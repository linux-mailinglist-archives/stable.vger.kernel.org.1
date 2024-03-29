Return-Path: <stable+bounces-33720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77468891F42
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8672845C5
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831BB13F447;
	Fri, 29 Mar 2024 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="UbJuG6UW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="apOizN0c"
X-Original-To: stable@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4535B1E6
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717710; cv=none; b=iYjCVc2AzukQuX0BCVTE1KgV0znBlUKk13Bq4d3sQiV5hv7mH68W7fORCMxC1qGFsPOF0VE9hex1TU7QTv2/+AvGu9eFXpX8wxPG0FojSstR1CDoPsIZSEClTH9n1bqdGVgR1Amyz23b+kDSC7Jl3uD8w/KWtSPR8HvOlvW30Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717710; c=relaxed/simple;
	bh=780glm+gtDImyGjGKBWW9GrDTbdXRsbP6jw8OVJ4q+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=judf2JxazaWgsQOgc2S7Vne80Eylxq2V7LdQfDreNj/Lvi8XTN+C3775xQkmFqZGUhIQJgido1+Vatrbv6fhueYieP1Ed+u8ggw9brRQrA82sXKkmCl+nPReHfqOgPgMs/XK04mU8C5N4eu1ZWMZlevPwu6n2RW++7DDAcJqzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=UbJuG6UW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=apOizN0c; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4F61911400FD;
	Fri, 29 Mar 2024 09:08:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 29 Mar 2024 09:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711717707; x=1711804107; bh=JbaZQZrS9g
	Fq1NJGzpN1szWUZQaV2f3280row4esfBQ=; b=UbJuG6UW9Mf3TqRq90jj+0PUIO
	V+j1Q8+Ok4Gz17z9aorCI/AOvNMD2B9f3lmrmd0mlXZNU8R46yGM9vb670KNQ9tN
	i73Rq9IK6+YQSLXGk1IQpf1m3nYGmN7auKq+1jC4kgR5scINCCzy1YeIuF74wQhf
	D4IWbWMcZcC+XzU8YKPG3h5f928S/oxfEoaqrA8RGiFr88qKMOp6TjYFVTX2wnPF
	zu2esp768jf9+e80P0A4NTqF/rJygEestNn4YfG77jRHqe1Nmb9OgEl/ze6vv3L5
	g/8eV8E2xEnPNMNdeFhqFzhE0/unILd9ZafDPh1zHhAEH+HUqZzBQVEuUjuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711717707; x=1711804107; bh=JbaZQZrS9gFq1NJGzpN1szWUZQaV
	2f3280row4esfBQ=; b=apOizN0ccN/xd4TeqPaRxyth+jAEFBxE48rEFEuoReuH
	nfAIr8zpTqIQk4iBO6hUN19frTO/vNRi2KUxgA2LV357GfiduayZV3cmKenblSvk
	RQi3aD9uEbfZMhR72aaJFAiWgjdgod5ZNoIt2pInC2/HuuqUPsLq0vZWRJIDZZ9m
	iR7xMyzrQH90LNd9H/KLUCffLoXaX27SH0cxeBazXGr6868BN5pen8Ed6+s6opp0
	Aa4l025UV9bTOLV7jYpinK+spmHq71WnpJrphJ7lSQ/hAH0Xk+HhogxeLx7i5N/b
	5TiO5zXBJ77nq7rIKDz772U9lhaGOKqKhDYqKaajMA==
X-ME-Sender: <xms:Sr0GZhxVcRDXCG9fq8v2USW7fqncaEidx-X6gmfJJVL1rCb6l6g8tA>
    <xme:Sr0GZhSBfthwfQUaiQ0BVjh_YoIVjsYfPFkwQhu-h1SBuJMOGYazgPKefrk7aWyjH
    pgWXSU-bU4_ew>
X-ME-Received: <xmr:Sr0GZrVFpSOqHHmwd1te9Ctu3wabq-FgGpOOzR-OMwIjnKSOcuX7GKtzkH5rVYh0YSgmzJkdiCRUGOtLieqyfu-xg5aDPxV7f3HIlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvvddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:Sr0GZji4vic3LwHIrxK_LEyiRk_WFm8NTvSnUYxtip3vizWwLMwpbw>
    <xmx:Sr0GZjCEmuUQoARl_uCW3ueuFwaPPgK8ImS_hLMZyoXh9zKVTQHA3w>
    <xmx:Sr0GZsIEtJIvWKkgTYknF7W0YXCdBLmHMswtQXXqvWLNeAZWm1Wnew>
    <xmx:Sr0GZiDkYURwTqxaE2z36Zr9yxCjanY-qFB8WR-nXe6qhzsscFiE2g>
    <xmx:S70GZgLMPM6EB2kE5rS6z1JgU8BdxP4goU1YniuScKtrfmEkpXRZXA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Mar 2024 09:08:26 -0400 (EDT)
Date: Fri, 29 Mar 2024 14:08:15 +0100
From: Greg KH <greg@kroah.com>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Yang Jihong <yangjihong1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 4.19,5.4,5.10,5.15] perf/core: Fix reentry problem in
 perf_output_read_group()
Message-ID: <2024032908-uphold-scapegoat-74e7@gregkh>
References: <20240307175015.1972330-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307175015.1972330-1-cascardo@igalia.com>

On Thu, Mar 07, 2024 at 02:50:15PM -0300, Thadeu Lima de Souza Cascardo wrote:
> From: Yang Jihong <yangjihong1@huawei.com>
> 
> commit 6b959ba22d34ca793ffdb15b5715457c78e38b1a upstream.
> 
> perf_output_read_group may respond to IPI request of other cores and invoke
> __perf_install_in_context function. As a result, hwc configuration is modified.
> causing inconsistency and unexpected consequences.
> 
> Interrupts are not disabled when perf_output_read_group reads PMU counter.
> In this case, IPI request may be received from other cores.
> As a result, PMU configuration is modified and an error occurs when
> reading PMU counter:
> 
> 		     CPU0                                         CPU1
> 						      __se_sys_perf_event_open
> 							perf_install_in_context
>   perf_output_read_group                                  smp_call_function_single
>     for_each_sibling_event(sub, leader) {                   generic_exec_single
>       if ((sub != event) &&                                   remote_function
> 	  (sub->state == PERF_EVENT_STATE_ACTIVE))                    |
>   <enter IPI handler: __perf_install_in_context>   <----RAISE IPI-----+
>   __perf_install_in_context
>     ctx_resched
>       event_sched_out
> 	armpmu_del
> 	  ...
> 	  hwc->idx = -1; // event->hwc.idx is set to -1
>   ...
>   <exit IPI>
> 	      sub->pmu->read(sub);
> 		armpmu_read
> 		  armv8pmu_read_counter
> 		    armv8pmu_read_hw_counter
> 		      int idx = event->hw.idx; // idx = -1
> 		      u64 val = armv8pmu_read_evcntr(idx);
> 			u32 counter = ARMV8_IDX_TO_COUNTER(idx); // invalid counter = 30
> 			read_pmevcntrn(counter) // undefined instruction
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20220902082918.179248-1-yangjihong1@huawei.com
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
> 
> This race may also lead to observed behavior like RCU stalls, hang tasks,
> OOM. Likely due to list corruption or a similar root cause.

Now queued up, thanks.

greg k-h

