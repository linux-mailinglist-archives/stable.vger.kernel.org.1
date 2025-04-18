Return-Path: <stable+bounces-134514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB5DA92F10
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D691B62051
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C012868B;
	Fri, 18 Apr 2025 01:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8qGa+ZC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EA278F37
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938649; cv=none; b=DKdoZHqcbddAQp+Ey2OXEA/7hv8h9ZNH2+elpFWr63Hd2mkY+ncy6BttHumcNSz15Wq7bL8Zv35zIPBKzoVB3yBPq9Wjyr2sEOWuUZtHkHKsuQWD4DdEK0hiXuAyvEDB0ppCrDjTooOTr1hFx2ZdoSlCGwChHLhtNpYnz7eXbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938649; c=relaxed/simple;
	bh=B9Benr0/RpNBrSd2xod5lGuZYL6dXWdrP2LLyuiJlf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiJ87raRm4knI4XvMb/pBmEUGAjX3D+C8JWUNhUDtso0ELHAp63aDiaNyDk44eYhj/KOb4nJgVdlN96Fy7sVBWoepsqyvT0aGOVvYTs87kV9KVSTj+FrgRfONRNTlaFPpC72mmeai7iRdFpc7CzNVDmesqVLkCODD7dSK1bnlSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8qGa+ZC; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ff67f44fcaso235441a91.3
        for <stable@vger.kernel.org>; Thu, 17 Apr 2025 18:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744938647; x=1745543447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7nETPg+IDemm8Piufm3ia7vwssw6aPw/0kpBxq7JZM=;
        b=B8qGa+ZCOGhGQKwchSP5LvmsVIVCUQjruw0Z1wmqoIlk8U9kw5zUJ/IRxdjlzbwVb8
         jOSLO7pJIAMg8AlLCiUx/ONrPik8vpJFqSrsYtjhOQL5ba32XxpQ2cKm8DlOaDfrwfC0
         EW+UKiIxbyYxK0oAiBe8zv5YnAbfWCQnCcM+ydJWEKd+fbFpMksM+MSLElMC4S433e5f
         LrcI4wI7wicu/Ie0s7evJXGiFOnlNhihYiDizD8Zbpg+QS8ZBtlLTCzLlQhznRnDOQKV
         oweH2GS8LrhvGM4jvpBSTeyUXJsm2tZeAdJiwPH0wdUDvce/PfPVVXBX3wNiTpdwdDg/
         4Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744938647; x=1745543447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7nETPg+IDemm8Piufm3ia7vwssw6aPw/0kpBxq7JZM=;
        b=kkyRSlgu8g5s5nMw5xkpHuaW694BmHI8+OSkGg8yGsC3SSfzisC6uPl3EQk8bG2hu2
         sdMEt7xh9+TYxdGOEhnKoIxuj+HQiQFejsK9cupet1xDomllaTk3oxSykSLflLOHsb9/
         Ed6tCE92ddL/nvc4zZP4NIwe3PzG+kl4jPuCURyJ5CYN0PUT5TmFh3TEtxfKQ5JLWtFT
         V7Q/T5pwDJQDJ2cQr4tdGFRYzCDCuP4kUtzis03jhcMPQDJ/pBHCpPxOKAP5qlkU8A/V
         NtbEN75HVtcVE1uwBd55k/kEZGve+xuZP9S2lTs+3tMMnZW8fAZXQjzzbMif+89Jk7Iv
         R/Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWk3JqqYKKxE+1N70vEE4B2uznh94ZLDaU3JEN5cLlFodCvf3BHRmnS9a/ZEeLI0Z7ZDC8zip4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBi+rFkk2cndbPHQyTdYccKFEGYgM+z0gMidps00FMK7cSWt0E
	r5GVzCHU76JA+jZetzT/J7+U+aNnZM1q1oy8E548LaATqT8AS+unCszjEfU9anwu1Ir3IP9KUxZ
	oLhafUolbyEnojVlp2/LmKzdhKug=
X-Gm-Gg: ASbGncuGucfkSRB10PCz4Lu+a2K4K9Wqyastvge4XHHZYKWs0NNnqdazW2TKQ6O6q/a
	oQLx0ZdBSOTpXS1OsvJKIz6bDSkLw9Hi6R7PmlTf54Vuu6xKwwd0JPgITW3Wq/3ZB/U0YDzDxPi
	tKCo8LnMQR8r+HhTO4TZlJ82davUKWNzTz
X-Google-Smtp-Source: AGHT+IGB3LlkcO/Zmqrhmx9Cbi6Z6kj57/61w+a/tBtR80nfrh/0qjkTkqsWScI5CmlOxB7P+pamMtN7oUHnq6ZZxss=
X-Received: by 2002:a17:90b:1c0a:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-3087bb30433mr523993a91.2.1744938646588; Thu, 17 Apr 2025
 18:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org> <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org> <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com> <SI2PR06MB5041A0BB912EBBC0032A94B8F1BF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041A0BB912EBBC0032A94B8F1BF2@SI2PR06MB5041.apcprd06.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Apr 2025 21:10:34 -0400
