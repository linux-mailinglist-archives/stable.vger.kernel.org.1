Return-Path: <stable+bounces-248879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO/EI6ZTB2oqywIAu9opvQ
	(envelope-from <stable+bounces-248879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:11:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA0F5548EB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB2CB30756A5
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EB34C6F04;
	Fri, 15 May 2026 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HSv9Vyeu"
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2304C042E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863973; cv=none; b=kwJD98DMv7VJsJF4evmHpOiC/IW7J2EKh/XjbuYMrslTlJesSkiNDvsX1B1J4t32XAWa9RP50RBNCjsECnVPt/jg6YAxOaepQ5lDFuc9UrwLTKjYgLeFhX5DHfp48TOTTnA7Ae7HUxu6ixP4IIqqWQWO7XfAMqM+qhlP9jYoj/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863973; c=relaxed/simple;
	bh=a5TGuieO1EdOH+HQq0dB7K3Y4o8LQ1CXEggScH+bMMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz8zoZL04VlrYDlnuksxKD+eTl3DwMuwwQr4Ql/LJvgX05fGqER15OmFIXiyijJpAHqQoBDdcC8JSsT26USOUXN2nDcZ6iCvEFZyzoosZFj1bn92w8FbA5372+qhkE+G3v8gRxfq3dvWahfRVIQ1vYFOZR6wieLujOTWztk734M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HSv9Vyeu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from ideasonboard.com (unknown [IPv6:2001:b07:6462:5de2:520d:d7a3:63ca:99e8])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9D7BC56D;
	Fri, 15 May 2026 18:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1778863953;
	bh=a5TGuieO1EdOH+HQq0dB7K3Y4o8LQ1CXEggScH+bMMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSv9VyeubgIoKCDhj6wYjVffYv7NaHhKapVFexlCRcredlToH67n9/CgyEdqjY3V7
	 gkKrIrxAnbr7q/IlblqEFMIR+LQx3IRmEHacvVP/ObbpKqMnoBxCtPa3KpnfJTmu3h
	 +qDQBsuyuuiknxN2YTiS4PzvSHkLzMBdWEHDYI00=
Date: Fri, 15 May 2026 18:52:40 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Daniel Scally <dan.scally@ideasonboard.com>, 
	=?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <barnabas.pocze@ideasonboard.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 7.0 016/201] media: mali-c55: Fix wrong comment of ISP
 block types
Message-ID: <agdO8lvv9vj9_1n8@zed>
References: <20260515154658.538039039@linuxfoundation.org>
 <20260515154658.887165119@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260515154658.887165119@linuxfoundation.org>
X-Rspamd-Queue-Id: 4BA0F5548EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248879-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacopo.mondi@ideasonboard.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ideasonboard.com:email,ideasonboard.com:dkim,linuxfoundation.org:email]
X-Rspamd-Action: no action

Hi Greg,

On Fri, May 15, 2026 at 05:47:14PM +0200, Greg Kroah-Hartman wrote:
> 7.0-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>
> commit df16624248296ce4e8890c7ddcc95f0ccb642bcd upstream.
>
> Some bad copy&paste happened in the description of the ISP block types
> and AWB_CONFIG got mixed up with SHADING_CONFIG.
>
> Fix it by assigning to each block the correct type.
>
> As only the comment is changed, there is no uABI breakage or regression.

I know this is borderline for stable, however it's in a uAPI header
so I considered it worth adding stable to the cc list.

If you don't think it's necessary, feel free to drop the patch.

Thanks
   j

>
> Cc: stable@vger.kernel.org
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Reviewed-by: Barnabás Pőcze <barnabas.pocze@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-params.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> index be0e909bcf29..c03a6120ddbf 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
> @@ -43,9 +43,9 @@
>   * @digital_gain:	For header->type == MALI_C55_PARAM_BLOCK_DIGITAL_GAIN
>   * @awb_gains:		For header->type == MALI_C55_PARAM_BLOCK_AWB_GAINS and
>   *			header->type = MALI_C55_PARAM_BLOCK_AWB_GAINS_AEXP
> - * @awb_config:		For header->type == MALI_C55_PARAM_MESH_SHADING_CONFIG
> - * @shading_config:	For header->type == MALI_C55_PARAM_MESH_SHADING_SELECTION
> - * @shading_selection:	For header->type == MALI_C55_PARAM_BLOCK_SENSOR_OFFS
> + * @awb_config:		For header->type == MALI_C55_PARAM_BLOCK_AWB_CONFIG
> + * @shading_config:	For header->type == MALI_C55_PARAM_MESH_SHADING_CONFIG
> + * @shading_selection:	For header->type == MALI_C55_PARAM_MESH_SHADING_SELECTION
>   * @data:		Allows easy initialisation of a union variable with a
>   *			pointer into a __u8 array.
>   */
> --
> 2.54.0
>
>
>

