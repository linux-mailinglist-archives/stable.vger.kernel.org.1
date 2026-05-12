Return-Path: <stable+bounces-246707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM4xIGm9A2og9wEAu9opvQ
	(envelope-from <stable+bounces-246707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:53:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C452B66D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 050F3306D620
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F7B3655F7;
	Tue, 12 May 2026 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8KC0TzI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920A34844C
	for <stable@vger.kernel.org>; Tue, 12 May 2026 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778629978; cv=pass; b=nrHuggQ4+Wn6XgEQVj3YJuGRBAaHYnCGhzMHUIDgwRZW8QoOH/SOzr2qFCNg0LL5noswGP8HywjQMYgG9eO6zldXn3ors7w42N5Ipdq1QMAk6wbNGTISk1LgV0dyogmI0b2PDktx1x0r/I5vG+I76r4LeGJp2uWzQBve5C1rbqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778629978; c=relaxed/simple;
	bh=M4OskHsBAFUee/E1HyOtty5ctmQ+ue41zkwBlCBiRQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAMz1AWq48/RUHF7etC9+dn7YziFOpJPRzv7229G0aFSt9iJbeMKSDqqtekjAJkh32YZYOC8Lb1KLCYAT2AsyBJZqvHQeLW8KIcU+pTeQLZuAByazSUf6hZea4+PVRSTDzgs6825xT95UoDTwTPjxMyT6ulefQeKLGw0Jn+0jqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8KC0TzI; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dea20cf21aso5587559a34.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 16:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778629975; cv=none;
        d=google.com; s=arc-20240605;
        b=K4mRyuHzeu7zXK2uESuSUigBIZanoDSNTiRDCxw8jCL4cew3hY2s183aOa00Eoeg66
         qomELNFqgRWmqr01IcAHkbkI9h+ILWwOkZicnglWTMXECIfFN5fA+eVbigwpKuU7d0Mb
         LHJGOOXLsVxi7+yaTkuQKth+jEwvFcNdp047HaEerzcyFjWrFXk7EMqZs+XULTQANPZ4
         PEIqQ14s1uSIvhcuXC/5b5tAu5v8mVqSn8YF8AmsFs9VgZWGdzFuUYAWIDdEAeBtdpYM
         ZCXVioZ1jSH7bhm9Lm9Kt03kYMTe0KGojgvcp8hNaFDhjsNXkbvAvbww5S7J9Y1WZa0R
         PxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+FGA8pZgJ3IPsHpCBVW+DHejdlYtVVwJny+rnPHDZOg=;
        fh=2gzaD6RhKHtAOGKDFjLc40dWUTilRw2gYAkZu/HqSp8=;
        b=UlFp10ygo2ankUDQwH5MK52m33OPwQAqXfHxFYCQtkWqddRtml1gvLlnKhnE+hmrJ4
         rznFUDfqkCPxDsEWUX+jDw6Ad05EmbMsu8nLhPvXS8CwZApdbTIqEmmtLut52kNE208f
         KkxDmfjcE3AG4UGwhXP6Za8fY+1RwPWCgIgQ5eAwD8RvCTqV22boTJNSMtT0lZuPWy8u
         xuBHW1QT1JSaH5R835RE+uLtsyfzOd2Cv/+6cR6Q77qadrY8nzoUmO86lHVLSFTapTKm
         6DNBVFrrXr27NSSn1fMdDQiSGBZTie7lXOU0IjNdDZbalSX98Os++o5dCx1n/qAtkCkU
         O43Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778629975; x=1779234775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FGA8pZgJ3IPsHpCBVW+DHejdlYtVVwJny+rnPHDZOg=;
        b=K8KC0TzISBY1O1cO1dOy6ieW9wXIoLOWpsuvuV8EWQn4096GsjghGLzTFLHtivUw/O
         2WLt4WTRhXOBdD+zGqr2WkUb+Og7lv+1DNW0qF6J46HrGBbsxeqVpRHxDIVxvFov/GTo
         Xw0x7rC8LkATweFmKKP/uH+NlMkW46lgtVnGHieWB+d0BkJtxjwXmO5wR0QRu4QupeSu
         +t/grIR3B8r08FK9UpTr3UIUd8uCVL0wwdsL8vtBx28ly69mxgvC4oXO4F3mqfKT0oWD
         DnBQH++KggPmJVcsL4AbZBlk7WM02g6vfcv6UNNO1xVRPRwnpGUiiInmurEcMTPaotgM
         lSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778629975; x=1779234775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+FGA8pZgJ3IPsHpCBVW+DHejdlYtVVwJny+rnPHDZOg=;
        b=pXLH53Kzt6ioiALVPfoCPvuXZQvU3AYSpjDOfPBycY+QOSoHU1VV9KOH9w5BNWIdgo
         Etw9jvH0Az9svXDVSkx8JUHi3LAu1hFSQAzvgNVpVQJ0YKrWqSWCp+evOoKSXdutldui
         tZB0P/TDePo/Kj9ykvFZPAmX7hh1FO2XfmHFYfWvQZkB89B/sRzgoZYTe6VZt9TWgf4E
         xjO5+u0gY42lLq+9qvx83ct1yValHIlvr8K9guV2GuvEDeqCN/WGkqFV19FCFZ+Ifl/l
         G0DbxUKPzT+hlqU1TqlY4q1YXmFDdp4DifP0y5QLZTX1iFY3kcd0V9X89EOvoqIizseM
         AUEg==
X-Forwarded-Encrypted: i=1; AFNElJ8hhabjCkpZwKlsXvW0keydloMUhiMDQK9z1a81hbY60mBxnDTmH3jgjxBXPkph4mhjl8Ru4Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6T8E30pLpyTXV6HEXvyD1SLID3HQZC7Vd0eZVQvf2+IPS9PpC
	rrFyAy4ZpBJ8AMmPzPDp6hJEepC6YUCfxK/vI2mWz7419ST8JIXtL/htnIOWk8u6cgl3GGeDnwb
	zQCbSs8iYpxWwZwmQzWZnrfKJKfpP68daDmromdPz
X-Gm-Gg: Acq92OHXFpwV01epsU3O5iVk5EWCzr2hoONpcCnGIsuQZWXr97hx8y5Eb7BNm6n9GM0
	TBQ+5it0pRU36n7zdV8Eerr215iuVrf+WvDaaRMmSjro6/Nz6RwoGQt539NZy2P1kLdaQ8mcl3v
	tzQFGeQSSWy4uWRO0/XPvXqoZDpHDAVp7DsQQUcHPB79GpnzzmiIa4adxI+TfVvi0wXgKh6YdAA
	/DiwK9sUdjOLfflpGtop+a6375HgT/qBCcmOr8rFAJreS6S3p6jhEh4HhJuHJxseJdYYwC7hmM7
	6FP0tFzvv2o2T0vUu9gc84SrmerZa71pSTbkQuUWpjhrS0aEmCt4Ma9ft5s=
X-Received: by 2002:a05:6820:1908:b0:694:9e10:fdce with SMTP id
 006d021491bc7-69b78d48a1fmr540205eaf.4.1778629974495; Tue, 12 May 2026
 16:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429-tcpm-discover-modes-nak-fix-v4-1-75945d0ed30f@collabora.com>
In-Reply-To: <20260429-tcpm-discover-modes-nak-fix-v4-1-75945d0ed30f@collabora.com>
From: RD Babiera <rdbabiera@google.com>
Date: Tue, 12 May 2026 16:52:41 -0700
X-Gm-Features: AVHnY4LfJ8Mvw0TkiFibkz2XCR8My-z9f4kN448nFcDnUZezatAPoamXYLKTZro
Message-ID: <CALzBnUGhad0r3oLDTG3TrFPBsJpyGa_Ra7DCM0Gju0-rKSxx9A@mail.gmail.com>
Subject: Re: [PATCH v4] usb: typec: tcpm: improve handling of DISCOVER_MODES failures
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EA1C452B66D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246707-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdbabiera@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,collabora.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, Apr 29, 2026 at 9:33=E2=80=AFAM Sebastian Reichel
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
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: RD Babiera <rdbabiera@google.com>

> ---
> Changes in v4:
> - Link to v3: https://lore.kernel.org/r/20260309-tcpm-discover-modes-nak-=
fix-v3-1-a4447f5c1c61@collabora.com
> - Rebase to v7.1-rc1
> - Collect Reviewed-by from Heikki Krogerus
>
> Changes in v3:
> - Link to v2: https://lore.kernel.org/r/20260303-tcpm-discover-modes-nak-=
fix-v2-1-5a630070025a@collabora.com
> - Move svdm_consume_modes() out of tcpm_handle_discover_mode() (Heikki Kr=
ogerus)
> - Move rlen return pointer argument into proper return code (Heikki Kroge=
rus)
> - Drop multiple tcpm_handle_discover_mode() arguments by re-getting them
>   in the function  (Heikki Krogerus)
> - Restructure if/else branches after these changes to make checkpatch hap=
py
> - Did not pick up R-b tag from Badhri Jagan Sridharan due to the amount
>   of changes
>
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
> index dfbb94ddc98a..44ab7e0e5d50 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2142,6 +2142,55 @@ static bool tcpm_cable_vdm_supported(struct tcpm_p=
ort *port)
>                tcpm_can_communicate_sop_prime(port);
>  }
>
> +static int tcpm_handle_discover_mode(struct tcpm_port *port, u32 *respon=
se,
> +                                    enum tcpm_transmit_type rx_sop_type,
> +                                    enum tcpm_transmit_type *response_tx=
_sop_type)
> +{
> +       struct typec_port *typec =3D port->typec_port;
> +       struct pd_mode_data *modep;
> +
> +       if (rx_sop_type =3D=3D TCPC_TX_SOP) {
> +               modep =3D &port->mode_data;
> +               modep->svid_index++;
> +
> +               if (modep->svid_index < modep->nsvids) {
> +                       u16 svid =3D modep->svids[modep->svid_index];
> +                       *response_tx_sop_type =3D TCPC_TX_SOP;
> +                       response[0] =3D VDO(svid, 1,
> +                                         typec_get_negotiated_svdm_versi=
on(typec),
> +                                         CMD_DISCOVER_MODES);
> +                       return 1;
> +               }
> +
> +               if (tcpm_cable_vdm_supported(port)) {
> +                       *response_tx_sop_type =3D TCPC_TX_SOP_PRIME;
> +                       response[0] =3D VDO(USB_SID_PD, 1,
> +                                         typec_get_cable_svdm_version(ty=
pec),
> +                                         CMD_DISCOVER_SVID);
> +                       return 1;
> +               }
> +
> +               tcpm_register_partner_altmodes(port);
> +       } else if (rx_sop_type =3D=3D TCPC_TX_SOP_PRIME) {
> +               modep =3D &port->mode_data_prime;
> +               modep->svid_index++;
> +
> +               if (modep->svid_index < modep->nsvids) {
> +                       u16 svid =3D modep->svids[modep->svid_index];
> +                       *response_tx_sop_type =3D TCPC_TX_SOP_PRIME;
> +                       response[0] =3D VDO(svid, 1,
> +                                         typec_get_cable_svdm_version(ty=
pec),
> +                                         CMD_DISCOVER_MODES);
> +                       return 1;
> +               }
> +
> +               tcpm_register_plug_altmodes(port);
> +               tcpm_register_partner_altmodes(port);
> +       }
> +
> +       return 0;
> +}
> +
>  static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *ad=
ev,
>                         const u32 *p, int cnt, u32 *response,
>                         enum adev_actions *adev_action,
> @@ -2399,41 +2448,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, s=
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
> +                       /* 6.4.4.3.3 */
> +                       svdm_consume_modes(port, p, cnt, rx_sop_type);
> +                       rlen =3D tcpm_handle_discover_mode(port, response=
,
> +                                                        rx_sop_type,
> +                                                        response_tx_sop_=
type);
>                         break;
>                 case CMD_ENTER_MODE:
>                         *response_tx_sop_type =3D rx_sop_type;
> @@ -2476,9 +2495,15 @@ static int tcpm_pd_svdm(struct tcpm_port *port, st=
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
> +                       rlen =3D tcpm_handle_discover_mode(port, response=
,
> +                                                        rx_sop_type,
> +                                                        response_tx_sop_=
type);
> +                       break;
>                 case CMD_ENTER_MODE:
>                         /* Back to USB Operation */
>                         *adev_action =3D ADEV_NOTIFY_USB_AND_QUEUE_VDM;
>
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260213-tcpm-discover-modes-nak-fix-09070bb529c5
>
> Best regards,
> --
> Sebastian Reichel <sebastian.reichel@collabora.com>
>

