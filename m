Return-Path: <stable+bounces-25326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD66786A7AD
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 05:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED67B20A46
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 04:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EAB20323;
	Wed, 28 Feb 2024 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TmYgibc1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CC20B20
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709095615; cv=none; b=KeE1xHTlHAfWJmh1ViRt+w5hwxn7IxbWJZ6s+EZFRJolLGafA/SQgfOfwfgHK6t6k8MCvwPRzpDRxMJJqN73qc22bt4XpEuEnZy2fsDXpOFPdxpgmWBbILO3XU3dXEBCWO0PbkZMvXvpNKaKTGapXl4vjepgtU4ymGbgqTQ/eUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709095615; c=relaxed/simple;
	bh=dpYIJkPVh3mPyPk3xQoQiO5f/SIloTYiCZ1jgjbThDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdAFnBv3qgYKTIJMYTHajKp2aaqK4RnED6rvdSY/TCBhkh8LVZTa6ljCI7rTsJfXv0xzWoouxNTFbualZdh1ot9wfmHjZkNcdXF3st9k6/yZGyX0VS9QFs/HKc0QU/kLDM2L0hUpTzEB9NP9gAmTAjTHDiiM3Xb1G3Z/F7GfP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TmYgibc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F11CC433C7;
	Wed, 28 Feb 2024 04:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709095614;
	bh=dpYIJkPVh3mPyPk3xQoQiO5f/SIloTYiCZ1jgjbThDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TmYgibc1P3GwoAQd0ROKJVYdyYUkKkDPafElDmLKPNDHqxPfIVKO8ZoT31GBgtOIK
	 sVEjMhTdXYjNJd8xJjUG51+6VV/anaPMuAmNWAomJI+N9gmfBpXpda7lUv0kzTT0Dz
	 EU5lRfJgI2w/EEhfkCQa0EnDzQvCIBZaDWyLMGZs=
Date: Wed, 28 Feb 2024 05:46:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Cc: stable@vger.kernel.org, phaddad@nvidia.com, shiraz.saleem@intel.com,
	ajay.kaher@broadcom.com
Subject: Re: Backport fix for CVE-2023-2176 (8d037973 and 0e158630) to v6.1
Message-ID: <2024022817-remedial-agonize-2e34@gregkh>
References: <20240228001506.3693-1-brennan.lamoreaux@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228001506.3693-1-brennan.lamoreaux@broadcom.com>

On Tue, Feb 27, 2024 at 04:15:06PM -0800, Brennan Lamoreaux wrote:
> Hi stable maintainers,
> 
> The following patch in mainline is listed as a fix for CVE-2023-2176:
> 8d037973d48c026224ab285e6a06985ccac6f7bf (RDMA/core: Refactor rdma_bind_addr)
> 
> And the following is a fix for a regression in the above patch:
> 0e15863015d97c1ee2cc29d599abcc7fa2dc3e95 (RDMA/core: Update CMA destination address on rdma_resolve_addr)
> 
> To my knowledge, at least back to v6.1 is vulnerable to this same bug.
> Since these should apply directly to 6.1.y, can these be picked up for that branch?

If you provide a working backport of that commit, we will be glad to
apply it.  As-is, it does not apply at all, which is why it was never
added to the 6.1.y tree.

thanks,

greg k-h

