Return-Path: <stable+bounces-206037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4242CFADFD
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 21:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA6DF305DE7C
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 20:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D462334D90B;
	Tue,  6 Jan 2026 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arhZVoBL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4634D905
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729693; cv=none; b=XAtJ00gzsHjJaqVQ0kntHwxCqfnzRaAp/rJOFec3rzefQxE2cfqL9u1oJcGgQTMgcb1rHY7xy3mVraTskZGWjyXpGJ7Hg9CeM1r4+cjQK9FUXDhYBhaaYY8oJMQghnwT8NYTeX0MoOj5z3N5ma35WSSXTnWbj7nqj0Tk0aHdjjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729693; c=relaxed/simple;
	bh=Dt549mrUZstAPsKfNJENULJYrTj+LZJNEJkKzB4AD+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZJtb4LJL1TwcVS4E/cybbgPEWaxcemdgX9Jh34ugB5CcTcf6YrcGCgTQyjkS9RnIBXfEWfCR0TZWxI5jYmT58IEe3sQS9b5X580OdGSNmab2kDBeNPKJjwYtkYKCq4kqH8BSkycB9v73LTIX9EtiJLtusSGATjLN6HU956NVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arhZVoBL; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-11bba84006dso73512c88.2
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 12:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767729691; x=1768334491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGV7wWt6S7LagMiDdKmY0Z14bkvoMGG1QHstzp9zIvU=;
        b=arhZVoBLSHgyTGMK9QVm2AQCIZwQD4vy5cAY098wwqKgp/q0F8MWG2fKjT14dRo545
         2FMF8jsH2lHa4S4HB2iQVCXaD5s1FAfZemt1Fh5lPipLJnSduqsNLFHetw3I6hh0uHXP
         jc+KMaKG5RztFIzYHjn1d+zCqyyUSf19LSY4iNjjgYEq13VokekR3wirv9lQ98QLHRcn
         iQ+4AaokPEewUD3xyAelv/bs3PPdos7PXcfHk967D9Af3CYkeGYXrIpeTAwXjZE4vAb+
         tytceeMmm3IYAfF4QVeeYJ4yraQD19QMUz8vxir3RJpQ8+iUi7CYiqjWlu2vXcPRmeLz
         BVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767729691; x=1768334491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGV7wWt6S7LagMiDdKmY0Z14bkvoMGG1QHstzp9zIvU=;
        b=H2gl/oSXWgtkZb0vCb5pspiYgOlDlBm8MATb2b28oH/N8UBmxeOPZuJJY4232Pwiye
         sRhS3wehOUsCMgdF1RcAvC/fC2hvWZJo72i5yJBUpr88mw5P1RBICoDBwExQuNj2IxnZ
         cyRgIPKCvQEVdUJgyaCsM+z1sbYK0fyiFwjzMbygsChqsGuFP2NvezXle77Y62EtdEX/
         CqxKsUsqyAmvUHlLJi5WJHsg46a9I2ZAxeYDQZIdKhuGW0dY0IMgAwhDbI9MFQQM3IUA
         nPEfhw2adkWb3Q7l1/6n0jnJV6TMNPpLUFogLhZSanktiJ50jEw4ulaoXeEBuafzHVAX
         Z4iA==
X-Forwarded-Encrypted: i=1; AJvYcCUumks+sjAqz1U+YIfwHZuyfGzzuzMJKLCr7ZVZeiXx5XwjdZF41kSlSBXMDG5ZeyYI2msY/sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8JsPw+E+VSIMJWg5SWUIe9SiXxq9pMF0nCJTUpfDVMMH4UHhB
	qsL3l1EZYtNyP7DXhx3Y4Vg2kwcpDBuEUfU4NPSMhPVfxYlNR/7DzbINxPdQLBzYDfUSNyo5Wo7
	Ndr+sIxVpcJfFdWoZT41xDPyc2pWVass=
X-Gm-Gg: AY/fxX6hZW0NVqrH27N3BmB7qL+SCtC4Nn0kn8oWQRD615vkGBDZCU5f3KuTj+4RvJn
	lN4oKgO2KnG1SwvEra1VmzrBlvVJX+Fde/s/X2E97u62xe0rnhSuo3Q/dao9SLY5S0kWp/B4zXd
	Bd+7Iufl2orWyN3Bz9E7yCtj3EDjece/LfMPgrmRf3tsofYOpxmwuCBRvwWfl+rzdLOAPf7BDZb
	DMc8JJJHq1ukCHCHYPHXoRPz+opkAVm01Ijt69EK0Eln4SD5hfchSlduamaqP1sprOnuVYdyq4H
	NCinRLW0apUSOMcNLntcl1NFISORj7j8v2Mkmre8IzfjCpC4dymxX0Q31zoB6wTmWvhgIWgYUj3
	YtwuSxTOcBPCNQJtm2mhDtoE=
X-Google-Smtp-Source: AGHT+IFSOhN+iUfgS/YG/37q1BSianexajuG7E+qe0vvmDLBMRpeuPTZXEk52DW7Gun6xTN8IE9bafugRgUlxEyPQ/Y=
X-Received: by 2002:a05:7300:33a4:b0:2b0:4e90:7755 with SMTP id
 5a478bee46e88-2b17d336a74mr28976eec.8.1767729690670; Tue, 06 Jan 2026
 12:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217150010.665153-1-siddhesh@gotplt.org> <20251217224050.1186896-1-siddhesh@gotplt.org>
In-Reply-To: <20251217224050.1186896-1-siddhesh@gotplt.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 6 Jan 2026 21:01:17 +0100
X-Gm-Features: AQt7F2rm2cIt5lvkOzP2EUWMGIAmjTpl6PyZUhg_r_Bxlk8y9aFK7bw2z4d2xAg
Message-ID: <CANiq72kGFOHOUjjAmjO7Wn2phcqKiwFG2UdXDu+uwoxJAggTGA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Add -fdiagnostics-show-context to bindgen_skip_c_flags
To: Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc: rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 11:41=E2=80=AFPM Siddhesh Poyarekar <siddhesh@gotpl=
t.org> wrote:
>
> This got added with:
>
>   7454048db27d6 ("kbuild: Enable GCC diagnostic context for value-trackin=
g warnings")
>
> but clang does not have this option, so avoid passing it to bindgen.
>
> Cc: stable@vger.kernel.org
> Fixes: 7454048db27d6 ("kbuild: Enable GCC diagnostic context for value-tr=
acking warnings")
> Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>

Applied to `rust-fixes` -- thanks everyone!

    [ Details about what the option does are in the commit above. Nathan
      also expands on this:

        Right, this does look correct, as this option is specific to GCC
        for the purpose of exposing more information from GCC internals to
        the user for understanding diagnostics better.

      I checked that in Compiler Explorer GCC 15.2 doesn't have it, but GCC
      trunk indeed has. - Miguel ]

    [ Removed Cc: stable. Added title prefix. - Miguel ]

Cheers,
Miguel

