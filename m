Return-Path: <stable+bounces-211248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLUEECY9cmnpfAAAu9opvQ
	(envelope-from <stable+bounces-211248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:07:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E7A68601
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5A6F3038F7B
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D459A349AEE;
	Thu, 22 Jan 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmQK8cyK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFF34B425
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094047; cv=none; b=deQTxA1k7uYjzdMTTt0xho3PZYOzAGuNhwIx+sRazRp1QmCz6JFqx/eYlVeeSo8lpRojtpZY70v26oUojs+O9rAM9LforppdOhPbtkfWXigDptrjb/Zs5/qXg1qjL4Z3bAz+PFm1yegaklOxNjEiheVHOFTNH+24rIpwhlK94lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094047; c=relaxed/simple;
	bh=AW6QW16cZw4eS2w4tFK4qEp001q0jxR721JZGa9TE8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2+gLgFtOKDNqEawsFqUNDj+oU0UrMi5S2GKmgT1GjQsZ7Vk4pZHy7kHhxQciK/2E7fXkfTNcoted+dGi9iEGRgJCTU+ttyiZbM84a4VKrnNtGT7akM5i88CTKK7laX+7QehK6bAVzXWeET7uGNKKH6Hk5Cm/exQbxFnpc53+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmQK8cyK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so14679945e9.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769094044; x=1769698844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDIGcrQeI7TUl53A1tKBQGSWEsAoREmDHrcAi67WNyY=;
        b=BmQK8cyKDsmehjbotknkAjl1E/aINQCQ7AcE9aPOcMVOwQSMLda8dyfl1+G+HLxSxx
         S4tyIZhTpHpFyOLivSZJnZUpifsGEKJqavjtwK42x7PmiT00CQ9V5SzVzHyI9wVB1B/M
         sGdXY/nO9q+4aqyZnLLC2No2iSnUBSUoOzfpvBNqKn7zyj7AyeKyD1pLChruSq1KGtWK
         gtzIDR8GiHO0PS/OB91gcW1AKkw15yMZ70GarAWHzdWjBuxhylF6k0b/OgHvBHv4V1Gy
         0ZWZA7n1yiNkpp0GDnOvqcfbunpTNZI8ev7fXNTfVGxuaUtis8EOdApmTxNJw/gwUzGu
         vZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094044; x=1769698844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FDIGcrQeI7TUl53A1tKBQGSWEsAoREmDHrcAi67WNyY=;
        b=jhN5WoXbz+rHFlDCc9mQJiYblxsWSW+fSsFtjxbDvg3znkqYsxefdym9333P5DuWT5
         lIEYFkJjrvwSTwkabk2xrDw9oPW4yKUvXftRQeuUDrDVGODqIaLlj18TPCbMhanYJ9dt
         IVkH+SBbnEieNGcS4MwVnkcVRkxJlHUHW1qVxj27ssazfFsEGHHxu+pNG+7YoWbh130c
         Sw1e1NyhDUp0vXe4v8heNCwjROTwwOX/KLrobXd2I6iHrX/tVUhiZiFfDJ+0QgXtNcIq
         iDH2sDzrMhHnvDsVSGqL/ht0P0SyMh03A98KEzqVo7BBf2zmS4c2coU43V8iqTD1JvH3
         T9uw==
X-Forwarded-Encrypted: i=1; AJvYcCW2JpOhUy5xKabsQdSK7ISbk9SyXK2qE6UrvlOxtr2tmXLWxwaci3cffBZH6w5wVYKoQOUWWK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTv7o5lADnvRtZQxPFcR311Ck7n5T15vmaoPrgf08b5z8Rp8oK
	R1fzqFS0U395CdBly0lxgAVlfaHBzfdDzLCnBChGqR6KUdmLeR13INT8
X-Gm-Gg: AZuq6aJb+0X1lk+Y0cm78/akahoirPdF64cmRH9HSKEHtWZFuHozfWCVTkf32oP5Boz
	6OVOnRqmHy+iZb3HMqiZvw0NPLJYzo3TZdgKb2XLI6g2qUAGKQwnUW5jWuARDrbVHI8FFDTrcHY
	ueubSL0eUSDqndrx02DAKQNhYrrZXL3Xa3a6hvIoRDXwHGBfwOrcus72i9w3oKsSETf3hyW7foE
	wYrXdI8eUp/jzskls3/PWwZPHE7jrHjFXZFx7SzGcFH0YpwRUSU+mLaLmMPcn5DYPVm8evWEO8d
	IKy4tH66aOaVOLGn6FTW5HocSbmGYP0avrFoISdTm1IksSkduYDVpq1oQA6R7ouymr5H2kptjHp
	ni1YIOgDq+ys4XmcV/jMHN0Fa2LbMSz9ovvcKHA5TBgipzsfFm1JBSmgbYUlNIiin/ElhiO3NKk
	5fJoz4BBBh1AoCmrF9DHu+0umOx5cGNx0IbxgW97zuub7WlIy9+LyeQQks
X-Received: by 2002:a05:600c:a013:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-4803e7f0e39mr144220535e9.30.1769094043496;
        Thu, 22 Jan 2026 07:00:43 -0800 (PST)
Received: from timur-hyperion.localnet (5400182B.dsl.pool.telekom.hu. [84.0.24.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470cf1acsm72039655e9.14.2026.01.22.07.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:00:42 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jon Doron <jond@wiz.io>, stable@vger.kernel.org,
 "Lazar, Lijo" <lijo.lazar@amd.com>
Subject:
 Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
Date: Thu, 22 Jan 2026 16:00:41 +0100
Message-ID: <4882409.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
References:
 <20260121182447.2434085-1-alexander.deucher@amd.com>
 <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211248-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[timurkristof@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wiz.io:email,gitlab.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 79E7A68601
X-Rspamd-Action: no action

On Thursday, January 22, 2026 6:07:27=E2=80=AFAM Central European Standard =
Time Lazar,=20
Lijo wrote:
> On 21-Jan-26 11:54 PM, Alex Deucher wrote:
> > From: Jon Doron <jond@wiz.io>
> >=20
> > On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
> > ih2 interrupt ring buffers are not initialized. This is by design, as
> > these secondary IH rings are only available on discrete GPUs. See
> > vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
> > AMD_IS_APU is set.
> >=20
> > However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
> > get the timestamp of the last interrupt entry. When retry faults are
> > enabled on APUs (noretry=3D0), this function is called from the SVM page
> > fault recovery path, resulting in a NULL pointer dereference when
> > amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
> >=20
> > The crash manifests as:
> >    BUG: kernel NULL pointer dereference, address: 0000000000000004
> >    RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
> >   =20
> >    Call Trace:
> >     amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
> >     svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
> >     amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
> >     gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
> >     amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
> >     amdgpu_ih_process+0x84/0x100 [amdgpu]
> >=20
> > This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
> > IP 9.3.0 from noretry=3D1") which changed the default for Renoir APU fr=
om
> > noretry=3D1 to noretry=3D0, enabling retry fault handling and thus
> > exercising the buggy code path.
> >=20
> > Fix this by adding a check for ih1.ring_size before attempting to use
> > it. Also restore the soft_ih support from commit dd299441654f
> > ("drm/amdgpu:
> > Rework retry fault removal").  This is needed if the hardware doesn't
> > support secondary HW IH rings.
> >=20
> > v2: additional updates (Alex)
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
> > Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jon Doron <jond@wiz.io>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> > 8e65fec9f534e..243d75917458a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct
> > amdgpu_device *adev, uint64_t addr,>=20
> >   	if (adev->irq.retry_cam_enabled)
> >   =09
> >   		return;
> >=20
> > +	else if (adev->irq.ih1.ring_size)
> > +		ih =3D &adev->irq.ih1;
> > +	else if (adev->irq.ih_soft.enabled)
> > +		ih =3D &adev->irq.ih_soft;
>=20
> Faults are delegated to soft ring when retry_cam is enabled -
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/dr=
ive
> rs/gpu/drm/amd/amdgpu/amdgpu_gmc.c#L541

Hi,

As far as I know the retry CAM is not available on APUs.
Please correct me if I'm wrong.

Thanks,
Timur

>=20
> That matches with the original logic in d299441654f ("drm/amdgpu: Rework
> retry fault removal").
>=20
> To match exactly with the logic in above commit, I think it should use
> soft ring only when retry cam is enabled. Presently, it's returning
> without doing anything.
>=20
> Thanks,
> Lijo
>=20
> > +	else
> > +		return;
> >=20
> > -	ih =3D &adev->irq.ih1;
> >=20
> >   	/* Get the WPTR of the last entry in IH ring */
> >   	last_wptr =3D amdgpu_ih_get_wptr(adev, ih);
> >   	/* Order wptr with ring data. */





