Return-Path: <stable+bounces-45281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0B48C75CA
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA28A1C20D0B
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D91459E2;
	Thu, 16 May 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YR5KrQOa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77925433D6
	for <stable@vger.kernel.org>; Thu, 16 May 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861774; cv=none; b=GaMS5isRQZ391JFi8gH0LWtk20w11arOhg8zjN0TGFg0scX33JMuKxumx+bTEyKSDseWZAYzxH6DyKwjEJ661vb2o5D7wNAs3jja0zNSeMdMFn48YgDOJiA5OCr0qkvJVVBMCJc14jK9l6s2Yzv6J9v4AFMfrEIhpDU31Q2PMps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861774; c=relaxed/simple;
	bh=4Fz1bl2P2SH2iq1lxfDHRNSq0ehnPFxIhinZfAQb7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCd31ulmaWxTbC1OSTobdDWW3AFOEX5ObrD/3CD0C0zaYElqZhWLFCTPSZptSSYFin1+RJObf0RNDF0guYoqf94IKO1jDWnEstLDZWgxW778SnfiYUXGTvy0wkp86qar4izVa+DFjcr6gPAkdLpY9LpnqVGimv5/JhHtYs4IvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YR5KrQOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E94C113CC;
	Thu, 16 May 2024 12:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715861773;
	bh=4Fz1bl2P2SH2iq1lxfDHRNSq0ehnPFxIhinZfAQb7zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YR5KrQOaST9z9cOU8gb0lKtRlMjNZSzod0zYluLbIWGC8fNZ7EGIWay/6thDzzIlb
	 LuUiEYH92XanfX7RkANqoYIlSYYUTscCoXkRExdMwlJeiUT/553aDe+dk7JQgQmwKm
	 8vQnHnp/CE0VSML+bHRq+b1e5MJW3FpDiSgCIyzg=
Date: Thu, 16 May 2024 14:16:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: rostedt@goodmis.org, akpm@linux-foundation.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] eventfs: Do not differentiate the
 toplevel events directory" failed to apply to 6.8-stable tree
Message-ID: <2024051624-delirium-punch-96f8@gregkh>
References: <2024051624-efficient-jingle-fc71@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024051624-efficient-jingle-fc71@gregkh>

On Thu, May 16, 2024 at 02:11:24PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
> git checkout FETCH_HEAD
> git cherry-pick -x d53891d348ac3eceaf48f4732a1f4f5c0e0a55ce
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051624-efficient-jingle-fc71@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..
> 
> Possible dependencies:
> 
> d53891d348ac ("eventfs: Do not differentiate the toplevel events directory")

Note, it applies, and builds, but fails testing, see this thread:
	https://lore.kernel.org/r/2024051628-direness-grazing-d4ee@gregkh

thanks,

greg k-h

