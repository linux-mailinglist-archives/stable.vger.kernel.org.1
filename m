Return-Path: <stable+bounces-120351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B4FA4E8DC
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B398C20E3
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 17:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69173296165;
	Tue,  4 Mar 2025 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FwNzJvuO"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857229616F
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107098; cv=none; b=P6s7vzXFn8czWa1XNzr/Av8BdItJ+pf/pHEQjPbsEDPr+zgrRl/g6GTR0KSNttCvZcz65cxPzYPSLicEh01hSbFmJx2DKEA4q3gEkJQHKu/RE4+zy+vrUcNUMAfXWFYTqaif3iBrXO8fAJHSU9WKPINEVr98qOr02qoMYXDfTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107098; c=relaxed/simple;
	bh=2JHXxXzhmpb0OX2lEi1YmWa9UaEMzszdSvf5a4zV9V0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXqvTpqcR8pbH8QnVK5x3qaT5zUj/W58cuZIky5gD2wN4XXf4B2vqVNWbnTcDYXhGpxNiQ33p5Czwd3ehRn86A6qaEyX4VZC2Xzni/JKlxt1TXJ5sLb20nE3HcbRCDDLcFV8/jXMCPxoLHXmc/ekNRYAOHy2geedb6Zi1A2CGUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FwNzJvuO; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so6489434e87.1
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741107094; x=1741711894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDh2ShgJFeYs9YZdId5VqANVdklC8j4ZumycrihxHA0=;
        b=FwNzJvuOVeWD/JpfuZFHaXrEaqNHsrVhXv+Doti+mZVAqVXnVeCJCI2UKoVcvLEHZZ
         wdm1aq6ucIwHgrMM0XoxddwPBJSCV2eXOvqetz85g1VjxavzZ19a0E4/MDu69o3c7H7L
         zQ/v9uxIqyRk466oEQOccYby7l4II4o1Fx0hFmaG4Vcxtn41CHZ6iwdTfStPiA2cevbt
         vEs7F+bQKdQHpmt0HyxyB5hDbdtssuhqsC+LhwIGiZVCf5aGa0r/rl6w1zJ/jM8DtvPb
         nNw/MAtDAT1YflmIY3NylkrW7oWkfrAtw9W4tiFEvkrwYucJloruM/LmKtLhvKQBwT/L
         w19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107094; x=1741711894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDh2ShgJFeYs9YZdId5VqANVdklC8j4ZumycrihxHA0=;
        b=bVPpRlA1cAQ4ykGJ5klsL4j45A/byO01ylnKPZ6EdSTV5teC0ZFUob2P6jNOq+lTn5
         2HFTPfr3mmwomInaiaZVh/dtTYfjaJWO+e4jS+c87TX+kXV6a/mhvSJmpLFXobwA9Bp0
         VXDIurZZQ94aMTxScY1msvGrNDUvo5p+mywzsSKiAjE/rdb2hdeCb0hx0YtLdk4iad1w
         ilGrQED6AKLKjQGNtXkYOU0tgJKSLDeVfDfy180VZzK/cggcytEZXZwMKira7dm97xoY
         ue8q9E2smP/ithVajVpNu0jjqoPlrRg0UCZMLX+4TmZquTcXFRf8fRzjNMtyWbD2A2N+
         168Q==
X-Forwarded-Encrypted: i=1; AJvYcCV69LQ0sA59H5Loq4pG9vVPtLcc308X4vlJC4pBkJLHYchIflvVn/8rsJp9eN8l1buogQyhjk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyty5e8V2bGpkboTYmFQ1g+4Uy+DIE5lI+2coU/VVgfiR9cB3WK
	dAor6lYamOC0zzimmooEJGVWM+/4pcEmSmcN6gt9aCYP9xQGV/MUtjrIByKPTioAwpsEGFfkgNv
	3jHc9fIUFApRymmr+v7jrBfZ63tYpF4OOM2NqJg==
X-Gm-Gg: ASbGnctlF5sGBM+FRW632h9vRJ5ZuyyW4z37Y+g/nBAYQxa60IRbjI6sWPsHC8qmpvI
	xU4QlkdenFKQmXZa672w80A3uvYbK4eDZhXy7fOP8hsLT46lJz3/k4wWnbAxAq+JswgU0ghHmsm
	Zc7OPJDBikJCTTcV+PCNPpYTemUW0ErPbVrCqzUO/gsQiussO0/teKtYaK
X-Google-Smtp-Source: AGHT+IEyBeEasaks1DqLAXD3qVdr0T57ZO9UNgUe1QVFUg+iLloSpXiDivArAUmEYp/N4JWWXmGfD9mHe5fRzFP8+H4=
X-Received: by 2002:a05:6512:3e0c:b0:545:bb6:8e32 with SMTP id
 2adb3069b0e04-5494c31a221mr8475997e87.12.1741107093672; Tue, 04 Mar 2025
 08:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025030445-collected-spoken-1e75@gregkh>
In-Reply-To: <2025030445-collected-spoken-1e75@gregkh>
From: Filipe Manana <fdmanana@suse.com>
Date: Tue, 4 Mar 2025 16:51:21 +0000
X-Gm-Features: AQ5f1Jqq9_zvNpAc-d1S4lEPjfdhW6fnixP0cjwlEBPisc4vwmCNRfD-cxcvi_s
Message-ID: <CAKisOQGrtCty9g7DkPXqp3Ox8FyF+zKe5fjPGA=H7s0XFgt92Q@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] btrfs: do regular iput instead of delayed
 iput during extent" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: dsterba@suse.com, intelfx@intelfx.name, johannes.thumshirn@wdc.com, 
	wqu@suse.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 4:33=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 15b3b3254d1453a8db038b7d44b311a2d6c71f98
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025030445-=
collected-spoken-1e75@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 15b3b3254d1453a8db038b7d44b311a2d6c71f98 Mon Sep 17 00:00:00 2001
> From: Filipe Manana <fdmanana@suse.com>
> Date: Sat, 15 Feb 2025 11:11:29 +0000
> Subject: [PATCH] btrfs: do regular iput instead of delayed iput during ex=
tent
>  map shrinking
>
> The extent map shrinker now runs in the system unbound workqueue and no
> longer in kswapd context so it can directly do an iput() on inodes even
> if that blocks or needs to acquire any lock (we aren't holding any locks
> when requesting the delayed iput from the shrinker). So we don't need to
> add a delayed iput, wake up the cleaner and delegate the iput() to the
> cleaner, which also adds extra contention on the spinlock that protects
> the delayed iputs list.
>
> Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> Tested-by: Ivan Shapovalov <intelfx@intelfx.name>
> Link: https://lore.kernel.org/linux-btrfs/0414d690ac5680d0d77dfc930606cdc=
36e42e12f.camel@intelfx.name/
> CC: stable@vger.kernel.org # 6.12+

This should have been 6.13+, not 6.12+.

So please ignore this for 6.12.

Thanks.




> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
>
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index 8c6b85ffd18f..7f46abbd6311 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -1256,7 +1256,7 @@ static long btrfs_scan_root(struct btrfs_root *root=
, struct btrfs_em_shrink_ctx
>
>                 min_ino =3D btrfs_ino(inode) + 1;
>                 fs_info->em_shrinker_last_ino =3D btrfs_ino(inode);
> -               btrfs_add_delayed_iput(inode);
> +               iput(&inode->vfs_inode);
>
>                 if (ctx->scanned >=3D ctx->nr_to_scan || btrfs_fs_closing=
(fs_info))
>                         break;
>

