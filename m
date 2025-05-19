Return-Path: <stable+bounces-144874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97440ABC18C
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 17:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1A53A4986
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9917628466A;
	Mon, 19 May 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cbvsoKzI"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658EBE5E;
	Mon, 19 May 2025 15:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747666883; cv=none; b=Ow52etk6tUxpo6vGCd6xq98SPJVHz/ZWCVd1DwiJXgDI9QdSLXR7X8zInD0ZdW0DnqpeFWYm/HBNxMDKl0fLLyONpTzni9qrFCfgsARYHp8N5iKDB9mFO9LjF++yO3qKEpZuvSog7i+VDRxKkMxv9JplLS8egb4zNZTAYLUM/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747666883; c=relaxed/simple;
	bh=SP+3uwUr1dUqOoOJChhGpSJSREZe1bvlmtKjcOsOu9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkU7Hxm9M1nb2FG+yX4G3S0+DZJ9x3de7LuUAiZw8fX50SDY+Z7ybR7gu8aoTIckOuRmcvkzKSvPO9Bzt/nwVmB3ZuWEAmo9+f+feSm3TWYH+XcWDuJQXyrXwA7ix6E27qAfz0GknZ0ZvEFm/Z1B8fiG+rfupj/XZWp4T409R1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cbvsoKzI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D+WlcLSTHUk7L2L0T5ZmVak0RKGML7Ka2WOYeq1OccI=; b=cbvsoKzIvnU/T53Bdebc0qBAEJ
	zgHYXgAtOn+jHwiFDrxux21nNS29sR5FIMUxb3QY6Vz0Yx8omQhDFrfTpvaW6CSNVD4m7RqV+VfOX
	+LRaLWnzTdLue3Gx+CM/m7X01wDSizLhT+m4q90L6JnJDCoa1ccT+my36cBJ9SiubiwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uH1zL-00D1pn-Jy; Mon, 19 May 2025 17:01:11 +0200
Date: Mon, 19 May 2025 17:01:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: chalianis1@gmail.com
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] phy: dp83869: fix interrupts issue when using with
 an optical fiber sfp. to correctly clear the interrupts both status
 registers must be read.
Message-ID: <97d0e167-ef11-4cbf-a473-fb823d7b727a@lunn.ch>
References: <20250519144701.92264-1-chalianis1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519144701.92264-1-chalianis1@gmail.com>

On Mon, May 19, 2025 at 10:47:01AM -0400, chalianis1@gmail.com wrote:
> From: Anis Chali <chalianis1@gmail.com>
> 
> from datasheet of dp83869hm
> 7.3.6 Interrupt
> The DP83869HM can be configured to generate an interrupt when changes of internal status occur. The interrupt
> allows a MAC to act upon the status in the PHY without polling the PHY registers. The interrupt source can be
> selected through the interrupt registers, MICR (12h) and FIBER_INT_EN (C18h). The interrupt status can be
> read from ISR (13h) and FIBER_INT_STTS (C19h) registers. Some interrupts are enabled by default and can
> be disabled through register access. Both the interrupt status registers must be read in order to clear pending
> interrupts. Until the pending interrupts are cleared, new interrupts may not be routed to the interrupt pin.
> Fixes: interrupts issue when using with an optical fiber sfp.

The subject is now correct, but the Fixes: tag is supposed to be a git
hash for when the problem was introduced:

https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

    Andrew

---
pw-bot: cr


