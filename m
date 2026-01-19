Return-Path: <stable+bounces-210279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6089AD3A168
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 070193025513
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4A33C53B;
	Mon, 19 Jan 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRiSVeWn"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE8F33B96B
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810814; cv=pass; b=e8k0cGq/a4+fgescuBsKXrsfxbmZsosRX84u5hUiUpFAfgFiys3+iOdjGmof2nqRgAn1Ds8Nz9+i79gsJC3lveM6+ouk0qD6iD5RIlQZptI3sDgDaeAgNdhrCeCOfj6IxbAvkdVPHxQqUeC82XfB6Z2bqQ82dMKEkEjCxkiCO/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810814; c=relaxed/simple;
	bh=1OYoSnQPQ6tygAvVT+bdbhRQI7JtOGMwYUUCyliHotM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rav9kl4kGu++mLZtyxbO1HDm8Ku7M/4I9rBAcymOL3K5IkeuExa7r1iirhDEjLL/Dqf6auh4A1mtt2Pdp/xi1hN3qgmRv295doEvaYAOegpt9wujWFcPOguyZFN/3/HbqpTrE6eZ/EwZoWtkXHgaj759g52Fgoj+TwJrfjzzqX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRiSVeWn; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ae2dfd9eefso228096eec.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 00:20:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768810812; cv=none;
        d=google.com; s=arc-20240605;
        b=PKtMmvbhSddBgPn6p+9tMqK2Fp3YrceED+3ouOY+3MJaNYfwUHWrpdKsjVQaVB7pfE
         72RwgTJShZmRWd+KArQVzPca6RCuPmBQ2EG/uIIlOcpC3urrhX53vLilqnF2d6OsHoLb
         e/hJLV8x3/+IVaYulaaxng/zAIkSizMWypHSZ4Tl16dpn1nvSbVAQSpDLA1asvtVvLXm
         Qg9W/ImHegLJ5Ds3Olsolzb1cewnnhHsJquO5u6ncDhxXRRxCbvaXiCRB1oI0UTPPezx
         JemBzb9puRb3dAawp1sUfQ4EYTM7XpVWYJNQU2gIquLaMZa2C3e2ye8RugFQXquufLHV
         1DWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W4qwFK8ioKelkojLIJh2X9LVVg4pbqzpYUCaeu6PnLY=;
        fh=SqR2viI4XzbEaTwqw2ArxOs38+BBY5SSPWb7HdXcH00=;
        b=L+8qPFb1wIlHROvaPobbJv/r6EXDjOBiFTvgxG+TOEzqzY8VEnohDApyDiQX6KyKW/
         6CtaVi9XbNZFGwD40ERliOCE8ck/ZwIN4wtNgN+YxBSxP2Zn8BVOn22sLpDeRh+1PUNu
         GQQtFMFf/l8H89CtwTGtSyXrSvfUEu8f/xaYgQRw5d8KPpmYePudyvfLceSNGvrxPxYI
         dYZIWFzhgDFAiKeVe+SssRaBEK10i9gQqXfZCk6tuVRFPm+XZAuBYXqk3Vh6z+nrQk7x
         Sn03Ne4ePTJMMhp6ZfOlHaMGOCenZd2ViDAhA8FoaGV3GewJr09ghxLoKeJt47UnZV6x
         twaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768810812; x=1769415612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4qwFK8ioKelkojLIJh2X9LVVg4pbqzpYUCaeu6PnLY=;
        b=CRiSVeWnI66NeHgEmY9JPjeyk9loebw0pCNF5Rpbov0OnMVS1yPnthleOm3g765guR
         Kuc7WPFpfA86plbxg9Fms5pKQbyyj4tF5KsjiJ8Z9jt0faVj+ux8JqZCCgUWc4he+nxq
         1/mPyRUsJY6s4U+RPsDfrrXrnqxj40hautBt+Ww1pWl3hmhf+Q/WjFL721EfK3rTcJi2
         XiOhCIb23jSiWnun2C692LsTScD5FFULEVnB8aG/sSv2p4Q2osUt/xu5k6hSysaF2CSk
         SlBXEZlOV2Vw0zxHv/jUrExKt1Tqi8+cdCRXnjIPFIcCXtUqqS1CDUSuXwggF2cch/Ox
         jhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768810812; x=1769415612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W4qwFK8ioKelkojLIJh2X9LVVg4pbqzpYUCaeu6PnLY=;
        b=d9zBopapqAX1B8fgzAQ1ct2GJe3JnMGFmZqmYC6mIXVAvRmYlut7lMxhZwd/voxlQF
         dW8pSvu4Krtz/3UqnVH0Drtfqm+xfEcARvrVDuZ3dehmOeR5zhJsbZTDOYl/ZmIY9szC
         452zNRKWEIz4ERHj2mxplIgEk0HP8JgnqFHDkTxRwpwga0SFLsVK+90QMrZAXQ7Vz9pa
         5Sd70FW1t41LXoMndcUEjD/57cN+2RbMRe9GcZE8BxLZFAb4/KT9BOj5vbdiFRgoCUxk
         p7YBBCdmISFLvxlqliE7cpGfh5b5F1Iabz+Hwov0FK+nRkNY0LBv/A3gKHimhURZEgCz
         N5Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWeNCPTSz2KD3gz+PhDTDZpqJmMddgrVPBssoi5X68VqhhQrC2t6g6IcwKZ7bdbqgjMb6JMDso=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0WHDQ3AJt7raYJX4qkmqWVTiCi8qzyTcddAdlBtrrVcxHvGn
	LWkYoUkpaS5/Ou8/sR05Ii5fz6EOOhx5kGeh29MN/LYq8CG0Qdd/rBSotcCqd2tGlNWWr23PNpk
	qP/7txci7NbKHR73ajjy+pks59Nosu84=
X-Gm-Gg: AY/fxX6i2mbIqMABBu24m6vJJHmj1ZZ7D/DdJuJtaSujq7zf2CJ5bsCkL1jz8MmIgco
	q2pAiHvSRtd8rXJc4a7l+lIe0oyqlFXS+AYIkdVFMs+JC++nwXwViIsGlc2Txgnk1JXlaW7Wk41
	PE6BXl3bEC21AoL0J2mOlNa/yTGSjXcVD2VVK/OSAEYqsyScO0A98EQcrfcPZYSCxz1WO4HCkBt
	L21ZXFVtizcg4mCcxXEL7G4hb4BL90yBUgoqy4sgF/J8pL2T0kPve4iX5kg2X3C5SaGWJA6Nr3H
	02zfjNmHcmpP0eLE2PBXoVyDxcrcYsL0Mq55o3R+41BwVmWYau8IlKAn/uF7gQZT59PvL70DbNn
	MM+46ZkpUf7Tv7fdGmJqgUWc=
X-Received: by 2002:a05:7300:f18f:b0:2b4:5d92:3e7f with SMTP id
 5a478bee46e88-2b6b3918011mr4284330eec.0.1768810811849; Mon, 19 Jan 2026
 00:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Jan 2026 09:19:58 +0100
X-Gm-Features: AZwV_QhxAiFaIcvwX8h9uKf6H4azma3UhOyTlcnZ27Zijuat-yr3VdVO8Qat4vs
Message-ID: <CANiq72nDtcSQ=GPvGUObaxqA6WaOGM8oUCqV80k-Sxm3zT5G=A@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] rust: build_assert: document and fix use with
 function arguments
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 3:47=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
>       rust: build_assert: add instructions for use with function argument=
s

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

