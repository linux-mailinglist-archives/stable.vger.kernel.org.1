Return-Path: <stable+bounces-105422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03DF9F9362
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 14:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD49163F2F
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 13:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DBE2156E2;
	Fri, 20 Dec 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDas9sUM"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73541C6A;
	Fri, 20 Dec 2024 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734701969; cv=none; b=N8EyAWrQ03u6+zYZ3d/StKOZ1xRu5cV+uewOuIpa1OMwek/cXGQtrxhhmfnonR0WjbB9C1OamUKjX8sOnhb6xu8FSzJBFPSBonmaqWH9GgjaFP2p11KRQnGK8k9hdPwmkRIPCgjICuHH7LUliQB30G0skXH7PhlJu+NN8RA1srY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734701969; c=relaxed/simple;
	bh=2qUU8li3aTo5PZtrk6vEnpxG6YHUKH5AH82X/bm8YRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k11m2I7sXLcTaSdgeIePJTQ4zkHkXNjxxhA3ZmJ5OxhI8OMR8RFl7IIczg6mcd4Gjs1M47UKiOIHQHn9BBBQ2VvSw4RncIaR64VlFtBXfXU6hiRIEIH+wr9jqu2xD3FjBgtOOpUQZ1npFM/NrTbT800ngVYKhoQn+aASbpUP2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDas9sUM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2a3c075ddb6so945602fac.2;
        Fri, 20 Dec 2024 05:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734701967; x=1735306767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQKnJ40KX0+1jmU8G7Cfb00du5PhUTYpoWNUkTQ88Is=;
        b=TDas9sUMY2VlFNxB338lv7zo74vCc++kvA+KcpEf8kHtPCmsam1Y+qFusKaOiiTx4F
         1qcHu5nGqULZXkZuXaFWs09ajF6I1R4Ya4INSXEeJhFFBTeEXbguVTi2HzNDPeba3bct
         ppgApcgur5sPWqDGRbBKkLVHfSlcR6IOi2m+N8IUl6kj6PpeLehpoQ0JXz3h9TTenGQ8
         ZDxmjE0eQsPdHsmAl9Mx77Fkx9XFSuMZdmKT9+1e5gc2o+Bs+GVptUHGVMrCCUPPrmFu
         BUooH5C/YsFc4IHDZ3pgJ59RdPPrwEeNN69dc5VTkiNb+UzFCRoJsQGY4H4Ompc/IXN9
         iPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734701967; x=1735306767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQKnJ40KX0+1jmU8G7Cfb00du5PhUTYpoWNUkTQ88Is=;
        b=sFei+aXfnMweY65DbTNRJntsSuS5hRM7FkVQ728xk5HOxB3KkJa45zof8dySJxgs+n
         3BF88FeR0CR0OzTNkoIj0ViIe3vRViALBLpRyOGwBO1rolEkVDfiv6sFtzyCXRcsT2TF
         o17FUOTnYDs48haHk+ZXj+6xEDCQqvBYgafFqBa2Bir0O5Kh9/T2WyyLBPTsjTib4dv0
         y/hbwVmNhzKRB1srUI18Y2FqG430LdjZTESBkLv8jcDWT4lUj1OXk9pJE8ChL3cIGtog
         +D56tfEPwGg/j2ulDja4REz1rEtDme1RQgY7L1ailc5tHT+C2JTRBApMSW0eR/bfd44j
         +zbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT+l5WUNKuMzt8qcR1lz7UTMn9bH2F5Yvi5ckR4nokfE25ZG6YE+sVGFdRnMEJkEIZtSX4c4Px@vger.kernel.org, AJvYcCWTciLTkIw36UeAhuQ35wK5sle567+JbMfp2vhSEAfj4qG+6RBmIMZVajef1RXmEbM1m6DRH4rQsQnE@vger.kernel.org, AJvYcCWsRAgtbtjeoN1YyYGLnT+g3twvCdA/f4RT7grrHUYIPXoaS1wsvuU9Zv786p8Jdn8/GZklWsvjIY20R9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBdRNGJQVTx8XPyO+V5u26rX03tTLyZBKwaI5jHob9jW8vENok
	c1us5I8Zn/dis+5ejoAzwAzRxwZ2bS2t5Bxcex7YmE2tVtuQDRBuSrdkiVoYPeZsDac8KTMf/Ww
	/gJJx0rfIz4Df+IcpJTs/lsm+YVM=
