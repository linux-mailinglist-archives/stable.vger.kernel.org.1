Return-Path: <stable+bounces-176990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752BDB3FD96
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551C82C2F52
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F932E8E03;
	Tue,  2 Sep 2025 11:18:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA632765C1;
	Tue,  2 Sep 2025 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811923; cv=none; b=UVfsOFcz2t4fQ9w/pE7DaQsmK50YXjLLWXu+XPWMTeAN4b+9v0BWoAyQdzfPhnwZHun+b7CVfirf5DLyualoPS1mV3DJ91h8E+89TX2gm/dDqa4Tm0Vji6+Rl1m1wW/2kbduO6beyd2pmm+RDqLhtkZWqKZhntsCd9DB+jz9bmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811923; c=relaxed/simple;
	bh=2YPGDIOlFICYdjgkf8GTamhWOiDyyLdTUT3dN1r6r5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6YbNdHWEVzpQX2LsWQuR0xyPKZ3w9OXQNowo7b28dkDPvTq4D5HesvqSQs9ZohUU+bqTRwJPQ2CAMb8BolWTbzSuqtK/3uN3njb7LmuCu6SZRhQPDsjMfNBTEd1sBrRfduKDv9/QvPtm3I8DijE/XMT0zgVRey1mqGKR5K9S2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3735726BE;
	Tue,  2 Sep 2025 04:18:33 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D25C3F694;
	Tue,  2 Sep 2025 04:18:40 -0700 (PDT)
Date: Tue, 2 Sep 2025 12:18:37 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jan Palus <jpalus@fastmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: quirk: fix write to string constant
Message-ID: <20250902-original-hallowed-robin-d030bf@sudeepholla>
References: <20250829132152.28218-1-johan@kernel.org>
 <aLG5XFHXKgcBida8@hovoldconsulting.com>
 <aLa__M_VJYqxb9mc@hovoldconsulting.com>
 <20250902-axiomatic-salamander-of-reputation-d70aa8@sudeepholla>
 <aLbGoctnA-Ad-Hxv@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLbGoctnA-Ad-Hxv@hovoldconsulting.com>

On Tue, Sep 02, 2025 at 12:27:45PM +0200, Johan Hovold wrote:
> On Tue, Sep 02, 2025 at 11:16:46AM +0100, Sudeep Holla wrote:
> > On Tue, Sep 02, 2025 at 11:59:24AM +0200, Johan Hovold wrote:
> > > On Fri, Aug 29, 2025 at 04:29:48PM +0200, Johan Hovold wrote:
> > > > On Fri, Aug 29, 2025 at 03:21:52PM +0200, Johan Hovold wrote:
> 
> > > > > The quirk version range is typically a string constant and must not be
> > > > > modified (e.g. as it may be stored in read-only memory):
> > > > > 
> > > > > 	Unable to handle kernel write to read-only memory at virtual
> > > > > 	address ffffc036d998a947
> > > > > 
> > > > > Fix the range parsing so that it operates on a copy of the version range
> > > > > string, and mark all the quirk strings as const to reduce the risk of
> > > > > introducing similar future issues.
> > > > 
> > > > With Jan's permission, let's add:
> > > > 
> > > > Reported-by: Jan Palus <jpalus@fastmail.com>
> > > > 
> > 
> > I was hoping to hear back, but I assume silence is kind of acceptance.
> 
> I sent the reply with the tag after making sure off-list that Jan was OK
> with it. Sorry if that was not clear.
> 
> > > Please don't do such (non-trivial) changes without making that clear
> > > in the commit message before your Signed-off-by tag:
> > > 
> > > 	[ sudeep: rewrite commit message; switch to cleanup helpers ]
> > > 
> > 
> > Sorry I meant to do that when I replied and asked you if you are OK
> > with cleanup helpers. Also yes I planned to add a line like something
> > above before finalizing.
> 
> Sounds like a mail has gotten lost since I never saw that question from
> you.
>

No I hadn't sent it yet, generally wait for builder report to finalise
the commit. Sometimes -next integration happens before build sends build
report for my branch and that happened this time.

-- 
Regards,
Sudeep

