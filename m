Return-Path: <stable+bounces-111973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14622A24F54
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 18:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907DC1621DD
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 17:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EEC1FBCB6;
	Sun,  2 Feb 2025 17:41:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A21BA34;
	Sun,  2 Feb 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738518072; cv=none; b=EUovw73St2dAIrK0mOgf1cuyWkj1f1CpQ59jXDryLPGWm545GX6Y2/WsNCCqSEVMTnyRzijYN8QQS/eO+LX2PajtyWG1S1vwPtiqhw5N3Uz0H6YjNSQEi3RTvHrNhrAMPxdVg1E4xcif6mrHBxtfE6/mPVXIRTUYBGFSikPssUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738518072; c=relaxed/simple;
	bh=9uJA1hu0K5ncyC7yaK4nBH0KJVs20hqleljDWbYnt78=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o6K3PZtRtUvZZvR9aTKiJy8IJj4f9jWC7c4/CO4koBvc3FaY7AVfmpP8bqP6oeywHktWCz7JgGztMCxAqrqWeIiZhIFHIsHtveuTiyfo+0/NRMIBR4sVm8kcbU3HWZ5vWakXAvXhRQFK6LPiXqLN/t6daZDMZ0tT/E5FXJ1BGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id D47BA92009C; Sun,  2 Feb 2025 18:41:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id CD5FD92009B;
	Sun,  2 Feb 2025 17:41:09 +0000 (GMT)
Date: Sun, 2 Feb 2025 17:41:09 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
    Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] alpha: make stack 16-byte aligned (most cases)
In-Reply-To: <20250131104129.11052-4-ink@unseen.parts>
Message-ID: <alpine.DEB.2.21.2502021718490.41663@angie.orcam.me.uk>
References: <20250131104129.11052-1-ink@unseen.parts> <20250131104129.11052-4-ink@unseen.parts>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Jan 2025, Ivan Kokshaysky wrote:

> Add padding between the PAL-saved and kernel-saved registers
> so that 'struct pt_regs' have an even number of 64-bit words.
> This makes the stack properly aligned for most of the kernel
> code, except two handlers which need special threatment.

 LGTM except for the request from 0/4 to improve the change description.

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

