Return-Path: <stable+bounces-163496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5F9B0BCD8
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 08:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E0B3ADD81
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 06:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A4827E7FC;
	Mon, 21 Jul 2025 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b="I83a04+j"
X-Original-To: stable@vger.kernel.org
Received: from s1.g1.infrastructure.qtmlabs.xyz (s1.g1.infrastructure.qtmlabs.xyz [107.172.1.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B52C181;
	Mon, 21 Jul 2025 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.172.1.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753080132; cv=none; b=nq1ae23NqgBIrm2DL/SxHtbEDmrKB5hPszWi6l5ckiSFlPDerx198Okme1+13Wh+IIF/j0j6tB6CYCZaRFs0KWvEzAAi7xKsQ64OdqX05k/lfpO+XU3TxpCg8FcnjkCa4j2Druhwpng6FwaMG0ewourGLMb313Ldz1VFIy/8Ofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753080132; c=relaxed/simple;
	bh=wxeCEH+SU8MPDQOxuqjRDnvHyxvCzawyLu1QgV8iPD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=th7xMZNbwBHUhrq1VuFAG+XYzVNGled+rtnbHPsxOrQzPYgxyjzTZmF7viugeVwqd4ED9QHPXY68Nyc6Zu9M7bPX8CKuLyRMvkajCh5eB+mxddhgSoCcaF/LA3CExvksJDvoTVauDl4iH9A5uhg7XwsY1+cE5Tlx0pNTjTKRLUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz; spf=pass smtp.mailfrom=qtmlabs.xyz; dkim=pass (2048-bit key) header.d=qtmlabs.xyz header.i=@qtmlabs.xyz header.b=I83a04+j; arc=none smtp.client-ip=107.172.1.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qtmlabs.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qtmlabs.xyz
From: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qtmlabs.xyz; s=dkim;
	t=1753079576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JqkdQzm/twkZ0VIwHtBVBtBC90/ZA2tGjffFIZE7FDY=;
	b=I83a04+jqtQCXmrtMyJ6J9S/WKikuzmcSD6ioHXUJb+9GzTMmmWf5QQiZYhHPX7QZ1h9Bh
	rRuVJtS9o9Y9RhgcNKIin2IjyFWrb8TS2ACFEdTlBYVV3UfNb1mpbpHL6Ex7BwluhCsVYf
	bD39/XeNaHk6X4QccWIWJ6a05VifPPWyclB3Al6Vqrf3Nkg9GIPzwqyRhMBm8AreAD6bNI
	XJ1KxhWyzpet0qI9bfjwIbwLIiBPMVweG6jCVfi3waFyzzLs0siRe1J7R2bI4933+4ZYOl
	OFYoUxsyBzKLVYScTDtiToRHocVqyLuBipHILmfaS0ICTdrmF4O8vSipi6Qghg==
Authentication-Results: s1.g1.infrastructure.qtmlabs.xyz;
	auth=pass smtp.mailfrom=myrrhperiwinkle@qtmlabs.xyz
Date: Mon, 21 Jul 2025 13:32:51 +0700
Subject: [PATCH] usb: typec: ucsi: Update power_supply on power role change
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-fix-ucsi-pwr-dir-notify-v1-1-e53d5340cb38@qtmlabs.xyz>
X-B4-Tracking: v=1; b=H4sIABLffWgC/x2MSQqAMAwAvyI5G9BqcfmKeKg2ai5VUlekf7d4H
 JiZFzwJk4c2eUHoZM+ri5CnCYyLcTMh28igMqWzSuU48Y3H6Bm3S9CyoFt3nh6sTaMLY4ZSkYZ
 Yb0JR/c9dH8IHLm38Z2kAAAA=
X-Change-ID: 20250721-fix-ucsi-pwr-dir-notify-8a953aab42e5
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
X-Spamd-Bar: ---

The current power direction of an USB-C port also influences the
power_supply's online status, so a power role change should also update
the power_supply.

Fixes an issue on some systems where plugging in a normal USB device in
for the first time after a reboot will cause upower to erroneously
consider the system to be connected to AC power.

Cc: stable@vger.kernel.org
Fixes: 0e6371fbfba3 ("usb: typec: ucsi: Report power supply changes")
Signed-off-by: Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>
---
 drivers/usb/typec/ucsi/ucsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 01ce858a1a2b3466155db340e213c767d1e79479..8ff31963970bb384e28b460e5307e32cf421396b 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1246,6 +1246,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	if (change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
 		typec_set_pwr_role(con->port, role);
+		ucsi_port_psy_changed(con);
 
 		/* Complete pending power role swap */
 		if (!completion_done(&con->complete))

---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250721-fix-ucsi-pwr-dir-notify-8a953aab42e5

Best regards,
-- 
Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>


