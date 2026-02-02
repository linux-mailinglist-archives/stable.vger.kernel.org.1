Return-Path: <stable+bounces-213045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K0uDXR5gGne8gIAu9opvQ
	(envelope-from <stable+bounces-213045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:16:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D18CAB63
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 11:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA91E300D091
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB02E6CAA;
	Mon,  2 Feb 2026 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhzMO4su"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27355313543
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026682; cv=pass; b=MMjQJaifh6T5vZCGns6L2IkMbT63SMdlVrV/MTot2QIwJflc9O260yErl6zj2TP2iQiXjc32knft/xSMuBwvA0nzT+FQA7zT1iQbJkrQQuYE3Sz7PZJFhF6e3C6NFfZhnsSgh76CLGiQfl0pl7vaunA3aozo4+EEz9F9hb1q41g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026682; c=relaxed/simple;
	bh=a/EjgiLJBN61zKW9j8WRcNN7IJvqvqLFYbpkn1obKfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kr6+mKaX6b3lYWiBH4wTBp97X3dBqkVFz5Rv324TKBJZaXSelDne9MtMm38x50HLEKG4osMhu+q4a2BqELH10K4J3U9j78S4NBNLsnL8BdIlCxmrflTdZxhP/wiZh5/4v3ImLgz2HQ4fBmJsx36rdLRTCQOuDIPa21zQFuaLRr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhzMO4su; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014b5d8551so743141cf.0
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 02:04:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770026680; cv=none;
        d=google.com; s=arc-20240605;
        b=MlSV8Z+D58Fkg7Fj8DgaIS3IMolkYCi57E9LEOgOg70mlKvpe4ybsMlZAmZE/aa7+X
         rOhV9rnK6QGNz7EZPrQIA1Ctu6IRzQ59rktVRdOKNNMYYfGc2S/E5L9r4ki1i0gum0B0
         OJZqYDkWxvVBEG2L+hf/Il8j7kBs0T8ZZhSBTEGCr2ZhLtyXtcM+iFZLUidlpZzmqlx6
         ia762FhSl/xRJ/znH3RMyKC+Dwkh81SidJPmtJE21TOuqizjubm+C3h/eYT8axugJ127
         vs2VV5Z3ht0W0NkLuYGpELzoTEwGqIo3iwmcEfYXFrO9+bPusWwZGJd1kmgje5XeVyQk
         YGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oBCrVhGDpTv4X/aChaxRKx5DWFmEAWePHe7FKvrzIYY=;
        fh=fYITS5CHd0h/IAZLwG3SAd6iUu/DKM49ZELg6gK7p+g=;
        b=RMN3t5MfYKsInUyLsPgwWqqNoIOtLNhrJaE9jFlKK3wJq2yIdfcDQ6sDC0i9285aU1
         lfxhCIVK2U72+UcVU5yxLguLqiuBNJN8igaZz2LAtXlMkxUnJzLDRW/slY7vl9Vih3up
         b/Gdi1b2+egsSJVarQk7PCy0Zni0Gp2SMRPxse5boKqWC3W7k2LXzQ/WEGkpIfFVvMUI
         aLhGo/rqabWwPFhGFs/119n/Ia6vKAd35fctYgTYNYwrSwoqiinjQKKttoQnsrkDOT/E
         jm2dyhdDcXBQEz3AWXXxBiu3VPDHzvOa7J2t6FRjbVQYFd+QwreLOeICAuPd7KWCwPv+
         LmMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770026680; x=1770631480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBCrVhGDpTv4X/aChaxRKx5DWFmEAWePHe7FKvrzIYY=;
        b=mhzMO4su+b45IePlHxPTlvXXJDCMKCv4ACHXqiva2HB/2zGtwqeypXa/gibLBvYNYr
         n4cEICjLVWY7mdw9qCSuSNUfFL4MTwjHR8O2pai1quwpELCPkVYY/bjD6g2NR+ggzirS
         Y3FJrtszwRcqY6JJMASgQifjAFGXPu/VPM+4J/vKKpfg1u3atZGUsX9NYjY/hOnRC3ws
         CuwY+8z3KDPjgS0TnRb9/VmJOsrK9r/GfBh0WJhaUJoWzPIfHNuBZllsoZbx4RghLZsg
         52kp83kZwMfZBdHslNYpsS9CTck8+VlSQJRSR9PH7yNoILP2+8nGZK7XNfi48vLCaRC2
         y2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026680; x=1770631480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBCrVhGDpTv4X/aChaxRKx5DWFmEAWePHe7FKvrzIYY=;
        b=ui8WjmUU7HnTuYLqpwpNJiNooKDxSshjy0SdwX5ZmiBaqbOIr2pEx8QuNZGufkBhpf
         s+R7pTLY9XB8nlmOvLDZGvYO6K4MWiZs6NkPHmpuMu6Xja3Sc12VWdzgHPz/OAy2ZEBB
         xkUKYCGFr1uKlzibVdyta8hFnEgcgRkwcY+RKLmC3ZbhiN6qUbYveRHhlGrwS1Lml+7B
         TPes1ulQt0sSI1DGFZQyVbcBebACTXJLkwV9Bj5tQDqnocNQEWw5LJrtg2wkL9Yjd2Ri
         VR5QDbJ08I29k9991pHiCxIuOwhZkBoJSBpacXyahpUTCeQE7ffB4cqybZQ+jErrtvId
         4aAw==
X-Forwarded-Encrypted: i=1; AJvYcCVNJjSDM82WDF5uNV1ZSjyn30Q7i+pGL2jpv+7uLuVhR9Btpkdc67WR5vYZt38vbAl2VPeV/h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlYdoFRo3IqKfI8OkOI5GY6w8dJyv3rCHfe+mLbpXlWbsg/AIK
	bP4sQn5Az6FzS167WEi2qpjMa2BRZQxys85Gfu5b1lmpfklv7JPBkZozHOvR4W/fCLEUVqBJeDE
	rBpx7iIUl4EzhQEsOrn1W9O609RVeyX914DCRoW5S
X-Gm-Gg: AZuq6aJnBOwVW086UK/P9gRf4ShjNcg9Utzd4g5dajZhE3rSfRoZtsQwleuZ63d8Mgs
	Np6Nr7ArJda1fSaSnDI6UPo5OBMo4RuHAJQxQFl6OK+1CboIJtqHdyhGmboI230bmLJvORflMFJ
	Qu0sR25SiLF+H6xPsAwOR4KfHT05r290pvqNbHiYp1DubcVYvPb8j3u/Rnoik31/2uENBDCq+c/
	JADzB3a+mmz0bV2moAmJp4uvBQwmfxOrM9Agpd/Wkp1jTPap3Z0sXVUMRlR1Rk0FPhW4DWEjdIq
	9XbfkVFRtRJotYC46eJ+0mY=
X-Received: by 2002:a05:622a:180d:b0:503:2e98:7842 with SMTP id
 d75a77b69052e-505dedf4092mr21061921cf.4.1770026679666; Mon, 02 Feb 2026
 02:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130074746.287750-1-guanyulin@google.com> <2026013133-tamale-massager-3c76@gregkh>
In-Reply-To: <2026013133-tamale-massager-3c76@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Mon, 2 Feb 2026 18:03:00 +0800
X-Gm-Features: AZwV_Qiw9LmBNa2njA4zcXW58SE7Ga7QU8lfb3Xm13kx5RUB38KsTHpij3-s71g
Message-ID: <CAOuDEK0o2jqqOUZVUdi9JDcyXRQHEuL9GCBrU0VQhWAfDtJnUg@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: host: xhci-sideband: fix deadlock in unregister path
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, stern@rowland.harvard.edu, 
	wesley.cheng@oss.qualcomm.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213045-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 59D18CAB63
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 8:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jan 30, 2026 at 07:47:46AM +0000, Guan-Yu Lin wrote:
> > When a USB device is disconnected or a driver is unbound, the USB core
> > invokes the driver's disconnect callback while holding the udev device
> > lock. If the driver calls xhci_sideband_unregister(), it eventually
> > reaches usb_offload_put(), which attempts to acquire the same udev
> > lock, resulting in a self-deadlock.
> >
> > Introduce lockless variants __usb_offload_get() and __usb_offload_put()
> > to allow modifying the offload usage count when the device lock is
> > already held. These helpers use device_lock_assert() to ensure callers
> > meet the locking requirements.
>
> Ugh.  Didn't I warn about this when the original functions were added?
>
> Adding functions with __ is a mess, please make these names, if you
> _REALLY_ need them, obvious that this is a no lock function.
>
> And now that you added the lockless functions, are there any in-kernel
> users of the locked versions?  At a quick glance I didn't see them, did
> I miss it somewhere?
>
> thanks,
>
> greg k-h

Hi Greg,

You are right; xhci-sideband.c is the only in-kernel user of the
locked versions. I will rename the __ functions to usb_offload_* and
remove the locked variants in the next version to clean up the API.

Regarding the deadlock fix itself, we have analyzed two potential
solutions. The core issue is that xhci_sideband_unregister() (and
xhci_sideband_remove_interrupter()) needs to decrement the offload
usage count (which requires the USB device lock), but it is called
from the disconnect path where that lock is already held.

Option A: Fix the Callers of xhci_sideband functions
In this approach, we keep the usb_offload calls inside the
xhci_sideband functions but replace the internal usb_lock_device()
with device_lock_assert(). We then update callers in
qc_audio_offload.c to explicitly acquire the lock.
This ensures the offload count remains tightly coupled with the
interrupter's lifecycle, though it effectively changes the API
contract: calling xHCI sideband functions now requires holding the USB
device lock.

Option B: Decouple usb_offload functions from xhci_sideband functions
In this approach, we strip the usb_offload calls out of xhci_sideband
functions entirely. The client driver (qc_audio_offload) becomes
responsible for the full transaction: acquiring the lock, managing
usb_offload_get/put(), and creating/removing the interrupter. This
restores clean encapsulation (xHCI functions only handle hardware),
but it places the burden on the client driver to correctly balance the
usb_offload calls.

I lean towards Option A to ensure the offload count implies an active
interrupter by design, but please let me know if you prefer the
cleaner separation of Option B.

Regards,
Guan-Yu

