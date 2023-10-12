Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5C7C759D
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379684AbjJLSDE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379592AbjJLSDE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 14:03:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D71B8
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 11:03:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD77C433C8;
        Thu, 12 Oct 2023 18:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697133781;
        bh=ciQtzYtPDKPG9K6HWMvXjs/tX3UmwEb5nAHdvfzzfPk=;
        h=Subject:To:Cc:From:Date:From;
        b=upnpYLd+BH3LfMj3NWuVWeK/5OEAEWbzGAMAuEsOxWhJ483OQDUzgct2VhKaJND1r
         ZNn2SZYUu+Ji3PiUwXw6GO2OYQcJlAE9l6PSUzOLgm1m5HW3FdsZj0lTVS2QoPuOlW
         0ZjeNxPCMk1qtqZT6zOpmUMp+FYNtzDdAZaTW0qM=
Subject: FAILED: patch "[PATCH] KEYS: trusted: Remove redundant static calls usage" failed to apply to 5.15-stable tree
To:     sumit.garg@linaro.org, 42.hyeyoo@gmail.com,
        torvalds@linux-foundation.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Thu, 12 Oct 2023 20:02:58 +0200
Message-ID: <2023101258-map-demanding-68a7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 01bbafc63b65689cb179ca537971286bc27f3b74
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023101258-map-demanding-68a7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

01bbafc63b65 ("KEYS: trusted: Remove redundant static calls usage")
fcd7c26901c8 ("KEYS: trusted: allow use of kernel RNG for key material")
c5d1ed846e15 ("KEYS: trusted: Avoid calling null function trusted_key_exit")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01bbafc63b65689cb179ca537971286bc27f3b74 Mon Sep 17 00:00:00 2001
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 6 Oct 2023 10:48:01 +0530
Subject: [PATCH] KEYS: trusted: Remove redundant static calls usage

Static calls invocations aren't well supported from module __init and
__exit functions. Especially the static call from cleanup_trusted() led
to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=y.

However, the usage of static call invocations for trusted_key_init()
and trusted_key_exit() don't add any value from either a performance or
security perspective. Hence switch to use indirect function calls instead.

Note here that although it will fix the current crash report, ultimately
the static call infrastructure should be fixed to either support its
future usage from module __init and __exit functions or not.

Reported-and-tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Link: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t
Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index c6fc50d67214..85fb5c22529a 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -44,13 +44,12 @@ static const struct trusted_key_source trusted_key_sources[] = {
 #endif
 };
 
-DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0].ops->init);
 DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sources[0].ops->seal);
 DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
 			*trusted_key_sources[0].ops->unseal);
 DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
 			*trusted_key_sources[0].ops->get_random);
-DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0].ops->exit);
+static void (*trusted_key_exit)(void);
 static unsigned char migratable;
 
 enum {
@@ -359,19 +358,16 @@ static int __init init_trusted(void)
 		if (!get_random)
 			get_random = kernel_get_random;
 
-		static_call_update(trusted_key_init,
-				   trusted_key_sources[i].ops->init);
 		static_call_update(trusted_key_seal,
 				   trusted_key_sources[i].ops->seal);
 		static_call_update(trusted_key_unseal,
 				   trusted_key_sources[i].ops->unseal);
 		static_call_update(trusted_key_get_random,
 				   get_random);
-		static_call_update(trusted_key_exit,
-				   trusted_key_sources[i].ops->exit);
+		trusted_key_exit = trusted_key_sources[i].ops->exit;
 		migratable = trusted_key_sources[i].ops->migratable;
 
-		ret = static_call(trusted_key_init)();
+		ret = trusted_key_sources[i].ops->init();
 		if (!ret)
 			break;
 	}
@@ -388,7 +384,8 @@ static int __init init_trusted(void)
 
 static void __exit cleanup_trusted(void)
 {
-	static_call_cond(trusted_key_exit)();
+	if (trusted_key_exit)
+		(*trusted_key_exit)();
 }
 
 late_initcall(init_trusted);

