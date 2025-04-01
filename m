Return-Path: <stable+bounces-127315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3511EA77916
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847051887A6D
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D31E1C22;
	Tue,  1 Apr 2025 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Or+ZWyMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E4DF60
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504535; cv=none; b=DLmQDlBhRVd1VEu9j4SkRuz/G8oMgK0FWLE939kQkepV4uuWsAupRPZ4XsBDZLpWN+UPFY6ebzqZleoTVLFEmOGKyUH+xrqEZUvs3x62u+FlDJIwCwzROXSfWnrcEOtUeatXvFBDu6V8Xfa4tWtlnLFJvK7BX5cjOj+M9qeEAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504535; c=relaxed/simple;
	bh=uGq040buThR+dhH4M4o1JxphDZSPmXUausDj7lvIJAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACJcqzGsYga4ESSguJTnPgLqSqQgZgtnHk75BgguhO36rs8UrqX2PgLtc1sgZmkdkDcoGU8RMfG/HwDz08Oz3n7mCHGuoQBMWVD/RHb/kxWNG04zeQN+8RJP52PZ6MQDzTAKmrFBKfomytXFcSzFV/YqhqSdyYC51hk7XM1KnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Or+ZWyMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ACDC4CEE4;
	Tue,  1 Apr 2025 10:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743504533;
	bh=uGq040buThR+dhH4M4o1JxphDZSPmXUausDj7lvIJAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Or+ZWyMnqxe2UP+d/4l/vl8S3H3dLE6Bt5XN8w1FxamMYq03PAxfe/4vimatIicVL
	 qf0Wr032ukmuAhnlPnLY49JI5ccdYGiFM5BOWrp5kThd6xclPYeH+551ghMWvJEXj0
	 ohvyR6QndsevvJWX8BzZ2RFffXGbGpFgtmcOdieU=
Date: Tue, 1 Apr 2025 11:47:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Request for backporting c4af66a95aa3 ("cgroup/rstat: Fix
 forceidle time in cpu.stat")
Message-ID: <2025040146-pennant-chain-0027@gregkh>
References: <Z9xWdxsAadLyp1SV@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9xWdxsAadLyp1SV@slm.duckdns.org>

On Thu, Mar 20, 2025 at 07:55:03AM -1000, Tejun Heo wrote:
> Hello,
> 
> c4af66a95aa3 ("cgroup/rstat: Fix forceidle time in cpu.stat") fixes
> b824766504e4 ("cgroup/rstat: add force idle show helper") and should be
> backported to v6.11+ but I forgot to add the tag and the patch is currently
> queued in cgroup/for-6.15. Once the cgroup pull request is merged, can you
> please include the commit in -stable backports?

Included now in 6.13.y and 6.14.y queues, but fails to apply to 6.12.y,
so can you send a backported version of that to us?

thanks,

greg k-h

