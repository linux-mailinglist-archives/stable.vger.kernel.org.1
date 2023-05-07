Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8276F988C
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEGNIj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 09:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEGNIi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 09:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B052E5BBE
        for <stable@vger.kernel.org>; Sun,  7 May 2023 06:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44D6C60B37
        for <stable@vger.kernel.org>; Sun,  7 May 2023 13:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A71C433D2;
        Sun,  7 May 2023 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683464916;
        bh=GD9StOygfndZOaofttMgb8drEwr7MrUxGJ+oTxP+Mk0=;
        h=Subject:To:Cc:From:Date:From;
        b=wvou1Q1BV7NSM9ykIu0xkFVUtGfU+WVtUG894K+yDaX2No9+eYvmkK7V3jyvdy/3c
         KOEjdq95M8CJHUL3N4iwoss5Lu0PilABGI6Y5ldGSKWwDZQ4xuAm6nd81M0/jJjt8F
         IKu5MKiVmsweCAPEalCc1pWDr4HbYPBImQkya6/I=
Subject: FAILED: patch "[PATCH] btrfs: reinterpret async discard iops_limit=0 as no delay" failed to apply to 6.2-stable tree
To:     boris@bur.io, dsterba@suse.com, neal@gompa.dev
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 15:08:31 +0200
Message-ID: <2023050731-defensive-scariness-cea7@gregkh>
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
git cherry-pick -x f263a7c3a53b99f691b41e4925feb67f2e8544d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050731-defensive-scariness-cea7@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

f263a7c3a53b ("btrfs: reinterpret async discard iops_limit=0 as no delay")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f263a7c3a53b99f691b41e4925feb67f2e8544d0 Mon Sep 17 00:00:00 2001
From: Boris Burkov <boris@bur.io>
Date: Wed, 5 Apr 2023 12:43:59 -0700
Subject: [PATCH] btrfs: reinterpret async discard iops_limit=0 as no delay

Currently, a limit of 0 results in a hard coded metering over 6 hours.
Since the default is a set limit, I suspect no one truly depends on this
rather arbitrary setting. Repurpose it for an arguably more useful
"unlimited" mode, where the delay is 0.

Note that if block groups are too new, or go fully empty, there is still
a delay associated with those conditions. Those delays implement
heuristics for not trimming a region we are relatively likely to fully
overwrite soon.

CC: stable@vger.kernel.org # 6.2+
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 0bc526f5fcd9..a6d77fe41e1a 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -56,8 +56,6 @@
 #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
 #define BTRFS_DISCARD_UNUSED_DELAY	(10ULL * NSEC_PER_SEC)
 
-/* Target completion latency of discarding all discardable extents */
-#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
 #define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
 #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
 #define BTRFS_DISCARD_MAX_IOPS		(1000U)
@@ -577,6 +575,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 	s32 discardable_extents;
 	s64 discardable_bytes;
 	u32 iops_limit;
+	unsigned long min_delay = BTRFS_DISCARD_MIN_DELAY_MSEC;
 	unsigned long delay;
 
 	discardable_extents = atomic_read(&discard_ctl->discardable_extents);
@@ -607,13 +606,19 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 	}
 
 	iops_limit = READ_ONCE(discard_ctl->iops_limit);
-	if (iops_limit)
+
+	if (iops_limit) {
 		delay = MSEC_PER_SEC / iops_limit;
-	else
-		delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
+	} else {
+		/*
+		 * Unset iops_limit means go as fast as possible, so allow a
+		 * delay of 0.
+		 */
+		delay = 0;
+		min_delay = 0;
+	}
 
-	delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
-		      BTRFS_DISCARD_MAX_DELAY_MSEC);
+	delay = clamp(delay, min_delay, BTRFS_DISCARD_MAX_DELAY_MSEC);
 	discard_ctl->delay_ms = delay;
 
 	spin_unlock(&discard_ctl->lock);

