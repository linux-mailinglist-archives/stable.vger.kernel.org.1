Return-Path: <stable+bounces-159131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E931AEF4AF
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 12:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B683B7AF5
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 10:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EC326CE12;
	Tue,  1 Jul 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fg/PIxLO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D94215191;
	Tue,  1 Jul 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364857; cv=none; b=vEP1eYgyMWoGv+psJduaJdsq75c+RMNVl+GiXuLVQJZBr5mxWzvnE5kV9XfHGcNI6eWI3zVM5VFQXnCP9JryzUA+emc3vAZ5+Gs1azzl3c2E6Kr8R7dmbrXRRmAmYEszztrB2ENXBsM2/3m6sUcyFtUCgsW+9IuzM2gHIjhQBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364857; c=relaxed/simple;
	bh=Wlx4TnlV2QM7/+quU7XTzCU416QeaJFHMjUHbSMNTag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBW4ZkMkSO/EdS40B2b0S4bWe7yd+gl+yQ+vb48eE5UcxVye2sury3oxZYHrKMr4kPE+cFP8b15N+tS0QVUOdmwR6k/F4t4UHWH03vC29bnM9KrIJxw0ekMgFF0Z70/X5OJ4SztzUcDmdZOd4Xcbgfou57GWVhu8twy5qnPNx1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fg/PIxLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F116C4CEEF;
	Tue,  1 Jul 2025 10:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751364856;
	bh=Wlx4TnlV2QM7/+quU7XTzCU416QeaJFHMjUHbSMNTag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fg/PIxLOrQBZU1J6+wD96e7RnK8h+Hoy0vkepORcngWD8z2e9ZWJTwzDAC+b6T0vI
	 BwbNLzZ1B6EExuyXnc4KKEtK/z5Eyd+5wSeG0iZnyFth5DXcX6fBjUSjMz1H7Q20j9
	 6FZJ5Ko9vTr5CEGhU5TtKGKTOvv9/3/2AN16LXPk=
Date: Tue, 1 Jul 2025 12:14:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: stable@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	Corey Minyard <cminyard@mvista.com>,
	openipmi-developer@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Corey Minyard <corey@minyard.net>
Subject: Re: [PATCH stable] ipmi:msghandler: Fix potential memory corruption
 in ipmi_create_user()
Message-ID: <2025070142-equation-unlighted-9720@gregkh>
References: <20250630-ipmi-fix-v1-1-2d496de3c856@google.com>
 <2025063054-abridge-conclude-3dad@gregkh>
 <DB0MKNAAHYVK.3V2BN2WP3C7ZI@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB0MKNAAHYVK.3V2BN2WP3C7ZI@google.com>

On Tue, Jul 01, 2025 at 09:52:55AM +0000, Brendan Jackman wrote:
> On Mon Jun 30, 2025 at 6:10 PM UTC, Greg KH wrote:
> > On Mon, Jun 30, 2025 at 05:09:02PM +0000, Brendan Jackman wrote:
> >> From: Dan Carpenter <dan.carpenter@linaro.org>
> >> 
> >> commit fa332f5dc6fc662ad7d3200048772c96b861cf6b upstream
> >> 
> >> The "intf" list iterator is an invalid pointer if the correct
> >> "intf->intf_num" is not found.  Calling atomic_dec(&intf->nr_users) on
> >> and invalid pointer will lead to memory corruption.
> >> 
> >> We don't really need to call atomic_dec() if we haven't called
> >> atomic_add_return() so update the if (intf->in_shutdown) path as well.
> >> 
> >> Fixes: 8e76741c3d8b ("ipmi: Add a limit on the number of users that may use IPMI")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> Message-ID: <aBjMZ8RYrOt6NOgi@stanley.mountain>
> >> Signed-off-by: Corey Minyard <corey@minyard.net>
> >> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> >> ---
> >> I have tested this in 6.12 with Google's platform drivers added to
> >> reproduce the bug.  The bug causes the panic notifier chain to get
> >> corrupted leading to a crash. With the fix this goes away.
> >> 
> >> Applies to 6.6 too but I haven't tested it there.
> >
> > So what kernels are you wanting this to be applied to?
> 
> Right, sorry for the ambiguity.  I've just applied the patch to 6.6 and
> booted QEMU and it worked fine.
> 
> I have not reproduced a crash in 6.6 but it's pretty clearly a real bug
> (it decrements the target of an uninitialized pointer).
> 
> So if you're OK with that then please apply to 6.6 and 6.12. Otherwise
> just 6.12 is fine, I will send another PATCH if I ever hit the issue for
> real in 6.6.

But why would we skip 6.15.y?  You can't apply patches to only older
stable kernels, as that would cause users to have regressions when they
move to newer ones. :(

greg k-h

> 

