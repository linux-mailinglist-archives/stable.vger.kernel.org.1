Return-Path: <stable+bounces-179806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AE0B7D2E4
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8F51C00298
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63730B50B;
	Wed, 17 Sep 2025 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R+GfaeLh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0158521FF5B;
	Wed, 17 Sep 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098459; cv=none; b=P6/VYEPb80jnG5cEoopP+1sZdRhSvbM6li50/0S+myfUnC6sxrSJcwqCEVtSK1xrRIi5TFgAWTDdxncRi/69LuuZR0MAk83NggcLlVwWhITS49rsyeeM32kvhtXcQyHBs6bdaxI2HxzlexboKPx5GlN89uDO4MDttif4mNyu6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098459; c=relaxed/simple;
	bh=5zAmcq3SlqCf6dm0pQE7jGyJ05jsVMAEDVuzqlPLnf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPyp/a08faz089mqs52f+Thh75phiVT4g7ykBv4aVG77yTNCegqJxm0bePwpNZBtVn8YtW336rcAp6Zn0ZKPIOPovb9ffqiPzWoLxkWe2lCMuaOrmxV5i+qWSR2msVIj1fGo8slAycZeL5vrN8U5DcAovH8bMNKbGXPzb3l6n90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R+GfaeLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9564C4CEF0;
	Wed, 17 Sep 2025 08:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758098458;
	bh=5zAmcq3SlqCf6dm0pQE7jGyJ05jsVMAEDVuzqlPLnf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+GfaeLhnzcZhPU70xy6FDHZVraIMFm3KZ6rhTeGaMt1go88Z+7uBd5qiZtpESo28
	 09GcqKdiOvV7/p2No6M4v5aRLXS4P1q+XD4/y/Utm+9VzGURNvP4kRCCs2KYNL5ezQ
	 AHoIYIdyG7mpw/CAjeqXEL6gXJpbm541AUE+E1GM=
Date: Wed, 17 Sep 2025 10:40:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eliav Farber <farbere@amazon.com>
Cc: luc.vanoostenryck@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
	akpm@linux-foundation.org, sj@kernel.org, David.Laight@aculab.com,
	Jason@zx2c4.com, andriy.shevchenko@linux.intel.com,
	bvanassche@acm.org, keescook@chromium.org,
	linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
	jonnyc@amazon.com, stable@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 1/7 5.10.y] tracing: Define the is_signed_type() macro
 once
Message-ID: <2025091717-snowflake-subtract-40f7@gregkh>
References: <20250916212259.48517-1-farbere@amazon.com>
 <20250916212259.48517-2-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916212259.48517-2-farbere@amazon.com>

On Tue, Sep 16, 2025 at 09:22:53PM +0000, Eliav Farber wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> commit 92d23c6e94157739b997cacce151586a0d07bb8a upstream.

This is only in 6.1, and not other trees, why is it needed here?

> 
> There are two definitions of the is_signed_type() macro: one in
> <linux/overflow.h> and a second definition in <linux/trace_events.h>.
> 
> As suggested by Linus, move the definition of the is_signed_type() macro
> into the <linux/compiler.h> header file.  Change the definition of the
> is_signed_type() macro to make sure that it does not trigger any sparse
> warnings with future versions of sparse for bitwise types.
> 
> Link: https://lore.kernel.org/all/CAHk-=whjH6p+qzwUdx5SOVVHjS3WvzJQr6mDUwhEyTf6pJWzaQ@mail.gmail.com/
> Link: https://lore.kernel.org/all/CAHk-=wjQGnVfb4jehFR0XyZikdQvCZouE96xR_nnf5kqaM5qqQ@mail.gmail.com/
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> (cherry picked from commit a49a64b5bf195381c09202c524f0f84b5f3e816f)

This is not a valid git id in the tree at all.

greg k-h