X-Gm-Gg: ASbGncuDQM+JTW94+SA+pq1Qh4j26VXrIwyIm2XwKr7qn2W7+i3TXNFK3QzzJroKFLI
	nHtTL9gzFQwgs+exd6DCH/trwZXEbVDxlpNTCKDI=
X-Google-Smtp-Source: AGHT+IF4bR8y2vVHK4XMzmTGh+h/VI63tJEne+pUOdwd7kKjajB/8oECNRwW5XY9RhpX8uM7D0caDUVB36fu5fDKVrw=
X-Received: by 2002:a05:6871:36c1:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-2a7fb1effa9mr1461342fac.25.1734701966823; Fri, 20 Dec 2024
 05:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241215125013.70671-1-joswang1221@gmail.com> <Z2Kd-k5icFTLeJkT@kuha.fi.intel.com>
In-Reply-To: <Z2Kd-k5icFTLeJkT@kuha.fi.intel.com>
From: Jos Wang <joswang1221@gmail.com>
Date: Fri, 20 Dec 2024 21:39:20 +0800
Message-ID: <CAMtoTm37OuzjE_V7okkV9NZS8hD57MG=WqfiEnh68SJTHmEgig@mail.gmail.com>
Subject: Re: [PATCH 2/2] usb: typec: tcpm: fix the sender response time issue
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your help in reviewing the code.

USB PD3 CTS specification=EF=BC=9A
https://usb.org/document-library/usb-power-delivery-compliance-test-specifi=
cation-0
Should this link be added to the commit message?

I will resubmit the code as soon as possible and put patch 1/2 and 2/2
in the same thread.

On Wed, Dec 18, 2024 at 6:03=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> On Sun, Dec 15, 2024 at 08:50:13PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > According to the USB PD3 CTS specification, the requirements
>
> What is "USB PD3 CTS specification"? Please open it here.
>
> > for tSenderResponse are different in PD2 and PD3 modes, see
> > Table 19 Timing Table & Calculations. For PD2 mode, the
> > tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> > tSenderResponse min 27ms and max 33ms.
> >
> > For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> > item, after receiving the Source_Capabilities Message sent by
> > the UUT, the tester deliberately does not send a Request Message
> > in order to force the SenderResponse timer on the Source UUT to
> > timeout. The Tester checks that a Hard Reset is detected between
> > tSenderResponse min and max=EF=BC=8Cthe delay is between the last bit o=
f
> > the GoodCRC Message EOP has been sent and the first bit of Hard
> > Reset SOP has been received. The current code does not distinguish
> > between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> > This will cause this test item and the following tests to fail:
> > TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> > TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> >
> > Considering factors such as SOC performance, i2c rate, and the speed
> > of PD chip sending data, "pd2-sender-response-time-ms" and
> > "pd3-sender-response-time-ms" DT time properties are added to allow
> > users to define platform timing. For values that have not been
> > explicitly defined in DT using this property, a default value of 27ms
> > for PD2 tSenderResponse and 30ms for PD3 tSenderResponse is set.
> >
> > Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
>
> If this is a fix, then I think it's fixing commit 2eadc33f40d4
> ("typec: tcpm: Add core support for sink side PPS"). That's where the
> pd_revision was changed to 3.0.
>
> Badhri, could you take a look at this (and how about that
> maintainer role? :-) ).
>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 50 +++++++++++++++++++++++------------
> >  include/linux/usb/pd.h        |  3 ++-
> >  2 files changed, 35 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 6021eeb903fe..3a159bfcf382 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -314,12 +314,16 @@ struct pd_data {
> >   * @sink_wait_cap_time: Deadline (in ms) for tTypeCSinkWaitCap timer
> >   * @ps_src_wait_off_time: Deadline (in ms) for tPSSourceOff timer
> >   * @cc_debounce_time: Deadline (in ms) for tCCDebounce timer
> > + * @pd2_sender_response_time: Deadline (in ms) for pd20 tSenderRespons=
e timer
> > + * @pd3_sender_response_time: Deadline (in ms) for pd30 tSenderRespons=
e timer
> >   */
> >  struct pd_timings {
> >       u32 sink_wait_cap_time;
> >       u32 ps_src_off_time;
> >       u32 cc_debounce_time;
> >       u32 snk_bc12_cmpletion_time;
> > +     u32 pd2_sender_response_time;
> > +     u32 pd3_sender_response_time;
> >  };
> >
> >  struct tcpm_port {
> > @@ -3776,7 +3780,9 @@ static bool tcpm_send_queued_message(struct tcpm_=
port *port)
> >                       } else if (port->pwr_role =3D=3D TYPEC_SOURCE) {
> >                               tcpm_ams_finish(port);
> >                               tcpm_set_state(port, HARD_RESET_SEND,
> > -                                            PD_T_SENDER_RESPONSE);
> > +                                            port->negotiated_rev >=3D =
PD_REV30 ?
> > +                                            port->timings.pd3_sender_r=
esponse_time :
> > +                                            port->timings.pd2_sender_r=
esponse_time);
> >                       } else {
> >                               tcpm_ams_finish(port);
> >                       }
> > @@ -4619,6 +4625,9 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >       enum typec_pwr_opmode opmode;
> >       unsigned int msecs;
> >       enum tcpm_state upcoming_state;
> > +     u32 sender_response_time =3D port->negotiated_rev >=3D PD_REV30 ?
> > +                                port->timings.pd3_sender_response_time=
 :
