Return-Path: <stable+bounces-164832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D2BB12B18
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 17:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F385A17DCE4
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C591286416;
	Sat, 26 Jul 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jobxrcTD"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD91172A;
	Sat, 26 Jul 2025 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753542869; cv=none; b=UycLx2F0wEYtH7L11i7ePM7/4FZFZrTycIExF9Qd2+Fem21AYaFg/SM2F08fRAXdpg/uhxnN3X9amxM6W+8A8zpC2ryAJ5ap5guiZe/I33ITlfriyqLf2qhJ6VdBjIlvLtBsGeDVl4yPIJxs9L0DeumtaFZoljXAW0BLFDDIjys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753542869; c=relaxed/simple;
	bh=7KnVq0bpX4BK5qfmfAMjT2aCIkDDD4mrF0Ibni/E7Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9APrncLFg6GL8h8+9NXL7y0+XsMW9vWnsHhiqiOc1pf+nOFFqQCDvZT+UUoY/LE2rrRLeLulIiScI8j9qLhZOUqOHQUpOldkdmMVkUtp/qQ81/qyGSRwaKGhrdg1weVkKQfY54xnsIYZ3BDueXFqUA86C0oatnCisl3HX/kXgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jobxrcTD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w8iwmIA2XesTNWiyP/rI4G6f6kJKZhgchzLduz9POwc=; b=jobxrcTDtg1zw81Vr6earsEGTk
	NZ6uyHDKtntzhmO/SVlnESqxWc5z0QWm4sOZWzNbZRPM9VPQ7LM5xEPTrOBWMZNcbb35pcR7hazUL
	qjzBSre6ZCnVbWPEDAY2lF93WxFgnVmSMSRIUJEDBVc8j5sxgDopgwsmB/3wjb8bsgPE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ufgbM-002wwk-JM; Sat, 26 Jul 2025 17:14:20 +0200
Date: Sat, 26 Jul 2025 17:14:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: chalianis1@gmail.com
Cc: hkallweit1@gmail.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] phy: dp83869: fix interrupts issue when using with
 an optical fiber sfp. to correctly clear the interrupts both status
 registers must be read.
Message-ID: <33f056e7-6bf4-47be-aa8b-95640bf2151c@lunn.ch>
References: <20250726001034.28885-1-chalianis1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726001034.28885-1-chalianis1@gmail.com>

On Fri, Jul 25, 2025 at 08:10:34PM -0400, chalianis1@gmail.com wrote:
> From: Anis Chali <chalianis1@gmail.com>
> 
> from datasheet of dp83869hm
> 7.3.6 Interrupt
> The DP83869HM can be configured to generate an interrupt when changes of internal status occur. The interrupt
> allows a MAC to act upon the status in the PHY without polling the PHY registers. The interrupt source can be
> selected through the interrupt registers, MICR (12h) and FIBER_INT_EN (C18h). The interrupt status can be
> read from ISR (13h) and FIBER_INT_STTS (C19h) registers.

Reading this description, it sounds like the fibre interrupt it not
cascaded into the micr? There are two completely different sets of
registers.

So i seems like you should be reading this register in
dp83869_handle_interrupt() same as the MICR.

    Andrew

---
pw-bot: cr

