Return-Path: <stable+bounces-4400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E46804752
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5D2815C5
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3E8BF2;
	Tue,  5 Dec 2023 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KifrVFZh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD136FB1;
	Tue,  5 Dec 2023 03:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55617C433C9;
	Tue,  5 Dec 2023 03:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747441;
	bh=SfaPMdrT8PzbGZfMP2pKnUjqnAhkW4DXQifejcN6XFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KifrVFZhp07dFLp6ao2XoqEttTunuTvJK/WBbHDOLUJA76QrFA1+V+AqiPg9TU+Gx
	 UkPmaqCZpyZXWGnCPiCxNwW/SVkucZgFFrmPCPoJvBLsMERAIkfm+wTSHNzneijdGR
	 pr7xdjsaMrDNJj8MOzAh1cj6xn7KBYwcs1qb/D6g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 5.10 077/135] dm-verity: align struct dm_verity_fec_io properly
Date: Tue,  5 Dec 2023 12:16:38 +0900
Message-ID: <20231205031535.327665714@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 38bc1ab135db87577695816b190e7d6d8ec75879 upstream.

dm_verity_fec_io is placed after the end of two hash digests. If the hash
digest has unaligned length, struct dm_verity_fec_io could be unaligned.

This commit fixes the placement of struct dm_verity_fec_io, so that it's
aligned.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-verity-fec.c |    3 ++-
 drivers/md/dm-verity.h     |    6 ------
 2 files changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -24,7 +24,8 @@ bool verity_fec_is_enabled(struct dm_ver
  */
 static inline struct dm_verity_fec_io *fec_io(struct dm_verity_io *io)
 {
-	return (struct dm_verity_fec_io *) verity_io_digest_end(io->v, io);
+	return (struct dm_verity_fec_io *)
+		((char *)io + io->v->ti->per_io_data_size - sizeof(struct dm_verity_fec_io));
 }
 
 /*
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -111,12 +111,6 @@ static inline u8 *verity_io_want_digest(
 	return (u8 *)(io + 1) + v->ahash_reqsize + v->digest_size;
 }
 
-static inline u8 *verity_io_digest_end(struct dm_verity *v,
-				       struct dm_verity_io *io)
-{
-	return verity_io_want_digest(v, io) + v->digest_size;
-}
-
 extern int verity_for_bv_block(struct dm_verity *v, struct dm_verity_io *io,
 			       struct bvec_iter *iter,
 			       int (*process)(struct dm_verity *v,



