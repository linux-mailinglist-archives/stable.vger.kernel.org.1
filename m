Return-Path: <stable+bounces-39410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F1C8A4D74
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C4D1F22B90
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 11:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D0C5D756;
	Mon, 15 Apr 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y/Y8jiCa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486955D734
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179828; cv=none; b=STmYvhEFpmam9OZqE9TsnNOxaKhk2r4u9zgjfJGNjvp48VNY/wjfDYyk5izxdhB3pn/+jbY/+EPJ0QN0GS9Y8v+g4pztnUAjLr2RpfI/FyNcJ1dmKITH3eDZyb96Kd/le3ZiqCa4L2JjpXoAvx8wde+k55ASd5+ywmDjJ/jK3Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179828; c=relaxed/simple;
	bh=YoYBC+IGg4G70z/RLCbo1hyYZEv20ZMLwRBdJ/2EG6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZcUIrLVyc+mx93FkyqcXVylMoj+R40jA9Ta1V/WuwM0ojSk5uUQHMqk6FxgXy+AJAmW3GxbvWNV7WHdnYHUPP3YWIpbcQbKWtaiFSaVS8w1BIjh62OHO2ZWbIz9JYR9N3YrnTcwYMm5eO2e0s3zQAR4KTEkWM9dLtelrIygsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y/Y8jiCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C737C32781;
	Mon, 15 Apr 2024 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713179827;
	bh=YoYBC+IGg4G70z/RLCbo1hyYZEv20ZMLwRBdJ/2EG6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y/Y8jiCaNfPrL4Lx+P06+JJRLwHi8/wKsYJEgvSFQxsDHBArO1kyRbrgP7ZdbDkeZ
	 +q3U6rR5TK1MtsS32hmf3lMFo5MvrQWXHa0uh8Ic7KNzpXCbiOX1n19/yPB4xAHXPm
	 KzM1SDa5a0ITDC9dMc/NgoeuEgy7MV0nd+eLw84Y=
Date: Mon, 15 Apr 2024 13:17:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: tom.zanussi@linux.intel.com, stable@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4.19.y v4 1/2] tracing: Remove hist trigger synth_var_refs
Message-ID: <2024041533-clang-circle-f651@gregkh>
References: <20240412093041.2334396-1-dongtai.guo@linux.dev>
 <20240412093041.2334396-2-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412093041.2334396-2-dongtai.guo@linux.dev>

On Fri, Apr 12, 2024 at 05:30:40PM +0800, George Guo wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> commit 912201345f7c39e6b0ac283207be2b6641fa47b9 upstream.
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

You can not send patches on without also signing off on them, right?

Please fix up when you resend this.

thanks,

greg k-h

