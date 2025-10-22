Return-Path: <stable+bounces-188928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A604BFAD8D
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 10:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552DA3BDF53
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092953074AD;
	Wed, 22 Oct 2025 08:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="H3W9/5Lk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E8280327
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121074; cv=none; b=CzP56mewdx0hixRxycL4eySmMcyFx7SMRmdTwNZg5qrW+sLZj9t4A/CPZx1xcsFydeMvEC9SG5WoUjZltUN9g+GUDKjUSHbRoT6wB7pb2e+7VolQLGehDbDiHFH/qlZIy0ROtjki1yUjvIDdi/f2pvw/U8+90jb372/fqooTneY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121074; c=relaxed/simple;
	bh=ti7G/84E0YzBXTvtASt3fHYjXTFmenpC52OVjFot3ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWeQEsrtscpVmdImJHZ/CHgJ5jtMgmidcFJcFNbDSbOT7D6pXE1Cylctd63wgk5K+ZcfDdlp/l7NAKSL548T9rMWEmYWDZYa1snH9In1wY0PXsCPddj2gTaimqjy5vZpcr0Eevdtz9BoCSVIfnOp28egEO9rPh7c7pE99ssbr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=H3W9/5Lk; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6a29291cebso50580866b.0
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 01:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1761121068; x=1761725868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AnPmF7GikSpuBYeb5D1xWnDEMKbEHnX3EodtVzhcqs=;
        b=H3W9/5LkmYNctOWvr5Up4oq1Ht3iE8PRppurYXaw5+NSYfbzSpqte5WOpmvhH9uZNo
         5A/A0b0Zae6QKiVLhu3vAlhxnUmIswrVxCACM3Ij9MPRnrDub62mAgkQebzxNqf55RUb
         ErZkw83rVRPI+Ks3fVHFPvuhtUyPuGpLp6QIcdu3Gny0bcMtUeJRjGijKhMGyH1Jt4tm
         i9oMWbyZkYBfMTDcx6MSUikyMdvzJjIN25laGePqcEspyuHVHU+KFSkO99KUKnfdF2NG
         IfKenO5xFQRJvSEEB/MogRjOltYYyyYhvmzWMD9wLAG4lBcZKowyV8Sf3jMtxvZcVxnu
         7/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761121068; x=1761725868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4AnPmF7GikSpuBYeb5D1xWnDEMKbEHnX3EodtVzhcqs=;
        b=VmacMjVpv0M6Tiayv19RCTg6622oN10Vk5YNoPobAEOsWhtBwjd97su7YzQFR4AGfC
         6l7M4vlLjOBKkBh9WUA3qN6st9TA4yfN0Cg5FDwL9/eDG5i1UIpePPQWcV13Qk31Wfk5
         gaQ3vH0eZCYVveOd5W3e8ynXIJK2C3w9z8tKJt1l0j1vlWPkK8CwHzBL4Bc5I6ZjTZrJ
         bF5n1LrOrjrrYXP9t95T2aT3QZZw1O0vWCOmJupSTpF1uYV4KrBqJqkFcDLiyYGO/WxM
         jmt7UCT++cm443pwXLbL9ET3DfJCAdk4Y3igLP6Xe+Jbd8f5pfqbfxIqEp400Raxm8w2
         szkg==
X-Gm-Message-State: AOJu0YwZaYLcFX0NUvVOjyoedgw05GuvQ5DFzVfKcWhea2AKic9zrq6G
	PnzX/yQpIqqTi3nAX9WKTX2mVIAsiK86b5+NoHOkXbdvHR4P/6MDz3oPuMz+4lxg+bSJT0Fk/vr
	M37HRbeERDGoP5pDvt5EO7VqykStgcuI0ovwHJrYaCQ==
X-Gm-Gg: ASbGncuFqg8E8XkzTtpKl/nwjwC5yjkUupEqtdGTtxDz9fI9+Gvb+O1Yqi1nziX4i6J
	DW8KasChaISM46JEe6+0KQcInO9Ymt26dAh+usyWD4g+fG6M1iRU46Qn+V2Vd53N6puwPeepwAr
	ocRmGKRTx6iGN301PijxdTXdEKP+iaYXOJskCOWZRhLenGc8yeRTbbS5pbmcnSKpnQ68ykmhku2
	ZrbgF9THagNT4xQEBZfL3OQ7eVrzONY+wbS6WIeO8XUjFbZd5q6wZlxpyS2MIw31U2qdPUi1ywj
	CEj3rPmrg3BQAh3OA8lDscrE8vc6
X-Google-Smtp-Source: AGHT+IELYwuQuJq02S8YTBuoFu4VR+wgRs0gisHIbN1jW8etU1gm3iQvaw9IgNxYvPNwMTgRRsiqOxaHnS4XTtzawKE=
X-Received: by 2002:a05:6402:254c:b0:63b:f26d:2eab with SMTP id
 4fb4d7f45d1cf-63d16aece4emr3714487a12.2.1761121067970; Wed, 22 Oct 2025
 01:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021195035.953989698@linuxfoundation.org> <20251021195038.635577649@linuxfoundation.org>
 <2025102240-zesty-unveiling-4f99@gregkh>
In-Reply-To: <2025102240-zesty-unveiling-4f99@gregkh>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 22 Oct 2025 10:17:36 +0200
X-Gm-Features: AS18NWDyzS1lKVizdJ-gUUOkZIsvOsfTH9zxZQijuuIDX1kTKUO4DW_6RhEvqk8
Message-ID: <CAMGffEnD5QePj+5sooX8RyZshO0fngLBv6xaBEWG6o4veJPxkg@mail.gmail.com>
Subject: Re: [PATCH 6.12 111/136] md/raid0: Handle bio_split() errors
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, axboe@kernel.dk, hare@suse.de, 
	john.g.garry@oracle.com, patches@lists.linux.dev, sashal@kernel.org, 
	yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 10:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Oct 22, 2025 at 09:53:07AM +0200, Jack Wang wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > 6.12-stable review patch.  If anyone has any objections, please let me =
know.
> >
> > ------------------
> >
> > From: John Garry <john.g.garry@oracle.com>
> >
> > [ Upstream commit 74538fdac3e85aae55eb4ed786478ed2384cb85d ]
> >
> > Add proper bio_split() error handling. For any error, set bi_status, en=
d
> > the bio, and return.
> >
> > Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > Link: https://lore.kernel.org/r/20241111112150.3756529-5-john.g.garry@o=
racle.com
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > Stable-dep-of: 22f166218f73 ("md: fix mssing blktrace bio split events"=
)
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > --- a/drivers/md/raid0.c
> > +++ b/drivers/md/raid0.c
> > @@ -464,6 +464,12 @@ static void raid0_handle_discard(struct
> >               struct bio *split =3D bio_split(bio,
> >                       zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO=
,
> >                       &mddev->bio_set);
> > +
> > +             if (IS_ERR(split)) {
> > +                     bio->bi_status =3D errno_to_blk_status(PTR_ERR(sp=
lit));
> > +                     bio_endio(bio);
> > +                     return;
> > +             }
> >
> > The version of bio_split return NULL or valid pointer, so we need adapt=
 the
> > check to if (IS_ERR_OR_NULL(split)) for all the 3 commits about Handle
> > bio_split() errors for md/raidx.
> >
>
> Sorry, I do not understand the request here, is this not ok as-is?
godd question, if keep as-is, it doesn't improve anything, the check
doesn't catch the error condition, only add extra code.
it doesn't make the situation worse.

