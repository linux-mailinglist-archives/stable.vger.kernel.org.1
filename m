Return-Path: <stable+bounces-206052-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E29CFB57B
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 00:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD3FB30380D6
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 23:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC992DE6FC;
	Tue,  6 Jan 2026 23:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hxq82pJH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181F265CA8;
	Tue,  6 Jan 2026 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767741885; cv=none; b=mi7kyZnXDBxLe1hlUkV7rBlejijEs6Pgxqdu3dMhDgsyimDQ6/6tfXcz63kZHoLvSdoxVLtJHpZFLpA55Yj65MhO0WgYh6/QzsPpSvt3dmWWNr5cQWYEGppK02wAZPzlttWQDIGGt6g+wdss7f9oSRGhB5KEs4JCqTtnYyQCImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767741885; c=relaxed/simple;
	bh=kbi25AN7J5KJOEyHPG4pOFTWqivq8V9VYd+c0YDMyg4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OXLlVCxEKfybeaib4TXNpRN6zzFo5nDqLFb2lXXlaTbPfOaxcdpaPaQFEWYrF0zRwm7b6tBN37LL1n7DuPXpf61L7GOce+kglEqjMW73gOLNR7g7OD75NWXhe/T1P72EubSP2Jr4hfA4P+8zoua3qFe58nZG3Kh+bs0NViCVwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hxq82pJH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767741883; x=1799277883;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kbi25AN7J5KJOEyHPG4pOFTWqivq8V9VYd+c0YDMyg4=;
  b=Hxq82pJHKeNpjWbi8WP44bidDHS0pkQ/+Ms9VBZMy8aUL0OoeMjKU5Zv
   uSWa9k4C1+YutPJ8dnFHAbUEGekPf5M7XsmoX3GKLwVqkJ1F4IwZsZCTj
   pM3ak4dya0jak8dgMqaIa4qomhsju6HdRGgyibm1DidgbNrFHcUtl7hP7
   iuX1cJtneajGH/HkWDz44TV0sgQcm9+3afAEGksXGk1qD8OBDVC0C88Pf
   z26Rh2HsEClADA4usew8eRKHOcpbiK2QpzqSUHAGECzJeMldkqS47i8gH
   RmmhzxWVB48yuqoNM69lzfGQu3ULIiEbEravjwpJ1GWhyHN0Wm0L4phFS
   Q==;
X-CSE-ConnectionGUID: KHrg+4b+T8+6Z/FXq8+DpQ==
X-CSE-MsgGUID: X5swP7GBTGOFxZLltlNwqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="56672321"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="56672321"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 15:24:42 -0800
X-CSE-ConnectionGUID: x30M/ogrRHajS00RnEcBug==
X-CSE-MsgGUID: taV9jgqFRTyH7/TcTIPNSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="203028852"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.247.173.62]) ([10.247.173.62])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 15:24:40 -0800
Message-ID: <e1d38d68f53302a150e11619b978d1b99d7590c2.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] platform/x86: ISST: Store and restore all domains
 data
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML	 <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Date: Tue, 06 Jan 2026 15:24:36 -0800
In-Reply-To: <39be18a6-d50e-e625-1347-7709cea78ea6@linux.intel.com>
References: <20251229183450.823244-1-srinivas.pandruvada@linux.intel.com>
		 <20251229183450.823244-3-srinivas.pandruvada@linux.intel.com>
	 <39be18a6-d50e-e625-1347-7709cea78ea6@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-01-06 at 11:44 +0200, Ilpo J=C3=A4rvinen wrote:
