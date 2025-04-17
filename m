Return-Path: <stable+bounces-133049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B26A91AEA
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB2516F91E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5B223BD0A;
	Thu, 17 Apr 2025 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hc8D1him"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25B1A2C0E
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889424; cv=none; b=SZtz8wlF2hMYssplOY9yKNBhop80+ltf/YlVjJ8yTWpmoB5CLd5tureGudZRy20ILKxUonvmP5MiQT28By2alGErFKWMBnY/WDdqsYUFPZTv9fger0mdYrZh0zFPOKsnitDA40DnRXwRsrC7zl3wRkXg5msjLkZUn7Qx/7gc+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889424; c=relaxed/simple;
	bh=SwLpi+PChaednh83IoV57MffqYtg3Gcay462g8NKpJA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NT9zaMNkFR7ppg8TiW+lj8tHtC1zkWebAwaOwaIy6wiZUOdgsBRUFQI4oEjc4ZRGvG2hH3bwQW4cKKj4g3aVtJzaBlUjUs8VQnZKPcmMzyNKmRV9MIynsHeLbrYMKYWpFxExygedxOax66OEiTwaLT9JRXIoOBMixhDEoh449aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hc8D1him; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781EBC4CEE4;
	Thu, 17 Apr 2025 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744889423;
	bh=SwLpi+PChaednh83IoV57MffqYtg3Gcay462g8NKpJA=;
	h=Subject:To:Cc:From:Date:From;
	b=Hc8D1himJWg9xAub1zyFQN0Ei98NSELHoT+s9tIO/mnTKrFbJC60h56O5OPX/AQGS
	 2PKsgv91QpV8hU572LmfPFTPHt43jptNhI3MYnIUQvUdI9cnrwyyJqartqLQ6SEtp7
	 1tTQgC+uAFrD/UvYym+B0C8rSvEC46YWbYkKMVao=
Subject: FAILED: patch "[PATCH] btrfs: zoned: fix zone activation with missing devices" failed to apply to 6.1-stable tree
To: johannes.thumshirn@wdc.com,anand.jain@oracle.com,dsterba@suse.com,naohiro.aota@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 13:25:07 +0200
Message-ID: <2025041707-saline-acts-ee63@gregkh>
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
git cherry-pick -x 2bbc4a45e5eb6b868357c1045bf6f38f6ba576e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041707-saline-acts-ee63@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2bbc4a45e5eb6b868357c1045bf6f38f6ba576e0 Mon Sep 17 00:00:00 2001
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Mon, 17 Mar 2025 12:24:58 +0100
Subject: [PATCH] btrfs: zoned: fix zone activation with missing devices

If btrfs_zone_activate() is called with a filesystem that has missing
devices (e.g. a RAID file system mounted in degraded mode) it is accessing
the btrfs_device::zone_info pointer, which will not be set if the device in
question is missing.

Check if the device is present (by checking if it has a valid block
device pointer associated) and if not, skip zone activation for it.

Fixes: f9a912a3c45f ("btrfs: zoned: make zone activation multi stripe capable")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4956baf8220a..9faf1e097196 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2111,6 +2111,9 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		physical = map->stripes[i].physical;
 		zinfo = device->zone_info;
 
+		if (!device->bdev)
+			continue;
+
 		if (zinfo->max_active_zones == 0)
 			continue;
 


