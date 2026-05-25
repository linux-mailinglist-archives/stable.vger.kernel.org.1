Return-Path: <stable+bounces-254070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SODwCSXRE2oaGQcAu9opvQ
	(envelope-from <stable+bounces-254070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:33:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 306B45C5B16
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 06:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CB7B3001A55
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 04:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B37306765;
	Mon, 25 May 2026 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWIAM7x1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25C2C2374
	for <stable@vger.kernel.org>; Mon, 25 May 2026 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779683616; cv=pass; b=jcbmDD1YXkji35Z6jz6oCi/q3Lea4HUdo4yG3pYnuHocP7JP+PJ1jWlHUEZRNSjLIjHtHgOq280qW7nRvtCWkUIcroYJ/p3wHUTKKN9eo9GmaiWVOC4l5WfiejbLGaPlY01Jce+ZLabSJN48Fw3jwqG5tuAbZP1O/n6snQOpSrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779683616; c=relaxed/simple;
	bh=Gf45grVFuOm3demmJCZ0UXk9nAXKGdOg6ojGQvuzccI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r4qtXMQg9KzXODRERyAD1nV3bMRuqJ1mpXXmDK6phHKVZrRJTM9RfjtswsDwq+TlDh3AvJH7Sd6WoEXH9S/TFfxVzdUJoslbqvTEfwhhuv/hiBsitkNtivCQ16m5KW+ptoJtjcZjDP4B+4NkTsYeEBq7pPx7SYYkRlAcireX6wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWIAM7x1; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dcdd1b492eso9369170a34.1
        for <stable@vger.kernel.org>; Sun, 24 May 2026 21:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779683613; cv=none;
        d=google.com; s=arc-20240605;
        b=NroixtFJeJWvE7hOgSDWzEWUgwxNYUDjtXeSAwiC4rIGyUlpLZ8uv3YtQlYGFqVDxu
         qg3O0bvbAhhxRDqhEglLuuvlKDP48tM48ZfWUciBcol7YDvqo8fjvDPg1P+j58UwLG2y
         D3Jjbdt0+LK90SFPMCu36EvTOEfjmXrnzxFAIHTWdoJXyf94KCIWcVJ/LxR5Wrs4d7//
         IiTZkKZyI/Zvi4l12aRN+HT785ICKRReTc2bin5hZ+PNTxj0in/vBaWdMBdma2p5j+Jm
         eNg1nNiBwKgmhujsZclBFY8CC7pOJe0Ek0lp/Ao+gOYXdjI15JeAiD46wLivgAi9Ib/1
         XfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=wwimpFsVZlAEhB9iEYy3FCj8FLxAMGpQ6vRgmclzF68=;
        fh=Otn04Vc9YQW5EnGNGgZMa85VOza1eVAt1XENSZG+lRE=;
        b=bpE7plRFvLz7MddtXPrZ/UVnlMCdPO+gV39MsGfsM6LTFezs1Kj2+f8v9VwAlC0/lt
         E3X1W/VnXUrFaTdv5FHrjpSyaJCsnzZ86ugpoaLWcV/bNSYdEx1zAj4O8zngu5VRXMo3
         OkarTBCMp3n57EOG7hRCyP6a9GUoQrvx5DATADsdgeRbVJEKkb/xvuBMDoL2Ex7vu9qa
         hC6yoCEMXjFKK6pSSfB01/UKRrbk+e2pPRPhC5YNo5cSr6yV9gvii/mK1C9jv/EoSzNV
         XmgE0I7CoxHMi0L05T4n90OtGaId1i8pg3gwRDRfCzWy8w03gfR4ta9wm9b+QEfWESQg
         2jCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779683613; x=1780288413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wwimpFsVZlAEhB9iEYy3FCj8FLxAMGpQ6vRgmclzF68=;
        b=iWIAM7x1UqXiWMshCiyjp0hy8VWaTHpB9LEyZS1Gcxb1Ife+lFXF9ogH+OkIGvuq0B
         jdKtdTmqFSeBdjzv50dceFC2UKGl348ZjXu9ZrdgC4K5LlaN7TKZtMfCsyUnr0K7e1x6
         wC13cOvFf1wwtVrwZpTQtxY7ehog+8WzznOzQrrvMNZoa9w3O8fjWwOCBPjlFAbxeivl
         6PvUOb/KfVQmH4m1Sbb6Q0/Ehsd9BMC9tKTk/ljVb+eD3IZhcCvIf990Ua1WgIVK0ZgT
         7an3ZEVsUiuAbnEtUJ6h/Dsgv6n5RVWv8njOAviXvhO4X4vzeM85/lIXSfjHmpoV8Rd2
         dyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779683613; x=1780288413;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwimpFsVZlAEhB9iEYy3FCj8FLxAMGpQ6vRgmclzF68=;
        b=B7PAf1ZJUgKlAU8/hN6yBoPnxcyR4OCqjtAaTReR46JdOW1f5FqiViGfqlnJxiM6F6
         mXb8a7urUtueRbLf0jTPVtCRtEN+sjk3Nt0vYGwL+LUkS+fPz8s/sEbRDL0NwQO11jFe
         Ln8PPlkV2jHoLDGQ3CmFz41Jqqsow7z9Q22bcaUNIC0RxvdUEbHsrrgul+IUxuQi3r8X
         oqgpst9GAeRDZROA2nVHigKu4OiG09otDxcXZjpwVZS36UK3kswHFwVxxSpJnkhD+uxd
         sx+GcAibzOgS/iEN6rLM0IwhvcJoNZtzTUlezLmFe/7o+nbwGSbPEyHOlxBdSDlSa7g4
         +hvw==
X-Forwarded-Encrypted: i=1; AFNElJ+Fgr/98iiT2963Qeib/o7bUT5D/Cl40inWMQPaVi2IvMz28z9Z0+pQzVw0fu6ZB3qg6GuJ+ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyghtk7tVAccLwGJE9UPCFeKQ/ydiQ3I3AgVIu3S+Jv9JbgLNA7
	wl4AdbndZw0UMRwEBP5tKZNbxAaQx1EgutMPlaXhOquXmPUWMvU77NZvN00lSfi1wSD/fTyyYJ6
	zDekyi9s+P2fAgA4WjSS/L5ii2v4LeNaJj0sctys=
X-Gm-Gg: Acq92OHysE3gH/veTEwg3D+CDRfnLkTltV0SguCGEtg4bf9d8n07VenCXpHFo3C9nqi
	piTpcnSyW4COhYrcfM17NA4wLqwjyT9qMYPskpAom+r8e8hozyen1o/Asb+ViRD4hyyDyH6+Eyg
	Mx8qfgbfFC78XQ1hkRmGSEhg3qj/1rf3k+xY4iYWQajc0TImlglwpjzOWZrmByaXYRJS0VUca4i
	OehTorosRHuzIry7dGSzZuUJbzMFItESX4mr0Mp+o8kgfZmBX4RRoDshKJigdzyJ7vJizbEJj1g
	UQeWtXB/rVQki9InUsfIyic0Gqv621bMCAMHS5zVMMX4Q7weFobEplCwxLPmOTUNp33mhMDbv9z
	Uv+uxmF2Q
X-Received: by 2002:a05:6830:6afa:b0:7dc:cbe1:119c with SMTP id
 46e09a7af769-7e6000b023dmr6457209a34.10.1779683613339; Sun, 24 May 2026
 21:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian Korwel <adriank20047@gmail.com>
Date: Sun, 24 May 2026 23:33:21 -0500
X-Gm-Features: AVHnY4J0HTryi2DT2Tdv7mGRhtqdMvtV227rgKH7mGi89iEWn-SK3ZAC4rfOuBA
Message-ID: <CADgB2mFBdTbad5+W=bDOMO+fe1S4jg+aCNjkgd3B3Guq0WFQdw@mail.gmail.com>
Subject: [PATCH v2] usb: gadget: f_uac1_legacy: fix use-after-free in gaudio_open_snd_dev()
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254070-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 306B45C5B16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Three bugs exist in this driver related to ALSA device file lifetime:

1. gaudio_open_snd_dev() opens the ALSA control file first, then the
   PCM playback file. If filp_open() for playback fails, the function
   returns without closing the already-opened control file handle.

2. playback_default_hw_params() return value was ignored. If it fails,
   both the control and playback file handles are leaked, causing
   gaudio_cleanup() to call filp_close() on already-freed file objects.

3. f_audio_bind() guards gaudio_setup() with an 'audio_opts->bound'
   flag to prevent re-initialization, but the fail: error path
   unconditionally calls gaudio_cleanup(). On repeated bind attempts
   after failure, this closes file handles that were opened in a
   previous bind invocation and already freed by RCU, causing a
   use-after-free detected by KASAN:

   BUG: KASAN: slab-use-after-free in filp_flush+0x23/0x1b0
   Read of size 8 at addr ffff88810d5523a8 by task bash/306
   ...
   gaudio_cleanup+0x59/0x100
   f_audio_bind+0x4b0/0x590

Fix all three issues:
- Close already-opened file handles on each error path in
  gaudio_open_snd_dev().
- Check and propagate the return value of playback_default_hw_params().
- Remove the 'bound' guard and call gaudio_setup() unconditionally in
  f_audio_bind(), making setup and cleanup a matched pair within each
  bind invocation. Remove the now-unused 'bound' field from the opts
  struct.

Additionally, f_audio_disable() was an empty stub. Add
cancel_work_sync() to ensure the playback work item is not in flight
when the function is unbound and the audio struct is freed.

Changes since v1:
- Added removal of the 'bound' guard in f_audio_bind() which was the
  root cause of the repeated-bind UAF
- Added cancel_work_sync() to f_audio_disable()
- Removed now-unused 'bound' field from struct f_uac1_legacy_opts

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1
implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 15 +++++++--------
 drivers/usb/gadget/function/u_uac1_legacy.c | 10 +++++++++-
 drivers/usb/gadget/function/u_uac1_legacy.h |  1 -
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c
b/drivers/usb/gadget/function/f_uac1_legacy.c
index 5d201a2e30e7..798fbb8550bc 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -697,7 +697,9 @@ static int f_audio_get_alt(struct usb_function *f,
unsigned intf)

 static void f_audio_disable(struct usb_function *f)
 {
-       return;
+       struct f_audio *audio = func_to_audio(f);
+
+       cancel_work_sync(&audio->playback_work);
 }

 /*-------------------------------------------------------------------------*/
@@ -735,13 +737,10 @@ f_audio_bind(struct usb_configuration *c, struct
usb_function *f)

        audio_opts = container_of(f->fi, struct f_uac1_legacy_opts, func_inst);
        audio->card.gadget = c->cdev->gadget;
-       /* set up ASLA audio devices */
-       if (!audio_opts->bound) {
-               status = gaudio_setup(&audio->card);
-               if (status < 0)
-                       return status;
-               audio_opts->bound = true;
-       }
+       /* set up ALSA audio devices */
+       status = gaudio_setup(&audio->card);
+       if (status < 0)
+               return status;
        us = usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings_uac1));
        if (IS_ERR(us))
                return PTR_ERR(us);
diff --git a/drivers/usb/gadget/function/u_uac1_legacy.c
b/drivers/usb/gadget/function/u_uac1_legacy.c
index 01016102fa17..5bcd3afd6366 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.c
+++ b/drivers/usb/gadget/function/u_uac1_legacy.c
@@ -226,12 +226,20 @@ static int gaudio_open_snd_dev(struct gaudio *card)

                ERROR(card, "No such PCM playback device: %s\n", fn_play);
                snd->filp = NULL;
+               filp_close(card->control.filp, NULL);
+               card->control.filp = NULL;
                return ret;
        }
        pcm_file = snd->filp->private_data;
        snd->substream = pcm_file->substream;
        snd->card = card;
-       playback_default_hw_params(snd);
+       if (playback_default_hw_params(snd) < 0) {
+               filp_close(snd->filp, NULL);
+               snd->filp = NULL;
+               filp_close(card->control.filp, NULL);
+               card->control.filp = NULL;
+               return -EINVAL;
+       }

        /* Open PCM capture device and setup substream */
        snd = &card->capture;
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
-- 
2.43.0

