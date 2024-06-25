Return-Path: <stable+bounces-55800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C009170F3
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 21:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DF52826B9
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 19:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A1217C7CB;
	Tue, 25 Jun 2024 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDzt8aPU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77EF143882
	for <stable@vger.kernel.org>; Tue, 25 Jun 2024 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719342707; cv=none; b=f+Emvi/qyBLiHRkSEdDgdUkye566bhtr+P4FuilW7Dc1qnb/8f7sZPNrtsnBHAy6HPOj9mEmxrxucvGLDMlNQzCy91EXmteZY5AW/E2R4EdG//foDPVd6eVlSwm9yvPDQAG56FS8x8YMVCdqivUFBD77QBxKtbk33hHMwVjspzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719342707; c=relaxed/simple;
	bh=qO9c0qpXrq+3fK0LEUzQ+gLt3HHAfu6AUWFZ9WrvQWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I8V30robMUVXGFpi1diMLDkg8/TxiLscD6uKhxhFn5+Xfv1tf07hsbKsGzGkkhS/R9t08TcGbAeo68pmUEtgbrL/1NJx1noUfFSitqPjo/EsDOUxL7C5pLq8lfoSMIJuxUHk4M25gNrYI9OMGF+kSHFtcPNQuUhnEXmCnxNTgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDzt8aPU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719342704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e13YfLxrx9QBTn7/Lh+rajM0bGrTVztbpsgKXAwM4ag=;
	b=cDzt8aPUGKGX8SLsuZyWAv/V3m76NaiF2LWcjqYseEFq7QBSamCT8U1O7GjeAB4loRXFIo
	OhLMnL62/UC7dyLW4NmfImZE4MChOWHG3W8jLstICCwtC8iiaA/JS8M/VVZTqMioEMTQBx
	yd1K70s1hdQ6WgzUae9aIpavdLOYgxM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Wy-7E9cNNTmRlTaT7vhMDA-1; Tue, 25 Jun 2024 15:11:43 -0400
X-MC-Unique: Wy-7E9cNNTmRlTaT7vhMDA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-794fd7ff611so1102955085a.2
        for <stable@vger.kernel.org>; Tue, 25 Jun 2024 12:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719342703; x=1719947503;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e13YfLxrx9QBTn7/Lh+rajM0bGrTVztbpsgKXAwM4ag=;
        b=EiBOCbXiR+rcGvSL13iGMwlLLs7UZ2BXA93brjs0DwcP/OCEnO/F217jLE+qoMEg1o
         SakLbnPOByErYvbShVVI1TL2fW9f/qJN9f6vy3w6kVF/abJfmNLlzjdxqr4ViHjx4A6J
         mg10AdxB4DBtxfjZiaXuXx+jZKu0v1+hOUiT434jWaWSLmyzCmZJ+oY9qVw11FMEK6yd
         uE93CII65PsA/b0f+W0LQEMkh9rxpzexeN/0ZY09b0k8uEWQTv1+ZeKr9IujiCqFPQIk
         1qDJ/5joBlsRFBjhak3g+LqKHZTrKbYoSALIvd01FNI+fpcv6Cm/6Oj1/wv+/rOwPv65
         m8tg==
X-Forwarded-Encrypted: i=1; AJvYcCXTSLDHP42f/I5akfhjglodeCh1US+mxsxL9L71W+IobgAtEqKpL7Qm0kx2+pAJjbyAfWPOE7D1Us9IgHg2SW8sEQxi6yZu
X-Gm-Message-State: AOJu0Yyc8gZj9ttYYHTf/BXmPHedu48vX2j5QMaCYY/wgm3KQScMRe8s
	GyxEvNbQmPWo5zs3sYM+rvTwRgYr/BFHduF7ezzMKAZOCsqv7n6BhSTrIr3JaGtX4Pe+fkR/VcS
	TLTK0OpSipmqqd8e9lXA8jKaVzC3iDSYb73ERNkLpECRRdjhkqysv3Q==
X-Received: by 2002:a05:620a:4002:b0:794:8de6:505f with SMTP id af79cd13be357-79be701fe22mr779120185a.65.1719342702851;
        Tue, 25 Jun 2024 12:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhdICv2itjqoD37ZGNl0mT+EALkdSduHpGzBvI0THMGz2Iv/iOD7HGal7FR551LXjasudQPQ==
X-Received: by 2002:a05:620a:4002:b0:794:8de6:505f with SMTP id af79cd13be357-79be701fe22mr779118085a.65.1719342702478;
        Tue, 25 Jun 2024 12:11:42 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b1917sm433317085a.38.2024.06.25.12.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 12:11:42 -0700 (PDT)
Message-ID: <30a2ae4b3ac161012168a6d03cd28c616829eb22.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/dispnv04: fix null pointer dereference in
 nv17_tv_get_hd_modes
From: Lyude Paul <lyude@redhat.com>
To: Ma Ke <make24@iscas.ac.cn>, kherbst@redhat.com, dakr@redhat.com, 
	airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 25 Jun 2024 15:11:41 -0400
In-Reply-To: <20240625081029.2619437-1-make24@iscas.ac.cn>
References: <20240625081029.2619437-1-make24@iscas.ac.cn>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Lyude Paul <lyude@redhat.com>

I will push this and the other patch that you sent upstream in just a
moment, thanks!

On Tue, 2024-06-25 at 16:10 +0800, Ma Ke wrote:
> In nv17_tv_get_hd_modes(), the return value of drm_mode_duplicate()
> is
> assigned to mode, which will lead to a possible NULL pointer
> dereference
> on failure of drm_mode_duplicate(). The same applies to
> drm_cvt_mode().
> Add a check to avoid null pointer dereference.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> index 670c9739e5e1..9c3dc9a5bb46 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
> @@ -258,6 +258,8 @@ static int nv17_tv_get_hd_modes(struct
> drm_encoder *encoder,
> =C2=A0		if (modes[i].hdisplay =3D=3D output_mode->hdisplay &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 modes[i].vdisplay =3D=3D output_mode->vdisplay=
) {
> =C2=A0			mode =3D drm_mode_duplicate(encoder->dev,
> output_mode);
> +			if (!mode)
> +				continue;
> =C2=A0			mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> =C2=A0
> =C2=A0		} else {
> @@ -265,6 +267,8 @@ static int nv17_tv_get_hd_modes(struct
> drm_encoder *encoder,
> =C2=A0					=C2=A0=C2=A0=C2=A0 modes[i].vdisplay, 60,
> false,
> =C2=A0					=C2=A0=C2=A0=C2=A0 (output_mode->flags &
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0
> DRM_MODE_FLAG_INTERLACE), false);
> +			if (!mode)
> +				continue;
> =C2=A0		}
> =C2=A0
> =C2=A0		/* CVT modes are sometimes unsuitable... */

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


