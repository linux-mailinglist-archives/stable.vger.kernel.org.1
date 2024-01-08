Return-Path: <stable+bounces-10297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ACF827449
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AF9B21F70
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3148154BD2;
	Mon,  8 Jan 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HFEdvIYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6AF53806;
	Mon,  8 Jan 2024 15:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504C8C433CB;
	Mon,  8 Jan 2024 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728603;
	bh=Tp+fwSLkNnOmbl/KbyLjTunxnVItnqrDBocKJ4QP4Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFEdvIYyHsAZ326cZgbnFKFMnJ6XAYhTGRWNEJZxA/sH1mHQrxlcU9hIixNio9UoN
	 w6xgI5XwqaMsMRGmxHJyNbZ/9cAamWsDlu7B6w0j8/DpjW50GZ3E8fYjPalvJltgGR
	 Hk2wdKXooE2hm6bDnSH4oJIG8Brd+kCyOyoEpADU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 130/150] btrfs: mark the len field in struct btrfs_ordered_sum as unsigned
Date: Mon,  8 Jan 2024 16:36:21 +0100
Message-ID: <20240108153517.172904179@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 6e4b2479ab38b3f949a85964da212295d32102f0 ]

len can't ever be negative, so mark it as an u32 instead of int.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 9e65bfca24cf ("btrfs: fix qgroup_free_reserved_data int overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file-item.c    | 2 +-
 fs/btrfs/ordered-data.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index b14d2da9b26d3..14478da875313 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -602,7 +602,7 @@ int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
 			}
 
 			sums->bytenr = start;
-			sums->len = (int)size;
+			sums->len = size;
 
 			offset = (start - key.offset) >> fs_info->sectorsize_bits;
 			offset *= csum_size;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index f59f2dbdb25ed..cc3ca4bb9bd54 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -20,7 +20,7 @@ struct btrfs_ordered_sum {
 	/*
 	 * this is the length in bytes covered by the sums array below.
 	 */
-	int len;
+	u32 len;
 	struct list_head list;
 	/* last field is a variable length array of csums */
 	u8 sums[];
-- 
2.43.0




