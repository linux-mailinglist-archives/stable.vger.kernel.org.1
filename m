Return-Path: <stable+bounces-171945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A460B2ED21
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 06:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7A7AB61EA4
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 04:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BA1C4A10;
	Thu, 21 Aug 2025 04:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzZ/wn/P"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EBA45BE3
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755751423; cv=none; b=Z6s0Da/remSeolrcErPt8EyLpz7VQftnQqyIG82HLJboavwWvECcZq2aNVwMON7IEyHsYCkcijzRDZf31V6roabcb3lXIURPkxu8AGQZkrJqvTCos1H0Eerln7KIyDEI+WlLF/lWJtKsTLW+7vbx+8XdQ37bLakv0RJPNdERHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755751423; c=relaxed/simple;
	bh=xTIj6V7ezcR4MueDpk20MMc3TrV9FrQYrRp10XWNvZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4obGCx6pVCUaw8IsDs09xumItNwZsVlmRfICGH8/s5xJ4O0yzlahIoNFpntJYLi1dBvES/yK82RiP74jZtB5FBpR7OVOSIpTBPM2/u3gxAygYEAkSIM0zh3Qt5mGOUvch9jNt/iFTlGzKrBIkiQFHZ4PrPwzXjR5G5LykSE7Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzZ/wn/P; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61d99c87ddcso130635eaf.2
        for <stable@vger.kernel.org>; Wed, 20 Aug 2025 21:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755751421; x=1756356221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWvhKp65AxyP1xwVvIS8MuCmDuU/KsXcWzjgpycsbII=;
        b=DzZ/wn/PZHId8J31eQnvK07iGPpjzNAyyXahW7nhbHPNzH7etGcNgmVxdlWpTv6k8C
         j58CFtazwk5Thg7+zG6NLLK8K3wZPNFjbxhFroekJ+is5PVac1E2YHnXh76URtEUAlqJ
         X3BwSum8pNGR1hp2wxmKhf/vzYzV/SBW3cEY4XeuiwsGuBaW8zz6NfTH8g+8nFbv7YpL
         PtUSrYoC/HlbRRNCmBleq74/NFb1v7cYqWwqQkbTVPHSqsmZrYLW9WhZED50R31Hagcx
         hs5j2Xlosz2zpi5mtvB1r4u1a/vD0YRbe/Bqb6gPTFO4SY9ov1XwTN1fHMVG6s6UqmS9
         pmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755751421; x=1756356221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWvhKp65AxyP1xwVvIS8MuCmDuU/KsXcWzjgpycsbII=;
        b=fswfcsTucFBd8qFUfdRGA+mQ2/e+Ts2drTaLK332Ma+oh9/vArIzPzNlgSxgT5yVf7
         EungKhO73Hlnp/pCFfBMHXo3sRCpoUMf4Qjdj9yIKAs6r9gkCQ/iSY7hWX2LH5Dz5Frz
         U+li3l1cCCL78i9FLlKXy0b1aErACRNL0jTXtTypCHFxpXYI3EV5P+rNPuaRYasFahNm
         +gg8auiRuhy0CDUVSFzhMXxcbvcUCtQKhdkyAl/hhS9jc6u04VLcfkQAfFX8FCkS8JNh
         +fPW9flgN5GsDDE9ZKL+cIzdJJoLJf0aemBfvx/tm1puHKTkhCPyETzHuSLKYJB/syhb
         ki2w==
X-Forwarded-Encrypted: i=1; AJvYcCWxQYBlpnOpEvamNlD3tmk7Us52IIdzQfYE0WOl3f5Hf9RF6bQ0wIcyFsnQ4tnsTHl/ObL7c5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdn5ABUgoiaG/pS+FcWqlrQCBT6rIcCgjNfonQwSONAzb5n12B
	WamBwVScJdHutp3L+41HUc0s0eNKA6FJNAPCphuG7hM0M73ZPcn7TRTEzoLViEUFojuWDfYuIkl
	97xcHkSrR1eR9NGUQUY576FUJGBiPxEI=
X-Gm-Gg: ASbGncuxBtg8E1C0RBxnfvv7YgChwxvLCD3tyLGvHyaYUt46JGvdor23rzDkCjzRWU0
	ZpNAy/6j9R8LsvdZGRJeqj2HPdyG/ZQ7SqUwS2qU6t9urSUn6CQCbii1GewnNayVZ0uTpMEsEmr
	De9KFNikoUXVBP0iHD5QND0yPaYhsoKAzwPKGHI2UL5bhyX2kDlWotmHuAa+bML+pKGsjR8l56e
	9fR
X-Google-Smtp-Source: AGHT+IGjprBbj/E2Wm4laG+alOgDHLSfMegvi1WsGOjDb1e3hjmUvLF5JnP1I0EZQkV5dEYbsLY1up+jOJ8PGChnNH4=
X-Received: by 2002:a05:6820:1b87:b0:61d:9adf:eecc with SMTP id
 006d021491bc7-61dab25dee0mr434089eaf.2.1755751420981; Wed, 20 Aug 2025
 21:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABFDxMGmVgswVoZFgBz=7xqA59M7fMt0jw2QHqWjm-W9tZktWg@mail.gmail.com>
 <20250821025423.90825-1-sj@kernel.org> <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
In-Reply-To: <CABFDxME5ZEAn+6=0GRWybTi-xBzbhhz7U38pMni3SdKjA+Aj-A@mail.gmail.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 21 Aug 2025 13:43:29 +0900
X-Gm-Features: Ac12FXxIn6O74TtxGWb4mmUw96J7yYYLAjMBUSDDJprJWR81IQ6dIXiEhH5f3OA
Message-ID: <CABFDxMEYXpQRS0fMdE-qoVMHym2Cp+2Uh+pXwB5h0MdvWGdiew@mail.gmail.com>
Subject: Re: [PATCH v2] mm/damon/core: set quota->charged_from to jiffies at
 first charge window
