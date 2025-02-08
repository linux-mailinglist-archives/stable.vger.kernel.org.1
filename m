Return-Path: <stable+bounces-114399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF7A2D7A9
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 18:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13D477A38C4
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 17:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864DE1F3B9C;
	Sat,  8 Feb 2025 17:01:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3541F30DA;
	Sat,  8 Feb 2025 17:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739034092; cv=none; b=jpk50UvcQPXFR3sdsWn6V1vEkR4sAvdPl8xFcRWJM0KO93jqr8BtrPSI/dEkDLjdLhJRbzHFzmOsFXCH3vuz+3ZgHphUttSVty4lcUKmPmuwaOIHvHqH+4GFfd4YJzbwFk8sPtoB7crezJQYIHcoItswWCi4q5i4zSZO4Se5D4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739034092; c=relaxed/simple;
	bh=SWjAC1dFHfWM48RkRP3mtsTsQDCo3e4Ez68GEPcvtb0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tta9x3oA6cMenjqyBlu94xvKXVum2/qp/xxhpiMfinQAmWphFeSMzCR3pbWDGN4ku1M9zJ3eaKghe9TUE/uUEDOzg2cloqDHgrl1HDqCSZSIOKrsHvgEy7Gx+FiEDBcZc9FKpvT+k/VYO7b0ahqjcXeWRgxD4E/kRqfzRtJp1Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id ECEA192009E; Sat,  8 Feb 2025 18:01:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id E61CE92009D;
	Sat,  8 Feb 2025 17:01:28 +0000 (GMT)
Date: Sat, 8 Feb 2025 17:01:28 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ivan Kokshaysky <ink@unseen.parts>
cc: Richard Henderson <richard.henderson@linaro.org>, 
    Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
    Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] alpha: make stack 16-byte aligned (most cases)
In-Reply-To: <20250204223524.6207-3-ink@unseen.parts>
Message-ID: <alpine.DEB.2.21.2502081615360.65342@angie.orcam.me.uk>
References: <20250204223524.6207-1-ink@unseen.parts> <20250204223524.6207-3-ink@unseen.parts>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 4 Feb 2025, Ivan Kokshaysky wrote:

> Note: struct pt_regs doesn't belong in uapi/asm; this should be fixed,
> but let's put this off until later.
> 
> Link: https://lore.kernel.org/rcu/alpine.DEB.2.21.2501130248010.18889@angie.orcam.me.uk/ [1]
> Link: https://bitsavers.org/pdf/dec/alpha/Alpha_Calling_Standard_Rev_2.0_19900427.pdf [2]
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Signed-off-by: Ivan Kokshaysky <ink@unseen.parts>
> ---

Tested-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej

