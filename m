Return-Path: <stable+bounces-108600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7194AA10933
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 15:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43D07A319D
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B400114A4DD;
	Tue, 14 Jan 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NR8JTW05"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA0146A7B
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864723; cv=none; b=XqygdnQhgw4uaY66oHxnjq4qoK/eWcfEF7hmRcm2yj9Z2jPbenK7mXHMv2q/i7hytgKztkWIy26xpkUJ6R4eWlBBxaT02IDgIGuSXBSvWvdAoB1AS6e0I1vnJ1k1PSXH8Zq9sycs4WqaIxhEqJcbVUC0V8r7BezBNw6vbD/6Vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864723; c=relaxed/simple;
	bh=3mZhZEpsVXvbK8kRBz620qSwc7gVFgby48NhPbc9xTE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lvmYVUPBD/44tXMQAu8T3e0vSjw7VLZ1Mvzzgrq1zZqJ+Zwf2rxjZScJoTF7GFo3h/cRGBmyOQmozOnMhm/KevGolp7CzO4zY+qEpuN9Rv6GcniTszuhU+qJHTWwwSvl6Rlw8Y2S5vsErdh+R1E5G18CvdYRmSR++OzefbZpx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NR8JTW05; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kyletso.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163c2f32fdso157410765ad.2
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736864721; x=1737469521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tSu4xp3Y6HOXZlKWn+sVDCe4JiYP/94emAGWE5skEzM=;
        b=NR8JTW05iJ6lrIEmxwScGvR/9qBw6g5uNX8WthKPKwnXdCwrtEo21VKpc6eiOmCZMJ
         JrR/szaLNa0lq0nQfyjCC9Qld7Q/XvN2TtRpplaDzHF5dcWkv0o5wrmwdI/zKPyrt7mh
         qkkFegckV/hnVK78shNZsDsisxwGIjhmIYEt5jWR+uxOWgt8Qr4FwGINph+CKwAb334P
         VtGXj2PCn6ftrsrZ5YPmN/BQ0tOu9ieJDIgT/mganbV0/rg2qnqkWBwQeWjZUqrRR6IJ
         3XXnnU14LMcT6JnFbDZYwYsCawKX5mfdMELLcjdNAz39pl7rSauZWFuur9txgf8yCklX
         P0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736864721; x=1737469521;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tSu4xp3Y6HOXZlKWn+sVDCe4JiYP/94emAGWE5skEzM=;
        b=oAvjQ5e68VTIpuWJDBeid7xp0eorut9zN/OyMxFMbz/aHSXEzJzCoAPAKIbIwmmo0D
         keeL5uREC920XfAGjlknQaEBoZ4vWxbmU88kHtynXkmQyyUGl0pscjb+VZpIyMESdZEd
         0iAvEmpo5cyzzM0c+oYCJ3OwdjYfvJ9uV0EFlsYQaVpjkt/pNYqMoVvyAGtMMwTslmlc
         WJLGNznhhZZule28I4uQQWC4BashOUKc4SNsMg9b602NM3mKkBVI9FBIaYecb+qj0Xti
         AgKUywBx7om3gRE6BGgP5rvgEKz3oOiNN4w3RPwMSOZY0wuBURra8ruC4FSx5407Fser
         wb7g==
X-Forwarded-Encrypted: i=1; AJvYcCXz5GxgkwXOMCdZewDyjR4b3kzJ3QJFCcGMmw5wbYvtWMEURneKlY8Yffe8wRvaWBJ6GEcpTkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkVpDIDOyDMbMxuFkKw6ZGo9s/5M2/vdWOUXi/XWhkmvSdjYAT
	EwwpmAuH5WdnNIYwvRiV3E1LjyeW/PJ7k4U6de6kdHElHgDGgzRC+nHIwcv7oykiVBONhe0LXbJ
	ahyMZoQ==
