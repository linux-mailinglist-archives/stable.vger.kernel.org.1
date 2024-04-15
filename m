Return-Path: <stable+bounces-39411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACA8A4D7B
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D154B23E00
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 11:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F475D75F;
	Mon, 15 Apr 2024 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sLzEjbFT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107F5D734
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179852; cv=none; b=eA7ubDezWE92LAs/Gp5JtxGw3+rZOspAL03SGs+r4qXbBcDLJE6iAcI5LAe+zkHL7BSywPHPG270Te1VMG16TfHQwC/VGt64t5DEc0yThagDAg5HOad83pT+h9PwqumnnEiEWXsanu97H3Gvr8OYWEDndglffe+7oUMR1xx09Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179852; c=relaxed/simple;
	bh=FiBNk8LqFt3kHVUey8n5ZNhoF8DG4i+ji36knvjdPag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEkCGbaxJ63G18U1sLzzPizLGXuNIX1rXV5H1KKrpOf3h15DrwYAfwUJ1ubm4LKefPw8y+BOGr2ngkSBryxD9EeqHQtctaIuxE/6UTlqtf6OU1B8zERC3KAv8uBguVh4b/XQb1r5OmHvHpm+jCBlCFz9zFpFnndKDzE0ZUxKAA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sLzEjbFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51938C113CC;
	Mon, 15 Apr 2024 11:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713179851;
	bh=FiBNk8LqFt3kHVUey8n5ZNhoF8DG4i+ji36knvjdPag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLzEjbFTOuQ6Fwzxz9LMrnizgKKUPewydjfQcuT1IzIOoVt7/SBMF6bgBf9RJT3RH
	 91SQFvcOtLes8j6Z9LtX/OLE1JbFNtINSKe+TqbJNbaAz+1HY305Yj6uyY8lQUvFRs
	 3jQGvIE8n37Be4jYN1q0x+AcIEKyQsFijCHx3iUE=
Date: Mon, 15 Apr 2024 13:17:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: tom.zanussi@linux.intel.com, stable@vger.kernel.org,
	Tom Zanussi <tzanussi@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 4.19.y v4 2/2] tracing: Use var_refs[] for hist trigger
 reference checking
Message-ID: <2024041518-lunchroom-anemic-a740@gregkh>
References: <20240412093041.2334396-1-dongtai.guo@linux.dev>
 <20240412093041.2334396-3-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412093041.2334396-3-dongtai.guo@linux.dev>

On Fri, Apr 12, 2024 at 05:30:41PM +0800, George Guo wrote:
> From: Tom Zanussi <tzanussi@gmail.com>
> 
> commit e4f6d245031e04bdd12db390298acec0474a1a46 upstream.
> 
> Since all the variable reference hist_fields are collected into
> hist_data->var_refs[] array, there's no need to go through all the
> fields looking for them, or in separate arrays like synth_var_refs[],
> which will be going away soon anyway.
> 
> This also allows us to get rid of some unnecessary code and functions
> currently used for the same purpose.
> 
> Link: http://lkml.kernel.org/r/1545246556.4239.7.camel@gmail.com
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 68 ++++++--------------------------
>  1 file changed, 11 insertions(+), 57 deletions(-)

Again, you also need to sign off on this.

thanks,

greg k-h

