Return-Path: <stable+bounces-6368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB45780DDCF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 23:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A798B214C5
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A355774;
	Mon, 11 Dec 2023 22:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbQc/Fzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0B11A4
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 14:01:49 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-42598c2b0b7so32931cf.1
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 14:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702332109; x=1702936909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYuCFWZ1VmS4Lp7mhYmBi3WLT2kfEMP1dhisfQvZFgw=;
        b=jbQc/FzoQskB9snNjp2zLzlHoN5UMppr5uib4DOWTPTVjxAWvzM4pPsMkAELFUn4KW
         ihg04OskZ9vwxupwWsWXj2cFkGjHuT+4CpqpktX/SopU3iTJ334rhhoP13bD2AyKPRbn
         mUUBMjRPg9r9i8xCSRbPvpMsY/KID4/L+HSwu/C5aJX016g+dEdQW7+banoOwyu8gzpL
         IPA0bNb0EfBHVMLo4PXMCz+vkxM+uj8kLk2x0bEjibTC2ut/W40yUCs6JCnwpkZ3lxij
         OENM6rxnCRFHfDJCAQ+BdOHL3vcz5wZAnYgTdyFy2jIZQDLIygi0i90nUcnr3z68/kxn
         /E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702332109; x=1702936909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYuCFWZ1VmS4Lp7mhYmBi3WLT2kfEMP1dhisfQvZFgw=;
        b=rNdG4TIZ98L9fF5iPBnb79/adaNLLGeQJ5gxrWYSgRKLHJSUoIux7wvyERgFwIyCsk
         XWUr2Lc9Sb46GQiGnARkNCZ6zS3RneP1NGPIhAEyH3SuPcXgekX6VpasLNMH22TiofSs
         LNNuWLQbyjgAija+DWOu8bD95xLuvlogCQXyUrdCt+LSMMPBT0xjorfnPfiSs8PH0DEL
         gGdncUlCQIvdD4EXN7Ry0wSeVsAS1yk3sicjcLcvHm5RSBgupslxYDwf8/vSNOG/JH4s
         xvAEbZOtm7jmm/kaqZCqUohLHjHSRPgo9hUJneFeeTlV1StiOZkBrBCiDtoINQhko6UZ
         I9qQ==
X-Gm-Message-State: AOJu0Yy/2XNoN+Q05/0s8ZZz92pbNfFqtCE7thQ3F5zT1Ul1tJ4tA3kZ
	6rDF1wd/SlNxFeq8+pnFIY5HRO53axWj9fv2JHFbbQ==
X-Google-Smtp-Source: AGHT+IH2IiHUqiS+hDMAihXMhQybFlm8Q+pUYtSDNA+K//Qg9HawPEM7ueM0PxZfERfjiArm+ASOh3BFax4JtNQiks4=
X-Received: by 2002:a05:622a:1b91:b0:41e:2bad:f3c5 with SMTP id
 bp17-20020a05622a1b9100b0041e2badf3c5mr823643qtb.9.1702332108841; Mon, 11 Dec
 2023 14:01:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com> <20231208061407.2125867-2-yuzhao@google.com>
 <20231208110011.102-1-hdanton@sina.com>
In-Reply-To: <20231208110011.102-1-hdanton@sina.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 11 Dec 2023 15:01:11 -0700
Message-ID: <CAOUHufacCTtUE6y1x5j+6Hp3SGtWu1-u38JHTR1z6JqU4cU8_Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 2/4] mm/mglru: try to stop at high watermarks
To: Hillf Danton <hdanton@sina.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, Kalesh Singh <kaleshsingh@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 4:00=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Thu,  7 Dec 2023 23:14:05 -0700 Yu Zhao <yuzhao@google.com>
> > -static unsigned long get_nr_to_reclaim(struct scan_control *sc)
> > +static bool should_abort_scan(struct lruvec *lruvec, struct scan_contr=
ol *sc)
> >  {
> > +     int i;
> > +     enum zone_watermarks mark;
> > +
> >       /* don't abort memcg reclaim to ensure fairness */
> >       if (!root_reclaim(sc))
> > -             return -1;
> > +             return false;
> >
> > -     return max(sc->nr_to_reclaim, compact_gap(sc->order));
> > +     if (sc->nr_reclaimed >=3D max(sc->nr_to_reclaim, compact_gap(sc->=
order)))
> > +             return true;
> > +
> > +     /* check the order to exclude compaction-induced reclaim */
> > +     if (!current_is_kswapd() || sc->order)
> > +             return false;
> > +
> > +     mark =3D sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERI=
NG ?
> > +            WMARK_PROMO : WMARK_HIGH;
> > +
> > +     for (i =3D 0; i <=3D sc->reclaim_idx; i++) {
> > +             struct zone *zone =3D lruvec_pgdat(lruvec)->node_zones + =
i;
> > +             unsigned long size =3D wmark_pages(zone, mark) + MIN_LRU_=
BATCH;
> > +
> > +             if (managed_zone(zone) && !zone_watermark_ok(zone, 0, siz=
e, sc->reclaim_idx, 0))
> > +                     return false;
> > +     }
> > +
> > +     /* kswapd should abort if all eligible zones are safe */
>
> This comment does not align with 86c79f6b5426
> ("mm: vmscan: do not reclaim from kswapd if there is any eligible zone").
> Any thing special here?

I don't see how they are not: they essentially say the same thing ("no
more than needed") but with different units: zones or pages. IOW,
don't reclaim from more zones or pages than needed.

