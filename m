Return-Path: <stable+bounces-124548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361A9A6365C
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 17:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37A0B7A3FFC
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812251A8F9A;
	Sun, 16 Mar 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVH5bigI"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF691AA1E8
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742141600; cv=none; b=IQriEPuIBAz8SpZQzn6gvDoKVrMrZKs2GmzNxkmS5kPb3b/Juu+MGznVzTCsYFVxsI5v5HkI+O1bhZZxtI6ksTB6RH3CmIfXoz3T/6+hGzSt0EHjEoKynDgm33rMbIk+wq+REww91vc1F3R93dD3Xu71TkgH2zbU9CUo8OEjueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742141600; c=relaxed/simple;
	bh=upvIXrSljt0iUZKDph1FQjoW5B718kLphHn3W48FpyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6uIqN6X+cwWcChqOqot872P92mTpEPnDL0+AXSdKP5iw9a9rpi+IAVVhksB0a9ct0sXfiae0ivPUkTTauzPUNl16COL9py2KoHKHu+OJBPV4uU4kXJj9W5osQuyqCipnndONKvEXvkgArevgDCuznAJXr4MdYHFJPFaZI8pyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVH5bigI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-30144a72db9so411088a91.1
        for <stable@vger.kernel.org>; Sun, 16 Mar 2025 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742141598; x=1742746398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upvIXrSljt0iUZKDph1FQjoW5B718kLphHn3W48FpyA=;
        b=LVH5bigIL/RvhRqjmASqL8Xtg7/yp8JYPGOs5d+PCQZQpUQX781FuVGgYX+QJCdhQU
         PvYcHMipPJTK9l72DFt7ec/TouqMgtaDJtwqume8MKj580c/D0LpTzXIT1Voi/GBWOOO
         GSxCAaW6u5liUgmZOqio1MZlQ3LsjA32Wby6FUUtrxTtjSy26FQCCn2Czc6zZsDpG9wt
         JxvQrxluRFxpkIOaTEbAump7pxL6NJKUzrNBNBXavFPltUib39pSjbO3RUxbkvMxeYVo
         tuMCcN+Xptjl9JsVXzY8Etq+okL7ZBrSM0vHt3PybAMzj1FHULbFlr6jE8RS3L7Ho5dB
         PxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742141598; x=1742746398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upvIXrSljt0iUZKDph1FQjoW5B718kLphHn3W48FpyA=;
        b=EUmPF69rBSvrUdn+h2Fgc6+1hD3JalLK8dI9E+u0WD5pgQyo/j8EiGUehNWtkY3hQj
         PUEusGI5/4bB/cAhWKtSFtlBjFWfbpjukrTXjFx6jq9kus773jbQU/K+w99FIPE4ZJnv
         dVwZz/qwXI5NiyulJW8WfBC+qKTQ5GFBFx81hKbi2awVBZUZp34H8F+zNaZKLOWs1w9h
         gm+IUAOpYJNZBCq6eP2hSbaaSjcKpKSv9my/sHUgaxvrggbveLuUCfzhDdYXZja4vFdG
         LfeS+8PoGJWI8YbSk2Ktsj5co/ATW4R5cciHBp9l/DNdm3m3e3SRKE1MVpr+eUOr0q5U
         gGxQ==
X-Gm-Message-State: AOJu0YxFd4JJVKL12xLhqOBgqMumH+UQoV+ehAclquqGicIs6NheZ3XD
	QcFEWf9FN5APBLKsZfMIhYcO4LJna8kNb0Az6sp8aW3Zl71I+5niDe2UE+ZAJb/LZNJ4x6RdSuq
	OMnxfJcyFAljNY54hU2G+QwtEf1I=
X-Gm-Gg: ASbGncuaTbAc0fm2/yqLofLrFGo1Qq2KGYoyLiQnWEx5eyRaW1NFrFewaQtCZpXX2Es
	AeOgDUJ9tWIQqs2N3ya8bSiYACNLQv2dy/jWrAIRJMBbkhFyrANlu/rm6Tlwnwycnl1CWNe0V8C
	0jRAqn5Qx9fTPP0GTqmuhpK/rdIA==
X-Google-Smtp-Source: AGHT+IG+B4RF+F3X8yXmVELh2DJEjthR6kqaaNBUSRnp3RoYS2FViRlP/0PFfwziv4uuXdRVHlfnWafY99wY3Xzf37c=
X-Received: by 2002:a17:90b:1d0e:b0:2ff:682b:b754 with SMTP id
 98e67ed59e1d1-30151c5f223mr4406698a91.2.1742141598169; Sun, 16 Mar 2025
 09:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025031635-resent-sniff-676f@gregkh> <20250316160935.2407908-1-ojeda@kernel.org>
In-Reply-To: <20250316160935.2407908-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 16 Mar 2025 17:13:05 +0100
X-Gm-Features: AQ5f1JpE9fZMERG5cBzkfQur08oR6MKtilsrU1RRVx9IaPmnHAH_xtuR0ET3i-g
Message-ID: <CANiq72mEexdcTSCJuc5SMwMQ3V+hLpV623WEqLNNB5jVRxH+Nw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<Box<T>>`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: stable@vger.kernel.org, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 5:09=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> [ Added Closes tag and moved up the Reported-by one. - Miguel ]

Note that this is the note of the original commit -- for the actual
backport, I changed `KBox` to `Box`, and edited the title and the log
accordingly.

I can add [ ] for the backport changes itself in the future, if that helps.

Cheers,
Miguel

