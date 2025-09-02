Return-Path: <stable+bounces-176976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8662B3FC66
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C980F1B24F01
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D42283FC2;
	Tue,  2 Sep 2025 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANsrxkQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4CC283153;
	Tue,  2 Sep 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808880; cv=none; b=iRuI/g5h5rpFTC0GDjojWRfGxxRZcbcStnrtSr+bCynQ4m3pLy/mU9dXfuKSevw4hf+dz41pFLjiFnRJ04lw+23oUyMLMS94pwfYQjAUZbY2dAFJhIslHDVy4FlPxHWSasDUbYa7OKq3J4zBiCWoKOf6wgmo7U41BAbVTZDYC6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808880; c=relaxed/simple;
	bh=e+JGdBZlEQwB2llDtbOT+bOn4vC2kuWun8FcHjC5bks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1fZ9kouyISVgGf07bPDfO2GfQHPFJxFekk47rzwEShOR0Y7Vnc4KHwzpce+t26EwQQ1qLepaHLF8YnB58gdOLB8nsismZrjqufkU7TlB87MqQ0ewBOlUGA+p9rGypNRp8oPCFuX8kfXEwNyoQs7zpIBaCVku9gDlJb4pPwpY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANsrxkQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F8DC4CEED;
	Tue,  2 Sep 2025 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808879;
	bh=e+JGdBZlEQwB2llDtbOT+bOn4vC2kuWun8FcHjC5bks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANsrxkQUFhi5hZBSz0WtooVaJxE5l+wRicHWEAThlbi/a6vHYPAmrVf+PeEhP+Bw3
	 UCTj3+BSvreM/faFHfcW5E49EPfmbU8clrlZS+jEZRc5AkYAeJDkgkov2Ey2yEEdl/
	 mbxujtvTFCk/kmgIH4TMjL/E0bs1+DF630opkefAbqRoJfDmjfKtwOi1tQuZele/1z
	 7FBe5MFj6l3KbH2A1vxqHzAJe9sqx7KrePqCNJ9f+MUBxdhe/HhVogwH7aQZ6vVY3X
	 gvzIoMc3IsV27cOn0QZMjrmUPnwxRk0VHAYfIOYVx+fs0yUL10nK7YyVh6z1Xtj3jW
	 PPxGki5FAA4kg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1utOEr-000000008Uh-0EbN;
	Tue, 02 Sep 2025 12:27:45 +0200
Date: Tue, 2 Sep 2025 12:27:45 +0200
From: Johan Hovold <johan@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jan Palus <jpalus@fastmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: quirk: fix write to string constant
Message-ID: <aLbGoctnA-Ad-Hxv@hovoldconsulting.com>
References: <20250829132152.28218-1-johan@kernel.org>
 <aLG5XFHXKgcBida8@hovoldconsulting.com>
 <aLa__M_VJYqxb9mc@hovoldconsulting.com>
 <20250902-axiomatic-salamander-of-reputation-d70aa8@sudeepholla>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-axiomatic-salamander-of-reputation-d70aa8@sudeepholla>

On Tue, Sep 02, 2025 at 11:16:46AM +0100, Sudeep Holla wrote:
> On Tue, Sep 02, 2025 at 11:59:24AM +0200, Johan Hovold wrote:
> > On Fri, Aug 29, 2025 at 04:29:48PM +0200, Johan Hovold wrote:
> > > On Fri, Aug 29, 2025 at 03:21:52PM +0200, Johan Hovold wrote:

> > > > The quirk version range is typically a string constant and must not be
> > > > modified (e.g. as it may be stored in read-only memory):
> > > > 
> > > > 	Unable to handle kernel write to read-only memory at virtual
> > > > 	address ffffc036d998a947
> > > > 
> > > > Fix the range parsing so that it operates on a copy of the version range
> > > > string, and mark all the quirk strings as const to reduce the risk of
> > > > introducing similar future issues.
> > > 
> > > With Jan's permission, let's add:
> > > 
> > > Reported-by: Jan Palus <jpalus@fastmail.com>
> > > 
> 
> I was hoping to hear back, but I assume silence is kind of acceptance.

I sent the reply with the tag after making sure off-list that Jan was OK
with it. Sorry if that was not clear.

> > Please don't do such (non-trivial) changes without making that clear
> > in the commit message before your Signed-off-by tag:
> > 
> > 	[ sudeep: rewrite commit message; switch to cleanup helpers ]
> > 
> 
> Sorry I meant to do that when I replied and asked you if you are OK
> with cleanup helpers. Also yes I planned to add a line like something
> above before finalizing.

Sounds like a mail has gotten lost since I never saw that question from
you.

I'm fine with using the helpers here even if I'm not generally a fan of
them (e.g. due to declarations in middle of functions).

> > In this case, you also changed the meaning so that the commit message
> > now reads like the sole reason that writing to string constants is wrong
> > is that they may reside in read-only memory.
> 
> Ah, I didn't realise that it changes the meaning now.
> 
> > I used "e.g." on purpose instead of listing further reasons like the
> > fact that string constants may be shared so that parsing of one quirk
> > can subtly break a later one.
> 
> I see your point, will revert to your commit message.

Thanks!

Johan

