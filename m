Return-Path: <stable+bounces-125665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E3A6A931
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 15:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46DCB189F7D6
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D41E3DEF;
	Thu, 20 Mar 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CyL1C3aZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D911DE3BA
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482141; cv=none; b=exRpUQb0tMnl0nEVt6f5PBFsFt+yt/04Khi8bO64pMvzMHvB+bl6UZZjjC0z3Ia4KWkh6qx77y7L8YpI70X/wOPnyO9IA2Znoxj4dfRpqzlN5H7Boj3MF+Dr42hpHeNekSlWoh3U9srZUWnrMaj+rmRMWNC8wdzOb4dy2zvSED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482141; c=relaxed/simple;
	bh=WtjkO0TQKzt0RszppKlScob3eWyi8tuviBJJzqoEBTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmxw46djciDFynCuA710AjTt8FCllZo538dBSg3ICOrdn/9Haa0Jf2j5OMDzD2RYlGOSdG+SAplt9kz6YD47A0y52oPrVuDe0b8PououotG5EPsksqwgrCSN5di5WSVhkPX/85YQUqyp8K0B3TpKnmGy4dfC07sbAWnefooKyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CyL1C3aZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50033C4CEDD;
	Thu, 20 Mar 2025 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742482140;
	bh=WtjkO0TQKzt0RszppKlScob3eWyi8tuviBJJzqoEBTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CyL1C3aZPMJhhPBYWMYT3FJ6pgoDBTnHkvQ63AL9mrM/EQfs5zS7ywHXAOTXYCeSw
	 WNU0Quq1ula3tzr+BWZWb4TwOJDiarcQuwLTkJZbblEIN+Teo+bDAxS0G18FhtkPr9
	 bNTrIa0oYjIt+sT1/BuiHS0R/O15/+g28wJtBX+Q=
Date: Thu, 20 Mar 2025 07:47:40 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Clarifying stable kernel rule on selftest backporting
Message-ID: <2025032033-obvious-directive-af8d@gregkh>
References: <oy6rjahx5grqer7yfhts5y2s6mivgjhevf5gtgkzlytiqznk4i@fglskeuhoilh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oy6rjahx5grqer7yfhts5y2s6mivgjhevf5gtgkzlytiqznk4i@fglskeuhoilh>

On Thu, Mar 20, 2025 at 10:31:16PM +0800, Shung-Hsi Yu wrote:
> Hi,
> 
> Do we have any rule regarding whether a patch that adds a new test case
> in tools/testing/selftests/ can be considered for backport?
> 
> For example, consider commit 0a5d2efa3827 ("selftests/bpf: Add test case
> for the freeing of bpf_timer"), it adds a test case for the issue
> addressed in the same series -- commit 58f038e6d209 ("bpf: Cancel the
> running bpf_timer through kworker for PREEMPT_RT"). The latter has been
> backported to 6.12.y.
> 
> Would commit 0a5d2efa3827 be a worthwhile add to 6.12.y as well?

Sure!

> IMO having such test case added would be helpful to check whether the
> backported fix really works (assuming someone is willing to do the extra
> work of finding, testing, and sending such tests); yet it does not seem
> to fit into the current stable kernel rule set of:
> - It or an equivalent fix must already exist in Linux mainline (upstream).
> - It must be obviously correct and tested.
> - It cannot be bigger than 100 lines, with context.
> - It must follow the Documentation/process/submitting-patches.rst rules.
> - It must either fix a real bug that bothers people or just add a device ID
> 
> Appreciate any clarification and/or feedback on this matter.

Adding more selftests for fixes is great, but as most people just run
the latest version of the selftests on older kernel releases, it's not
usually needed.  If you note, we do backport a lot of selftest changes
for this type of thing, so it's not exactly a new thing for us.

So send the backport on and we will be glad to queue it up.

thanks,

greg k-h

