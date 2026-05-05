Return-Path: <stable+bounces-243959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIVPMW95+Wnz8wIAu9opvQ
	(envelope-from <stable+bounces-243959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:00:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3BB4C69E4
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 221E0302A4C1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F333BFE24;
	Tue,  5 May 2026 05:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYAFkY+t"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77E93BED19
	for <stable@vger.kernel.org>; Tue,  5 May 2026 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957201; cv=none; b=XTmou392sibaE5AaZxFv1GBikbBXHIWDqxVSrvB3BMnA1+75oAbOaMktN/9VuMGoaR2fhcLttrAdS7F6rvHBiVp8zpVDSNDBtr3eavIi5RmKXQ/2I1SSMF+87Z9Xe6NjBFLE+YDgZuEkRQuQoXxeG09cWdblDvnGIMvO/rBX3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957201; c=relaxed/simple;
	bh=k3lNyotbBlvJRdIa+QVnpTzMljk79k/9Qo/tA1whrNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iS6vQwKcOXvxiCzQibXHrOo+6ZwArNPDHuZjlPAOstQkLTtYJ3ku9pWCpUTp7dQq8c5KvOvF6KPe5KHuhwByXJRWeBkcDSgtjWd8uSrTZQ+Tffjjn/1PEYE2+yuxJmgWT5yqldU1ij3iazQgO2hlOfkP95Zg44ZjYIPmaYl7g7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYAFkY+t; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so11431897eec.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957199; x=1778561999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQJzEYjyJSMr2B5v+vMVW1rwmGPK2FjCqqMv4HvWwFo=;
        b=eYAFkY+t1Zu5qKg7IySriz0B52RWbyqrrDWdX3J1+8n62C6XC7WHj+xvP+4M6V5tDz
         LE9WpCZhgONay93UWAsBiz30LZrmB7pXX9JbnFZksVq/fecsavdhXfogU8c8G5wRV07x
         A91BhyfikpF45LOVQtx9vJEGttCwWdeZfwjeWsGmxyT3wNEN7ZeN8nJEyTxRlGh/pTqR
         DFnVwNGHmAn6Rc0DHdbg6+EtmR6xWAtlWgrzPfD6V6MlPMEQir6GtmROKOGhCzp/aSLO
         S4wT7lzT/NEoP8lpQnYDCo6+qxNMPOCscUk0W7wuWa+6b3UilAKhU1F5nXwVLD5Y9Hfp
         BOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957199; x=1778561999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQJzEYjyJSMr2B5v+vMVW1rwmGPK2FjCqqMv4HvWwFo=;
        b=FL3Xf4+VQ+ibg2TeGNL6sU7czYVnds3YW3wkHuM2rTamg2lypIQtMHOro2rU1H5oEc
         1Dyp4bqCKqkASCugtYJvTVdIDEb6cakCGb0JGuAKK6ozctLBUMdMj10e9/2X+fgDg9ts
         0lwFnnDQplZWLBJQrHBudr9aLTnMfG796t+W4OXC0XVWz4ORZIB3OAmlz2s+FWOXdnWJ
         4ODEnb7YpxckafvajdhF/1Z7e+mrWl4b6ZUlStpQDJLGuk+wXdbdUADpBjBC4mSs4y42
         vw6tjdv7p5MFDvTXbTykw21saiVxmu0vILti2as/i54nRCpzOrkBfoHKVqCvWHDcbkc0
         6Okw==
X-Forwarded-Encrypted: i=1; AFNElJ9hV7zwRRz2Tv9VLk6BIQmTej35iG2sS5vgd18rUwucqdFAtHldem0DoWqyI0jEOLCCF4Wggw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6+MMqIvXJ//7v4pDXwbjDCGlGvb+k9o7gRP3384TL2H4/mT6
	iE+WCfYPMEPce+HGL1JwWKzeomJvq1u9ji3WVIpOkn1AHRrVI5kf/oA0
X-Gm-Gg: AeBDieu4gSDgpkku+8WUsoOaFH1tCBrVmaLLsyu/l4M2QqD+XW5308p/NaIDCQK3+za
	Lfsvn6RiOZHpJPICJCC3yYZbhX/cQ4W5ApII7LN491CDg9YO4T9q3e29zdugOKXDAke+F5RMoAb
	8pB7YwfPmUXFAZQlz9ZIytK5B2UbPxdYpoIlavd3gbsgzKlwbIQGAP+M4X+fTbA5QRQB1PoUYqA
	ezDrOxZekLRV/zqOtSMi8oyxsT78q8FAxXV6p/fRx9Gid8/eM51ZXMIoUL+8eNxxtUk2OlL2FX5
	qM6u2FP+AmG7I7eGFtcM6bYRRnS8kUFdkr7vtmEs/AMmiFk3LMrvnAQKh4Sc6x05b7EMY2+LyjH
	XaK2FQBAkNBjPo7FjVZo57BJPEaNy0w4xihIKzQwzZqxizqgN82qDp+I/pW1Kzw0/ozBoL22xHd
	sYafD0JjcUsjuYiszapFu3CJqcb+0hLSBy4D5fH0hAp8uSGKiItpAF7aKfUzfCe42ozKK4xBzxU
	nP3ScRObuSky600L80ZiWg6kA==
X-Received: by 2002:a05:701a:c94e:b0:119:e56b:c75b with SMTP id a92af1059eb24-12dfd85eb0dmr5820668c88.32.1777957198825;
        Mon, 04 May 2026 21:59:58 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.21.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:59:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 02/20] Input: rmi4 - refactor register descriptor parsing
