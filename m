Return-Path: <stable+bounces-242134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DnZBE5n82ky2QEAu9opvQ
	(envelope-from <stable+bounces-242134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:29:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7117B4A414C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 16:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F133302199E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4F242B75B;
	Thu, 30 Apr 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wYpqmr8L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vm/l7ArT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wYpqmr8L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vm/l7ArT"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E794942981A
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559370; cv=none; b=UGt4bzzYDOMeaFKRGQJRMde3ZvC32a4RctZ3b2B5seD0yFcFfrLcXc7bxiar6W5cmrhlTpI5x9jRvni2xfWuknpVDuiGgGwiRXmPE3WCp4IVxDF6KdX7SnW72i8PmVX0KHLQVz9tWwHNGcIsrcXUL1qC/OrVB2hAFJwi3rvzAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559370; c=relaxed/simple;
	bh=PqLfuc+u5Eu8mywuPSgcKKE2kSP+9+K5t2wIbxTcPjY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R70yzGBhepEx50OIFkeSKfPQTSJYyNnrpMLazBITgiQlx2GuHwu4i6iMatW1531VJ2pkFc045L+zBzVKmOFwpB5145J674jrSHD0vEyJHDubHz0CLJvU+qoOYv8YKmqRJE5v2KWP33d/ErmuGBkO2lgNfX8yTlLaENXLlX3wyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wYpqmr8L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vm/l7ArT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wYpqmr8L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vm/l7ArT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A1405BD3C;
	Thu, 30 Apr 2026 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777559367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohAgqVDBAfASVnGPkaLLDwXnJ/6bmFpEe/jmONatg/8=;
	b=wYpqmr8L0fS6kFIDZjO1V21K4pmUG1igYG+W7TRcOJfwrCa1eHpZVaezTbNe8wJIxhjiry
	r49xugIhvXvVcRx5KiSDZ7wuooZlJk3J2WiE30Cn8ucIc0W7L/CbCTdo/Pz8JzNw+M9e+e
	kvdM97LlXgl44Kux10KByZuWW3/zSf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777559367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohAgqVDBAfASVnGPkaLLDwXnJ/6bmFpEe/jmONatg/8=;
	b=Vm/l7ArT5v1sTOGN5BqXg+wBUF0SwX6vpmgSCdTU1RzYtQvA3gNPXQS5sFnRbBqCpCXkmr
	sJokhhBgzt6UA1AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wYpqmr8L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Vm/l7ArT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777559367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohAgqVDBAfASVnGPkaLLDwXnJ/6bmFpEe/jmONatg/8=;
	b=wYpqmr8L0fS6kFIDZjO1V21K4pmUG1igYG+W7TRcOJfwrCa1eHpZVaezTbNe8wJIxhjiry
	r49xugIhvXvVcRx5KiSDZ7wuooZlJk3J2WiE30Cn8ucIc0W7L/CbCTdo/Pz8JzNw+M9e+e
	kvdM97LlXgl44Kux10KByZuWW3/zSf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777559367;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohAgqVDBAfASVnGPkaLLDwXnJ/6bmFpEe/jmONatg/8=;
	b=Vm/l7ArT5v1sTOGN5BqXg+wBUF0SwX6vpmgSCdTU1RzYtQvA3gNPXQS5sFnRbBqCpCXkmr
	sJokhhBgzt6UA1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFAD7593B0;
	Thu, 30 Apr 2026 14:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mfdeMUZn82lOcwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 30 Apr 2026 14:29:26 +0000
Date: Thu, 30 Apr 2026 16:29:26 +0200
Message-ID: <87wlxomshl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: Wait for async firmware callback at unbind
In-Reply-To: <87y0i4mu22.wl-tiwai@suse.de>
References: <20260430-alsa-hda-tas2781-fw-callback-teardown-v1-1-874367d6b41b@gmail.com>
	<87y0i4mu22.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 7117B4A414C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242134-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 15:55:33 +0200,
Takashi Iwai wrote:
> 
> On Thu, 30 Apr 2026 06:02:02 +0200,
> Cássio Gabriel wrote:
> > 
> > The TAS2781 HDA I2C and SPI side-codec drivers queue the RCA
> > firmware load with request_firmware_nowait() from component bind. The
> > firmware loader keeps a device reference and pins the callback module,
> > but it does not protect the driver's HDA private state from component
> > unbind.
> > 
> > The callback dereferences tas_hda/tas_priv, takes codec_lock,
> > creates ALSA controls, updates RCA/DSP state, runs runtime PM, and may
> > load DSP and calibration data. Component unbind currently removes
> > controls and DSP state immediately, and the later device remove destroys
> > codec_lock through tasdevice_remove(). A delayed callback can therefore
> > run after the HDA component state has been torn down.
> > 
> > Track the pending HDA RCA request with a completion. Mark it cancelled
> > at unbind, let a callback that observes cancellation exit before parsing
> > firmware or creating controls, and wait for any already-running callback
> > before tearing down HDA controls and DSP state.
> > 
> > Clear cached kcontrol pointers as controls are removed, and when
> > snd_ctl_add() rejects them, so a later cancelled or failed bind cannot
> > remove stale controls from an earlier bind.
> > 
> > Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
> > Fixes: bb5f86ea50ff ("ALSA: hda/tas2781: Add tas2781 hda SPI driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> 
> Hmm, this looks too complex than needed.  Basically what we want is a
> simple cancel or sync for async firmware loading work.  Once when such
> a helper is provided, the rest in the HD-audio side will be just a
> call of it at the remove or unbind.  And, I guess we can implement the
> helper in the f/w loader with a help of devres or such.

I meant something like below (caution: totally untested)


Takashi

-- 8< --

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index a11b30dda23b..bd99c5417be8 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1140,6 +1140,20 @@ struct firmware_work {
 	u32 opt_flags;
 };
 
+static void firmware_devres_release(struct device *dev, void *res)
+{
+	struct firmware_work *fw_work = res;
+
+	module_put(fw_work->module);
+	kfree_const(fw_work->name);
+	put_device(fw_work->device); /* taken in request_firmware_nowait() */
+}
+
+static int firmware_devres_match(struct device *dev, void *res, void *data)
+{
+	return res == data;
+}
+
 static void request_firmware_work_func(struct work_struct *work)
 {
 	struct firmware_work *fw_work;
@@ -1150,14 +1164,10 @@ static void request_firmware_work_func(struct work_struct *work)
 	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
 			  fw_work->opt_flags);
 	fw_work->cont(fw, fw_work->context);
-	put_device(fw_work->device); /* taken in request_firmware_nowait() */
-
-	module_put(fw_work->module);
-	kfree_const(fw_work->name);
-	kfree(fw_work);
+	devres_release(fw_work->device, firmware_devres_release,
+		       firmware_devres_match, fw_work);
 }
 
-
 static int _request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
@@ -1165,14 +1175,14 @@ static int _request_firmware_nowait(
 {
 	struct firmware_work *fw_work;
 
-	fw_work = kzalloc_obj(struct firmware_work, gfp);
+	fw_work = devres_alloc(firmware_devres_release, sizeof(*fw_work), gfp);
 	if (!fw_work)
 		return -ENOMEM;
 
 	fw_work->module = module;
 	fw_work->name = kstrdup_const(name, gfp);
 	if (!fw_work->name) {
-		kfree(fw_work);
+		devres_free(fw_work);
 		return -ENOMEM;
 	}
 	fw_work->device = device;
@@ -1184,18 +1194,19 @@ static int _request_firmware_nowait(
 
 	if (!uevent && fw_cache_is_setup(device, name)) {
 		kfree_const(fw_work->name);
-		kfree(fw_work);
+		devres_free(fw_work);
 		return -EOPNOTSUPP;
 	}
 
 	if (!try_module_get(module)) {
 		kfree_const(fw_work->name);
-		kfree(fw_work);
+		devres_free(fw_work);
 		return -EFAULT;
 	}
 
 	get_device(fw_work->device);
 	INIT_WORK(&fw_work->work, request_firmware_work_func);
+	devres_add(device, fw_work);
 	schedule_work(&fw_work->work);
 	return 0;
 }
@@ -1259,6 +1270,28 @@ int firmware_request_nowait_nowarn(
 }
 EXPORT_SYMBOL_GPL(firmware_request_nowait_nowarn);
 
+static int firmware_devres_cont_match(struct device *dev, void *res, void *data)
+{
+	struct firmware_work *fw_work = res;
+
+	return fw_work->cont == data;
+}
+
+void request_firmware_nowait_cancel(
+	struct device *device,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	struct firmware_work *fw_work;
+
+	fw_work = devres_remove(device, firmware_devres_release,
+				firmware_devres_cont_match, cont);
+	if (!fw_work)
+		return;
+	cancel_work_sync(&fw_work->work);
+	firmware_devres_release(fw_work->device, fw_work);
+	devres_free(fw_work);
+}
+
 #ifdef CONFIG_FW_CACHE
 static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index aae1b85ffc10..f7a80ed9c825 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -110,6 +110,9 @@ int request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
+void request_firmware_nowait_cancel(
+	struct device *device,
+	void (*cont)(const struct firmware *fw, void *context));
 int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
@@ -157,6 +160,12 @@ static inline int request_firmware_nowait(
 	return -EINVAL;
 }
 
+static inline void request_firmware_nowait_cancel(
+	struct device *device,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+}
+
 static inline void release_firmware(const struct firmware *fw)
 {
 }

