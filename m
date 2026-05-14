Return-Path: <stable+bounces-247087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPmrLGQpBWpUTAIAu9opvQ
	(envelope-from <stable+bounces-247087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:46:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C4B53CD50
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CE6E3041AA5
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351182FDC30;
	Thu, 14 May 2026 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIZ5fl0p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2073F413A;
	Thu, 14 May 2026 01:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723141; cv=none; b=Ku/fk31OIXmh1kGR3cDZXXF9J/BP5uzxFwh0M6Rdb644nG4cR2W3qeMaUvoh5TRpSSU4etIviqKrxmVDFQYy+JaODp9/TbGQ6DLrl5Tpit/vvFJXaznOYS0pWzkhOQ2NOZH4zdASldai1mQiYCYVoFf/QIZpsuT+inZsTcdTvRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723141; c=relaxed/simple;
	bh=OKZBTuubcnx61C6WF0CQOVi9ssqx+yDjRXq5orDqNQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot9HcT8kLg8n9vPf6VQmpOVW9/g+PGx5hm6Fw17XbMNtzhmWfujCxS8PBGPScLRwaXqsVS71o9u5OuwFefL6edLo8PjW/6QBjB3iYNZ+CoI3/ZjSp814jgzBpsRCXGCt6HIpCNOPoPgcUh86tF4LjKsx6/kOipaCmDI4bEvdS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIZ5fl0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B6BC2BCB8;
	Thu, 14 May 2026 01:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723140;
	bh=OKZBTuubcnx61C6WF0CQOVi9ssqx+yDjRXq5orDqNQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIZ5fl0pnLB/glGp54uoPNQ3pZnp0a9wa4PmyCXacCfni0j8QvvMxBqMtGVVXwZtL
	 1AVyyc7zp6TgxSJjW4C1xEMN4SPh/j90QNMeobq30Sg3suw1CLDTZyYg+ySwecu0L9
	 0kBxt7kLVlh5Q1oE+uH7rftHWurxVK8tFJXAHwb1P0QexWSWTALb+wNGJ3OBsSJzE5
	 VKoEUduWKrbm8lqGUASCjqVYzNr6cWcjK/WtgRZdo4klTkYDB9pQYpd7h+OSIrNMg0
	 rLd3znCSUFmXj9qCqjcJo4mmA3ePp385FTWrsZAWVO7DVvx6k3ra7KAcT19OwE4grh
	 HbPHzHWBUbk7A==
Date: Thu, 14 May 2026 09:45:37 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Yongchao Wu <yongchao.wu@autochips.com>
Cc: pawell@cadence.com, rogerq@kernel.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: gadget: fix request skipping after
 clearing halt
Message-ID: <agUpQURk02hAYz2Z@nchen-desktop>
References: <4cbc0a7f-19e6-4ce5-b36e-079e4cb22086@autochips.com>
 <20260513160012.2547894-1-yongchao.wu@autochips.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513160012.2547894-1-yongchao.wu@autochips.com>
X-Rspamd-Queue-Id: 15C4B53CD50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247087-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 26-05-14 00:00:12, Yongchao Wu wrote:
> According to the cdns3 datasheet, the EPRST (Endpoint Reset) command
> causes the DMA engine to reposition its internal pointer to the next
> Transfer Descriptor (TD) if it was already processing one.
> 
> This issue is consistently observed during the ADB identification
> process on macOS hosts, where the host issues a Clear_Halt. Although
> commit 4bf2dd65135a ("usb: cdns3: gadget: toggle cycle bit before reset
> endpoint") attempted to avoid DMA advance by toggling the cycle bit,
> trace logs show that on certain hosts like macOS, the DMA pointer
> (EP_TRADDR) still shifts after EPRST:
> 
>   cdns3_ctrl_req: Clear Endpoint Feature(Halt ep1out)
>   cdns3_doorbell_epx: ep1out, ep_trbaddr f9c04030  <-- Should be f9c04000
>   cdns3_gadget_giveback: ep1out: req: ... length: 16384/16384
> 
> As shown above, the DMA pointer jumped to the next TD, causing
> the controller to skip the initial TRBs of the request. This leads to
> data misalignment and ADB protocol hangs on macOS.
> 
> Fix this by manually restoring the EP_TRADDR register to the starting
> physical address of the current request after the EPRST operation is
> complete.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Cc: stable@vger.kernel.org
> Cc: Peter Chen <peter.chen@kernel.org>
> Signed-off-by: Yongchao Wu <yongchao.wu@autochips.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
> Changes in v2:
> - Clarified in description that the DMA pointer jumps to the next TD,
> skipping the entire request.
> - No code changes.
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index d59a60a16ec770..96653c7d18f202 100644
> --- a/drivers/usb/cdns3/cdns3-gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -2814,9 +2814,19 @@ int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
>  	priv_ep->flags &= ~(EP_STALLED | EP_STALL_PENDING);
>  
>  	if (request) {
> -		if (trb)
> +		if (trb) {
>  			*trb = trb_tmp;
>  
> +			/*
> +			 * Per datasheet, EPRST causes DMA to reposition to the next TD.
> +			 * Manually reset EP_TRADDR to the current TRB to prevent
> +			 * the hardware from skipping the interrupted request.
> +			 */
> +			writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma +
> +						priv_req->start_trb * TRB_SIZE),
> +						&priv_dev->regs->ep_traddr);
> +		}
> +
>  		cdns3_rearm_transfer(priv_ep, 1);
>  	}
>  
> 
> base-commit: 46b513250491a7bfc97d98791dbe6a10bcc8129d
> -- 
> 2.43.0
> 

-- 

Best regards,
Peter

