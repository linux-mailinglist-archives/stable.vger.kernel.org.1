Return-Path: <stable+bounces-122793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15813A5A13C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261D43A8451
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58B231A3B;
	Mon, 10 Mar 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zSF6mGHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3501C4A24;
	Mon, 10 Mar 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629513; cv=none; b=oCdAqc0jn9ygA+VgLEguBYBW4d2zIu6vchmOa9iEA6U8Go2/xty0VoJyas7uJ/XLEob+Kdgv4x6glLZ41aDUhwVSFtmYhn4ncFLeNrNbRzg/AykUhxWWxbdnWfaYV3KI2RSu6OQ6MXS7yu6qUcvNVzr7S2c6khBCFn86V5bl9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629513; c=relaxed/simple;
	bh=ksivJ6YOin3xiOqfs+gEgpw3j5z7K/Q2+mfWz9ROVKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTSzlEpSph8wD4mqMduYxhmj02zwjveRK0Q7kuFz7rZXwzsStS0VB8J7OW3SN73aDGzhMCZBiFyHRAIYYGctjmpBtZe5ohaQglaMV3l2FPTIYz43sb7sHfWAKZoL8r+70zuopXl5eJuNFg82d1iHlllCIvBCk0ACdgo2IdehzTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zSF6mGHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A19C4CEE5;
	Mon, 10 Mar 2025 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741629513;
	bh=ksivJ6YOin3xiOqfs+gEgpw3j5z7K/Q2+mfWz9ROVKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zSF6mGHVGWP4zeCKIiLJKkCqbDR4sA6Z4HpARjQC2E+15pW9zVaJsNfQt20IVHl5D
	 ermoauzZPac6/PKLq5+2R7KtSdngA90cBRpJhUOU4SQKSpRb6atR53/vgBZDdg1kJB
	 ANbfjC16Q0oDCdYgSSlQVQur/pOXIVRhLGNatI8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hou Tao <houtao1@huawei.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 5.15 289/620] dm-crypt: dont update io->sector after kcryptd_crypt_write_io_submit()
Date: Mon, 10 Mar 2025 18:02:15 +0100
Message-ID: <20250310170557.019539057@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

commit 9fdbbdbbc92b1474a87b89f8b964892a63734492 upstream.

The updates of io->sector are the leftovers when dm-crypt allocated
pages for partial write request. However, since commit cf2f1abfbd0db
("dm crypt: don't allocate pages for a partial request"), there is no
partial request anymore.

After the introduction of write request rb-tree, the updates of
io->sectors may interfere the insertion procedure, because ->sectors of
these write requests which have already been added in the rb-tree may be
changed during the insertion of new write request.

Fix it by removing these buggy updates of io->sectors. Considering these
updates only effect the write request rb-tree, the commit which
introduces the write request rb-tree is used as the fix tag.

Fixes: b3c5fd305249 ("dm crypt: sort writes")
Cc: stable@vger.kernel.org
Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-crypt.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1993,7 +1993,6 @@ static void kcryptd_crypt_write_continue
 	struct crypt_config *cc = io->cc;
 	struct convert_context *ctx = &io->ctx;
 	int crypt_finished;
-	sector_t sector = io->sector;
 	blk_status_t r;
 
 	wait_for_completion(&ctx->restart);
@@ -2010,10 +2009,8 @@ static void kcryptd_crypt_write_continue
 	}
 
 	/* Encryption was already finished, submit io now */
-	if (crypt_finished) {
+	if (crypt_finished)
 		kcryptd_crypt_write_io_submit(io, 0);
-		io->sector = sector;
-	}
 
 	crypt_dec_pending(io);
 }
@@ -2024,14 +2021,13 @@ static void kcryptd_crypt_write_convert(
 	struct convert_context *ctx = &io->ctx;
 	struct bio *clone;
 	int crypt_finished;
-	sector_t sector = io->sector;
 	blk_status_t r;
 
 	/*
 	 * Prevent io from disappearing until this function completes.
 	 */
 	crypt_inc_pending(io);
-	crypt_convert_init(cc, ctx, NULL, io->base_bio, sector);
+	crypt_convert_init(cc, ctx, NULL, io->base_bio, io->sector);
 
 	clone = crypt_alloc_buffer(io, io->base_bio->bi_iter.bi_size);
 	if (unlikely(!clone)) {
@@ -2048,8 +2044,6 @@ static void kcryptd_crypt_write_convert(
 		io->ctx.iter_in = clone->bi_iter;
 	}
 
-	sector += bio_sectors(clone);
-
 	crypt_inc_pending(io);
 	r = crypt_convert(cc, ctx,
 			  test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags), true);
@@ -2073,10 +2067,8 @@ static void kcryptd_crypt_write_convert(
 	}
 
 	/* Encryption was already finished, submit io now */
-	if (crypt_finished) {
+	if (crypt_finished)
 		kcryptd_crypt_write_io_submit(io, 0);
-		io->sector = sector;
-	}
 
 dec:
 	crypt_dec_pending(io);



