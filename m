Return-Path: <stable+bounces-138955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F3DAA3CF9
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459599A63AC
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75EC2DCB6A;
	Tue, 29 Apr 2025 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzL+BSU+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F3246762
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 23:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970469; cv=none; b=cqxgWBmXJP8ppxybKGeo60zdTD6oqrghpiv1HKmaoqQiKSOZh1soKiF8G0O5NgRw6I+1BP7IOn+0r4LRw99krCZZ6jQBsxalEcb/MfzP95ncVnulttKLDhbcoCydFCZlEr7JaINpOCawDG76/fc5wXV5ENW78u9MMdy2YNrhAaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970469; c=relaxed/simple;
	bh=EUXN40sun50EBrYaGuLWVQrctCvrMTiPSjuC2qVa6MA=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=XDzOLemomOzHYFcxY1BHAAuCyY1tiapmOFYKV6MQcvcOBu9TPvCjHlDzHfcmmY0nBRZbswTOAEhNEoqQOY6xkuvhoWjnAudz39/5VW/djd5cjVIFbhJngQWnMTntRXGlH78+vdSpMo4ye/xpuuKvaA5FT2LAEwrLUDauAeLGhhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CzL+BSU+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso8977127a91.2
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745970467; x=1746575267; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kqhn91kxJk0NqrWbN6uNVF8ez7ssrZW8quhtkNzQJcg=;
        b=CzL+BSU+J+3IOAtJsTXPf8lw4JvLGCvN4/gDlnyVwn0OwUIOahX5ZtYZqwa2YLkr05
         SrE66pFaOgNheWY9tKdtBPwqljryVz4DjjyZiwoXTJE0ArfwfGTesKdbTeDcA8vYSeYT
         IvQ/bz/G0zdAFyueBscslUP6cdz1333it+gTqk1/IBt6rdqN3UUaTOXFis5BxMA8BIqZ
         Mipa7XNhOe/qXZFjUb/Jg9aT7ZB3YwQVUDemw8qq6WU+DXxPWQTAwbUoftmLPMHfoFk8
         erIgZtyvULb9lP36UnYzaSEOdi026vl43BAHF8LTbjNYphojWGPUiBZgNucebF85UWgY
         CTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745970467; x=1746575267;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kqhn91kxJk0NqrWbN6uNVF8ez7ssrZW8quhtkNzQJcg=;
        b=EmG1TSs1GUQT92RI9IJjSH/9xsuudsCfaiEM0tkoxDDUyGzsKmzUxZ4nB670zybY76
         Uo+rX4fOkeU8knQuDVsc6cpOf9EEaBYc3pcGUZ6Ho8K9ZK6lowLn6x0AzYbW/nQlAPlu
         biMi+1mNI96KFgiroAEP5mGlZWYJG2BNeQmaIdzoKwbkbUFTmNNWPZ4CLoGsBF9XzDY6
         yUEPhkvAdNrkI7VhVwjveZRKluQZvwsinFQByL0Lk/cSVQbsVhQ848vMqnWsxZ1GROm+
         /WOgJaUMuO815LNE0Qk/Cd++FiVzAouqZAPU13rC8TJG6fEOXePvipne+hQNjuZpLd+p
         Z/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUMjZ+k+vwpmYx2buybnkuWubHcev8KSVwF3Kz5F+0vFJpJt87HV1GnXRTIrdcwvpsNFoBlFKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1pDIi4nf3Tbda2i51VJ3Yu4yOw6HU2KFOB8WG56LiDxbgBdkj
	ufiaEDOOmEwFi8tKhqtEW14JF2ow4noN0vpVmJUfnp6GZD9l/dchekLC22ibuK6449TXNekJ2It
	f9GIkuXxkz4lkQA==
X-Google-Smtp-Source: AGHT+IFJlrR3Sq9I5l43d7ShfYq2cl3PN625t73YYl+5vc8ZyI1ord9aUK9rPq80NYo4FPLDUqCmnjMJmHuGuMA=
X-Received: from pjbok13.prod.google.com ([2002:a17:90b:1d4d:b0:301:1ea9:63b0])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fce:b0:309:fd87:821d with SMTP id 98e67ed59e1d1-30a333647demr1488703a91.29.1745970466762;
 Tue, 29 Apr 2025 16:47:46 -0700 (PDT)
Date: Tue, 29 Apr 2025 23:47:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2833; i=rdbabiera@google.com;
 h=from:subject; bh=EUXN40sun50EBrYaGuLWVQrctCvrMTiPSjuC2qVa6MA=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDBmCqfJPBE+e+jH9vbDYhiVySQvO/qvZY9Q499Zc8yyPl
 k/+rhVtHaUsDGIcDLJiiiy6/nkGN66kbpnDWWMMM4eVCWQIAxenAExk6VmG/04cOVYfax9siJgd
 PU2n4kXVDW0VPaskoVt3U3MVdQ9I+zMyPIicfpxR8mDNhcdXLDR1LmxsuZ7L7nzj20t5R7saxYI aPgA=
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250429234743.3749129-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach
From: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch fixes Type-C compliance test TD 4.7.6 - Try.SNK DRP Connect
SNKAS.

tVbusON has a limit of 275ms when entering SRC_ATTACHED. Compliance
testers can interpret the TryWait.Src to Attached.Src transition after
Try.Snk as being in Attached.Src the entire time, so ~170ms is lost
to the debounce timer.

Setting the data role can be a costly operation in host mode, and when
completed after 100ms can cause Type-C compliance test check TD 4.7.5.V.4
to fail.

Turn VBUS on before tcpm_set_roles to meet timing requirement.

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 784fa23102f9..e099a3c4428d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4355,17 +4355,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB,
-			     TYPEC_SOURCE, tcpm_data_role_for_source(port));
-	if (ret < 0)
-		return ret;
-
-	if (port->pd_supported) {
-		ret = port->tcpc->set_pd_rx(port->tcpc, true);
-		if (ret < 0)
-			goto out_disable_mux;
-	}
-
 	/*
 	 * USB Type-C specification, version 1.2,
 	 * chapter 4.5.2.2.8.1 (Attached.SRC Requirements)
@@ -4375,13 +4364,24 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	    (polarity == TYPEC_POLARITY_CC2 && port->cc1 == TYPEC_CC_RA)) {
 		ret = tcpm_set_vconn(port, true);
 		if (ret < 0)
-			goto out_disable_pd;
+			return ret;
 	}
 
 	ret = tcpm_set_vbus(port, true);
 	if (ret < 0)
 		goto out_disable_vconn;
 
+	ret = tcpm_set_roles(port, true, TYPEC_STATE_USB, TYPEC_SOURCE,
+			     tcpm_data_role_for_source(port));
+	if (ret < 0)
+		goto out_disable_vbus;
+
+	if (port->pd_supported) {
+		ret = port->tcpc->set_pd_rx(port->tcpc, true);
+		if (ret < 0)
+			goto out_disable_mux;
+	}
+
 	port->pd_capable = false;
 
 	port->partner = NULL;
@@ -4392,14 +4392,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	return 0;
 
-out_disable_vconn:
-	tcpm_set_vconn(port, false);
-out_disable_pd:
-	if (port->pd_supported)
-		port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
 	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
+out_disable_vbus:
+	tcpm_set_vbus(port, false);
+out_disable_vconn:
+	tcpm_set_vconn(port, false);
+
 	return ret;
 }
 

base-commit: 615dca38c2eae55aff80050275931c87a812b48c
-- 
2.49.0.967.g6a0df3ecc3-goog


