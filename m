Return-Path: <stable+bounces-16041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678583E880
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C8F1C227AA
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28EA635;
	Sat, 27 Jan 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jNdx9ozR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3728E6
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 00:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706315716; cv=none; b=hrTjWfs7TMP4HkxAh6OJ3kRLhCFHLIerVfVF+3f5k6r6a7tcbnsa907BPUi7ekWbEBw8o3BqdLKUwlae83jfZ6z4oCe73IFtvUQeshvl0jDIQf0idhy7QFKF0db9U3EHYDZH3Q6QUYnN1dWCnQviflJThnn0kZ7+vWTw5QglD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706315716; c=relaxed/simple;
	bh=fUrdat8KdA6Jyp77IRytZ+BgoCNIsywCAFvHbHyuIyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/C3gp4JgpQpbC3p2+IDk0D6+o5JjLpMt9mENWlmsVoDekday8oe6yHgvu/j04FC+pKLW6h394u4rMuQ0TgdC0SvhpNnpuJIk/ZutXK2Rixt9sq2tMTWUEttKmclCSegvVTwIov6S2SbfohzPB+ZsLVinsNzOwT4GsNQAVCBsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jNdx9ozR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34C8C433C7;
	Sat, 27 Jan 2024 00:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706315716;
	bh=fUrdat8KdA6Jyp77IRytZ+BgoCNIsywCAFvHbHyuIyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNdx9ozRTxh+MHqjdKQe4WIuwq7Wz/Yc5ZfapIQ8dIzXoVV7gsCgAvlvJi5oslb5g
	 MqIk8DljuTRVcH5T3nlabdT1644MOgiCCthYPbVyRv/NT7ceq7aGpGN7TVZiq2eccu
	 /GGEhP+k1qM/BfKbdbGirEBYUwcKjCyJrEI8mdcM=
Date: Fri, 26 Jan 2024 16:35:15 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Jaime Liao <jaimeliao.tw@gmail.com>, jaimeliao@mxic.com.tw,
	stable@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] mtd: spinand: macronix: Fix MX35LFxGE4AD page size
Message-ID: <2024012606-stylist-alabaster-b300@gregkh>
References: <20240125024816.222554-1-jaimeliao.tw@gmail.com>
 <20240125100820.174eb458@xps-13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240125100820.174eb458@xps-13>

On Thu, Jan 25, 2024 at 10:08:20AM +0100, Miquel Raynal wrote:
> Hi Jaime,
> 
> + linux-mtd which was missing to your contribution.
> 
> jaimeliao.tw@gmail.com wrote on Thu, 25 Jan 2024 10:48:16 +0800:
> 
> > From: JaimeLiao <jaimeliao@mxic.com.tw>
> > 
> > Support for MX35LF{2,4}GE4AD chips was added in mainline through
> > upstream commit 5ece78de88739b4c68263e9f2582380c1fd8314f.
> > 
> > The patch was later adapted to 5.4.y and backported through
> > stable commit 85258ae3070848d9d0f6fbee385be2db80e8cf26.
> > 
> > Fix the backport mentioned right above as it is wrong: the bigger chip
> > features 4kiB pages and not 2kiB pages.
> > 
> > Fixes: 85258ae30708 ("mtd: spinand: macronix: Add support for MX35LFxGE4AD")
> > Cc: stable@vger.kernel.org # v5.4.y
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> 
> Looks legitimate.
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> > ---
> > Hello,
> > 
> > This is my third attempt to fix a stable kernel. This patch is not a
> > backport from Linus' tree per-se, but a fix of a backport. The original
> > mainline commit is fine but the backported one is not, we need to fix
> > the backported commit in the 5.4.y stable kernel, and this is what I am
> > attempting to do. Let me know if further explanations are needed.
> > 
> > Regards,
> > Jaime
> > ---
> >  drivers/mtd/nand/spi/macronix.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
> > index bbb1d68bce4a..f18c6cfe8ff5 100644
> > --- a/drivers/mtd/nand/spi/macronix.c
> > +++ b/drivers/mtd/nand/spi/macronix.c
> > @@ -125,7 +125,7 @@ static const struct spinand_info macronix_spinand_table[] = {
> >  		     SPINAND_HAS_QE_BIT,
> >  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
> >  	SPINAND_INFO("MX35LF4GE4AD", 0x37,
> > -		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> > +		     NAND_MEMORG(1, 4096, 128, 64, 2048, 40, 1, 1, 1),
> >  		     NAND_ECCREQ(8, 512),
> >  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> >  					      &write_cache_variants,
> 
> 
> Thanks,
> Miquèl
> 

Now queued up, thanks.

greg k-h

