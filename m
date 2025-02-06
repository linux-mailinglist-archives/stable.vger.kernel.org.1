Return-Path: <stable+bounces-114166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A71A2B1C2
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB281188542D
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D61A23A6;
	Thu,  6 Feb 2025 18:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6b0357/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B41DE4EA;
	Thu,  6 Feb 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867919; cv=none; b=mgyL7e+sz856R0cwLuA6iHbwq2AswqEcBLDq1FP+KUPHkig/cmwknpc+iWXIi+SLL1j9VIhFJmik3K0IoRWS4MIs5zdsbWsGZeDbCGNPyB8xT8G0DNdmuXL0onHGRBghj7CaVexunH02dxhXnAbM2HyHhgeqdq0y55FawnBSELY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867919; c=relaxed/simple;
	bh=Apls7xlXpI4BlG2F+Xa4MPAdsuwb3kTPYtmLlbvU+hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVfe95rAL7YeVHuK/tBrGrQKefqTxcioDYZ2RTOS2j9NbGHg4vKAenrcBnw6RRk/2AnGt/diXC0C8uQOV7MtEJsKEy1bmiFlZUtWzh7KvK+zpwbj1WjWVDew7Kyv8O8VbvRY1N1TN/edSQxufUOhbdzvZXyiwwbU0kqXngdaHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6b0357/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216406238f9so3088895ad.2;
        Thu, 06 Feb 2025 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738867916; x=1739472716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQDe7d33d+8AbbWFyoGmO2lz3zYl9Xdp8K24tZeJFrk=;
        b=J6b0357/mvQiC2YWXnIKisuGd1tDAIm9/BriBCnjIH6N7vg628LR3cMDOrf5jg2X9c
         87erRpA/k6vnX1B7A358XrM3jrIrV4arnoSTZb+4s22RHoveEbJGzbhSKeRCG2BZrr4s
         pSpZIMIhpjg0Atwrw1Nhl0eB+I2eOdCD6mq+hia0Iwb7WYdhdTgHIZ4IC3XTk+Hh29p6
         C4QtKr8KQuoH5eJcpAJUjpS8Val/CpByh2AHkm2XJcmu6E98Db+GzKfyRUJ/OsgtRcRm
         1UXLq2+3+daEOcXuFEvWXVqGHQRcXJI6T/PltKXqdaHkAahHsbCVLAMIuxtM2DSVz3/U
         grFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867916; x=1739472716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQDe7d33d+8AbbWFyoGmO2lz3zYl9Xdp8K24tZeJFrk=;
        b=h67HNkJwq6NEWTEZ7gNvO9RXS9N2X5KhPuiBBJu0CUwCYgSKo+SGc2lpCpuYvd5P7o
         jcYq/IpbsSOVvNr3ihBOB86iOOyMh17Uy6DR87WYEhAbC3YgKaTPUvCAmW2IPPi7gRi2
         nOX+TzEN8VkrGC0Ec/pGGR6OaBnTejsv79EIpDrVk683Rw2ZH0S17vFatJ/BCeTXjYWC
         HH/AxnzAeLQkesGfs6nj4Y73aZ3yD1wayaeKqmVn+lbc+0rXu68XOgyO99B7XgXXAKt0
         l4unbWT5EKSCYYGa/AAedSqidfuqoMah1hcPCQv0ZrvKnW7vFh7oYCrkcRbXUFbAmuyn
         DHMA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/lIihLCaE9TlF4DJUGjEiaWKMScfXK17SDk+4Y/UdVEpySwAzciE02aIE+oPmqAuN4tLQIks@vger.kernel.org, AJvYcCVjZBOmmnAMcWT5xr9kavS2dHiakETfNOnuvKZZIVsdi37j1akXTHjHjXAiU6BErAeweF5lgyaojKSK4nM=@vger.kernel.org, AJvYcCXUFeCZjmKf5mqg/G1//IYs1rABK5VyjKCTJqkRNnuIbFxz0sAyYH1SOzPEHoVZavzQXGFA9bnXumqJlckh+jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVV86uuI9ZmJRopSLHmPw8d6/h/hG2hVYODv2NWJAm9hhqwIPO
	JYj7Ihx9Ae5HpJSvsQUqM55Yr6kzbItAKQVRpRuMdbs7hmrYXai8MYcUapX5h9bmenw8Ab8AZq5
	KV+Ka+rmV5bpi54qE0I3DuxIMUPs=
X-Gm-Gg: ASbGncvO++8n/a61KP+Yp5vB0FBHVRYAvNnFTckdUuWb2NgFnGo+lmwmIOThk+SK/W5
	c5y9wEn5Pitu1k9SGbFmgVkS6jKHiboOxgRXwRsV3+PnExuqpAcaLgMvoREtRqnZxfbwLVi7W
X-Google-Smtp-Source: AGHT+IHXyLnCF10siG1h3PoSY2AAnWYTS1Ir/xOCwCqiVyI4gHTlCdy+ATAintPEFk7FJn2T3sWetjp0FJZPhtD5RFE=
X-Received: by 2002:a17:902:db0b:b0:20b:9b07:777a with SMTP id
 d9443c01a7336-21f4e771cf8mr1088025ad.10.1738867916182; Thu, 06 Feb 2025
 10:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-rustc-1-86-x86-softfloat-v1-1-220a72a5003e@google.com>
In-Reply-To: <20250203-rustc-1-86-x86-softfloat-v1-1-220a72a5003e@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Feb 2025 19:51:41 +0100
X-Gm-Features: AWEUYZnnDjBj8aaLIlLDC8SjVdoNXjCv4Z3bXs5NTkwlAeXWYNqkYkHQw2bJDTY
Message-ID: <CANiq72kv_wE_ESNsW9qDiwnJkaoFb+WERJ6p796TCPAdK838Fw@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: set rustc-abi=x86-softfloat on rustc>=1.86.0
To: Alice Ryhl <aliceryhl@google.com>
Cc: x86@kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:41=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> When using Rust on the x86 architecture, we are currently using the
> unstable target.json feature to specify the compilation target. Rustc is
> going to change how softfloat is specified in the target.json file on
> x86, thus update generate_rust_target.rs to specify softfloat using the
> new option.
>
> Note that if you enable this parameter with a compiler that does not
> recognize it, then that triggers a warning but it does not break the
> build.
>
> Cc: stable@vger.kernel.org # for 6.12.y
> Link: https://github.com/rust-lang/rust/pull/136146
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

x86: I will pick this up, but if x86 wants to do so, that would be
welcome -- in which case:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

and I would recommend updating the Cc stable tag to mention 6.13 and
the reason to avoid over-backports, e.g.

    Cc: <stable@vger.kernel.org> # Needed in 6.12.y and 6.13.y only
(Rust is pinned in older LTSs).

Cheers,
Miguel

