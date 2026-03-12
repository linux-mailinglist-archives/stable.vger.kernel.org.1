Return-Path: <stable+bounces-224897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH6rBfX2smmLRAAAu9opvQ
	(envelope-from <stable+bounces-224897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:25:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC772768A3
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A1523012BFF
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B23F87FA;
	Thu, 12 Mar 2026 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qcorwusU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A336C0D6
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336295; cv=pass; b=CqeDkWNKSla9vEcHbUaUGqJbVTsOQSGItOAGQ5hbgxThs9uqf4qmucF/9PkoZ/OgMkdzZfDBXTu3v0vgJBFTVCQzOQdrg6jzmmv4W0WKzWa1B69J+tepVfjp3eq2HpKPQDF2hg6kraS9DC/KKdixTaXpxp2jbY+jHm4iusZBtfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336295; c=relaxed/simple;
	bh=bA7SOYOZ5VpR5LevIqMsHdzI87xzujJLmcIyV5G8kSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqKRRhsEaIPo5jwBT4Oz+mwPWNwtEmIqJHOPsOg3QcZrt02yqTgEI5ZGOR4pgM5z99jXrbRwcQCDbCWAJMR1Oj7vDXaesBwcQ7uE9uHiNSgRvBAAXolpyI1Czdm7rtrnxygoywexqAwQQxVVeANQr623fj3pHocuxMiZGFVIQ2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qcorwusU; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5091ed02c54so35541cf.1
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 10:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773336292; cv=none;
        d=google.com; s=arc-20240605;
        b=P/X001FJz9+85PoCuDZi9BcRkxSqjO6SNuP96r9z/smsU+8xNqum2IRvj9ud7hjATE
         0tcEkcBN5gobBe89PkTRVe5uUU2jOmD6D9e4mNIJg0g51QJwDOFgySo6dZgNPE8kpACb
         EvSXzwGR6RowrZYwwNFqjIXb3dkvLaSSPEkLakfjXR+WwUKv95SYetBGTpSvwP6vPXzv
         WX8+pYWWA4bg+q4qywbmfIGYrf8bswW2zVPyOKDncdRSxLGHDT7/RqEte1/P28ulvZut
         2AH3N/TBdVB8FkPDlZ2mt92KqQKKxc8PEqMqJSD14+ClgQKksxfpCnKoUHCDGam1jpdI
         Iblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xjwzPu73xn+DNGk07wn7qgGLfPtqT0k3FiNx5Ciz7IE=;
        fh=OtZbzl1xr31Azmr2SHWJ23LAzeltyuNJxdfGgiRmyZ4=;
        b=VoS5KdIQsu7LrwsqhzzpFg2RbmN8LDGa03eekjoxXpAW+hH2O6ULiywUbl1CRgZHv6
         aKYdFg4RLAmvRidqSJWy05NNdnbEjtPNZxAB11q2bLOtTfWpY8kualOk2LYrUptsGcv0
         FqIBeDApoG9/VhNYuZhy+eC/aQcTvCaRlR9zZGNmApi70sHjukqn36juLxbeCSeAsFYh
         apDP1WydcZ03b7m+zQuwXFOxz7F7rh61Tc59XQ1HdTYOJunumYdxAwa0sNJD+NiW3Pqy
         0E3aAinIc4lFLryXrcwMsqUrtCZKjakTkt5EYz2YE8H9y5idizYNzx8xC0vFfdPzGsWB
         TdcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773336292; x=1773941092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjwzPu73xn+DNGk07wn7qgGLfPtqT0k3FiNx5Ciz7IE=;
        b=qcorwusUWgLEagS0h0wqRTUMJSSeiBzXm8fFgA4Q5yDqheU1lBokG8aU8Af158shen
         OgoAH26GfBTkTMD9MScsHu154PNnGkPc1TOu50VstIaVkGfmF+dqJEqhdKDKwHhX6w9y
         X1/dDqMYnSRUgWPVkDKKq6tfUTLQLD91iUgQN4A5htAqWzToujaKvRI+6PhxIEo86v6S
         Lk+qZqmc2il7DpvXyuuEu/wgPVUiLwoqJUVX07WWIAfgLrfz25xgOa3gMZWAwrOK2Ncj
         8+sWGmQMmhc/SBQi7qlQtZwkw3jPHFiSovSj5R2nNrIm3J8S0/E/4aGI++/WNmGAfcgN
         dlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336292; x=1773941092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjwzPu73xn+DNGk07wn7qgGLfPtqT0k3FiNx5Ciz7IE=;
        b=KuqyOM/ZvYrW1u0ucRJYmJZPhoeyjH7SZi3L9Oo+cGbJzInBGoW73c5LmFGeTfwTli
         0fnQcmNs9nTUGGNY73OfvHBgOmifvyQyzmYTELWPDwkv24LTvIU7wEUpVj52IFWev/7j
         j4p/W3DM1rvAQqDRLPAgubd6irUX25dgWmFKY56Xs0D7QkFClqbK3+pok1+044n+l0bj
         noeueDugpce46qt0QodG3uEVWLdVW3vzJOtebORh0SWk2BNzns8Y8UfQpn7H00lGnGGY
         PZP2dEiIbEz5ctWulovaGiOvI7lF9uKCke4DiZDPU01PXmVWTTNwOC/mF7RLj6F6wtNV
         NzJA==
X-Forwarded-Encrypted: i=1; AJvYcCVJFVzAzp+iK/EknOY2u2rTBTNmQUooCJbrBYrMF2PL6HwJuyPcuxaLIQOqhO+W/6cSjcD8Tvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFhwy9Yz7mpO7ljVa02dtePhw1fmcdJ2p5qBRso9zdubr8AaH
	CGFbAmSXUZjVhZGzIcvFllfhxLRSbQVMk9ALIs4P6VzNI0kNVxNMDSA26cOTlHMDWu1ijKzwEkp
	L9CbdBZqsHlzIvcIFgz0BkiZvEbvKfGjdZZq0VZQK
X-Gm-Gg: ATEYQzyenqPoxtXaLzIFWSqv2w3jn+lCgX4Dyw6TeAXfLN7Ajb11UT3Fo76kj78cPo+
	KFd6AxzgDtHN4sGmDhh9SNKag08Gwo84BVZZAJkEz6cUgQSchEdKwoz3cPVpNQdH72GYiZ2QvXB
	QGhOpnP1vPYQ0/inmciCUpCs4YD7M5M2/kIlgqSXqy21gRtdW3+nJzc5kdiX/Oxxt4ElilfVfa0
	QRFyWghacyl12kGziZYBgh+iap0HfsMHbyVltePH3dDWQ2MKBqybUEpHhs+vnl1aAgyZbag8rw1
	/aQPfA93
X-Received: by 2002:ac8:6618:0:b0:509:1cf9:ea11 with SMTP id
 d75a77b69052e-509585b0cbcmr211941cf.7.1773336291836; Thu, 12 Mar 2026
 10:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309022205.28136-1-guanyulin@google.com> <20260309022205.28136-3-guanyulin@google.com>
 <2026031115-unboxed-spouse-1dcd@gregkh>
In-Reply-To: <2026031115-unboxed-spouse-1dcd@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 12 Mar 2026 10:24:37 -0700
X-Gm-Features: AaiRm53x3rooP9tpQYr_vJVM2HZqK_Gt4rD4pP0lr2DOh0rRnTjTeszILknzfPw
Message-ID: <CAOuDEK3k6nyiHxhcL1kv=QNQaZMF6ms=sLerSZ5JBc5WBd7nAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: usb: qcom: manage offload device usage
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, perex@perex.cz, tiwai@suse.com, 
	quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	christophe.jaillet@wanadoo.fr, xiaopei01@kylinos.cn, 
	wesley.cheng@oss.qualcomm.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,wanadoo.fr,kylinos.cn,oss.qualcomm.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BC772768A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 5:31=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Mar 09, 2026 at 02:22:05AM +0000, Guan-Yu Lin wrote:
> > The Qualcomm USB audio offload driver currently does not report its off=
load
> > activity to the USB core. This prevents the USB core from properly trac=
king
> > active offload sessions, which could allow the device to auto-suspend w=
hile
> > audio offloading is in progress.
> >
> > Integrate usb_offload_get() and usb_offload_put() calls into the offloa=
d
> > stream setup and teardown paths. Specifically, call usb_offload_get() w=
hen
> > initializing the event ring and usb_offload_put() when freeing it.
> >
> > Since the updated usb_offload_get() and usb_offload_put() APIs require =
the
> > caller to hold the USB device lock, add the necessary device locking in
> > handle_uaudio_stream_req() and qmi_stop_session() to satisfy this
> > requirement.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ef82a4803aab ("xhci: sideband: add api to trace sideband usage")
> > Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> > ---
> >  sound/usb/qcom/qc_audio_offload.c | 102 ++++++++++++++++++------------
> >  1 file changed, 60 insertions(+), 42 deletions(-)
> >
> > diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audi=
o_offload.c
> > index cfb30a195364..1da243662327 100644
> > --- a/sound/usb/qcom/qc_audio_offload.c
> > +++ b/sound/usb/qcom/qc_audio_offload.c
> > @@ -699,6 +699,7 @@ static void uaudio_event_ring_cleanup_free(struct u=
audio_dev *dev)
> >               uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE,
> >                                  PAGE_SIZE);
> >               xhci_sideband_remove_interrupter(uadev[dev->chip->card->n=
umber].sb);
> > +             usb_offload_put(dev->udev);
> >       }
> >  }
> >
> > @@ -750,6 +751,7 @@ static void qmi_stop_session(void)
> >       struct snd_usb_substream *subs;
> >       struct usb_host_endpoint *ep;
> >       struct snd_usb_audio *chip;
> > +     struct usb_device *udev;
> >       struct intf_info *info;
> >       int pcm_card_num;
> >       int if_idx;
> > @@ -791,8 +793,13 @@ static void qmi_stop_session(void)
> >                       disable_audio_stream(subs);
> >               }
> >               atomic_set(&uadev[idx].in_use, 0);
> > -             guard(mutex)(&chip->mutex);
> > -             uaudio_dev_cleanup(&uadev[idx]);
> > +
> > +             udev =3D uadev[idx].udev;
> > +             if (udev) {
> > +                     guard(device)(&udev->dev);
> > +                     guard(mutex)(&chip->mutex);
> > +                     uaudio_dev_cleanup(&uadev[idx]);
>
> Two locks?  For one structure?  Is this caller verifying that those
> locks are held?
>

The device lock is used for usb_offload_get/put apis below. We want to
maintain a strict lock ordering to aviod ABBA deadlocks.
The caller wasn't verifying the &chip->mutex lock before. Do you want
me to add it as well?

> > +             }
> >       }
> >  }
> >
> > @@ -1183,11 +1190,15 @@ static int uaudio_event_ring_setup(struct snd_u=
sb_substream *subs,
> >       er_pa =3D 0;
> >
> >       /* event ring */
> > +     ret =3D usb_offload_get(subs->dev);
> > +     if (ret < 0)
> > +             goto exit;
>
> Where is the lock being held here?
>

It's held in the handle_uaudio_stream_req function above.

> This pushing the lock for USB calls "higher" up the call chain is rough,
> and almost impossible to audit, given changes like this:
>
> > @@ -1597,50 +1612,53 @@ static void handle_uaudio_stream_req(struct qmi=
_handle *handle,
> >
> >       uadev[pcm_card_num].ctrl_intf =3D chip->ctrl_intf;
> >
> > -     if (req_msg->enable) {
> > -             ret =3D enable_audio_stream(subs,
> > -                                       map_pcm_format(req_msg->audio_f=
ormat),
> > -                                       req_msg->number_of_ch, req_msg-=
>bit_rate,
> > -                                       datainterval);
> > -
> > -             if (!ret)
> > -                     ret =3D prepare_qmi_response(subs, req_msg, &resp=
,
> > -                                                info_idx);
> > -             if (ret < 0) {
> > -                     guard(mutex)(&chip->mutex);
> > -                     subs->opened =3D 0;
> > -             }
> > -     } else {
> > -             info =3D &uadev[pcm_card_num].info[info_idx];
> > -             if (info->data_ep_pipe) {
> > -                     ep =3D usb_pipe_endpoint(uadev[pcm_card_num].udev=
,
> > -                                            info->data_ep_pipe);
> > -                     if (ep) {
> > -                             xhci_sideband_stop_endpoint(uadev[pcm_car=
d_num].sb,
> > -                                                         ep);
> > -                             xhci_sideband_remove_endpoint(uadev[pcm_c=
ard_num].sb,
> > -                                                           ep);
> > +     udev =3D subs->dev;
> > +     scoped_guard(device, &udev->dev) {
> > +             if (req_msg->enable) {
> > +                     ret =3D enable_audio_stream(subs,
> > +                                             map_pcm_format(req_msg->a=
udio_format),
> > +                                             req_msg->number_of_ch, re=
q_msg->bit_rate,
> > +                                             datainterval);
> > +
> > +                     if (!ret)
> > +                             ret =3D prepare_qmi_response(subs, req_ms=
g, &resp,
> > +                                                     info_idx);
> > +                     if (ret < 0) {
> > +                             guard(mutex)(&chip->mutex);
> > +                             subs->opened =3D 0;
> > +                     }
> > +             } else {
> > +                     info =3D &uadev[pcm_card_num].info[info_idx];
> > +                     if (info->data_ep_pipe) {
> > +                             ep =3D usb_pipe_endpoint(uadev[pcm_card_n=
um].udev,
> > +                                                     info->data_ep_pip=
e);
> > +                             if (ep) {
> > +                                     xhci_sideband_stop_endpoint(uadev=
[pcm_card_num].sb,
> > +                                                                     e=
p);
> > +                                     xhci_sideband_remove_endpoint(uad=
ev[pcm_card_num].sb,
> > +                                                                     e=
p);
> > +                             }
> > +
> > +                             info->data_ep_pipe =3D 0;
> >                       }
> >
> > -                     info->data_ep_pipe =3D 0;
> > -             }
> > -
> > -             if (info->sync_ep_pipe) {
> > -                     ep =3D usb_pipe_endpoint(uadev[pcm_card_num].udev=
,
> > -                                            info->sync_ep_pipe);
> > -                     if (ep) {
> > -                             xhci_sideband_stop_endpoint(uadev[pcm_car=
d_num].sb,
> > -                                                         ep);
> > -                             xhci_sideband_remove_endpoint(uadev[pcm_c=
ard_num].sb,
> > -                                                           ep);
> > +                     if (info->sync_ep_pipe) {
> > +                             ep =3D usb_pipe_endpoint(uadev[pcm_card_n=
um].udev,
> > +                                                     info->sync_ep_pip=
e);
> > +                             if (ep) {
> > +                                     xhci_sideband_stop_endpoint(uadev=
[pcm_card_num].sb,
> > +                                                                     e=
p);
> > +                                     xhci_sideband_remove_endpoint(uad=
ev[pcm_card_num].sb,
> > +                                                                     e=
p);
> > +                             }
> > +
> > +                             info->sync_ep_pipe =3D 0;
> >                       }
> >
> > -                     info->sync_ep_pipe =3D 0;
> > +                     disable_audio_stream(subs);
> > +                     guard(mutex)(&chip->mutex);
> > +                     subs->opened =3D 0;
> >               }
> > -
> > -             disable_audio_stream(subs);
> > -             guard(mutex)(&chip->mutex);
> > -             subs->opened =3D 0;
>
> You have multiple levels of locks here, which is always a sign that
> something has gone really wrong.  This looks even more fragile and easy
> to get wrong than before.  Are you _SURE_ this is the only way to solve
> this?  The whole usb_offload_get() api seems more wrong to me than
> before (and I didn't like it even then...)
>
> In other words, this patch set feels rough, and adds more complexity
> overall, requiring a reviewer to "know" where locks are held and not
> held while before they did not.  That's a lot to push onto us for
> something that feels like is due to a broken hardware design?
>
> thanks,
>
> greg k-h

A known deadlock exists in the current design, caused by USB locks
sometimes being held in the higher function (e.g. during the USB
connection change). Due to this nature, I think if we want a design to
cover these two scenarios, certain degree of lock mainpulation is
required. I agree this is not an elegant way to address the issue.
What approach do you think better addresses this problem?

Regards,
Guan-Yu

