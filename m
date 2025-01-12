Return-Path: <stable+bounces-108303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2466A0A6B4
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 01:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE3A1689F2
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 00:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34C628E8;
	Sun, 12 Jan 2025 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZDP7KCn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F3610B
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736640092; cv=none; b=k0ZS5VrgKVHANo9vWdDCALQhdOHn+y2KAazaszVXrMBRgZNm7rulpg6+lbUVecsttVmJvEuM9EaBfuwyKidi0A+qy77ZgRGyXy5J+IO0fATRjAXFoIzYhcUlrYGckMZiwuidD8zAy1+Ao7SputnrS71bpZ+PCOQP+0hj88/Ac/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736640092; c=relaxed/simple;
	bh=RzPsLl7tkpnztHo38z9LFz0mbTITR6o9Eboa+XlRJNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbsjodRiQsYuPgY7aVXkYGuaBIVqHU3QBeCKX8khtNylxRdqgFAuxA2QUi9eo3ZAUbjhmBiEIetdEtfBrdVdhtR1fV0/vGGphI+DM0gbbLESvLZ9Zd3i1vlXujkQtRghGkp6Q3KYiRWO08+mqiff9WfkiGlBI04xgVbEIWUn0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZDP7KCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756BAC4CED2;
	Sun, 12 Jan 2025 00:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736640091;
	bh=RzPsLl7tkpnztHo38z9LFz0mbTITR6o9Eboa+XlRJNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZDP7KCnoUzsr/9l8vBzVZk4joH3EycSfADSzdTTnZL/vj7wpKVLnO/NJsRdMxMQv
	 tIdgCLYqwC4OLZpWkTYxji5tXsln7epbmqKuItkE3qHq8IoiVqTYcHaLhkiS33fbS0
	 D+agd+WLOfrEHr5h9XzDOjoiPWu8uhkVyfFV3EBkXjqxNq+VHQF7Y9padgr75qyo/j
	 DCkm20kFizIgy7ok0QgaWtshE3MZ2qe5Mhgs9t5J6W6JSPw7OAAqEqEWUjlubPpArm
	 +Pq29egeZKxRMR0+8FS8qUOjnsEvq1K/vcJSOUAVbBalRu628YeKUCDBOLwnOrzzKZ
	 w0QsVScNaLJXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)
Date: Sat, 11 Jan 2025 19:01:29 -0500
Message-Id: <20250111183417-38a97a75275ca59a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250111224833.368181-1-gmazyland@gmail.com>
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
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6df90c02bae4 ! 1:  256dffb95a93 dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)
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
| stable/linux-6.1.y        |  Success    |  Success   |

