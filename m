Return-Path: <stable+bounces-95803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE6A9DC351
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616C6281AE7
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7E189521;
	Fri, 29 Nov 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/hGzSSA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D2157484
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732882526; cv=none; b=KStaXF+ZFqdZUD7lLhab9nQYbZG31kDGaSGhKPoZhtfz64htte55eTH8gHr5TMFafD19+/E7895NFXRkmjgmfo14iv5+sEBljZHX+qc5KjYP/75wX5yNOw963VNqmGBh1OcXWLR1OpfUdohzeb6PBq+ec/qLrGaJYZKSsCWPan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732882526; c=relaxed/simple;
	bh=hl9t5Mvv6dUvHWWyl/7LLm1RjdicggxsP5LVoWytoBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R17U4VTp11paUAMbyG+AgWT2+dARml3YTwRevaAsdLnULUnoJdDWmT2BV0n4qy/ms7D8s8BZeNm2r+eUDl9gLvPCtn32Z3mRrzLcUPZR3mWg/px/zVbbVFJOOtu3f62Ib7k5IxkE0jO04KgCqkHxL1FrbOlfVqqjfOiLXFdVVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/hGzSSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFA8C4CECF;
	Fri, 29 Nov 2024 12:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732882526;
	bh=hl9t5Mvv6dUvHWWyl/7LLm1RjdicggxsP5LVoWytoBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/hGzSSAPJFuG/mtdFj6gaOzQkMACcDybj6pk+JxG+64eODeaa0igwzmpjsEELhWH
	 16vso77QXNc1IcI1HJ6DyjxXc9O21CXSM+wBr3GNvQDpP9ga0BIQxjoaMy8BY6ISgd
	 j2Fbox9RO8eI57K8jCmqbd/2kcXsNRhB97DPA7Sw=
Date: Fri, 29 Nov 2024 13:15:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Acs <acsjakub@amazon.com>
Cc: Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
	Jakub Acs <acsjakub@amazon.de>
Subject: Re: [PATCH 6.1/5.15/5.10/5.4] udf: fix null-ptr-deref if sb_getblk()
 fails
Message-ID: <2024112908-stillness-alive-c9d1@gregkh>
References: <20241129105846.4698-1-acsjakub@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129105846.4698-1-acsjakub@amazon.com>

On Fri, Nov 29, 2024 at 10:58:46AM +0000, Jakub Acs wrote:
> commit 32f123a3f342 ("udf: Fold udf_getblk() into udf_bread()"), fixes a
> null-ptr-deref bug as a side effect. Backport the null-ptr-deref fixing
> aspect of the aforementioned commit.

Please backport the whole thing.

thanks,

greg k-h

