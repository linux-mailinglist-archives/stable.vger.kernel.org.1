Return-Path: <stable+bounces-217315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ereRK1AMlmlKZQIAu9opvQ
	(envelope-from <stable+bounces-217315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 20:00:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BBA158D77
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 20:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53C0C3006B5E
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 19:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964532D0C79;
	Wed, 18 Feb 2026 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="au14phct"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4F238C29
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771441228; cv=none; b=nu3L1/oWG4rQGTmjdaJCrjMQjxdnUzmw11ROkg9SZl8liIzfnJ9KShby7PBaGeaauRm5fAkhJpe8NzcReEPXJ83Gsfgya59Uf5+iI1ZOkVUkLCTsaQo4lTDZgB8irb5VbViAu85/+Zpn6jf+wIY4lQt0IZauH+lSwcZG1089AGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771441228; c=relaxed/simple;
	bh=OQSdv3sYVoVHJFv6CIsqAmFjzui75wTfaJCKVOLrrzQ=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtSeXKROzh+iLZtF5WXRjnLMPQ7od+ot9xVVvOHAZjRiT+rBhrS2hIrNUTJCNblGDs616RJH9bFtAXrKtHoEgtqV9jzixV7ZVhpjSOj/YsTpW3DkhHxOBG3dbhlCqCKodXyL+p/onfmqNswpdJATP+h8QuB5lZAg+ImWLeyRluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=au14phct; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-387114fdbedso1711921fa.2
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 11:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1771441225; x=1772046025; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=52zs4H7SRmeATE57nBs4ZjTnQbfu33snwasVpXdlcKk=;
        b=au14phctH1HpaFkC2iXb21utpG/aJooDMu6GajrPJD3ApazOM1+bSOQ4MzE8P+Mh+r
         DvJTJG9BFBbYAbCxfarEFHb/EKb+F4Y3lbSQ0687T4GCoTzmMsbr1A11hvUlsHGrHmO6
         MN8t12wwdfx4E8FK0x4223DoO/f6qYBZSSdcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771441225; x=1772046025;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52zs4H7SRmeATE57nBs4ZjTnQbfu33snwasVpXdlcKk=;
        b=WPCAd8FIiAHbFqXapY3nzEyCGnlDZRvVTbpt5ouV3KDGrdydRPHtCu980zbue2IJty
         I2zB7ZnH+RxTU+bZ4jV3YUBfkjyexficP+6H5q7PLfdqOjsix7x+UvmipmXV6Vhl7KPL
         dIQt9ykdweBQWOSW1gSWUK7zRyAPcovCUc9SgZTPMH7Sl8/8iGBrSkkvjQBnfQ9kvHF8
         RPyLrCXGnOAzVCf+GHeYvL0K9pDD1igEosR97r24ZUfoBTphZ2nHktxwmKqurK1nxTZv
         Ob9dX1JxoQ8nP6kE2P/yrZuGkebGGG+7ByBgza0TMMFxTsQvTgfCUzy3W9nx7ClUyBfF
         4b/Q==
X-Gm-Message-State: AOJu0YyrnaO1tFOSu+fTaQhQbPugHtvPxp9f83c+nVEUYHSdrfWIARAw
	aCXRYdv5qeXbEWxShlIjbPI3JeTAnCyNgZZfaAtbhi3So/t1N8j2EmF6KMoFTbaphvjg4kLPKR+
	AaVak
X-Gm-Gg: AZuq6aLc1E7PgXjgSJkX8oPP3kZc8LfPqoxC96jN4U2RCqXkLd+NvhvFH1RTpNQPH0Q
	+y1PupFnnqbnZbkfMp4xIhmEZfCvLLDUpiln9vVkNfdBDjfMfgfFJugtfglgqpOZ+YMoJTwEiI4
	n+CJ3d/2r9qGxtxjKqPNoP8IWekylMcmfjbIfmwG3jF7HHrsgxa3484/ufLj+lYRQNcfBSrgm/0
	irHNawjHV4BUkxc9nZc+tlzX+ouAT2ADh662U9j2PXg8fBbrZM20r/zwZRE7HlLbLKyc3cFGglq
	diT1AWQpsfWsguyLAKyOU5KokXY1d9kG9nRLXhdNsGUBNaU1L4JF9SZtTiQAowayCQNT93gjxvL
	JX5K01EEQEFvkBau0avbeLPDhtdceLt0n17UUx4ug5POvu1K6bEfanT9GFwT9WI99vh93gf063F
	rcxRIaYGOKgFRPtjywnO8FEMi3+eqYob5PeoODszkGLp351QMYLHuYk30PuK88b6h8dJqzr9ekz
	Vcj2yxu2qcMasgwuTc1hOZPHuKWYPPLxgpzYpcCdgbJhjQCpRgNr5gJyYl7jWLMuw==
X-Received: by 2002:a05:651c:1587:b0:385:dde5:1bf3 with SMTP id 38308e7fff4ca-387e8efe3b8mr52276911fa.6.1771441225156;
        Wed, 18 Feb 2026 11:00:25 -0800 (PST)
Received: from ?IPV6:2a01:cb05:94a2:a200:2ad9:827a:59cb:148a? (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr. [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38706905f98sm41905581fa.30.2026.02.18.11.00.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 11:00:24 -0800 (PST)
Message-ID: <de3a26eb-1852-4873-a274-efa8bda47e7e@smile.fr>
Date: Wed, 18 Feb 2026 20:00:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update delay select values
 for MMC1/2 subsystems
Cc: stable@vger.kernel.org
References: <20260218184854.1731826-1-romain.naour@smile.fr>
From: Romain Naour <romain.naour@smile.fr>
Content-Language: fr, en-US
In-Reply-To: <20260218184854.1731826-1-romain.naour@smile.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_TO(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[smile.fr,reject];
	R_DKIM_ALLOW(-0.20)[smile.fr:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[smile.fr:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217315-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.naour@smile.fr,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,4fb0000:email,ti.com:url,4f98000:email]
X-Rspamd-Queue-Id: 34BBA158D77
X-Rspamd-Action: no action

Hello,

Le 18/02/2026 à 19:48, Romain Naour a écrit :
> Update the delay values for legacy and high speed modes, based on
> the latest revised datasheet SPRSP36K released in April 2024 [1].
> 
>   (MMC1/2 - SD/SDIO Interface): Updated/Changed the
>   "OTAPDLYENA, DELAY ENABLE" and "OTAPDLYSEL, DELAY VALUE" for the
>   Default Speed and High Speed modes from "0x0" to "0x1"
> 
> The previous SPRSP36J datasheet recommends to set ti,otap-del-sel-sd-hs
> value to 0 for MMC1 and MMC2 interfaces. These values were updated in
> kernel 6.5. As a result we have some occasional regression with ultra
> high speed DDR50 SDXC cards while mounting the rootfs:
> 
>   mmc1: error -110 whilst initialising SD card
> 
> A similar issue may occur with u-boot after a reboot while
> initialising the SD card:
> 
>   mmc_init: -110, time 67
> 
> [1] Table 6-86. MMC1/2 DLL Delay Mapping for All Timing Modes, in
> https://www.ti.com/lit/ds/symlink/tda4vm.pdf,
> (SPRSP36K – SEPTEMBER 2021 – REVISED APRIL 2024)
> 
> Cc: stable@vger.kernel.org # 6.5+

Please, ignore this patch for now.
It was sent by mistake.

Best regards,
Romain


> Fixes: af398252d68e ("arm64: dts: ti: k3-j721e-main: Update delay select values for MMC subsystems")
> Signed-off-by: Romain Naour <romain.naour@smile.fr>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index d5fd30a01032..418e6010ef1f 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1643,8 +1643,8 @@ main_sdhci1: mmc@4fb0000 {
>  		clocks = <&k3_clks 92 5>, <&k3_clks 92 0>;
>  		assigned-clocks = <&k3_clks 92 0>;
>  		assigned-clock-parents = <&k3_clks 92 1>;
> -		ti,otap-del-sel-legacy = <0x0>;
> -		ti,otap-del-sel-sd-hs = <0x0>;
> +		ti,otap-del-sel-legacy = <0x1>;
> +		ti,otap-del-sel-sd-hs = <0x1>;
>  		ti,otap-del-sel-sdr12 = <0xf>;
>  		ti,otap-del-sel-sdr25 = <0xf>;
>  		ti,otap-del-sel-sdr50 = <0xc>;
> @@ -1671,8 +1671,8 @@ main_sdhci2: mmc@4f98000 {
>  		clocks = <&k3_clks 93 5>, <&k3_clks 93 0>;
>  		assigned-clocks = <&k3_clks 93 0>;
>  		assigned-clock-parents = <&k3_clks 93 1>;
> -		ti,otap-del-sel-legacy = <0x0>;
> -		ti,otap-del-sel-sd-hs = <0x0>;
> +		ti,otap-del-sel-legacy = <0x1>;
> +		ti,otap-del-sel-sd-hs = <0x1>;
>  		ti,otap-del-sel-sdr12 = <0xf>;
>  		ti,otap-del-sel-sdr25 = <0xf>;
>  		ti,otap-del-sel-sdr50 = <0xc>;


