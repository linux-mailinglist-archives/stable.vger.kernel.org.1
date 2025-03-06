Return-Path: <stable+bounces-121324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F2A558B9
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 22:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59F917499C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 21:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CC7276052;
	Thu,  6 Mar 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y8yXhYxb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72AC23FC59
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296314; cv=none; b=Ngxgtqatge3VxYHjDejLo4Q8BsGWsIFevWeyk+FGER/a8cADcgYiz5HiFUdDKsQ5LdEL9V/hFSg5i3Zqsp1BZAnRkTYeOl1kDQHa+nMu/ikTNV2C6WJQqMHMDmyizacYS1TKtrMfW0aT6Y1labf8yjLy2ub2znvNxfovhFCnGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296314; c=relaxed/simple;
	bh=6nLUeGZBsOZaxX7lD0yAqrwnU/9EkCCEKqX2KbebjDY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cCLVlS2inZHVGWkN+06x3WViatJpWTbx+cDVmfexPWYengwSyw1CATT3cO8hOdwOO5C1Z3ZFHIjXC1FoNONd06S5VWehAR4qCbAymLJlyeJLNtMHXpvYwGKbBSZXqMptsYBKof3OnI3rB+QdjWWiTrqyU7yhfTmkv7+OPCpEfJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y8yXhYxb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf4802b242so223808266b.1
        for <stable@vger.kernel.org>; Thu, 06 Mar 2025 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741296310; x=1741901110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6nLUeGZBsOZaxX7lD0yAqrwnU/9EkCCEKqX2KbebjDY=;
        b=y8yXhYxbNasZPZMGQjweQq91JrwF0qwIqKnhDD00CsLW1+uxQB96aHu+/RgxhmQSyY
         ocaQgUQameDnuXFZnKF53BOYjaCdlipwjqg0e4znaayu/EBBoiS4qIYFN0Kz+bfvuPAz
         rlyEmStL4Fr0rQnC7O+dx3Jzqfcvs3t23rGiqtMrtKpJs5Srhr7RkcgkXI6GsbHZjyTN
         5TV6gNy3GffpoEtc7HPbxSCUxOkgp5Y/PXiqB4pvr81Jwlcl/4ThuqsTv8Cz6c5JmbHA
         xPGVmi+wUAV8Om/qWkYPC4VQJBgMRtrYgSPSddxu1KfJ5IgQbEOlnGGIZPr69EdZPBLi
         ST9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741296310; x=1741901110;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nLUeGZBsOZaxX7lD0yAqrwnU/9EkCCEKqX2KbebjDY=;
        b=XxLtdgLBFUtoEblTEd7PeC4NqAdRDMrM5IjLLQtzdjB5JksNu37aZt7qHHrhQIl4jL
         B9XOSVU6mBvEJpEjVA44gfHno1zchuuXpgKfKl6o1PLiQ/iSxtrxdGvO83vRV3CgK+eq
         7UzjkcbvHcW/fyC5ilv2EtxW5MNotMG2I83IDEQvb8nJx5Ya5Qb7DlK2RzJ/M2SroOn7
         IuFzxVotMYiw3cpeyblEJXPtptWWQ6aN4C/Zzy35TOObbiNjdKXBo78PIaz9/v24D7Pp
         2RcVHyMd1GYxldj21EHSnAkOTahSoYEtiDu3tQS+OjSKGkvEfpsKvr2AiRgNzOHluz1I
         Ykcg==
X-Forwarded-Encrypted: i=1; AJvYcCV2I3R+aIDv8nFad7rL4aw9ZQBbt5OPYUDRO1K+t5a/Dk8jxu7m1AGhZC61Jfk8gSqjNYUyPDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNG+PDRYnMVc9TX8abhG7cADex5u/1/kyU1et4s0RCqfAtPv51
	s1kvn2I53JPtrhbv1SRw0+3kmPuX1wShgV6lmJKuLwxZuHMXKdrD7QlEv9oECS4=
X-Gm-Gg: ASbGncsY7D4H0T4PKnLcw2totYXqYOpx+4mntlRd++hYb2QYneXfT3QH67+VhMqEEdu
	xUnEWzATcRbtigwqlQgeu8CPhaZafxSgCqiv3z3GBCHcp99AksrqvWnqeU0rJbPV2LDISTQVDkJ
	c26FrTMG8MwdFt3HO3UXiYUa+6bEMvoIUSbWD84ENeCP6t3QEkYb9aY18JtVdX31qDd8Ji6DHQj
	8ieUZPcTNiKjrv/MMmEM3mVXQoPWuiwDRJ4pHXJt0/WclshAZT/It9JGfzi9xDFQBcGIXJC/mrv
	1JwDL8bBFhXAmqYfiUbp4REyx5Jo0tSXvX7BoOcTJ/PJWkM=
X-Google-Smtp-Source: AGHT+IEfkrY7UVJaq0/ND9NEi5g0hc9ml44W1eaBzgh92FLmrsjRrsJKvCEmtLb9GKZY9TgjXouEaw==
X-Received: by 2002:a17:907:3f9b:b0:ac1:ddaa:2c11 with SMTP id a640c23a62f3a-ac25210ff7emr88036066b.0.1741296310064;
        Thu, 06 Mar 2025 13:25:10 -0800 (PST)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d7da1sm156779066b.174.2025.03.06.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:25:09 -0800 (PST)
Message-ID: <2c1cab545cd3b57a2155df2e87ad9830b2b94ab1.camel@linaro.org>
Subject: Re: [PATCH v3 3/4] pinctrl: samsung: add gs101 specific eint
 suspend/resume callbacks
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, Krzysztof Kozlowski	
 <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
	 <alim.akhtar@samsung.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, 	kernel-team@android.com,
 jaewon02.kim@samsung.com, stable@vger.kernel.org
Date: Thu, 06 Mar 2025 21:25:08 +0000
In-Reply-To: <20250306-pinctrl-fltcon-suspend-v3-3-f9ab4ff6a24e@linaro.org>
References: <20250306-pinctrl-fltcon-suspend-v3-0-f9ab4ff6a24e@linaro.org>
	 <20250306-pinctrl-fltcon-suspend-v3-3-f9ab4ff6a24e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3-2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 20:42 +0000, Peter Griffin wrote:
> gs101 differs to other SoCs in that fltcon1 register doesn't
> always exist. Additionally the offset of fltcon0 is not fixed
> and needs to use the newly added eint_fltcon_offset variable.
>=20
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Fixes: 4a8be01a1a7a ("pinctrl: samsung: Add gs101 SoC pinctrl configurati=
on")
> Cc: stable@vger.kernel.org
> ---
> Changes since v2:
> * make it clear exynos_set_wakeup(bank) is conditional on bank type (Andr=
e)
> * align style where the '+' is placed (Andre)
> * remove unnecessary braces (Andre)
> ---
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 24 ++++-----
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 70 ++++++++++++++++++++++++++
> =C2=A0drivers/pinctrl/samsung/pinctrl-exynos.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +
> =C2=A03 files changed, 84 insertions(+), 12 deletions(-)

Reviewed-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


