Return-Path: <stable+bounces-142931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 500E6AB050F
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 22:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B2A1C27A25
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5490922126E;
	Thu,  8 May 2025 20:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE89aymo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8921D5B6;
	Thu,  8 May 2025 20:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737814; cv=none; b=S/LqkgJgJvd79d2zwYvXPLHwz9BU22eSllXpM+VC4FEeZbfxJ+Yu7vaTs8JqkgpBkTlWuITS1EH0iQ5lA9U5UfxUywlK1+f3IairCbaaDLvpua/53FF8RKGUr+yGtf6u2S8mf+R+0JMmiusowVOTiRIWpxFikI36A1uwozA7NsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737814; c=relaxed/simple;
	bh=NFIYZyU4ZlPO9IXNvf8D4jJ65kxgXjTKLnvESLhF03c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ifxtal4/m5MbMcvkYLOyZC08Myb7iCZan8yaoiD4XBzw2bjc3f/bXjUTxUPZst6auOIYL4ub3gKpqGwngDa1JT/cunz8ClDSQWrgKqTNz92X2cHHfSFb2J6Y6LIYrrp1qKnCThIF5FBKvgJURepLw+FnQAsntiVTcTKVzltHXMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE89aymo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E47C4CEE7;
	Thu,  8 May 2025 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746737813;
	bh=NFIYZyU4ZlPO9IXNvf8D4jJ65kxgXjTKLnvESLhF03c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JE89aymo9TKHtwMSvprqGcsCA5HrnXMXJfsYd7TdOFEvd4U6zUiaF5jH/JYJ1JHAc
	 ELFfBC4mndhFz7aQG9Ods6A/twTUWNgDqODb4L2/6PWvDv/CxZ9JXSrJqhWhFDDm73
	 D0Zgi9VglaSEtkP2UfOtIcV6A5u4NaUvLVBO8F+RKOt79zEX0QNVjx7Up5F8xi/84D
	 MumGob+/xu7Of9cRxx+MH2v5cUBTtYlDJlMTcYKot8ame3Q+iZLTLTDIqsHdNSpyhf
	 h+o4zUSY3J3BWSnRYFonDD6M0dm3BsJgLgqlXqZnb4U8B2Vh35a/frXEHsjKrE5i+X
	 HBF8z7ASebJaQ==
Date: Thu, 8 May 2025 13:56:50 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Pasi Kallinen <paxed@alt.org>, 1104796@bugs.debian.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Re: perf r5101c4 counter regression
Message-ID: <aB0akj1BdBeY6YiI@google.com>
References: <174654831962.2704.6099474499200154093.reportbug@deveel>
 <aBpcvG2yBtrrTie-@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBpcvG2yBtrrTie-@eldamar.lan>

Hello,

On Tue, May 06, 2025 at 09:02:20PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> Pasi Kallinen reported in Debian a regression with perf r5101c4
> counter, initially it was found in
> https://github.com/rr-debugger/rr/issues/3949 but said to be a kernel
> problem.

What's the '51' part?  I don't think it's defined.

  $ grep . -r /sys/bus/event_source/devices/cpu/format/
  /sys/bus/event_source/devices/cpu/format/event:config:0-7
  /sys/bus/event_source/devices/cpu/format/pc:config:19
  /sys/bus/event_source/devices/cpu/format/edge:config:18
  /sys/bus/event_source/devices/cpu/format/offcore_rsp:config1:0-63
  /sys/bus/event_source/devices/cpu/format/ldlat:config1:0-15
  /sys/bus/event_source/devices/cpu/format/inv:config:23
  /sys/bus/event_source/devices/cpu/format/umask:config:8-15
  /sys/bus/event_source/devices/cpu/format/frontend:config1:0-23
  /sys/bus/event_source/devices/cpu/format/cmask:config:24-31


Nothing for bit 16, 20 and 22 on the 'config' field.

Is it possible to fix rr to use a correct event encoding instead?

Thanks,
Namhyung

> 
> On Tue, May 06, 2025 at 07:18:39PM +0300, Pasi Kallinen wrote:
> > Package: src:linux
> > Version: 6.12.25-1
> > Severity: normal
> > X-Debbugs-Cc: debian-amd64@lists.debian.org, paxed@alt.org
> > User: debian-amd64@lists.debian.org
> > Usertags: amd64
> > 
> > Dear Maintainer,
> > 
> > perf stat -e r5101c4 true
> > 
> > reports "not supported".
> > 
> > The counters worked in kernel 6.11.10.
> > 
> > I first noticed this not working when updating to 6.12.22.
> > Booting back to 6.11.10, the counters work correctly.
> 
> Does this ring a bell?
> 
> Would you be able to bisect the changes to identify where the
> behaviour changed?
> 
> Regards,
> Salvatore

