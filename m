Return-Path: <stable+bounces-12276-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCEE832C21
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5250DB219BE
	for <lists+stable@lfdr.de>; Fri, 19 Jan 2024 15:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB543C493;
	Fri, 19 Jan 2024 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKJeA4Ld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70654675
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677108; cv=none; b=OoUV8tH5Vrc+TnGfYuOtHopwD10+ABx3lbjllJhveHM0nyoKq4ORSgOio+pH/krZatvazsQP/6MGJ0jspOIpV6rORNcm/NShgvy70mIr7KW/eV7AO6g5C9F1t6FNfwQC24E5SfRHAVg0HtB1WenTNBcMHV4/5CDE027p2IsxXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677108; c=relaxed/simple;
	bh=QEJWu5pSjcxHf7Mb+wjyUlw+gPwZ19jJt7RqEU0Zfjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/R+o4bFfy6yrVjKhnUSslxNfMu6OIKj8uqaqPB0DyVZLW2g2oR7RYLepjVlauwu3mw1153EemQFkLzjJVXPjSgNQrImmYcll2eH/LIhk7auQOdlnKHFoAstwJmsLSxQEoVo/LNpuqCX85f2QyitsQKesUE3Fn/626PDA75cmys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKJeA4Ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DA6C43394
	for <stable@vger.kernel.org>; Fri, 19 Jan 2024 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705677107;
	bh=QEJWu5pSjcxHf7Mb+wjyUlw+gPwZ19jJt7RqEU0Zfjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EKJeA4Ldr0hfHx5rmRNhZurnmeEUaY503egkxgVzboDzclVU68XSLy88duWNR7dG4
	 9A8TZxFpeBgG8BK7XXQ4gn4RtR2gL3bzI+VuQxmTjk33Ib1z6mM+d7PMsYKw90rVR4
	 TISEyCwhX6up729f2Hq9gLCWce8/F/6rbLwMGdPPNYsSAFD1oNa0eUZP9vjnmzNRPH
	 GKYvnt+61KsaizGPdfxJkW2Qd6golSng+0F6xFluQdM7wINEKisbXZXKG7ONW1gE5H
	 DeBWYSJSPZW55PQ3Bjy/ZZzhaceMVrp3UNDwKXTJFu8Rspwy0N5bgaJWfY9nQximvu
	 3TCDJkGnZEVFg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cdb50d8982so10480221fa.2
        for <stable@vger.kernel.org>; Fri, 19 Jan 2024 07:11:47 -0800 (PST)
X-Gm-Message-State: AOJu0YxuNUX7lbS48I1/MX48r1q+/a3L0nrUujwN3CTSRy/Do79t3XPg
	4UIm/d66yIGIv2GTGn6mTNaTvbnednCaxU0tWNcKGGrZuUWXWSc+ZsV2DyjbiDsdMwRwrv+bPxI
	iY2eqp7vaFp5Hk9id3XXLHpxNGQ==
X-Google-Smtp-Source: AGHT+IH63y428qa91gJp3u7l2DnEeA8PtRs+iqSgbK4bBkTTatiOx+UiAspezMS9Ewr2zbweHDDZxvONRuMavk9WUIU=
X-Received: by 2002:a05:651c:1991:b0:2cc:f163:fb6a with SMTP id
 bx17-20020a05651c199100b002ccf163fb6amr1998701ljb.53.1705677105838; Fri, 19
 Jan 2024 07:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116110221.420467-1-mark.rutland@arm.com> <20240116110221.420467-2-mark.rutland@arm.com>
In-Reply-To: <20240116110221.420467-2-mark.rutland@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 19 Jan 2024 09:11:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJGWHj_adgvX_XwRuh+xvQGw2p-e9ZxxJ_qd19nWZ_daQ@mail.gmail.com>
Message-ID: <CAL_JsqJGWHj_adgvX_XwRuh+xvQGw2p-e9ZxxJ_qd19nWZ_daQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, 
	james.morse@arm.com, stable@vger.kernel.org, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:02=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> Currently the ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD workaround isn't
> quite right, as it is supposed to be applied after the last explicit
> memory access, but is immediately followed by an LDR.

This isn't necessary. The LDR in question is an unprivileged load from
the EL0 stack. The erratum write-up is not really clear in that
regard.

It's the same as the KPTI case. After switching the page tables, there
are unprivileged loads from the EL0 stack.

Rob

