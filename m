Return-Path: <stable+bounces-222420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFqdCNDgo2kTRAUAu9opvQ
	(envelope-from <stable+bounces-222420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:46:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A481CEAD2
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C68C03005764
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E51D3195FB;
	Sun,  1 Mar 2026 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smg8NnrE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2B8317146
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347591; cv=none; b=liWl/hFi3FmUjv/nI1bFVZBOlwTTVtTfU9Qg3ZxThOLPcuoIC/wbtuDldFnqW5mthHsVPjDYWfG6eSLUdodiN8EPki9KhAZHqtOHSVdgo3s/PEP7LbJt1e04H6RFDwUR/E2WjERhy5IDP1MZnqbNqCl5H/cY4ZNaO5y1iEsHkpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347591; c=relaxed/simple;
	bh=c7yt7t1C7IKL+PTpcaEB7MdzhrMReQnLePjLzslok6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bInHHohZ7oOu9n3mQpTLpdpYwineh8JrFyk54c/4iht4W81aht/LwyECqyE1KKux108AZN9HO5S/6daxhtfo0O/4OQ2tCv1sH75bYLr1+O8wWts365FGHcOevG3NBpu7SkEY366h7BSRbvN/luUhT3PIoqgbsHHLTDaaRAf2efY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smg8NnrE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366E8C2BCB0
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347591;
	bh=c7yt7t1C7IKL+PTpcaEB7MdzhrMReQnLePjLzslok6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Smg8NnrELaPtnPQPrQHongBwDTvCU9ZD3AeAZ11USkiZjL87XgAkTGwZRlBjsmvAL
	 x8Ys5TRnpkAe7NCGnBr+zFJ4b+7gZhFTF7lz37kP+sXXAfRzTX4o/+AS7jcbUPVgL+
	 bY1D732eG3r6l/AyciB7d1y4ZbD7JaxAq3ymY8jU8PYRC9/7at4/BIgAMfHO65rmeh
	 pw1FIW3rrfGgGomcKF3wFah5AQQHhYtffa316hVhCkulpzcrUCf8BluChJC1gsyOpg
	 MZxwHoEMFPUIg48ejALTN+FtrRDI8YMSaBMUdvfvsgYFuueNALqb1o2F14YLRyQAhO
	 Xd8xDonEt249g==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65faaa8b807so6289469a12.3
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:46:31 -0800 (PST)
X-Gm-Message-State: AOJu0Ywx7Cos2XkSmmRwHmtbvKa+fGpB7zg85hQkpstradSqb9g0eBm8
	CyBtphnzpz+qABc54aHMJAMmEjtLWMZAMlxtdTHH1I4NWQP5BYI6yjxfbDK8QR2kWb3y6h78xFy
	Z64aew56b+Gh4hP0nx5NdVyZKgMRomXw=
X-Received: by 2002:a05:6402:f23:b0:65f:730d:8026 with SMTP id
 4fb4d7f45d1cf-65fdd6d76efmr3466140a12.9.1772347589719; Sat, 28 Feb 2026
 22:46:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301014529.1708098-1-sashal@kernel.org>
In-Reply-To: <20260301014529.1708098-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:46:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7cxVAG3QKSDaUg-M-AYGMCVBqvUqnps52paScPMYO8Qg@mail.gmail.com>
X-Gm-Features: AaiRm507T7L922KCkjo9JPTmLoki11dW6Wc7eq38sLI5dzSAZfHwtLRzBf0YCu0
Message-ID: <CAAhV-H7cxVAG3QKSDaUg-M-AYGMCVBqvUqnps52paScPMYO8Qg@mail.gmail.com>
Subject: Re: FAILED: Patch "net: stmmac: dwmac-loongson: Set clk_csr_i to
 100-150MHz" failed to apply to 6.1-stable tree
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222420-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B3A481CEAD2
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:45=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I have already submit a patch for 6.1 some days ago:
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

