Return-Path: <stable+bounces-177524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A613EB40BB8
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 19:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E6F3B3E13
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 17:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F11310654;
	Tue,  2 Sep 2025 17:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDxav9HH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78201C7012
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833103; cv=none; b=TYx1CIUteOk7F0IdnEiyd4Rq+x/FZs27JLHsXTJiA+Ey/IUDewg7Skq7zxoogilsAmAI3oOV8maXXi5yH3jhQvvzJ94xGeQlx/6qAql47PaK/oMwKAhkKoCcfcI8vgNmpbuUcAs0osC7J5xNjutdpKgopa2Msbjy5WarcEB/BTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833103; c=relaxed/simple;
	bh=eHDh6EYEf8otbCErhsJ5F0gjruWxqH5WeQD28ohPUHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EjiaC+CxwXmZZfZp1I6h30+ueK+6ZxgE6wZGMjAKh2xMSe/v5tsLtDCii91NEB6dOt8yvUlHFHQspIwszLs0ARjpxalWkBjevYrfqql55cDLFfEOLrE4ruk4Xgqcn/bwXumKzGV+LwbC2R2dil6h9h42bp7TMZp2aHlpoKrewNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDxav9HH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32307C4CEED;
	Tue,  2 Sep 2025 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756833101;
	bh=eHDh6EYEf8otbCErhsJ5F0gjruWxqH5WeQD28ohPUHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cDxav9HHZzqMdr/ZnjNaKvlJZ3DRDWJl0oGzPYf9mT+uXo+l2AtdhnqCjZla064pX
	 puyhUGaLIyYYgnDVR9x/v3+cjhW7pk33gNGG4QUZDSRH8zYIELNx/h0F8EZ54vQE7w
	 jPN7EsxAB24MSrvSqGCKRqY0NVkm76RHRBnz1MKbSzuerstEXuKWzInV0uaaqcMd9U
	 lCIATpp013sFEyyHLBat8hIfxrY/i53uQzjW6wLRE+olH50ZsT+vi4Klr6JkKtOv/r
	 5Z7qtxaoq2dVKW0qMRMmA1ZvzToFShFLktlUUsukhSQrCaGgNKkOR0fN61POnkuR0I
	 Vh/OpQBTmPi1w==
Date: Tue, 2 Sep 2025 13:11:39 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 6.1.y 0/1] Backporting patches with git-llm-pick
Message-ID: <aLclSwgwIhaMjE88@laps>
References: <2025011112-racing-handbrake-a317@gregkh>
 <20250901153559.14799-1-nmanthey@amazon.de>
 <aLbZoQrlED0PN0pc@laps>
 <f0f5fd8da13d000355166d9eb87e24ddc1b8fa70.camel@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <f0f5fd8da13d000355166d9eb87e24ddc1b8fa70.camel@amazon.de>

On Tue, Sep 02, 2025 at 04:22:40PM +0000, Manthey, Norbert wrote:
>On Tue, 2025-09-02 at 07:48 -0400, Sasha Levin wrote:
>> One note about the tool: in my experience, unless the tool can also act as an
>> agent and investigate the relevant git repo (and attempt builds and run tests)
>> on it's own, the results used to be very lackluster.
>
>I agree in general. On the other hand, we want to keep the amount of work done by
>the LLM or agent small. For now, we only submit a bit of context and the commit
>messages. The validation is executed by the application independently of the
>agent. There is no feedback loop yet, or similar -- that could all be done in the
>agent-stage. We have a few more filters and limits to only process commits that
>are likely to be finished successfully by an LLM.

Consider a simple backport example: let's say that upstream we see a patch that
does something like:

   mutex_lock(&m);
- old_func();
+ new_func();
   mutex_unlock(&m);

But when we look at an older tree, we see:

   spin_lock(&l);
   old_func();
   spin_unlock(&l);

If you don't pass massive amounts of context in, there's no way for an LLM to
know if it's safe to simply replace old_func() with new_func() in the old code.
Most LLMs I played with will just go ahead and do that.

A human backporter (and most likely, an AI agent) would have a lightbulb moment
where they go look at new_func() to see if it's safe to be called under a
spinlock.

I guess that my point is that at this level for this usecase, LLMs don't end up
being much better than using something like wiggle[1].


[1] https://github.com/neilbrown/wiggle

-- 
Thanks,
Sasha

