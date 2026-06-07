Return-Path: <stable+bounces-261155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lIg7BT1FJWoqFgIAu9opvQ
	(envelope-from <stable+bounces-261155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7E464F7A3
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:17:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=WumLK0DL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261155-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261155-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42EBC301233C
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC5F2E1F0E;
	Sun,  7 Jun 2026 10:17:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5D4071DA;
	Sun,  7 Jun 2026 10:17:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827448; cv=none; b=AziEGTW9c03qFqWsNDheb52avosMvjLRhX3jDcUyvsGdJZnxrh/+8jke+gIcBD6pkzflln+Zo38NzhgpbULIa/NMGi+LNIn3yo+WEHkCTf2Sst1IN4u9mZW0zOF+dZp7GRWZIoAMfaJiIULxNOyiLE5uuet0OwyptEKzg7QbBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827448; c=relaxed/simple;
	bh=lT8slr/76CdZeHRNjv5+r+NufwKa+sP5FlTYgHAzGNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G06Z84gLTUKzeCNsBK5jgVK5G7/IOvOE5ra0nScf7/sz9gy1eE4UGBquqMmpc/ySE2h5jQEK8gOtLCuq9N3VhuWwUYq9uPlksXrPl14HWyn1yeOPNW6lIHPdB//YWdFkEhdNCiGnkTcA4CEwl6KVpW29SMpKc/gmd6ovvE1Rpwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WumLK0DL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A790C1F00893;
	Sun,  7 Jun 2026 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827447;
	bh=uqk+8wpgbZ5E8VAAQSGKGyRxrJz947yE2PIuXsdeFyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WumLK0DLYC7Twzq3yJWj2FR65fU97e65QXHBAjYjzFfl4uPSd08tUVljEvnABUIsW
	 A7XZC2NoXXEQjWCsixZgr2IV6JkwqT5oKZr7WWrl27MQQokgQQn8QrCDjo0fkL561/
	 OlCvoKc/OFe/GWm7ZYJSN1xYgXvVm2OjdlTthIeg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Vecera <ivecera@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 094/332] dpll: zl3073x: add die temperature reporting for supported chips
Date: Sun,  7 Jun 2026 11:57:43 +0200
Message-ID: <20260607095731.606011208@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261155-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ivecera@redhat.com,m:horms@kernel.org,m:pabeni@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A7E464F7A3

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 3a97e02b3e91e4d40095ad9bb6e466d8d7c1a1bc ]

Some zl3073x chip variants (0x1Exx, 0x2Exx and 0x3FC4) provide a die
temperature status register with 0.1 C resolution.

Add a ZL3073X_FLAG_DIE_TEMP chip flag to identify these variants and
implement zl3073x_dpll_temp_get() as the dpll_device_ops.temp_get
callback. The register value is converted from 0.1 C units to
millidegrees as expected by the DPLL subsystem.

