Return-Path: <stable+bounces-307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AC17F78BD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0A81C209AC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175133CE1;
	Fri, 24 Nov 2023 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="udiuFxy+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC152EB15
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E49C433C7;
	Fri, 24 Nov 2023 16:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700842606;
	bh=O9w+ZpPtfccWGH6CsrUGqZnmZx7vNy2+Qssl/B2vCkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udiuFxy+2FY7zyLoWqNz/USGco+wXYjADCD47Q0454WPw9lYuNAfAXrblzJ5hqNAd
	 8qoZtI6aAeTel07a2w/Q30DvrkW22u7K8x40/VgVDhKnT8J10O9wqnIeDBcUN7tMF/
	 x5B5LtdDmGjYLf81yvBnCRcEf4CgNnB9Q3OrxxpE=
Date: Fri, 24 Nov 2023 16:16:43 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5.10.y] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-ID: <2023112415-salutary-visible-1485@gregkh>
References: <2023102135-shuffle-blank-783e@gregkh>
 <20231124130935.168451-1-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124130935.168451-1-flaniel@linux.microsoft.com>

On Fri, Nov 24, 2023 at 02:09:35PM +0100, Francis Laniel wrote:
> When a kprobe is attached to a function that's name is not unique (is
> static and shares the name with other functions in the kernel), the
> kprobe is attached to the first function it finds. This is a bug as the
> function that it is attaching to is not necessarily the one that the
> user wants to attach to.
> 
> Instead of blindly picking a function to attach to what is ambiguous,
> error with EADDRNOTAVAIL to let the user know that this function is not
> unique, and that the user must use another unique function with an
> address offset to get to the function they want to attach to.
> 
> Link: https://lore.kernel.org/all/20231020104250.9537-2-flaniel@linux.microsoft.com/
> 
> Cc: stable@vger.kernel.org
> Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
> Link: https://lore.kernel.org/lkml/20230819101105.b0c104ae4494a7d1f2eea742@kernel.org/
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> (cherry picked from commit b022f0c7e404887a7c5229788fc99eff9f9a80d5)
> ---
>  kernel/trace/trace_kprobe.c | 74 +++++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_probe.h  |  1 +
>  2 files changed, 75 insertions(+)

We also need a version for 5.15.y before we can take this, you do not
want to upgrade and have a regression.

thanks,

greg k-h

