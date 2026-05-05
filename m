Return-Path: <stable+bounces-244235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E6AGEMt+mlXKgMAu9opvQ
	(envelope-from <stable+bounces-244235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:47:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EDB4D24B1
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC04330230D2
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056FA480DCD;
	Tue,  5 May 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZIRr/e8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4F36EA8A
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778003255; cv=none; b=Kn6kf5XBMmGSq4KL3qbNQlAcbwLszcW9QD7sdPAxQu9XBDXO3eShk+64a6gV1/P+15gfV/SO3o4tgk3R00ottD1Sn7nNYKd/gJ40ZwMCklgCvwQ97aco2JCfeEPkID1c00zRpRr7hSgoQgjITrkQ/k6rQJNUz9O1p/uxCQ1k4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778003255; c=relaxed/simple;
	bh=lwsN6Ij/KA7Fw1q7jKImkYdqw44KrNH+364KKSge1SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiwqu1kDVHs/m0UtQCp237wShdRE7d+8/qo7l5DtCFP+GDuXChSM+HyRBG7qp89VmC8jolwEuccaDB3Ya1M95Pn4eNQZzba1a7BtI1M2dZ6QKmvHCW/xZaLUc4webFolnOziWICK6zjABkzsPTGuaIwLKtMoVXYg4nbn3EH+wE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bZIRr/e8; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so1165742b3a.2
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778003254; x=1778608054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgpomHj2+eyNGfRuF2OuoOdQ3+F2BeBzWU4tDvGhfTU=;
        b=bZIRr/e8W5EjM2XfvrN9gqkBZnKqS9dPEru1np4JzfTJkETBYuKrvORrzbZDPuzsnF
         JTM5W9HjtBBUlkwcejKL9V/iv8cYDjE6EXoEVS+aT3KOA6BCTjnH52us/uPQtYyYSDkp
         eFaHWfzq093B311l9KBWppKuiyATGdgWCee6BoeQLC896ro3bgRzcVP+NH3/2YozDKXu
         EkJy1rhnuOteYdvZ9v/YTkRay3BF3SI+rpc+yMkaH8f3F8yZ/riIpEndM+uPf9qsIzac
         uPeHl540RD0LhQi8cvqlKbwdtk6SfgnRqF478l5PbtuIbQlM7c5SLkk1qnehuv7zwkik
         6BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778003254; x=1778608054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgpomHj2+eyNGfRuF2OuoOdQ3+F2BeBzWU4tDvGhfTU=;
        b=JanBJnOI+kWE/Me1bfaKP47tqcm+8xMJhXQM/2KT+/NOSy590nh+UKWZXHcp25yj33
         i5DBkv8eHaiZL0QloxYNlrk/I2SWF5mvOz1B3ml9xNCJLi/TkpwJvZDFkZKFkLeycQxT
         Q04rBZ+xO7y3AgX/8LHyKbVXu7iGDEz+NC3kcvd/c5MBs+zxwbu8SdthUeLkJzN7qRhw
         Ybz6gKorIaLXO9YctFZlFsH1fgTrnt1Bc6BgRKG7LeUdnu0kbwwjL009OmIEs0i3GxlA
         JzMiDfu4uVuhXvgTBZL7kVerc/YhYWR8/Fg9R7Xc0far9SaMMkJdwNLVCTmKBu5wAmgC
         XOgA==
X-Forwarded-Encrypted: i=1; AFNElJ+UcU6BdWHJJvf5PilVUd09t+Th2KWEsOc44lvEs7KGQODJWUB6p9H7k1WCxszVo6wJPD5hyAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9gGjRzyHNTu0/uI4fOWBfHMg9m5nndWwoBSvIX6t4vkeLy0V
	Uni4d3Bpd/ofDgFWIYEsy47FvVn6kaS3SRI1bl/0OC3+I85lVWq1h39lI5W8Ds5yHA==
X-Gm-Gg: AeBDieu7Ah9CqD816oXdRuWGsM+Hy9RFruCS7FIUerxolA9+apg36MKZhs4BqeNOJju
	Qp5trMCW9F087RCRQ2N2YdnCefaPQASwux/E4y2X45k4/G1XMUpeHf4vce+81mz9Zm3zCYolvJg
	eJc05kflwp8WldSs3ltz5R+005AZxvet5XX84ZASyekolXmIIzSrfFu9bo2ziE5VlajDSxbXKTa
	dCUK/g3DhsaA31ny+04SvLkSOT0WCa7N+ZpRWwnh8YkexLOoJzm4e5M7mfm/K+T0ezX3+IqvpQw
	D6OTQjtDpotlTH+BlZghM+yejhKmLIckGX/AyBxOASb9hPeiXVAebZvFMcnIqrBWCwiDaMG4pn6
	M9I+uMWT5ZsZfdcYGO1ZReya8XyQGz17+SG4hRGtuZOB4H36FJAkOnd6CF33/6S08BE4haX78rq
	/ACyqFcJzqpLTxd+Pyey45uzdEk7lcxUQw+1XsKL2KbEfKp0329oXfha3d30g52Ljs6os21WBE7
	0QU3A==
X-Received: by 2002:a05:6a00:987:b0:82f:98c:1465 with SMTP id d2e1a72fcca58-83923e981dfmr4030032b3a.27.1778003253088;
        Tue, 05 May 2026 10:47:33 -0700 (PDT)
Received: from google.com (51.86.127.34.bc.googleusercontent.com. [34.127.86.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8462sm2840483b3a.38.2026.05.05.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:47:31 -0700 (PDT)
Date: Tue, 5 May 2026 17:47:28 +0000
From: Benson Leung <bleung@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Init mutex in
 Thunderbolt registration
Message-ID: <afotMJqvwYevy6U-@google.com>
References: <20260505053403.3335740-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="89axrARWOPcEMaPt"
Content-Disposition: inline
In-Reply-To: <20260505053403.3335740-1-tzungbi@kernel.org>
X-Rspamd-Queue-Id: 04EDB4D24B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244235-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bleung@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chromium.org:email]


--89axrARWOPcEMaPt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026 at 05:34:03AM +0000, Tzung-Bi Shih wrote:
> cros_typec_register_thunderbolt() missed initializing the `adata->lock`
> mutex.  This leads to a NULL dereference when the mutex is later
> acquired (e.g. in cros_typec_altmode_work()).
>=20
> Initialize the mutex in cros_typec_register_thunderbolt() to fix the
> issue.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 3b00be26b16a ("platform/chrome: cros_ec_typec: Thunderbolt support=
")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Thanks for the fix!

Reviewed-by: Benson Leung <bleung@chromium.org>


> ---
>  drivers/platform/chrome/cros_typec_altmode.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platf=
orm/chrome/cros_typec_altmode.c
> index 557340b53af0..66c546bf89b5 100644
> --- a/drivers/platform/chrome/cros_typec_altmode.c
> +++ b/drivers/platform/chrome/cros_typec_altmode.c
> @@ -359,6 +359,7 @@ cros_typec_register_thunderbolt(struct cros_typec_por=
t *port,
>  	}
> =20
>  	INIT_WORK(&adata->work, cros_typec_altmode_work);
> +	mutex_init(&adata->lock);
>  	adata->alt =3D alt;
>  	adata->port =3D port;
>  	adata->ap_mode_entry =3D true;
> --=20
> 2.54.0.545.g6539524ca2-goog
>=20

--89axrARWOPcEMaPt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCafotMAAKCRBzbaomhzOw
wiYUAP9t4B8VrD/q+NsAmZTAXx6uBt1fGtt47f6A5GGpcwUnvAEAgl/jN09WGS/J
0KFFd/pfEjUIqc1NiX5N3z7ao1t1bQM=
=JajR
-----END PGP SIGNATURE-----

--89axrARWOPcEMaPt--

