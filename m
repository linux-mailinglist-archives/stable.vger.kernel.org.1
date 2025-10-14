Return-Path: <stable+bounces-185596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57402BD813E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A9419230E5
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5B630F815;
	Tue, 14 Oct 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S5sYnA0x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889281D5AC6;
	Tue, 14 Oct 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760428964; cv=none; b=glxOQMfccU/BNvziK3azQaajJsP6V53Vu3eHy1t3aFOcZ4LgyOB2Ek3DARhusRxr5nQkfO1tJsnPk2SnejwiFPYLo7os+dSdfbHHeTAYFZVNfOqfLV/+M9T71rASJgg0gkcJWuVgoIX2+qbggc6+qG3LpVjBCWGYmEimYIw6u8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760428964; c=relaxed/simple;
	bh=dGBxSxLw0RN6Zij1QQZIpEgNum+sah9NeStZCIuXt5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbFlmnSdtd0EgYiuExD1QtwYA+rgx+MuermYT77u8Pmcjaobz1dhYd+uK6Vp+y+JVE/n6elUQckR/Ll4A0eZkJm8RHBcEuc/uv634azBOpobyA/1QSloOUWOLFF0FN62lEAk4EixLGQBbrkXU1aKDlvN30GaeBE7mrTsCwF/TfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S5sYnA0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AD5C4CEE7;
	Tue, 14 Oct 2025 08:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760428964;
	bh=dGBxSxLw0RN6Zij1QQZIpEgNum+sah9NeStZCIuXt5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S5sYnA0xKvEFRdaB05kNJp6g26WnjSak25gaLqR5seEdSU5H+eecEVlfCBI8A5XzG
	 f2NyGsgJ0asYF0AQ1tcltxc2QgKHxZZ/T3G04XW50dtoHtPYZAFF1KId/SuRioqGO3
	 o0NTHfsb6WxYcNYIxEa9UXa/j7AFIq2pezB+b5z0=
Date: Tue, 14 Oct 2025 10:02:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <2025101421-citrus-barley-9061@gregkh>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <2025101451-unlinked-strongly-2fb3@gregkh>
 <zfmoe4i3tpz3w4wrduhyxtyxtsdvgydtff3a235owqpzuzjug7@ulxspaydpvgi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zfmoe4i3tpz3w4wrduhyxtyxtsdvgydtff3a235owqpzuzjug7@ulxspaydpvgi>

On Tue, Oct 14, 2025 at 04:54:45PM +0900, Sergey Senozhatsky wrote:
> On (25/10/14 09:47), Greg Kroah-Hartman wrote:
> > On Tue, Oct 14, 2025 at 04:43:43PM +0900, Sergey Senozhatsky wrote:
> > > Hello,
> > > 
> > > We are observing performance regressions (cpu usage, power
> > > consumption, dropped frames in video playback test, etc.)
> > > after updating to recent stable kernels.  We tracked it down
> > > to commit 3cd2aa93674e in linux-6.1.y and commit 3cd2aa93674
> > > in linux-6.6.y ("cpuidle: menu: Avoid discarding useful information",
> > > upstream commit 85975daeaa4).
> > > 
> > > Upstream fixup fa3fa55de0d ("cpuidle: governors: menu: Avoid using
> > > invalid recent intervals data") doesn't address the problems we are
> > > observing.  Revert seems to be bringing performance metrics back to
> > > pre-regression levels.
> > > 
> > 
> > For some reason that commit was not added to the 6.1 releases, sorry
> > about that.  Can you submit a working/tested backport so we can queue it
> > up after the next round of releases in a few days?
> 
> Sorry for the confusion, the commit in question presents both in
> stable 6.1 and in 6.6 and appears to be causing regressions on our
> tests.  I copy-pasted wrong commit id for 6.1: it should be a9edb700846
> for 6.1 (and 3cd2aa93674 for 6.6).
> 

The point is still the same, commit fa3fa55de0d6 ("cpuidle: governors:
menu: Avoid using invalid recent intervals data"), is not backported to
6.1.y, it is however in the following released kernels:
	5.10.241 5.15.190 6.6.103 6.12.43 6.15.11 6.16.2 6.17
so something got lost in our trees and it needs to be backported.

I need to knock up a "what patches are missing" script again and sweep
the trees to catch these types of things.  It's been a year or so since
I last did that.

thanks,

greg k-h

