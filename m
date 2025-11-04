Return-Path: <stable+bounces-192427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01013C3217F
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 17:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3B13B626C
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 16:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37B7333457;
	Tue,  4 Nov 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn5XBqtv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147242264A0
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274057; cv=none; b=Rjup0/4nLIWexAQ4vSyzpALvBisN0XOKSeB/OrSAr7+zN4ev4GXU27nqemKLYfybmSycNEjR96Q0z6HRZVqZGY2AIkXAVquVmVVF53MS8ignBal4tJSngaw3eRckszTKDqCebwNqdaFgfdAm/lmHf8C4re4xl4578/Wht5hAoxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274057; c=relaxed/simple;
	bh=a8zjnlZJoP75Gcp3unqAhRNeNHZZuPHHbDlOcyOC1Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkpY3RCk1dWg79zlooE3zJzj92dernu3MOjpdI7tT4wTeYIKwElHhr258N2NcUPUCaB14gHfKPMkKJiM13YG1m1eXPQco1U0Ny+urqvji8dluPjK6i2uCFepGR1YcIuyfnN66NRFLmdiWdEc6L3n2bVNbrpUFi7APRkZk7P1op8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tn5XBqtv; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78662bd3b49so27662027b3.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762274055; x=1762878855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EeY/Q1vjgJqdUpxoN7I5OLtGxJW4ljCXvqhX1XWJkyQ=;
        b=tn5XBqtvJGKyjMeeYb+FMDXgjPt/GJuVrq3OqqMgC+IpQH6JgcYtcnS9COHnqLqyBT
         GbbzoBS+tgJLMtwvWaDQIvcWRjpBzr4C38m+IVJrhTQ5ppd0CcMw5gjr6v1PYvxjsEOq
         mtMRzliYCEPA9289aGvhp1sTw8i1ST96lNQ5zvRYWqiSw5qLqaxGX9bxlRNXvYBZvieF
         iFmrfcsjaeWRIC1G0/BqcTGTTjVUgqUDc+8Ca6qGSYL7SPwzb8y2rJpyoZq4aprRFFvN
         6ZYCOj12OaVPp86W80o5WD07DCOduUq5hMS5rWmukOWoe13HsxELhOQYI72O2YuHfKRM
         nRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274055; x=1762878855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeY/Q1vjgJqdUpxoN7I5OLtGxJW4ljCXvqhX1XWJkyQ=;
        b=p/xQ0k83Lxd5DhQdPIK/Idt/7oqNWvnrjeaLZ/PIHzWyLGg/2z34Zt4QgN0Zoq/Z0O
         OkMKZnxj0Gri0Od6mIvSZe2grWDLcvZmdRBdYJySJ00vLiRGCrOenebjt9B5NdS4n7A6
         NETfzOJ8/ZroGFAdNIcM6DVlHr6UsSuogqO7soaXgVGtuGxACS/BHnlxF0CYW6iFiaXh
         1YGziJvhXse9881pVnwBhgHmM4Kxhcr13noKR5D3bxJkErLkW0+7A2LIUreIOMJ8ckMc
         tQPZOSMwIWzGznwZW7hShILrFnkuFF48m/o0qyBvWsKb45phlnRDjtujHMaQGsLYlj2P
         B6gA==
X-Forwarded-Encrypted: i=1; AJvYcCWJv4IzmmNS/cfokYDVkR0Def6/A0a/gxghRY2FwM7+VPXhBd7hi09R4BqqRectdcA3NXEv0MM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0mBofarTw3QR3wfEV1YmLoeY5fTnJo1sbawZKzRoxZIZD5JD7
	LX691tcelmxuDUwtCcNHobTHc/YUk0ZpJVd62MgpGvccLj6PA8ITqepMMUZvfQEiBK7DrRozsjE
	OExUPHAAgmBvDHicSB+JbP1fgRSghPw+1Lr5Xi+fIkw==
X-Gm-Gg: ASbGnctK+CWdDLzSZNasrfIg7jfClGTFAaNhcMszmCrDEaS4asQcytIQX3S+Gc6E8/5
	+u92GAoHactj11H5d1RyXS9BrIP7BZujesPRAuMD0hj0TEiAzuH52X6aekTN7oGrIS7nJKjS3Ph
	C3Q5IvR4//vf2PZCP5x8O5sZ5D7AVCaXdo6MrdTuu0CfPf9ex9D/scmhVOlTY73dsk/DnA3S4yL
	xHH1givKqwW0rcV79C3V6AcbF3+S9cKMV65yJB6ooGLSx7UGPfI9uu2ZMHh9w==
X-Google-Smtp-Source: AGHT+IF0Z/yNF7yi6Lz9tQRkNyi37+NTyOPEnzyNmvGQXNJdjD0tMjSSXuyBHzY73wkfo4eUOH3v52Gvr3xMHkvavMo=
X-Received: by 2002:a05:690c:4882:b0:786:802b:d7ff with SMTP id
 00721157ae682-786a41efce2mr752787b3.59.1762274054906; Tue, 04 Nov 2025
 08:34:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028031623.43284-1-linmq006@gmail.com>
In-Reply-To: <20251028031623.43284-1-linmq006@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Nov 2025 17:33:38 +0100
X-Gm-Features: AWmQ_bk9KtCzO_f_YWM_AynJxSlgpLBL58lIquCitQc40-GRB32NM5WebMbg_Tg
Message-ID: <CAPDyKFqiNeO==u0j=VTKmWaG8VdMR-mS84QoLjrussfMYrr1mw@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpc: fix reference count leak in imx_gpc_remove
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	"Rob Herring (Arm)" <robh@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 04:16, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_get_child_by_name() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 33991f3c6b55..a34b260274f7 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -536,6 +536,8 @@ static void imx_gpc_remove(struct platform_device *pdev)
>                         return;
>                 }
>         }
> +
> +       of_node_put(pgc_node);
>  }
>
>  static struct platform_driver imx_gpc_driver = {
> --
> 2.39.5 (Apple Git-154)
>