To support per-instance ops selection, copy the base dpll_device_ops
into struct zl3073x_dpll and conditionally set .temp_get during device
registration based on the chip flag.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Link: https://patch.msgid.link/20260227105300.710272-3-ivecera@redhat.com
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: d733f519f644 ("dpll: zl3073x: use __dpll_device_change_ntf() and remove change_work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/zl3073x/core.c | 22 +++++++++++-----------
 drivers/dpll/zl3073x/core.h |  2 ++
 drivers/dpll/zl3073x/dpll.c | 28 +++++++++++++++++++++++++---
 drivers/dpll/zl3073x/dpll.h |  2 ++
 drivers/dpll/zl3073x/regs.h |  2 ++
 5 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index c8af3430104505..10e036ccf08f05 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -30,18 +30,18 @@ static const struct zl3073x_chip_info zl3073x_chip_ids[] = {
 	ZL_CHIP_INFO(0x0E95, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
 	ZL_CHIP_INFO(0x0E96, 4, ZL3073X_FLAG_REF_PHASE_COMP_32),
 	ZL_CHIP_INFO(0x0E97, 5, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x1E93, 1, 0),
-	ZL_CHIP_INFO(0x1E94, 2, 0),
-	ZL_CHIP_INFO(0x1E95, 3, 0),
-	ZL_CHIP_INFO(0x1E96, 4, 0),
-	ZL_CHIP_INFO(0x1E97, 5, 0),
+	ZL_CHIP_INFO(0x1E93, 1, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E94, 2, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E95, 3, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E96, 4, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E97, 5, ZL3073X_FLAG_DIE_TEMP),
 	ZL_CHIP_INFO(0x1F60, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x2E93, 1, 0),
-	ZL_CHIP_INFO(0x2E94, 2, 0),
-	ZL_CHIP_INFO(0x2E95, 3, 0),
-	ZL_CHIP_INFO(0x2E96, 4, 0),
-	ZL_CHIP_INFO(0x2E97, 5, 0),
-	ZL_CHIP_INFO(0x3FC4, 2, 0),
+	ZL_CHIP_INFO(0x2E93, 1, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E94, 2, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E95, 3, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E96, 4, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP),
 };
 
 #define ZL_RANGE_OFFSET		0x80
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index fde5c8371fbd28..b6f22ee1c0bd1b 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -32,11 +32,13 @@ struct zl3073x_dpll;
 
 enum zl3073x_flags {
 	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
+	ZL3073X_FLAG_DIE_TEMP_BIT,
 	ZL3073X_FLAGS_NBITS /* must be last */
 };
 
 #define __ZL3073X_FLAG(name)	BIT(ZL3073X_FLAG_ ## name ## _BIT)
 #define ZL3073X_FLAG_REF_PHASE_COMP_32	__ZL3073X_FLAG(REF_PHASE_COMP_32)
+#define ZL3073X_FLAG_DIE_TEMP		__ZL3073X_FLAG(DIE_TEMP)
 
 /**
  * struct zl3073x_chip_info - chip variant identification
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index aaa14ea5e670fd..c201c974a7f9a4 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1065,6 +1065,25 @@ zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 	return 0;
 }
 
+static int
+zl3073x_dpll_temp_get(const struct dpll_device *dpll, void *dpll_priv,
+		      s32 *temp, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u16 val;
+	int rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_DIE_TEMP_STATUS, &val);
+	if (rc)
+		return rc;
+
+	/* Register value is in units of 0.1 C, convert to millidegrees */
+	*temp = (s16)val * 100;
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 			     enum dpll_lock_status *status,
@@ -1671,6 +1690,10 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 	zldpll->forced_ref = FIELD_GET(ZL_DPLL_MODE_REFSEL_REF,
 				       dpll_mode_refsel);
 
+	zldpll->ops = zl3073x_dpll_device_ops;
+	if (zldev->info->flags & ZL3073X_FLAG_DIE_TEMP)
+		zldpll->ops.temp_get = zl3073x_dpll_temp_get;
+
 	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
 					   THIS_MODULE, &zldpll->tracker);
 	if (IS_ERR(zldpll->dpll_dev)) {
@@ -1682,7 +1705,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 
 	rc = dpll_device_register(zldpll->dpll_dev,
 				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
-				  &zl3073x_dpll_device_ops, zldpll);
+				  &zldpll->ops, zldpll);
 	if (rc) {
 		dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
 		zldpll->dpll_dev = NULL;
@@ -1705,8 +1728,7 @@ zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
 
 	cancel_work_sync(&zldpll->change_work);
 
-	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
-			       zldpll);
+	dpll_device_unregister(zldpll->dpll_dev, &zldpll->ops, zldpll);
 	dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
 	zldpll->dpll_dev = NULL;
 }
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index c65c798c37927f..278a24f357c9bd 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -17,6 +17,7 @@
  * @forced_ref: selected reference in forced reference lock mode
  * @check_count: periodic check counter
  * @phase_monitor: is phase offset monitor enabled
+ * @ops: DPLL device operations for this instance
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
  * @lock_status: last saved DPLL lock status
@@ -31,6 +32,7 @@ struct zl3073x_dpll {
 	u8				forced_ref;
 	u8				check_count;
 	bool				phase_monitor;
+	struct dpll_device_ops		ops;
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
 	enum dpll_lock_status		lock_status;
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 5573d7188406bb..19c598daa784ca 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -78,6 +78,8 @@
 #define ZL_REG_RESET_STATUS			ZL_REG(0, 0x18, 1)
 #define ZL_REG_RESET_STATUS_RESET		BIT(0)
 
+#define ZL_REG_DIE_TEMP_STATUS			ZL_REG(0, 0x44, 2)
+
 /*************************
  * Register Page 2, Status
  *************************/
-- 
2.53.0




