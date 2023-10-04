Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76E77B8313
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbjJDO7s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 10:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbjJDO7q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 10:59:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58B9B
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 07:59:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E706C433C8;
        Wed,  4 Oct 2023 14:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696431582;
        bh=T4Ut/Y8GDTU52HjuJ6iBAmaE3ZIJk4Q+DUhkxtzp5h4=;
        h=Subject:To:Cc:From:Date:From;
        b=I3j+Iq2CS5y/4EJKIKkS6eznhISW7GC6Y1uMfNy02HFQ2YgCZqOwMUasYaVdR76lk
         NPL8y63ZXVdQZlp3DWu+9YIeJ8r6B0vRCtu2cRuSy5iviR0D9TlQnJPzbE1A+ul/sH
         eZNotuuvGJGQGAdV7pHKv2k2kPViqQ/Br7XMljLc=
Subject: FAILED: patch "[PATCH] maple_tree: add mas_is_active() to detect in-tree walks" failed to apply to 6.5-stable tree
To:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        pedro.falcato@gmail.com, stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Wed, 04 Oct 2023 16:59:40 +0200
Message-ID: <2023100439-obtuse-unchain-b580@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 5c590804b6b0ff933ed4e5cee5d76de3a5048d9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023100439-obtuse-unchain-b580@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c590804b6b0ff933ed4e5cee5d76de3a5048d9f Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Thu, 21 Sep 2023 14:12:35 -0400
Subject: [PATCH] maple_tree: add mas_is_active() to detect in-tree walks

Patch series "maple_tree: Fix mas_prev() state regression".

Pedro Falcato retported an mprotect regression [1] which was bisected back
to the iterator changes for maple tree.  Root cause analysis showed the
mas_prev() running off the end of the VMA space (previous from 0) followed
by mas_find(), would skip the first value.

This patchset introduces maple state underflow/overflow so the sequence of
calls on the maple state will return what the user expects.

Users who encounter this bug may see mprotect(), userfaultfd_register(),
and mlock() fail on VMAs mapped with address 0.


This patch (of 2):

Instead of constantly checking each possibility of the maple state,
create a fast path that will skip over checking unlikely states.

Link: https://lkml.kernel.org/r/20230921181236.509072-1-Liam.Howlett@oracle.com
Link: https://lkml.kernel.org/r/20230921181236.509072-2-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e41c70ac7744..f66f5f78f8cf 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -511,6 +511,15 @@ static inline bool mas_is_paused(const struct ma_state *mas)
 	return mas->node == MAS_PAUSE;
 }
 
+/* Check if the mas is pointing to a node or not */
+static inline bool mas_is_active(struct ma_state *mas)
+{
+	if ((unsigned long)mas->node >= MAPLE_RESERVED_RANGE)
+		return true;
+
+	return false;
+}
+
 /**
  * mas_reset() - Reset a Maple Tree operation state.
  * @mas: Maple Tree operation state.

