Return-Path: <stable+bounces-45472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 538538CA78C
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 07:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07F21F21F58
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 05:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5A3D963;
	Tue, 21 May 2024 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahyKiBK0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DBB610C;
	Tue, 21 May 2024 05:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716268318; cv=none; b=F1uP0kHFoEkvSRVTC3IcYa4YQPw1+A4Z4BblF9ApsmW8hjgIYzyuy8ROrDJlvLQT/Pz9odRQaMleSRFseZxumF771br+1eALFxOyPbQDki82dNkRCPL58VIG6sAIz75IEaMOyT110lOUogYWWmlwayi41MzklRicqoqK8h/x3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716268318; c=relaxed/simple;
	bh=qFSJ0rsco8+WuXhll/0TerB+xpQA36XKgLgz4erYikY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8CKHd5NUmpOe6pYRK5xTq4i80MbiYQfgcsxdhsLWze+KN3sLyyGTqW8SMCz8n9liGs9oVRs7/B4JjBhXTo9tuzPXdt2ki+yYa5A4mKyiu/E7iAnTNPsVAz5xhjWBZjj7N5rDiU7ChSk1XeQG7E+D97qMI5163214J03A2mQ7Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahyKiBK0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716268317; x=1747804317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qFSJ0rsco8+WuXhll/0TerB+xpQA36XKgLgz4erYikY=;
  b=ahyKiBK0y6MKfOql6sggDvVB8cxUC+N5XCB0/ZvxrPkBG97veT7rAngj
   hZWU2Ob9vSsgen6W4S3Ts9k9VQf1Kxn4SApTGsocwW7ihg46DDXv47vzU
   9g9UNS74Talda0ViVQ9KjayYh3n3mZw9xLpfalGSdWwAGCR40pWGlFol0
   1cYfN+1+WlCPqgxYVzxSpFCWT9+IwFz25VrQfPld9IZQIeAww1zevZu6L
   vTmVU3AFuZIQiY8X7Tbm5v+CNN+nz2ESb982Ux0rsM+VlZWaw/jGSo821
   CZ23X8gi/WYDtNw2d6yWreuHDo0nFRc1aseD7mWBKV1gb/f0WPnfZBdkc
   w==;
X-CSE-ConnectionGUID: qXsqUT9QTwyyjX1C0s1tVg==
X-CSE-MsgGUID: AnSmHBO8T424rBcqvDtNCg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12610741"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12610741"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 22:11:56 -0700
X-CSE-ConnectionGUID: jmc5xnqSRZuuMYonG8wyTA==
X-CSE-MsgGUID: MBHjqaDvR8e+IpDTQrvK0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32762236"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 20 May 2024 22:11:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id DECD7179; Tue, 21 May 2024 08:11:51 +0300 (EEST)
Date: Tue, 21 May 2024 08:11:51 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Gia <giacomo.gio@gmail.com>
Cc: Benjamin =?utf-8?Q?B=C3=B6hmke?= <benjamin@boehmke.net>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christian Heusel <christian@heusel.eu>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kernel@micha.zone" <kernel@micha.zone>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"S, Sanath" <Sanath.S@amd.com>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
Message-ID: <20240521051151.GK1421138@black.fi.intel.com>
References: <CAHe5sWavQcUTg2zTYaryRsMywSBgBgETG=R1jRexg4qDqwCfdw@mail.gmail.com>
 <38de0776-3adf-4223-b8e0-cedb5a5ebf4d@leemhuis.info>
 <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <61-664b6880-3-6826fc80@79948770>
 <20240520162100.GI1421138@black.fi.intel.com>
 <5d-664b8000-d-70f82e80@161590144>
 <CAHe5sWazL96zPa-v9S515ciE46JLZ1ROL7gmGikfn-vhUoDaZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHe5sWazL96zPa-v9S515ciE46JLZ1ROL7gmGikfn-vhUoDaZg@mail.gmail.com>

Hi,

On Mon, May 20, 2024 at 07:30:28PM +0200, Gia wrote:
> In my case I use the official Thunderbolt cable that came with my
> CalDigit TS3 Plus and yet the log - attached in a previous email -
> says current link speed 10.0 Gb/s. I just tried a good quality USB4
> cable too and nothing changed.

I will take a look at your logs today but in the meantime can you run
following command on the system with the dock connected?

  # tbdump -r 0 -a 1 -vv -N 2 LANE_ADP_CS_0

Here tbdump comes from https://github.com/intel/tbtools. It should be
pretty straighforward to build but let me know if any issues
(unfortunately there is no binary package available at this time).

The '-a 1' should match the adapter the dock is connected. You can get
it for instance like this (this is an example from my system):

  # tblist
  Domain 0 Route 0: 8087:7eb2 Intel Gen14
  Domain 0 Route 1: 003d:0011 CalDigit, Inc. TS3 Plus
  Domain 1 Route 0: 8087:7eb2 Intel Gen14

Here the CalDigit has "Route 1" so it means I use "-a 1" above. It could
be also "Domain 0 Route 3" in which case replace the "-a 1" with "-a 3".

This command should dump two lane adapter registers LANE_ADP_CS_0/1 that
show the link capabilities.

