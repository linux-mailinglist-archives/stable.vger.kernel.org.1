Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B344C7ECC92
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjKOTbS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjKOTbR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B431A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FA2C433C9;
        Wed, 15 Nov 2023 19:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076673;
        bh=pPHr76ySGRU3x1Lf3CmimTeSHnL+oixnS0W3FADqG20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K70XjFU6sBAv5thulz2gbacld4G8U1QHea9vW9oGWC8ZkYn5NfpwbN5UWFRw2jHnr
         K65tDkOb14A00x6G1aQ0SgWHMztt+79pks43I+qJqJ+8p1NvBDvjDyrimRjabbU2iR
         MvuSCLt8FlBRl6HKnrmRbXzwS8u1T6hfjeNKKpG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Georgia Garcia <georgia.garcia@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 376/550] apparmor: fix invalid reference on profile->disconnected
Date:   Wed, 15 Nov 2023 14:16:00 -0500
Message-ID: <20231115191626.889656870@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Georgia Garcia <georgia.garcia@canonical.com>

[ Upstream commit 8884ba07786c718771cf7b78cb3024924b27ec2b ]

profile->disconnected was storing an invalid reference to the
disconnected path. Fix it by duplicating the string using
aa_unpack_strdup and freeing accordingly.

Fixes: 72c8a768641d ("apparmor: allow profiles to provide info to disconnected paths")
Signed-off-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/policy.c        | 1 +
 security/apparmor/policy_unpack.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index b38f7b2a5e1d5..ec695a6caac7d 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -255,6 +255,7 @@ void aa_free_profile(struct aa_profile *profile)
 
 	aa_put_ns(profile->ns);
 	kfree_sensitive(profile->rename);
+	kfree_sensitive(profile->disconnected);
 
 	free_attachment(&profile->attach);
 
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 694fb7a099624..74bcd0d79fb33 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -804,7 +804,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	const char *info = "failed to unpack profile";
 	size_t ns_len;
 	struct rhashtable_params params = { 0 };
-	char *key = NULL;
+	char *key = NULL, *disconnected = NULL;
 	struct aa_data *data;
 	int error = -EPROTO;
 	kernel_cap_t tmpcap;
@@ -870,7 +870,8 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	}
 
 	/* disconnected attachment string is optional */
-	(void) aa_unpack_str(e, &profile->disconnected, "disconnected");
+	(void) aa_unpack_strdup(e, &disconnected, "disconnected");
+	profile->disconnected = disconnected;
 
 	/* per profile debug flags (complain, audit) */
 	if (!aa_unpack_nameX(e, AA_STRUCT, "flags")) {
-- 
2.42.0



