Return-Path: <stable+bounces-268811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VVR1HTtePmqxEgkAu9opvQ
	(envelope-from <stable+bounces-268811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:10:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8066CC4C7
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:10:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=orM0BkuR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268811-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268811-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83FBF30210C3
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36DA3EFFA8;
	Fri, 26 Jun 2026 11:10:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5FE1C84A6;
	Fri, 26 Jun 2026 11:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472230; cv=none; b=ISm73jou+64RxkfUsHOn3tc5Lelrj+aHNnBc1Prq3Y7moZSWZpoBvgngv5v8DM2Y/cCaEMizgB0fea3Q5N0npCIwxNfqmFAtMW9vU/0n4UHFfL+HTYNw/uYaeqGhBFRKxh6BO4LlmjVs6t4Pw8jkCkfMI+vA++9uicmTUtl/LGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472230; c=relaxed/simple;
	bh=BcOwHJCBoHCD/nt/jx+PVcrmEB7h8PTVijZIhVv3P34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DqHbdL1yYq7qAZlsQOjKlWrKlJ6WD1L+Iitjp8KvUvVkKY8sylgQ+VPUrzqE/7JjGJT+LCHGm8Evwn+g29UNfsXrxvWj6Le7uSGxXDDF8CEKZ0ASGMhQw0ITficVvXObL+gFhknRjqeIyZeomIQv8TSCQJLDcTB/z4bcFIJqStw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orM0BkuR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2B61F000E9;
	Fri, 26 Jun 2026 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472229;
	bh=AUAlvBxMc4bt39AC/sKnSSFnKSzDSItRNQY9EFsMK8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=orM0BkuRMVNu0xg5QM0Qz3nJn7sG/5q9c8yQHGAYSEMgq2ZwuHw5D3SIT+gh+NhNO
	 NGIW+AYjUQFDt2KcAGfafHF44nmxOJyvHq73WLrfWTClCjpb/uw0BkwJdLS2S1ujE1
	 sz3N1ICe7QfgsfEafH5CivH1u6UjxsIJ5py8xTXSen9hES8/o8SwcF4FX8cIiEk/OZ
	 ss/DTt6OEgDaMfo+Oqg0IZjMVZYtjhUJ3V2AQwod3baRgRAhTs0cXGr2BS/SqlT3vh
	 p6cKiJIWtup8MdD5ERyKyOmSLgUPMr4eHj0sV/i742eDSOSZk6AjXQBnAETJ2M83NY
	 GRrTvUVIwaabQ==
Date: Fri, 26 Jun 2026 13:10:25 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: pata_pxa: Fix DMA channel leak on probe error
Message-ID: <aj5eIWnpbLDxzK40@ryzen>
References: <20260625141837.62362-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625141837.62362-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:dlemoal@kernel.org,m:linux-ide@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268811-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ryzen:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA8066CC4C7

On Thu, Jun 25, 2026 at 10:18:37PM +0800, Wentao Liang wrote:
> When dmaengine_slave_config() fails, the DMA channel acquired by
> dma_request_chan() is not released before returning the error,
> leaking the channel reference.
> 
> Fix by adding dma_release_channel() in the error path.
> 
> The ata_host_activate() error path already correctly releases the
> DMA channel.
> 
> Cc: stable@vger.kernel.org
> Fixes: 88622d80af82 ("ata: pata_pxa: dmaengine conversion")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/ata/pata_pxa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
> index 03dbaf4a13a7..9f63bdfb8576 100644
> --- a/drivers/ata/pata_pxa.c
> +++ b/drivers/ata/pata_pxa.c
> @@ -286,6 +286,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
>  	ret = dmaengine_slave_config(data->dma_chan, &config);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "dma configuration failed: %d\n", ret);
> +		dma_release_channel(data->dma_chan);
>  		return ret;
>  	}
>  
> -- 
> 2.39.5 (Apple Git-154)
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

