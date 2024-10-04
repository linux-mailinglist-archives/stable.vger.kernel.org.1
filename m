Return-Path: <stable+bounces-80724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E209598FF71
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 11:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DF1281D5E
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 09:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236B714600F;
	Fri,  4 Oct 2024 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2YAwZPW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86542145B1B
	for <stable@vger.kernel.org>; Fri,  4 Oct 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033300; cv=none; b=b8ShsMxReMG2eA3lmen06NGceXAsYPB2WtbT1uXcLJH/3qQRxfa9eSq0Tdunf/kuD8GLG6OVQ5AcE5znC/3fVxhLiGOin5Qxt5ZIHKAy31PNcq42//lANPNBK9hIMzY/GRpWBSO2lHnRXpehc7E4WHOWajPmsop8rX6tBEOtf1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033300; c=relaxed/simple;
	bh=1C7OiAdPfBqnpWez5BahZoMLagkw/f2Vepo1VUMoKwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJUwrZL+znm4cetaazHB26bUqh59MeDG6UCtcBSC+x1M6ARnDaNYUTwPZTrhS1Bi/7DyjtrNn2nSjf9bm5IiJRlU/ElJ9jsdCv3bNpDGDPndtMMVyJaQQKe1Qrp7yLl3UprPyP91X+p1moDarrN+88CoZqCKf/inK9LDqIhMgvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2YAwZPW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728033299; x=1759569299;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=1C7OiAdPfBqnpWez5BahZoMLagkw/f2Vepo1VUMoKwk=;
  b=d2YAwZPWt/UwvtmNaoj1jowGBs3zrTpP6qzjskN2BFwnFcC1oHXCBaMk
   xk2zkbV/pmkaTbXu19O2BA2ghnTrehkfhTVIDnL4HeSwTUWpLktIIiffW
   EZZeCQJkJsuMY9HDSeU/52sdSwhGTRIH2CvmRBjBeTKCGWxjxVBpK0mRa
   y6t9OVNDimfIhXq5a/RrmeOIC4WicR5+DcXdzdd1t5MwlAjZwuRLH6F6o
   kco2J7QTwQsKTvD/jVPUOZodXwlXPrhiCT0dxbbAyYOfqWYh0VGfIfPUu
   FIDh9XXZKgBubdzp48MKRGlBHOmG2i0TyEokmbArV7jA3mfckvoeA+wij
   A==;
X-CSE-ConnectionGUID: VgCOf4zmQ22K0xJL74rvAQ==
X-CSE-MsgGUID: ofJjGgJqSg6MULlrrJPluw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27384893"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27384893"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:14:57 -0700
X-CSE-ConnectionGUID: qEPVMXIBSqejCohLUqyHmA==
X-CSE-MsgGUID: 8iPdFBTKQ0eFmCma1/mkaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74647452"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:14:58 -0700
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.150])
	by linux.intel.com (Postfix) with ESMTP id 80A2F20B5782;
	Fri,  4 Oct 2024 02:14:56 -0700 (PDT)
Message-ID: <5a0d003078c7cb5aa5196c2dcf0508996ff88fcc.camel@linux.intel.com>
Subject: Re: [PATCH 6.11 608/695] intel_idle: add Granite Rapids Xeon support
From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 04 Oct 2024 12:14:55 +0300
In-Reply-To: <20241002125846.785351246@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
	 <20241002125846.785351246@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-02 at 15:00 +0200, Greg Kroah-Hartman wrote:
> 6.11-stable review patch.=C2=A0 If anyone has any objections, please let =
me know.
>=20
> ------------------
>=20
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>=20
> commit 370406bf5738dade8ac95a2ee95c29299d4ac902 upstream.
>=20
> Add Granite Rapids Xeon C-states, which are C1, C1E, C6, and C6P.
>=20
... snip ...

Hi Greg, I was on vacation. Looks good, but I'll test 6.11-stable with thes=
e
patches (#608 and #609) to double check, and let you know if there are issu=
es.

Thanks!

