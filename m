Return-Path: <stable+bounces-238242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNseEaNZ4GmsfQAAu9opvQ
	(envelope-from <stable+bounces-238242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:38:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E4409FCD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 05:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0F63076DC1
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 03:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972B83002DD;
	Thu, 16 Apr 2026 03:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mywj4rp9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05519D093
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776310681; cv=pass; b=AqXuxCmvXcNIvI+pIzJFNLC4kNgvMYzjIwkCMTT1XNlBg1p7t34NAN3PYO3eObrg14f/qMN7hwnpjTrCE/ZI/2xJiaAR6tFv2iOvYlpdCAf05q+9m9SwA5/xSvFtLkU8Zq0UjWucOCu7vYp4DUe0fRYElUqUzqdZZhGMQHMJPG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776310681; c=relaxed/simple;
	bh=C8PZGig8l7zbLiK6cSt1Ax2mHoN3XwJKs+wjkaXaPCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbDDvdQxJSo9I98nuKx2V+OelnXU3vlmOtna5eTpXzFh4WU7ujeHcu2xMOiRvXVuVMtjCbpVSHVbuxElBM6g7rDlLaUzWXMX5UTbdXepTnDAsQob8nqQ77S5mRzPbHWe/hT5RhcWOXDYDtDl2G7mXogC5JxSQ4thQB6tJ5bDNJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mywj4rp9; arc=pass smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-7b186dfc1d0so3338287b3.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 20:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776310678; x=1776915478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=II7mrYt4xuIuJQAivYitgL6u5da+41h7arYixoqJr6o=;
        b=ERsOAEOAwIUmiua2JXch6PVueVqp/3V3/zkTL2OruvtSoWbv+Ipt6NQoUs+CHu3rDD
         rsTyHwyG7W6RmtJ+K3+WC/QOVfGy2R0SZmGCAV7H370vbe8xa4nhgMgoAcalD77/lr2v
         nvZW0AvbLda3zBYFRjGvmvZp+j08mDYOiDXGQkwXyPO7DSyol0TLfYPV8tu0EdIh/KvO
         1jGcDRpShBh+IkNNkG1sNtAg9j3bc/etULeF2GnSa5zkoJglNaYecQuTxGO2L/G5MDco
         k+5xGAtSy6duMjvUEMIpZDLFnO6AMyzEl4UBWSK14T/K1lkqhP7sBxLp4Io4LRv50sEU
         seJg==
X-Forwarded-Encrypted: i=2; AFNElJ/W10bATw/Ny4qfEfaUBDDCY9KaQK2tEMkvbqOrTr1dvRFO/rvtmn592kjmmP1/AoHzxOZCbrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2quuFRG6ZnMZ0JpCRYDBWYxuVYhaTyF/NPtRLtVd02naxJua
	vojlXp4QMV2YH6S9Yip5gudeP+DLsoiEzShJN8D5GT7GtGEbPG5wAor/+LwvsQ6hdeEOcrBdVDf
	7oolMz/yZWxcj9+lBAw6CYxeANXoAgPli65/yWWnbuaZ/Gax38E3OPSoaOMyrWoXubnE2zREa6E
	b9nS8Z5uDM8oeuINLm+w6gu0fgIi1/pQrlmr+fC2hl2/JBA4ZXGCC1nwmRBffF1Uac/syvcrF0k
	yV298Bv
X-Gm-Gg: AeBDiesDR8C3JcQk6Sfp84ZF3NaKk1UCEWqkpicn7cyJRY/QZRxHaykIqmBq+PEFNnB
	dBicm02Tn/zrXuH+K6t5NnMJoC6u3hwNGwBPhVJnh7oFCQjTaaS4OtUnCUw/sqvFj5YNrSSUUGi
	HbQcFwX3tThC1RcJzATYJ0WPBANtkhjyKA2M8laDpPr22wqsgO9yHWTxAnH3BThuykKu74JZ8kM
	798ujgvyUhmODZmZ0HJpk//WwU1JB+gPTvPc0Io8/Es6nRjxY1qLFjEvrBPicxriTdW10GMIJhs
	3WTvLOy4AK5xtV8PaMkNl5BUOozFMYWTW77ENpm0wVJ/eixNxqzoQg3XqJXUStT7IWyQopAJbSx
	KW77hW2JwnFNQZu0hcYv8QVgbAkXKmMEPso2x4Ckpjo5b2t2ySZq/Ayb69QNKOMeLSdroiZgQsz
	XylSDF9y/YUhwc4WRSkSWvo+Ar2gfv0JfPuLm6CXhteLLoDPWyoAV2CICodkDn06XpjtM=
X-Received: by 2002:a05:690c:11:b0:79b:e346:9813 with SMTP id 00721157ae682-7b863371d76mr19719467b3.10.1776310677789;
        Wed, 15 Apr 2026 20:37:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-652e47d3fb4sm231182d50.29.2026.04.15.20.37.57
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2026 20:37:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a3fdf4491bso3110012e87.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 20:37:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776310676; cv=none;
        d=google.com; s=arc-20240605;
        b=bRqw2KrgFdUOThZumVuqobWDF2UxuF+vgvq9DrNVYd7joxX7dIFPCgstJBmNCk4ptQ
         5gpFJ/OwEBKkpwOPFbYLfR7nK047TbwS3/cAsQwMOvVQZ3hMMOWk/cDDBxnqREBslVpp
         vFB10OP/OaCcDaafCcTiw1Xnrn8PXK7tyWbgsySMCx8C8/sTiYlzgRcdT6/JvaVnEYyC
         vzlYuxJIoDM7NscC00OrUoJrCR0+nFKEG+4eaDjocVTD7HpGtjTTKnKJ3NKmdaZ9c3XR
         T1czxoK4rlXjQBXS1sYyLwfKcEUxY3wLcu3WCR3a9kRlSiuaZQs0lfUKjvZYYdnoMI3Y
         mTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=II7mrYt4xuIuJQAivYitgL6u5da+41h7arYixoqJr6o=;
        fh=ThBVm8APDcrEO0mY655FKtd+kzTBj/Cauv0Cfv6vm90=;
        b=aDdM+m4I9iOOibuqTD/lj8r1fLpjmGgUdSCYUPrwcpEqejltX4M62CCD6xKrsvhdyO
         B/k8cCnQDkWxJfizyYvVtPh3v3S2L9MDhCz+Q8y9b0YrVIejeaTYeqePYDL8HHpFOvBV
         bjGD59Js1Xl6SaV3rvmiZwGbSMJTsyhzIxSyXCLhXFdz4V4tJksDf6Rusyz3HWnTM9/N
         gJtDkWxdEuYR+XcuEozNN476J0oRcIreiiwVUoDLuNjrcgd2h6Kl+1uP7/mxIaF3tUKw
         TA6h5/AIaQji1CP4HO21JTYUn5AeB0Nv56Ovtk2YJZhvW2wJPbY0cbG9EJgY24aG9oJQ
         AYAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776310676; x=1776915476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=II7mrYt4xuIuJQAivYitgL6u5da+41h7arYixoqJr6o=;
        b=Mywj4rp9kN4wTU/glbtFfB0UkBsG8GnVo5juVFBERJYwlidchJku5IprEawneQFJ7P
         IIzmyIf7wibOVOVNGAPLGVnUtPOk7nxSKOiKPD0Kd11C5x3n56iI2Y+mFC/LJlQnjj07
         0kNYH5PXyqvXdE56aJHzv7bfP/CUYJYHYpTq8=
X-Forwarded-Encrypted: i=1; AFNElJ9ijy9hdfI4/hnPwq7sJDC8AsfYuUrM4gtSPmCxJJrHjfFfMPNH5d2nAmzXVsgXKQpQltEt5PQ=@vger.kernel.org
X-Received: by 2002:a05:6512:3e28:b0:5a2:ad98:3685 with SMTP id 2adb3069b0e04-5a3efd90bbfmr7195892e87.35.1776310675913;
        Wed, 15 Apr 2026 20:37:55 -0700 (PDT)
X-Received: by 2002:a05:6512:3e28:b0:5a2:ad98:3685 with SMTP id
 2adb3069b0e04-5a3efd90bbfmr7195870e87.35.1776310675337; Wed, 15 Apr 2026
 20:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414105529.9883-1-popov.nkv@gmail.com> <ecf4cd01-b05d-4f51-943a-631cc4b27331@amd.com>
 <CABQX2QMH2XFcuz00DQQWU4uKw2B8OzE4rCE5=8LMXDg4t0AqWQ@mail.gmail.com> <9a33c8b4-64f1-400f-b8a0-0972ea5b5ecf@amd.com>
In-Reply-To: <9a33c8b4-64f1-400f-b8a0-0972ea5b5ecf@amd.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 15 Apr 2026 23:37:41 -0400
X-Gm-Features: AQROBzBeTXAsyPXmmTJlvmAfqcZclh41H9HUgy916nOi9mKbcOMPsijik6exNAU
Message-ID: <CABQX2QPatyzmoTJYv3C52aUfE2qS4bEr-01J5XbQnay94vs1Cg@mail.gmail.com>
Subject: Re: [PATCH 15901/15901] drm/vmwgfx: fix NULL pointer dereference in vmw_validation_bo_fence()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: popov.nkv@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linaro-mm-sig@lists.linaro.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org, Ian Forbes <ian.forbes@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dff1dc064f8b8e96"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238242-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linaro.org,linuxtesting.org];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E13E4409FCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000dff1dc064f8b8e96
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 3:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/15/26 03:08, Zack Rusin wrote:
> > On Tue, Apr 14, 2026 at 9:25=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 4/14/26 12:55, popov.nkv@gmail.com wrote:
> >>> From: Vladimir Popov <popov.nkv@gmail.com>
> >>>
> >>> If vmw_execbuf_fence_commands() call fails in
> >>> vmw_kms_helper_validation_finish(), it sets *p_fence =3D NULL. If
> >>> ctx->bo_list is not empty, the caller, vmw_kms_helper_validation_fini=
sh(),
> >>> passes the fence through a chain of functions to dma_fence_is_array()=
,
> >>> which causes a NULL pointer dereference in dma_fence_is_array():
> >>>
> >>> vmw_kms_helper_validation_finish() // pass NULL fence
> >>>   vmw_validation_done()
> >>>     vmw_validation_bo_fence()
> >>>       ttm_eu_fence_buffer_objects() // pass NULL fence
> >>>         dma_resv_add_fence()
> >>>           dma_fence_is_container()
> >>>             dma_fence_is_array() // NULL deref
> >>
> >> Well good catch, but that is clearly not the right fix.
> >>
> >> I'm not an expert for the vmwgfx code but in case of an error vmw_vali=
dation_revert() should be called an not vmw_kms_helper_validation_finish().
> >
> > To me the patch looks correct. This path is explicitly for submission
> > failure and does BO backoff plus vmw_validation_res_unreserve(ctx,
> > true). The backoff=3Dtrue branch skips committing dirty-state /
> > backup-MOB changes, which is only correct if commands were not
> > committed. Here the commands have already been submitted; only fence
> > creation failed. So I think unlocking BO reservations without
> > attaching a fence, then letting vmw_validation_done() keep taking the
> > success path for resources is correct.
>
> Ah! I would just avoid adding more TTM exec code dependencies.
>
> We also have the always signaled stub fence for such use cases. How about=
 that change here:
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> index e1f18020170a..8dcb8cd19e29 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -3843,7 +3843,7 @@ int vmw_execbuf_fence_commands(struct drm_file *fil=
e_priv,
>         if (unlikely(ret !=3D 0 && !synced)) {
>                 (void) vmw_fallback_wait(dev_priv, false, false, sequence=
,
>                                          false, VMW_FENCE_WAIT_TIMEOUT);
> -               *p_fence =3D NULL;
> +               *p_fence =3D dma_fence_get_stub();
>         }
>
>         return ret;

Yeah, that would be an ideal cleanup, but it needs a lot more work.
The p_fence is a vmw_fence_obj so we'll need to write code that allows
creation of vmw_fence_obj with a signaled dma_fence and then plumb
that through the driver. We'll also have to change a bunch of places
(especially in older kms code) in vmwgfx that treat null fence as "the
device has already synchronized". It's the right path, but to fix this
particular issue I'd be happy to take Vladimir patch for now and
perhaps I'd ask Ian to put a proper cleanup on his todo.

z

--000000000000dff1dc064f8b8e96
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEINFB
rIE9ROoOc0xiUpWtzO6U/Fm02Q/KSp34pKYx00X/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQxNjAzMzc1NlowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAG+q0rz1Q4UB2syWSijmwSYPN1TFf5AKljUY44y+
yBlvtwKWYHziOB/5kpoPEYd8VuKyGLjeUv48kB5j6nsP+btZP9uZPCV8rxVjghAuzL1jeh1QPgdr
hQPkfkv9VtA+EK+/K5QwGmuxwgtjGdisE+4Cfaxb0BbjHs9xf5BrHSP4F4ussmYXuWSXLqA1MJq/
6MYPySQAaU+TN3wfl1ffjEfB7DH7+nArNYmCOKkqnMaHJAjv/iUnyvX4KJUJYLyy6szGdYYfhT7J
a+sfKABJY8PyrwV+3jNOdqx9MRtd65hC88xFfWMRoeokekJBaFQhGXC//EkAmcF35KBGjkNtNO8=
--000000000000dff1dc064f8b8e96--

