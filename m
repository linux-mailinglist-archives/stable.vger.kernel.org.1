Return-Path: <stable+bounces-247223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGD7BDPgBWpJdAIAu9opvQ
	(envelope-from <stable+bounces-247223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:46:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BC73C543673
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1905F30E65D4
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886A1423148;
	Thu, 14 May 2026 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK7OB0ku"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D90B425CDF
	for <stable@vger.kernel.org>; Thu, 14 May 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769490; cv=none; b=gS9jVovJl3gKj4Y83hj90dPFHTVELGn71cr4mV40rJr+z2yPzvwcVs7wRSm0jT44yFPKgXdmAVKpID32mJh1oeTTDc15NVmQXkqK+WBrh86uYEdbNtL1TH9fOytmw5KGcGZTzuux+ic771G1juDfNajtyoCNuCEiF8Z8Asaotxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769490; c=relaxed/simple;
	bh=SGen0cAI8+jw73WuKJHAtUiwrOtLJHmirFzTJNCp9XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VNIaeRdDhYbMrwvuPvji/IpQMxIoiGUofpE6C5weNwurNQJZfix1FA4IE9wPkgN9Pz71gnWKfKdD1qjVgzHY7hFjsi80ZBOpY8S4YUn4fkWb/lDsAnerdrlGDTnEuqQ+8ar8NQFfM43JHIsSTzDVPCuB27TISCl491IIRM18go0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK7OB0ku; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8772a67bcso677084e87.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 07:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769486; x=1779374286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4W/+uaY1ucSCdVdyhDwD7Z4d6rSXxFokJhSb7BC4Ng=;
        b=kK7OB0kurzXg1SEyYIr1n5rfo/0IrVAiHsHp5jRbU0loUoWjxJHoyUCSqNexepnBoy
         UFO6FCZQ98vTK5ZvOXTcr0j4SWcmLf+dLmtsWzRsGjHRX7IDb7U2Ocb6xHNS5pcw5Xu1
         D3554HvV6IpZMYjFW2MWxjXEDb41/HPVPKqPBfHfW+v7Ti+ib0wMa4Y8/LLoKrNIO9WX
         1XyLWeTczzdaITU1uTyPiCPwLyVtideA1Qh4AsMFfPZo6CKwagavxEYKjZBFEPej97SD
         CZPzGdTSWfQomf9ZWRdSYUbZCVzbMurZhhclpHHdyOChJzR/eCQeCp4Na9eS2Rzl39xo
         iW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769486; x=1779374286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F4W/+uaY1ucSCdVdyhDwD7Z4d6rSXxFokJhSb7BC4Ng=;
        b=DXNMpieyWxu2FEgsT2l/qTDCS1v6MxWWMhxNVYynXnVIrV7yrJENhwYMSux+SdjOYw
         ercsGxtDFEAAoPFxHBslxW+GsRflbrGX/3DC4UZpgd5sizh/hc9bHfGOHhZi4EAOaqcz
         zc80ZY7ROA5OcA/t62X4G4Z+TbdAJAy1ZLLyhxYYXvpAIX6whIfhOslT8XQ+843rD/K7
         m9ofUcjtDfpB7VnhwEOejS247vLSUELBDE9+mPI/DzBn9H8u3dkUxHTLNhDhj1Mv9oyM
         DkLBYiws4kNmrkRBkF5Yb1vK78hPq/3U0n+BfZHcmYEJ7l8GlOyOxnjZ0nQ2vbEoRgqj
         y/tg==
X-Forwarded-Encrypted: i=1; AFNElJ/CSe3Fzpadl312Dko0y+0QBtN6nhb5os1tMvQWSR3aqW7IPCv/DpRXDSSU2pxOrJRAlu20cOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykBhX5DOm2tYzrIGJPDAVOdqLRRGIi2zkyPmgen4W1XJ7w5sKm
	OgTBnE/nDoxnrkbsPAPHn4ECvxrYWSH/mfGXhM7GS7EJ6ls0CYzQjR9+
X-Gm-Gg: Acq92OFFpE6Sdyusxq+bCrt5EB7GYpam3xQoR9SUr8xnSnROtAAgfOG9isJNNXD5BIY
	oH2yBfy9lbwlcIEul0HTdbJj/fY236IBp5+G1mRVRoEh+cJSjjMrEyxZGxKuVrCs11RtFSLW81B
	5uiTLPSCMJZiqGhcvdKvxR343vgT/JvAyY2aKumNFaXx7QKeiBId2Zo1U3aMPKqvAz/0RM5fm3M
	XVrJETvkF/V1G6Mjk+KMdXULFwDzTVsmrOhaxOUMfpal8jFXe3+yY2s0GVjt4xMdgtK+mEDVJPW
	LIP3FPaZbNGQqOXtEpkngUTqKoaN3/apLn/JQcIuuetOEpPEfpGMf0VQR2loZazSr/OTsZjnTbd
	nBXucgpeptnPWaKCPsjffawHzbh5HvkpTW2FIQPAdHLUajOlOm+Q0fD2sOEnsv5/7C9INfk1vxj
	17Xy9sOjk6P/UVlKcJaCupZkOks4Hgn+ct7qTkxz5H1JxcPimUiXWDKvTIdw==
X-Received: by 2002:a05:6512:39c2:b0:5a8:847a:dee2 with SMTP id 2adb3069b0e04-5a8ef9a9b90mr1051021e87.3.1778769486083;
        Thu, 14 May 2026 07:38:06 -0700 (PDT)
Received: from localhost.localdomain ([144.124.192.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c578sm518716e87.12.2026.05.14.07.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:38:05 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH 2/2] serial: 8250_dw: remove clock-notifier infrastructure
Date: Thu, 14 May 2026 19:37:46 +0500
Message-Id: <20260514143746.23671-3-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260514143746.23671-1-sozdayvek@gmail.com>
References: <20260514143746.23671-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC73C543673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-247223-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,linuxfoundation.org,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The clock notifier and matching work_struct in dw8250_data were added
in 2020 for the Baikal-T1 SoC, whose multiple UART ports share a
single reference clock and need to be informed when another consumer
re-rates that clock.

Baikal SoC support has since been removed from the kernel (see e.g.
commit 5d6c477687ae ("clk: baikal-t1: Remove not-going-to-be-supported
code for Baikal SoC") and the matching removals across bus/, mtd/,
PCI/, hwmon/, memory/). No remaining in-tree user needs the
cross-device baudclk rate-change notification path: the only
configuration that wired up the notifier was Baikal-T1's shared
reference clock topology.

Drop the now-unused clock-notifier and its deferred-update worker:

  - struct dw8250_data fields clk_notifier and clk_work,
  - the clk_to_dw8250_data() and work_to_dw8250_data() helpers,
  - the dw8250_clk_work_cb() and dw8250_clk_notifier_cb() callbacks,
  - the INIT_WORK / notifier_call setup in dw8250_probe(),
  - the clk_notifier_register() / queue_work() in dw8250_probe(),
  - the matching clk_notifier_unregister() / flush_work() in
    dw8250_remove(),
  - the stale comment in dw8250_set_termios() about the worker
    blocking,
  - the linux/notifier.h and linux/workqueue.h includes that are
    no longer used.

dw8250_set_termios() keeps calling clk_set_rate() directly, which is
all the remaining single-UART configurations require.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 81 -------------------------------
 1 file changed, 81 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7dbd79a91..41c5abccd 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -19,13 +19,11 @@
 #include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
-#include <linux/workqueue.h>
 
 #include <asm/byteorder.h>
 
@@ -86,8 +84,6 @@ struct dw8250_data {
 	u32			msr_mask_off;
 	struct clk		*clk;
 	struct clk		*pclk;
-	struct notifier_block	clk_notifier;
-	struct work_struct	clk_work;
 	struct reset_control	*rst;
 
 	unsigned int		skip_autocfg:1;
@@ -102,16 +98,6 @@ static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
 	return container_of(data, struct dw8250_data, data);
 }
 
-static inline struct dw8250_data *clk_to_dw8250_data(struct notifier_block *nb)
-{
-	return container_of(nb, struct dw8250_data, clk_notifier);
-}
-
-static inline struct dw8250_data *work_to_dw8250_data(struct work_struct *work)
-{
-	return container_of(work, struct dw8250_data, clk_work);
-}
-
 static inline u32 dw8250_modify_msr(struct uart_port *p, unsigned int offset, u32 value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
@@ -484,46 +470,6 @@ static int dw8250_handle_irq(struct uart_port *p)
 	return 1;
 }
 
-static void dw8250_clk_work_cb(struct work_struct *work)
-{
-	struct dw8250_data *d = work_to_dw8250_data(work);
-	struct uart_8250_port *up;
-	unsigned long rate;
-
-	rate = clk_get_rate(d->clk);
-	if (rate <= 0)
-		return;
-
-	up = serial8250_get_port(d->data.line);
-
-	serial8250_update_uartclk(&up->port, rate);
-}
-
-static int dw8250_clk_notifier_cb(struct notifier_block *nb,
-				  unsigned long event, void *data)
-{
-	struct dw8250_data *d = clk_to_dw8250_data(nb);
-
-	/*
-	 * We have no choice but to defer the uartclk update due to two
-	 * deadlocks. First one is caused by a recursive mutex lock which
-	 * happens when clk_set_rate() is called from dw8250_set_termios().
-	 * Second deadlock is more tricky and is caused by an inverted order of
-	 * the clk and tty-port mutexes lock. It happens if clock rate change
-	 * is requested asynchronously while set_termios() is executed between
-	 * tty-port mutex lock and clk_set_rate() function invocation and
-	 * vise-versa. Anyway if we didn't have the reference clock alteration
-	 * in the dw8250_set_termios() method we wouldn't have needed this
-	 * deferred event handling complication.
-	 */
-	if (event == POST_RATE_CHANGE) {
-		queue_work(system_dfl_wq, &d->clk_work);
-		return NOTIFY_OK;
-	}
-
-	return NOTIFY_DONE;
-}
-
 static void
 dw8250_do_pm(struct uart_port *port, unsigned int state, unsigned int old)
 {
@@ -547,10 +493,6 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, newrate);
 	if (rate > 0) {
-		/*
-		 * Note that any clock-notifier worker will block in
-		 * serial8250_update_uartclk() until we are done.
-		 */
 		ret = clk_set_rate(d->clk, newrate);
 		if (!ret)
 			p->uartclk = rate;
@@ -783,9 +725,6 @@ static int dw8250_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->clk),
 				     "failed to get baudclk\n");
 
-	INIT_WORK(&data->clk_work, dw8250_clk_work_cb);
-	data->clk_notifier.notifier_call = dw8250_clk_notifier_cb;
-
 	if (data->clk)
 		p->uartclk = clk_get_rate(data->clk);
 
@@ -843,20 +782,6 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (data->data.line < 0)
 		return data->data.line;
 
-	/*
-	 * Some platforms may provide a reference clock shared between several
-	 * devices. In this case any clock state change must be known to the
-	 * UART port at least post factum.
-	 */
-	if (data->clk) {
-		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err) {
-			serial8250_unregister_port(data->data.line);
-			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
-		}
-		queue_work(system_dfl_wq, &data->clk_work);
-	}
-
 	platform_set_drvdata(pdev, data);
 
 	pm_runtime_enable(dev);
@@ -871,12 +796,6 @@ static void dw8250_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(dev);
 
-	if (data->clk) {
-		clk_notifier_unregister(data->clk, &data->clk_notifier);
-
-		flush_work(&data->clk_work);
-	}
-
 	serial8250_unregister_port(data->data.line);
 
 	pm_runtime_disable(dev);
-- 
2.43.0


