Return-Path: <stable+bounces-222414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJTCAOneo2mGQgUAu9opvQ
	(envelope-from <stable+bounces-222414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:38:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED511CEA64
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 07:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77A293008083
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 06:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC4317151;
	Sun,  1 Mar 2026 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh7RsHVp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AD430BA3
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772347105; cv=none; b=Pmbztpql05uVtG0fIHKiCSztsDOkw4pKqZpylR75eoIPMWgAZgtXIuWH29UFZhWP2ESTCZl+gDqndHv2sMPEXmS971HEQQdLZUAzmus6psTxY2jpM068619viGFVz0PVzD2TJDTAQsrExH2JO9vVxrDSX0cqK551KK6M87p8bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772347105; c=relaxed/simple;
	bh=88o1axfZfrS6umlnTLtfz3bDCQajM1uVbt0V0dlisqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEIL7uRLm4nVvpAjoVPFV8/zuR5ll85wwIAKAcwtsz/pBxwbpP25R/Zd/mMwNpq6OeRIUtAfakcv2crJ9x6c4i9/0i3OGYodMlQNTA4Nxx26qgXx4fOUIO3N23WmZbiC8HOqdWC7oXkxdbGQY+6yzsIzutcms7+fWVev+xE6UHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh7RsHVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF88C2BCB3
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 06:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772347105;
	bh=88o1axfZfrS6umlnTLtfz3bDCQajM1uVbt0V0dlisqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eh7RsHVp1g/Z1qcHgubqF6DXl8bQjKKE7PbYqa8WF7bj1cN24BrlV9NMRJIpT8Fzn
	 rdo5YlnHfNjL6nbaP1dTgIxaLlwRZyqtQUEUE7hdWT3kdBxt4t5uq0FLvZoa/oGc7p
	 RrMZZl+PDUmcKc3WdgxiPswLqci5+Wm7CwRtvibqtGHkldmNvf+7dAXNrDJQRBfH63
	 M2urp4A+n3Z+EBpgHzuvCCpED0ckoJ4DQTG/0plIw9ShtjUPy2MmzZlJ3HlfsAH4Yr
	 6C6WpVBClxE88MAnquoZi1hPM1/sDrE7hOZIlfOvXyHKq0V7TKRxL7JOB13+kCvHvU
	 Oxbes9npHG/ag==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65f73d68faeso5099827a12.3
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 22:38:25 -0800 (PST)
X-Gm-Message-State: AOJu0YzDOWoLiwRxBvCqfkfl0F5mn+KI6XhOlFXB7KlrzVW4Na2CgUXq
	9hq40w+g2Cj5uxS2aQjnU+ICCJDTLbgAK253DHi3iJQT9HN66dsc56byDSg083zfUVFfxDmZ8la
	veC9N5KV7lT1nYw2ULupPVS7YGJa5h8Q=
X-Received: by 2002:a05:6402:26c9:b0:64b:83cb:d943 with SMTP id
 4fb4d7f45d1cf-65fdd6be020mr4850268a12.6.1772347103783; Sat, 28 Feb 2026
 22:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301013640.1696690-1-sashal@kernel.org>
In-Reply-To: <20260301013640.1696690-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 1 Mar 2026 14:38:12 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4qU7GSJRMPm3253dRB97mvhKOH6m_GGjA4b-itDz384A@mail.gmail.com>
X-Gm-Features: AaiRm53sz9DVhIh-5fus-ezv4_hsXvql4TrfiX1Xpwrvt367E5_JQhQdXVmr2Oc
Message-ID: <CAAhV-H4qU7GSJRMPm3253dRB97mvhKOH6m_GGjA4b-itDz384A@mail.gmail.com>
Subject: Re: FAILED: Patch "net: stmmac: dwmac-loongson: Set clk_csr_i to
 100-150MHz" failed to apply to 6.6-stable tree
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222414-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AED511CEA64
X-Rspamd-Action: no action

Hi, Sasha,

On Sun, Mar 1, 2026 at 9:36=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
I have already submit a patch for 6.6 some days ago:
https://lore.kernel.org/loongarch/20260218121242.2545128-1-chenhuacai@loong=
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

