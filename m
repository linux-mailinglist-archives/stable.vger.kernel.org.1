Return-Path: <stable+bounces-108302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E7FA0A6B3
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 01:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDCB168932
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD6A41;
	Sun, 12 Jan 2025 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBJv4aO2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460654431
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736640089; cv=none; b=m5UwFZcq5UnhSb5+FxOxLTVge0AWWPR4MP44m+WvSiQ6m61nBjR9zqXACPra7c2BsXz19jfMnFuaHtvfzdohAcoeur2FUT45Mf4GYHNh/NgOTCFb3FjtB1R2V32fA3kzmT0mXC6PMQKnYJOc8qia1UfbEuSuTtLqhcAOsGhFlUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736640089; c=relaxed/simple;
	bh=8ZcZSzArI1XEg8rG2xoU+Z7IY1/Dt9+21sniwBstlSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kwo6vGoUzTScWIj/SJ5YCrwTXkxUgq8XCltScPCN/wB0FdCgCwM+q6oGbS4o7Kk/dRH65hMhJMWtMURqkxIz82xfaVgboKF3q8H1mru6egleNRlMRT5FPsKg+/pdHELtMqlbQX+30CJ9PdQjWL43xGOrakfFvtr5K46k3KKL/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBJv4aO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA73C4CED2;
	Sun, 12 Jan 2025 00:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736640088;
	bh=8ZcZSzArI1XEg8rG2xoU+Z7IY1/Dt9+21sniwBstlSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBJv4aO2aEUJi8l4R105dG0aPEXQ4qXRj9Y6EbLMvApYvY2dqvkR7qZItMIcIxzgG
	 4a3ttCvGCnMZOL0tkgZ/uKM1kH9UlwrVDp18nWpfKJvj4hVhSnvAU6+e0NDiTNFlTg
	 N3eUbHZ/Q/Q8E6zt4RyxwyjNYh9nnlG1Cyc5H5ugTeoS+FbjNweBUruoBKZgaQwBGa
	 eUcrBfhP7dohykdF+W2AmTCX8VNQ6Rlen2Ts3bSah++2V1ly4N8cN2wYstr0XP9G5b
	 eOqF+EykOVtq6EbM0+c+XvfWzLLCHe1dfNZLCcnoWVKu052xdieAGq+dSF7u7NfDqX
	 o4j/trWMFpk4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)
Date: Sat, 11 Jan 2025 19:01:26 -0500
Message-Id: <20250111182528-f23ff245ec71178c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250111224554.368020-1-gmazyland@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 6df90c02bae468a3a6110bafbc659884d0c4966c


Status in newer kernel trees:
6.12.y | Present (different SHA1: 16c9c0afd88d)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6df90c02bae4 ! 1:  c91919dd6e7e dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)
    @@ Commit message
         Fixes: 8ca7cab82bda ("dm verity fec: fix misaligned RS roots IO")
         Cc: stable@vger.kernel.org
         Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
    +    (cherry picked from commit 6df90c02bae468a3a6110bafbc659884d0c4966c)
    +    Signed-off-by: Milan Broz <gmazyland@gmail.com>
     
      ## drivers/md/dm-verity-fec.c ##
     @@ drivers/md/dm-verity-fec.c: static int fec_decode_rs8(struct dm_verity *v, struct dm_verity_fec_io *fio,
       * to the data block. Caller is responsible for releasing buf.
       */
      static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
    --			   unsigned int *offset, struct dm_buffer **buf,
    --			   unsigned short ioprio)
    +-			   unsigned int *offset, struct dm_buffer **buf)
     +			   unsigned int *offset, unsigned int par_buf_offset,
    -+			   struct dm_buffer **buf, unsigned short ioprio)
    ++			  struct dm_buffer **buf)
      {
      	u64 position, block, rem;
      	u8 *res;
    @@ drivers/md/dm-verity-fec.c: static int fec_decode_rs8(struct dm_verity *v, struc
     -	*offset = (unsigned int)rem;
     +	*offset = par_buf_offset ? 0 : (unsigned int)rem;
      
    - 	res = dm_bufio_read_with_ioprio(v->fec->bufio, block, buf, ioprio);
    + 	res = dm_bufio_read(v->fec->bufio, block, buf);
      	if (IS_ERR(res)) {
    -@@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
    +@@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
      {
      	int r, corrected = 0, res;
      	struct dm_buffer *buf;
    @@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, stru
     -	u8 *par, *block;
     +	unsigned int n, i, offset, par_buf_offset = 0;
     +	u8 *par, *block, par_buf[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN];
    - 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
      
    --	par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
    +-	par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
     +	par = fec_read_parity(v, rsb, block_offset, &offset,
    -+			      par_buf_offset, &buf, bio_prio(bio));
    ++			      par_buf_offset, &buf);
      	if (IS_ERR(par))
      		return PTR_ERR(par);
      
    -@@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
    +@@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
      	 */
      	fec_for_each_buffer_rs_block(fio, n, i) {
      		block = fec_buffer_rs_block(v, fio, n, i);
    @@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, stru
      		if (res < 0) {
      			r = res;
      			goto error;
    -@@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
    +@@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
      		if (block_offset >= 1 << v->data_dev_block_bits)
      			goto done;
      
    @@ drivers/md/dm-verity-fec.c: static int fec_decode_bufs(struct dm_verity *v, stru
      		if (offset >= v->fec->io_size) {
      			dm_bufio_release(buf);
      
    --			par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
    +-			par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
     +			par = fec_read_parity(v, rsb, block_offset, &offset,
    -+					      par_buf_offset, &buf, bio_prio(bio));
    ++					      par_buf_offset, &buf);
      			if (IS_ERR(par))
      				return PTR_ERR(par);
      		}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

