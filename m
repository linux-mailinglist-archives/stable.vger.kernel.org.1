Return-Path: <stable+bounces-184201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FFBD23B5
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B763A2E2B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D12F9DBF;
	Mon, 13 Oct 2025 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHkZf7Dq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C772C18A;
	Mon, 13 Oct 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347022; cv=none; b=CnSdfeRsDnzHDEaB1eNYnpxdOBmcU1srchAsJnVcZPr7a8CP9sw/6lYSarMsPkBFEefbxAsJIbTTtZFR/BLKwxlTV65IL9jefX4IJsIJojCCmKP7v9BO/TxF4hD8KX3/00NekyWQekSRNp9beBikQttJdimVy/9bfG4X4XiVMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347022; c=relaxed/simple;
	bh=/auT3UgIwSi0ev3BBmyrAvTGEjKox8DEHohP+Ue7Ahc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1mXzPYaFU/e2Z9GHdow3D0fjcGK4QBjEknY6Y9WIdjureiYGGGsyO/IDKQO7Bx5p37HZqHr7myik8mg396QHOqyWMkMmj3kPNenMlq216tl6Bv5Aqlqmm+RC+TUk20fm/AaOdo0N+b8m2KlHyh4lBbkgkvMCQtdmE/MUq1nt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHkZf7Dq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC04C4CEE7;
	Mon, 13 Oct 2025 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760347021;
	bh=/auT3UgIwSi0ev3BBmyrAvTGEjKox8DEHohP+Ue7Ahc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UHkZf7DqqY0Y9WedIGvcr6spAb5M3fmj+83HQzre/CIe4aCD9af9E3/siVKO2faGU
	 aHh4VkU8kY/xLzDLYDC4m6hCqypdMD9aBSObX6Tm1Ojd3FW4xTPvDOJ6Ay32VFhbLQ
	 xD0vSbpZRoFbF34rPRGuUZPEB1gWW1qkFG/W/UAgILhmJKAVYx+Q1tqFMBZup5ZZR6
	 XKYn2s7nOzL+j/RrPTQqVwj1uIjinfmeJGQpPTIKZK5xy8usHUSjvs1rFzABEGoZhO
	 xdMasDGO4KKf7dMBJSKSPTTfOtivl3k+8dPGDkoB1Y3nZ82P2ZUj5yzbEiFsGz3Ze4
	 Ost8ClewWTbVQ==
Date: Mon, 13 Oct 2025 18:16:55 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Miaoqian Lin <linmq006@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix bool return value in gzip_is_compressed()
Message-ID: <aOzDh4yhR5F0nMTG@google.com>
References: <20250828104652.53724-1-linmq006@gmail.com>
 <4ecf3e76-27f8-47fd-a07d-7da2489af55f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4ecf3e76-27f8-47fd-a07d-7da2489af55f@linux.intel.com>

Hello,

On Sat, Oct 11, 2025 at 11:48:56AM +0800, Mi, Dapeng wrote:
> 
> On 8/28/2025 6:46 PM, Miaoqian Lin wrote:
> > gzip_is_compressed() returns -1 on error but is declared as bool.
> > And -1 gets converted to true, which could be misleading.
> > Return false instead to match the declared type.
> >
> > Fixes: 88c74dc76a30 ("perf tools: Add gzip_is_compressed function")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
> >  tools/perf/util/zlib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
> > index 78d2297c1b67..1f7c06523059 100644
> > --- a/tools/perf/util/zlib.c
> > +++ b/tools/perf/util/zlib.c
> > @@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
> >  	ssize_t rc;
> >  
> >  	if (fd < 0)
> > -		return -1;
> > +		return false;
> >  
> >  	rc = read(fd, buf, sizeof(buf));
> >  	close(fd);
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

We have 43fa1141e2c1af79 ("perf util: Fix compression checks returning -1
as bool").

Thanks,
Namhyung


