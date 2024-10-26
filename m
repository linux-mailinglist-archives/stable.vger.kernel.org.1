Return-Path: <stable+bounces-88219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A759B1A48
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 20:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ED91C2131A
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 18:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBE713B2A8;
	Sat, 26 Oct 2024 18:03:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F1333F6;
	Sat, 26 Oct 2024 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729965831; cv=none; b=IH/6LwHEUNKBi6/VkXO8XDGj7gfeyLoAzNQ5kijKMVNT9Ppz8JBxCm/Wn4bj9lEifehDNDgNOgwxFLM6oW8lEEzevL2rtH7vgmZVVtQXNR5x6j2J6kedoxaqeBTcE1LpT3aWFICQrb5T61Zket1tF0rXWlq5S8zckcjDxjXvUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729965831; c=relaxed/simple;
	bh=x0J2jXABQk0AfmWQJSvPjWMMy56gbFwY6CO7ZEFdsrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StL/f4JvJPknClmCD3I1juVVa7Qkq1tuo7es3QGPuhObAx+dPvQE95bw2wuu/rWR2BDKI2V8aroUY3Dn57eUPkCeyS2ySBEaSp4zcQoievy2mq0lnqg6IbPeS/uQc+Re6SVomsamEpoz/d1SGUwjhSlDN6rV23S1j5OY56tsDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 49QHskX0009892;
	Sat, 26 Oct 2024 19:54:46 +0200
Date: Sat, 26 Oct 2024 19:54:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        conduct@kernel.org, security@kernel.org, cve@kernel.org,
        linux-doc@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, shuah@kernel.org,
        lee@kernel.org, sashal@kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Concerns over transparency of informal kernel groups
Message-ID: <20241026175446.GA9630@1wt.eu>
Reply-To: linux-kernel@vger.kernel.org
References: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
 <20241026145640.GA4029861@mit.edu>
 <522bd817-339a-45b0-84c2-2b1a4a87980a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <522bd817-339a-45b0-84c2-2b1a4a87980a@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Oct 26, 2024 at 05:33:16PM +0100, Jiaxun Yang wrote:
> > There's quite a bit of information available in the Linux Kernel
> > documentation.  For example:
> >
> > * https://www.kernel.org/doc/html/latest/process/security-bugs.html
> > * https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
> > * https://www.kernel.org/code-of-conduct.html
> 
> Thank you for the pointers. My concerns actually rooted from the first two
> documents, and I was directed to the third link off-list following my
> initial post.
> 
> In process/security-bugs, the term "security officers" is consistently mentioned,
> yet it's unclear who they are, what specific privileges they hold compared to
> regular developers,

The "security officers" is just a small group of trusted maintainers
(~20) who devote some of their spare time (and possibly some work time
as well) reviewing, triaging, and forwarding some security reports that
arrive there. I think the term "security officers" is used essentially
to remind that reporters are interacting with real people without the
heavy weight of processes or whatever some could possibly imagine.

I'm not aware of a public list of participants, though the list of
participants is shared between the members from time to time when one
arrives or leaves. I think discretion is key here because I'm not even
sure that every participant's employer knows that they're on that list,
and it's better this way, as some might try to exert pressure to try
to get some early notifications, which is absolutely forbidden.

Participants are quite responsible people. Some have already left the
list by lacking time to participate, some temporarily or definitely.
New participants are sometimes asked to join because they're involved
in many of the reports, and that way they can directly interact with
the reporter without anyone having to review and forward them the
messages first.

So if you wonder who's there, just ask yourself who can speed up the
process by participating when there are frequent reports in their area
of expertise, and you'll guess by yourself a few of them :-)

> and how security fixes are expected to reach Linus's tree
> during an embargo period.

There's no hard-rule there. Some fixes are written by some of the team
members because the bug is directly in the subsystem they maintain so
for them the easiest path is to take the patch and add it to their
pending queue. Most of the time the fixes are forwarded to maintainers
not part of the list and they deal with them the way they're used to
for other bugs reports. Most of the time bug reporters are told that
their report is not critical and should be handled the regular way (as
it's always better to have public discussions on fixes). It's super
rare that fixes are merged directly by Linus himself. It could happen
because there's a huge emergency, but history told us that bugs handled
in emergency do not always result in the best fixes. Also if one is
seeking discretion, the last thing to do is to merge the fix without
sharing it on a public list, as that's what attracts suspecting eyes :-)

Also, for the vast majority of bug reports there's no embargo period
requested by the reporter, as most of them just want bugs to be fixed.
I think it might be less than 1-2% for which an embargo is requested,
and that's fine because fixes don't wait. Most of the time once the
fix is agreed upon by the different parties and passes the reporter's
tests, it gets merged in the maintainer's tree.

I noticed many times that there are some fantasies around the security
list because it's not public, so people in quest of amazing stories may
imagine lots of stuff happening there. The reality is that it's exactly
like any other topic list where bugs are discussed between maintainers
and bug reporters, but the discussions are just not public since they
would directly put many users around the world in trouble without even
having a chance to protect themselves. Another benefit of not being
public is that it's easier for reporters to share traces, captures etc.
They don't need to waste their time anonymizing them (though most of the
time there's absolutely nothing confidential shared anyway, but an IP or
MAC address can remain without having to hide them as is often done on
public reports).

Really there's nothing special about that list, it simply helps to put
bug reporter in relation with the appropriate maintainers and save them
from trivial mistakes, because it's always frightening to report a
security issue to a project, you always fear you're sending to the wrong
people and will cause unexpected trouble. That list is there to address
this specific point, and to make sure the report is not forgotten.

I hope this clarifies its role a bit!
Willy

