Return-Path: <stable+bounces-108300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4358BA0A64A
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 23:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5BA3A75D5
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB21B78F3;
	Sat, 11 Jan 2025 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/kqeQkS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA41BDABE
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736635581; cv=none; b=TZejkw/AKHalLyo9TcxLE8VrJ/gkFJ/9k0gg49SHlCwFNQi197tVi4dScFl5B4py6Jaz1mk9ChUMTtZorM3pS7XVYH761Kt1zlVYiPAmoxyMIVxWT2fLwOeOwUrqoAAZWefRlAyZJM5K722U2srs8hMmvESgqFcCykj8KNX8BkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736635581; c=relaxed/simple;
	bh=5ECvf1u9NHmptKLz+HAxIkJeWXHN12pXL8jKOi/J4fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mh0yJZTNePd3upRZKereTpIF45nauXU+0lo28EL8kubcTTy/nGJ06rLZS+FTiRr3ccOPiD067s9Mq7k0Q3EIw+6xoqN2Z8u9EcyIj2oUJ+IlIDl2XHrW/x2UT3jyl+e8mgGWH+RRSeP26j0Evx5UPqk/SJKWKNWkiKny4Ntkl0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/kqeQkS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so647820566b.3
        for <stable@vger.kernel.org>; Sat, 11 Jan 2025 14:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736635578; x=1737240378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWAacD2f2PnfEMnthYEkcBhO/G94GxLgXO3vunFs1vI=;
        b=d/kqeQkSucM0OpY5f4XXhKUV3NrzpQUnzRl5edKGRd9Wy6pSzqZ9P5TJxnwA5pd08D
         GjKPTsaig9rHXrC3/k1+dNbdsE9nki9nBEhSuNc0V5O1pToCSozaBDR48W7nyRXJZH9P
         NEHJABHxKABRRuZdB/BApbdCtIe+7vGHmq/CohbfpQaqW/JZobS5uZnc2HZReGtGbfIo
         m4yixqpQrrK9kU9noBLLP9P/AV+X8PeZy8WKKk98moTyOwx/MOXjJwrdXnOa6vGdlmWP
         XiZnBD/KN899IksuA5kqqq+omDu44SywZwUhVkzqGHYgHVQOxwwEagMkt4ZVpNzswElq
         hILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736635578; x=1737240378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWAacD2f2PnfEMnthYEkcBhO/G94GxLgXO3vunFs1vI=;
        b=sau5bppAoF/H9E/KPbOieFzk/JFxfohZzK0Rfapx72ta5Tq2GrxNoBAloG3PEgRZnT
         UwRiBhHm/jpkKnD6nPSusjliBK1Sp6CccHVIxMLli28Zd7tHVlDE6FZJC8g7QhrL651d
         TAXMSld2lrLd0zsLBgQgPzOzHRXfVJXY9YLBMyKbD5FBPng25j9XHvZF+tJULgoCrFTB
         uFfiTDBfc7sUPGPBu1fCem077T10GRcgBdlJeoHzBRLy5JGZNfXemfwCgGJYqHHbPHGZ
         8dtXIy9A3Iqio34Rs/AexNtLR00Mnl8blm9sCMHxyGyErYsgOla7p/6GaGhl+O5wOrDV
         yI9g==
X-Gm-Message-State: AOJu0YxUjbQOfQf/+O3mAd9M3PTGAG45N0uqcMVr6Vc7LXmBaTdeYFsU
	c5OpQoH6o4wnplW7NBFOwb5qNAKSqWvHmU8wBWUNPu8lVLgIkyfWaxNgYg==
