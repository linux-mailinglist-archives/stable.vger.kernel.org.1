Return-Path: <stable+bounces-262190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id prneBjC2J2rj0wIAu9opvQ
	(envelope-from <stable+bounces-262190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 08:44:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1902A65CE43
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 08:43:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ideasonboard.com header.s=mail header.b=InUzYu6M;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262190-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262190-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ideasonboard.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40D563010229
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 06:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223443BED1F;
	Tue,  9 Jun 2026 06:42:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB81830DD1D;
	Tue,  9 Jun 2026 06:42:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780987357; cv=none; b=jWZWrnEs0ndWckI9lFFpNTmahgB114Z20gwHkXWgTX6wrEoF6618WOtKnrQs9korSknaWiPSiciWOZmiTCcBsy7jvrFVQrcFvqZ2n1siVtu3CJstEzQKn8RjBLD8BwNs53RmM4tb4JpxPN/Hm2vpRkQGuaObBFVNQ4nLRrElbjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780987357; c=relaxed/simple;
	bh=HSP/NBsMCDcgfL85cSYwUJK9bQInZ13SdztQXZx0Zm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGJWM5/izqV3Bh7agZxX8wX+PzRI2rvN6DnHCPbYNKH+aEZ2JEADhjrtmUWvc2orHaygkNpHpq1RD5D03gY2htzWl9znyPmNIYgEDQWplzrVT+PQt/yvfSKwUZVuW5NGj/8hQGIqgBQCnKouiu6WRekq8XBtEvERx6aVyav3TRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=InUzYu6M; arc=none smtp.client-ip=213.167.242.64
Received: from ideasonboard.com (93-46-82-201.ip106.fastwebnet.it [93.46.82.201])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A4315132;
	Tue,  9 Jun 2026 08:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1780987326;
	bh=HSP/NBsMCDcgfL85cSYwUJK9bQInZ13SdztQXZx0Zm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InUzYu6M+NyguTpngErAYGP5/QAwX/5SVP8Al2jJufJ/eOwfFh/fiD04ng5YL7E34
	 NRnltZpskKcU9Y4pRYvFNcJ6dOjd9Cmy5ZaWsZz+lqqsYbRSOvPKZ9ELnNvUVC0qN9
	 rx5zH0S5gxX/3njXNSiWv+1Kd875ENnEdTeLMRSo=
Date: Tue, 9 Jun 2026 08:42:32 +0200
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: David Carlier <devnexen@gmail.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: mali-c55: Fix AEXP IHIST disable bit shift
Message-ID: <aie1vqkd96-8uCmA@zed>
References: <20260609053231.24855-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609053231.24855-1-devnexen@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-262190-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:devnexen@gmail.com,m:dan.scally@ideasonboard.com,m:jacopo.mondi@ideasonboard.com,m:mchehab@kernel.org,m:linux-media@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jacopo.mondi@ideasonboard.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacopo.mondi@ideasonboard.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ideasonboard.com:dkim,ideasonboard.com:email,ideasonboard.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1902A65CE43

Hi David

On Tue, Jun 09, 2026 at 06:32:31AM +0100, David Carlier wrote:
> The post-Iridix auto-exposure histogram disable bit in
> MALI_C55_REG_METERING_CONFIG is bit 16, but MALI_C55_AEXP_IHIST_DISABLE
> was defined with a shift of 12, copied from the AEXP_HIST definition
> above it. As the value is masked with the BIT(16) disable mask when it
> is programmed, the result is always zero and the disable bit is never
> set. The IHIST can therefore never be disabled, neither at ISP init nor
> via a parameters block flagged V4L2_ISP_PARAMS_FL_BLOCK_DISABLE, and the
> hardware keeps producing histogram statistics that userspace believes
> are switched off.
>
> Use a shift of 16 so the disable request takes effect.
>
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/media/platform/arm/mali-c55/mali-c55-registers.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
> index f098effde..4cd13b702 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
> @@ -173,7 +173,7 @@ enum mali_c55_interrupts {
>  #define MALI_C55_AEXP_HIST_SWITCH_MASK			GENMASK(14, 13)
>  #define MALI_C55_AEXP_HIST_SWITCH(x)			((x) << 13)
>  #define MALI_C55_AEXP_IHIST_DISABLE_MASK		BIT(16)
> -#define MALI_C55_AEXP_IHIST_DISABLE			(0x01 << 12)
> +#define MALI_C55_AEXP_IHIST_DISABLE			(0x01 << 16)

Thanks, this indeed was a bad copy and paste I presume
Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

>  #define MALI_C55_AEXP_SRC_MASK				BIT(24)
>
>  #define MALI_C55_REG_TPG_CH0				0x18ed8
> --
> 2.53.0
>