> On Mon, 29 Dec 2025, Srinivas Pandruvada wrote:
>=20
> > The suspend/resume callbacks currently only store and restore the
> > configuration for power domain 0. However, other power domains may
> > also
> > have modified configurations that need to be preserved across
> > suspend/
> > resume cycles.
> >=20
> > Extend the store/restore functionality to handle all power domains.
> >=20
> > Fixes: 91576acab020 ("platform/x86: ISST: Add suspend/resume
> > callbacks")
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > CC: stable@vger.kernel.org
> > ---
> > =C2=A0.../intel/speed_select_if/isst_tpmi_core.c=C2=A0=C2=A0=C2=A0 | 53=
 ++++++++++++---
> > ----
> > =C2=A01 file changed, 33 insertions(+), 20 deletions(-)
> >=20
> > diff --git
> > a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > index f587709ddd47..47026bb3e1af 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > @@ -1723,55 +1723,68 @@ EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_remove,
> > "INTEL_TPMI_SST");
> > =C2=A0void tpmi_sst_dev_suspend(struct auxiliary_device *auxdev)
> > =C2=A0{
> > =C2=A0	struct tpmi_sst_struct *tpmi_sst =3D
> > auxiliary_get_drvdata(auxdev);
> > -	struct tpmi_per_power_domain_info *power_domain_info;
> > +	struct tpmi_per_power_domain_info *power_domain_info,
> > *pd_info;
> > =C2=A0	struct oobmsm_plat_info *plat_info;
> > =C2=A0	void __iomem *cp_base;
> > +	int num_resources, i;
> > =C2=A0
> > =C2=A0	plat_info =3D tpmi_get_platform_data(auxdev);
> > =C2=A0	if (!plat_info)
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	power_domain_info =3D tpmi_sst->power_domain_info[plat_info-
> > >partition];
> > +	num_resources =3D tpmi_sst-
> > >number_of_power_domains[plat_info->partition];
> > =C2=A0
> > -	cp_base =3D power_domain_info->sst_base + power_domain_info-
> > >sst_header.cp_offset;
> > -	power_domain_info->saved_sst_cp_control =3D readq(cp_base +
> > SST_CP_CONTROL_OFFSET);
> > +	for (i =3D 0; i < num_resources; i++) {
> > +		pd_info =3D &power_domain_info[i];
> > +		if (!pd_info || !pd_info->sst_base)
> > +			continue;
> > =C2=A0
> > -	memcpy_fromio(power_domain_info->saved_clos_configs,
> > cp_base + SST_CLOS_CONFIG_0_OFFSET,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(power_domain_info-
> > >saved_clos_configs));
> > +		cp_base =3D pd_info->sst_base + pd_info-
> > >sst_header.cp_offset;
> > =C2=A0
> > -	memcpy_fromio(power_domain_info->saved_clos_assocs,
> > cp_base + SST_CLOS_ASSOC_0_OFFSET,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(power_domain_info-
> > >saved_clos_assocs));
> > +		pd_info->saved_sst_cp_control =3D readq(cp_base +
> > SST_CP_CONTROL_OFFSET);
> > +		memcpy_fromio(pd_info->saved_clos_configs, cp_base
> > + SST_CLOS_CONFIG_0_OFFSET,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(pd_info-
> > >saved_clos_configs));
> > +		memcpy_fromio(pd_info->saved_clos_assocs, cp_base
> > + SST_CLOS_ASSOC_0_OFFSET,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(pd_info->saved_clos_assocs));
> > =C2=A0
> > -	power_domain_info->saved_pp_control =3D
> > readq(power_domain_info->sst_base +
> > -						=C2=A0=C2=A0=C2=A0
> > power_domain_info->sst_header.pp_offset +
> > -						=C2=A0=C2=A0=C2=A0
> > SST_PP_CONTROL_OFFSET);
> > +		pd_info->saved_pp_control =3D readq(pd_info-
> > >sst_base +
> > +						=C2=A0 pd_info-
> > >sst_header.pp_offset +
> > +						=C2=A0
> > SST_PP_CONTROL_OFFSET);
> > +	}
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_suspend, "INTEL_TPMI_SST");
> > =C2=A0
> > =C2=A0void tpmi_sst_dev_resume(struct auxiliary_device *auxdev)
> > =C2=A0{
> > =C2=A0	struct tpmi_sst_struct *tpmi_sst =3D
> > auxiliary_get_drvdata(auxdev);
> > -	struct tpmi_per_power_domain_info *power_domain_info;
> > +	struct tpmi_per_power_domain_info *power_domain_info,
> > *pd_info;
> > =C2=A0	struct oobmsm_plat_info *plat_info;
> > =C2=A0	void __iomem *cp_base;
> > +	int num_resources, i;
> > =C2=A0
> > =C2=A0	plat_info =3D tpmi_get_platform_data(auxdev);
> > =C2=A0	if (!plat_info)
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	power_domain_info =3D tpmi_sst->power_domain_info[plat_info-
> > >partition];
> > +	num_resources =3D tpmi_sst-
> > >number_of_power_domains[plat_info->partition];
> > =C2=A0
> > -	cp_base =3D power_domain_info->sst_base + power_domain_info-
> > >sst_header.cp_offset;
> > -	writeq(power_domain_info->saved_sst_cp_control, cp_base +
> > SST_CP_CONTROL_OFFSET);
> > -
> > -	memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET,
> > power_domain_info->saved_clos_configs,
> > -		=C2=A0=C2=A0=C2=A0 sizeof(power_domain_info-
> > >saved_clos_configs));
> > +	for (i =3D 0; i < num_resources; i++) {
> > +		pd_info =3D &power_domain_info[i];
> > +		if (!pd_info || !pd_info->sst_base)
> > +			continue;
> > =C2=A0
> > -	memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET,
> > power_domain_info->saved_clos_assocs,
> > -		=C2=A0=C2=A0=C2=A0 sizeof(power_domain_info->saved_clos_assocs));
> > +		cp_base =3D pd_info->sst_base + pd_info-
> > >sst_header.cp_offset;
> > +		writeq(pd_info->saved_sst_cp_control, cp_base +
> > SST_CP_CONTROL_OFFSET);
> > +		memcpy_toio(cp_base + SST_CLOS_CONFIG_0_OFFSET,
> > pd_info->saved_clos_configs,
> > +			=C2=A0=C2=A0=C2=A0 sizeof(pd_info->saved_clos_configs));
> > +		memcpy_toio(cp_base + SST_CLOS_ASSOC_0_OFFSET,
> > pd_info->saved_clos_assocs,
> > +			=C2=A0=C2=A0=C2=A0 sizeof(pd_info->saved_clos_assocs));
>=20
> Why is the use of empty lines inconsistent between suspend and
> resume?

I will fix that.

Thanks,
Srinivas

>=20
> > -	writeq(power_domain_info->saved_pp_control,
> > power_domain_info->sst_base +
> > -				power_domain_info-
> > >sst_header.pp_offset + SST_PP_CONTROL_OFFSET);
> > +		writeq(pd_info->saved_pp_control,
> > power_domain_info->sst_base +
> > +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pd_info->sst_header.pp_offset +
> > SST_PP_CONTROL_OFFSET);
> > +	}
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL_NS_GPL(tpmi_sst_dev_resume, "INTEL_TPMI_SST");
> > =C2=A0
> >=20

