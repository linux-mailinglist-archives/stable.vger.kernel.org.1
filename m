Return-Path: <stable+bounces-242824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGe4ICnS92kBmgIAu9opvQ
	(envelope-from <stable+bounces-242824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 00:54:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC724B7BA8
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 00:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB150300F9ED
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 22:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83C3B6342;
	Sun,  3 May 2026 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b="NdcC3gzQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F061E3A75B9
	for <stable@vger.kernel.org>; Sun,  3 May 2026 22:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777848862; cv=pass; b=inlHFHiRSO1BoOEcS/23KXLm14Tm8f9t8IRNWiL9ZrfUmn4HqSSBfz7botQ93ewqCAnD+1Jwyz0UmtyQZG6m6il0saUVgtscX2wg1pos5Yk/GE+pgSe8vUMAmSPhdbKrNiNRYiw52TYH2ab++BAOOnxTIN9EstEimptVxIFvJ14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777848862; c=relaxed/simple;
	bh=HHUqSrSbpan1HpTwDObpiGld6DV6AUvdUllNygldI6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEas9F5dJ9rFrQdIV9DQyNujUYVciY8CxBMk/pL8jG/6JZV0RRRMOOb8oOzIHsYjp6HGvKIb9iNo0+giY/zzeQBv1yNGKWq+w3gk5vC3TAMFB/faFI3nqPbiHkQ9Zni/L1kWPoZ1dl+aKn/G0AFlC1YixMIPEYKaUAr0DvxEW1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com; spf=pass smtp.mailfrom=jphein.com; dkim=pass (2048-bit key) header.d=jphein.com header.i=@jphein.com header.b=NdcC3gzQ; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jphein.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jphein.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65890a6ca20so2903040d50.0
        for <stable@vger.kernel.org>; Sun, 03 May 2026 15:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777848860; cv=none;
        d=google.com; s=arc-20240605;
        b=b6EGWwjMFoYG07JaQ0Z+1sEx6/Y1cxv8eLE4MU9a9L7hoDp8FJqCONfH7kH2iu1w1m
         kUXM0EoRIQEuCUJ212QgXA2lU1+rEGarFo/X3gdCxfWhKZjPWLi5o85Ivpaex9Aq8BDM
         CHEnmLTopbWPbXpHbX30PbwCd/3N81XBWhqHgNG3mIvkkG94L01PHGKVI1NTaSYQqoqh
         DLfYi27bJQ+K8WlUT3YnvbLvnqK/iwOea6RxEQsDKgMuzZiu+erHgCZcmBN5DcaST56w
         tzt8sB373fAHwIyUY7Db6kukCndlqkeWYnvvNtoef4bwfRAuqy8BDCzHMLm9KyatPAYo
         ac8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HHUqSrSbpan1HpTwDObpiGld6DV6AUvdUllNygldI6s=;
        fh=eMhrlYf3lWj4bn7XCrT7Qk/ujdFA2LfWQOF3/JJUFkg=;
        b=M9Inkq+syX0dce0DJD1w5EuyzpANwfb1wzZyeppPhwZTL1Dev3doa1kts+k0lxCwXk
         D6r4HDVVWbojIwmnfOzL2Cl5XrWOmscDSE7ETWiqOwKKPFBUvaSv+P0PN7MryjCep49Z
         RBsGRY+6HPQm+kg2Wh5XUNhrQg6JXSbk0uIj6jAvs36H4UtaOv4BKiQrTp/7Y5/7JT51
         mEVycLXNwS3dWAFX7Ed4ICuLUiQ3ZvZxecBs48urnK2YijKaXThzzfCYqPiLUSGHRDnY
         nw9bSNZ6yi5qkqwjYwHyT/Xmq2wY7trGKsk/QQyH3mmLvLzC+jiK5EZf+nbYDl6h0e3b
         ly7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jphein.com; s=google; t=1777848860; x=1778453660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHUqSrSbpan1HpTwDObpiGld6DV6AUvdUllNygldI6s=;
        b=NdcC3gzQADkEdZyAJtOeJ+IVs6BMc4gGSL0sDMVyVTZ6oxQnk/oF7sWHTXo1Tf+Yi6
         U4bzRNXVRESDJBo1DFzPvc2IcOhwx3rX+vHueT5iYwdTaY8+XN2YO3kOBh8T6/6nfFM+
         nZqXsZQosBrlLpPqcv/HN532w4+ScpHKUIhpG5bXadLN8yKEYYmq2xtoY8Shq1o2FQ9N
         M3VzPvr7o5kK+PUEeB1I3LqXSy2/djlRhP80zAZ6pxxOB4ICfdbueF+UcY0Yl0ChkXhe
         Xy0z+Nc5PkF8aHkDkCFSiWGWwht0PZ8J1sZtQ5KOpIHtPL1KNruroUMbX5B6ALS5rWPH
         KDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777848860; x=1778453660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHUqSrSbpan1HpTwDObpiGld6DV6AUvdUllNygldI6s=;
        b=B4sLuDiTEmYAZXxa2a4ox5PNNIfCcJFxbWsJWU3NJpZ3yigo/RstkcrCF/mapnmulA
         A5QIVdLjjtdVOrKnrVTx2q7EDCkSa+XHmft/yLvpsuRRRyVI+9w6a5948oOLrEOiMXf+
         8lO8jhwR0F/ZENtMHrbimOVNRS7i0oM+8LfCceovP0D3kaFtNJ9LLONs5T12i0U+kxlL
         6a2GC1gzhKfkYAjDdA0qmRXfd8wz1ZttW8PBBQSMEyflGAFIexaYuqiOBxuTSLSbOrYl
         78GGRhsm0HuOGtMc85zyiTewIQE5cNoXAzq6OC6HVUSIF+sKwjD1A2FNPeip6TqjPLIT
         ++Tw==
X-Forwarded-Encrypted: i=1; AFNElJ+rfOxcZtmhDwq03XPnvIGXBXbnv+UIvjy2CagZ8r/LGDT1qsj1cM3wQRmj9L8yQbutUkIviQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjHThf27DYcgR5j4cw4PqUHqEHahbYvv0OcP9ZK2dlTYIwNJ+9
	x6o/fvP4dy3zebw7sOiwKtBu6bx53Zi3CzBOYB7yZL6/dgVyuvVU64+y2xuTlhROTuVfaz0KBIL
	u125RHY01hfjBiqP7G6/MsKPUd2aeUhNDXemIPda+
X-Gm-Gg: AeBDieuAq0SuDX9YT3HiZuTvyoKKyuNBkYcHlSwd40J0R6Jd8s7BNMm4aYc+ONRQ1I1
	pncBVuHQzUJ7HAn7VoijfV+D6lIBMl0Sym/bgmasVIwtamXXb8mclRrZBRJ6xFVbmi/LG+FBARQ
	+jq+76S6nf6SFFemHQ9fX8YcYbIz3+UGuZkMCxWm/slTIELq1myH774fZnxKGGrUbvqqYUmsRg7
	aNGBfaIZLBDU/tzz6Lp4Wk+9YY8hbHQmEmvTaneHtPG4HjE1nkjnCntHTW3wuXj2YHdTadc1cI8
	YlYnFDtN+A66gz6sYFyPmLuKKd0dnejrWqmOB7up97/DcoRZFahBjPVpZ41T7iyvSGy7eHImEHh
	t
X-Received: by 2002:a53:b426:0:b0:651:9720:744c with SMTP id
 956f58d0204a3-65c3dbeec96mr6188357d50.63.1777848859718; Sun, 03 May 2026
 15:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331003806.212565-1-jp@jphein.com> <20260331003806.212565-3-jp@jphein.com>
 <CANiDSCvsxP+npQTHUrMTp+Z8XULYKSLTz2AFu+WQnsLbRBGa2w@mail.gmail.com>
 <20260409100247.7cfb62d1.michal.pecio@gmail.com> <20260409221749.5e6bccab.michal.pecio@gmail.com>
 <c4275422-a9b4-4519-95f9-1163a7912709@linux.intel.com> <CAD5VvzCEV_XbHc_Gby7mFPBSgSebqKDKJf3VC8HNRrD+xWaTJg@mail.gmail.com>
 <20260413100545.71796c66.michal.pecio@gmail.com> <20260427083553.36ff4731.michal.pecio@gmail.com>
In-Reply-To: <20260427083553.36ff4731.michal.pecio@gmail.com>
From: Jeffrey Hein <jp@jphein.com>
Date: Sun, 3 May 2026 15:54:08 -0700
X-Gm-Features: AVHnY4LhPRw4XrdZjjt_olrWEaNJISf_JWRrz01TpDM2605apcllR8Yxymswj_U
Message-ID: <CAD5VvzBKvK3Z0HLoNx0VEbgyzQVq1CHwMKpCEpdC8zs8OowTNw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] media: uvcvideo: add UVC_QUIRK_CTRL_THROTTLE for
 fragile firmware
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>, Ricardo Ribalda <ribalda@chromium.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CEC724B7BA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[jphein.com,reject];
	R_DKIM_ALLOW(-0.20)[jphein.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242824-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp@jphein.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[jphein.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dmesg.post:url,jphein.com:dkim,jphein.com:url,mail.gmail.com:mid]

Hi Michal,

Both tests done. Intel xHCI 0000:00:14.0 (8086:a36d, Cannon Lake),
kernel 6.17.0-20-generic stock, stock uvcvideo. Two Razer Kiyo Pro
units (1532:0e05, fw 8.21) on root ports 2-1 and 2-2.

hammerint (2026-04-29): 60s per Kiyo. Kiyo 2-1 logged 413,738
submit/cancel cycles on EP 0x85 IN; Kiyo 2-2 logged 416,350. Both
timed out cleanly (rc 124 -- didn't kill the HC). Zero xhci_hc_died,
zero "event condition 198", no command timeouts in dmesg.

Caveat: usbcore.quirks=3D1532:0e05:k was on the cmdline that boot.
Hammerint runs the link at full throttle so it never gets idle enough
to attempt LPM transitions -- NO_LPM should be inert here -- but I can
re-run without quirks if you want a clean reading.

stream-mmap loop (2026-05-03): 300s per Kiyo, MJPG 1920x1080 @ 30fps,
no quirks on cmdline. Kiyo 2-1: 134 open-fmt-stream-close cycles on
/dev/video0. Kiyo 2-2: 92 on /dev/video2. Both clean, dmesg.post empty
of fatal patterns.

So Intel survives both reproducers in the windows tested. Doesn't
disprove your "looks like a HW bug" framing -- consistent with Intel's
xHCI ring tolerating the cancel/resubmit pattern that kills ASMedia.
The cascade path is silicon-dependent.

Note on scope: neither test exercises the rapid-SET_CUR pattern
(settings spam during a video call) that triggers the firmware lockup
in real-world use. That separate trigger does crash Intel --
stress-test-kiyo.sh hits hc_died around round ~25 on stock kernel --
and CTRL_THROTTLE in the patch series addresses it. So the patch
series argument doesn't change.

Side note: the same v4l2-ctl focus_absolute reproducer is reported on
Linux ARM (Pi), Windows, and macOS by another user (Razer Insider) --
supports the firmware-bug framing. Reffed in the v8 upstream report.

For v8: CTRL_THROTTLE addresses the trigger (rapid SET_CUR -> firmware
lockup), not the xHCI-side cascade. The xHCI side is your territory.

Forensics: https://github.com/jphein/kiyo-xhci-fix (raw run output
lives in gitignored results/ dirs locally; happy to send SUMMARY.log +
dmesg dumps off-list if useful).

JP

Jeffrey Pine Hein
Just plain helpful.
jphein.com =E2=98=80=EF=B8=8F techempower.org
(530) 798-4099




On Sun, Apr 26, 2026 at 11:36=E2=80=AFPM Michal Pecio <michal.pecio@gmail.c=
om> wrote:
>
> On Mon, 13 Apr 2026 10:05:45 +0200, Michal Pecio wrote:
> > Question: can you kill it by starting some video application to set
> > the camera up, closing it and then running this loop?
> >
> > while :; do v4l2-ctl -d /dev/video0 --stream-mmap --stream-count=3D1; d=
one
>
> Hi again,
>
> Any chance you could try it? And also the attached test program:
>
> cc -lusb-1.0 hammerint.c -o hammerint
> sudo ./hammerint 1532 0e05 0 85
>
> Initial arguments are VID:PID of the device, next is the number of
> an interface containing some interrupt endpoint and then the endpoint
> address (including 8_ if IN).
>
> I tried with a variety of SuperSpeed devices (UVC, NICs, hubs) and this
> reliably breaks ASMedia HCs within seconds. If the same is the case on
> Intel then it's a bigger problem than just UVC.
>
> The video streaming loop breaks even more controllers. I have some
> general idea how the streaming case could be dealt with, but not so
> much the interrupt one. Maybe rate limiting. I found that avoiding
> Set TR Dequeue to Link TRBs reduces failure rate, but not to zero.
>
> Long ago I also looked at the issued command sequences and I haven't
> noticed obvious errors or spec violations. Looks like a HW bug.
>
> Regards,
> Michal

