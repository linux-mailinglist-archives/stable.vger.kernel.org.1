Return-Path: <stable+bounces-223652-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKLEMFvNrmnEIwIAu9opvQ
	(envelope-from <stable+bounces-223652-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:38:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6F6239DBE
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C21A0301B7BB
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36EF3BD628;
	Mon,  9 Mar 2026 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BqciC4Hh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E433B8D5F
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063512; cv=none; b=QmdrXFSPI3Z6bAOQ07pLVfgTxaQCajEj3KyzOtGIlpjPOojStUpUU5GzHpRXZJhajkYTO2zoo1ukURPWVQA1gGayFiPdJ7fjJTcbyGQS6lBYlU3gmc8jSWyUO/4l3WwaJch3QlIg3YhedHk7btgaXiybocuNKRXRdu5Zs0TfA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063512; c=relaxed/simple;
	bh=dR1HiiLQCIUmyP4yD9x6Z453rum3kL8Dyh137H2LTnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdXJ8V/C3/K6GDdBhg2Jd1lEBlGp0ANH/crBjnlrMSMSLK655YYGhVaZwIRRvnE4zYXlUgaKa0iXBruCB3OmQrgW/Acrhvxv/0BorNfIZ90Z79ajDTIxBWG6FXyV+A9VOP0dI7jv+A6ln06leH24Aex23B7XroJ/QRoWj4qjlMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BqciC4Hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CE6C4CEF7;
	Mon,  9 Mar 2026 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773063511;
	bh=dR1HiiLQCIUmyP4yD9x6Z453rum3kL8Dyh137H2LTnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqciC4HhJE1rF8QuYqS1a2OiS5KszbDrT1q4ymy2S3bPXfGVmwYMQQzXzFNKgVyLN
	 MDYQfyq15PzqZ6hPU1Uyfz5vUC2o/GxGteAonjrmWaXcJpZkzhHb37+yhA5w+ZGYBl
	 MGbxHTJN1CXfoZ0kQ0HgZOBPU7Skm0pG5Vp9j018=
Date: Mon, 9 Mar 2026 14:38:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, pshete@nvidia.com,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Patch "soc/tegra: pmc: Fix unsafe generic_handle_irq() call" has
 been added to the 6.19-stable tree
Message-ID: <2026030910-strength-relapse-8dee@gregkh>
References: <20260227025419.2745361-1-sashal@kernel.org>
 <20260227071216.6dYMGnMj@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227071216.6dYMGnMj@linutronix.de>
X-Rspamd-Queue-Id: 6A6F6239DBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223652-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,goodmis.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.582];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 08:12:16AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-26 21:54:18 [-0500], Sasha Levin wrote:
> > Author: Prathamesh Shete <pshete@nvidia.com>
> > Date:   Thu Jan 8 05:01:03 2026 +0000
> > 
> >     soc/tegra: pmc: Fix unsafe generic_handle_irq() call
> >     
> >     [ Upstream commit e6d96073af681780820c94079b978474a8a44413 ]
> >     
> >     Currently, when resuming from system suspend on Tegra platforms,
> >     the following warning is observed:
> >     
> >     WARNING: CPU: 0 PID: 14459 at kernel/irq/irqdesc.c:666
> >     Call trace:
> >      handle_irq_desc+0x20/0x58 (P)
> >      tegra186_pmc_wake_syscore_resume+0xe4/0x15c
> >      syscore_resume+0x3c/0xb8
> >      suspend_devices_and_enter+0x510/0x540
> >      pm_suspend+0x16c/0x1d8
> >     
> >     The warning occurs because generic_handle_irq() is being called from
> >     a non-interrupt context which is considered as unsafe.
> >     
> >     Fix this warning by deferring generic_handle_irq() call to an IRQ work
> >     which gets executed in hard IRQ context where generic_handle_irq()
> >     can be called safely.
> >     
> >     When PREEMPT_RT kernels are used, regular IRQ work (initialized with
> >     init_irq_work) is deferred to run in per-CPU kthreads in preemptible
> >     context rather than hard IRQ context. Hence, use the IRQ_WORK_INIT_HARD
> >     variant so that with PREEMPT_RT kernels, the IRQ work is processed in
> >     hardirq context instead of being deferred to a thread which is required
> >     for calling generic_handle_irq().
> >     
> >     On non-PREEMPT_RT kernels, both init_irq_work() and IRQ_WORK_INIT_HARD()
> >     execute in IRQ context, so this change has no functional impact for
> >     standard kernel configurations.
> 
> sorry for not noticing this earlier: Instead of irq_work() and all this,
> I would suggest to revert this and simply switch to
> generic_handle_irq_safe() instead.

Can you send a patch upstream for this and tag it for stable?

thanks,

greg k-h