To: SeongJae Park <sj@kernel.org>
Cc: honggyu.kim@sk.com, damon@lists.linux.dev, linux-mm@kvack.org, 
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Restore missing CC) + Andrew

On Thu, Aug 21, 2025 at 1:29=E2=80=AFPM Sang-Heon Jeon <ekffu200098@gmail.c=
om> wrote:
>
> On Thu, Aug 21, 2025 at 11:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wr=
ote:
> >
> > On Thu, 21 Aug 2025 10:08:03 +0900 Sang-Heon Jeon <ekffu200098@gmail.co=
m> wrote:
> >
> > > On Thu, Aug 21, 2025 at 3:27=E2=80=AFAM SeongJae Park <sj@kernel.org>=
 wrote:
> > > >
> > > > On Wed, 20 Aug 2025 22:18:53 +0900 Sang-Heon Jeon <ekffu200098@gmai=
l.com> wrote:
> > > >
> > > > > Hello, SeongJae
> > > > >
> > > > > On Wed, Aug 20, 2025 at 2:27=E2=80=AFAM SeongJae Park <sj@kernel.=
org> wrote:
> > > > > >
> > > > > > On Wed, 20 Aug 2025 00:01:23 +0900 Sang-Heon Jeon <ekffu200098@=
gmail.com> wrote:
> > [...]
> > > I think that I checked about user impact already but it should be
> > > insufficient. As you said, I should discuss it first. Anyway, the
> > > whole thing is my mistake. I'm really so sorry.
> >
> > Everyone makes mistakes.  You don't need to apologize.
> >
> > >
> > > So, Would it be better to send an RFC patch even now, instead of
> > > asking on this email thread? (I'll make next v3 patch with RFC tag,
> > > it's not question of v3 direction and just about remained question on
> > > this email thread)
> >
> > If you unsure something and there is no reason to send a patch without =
a
> > discussion for the point, please discuss first.  To be honest I don't
> > understand the above question at all.
>
> Ah, I just mean that I need to make a new RFC patch instead of
> replying to this email thread. I'll just keep asking about previous
> comments on this email thread.
>
> > >
> > > > >
> > > > > In the logic before this patch is applied, I think
> > > > > time_after_eq(jiffies, ...) should only evaluate to false when th=
e MSB
> > > > > of jiffies is 1 and charged_from is 0. because if charging has
> > > > > occurred, it changes charge_from to jiffies at that time.
> > > >
> > > > It is not the only case that time_after_eq() can be evaluated to fa=
lse.  Maybe
> > > > you're saying only about the just-after-boot running case?  If so, =
please
> > > > clarify.  You and I know the context, but others may not.  I hope t=
he commit
> > > > message be nicer for them.
> > >
> > > I think it is not just-after-boot running case also whole and only
> > > case, because charging changes charged_from to jiffies. if it is not
> > > the only case, could you please describe the specific case?
> >
> > I don't understand the first sentence.  But...
> >
> > I mean, time_after_eq() can return false for many cases including just =
when the
> > time is before.  Suppose a case that the first and the second arguments=
 are,
> > say, 5000 and 7000.
>
> I think my previous explanation is not enough. I just want to say,
> time_after_eq return false, but user expected true case; And I think
> that's the point we want to fix.
>
> Maybe I can change my previous question like this, "Is there any
> situation, that charged_from has been updated before and even though
> reset_interval has passed but time_after_equal() returns false".
>
> I asked this question because I think that kind of situation can't
> exist and minimum version of Fixes patch(5.16) uses esz in the same
> way as it is now. So I think that we shouldn't use "stop working" in
> the commit message.
>
> As I was writing this, I thought about your comments deeply again.
> Since you describe the current state of esz as a bug, I think you
> might want to write "stop working" to comments, because I think you're
> thinking that some fixes patch could change esz initialized value
> (also reasonable, I agree)
>
> I think adding an explanation of the above knowledge is good to help
> newcomers to understand DAMON well. Also, Could you please check the
> above question for a more detailed commit message?
>
> > >
> > > > > Therefore,
> > > > > esz should also be zero because it is initialized with charged_fr=
om.
> > > > > So I think the real user impact is that "quota is not applied", r=
ather
> > > > > than "stops working". If my understanding is wrong, please let me=
 know
> > > > > what point is wrong.
> > > >
> > > > Thank you for clarifying your view.  The code is behaving in the wa=
y you
> > > > described above.  It is because damon_set_effective_quota(), which =
sets the
> > > > esz, is called only when the time_after_eq() call returns true.
> > > >
> > > > However, this is a bug rather than an intended behavior.  The curre=
nt behavior
> > > > is making the first charging window just be wasted without doing no=
thing.
> > > >
> > > > Probably the bug was introduced by the commit that introduced esz.
> > >
> > > Thanks for your explanation. I'll try to cover this point in the next
> > > patch as well.
> >
> > If you gonna send a patch for fixing this bug, make it as a separate on=
e,
> > please.
>
> I didn't mean newer code changes, just commit messge. As you said code
> change should be created with another patch, if it has another
> intension; Also, i didn't have any plan yet. I'm trying to resolve
> this patch first
>
> > [...]
> > > > So what I'm saying is that I tink this patch's commit message can b=
e more nice
> > > > to readers.
> > >
> > > You're right. I'll try to make the commit message more clear. I'm
> > > really sorry for bothering you.
> >
> > Again, you don't need to apologize.
>
> Maybe, I just want to express my gratitude :)
>
> >
> > Thanks,
> > SJ
> >
> > [...]
>
> Best Regards
> Sang-Heon Jeon

