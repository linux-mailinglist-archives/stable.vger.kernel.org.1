Return-Path: <stable+bounces-233572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CgRApDs1GkjywcAu9opvQ
	(envelope-from <stable+bounces-233572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:37:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F773ADCB3
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7C61300AB19
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66391221F1F;
	Tue,  7 Apr 2026 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Gsdsf/95"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3ED3AEF33
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775561869; cv=none; b=GIzblT6uXE8B7tzxQr5EpvESrPgmG6NwmptHAW1QTX0hkVgh+WbEvgSh9rjNE7vV6+Iux6dEt6UOM+eIH+XjbOcBzllF+SiDoRdxS6iGkkOTBp+QYutncjAxCggQNIISdmmitbJDuomNKv3baz5oPCnpzrvTetFBB6rFo14+f0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775561869; c=relaxed/simple;
	bh=EfpKBeqkgutVYMd8u3E6PI6OifWo+DEjlhYjpffW8cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+pz4CoP+24l6ymP0yXBOJl5MWXsGIk7CjZp/0QNer604YCCOCPsTNC0Liqyv8raVI5idgNCJ8YIjGeR6htqrLqHkRWALNkAzHy5LOJ+pVRsAfcvuTDhFnBR7f2aZsLGj0ONkGw1oWN03rGMA0Yvl2QOThp/mFLFKlASO2Vruuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Gsdsf/95; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso4517510f8f.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 04:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775561865; x=1776166665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mvR+A4CWRJxfZjjwZ3ZGzOqZJhBd4NWr/H88PgFiaA=;
        b=Gsdsf/95CKWmwBpzuAuQWrQDHjh9Qc0a9E7BeauTuAl9/PsoSVDhgm02MhmUbCFPTe
         2NqSnRXK8crIZgSxDqAdG/dqgCwXWvVqvIX/4Je1Z1RGWhsQYSmprTwrXwglRrmiIzhV
         gtF4hHM/4/PwKvRMsyzL/XrhT6nUQkgVQdW1XUI2ehjoLX5XJzSRTIvfvZXo9do4iwEl
         dyVnSG2u6NBETEX3393XCcKBIcqD9u1vbnUWodvhLY3S/bA7DaUnSp9ICg4+8z+c1K6P
         DQIzFdUO0UIdivN/rs889SBAQrtoi3r6zl96c37orjneNU6iQ+RYPpezkWQ0JoVzpHe7
         LIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775561865; x=1776166665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mvR+A4CWRJxfZjjwZ3ZGzOqZJhBd4NWr/H88PgFiaA=;
        b=RK5OI/9jKfkepUcsey0WgU/RuAby9WOJoapKDuY4t1N1qSewS2cdyBWk61h9/NA3dV
         G4wuexKGQe/MedPEKqV8wxoL/1gUs0iOgpM43O7KBiBchDNxU0RsbbDMUoiFQCKtdQuv
         jtGupSNeQvEyAX0+Ix8M7vAqHFUc5kjofvOXfaDqN/vBciUSxzdlVI1j2O6IfVln5CYF
         /hC3hNO5vBNUWGLQyJ742z8UAY5I9G9dIlob3LlAsgFxLOEXDDlbP5BwhT2hhWc/NLrZ
         PyKe4UMatC70eiIyIERPaSB9a/ivAy8nQKtq5E6dx9bF0jEHkV70Dtq0y7/Sf7YUrarB
         tf2g==
X-Gm-Message-State: AOJu0YzUpNtlbgJyWB/DiUnkqbcArglzOiZ4LsQSi7f5ImBSAvRwJLUB
	pN3smIEQzSwkvJGE1TC3UTO0R6m2o324n2g/laNqk+iGz2cC9sNWo8Sx23w/Ro6HepIFrXWJXKd
	UyZIa
X-Gm-Gg: AeBDieu8Z3jGHVZRgpHYgEJXLe+eoK0rR1OE5ggELFu051S2li5MSGfSzjNOKuaXYMZ
	MwEXbOa3vOHq+Bj4ulAplSlEk9GZIkODvsxOkYFxRKxlWCVWwsC6/b/yACUyVjrU6Z/QlaMq0v2
	Ahc8zp0YNmdqrCJQSQ/46DydJxjTtgXr8FObAjgY5ImV5UUXigfq2zffksVO1eHrO5uSQEEN1KB
	+/OjyPD6IIYFoyU/reRBmxsnbuJwl7fn93rOMMTRqQgbtHqaJYzlKUHPezwtj+7F0tq9ZhDySmY
	6kMoBXSb/HxqPjFxRc20VYLj4+W5+k8TicCFVTqd1gnU0EV4tPTcY6u26sEmzZh8HLK53CXxlys
	PMnURwjh2vMD86auee3RKPn0RO0n42fU7M57DdMh+Vc77qcmtooPBkyMAV/reM2+50ICip7738c
	bnTBzsIUd1qZBcmjQyjBoEE9KwqK740Z4qWSYoJCQDjVWowQLwPtgj
X-Received: by 2002:a05:6000:26c3:b0:439:ba75:7dab with SMTP id ffacd0b85a97d-43d29269f8fmr21966055f8f.9.1775561865216;
        Tue, 07 Apr 2026 04:37:45 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f13sm50527718f8f.3.2026.04.07.04.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:37:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stable@vger.kernel.org
Cc: claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y 1/4] phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
Date: Tue,  7 Apr 2026 14:37:39 +0300
Message-ID: <20260407113742.860378-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407113742.860378-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	DMARC_NA(0.00)[tuxon.dev];
	TAGGED_FROM(0.00)[bounces-233572-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email,bp.renesas.com:mid,tuxon.dev:dkim]
