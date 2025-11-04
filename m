Return-Path: <stable+bounces-192398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AFFC316BE
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 15:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0035E421A1C
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 14:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB1D32BF48;
	Tue,  4 Nov 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqBFoHXh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3432B9B4
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762265158; cv=none; b=GuB8wXUZ9ada72Dw/vH/OzpcjWuotIU0Nj1e/kSG1th8dBlCuGVrge1vU1hi8ZMdVhMzsJ3SozO5iO2ckyX+pWn7ynwuL78o07lOWB7KrJEfQDjlgxAnk5+YDr9HC5VmR54QiQWI3xF2yURuVD2vqPPwvlvf6S/H0KxKFR9P5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762265158; c=relaxed/simple;
	bh=xwNceA9wbeOqYxoJU3Jt1SIQ1eC8AGuVP4fS8PiKhhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsmJcDQKQpUsGlu3r3VRJ6VTq9a2HzJKJ+M//OPt9Tm4wQT9EVfXCwUocXjkH2C9G95ElGDlPMt0XHLA0n/NeTwFtOf9xIALOxyhMzYkAyqCpMJr+9nFkj/FdMRQVALZ0ZBWxhmMiu1+C6JJj5FU5aDW1vN2omC3AKAjO2E7oPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqBFoHXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AB3C4CEF7
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 14:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762265157;
	bh=xwNceA9wbeOqYxoJU3Jt1SIQ1eC8AGuVP4fS8PiKhhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VqBFoHXhz6diMg/8q0xA7OPm5EkEB54OVdv1aV2fvm8vP1O8B34q8B1baEukkrXTY
	 8+Ynm23qDkV3NOChiO78oPJKCcNfUbv74a60dsEHeA6UeXEx28NRqnL7/4NsnvGTij
	 kWoDbmhAAgHDYk9cs2pIVQsF4k9xfdf0jyAcZbtdMXKyQ2N6FflV+qxyocpAG8nI+z
	 fVx2mCBvclXnBSt76MXOZgl5/G8w0qTfYx20aPuv3oiINUiOulxRvi4Q4v5T6Qdj56
	 2/DT4HlBjBq4gvwt59p93PyeZwvpQYWrwMNMF3oO21famAzI1QJy9CtuIK0APrv3b2
	 y0X12tOqOr+Uw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b472842981fso716261566b.1
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 06:05:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtht0mGfKYkPIN7+6jUka/R/zZN+fcsGUtGsLMJS8wA1bjjchQsYp4+/KZ5F279zqwe/9jmJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8YBPdqKWf/gouJAXEYwR6tJPWPqStxswCeNAo7ucjm05m0wD
	g6PIW/ihhzXfOuC12+CvSUP5Bj3vKzZu19ahmhwkBgJjqdkoRGTQV1bytp0uW0kjHDdbfssbu0F
	vq7MDfSqRg/Rd065jAGCNquHCJBkKyW8=
X-Google-Smtp-Source: AGHT+IFRHXrgFcRL1kF6f7O7o4U2loCiIItvRf1yYOccI40aSz2GtslTGdxn8g9J/CSSWk8lxoqLVHVURoUzpviRt1I=
X-Received: by 2002:a17:907:7252:b0:b46:8bad:6981 with SMTP id
 a640c23a62f3a-b70701917e6mr1848664066b.20.1762265155999; Tue, 04 Nov 2025
 06:05:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104084509.763078-1-zhen.ni@easystack.cn>
In-Reply-To: <20251104084509.763078-1-zhen.ni@easystack.cn>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 4 Nov 2025 14:05:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6QKShugKSvTrbYw5aE8mWmYth55jJ2c8cNJVP_XQTSVQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmbyp8qWqgrsAg7ufQXCfXSafXLHCiRemr0CtzT2PZBHt9N6niDcvhg-gE
Message-ID: <CAL3q7H6QKShugKSvTrbYw5aE8mWmYth55jJ2c8cNJVP_XQTSVQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix resource leak in do_walk_down()
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 1:21=E2=80=AFPM Zhen Ni <zhen.ni@easystack.cn> wrote=
:
>
> When check_next_block_uptodate() fails, do_walk_down() returns directly
> without cleaning up the locked extent buffer allocated earlier,
> causing memory and lock leaks.
>
> Fix by using the existing out_unlock cleanup path instead of direct
> return.
>
> Fixes: 562d425454e8 ("btrfs: factor out eb uptodate check from do_walk_do=
wn()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  fs/btrfs/extent-tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index dc4ca98c3780..742e476bf815 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5770,7 +5770,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>
>         ret =3D check_next_block_uptodate(trans, root, path, wc, next);
>         if (ret)
> -               return ret;
> +               goto out_unlock;

This is wrong and will cause a double unlock and double free.

When check_next_block_uptodate() returns an error, it has already
unlocked and freed the extent buffer.

Thanks.

>
>         level--;
>         ASSERT(level =3D=3D btrfs_header_level(next));
> --
> 2.20.1
>
>

