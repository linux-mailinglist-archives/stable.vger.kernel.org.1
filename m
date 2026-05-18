Return-Path: <stable+bounces-249356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJcCIQpUC2qYFgUAu9opvQ
	(envelope-from <stable+bounces-249356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:01:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE0A571D83
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CE05303746C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509E038911E;
	Mon, 18 May 2026 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VT8lOrQz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ay0KdeJ8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD403389DF3
	for <stable@vger.kernel.org>; Mon, 18 May 2026 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127190; cv=none; b=KFFE9zxjwQIpbOfeBc5SFmaF7JQ/nnFieHbsL81Mi1rdWwGj7KdijphOQcVHkNe+eO2s8IERpiF2+CiW9CBx8RBW3FSUugrXpEJw7nUMLwj8jR7oOcRq1tUWdy6KV5IH+1q3l8snOYsRZlOUu2ELgn5TDwZwhpHZe6aFmNztfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127190; c=relaxed/simple;
	bh=56Gx8U1bBkQwGZUb/0kMvViULOM86+lx0qtC08zx5ls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMKRn0+6LQuwTP5PvimvXoRYoEApNfc69St5b/g0IMNiTe57eMF5KtCBENMp50jGyPO8PjIaAcZuuTG9No2JMYqWi4j1O0eosgBq29GxIieZI5ldId/BTC2nTaXzNLHp9kXfGBLy0P+zlZV1bpn0XGmnh1qWLtXAo2JG4lFfYCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VT8lOrQz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ay0KdeJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779127187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u8nJotCS5ieH4qI/fVkCf7erQnf4wXUQWNAiQ92BJeI=;
	b=VT8lOrQz5ai6E67GqUulmKaE7TOxOv8g9KJPgfrBbIET7fdmbWicoglDtS+o/WPPvHvge0
	ixz8Qvtja9VDl55eCJGa/XVAMiro2TRAHVz6NE1gjxmQPeATmTrPXVD5SMRecVEzq5W+VW
	D+td2vButBCFafLs4cFrd4k6fSlnL/Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-H10k0RCUNOeXCLzkmcnozw-1; Mon, 18 May 2026 13:59:44 -0400
X-MC-Unique: H10k0RCUNOeXCLzkmcnozw-1
X-Mimecast-MFC-AGG-ID: H10k0RCUNOeXCLzkmcnozw_1779127183
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8b7a1ea06bfso90341996d6.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779127183; x=1779731983; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u8nJotCS5ieH4qI/fVkCf7erQnf4wXUQWNAiQ92BJeI=;
        b=Ay0KdeJ8ocihUI8XZuAKDN5cElfvPBNjXJ88LE2lOI6nG7GAqJqufJAUQdYOpX39TP
         qphL/AVC57an6sdO9+AmoRRjRYFt6eJ3Hcq3pKiBxTPmfnrQjhh5n76q9m/HbvG9J96d
         U8GWNoL97NG97k3aaQsPGBlqBvuY51RHV4ywa7ExwZDrtMe7trWilakGyADGq9qhMmJo
         jANdPkq+nPNuKnJcsDD0ZN6lGbLyXO+NAcDYhpqOUiMHyxzZUrTCKNo9jsvg8xgR/+9j
         TOgr2PW9Emns7Uk6htgktFgOfFu0srO9Usrbkqb6JuJVfKLFCGv+I7qYW58KEGVpzkBt
         rf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127183; x=1779731983;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8nJotCS5ieH4qI/fVkCf7erQnf4wXUQWNAiQ92BJeI=;
        b=KUDrIsNMA3Fo2BdRUnocMAN4l3HDRaITwOzWfFAwOokmnxiak1ly3ePP/d8yDeuon6
         0MSyq1LZmoAhNmEIOipjYqdIMXWD2CS94aZM4fW+JI3J21E9EsXPOdURTxnWE849OD2x
         AjXmJpGVsdI2ATMFHd+RDTwhK0jGVQJFImf7RQQzv2xjt588U9xZsH0Vz1Kodv3FwOTn
         PSYSfOuoq2zm80Sll6FNOkbvKMk0BKVEuqtdFfNMZaxh397h7IHMtv52VsF82YnWGQHa
         k5MY/lNVAhrLA4PUZs8bGE3lmF5tkpxLmONzbvkBN599IK4tB3v3Y8CGniuYiYj4mLsq
         PdmA==
X-Gm-Message-State: AOJu0Yw9iDgMo2R44wzDVgX70TeMkp5nho5eH+NZGu9R/OomKgt8VsYR
	zpHk1KlRbxl4EnLhbdnHYTHGli2RWzb3gEL+qdzSbzZEv+In9UHZHVxCZauVH66bLpRDoFMxmtj
	Kto2nKwwW0s5LhGsPUAXfhAAeq2CJUa/Rx6thK7jNsZGAu1kQjeR46WJP4A==
X-Gm-Gg: Acq92OEVUE07gBRrXcXWXNEFcjaJQxQ89rTuwtVXjrMwFzn7sx6z6YldfiO0Zoi4y95
	ZCmGpgF3Gp7MlhHjb+Mj35/mRSXuKnuZXuIgeqUoj7vRl70t5c+8pRMeiVuWLI1XsfiBlP8E7Op
	Io6OQBbRJdyyIhLofAEPZ9TUkxd1MCCEE5iokmGPtbJ5SXdTwJbqFE6hDsMip50W6m4pDSYO+PE
	9mgUuDtCbd8SdunKEtluznPIVWSJ4TVTn2h+KLliDE9bEyyhGj+tBw99NAr4DcG5rbscd0a+GMI
	A9CT91Ec3D8gnQUWR/3njxNdax2xmVwTBspsMKWF+LygPorw0b2nfIKqlZTZu68j5o5h7GBkJYR
	R5TwUcglzc1bSXRwiDA==
X-Received: by 2002:a05:6214:5e06:b0:8ca:1f6b:a27d with SMTP id 6a1803df08f44-8ca1f6ba690mr181284966d6.20.1779127183522;
        Mon, 18 May 2026 10:59:43 -0700 (PDT)
X-Received: by 2002:a05:6214:5e06:b0:8ca:1f6b:a27d with SMTP id 6a1803df08f44-8ca1f6ba690mr181284626d6.20.1779127183069;
        Mon, 18 May 2026 10:59:43 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3619c7d9sm62373116d6.36.2026.05.18.10.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:59:42 -0700 (PDT)
Message-ID: <04a87b5cebc6aeea103997c453e0487ffee70022.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp/mst: fix OOB reads on 2-byte fields in
 sideband reply parsers
From: lyude@redhat.com
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, 
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 	simona@ffwll.ch, linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 13:59:41 -0400
In-Reply-To: <20260510203128.2884846-1-ashutoshdesai993@gmail.com>
References: <20260510203128.2884846-1-ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249356-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EBE0A571D83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next in just a moment

On Sun, 2026-05-10 at 20:31 +0000, Ashutosh Desai wrote:
> Three sideband reply parsers read 16-bit fields as:
>=20
> =C2=A0 val =3D (raw->msg[idx] << 8) | (raw->msg[idx+1]);
>=20
> and check bounds only after the fact. When idx =3D=3D raw->curlen,
> raw->msg[idx+1] reads one byte past the received message data into
> the following struct fields (curchunk_len, curchunk_idx, curlen).
>=20
> Affected functions:
> =C2=A0- drm_dp_sideband_parse_enum_path_resources_ack()
> =C2=A0=C2=A0 full_payload_bw_number and avail_payload_bw_number fields
> =C2=A0- drm_dp_sideband_parse_allocate_payload_ack()
> =C2=A0=C2=A0 allocated_pbn field
> =C2=A0- drm_dp_sideband_parse_query_payload_ack()
> =C2=A0=C2=A0 allocated_pbn field
>=20
> Fix by using a single combined check (idx + 2 > curlen) before each
> 2-byte read. Since the check is strictly tighter than idx > curlen,
> no separate step is needed.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> Changes in v2:
> - Drop separate idx > curlen check immediately before idx + 2 >
> curlen;
> =C2=A0 the combined check strictly subsumes it (Lyude Paul)
>=20
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 ++++------------=
-
> =C2=A01 file changed, 4 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 9416a48804c8..6e7896193772 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -925,16 +925,13 @@ static bool
> drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
> =C2=A0	repmsg->u.path_resources.port_number =3D (raw->msg[idx] >> 4)
> & 0xf;
> =C2=A0	repmsg->u.path_resources.fec_capable =3D raw->msg[idx] & 0x1;
> =C2=A0	idx++;
> -	if (idx > raw->curlen)
> +	if (idx + 2 > raw->curlen)
> =C2=A0		goto fail_len;
> =C2=A0	repmsg->u.path_resources.full_payload_bw_number =3D (raw-
> >msg[idx] << 8) | (raw->msg[idx+1]);
> =C2=A0	idx +=3D 2;
> -	if (idx > raw->curlen)
> +	if (idx + 2 > raw->curlen)
> =C2=A0		goto fail_len;
> =C2=A0	repmsg->u.path_resources.avail_payload_bw_number =3D (raw-
> >msg[idx] << 8) | (raw->msg[idx+1]);
> -	idx +=3D 2;
> -	if (idx > raw->curlen)
> -		goto fail_len;
> =C2=A0	return true;
> =C2=A0fail_len:
> =C2=A0	DRM_DEBUG_KMS("enum resource parse length fail %d %d\n",
> idx, raw->curlen);
> @@ -952,12 +949,9 @@ static bool
> drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
> =C2=A0		goto fail_len;
> =C2=A0	repmsg->u.allocate_payload.vcpi =3D raw->msg[idx];
> =C2=A0	idx++;
> -	if (idx > raw->curlen)
> +	if (idx + 2 > raw->curlen)
> =C2=A0		goto fail_len;
> =C2=A0	repmsg->u.allocate_payload.allocated_pbn =3D (raw->msg[idx] <<
> 8) | (raw->msg[idx+1]);
> -	idx +=3D 2;
> -	if (idx > raw->curlen)
> -		goto fail_len;
> =C2=A0	return true;
> =C2=A0fail_len:
> =C2=A0	DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n",
> idx, raw->curlen);
> @@ -971,12 +965,9 @@ static bool
> drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
> =C2=A0
> =C2=A0	repmsg->u.query_payload.port_number =3D (raw->msg[idx] >> 4) &
> 0xf;
> =C2=A0	idx++;
> -	if (idx > raw->curlen)
> +	if (idx + 2 > raw->curlen)
> =C2=A0		goto fail_len;
> =C2=A0	repmsg->u.query_payload.allocated_pbn =3D (raw->msg[idx] << 8)
> | (raw->msg[idx + 1]);
> -	idx +=3D 2;
> -	if (idx > raw->curlen)
> -		goto fail_len;
> =C2=A0	return true;
> =C2=A0fail_len:
> =C2=A0	DRM_DEBUG_KMS("query payload parse length fail %d %d\n",
> idx, raw->curlen);


