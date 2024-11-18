Return-Path: <stable+bounces-93800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F699D12AE
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 15:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C752833A5
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F519AD7E;
	Mon, 18 Nov 2024 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2VCOtCY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFB719884B
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939007; cv=none; b=Mvv2wl2BIcKn59UhOcPu5fYOr8UOq4k/+5pvVXAuvEiIG3rUwxaaZkXYMDWtJRtIN42MwKhBUxCXRkmPMQrMf1kgIW9lLMxFkeLF5u/ba+H3FDRo15H0hTrwU4+bJvJb9oJwculJflFrbtPdeFakjir9NnUvV3t9RjcGGLa01NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939007; c=relaxed/simple;
	bh=Wx54fdMz1kOg4pNDXDXVAiV3AWLqXmG86A/9WOZNHFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8M80Ze2S6fis1c6loG6wD6cCpS8Cas1vibBUQVOY+cW+gFTPAMovrPyro0IhcIpjz9FO+lyiSnVP17iyRkvlTaiBPSYQrD/j8oZovNKEPTFQCflPuOQmABz/GB1R/Li6VErigAC0ZGw7AKuCbBhZW+d75h5iyd6PgpOh8WUY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2VCOtCY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e49d5deeeso146934b3a.0
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731939005; x=1732543805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3TUna0YQr4Wj+2n6bJe9uUSz+cPZNlp5sWEozSXdjc=;
        b=F2VCOtCYPjzBGNOKeWAy8t4wF7gHdL9mIK6DxmxRqfcs8R+g6f5b7gCQ8wspKZr53Q
         Izb1PlPzPvwZpjyF3TRJuDhzg+bTduUAahE3J19K4Ycr5MslcDRdaCSJnrCBEMviWHC9
         TZr5tZcXYPWhNwZS7afE9n0dcWyDvZsOds8w7hVRg1QURBJBu/eSfpcSrbe7niIlrhQA
         EncJ0K2vt2a3Irp8LcSyawJx0/ApIyYqLnTCIO9yIezE5QPnFb5iLb6jQvdfA7gqVNNP
         NU13sBhMHUX0k7Xn8GRnNUgJsOlnAC3Pbt8TU4vcwN+DuCuxqgXXcfdmo56A9nFxEf27
         1dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731939005; x=1732543805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3TUna0YQr4Wj+2n6bJe9uUSz+cPZNlp5sWEozSXdjc=;
        b=TdvCn1GctIb9u1He87U5ypg69klUHp9ArmU+cD4GZJkJL+O7IXwtl5r+SAoKqY7CKp
         8qB1VPt06AJtLN5WhT6d0ff0jp5xfVkNmcwpI2Rv+zh0vrChrqHf8OD0BESqA6aQddFW
         xp8uf5heJZd2ys3f+o3bQPk0qlQEQvP8i1ENrLNCVTK42yM4uxhQkoPi4zfROOOByHI5
         D0wufvqaYQEpCypHc5BsI5AudOHqUMda08guBSe+XPdqf8IQ1nvZzYGH4EqHPv9rhUq6
         5V2szcx0awRMLcPq3x9IG/fGr3/p3O2GoFv8ER+vDnkytuliy7L4A8vFp84AsyWmfhQy
         Mw0Q==
X-Gm-Message-State: AOJu0Yx8WEHi87F5tsQ4pmciLBYO3j7u9UwgG46160K5ft0XpntlpZJR
	JBopVYX/S4f6n7slzLhVL1hzSe1c5bo6Wnhx7dfXLSRsa7bZRctt11HgTuzW/SRKrY7Gb6wEFXF
	ngX9Tna3LLLxRRV80fEwq5gKClZs=
X-Google-Smtp-Source: AGHT+IEEwyGqtph6tUDQISyTtF7jieMYFj2+UEQkCHRLvRonvRUmUbSsdvBbgv6SfdP9M0/mJiwlofdft59pfq20ulw=
X-Received: by 2002:a05:6a00:1704:b0:71e:66bb:d33b with SMTP id
 d2e1a72fcca58-72476bc530emr6932302b3a.1.1731939005466; Mon, 18 Nov 2024
 06:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116130427.1688714-1-alexander.deucher@amd.com>
 <2024111614-conjoined-purity-5dcb@gregkh> <CADnq5_PkG8JywBPj5mivspUPJUC6chEGuNEH5a1_A-FCd_8wog@mail.gmail.com>
 <2024111653-storm-haste-2272@gregkh> <CADnq5_MPEwVGmnMBz_xzO4ZCBM0kgqP=rzwK+L5VPjwpnRj9+A@mail.gmail.com>
 <2024111617-subarctic-repeater-c06f@gregkh>
In-Reply-To: <2024111617-subarctic-repeater-c06f@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Nov 2024 09:09:53 -0500
Message-ID: <CADnq5_OhPc5gia7AH4diYi3SZvUPHFLPxsJNxn20+02t+Otomg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/pm: correct the workload setting"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 11:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sat, Nov 16, 2024 at 10:07:38AM -0500, Alex Deucher wrote:
> > On Sat, Nov 16, 2024 at 9:51=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Sat, Nov 16, 2024 at 08:48:58AM -0500, Alex Deucher wrote:
> > > > On Sat, Nov 16, 2024 at 8:47=E2=80=AFAM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Sat, Nov 16, 2024 at 08:04:27AM -0500, Alex Deucher wrote:
> > > > > > This reverts commit 4a18810d0b6fb2b853b75d21117040a783f2ab66.
> > > > > >
> > > > > > This causes a regression in the workload selection.
> > > > > > A more extensive fix is being worked on for mainline.
> > > > > > For stable, revert.
> > > > >
> > > > > Why is this not reverted in Linus's tree too?  Why is this only f=
or a
> > > > > stable tree?  Why can't we take what will be in 6.12?
> > > >
> > > > I'm about to send out the patch for 6.12 as well, but I want to mak=
e
> > > > sure it gets into 6.11 before it's EOL.
> > >
> > > If 6.11 is EOL, there's no need to worry about it :)
> >
> > End users care :)
> >
> > >
> > > I'd much prefer to take the real patch please.
> >
> > Here's the PR I sent to Dave and Sima:
> > https://lists.freedesktop.org/archives/dri-devel/2024-November/477927.h=
tml
> > I didn't cc stable because I had already send this patch to stable in
> > this thread.
>
> I'd much rather prefer to match up with what is in Linus's tree.  If you
> have the git id that lands in Linus's tree, please let us know and we
> can take that.  This way we can keep 6.11 and 6.12 in sync, right?

Sure, but if the patch happened to miss 6.12.0, it would have landed
in 6.12.1.  If that happened 6.11 may have missed it and right now and
for the near future, 6.11 is what is important to users and distros.
Anyway, the patch landed before 6.12 final, so please pull:
commit 44f392fbf628 ("Revert "drm/amd/pm: correct the workload setting"")
into 6.11 stable.

Thanks!

Alex

>
> thanks,
>
> greg k-h

