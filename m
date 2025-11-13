Return-Path: <stable+bounces-194661-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15344C55ED7
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 07:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 393E24E2B67
	for <lists+stable@lfdr.de>; Thu, 13 Nov 2025 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95212320A04;
	Thu, 13 Nov 2025 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ma8VLPZe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00E299957;
	Thu, 13 Nov 2025 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763015474; cv=none; b=MUYUwcMdmXQ2IX5emEmXb7uprBW4XBAY75Ztylu26LLQKPU8H5VxXx3TC5TvZfMMrisZl2TwPn4pkNhnSxp8R9PAV6RADNveklqYFtHWjXK9iHMe73DAvZrQd0WmkThJ6TVbe7ws572vN9by2mxB/HJGdoNaZPGcspevyk7r/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763015474; c=relaxed/simple;
	bh=KTrdF0oN78I/0/ajkgQRubzWWqyEYegoWh0yFiFiDOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrv0HwsH2YTH7cKU2hvSO8HPw0QCMYBOxNfVCHvHOTka5hmbczev1Z2jOS0AqcN6lakASJiVNTuhhe+HP70HvvHJBARnLdqE8wVhmW10giQ0MxzMGKH/3y3eJYhk5EVvF03j4HrOePEtASFlUM6S4MGlXRj//xcDNkGspX0DJx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ma8VLPZe; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763015473; x=1794551473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KTrdF0oN78I/0/ajkgQRubzWWqyEYegoWh0yFiFiDOE=;
  b=Ma8VLPZeNSciQrYAIOKC2nC/zt1Ger62BKVsXvaEMZwMWr40tyYvJ8Qz
   K0maNkIFUF6FEzmQVnwyzgm/DN/6HZOhr9ArDX7yUaOYXmwfBBEd1evf6
   4MU0pFb4tydlIMyhI5pfj+o0fhwfy0a99NP6OuCy5MqxmmYWnzd18Y+4o
   PST3RB6C32wm4cCR13bFcUdeeyQy6OBciDy3Fgn4st2+hebH6Y3tApSkn
   AZ5fEkro25ENyP+5PBKbBUedzZ32zdilXn75946K9LfHnBt8WKWX06xRf
   E4Yvwjkyce0j9RlwlTQAJce8cFwdVS6EKe/dPB56kPi8saSNHw7lbBGz5
   w==;
X-CSE-ConnectionGUID: MXTNAD2kThOEKIN6c3M7sw==
X-CSE-MsgGUID: wkiO0o6IQkKFTUfMqqwg9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="87733524"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="87733524"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 22:31:11 -0800
X-CSE-ConnectionGUID: f4Al0sQYSWCeg4XI9lC06A==
X-CSE-MsgGUID: R/7lys7xSAWvOlYx8I0N0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189268442"
Received: from rvuia-mobl.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.245.89])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 22:31:07 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6EB12121796;
	Thu, 13 Nov 2025 08:31:04 +0200 (EET)
Date: Thu, 13 Nov 2025 08:31:04 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, hariconscious@gmail.com,
	cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev, perex@perex.cz, tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com, khalid@kernel.org,
	shuah@kernel.org, david.hunter.linux@gmail.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: Intel: avs: Fix potential buffer overflow by
 snprintf()
Message-ID: <aRV7KMU_I13osYbE@kekkonen.localdomain>
References: <20251112181851.13450-1-hariconscious@gmail.com>
 <2025111239-sturdily-entire-d281@gregkh>
 <18bac943-6420-439c-91dc-643277850f69@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18bac943-6420-439c-91dc-643277850f69@sirena.org.uk>

On Wed, Nov 12, 2025 at 07:33:51PM +0000, Mark Brown wrote:
> On Wed, Nov 12, 2025 at 02:20:19PM -0500, Greg KH wrote:
> 
> > Also please do not wrap lines of fixes tags.
> 
> Someone probably ought to teach checkpatch about that one, it moans
> about long lines without checking for Fixes: IIRC.

I can recall this issue, too... I checked how to reproduce and fix this but
it seems it's already done: I couldn't reproduce it. I'm getting this for
breaking a Fixes: line:

WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes: ...

It basically now checks the subject matches with the quoted string.

So all is well!

-- 
Sakari Ailus

