Return-Path: <stable+bounces-75945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35D9760DE
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 07:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4EE1F28591
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 05:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB0188A08;
	Thu, 12 Sep 2024 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5QCx/GV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935C18890C;
	Thu, 12 Sep 2024 05:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120753; cv=none; b=iT3Qv5KOjzhdOO1fhsp/re25Mx7VB5kJaSftpD/gj4cSaz7Qz1SRZix3f7rLZ910xi2lW1YKZJoGtnsjvGEWGqgDarFy4Z1EQHzy/6wFtvlF6Yc1lJGUrgUY2V8NbQ5bXpgQirfId+ckeSbic29tV2+AB5egQTkKALwgEjvXPrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120753; c=relaxed/simple;
	bh=nBvEpR5w9mOpbzrTW/zqtMNH47LbrUPYrT4gFzhhlnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S44vj10vbWQjxjypBMa5CuSzJTkgVh0B02Hp0SPBTzsrG8+Q3XncWdIydOmVvbGKTdgZiAM80LEftS4b+ijMblbMjKlC+QKryK+tUlPAj8HMVMZSTsHIdCjvRS7oBWNPJ3odfhp4faUZV/skxmBZA1czui2X/KNgUmyk3AvmlHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5QCx/GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF512C4CEC3;
	Thu, 12 Sep 2024 05:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726120753;
	bh=nBvEpR5w9mOpbzrTW/zqtMNH47LbrUPYrT4gFzhhlnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5QCx/GV1Zz4coe5Xac1Jm3vbt+kRNWg/c6nDakVvgXlUVpx2fXjCo9xdkr4+qZhe
	 qI8JsslQICDEGfhgkqLZpF19XYMFf1ohPQMs0evkA8CvDKhEm9hKIFHHIRO9c9wLg4
	 FV0ST2isYoKMB+t4dP6B65CWla5fQ1QXN1SR3C6UuEkaNJ5m3E6oc0sHf+JxWkq8t0
	 cfn912Ort8v12QleNY55c8wuloyTWaZVNPVi3JuOlK2mZdbJcOp/hR1/vc9HHnoInD
	 G/2Q8YqTCM2U1O/LzsDfRmN/VfI9AFwc4dauegeuS9Iu1lNKgao+h1GtuM8s/0hjTx
	 UYpVLYTwrP9bw==
Date: Wed, 11 Sep 2024 19:59:11 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] workqueue: Clear worker->pool in the worker thread
 context
Message-ID: <ZuKDL1xuDeAzExSN@slm.duckdns.org>
References: <20240912032329.419054-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912032329.419054-1-jiangshanlai@gmail.com>

On Thu, Sep 12, 2024 at 11:23:29AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> Marc Hartmayer reported:
>         [   23.133876] Unable to handle kernel pointer dereference in virtual kernel address space
>         [   23.133950] Failing address: 0000000000000000 TEID: 0000000000000483
>         [   23.133954] Fault in home space mode while using kernel ASCE.
>         [   23.133957] AS:000000001b8f0007 R3:0000000056cf4007 S:0000000056cf3800 P:000000000000003d
>         [   23.134207] Oops: 0004 ilc:2 [#1] SMP
> 	(snip)
>         [   23.134516] Call Trace:
>         [   23.134520]  [<0000024e326caf28>] worker_thread+0x48/0x430
>         [   23.134525] ([<0000024e326caf18>] worker_thread+0x38/0x430)
>         [   23.134528]  [<0000024e326d3a3e>] kthread+0x11e/0x130
>         [   23.134533]  [<0000024e3264b0dc>] __ret_from_fork+0x3c/0x60
>         [   23.134536]  [<0000024e333fb37a>] ret_from_fork+0xa/0x38
>         [   23.134552] Last Breaking-Event-Address:
>         [   23.134553]  [<0000024e333f4c04>] mutex_unlock+0x24/0x30
>         [   23.134562] Kernel panic - not syncing: Fatal exception: panic_on_oops
> 
> With debuging and analysis, worker_thread() accesses to the nullified
> worker->pool when the newly created worker is destroyed before being
> waken-up, in which case worker_thread() can see the result detach_worker()
> reseting worker->pool to NULL at the begining.
> 
> Move the code "worker->pool = NULL;" out from detach_worker() to fix the
> problem.
> 
> worker->pool had been designed to be constant for regular workers and
> changeable for rescuer. To share attaching/detaching code for regular
> and rescuer workers and to avoid worker->pool being accessed inadvertently
> when the worker has been detached, worker->pool is reset to NULL when
> detached no matter the worker is rescuer or not.
> 
> To maintain worker->pool being reset after detached, move the code
> "worker->pool = NULL;" in the worker thread context after detached.
> 
> It is either be in the regular worker thread context after PF_WQ_WORKER
> is cleared or in rescuer worker thread context with wq_pool_attach_mutex
> held. So it is safe to do so.
> 
> Cc: Marc Hartmayer <mhartmay@linux.ibm.com>
> Link: https://lore.kernel.org/lkml/87wmjj971b.fsf@linux.ibm.com/
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Fixes: f4b7b53c94af ("workqueue: Detach workers directly in idle_cull_fn()")
> Cc: stable@vger.kernel.org # v6.11+
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Applied to wq/for-6.11-fxes.

Thanks.

-- 
tejun

