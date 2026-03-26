Return-Path: <stable+bounces-230457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NetM+ApxWkU7QQAu9opvQ
	(envelope-from <stable+bounces-230457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:43:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386C335604
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8A830480B8
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4343F8DF1;
	Thu, 26 Mar 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZZYgoI3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D4364E8E
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528496; cv=pass; b=sxuP+PrNhOIAXalxzHGGHLinWaQHhMJ5saNjmr3udwJlcB+IhUsMchPr3HgrzTw9eRUB2xhY9JHfoEgOFuJMRV5E4As1eEFxs9bXMe8SOru0khXV+PVm+l9EN0ISYmPlsx1StsgxM/xJuf364P5LIAb9rvqgGGsfEt3qt234J5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528496; c=relaxed/simple;
	bh=p+oFtCDEdez9suBe9pe1fZYHjfKOx23fi/EG0H17aGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFkEruigKp3QQzYr1KpBVcO98xKdy5gYqDa9DMT76sAUKH7+GPCDea+merdmt5jQmog84SxiPZ4/TERfJngo6zyWt9MMT8TXMv+13JfY1ukLFD3Q6thJQuA6bOZj0e0KwXpg/VPI3Y/v9BWdvCb+Rle6FWGWzbfnl6m3Jl7pJ2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hZZYgoI3; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so1055404e87.0
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 05:34:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528494; cv=none;
        d=google.com; s=arc-20240605;
        b=QVtq/iphbvYF4uI4QZzZyORVRaPqXoxM57BRuC2jKYzKEmlUJW3mpFDzec41XedUDK
         LkbAseYUVUHqAarJNhGiAfXo2gicfNDmkHY/laO/EudlhSt7FqLWp5qM/VO44PxHDgaT
         HhrJdLk4aTyMIxptxvwCekls26hGEC818ZuktSBtmb/aZ+xSUGSU6KmOOGNpoLR99JQr
         v+NzfnlZxFgUrVKJLdW+NWCaVrn5o/bz4SmVbRbAFMx9cmrDAMjfOU+rfKn9pQmUGwSr
         bfm0SjcX5qyapxyZyUxpHojpRMUgv5h//2h6QunAKsVRwbayWxPvvpgYyjtdhyVIDYMF
         Sygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fMtjTcJq5eIA2qihI+2nGicxmL8Td67ZjB3pSoQD8ho=;
        fh=rLjR8fRvwuch7vbxYa++PLyLlsBfDsFcWKCcR85Sre8=;
        b=ZwAZWBPsZ8W2ocNSjLFj8zv/o6WnsysZDZ6/X6x5/MlhdLuAxy8aX8LwLW0h2Haa3i
         hz2aBziQk7wgxvtx3X+0/x8jGc/oUevQIJTM8+PiSzQstiNHQlx9l0dJ3aCjrHvUDn1E
         CMUawanpMehCyS7KBoE0dVQXniAHOkNL4Fys4pCuyJ6vqPz1pOjsJdlFQTpPOTsw33h6
         dDCMZWynZBeYkePsJ9BzTVFrRs94InuUMojk//HSvv3ciA91cXMWZfDtOPeAAn8mWyKB
         q9Pz0qETctRTeuvM6MU6mNWHyzilfHOhK2bD+TlfeoRO+kogBUJIUY2Zyjx7HLSMOfKA
         l6aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528494; x=1775133294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMtjTcJq5eIA2qihI+2nGicxmL8Td67ZjB3pSoQD8ho=;
        b=hZZYgoI3hZE5jscwY/qgSvmSORNBapT/tnNUPeOYH6nSseyEGXl7xg043KwGvyQ5XQ
         39qBu0hUvs+id894K45MXjjb6hRr2s9+KV0jHYz905AFh/zJF7tkMXcKUwMOQMSe/sZ9
         c+AvYiJN5f/KXuqWaYijmCA3iFUUPDMvQ1WW59A6rMVtqtRnUHyxfrkQmJ7tt/emBdMo
         aEOs1SlkXT0z8GwwZeXG/0zvlgrHD69dX8QVk5naCNB7QHExGd4Gi9ZNpyQO9a4WAwCJ
         Aa+kPaoFIfonDIoOk41YCP5QqlQgOfSyl4n46heEFQtmzQF+gXSFC/nGnPWaiBJK/cul
         gZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528494; x=1775133294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMtjTcJq5eIA2qihI+2nGicxmL8Td67ZjB3pSoQD8ho=;
        b=di9U8Aa1N/+1dlLZRDzm+a0jmYPvELOfiLUw/3dA3ziZDnDNOps53f8yqNSdwl4+O6
         L+p8wswVFMYvqIJkMn2T1Md+uEHd8O/ltUAgw1EsPM1afvyDuHS5k+KoIDbaP+suH5Zy
         GiOjpieg4clmVjp/EzCdMrl1Pwwlm/2PyjQz+VaZuykv7zVXRy1CV0mIMEqkMatIHatK
         6/EbhNN/c4xy/RpcQGoOfVNa7gtpTZG/Sw3Q5GucmKtivfyTDBFqtXpb2UL/p/osXBT1
         syYJSPpWJvmicyiguee9bmLVCOff9z2Daw9aMONfnjQKr1c4YPWRFVINM5dR8HTRH/5b
         Y8sA==
X-Forwarded-Encrypted: i=1; AJvYcCXCfC8AuObcA9Zm7sSKBAMKzyE13cr28oa/TLMRAGjVDePVTsQzFy0CYEXiirIpiFVxD/uY1p0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZAy0Htl4OR5nBvQJh0Nm8Rx2dbVoL/QUyT5Hw//i19DaO+Dpj
	BG/WTbxDblzL87o8NwhfdTmmT6o/xP7scmB4iiRu50ehHh1oj2ECTOhU8QoiEfYtYoOI9uYYqKW
	I+4zLIjqfcGS+6ZWSOtQLRDLNi9RdffvtnGo2n7ERiw==
X-Gm-Gg: ATEYQzwgEv/fOO9Uyav4EW0UL0GIUgACjDtHFfHeYsOP6YOyYBNay9/YMR0TFNSMjvb
	4nuMnO6urh3W9TCeU9W4teM+9kmmw3rcYAK20cQf/fnsFZUQUi5eK2l44VoJuVUV6x4GMrLN9Kt
	oZWdFetB2DNasah5j3K9/4HPNwMreNDs9mWOglRlUA1b5fkeDs5FqKG52UhQje1x3a6xGjViueB
	A+SAX162yc+JJJB65oGsVIXZGBg/i7gwt3I1JbxPiTdpxYXPJDbORZTU6AZc1yBSnXXhY6xG5Lm
	EAfP/xY=
X-Received: by 2002:a05:6512:3e0c:b0:5a1:43f3:764a with SMTP id
 2adb3069b0e04-5a29b979b0amr2997503e87.5.1774528493504; Thu, 26 Mar 2026
 05:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326030759.8107-1-ot_cathy.xu@mediatek.com>
In-Reply-To: <20260326030759.8107-1-ot_cathy.xu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:34:16 +0100
X-Gm-Features: AQROBzAUMJTYzzyeSawXUe9OdLfBc-C70N5GR1BByMjzhb7eLn_1dlJggBGZnww
Message-ID: <CAPDyKFoemi7Ss8706XVUCu6L64CUgcdGQNe9jBFSxaOPp2umEQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] mmc: mtk-sd: disable new_tx/rx and modify related
 settings for mt8189
