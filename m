Return-Path: <stable+bounces-129112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18544A7FE23
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7634116DDF0
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA3263C6D;
	Tue,  8 Apr 2025 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fSQATpqW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5318E26A0EA;
	Tue,  8 Apr 2025 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110148; cv=none; b=eI01rPcUsvWWQqJ7XnoPO5NRExgeeMEzgeZKouI0ZToLpNYXqZ3x+IadEqmJiXD0anpmZh7/4UOPFY3wMt7iGFlh9OkHRIPbMtzemSUvap2jQ6cF9yQU/MfTDJHXxwdN8wO1UTQUU7NHo+lIw156MoIQLY48ChjQSK9nIVsn1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110148; c=relaxed/simple;
	bh=yskLhDd2knqP1e6nqt3cqzefTZn6GyMOK9i5wODA5wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGZAgKWUPxR+Y1MPrmvZ2aDNSI6XoXYIwTy4lHUYLx+4snTcz8ysu7bj0Y6SUs4FiCbOQ/t94zmyW9h8Fra7yJv9HwFTbU1W6oz20XKbXRzbSkwgR+dP0ItwLSO30mA8l6nnGaJI/eE2xY9dXqrnRpTkvZRQ/2s6D5CuEkj3sl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fSQATpqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AC9C4CEE5;
	Tue,  8 Apr 2025 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744110147;
	bh=yskLhDd2knqP1e6nqt3cqzefTZn6GyMOK9i5wODA5wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSQATpqWwzEL0gplRWcjaU8icaMJCz5xSsok8VBH7UDqaon87+ITnuAiH5DrCvivm
	 vGJ0V/Uv0xQ5rSeXWaz70T2K7ADZk0DhJX5d3HB731p29GQYBvwOqrJFmgipRw0zGl
	 rkTZlOeTJDNjd/iwkEkWeqjU3o69RldD4QRBTxbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Tatham <anakin@pobox.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 186/227] affs: dont write overlarge OFS data block size fields
Date: Tue,  8 Apr 2025 12:49:24 +0200
Message-ID: <20250408104825.885014668@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 7738fafcccfc1..bc88ba29d393c 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -725,7 +725,8 @@ static int affs_write_end_ofs(struct file *file, struct address_space *mapping,
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




