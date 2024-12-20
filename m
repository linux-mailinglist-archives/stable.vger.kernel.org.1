Return-Path: <stable+bounces-105518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B08229F9BDB
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 22:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95864188918D
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 21:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685616FC5;
	Fri, 20 Dec 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/ihCrWQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3D1AA1D5
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734729794; cv=none; b=W0Lucz/MrY5IbssZwYJbq1GrRUrmJjY4OGLQedEWCbOs8TbzqPUpym2V3XKFsVlHHj5m3sEzWWdXpjDoawpQ7vw3I4VfhMFOBnLovujBJbb+1BIjgApZd/k4wjDAEtvBA9pHxpn4hO6LPmY5Z0hrP0u/2OqItB/JcWKX23L+kFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734729794; c=relaxed/simple;
	bh=dKV7y8rf9cOZo2ndR70zikFA9nBvRl0Bm8U0LgBXHwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eem+I8feYhmqPiKdWkRd2eM3kUSIfiBYl8+hcMQufIjv72b3Xpgr4bxhTYYu5l1fHmLIcuNGSVnD+7L8Wy4YiK9B9GZm4O2pVMfo8c3wwK3ieHX53Y5WSxzlfRrLI19Th31mCw1wJwnKUeSHQ1MbWs65581TOJguiH/Vsyrc2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/ihCrWQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3ebadbb14dcso977527b6e.3
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 13:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734729790; x=1735334590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSNG3J+bXJaKPLRK0YtFOyFTIda24K0igSRqaKX5Y/o=;
        b=R/ihCrWQ2qBUEqiyqzzVz48qiVZJ3Ba11eRgJU1DNamo8dIffK8v1x7InWwaQ1F2Ed
         YotjzS7MTRVQMlZo+Z+Y79CVLDBl1+GJ/W45GL3p/AKGlwM0BnctbI3oNYSFPqz/3K4L
         br4ueWM8TM+1WNYgR6es19Q5f14GX240xlpTXA0VJjP5/TJlccOsBnv5CBSl/jiXNGeA
         V7nKKjKhSxX9LubekQUry2EMCa5Laf5W3tYKPk7ZLq3Dfiy0kzFshdBnElTP2+mAoy1H
         O2Qt4t/Dw4zim2foYB9j/GzvWWHIYCVsEPXTERRXbN/9kJGKpIUDTcBm/Zk5LJO/EDnz
         D6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734729790; x=1735334590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSNG3J+bXJaKPLRK0YtFOyFTIda24K0igSRqaKX5Y/o=;
        b=eO9QgXJusb7kZLKCzs5vyESveFVimEveRZSl3n7pg5SY9jQl53kfmfm2llxga/E0xq
         QxTWdviBKzUyzqxjYwnN6cWlT4yuBfSPaDKcaVyMKTC5ynR7RmLQkLx3k/vXUeIqGjPF
         +PU4Llode5YvNwIRiS4LOnqhX/ZAk1xILAhpM6WLakxdlg/GHi9Mfmgu05AaK44h9qER
         5kxS8xRD+10VrGfUV5gq+1jhkQCMc/69TnbO0jfvAIOdZcSXChrb0mZDPoTVomgAYH9j
         RLY8GPQWM264y6nmdkTUvwGsFcqqQvjRXioapWDRFltuYCQfxDQtLE0opblrpQpSIazA
         9SSg==
X-Forwarded-Encrypted: i=1; AJvYcCV9Wcu2J2ydfjGWGxNXiS4PetZmfK4i1x2B+C5AQAsLIOd2Lq+KYIKBW/Y7KZnQJoTDD8FHVqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1JcggvouHDeZ9UomgKdEAweAH8SksRUh8m+i6Cw2VJVMKveyR
	7s3c4CKde2sUrATgz1xOu77KmFBW4bGOMmTLiJ/zWNsHLXC2UR1ZjS+N1QJwqdsEC2bwMKUFloh
	qqL6UCUygVqW8rwi8a+Dk1jdSDlDw0Ck8Q/Q7
X-Gm-Gg: ASbGncsulglWU2BqXHJrH5+SO/Ry8mEOv3kjCW5ryKqOym5Q7XBKk4Mm+Va1xgXGdBk
	PtcC3VZxKKIYev/unTIZ0+l/r/hCcy6n6aNf/JtqmheEqH0VgVOp+phpyL4nH1aLwmLk7WA==
X-Google-Smtp-Source: AGHT+IG9MdCHPU14UmaL6aydW9bGAovqPN578THAvyY7ktQe0+9+rCs1itaCUIdyaPo25C5OwiS5e6w26efKwMR9Qps=
X-Received: by 2002:a05:6808:1597:b0:3eb:4076:865e with SMTP id
 5614622812f47-3ed803566femr2862462b6e.0.1734729790318; Fri, 20 Dec 2024
 13:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215125013.70671-1-joswang1221@gmail.com> <Z2Kd-k5icFTLeJkT@kuha.fi.intel.com>
 <CAMtoTm37OuzjE_V7okkV9NZS8hD57MG=WqfiEnh68SJTHmEgig@mail.gmail.com>
In-Reply-To: <CAMtoTm37OuzjE_V7okkV9NZS8hD57MG=WqfiEnh68SJTHmEgig@mail.gmail.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Fri, 20 Dec 2024 13:22:33 -0800
Message-ID: <CAPTae5Le5rEn1FfHiAxuL9cMU=NgR=8SfVihYHyZ4GbX5Km=sg@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: typec: tcpm: fix the sender response time issue
To: Jos Wang <joswang1221@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 5:39=E2=80=AFAM Jos Wang <joswang1221@gmail.com> wr=
ote:
>
> Thank you for your help in reviewing the code.
>
> USB PD3 CTS specification=EF=BC=9A
> https://usb.org/document-library/usb-power-delivery-compliance-test-speci=
fication-0
> Should this link be added to the commit message?
>
> I will resubmit the code as soon as possible and put patch 1/2 and 2/2
> in the same thread.
>
> On Wed, Dec 18, 2024 at 6:03=E2=80=AFPM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Sun, Dec 15, 2024 at 08:50:13PM +0800, joswang wrote:
> > > From: Jos Wang <joswang@lenovo.com>
> > >
> > > According to the USB PD3 CTS specification, the requirements
> >
> > What is "USB PD3 CTS specification"? Please open it here.
> >
> > > for tSenderResponse are different in PD2 and PD3 modes, see
> > > Table 19 Timing Table & Calculations. For PD2 mode, the
> > > tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> > > tSenderResponse min 27ms and max 33ms.
> > >
> > > For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> > > item, after receiving the Source_Capabilities Message sent by
> > > the UUT, the tester deliberately does not send a Request Message
> > > in order to force the SenderResponse timer on the Source UUT to
> > > timeout. The Tester checks that a Hard Reset is detected between
> > > tSenderResponse min and max=EF=BC=8Cthe delay is between the last bit=
 of
> > > the GoodCRC Message EOP has been sent and the first bit of Hard
> > > Reset SOP has been received. The current code does not distinguish
> > > between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> > > This will cause this test item and the following tests to fail:
> > > TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> > > TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> > >
> > > Considering factors such as SOC performance, i2c rate, and the speed
> > > of PD chip sending data, "pd2-sender-response-time-ms" and
> > > "pd3-sender-response-time-ms" DT time properties are added to allow
> > > users to define platform timing. For values that have not been
> > > explicitly defined in DT using this property, a default value of 27ms
> > > for PD2 tSenderResponse and 30ms for PD3 tSenderResponse is set.
> > >
> > > Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)"=
)
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jos Wang <joswang@lenovo.com>
> >
> > If this is a fix, then I think it's fixing commit 2eadc33f40d4
> > ("typec: tcpm: Add core support for sink side PPS"). That's where the
> > pd_revision was changed to 3.0.

Hmm, this patch also relies upon
https://lore.kernel.org/all/20241022-pd-dt-time-props-v1-2-fea96f51b302@goo=
gle.com/
so not sure whether it could be Fixes: 2eadc33f40d4 ("typec: tcpm: Add
core support for sink side PPS")

The patch looks good otherwise. Will wait for Jos's resubmission based
on his previous response.

> >
> > Badhri, could you take a look at this (and how about that
> > maintainer role? :-) ).

This took time was lining up the logistics.
Will send out a patch proposing me and a few others right after the
new year break.

Regards,
Badhri

