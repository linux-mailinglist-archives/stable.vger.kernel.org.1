Return-Path: <stable+bounces-76119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BAC978BD7
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 01:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BF2285727
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE517BECD;
	Fri, 13 Sep 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifYGJIt8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5ABA2D
	for <stable@vger.kernel.org>; Fri, 13 Sep 2024 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269915; cv=none; b=YpKTfanI/T+nfQDKu7mCx4qtA5awxpwtwFcMtJk8eypWLXRYk7OGqqfDBFykJtI/mN06sDBNDoW25ZIIfq6JttpuFQVYJb69T4mcmAQa2ayH0cE2QdcItWmEtqD24NVSSmTpdH062jHME2Isv2TDOya1HOD7VcDvJkK4InGcrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269915; c=relaxed/simple;
	bh=YhDdGu4hZiGlx+q+XBnCOedph29DSV5sGtHeIamXfXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fyxu344ePJay8tGLaY4qrE/OA4cfcm4ONsMeCFNfxHg9dFXJNAKVeJPCuG8/bbG+3gbC+vA5/1b4qVtjkvHVvar0AlyYX8mXthHnTgZ1vq+/R6tpdzmu65zHD70cgFRoTu7OAL/5//gpzaeUgoNGu5l+dZ4n8Im1brEJBs4QQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifYGJIt8; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c355155f8eso11640396d6.0
        for <stable@vger.kernel.org>; Fri, 13 Sep 2024 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726269913; x=1726874713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1upeTCfWWdmhQBb3MjHQmjSH67h27z34eMn0HTUO29I=;
        b=ifYGJIt8rMJe6N1neShOnbqb7mDtAOecOH9pOE5y0gziT+jPc+/Ct1h+h7Tfgt8zI9
         qAD4s+e/d3PQHGc6eWngLkzzaqDhCza9Ah4O3X/AYlc6YnbW0K1EpYShiLs3kQ4LiLm0
         9U3AUAjqPW1fCiKV/i/JFXjrt4iBe/Yyqs/CH8ceZRUwcpu5racJ95PZ7AHeAUvxbGGu
         mwSIhtDpJ6f7/BrfK8I3vbTmcEsJtl3suYMy6Rj4hrx7nCgQuSdA8rMK7puN0w572jg8
         sZZHp8sO+3Yj5nQ3vfQrLju7nKdYG3Ef3Es7QhIexFYkArA+F0QlsITqQvZfxxO3V0Nx
         La2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269913; x=1726874713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1upeTCfWWdmhQBb3MjHQmjSH67h27z34eMn0HTUO29I=;
        b=QCLcwCvib5fwj8xMPxd09Z5/nXLNmVbkUYvjKlY9p6p50utWS/LJvEjTTiMfRs1Wic
         mz3+jQlp4g1e7w8umHITXgVdIIi9mVcYuZFEpnabQPibIQqq05AVSQysTMzYQVtbRyqi
         /h+PNFbqTQNV4iSgqmJpuxHGKVf6vQaLRR2PNu0ylxF56QzakWAz22C+N91ADhkcg9Vu
         8glVEhcaLz468OOw3pNBOmuSXSy34ui9ZJPGWnWdO9qxYDr2qqgGR9M8CRToyoaE8BFO
         ll1r8OoUZQ9E1ZC9KKjjInnJMxPraOiCp1cD5ObraG8/wazIXIEVPL+qkIspdSQQVnuI
         mymg==
X-Forwarded-Encrypted: i=1; AJvYcCUKwTHg59mYElG/cUtrMEYaG6J/A4KrINUY9z4C0kSXiQzq/nU6qYXZkHErutfW+mHRUoc+l7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrydHF5r1YI7iFReRSf/9lGLgmOOyPN3HunYbrFJy5HRvuTu0
	BAeva9OHsKpBOnIqDR6uHj0KGtLaXi1IrUP8BKRLxc8VhjG1bXyHXKjr0qHhCoBo9sumyKCBaff
	HkoAhrIggAKE2zXjIsi89gR7vgeq2r1Tbeo0I
X-Google-Smtp-Source: AGHT+IFqtIPpQJsc7jyZAn718b4uKPn4dZBFMgeJxtohg1PFwMBWzsu9Up8tGLWlLeZprh/19Ar11aLSbpd88jMMo6w=
X-Received: by 2002:a05:6214:5bca:b0:6c3:64b6:3e29 with SMTP id
 6a1803df08f44-6c57e0b5f9cmr65012116d6.30.1726269912814; Fri, 13 Sep 2024
 16:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906005803.1824339-1-royluo@google.com> <20240907005829.ldaspnspaegq5m4t@synopsys.com>
 <CA+zupgxMefawABGDkpRy9XmWJ5S50H1U9AF9V3UqX2b5G3pj-Q@mail.gmail.com> <20240913181251.3upf6zme2j2mobv3@synopsys.com>
In-Reply-To: <20240913181251.3upf6zme2j2mobv3@synopsys.com>
From: Roy Luo <royluo@google.com>
Date: Fri, 13 Sep 2024 16:24:36 -0700
Message-ID: <CA+zupgzyK8hL3=b-P5uA+bhuhZUVDva26a7fo-JdTmPqRVgDnA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: dwc3: re-enable runtime PM after failed resume
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "badhri@google.com" <badhri@google.com>, 
	"frank.wang@rock-chips.com" <frank.wang@rock-chips.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:12=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsy=
s.com> wrote:
>
> Can you include this info in the commit message?
>
> And while at it, can you also update minor style change to remove the
> brackets for single line if statement to this:
>
>         ret =3D dwc3_resume_common(dwc, PMSG_RESUME);
>         if (ret)
>                 pm_runtime_set_suspended(dev);
>

Sure, sent out v2 for review.

Regards,
Roy Luo

