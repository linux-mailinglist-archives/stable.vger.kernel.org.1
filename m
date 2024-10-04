Return-Path: <stable+bounces-80766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB0C9907F8
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 536CC1F21B49
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBECF1C304D;
	Fri,  4 Oct 2024 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mK2Hzjmv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C21CACF4
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056496; cv=none; b=B8c1BMwgV4copjEDgnp2gNo6xypDtpev8nDx2w4UsUwmEDDkocLAX1zg2A1xO8l6w+uQkRnfiNXMzY3h0rXPkP/agCdsf9EII7tNrBk6R0o2m8Sj4jMVP5HI1TC0BjZMKqR4EtyUgyY1LlK4e7QhSvTvr3R6skM6Mp3jz+Mj5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056496; c=relaxed/simple;
	bh=dJqcYDoZdMv4SCtPkgzGtLXt5PcyPXiz75/oxa/aADI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I90kkje4KmQIrLOD5hErE3heDom8lJKAOsPzvIM3SpDN2bl3r5nu2iWBI7PLZcnA8P2M0jpSiRDm6Unmu8BAW0RpdECyWjGRQu4STqYQjxXb8YVCRDshRswLyJF/gpJzhsOXlidj3Te1UP5uBz1Mo5dv0IM7L7jXFXKiKU2HeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mK2Hzjmv; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e22f10cc11so17385157b3.1
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728056494; x=1728661294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld53TKEHT8b3TSuRD204fFYTz9ezn3pJ8reFZpiI+8o=;
        b=mK2Hzjmv77T9jM6BLYXk+0wgCzWlooXxmyJv2CA+PsMH4bIiIhnUHirg4Hf3Bs8rs7
         RS13CkkZl1+OKF5EBG9Qes2L3l0qNUZfidvJAlPisHHhpyZRT5V+L1wPXbOmw0mLpD40
         7C44TH8l+pBMpvvNuv0kCfi/USKci4MC0PD4ISydWcEjT9HKlxsCVSk0yRVAah3+7HIG
         eUtrNZVImGi+BkGyrLQGBc+6XvZAIJL8zMXsLdg9t+1GyvARQAeapjAdbNm4/cH/WmuE
         qhMfHvjLULM475fr/0fYjTzrtB0y0IYWL/P5O6QzTdPHHQPTzM5ygftaikeqQW8Okmxo
         W+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728056494; x=1728661294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ld53TKEHT8b3TSuRD204fFYTz9ezn3pJ8reFZpiI+8o=;
        b=cOQJYclwxa7fxoVU7RR3iASXSuilR6heg1p9WTuXVONhuLWStKe5fY+kbLYW6yt1RF
         yUdpalmwn+Jh31jJ09UxTYmNPBnUb4TUGdtLNNNbTTQ1Kdi4DfzL4DW4BAyCuaZuip4S
         c99Ees5ebC1zulGIYkeB2ECWTUK1TWUsUnjMh5+oDaX2S6uF4ZD2J2Vf9HA1CgJTlKPI
         EBzgnlyDzvQoIWS+JEqHW0tChL0UckUTOZSD0mTfX2VjVvGiU0A+mAwbbdOIolCEg4Rf
         KrjUKvSSz4UbTIzcbp2KU/qXOtjjAqfeoLSmSK20iE3FH8lqrIkDnubL43JI6jLLEeWI
         pfzA==
X-Forwarded-Encrypted: i=1; AJvYcCVNQujOzyo9n44mmpS69AfYPk1WxAP6yZacuLAl8kx6NXQdhSV0yNHQkjSk1Uchw1M7/YxbItA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+T/04VsYHq+FRqP4JxDYR962U7tf2dq5VKie8McdV1HW+UPrt
	29AErYP0oZitXJbFI7NQAXwMQla46HqrY6tT36/5XnrgdDmm1DruT5fzq0prD5lIsqYfnVwjkpp
	lcWE8Q/Ft0pJJBhHin1uoRbvOrzk=
X-Google-Smtp-Source: AGHT+IGmAHX5qOJKjfePGvgyCk94mzcfv68CQ5ZqvNqlsIkB21J1eW/6bT6b0FMpBRoy3DQZDXAbMHouQVFazdiqulc=
X-Received: by 2002:a05:690c:d89:b0:6de:b23:f2c3 with SMTP id
 00721157ae682-6e2c72412bamr31532787b3.7.1728056494214; Fri, 04 Oct 2024
 08:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125822.467776898@linuxfoundation.org> <20241002125838.303136061@linuxfoundation.org>
 <CADpNCvbW+ntip0fWis6zYvQ0btiP6RqQBLFZeKrAwdS8U2N=rw@mail.gmail.com>
 <2024100330-drew-clothing-79c1@gregkh> <A8D6C21F-ACAD-4083-900F-528EB3EB5410@oracle.com>
 <CADpNCvbKGAVcD9=m_YxA6qOF6e0kohOfVsKOqJeVmrYaq0Sd8w@mail.gmail.com>
 <2024100420-aflutter-setback-2482@gregkh> <CADpNCvYn9ACkumaMmq7xAj6EQuF6eYs174J+z81wv5WqzdWynA@mail.gmail.com>
 <2024100430-finalist-brutishly-a192@gregkh> <2024100416-dodgy-theme-ae43@gregkh>
In-Reply-To: <2024100416-dodgy-theme-ae43@gregkh>
From: Youzhong Yang <youzhong@gmail.com>
Date: Fri, 4 Oct 2024 11:41:24 -0400
Message-ID: <CADpNCvZTdxNsrqq-xOga38unKWCC_ZwB-+F1VprJumXiCmTD6g@mail.gmail.com>
Subject: Re: [PATCH 6.11 397/695] nfsd: fix refcount leak when file is
 unhashed after being found
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>, linux-stable <stable@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Jeff Layton <jlayton@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Greg. Yes, if a complete fix is concerned, it should be
backported. I had no problem applying those commits on the top of 6.6,
but I am not sure about the earlier kernel versions.

On Fri, Oct 4, 2024 at 10:35=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 04, 2024 at 04:26:39PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 04, 2024 at 10:17:34AM -0400, Youzhong Yang wrote:
> > > Here is 1/4 in the context of Chuck's e-mail reply:
> > >
> > > nfsd: add list_head nf_gc to struct nfsd_file
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D8e6e2ffa6569a205f1805cbaeca143b556581da6
> >
> > Sorry, again, I don't know what to do here :(
> >
> >
>
> Ok, in digging through the thread, do you feel this one should also be
> backported to the 6.11.y tree?  If so, how far back?
>
> thanks,
>
> greg k-h

