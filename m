Return-Path: <stable+bounces-89310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1E99B5E6F
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 10:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616391C20A28
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74301E1A37;
	Wed, 30 Oct 2024 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ELrbBiJw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD01E1C14;
	Wed, 30 Oct 2024 09:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730279191; cv=none; b=L1atPmcMcymWlpLoPlEyZRYobY3MY+spQHSdlkUq7f3iqIY4iONB4En0hCM4dw1zuzUCniQ4UsYoy/DBsOsn+9XQghzwSo5yTQ4zvPuKudyZiv/Bi0G8tGh7izSiYekcCv6AC8Xw8zofjben+X4OUU+9V0Kbb7uJIt+b3N4WjLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730279191; c=relaxed/simple;
	bh=UHAvCgWVJbo/IoGy4cfK+JVAwccuRu6Xu7KbTRA9d2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sV3NnXFZX71BOwTjPddOqqouzJnTo4aZlgGno3jfzOzg2gE4mHJEgpoAChsB/U+4wIjA/N14ejD10GTRM64BJ5/qCniUdOqSLgtEjlrU6gV2fwx4jspbfm04tKmaSyjCR5+kF+1w+4Yln9qXeWsT0j5/A8Pmoj8DRf3IpKo26gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ELrbBiJw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730279190; x=1761815190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UHAvCgWVJbo/IoGy4cfK+JVAwccuRu6Xu7KbTRA9d2I=;
  b=ELrbBiJwOgKriQ+KgjaLtJc+h7uC8qZOlbWr0bMG8FntFOmoVOuQtm2v
   57GbJ4Hd+eGcW+jXbhCOHMdinB+lsWcL8AufnAW2lm7Fv2Jdlva+scziK
   dr1LVvfwXe4OAokwPlQnAh8mB4gW+dedHybODAipNqG6pY9q+cUUzITAB
   NQAdolyfbw/bjVwC4fYicmLKZw+qoZqpBLVPbm/rXKrRK5jE5aRBN+nah
   C6r3o+KVl57ww0dnd/ct0LMF05iJy7p3J8yFTia3ePIB1xCBmHWKaBOuM
   gRTHcP2rtI5Piq1Wmt1PVH0hFxfSxXXaQ30TWPMny6zUJj4PwPrJ0+V6J
   Q==;
X-CSE-ConnectionGUID: O9sxnTjASROMvqKfih1mPA==
X-CSE-MsgGUID: zD45V6riRTOHmPvj9GJHcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30115594"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30115594"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 02:06:29 -0700
X-CSE-ConnectionGUID: aL85xrH/RWGgAivk+/lliA==
X-CSE-MsgGUID: jFHHloDnTvmvKXlW9ep40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="86192087"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 30 Oct 2024 02:06:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 46F682C1; Wed, 30 Oct 2024 11:06:25 +0200 (EET)
Date: Wed, 30 Oct 2024 11:06:25 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rick <rick@581238.xyz>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Sanath.S@amd.com,
	christian@heusel.eu, fabian@fstab.de, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Message-ID: <20241030090625.GS275077@black.fi.intel.com>
References: <000f01db247b$d10e1520$732a3f60$@581238.xyz>
 <96560f8e-ab9f-4036-9b4d-6ff327de5382@amd.com>
 <22415e85-9397-42db-9030-43fc5f1c7b35@581238.xyz>
 <20241022161055.GE275077@black.fi.intel.com>
 <7f14476b-8084-4c43-81ec-e31ae3f7a3c6@581238.xyz>
 <20241023061001.GF275077@black.fi.intel.com>
 <4848c9fe-877f-4d73-84d6-e2249bb49840@581238.xyz>
 <20241028081813.GN275077@black.fi.intel.com>
 <2c27683e-aca8-48d0-9c63-f0771c6a7107@581238.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c27683e-aca8-48d0-9c63-f0771c6a7107@581238.xyz>

Hi Rick,

