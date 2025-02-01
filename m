Return-Path: <stable+bounces-111916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD66A24C2F
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60DF188510A
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0AA1CAA8B;
	Sat,  1 Feb 2025 23:50:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-2.orcon.net.nz (smtp-2.orcon.net.nz [60.234.4.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E1126F1E;
	Sat,  1 Feb 2025 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.234.4.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738453826; cv=none; b=cjP20+M/OtkNJQzPCDBt6vBKqyLrQ9ASEHj++9vlTEp2v7UfigmCgqkc+4uH1xOOrysFVkvlMyhKaSG8S87ay4YSHsUa63Wlvkn3MRk45iwisOFKOro01TlmyXiTRx/BUuk//5Hw6kXiJbdPCRWyL4g2LLZHJfvE7PCXo781PL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738453826; c=relaxed/simple;
	bh=wklMM8is99qSEnIVgcDmnRoJKKRYWnNkYLttOyzBgaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3QQ1zGZT7IjtpgXu9fDpOi5aaqPCst9K+3A27GIappvb2TrwmttfW/2M6qtBmiT8if8qk7Td8Z+m1Z4/cNHdYQ4bcgLpvPM2GlP5ZgjQd8z0UqP38tALvDop9CfxpgYAiQxgMXG3Ev+22n+1YZ0zyifUpICY6LYbp3PAv3Rw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz; spf=pass smtp.mailfrom=orcon.net.nz; arc=none smtp.client-ip=60.234.4.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orcon.net.nz
Received: from [121.99.247.178] (port=6860 helo=creeky)
	by smtp-2.orcon.net.nz with esmtpa (Exim 4.90_1)
	(envelope-from <mcree@orcon.net.nz>)
	id 1teMf9-0004nN-Ej; Sun, 02 Feb 2025 12:12:31 +1300
Date: Sun, 2 Feb 2025 12:12:26 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Ivan Kokshaysky <ink@unseen.parts>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/4] alpha: stack fixes
Message-ID: <Z56qWp9GGuewJr1K@creeky>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Ivan Kokshaysky <ink@unseen.parts>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250131104129.11052-1-ink@unseen.parts>
 <6cb712c1c338d3ce5313e05a054ea9de21025ff0.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb712c1c338d3ce5313e05a054ea9de21025ff0.camel@physik.fu-berlin.de>
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --

On Sat, Feb 01, 2025 at 10:46:43AM +0100, John Paul Adrian Glaubitz wrote:
> Hi Ivan,
> 
> On Fri, 2025-01-31 at 11:41 +0100, Ivan Kokshaysky wrote:
> > This series fixes oopses on Alpha/SMP observed since kernel v6.9. [1]
> > Thanks to Magnus Lindholm for identifying that remarkably longstanding
> > bug.
> > 
> 
> Thanks, I'm testing the v2 series of the patches now.
> 
> Adrian

I've been running the patches on the 6.12.11 kernel for over 24 hours
now.  Going very well and, in particular, I would like to note that:

The thread-test in the pixman package which has been failing for over
year 10 years on real Alpha hardware now passes!

I have now successfully built guile-3.0 with threading support!
Previously guile would lock up on Alpha if threading support was
enabled.

So there are some very long-standing bugs seen in user space that are
fixed by this patch series.

Cheers,
Michael.

