Return-Path: <stable+bounces-208321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD9BD1C8FA
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 06:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D785D30388A9
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 05:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8E34EEF4;
	Wed, 14 Jan 2026 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TX5Yluit"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F5832ED21
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 05:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768367792; cv=none; b=aGtcHlPYiAkgDXCe7m3EX1PQYxNlKcyVrEiqy8lQNWBRC8VSte0Kdojj/Yg3KK4UgZETCh1EIKk10VTqJ34qv9mpndUZGe/4OlXQYypHYI4pUfg3P6UBDace+t7wWpin7G/drlIZn/a9oS1cFeTLqrXGoMg6mK4bV0JyekNkV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768367792; c=relaxed/simple;
	bh=iP3S/72fuu/L/exhomw5MypN4Y5Gkqbqe4ilsP/Xh9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpUibeWseG6UYWYDNU2aKmJQ8FHfjHpmyNiHYXthe+QBta5aH+p+vhoLW53VC2NQosZdv8swTCRuwjIBvfW/HYWRLyAcZzyEryxe7taddFpA9VSjft4z7k8bvzvcL6pI0s2By1P/tpBY5DE4Bbq/6bjIin9HipLwJh9WqSkLDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TX5Yluit; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8887f43b224so133296786d6.1
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 21:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768367778; x=1768972578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezdkIkld7c/oSBzC35T3zK1WNNmb2BZY9Vgt94zhRnA=;
        b=TX5YluitevghmW0OHjqC6VOV7NYfDVLG18JvQ7C6Vn+vpssFT9q3N/n3kt/F2RZ2R9
         Vg7Dy//icNJGcbuz3WDQhv8ugasQVTExvncNoTgOoNAVHVGYjD95Ah4ZjXa6KlOEW1p+
         Vzrt5JSWrRIJzeMAfyrT832c/e25CurqzzA44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768367778; x=1768972578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezdkIkld7c/oSBzC35T3zK1WNNmb2BZY9Vgt94zhRnA=;
        b=M6qT0a6z2siHjHJXeAuh93CnFGLwPby/AZEd1qAZfHORf+KEgWqo8lvx2MKdQO5P5q
         ryuiaIJO+hmtmvR2qdjc/MURLfwMUgxpKQGLDB7g3+XeCnjjDxI9LS2n8Gac/yUHjxcf
         pXKu2JLFDQQjHVaUwTHxlo3+AAP6KvluHVfPMtUdccFaHQ69GTEn9L0JT+ICHdQDHewW
         7vbRRCIBTeMMEIsYKTE0B5FMVfYvKjV/Kcl3gvVa12OmoRu8FyqaURd69g3NLO/1IgoN
         +cM43yOsWk3nn0s/nbqYxUPu/0LN9HPE0GV5bw0zxlEbufdhhgie+FwokL+LNB4zF4F1
         mRSA==
X-Forwarded-Encrypted: i=1; AJvYcCWR3oNIZ2GLjJ3TvH6YtkcYOlXQfwlwb7k3yEHFIZSUoAa+9xR43xFPmUsPO6AD/Ft8mxahV+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtR3DLVv1na0e1alz/gDNlKRD0pxkhTs7LQqNEqlJOfQ0GOQ/
	7qX5aKGObk+/bX10gmGrIq8ffwIPhYwDBL0pJ4WqjBKXYGwGdBpa4d/9DicVHfKOdr3/EEkLJnW
	Sytw2pA==
X-Gm-Gg: AY/fxX5gLAI39xPKpZ3syKNaISVI5F6AIzZGzva0E15PzL3bB0fg0ZwqlGBIWSmRUo7
	ixqbTjld4i+UxrDOEfn0bTtrcqjyLZReiVlMqkQnD8KP8v32pXW+ExP9TEOyKri8ABqVTP0sZYK
	PmfKeUdHzsiI/IPTn+VULB7xkJO5BUyF5G8OR2tqzfXZCxdy3Ilge68Ip5G8JMzJdMkUxP/zHcR
	DPte76GXJ+rjGU8QzaqCWfVCzFgwtnkV0uorls1CyQ/1jG0Srxrz9TtN2zoXi7grmuJk7pkKIkT
	Ab2zaw19mvxRNe/2aP/WoD1b8YLaC5W+J/aNInh6g/fGkUTxcCUA6ba2C3zd1PtzLs1E39o6ZPR
	VnCGrrCPvt9CLv/R0RdY53OW4Dj9XJTD/QSW46f/J3W8TTw4tFlLqJBuI2gKaUHpBi0wpsKzeQg
	y7IpT2t/Tage1tKi5fHs0yVexAe/CR0bkPs8l+o4yF3L/hgqK9y/Y31g641Zoj
