Return-Path: <stable+bounces-244625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNQPKEHV/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:09:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4C4ED3A4
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 239B6300F2B8
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBC43314A1;
	Thu,  7 May 2026 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foRjLjRD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="INhmLiEe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4B31D75E
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177246; cv=none; b=IvmHQFcuMm/QB48zPyiR/F1P+i49tbG0O0Tvf/b3nCwqQI5cWe7aJRR/arJxk35ZJ22PJh+Ne7irVy2hO/J5G+5ISP3ZIJZWUQpFzUrMCrZeB0130Lz1z/eaYrySxZy24Xq4MwCtzAEHKVUtfUUKJikaF/ndII2HTDv84DbrZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177246; c=relaxed/simple;
	bh=DkSDN97W5UUvdVU8/N4s8W23ePyjxP5okSTrhYYb8ok=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWTP+R7jlgj0hqDFcETwm4cWBH84cDKLg9WosMdPc01HQgIQYTT78Xb/MNxki5tDLLUVniOiYbVwkiohnfIu9eh0VvrsR2XtNPeZhGkicB+PQ5rNUPoRtleOI6exHYaBuljopnmJNI4mFQFG95QmO8H0SJu+METYFwyMnRR4y6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=foRjLjRD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=INhmLiEe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778177243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMramWm34LJwqXAbzHOSM29JunUaIBH0eWDhplWtOIc=;
	b=foRjLjRDz5YEW9gnPcmMdd2Qi0C9NLD58BZKMwiuikwhz4IAvG3bZUTDz7p5G7IddCgzx1
	XZHGKtorUom3qbaaHcsWBpZNMXLUpy1ayjzlHB0lVva6A/Yg5ui7bPLsTXwawIzGNzsvlM
	J9UTb81SxYGCILWq0yIshn15YRBkQus=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-51ANkp0rMAqklpiUTJr6bA-1; Thu, 07 May 2026 14:07:21 -0400
X-MC-Unique: 51ANkp0rMAqklpiUTJr6bA-1
X-Mimecast-MFC-AGG-ID: 51ANkp0rMAqklpiUTJr6bA_1778177241
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d84b5f73bso31014891cf.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778177241; x=1778782041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IMramWm34LJwqXAbzHOSM29JunUaIBH0eWDhplWtOIc=;
        b=INhmLiEexCzjs4ncGNDVmiSIQfEOuy35cxi0UEH+8fspvs4YfQlUcisK1Cy79Ng6uI
         0hmKjP3GgiOjGE92fxGprrNwSlGSZeIjw1VQLBYQZ++eqxd7q0achPdf3gSkpVl0aJ+n
         Njzoi9hcYVTfRipJQfy85ozpsEIVTwq61Oe1qYBR8ShobhS17IFq0/MNn2QUOBqEL0ky
         9l2S9trQ8wxEDcbjMUGvm93ZxWqpsRoNhqeVjsoc4z/mcurXS0C9MzqNwejv2tnNpNNM
         gD52Lil07WdjolcJM1F6tln3vqFt+B4DPduaf3rELfTz+MYm34t0T1zq3m297UrQxgKe
         aZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177241; x=1778782041;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMramWm34LJwqXAbzHOSM29JunUaIBH0eWDhplWtOIc=;
        b=i4qAoGmhjsGQjt+sN8wiMDIEEiSBo+PVsr49n4xFGT/jOMwBVK664AokiZ2vWtVYjB
         UkfHKGOqo6m5HylDizheF7sjmic/9OS8l1ORZCTClX7eDwMnJQ/8jKzE75r+TTgh5v3u
         GSoAUYl9TPgGUfUIZPWOqsVmmkspw0IhwNVOlUQvRwsbM7+CL1ufLNZvyRseptqCBazC
         rCikqdjb0f9YtVh8+VoOlP94qpcMKlU3/PtgbQyOxwQCLKqXjiC94ast0nBd77tD2mVi
         fJTRtNx1IW05aqF3n235eKzxCmnEqlxoR9qlHbsn4MZgWaZGN0cfhQbZ5vrgipgoccVr
         rbQg==
X-Gm-Message-State: AOJu0Yzxe+Q9uuAqv80kMhigRYSVA+zdh7Ir+ksshKST1EaMI5tUsYbh
	vMakHbIUbz31fvYBDFR3ztXu8R4+yoWmeMP6+FIdP7a3o1lnw+iA8hiM9SGohXJA9jR7EtUiTCj
	RMiVay73E8OL6g5EtCDOYjdvPkrnSG9RnWgcYNc0aw/fvI8ynYIZGxLosOQ==
