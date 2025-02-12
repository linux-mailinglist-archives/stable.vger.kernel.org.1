Return-Path: <stable+bounces-115015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F13FA320AC
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C642E163FAA
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C534204C3B;
	Wed, 12 Feb 2025 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYRDhC/l"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F22046BD;
	Wed, 12 Feb 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347982; cv=none; b=iOf8na8aTXb0HmD9o406v9SAoAUQahxZmlqIbZqoni6nhEGYp6LHSoW0jRi6eBwWzW8tarzumSiWd0neLLO/JuS2w+oySdbj5xg81mCswu3YYw5R7IBDDk3FX2x8M/7B1bORHlaH4phJb2D7ls6P4xR/MTsG3vghLmbENKLwlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347982; c=relaxed/simple;
	bh=K6xZtvcBX7VHLllZ0U21xVUVPmHeVbAT8lLiQebLSdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlW+7gv5FRXIZyA+JwbTiSrPLnArN7/wL7X2lqiw4wj/SLe868ut/NniaWSm0O89NnjYXwVtapQZ9GflB02q3+AyEJQVI8RetMvOabRdHa+sx+SaXwQIYb2ilgu8ErSijoZIzaOOfrw+lA+SfV2WYFi+MLPJg4P5xF69+JQma5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYRDhC/l; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7c07e8b9bso524879466b.1;
        Wed, 12 Feb 2025 00:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739347979; x=1739952779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGGKJfp191wArHnRVFLB5wmtEKHrnNDmIP220p0KWvw=;
        b=LYRDhC/lh7LcIbTXPES0U8FcXjSJDT2hvfYTRjgc471gq28PoaRYPpjD5Peo8Cgvdm
         RYJ1Kq26yrqHEKeMtbTxSIIVvqLa3jSaYOsndFVd5D9SReakLPU8w53ykWqtAKmnr/id
         Ir3VlRROElKfZax5DIEOg+vahg0ATmtBZBD4aR929jUnE5A9tACDw/xAJ28fLVaQu8Ei
         38fELF9Uph4wqDSvwQVv62h8avY4gV4ZXbz+GSSvhNDZwSJ+pu9YoBZN8Hjtp40yQJ2y
         crkyKk3ZUociGt69QW5QK4Dabq1FmL2p44LYD0c1Y7tc3PGO3c84C9BqaTL3gxRji7bL
         gRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739347979; x=1739952779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGGKJfp191wArHnRVFLB5wmtEKHrnNDmIP220p0KWvw=;
        b=d8zscsdIEOFNk0TVTHwdflDU+5WaLZzF599f7Yvpc6nbt1YUbl4Avw5JXIBSdE5wf0
         eAiq/cWtB631+v7O8dSluIfozB0uazXvqxd+FFek7DpLahGKMoLIf7qGdmpu2VYkYdQs
         hf3W4cojLhPVbetXFLLBGIoqHOdgx43fwWGwdbi6yasNP9SRzSz6jR6DZ2GP7IN2TcBr
         dBX5JJKDfWo4HmX3kqQ/EoWS3w8tLx636DyzTHhCQViS3uqi12k2JmZlFvkazyCHX7L7
         N6MpMntKYot/EFp9kJumLE/FjFkBbdmD/kpMS237u8KJsLn3xJgu/Qhcu/ToFCQTDhgB
         hjxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwwCVOY/3MMY/Z4wWDCm38Ii89HIvpUqwCxuBcTbV4V9gLDV+Ywv/+2rRbs9FYZS7Eoa4f1vJ01kzkfQw=@vger.kernel.org, AJvYcCW9JpYyaO8nsiZtNNtpCxxjDk2kGbLLMYDMaMAFuFqnXeiS14jmyNCNv10/zY5I/0+I5OB1e79J@vger.kernel.org, AJvYcCXWHnbE9fQwnGRb8cZ2o8JQ0a4cGVYM7ysQM3JKKa3BskKLcc0xj9DS4vTUQUxfHj3GFNyD2cjsqCSO@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1ovS7SjLZ5NSyg0Bpg0s+ycRvqMzf/XnO6bKZ5dWQ0wBeqEM
	kGRKZxnLIFBCLZATOAb/n2qir0k9xK2mGdI5p6A8fNjei2atlk1v
X-Gm-Gg: ASbGncszC8XHVNI5iOT97pQXoEQif46Ek52ZlO+t5RYkelfEEomlupQobkEIZwhrL/s
	tkVioMOrP5oU+fO714gpRR+gvSis5J3RlVSzs3Gm9Tr+Hmdwcu4ANMrsZ++fEia+EXu7d4Cj2Jo
	gpXgsfB5zrEToAD/UMID0MCNKDpBDuaH8Q8M6o5mWQhspA1UJTTJNnpFaBScNJ5zMVo3Lsgls9d
	Wup7/FgZUKOkRhI7t1ewjzOCg6x6NxOzk5NeQxVtmfcqIp72kbWdM42++QWRUDzMQgdSM28PO5k
	Wn3yafuAUOddcJVKqRQhjuOxFFreKbtb
X-Google-Smtp-Source: AGHT+IELRgBORrlG4zy3zq7i6yGArccsPGRJu5FNsBQxgON585YtybG9n6qwQB5N+eUMjCgZIU2rHw==
X-Received: by 2002:a17:906:7807:b0:ab7:6369:83fc with SMTP id a640c23a62f3a-ab7f34af3d5mr163581466b.38.1739347978353;
        Wed, 12 Feb 2025 00:12:58 -0800 (PST)
Received: from foxbook (adth118.neoplus.adsl.tpnet.pl. [79.185.219.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b8f73d51sm647210166b.100.2025.02.12.00.12.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Feb 2025 00:12:58 -0800 (PST)
Date: Wed, 12 Feb 2025 09:12:54 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: Handle quirky SuperSpeed isoc error
 reporting by Etron HCs
Message-ID: <20250212091254.50653eee@foxbook>
In-Reply-To: <CAHN5xi05h+4Fz2SwD=4xjU=Yq7=QuQfnnS01C=Ur3SqwTGxy9A@mail.gmail.com>
References: <20250205234205.73ca4ff8@foxbook>
	<b19218ab-5248-47ba-8111-157818415247@linux.intel.com>
	<20250210095736.6607f098@foxbook>
	<20250211133614.5d64301f@foxbook>
	<CAHN5xi05h+4Fz2SwD=4xjU=Yq7=QuQfnnS01C=Ur3SqwTGxy9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 13:59:49 +0800, Kuangyi Chiang wrote:
> > +       if (xhci->quirks & XHCI_ETRON_HOST && td->urb->dev->speed == USB_SPEED_SUPER) {
> > +               td->error_mid_td |= error_event;
> > +               etron_quirk |= error_event;  
> 
> This would be the same as etron_quirk = error_event; right?

Yeah, same thing I guess.

> I tested this with Etron EJ168 and EJ188 under Linux-6.13.1. It works.

Well, I found one case where it doesn't work optimally. There is a
separate patch to skip "Missed Service Error" TDs immediately when the
error is reported and also to treat MSE as another 'error mid TD', so
with this Etron patch we would end up expecting spurious success after
an MSE on the last TRB.

Well, AFAIS, no such event is generated by Etron in this case so we are
back to waiting till next event and then giving back the missed TD.


Maybe I will seriously look into decoupling giveback and dequeue ptr
tracking, not only for those spurious Etron events but everywhere.

Mathias is right that HW has no sensible reason to touch DMA buffers
after an error, I will look if the spec is very explicit about it.
If so, we could give back TDs after the first event and merely keep
enough information to recognize and silently ignore further events.

Michal

