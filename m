Return-Path: <stable+bounces-15474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C15838564
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CD01C29EB8
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081D44C79;
	Tue, 23 Jan 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nlKGtDr4"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F74C67
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976126; cv=none; b=ugay2Dsf5XdsIYoqvKcy0PGJ1z3voVIE1kPJSoRx/kZLcqn0AdLW/hsRTMWTrGg3e49nBHrGAVteVQ3XXBzHYtlxsRC8YO75OWa+nNfkDuqs6DaemDS9GZAAZXwbh444doY7APEuSH7zTXPXEmzPB//UpHlZywmTp2LCfJMPN20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976126; c=relaxed/simple;
	bh=vTM+qdRWpkFtLvMvHNTBzx/MmYnqVDYqkcAx+LICs/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG1S8uyHySaLI2A1p6cZryCfqCc6BZBqF3PeIA1OCvO0f/8KvS8U7M2RQQbPmQj4uVzxsAbZcD03KcDT3z+dMMSSkIV16QuZaJ/kYH/mzhFSG8eG3iX+RAWGoTPgyUF7Nrb1TjUbiAdOcL196gOM39oikrexwKHQkeK0Ln6Tsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nlKGtDr4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g7FH/38QWfK7nQuKl2D+jAs/PaEeIZnXyIux3FL5Vys=; b=nlKGtDr4Za+evEHUjSGLw/21kh
	0DidIC8nW425tCXkUqCKEKuTNS26GEnPSizGatuMHA4mjHEsshEVXmDmeLDhAIiT33P6ARZT4558v
	mmiZgOiRcab/vrAMLb7uwLgtvCBHa/fuHaePx6oEvmXp9Bm9HjRFLk3BOw2F+hQyKgNv+DjmteNLW
	rZhmM6U+MXhv4/nTT6Siu/maLFkdfrtnFj7f5HB3vxaZtHCsPZYzADuXscMowBmf1RmGC24krNdhM
	bLnVqetVk5ufzElxL+SDsoYSIQxySMhaWGZuv/mPLdmzqwTpHcSJOmQqWGBdMJ339NC4apon9tLuP
	WtCGTqow==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rS6Ju-00000001sQr-3ex4;
	Tue, 23 Jan 2024 02:15:22 +0000
Date: Tue, 23 Jan 2024 02:15:22 +0000
From: Matthew Wilcox <willy@infradead.org>
To: gregkh@linuxfoundation.org
Cc: akpm@osdl.org, axboe@kernel.dk, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] block: Remove special-casing of compound
 pages" failed to apply to 4.19-stable tree
Message-ID: <Za8hOgYxV3Y8Jnqo@casper.infradead.org>
References: <2024012229-dealer-luster-6ff4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024012229-dealer-luster-6ff4@gregkh>

On Mon, Jan 22, 2024 at 11:31:29AM -0800, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

and here's the one for 4.19

diff --git a/block/bio.c b/block/bio.c
index 7858b2d23916..476a88e11715 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1592,8 +1592,7 @@ void bio_set_pages_dirty(struct bio *bio)
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, i) {
-		if (!PageCompound(bvec->bv_page))
-			set_page_dirty_lock(bvec->bv_page);
+		set_page_dirty_lock(bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(bio_set_pages_dirty);
@@ -1652,7 +1651,7 @@ void bio_check_pages_dirty(struct bio *bio)
 	int i;
 
 	bio_for_each_segment_all(bvec, bio, i) {
-		if (!PageDirty(bvec->bv_page) && !PageCompound(bvec->bv_page))
+		if (!PageDirty(bvec->bv_page))
 			goto defer;
 	}
 

