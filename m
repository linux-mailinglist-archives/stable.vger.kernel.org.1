Return-Path: <stable+bounces-203228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDABCD6A11
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 17:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85BC303E669
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C5B326930;
	Mon, 22 Dec 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="EIDDBFPC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9727A103
	for <stable@vger.kernel.org>; Mon, 22 Dec 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766419562; cv=none; b=nFGsGmFARJNsXNqgObdm+56GrTmkgbxCETkuhglbS41Z1naKDwDvO81D9o+YxLos0vWpxNlXXtY7K8y3QseYu/3fEw3TuxWBelOVbh5h2ozU1/YCLWUXT0JNACbaMhFUM30w4TcVYI1GQFJS79f2mlD5TEm7NQLlISQuP0HWHM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766419562; c=relaxed/simple;
	bh=9GSybY9zlgbwOL3N6pn11FM5FIhBxpAoCP7ajx3LDk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ordYWLHU+CUH37dKrmf8g+CPtOi8Zf5hYRRFOJVsRP3fJVG8q3dD6Bd+OLN8xc+G4DDJ0fj2UnxAX8l3LfJ7kBFRWfaHCYhPeCvCp8WmZmlev3vJT0OlkD2QyXdJZPkovaHNiZr/4f/zZEu2rWYIrPbJnBCaP31xn0a0DWAZOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=EIDDBFPC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-431048c4068so2324614f8f.1
        for <stable@vger.kernel.org>; Mon, 22 Dec 2025 08:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1766419559; x=1767024359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GSybY9zlgbwOL3N6pn11FM5FIhBxpAoCP7ajx3LDk8=;
        b=EIDDBFPCpHGaqh/VpKKjpfQv1iLTrKjUvGL3wuVqJpm7wFo4Ws39c+PhWGATWN8bhz
         lC6f0bObYASM+XZdPAq54QyLNwoDi67ca5g3EUbsmSHJBjZOQJGkdUN+oI0zONq8cxSo
         z/4FxO6axSbxzTYjxzItcolW6Jj3VhYmcZrRzuu7LNyHPs0ebo5SDBhGDplut7SNmW+I
         fXzgt4uZ7YVS+Uy1pBZFp9S0tEosVjaXBnxaKEV1qlkP+A9lOH/dgCNBeUaJ/s6O2v0f
         I2DIvY5KtFObuAA5Wl9GN+zahf4BduaFLsQwjtfzogvL7x3zuwgvXxgXITiQVGckYwO3
         vsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766419559; x=1767024359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9GSybY9zlgbwOL3N6pn11FM5FIhBxpAoCP7ajx3LDk8=;
        b=Zzfw0AKPEjtHhFDlHhdt+wjM+0avLD69p5bNqfm2Cx7oMUaUd4JE6Hj1HgCAE3DMwM
         n4ICeXY3gj+jLn8SA3CncGN8Cj2Jy3URYjk4OM04q5D5jKwa+o3hZr0oXAfB/rgxgeI8
         4z5ZJexrTGV00icp4HoOlW+earENpSOyy5vMJ+lKzv7wn+SflWZpO3hVFGl91tof75Ql
         9iTsrK/HdA4sSmoJY8PFNEVTHFCtAmZ6WGpYt8W/c6NBekUrqLhrCAt1uRv5vyNQohJ7
         MXfIdLCtYMR7on0vZGqhaunn0jSmLTU4opgXEZx/6Urkhu87qg3WdrCySlcPI4Ht14UD
         Axcw==
X-Forwarded-Encrypted: i=1; AJvYcCUmNnyotLV1Z3CBbkG9d/Gd3EmxdDG6H3ODC1xk1ykrasBxyxk2x2Z+Mf0NEGYnZclRxAgkoRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfdp7H2kx5HraRy1VIHQyISNOsUD7c9S5LhYPWPX6myBsngTdY
	dx6Ntfm0thdx4Bj5DfEOEd5aY0H9DgPXRFkaiaDKS3TsTTz2R7S+6f/kdkNMfJuY2+TIT90Hsjp
	hWEGQCdmY6PpvbsgwdSt0BDCPRuGLVGsSsdVkdXgyAArlSyX42diKGc0=
X-Gm-Gg: AY/fxX6h/vNjscNuo1bzplqiaNtTn6AvSAK4AirkKhbmIKRU9sLoG+nx+nZzl4F+p7F
	cpTbs376XRDoiHIKEExOsFdpxg2ne9ZcFgxDZXBLxHQ250Nze32120MeqjhZzZYmEaAZEPXxMve
	QclevKwHQh6Vvg9Em86S6xtWj0mGgyU8oQnXAGgdvk5oCwMJjB9kgqvbxHXCKSIJ/LfbbhQQmFf
	AVZrpiCzRN9rDq5pESlEslz2kxjEKs2NOXikxPa0SjiYgp/a9lRMe0ulVUhOlw2LPnJmFtYTqb9
	MZkDC3GFkt2iLgy4pTnaFBgoDm+beoluaydj
X-Google-Smtp-Source: AGHT+IF85Jpy061efGYrFXdwEVD75nuvaquwiFbOkB8x+e/DL8d0oZJ8a+QFPrbIG+XdyRl1LA1C2FguSGaSOO7bUyA=
X-Received: by 2002:a05:6000:2385:b0:430:fae3:c833 with SMTP id
 ffacd0b85a97d-432447a27femr16821050f8f.7.1766419559533; Mon, 22 Dec 2025
 08:05:59 -0800 (PST)
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
Date: Mon, 22 Dec 2025 17:05:47 +0100
X-Gm-Features: AQt7F2ouiK0yA5JohVYm-_FB_NaUn3PWwZidZ-lhlah2f1JA58OcO1oLH7qLzw8
Message-ID: <CAN+4W8hrm8k9Jo9MDPRd_4-Ak80s3Avnjw5MNNkwPVai=iCP0A@mail.gmail.com>
Subject: Re: [PATCH] virtio: console: fix lost wakeup when device is written
 and polled
To: Arnd Bergmann <arnd@arndb.de>
Cc: Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 11:49=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> Is it always enough to wake up only one waiter? From your
> description it sounds like it might need wake_up_interruptible_all()
> instead, but I may be misunderstanding the issue.

I did some digging into waitqueue semantics. AFAICT
wake_up_interruptible() will wake all non-exclusive waiters, and up to
one exclusive waiter. In our case all waiters are non-exclusive
(ignoring epoll with EPOLLEXCLUSIVE).

I do believe there is a different way to fix this, which is a bit more
elegant. I've sent a v2.

Best
Lorenz

