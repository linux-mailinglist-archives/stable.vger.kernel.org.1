Return-Path: <stable+bounces-198168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53BC9DF0C
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 07:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32283A7F85
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62259288C2F;
	Wed,  3 Dec 2025 06:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbAGz/Id"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00034285C85;
	Wed,  3 Dec 2025 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764743902; cv=none; b=a231Nwjwx1dbEzDr3n91p/S0OG7OW4GWJG5K0z7uiyLiDVnavC3rCWvYJFST/Pizu8l/7O3RJeNzqqPNYBE7oetOtVN0yuDv9HBK6bW6l9Ijndt0jAkQ9l39Wy+vYrdJhcJ9eE7Qbp13MgVQfgshUUPhc83SWtEwtq0tjHjp9dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764743902; c=relaxed/simple;
	bh=+XM1mndVqIT1rszXCFeTNF26QNeMpZY6yncOwatE4o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbByl1XuR1UJEGe5GFQRENBgg+xK6iaF35ax01KzZY8FZZKjIek4tGzVQ3Yk/DzzAYLr4c8QDQVkA1E+ecYqkp7rbmNpLArW9vGzDsrDMKX0AONmxYTq0FWHfEry7TaMYi194TUA8CYiBtyh9vpCPUFkc94kySwV4YS1xgE96F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbAGz/Id; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C25C4CEFB;
	Wed,  3 Dec 2025 06:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764743901;
	bh=+XM1mndVqIT1rszXCFeTNF26QNeMpZY6yncOwatE4o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MbAGz/Idp+mJMwpHKzEWPKLovgDlr1iUrJHRRsyeJRM1sdLTEiE8LImW+6IQDqzis
	 uin3U3kbUo4zRuoucZW/xjHBnBLpgpEsThz0FFmgsBKoufxUFL2xzDu0i53IlRE2NP
	 P3xXsvk9szcTBsLLnkICLzfX6e+DPQMn80vPMhoA=
Date: Wed, 3 Dec 2025 07:38:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Doug Berger <doug.berger@broadcom.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH stable 6.12] sched/deadline: only set free_cpus for
 online runqueues
Message-ID: <2025120356-professed-criteria-0a25@gregkh>
References: <20251027224351.2893946-1-florian.fainelli@broadcom.com>
 <20251027224351.2893946-5-florian.fainelli@broadcom.com>
 <2025103157-effective-bulk-f9f6@gregkh>
 <31316499-4007-4211-add8-eb6bab565e0d@broadcom.com>
 <6df70e8d-86b5-48ce-8228-699f28f7ef2b@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6df70e8d-86b5-48ce-8228-699f28f7ef2b@broadcom.com>

On Tue, Dec 02, 2025 at 10:32:23AM -0800, Florian Fainelli wrote:
> On 10/31/25 11:10, Florian Fainelli wrote:
> > On 10/31/25 05:27, Greg Kroah-Hartman wrote:
> > > On Mon, Oct 27, 2025 at 03:43:49PM -0700, Florian Fainelli wrote:
> > > > From: Doug Berger <opendmb@gmail.com>
> > > > 
> > > > [ Upstream commit 382748c05e58a9f1935f5a653c352422375566ea ]
> > > 
> > > Not a valid git id :(
> > 
> > This is valid in linux-next, looks like this still has not reached
> > Linus' tree for some reason, I will resubmit when it does, sorry about
> > that.
> 
> The commit is now in upstream in Linus' tree, can you pick up the stable
> patches when you get a chance? Thanks!

Which patches exactly?  And normally we have to wait until they show up
in a -rc release, right?

thanks,

greg k-h

