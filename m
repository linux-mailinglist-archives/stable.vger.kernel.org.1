Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496F37ED118
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344056AbjKOT7c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344030AbjKOT71 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:59:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B01A5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:59:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFF8C433CA;
        Wed, 15 Nov 2023 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078362;
        bh=4q/mKnusCY8woNu1q286Db7ABLkMbM8vl4FHY8iKFBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYTFdK3l1f/e0fJYZGojlljdcrpxMwntwqJ23lPDVLuB0eB1C2FKjXEhkdm9BAhQf
         ydpEfWQV46IAT/hG5VweIxecQTfCbkGvQdxaYORGr17hhHbL7cPVHR0glPZ08BI0w5
         YpwqAbqNxJJ4APb0OHuTM2v0aNYX/zOGPne+MU9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Georgia Garcia <georgia.garcia@canonical.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 252/379] apparmor: fix invalid reference on profile->disconnected
Date:   Wed, 15 Nov 2023 14:25:27 -0500
Message-ID: <20231115192700.048724908@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index fbdfcef91c616..c7b84fb568414 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -218,6 +218,7 @@ void aa_free_profile(struct aa_profile *profile)
 
 	aa_put_ns(profile->ns);
 	kfree_sensitive(profile->rename);
+	kfree_sensitive(profile->disconnected);
 
 	aa_free_file_rules(&profile->file);
 	aa_free_cap_rules(&profile->caps);
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index fbddf6450195d..7012fd82f1bb1 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -656,7 +656,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	const char *info = "failed to unpack profile";
 	size_t ns_len;
 	struct rhashtable_params params = { 0 };
-	char *key = NULL;
+	char *key = NULL, *disconnected = NULL;
 	struct aa_data *data;
 	int i, error = -EPROTO;
 	kernel_cap_t tmpcap;
@@ -710,7 +710,8 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	}
 
 	/* disconnected attachment string is optional */
-	(void) aa_unpack_str(e, &profile->disconnected, "disconnected");
+	(void) aa_unpack_strdup(e, &disconnected, "disconnected");
+	profile->disconnected = disconnected;
 
 	/* per profile debug flags (complain, audit) */
 	if (!aa_unpack_nameX(e, AA_STRUCT, "flags")) {
-- 
2.42.0



