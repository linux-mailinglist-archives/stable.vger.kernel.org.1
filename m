Return-Path: <stable+bounces-242488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMOMKUH09GnJFwIAu9opvQ
	(envelope-from <stable+bounces-242488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:43:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418E4AEE82
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CDD7C3007AEE
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B126F3F20E5;
	Fri,  1 May 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="F514FPxF"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2B34D4FE
	for <stable@vger.kernel.org>; Fri,  1 May 2026 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777660986; cv=none; b=o7EwPCuwGWDUExMtC1J7aDgZc2oxdSLSfRLSHklMmnaEI4ep5687AwMI5o7mTZ1W2q37mZ60lMfFbGzKt8GjC+UzhG9iHU9Vp20TVhuU4z4B9YIMiYNuMO3fVr51gN8Mu4R6KIJiDbSyPtRvd5OFH8y35HVWWMURZHZhUNF3/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777660986; c=relaxed/simple;
	bh=NocLFeK+hCVRf4EUnEY/khrFsZuCMU79EngrzgN0pd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ua0cS1BWqx9h/A3mEtH4bS3arXj4JlVO0fBjEzNwVzOD/NmJyRK3TvNwxhkj78WqU/ndB1qaXrUPmNYyGRQMPdiOv9/3Q8wdGYSZq8XwUH5r/LG1264Sz7YJZlKg6+mphP8rLxf3e1CxfPNr8OcxyKZ0fMFZOrM+62v2s4/3vVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=F514FPxF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506362ac5f7so15976871cf.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1777660983; x=1778265783; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6IPN7cSeBDmLbPswg8U4gMRTv7jzrlU78cVvrGOecvk=;
        b=F514FPxFuxz0ZGucn6vp5yNGJSyyuLnp6yGSl5awOU6bE2HMzqkPyJX3MXztanq+KZ
         QcL31K/eSYfHSBcWxXU0HlGeH/7ADQoAB+RWe1rUnSwn6ECLMjqO4ZE9HUIII0irfzar
         MVP+u+NAUVCt64WjQjaw8gWvCfssmrmbhRhFgX0vR+iMCQn/xxQ/VCI9y8uloUWzwmwQ
         WlNViFZBxvgjcp6AKhi5BXNtVmagqWKawTLs72UsntdXmOymybpCLicY1ph7uFwZBVG9
         3GwrPSC0WhbRfVXElRPlr3K3kBG1jxBT9uXK7f2hM4e6Fv4ks0o7hXbNQdQ7nCT44bpW
         mClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777660983; x=1778265783;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IPN7cSeBDmLbPswg8U4gMRTv7jzrlU78cVvrGOecvk=;
        b=lFppG6Qbmgph4O5IB1P43SksckRhHZ9lNbyTBOW8UmfjnvnFf4JGY3f3xZspWvWD3K
         eCdeDOlaVSZISsaDSd4KKhzoiM359PTnEbcaTEWAjWNXM9EEmQKZScTldUBKpva2zGww
         JfOj8WG3L2u1F/SSX91aUoQ6iKO/sR98Oa9NqU2szMbazp6jR+gYQgRST+eVVXjYL2+s
         dx3RHYA+M/TSHyyt0KLTqyA0vWZZ+F5bykdcaCFaE9zihk95wgS8WO7cbOc33HwX4qLo
         Gzu03qONNjVaVbw04s6xbb9ehgrhiwChcKscj71nEy+eAtS4hKZQBEZlWfoQB3ifiqwy
         vfQg==
X-Forwarded-Encrypted: i=1; AFNElJ/0uOtzlkC+tMw+aKY8P61na8DXLUwKTFJcnR79Rxgyai1LRhpXJjAEPyNyOWsxt9ssRzVIkq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtkckhGfE5FeqCRHl52bvqf6E6Ph25ZDOPSOyH28K6PgjLa+z2
	lm5JqiT61V5c5iOXUJo0DEdCFmOs8fbnRW+fKIGHsNjCWQnIrrTQh4ruf08oCdx7Opc=
X-Gm-Gg: AeBDiesHFJfoQsq1dIuvhp1bs+AU/ZLWF9dXCFiSWgKTkgiJ7HtJX5rjc8tDVg+wwHL
	iTZcHYtvYh2HbEPtToPKdjwnPsEK26NH3XrZmggMFhzJKaarkvBrWmx53uTPckrQqXgmVXuOgfS
	XE6k2IH2sncXnU2sMlAq2wL7mLRAEEu54N+oGGA/XR+v3Bi4ItzZH+iHRme1eptJkirAikVwzIX
	Qg0FVVv88DtsPfQSQj2VEXchaPE06Cgk+jcmJKKQRe0saov3WryXvZRJ+YvKWDyjLzFUTMLeV1I
	rPmfUEVj1jGNyZYJ8JGjI+YGldC8NrNrj8SypkMyhz3WatuMxPQve5953L+umdxD5/KJ2yxIbub
	oUk8SjCKFeNgiE17gMpaHRRJdNeJJweWO2ltDRuF1dQD+KVkUzsB50lBwM2oLQMNNCLy1q/MKtZ
	Ku94qIxb0LnFb4iKvtZJ79cB/yujmnfZWsq/bcYGtbQYIbaxA2GPvvQGEk+FfMmoJ6
X-Received: by 2002:a05:622a:480e:b0:50b:445a:4139 with SMTP id d75a77b69052e-5104bfcc501mr5650901cf.54.1777660982833;
        Fri, 01 May 2026 11:43:02 -0700 (PDT)
Received: from [192.168.42.160] (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51043c1b8fdsm17375141cf.6.2026.05.01.11.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 11:43:01 -0700 (PDT)
Message-ID: <8ac864747a72c2a02db277438c7ed441b38aa5db.camel@ndufresne.ca>
Subject: Re: [PATCH v2] media: mediatek: vcodec: free working buf on error
 path in vdec_vp9_slice_setup_lat()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, tiffany.lin@mediatek.com, 
	andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com, mchehab@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	laurent.pinchart@ideasonboard.com, hverkuil+cisco@kernel.org, 
	benjamin.gaignard@collabora.com, p.zabel@pengutronix.de,
 george.sun@mediatek.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Date: Fri, 01 May 2026 14:43:00 -0400
In-Reply-To: <20260429065221.175159-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260429065221.175159-1-lihaoxiang@isrc.iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="=-yncNRVXEvUL82zIfX7FS"
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9418E4AEE82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[ndufresne-ca.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[ndufresne.ca : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242488-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[isrc.iscas.ac.cn,mediatek.com,kernel.org,gmail.com,collabora.com,ideasonboard.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[ndufresne-ca.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas@ndufresne.ca,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email,ndufresne.ca:mid,ndufresne-ca.20251104.gappssmtp.com:dkim]


--=-yncNRVXEvUL82zIfX7FS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 29 avril 2026 =C3=A0 14:52 +0800, Haoxiang Li a =C3=A9crit=C2=
=A0:
> Add an error path label in vdec_vp9_slice_setup_lat()
> and call vdec_vp9_slice_free_working_buffer() to free
> working buffer to prevent potential memory leak.
>=20
> Fixes: 5d418351ca8f ("media: mediatek: vcodec: support stateless VP9 deco=
ding")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
> Changes in v2:
> =C2=A0- Remove two functions' return value check and error
> =C2=A0=C2=A0 code, since these never fails. Thanks, Nicolas!
> ---
> =C2=A0.../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 12 +++++-------
> =C2=A01 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9=
_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp=
9_req_lat_if.c
> index cd1935014d76..5a424d738fed 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_la=
t_if.c
> @@ -1166,24 +1166,22 @@ static int vdec_vp9_slice_setup_lat(struct vdec_v=
p9_slice_instance *instance,
> =C2=A0	if (ret)
> =C2=A0		goto err;
> =C2=A0
> -	ret =3D vdec_vp9_slice_setup_lat_buffer(instance, vsi, bs, lat_buf);
> -	if (ret)
> -		goto err;
> +	vdec_vp9_slice_setup_lat_buffer(instance, vsi, bs, lat_buf);

You forgot one essential step, which is to remove the return 0 and fix the
signature of vdec_vp9_slice_setup_lat_buffer(). Otherwise someone somewhere
these days will add it back base on static analyzes.

Nicolas

> =C2=A0
> =C2=A0	vdec_vp9_slice_setup_seg_buffer(instance, vsi, &instance->seg[0]);
> =C2=A0
> =C2=A0	/* setup prob/tile buffers for LAT */
> =C2=A0
> -	ret =3D vdec_vp9_slice_setup_prob_buffer(instance, vsi);
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

--=-yncNRVXEvUL82zIfX7FS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCafT0NAAKCRDZQZRRKWBy
9AkeAQC/nCc//1RNy8QZAEKkoAfSlPNlsSTvZa319kmNYUGXLQD48bQPV2/ZQqpv
raeVmn5f4p0Z4LwV12HpdtM/hgcdAw==
=ogX7
-----END PGP SIGNATURE-----

--=-yncNRVXEvUL82zIfX7FS--

