Return-Path: <stable+bounces-5352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8780CAFA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB705281E19
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657023E498;
	Mon, 11 Dec 2023 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPMJgbJp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B5EB3
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 05:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702301288; x=1733837288;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=wSWycREeIH2yUgdl0B6zT1fgxOfBJPGGgpeEBNkOR80=;
  b=aPMJgbJps93W6wT4hHvaVtXYiq8VowodPg2sFCTBNulxPA/GVhL/tsRd
   Y94M24e99a0wqp228XzOn/wrfVZ5hYnG5rKyVkn/EAsE1+vS+6GhuFhaH
   ovp2/CsCC6cRnnsI0Tcm68/ESmeDBWmEWTZNtGBUzv28hw3IhklgytrdI
   VW3wcOUCjeK8xJT9x4ucy08+a1lDQJhCfU4HB5f9o+CKirQWqAq3pMvlV
   88e/u14Zp6iNJGN8PP05B9+UfCt29CVH4MfUGQexw2SGuzuXptfqOKyas
   dv4jRXyqMg0RWglyUiMqI3a72MUhoCI/AKbdK1Mdx9x+dMrJkMQPG50Bd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1714643"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1714643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 05:28:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="946323337"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="946323337"
Received: from kbalak2x-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.63.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 05:28:06 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, bbaa <bbaa@bbaa.fun>,
 intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH] drm/edid: also call add modes in EDID
 connector update fallback
In-Reply-To: <ZXNfu6zcBy3JvbGd@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20231207093821.2654267-1-jani.nikula@intel.com>
 <ZXNfu6zcBy3JvbGd@intel.com>
Date: Mon, 11 Dec 2023 15:28:03 +0200
Message-ID: <87edfsyil8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 08 Dec 2023, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Thu, Dec 07, 2023 at 11:38:21AM +0200, Jani Nikula wrote:
>> When the separate add modes call was added back in commit c533b5167c7e
>> ("drm/edid: add separate drm_edid_connector_add_modes()"), it failed to
>> address drm_edid_override_connector_update(). Also call add modes there.
>>=20
>> Reported-by: bbaa <bbaa@bbaa.fun>
>> Closes: https://lore.kernel.org/r/930E9B4C7D91FDFF+29b34d89-8658-4910-96=
6a-c772f320ea03@bbaa.fun
>> Fixes: c533b5167c7e ("drm/edid: add separate drm_edid_connector_add_mode=
s()")
>> Cc: <stable@vger.kernel.org> # v6.3+
>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>
> Reviewed-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

Thanks, pushed to drm-misc-fixes.

BR,
Jani.

>
>> ---
>>  drivers/gpu/drm/drm_edid.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index cb4031d5dcbb..69c68804023f 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -2311,7 +2311,8 @@ int drm_edid_override_connector_update(struct drm_=
connector *connector)
>>=20=20
>>  	override =3D drm_edid_override_get(connector);
>>  	if (override) {
>> -		num_modes =3D drm_edid_connector_update(connector, override);
>> +		if (drm_edid_connector_update(connector, override) =3D=3D 0)
>> +			num_modes =3D drm_edid_connector_add_modes(connector);
>>=20=20
>>  		drm_edid_free(override);
>>=20=20
>> --=20
>> 2.39.2

--=20
Jani Nikula, Intel

