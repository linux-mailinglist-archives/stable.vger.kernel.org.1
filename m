Return-Path: <stable+bounces-136339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA8DA99357
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A721BC1627
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F7284B42;
	Wed, 23 Apr 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PT9ZEbbt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1319279345;
	Wed, 23 Apr 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422286; cv=none; b=MPQJPPdmbGfetWk9dlD5JLZ3f63hahlnptjDxFKoYua40C+N6rmXNc2HEbriywJKbddqqCftlQCgU4uZOUO13/s/PBydDGUUBk1ncIoXe/GkETGs7iFJjk6sdNEYTzEEp1rF+67HI51Sk3FdPyj9IxL8V6jbgNZfhvoAXkNkQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422286; c=relaxed/simple;
	bh=m+R5BSm65sBPq3ue3Ykt5l/jHRVU/AaqGpT1wwxAw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trRVMmv5lH4TUXPFN8xM2cl8FvjKXpjE7n/M0H9h8pHFWB1c6pZeP+DAK0R9+xq/ejtmkOe8FM4IWUeN77oPRZ5YS1bB1QPLkSulB87eTI7+e7mSGoRMb6rWfE0h14WEij7lisnZCgnUbUwAR/TheOjJfxcuuSopu+Da88TKJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PT9ZEbbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73F3FC4CEE3;
	Wed, 23 Apr 2025 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422285;
	bh=m+R5BSm65sBPq3ue3Ykt5l/jHRVU/AaqGpT1wwxAw8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PT9ZEbbtnGLTFwl0KiGY94KTTyLl/nUrUznO/4tBS10ownTJ8g8pdbvUPyU/XOr00
	 Aoagc+UCYHZFDVAmCk4zIOtHcUEJybt+FGFLY0PIuk0BfUIS/Q7FDtHRiJf3K0ca1K
	 YQZSKGY8tp8poTiY57hrBDxO6cCXh7hkNj3uWQ3w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 270/291] btrfs: zoned: fix zone activation with missing devices
Date: Wed, 23 Apr 2025 16:44:19 +0200
Message-ID: <20250423142635.453284962@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
References: <20250423142624.409452181@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit 2bbc4a45e5eb6b868357c1045bf6f38f6ba576e0 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1909,6 +1909,9 @@ bool btrfs_zone_activate(struct btrfs_bl
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
 
+		if (!device->bdev)
+			continue;
+
 		if (device->zone_info->max_active_zones == 0)
 			continue;
 



