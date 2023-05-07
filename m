Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547C06F988B
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 15:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjEGNIg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 09:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjEGNIg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 09:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234C311610
        for <stable@vger.kernel.org>; Sun,  7 May 2023 06:08:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9971960C64
        for <stable@vger.kernel.org>; Sun,  7 May 2023 13:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC15C433D2;
        Sun,  7 May 2023 13:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683464914;
        bh=8Yfs9qBmGTv7SlIxIPc0Ybzjv4tzQGaw9RIt3du9gQQ=;
        h=Subject:To:Cc:From:Date:From;
        b=sFFg5ogKiFBVAqYBFW8vvlmA4RjduVRfnppfc0q7s4Gm0uV+P8izc8wNRnH6ZCRX7
         bJw/jU5eI99vXi4FlQciDZ2YxYWBpXyLGQBd92lO8do4VCmuJKfWDwWwwrdncJiJti
         jqdbSKEI7uq+L2nj83vUq2CRjFuuUPF0A06dGqB0=
Subject: FAILED: patch "[PATCH] btrfs: set default discard iops_limit to 1000" failed to apply to 6.2-stable tree
To:     boris@bur.io, dsterba@suse.com, neal@gompa.dev
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 15:08:25 +0200
Message-ID: <2023050725-customary-casing-68ab@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x cfe3445a58658b2a142a9ba5f5de69d91c56a297
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050725-customary-casing-68ab@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

cfe3445a5865 ("btrfs: set default discard iops_limit to 1000")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cfe3445a58658b2a142a9ba5f5de69d91c56a297 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Wed, 5 Apr 2023 12:43:58 -0700
Subject: [PATCH] btrfs: set default discard iops_limit to 1000

Previously, the default was a relatively conservative 10. This results
in a 100ms delay, so with ~300 discards in a commit, it takes the full
30s till the next commit to finish the discards. On a workstation, this
results in the disk never going idle, wasting power/battery, etc.

Set the default to 1000, which results in using the smallest possible
delay, currently, which is 1ms. This has shown to not pathologically
keep the disk busy by the original reporter.

Link: https://lore.kernel.org/linux-btrfs/Y%2F+n1wS%2F4XAH7X1p@nz/
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2182228
CC: stable@vger.kernel.org # 6.2+
Reviewed-by: Neal Gompa <neal@gompa.dev
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 317aeff6c1da..0bc526f5fcd9 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -60,7 +60,7 @@
 #define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
 #define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
 #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
-#define BTRFS_DISCARD_MAX_IOPS		(10U)
+#define BTRFS_DISCARD_MAX_IOPS		(1000U)
 
 /* Monotonically decreasing minimum length filters after index 0 */
 static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {

