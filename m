Return-Path: <stable+bounces-220022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH+GGmUwomke0wQAu9opvQ
	(envelope-from <stable+bounces-220022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:01:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B91481BF4C0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D0A30F1AD6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CDF394492;
	Sat, 28 Feb 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3kJf7Ul"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC7395261
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236808; cv=pass; b=EQtBcxMi3BAY/dhy+bIH9saL/7yTw9y5G04YjlMMg66/rphOsF80I+JtZWDff1ZyZfD74acnGkwxuYrkpOi4J8RFUotoFZt4B037R6ZzzjJBQZj//G4f/aQst/pJY10kqzXbXwPkpes0veScncQd0lCYD0RRVQItC8a/BwSwkyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236808; c=relaxed/simple;
	bh=B28KfXTVIHWAH+pwOzTyktHs/wteIJxouZMrqga+cf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUxLt3+no/Y012cFVU1KyBACBdF7X0SvzOr/7lH+bsrdv/rSTVSe8aG8fSorr2+WyJ3brNhsPhpIP9HzRmKGe7QvNTnchzVQzz9Zsu6CSSxy0rb7QZ1tQ2OQwCFxMyIJEUEjVBdyfBmRPo8P6okyVTn9MCKagOB7uhq2fo72u8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3kJf7Ul; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5033b64256dso168001cf.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 16:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772236806; cv=none;
        d=google.com; s=arc-20240605;
        b=IcUi4Eac+O4yF9PoXFE2sBOM+XdRMQYDm/94qCT3atH5yfSYkwGmxfv1vohPFTdE+Y
         FjqhdHsdVos6fT0Tfb6QV96YzUXow1ZLP77tqGyOMLt26u05Qy0cAiXMw7YyXlj+4fuW
         ibW2UFCOFCM0OxhXY2ToerCikbMLTfYaMkFJMESLcNJCY3S21nZq3ZJjkAMAS9EYlenc
         ed+kfCqUA6B8/DD2kL9RedvCLZmEIkGSdPVu9yWunBFJBGXuv53eCORZ8BsXTe4KpAzx
         CYqgz4nQ4P8ZKBvbGBqkl4x0WDUr4GbdWobliBXs0Iz2fWHEMKfEUCbX2nCPqLyd7/y1
         FY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yddjG/5Y0KXabUKtjnkcKD4FXkRFrDhaHT6JScxTco=;
        fh=ci6Vpip7Dajj7D0SsAFtnDz3SF5XkNL9J9oc+p3s/Zo=;
        b=Bkb7L9Ip5DtU3KHcwj/6brrbHR8UzeslaR0ejchaaJ3c+mkjyQGF79KleS5veBO16/
         CAKLI0T0oZpjeSQ1fGByE9tOULbU1lJopMEwzAofUDfL6++cDMDzVEMw1g7JqL2ce5uK
         zTA6glkmxjRRGYJt+p4QNxnTM8go5InoCGjomKduOVhmZgheZUgYdsWHUtbJ9cSBPJaj
         Lr1nQbT3t+sKfLPEmXrbTge9vTl8De7pY7dGAdKt4EkgrGYm5EEKpssCylcQmFn5UzJN
         ifHlnw7FL6bBywUoVBwfqtiUl9HpSgc18z2UsP1UxZOYvaaLQc0/LBRMG58t1L1Sipzm
         VjDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772236806; x=1772841606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yddjG/5Y0KXabUKtjnkcKD4FXkRFrDhaHT6JScxTco=;
        b=D3kJf7Ulct0SCkvf7I3kIVjfSnw596oHVi88qXDIsj1L78jKIfXZpnsApvXgSMA87p
         uNLRUEO5pHJaeADxQ2BzKrsZbUzGyPi0vbi8H1jCqxtnUDB/MwYsfHNZcUPmcv9JoEZG
         wk6UbzmB3fBlyflTajSQulknPQLEhL3veyhx/6FuLUlZnPniF2BlHbhc+jXEDwqnHBgq
         dEqKMCXccxx7pahMiowXkeS1Pf7CZiqh8IgazTnGXWY1JMoLIvxiiuQk/RIZWDYCg2Kl
         UXJpKeQC0oE2mxvTTK2OblRPmahc8XV5jQ3Q74FljHMaBKeV81bXtRvWItOb3R9oyotH
         uLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236806; x=1772841606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yddjG/5Y0KXabUKtjnkcKD4FXkRFrDhaHT6JScxTco=;
        b=d9piq3QlySQoVIN9V/oRC4II7Kt34NjtqlsJbU4zQYT2rgAmqwnF7OTjJQmRuKvhtN
         zRYvR32AbC8Iwo2VLo+/nKApAoSv0iFPzDjsLu46N9ZlsF6wqwA0xfSyQhvdBJvO7gkR
         3/kokVFNSX4LdIrQprrNq4Z7kXl0GRCNtiZsouTZaO1JIKH2eNZqz7SAL1M+XSKQhtLP
         2F691toHATuJz+/3UalqdLMwT7HIKKFg+rJLnEOIaiRmnFyOvZEEEW/lkgNZWR8J/Git
         Lf/Cpx9F+ExL87JHk7WFWIDCDRqnKaM7Hdew+LOnl6fcc8rIVF6YAxEaMVrjI5kxh8ba
         bTxA==
X-Forwarded-Encrypted: i=1; AJvYcCXQQQw5D6Knq1hcy6jrOZYBBTNtvIHj80ohY8XuZo+WY1z7QzxXixt/B9TGwH1Jk8x2HLwv74A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSb+YXARuI0qZ/aIcPPo5cr45Lhr8fdWYsUse7C3F/eq/AejlS
	BMmlLYnk7+oPOlllH6edekZcDw/Xb6LgrHOR/TWeFBxR7zH8YbSIVkYTvo8FyS8YPJYA2tJhR8z
	6ZXr245uK8+Im2J8jPHwCjfH5RGIq+bjydlwTxCbo
X-Gm-Gg: ATEYQzzbfdi33afBk704MlpEt95Zxjw1mVMxNlZ7Vf3+W7sJal3K0UITYKwehNsqDhP
	qJjyRhi2EUAlwPwHwZuGMsT+ICBOJ9vkhoTZuA0r5lx1xQjm/YvwscIYe/szSlmrqwMzWWebOyA
	Yf6CwrfPHgiocsIwF28k8pWKfSuvj8qjnThyHw6NIiVPQ+0vFWoN3Pg1MGa9uMjdeVUBwxHPXPA
	Tsb7A+qYoup38Y7qfkBevH0j4VyE9UIqaoEERSoIrhThJzrIsJMn99Z7JtgZ+y8MmOLQjr+3D+Q
	QdJ3HP276Nw/oYhmFg9g0pizXwJoWkcLwA8D2mNmYg==
X-Received: by 2002:a05:622a:1308:b0:501:4eae:dbfc with SMTP id
 d75a77b69052e-5076182d63bmr1756811cf.5.1772236805650; Fri, 27 Feb 2026
 16:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225064601.270301-1-guanyulin@google.com> <20260225064601.270301-3-guanyulin@google.com>
 <87fr6na0nw.wl-tiwai@suse.de>
In-Reply-To: <87fr6na0nw.wl-tiwai@suse.de>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Sat, 28 Feb 2026 08:00:00 +0800
X-Gm-Features: AaiRm53ptCFt_q2nGAuGSY2eM5lPNdvP7VORHK8-qrElNH6Lb3G9HX2FDoTgLos
Message-ID: <CAOuDEK1Rek7vaLLzvOqiN1jcuiESyOLYqjR+rY5htqEFayG2JA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ALSA: usb: qcom: manage offload device usage
To: Takashi Iwai <tiwai@suse.de>
Cc: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	harshit.m.mogalapalli@oracle.com, wesley.cheng@oss.qualcomm.com, 
	dan.carpenter@linaro.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220022-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B91481BF4C0
X-Rspamd-Action: no action

Hi Takashi,

Thanks for raising the concern. The fix I proposed aims only to
separate xhci_sideband_remove_interrupter() and usb_offload_put().
Let's wait for QC's reply to see whether this is a rigid fix.

 Regards,
 Guan-Yu

On Fri, Feb 27, 2026 at 1:13=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 25 Feb 2026 07:45:51 +0100,
> Guan-Yu Lin wrote:
> >
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
>
> Mostly it looks good to me, but a slight concern is the
> usb_offload_put() call in the error path of prepare_qmi_response().
> IIUC, the bitmap is cleared only at uaudio_event_ring_cleanup_free(),
> and you have also the usb_offload_put() call there.  I wonder whether
> this might lead to the refcount unbalance.
>
> I'm not sure whether the original driver code handles it well, and
> this could be already a bug there calling
> xhci_sideband_remove_interrupter(), though.
>
>
> thanks,
>
> Takashi
>
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
> > +
> >       ret =3D xhci_sideband_create_interrupter(uadev[card_num].sb, 1, f=
alse,
> >                                              0, uaudio_qdev->data->intr=
_num);
> >       if (ret < 0) {
> >               dev_err(&subs->dev->dev, "failed to fetch interrupter\n")=
;
> > -             goto exit;
> > +             goto put_offload;
> >       }
> >
> >       sgt =3D xhci_sideband_get_event_buffer(uadev[card_num].sb);
> > @@ -1219,6 +1230,8 @@ static int uaudio_event_ring_setup(struct snd_usb=
_substream *subs,
> >       mem_info->dma =3D 0;
> >  remove_interrupter:
> >       xhci_sideband_remove_interrupter(uadev[card_num].sb);
> > +put_offload:
> > +     usb_offload_put(subs->dev);
> >  exit:
> >       return ret;
> >  }
> > @@ -1483,6 +1496,7 @@ static int prepare_qmi_response(struct snd_usb_su=
bstream *subs,
> >       uaudio_iommu_unmap(MEM_EVENT_RING, IOVA_BASE, PAGE_SIZE, PAGE_SIZ=
E);
> >  free_sec_ring:
> >       xhci_sideband_remove_interrupter(uadev[card_num].sb);
> > +     usb_offload_put(subs->dev);
> >  drop_sync_ep:
> >       if (subs->sync_endpoint) {
> >               uaudio_iommu_unmap(MEM_XFER_RING,
> > @@ -1528,6 +1542,7 @@ static void handle_uaudio_stream_req(struct qmi_h=
andle *handle,
> >       u8 pcm_card_num;
> >       u8 pcm_dev_num;
> >       u8 direction;
> > +     struct usb_device *udev =3D NULL;
> >       int ret =3D 0;
> >
> >       if (!svc->client_connected) {
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
> >       }
> >
> >  response:
> > --
> > 2.53.0.414.gf7e9f6c205-goog
> >

