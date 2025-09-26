Return-Path: <stable+bounces-181794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B838EBA504F
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 22:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEF37A65D8
	for <lists+stable@lfdr.de>; Fri, 26 Sep 2025 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE99280308;
	Fri, 26 Sep 2025 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2ll9FLT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56A71F4E34;
	Fri, 26 Sep 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758916795; cv=none; b=HmxaLMrBzuTPmMRlflAVfp/a3tf/KQSIMF6MBLYH++9LgvvLIex1FshJFBV0TV+4teOGfthGk2B3K69GaXcpgEea0q0Iz4PhEJV/w7nIfyFkeukKylrYqus9xtdpr307CyzShrWf/2pG4A3fc2HBm8mHWrsggJfqTRkmuU05ikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758916795; c=relaxed/simple;
	bh=G7QcvnfTWYRxp/GmM+pso0f4vUGZFkPkild8qrlkqqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eat6GSxiTGSIa/+3muV0ZcddBMDZgCtV82Uf/MeBfALU/6BAz+OblCcMgMBxPY9AifjTjZ/U2gfke4urdx1L9mjLTFfsiBDWQ9VrsbHY+8PWLuzNd7SMIALw+ghMpuNSKKAgm4UMl9dLRPUf0coymSMi013IOB4gn0//9aPbWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2ll9FLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE47C4CEF7;
	Fri, 26 Sep 2025 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758916794;
	bh=G7QcvnfTWYRxp/GmM+pso0f4vUGZFkPkild8qrlkqqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2ll9FLTLWRE92u88UmONdWrCOlNV+McWooNhWW7eQtfGIXiGeFKrFHrQQchxfF+a
	 khte4Ekq1ZoiqfHaYsS5KaWfJxwrRi4EoxyrdMMy4Y3LnCgXMSnwcGEKYFpNMOdJ0m
	 zWeLMu9GonIhmFG48uzbN/5Po8p7tarc+XluYZWbxRJhw5MqcLJv0NgHxApXeWnn4n
	 emyLkCr8LczOsX4cTgjdgQJULlQg9hQfWIoC9+1TKp2wvfhDeZaVsKXhoDZE54mDs6
	 XVULY0fDtAGYf/81Z56GkpMzrlSZhMElMs/c4sSZn9+tbp9NBNLxV2plFmPRicPHrK
	 rR0OfqEOUCMWA==
Date: Fri, 26 Sep 2025 09:59:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Chenglong Tang <chenglongtang@google.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	roman.gushchin@linux.dev, linux-mm@kvack.org, lakitu-dev@google.com,
	Jan Kara <jack@suse.cz>
Subject: Re: [REGRESSION] workqueue/writeback: Severe CPU hang due to kworker
 proliferation during I/O flush and cgroup cleanup
Message-ID: <aNbwuc_Efg-Bj2Yu@slm.duckdns.org>
References: <CAOdxtTYQye1Rtp-sG48Re+_ihD637NDXTG_V_uLkerg=m1Nbtw@mail.gmail.com>
 <CAOdxtTYKrMhjW9JiOCDBia+s=2tob1HF6yfAytYnajYsSoX5Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOdxtTYKrMhjW9JiOCDBia+s=2tob1HF6yfAytYnajYsSoX5Kg@mail.gmail.com>

cc'ing Jan.

On Fri, Sep 26, 2025 at 12:54:29PM -0700, Chenglong Tang wrote:
> Just did more testing here. Confirmed that the system hang's still
> there but less frequently(6/40) with the patches
> http://lkml.kernel.org/r/20250912103522.2935-1-jack@suse.cz appied to
> v6.17-rc7. In the bad instances, the kworker count climbed to over
> 600+ and caused the hang over 80+ seconds.
> 
> So I think the patches didn't fully solve the issue.

I wonder how the number of workers still exploded to 600+. Are there that
many cgroups being shut down? Does clamping down @max_active resolve the
problem? There's no reason to have really high concurrency for this.

Thanks.

-- 
tejun

