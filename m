Return-Path: <stable+bounces-136766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53604A9DB8F
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF851BA5205
	for <lists+stable@lfdr.de>; Sat, 26 Apr 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776A122FE08;
	Sat, 26 Apr 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFAZjiVp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E9256D;
	Sat, 26 Apr 2025 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745679154; cv=none; b=VDbOzE093UbxI7PKqf/21YLGtEJMwR6q+69EMOV4UX1B8FfKcpVgsmgE0cDP0LkX9lrWs2GB63lZI3qPbG7avAplfCpoFIlqobbhi5gfoAkb3/yF0m5/SyEEWaxyctj6d2z4GZlxB/sxbZephNmg90a6+W2xJeHRtzjAyuoLpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745679154; c=relaxed/simple;
	bh=xhA3xutVcMuTudYCDtZHLjJghvPLYqZI6l6Yrxkvbtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi4UCVsdTbzUZfAXrUUBaU5owJg79pUBSGSq/AugiGjsWDGYMo4y8g28yG/u7HHO7fDcZJXACzYUkQF+xC8mNTh+LIzCYhHVZ+YUeVsH+3BXQ+FaxnArbu/K7KqvwrJdkBxlEtS5AC8/i+DaTganWbhphcwW9KBEVMNulA+i7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFAZjiVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74940C4CEE2;
	Sat, 26 Apr 2025 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745679153;
	bh=xhA3xutVcMuTudYCDtZHLjJghvPLYqZI6l6Yrxkvbtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFAZjiVpzoi/SiL84jr1kKNV5/oRMqhcY9ZcG5zdiNc4lBNIPuUPRvWHp1sZJQsU+
	 H/5oa2zuYXoSQJ3w/LIeTnsduxntwZZojJWL6Fg2lKHd+CbOJkLS7VXSzoIULNkn2/
	 nweIHKGfXqSC2mx0lGCk2JT2E9LTGczLbpiZ0HirNf2+CWftKWxTa2oCDGsHv6XF3v
	 Zm1JeYwt9TyHAYGlr9Va6S7HaPbrtT7rXNP5cCi3dNzpqrA0uvG/ySXkbeEqc2oIij
	 RLUFTMCfmSBIHECTcycf6ZxjsFTAn+N6FUpYT3trGd9WkMYSmfmhUfsMjAhrflJ+9V
	 S1D+B7IDw745w==
Date: Sat, 26 Apr 2025 10:52:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Patch "lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP" has been added to the 6.14-stable tree
Message-ID: <aAzzMJUz8Gh1uGnr@lappy>
References: <20250426132510.808646-1-sashal@kernel.org>
 <71399E4C-AAD6-4ACF-8256-8866394F3895@kernel.org>
 <20250426141107.GA3689756@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250426141107.GA3689756@ax162>

On Sat, Apr 26, 2025 at 10:11:07AM -0400, Nathan Chancellor wrote:
>On Sat, Apr 26, 2025 at 06:33:24AM -0700, Kees Cook wrote:
>>
>>
>> On April 26, 2025 6:25:09 AM PDT, Sasha Levin <sashal@kernel.org> wrote:
>> >This is a note to let you know that I've just added the patch titled
>> >
>> >    lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
>> >
>> >to the 6.14-stable tree which can be found at:
>> >    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>> >
>> >The filename of the patch is:
>> >     lib-kconfig.ubsan-remove-default-ubsan-from-ubsan_in.patch
>> >and it can be found in the queue-6.14 subdirectory.
>> >
>> >If you, or anyone else, feels it should not be added to the stable tree,
>> >please let <stable@vger.kernel.org> know about it.
>>
>> Please drop this; it's fixing the other patch that should not be backported. :)
>
>This one is still technically needed but I already sent a manual
>backport for this...
>
>https://lore.kernel.org/stable/20250423172241.1135309-2-nathan@kernel.org/
>https://lore.kernel.org/stable/20250423172504.1334237-2-nathan@kernel.org/
>
>Sasha, it is a little insulting to me to have my manual backports
>ignored while you pull in extra unnecessary changes to make them apply

Appologies: this is a case where some things falls through the cracks
between Greg and myself. Let me explain...

Greg is usually picking up patches from the mailing list. I have the
annoying bot (which you might have seen) that tests backports folks send
over, but in reality I would rarely apply a backport someone sent over
(even if only so we won't step on each other's toes).

On the other hand, I have some automation in place that after a few
days, it combs through the FAILED: mails that Greg sends out and will
attempt to automatically resolve conflicts by bringing in dependencies
and build testing the code.

I promise I haven't "manually" ignored your backports :)

>cleanly, especially since I sent them straight to you. I already spent
>the effort to account for the conflict, which was not big or nasty
>enough to justify pulling in the upstream solution, especially when it
>is still not ready for prime time, hence this change...

I'll go drop my backports and queue up yours.

-- 
Thanks,
Sasha

