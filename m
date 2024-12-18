Return-Path: <stable+bounces-105159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06989F6648
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3524E164D82
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE721ACEB6;
	Wed, 18 Dec 2024 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enJ7lAsJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5E2E630
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734526651; cv=none; b=YG1Be2po+guEpRaAptC2hBEnq0Efjn+YmIbJ/OYXUtDFOxjlNahHVZuMOUT+l97OrMZ8TM+/ivlOb1iPz0NC1wA1E+eYmfZzHrzaXiFq7QuzlEEsaXkEQMk1GGll6GM0cKuDKaTVQuf848mY/y67skjdyPxSkwsz+K2ZivmwoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734526651; c=relaxed/simple;
	bh=z8wms88ORT9j6FOpNaVYrgGG7JWgrQzacqQ5JCsYVho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p217eC1gm8BwZXnWai/rHe9pemnJyiCD+RyAXGAGuMDs7ahWKm70/O6/CACuW3m9K/ShFOnRpctdcDsJ36KfhhAGqZRcyTC6wnmaHApPVYwc+lx+J/N2w0wogMK7ZmtFRuhCOuGFYPSxoVxRfOwL4xmPCgsbYSXFjkACna/5pmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enJ7lAsJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aab925654d9so909093066b.2
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734526648; x=1735131448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCPMR6EORe91bOxjKN4OfMPqLEjWnpVbBSIjTYcJc1w=;
        b=enJ7lAsJ8YGj7e4/0L8UYJ8v3fhCMDt/NgjfhicOUsmh7TNimQCzoNyZiFhxn5O4HI
         QhWNljk4MHhUYylms1YEaykvyk5pHQqwWK40Rr/TFSE15eAB1CuTiCuqRsFPZ23VHPRF
         +yH1HSTZ3ronbd4mWI0yQTba/hN9s+VAKuZ1OAHt/cZ/Hp+FuYv3YGQ/8cTttV8vtdUs
         oYMaJzLhzfN/bYQgpbApnv+O+Eaonetycm6/DSspBCw7inD++8KPSHEivt8zPBoOWsy0
         b0JDJIXTqFtELzInvq6HbTeJmRJHgFlkCguBTPahuoIVG+znx7c+Uiw+aAS46u0mfBSi
         6qCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734526648; x=1735131448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCPMR6EORe91bOxjKN4OfMPqLEjWnpVbBSIjTYcJc1w=;
        b=JbjpMXnS7XwAvnLNOZXba2LOcsbBAajZ7RoSJGsln/ZeIezWp3iwyBjdOv/Q7kykVR
         uegpb21td2jU0vKQAc5u7CJFGqK4VI3M8+EsQ4xdc+mlY4EGsgIUNp1Rk0IwXbKLTJjZ
         WlewjSuSDooG+FAfsAYgJR9uyNbguf3pC4U8jEa6lN53Pw55vN4dy17wbI8IrKsRhT2H
         7vuvrJAb1Haic1jty4mfRoxgFmhmvALeX9qzn9uRBXb/ozw1RMMP+awZXoiKbwEPjzOY
         RxizY2QrY705tCFyp5tOIohZOwaIFRgE3RFaArAxXTOGpVoI88KXH0jeEXKstBn1RzRq
         kJLA==
X-Forwarded-Encrypted: i=1; AJvYcCV/GBYlX9HxUyBS7vWrcohCpnKYirrxdWV1IvULpuPJITg6tsNxhNcTb20WVZhLQTnJgg1P0HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQvI0v2Jbrkf144wfRLWsgQC3E8BexkAGqPBjar8PFlJIirGzi
	EB7FlXL9JV10gbfZ3E7/SAqixVe7WD+g0FXS0XHAEKGZZ0Ypp1iT
