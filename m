Return-Path: <stable+bounces-254155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIgYCh1eFGqgMwcAu9opvQ
	(envelope-from <stable+bounces-254155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:35:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D8A5CBC93
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DF91300F10F
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2F9248F64;
	Mon, 25 May 2026 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAGj16pi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B471DF26E
	for <stable@vger.kernel.org>; Mon, 25 May 2026 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719706; cv=pass; b=PkAaQVBryOVRajc5P5pgNKxoJCidMdmQ5Oj373EIEOMvwnF+qNeBsDDq1hxYTU9XCXTJn4CUKPZSzi/eI5KJFWJKEKeyAu8W8BVB3BFB4dtm9INmDT+Eb1b8kj5DzoIS6SFPmCzJAYEHfzHLqWZOu+8UM5vdOfpzYiW/CedhiUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719706; c=relaxed/simple;
	bh=pe+FUR5NMnEZtuIJXRudZq21vxQtju/HXUgJ/nhF0YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFeUOSOMRHWG8t03rw4weDh0BEghxZSLMJzm5RCqtX57ScN9z10zWPSWbRvAUS0Csq+slunBp/r1R7cM7T+M2JMbQ7/jGKmjtjxzvlm+BnimMmiXTx2g5VNaR9XX3ZuX0qpquM7VQht4qSunbeV6QgGrmsVB8O16cdxhpF1uTbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAGj16pi; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7de7dc85b74so9350431a34.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 07:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779719703; cv=none;
        d=google.com; s=arc-20240605;
        b=M8wx3hLQu5wQnOpIfCcXkjDg5leQuwLX0otUm3PBEKQ/ixbFLpyOZ5zdq6hpkzQj9Z
         0zQMdZFGPyb4TtbeIU3fZ1h6qs2PNAvqJH+eHB2nTJqEMV9yIha3xnPtc7XdUxmznEAt
         KMFznkP43pBlev1KT0JPvhKt7czpRWDYSXAy8l5X3N1n4SnnjxHGGTK1k9W8q85llEcP
         PidjM+JEMJ/4ZKFB+uYL8IrtfsGj6Pd7CqtOikRlrRmh+FAhIekMtIrv6Y5hJyG82kro
         SNMFPmoVtASwBbKFh3kplHfkb1TZQ64NY+ZOBdpMCOT9l17FMP2Wds7oF1E57Pz2p51i
         6tvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZilwwUTKg2B04hSqr+lE+FDl3+rAThj3vmXAPgDK7M=;
        fh=kYKXcAoRZ3RVfUZHzgcLnSqUGRal8IARo30dnV8QgUg=;
        b=RdjvT0Kq/+qUVcNLJO2oe7V/EiYTQdEgUnX6t+hPqdI2C2YEotVlide6k+/6CngOw8
         8nEvReU8oWrqaEbrV1rPXAEwkPp7YZMkSrg2/JFvpnzcDHJs5JolTq6BcDRSlpKWw8OH
         660f1nK+qo3YHqFQBNvYDpTjGFBDU87UzpVhhFNAqJy4WKc+461chhPqRt6Zeod3EuoK
         yentbX3fyucBXZD870hPeOFqlMN7ZLCP6QqyfTneXj4hBJZNZzXfTUc67u1VbMOwUYdS
         oU/oOmGAcWjXOpa7b410wQ2TgGAAZbbIJT3VFSB8tfTkhkW4028mnCcUcuLMGLD1UXst
         GGFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719703; x=1780324503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZilwwUTKg2B04hSqr+lE+FDl3+rAThj3vmXAPgDK7M=;
        b=XAGj16pib0iWYhWHXvI51M6AYuBm7R/td7Cb+kEpPGn16ELsFUl8kbpl5i46/ri2ky
         T2ZKks12z7eDM2Tv4XCOzLvZy7ejcp6IJkhFH/hc/f2ODIoqydTh8Il6eV9e5lA++8Pz
         bmVAtoxYFZeclWHHdFq0MTy1KTRdIZ9bwCoz1RVa7HrzWiNaQ4QrXYlpMVIDSHdPpiEF
         4vCwf9ujXjrKt00UxlC4Z7nK2z4sGapa6xDOB5OBP6vNOwx5IuLMtZ/8BzTWY8orHzZg
         8FXnY5lW2ttLZ053f9lD57OdteP6t4gqqQOaVVXhqWZIi1gz4kQDUHr8rLnu16uhZX/1
         PNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719703; x=1780324503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LZilwwUTKg2B04hSqr+lE+FDl3+rAThj3vmXAPgDK7M=;
        b=D5OJXvfIs8O68OJ6Lizwf+vYAUgu64XkPtOveAmCZepDd50lasX6WO8UhnI0/MtFmn
         K5RhBE3+YyTGddqQC4CvcHdj42WhKzZ6xCWKtqhWiJE5528vh9kTqZOS0MV0OHFSVGkx
         6YKYzYU1uILwRsIcCBzlUOphoD5o5ef9HFXVOAkglRKugZrhtEDKr1pXx9fOpUBqShoz
         5f7YRrCn3rtKeig7oHSNakEtB7Ns6vTe7szsNEKoHWEYSLq1+rbC2iz0Ji+I4u1t0GRS
         Cn+QwK6q47e4DeT6jipA8KLG2n5R0D+s29eF3Wq/vbUQ1k6/9CKjdeEISEBcc1iZ/5vH
         3xDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MK5GAZEmJMGCNQ7oFjFtalcHgXdhJBs9SdeEoKHEnDIOQxkoAlSB/Wqrw58M8oTrncsh3eA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPAi/9NohPcPA4/uohehm+8ZS35g8ICRebPeU4b3BIHTxscPS
	L9CbzpUMr3GCZ6iCg5RU4eqjVRfkY/7UHIE7AqZXSkiaAtUb5vTMIiYA7FrS1AZai6HWB3l2KWZ
	14YHK1OZpY+nDv5jGc5NpQ1ebhWlQVX4k1TTBYMJ20Q==
X-Gm-Gg: Acq92OFHaZn4zjzCHloTEnJ/lAny3XCTIQKOh4JtyMJpPi3Q7Rj1HiQvwBLUo/rz4+p
	cm7TpAkA+VSjuLAKnyUKVmzbjaGaeiZqbEREjcQLOxQ2h/okouGPHQv8ruqo0TyHu3udB3bADeH
	DG8g4k9FAcdcVS5ltG6B2OfijTH1oGxLSzgP9v2TCOJkSEL4JHYx5DKAh/DsP2Iu/tM/flIcYd6
	t+r0AKTI9/NRwDX7iYCMskHvZXHcm9TjV03KyKJg4wsutrKNJS2SKY83oL4HYtSvdDIYMByXTqc
	f8C131rbmcBbbkMrj1oyF5eWqlZp1Inpf+Mu9eIKe859F4pAONMpNB+S8LbJF05NK7XqcYvIAwJ
	NH9AoQLfm
X-Received: by 2002:a05:6830:2404:b0:7dc:2f4f:17b4 with SMTP id
 46e09a7af769-7e5fef2efdcmr8797991a34.21.1779719703414; Mon, 25 May 2026
 07:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADgB2mFBdTbad5+W=bDOMO+fe1S4jg+aCNjkgd3B3Guq0WFQdw@mail.gmail.com>
 <2026052528-resupply-fanatic-496a@gregkh> <CADgB2mH8VayssgQmuyfMJn8Vv-o8_udfL6msVGrHrL1hO9nd4g@mail.gmail.com>
In-Reply-To: <CADgB2mH8VayssgQmuyfMJn8Vv-o8_udfL6msVGrHrL1hO9nd4g@mail.gmail.com>
From: Adrian Korwel <adriank20047@gmail.com>
Date: Mon, 25 May 2026 09:34:52 -0500
X-Gm-Features: AVHnY4I21BW8Q7lxS9d3ngMrdfPwtAsu_6uaomKcSVShAhboadXjSQp87ZqPdHQ
Message-ID: <CADgB2mEChTShmNswSZqfv5X716GJkFBekA8uRhUMGh92MMMLeQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: f_uac1_legacy: fix use-after-free in gaudio_open_snd_dev()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254155-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 95D8A5CBC93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[PATCH v3 2/4] usb: gadget: f_uac1_legacy: fix use-after-free caused
by bound guard

f_audio_bind() guards gaudio_setup() with an 'audio_opts->bound' flag
to prevent re-initialization on repeated bind attempts. However the
fail: error path unconditionally calls gaudio_cleanup(). On repeated
bind attempts after failure, this closes file handles that were opened
in a previous bind invocation and already freed by RCU, causing a
use-after-free detected by KASAN:

  BUG: KASAN: slab-use-after-free in filp_flush+0x23/0x1b0
  Read of size 8 at addr ffff88810d5523a8 by task bash/306
  ...
  gaudio_cleanup+0x59/0x100
  f_audio_bind+0x4b0/0x590

Fix by removing the bound guard and calling gaudio_setup()
unconditionally in f_audio_bind(), making setup and cleanup a matched
pair within each bind invocation. Remove the now-unused 'bound' field
from struct f_uac1_legacy_opts.

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1
implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 11 ++++-------
 drivers/usb/gadget/function/u_uac1_legacy.h |  1 -
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c
b/drivers/usb/gadget/function/f_uac1_legacy.c
index 5d201a2e30e7..6ad4b16769b7 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -735,13 +735,10 @@ f_audio_bind(struct usb_configuration *c, struct
usb_function *f)

        audio_opts =3D container_of(f->fi, struct f_uac1_legacy_opts, func_=
inst);
        audio->card.gadget =3D c->cdev->gadget;
-       /* set up ASLA audio devices */
-       if (!audio_opts->bound) {
-               status =3D gaudio_setup(&audio->card);
-               if (status < 0)
-                       return status;
-               audio_opts->bound =3D true;
-       }
+       /* set up ALSA audio devices */
+       status =3D gaudio_setup(&audio->card);
+       if (status < 0)
+               return status;
        us =3D usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_u=
ac1));
        if (IS_ERR(us))
                return PTR_ERR(us);
