Return-Path: <stable+bounces-135182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB0A97588
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F79179275
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EA72980C1;
	Tue, 22 Apr 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4w3DPKE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC82857C4;
	Tue, 22 Apr 2025 19:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350542; cv=none; b=FU68EiVgdCWNCGZVxqlhThyWBh+iEU3wuEhNTsA6XAvw0IHJl97vwPmcK3ankqndR367HnQwBBcTmgSd062e+Pg6/3aUdWCurhTMPb8QuY3x1KW450qHYCVpyVDhIcINCFvByp4BFMYtm4J63ahzd8OSdjHtDObtC/lpatO9emM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350542; c=relaxed/simple;
	bh=5uIMwI+fP0wgHXqFGRjDYffIXoIXt32yHEx2uTfvUsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h91RtKUBmDPm1vR8SsAl2NhbYNpJ26SV/KUqJEKiCdVJv5FO67JaUbhdwZE5eeN30DL/SNG2EFC8TpCMMZhSSKyi1AtbzbLeJmDFEMfVMfwrv9ryL8wDI+UM1/PQbyngWP7XW2VKFFGtWocDeHo1ihWBcP6wBpe2o+UVC0YgvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4w3DPKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C65CC4CEF1;
	Tue, 22 Apr 2025 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745350540;
	bh=5uIMwI+fP0wgHXqFGRjDYffIXoIXt32yHEx2uTfvUsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4w3DPKEoWXBnrG87IR4lytsdIdU7qGGetLH0ovcoMTky7pSwZlhEzbj5nf5av0GH
	 Y5IMLxaLw2Nkdfqsn3LYAr0tQWA0F8n193z6CRzT/j0ia+HbebzwLoMhOIFwoLl6l3
	 80i9JWaYZXYjeNOIVUd4HuyRWeYRajyqJhrI7CFnec+0sZt5gwBHa7yv5OSnZYCp3e
	 rJN7dqSIeqBSv0fR3+wA1lu8YInQe4or2/mbaoHl7Sz9PnK1aLm0Oa0Ur8quSblGKh
	 hLoOSJyMSPbruAqVj07SpPgOlPZAyOWh9bm01LZ13uuI41rhpG8fYRyrSIbmahOxMf
	 7h2BP6meX5j9w==
Date: Tue, 22 Apr 2025 21:35:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, andrew.cooper3@citrix.com,
	Len Brown <len.brown@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Handle Ice Lake MONITOR erratum
Message-ID: <aAfvalru47h7Qffk@gmail.com>
References: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
 <aAc7Y5x_frQUB2Gc@gmail.com>
 <4ea35cc4-1720-494c-9d90-e4669c8cde08@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea35cc4-1720-494c-9d90-e4669c8cde08@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 4/21/25 23:46, Ingo Molnar wrote:
> >>  /*
> >> + * These CPUs have buggy MWAIT/MONITOR implementations that
> >> + * usually manifest as hangs or stalls at boot.
> >> + */
> >> +#define MWAIT_VFM(_vfm)	\
> >> +	X86_MATCH_VFM_FEATURE(_vfm, X86_FEATURE_MWAIT, 0)
> >> +static const struct x86_cpu_id monitor_bug_list[] = {
> >> +	MWAIT_VFM(INTEL_ATOM_GOLDMONT),
> >> +	MWAIT_VFM(INTEL_LUNARLAKE_M),
> >> +	MWAIT_VFM(INTEL_ICELAKE_X),	/* Erratum ICX143 */
> >> +	{},
> >> +};
> > While it's just an internal helper, macro names should still be 
> > intuitive:
> > 
> >   s/MWAIT_VFM
> >    /VFM_MWAIT_BUG
> 
> The current convention is to end with the thing that's being matched,
> like "_FEATURE" or "_VFM" in the X86_MATCH*() macros. That's why I
> ordered it the way I did.
> 
> As for including "BUG", the _macro_ doesn't match CPUs with the bug.
> It's just matching CPUs with the specified VFM that have MWAIT. It could
> (theoretically) get used for non-bug things so I don't think it's
> intuitive to put "BUG" in the name.

Oh, that makes sense - objection withdrawn.

Thanks,

	Ingo