X-Gm-Gg: ASbGncsMkCjJWoM25JLN+LZp/ED4Xh1+stfxM/K24zSL0ErCCqfEpnc/+RVtK3QxUnw
	OLQVPhxKiNKXlNBg/6XIRGAti8SXu5b7jnY9wih67pEc16GK/Kralrs3G/sG1vVsXu6f40xGp9J
	B2M+seUGCTrXDsa30qznIxyByenIIeNgZEc9fyL0WoeUcl5H6+UwcQcmTA0WsVI52qviMmF2Gle
	XK7K/L1ZB2Riim+P/Xne7G3f+1vvYvMlsu/jL24v56q660YoeWmbrlO/FrNkrM=
X-Google-Smtp-Source: AGHT+IH6xphJbzBB0clZE8WO90m1ArQbyWne+sZk3kJAASTuFfHPXnqqCDdwobQVEXgXsMJb4BK/tg==
X-Received: by 2002:a17:906:3297:b0:aa6:66bc:8788 with SMTP id a640c23a62f3a-aabf48cf088mr209274066b.45.1734526647725;
        Wed, 18 Dec 2024 04:57:27 -0800 (PST)
Received: from syrah.fi.muni.cz ([2001:718:801:22c:1369:c402:50e6:7236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963598c2sm555116966b.96.2024.12.18.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 04:57:27 -0800 (PST)
From: Milan Broz <gmazyland@gmail.com>
To: dm-devel@lists.linux.dev
Cc: snitzer@kernel.org,
	mpatocka@redhat.com,
	samitolvanen@google.com,
	jaegeuk@google.com,
	Milan Broz <gmazyland@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)
Date: Wed, 18 Dec 2024 13:56:58 +0100
Message-ID: <20241218125659.743433-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue that was fixed in the commit
  df7b59ba9245 ("dm verity: fix FEC for RS roots unaligned to block size")
but later broken again in the commit
  8ca7cab82bda ("dm verity fec: fix misaligned RS roots IO")

If the Reed-Solomon roots setting spans multiple blocks, the code does not
use proper parity bytes and randomly fails to repair even trivial errors.

This bug cannot happen if the sector size is multiple of RS roots
setting (Android case with roots 2).

The previous solution was to find a dm-bufio block size that is multiple
of the device sector size and roots size. Unfortunately, the optimization
in commit 8ca7cab82bda ("dm verity fec: fix misaligned RS roots IO")
is incorrect and uses data block size for some roots (for example, it uses
4096 block size for roots = 20).

This patch uses a different approach:

 - It always uses a configured data block size for dm-bufio to avoid
 possible misaligned IOs.

 - and it caches the processed parity bytes, so it can join it
 if it spans two blocks.

As the RS calculation is called only if an error is detected and
the process is computationally intensive, copying a few more bytes
should not introduce performance issues.

The issue was reported to cryptsetup with trivial reproducer
  https://gitlab.com/cryptsetup/cryptsetup/-/issues/923

Reproducer (with roots=20):

 # create verity device with RS FEC
 dd if=/dev/urandom of=data.img bs=4096 count=8 status=none
 veritysetup format data.img hash.img --fec-device=fec.img --fec-roots=20 | \
 awk '/^Root hash/{ print $3 }' >roothash

 # create an erasure that should always be repairable with this roots setting
 dd if=/dev/zero of=data.img conv=notrunc bs=1 count=4 seek=4 status=none

 # try to read it through dm-verity
 veritysetup open data.img test hash.img --fec-device=fec.img --fec-roots=20 $(cat roothash)
 dd if=/dev/mapper/test of=/dev/null bs=4096 status=noxfer

 Even now the log says it cannot repair it:
   : verity-fec: 7:1: FEC 0: failed to correct: -74
   : device-mapper: verity: 7:1: data block 0 is corrupted
   ...

With this fix, errors are properly repaired.
   : verity-fec: 7:1: FEC 0: corrected 4 errors

Signed-off-by: Milan Broz <gmazyland@gmail.com>
Fixes: 8ca7cab82bda ("dm verity fec: fix misaligned RS roots IO")
Cc: stable@vger.kernel.org
---
 drivers/md/dm-verity-fec.c | 40 +++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 62b1a44b8dd2..6bd9848518d4 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -60,15 +60,19 @@ static int fec_decode_rs8(struct dm_verity *v, struct dm_verity_fec_io *fio,
  * to the data block. Caller is responsible for releasing buf.
  */
 static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
-			   unsigned int *offset, struct dm_buffer **buf,
-			   unsigned short ioprio)
+			   unsigned int *offset, unsigned int par_buf_offset,
+			   struct dm_buffer **buf, unsigned short ioprio)
 {
 	u64 position, block, rem;
 	u8 *res;
 
+	/* We have already part of parity bytes read, skip to the next block */
+	if (par_buf_offset)
+		index++;
+
 	position = (index + rsb) * v->fec->roots;
 	block = div64_u64_rem(position, v->fec->io_size, &rem);
-	*offset = (unsigned int)rem;
+	*offset = par_buf_offset ? 0 : (unsigned int)rem;
 
 	res = dm_bufio_read_with_ioprio(v->fec->bufio, block, buf, ioprio);
 	if (IS_ERR(res)) {
@@ -128,11 +132,12 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 {
 	int r, corrected = 0, res;
 	struct dm_buffer *buf;
-	unsigned int n, i, offset;
-	u8 *par, *block;
+	unsigned int n, i, offset, par_buf_offset = 0;
+	u8 *par, *block, par_buf[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN];
 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
-	par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
+	par = fec_read_parity(v, rsb, block_offset, &offset,
+			      par_buf_offset, &buf, bio_prio(bio));
 	if (IS_ERR(par))
 		return PTR_ERR(par);
 
@@ -142,7 +147,8 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	 */
 	fec_for_each_buffer_rs_block(fio, n, i) {
 		block = fec_buffer_rs_block(v, fio, n, i);
-		res = fec_decode_rs8(v, fio, block, &par[offset], neras);
+		memcpy(&par_buf[par_buf_offset], &par[offset], v->fec->roots - par_buf_offset);
+		res = fec_decode_rs8(v, fio, block, par_buf, neras);
 		if (res < 0) {
 			r = res;
 			goto error;
@@ -155,12 +161,21 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 		if (block_offset >= 1 << v->data_dev_block_bits)
 			goto done;
 
-		/* read the next block when we run out of parity bytes */
-		offset += v->fec->roots;
+		/* Read the next block when we run out of parity bytes */
+		offset += (v->fec->roots - par_buf_offset);
+		/* Check if parity bytes are split between blocks */
+		if (offset < v->fec->io_size && (offset + v->fec->roots) > v->fec->io_size) {
+			par_buf_offset = v->fec->io_size - offset;
+			memcpy(par_buf, &par[offset], par_buf_offset);
+			offset += par_buf_offset;
+		} else
+			par_buf_offset = 0;
+
 		if (offset >= v->fec->io_size) {
 			dm_bufio_release(buf);
 
-			par = fec_read_parity(v, rsb, block_offset, &offset, &buf, bio_prio(bio));
+			par = fec_read_parity(v, rsb, block_offset, &offset,
+					      par_buf_offset, &buf, bio_prio(bio));
 			if (IS_ERR(par))
 				return PTR_ERR(par);
 		}
@@ -724,10 +739,7 @@ int verity_fec_ctr(struct dm_verity *v)
 		return -E2BIG;
 	}
 
-	if ((f->roots << SECTOR_SHIFT) & ((1 << v->data_dev_block_bits) - 1))
-		f->io_size = 1 << v->data_dev_block_bits;
-	else
-		f->io_size = v->fec->roots << SECTOR_SHIFT;
+	f->io_size = 1 << v->data_dev_block_bits;
 
 	f->bufio = dm_bufio_client_create(f->dev->bdev,
 					  f->io_size,
-- 
2.45.2


