Return-Path: <stable+bounces-176911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FCCB3F039
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 23:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4511B204EE
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757A1D7E5C;
	Mon,  1 Sep 2025 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hfLf2hOE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48761E515;
	Mon,  1 Sep 2025 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756760445; cv=none; b=UFJhiPtDotr7ciWb/JFktLU8lnQNWcVkIBDTRHHS2QctOfe+Qi2+oBpJ/YgmZNV9uswr+6a5/Wgegjfw/xuvpuosUdM9rk1fMAM8FIy9ukv6dS+UndkHjrNrLOOACDdr9XlgoEYR8MWUVJCm1uNm6IA6/flqGepM0f2YnyQ6qAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756760445; c=relaxed/simple;
	bh=17SJeLM5fHdTDc3zgAfNajvnMi6wWr6jMtsEc6PBlXk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hrxI1ZGENOJIvpaVGz5u2gePsyUan4fS4h4PRg0/xitn/wgQmMjbyXeuW5IF7gWg83m7NXTl+5cCxOQM3CKq0qxDs/QXr2/8CxpHVycCFsDgD3MVtAApxCYBC6NmaxwADJKWjlYcQljxQQqMdkwfDZeC03w2BAxQ4ShXSsYXdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hfLf2hOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A17C4CEF0;
	Mon,  1 Sep 2025 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756760444;
	bh=17SJeLM5fHdTDc3zgAfNajvnMi6wWr6jMtsEc6PBlXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hfLf2hOEF0oj+jHfP3yfD01ar9MdRtJdsr/q8XxmC3MbUE7+D/XOlBVPBXKGHguKM
	 YIX9iAp2M0a2DQHNHIN8w6vLU6gJprz8pEwHh3Thl4nqsuVP6DaFd50OC575yrAtzu
	 VqZTY/oypQqsUizoupg9miKFK2wruEWwiO/z96Rc=
Date: Mon, 1 Sep 2025 14:00:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Ruan Shiyang <ruansy.fnst@fujitsu.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, ying.huang@linux.alibaba.com,
 y-goto@fujitsu.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
 vschneid@redhat.com, Li Zhijian <lizhijian@fujitsu.com>, Ben Segall
 <bsegall@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: memory-tiering: fix PGPROMOTE_CANDIDATE counting
Message-Id: <20250901140043.b522b4f16cb4fe52566fe516@linux-foundation.org>
In-Reply-To: <63a6962f-6ffb-47cd-806d-ec568f0b2df7@suse.cz>
References: <20250729035101.1601407-1-ruansy.fnst@fujitsu.com>
	<20250901090122.124262-1-ruansy.fnst@fujitsu.com>
	<20250901125917.e9792e5d0df12ba1c552c537@linux-foundation.org>
	<63a6962f-6ffb-47cd-806d-ec568f0b2df7@suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 22:34:32 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

> > Could be either c6833e10008f or c959924b0dc5 afaict.  I'll go with
> > c6833e10008f, OK?
> 
> LGTM as a helpful pointer, but I don't think Cc: stable is necessary for
> "admin might be confused" kind of thing if that's there since 6.1 and only
> came up now.

OK, thanks.

