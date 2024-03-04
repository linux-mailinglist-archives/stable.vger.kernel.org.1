Return-Path: <stable+bounces-25871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017ED86FDD7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850D9B21CE7
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5951B819;
	Mon,  4 Mar 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f9Uoq3I9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E4134B7
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709545322; cv=none; b=VlpQNBvSVS+D8fiMxadX4q13pqF4vgT+zwjqo/ymYLoRyBrQ3LywC89am9kcKcUYsIcBFIdZ/+/yAhP9mDmshXcN/feTbkaLjHu/50ImsL0DGKpeB33ZYkYvMPoMJ/ft2atKNWJc6gU67VmbnRrEbRWHgfj95+SOEu1U+M4DY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709545322; c=relaxed/simple;
	bh=YfDq+f0LT4QTrr/NjuUfNIOUqD1DOELWAo0fnLebgkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzPItIQ9vXm4capn9vkV++PqedrRN7s67tg4110KmrkPqadGpzUuCLm72CwzYSs7TnIDk53YeGjKVOg31vn+TFnG2nZ6jI28ynFTaG7pfnaud8No2dETWKYaKopPQanFw1hYaYT5IvJrhhLdau8b3gYBdZTt1JWvMpPdvnQDwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f9Uoq3I9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so51699581fa.1
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 01:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1709545318; x=1710150118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMa9Upq+27VeFRKUIXwGWJMhjDEmPhQavcF4Cruk30U=;
        b=f9Uoq3I90uLCHV0H26qExXSXXknxomrX9g8oCBnqZkFWdPsWagZc17bu6jeCLMYzf4
         QSwhWT1FvdQuAk0ULR54IP32Jo2inWx+5cibPUfiSZYCsHr704xTOkOwBjAifR1RFBHX
         HZWA9lGEOTB1zNFONqQFVzKmM/scAe4g5dAeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709545318; x=1710150118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMa9Upq+27VeFRKUIXwGWJMhjDEmPhQavcF4Cruk30U=;
        b=O9qMS46FaxODXlx/YyTg0bTFaXXB0h9ytY+861AKIovgfQHQMIlkTGNxiBBOFyWGN+
         ippXpmtayKhnNOn/VUGeSMOEr/eNSrBje4xjAShhdZFg8xh67B7uYihvfvpfrIKHgJn/
         CUTBPX4Z0UjbkHIb73MQCPFCAnt4jKLk4kaHUDL58k7TpDWlJieqIoKmsTGUtA8Kcp9v
         NlLBtAALKwocvt+ZhnipX1RkkA+Mcxh3+tDVzOCCYyh+eFkVhofI5WrCxtDR5/QM6t7/
         KYLFHAJdBfQU3wqBds3HlXurtOaRZwh//7BuNzWhvIJ7P1Avw7yyp4sZP/SNMeINMiU/
         8lZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRr5PYSX+igRiX39dLXjd/39hM24wJ3is7/CdUfAUoSkvxLQf5lODKgwi5SNeXYI/nqlIRoAOVmpRmtvX1z9gDqykTnBd1
X-Gm-Message-State: AOJu0Yx9/5QAyKEsfSwABTlTNggLmLLj8DTiQFpfp7r92dq6OquycB4f
	Tk9no+sYKMot+N10K20JcGD8NM8Swm7J5TnKSP7mWUlDLePCnsfHEwrrLzDtNvFnVMNgMXFur1q
	cCBLfksfTUBAyGBjzasR4wcXAMxHiR2PZVBW0
