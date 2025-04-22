Return-Path: <stable+bounces-135120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59C7A96BB8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB643A3A63
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9837427E1DC;
	Tue, 22 Apr 2025 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5uXIhno"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E427466
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326865; cv=none; b=HscTi5qJGaG6rcenGQSv9oEgTJ9YFIGsMISlYQV8k/VJo6cjK7qFFfk40BnwpO0LoJiddbP1iKkEYACAN4ls//A+otiDDOnenbCiyeowkQ7+90sIh1R2cLpcogAYIGhT93L9L5OpZxeSNWY3p7RIfdp6Os/IPgHoTlAUtceIyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326865; c=relaxed/simple;
	bh=JlnacHQz2zXpzchLGjtlvEaNaLcyKI8AZd/3MGc36GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OX1Df6zuSZeIpszHPu4d2aTFDiDJ5g3MSEbGJI7evNV269VZTqeAkGP5G2aYThuKgj3AwMPViWKmSjMG9yq8sXgBKJtOeMzLRhcG4qUPZxP7uojxmvaktMWzlXtp90WA1rUb/GxtIndTE7ycJLLKhyzk26Dm0N6wEu28ISprUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5uXIhno; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b1276984386so83327a12.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745326863; x=1745931663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMQaVeR3x4YkFMJA2BzDkkwgCbMHhGjo7H0lhGLmoyA=;
        b=B5uXIhnoMNKawSopoeI6OtTw/K9uBsM5YwV7LaCzzj6BVvq5F03A+NuI5Yy7Q2X6WN
         bAL9RuCwkc4XdEE/PobS6aBMwViv9JQL0YudjsUmWK01Q7cyRZnA1+dGovxEGfsWTwux
         hHCe+HKY2vuU/O/RjDMZXoquXqfNKbLremOx5qjOgJEIzQTvwZaFAzEwKQFEQUmhZTmI
         ahKMAMIIlqpnD8bOgCCLwO6CKspDqgW68JYEK4onxifFkVb0BS9EJlQBwMMIHQtkDW5L
         nfgAhdDCMgYedVzfQKb7bKwb7y+X+dqe+Mgj9pMvpJhLRZngNcu2rspk7AzT6bdGAkKo
         W8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745326863; x=1745931663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMQaVeR3x4YkFMJA2BzDkkwgCbMHhGjo7H0lhGLmoyA=;
        b=sqgBRwZIFJGC0H2ze027ctEdoLG24xQZ0ePOkZxtXyRjg2frWhyrcKxwVXkGLUhFhG
         yd6ZQOVh/LLTVgYv6x9nXAGh76lvTuU+Tyg7R/CwVY1E5r6M9XdnbDNiGNHZpmBr5eOd
         VygmyHNwqVjW+GcsFGH1K+Gzc5BbM0ASz4NflpfC8xdlVYD0NBQXpEWd/wWzhLYmN/RV
         I/VW4qyVsU1kDfoahNYO5Lk2/cvY7GlcMDkZo/cSbtPaj8rVtv57t4um4aRCRCu14VqV
         JjrACSYNkCITiGuAa60IbovphavUAh3B2MOZYNYlmaBawsBywyQPRxXNBmOOJt0sw5+o
         Y02g==
X-Forwarded-Encrypted: i=1; AJvYcCUP/1KVPLvI0NZUsSMF64747nA0yGEWBGsrys2wmACJcuEWalzpZKrsrNI1V0fQZYr9Qsb7VEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5E19I9bcQQgEXPwGFhzUy8y4qgPXlaP1AI5JbKHD+x/GUI2Do
	uyNuCd1W/MtpZzF1Xl32vDoq1Ukj+5agQZgvvj9cLfVzrrH3yql79QCSl55Ecy1pACfTHhRqK9k
	NelZyCeFJ9nUY+nfk5bPD3/ZOCCQ=
