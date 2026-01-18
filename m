Return-Path: <stable+bounces-210242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBD0D39996
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 20:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53842300B2A7
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 19:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4A23EAB7;
	Sun, 18 Jan 2026 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1kGETeY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8355B1367
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768765558; cv=pass; b=fHUCD4dwpDHI9sUdGw1LHSqXmA/RKUMoh6Bx6jjdZba/hfK+K9dkpYxlQFOcRVAnGLf3L61Ou2O0TPYVrbKFc3UzC1IYT+bhXbl2e+vDwnznDUqe3lR34NYB+UGkFnCXg/qmtVJCfT3iLQO2PRYFpxnW5h/5oM4J4Rk8cw27fj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768765558; c=relaxed/simple;
	bh=KVHaohjIpkS8RF4XW8vpNt+aWDOb9cyMHNvbV9tdgrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+ryLaiiXvfwws/az2c1goA7WQOzyeJrdc4MLe61ejMcD6ZBnXOtzJs4dYrkWHCiZaMn/uiZFO3cMnjCyobDpujYeUGZAjH+OpysK/8TQ1JEZ3akn6GTwmOkFi62pYAcrtugqEn3lMWTkzXeS4USGN8lbu5Y9yyIFUCdgZpu3as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1kGETeY; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b1769fda0eso381959eec.3
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 11:45:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768765557; cv=none;
        d=google.com; s=arc-20240605;
        b=cEJvgRgvGCE1n8hqMYkpCQOucNVfxKiwYTJAwnr/XZ+0YnumWmais5z3HAXFKUtgp0
         0Yn4U1buPuV+QpGLm4t5OAeRQPzM2qF28GzlKr88TRH7xvzpcUhJgyVJHDyrMEwz7EbZ
         wvNyybe/zH5UNaSBGnrDYCRoIkMnVBkCW56KCAD8hgGYvGpYE8IcvYgVRxPZz1Pw2Pd8
         WxNRDIz0a+PoGBczK7unnxllxC6gJlBdXw3HOSxbRebJlO1NA5Kp2/W728OlvLv8qSjJ
         VXDyUH3bnsHyvHWZcNVY2DLzi29VhLeHyPJ5cxwAZChi5Ts5RGFeNobnXIcEFSGdwzWd
         aVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ngLJEmbzzfwIyJl3HgdWne+DdSWDFYCnHseYetxWc3E=;
        fh=BKqfmJr9SM3MIMUl1osCjn1Ytx9JyYjOMDLcIwiTFsg=;
        b=RuKNmMAj6aG+nu4Z+47+gV9udI+iZZQLqHyFE/JQOlXqFQ2sQbhZb7ZFWeXIkin61S
         d8Rm2ZdS64YBjIcsba8Cet1hdBLd+/N+7ZD42xwwAHqRJZsOI4U4kt90jOEkfXL6MIJ6
         E8vHiZDwNFigj4EUSf9WZWs03mPZZgB+kF2PFicBolhwW7cWAchMlrIqlV+WYuHA3CsX
         MzJc30ynmEIWXn36fLGzZcRgKWw2oygdsk2JxbgzY5KFDh1F+4b6X6ddGw6bW6a9x+OX
         HTadVn/HitqThMRFwdbLJyMsjF9rsHzEosm4ZNV7uh1AXiwwlwJ0C+LxU1WS+a8zgTa8
         n0xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768765557; x=1769370357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngLJEmbzzfwIyJl3HgdWne+DdSWDFYCnHseYetxWc3E=;
        b=a1kGETeYn96vfAtUMnq3WWCUyDjZfuOjIYO5KJfsxBT6XOBL2QZUW8WlSERfWCZ+4R
         e0ThKDKGRjJJDvZLq025pLtHvGAHBPFmGRlh7DLTdTbQ/q8qqCIl1Gja4gWBeKDzzBei
         04rmBcVo3YV5C7B4iUgHbopUVNusdCjvLjJDb8khHlngeQtBAtDmMUm4FgUMu28bMWI6
         SY2xT1DgfE+DjPc2xE72ZtSsMjciuJlnNaa4WYlOhU0KmbyL7DKEeW1m87TPhiT7s2DD
         3vLQMsnPtUnwrWHMlfJxSom9JF2UQtYpwmz1VfWTEAGzDq9Uxw4ZC9RNpAepSChWYcmW
         Ar1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768765557; x=1769370357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngLJEmbzzfwIyJl3HgdWne+DdSWDFYCnHseYetxWc3E=;
        b=CBqhXBui8dnP4/zrLIMz26lkMe2x7gGNGsFuGHE7cPspRLON4POXlNGuJ2ajBPto/j
         00BCwDbWaUYYr2yj7K7K8lZJs5H1PyRU81tp0uYlRSOcF0PwvcR466d3RdFM66UubvPO
         LLfAa36z0KWpBVcUcp1qyAKRhVVy954JkzngPJI2/+Sa5UKkrZTCsrax6MqIl0yW5lMM
         Wijt+T10vq7sgPOBXwlb6siPIl6RB3TEIKQxITJnyT0SIKHEMwAyeK2lySn7bweBB311
         pm8jhdrjfVC5Ui1jL4a5glrGsXFI8pn424evSK/MD8Ek2AIgBE2EBQFdJ26TUjBddgVN
         45Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUVuou3LDl4CEsOLMbVXJ6BCHpgiJz5g5fSVWhSZktWofpF6K9u0v+hHoiy4AIsE83TtXduz+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZfHh3PtzyLrW66lTL+GMva/eFtDKOZeW7SHxVuUP62g3DI9E
	EH765gr/qUU0RQ1uepQXDZYCAM7kaAePNEY4OTpFrQLcIa85o8uOVEBiy4PRr/LY1TKfB2HgYsu
	WZuhsiI/PbpzhIY5hLNidZ0NLBoBOooM=
