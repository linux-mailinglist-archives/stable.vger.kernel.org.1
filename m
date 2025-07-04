Return-Path: <stable+bounces-160152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDFAF89E0
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECCB3B412F
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 07:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604D2279DA9;
	Fri,  4 Jul 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVyPsTeO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989D1DF246
	for <stable@vger.kernel.org>; Fri,  4 Jul 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615178; cv=none; b=coGW1d3oYXS10Ra8l76DaW/w2P0ZJAsA7M8ZllvNizjZ9pd3arA+Z5Epti/afyDC/EYaBvHdeS/CkBoqxYc1ykTvd5JyElEcfmmcTL4TAGoXfjBXHpUzdLw+VH1wj666r6paTQ2z5qt4mBScLwFx6iWsGAahYwdEuUya5NBt978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615178; c=relaxed/simple;
	bh=thn7hBv5hevtAyLdi7Mi6t6qrpp7BuiFJ60MRMfvxoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ViuTCMcb9MroRyIhMDZbttyu7W342AhfnRj7MUmXI2X+RjrmheU850BcS9qaxjabivnxxS2cU4uULqROQoQCFxuHiRnwV+pYY3k6HbhbavNYYZtc17QOJ5gklwEEWkwgPhFS1X0DkgPhjB4wVAMw+r6DnVjrdLTvCfn8+5St6c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVyPsTeO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso6470081fa.1
        for <stable@vger.kernel.org>; Fri, 04 Jul 2025 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751615173; x=1752219973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CMKkl3Ng7VHLf5+40SYH9xeF/I57k4uscstnKGIg1Q=;
        b=LVyPsTeOvwXvjK51rtS6h14Nb6jcL9itBeagDQBW2S9OQxEd+rS+9HXhArORmyhTx/
         0f51dlBHyFFDllFYYL+qwQzPMcx61Yvz1dAafcdgRAj4pSQ5d6wEgcFtqtBOyyJcEM8y
         QXoAQBD5Xd2DK7ZqJGYs4blq2so6ajLtDY9/zPs813OsjFcGczTiNpjZLLMM2MD2XtLi
         nqZYW3KDkjkOXiBehNvXCKSj6Wmfogge3iUCjk36qdNWX1QCW+qbfgeQMcKl3xQ489eX
         pW7bCKkcoESapvIdu70R54mVwYjMXwzEErafB0XqneFunkRMrm5wT0Pab5O79Tc639TX
         GnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751615173; x=1752219973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CMKkl3Ng7VHLf5+40SYH9xeF/I57k4uscstnKGIg1Q=;
        b=mdU8qYlCeyLYU4J6jynuy5lxQXMagkP9EMFiaI2CPXBEAgIfw69NfHOx7rYebrNzL6
         81jsFIbtXJLWoYZfOrZkbecDUk7I42MElyhtaZk0ffXFjK3cEeVOvJYQl4gjFw9i7Te2
         aQCbW3iN4xvV5mMtzs0zr/iYCFsoUEyZHihaT7E8MQDBsnk/sYx+0GbWkFrH2iKLIrbS
         aknMS44A86pAZQafuxJ6do8WNepo+FMypLSOncyW3iVPfpfCsLIGc/x13zXDM3b62Qzn
         np8789UWrKXoeRIkDEgOCvhArSfQ+/6QbQX9Rl86nDVS/JM7PkiIOqHf29u040txlbOB
         lntA==
X-Gm-Message-State: AOJu0YyI9GfexAVb6QLB0fFbpUAPmY2gIYlJ7McvaQ/kVmjXK1lBOQ+N
	uY0zHaO6P2yGKa5tnjspvKfexpOMN34NheTtqVfGGBiB3d1EoBR5/UTzIMioDpqBIe9INIwSy2b
	xctbPU9QkySAJSwVN0vTjyKEmqW2O5HU=
X-Gm-Gg: ASbGncslUM7cJprWe8JhvsSBOFMJB/P4DcYdybPlgyH7i3YCB4hNifDFgLO18VGEs1H
	mdaIaEc1WYuCBvedV6R0cf7dteyjLAih96BaNkIp8hm/4d9tgqzDhXql31nyHpF2QVHGj/a5Wyv
	vUDRN/7VCTXGGnRDj94VHSvobgLtrcgVBpzlWGHpbF1Whs+WeMktOcQXe6g25o9HjWrMiWLFfqS
	EJZS+j8MbSRZm0=
X-Google-Smtp-Source: AGHT+IG5Jffwv9yuGA20Ai/Iu0laps2VAxdk7ZBpr7fuOF6NOL9O94fnPyBy7oUvJrs9vcQJzGNsqVm7vc9ylJHNwgI=
X-Received: by 2002:a05:651c:19a9:b0:32b:9c54:4ca1 with SMTP id
 38308e7fff4ca-32f093408e6mr3004691fa.39.1751615172383; Fri, 04 Jul 2025
 00:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624134840.47853-1-pranav.tyagi03@gmail.com> <20250624191559-d8d1fb6d1407e834@stable.kernel.org>
In-Reply-To: <20250624191559-d8d1fb6d1407e834@stable.kernel.org>
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
Date: Fri, 4 Jul 2025 13:16:01 +0530
X-Gm-Features: Ac12FXwu-1mf9D-s4Xpda5obi4SXi-y1XgIFKhhXmGFxJj8Juko4yNxQsdHMj-Q
Message-ID: <CAH4c4jLg+X-2AoC6WgHVkS7gR1Vr2zmEy-Sv-oey8sg0DU6ZeQ@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] xfs: fix super block buf log item UAF during force shutdown
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:39=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> [ Sasha's backport helper bot ]
>
> Hi,
>
> =E2=9C=85 All tests passed successfully. No issues detected.
> No action required from the submitter.
>
> The upstream commit SHA1 provided is correct: 575689fc0ffa6c4bb4e72fd18e3=
1a6525a6124e0
>
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Pranav Tyagi<pranav.tyagi03@gmail.com>
> Commit author: Guo Xuenan<guoxuenan@huawei.com>
>
> Status in newer kernel trees:
> 6.15.y | Present (exact SHA1)
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (exact SHA1)
> 6.1.y | Present (different SHA1: 0d889ae85fcf)
>
> Note: The patch differs from the upstream commit:
> ---
> 1:  575689fc0ffa6 ! 1:  9876b048d8f68 xfs: fix super block buf log item U=
AF during force shutdown
>     @@ Metadata
>       ## Commit message ##
>          xfs: fix super block buf log item UAF during force shutdown
>
>     +    [ Upstream commit 575689fc0ffa6c4bb4e72fd18e31a6525a6124e0 ]
>     +
>          xfs log io error will trigger xlog shut down, and end_io worker =
call
>          xlog_state_shutdown_callbacks to unpin and release the buf log i=
tem.
>          The race condition is that when there are some thread doing tran=
saction
>     @@ Commit message
>          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>          Disabling lock debugging due to kernel taint
>
>     +    [ Backport to 5.15: context cleanly applied with no semantic cha=
nges.
>     +    Build-tested. ]
>     +
>          Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
>          Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>          Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>     +    Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
>
>       ## fs/xfs/xfs_buf_item.c ##
>      @@ fs/xfs/xfs_buf_item.c: xfs_buf_item_relse(
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.15.y       |  Success    |  Success   |

Hi,

Just following up on this 5.15.y backport.
Please let me know if anything else is needed from my side.

Regards
Pranav Tyagi

