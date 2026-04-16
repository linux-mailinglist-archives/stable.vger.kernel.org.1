Return-Path: <stable+bounces-238321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMxQN5b24GmInwAAu9opvQ
	(envelope-from <stable+bounces-238321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:47:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295C40FC05
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC5F3071C77
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 14:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757453E120D;
	Thu, 16 Apr 2026 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="avVS49ZM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kBKn6vB3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51DC2045AD
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350809; cv=pass; b=Zil0oJHHrO7uPjuGQARWzLImkawteNAfQ4VNs+ebJTDeebMPQZmFdKHHyWlSAA4WKyOVV3YMNmGTX+D9YvZ64NBZC2nzzte2sDMBODdNvDWB72UQ+Eyl/oxHWEv5HJSXRuiuc71i1YegcHHXmvhBx9+0cxcHhfK1pi2VizEWBlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350809; c=relaxed/simple;
	bh=DZCLn5MJ4r3soQbNgHCA3buradW5el48yuJ9ZXDcTfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRz76x5q1cGbrE7mI7Hdc5/d/mHw0lyaeSjxciC522zaBCFZifb/1eUhEjbTjhyQoyBpoEVlN2yme/Iww+aXqfBlUDgbnc2s1dOdnngPUtcR0S5st06U7AW5bfDocIcmyHaqg0NWM308WPeMUCeJBSkDVF9aqM6Gquk72FwZL3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=avVS49ZM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kBKn6vB3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776350806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdVxqyAXKoeqrj2cGnO5r3z+/z3A0QdARs5q1LcXUQY=;
	b=avVS49ZMor1aD6oEOUF7tG9PmHNKqNPr5ZwmbWK/fzfUr+UPnOnQb3eUIneGiHi4nwEEHU
	IwcxvEohgQbR58i4xFBenAyDzXMk99vE6HDvNU1mtQHC/hbIqhH5ezaMeIvqoKYvw3ySrP
	x1772wAFt095IKTRJS8KDAaPkdCgG/c=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-HsLHM3zlMmW-ZIHx4QhI9A-1; Thu, 16 Apr 2026 10:46:45 -0400
X-MC-Unique: HsLHM3zlMmW-ZIHx4QhI9A-1
X-Mimecast-MFC-AGG-ID: HsLHM3zlMmW-ZIHx4QhI9A_1776350804
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-358e425c261so8677133a91.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 07:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776350804; cv=none;
        d=google.com; s=arc-20240605;
        b=HApRhLrbewO5EvJC0Rb1LddK8iUA3w/EwJ6gBya1Be+Gs4dtJod5v+iyK3FSR5NUvF
         AqEZ8KUWl/e/f5HJnr/UVw+sJ7V/XSJt/JA016V5uQXPcCf+tBIPBjVJ6iB1+vYuvBgc
         IQ+MstseDRrk1VQVFS5c1qL5GhXvRdMLbk9WaCUO7hHYa8R0hDhirQasN3kIOXOgfMmP
         Eo9eKR/g2kxSi+TZPGWE92ht37wdkrZQn+N5dFRv3yZ63IDyCsjvp5MGKxzpYiHJuaoa
         ptxJkWttrlrP9pPcOKD1UPm8lmYmoSPR0h5FYgMtphJaYZSZES8rFTsOJGGei34UE0N/
         oIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QdVxqyAXKoeqrj2cGnO5r3z+/z3A0QdARs5q1LcXUQY=;
        fh=U14dtRW1tMh7+BhhjBmkKi+H9EgXXqPkIWSVU5UOEhA=;
        b=Zih6oLu1AxIjpYk1yhuHrbuvbrWpFXRu20V9aLvoBF8Nn1Z9Kp4+6nWODWAIOQVOxI
         5W/x3NxyaQgOvscqSMXDhcMdThGjhNJicc9i7rBFBKI13Z8/SKz1Nz9mt6LGh62J9ELx
         kRCy5ZFWW8D5wKW+mVAC479PnVR5rVfqI3TbYX0AWDl3LqJekPUNj4Oe1SOoWPzDcuvO
         VG0Bud3ar97+2T2mjqbb6Jb1BGtWNgFzpAzc2pIqUVZLQUVBNp0Az8sP8WB23XHYu1Kr
         8e1xion9BvGCOfsaXApo6HQqIJmNkrL44W4oGgE1FhEqkM4mwcNleRFPxnBTvUrIHMIm
         OcXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776350804; x=1776955604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdVxqyAXKoeqrj2cGnO5r3z+/z3A0QdARs5q1LcXUQY=;
        b=kBKn6vB3BtmaV4xRfMOSDUubFfkj5/Zd+Xnl23CqpXQo2ZJCuPCArjNTXId8/SeQOa
         TPGNmOZAMzFQ6VEN3iXc0yzs/P52Zat+3ABcYe93mDR3GtxalYQyX6JKr7mA2Sx3wwjd
         KfUFbkyHveSOfNyktw+Cj8qEfMkf2DXI9kqK8vHsrYFphvfJUxA/3xs3OoE9Hf0z23dU
         dQJMyls42Snq+M1lzCNZvfBmXfjQ5lrc1QU3YJ38dZ4Sfw+XL7qoByaHyHkbQCz62UNi
         cSDn9StuoYBgdMLFe/gO3TuOktgp5jUFNlR4cpNRqtHrG6XquE9fjumZnrGqnqgmUTke
         DIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350804; x=1776955604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QdVxqyAXKoeqrj2cGnO5r3z+/z3A0QdARs5q1LcXUQY=;
        b=F0BDyLrSnpZTFrSuL+/JuFkc2gi3EAjs9Y1eHPJYlqb+JFpohcJ377Dp5Rde4jQnV+
         NMEUpHiAr4wxhVV9LY+0jVd4LaL6x76hVGC3Yw0sdL5o2Y7s9GKuB+0OveB7hzBHVqrc
         +Sa3IHpqnwp3DdVyKUl1cgxHCMu6vS1l6O1XL242FesdOw+YWIwdKsMOup3zktNSwmdK
         AOF1lr6LyF6Uhe0yydUb0FIehUbuK19rB8uocE+7faKRypCAVMPCWR+MtB8TrtFSnZR4
         LRe4nAtHiZaTBGIPy7I1NO5gJGIH3k/PWRFrUTy6k6VI6OiwOfZPqWALNjsLZyPFYdT7
         IZXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8nXk5NkUYGDZ/oAz5TrXarg5MesVBpooh25FMup6AOzvenr1cnpNRN12QBX9UEDrdcBgNJvTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9tvhGbToQ184tC/5pB29JP0ZR6PGXVj17Y1mfcItDf/Uf7EhU
	Svn+v9nL2r1re1knU+AJ7wI/kNhySxqKdYg4HwPHfw49kX8HhkBAkDqwbZ1PUr2ZrBIVNysDEUw
	axkFBzG/4nDTCO5EqslEaVuuZoJkVuzL/WSSDEshAL4pSc6iVbuZitebX6pP/ELt44hDLSklBEx
	b9Trb9Zr7hfjizJICGXCsU8HNuCt626pR+
X-Gm-Gg: AeBDiev/Q4Xas1udhddMOs7Eju20EzxUDEOk2Tt5pp9uS3QWsjek13A7QolhYAIj9Nt
	FFo2b8OyJf356ytNFLrrLjb1ghe8drpHNWdQuGnED+oaeWVmZ/queN52OCSTpzR7N/IDBykTLaS
	YFt+spqtBg4Egqg6DO6DOSmyzYvMbgH7bSIsrzGsSZHV/7EOiSNWOC2ILAto4wz1p4KRkiXLNHH
	qw=
X-Received: by 2002:a05:6a20:4312:b0:398:8d38:c60c with SMTP id adf61e73a8af0-39fe40aac53mr28231780637.55.1776350803573;
        Thu, 16 Apr 2026 07:46:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:4312:b0:398:8d38:c60c with SMTP id
 adf61e73a8af0-39fe40aac53mr28231742637.55.1776350803080; Thu, 16 Apr 2026
 07:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org>
 <20260415-wip-fix-core-v1-2-ed3c4c823175@kernel.org> <8fedad8e9caecd379f2296562cd6abd37f7cee46.camel@hadess.net>
In-Reply-To: <8fedad8e9caecd379f2296562cd6abd37f7cee46.camel@hadess.net>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 16 Apr 2026 16:46:28 +0200
X-Gm-Features: AQROBzD-vVFl_065x6nZIK1IjlDiUy9P4QSkjgjIaaL4c8szdqTSf21JUcEoXr8
Message-ID: <CAO-hwJ+EgC0pM6L6vGFEaRFt2Nwj5b-CCf_5e5VkvrXgdHrjNg@mail.gmail.com>
Subject: Re: [PATCH 2/4] HID: core: introduce hid_safe_input_report()
To: Bastien Nocera <hadess@hadess.net>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238321-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.tissoires@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,hadess.net:email]
X-Rspamd-Queue-Id: 8295C40FC05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 11:41=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Wed, 2026-04-15 at 11:38 +0200, Benjamin Tissoires wrote:
> > hid_input_report() is used in too many places to have a commit that
> > doesn't cross subsystem borders. Instead of changing the API,
> > introduce
> > a new one when things matters in the transport layers:
> > - usbhid
> > - i2chid
> >
> > This effectively revert to the old behavior for those two transport
> > layers.
> >
> > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> > bogus memset()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  drivers/hid/hid-core.c             | 21 +++++++++++++++++++++
> >  drivers/hid/i2c-hid/i2c-hid-core.c |  7 ++++---
> >  drivers/hid/usbhid/hid-core.c      | 11 ++++++-----
> >  include/linux/hid.h                |  2 ++
> >  4 files changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index a806820df7e5..cb0ad99e7a0a 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2191,6 +2191,27 @@ int hid_input_report(struct hid_device *hid,
> > enum hid_report_type type, u8 *data
> >  }
> >  EXPORT_SYMBOL_GPL(hid_input_report);
> >
> > +/**
> > + * hid_safe_input_report - report data from lower layer (usb, bt...)
> > + *
> > + * @hid: hid device
> > + * @type: HID report type (HID_*_REPORT)
> > + * @data: report contents
> > + * @bufsize: allocated size of the data buffer
> > + * @size: useful size of data parameter
> > + * @interrupt: distinguish between interrupt and control transfers
> > + *
> > + * This is data entry for lower layers.
>
> You probably want to explain why it should be used instead of
> hid_input_report() in this doc blurb, and modify the hid_input_report()
> docs to mention that this should be used.

Good point. Sending v2 ASAP.

>
> Maybe hid_input_report() should also be marked as deprecated somehow,
> to avoid new users?

Well, it's not entirely deprecated because, for instance, in uhid we
only have the buffer with the provided size around. So we can't be
less restrictive in that precise case, and then switching to _safe
will not change a bit.

Cheers,
Benjamin

>
> Cheers
>
> > + */
> > +int hid_safe_input_report(struct hid_device *hid, enum
> > hid_report_type type, u8 *data,
> > +                       size_t bufsize, u32 size, int interrupt)
> > +{
> > +     return __hid_input_report(hid, type, data, bufsize, size,
> > interrupt, 0,
> > +                               false, /* from_bpf */
> > +                               false /* lock_already_taken */);
> > +}
> > +EXPORT_SYMBOL_GPL(hid_safe_input_report);
> > +
> >  bool hid_match_one_id(const struct hid_device *hdev,
> >                     const struct hid_device_id *id)
> >  {
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-
> > hid/i2c-hid-core.c
> > index 5a183af3d5c6..e0a302544cef 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> > @@ -574,9 +574,10 @@ static void i2c_hid_get_input(struct i2c_hid
> > *ihid)
> >               if (ihid->hid->group !=3D HID_GROUP_RMI)
> >                       pm_wakeup_event(&ihid->client->dev, 0);
> >
> > -             hid_input_report(ihid->hid, HID_INPUT_REPORT,
> > -                             ihid->inbuf + sizeof(__le16),
> > -                             ret_size - sizeof(__le16), 1);
> > +             hid_safe_input_report(ihid->hid, HID_INPUT_REPORT,
> > +                                   ihid->inbuf + sizeof(__le16),
> > +                                   ihid->bufsize -
> > sizeof(__le16),
> > +                                   ret_size - sizeof(__le16), 1);
> >       }
> >
> >       return;
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-
> > core.c
> > index fbbfc0f60829..5af93b9b1fb5 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -283,9 +283,9 @@ static void hid_irq_in(struct urb *urb)
> >                       break;
> >               usbhid_mark_busy(usbhid);
> >               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
> > -                     hid_input_report(urb->context,
> > HID_INPUT_REPORT,
> > -                                      urb->transfer_buffer,
> > -                                      urb->actual_length, 1);
> > +                     hid_safe_input_report(urb->context,
> > HID_INPUT_REPORT,
> > +                                           urb->transfer_buffer,
> > urb->transfer_buffer_length,
> > +                                           urb->actual_length,
> > 1);
> >                       /*
> >                        * autosuspend refused while keys are
> > pressed
> >                        * because most keyboards don't wake up when
> > @@ -482,9 +482,10 @@ static void hid_ctrl(struct urb *urb)
> >       switch (status) {
> >       case 0:                 /* success */
> >               if (usbhid->ctrl[usbhid->ctrltail].dir =3D=3D
> > USB_DIR_IN)
> > -                     hid_input_report(urb->context,
> > +                     hid_safe_input_report(urb->context,
> >                               usbhid->ctrl[usbhid-
> > >ctrltail].report->type,
> > -                             urb->transfer_buffer, urb-
> > >actual_length, 0);
> > +                             urb->transfer_buffer, urb-
> > >transfer_buffer_length,
> > +                             urb->actual_length, 0);
> >               break;
> >       case -ESHUTDOWN:        /* unplug */
> >               unplug =3D 1;
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index ac432a2ef415..bfb9859f391e 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -1030,6 +1030,8 @@ struct hid_field *hid_find_field(struct
> > hid_device *hdev, unsigned int report_ty
> >  int hid_set_field(struct hid_field *, unsigned, __s32);
> >  int hid_input_report(struct hid_device *hid, enum hid_report_type
> > type, u8 *data, u32 size,
> >                    int interrupt);
> > +int hid_safe_input_report(struct hid_device *hid, enum
> > hid_report_type type, u8 *data,
> > +                       size_t bufsize, u32 size, int interrupt);
> >  struct hid_field *hidinput_get_led_field(struct hid_device *hid);
> >  unsigned int hidinput_count_leds(struct hid_device *hid);
> >  __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16
> > code);
>


