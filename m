Return-Path: <stable+bounces-58043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774D92758C
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 13:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3092B282BF7
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037351AD9D4;
	Thu,  4 Jul 2024 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VdNLFNnE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649514B078;
	Thu,  4 Jul 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094089; cv=none; b=Mf5J8PHWursvnsVTPBqmwcXa8zmtw6RvZWsWwHlZF5DnjJODwrnkD9Rod4fomSgMOUj1rono2SavwxDPaCGyGjrtX/raxx2kFNibginHAm4+1FforJk0xinIUbGkoVTi7xUoWfV5UkWRPTYx5bjrvYy5kpwQQmaiEsbrhWzEpqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094089; c=relaxed/simple;
	bh=kl9XkKFbLG8/cbOoGcnf0G2TA157gAgTav5mc9Tz9mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdkTAyFisWg4SNvLJehA6XH/Z7b9eJrVUFJne7sQzWoOS+vtaAGg5ivsMYB3uQA6xRK4Am4n5/ZWCVF411PP14GGiUfSCPpVHlt/jaUuIdkjIEytJX3GN0T6qI+tiaSb15Fl6JGEcD4Z1LEgBq34I6eDEvcuT7pJXuRirknu2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VdNLFNnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8260C4AF0A;
	Thu,  4 Jul 2024 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720094089;
	bh=kl9XkKFbLG8/cbOoGcnf0G2TA157gAgTav5mc9Tz9mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdNLFNnEeg09B2Du5hdaglmBnpQb4YpGCY1fFY+n9RN84QB/EyxadevuGDZRWM6+K
	 c2twI58mEvTjsigqDX9PIsE3nPRn3+yJd+OqX75YoXnfOpqagxA0d51RL66QDoAVJR
	 zjaIpjySpyrLrIkyNioQf1JRnvCvUn5lr46UQJaM=
Date: Thu, 4 Jul 2024 13:54:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Austin Kim <austindh.kim@gmail.com>,
	MichelleJin <shjy180909@gmail.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	ppbuk5246@gmail.com, Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH] tracing/net_sched: NULL pointer dereference in
 perf_trace_qdisc_reset()
Message-ID: <2024070441-stool-quit-b846@gregkh>
References: <20240702180146.5126-2-yskelg@gmail.com>
 <20240703191835.2cc2606f@kernel.org>
 <2024070400-slideshow-professor-af80@gregkh>
 <6391f34a-b401-47e8-8093-d3b067f26c1b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6391f34a-b401-47e8-8093-d3b067f26c1b@gmail.com>

On Thu, Jul 04, 2024 at 08:16:34PM +0900, Yunseong Kim wrote:
> Hi Greg, Hi Jakub
> 
> On 7/4/24 6:32 오후, Greg Kroah-Hartman wrote:
> > On Wed, Jul 03, 2024 at 07:18:35PM -0700, Jakub Kicinski wrote:
> >> On Wed,  3 Jul 2024 03:01:47 +0900 Yunseong Kim wrote:
> >>> Support backports for stable version. There are two places where null
> >>> deref could happen before
> >>> commit 2c92ca849fcc ("tracing/treewide: Remove second parameter of __assign_str()")
> >>> Link: https://lore.kernel.org/linux-trace-kernel/20240516133454.681ba6a0@rorschach.local.home/
> >>>
> >>> I've checked +v6.1.82 +v6.6.22 +v6.7.10, +v6.8, +6.9, this version need
> >>> to be applied, So, I applied the patch, tested it again, and confirmed
> >>> working fine.
> >>
> >> You're missing the customary "[ Upstream commit <upstream commit> ]"
> >> line, not sure Greg will pick this up.
> >>
> > 
> > Yeah, I missed this, needs to be very obvious what is happening here.
> > I'll replace the version in the queues with this one now, thanks.
> > 
> > greg k-h
> 
> 
> Thank you for your hard work.
> 
> 
> This fix need to be applied versions in +v5.10.213, +v5.15.152, +v6.1.82
> +v6.6.22, +v6.7.10, +v6.8, +6.9
> 

Already done.

