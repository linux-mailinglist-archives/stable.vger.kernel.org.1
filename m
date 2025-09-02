Return-Path: <stable+bounces-176970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ECDB3FBFF
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C041B22C8B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C40726B2CE;
	Tue,  2 Sep 2025 10:16:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB282BD11;
	Tue,  2 Sep 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808213; cv=none; b=HXb6nfYJQ+1ikaDoqCMcBJ04u2WUDCghJYlnusprPqgH/gKF74pJwvZ5HnwxCNInRKqjus+8igHvlDgeF4dXE/2d+yY1r9b5epotebySHqx326m6vwJYr+5bYYvgtfhYZEup7T6HSf1NmW/yVKK9JYJrfTJjI8vXEhUIqdIUh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808213; c=relaxed/simple;
	bh=MiuVwlDkQpkcmg4SsiFuwfX5YZ5iFvnaXQsJoKawFBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtoGm8VKiEJ3lOkBsxez0XwZ5lStPc1HaNqJUj7zaHzxeRroI/F8TtqumSqwVczpNQUwABBaCT5KxTRpGkHMjCvW9vD4UmthmurBDtE6jBPHumhLawVfc0luSWEj7f8bdKfiIataqvl+0DkYYWar/vwUJ0YEQHFCA9Z0d+2+N38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 418FE169C;
	Tue,  2 Sep 2025 03:16:42 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305483F6A8;
	Tue,  2 Sep 2025 03:16:49 -0700 (PDT)
Date: Tue, 2 Sep 2025 11:16:46 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, stable@vger.kernel.org,
	Jan Palus <jpalus@fastmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: quirk: fix write to string constant
Message-ID: <20250902-axiomatic-salamander-of-reputation-d70aa8@sudeepholla>
References: <20250829132152.28218-1-johan@kernel.org>
 <aLG5XFHXKgcBida8@hovoldconsulting.com>
 <aLa__M_VJYqxb9mc@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLa__M_VJYqxb9mc@hovoldconsulting.com>

On Tue, Sep 02, 2025 at 11:59:24AM +0200, Johan Hovold wrote:
> Hi Sudeep,
> 
> On Fri, Aug 29, 2025 at 04:29:48PM +0200, Johan Hovold wrote:
> > On Fri, Aug 29, 2025 at 03:21:52PM +0200, Johan Hovold wrote:
> > > The quirk version range is typically a string constant and must not be
> > > modified (e.g. as it may be stored in read-only memory):
> > > 
> > > 	Unable to handle kernel write to read-only memory at virtual
> > > 	address ffffc036d998a947
> > > 
> > > Fix the range parsing so that it operates on a copy of the version range
> > > string, and mark all the quirk strings as const to reduce the risk of
> > > introducing similar future issues.
> > 
> > With Jan's permission, let's add:
> > 
> > Reported-by: Jan Palus <jpalus@fastmail.com>
> > 

I was hoping to hear back, but I assume silence is kind of acceptance.

> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220437
> > > Fixes: 487c407d57d6 ("firmware: arm_scmi: Add common framework to handle firmware quirks")
> > > Cc: stable@vger.kernel.org	# 6.16
> > > Cc: Cristian Marussi <cristian.marussi@arm.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> I noticed that you picked up this fix yesterday but also that you
> rewrote the commit message and switched using cleanup helpers.
> 
> Please don't do such (non-trivial) changes without making that clear
> in the commit message before your Signed-off-by tag:
> 
> 	[ sudeep: rewrite commit message; switch to cleanup helpers ]
> 

Sorry I meant to do that when I replied and asked you if you are OK
with cleanup helpers. Also yes I planned to add a line like something
above before finalizing.

> In this case, you also changed the meaning so that the commit message
> now reads like the sole reason that writing to string constants is wrong
> is that they may reside in read-only memory.
> 

Ah, I didn't realise that it changes the meaning now.

> I used "e.g." on purpose instead of listing further reasons like the
> fact that string constants may be shared so that parsing of one quirk
> can subtly break a later one.
>

I see your point, will revert to your commit message.

-- 
Regards,
Sudeep

