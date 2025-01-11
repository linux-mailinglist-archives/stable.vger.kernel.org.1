Return-Path: <stable+bounces-108301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA5A0A64B
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 23:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838E01689C8
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 22:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1C31CFBC;
	Sat, 11 Jan 2025 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWCZ2YXY"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E881B78F3
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 22:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736635725; cv=none; b=gv9ingQ/ds2eBnFQf8tmUAXnXQYeO5GacwDLTV0UJ5HJ5VLe40Cq9rrk5YC1kkSndtNNUtq5hyGmaq7JQ/ni6oolriQt2e+yBnqKBgb+88KmagIsAjV6iuzRIkROJ4R9VDYGxMq6PGDOyOGgzv16JVIMdNvpKTeKr7ueJbuMcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736635725; c=relaxed/simple;
	bh=gnM0eqLNkPtGwwdaBxA8poUD5IH2XVtt0V9D2F58TC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7HOFmJU2Rb2HID5EMjmxjo6HD5hgNbtSkgyGDESJTE/uXFRi16FJYCFvCduqFvl6naeZNrlFWMHyic8GSgVwUxo2SklCoTmNuHc6JtBFAKsSj/eCtOKFxMyfaUcN+XcLD0EzqYLmNLlvgtBes2b0vyNcX4T0frJi93kFm06jTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWCZ2YXY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso5273716a12.3
        for <stable@vger.kernel.org>; Sat, 11 Jan 2025 14:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736635722; x=1737240522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74DewVgy1P2KipicwbRfpqvWino/FvgWUBM0hLTHXgY=;
        b=BWCZ2YXYF19tgugqOL/5kjiB88MblX0u9suxNS7DztYKCaiO4JIGQjCnfxHgTIQvhg
         ukjJpHN02fPv60ctxg3ecNGG5OoQQYOBtic4VdAV2yYut/zFCxd3bUNVfVxV3PA4RP7M
         bbHEQzuZJu4uVaJFKEHglMGo3ynSekojqNzW7vXFk1P92gVccA143djAw3f3+2eGi4dc
         oR4mjUxC+5R7k18wwFmaaWYdYmmMlVKgRbcmI+659Id/RHTxSWMN0hKAaRCpL5e+OaBc
         d/Sr4ezJ+sqkr+xQ4RSWAoWqTwUTzwGM3caLMcMqFdzSvjcfFMMinOHVHxTHumE2FLy5
         3xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736635722; x=1737240522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74DewVgy1P2KipicwbRfpqvWino/FvgWUBM0hLTHXgY=;
        b=oerxRkhN5UCOLJBaoTVp8YyPRXkeU4ZiqhUaZvQjjYWyY1uiM5OOt+yfSn6Q1a4Ebb
         Cu7Xn3/CPSlmzM4xjbQUU5U7oy0DLSRC4G/dr7DrjebHKDiYwqObde+sF+A4J1wmb2Q2
         jQcViAS2g6CcyDE+rvDqoixQP8gxM63RCqR7G+nAGNHIuZGrpk/Wq+YWUFvIkBg1iQXS
         kRO+1DBFAAD7SC+MNfRKJCpFRGRvnpiWXaNxPwoscu3Ll7VXuXwDuQaQaQIMeVEkom5U
         PvnKYSeL8EvSvCuBnSNeuNr8dM7rwwJC+Jf81CpF1JrFEflo3y4T02zzGfXXFySFT81P
         v52g==
X-Gm-Message-State: AOJu0YzIPzyH20pYCIK1LIne1Rd5jusAf4gGTvQkxv8bkuzUvDHiVPUd
	+vTbZWiUB5g3xboo8840q8oDM2QhWt7D85R3txA2js/4MWrif0Z1QkGRog==
X-Gm-Gg: ASbGnctKni+NMxMoQhhYEQc/LL2s8w7uQOCoflTP1R/vtSLRHcsmTs/QH6V98/tSL6s
	4GkcjOVJovYsGG/TGEkcwNraD/IM0W1tSHGXTCkUcWrku6PF8xSggl0U2imZANy4i5L4qSaYu5Y
	fNjq7eAb2Pl77r5ZzBxfB66yjCyP0D12hum4XMS6uWiyUyCjHRs63oCTdbcWHhqvfDxjvapx6Ca
	AAwyUHzUfzzp3j+nl8G3bgW/CYIy18GwF1Tc3dwkOGNT1uTHEVCr5IuOuL6Rr72OAr+KuIJcbDV
	ii+zknJqLKptPL7n24KP8p1hP55u9dY4/OOhPcJJpH9WfttTNqZuEoHNeEX/
X-Google-Smtp-Source: AGHT+IErnfZt88p0kWzxDdSY3y5fArWc6MJUJo8LPY45OajSbdkZGPFcwIoLHdEk81ISIByVqM//4w==
X-Received: by 2002:a05:6402:51cf:b0:5d1:22c2:6c56 with SMTP id 4fb4d7f45d1cf-5d972e1be28mr14839519a12.17.1736635721994;
        Sat, 11 Jan 2025 14:48:41 -0800 (PST)
Received: from syrah.mazyland.net (dynamic-2a00-1028-8d1a-5dc6-7184-2e63-0011-e253.ipv6.o2.cz. [2a00:1028:8d1a:5dc6:7184:2e63:11:e253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9900c4b56sm3019748a12.32.2025.01.11.14.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 14:48:41 -0800 (PST)
From: Milan Broz <gmazyland@gmail.com>
To: stable@vger.kernel.org
Cc: Milan Broz <gmazyland@gmail.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.1.y] dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)
Date: Sat, 11 Jan 2025 23:48:33 +0100
Message-ID: <20250111224833.368181-1-gmazyland@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025011142-bladder-elevator-f97f@gregkh>
References: <2025011142-bladder-elevator-f97f@gregkh>
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
index 0304e36af329..9bf48d34ef0f 100644
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