X-Gm-Gg: ASbGncvaCaK4N9etpW6vzpWIPTWwVkIS3/BvedSQHf//ysG8Ic9c3vjbCZYI1extGm2
	p6bG2UBAXMvVS3c52YL9WZMp3EqRUvsrATW8i7T6h9JJNwq6SrxJLq7rCF1gfdk7r9ZPOj1CdZj
	zasybtvziJbf/uM9NSf23N7B8FOSvBqMawOiOBm++lJVfrzcBJVKUTfv6fIUHuAKS1bYgUpnTJC
	uh+/Jt7eoDFiXSg67DXaV01UwzVjMFF6pyUyzy5YPxu2KVoEEL8W+bZeFu6H/XFpi161mX32rM/
	b4vkVqOQ8YTFTRDKAU9+oGHp8LtbGAE8Kdd47Y9009Sxgbat+cjn7Wlp/k3A
X-Google-Smtp-Source: AGHT+IFNhozb9byfT0UjM/uh4uu+CJoV51sT/k9h8RUQ6jeje1NOIXKkoOTCs3zMj/BfP2y+ERp57A==
X-Received: by 2002:a17:907:971e:b0:aa6:aedb:6030 with SMTP id a640c23a62f3a-ab2ab70a9a2mr1331042666b.52.1736635577805;
        Sat, 11 Jan 2025 14:46:17 -0800 (PST)
Received: from syrah.mazyland.net (dynamic-2a00-1028-8d1a-5dc6-7184-2e63-0011-e253.ipv6.o2.cz. [2a00:1028:8d1a:5dc6:7184:2e63:11:e253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9646be5sm316502366b.174.2025.01.11.14.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 14:46:17 -0800 (PST)
From: Milan Broz <gmazyland@gmail.com>
To: stable@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.6.y] dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)
Date: Sat, 11 Jan 2025 23:45:54 +0100
Message-ID: <20250111224554.368020-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025011140-scope-tasting-d3ad@gregkh>
References: <2025011140-scope-tasting-d3ad@gregkh>
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
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
(cherry picked from commit 6df90c02bae468a3a6110bafbc659884d0c4966c)
Signed-off-by: Milan Broz <gmazyland@gmail.com>
---
 drivers/md/dm-verity-fec.c | 39 +++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index b475200d8586..6a7a17c489c9 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -60,14 +60,19 @@ static int fec_decode_rs8(struct dm_verity *v, struct dm_verity_fec_io *fio,
  * to the data block. Caller is responsible for releasing buf.
  */
 static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
-			   unsigned int *offset, struct dm_buffer **buf)
+			   unsigned int *offset, unsigned int par_buf_offset,
+			  struct dm_buffer **buf)
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
 
 	res = dm_bufio_read(v->fec->bufio, block, buf);
 	if (IS_ERR(res)) {
@@ -127,10 +132,11 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
 {
 	int r, corrected = 0, res;
 	struct dm_buffer *buf;
-	unsigned int n, i, offset;
-	u8 *par, *block;
+	unsigned int n, i, offset, par_buf_offset = 0;
+	u8 *par, *block, par_buf[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN];
 
-	par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
+	par = fec_read_parity(v, rsb, block_offset, &offset,
+			      par_buf_offset, &buf);
 	if (IS_ERR(par))
 		return PTR_ERR(par);
 
@@ -140,7 +146,8 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
 	 */
 	fec_for_each_buffer_rs_block(fio, n, i) {
 		block = fec_buffer_rs_block(v, fio, n, i);
-		res = fec_decode_rs8(v, fio, block, &par[offset], neras);
+		memcpy(&par_buf[par_buf_offset], &par[offset], v->fec->roots - par_buf_offset);
+		res = fec_decode_rs8(v, fio, block, par_buf, neras);
 		if (res < 0) {
 			r = res;
 			goto error;
@@ -153,12 +160,21 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_fec_io *fio,
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
 
-			par = fec_read_parity(v, rsb, block_offset, &offset, &buf);
+			par = fec_read_parity(v, rsb, block_offset, &offset,
+					      par_buf_offset, &buf);
 			if (IS_ERR(par))
 				return PTR_ERR(par);
 		}
@@ -743,10 +759,7 @@ int verity_fec_ctr(struct dm_verity *v)
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
2.47.1


