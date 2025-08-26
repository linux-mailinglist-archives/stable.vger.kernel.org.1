Return-Path: <stable+bounces-174040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BEAB360F6
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29552A2448
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46C91C4A2D;
	Tue, 26 Aug 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XgGwIlOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED0FBF0;
	Tue, 26 Aug 2025 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213333; cv=none; b=E64vR25w+TAs9beFY14iLgwwVwGVHolyicGUM7oV2sSM/HxmffWMWK8Ea8WzW52ArPwrFPi8Gpy96Tov6CDeejnRvdlpt53cPDr7tdbPXhTGDNzNF6aeIqC6rJZyRv9PaAVbsO+zfRX25XwbyTPY7OiAA4LuttcXWN/q/p5CbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213333; c=relaxed/simple;
	bh=gXGK+TpaPHnwBD7xPyoN2yJpydheS0Mu4gPFRwV2JLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOp1N7NGviGN8uM74pAVszHEK5wiqgfg/pNbgloW+5uym89R/2XRsVv/ejzfSVgMTNAb64EcS2C8toRf5sOZCQaYX8dBXFgOfq6hRY44odncC1awV5Dj7InsXknjP6rMD9Sq0f+RLvMp/Th1jw4vPzKF6Ryrpcl+Tl8AxjhEE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XgGwIlOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EDAC4CEF1;
	Tue, 26 Aug 2025 13:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213333;
	bh=gXGK+TpaPHnwBD7xPyoN2yJpydheS0Mu4gPFRwV2JLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XgGwIlOUSBUHDJib4M2qwL+yQYWvfE5r1k028tbkPaihfRg2vqE9WgLVC6t4EHL36
	 X6lMa9CJAGoOSkMKYsPgKegcIlcwCTj+oALUgZ33e+E5hbNetB/a7qvsmkYxByk3H9
	 KWZeNFBrvyk+OfcGPhppF5/MKwGYoJ4ZaIUiyh+A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 309/587] btrfs: zoned: use filesystem size not disk size for reclaim decision
Date: Tue, 26 Aug 2025 13:07:38 +0200
Message-ID: <20250826111000.780053243@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit 55f7c65b2f69c7e4cb7aa7c1654a228ccf734fd8 upstream.

When deciding if a zoned filesystem is reaching the threshold to reclaim
data block groups, look at the size of the filesystem not to potentially
total available size of all drives in the filesystem.

Especially if a filesystem was created with mkfs' -b option, constraining
it to only a portion of the block device, the numbers won't match and
potentially garbage collection is kicking in too late.

Fixes: 3687fcb0752a ("btrfs: zoned: make auto-reclaim less aggressive")
CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2350,8 +2350,8 @@ bool btrfs_zoned_should_reclaim(struct b
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
+	u64 total = btrfs_super_total_bytes(fs_info->super_copy);
 	u64 used = 0;
-	u64 total = 0;
 	u64 factor;
 
 	ASSERT(btrfs_is_zoned(fs_info));
@@ -2364,7 +2364,6 @@ bool btrfs_zoned_should_reclaim(struct b
 		if (!device->bdev)
 			continue;
 
-		total += device->disk_total_bytes;
 		used += device->bytes_used;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);



