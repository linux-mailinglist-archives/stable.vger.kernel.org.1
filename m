Return-Path: <stable+bounces-47945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0478FB914
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 18:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2172874B0
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 16:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18FD1487EA;
	Tue,  4 Jun 2024 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6WzDYrn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3261482F5
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518763; cv=none; b=ajIBrmLHZhymMpu6fxOnL7v3BzcOcW2IF3DvEW13rkWd+2y6rqlytqYCzJuI/aYaiaL4GXvvmTFOz5QMEhvie7nL76yIkt1uShS71GqeKailiXxjOh09oyG37/kEdHbddALeuOBm0wzkxwI9dEKnkCQTnLnoCVBYsj5y68Y8gjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518763; c=relaxed/simple;
	bh=bnV5BtIA/007nHli9MeyJHN89RzoQ1Z5PfZo758g/nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPneXEMfTgcKcKuOEHrVV+wR1Z8I2Ren64Sc8fZyCqwBMSjnB3iIV+yMMlaMBc/JzvjVieeUB4g45aIedQEL63eIZX7YASYQuu+8lv1aCWi3Aq7gi8tCyxiPbPNZPsR22jx5zHlxXKGddOLhwNmGbcTfe8V3CtnQdcYsezg/AYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6WzDYrn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so92a12.0
        for <stable@vger.kernel.org>; Tue, 04 Jun 2024 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717518760; x=1718123560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnV5BtIA/007nHli9MeyJHN89RzoQ1Z5PfZo758g/nY=;
        b=K6WzDYrnmw91Lo3R0BPw1hjLVoKj4vpTQ6O+Y2FsLAJgnsJX0/6V7D77drsbA6OWn+
         LEY437ppjOtTx6b/In9ElDIarSPO76TLnWCkM+DETJpGFNKqyjB4ywC/SY1hsZeod1nU
         sm9R1KcybYe4CMIiuEN1MoxqFBtfg1MQBI10mDhUtJoAe2SudTJLqodltROuzjtcnZ/+
         rRWbajWf+4Ms6MEaVhC6yIGwZ5u9qIR2+/Tglx8K4r59B6wEerTxvpLWLbF1WJBd8Dgw
         cyCX8mbkMd52R+CILnb4Bi0j8fFMRmUdL0G8zTGVLotRbMjafMp96Sd5vYN6Cdyu3+2e
         Mh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518760; x=1718123560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnV5BtIA/007nHli9MeyJHN89RzoQ1Z5PfZo758g/nY=;
        b=LRlwgI2dzD7+EKRYdkUZpN8qeJIFlWeo//tZIHTBlSv96OTd5TVotjufr2QPhKgJAp
         OZyOaPD57hgl7+3maUIg6ifx8axYnu7nNXK15omHwzGPFqELeELM4BA9aB26N3UXNRMi
         KGBrrY20crI0yN5uBVMagT4RcYnSp8m7CtFAo8P5nZ69JbQA+yhTJ3zgLMEe5slLp3xS
         ncICn7DG//YmC3mlDJuv5GqpahaeBu6XrE2pJP0aoT6GuP+8hfSWka1K0M/WSi05F3Ha
         7Wz7yWlA6r8A6wMeJJgR9EpMcRaa1gQ76w1WFmLFGXull3sBl/qDih5WN0VEuQL37TKA
         uwYA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQnTMfMSlKK2Au7XPdboh7qAyBumHBi15hmx0I7gQk8tK+FEti1HK4ink5g6qyMk2qPtl9wioFgiP7DopTNFgKz55xpc7
X-Gm-Message-State: AOJu0YwVMQLjqDRuR/QoY4HYb2YPDwl9iqGpKU1PjSBDwWei/o76YREc
	Qc6kNjGSQMCw0Reju9AhooDdWRHPIesVTyJBSXl3k7E73Q27XsvMDtFvGTDFfS7uUOXmRnZBbLi
	cG2CK14wmxP4MPzxS7M1LfzSxcttCJYldFJQE
X-Google-Smtp-Source: AGHT+IGsbVRVW3Q6Gg7R9KkFLonVbiVTvZ/dtTxhWqQoUAmYqqRCHCVyrpqzgnWhS+fZwfayf3UVRLdI4jRG/HHzi58=
X-Received: by 2002:a05:6402:1297:b0:57a:3103:9372 with SMTP id
 4fb4d7f45d1cf-57a806132eamr163370a12.7.1717518760196; Tue, 04 Jun 2024
 09:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <575be1d3-d364-7719-5cfb-f89bdec66573@applied-asynchrony.com>
 <2024060452-headrest-deny-2a5b@gregkh> <ba29a0e9-8f4c-e209-fb2d-1ef80f97da6d@applied-asynchrony.com>
In-Reply-To: <ba29a0e9-8f4c-e209-fb2d-1ef80f97da6d@applied-asynchrony.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 4 Jun 2024 18:32:24 +0200
Message-ID: <CANn89iKN3i6m4h=UUmQbRNSocNY61bb7OaS-tdTnnmWuaPot1w@mail.gmail.com>
Subject: Re: Please queue up f4dca95fc0f6 for 6.9 et.al.
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 6:26=E2=80=AFPM Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 2024-06-04 17:44, Greg KH wrote:
> > On Tue, Jun 04, 2024 at 04:56:24PM +0200, Holger Hoffst=C3=A4tte wrote:
> >>
> >> Just ${Subject} since it's a fix for a potential security footgun/DOS,=
 whereever
> >> commit 378979e94e95 ("tcp: remove 64 KByte limit for initial tp->rcv_w=
nd value")
> >> has been queued up.
> >
> > Only applies to 6.9.y, have backports for older kernels?
>
> No, sorry - I'm just the messenger here and moved everything to 6.9 alrea=
dy.
> Cc'ing Jakub and Eric.
>
> My understanding is that the previous commit was a performance enhancemen=
t,
> so if this turns out to be too difficult then maybe 378979e94e95 ("tcp: r=
emove
> 64 KByte limit for initial tp->rcv_wnd value") should just not be merged =
either.
> I have both patches on 6.9 but really cannot say whether they should go t=
o
> older releases.
>

Sorry I am missing the prior emails, 378979e94e95 does not seem
security related to me,
only one small TCP change.

What is the problem ?