X-Received: by 2002:a05:6214:258c:b0:88f:e334:8d5 with SMTP id 6a1803df08f44-8927431de8emr17519456d6.22.1768367777955;
        Tue, 13 Jan 2026 21:16:17 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89076fa0718sm167156526d6.0.2026.01.13.21.16.15
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 21:16:16 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5014acad6f2so126271cf.1
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 21:16:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjKVNk1xfD3w44inxReElNeJZRj/Fkk0Y2KdSrO5BfRjZifxUYTYL9Mb7QLVb68Abd2bqtSyA=@vger.kernel.org
X-Received: by 2002:ac8:5e48:0:b0:4f1:a61a:1e8 with SMTP id
 d75a77b69052e-5014825a304mr6273611cf.10.1768367775388; Tue, 13 Jan 2026
 21:16:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d4690be7-9b81-498e-868b-fb4f1d558e08@oracle.com>
 <39c7d882-6711-4178-bce6-c1e4fc909b84@arm.com> <005401dc64a4$75f1d770$61d58650$@telus.net>
 <b36a7037-ca96-49ec-9b39-6e9808d6718c@oracle.com> <6347bf83-545b-4e85-a5af-1d0c7ea24844@arm.com>
 <e1572bc2-08e7-4669-a943-005da4d59775@oracle.com> <CAJZ5v0ja21yONr-F8sfzzV-E4CQ=0NqLPmOeaSiepjS4mKEhog@mail.gmail.com>
 <CAJZ5v0hgFeeXw6UM67Ty9w9HHQYTydFxqEr-j+wHz4B7w-aB1Q@mail.gmail.com>
 <rsqh4kpcyodnmcxcdd3yvysdmnfj34fgjtr4pmfhlg2cqtvlhh@iakffruxcnac> <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
In-Reply-To: <ndqg2mysdc4bsvokmrqubx6rw3oj3lrflxw3naqiohbg7yablf@ccm3rl36dnai>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 14 Jan 2026 14:15:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DBsd4tMcRuVwD3=csJ=4=DMcJhzah+-CTq31qOZHyJEg@mail.gmail.com>
X-Gm-Features: AZwV_QgaEM5U0dghv7arOEC9sAg-1oiklciKgVxEPDm8-o619IU-2A6jT2MKyE8
Message-ID: <CAAFQd5DBsd4tMcRuVwD3=csJ=4=DMcJhzah+-CTq31qOZHyJEg@mail.gmail.com>
Subject: Re: Performance regressions introduced via Revert "cpuidle: menu:
 Avoid discarding useful information" on 5.15 LTS
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Harshvardhan Jha <harshvardhan.j.jha@oracle.com>, 
	Christian Loehle <christian.loehle@arm.com>, Doug Smythies <dsmythies@telus.net>, 
	Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, Jan 14, 2026 at 1:49=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Cc-ing Tomasz
>
> On (26/01/14 13:28), Sergey Senozhatsky wrote:
> > Hi,
> >
> > On (26/01/13 15:18), Rafael J. Wysocki wrote:
> > [..]
> > > > > Bumping this as I discovered this issue on 6.12 stable branch als=
o. The
> > > > > reapplication seems inevitable. I shall get back to you with thes=
e
> > > > > details also.
> > > >
> > > > Yes, please, because I have another reason to restore the reverted =
commit.

Is the performance difference the reporter observed an actual
regression, or is it just a return to the level before the
optimization was merged into stable branches? If the latter, shouldn't
avoiding regressions be a priority over further optimizing for other
users?

If there is a really strong desire to reland this optimization, could
it at least be applied selectively to the CPUs that it's known to
help, or alternatively, made configurable?

Best,
Tomasz

> > >
> > > Sergey, did you see a performance regression from 85975daeaa4d
> > > ("cpuidle: menu: Avoid discarding useful information") on any
> > > platforms other than the Jasper Lake it was reported for?
> >
> > Let me try to dig it up.  I think I saw regressions on a number of
> > devices:
> >
> > ---
> > cpu family      : 6
> > model           : 122
> > model name      : Intel(R) Pentium(R) Silver N5000 CPU @ 1.10GHz
> > ---
> > cpu family      : 6
> > model           : 122
> > model name      : Intel(R) Celeron(R) N4100 CPU @ 1.10GHz
> > ---
> > cpu family      : 6
> > model           : 156
> > model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
> > ---
> > cpu family      : 6
> > model           : 156
> > model name      : Intel(R) Celeron(R) N4500 @ 1.10GHz
> > ---
> > cpu family      : 6
> > model           : 156
> > model name      : Intel(R) Pentium(R) Silver N6000 @ 1.10GHz
> >
> >
> > I guess family 6/model 122 is not Jasper Lake?
> >
> > I also saw some where the patch in question seemed to improve the
> > metrics, but regressions are more important, so the revert simply
> > put all of the boards back to the previous state.

