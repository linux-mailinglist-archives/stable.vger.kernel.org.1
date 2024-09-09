Return-Path: <stable+bounces-74084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6BF972204
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08681C23344
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4ED189517;
	Mon,  9 Sep 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I6rlqljj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B40183CDB;
	Mon,  9 Sep 2024 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725907243; cv=none; b=useWPk0JZT7HO8Ikq0cjrrOLi/4/iy7oghKFqFBpdghQKOyYQ7GV9Hdhl36HKKgciUBsVlJFzyNzss3+xTecFC3YAc5EjbcyXXuUMMEm3GtujuQ+yj3rJqPA0TH8oGtiIalR89THoATr8eHH1Bz6eytu60MNn39Jf5QpRkcZXaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725907243; c=relaxed/simple;
	bh=ldth771QtKYp1aOO9EKui3hX7A0F+l9TXfrgCTBSWZY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bb8F9aHtW+vh3RWI0WZ/sBRxPg387tNI2Bs7Y8df8yoalmfN5FmTO+H/87Am4sv4O6+l4ngse7hUuU/cx4SUlN98z6MY4FBujtK/NWnf0XUTCS2VCt71OKHMdmOCh8B4OPni1BVCZ0uVN5DtSN0nFrW1u86WcGhWyvlgA7lBxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I6rlqljj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725907242; x=1757443242;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ldth771QtKYp1aOO9EKui3hX7A0F+l9TXfrgCTBSWZY=;
  b=I6rlqljjyr93xIyeXYqGeDUno4QAh+oDzXV/ro9Z03sUwna+BaWwpDmn
   KhoCbfb9u13HOxD8Og9k5XIRoXnNma/5foPQt0XIenUZvVHen548mborA
   K63ad+rA68jsgq7BvXPWSsCjkAXLKqfyNlLkeBh7FetRwj7TYPa0trjY/
   ZmMMhpE/0KZalw9pOWM4rQ/H1b0qpYj/dzo2T8tLntP5bfi4W5qJOGcAk
   awPVCoP0oPLre/U9XHXSuYcUoDVHLcJFRPN6UYPZuv2EXUnUuHlsniEkh
   BHAxDqiNCuFSzDa4R30iL5aXG5uaGr5tMzrnckKyn0qC31Wzncya59R8n
   Q==;
X-CSE-ConnectionGUID: MzCLjFEvR86hfSuGhvN9hg==
X-CSE-MsgGUID: h445T1epRyaqWo+6OnZwww==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24120412"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24120412"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 11:40:41 -0700
X-CSE-ConnectionGUID: OxYL5/vJTWqo4UpbyrhYig==
X-CSE-MsgGUID: REAwAcRSSvG247ovHd1ddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="97571629"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 11:40:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Sep 2024 21:40:36 +0300 (EEST)
To: Hans de Goede <hdegoede@redhat.com>
cc: Andy Shevchenko <andy@kernel.org>, James Harmison <jharmison@redhat.com>, 
    platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] platform/x86: panasonic-laptop: Fix SINF array
 out of bounds accesses
In-Reply-To: <172590448046.2114.11735502570640542626.b4-ty@linux.intel.com>
Message-ID: <68b1cc24-1ef0-c247-f2c0-546e7ee96ed9@linux.intel.com>
References: <20240909113227.254470-1-hdegoede@redhat.com> <172590448046.2114.11735502570640542626.b4-ty@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-732980885-1725905230=:966"
Content-ID: <e5d23138-5364-e501-91cd-848664a367e0@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-732980885-1725905230=:966
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7b4c3389-35f1-d4c2-1810-61c91372e9f9@linux.intel.com>

On Mon, 9 Sep 2024, Ilpo J=E4rvinen wrote:

> On Mon, 09 Sep 2024 13:32:25 +0200, Hans de Goede wrote:
>=20
> > The panasonic laptop code in various places uses the SINF array with in=
dex
> > values of 0 - SINF_CUR_BRIGHT(0x0d) without checking that the SINF arra=
y
> > is big enough.
> >=20
> > Not all panasonic laptops have this many SINF array entries, for exampl=
e
> > the Toughbook CF-18 model only has 10 SINF array entries. So it only
> > supports the AC+DC brightness entries and mute.
> >=20
> > [...]
>=20
>=20
> Thank you for your contribution, it has been applied to my local
> review-ilpo branch. Note it will show up in the public
> platform-drivers-x86/review-ilpo branch only once I've pushed my
> local branch there, which might take a while.
>=20
> The list of commits applied:
> [1/3] platform/x86: panasonic-laptop: Fix SINF array out of bounds access=
es
>       commit: f52e98d16e9bd7dd2b3aef8e38db5cbc9899d6a4
> [2/3] platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf =
array
>       commit: 33297cef3101d950cec0033a0dce0a2d2bd59999
> [3/3] platform/x86: panasonic-laptop: Add support for programmable button=
s
>       (no commit info)

Hmpf, b4 messed this one up. Only patches 1-2 were applied and 3 should=20
go through for-next.

--=20
 i.
--8323328-732980885-1725905230=:966--

