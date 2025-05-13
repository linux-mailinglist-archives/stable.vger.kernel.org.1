Return-Path: <stable+bounces-144114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F12DAB4C62
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05E83BF16A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0F1EF0BB;
	Tue, 13 May 2025 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="guZnPtVU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6011712
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119420; cv=none; b=O8jR/WwOT8a7dlLNi7GFAb6IlZWxpDW7+FFlXzyIUpNFEmmEZd9nfd321CzYWWn38ue4vdGaFovW2PKVrw5mlcnFxpbp4T+9rZmCg/Oz1dXvka0nqHvujzfkHMo3YyERdJIpwXz8uTQ6XOpkmEDXf/0CbM3/LOTLjgHdBzLgsFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119420; c=relaxed/simple;
	bh=tXjMvgp4s5EFz0NBiRER5LjSWzBwNLVhXzdHmeDi9n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5KGB9WwPCGZxi/vCn4C5nzRUedZ8jCIF2doGKuA9m/QQ08+uRg//gixqwGWonivXfn8o3COsPiZ3k8A7BDGT4cEdRr7exG2SAxB0zkzfTEZNzpvu9YB3Y/6uZNAJmmJf+bNQrnNurCR1p+kDRuK8FhDq2iUXKtXu1tyRh923wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=guZnPtVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD25C4CEED;
	Tue, 13 May 2025 06:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747119420;
	bh=tXjMvgp4s5EFz0NBiRER5LjSWzBwNLVhXzdHmeDi9n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guZnPtVU6Dq68eXRuraDEYcXPL47oyxWQK2TqITJq03JsRMfRLPGCpM7Zh2Y8UBev
	 RCw5ZjtW9Mi783NAOB3552Pk7UrNpyJmCP2XneTfoT28+yhH146w8hpQQ0PKztlvms
	 2jO7QwtrwHv1Oy+ZrR9i8d9dpLK/PZo/WlS7fqYU=
Date: Tue, 13 May 2025 08:55:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tglx@linutronix.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] clocksource/i8253: Use
 raw_spinlock_irqsave() in" failed to apply to 6.1-stable tree
Message-ID: <2025051336-applied-ambiguous-08e7@gregkh>
References: <2025051256-encrust-scribe-9996@gregkh>
 <20250513065326.frlx-qtR@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250513065326.frlx-qtR@linutronix.de>

On Tue, May 13, 2025 at 08:53:26AM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-05-12 12:31:56 [+0200], gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 94cff94634e506a4a44684bee1875d2dbf782722
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051256-encrust-scribe-9996@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > 
> …
> 
> I performed these steps and the patch applied. The diff is the same so
> git did not attempt to resolve a conflict on its own. HEAD was at
> v6.1.138 at the time.

Did you build the result?  Many times FAILED reports are due to that.

thanks,

greg k-h

