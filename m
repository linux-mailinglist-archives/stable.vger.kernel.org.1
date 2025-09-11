Return-Path: <stable+bounces-179312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CEB53E90
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 00:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57C57BD58F
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 22:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277134AAEE;
	Thu, 11 Sep 2025 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RUSWSziV"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF38C342C9D;
	Thu, 11 Sep 2025 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628781; cv=none; b=qb2qWdlQowmpcjMyJdTcokX/Btns8lE09ZII2e3J82NRW4OxwCI65qPu0mdLOl+1WfKIC+2sJrLryCCt6bK9KAjCYZTP8uhuI3fMIm2+g0rWUQvbSoNHOVpH1dMr1PVdCTuAV3RfkGPwXd3IImN/SC7choRQIMgtwI1Nqwg7o4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628781; c=relaxed/simple;
	bh=8qAW7k+pdxj330R+9BUzLfefS6+eHgrjIwHtht4fASY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUMK5KIthjZ5Mm/e4CxunImaOagY2Jj3hkHd9d8z96n3/CW271fBpw0qE9arUY6cyezgLP5ErE+kYY4H/PKL4MG/+SMnZ9X387o7Der8B462LskygHtZ4e6ZYCcy0c/Rkv2dLj+TCy2jxek0tiWoYuOAdQmtwLxFwl2e0Dyldzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RUSWSziV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k38r4YA5840dqQerOX6ASJvj7ltULIdsb+/xx7kZDp4=; b=RUSWSziVQseGJ3SzEMC5DuSIof
	xSJSdXq3E10/hf6iFm61jJPQi3jJswsp5oxz3zVxrfjSr1J+Fj4l0qv7VTcMtkWc3f4O/Crfd6iS1
	Hf7hA9A83Kwc+SfQwLkSz19rrepirv6/5Kt8JLN/PLhz6IcJge/qJUMMLi3dNf6wkFxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwpX6-0088t2-RU; Fri, 12 Sep 2025 00:12:48 +0200
Date: Fri, 12 Sep 2025 00:12:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: dts: marvell: cn9132-clearfog: fix
 multi-lane pci x2 and x4 ports
Message-ID: <9272b233-b710-4e57-b3ff-735f45c03c74@lunn.ch>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
 <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>

On Thu, Sep 11, 2025 at 08:28:06PM +0200, Josua Mayer wrote:
> The mvebu-comphy driver does not currently know how to pass correct
> lane-count to ATF while configuring the serdes lanes.
> 
> This causes the system to hard reset during reconfiguration, if a pci
> card is present and has established a link during bootloader.
> 
> Remove the comphy handles from the respective pci nodes to avoid runtime
> reconfiguration, relying solely on bootloader configuration - while
> avoiding the hard reset.
> 
> When bootloader has configured the lanes correctly, the pci ports are
> functional under Linux.

Does this require a specific bootloader? Can i use mainline grub or
bareboot?

	Andrew

