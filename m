Return-Path: <stable+bounces-176812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AAB3DE31
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E049C3AC708
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53C30C608;
	Mon,  1 Sep 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeTZEL7d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422430ACEA;
	Mon,  1 Sep 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718449; cv=none; b=I0xdtVzVId/nprFAKQcSupmt1O4Nmum9O6aOttSsUoWAplPnXXkDR1oSIvNR7tNBdZ+yQUt5Si/QFv7vbt1KRemq4ud6lrAlMoBhOa2sq6rhxj4cdtxZ1/XQP0bxER0F3gzxuSWL1c0AbyyGRQNROVna2GWaXXJgEWhqvV/6eNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718449; c=relaxed/simple;
	bh=uPpjhhX6OSOG20zlto+F459N/ANJBRNXVrmbCAnwWsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxbO37JQ4WV5RC7frS78lX+gYN7riG/RezvBKze649C3764MOb3SnkwDc/YJxXlllxIqT5rvJpyyW2cUNAvIFauNQ+myWG8br/aC62XVsnWC1muw410ltRmA63gT0N5cGUhCMEIuP9z+8k88bVkp1k1kqDrB5lPp+8M4gg61CTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeTZEL7d; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-327d8df861dso1883494a91.2;
        Mon, 01 Sep 2025 02:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756718447; x=1757323247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTM7j+dudYDI3LeEGbLTFNhknSATcKexImiJ1EJbpS4=;
        b=NeTZEL7d4UxhFW0dFhLz3Lgr/ty60sVm3/4K7VK92M6GP6BOp/MJMakSLwN1ktbWm9
         ZCt50YEEs+mAEt+Woce+tlTr5YhR6Ru1dl5sJsa56dPc5FMQtkvRsfxXEVt7b3jYRW91
         CdD8dx4jCH6MYHCi/6ozKMGYAHWLndnbjvC0L4RmjV25Tg3zpQ7IJWT0QAPrK5Xk2xct
         HSVSaq7prRLD1CVHkDkPcOK6bglvLOuKogBVM1CqgdfXKbaQVeSmZiSjmmlc8m4iq3iR
         AkxbKncdbRWW7ORMdUaoO+Qy6cOGz9veSAUh07xYk4WoyDKNri+imCNzV0ObIQ0RArd4
         s6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718447; x=1757323247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTM7j+dudYDI3LeEGbLTFNhknSATcKexImiJ1EJbpS4=;
        b=UQEb7dttwpO3Ol6IabyNtr/+VYf2gXHI2Na5kWAdHfN7Zjd7i/f2h63kyPncPCc5VK
         AqojFxeFEO69nMPB31GRsfyZH/g1H7RapdK+njZ5lcGDB/7NSTRHayxr6mQu6yi0GSS/
         dBgS6szpMBYmzEnMO2j/bc55pcUC5DY+ESCgEm1GTa4HOStXrMF7x/mH3Ug1vAZHW1Z3
         /N9B3uWnjPgjzo8CGOgH8SAdz9Afdz3RTZbTso7q4mcPvAmgmZAztVAUcR0nQBvZLq0S
         wleN54Jq/utT/gyWt8muEzIY4U+tIL3jB7XFkG3wqIO/386c5t8Wa5+5OfOVBTtJQ21R
         BBBg==
X-Forwarded-Encrypted: i=1; AJvYcCUha2i5KPE26zNlXJ6k7lO1ObM7kVfJP5joCABqI500ttjxqrI3Ki6pP1d/wsamSV8JJCGR135J1nXnmc8=@vger.kernel.org, AJvYcCXNkwWK1TlGbvJzUtqXwhReU4kMomza3+9gH6H4+AJZZB2UpuxB7i3OiroDCqMyh+QdmJY+4fLk@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWFXbTI/SvO9v6HBe3SrqQNsflJ+7/deujAgWEDneSC9O6XXc
	g7je4yYh14l5BLuZ197IK9ud8jevmm48taaOsb7zvEk0LX/6PRo7M8dKIaRuQ6RuiKySDk8LTyW
	k6gAewtiNRzsBj4tcusouCWVCSQUu3h0=
X-Gm-Gg: ASbGncs7/ibrFCqXZq7q7U9f37m7Rnvmsho2zNtWff81Y5SgezMhmAwfHzI9i7F0dov
	oMYNvYwlZClX75ViQ6eyrXyWx1/kGBiJNIMSq1crzpXomBXmt+wtZSi3hl/DkSBSVmGUQDZBL5A
	udpYZZzli5Qrhnkmz4hCBs7BRxXh+WoRI1ca7Z52bzkCxu9D1W0Tv2nuLcpDhj7Qnlcrx5WpOGn
	+u6q2d7eLjnczeddfVwvZhkbRJyDinDCVbfG1iRixqt8pcmKQ==
X-Google-Smtp-Source: AGHT+IE8wUy1PB+IopIFDdgKXlskbRViVOMNnmdf/EFPKaLDFIGjEd6U9ahFVCRY9iM736R4GYKuuWXmGbJO+1d+tCE=
X-Received: by 2002:a17:90b:4d83:b0:325:57fc:87ce with SMTP id
 98e67ed59e1d1-3281543380fmr9519163a91.9.1756718447493; Mon, 01 Sep 2025
 02:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829083015.1992751-1-linmq006@gmail.com>
In-Reply-To: <20250829083015.1992751-1-linmq006@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 1 Sep 2025 02:20:36 -0700
X-Gm-Features: Ac12FXzAyEogZM8FrgEbQ-F5JCiJPgP03A7CJQUrB8cqhmDZLcCZUEpO4k-ru6k
Message-ID: <CAMo8Bf+Xv-r4cji=ueQgt0yK2SLJPSFNhzpG0ZX7Uo9b7qaMzQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: simdisk: add input size check in proc_write_simdisk
To: Miaoqian Lin <linmq006@gmail.com>
Cc: chris@zankel.net, thorsten.blum@linux.dev, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 1:30=E2=80=AFAM Miaoqian Lin <linmq006@gmail.com> w=
rote:
>
> A malicious user could pass an arbitrarily bad value
> to memdup_user_nul(), potentially causing kernel crash.
>
> This follows the same pattern as commit ee76746387f6
> ("netdevsim: prevent bad user input in nsim_dev_health_break_write()")
>
> Fixes: b6c7e873daf7 ("xtensa: ISS: add host file-based simulated disk")
> Fixes: 16e5c1fc3604 ("convert a bunch of open-coded instances of memdup_u=
ser_nul()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  arch/xtensa/platforms/iss/simdisk.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks. Applied to my xtensa tree.

-- Max

