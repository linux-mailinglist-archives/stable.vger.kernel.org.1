Return-Path: <stable+bounces-163013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB9B0655E
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 19:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46DD417AC72
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC996286D78;
	Tue, 15 Jul 2025 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BlGOyJry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712A5248F60;
	Tue, 15 Jul 2025 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601733; cv=none; b=ei/gK1y/lcUtuhCPMFpAkdppAREWSir6+mRtnCkIM8R9rJVY/aqNG64n/uFsFyAmHI3aFRMiXZYYjyKxQ4qpW38em/G8pkBaYiUIEeQ4Ow3pbHB483SXi1TwT0omnSqtz5C44OV84UN2oYMZ3zqualwd019xEfBM0Avg3V6HQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601733; c=relaxed/simple;
	bh=wdfyaBEFuI+Se186ARLt/uqIgP2VA5aMHlBe67qs7ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktrvrwaHPAaa/LoSYJMrVJiHq7Wp/QX729YRAYpqEpKZZtqhuzmnXyS8jedJPP5j5wvOlKRNMUEI6V8azbTHC8oBMo/03tYjQfyVR8ZYftf1YLjm5RGSPudgi4S8q+vff1k+wkRLGTD80OGRbuSezbHm/5S3nh0+q6psFApeZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BlGOyJry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2196C4CEE3;
	Tue, 15 Jul 2025 17:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752601733;
	bh=wdfyaBEFuI+Se186ARLt/uqIgP2VA5aMHlBe67qs7ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BlGOyJryrZDa4TqzMz/pCGDPzzGbQGVtHd5Ui64X4fTk49zFcMrgdclLLP7S5OqYj
	 86SH3pyTEK4PCvTpc4YSBAKOnEk5SDKcPr0s9gWHfcz/tQfzvLHSq4G8TzAV3Z3ScB
	 1aDAo8YJxjdhAfqEArm6QBPcaTmmUZXqpDaL+KCk=
Date: Tue, 15 Jul 2025 19:48:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
	stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Subject: Re: [PATCH] usb: hub: Don't try to recover devices lost during warm
 reset.
Message-ID: <2025071527-vendor-rockfish-ef19@gregkh>
References: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250623133947.3144608-1-mathias.nyman@linux.intel.com>

On Mon, Jun 23, 2025 at 04:39:47PM +0300, Mathias Nyman wrote:
> Hub driver warm-resets ports in SS.Inactive or Compliance mode to
> recover a possible connected device. The port reset code correctly
> detects if a connection is lost during reset, but hub driver
> port_event() fails to take this into account in some cases.
> port_event() ends up using stale values and assumes there is a
> connected device, and will try all means to recover it, including
> power-cycling the port.
> 
> Details:
> This case was triggered when xHC host was suspended with DbC (Debug
> Capability) enabled and connected. DbC turns one xHC port into a simple
> usb debug device, allowing debugging a system with an A-to-A USB debug
> cable.
> 
> xhci DbC code disables DbC when xHC is system suspended to D3, and
> enables it back during resume.
> We essentially end up with two hosts connected to each other during
> suspend, and, for a short while during resume, until DbC is enabled back.
> The suspended xHC host notices some activity on the roothub port, but
> can't train the link due to being suspended, so xHC hardware sets a CAS
> (Cold Attach Status) flag for this port to inform xhci host driver that
> the port needs to be warm reset once xHC resumes.
> 
> CAS is xHCI specific, and not part of USB specification, so xhci driver
> tells usb core that the port has a connection and link is in compliance
> mode. Recovery from complinace mode is similar to CAS recovery.
> 
> xhci CAS driver support that fakes a compliance mode connection was added
> in commit 8bea2bd37df0 ("usb: Add support for root hub port status CAS")
> 
> Once xHCI resumes and DbC is enabled back, all activity on the xHC
> roothub host side port disappears. The hub driver will anyway think
> port has a connection and link is in compliance mode, and hub driver
> will try to recover it.
> 
> The port power-cycle during recovery seems to cause issues to the active
> DbC connection.
> 
> Fix this by clearing connect_change flag if hub_port_reset() returns
> -ENOTCONN, thus avoiding the whole unnecessary port recovery and
> initialization attempt.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8bea2bd37df0 ("usb: Add support for root hub port status CAS")
> Tested-by: Łukasz Bartosik <ukaszb@chromium.org>
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---
>  drivers/usb/core/hub.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Alan, any objection to this?

thanks,

greg k-h

