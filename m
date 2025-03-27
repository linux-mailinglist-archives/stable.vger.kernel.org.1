Return-Path: <stable+bounces-126855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E73A731D2
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 13:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE9B3ABC04
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D68D213259;
	Thu, 27 Mar 2025 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfVJ6vTs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66220A5CB
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 12:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743077127; cv=none; b=qY/4s6RMyKIE8ncMKHbDF5/WRLH7fH6wojb2RnHtZvs8rN1aA0cRLwsBgul3qq1+3kLsM08YzFQmlm3b0e0qeNWbnQlZ+q9bBteQXkzsdsIQWHzifYE4tciZeZfTcHLnTil4S6MOfyCoRsoU6U1rCn8ebGUkoOxC6fPcWJ7gayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743077127; c=relaxed/simple;
	bh=Q6fch+EhQlC0zvrbXFqCs27rgLnaij0KpF5jZcCQ26A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GQfH8FBg4PbcS5Cuewh+eFyYY6uzH7FO14hoGs8m11wxLH4ZlhC0o3cxpX1vnPxNhrPeyS2DWwS/uB5SiuiPN4+FWHjcMpfxt+DOSYVc0c2iQrAC59vdedzsXHqYscuGLaouOqVsoiaXDjcXBVcvOE9+v6YWYOK+Zl0QEmvBsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfVJ6vTs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743077126; x=1774613126;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Q6fch+EhQlC0zvrbXFqCs27rgLnaij0KpF5jZcCQ26A=;
  b=JfVJ6vTs8ceej5koZljM4JNAifXTejzSJxw8wjIEYlimAO/Eu96D9924
   kpr+SeViSuJ3lKXQL+dHbE3XyVFIODIgJ0GFHxhBHJxvfxt8uHWrr5ANs
   Ukg0z/fcH+K6sKqdol8gfb13vUTSWZIH2ttRMPJNj255FzF9dZF24UpU9
   qF44G/0XDVjkWO1NmzpkL4b3mWBpsgMUQ/OJI3M9wtKFlBVyxJGOkqw+o
   TMhGj3pk92dg7c4uBzPryrK7NQZx+zs/oPbFKqo+7SZRNNB2G/4HQF38C
   GeFYKvK1WWDB0MaUlHGgo9hehi15U9gzxbhM0Rk4FSZotzhp9b4XgxqhX
   g==;
X-CSE-ConnectionGUID: F2MuGeoEQvm10dm65R48Bg==
X-CSE-MsgGUID: tiYdC4EOTcy9kffTa7qXVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55405103"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="55405103"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:05:26 -0700
X-CSE-ConnectionGUID: zsjvQxW8S/6EpEIcpXifZQ==
X-CSE-MsgGUID: +VLjFLDMRUq7l+RtSNRoQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; 
   d="scan'208";a="125337195"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 05:05:23 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm: Remove redundant statement in
 drm_crtc_helper_set_mode()
In-Reply-To: <CAAhV-H6AecMYG0t-Ldxy68fm-_Wk4VjcdFfc-s6xwEeddUn-Ew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241111132149.1113736-1-chenhuacai@loongson.cn>
 <87o72lde9r.fsf@intel.com>
 <CAAhV-H6-yB5d8gXEH9TPHuzx0BJT+g8OCUmwTfSTTtqxfmcHDA@mail.gmail.com>
 <CAAhV-H7m0+-bHp0z0V+uySvBfPym4nMBCCTc5V80mYTfXjpuFA@mail.gmail.com>
 <CAAhV-H6AecMYG0t-Ldxy68fm-_Wk4VjcdFfc-s6xwEeddUn-Ew@mail.gmail.com>
Date: Thu, 27 Mar 2025 14:05:20 +0200
Message-ID: <871pui65mn.fsf@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Mar 2025, Huacai Chen <chenhuacai@kernel.org> wrote:
> Hi, Dave,
>
> Gentle ping, can this patch be merged into 6.15?

Pushed to drm-misc-next.

BR,
Jani.


>
> Huacai
>
> On Mon, Jan 13, 2025 at 10:13=E2=80=AFPM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
>>
>> Hi, Dave,
>>
>> Gentle ping, can this patch be merged into 6.14?
>>
>> Huacai
>>
>> On Mon, Nov 25, 2024 at 2:00=E2=80=AFPM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
>> >
>> > On Mon, Nov 11, 2024 at 10:41=E2=80=AFPM Jani Nikula
>> > <jani.nikula@linux.intel.com> wrote:
>> > >
>> > > On Mon, 11 Nov 2024, Huacai Chen <chenhuacai@loongson.cn> wrote:
>> > > > Commit dbbfaf5f2641a ("drm: Remove bridge support from legacy help=
ers")
>> > > > removes the drm_bridge_mode_fixup() call in drm_crtc_helper_set_mo=
de(),
>> > > > which makes the subsequent "encoder_funcs =3D encoder->helper_priv=
ate" be
>> > > > redundant, so remove it.
>> > > >
>> > > > Cc: stable@vger.kernel.org
>> > > > Fixes: dbbfaf5f2641a ("drm: Remove bridge support from legacy help=
ers")
>> > >
>> > > IMO not necessary because nothing's broken, it's just redundant.
>> > Maintainer is free to keep or remove the Cc and Fixes tag. :)
>> >
>> > Huacai
>> >
>> > >
>> > > Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>> > >
>> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> > > > ---
>> > > >  drivers/gpu/drm/drm_crtc_helper.c | 1 -
>> > > >  1 file changed, 1 deletion(-)
>> > > >
>> > > > diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/d=
rm_crtc_helper.c
>> > > > index 0955f1c385dd..39497493f74c 100644
>> > > > --- a/drivers/gpu/drm/drm_crtc_helper.c
>> > > > +++ b/drivers/gpu/drm/drm_crtc_helper.c
>> > > > @@ -334,7 +334,6 @@ bool drm_crtc_helper_set_mode(struct drm_crtc =
*crtc,
>> > > >               if (!encoder_funcs)
>> > > >                       continue;
>> > > >
>> > > > -             encoder_funcs =3D encoder->helper_private;
>> > > >               if (encoder_funcs->mode_fixup) {
>> > > >                       if (!(ret =3D encoder_funcs->mode_fixup(enco=
der, mode,
>> > > >                                                             adjust=
ed_mode))) {
>> > >
>> > > --
>> > > Jani Nikula, Intel

--=20
Jani Nikula, Intel

