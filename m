Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F067A7C84
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjITMCD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjITMCC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:02:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E084EC
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:01:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0377C433C7;
        Wed, 20 Sep 2023 12:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211315;
        bh=SAagg+A1mPigzlB9iqCy3MzZMzbcPOHJ3LAKbD+/j4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLBItouEEm1PwdNZCyVDcqkHtwuJeqrIXATQNmitf6x0bu/JQWmMSffKPD/u8GJt5
         RDFc3AsO3g2nvr8fpvWIRwrB7iEwdeGcX6n79wsM87UukQllwteF/GbwdUwI+0YiFR
         qEQjH6rTaagx2avwfFGsdVcaIAWoCNAMehebWR7w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 021/186] security: keys: perform capable check only on privileged operations
Date:   Wed, 20 Sep 2023 13:28:44 +0200
Message-ID: <20230920112837.650617381@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 2d7f105edbb3b2be5ffa4d833abbf9b6965e9ce7 ]

If the current task fails the check for the queried capability via
`capable(CAP_SYS_ADMIN)` LSMs like SELinux generate a denial message.
Issuing such denial messages unnecessarily can lead to a policy author
granting more privileges to a subject than needed to silence them.

Reorder CAP_SYS_ADMIN checks after the check whether the operation is
actually privileged.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/keyctl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 9394d72a77e80..9e52a3e0fc672 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -922,14 +922,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 	ret = -EACCES;
 	down_write(&key->sem);
 
-	if (!capable(CAP_SYS_ADMIN)) {
+	{
+		bool is_privileged_op = false;
+
 		/* only the sysadmin can chown a key to some other UID */
 		if (user != (uid_t) -1 && !uid_eq(key->uid, uid))
-			goto error_put;
+			is_privileged_op = true;
 
 		/* only the sysadmin can set the key's GID to a group other
 		 * than one of those that the current process subscribes to */
 		if (group != (gid_t) -1 && !gid_eq(gid, key->gid) && !in_group_p(gid))
+			is_privileged_op = true;
+
+		if (is_privileged_op && !capable(CAP_SYS_ADMIN))
 			goto error_put;
 	}
 
@@ -1029,7 +1034,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	down_write(&key->sem);
 
 	/* if we're not the sysadmin, we can only change a key that we own */
-	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
+	if (uid_eq(key->uid, current_fsuid()) || capable(CAP_SYS_ADMIN)) {
 		key->perm = perm;
 		ret = 0;
 	}
-- 
2.40.1



