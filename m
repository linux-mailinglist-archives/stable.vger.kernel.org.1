Return-Path: <stable+bounces-214544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMfWCuHrhGmw6gMAu9opvQ
	(envelope-from <stable+bounces-214544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:13:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1947F6BF0
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 20:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA2463022916
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2327C313E2F;
	Thu,  5 Feb 2026 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AI/GyRR4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FB279DB3;
	Thu,  5 Feb 2026 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318809; cv=none; b=LW+URbp+M5Ij8ACLAOv6ho6vq4SAS7FfXPe8Y0eaGOxoXFG6wZnU/mWxjv5onQXR4FM4ZkrbEVMDzcQcHc2r0t/J+ORXNXYLwAIVpYM92dWFWW6qYagak9DRoR3UH8zWHvuuwKiawIEmy64HL3ChWM1V5VXaAGhLeT45rcZR4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318809; c=relaxed/simple;
	bh=tbP9h1k5B3yJWSPqrDUODMYf9Jvid9ANIt8ghdoN3/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOUcnLE57kZ7nLfM27vi3zayQGYAjG19rn+8EN3VSnt5bcoOO9ucZf5MAt2tuIhlLIinj2oDYu7lC5Aju6rpnSJDPwU5ltC69e8YLnWmBYB3ojNyGMM2UAUWiklIh7f44/C+iiT4G6Ryo2cp570X2wUSUTq8w1Rk1oxU7APTP7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AI/GyRR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E43C4CEF7;
	Thu,  5 Feb 2026 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770318809;
	bh=tbP9h1k5B3yJWSPqrDUODMYf9Jvid9ANIt8ghdoN3/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AI/GyRR4yvA9o/8v/j3DAv1n0c0wPVbf55qafkDTFU5w3mONpCZRxgiUFwTMdj33B
	 dOXHBJz+KmjxOnBPPVja8barysKJoc2t106sUK/chAc6kY+ieKa4pMnfQq9rihtmpa
	 YCVLEoxSr0Sl1hIO5rFZ77RV401EPxvAl+dwDuHTFEcx/fGKd4FxIo9JG9mUn5+QUE
	 yS25l4NNgd1XjMWbTUab23E0kZ18/KcWg2tfS4t97yayAdSWe5PyteWkAcvtjeEV5M
	 V+tEDa6XPMBhicd1k+xeCSxdLq+k5EBOBcXQGyk5Cs3BlQ13b84uR+f7h+MsviPDay
	 Du6MM8YpKTzBA==
Date: Thu, 5 Feb 2026 19:13:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Remi Buisson <remi.buisson@tdk.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: inv_icm45600: fix INT1 drive bit inverted
Message-ID: <20260205191321.7e5f7b49@jic23-huawei>
In-Reply-To: <20260205-inv-icm45600-fix-int1-drive-bit-v3-1-9c60c354dadb@tdk.com>
References: <20260205-inv-icm45600-fix-int1-drive-bit-v3-1-9c60c354dadb@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214544-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,jean-baptiste.maneyrol.tdk.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tdk.com:email]
X-Rspamd-Queue-Id: D1947F6BF0
X-Rspamd-Action: no action

On Thu, 05 Feb 2026 17:59:14 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> Drive bit must be set for open-drain mode and be cleared for push-pull
> mode.
> 
> Referring to datasheet DS-000576_ICM-45605.pdf section 17.23
> INT1_CONFIG2.
> 
> Fixes: 06674a72cf7a ("iio: imu: inv_icm45600: add buffer support in iio devices")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Cc: stable@vger.kernel.org
Applied to the fixes-togreg branch of iio.git. Note that has a
random base at the moment, so I'll wait for release or rc1 and then
rebase on that before pushing out.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Add precisions in datasheet reference
> - Add missing reviewed-by tag
> - Link to v2: https://lore.kernel.org/r/20260205-inv-icm45600-fix-int1-drive-bit-v2-1-5e72608ea154@tdk.com
> 
> Changes in v2:
> - Add datasheet precision where to find the bits
> - Link to v1: https://lore.kernel.org/r/20260205-inv-icm45600-fix-int1-drive-bit-v1-1-72a78cd07150@tdk.com
> ---
>  drivers/iio/imu/inv_icm45600/inv_icm45600.h      | 2 +-
>  drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600.h b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> index c5b5446f6c3b43150512bcc4357cee385080b634..1c796d4b2a4038203f734f80d7bf7bad138c3497 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600.h
> @@ -205,7 +205,7 @@ struct inv_icm45600_sensor_state {
>  #define INV_ICM45600_SPI_SLEW_RATE_38NS			0
>  
>  #define INV_ICM45600_REG_INT1_CONFIG2			0x0018
> -#define INV_ICM45600_INT1_CONFIG2_PUSH_PULL		BIT(2)
> +#define INV_ICM45600_INT1_CONFIG2_OPEN_DRAIN		BIT(2)
>  #define INV_ICM45600_INT1_CONFIG2_LATCHED		BIT(1)
>  #define INV_ICM45600_INT1_CONFIG2_ACTIVE_HIGH		BIT(0)
>  #define INV_ICM45600_INT1_CONFIG2_ACTIVE_LOW		0x00
> diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> index ab1cb7b9dba435a3280e50ab77cd16e903c7816c..b028044d609a41f6d4b747383323130ded0d2e79 100644
> --- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> +++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
> @@ -637,8 +637,8 @@ static int inv_icm45600_irq_init(struct inv_icm45600_state *st, int irq,
>  		break;
>  	}
>  
> -	if (!open_drain)
> -		val |= INV_ICM45600_INT1_CONFIG2_PUSH_PULL;
> +	if (open_drain)
> +		val |= INV_ICM45600_INT1_CONFIG2_OPEN_DRAIN;
>  
>  	ret = regmap_write(st->map, INV_ICM45600_REG_INT1_CONFIG2, val);
>  	if (ret)
> 
> ---
> base-commit: d820183f371d9aa8517a1cd21fe6edacf0f94b7f
> change-id: 20260205-inv-icm45600-fix-int1-drive-bit-7d12ea3e2cd2
> 
> Best regards,