> >
> > > ---
> > >  drivers/usb/typec/tcpm/tcpm.c | 50 +++++++++++++++++++++++----------=
--
> > >  include/linux/usb/pd.h        |  3 ++-
> > >  2 files changed, 35 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/t=
cpm.c
> > > index 6021eeb903fe..3a159bfcf382 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -314,12 +314,16 @@ struct pd_data {
> > >   * @sink_wait_cap_time: Deadline (in ms) for tTypeCSinkWaitCap timer
> > >   * @ps_src_wait_off_time: Deadline (in ms) for tPSSourceOff timer
> > >   * @cc_debounce_time: Deadline (in ms) for tCCDebounce timer
> > > + * @pd2_sender_response_time: Deadline (in ms) for pd20 tSenderRespo=
nse timer
> > > + * @pd3_sender_response_time: Deadline (in ms) for pd30 tSenderRespo=
nse timer
> > >   */
> > >  struct pd_timings {
> > >       u32 sink_wait_cap_time;
> > >       u32 ps_src_off_time;
> > >       u32 cc_debounce_time;
> > >       u32 snk_bc12_cmpletion_time;
> > > +     u32 pd2_sender_response_time;
> > > +     u32 pd3_sender_response_time;
> > >  };
> > >
> > >  struct tcpm_port {
> > > @@ -3776,7 +3780,9 @@ static bool tcpm_send_queued_message(struct tcp=
m_port *port)
> > >                       } else if (port->pwr_role =3D=3D TYPEC_SOURCE) =
{
> > >                               tcpm_ams_finish(port);
> > >                               tcpm_set_state(port, HARD_RESET_SEND,
> > > -                                            PD_T_SENDER_RESPONSE);
> > > +                                            port->negotiated_rev >=
=3D PD_REV30 ?
> > > +                                            port->timings.pd3_sender=
_response_time :
> > > +                                            port->timings.pd2_sender=
_response_time);
> > >                       } else {
> > >                               tcpm_ams_finish(port);
> > >                       }
> > > @@ -4619,6 +4625,9 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >       enum typec_pwr_opmode opmode;
> > >       unsigned int msecs;
> > >       enum tcpm_state upcoming_state;
> > > +     u32 sender_response_time =3D port->negotiated_rev >=3D PD_REV30=
 ?
