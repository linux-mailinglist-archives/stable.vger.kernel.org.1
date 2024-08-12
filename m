Return-Path: <stable+bounces-66468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E794EBDC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AA41C21337
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA64175D2A;
	Mon, 12 Aug 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgCLHkgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE67130495;
	Mon, 12 Aug 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462386; cv=none; b=IUOQObOoMN9tTc0Yju3vaGhCqo/hW397xhF4+z0yge0fA19XjSXbqCiM77A3lCV4/4Sj/ABFfByqipxzBLNIWoLOYu1lnZFTtkwmJ36i/rrSt0iozPD9o0Of70VdZDzfybYmlHqf3M+uHPsgfsS80Wykjh3WqPEJ1wDQIdmuA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462386; c=relaxed/simple;
	bh=y5L4okBvgLnBNb+NTAOKCQZPOdCYmHMWG+7QyCYNXbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0F7gTFv+raFQ3Sjm0AEY7mDX392M1Empi2Ueu1eofYCGMWC0RcLTiG/ijhBvBGGFBnaPRMfRCXShaQNpw5DIjq4eV8OkV+pYVzgT17qalobNWSi3xU5TncLKHP4VXo6MEIZGok2JNGJD1JghGbFXlreXDSWVOYQG0h9RDFMpjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgCLHkgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC57C32782;
	Mon, 12 Aug 2024 11:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723462386;
	bh=y5L4okBvgLnBNb+NTAOKCQZPOdCYmHMWG+7QyCYNXbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgCLHkgXqpatWupyfcMrUvlAecsBEwlH2YL+Kl7AT7cApk8DBByCMOh/+YRfaTmfL
	 +ZVGVCKF4ZX1dAORDgx+9ZZjR8WTG9hIWDDlX10u1Iabqqu4FxLPZ0OgC9y9/iUWzq
	 FUoV/mwpfM8dST9+yDnP+QxH91SLDXB3/HjKk+V80cX1N8u3tU7YQGVt1ndcSLCru8
	 edyMXp15dV6OLfHUdlesbQK3CslVrXtCq/cjfHOfc9PoomucqNGAMVlw7m0EJV2trc
	 Cz85vX358Vr2uNwR1Naq0F+dDi5N1odE1VSlDg8jru8W89diRRua21U0Nj2ZRaXHEL
	 /SMzCfkLWmPAg==
Date: Mon, 12 Aug 2024 07:33:04 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <Zrny8ML-LCIE7-5m@sashalap>
References: <20240811125836.1264962-1-sashal@kernel.org>
 <20240812061246.pOuivUqI@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240812061246.pOuivUqI@linutronix.de>

On Mon, Aug 12, 2024 at 08:12:46AM +0200, Sebastian Andrzej Siewior wrote:
>On 2024-08-11 08:58:35 [-0400], Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
>>
>> to the 6.10-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      net-reference-bpf_redirect_info-via-task_struct-on-p.patch
>> and it can be found in the queue-6.10 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>To quote Jakub:
>
>|On Sat, 27 Jul 2024 20:52:53 -0400 Sasha Levin wrote:
>|> Subject: [PATCH AUTOSEL 6.10 10/27] net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
>|
>|no no no, let's drop this one, it's not a fix, and there's a ton
>|of fallout
>
>Please drop this one from the stable queue.

Already did, sorry - this was a mistake on my end and it was already
fixed :)

-- 
Thanks,
Sasha

