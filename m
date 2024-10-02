Return-Path: <stable+bounces-79924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2098DAEC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6143B269BA
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9941D07B5;
	Wed,  2 Oct 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E+KKkvCH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA41D1F5B;
	Wed,  2 Oct 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878867; cv=none; b=O+/UD6d7/F2MC7HXIXMN82OxCiap2WX7gPcLME5S+9HmrDqUYmxDZ9pQDdgfAnD+3eYuXZfhAlwoK4rHAomd8MP/b13FhWLsRcGzXRjwzvZqBJw82TAWUDsOXiCJ4Jw5QvOwbypomNPkm8do+Xsdez0KD+TGEp4sXwdS2uZi5No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878867; c=relaxed/simple;
	bh=0M4LpSr5GY/htaqR7t6M7rXSXma9alViVEn8c8n52L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwjjkj6R4fHOybCMP6v1fOMWb41RsKHDIawcbHWWeWadvv0wCa68RwwgJBIeYEpPDrzhJQVMoEuYJUtyN4i8M0nEIEdNaB0TJu7MafK8ay63RgKldBzy6t8XI34MrCAIB3rQKuwStM4GK2sdIoIjRyJOzN/oN+DTp6NGLfWywl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E+KKkvCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3609C4CEC5;
	Wed,  2 Oct 2024 14:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727878867;
	bh=0M4LpSr5GY/htaqR7t6M7rXSXma9alViVEn8c8n52L0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+KKkvCHzRX+YdA9wYSLWkVZIfC52LzB5X5NXN3/0346CzvQjeBtbuQaZ9ADkzTvd
	 2/lDrCqDoD5qYyja1Ywxakk/Df9jL1oO0Hn0UJIrK7FPz+NkCbJiWJUBpWM7NqhSIv
	 tWUNmMocshIofQ5MLqUCFj/BjFNVVjqALSrWlGzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Luca Stefani <luca.stefani.ge1@gmail.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.10 559/634] btrfs: always update fstrim_range on failure in FITRIM ioctl
Date: Wed,  2 Oct 2024 15:00:59 +0200
Message-ID: <20241002125833.177929256@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Stefani <luca.stefani.ge1@gmail.com>

commit 3368597206dc3c6c3c2247ee146beada14c67380 upstream.

Even in case of failure we could've discarded some data and userspace
should be made aware of it, so copy fstrim_range to userspace
regardless.

Also make sure to update the trimmed bytes amount even if
btrfs_trim_free_extents fails.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent-tree.c |    4 ++--
 fs/btrfs/ioctl.c       |    4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6426,13 +6426,13 @@ int btrfs_trim_fs(struct btrfs_fs_info *
 			continue;
 
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
+
+		trimmed += group_trimmed;
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
 			break;
 		}
-
-		trimmed += group_trimmed;
 	}
 	mutex_unlock(&fs_devices->device_list_mutex);
 
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -543,13 +543,11 @@ static noinline int btrfs_ioctl_fitrim(s
 
 	range.minlen = max(range.minlen, minlen);
 	ret = btrfs_trim_fs(fs_info, &range);
-	if (ret < 0)
-		return ret;
 
 	if (copy_to_user(arg, &range, sizeof(range)))
 		return -EFAULT;
 
-	return 0;
+	return ret;
 }
 
 int __pure btrfs_is_empty_uuid(u8 *uuid)



