Return-Path: <stable+bounces-133565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E73A92633
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81FF94A0042
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753922561DA;
	Thu, 17 Apr 2025 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2EtYD/ri"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FCD1A3178;
	Thu, 17 Apr 2025 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913461; cv=none; b=q68xTnsahuJIsU6lKvmCDBhthxg7k1sSQ31KIjvtKtu8DC4Nie8LIdKkYJvOxvZOwG3NV/MT9ie0+9zHQ7vSepAmQUXegt+QBDcOj4ZP/uocxMyKbtP7PXT67L0pl1LDpnskIrSNMu3W/VyiuWwTnsW+GcqUhnYlu0ql8EVjCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913461; c=relaxed/simple;
	bh=j03R4Zmf8B+fx8EzqKIehdVHh6SQuTCT3il8w74fk0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muuelEohQ3B478NEOkniV5F2+MmB8Y54joOGEUsuvk6NvW7kWI4S+T+B4jty/JGV8UX7hzl1WW9EOgtpsm1yWbiqOcSklxEJDGPPeLW47vTmOtIPUyNUE4H/bqmtLlYWOdwO7zSHIFGWNKvUZw23LaTz0DtN+Z6/0EpgAsEueVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2EtYD/ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAA4C4CEE4;
	Thu, 17 Apr 2025 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913460;
	bh=j03R4Zmf8B+fx8EzqKIehdVHh6SQuTCT3il8w74fk0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2EtYD/ril9tpl3pfLGUXyWVybjhf+o07kjEKe9MeJgKq9pCg0Lc92XK+QA2X2QIJv
	 zkIS7L2wfw7zaxhWK45zJUY4XalzZjVDttB+Dv6/PKbw6wlEgzax6bVOUOEGk/h0+R
	 W6hct1tyfYfsrEmXWoH0lc0X7619b3+zwmOZNMj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Anand Jain <anand.jain@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.14 346/449] btrfs: zoned: fix zone finishing with missing devices
Date: Thu, 17 Apr 2025 19:50:34 +0200
Message-ID: <20250417175132.146080161@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

commit 35fec1089ebb5617f85884d3fa6a699ce6337a75 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/zoned.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2275,6 +2275,9 @@ static int do_zone_finish(struct btrfs_b
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
 		unsigned int nofs_flags;
 
+		if (!device->bdev)
+			continue;
+
 		if (zinfo->max_active_zones == 0)
 			continue;
 



