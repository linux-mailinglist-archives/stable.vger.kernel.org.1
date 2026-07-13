Return-Path: <stable+bounces-273875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2rHZDTQLVWpLjQAAu9opvQ
	(envelope-from <stable+bounces-273875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:58:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6874D582
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 17:58:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="EBdK/teV";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273875-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273875-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35F8430DF312
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035383090C6;
	Mon, 13 Jul 2026 15:56:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F075309EE6;
	Mon, 13 Jul 2026 15:56:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958175; cv=none; b=iCCuvRC4NeZ46PhRgCU58mwpRMpkwq3bPFknWP1I5Ep4dK5wZ1rD2xUD9bYx/8avNrX3e9ATVHngmIf/tenc91x9Ixhs3VZZy3SZxo5ddzWURxUryZf+rdS6TnozTCMcYipLryKbhVRGbMzyYE+P2ZbOlhoTTLPVAq7RkL67dAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958175; c=relaxed/simple;
	bh=LCej+Rliv0wJ++djmH902EwhMHclkBEEK09dIj2uZOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1rEAC3L/5tEsAf1IgXNAHTo4INQGm1ors0YWtNxUG9HrU2OSrPckllf+agkFspbe7UliTT+TQttCPrSczoJKKrkXzLIyXDVcvRlOX/BOc94Uu8n4QIRFPoMipglyPbXYBWANzxwN38enRedkEatYaGgwTDAxmhn0IdqdnrPleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBdK/teV; arc=none smtp.client-ip=192.198.163.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783958174; x=1815494174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LCej+Rliv0wJ++djmH902EwhMHclkBEEK09dIj2uZOo=;
  b=EBdK/teVajTG4osBHGkRNrtCRnv3XJsre9gG8e+IDEBxNJlLrowKawSu
   RzcQU8hZOKeksK0GMdHx6bVhxkUN1xt2oq6twh7M8a6FeDj3W+yafollW
   hfU36P0aGoMFxYdouGEcqmUhi2lndhQU5+XHCY0r2QlDWZkAcZCbHozm3
   F4f5I1H5GK4J2j/5My0vewKFePudsQNjlgdabab0MbKdce71X6pGn/uan
   jiDjC6pvIFE6UA/MDtvqsKaORbjS4paVks9lK1J2DnuFUbPOcw2N/zwc2
   0cHYRuRHiUX8zPqkZcEFwLaRUKwgsTgG8qiB9T5qDTuxdrKHieji8NkCc
   w==;
X-CSE-ConnectionGUID: J1ZTr5okR9Sq7ZyNsfeV6g==
X-CSE-MsgGUID: jZVBw2wWSyaoFwcYjJ7yGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88393425"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88393425"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 08:56:14 -0700
X-CSE-ConnectionGUID: NpRk19ISS3SH0xPY+JPZZg==
X-CSE-MsgGUID: U/BDizIlSvev+BcDoKXIZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293774661"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 13 Jul 2026 08:56:11 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Date: Mon, 13 Jul 2026 17:56:01 +0200
Message-ID: <20260713155601.711389-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273875-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:raag.jadav@intel.com,m:mika.westerberg@linux.intel.com,m:andriy.shevchenko@linux.intel.com,m:andi.shyti@kernel.org,m:ramesh.babu.b@intel.com,m:michael.j.ruhl@intel.com,m:linux-kernel@vger.kernel.org,m:intel-xe@lists.freedesktop.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heikki.krogerus@linux.intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,intel.com:dkim,linux.intel.com:from_mime,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85D6874D582

Some platforms make an assumption that the i2c controller's
enabled state indicates also the power state of the
controller. This can create a problem when the controller is
in disabled state, because the hardware may assume
incorrectly that it is then also in low-power state.

To fix this, the controller is kept enabled by taking over
the IC_ENABLE register. The controller has to be disabled
when the configuration is updated and when the target
address or the slave address are assigned, so disabling it
when IC_CON, IC_TAR or IC_SAR registers are programmed, and
then re-enabling it again.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_i2c.c | 55 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_i2c.h |  1 +
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 7fa1b16598ee6..956a50dc4ef31 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -8,6 +8,7 @@
 #include <drm/drm_print.h>
 #include <linux/array_size.h>
 #include <linux/container_of.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -217,11 +218,40 @@ void xe_i2c_irq_postinstall(struct xe_device *xe)
 	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
 }
 
+/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
+static void xe_i2c_disable(struct xe_i2c *i2c)
+{
+	int timeout = 100;
+	u32 status;
+
+	xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 1, 0);
+
+	do {
+		status = xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_ENABLE_STATUS));
+		if (!(status & 1))
+			return;
+		/* Can't sleep here. */
+		udelay(25);
+	} while (timeout--);
+
+	dev_warn(&i2c->adapter->dev, "timeout in disabling adapter\n");
+}
+
 static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct xe_i2c *i2c = context;
 
-	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
+	*val = xe_mmio_read32(i2c->mmio, I2C_REG(reg));
+
+	switch (reg) {
+	case DW_IC_ENABLE:
+	case DW_IC_ENABLE_STATUS:
+		FIELD_MODIFY(DW_IC_ENABLE_ENABLE, val,
+			     i2c->ic_enable & DW_IC_ENABLE_ENABLE);
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
@@ -230,7 +260,28 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct xe_i2c *i2c = context;
 
-	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
+	switch (reg) {
+	case DW_IC_CON:
+	case DW_IC_TAR:
+	case DW_IC_SAR:
+		/* Disable the controller. */
+		xe_i2c_disable(i2c);
+
+		/* Write the register. */
+		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
+
+		/* Enable the controller. */
+		xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 0, 1);
+		break;
+	case DW_IC_ENABLE:
+		i2c->ic_enable = val;
+		/* Other fields can be updated except the enable bit. */
+		val |= DW_IC_ENABLE_ENABLE;
+		fallthrough;
+	default:
+		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
+		break;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index c95f98c2053d5..2cd17b5726289 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -37,6 +37,7 @@ struct xe_i2c {
 	struct platform_device *pdev;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
+	unsigned int ic_enable;
 
 	struct notifier_block bus_notifier;
 	struct work_struct work;
-- 
2.50.1


