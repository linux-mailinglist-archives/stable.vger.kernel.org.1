Return-Path: <stable+bounces-83682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EAA99BE9C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F13281434
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2C7158848;
	Mon, 14 Oct 2024 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aknMXeWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C5158558;
	Mon, 14 Oct 2024 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878301; cv=none; b=S/SkgEZeipqPeXeHhPB3bzegt5eLtclrE+4UDtaXcPGltLbVMI+1Zsc2rRvxJJ6kWxrkpji2hnzpXPuU3CCL3TM7Y8RC5MHrRIFq5e/93EDDbUjMKikyhVzEbr7WJ8/twrcEeE39jHOhbQX1XNhP/9s+fh0oMP3pjJpmWm5Stho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878301; c=relaxed/simple;
	bh=M89r/ymFDKvVzwyXtJVZNcd1oTCW9l+bnV33+pk7GOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FneVTiclKWalfCQgpHXQu6XEQAgM7GIegr4jFJ+HQnBR0lOikZxexj5dG/Whxtn/lh6w3J19NRaKV8nefec6XNOwct9serUgQ0gzhC7o/s2Hmf7bDhbi09BGHUJig9dw6qgxeiZohGK+YWx4t1c2wXB4gm2HCjycZ5qnRkwyPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aknMXeWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76453C4CECF;
	Mon, 14 Oct 2024 03:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878301;
	bh=M89r/ymFDKvVzwyXtJVZNcd1oTCW9l+bnV33+pk7GOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aknMXeWHTXP/KVuMhQzm0VkqVrTP7wpdvSUbUt3Bw2Bs0YkJPcCdNoWxEXuMUDB8F
	 +1nKOxLFtp/aSs8KwXL1wkSiD/Kff3lK/x1QSIz2lfeExcfdFhfFQHa43oaI1lwBT5
	 6cq4i1nKjEh+cDv6CP+Whq+1JMNjc8Udl00jWqNWMKWKyEVmnbyLOcjvhzNEyzvIUV
	 t3ayTFMRYOmm/wuULvSkNECrWmByb5YPupldp8RATcJQSDvGvJmBwvDnpExI54OIYU
	 O6p/fxKK2uEudufTq+sFk6Dq81Y75xqtzsdYVksToaMAB+GrxHS3pLUVoEOnsxyHLN
	 5yoBBhd7Bw0+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 04/17] fs/ntfs3: Stale inode instead of bad
Date: Sun, 13 Oct 2024 23:57:54 -0400
Message-ID: <20241014035815.2247153-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035815.2247153-1-sashal@kernel.org>
References: <20241014035815.2247153-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 1fd21919de6de245b63066b8ee3cfba92e36f0e9 ]

Fixed the logic of processing inode with wrong sequence number.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 1545262995da2..20988ef3dc2ec 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -532,11 +532,15 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 	if (inode->i_state & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
-		/* Inode overlaps? */
-		_ntfs_bad_inode(inode);
+		/*
+		 * Sequence number is not expected.
+		 * Looks like inode was reused but caller uses the old reference
+		 */
+		iput(inode);
+		inode = ERR_PTR(-ESTALE);
 	}
 
-	if (IS_ERR(inode) && name)
+	if (IS_ERR(inode))
 		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
 
 	return inode;
-- 
2.43.0


