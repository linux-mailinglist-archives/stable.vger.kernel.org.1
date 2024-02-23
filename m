Return-Path: <stable+bounces-23496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A2486161F
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868251C23DFE
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 15:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6382880;
	Fri, 23 Feb 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dXXa6L2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86078287A
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703042; cv=none; b=MANfw7JZhRxv+cPNDmxmZpogGWujpN8uLmgP9Q19iEBqAXxKIyryqZvi1JGkISR4pNie5BVn44zriYygJwGqSDUaT5ULns/zi9zR70GBgqbA7LzH6k91OToPWJc30m7AT5x5gUW2bSi92nMSm/83g1YlzIcMkozbj58zUQ+5Iow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703042; c=relaxed/simple;
	bh=mPL2o2czx9hOn6XSG0H33ybiTtLNbgAsItHJx7V4kWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhC3I7wOsOnPTggNnzw8W+w3JF0NgejzPqzT32ofpdixhHzsx5d8M516odhw4NAeXkviUDs9bc4bVJgced4vHtC0X1/HHYVRDO6WXHmhO/5WjwuhqGE4uW3184na9AHdJ73bxvthaxHJYSvcSNlPNFE/a3MJCO5HoIVoXclBPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dXXa6L2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD48AC433F1;
	Fri, 23 Feb 2024 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708703042;
	bh=mPL2o2czx9hOn6XSG0H33ybiTtLNbgAsItHJx7V4kWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXXa6L2JUAdAZgAjoZbzPa80Q+lwwSNMwNEWi9ej1jZxgdR6H3/mhhllMPxsAAHWO
	 dwPzBy0u8zMrh1HbD761ztD2LS9GyKVSizGrD5cMqMUyA+d2xRKlXVhfeMM5EEzbS9
	 7Xy3k5gG/e6gPIhOIiOEtuwwYUeSUg+nfVXR41hc=
Date: Fri, 23 Feb 2024 16:43:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, jolsa@kernel.org, daniel@iogearbox.net,
	yhs@fb.com
Subject: Re: [PATCH 5.15,6.1] Fixup preempt imbalance with bpf_trace_printk
Message-ID: <2024022352-spectrum-crier-44d9@gregkh>
References: <20240217121321.2045993-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217121321.2045993-1-cascardo@igalia.com>

On Sat, Feb 17, 2024 at 09:13:14AM -0300, Thadeu Lima de Souza Cascardo wrote:
> When bpf_trace_printk is called without any args in a second depth level,
> it will enable preemption without disabling it.
> 
> These patch series fix this for 5.15 and 6.1. The fix was introduced in
> 6.3, so later kernels already have it. And 5.10 and earlier did not have
> the code that disabled preemption, so they are fine in that regard.
> 
> This was tested by attaching a bpf program doing a non-0 arguments
> trace_printk at sys_enter and a 0 arguments snprintf at local_timer_entry.
> 
> Dave Marchevsky (1):
>   bpf: Merge printk and seq_printf VARARG max macros
> 
> Jiri Olsa (3):
>   bpf: Add struct for bin_args arg in bpf_bprintf_prepare
>   bpf: Do cleanup in bpf_bprintf_cleanup only when needed
>   bpf: Remove trace_printk_lock
> 
>  include/linux/bpf.h      | 14 ++++++--
>  kernel/bpf/helpers.c     | 71 ++++++++++++++++++++++------------------
>  kernel/bpf/verifier.c    |  3 +-
>  kernel/trace/bpf_trace.c | 39 ++++++++++------------
>  4 files changed, 72 insertions(+), 55 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

All now queued up, thanks!

greg k-h

