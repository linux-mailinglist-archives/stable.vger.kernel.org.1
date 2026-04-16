Return-Path: <stable+bounces-238343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JDgBLgf4Wl0pQAAu9opvQ
	(envelope-from <stable+bounces-238343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:43:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF694131E4
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 19:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DB2B30193A5
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462E33290B9;
	Thu, 16 Apr 2026 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTopU5F3"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFE2F7462;
	Thu, 16 Apr 2026 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776361396; cv=none; b=GXN5Go2zoSS+glqGgj6eLMUPsQZ+UGuyuQpojcmM6KWQYHukRjDbjh3fAHfnxFfWYnx66qlfw4mggDeg+Rh3ULpCh/QsUBpIVr1m7+QtyZ8u4T79z8oNj0kywWoXhePMQEFNX3wpSMMRo/CYYw/d7AYVV4dLfij9RwGaxzbXYR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776361396; c=relaxed/simple;
	bh=goHtxLkJvMZ1Jfuq95Zfv9KGVUKJ9m0SbkTFoBUu5NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yj9qaQXzgvnbthysxQZr00P2LqZGksW3UnmUoNN8sGPLqEAu0XxfqElTbSVubUN+T0ehGX0LoajAxZ90qrXY0Lg3oPYtciRxuROmY2P1VuhE5ExTUwzuelTGb0uLgh6dAEddubWh/AT7co9r3/Ags0E/8c3oHj9cJj3aCEOfNKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aTopU5F3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=goHtxLkJvMZ1Jfuq95Zfv9KGVUKJ9m0SbkTFoBUu5NM=; b=aTopU5F3NxQRF5/1M3KAZrO9T2
	SyRk7xB2Rt6NhaGt9bb34i2rTDd9sYttJmd1yTVzq3lLG+kOcs456trn9S3m9cNktGoGTWsfOITOj
	TZyHFf6rtLcl2Jy6zVVQbmpNgcHYj+IL/1ecwy+IyICBoeqgOyNO/+Qff2af/Sd4aijd7qcsucGvH
	JTYhzZLmsl2H71ZhLN3F0kUD/rSBVvDx3JaihB4OpauH0gworFtikZHfpN+UVMrj6vR64vO4YGKXD
	5CNW7fazvhz5XXH42QR88GGCO/V3vAq09k5kN2p4YIC8ipgECMgF9+qtU9Iz93iL9QRosUnTKnUcl
	+b6wMtsA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDQk5-00000001y7C-1dqJ;
	Thu, 16 Apr 2026 17:43:05 +0000
Date: Thu, 16 Apr 2026 18:43:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Hannes Reinecke <hare@suse.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] [SCSI] advansys: fix host resource leak in EISA probe
 error path
Message-ID: <aeEfqbaI6LNObJAC@casper.infradead.org>
References: <20260416165935.3958686-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416165935.3958686-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238343-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 9DF694131E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 12:59:35AM +0800, Guangshuo Li wrote:
> A manual code audit found that advansys_eisa_probe() frees saved
> Scsi_Host objects directly in its error path.

I've been told all your patches are AI slop, I'm not reviewing this.

