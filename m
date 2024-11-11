Return-Path: <stable+bounces-92133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D539C3FBC
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 14:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBB2B20FE9
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF819D067;
	Mon, 11 Nov 2024 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSQ/dXHc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B51865E0
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731332626; cv=none; b=AdHoyg3ohOEovxNloPRLr/OjJ9mKdQOZvT6PIgnnai0pgXM5lJU0gTubH4aoGIziOocaAIgv4VOhCUdGnR8ZY/mcCRXUOYBomGGxoCFGR9onGEhHxiLDZkn083zY56MlUvUFRtxR2savftbEfe08EMgSVeUx6aytYIMctuQ5KfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731332626; c=relaxed/simple;
	bh=jYvLQr8HkhBTMi8Vwwvm/H234TJAgq+I/opC9vwgbeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku4nL+opHcTCzTO5mty8ouF4b0iaRa6lWuT76JMmKBLJvV0DTgE66HFwTDOXSPAv//KbignIg9H67TOllaIDWo9J998G831CX5GmVGBViCbC2/UdwdAvlLUqZ7N6QNkldt3jmZnqsDhZ77ja6RBxA4sCI3Ep6llHIkwlEhBg8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSQ/dXHc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c87b0332cso280205ad.1
        for <stable@vger.kernel.org>; Mon, 11 Nov 2024 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731332623; x=1731937423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDP+cDmyXee8Hd/DZmVZMRbGxd+UGKc4TIK2uER3Dco=;
        b=OSQ/dXHcmTiszrItgfstTXYtywBaD2kgFxd1NgLPM+xdrlmnWtw7fANGHzDffG4C1X
         BKxPye6HyxBC/hp9sKv5QwPi26YfTkldAgGh/SM+zBvMA6rBGgapbA30YEhBLJ70ZbI7
         zLFl8eY0EhIkAsygBB8mMbOs/mO3nSAEcmBsFfOUwPmX8JfjCM5bavqvih+saU1wW9Pj
         yBy0UtEDgenm9oYZNmhNDoJyEzwoQMJ/xB2kKJuOgqj+HLGcUjOnrf7QQocKyb9lJXGJ
         PAv+Chz3roB0NcAjkKb0b11xN5KRC/KXEvw/MpOoggIqhqh/sYzx1KR9JSDn/0rYXs2P
         C5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731332623; x=1731937423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDP+cDmyXee8Hd/DZmVZMRbGxd+UGKc4TIK2uER3Dco=;
        b=NJedyiR/Lhen5RH3cgkqHJm++CUxHGxOxzZEwscgsuW+EPS3nDTJMGMs3OPEsE083v
         ZLkwEFszoRLnpcmE1ILXVPUUzAsP1XSMzLNc8HdxfLQwEN83RFaYP8oxNVxIrph8TM4g
         Ve6PQ8Q2bAD5kG8Avb5DII7c3HIg7Hb6wWiM5pYNJzyvGOizRwDCublVy5Rh+ysbbeS9
         RKBga+kIL9/Jf4je/Ea3Fgj2ioe6rDKZTS9dA54E1NGSrUT74zbpOJJTh2fmsJGx7P/B
         IOM0VuppLgaxbbCraqOHm8MaN1K1Ef795pxEyxV0YOs36KFMQNb5pc7yx5nHiUkQc/PE
         eJQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZkHX7TB9hYyvxVBrDkgKJSjWWytgszzyBiL5orihghVSmb7eXamT5d6oQMAs884NwaC85ilM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf9Nb8FzKLZNpaqLQYgUsAnqpF4egLJjNmt1pyfophQPrAr03f
	VYAYYG17AGJg9xRCHBWD3RD2oz9Ph3nU540V5hmGWE8ci+mTHtL4qTTqltonXH0LI1viLB2EUhP
	ZQGlsJwzmH0RJmnLhdHInjki9etuVoSdYeorn
X-Gm-Gg: ASbGncsD60v1t69bo2JJP80D4r57W5LRtK+/W52kQ/Ck3+NXzpuVNyhmtIWwv0aV9mn
	vAfYSvFKC0AcItsBF+ULev+mwT3uwYA==
