Return-Path: <stable+bounces-133050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01104A91AE9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE8C19E55FA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D432236F6;
	Thu, 17 Apr 2025 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MaTldAzM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144811A2C0E
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889427; cv=none; b=Pnte29/HLmW0CcE4JSIe3Z0cQbL9OFFS9c4qkmW94h14NLIT4DjoFApiY+NP3d1j0DczEWFBDnIjOhfAQymp2BQqC1f7d24GEoYHWUorA8R8+4uA3sC7AO2UIvbcckGx6Iaz5/DkcUh8vm7IQr9WWZYZirnrf2C4EPg2Xk6bxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889427; c=relaxed/simple;
	bh=m8WtuWT77gmF+uutAISIFt4SQ6T82WaDryY1MSOTsfQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d/90CZi0bnU5NcRU2f41V+ZShyVXtoHYOPLrQtJ+f0+R3t2J6cqVMVl3tTGxUBCHmhtYt655bk8gkICb1Dj2AnQUleTqStN6s2cnTyNj1pVvglDcTDupsgZgxzDPCC66DPR/fnjM0T9IM99wfRUhtjzwkx99YGkxkGrYr3WOfdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MaTldAzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88736C4CEF1;
	Thu, 17 Apr 2025 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889426;
	bh=m8WtuWT77gmF+uutAISIFt4SQ6T82WaDryY1MSOTsfQ=;
	h=Subject:To:Cc:From:Date:From;
	b=MaTldAzMyLC8TGTD2Rik4C75/fCF6xEtN46VosTVZQXZ5qtoXTFu2riwgDMtLtdIu
	 5usZlmDtPLPJy6BwIU2asCgmTxwCQL7iG9RXhgjGOtyKUXt21o7X7smQD11rNVY7qi
	 bUkhOh+wa18WgudJlwHNlZBngg35snTSfdaKPB1I=
Subject: FAILED: patch "[PATCH] btrfs: zoned: fix zone finishing with missing devices" failed to apply to 6.1-stable tree
To: johannes.thumshirn@wdc.com,anand.jain@oracle.com,dsterba@suse.com,naohiro.aota@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:25:33 +0200
Message-ID: <2025041732-purgatory-either-8bfc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 35fec1089ebb5617f85884d3fa6a699ce6337a75
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041732-purgatory-either-8bfc@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 35fec1089ebb5617f85884d3fa6a699ce6337a75 Mon Sep 17 00:00:00 2001
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Mon, 17 Mar 2025 12:24:59 +0100
Subject: [PATCH] btrfs: zoned: fix zone finishing with missing devices

If do_zone_finish() is called with a filesystem that has missing devices
(e.g. a RAID file system mounted in degraded mode) it is accessing the
btrfs_device::zone_info pointer, which will not be set if the device
in question is missing.

Check if the device is present (by checking if it has a valid block device
pointer associated) and if not, skip zone finishing for it.

Fixes: 4dcbb8ab31c1 ("btrfs: zoned: make zone finishing multi stripe capable")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9faf1e097196..fb8b8b29c169 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2275,6 +2275,9 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 		unsigned int nofs_flags;
 
+		if (!device->bdev)
+			continue;
+
 		if (zinfo->max_active_zones == 0)
 			continue;
 


