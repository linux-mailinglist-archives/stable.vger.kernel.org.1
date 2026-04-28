Return-Path: <stable+bounces-241456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VE54HMoI8GkINgEAu9opvQ
	(envelope-from <stable+bounces-241456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:09:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEADD47C4D6
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A51BE3034E29
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 01:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7067A23E35F;
	Tue, 28 Apr 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5jklr5a"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BE5464D
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338565; cv=none; b=GGm9FHpPMwxM1yDfsUHG6hWSxm+Re558ZzzbnUljp+MCZRmFKH58s+9qnw6helKLkepSmF9sdXU46aCbZXb85UInxXzJ4hEb/NRnGShRHXKmztYD7+WPn0EcUBt0hAKYh47avJ/Wn63yJfXm1eQqw7Dipl3lS4NCeo79m5M2qv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338565; c=relaxed/simple;
	bh=d9+1G5guTxGxgDF7AlZCYAyVE/dspri7a/S+NXBm2Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uJiLPKX3pTO3z8K29V6MLqVADxiGf8woTEk5Oe8GE/aiyVqW+yg6kOM+KBY3P65n2eP66Dha0wl4L4mxUYyVtUrTsrf0QuIaZzeiO+kyl1xJGshlaUbie8oyrng75hFHNk7RKYIZMztP11QovdhBtOZP8zDB2BTUyB6J2HsCpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5jklr5a; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2dee127b3c5so709550eec.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 18:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777338563; x=1777943363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqyLeCB0LHzwlyW313c4IdDkpLsyRNtNhHpc7DsBWxc=;
        b=f5jklr5aaApywTGu8JT1SSiIyIeyOlPEyMuSkHwheHMzGMrA/EMXVqmYm+MRBLio7N
         aq2299CZ8I7KcKMUnXFe1+ZzCQHyLPTO9cyRTyqKJDo+Obp1PiIF5mIItjG7aElewNiE
         uMrFb09Vx3sOpL1s8vxK3v8ftcO2ahBp8lb88Saz8mNIgkhev2/ErWT/cJqg/SJNaIdu
         zOZnrech9v4T9Cbryx+eef6YqDEyGnqFH+At6oxiZAVD+PniGJRZNaP20XDaSFZQQ4qi
         xbpTKxuCLobTYgcZnlicYnQUGyNmu3PafkklZ10yq62iqaMp1oDmlB/Jk9Oz9AUEcFuG
         Al5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777338563; x=1777943363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqyLeCB0LHzwlyW313c4IdDkpLsyRNtNhHpc7DsBWxc=;
        b=RSxReIc9+39ILXeoqxtibKGHGNiCnFLhxp/0qvQDTUXR82qouMLNJJREuXPyS7wSJQ
         0qzyQlbAsGFtbp9LdxwLnrOIJIYUChrU1KWgNBr3ZrVglbnhUG7uL1Xim+G4MUKeOgEc
         fETxhPtH6VKHjjKicegFfNMSfZBJjDlT0jxHFDVvRoSNFqs+msJFR0xbc+qVwXIsDx9O
         OCGB+/5T9DOcGYI8Mkh4E0JYTQnNtJNYx9NKO/rdIHVrOFZ1QcrQPbYPDp7KIyGfnj8h
         VwJhnd2l+JCBlR7+vT/IW3UskxI/8+ZUKivdPU0W+l6UokUoTyxM3E7SE8se+KldKPld
         Q5Rg==
X-Forwarded-Encrypted: i=1; AFNElJ+MZ+2NXlcwku77hzn9nlqGqKZYIlyhxq9JL3bBREzcPZptRsXhTEKnOc9RzytaqKr8+kCDc8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6+4EQ4063KngDhMQXnZuYo2HWFLh1ll1x1sz431pentcoemZ
	WpR8357E26jwXNUMvAYDYr79Aqzd3yLwOlARsm5BSfgZ8yXKMpORQiPu
X-Gm-Gg: AeBDies2NDXnRyjZ2NXEKzBhlJeHxLDthyP6buJ5JtY6eLvCEZksCF3og99myjNfYcZ
	VBNazAO3QLFLNGG3HiNb8MwsDImP2BV7RTWakrjzQWhPoopyIKloaFTtSX2QerLFprdVSVEY/+k
	/k5CDQRoUCgsH6GcBwIZJtNZqUUGQ/RxLZKH+fBEchFVQfdR/bFtNioDTKc2ov5wQWEYNXNCRwh
	4RetR8vDBXQTy0tPiE8C4yktLxmwU58pN7S6H5Fl/kff1Njgenk9z07FzHgy9gYKTWjy8oOjGz3
	hpazTG2+Df+ye0MwYvI70yD9klLVErhmZE5Q8gCOiWUvhuvPnse8ZJx5qcddkEavZWUk1Wq/A8C
	NpKTkJUUcIiE9N7J0Lxbz6D42gS+aPfGRrR7czkCoZBtcfNzljOzC3sZKBkuEs/EwWPYodkd85Y
	Afgd2o8+wUuw+kXU5/Hr7kxjfVqSBYeXfzaHTgjjD5sy9BmEuMtIkDwlB8J8q9V436YByVAbWi8
	/FmmLzdHTutBuG1eiSV73I6x31NL4RXIkiv
X-Received: by 2002:a05:7300:541:b0:2be:6f30:f2f9 with SMTP id 5a478bee46e88-2ed0a1122femr640598eec.26.1777338562670;
        Mon, 27 Apr 2026 18:09:22 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e678:f42a:a63c:516c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09fb64d7sm1071380eec.9.2026.04.27.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:09:21 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Input: rmi4 - refactor register descriptor parsing
Date: Mon, 27 Apr 2026 18:09:15 -0700
Message-ID: <20260428010917.1320927-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEADD47C4D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241456-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]

Factor out parsing a register descriptor item from
rmi_read_register_desc() and ensure there are no out-of-bounds accesses.

Use get_unaligned_le16() and get_unaligned_le32() for reading multi-byte
values.

Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.c | 119 ++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 46 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ccd9338a44db..9871e9b816dc 100644
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
+	int offset = 0;
+	int map_offset = 0;
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
+				bitmap_set(item->subpacket_map, map_offset, 1);
+			}
+			++map_offset;
+		}
+	} while (buf[offset++] & 0x80);
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
+	int presence_offset;
 	int reg;
 	int offset = 0;
-	int map_offset = 0;
+	int map_offset;
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
 	++addr;
 
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
 
@@ -638,56 +690,31 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	 */
 	ret = rmi_read_block(d, addr, struct_buf, rdesc->struct_size);
 	if (ret)
-		goto free_struct_buff;
+		return ret;
 
 	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
 	for (i = 0; i < rdesc->num_registers; i++) {
 		struct rmi_register_desc_item *item = &rdesc->registers[i];
-		int reg_size = struct_buf[offset];
+		int item_size;
 
-		++offset;
-		if (reg_size == 0) {
-			reg_size = struct_buf[offset] |
-					(struct_buf[offset + 1] << 8);
-			offset += 2;
-		}
-
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


