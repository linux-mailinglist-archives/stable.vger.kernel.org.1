Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3766F96CE
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 06:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjEGEJU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 00:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEGEJQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 00:09:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E54E6E93
        for <stable@vger.kernel.org>; Sat,  6 May 2023 21:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A954D614EA
        for <stable@vger.kernel.org>; Sun,  7 May 2023 04:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4EAC433D2;
        Sun,  7 May 2023 04:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683432555;
        bh=TuPwhsg69226y5Wb3zaofI493lhuqaR0Lsf5dX6yJ6I=;
        h=Subject:To:Cc:From:Date:From;
        b=uNBiNt23HR2Wu+xbPfQL1zn9ZMVrJmiSymRjyCoEIA/JV+MN++twsSu2eTmSVHrCz
         /tk4d71UmJL7aXUhT5FDaAvW+iN87+oK1HE5OcsDMYqfOUy3LBPBSj5P/kV0jbB5Cq
         TWT0yddw55qAAlZ9q/vMR4md4SwQrdOv1AnFAyd8=
Subject: FAILED: patch "[PATCH] crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a" failed to apply to 5.4-stable tree
To:     toke@redhat.com, herbert@gondor.apana.org.au
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 06:09:04 +0200
Message-ID: <2023050704-colonist-pusher-4edb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a543ada7db729514ddd3ba4efa45f4c7b802ad85
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050704-colonist-pusher-4edb@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

a543ada7db72 ("crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a WARN_ON()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a543ada7db729514ddd3ba4efa45f4c7b802ad85 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 13 Mar 2023 10:17:24 +0100
Subject: [PATCH] crypto: api - Demote BUG_ON() in crypto_unregister_alg() to a
 WARN_ON()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The crypto_unregister_alg() function expects callers to ensure that any
algorithm that is unregistered has a refcnt of exactly 1, and issues a
BUG_ON() if this is not the case. However, there are in fact drivers that
will call crypto_unregister_alg() without ensuring that the refcnt has been
lowered first, most notably on system shutdown. This causes the BUG_ON() to
trigger, which prevents a clean shutdown and hangs the system.

To avoid such hangs on shutdown, demote the BUG_ON() in
crypto_unregister_alg() to a WARN_ON() with early return. Cc stable because
this problem was observed on a 6.2 kernel, cf the link below.

Link: https://lore.kernel.org/r/87r0tyq8ph.fsf@toke.dk
Cc: stable@vger.kernel.org
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 9b7e263ed469..d7eb8f9e9883 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -491,7 +491,9 @@ void crypto_unregister_alg(struct crypto_alg *alg)
 	if (WARN(ret, "Algorithm %s is not registered", alg->cra_driver_name))
 		return;
 
-	BUG_ON(refcount_read(&alg->cra_refcnt) != 1);
+	if (WARN_ON(refcount_read(&alg->cra_refcnt) != 1))
+		return;
+
 	if (alg->cra_destroy)
 		alg->cra_destroy(alg);
 

