Return-Path: <stable+bounces-237998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CtyEQ3l3mnVMAAAu9opvQ
	(envelope-from <stable+bounces-237998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:08:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC93FF72C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 03:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A07953019524
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B7258EDA;
	Wed, 15 Apr 2026 01:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LqqvLSI9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55740DFC9
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 01:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215299; cv=pass; b=XPSaT0l4/ryfQHJmnOe8UzYGrxw3v5l+LwjxeRKDSX3LTKsJezGkqGoaRM4VfINX9cCAhvRBKQyHCBWr8dHxZuO1MtKEJHaHUV0Z1oVJN9qwz2G/dqt6bktnGOfledwYs9+gR59AZZnbTCFVKEZ9A5H1ENigOipuWbJcajbkdxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215299; c=relaxed/simple;
	bh=ETyv8R1EiS4W2B8We3qE7tRSiJ3qf+61G/qdJTUNG4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFf4DcbIPcFpgcvrgzPCwv3kBTq6g7qSGuYRGXQ8BeqZyF0HUpdQuyYS+nSVFKvCAHWbTlQcmYSLmy5Nk14AXfq0yYMxzm9COVKdQXXWqPUE+1quANwrbnHk2SPTcaig9bf0v2o5SJBV1wmn0/eOEy4TACP6YgZC7iqXd4xUNEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LqqvLSI9; arc=pass smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-64eaf8aa893so5323018d50.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 18:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776215297; x=1776820097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irtdSKHcnlDWIh7uFELMycv2jXEhq7+pQNMokkqdeLE=;
        b=bg0HayJoZ2bRgaOXVHyvYfTzEJok5qteZw6YW24rKW/lRtCP8t4mxGhFiNsqXkfhag
         ls9t/y/jA5Mmof2ZOzaBBRMP2Ku1XKxw654w2Z2cX9f0eFrAUi4nRQ4iOd5YKAdJXuBd
         50RYhRsqFv38yo74+u6dZRq4dbsjVXfvUBKLadTloovPFRckWQMj6InBBT5Q1zHXVeke
         kxgnRwySoZ3oATNOv4grDD7hAaiMd2e6ebYVYN8DzDXPWA11lfZssnYOtzpheBywvpqR
         ++7a4dAvstPzWhhYcVZzmCmvwDPHplDNA9agWIJywC0wE/M7KgqdJoEYktz2qyHXDPPB
         8H1Q==
X-Forwarded-Encrypted: i=2; AFNElJ+rEr08AYlfJiIJOgI0uSSCXjJUXZX3uRW83Xs165cbGJfjGxc/EMn2Vj9bYyUOdf6vzDgxwGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHDrhKIV8HNECwGWYIKsyz5d9eYY2xM1Gdud9h1MIeQ6OOty75
	cUMHJSoOdyoHYstP2nTkY7aofFA7rv5ujLA7PBbKjjFDSdcsqm5QzQHD5m5J1u6qvvnOqzFSYyZ
	FFWoANhrb5fzXDflr6YEjD61pxF3nXQwE+TH0rc4UD8UJF2aJ/KEJkAx31MxesyBjf3GVW63VXE
	ktKVgNycr2uwcJBN+Ka5IQLnwF6D1IoTgpeRRDcrodx7jZM7pILd5QNKeRcASmw+eUQdLn0JVY4
	MpPtc9X
X-Gm-Gg: AeBDieson/niqEahHWdOnDOlOgOeOJDUcz4LN+Qz1fWz3zYvzPcwFT73eR9mRH3OdrG
	PLEkAInza1KhqCScJIRBSH8vzx2/1AnwbF0irGmf8Vfvoo2Sf4qFt7Y2+FoqybucvJ58Zg00LQl
	lTav9XGZfBMu/dsy4tUMJEz8htKT0E5aFfhUVZYNIooMspvKOGIsIkhf+mC51jZl/6dsZQ6GWN/
	EgjufBE7HjfGfijm+xqGgBbucF2BliHe5lJiJdeB5OL0nPxsfLZ75/njxUZJjl8cGCGEXW3l7OE
	oSI525hd86Yjaep2UV4WFckI/JMfunh+jWQjAfJCQ+QgQDfeqXDEM1zzjMAmIupsPMPJE/X5zTs
	hKbkbBA05kuVWWSLcYUn8y6i+y+qKceRBNjPlgPNzEzQ1i5DK7CB3AO69qvawRhGuiaqr7QH8qu
	2UzC1Mamu/nWijvKMvxonkhYHiAHteHBDlPCvF5kdtONm/kjkfbuvO4VB/m2z7zOlR
X-Received: by 2002:a53:d110:0:b0:651:9286:578a with SMTP id 956f58d0204a3-65198a8aa06mr13938390d50.25.1776215296872;
        Tue, 14 Apr 2026 18:08:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-652e473682esm9806d50.16.2026.04.14.18.08.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 18:08:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5a4055b2e65so980585e87.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 18:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776215295; cv=none;
        d=google.com; s=arc-20240605;
        b=Q+686T9vZGRGeESYCXPq42SqJOYfebl7/xJqpdsSTmXCzdX1FRAwG1YzzHgnmYgpPf
         oAn3RdbjNtQCiGWrw0nSg7ZtEmTYZPSZFQs88qAnQ11mzahqNSvx2wh8SehVP8RoPTqo
         b2B0S4Ekj8ZEejF81vyTCeCJ8Hajzf/Oj4vSmVGPydmrZ0uY9mekeUAR9tfIz85JPKIL
         BrTtD2sbZcWRtgv/h9XSNhDqiDZwWWekPcAVFhB+qHg8qBXR3DmYbaJGg1rdsAB4kvPl
         Wuw6ZCLuwp1i9iDQtgKGwaay/3exHPygLc+wbrnn/qO4B4yUsVmlnSZ0IGpWktWxZnsX
         liYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=irtdSKHcnlDWIh7uFELMycv2jXEhq7+pQNMokkqdeLE=;
        fh=HlkoOfEGWYM8k20s8TXP5Y7/bz8ZXoTBF5jx6X0ECrc=;
        b=YjsRFmU4dRh9C0VY88z73taG4t0TCZ9/yYbNZGkxTd0/rWEIs9c+4Q8R5fMYI9mvrR
         9AqlToinj8D3tVG9kYp/wRANn2hKw11AimXricxQQBx8xwiKDMbPqr5e8iF+4ePnXZKS
         Wf9A3ruCpGK+sHKJiQ4jOAUmBhq0dCzqAbh1VfOv7CjclpRMPlvIy0ZiSEnSiyejjznN
         +M1STtfifViPi0xCYBGmnkS6WWTtaOmZALVg5Y461jjtS9lvRwhnr/1ThWpbMPM4sMYj
         7XFE6PfzWsfFjCCrvshDG5nb6r0tsrQWshSiC6f/YTB1zLfpYaD5ejYXSZFasMH9OnRo
         MJSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776215295; x=1776820095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=irtdSKHcnlDWIh7uFELMycv2jXEhq7+pQNMokkqdeLE=;
        b=LqqvLSI9NYeqtCNi8tS0c6TgnhWjvH1/wfJwIFMMTTFlaYvs9VsiO/1jks8+RTzIjo
         CYgm5fE2bWyRMD3+/IZ+GhSEIufZz0yv85n0WHEVjH7A+eDqgVG6GS4GJHvbpfFJHJ9l
         +gnNEX63b4VqaH6zcfiJIhZsDEOGCaPahc5Lc=
X-Forwarded-Encrypted: i=1; AFNElJ+CeICeyhrezrnJPBzgzh40689pjzhLx8maCkEPk0+WZ1WBmY4FlkmBxUcPXBXv6SyNxsQlst8=@vger.kernel.org
X-Received: by 2002:a05:6512:3b28:b0:5a2:c210:4631 with SMTP id 2adb3069b0e04-5a3efb281d6mr6506447e87.24.1776215294973;
        Tue, 14 Apr 2026 18:08:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3b28:b0:5a2:c210:4631 with SMTP id
 2adb3069b0e04-5a3efb281d6mr6506440e87.24.1776215294435; Tue, 14 Apr 2026
 18:08:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414105529.9883-1-popov.nkv@gmail.com> <ecf4cd01-b05d-4f51-943a-631cc4b27331@amd.com>
In-Reply-To: <ecf4cd01-b05d-4f51-943a-631cc4b27331@amd.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 14 Apr 2026 21:08:01 -0400
X-Gm-Features: AQROBzB9xDYvxtGn-vVFYidT-0afNkRbq08eF7asqpx7x2PE8EMbH6-BtwZ2p0U
Message-ID: <CABQX2QMH2XFcuz00DQQWU4uKw2B8OzE4rCE5=8LMXDg4t0AqWQ@mail.gmail.com>
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
	boundary="000000000000b9f522064f755909"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237998-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,lists.freedesktop.org,vger.kernel.org,lists.linaro.org,linuxtesting.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 99BC93FF72C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000b9f522064f755909
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 9:25=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/14/26 12:55, popov.nkv@gmail.com wrote:
> > From: Vladimir Popov <popov.nkv@gmail.com>
> >
> > If vmw_execbuf_fence_commands() call fails in
> > vmw_kms_helper_validation_finish(), it sets *p_fence =3D NULL. If
> > ctx->bo_list is not empty, the caller, vmw_kms_helper_validation_finish=
(),
> > passes the fence through a chain of functions to dma_fence_is_array(),
> > which causes a NULL pointer dereference in dma_fence_is_array():
> >
> > vmw_kms_helper_validation_finish() // pass NULL fence
> >   vmw_validation_done()
> >     vmw_validation_bo_fence()
> >       ttm_eu_fence_buffer_objects() // pass NULL fence
> >         dma_resv_add_fence()
> >           dma_fence_is_container()
> >             dma_fence_is_array() // NULL deref
>
> Well good catch, but that is clearly not the right fix.
>
> I'm not an expert for the vmwgfx code but in case of an error vmw_validat=
ion_revert() should be called an not vmw_kms_helper_validation_finish().

To me the patch looks correct. This path is explicitly for submission
failure and does BO backoff plus vmw_validation_res_unreserve(ctx,
true). The backoff=3Dtrue branch skips committing dirty-state /
backup-MOB changes, which is only correct if commands were not
committed. Here the commands have already been submitted; only fence
creation failed. So I think unlocking BO reservations without
attaching a fence, then letting vmw_validation_done() keep taking the
success path for resources is correct.

iirc the same helper is used by execbuf, and the shared-helper fix
correctly covers both paths so this is probably not only a kms issue.

Untangling this code would make sense because it's confusing, but
that's not something I'd expect Vladimir to do :)

z

--000000000000b9f522064f755909
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIJbU
+Ul2Ju230MA3piovGJ+/oE+VmOysjBq8WgmmmKaMMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDQxNTAxMDgxNVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABBa5jgr3/OuBTC1lDJjNPgvsppmGdM6Q6JA3BBA
uLZ6K0OwXUJYVyai2eFDJKjM0Tlk+hyn1bYrW1WvfXBkfvl90BYFFMOH1VvqtTU7ftdjfbsJL9ej
0owoDkug41eKCVHoHVl91rcIS6D3G6y3t6BzuKqhzdNYs7Kyj7wRoNHw2YHC1ySM98dQRa1wXqwM
ugK938rLCbH0S+WUDpM/OWJW6LmhnSGqZ6fi9GYOk9CA435iROfAWVEN3GtcJsQZa1DvN4j+EeN/
kuRHfWzW446PPVl5SPzLXYW+mZH9WAHKdyDysRalQm1kdYqIeTIVnCBgD4mFOm799BYuQFkPfXk=
--000000000000b9f522064f755909--

