Return-Path: <stable+bounces-62762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88062941006
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41834281D05
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5CF194A4F;
	Tue, 30 Jul 2024 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM0E8zEq"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C41DA32
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336906; cv=none; b=r86qJvw/OZFl2MYeKUls3fR2CNhkdiDytsiA/GXmjGqaXGPef4bqqjpx8vlGOfBVp83aJ5leVJMpTItpUyp35TelMizhkfZTVCXy8FLjk3/1uKJqznMo/GASP7fYOuqXcacvPv+2ezyJzkqVrfHE1IZ7PLIfs/qCvRmKye5mtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336906; c=relaxed/simple;
	bh=GldJppHtw5QtjXpedPX9tzJA79Zo5wyZzlHOBn+0VKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEruejxsGyz86tRrFt/LpHEOhfZgL54M65xMQg+7pvKPh+smeBta9sv+mRAMkHk61BwDSJ1sO4ZN4wBH37WvsGA2RCpH3xK/AgmkcAuGYJDcGzE6Ls4e2l3XEFQ3Rj0T3R9E1FgG0/zwj6kp3ORIN2oU3zqGNereNVNMd8QV5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM0E8zEq; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-260f033fda3so2896269fac.3
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 03:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722336904; x=1722941704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeAdkBYSZaNxfPi5KLW5dl//O1yavqjZkiWcyceCggQ=;
        b=FM0E8zEqFbLrUAZcmSRObsfuqiD883ig9sKFCQhDmhqcfd8J/8w+aKedxLrFkljsp8
         1ll3RKnnpslVr8yUBcVF25M+BE2cC3TlVA8hS6mvMGQp/V+rznmCE5wDk3f+Lu3LHrv8
         w584FY5ci8188wsD+3gg9hsvF1fhfmQRzajHKmT6bk1fLQfjtM1KgQ27pGw1K/Pl8waY
         E/FZRB5XygHlh6U6tOEyLRjQae0phQ2/1EwmLr3ov9dYLZMaXBCv06UWWko19JAVSWkm
         mwuD1i8DXbZf8ZVErMXJ28aJGELoJwDz0k9pqKBgHX0X3SqlZ4nVPnG1QA90km/o4SPX
         RV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722336904; x=1722941704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PeAdkBYSZaNxfPi5KLW5dl//O1yavqjZkiWcyceCggQ=;
        b=Ifc+qI50gNU5cpkel9kSaoLbDxB9BjKW0ynVeRYsSBaJ4/w/4SoLvDC6oxQmK1HiBp
         rT15HFkx8uch6D6hR0mA36+EDsEn/iFRxBaI+QFRatWyScKAUCFFxFvqGjVTjz1ly3zW
         H776WqkR3jAPlyyl7XGCX15UVsrpgqtJh38+35tgqMJ1Brt8oJjIPstfnXEc3Kf2I8XF
         UnJgztDGxghjOa6/NUxAcRWFn9N9ecXekwkqh8j7JWTTOvPCzpfNtSzWbjFEgF2nc6AN
         /Kzj89rrHm8fQUDx6LC3XYdsGuZQa84RgUFQKf3ejbU2ypZin2+gttJ4MaXaDguALv42
         1fNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYidD7uaMNBYGC+Z6kr7pIZUbNarJT0lHvUPB1VekJUT+t2HdcR4tQTwbidVBxvwK3nPd7AtFzZSL0cZWV9hfVaET3UtdX
X-Gm-Message-State: AOJu0YwcCZI0AGgTmvbBIDEtzVLvhL2aVpp8E4PdksjDmcm3AjdsU6GU
	GNihBL1DE8Whpuwf+LZrDP2FORoC53nsauBgsiOHWwFNhrmU0F2uXf6Ggc6Ul2Wz3tm12zOV/QC
	7lgtdoP3aXzz6+XH1HN+cKoyuZShxSaIj
X-Google-Smtp-Source: AGHT+IEyg5Gte1xsZivnxQil6u+PIVohppRGiNWv3TpTvymk5VlrE8ZJtcPhLWfhry8+EPMnSrZH5BJXnoPSCM5Gj9k=
X-Received: by 2002:a05:6870:ec8b:b0:260:e2ed:1abe with SMTP id
 586e51a60fabf-267d4eed102mr11903636fac.39.1722336904367; Tue, 30 Jul 2024
 03:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024073021-strut-specimen-8aad@gregkh>
In-Reply-To: <2024073021-strut-specimen-8aad@gregkh>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 30 Jul 2024 12:54:52 +0200
Message-ID: <CAOi1vP_hPytqPrhgwL7Oig6wKLs0Z2qz3S5BV=VtepATGvvN5Q@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rbd: don't assume RBD_LOCK_STATE_LOCKED
 for exclusive" failed to apply to 6.10-stable tree
To: gregkh@linuxfoundation.org
Cc: dongsheng.yang@easystack.cn, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:25=E2=80=AFPM <gregkh@linuxfoundation.org> wrote=
:
>
>
> The patch below does not apply to the 6.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.10.y
> git checkout FETCH_HEAD
> git cherry-pick -x 2237ceb71f89837ac47c5dce2aaa2c2b3a337a3c
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073021-=
strut-specimen-8aad@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..
>
> Possible dependencies:
>
> 2237ceb71f89 ("rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive mapp=
ings")
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 2237ceb71f89837ac47c5dce2aaa2c2b3a337a3c Mon Sep 17 00:00:00 2001
> From: Ilya Dryomov <idryomov@gmail.com>
> Date: Tue, 23 Jul 2024 18:07:59 +0200
> Subject: [PATCH] rbd: don't assume RBD_LOCK_STATE_LOCKED for exclusive
>  mappings
>
> Every time a watch is reestablished after getting lost, we need to
> update the cookie which involves quiescing exclusive lock.  For this,
> we transition from RBD_LOCK_STATE_LOCKED to RBD_LOCK_STATE_QUIESCING
> roughly for the duration of rbd_reacquire_lock() call.  If the mapping
> is exclusive and I/O happens to arrive in this time window, it's failed
> with EROFS (later translated to EIO) based on the wrong assumption in
> rbd_img_exclusive_lock() -- "lock got released?" check there stopped
> making sense with commit a2b1da09793d ("rbd: lock should be quiesced on
> reacquire").
>
> To make it worse, any such I/O is added to the acquiring list before
> EROFS is returned and this sets up for violating rbd_lock_del_request()
> precondition that the request is either on the running list or not on
> any list at all -- see commit ded080c86b3f ("rbd: don't move requests
> to the running list on errors").  rbd_lock_del_request() ends up
> processing these requests as if they were on the running list which
> screws up quiescing_wait completion counter and ultimately leads to
>
>     rbd_assert(!completion_done(&rbd_dev->quiescing_wait));
>
> being triggered on the next watch error.
>
> Cc: stable@vger.kernel.org # 06ef84c4e9c4: rbd: rename RBD_LOCK_STATE_REL=
EASING and releasing_wait

Hi Greg,

Please grab commit f5c466a0fdb2 ("rbd: rename RBD_LOCK_STATE_RELEASING
and releasing_wait") as a prerequisite for this one.  I forgot to adjust
the SHA in the tag that specifies it after a rebase, sorry.

This applies to all stable kernels.

Thanks,

                Ilya

