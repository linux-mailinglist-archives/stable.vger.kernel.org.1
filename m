Return-Path: <stable+bounces-247296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEAlKLdZBmqhiwIAu9opvQ
	(envelope-from <stable+bounces-247296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:24:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A9D547C01
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA832302B384
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 23:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3FA39734D;
	Thu, 14 May 2026 23:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhQMOaWY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311B13921C7
	for <stable@vger.kernel.org>; Thu, 14 May 2026 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778801063; cv=pass; b=C6GPPx1ds2VCjTk9V1xNNKyC7hRmzqA6Bm1bhBMV/NAIRXeQjqkp6tekTbKKBuD2T2MiVa/95iM0iOHvNGYnJZyeSRNO+drI4APQA++k9UVtQzOrhtzUsbTvovSzgCujey0tcjICddDrkaNGtHtttGWr72+b7gviaGpXBZQYqWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778801063; c=relaxed/simple;
	bh=m8ZYJsMvzzzpQCdZHcn3IBPYg93Sd/wlXf5WcdxvF6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kuf6/pWgawulq/mrexTefik6HwKTtAtDnWrtYRocm+4zrewnv8bBv9SyMmwRhwgFNDI9XlgqdhvMVOILnOUP582YsB5L7zBWdLnJHoAutwKBf0JKCZCF/9y0HaVCxpYKZo1R6NLBPmmxG1j/eigb98ZrnWHIsCqIR1zlquli4zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhQMOaWY; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f13ae64db1so333508eec.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 16:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778801061; cv=none;
        d=google.com; s=arc-20240605;
        b=SiVKNxkbjx22PrntZ7JxmV4gBj4lV9nhQV6vPCKbtIkT5IvVzqLGUxt3qKCAGLIDlv
         0QO+Ql3Orvs8Y1Wt6JSuCJR1F2ui95jRIn8pAwK3wGCasxmcvkrEKSl5qzv1KOcvSTm6
         7pLkDv4NvPHUHZnwaIr6o7Axl2eRP3VLMJq5S0HiPF37IKMBvxagrwSMGTzmVGeuO4EA
         67UPirSCPF85G08PbGnLfm5hf3UtWctubCiJ24X/OWMs3CfIKixFzD0Y0f5V83hxCFtI
         kQowLt6ZTwtAVjSH1WXL9zecDAqrA7gNrXUu7mtTpvcfoJbAbi5ksr9D17JX2qN+j7tt
         ahvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iCrvG6gDvT6q/NN1t3exob8czfIU3adNxBT+Aa2Lpbc=;
        fh=yP2jBl/ocym6EFaW4MYgG/T6rZws4M6kKrqhAyp9/sU=;
        b=VPxesBYrsgQF317f+YTDjO062MzmbFjZzH4ts8TOGp1o+KMwHwXAUsrwS7sKBXktl3
         2O95eLI6n07K6VanEpNs/IVYdGhP+idoJCOCTPI3DoY5YCCM7/WGZDhGBBt9DR7VJUyE
         thGoB7MiRjVi0DrK9JEMSPIt3LrFk2Y6Np9no4Bws20WoKYfhapFLaswLEbShqNE79kS
         U8/EAsMjAjx3K3t3cNqxeHxehwF+iE/ZlOAWfOhjWnLl+ro1W/UkJy/eABnCnijvkZZL
         mtLgwXBSeRhItaTFpe9l0T7A+rQBryHPy/5Anwc3/zFEGuUkIWFxrEku+hdAPpXbE6dd
         JXdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778801061; x=1779405861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCrvG6gDvT6q/NN1t3exob8czfIU3adNxBT+Aa2Lpbc=;
        b=qhQMOaWYCOcH+b0Eu1NY4VA9oE6PXZUu8niTeAPOpINO7O9T9sH3ygljvm1j97UT3J
         ge8JacujbRxXeSsUcp983KZnKwXdqnc8Pghk4bASxyS7FeHFFZgyDwrzLtYL3JDwV4l+
         hJWRQG4XtGw8NqX+S/a+v4+nq2/X34rxTARJYD97pKFhjYSeNb3hOPe2a/PK9pGQRT36
         oX3ybUvqUzzV1UiDZB3kDH4DaTWbsVdrBSH31gZPMlgcC+XRr7FqtEIsTGC8KYPw8Mlt
         rD92/J/oORPH54s7TixQp3SY2QM/aC0VbgaLLNdt0rjeMM7FZ78jWsusf2HKQSD9DFfA
         Pk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778801061; x=1779405861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCrvG6gDvT6q/NN1t3exob8czfIU3adNxBT+Aa2Lpbc=;
        b=DlLokPen5H+0x99VKYRNKT2f2z9rL9qecn26MFraNRHX7Q8LvR4UDYBVApmEGHebg+
         NQVsNNK0v74sfiZd1eiFEF9lJ6yw0fPILM2xXXEv5mWyUj24aeps1F3cpyHpqJaNQbkc
         g83UJP4BNo9MIqm0Vi0al+EA9BGqpXCiQMHUWkH+RXJSm3/X7/E4GbHW2rwm4rHWIyMf
         gzuBBpFDo6hXEpA/8Gx4bJ67nU4BAtU+4HoOc/xPyqbPLUxJmvNLdejpQ1t6iMaXRgWr
         VO+VArHy326C+U/DDJqjw8T/zMi6zl+IeKech9Fq9PdwwXYmFAd2hOM7AX2EkKBIWcGu
         DFqg==
X-Forwarded-Encrypted: i=1; AFNElJ9C8weMG4hC2mGoOaklsSZWISt6v8ta6zarUPQF6A/Bp/XtFKb5yXR7vR69DJP14BCfJyHAZfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0BoRNTvDCWG9oWZdTOXb83rmCdWm8eWcxpv34LlVA2ulE7gK
	ltY4mydToPy3RC+aaXTsj5h+7T82de/WmHcAQokUBVlf+oLZCVCHlbl61UzGyzFxk7hTcZkGFGz
	ODzkrjovVNgCh/3nH1ZtIF885ZSbl8/w=
X-Gm-Gg: Acq92OFWVwhS3PdnobpSUi3D7tP7kqpV5tah5qL50H9O1uNNjFgBaPVA0x+0hG7yzko
	izhoKq4Eo1UiRLJ+p5NNIkME/dBCiMb4E8oGrFpOqSOAhGgDxTN3g9016F8tzi8tB1HdJp+ZwSE
	ElPxhCdebUkSTiayeF9JECnl+ET/goWG7hZh91WwOjECkIdvLWfMpRUTqwZlCjB8BNt2qcv/X5M
	4UxUyQuD1udI8ekIx/RhRXEG8f7PtTo362y/GO9v+tKpx40PBN4vO/EXYoiyzZUcNDY+6zn99uP
	SsvfrAdGm0IcvmSeJHk2zN/dZa6dfRFzoCUdbcz4W4tDs1FvGUZwJJtpWcyfV4VlrlgC9guhrra
	2En/RxJ6wHYI9VxI+sh0pM/SJi//heTftpQ==
X-Received: by 2002:a05:7300:a903:b0:2ff:bba9:c76 with SMTP id
 5a478bee46e88-30398706533mr344093eec.5.1778801061172; Thu, 14 May 2026
 16:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
In-Reply-To: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 15 May 2026 01:24:08 +0200
X-Gm-Features: AVHnY4L53ARsjRDewJnLSnNGXHTdLumYZ67gHz05fYQmwiowdxVQQXO0c_1LPyU
Message-ID: <CANiq72n7jO2dbW=y0qqkL=qwu+nEt9DS9dYsLhWVSSLuJk+LEw@mail.gmail.com>
Subject: Re: [PATCH] ARM: Do not select HAVE_RUST when KASAN is enabled
To: Nathan Chancellor <nathan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Schrrefl <chrisi.schrefl@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 17A9D547C01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247296-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[armlinux.org.uk,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:02=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> When KASAN is enabled, such as with allmodconfig, the build fails when
> building the Rust code with:
>
>   error: kernel-address sanitizer is not supported for this target
>
>   error: aborting due to 1 previous error
>
>   make[4]: *** [rust/Makefile:654: rust/core.o] Error 1
>
> The arm-unknown-linux-gnueabi target does not support KASAN, so avoid
> saying Rust is supported when it is enabled.
>
> Cc: stable@vger.kernel.org
> Fixes: ccb8ce526807 ("ARM: 9441/1: rust: Enable Rust support for ARMv7")
> Link: https://github.com/Rust-for-Linux/linux/issues/1234
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