To: Cathy Xu <ot_cathy.xu@mediatek.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Mengqi Zhang <Mengqi.Zhang@mediatek.com>, 
	Wenbin Mei <Wenbin.Mei@mediatek.com>, Andy-ld Lu <Andy-ld.Lu@mediatek.com>, 
	Axe Yang <Axe.Yang@mediatek.com>, Yong Mao <yong.mao@mediatek.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230457-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim,collabora.com:email,mediatek.com:email]
X-Rspamd-Queue-Id: 5386C335604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 at 04:08, Cathy Xu <ot_cathy.xu@mediatek.com> wrote:
>
> Disable new_tx/rx to avoid data transmission instability, and adjust
> .data_tune, .stop_dly_sel, and .pop_en_cnt to fit the overall
> configuration after disabling new_tx/rx, making it more compatible
> with mt8189.
>
> Fixes: 846a3a2fdff5 ("mmc: mtk-sd: add support for MT8189 SoC")
> Cc: stable@vger.kernel.org
> Tested-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> Signed-off-by: Cathy Xu <ot_cathy.xu@mediatek.com>

Applied for fixes and by dropping the stable-tag as it's superfluous
in this case. Thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/mtk-sd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 302ac8529c4f..b2680cc054bd 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -682,15 +682,15 @@ static const struct mtk_mmc_compatible mt8189_compat = {
>         .needs_top_base = true,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> -       .data_tune = true,
> +       .data_tune = false,
>         .busy_check = true,
>         .stop_clk_fix = true,
> -       .stop_dly_sel = 1,
> -       .pop_en_cnt = 2,
> +       .stop_dly_sel = 3,
> +       .pop_en_cnt = 8,
>         .enhance_rx = true,
>         .support_64g = true,
> -       .support_new_tx = true,
> -       .support_new_rx = true,
> +       .support_new_tx = false,
> +       .support_new_rx = false,
>         .support_spm_res_release = true,
>  };
>
> --
> 2.45.2
>

