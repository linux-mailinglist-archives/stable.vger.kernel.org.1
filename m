Return-Path: <stable+bounces-7225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4270181717D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCD88B20B97
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8EA15AC0;
	Mon, 18 Dec 2023 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aNfjqvGz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6536129ED2;
	Mon, 18 Dec 2023 13:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9D2C433C8;
	Mon, 18 Dec 2023 13:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907900;
	bh=SV0J3CCoA4Np0A6Hvy5ILqO+K4kvJEPVLZIwfWKuYWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNfjqvGzT+sVehjGW1u4EsVmzZNF6XX6DBm58UGGDQKQXwqpemouNLLXMf1dCY/0n
	 LU8tahFF6carPaWWmG/rpuKjmA2rhORvfSBWcY5+XwlsgITs9eV1qZKCFYTTxpimke
	 3/BI1Jefa/F889o0c8zv6M/WVxJtyZv2fU4QYCUQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 087/106] btrfs: free qgroup reserve when ORDERED_IOERR is set
Date: Mon, 18 Dec 2023 14:51:41 +0100
Message-ID: <20231218135058.794976771@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

commit f63e1164b90b385cd832ff0fdfcfa76c3cc15436 upstream.

An ordered extent completing is a critical moment in qgroup reserve
handling, as the ownership of the reservation is handed off from the
ordered extent to the delayed ref. In the happy path we release (unlock)
but do not free (decrement counter) the reservation, and the delayed ref
drives the free. However, on an error, we don't create a delayed ref,
since there is no ref to add. Therefore, free on the error path.

CC: stable@vger.kernel.org # 6.1+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ordered-data.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -544,7 +544,9 @@ void btrfs_remove_ordered_extent(struct
 			release = entry->disk_num_bytes;
 		else
 			release = entry->num_bytes;
-		btrfs_delalloc_release_metadata(btrfs_inode, release, false);
+		btrfs_delalloc_release_metadata(btrfs_inode, release,
+						test_bit(BTRFS_ORDERED_IOERR,
+							 &entry->flags));
 	}
 
 	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,



