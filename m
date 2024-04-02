Return-Path: <stable+bounces-35625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70585895A38
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 18:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A183C1C226A3
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72715B108;
	Tue,  2 Apr 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KfAUNKON"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCE15A48F
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076611; cv=none; b=fg/KtXLFS1a4i434WpjSpMQo2qX4nIx6B4Nx2ZqwxOJHAexaMuaDOs4e9r1E6tfmJFOyMT3Emn+WaSxknXlHbkSEwBJgr7DFYnDuqf5MN8o1Pd475/HOSCPRqoXNhD3cxPt2zk9njjth7OwT7V+5EA5o79Ln7Lqk342OvMxHqbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076611; c=relaxed/simple;
	bh=iyx5l7Dqvk4wQTgwuntjrzy0lxMhu/ZL5F5b1gIiFBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tZgAOzmNoaWsxYRcfdcyO65JonyABlfQ9dSh/DwFiQJtWKugmDjLk2dnqH9C1z/5ASXe0QXNzOHexskzcIuT8SfAKOpdTw8XCyEQm4OjLwdToLNCxYgw+acaj73+9W1YfnvoCK7gynuIIRvIQiZQ8vL+SOuA4DhwwC8R/QQQoRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KfAUNKON; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712076610; x=1743612610;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=iyx5l7Dqvk4wQTgwuntjrzy0lxMhu/ZL5F5b1gIiFBs=;
  b=KfAUNKONMez2LrD5h/82/+AShJT5U1PK7zPdZ87owt9vankGOuZSHyRi
   N4XGakzaFaXbZFEHGGEmjqFpqRLOyQSNTTnusDEZfBf7FV7V0vnIuWA1T
   zXnGNc8RHcF1jvcnaAwTLvgdfemC4n10qLGJ2wkoAvERqDbL5miG8hFmy
   nKcxZtrY3QhhMV11S/X7H5xFhIf6cgHRs5yzZBg5qNJqIxlADdc+WO7vg
   yj2u2DCRFc6bv7RqugMNaDNjop2pAqhPmPkAhVkB2uKyLwV2TcN9EBvFq
   noZ4la22Vm8lizrUZ+ql+ZO6i1oyHsXIX02zcLYTcZO2jgekm4VF6pCU7
   Q==;
X-CSE-ConnectionGUID: nxCwa/aGQQWwlHf1idYmow==
X-CSE-MsgGUID: dNxbq0B/SAyW+YdAm2VlFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7132489"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7132489"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:50:09 -0700
X-CSE-ConnectionGUID: KREIV6u/RmeU45kJTGnl+g==
X-CSE-MsgGUID: rqeLoqYhSmKpw0rZRj8z8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22841071"
Received: from pramona-mobl.ger.corp.intel.com (HELO localhost) ([10.252.57.179])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 09:50:06 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Jouni
 =?utf-8?Q?H=C3=B6gander?= <jouni.hogander@intel.com>, Luca Coelho
 <luciano.coelho@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/display: fix display param dup for NULL char *
 params
In-Reply-To: <wujbboih3iscmkadgre3xpur26nt37xeo3grryjgpsefmxwe2t@ovdcfpfe5cbo>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240402155534.1788466-1-jani.nikula@intel.com>
 <wujbboih3iscmkadgre3xpur26nt37xeo3grryjgpsefmxwe2t@ovdcfpfe5cbo>
Date: Tue, 02 Apr 2024 19:49:51 +0300
Message-ID: <87r0fnemkw.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 02 Apr 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> On Tue, Apr 02, 2024 at 06:55:34PM +0300, Jani Nikula wrote:
>>The display param duplication deviates from the original param
>>duplication in that it converts NULL params to to allocated empty
>>strings. This works for the vbt_firmware parameter, but not for
>>dmc_firmware_path, the user of which interprets NULL and the empty
>>string as distinct values. Specifically, the empty dmc_firmware_path
>>leads to DMC and PM being disabled.
>>
>>Just remove the NULL check and pass it to kstrdup(), which safely
>>returns NULL for NULL input.
>>
>>Fixes: 8015bee0bfec ("drm/i915/display: Add framework to add parameters s=
pecific to display")
>>Fixes: 0d82a0d6f556 ("drm/i915/display: move dmc_firmware_path to display=
 params")
>>Cc: Jouni H=C3=B6gander <jouni.hogander@intel.com>
>>Cc: Luca Coelho <luciano.coelho@intel.com>
>>Cc: <stable@vger.kernel.org> # v6.8+
>>Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Thanks!

> ... but what's the purpose of the duplication?  How one is supposed to
> use the dmc_firmware with e.g. LNL + BMG? Setting it later via debugfs
> doesn=C2=B4t change the behavior. AFAIR this was done to support multiple
> devices, but I don't think it achieves its purpose or I'm missing
> something.
>
> By leaving a param writable and not duplicate it at all, we are at
> least be allowed to:
>
> 1) disable autoprobe
> 2) load module
> 3) bind do LNL
> 4) set dmc_firmware param
> 5) bind to BMG
>
> Yeah, it's manual and not intuitive, but should only be used by
> developers with targeted debug.  How would we do something like that
> with the current code?
>
> I know that for params via sysfs, it's impossible to get them back to
> NULL, so I think we should make sure NULL and empty is handled the same
> way. Getting it back to empty is hard enough but at least possible (see
> https://lore.kernel.org/igt-dev/20240228223134.3908035-4-lucas.demarchi@i=
ntel.com/),
> but I think this is not the case for debugfs.

There are a lot of angles to this. :)

First of all, I think when we do copy the params, they should be
preserved as they were, instead of changed. This patch fixes this part,
and the bug that currently disables DMC altogether.

We do copies for a few reasons. From module params to device params, and
from device params to error capture.

I agree that making a distinction between an unset parameter and a
parameter set to NULL is probably a mistake, because as you mention it's
not feasible to go back to NULL. In this case, NULL means default and ""
means disabled. No way to go back to default.

For params that only make sense at probe, we should perhaps leave the
module parameter writable, and the device parameter read only. Even in
this case, the duplication is a feature and makes sense: you can modify
the module parameter, but it only makes a difference to devices bound
after the change. For devices already bound, you can look up the value
that was used from debugfs.

BR,
Jani.



--=20
Jani Nikula, Intel

