Return-Path: <stable+bounces-223281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCXGBsn/qWk1JQEAu9opvQ
	(envelope-from <stable+bounces-223281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 23:12:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621E6218D0D
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 23:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 594B1301DAD9
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B059036167A;
	Thu,  5 Mar 2026 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DOI8T6md"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5C35E946
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772748708; cv=pass; b=HSmpR1diAUEyD84qFdKZ2ARMfsphMoQxIeizfmU4egEnkdnmLRccqxm+j5jK/OEOqyQ4KhaO9XNSfXCrbe8FEsim8PRZ07WWowkvgOnNCGcvYim2twDJelEU1g5zh4LT+iAnxyswpU6TBEaNmkFUNfE/jD5twUjye1DlslXyl5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772748708; c=relaxed/simple;
	bh=7MxVFjGmawKQXY3xM/uqGd23Krw/OYZ1EZEEu/8Pros=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDRg3PgIw6JgFGBtmPjUSjc/wEcPteG/6PMdRT3Ok5SUzXEBBtR0Wl/AW20zPvFIGQQMh6jAR9CjUcOhJ/Zd1B684+/PinE5EcrkXnw6akCYiMeddwbwS4dGxQZaxmG+4r4KmraSfu0piFWVapCZuGBcyH7cqj3Bxu/VeItoM7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DOI8T6md; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40429b1d8baso1512474fac.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 14:11:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772748706; cv=none;
        d=google.com; s=arc-20240605;
        b=UKCYinuqmvLdrXG8F4TaX4bxRr4iBaNluMGdlz/1hD/MTbCFs+PqW7rrW0JmXEcEqe
         4oBKbKk1dnNJ9eZXgGbZamJn2aHK1cgbOmiQlmb+G7n/KeQ3oz23zLYOy1xEkXjQ/2UZ
         aPvGd2PEQTQMO4jFDzyG6IRKl8E1pih7IldneFAHTr+bRexrsL72RzdyONeBtO6Pf39W
         eSUMz9sPWpwPYWIGMnwVCGOjNrbtm6mK9dtvYzUlW25aZNRz9jQJWLD7u0EK4wIbj1C/
         C+MG9or/1bJ2A/fwi4TxZyYbUkGihKWGX1zSaJ2nhaiWIzZs1fMJjtmYYOtof/Zs6Yru
         Q9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2S5UrH7lP9tywnp3Wdnyb1KYpD7D1yyMflWo2M+GqP0=;
        fh=W/f9Lkqa4mSvqhBxz9Aro8eHiPbWNB1Z2GFIENWavYo=;
        b=URUqRJMTozFfd3/J2EOXku7ayAkedbFgesykztppzQNzu4gnyRDBK+0MEDKTYvTEFj
         y3wYHPQ11zX54THdeFml+J4zp8sOiN6d+ZUbSBjaFTvF04lUe5HDebiJjpNUYWZXHsQs
         +10FyeEljy/g++GudwOOH5uJ61avyDKERI13wbhEX07taN3nTfthDQWlK3d1C9IRwGs/
         tr5oPRIyJR85jDY2dT/4WvE6HFiVOQv8jPYvR2RCR0S2MhhknSSlA0HMzRDgUiSVYebX
         IuI19ylYyF7xzIlR+jec7nMOx3cNymCrC8yUBRoXF6Rp23Soqw8r4IB78435STH46DaV
         HmHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772748706; x=1773353506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2S5UrH7lP9tywnp3Wdnyb1KYpD7D1yyMflWo2M+GqP0=;
        b=DOI8T6mdTU48uo47KGICMefsl4B9HALrfKgBztQ9nsYvRJes+h/bw7vHr0w/IoWIbb
         4sMHpruSffR9Zs0ZMdmkACInCpNijz0h+ra2+JoHNPNEIMLe6nCiU2kGFyIBYKWwHGv/
         IW51v3oMvlrOkxyGFDLZePRECB7H1HD4vM1UbCY3yyUt96f1BKDkqwtLbuD0ZH6htjGA
         mflF9VltKWZ98Ri2ik9exEESh+f9/qSeyu42Jf/pCghBbsUL57Xohm/9T7NRZhlHCmiX
         SE0d0Zp+7dMbn4jXaFouOfEDqTul2ONAFk4c3LJ2KNDo8prJh0scjzOkv5FPuhxPLpOc
         O0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772748706; x=1773353506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2S5UrH7lP9tywnp3Wdnyb1KYpD7D1yyMflWo2M+GqP0=;
        b=o3AVxNVW4FW4W5JQWdsPPThaUF+N1wdsJMUTaIgwRl/PgsyFdQkgw8qy0zZzdhd+wz
         BlU6jspkwj3Iwfdkkj7zQ6ib4imKB33fvRy1B3yf+TB3lKJf4u6Ri+MPR4ZcjTrf7AVQ
         nyEhiDfF9FvZlKZXzG0BJk6WBqiwKtbBQnI0KG7gb8ZwZ43ilqvw+pByfU07afvfcDz/
         mv/0wsepL5ke5pZ7WwVurEB3ubomRKTubAaPz6WPBZcXS2lCrzLJLh3pDVbDJB8LJMIF
         ZLqijFWTL6TUFx7aHzwOvG8pcEuH29mZoreoUo5fCgJguqdGfupGzrmmFwLPT7wEqxgv
         iemw==
X-Forwarded-Encrypted: i=1; AJvYcCXe+jZoWfadPTIW++qyHxAwqqfMzNFgNRslWV+fZd1jJpjJRjAMGQhJszma/jwGMqJwGgiInOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTp+Cucht4IzncN8xft7zUrK4Z2neOdfzh69h0E4R5NQWCEdT8
	PPGfHhSZVyKFeGGhttSZSAV012GA4NTJatVJuaSjQwkQNYqrHEvS26KNV0hulgxUDc4H/o/q9Tc
	t9o24j7sofdUNg+f+Yvv+M8f4WYNxmjPdB1jWQ08DJV7lL4lVIld3botLKtA=
X-Gm-Gg: ATEYQzywyYclXZyEKUWq/m0KqQy+p0nC0wNWk/nKQDgqCaxZj4Fc9xI4ng66/yTi044
	yGBiFQW3nC+ghCdo5ckNMwY9prGYYOIyQ20iN+Kme4ld2k/uLpVqqAG1NNmHo6vUgPvAbD3uc0p
	Rtr70ZGcZ4MS0dVE+/PB5ZMMahdsiswYWp7qR9O4a00c9xLI+0DZwFg/WLTSWnpFyTAjBXTo9CF
	dLTpkWJiY6NJcP/lJt2o9iNKh4tJbbKRmMW4iFeAaDZ6TFAZ1XnSkdp+8xT8B0Iwo4hUuYYL7qO
	in2F3IDycNEQjQvcxMQVPlMZtsgrdLdtGfkYEQ==
X-Received: by 2002:a05:6870:8092:b0:408:9c83:5b1a with SMTP id
 586e51a60fabf-416e3ea8cbcmr11261fac.4.1772748705651; Thu, 05 Mar 2026
 14:11:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303-tcpm-discover-modes-nak-fix-v2-1-5a630070025a@collabora.com>
In-Reply-To: <20260303-tcpm-discover-modes-nak-fix-v2-1-5a630070025a@collabora.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Thu, 5 Mar 2026 14:11:09 -0800
X-Gm-Features: AaiRm53_zjz33-tP74RcnsVNiwqmROLVrBKjQJc9wO9dxIBzC4JHKLRA0HcGnc8
Message-ID: <CAPTae5J+psuXX9m0boHYMYpfi8aNQ3erdyUU5Qnq9DFWbZDRFQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: improve handling of DISCOVER_MODES failures
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, RD Babiera <rdbabiera@google.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 621E6218D0D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[badhri@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-223281-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 8:29=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> UGREEN USB-C Multifunction Adapter Model CM512 (AKA "Revodok 107")
> exposes two SVIDs: 0xff01 (DP Alt Mode) and 0x1d5c. The DISCOVER_MODES
> step succeeds for 0xff01 and gets a NAK for 0x1d5c. Currently this
> results in DP Alt Mode not being registered either, since the modes
> are only registered once all of them have been discovered. The NAK
> results in the processing being stopped and thus no Alt modes being
> registered.
>
> Improve the situation by handling the NAK gracefully and continue
> processing the other modes.
>
> Before this change, the TCPM log ends like this:
>
> (more log entries before this)
> [    5.028287] AMS DISCOVER_SVIDS finished
> [    5.028291] cc:=3D4
> [    5.040040] SVID 1: 0xff01
> [    5.040054] SVID 2: 0x1d5c
> [    5.040082] AMS DISCOVER_MODES start
> [    5.040096] PD TX, header: 0x1b6f
> [    5.050946] PD TX complete, status: 0
> [    5.059609] PD RX, header: 0x264f [1]
> [    5.059626] Rx VDM cmd 0xff018043 type 1 cmd 3 len 2
> [    5.059640] AMS DISCOVER_MODES finished
> [    5.059644] cc:=3D4
> [    5.069994]  Alternate mode 0: SVID 0xff01, VDO 1: 0x000c0045
> [    5.070029] AMS DISCOVER_MODES start
> [    5.070043] PD TX, header: 0x1d6f
> [    5.081139] PD TX complete, status: 0
> [    5.087498] PD RX, header: 0x184f [1]
> [    5.087515] Rx VDM cmd 0x1d5c8083 type 2 cmd 3 len 1
> [    5.087529] AMS DISCOVER_MODES finished
> [    5.087534] cc:=3D4
> (no further log entries after this point)
>
> After this patch the TCPM log looks exactly the same, but then
> continues like this:
>
> [    5.100222] Skip SVID 0x1d5c (failed to discover mode)
> [    5.101699] AMS DFP_TO_UFP_ENTER_MODE start
> (log goes on as the system initializes DP AltMode)
>
> Cc: stable@vger.kernel.org
> Fixes: 41d9d75344d9 ("usb: typec: tcpm: add discover svids and discover m=
odes support for sop'")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>


Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

>
> ---
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20260213-tcpm-discover-modes-nak-=
fix-v1-0-9bcb5adb4ef6@collabora.com
> - Squash patches (Badhri Jagan Sridharan)
> - Add Fixes tag (Badhri Jagan Sridharan)
> - Move common svdm_consume_modes out of conditional statement (Badhri Jag=
an Sridharan)
> - Add TCPM log to commit message (Badhri Jagan Sridharan)
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 97 +++++++++++++++++++++++++++----------=
------
>  1 file changed, 61 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index 1d2f3af034c5..cd5260f408fb 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1995,6 +1995,55 @@ static bool tcpm_cable_vdm_supported(struct tcpm_p=
ort *port)
>                tcpm_can_communicate_sop_prime(port);
>  }
>
> +static void tcpm_handle_discover_mode(struct tcpm_port *port,
> +                                     const u32 *p, int cnt, u32 *respons=
e,
> +                                     enum tcpm_transmit_type rx_sop_type=
,
> +                                     enum tcpm_transmit_type *response_t=
x_sop_type,
> +                                     struct pd_mode_data *modep,
> +                                     struct pd_mode_data *modep_prime,
> +                                     int svdm_version, int *rlen,
> +                                     bool success)
> +
> +{
> +       struct typec_port *typec =3D port->typec_port;
> +
> +       /* 6.4.4.3.3 */
> +       if (success)
> +               svdm_consume_modes(port, p, cnt, rx_sop_type);
> +
> +       if (rx_sop_type =3D=3D TCPC_TX_SOP) {
> +               modep->svid_index++;
> +               if (modep->svid_index < modep->nsvids) {
> +                       u16 svid =3D modep->svids[modep->svid_index];
> +                       *response_tx_sop_type =3D TCPC_TX_SOP;
> +                       response[0] =3D VDO(svid, 1, svdm_version,
> +                                         CMD_DISCOVER_MODES);
> +                       *rlen =3D 1;
> +               } else if (tcpm_cable_vdm_supported(port)) {
> +                       *response_tx_sop_type =3D TCPC_TX_SOP_PRIME;
> +                       response[0] =3D VDO(USB_SID_PD, 1,
> +                                         typec_get_cable_svdm_version(ty=
pec),
> +                                         CMD_DISCOVER_SVID);
> +                       *rlen =3D 1;
> +               } else {
> +                       tcpm_register_partner_altmodes(port);
> +               }
> +       } else if (rx_sop_type =3D=3D TCPC_TX_SOP_PRIME) {
> +               modep_prime->svid_index++;
> +               if (modep_prime->svid_index < modep_prime->nsvids) {
> +                       u16 svid =3D modep_prime->svids[modep_prime->svid=
_index];
> +                       *response_tx_sop_type =3D TCPC_TX_SOP_PRIME;
> +                       response[0] =3D VDO(svid, 1,
> +                                         typec_get_cable_svdm_version(ty=
pec),
> +                                         CMD_DISCOVER_MODES);
> +                       *rlen =3D 1;
> +               } else {
> +                       tcpm_register_plug_altmodes(port);
> +                       tcpm_register_partner_altmodes(port);
> +               }
> +       }
> +}
> +
>  static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *ad=
ev,
>                         const u32 *p, int cnt, u32 *response,
>                         enum adev_actions *adev_action,
> @@ -2252,41 +2301,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, s=
truct typec_altmode *adev,
>                         }
>                         break;
>                 case CMD_DISCOVER_MODES:
> -                       if (rx_sop_type =3D=3D TCPC_TX_SOP) {
> -                               /* 6.4.4.3.3 */
> -                               svdm_consume_modes(port, p, cnt, rx_sop_t=
ype);
> -                               modep->svid_index++;
> -                               if (modep->svid_index < modep->nsvids) {
> -                                       u16 svid =3D modep->svids[modep->=
svid_index];
> -                                       *response_tx_sop_type =3D TCPC_TX=
_SOP;
> -                                       response[0] =3D VDO(svid, 1, svdm=
_version,
> -                                                         CMD_DISCOVER_MO=
DES);
> -                                       rlen =3D 1;
> -                               } else if (tcpm_cable_vdm_supported(port)=
) {
> -                                       *response_tx_sop_type =3D TCPC_TX=
_SOP_PRIME;
> -                                       response[0] =3D VDO(USB_SID_PD, 1=
,
> -                                                         typec_get_cable=
_svdm_version(typec),
> -                                                         CMD_DISCOVER_SV=
ID);
> -                                       rlen =3D 1;
> -                               } else {
> -                                       tcpm_register_partner_altmodes(po=
rt);
> -                               }
> -                       } else if (rx_sop_type =3D=3D TCPC_TX_SOP_PRIME) =
{
> -                               /* 6.4.4.3.3 */
> -                               svdm_consume_modes(port, p, cnt, rx_sop_t=
ype);
> -                               modep_prime->svid_index++;
> -                               if (modep_prime->svid_index < modep_prime=
->nsvids) {
> -                                       u16 svid =3D modep_prime->svids[m=
odep_prime->svid_index];
> -                                       *response_tx_sop_type =3D TCPC_TX=
_SOP_PRIME;
> -                                       response[0] =3D VDO(svid, 1,
> -                                                         typec_get_cable=
_svdm_version(typec),
> -                                                         CMD_DISCOVER_MO=
DES);
> -                                       rlen =3D 1;
> -                               } else {
> -                                       tcpm_register_plug_altmodes(port)=
;
> -                                       tcpm_register_partner_altmodes(po=
rt);
> -                               }
> -                       }
> +                       tcpm_handle_discover_mode(port, p, cnt, response,
> +                                                 rx_sop_type, response_t=
x_sop_type,
> +                                                 modep, modep_prime, svd=
m_version,
> +                                                 &rlen, true);
>                         break;
>                 case CMD_ENTER_MODE:
>                         *response_tx_sop_type =3D rx_sop_type;
> @@ -2329,9 +2347,16 @@ static int tcpm_pd_svdm(struct tcpm_port *port, st=
ruct typec_altmode *adev,
>                 switch (cmd) {
>                 case CMD_DISCOVER_IDENT:
>                 case CMD_DISCOVER_SVID:
> -               case CMD_DISCOVER_MODES:
>                 case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
>                         break;
> +               case CMD_DISCOVER_MODES:
> +                       tcpm_log(port, "Skip SVID 0x%04x (failed to disco=
ver mode)",
> +                                PD_VDO_SVID_SVID0(p[0]));
> +                       tcpm_handle_discover_mode(port, p, cnt, response,
> +                                                 rx_sop_type, response_t=
x_sop_type,
> +                                                 modep, modep_prime, svd=
m_version,
> +                                                 &rlen, false);
> +                       break;
>                 case CMD_ENTER_MODE:
>                         /* Back to USB Operation */
>                         *adev_action =3D ADEV_NOTIFY_USB_AND_QUEUE_VDM;
>
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260213-tcpm-discover-modes-nak-fix-09070bb529c5
>
> Best regards,
> --
> Sebastian Reichel <sebastian.reichel@collabora.com>
>

