Return-Path: <stable+bounces-192714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6357EC3FB47
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 12:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DCB14E42DB
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692D31DD81;
	Fri,  7 Nov 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUkZvzKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD629AB05
	for <stable@vger.kernel.org>; Fri,  7 Nov 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514417; cv=none; b=lulRHliNNyCR48R7qupeMELMDj6L/SJGgftmEKTku3PMl/a8M4fPCs9RRrh1uqRjpN2IelZZ4Ira/O1Y/S76WDfJlLT5JWYiS2hbaxnvzLAtXR5GlzF7Uu2RvFfb1PSfdoPxB5GW8gqZy3jPj6+A6LnG2gvafNRr0JKof5NovXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514417; c=relaxed/simple;
	bh=BRaK+VjCK1hNZi3/Bm25vdWhbCF3f4DmIMNp6ZePR/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl6Gty86vVTYKjoZ36cxmSbtwxC/A8ausc5dNAV2QEz2Da3UFBsigzR9wKU7vJlWBj6of+opp8n1Sp8JN2YlGpmuoYGaBFnTuZ+FZAqwfisvN4Z+l8Jmun8K3Cq7kz6W0lswQqlpo8DfHAGiNkBrtAeImorKFLHiWEhhg/Chlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUkZvzKt; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4ed861eb98cso7796151cf.3
        for <stable@vger.kernel.org>; Fri, 07 Nov 2025 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762514415; x=1763119215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCuntcHPB7jt7B/bSZdm9gqlzC6yu+GRicnaUIhJiE0=;
        b=jUkZvzKtLY+JSbhFO4QDQAGxkk4ytJCkr8KMyQ/klCNASqBvBpGxSiLm2fdHMiJCKO
         Ut+ahhOqbegytRzh+KR5nabbJRq2vR+cB3X73kbMFv+Q10e7un0CORbff6BDJdwk684P
         gWKx+ZSUDBI6680d7NmVMabEKpPAvNxb96FRI/I3EutuLavhEQGAMNeMGzydzluohZTG
         vxgnvW9dPj+MV0o+w14sN24hebsdyN2KRBmxOkxQAzZ/g+0EDS5GYnh9S4xbdunYctQe
         BC9KASBUx8/3VYjCTQ5AYZuc2ZDiaLAYBY5QIqvSBE4liwEqaOcQ/8lQvJMDx2EPOgST
         XAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514415; x=1763119215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCuntcHPB7jt7B/bSZdm9gqlzC6yu+GRicnaUIhJiE0=;
        b=dZqFqyHeKqJaw2LGM5IONRAJBG2C8VTZ6Pv6eqA28FTyOx2TFZlmzeT6Lggb0QF0Rl
         H67GoEhVH2/G+Dee/jNXVU9Hh1VriZS3nPEXhj++7lvhlHFnSShRJ2bETjAT/kzAFiCY
         30eaedc+DWRhyyF43IdGZgT8QBoqHs9q5N81rU/P9Ee9WeoI+8uOqlCyDJ004nAWqXoa
         JBleL4c0QxI43BfPgg5/DmsIEumRU1Qr74JVqKElAjh8UatMeKRsWBDyOUuFu/rHn8z9
         EircKx08QijjpRbHlAqfQcM+s5FXlB4WsR6W5x7bGDPoaCE3jsrPaeEEwu53DntnptT9
         dRaA==
X-Forwarded-Encrypted: i=1; AJvYcCXs3W9Q54a2rNMpbx7LBaAI0y3s0GTy/DBlm9G2i/bDOwfOX3kAR6Mvi6vAQ8tGdP5oRRIvZ/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbiXVaptiqitub8ySzzXdqeajNc/C4XZD2vcCg6Af3yWAPKOmE
	j1sD+N+yN4GrquNzCIjISCZ3Ajr3Huot0tL4KgNsWe9MLebxFJovtkD79LGAVw+Uuwj3wBSe13W
	sTcc57M7O4ZZu1j2lWd2M5xHq7sMR7L8RDhi3pQ6B
X-Gm-Gg: ASbGncuRqUUjROtY/KzIumt5XnWh9HtTNB0DZW9mMjHytVAgqrABneaeXMT2Hrw5Okw
	nA1CgHA8POsn4I/Wk5RF+l+ZJnft0K4xH0mSvC9p333bTxSqS7b35a1Tu3vdwG3EkbufpUpdGfw
	Qlh+X8F2Z46zsqusX3FWWp/+VXrhVClR8Aguo9nBmlJRz9JoRuO0BnRZqjzNJJip85ReQkEZubh
	WLW2fgxJ10E8w2bTMVSpmWuFTZgvZrpD34/ZitQzj/TnRylc6JTXF7qQ0wYhw9RL17NWZNB
X-Google-Smtp-Source: AGHT+IGC3fYMjryS9zADloir/gP2Yamma9UjG5JSmMf62xT/E/o9kWnU3HSHFswBMiaxi1WGy0axf3d/DY0sMx5XNcM=
X-Received: by 2002:ac8:5702:0:b0:4ec:f969:cabc with SMTP id
 d75a77b69052e-4ed9494e284mr28907961cf.10.1762514414438; Fri, 07 Nov 2025
 03:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107080117.15099-1-make24@iscas.ac.cn>
In-Reply-To: <20251107080117.15099-1-make24@iscas.ac.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 03:20:03 -0800
X-Gm-Features: AWmQ_bnEuaGnleUmw5tdQ2p6tHQd4r5RAkYYgVZBqY4gtBL8VHSKOH_-igWdJDQ
Message-ID: <CANn89iKswhYk4ASH0oG1YbvNsP9Yxuk4vSX5P45Tj_UY+s16VQ@mail.gmail.com>
Subject: Re: [PATCH] net: Fix error handling in netdev_register_kobject
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, atenart@kernel.org, kuniyu@google.com, yajun.deng@linux.dev, 
	gregkh@suse.de, ebiederm@xmission.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:01=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> After calling device_initialize(), the reference count of the device
> is set to 1. If device_add() fails or register_queue_kobjects() fails,
> the function returns without calling put_device() to release the
> initial reference, causing a memory leak of the device structure.
> Similarly, in netdev_unregister_kobject(), after calling device_del(),
> there is no call to put_device() to release the initial reference,
> leading to a memory leak. Add put_device() in the error paths of
> netdev_register_kobject() and after device_del() in
> netdev_unregister_kobject() to properly release the device references.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: a1b3f594dc5f ("net: Expose all network devices in a namespaces in =
sysfs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/core/net-sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index ca878525ad7c..d3895f26a0c8 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -2327,6 +2327,7 @@ void netdev_unregister_kobject(struct net_device *n=
dev)
>         pm_runtime_set_memalloc_noio(dev, false);
>
>         device_del(dev);
> +       put_device(dev);

Please take a look at free_netdev()

>  }
>
>  /* Create sysfs entries for network device. */
> @@ -2357,7 +2358,7 @@ int netdev_register_kobject(struct net_device *ndev=
)
>
>         error =3D device_add(dev);
>         if (error)
> -               return error;
> +               goto out_put_device;
>
>         error =3D register_queue_kobjects(ndev);
>         if (error) {
> @@ -2367,6 +2368,10 @@ int netdev_register_kobject(struct net_device *nde=
v)
>
>         pm_runtime_set_memalloc_noio(dev, true);
>
> +       return 0;
> +
> +out_put_device:
> +       put_device(dev);
>         return error;

This seems bogus.

Was your report based on AI or some tooling ?

You would think that syzbot would have found an issue a long time ago...

