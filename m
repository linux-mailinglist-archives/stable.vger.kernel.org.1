Return-Path: <stable+bounces-201030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9DECBD7D3
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91C04300BE6D
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 11:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8448132C321;
	Mon, 15 Dec 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="erFMinag"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A619258E
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797962; cv=none; b=gRuOTbDbxZv6q6D1aJQDk/b9UhjfRWUKMLGpRwiQoLdAtNeBYJjEW5bolk65Rm2ebAQ430YPWemSLPY1l+jQLT0oN5s3doTa73e2yd+HNiJlMTw4Tv9tGbi0+FBOKogvlzn4ynMpFpE+/5sCUjah6OZ48gy5EGxnpR/0kQlp5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797962; c=relaxed/simple;
	bh=eS5Yk3WsjQ01y+LN+SGf9F1HoK/gz/CC55YPeGSjF08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh1bcf7TBBdWekKYDHrBx23USJML8RUXP6ENQ8+/5PtG+Ap7fKwIlcMi5kPZqpX+U9sMwx98YdWv/ZQTiwvRAXAABvDrynqWoqTAZtgZ0mD+MgYkguLDy3sI/fdxxEJub6Bv/pVbvCfFGenFvrUq8FMRAT6Q+Gus+T/LcrqsBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=erFMinag; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so38052275e9.2
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 03:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1765797958; x=1766402758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS5Yk3WsjQ01y+LN+SGf9F1HoK/gz/CC55YPeGSjF08=;
        b=erFMinag2qRcKWRjzr0GrPIL3J5zaX5N3wMwNpzh0IZ/VksHg+ms3GISzo+8/Wdiq2
         etWAdhjJJ8Un1qiFCUEv24FktFsOa5rjXQUEQAUPVau/bj/Rth8l9yRiFTs9fEclq0TG
         qblAvFD+MqqTA+3PEMqQuqoPKgMPkumzNwdWpIQt3xm1KGyX/9mWL8OWUwNhZ2Z+sxW1
         qyu+QrbQWqhFHghjCEklfCU7tdcCR9Q1u4dQDvRCzT1P9tKBmsZkgS2oz+ygiKEcgtna
         j+AYgJKTGo5elVFHFOdabYaeDs+kNSQUkvFlNFRXGPSqr4GSBec0+5nz35SXuihQiBtc
         8/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765797958; x=1766402758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eS5Yk3WsjQ01y+LN+SGf9F1HoK/gz/CC55YPeGSjF08=;
        b=Oyb3b9hsggfAwv5zluPGVm6EdMrSL7sV/F7I8p4byg4dsH0sTzYV2qGaBSGp92WZ7/
         nnZ4pIhWqddvTBFuTGagljipEMiDrJfiwd7i1g/Ix4jEBNgyoNspJHwlftBcUmYf8J18
         lLjuKbq9uh0ibz5uTkdWSmIxuTXTawdp7IjkwSQgg8Uegqlzh8OUDy+2TZwG0leCvsx0
         H9xq/6U86iMpGvsnKqbFSV2g+dngWSmNaTiW/4MkqyslvE7HF+Kixrnfhu9ft/p0l24r
         DKe4xOVm1/RHjbvpI6ijRiaKtDrhG3HsECCS6rlXHaj1pE8fUZgIor2ydhBz1nWDkjA3
         iG6A==
X-Forwarded-Encrypted: i=1; AJvYcCU0XFwLIWHeQIah39zKFWioGWoNh69tuyD3ILr2NRKfYwsfC5sM9dB8U1kHglUSe95ajpdWJAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2UMXUSg12EMVnkP8CbIvOS4K8+P6H/Rc2vHJ1AeC1w3Djme3
	pmre1+lGdJApCxCq0Oph4os23Tj9SgXBHvoZFy4A/xp0N+gPL2v3j8gQSo4T4YnYbh/I63/gjr4
	rXdIIs+vOvUGxDs3W7FjFc/AHG3SFYgMHdiSJbzSnlQ==
X-Gm-Gg: AY/fxX5gK6f6utFL7m0LQ5Q4rq5mmHCM3c3SRqKajdrgt6Uec3KC7XHkq52wz3cgbSf
	qufpzv1o8B9sA3jpRlC9Vlppy/7doHUJ8bwkn+k4mdzGkVIY/7gv52cLhEF6fNn9Gpt/pPxvVXj
	tJd3qy4RHhF4rcRN9oFbJvhdGJ62D4Jp2wdLNMsdbN1VMhoIL94ChoI3jnOBSp0ehzR2rS+HANn
	0J8uIwvXmPjNtakg/VE9uFY4T952eLViqsCcDhKmpdD0A0Tk973SN30ltAGTdHeWKCDhy9DkV9s
	WqfVu4xR
X-Google-Smtp-Source: AGHT+IGpTEbxFK2lbEctOBKa+eg6LRSXnvQzjEerfHMFeh7BccrYevClP/yesjW8S2VYrdlQoKulhkn5RWUyk6KLBnI=
X-Received: by 2002:a05:6000:2881:b0:429:d6dc:ae10 with SMTP id
 ffacd0b85a97d-42fb46e2cf5mr11339129f8f.29.1765797957904; Mon, 15 Dec 2025
 03:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215-virtio-console-lost-wakeup-v1-1-79a5c57815e7@isovalent.com>
 <568c03e9-b30d-4655-8771-f8995f5a4ed4@app.fastmail.com>
In-Reply-To: <568c03e9-b30d-4655-8771-f8995f5a4ed4@app.fastmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 15 Dec 2025 11:25:47 +0000
X-Gm-Features: AQt7F2ppCg1UxUWVFrNxxRZ7iZQ7757p2GrbRAwSqIYOXp8taw_DjKkJQZ4fjHk
Message-ID: <CAN+4W8hzti6dtuNAEKGqkSXj5NiNhb54w+Kbq0kCHnW3yiXmLw@mail.gmail.com>
Subject: Re: [PATCH] virtio: console: fix lost wakeup when device is written
 and polled
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:49=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> Is it always enough to wake up only one waiter? From your
> description it sounds like it might need wake_up_interruptible_all()
> instead, but I may be misunderstanding the issue.

Ah, I'm just not familiar with waitqueues, so that is very possible. I
based it on
out_intr(), which also only does a wake_up_interruptible(). So either this =
is
enough, or we need a wholesale replacement of wake ups? :(

Nothing in the virtio console prevents a third thread from entering the fra=
y and
also getting stuck as far as I can tell.

- Thread A: write(): fill up vq, enter waitqueue
- Thread B: write(): vq is full, enter waitqueue
- Thread C: poll(): consume used buffers
- vring_interrupt() dropped, both A and B stuck

Is there other locking going on in the virtio layer or somewhere else that =
would
prevent concurrent write?

Best
Lorenz

