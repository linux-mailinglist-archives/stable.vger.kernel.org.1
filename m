Return-Path: <stable+bounces-131614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2A5A80A7C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A7817B3991
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62519268685;
	Tue,  8 Apr 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/LiTyJo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4A26B943;
	Tue,  8 Apr 2025 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116873; cv=none; b=LSumdQ7xklIZiT4MK+DWCNa++RwOY0eunRXPo5ZYDBsYItEn2NXqeuKv+SGQgzKdo6vCjPuY6DuqxoBDOPkaA43bQDaRra9biVWd9b+Vtie6YThGzKP/6tZao+NfYY2M7N0X9PWcLXPt5tj2WpRR+T/R1neDPL+ulvOOgG42Ld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116873; c=relaxed/simple;
	bh=lohm0wbZQrcWm27XEgTvUne73eCscqaDcTyU/kbgKGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYkVUlRVYJaCqvXXmJZYlUmTxXZi+9o1jKUBKQ1E/P+MxK4V7lXOH91pswuezvxNxJBMWnNLR0fTStXTOM/ww1L3pMmhlwkdq7VXecHOEdyozNrAW1d44vzSSYBuaTJy5XWNWIrW8/xWrZegXC//IklJWCro0MFydE48TrMzMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/LiTyJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3824C4CEE7;
	Tue,  8 Apr 2025 12:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116873;
	bh=lohm0wbZQrcWm27XEgTvUne73eCscqaDcTyU/kbgKGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/LiTyJolgLkGBgTPSFD/AKW+2M+0IpYh41A09bWdETa/b1sjKTfe+2ucyU3BVhqh
	 GV4Udd0M9PcYUYzxxOAC8KNgndF0hI8HWjV/og0DMLnlamd7qOL456EaKd1Uvuvm3N
	 2rfqslrYBaLKG46+Ts17b3rfDRlqrWeaSjpyObFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Tatham <anakin@pobox.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 263/423] affs: dont write overlarge OFS data block size fields
Date: Tue,  8 Apr 2025 12:49:49 +0200
Message-ID: <20250408104851.873418221@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Tatham <anakin@pobox.com>

[ Upstream commit 011ea742a25a77bac3d995f457886a67d178c6f0 ]

If a data sector on an OFS floppy contains a value > 0x1e8 (the
largest amount of data that fits in the sector after its header), then
an Amiga reading the file can return corrupt data, by taking the
overlarge size at its word and reading past the end of the buffer it
read the disk sector into!

The cause: when affs_write_end_ofs() writes data to an OFS filesystem,
the new size field for a data block was computed by adding the amount
of data currently being written (into the block) to the existing value
of the size field. This is correct if you're extending the file at the
end, but if you seek backwards in the file and overwrite _existing_
data, it can lead to the size field being larger than the maximum
legal value.

This commit changes the calculation so that it sets the size field to
the max of its previous size and the position within the block that we
just wrote up to.

Signed-off-by: Simon Tatham <anakin@pobox.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/affs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index 226308f8627e7..7a71018e3f675 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -724,7 +724,8 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
 		tmp = min(bsize - boff, to - from);
 		BUG_ON(boff + tmp > bsize || tmp > bsize);
 		memcpy(AFFS_DATA(bh) + boff, data + from, tmp);
-		be32_add_cpu(&AFFS_DATA_HEAD(bh)->size, tmp);
+		AFFS_DATA_HEAD(bh)->size = cpu_to_be32(
+			max(boff + tmp, be32_to_cpu(AFFS_DATA_HEAD(bh)->size)));
 		affs_fix_checksum(sb, bh);
 		mark_buffer_dirty_inode(bh, inode);
 		written += tmp;
-- 
2.39.5




