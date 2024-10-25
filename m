Return-Path: <stable+bounces-88183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547429B0A61
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 18:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3154F281B92
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B0A1FB89E;
	Fri, 25 Oct 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="g7/DMDLo"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED9915ADAB;
	Fri, 25 Oct 2024 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875318; cv=pass; b=ZKovqU/uEq5P79KFvL6xocXghrBMfdvc5+VSiPQlrCHDPjDKs+f9pf6zmn6nizAIHqL/EcjTcwgPoNw4GzXrEb9wIu67HBaUbZ6UP7l+foMYz2yO0QKvS52cVGUDxWLAEfpZmnwuG42OkX2Qpw48j20j0MTvmp3kK5zXOoxaf8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875318; c=relaxed/simple;
	bh=TkHNarZS4pSLxIgyzxiNyeSWF41bzLLV19/JuUBB2s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS4fdZi5cKeUKdRdgPhBToOU+FZ3Ape23sQBrMjMFKey4vCz+mqhiKRl9+ZiHj8Y7dnOcQ+k/Pcymra2xvqUALuId2d6Vaq334/rYjW64yK6PGplYQKqda8bXNwiHCVRJv9mLHXPpYsAOSfuMM83klnX8xiu8icyd6HuKLAquRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=g7/DMDLo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729875298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YUmaYjF4Ps/jgwwt8/w3jiVpmXPW2tS7pX9mbRYmKXRZK39X0LzUbrpNsAW/PfGnOyUoKypbs5AXCtCFJy1PdrOIi3dM8jDm4WJEm2KC2GHliBd57mz5h0uUEtCoAAG5BQejcx9rEz3Y9u0VyLsDHstJR7lhjVknQdo8yNRTNcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729875298; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Jr7SWzsSYm+eYx+rG17jTZS+t8t8d9UsF7LOAdFCyXQ=; 
	b=FBpNYlBPzft95xuA6saSFAM8If2KmlhJyq1gTBwMJ1rPlkGLtWCzLwOMd58g6rmXtGoHy/D+izL67aHT8pQcIVW2GXdMou6+jkTEZcTBC4GChPeX+Zmm0hG/uHRW0RNpIk3imdjFnSEBBactOCQshAiO0H/nONYt5TwuMUoF4eQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729875298;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Jr7SWzsSYm+eYx+rG17jTZS+t8t8d9UsF7LOAdFCyXQ=;
	b=g7/DMDLoZaY/789N1WdT8gQwVjsqsZs1RHPJ/kd1nslYuOnUFIDAgI3lET6SIKDF
	tDoc/rylfl3nprWWf4j6YfXzpTcJH1Fu4NANAm4kJ/YlINsT6c+ZJQyUF0ltSGA41NO
	1mQkP13kaW0Jy/ntB7L5hNbkxju3IoMXpkyBPtCs=
Received: by mx.zohomail.com with SMTPS id 1729875295395343.5082836686537;
	Fri, 25 Oct 2024 09:54:55 -0700 (PDT)
Received: by mercury (Postfix, from userid 1000)
	id 6BA4510603F9; Fri, 25 Oct 2024 18:54:51 +0200 (CEST)
Date: Fri, 25 Oct 2024 18:54:51 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Amit Sunil Dhamne <amitsd@google.com>
Cc: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	rdbabiera@google.com, badhri@google.com, xu.yang_2@nxp.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: restrict
 SNK_WAIT_CAPABILITIES_TIMEOUT transitions to non self-powered devices
Message-ID: <qycbz2nxyh2i2yebmuvzzixxou2jvrojvqlfyfx334qxozu27n@uwge5gudmttn>
References: <20241024022233.3276995-1-amitsd@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a4nnbsddgl3uyol6"
Content-Disposition: inline
In-Reply-To: <20241024022233.3276995-1-amitsd@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/229.360.92
X-ZohoMailClient: External


--a4nnbsddgl3uyol6
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] usb: typec: tcpm: restrict
 SNK_WAIT_CAPABILITIES_TIMEOUT transitions to non self-powered devices
MIME-Version: 1.0

Hi,

