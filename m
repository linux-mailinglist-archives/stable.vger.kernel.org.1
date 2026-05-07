Return-Path: <stable+bounces-244639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GmtL4/+/GmxVwAAu9opvQ
	(envelope-from <stable+bounces-244639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 23:05:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 681B14EF1A2
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 23:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352E5300A3A5
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D4F339B41;
	Thu,  7 May 2026 21:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQT7y8zJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF2301717
	for <stable@vger.kernel.org>; Thu,  7 May 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187914; cv=pass; b=marlzVgjs1wiv1oqYApJL0RxtDBhTV3C4WOcY2g7Jsj3pIaXxweLbiQJGvJJjkHM4UHnzu/vVtGX7HGE/Nzrv97os3n397qPuDPXrAXFt94Gczh7Je0Hbk3sx+kvfHU/cPGcK5ydQxu7RC/PqgSPYiXM3EuquWW/8AgbrsWegak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187914; c=relaxed/simple;
	bh=jE+/jUqv7pNoCfzauPI8lFa2VQ2OKNCvpXHgcRT4LRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2q4ZMzrmxDhHwni0S6czd7nhMBDOCv5vnBi0alEQEu7E4qYYEHRd4etbP7PqKoUkAiOAjRFhYAaqy9uKOf7yGAStIN+EbRLqivG1dpEay8yU795QQERfwDbMuKNDhByaDdVhd7H2qGC6qzN5eiAIQGK4tT/hF+omE5H4s1Cozo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQT7y8zJ; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4233e152457so923495fac.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 14:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778187912; cv=none;
        d=google.com; s=arc-20240605;
        b=I5S65z7A0aTvZbNNySyuNKS0BJl9JxN+jJ9VajfSF39IgtYPEd+Jnl+zc03ZJBUzI9
         +hvXJ7M/NH4sCHzCcezasyZLx2xHyrX7UJygHBJq+rOzKNsH44MY+8bYxiqoR6TQA1QL
         X7YFhKeN7zSYN3z3u3X9Sck3EN/26tGi0WUsZvK/o2AUolgm9YP3HoFMXNZp8wdy09LW
         9nGr0jmoVIcCldYNxsXbJO8T4iu7KZOveotLVWymKPcd92IDmMWcC6fny9eW5KLyJ9zy
         rmrjoMNM0pPkoOPbUgaB11B42LTdnsKu71POEX1VEFvwIYUhxgk17bHM3Z2NxnXjGhm4
         wUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uM69f/OhaRvPDM2WKfYEa4uqX5GcZJHERLXCxzT36H0=;
        fh=c3v6T6Egs6fcOtJ/0OIWQZgJuumzWQsBKMYN35K+QxU=;
        b=bShWBQxq1NwZFHNy46vZtKxTt3IU7kpQm0XQ+3VWrxbbLBjrC8AfCPwtUdSuH7Kjcb
         p6R2iSvJJz2RoekWFXqMz/mKq73DQGm86pyK5TxoyBW4XtLM0vg6wv3DCUM+CrI97XMG
         hq+tDI6PTRhOjUYPdkyashEGfVGkLTSqD1wRtVnGtEMmV1I8tWXnGnuiJMPIyupPnV9F
         jVa2F1lJMliM9Wgq+2t2WS07uR+3bdi2GITkuLsxX+VyGAI0wKtUEH+Kmgck601YxXF4
         lfhD5Q+6W1cM4UlqqLpUJl8veCuZ4NM/3P5GZdGy2YaR9oQqEIVJ7p39j31R7lpPXO0h
         pKUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778187912; x=1778792712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uM69f/OhaRvPDM2WKfYEa4uqX5GcZJHERLXCxzT36H0=;
        b=UQT7y8zJUNngkSy3gAzw+8rnMY8/4vXj/C4XUhtCXuZKbCwGD1IWospAmNDp/u9H9V
         cSkI/H6ZBC4CzjZu2TDCmDKKSEQPgRdM8rrTSnu4gcJGMNVEYa1+bFqCs6kuPIERcSwa
         AI5AdSSbFFPiTo5Ta0VV2TpmL2PewmKgmzqYVBJvyvSs34Z8C24fdEmKzUX1zT1EIqhf
         xivwaVHal57PDDpLd83JYYT312jJRAWhT5qJAsbEMizoQuSjfDJmBf0IbltnBAGDBuZj
         F7en4wISZsCo8VHYNqRg6vWpT7zaVBcibcye+4tXhU+mKTNrVJEPWfZJooijv/Leu5zy
         bbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187912; x=1778792712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uM69f/OhaRvPDM2WKfYEa4uqX5GcZJHERLXCxzT36H0=;
        b=Lr9OCYsUY1M2Z/giisfncB5xPJC3bgqg8Hi2JKGJyorfzYThlQKyXrfLvrQcleOSNT
         2lMQy9pAMUe1qdb/Oy2IRp0c7XlTah2Bt25M3Fp0EfHjMyMVu4dWMqXlyivV+3sHgTbO
         lFHREk8j0xLRr3n6+2O3m9Q3qLsN+7bsjzhtVjuhLBQwLTmcsWW09IBnQW86AAilf0q5
         4GdiAVrtHB2IdYmLi1Lgew3jX+yynzLXgIpZAKGjpha6DuPkbsZhp/T1P0tQRn7RSy3f
         cbnHNHawZ8HwrTzgVx3+ITumx//hoM5KF7mBORR64xZnDdz+jpDXoRsgUinnVUsi/DuF
         xtaw==
X-Forwarded-Encrypted: i=1; AFNElJ+pRMTbmX0mjaOO51LgBHxj3jBIjxSgr3Dt5mfRNCyDnic+utMVMQ3C1eP2+jykW4DbKThX4nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKexaMetQ5W2udbL0Mfn3v/BKvmdu1l/wO+A47hR851GxBPcNx
	DVtB/mseu3udgsSfuea/92fk+CAZNBGRLLbGqlc3ERA7x5ngnZR1Wv/HZoaz/UmWDKvE/rkhDDa
	iTvUQwjWCuWOES6ROheTms4tie2M2jUY=
X-Gm-Gg: AeBDieuEJxy0nDZgoPImSQQ0mUIpgcxkUT87lmVbAmABCsUgR01i8KRB1q00Rz/By86
	epHoyeeW8VdpC5Vf+NmCKMZ22Mo4LsAR8rtX60I7QPdLfVEGAQ00GLeguBCkLdk3B/vZ16XMxwS
	8lnMsWa8R7Ij+xAzuz1qsbpD/Mu1VDfao/1NylOu6PagBjfeDM/LFEHEClVK1GItm21DvqgUsap
	a+NNIoUb/4upJlmdx0GTTdqHhlrKmL6pLct7+w0HOHfOYMYdzFXPf3ANgxHekE7KkH8sH16sFl7
	kq+tob6QeSBoaHla22n8bFSUEQThiXShlkcKGQ==
X-Received: by 2002:a05:6870:9120:b0:40a:605b:518a with SMTP id
 586e51a60fabf-434f64f0e2bmr6401085fac.27.1778187911702; Thu, 07 May 2026
 14:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507022213.29290-1-dennylin0707@gmail.com>
 <20260507022213.29290-2-dennylin0707@gmail.com> <CAGEkeHc2MiJenQnyHa8wwYxpZfaBwZpy3=iXJCjAjvXrs9UsiQ@mail.gmail.com>
In-Reply-To: <CAGEkeHc2MiJenQnyHa8wwYxpZfaBwZpy3=iXJCjAjvXrs9UsiQ@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 7 May 2026 23:04:51 +0200
X-Gm-Features: AVHnY4Jo1IyTHyb9HmNlTOZ-S9HjOMOViUseCpdHPNPhWjhasIYCpZvP3cqqYK8
Message-ID: <CAPybu_1RvjRQ5ySkJum3AzTX9-bxmNmkcMMK7Q-Q14tZPSQHnQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] media: tegra-video: vi: fix invalid u32 return
 value in format lookup
