Return-Path: <stable+bounces-80582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46098E017
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6CCB2814B7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5561D0DF9;
	Wed,  2 Oct 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3wpbkrE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42033D1
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885043; cv=none; b=Mfq1qHhC8ceE8ByqyhIUrvfy+KpO4otzwnSeu3vLI6cn7yBolcknSjIh8Ouc4krdTlaCgo2gqvjb6FZzlcBbH1pL8M4+BkZMn022aeUKQBMBA+1EXRj8fyaA3wuYw4k30vvojBKgpmkQqv1VPRTaOgYUn30+5iHQouUnoisJQ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885043; c=relaxed/simple;
	bh=xll5ewsNSWb8KrDgYCL/pj1w4tjE0i3lMugj8Y5arWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiZTFr4GtwXXrTM6fFTNwJVUUTFJ0dejJ/iGGN/UOWob8bD8oEW+0kt4t5c9O6ds2qyZ308J2u9MZUXmxC21fvMWdOE/+osr/kEjOqiqA8Iut1TfD2FpbfoQ457+bkd1IEsVAkbvdDBi9onorItuOF2wApYa44zvDOv349Vx1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3wpbkrE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727885041; x=1759421041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xll5ewsNSWb8KrDgYCL/pj1w4tjE0i3lMugj8Y5arWg=;
  b=n3wpbkrE7rWSq9v7mhp4MvbGq6pv7jnwnlZYfpUjR6bXTSgqAS+YEeLt
   dCAyg5KeVC09Q2nbyEsNki9GhMet5anwqRlRPw/FumXI6fvij4V2do8Ck
   4jRf9dRMuntsN8q1fp+VbgJoKQyxZx6xFp3tnp/GRx3/oTUW/fK7oNFss
   cE8WrGE7tZzPN3oTMAmpuuAzzw1D2WCj3xpY7S9rEgZ+ts27HyaLsTjV2
   mbNVISSjLuqbQ7APHkqPlPeTdPN+eSNr3Hhb+Lp1V8O7IOOL5+AGMaErT
   GVDwfEN86JI56vdwJwlNxiA70CF7yp530FMUDNkyKHiqMKttuvus5ar7/
   A==;
X-CSE-ConnectionGUID: kNg0KkM5QLexOhFoOu0XBw==
X-CSE-MsgGUID: VC1KYi+FTg2xlttQcyE7Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="30848084"
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="30848084"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 09:03:59 -0700
X-CSE-ConnectionGUID: vFZ3zjy5RfKgid1YAEt8Sw==
X-CSE-MsgGUID: ed/HeQCpQ4CIspbItsQLBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,172,1725346800"; 
   d="scan'208";a="78579028"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 09:03:58 -0700
Date: Wed, 2 Oct 2024 09:03:56 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Kan Liang <kan.liang@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Changbin Du <changbin.du@huawei.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 247/538] perf callchain: Fix stitch LBR memory leaks
Message-ID: <Zv1u7P2GlV6w7WJZ@tassilo>
References: <20241002125751.964700919@linuxfoundation.org>
 <20241002125802.002549697@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002125802.002549697@linuxfoundation.org>

On Wed, Oct 02, 2024 at 02:58:06PM +0200, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Ian Rogers <irogers@google.com>
> 
> [ Upstream commit 599c19397b17d197fc1184bbc950f163a292efc9 ]
> 
> The 'struct callchain_cursor_node' has a 'struct map_symbol' whose maps
> and map members are reference counted. Ensure these values use a _get
> routine to increment the reference counts and use map_symbol__exit() to
> release the reference counts.
> 
> Do similar for 'struct thread's prev_lbr_cursor, but save the size of
> the prev_lbr_cursor array so that it may be iterated.
> 
> Ensure that when stitch_nodes are placed on the free list the
> map_symbols are exited.
> 
> Fix resolve_lbr_callchain_sample() by replacing list_replace_init() to
> list_splice_init(), so the whole list is moved and nodes aren't leaked.
> 
> A reproduction of the memory leaks is possible with a leak sanitizer
> build in the perf report command of:

IMHO this doesn't meet stable criteria. It's a theoretical problem
that only causes noise in leak checker outputs, but doesn't actually
affect any real user.  The memory is always freed on exit anyways.


-Andi