X-Gm-Gg: ASbGnctlH5UF5eOixsGTqw/qqK61ca2ZlXxLAgY8kNtDJs7SJCBB3AD7aDk+kUKPiY9
	flGCAP9U84zuKqYsfw0ov12Bzhlv3omsMerhr0N6JFSqoSFurgZmLes8CUEP10tDAu7Ke+vJr3y
	rgrFdq/HAqxxlXIKS4SReo4g==
X-Google-Smtp-Source: AGHT+IE2rBFaVyNkbpbvryC/1IsZvy1wKkM+KnDrUqSyaIMMwOtvPffaka1pMn5zR7USL3XmQIxDElZFWPTj2vbI4Js=
X-Received: by 2002:a17:90b:1b44:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-3087ba5ea96mr8603347a91.0.1745326862532; Tue, 22 Apr 2025
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org> <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org> <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com> <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
In-Reply-To: <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 09:00:49 -0400
X-Gm-Features: ATxdqUH2hkViMgnErFFpI6VX1e4K3fATFOHKYd1vBRtymzw7NTvXXweUuy0lPgM
Message-ID: <CADnq5_ML25QA7xD+bLqNprO3zzTxJYLkiVw-KmeP-N6TqNHRYA@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lzdGVtIGVycm9yIA==?=
	=?UTF-8?B?ZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Fugang Duan <fugang.duan@cixtech.com>, 
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "david.belanger@amd.com" <david.belanger@amd.com>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, Peter Chen <peter.chen@cixtech.com>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 10:21=E2=80=AFPM Alexey Klimov <alexey.klimov@linar=
o.org> wrote:
>
> On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
> > On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixtec=
h.com> wrote:
> >>
> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=
=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 22:49
> >> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org>
> >> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.klimov@=
linaro.org> wrote:
> >> >>
> >> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> >> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.=
org> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
> >> >=E6=97=A5 2:28
> >> >> >>#regzbot introduced: v6.12..v6.13
> >> >>
> >> >> [..]
> >> >>
> >> >> >>The only change related to hdp_v5_0_flush_hdp() was
> >> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing H=
DP
> >> >> >>
> >> >> >>Reverting that commit ^^ did help and resolved that problem. Befo=
re
> >> >> >>sending revert as-is I was interested to know if there supposed t=
o
> >> >> >>be a proper fix for this or maybe someone is interested to debug =
this or
> >> >have any suggestions.
> >> >> >>
> >> >> > Can you revert the change and try again
> >> >> > https://gitlab.com/linux-kernel/linux/-/commit/cf424020e040be35df=
05b
> >> >> > 682b546b255e74a420f
> >> >>
> >> >> Please read my email in the first place.
> >> >> Let me quote just in case:
> >> >>
> >> >> >The only change related to hdp_v5_0_flush_hdp() was
> >> >> >cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HD=
P
> >> >>
> >> >> >Reverting that commit ^^ did help and resolved that problem.
> >> >
> >> >We can't really revert the change as that will lead to coherency prob=
lems.  What
> >> >is the page size on your system?  Does the attached patch fix it?
> >> >
> >> >Alex
> >> >
> >> 4K page size.  We can try the fix if we got the environment.
> >
> > OK.  that patch won't change anything then.  Can you try this patch ins=
tead?
>
> Config I am using is basically defconfig wrt memory parameters, yeah, i u=
se 4k.
>
> So I tested that patch, thank you, and some other different configuration=
s --
> nothing helped. Exactly the same behaviour with the same backtrace.

Did you test the first (4k check) or the second (don't remap on ARM) patch?

>
> So it seems that it is firmware problem after all?

There is no GPU firmware involved in this operation.  It's just a
posted write.  E.g., we write to a register to flush the HDP write
queue and then read the register back to make sure the write posted.
If the second patch didn't help, then perhaps there is some issue with
MMIO access on your platform?

Alex

>
> Thanks,
> Alexey

