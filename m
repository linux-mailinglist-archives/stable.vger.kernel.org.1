Return-Path: <stable+bounces-55853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF42918730
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A94E281468
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15418C32B;
	Wed, 26 Jun 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ik3fNd2u"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697361849EF
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418837; cv=none; b=uA/IuFQHMMdtEz1iuIgqx2AtbCF1G0q97wUQUgIdmq4EYVlX3w7EB2myhhgxe8DlJcRi0yEQY6gDu7K0Z2T4vBBCZkBzbLkvDr7ksZC1ATLxFeVI2WyDwqTARJoS3YYr9hCDW78e/FVTJ0vv8/yjNT+qOEMPUFvyhLCETnx4dEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418837; c=relaxed/simple;
	bh=OCteto+W9gTIgGPpw3NgSna/xuWa5iOdB3S4LUpqDnM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rtAN4aK3kKadtrKUmHckTr5Sr2Gki4J2t7VcIuzxfHBSmKT7WKD31TAAgPLNvtrcyNfG5dSHN/E0TOZBi6pSqwabNxLW1LW9AQk1MQO7kFeR56Ap+5W5hIP51rfAp/dXsXFOL+YqVumrs+MEI7KKr+xvEyLZDauB2ZplgoPpKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ik3fNd2u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719418834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CyeK3GRLaHegaYbR5xPpklmA5OzN7TqqvirmtcOmEwo=;
	b=ik3fNd2uOEgzFI2F5AX2pOc4I1BloFTlklTGPDs2KDdEIGA8shscXw52TtYYXnbm0IKDfo
	fkYvwFIEVmCmqOVCPqNL773Fvpon9DXbBsvkZurePP83KNgG6pushxWgdtRaB2HT90bKwv
	k+YjRThptGZbwki+xo22cdL9z696j14=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-nE-VmQmbMjiXV3LWBLfaJg-1; Wed, 26 Jun 2024 12:20:33 -0400
X-MC-Unique: nE-VmQmbMjiXV3LWBLfaJg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-43fb02db6d2so109535271cf.0
        for <stable@vger.kernel.org>; Wed, 26 Jun 2024 09:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719418832; x=1720023632;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CyeK3GRLaHegaYbR5xPpklmA5OzN7TqqvirmtcOmEwo=;
        b=JDwLI7HJimE+HrihNhJehUPZTA7qCahxlCYsNXWLrBeXKSVfmpXvia1sbI5siGCdr1
         7FmXfDieQc50CTmZpIPeY+DWToOu7oX0Vf0W8zGMMJe1UTTMjpvXNgyK5297TNtZfl4w
         SLbtb5FfbwOWrmfRVXCVtl9qRG1pBIrF+HRM3gNZQjkfFwZ/Z4TTHdtl7taV0j2VnY1C
         lj7IlOV2x50uDY09h13pQ3KpIyDkZruFTSfkwzHGgDFCY7mb/qDuMYt6oiyWDC3FpO7y
         FBrfCJtjyS2VMNpAZ5eNkrni93gjjoMUH7Hv2j3rJJV7QNrc8eVQjEJ4NGEFj4VF9lN+
         +2Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVmTtatzywlTyUUwiraY8WhRD6mgkc68YjxNzN3niQQUDPUkUuSuN6Jl4UvMajJ2Mx0nijbqLWj2ihHaysQD6aQgPNd7ODH
X-Gm-Message-State: AOJu0YwUxzrId/FqoLE2A+r7w1pwo1LHO2zVf/ylAVHuZe5isXZCiJRy
	y4k2SMI4tbbGjjMsPhvBK4EsHxeKhEuUDnH60NpyiFUiM68MX8oZGAqpZhsPFk39e/vbO6pFtv4
	DPdsrJrJ3k31I3a5GAX4cHfTVcroWvf636Kaf1qbhwBjn2pe6ZBOmxQ==
X-Received: by 2002:a05:622a:1650:b0:43a:f8d3:f4c4 with SMTP id d75a77b69052e-444d91a95ebmr127274611cf.21.1719418832508;
        Wed, 26 Jun 2024 09:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl/6pjwXh3eYxhUg1LhHOVVuXrCojU6GizTbxNkS/2KKtWyqteg6noR/crxypzcYyciERgnQ==
