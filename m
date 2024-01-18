Return-Path: <stable+bounces-12175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0786B8318B7
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3872B1C21EC6
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CC924209;
	Thu, 18 Jan 2024 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXjje/vT"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18406241F7
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 11:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705578654; cv=none; b=HSxf9AAmjaeb+oLT4eKo6i3M+rnsmZFoW9cvdFFX/V/dJk6oYUE+unAbRXINEdJEp77BVEyd2ZZ7/qwNIJq3o7LNFd+ftidE87bOOwSEYo7mw9Xs2CgOBDHj6rRZy/G+0zQsyRybBJP+h2Cam+uSatRSdWbOb/dVOxj5QPhYQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705578654; c=relaxed/simple;
	bh=gt35hwddnpNUWAan27VYVSM0nHY7vcCvCwkZZknrkR0=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=V3I/W5Xf2TDCLWNOq9lt1b4AmGM0T4HG18xNmgJ3vLlewBi/zMe+tVuik+gXEz6Kwryx/z8Op6tuCwrQIYHb6ophouzPFyRy8rk5C0UPJA5AlmxbR2qhuDLCEx69TYZKr+VJ8V8rbKRN3kp4SIp4vPXgg3gH1s4joqWkx74eq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SXjje/vT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705578651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QT9qXfX+i5084J8ucGBrAuMK3QTq9k9pLJjBMMFh3rE=;
	b=SXjje/vT9+vqiAGnAdtgnhGz12f4LEbUe02RAeji67okrlX0I3Z3/L0dP+cI6p84/aqNl9
	LW7wvzgOsSmevT3K9vWUnfnPoavxQHB30rdIk2JzQu/KkHXFkyvaaL8x+KO+GQFuXjmbAK
	i3gDJihQ37fN+PST0LnhUGnpjjrvwLs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-d_2jqCNzOLSolxcedlaOUA-1; Thu, 18 Jan 2024 06:50:49 -0500
X-MC-Unique: d_2jqCNzOLSolxcedlaOUA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28c5c622a3cso8334142a91.0
        for <stable@vger.kernel.org>; Thu, 18 Jan 2024 03:50:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705578649; x=1706183449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT9qXfX+i5084J8ucGBrAuMK3QTq9k9pLJjBMMFh3rE=;
        b=GIXJOnw9QqjjALAeKrzX+Eix3B+tzSTxbFp5nuL1g6Og34uagQAvH/g4FfEokYj6rc
         0CtLnss25+n+wu7OwyQ354JDAXkHXcoHuXFrTBdATdIfXsVbEslK8uj2YgVJIugRHasr
         eIWq19KmtupomdCQHTQaxPWWf+gyIy+cE3DJ8yGTs+a9MhZ8rbmSDBgZEdors1/KLm5U
         ptaOXz2epAlRgzvnYSXDqKNEVg3rH2a3mENvEIb/H7Hpl6jF5lwCk2SzZFz8g+RgLDAg
         CSpyZllOSawo+saoRvzBXTalYzWVCbeg0m1gzEZlsqbwRV8d9wd9Vdvl5ZPRysuzX6yF
         ZfTQ==
X-Gm-Message-State: AOJu0YwnOLQH0Fi0xGPDdNilRguALGx3ZMhdVn6CDC4QnFwUq+9MSLfy
	VERnW8rrdTJB/QF8ukw9/jW8Ef3m6nX1wDmBeh02Kr+dRtCAzqbKC9YphnjwNeIC1bfkUc1UVt1
	AdbZEQRro8yCT1vC1TTRWzJn2FZ9RPH16tN9LeFkNnd8Y735WB/cRdNqEt8hCdDF/sGfb1w7nO7
	hsk3KOVJJPa8uLRP1RyFyIeLxUeGaJ
X-Received: by 2002:a17:90a:fa08:b0:28f:423f:1cfe with SMTP id cm8-20020a17090afa0800b0028f423f1cfemr537979pjb.18.1705578648792;
        Thu, 18 Jan 2024 03:50:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVs+zCTtfvuguPsuMp6IoFUt9geCNapxlrZ6013/fZtiox4ORl6FknrWsaFGhDHw+mmfqpBre4bZ+1zAqDKZk=
X-Received: by 2002:a17:90a:fa08:b0:28f:423f:1cfe with SMTP id
 cm8-20020a17090afa0800b0028f423f1cfemr537973pjb.18.1705578648531; Thu, 18 Jan
 2024 03:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116002817.216837-1-sashal@kernel.org> <20240116002817.216837-11-sashal@kernel.org>
 <ZabrPnsVr6WHz2lM@duo.ucw.cz>
In-Reply-To: <ZabrPnsVr6WHz2lM@duo.ucw.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 18 Jan 2024 12:50:37 +0100
Message-ID: <CAHc6FU70RD8fktBp=Srv6xeq3qXoLCdT8pi6y=1Y7bMHFK-mtQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 11/12] gfs2: Refcounting fix in gfs2_thaw_super
To: Sasha Levin <sashal@kernel.org>, Pavel Machek <pavel@denx.de>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 9:53=E2=80=AFPM Pavel Machek <pavel@denx.de> wrote:
> Hi!
>
> > From: Andreas Gruenbacher <agruenba@redhat.com>
> >
> > [ Upstream commit 4e58543e7da4859c4ba61d15493e3522b6ad71fd ]
> >
> > It turns out that the .freeze_super and .thaw_super operations require
> > the filesystem to manage the superblock refcount itself.  We are using
> > the freeze_super() and thaw_super() helpers to mostly take care of that
> > for us, but this means that the superblock may no longer be around by
> > when thaw_super() returns, and gfs2_thaw_super() will then access freed
> > memory.  Take an extra superblock reference in gfs2_thaw_super() to fix
> > that.
>
> Patch was broken during backport.
>
> > +++ b/fs/gfs2/super.c
> > @@ -1013,6 +1013,7 @@ static int gfs2_freeze(struct super_block *sb)
> >               goto out;
> >       }
> >
> > +     atomic_inc(&sb->s_active);
> >       for (;;) {
> >               error =3D gfs2_lock_fs_check_clean(sdp, &sdp->sd_freeze_g=
h);
> >               if (!error)
> > @@ -1034,6 +1035,7 @@ static int gfs2_freeze(struct super_block *sb)
> >       error =3D 0;
> >  out:
> >       mutex_unlock(&sdp->sd_freeze_mutex);
> > +     deactivate_super(sb);
> >       return error;
> >  }
>
> Notice the goto out? That now jumps around the atomic_inc, but we
> still do decrease. This will break 4.19, please fix or drop.

Thanks, Pavel.

Sasha, you don't want that fix without "gfs2: Rework freeze / thaw
logic" and the follow-up fixes, and backporting that probably isn't
going to be worth it.

Thanks,
Andreas


