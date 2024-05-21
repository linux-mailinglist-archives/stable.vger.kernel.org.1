Return-Path: <stable+bounces-45499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762F8CAD50
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 13:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA737281C09
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD974BF0;
	Tue, 21 May 2024 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXe8poBI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AC55E43;
	Tue, 21 May 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290820; cv=none; b=p0ZO/yUv8UTATpimwdFPatJAZsycnPrsgffa9zc2X+581IXClSKd5rtTPIJ1MUIxznCIUpNKDi3qIAgyEUQukKb7+9KdjPMmeC7gOx1SdXW6fNgm8JQQROD8SCbmoi4eiHzcRRUh5tRAMyUDW8QyfUXySOABM8x2W9rqa7MCfE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290820; c=relaxed/simple;
	bh=PJqoCPkOCR3UUd+gl0wkD3v4z7g4IbzVghSUwmDYQaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mc9O4NwBoiIABZHhwJIjD9nu7FLQXPPr8kcwYPOsHqSixXUoDee/y/GCSZxG0ROxYC3AnPaS3MjtvnLcq9bnxal4N0OS9fRStYqSwKD9BsqvFw5q9np9XwQZwUjVWxEW1SJYozCU37J71ewi/MdfMTHjvtOyg9VZLIVy0XZQtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXe8poBI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716290819; x=1747826819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PJqoCPkOCR3UUd+gl0wkD3v4z7g4IbzVghSUwmDYQaY=;
  b=aXe8poBIPaQyuogP0q8ar217cCgg4wyJHNE8oYccgbrIkNy8gi1BX/B1
   3BM5Vd9v0zTsyS+H8MWFTLUBEtMRhMnucm3PGiiA/35t3LT0fx8JF/Yxl
   Sa9/Akg5SO1zDFciMhdENTBHUIJIRqV5+JhmOw5U9If1N3qG5GDVsqDwl
   FAnKpS1Lj6dVqhxQw+1gABX7COWGjVcMlB1J1OO2asvSEKyXD2mC2+dgd
   xkzpP9W1cCeztvSjXPh1Adq6pzSeia/8/JBGKGgedVJitmu6VT4rQo4+A
   fk0GOXsp6bZsrct55fzYgcWOiDt3I/AvUdCPiSkWMc9n9AxkNU8ZbFVqL
   Q==;
X-CSE-ConnectionGUID: UghX9h0bSkOFPQJ4O0ZA7Q==
X-CSE-MsgGUID: yqF66r/ES+ufLGcmrJ6oTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23145506"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="23145506"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 04:26:58 -0700
X-CSE-ConnectionGUID: sp4Q/AZZTUKPAIAcwYmi9Q==
X-CSE-MsgGUID: Uzep9t58QoiuClQwX3w4iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="37274456"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 21 May 2024 04:26:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 697FD17F; Tue, 21 May 2024 14:26:54 +0300 (EEST)
Date: Tue, 21 May 2024 14:26:54 +0300
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
Message-ID: <20240521112654.GP1421138@black.fi.intel.com>
References: <lqdpk7lopqq4jn22mycxgg6ps4yfs7hcca33tqb2oy6jxc2y7p@rhjjbzs6wigu>
 <611f8200-8e0e-40e4-aff4-cc2c55dc6354@amd.com>
 <61-664b6880-3-6826fc80@79948770>
 <20240520162100.GI1421138@black.fi.intel.com>
 <5d-664b8000-d-70f82e80@161590144>
 <CAHe5sWazL96zPa-v9S515ciE46JLZ1ROL7gmGikfn-vhUoDaZg@mail.gmail.com>
 <20240521051151.GK1421138@black.fi.intel.com>
 <CAHe5sWb7kHurBvu6JC6OgXZm9mSg5a2W2XK9L8gCygYaFZz7JQ@mail.gmail.com>
 <20240521085926.GO1421138@black.fi.intel.com>
 <CAHe5sWb=14MWvQc1xkyrkct2Y9jn=-dKgX55Cow_9VKEeapFwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHe5sWb=14MWvQc1xkyrkct2Y9jn=-dKgX55Cow_9VKEeapFwA@mail.gmail.com>

On Tue, May 21, 2024 at 11:12:10AM +0200, Gia wrote:
> Here you have the output from the dock upstream port:
> 
> sudo tbdump -r 2 -a 1 -vv -N2 LANE_ADP_CS_0
> 
> 0x0036 0x003c013e 0b00000000 00111100 00000001 00111110 .... LANE_ADP_CS_0
>   [00:07]       0x3e Next Capability Pointer
>   [08:15]        0x1 Capability ID
>   [16:19]        0xc Supported Link Speeds
>   [20:21]        0x3 Supported Link Widths (SLW)
>   [22:23]        0x0 Gen 4 Asymmetric Support (G4AS)
>   [26:26]        0x0 CL0s Support
>   [27:27]        0x0 CL1 Support
>   [28:28]        0x0 CL2 Support
> 0x0037 0x0828003c 0b00001000 00101000 00000000 00111100 .... LANE_ADP_CS_1
>   [00:03]        0xc Target Link Speed → Router shall attempt Gen 3 speed
>   [04:05]        0x3 Target Link Width → Establish a Symmetric Link
>   [06:07]        0x0 Target Asymmetric Link → Establish Symmetric Link
>   [10:10]        0x0 CL0s Enable
>   [11:11]        0x0 CL1 Enable
>   [12:12]        0x0 CL2 Enable
>   [14:14]        0x0 Lane Disable (LD)
>   [15:15]        0x0 Lane Bonding (LB)
>   [16:19]        0x8 Current Link Speed → Gen 2
>   [20:25]        0x2 Negotiated Link Width → Symmetric Link (x2)
>   [26:29]        0x2 Adapter State → CL0
>   [30:30]        0x0 PM Secondary (PMS)

Hmm, okay both sides announce support of Gen3 yet the link is Gen2 which
makes me still suspect the cable, or the connection in general. I
suggest, if you have, try with another Thunderbolt cable.

