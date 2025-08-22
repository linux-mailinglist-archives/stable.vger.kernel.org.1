Return-Path: <stable+bounces-172427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E63B31BBC
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93AE17868F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7999E309DA5;
	Fri, 22 Aug 2025 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lu7icW0K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368652FC003
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872423; cv=none; b=XQVqvJJAxDcmwGtbJ99Uozhd9p7OQsahlmNc0ONx9VoDPeZ+BnIBIMgbNGO53c8H2IvkeAjs2V83Jk5FSkNAMZ2cBNseWZDVhV0q0fnzvUx8XHtxxK3eKZ5Iuflzsprjr7ZCyVZeA2hsg5FoG8SwOLt3DMfpZRw9H9QRyQW6omM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872423; c=relaxed/simple;
	bh=mraSJkpOKceAxXfhootrA+JjyuEssv5/UXj0Oe2dVqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR1DP1pWsdzgnpUE8OXATVdP0ZZOh0Amd0w2cF8vDYjeconpyXcACRPdFJqwBBOxYb773Q1VhLull3T8RVjgkq6I2rp37MA2bELDCLkJzq1WRsBuTtAWZFPNZ+3/ApI53GjDH657O59HAgb7dbMCJdb2Pa7LqCHRDsLs56vVXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lu7icW0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBE6C4CEED;
	Fri, 22 Aug 2025 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755872421;
	bh=mraSJkpOKceAxXfhootrA+JjyuEssv5/UXj0Oe2dVqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lu7icW0KY36ObRyhI5Gx91N2IVdyGkseunKu2FA0znq+9vx/G+zZ47aVd1QWi0zky
	 eXA9rBh8H8+WnuAalIbRmJ9YY100xCNQVgOzMaAloo9jdGoCw0FoXNPRwc5LnHTPcE
	 6yM4LkazQc/1ZGbqKO7zLiAgXfJpAAuZQ9E7eDJA=
Date: Fri, 22 Aug 2025 16:20:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: geliang@kernel.org, kuba@kernel.org, tanggeliang@kylinos.cn,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mptcp: remove duplicate sk_reset_timer
 call" failed to apply to 5.15-stable tree
Message-ID: <2025082210-urchin-unclad-fe27@gregkh>
References: <2025082230-dupe-going-e673@gregkh>
 <1ff67cdd-659c-4b52-9ff3-53916b4aaf90@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff67cdd-659c-4b52-9ff3-53916b4aaf90@kernel.org>

On Fri, Aug 22, 2025 at 04:01:34PM +0200, Matthieu Baerts wrote:
> Hello,
> 
> On 22/08/2025 08:04, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> 
> Thank you for the notification!
> 
> (...)
> 
> > From 5d13349472ac8abcbcb94407969aa0fdc2e1f1be Mon Sep 17 00:00:00 2001
> > From: Geliang Tang <geliang@kernel.org>
> > Date: Fri, 15 Aug 2025 19:28:22 +0200
> > Subject: [PATCH] mptcp: remove duplicate sk_reset_timer call
> > 
> > sk_reset_timer() was called twice in mptcp_pm_alloc_anno_list.
> > 
> > Simplify the code by using a 'goto' statement to eliminate the
> > duplication.
> > 
> > Note that this is not a fix, but it will help backporting the following
> > patch. The same "Fixes" tag has been added for this reason.
> > 
> > Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
> 
> Sorry, I should have updated the "Fixes" tag: this patch is only needed
> for trees having commit 304ab97f4c7c ("mptcp: allow ADD_ADDR reissuance
> by userspace PMs"), so v5.19+.
> 
> So this patch is not needed in v5.15.

Thanks for letting us know on this, and the other one.

greg k-h

