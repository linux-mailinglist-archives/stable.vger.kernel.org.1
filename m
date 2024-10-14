Return-Path: <stable+bounces-83745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7798299C37B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E29E1F21DEB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 08:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D37C1474B8;
	Mon, 14 Oct 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M7Hw4Sss"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49C1A270;
	Mon, 14 Oct 2024 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894972; cv=none; b=DOyTlb09anaz7sCnl2T3k8nAGoIuaj3otYm1QdnSGk9Cm8KGhO0mdTkzZRVPImko9xztbiOBhkqWogCOsSrReUWa46snaDoIS21z8JmYg6BNgXtuDydYSmi1jFDP2Ac4oOHYOHD2W1xQIwdp82rMLjxmgw7N8xxfpcb7HbOFWYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894972; c=relaxed/simple;
	bh=SLDPRDnmzXBGPmmHTDtmyHRfMMr7+XIbsyjLdVTqizA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMleA1e3+5vWd9QYRPwlhqIroWEo2cUPV0hP+zBRto9eJcbuEObuo7kXlDVno8D9CsoOae+Too4xJ2SrPI2Xmqxlx111IO8XYcajr/fsGYjwyjOnNnMrOcJYDkCW1BTvMYZ4okZ8LFTkwokfS0ll+dAbjWSM5Z22EQ27uoqMCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M7Hw4Sss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175CCC4CECE;
	Mon, 14 Oct 2024 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728894971;
	bh=SLDPRDnmzXBGPmmHTDtmyHRfMMr7+XIbsyjLdVTqizA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7Hw4SssMZFDsY+na2IdKE69/fzqcJ5xdw3VG0UM6EVuwZnSgdFv6/tZU6K2vhVKi
	 6VPYB7bSV7bLBmtsAdlK9DE8At05k2qmU1cF7eJ3OhEMba3IhgcI046spE+7eWkRdI
	 ln8YjL0kn6AsCeAvJ0zF2uSOv1L+QPcN1nTPAEn0=
Date: Mon, 14 Oct 2024 10:36:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sherry Yang <sherry.yang@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-stable <stable@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 0/2] tracing/kprobes: Backport request about
Message-ID: <2024101452-getup-legal-355f@gregkh>
References: <20240927214359.7611-1-sherry.yang@oracle.com>
 <2024100111-alone-fructose-1103@gregkh>
 <D99F1DB5-4DDE-478A-BCB6-C510CAFC1C67@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D99F1DB5-4DDE-478A-BCB6-C510CAFC1C67@oracle.com>

On Fri, Oct 11, 2024 at 04:55:15PM +0000, Sherry Yang wrote:
> Hi Greg,
> 
> > On Oct 1, 2024, at 1:11 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > On Fri, Sep 27, 2024 at 02:43:57PM -0700, Sherry Yang wrote:
> >> The new test case which checks non unique symbol kprobe_non_uniq_symbol.tc 
> >> failed because of missing kernel functionality support from commit 
> >> b022f0c7e404 ("tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbols"). 
> >> Backport it and its fix commit to 5.4.y together. Resolved minor context change conflicts.
> >> 
> >> Andrii Nakryiko (1):
> >>  tracing/kprobes: Fix symbol counting logic by looking at modules as
> >>    well
> >> 
> >> Francis Laniel (1):
> >>  tracing/kprobes: Return EADDRNOTAVAIL when func matches several
> >>    symbols
> > 
> > As per the documentation, we can't take patches for older kernels and
> > not newer ones, otherwise you will have regressions when you finally
> > move off this old kernel to a modern one :)
> > 
> > Please resend ALL of the needed backports, not just one specific kernel.
> > I'm dropping these from my review queue now.
> 
> I have sent the backports to 5.10.y, and Sasha queued them up. Can we get this series in your 5.4.y review queue again?

Please resend them as they are long gone from my queue.

thanks,

greg k-h

