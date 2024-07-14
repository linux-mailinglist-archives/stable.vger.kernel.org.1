Return-Path: <stable+bounces-59247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA3930A6A
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202851C20C22
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A5F79EF;
	Sun, 14 Jul 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG8RzUlD"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8EB7F;
	Sun, 14 Jul 2024 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720968328; cv=none; b=IbJjm+LC+Lo7lY3Mj5yyW8mo8Z/mCTxuWIZm+WaRyEh8r14EYWxVpyrsLwtykyLyzL2s9/EKcoI8mWdxhaf0VMg/qI6CtoDmNiMW0uzHsDx6rKU7FwZ1bfWg04prkj2oFfwf0ya17wL80IPmYTa3vC715AidU2IhTaLLqzsYRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720968328; c=relaxed/simple;
	bh=eTw8I67Ua3yUafmHKKKWhTlCUCO8Cg6SzvM3mwFcJWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfXfYDPKxqBHNfcAdxCk3NsdD8Hp3H1wkQZKwUBZ6SjCo1JMpDjtLmK6/s0eGJaChSMTmApk259RshZy6InjauVWPY6ebbRjjgGD+mBapzcTXjsNGFuY7Vddo5XoCmj5ala9d5jU+n0GJ37r24KfQQeMzlH03Tp6ZL0OF7WzCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG8RzUlD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee91d9cb71so36327251fa.0;
        Sun, 14 Jul 2024 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720968324; x=1721573124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfoLUS71vnmBVP7Ktm+DIvCGvfeHCWbWiiz7kQUxoVo=;
        b=ZG8RzUlDsa8u4qMjH3lzhkgKjXcRVOyEsp8bRyzdcNpaHHzix+4N54aMjC8ZIRMlam
         zdTPKj9FgWbzRwqSEl3q0mG8+s669tUwvQiSeL4BA7AFsMn8jnC/3e2hPMatkEgZWCbL
         qAYxj1sH9IewpBHHtF2UOGJsA7CA4bCn7v+spVQ6CNeaAYhJCDcBV3AUAahKdBmEQ/VY
         hoFqsr/UkYPF5Jg566S1d0M+UDn/Lwq1+YkdAOBfwCX4U1iam5q1RcRld1nNQk1us5Yp
         ceUDaRR6mHrT970BZVQ4/Vup9WxoDanVSR65l79fjmf5MZiGBgTq/gQUvZ5OwULBtyNk
         CY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720968324; x=1721573124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfoLUS71vnmBVP7Ktm+DIvCGvfeHCWbWiiz7kQUxoVo=;
        b=vr97XQluBGrqRcKq3T/NfJtLsvD9zjGthkTXfHdXIyqp98VsD2pCVqW6XSESeBkop7
         i1RLHlVe2evtcL36SqugPnpDBTqGBe67PD4sPKVc9tEvf/HQd35vpXC3cQbgJCtBnSwU
         YdFtx9YjRnMltNL3gsW2lq4+d9dHXv5C9glwSuw19GFFSMBd2pkco1DSeSMw28bcOGIP
         fXLONdDr7nIbiE7kDIo3y+FDycR73OIC1VLuFS20JTpddB4PXBmzhndskvUU3rI6yeU8
         OEOZ+ga54nNYiOTpvL13Omy/SNDTABs8STZ4RMUHFg5Zx3rv/eiP/MwtINpvC2B4t5f8
         klkg==
X-Forwarded-Encrypted: i=1; AJvYcCWAAf8nwKEz2y0nKfegPQpgs5+lc9s/UmQQN+n8VX2BGA6eZOQRJmcjRtGfO0gRqY1UCYEX8oyZnETNiafC7/IJn3Dcsb1+s1cBFPCt7WA0GTE9h/AfuKfspkpcj43p6d4SX5uMvk1piPnYq6Qh21pxchoO/TswCXw308RABxu3
X-Gm-Message-State: AOJu0Yz+lqzStKjfkwwZbg/XUycvwW3GIti/aU1aDEzjDR9tRrQ16trX
	bDYyDaPp9eBBybFwb9L5Iw/wodZQJ4Pga48uFqtyfEjIC/oJghDUcI090gwdq8jFiOTSALA6BPo
	4Iw7XaugV7vXHYims8V9WxKgQmGY=
X-Google-Smtp-Source: AGHT+IESBT7QZuo3mzHJ8MJwVzwOBYsNWEYhAGUxWxrPobNrqv3tPGJnEZdVOOX3BWN8XkoiT4ndMF6LZEoROJongP8=
X-Received: by 2002:a05:651c:210c:b0:2eb:f31e:9e7b with SMTP id
 38308e7fff4ca-2eeb30e5129mr129887491fa.14.1720968324234; Sun, 14 Jul 2024
 07:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+3zgmvct7BWib9A7O1ykUf=0nZpdbdpXBdPWOCqfPuyCT3fug@mail.gmail.com>
 <2024071447-saddled-backrest-bf16@gregkh> <CA+3zgmtP0o4onLaeUhoYoJ2f9J_hSo3NM77jpSQ9N-rTWgG80g@mail.gmail.com>
In-Reply-To: <CA+3zgmtP0o4onLaeUhoYoJ2f9J_hSo3NM77jpSQ9N-rTWgG80g@mail.gmail.com>
From: Tim Lewis <elatllat@gmail.com>
Date: Sun, 14 Jul 2024 10:45:12 -0400
Message-ID: <CA+3zgmsCgQs_LVV6fOwu3v2t_Vd=C3Wrv9QrbNpsmMq4RD=ZoQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 8:51=E2=80=AFAM Tim Lewis <elatllat@gmail.com> wrot=
e:
>
> On Sun, Jul 14, 2024 at 2:30=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> > On Sat, Jul 13, 2024 at 01:52:52PM -0400, Tim Lewis wrote:
> > >     usb: xhci: prevent potential failure in handle_tx_event() for Tra=
nsfer events without TRB
> >
> > Ick, is this also a problem with the latest 6.6 and/or the latest 6.9 a=
nd/or Linus's tree?
>
> The problem did not occur on 6.9.9
> I'll test 6.6.y next.

The problem did occur on 6.6.y
I'm going to re-test 6.9.y ...

