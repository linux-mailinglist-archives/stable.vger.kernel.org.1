Return-Path: <stable+bounces-68326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 096599531AC
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B352C28960B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0625D19F482;
	Thu, 15 Aug 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaPmhwBl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D701714A1;
	Thu, 15 Aug 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730215; cv=none; b=cD6ZcYxDhLvS001YNb33dGfqy4x1hdDzr56aYBj1qMYWOsFOvisSg25GillIW8j5qQq6dFOWy7764/Gk7xBru5Cmve3V/w+Qld+t73tZHscKTMo3/AD4dKKvVHOlVS/hV6Av7Tg6diZCHu/nqQTJ9djfGPykvCWcauTcb4wIkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730215; c=relaxed/simple;
	bh=pNzAuHuhw5vFj0MfUJcfnnwgyE2OQGAdmeyHX+UNaD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHacP5TBa7onHV1Z8I6XWukTe58h3KcZToH9LlD6+4PtHYy1tUexWQOH1hy3YEGs+SdbMh6XEMgkCh/62troGj9RXwVIccoqOuD1vjyff2G5P/Dm52Nno2xQfA3WMjTB51nhSdCjwOEWJRR8r14mOY2r1WfmGNfRGyTmY0V7iOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaPmhwBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880A2C4AF0D;
	Thu, 15 Aug 2024 13:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730215;
	bh=pNzAuHuhw5vFj0MfUJcfnnwgyE2OQGAdmeyHX+UNaD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DaPmhwBlEUrM/uGlSuvQkk2mh69hNGpN3oP0zLSuu4YAZAzR4D8aC2ZIcAvzlNQLr
	 TKegh9YnwSlgdfXVJXTVxMs/EDzX6qV4Ssxp2LMUz4bgwuKfoNmvcczsng8Na4ZpGJ
	 LYncOTQnQp7swLnA6FCPHVtRBkq1LSxkehOTEI61CKit6QLrxbEgrE6AhMhs2ET97Q
	 NwlTi/+tj10fBRStqSZv3MnAIGe4CM2S1h2kOKMCEprJjcAbtiKWPpnuO+RB0u8LZa
	 0F0BPI2p8oxY/tShm1OCxw6z9kRmx4reVienSJTiRThdFZaarVJCtLlJDZhqZlLnPL
	 9/YiktCVJGk+A==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3b785d8b1so627114a91.1;
        Thu, 15 Aug 2024 06:56:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIshp+OSZgQudqTKxOP59iwq2RLFWSlzBIgQHtLFpcRyIkvZVGSN1LvCJ7UDcA8BJWZpnzq9yzT+Epfr+6bkd8hYgVHunWHtyuy8mxURWf/YnQWQ9QcODXuaM6Vb+1Dc/63NMC
X-Gm-Message-State: AOJu0Yz6O1RqlXz4Joi3s0yqEkOD7PCQwmUt1a99AuHZ6uaY0JwS+caZ
	0Nbyb2GgAFvggIP0FX8Lvy2kCMqlJiS41ZmiayloQczztrqcM6aVN7jrpmKu3n0VuGDuNnARjw9
	tXSY69svFq7mTxlY6wEtdICbcFQ==
X-Google-Smtp-Source: AGHT+IHF8lihSFvFy146V9RFDKmET4UMbp4dFKkjYWDYSa8MfftqgIMB+sTB/uU6Rl3c42kHJSnavDM+yFIZjN3/ZEk=
X-Received: by 2002:a17:90b:230d:b0:2d3:ad41:4d7a with SMTP id
 98e67ed59e1d1-2d3c391157dmr4796664a91.4.1723730215112; Thu, 15 Aug 2024
 06:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
In-Reply-To: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Thu, 15 Aug 2024 21:57:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY__EAW-Tj93oSnN1TTB0sH3VMnHwwRaVv-Nm7cEGBeuvcQ@mail.gmail.com>
Message-ID: <CAAOTY__EAW-Tj93oSnN1TTB0sH3VMnHwwRaVv-Nm7cEGBeuvcQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/mediatek: fixes for ovl_adaptor
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Nancy.Lin" <nancy.lin@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Javier:

Javier Carrasco <javier.carrasco.cruz@gmail.com> =E6=96=BC 2024=E5=B9=B46=
=E6=9C=8825=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:44=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> The main fix is a possible memory leak on an early exit in the
> for_each_child_of_node() loop. That fix has been divided into a patch
> that can be backported (a simple of_node_put()), and another one that
> uses the scoped variant of the macro, removing the need for any
> of_node_put(). That prevents mistakes if new break/return instructions
> are added, but the macro might not be available in older kernels.
>
> When at it, an unused header has been dropped.

For this series, applied to mediatek-drm-next [1], thanks.

Regards,
CK

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (3):
>       drm/mediatek: ovl_adaptor: drop unused mtk_crtc.h header
>       drm/mediatek: ovl_adaptor: add missing of_node_put()
>       drm/mediatek: ovl_adaptor: use scoped variant of for_each_child_of_=
node()
>
>  drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> ---
> base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
> change-id: 20240624-mtk_disp_ovl_adaptor_scoped-0702a6b23443
>
> Best regards,
> --
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>

