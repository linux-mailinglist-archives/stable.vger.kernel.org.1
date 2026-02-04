Return-Path: <stable+bounces-213359-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPFVCCkOg2k+hAMAu9opvQ
	(envelope-from <stable+bounces-213359-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 10:15:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D4E3A98
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 10:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CD51300614B
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009523A1E72;
	Wed,  4 Feb 2026 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAVLrAoc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771613A1E67
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196517; cv=pass; b=GSyTBxPmyrC80IuEecyZnfwm5pg8D8Ti7axEzNGrdXfUoEI2aiCQx3P15A34wNG9wlEDuX9+qHO1gu9qSrn0l4uMTJv2152NKkaVYEZ9WKeXEf2tYaZ8sefG2FF9QdWRT8mbfCn5GE8wUldqnwv/krMNTr9II/gIITGc/45PwEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196517; c=relaxed/simple;
	bh=wC2eOCM21PbEmwR8LFQmI9j4ZWCB3ZE8jYVykbZL3Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGIRw6dRg5Ayh4amLXVVy+/j8+kM7hBZf9+SDqIBtwBb5mkWdP4oIBzR+pVCSEYwcLZN3V2q/31+8ok7HR6Lb4HofP1BRN9gWmlXsYl7PLsnPNZyHQnopE9mfTJm+naH2g4WlUXgEAERkwipEsu1MNzuGqxCha1Lhcp4Mneg+Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAVLrAoc; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-505d3baf1a7so306151cf.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 01:15:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770196516; cv=none;
        d=google.com; s=arc-20240605;
        b=ij+qZRV7ns1MK9InaWb6cmJjgaynGYwlfgT+6YcAdUnFotNBz8J/oD6yPVX53fSPMJ
         lnmkVYYidXSCMqjZCbVqj88d8sZjVtQAovjYDxKfutaG4gQLBrLjSd3jelSKKOvtHeDT
         cmpBMUixySnUPj+XRhE/ynL00glAmSS/ICrHrdRpkxFftSj7qkvxPLSH4tr/WWNKOABg
         IyUi4SK3oytAAtZ14Ew5VmoCpTVSq3LfAdVkdpKRm9Em0MNGITSFTJq152towq/6n1ik
         /Xp+RPmHDlIM1YIepe+DeRpGYQDDYptGsaCPo0SIeNklknRkx/awve/cca14An//cN6B
         1ZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qtr/Rq5XW6imebDaN6PuW6KteYh03XamAZ/tTwSjOec=;
        fh=VWymZwXS70vHvP86acP/5SfDjSD/K8JMRG573isN5ZI=;
        b=Z+J2kNuSsNxyKAPiBeu+WyDCcQTuO7yx3HONJZHSi79L4oh9Ald5ngvEx1Z1GV/BQU
         gveOSi0epSYbVLKEhPfPDBGEtgGg3HegklaowadbP6QNbzS326oS1AMWvoeAoL7xVXD7
         iqJqp9sph2jwj7qce7X9awyiIfE9WfH9TLamcgHnkxOVqwCJNkaNAuaxxPlKt3he2o1L
         CpMZKcYdp1r44zQ5l0UeXf9HE7dOZuDhGdMMvxKNI3ZAv++ItCYHSamS8kgJgCu9DKVY
         h1WzK7ybNWatl7MZQIbVQoHylKE7J9NnlWggDg1wEDdO/ircsgTsMwvyODzGFm9vhlNB
         8nYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770196516; x=1770801316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qtr/Rq5XW6imebDaN6PuW6KteYh03XamAZ/tTwSjOec=;
        b=KAVLrAoc05FMKbXBLJlE4wgGhclqHSeP+nX5t+vggfjy1Jo8jRD1i53NDU5P29hDgQ
         gIzJY/4Zp+a/pXDSGbL2rHzriI6tE1l3QMVvYG7JSfncpKL+9nuFVQmcaut1fux7/Gbc
         XM8qvEPHtbfsBqJ/6IoeiC6VJqcle72oLvxG2l1QiJIB9b0Bs894f/KK7WmEeLNDSxRL
         m+tFZi7uvBQML9ZHOfpeB5/PkwB0TIp0waxy2GMmRU0zulVI7y2Y1uas4aWK6nVVqzEh
         uH2An8Uk4aVloPH9PSDeJQSUubStT4BCo7Sy8jFih3I6UX9wx9LSbV1WrFceJAzyBA1J
         xaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196516; x=1770801316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qtr/Rq5XW6imebDaN6PuW6KteYh03XamAZ/tTwSjOec=;
        b=TIGBBDR0dx5dZahfcDJHaFjqbMxSXayS0JGvYHGp/8K0ftzBCNop+Xj6UOPq99uyJd
         OQ28MtjrOdaKcnbbGIxb0l+4HEjOawkbuGu7oAOuPVsQUv1/FaWfh3WlMyjAnm1vr4+7
         YonZMxjjpKMV9T/31k27Zn2uTJpjw6lnMU8H29mLu40392P8mwoSfXE5mwcyoysRr7al
         hAydXBKb4azbFCgzcZWE8iMGUCXknAOG5ahbqqZfH90i9UT0qONQpC2Ea+WrzwJjLbZb
         lsHB7Iuf7x4XdnWAJ8L6HRthyIDr0DlEfHH6mxzcthsDpgcDIVnWt7q+sNVJH/tx8pWg
         Ao6g==
X-Forwarded-Encrypted: i=1; AJvYcCVYUqkJLYoJx0sT+2mHzkXym6SMXDoU2kaA+WyccHXMOuCBJBlyC6g3JpUwXUXzWEfEdjykmBY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc3pHyhMUfKIWtA64ozzqNF1epGBuuLmZaDWllE2leWNh9QzJW
	jPRa2jtNRp3q7heOnSmJ0pvL7E0KilglJcRE6do7RfvR/U+2UanJRak6pqnZtxSH0p3Z1Gdi/6z
	LwZxPrV2xFThsS6aFlfrv5suB68S671v74gal1Rjg3yHO72On4ldtTUID
X-Gm-Gg: AZuq6aJ1bEwcSSS9s2RyvHcQDsRsbOjhTz8tO9VAkvWazkkxUOIbBCzG3TXI5rCiIx2
	+yQADT8sEI52vLGODFLwA5sqxGcWyhRsuFRHy3hyYa9ahRfNB9LOkF+bpRWC7LHN4jfdk7dYZWc
	P6Wr61ivuCPdvfuiTCqjacES/sRwXi5mQke0QlYjbPZkrBLivDzMPGBy/6OHRKjIAlHIpN0Kj/Z
	tE8n+CATHZPpSdzB0t7o9xgN+dqZPu+IkrkRPTDiTyOA7xSIUE2POHNp+FifcR1nf8UsI+PwyfM
	EcjNRJ3w/RXXdXr3VSg8twGrxuz6D69L
X-Received: by 2002:a05:622a:1a8a:b0:501:19b9:42e9 with SMTP id
 d75a77b69052e-5061c3c660amr9915021cf.4.1770196516081; Wed, 04 Feb 2026
 01:15:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130074746.287750-1-guanyulin@google.com> <2026013133-tamale-massager-3c76@gregkh>
 <CAOuDEK0o2jqqOUZVUdi9JDcyXRQHEuL9GCBrU0VQhWAfDtJnUg@mail.gmail.com> <6acaaae2-4e93-46f5-8170-277bc369f922@linux.intel.com>
In-Reply-To: <6acaaae2-4e93-46f5-8170-277bc369f922@linux.intel.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Wed, 4 Feb 2026 17:15:00 +0800
X-Gm-Features: AZwV_QiZlT8utJE1tq9fy_MBQe3Qe0segFCNT9KB1NvH357aF9kf-41nbzR-ltU
Message-ID: <CAOuDEK3xzpY7Cr8JgactH=Sy=h7aTEgdTqUiuX8xh6gvUNR5uw@mail.gmail.com>
Subject: Re: [RFC PATCH] usb: host: xhci-sideband: fix deadlock in unregister path
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mathias.nyman@intel.com, 
	stern@rowland.harvard.edu, wesley.cheng@oss.qualcomm.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213359-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanyulin@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: A13D4E3A98
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 10:14=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 2/2/26 12:03, Guan-Yu Lin wrote:
> > On Sat, Jan 31, 2026 at 8:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> >>
> >> On Fri, Jan 30, 2026 at 07:47:46AM +0000, Guan-Yu Lin wrote:
> >>> When a USB device is disconnected or a driver is unbound, the USB cor=
e
> >>> invokes the driver's disconnect callback while holding the udev devic=
e
> >>> lock. If the driver calls xhci_sideband_unregister(), it eventually
> >>> reaches usb_offload_put(), which attempts to acquire the same udev
> >>> lock, resulting in a self-deadlock.
> >>>
> >>> Introduce lockless variants __usb_offload_get() and __usb_offload_put=
()
> >>> to allow modifying the offload usage count when the device lock is
> >>> already held. These helpers use device_lock_assert() to ensure caller=
s
> >>> meet the locking requirements.
> >>
> >> Ugh.  Didn't I warn about this when the original functions were added?
> >>
> >> Adding functions with __ is a mess, please make these names, if you
> >> _REALLY_ need them, obvious that this is a no lock function.
> >>
> >> And now that you added the lockless functions, are there any in-kernel
> >> users of the locked versions?  At a quick glance I didn't see them, di=
d
> >> I miss it somewhere?
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> > Hi Greg,
> >
> > You are right; xhci-sideband.c is the only in-kernel user of the
> > locked versions. I will rename the __ functions to usb_offload_* and
> > remove the locked variants in the next version to clean up the API.
> >
> > Regarding the deadlock fix itself, we have analyzed two potential
> > solutions. The core issue is that xhci_sideband_unregister() (and
> > xhci_sideband_remove_interrupter()) needs to decrement the offload
> > usage count (which requires the USB device lock), but it is called
> > from the disconnect path where that lock is already held.
> >
> > Option A: Fix the Callers of xhci_sideband functions
> > In this approach, we keep the usb_offload calls inside the
> > xhci_sideband functions but replace the internal usb_lock_device()
> > with device_lock_assert(). We then update callers in
> > qc_audio_offload.c to explicitly acquire the lock.
> > This ensures the offload count remains tightly coupled with the
> > interrupter's lifecycle, though it effectively changes the API
> > contract: calling xHCI sideband functions now requires holding the USB
> > device lock.
> >
> > Option B: Decouple usb_offload functions from xhci_sideband functions
> > In this approach, we strip the usb_offload calls out of xhci_sideband
> > functions entirely. The client driver (qc_audio_offload) becomes
> > responsible for the full transaction: acquiring the lock, managing
> > usb_offload_get/put(), and creating/removing the interrupter. This
> > restores clean encapsulation (xHCI functions only handle hardware),
> > but it places the burden on the client driver to correctly balance the
> > usb_offload calls.
> >
> > I lean towards Option A to ensure the offload count implies an active
> > interrupter by design, but please let me know if you prefer the
> > cleaner separation of Option B.
>
> I would prefer option B
> Decouple the offload from sideband.
>
> The secondary interrupter in sideband was specifically createad for
> qc_audio_offload.
>
> Vendors using the xHCI hardware Audio sideband Capability (xHCI 7.9)
> won't use a secondary interrupter, but might sill want to prevent suspend=
ing
> the device. So it shuold be better to make this decision in the class dri=
ver.
>
> The offload count shoudn't be that complicated. Isn't it binary at the mo=
ment?
> We don't allow more than one sideband per device, and it can only have on=
e
> interrupter.
>
> I unfortunately couldn't participate in the review and development of
> drivers/usb/core/offload.c, but my original idea before it was implemente=
d
> was to keep usb core out of sideband as much as possible as its not reall=
y
> a part of usb specification.
>
> This is also why I added the sideband pointer to struct xhci_virt_device.
> It allows us to figure out if a device is dedicated for sideband use.
>
> so xhci_sideband_check() could be something like
>
> bool xhci_sideband_check(struct xhci_hcd *xhci)
> {
>         guard(spinlock_irqsave)(&xhci->lock);
>
>         for (int i =3D 1; i < HC_MAX_SLOTS; i++) {
>         if (xhci->devs[i] && xhci->devs[i]->sideband)
>                 return true;
>         }
>         return false;
> }
>
> Thanks
> Mathias

Hi Mathias,

Thanks for the feedback.
I will proceed with Option B as you suggested. Decoupling the offload
logic from the sideband mechanism seems cleaner and places the
responsibility correctly on the class driver (qc_audio_offload) to
manage the offload state.

I will implement the following changes in v2:
1. API Cleanup: As Greg requested, I will rename __usb_offload_* to
usb_offload_* and remove the locked variants. These functions will use
device_lock_assert() to ensure the caller holds the lock.
2. Class Driver Logic: qc_audio_offload will handle locking udev and
calling usb_offload_get/put() directly.

Regarding xhci_sideband_check():
I have a concern regarding power management with the proposed check:

if (xhci->devs[i] && xhci->devs[i]->sideband)
        return true;

vdev->sideband is assigned during xhci_sideband_register(), which
happens when the class driver probes (device connection), and it
persists until disconnect. If we use this check, the xHCI controller
will be prevented from PM suspending (system suspend) as long as the
device is connected, even if it is idle (not playing audio).
For mobile power optimization, we need to allow the controller to
suspend when the sideband is registered but idle.

Since we are proceeding with Option B, the class driver will be
maintaining the udev->offload_usage count via usb_offload_get/put(). I
propose we still rely on usb_offload_check() (or check offload_usage)
within the xHCI sideband check. This ensures we only block or adjust
the PM suspend flow only when there is active data transfer.

Regards,
Guan-Yu

