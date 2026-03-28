Return-Path: <stable+bounces-230793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFpOE7bux2mcfAUAu9opvQ
	(envelope-from <stable+bounces-230793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 16:07:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCD34EC92
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 16:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84E373013D6A
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969FF344057;
	Sat, 28 Mar 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AufogAnt"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A23519A288
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774710442; cv=pass; b=ZwJzgpBeyiTvr5jYRjhasfeuMDnu8l/c1mOFHyag0409ZGY091zKIPwU+NNGtJS7K3JBGNIcq/RclhyzkMpb7S5n8ZDPNP4z99PGNb2XhLfBNFp7qlPwPFzCnN9G9py1GwJ6opEdMo+wLB5nKDQPW30ebL1R5TKRSQAeOIx5Cf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774710442; c=relaxed/simple;
	bh=+25HSy4Nh9sW/+Ht25CiiDC24+4BuXR+UDHKdcNctQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS3zfQFsRdbOQHlYDUQyVLDIiI5xgAtU0KCweYdcMyIfv6bniSHRGNP0FrlFokmxQhaXH8aN/aV6XybWQdXa/N/fpUr6q2k/tFUxbzEM4Pq3osBby7EuAKd089WRYat9WtoOIjg/Sw7VLG37qRT8t9ZmiDT+dhviFP8rCFvHOG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AufogAnt; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509062d829dso368961cf.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 08:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774710440; cv=none;
        d=google.com; s=arc-20240605;
        b=SydYqM2X7/oyv9Ys6LoSAeQz56d9m1sdhkyEGvDobFzI5msjYl+bonwH7uMPGTcvWM
         Dppfu0FmuDwXmjI8DSRUww9rbKs9ZktlwnMapaRIjzpQ1ICJAtcEn0GlaAEmemUFVPuL
         1tpuqI+tHCSDJn0+RpZCOixRJHZERaLguorJAIJJaI5AoRYonmeLkjhRFhza0FzkBC2Q
         zXVbx4YYrIspZOTmUhBYg6897ZpwUKyZzW8ahcD5x8aeHZFcveRKb7SHZT6H7iiURUOU
         7evaLEBNzBYeJI4V1cXhQYIUEJbUdptx4/2NIzT7i7OUbvfU3gwu7JOxV/52+MZIDXbO
         w81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MYSq0ecok7/Nk88ydJ03AyrQ9n3U+lTc9bL9MpdtneI=;
        fh=acYw3YaLcZOtDLKGsg5L3Kbw3YVDJxm5a+uITl/5YAk=;
        b=G4q7Eo4jcfz/Bi3bAmsadMQQ4hucdu0uSZeab4UD3x7GdwOxcd81SEwG8AchMoNH6F
         AZfz2TvvIz/BWWxIgT4UfXBdHBOseoS0GZRqvZpYoAwySsTO41bk6mGAA3qpeL3AZY3W
         SHqZtzrsRCB3GMiLRvQuZZn44AYAr95oO8ESFysSHHLWaBn7CeGHaVxPqbK3iYElRwQW
         oLuUG6jiQMI0s7xBQvrKzNjm8AJBqVnhfBaeBD9iCcTRjOzOqcmgyRoECYBns/rdJ2Vd
         VaILbu9F3lQj3dO0Pl/SHcbg79NPMX3BRq1vQI29Cpz3S2zDTlctvrkcznM8DvoirX0c
         egBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774710440; x=1775315240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYSq0ecok7/Nk88ydJ03AyrQ9n3U+lTc9bL9MpdtneI=;
        b=AufogAntoJsn4YGPdKXcvWacFH7pU4PcAXa+MoYfkCIaguhP3vqKCh/sPHy3td38WD
         byH3Xiz2vzG1wRKvZJ63aM6Jo2/nhgi5Pl+2OmKVaKzSx3vhCoPXOPdIRBqA1VfXxXPP
         HBuD64GIDBVmN2k//fTrYMiEbASBJN4WVcNSxPxdmJt60xPiimW0Sj6lUuJwZSv7d6Wb
         +a7u5TU1DU7QCsw2X44zzmCHi14fKD8vyVZnld63ib7PT+KgIigrA4657VRGb99NVQ1Z
         QZfjt0nwi+/dfDLH9euqKJ8dMxHl9I/zS5yA7rrDQWRmOYf6IgbnF8/kU5LCSysSutmX
         KjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774710440; x=1775315240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MYSq0ecok7/Nk88ydJ03AyrQ9n3U+lTc9bL9MpdtneI=;
        b=QE30oHUHqMaTXOv7mHsb/1IFFvONQVfu/qHQXrgwZjsj2VQobIi+udxk6jUWFMeqdG
         wfG35lz/xydlRe/8y7Y3gpSZYQ/uOkM1eKAAkc47YzdTSa+vpuTZfRTilGEf+CRsIsOn
         xyI3yOwx9LlMhc8eNmRNftD1gw0eHnnvWhFKdcju3YQAGBHreXPrEulBw6nxt0Bc0KiS
         ANU5iwcBw5uEwtgf+AiU/LTNf/W7szr7vVs0rlo4rhhJJU2H3nZSXAb+gvtWRtHBr3bc
         LzqUbKTkybn43nTKZ/GCYcfPvCmeUrm4hEODuypsQLU+CNtbe/u46hC0aBr/Ua0XXDqx
         RbCg==
X-Forwarded-Encrypted: i=1; AJvYcCWvBPc+juS5zchW0eBq9rPTrfnFhpdrfxoC3MCF63Nkb/ErhmWo8OCIS0lAhYGsXgxaDZcScs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycVlVSbJNKtLshaw7hAidZycgu6rCqhP7VURVfCnuBoMVNJUle
	60dDiiGfvkEOPbD6Nw4Fs2LSJ1nIKQ8McqTVzHECKK+6dwPFvW7Wl56o/069bvQSjrlILWgz+GW
	JuKOSOTJSBxqxg70/HgBxfxUWBxHMpMHNzIypElsg
X-Gm-Gg: ATEYQzyOZWyhU9ajuHXepymKlHeRib2USLyLjqegDi8IPhnAEk7pQi9B90s72zOF4Xg
	2Pz35XvMh0+bXVPZnQIfJcJZPc/4z/iNx8i2TcVkkNZpe242r0KLyxoGpNkT060yAgtbQJIXFFL
	i5tcDl8LgpUo15taaz3e5iz1miEUNiTW+SHolFBUqBB1ducj1X/fO3LLKhefcE/KrP5Yy+mOvqI
	IXugh7PQMOGuhSZ7wEUMT7Xzif4o54C30F276CmvzqaXpZj9qqvuXZRjvdrs2bN3CfUx5iq7FV6
	gPDFIwco76SQEJ18YyE=
X-Received: by 2002:a05:622a:1209:b0:4ff:cb72:7c03 with SMTP id
 d75a77b69052e-50bb3d40dd3mr8303251cf.3.1774710439333; Sat, 28 Mar 2026
 08:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324203851.4091193-1-guanyulin@google.com>
 <20260324203851.4091193-2-guanyulin@google.com> <bed5a8c0-2611-464a-bfd3-b00a8648727b@linux.intel.com>
In-Reply-To: <bed5a8c0-2611-464a-bfd3-b00a8648727b@linux.intel.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Sat, 28 Mar 2026 10:06:00 -0500
X-Gm-Features: AQROBzCwP314OdG765RsMY_jZphlo5IIejJb1-BR4VDw1M_2VFoPa4yRhQk-JsU
Message-ID: <CAOuDEK3dHL3mwjem__tqOCHOaNLa9joymncZNZBRh6py-HzUhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] usb: core: use dedicated spinlock for offload state
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, mathias.nyman@intel.com, perex@perex.cz, 
	tiwai@suse.com, quic_wcheng@quicinc.com, broonie@kernel.org, arnd@arndb.de, 
	xiaopei01@kylinos.cn, wesley.cheng@oss.qualcomm.com, hannelotta@gmail.com, 
	sakari.ailus@linux.intel.com, eadavis@qq.com, stern@rowland.harvard.edu, 
	amardeep.rai@intel.com, xu.yang_2@nxp.com, andriy.shevchenko@linux.intel.com, 
	nkapron@google.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230793-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,intel.com,perex.cz,suse.com,quicinc.com,kernel.org,arndb.de,kylinos.cn,oss.qualcomm.com,gmail.com,linux.intel.com,qq.com,rowland.harvard.edu,nxp.com,google.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A5BCD34EC92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 6:58=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> Hi
