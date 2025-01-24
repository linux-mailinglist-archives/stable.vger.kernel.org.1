Return-Path: <stable+bounces-110367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66559A1B1EE
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 09:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3C43A76DF
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 08:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69B1F5404;
	Fri, 24 Jan 2025 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt00Sfzw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F261DB120;
	Fri, 24 Jan 2025 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737708708; cv=none; b=QKIXrIeGQyQR3F7d81xJohdxMZpAO3hCB5f9Q1ZLJ5U2VP7mU+bJNCwsHi0TzMM/l91yLusjEk96Lb9I+DxYGeO3ZDBHW1y4vbik3vXjk3Qku/AUhvSj/6Kufleo31zMPfDWAY7p8ynmJ4wtOjWLJqx04iprLZYiMGl9C8BG4BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737708708; c=relaxed/simple;
	bh=BbN++qECnwldq4KWLWZCEtk9J6EBoaB5MgASJmvwIPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erX6G2KOPLGxv/YMxrMBegAHWXbfJyg8AF2eeCeesYpE5BTbGwi/nNPIarr9IygpQo7QQE3bwOrAHR5lI5jiT/naSmIK+EQCPC6/7I8AZiPS44u4s9FyUe4doWONrT+R21U2P4yW+TLhjt5zPw1cGYanWGf7p9DRtSDU5z8Dodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt00Sfzw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-436a03197b2so12103365e9.2;
        Fri, 24 Jan 2025 00:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737708705; x=1738313505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o7lbqvBfWFIL0G8uqSnKhjS80pSitov1mvBHEMw18dY=;
        b=Jt00SfzwNeT91KIlb9bv+oDwkEi4axqN7krBwIDS3clg6+vcZ/7iT4jLaZu/Vm8pFU
         B5C97lwsRVgvF1Pg+pmvTl0w3c3ZQza6dhTpl/CFRvbn35UdYph+gXApEo/yOlKhsCwy
         mvrDRVr4lpaOhRhFGhwDRXvjw1TQpIJ50+rW3tdpOYqlmc4cP88btK+9bSHmIGbtAM2i
         bIEE1C4x1odig/lgwunXo0UhjFtjhCg4kR62CqsbvwrQr3e8uNsKikeTDg4w1QMxf5GM
         Q/IUsUPN3MBkvhzGCyS7SN7FmUZ0EHpP1kAlUKuE5S4oiubDu5ipqmxdmEX/MQl7KSVb
         nSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737708705; x=1738313505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7lbqvBfWFIL0G8uqSnKhjS80pSitov1mvBHEMw18dY=;
        b=sk06qaQrsfq98+QGVnmqKjSkV1sRFSrIercBjAMgOxcdqOLNhaFYI2HRByoYA6vxBi
         ZFBA3PxTYd99yAqgLTFVCS+orucFpyzQ8Ni20I7OYJYFOPzP4T7xpxd8L31NCrrPc4Jv
         OZKDUyQlFKKf/Q6SstFcJzEijFqf3FnTrxkXBTp86LcFw6Q4L1Isi75lmIbxMOJ2QRPm
         BIWIPGhUW3pLULpdJ3tsJhEJkXOklv2/hBdTOx4gCmz0oMQcPktW5wHwjJlDCKq6cu69
         mU0ZkUwCpPv/quzmVQxoqeA38Sc63jrC+xSYKu62bYmUIJiMKWwboZqeKpgtP6L/3udN
         Acig==
X-Forwarded-Encrypted: i=1; AJvYcCU+kOocWR3Phj65Gp2nBcINlqbmiTKAv0bRXjc1/8leJSlw89myNajHdKROgyaRMS14nhg8lkOSi8kHG98=@vger.kernel.org, AJvYcCUHNrWGM09DVK6fWTEodXsFPeWYHbL2LUgJAunffjH63Xqlz2IJpng6/FuHqfaTbC3sd9roLWFA@vger.kernel.org
X-Gm-Message-State: AOJu0YzEjNYADeh03PgLO/+gHJZ66OaxBuDlZY7lFIvNf63aTRN8KVwU
	RtkRdXqHKiSCiP9AYzqBvg41oPpaOjfK5z0XdPilm7J+j/KvdDno
