Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38897A379A
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbjIQTWj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbjIQTWM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:22:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4419C132
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:22:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77147C433CC;
        Sun, 17 Sep 2023 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978524;
        bh=8tLpuBMB/G+U1xiarnc5WkRxQmFOzxC3uIteveDaKXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDItgZaWpkeKZtUi8L/XC/LmnklBmbkCXTqwKT0mK1HSUqIvXoJeFWThLKM1D2Km6
         8WOrIAoikZtn2Pj6pv+6z7vkrrN6c0BxANy5W/QNlGYlMsArr8hTIbYuyBFb9HiijC
         T9LoL+RS6UpxtANawTHAtxAPBojrjoUGVk+R4UjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 047/406] security: keys: perform capable check only on privileged operations
Date:   Sun, 17 Sep 2023 21:08:21 +0200
Message-ID: <20230917191102.387988861@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 61a614c21b9b6..e3ffaf5ad6394 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -980,14 +980,19 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
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
 
@@ -1088,7 +1093,7 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 	down_write(&key->sem);
 
 	/* if we're not the sysadmin, we can only change a key that we own */
-	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
+	if (uid_eq(key->uid, current_fsuid()) || capable(CAP_SYS_ADMIN)) {
 		key->perm = perm;
 		notify_key(key, NOTIFY_KEY_SETATTR, 0);
 		ret = 0;
-- 
2.40.1



