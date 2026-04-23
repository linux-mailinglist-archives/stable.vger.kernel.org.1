Return-Path: <stable+bounces-240492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F6nJtAh6mnKuwIAu9opvQ
	(envelope-from <stable+bounces-240492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:42:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A94784532AB
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C240307CEE9
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28B92F1FDE;
	Thu, 23 Apr 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="mzL0bUou"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D282EDD78
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951088; cv=none; b=NKFCkFt2hDClQIS+nIUSrqKNYFogpUVRwivXziiR144Hc33En3kbwkYEMzVull5EmL6chvPHlim4zpjSKQIRWYUYf6D5R3G0E3NjXXgW7V7RInFr9zqZgT10xOnvVjiHHVKbOoqvt63nelP+ncrJ63ymFmdEgFgbN4E0n/AUgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951088; c=relaxed/simple;
	bh=OkIYMUDB7SvQNczi+a/z9LNo3qE9So2rbHE3TpVf25k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mo/d/GexzSy6y/Q7mhMJe91wE3+Of+EdbvGv6Cy8FAVOlvK0HLm/WFPPKmnbK4IMcy4WJcFMj8oBEKTDWn64a9tF6SHz4kmw0U4k2qym+9wB6Dulb9ZMY/4U/X0svTMP1V3ZNQeThD70GVrYmaL9GNOLs4a4Tw+0R0ElSEuT6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=mzL0bUou; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dca00c1591so2033143a34.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1776951086; x=1777555886; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OkIYMUDB7SvQNczi+a/z9LNo3qE9So2rbHE3TpVf25k=;
        b=mzL0bUouKLN3I0aQkCndIJ38GOmwswmBhqhliTOrDukwSc6mZ4cEreR0tpARsWJtda
         qiRxLAAU65wNt+T08rNsnnwraM7hPyiEe+LpXZayM5+03oBBWvFQnTPHDLo677Opy8fr
         EP+KLsS9aQ2K2Z5qQ+OMv+pVfJjRjs9Xwwj3J8YPgckwlX2/mc7B0jqNpoF6ilwbi8jI
         ddCeJ4q5YMFLSoOn5i8KAApG2U4xKhBY00ulgv9+8b0O3n9rXYLa7/Z4P2gdqTlFkUWW
         i91p1vbhgrTooBfdgRIsnlYaQ1EJIjCt2lLK5AgugFBTEwIlfJLWJx9O+hK5GVtBkbz1
         +aZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951086; x=1777555886;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkIYMUDB7SvQNczi+a/z9LNo3qE9So2rbHE3TpVf25k=;
        b=qg8FMgLU0vJU6FxjbQwbJgrzQI2yv/jdIaw1WeTRNO3gicHlDs1ot6Xvp5o9n6z8Pt
         T+VDiFdNGwHQh0Pzdd8Sx2QdzGrvf9/zT2gvMYaPa2BUjc+ObkcnfcXXX73ASN5z2NpG
         VbdVHlpRcbz6Z152PTiwdFkLgYKwY+3zWq0mMKCevpPyvuoeSIwUZGjiflEpPrAMLMBT
         U5zR2QarY0gZlxOv5+pA9sVW9HBFWkHlEUh7gnX+NR5WnML7WWTDBEil2nQFjpUGbIMH
         E2oIOjwrPKLenYbqfxJ6mdSmmibuAdKZZm3c9nTdsJKNEBt9Feg2zmcx0yZvHh+zM/mj
         YHbw==
X-Forwarded-Encrypted: i=1; AFNElJ9DuPZ/xAXErAhZLp5NRVrJGkItIQKhwfIacHifqBSaevCzq167F0oDVNx6KxjI2o2MTSOVDP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuzS4e9zS5oz4kxhOxntlNBhoBCqG188QSocrCf8DA99dnkTE
	8nsK00TJp7yi6gBGRRDqbRrKsPTI2PB+I+kAleN8yFJUWcbZCb5X+OXBLosXoSAXZ+o=
X-Gm-Gg: AeBDies8DeV7soH0Rbs3o1bEEAHSdWE7FSfKQdVFIT1qY/ZOrANrX5IOIgeZE3NM2yL
	TPVKTEhuIZq2vOChQq8dbwkJ5QnkpbzOgsmhTXIhYNBRA82OKhX5+viOJxnlKSGmLVYEyNOzsz6
	NejoeB4X9LKjXlwtvKZ70639LM0r8K5otxgaLb615Lrg1nAcnV38vPIBFyTfGFbyqjKQJdnrfJ7
	yyp3Kxr7BuDbtKRXP8fkDnHzKOS+VZ1K3C05rRkkxHMMUfwPB0RKAYnXfYN5ZOISlxZYhfLqDXa
	7/4/CVftRAYYQMSGxWLTFv/SuhIBSJ8bCk80NsXTsOMX3EIvsZxXwwRQhR/97W6HIl5nC5h/ySp
	KYZo53aNYvd1ZCqj9moiOTnI45srIMdqpa6VLgSpwZp9slhonFJjtdRvX8Vs/ow6RsKXVjLyv2Q
	tbjFrE7B+nZ1XlHlWPwbPy5iHsJgiaMnPfwLqLE3CYRqMbLhtdng==
X-Received: by 2002:a05:6830:67d5:b0:7d7:d615:3040 with SMTP id 46e09a7af769-7dc951a8f7amr17141856a34.17.1776951085943;
        Thu, 23 Apr 2026 06:31:25 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b::5ac? ([2606:6d00:15:e06b::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm161750556d6.7.2026.04.23.06.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:31:25 -0700 (PDT)
Message-ID: <89390648a5ed37ccb61731d54b6241cfc6058882.camel@ndufresne.ca>
Subject: Re: [PATCH v2] dma-buf/udmabuf: skip redundant cpu sync to fix
 cacheline EEXIST warning
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Kasireddy, Vivek"
	 <vivek.kasireddy@intel.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "sumit.semwal@linaro.org"	
 <sumit.semwal@linaro.org>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>,  "dri-devel@lists.freedesktop.org"	
 <dri-devel@lists.freedesktop.org>, "linux-media@vger.kernel.org"	
 <linux-media@vger.kernel.org>, "linaro-mm-sig@lists.linaro.org"	
 <linaro-mm-sig@lists.linaro.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"	
 <stable@vger.kernel.org>
Date: Thu, 23 Apr 2026 09:31:24 -0400
In-Reply-To: <CABXGCsM8T4e8kaaO_bauHnN0yE5cxwkkcN+eAJWE8hnJ8RdSRw@mail.gmail.com>
References: <20260331061657.79983-1-mikhail.v.gavrilov@gmail.com>
	 <IA0PR11MB718531C51736C57114D6DC2CF850A@IA0PR11MB7185.namprd11.prod.outlook.com>
	 <CABXGCsM8T4e8kaaO_bauHnN0yE5cxwkkcN+eAJWE8hnJ8RdSRw@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-Upe9IeD/YcP+xQYdAbXn"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ndufresne-ca.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[ndufresne.ca : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240492-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ndufresne-ca.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas@ndufresne.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,ndufresne.ca:mid]
X-Rspamd-Queue-Id: A94784532AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--=-Upe9IeD/YcP+xQYdAbXn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 23 avril 2026 =C3=A0 16:49 +0500, Mikhail Gavrilov a =C3=A9crit=C2=
=A0:
> On Wed, Apr 1, 2026 at 6:15=E2=80=AFAM Kasireddy, Vivek
> <vivek.kasireddy@intel.com> wrote:
> >=20
> > Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > Will push this one to drm-misc-next soon.
> >=20
> > Thanks,
> > Vivek
>=20
> Hi Vivek,
>=20
> I see the patch landed in drm-misc-next (504e2b4ab97a, tagged
> drm-misc-next-2026-04-20), which targets 7.2.
>=20
> Since the patch has a Fixes: tag and Cc: stable, would it be
> possible to also cherry-pick it into drm-misc-next-fixes so it
> makes the 7.1 merge window that's closing soon?

That would cause the same patch to exist with two different hash, which is
generally causing trouble down the pipeline.

Nicolas

>=20
> The bug is reproducible on current mainline and affects users
> with CONFIG_DMA_API_DEBUG_SG enabled.

--=-Upe9IeD/YcP+xQYdAbXn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaeofLAAKCRDZQZRRKWBy
9LE6AP4zbpIjsamlcu/G6Lqh82xunsoqtFZgRGnace73ZbfDFAEA6PEngKC7M3Yo
K0RGNiwAl4iugWAP62doSTdmh9OX8Ac=
=JOLV
-----END PGP SIGNATURE-----

--=-Upe9IeD/YcP+xQYdAbXn--