X-Gm-Gg: ASbGnctElvf3duY2LNCRlxtcx2EVzAkkNOeqony2y5vxAr1CTySI/2/vQIXU1aSPwHx
	KI86lvBYqXldDMy+oMcuY8V6jjk4Gf5MNx4qkuFHjOnfZk12wEDv+QihiATg+7KxGU4Mt0xC3I8
	X5FMB6N6kaKUqCBOkzbgNdzKT29n4XGEu96DOEZ6klKpk2iNaJHO1z/jJ6n6GjiG9zWwj0MvzNV
	wGiJo+EdkU46e+UnlZhelnFQe9OZuJolBYNxc9T2prhgXSR9ZZaa/dlbCSrlwCzNF1lLgiHNj3D
	6OtrurA8
X-Google-Smtp-Source: AGHT+IF4dqAR6koojsslJLJ51I90eR24QucpBC3Wc4090WYTgW0SGNn1teDBd4jW7zBLCJGN0QkY1w==
X-Received: by 2002:a5d:5986:0:b0:38a:a083:9200 with SMTP id ffacd0b85a97d-38bf59eb93dmr30924270f8f.44.1737708705110;
        Fri, 24 Jan 2025 00:51:45 -0800 (PST)
Received: from eichest-laptop.lan ([2a02:168:af72:0:58db:611:d7b2:c596])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a188c33sm2085115f8f.53.2025.01.24.00.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:51:44 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	tglx@linutronix.de,
	shivamurthy.shastri@linutronix.de,
	anna-maria@linutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] irqchip/irq-mvebu-icu: Fix access to msi_data from irq_domain
Date: Fri, 24 Jan 2025 09:50:39 +0100
Message-ID: <20250124085140.44792-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, we incorrectly cast irq_domain->host_data directly to
mvebu_icu_msi_data. However, host_data actually stores a structure of
type msi_domain_info.

This incorrect assumption caused issues such as the thermal sensors of
the CP110 platform malfunctioning. Specifically, the translation of the
SEI interrupt to IRQ_TYPE_EDGE_RISING failed, preventing proper
interrupt handling. The following error was observed:
genirq: Setting trigger mode 4 for irq 85 failed (irq_chip_set_type_parent+0x0/0x34)
armada_thermal f2400000.system-controller:thermal-sensor@70: Cannot request threaded IRQ 85

This commit resolves the issue by first casting host_data to
msi_domain_info and then accessing the mvebu_icu_msi_data through
msi_domain_info->chip_data.

Cc: stable@vger.kernel.org
Fixes: d929e4db22b6 ("irqchip/irq-mvebu-icu: Prepare for real per device MSI")
Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
---
Changes in v2:
* This patch is a v2 because it addresses the same issue as this patch:
  https://lore.kernel.org/all/20241217111623.92625-1-eichest@gmail.com/
* This time it addresses the underlying issue instead of adding a
  workaround (thanks to Thomas)

 drivers/irqchip/irq-mvebu-icu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index b337f6c05f18..4eebed39880a 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -68,7 +68,8 @@ static int mvebu_icu_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
 			       unsigned long *hwirq, unsigned int *type)
 {
 	unsigned int param_count = static_branch_unlikely(&legacy_bindings) ? 3 : 2;
-	struct mvebu_icu_msi_data *msi_data = d->host_data;
+	struct msi_domain_info *info = d->host_data;
+	struct mvebu_icu_msi_data *msi_data = info->chip_data;
 	struct mvebu_icu *icu = msi_data->icu;
 
 	/* Check the count of the parameters in dt */
-- 
2.45.2


