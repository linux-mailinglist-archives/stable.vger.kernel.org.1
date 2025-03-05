Return-Path: <stable+bounces-120425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D162A4FF0D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 13:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845E4188ED6D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BFA2451F1;
	Wed,  5 Mar 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1x9k/ke3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088E2451C3
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179301; cv=none; b=cB0NNcot29KHdQm0i64Gz7KtGqsd7NVZD46Z+Q6VokG4JLEgqoeM5dWbBXD0XYAFbHvP6p6879aGVqmLkl0uagp05XzwUi4ntxWtgcX+X6PZsu0AhTl778T899XcB7LOM9Oq+yMV+CjHnJyoGPK2Wv6YZxSxZGHWP2nl8jDSO9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179301; c=relaxed/simple;
	bh=afom2mOueQTJy29QChVZDh1daijt8kzYH0L6bLrpFes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJOwjfbmaciMkiKp7qv4GwmCdGEUz1nqfcd/QV59wMkMEWEu3+SFaGPeiRH17yDAeDsEmv7GBT2PXynHERtV1msbkxl7XX5QuJ8AM7C1sxs9PCzJmi5Ow+1SeEd1ni4k/ESvA9PAjtWqdCHnB0e3hWX8eGjQIk3n2sovZiDCCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1x9k/ke3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152EBC4CEE2;
	Wed,  5 Mar 2025 12:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741179300;
	bh=afom2mOueQTJy29QChVZDh1daijt8kzYH0L6bLrpFes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1x9k/ke3qaOXgRQF/HKxg/6LxtyVZM8Fwk3yhYgJL3TnYsaTavdQBfwXuri5GK1Ud
	 JDg/hO5CGYGfeJFzgd3gY/RF7s08EEE4zG/M2xuecYqGwxDq9JBvDZTz458MqGGrsV
	 DFCYnBO4UMCXChyI/352KNXv2AYR2AbC25YonqNg=
Date: Wed, 5 Mar 2025 13:54:57 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, stable@vger.kernel.org,
	Luis Goncalves <lgoncalv@redhat.com>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wang Yugui <wangyugui@e16-tech.com>,
	Jan Kundrat <jan.kundrat@cesnet.cz>
Subject: Re: [PATCH 6.6 0/4] rtla/timerlat: Fix "Set OSNOISE_WORKLOAD for
 kernel threads"
Message-ID: <2025030551-banter-laborious-341f@gregkh>
References: <20250228135708.604410-1-tglozar@redhat.com>
 <20250228095831.69de56ed@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228095831.69de56ed@gandalf.local.home>

On Fri, Feb 28, 2025 at 09:58:31AM -0500, Steven Rostedt wrote:
> On Fri, 28 Feb 2025 14:57:04 +0100
> Tomas Glozar <tglozar@redhat.com> wrote:
> 
> > Two rtla commits that fix a bug in setting OSNOISE_WORKLOAD (see
> > the patches for details) were improperly backported to 6.6-stable,
> > referencing non-existent field params->kernel_workload.
> > 
> > Revert the broken backports and backport this properly, using
> > !params->user_hist and !params->user_top instead of the non-existent
> > params->user_workload.
> > 
> > The patchset was tested to build and fix the bug.
> > 
> > Tomas Glozar (4):
> >   Revert "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads"
> >   Revert "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads"
> >   rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
> >   rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
> > 
> >  tools/tracing/rtla/src/timerlat_hist.c | 2 +-
> >  tools/tracing/rtla/src/timerlat_top.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Greg, can you pull these into 6.6?

Will do, thanks.

greg k-h

