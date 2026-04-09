Return-Path: <stable+bounces-235479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C5zIg7v12kbUwgAu9opvQ
	(envelope-from <stable+bounces-235479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:25:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 495233CEA91
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 20:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0F8430269D7
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87103E1D0C;
	Thu,  9 Apr 2026 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzLxomTq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F82472A6
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759114; cv=pass; b=mCQ6I5M1W951BmG4LwHHeHEE697qVFQNiPuIrzVgi54aTHvuxZhgXw9qFii8Qt6dCPp2C+1TPCaB45U6C204Gn3a2wdg4qLB3RPFfwh6qV6HdGRhZG7jYOj71NnPWcZwwDcW4Ssi6tKhIDOUqXPehbnY0ToQH0Xiewk9WpkO1po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759114; c=relaxed/simple;
	bh=uRIpHIXY1Jgv/tUqLrduouxc+mc9S9SHsVuyZmzj/QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbNMKsX14X3BWeYDyBvnYGJ/+v3QrgD9gOhXU04cngbUcgrM08urWeSAZ0XvKH4xs5HcsU7ZWT/Qc3AmtveWinjcKTrmhFP7gCht6ZYsXaxi7OA9Vvy90hfnzL8GyB0YtLDkdg+JO00QxtCn/NWgt+dfFYqLRq8Q2oScC5/RuGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzLxomTq; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66fb5f2183fso2066210a12.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 11:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775759111; cv=none;
        d=google.com; s=arc-20240605;
        b=JVBmdsV7fmZVAwyu/Wi69uWqo9DqH2x9cTN4Jj5jd2ul1tuIG/Ku7FtufNvNFB7B66
         HrcZ0qsy/gBVFB4hZyVNpNMKH65CEk26rwfTzeO/Eq0TcjuqxSHIRY+yFOAtnFxNXVCn
         YzEIHKAuzNzEzuTRqKwwEJI6SGYew0kAVkA8TKztkwT0uOR6cLSmGXGjyIHeI0cjeJEh
         LUVDxJUrZPgPMIN+Id5T55w7njHII1lKGeUatadgwBwsPPjKZo93QMjboo4qY574tYWD
         mpj28a5JJ7yHoHliqU9LtdwK9vESWtMNfWfWLrv/0jPVsETO/3O/WY3CT+SQJYgt8kKL
         FqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        fh=KyYrfeO/kAZtCyKsHQT0L/nL5K/5r1bDoD4FF9olD3k=;
        b=kaARIFh2PkGpDEy+mh8NJRglJkJdxIx/0OcJM/WkbVZQizjLYdd0VcS9Bw3pvkHHwH
         FSzxdDUpezqcjrgQbAaa3gEABKGX7D1/3dTIgQETIBDb9yKt4vAHwCKEE4sx8H2yndcC
         HxusUJHGt3Vqc48fkGmOP1ar0CbOrqf5te3rDUfCzH9pUfxbcAXJXj4PNsnOs2RkfLiY
         EojALOmQxBCyQN1frW/VBMuC5361CbbC0B3uranvmfCnzLlSidHL1UEGzzWrSG4Y9Grn
         A0m34SnNmCpfU/nSSES43Le4aYl2lWvln9biHcXM1XK202d5y1fA5gYibG1m9eOtvbUZ
         L0aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775759111; x=1776363911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        b=LzLxomTqu3hI303cqh2kQu4o2QnX1b75nZh+6sCJ14WZQWRlau3rNtsEsjvR8ReWl4
         P5xC3YMB1IhHq1kdyBqUhi2nCBOXRxuHWNcvMIXZyADz281HJsOEBMIAhEbVLPuXaj7J
         ndczERAsnqnzXca/SLqO1WOQjw4VQ/7YKEkd22YnM6sYbeRUXQaUnNyqN0w7Lcn2ONgO
         9Opx+SCMutnon9umjt7iexP3KFc5RVv8ATMueCPD8aQA7XrarOswzjrs1YW9Uqa7YAFb
         Pf5B0nrRwGHlRmvI0+M/4f8iueNgVYY+xRf+APnq7COAdYqymyaDyL+0WTbNtiDuuvu8
         JF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759111; x=1776363911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        b=dkueQSzZoen8/gvfizzTWzJj0s+uRIfno624eZRkiwdFU34y21KJvdFR2QQwguWezS
         SAqqidF9sI2I7Obb1WNYM9hDVzulWqMreBqb7VneGP/lfUAxyFMsOdM+cgHHKodmlSvA
         7vLlaHJW0N8sMqUd1JPvB6396UwwHSiDmRrbTMmT0AnPDgJhuGXC1VVnpWK8HrthSu+Z
         hsG/vSqgE8SmJw62avc1mmpcALjJSwxu6Z2+UROgEX9rymm1GAMVgV2xHEHixp+phkUR
         WmeO2x2Uss21Gsnqg6YnYrRB95pZjKQV08YgW5Q65EeiZBaO5kq9WUSqyQ6LwNRCJCGf
         luLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLa6+Li3I6twPD+0CH2MRkqzJD5YvoFXt+iGJO7q3ic/GmM8rrflddDNMgGHsL92jUaOMTWP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5IepZdsVPJL7Z7NSd/bu6qGUEJ3/Qj6toYlK5MTyLuRNJQVFc
	4q/7yvbiPo1TNhgFTV5GL2cTQcIvnaZu8HNPTr2JtQfBeBxWB5XqnXMp0//T5XZXhO/LY0gN4jX
	W9YFB8TW6QkFxj7ARt6TMySycfXHdotE=
X-Gm-Gg: AeBDieuu1a0SYTosv2dFxSqRCRs9oV+efpcw52cMYPHlMtiBV3L2o4JcxwCZB8HoDbr
	ss4675npHM7FkPCealM3gs5e5E7Q8c8jcsWXX2Yt7Za1u3G72Gcvn9iBH/9c4cNzm/wnS3jZkhO
	TjB+R0yKRfrWLqo196omuP/2JO2qY/w0oObGxmdMBUzaxKfc0VTJjuW+7RuhPf6MeNRTpHA5pzd
	+jLKPuPXtW0hrw8YDbae3g818SKKrJ5AvTCR/kAYdynIoKxrdQrzc/HELrmMk/Q3Zt+6PmOyYKr
	lbjRlKs=
X-Received: by 2002:a05:6402:358e:b0:66e:f4c0:c348 with SMTP id
 4fb4d7f45d1cf-66ef4c0c5a1mr8652002a12.7.1775759110757; Thu, 09 Apr 2026
 11:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
 <20260324201858.46591-1-sebasjosue84@gmail.com> <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
In-Reply-To: <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Thu, 9 Apr 2026 21:24:59 +0300
X-Gm-Features: AQROBzD5ryy57P3iGUvqLsmBCdxSK-kLXMP5Y7ZvC8lV482_vL8uUBuQIdBTpOA
Message-ID: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
To: Jiri Kosina <jikos@kernel.org>
Cc: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235479-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelzaidman@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 495233CEA91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 6:50=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
>
> On Tue, 24 Mar 2026, Sebastian Josue Alba Vives wrote:
>
> > ft260_raw_event() casts the raw data buffer to a
> > ft260_i2c_input_report struct and accesses its fields without
> > validating the size parameter. Since __hid_input_report() invokes
> > the driver's raw_event callback before hid_report_raw_event()
> > performs its own report-size validation, a device sending a
> > truncated HID report can cause out-of-bounds heap reads.
> >
> > Additionally, even with a full-sized report, a corrupted
> > xfer->length field can cause memcpy to read beyond the report
> > buffer. The existing check only validates against the destination
> > buffer size, not the source data available in the report.
> >
> > Add two checks: reject reports shorter than FT260_REPORT_MAX_LENGTH,
> > and verify that xfer->length does not exceed the actual data
> > available in the report. Log warnings to aid debugging.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> > ---
> >  drivers/hid/hid-ft260.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> > index 333341e80..68008a423 100644
> > --- a/drivers/hid/hid-ft260.c
> > +++ b/drivers/hid/hid-ft260.c
> > @@ -1068,6 +1068,17 @@ static int ft260_raw_event(struct hid_device *hd=
ev, struct hid_report *report,
> >       struct ft260_device *dev =3D hid_get_drvdata(hdev);
> >       struct ft260_i2c_input_report *xfer =3D (void *)data;
> >
> > +     if (size < FT260_REPORT_MAX_LENGTH) {
> > +             hid_warn(hdev, "short report: %d\n", size);
> > +             return 0;
>
> Michael, can you please confirm whether the device can never legitimately
> send shorter than FT260_REPORT_MAX_LENGTH reports?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

The FT260 uses different report IDs (0xD0 through 0xDE) for different paylo=
ad
lengths, with each report ID defining a different report size in the HID
descriptor. So yes, the device can legitimately send reports shorter than
FT260_REPORT_MAX_LENGTH, and a blanket size < 64 check would break valid
short transfers.

Looking at __hid_input_report(), the HID core could validate size against
hid_compute_report_size(report) before the raw_event call - essentially
moving the check that hid_report_raw_event() already does to happen earlier=
.
That would handle truncated reports generically for all HID drivers. Howeve=
r,
such a change would affect all HID drivers and require broad testing, so th=
at
is your call.

What the HID core cannot validate is driver-specific payload semantics. In
ft260, the I2C input report has a length field at byte 1 that indicates the
payload size, and the driver uses it as the memcpy length without checking
it against the actual report size or against the expected data capacity for
the specific report ID.

I will submit a per-driver fix with two checks, both essential:
First, a minimum size check before accessing any header fields. Currently,
the HID core does not validate report size before calling raw_event, so a
1-byte report would cause an OOB read just from accessing the length field
at byte 1. This check is necessary regardless of the second check.

Second, a validation of xfer->length against the expected data capacity for
the given report ID. Each I2C input report ID defines a specific data capac=
ity
(report 0xD0 holds up to 4 bytes, 0xDE up to 60 bytes). A corrupted length
field exceeding this capacity would cause an OOB read from the source buffe=
r
during memcpy, even if the report itself is full-sized. Only the driver kno=
ws
these per-report-ID limits.

I have the hardware to test this change. I will credit Sebastian with
Reported-by for identifying the issue.

Thanks,
Michael

