Return-Path: <stable+bounces-144466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7FEAB7B0A
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 03:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB54A7A8967
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 01:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CC2798F2;
	Thu, 15 May 2025 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mY4yBTIz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCB2797B7
	for <stable@vger.kernel.org>; Thu, 15 May 2025 01:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747273211; cv=none; b=M8LGR3Al3hRbe1vb5aubYAvx2szKCmlRBkM1S15tG7iFBnVf558wdGI0Fj4nokUkEJeh+8OT97zFfnxgM+iqbgbiKhEP5Y1086xbvqAx2tKr/q5BpIcY/YoT7ZuPbKuLTxBZHPTRlOrjP+NYVZw3OHNKkPmhanWTFxn7Msveagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747273211; c=relaxed/simple;
	bh=j3AQqh2bF+a1tTBBmMb6vQqukFWdDH12NEK3gDZ/zHw=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=murHr4gM3ZJxYevgBZn/hjdaFKB/O6k6D4ibIuKfKI7R8k4cgqAPphY9JmPjGUedrWizvbyt1+8LqMSYl92nKhQPWXjQbR9oXPzRyeawlCBmtBrh0D4AP3ANGv5K8I4PLayFaDnJghWmL4Nq49wS03NcgHOUKkGR+2lIu1uZrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mY4yBTIz; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ab5d34fdbso447751a91.0
        for <stable@vger.kernel.org>; Wed, 14 May 2025 18:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747273209; x=1747878009; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IakyZJkj7nOlvLL2uNc9irIZAgoOcA1vyttW9qbfPnU=;
        b=mY4yBTIzgZmK5j5zGfnDvG6JQm/gN6JTEo1tXzzkXxZy8vDFMgJp0S9V0JplwDYdgh
         T4Jt3D116pUj+P2fqsBkLLf76tUCi97li2me8oSvwN3cYRwM0pBHF+08U4sWrCUK08DR
         MVBalcLuDWN5kuXObLpRrWrb5UFrfqzmMtVJqHW554zbg7Dsfg2lVP5NmE46TWMoxGpn
         YSEw6+P7scu6QlQOfOnHTuKFxmZFRrxK8PxwRW1KWtZWWZfPRab/ImDge4bQlrIMC/gB
         saASXtqZrDZJfGvI5Hw/VuD4gCsa6MWb4k+rnuBslKRcCzzCLf2URUNQzNgtLnAZ2HXe
         gKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747273209; x=1747878009;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IakyZJkj7nOlvLL2uNc9irIZAgoOcA1vyttW9qbfPnU=;
        b=QQNLO/MF/gp2q13PXoIEsBhctJC5GcumwZ3N2/iYU+77PrCBI5TWpBJCTjGB/SDebx
         ia7p8Mn4UsuDzo5/svfsGHxa+Ljif+P9UyZbK/R5Npw63G/raxslR8ULzI4T4elhjOp+
         nl86lm8TYo1tlUmFbkhyz/VLWMlX06P3vOekjVI/M2CJJRUZ6wwMQlxtOz8RUEq03Zfj
         YtQvqIBBgkVTDLmoXJqtflc9fcC8oJ96j/mrcs2TUvIi3gDhvO6jTDIJ7EFfCKuIFTnO
         bZxD8ORAcGUSmKr6IjYYnHpou0BEdGwpp9sLQIrnglUxW196Rc95HkL4OoWt0dNDQJsC
         aPSg==
X-Forwarded-Encrypted: i=1; AJvYcCWFASIJnQTVskgmxUsb5nhZsLsl/5CC7j8td+EfdJieOq0s05Pjg77+4K3FQGZ6JVg8PtbLLKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lVZ6it5xmwJaPbF4KOTxNO94vtHdrGUir0/Ipn+ohX0sC6vw
	qnvARGmgr2+dSBMXt8yKG12dW40yLvrQW8FgqXUnIb8RxRZMSy4lcrE4reMsLBNkUbXAV0xM/FM
	RMbqOoMxQ+eoewQ==
X-Google-Smtp-Source: AGHT+IEyLvp3ghttpO9cVp/ndy7EDcY+GfCBT+shK3xrBkQdK1whbMrygpWLNQikJyJ78DDaeVfQrWnuBB9FBDk=
X-Received: from pjbsu3.prod.google.com ([2002:a17:90b:5343:b0:2fc:3022:36b8])
 (user=rdbabiera job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3949:b0:2ea:a9ac:eee1 with SMTP id 98e67ed59e1d1-30e2e5e5a63mr9196895a91.10.1747273209002;
 Wed, 14 May 2025 18:40:09 -0700 (PDT)
Date: Thu, 15 May 2025 01:40:02 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2883; i=rdbabiera@google.com;
 h=from:subject; bh=j3AQqh2bF+a1tTBBmMb6vQqukFWdDH12NEK3gDZ/zHw=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDBmqrp+nexnMyP91YvlDq4/t5j/2nvGYyf91ySyXoOzNO
 wrbRPRedZSyMIhxMMiKKbLo+ucZ3LiSumUOZ40xzBxWJpAhDFycAjCR9GqGf+ZF/zoNwq07ZgSm
 T7kyi9fm3pke0cUXr2TuN+VPPdd+VouRYeGMU16hm0Oenr75ZWHY7xdHmLpWdb378D6Jx/ix99t jRzkA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250515014003.1681068-2-rdbabiera@google.com>
Subject: [PATCH v2] usb: typec: tcpm: apply vbus before data bringup in tcpm_src_attach
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
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes since v1:
* Rebased on top of usb-linus for v6.15
---
 drivers/usb/typec/tcpm/tcpm.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 8adf6f954633..05c62a1673af 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4353,16 +4353,6 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
 	tcpm_enable_auto_vbus_discharge(port, true);
 
-	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_source(port));
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
@@ -4372,12 +4362,22 @@ static int tcpm_src_attach(struct tcpm_port *port)
 	    (polarity == TYPEC_POLARITY_CC2 && port->cc1 == TYPEC_CC_RA)) {
 		ret = tcpm_set_vconn(port, true);
 		if (ret < 0)
-			goto out_disable_pd;
+			return ret;
 	}
 
 	ret = tcpm_set_vbus(port, true);
 	if (ret < 0)
 		goto out_disable_vconn;
+	
+	ret = tcpm_set_roles(port, true, TYPEC_SOURCE, tcpm_data_role_for_source(port));
+	if (ret < 0)
+		goto out_disable_vbus;
+
+	if (port->pd_supported) {
+		ret = port->tcpc->set_pd_rx(port->tcpc, true);
+		if (ret < 0)
+			goto out_disable_mux;
+	}
 
 	port->pd_capable = false;
 
@@ -4389,14 +4389,14 @@ static int tcpm_src_attach(struct tcpm_port *port)
 
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
 

base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
-- 
2.49.0.1045.g170613ef41-goog


