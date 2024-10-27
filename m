Return-Path: <stable+bounces-88221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D029B1B99
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 02:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E8C1C2102E
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F618028;
	Sun, 27 Oct 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mn25l205"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A0DF5C
	for <stable@vger.kernel.org>; Sun, 27 Oct 2024 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729991929; cv=none; b=FC1FcyMmcXw3eMRZzmhu/3D7wSO7Qfc9UPUKoNUHK0rQ5rQ/MkhC1QW9WPerT3IttqKFygKKHgCRRtlMT5IKAeBUakIxGNcDgBe2mFUQSrO7XksCQc++UjnglWxTuhp1fy8rk7uUhGcgvqb51e0k39nKccTQOHxNCTcGjbELRBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729991929; c=relaxed/simple;
	bh=U8QJPKyyTDXdhLxIVXdsg9oEMwLT+uSchUx25oUDr9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCUTFAkrKb9t+MiNdGQi0OVOcZrrTOn4yP8nUSsuK0tXR8lJVh/muzDTR+kcSxLoFYjaKg+01J6zzc0+HnDsgWiM9XDs5iAl5YUZPYqwiSZ/bU/FREUbDCGXbJnm6mw2Y4NkorPBRP5grXSuX9UTvXGH8h6EHPsl26BVtbNf9Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mn25l205; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (99-196-129-121.cust.exede.net [99.196.129.121] (may be forged))
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49R1I9eJ015160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Oct 2024 21:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729991901; bh=oeDNW4t5Q8UciCSZ6PSKNouh/u7JRhCcE7T8hef1oE8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mn25l2054zU1JtBOAaOMYsTMBRz1d1NkFZxlklqW9MD3V2H/YheAJ1T21JVCvzgDY
	 7s+FyEJ4QQ8c8WrwZfKTM6ExJVtaFzhTzZY4Vg7RDTegLDXzy+yi6GMOyH9uNZnnr5
	 riGEBM6qnU8wPHQxm4znfoYhEh6jxcppQJqvEYongCsBHCevMmM7sH2LWwTc7wLqLU
	 Nixzu+skiJwbE0EKBOJ3qAF2i+KZa3rtgfVIhZhxoaPabiG/8OxwS3J5yN70f+WUjz
	 Rq00AZS9wQhpmO2DtQ2kufUPEaI8kz2AwKyrTDYvvSiAD1wGvy5eS4pqpwmJGugN3j
	 lro+VioZEP92Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 321D234033D; Sat, 26 Oct 2024 20:14:22 -0500 (CDT)
Date: Sat, 26 Oct 2024 21:14:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org, conduct@kernel.org, security@kernel.org,
        cve@kernel.org, linux-doc@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, shuah@kernel.org,
        lee@kernel.org, sashal@kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: Concerns over transparency of informal kernel groups
Message-ID: <20241027011422.GA3842351@mit.edu>
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

On Sat, Oct 26, 2024 at 05:33:16PM +0100, Jiaxun Yang wrote:
> That being said, I'll try to improve the documentation on these things
> based on my observations. My background perhaps makes me particularly
> sensitive to some ambiguous language, especially where "constructive
> ambiguity" might be involved. Recent events make me started to look
> into those aspects in border community.

Well, make no mistake, there *is* a lot of ambiguity, because we don't
really have a centralized governance structure other than Linus has
the benvelent dictator.  The general philosophy is to have just as
much structure as necessary, but no more.  We do need to have a legal
organization to sign contracts with hotels, caterers, etc., for the
purposes of organizing conferences.  That is one of the roles of the
Linux Foundation.  But just because the Linux Foundation organizes
conferences, and accepts corporate donations, and pays Linus's salary,
*doesn't* mean that they get to dictate to Linus what he does, or
anything about what code does or doesn't get accepted into the Linux
kernel.  As Jim Zemlin, the Executive Director of the Linux Foundation
has been known to have said, he works for Linus, and not the other way
around.

This is not the only way to organize an open source project, of
course.  For example, the Rust community has a lot more structure
process.  I will note that this has not reduced the amount of
organizational drama and contrversy.  In fact, some might argue that
their governance structures may have caused some of the more recent
drama that lead to some people stepping down from official leadership
roles....

Or you can take a look at some of the BSD projects, which early on had
a lot of drama and some of the BSD forks based on who was officiallty
part of the core team, and who wasn't (or who was thrown off of the
core team).  It's perhaps because of that drama in the early 90's that
some of us who were around during that era rather consciously rejected
the formation of anything like the BSD formal core team model, because
we saw the dysfunction that could result from it.

There are limits to the informal model, of course.  One of the ways
that we have tried to make it scale is that there is great value in
making sure that the kernel developers have face time with each other.
It's one of the reasons why I organized the Linux Kernel Summit, which
later morphed into the Maintainer's Summit.  It's why there are many
people who spend a huge amount of time organizing the Linux Plumbers
Conference and other workshops, whether it's the Linux Security
Symposium, or the Linux Storage, File Systems, and MM workshop, or
Netconf.  The ability for us to see each other face to face, and break
bread together, makes the human relationships real in a way that
avoids e-mail conversations alone can turning into flame wars.

More recently, some subsystem teams have started regular video chats.
They aren't a substitute for in-person meetings, but they still are
valuable in terms of having that higher bandwidth conversation where
the non-verbal cues can humanize the personal connection.

Of course, like all things, there are tradeoff and limitations.
Attendance at in-person meetings can be hampered by real-world
considerations such as the cost of travel, or the need to get travel
visas, or for people for whom English is not their primary language,
they might be able to use Google Translate for e-mail, but that
doesn't work that well for in-person meetings or video conferences.
Some of these can be mitigated; the Linux Foundation has a travel
scholarship fund for people who can't get corporate sponsorship for
their travel, and many conferences now have a hybrid option for people
who can't attend in person for whatever reason.  But the language
barrier can still be an issue for some.  Maybe someday we will have
something like Star Trek's universal translator...

The bottom line, though, that any organization is made up of *people*,
and so there is no substitute for personal relationships and trust.
If you don't have that, I doubt any amount of organizational structure
can save you, and in fact, to the extent that some people might try to
game the formal rules/structure, it might actually make things worse.

Cheers,

					- Ted

