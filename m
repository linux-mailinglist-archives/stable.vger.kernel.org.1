Return-Path: <stable+bounces-183678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D9BBC8647
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A13A927C
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D90A266584;
	Thu,  9 Oct 2025 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QipIsMDa"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7412A1CA
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760004058; cv=none; b=e9l5Gu67otou3wRui3DktLQ5JvHRE0eJvyVwDL5P7x494HbqYibtUnndQxiMNWVIoMv+C2tHDcxlYPUbLVNVDgbuGE+zNZzqCvsN9lq+JT6DC10PM+UeYrIl4LOXLBBkwvIh43s+kFBSdYMafpmz2yS6ACE8JCyRYgp5gcMQl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760004058; c=relaxed/simple;
	bh=8pRBn/pEda3RCBzr2ShV8B4AiuOg85LHHaiMsOGogQI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=R7qu9IjhRdiWDAwF4T9krCXCkKxH8+L/js3uMs8t51JeR0pe9Hd8PxwBqWaHsJSUrI5gcKOJwFuQVgKVT6ACWMIBWYwFtQ3TH+Wrk2qUrC/yDY/xShkoC4WxBqi2j7uJDXYw4HuRWaMBJfcUH8CBx0KtvNm6dP1HdaCBovjl/Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QipIsMDa; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760004044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuzURPilJo8vSvl9gt8w8y9Vtfs9Spi+7eSfOYFI33w=;
	b=QipIsMDaJcGV9bsCDokhOdNGdUc6jZSsf2INwXRIW9bdGNEwlnCaast9vDdVCi1F91RaQt
	AZvs5rfQ00FkOoKQphXEOe0ejvI2/xp+SydIHWCO9WF31PLBjppDBLA6DjmpF8E84ZLLku
	+avMO6ua58zXywGY1xTVRnO6T5ChkNg=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Revert "drm/amd/display: Only restore backlight after amdgpu_dm_init or dm_resume"
Date: Thu, 9 Oct 2025 12:00:29 +0200
Message-Id: <F64C306E-67BC-4ADC-AF8F-1DACAF695D9D@linux.dev>
References: <2025100931-retorted-mystified-bd52@gregkh>
Cc: harry.wentland@amd.com, Christian.Koenig@amd.com, sunpeng.li@amd.com,
 airlied@gmail.com, simona@ffwll.ch, Alexander.Deucher@amd.com,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 regressions@lists.linux.dev
In-Reply-To: <2025100931-retorted-mystified-bd52@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT


>=20
> On Oct 9, 2025, at 11:51=E2=80=AFAM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
>=20
> =EF=BB=BFOn Thu, Oct 09, 2025 at 11:23:01AM +0200, Matthew Schwartz wrote:=

>> This fix regressed the original issue that commit d83c747a1225
>> ("drm/amd/display: Fix brightness level not retained over reboot") solved=
,
>> so revert it until a different approach to solve the regression that
>> it caused with AMD_PRIVATE_COLOR is found.
>>=20
>> Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgp=
u_dm_init or dm_resume")
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
>> 2 files changed, 4 insertions(+), 15 deletions(-)
>=20
> <formletter>
>=20
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html=

> for how to do this properly.

Apologies, I was a bit confused by:

If a regression made it into a proper mainline release during the past twelv=
e months, ensure to tag the fix with =E2=80=9CCc: stable@vger.kernel.org=E2=80=
=9D

in the regressions page, but I see now the way I did it via email cc was inc=
orrect.

Should I resend with that fixed?

>=20
> </formletter>

