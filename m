Return-Path: <stable+bounces-105556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F29FA546
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 11:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC941888DC6
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4324189B86;
	Sun, 22 Dec 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgRyZ/fR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF4188722;
	Sun, 22 Dec 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734863868; cv=none; b=A2hs5m5A/ouT0RPbmDVlLgGLvuoAmtQWYgnZTYcCjth+V6ao1/5LRtdDNOZh8knVPA95HfAkssiP4X160neWdBLiPT7/lqMj6MvpXK4BYE/f6J7OeWmf/jYdPW19uWpRrrqbZF2dEuG1+ydU0LzDPX/E8ZFH8oYACGXrJf12djI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734863868; c=relaxed/simple;
	bh=Dih0UevojjK6aYi/hraFiM0YbAA8nuuUB3ySstbKIVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5vEWinr0jaQHeWJUEkLwBaaVO56rNR+yFqnnDfYnQq06vALdGicbLwtymr7/e7shq0XKidGJgRQdAZrCUob7q6C6GtEsE6zuLZpeXw/4YWhcItbQOCiXtslWYdTo8hNsxrkRf1UeYKf892BAHTbi5LH+QCZ4cIeesJHdEnTbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgRyZ/fR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30219437e63so45247071fa.1;
        Sun, 22 Dec 2024 02:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734863865; x=1735468665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uAf4XYF+BN/cynPMUouPVnj1TJkDYFatX5sPirx1ssQ=;
        b=jgRyZ/fRlojXXeydOYmFkCT6KmB7srXsWO/FZQaMFH9Kq9NknjUU+AqR6czT3WXDqx
         sEmgBR7L2A9dmXhSWlXtvIUqFjvQNQrhd/SBEwNz05uD71TnUJFoqA37PbofU4I1knjJ
         qKEzfs0Ic5c7qa/8GY3Aid4gRXGsFJwAgmd7aqw0hfHkk0K1xJ5nxNQBCEpZ9mI1Aeg5
         P4w3dtmdVjwmvhCtxdBNRIHSQyMo55FP/KDBkhToI7sOle44NB+bVZUxONqOaR1G3Z7J
         8kPy1F6PuU8fnUguShwREpqxCFfeeup95rgmp/aIHLrBJHhvR1tlP3gqeUkoDSrJPvel
         yWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734863865; x=1735468665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAf4XYF+BN/cynPMUouPVnj1TJkDYFatX5sPirx1ssQ=;
        b=jktImjgfIOFP/027xdMbu9ksb3fdYoOgjZeIYubhDkE2vjuao17dQkTGPSfQiH8Z/3
         r4mpugbpaUs377dE+GmLnXrmOX+IskZev04b9uP4ogzgK+pG4Hgfgqxbp+wd+pAWcWAX
         sA3atUXDRaJIgZcaMWgkvF4q5I7IIscZMC1t7NSrzGItSS7I1o8SNjDwr0c5b/gmcRkl
         xAyGYKOyyOTaBiVfIOEadEnx8gXBLZpafg4d4zyfFdAnj1vFe0usfyezmdbzyUDK3gaX
         bVIA0wIgErKWdSRD93jAFjAwTRj9qEugjXDaBUWgel/RmFlckb0CN90XXinzk5Ca4n0i
         Neaw==
X-Forwarded-Encrypted: i=1; AJvYcCVvt2nWFBRLrSBx/pa8kAatZDrXTIIQK574TL/5ZXlEtc+Zf9gfh0jGKBShYaaKq618Gny7OwM4@vger.kernel.org, AJvYcCX9hFZW7EqOwxMgCIk8s2p6OA2e/ldevbWdt3NJBa7p96pv/sFoPDAxVnT+GWUVaPTIrVxpbSRRvBim4SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkXPpQh3pfKEcfs38yWGUTxLzde4PolMsACUCjvXR8wvOQd5Ab
	vdk97FcWD4VuYyAm7XgRZnGjoMxyqBJpmyXMYzOyInWXhMVxD3FlRbf/OeXlk82grfT5s2aaEpm
	OTmcxOTmMQp9xfk7kMMSRRDT36hY=