X-Google-Smtp-Source: AGHT+IETPc+SVHj47N7mDi3y9b3P39arT7614Q9JWIkwIq84hMAFtIcLJ/cZOvbHbBU+mSpbxKQJa4AQPdsxtagSf6Q=
X-Received: by 2002:a17:903:2292:b0:20b:5e34:1850 with SMTP id
 d9443c01a7336-2118f1c8c0cmr3154185ad.23.1731332623385; Mon, 11 Nov 2024
 05:43:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111082832.CB6B3C4CED0@smtp.kernel.org> <CADyq12zz+Di3FDANsZo1F79EvSSvUZt6fdRMDqG0tqbWoHq+rg@mail.gmail.com>
In-Reply-To: <CADyq12zz+Di3FDANsZo1F79EvSSvUZt6fdRMDqG0tqbWoHq+rg@mail.gmail.com>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 11 Nov 2024 08:43:07 -0500
Message-ID: <CADyq12wbX6Jn0aPgm4EpMtFcE1d=K7qAWan=g9L7RtQ674Escw@mail.gmail.com>
Subject: Re: [merged mm-stable] zram-clear-idle-flag-after-recompression.patch
 removed from -mm tree
To: Andrew Morton <akpm@linux-foundation.org>, "# v4 . 10+" <stable@vger.kernel.org>
Cc: mm-commits@vger.kernel.org, minchan@kernel.org, kawasin@google.com, 
	senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 8:42=E2=80=AFAM Brian Geffon <bgeffon@google.com> w=
rote:
>
> On Mon, Nov 11, 2024 at 3:28=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> >
> > The quilt patch titled
> >      Subject: zram: clear IDLE flag after recompression
> > has been removed from the -mm tree.  Its filename was
> >      zram-clear-idle-flag-after-recompression.patch
> >
> > This patch was dropped because it was merged into the mm-stable branch
> > of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >
> > ------------------------------------------------------
> > From: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Subject: zram: clear IDLE flag after recompression
> > Date: Tue, 29 Oct 2024 00:36:14 +0900
> >
> > Patch series "zram: IDLE flag handling fixes", v2.
> >
> > zram can wrongly preserve ZRAM_IDLE flag on its entries which can resul=
t
> > in premature post-processing (writeback and recompression) of such
> > entries.
> >
> >
> > This patch (of 2)
> >
> > Recompression should clear ZRAM_IDLE flag on the entries it has accesse=
d,
> > because otherwise some entries, specifically those for which recompress=
ion
> > has failed, become immediate candidate entries for another post-process=
ing
> > (e.g.  writeback).
> >
> > Consider the following case:
> > - recompression marks entries IDLE every 4 hours and attempts
> >   to recompress them
> > - some entries are incompressible, so we keep them intact and
> >   hence preserve IDLE flag
> > - writeback marks entries IDLE every 8 hours and writebacks
> >   IDLE entries, however we have IDLE entries left from
> >   recompression, so writeback prematurely writebacks those
> >   entries.
> >
> > The bug was reported by Shin Kawamura.
> >
> > Link: https://lkml.kernel.org/r/20241028153629.1479791-1-senozhatsky@ch=
romium.org
> > Link: https://lkml.kernel.org/r/20241028153629.1479791-2-senozhatsky@ch=
romium.org
> > Fixes: 84b33bf78889 ("zram: introduce recompress sysfs knob")
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Reported-by: Shin Kawamura <kawasin@google.com>
> > Acked-by: Brian Geffon <bgeffon@google.com>
> > Cc: Minchan Kim <minchan@kernel.org>
Cc: stable@vger.kernel.org

> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >
> >  drivers/block/zram/zram_drv.c |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > --- a/drivers/block/zram/zram_drv.c~zram-clear-idle-flag-after-recompre=
ssion
> > +++ a/drivers/block/zram/zram_drv.c
> > @@ -1864,6 +1864,13 @@ static int recompress_slot(struct zram *
> >         if (ret)
> >                 return ret;
> >
> > +       /*
> > +        * We touched this entry so mark it as non-IDLE. This makes sur=
e that
> > +        * we don't preserve IDLE flag and don't incorrectly pick this =
entry
> > +        * for different post-processing type (e.g. writeback).
> > +        */
> > +       zram_clear_flag(zram, index, ZRAM_IDLE);
> > +
> >         class_index_old =3D zs_lookup_class_index(zram->mem_pool, comp_=
len_old);
> >         /*
> >          * Iterate the secondary comp algorithms list (in order of prio=
rity)
> > _
> >
> > Patches currently in -mm which might be from senozhatsky@chromium.org a=
re
> >
> >

