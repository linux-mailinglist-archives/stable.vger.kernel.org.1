Return-Path: <stable+bounces-185722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7DABDAF06
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 20:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203883AA878
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C247296BBF;
	Tue, 14 Oct 2025 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6MEE7mJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFB213E9C;
	Tue, 14 Oct 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466345; cv=none; b=qxuSMCN8SIyumqKwC9d/vhpUE52zpmNruQf6Y+EjcAuR3VR0b7duDTTqGf9t6C4ZW5lMt7l4YZWx08NgqW9nnHiLb22IvS24y8N4eNdgQlZwGXXtmjwaOBrg01ZipVUVmnmLT10c2zrbO04lC0Zd4TUI+id3I/afxuyS/9uH62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466345; c=relaxed/simple;
	bh=LAfkOdACrQ3d5VwlIx954g+/KHg9ZXj3o8sOyRUM4Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qu3/yufePsCWbzr0HIJZ75QDrZ85rAhRJhKCWL1Oe1hURr4OiRZMlsNsF+QdUkbq/SobQlpSA3tqdxY8B2QdNAp+lf/84sLWMOyPAxAJyWhBc2EYHEK92jJimatjv9DDrkYiZCUQIifyB8jWkoCA41jTJ9dqdWNEvVIDxQizDaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6MEE7mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C42C4CEE7;
	Tue, 14 Oct 2025 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760466344;
	bh=LAfkOdACrQ3d5VwlIx954g+/KHg9ZXj3o8sOyRUM4Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6MEE7mJcgu00erqCJOXmjiHlJV4ZH80c0BzNQzkPdTeGftkgZ5dSxYgfaNlsxTtC
	 GsD8FHsx/CpZGWHlUwy3Nr4hjSKGxRhz7lnnJY7obi8vcCdvOSlD3TIzw/3gSYK4E1
	 vQpWDjTdF/lijEdy1qZDsoI1qzRUpZcDq3vWZX8uKRm1hpTi2QVGgO7apiiUBPEok+
	 KvK1l6wYrCGRh6ExczqXY1t/ZwuE3MxLX6WX18oOw8h3Lb9FyfKUulsLLnk8Tm4Uk9
	 lsxCgCw9+XD3JIRW7BMvo1hL+ctd2jSj0ENOhL0EROgfKG7MTXlTYHy5HyRkGOHKxE
	 3zF1RlLIpIu+Q==
Date: Tue, 14 Oct 2025 15:25:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix bool return value in gzip_is_compressed()
Message-ID: <aO6VpLGVG5OOHnOY@x1>
References: <20250828104652.53724-1-linmq006@gmail.com>
 <4ecf3e76-27f8-47fd-a07d-7da2489af55f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ecf3e76-27f8-47fd-a07d-7da2489af55f@linux.intel.com>

On Sat, Oct 11, 2025 at 11:48:56AM +0800, Mi, Dapeng wrote:
> > +++ b/tools/perf/util/zlib.c
> > @@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
> >  	if (fd < 0)
> > -		return -1;
> > +		return false;

> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

