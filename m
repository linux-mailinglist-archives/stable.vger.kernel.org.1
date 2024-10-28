Return-Path: <stable+bounces-88691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69C59B2711
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E31B1F247FA
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF1E18EFD6;
	Mon, 28 Oct 2024 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O4GfYUr9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32C2AF07;
	Mon, 28 Oct 2024 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097904; cv=none; b=Mc8cQk/xqzuuFrDF7BvmngBnbp3bmdCuGazJkcRlKY9AfUZcyZxpXUxR+7ffLifKVLLfDqaL8b4iLYvFJ2WT3Zvl0llOSXF/I/NpYA507oOYS47vbY62dNl2qLKmUPDU3VgrpaZkB2i1uzTuAZWsUdqzOBQlYXziNSkAXl50SvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097904; c=relaxed/simple;
	bh=SiD7FJhfgW+qhc7xzHxZ4BiFPXIgKHALW5X5uO4qjQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJWJKClFCFPLH5rWPJtvlFQYiOiH0anzYoPKjmgELSYTCVJXTOkSU5yeJWJ5vh0uNe5Nq8RnqIrklzFh034EvP3pDRRDFW6Xkk23XMBI+8O6JK1+UtJDkmHziWLa+5nrQb89CJI0BUmYlNGRDSAJAqfv7PIrLRJOGtvLt3RzzgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O4GfYUr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB29C4CEC3;
	Mon, 28 Oct 2024 06:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097904;
	bh=SiD7FJhfgW+qhc7xzHxZ4BiFPXIgKHALW5X5uO4qjQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4GfYUr9aSNewyDeysiYMyizW0pvLHlLeMf1fB3Yb58t8qJ7rENWQ97mei4GhzfGS
	 TVVgD51OiRkcczNCNJZWpgELNWodS4/vsUUTOWsN7/qjHJjEal2CKF3K+JuUz1NYnt
	 0YyO4RWvdvmWCC+ATldKFBfi38Kc1I1NGp7G7Y8s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xinyu Zhang <xizhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 199/208] block: fix sanity checks in blk_rq_map_user_bvec
Date: Mon, 28 Oct 2024 07:26:19 +0100
Message-ID: <20241028062311.538282727@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xinyu Zhang <xizhang@purestorage.com>

commit 2ff949441802a8d076d9013c7761f63e8ae5a9bd upstream.

blk_rq_map_user_bvec contains a check bytes + bv->bv_len > nr_iter which
causes unnecessary failures in NVMe passthrough I/O, reproducible as
follows:

- register a 2 page, page-aligned buffer against a ring
- use that buffer to do a 1 page io_uring NVMe passthrough read

The second (i = 1) iteration of the loop in blk_rq_map_user_bvec will
then have nr_iter == 1 page, bytes == 1 page, bv->bv_len == 1 page, so
the check bytes + bv->bv_len > nr_iter will succeed, causing the I/O to
fail. This failure is unnecessary, as when the check succeeds, it means
we've checked the entire buffer that will be used by the request - i.e.
blk_rq_map_user_bvec should complete successfully. Therefore, terminate
the loop early and return successfully when the check bytes + bv->bv_len
> nr_iter succeeds.

While we're at it, also remove the check that all segments in the bvec
are single-page. While this seems to be true for all users of the
function, it doesn't appear to be required anywhere downstream.

CC: stable@vger.kernel.org
Signed-off-by: Xinyu Zhang <xizhang@purestorage.com>
Co-developed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Fixes: 37987547932c ("block: extend functionality to map bvec iterator")
Link: https://lore.kernel.org/r/20241023211519.4177873-1-ushankar@purestorage.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-map.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -600,9 +600,7 @@ static int blk_rq_map_user_bvec(struct r
 		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
 			goto put_bio;
 		if (bytes + bv->bv_len > nr_iter)
-			goto put_bio;
-		if (bv->bv_offset + bv->bv_len > PAGE_SIZE)
-			goto put_bio;
+			break;
 
 		nsegs++;
 		bytes += bv->bv_len;



