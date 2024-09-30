Return-Path: <stable+bounces-78269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6D98A6AD
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D61BCB25878
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06DD190052;
	Mon, 30 Sep 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBSvB64A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054AA18DF83
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705439; cv=none; b=pUEUmnKEK+lCEdJNiUfuaESVTXDUSPiPrumZzbY6E0L47r+lGDz7lMhFhgK45H+JIHX3txXQkjI/CVJF0yv9UH9UIBW2UZgwtM7nJb/qooVIZujZ1UDyW6y6kzO36OfRJwFUfoX/0eKnZVlu3LqL4yHCJkaDYwoi3PbW3Z9R+2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705439; c=relaxed/simple;
	bh=/r+t+YGLR0BTLh9CUO53Ejrg4XuSTEux2M0bULlJS3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kg1hWmd2EaSNitKVX34/c/TsC4w2hZvvqATP1jdkQyNiY2QqJpJlj8H1nTIsAMU/NR32GseFLzGX5QjVqBQtQ0HFm4VUgXA//2CY+YkpFCThriN7BaBNLr9KXXdLY7OfhkiYjn3rfOu3Xyfk3q5jduY7oin7vBoUcCxeqa6nwkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBSvB64A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b533c6865so4728375ad.2
        for <stable@vger.kernel.org>; Mon, 30 Sep 2024 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727705437; x=1728310237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McxIwBdoZS9dYb/FR7HkEedBet4OQUoAX6BYObEL1TA=;
        b=gBSvB64AXVTOykInl7SOFb1gDQUMlA8IxgR1B2Y4UH+OKqpjlsJA8Uodrqw25qiFxs
         4M8tMQ2EGjldIkGd4MDvKWaiSdu8ByFNUne/ORlZVdRqGZihcdD8hheGuUGE8fkyaM32
         CjWb/bXP4E1r+IxXVWAkX+I5QVcviBullKdHWmM/RBLbz7p0Bi9QNJagX5xhRgBkO//A
         GgpZGYZ05mjBpesbsuCWhIp7cZWCrwKzP9SNnKuQVbE3CnLwATSs684f3rDybKu/uHT5
         PHnjfTM97l+c7YO/NBCVjVRfaZDMnlpYDpDge7pEToekRPBIxcS3D4PTgNTjNGbcraIM
         7rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727705437; x=1728310237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McxIwBdoZS9dYb/FR7HkEedBet4OQUoAX6BYObEL1TA=;
        b=j0Wfmq2eXi+lj0IAgbMRN+eTpruxOZjALlqNUUJJf6+och8Q5qotojgVD/xDlnEOiv
         x5ukE8Fw0wPZUr/LzQUp9P34L6kK4GF/un9Bzy2znZDMcdgwKBgUQyhbvLqz+COp+FsY
         49arucHvp/ddA7TVQAJF/Svn28q4jFpO+E6VF4KWrdCUbg6V9o47rJfc+wdw9P4azOB8
         h7H77CyPT9NNwy+All1Wii+B07y4iok2nSCj9Qp2YdKKY/mdgLUYmZPs5i3MvRHlL/3M
         R4r5HWCiEWtyDUDiDV2hZdTbp0ULXZwSo35i81Vdt5hYE103SXRTHm0Ivm5WWGbR/l4O
         +B9A==
X-Forwarded-Encrypted: i=1; AJvYcCUeYuDENzsNpJ922zLE/rL+klu/XOTTWtqutn/HsRVRaREMsRcYx84bEQYdI6pInEpCeYvmCH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXYc9h7tpVNYlFsi4V6gW4gUnuZihp7RyOuli/9khCOPT0O7p
	mhNyP3AfVR8NcSt9C09QvGjAdq99SmIbfmPPfsVOcOf0bCOuplmYAiwx2TaX8OgEAlvcQgRU4SG
	beL9xIUtNOa+FUMrHlmBOkmROtkM=
X-Google-Smtp-Source: AGHT+IEIbyb8yqyN3WBzcbKuJ/1L0jxWZ6Wt/sQH57R8KgxevzbAT9vgrvIc2AdxFXPJm+OXOMwjGq9Gj+gMKcEkGt4=
X-Received: by 2002:a17:903:184:b0:20b:9aa:efca with SMTP id
 d9443c01a7336-20b579009eamr47443435ad.9.1727705437151; Mon, 30 Sep 2024
 07:10:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024081247-until-audacious-6383@gregkh> <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
 <CADnq5_MXBZ_WykSMv-GtHZv60aNzvLFVBOvze09o6da3-4-dTQ@mail.gmail.com>
 <2024081558-filtrate-stuffed-db5b@gregkh> <CADnq5_OFxhxrm-cAfhB8DzdmEcMq_HbkU52vbynqoS1_L0rhzg@mail.gmail.com>
 <2024082439-extending-dramatize-09ca@gregkh> <CADnq5_OeJ7LD0DvXjXmr-dV2ciEhfiEEEZsZn3w1MKnOvL=KUA@mail.gmail.com>
 <2024090447-boozy-judiciary-849b@gregkh>
