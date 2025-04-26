Return-Path: <stable+bounces-136769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD25A9DBBD
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 17:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C594A07EB
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3A25CC54;
	Sat, 26 Apr 2025 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp6sUUIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC613E41A;
	Sat, 26 Apr 2025 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745680373; cv=none; b=ojmREYrP6XBcg4T3sWmJGH6YlbxAKwmL7D8WP53Cf5Z5RfIjNn8g+CQXoNEPIRBytGkUQKQulnKTC7+jeAEo3DsEzAjAntx0CUhXq5R2vPNUAzOGGIjG9SO9hB3lE2AlYih6vdONJu7/4E80eyzBe1CUJ/VgdHhYs5nx22Btmd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745680373; c=relaxed/simple;
	bh=RSTyDXmnY5NvI87lLbVOCtacxZJwYpD7DTZvdyNBZlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEhwPQUF+mtd9rQx0SeszxrswUMLLUaSQU90iLOtBl8gq6/84gOhnilVef5pRSgxBIM+s2MihWweOq+yQd4+rwGlv8Kc+VbjB4x5M1GdyVlINOB5XB3WfamSgYspveAYbwbpauYi7YwdVWfIGGfVvXku9d9yYbEZ1wN1E7yCFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp6sUUIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793B0C4CEE2;
	Sat, 26 Apr 2025 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745680373;
	bh=RSTyDXmnY5NvI87lLbVOCtacxZJwYpD7DTZvdyNBZlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mp6sUUIBPI3S/RmOtqTDlK168MPlbakc3Qzbb/AVGbqMHqM8L1R23JF03hhR15Ala
	 03xIc3XqMOp+JO9XMhG213evvv8ORPzg00iVnIZ8YgmiNCqm03uukc8Jh6iei3BStU
	 8JsUSotWyJxV3G0k/zHRCZmO/NnRdeOR9rcwVfRonBELc14o6vLqGWGO3UT/bAtjlQ
	 tx9F4XUOpZ0CyPQ0A3pSCzL7Wmn6CUKT+e6wB1OL+LCaeFPAEESuYt8VaghBRA5B1g
	 nLgIne7tA8ugidE7YKxzTjRJk4LSlIDLxJkUBSUj0wk8XMTJJiaBctBTbh7CTStUaJ
	 3THtgzfC7R/+w==
Date: Sat, 26 Apr 2025 11:12:48 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Kees Cook <kees@kernel.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP" has been added to the 6.14-stable tree
Message-ID: <20250426151248.GA2377568@ax162>
References: <20250426132510.808646-1-sashal@kernel.org>
 <71399E4C-AAD6-4ACF-8256-8866394F3895@kernel.org>
 <20250426141107.GA3689756@ax162>
 <aAzzMJUz8Gh1uGnr@lappy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAzzMJUz8Gh1uGnr@lappy>

On Sat, Apr 26, 2025 at 10:52:32AM -0400, Sasha Levin wrote:
> On Sat, Apr 26, 2025 at 10:11:07AM -0400, Nathan Chancellor wrote:
> > Sasha, it is a little insulting to me to have my manual backports
> > ignored while you pull in extra unnecessary changes to make them apply
> 
> Appologies: this is a case where some things falls through the cracks
> between Greg and myself. Let me explain...
> 
> Greg is usually picking up patches from the mailing list. I have the
> annoying bot (which you might have seen) that tests backports folks send
> over, but in reality I would rarely apply a backport someone sent over
> (even if only so we won't step on each other's toes).
> 
> On the other hand, I have some automation in place that after a few
> days, it combs through the FAILED: mails that Greg sends out and will
> attempt to automatically resolve conflicts by bringing in dependencies
> and build testing the code.

Maybe that automation could look to see if a patch has already been sent
to the FAILED thread? Greg's instructions tell people to use
'--in-reply-to' with the FAILED message ID so it would probably cover
the vast majority of cases of manually backport.

> I promise I haven't "manually" ignored your backports :)

Sorry, I did not mean for that to sound as harsh and accusatory as it
was and I appreciate the additional clarification around the process so
that it can potentially be improved :) thanks for all the work you and
Greg do.

Cheers,
Nathan