On Wed, Oct 30, 2024 at 08:11:30AM +0100, Rick wrote:
> Hi Mika,
> 
> Thank you for your email.
> 
> On 28-10-2024 09:18, Mika Westerberg wrote:
> > 
> > I still see similar issue even with the v6.9 kernel. The link goes up an
> > down unexpectly.
> > 
> > I wonder if you could try to take traces of the control channel traffic?
> > I suggest to use v6.11 kernel because it should have all the tracing
> > bits added then install tbtools [1] and follow the steps here:
> > 
> >    https://github.com/intel/tbtools?tab=readme-ov-file#tracing
> > 
> > Then provide both full dmesg and the trace output. That hopefully shows
> > if some of the access we are doing in the Linux side is causing the link
> > to to drop. Let me know if you need more detailed instructions.
> > 
> > Also please drop the "thunderbolt.host_reset=0" from the command line as
> > that did not help, so it is not needed.
> 
> Dropped thank you.
> 
> > 
> > [1] https://github.com/intel/tbtools
> 
> tbtrace on 6.11.5:
> https://gist.github.com/ricklahaye/69776e9c39fd30a80e2adb6156bdb42d
> dmesg on 6.11.5:
> https://gist.github.com/ricklahaye/8588450725695a0bd45799d3d66c7aff

Thanks! I suspect there is something we do when we read the sideband
that makes the device router to "timeout" and retry the link
establishment. There is also the failure when USB 3.x tunnel is created
but we can look that after we figure out the connection issue.

Looking at the trace we are still polling for retimers when we see the
unplug:

[   48.684078] tb_tx Read Request Domain 0 Route 0 Adapter 3 / Lane
               0x00/---- 0x00000000 0b00000000 00000000 00000000 00000000 .... Route String High
               0x01/---- 0x00000000 0b00000000 00000000 00000000 00000000 .... Route String Low
               0x02/---- 0x02182091 0b00000010 00011000 00100000 10010001 .... 
                 [00:12]       0x91 Address
                 [13:18]        0x1 Read Size
                 [19:24]        0x3 Adapter Num
                 [25:26]        0x1 Configuration Space (CS) → Adapter Configuration Space
                 [27:28]        0x0 Sequence Number (SN)
[   48.684339] tb_rx Read Response Domain 0 Route 0 Adapter 3 / Lane
               0x00/---- 0x80000000 0b10000000 00000000 00000000 00000000 .... Route String High
               0x01/---- 0x00000000 0b00000000 00000000 00000000 00000000 .... Route String Low
               0x02/---- 0x02182091 0b00000010 00011000 00100000 10010001 .... 
                 [00:12]       0x91 Address
                 [13:18]        0x1 Read Size
                 [19:24]        0x3 Adapter Num
                 [25:26]        0x1 Configuration Space (CS) → Adapter Configuration Space
                 [27:28]        0x0 Sequence Number (SN)
               0x03/0091 0x81320408 0b10000001 00110010 00000100 00001000 .2.. PORT_CS_1
                 [00:07]        0x8 Address
                 [08:15]        0x4 Length
                 [16:18]        0x2 Target
                 [20:23]        0x3 Re-timer Index
                 [24:24]        0x1 WnR
                 [25:25]        0x0 No Response (NR)
                 [26:26]        0x0 Result Code (RC)
                 [31:31]        0x1 Pending (PND)
[   48.691410] tb_event Hot Plug Event Packet Domain 0 Route 0 Adapter 3 / Lane
               0x00/---- 0x80000000 0b10000000 00000000 00000000 00000000 .... Route String High
               0x01/---- 0x00000000 0b00000000 00000000 00000000 00000000 .... Route String Low
               0x02/---- 0x80000003 0b10000000 00000000 00000000 00000011 .... 
                 [00:05]        0x3 Adapter Num
                 [31:31]        0x1 UPG
[   48.691414] thunderbolt 0000:00:0d.2: acking hot unplug event on 0:3

Taking this into account and also the fact that your previous email you
say that v6.9 works and v6.10 does not, I wonder if you could first try
just to revert:

  c6ca1ac9f472 ("thunderbolt: Increase sideband access polling delay")

and see if that helps with the connection issue? If it does then can you
take full dmesg and the trace again and with me so I can look at the USB
tunnel issue too?

