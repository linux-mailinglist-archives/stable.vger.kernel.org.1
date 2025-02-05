Return-Path: <stable+bounces-112328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7B6A28C2A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1365188218D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B0614A088;
	Wed,  5 Feb 2025 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GR6+kMRf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42213D52B;
	Wed,  5 Feb 2025 13:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763138; cv=none; b=p2v/aNqH6UQxjAESBUW48DL9Nbdc5LVNcCHtDE9DJX+p5y3miTdt/wVwHAmcSF/aeoysRUJyC9HvVqOtbozvgtfHHl7A1twpLxpHdcSlR/+FKmRwaBCtPuMW33Xc8OTcI6KCym8Rk/qPEArmpdEU9clM22VvrFVQng7qOw1FUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763138; c=relaxed/simple;
	bh=WQGvGQBHeJjCXq0SrQpwZm0aPpYiePX8vfLicPaH0OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1AslEol6fv21bAa+mZxfc65bUhQjTzpZkXQ0Mz/RWtjcl9vyW322NyjGsNfb1yFKmBGrW6un3mThKZt+R5Dxc9DsKi9l0kZc+T6yvA/3401i79/lF/xbO68miNwV2jk/f4MRzta2Aij24KL1LQ/FvbvdtidPOW1qrzR7uLd48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GR6+kMRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63044C4CED1;
	Wed,  5 Feb 2025 13:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763137;
	bh=WQGvGQBHeJjCXq0SrQpwZm0aPpYiePX8vfLicPaH0OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GR6+kMRfl9tE+2KBL8PhfuvxBROnlTIpTb01hR3y6ZpvsQB+NhOgWi+4R8eNUHz8D
	 PCKY1xTDN5luEkvAmMtxBmpP8j+PcVTho9q40P+VbQooPY1TJCEQ/8AtbMxe5Cn0nQ
	 oaLZrsSutgMQP4reFxmbDQzJnfhFglSjEfjGQ9Bc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 004/393] afs: Fix directory format encoding struct
Date: Wed,  5 Feb 2025 14:38:43 +0100
Message-ID: <20250205134420.458584904@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 07a10767853adcbdbf436dc91393b729b52c4e81 ]

The AFS directory format structure, union afs_xdr_dir_block::meta, has too
many alloc counter slots declared and so pushes the hash table along and
over the data.  This doesn't cause a problem at the moment because I'm
currently ignoring the hash table and only using the correct number of
alloc_ctrs in the code anyway.  In future, however, I should start using
the hash table to try and speed up afs_lookup().

Fix this by using the correct constant to declare the counter array.

Fixes: 4ea219a839bf ("afs: Split the directory content defs into a header")
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20241216204124.3752367-14-dhowells@redhat.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/xdr_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/xdr_fs.h b/fs/afs/xdr_fs.h
index 8ca8681645077..cc5f143d21a34 100644
--- a/fs/afs/xdr_fs.h
+++ b/fs/afs/xdr_fs.h
@@ -88,7 +88,7 @@ union afs_xdr_dir_block {
 
 	struct {
 		struct afs_xdr_dir_hdr	hdr;
-		u8			alloc_ctrs[AFS_DIR_MAX_BLOCKS];
+		u8			alloc_ctrs[AFS_DIR_BLOCKS_WITH_CTR];
 		__be16			hashtable[AFS_DIR_HASHTBL_SIZE];
 	} meta;
 
-- 
2.39.5




