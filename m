Return-Path: <stable+bounces-110096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18346A18A36
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 03:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9B169907
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 02:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2676C13A3F2;
	Wed, 22 Jan 2025 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjEo0mRd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D8158D80;
	Wed, 22 Jan 2025 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514159; cv=none; b=A7SRCU2fOikWBni1mrxE0HfwmVRS4EiZgsndl/4L9QjNLWJqLBXhs1/x1t/p0hA2K43I26ryvAcNOGRwdG91AO2DXs+GOPusCTc3jX7iDwSIBEGgzBRUfmFV0Y3hC2DC766y72k9seCOaBeGBU4UU4wQbWErwzTqytmI54kowWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514159; c=relaxed/simple;
	bh=fe/SR2Um8oKKaazVW/si82zLQewzrYk1RfUJXEmBAng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWkxKdkXxlo6pKXJAMUjUbhfDRUL7Hb3+dkGJavFXFqUgNGzGBKWH/SSpf3rL5mZ6vI/U+KabIO61nAzPGIsivziMkhfthFJ+tbly4awEQuaRfKlRf5kc0UUSD9sY4vCNI/c6DirmQUqUabvjhDRGi2Lm1CN+jOSABXI5Ds01Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjEo0mRd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so10166446a12.3;
        Tue, 21 Jan 2025 18:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737514156; x=1738118956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fe/SR2Um8oKKaazVW/si82zLQewzrYk1RfUJXEmBAng=;
        b=QjEo0mRdBoNRo1TL47crqhkOa740vlWew3oPkLc+KV4wyoljC9GAPr38QitqEaQF7j
         oBpoLmrQNmpwEax5M03bbJoF0Dz4FRcCB5MEvDoQmybsciVVJOM9jaGBuBe9+gDYac/C
         lD0amt9V7y07XMT4BF3ULyd7wIOLILkwLn0vbkzdiYQsymQ9V0jpSq9QKfhACsuccKaX
         qDt0dYo03IYNH8nPQRm5+Tv7QZkQ0NjN3lpy8b4/57Zd8fjMzf/f0st1BMNh2Qs0leK/
         r7wKhHSAjz5S7qOu/PzhItG+3HfqyLJMdYtj+J4Pk5rUzwDZ/VoND8MzycqcByJCZrGW
         PosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737514156; x=1738118956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe/SR2Um8oKKaazVW/si82zLQewzrYk1RfUJXEmBAng=;
        b=KHsrc7bTxGXA6/hMHaEmJTkwCy8YSHYOjW9BvrEo5CfYli62a4XkG49Uafqg7SJ91f
         oioi1PKlW1gPtl6MZx2DDzCUNM/dP/vDKBZ4hGs/1ibywj50S7Q2Nu98xJM3nUAAoPdf
         hcFyK/SKVyxUHisJyXgUJ+TPVp2pNtx7OljSHJ4T/5DuiV0VMY8A7TqxQ0j9Qspy3fR8
         nPgwcEuBzxaBR6FuMef911c8R9c/2mBZovS/GbLCBfhyihZ0wAiaFygCErdtS0PNa8Uc
         qfCnXFqi+zYVixoqmhiFR/g/KyvCYgkwhcFhUfKLU9Elh8t3HB4aN4fGabl3xGm9BlsW
         BcMg==
X-Forwarded-Encrypted: i=1; AJvYcCUA6E82ZlMa74sfADNKXNwOm9rC1RTvKUaAJGKZjQGJdIPjUTmrM7OcPswAogxcMITRelJkBE8q@vger.kernel.org, AJvYcCUeJcujjHTtAn2rstGHs8i+NWqBPDkIqUM6M0Xwsz5jiAgxDsd+ftFeB1cG3pTt8qWCbLqqqc8Y@vger.kernel.org, AJvYcCXxFJzXWiSqi0MyT8/d2MC7dzt1E0a+Wo2G8uY6pZNXHzZCNnjGRWQdVal2lj/Uft5sn2IdPzLEFoLJ3uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknalLUaMP+9p0idfCf/Se2vgJEu/MqHpv8+1rg2DmuDx/JbGF
	LqBgen6JC8M34n8BLm/V5WL4vHviQRWE3hf5j6u7F3b2o3+h2nxZa4XqzJpwIZwUF2cybmHj3ES
	KrwWheUDcEuOMWIm2Tpt6mVV1kI61f7SlURL4mu/b
X-Gm-Gg: ASbGncuL/EplN4fDHRnrcbuFjiJW5jq/oQWuWaa4VKQ7NsEnlRu3Mmvl+2kox9BplZc
	v4y6wyPVPEuG+XswXkZdKwJpDG8PwknlQgx5KzogESmBqqbd+Tzo=
X-Google-Smtp-Source: AGHT+IHKgS6ptYNAF3b8MTfFPMFP743Cr6V2t/3al8b9d+/yuT4LhnCQ8doLARwsza8YeKAv/CuHgKKz3eLz/WUIJPw=
X-Received: by 2002:a05:6402:4406:b0:5d9:84ee:ff31 with SMTP id
 4fb4d7f45d1cf-5db7d2dc6d2mr42776113a12.3.1737514156278; Tue, 21 Jan 2025
 18:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115131006.364530-1-2045gemini@gmail.com> <20250116165914.35f72b1a@kernel.org>
 <CAOPYjvaVZAHqWhzYsLjtc4Q8CSCF2g4bG-efLHPOP_NMSs0crg@mail.gmail.com> <20250120105555.GV6206@kernel.org>
In-Reply-To: <20250120105555.GV6206@kernel.org>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Wed, 22 Jan 2025 10:48:39 +0800
X-Gm-Features: AbW1kvbgpuMTJznGEliWxvijTtjHQRSj84HS80MZzcTZGh7hA0qbhUY0AUXVLL4
Message-ID: <CAOPYjvbu5bZsKYN8XtTE1a0yXX+dyvy6p0FUVAzXiKnbpYtYzw@mail.gmail.com>
Subject: Re: [PATCH] atm/fore200e: Fix possible data race in fore200e_open()
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, 3chas3@gmail.com, 
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Fri, Jan 17, 2025 at 10:28:59AM +0800, Gui-Dong Han wrote:
> > > On Wed, 15 Jan 2025 13:10:06 +0000 Gui-Dong Han wrote:
> > > > Protect access to fore200e->available_cell_rate with rate_mtx lock to
> > > > prevent potential data race.
> > > >
> > > > The field fore200e.available_cell_rate is generally protected by the lock
> > > > fore200e.rate_mtx when accessed. In all other read and write cases, this
> > > > field is consistently protected by the lock, except for this case and
> > > > during initialization.
> > >
> > > That's not sufficient in terms of analysis.
> > >
> > > You need to be able to articulate what can go wrong.
> >
> > fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
> > In this case, since the update depends on a prior read, a data race
> > could lead to a wrong fore200e.available_cell_rate value.
>
> Hi Gui-Dong Han,
>
> I think it would be good to post a v2 of this patch with
> an explanation along the lines of the above included in
> the patch description.

Hi Simon Horman,

Thank you for your feedback. I have submitted a v2 version of the
patch with an added description of the data race hazard, as suggested.

