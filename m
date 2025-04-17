Return-Path: <stable+bounces-132919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC5A91579
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD90189C7FF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66225219A76;
	Thu, 17 Apr 2025 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bbaGGhP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04821A431
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875708; cv=none; b=mKXJBXjCpqEKOCsXFTZdG52WdgCncLyU4v6NLB576eg7LbzIAdyhyGgIl/FUv+ghqc5SU7dbqqNN/YQnHqvLNoBVPOX7GX4Oe2/sh74XZUxi6+ywnBkca4L6nYmES0+U5BTuciPNdNhpVh3Dfo/5tPC1WAIuRMBFBDpLhea1O/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875708; c=relaxed/simple;
	bh=Q6A0u6FeDvRD2mlvxjJPAK+Arehk54je3JcKYA7FBHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5nlOtV0u/jfM05n/nFEUHyWfr+JIHhpxlRnyxgOmPUKg9/4g08BkgEOMpxQp62PlRpuHK6dzn8tMgTgrIrJXRMHwt/7cpmSV/T1g0mTB8xcCJIZN+aN9IiG/FCfsb7hedM82TZOtvH8dmbd+qvl7pk/9q/Fkis34FOKcZfRYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bbaGGhP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A24C4CEEE;
	Thu, 17 Apr 2025 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744875707;
	bh=Q6A0u6FeDvRD2mlvxjJPAK+Arehk54je3JcKYA7FBHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbaGGhP3KZpY2I/aofAnbsP5E/+zhRPJPEWKjRcnahe3xfZHqDOZgPZjWpkUUJ6CL
	 obf0YwsA1NdkieNEiqVfLCqIP2LEltn0hxnJ9TU1s1l5NNFH5VFgzsFL9Hr7krWYVz
	 1XcVu8bhN6a8cR/UTg1JiDlYNBeltlrepxCsYwQM=
Date: Thu, 17 Apr 2025 09:41:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cliff Liu <donghua.liu@windriver.com>
Cc: huangchenghai2@huawei.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, stable@vger.kernel.org,
	"He, Zhe" <Zhe.He@eng.windriver.com>,
	"Bi, Peng (CN)" <peng.bi.cn@windriver.com>
Subject: Re: Question about back-porting '8be091338971 crypto:
 hisilicon/debugfs - Fix debugfs uninit process issue'
Message-ID: <2025041739-armoire-dimmer-4670@gregkh>
References: <767571bc-1a59-4f7c-a9c7-fb23b79303a9@windriver.com>
 <4725f8e8-7f46-48f6-9869-8bf16eca6f1a@windriver.com>
 <2025041727-crushable-unbend-6e6c@gregkh>
 <205d560b-be0e-4ee4-8293-e66023e481c0@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <205d560b-be0e-4ee4-8293-e66023e481c0@windriver.com>

On Thu, Apr 17, 2025 at 03:32:07PM +0800, Cliff Liu wrote:
> Hi Greg KH,
> 
> On 2025/4/17 15:13, Greg KH wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Thu, Apr 17, 2025 at 02:51:05PM +0800, Cliff Liu wrote:
> > > Hi,
> > > 
> > > I think this patch is not applicable for 5.15 and 5.10.
> > Then why are you trying to apply it there?  Do you have the bug that is
> > being reported here on those kernel versions?  If not, why is this an
> > issue?  If so, find the files that are affected in those releases and
> > apply the change there.
> 
> It is reported by NVD that it is CVE-2024-42147 vulnerable and this patch
> fix it in v6.10.
> 
> So I want to back-port the patch to 5.15 and 5.10. I didn't make it clear.
> So sorry for that.
> 
> I just want to get more help or information to confirm if it is applicable
> to 5.15 and 5.10.

Do the research to see if this is even applicable to those older kernels
first.  Many times the ranges are wrong, or missing, because the
commit that fixed the issue did not have that information.

CVE fix ranges are a "best effort" so they will be wrong at times.  It's
up to you to do the work to validate the range if you care about that
specific commit.  If it is wrong, submit a patch to the vulns.git repo
to update the range information, like many people have been doing over
the past year, to fix these ranges where they were wrong.

Also, don't use NVD, use the raw CVE records.  NVD has a "value add"
that everyone has realized does not really mean anything.  We have no
control over what they do, please use the real CVE record instead.

thanks,

greg k-h

