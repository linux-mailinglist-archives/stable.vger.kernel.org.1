Return-Path: <stable+bounces-267899-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dENBBItMOmpP5gcAu9opvQ
	(envelope-from <stable+bounces-267899-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:06:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5779E6B5920
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 11:06:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZCddekKJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267899-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267899-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56D1030C0179
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 09:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20C93C6611;
	Tue, 23 Jun 2026 09:00:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB803CF200;
	Tue, 23 Jun 2026 08:59:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205201; cv=none; b=KSE1JrwrxPrDPBphjrDM8nU3EFJ4UpyioqnBpxFb4vTbz9G0NALMc68xx+6kaAeII6MFwYmL9zjQbpx1RezVK8NB+Lq0PMo7lmr41j+YSJu4g0Qer+UQWgHvhzGE3ewe7ieFxePt10xE3HVH3A/Y9qw+r9P7pF1qsx2XcIff/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205201; c=relaxed/simple;
	bh=0GU9LIMJY50aIaiYHYc+NTnY9K6OdMdQEpFxEubWTJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrDfTKIBIGg+nsMi7qLMuX3/rezY4XJh3Fyh+eoMhoGTZGO5o3e2P4ZtPBIFbhqT5QriruPK4x9IxC7AiAadCntjhEhoV0uCItBB/6vE9tTxMTMLiCoOODApAhIdbNernvUAO+gRsjFlJWRrpIR9OCmKNAlvhiH2dJcuuWZYHo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCddekKJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B271F000E9;
	Tue, 23 Jun 2026 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205195;
	bh=CZJDMKie+kghBH4XpQ8XcibyOPE/XQSoQlDLMtsEl4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZCddekKJeKhGUvYTJgXy9VoBpK1WCBwH238B5Ov4bM/rLsaZmhsVB3PYh7W4Q1EKE
	 6ILnKu1bv0n1xn54jX3aHNp+JzxMQUm5CKebOTP5r2qifBmSUj4O+LuNsy8GBwA7M8
	 MiQazGMT1kWNjDHx35ledoiyrRVsAjmbdWO51zyyD7hGf44VB3jwpoj6J7cmTW7rRs
	 SPOy360WTGEWlK8dGCqvKRFXp+sMLTsD6bDf+8x9c8U0wBhRWN0XC20ET9UCg98BPY
	 Ua43fgAGAS6tgec2DXPOnz3b/NZYnd4OvIfHYLCkJToAZfIEy+gYKw4l9uuMPHCTRU
	 y8HTEz5/Syhww==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wbwz3-00000000Zgb-0NSv;
	Tue, 23 Jun 2026 10:59:53 +0200
Date: Tue, 23 Jun 2026 10:59:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev,
	Masayuki Ohtake <masa-korg@dsn.okisemi.com>,
	Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
	Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH 5.15 323/411] spi: topcliff-pch: fix controller
 deregistration
Message-ID: <ajpLCYZ3eQm5p64L@hovoldconsulting.com>
References: <20260616145100.376842714@linuxfoundation.org>
 <20260616145118.324999322@linuxfoundation.org>
 <d23a21f0-95dd-4e0c-845e-2a54c50f44eb@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23a21f0-95dd-4e0c-845e-2a54c50f44eb@oracle.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267899-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:harshit.m.mogalapalli@oracle.com,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:masa-korg@dsn.okisemi.com,m:ramanan.govindarajan@oracle.com,m:broonie@kernel.org,m:sashal@kernel.org,m:vegard.nossum@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hovoldconsulting.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5779E6B5920

On Fri, Jun 19, 2026 at 06:08:40PM +0530, Harshit Mogalapalli wrote:
> Hi Greg/Sasha,
> 
> On 16/06/26 20:29, Greg Kroah-Hartman wrote:
> > 5.15-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Johan Hovold <johan@kernel.org>
> > 
> > [ Upstream commit 5d6f477d6fc0767c57c5e1e6f55a1662820eef87 ]
> > 
> > Make sure to deregister the controller before disabling and releasing
> > underlying resources like interrupts and DMA during driver unbind.
> > 
> 
> ^^ let us remember this -- deregister before releasing irqs.
> 
> > Fixes: e8b17b5b3f30 ("spi/topcliff: Add topcliff platform controller hub (PCH) spi bus driver")
> > Cc: stable@vger.kernel.org	# 2.6.37
> > Cc: Masayuki Ohtake <masa-korg@dsn.okisemi.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > Link: https://patch.msgid.link/20260414134319.978196-8-johan@kernel.org
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > [ renamed spi_controller_*(data->host) calls to spi_master_*(data->master) ]
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/spi/spi-topcliff-pch.c |    7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > --- a/drivers/spi/spi-topcliff-pch.c
> > +++ b/drivers/spi/spi-topcliff-pch.c
> > @@ -1450,11 +1450,16 @@ static void pch_spi_pd_remove(struct pla
> >   		free_irq(board_dat->pdev->irq, data);
> >   	}
> ^^^ let us remember this.
> 
> >   
> > +	spi_master_get(data->master);
> > +
> > +	spi_unregister_master(data->master);
> > +
> >   	if (use_dma)
> >   		pch_free_dma_buf(board_dat, data);
> >   
> >   	pci_iounmap(board_dat->pdev, data->io_remap_addr);
> > -	spi_unregister_master(data->master);
> > +
> > +	spi_master_put(data->master);
> >   }
> 
> 
> I ran an AI assisted backport review over the 5.15.210 queue and then
> checked this one manually. I think the 5.15.y backport keeps the API 
> mapping, but not the upstream teardown ordering.
> 
> Upstream 5d6f477d6fc0 unregisters the controller before the local teardown:
> 
>          spi_controller_get(data->host);
> 
>          spi_unregister_controller(data->host);
> 
>          if (use_dma)
>                  pch_free_dma_buf(board_dat, data);
>          ...
>          pch_spi_free_resources(board_dat, data);
>          /* disable interrupts & free IRQ */
>          if (data->irq_reg_sts) {
>                  /* disable interrupts */
>                  pch_spi_setclr_reg(data->host, PCH_SPCR, 0, PCH_ALL);
>                  data->irq_reg_sts = false;
>                  free_irq(board_dat->pdev->irq, data);
>          }
> 
> 
> In final 5.15.y, the equivalent spi_master_get()/spi_unregister_master()
> still happens after queue/status teardown, pch_spi_free_resources(), IRQ
> disable, and free_irq():
> 
>          pch_spi_free_resources(board_dat, data);
>          if (data->irq_reg_sts) {
>                  pch_spi_setclr_reg(data->master, PCH_SPCR, 0, PCH_ALL);
>                  data->irq_reg_sts = false;
>                  free_irq(board_dat->pdev->irq, data);
>          }
> 
>          spi_master_get(data->master);
> 
>          spi_unregister_master(data->master);
> 
> The spi_master_* names are equivalent wrappers for the controller APIs 
> in 5.15.y, but the call placement is still the old ordering. That leaves 
> child SPI devices registered while the driver has already started 
> tearing down controller resources.
> 
> I think for 5.15.y we should fix the backport by moving spi_master_get() 
> and spi_unregister_master() before the local queue/resource/IRQ teardown 
> in pch_spi_pd_remove(), thoughts?

I agree, this backport looks wrong.

This is probably an effect of

	9d72732fe70c ("spi: topcliff-pch: fix use-after-free on unbind")

being backported before

	9d72732fe70c ("spi: topcliff-pch: fix use-after-free on unbind")

due to the latter first failing to apply because of the SPI API rename.

Johan

