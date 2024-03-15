Return-Path: <stable+bounces-28265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9196787D386
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E580283F6B
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4796B4AEF1;
	Fri, 15 Mar 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUxrGNxw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0530947A67
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710527156; cv=none; b=YOvKvxmKwsBDHPfDG72IdjNBNkPwZ61AejpMNHKJxUdYi0dZZ/cM+KTQkd35N9cGNhxVHBxyuBOs8U048i36NH9ZFJP8bMqUV1rgt75JV5cMVYAnS5NofCiz+c23Naoo+jymrkcoBetkYs/KM/JV8BOZe6ApUaHCkprLiigvnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710527156; c=relaxed/simple;
	bh=tr6ntZPX7I7g5hEdJ+vW6afZngBdxB4VLUeNuYVx/5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GtEfq/25fcEs1qSEJ3CvNSmWRmduDZhoNChMOIiuZ828qdinxCoAGDAUfzNvUVvjM7XGg13Nn/Nrpj6aK+YvpHejzgodBMCoL2x3j3FVUV1bng9or8qTgTEU3OYjVvT/2xtaLsBL5BIa2nnIE4JznEJS6dsB7M1VBqa+izJynuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUxrGNxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AAEC43394
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710527155;
	bh=tr6ntZPX7I7g5hEdJ+vW6afZngBdxB4VLUeNuYVx/5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gUxrGNxwfevnUmm+z9Y+bpoTac4e/jZP34VlEAg1ZFmBHyXp39nBf4nQ+y08Aix35
	 ynWYIOAdd34vTiwEijzQi0E+J+4dM4399OARaYxi7tJq3tgf+RMP97cLknjWS0bkRP
	 N4gENT9c5Om7uxiZQoGT4yEtojcM3IpevnPqqCwpZSbtjLhVyjB8PaF/66yjPv8XWU
	 /B1Wy1qi7qVsH3aMZgMul5sxm6cvDIyOYZVK4dVsCbKfOLJ5EE2EqaKPFTbBhIlbmk
	 yehUEvUlDDv5if47+sCDPpe7GBTjM67n64VdMB2IL/GFTwlHsmga51dBnXcZZgn5Dp
	 ae3R0sOK2zBCg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513d3e57518so2260315e87.3
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 11:25:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw47KBJ0eSFh2SsMpkQl+n8RkxByMidl1ljfgXNV1O2D84k4rc3
	D+YbXPX8DiqVnH7WW2NBBIv2ONNjp0pPyzLv5xjVki3VhDRrEsuJ2f4kBBXFfGBqM9dZCmNEO4p
	8UG5bN/vZC4O59V6RRt1FqkdRim8=
X-Google-Smtp-Source: AGHT+IHG7q71Pp8wrwC72c6hoP6KsfADEgvzZfjnqNkb1bLVbUMmrg9BkXFI9zrkov6W5GHHpKbxoTCjazuwD+35SGU=
X-Received: by 2002:a19:6406:0:b0:513:d8e3:fe3d with SMTP id
 y6-20020a196406000000b00513d8e3fe3dmr2170705lfb.26.1710527154049; Fri, 15 Mar
 2024 11:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
 <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
 <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com>
 <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz> <CAMj1kXG1Vgpp+ckwDww_4q2SF+kajUaoE3+qe5FzMkGyq-Lbag@mail.gmail.com>
 <CAMj1kXGZLs3MdFiK9jrkmWR+YPt50L5tuCJ+rLLTjVa3Grm6tw@mail.gmail.com>
 <61148405-2036-4994-9eef-45cbe6aa9adb@podgorny.cz> <CAMj1kXHn0qp2Qq1WfoT015ezjnzHLoy7=XVE_RY+6jsHzQ+gkA@mail.gmail.com>
 <35ae3208-a0ba-43a7-ac4c-6f770b3df405@podgorny.cz>
In-Reply-To: <35ae3208-a0ba-43a7-ac4c-6f770b3df405@podgorny.cz>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 19:25:42 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHO_R4XpQ=To1ZW_yac_sjWFPnw7pjunn0UmraFDA2wCg@mail.gmail.com>
Message-ID: <CAMj1kXHO_R4XpQ=To1ZW_yac_sjWFPnw7pjunn0UmraFDA2wCg@mail.gmail.com>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
To: Radek Podgorny <radek@podgorny.cz>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 19:11, Radek Podgorny <radek@podgorny.cz> wrote:
>
> ok, will. the kernel with previous patch is still compiling so i'll
> queue it. ;-)
>
> anyway, should i apply this as a separate patch or as an addition to the
> previous one (the one with bss.efistub addition)?
>

Only this one change please.

