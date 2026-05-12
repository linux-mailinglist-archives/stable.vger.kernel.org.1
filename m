Return-Path: <stable+bounces-245653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OUWMB86A2r81wEAu9opvQ
	(envelope-from <stable+bounces-245653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:33:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F8522969
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE6DD30AE980
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1593A7192;
	Tue, 12 May 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGcSmFaq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE323A4256
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594550; cv=none; b=dAJMiJVNr+TOiB2xjkVhh+4bKNlNw7dlmYmORLX+DKBFEgtNDcGu9NLg0jhYOjgxIeqmBTeoZ0AVd+dP24eEZDH6m9mJGKyAfEQr9bukYX5RGtqO98qHdeyoq03d01051s3rdHJz6y0skKe/rJPg0mLDt9spwVIByS+l2vAa9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594550; c=relaxed/simple;
	bh=2oxbpBd65xfcFUBivNCqgvlXh8v35fuk3fay6z3QXmA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FyM7rmwH1UkDSL4JLRdfFU7Nvj+tZ+kfA3DvA7ZphaATKaIH/HgPxp8YpM0df9cwu/+YSDsXsyefYZpx51AEJrewEclUVmwT5iEgNem4wbEjqw7CnkbEwT8BpdiROeXfqnlKQqf+7g3A7MYDutKqeqRmnSzKnMIhgMXmpiags9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGcSmFaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9121C2BCF5;
	Tue, 12 May 2026 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594550;
	bh=2oxbpBd65xfcFUBivNCqgvlXh8v35fuk3fay6z3QXmA=;
	h=Subject:To:Cc:From:Date:From;
	b=AGcSmFaqNzvxQ6TeNy89ReJxXzTKX3Ls7eU2kmGQfYlPXPejWrh1oPZ9VJQBnLNuZ
	 OYPRRef+vT3dw9SqfOddEtSfcRMhnydHTheFGfG/YwQidcjDosGYZ6YuOiA0UZT//B
	 j/jiB5Lv8gFjXiFhKQt+hrUeWSThryzSUYwsH+Hk=
Subject: FAILED: patch "[PATCH] dm-verity-fec: fix reading parity bytes split across blocks" failed to apply to 6.18-stable tree
To: ebiggers@kernel.org,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:00:04 +0200
Message-ID: <2026051204-outpost-catching-0850@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E62F8522969
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245653-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 430a05cb926f6bdf53e81460a2c3a553257f3f61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051204-outpost-catching-0850@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 430a05cb926f6bdf53e81460a2c3a553257f3f61 Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 5 Feb 2026 20:59:24 -0800
Subject: [PATCH] dm-verity-fec: fix reading parity bytes split across blocks
 (take 3)

fec_decode_bufs() assumes that the parity bytes of the first RS codeword
it decodes are never split across parity blocks.

This assumption is false.  Consider v->fec->block_size == 4096 &&
v->fec->roots == 17 && fio->nbufs == 1, for example.  In that case, each
call to fec_decode_bufs() consumes v->fec->roots * (fio->nbufs <<
DM_VERITY_FEC_BUF_RS_BITS) = 272 parity bytes.

Considering that the parity data for each message block starts on a
block boundary, the byte alignment in the parity data will iterate
through 272*i mod 4096 until the 3 parity blocks have been consumed.  On
the 16th call (i=15), the alignment will be 4080 bytes into the first
block.  Only 16 bytes remain in that block, but 17 parity bytes will be
needed.  The code reads out-of-bounds from the parity block buffer.

Fortunately this doesn't normally happen, since it can occur only for
certain non-default values of fec_roots *and* when the maximum number of
buffers couldn't be allocated due to low memory.  For example with
block_size=4096 only the following cases are affected:

    fec_roots=17: nbufs in [1, 3, 5, 15]
    fec_roots=19: nbufs in [1, 229]
    fec_roots=21: nbufs in [1, 3, 5, 13, 15, 39, 65, 195]
    fec_roots=23: nbufs in [1, 89]

Regardless, fix it by refactoring how the parity blocks are read.

Fixes: 6df90c02bae4 ("dm-verity FEC: Fix RS FEC repair for roots unaligned to block size (take 2)")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 1e776e0d6be5..e5d38bb3f16f 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -33,36 +33,6 @@ static inline u64 fec_interleave(struct dm_verity *v, u64 offset)
 	return offset + mod * (v->fec->rounds << v->data_dev_block_bits);
 }
 
