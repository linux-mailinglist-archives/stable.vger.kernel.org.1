Return-Path: <stable+bounces-234869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OSGDAGo1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:09:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 857833C2821
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E79DB30F5617
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0433D6689;
	Wed,  8 Apr 2026 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Kl8Tzwz0"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D32641FC;
	Wed,  8 Apr 2026 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673974; cv=none; b=hiMwwkWxtWQwMTGNoDFgt7fnE9bqLsUvVuKszeI+voVe7H4eR4F5I3G20lq7+x/dJk9+BdBPJsQYthfzgflSDD542xKbQrBr0WrhfD1CFIJHzX9zU9tOjgqCvFLHV87w3vu310uonGx9Ye9nkRQ26S546JSItFgefv1k2BMZcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673974; c=relaxed/simple;
	bh=5D0NVeAVEZRGm+jNO6/GDyqpFaV6g6YO2O9/iACNz5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oTyQ9YiwViFNZ208ykmVEGvPUy4VqaXhB5NdTX3XDTEXbUMgxY2SJ1/4OsEbJskU8C1OaHhJ4zmV+6n0NUEgl9ohoEa1y/m5yeyo/70t1rwXNn2sOEh52ES2x0tzZxd0PBtt538edPQ49gL6G0GilKjhDHel84HLgQXlU0u0Ssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Kl8Tzwz0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775673971;
	bh=5D0NVeAVEZRGm+jNO6/GDyqpFaV6g6YO2O9/iACNz5E=;
	h=From:Date:Subject:To:Cc:From;
	b=Kl8Tzwz0ZTtEcavyDroMem9AXb4wNy6nLuT7yBD21VZkhy4qRFrmARqkewGQNrZN4
	 RGHmifSi9pSSyZ4fEkGodIQgiEs40MWNq/g1r4SoJoH/QFMwhjXNsD5LzRxIA/oD+z
	 EB8msx7UofXzHo1CnCyZNigpRbap+bDTYvxh1blY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 08 Apr 2026 20:45:50 +0200
Subject: [PATCH] hwmon: (powerz) Avoid cacheline sharing for DMA buffer
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260408-powerz-cacheline-alias-v1-1-1254891be0dd@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxG4auQrm0yjIQYr2Jc1PIjNWQgU1Ej4
 e6OuvwW763kyAanY7VSxsPcplRQ7yrSQdIVbF0xxRDb0IQDz9MT+c0qOmC0BJbRxLnrVULdxn2
 jkUo8Z/T2+o1P5799udyg9++Ntu0DtdmNaHoAAAA=
X-Change-ID: 20260408-powerz-cacheline-alias-dfca016234c2
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775673970; l=1567;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5D0NVeAVEZRGm+jNO6/GDyqpFaV6g6YO2O9/iACNz5E=;
 b=oEVo9HyrsQlkOO4SHb305kp8POEojbFDH8sEUfjcGDlQRyOsojAjk2OHJctcePiD/DcReXkD4
 +O+1beZ2PskAZ8ZeUFs+D2oh4ihFm6m0Nus9rXIAEH1MqQbB+L3REtl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234869-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 857833C2821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Depending on the architecture the transfer buffer may share a cacheline
with the following mutex. As the buffer may be used for DMA, that is
problematic.

Use the high-level DMA helpers to make sure that cacheline sharing can
not happen.

Also drop the comment, as the helpers are documentation enough.

https://sashiko.dev/#/message/20260408175814.934BFC19421%40smtp.kernel.org

Fixes: 4381a36abdf1c ("hwmon: add POWER-Z driver")
Cc: stable@vger.kernel.org # ca085faabb42: dma-mapping: add __dma_from_device_group_begin()/end()
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hwmon/powerz.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/powerz.c b/drivers/hwmon/powerz.c
index 4e663d5b4e33..5e8397895613 100644
--- a/drivers/hwmon/powerz.c
+++ b/drivers/hwmon/powerz.c
@@ -6,6 +6,7 @@
 
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -33,7 +34,9 @@ struct powerz_sensor_data {
 } __packed;
 
 struct powerz_priv {
-	char transfer_buffer[64];	/* first member to satisfy DMA alignment */
+	__dma_from_device_group_begin();
+	char transfer_buffer[64];
+	__dma_from_device_group_end();
 	struct mutex mutex;
 	struct completion completion;
 	struct urb *urb;

---
base-commit: 3036cd0d3328220a1858b1ab390be8b562774e8a
change-id: 20260408-powerz-cacheline-alias-dfca016234c2

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>