>
> On 3/24/26 22:38, Guan-Yu Lin wrote:
> > -     /*
> > -      * offload_usage could only be modified when the device is active=
, since
> > -      * it will alter the suspend flow of the device.
> > -      */
> > -     ret =3D usb_autoresume_device(udev);
> > -     if (ret < 0) {
> > -             usb_unlock_device(udev);
> > -             return ret;
> > +     spin_lock(&udev->offload_lock);
> > +
> > +     if (udev->offload_pm_locked) {
>
> Could we get rid of 'udev->offload_pm_locked' and 'usb_offload_set_pm_loc=
ked()'
> by calling a synchronous pm_runtime_get_sync() or pm_runtime_resume_and_g=
et()?
>
> This way we can ensure udev->offload_usage isn't modified mid runtime sus=
pend or
> resume as resume is guaranteed to have finished and suspend won't be call=
ed,
> at least not for the runtime case.
>

We previously considered manipulating runtime PM directly, but the
USB-specific runtime API (usb_autoresume_device()) necessitates
holding the device lock. Since holding this lock causes a deadlock
issue as reported, we implemented a check-and-return-error approach to
remain deadlock-free while staying consistent with USB locking
requirements.

The `offload_pm_locked` flag ensures that `offload_usage` remains
static throughout the system suspend/resume cycle. Because
modifications to usage counts directly impact the USB power management
flow, all updates must occur only when the device is fully active.

> > -     /*
> > -      * offload_usage could only be modified when the device is active=
, since
> > -      * it will alter the suspend flow of the device.
> > -      */
> > -     ret =3D usb_autoresume_device(udev);
> > -     if (ret < 0) {
> > -             usb_unlock_device(udev);
> > -             return ret;
> > +     spin_lock(&udev->offload_lock);
> > +
> > +     if (udev->offload_pm_locked) {
> > +             ret =3D -EAGAIN;
> > +             goto err;
>
>
> Ending up here is about unlucky timing, i.e. usb_offload_put() is called =
while
> device is pretending to suspend/resume. Result here is that udev->offload=
_usage is
> not decremented, and usb device won't properly suspend anymore even if de=
vice is
> no longer offloaded.
>

The current implementation requires the class driver to either handle
the error code properly or ensure the system is fully resumed from
system suspend before calling `usb_offload_get()/put()`.

If we use the idea from pm_runtime_put_sync(): "decremented usage
count in all cases, even if it returns an error code", this will lead
to usage_count changes during system suspend. The system might use
suspend logic with active USB offloaded devices system to suspend, but
uses logic without active offloaded devices since the usage count has
been changed during the suspend period. To avoid this, a
check-and-return-error approach is adapted here.

> >   bool usb_offload_check(struct usb_device *udev) __must_hold(&udev->de=
v->mutex)
> >   {
> >       struct usb_device *child;
> > -     bool active;
> > +     bool active =3D false;
> >       int port1;
> >
> > +     spin_lock(&udev->offload_lock);
> > +     if (udev->offload_usage)
> > +             active =3D true;
> > +     spin_unlock(&udev->offload_lock);
> > +> +  if (active)
> > +             return true;
>
> Not sure what the purpose of the spinlock is above
>

The spinlock was originally intended to prevent a race condition
between `usb_offload_get()/put()` and `usb_offload_check()`. However,
because `usb_offload_check()` is only invoked while
`offload_pm_locked` is set, the race is already resolved. I=E2=80=99m remov=
ing
the spinlock and updating the function description accordingly. Thanks
for identifying this.

> > +void usb_offload_set_pm_locked(struct usb_device *udev, bool locked)
> > +{
> > +     spin_lock(&udev->offload_lock);
> > +     udev->offload_pm_locked =3D locked;
> > +     spin_unlock(&udev->offload_lock);
> >
>
> spinlock usage unclear here as well
>
> Thanks
> Mathias
>

The spinlock ensures that `offload_usage` is modified only while
`offload_pm_locked` remains false. Without this synchronization,
`offload_pm_locked` could change during the execution of
`usb_offload_get()/put()`, leading to a race condition.

Regards,
Guan-Yu

