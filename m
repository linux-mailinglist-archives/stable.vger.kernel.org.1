Return-Path: <stable+bounces-106712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89159A00BE4
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEC1164641
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6C31FBE86;
	Fri,  3 Jan 2025 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhxN4yoq"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65161FBCAF
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920822; cv=none; b=QASU5iBr4sH/VslOdPokQ4Fxqu1Ccqw5xIdzbRjVQ2ZPd9zCAfB4CeILr+FDdVPII3WRz0Rxq76LUjRRfPKvdAw/41RvTGKrfKtnlcRpLioTv1IsaH/E8U3awLPSNGIANh+im/JD9oK1M7A24nN627atd6pEgcR75WEWlY11Gio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920822; c=relaxed/simple;
	bh=4FEuJDlDI0B16gkXu6wLgeyZ5PrTnKaroqnftxcmUjg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dV4wqV2WNK0PFEWEo5A2vE7BRRbBRLi1ZSh7JjTBJyS6fLSXckk52i/bWiH6K+iC4r59lOhEJ7X6ybcRhVRnY9Wkobcy8M5wRhyWCiW5MgD6zAFyR827H8nqccr+Ge+gKdStS5ThPd3Gn09aKxMhjVOUAi5g6+c5ltLDiUJfxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhxN4yoq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735920817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPe8/8TErK3TKOg87HTQS07RBZ/QcY+iITVQnBjOqwA=;
	b=LhxN4yoq33sMwb8hf91TmaYEs+5D7iBinnAYfW9jNE90Fu/5ptVUMkQcHdY9s9nsaphvbR
	Pw1BGDfE/vXTQd0L2LDhBvohUaDz8wiI9ZM2Q349f+7KHH5HFcIr8W2bleT5aM1CgaMA8M
	eNFonIMdKao/+qflZhENlUbpjiXDgvk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-mzHjFFuyM7u1RlklwwaNbg-1; Fri,
 03 Jan 2025 11:13:34 -0500
X-MC-Unique: mzHjFFuyM7u1RlklwwaNbg-1
X-Mimecast-MFC-AGG-ID: mzHjFFuyM7u1RlklwwaNbg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DB79195608E;
	Fri,  3 Jan 2025 16:13:32 +0000 (UTC)
Received: from [10.45.224.27] (unknown [10.45.224.27])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A49519560AA;
	Fri,  3 Jan 2025 16:13:30 +0000 (UTC)
Date: Fri, 3 Jan 2025 17:13:24 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
cc: dm-devel@lists.linux.dev, snitzer@kernel.org, samitolvanen@google.com, 
    jaegeuk@google.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] dm-verity FEC: Fix RS FEC repair for roots unaligned
 to block size (take 2)
In-Reply-To: <20241218125659.743433-1-gmazyland@gmail.com>
Message-ID: <7c7aff1c-a05b-0027-f484-66447d39bced@redhat.com>
References: <20241218125659.743433-1-gmazyland@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi

I staged both patches for 6.13.

Mikulas


On Wed, 18 Dec 2024, Milan Broz wrote:

