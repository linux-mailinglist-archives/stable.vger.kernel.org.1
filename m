Return-Path: <stable+bounces-89700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161BB9BB4C5
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B58A1C20B2A
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 12:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547BB1ABEBB;
	Mon,  4 Nov 2024 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhzBv4Qw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1811EEE6;
	Mon,  4 Nov 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723948; cv=none; b=dyTklsvuqy9dkp9hiU7hRADCwqfhqraWB+UHAkuOUJu7hZA/5VukgyPLeHI7VWxiRIDqPR4tVIztBohZ56/7CvkZNaLaC1aTjRvO7uD61bTUXeAwLfMk6mkkZfRcoiucyoimx763yFBugEhz2Ig7grycTKZzZ4ZgoDrvtBV2YZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723948; c=relaxed/simple;
	bh=3sKt0pKQ7l+ewl3dj/n8AiM7yxbEFq3qr76uue5LlSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHUgiH+VTwWFLSO3cAxUSSHOn9fds5wLsFVsVnHA37MdAPrOnTI2Qwh/ttVzqnEFD1gfxnNdlCjU6JcFJp/8c7ZdubS17LOreKCSx7fwEw/1gqZg90o8oAZxxrI3QbsJ8bnHhP4V8TLMVMxKnv6LZFeb6XlgyEvwHNN5pKaLllA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhzBv4Qw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88A1C4CED7;
	Mon,  4 Nov 2024 12:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730723947;
	bh=3sKt0pKQ7l+ewl3dj/n8AiM7yxbEFq3qr76uue5LlSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DhzBv4Qw/jRz2kLqJWnrL9AmrJDBvFX8zXP/vfElrDZdHWrzLB/ZnpbWxlmcKkDe8
	 ZQYaMAjrvvMq4vAHlEoZs022vT3TInz6dt/Ha+fkPV1iOa6yaZ0RovvTDIYKdgWjDx
	 QViQePlDTW1N/RBNcbcIHAmITMxXQPLWesx6udR4quGbaHqHaAujho6HgX5NqZMV9b
	 ohjRnGyzc4v+5QWxcxBRmmJIkNYYDjUxwwtvNpWp88nJSzzGnlbL+ReLlYXdOi9ebv
	 IF3Id1AaO29eVzPmbJLeG1znJzo03xDRBcbe7yhG3z0QPhIug1IVlHZkottVQvcYhu
	 ubk3a/LfbDVRQ==
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea7ad1e01fso2852470a12.0;
        Mon, 04 Nov 2024 04:39:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ1r7p3gkTWjfR/RwJgAhp8/we5OISuAdlfgdhJespfeWdufnWRLGXhUFvSYLmrczJSO/skC38eHsOgsU=@vger.kernel.org, AJvYcCUcRSev6rzwvyM8YbdHjpQ2+NzqSTOubG/bPnYsUK4I6txnze/XOj1JolPLTPdy7tIsS0ZMnfQs@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6Y3tZ/pMWGCCX9zOaIRhiQZm8nytpaV3/RuiFx7V+Xnbrcz6
	paO9HUmRQmB5eEMX50Q5BZ4FitIqNAnP0doMWJh/J/jcbrBD8E7Ns+Snu3MBOlNHaGimIFNB9mp
	wYQGUJ7LWD7mG7eYYRdQpMqHUfw==
X-Google-Smtp-Source: AGHT+IGp3PoghnDPsbTvX2ld6cnOJBapqXb+5hbUeZVa3jcTQkcnfw8QcLHobq/Oeep5/JnK90IvUmtv0dEY2fr3tnQ=
X-Received: by 2002:a17:90b:38ca:b0:2d8:3f7a:edf2 with SMTP id
 98e67ed59e1d1-2e94bdfdeadmr19464472a91.12.1730723947190; Mon, 04 Nov 2024
 04:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Mon, 4 Nov 2024 20:39:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8Vf3_BCOd6t2G=e-rU-cKZTdGbqEChPi5vipY6yR02eg@mail.gmail.com>
Message-ID: <CAAOTY_8Vf3_BCOd6t2G=e-rU-cKZTdGbqEChPi5vipY6yR02eg@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/mediatek: Fix child node refcount handling and
 use scoped macro
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>, 
	"Jason-JH.Lin" <jason-jh.lin@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Javier:

Javier Carrasco <javier.carrasco.cruz@gmail.com> =E6=96=BC 2024=E5=B9=B410=
=E6=9C=8812=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:22=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> This series fixes a wrong handling of the child node within the
> for_each_child_of_node() by adding the missing call to of_node_put() to
> make it compatible with stable kernels that don't provide the scoped
> variant of the macro, which is more secure and was introduced early this
> year.

For this series, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> Javier Carrasco (2):
>       drm/mediatek: Fix child node refcount handling in early exit
>       drm/mediatek: Switch to for_each_child_of_node_scoped()
>
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> ---
> base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
> change-id: 20241011-mtk_drm_drv_memleak-5e8b8e45ed1c
>
> Best regards,
> --
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
>

