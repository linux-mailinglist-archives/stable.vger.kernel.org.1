Return-Path: <stable+bounces-78109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC429885ED
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF418282332
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B618BC1E;
	Fri, 27 Sep 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="N+jLYx2F"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F818872F;
	Fri, 27 Sep 2024 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727441958; cv=none; b=qhcFaWuVT31sYtUdIaaPoqyHWnlla6N/7Lz5JTcrbATmkSJH/CKC+rAdUI+LwMSHbpXse7duCS8P6C94HFmrYvIIrIHH02w7WdnCEUQ9nzNo+JKSRkO20wxjam+Z3lzt1mVKzsWCBfYJrvdQaWMnV28z/R65Sr4xdBLgulqXLJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727441958; c=relaxed/simple;
	bh=MgHA6QrlFDqD0b39Bjeh4xZCqnAdUcrIa0qC+IxrJ8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5815qpoDvW37T+v5lMQsGyie8e1fQebTLJrXENJynphjO1baJPpx0YM9+5WkVr6zwTelDm7e4blwjT3baGc4T/oG9J68arIYdSU1VYlvsrkWboyFVOsROVNh0nQdg96eASAuPRSpKgw1n7nD5PLCqWC9mkCBmZkaGemCjsrdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=N+jLYx2F; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=LCDzsMM/uMsr1Jh/JXxraXhth4C18YjmMU5EvAUKBtY=; t=1727441956;
	x=1727873956; b=N+jLYx2FKShSUSjo6dTbk6R9viHLYK7Np+yiFN+LVTbrpf9c88VwpC9NvjXPp
	0tvSqPbeG/0TNFTGZt7xcCQv2rHqxkJFlORQ8S4x7RhdXwynkoV2HKa5UieEKfc1/6/1D0aKBPCAe
	lLN6N7/AmTwSNZKSFG7LL0RCeATjyh9oVtF5DI/QpECf3cNWzMJCVHdKgWZJJ60BNcl73PHE5UgBi
	izghZL1talUVoNqTS4T8dCV3pkRHXLFKjoWPK5IXWG0FIS95EeR2Obrjb8IZJ3PllP9dCl6rx+NJ1
	bZe4TdgZL7LAkiZti9naLOhtfbRzvBut9bn86m0kXs4niwcwgA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1suAZ0-0006eM-IU; Fri, 27 Sep 2024 14:59:14 +0200
Message-ID: <ac9c7c92-a03f-49de-a0ae-147e804161b6@leemhuis.info>
Date: Fri, 27 Sep 2024 14:59:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How do we track regressions affecting multiple (stable) trees?
To: Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev
Cc: stable@vger.kernel.org
References: <2e6fc26a-26f8-4fb0-af5b-261e3eda6416@heusel.eu>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <2e6fc26a-26f8-4fb0-af5b-261e3eda6416@heusel.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1727441956;897c2ef4;
X-HE-SMSGID: 1suAZ0-0006eM-IU

On 27.09.24 14:24, Christian Heusel wrote:
> 
> I wondered a few times in the last months how we could properly track
> regressions for the stable series, as I'm always a bit unsure how proper
> use of regzbot would look for these cases.
> 
> For issues that affect mainline usually just the commit itself is
> specified with the relevant "#regzbot introduced: ..." invocation, but
> how would one do this if the stable trees are also affected? Do we need
> to specify "#regzbot introduced" for each backported version of the
> upstream commit?!

No, as there (most of the time, see below) is not much point in doing so
(afaics!). And you'd need a separate mailing list thread or bugzilla
ticket for each of them as well, which gets messy (but might be worth it
for cases like the "[0]" you linked to!).

To explain the current state of things:

Usually when a regression affects multiple stable series it also happens
in mainline. Then it should just be tracked it as mainline regression,
as Greg almost always will wait for the fix to hit mainline anyway --
and then usually will backport the fix on his own, as long as it has a
fixes tag.

Sooner or later this ideally should be improved with additional features
in regzbot:

* A way to tell regzbot "this mainline regression does not affect the
following stable series" (they usually do, so coming from the negative
side of things is likely the right thing).

* The webui on the page for stable kernels should list all mainline
regressions that affect stable series as well, because the culprit was
backported to them (unless they were marked to not happen there, see
previous point) -- and should continue to do so until the mainlined fix
lands in those stable series as well.

One case then afaics remains uncovered: regressions that happen in more
than one stable series, but not in mainline (for example because some
per-requisite is missing in all of those series). Not sure, some way to
tell regzbot "this affects multiple stable series" is likely the right
slution for that.

In the end all of that should not be really simple to implement, but not
hard either -- but well, due to lack of funding development currently is
mostly stopped. :-/

Hopefully things will improve soon again. But even then there are imho
more important features that need to be addressed first. :-/

> IMO this is especially interesting because sometimes getting a patchset
> to fix the older trees can take quite some time since possibly backport
> dependencies have to be found or even custom patches need to be written,
> as it i.e. was the case [here][0].

The above should hand this case afaics. If not, please let me know.

> This led to fixes for the linux-6.1.y
> branch landing a bit later which would be good to track with regzbot so
> it does not fall through the cracks.
> 
> Maybe there already is a regzbot facility to do this that I have just
> missed, but I thought if there is people on the lists will know :)

The idea to handle stable better is pretty much in my head sind
regzbot's early days, but you know how it is: there only so many hours
in a day.

> P.S.: I hope everybody had a great time at the conferences! I hope to
> also make it next year ..

FWIW, sounds that will require and intercontinental flight next year.
:-/ But fwiw, a few people consider doing a kernel track at CLT oder
Frosscon next year; and next year I might go to Kernel Recipes again is
the timing is better.

> [0]: https://lore.kernel.org/all/66bcb6f68172f_adbf529471@willemb.c.googlers.com.notmuch/

HTH, ciao, Thorsten

