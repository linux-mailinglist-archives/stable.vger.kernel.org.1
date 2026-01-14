Return-Path: <stable+bounces-208330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56814D1D0E6
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 09:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD64830086F0
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D16236A021;
	Wed, 14 Jan 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F4BjAfHV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE226ED35
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378717; cv=none; b=CLViJuBLQW6Hkrqj1FsriTMUClBgsveLcUuTpRL0ONsxFIx1kNAobw5sW/r2AMaNNOlrwtgveJvvnToi/jaAtAvU3JpYQCBlpIjLlAe2+1jr3b4B5F56wPOhiC36fsh5wuAfrbFmrkgySujMrl/qc+K8Cz6uZp0l86xJbZtpXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378717; c=relaxed/simple;
	bh=2rIhPbY6ae6VI8ZyQYMQitssWKnS1Vd903IkWFk6G2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob+KzP6BHXv6JRFywqMhOizxmxXVRZXeEDgeycQ8scRMQzAcCdgISO5LFITJknYbbQWcVRN54gWoor2pYXdNGAGbkgRUZ8XKlwi+zAU21Gfs1B4yhYSPY5MHqwfFOIeYd+BILTD4BSEZu9DJxr/uYO72vX4NmTs8VX3H/m+M/zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F4BjAfHV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so4606967f8f.2
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 00:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768378712; x=1768983512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X8y3eBpdpZ4jiLb2IpPbzYhjPFac6qto4kOtboVZXAA=;
        b=F4BjAfHVOTbK7cj4O4iZiH6hCLmrvT4Ll85x5Dz6S181097YQzaaxbgP9HLTsUcuJ2
         qejf6vtPbIfYJft3cbwhKpiEekG+gvXKj/YhABoZm/66yEY1j1qhkMD2nvp1giR1ZDvF
         zunpkz2XURefF/mKvsO6G/IO4rmxSnk98dSWz3bu1iY1yyEcC+rgVdYhIBNIpoKwg059
         KXhJad3CRVlJU08HtUl9MugxEE73SmKH74uqOjerQgLYhXNHh3hgiYOezgEGZMhAAarA
         XARBM4r/C6NouBuQ84VP8ZQdqn0iVgsZJelHp0gQADRth5EI0jbbPrscR6Rl+SU3J5fT
         nmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768378712; x=1768983512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8y3eBpdpZ4jiLb2IpPbzYhjPFac6qto4kOtboVZXAA=;
        b=kDSMxaLprRnT9mFbg7ls+IKiReDMrC4SJLVi8VXRSHdSxo/KwEtQnSfxRZHDvahFBM
         5VXZ49X8SlNisN5e7BdG1sWhY9wUXlGF62pFJ6WDkqmFpdp9XCHzd2I8Z0D4IKr6pD+w
         XFypokCGYHufJfyIFoypZF2jk+b1F/wgK7yau5YrucX4fG1OlHxzxc5LRtqkqz8VKC6y
         BnFdlXuO1ugG//fU1Np4IplsonbuMyK++DdrnwDlUOqcBwvztQS+7NnYrmXStiqO1TVF
         FM6uwghEwd/eSqppzFMUENvvWq91gZHFTmcADiSvKnA5pHTkGUxbI1ngpOusHg8bBz1i
         +ivQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaX/qElG+hbau1UsgJF/8TsYGXvZNhmydWD7/j4iSOV+IvS+uANN6I9kQUgdDTY+vgF+4FAm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwGgnOabg0+z5uh+eO8Kz8BtLoJbVa9J84TGA65gOLLyC3y5xp
	kOPXuNjohHyaP7kEA3mqB+jb2DTFhdOPW3DfuSEB33hCRpkscQGbg6186G5fVCR4HZQ=
X-Gm-Gg: AY/fxX42v/Rb0UzP28lnKCT4GuoKHmvKBcAY71DOsGQSfwjwb2LuU6uskG3GyiL7wWp
	pV+BKpkiJTt5v2G4eFvnhXK6N0RovPMz5uTmb25NV04R29BslWBKqE4y+7CVQ+qFDO47G8i2wgb
	BazpqfMS+nOU+gWjC/bhnHY2dO6mZw4YakfBJCX6NWhkuZU9gLFu+6xrnF4MwimZ6KHrguycR+y
	7T9CYZ37Gj2cfMn4Y6RmdKTESDNub6tgpEBELNG9lqOp9nuPlOaARC9rndsZGNWiC23iUApzo+G
	JMJAltvPZIfQ5QUYvlEFukh2lxeEav3+xmWz0dpVMo+9gFuTHGZ23mjOZI0d1MN9LiF+4i9OMw2
	ykIvcc7OTFoatrv5VyHZTLNSKJxaGtciQVJcsZYibNYEu2Bvy4iM0g4dU2SqgWs+fYWf951kfYa
	QEv7TgCKRPEPUgdDuy96CWdJyNnJUD+c2cbBo=
X-Received: by 2002:a05:6000:1a88:b0:431:327:5dd4 with SMTP id ffacd0b85a97d-4342c557825mr1897922f8f.46.1768378711829;
        Wed, 14 Jan 2026 00:18:31 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacc5sm48487321f8f.5.2026.01.14.00.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:18:31 -0800 (PST)
Date: Wed, 14 Jan 2026 09:18:29 +0100
From: Michal Hocko <mhocko@suse.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	stable@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] mm: Fix OOM killer and proc stats inaccuracy on
 large many-core systems
Message-ID: <aWdRVY6Bzw2kjedk@tiehlicka>
References: <20260113194734.28983-1-mathieu.desnoyers@efficios.com>
 <20260113194734.28983-2-mathieu.desnoyers@efficios.com>
 <20260113134644.9030ba1504b8ea41ec91a3be@linux-foundation.org>
 <c5d48b86-6b8e-4695-bbfa-a308d59eba52@efficios.com>
 <20260113155541.1da4b93e2acbb2b4f2cda758@linux-foundation.org>
 <162c241c-8dd9-4700-a538-0a308de2de8d@efficios.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162c241c-8dd9-4700-a538-0a308de2de8d@efficios.com>

On Tue 13-01-26 20:22:16, Mathieu Desnoyers wrote:
> On 2026-01-13 18:55, Andrew Morton wrote:
> > On Tue, 13 Jan 2026 17:16:16 -0500 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > 
> > > The hpcc series introduces an approximation which provides accuracy
> > > limits on the approximation that make the result is still somewhat
> > > meaninful on large many core systems.
> > 
> > Can we leave the non-oom related parts of procfs as-is for now, then
> > migrate them over to hpcc when that is available?  Safer that way.
> 
> Of course.
> 
> So AFAIU the plan is:
> 
> 1) update the oom accuracy fix to only use the precise sum for
>    the oom killer, no changes to procfs ABIs. This targets mm-new.
> 
> 2) update the hpcc series to base them on top of the new fix from (1).
>    Update their commit messages to indicate that they bring accuracy
>    improvements to the procfs ABI on large many-core systems, as well as
>    latency improvements to the oom killer. This will target upstreaming
>    after the next merge window, but I will still post it soon to gather
>    feedback.
> 
> Does that plan look OK ?

I was about to propose the same. 1) is a regression fix and should be
merged first and go to stable trees (it is a low priority fix but still
worth having addressed).

Also a minor nit. You do not have to send cover letter for a single
patch series.

Thanks for working on this Mathieu!

-- 
Michal Hocko
SUSE Labs

