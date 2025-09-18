Return-Path: <stable+bounces-180554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCECB85BAC
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 17:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8B53AE7E9
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E1631159B;
	Thu, 18 Sep 2025 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hDSt9EL/"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0730CD90;
	Thu, 18 Sep 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210112; cv=none; b=cimTShEXCAIm0XDAhaiPo7anNn5gM0SJg9qEM+9y9WILxT35Gk6WoBIyVMwFy3iL1stBPnRdwk97xw0IukKXERZIxFa8lnI0jeGzhCjSGja0QgrN3kPGMIADs3Pr0LJQpzltNuqefnYONu2nUFC7ekWeyx4bOQm7s1We8zxvIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210112; c=relaxed/simple;
	bh=9HZieDAQu8syY8Gux1G9BaTofwg9LvmsPGucXhikUUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwVb2C9YURM4AhBI3W0DIBd4QgQpSnbyZlmWhnhoRr3JT5kNNheh3cwuFi4Pj/a8qtXTPcr4HHpxT2SzXu+1coUhlZ8E0Mo+oqGpNU1kzljRJQQynmAR+eUo11iy2KDTMgYZ8jfz+cP3fH/vVlBrQDoPv3MsFOI9rIGs7DGABQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hDSt9EL/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=c8rhx9sLUwe7GJ//MVfib66PmIFyPDMc5Lp9jdquzjs=; b=hDSt9EL/Z8uINZFYoPQPSYiXRR
	+Am5vfBof0zN3CeKZY8cqXMJArisUz9QeKqGE+wfriBlxiLAtQ/fnI4XxNWu2cX//OjWczw0GDCoP
	qADylRn8F6Z4YnvtIcT4xTrADIxKxJg06Pqi5nVDDYfN/5g4kydC3kBiHrcJ+3hiF3ec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uzGlT-008qVe-BO; Thu, 18 Sep 2025 17:41:43 +0200
Date: Thu, 18 Sep 2025 17:41:43 +0200
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
Message-ID: <2589d2df-8482-4648-b63c-5a4a86f01fbb@lunn.ch>
References: <20250911-cn913x-sr-fix-sata-v2-0-0d79319105f8@solid-run.com>
 <20250911-cn913x-sr-fix-sata-v2-3-0d79319105f8@solid-run.com>
 <9272b233-b710-4e57-b3ff-735f45c03c74@lunn.ch>
 <dbb10e82-ae10-4987-900b-17d4f4b62099@solid-run.com>
 <dedd4222-b2ba-4247-98b4-504b5c032f69@lunn.ch>
 <eab0cc63-de1b-4b41-bcce-7a2308d4f446@solid-run.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab0cc63-de1b-4b41-bcce-7a2308d4f446@solid-run.com>

> >> The mvebu-comphy driver does not currently know how to pass correct
> >> lane-count to ATF while configuring the serdes lanes.
> > Why not just teach mvebu-comphy to pass the correct line-count? That
> > sounds like the proper fix, and that makes the kernel independent of
> > the bootloader.

> That would be a feature on the comphy driver, not a bug-fix backported
> to stable. The core goal was to fix bugs found in Debian 13.

It is not so simple.

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

  It must either fix a real bug that bothers people or just add a device ID

Crashing at boot would be a real bug that bothers people, not just a
new feature.

Lets see how big the patch is. If its 1000 lines of hard to understand
code, it will probably be rejected for stable. If its 100 lines or
less, it will likely be accepted.

It is also hard to argue the DT is wrong. It just describes the
hardware. I assume the description is actually correct? The issue is
the driver, not the description. Also, i assume this affects all
boards using this SoC? Removing the nodes in one board 'fixes' one
board. Fixing the driver fixes all boards...

    Andrew

