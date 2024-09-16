Return-Path: <stable+bounces-76180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC05979C00
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646792819D7
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61598131BDD;
	Mon, 16 Sep 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pn9FC1x6"
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDA71739
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471492; cv=none; b=UdY7IEuqwwOxXFB8tTBMhZPebAMhmFgmTbrubM9loyVhMUBotD0c2gZaBZEOgTYez7IWWJG9GIN9s5ZubRepvv06vssGoAGYCVCtsw/rYA4QAysF+2HIyweIpANGgsoeTdZBHELsj5ONNRyQ2DNpIsI4qFzqj1aWKq4YjjJHirM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471492; c=relaxed/simple;
	bh=47xPVJrzm6Sz8Ky0GorJhQI2r9rwb/mpjHTKV1Qxpjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S60YTvPWE+j1pjq6U6a5HWPE3vSRk9SBDlG/MSZDtay+UiwBDMT4aqEdpEaqanznJIVR4Ias5HXUGzXLqhSJOaRMEsHrZtrcWlnBxlaX9Ez+8UwyonZUZklQbqN5h/OhZ/TLuiTKcLuAmdxTYAG8FNRh+yqqQWf0nWk9Jtd/XTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pn9FC1x6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=htINtMKW1HHHTz6jXf4cYaZiT3xsT/nN0J8Q13owBXQ=; b=Pn9FC1x6nnL0y9Cn7Z9N7H7ytU
	cnlXuztesp1Ehje2r9n2mP9UmGrD44lQT6tOQ5ADkWRaKwb8R6I7Tpqg887T3I6M3vWHX2gjKeLVr
	McgOkSWOVNM5zTI6182gNcaJM+eN5U60ysxN4vYhN5f3PPW8dnRw5KHtlOPllrR5ATMEtcKXXsiPw
	rmvmNKdTTSWRBPx/3MJtoWxl9S6n8T32ttqeufOQlPfRXQu85xrXE/oT5jQU4tj3N79sBYNkOEtZo
	FO/40oEM+s/FyGzhKQOq4mHmISg54wN862PYFIhB9dC6ZkjnvzA22QGKPt1pnf4CNL02uqk5DNzB0
	mK4aPqfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sq66E-00000003Iyc-1rAO;
	Mon, 16 Sep 2024 07:24:42 +0000
Date: Mon, 16 Sep 2024 00:24:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ariadne Conill <ariadne@ariadne.space>,
	xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
Message-ID: <ZufdOjFCdqQQX7tz@infradead.org>
References: <20240906184209.25423-1-ariadne@ariadne.space>
 <877cbnewib.wl-tiwai@suse.de>
 <9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
 <ZuK6xcmAE4sngFqk@infradead.org>
 <874j6g9ifp.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j6g9ifp.wl-tiwai@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 16, 2024 at 09:16:58AM +0200, Takashi Iwai wrote:
> Yes, all those are really ugly hacks and have been already removed for
> 6.12.  Let's hope everything works as expected with it.

The code currently in linux-next will not work as explained in my
previous mail, because it tries to side step the DMA API and abuses
get_dma_ops in an unsupported way.


