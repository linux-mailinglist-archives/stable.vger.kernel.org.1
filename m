Return-Path: <stable+bounces-88216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C069B18D8
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 16:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032561C21499
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F861C695;
	Sat, 26 Oct 2024 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Tzw8Gs48"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4D1F94D
	for <stable@vger.kernel.org>; Sat, 26 Oct 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729954642; cv=none; b=ODCu7pLltSKUnQZDLKWWbRnPja7O5co0kaBYi2xhNiYcZB78udCPjuegA3hbYwmUZqXpe5nYTMZOWdubvA5KBhE0fja+0yCwc2PVvjn14x+vzp+HmP55uKOpTMRMro0eKsBUHPojzSMRZzvVO+h7SNF456MzdD4htahZGFn4f/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729954642; c=relaxed/simple;
	bh=CJs0VpoZhONc6COX1imNdpelZZQnQ6WOrBIepRXm34w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScqcFHfqoMZOMzPluXxChrosm4cgrAWbvuK1F12q5lN34AgP3/NeeRfLd9/jC7mZPmeiW024wTHWh6PT3SJyZmK4ZAeYHGxF5MFCwxNtxSH7sh1N4X6Uln80UOo9rqssEuft/YKWwFMM0AyF5V6J5Xj+y4f715AHCkv5CpMxKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Tzw8Gs48; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-123-201.bstnma.fios.verizon.net [173.48.123.201])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49QEueZW028447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Oct 2024 10:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729954603; bh=aULT5OMJ6smsVuK2cgh/H3JIovBDA9Azz9OyMHRcqaA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Tzw8Gs48LAwF45tatmSNWobz6VgBPrihP9EwNG7bIEEGCVvsky/lBI9xua7qdo9Pm
	 N81QQdX40IHBtixe7waVbfo8zUTXPme/XEdo8UoQxU8+p5DQQbgGLc9jrbFALqdC2I
	 odx3/RXBgLGum4PQgJZawxMyVtVi2W6YofKFKbrXf5ROvvpEWgvyt+F2v1Op+cY+3V
	 W0kkcVK39CosbMH+9FxMRHK00q4mNKfcdI4D3yuiQqUhbun0cZrbt6C6XoJunc1ejX
	 mgDcjv7kG6j2lqCzjzzMb9QMtntP+jMaGoci5t4WeQ1q6M6frglWCE1gnNPz4pQW/c
	 FIXSWhYTo1nwA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3C68815C032A; Sat, 26 Oct 2024 10:56:40 -0400 (EDT)
Date: Sat, 26 Oct 2024 10:56:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org, conduct@kernel.org, security@kernel.org,
        cve@kernel.org, linux-doc@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, shuah@kernel.org,
        lee@kernel.org, sashal@kernel.org, corbet@lwn.net
Subject: Re: Concerns over transparency of informal kernel groups
Message-ID: <20241026145640.GA4029861@mit.edu>
References: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>

On Fri, Oct 25, 2024 at 04:15:42PM +0100, Jiaxun Yang wrote:
> 
> Over recent events, I've taken a closer look at how our community's governance
> operates, only to find that there's remarkably little public information available
> about those informal groups. 

There's quite a bit of information available in the Linux Kernel
documentation.  For example:

* https://www.kernel.org/doc/html/latest/process/security-bugs.html
* https://www.kernel.org/doc/html/latest/process/code-of-conduct.html
* https://www.kernel.org/code-of-conduct.html

Ultimately, though, governance model that we've used since the
founding of the Benevolent Dictator model.  For a description of this,
see:

* https://wiki.p2pfoundation.net/Benevolent_Dictator

The reason why this model works for Open Source projects is that
ultimately, the license allows the code to be forked, and someone
could decide to take the Linux Kernel sources, and declare some new
version, say: "Tedix".  However, if I was delusional enough to do
this, it's very likely no one would pay attention to me, and consider
me a random madman (of which there are many on the Internet).  

Ultmately, though, the reason why Linus continues to serve as the
leader of the Linux is that there is a very large number of people
that respect his judgement and technical acumen.  And unlike in
physical space where a dictator could (hypothetically) order tanks to
fire on college-aged students, ultimately no one can force developers
or companies to continue use or develop Linux.

Everything else follows from this.  So for example, a maintainer or
maintainer team can refuse to accept patches from a particular source.
If someone disagrees with a decision, whether it is not accepting a
patch, or request a patch that it be reverted, they can appeal to
Linus.  Linus ask the Maintainer for their reasons, or can decide to
override the decision by accepting the patch into his tree, or
reverting a patch.  Ultimately, Linus can decide to relieve a
maintainer of their duties by simply refusing to accept pull request
from that maintainer, or by remoing the subsytem entirely from his
sources.

As another example, the Code of Conduct committee has no inherent
power to sanction developers, other than to make recommendations to
people who actually do the work --- namely, Linus Torvalds, other
maintainers, the people who run the mailing lists, etc.  Like with
Maintainers, their "power" comes from the respect that individuals on
that body have with Linus and the other maintainers.

Yet another body which you didn't mention is the Linux Foundation
Technical Advisory board.  That body is elected, but the TAB has
always made it clear that the primary power comes from the reputation
and moral authority of the people who are elected to the TAB.  Sure,
The TAB chair has an at-large seat on the Linux Foundation board, but
any influence that the TAB through the TAB chair might have is more
because of their work and the force of their arguments.


More broadly, the model that I like to use is "servant leadership",
and that's why I tell people who want to pursue taking up leadership
roles in Linux.  Most of the senior leadership spend a huge amount of
their personal time, and have often made career choices that have
prioritized working on Linux and other Open Source projects over
monetary renumeration.  Speaking for myself, I could have progressed
farther in terms of position and salary.  I made choices that traded
the freedom and ability to work on Linux because that was more
important to me, and there is an awful lot of what I do as a leader is
to serve those people in the ext4 development community.

This is not true just in Linux; previously, I've served on the
Security Area Advisory Group for the IETF, the standards body for the
internet, and as working group chair for the ipsec working group when
the IPSec protocols were first being standardied.  Sure, I was part of
the "governance" of the IETF, but one of the things you learn very
quickly is that as a volunteer leader, your primary power is to stop
things from happening.  Hopefully, you're only stopping bad things
from happening, and you can try to encourage and cajole volunteers
spend time on what's necessary to make forward progress.  And of
course, you can spend your own personal time smoothing the way to
enable the members of the community to make forward progress.  And
that takes us back to "servant leadership".

Cheers,

					- Ted

P.S.  Note that when I say "volunteer', I'm using this in a fairly
broad/informal fashion.  Yes, some members of the community have
companies that pay our salaries to work on Linux.  But as the ext4
maintainer, I don't have magement authority over the ext4 developer.
I can refuse to take a patch; I can spend time creating testing
infrastruture to make it easier for ext4 contributors to test their
work; I can point out ways that some particular design might be good
for ext4, and good for their company's business objectives, to the
extent that I know their companies goals or they are willing to share
those goals with me.  But I can't *force* someone at SuSE or Oracle or
IBM or Huawei to work on some particular ext4 feature or bug.
Ultimately, either individuals (who might be hobbists) or companies,
voluntarily choose to contribute to ext4, or the IPSec standard.  And
so that's why I call Linux and the IETF have much in common with a
pure 100% volunteer organization, such as Doctors without Borders.

