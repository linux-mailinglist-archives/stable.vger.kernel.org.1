Return-Path: <stable+bounces-254157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNaFG9FeFGqgMwcAu9opvQ
	(envelope-from <stable+bounces-254157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:38:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2245CBCCF
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 16:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44EA33013A48
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECBF382396;
	Mon, 25 May 2026 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDzM/TF/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A8034D394
	for <stable@vger.kernel.org>; Mon, 25 May 2026 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779719886; cv=pass; b=UJVYYg0OChZNse7wHvyh9KxwPkkV+kp5Snvz0IKIKrLA/coR778yAjMko6fv616AewH6wPmV4Xjv45zpRsqLBCeIwRLONgGU3T6qUthKmJHrimoFkwJMj0rkBzaQN8VZgWlNXlaU96WynUh3Bzcgn4iOaGM8ILJyBIHCJrdWNcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779719886; c=relaxed/simple;
	bh=G2Id5402cWyxOVLSnwdl6Q84UFGE2+M+Qt04mkCwu2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wo1u5O8VZs32mKzDUpJALPocFZlxtGhiOz9BObMD/U9bZT0mZMvr38W4vfQG6vrVx2AC8uZvuwQdgKStW6JGpZZyOQl3DPoOWtv4vnQAcaE8UPawwqBxu0buT84zAYLc6rHeXkh6cNqXo3ypZinOAlM+UvBxVbEE9QfURV+JWck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDzM/TF/; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e61da76fd9so1435919a34.0
        for <stable@vger.kernel.org>; Mon, 25 May 2026 07:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779719884; cv=none;
        d=google.com; s=arc-20240605;
        b=gUkOnSf4LCUAbNTmrRir1YcryY9vD3L+QNbuAxA7jsBM4EkiDMQGcHr2j800Juk1+E
         QXWLMfPghBJrLSjf86ntUf4nztjXoRQ5Ek1/miUJeejA0wYdoQWBvosd3v2fcW2Layjn
         xOz3NNWn3rF8LOddu0BwUTU9DPjZM9ECBFXr6H5tkajOoV6D+/MoORf+zC5sqqmSA25D
         vSJCuu/OUXm7MF7qIX3vmfu8Rn6lK17eoLlCaR7Hsw5pJfNrW0JQLLNnItzN4TGzBsft
         /F3UjXXNhkYkdhfO2kTLOy6ivxAkL9ygU4KM2L+M9BPAdZgn80mvMXnaarmjmowRRw5+
         N/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GNT00E78PpyiXmC2slq/IpO4wze6gTXWVtWJlfyewm4=;
        fh=4YLu4OVAbRDa8Do32NLF5UuIUsp9qIhnli+7JE2uDuU=;
        b=dalp0KUpwKy2SoX7LMzWbVOHQHTQXQ/mul8i/z3UtxfH7UlXLZGs+GJSkSq2NHf0su
         v2tmJmudS8oPYYVBr2gf9IKbK4Zrwg8ewMhIs/cLyZdjp8xi0bl4hyD1KZALluzxO5dY
         HTzie7PQLokNjisk5NhFbRx2N+ZqsdnwiggYbbxhTuPzkLW/vM/Xj14OOX22gj/Uoizz
         TZUwKR01B1oUFtZhkfc6ZRNilmKs2Lm697YiAIhSTsXTM+v04wyZeI1SbIcmJuYH/RDc
         JdM1rprTj5EunrXLwF48i7deUCpncN7Qsi2s2sdkFpG6DmPED/1AomTRT98Kjbd9agcp
         6x+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779719884; x=1780324684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNT00E78PpyiXmC2slq/IpO4wze6gTXWVtWJlfyewm4=;
        b=mDzM/TF/GJLfzklkqdfKOp8EjHpCr48qB46uDfCp7GizqVpyl4x/KtlA7p40LwN6li
         opGuPbeD0NdBh4iJSNLV9K7m6Man6qho6hW0ys1ZEBz3dxfo1mhRM7jgMM6wigBRFAoo
         RPVnGmtYJ16UXaa+c+Uo+OeHfDbY89PhSOd9XJHbPoQSqIs/T+kDkICSly9FD7ePimuO
         pZTVD6Je1Lc+gfyXMnu1BrKkzeZz0dC3lakbGgLYEuI+cPU+Uf+O0fiYdrtWpnRQQUyG
         tPHb6G2fkvLesM1ZFKAYajZ7PrDF7wxnFj5zUMGdjXNej6e2iBG8ypl4pBIkVgT3E5wn
         pEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779719884; x=1780324684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNT00E78PpyiXmC2slq/IpO4wze6gTXWVtWJlfyewm4=;
        b=s3yx5ZfvdmStEi9aXHkKb0kgmic4rDawUiLpb2rbjQHJgTWfsiyUtxm0JKd3A2wN2a
         qwvaOKmvU3POzXxwOCarIlYnKp/P/yRR9Tsn2X35lu16rvalA5T+Vq3KXt2SoVc47bbF
         wJI0rwsDMzytr368UdurwW2y9pOyD+tkdvnrKw+MADZ7FucIrqjVLpDb60i0mvP1D9A3
         zVaepn8dhMcd62/UltcXsYCvtFoXPZN10ax0WyBMeVtbxfduPWJxcFix0edoGgieSseA
         PVWdDMGVpuwbeO/ZT3iC3lLor1g/cc/lkTPwz/BbD1tsQoXFp6oWBW3wtDytgdEYK5GZ
         fhLg==
X-Forwarded-Encrypted: i=1; AFNElJ9BaWKLb0VnNQg7aUDLidzYM5hxlEeIJxrMVJEpJQTYtgYkX+FKlyfSQAjze0dmCeBRe+D+tZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdlCwFo3vYpB2KzObic8UslC+Pn/guSGsFhVnRXyIDrcTkWjz
	b5A/PDKM9GeQv2L3ylxuvvkkfIFuPOzRa2H1xLydMrJRjMoV5i5jjvBO9G1lD5iFv412Y4843UZ
	qFKaakK/7F4Brnc8diiZRAFgjokex5RqiitsABVdBYQ==
X-Gm-Gg: Acq92OEZO+WnoXVnTnSd+U3J8DiG2sXqvgqnhWxvSBa6vtBIfoApvLEtRMoVm1c/tMY
	VzFBwOFfiHVJv13/QF7mNo+sG/IFO5fO6tqtYuU/xLdVOJ43qilzZuxcu2Qjf8aG5ATbV3Rnz04
	W+P5omLAGeuZIY6MbMJXKgoTrtx97FJEb/NTsEgj1ENYLEsJu7DKvnnhakxtGuXvrlk5OeiFujv
	nOUyaCoVUNyJmJWlPMuw7WIf9RCvGZiyeYNQsICbB035zdiF1M5S+rpvxAdH1YnV2B2mr1+C18l
	zIs/wuylwhhSPuccfVbcB9HNXyUACp3wNpPae2pGOcXR7iJSLvNoovaGdAYyjNnPD4J6ybj7fbB
	ioAdn770u
X-Received: by 2002:a05:6830:82fc:b0:7e1:cba6:9837 with SMTP id
 46e09a7af769-7e5fed7ddd3mr8703872a34.6.1779719883977; Mon, 25 May 2026
 07:38:03 -0700 (PDT)
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
Date: Mon, 25 May 2026 09:37:52 -0500
X-Gm-Features: AVHnY4LCtHtw1vVRdklxJMBOlB7O1vYHr78coIfFTyR5_0XZytzvkR1gC1zuToY
Message-ID: <CADgB2mFC436hPxF1FpP2OgO7iY8KVaF3igiWe1mTTB=BJFgmmw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: f_uac1_legacy: fix use-after-free in gaudio_open_snd_dev()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org, 
	heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254157-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Queue-Id: BA2245CBCCF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[PATCH v3 4/4] usb: typec: thunderbolt: cancel work before altmode is remov=
ed

tbt_altmode_remove() frees resources associated with the Thunderbolt
altmode but does not cancel the pending work item before returning.
Since tbt is allocated with devm_kzalloc(), it is freed automatically
when the device is released after remove() returns.

The work item tbt_altmode_work() can be scheduled via schedule_work()
from tbt_altmode_vdm(), tbt_altmode_activate(), and the probe path,
and may still be pending or running when tbt_altmode_remove() returns.
The work function accesses tbt->lock, tbt->state, tbt->alt, and
tbt->plug[] =E2=80=94 all of which reside in the freed struct, resulting in
a use-after-free.

Fix by calling cancel_work_sync() in tbt_altmode_remove() before
releasing any resources, ensuring no work item referencing tbt can
run after teardown begins.

Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate Mo=
de")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/typec/altmodes/thunderbolt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/altmodes/thunderbolt.c
b/drivers/usb/typec/altmodes/thunderbolt.c
index 32250b94262a..57c8dff0c51f 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -303,6 +303,8 @@ static void tbt_altmode_remove(struct typec_altmode *al=
t)
 {
        struct tbt_altmode *tbt =3D typec_altmode_get_drvdata(alt);
+       cancel_work_sync(&tbt->work);
+
        for (int i =3D TYPEC_PLUG_SOP_PP; i >=3D 0; --i) {
                if (tbt->plug[i])
                        typec_altmode_put_plug(tbt->plug[i]);
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