Date: Mon,  4 May 2026 21:59:32 -0700
Message-ID: <20260505045952.1570713-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B3BB4C69E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243959-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Factor out parsing a register descriptor item from
rmi_read_register_desc() and ensure there are no out-of-bounds accesses.

Use get_unaligned_le16() and get_unaligned_le32() for reading multi-byte
values.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 124 +++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 48 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 06f5e3000cf0..75949fb1a922 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -22,6 +22,7 @@
 #include <uapi/linux/input.h>
 #include <linux/rmi.h>
 #include <linux/export.h>
+#include <linux/unaligned.h>
 #include "rmi_bus.h"
 #include "rmi_driver.h"
 
@@ -558,30 +559,74 @@ int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 	return retval < 0 ? retval : 0;
 }
 
+static int rmi_parse_register_desc_item(struct rmi_register_desc_item *item,
+					const u8 *buf, size_t size)
+{
+	unsigned int offset = 0;
+	unsigned int map_offset = 0;
+	int b;
+
+	if (offset >= size)
+		return -EIO;
+
+	item->reg_size = buf[offset++];
+	if (item->reg_size == 0) {
+		if (size - offset < 2)
+			return -EIO;
+		item->reg_size = get_unaligned_le16(&buf[offset]);
+		offset += 2;
+	}
+
+	if (item->reg_size == 0) {
+		if (size - offset < 4)
+			return -EIO;
+		item->reg_size = get_unaligned_le32(&buf[offset]);
+		offset += 4;
+	}
+
+	do {
+		if (offset >= size)
+			return -EIO;
+
+		for (b = 0; b < 7; b++) {
+			if (buf[offset] & BIT(b)) {
+				if (map_offset >= RMI_REG_DESC_SUBPACKET_BITS)
+					return -EIO;
+				__set_bit(map_offset, item->subpacket_map);
+			}
+			++map_offset;
+		}
+	} while (buf[offset++] & BIT(7));
+
+	item->num_subpackets = bitmap_weight(item->subpacket_map,
+					     RMI_REG_DESC_SUBPACKET_BITS);
+
+	return offset;
+}
+
 int rmi_read_register_desc(struct rmi_device *d, u16 addr,
-				struct rmi_register_descriptor *rdesc)
+			   struct rmi_register_descriptor *rdesc)
 {
 	int ret;
 	u8 size_presence_reg;
 	u8 buf[35];
-	int presense_offset = 1;
-	u8 *struct_buf;
-	int reg;
-	int offset = 0;
-	int map_offset = 0;
+	unsigned int presence_offset;
+	unsigned int map_offset;
+	unsigned int offset;
+	unsigned int reg;
 	int i;
 	int b;
 
 	/*
 	 * The first register of the register descriptor is the size of
-	 * the register descriptor's presense register.
+	 * the register descriptor's presence register.
 	 */
 	ret = rmi_read(d, addr, &size_presence_reg);
 	if (ret)
 		return ret;
 	++addr;
 
-	if (size_presence_reg < 0 || size_presence_reg > 35)
+	if (size_presence_reg < 1 || size_presence_reg > 35)
 		return -EIO;
 
 	memset(buf, 0, sizeof(buf));
@@ -597,16 +642,23 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	addr += size_presence_reg;
 
 	if (buf[0] == 0) {
-		presense_offset = 3;
-		rdesc->struct_size = buf[1] | (buf[2] << 8);
+		if (size_presence_reg < 3)
+			return -EIO;
+		presence_offset = 3;
+		rdesc->struct_size = get_unaligned_le16(&buf[1]);
 	} else {
+		presence_offset = 1;
 		rdesc->struct_size = buf[0];
 	}
 
-	for (i = presense_offset; i < size_presence_reg; i++) {
+	map_offset = 0;
+	for (i = presence_offset; i < size_presence_reg; i++) {
 		for (b = 0; b < 8; b++) {
-			if (buf[i] & (0x1 << b))
+			if (buf[i] & BIT(b)) {
+				if (map_offset >= RMI_REG_DESC_PRESENSE_BITS)
+					return -EIO;
 				bitmap_set(rdesc->presense_map, map_offset, 1);
+			}
 			++map_offset;
 		}
 	}
@@ -626,7 +678,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 * I'm not using devm_kzalloc here since it will not be retained
 	 * after exiting this function
 	 */
-	struct_buf = kzalloc(rdesc->struct_size, GFP_KERNEL);
+	u8 *struct_buf __free(kfree) = kzalloc(rdesc->struct_size, GFP_KERNEL);
 	if (!struct_buf)
 		return -ENOMEM;
 
@@ -638,56 +690,32 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 */
 	ret = rmi_read_block(d, addr, struct_buf, rdesc->struct_size);
 	if (ret)
-		goto free_struct_buff;
+		return ret;
 
 	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
+	offset = 0;
 	for (i = 0; i < rdesc->num_registers; i++) {
 		struct rmi_register_desc_item *item = &rdesc->registers[i];
-		int reg_size = struct_buf[offset];
-
-		++offset;
-		if (reg_size == 0) {
-			reg_size = struct_buf[offset] |
-					(struct_buf[offset + 1] << 8);
-			offset += 2;
-		}
+		int item_size;
 
-		if (reg_size == 0) {
-			reg_size = struct_buf[offset] |
-					(struct_buf[offset + 1] << 8) |
-					(struct_buf[offset + 2] << 16) |
-					(struct_buf[offset + 3] << 24);
-			offset += 4;
-		}
+		item_size = rmi_parse_register_desc_item(item,
+							 &struct_buf[offset],
+							 rdesc->struct_size - offset);
+		if (item_size < 0)
+			return item_size;
 
 		item->reg = reg;
-		item->reg_size = reg_size;
-
-		map_offset = 0;
-
-		do {
-			for (b = 0; b < 7; b++) {
-				if (struct_buf[offset] & (0x1 << b))
-					bitmap_set(item->subpacket_map,
-						map_offset, 1);
-				++map_offset;
-			}
-		} while (struct_buf[offset++] & 0x80);
-
-		item->num_subpackets = bitmap_weight(item->subpacket_map,
-						RMI_REG_DESC_SUBPACKET_BITS);
+		offset += item_size;
 
 		rmi_dbg(RMI_DEBUG_CORE, &d->dev,
 			"%s: reg: %d reg size: %ld subpackets: %d\n", __func__,
 			item->reg, item->reg_size, item->num_subpackets);
 
 		reg = find_next_bit(rdesc->presense_map,
-				RMI_REG_DESC_PRESENSE_BITS, reg + 1);
+				    RMI_REG_DESC_PRESENSE_BITS, reg + 1);
 	}
 
-free_struct_buff:
-	kfree(struct_buf);
-	return ret;
+	return 0;
 }
 
 const struct rmi_register_desc_item *rmi_get_register_desc_item(
-- 
2.54.0.545.g6539524ca2-goog


