Return-Path: <stable+bounces-126574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB2A704BC
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 16:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7444216D704
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE31EA7DB;
	Tue, 25 Mar 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b="bLSCSjvW"
X-Original-To: stable@vger.kernel.org
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8137325BAD9
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915566; cv=none; b=Bf2p7YQFScToUaNVgzOTfAL2YiaAU0iNLQk9SJJHIyKp1SwviRicWLdBM+WKvgvLErNiCH33zq2sPWGjAM+nrZyB3SwiVGU6VSWrGuK+w2jqqmTUTxeczGEu6TrjOuR+VQmmrAnnteGtShC05cjbQwLJ5T3IFdEMfSt9hG4aXSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915566; c=relaxed/simple;
	bh=1SMaNcgHDnVkPByJAs8xbaa1v3T/Chn2e5uxDku/NbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nacHQNxSScM2BibaOXz4wb+VzclcwH27Kk1BvzGKaKNHBJ+pBbUkxI5cFRrrkskmtMWNFcDKy5oC7gtbN4/WcEo0AjTPEGh0HOmd4Ol+gBuCcpcXSjhs0SNQNxsuQLc3kyLxpq+uGZo1cOuhrgULlcRKLoZMu3gPCn0oOODti84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io; spf=pass smtp.mailfrom=patcody.io; dkim=pass (2048-bit key) header.d=patcody.io header.i=@patcody.io header.b=bLSCSjvW; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=patcody.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=patcody.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=patcody.io;
	s=protonmail; t=1742915553; x=1743174753;
	bh=DhNFLl2UgqhpiFGUc9+LyKLooe2GHvyl/+zO4fJQcMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=bLSCSjvWArxRNrI152xTD8OPQiNplvlNX+Ibg6H4TvMzi70ilPPIdl4/+IWSR/sjB
	 ymrmKO9oO7SwJM7yPYisaQpPqv3q6zeaQD+qDWlSTg2XRXsr4R/m8zvNlw5Q4ED+6f
	 F+yH6yRlxgV88GI1PdgCsu3oA+EYZaek52lNmiVuAZcV7Oks7MRmmUETLYVcVj2Ikk
	 mCMyKBICFb1Ab/wJ9aoszAhlKCnnz5yHkPvpn/hwkxwYz9Cylqrvyq6Wtf8Zn50+ea
	 k+FEC4PnMQlqTSRaviTVHFa/EQ8C6aEgPqqBDQiTo0v/qlb1KwGORfO83Lji3zgPmi
	 U1O82I3K1Admw==
X-Pm-Submission-Id: 4ZMYLl6FCWz3LT
Date: Tue, 25 Mar 2025 08:12:30 -0700
From: Pat Cody <pat@patcody.io>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	riel@surriel.com, patcody@meta.com, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <Z+LH3k2RyXOg9fn4@devvm1948.rva0.facebook.com>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324115613.GD14944@noisy.programming.kicks-ass.net>

On Mon, Mar 24, 2025 at 12:56:13PM +0100, Peter Zijlstra wrote:
> Does something like:
> 
>   https://lkml.kernel.org/r/20250128143949.GD7145@noisy.programming.kicks-ass.net
> 
> help?

To clarify- are you asking about if we've tried reverting 4423af84b297?
We have not tried that yet.

Or if we've included "sched/fair: Adhere to place_entity() constraints",
which we have already done- https://lore.kernel.org/all/20250207-tunneling-tested-koel-c59d33@leitao/

