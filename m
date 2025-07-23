Return-Path: <stable+bounces-164446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D295BB0F470
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E983BC1E2
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 13:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A052E7F06;
	Wed, 23 Jul 2025 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzeiIKm0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86F2E425D
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278493; cv=none; b=u9+mofIMNtv/L67OrF6caV6qhcIgDXdm7FEYql3SLCCSowzwhcGR55JIp63DvF3tCVp72U30bJdKlQG2KTgzu8wWFCHvXRLI6V9zgsVxqrHMsUubKTDtsGBE0xNCVz5IPWxZh146QDKng8fXHqJZteUl9r4upEY2OgC7yb1YSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278493; c=relaxed/simple;
	bh=+oF4qJFv01ve5ifgodU8AWkVjcFzb7a+X8H7r1/57OQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b5e4/cOg68YqsrNrpJxTYZTnT0/+ZuOovNgKJj6OG0PzKT4yxEGq/iBJR7LaGjpOOGpILP5AdGp441BFbgdLpnO/8iW+suf41FHfBb348OHXDU+bonQdFebtcGL8F2e4QZcif+U7SAYCgEcdhk4yS0PcJUJ+Phh0+9r0w1sqZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzeiIKm0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753278492; x=1784814492;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+oF4qJFv01ve5ifgodU8AWkVjcFzb7a+X8H7r1/57OQ=;
  b=QzeiIKm0p/d2EL2b+24LRCt4JgCMI/dV/8qsv2dcFbElvJ2CLUo21/OJ
   yQredZKE4SYVuhfC2u3U1z5LfSwGY6ELe2f559ZznZ5bzfs5oOC8hv6kX
   DSJzxyTuKqVHQj7CWqhGbeWn/626g/SugLQJ/Sb3CHRuBZd7rTN12FXUd
   5P+TyfgB/nMJMfbWQu3WTk80sClzX4eNOV5TPjc00/sVO2H6XsKuYvaMF
   OJYz0mpUfjTqvSLTHtamISFKhIrhE+g3Qtro1eHWQ9uIpI71yjaJrTdhd
   NdUKsa7G5cUrJX2f9bnEdIe42iBw4QkF+wuZWtoTPudcosMDELubHzgYr
   g==;
X-CSE-ConnectionGUID: W5zvOFIeRM+zOLe+OvmoDQ==
X-CSE-MsgGUID: es6ga4EsQJSl+W3AWObBnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="59218334"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59218334"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:48:11 -0700
X-CSE-ConnectionGUID: YC89VqXjRZW98DKhz37HVQ==
X-CSE-MsgGUID: K4PNvXhhR3e3kmY/HQpgfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163597344"
Received: from aschofie-mobl2.amr.corp.intel.com ([10.125.108.174])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 06:48:10 -0700
Message-ID: <2b62ff30e0c3a256ec18d074623967e3b317e1e3.camel@linux.intel.com>
Subject: Re: [PATCH 5.15.y] powercap: intel_rapl: Do not change CLAMPING bit
 if ENABLE bit cannot be changed
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Sasha Levin
	 <sashal@kernel.org>, stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki"
	 <rafael.j.wysocki@intel.com>
Date: Wed, 23 Jul 2025 06:48:08 -0700
In-Reply-To: <bbb2c75c-2e14-47c2-987b-aefabf298d6b@oracle.com>
References: <2025070818-buddhism-wikipedia-516a@gregkh>
	 <20250721001504.767161-1-sashal@kernel.org>
	 <bbb2c75c-2e14-47c2-987b-aefabf298d6b@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-23 at 12:11 +0530, Harshit Mogalapalli wrote:
> Hi Sasha,
>=20
>=20
> Question inline from a backport point of view:
> On 21/07/25 05:45, Sasha Levin wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> >=20
> > [ Upstream commit 964209202ebe1569c858337441e87ef0f9d71416 ]
> >=20
> > PL1 cannot be disabled on some platforms. The ENABLE bit is still
> > set
> > after software clears it. This behavior leads to a scenario where,
> > upon
> > user request to disable the Power Limit through the powercap sysfs,
> > the
> > ENABLE bit remains set while the CLAMPING bit is inadvertently
> > cleared.
> >=20
> > According to the Intel Software Developer's Manual, the CLAMPING
> > bit,
> > "When set, allows the processor to go below the OS requested P
> > states in
> > order to maintain the power below specified Platform Power Limit
> > value."
> >=20
> > Thus this means the system may operate at higher power levels than
> > intended on such platforms.
> >=20
> > Enhance the code to check ENABLE bit after writing to it, and stop
> > further processing if ENABLE bit cannot be changed.
> >=20
> > Reported-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > Fixes: 2d281d8196e3 ("PowerCap: Introduce Intel RAPL power capping
> > driver")
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Link:
> > https://patch.msgid.link/20250619071340.384782-1-rui.zhang@intel.com
> > [ rjw: Use str_enabled_disabled() instead of open-coded equivalent
> > ]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > [ replaced rapl_write_pl_data() and rapl_read_pl_data() with
> > rapl_write_data_raw() and rapl_read_data_raw() ]
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> > =C2=A0 drivers/powercap/intel_rapl_common.c | 23 ++++++++++++++++++++++=
-
> > =C2=A0 1 file changed, 22 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/powercap/intel_rapl_common.c
> > b/drivers/powercap/intel_rapl_common.c
> > index 9dfc053878fda..40d149d9dce85 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -212,12 +212,33 @@ static int find_nr_power_limit(struct
> > rapl_domain *rd)
> > =C2=A0 static int set_domain_enable(struct powercap_zone *power_zone,
> > bool mode)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct rapl_domain *rd =3D
> > power_zone_to_rapl_domain(power_zone);
> > +	u64 val;
> > +	int ret;
> > =C2=A0=20
> > =C2=A0=C2=A0	if (rd->state & DOMAIN_STATE_BIOS_LOCKED)
> > =C2=A0=C2=A0		return -EACCES;
> > =C2=A0=20
> > =C2=A0=C2=A0	cpus_read_lock();
> > -	rapl_write_data_raw(rd, PL1_ENABLE, mode);
> > +	ret =3D rapl_write_data_raw(rd, PL1_ENABLE, mode);
> > +	if (ret) {
> > +		cpus_read_unlock();
> > +		return ret;
> > +	}
> > +
> > +	/* Check if the ENABLE bit was actually changed */
> > +	ret =3D rapl_read_data_raw(rd, PL1_ENABLE, true, &val);
> > +	if (ret) {
> > +		cpus_read_unlock();
> > +		return ret;
> > +	}
>=20
> Shouldn't this be rapl_read_data_raw(rd, PL1_ENABLE, false, &val); ?
>=20
>=20
Correct. This will result in additional call to rapl_unit_xlate(), but
since for primitive PL1_ENABLE, the unit is ARBITRARY_UNIT, this will
not translate and return the same value.

Thanks,
Srinivas


> Thanks
> Harshit
> > +
> > +	if (mode !=3D val) {
> > +		pr_debug("%s cannot be %s\n", power_zone->name,
> > +			 mode ? "enabled" : "disabled");
> > +		cpus_read_unlock();
> > +		return 0;
> > +	}
> > +
> > =C2=A0=C2=A0	if (rapl_defaults->set_floor_freq)
> > =C2=A0=C2=A0		rapl_defaults->set_floor_freq(rd, mode);
> > =C2=A0=C2=A0	cpus_read_unlock();
>=20


