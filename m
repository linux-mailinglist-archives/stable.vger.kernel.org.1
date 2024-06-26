Return-Path: <stable+bounces-55854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D1C91873A
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 18:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879082873E9
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B2D18EFF5;
	Wed, 26 Jun 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YB/5zvjZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCFB18EFC6
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418986; cv=none; b=VGn0CNNxgdU/qjXjbwUFclRi7OeKkzMAOPK1NmhddalAqFVPFPsvMLwzRRgzueerkZxYiXoynazW6Z5c3K8CBB2HyhKkd/jqsTTMZ4g561gRF1QJVgAjpCFw0dXxjOFSaV4iYxmtKNSaIesREKpAHreLwM05ELtTsTQGHQoqqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418986; c=relaxed/simple;
	bh=eHSg81Fo+Pt8x6ltJGBZ0e8Jr9axjacRr8oqUhS7yeY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NmOd5UvHhcixLCu14Rvd5tj/M9B8kZtnM5nWg6HmxkLthl3qTp6dCTD0dKqJuPJ5C3/nsV0qdvmwK+8FuIFLpysvFtKxX7ohfRvqi74lJK9Vt2MmhbO5dmZJFRUs+mDdKRQEcrlyy+T1ckrJeBDGwM08unBL9v5/G4gEK/mTm4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YB/5zvjZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719418983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuoTJ79gACgiKUQpe7k7Io37YwVqSEgfRMaeyg7Zvos=;
	b=YB/5zvjZvH06b0sVwc4Viy8ryhpiQp7Zho/s/IynvCU9VKemRd41sUW5NklZBSS7oZZvxh
	rmh7r7scMumzFWYDSi2YFc8dIqjjHJHAISwJSXZo1bHHCjZ0KuIWzYsodlWWPZnghpqp3W
	A8hkFXa40XE2i8lIyojL7NvmkBKbY7Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-od25PwltOoO3d6RHZdsv1Q-1; Wed, 26 Jun 2024 12:23:01 -0400
X-MC-Unique: od25PwltOoO3d6RHZdsv1Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b500743a3fso103677236d6.1
        for <stable@vger.kernel.org>; Wed, 26 Jun 2024 09:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719418980; x=1720023780;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JuoTJ79gACgiKUQpe7k7Io37YwVqSEgfRMaeyg7Zvos=;
        b=LUBeZGLvaHA6/wQKUTNKwLs4Fj5oMufzf6q3RXlYGvYSHZgs+czn9pjtl9VCJSiB/l
         M+WRVJ8Gwn0FCXdWzr2WNsLm0SsLpOkRz1UeQ57Y54a/NwA58YMQ/3bdpIqtdZjwqWMl
         vAQ4vlBMHfdb0gtWJQK1ySgtE46+2v+9POWXQsIFNXXReCOtLqjtSZVIay2z3G73Z+fI
         Q37rQ6cZDHOaypNz0IJO2tOrChzqUMSA/xCrvXK89HT5Zh5V079RF23ffOPeuJUlhGAV
         IGx4e8ZK0WDJefoZEAk1hfF/NCZfJ/QCrVAZNyc6CE2Zzz7kFaVoQaIOCrnWeMQEk4M1
         RTuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2UX//rxFv/hCjMyvlfaTi3odwqL1anRRNiX4aLnfVCkhB12Nu2CTCeaHiNHZb6WUAnlkD58CVKxUj7sFC29Q6xlunNv5i
X-Gm-Message-State: AOJu0Yx67/YBIJht+hCts9qIHwAVtlnyNVrjrwlXm4VvXAzwF4c7x2ZV
	Lt1Veevlx676S7D55LscGT8KCAk6NqPjaKUsChLV2wvLhS3wz0NPFudhswA26tEMFhzho3Rn3+Z
	/k1z8+f65H/HpMcSt8RxaoIVqnhTjIVfrPrL+lUqsqFC0MfbpdBdRgQ==
X-Received: by 2002:a0c:f64d:0:b0:6b2:a2bb:df2d with SMTP id 6a1803df08f44-6b58d706835mr1509666d6.48.1719418980495;
        Wed, 26 Jun 2024 09:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEndPS6fn5RzMS1/6Ml0GKhbz5cKUSuQGVRP877/iF2ldPCLzprf0ZZqKl5nq4TqTtPQjLg/g==
X-Received: by 2002:a0c:f64d:0:b0:6b2:a2bb:df2d with SMTP id 6a1803df08f44-6b58d706835mr1509486d6.48.1719418980212;
        Wed, 26 Jun 2024 09:23:00 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef5c3c1sm55634406d6.120.2024.06.26.09.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:22:59 -0700 (PDT)
Message-ID: <61bab346f145a529a61e5366fb39f424512e5a5c.camel@redhat.com>
Subject: Re: [PATCH 1/3] drm/dp_mst: Fix all mstb marked as not probed after
 suspend/resume
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, imre.deak@intel.com, daniel@ffwll.ch, 
 Harry.Wentland@amd.com, jerry.zuo@amd.com, Harry Wentland
 <hwentlan@amd.com>,  stable@vger.kernel.org
Date: Wed, 26 Jun 2024 12:22:58 -0400
In-Reply-To: <20240626084825.878565-2-Wayne.Lin@amd.com>
References: <20240626084825.878565-1-Wayne.Lin@amd.com>
	 <20240626084825.878565-2-Wayne.Lin@amd.com>
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

Thanks!

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2024-06-26 at 16:48 +0800, Wayne Lin wrote:
> [Why]
> After supend/resume, with topology unchanged, observe that
> link_address_sent of all mstb are marked as false even the topology
> probing
> is done without any error.
>=20
> It is caused by wrongly also include "ret =3D=3D 0" case as a probing
> failure
> case.
>=20
> [How]
> Remove inappropriate checking conditions.
>=20
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: stable@vger.kernel.org
> Fixes: 37dfdc55ffeb ("drm/dp_mst: Cleanup drm_dp_send_link_address()
> a bit")
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 7f8e1cfbe19d..68831f4e502a 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -2929,7 +2929,7 @@ static int drm_dp_send_link_address(struct
> drm_dp_mst_topology_mgr *mgr,
> =C2=A0
> =C2=A0	/* FIXME: Actually do some real error handling here */
> =C2=A0	ret =3D drm_dp_mst_wait_tx_reply(mstb, txmsg);
> -	if (ret <=3D 0) {
> +	if (ret < 0) {
> =C2=A0		drm_err(mgr->dev, "Sending link address failed with
> %d\n", ret);
> =C2=A0		goto out;
> =C2=A0	}
> @@ -2981,7 +2981,7 @@ static int drm_dp_send_link_address(struct
> drm_dp_mst_topology_mgr *mgr,
> =C2=A0	mutex_unlock(&mgr->lock);
> =C2=A0
> =C2=A0out:
> -	if (ret <=3D 0)
> +	if (ret < 0)
> =C2=A0		mstb->link_address_sent =3D false;
> =C2=A0	kfree(txmsg);
> =C2=A0	return ret < 0 ? ret : changed;

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


