Return-Path: <stable+bounces-124881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8ADA684B1
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 06:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8359119C3200
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 05:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E3524E4C7;
	Wed, 19 Mar 2025 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1rAhZVoL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gr5IHlEF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59E20F060;
	Wed, 19 Mar 2025 05:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742363823; cv=none; b=YFUPDJ2X1Q5+sDiiFRVK/Fpmc8l96THOGhRwQek5GNumBMllAi3lNB1n5Y5X7P89IP4a2A2vV5xTJeURKusnZW1GzDMLkR9+wtLf2WFbXH/h3tTm5u201jc+wl5S653CbYh4Ev6PPG9QNyn39O4Hz0radDfoK+7XZ2VEElG5Ln4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742363823; c=relaxed/simple;
	bh=T0otBTV/6W6FGpqUqNIWoJL4tq1mjsyb9gKufZqadtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rddqg28/phA/tFOuXLsKYjpjuqJsC83OuklPlhqMEj/z4N4l1beshiVJqb56JkAQ+AgflijYxHgKcbZqwAuPttlghtHxq9XUzX+mP5rlm+bvpD13gl/Bfr2uoed0VjWLpG0rmikH1guNu7d1cJR5Z98DcNnN5v94FFfpbriLprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1rAhZVoL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gr5IHlEF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 06:56:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742363813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhNs5jIgxAZdS5yYj9y8SQEJJ9FxcQj5IZ8rsflvDhY=;
	b=1rAhZVoLIOoeYi4SmbmTdBq1WP6F95AGzxtni/TQoO0SC1JFnEJrF/UHDGXoulnGiOuCtK
	+jR1IVHJ3SG+HZCQasSUC8j6dyFSkwBTx/JWMIwQOTeLklsmTAIOQ6DWcStei20tBXcXCF
	zgAHze+qkU9eaG4F7z+Z9GhkFKE/cIEZfnWOIZj+aKWdvW0JryADPf7qnfztLeRxzTab/+
	tfXHAk2Cqp5pA1on5HOXVGovY/WmWyCzl6sYLkCD+pMNyX/xxUoU1zbhcOOW5p8dFrES11
	aD6bDEqcQcLLsA5D/SSJGyDBUJExKI1hyLRlEiEZyqahPHwQgOePgaM9/OADMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742363813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HhNs5jIgxAZdS5yYj9y8SQEJJ9FxcQj5IZ8rsflvDhY=;
	b=Gr5IHlEFk2qx6sQKvcaMaTAyuSquDUo8EXlmPlRY79D9nZKstQ5aaK9vMtWDwr36hNEj8p
	vqUMOqRf0NYPt+Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: cdns3: Fix deadlock when using NCM gadget
Message-ID: <20250319055653.uSl-FEiQ@linutronix.de>
References: <20250318-rfs-cdns3-deadlock-v2-1-bfd9cfcee732@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318-rfs-cdns3-deadlock-v2-1-bfd9cfcee732@linaro.org>

On 2025-03-18 11:09:32 [-0400], Ralph Siemsen wrote:
> The cdns3 driver has the same NCM deadlock as fixed in cdnsp by commit
> 58f2fcb3a845 ("usb: cdnsp: Fix deadlock issue during using NCM gadget").
> 
> Under PREEMPT_RT the deadlock can be readily triggered by heavy network
> traffic, for example using "iperf --bidir" over NCM ethernet link.
> 
> The deadlock occurs because the threaded interrupt handler gets
> preempted by a softirq, but both are protected by the same spinlock.
> Prevent deadlock by disabling softirq during threaded irq handler.
> 
> cc: stable@vger.kernel.org
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

