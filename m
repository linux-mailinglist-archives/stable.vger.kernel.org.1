Return-Path: <stable+bounces-89592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E79BAA4F
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 02:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231BB2813BE
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 01:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494F2158A2E;
	Mon,  4 Nov 2024 01:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4B/2DYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664926AF6
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730683778; cv=none; b=fjJTF3KJm0gLmBhXgmGG9hmFBp9oddvrw0Nk30tCbiEOi50BfnMQfrLtSlEiXhvu4hZ5Csqt3S5qdmj1nKl6JRmyrG9+BOgbQuvUK674QXJiqrHONICVaVe1WiwQ0uCjROqsbBLM7KLux4Lb8fLgORASNOugEgycPk0n0KXrfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730683778; c=relaxed/simple;
	bh=GULAbOY1zVeIbZv4Zk+v9DlKeXQwcxXqh1xlTQPzHQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSi7+QQXcv/8d39srqowcVMlthxJfj/L2hy71GMBqguSrsqdNhOEKfcDYC3RH9kDLXP6VGLJp7e/nkPfrGUBlEeTZzdTDQlwKXjmo1a8rfg2lmJQGweF3NJQe+VvEDXQhs1eR+qeqV6dGcs5gUw4eLaBDrXj5eOeeJjgITqVnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4B/2DYK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso31819795e9.0
        for <stable@vger.kernel.org>; Sun, 03 Nov 2024 17:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730683775; x=1731288575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GULAbOY1zVeIbZv4Zk+v9DlKeXQwcxXqh1xlTQPzHQQ=;
        b=A4B/2DYK4AvzvTWEX6IQE3T0LTOe7iwjwf96P8VdXvMWtJ3smXupjqPWu8EXZkojnR
         2oOa/TC82r/s8ms+uYNQd+a7NpQaJ98bw8YG4QseLkzQMO+EKZXvR06eM1s06C/F6fcg
         Z0DgBbeQV1zFojnTnwaQv702IeDvO0/HJmoVTkEIY8IrvtkJj/+Q9ZNgPMJg0wmfFFIx
         DKl1OFlivWMFsZ+vM3geaUL1iE8OsJk7DdH/C7ifLbgX+UU6Ad5X8yLYxubNr2gaJd9y
         0sjgzMLtkg7xnWAQdHJsux8G7vhjhccp/rYv7BBaGsJDvVGhUoOhFAW7GJhN00xKWwQo
         OATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730683775; x=1731288575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GULAbOY1zVeIbZv4Zk+v9DlKeXQwcxXqh1xlTQPzHQQ=;
        b=kuoYJHcBwX29iBrDJVPi46NLZttT/whNCTk70KnOWTwoS+Gnkwrv94mTWGKEd62LwN
         TiQkYLBBzH2/60cwD1FsOT9ly/qW0C2B+A3pPnM+hP1z8Jwij4uFXpC/AIJr68Orvt63
         l55i+Lfh67o1ANztb06huCIsEN+kVryxrdVSxLglTj7sMb8g59bdduJQGt0LsecjkDBP
         AxkaRq4F7VJsVsueaiPMA8L35nr4nQ7bWHmfEH7p/aNrNXQsPkD0NZL0gmGpurQtTpAa
         3p1/ybg0ye6S6Gom/JU+9xmF6uxCYzg/wZ28cndIsYi8g8YpmYGvbRhM6k00oYh20UdV
         WsDw==
X-Gm-Message-State: AOJu0YzcB0mjOmtNxLxBWSrUdiECN306Mw8NUO6zxwB45pa8kvOuBf2K
	i3Ta8xeZGPU1XHLfYGm8GmHd8iKm0sxI9wEfgkmHDfoh4f1v4RZ62beQ9OSQmrJu/k2uM/oyy0Y
	bdgW52Y0DoA0oLXegwB8dRzTZmZF1Wg==
X-Google-Smtp-Source: AGHT+IGSE9M9bYvD53j6OyayGZkECjkOPs55XRDHAftYWL6gTMpCLQzV2c0bzsrMRN7EZHB31Xsc3TlX2wZh0qtkudg=
X-Received: by 2002:a05:600c:468a:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-4328b4bdc74mr56763365e9.20.1730683774423; Sun, 03 Nov 2024
 17:29:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103022812.1465647-1-gpiccoli@igalia.com>
In-Reply-To: <20241103022812.1465647-1-gpiccoli@igalia.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 4 Nov 2024 02:29:23 +0100
Message-ID: <CA+fCnZdM2rjzJf7COAjDLvW6S0dDaSpPKgZfMvXXQ4i2_HL+Nw@mail.gmail.com>
Subject: Re: [PATCH 6.1.y / 6.6.y 0/4] Backport fix(es) for dummy_hcd transfer rate
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org, 
	sylv@sylv.io, stern@rowland.harvard.edu, kernel@gpiccoli.net, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 3:28=E2=80=AFAM Guilherme G. Piccoli <gpiccoli@igali=
a.com> wrote:
>
> Hi folks, here is a series with some fixes for dummy_hcd. First of all,
> the reasoning behind it.
>
> Syzkaller report [0] shows a hung task on uevent_show, and despite it was
> fixed with a patch on drivers/base (a race between drivers shutdown and
> uevent_show), another issue remains: a problem with Realtek emulated wifi
> device [1]. While working the fix ([1]), we noticed that if it is
> applied to recent kernels, all fine. But in v6.1.y and v6.6.y for example=
,
> it didn't solve entirely the issue, and after some debugging, it was
> narrowed to dummy_hcd transfer rates being waaay slower in such stable
> versions.
>
> The reason of such slowness is well-described in the first 2 patches of
> this backport, but the thing is that these patches introduced subtle issu=
es
> as well, fixed in the other 2 patches. Hence, I decided to backport all o=
f
> them for the 2 latest LTS kernels.
>
> Maybe this is not a good idea - I don't see a strong con, but who's
> better to judge the benefits vs the risks than the patch authors,
> reviewers, and the USB maintainer?! So, I've CCed Alan, Andrey, Greg and
> Marcello here, and I thank you all in advance for reviews on this. And
> my apologies for bothering you with the emails, I hope this is a simple
> "OK, makes sense" or "Nah, doesn't worth it" situation =3D)

Sounds good to me, thank you!