X-Gm-Gg: AY/fxX71QZh0dl1TxoGH9+JucQp8bvC2I0X+4clOQqhncNIgsO5NYYdfKm4FUkrlD2D
	c4uK0Xx7IqEryjDRZibUWh3FnqQ3cvU6mMzmmgM9g6aOf2AEy21sqaLIaiwz4orrCd4JKLPC24b
	2v1UaDoJf8Q9+1tccnzU0VdkkEAJIbOTyOpm42Rg8/3sPRrs2VWlNVAwnvuVOm/pRCQfakw46fI
	nXqghayHvhVaSo82Y1sdW/S1KB5/p1KtunQxwl2tqz8+J036Cd8ZlGeiUAvF3ZXy6pigQwn6JMh
	xREMpZ19Zx2SGUdVANhqetcH44U8mbJF0xB0wf8p7/uZJ5Bo6FOkabO7Ih/+zJd9156aTdnSm8f
	YmQDQ9XVbEYVT
X-Received: by 2002:a05:7301:3f19:b0:2a4:3592:cf89 with SMTP id
 5a478bee46e88-2b6b380ec55mr3935044eec.0.1768765556660; Sun, 18 Jan 2026
 11:45:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
In-Reply-To: <20251208-io-build-assert-v3-0-98aded02c1ea@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Jan 2026 20:45:44 +0100
X-Gm-Features: AZwV_Qij1ytH7g1-A1PT-QCFQRqVSpKUckCbAvhQA3vEU6vow4n76J5rAgj9nXw
Message-ID: <CANiq72kvMp0KS0wXGYRiPOdNvJLoBpM45G7BHgPF_g-M9b5t_A@mail.gmail.com>
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
>       rust: bits: always inline functions using build_assert with argumen=
ts
>       rust: sync: refcount: always inline functions using build_assert wi=
th arguments
>       rust: num: bounded: add missing comment for always inlined function

Applied to `rust-fixes` -- thanks everyone!

The first one I will apply it into`rust-next`.

Cheers,
Miguel

