Return-Path: <stable+bounces-112285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C76BA28657
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 10:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50743A76E7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 09:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B5122A4E5;
	Wed,  5 Feb 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJOCW5dU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF0228383;
	Wed,  5 Feb 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738747101; cv=none; b=fWfckWAb+2xWoSvg4LHR2XBlS5wozD53ISdMX0fGgKWqmArYQcmRDxqS3YXERZvpSry8frUbPgi7RwKTFU+/dqjUOh5MFx4bSXyCDfgyNKq8/vT4/nJWKunaD4dSq49Psfp2islEREOtRO70fsY8uTML8PUtdmc4ctv0VxrzyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738747101; c=relaxed/simple;
	bh=BwEguvJcszdmiWk2vKx2IJNL7jjLlqmazqYLrIneYoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIxoUJgDthCZ3j6lG0t1snD4YsE0WVC5TDCP0s0By8KEHnbRy3VkK6PfE1W7dB88S/ZWklJMCfROpkKYpo6261le0D7TQFMdzS01bR9e2sdjZEVdOf2uo8H2D+bulbWU6hT071o7VtmjZOyg9gny0WPSV/bWzlKCgiLPCc77bps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJOCW5dU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D42C4CED1;
	Wed,  5 Feb 2025 09:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738747101;
	bh=BwEguvJcszdmiWk2vKx2IJNL7jjLlqmazqYLrIneYoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJOCW5dUOQT0zpQz3EXD0a8AJoafowCcp5ubL+xZYZ7S/gu2+SXCTpxtPffFrbsFT
	 kjjmkf+fBRlf2JJrwd/h3eu1IqetzRaYajiHtwv9xwR+cusPqa+5lid+ZHBHIhryqO
	 KiF4VtchcHZEyUN/IfIQ7xHaAtwv57GrA7YXwR1U=
Date: Wed, 5 Feb 2025 10:18:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Krishanth.Jagaduri@sony.com
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Atsushi Ochiai <Atsushi.Ochiai@sony.com>,
	Daniel Palmer <Daniel.Palmer@sony.com>,
	Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Documentation/no_hz: Remove description that states boot
 CPU cannot be nohz_full
Message-ID: <2025020547-judo-precise-0b3c@gregkh>
References: <20250205-send-oss-20250129-v1-1-d404921e6d7e@sony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205-send-oss-20250129-v1-1-d404921e6d7e@sony.com>

On Wed, Feb 05, 2025 at 08:32:14AM +0530, Krishanth Jagaduri via B4 Relay wrote:
> From: Oleg Nesterov <oleg@redhat.com>
> 
> [ Upstream commit 5097cbcb38e6e0d2627c9dde1985e91d2c9f880e ]

It's just the documentation part of that commit, not the full one.

> Documentation/timers/no_hz.rst states that the "nohz_full=" mask must not
> include the boot CPU, which is no longer true after:
> 
>   commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be nohz_full").
> 
> Apply changes only to Documentation/timers/no_hz.rst in stable kernels.

You dropped the rest of the changelog text here :(

> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Cc: stable@vger.kernel.org # 5.4+
> Signed-off-by: Krishanth Jagaduri <Krishanth.Jagaduri@sony.com>

And you dropped all the other signed-off-by lines :(

> ---
> Hi,
> 
> Before kernel 6.9, Documentation/timers/no_hz.rst states that
> "nohz_full=" mask must not include the boot CPU, which is no longer
> true after commit 08ae95f4fd3b ("nohz_full: Allow the boot CPU to be
> nohz_full").
> 
> This was fixed upstream by commit 5097cbcb38e6 ("sched/isolation: Prevent
> boot crash when the boot CPU is nohz_full").
> 
> While it fixes the document description, it also fixes issue introduced
> by another commit aae17ebb53cd ("workqueue: Avoid using isolated cpus'
> timers on queue_delayed_work").
> 
> It is unlikely that it will be backported to stable kernels which does
> not contain the commit that introduced the issue.
> 
> Could Documentation/timers/no_hz.rst be fixed in stable kernels 5.4+?

Does the documentation lines really matter here?

At the very least, we can't take this as the signed-off-by lines are all
gone.  Please resend with them all back, and then make a note that you
are only including the documentation portion and why.

thanks,

greg k-h

