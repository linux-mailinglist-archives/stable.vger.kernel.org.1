Return-Path: <stable+bounces-208446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF98AD25221
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2203530C4557
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843F93A1D0B;
	Thu, 15 Jan 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b9LTaB+6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C773A1A5B
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488859; cv=none; b=NSbUEgdTGJFziwimrVX3oN7reAHPrbOwlvDolxD/YI9tvtb8Z0DRxbmozUVi5B41YguiuFSSOjCa1NTf9BEVwU5+ku3OYQWnwlTn/XKK5RAiNJWFnJDbLHIz9NPzd6P5l2uVYzYNyUmE6j3Q8lUtRsJ4cdq3XpejuW+LmuszFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488859; c=relaxed/simple;
	bh=eGX1uIRNiVRKNpnEQWr8+h6ChiHJM3AhnFKihXO9glk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1IQsXZG/+JYmelhKR5JkflO1UQ2rYuBMLEs8yxf8VPo71gVT7+k4uA5KRWzpeAKelyum4gG1PFpt/04mpNqzFzMh0X5ThmqfmJu0yctjwRAoZo4gkwpaEPJ2pYxswMdsLQ6Qt6AwpDHdsX3EWxZB/t4W98waPq0C/x8B//mGXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b9LTaB+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7E1C116D0;
	Thu, 15 Jan 2026 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768488858;
	bh=eGX1uIRNiVRKNpnEQWr8+h6ChiHJM3AhnFKihXO9glk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9LTaB+6r/7k8EKDOi1pwgm0veGkJiuWN8LB/wZXURid5/s/OOhZUk+GWmvxMSxce
	 A+fopu9qWO0EGrCmQldwhkXS/9g7clJXTFjY1GYdszDUZgVlP3eVn1xJIjjVLx87Pu
	 3OLGCVLmirlgqlxsDlHseui2Y5fedl4g8eqFOdHE=
Date: Thu, 15 Jan 2026 15:54:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org, lujialin4@huawei.com
Subject: Re: [PATCH stable] cpuset: Fix missing adaptation for
 cpuset_is_populated
Message-ID: <2026011510-untouched-widen-8f33@gregkh>
References: <2026011258-raving-unlovable-5059@gregkh>
 <20260114015129.1156361-1-chenridong@huaweicloud.com>
 <bb71a754-ed2e-4535-aa20-c8d0a9ec4be1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb71a754-ed2e-4535-aa20-c8d0a9ec4be1@huaweicloud.com>

On Wed, Jan 14, 2026 at 10:13:16AM +0800, Chen Ridong wrote:
> 
> 
> On 2026/1/14 9:51, Chen Ridong wrote:
> > From: Chen Ridong <chenridong@huawei.com>
> > 
> > Commit b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
> > was backported to the long‑term support (LTS) branches. However, because
> > commit d5cf4d34a333 ("cgroup/cpuset: Don't track # of local child
> > partitions") was not backported, a corresponding adaptation to the
> > backported code is still required.
> > 
> > To ensure correct behavior, replace cgroup_is_populated with
> > cpuset_is_populated in the partition_is_populated function.
> > 
> > Cc: stable@vger.kernel.org	# 6.1+
> > Fixes: b1bcaed1e39a ("cpuset: Treat cpusets in attaching as populated")
> > Signed-off-by: Chen Ridong <chenridong@huawei.com>
> > ---
> >  kernel/cgroup/cpuset.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index f61dde0497f3..3c466e742751 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -486,7 +486,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
> >  	    cs->attach_in_progress)
> >  		return true;
> >  	if (!excluded_child && !cs->nr_subparts_cpus)
> > -		return cgroup_is_populated(cs->css.cgroup);
> > +		return cpuset_is_populated(cs);
> >  
> >  	rcu_read_lock();
> >  	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
> 
> Hi Greg,
> 
> Is this patch suitable for applying?

It needs approval from the maintainers of this file.

> Note:  Because the corresponding commit varies between LTS branches,, the Fixes tag points to a
> mainline commit.

As this is only for 6.1.y, why not point it at the commit there?

Or is this for other branches?  If so, which ones?  It might be best to
provide a backport for all of the relevant ones so that we get it right.

thanks,

greg k-h

