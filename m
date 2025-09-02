Return-Path: <stable+bounces-176960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EDDB3FA7B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65F6E189447F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF842EB874;
	Tue,  2 Sep 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wFMY1kWT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D392E2EB845;
	Tue,  2 Sep 2025 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805626; cv=none; b=WUQmdeD8uwci8qxK+homIhFIEONj8sqHzjfNlHWUA0oxU8E0z2Y5nWeX9PXBV3iXp7fSY69oPMUNzIRIU55DNccGPoP7PauNhJHRzF5oOYdBD0Ia3+L2kY7upkFq1oXdHBDJgPAa1A+p0qyWQXucColzvA87BLb/R3YZs2mfScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805626; c=relaxed/simple;
	bh=1IIi9QXKBT03w09uxQJwrIgICSBS/nK87PXWBV+Hhwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BE1EvyPqOU/ZeIMWD/1Le3AetcuQb05U3q6UGWTTKdnzeoev4DCTXecWIptixRCOIRS6YaBnq/YZaZ3y281R5WVnYTlizH6rpYU+kkGKRxLS9KOigBraHGTelYsQQNG/2shzWy3A1i9r/JcW+aifNmvkXmXni8uwTvY8ahKf7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wFMY1kWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DEDC4CEED;
	Tue,  2 Sep 2025 09:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756805625;
	bh=1IIi9QXKBT03w09uxQJwrIgICSBS/nK87PXWBV+Hhwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wFMY1kWTmD7Tv4vZLGR2ZsQdkGc5DsFdWaSm/4gCgQKnU9N1R/UGdwEbWa4LxKyer
	 DCMEpVmq0UzqoaHgSSPl8NWrQ4sg6Xqfh1bOOarse+mR5+ofnxtle5kfgDYEngN5kK
	 chQ7Wnghf39Fu1FHtnG1S1KyZ5tYH2P2pAGHDQpI=
Date: Tue, 2 Sep 2025 11:33:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Miaoqian Lin <linmq006@gmail.com>, stable@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] cdx: Fix device node reference leak in
 cdx_msi_domain_init
Message-ID: <2025090236-fernlike-ovary-ed81@gregkh>
References: <20250902084933.2418264-1-linmq006@gmail.com>
 <a4130364-dabd-4a95-b793-06ba5581e56f@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4130364-dabd-4a95-b793-06ba5581e56f@web.de>

On Tue, Sep 02, 2025 at 11:05:45AM +0200, Markus Elfring wrote:
> > Add missing of_node_put() call to release
> > the device node reference obtained via of_parse_phandle().
> 
> You may occasionally put more than 58 characters into text lines
> of such a change description.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc4#n638
> 
> 
> How do you think about to append parentheses to the function name
> in the summary phrase?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

