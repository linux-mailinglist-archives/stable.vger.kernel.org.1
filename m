Return-Path: <stable+bounces-92818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8A09C62BD
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 21:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D42BA2458
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799A213EF0;
	Tue, 12 Nov 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RUTXOkI8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D0320721E
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430763; cv=none; b=e9uAMrh9rnhbwbyF0MApTv83kJF5jWOnsaXxq4SIg9zueeUZyVa/F4FbeGY2xsu4DMQu3GVPGBJ9BBlBqj1tK+Y6KMHLwxqEonfeIf8BuA+OKUi+iwdpKY8/87mVVwfl/zFCYMPvvyDWbbdZaEUXVVb9mV7XW+BIMMJhwex+6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430763; c=relaxed/simple;
	bh=b1jTEdtkPHakCF/IMGMMubosZyjuhF07sN6TNoysKrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYo/5kaYUwuCrDoj77cPHSQ0but3Oz8qauLwol8igHkdx0INiT607dlImzbgqbMyhnaZ6EhirHL/92oZwaiYE2GQa636AzqJ7Tj19zk2C0uKjwN2dEewMgFJTk8OPNaUMtnW0MRzHd3yvci4kr2+heOI7/uTOZf+vEzArew0lEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RUTXOkI8; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so470097066b.3
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731430759; x=1732035559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZPEPxQtUZVtl/O/zpSarTmTSavN7LoRspL03/jTYy4=;
        b=RUTXOkI8HdlKelw/64aU4Tl7CzBpKXU0V8GLK67IeZHNtLnGTZ01umtK7annRScJlx
         +gMoDoXQen4N8a5SRJx4OPjYM+k5U0FUfTAwXvyDhkF4nPYnbRV92w5RvMvp83+MdEP7
         F6MEnZlG30f2ioqyT3QSRADp6ikh3fNItGW3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430759; x=1732035559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZPEPxQtUZVtl/O/zpSarTmTSavN7LoRspL03/jTYy4=;
        b=QpJO/q0rWbbRV5/sXh+g7bEyfeKZ82SgdZIyQ86Zq1H7fOI+g/0Yp7jFfUMX/2xtUj
         Xpo4cdp2eYUwJjleKy3lSNpr6Ct61Q8Ee9thmCw3qNMZJkoIdj36deUZ5RkoBKHB9UE9
         heZmPnaGc3D6hgVLjYYPqHXPDYmSs9qfJvLU8fzJUlyo7E3XOYp9yQSZwqZmlq7dPZz2
         gTPYxyL5BM0QJmG8rGn1Jt3e9ofG8VV2Vd6tq8iAMoq39bvKp8QOcBc1PEYvqOGaGP4m
         JqTqEFXt9FD8enB9+cQHrlu9ySL1WH7gzWjBY1UgZbXgd/zqC8wtm3mZhFIf1mHjQ3M8
         nzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjJ9BGeZX3o0eaaTLCrmgGFkMryawMKGE1xQs7HuhOxxdR3FDxsh4CURQqdSqAdaaFPM/1VOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmsjAoT79apROaUzt4uWvQFaKoJqimxLRfVp/OuNOgY0tXY7U
	0GujRkuuDhmjP1kdX1f1D9vXfu7WCCnnsxBeYnNzBVZF+AVHVvOQG6Vhik+40ddz47HPbZd+8W1
	yn6M=
X-Google-Smtp-Source: AGHT+IFBpP/XFi5mrGFF0hJwxwLOWHkbpghku74Vo+lHIn07nzMxceJZdvlCk1A18mR8WPtolSZJ4w==
X-Received: by 2002:a05:6402:13ca:b0:5cf:4655:fe7e with SMTP id 4fb4d7f45d1cf-5cf4655feb3mr7291947a12.24.1731430759407;
        Tue, 12 Nov 2024 08:59:19 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5c91esm6117573a12.4.2024.11.12.08.59.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:59:18 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4316cce103dso74305305e9.3
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 08:59:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1EPcxUB3kfEqKT0yOvDDTTK+MM0aM4s5/LhpmKROrAZH8GlDZC/HbSLYONWtIEf9wCyQ2sJQ=@vger.kernel.org
X-Received: by 2002:a05:6000:1a8c:b0:37c:cdbf:2cc0 with SMTP id
 ffacd0b85a97d-381f1889e2amr16128594f8f.53.1731430758034; Tue, 12 Nov 2024
 08:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-geregelt-hirte-ab810337e3c0@brauner>
In-Reply-To: <20241112-geregelt-hirte-ab810337e3c0@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 08:59:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLGan4AvzmAaQiF-dZ9DRRV4-aVKj0WXVyB34HjuczaA@mail.gmail.com>
Message-ID: <CAHk-=whLGan4AvzmAaQiF-dZ9DRRV4-aVKj0WXVyB34HjuczaA@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() for highmem
To: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 07:36, Christian Brauner <brauner@kernel.org> wrote:
>
> Hey Linus,
>
> I think the original fix was buggy but then again my knowledge of
> highmem isn't particularly detailed. Compile tested only. If correct, I
> would ask you to please apply it directly.

No, I think the original fix was fine.

As Hugh says, the "PageHighMem(page)" test is valid for the whole
folio, even if there are multiple pages. It's not some kind of flag
that changes dynamically per page, and a folio that spans from lowmem
to highmem would be insane.

So doing that test just once at the top of the function is actually
the correct thing to do, even if it might look a bit wrong.

At most, maybe add a comment to that 'uses_kmap' initialization.

             Linus

