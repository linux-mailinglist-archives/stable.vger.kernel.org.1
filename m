Return-Path: <stable+bounces-40285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C21B8AAD85
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 13:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10201F21D69
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC768120D;
	Fri, 19 Apr 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cvDgiinu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5842AAF
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525491; cv=none; b=tk9LAwUHAyyJYkHPTq+DoiYMdZrN3jf7Wv/JpPt7vTLhpY4jl4K6ko0gp+1V+zlGoweurRt7swk6r4Ao4VRTZoF1KPL75WpXLCP0QTCzmGBXDeuNCei3OiWJEt2NoAuQRzz88F02njQ9NOQwEOB3RYRMb/smu3kRJ25PIAqpXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525491; c=relaxed/simple;
	bh=lNKnyQVcGDCqtAan7a9HtVYdOjSqqKNaCqne8qatPRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJdcnXwoi6n3oQAq4716Q/JG9K9GxWWtUMDSHp7FIfZRTppDFqhhhsAVQqTKnSxvRfbtWdRvVl9IReREy2xbEUStKqQlXvqJVgualW4nfpHyu5yw4LGLn5puDi+SAKPIvVSTw9G4b6XEMzYU2ugiahbgBzq3nwqVbzn6mCCu0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cvDgiinu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DA7C072AA;
	Fri, 19 Apr 2024 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713525491;
	bh=lNKnyQVcGDCqtAan7a9HtVYdOjSqqKNaCqne8qatPRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvDgiinuAbzEAkjViP5S0DVeuaG3RP/rDsQUtYGCxRDx81NO9SaKbixF8ocz6fEzs
	 xSX8nwWxtIXcwSd8fSNKBiXRomCIPQwWliVLbZeRtbhXkOknbX/v1RJrxvSEzKwqeA
	 tZTvtNFz31JbnsA073z3zsiuhvU53RS92pj1K3uo=
Date: Fri, 19 Apr 2024 13:18:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: tom.zanussi@linux.intel.com, stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH 4.19.y v5 1/2] tracing: Remove hist trigger synth_var_refs
Message-ID: <2024041946-primarily-panning-8fd1@gregkh>
References: <20240416015432.2282705-1-dongtai.guo@linux.dev>
 <20240416015432.2282705-2-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416015432.2282705-2-dongtai.guo@linux.dev>

On Tue, Apr 16, 2024 at 09:54:31AM +0800, George Guo wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> All var_refs are now handled uniformly and there's no reason to treat
> the synth_refs in a special way now, so remove them and associated
> functions.
> 
> Link: http://lkml.kernel.org/r/b4d3470526b8f0426dcec125399dad9ad9b8589d.1545161087.git.tom.zanussi@linux.intel.com
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  kernel/trace/trace_events_hist.c | 18 ------------------
>  1 file changed, 18 deletions(-)

What is the git commit id of this change in Linus's tree?  Always
include that please.

Can you fix up and resend the series?

thanks,

greg k-h

