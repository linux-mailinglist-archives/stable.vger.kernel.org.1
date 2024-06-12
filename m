Return-Path: <stable+bounces-50261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200CB9053EC
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C932B1F26784
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E274217B408;
	Wed, 12 Jun 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EYQ0XypN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9181791F2
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199560; cv=none; b=EfdTEgSr5nIO4FQ40nIqbi0kwMqhUs990WqBkQkClJBP4JKMgI/ZAA83X3hSg+M0Dm1o/MvZyduOTwvWJ3IN6vT/TUURTkaXMwkfoqdeuBvaDrl9FneKlIch15X7Sgglw52lo6b4FRoX5tI6aTuT1KbRUD0tJYLW73yHZnPjTzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199560; c=relaxed/simple;
	bh=AmF+WDWaYcX8MZFsGQ/YlwyK2/czsrzKjyb741pWddI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p44j9wwon12wNmyIebn/ICslT1eIu0brSiKeq+pop4uN/AKwc+s9HqxPTtaIXpUkQb9PKB0LxLBX4kDoa6iz/2Rb8TJmKIDbmFf9wbF3P4sHsPwPQRlUAjcmzyxH2H6uDQI1mzbmH4anyRfUaa3xe6etfz1Q2CwEyPUJhzeWfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EYQ0XypN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EB9C3277B;
	Wed, 12 Jun 2024 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718199560;
	bh=AmF+WDWaYcX8MZFsGQ/YlwyK2/czsrzKjyb741pWddI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYQ0XypN11sn0uqcK5nL33QO/eiL/v1wgcBkCtX69YhGkl6QfaUZCwZdF61TvsZSs
	 ZNJqPS/y0hvoBwyaeqvU21YPb7ViTOazFNvZx695bxacYX2Bj4wblezqqy5YOIP4KS
	 6vS5nnCKlQxzu+EobMr6BMTB116/uOzbFLCjJVhA=
Date: Wed, 12 Jun 2024 15:39:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Heusel <christian@heusel.eu>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Tim Teichmann <teichmanntim@outlook.de>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 6.9.y] x86/topology/amd: Evaluate SMT in CPUID leaf
 0x8000001e only on family 0x17 and greater
Message-ID: <2024061206-avatar-company-2f39@gregkh>
References: <2024060624-platinum-ladies-9214@gregkh>
 <20240606142350.24452-1-christian@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606142350.24452-1-christian@heusel.eu>

On Thu, Jun 06, 2024 at 04:23:50PM +0200, Christian Heusel wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The new AMD/HYGON topology parser evaluates the SMT information in CPUID leaf
> 0x8000001e unconditionally while the original code restricted it to CPUs with
> family 0x17 and greater.
> 
> This breaks family 0x15 CPUs which advertise that leaf and have a non-zero
> value in the SMT section. The machine boots, but the scheduler complains loudly
> about the mismatch of the core IDs:
> 
>   WARNING: CPU: 1 PID: 0 at kernel/sched/core.c:6482 sched_cpu_starting+0x183/0x250
>   WARNING: CPU: 0 PID: 1 at kernel/sched/topology.c:2408 build_sched_domains+0x76b/0x12b0
> 
> Add the condition back to cure it.
> 
>   [ bp: Make it actually build because grandpa is not concerned with
>     trivial stuff. :-P ]
> 
> Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
> Closes: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/56
> Reported-by: Tim Teichmann <teichmanntim@outlook.de>
> Reported-by: Christian Heusel <christian@heusel.eu>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: Tim Teichmann <teichmanntim@outlook.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/7skhx6mwe4hxiul64v6azhlxnokheorksqsdbp7qw6g2jduf6c@7b5pvomauugk
> (cherry picked from commit 34bf6bae3286a58762711cfbce2cf74ecd42e1b5)
> Signed-off-by: Christian Heusel <christian@heusel.eu>
> ---
>  arch/x86/kernel/cpu/topology_amd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Now queued up, thanks.

greg k-h

