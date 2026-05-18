Return-Path: <stable+bounces-249354-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGWdEp1RC2qWFgUAu9opvQ
	(envelope-from <stable+bounces-249354-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:51:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E070571BFF
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49520300D564
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB9E382394;
	Mon, 18 May 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmlMYL67";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dsas56wn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A05382293
	for <stable@vger.kernel.org>; Mon, 18 May 2026 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126677; cv=none; b=JVV1MnlwQsuu4fZfwuxP14+uQyUeUaVt6gLmod+GpzeVa8CKfdAR2d9DLTD4VyF6rmFbBGgtp/KmVfZhID9GgzG751E+k91oKDRJ2lw/VYT6QSqRJqsiKtfpnP0iM60E7kqPhNeHPi92qaUdNAyFWNKrhrB0W8YCqAxQ2hUsfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126677; c=relaxed/simple;
	bh=91smVd3QAkXEQnAcUjgtO9+U3ppX/svzKoezLQCwKvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YEOgkGbOqHH9MVtFbQxLm2Wuo6cTgVZHAmTYOAVXvbIN7mHdIGnNW6o3W2/eNsTKKp11u6Ufv4QBS2vzJq0rjVDKoN8m1Hb5EQRlJ6hpjLM6CPMfpHdriEQeFg7UnePqNutZcNAMdBVOKSI8o1bnDXrX/X8h94dPt+qESPbzfMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmlMYL67; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dsas56wn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779126675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0D/2lnvFHwbgVt4+FwCYJ0wron62f0hNfGCEfp5oz8=;
	b=RmlMYL67isOs9QezpHt3dIuLZf/SUC7/zW5wMOkTNDeiQtmYaj06H2TMwKBNh80IgGsnrc
	6wgV3Gh4JC+5de9voNhPDVjJokDO99qw3hvyuGN2vwAhOy08C3dwI1hVB9YX+zn0OoCynz
	xsphMAQ/ZHjb7Nucvso87piyRzvy1OY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-i-OzND7qMm6fkyiUKXIjHA-1; Mon, 18 May 2026 13:51:14 -0400
X-MC-Unique: i-OzND7qMm6fkyiUKXIjHA-1
X-Mimecast-MFC-AGG-ID: i-OzND7qMm6fkyiUKXIjHA_1779126673
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8acafc224a8so87958936d6.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779126673; x=1779731473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e0D/2lnvFHwbgVt4+FwCYJ0wron62f0hNfGCEfp5oz8=;
        b=Dsas56wnQL0yhJ486qacPCIGx/FrA6FPfPEM2H3MXY1LPTCuDpNvLiPfO6xylDvcqP
         ejAL89z1IO8oZVnlD9eS4zV72BwKLt1++ADs0qH805Eqx5sQBZOF9PuHQW+p+e8jpx/P
         iVUvgm3qlkrRVxg9zsTSjnPME6vjiVYNsYdDYmjvIEZcgnQr9F9q0qhy+1NBUbIgMCQB
         F7QfhM4CHWGa0tyFhIoXKuCku+TcWMDYhRP1C6uRa8GMboptj6ZDVnIvcMBaU7I4adyX
         uujcJC8a5AYhBqzXODLbiDCvQfuxq0oLoX6ofKszTCNffPYwmLfTaTvWUuncTlgvPXna
         q4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779126673; x=1779731473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0D/2lnvFHwbgVt4+FwCYJ0wron62f0hNfGCEfp5oz8=;
        b=od4Ami6NR/0Klk/xrpgDu8kuhDJyN6u6w2Q9X1shF+ekzLoiQTtaOUnfbbfEEIPwh8
         hauTEZwOppwU/yaUG99DgGLeP96CT1EAh67+iuVoiICFxDRwTCwkUuk8Cg7uOauwzTjH
         29/1utF3clR9WGrUlu94qT7o919x/bQnp8MPhHjlf96gBhpO50SO8rVpeD+jlg7NVWFq
         TON/bY6JDHwIddhtvplafDCbW8+PxAiQYCv58vIOpVWQ4/uyNVEFkavs88JUrE2Yif15
         f7NAzNF7E1VgbmVzqbrX6Gr0X7RSDvClqA6GbiSs6bF92YjnDOv7C/yCF1nqHyoqMC66
         N0WA==
X-Gm-Message-State: AOJu0YzGExNUbCawiBCsELJa4jPebOCr0WKKEMoTIlHewQ1h4jr8dYXB
	ZbQmLsU+0YjZUqz20LW+D3PcsCOW9o7mvvKV4grTUIxitmnoj5jmrdVsOTpabkr099VKQXrPdqa
	b4J/ZZcuDmpynMPmNoNkexlf5x+yWZihq3SinkBMB0uZuT2SAHfACILX5rA==
X-Gm-Gg: Acq92OFiqjgmON9mh2mY691YKtM6c1DGG0sN0m8l1ZH3/S7IdiVCc1wX1rtXAc+T5/Y
	HhO3HDExO61eOk+x1q7/W1+sGgxSht8C67kd+IugI2I0bIer3QkbXE8zSiMjdKi/9ztbhX/HCI1
	kr7ghEEjyqHefubkuMcKjidmYtNOOblAGMqD1fNGEN3FSBfhTrXRa0VrMX35Fvrj1YRWvEyVjph
	aIRZ49jPo6dfTBJw4gwvBVU9etF1vdFRrmQDMvMoTNnJ0omFoJn8AG0OVVd6MEBAuN2Jku0SRF8
	EO3UG5cFxaA3MGRvE9PASoblwucMpbchN940AXTvAA1UWvJVRq/4byC68ZJSchlqFmqJ0CQT8UH
	IVuFdVADy/MCClrQJ/Q==
X-Received: by 2002:a05:620a:170f:b0:911:5568:364e with SMTP id af79cd13be357-911cea09f95mr2541778785a.37.1779126673379;
        Mon, 18 May 2026 10:51:13 -0700 (PDT)
X-Received: by 2002:a05:620a:170f:b0:911:5568:364e with SMTP id af79cd13be357-911cea09f95mr2541772085a.37.1779126672725;
        Mon, 18 May 2026 10:51:12 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91435ca2855sm449582485a.40.2026.05.18.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:51:11 -0700 (PDT)
Message-ID: <b8ca839c8561ad301f24921ea4c37b2cb129c4d8.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp/mst: fix OOB reads in remote DPCD/I2C
 sideband reply parsers
From: lyude@redhat.com
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, 
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 	simona@ffwll.ch, linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 13:51:11 -0400
In-Reply-To: <20260510201733.2882224-1-ashutoshdesai993@gmail.com>
References: <20260510201733.2882224-1-ashutoshdesai993@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249354-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ffwll.ch,linux.intel.com,kernel.org,suse.de];
	FROM_NEQ_ENVFROM(0.00)[lyude@redhat.com,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E070571BFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc in just a moment

On Sun, 2026-05-10 at 20:17 +0000, Ashutosh Desai wrote:
> drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
> message and then unconditionally does:
>=20
> =C2=A0 memcpy(bytes, &raw->msg[idx], num_bytes);
>=20
> without checking that idx + num_bytes <=3D raw->curlen. raw->msg[] is
> 256 bytes; if a malicious or misbehaving MST hub sets num_bytes
> larger
> than the remaining payload, the memcpy reads past the received data
> into whatever follows in raw->msg[].
>=20
> drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw (noted
> with a /* TODO check */ comment since the code was introduced).
>=20
> Fix both functions by using a single combined check
> (idx + num_bytes > curlen) before each memcpy. Since num_bytes is u8,
> it is always >=3D 0, so this strictly subsumes the simpler idx > curlen
> form and no separate step is needed.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> Changes in v2:
> - Drop separate idx > curlen check; idx + num_bytes > curlen with u8
> =C2=A0 num_bytes (always >=3D 0) strictly subsumes it (Lyude Paul)
>=20
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 170113520a43..9416a48804c8 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -871,7 +871,7 @@ static bool
> drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
> =C2=A0		goto fail_len;
> =C2=A0	repmsg->u.remote_dpcd_read_ack.num_bytes =3D raw->msg[idx];
> =C2=A0	idx++;
> -	if (idx > raw->curlen)
> +	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw-
> >curlen)
> =C2=A0		goto fail_len;
> =C2=A0
> =C2=A0	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx],
> repmsg->u.remote_dpcd_read_ack.num_bytes);
> @@ -907,7 +907,9 @@ static bool
> drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
> =C2=A0		goto fail_len;
> =C2=A0	repmsg->u.remote_i2c_read_ack.num_bytes =3D raw->msg[idx];
> =C2=A0	idx++;
> -	/* TODO check */
> +	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw-
> >curlen)
> +		goto fail_len;
> +
> =C2=A0	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx],
> repmsg->u.remote_i2c_read_ack.num_bytes);
> =C2=A0	return true;
> =C2=A0fail_len:


