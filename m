Return-Path: <stable+bounces-242489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /3IfLi/19GmaGAIAu9opvQ
	(envelope-from <stable+bounces-242489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:47:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E944AEEEC
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95C7A3027694
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 18:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D9C3CD8D2;
	Fri,  1 May 2026 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="XGON0lWH"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26D336B04E
	for <stable@vger.kernel.org>; Fri,  1 May 2026 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777661027; cv=none; b=mME/GXgYAToH/6u3yKeKCtgX92q6k0FFettETqekF9XlEXpDR2dtP9Leg8jz3cIdKSC22C8o6yuhia/QWm9hc729X4esgq5PDIgEvn0KdYIg3iGISS1bYbAWxb6WfsQf1RFiAGI6RBiciNjBwD9XHHZc86eTCWRteFAH2iP1byY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777661027; c=relaxed/simple;
	bh=2dFQtxEBStWKwzBnikgKADbJcEf1D54n3gMLhcCj368=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhX0W/rWwBlQeygXxFj0c8HP82P5Zek89c8hqAra+eYJH5ACo+MlnkVD6+MvlMaOsukrqbtk+7qm46xf/6qEwPxhDbKYjxKYh2fzMfbETvaneZcG5nNHyBxWlBTbc8owNPdwLBKrDTMxY4gK4JdAgrNRvKpDlzpazDmQq1Ju5ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=XGON0lWH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d75bfb259so14584501cf.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 11:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1777661025; x=1778265825; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ulsFcfU93D70Sa+J1hAyL4OPSDEMDmywDdF1UctN/Y4=;
        b=XGON0lWHdpT77nm9b4LnkHRFGZCpv0393vDSYZgAl7hMVphUKPy7RfzqlCDVv7obFD
         tONvKkUnRfLgdavbynPitxU/FhO+GYdKPgtfv520Wc8EIcBvDJlM+ziVeY9yIa+bVw0W
         StfDR1n3S7F0+KbnlsfmbDNw/ESX0Fz5WVoK18dWZliMgiqzLPKVtJ1JfBJRPpMjMslZ
         VQMNJyDjqePY8xLyuIBoBLdKEc74L+KElVlKDzf9DGpN1oeAmj37pUfi8CH90CaJERs6
         PO/IY9rHBb316DNwH//OdbfP4W+4DnrEII1fs/CcU2BmEnZw+5m7YUru4V3aMdgsJkBV
         azgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777661025; x=1778265825;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulsFcfU93D70Sa+J1hAyL4OPSDEMDmywDdF1UctN/Y4=;
        b=R6kBsjCpNCd/NwAxnZlYJZeAAfyeo+0xF7M95MBtkBMJWpFQwmohFaeQaZjUtCIkw4
         XtpNARLHQNJANE5NvmK6lXRUeX3IizMocebJIHG+7on0gqSwIodOIeqKqwgDXevcsWtJ
         MxCO45Glp2MtwfjeiUP4wIUD/rFOhScMHtfJ86L5sW6IXIZXDc7grc8uRLoliOaNRIFO
         Zudj/JaLalGnGFox8WiPSDB6PXhqZgCvHoP81WI5Qoi3fY+yAx/Uhgi+Vg3LjBlv9CAs
         cLwYvkMk0XCZMp2ofbewZr8A60xJeMaxd2a99gPD/PQMcM1y8g4xCAOSb3Ivb46WC13i
         zT5g==
X-Forwarded-Encrypted: i=1; AFNElJ/WG+zUI88M4L9qjtCfJuzvZD/JHhBiLNyJBQ5WksYqjLGdSjkH3LO11voLXRgIICQKMehzifM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUo6uc5tBQ1VS1fdwcvZfnkVrCWyacv1VGx4z+VVuvuFD3nNBd
	lDGueaP2WMQjRJ/DTljIvW9rAfSiyZ+4VcVqSHXoIAXwpSG76Lju69itLkkIjzODt/U=
X-Gm-Gg: AeBDiesfoqODViqFKwxjvhbjZXQ25cuDDm8xDknfoR9lrKj32S+5uNhEzktwtBZAm2F
	VfUQkIlUOOp/nsu2ttToKtvn+fva7FWp5X0ZnTDJi1tFJMfFcKFg9rbz3E4j4/5foRx8O0ivHFU
	TmgTeYlgNRgVAlqnmZvv+WwV3cY0qL5RalNqp2v2kY0PIvxZzjpzAsZ6Ay4x3BxMWg6EsgTzyhg
	9qCBOkLsIzBrUenkmWkIGhET/iqNPY2uNkNM6jHgRWqyQ9bqmYz+SQSKTbd/ghXOSou0k+ugCQn
	CvY+NMRfQrGgNFKRenMqw6GyYjYDmPfqh+Qw1O1n/1y7RxMMYVbRq/DVVAHQzWNNW/CB43Lu2E5
	gQAFeCeiCaAjd3EAX6Ir62VQc0vYRZ3uH5zKSrKng4HXrEOWKPKM35mvVoGmNbDrTxNmi8KyeRB
	iBIRFN2dYBoCE0n5BsTIi+nFFXhHQmx5i6TtXbYEMMTznSucXb/Lg64Q==
X-Received: by 2002:a05:622a:4805:b0:50e:5ffd:dec2 with SMTP id d75a77b69052e-5104be45024mr6935901cf.1.1777661024659;
        Fri, 01 May 2026 11:43:44 -0700 (PDT)
Received: from [192.168.42.160] (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51041ddb598sm18992271cf.13.2026.05.01.11.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:43:43 -0700 (PDT)
Message-ID: <fae38f0f4ab8e8176cb6c5a37246e7aa5b5409d8.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: mediatek: vcodec: free working buf in
 vdec_vp9_slice_setup_single()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, tiffany.lin@mediatek.com, 
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com, mchehab@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	laurent.pinchart@ideasonboard.com, hverkuil+cisco@kernel.org, 
	p.zabel@pengutronix.de, benjamin.gaignard@collabora.com, 
	xiaoyong.lu@mediatek.com, mingjia.zhang@mediatek.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Date: Fri, 01 May 2026 14:43:42 -0400
In-Reply-To: <20260429070119.181876-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260429070119.181876-1-lihaoxiang@isrc.iscas.ac.cn>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-aMrOnipeNucjfzPvuk1Q"
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 10E944AEEEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[ndufresne-ca.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[ndufresne.ca : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242489-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[isrc.iscas.ac.cn,mediatek.com,kernel.org,gmail.com,collabora.com,ideasonboard.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[ndufresne-ca.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas@ndufresne.ca,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ndufresne.ca:mid,iscas.ac.cn:email,ndufresne-ca.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


--=-aMrOnipeNucjfzPvuk1Q
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 29 avril 2026 =C3=A0 15:01 +0800, Haoxiang Li a =C3=A9crit=C2=
=A0:
> Add an error path label in vdec_vp9_slice_setup_single()
> and call vdec_vp9_slice_free_working_buffer() to free
> working buffer.
>=20
> Fixes: b0f407c19648 ("media: mediatek: vcodec: add vp9 decoder driver for
> mt8186")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
> Changes in v2:
> =C2=A0- Remove vdec_vp9_slice_setup_prob_buffer()'s return
> =C2=A0=C2=A0 value, since it never fails. Thanks, Nicolas!
> ---
> =C2=A0.../mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c=C2=A0=C2=A0 =
| 9 ++++-----
> =C2=A01 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git
> a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if=
.c
> b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if=
.c
> index cd1935014d76..d034d84ad7f1 100644
> ---
> a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if=
.c
> +++
> b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if=
.c
> @@ -1808,17 +1808,16 @@ static int vdec_vp9_slice_setup_single(struct
> vdec_vp9_slice_instance *instance,
> =C2=A0
> =C2=A0	vdec_vp9_slice_setup_single_buffer(instance, pfc, vsi, bs, fb);
> =C2=A0	vdec_vp9_slice_setup_seg_buffer(instance, vsi, &instance->seg[0]);
> -
> -	ret =3D vdec_vp9_slice_setup_prob_buffer(instance, vsi);

Same as previous patch.

regards,
Nicolas

> -	if (ret)
> -		goto err;
> +	vdec_vp9_slice_setup_prob_buffer(instance, vsi);
> =C2=A0
> =C2=A0	ret =3D vdec_vp9_slice_setup_tile_buffer(instance, vsi, bs);
> =C2=A0	if (ret)
> -		goto err;
> +		goto alloc_err;
> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> +alloc_err:
> +	vdec_vp9_slice_free_working_buffer(instance);
> =C2=A0err:
> =C2=A0	return ret;
> =C2=A0}

--=-aMrOnipeNucjfzPvuk1Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCafT0XwAKCRDZQZRRKWBy
9DtqAQC1Dg6Zdwpp1TbLyQpoV3dfXpp0ZnEkO20SH8pEBubrUgD+MoWNudTp/uFM
Wq9Gi27dGGRSf9vDASBpXnzMdkgrVQQ=
=o8rD
-----END PGP SIGNATURE-----

--=-aMrOnipeNucjfzPvuk1Q--

