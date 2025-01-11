Return-Path: <stable+bounces-108285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0ECA0A4BE
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 17:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFDE3A11BF
	for <lists+stable@lfdr.de>; Sat, 11 Jan 2025 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035714EC7E;
	Sat, 11 Jan 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qir++l02"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06B114BF8F
	for <stable@vger.kernel.org>; Sat, 11 Jan 2025 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736612395; cv=none; b=h8z1wyWTgsfOfFpdf9VphKjW8LeDdPw+Mz7K1UXjQda8UOxPvseD8vN0imGt3dDU56B0AQmpnlGmp43tjRkKzwuHDoj/+ROx5ASlBevr7w6xBsizVoVPlgwSUtzbzQCRFrBOE9j3WkInIPFTgMrKBZ4skGVClaL321ZLGDBFZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736612395; c=relaxed/simple;
	bh=nPlVIvc/7NP6LeNVlKBzV1j5RYhtr+ryk08NXHj/A4U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=blLz+RjueSbmmqpBfmJxF9diC1j1fs1d2JyOO6Uh2b+2N5fAOC2KGUyg35JBIjBAERhpaRE7lGMP2j8TWagngRpMRbN/pAx0gtPSYAKkPUPmiS7JOHWcFAgwLi2zm3+cd4P6fw/0ahwyNwJnhmsZr8ijOw2B96uMptkLlTrlihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qir++l02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF97C4CED2;
	Sat, 11 Jan 2025 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736612394;
	bh=nPlVIvc/7NP6LeNVlKBzV1j5RYhtr+ryk08NXHj/A4U=;
	h=Subject:To:Cc:From:Date:From;
	b=qir++l02rBBK6e1timmgDcXbb6YPh34i0YA26gfIBTjsm7HCmdcjc47meGxBKi6d+
	 etXEY2yKHI2xlHFlcvpJ1KwDj0HTYVfEzxP1qbjd+fJygYdry/sKsDrJkDbzfTOrxK
	 xlX5scZVt3cpxwqyo2+ggVtKQo4SlaAWzvdz4qCY=
Subject: FAILED: patch "[PATCH] dm-verity FEC: Fix RS FEC repair for roots unaligned to block" failed to apply to 5.10-stable tree
To: gmazyland@gmail.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 11 Jan 2025 17:19:44 +0100
Message-ID: <2025011144-slab-putt-25f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6df90c02bae468a3a6110bafbc659884d0c4966c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011144-slab-putt-25f3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6df90c02bae468a3a6110bafbc659884d0c4966c Mon Sep 17 00:00:00 2001
From: Milan Broz <gmazyland@gmail.com>
Date: Wed, 18 Dec 2024 13:56:58 +0100
Subject: [PATCH] dm-verity FEC: Fix RS FEC repair for roots unaligned to block
 size (take 2)

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