> This patch fixes an issue that was fixed in the commit
>   df7b59ba9245 ("dm verity: fix FEC for RS roots unaligned to block size")
> but later broken again in the commit
>   8ca7cab82bda ("dm verity fec: fix misaligned RS roots IO")
> 
> If the Reed-Solomon roots setting spans multiple blocks, the code does not
> use proper parity bytes and randomly fails to repair even trivial errors.
> 
> This bug cannot happen if the sector size is multiple of RS roots
> setting (Android case with roots 2).
> 
> The previous solution was to find a dm-bufio block size that is multiple
> of the device sector size and roots size. Unfortunately, the optimization
> in commit 8ca7cab82bda ("dm verity fec: fix misaligned RS roots IO")
> is incorrect and uses data block size for some roots (for example, it uses
> 4096 block size for roots = 20).
> 
> This patch uses a different approach:
> 
>  - It always uses a configured data block size for dm-bufio to avoid
>  possible misaligned IOs.
> 
>  - and it caches the processed parity bytes, so it can join it
>  if it spans two blocks.
> 
> As the RS calculation is called only if an error is detected and
> the process is computationally intensive, copying a few more bytes
> should not introduce performance issues.
> 
> The issue was reported to cryptsetup with trivial reproducer
>   https://gitlab.com/cryptsetup/cryptsetup/-/issues/923
> 
> Reproducer (with roots=20):
> 
>  # create verity device with RS FEC
>  dd if=/dev/urandom of=data.img bs=4096 count=8 status=none
>  veritysetup format data.img hash.img --fec-device=fec.img --fec-roots=20 | \
>  awk '/^Root hash/{ print $3 }' >roothash
> 
>  # create an erasure that should always be repairable with this roots setting
>  dd if=/dev/zero of=data.img conv=notrunc bs=1 count=4 seek=4 status=none
> 
>  # try to read it through dm-verity
>  veritysetup open data.img test hash.img --fec-device=fec.img --fec-roots=20 $(cat roothash)
>  dd if=/dev/mapper/test of=/dev/null bs=4096 status=noxfer
> 
>  Even now the log says it cannot repair it:
>    : verity-fec: 7:1: FEC 0: failed to correct: -74
>    : device-mapper: verity: 7:1: data block 0 is corrupted
>    ...
> 
> With this fix, errors are properly repaired.
>    : verity-fec: 7:1: FEC 0: corrected 4 errors
> 
> Signed-off-by: Milan Broz <gmazyland@gmail.com>
> Fixes: 8ca7cab82bda ("dm verity fec: fix misaligned RS roots IO")
> Cc: stable@vger.kernel.org
> ---
>  drivers/md/dm-verity-fec.c | 40 +++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
> index 62b1a44b8dd2..6bd9848518d4 100644
> --- a/drivers/md/dm-verity-fec.c
> +++ b/drivers/md/dm-verity-fec.c
> @@ -60,15 +60,19 @@ static int fec_decode_rs8(struct dm_verity *v, struct dm_verity_fec_io *fio,
>   * to the data block. Caller is responsible for releasing buf.
>   */
>  static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
> -			   unsigned int *offset, struct dm_buffer **buf,
> -			   unsigned short ioprio)
> +			   unsigned int *offset, unsigned int par_buf_offset,
> +			   struct dm_buffer **buf, unsigned short ioprio)
>  {
>  	u64 position, block, rem;
>  	u8 *res;
>  
> +	/* We have already part of parity bytes read, skip to the next block */
> +	if (par_buf_offset)
> +		index++;
> +
>  	position = (index + rsb) * v->fec->roots;
>  	block = div64_u64_rem(position, v->fec->io_size, &rem);
> -	*offset = (unsigned int)rem;
> +	*offset = par_buf_offset ? 0 : (unsigned int)rem;
>  
>  	res = dm_bufio_read_with_ioprio(v->fec->bufio, block, buf, ioprio);
>  	if (IS_ERR(res)) {
> @@ -128,11 +132,12 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
>  {
>  	int r, corrected = 0, res;
>  	struct dm_buffer *buf;
> -	unsigned int n, i, offset;
> -	u8 *par, *block;
> +	unsigned int n, i, offset, par_buf_offset = 0;
> +	u8 *par, *block, par_buf[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN];
>  	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
>  
> -	par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
> +	par = fec_read_parity(v, rsb, block_offset, &offset,
> +			      par_buf_offset, &buf, bio_prio(bio));
>  	if (IS_ERR(par))
>  		return PTR_ERR(par);
>  
> @@ -142,7 +147,8 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
>  	 */
>  	fec_for_each_buffer_rs_block(fio, n, i) {
>  		block = fec_buffer_rs_block(v, fio, n, i);
> -		res = fec_decode_rs8(v, fio, block, &par[offset], neras);
> +		memcpy(&par_buf[par_buf_offset], &par[offset], v->fec->roots - par_buf_offset);
> +		res = fec_decode_rs8(v, fio, block, par_buf, neras);
>  		if (res < 0) {
>  			r = res;
>  			goto error;
> @@ -155,12 +161,21 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
>  		if (block_offset >= 1 << v->data_dev_block_bits)
>  			goto done;
>  
> -		/* read the next block when we run out of parity bytes */
> -		offset += v->fec->roots;
> +		/* Read the next block when we run out of parity bytes */
> +		offset += (v->fec->roots - par_buf_offset);
> +		/* Check if parity bytes are split between blocks */
> +		if (offset < v->fec->io_size && (offset + v->fec->roots) > v->fec->io_size) {
> +			par_buf_offset = v->fec->io_size - offset;
> +			memcpy(par_buf, &par[offset], par_buf_offset);
> +			offset += par_buf_offset;
> +		} else
> +			par_buf_offset = 0;
> +
>  		if (offset >= v->fec->io_size) {
>  			dm_bufio_release(buf);
>  
> -			par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
> +			par = fec_read_parity(v, rsb, block_offset, &offset,
> +					      par_buf_offset, &buf, bio_prio(bio));
>  			if (IS_ERR(par))
>  				return PTR_ERR(par);
>  		}
> @@ -724,10 +739,7 @@ int verity_fec_ctr(struct dm_verity *v)
>  		return -E2BIG;
>  	}
>  
> -	if ((f->roots << SECTOR_SHIFT) & ((1 << v->data_dev_block_bits) - 1))
> -		f->io_size = 1 << v->data_dev_block_bits;
> -	else
> -		f->io_size = v->fec->roots << SECTOR_SHIFT;
> +	f->io_size = 1 << v->data_dev_block_bits;
>  
>  	f->bufio = dm_bufio_client_create(f->dev->bdev,
>  					  f->io_size,
> -- 
> 2.45.2
> 