> > > +                                port->timings.pd3_sender_response_ti=
me :
> > > +                                port->timings.pd2_sender_response_ti=
me;
> > >
> > >       if (port->tcpc->check_contaminant && port->state !=3D CHECK_CON=
TAMINANT)
> > >               port->potential_contaminant =3D ((port->enter_state =3D=
=3D SRC_ATTACH_WAIT &&
> > > @@ -5113,7 +5122,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >                       tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> > >               } else {
> > >                       tcpm_set_state_cond(port, hard_reset_state(port=
),
> > > -                                         PD_T_SENDER_RESPONSE);
> > > +                                         sender_response_time);
> > >               }
> > >               break;
> > >       case SNK_NEGOTIATE_PPS_CAPABILITIES:
> > > @@ -5135,7 +5144,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >                               tcpm_set_state(port, SNK_READY, 0);
> > >               } else {
> > >                       tcpm_set_state_cond(port, hard_reset_state(port=
),
> > > -                                         PD_T_SENDER_RESPONSE);
> > > +                                         sender_response_time);
> > >               }
> > >               break;
> > >       case SNK_TRANSITION_SINK:
> > > @@ -5387,7 +5396,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >                       port->message_id_prime =3D 0;
> > >                       port->rx_msgid_prime =3D -1;
> > >                       tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, =
TCPC_TX_SOP_PRIME);
> > > -                     tcpm_set_state_cond(port, ready_state(port), PD=
_T_SENDER_RESPONSE);
> > > +                     tcpm_set_state_cond(port, ready_state(port), se=
nder_response_time);
> > >               } else {
> > >                       port->message_id =3D 0;
> > >                       port->rx_msgid =3D -1;
> > > @@ -5398,7 +5407,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >                               tcpm_set_state_cond(port, hard_reset_st=
ate(port), 0);
> > >                       else
> > >                               tcpm_set_state_cond(port, hard_reset_st=
ate(port),
> > > -                                                 PD_T_SENDER_RESPONS=
E);
> > > +                                                 sender_response_tim=
e);
> > >               }
> > >               break;
> > >
> > > @@ -5409,8 +5418,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >                       port->send_discover =3D true;
> > >                       port->send_discover_prime =3D false;
> > >               }
> > > -             tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
> > > -                                 PD_T_SENDER_RESPONSE);
> > > +             tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT, sender_=
response_time);
> > >               break;
> > >       case DR_SWAP_ACCEPT:
> > >               tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP)=
;
> > > @@ -5444,7 +5452,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >                       tcpm_set_state(port, ERROR_RECOVERY, 0);
> > >                       break;
> > >               }
> > > -             tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, PD_T_SE=
NDER_RESPONSE);
> > > +             tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, sender_=
response_time);
> > >               break;
> > >       case FR_SWAP_SEND_TIMEOUT:
> > >               tcpm_set_state(port, ERROR_RECOVERY, 0);
> > > @@ -5475,8 +5483,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >               break;
> > >       case PR_SWAP_SEND:
> > >               tcpm_pd_send_control(port, PD_CTRL_PR_SWAP, TCPC_TX_SOP=
);
> > > -             tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT,
> > > -                                 PD_T_SENDER_RESPONSE);
> > > +             tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT, sender_=
response_time);
> > >               break;
> > >       case PR_SWAP_SEND_TIMEOUT:
> > >               tcpm_swap_complete(port, -ETIMEDOUT);
> > > @@ -5574,8 +5581,7 @@ static void run_state_machine(struct tcpm_port =
*port)
> > >               break;
> > >       case VCONN_SWAP_SEND:
> > >               tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP, TCPC_TX_=
SOP);
> > > -             tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT,
> > > -                            PD_T_SENDER_RESPONSE);
> > > +             tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT, sender_re=
sponse_time);
> > >               break;
> > >       case VCONN_SWAP_SEND_TIMEOUT:
> > >               tcpm_swap_complete(port, -ETIMEDOUT);
> > > @@ -5656,23 +5662,21 @@ static void run_state_machine(struct tcpm_por=
t *port)
> > >               break;
> > >       case GET_STATUS_SEND:
> > >               tcpm_pd_send_control(port, PD_CTRL_GET_STATUS, TCPC_TX_=
SOP);
> > > -             tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
> > > -                            PD_T_SENDER_RESPONSE);
> > > +             tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT, sender_re=
sponse_time);
> > >               break;
> > >       case GET_STATUS_SEND_TIMEOUT:
> > >               tcpm_set_state(port, ready_state(port), 0);
> > >               break;
> > >       case GET_PPS_STATUS_SEND:
> > >               tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS, TCPC=
_TX_SOP);
> > > -             tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
> > > -                            PD_T_SENDER_RESPONSE);
> > > +             tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT, sende=
r_response_time);
> > >               break;
> > >       case GET_PPS_STATUS_SEND_TIMEOUT:
> > >               tcpm_set_state(port, ready_state(port), 0);
> > >               break;
> > >       case GET_SINK_CAP:
> > >               tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP, TCPC_T=
X_SOP);
> > > -             tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_=
RESPONSE);
> > > +             tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, sender_respo=
nse_time);
> > >               break;
> > >       case GET_SINK_CAP_TIMEOUT:
> > >               port->sink_cap_done =3D true;
> > > @@ -7109,6 +7113,18 @@ static void tcpm_fw_get_timings(struct tcpm_po=
rt *port, struct fwnode_handle *fw
> > >       ret =3D fwnode_property_read_u32(fwnode, "sink-bc12-completion-=
time-ms", &val);
> > >       if (!ret)
> > >               port->timings.snk_bc12_cmpletion_time =3D val;
> > > +
> > > +     ret =3D fwnode_property_read_u32(fwnode, "pd2-sender-response-t=
ime-ms", &val);
> > > +     if (!ret)
> > > +             port->timings.pd2_sender_response_time =3D val;
> > > +     else
> > > +             port->timings.pd2_sender_response_time =3D PD_T_PD2_SEN=
DER_RESPONSE;
> > > +
> > > +     ret =3D fwnode_property_read_u32(fwnode, "pd3-sender-response-t=
ime-ms", &val);
> > > +     if (!ret)
> > > +             port->timings.pd3_sender_response_time =3D val;
> > > +     else
> > > +             port->timings.pd3_sender_response_time =3D PD_T_PD3_SEN=
DER_RESPONSE;
> > >  }
> >
> > I can't see the whole thread, but I guess those properties were
> > okay(?).
> >
> > thanks,
> >
> > --
> > heikki

