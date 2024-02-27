Return-Path: <stable+bounces-23857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418B4868B7A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F47DB22A1A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23BB135A65;
	Tue, 27 Feb 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="piV71Koz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EBD135A45
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024479; cv=none; b=Dl2lgd5ngmjnhmobQLjmMT5y+d5Gaunb7KJnP+GEAFrQrtlw1AwNGU1skC9mX38dtxGiU7HJemT80B1q2p4no8Y17YKljIsdHvsErJMxnulivWpFkwVP+euHcpsfQxpT7yuODVLSmKjcZzeFLyc7siQcr8kKTALJQ/SIT9YhWqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024479; c=relaxed/simple;
	bh=e4evP+kTDRRMTPAppvC8fe+bdikCQkLyNSK8BGzLPIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzxeRT/ss3K/iLL2B9exa46+tBdRplJru6NXP0kiVjDiYV5Xw1MhMAn/iQPfwd/4ZHHELhHYdRDwdgqBmu/qAwi0fb1dxsRh6D0Du1ezBODnEK1UrwPXVftZ9BMADwT40YeIwXAk9Pd1/iAyOe2gZZLuYjLKmsGaFXwxVTRp2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=piV71Koz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B278AC43390;
	Tue, 27 Feb 2024 09:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024479;
	bh=e4evP+kTDRRMTPAppvC8fe+bdikCQkLyNSK8BGzLPIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=piV71KozEqzQvVwlUfCDjodAyJofEw2WxVG2JkH0QXhL58GDA6we5UJVB7Q59MLw5
	 UUm/+854GxKJp0/aQu2pP/jylzGJZ/7LHpqpiROeALrM+QGjk3hz2iHmc7qRnjGeSg
	 bbqvaUabBMBbrWzCwNVQMjHRescQnBQw8zhFW9M4=
Date: Tue, 27 Feb 2024 10:01:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: vidyas@nvidia.com, sdonthineni@nvidia.com, stable@vger.kernel.org
Subject: Re: [PATCH linux-4.19.y] PCI/MSI: Prevent MSI hardware interrupt
 number truncation
Message-ID: <2024022759-slacker-diary-3962@gregkh>
References: <2024022609-womanless-imprison-678c@gregkh>
 <8734tfb73h.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734tfb73h.ffs@tglx>

On Mon, Feb 26, 2024 at 04:03:46PM +0100, Thomas Gleixner wrote:
> 
> From: Vidya Sagar <vidyas@nvidia.com>
> 
> Commit db744ddd59be798c2627efbfc71f707f5a935a40 upstream.
> 
> While calculating the hardware interrupt number for a MSI interrupt, the
> higher bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI
> domain number gets truncated because of the shifted value casting to return
> type of pci_domain_nr() which is 'int'. This for example is resulting in
> same hardware interrupt number for devices 0019:00:00.0 and 0039:00:00.0.
> 
> To address this cast the PCI domain number to 'irq_hw_number_t' before left
> shifting it to calculate the hardware interrupt number.
> 
> Please note that this fixes the issue only on 64-bit systems and doesn't
> change the behavior for 32-bit systems i.e. the 32-bit systems continue to
> have the issue. Since the issue surfaces only if there are too many PCIe
> controllers in the system which usually is the case in modern server
> systems and they don't tend to run 32-bit kernels.
> 
> Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy irqdomain")
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [ tglx: Backport to linux-4.19.y ]

Didn't apply there, are you sure this was correct?

Anyway, I fixed it up by hand...

thanks,

greg k-h

