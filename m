Return-Path: <stable+bounces-176675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D88AB3AE99
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 01:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A009878C0
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539B276059;
	Thu, 28 Aug 2025 23:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUM2trqD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912237261C;
	Thu, 28 Aug 2025 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756425015; cv=none; b=dc6qJRjoqYeTnFGcXlbrTCwBpk4RMTEwyIeU4k9jUDVmXG1DdmpAv+OiLVTSKCnuwpkJwd2pFFD1QrbmeP9yfwSrOOLEyvtWAjiRlHLTfcSSUi+WklHZYNzVihu7nzqe2p43/aloeTlBoHRtGqoTyoy3L3Wmb76pq0k5JMnzOds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756425015; c=relaxed/simple;
	bh=zsWCFAyMsxiaMzTEC3Gr3yuzGPTx6B+vy48OAuN/rqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QT2hmmTgJ+H8V6bhKThmyhDaPmPQl5oJR3eyC7Zw7cAOW1Ivw0UPh3vqDXI4ipWJPt3NpBFTRLCOTHrlpLIMUb5tu9EKzrDLPFfxdJxtH2XrE81/5uhFYgXTcW7mQwfN+Bb4FScTXkS4hag2pLekYfS4dIW2GqKXdsbK0X/pJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUM2trqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243E7C4CEF6;
	Thu, 28 Aug 2025 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756425014;
	bh=zsWCFAyMsxiaMzTEC3Gr3yuzGPTx6B+vy48OAuN/rqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lUM2trqD6QlWxEbRGcHnWfAT2Dw6TF/vTGWJnBm3Lnj48ttau7a9jzrHNOqTDhcjd
	 z0sB8EwOiczyD7iNgthyhi+Omu58xYralkqysW54YfQUTMuDqO0gi4j3uDXLV7e9mQ
	 FbKlQ3XrVF/6gGwwfiZ644bMQa8Oic2wG/g1Tli3VZN7dnZo8Gu//4PtFB4tKfKJQp
	 GZmG92gVtfuLoaQ61eXYr1rAjQyOuOlM1DjxMw7CWiyTciFXlf1Jxu7lP/0h0TJPKQ
	 EVtNBY9OIA/EIuO9l5ZsrmiXSoyeQID06KOCFP8BQj6VWd3urFpHeywTWuGvXNF6pa
	 10ECT7tdBeZSw==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-327771edfbbso1616032a91.0;
        Thu, 28 Aug 2025 16:50:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUi96WnVM5y7Hq+Wk0vDJQrWFYQcFeLBf2wLkyyR8dl5LeTxw4Bl73gge0Sx5AXn9OWI1rBCJkXCBMIz8c=@vger.kernel.org, AJvYcCW2MsTwXRRfnuQvdC1I0m8nE5Go3CMJSIUgUMXrZyiu4NEe0ak7AGg8orrFKTO9otKY3hpL0gK3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyqt/bl2LpVWNeth1UkiUcXyrWBt9pFJ5tsPT/Ap8YulsbzK/6
	MBf2R9zVFwKTaLR+gUlUCFyilBnP3J2nBmSSLXSbhj/e0lLstTHb/PQffNX5pSLIj/zsXiz+sVo
	D5XtAJDOAzgN0j3Dj+8nI0kkosW1azw==
X-Google-Smtp-Source: AGHT+IEyPrn2mauZsphfR5LkJf3knFAASu6dleEuuWgWtdTpwoFH8h3V5JmRW8ZSNdzaXyzRk8Y/2ADMz9Ym8II8Udk=
X-Received: by 2002:a17:90b:384c:b0:325:57fc:87ce with SMTP id
 98e67ed59e1d1-32557fc89damr26677996a91.9.1756425013709; Thu, 28 Aug 2025
 16:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722092722.425-1-johan@kernel.org> <aK7VCJ9yOKntjgKX@hovoldconsulting.com>
In-Reply-To: <aK7VCJ9yOKntjgKX@hovoldconsulting.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Fri, 29 Aug 2025 07:51:23 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-CijzQqrRUf_=cQbTUSybN3GT46q0vx1139mmZub_OfQ@mail.gmail.com>
X-Gm-Features: Ac12FXy2kPL9Itx_6-_TK8BzHuWR2wBjPXyw4so4ACn3LaV_swD9vLFI7S9ZLJk
Message-ID: <CAAOTY_-CijzQqrRUf_=cQbTUSybN3GT46q0vx1139mmZub_OfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: fix device leaks at bind
To: Johan Hovold <johan@kernel.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Nancy.Lin" <nancy.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Johan:

Johan Hovold <johan@kernel.org> =E6=96=BC 2025=E5=B9=B48=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Jul 22, 2025 at 11:27:22AM +0200, Johan Hovold wrote:
> > Make sure to drop the references to the sibling platform devices and
> > their child drm devices taken by of_find_device_by_node() and
> > device_find_child() when initialising the driver data during bind().
> >
> > Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 mult=
i mmsys support")
> > Cc: stable@vger.kernel.org    # 6.4
> > Cc: Nancy.Lin <nancy.lin@mediatek.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
>
> Can this one be picked up?

Ma Ke has sent a similar patch [1] before you. And that patch fix more thin=
gs.
I've already pick up the final version [2].

[1] https://patchwork.kernel.org/project/dri-devel/patch/20250718033226.339=
0054-1-make24@iscas.ac.cn/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
commit/?h=3Dmediatek-drm-fixes-20250825&id=3D1f403699c40f0806a707a9a6eed3b8=
904224021a

Regards,
Chun-Kuang.

>
> Johan