X-Gm-Gg: AeBDiesgPGuvhGklRq5oD/EOOKx4dXEw0y19wyte9nMa91l/4I24Y9Ahh4ervoE0TGc
	tnkkiLkaPYm/ULcs74oE3gA0FfQHFAJQBr7CL4Z7PrjACnfpZxS26mXfVhgPLSJqJDmIJqy8eu5
	nRDd0T0PhGFdGG5Nr1o0Cz1SKYkPJgzVBimmeiziOb/Frfz8PN+vAX3JVCT2wzA9I5hA/8MPA4P
	5YWs2qj9DHnPClLlUuyXH2YsDd6J2rCSrVqpcyPhbzW9Q6bEpB4Bu96+06EaplruNvGiFSZD7Bn
	YKwub2zZ7BCNQ1w5GmU7NfoTDUt1wbh3r1Rquamia20m2pFhV3MnzLOGNZSe8COQ/GkKJIVkE8/
	7gXyrDK9fL5CJaxk5cQ==
X-Received: by 2002:a05:622a:18a9:b0:50e:6302:340b with SMTP id d75a77b69052e-514621ff185mr135509071cf.53.1778177241247;
        Thu, 07 May 2026 11:07:21 -0700 (PDT)
X-Received: by 2002:a05:622a:18a9:b0:50e:6302:340b with SMTP id d75a77b69052e-514621ff185mr135508241cf.53.1778177240620;
        Thu, 07 May 2026 11:07:20 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-514850cb131sm3655181cf.2.2026.05.07.11.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:07:19 -0700 (PDT)
Message-ID: <02ebf0e092a810cbb61eaab13a0cd6f46881c23f.camel@redhat.com>
Subject: Re: [PATCH] drm/dp/mst: fix buffer overflows in sideband chunk
 accumulation
From: lyude@redhat.com
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, 
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Dave Airlie <airlied@gmail.com>, Daniel Vetter
	 <daniel@ffwll.ch>
Date: Thu, 07 May 2026 14:07:19 -0400
In-Reply-To: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
References: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C5F4C4ED3A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ffwll.ch];
	TAGGED_FROM(0.00)[bounces-244625-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc in a moment

On Fri, 2026-04-10 at 04:19 +0000, Ashutosh Desai wrote:
> drm_dp_sideband_append_payload() has three related bugs when
> processing
> device-provided sideband reply data:
>=20
> 1. Zero-length curchunk_len underflow: msg_len is a 6-bit field taken
> =C2=A0=C2=A0 directly from the DP sideband header. If a device sends msg_=
len=3D0,
> =C2=A0=C2=A0 curchunk_len is set to zero. The condition (curchunk_idx >=
=3D
> curchunk_len)
> =C2=A0=C2=A0 is immediately true, and curchunk_len-1 wraps to 255 (u8
> underflow).
> =C2=A0=C2=A0 drm_dp_msg_data_crc4() reads 255 bytes from chunk[48], then
> memcpy()
> =C2=A0=C2=A0 writes 255 bytes into msg[], both far out of bounds.
>=20
> 2. chunk[48] overflow: curchunk_len can reach 63 (6-bit field).
> chunk[] is
> =C2=A0=C2=A0 only 48 bytes. Multi-iteration payload assembly appends 16-b=
yte
> blocks
> =C2=A0=C2=A0 until curchunk_idx reaches curchunk_len, writing up to 15 by=
tes
> past
> =C2=A0=C2=A0 the end of chunk[] into msg[].
>=20
> 3. msg[256] overflow: each chunk contributes (curchunk_len-1) bytes
> to
> =C2=A0=C2=A0 msg[]. No check ensures curlen + (curchunk_len-1) stays with=
in
> msg[256],
> =C2=A0=C2=A0 so the memcpy can spill into adjacent struct fields.
>=20
> All three are reachable from any DP MST device that can forge
> sideband
> reply messages on a physical connection.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index f2a7dbc5e..5261a4a54 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -789,6 +789,12 @@ static bool
> drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
> =C2=A0{
> =C2=A0	u8 crc4;
> =C2=A0
> +	/* curchunk_len must be >=3D 1 (min 1 CRC byte) and fit in
> chunk[] */
> +	if (!msg->curchunk_len ||
> +	=C2=A0=C2=A0=C2=A0 msg->curchunk_len > ARRAY_SIZE(msg->chunk) ||
> +	=C2=A0=C2=A0=C2=A0 msg->curchunk_idx + replybuflen > ARRAY_SIZE(msg-
> >chunk))
> +		return false;
> +
> =C2=A0	memcpy(&msg->chunk[msg->curchunk_idx], replybuf,
> replybuflen);
> =C2=A0	msg->curchunk_idx +=3D replybuflen;
> =C2=A0
> @@ -799,6 +805,9 @@ static bool drm_dp_sideband_append_payload(struct
> drm_dp_sideband_msg_rx *msg,
> =C2=A0			print_hex_dump(KERN_DEBUG, "wrong crc",
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DUMP_PREFIX_NONE, 16, 1,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg->chunk,=C2=A0 msg-
> >curchunk_len, false);
> +		/* Guard against accumulated msg[] overflow */
> +		if (msg->curlen + msg->curchunk_len - 1 >
> ARRAY_SIZE(msg->msg))
> +			return false;
> =C2=A0		/* copy chunk into bigger msg */
> =C2=A0		memcpy(&msg->msg[msg->curlen], msg->chunk, msg-
> >curchunk_len - 1);
> =C2=A0		msg->curlen +=3D msg->curchunk_len - 1;


