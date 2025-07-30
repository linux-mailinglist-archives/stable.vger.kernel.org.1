Return-Path: <stable+bounces-165204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D205B15B42
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F09E17EDD2
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2972926A0E7;
	Wed, 30 Jul 2025 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hm1fU27N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9510269B0D
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 09:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866699; cv=none; b=ZYsZfGWgS2R8gs6vEts05Yrvq1CHgg6sRapyaIYMGJPuYCyyzTDW57eItynCEu8PHVLWxSmPZrVTe1AfaNAuWLvAMx7nbru86tcjKZ255hmFErQBhzhRPMcUQv4dlKovU0ms2AY3UsHRqz85NJAfHR+EhOTzHixX3t9fFLu1d/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866699; c=relaxed/simple;
	bh=+WJQc3mYDbfpVTQtAeaxwuqRmL/J78a6VB39X7ejTAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD7ZZAzNesjNMYJr/b9nB33gSlXmMnNzhNeHJ3CjjDs4MPDVg7N9Qsi1WN5rf/Hc0HY1jGGXH/owMIKEW9OcgVjyFeQvXFvowKRbgOE1FS1vAxqjMoPkM99JKVp2gkh4j6ZJg9me+VsCJ3aPvqvzJYDgnjmgohrTxHGqs7gaES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hm1fU27N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BE7C4CEF5;
	Wed, 30 Jul 2025 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753866699;
	bh=+WJQc3mYDbfpVTQtAeaxwuqRmL/J78a6VB39X7ejTAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hm1fU27NDFSnkBE9UggPHpRDTFLibx94kyAjuJ3rFHcCCaAHF2LLP6VuIWZlWnZa7
	 BikAKPF/Qjbr07gnjQ/+4dMcv5YCjs55aUuaA2s0HHae5sdhQ+miYdJyzyQVpVWxi4
	 MKivbNf7SMxbWPXpo3lZcHaVd6zHNs8Juo8EUWhE=
Date: Wed, 30 Jul 2025 11:11:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: skulkarni@mvista.com
Cc: sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4.y 8/8] act_mirred: use the backlog for nested calls
 to mirred ingress
Message-ID: <2025073030-thrash-negative-6089@gregkh>
References: <1753464140-e7196da4@stable.kernel.org>
 <20250728052618.171895-1-skulkarni@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728052618.171895-1-skulkarni@mvista.com>

On Mon, Jul 28, 2025 at 10:56:18AM +0530, skulkarni@mvista.com wrote:
> My apologies for sending the HTML content in the previous email/reply which was rejected by the stable mailing list.
> Here is a resend without HTML part:
> ---
> 
> Hello Sasha/Greg,
> 
> For the "found follow-up fixes in mainline warning" for this patch:
> "Found fixes commits:
>  5e8670610b93 selftests: forwarding: tc_actions: Use ncat instead of nc"
> 
> While analysing the patches, I actually had noticed that the commit 5e867061 is a follow up i.e. "fixes" commit. But this commit  5e867061 is not part of the next stable kernel v5.10.y and as per my understanding, we are not allowed to backport a commit which is not in the next stable kernel version. Thus I haven't included that commit/patch here.
> 
> I am new to the process & learning the rules. Can you please let me know if any action is required from my side for this patchset here?

You need to submit all of the needed fixes for anything you have
backported as well.  As you are introducing a "problem", that would not
be good.

But, as you say, this is not in the 5.10.y tree yet, so please submit a
version for that as well, then there should not be any problem.

thanks,

greg k-h