In-Reply-To: <2024090447-boozy-judiciary-849b@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Sep 2024 10:10:25 -0400
Message-ID: <CADnq5_MZ8s=jcCt_-=D2huPA=X3f5PWNjMhr88xoiKc_JFwQtw@mail.gmail.com>
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending now that rc1 is out.  These should be ignored for stable.

8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on Lin=
k
fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
math_ceil2
295d91cbc700 drm/amd/display: Check for NULL pointer
6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_common_=
modes


Alex

On Wed, Sep 4, 2024 at 1:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Aug 27, 2024 at 10:18:27AM -0400, Alex Deucher wrote:
> > On Sat, Aug 24, 2024 at 1:23=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Fri, Aug 23, 2024 at 05:23:46PM -0400, Alex Deucher wrote:
> > > > On Thu, Aug 15, 2024 at 1:11=E2=80=AFAM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Wed, Aug 14, 2024 at 05:30:08PM -0400, Alex Deucher wrote:
> > > > > > On Wed, Aug 14, 2024 at 4:55=E2=80=AFPM Felix Kuehling <felix.k=
uehling@amd.com> wrote:
> > > > > > >
> > > > > > > On 2024-08-12 11:00, Greg KH wrote:
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > As some of you have noticed, there's a TON of failure messa=
ges being
> > > > > > > > sent out for AMD gpu driver commits that are tagged for sta=
ble
> > > > > > > > backports.  In short, you all are doing something really wr=
ong with how
> > > > > > > > you are tagging these.
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > I got notifications about one KFD patch failing to apply on s=
ix branches
> > > > > > > (6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, tha=
t you
> > > > > > > already applied this patch on two branches back in May. The e=
mails had a
> > > > > > > suspicious looking date in the header (Sep 17, 2001). I wonde=
r if there
> > > > > > > was some date glitch that caused a whole bunch of patches to =
be re-sent
> > > > > > > to stable somehow:
> > > > > >
> > > > > > I think the crux of the problem is that sometimes patches go in=
to
> > > > > > -next with stable tags and they end getting taken into -fixes a=
s well
> > > > > > so after the merge window they end up getting picked up for sta=
ble
> > > > > > again.  Going forward, if they land in -next, I'll cherry-pick =
-x the
> > > > > > changes into -fixes so there is better traceability.
> > > > >
> > > > > Please do so, and also work to not have duplicate commits like th=
is in
> > > > > different branches.  Git can handle merges quite well, please use=
 it.
> > > > >
> > > > > If this shows up again in the next -rc1 merge window without any
> > > > > changes, I'll have to just blackhole all amd drm patches going fo=
rward
> > > > > until you all tell me you have fixed your development process.
> > > >
> > > > Just a heads up, you will see some of these when the 6.12 merge win=
dow
> > > > due to what is currently in -next and the fixes that went into 6.11=
,
> > > > but going forward we have updated our process and it should be bett=
er.
> > >
> > > Can you give me a list of the git ids that I should be ignoring for
> > > 6.12-rc1?  Otherwise again, it's a huge waste of time on my side tryi=
ng
> > > to sift through them and figure out if the rejection is real or not..=
.
> >
> > 8151a6c13111 drm/amd/display: Skip Recompute DSC Params if no Stream on=
 Link
> > fbfb5f034225 drm/amdgpu: fix contiguous handling for IB parsing v2
> > ec0d7abbb0d4 drm/amd/display: Fix Potential Null Dereference
> > 332315885d3c drm/amd/display: Remove ASSERT if significance is zero in
> > math_ceil2
> > 295d91cbc700 drm/amd/display: Check for NULL pointer
> > 6472de66c0aa drm/amd/amdgpu: Fix uninitialized variable warnings
> > 93381e6b6180 drm/amdgpu: fix a possible null pointer dereference
> > 7a38efeee6b5 drm/radeon: fix null pointer dereference in radeon_add_com=
mon_modes
>
> Please resend this after -rc1 is out, so we don't have to hunt for it
> again.
>
> thanks,
>
> greg k-h