diff --git a/drivers/usb/gadget/function/u_uac1_legacy.h
b/drivers/usb/gadget/function/u_uac1_legacy.h
index b5df9bcbbeba..fd22fd37fe53 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.h
+++ b/drivers/usb/gadget/function/u_uac1_legacy.h
@@ -61,7 +61,6 @@ struct f_uac1_legacy_opts {
        char                            *fn_play;
        char                            *fn_cap;
        char                            *fn_cntl;
-       unsigned                        bound:1;
        unsigned                        fn_play_alloc:1;
        unsigned                        fn_cap_alloc:1;
        unsigned                        fn_cntl_alloc:1;
--=20
2.43.0

On Mon, May 25, 2026 at 9:30=E2=80=AFAM Adrian Korwel <adriank20047@gmail.c=
om> wrote:
>
> On Mon, May 26, 2026 at 12:57AM, Greg KH wrote:
> > Why is this not broken up into smaller patches...
> > The "changes" go below the --- line, right?
>
> Apologies for the formatting issues. Please find v3 below as a series
> of 4 patches. Fixes split into separate patches and changelog moved
> below the --- line.
>
> Adrian Korwel (4):
>   usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_de=
v()
>   usb: gadget: f_uac1_legacy: fix use-after-free caused by bound guard
>   usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
>   usb: typec: thunderbolt: cancel work before altmode is removed
>
>  drivers/usb/gadget/function/f_uac1_legacy.c | 15 +++++++--------
>  drivers/usb/gadget/function/u_uac1_legacy.c | 10 +++++++++-
>  drivers/usb/gadget/function/u_uac1_legacy.h |  1 -
>  drivers/usb/typec/altmodes/thunderbolt.c    |  2 ++
>  4 files changed, 18 insertions(+), 10 deletions(-)
>
> On Mon, May 25, 2026 at 12:57=E2=80=AFAM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> >
> > On Sun, May 24, 2026 at 11:33:21PM -0500, Adrian Korwel wrote:
> > > Three bugs exist in this driver related to ALSA device file lifetime:
> > >
> > > 1. gaudio_open_snd_dev() opens the ALSA control file first, then the
> > >    PCM playback file. If filp_open() for playback fails, the function
> > >    returns without closing the already-opened control file handle.
> > >
> > > 2. playback_default_hw_params() return value was ignored. If it fails=
,
> > >    both the control and playback file handles are leaked, causing
> > >    gaudio_cleanup() to call filp_close() on already-freed file object=
s.
> > >
> > > 3. f_audio_bind() guards gaudio_setup() with an 'audio_opts->bound'
> > >    flag to prevent re-initialization, but the fail: error path
> > >    unconditionally calls gaudio_cleanup(). On repeated bind attempts
> > >    after failure, this closes file handles that were opened in a
> > >    previous bind invocation and already freed by RCU, causing a
> > >    use-after-free detected by KASAN:
> > >
> > >    BUG: KASAN: slab-use-after-free in filp_flush+0x23/0x1b0
> > >    Read of size 8 at addr ffff88810d5523a8 by task bash/306
> > >    ...
> > >    gaudio_cleanup+0x59/0x100
> > >    f_audio_bind+0x4b0/0x590
> > >
> > > Fix all three issues:
> > > - Close already-opened file handles on each error path in
> > >   gaudio_open_snd_dev().
> > > - Check and propagate the return value of playback_default_hw_params(=
).
> > > - Remove the 'bound' guard and call gaudio_setup() unconditionally in
> > >   f_audio_bind(), making setup and cleanup a matched pair within each
> > >   bind invocation. Remove the now-unused 'bound' field from the opts
> > >   struct.
> >
> > Why is this not broken up into smaller patches to corrispond with each
> > issue/fix?  Please do so.
> >
> >
> > >
> > > Additionally, f_audio_disable() was an empty stub. Add
> > > cancel_work_sync() to ensure the playback work item is not in flight
> > > when the function is unbound and the audio struct is freed.
> > >
> > > Changes since v1:
> > > - Added removal of the 'bound' guard in f_audio_bind() which was the
> > >   root cause of the repeated-bind UAF
> > > - Added cancel_work_sync() to f_audio_disable()
> > > - Removed now-unused 'bound' field from struct f_uac1_legacy_opts
> >
> > The "changes" go below the --- line, right?
> >
> > thanks,
> >
> > greg k-h