X-Gm-Features: ATxdqUGDEZvfp9V-P_wUUUSYUpfed3Uo-jgWRPQhyLWXle_ivZG6tFPYSajY0Mc
Message-ID: <CADnq5_MF5_ZNc-ipUhVefa-vGZewa+Hg2WOm3zpv49GmqeqNHQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JFR1JFU1NJT05dIGFtZGdwdTogYXN5bmMgc3lzdGVtIGVycm9yIA==?=
	=?UTF-8?B?ZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
To: Fugang Duan <fugang.duan@cixtech.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, 
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "david.belanger@amd.com" <david.belanger@amd.com>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, Peter Chen <peter.chen@cixtech.com>, 
	cix-kernel-upstream <cix-kernel-upstream@cixtech.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 8:30=E2=80=AFPM Fugang Duan <fugang.duan@cixtech.co=
m> wrote:
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=8F=
=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8817=E6=97=A5 21:08
> >On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixtech=
.com> wrote:
> >>
> >> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=
=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5
> >22:49
> >> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org>=
 On Wed, Apr 16, 2025 at
> >> >9:48=E2=80=AFAM Alexey Klimov <alexey.klimov@linaro.org> wrote:
> >> >>
> >> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> >> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.=
org> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44
> >=E6=9C=8816
> >> >=E6=97=A5 2:28
> >> >> >>#regzbot introduced: v6.12..v6.13
> >> >>
> >> >> [..]
> >> >>
> >> >> >>The only change related to hdp_v5_0_flush_hdp() was
> >> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing
> >> >> >>HDP
> >> >> >>
> >> >> >>Reverting that commit ^^ did help and resolved that problem.
> >> >> >>Before sending revert as-is I was interested to know if there
> >> >> >>supposed to be a proper fix for this or maybe someone is
> >> >> >>interested to debug this or
> >> >have any suggestions.
> >> >> >>
> >> >> > Can you revert the change and try again
> >> >> > https://gitlab.com/linux-kernel/linux/-/commit/cf424020e040be35df
> >> >> > 05b
> >> >> > 682b546b255e74a420f
> >> >>
> >> >> Please read my email in the first place.
> >> >> Let me quote just in case:
> >> >>
> >> >> >The only change related to hdp_v5_0_flush_hdp() was
> >> >> >cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing
> >> >> >HDP
> >> >>
> >> >> >Reverting that commit ^^ did help and resolved that problem.
> >> >
> >> >We can't really revert the change as that will lead to coherency
> >> >problems.  What is the page size on your system?  Does the attached p=
atch
> >fix it?
> >> >
> >> >Alex
> >> >
> >> 4K page size.  We can try the fix if we got the environment.
> >
> >OK.  that patch won't change anything then.  Can you try this patch inst=
ead?
> >
> >Alex
> >
> Alex, it is very sorry that our team don't have the GPU card in hands.
> It is better to ask amd gfx team help to try the fixes.

Sorry, we don't have the problematic arm board.  This code works as
expected on x86.

Alex

>
> >>
> >> Fugang
> >>
> >>
> >>
> >> This email (including its attachments) is intended only for the person=
 or entity
> >to which it is addressed and may contain information that is privileged,
> >confidential or otherwise protected from disclosure. Unauthorized use,
> >dissemination, distribution or copying of this email or the information =
herein
> >or taking any action in reliance on the contents of this email or the in=
formation
> >herein, by anyone other than the intended recipient, or an employee or a=
gent
> >responsible for delivering the message to the intended recipient, is str=
ictly
> >prohibited. If you are not the intended recipient, please do not read, c=
opy,
> >use or disclose any part of this e-mail to others. Please notify the sen=
der
> >immediately and permanently delete this e-mail and any attachments if yo=
u
> >received it in error. Internet communications cannot be guaranteed to be=
 timely,
> >secure, error-free or virus-free. The sender does not accept liability f=
or any
> >errors or omissions.
>
>
> This email (including its attachments) is intended only for the person or=
 entity to which it is addressed and may contain information that is privil=
eged, confidential or otherwise protected from disclosure. Unauthorized use=
, dissemination, distribution or copying of this email or the information h=
erein or taking any action in reliance on the contents of this email or the=
 information herein, by anyone other than the intended recipient, or an emp=
loyee or agent responsible for delivering the message to the intended recip=
ient, is strictly prohibited. If you are not the intended recipient, please=
 do not read, copy, use or disclose any part of this e-mail to others. Plea=
se notify the sender immediately and permanently delete this e-mail and any=
 attachments if you received it in error. Internet communications cannot be=
 guaranteed to be timely, secure, error-free or virus-free. The sender does=
 not accept liability for any errors or omissions.

