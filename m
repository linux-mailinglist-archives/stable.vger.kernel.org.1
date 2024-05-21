Return-Path: <stable+bounces-45488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BD8CAA61
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 10:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E560028206F
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C05647E;
	Tue, 21 May 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9QlWB4E"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76355381B;
	Tue, 21 May 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281707; cv=none; b=EUcyQZB5p3S/8HLdQCxvC6rKrGA9LwroVQ5h0fCvs1kpFsgJToPh6gFM1rqJ2P4GUTDenShrbdR922mzsnCGePqpzDusAG/PopRqMu5dqMG+4EtO0NmpKwWoYGgzDrFEbPIHkex8woANT+g3wc9/fSHh8dKixJycIFu0Ygl5n2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281707; c=relaxed/simple;
	bh=aqJj6geibIkWwRe+zJFl0MsryR1bn8zW4vkAmyvb7V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnAaw+gXQcTB/z5RDWxX+pYEcWC8YUu5/YcuIz0t0u7UYAXh3Uw1PePznFaT3FXlCfNHM7YZRmnVPFcjJ7lG1XeLA5oJMt/q4mhtX5eOxxTzYXh4UQy6mQJ2g86exMiV8Y5ajkCFxxf1wjFio4rhMFyHJrOj9W09LjaueX1O5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9QlWB4E; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716281706; x=1747817706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aqJj6geibIkWwRe+zJFl0MsryR1bn8zW4vkAmyvb7V8=;
  b=H9QlWB4EzAo0F5iPDWhYzhs8uLYKAS97Rb6K6B+0NBG5UedwiuMFNVDG
   ru5vOWFj5gjFc+/Xk2Iu0aFIFi2mhmkh3bntXktkMxpCuE0aZN85lTPzx
   x6hcikDJ672c3DToGnKq/OxkFBtRzpUirPXZT0wERN+et/SgUao4UJzPQ
   Kpinmi8XNVU4sdXYv9uEpHGay/YVK0/U72MQ5ot7ssQ1Lej2veMtPt2os
   GwjNyLAouO+rAkH17BcNm0eup+SlTNkHB1tikpPCbRj1iBowOjfD+4qp4
   6pPwuVWHsihvoS102q3PYvkISgzEXbMtoZXjbh6eI8oAsRP0nLb3sQWeu
   A==;
X-CSE-ConnectionGUID: TIMNSchTReGMTy3hRnCXwg==
X-CSE-MsgGUID: SURNsyvxSEyxR4cCmXQMIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="29966576"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="29966576"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 01:55:05 -0700
X-CSE-ConnectionGUID: Qrnsg7WMSn6rFKrS8tr0Cg==
X-CSE-MsgGUID: aBHoeB7cS86v7TJIgcpyug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="32705234"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 May 2024 01:55:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 2DB49179; Tue, 21 May 2024 11:55:01 +0300 (EEST)
Date: Tue, 21 May 2024 11:55:01 +0300
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
Message-ID: <20240521085501.GN1421138@black.fi.intel.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <CAHe5sWY_YJsyiuwf2TsfRTS9AoGoYh4+UxkkZZ0G9z2pXfbnzg@mail.gmail.com>
 <20240521051525.GL1421138@black.fi.intel.com>
 <CAHe5sWY3P7AopLqwaeXSO7n-SFwEZom+MfWpLKGmbuA7L=VdmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHe5sWY3P7AopLqwaeXSO7n-SFwEZom+MfWpLKGmbuA7L=VdmA@mail.gmail.com>

Hi,

On Tue, May 21, 2024 at 10:07:23AM +0200, Gia wrote:
> Thank you Mika,
> 
> Here you have the output of sudo journalctl -k without enabling the
> kernel option "pcie_aspm=off": https://codeshare.io/7JPgpE. Without
> "pcie_aspm=off", "thunderbolt.host_reset=false" is not needed, my
> thunderbolt dock does work. I also connected a 4k monitor to the
> thunderbolt dock thinking it could provide more data.
> 
> I'm almost sure I used this option when I set up this system because
> it solved some issues with system suspending, but it happened many
> months ago.

Okay. I recommend not to use it. The defaults should always be the best
option (unless you really know what you are doing or working around some
issue).

The dmesg you shared looks good, there are few oddities but they should
not matter from functional perspective (unless you are planning to have
a second monitor connected).

First is this:

  May 21 09:59:40 um773arch kernel: thunderbolt 0000:36:00.5: IOMMU DMA protection is disabled

It should really be enabled but I'm not familiar with AMD hardware to
tell more so hoping Mario can comment on that.

The second thing is the USB4 link that seems to be degraded to 2x10G =
20G even though you say it is a Thunderbolt cable. I'll comment more on
that in the other email.

