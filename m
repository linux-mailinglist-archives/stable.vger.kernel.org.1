Return-Path: <stable+bounces-212799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L9QAP6Ue2nOGAIAu9opvQ
	(envelope-from <stable+bounces-212799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:12:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D1B2ADD
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EE4D30247F4
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A49E346E4A;
	Thu, 29 Jan 2026 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="p1RxjLD5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CB344DB7
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706628; cv=pass; b=AVjiPyV61NJfZLKSCwn+MjI0hlUXzSIOP29765ytZFl37H77JXbtPP6jciKUf9r69qzOPyJGfWnaQzCdG4aKFKya2h/Cj5UFVMaTEr2rjD9CZlglnwm214f/6tKm6FcC5jalGseVi+P+LnagAECKd91cf83Da11YHYMhSvzwXaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706628; c=relaxed/simple;
	bh=n3rWul1mPkMvcN6y/hYVs19xbPa6PYVXkQt0laaQL2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HoQ+51Kp1UAWj5Flr8EVYamVujSRgxBtYLPCc8Ylxq6OapwlzHyM4AH8JgBopIy/9j1mwZex7J5APiaGndQG2pXuFwFniT2GSGWzYCTsS5zGcw4Mn+iS0LCSwt1vJMKcxZSJXDxYB+zqL3o7J72hrXOeBr21oEwMjBktHiw+8d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=p1RxjLD5; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65807298140so2020950a12.2
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 09:10:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769706625; cv=none;
        d=google.com; s=arc-20240605;
        b=gKtK8DpHPgSDedvAeHhv3vyRMW1QFLDuk2TAmRQVxoOvr5/CAANpPclEzBvQPXuS+P
         FHfY+NSOt/bS1Eixwz61H9c7SW8xV0Ots22AEsqlENsadS7DEm35tgA9yy2J+7ayrx1s
         Q3LHLYJfEYw4ZjeQy8A/vOEXETLJFOJ4FBrk1eH622uUe7UWr1Q7KUaVLONeXHlfe93B
         rmJw58IEr60As4GwoRnEAYye5W44ZHdJeIW3DjRsj91S127q/LL3hVUvDrEDahKx3W2E
         4PZIFFDHiST8+ajouxqLQzYIlTRQfjVeODFJ1hIxndCi+XUL3fmDAbQ6MQZnykZEHDWH
         XvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n6OCmwX/j9Xn2LVH5U+aS18pnLbo6JaXYZFOm+PY4+E=;
        fh=qHKkEZr4JQdhgnbrEhc40JLsMchjXNzhvj6uEDHL+s0=;
        b=Qp/cZATHCRV1ZZQZMyRCWQAKLYvMtSi4jzWktHCdeK9pn/+StGxgZJtuXULQNc10rV
         IONlQeP1cwkj1JYuQ3Q8YplMIsEH5BoZooSdA0xWv3pGivDwR6dRDFEZilvkzWR56gi5
         PVCn3GsN/4v0kxyQWHEXg3NmoTgCnyp1sAQCakRrxk3f6/mD9EdxJkLKM3k8GW2393Zu
         CEF7yjHLv1MkNA9Tk3Gn0MFdt/sVoheDVwtbWu4cUWuZd9ILza+9L5TWijlNxvtsLuZy
         jCD3OEj4nJmzylYZzqxXe3kFZtq/3PiLwQIab9bmLZvlE+PrsWWAQZxiLdhi206JE2fa
         G2WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1769706625; x=1770311425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6OCmwX/j9Xn2LVH5U+aS18pnLbo6JaXYZFOm+PY4+E=;
        b=p1RxjLD5it9KjvzdLdoZ6xiDoilz9Yh+FZ6XV8XJpyoPKCuAX+WsZVJnczexDlIuch
         2TEokHmhVI2JHsAOes8z/iNpgQB++R8i9mPh3oqi0q0nQFkYC0O2lpCuYhVXox2IF3UF
         sq4XxUQfbuXKWrGyMAUlco9JFe7r/bd2LxQQRI/ZwC6VRk1h6paKq+Pq42xgMtELR7R9
         GE9HpT/DOYBX3TxfIUAZYK4Sg1r+RTKFgECbq7hV2x1mJC6NOW3PXn5o7P19040gM1/t
         3AmBZBvMkOGf7gSeSCU8tuAFiyKFyqHoDmPR5Wgx68xSKhoAMaWgqrbHZ9kR7hf7txF1
         xcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769706625; x=1770311425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n6OCmwX/j9Xn2LVH5U+aS18pnLbo6JaXYZFOm+PY4+E=;
        b=PlnvcdhCngoRAFGkuv2fPSHZp2bqrlWHfM2lyWRuJI9o3AFn235Pzf4NLLRdjVTfv9
         cqoLkmA5ShZVyn+xSEhd+XqEWzptKt8pvbufMqQHgrxHKG7yaf/MHNnFnOAN76GTlWZG
         5EfF+ZEtipFxCmml1H1TIv3ZsuSCZ6bvlTvG9bA+ihYVsCpqP5i6cFNg4mfZWTVa2buB
         mSQhIUte4PRlboShTEXNVDARbjYlY5OdGivSsou9+WKw11JHFAe0AKkyfYQb5Pv6h2gK
         Y4ir1Bh4Uv2cCH5x+5CG/Mvs1GOqknAGNWC580f6GURVd8dYYbKisXlqkXJTpn6nXtGi
         MicA==
X-Forwarded-Encrypted: i=1; AJvYcCVULLVCxHAlvo7lS2rePPIxdYKFKT6pF1Qz5BqMpZdkgT1apxKVRcO67ciwpNMR8c+Bej/sXC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdg+3XXB3Z90bXy7oYps2ZJDPrut3TtU4M4Ur8HSqG0GC+I8Kc
	r+8j0wsYuCb4GCp1BJZYYZHXYQvvQ8jS2q3HY1iJwACwy5jIP/hAoWK4XYXwR2hDLdyP40gPKee
	A1AKBPr8GFKPCBQND4nUarRYH/1EQraBnWK7SlNOjwg==
X-Gm-Gg: AZuq6aJRi+8exbWzwqYld/VlyCyK6cbVV59jW+ZyUkztmpTLZVjpkrFJZ2YJaDfcwNL
	dgnmA3NALWt8eHinMrQ+UzNf6zIsI/Me8RQWhgk7eexdJJKCXiCDxONlfLA77TqU0BxTZpuHYaV
	EVua4zM1+EgiDf/HjbxjF/tDxxUd5eAoqN32t95auEUVTvJIUFWy9cn6X11dA8CZCHp7JdW2Gd5
	S6qxMRwU6VRdsfFRcn235yT7z5jLrOfH8j58VOpkf/DbcupUu3dBKDBf2u4j8RSwaDtG03dXSUp
	FHMWJJ4NhoOLqsLBbmLqMQwwswtR
X-Received: by 2002:a17:907:1c95:b0:b87:6f58:a845 with SMTP id
 a640c23a62f3a-b8dab330a3amr682929466b.36.1769706624604; Thu, 29 Jan 2026
 09:10:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net> <8149b8cb5a7b36a1543ca05666f33a6373674e0e.camel@gmail.com>
In-Reply-To: <8149b8cb5a7b36a1543ca05666f33a6373674e0e.camel@gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 29 Jan 2026 21:10:13 +0400
X-Gm-Features: AZwV_QhsPnBR0plQowOsHO5YBq3ZTAUEr4l8UAag9_eqRFlaZuUYqpCOMut7ozs
Message-ID: <CAKTNdwG=He3iJ8cPo4fFbcEwQQRrt_SGzoviMhi2a3kMXAO8hA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix RPMB region size detection for UFS 2.2
To: Bean Huo <huobean@gmail.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212799-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[flipper.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flipper.net:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D2D1B2ADD
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 8:53=E2=80=AFPM Bean Huo <huobean@gmail.com> wrote:
>
> On Thu, 2026-01-29 at 11:38 +0400, Alexey Charkov wrote:
> > +                       hba->dev_info.rpmb_region_size[0] =3D
> > +                               get_unaligned_be64(desc_buf
> > +                                       +
> > RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_COUNT)
> > +                               <<
> > desc_buf[RPMB_UNIT_DESC_PARAM_LOGICAL_BLK_SIZE]
> > +                               >> 17; /* convert to 128 kBytes units *=
/
> > +               }
> >         }
>
> Hi Alexey,
>
> thanks for your fix, I didn't notice there is UFS 2.x on the market which=
 will
> use UFS OP-TEE RPMB framework.

Hi Bean, it turns out many of the UFS modules for Rockchip RK3576
based devices are 2.2. I'm poking around the OP-TEE support on that
platform, and discovered that the existing driver didn't see the RPMB
at all, spent quite a bit of time trying to figure it out before
spotting the difference between the two spec versions :)

> here is potential u8 Overflow, since for the UFS3.x+, it is u8 in unit
> descriptor, but
>
>
> The calculation can overflow for larger RPMB regions (>32MB):
>   - A u8 can only represent up to 255 =C3=97 128KB =3D ~32MB
>   - The shift result is assigned directly without bounds checking

The spec says it can only be up to 16MB maximum (see section 12.4.3.1
RPMB Resources), so it should always fit. Happy to add a comment about
that.

Best regards,
Alexey