> > +                                port->timings.pd2_sender_response_time=
;
> >
> >       if (port->tcpc->check_contaminant && port->state !=3D CHECK_CONTA=
MINANT)
> >               port->potential_contaminant =3D ((port->enter_state =3D=
=3D SRC_ATTACH_WAIT &&
> > @@ -5113,7 +5122,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >                       tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> >               } else {
> >                       tcpm_set_state_cond(port, hard_reset_state(port),
> > -                                         PD_T_SENDER_RESPONSE);
> > +                                         sender_response_time);
> >               }
> >               break;
> >       case SNK_NEGOTIATE_PPS_CAPABILITIES:
> > @@ -5135,7 +5144,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >                               tcpm_set_state(port, SNK_READY, 0);
> >               } else {
> >                       tcpm_set_state_cond(port, hard_reset_state(port),
> > -                                         PD_T_SENDER_RESPONSE);
> > +                                         sender_response_time);
> >               }
> >               break;
> >       case SNK_TRANSITION_SINK:
> > @@ -5387,7 +5396,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >                       port->message_id_prime =3D 0;
> >                       port->rx_msgid_prime =3D -1;
> >                       tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TC=
PC_TX_SOP_PRIME);
> > -                     tcpm_set_state_cond(port, ready_state(port), PD_T=
_SENDER_RESPONSE);
> > +                     tcpm_set_state_cond(port, ready_state(port), send=
er_response_time);
> >               } else {
> >                       port->message_id =3D 0;
> >                       port->rx_msgid =3D -1;
> > @@ -5398,7 +5407,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >                               tcpm_set_state_cond(port, hard_reset_stat=
e(port), 0);
> >                       else
> >                               tcpm_set_state_cond(port, hard_reset_stat=
e(port),
> > -                                                 PD_T_SENDER_RESPONSE)=
;
> > +                                                 sender_response_time)=
;
> >               }
> >               break;
> >
> > @@ -5409,8 +5418,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >                       port->send_discover =3D true;
> >                       port->send_discover_prime =3D false;
> >               }
> > -             tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
> > -                                 PD_T_SENDER_RESPONSE);
> > +             tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT, sender_re=
sponse_time);
> >               break;
> >       case DR_SWAP_ACCEPT:
> >               tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
> > @@ -5444,7 +5452,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >                       tcpm_set_state(port, ERROR_RECOVERY, 0);
> >                       break;
> >               }
> > -             tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, PD_T_SEND=
ER_RESPONSE);
> > +             tcpm_set_state_cond(port, FR_SWAP_SEND_TIMEOUT, sender_re=
sponse_time);
> >               break;
> >       case FR_SWAP_SEND_TIMEOUT:
> >               tcpm_set_state(port, ERROR_RECOVERY, 0);
> > @@ -5475,8 +5483,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >               break;
> >       case PR_SWAP_SEND:
> >               tcpm_pd_send_control(port, PD_CTRL_PR_SWAP, TCPC_TX_SOP);
> > -             tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT,
> > -                                 PD_T_SENDER_RESPONSE);
> > +             tcpm_set_state_cond(port, PR_SWAP_SEND_TIMEOUT, sender_re=
sponse_time);
> >               break;
> >       case PR_SWAP_SEND_TIMEOUT:
> >               tcpm_swap_complete(port, -ETIMEDOUT);
> > @@ -5574,8 +5581,7 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >               break;
> >       case VCONN_SWAP_SEND:
> >               tcpm_pd_send_control(port, PD_CTRL_VCONN_SWAP, TCPC_TX_SO=
P);
> > -             tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT,
> > -                            PD_T_SENDER_RESPONSE);
> > +             tcpm_set_state(port, VCONN_SWAP_SEND_TIMEOUT, sender_resp=
onse_time);
> >               break;
> >       case VCONN_SWAP_SEND_TIMEOUT:
> >               tcpm_swap_complete(port, -ETIMEDOUT);
> > @@ -5656,23 +5662,21 @@ static void run_state_machine(struct tcpm_port =
*port)
> >               break;
> >       case GET_STATUS_SEND:
> >               tcpm_pd_send_control(port, PD_CTRL_GET_STATUS, TCPC_TX_SO=
P);
> > -             tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
> > -                            PD_T_SENDER_RESPONSE);
> > +             tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT, sender_resp=
onse_time);
> >               break;
> >       case GET_STATUS_SEND_TIMEOUT:
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> >       case GET_PPS_STATUS_SEND:
> >               tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS, TCPC_T=
X_SOP);
> > -             tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
> > -                            PD_T_SENDER_RESPONSE);
> > +             tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT, sender_=
response_time);
> >               break;
> >       case GET_PPS_STATUS_SEND_TIMEOUT:
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> >       case GET_SINK_CAP:
> >               tcpm_pd_send_control(port, PD_CTRL_GET_SINK_CAP, TCPC_TX_=
SOP);
> > -             tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, PD_T_SENDER_RE=
SPONSE);
> > +             tcpm_set_state(port, GET_SINK_CAP_TIMEOUT, sender_respons=
e_time);
> >               break;
> >       case GET_SINK_CAP_TIMEOUT:
> >               port->sink_cap_done =3D true;
> > @@ -7109,6 +7113,18 @@ static void tcpm_fw_get_timings(struct tcpm_port=
 *port, struct fwnode_handle *fw
> >       ret =3D fwnode_property_read_u32(fwnode, "sink-bc12-completion-ti=
me-ms", &val);
> >       if (!ret)
> >               port->timings.snk_bc12_cmpletion_time =3D val;
> > +
> > +     ret =3D fwnode_property_read_u32(fwnode, "pd2-sender-response-tim=
e-ms", &val);
> > +     if (!ret)
> > +             port->timings.pd2_sender_response_time =3D val;
> > +     else
> > +             port->timings.pd2_sender_response_time =3D PD_T_PD2_SENDE=
R_RESPONSE;
> > +
> > +     ret =3D fwnode_property_read_u32(fwnode, "pd3-sender-response-tim=
e-ms", &val);
> > +     if (!ret)
> > +             port->timings.pd3_sender_response_time =3D val;
> > +     else
> > +             port->timings.pd3_sender_response_time =3D PD_T_PD3_SENDE=
R_RESPONSE;
> >  }
>
> I can't see the whole thread, but I guess those properties were
> okay(?).
>
> thanks,
>
> --
> heikki

