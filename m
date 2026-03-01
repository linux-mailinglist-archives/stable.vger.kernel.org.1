Return-Path: <stable+bounces-222424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGXpJmbio2nbRAUAu9opvQ
	(envelope-from <stable+bounces-222424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:53:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A17E1CEB29
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA1F23018761
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A9F31B803;
	Sun,  1 Mar 2026 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHe0qPKq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED12731B101
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772348001; cv=none; b=cpcOToYDf9n/2OBHWxDjCZsOOVvB/fxQaq0lzrB7sFvM9Ejud/DNzVCPTiZI32uC0N6mqA4oYqB+YMBS1VGCCIKJjPO9rUttT3S586jk7yKis/xiw9kOY91RvronfwB3uhWu2j79RDQx5rx1qaVUr8qAQHW/brQzzUUzN/R49HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772348001; c=relaxed/simple;
	bh=uBz5/DsNTkQF53CTWrzktdKlRSarb9rE0O45U+rT51I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zd+8QYul8APYE+2Elzp1N2Y9YG6GeLT99PeUhM8wl0a+wHqqWu8VJszUNIJL3e/jEjLBihQFqLgZ1PQMJLGpPTSIDcvXlAqOpXd/r8AshrdRgQEQk/n/dfUxhTJIhYk4nes0rczZx+Vq/9nW7YVUM0MmYCL0T5xTLn8AOwXgAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHe0qPKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65764C2BCB0
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772348000;
	bh=uBz5/DsNTkQF53CTWrzktdKlRSarb9rE0O45U+rT51I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hHe0qPKqlA2jRVjg5vABP2Aa6hNExBjEIedvyNDQZXuI7E+qTe5af0cTSaWg6BS5w
	 ssd24632XDM6/aEhP9EXoJ/rM+sMNvu5NLZ8F7aPAg9nCBOYI81O4knii0Qd46Gq6/
	 HYPxI3Ku/dctrl3SUfMZX+8G5fQgWoA6BffzdVMMh0NTn9Z/1+6NIavwQPJQWDmSlz
	 booQh/xG8Szq7fWhYzrIWYyqG8wZxOphFwhbgV5b3mhA98kNIIhb4GSF9pjbnS0+QW
	 toXEgIQK4QvCMMj8OFd1xQ6eGUMIQsvCMN9HsGV5X8W5OYRcwgdrHph+V/75AfFzf+
	 xNld2+Z7uzHug==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c5a778923so5419337a12.2
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:53:20 -0800 (PST)
X-Gm-Message-State: AOJu0Yxb5HJyLjtGBX5tUD9oGLtSc/dCphpFOtU2NkRL2WMBmV5xRw7S
	7eBnssgjYumpKMYacehUZ2xgdsi6OTGn8GpT3XDHE4U8xl4q8vDrzCWAfN2xig5LJbCDLcRkbu+
	XMrMg53xhnpUN0L/3kaykXE1ym+kuEXE=
X-Received: by 2002:a05:6402:4493:b0:660:475:93f2 with SMTP id
 4fb4d7f45d1cf-660047594bemr3098193a12.18.1772347998875; Sat, 28 Feb 2026
 22:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301015348.1720657-1-sashal@kernel.org>
In-Reply-To: <20260301015348.1720657-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:53:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7CpjDY29zPB60d8Ct2NWRrwGf+tJ52oYCL3fjRPEkEDA@mail.gmail.com>
X-Gm-Features: AaiRm50zfa7_kKX2hukVQSNRYw5_Ic-T65iYr0aa-JHwjvscZiMEXArH3ZD0ets
Message-ID: <CAAhV-H7CpjDY29zPB60d8Ct2NWRrwGf+tJ52oYCL3fjRPEkEDA@mail.gmail.com>
Subject: Re: FAILED: Patch "net: stmmac: dwmac-loongson: Set clk_csr_i to
 100-150MHz" failed to apply to 5.15-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Hongliang Wang <wanghongliang@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222424-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,loongson.cn:email,msgid.link:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3A17E1CEB29
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:53=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I have already submit a patch for 5.15 some days ago:
https://lore.kernel.org/loongarch/20260218121310.2545149-1-chenhuacai@loong=
son.cn/T/#u

Huacai
>
> Thanks,
> Sasha
>
> ------------------ original commit in Linus's tree ------------------
>
> From e1aa5ef892fb4fa9014a25e87b64b97347919d37 Mon Sep 17 00:00:00 2001
> From: Huacai Chen <chenhuacai@loongson.cn>
> Date: Tue, 3 Feb 2026 14:29:01 +0800
> Subject: [PATCH] net: stmmac: dwmac-loongson: Set clk_csr_i to 100-150MHz
>
> Current clk_csr_i setting of Loongson STMMAC (including LS7A1000/2000
> and LS2K1000/2000/3000) are copy & paste from other drivers. In fact,
> Loongson STMMAC use 125MHz clocks and need 62 freq division to within
> 2.5MHz, meeting most PHY MDC requirement. So fix by setting clk_csr_i
> to 100-150MHz, otherwise some PHYs may link fail.
>
> Cc: stable@vger.kernel.org
> Fixes: 30bba69d7db40e7 ("stmmac: pci: Add dwmac support for Loongson")
> Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Link: https://patch.msgid.link/20260203062901.2158236-1-chenhuacai@loongs=
on.cn
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 107a7c84ace80..c05e3e7a539cf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -91,8 +91,8 @@ static void loongson_default_data(struct pci_dev *pdev,
>         /* Get bus_id, this can be overwritten later */
>         plat->bus_id =3D pci_dev_id(pdev);
>
> -       /* clk_csr_i =3D 20-35MHz & MDC =3D clk_csr_i/16 */
> -       plat->clk_csr =3D STMMAC_CSR_20_35M;
> +       /* clk_csr_i =3D 100-150MHz & MDC =3D clk_csr_i/62 */
> +       plat->clk_csr =3D STMMAC_CSR_100_150M;
>         plat->core_type =3D DWMAC_CORE_GMAC;
>         plat->force_sf_dma_mode =3D 1;
>
> --
> 2.51.0
>
>
>
>