To: Denny Lin <dennylin0707@gmail.com>
Cc: mchehab@kernel.org, gregkh@linuxfoundation.org, luca.ceresoli@bootlin.com, 
	thierry.reding@kernel.org, jonathanh@nvidia.com, skomatineni@nvidia.com, 
	digetx@gmail.com, hverkuil+cisco@kernel.org, dan.carpenter@linaro.org, 
	linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 681B14EF1A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244639-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardoribalda@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,bootlin.com,nvidia.com,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,cisco];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Denny

On Thu, May 7, 2026 at 6:06=E2=80=AFAM Denny Lin <dennylin0707@gmail.com> w=
rote:
>
> Hi,
>
> The media CI reports a missing Signed-off-by from Ricardo Ribalda,
> but this patch was submitted directly by me and has not been handled
> by any committer yet.
>
> I believe this is a false positive.

It is indeed a false positive. Sorry about that

Regards!
>
> Could you please confirm?
>
> Thanks,
> Hungyu
>
> On Wed, May 6, 2026 at 7:22=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com=
> wrote:
> >
> > tegra_get_format_fourcc_by_idx() returns a u32 but uses -EINVAL to
> > signal an out-of-bounds index. This results in a large unsigned
> > value being returned, which may be interpreted as a valid fourcc.
> >
> > Returning 0 is not a valid fourcc either. This condition should
> > never happen, so use WARN_ON_ONCE() to catch unexpected out-of-bounds
> > access and return a valid fallback format instead.
> >
> > Suggested-by: Hans Verkuil <hverkuil+cisco@kernel.org>
> > Fixes: 3d8a97eabef0 ("media: tegra-video: Add Tegra210 Video input driv=
er")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> > ---
> >  drivers/staging/media/tegra-video/vi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/m=
edia/tegra-video/vi.c
> > index f14cdc7b5211..456134a9e8cf 100644
> > --- a/drivers/staging/media/tegra-video/vi.c
> > +++ b/drivers/staging/media/tegra-video/vi.c
> > @@ -80,8 +80,8 @@ static int tegra_get_format_idx_by_code(struct tegra_=
vi *vi,
> >  static u32 tegra_get_format_fourcc_by_idx(struct tegra_vi *vi,
> >                                           unsigned int index)
> >  {
> > -       if (index >=3D vi->soc->nformats)
> > -               return -EINVAL;
> > +       if (WARN_ON_ONCE(index >=3D vi->soc->nformats))
> > +               return vi->soc->video_formats[0].fourcc;
> >
> >         return vi->soc->video_formats[index].fourcc;
> >  }
> > --
> > 2.34.1
> >
>


--=20
Ricardo Ribalda

