Return-Path: <stable+bounces-107955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 550BDA05221
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 05:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C851677E4
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A412594B3;
	Wed,  8 Jan 2025 04:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOd1lFyU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5BE27466;
	Wed,  8 Jan 2025 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736310892; cv=none; b=jsReMUfifvIzY2KOKHqmQWmAxR5ehFf4VZwKAUaEoRo9U3apWUTfmTkcwht0EZz1lPgGnGlmglcpS47c6fwHp3ICvSt+nlwgYqSEYpnyiqIXRqiG+Hz6TMt5layYitwj1m7F1lR+Mxfn7ChfINK5ViJ+DwOndpBWiZ85rsfwiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736310892; c=relaxed/simple;
	bh=NP+fZWGe0Uao5SohUsCX5PK+L7Mx/lE0cMl5qB5iqXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khTYCg8Q1/Z01+/H3e1IFF2D6CRRNvdzI+CASPXz7mEub7En9i3yg8MFly7souj3hrOXuGVO4St6wdnIAWBbey+SzFxIji31Zh8/7JAtP8XrS0XJgw4yGhGaq0BzADuOP453GodBJZlVzT6NtZs1O407dbm0pFf4GxGfu0dj4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOd1lFyU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d92e457230so157443946d6.1;
        Tue, 07 Jan 2025 20:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736310889; x=1736915689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP+fZWGe0Uao5SohUsCX5PK+L7Mx/lE0cMl5qB5iqXU=;
        b=ZOd1lFyU2JMAh/ylDMYN3Idih3UDDzADBC7WrmBwoNCpKncXZt3JXiRbjyfayD0JZ8
         jPgofUmd9W96tCzASsU+NR1npWbVlkgq1Jei+Wd5yRQ+VlK7fKE1z3PtBy0IdFqZWffW
         b5bShgLL2CM2ITPRZOMcpGYJKVqebsvg/xCyfqpOezApR7FWuGp7RJCO3FTurXiDRyFx
         aFNyKJNVdVm75wxb9phkvjRQe3prh81IK/gyyP1q7MzcbrzVo+KuF+5SOJB0dy+jzcrD
         jOdMcvWQB0g0l3vSkTTEViohC+4EUDYMN2xKEPFS6gpnlQqJmPLX0jjKTy57sGVS5sdf
         mEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736310889; x=1736915689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP+fZWGe0Uao5SohUsCX5PK+L7Mx/lE0cMl5qB5iqXU=;
        b=L2GSJUrcZqRAbooB+O8CC1rfVsIKbopLVjPQTNVPwoG/8WZ6NT738Peo/wS6r2DRaT
         n9vbZcct1WwEeCarJt2Fn7Ws2/I9AwpW3209QI8W4yQoAj5FcHWvTcoKv/OgsNtFHPq3
         KhhYGP5nIp5LXoJkqmHVXayUgd1gQntN7AAIog+/EY4dSGdrcOtJTR4WpNI6oBxW7WL+
         eo9kqosk+23TelMJgeZ80fbrCPtNSWbYKT9IadLuUCFd0cBooloSBX9mtyp4E2dpInIj
         AvWgHJqQP7dxhzXLNd30PvVXFOIel11KhoafuSltFzbtybzxNfkV8TL0xcFpDxm7V8yW
         DxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXSyNcBWkAoC000u20c6zyz6mDINnXtXvmngjQFImhhUgY891N9E9BHBRhFU2PypETJdIM+mD3@vger.kernel.org, AJvYcCUuO3F90+aK5ZOP7TcKXU696N8qqDthGqKoNaPjMVrfjNCLcry6hxADscxrEiYL/VMivXs9P2osRcD7LYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGfe8I+QFZFSybnF9fBrOWY6npbMHRFXLA7d4W8Dta/Gx1MU0c
	7UUIGRH4or6qJQqOVTFT1SX4kchjzb3AohOYbKbC/8fJYMs4q4aRpZf3YkpuvzEi3v8I0TvYa/7
	PR68wuFM9bWeBnQ4cI/1uvWYtMoU=
X-Gm-Gg: ASbGncsOcYtsDh13f1Lxr25fT94OAjn3saHI181PATpPNrgEBL87qTSwF1K7eWrAK93
	9Zlu6y4Zz5DECAUauSBCv9NfQSqCW+hhknDb0
X-Google-Smtp-Source: AGHT+IFyQQswgYJMNAk+54odFWajNP0BP6ZfaT/jlBHtJsyoaAAoln0VI0PhVY67hTt8NMczP843dkAIBQ4s2n/VyYQ=
X-Received: by 2002:ad4:5bcc:0:b0:6d8:a9dc:5a65 with SMTP id
 6a1803df08f44-6df9b32b347mr22687096d6.45.1736310889408; Tue, 07 Jan 2025
 20:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107074724.1756696-1-yosryahmed@google.com>
 <20250107074724.1756696-2-yosryahmed@google.com> <20250107180345.GD37530@cmpxchg.org>
 <CAJD7tkYNvyVh2ETdbHrmtJRzKwVX3pPvite+cy0aS6cwJe5ePw@mail.gmail.com>
 <CAJD7tkYhO7DAQTrmb1A2H_FsaExoa1fp+C8vQw0MmzkmM+KyUA@mail.gmail.com>
 <CAKEwX=M_wTnd9yWf4yzjjgPEsjMFW-TAr_m_29YK4-tDE0UMpA@mail.gmail.com> <CAJD7tkZffK+05e8fLnUWFA0+2AsJKf9xjEKFoX4mgyFxqd5rSQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZffK+05e8fLnUWFA0+2AsJKf9xjEKFoX4mgyFxqd5rSQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Jan 2025 11:34:38 +0700
X-Gm-Features: AbW1kvZadO9xN9joBYCbG2hDV0vjUGMmKTGP3MBC676S2dwZUuSYc6ZPsTNGbFo
Message-ID: <CAKEwX=PdNo-Me1GL760PhaWR0QRdqhWF0tm33KHCU3qubsp+hQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] mm: zswap: use SRCU to synchronize with CPU hotunplug
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 11:14=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jan 7, 2025 at 7:56=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> I may have found a simpler "proper" fix than disabling migration,
> please see my suggestion in:
> https://lore.kernel.org/lkml/CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TF=
MWWQRzQ@mail.gmail.com/

Discovered that thread just now - sorry, too many emails to catch up
on :) Taking a look now.

>
> >
> > Is this a frequently occured problem in the wild? If so, we can
> > disable migration to firefight, and then do the proper thing down the
> > line.
>
> I don't believe so. Actually, I think the deadlock introduced by the
> previous fix is more problematic than the UAF it fixes.
>
> Andrew, could you please pick up patch 1 (the revert) while we figure
> out the alternative fix? It's important that it lands in v6.13 to
> avoid the possibility of deadlock. Figuring out an alternative fix is
> less important.

Agree. Let's revert the "fix" first. CPU offlining is a much rarer
event than this deadlocking scenario discovered by syzbot.