-/*
- * Read error-correcting codes for the requested RS block. Returns a pointer
- * to the data block. Caller is responsible for releasing buf.
- */
-static u8 *fec_read_parity(struct dm_verity *v, u64 rsb, int index,
-			   unsigned int *offset, unsigned int par_buf_offset,
-			   struct dm_buffer **buf, unsigned short ioprio)
-{
-	u64 position, block, rem;
-	u8 *res;
-
-	/* We have already part of parity bytes read, skip to the next block */
-	if (par_buf_offset)
-		index++;
-
-	position = (index + rsb) * v->fec->roots;
-	block = div64_u64_rem(position, v->fec->io_size, &rem);
-	*offset = par_buf_offset ? 0 : (unsigned int)rem;
-
-	res = dm_bufio_read_with_ioprio(v->fec->bufio, block, buf, ioprio);
-	if (IS_ERR(res)) {
-		DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
-		      v->data_dev->name, (unsigned long long)rsb,
-		      (unsigned long long)block, PTR_ERR(res));
-		*buf = NULL;
-	}
-
-	return res;
-}
-
 /* Loop over each allocated buffer. */
 #define fec_for_each_buffer(io, __i) \
 	for (__i = 0; __i < (io)->nbufs; __i++)
@@ -102,15 +72,29 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 {
 	int r, corrected = 0, res;
 	struct dm_buffer *buf;
-	unsigned int n, i, j, offset, par_buf_offset = 0;
+	unsigned int n, i, j, parity_pos, to_copy;
 	uint16_t par_buf[DM_VERITY_FEC_RSM - DM_VERITY_FEC_MIN_RSN];
 	u8 *par, *block;
+	u64 parity_block;
 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
-	par = fec_read_parity(v, rsb, block_offset, &offset,
-			      par_buf_offset, &buf, bio->bi_ioprio);
-	if (IS_ERR(par))
+	/*
+	 * Compute the index of the first parity block that will be needed and
+	 * the starting position in that block.  Then read that block.
+	 *
+	 * io_size is always a power of 2, but roots might not be.  Note that
+	 * when it's not, a codeword's parity bytes can span a block boundary.
+	 */
+	parity_block = (rsb + block_offset) * v->fec->roots;
+	parity_pos = parity_block & (v->fec->io_size - 1);
+	parity_block >>= v->data_dev_block_bits;
+	par = dm_bufio_read_with_ioprio(v->fec->bufio, parity_block, &buf,
+					bio->bi_ioprio);
+	if (IS_ERR(par)) {
+		DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
+		      v->data_dev->name, rsb, parity_block, PTR_ERR(par));
 		return PTR_ERR(par);
+	}
 
 	/*
 	 * Decode the RS blocks we have in bufs. Each RS block results in
@@ -118,8 +102,32 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	 */
 	fec_for_each_buffer_rs_block(fio, n, i) {
 		block = fec_buffer_rs_block(v, fio, n, i);
-		for (j = 0; j < v->fec->roots - par_buf_offset; j++)
-			par_buf[par_buf_offset + j] = par[offset + j];
+
+		/*
+		 * Copy the next 'roots' parity bytes to 'par_buf', reading
+		 * another parity block if needed.
+		 */
+		to_copy = min(v->fec->io_size - parity_pos, v->fec->roots);
+		for (j = 0; j < to_copy; j++)
+			par_buf[j] = par[parity_pos++];
+		if (to_copy < v->fec->roots) {
+			parity_block++;
+			parity_pos = 0;
+
+			dm_bufio_release(buf);
+			par = dm_bufio_read_with_ioprio(v->fec->bufio,
+							parity_block, &buf,
+							bio->bi_ioprio);
+			if (IS_ERR(par)) {
+				DMERR("%s: FEC %llu: parity read failed (block %llu): %ld",
+				      v->data_dev->name, rsb, parity_block,
+				      PTR_ERR(par));
+				return PTR_ERR(par);
+			}
+			for (; j < v->fec->roots; j++)
+				par_buf[j] = par[parity_pos++];
+		}
+
 		/* Decode an RS block using Reed-Solomon */
 		res = decode_rs8(fio->rs, block, par_buf, v->fec->rsn,
 				 NULL, neras, fio->erasures, 0, NULL);
@@ -134,26 +142,6 @@ static int fec_decode_bufs(struct dm_verity *v, struct dm_verity_io *io,
 		block_offset++;
 		if (block_offset >= 1 << v->data_dev_block_bits)
 			goto done;
-
-		/* Read the next block when we run out of parity bytes */
-		offset += (v->fec->roots - par_buf_offset);
-		/* Check if parity bytes are split between blocks */
-		if (offset < v->fec->io_size && (offset + v->fec->roots) > v->fec->io_size) {
-			par_buf_offset = v->fec->io_size - offset;
-			for (j = 0; j < par_buf_offset; j++)
-				par_buf[j] = par[offset + j];
-			offset += par_buf_offset;
-		} else
-			par_buf_offset = 0;
-
-		if (offset >= v->fec->io_size) {
-			dm_bufio_release(buf);
-
-			par = fec_read_parity(v, rsb, block_offset, &offset,
-					      par_buf_offset, &buf, bio->bi_ioprio);
-			if (IS_ERR(par))
-				return PTR_ERR(par);
-		}
 	}
 done:
 	r = corrected;


