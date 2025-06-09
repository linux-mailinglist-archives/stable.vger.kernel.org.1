Return-Path: <stable+bounces-152173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 441DDAD2065
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 16:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0973B5821
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2D52459F7;
	Mon,  9 Jun 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xgszirsx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44725D21A;
	Mon,  9 Jun 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477086; cv=none; b=Tjk0A4coox6Q5kRxbjpypJdeGcNZzTVgVHQLSmhKP8bXu509KLsG68b+TDn/t4TZMX6qujEtgTOSBcB/bsQ4M+klDxzUP+vWxQ6AJchhFrxPj911+cWclhhbZd1U0bZs8HZtcFNV27nEvfIt16piNMlvuEKEnoWMu0ET+bHW7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477086; c=relaxed/simple;
	bh=eACaxt02WUWamov4/PRFJ2M1YIB5DvQrMTadVks0Ha0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnJk7ZkMVU1QAtMYbVQL836Y/qIRnGSq9XcpERiLmhCTl5mC0xZXGGoKnFnCH8hnWCY67ohiT0/jMDVoQX4pQ3u2+z8JDdnCTyYotqnMA0aI9ptsqgRIXYLh4ypBTonG0wiqiQL32tm+8W7MR14MiCw0mbdlRthdjDlL/cK2Trs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xgszirsx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-313067339e9so680475a91.2;
        Mon, 09 Jun 2025 06:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749477084; x=1750081884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eACaxt02WUWamov4/PRFJ2M1YIB5DvQrMTadVks0Ha0=;
        b=XgszirsxsnEa5PPQmZKlCbIjhOhIjqV+T8x8IF81InX18SdqzgygswOV8OUtRLh2Hz
         702uSKFMuPxir2JVRMUBdR4pBWDnMoWsyUoccj2kBuwdxJXnciF1K28Q/xTEA1xnNYNE
         XwVWSSsPFtJIA5az/9Mlfbu3eQmnGvaL0ObKam7j+RD8OvXUtbjE4oSRq2tRw3FSxyVE
         jRdUhD5/f7aJteyCFyAr/YH9imE+dlJzjlB5bg7TkWAhNCGGF4rv6Ff1QRPccN297fQt
         O8oWkFOrm45uDyuzNYEoJToSiId++wxN66zEH19qDt/Z4k07ubbtdfhqR7+TD89uNq0e
         6s1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749477084; x=1750081884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eACaxt02WUWamov4/PRFJ2M1YIB5DvQrMTadVks0Ha0=;
        b=jDPWTnl2CooIOZDcVIGRGNJqZqAwLgbBOT5CmVTGd/O9fSKCgmUNyrk9pLyiS+p8g6
         v1ejj0tTIEcAtYxS2+KPOiwgIVBV2rwlU0J7tDYxQYFeomaD7V1SHwJZ/CqC7XrcCAPa
         lDe2TS1whaH8zyudxI92DRyu1awJZKVSfFAK8L0RmbK1KrvjuEaKAQq7uUBo6qg7QQiw
         XzvZ3jgRgtiecxH0ILlW+WmDqdZbNLb0Gi4orp5Hj2N9xy69qSVLSf4YBUZnYX3Lix5q
         /lUoFjO8djowF8JDA+yS/zYJT8GG3++RxS4rRmtzPYNI2XqeufJ+x5Nd49aKAliZm3aJ
         n4Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWX7Zh4MJpe9+/9HQJqgteXB5r4PfsqLWo9F0CA9nEYmxGI9rEX3q2yRZx2q3Ykkp7tj/+dybOhzB0+4U5J0Nc=@vger.kernel.org, AJvYcCWwy6lkttTxIUt6kYd9OwS9pbT2ZSIlAbIYdIKoehOZT/vnwan5XygVE7OqUzxlBcUusJ7+gdPI@vger.kernel.org, AJvYcCWz2tPG4GkaWyzD1KZhZftL88qYuaYKFISPsV608cJ7i54i+WtT7uil2l6A/Xd5OOeIDdZ3sxknLWpQ4cqp@vger.kernel.org
X-Gm-Message-State: AOJu0YynbtKAfTlnT8EX9vKaXniX3Ad5cbMuc/JOXNcSdTsPDaGR3y08
	eBSgX3E8LN3o3lmbHmtPivuOgAlJx9uvROz4akkMOzSaLmJaFYcME1CrhUMIrojQmf1JOuwA+uN
	Nm1a7P/O6XGVeP9C+tfZxAywSbqL5fsg=
X-Gm-Gg: ASbGncvQgfx0uLCcEsVBh6jLTQX/w2zNv+53ebOo4rl1JJ+JwpeN2YY6RE0SAU3ccvg
	XwtEgD9LxvVJH4h2X45TwMX6PO569ExXHDdzNiy5Mq7o5KINT3/jbWlw/SmMfTf4f9AhrIBa2UD
	4thsYBX+GP0nN2XWSlWJhXafx6sBHk7eh0zBPmxKdJjRo=
X-Google-Smtp-Source: AGHT+IGkkCxVNET2hTnCQKkB5ht2XhMJXmVkVA6QMXG//p+Iy2xKOFDBp1eOArmCKNe88x3UOn8NtAfKsUQfancfTHU=
X-Received: by 2002:a17:90b:1801:b0:313:2f9a:13c0 with SMTP id
 98e67ed59e1d1-3134e2b90f8mr6572065a91.1.1749477084002; Mon, 09 Jun 2025
 06:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029140036.577804-1-kernel@jfarr.cc> <20241029140036.577804-2-kernel@jfarr.cc>
 <paezt3cuux5kwv7dvyuo4rrff2felwzmjunkdpyxqjp3fbnyzn@rcdj4xq6djio>
In-Reply-To: <paezt3cuux5kwv7dvyuo4rrff2felwzmjunkdpyxqjp3fbnyzn@rcdj4xq6djio>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Jun 2025 15:51:12 +0200
X-Gm-Features: AX0GCFs-AANvO4jrbUE-NjAZoTdqBDYVE5mIEuWtE19UmN1xM-LkNwTb5ope6jY
Message-ID: <CANiq72=kjk5Kkebz2-QrOuwRKENAziTXhXrnKNL4eoOo4diO3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Compiler Attributes: disable __counted_by for clang < 19.1.3
To: Dafna Hirschfeld <dafna.hirschfeld@intel.com>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, kees@kernel.org, nathan@kernel.org, ojeda@kernel.org, 
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
	thorsten.blum@toblux.com, ardb@kernel.org, oliver.sang@intel.com, 
	gustavoars@kernel.org, kent.overstreet@linux.dev, arnd@arndb.de, 
	gregkh@linuxfoundation.org, akpm@linux-foundation.org, 
	tavianator@tavianator.com, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:14=E2=80=AFPM Dafna Hirschfeld
<dafna.hirschfeld@intel.com> wrote:
>
> Why is the define of __counted_by moved from here (compiler_attributes.h)
> to a different location (compiler_types.h) ?

`compiler_attributes.h` is supposed to have only things that do not
depend on the kernel configuration and so on.

It sounds like those out-of-tree headers should be fixed.

I hope that helps.

Cheers,
Miguel

