Return-Path: <stable+bounces-41715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E19F8B5968
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F80B2B40D
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988A156B6A;
	Mon, 29 Apr 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAeZ0wZu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC75338A
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395846; cv=none; b=sHcI5sAPJVvskPWU5GCgu0gkS5++rD9I7pHuesO0H38g387u6dYaohsjSdnOOUlQfxQhSOCbsWjKMIwwRNWYMPBGJ6GPtVYDvlX5Xq1PW/98K9/KJSJcVSSvXT2uwg4h2DoTcLuNoQm1o2zNmj26CWt7vz9yJPqzGisw6Qx5RXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395846; c=relaxed/simple;
	bh=PBZU2TMMW/6C3ulEQlDznqnr5EeT+3FH17yZRtH6p74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYo05hnMoeTo0ZXvtHoqyfO4YldfEySbjmFCqGZT8X59iMI7p+GkArkfpd0JPoT5MioxZf5qwpdhw/RzsyCCR6pIJnqXfi+Hhv4JvqlZH8T9vJBoIU5B43YGE0+lICb3qXfYkXvNrGbXKTfHu7wn4SE6QO1BxGRbNpMdNnpEzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAeZ0wZu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b18e829acfso692802a91.0
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714395844; x=1715000644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBZU2TMMW/6C3ulEQlDznqnr5EeT+3FH17yZRtH6p74=;
        b=VAeZ0wZu9hd1fLis7oLVTvan4aWch0mKbX/8clPCRM2m5v9N+TO4obo+2BTt3Wpghg
         L/hpCjQlc8oPfoLgCKVOKH8kllXtQvgZfYDZVspBJmnomeXrFkRhn9fph3lS/RlxXxFq
         Hru+kkDuXp3t0zWon0X8TUDMWTdcyQcjomFY9HpQ+VTKFQ+MUrFchzNqFVAn9vJZn7Mm
         2LQBew/CDlQOMX9qAUDB3n1YoQ94PUsermDfImM3rKpV+X1Fb2E8/yCckdbybG7kQ6XQ
         dh1CwSz2RCHO5BGM0r85Y3hrrMfRChjlIeIsK3SqcyeFIvFBzslkiBWrn+GmPj5SCN47
         UEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714395844; x=1715000644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBZU2TMMW/6C3ulEQlDznqnr5EeT+3FH17yZRtH6p74=;
        b=tav+OJWwPuoQI4II+9y9zwOL1ApioFsaZFIyVm81V2Vf3lyUO6DAHKyY+RWG2tfbpX
         GsjewGauaRf/5Z5rrDP3kMEc3BQqXYoUVHy4UnmJmCCRRIEqftXomKkRToziJhjaU+vy
         sqFrMALcGDVSiT21qe4uug77JeryYD0IVOV4Npa2PmsKkbWwOqH+K08cV70rcOqjR4eV
         RjOk0Fnbvsgt5S50/qyCzojJ2eVRjibbSO7iLRL7FoYRpG+6rR4uVeS++nRBlAO6xzhS
         jBRnJL98lRSUJU0O8KJU9hsPzbkAJ6kTDmucuW0Hv4yCOQFifJgsdoD3NiiWYsnhJVqx
         qbSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3uso6wOOh17zS9jJyMDb+DPiyYttDdSWzL/AJ939ssoDfoKECTkG1Jm+ohFRFCfXN1OiLXx8zCad0UwD1jn+7sTjn3iDK
X-Gm-Message-State: AOJu0YzPbnNCzPJO2xxl9AIqWxal2cga9W4ok+0isEtYKcOe9I2P1UgQ
	r1rLcOVUItYk7ZLyqTM5iaLS5gKg3roFJeQvXx7lQFjuXxNQht6OOx7g5thseSFhDA6EDF0Cene
	5VR5PexoHaiKnCd2DtB3uH2uidXw=
X-Google-Smtp-Source: AGHT+IG30yKQbLv/5JlDHB2oWrg55LZXzirKMbM6Up0KptAG3UPbFYwDE7uOWxQGC/troGRZiJZ4PyFrHFK+Zuwzx5s=
X-Received: by 2002:a17:90a:654c:b0:2a0:215f:dc9c with SMTP id
 f12-20020a17090a654c00b002a0215fdc9cmr9486969pjs.35.1714395842959; Mon, 29
 Apr 2024 06:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024042909-whimsical-drapery-40d1@gregkh> <CANiq72ndLzts-KzUv_22vHF0tYkPvROv=oG+KP2KhbCvHkn60g@mail.gmail.com>
 <2024042901-wired-monsoon-010b@gregkh> <CANiq72nLGum-AqCW=xfHZ5fNw5xQ+Cnmab3VZ+NeHEN1tSNpzw@mail.gmail.com>
In-Reply-To: <CANiq72nLGum-AqCW=xfHZ5fNw5xQ+Cnmab3VZ+NeHEN1tSNpzw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Apr 2024 15:02:47 +0200
Message-ID: <CANiq72kr2zNZtKZqqmHeBW0XXnMHhXeF4S6UysCrb2_BNCm-kA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] kbuild: rust: force `alloc` extern to
 allow "empty" Rust" failed to apply to 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: ojeda@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com, 
	gary@garyguo.net, julian.stecklina@cyberus-technology.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:22=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Let me send them manually then.

I see you queued them already for 6.6.y and 6.8.y -- thanks!

Cheers,
Miguel

