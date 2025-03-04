Return-Path: <stable+bounces-120256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD77A4E469
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727D28A4DDF
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EC227FE62;
	Tue,  4 Mar 2025 15:29:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783825FA09;
	Tue,  4 Mar 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102149; cv=none; b=MqRWiSCGw4Or1Bg9RN24jKQECtjQPl4bGa3QI6k1gZUANw9u45uo1Z6fd1byzN4eb/HIYZDot2LfbrU7ZWKWx0MgZK4n+Lcs9EiYYBie9zMvbyv0rJ32gZ/QZ0tEIwfnUugiAhFsyu60AkSsJWq4q7W+HGG19KODZhNyOzFx268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102149; c=relaxed/simple;
	bh=wbtGl0lCnE8nAV1/goGKCAbFgaxifBaCjwluc+3tZwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRRmgR9JeZUApltYekEFNkhx+0NZYzVCaaM3LES0Z7P2T7QpH7igdAXNK3XYv/0e7WcqXQwjZPvvJXMH7vhSAqUI6ZcbGQuy157hahBxZNG1zOGCP8rMrR1dev+HRpMc9zD3wbgQBFP3yNSG07q/7Tqjg720wIoA2kAj0Vy857s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B918C4CEE5;
	Tue,  4 Mar 2025 15:29:07 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:30:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Harshit Agarwal <harshit@nutanix.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, Jon Kohler
 <jon@nutanix.com>, Gauri Patwardhan <gauri.patwardhan@nutanix.com>, Rahul
 Chunduru <rahul.chunduru@nutanix.com>, Will Ton <william.ton@nutanix.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Message-ID: <20250304103001.0f89e953@gandalf.local.home>
In-Reply-To: <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
References: <20250225180553.167995-1-harshit@nutanix.com>
	<Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 09:15:55 +0000
Juri Lelli <juri.lelli@redhat.com> wrote:

> As usual, we have essentially the same in deadline.c, do you think we
> should/could implement the same fix proactively in there as well? Steve?
> 

Probably. It would be better if we could find a way to consolidate the
functionality so that when we fix a bug in one, the other gets fixed too.

-- Steve