X-Gm-Gg: ASbGnctkf7PpmtsSH0AlddqSYAlBopfcxo1nlJbFh4UIQloxmhnV28zBikjUA+ouMp2
	ucfpUeA/BbcTxt1fBGXgJMljREHo5pAxc0vhEAiwwPY4wChL7J57eebU2itsPQt630YFA
X-Google-Smtp-Source: AGHT+IGJ4XnG6hPJJ83WUCPU4UF5z2bmt9KoMQ+xXAQfdQtvpcUiv3Qt3tZqeiwj1hLIlyJ3fx6mjYGevzp0orcU4bE=
X-Received: by 2002:a05:6512:3510:b0:542:2952:8848 with SMTP id
 2adb3069b0e04-54229529bb5mr1819462e87.3.1734863864768; Sun, 22 Dec 2024
 02:37:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>
 <099d3a80-4fdb-49a7-9fd0-207d7386551f@citrix.com> <CA+icZUX98gQ54hePEWNauiU41XQV7qdKJx5PiiXzxy+6yW7hTw@mail.gmail.com>
 <CA+icZUW-i53boHBPt+8zh-D921XFbPb_Kc=dzdgCK1QvkOgCsw@mail.gmail.com>
 <90640a5d-ff17-4555-adc6-ae9e21e24ebd@citrix.com> <CA+icZUVo69swc9QfwJr+mDuHqJKcFUexc08voP2O41g31HGx5w@mail.gmail.com>
 <43166e29-ff2d-4a9d-8c1b-41b5e247974b@citrix.com> <CA+icZUUp9rgx2Dvsww6QbTGRZz5=mf75D0_KncwdgCEZe01-EA@mail.gmail.com>
 <CA+icZUV0HEF_hwr-eSovntfcT0++FBrQN-HbFL+oZtnKjJzLtA@mail.gmail.com> <698f48a0-b674-4d7f-9c47-f1f8bf86379e@citrix.com>
In-Reply-To: <698f48a0-b674-4d7f-9c47-f1f8bf86379e@citrix.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sun, 22 Dec 2024 11:37:08 +0100
Message-ID: <CA+icZUW454ND85nbjqAoMg42=i+aGht8Z=iG2wKj=Un7Ot0y6Q@mail.gmail.com>
Subject: Re: [Linux-6.12.y] XEN: CVE-2024-53241 / XSA-466 and Clang-kCFI
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Jan Beulich <jbeulich@suse.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	xen-devel <xen-devel@lists.xenproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 10:31=E2=80=AFPM Andrew Cooper
<andrew.cooper3@citrix.com> wrote:
>
> On 21/12/2024 6:25 pm, Sedat Dilek wrote:
> > With...
> >
> > dileks@iniza:~/src/xtf/git$ mv tests/xsa-454 ../
> > dileks@iniza:~/src/xtf/git$ mv tests/xsa-consoleio-write ../
>
> That's completely bizzare.   There's nothing interestingly different
> with those two tests vs the others.
>
> I take it the crash is repeatable when using either of these?
>
> ~Andrew

This time I stopped SDDM and thus KDE-6/Wayland session.

Tested with Debian's officially 6.12.6-amd64 kernel in VT-3.

test-hvm32pae-xsa-consoleio-write SUCCESS <--- 1st time I tried, never
said this is not OK

test-hvm64-xsa-454 leads to FROZEN system and DATA LOSS (here: ext4).
Reproducibly as told many times.- in Debian and selfmade kernels version 6.=
12.6.

Stolen from the picture I took with my smartphone:

sudo ./xft-runner test-hvm64-xsa-454

Executing 'xl create -p tests/xsa-454/test-hvm64-xsa-454.cfg'
Executing 'xl console test-hvm64-xsa-454'
Executing 'xl unpause test-hvm64-xsa-454'

^^ System does NOT react!

I can send you the picture on request.

-Sedat-