X-Google-Smtp-Source: AGHT+IGzEszmDZk4FhEWLOcRg1abwedqDueuOVK7MIK2k4wjynrs8GaVu9upTo3mx4cp9fIselYBFA62pIWo
X-Received: from plbmo13.prod.google.com ([2002:a17:903:a8d:b0:216:31f0:27de])
 (user=kyletso job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94f:b0:216:25a2:2ebe
 with SMTP id d9443c01a7336-21a83f573d7mr374935705ad.19.1736864720690; Tue, 14
 Jan 2025 06:25:20 -0800 (PST)
Date: Tue, 14 Jan 2025 22:24:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250114142435.2093857-1-kyletso@google.com>
Subject: [PATCH v1] usb: typec: tcpci: Prevent Sink disconnection before
 vPpsShutdown in SPR PPS
From: Kyle Tso <kyletso@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org, 
	andre.draszik@linaro.org, rdbabiera@google.com, m.felsch@pengutronix.de, 
	xu.yang_2@nxp.com, u.kleine-koenig@baylibre.com, emanuele.ghidoli@toradex.com, 
	badhri@google.com, amitsd@google.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Kyle Tso <kyletso@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The Source can drop its output voltage to the minimum of the requested
PPS APDO voltage range when it is in Current Limit Mode. If this voltage
falls within the range of vPpsShutdown, the Source initiates a Hard
Reset and discharges Vbus. However, currently the Sink may disconnect
before the voltage reaches vPpsShutdown, leading to unexpected behavior.

Prevent premature disconnection by setting the Sink's disconnect
threshold to the minimum vPpsShutdown value. Additionally, consider the
voltage drop due to IR drop when calculating the appropriate threshold.
This ensures a robust and reliable interaction between the Source and
Sink during SPR PPS Current Limit Mode operation.

Fixes: 4288debeaa4e ("usb: typec: tcpci: Fix up sink disconnect thresholds for PD")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 13 +++++++++----
 drivers/usb/typec/tcpm/tcpm.c  |  8 +++++---
 include/linux/usb/tcpm.h       |  3 ++-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 48762508cc86..19ab6647af70 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -27,6 +27,7 @@
 #define	VPPS_NEW_MIN_PERCENT			95
 #define	VPPS_VALID_MIN_MV			100
 #define	VSINKDISCONNECT_PD_MIN_PERCENT		90
+#define	VPPS_SHUTDOWN_MIN_PERCENT		85
 
 struct tcpci {
 	struct device *dev;
@@ -366,7 +367,8 @@ static int tcpci_enable_auto_vbus_discharge(struct tcpc_dev *dev, bool enable)
 }
 
 static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
-						   bool pps_active, u32 requested_vbus_voltage_mv)
+						   bool pps_active, u32 requested_vbus_voltage_mv,
+						   u32 apdo_min_voltage_mv)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(dev);
 	unsigned int pwr_ctrl, threshold = 0;
@@ -388,9 +390,12 @@ static int tcpci_set_auto_vbus_discharge_threshold(struct tcpc_dev *dev, enum ty
 		threshold = AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV;
 	} else if (mode == TYPEC_PWR_MODE_PD) {
 		if (pps_active)
-			threshold = ((VPPS_NEW_MIN_PERCENT * requested_vbus_voltage_mv / 100) -
-				     VSINKPD_MIN_IR_DROP_MV - VPPS_VALID_MIN_MV) *
-				     VSINKDISCONNECT_PD_MIN_PERCENT / 100;
+			/*
+			 * To prevent disconnect when the source is in Current Limit Mode.
+			 * Set the threshold to the lowest possible voltage vPpsShutdown (min)
+			 */
+			threshold = VPPS_SHUTDOWN_MIN_PERCENT * apdo_min_voltage_mv / 100 -
+				    VSINKPD_MIN_IR_DROP_MV;
 		else
 			threshold = ((VSRC_NEW_MIN_PERCENT * requested_vbus_voltage_mv / 100) -
 				     VSINKPD_MIN_IR_DROP_MV - VSRC_VALID_MIN_MV) *
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 460dbde9fe22..e4b85a09c3ae 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2973,10 +2973,12 @@ static int tcpm_set_auto_vbus_discharge_threshold(struct tcpm_port *port,
 		return 0;
 
 	ret = port->tcpc->set_auto_vbus_discharge_threshold(port->tcpc, mode, pps_active,
-							    requested_vbus_voltage);
+							    requested_vbus_voltage,
+							    port->pps_data.min_volt);
 	tcpm_log_force(port,
-		       "set_auto_vbus_discharge_threshold mode:%d pps_active:%c vbus:%u ret:%d",
-		       mode, pps_active ? 'y' : 'n', requested_vbus_voltage, ret);
+		       "set_auto_vbus_discharge_threshold mode:%d pps_active:%c vbus:%u pps_apdo_min_volt:%u ret:%d",
+		       mode, pps_active ? 'y' : 'n', requested_vbus_voltage,
+		       port->pps_data.min_volt, ret);
 
 	return ret;
 }
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 061da9546a81..b22e659f81ba 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -163,7 +163,8 @@ struct tcpc_dev {
 	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
 	int (*enable_auto_vbus_discharge)(struct tcpc_dev *dev, bool enable);
 	int (*set_auto_vbus_discharge_threshold)(struct tcpc_dev *dev, enum typec_pwr_opmode mode,
-						 bool pps_active, u32 requested_vbus_voltage);
+						 bool pps_active, u32 requested_vbus_voltage,
+						 u32 pps_apdo_min_voltage);
 	bool (*is_vbus_vsafe0v)(struct tcpc_dev *dev);
 	void (*set_partner_usb_comm_capable)(struct tcpc_dev *dev, bool enable);
 	void (*check_contaminant)(struct tcpc_dev *dev);
-- 
2.47.1.688.g23fc6f90ad-goog


