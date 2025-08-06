Return-Path: <stable+bounces-166737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ECFB1CC1D
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 20:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F54218C44E0
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1800128C2BD;
	Wed,  6 Aug 2025 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="h+EGrClJ"
X-Original-To: stable@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5DC2E36E7;
	Wed,  6 Aug 2025 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505959; cv=none; b=CqPiZ+4mwyqxQAIlORgt8J1CK6rf6USmRxLM9aPFa3i1V/1biFQjZvJwT6Gb3wd/wHeFrkKFczOon5QU5yc+27+iWqJp5Fjve3xLxpusm3sjrsOJziGYn6fS72fX/Pqm2mMHcjvf8x9Quqgmqm1WSXMVLEapxELszw2rtGcXHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505959; c=relaxed/simple;
	bh=sgX957es7+GVKONZFlhAEg1uefyAvzCkSJvyoqskeAQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=BauA/w3DZ9uTNOoIC0+8RfkGFPJfaOootJuiGMY9XJ8XHjHmVYfTh1WFo0mjZoxPG0a2ZbuOBel3ztsLpmrf/LbyFYO+Ai6CoyuSYbIHHMK4XqPT4FYtkTbGhLf5mGiyNbTAmJoSLI4/0q5qc6jhfBbODV/pT0yEhADPEAp8NIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=h+EGrClJ; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=h+EGrClJ;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 576IXWRG3356275
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 19:33:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1754505212; bh=x5ZJSZGGUboOavAQ6X5at8DOZHYlPYdsBqMz8Z9etXE=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=h+EGrClJu4U/9bJcFT7RoC2qz+6bJRHrROy6N6qGil7JWVW6GQdGwDcj4mDBcF3FG
	 IsxvPGbRGnlpEb/6qi8JmplXbrnM0zN6kLxOXLMiW5TgXoTIqnLaAtOwDkyVH5cH7j
	 jkPeR/3NdMdEICWlM3NhiGN6jIpZ54oINGsbiaLI=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 576IXWCY960034
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 20:33:32 +0200
Received: (nullmailer pid 612794 invoked by uid 1000);
	Wed, 06 Aug 2025 18:33:32 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: qmi_wwan: add Telit Cinterion FN990A w/audio
 composition
Organization: m
References: <20250806121445.179532-1-fabio.porcedda@gmail.com>
Date: Wed, 06 Aug 2025 20:33:32 +0200
In-Reply-To: <20250806121445.179532-1-fabio.porcedda@gmail.com> (Fabio
	Porcedda's message of "Wed, 6 Aug 2025 14:14:45 +0200")
Message-ID: <875xf0i9kz.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.7 at canardo.mork.no
X-Virus-Status: Clean

Fabio Porcedda <fabio.porcedda@gmail.com> writes:

> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index f5647ee0adde..e56901bb6ebc 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -1361,6 +1361,7 @@ static const struct usb_device_id products[] =3D {
>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1057, 2)},	/* Telit FN980 */
>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990A */
> +	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1077, 2)},	/* Telit FN990A w/audio */
>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990A */
>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */

Looks good to me.

A note for the stable backport: You might want to cherry-pick these two
commits changing only the comment text of the two adjacent lines to
avoid unnecessary conflicts:


 ad1664fb6990 ("net: usb: qmi_wwan: fix Telit Cinterion FN990A name")
 5728b289abbb ("net: usb: qmi_wwan: fix Telit Cinterion FE990A name")


Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>

