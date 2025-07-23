Return-Path: <stable+bounces-164493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD5B0F8A8
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 19:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53332177DF1
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223720D50B;
	Wed, 23 Jul 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ef0DOLYw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8BF2F5B
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753290571; cv=none; b=mQkxqupOmrE2e5MgbGtPJM6S4fsy66qKhTH/uNhARPaCK4hGVlge3jmZz3U6TNJcXT7KzELEsjeOV21Z4Uykm5ZMsYmzJFKcZT/QpwXFO+jsJWr9quEOkBk1lyKOjZvnbLNarxV5aUrdy2PIjX88eMDKAerANJcKtD2bi6IaR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753290571; c=relaxed/simple;
	bh=ZJubHw+sKAucX5BEfVuNHWO9J8yoFbw57uIvndr4v/4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lN2Idxz1jtI/zJut4Mm7o2xKgeQiuCQICbaWo9g+yhRgR6O33iwwos4l+4DO4/FxNX2Db5ME8E0QneyEOCXGNsTx7w6KTGWZOiRjq+SYEdgD+YOsjHhFsq92Zh7BSFpR3eOA/iD5IajlcdvNJb4HsHKnOL4jsclxGtSBYQe6Y6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ef0DOLYw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753290570; x=1784826570;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ZJubHw+sKAucX5BEfVuNHWO9J8yoFbw57uIvndr4v/4=;
  b=Ef0DOLYwr1CWy2gs97BuC2oXbouIsHLeViYdk+JBP8EO91efeUdAHc6w
   XfE3uKHsJuaddWk3SkGh28bihtYHTFzsoahrdcNK9mEvOWeJloFpvWP42
   vmu2oWbouKsg1fSOx4yQKmcyz7Wqzaawk55VFDysoLhYMlXuku97XpG6a
   zvrW50VxQzOmpePEBmvhoYtsgtp7RhAnz2KYvhei9Ll9phpG0Zm71tDCE
   oCb343TZQsk4gVVmtKmPImdw70i75V8887teO3mSlhelzaaMko/+Ow4tE
   YCJ75qCYjSFyAcEqEW4SQktqIeUKClBrIB+Wj1bUc1uUGRnr1uI30j1rR
   Q==;
X-CSE-ConnectionGUID: e/u21bsRSgCQD2zQSPDscg==
X-CSE-MsgGUID: Y3Qj1fj4SaWlAI/bmW6zZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66923973"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="66923973"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 10:09:27 -0700
X-CSE-ConnectionGUID: ZccCecysQ3GytxXnaG0JIw==
X-CSE-MsgGUID: tMu0Z+e8SQeL/PME+QjBuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="163711163"
Received: from aschofie-mobl2.amr.corp.intel.com ([10.125.108.174])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 10:09:26 -0700
Message-ID: <fbc7f6a0e5f5144d8ad21c7f3e084638373bef67.camel@linux.intel.com>
Subject: Re: [PATCH 5.15.y] powercap: intel_rapl: Do not change CLAMPING bit
 if ENABLE bit cannot be changed
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, 
 stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "Rafael J .
 Wysocki" <rafael.j.wysocki@intel.com>
Date: Wed, 23 Jul 2025 10:09:24 -0700
In-Reply-To: <aID6aeUGpWGUADIz@lappy>
References: <2025070818-buddhism-wikipedia-516a@gregkh>
	 <20250721001504.767161-1-sashal@kernel.org>
	 <bbb2c75c-2e14-47c2-987b-aefabf298d6b@oracle.com>
	 <2b62ff30e0c3a256ec18d074623967e3b317e1e3.camel@linux.intel.com>
	 <aID6aeUGpWGUADIz@lappy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-23 at 11:06 -0400, Sasha Levin wrote:
> On Wed, Jul 23, 2025 at 06:48:08AM -0700, srinivas pandruvada wrote:
> > On Wed, 2025-07-23 at 12:11 +0530, Harshit Mogalapalli wrote:
> > > > +	/* Check if the ENABLE bit was actually changed */
> > > > +	ret =3D rapl_read_data_raw(rd, PL1_ENABLE, true, &val);
> > > > +	if (ret) {
> > > > +		cpus_read_unlock();
> > > > +		return ret;
> > > > +	}
> > >=20
> > > Shouldn't this be rapl_read_data_raw(rd, PL1_ENABLE, false,
> > > &val); ?
> > >=20
> > >=20
> > Correct. This will result in additional call to rapl_unit_xlate(),
> > but
> > since for primitive PL1_ENABLE, the unit is ARBITRARY_UNIT, this
> > will
> > not translate and return the same value.
>=20
> I was thinking we need to call rapl_unit_xlate() so we won't just get
> whatever the raw value is, but yes - since it's ARBITRARY_UNIT then
> it
> won't really do much.
>=20
> I guess in this case it doesn't really matter if we pass true or
> false
> here?

correct, you just save one additional call.

Thanks,
Srinivas

>=20


