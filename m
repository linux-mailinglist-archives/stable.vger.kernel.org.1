Return-Path: <stable+bounces-180537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E9B85324
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3AD562759
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334303128CE;
	Thu, 18 Sep 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FhpXnzrZ"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730D3126D2;
	Thu, 18 Sep 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204607; cv=none; b=dNa8VtONcrvNNZUjfvoPX25IBbOFQY9jemvgVeSF2VDD7h3V8wGLArjd7NyRzxWFX8uYJJNPVqrQ1onByb//f+F+Re+jfqjNgM5Krm2FdKXFOeOrYP+0O+1F0mkoLRFJVRvKDLX0kTzjchkxhQOk1l3iMjZw2eZtUYsJ5zNf+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204607; c=relaxed/simple;
	bh=nFHi54wCET7igQC5KRhNHkJ7aBYvqs3E5kPuCORPpoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jA3ncoCfzUtWuKl53/JmdlaQlERYjMIIxD9pIX0DifbHRsIMPBUrs9MLKgVFL7upfa6u/gNZYQWxHr19VV8UjD3ZipyVusP9IsA1cz21fG1CgOUXtyBZMaIX1gQv1DvjibdRFO3wt15ftAU70g12XxXsMqCp2tM2UWrPAnP9LXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FhpXnzrZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FFLORDihYCicM5VZt7vNB80L4AErinlH5+UxIfqQxVw=; b=FhpXnzrZcb6mjDFRd2NdWQ823k
	R1B/DN7Ol8sQnnusRoRVLVERXTDVPwq1oVqpGj/rKM/9/Z6+AG7R2cKBc/su7lPAwG4hsTsFPsI7e
	yUg2SmC1Fb4dXcWWQwxNoOuGivGonRXsPgGFp6WWOJjmVD3NUrCfzObSrDiF1HqBRLgs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzFKa-008pbw-Bz; Thu, 18 Sep 2025 16:09:52 +0200
Date: Thu, 18 Sep 2025 16:09:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: marvell: cn9132-clearfog: fix
 multi-lane pci x2 and x4 ports
Message-ID: <dedd4222-b2ba-4247-98b4-504b5c032f69@lunn.ch>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
 <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>
 <9272b233-b710-4e57-b3ff-735f45c03c74@lunn.ch>
 <dbb10e82-ae10-4987-900b-17d4f4b62099@solid-run.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb10e82-ae10-4987-900b-17d4f4b62099@solid-run.com>

On Thu, Sep 18, 2025 at 10:46:03AM +0000, Josua Mayer wrote:
> Am 12.09.25 um 00:12 schrieb Andrew Lunn:
> > On Thu, Sep 11, 2025 at 08:28:06PM +0200, Josua Mayer wrote:
> >> The mvebu-comphy driver does not currently know how to pass correct
> >> lane-count to ATF while configuring the serdes lanes.
> >>
> >> This causes the system to hard reset during reconfiguration, if a pci
> >> card is present and has established a link during bootloader.
> >>
> >> Remove the comphy handles from the respective pci nodes to avoid runtime
> >> reconfiguration, relying solely on bootloader configuration - while
> >> avoiding the hard reset.
> >>
> >> When bootloader has configured the lanes correctly, the pci ports are
> >> functional under Linux.
> > Does this require a specific bootloader? Can i use mainline grub or
> > bareboot?
> 
> In this case it means U-Boot, i.e. before one would start grub.
> 
> I am never quite sure if in this situation I should say "firmware" instead ...

What you failed to answer is my question about 'mainline'? Do i need a
specific vendor u-boot, or can i just use mainline u-boot, or mainline
bareboot.

I personally like to replace the bootloader, because the one shipped
with the board often has useful features disabled, or is old. If i do
that, will the board work? I would much prefer the kernel makes no
assumptions about the bootloader. You said:

> The mvebu-comphy driver does not currently know how to pass correct
> lane-count to ATF while configuring the serdes lanes.

Why not just teach mvebu-comphy to pass the correct line-count? That
sounds like the proper fix, and that makes the kernel independent of
the bootloader.

	Andrew

