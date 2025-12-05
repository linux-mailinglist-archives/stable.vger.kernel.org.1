Return-Path: <stable+bounces-200196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB081CA90D2
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 20:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6041305483F
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA39334847A;
	Fri,  5 Dec 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3Z9VSVx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAD2D29D6;
	Fri,  5 Dec 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764961449; cv=none; b=hrijEpBSaWZTPkwojWAOvVvqjLbB7gEg6A7kw5pjVWb2UoDNu3S+vxqB0yVB7NBf8AJcfTOuCKFL9iK9QGagWz4OaUN1CBQLs+TAv3PkCDz88JUJy65+JYDO/YZwKcoPWLT3tHFznLlIIQmzmDhcagpozU/PaTmwyQGl2g1ZkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764961449; c=relaxed/simple;
	bh=RqoSCoqqr2QqQUqBJqSkZPQ1MI2I406/gNl9u9r4O9Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hHki2ViBt0kwPOIXjSD6JLvMacgU4RgDRfncOWTBRi2Wl7wPeqi9laY3sbVG98Pqx+PNRsriRyMPQg67AtZeNcDdB3ZKwMm75sClsWXUehChfckqPs0juoHfGPnbX3oMZ+MuwH+vDvayYvWf1XvQEBsJlebydVLCDcvK0Y1qeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3Z9VSVx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764961448; x=1796497448;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RqoSCoqqr2QqQUqBJqSkZPQ1MI2I406/gNl9u9r4O9Q=;
  b=U3Z9VSVxyACxNHIGeLZ9Xam9cgpvOa06uYAui6K7ddPwtgG+Xd6HgI3G
   v/VNX4FQGKZ9vybINpQucOnCx9sH8vOts2RXGTlu6DGBEIGQ07uBVp32+
   5NR+NHPukuc3Fl4PD0O+ayzHETdVxjsNUEWVR3BdrqLat7y1v9Lr05pMx
   XmoQua8CJQ3Cz4VU9RWYlz7M+Xo+1KY3qY85lHM7gXkeP+pcHSuQL4okH
   lmJUSYkyPNBFCnNJwO6Orx9QtK5k75R1ug0hCzlVVykQTeCY1mZpELfxz
   x5omUHNjqqzNwrZ7TDtsfZim9oFqZrfNCOeQxYvlrhB+Ln3smgnhLkSME
   A==;
X-CSE-ConnectionGUID: y5/43X9KRGuzcFXXhNzKig==
X-CSE-MsgGUID: jc3lDzUoTo2HMOmnXMK2/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="67038189"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="67038189"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:04:07 -0800
X-CSE-ConnectionGUID: gaNsaobdQKm6E0sE1nA+EQ==
X-CSE-MsgGUID: Tj9WHlwUTO2k/DBVaS3Ghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="226377110"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 11:04:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 5 Dec 2025 21:04:01 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    Dell.Client.Kernel@dell.com, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 0/3] platform/x86: alienware-wmi-wmax: Add support for
 some newly released models
In-Reply-To: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
Message-ID: <49c9bab4-520f-42ca-5041-8a008b55f188@linux.intel.com>
References: <20251205-area-51-v1-0-d2cb13530851@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-956674157-1764961441=:10736"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-956674157-1764961441=:10736
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 5 Dec 2025, Kurt Borja wrote:

> I managed to get my hands on acpidumps for these models so this is
> verified against those.
>=20
> Thanks for all your latest reviews!
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

You don't need to signoff the coverletter. :-) (Hopefully it won't=20
confuse any tools but I guess they should handle duplicate tags sensibly=20
so likely no problem in this case).

For the series,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

> ---
> Kurt Borja (3):
>       platform/x86: alienware-wmi-wmax: Add support for new Area-51 lapto=
ps
>       platform/x86: alienware-wmi-wmax: Add AWCC support for Alienware x1=
6
>       platform/x86: alienware-wmi-wmax: Add support for Alienware 16X Aur=
ora
>=20
>  drivers/platform/x86/dell/alienware-wmi-wmax.c | 32 ++++++++++++++++++++=
++++++
>  1 file changed, 32 insertions(+)
> ---
> base-commit: 9b9c0adbc3f8a524d291baccc9d0c04097fb4869
> change-id: 20251111-area-51-7e6c2501e4eb
>=20
>=20

--=20
 i.

--8323328-956674157-1764961441=:10736--

