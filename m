Return-Path: <stable+bounces-171866-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B16B2D0E3
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 03:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAFC1C24C7D
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 01:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28281A9F82;
	Wed, 20 Aug 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUVboWDQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7C1A76D4;
	Wed, 20 Aug 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755651609; cv=none; b=U2fYrqrKgnO2ycV2rSCrLU9+Tiwlexzx36/JFndseRvWgdZqx5Fh9qsZvOvEQdkNiWfxYhX1443lMOWmnaj2W4Y4jZ9Y50a7veYAWvrrfLeZl4Un60ANMQz92w1hhElZsEmyWD76PfmL6LinbaveBJtbAsra4ZrUer0oeXH8hvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755651609; c=relaxed/simple;
	bh=JFhoL3YfNHgdhhfjYUv35Lds5sUeHFBImU5hZ4572/w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FuXUvzwakNjTDICrCXeGUgngYFs4QQk3vrHfTywiCLxHrcJIsYS0Bxp6JiKT6V7YkDUJ76ifI3SB0NWD1CJXr0yauWrhjapzRcZ55BnNoQrlQT8C5FriiPwj5e8rB10L+yRdE9s/pigvpmG1kLQg6ZEwv2oI7kzjJW5EtOe/rO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUVboWDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83657C113D0;
	Wed, 20 Aug 2025 01:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755651609;
	bh=JFhoL3YfNHgdhhfjYUv35Lds5sUeHFBImU5hZ4572/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lUVboWDQQa5eQ8NCFUg1I7VBbMv+kM19AHe9O3teKGDILXKFdyIkPkL5ybQYv8Slv
	 ytP4dyhynjC80KpfDHTCzlifsUXIS+PM7ySIRicNLi/ReoypznSfyvVw96KAr0mXXD
	 RkyNfEZ+UCVenHI05I7h2Zc8NBjXTNt1R9YJX3e2IeXstEdE2C6moiwbXu+W9++/KJ
	 zsGszwA9Hx1Dmzy4Qy++ORISXNGXJiqVARw9PyUqU1XbvIqnI5Qp25grSN1d2GH303
	 LuUXVVMUnvtVNuZCS/1/8gho0B8VQF6TBCTzMW2E1pFwLpU9y2otsq/D+hTtZe2ZlM
	 K14j2y9brapAQ==
Date: Wed, 20 Aug 2025 10:00:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Alan J . Wylie" <alan@wylie.me.uk>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [PATCH] x86: XOP prefix instructions decoder support
Message-Id: <20250820100004.15a49b907b334e821f0a0e73@kernel.org>
In-Reply-To: <F5D549B0-F8F7-467A-8F8D-7ED5EE4369D3@zytor.com>
References: <175386161199.564247.597496379413236944.stgit@devnote2>
	<20250817093240.527825424989e5e2337b5775@kernel.org>
	<F5D549B0-F8F7-467A-8F8D-7ED5EE4369D3@zytor.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 18:36:17 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> The easiest way to think of XOP is as a VEX3 supporting a different set of map numbers (VEX3 supports maps 0-31, XOP maps are 8-31 but separate); however, the encoding format is the same. 

Hmm, OK. We need to enable VEX3 support too. What about the opcode?
Most of the opcode are the same, or different instructions?

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

