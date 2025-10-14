Return-Path: <stable+bounces-185724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A823BDAF3F
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 20:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F1319A0B44
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85729D279;
	Tue, 14 Oct 2025 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7dqFvSR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD826FDA9;
	Tue, 14 Oct 2025 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466851; cv=none; b=YJuQbDlyYuVT6nrg+d4piOCgktlbqUb4gnOhqqMdwq7d7aQyLNxKiW3d5kVSxBdQSySMhDNdI5uZxNr3PVIIVuis4QR2tOx1LRc1s95/VNsItnst863sSP+SrxCdLgHzOkKPEVXyLYa5PzEbnNX/i57Z5382+o+GudRF91j1dR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466851; c=relaxed/simple;
	bh=PLQupHxYSg9wOyJFOAJ7+pbMGjt8o2y2t9mkr785clw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScJasJccMfHLvVGbHuPZDW/qIeQDomAuJ2A5vECUtgWwaI+mL1EJHg1XLGFzbyzmtLa/WHwQ5uTz70Q+jjin5glKv6b/imm4wncGF+q5IezV3qmYTr9bHftxmBW5WRNFdwND3Acvu6sMyrNv5VeQrFHXto8cTsh+SpRaYmuDepQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7dqFvSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCD5C4CEE7;
	Tue, 14 Oct 2025 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760466850;
	bh=PLQupHxYSg9wOyJFOAJ7+pbMGjt8o2y2t9mkr785clw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O7dqFvSRXHcNKIwbW4PevuErLengwAkI2WFGKDV9ABuCCRQDroMVQWifUZlbef1Jd
	 eiAWFlCw7+v17JV+FDQXLd032RWAgyG/+9twDFrwY2NS5uVAL5j2xdLRZdD46Ty8ke
	 LyZd92dXdvlIPbIjMLkVb9BPGln/55nrp+343VuogBAeAof0y4xv6vry7gcutDhqha
	 0XYGy8KRURvuMqdUyp5P1JgSxfmAkl7YtYmV1ld5a09hDNiRqiBJhW5CMWgO884a4g
	 TuiL+mwWGfASbjcSlhHZceyYiAKE+ZvB/X/8JMfa3d63yv7bcQh2pbBbyHPLorSeQp
	 mT7ZJucR5Y8sw==
Date: Tue, 14 Oct 2025 15:34:06 -0300
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
Message-ID: <aO6XntNCySo9MXaz@x1>
References: <20250828104652.53724-1-linmq006@gmail.com>
 <4ecf3e76-27f8-47fd-a07d-7da2489af55f@linux.intel.com>
 <aO6VpLGVG5OOHnOY@x1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO6VpLGVG5OOHnOY@x1>

On Tue, Oct 14, 2025 at 03:25:46PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sat, Oct 11, 2025 at 11:48:56AM +0800, Mi, Dapeng wrote:
> > > +++ b/tools/perf/util/zlib.c
> > > @@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
> > >  	if (fd < 0)
> > > -		return -1;
> > > +		return false;
> 
> > Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
 
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sorry for the noise, I merged this already, it is already in 6.18-rc1 :-\

- Arnaldo

