Return-Path: <stable+bounces-196829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E645C82EF7
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 01:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69C324E2648
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25951E51EE;
	Tue, 25 Nov 2025 00:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="L17Nb8Mh"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341513EA8D;
	Tue, 25 Nov 2025 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030585; cv=none; b=doWSCMXAjpOAoCLWKN6ROkrHU2OfaT0Vga/aDsOgkMfIEWSJGd+M8OmRqvH2wpnqBT5bfuX3XmYzITa0FoLkwYbSxuHGRZTTsiZBznEzcFQaUb+o5KgtapUcBTaZtaon6wUM/3IPbR4PboRQlrWcf55Gbba1EWLCJ01id6T/fhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030585; c=relaxed/simple;
	bh=C2HlEMsvyQMCnybCB7SaC+I40kgvVfnrxFOIhwRCxoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suQJP3eXP4CbfPcHztufyZeoI0Kuaj/+q0dk7CY1v9uR8Xb1dpDSHqOURoU9AgtxZ62k87RTII4Fw/lakWC2aByU6g9FNHir8Qycc433cQI6yeQLrr16xeBmT5r4WGDSjqDKe3a/rS8h/7Irl1TmrP3aLZHJRW5HgVRg2Q4IMKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=L17Nb8Mh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uyDn49yZ3JolAXWifLKxq5HAVN38ilksH6HBgYuR0nY=; b=L1
	7Nb8MhGnQygQto0HcUvmLyukrHQst/i8Nw41kohjxc5NkmgX+Ps3zuSnyHDoL8oGdBijaPzUW6+MQ
	zyexHb9Idk4+9y5ViEvxKCrtThwLOC9hT6cO9vu45b6mu9oDJYLsnqoXlC2wroPgG3xN/DVu4ZfZ6
	VNtVlalW78OMa5c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vNgw1-00ExbS-H6; Tue, 25 Nov 2025 01:29:33 +0100
Date: Tue, 25 Nov 2025 01:29:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: yongxin.liu@windriver.com, LKML <linux-kernel@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, david.e.box@linux.intel.com,
	chao.qin@intel.com, yong.liang.choong@linux.intel.com,
	kuba@kernel.org, platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] platform/x86: intel_pmc_ipc: fix ACPI buffer memory
 leak
Message-ID: <72fcaebe-afb6-49ef-a6fd-69aa0f8c7a39@lunn.ch>
References: <20251124075748.3028295-1-yongxin.liu@windriver.com>
 <f1124090-a8e4-6220-093a-47c449c98436@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1124090-a8e4-6220-093a-47c449c98436@linux.intel.com>

> Good catch but this fix doesn't address all possible paths. So please use 
> cleanup.h instead:
> 
> 	union acpi_object *obj __free(kfree) = buffer.pointer;
> 
> And don't forget to add the #include.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

  1.6.5. Using device-managed and cleanup.h constructs¶

  Low level cleanup constructs (such as __free()) can be used when
  building APIs and helpers, especially scoped iterators. However,
  direct use of __free() within networking core and drivers is
  discouraged. Similar guidance applies to declaring variables
  mid-function.

    Andrew

---
pw-bot: cr

