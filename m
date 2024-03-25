Return-Path: <stable+bounces-32169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322DB88A46F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 15:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF19E2E401B
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0B16EC1D;
	Mon, 25 Mar 2024 11:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITddNt0z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF68A12883A
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362740; cv=none; b=MVBpeO2MtGM5AZX+7ok4KwL39LvrME3hUNkdt3/9yq8mTpHuhZefwgdGyVaN/MgUH53UINZCyuFw3Jr1C4CrY/74pJV6cbN5PfabnkyA42Dm6xHXn6m85f/efZNaY1D5Z9pxTDUmEvfKO6LuTC4vBiuhQ9O+F0cODpRo0IUcmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362740; c=relaxed/simple;
	bh=/7yLriuhvRcFxs/cJwyFfIpn2d65gbmkfqddeVZbCcA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l7aSP0r5jpxzOZ6FaxOTc2wWbA+wQVOE0E52bMJOnLSq9p7VQfVFzU54SZQ3ceZZSleIuwZR1fvJGpdOeBtlnQa4zeNBqJuhsRLSCVvR8V2TCuA7E8sS/jGGbwMSMzAWRU+9wZC50mV6FCglr1ZJ2+GDUJ5cCI6ZL++FSEgWjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITddNt0z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711362738; x=1742898738;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/7yLriuhvRcFxs/cJwyFfIpn2d65gbmkfqddeVZbCcA=;
  b=ITddNt0zW8h8RzRnZcCph1nHtRihC5Xtl5YAjz0VxfRfYBQ98C02nlq/
   HNhzCwUf/sE/Xu01Do/oDPDNyNWD0kaVWEgKXRRPfbmt6FnB7nfiY+/pM
   o0SZ9P9gN518w7PH/C5zgpwNqA3QO4B94FmTYxJl9POch8HNeFwz7h6VR
   QISWtNJXOA+O86Jcijwto3xe5SNPLGRZrDH28y/qyjXdcm/aBsKSNzCXa
   npnqkh9isw6xXZj6CKjhcOdknQoAfwVnhGGi0fIdbeVmNEuMmXT2BHOxj
   REItU/7ZkMS6LTNeqedMZaBaqFfA0ftEeihhlt4VCaaJJYwBQhn3tBz+C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6461923"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6461923"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="15657281"
Received: from idirlea-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.171])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:32:13 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/i915/bios: Tolerate devdata==NULL in
 intel_bios_encoder_supports_dp_dual_mode()
In-Reply-To: <ZfnVUbHNL4lEeinV@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240319092443.15769-1-ville.syrjala@linux.intel.com>
 <87sf0mo9hx.fsf@intel.com> <ZfnVUbHNL4lEeinV@intel.com>
Date: Mon, 25 Mar 2024 12:32:10 +0200
Message-ID: <871q7yk3f9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Mar 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Tue, Mar 19, 2024 at 11:29:14AM +0200, Jani Nikula wrote:
>> On Tue, 19 Mar 2024, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
>> > From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> >
>> > If we have no VBT, or the VBT didn't declare the encoder
>> > in question, we won't have the 'devdata' for the encoder.
>> > Instead of oopsing just bail early.
>> >
>> > We won't be able to tell whether the port is DP++ or not,
>> > but so be it.
>> >
>> > Cc: stable@vger.kernel.org
>> > Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10464
>> > Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>> > ---
>> >  drivers/gpu/drm/i915/display/intel_bios.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/i915/display/intel_bios.c b/drivers/gpu/d=
rm/i915/display/intel_bios.c
>> > index c7841b3eede8..c13a98431a7b 100644
>> > --- a/drivers/gpu/drm/i915/display/intel_bios.c
>> > +++ b/drivers/gpu/drm/i915/display/intel_bios.c
>> > @@ -3458,6 +3458,9 @@ bool intel_bios_encoder_supports_dp_dual_mode(co=
nst struct intel_bios_encoder_da
>> >  {
>> >  	const struct child_device_config *child =3D &devdata->child;
>>=20
>> The above oopses already.
>
> Nope. It's just taking the address of the thing.

I guess. Still looks a bit suspicious. :/

Reviewed-by: Jani Nikula <jani.nikula@intel.com>


>
>>=20
>> BR,
>> Jani.
>>=20
>> >=20=20
>> > +	if (!devdata)
>> > +		return false;
>> > +
>> >  	if (!intel_bios_encoder_supports_dp(devdata) ||
>> >  	    !intel_bios_encoder_supports_hdmi(devdata))
>> >  		return false;
>>=20
>> --=20
>> Jani Nikula, Intel

--=20
Jani Nikula, Intel

