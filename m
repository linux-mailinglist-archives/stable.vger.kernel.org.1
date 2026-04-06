Return-Path: <stable+bounces-233377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHrSOIO302l+kwcAu9opvQ
	(envelope-from <stable+bounces-233377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 15:39:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4953A39C4
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A30C302205F
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5CC2EA172;
	Mon,  6 Apr 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDK5t7YT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3F92D9ED1;
	Mon,  6 Apr 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482693; cv=none; b=DCLbNYQpV3ijV8/jJrTXKrVx1abVB6BhZu0/FELZ9r7IWSv9d8R8zkM2BN8t6j6bEBbpVVHQzDQtDCw8r2e1uookvwReDr1DCAp4OKv05Wh4qZqUsvWq8+ueunJ46v3FKij3dx78tQVebOS0qp0p2vyDLXiIFcgHWFFijJ/d5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482693; c=relaxed/simple;
	bh=9f1+IanKVd/XJVNM+JocRgqDSvnCXUbrGgLpydGoeKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAdICxLGMdxMmg2EHoabluqKwKPsTLsHhTU7eGgynDOummgdVdw96a5zI+6CZeMhvOKr5IwGDLzVy7VQvkq2KPoYqZNn2oKwq1BEVzgnWuuE/5GaT9++pDlqX4WemchNolCtGvuWR+Wn3U6kGWBi5YCPi2e4/ePYsM2pTQ5j7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDK5t7YT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3371EC4CEF7;
	Mon,  6 Apr 2026 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775482693;
	bh=9f1+IanKVd/XJVNM+JocRgqDSvnCXUbrGgLpydGoeKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bDK5t7YTuBMAo9PQTMhzXtsxuuA7TIHYdXteEB7LQ7i4H9uIz4uR3C1MFG+sg4dgF
	 ihwQHNJJJMdWkQ5t008x/jk/KULPIti5KEfUjgamnxOtivSFLcda5bhM1MD66RuA7B
	 nHqCcqung8SEGJJghWxkwrwaAVPeBKVy+i9tgK3D5hHGC/WFLtWAAjkueaQ6FUpefC
	 8oibaimxaauepHVv/mK/hm17WrpB2NBvv23ZKKa3i4/JVKnfGyh9sAkSb3TYAIn1bY
	 wOCsgGU8dsYPRNuZo1uqua80XOu3cOL5Yu2p0LJn4xf6e+ny9vgjSRj5N61BwIh+Lp
	 1/E1glJwDXZkQ==
Message-ID: <e4090ddb-a237-4d55-b916-ea9ca32d6d98@kernel.org>
Date: Mon, 6 Apr 2026 15:38:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix USB 2.0 HS PHY tuning values for
 Exynos7870
To: =?UTF-8?B?xYF1a2FzeiBMZWJpZWR6acWEc2tp?= <kernel@lvkasz.us>,
 vkoul@kernel.org
Cc: neil.armstrong@linaro.org, alim.akhtar@samsung.com,
 andre.draszik@linaro.org, pritam.sutar@samsung.com, kauschluss@disroot.org,
 johan@kernel.org, ivo.ivanov.ivanov1@gmail.com,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260406070548.132491-1-kernel@lvkasz.us>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260406070548.132491-1-kernel@lvkasz.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233377-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,samsung.com,disroot.org,kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lvkasz.us:email,qualcomm.com:email]
X-Rspamd-Queue-Id: 3B4953A39C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 06/04/2026 09:05, Łukasz Lebiedziński wrote:
> The existing PHYPARAM0 tuning values for Exynos7870 are incorrect,
> causing the USB 2.0 PHY to fail high-speed negotiation and fall back
> to full-speed (12Mbps) operation.
> 
> Fix TXVREFTUNE (transmitter voltage reference) from 14 to 3,
> TXRESTUNE (transmitter impedance) from 3 to 2, and SQRXTUNE
> (squelch threshold) from 6 to 5. Also explicitly set
> TXPREEMPPULSETUNE to 0, which was previously missing from the
> tuning table despite being included in the register mask.
> 
> All values are derived from the vendor kernel for the Samsung
> Galaxy A6 (SM-A600FN), as no public hardware documentation is
> available for the Exynos7870 USB DRD PHY. With these corrections,
> the PHY successfully negotiates high-speed (480Mbps) operation.
> 
> Fixes: 588d5d20ca8d ("phy: exynos5-usbdrd: add exynos7870 USBDRD support")
> Cc: stable@vger.kernel.org
> Tested-by: Łukasz Lebiedziński <kernel@lvkasz.us>

Drop you are the author. This is for 3rd party credits.

> Tested-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> Signed-off-by: Łukasz Lebiedziński <kernel@lvkasz.us>
> ---
>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> index 5a181cb4597e..8711a3b62c8e 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -1958,13 +1958,14 @@ const struct exynos5_usbdrd_phy_tuning exynos7870_tunes_utmi_postinit[] = {
>  			      PHYPARAM0_TXPREEMPAMPTUNE | PHYPARAM0_TXHSXVTUNE |
>  			      PHYPARAM0_TXFSLSTUNE | PHYPARAM0_SQRXTUNE |
>  			      PHYPARAM0_OTGTUNE | PHYPARAM0_COMPDISTUNE),
> -			     (FIELD_PREP_CONST(PHYPARAM0_TXVREFTUNE, 14) |
> +			     (FIELD_PREP_CONST(PHYPARAM0_TXVREFTUNE, 3) |
>  			      FIELD_PREP_CONST(PHYPARAM0_TXRISETUNE, 1) |
> -			      FIELD_PREP_CONST(PHYPARAM0_TXRESTUNE, 3) |
> +			      FIELD_PREP_CONST(PHYPARAM0_TXRESTUNE, 2) |
> +			      FIELD_PREP_CONST(PHYPARAM0_TXPREEMPPULSETUNE, 0) |
>  			      FIELD_PREP_CONST(PHYPARAM0_TXPREEMPAMPTUNE, 0) |
>  			      FIELD_PREP_CONST(PHYPARAM0_TXHSXVTUNE, 0) |
>  			      FIELD_PREP_CONST(PHYPARAM0_TXFSLSTUNE, 3) |
> -			      FIELD_PREP_CONST(PHYPARAM0_SQRXTUNE, 6) |
> +			      FIELD_PREP_CONST(PHYPARAM0_SQRXTUNE, 5) |
>  			      FIELD_PREP_CONST(PHYPARAM0_OTGTUNE, 2) |
>  			      FIELD_PREP_CONST(PHYPARAM0_COMPDISTUNE, 3))),

With tags corrected:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


Best regards,
Krzysztof

