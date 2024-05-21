Return-Path: <stable+bounces-45473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1118CA794
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 07:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE0DB223BD
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 05:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6430256A;
	Tue, 21 May 2024 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzrO7glz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E731BF31;
	Tue, 21 May 2024 05:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716268531; cv=none; b=n+zWvu0XYtYaAsLj/hjyt+Fh3zvbqQ7Ev8YnoL+pWHvcTR8FgWigpeg7qP7R3A1FEnzYpjirFeibdZj3HUl7Nr3HUmZl2oW2oZ7B0uiC3ehDgezfdQdw8jqiM59YZXFPBnVU8pymBG70pXLRe+uqQRjFL1GNrQ92+H+1Nt/PBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716268531; c=relaxed/simple;
	bh=vFv6DJQbTNFYud7DjAOJ9Oiu/jUCZI9/sQAgG3QA0sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ5k5YZKh6z9SC67zM6QcvJnACqeGv8vQuNMWCVmgOXqlZiYTc3uLdlZWYd4eThNwXDaLAVc5uKHpVJ+bx3M/i3c7mmripomaJlrKWjfSXp45Kwtk71daHHfREz75ocpygLilzsbQnB/3ndfopOl+zVIKvtJikoclpsZ/KGO0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzrO7glz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716268531; x=1747804531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vFv6DJQbTNFYud7DjAOJ9Oiu/jUCZI9/sQAgG3QA0sc=;
  b=gzrO7glztyyA2exFIQGMCLlxNU1z6/Z4Cty1KZ0ts/tc0K2pjNMVQwzp
   MrKrQTCd0iydVWPNTIH6mpVzwnLMJ/QzJOWdk4RisZjqoUbpGGd2Kx+yO
   2PoNflUBTmdCC3xqg+eMJ8aKbgdjODIqdVob0tJQ8jI1JaLjIxEhheBOl
   w3YTzgz/XeTHdsXSRgHZw/oyQXZCu7A2rWe+aIIXVIyeJloGE314IehTX
   Jh4RMyGPJQYtW95UfkqhESRYiSBojOZ5Vhnb8AJu9Exg3RmDPPn993NzV
   rgh2rTMYp+cfUctp6DgAHRjo/7FdDHEl0kViZaVui3IBK+WK6V4XInHn5
   g==;
X-CSE-ConnectionGUID: zuOhdeWRSIe4zDJ+ixQa/w==
X-CSE-MsgGUID: 7XlTP8jfTwywCU0j3luDVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="29958977"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="29958977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 22:15:30 -0700
X-CSE-ConnectionGUID: wYlcXpOhRMagvsD64nYFdQ==
X-CSE-MsgGUID: 6GmCX/kFRM6fGEXleLbasQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="37313660"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 20 May 2024 22:15:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 8F675179; Tue, 21 May 2024 08:15:25 +0300 (EEST)
Date: Tue, 21 May 2024 08:15:25 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Gia <giacomo.gio@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Christian Heusel <christian@heusel.eu>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kernel@micha.zone" <kernel@micha.zone>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Benjamin =?utf-8?Q?B=C3=B6hmke?= <benjamin@boehmke.net>,
	"S, Sanath" <Sanath.S@amd.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
Message-ID: <20240521051525.GL1421138@black.fi.intel.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <CAHe5sWY_YJsyiuwf2TsfRTS9AoGoYh4+UxkkZZ0G9z2pXfbnzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHe5sWY_YJsyiuwf2TsfRTS9AoGoYh4+UxkkZZ0G9z2pXfbnzg@mail.gmail.com>

Hi,

On Mon, May 20, 2024 at 05:57:42PM +0200, Gia wrote:
> Hi Mario,
> 
> In my case in both cases the value for:
> 
> $ cat /sys/bus/thunderbolt/devices/domain0/iommu_dma_protection
> 
> is 0.
> 
> Output of sudo journalctl -k with kernel option thunderbolt.dyndbg=+p:
> https://codeshare.io/qAXLoj
> 
> Output of sudo dmesg with kernel option thunderbolt.dyndbg=+p:
> https://codeshare.io/zlPgRb

I see you have "pcie_aspm=off" in the kernel command line. That kind of
affects things. Can you drop that and see if it changes anything? And
also provide a new full dmesg with "thunderbolt.dyndbg=+p" in the
command line (dropping pcie_aspm_off)?

Also is there any particular reason you have it there?

