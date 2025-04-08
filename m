Return-Path: <stable+bounces-130352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11BA803D2
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89E419E65DD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AFE267B91;
	Tue,  8 Apr 2025 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXXu33Ah"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE649224234
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 11:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113491; cv=none; b=UTJarHU0F4caKK/gNG3hAbEE3IrVXQxOiVe+fWRZNbROoDG3O9YqJgwkBbwtsnCegKeWrwvE9Zh9RNSZhuVBvoOlqlZAtRTunyqtjf+WqFfiCP72fW5hzyGsqFE25/sZkbUiWtvPGPUN0vUQGaI7I2FGs2axuzMTtDwQ/LYTj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113491; c=relaxed/simple;
	bh=H8PrH8DhwvVPq9YxP0qvt8ia656YD1J02D0+wxd9KKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pqvc7LEWwRP9SYPRx8nxlWgr/qGHxmpnplzfYGxS3ZuPGftCEb+fhuz4NJ+OHK68KRg6UePsURP4sVaWDUH2WYShTICj7asFIjhCgEz3DQ/0pyAjInLdDclDiF/bXmXzPneXGbx/PvRUCHGUIG0lOBPMIsmIQfaeqI04dRidZbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXXu33Ah; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914aba1ce4so4396686f8f.2
        for <stable@vger.kernel.org>; Tue, 08 Apr 2025 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744113488; x=1744718288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzDQS9SW/iaYstqoOxPXbXo6eBA2JBDZWGyNq+1mh3A=;
        b=DXXu33Ahxu8NUr0Xmq0q0bHdEduTtSrxEKscaOHfYXU3BC4ThklzB18PseHigwh1/x
         bYQQgYIQNoPiH2VMPI45okNMFqyuffmz1Bf1EBqBvrKRaD3lY5UPbVGypooS2ScBhD83
         ybzSG3aCaU5bk/+/gwi2599gnVsAsLwSUy38mDYRCGNvqmpS5xDZOq9suc63XRsX22RU
         Mi1SjgTcttJzYnhID8TiUtEFAsb2/pfbDwfMKHNx9IAiUJCThUHmWlvoF6mqEIuJt93A
         lB7mtprKhLzV9fRETKRAHCRP6iqZYR2ounHGJN5Daf/CcOyaS3qdZxDyc5pjoEHZ9DCp
         rb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113488; x=1744718288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzDQS9SW/iaYstqoOxPXbXo6eBA2JBDZWGyNq+1mh3A=;
        b=hfmEC1Z7aZ9F7I9kartt5a12Pr6vZ9vlUUP7lEKCv//aLJWDNB1z0AK1aVFuNO/Cxa
         BpYOPj4cGq/olbMIuuvO1SWKhHknhbfb6nxl5VruyNFmiZS7ZsnJ4eYyxhca5fxsxmtq
         GG/cbE6RKXl/0H/2XG1hjrve0JuvhV8t6pt3NDEJJXBZhJhcJijkm/i9bEQTumMOp7Nf
         G2HHmrVfY+M052NRO0sd6NAgUDoERagCSZf91pdTe+FSsnNj1ROaOz3SghwBGwM7T39y
         T81xKa06V3yCsaRJGof1gfSLOmqwCWjB9ukNvLstWIHQwMSHDEp7SekDjVKzw3xU7hxW
         BzFA==
X-Gm-Message-State: AOJu0YytGNL7HfKoBdT5khTI5nYU0SGyaw1/y//uU4U/Gw1Aq3ujWdR2
	MPBA61M9NdQMdUIMv1EKzLvT0gmX8iP76+daXXSKga+/mF4e8cP2vnuEOera8cq4jgJS7qWllf2
	qB/cBNlSFB/ikUuir0c7NUj/7pJB0RH2a/zcp
X-Gm-Gg: ASbGncuvCVXYPlXeSm3HFPsbiB9wADD+5jxsk4uNO0+D8f0dVVat7FqD+ZUqDkcACAZ
	Pcv+LDvU54QLkV4bskmZMPucod/P5nDAP1ogSkkM8n1dofDyIIbq8rq52fK4FtG+hh1b/8Sh2XR
	eXCSNq5HLQaWsLmC5lT5w7K9MTLft41ho5IoG+UijD1NykmoO7cjnue8yF
X-Google-Smtp-Source: AGHT+IHR5+3qdcDJjtKctI9kDCAeB4369y/zP0yo1fjwF8QoixOqRlbbyym+GmWvivti/4RxoDhijpZ0LI4xTLRTKZo=
X-Received: by 2002:a05:6000:228a:b0:38d:e584:81ea with SMTP id
 ffacd0b85a97d-39d0de67ca9mr13977845f8f.45.1744113487958; Tue, 08 Apr 2025
 04:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104828.499967190@linuxfoundation.org> <20250408104830.890872754@linuxfoundation.org>
In-Reply-To: <20250408104830.890872754@linuxfoundation.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 8 Apr 2025 13:57:56 +0200
X-Gm-Features: ATxdqUGe8bFOZvLuWZ__R6jYo-U_e2Seu4Hh30FmTWVbnXMjq3AfKCGDNREEkCk
Message-ID: <CAH5fLgj6SEKy1-CopXTnaFWK6WFddP+ahccf1_MdabpeCuB87A@mail.gmail.com>
Subject: Re: [PATCH 6.6 089/268] rust: fix signature of rust_fmt_argument
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Tamir Duberstein <tamird@gmail.com>, Petr Mladek <pmladek@suse.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:54=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Alice Ryhl <aliceryhl@google.com>
>
> [ Upstream commit 901b3290bd4dc35e613d13abd03c129e754dd3dd ]
>
> Without this change, the rest of this series will emit the following
> error message:
>
> error[E0308]: `if` and `else` have incompatible types
>   --> <linux>/rust/kernel/print.rs:22:22
>    |
> 21 | #[export]
>    | --------- expected because of this
> 22 | unsafe extern "C" fn rust_fmt_argument(
>    |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
>    |
>    =3D note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *mu=
t c_void) -> *mut u8 {bindings::rust_fmt_argument}`
>               found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *cons=
t c_void) -> *mut i8 {print::rust_fmt_argument}`
>
> The error may be different depending on the architecture.
>
> To fix this, change the void pointer argument to use a const pointer,
> and change the imports to use crate::ffi instead of core::ffi for
> integer types.
>
> Fixes: 787983da7718 ("vsprintf: add new `%pA` format specifier")
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Acked-by: Petr Mladek <pmladek@suse.com>
> Link: https://lore.kernel.org/r/20250303-export-macro-v3-1-41fbad85a27f@g=
oogle.com
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

> -use core::{
> +use crate::{
>      ffi::{c_char, c_void},

I don't think crate::ffi exists on 6.6, so I would think that this
does not compile.

Alice

