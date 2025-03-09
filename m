Return-Path: <stable+bounces-121609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB1AA587FF
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 20:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5633AD47A
	for <lists+stable@lfdr.de>; Sun,  9 Mar 2025 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CBC21A44E;
	Sun,  9 Mar 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jicQ10rx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4921DA109;
	Sun,  9 Mar 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741550202; cv=none; b=ATAimBnqYTACeNz6V8DSPmUBFoylgzhFUh2fq+tBJYW+mGJ+WbVCuHPdxUpFfHA7XxREfZy4mhdHEktgVtXbPmVBtPDR1PLIEovWh2MY/tQDE7Uuht4U9tf3Op1+X0KpvQQq4DUqkdvohkEX4ni07TUmbGBR5JgeERGaFM6Da6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741550202; c=relaxed/simple;
	bh=9zth3ji/1gSASSbT74qef/gpNPTW4q7Xzz9+gH90Nws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ov02k0g0p/vj0jPmMW9XdBR8DeJRLi0LL6sD09ge2BsT76KrEhQLV/SJTwmFx8ZLs5f6x1+CVDmL6UI8dtdE4eNGqWcwrGhB8iSdEHCOpbyS2it8gELF7LIa0wosnjgkF/k42T+cQawr5oWe8F3vORO199u4I5+wZHe3A7NPO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jicQ10rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63392C4CEE3;
	Sun,  9 Mar 2025 19:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741550202;
	bh=9zth3ji/1gSASSbT74qef/gpNPTW4q7Xzz9+gH90Nws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jicQ10rx8YCGb1nPT0GsF8Ry7D154mk/tl64osb5PD/y/trtNC1eYWB0RG6HadmAj
	 vku4gl6GxXYHX/CK3nCWiMAY89EVbvOP29WJEEDaBiCwtWGPdBOqJxZn9wfkYU6Okd
	 vUz0JObz4x9qxurQFGFLcM2sEW2Ttn2/qqXu7c1sDGFyu7vaFPmIYguxq83kUzgvT8
	 JNlC/HBu+mEfP6Wo6kI1T+CKIblCSzTPBmcRPyNYrFO6oYbSkby8UdcXv11t84Srh7
	 togOcLPwFW9v5JnB3Isvvrb8secp7GYyEUjQYdzp4O4B6wEytF4txoZMR6kdAgphWi
	 nOG/BiVJQ3MTw==
From: Miguel Ojeda <ojeda@kernel.org>
To: chenhuacai@loongson.cn
Cc: chenhuacai@kernel.org,
	gregkh@linuxfoundation.org,
	jpoimboe@kernel.org,
	kernel@xen0n.name,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	peterz@infradead.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH 6.12/6.13] loongarch: Use ASM_REACHABLE
Date: Sun,  9 Mar 2025 20:56:22 +0100
Message-ID: <20250309195622.1541936-1-ojeda@kernel.org>
In-Reply-To: <20250308053753.3632741-1-chenhuacai@loongson.cn>
References: <20250308053753.3632741-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 08 Mar 2025 13:37:53 +0800 Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> commit 624bde3465f660e54a7cd4c1efc3e536349fead5 upstream.
>
> annotate_reachable() is unreliable since the compiler is free to place
> random code inbetween two consecutive asm() statements.
>
> This removes the last and only annotate_reachable() user.
>
> Backport to solve a build error since relevant commits have already been
> backported.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Link: https://lore.kernel.org/r/20241128094312.133437051@infradead.org
> Closes: https://lore.kernel.org/loongarch/20250307214943.372210-1-ojeda@kernel.org/
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

This indeed removes the build failure for me -- built-tested for loongarch64
(together with the rest of the Rust long backport series):

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

