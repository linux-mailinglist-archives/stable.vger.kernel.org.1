Return-Path: <stable+bounces-247222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ERpE1/gBWr4cwIAu9opvQ
	(envelope-from <stable+bounces-247222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:46:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C67675436BD
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3913630DE11A
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB174426EAC;
	Thu, 14 May 2026 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcr8LY88"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DF34219E9
	for <stable@vger.kernel.org>; Thu, 14 May 2026 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769488; cv=none; b=fwcc9TVqOok27MY8dxa/uAoRidnK5jL0gX03wVqiLSB+6Opugm99Mw3tuwfpwLHYOfxhCF2MwrF9aicuOHWrIVxvkoOuL4jZ2kO+a9nfdHI/e1IbpmNIKTF9qeb00fDn1q4FLLI1mwwGhAnwxiWhk47IK4HcZ6dHqXb2rsMUFUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769488; c=relaxed/simple;
	bh=zluCpqhMM6VvBgJlcAiGgCuazimnhyHm88ivrs6R8LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IA8kJi7+p/jjoknywLshk5olHtvRiyLHhPdA36AFROS/kRa+gUuY10DYW7lycQJ15Z/j/tjoJRnO5K+uZC8ok7Y5x185fTIDFFXbRI+Xm44khY+oEA+QmDImbX+FGtA35maec3ypj5iiC1oFSPKkM8o0XH3I2v9wea7lfCFyfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kcr8LY88; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-393933b8c6dso9375971fa.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 07:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778769484; x=1779374284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjPi7BZ5+dULqS5lccVpY5SGYZnwsN2PwYz3FOHrrHg=;
        b=Kcr8LY88vzRSTMpMO9bb/Ov3tYmMrPDJaj0LlelqVAN7oxL7wdHs+9+IFM9ZsesDej
         C2HEw4xbmgcnPZYTUBfSJSnROGj59qkn2UFeLJ6VOkxbbOgcvW5pN32I3MPtq0rMjnfN
         Rlgvwm1e8VSZuoWy54X+MnT7lV/ZQkCD3IScMDnuqmxmMOUKbmyuUikgFNKjM3UDxe14
         cXk8AmQMC7scSMnPi3dLluIP7drQM26jK4PPKg9qTa9wF6GJvXdyve5sJzh/mGx+08Bo
         ucM+tVmGqT94xV4njLr79DT3NWcsQseEXAc8TJ04hZFu4Ih+cS9eNjlHGrgWhRZKYURY
         gwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769484; x=1779374284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjPi7BZ5+dULqS5lccVpY5SGYZnwsN2PwYz3FOHrrHg=;
        b=KgoEqv81l4+YmNRcYdHJMXph4TSu1lCE3IL+L8+gG8zYlXc4dCmBd2pMrQZcBIaVDG
         Bw2s0H0rk2ky3o18ybJm95I3VWxR/UQZkel3DNMB7xIV7sfUFBSNkABX7nxR6WLMETTW
         iiNKWkHfdmmIHbpZMef/D1TP8fkKA3NzUo0PKwMWYm4y41dKddIjod1df4gCJz1OGxCH
         eGpFQ7X0jZUrAkkZg1K13kpsDLTWLffrtYyaK27fYpgOEYcFUTUjLma6AbMR4ckt2BxN
         PAERMkvw3x6d335R6fSHzpqLo07pTiCGDALTCkoPh01qtZNQ8teJdjJq69PBfiiSCucs
         j26g==
X-Forwarded-Encrypted: i=1; AFNElJ+BeXELxHRoqIgd0dfrExrnE75wI082eK6TQ2mm2yR/KQXNtBLF1IsGPku/o/HeetUEoRJMIzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUeLS87Ma2t8GeUZbbtESkBK9r172ACCTfbRbiMwEiKl3PV7/5
	CkxhQueIUa1zsI0MWisvD1Ot67UnYfrjRvs9I616/REoM5cV96OJnZYA
X-Gm-Gg: Acq92OHWaEJHuM0fx87l7vhWx8biEc9uPiLShgUbnqEbAd10J8QhAnAIi2twgk3379G
	gBzgtAKi9tfwb13Mve8oBz1zPhFlb3CM5NHOl16hmiI+wWwDEuK6RcR3P0XoUpSTYENnA8tedGg
	AvWIDDOJSPHr0QtDYYx1n69aaBxvWYNDcMki/oap24Iwdk6VDgrQhzNUqiayCotXryOvPGUtprf
	zahDBEmWVfYIstiwRl/7TAKyyOZdNVYuxU57ARSLINkjIDtcdIP8PdhHMRbsX3YIsPqqjfYlOUk
	aI5iJI54fyaSu/a22AxwlaPp5YvTtzce5QEFnXR17iyLe856p4q8HmaFyy8r/m2ahgsEA+FA72Q
	0qdB770G5giG3ixzkl2K33S1tc8bvQZKCtJIxoKHShsjUvdpFgxF8la5HJWHFgXsg7BTPzxR17z
	neCBOTCCV/J8qafTagm+x+Il1ErfvRpkWujanWRysV09rVpVg=
X-Received: by 2002:a05:6512:1288:b0:5a8:7c42:bebe with SMTP id 2adb3069b0e04-5a8ef9a8fc3mr1056037e87.4.1778769484152;
        Thu, 14 May 2026 07:38:04 -0700 (PDT)
Received: from localhost.localdomain ([144.124.192.245])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f10c578sm518716e87.12.2026.05.14.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:38:03 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: ilpo.jarvinen@linux.intel.com
Cc: andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH 1/2] serial: 8250_dw: unregister 8250 port if clk_notifier_register() fails
Date: Thu, 14 May 2026 19:37:45 +0500
Message-Id: <20260514143746.23671-2-sozdayvek@gmail.com>
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
X-Rspamd-Queue-Id: C67675436BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-247222-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,linuxfoundation.org,kernel.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

dw8250_probe() registers the 8250 port via serial8250_register_8250_port()
and then, if the device has a clock, registers a clock notifier. If
clk_notifier_register() fails, probe returns the error but leaves the
8250 port registered. The matching serial8250_unregister_port() lives
in dw8250_remove(), which is not called when probe fails, so the port
slot stays occupied until the device is rebound or the system is
rebooted. The devm-allocated driver data is freed while the port still
references it (via the saved private_data and serial_in/serial_out
callbacks), so any access to that port slot before a rebind is a
use-after-free hazard.

Unregister the port on the clk_notifier_register() error path.

Fixes: cc816969d7b5 ("serial: 8250_dw: Fix common clocks usage race condition")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 94beadb40..7dbd79a91 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -850,8 +850,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_dfl_wq, &data->clk_work);
 	}
 
-- 
2.43.0


