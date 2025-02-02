Return-Path: <stable+bounces-111974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AD8A24F58
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 18:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CB37A1C50
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339D81FBE8A;
	Sun,  2 Feb 2025 17:41:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DE91F9EC1;
	Sun,  2 Feb 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738518094; cv=none; b=DIrh3/dZFQ9NOL5I9vtlKg2DVeXxyh7gEC3MVcZ4nCfqMAoVWSAatbs6PVuctCZkq27zxJGPjOoUNkPFBlltYAiDgaNNQJZUoQ1S8h4GyrSAAui4UDCCdEb0lr7HdKHlMbpUwQVJjtQQlV2Eah1S8/8vbE3yBP2UbEAhKgidHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738518094; c=relaxed/simple;
	bh=w4IBQpNohvlUGg1hjCaVC0rczWkztiGAZrXXkW9/HbA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sFUIl6K6WHvPEJG52BCsfvhhraH33CKL+4JY/jMTJFyyYibRbb0Ni5mkAKt+5z7f+N9nhiG82twecw3E+oJCciEELJ6KZu98RJW3VF5T+JSBLRbHaPw2sbwKrCaA0ycLzU6VzL4bjjxynL+IVWk6ZicPtsFS598ZnIPqatPQ4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B627F92009C; Sun,  2 Feb 2025 18:41:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id AF67692009B;
	Sun,  2 Feb 2025 17:41:31 +0000 (GMT)
Date: Sun, 2 Feb 2025 17:41:31 +0000 (GMT)
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
Subject: Re: [PATCH v2 4/4] alpha: align stack for page fault and user
 unaligned trap handlers
In-Reply-To: <20250131104129.11052-5-ink@unseen.parts>
Message-ID: <alpine.DEB.2.21.2502021720340.41663@angie.orcam.me.uk>
References: <20250131104129.11052-1-ink@unseen.parts> <20250131104129.11052-5-ink@unseen.parts>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Jan 2025, Ivan Kokshaysky wrote:

> do_page_fault() and do_entUna() are special because they use
> non-standard stack frame layout. Fix them manually.

 We could reuse `struct switch_stack' here and clean up this stuff a 
little, but I guess it can be done later, when we've run out of more 
serious issues.  LGTM then.

Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