X-Received: by 2002:a05:622a:1650:b0:43a:f8d3:f4c4 with SMTP id d75a77b69052e-444d91a95ebmr127274311cf.21.1719418832193;
        Wed, 26 Jun 2024 09:20:32 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44504b1b0f7sm11151541cf.19.2024.06.26.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:20:31 -0700 (PDT)
Message-ID: <7da3ccf156a858c1a7d2691fbedfa7aa2ceccdf7.camel@redhat.com>
Subject: Re: [PATCH 2/3] drm/dp_mst: Skip CSN if topology probing is not
 done yet
From: Lyude Paul <lyude@redhat.com>
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, imre.deak@intel.com, daniel@ffwll.ch, 
 Harry.Wentland@amd.com, jerry.zuo@amd.com, Harry Wentland
 <hwentlan@amd.com>,  stable@vger.kernel.org
Date: Wed, 26 Jun 2024 12:20:30 -0400
In-Reply-To: <20240626084825.878565-3-Wayne.Lin@amd.com>
References: <20240626084825.878565-1-Wayne.Lin@amd.com>
	 <20240626084825.878565-3-Wayne.Lin@amd.com>
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

Some comments down below:

On Wed, 2024-06-26 at 16:48 +0800, Wayne Lin wrote:
> [Why]
> During resume, observe that we receive CSN event before we start
> topology
> probing. Handling CSN at this moment based on uncertain topology is
> unnecessary.
>=20
> [How]
> Add checking condition in drm_dp_mst_handle_up_req() to skip handling
> CSN
> if the topology is yet to be probed.
>=20
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 68831f4e502a..fc2ceae61db2 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -4069,6 +4069,7 @@ static int drm_dp_mst_handle_up_req(struct
> drm_dp_mst_topology_mgr *mgr)
> =C2=A0	if (up_req->msg.req_type =3D=3D DP_CONNECTION_STATUS_NOTIFY) {
> =C2=A0		const struct drm_dp_connection_status_notify
> *conn_stat =3D
> =C2=A0			&up_req->msg.u.conn_stat;
> +		bool handle_csn;
> =C2=A0
> =C2=A0		drm_dbg_kms(mgr->dev, "Got CSN: pn: %d ldps:%d ddps:
> %d mcs: %d ip: %d pdt: %d\n",
> =C2=A0			=C2=A0=C2=A0=C2=A0 conn_stat->port_number,
> @@ -4077,6 +4078,16 @@ static int drm_dp_mst_handle_up_req(struct
> drm_dp_mst_topology_mgr *mgr)
> =C2=A0			=C2=A0=C2=A0=C2=A0 conn_stat->message_capability_status,
> =C2=A0			=C2=A0=C2=A0=C2=A0 conn_stat->input_port,
> =C2=A0			=C2=A0=C2=A0=C2=A0 conn_stat->peer_device_type);
> +
> +		mutex_lock(&mgr->probe_lock);
> +		handle_csn =3D mgr->mst_primary->link_address_sent;
> +		mutex_unlock(&mgr->probe_lock);
> +
> +		if (!handle_csn) {
> +			drm_dbg_kms(mgr->dev, "Got CSN before finish
> topology probing. Skip it.");
> +			kfree(up_req);
> +			goto out;
> +		}

Hm. I think you're definitely on the right track here with not handling
CSNs immediately after resume. My one question though is whether
dropping the event entirely here is a good idea? In theory, we could
receive a CSN at any time during the probe - including receiving a CSN
for a connector that we've already probed in the initial post-resume
process, which could result in us missing CSNs coming out of resume and
still having an outdated topology layout.

I'm not totally sure about the solution I'm going to suggest but it
seems like it would certainly be worth trying: what if we added a flag
to drm_dp_mst_topology_mgr called something like "csn_during_resume"
and simply set it to true in response to getting a CSN before we've
finished reprobing? Then we at the end of the reprobe, we can simply
restart the reprobing process if csn_during_resume gets set - which
should still ensure we're up to date with reality.

> =C2=A0	} else if (up_req->msg.req_type =3D=3D
> DP_RESOURCE_STATUS_NOTIFY) {
> =C2=A0		const struct drm_dp_resource_status_notify *res_stat
> =3D
> =C2=A0			&up_req->msg.u.resource_stat;

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