On Wed, Oct 23, 2024 at 07:22:30PM -0700, Amit Sunil Dhamne wrote:
> PD3.1 spec ("8.3.3.3.3 PE_SNK_Wait_for_Capabilities State") mandates
> that the policy engine perform a hard reset when SinkWaitCapTimer
> expires. Instead the code explicitly does a GET_SOURCE_CAP when the
> timer expires as part of SNK_WAIT_CAPABILITIES_TIMEOUT. Due to this the
> following compliance test failures are reported by the compliance tester
> (added excerpts from the PD Test Spec):
>=20
> * COMMON.PROC.PD.2#1:
>   The Tester receives a Get_Source_Cap Message from the UUT. This
>   message is valid except the following conditions: [COMMON.PROC.PD.2#1]
>     a. The check fails if the UUT sends this message before the Tester
>        has established an Explicit Contract
>     ...
>=20
> * TEST.PD.PROT.SNK.4:
>   ...
>   4. The check fails if the UUT does not send a Hard Reset between
>     tTypeCSinkWaitCap min and max. [TEST.PD.PROT.SNK.4#1] The delay is
>     between the VBUS present vSafe5V min and the time of the first bit
>     of Preamble of the Hard Reset sent by the UUT.
>=20
> For the purpose of interoperability, restrict the quirk introduced in
> https://lore.kernel.org/all/20240523171806.223727-1-sebastian.reichel@col=
labora.com/
> to only non self-powered devices as battery powered devices will not
> have the issue mentioned in that commit.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 122968f8dda8 ("usb: typec: tcpm: avoid resets for missing source c=
apability messages")
> Reported-by: Badhri Jagan Sridharan <badhri@google.com>
> Closes: https://lore.kernel.org/all/CAPTae5LAwsVugb0dxuKLHFqncjeZeJ785nkY=
4Jfd+M-tCjHSnQ@mail.gmail.com/
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
> ---

I actually had this constrained to the !self_powered use-case
originally (before sending to the ML). Since I didn't see a good
reason for the extra check, I decided to keep the code simple :)

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/usb/typec/tcpm/tcpm.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d6f2412381cf..c8f467d24fbb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4515,7 +4515,8 @@ static inline enum tcpm_state hard_reset_state(stru=
ct tcpm_port *port)
>  		return ERROR_RECOVERY;
>  	if (port->pwr_role =3D=3D TYPEC_SOURCE)
>  		return SRC_UNATTACHED;
> -	if (port->state =3D=3D SNK_WAIT_CAPABILITIES_TIMEOUT)
> +	if (port->state =3D=3D SNK_WAIT_CAPABILITIES ||
> +	    port->state =3D=3D SNK_WAIT_CAPABILITIES_TIMEOUT)
>  		return SNK_READY;
>  	return SNK_UNATTACHED;
>  }
> @@ -5043,8 +5044,11 @@ static void run_state_machine(struct tcpm_port *po=
rt)
>  			tcpm_set_state(port, SNK_SOFT_RESET,
>  				       PD_T_SINK_WAIT_CAP);
>  		} else {
> -			tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -				       PD_T_SINK_WAIT_CAP);
> +			if (!port->self_powered)
> +				upcoming_state =3D SNK_WAIT_CAPABILITIES_TIMEOUT;
> +			else
> +				upcoming_state =3D hard_reset_state(port);
> +			tcpm_set_state(port, upcoming_state, PD_T_SINK_WAIT_CAP);
>  		}
>  		break;
>  	case SNK_WAIT_CAPABILITIES_TIMEOUT:
>=20
> base-commit: c6d9e43954bfa7415a1e9efdb2806ec1d8a8afc8
> --=20
> 2.47.0.105.g07ac214952-goog
>=20

--a4nnbsddgl3uyol6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmcbzVgACgkQ2O7X88g7
+pqdCg//QuiUnHno4TZ9ZYeLw5BBTQwTtXLKErchyyfuJVYMWza1tDQMwWGLNMeh
g+hvjmcGWSJZwKnZd/kBAW4muF+qbhx58FgCfRQ/WwwXkf5i+Um7h0cwOoq6hMFx
DkqsER04hCx4skB4tDUSC9T4/PWnnWVQBwi4h7Ugb0VYeCUdGmQqLrbamqh+6aAR
BFZUxZ/UJZyUrJJJrTKL3BNpEe9ZfFYo73lSTetis4coFXBy0bhBpIVczEoJDA+w
q7iMtYoDzLZ7O3MGAeIhqgg6Kaie0V2JeQr0OoXa3viHrC6i/LyZ0J+PGlFIbsDo
No/eUsozAY1lBO/d9tKSY4Z62NYtssbcpiqMrLU3kIn8u/32oCyG4GgHogHzZBiK
npbyV/kVKamGRgmwVAFk46g1qtb8IanSuo8kBWS0H9EKahH08IUhoac004wyF1yB
9Aoc8cFBXV0KXV9vyUsQMOsxWyadgUjjPRGOrwMaYN9CkDxwvxdJyyMSaAl0PxSN
W1x0WojnTz0g6EtJ/xM+AZtO3mDgqKDFceRxABaBdPnR2khROViF8xNxAs7RHLAY
KF3dZSAjEo5wLdZOIB+0Evj0g307ikf9hH1k29zCVz8s4w6N50h1/F8sM/2tsBd2
1jwGZS3/9nanoTFksabwt3pDzvZ7BHcHQF8tL/HDDh/f105WNXs=
=2MN7
-----END PGP SIGNATURE-----

--a4nnbsddgl3uyol6--

