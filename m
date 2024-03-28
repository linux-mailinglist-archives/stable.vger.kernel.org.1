Return-Path: <stable+bounces-25984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240A3870C73
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAC7287964
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924391EB5A;
	Mon,  4 Mar 2024 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UCW/EaCF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5291EA99;
	Mon,  4 Mar 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587542; cv=none; b=ZZPOcooJ/ZfKP3l9BSMnhEKMnLWbGyOWeSJZr4Bsky9SxIdCxmw6m9BrMLU0n8yFRNnuxyJ4mZrdFU++c75AiHOLcKxVpmh00gAd1jNYRXoqQcpyMY19JbBLSGKCWdUF/6GL6H+KxnNo853EkkYOr1u9dfkD5K1GKdngoyX+Zcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587542; c=relaxed/simple;
	bh=1OkbSB/U2ivPweYXR4a4BV2enMeC52y1WdWRnJ8I14g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAYXb3vJjVR598KaryxKqdFjN9nZbS6D6sIwzNyPSnuVXbg/3RR4Ku3TrwhgsARKixWUwzU9QClHt/d/ApSR+GG61vtJsDf0hsnO7P0RIVBbyp/Qe2hGrbl0iugzb7K7T5va5ZCCn9rsX+fGpWI94+xAlWtc07Ls3atc+ufzraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UCW/EaCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72819C433C7;
	Mon,  4 Mar 2024 21:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709587541;
	bh=1OkbSB/U2ivPweYXR4a4BV2enMeC52y1WdWRnJ8I14g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCW/EaCF+IWN5CCLjF8+oXeIVSylBhWz3/CdKBGVhTI2323G1ghKAzDnZJoH/Etet
	 Y0nq03WcE6KBsp9B0MBYioKATlITedPHMyfV5eat+sd6tZ8idJp7aB3N5nNlTaqCVp
	 R14W4530yLWd8RmGV1zVP/Eipp86f9DEUeMrxKHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Edward Adam Davis <eadavis@qq.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Subject: [PATCH 4.19 13/16] btrfs: dev-replace: properly validate device names
Date: Mon,  4 Mar 2024 21:23:34 +0000
Message-ID: <20240304211534.822842025@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211534.328737119@linuxfoundation.org>
References: <20240304211534.328737119@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -535,6 +535,23 @@ leave:
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
@@ -547,10 +564,9 @@ int btrfs_dev_replace_by_ioctl(struct bt
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



