Return-Path: <stable+bounces-87667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3904D9A9827
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675F11C214A4
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 05:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A98287D;
	Tue, 22 Oct 2024 05:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IdPRMJfM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A480C13
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729573979; cv=none; b=CXxPUggD0ad0hd93/b2KjCX9aWNDgB1K+9CA1Rn22jj5Tw3sAaVK5owECX1WPte314mkgz0R7oTD5ihHOryHjKdvxZtRS422XNlSbNn38unNhn4s5P8JP5W5xIpEZy4fAV+00Mbda4kL+lOuiX2e/ps3HsR9Oe8XGTjZqJzC1KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729573979; c=relaxed/simple;
	bh=WABslkWTKOj2J++q0/rbMP34AhQE0MCBB9aR1AvZJPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNzF4+A6BcNtQoKYAbC2LUKKp8BXguymMGfJfqTrIX8Ft9Rt78Zu3ad++b+f2MFHURel8N5vgfzb/x4W2lrPsJaSumMNtwzFEzoeDWVDpcR7T+L6UZHi1LzDr5d+zAM/HwvsYETxBu6CC8sB+7UdWC5yob6Cnlk4o+2+kyWIzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IdPRMJfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A6C4CEC3;
	Tue, 22 Oct 2024 05:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729573978;
	bh=WABslkWTKOj2J++q0/rbMP34AhQE0MCBB9aR1AvZJPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IdPRMJfMV0g7GXx+Ouh8QT0ROKyFwUG3Hx4ANgoSPpKX/2LmnrqUH2nHy6wrqP/n9
	 8k6fnvqKDbJ/KcXWT+mG9+aQoYouHIZPpbcd9hmPJe+1OPEmG1vqkgyBZlnPXjStAi
	 Gm5sQMwRAFZt0Vi4icz9NOCv7LO4Nm6vZosP/I8M=
Date: Tue, 22 Oct 2024 07:12:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Kochera <kochera@google.com>
Cc: stable@vger.kernel.org
Subject: Re: Backport Fix for CVE-2024-26800 to V5.15
Message-ID: <2024102211-stinger-unbaked-1a15@gregkh>
References: <CAN1hJ_PjnxgOmY0gxeHVcLYhjLbLsjNUHWfwbWwq2sXX2qwAwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN1hJ_PjnxgOmY0gxeHVcLYhjLbLsjNUHWfwbWwq2sXX2qwAwQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 05:35:26PM -0500, Michael Kochera wrote:
> Hello, I wanted to check on the backport of the fix for CVE-2024-26800
> on the 5.15 kernel.
> 
> Here is the commit fixing the issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=13114dc5543069f7b97991e3b79937b6da05f5b0
> and as you can see the commit it says it fixes was backported to 5.15
> to fix a different CVE but this one wasn't as far as I can tell.

As that commit does not apply cleanly to the 5.15.y tree, it was not
automatically applied.  If you wish to see it there, please provide a
working and tested backport and we will be glad to include it.

thanks,

greg k-h

