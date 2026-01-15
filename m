Return-Path: <stable+bounces-209975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D84D29580
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 00:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDC20300F68A
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 23:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1353330D47;
	Thu, 15 Jan 2026 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4Cescfp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDF328B4E
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 23:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768521136; cv=pass; b=YXvUrDKP0r3/5iPsbxhTE9dfW8+6NXT72K286EqIDu/RhYzkE8dMcC++QusCnjFAg6uXbbOobDvl3FV0WSbEbG3+VJI4cd1Lr7iLDfGrHlue8kqBe/y45lnO6aV8wmK19mYl15LdZJTi0E9MKcPLaKqHM1H54W5QQXPXm6fAIm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768521136; c=relaxed/simple;
	bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcJnh5mgkAwdJ9EVnN5mGVkjd+KHrln1YLbrk5kQ6Xd4u9wfWv1yCSEHpiy77zxMiHWUGEPvBaAkmyeC1hIKFd3HJ2RqI4clqcsZBGe91mCRGFX4Q4F4tVc3FXGGnl4wUOsjqLhvbyUJA85Wp/LKjKXrYgDLRxXWfoYJ+3qVgCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4Cescfp; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50299648ae9so91841cf.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 15:52:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768521134; cv=none;
        d=google.com; s=arc-20240605;
        b=JfBIgjevEkiQgjsMBCjPNON6yJ83i32LPa0QUuS7MZnQ6DMtdcmq3HXKTOzGA4JTvc
         8cCHy8/SjF6ISUR7k8PkrkZ+gx+HMVIdZwW65Li6DTxTawteLDIDkSU9ZUD2nCfunc85
         sQtMy519UCwMM6OTfMgzSHKa6m8SA+Oj1q/q5aorjNz74VP/VU19fLXHdFh1IWvXKm4P
         V2MsDxebHOVSj5PwFnHsrJj6FJpLLgYB6Ejj+OxNviSbzuBOpjnYh+e8eJjsHjRQ/77v
         B186yiA21sCQWPVSiQ+X6mgWtdsEJIzMSq0xDzH2od9U1p/SEvAn2ldeu0ED22ZTHF5b
         NRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        fh=RAUporBsIPrhDUKfbmP1bLXuX4WC9Mk59p+vABlLxn0=;
        b=ZhoozfI9GnitXMpwP7eFigIjKPR3VKPHaG6RU0sY0gfP1a7f/geOkQmcnA/MClEqF2
         ugaOAWc27CLnE/+rGwdwQqPmVb/reWF6IJsl7ux5GtDGcf5epWOAf3A2qFUf/9G+Z//h
         XCEiPyvpy78J2RxkumV+mk2zTdnJo5C2L0fMGRyMyPjQzfG3fsBZ4ZIzGqghNNAp1YY5
         Gp/tQx1xE8dhwMdM0ZE2S38NSDe9hl/GEVkZeDMzY7OwhJU176qCXQbuaCh5jozT5E6c
         +5XID+132VM5hafGiDY6NbZITViOwCI+2yYjraCH3USxG5Z/y7W+vI65LvPIGB/0oLHK
         wrtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768521134; x=1769125934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        b=u4Cescfpn1OnVSiSBqa5nZKR9h1lcNfHd9brRMoX6LykbU79t/u6ZHYijnL8EdacAW
         KggfRA71jITgSZThXZKMuNJae4buD+CWmq5Jczne8rk/UxUJkTNpU7BBwNANHgY4nVva
         HVU0ur4wF02mbOC3Kyyi3JccpD1DcOZYa8usHmlIjVZzMXbVX1/JKbXNcf+1v4J0Gb0k
         28+ONiyejWnwjpxjqs1I5iL/+kcIHezH/2B6rIpTBdY+wnzSSRyn8dE6v084a2vdB5Pv
         jPZsoKY3Zd5Zmz/teZG3f20K/XQGeUsD6VlDjiqGEQ5VfWVfbqyKfljTkAX/9X/mNxxv
         X/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768521134; x=1769125934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ziMDC0dlNmas6gHzjHH1+PeorxqM4k3ugul/XAfwuzw=;
        b=ZnOT64t7Ajc2DNsXxUu6u8C4vctTqqn5YnsSOTmJi/1+OvcgSEimWd/cGD5T5J9YVY
         c20DP7FcDGBUTy8yawXLm4NEknxzpTXW93iV9nPPhJGX17SJWeUUU1N6qvRiq10QsRkC
         8ZGnpI46WwM/Z9QNk/Ph1AiTmzKSd4PFhMHWM3VqOsRmbvDtHRdjkmhF8IuehZCZkjaZ
         7OJp3S8/qqO+A+UGoPUolphTRCKkOK4p2f3qgcGtbS3ctTqO4gNbAzSMTw7JgS/XPWL2
         RSNg0HBluC1st8GRwjfan4HHaBCvue82lNYxYsp6gLMGmg1jIQKjK6DLMMqGAo9SHQOR
         00gg==
