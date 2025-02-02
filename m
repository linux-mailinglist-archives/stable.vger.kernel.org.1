Return-Path: <stable+bounces-111970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894ECA24F4B
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 18:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C693188364C
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF91FA851;
	Sun,  2 Feb 2025 17:37:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37582BA34;
	Sun,  2 Feb 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738517868; cv=none; b=NXWFvLqx6PCCTvyz1xn8RHEiJAlrfUNVaEKfNvD90Cs2Fll6YR0tH6GSOZ1pMeOuniivWVBhcgFBmd2RiCyInbIZyYQ90rgJabv+YlKcWHNQ1fj2KBkULZk+JPhvmd1jJkr/8Y199qgbNsy+RV3pPhomhV+m367/+qS18xdItzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738517868; c=relaxed/simple;
	bh=7RB6OJs9fX5mQCGXnF75AXjtMuZjAUnaksxQrKu4dl0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DViJT1ucD17WP/HnCjN8CyKGwWAroMuh4wQBjRcHq1tKGrkJ28fP74x+GJjS+XE0z5tJgW05AnXdpxYBy/+avmDMp8nt8a25BNC/fUMo0ssC2npllaO5+PoWvIQR6Wp8QGsIiw7Mve+b9UDYAqr4D9hHYMJBavBpvaLGc6nf4mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id F0C8F92009C; Sun,  2 Feb 2025 18:37:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id EB66992009B;
	Sun,  2 Feb 2025 17:37:36 +0000 (GMT)
Date: Sun, 2 Feb 2025 17:37:36 +0000 (GMT)
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
Subject: Re: [PATCH v2 0/4] alpha: stack fixes
In-Reply-To: <20250131104129.11052-1-ink@unseen.parts>
Message-ID: <alpine.DEB.2.21.2502021652360.41663@angie.orcam.me.uk>
References: <20250131104129.11052-1-ink@unseen.parts>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Jan 2025, Ivan Kokshaysky wrote:

> This series fixes oopses on Alpha/SMP observed since kernel v6.9. [1]
> Thanks to Magnus Lindholm for identifying that remarkably longstanding
> bug.
> 
> The problem is that GCC expects 16-byte alignment of the incoming stack
> since early 2004, as Maciej found out [2]:
>   Having actually dug speculatively I can see that the psABI was changed in
>  GCC 3.5 with commit e5e10fb4a350 ("re PR target/14539 (128-bit long double
>  improperly aligned)") back in Mar 2004, when the stack pointer alignment
>  was increased from 8 bytes to 16 bytes, and arch/alpha/kernel/entry.S has
>  various suspicious stack pointer adjustments, starting with SP_OFF which
>  is not a whole multiple of 16.
> 
> Also, as Magnus noted, "ALPHA Calling Standard" [3] required the same:
>  D.3.1 Stack Alignment
>   This standard requires that stacks be octaword aligned at the time a
>   new procedure is invoked.
> 
> However:
> - the "normal" kernel stack is always misaligned by 8 bytes, thanks to
>   the odd number of 64-bit words in 'struct pt_regs', which is the very
>   first thing pushed onto the kernel thread stack;
> - syscall, fault, interrupt etc. handlers may, or may not, receive aligned
>   stack depending on numerous factors.

 Would you please put this analysis into the commit description of 3/4?  
It gives a good justification for the change, so it seems appropriate to 
me to get it recorded along with the commit for posterity.

 NB I've been feeling a little bit unwell over the last couple of days and 
consequently I only started my GCC/glibc verification yesterday.  Current 
ETC is this coming Tue.  Perheps it's worth noting that I run this against 
6.3.0-rc5 with a couple of backports on top to resolve conflicts, as the 
current master does not support EV45 hardware anymore.  I'll let you know 
of the outcome.

  Maciej

