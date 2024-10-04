Return-Path: <stable+bounces-80751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5D9905C9
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 16:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EBC1C21647
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64B1D5AB8;
	Fri,  4 Oct 2024 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5a/h/AF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEBD1D6DB3
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051467; cv=none; b=MkA38tYvPfkcAdgyQfXN6ISMmxy2xaHlAS3c46B55l0i++prUGE29ploMDDkMzF85oWtWGB4TG/UsfrcgIYqmXP3/l2KVDQd84tdfT7GzIrmyngT2QmV76MGTZIZUb3fGsKKoRhJeZCElV9mcaTV5pGv28VEaqbOGpYHkImK3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051467; c=relaxed/simple;
	bh=zsE3OLHAGWx+9i8525FiuBbVUGIdrrHEA48nOTpUX+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGj9d04SxVKs82gyjsvD/iMkkHph3D2EPbyWIqpOM1gBJCpV9XRXbllR4b9Viihd6q1hYcA1VLFsVObQ7HcVvVyH7WXmhscXcMpyDf5DzlpSsKbA5R4vVfDrCCkKnP5tqLGTtDujGIz6Dmyd32u0IGGwArMJio3urotLIcNcPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5a/h/AF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e252d1c5b25so1807148276.3
        for <stable@vger.kernel.org>; Fri, 04 Oct 2024 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728051465; x=1728656265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNUlLWhszcF1O/g2HmC+fFVclU6SG4kGSBRvhEPUmus=;
        b=W5a/h/AF7QmXLcjynu60MqtSRghyV9nEvcU+IcWB5d3Xa5v8puoA6sfeEI8jGELhgA
         Plt847jfBYn2aubzrOeVH2x9LIO6Asph4D2KaL0kBZN0lEhgWGm1NkuXxVL7bQEe+rVO
         iIicAQi8syq+Ka8pCrD4W7i6+dNfF7XEFc7tgRb3movNS1D2FGbSfj6ZrCXT//6CS9x4
         OzhkOYTB8CrZlU4NgpIpiMz/IIUHor1j0rrNjTCsYg96Qsz+E2EoOvebaCx6frojPrd1
         ukDNSis9SNGZMo5g9VpBUIiDENWZU+kRx8dswvw+bmWovfnGZVHEb+//4hNUKd0E8IVa
         LS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728051465; x=1728656265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNUlLWhszcF1O/g2HmC+fFVclU6SG4kGSBRvhEPUmus=;
        b=Lvf2REuNhH0PClCH4hfEYLm7h0E17XD2MNcjyI6KCo0FdQMTLEyuUMpuEzkfsoVYYf
         pyLcbvadgCMVKTUHjbuMBP6iGKKq/WgKB067HzuFXYBGOLpfuSedRKf4tZk8Zbwo/sg6
         Z21MZOwKdPvFGXjtO4fxEhIGMJ3/7xqYJ0xM9kc57DJ3bESggApavy3g8rx65KeA9wXh
         NT9/8C/u+/SW9QXsH4/qnEBn2+868YuEwoSfWqzeHEtWYMnxlY8TGoZGfgow2dR0tOqL
         WDAKlqx37NsoHqCZWGawbpcuGTFWGcm3VQ6BlgPP3S0OitsA7FtZeVBemKpqtOS+s5cE
         lezw==
X-Forwarded-Encrypted: i=1; AJvYcCXBMgwO9QN8G9dXphwfecmlD/mz6WDmsah86+BZPYAHC4xslo5lWstrlLtRSlbBaTHf6VxZ6R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWk4vqR4iMPZevjRuuNMZ2lAgMNzlCBEZA2M/8Hmfx/tb/UqKa
	IR92Eb99jWShZomNNOfB4YGlABzncopwNdSZHPbgrYrMW7KgYbnBks/GxhB4I4t/x4HtbF3sxgd
	z8kNqdDEgQVpi11n+x9Oz4BO2Vdc=
X-Google-Smtp-Source: AGHT+IEB9VVNQ2jOBSVouKS0eBjZgjKxntWY1NMMvCWikKrNo3Z+2Bg2wv2PDY/nA9jG2S33P3rqvAZK3gpxXaclnrU=
X-Received: by 2002:a05:690c:d89:b0:6de:b23:f2c3 with SMTP id
 00721157ae682-6e2c72412bamr28091777b3.7.1728051464719; Fri, 04 Oct 2024
 07:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125822.467776898@linuxfoundation.org> <20241002125838.303136061@linuxfoundation.org>
 <CADpNCvbW+ntip0fWis6zYvQ0btiP6RqQBLFZeKrAwdS8U2N=rw@mail.gmail.com>
 <2024100330-drew-clothing-79c1@gregkh> <A8D6C21F-ACAD-4083-900F-528EB3EB5410@oracle.com>
 <CADpNCvbKGAVcD9=m_YxA6qOF6e0kohOfVsKOqJeVmrYaq0Sd8w@mail.gmail.com> <2024100420-aflutter-setback-2482@gregkh>
In-Reply-To: <2024100420-aflutter-setback-2482@gregkh>
From: Youzhong Yang <youzhong@gmail.com>
Date: Fri, 4 Oct 2024 10:17:34 -0400
Message-ID: <CADpNCvYn9ACkumaMmq7xAj6EQuF6eYs174J+z81wv5WqzdWynA@mail.gmail.com>
Subject: Re: [PATCH 6.11 397/695] nfsd: fix refcount leak when file is
 unhashed after being found
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chuck Lever III <chuck.lever@oracle.com>, linux-stable <stable@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>, Jeff Layton <jlayton@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here is 1/4 in the context of Chuck's e-mail reply:

nfsd: add list_head nf_gc to struct nfsd_file
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D8e6e2ffa6569a205f1805cbaeca143b556581da6

On Fri, Oct 4, 2024 at 10:10=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 04, 2024 at 10:01:46AM -0400, Youzhong Yang wrote:
> > I applied 2/4, 3/4 and 4/4 on top of kernel 6.6.41 and tested it under
> > our work load, unfortunately leaks occurred. Here is what I got:
> >
> > crash>  p nfsd_file_allocations:a | awk '{print $NF}' | perl -e
> > 'while(<>){ $sum +=3D $_; } print $sum, "\n";'
> > 114664232
> > crash> p nfsd_file_releases:a | awk '{print $NF}' | perl -e
> > 'while(<>){ $sum +=3D $_; } print $sum, "\n";'
> > 114664221
> >
> > So yes, 1/4 is needed for fixing the issue.
>
> What exactly is 1/4?  For where?
>
> Sorry, top posting loses all context :(
>
> greg k-h

