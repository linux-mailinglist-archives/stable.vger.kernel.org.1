Return-Path: <stable+bounces-260648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NYizCK57Imr4YAEAu9opvQ
	(envelope-from <stable+bounces-260648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 09:33:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222D64602A
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 09:33:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=CYx9P3lL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260648-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260648-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29DC33033AF2
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 07:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE947798A;
	Fri,  5 Jun 2026 07:31:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7402142315C;
	Fri,  5 Jun 2026 07:31:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644689; cv=none; b=CQ8RdNssMMog/R9zH1mTUvbqnajlUMZY0Og6w7azMnGamj/CXVMbWSvrS2/S/uCtsuXJClk5YhzaKebgxM4EGPxfkDTUZgAsMfO2MLSmZZKamQy7h/Nd7oQA8TAfoYTnN6KhHsLwYerxTjAgN/3oVMRBigjmuyqsG00DfV8swDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644689; c=relaxed/simple;
	bh=X/Uwg7EAprjn29vGoCPyrsDva4WLvnzDbK4puoRgW1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsN/PjR+hovBvAN/2Nz/jqG482yrohtbB/DYXkYiLOeJemwViPeA7TItvUxnW0KMDFWY9A4E2GkkO1VrIfxAlbXkuv9Kc5HU7O27udsPxf+l/iOxXI/JsxqBVEOduy8v7DgTOIwPSnqzp/DPn8+4JPSNQ2kwtAjXMou+N7dIOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CYx9P3lL; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X/Uwg7EAprjn29vGoCPyrsDva4WLvnzDbK4puoRgW1w=; b=CYx9P3lL312mmP2nhMr0NfxStS
	rwYeMw8laC9guLknZ2aPOtNcMbLZfNb9W0WHoZUzZ4WUy3d7plRjaWB3ER7IeqsbP6slh4vtNCRJq
	Y/8q9URjV6BbwXkJLLWsJFqol1Yl6orYLyZWA2RmX30/9JoI6L8SHLlBdNK4iGh1jMii+Qu4Zx82A
	gZDwLHxRkGb6XU6HUYCEXXGc4jN6RmtVbm+8SxHNF/UWEGzIfbNojcJUbDGwsQO3kMY6UJIQO3GKm
	HyDoZ8GYwqrZayc3j/TDDxZVXndgMbkGBH1sNKXaLF7j8oznSLsK2FsOLku83NaJBfUapHDfwWGss
	NCOV/XBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVP1b-00000000EoY-36qG;
	Fri, 05 Jun 2026 07:31:28 +0000
Date: Fri, 5 Jun 2026 00:31:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] block/fops: fix refcount underflow in
 __blkdev_direct_IO()
Message-ID: <aiJ7T7M2v7x9jGsJ@infradead.org>
References: <20260603021035.3690601-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603021035.3690601-1-vulab@iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-260648-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,infradead.org:mid,infradead.org:from_mime,infradead.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8222D64602A

On Wed, Jun 03, 2026 at 02:10:35AM +0000, Wentao Liang wrote:
> __blkdev_direct_IO() calls bio_get() and bio_put() around
> I/O operations, but if the I/O fails, the error path may call
> bio_put() twice, causing a refcount underflow.

What I/O failure do you observe?


