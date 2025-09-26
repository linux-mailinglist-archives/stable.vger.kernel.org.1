Return-Path: <stable+bounces-181792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27437BA4FF4
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 21:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BB71C2038A
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16C28153D;
	Fri, 26 Sep 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUXSWAmH"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044781C28E
	for <stable@vger.kernel.org>; Fri, 26 Sep 2025 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916266; cv=none; b=WIJ13sWVpnh4e2clbhBzS6B8cG9MI/Tok6dvnHXTl0e89Ljy4sZ4oJpxM6LKGU+DDrhfwOTx6e+PUGZ7nQ3XeVsmF6WiqB/QWQB6CB4lrTdAWDB/W3hPu646W2Xfw9LvrPLErpo36R3//IJuCZC3aKmFH3OygTtvDG80+Y02FoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916266; c=relaxed/simple;
	bh=mIgdAucLc1u+3OkJJI1pbpONXxhzgedhI+0k2CsiHM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WS2moAeVXFouZiJi5S+wFkq3m2akWwUGP15yB1ptqny432LTi+lLbsMelLLoNnX7AJMn95OT2c/s5/XRbWQ7ijWatEnU+WkM9RUPjJEaeEOFis3CzXfOoFLp+7It0t56/IjV0j6oYveaFle1UecNCq1CkiRM51qgHaqAJGV2LZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUXSWAmH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57abcb8a41eso171e87.1
        for <stable@vger.kernel.org>; Fri, 26 Sep 2025 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758916263; x=1759521063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ip017FMnVxrXIHAt9kopjLMyNWF+o8u1hHFJYtAWs5k=;
        b=eUXSWAmHp4F+GYvjst7EjCfCg8I9h8LggNjaPl4Zi1d8l22MbFTNIAmLxfGvS5dsNW
         p2sM/m1Fl6j+4M0sMZH/AasWkMOuVdQZGKvC23eHeNo5I1ekZQ2X6b0zz9/a8Bny/7+6
         9DznJHyVHHEO3SfRi7hzIKVzrqxqH7pb+9PAoF3yUfIAt2MgPglKZv7d1Uljxu5uxsjX
         CsAAnad96vM1eGUQCrdGr6SJRWJ3aTctUvIK0udiFRbzBX5MSz04xbLLIjI4XtVswfRV
         TWkXUiKU7A/cbOX6DGU3ww9EaNYHAZ+4sKeg5NqSKJdyShFJ2CO7pfhzgvBSZ8p5sizE
         fhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758916263; x=1759521063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ip017FMnVxrXIHAt9kopjLMyNWF+o8u1hHFJYtAWs5k=;
        b=XXSYSx9TL/OPSXvygSaI+dRlOLyuekU5Oqh6i2cwV+qsPHtLh4kEGDhmq7IsIvNQAx
         AYfeNWtWITvcPsZKwJb05p5NunF13VFK0VGIFxM9b4bj4ZSbsqSmvbK+LPIHI0AZu4A9
         4nOzIlpudnExojM4qhv+wLz0H4Pc4ju2R6aDPcHoPakd3HzRy4Cne+e9sd1QimQ59hrM
         KOyjksrS2GmNuD4ttGGi8uHd4In+WKy4AcFbgfyyrZmkY92Iuz0cD+iXaN6is+8SBrD9
         I8sSGCgJ8t/emVxp3pabYV2Nxhw4D60s5prB4ckQNkOZM5PS2qL3AHzBKETpXm/+stPr
         BSzQ==
X-Gm-Message-State: AOJu0YyySPtqKhXHCkozWlDEpis2M14tHqhsn45KVz7EzNeWGhPG1Xb6
	2XDdoAuOZdo4KZr2XAv07jSew2gLV7lUmQ8ith0wuyiFEmEPdIJ4zlA4PrOQYjJX/Tt7OXEYHo2
	rKDvnBIK+Dbpb/SI9lI2QSUl97ZlBC/5zKaHDDgti
X-Gm-Gg: ASbGncvBqPAnfEZmOtsMaHO0zqerRw6nGJhT9XqpwPx0zR1vkKzs8s5I/3114t1ExfZ
	fe2bGMduI19DiRk387K0Xmbj6CMzL5AnlOHMGgh78HhLlKBUy951fLC2uSiNP8BQkUSD+chY1ac
	Mo/zqTsphf0yhhsbBrrJrPTM4LDDO6vF4R55oV+OrssbX9oIrQGcSV1bWiOpW9EykpnZ6pmhcN/
	CFXGQv6kmmjVQ==
X-Google-Smtp-Source: AGHT+IEE5OaYdO0IaMGFY36b6MbwvrxUfn/XZsaRUGWhiPwBfx1smyDXptqX2r5rZlNLWNxdoLF1cU0Oyz9dS7BV5oA=
X-Received: by 2002:ac2:4349:0:b0:579:49:344f with SMTP id 2adb3069b0e04-584303cd819mr413762e87.0.1758916262755;
 Fri, 26 Sep 2025 12:51:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdxtTZJqgDNMtqsq51hQ0azanFPLXHMAJ-mRhRS6yjzYhMf_A@mail.gmail.com>
 <aNSSNgUeMSTtlimW@slm.duckdns.org>
In-Reply-To: <aNSSNgUeMSTtlimW@slm.duckdns.org>
From: Chenglong Tang <chenglongtang@google.com>
Date: Fri, 26 Sep 2025 12:50:51 -0700
X-Gm-Features: AS18NWAN5nGcUSbNskAJzYe71VDRCVrJaJpdw8gBe4Wx0-59iqP8y5qS9LyHsiY
Message-ID: <CAOdxtTZmqGpT85ER+c4VsQfoo+AHDyWC+6MG__hm5i6+sVoaWQ@mail.gmail.com>
Subject: Re: [REGRESSION] workqueue/writeback: Severe CPU hang due to kworker
 proliferation during I/O flush and cgroup cleanup
To: Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, lakitu-dev@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just did more testing here. Confirmed that the system hang's still
there but less frequently(6/40) with the patches
http://lkml.kernel.org/r/20250912103522.2935-1-jack@suse.cz appied to
v6.17-rc7. In the bad instances, the kworker count climbed to over
600+ and caused the hang over 80+ seconds.

So I think the patches didn't fully solve the issue.




On Wed, Sep 24, 2025 at 5:52=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Sep 24, 2025 at 05:24:15PM -0700, Chenglong Tang wrote:
> > The kernel v6.1 is good. The hang is reliably triggered(over 80% chance=
) on
> > kernels v6.6 and 6.12 and intermittently on mainline(6.17-rc7) with the
> > following steps:
> > -
> >
> > *Environment:* A machine with a fast SSD and a high core count (e.g.,
> > Google Cloud's N2-standard-128).
> > -
> >
> > *Workload:* Concurrently generate a large number of files (e.g., 2 mill=
ion)
> > using multiple services managed by systemd-run. This creates significan=
t
> > I/O and cgroup churn.
> > -
> >
> > *Trigger:* After the file generation completes, terminate the systemd-r=
un
> > services.
> > -
> >
> > *Result:* Shortly after the services are killed, the system's CPU load
> > spikes, leading to a massive number of kworker/+inode_switch_wbs thread=
s
> > and a system-wide hang/livelock where the machine becomes unresponsive =
(20s
> > - 300s).
>
> Sounds like:
>
>  http://lkml.kernel.org/r/20250912103522.2935-1-jack@suse.cz
>
> Can you see whether those patches resolve the problem?
>
> Thanks.
>
> --
> tejun

