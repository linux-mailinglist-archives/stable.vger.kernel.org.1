Return-Path: <stable+bounces-241201-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LBZM2K67mnqxAAAu9opvQ
	(envelope-from <stable+bounces-241201-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 03:22:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710E46BE1F
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 03:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CDA1300C001
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 01:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AF202F71;
	Mon, 27 Apr 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0EnkfuD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB5175A81;
	Mon, 27 Apr 2026 01:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777252958; cv=none; b=XwEqjfzfa2I+IPaxu+/cmxn7cRGSCGuHqFmXQmZG5NGJ/DmngbtI2z+ADWdTgz4Re2MF6RpMbhc+sYa/bEjaiX8ZdkdekCVV2/5qfFn+4H96YJJfOzf8AkyBQHnztDl+1AmGJ9BKyOEkJ2Dkr3gm+iDk1BkU98MZ3kdYCTfDjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777252958; c=relaxed/simple;
	bh=BX2k3FegiT32JzBDbtax9RMlTkcLecybywnZHE8gaZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljakW/5d4lBvll4WIUuFv12j7kN4hFORkdIf+DWccc+PzOxYxAcZCSPzTWYiHhfTgh2//+tDa71O0VXSx2QUji8GOqGqL8dUIMt8Qa6TauINOTmgtx4UsQlpVpTIyDIr6C6IgehzPQUchmc43Y4CuC8hRSVi0tboIDS7WbxWfX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0EnkfuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55B1C2BCAF;
	Mon, 27 Apr 2026 01:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777252958;
	bh=BX2k3FegiT32JzBDbtax9RMlTkcLecybywnZHE8gaZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0EnkfuDHwk9kVnmr/AtkHvJi+lCHl8Udshb3TzJ784jps1WlWfhmhbKnoLcExi38
	 VBBnan8jXt0nuoUwCJiO4T/ardJo9M5s2t/XrJ7glnlmfPfna75N15LWsPbVGD5Mzy
	 SSbzS4XG6IFDI1UyMRmNGafYwy2DCuhZM75ZHcj5p4A2T5K9kjy3vfrllKbrRtP67w
	 DCnFuOZ1wfGDF27/9fI+Tepjm3YuzBFIvt35daqI24TP4+3nAozdpFhKoE1Iaj7sEb
	 ADWZfB/Ohcso+uPZGcDkknJk0ZiqrrilMclLDlXa+TEwD2nYo8YrxRYTpdkajqTkC7
	 bl+uxULiq3a+A==
Date: Mon, 27 Apr 2026 09:22:34 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Yongchao Wu <yongchao.wu@autochips.com>, pawell@cadence.com
Cc: rogerq@kernel.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: gadget: fix request skipping after clearing
 halt
Message-ID: <ae66WphA+lO6t3rE@nchen-desktop>
References: <20260423160601.2949010-1-yongchao.wu@autochips.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260423160601.2949010-1-yongchao.wu@autochips.com>
X-Rspamd-Queue-Id: 3710E46BE1F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241201-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,autochips.com:email]

On 26-04-24 00:06:01, Yongchao Wu wrote:
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
> As shown above, the DMA pointer jumped to index 3 (offset 0x30), causing
> the controller to skip the initial TRBs of the request. This leads to
> data misalignment and ADB protocol hangs on macOS.

Pawel, Is it a hardware issue? The cycle bit has already been toggled
before the endpoint has been reset, why the DMA pointer still advances?

Peter

> 
> Fix this by manually restoring the EP_TRADDR register to the starting
> physical address of the current request after the EPRST operation is
> complete.
> 
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Cc: stable@vger.kernel.org
> Cc: Peter Chen <peter.chen@kernel.org>
> Signed-off-by: Yongchao Wu <yongchao.wu@autochips.com>
> ---
>  drivers/usb/cdns3/cdns3-gadget.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> index d59a60a16ec77..96653c7d18f20 100644
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
> 

-- 

Best regards,
Peter

