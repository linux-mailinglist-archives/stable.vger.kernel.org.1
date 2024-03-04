Return-Path: <stable+bounces-26328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5964870E15
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E381C2397A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF07BAED;
	Mon,  4 Mar 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="afL8TxbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05DE61675;
	Mon,  4 Mar 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588437; cv=none; b=eb0Y1z8a8DovZYJ2xzP0pEGN8x3oa+HCTeve96aE+W46dDwYCaIj3mBkZDsEVTLSTIB7HKG5NSl50hK7hM4LEodk0rTkCDbh51R1/KxU4g20PWdvgnIviGC3ZBEiVMVuee3EHGUkv1kRfg4EYOM+urS6JPdpHsgaJne55OqadXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588437; c=relaxed/simple;
	bh=IeXHTO6fViGYuLt55sSkSfkVmDeoW+ok0dx+7mpOqfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWjF96QL2P8tqRhBRjTIE8p4FFKujQHKxJnnwYQsbbfYgUzFGfEBwtHAU+CkMwl+kUKyrdf5Z6n5GRITqOUP6hGuIKHHf6kW2q8eK/knjywX4lW+x6zS0+SIqhTUq8Dmbh3oqVqrYMS/J9Id6fBzDvOM3wcMcYy4t16nv89FoyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=afL8TxbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9FBC433C7;
	Mon,  4 Mar 2024 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588436;
	bh=IeXHTO6fViGYuLt55sSkSfkVmDeoW+ok0dx+7mpOqfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afL8TxbN4qPxHFkpbwoHTVcF0b8IgXlNiYZDwxKwA7S50F7dC+uqqPO2q1W9A4L+v
	 RRslIyI4S85i4eVv+VIJN+41qzSjGfKbc3gDP439qHL6UbK1ueAGhMGKer4QSqHnXS
	 jzJqYLIdZKib4s7Zb4bkZooHMLvWz7vHlFm9siKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Subject: [PATCH 6.6 082/143] btrfs: dev-replace: properly validate device names
Date: Mon,  4 Mar 2024 21:23:22 +0000
Message-ID: <20240304211552.547334727@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211549.876981797@linuxfoundation.org>
References: <20240304211549.876981797@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: David Sterba <dsterba@suse.com>

commit 9845664b9ee47ce7ee7ea93caf47d39a9d4552c4 upstream.

There's a syzbot report that device name buffers passed to device
replace are not properly checked for string termination which could lead
to a read out of bounds in getname_kernel().

Add a helper that validates both source and target device name buffers.
For devid as the source initialize the buffer to empty string in case
something tries to read it later.

This was originally analyzed and fixed in a different way by Edward Adam
Davis (see links).

Link: https://lore.kernel.org/linux-btrfs/000000000000d1a1d1060cc9c5e7@google.com/
Link: https://lore.kernel.org/linux-btrfs/tencent_44CA0665C9836EF9EEC80CB9E7E206DF5206@qq.com/
CC: stable@vger.kernel.org # 4.19+
CC: Edward Adam Davis <eadavis@qq.com>
Reported-and-tested-by: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/dev-replace.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -726,6 +726,23 @@ leave:
 	return ret;
 }
 
+static int btrfs_check_replace_dev_names(struct btrfs_ioctl_dev_replace_args *args)
+{
+	if (args->start.srcdevid == 0) {
+		if (memchr(args->start.srcdev_name, 0,
+			   sizeof(args->start.srcdev_name)) == NULL)
+			return -ENAMETOOLONG;
+	} else {
+		args->start.srcdev_name[0] = 0;
+	}
+
+	if (memchr(args->start.tgtdev_name, 0,
+		   sizeof(args->start.tgtdev_name)) == NULL)
+	    return -ENAMETOOLONG;
+
+	return 0;
+}
+
 int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 			    struct btrfs_ioctl_dev_replace_args *args)
 {
@@ -738,10 +755,9 @@ int btrfs_dev_replace_by_ioctl(struct bt
 	default:
 		return -EINVAL;
 	}
-
-	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
-		return -EINVAL;
+	ret = btrfs_check_replace_dev_names(args);
+	if (ret < 0)
+		return ret;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
 					args->start.srcdevid,



