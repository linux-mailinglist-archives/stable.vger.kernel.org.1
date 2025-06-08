Return-Path: <stable+bounces-151950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E5AD136F
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76ED83ABA91
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643E719DFB4;
	Sun,  8 Jun 2025 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYycuwpU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBAD8633F;
	Sun,  8 Jun 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749401914; cv=none; b=ST8LUUh4MI+sed51rY4+VADOOUcknXywiUPaLc95aftwIm3820qHVBqx5lg7Q9Ihvt9OC/BqfyLZmLpsvEj/Y86TkTu9raD+pV6fTceJCnb65sSLRiITIUDkG/ZAk+YXmyCFiW96jkRGgn7kRO3RmuWc29+Zoa7Oyo+/f2aSLk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749401914; c=relaxed/simple;
	bh=ES1nmazJC3eHPE4Dm72aaF6T8bwJef75vhIHbVci3TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5muTNbFvFoWQpfG9m59IIvZY6ase0l6ZtST7LYhHSIG7sLC69LUwF3O8lP8j/LHhPdYIchcIJzBymTJND4024GUbos7QmeVjLmVU9EveQiXYRvOY/e86en4EOc9tz4aRft0iCHZZB8gacPV5NsCl6k9DyRl8CLQv2+3D/mxLNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYycuwpU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31306794b30so663623a91.2;
        Sun, 08 Jun 2025 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749401912; x=1750006712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES1nmazJC3eHPE4Dm72aaF6T8bwJef75vhIHbVci3TE=;
        b=CYycuwpUfkrnA4w2pe64/VQ3+7mzSu20xfzqisz1oZhGC9d+DXjVZB3mXzNRvJbotB
         DKa5VFVOp7Mf4xHpYCiRXQlZh/GHbb+9ccUZ2lawHnvFaBuphYhOSeGDuJkUzlciSELn
         GV4Ic5L1ipp+tUTfLPeyEZ3wknx9Ra7VsVGUq7OP1p32Xd9/0RPTVdgCnJEGFIa0hvNu
         u8zDErk432YbOSXJO5OVG2Re/xqoFOxHhNAZ7IvmvFP8jJVJBOzbeoSCg7ycwAq724uC
         Q1dTHhXIjVJo0wxSFsYGqsHsgHSjrAEmqKBCms4evi8dqv9PcBymqnUlKtYnMXWhrNCT
         Cj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749401912; x=1750006712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ES1nmazJC3eHPE4Dm72aaF6T8bwJef75vhIHbVci3TE=;
        b=vdcfk5IF8gDToN0nDsJqjHFewozA2FtPlQvx+P0f3aYu4L214/7tZqKP1/nj/odzHF
         aw0nOiywD59lg/5M2V+DI+ojMyao5IE/+8Y0sfFyuxAbw2hJg8Mj7TSU6lw3x8X9aEsx
         S3YyGGpYwp9CKoCmsIkVGI9dNTAMB+R3DMCzWwUsa6dQakt3A8sl0rwyoiYWOn0HG/gF
         EImANx8Wl1FQsEattQ3OpQfCuRtMoYH0OgrcUwDHHii4fUWwzvfaT4LsEUEBxIAEiUue
         BZmqEqegTR2ie6xXsG60D5b4VNMT4Kx2BZ87kT29WlTVTIKywVLLCtuvcICqWX90drg0
         Q4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCW5VfWwZSR+uFG2VA0fJ4rfcAGv0BcR8uYi1hBit+BzvwRZMaHmPPbVXtbN8k79hG7lqb99J1LmKhML6RYxkQ==@vger.kernel.org, AJvYcCXQ8bYAO3d6yZdXJJ67b10fTsVkNRLzno91+3l82tcNLqPxMqCsc9gv163VuWTkL8vSGFC/8Yky@vger.kernel.org
X-Gm-Message-State: AOJu0YxISkGZc8jsoVJ729H9vp40vjCoksXZgk+FrQExVjG8FGq3p4Za
	wxYl79eFBij8wOAUrnkPIIcNc0UHfYcYw00oiqXgfpPr8/LHqkfBgXV5fvtffjNvtK7ZqWFfmuw
	Rcj9ivyQHc8eEduMRBGFUeCUkwlvb9uw=
X-Gm-Gg: ASbGnctc+/XPG6sapAIyohMp3F3ZB3yyEotVRpyQ1Dva/qQGNVH0NLCfkGuWz9qnhIP
	I4/UVSrtnH2FjlABgNw4khRuNco5vkeAYaUkii8qBKbstr/P1AA9lJek5PR2d5xPHnBdB2S5br7
	sCtmb6ZonxqnGG2Oh8kiTgQHHYbei48WiUZmQVFrG3ORc=
X-Google-Smtp-Source: AGHT+IFA4cilCp8konvSgiPyWQ58lP38AAeVmHos0qjl+W3YgE9/ft3sxbiQd2JYm7oZqsNfKL+FHzrJ6/JGbHhlXxI=
X-Received: by 2002:a17:90b:3890:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3134753c519mr5493581a91.5.1749401912214; Sun, 08 Jun 2025
 09:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608125427.933430-1-sashal@kernel.org> <20250608125427.933430-3-sashal@kernel.org>
In-Reply-To: <20250608125427.933430-3-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:58:20 +0200
X-Gm-Features: AX0GCFu6iiku9uzFUJGAP-W5yV_jv3JQSJcON9tf2s_TFjM-Gj7pUiRoU9T2fA0
Message-ID: <CANiq72nq8Yhj28MMUFBk1RbmuWaLssXbu3mz4rO_C6pV3GRE0w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.15 03/10] rust: module: place cleanup_module()
 in .exit.text section
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com, lossin@kernel.org, 
	aliceryhl@google.com, dakr@kernel.org, gregkh@linuxfoundation.org, 
	boqun.feng@gmail.com, igor.korotin.linux@gmail.com, walmeida@microsoft.com, 
	anisse@astier.eu, gary@garyguo.net, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 2:54=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> **YES**

Same as: https://lore.kernel.org/rust-for-linux/CANiq72kEoavu3UOxBxjYx3XwnO=
StPkUmVaeKRrLSRgghar3L5w@mail.gmail.com/

Cheers,
Miguel

