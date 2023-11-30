Return-Path: <stable+bounces-3219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0948F7FF059
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89792820CB
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C2482C9;
	Thu, 30 Nov 2023 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LP7zd+kb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751047A6B
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9A1C433C9;
	Thu, 30 Nov 2023 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701351562;
	bh=B6aBC+dmLLqc6HAJFub5ldi2nVKNIFOnJUfFqYurwV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LP7zd+kbr894PdRloMNjOWT80lcerBtInEN3CadgHipOODAhZvoPYAmoeqPEFqBAB
	 ELa7wT80QwAgss+Bo/RmqXgZsPpdLdm11b5vyYSF5Sa91LvU5t+uk+eTpHQOFaY1Vf
	 2/Pb9kP8XspldWCM2RhOBY6wcB4O0GKG0AUZJuG0=
Date: Thu, 30 Nov 2023 13:39:20 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 4.14.y] tracing/kprobes: Return EADDRNOTAVAIL when func
 matches several symbols
Message-ID: <2023113013-lyrically-luncheon-9c3e@gregkh>
References: <2023102140-tartly-democrat-140d@gregkh>
 <20231127165012.325224-1-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127165012.325224-1-flaniel@linux.microsoft.com>

On Mon, Nov 27, 2023 at 05:50:12PM +0100, Francis Laniel wrote:
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
>  kernel/trace/trace_kprobe.c | 48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

All now queued up, thanks.

greg k-h

