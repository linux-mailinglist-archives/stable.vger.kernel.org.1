Return-Path: <stable+bounces-66403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1195A94E668
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 08:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC8A281FE5
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 06:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3614D6F6;
	Mon, 12 Aug 2024 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sfsHQ+EL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDDSm2Tu"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490873715E;
	Mon, 12 Aug 2024 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443178; cv=none; b=l3XtjdUHu4XfL1MlseGDfI8IGk+8tgqT4JaDlJCDdEisZxFKkREV9l1HtwxlKRJ6MLiRQ1FD1mg1gQdf3cfFaQFExrEOGSJORRr/Iqq7KzzSdFi5RHG2lojUKz2yewlFcKrX5xFGyB2/J6vxXm1gWqVsL7v6NcOq7XWb/0tKQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443178; c=relaxed/simple;
	bh=elooEO8/ikuObwPR7MuCh2nfrwQ+qWw2D5YKI/yz/sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKT66qeN+DhfZu+OMf8sXLhAxqdJbMDJtSeOlnabP2UKzS6tdASdNuGOMP+ISdB3TmV1n9EANbabCh3Cz28+FvJ2Z1T2QsvMEq2mZLpHZIaRzAN0L39rRYdXaiWrimJeSv5ha15rpDUeekrIjQ0Pzck6g8sXoqWMYaIVtV7hmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sfsHQ+EL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDDSm2Tu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Aug 2024 08:12:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723443168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqvaJ1JCZQHeQ4qFWJxOUII9jzdb07rHkQ1ZA4lhHMg=;
	b=sfsHQ+ELC8clbAnthZIWkj9W/w4aK7MzOqWceLMawxmXQnWGHwM2V/0ll5vWkOqTBZvKmu
	/tuwQ0ErEQbiU/8deP4W6E5+Lbo6KdM/niy7TQ8T70WZZ9NQ/H+zfLI7lceu0O+eWL3qCL
	NafCIB3b9qSEazkPBbLA8jzDPMv4C1xEB8B75bpA/oKc/K8kOMVH9SBrW5kExvtLMoECdd
	IK0ZdcOPQZ85NuCMfJ+vmiAlPZNt/q2xis3AmltH7VutHPDgIeDshfeHETiBrtfhRc6tIy
	IZ8GgvU8IbJVS0u7xTPreoVQxDaZM+jx5xtDlBqPKe+ChztFY9qebyVPtdxJwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723443168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HqvaJ1JCZQHeQ4qFWJxOUII9jzdb07rHkQ1ZA4lhHMg=;
	b=bDDSm2Tup4YSicCIV+YIZjOjQDjNFuUVGqVAxBrYapkC2+3UccNunUhbE0KH6nFZ66ufot
	MJOP2Zz+NYxIetCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "net: Reference bpf_redirect_info via task_struct on
 PREEMPT_RT." has been added to the 6.10-stable tree
Message-ID: <20240812061246.pOuivUqI@linutronix.de>
References: <20240811125836.1264962-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240811125836.1264962-1-sashal@kernel.org>

On 2024-08-11 08:58:35 [-0400], Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
> 
> to the 6.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      net-reference-bpf_redirect_info-via-task_struct-on-p.patch
> and it can be found in the queue-6.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

To quote Jakub:

|On Sat, 27 Jul 2024 20:52:53 -0400 Sasha Levin wrote:
|> Subject: [PATCH AUTOSEL 6.10 10/27] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
|
|no no no, let's drop this one, it's not a fix, and there's a ton
|of fallout

Please drop this one from the stable queue.
 
Sebastian

