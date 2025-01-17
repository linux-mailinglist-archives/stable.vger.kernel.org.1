Return-Path: <stable+bounces-109323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EB8A14841
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 03:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45D7188D52B
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 02:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDEB1F5619;
	Fri, 17 Jan 2025 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLOnwJzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067963BBD8;
	Fri, 17 Jan 2025 02:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737080977; cv=none; b=bhYuL2QDMaxw69s27WSYsmCr+l8z7t4lobPHhi61YUS6299IPj/5ZPYgT3TVYXOo7KNK4Ht+Ge9x14gAOLKQoMXwD3nAFyNchtIBP8vI0LMBdHxMi7XHhFk4mdeIF8moGUQU/Yx6BKifui6QBWUgtRBJPVASZm1UX2eYskybxz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737080977; c=relaxed/simple;
	bh=6tM/pA/kSrQZtfqCEKOc6GHC0c3Kas659XJ2JGMGAjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edS5IszxjkZICMIwcgecT4us44aqxv9zznRVhhR/fXYyQTyLoVvyamXOrYKmCLsrKPNGqVb25JorJRqbol5vfCysMicO2G5M4/lTcxw8R3LQRY1ARQ3G4UvHavUJ4u4ZHz2SNWvpRUZcA5UFB90wQm6q+ibo+Ndal8l/I/Od74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLOnwJzo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5da12190e75so3264613a12.1;
        Thu, 16 Jan 2025 18:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737080974; x=1737685774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6tM/pA/kSrQZtfqCEKOc6GHC0c3Kas659XJ2JGMGAjw=;
        b=CLOnwJzoEZHAzCzntamdtE+HubloreQRLz7R1LlG+6bhV8I1gGhC3dgtLfaLwAg7dB
         rW81k1nYiHVLxbxLIra1DWyWkbPV5XD4co/0Ojzt+6GwSqQAmGU9xE8289ghtvTgljFD
         IcNZS9RToAGTFGDGjmMSrpgpfc8oIPJmJDuy8HQj8FPt2+rEE+GLV1BadJ87Kp5UAhYz
         ShNBp15qTIfI3xpZKShKpCjwt1EMYL3AeA/zdRDAkc3EO7uaglbIzxXLlgA1rE0ejcWC
         ZpMTYeNmRSWFkKWNji3ItUAH1zW7qG4L3qYq7IUje/XcZl5asCC8IsYmOIKPeXTHpEDl
         Cnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737080974; x=1737685774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tM/pA/kSrQZtfqCEKOc6GHC0c3Kas659XJ2JGMGAjw=;
        b=Ly/b7HXMAIk+ViNNQXmtkcaEXJW8mJjsJ8jChAg197E2TwUZyCPT2ummrBvLMnfRXL
         /dadUp1zhwxOygUe2xZq4fItk+CYF/E+JnY0a0JTxbADpBKhvFxNduKbFhTMGQBD/eo/
         dv7VhkUAo5jDMJA1OKhg+IXwXJ1FwV7KSl68TTKxb2lXLTg5R4y438YzT41RqSsXECuP
         O50hoLkdviUuUPqUHBOuWwCYQnEjYOEVdDniOwq699UXkaTOEte7A6QGUnd4QBFQKbt4
         rap1tlpnuBdGQA4kKFKRf0SZUDFVx6dQ9N0vXKXIzZB22gmUMVp3zLzd4Yd3iFF4Z+qN
         39/w==
X-Forwarded-Encrypted: i=1; AJvYcCUPkh/ui2iEflGAjsg47mNy/ot0DCVX/eMok5ztaO5a6m72I1bq3tEv+hhJpvyr/iheRqj2/ws0@vger.kernel.org, AJvYcCWbmZ+uZmnTKBZ900pnARVdhtatuc1phZS+lENYbOG4vxEV8RKhlUuhFJZsycD9KXzZu3HFmHKM@vger.kernel.org, AJvYcCX3U4co4BxexwbUdzaFfQuEOf7ZTG1DqLkLQP1bDpC4qwMT+k+wrpZfUbjajZrnaoT0fSbDYMTnweAl8Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHc0CyqNiz3Hs8A5D3PT2DKzU3l0we2DJ7OD6bP355yKRczK1
	694KCvI/uDFQ+tGaHco0yDKV9V5/tH92XBiftCCjxeiSzg/dquvbU9tnxo8nrRQ/vAPyV4cVRId
	y9DfAmCElw95VyEFvyajTQXHwle3z9Z/GtWQNSNae
X-Gm-Gg: ASbGncuiYQ71e7YB89Rra3ZhpTQtUTR5+aE7zwvafXmCZrYzZAtbe34b59QVgg/HXXx
	ZpwYNKBnqWYfQSTxaYV2KS1CUGnpvWqLjfeNhtHs=
X-Google-Smtp-Source: AGHT+IG+Bo3MdLVOmK4kOzKUNFSJxSfdGBauz3+fQSZveHFAP6uD5cRbtdoWAN2mrN7dGT9hnf4+xpK2UesLUnk9yfo=
X-Received: by 2002:a05:6402:2696:b0:5d1:2377:5b07 with SMTP id
 4fb4d7f45d1cf-5db7d2e54b9mr832244a12.6.1737080974184; Thu, 16 Jan 2025
 18:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115131006.364530-1-2045gemini@gmail.com> <20250116165914.35f72b1a@kernel.org>
In-Reply-To: <20250116165914.35f72b1a@kernel.org>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Fri, 17 Jan 2025 10:28:59 +0800
X-Gm-Features: AbW1kva3ZdQWLlhhvIkVs0HMAl-5SWQbUKV2HjOurnuULPpRUakAuycXaeGHHtk
Message-ID: <CAOPYjvaVZAHqWhzYsLjtc4Q8CSCF2g4bG-efLHPOP_NMSs0crg@mail.gmail.com>
Subject: Re: [PATCH] atm/fore200e: Fix possible data race in fore200e_open()
To: Jakub Kicinski <kuba@kernel.org>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Wed, 15 Jan 2025 13:10:06 +0000 Gui-Dong Han wrote:
> > Protect access to fore200e->available_cell_rate with rate_mtx lock to
> > prevent potential data race.
> >
> > The field fore200e.available_cell_rate is generally protected by the lock
> > fore200e.rate_mtx when accessed. In all other read and write cases, this
> > field is consistently protected by the lock, except for this case and
> > during initialization.
>
> That's not sufficient in terms of analysis.
>
> You need to be able to articulate what can go wrong.

fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
In this case, since the update depends on a prior read, a data race
could lead to a wrong fore200e.available_cell_rate value.

Regards,
Han

