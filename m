Return-Path: <stable+bounces-247232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDqiIQ7oBWqPdQIAu9opvQ
	(envelope-from <stable+bounces-247232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:19:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1275543E9C
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ADB930FBC40
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3044D001;
	Thu, 14 May 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flAQ4QHz"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D046428830
	for <stable@vger.kernel.org>; Thu, 14 May 2026 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771417; cv=pass; b=Yzs/tq+TSR1jCJyTin2SPAw9/W36Whw5B82eWqz4XaaHD4oE5xW7rJyTH/xkOqlxFITLUN6il1q9r7xjmnUREL77omGXPXcENwKRC6FXf3IggKsiaGXotKWEcJAZg70bjQPyoQ0hlbCEgltZHizn5aNYkOyWmae33/CllkQZ0rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771417; c=relaxed/simple;
	bh=Q1xiOWqnVIIhtfM/F9I+pHsCAuyVu9lKNInWE6ily6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blTvg6YWviF4V4t16RFl2D+SnS/AJeCyZk0Ky1pXzsK8dncTGHaAv4aIdSOGUR2ivP86cqsWVLr59nlzm/MgQoRpHO73BAq5RwfMi5pBNovpJPajz/6Ms/kKtckmEPBiV8JBnZV8KSl77qtaDtAId7zfQ5cQ6acF/95XjQq8z0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flAQ4QHz; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f1b00a75ffso567578eec.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 08:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778771408; cv=none;
        d=google.com; s=arc-20240605;
        b=R0Mjhe6cEv+bXqmoGP8ma+OOBvkb3gtapFT+PYLRewcOus+V5VN2xSwGo1C0oLCs8B
         iyVEMB6L6ZXczHQM18fZs8gHNS7N6lz6ORehHVXqT3QAua4JCCHzPp+vNItZBWwVgsS4
         CrcaUBwzdcm39pm2wcxrRxNNp+4vnYsBXHI4vyH2v4F/912lrbPNpAHMRucrELYM15XA
         EQiJeSJ7I3wMR/mkf6txQmq/9tJgFLhTsX/lI2ACKtzVzgvYy584ghGVhWjqMBBsp0Rw
         5oHhSOj3EfxdN2snCfCNwYW1aw/JrszoGY9yOe3akKRd3Hnd/QxZS1tUOV+h0hHstiVY
         vWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RkPjqCzei1qs4lsLRpPYWOszzEiBZY+5+KZ0A6n4vY0=;
        fh=XXe8NHSHbi4gRQ1glEE4IRcffawLziZl1kV+uvT697s=;
        b=Sx3eq16Fj3e4tQ1i/SAdzBPH6JhoApe5F96tojPK0TPs467YZy+Zj84XNWO1jQic8G
         as5gDrgdqFzammZFlQ0PdsodDEPCYaqY9eKDnFAqbiul/8V9Ku3Vf6xbLq0D6pHelrzA
         5X0UGT1SxowMZAVURZIBM4ermoELKcxdgpGrNt0H+nnE3TzsROmjBB3CM8OkLwal9Z43
         runyReJ34LFVyCbTm2ge4Sj3T5O0X3xDw/0Yw4cRlpd4Nb00Z668/0xb1/TDB1Qx0Coa
         y65gYxJhArPWFWPJglSKCjLYEjKI7jE3A8XhrTdHSRkeCEqKJrOiKtk9DBOAj1xF54wV
         ovTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778771408; x=1779376208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkPjqCzei1qs4lsLRpPYWOszzEiBZY+5+KZ0A6n4vY0=;
        b=flAQ4QHzTCGylk9SqVDYtWVqzRwfqjNXoKlTmG06+XYjI0IKpncg1gpeLw/eoaXL7R
         rbXvfHtIE31JSTpAZjKK5jhK7Y5PSb9hmAsdT+WrWjNzKO4wCwPlT4L4AEKpkR6sktUZ
         Q/yp0SUypaeiYr01bhkagq1PGG65h1xs+WHi0kc5VTzCwFc3EMgSaTG8qgeJ+O8y9aBH
         pw0cbid/xsk7qvPl6TWMJcCctfic6ryIHar4rHAJwj0C8tqNVdISeqjzKe2Os8aYeGBF
         q0xBxsjOFJXWMqWwYYAV9su1JZQ/zD5vXppiOeNxiOYZwjR138/HoI924de97WE4adnh
         98wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778771408; x=1779376208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RkPjqCzei1qs4lsLRpPYWOszzEiBZY+5+KZ0A6n4vY0=;
        b=BwC1/VRStPspIHDKEg9/m5bNvOIZMV3qKKWV6f6tfljPpx4VXN3AJ+0Ac7vzXyVuP6
         NGj4d7kDtwyM5yxK9SMQWsBvgKqei7wV2e8hMl2Vh/LKXlmzRN5IRJuL/3BpiKRnXiqG
         76C391YB8j+hhdo5zdfIFwSDB+XeSo0e9sZhTEhr1h/t09K/RWByLPLhuUxFI/lElIMO
         ntWbkIRxv4gMyvpxAoHNmEc/EZA9zHcyRdS1V6x4zFwUcH5YSAgvMMJKYolH8eG1YVtc
         iKxHsmLJdBQIP6Kbdy7u3HFynz5g2jvKHcPvn0L8DxeRhFhT/4j2auunzZgF+DBQ/4U7
         3a2A==
X-Forwarded-Encrypted: i=1; AFNElJ+vvAEv3/bXd6VLUXm3i285PrOkpLILZqqk+1s1vrShKFVzEYTmu2eTmCxbMuvFWow/G+8KEMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wUi3ilkTtJJ8RhQuNdOh0MxadscAf+WEiUVeWAyyri+CbSrG
	i0VFYk1Vs3S1o9kkrEJu8jELZTgyYz20mGf1x1JT2lUx9SKoxDPmW1cXS9WOmihWKh8lnSDd51X
	wxtB04RqWJDwdCFhpOuri+hKmdyjGMN0=
X-Gm-Gg: Acq92OG9N4PqzT0ZapoHIngDMGPAebDUxag0VEVThokoawXNwQbc3VyU4Dx2Rnh8gYn
	NzTjmFUhkKhe2zZ/Tc9ht3+SPDXu+1HZheHV4bgz4w0tOxsFo/NlMRjSKmzu4K0r8k1x7w5u6bL
	5bJvYTbzeD02o6tpatIvGlmzH1Mhl3b9+APzM6wTcixnvbQ/g/l9CwIKbSYBahviYsqb+v+pZzS
	NYahHfXeyDeHMue4yEzXeQF+F7rSb353vGNJ/mExYLeJV0S1pGxJ+I5MW0KJnrFk1hkBVtn/lzK
	Uo/xu8Bm4w8ophMp2Dm5DSD8EAttMhdCCI6MUupr0gIS1q92asEFh/5ON6Qr4QpBeyOPqRM/mLP
	/1Zje3JMVTpFBl/2ULImofFg=
X-Received: by 2002:a05:7300:2150:b0:2d1:9b35:4f03 with SMTP id
 5a478bee46e88-30119a739camr2362416eec.5.1778771408152; Thu, 14 May 2026
 08:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
 <agGRnHVTLiwobb9W@google.com> <20260511090943.GA1029560@ax162>
 <CANiq72nm_3KM4gMnb0x34oJk1+_8XrUz-43zwW58Mr1UHG8qtQ@mail.gmail.com> <20260514123539.GA1781775@ax162>
In-Reply-To: <20260514123539.GA1781775@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 14 May 2026 17:09:55 +0200
X-Gm-Features: AVHnY4K4FPfnCtiB6KX494dgF2K9qH9aUDHSKjAUM2cHs1-ctz9GH5wRqeeAVhY
Message-ID: <CANiq72nZ5hW545-k1jpjR=tbEuKigm3fBcVhuuafCmoYPZzq7Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: Do not select HAVE_RUST when KASAN is enabled
To: Nathan Chancellor <nathan@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Russell King <linux@armlinux.org.uk>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Christian Schrrefl <chrisi.schrefl@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E1275543E9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247232-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[google.com,armlinux.org.uk,kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 2:35=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> FWIW, I think Russell has been away dealing with personal stuff
> recently:
>
>   https://lore.kernel.org/aeDSTIS9-TDSihbX@shell.armlinux.org.uk/
>
> So I doubt he would fight you taking it, given that it is Rust related.
> I am rather selfishly motivated to have it picked up and merged because
> I have to remember to pass KCONFIG_ALLCONFIG=3D<(echo CONFIG_RUST=3Dn) ev=
ery
> time that I have to test arm allmodconfig. But don't feel rushed to pick
> it up if you want to wait for a formal agreement on the path forward.

Thanks for the context -- in that case, yeah, I will apply it to avoid
you (and others) further trouble.

If someone shouts I can take it out.

Cheers,
Miguel

