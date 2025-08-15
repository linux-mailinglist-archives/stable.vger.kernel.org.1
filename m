Return-Path: <stable+bounces-169743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F229EB28360
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D6B84E2ADD
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4482FD7AB;
	Fri, 15 Aug 2025 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f4krVdWQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D5227B9F
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273437; cv=none; b=XQn74fjy8OvGEzvjECPbvvpF4kU1QtpnPa1J/DxZedeTYrcOhpoaakC613S6Iq4j6UmLzQM5qx3aP+eQ5q0KHmYk9rYy+VMea5HZEFrvcf4oXshpztbkSu2cdF5GtLw0i4ryehlMFS52IRxpMx9WFLbGpugBX8svT5kFOXDLF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273437; c=relaxed/simple;
	bh=EZk4WFfz8jNuDjULi1ecw5Db5utG1llEshcmOB+zdqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjOMYKHAE+b3JY3QOc2eNzKbdytIBgdy8I/F+59PwW9IE2DAHEs/gzOIVJuvPe/TRzywPA9nElmZGktd0oBQoRxEHvIfV6nBQSDydsqrhR9Q0CVbwZE8an/ocEMRjMB891nw+mMnpLAD4bAslEzvImsp5U8vX9c7YhyFL2Pv2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f4krVdWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91D5C4CEEB;
	Fri, 15 Aug 2025 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755273436;
	bh=EZk4WFfz8jNuDjULi1ecw5Db5utG1llEshcmOB+zdqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4krVdWQYhXdpyI81U7CfGelnHA6yesTlNSnVP3mu0LOMIk8PPBf3ufU7x1Rk4/Tt
	 o6+t6k7TSo1318eCN0GZww6BLzoCKZt2MkLu9QPfls4DegVp24+5+QJXKR1VR9Vs8k
	 nsdATl3hwbiunypTUvRN0NW5Gw1zn1+QKB5RmMtQ=
Date: Fri, 15 Aug 2025 17:57:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: superman.xpt@gmail.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: commit partial buffers on
 retry" failed to apply to 6.6-stable tree
Message-ID: <2025081558-scion-joylessly-a7b6@gregkh>
References: <2025081549-shorter-borrower-941d@gregkh>
 <15e7ab1a-46d9-4d3d-b48e-3e10e570829e@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e7ab1a-46d9-4d3d-b48e-3e10e570829e@kernel.dk>

On Fri, Aug 15, 2025 at 09:46:53AM -0600, Jens Axboe wrote:
> On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 41b70df5b38bc80967d2e0ed55cc3c3896bba781
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081549-shorter-borrower-941d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Here's one for 6.6-stable.
> 
> -- 
> Jens Axboe

> From c16cb4e2a4b1a487ca7feae5931dfb22ac495b76 Mon Sep 17 00:00:00 2001
> From: Jens Axboe <axboe@kernel.dk>
> Date: Tue, 12 Aug 2025 08:30:11 -0600
> Subject: [PATCH] io_uring/net: commit partial buffers on retry
> 
> Commit a6dfda7da5c65b282c1663326be16e57aec3d1bd upstream.

Nit, wrong git id :(

I'll go fix it, thanks.

greg k-h

