Return-Path: <stable+bounces-41827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F88B6D3D
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1051C227C5
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56373D0D0;
	Tue, 30 Apr 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em94o+QS"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F75211C
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466723; cv=none; b=r35uqweZs2r2ohjucyVoUCi+ts+TslD4PQcuEdEijFSzdZ7DTYmzZgvaTlpnkAHRhSNm2HCAVJGny9fg14CBtu2rbbBNPHElY60mD4NsN/W48cnvQxWDUlkTZxBh5lxEH3GEZ8wpvaEzIukm8OtPFRFA3EenIAo+OJ5UmnbZaO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466723; c=relaxed/simple;
	bh=FFSw6rTle5sjfXQ47HO7A6O5hDbvdWpTTxSfiXoKN24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3dvvMWnVudZhH8vO7NNw2BqrOkaxx0Dn4kpg+VfQ5n76RH9KXiLK9aNvzbnljSi7HOTNSKUOatwKm/0EUjJMYXYP0Ci+sbxW3DsxcWKNcrJ3fQVSzY9HMHRvvKDJc3m6Owt+smX28uVBcXPAn/d5o9JKGo7LSjQoh1PCaF/DpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em94o+QS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5726ccca4c8so3475979a12.3
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714466720; x=1715071520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F30LJllV5Ga063bB0krQ2t2VHg+mPMMwRnPeUuZ3u88=;
        b=em94o+QSCiAZR/LYxvck9rxQZ43jFZ8than28LwnM+d5wmURFXByO+6c3X5U+m9+4P
         /TshHceF2lDirB4maWOV645SkPstK7iKKfqX9yyUdl4TLKDCj5k+dDPoL52wmYo7LK9d
         GSc95WUxzhZ1rs0bem/SIbfPZhp69oggTHBiLGBhcCgdmcx3hgLpoNk4FjB52ndZZ8v0
         GOAORkJ10HX+i6oJxeZAr78rHB+bqECp0QhacdjTkk8eMgKOh67rzWlMHFRHI7v/1T8/
         2RC/KCFD+g27dhDwkaYvCRn2mHG9WOpLpx6vTp2HqG5ERBYlWbRA8Rdjh0SGSQjXhjUd
         4t3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466720; x=1715071520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F30LJllV5Ga063bB0krQ2t2VHg+mPMMwRnPeUuZ3u88=;
        b=J1B/LCkpJyP7fllu9Mi0OHyXmVAXq/KCrOj9HJASOUhLTENVXEHnhFzxGpj0+wO6yz
         wUrYaSl0iqRn/O2QKfsJizr+yA7okSvka/MHYVlP8qZ75oAB4iwaD/etGWsAKAUT5UbH
         dPznT4oJWhMGoW67QFxZ24M1N98Je85R26bYxeLio1w3O3kDe/1hyp9RiU+bR99wNs4s
         XRo0F2Bb4ITL7AWBvDrmkoq6Z95iKFALD8Dkv3ZcPK1FmsMT9QZOpZOb2m8aRoKDTyDw
         heLdFbcbVHofHf2YioDG1dIbLdCoPYb6RTf+gwpn828ZeSrccxOZHkozvXmnX59ssbJi
         81qw==
X-Gm-Message-State: AOJu0YynGLi7b3g3+M88QnnQOP5oCZ0gHQzwoS4N+WJ1JFi+kq/Kci1R
	1QA+fSwM+Ut/sCUJcZcbKf5E58CqlkXJmYOL8nTiEAN8l0738ClpebuPR3fNHJopXu5nd0wULi+
	FoOHardS/vH37QrXF/dnslvA37SI=
X-Google-Smtp-Source: AGHT+IFr924i54wx9ulR4DUhn4QQtUyHJSXCgp81Hi1z5vIcJn+cnjzR7NNxUkF3sqk99r0iza8T3cyZ1Bm2M5XNszE=
X-Received: by 2002:a17:907:7713:b0:a58:c696:9aab with SMTP id
 kw19-20020a170907771300b00a58c6969aabmr9413245ejc.15.1714466719859; Tue, 30
 Apr 2024 01:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024042925-enrich-charbroil-ce36@gregkh> <20240430080923.3154753-1-yick.xie@gmail.com>
 <2024043057-gloss-sustainer-601f@gregkh>
In-Reply-To: <2024043057-gloss-sustainer-601f@gregkh>
From: Yick Xie <yick.xie@gmail.com>
Date: Tue, 30 Apr 2024 16:45:07 +0800
Message-ID: <CADaRJKs+1dyyLMzVrBW8ZHBOxSjFW7PwX7VeK6qY0qCj6iHLjg@mail.gmail.com>
Subject: Re: [PATCH 4.19.y] udp: preserve the connected status if only UDP cmsg
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All of them have been sent out.

Thanks

On Tue, Apr 30, 2024 at 4:22=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Apr 30, 2024 at 04:09:23PM +0800, Yick Xie wrote:
> > If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> > "connected" should not be set to 0. Otherwise it stops
> > the connected socket from using the cached route.
> >
> > Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
> > Signed-off-by: Yick Xie <yick.xie@gmail.com>
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > Link: https://lore.kernel.org/r/20240418170610.867084-1-yick.xie@gmail.=
com
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > (cherry picked from commit 680d11f6e5427b6af1321932286722d24a8b16c1)
> > Signed-off-by: Yick Xie <yick.xie@gmail.com>
> > ---
> >  net/ipv4/udp.c | 5 +++--
> >  net/ipv6/udp.c | 5 +++--
> >  2 files changed, 6 insertions(+), 4 deletions(-)
>
> Sorry, but we can not take a 4.19.y only patch, without it also being
> present in newer stable kernels.  If you provide versions for 5.4.y,
> 5.10.y, and 5.15.y then we can take this one.
>
> thanks,
>
> greg k-h

