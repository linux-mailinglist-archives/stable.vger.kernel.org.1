Return-Path: <stable+bounces-121610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7BEA58808
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 21:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D421B3AD329
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 20:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3941DE4F8;
	Sun,  9 Mar 2025 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O55SYx47"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7383C1DF279
	for <stable@vger.kernel.org>; Sun,  9 Mar 2025 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741550746; cv=none; b=msd8QRGiDNUdOydLUj7ThPt43akt3mGMOcLmXVpJHn8yDIMtabjJOjCo0ETV0FKwdeNBrVa8qdD7+cEk60xc9LtYiEH0LCjLTn+hLLv8piqrmxlRdVnjXgMnFWrs3TMXvNVjytatrYPIJCfqK18hyFdT1/gRm88pvTNxDXPH0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741550746; c=relaxed/simple;
	bh=5QNgz1DSwEz+JcQUvkPIVZFiV3jEVE3c+o+xtiwY6iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeMz1y+NQYhtsIJ6Gqqbjof3VQ1XUkCW6v7a3lp2/Ov6VcliNebzmI/huGoWl4/sbX87htrahy5hyOCBYeDG7I8DYXAJhQPXvUakgMOoXY/Hr58yzyNIqzgU6wnpvHZh12FDwEslvtu8tE5UE+aVEl6/1Z3AQD2K8DE2MiDIH7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O55SYx47; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso2443688a12.2
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741550742; x=1742155542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zomZiYOBSa5a/dlFzwVwmAP1/cu0vUqOQ6lECx80PAs=;
        b=O55SYx47ZyZ0tGMXkJAARLilJegA+GA+V8zg5seVS39tySHygUvYRkBP9bbhQ7bzfT
         7/lMDdInMp+0TqeA56NuMJC5IxQs0k5BrCZKjw/vTnsi0Cnn/tY2hfHuQ30izK/pUGNg
         zTba9oTLzO9kN4IiosChn51lOU+yeQsgogTDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741550742; x=1742155542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zomZiYOBSa5a/dlFzwVwmAP1/cu0vUqOQ6lECx80PAs=;
        b=ZzLLu38DGqATaFxAowZF5+LN1Bo1omUttf0X4N+fveAy0rsESeE+UiehbK0127ccCq
         XlBgl8atCRsf8Q0YqoHbRi6GowXwLd7n+YkzpbxDfe4jTd+D+n1PiNE3L3oybQi2Yzsr
         Z5WwOBNaUvK7RZ16Ygr5DrDe1I+YThRpM9gxsXr3ebgjtS5sEvJufURs8KigbQfWXbUT
         eLFD8NjrlPLzowiC7ZtuksXpe8L+LboF2FOTgZmeDfO0mIyEp30qOO+0cvdXIOEbyk2d
         LOwGW/oSR1h5PFO7cYpB7+80tKMcg3b6LTc38wgwaqo2mxxmxB8jyNcZxArXGhOV4bRK
         Aezg==
X-Gm-Message-State: AOJu0Yy56YKXiiE9B3PAK3HyuehDzwg8UWMnnltd14ZxBwXEz7M6/7vH
	r6AGzrjnSFYIS0WBsN1f3GsNsTwrdMpLsMzZOG3dxQ5QO3CFo1xn/Pk+zqWCisp71GIL/se17RR
	WPQY=
X-Gm-Gg: ASbGncsKx/i5mAmRFNpTmmiOxvzCVAOuaq9DIopoBZbyhttRyXDMSEWWKbKh/plZCij
	5DBHs87ifDVxBzmrP02GoesetxDEzOhQb8X6rHStP5zFjm5oNrHkyUtJreQmVdu811+3+8rjy4L
	VC8K7FDBt1grkn8Yg4f5IZWrhszzs1Vrghj47E7hCrfZDpEX6gf+2ohktBZzXR1Yrir0Ng3pYhg
	PCADdqno8328yB9fIpwGDyF6ieldXCSbPIPZRQYOVtbytnhIiRCWMbSxbQRsYujEKABkUn/z6qu
	QAkQwBfw7Not2ian83kzaGkxN5W8FHBGKc3BaPkYR8D0kubmBkPSVA0+tPppDYNbCbocwFiwlgL
	nL6DuGndnCUnPUhYhKEs=
X-Google-Smtp-Source: AGHT+IHhu5b+idgjNS2CS9OAfenv2kRC4Wa8pHYqnx6ReQJwhv5ItcYtFRVhZo6Zcpeohu5tQfpUow==
X-Received: by 2002:a17:907:1b21:b0:ac1:dfab:d38e with SMTP id a640c23a62f3a-ac2525f6b9amr1151720666b.15.1741550742374;
        Sun, 09 Mar 2025 13:05:42 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239438f9bsm650002766b.11.2025.03.09.13.05.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 13:05:41 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac286d4ed05so122857866b.3
        for <stable@vger.kernel.org>; Sun, 09 Mar 2025 13:05:41 -0700 (PDT)
X-Received: by 2002:a17:907:7156:b0:ac2:26a6:fed5 with SMTP id
 a640c23a62f3a-ac252703847mr1064702866b.29.1741550741028; Sun, 09 Mar 2025
 13:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309195202.4675-1-sashal@kernel.org>
In-Reply-To: <20250309195202.4675-1-sashal@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Mar 2025 10:05:24 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgsHsVjOnETsRtY8ELEi1G1_0uLMYq2Fv9auhRfR5uJvg@mail.gmail.com>
X-Gm-Features: AQ5f1JqZd31Ai6TLorPQKvvkOZNZdK8HJaaYWhzH0xBPB29dSHUTONoVoRxJzHQ
Message-ID: <CAHk-=wgsHsVjOnETsRtY8ELEi1G1_0uLMYq2Fv9auhRfR5uJvg@mail.gmail.com>
Subject: Re: Patch "fs/pipe: Read pipe->{head,tail} atomically outside
 pipe->mutex" has been added to the 5.10-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

Note that this was a real fix, but the fix only matters if commit
aaec5a95d596 ("pipe_read: don't wake up the writer if the pipe is
still full") is in the tree.

Now, the bug was pre-existing, and *maybe* it could be hit without
that commit aaec5a95d596, but nobody has ever reported it, so it's
very very unlikely.

Also, this fix then had some fall-out, and while I think you've queued
all the fallout fixes too, I think it might be a good idea to wait for
more reports from the development tree before considering these for
stable.

Put another way: this fix caused some pain. It might not be worth
back-porting to stable at all, and if it is, it might be worth waiting
to see that there's no other fallout.

              Linus


On Sun, 9 Mar 2025 at 09:52, Sasha Levin <sashal@kernel.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     fs/pipe: Read pipe->{head,tail} atomically outside pipe->mutex