X-Forwarded-Encrypted: i=1; AJvYcCXMN1N3UOj6Kw+mhSdZjEeNPXCZGmIJ2VILq3PaDYtSy5kjzBlvg3YmfXOBxxBL4Ojwc6YjKpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgzHKC2S921+P/e+MG35lkaX4nUop9XbvJ8xYHpy9tSx4gSZ3
	x3ckaIvZG5+WwoiNYAQ3KqjVEwHhmABjTjarcotWN3VnN41P3jSYKDsnQmptVKXKQCZMR+F5kOY
	5hth8u/yrWva5a7YdW4v0Xcg5olg+5Y2cvzP0eC5B
X-Gm-Gg: AY/fxX49y1S+4AMTV93UbngJizG9qzXNw09BPETGRrwHdq0jkjhVpTHZg+kXul8E2j9
	63nQCQ8e1+Ncl0mwX1BMg62IqhvrwYTWxilXamwTpFjpHvQJNEg2TLxEif+nDOCfwSxsdV1lulG
	yXE9GRmotEFY7v+5CyXhcS+Sd8eUleRCtM2Czv4SfMRUZc108DiC3vExTcdPpRwwfhwes272D6/
	9cH4k4hVf5oiaCHHux/Q2DHQHhFBQa7o/hnO8IS023/lZOvYOMbVkFcGxoKT5Yz0bN2XgXEJCmo
	Z9V69Qqe8m27DBRg08J1P7hzO6CliKrRGg==
X-Received: by 2002:a05:622a:58b:b0:4ff:a98b:7fd3 with SMTP id
 d75a77b69052e-502a22cfe86mr4096151cf.2.1768521133130; Thu, 15 Jan 2026
 15:52:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-1-98225cfb50cf@suse.cz> <aWWpE-7R1eBF458i@hyeyoo>
 <6e1f4acd-23f3-4a92-9212-65e11c9a7d1a@suse.cz> <aWY7K0SmNsW1O3mv@hyeyoo>
 <342a2a8f-43ee-4eff-a062-6d325faa8899@suse.cz> <aWd6f3jERlrB5yeF@hyeyoo> <3d05c227-5a3b-44c7-8b1b-e7ac4a003b55@suse.cz>
In-Reply-To: <3d05c227-5a3b-44c7-8b1b-e7ac4a003b55@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 15 Jan 2026 23:52:01 +0000
X-Gm-Features: AZwV_QjyQPPUtH5tGDbHEFhedU3kKqiqu-2QyYB5WPZJAwFL9F8l2hS-k58cSQU
Message-ID: <CAJuCfpHCgyKTiPOZ_p76hTLRrZfQrkNh7XHJkEM0omWWCK2WQA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 01/20] mm/slab: add rcu_barrier() to kvfree_rcu_barrier_on_cache()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, bpf@vger.kernel.org, 
	kasan-dev@googlegroups.com, kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 1:02=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/14/26 12:14, Harry Yoo wrote:
> > For the record, an accurate analysis of the problem (as discussed
> > off-list):
> >
> > It turns out the object freed by sheaf_flush_unused() was in KASAN
> > percpu quarantine list (confirmed by dumping the list) by the time
> > __kmem_cache_shutdown() returns an error.
> >
> > Quarantined objects are supposed to be flushed by kasan_cache_shutdown(=
),
> > but things go wrong if the rcu callback (rcu_free_sheaf_nobarn()) is
> > processed after kasan_cache_shutdown() finishes.
> >
> > That's why rcu_barrier() in __kmem_cache_shutdown() didn't help,
> > because it's called after kasan_cache_shutdown().
> >
> > Calling rcu_barrier() in kvfree_rcu_barrier_on_cache() guarantees
> > that it'll be added to the quarantine list before kasan_cache_shutdown(=
)
> > is called. So it's a valid fix!
>
> Thanks a lot! Will incorporate to commit log.
> This being KASAN-only means further reducing the urgency.

Thanks for the detailed explanation!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

