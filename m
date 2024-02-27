Return-Path: <stable+bounces-23846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C98868B4F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9FC1F26680
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37B4131748;
	Tue, 27 Feb 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V/pYRzbS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62299130E36
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024043; cv=none; b=cY0E6QPatjXIeyU4cZn8iDfVznyMFgZ40Ko0evlVo8fSzL5AXfHOFppEuB0bXLXRtKQ7DnYs9kKmMs+67r273EnSd3A7Sh9ksQ95gcxcXE/ZbRyEpBYN/K9qc3+aGpRb4dW2iWmVL8aray/hHA6xyGOz0JXzv/XV062ZxjM171M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024043; c=relaxed/simple;
	bh=TJzjCuznkFCUAn6bJt8P/l9QhPoFM6t8PZIEXOBxT64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK35MLfXmWzw1q2ErrXVpimhkDsuLj8CwNfEpm1gfl3H9XWptFdw8uIL9DuAuonpv8m+GvKOJ6J4eebHIxwHVuovamiPrXmPeVn95V8/3YO71iNKAibYapVT6FI8JvEoBjHw4IRJK1y5EskMgrmWYZK0AIoCKbGnBxDu7aXj8yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V/pYRzbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D79DC433C7;
	Tue, 27 Feb 2024 08:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024043;
	bh=TJzjCuznkFCUAn6bJt8P/l9QhPoFM6t8PZIEXOBxT64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/pYRzbSH9Pdg/QmEM+Gtrs3g2yj1pcVAikNAby9zhrrrvIKgCOSQUmzUEo6PTMaA
	 bIBlkVi3bLrJ9QF4Mu2vnbFKFoRm+m7PdxNSxeqZYfJBLDDiLrDAmiR4xd3jAGyX9a
	 ED9PkgsPSfoZasvqSJQB0gNBhyyLHgyekLvXvxw0=
Date: Tue, 27 Feb 2024 09:54:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 6.6.y 0/6] Delay VERW - 6.6.y backport
Message-ID: <2024022740-smugness-cone-e80c@gregkh>
References: <20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-delay-verw-backport-6-6-y-v1-0-aa17b2922725@linux.intel.com>

On Mon, Feb 26, 2024 at 09:34:14PM -0800, Pawan Gupta wrote:
> This is the backport of recently upstreamed series that moves VERW
> execution to a later point in exit-to-user path. This is needed because
> in some cases it may be possible for data accessed after VERW executions
> may end into MDS affected CPU buffers. Moving VERW closer to ring
> transition reduces the attack surface.
> 
> Patch 1/6 includes a minor fix that is queued for upstream:
> https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/

Obviously I can't take this, you know that :(

Please include the actual commit in the series, when it hits Linus's
tree.

I'm dropping all of these backports from my review queue, please resend
the fixed up series when they are ready.

thanks,

greg k-h