X-Google-Smtp-Source: AGHT+IFK5MqOVSP30v+kDdnCrsm0Af+F8Xspoq77698+haFg5ktVufYeulJKpMCIOnzu0AHQSCAaRAbX7QcFd7XrOVA=
X-Received: by 2002:a05:6512:3a9:b0:512:d5c7:60d9 with SMTP id
 v9-20020a05651203a900b00512d5c760d9mr5036118lfp.3.1709545318629; Mon, 04 Mar
 2024 01:41:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024022817-remedial-agonize-2e34@gregkh> <20240228184123.24643-1-brennan.lamoreaux@broadcom.com>
 <CAD2QZ9YZM=5jDtqA-Ruw9ZcztRPp6W6mZj9tA=UvA5515uYKrQ@mail.gmail.com>
 <2024030407-unshaven-proud-6ac4@gregkh> <CAD2QZ9YPmo3X+q8g+_zHd+=Y=_qKFa+xSgvwfTC3dZ0KhiMyOA@mail.gmail.com>
 <2024030417-linked-obsessed-7c98@gregkh>
In-Reply-To: <2024030417-linked-obsessed-7c98@gregkh>
From: Ajay Kaher <ajay.kaher@broadcom.com>
Date: Mon, 4 Mar 2024 15:11:46 +0530
Message-ID: <CAD2QZ9Ze+Ty8uk8+etw=FDdfUtTUxM4toKnAmh2W1q9WWGskiQ@mail.gmail.com>
Subject: Re: Backport fix for CVE-2023-2176 (8d037973 and 0e158630) to v6.1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>, stable@vger.kernel.org, 
	phaddad@nvidia.com, shiraz.saleem@intel.com, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 2:50=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Mon, Mar 04, 2024 at 02:21:22PM +0530, Ajay Kaher wrote:
> > On Mon, Mar 4, 2024 at 12:14=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Feb 29, 2024 at 02:05:39PM +0530, Ajay Kaher wrote:
> > > > On Thu, Feb 29, 2024 at 12:13=E2=80=AFAM Brennan Lamoreaux
> > > > <brennan.lamoreaux@broadcom.com> wrote:
> > > > >
> > > > > > If you provide a working backport of that commit, we will be gl=
ad to
> > > > > > apply it.  As-is, it does not apply at all, which is why it was=
 never
> > > > > > added to the 6.1.y tree.
> > > > >
> > > > > Oh, apologies for requesting if they don't apply. I'd be happy to=
 submit
> > > > > working backports for these patches, but I am not seeing any issu=
es applying/building
> > > > > the patches on my machine... Both patches in sequence applied dir=
ectly and my
> > > > > local build was successful.
> > > > >
> > > > > This is the workflow I tested:
> > > > >
> > > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/=
linux.git/ linux-6.1.y
> > > > > git checkout FETCH_HEAD
> > > > > git cherry-pick -x 8d037973d48c026224ab285e6a06985ccac6f7bf
> > > > > git cherry-pick -x 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95
> > > > > make allyesconfig
> > > > > make
> > > > >
> > > > > Please let me know if I've made a mistake with the above commands=
, or if these patches aren't applicable
> > > > > for some other reason.
> > > > >
> > > >
> > > > I guess the reason is:
> > > >
> > > > 8d037973d48c026224ab285e6a06985ccac6f7bf doesn't have "Fixes:" and =
is
> > > > not sent to stable@vger.kernel.org.
> > > > And 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95 is to Fix
> > > > 8d037973d48c026224ab285e6a06985ccac6f7bf,
> > > > so no need of 0e158 if 8d03 not backported to that particular branc=
h.
> > >
> > > Ok, so there's nothing to do here, great!  If there is, please let us
> > > know.
> > >
> >
> > In my previous mail, I was guessing why 8d037973d48c commit was not
> > backported to v6.1.
> >
> > However Brennan's concern is:
> >
> > As per CVE-2023-2176, because of improper cleanup local users can
> > crash the system.
> > And this crash was reported in v5.19, refer:
> > https://lore.kernel.org/all/ec81a9d50462d9b9303966176b17b85f7dfbb96a.16=
70749660.git.leonro@nvidia.com/#t
> >
> > However, fix i.e. 8d037973d48c applied to master from v6.3-rc1 and not
> > backported to any stable or LTS.
> > So v6.1 is still vulnarbile, so 8d037973d48c and 0e15863015d9 should
> > be backported to v6.1.
>
> Ah, thanks, sorry for the confusion.  Both now queued up.
>

So quick, thanks.

- Ajay

