Return-Path: <stable+bounces-151946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C228AD1368
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A9916884E
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3129319DFB4;
	Sun,  8 Jun 2025 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcYZ28VR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB019882B;
	Sun,  8 Jun 2025 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401759; cv=none; b=BMqiyz2eW2XAx0316ll/MwB+wNXC7FmXXZrtRYbAh0NDRJeorgb1bHl4eDBbTjo64SSzsNXZyjEFZ6eVoxi9JRSNcGsLnoXnLZZxXFRIQppyOKwt48f+KB2Do9Vd771r5SdzxS02c9sHPHjfv0y5pfey2UkZGB2gajkofu9nAXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401759; c=relaxed/simple;
	bh=lrJ2LzF7zlUMZm0btnhQN/Snt0WUKDPLpgPae//gUiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9XdNEHFbqISqQsC7K0d7jD0lS0tizZH/V8swlR0PG1rP4eA8re+jXgPtD+yQjxzhgALnJR4imXAS8PFFMms/cCL5NoT35ayAeUSRmhi2mmdGticUjhz3QeQPqOB2giA7Bg7/V+qRjczoZnWAHba1io9NIlAMGwyvBKBfp+Q0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcYZ28VR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-313862d48e7so59586a91.1;
        Sun, 08 Jun 2025 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749401757; x=1750006557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSjaCDZzns9NZ/rU9vg+pCrunxrSi24iyQgxwaNXdjA=;
        b=OcYZ28VRCx3ENe+QMchf1/dIfeiplPsocf3/qZmfXgqbJ2MJNSyBC3IN9zfghehA5f
         kM7yJ2a9tXIYq6uf6TP69CN5cxtPombKpXJv3ik1KaY3xpsS1VwybpoCWLJSeg9QKr4J
         lRQq7S5Tb8L12/17ufKHzFR4PcKoaV9VsZgxiqMP8736CGyLwETVmHZ3Tf9ZAW6bRzSk
         5sqimFJR5/Nm2jKhaUVZS5O7zB5rbaABeMUpTG2Trpvlles+m5l1VxZRPAbv6OgnwLbj
         ji8DzNfTx2PbD2XeUE4D4rIkLFAlq7K97HyZ2CPW0RIrpSnnnkvdAppddweZxxt+caPm
         1X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749401757; x=1750006557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSjaCDZzns9NZ/rU9vg+pCrunxrSi24iyQgxwaNXdjA=;
        b=a/2r6AXAQ21PO3btLEjSYjC5sbgyCT44AdFZG3hWX0fTx9CNs6JQhaCr5OCU2zo6Zp
         7ucyb4q0ogZrEyWJGYnTBriC11bvVXzxV8JrVRJKvQVie1UJO9fAcSoge+KkUWmg1y0n
         SnzIU3EmBz5FrLYipRO7ekYNOJM8whhKtvtOU9E5Xs6+5ffRPzz7x8XNyryr+R7JLwc3
         irYMZ2gFmL4zs+vg6fYBgEovT/pqwpKOEMi/R+AmV2AV8BlkbkU6vSzAUpRL52tXwXF7
         0wxbXlkDQT6WHTzzZ/jKDJZTH/cN60COy2LEjnC6rXsUMTkn1QfGGvZvDnalVQjdWP7O
         Tk1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0EZc7njhRfNtBwOS+ABz0iln4bNXvn6BPksOj6o7Oszn3kd9TFw0zTWSNLXSlN9SQV89vNv6SJNigRWV1dg==@vger.kernel.org, AJvYcCVQYpZZaBCgMWoQ5hC2RUfC/JM34XNkfz8HTYAtxieLfp1PPwwqMWPfMIl07NoxVqKqF3PDGPzT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6byeRcLwu0fI4+f13hrrvBbSz4bT7L1Gt79tLCdfxz3BJZ3d
	43z2NajuGaXc31Yh98SSyAHL2Hvs/TKCvD2zLAic8mHY7f5miTygHZzMRBaJfXKnm6GMY1osCki
	77ICjr/ZKz9njT1owh6MVed11NyrtCek=
X-Gm-Gg: ASbGncvD4sauMuakItcxR8F57q5zEVPUGFlP4JdFUvgvcGedwnCsQnMxb0qW3gKYh1h
	XPLX43jN95EQEnZbumYjRqr7cRWGVkUWlW+9/uPp5IW4vqd21DZqizg3Sn7x/HphlWXX5zWmtXf
	V2Xcm8t/rE6u6shl17zHx+5ATvG8K/Ud8gMPmwpd597EA=
X-Google-Smtp-Source: AGHT+IGkmZGpCtoYI36H3yUtvjrmSOb3PvMZ3WR83VJPV8zEEiF3aoRxqgFqf0hzcsX2tUpOnd945145uI/+k2leH8s=
X-Received: by 2002:a17:90b:3a87:b0:312:db8:dbd3 with SMTP id
 98e67ed59e1d1-3134e422457mr4453960a91.6.1749401756911; Sun, 08 Jun 2025
 09:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608125543.934436-1-sashal@kernel.org> <20250608125543.934436-2-sashal@kernel.org>
In-Reply-To: <20250608125543.934436-2-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:55:44 +0200
X-Gm-Features: AX0GCFtg5vXXOQtvKzuqFbWiwUPEonHdI8Jhi4FBd11G-0o2n9_KiOxJiu6CJes
Message-ID: <CANiq72kEoavu3UOxBxjYx3XwnOStPkUmVaeKRrLSRgghar3L5w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 2/5] rust: module: place cleanup_module() in
 .exit.text section
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com, lossin@kernel.org, 
	aliceryhl@google.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
	boqun.feng@gmail.com, igor.korotin.linux@gmail.com, walmeida@microsoft.com, 
	anisse@astier.eu, gary@garyguo.net, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 2:55=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> 2. **Minimal and contained**: This is an extremely small change - adding
>    just one line to specify the link section. The risk of regression is
>    essentially zero.

The AI is a bit optimistic here :) Changing the section of something
could actually have a wild effect.

I don't think I would backported this, since the savings are tiny and
they aren't an actual fix as far as I can see (or at least I am not
aware of reports of "tools" breaking like the AI suggests).

Anyway, it probably doesn't hurt either -- `exit.text` has existed for
a long time.

Cheers,
Miguel