X-Rspamd-Queue-Id: 91F773ADCB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 54c4c58713aaff76c2422ff5750e557ab3b100d7 upstream.

It has been observed on the Renesas RZ/G3S SoC that unbinding and binding
the PHY driver leads to role autodetection failures. This issue occurs when
PHY 3 is the first initialized PHY. PHY 3 does not have an interrupt
associated with the USB2_INT_ENABLE register (as
rcar_gen3_int_enable[3] = 0). As a result, rcar_gen3_init_otg() is called
to initialize OTG without enabling PHY interrupts.

To resolve this, add rcar_gen3_is_any_otg_rphy_initialized() and call it in
role_store(), role_show(), and rcar_gen3_init_otg(). At the same time,
rcar_gen3_init_otg() is only called when initialization for a PHY with
interrupt bits is in progress. As a result, the
struct rcar_gen3_phy::otg_initialized is no longer needed.

Fixes: 549b6b55b005 ("phy: renesas: rcar-gen3-usb2: enable/disable independent irqs")
Cc: stable@vger.kernel.org
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250507125032.565017-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[claudiu.beznea: declare the i iterrator from
 rcar_gen3_is_any_otg_rphy_initialized() outside of for loop]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 32 +++++++++++-------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index ea01a121b8fc..646a5140b30e 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -98,7 +98,6 @@ struct rcar_gen3_phy {
 	struct rcar_gen3_chan *ch;
 	u32 int_enable_bits;
 	bool initialized;
-	bool otg_initialized;
 	bool powered;
 };
 
@@ -288,16 +287,16 @@ static bool rcar_gen3_is_any_rphy_initialized(struct rcar_gen3_chan *ch)
 	return false;
 }
 
-static bool rcar_gen3_needs_init_otg(struct rcar_gen3_chan *ch)
+static bool rcar_gen3_is_any_otg_rphy_initialized(struct rcar_gen3_chan *ch)
 {
-	int i;
+	enum rcar_gen3_phy_index i;
 
-	for (i = 0; i < NUM_OF_PHYS; i++) {
-		if (ch->rphys[i].otg_initialized)
-			return false;
+	for (i = PHY_INDEX_BOTH_HC; i <= PHY_INDEX_EHCI; i++) {
+		if (ch->rphys[i].initialized)
+			return true;
 	}
 
-	return true;
+	return false;
 }
 
 static bool rcar_gen3_are_all_rphys_power_off(struct rcar_gen3_chan *ch)
@@ -319,7 +318,7 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	if (sysfs_streq(buf, "host"))
@@ -357,7 +356,7 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 {
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_rphy_initialized(ch))
+	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
 		return -EIO;
 
 	return sprintf(buf, "%s\n", rcar_gen3_is_host(ch) ? "host" :
@@ -370,6 +369,9 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
+	if (!ch->is_otg_channel || rcar_gen3_is_any_otg_rphy_initialized(ch))
+		return;
+
 	/* Should not use functions of read-modify-write a register */
 	val = readl(usb2_base + USB2_LINECTRL1);
 	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
@@ -435,12 +437,9 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 		writel(USB2_OC_TIMSET_INIT, usb2_base + USB2_OC_TIMSET);
 	}
 
-	/* Initialize otg part */
-	if (channel->is_otg_channel) {
-		if (rcar_gen3_needs_init_otg(channel))
-			rcar_gen3_init_otg(channel);
-		rphy->otg_initialized = true;
-	}
+	/* Initialize otg part (only if we initialize a PHY with IRQs). */
+	if (rphy->int_enable_bits)
+		rcar_gen3_init_otg(channel);
 
 	rphy->initialized = true;
 
@@ -456,9 +455,6 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 
 	rphy->initialized = false;
 
-	if (channel->is_otg_channel)
-		rphy->otg_initialized = false;
-
 	val = readl(usb2_base + USB2_INT_ENABLE);
 	val &= ~rphy->int_enable_bits;
 	if (!rcar_gen3_is_any_rphy_initialized(channel))
-- 
2.43.0


