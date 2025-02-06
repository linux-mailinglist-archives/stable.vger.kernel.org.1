Return-Path: <stable+bounces-114184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A24A2B66F
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 00:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA5D818898CB
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A6122FF3A;
	Thu,  6 Feb 2025 23:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbEFh/Q6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A11D9A66;
	Thu,  6 Feb 2025 23:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883533; cv=none; b=djbX9njRDoZyNWg8OzlETGAGIEmG2JKAlAfL2lMJzZ2xsaXOvzDJuxcC9T2tN05iihZgmRgQEwOPj62omU7UtehhRXzJmLzbwZCMUEXqA59ThFSVG9GSy4o8mqre/tkhrPZpOAxQ9Q95MVciaFS/SaHgD7f9c+tvV2Uwj+/vNvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883533; c=relaxed/simple;
	bh=T0Wj0kmg/cSO81RHPcQC5+556wt9IZ2fZ3r/H844l0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aHak9jF3DPMNTSRvdvrCL3NZyPIjBxHoH6cwBejclgPz4ZJOht1vAUTnwGNRNc2vYPJCxskJ2Hkn545SRhgf7GG5bQzAr82e94LQanA0SSe7GN4fteu+AYfa701qnVnnHbb40TIz98bTl6nu9L7Ha5oqGobW2UYfELn/4rDzs2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbEFh/Q6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f45526dea0so292308a91.1;
        Thu, 06 Feb 2025 15:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738883531; x=1739488331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0Wj0kmg/cSO81RHPcQC5+556wt9IZ2fZ3r/H844l0o=;
        b=IbEFh/Q6AxPXCSeNRpZM1yp71wkHDqg/itKbYLjHPCs9JBvSe4qU2Qe+AyLRFQUATi
         UdZuiGX/OICAQx/e70bbqt8e5bfrIe6ZlKqEXldqX2pINWimJZa8/tN8G/57325o5jhl
         zrOgFK0Gq+zzz3aj+s/n+rXvHZHwDmqoxlxJXV53A2XIdtW1trpwVIqUfyTRJfTI4rCO
         8s1uFzFziKQKtFky+IRaWxcyzk77WiuZLRuhpDCuBJWI29XKpN+43Cn4KD/K9Ut2geyz
         uvnOA8wJMHuv3P0ApqllKwnuxkLFzaRdN+BVPXAcVPJSEAoryc7khRhCk8+eYY7Y2utA
         Ly9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738883531; x=1739488331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0Wj0kmg/cSO81RHPcQC5+556wt9IZ2fZ3r/H844l0o=;
        b=wgP13LYOd5/vPQivTE6tLJ/8hNgVrixaa9wUb4fwWtMBeVWQeMJQd96J53bEKLbTiD
         GLAVRhp21pHaHHsh9KqI4brdYac/x/UC+Q8Xkg4CbiGfi7JwrTY9k6bbbcwiIt7pPFv0
         SeH/VtJ8n9J657pPa0modhX8NvxfFSdKQscR1QLJFm6+1f9MPZNKijEsgsnPEMdctolp
         1/hgCrQfih1uCSPBNFvJa324j+xOYV/jAphKDMO1vS5zvoNtePv6UnrkDLyOVuUlfmbr
         +bRZ1w7ldoAMGXlv6yuru2TIxqAO3fdEEV6TTJl6JdRyqxT/p8sETx2O6+GHSPZHbVtv
         xewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKr6rFzERhkQNHw5E0DizIXwmxPO1AmhPsQMMTuLV6bqDppNCEgQuYbtsSxpWbQYGoisqs2ffC@vger.kernel.org, AJvYcCWJhkeNKrPAiV1ftm3M12zLr97Ol/xYkU5htYMu0lOofqIObSUvWa02aA8HV0e0ooS2krVyleqb7hwRhW4=@vger.kernel.org, AJvYcCX6vKsrD6hf10b93RnGJ6TpR/BHr6yd7/SgCf7JxpSJkILLK0c/LBQpz1yN1Iqd9p8zEpYXCjxHNd6/Lg23w64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuxHBRhdh1263oQZaV41Scr8Z7T37af8AxdXI929L4Li/3AcJx
	dI4tt7m6ph/sLEg/zKq6yhOJJNpx/diwBC1tLtJ+0UhdaZmvIoiLIU3Bldt6muyNg2hLTCrpB2R
	wbI0gGYcOSlKCBGtYXsdj93EEbc0=
X-Gm-Gg: ASbGnctbFscLInruYMuq/qUnshmO5VROf40UlGFKhXAR6unmE4Z9OxKv59Mr8MtITrK
	WXEdzr60Pf6IZKmZISpeAwkc4uTNob+q+TK/dkR9ivgoL9A9bheA4veSvH9T4mVJD7qL1AgbO
X-Google-Smtp-Source: AGHT+IEirwjMb2+Tte/ztOzcJVc6rz5/I99KNyU1w//C/vKkgniRyBjJrBeJwRRFR+mH2QpV5DbHOFYSgB6R4pJZWfc=
X-Received: by 2002:a17:90b:1b44:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fa23f5ea82mr562072a91.1.1738883530889; Thu, 06 Feb 2025
 15:12:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203-rustc-1-86-x86-softfloat-v1-1-220a72a5003e@google.com>
 <CANiq72kv_wE_ESNsW9qDiwnJkaoFb+WERJ6p796TCPAdK838Fw@mail.gmail.com> <e60b9d9c-01aa-4a87-8701-d5f18a5f4240@intel.com>
In-Reply-To: <e60b9d9c-01aa-4a87-8701-d5f18a5f4240@intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 7 Feb 2025 00:11:57 +0100
X-Gm-Features: AWEUYZlN2l6DrxgrKrDDZ33vCZBQLuGXYij2RPkQSeOXJ--doc7yq3sVTxPUKS0
Message-ID: <CANiq72kQhY8fh6tu-N17SDqEoz27-f6HXOTLnuua7FFKdXPT=A@mail.gmail.com>
Subject: Re: [PATCH] x86: rust: set rustc-abi=x86-softfloat on rustc>=1.86.0
To: Dave Hansen <dave.hansen@intel.com>
Cc: Alice Ryhl <aliceryhl@google.com>, x86@kernel.org, rust-for-linux@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:08=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> First of all, thanks for cc'ing the x86 maintainers on this! I do think
> it would be best if you take this through the rust tree though:
>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86

Great, thanks!

Cheers,
Miguel

