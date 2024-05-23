Return-Path: <stable+bounces-45614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F478CCB78
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 06:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2794B282EB0
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 04:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E312B15A;
	Thu, 23 May 2024 04:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QF3ROHgA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914141F5E6;
	Thu, 23 May 2024 04:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439514; cv=none; b=KWZK57oO+11vhiqKy1Ou2uRbHvPpRdJH8n+HrhclptNQtlVgzwzBJ/Fupl+0WDj3Q5P1Nak9XD6mxJWJZZvMamdgo9DprojgF1IORTumpfQrMOGE95c1dD7pQJR4U6WtkGKACRUmmaPUOeRRCDxiWNTe14rG72nHET91ZU/VVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439514; c=relaxed/simple;
	bh=vCGKBBvs+CFNAlmNfTvta6ASZjdxorfckdKRcybznSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYB3k5mWJIZFfNlUanpzI5u6uv3FZrLzHek2mdPr6lnhRfVAcSVCL8QcUrxXXqYKhQtZfUhGA2VGorXvzIcjDHbXLdqvAtFQQOJxPZ54f3EshjzuRBLzQo634ke0l+xOveUgrVXjdYkphBjJuKAtasMf5pksoWBOBz4LAZl09uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QF3ROHgA; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716439513; x=1747975513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vCGKBBvs+CFNAlmNfTvta6ASZjdxorfckdKRcybznSQ=;
  b=QF3ROHgAewoBhWvOAJu5nDL9+dnGiZqJwxylXO12DjU0B049ogvLqpL4
   VouFS39iu2vF7CUt9pjmKnRdsqZI7AT6pjravWfscF/TzyaUNg00gdXBJ
   aga8Jx9E1Dn7aUCqOecv+8J1zRADmOF3Jqx6Th9DblneCtTtwD0YRa+v/
   ANfSCsnVxy4fqhN87KJpe8AIYvE0GGzdECh0NB2CrIiFAwJTOCuc1U3av
   7qYqxRvM/vMNVOG/ro2le8oowDYnqpa4BG25hwZ5O4Ed7bF6CHLILAGGn
   E6jxI+m6Xly4BY9gr0OhfZQ/sHJbKESVlIqDYk5xidIBifHM8TNLmLuyC
   Q==;
X-CSE-ConnectionGUID: 3stSL6jqTMGpk2zd/QzSaA==
X-CSE-MsgGUID: kVPSIKh3TL+e7iJDG5srhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12564657"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12564657"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 21:45:12 -0700
X-CSE-ConnectionGUID: 5hDjUWs0SY++9FE1vCsMCw==
X-CSE-MsgGUID: myyeBLecRpmyCN6Kh5ttQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33427663"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 22 May 2024 21:45:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id DABA2E7; Thu, 23 May 2024 07:45:07 +0300 (EEST)
Date: Thu, 23 May 2024 07:45:07 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Gia <giacomo.gio@gmail.com>, "S, Sanath" <Sanath.S@amd.com>,
	Benjamin =?utf-8?Q?B=C3=B6hmke?= <benjamin@boehmke.net>,
	Christian Heusel <christian@heusel.eu>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"kernel@micha.zone" <kernel@micha.zone>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [REGRESSION][BISECTED] "xHCI host controller not responding,
 assume dead" on stable kernel > 6.8.7
Message-ID: <20240523044507.GX1421138@black.fi.intel.com>
References: <20240520162100.GI1421138@black.fi.intel.com>
 <5d-664b8000-d-70f82e80@161590144>
 <CAHe5sWazL96zPa-v9S515ciE46JLZ1ROL7gmGikfn-vhUoDaZg@mail.gmail.com>
 <20240521051151.GK1421138@black.fi.intel.com>
 <CAHe5sWb7kHurBvu6JC6OgXZm9mSg5a2W2XK9L8gCygYaFZz7JQ@mail.gmail.com>
 <20240521085926.GO1421138@black.fi.intel.com>
 <CAHe5sWb=14MWvQc1xkyrkct2Y9jn=-dKgX55Cow_9VKEeapFwA@mail.gmail.com>
 <20240521112654.GP1421138@black.fi.intel.com>
 <CAHe5sWbAkgypzOA-JpBpwY5oFP1wXShKDNevmjLEu1kR1VOeRA@mail.gmail.com>
 <79dfc0b9-94d4-4046-a3b9-185e53b4a192@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79dfc0b9-94d4-4046-a3b9-185e53b4a192@amd.com>

On Wed, May 22, 2024 at 10:19:51AM -0500, Mario Limonciello wrote:
> On 5/22/2024 09:41, Gia wrote:
> > Now this is odd...
> > 
> > I've tested another cable - a very short one used with a Gen3 nvme
> > enclosure that I'm sure it's working - and I got Gen2 20 Gbps. I also
> > have tested this on Windows 11 and I still just got a Gen2 connection.
> > 
> > I was almost sure it was caused by a bad USB4 implementation by the PC
> > manufacturer, then I tried to connect a Thunderbolt 3 disk enclosure
> > via daisy chain to the Caldigit dock and I got the full Gen3 40 Gbps
> > connection! See the attached picture.
> > 
> 
> I suspect you can't actually get Gen 3 performance in this configuration.
> IIUC you should still be limited by the uplink to the host.

One "explanation" could be that the distance from the SoC to the Type-C
connector is relatively long which would require a retimer to get the
Gen3 speeds.

