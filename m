Return-Path: <stable+bounces-119951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B871A49C9D
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 16:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB381764E6
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FCD26E17A;
	Fri, 28 Feb 2025 14:57:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99370248862
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754667; cv=none; b=SFNgsWd26Ubdl9HbZ2557s8LN4sdLXmgr2cyMem/Pt14Wu62WTC41JUxPy8QX3HCnt+ZtNtiDY7cQBg//hNFm4GmPsbSRJV1mfzgTIM8JwUhjr8aeD8a7alMBkPMh9P5DqmMmKn4SQiPZXZUUgPC3nvFowit/wq57D+R4wON0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754667; c=relaxed/simple;
	bh=wQT9U4y3Vr7xgZbhy/V+PLhUq+vdL17OdgKXxfsBUFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7M+LIjwGPO99eWznnUy6zc6B6iKTL2KvDDG8XekiqprrDTryaJYNxwLRZcpBFdYOITYNdyWDncyYrtheRxA1np5qUuRR24wqRi3irskVteaZnx3aasiE+2RW3o9UEd2TBdQilwgAPyHfamZQ6BXf9xLNV1z7lI7IJrOwsGgRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489DCC4CED6;
	Fri, 28 Feb 2025 14:57:46 +0000 (UTC)
Date: Fri, 28 Feb 2025 09:58:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: stable@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Guillaume Morin
 <guillaume@morinfr.org>, Wang Yugui <wangyugui@e16-tech.com>, Jan Kundrat
 <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH 6.6 0/4] rtla/timerlat: Fix "Set OSNOISE_WORKLOAD for
 kernel threads"
Message-ID: <20250228095831.69de56ed@gandalf.local.home>
In-Reply-To: <20250228135708.604410-1-tglozar@redhat.com>
References: <20250228135708.604410-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 14:57:04 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Two rtla commits that fix a bug in setting OSNOISE_WORKLOAD (see
> the patches for details) were improperly backported to 6.6-stable,
> referencing non-existent field params->kernel_workload.
> 
> Revert the broken backports and backport this properly, using
> !params->user_hist and !params->user_top instead of the non-existent
> params->user_workload.
> 
> The patchset was tested to build and fix the bug.
> 
> Tomas Glozar (4):
>   Revert "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads"
>   Revert "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads"
>   rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
>   rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
> 
>  tools/tracing/rtla/src/timerlat_hist.c | 2 +-
>  tools/tracing/rtla/src/timerlat_top.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Greg, can you pull these into 6.6?

Thanks,

-- Steve


