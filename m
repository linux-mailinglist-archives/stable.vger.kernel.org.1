Return-Path: <stable+bounces-169565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34013B26875
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A444BA27BA8
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D463301491;
	Thu, 14 Aug 2025 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sojiv3Us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB823009F0
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179822; cv=none; b=Pbj6eft5C9DeH0XDpTz1nOYLQoXpJnZa78NtUbdilUyeTTFvtndqsJ4MQUuEJIRUGpPd6aDqrxsJ8oLzPj1i6GWfGssJnHMcrSHeKq9WlewVlkmk+TQgjPkWD5ILN5X6SGLHrhP3NJCiCwzYUcreH5upWJbj0NUXHWDYV2gV464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179822; c=relaxed/simple;
	bh=Q7mbc3OIpQaPF8obJ8icgwvmlyAtL+TbGOLtiSQZ6es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A27F5EB3iqhZwhDwBLaEFC1Jf1k+lFg219uNbX8myCsFEh5pSd+hNyrKve7Q7bHw/6SNuCcjU6txJMrJGXJc+l3bSGTfRMI4OTriPG2Flt7DMeVwgX7M+ftIBNRIXSwGkNajS/7MdnQqCojLg8MQLNBYam/6mEinMtCx3r/GedA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sojiv3Us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F10AC4CEEF;
	Thu, 14 Aug 2025 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755179821;
	bh=Q7mbc3OIpQaPF8obJ8icgwvmlyAtL+TbGOLtiSQZ6es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sojiv3UsybtdunXpyA0Crttz/b1pWBG0WsE9lbXRXbLa9LCyn+5d5BrRFyAjTLPjw
	 2ktGP9YHMe450uLz1StN54N7defGdpcppvziO6onfFeQdJxq5jRP5EfqmdPEeWJobD
	 RSs6hrcrlcHYtGfeqQJewvrnIxTK0VHuvTSzvjAQ=
Date: Thu, 14 Aug 2025 15:56:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Gu Bowen <gubowen5@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	linux-mm@kvack.org, Waiman Long <llong@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	John Ogness <john.ogness@linutronix.de>,
	Lu Jialin <lujialin4@huawei.com>
Subject: Re: [PATCH v3] mm: Fix possible deadlock in console_trylock_spinning
Message-ID: <2025081450-tibia-angelfish-3aa2@gregkh>
References: <20250813085310.2260586-1-gubowen5@huawei.com>
 <20250813155616.d7e5a832ce7cda7764942d10@linux-foundation.org>
 <f3e631dc-245a-4efe-98e5-cbe94464daec@huawei.com>
 <aJ3f05Dqzx0OouJa@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ3f05Dqzx0OouJa@arm.com>

On Thu, Aug 14, 2025 at 02:08:35PM +0100, Catalin Marinas wrote:
> On Thu, Aug 14, 2025 at 10:33:56AM +0800, Gu Bowen wrote:
> > On 8/14/2025 6:56 AM, Andrew Morton wrote:
> > > I'm not sure which kernel version this was against, but kmemleak.c has
> > > changed quite a lot.
> > > 
> > > Could we please see a patch against a latest kernel version?  Linus
> > > mainline will suit.
> > > 
> > > Thanks.
> > 
> > I discovered this issue in kernel version 5.10. Afterwards, I reviewed the
> > code of the mainline version and found that this deadlock path no longer
> > exists due to the refactoring of console_lock in v6.2-rc1. For details on
> > the refactoring, you can refer to this link :
> > https://lore.kernel.org/all/20221116162152.193147-1-john.ogness@linutronix.de/.
> > Therefore, theoretically, this issue existed before the refactoring of
> > console_lock.
> 
> Oh, so you can no longer hit this issue with mainline. This wasn't
> mentioned (or I missed it) in the commit log.
> 
> So this would be a stable-only fix that does not have a correspondent
> upstream. Adding Greg for his opinion.

Why not take the upstream changes instead?

