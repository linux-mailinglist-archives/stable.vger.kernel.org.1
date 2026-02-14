Return-Path: <stable+bounces-216588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE67CBnqkGkfdwEAu9opvQ
	(envelope-from <stable+bounces-216588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:33:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8713D9D3
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 22:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDA3E30BF004
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 21:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4EA3126A0;
	Sat, 14 Feb 2026 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaF8n+Wd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C03126B2;
	Sat, 14 Feb 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771104447; cv=none; b=XZP+X6fi8EkWMQAg3cqdYuauFGCuFYmnBWjN+JrvUIbBf0SGU+3Uo842LMwJ7K2RLxlgN4m7uvAJ24mIFdwy0I9lu1yITB0b1m03HZLL9evj0lMTUeEfYzngVmJpdzlYQAMBzA0zMn4Ww+5Ut7jQSbIJRQZpdcSgbTHIAXUJv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771104447; c=relaxed/simple;
	bh=R+qX/dkrpBBCavbTroNjk+lNEn38yjTGaEYPb+S4W00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcHyXUljOhudpW/1T8E5YsZcZU0he2z8MP9DJ5T/gHV+6NDNxM2Lhnv8mxDvQaVPJIH4MTSxz2Ljb1a4Eu/EWeAGeS1wAzYktI4fxTGwPDKxVI1J2IkoAr5Z/HeD48XKPfSwvZUc9pCv+uoALxa2lKQdiGdlOUTSf8VnD2Wqh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaF8n+Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01CAC16AAE;
	Sat, 14 Feb 2026 21:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771104447;
	bh=R+qX/dkrpBBCavbTroNjk+lNEn38yjTGaEYPb+S4W00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LaF8n+WdhwV4M+N/2/m80YrHiZ6MalvKhdJMln7I5ESUtEvOVr3BnbDe/p0lQ+RNG
	 BGr+KYHV/wDNU6rFYj20wFvzsgd9hL/ikUWJFmg7iiZUuLa0AXXUOm5RqRZg5T5QKW
	 ai5sX25Cv/xv6fNEiWFM0YvpqXT5U+lx4dvQU1XwoXEX9KtFzetYoznvEL6A1olYyW
	 075ieIqCcyTKE3G+UC1XW6yjX/Q7zFgQRNS4Kv7dj0LfEZHCvxz7n7l5NUoVQTuv2i
	 zLjZi3joRp8kAdZFdHpBAZqHiorSkEUHVk0IuUnr7BroS/LMuIJR12czs54I3LxLiA
	 OqHq5s0PoXKpw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jacopo Scannella <code@charlie.cat>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] Bluetooth: btusb: Add device ID for Realtek RTL8761BU
Date: Sat, 14 Feb 2026 16:23:56 -0500
Message-ID: <20260214212452.782265-91-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214212452.782265-1-sashal@kernel.org>
References: <20260214212452.782265-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[charlie.cat,intel.com,kernel.org,holtmann.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216588-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,startech.com:url]
X-Rspamd-Queue-Id: 8DE8713D9D3
X-Rspamd-Action: no action

From: Jacopo Scannella <code@charlie.cat>

[ Upstream commit cc6383d4f0cf6127c0552f94cae517a06ccc6b17 ]

Add USB device ID 0x2c0a:0x8761 to the btusb driver fo the Realtek
RTL8761BU Bluetooth adapter.

Reference:
https://www.startech.com/en-us/networking-io/av53c1-usb-bluetooth

Signed-off-by: Jacopo Scannella <code@charlie.cat>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### Commit Message Analysis
The commit adds a USB device ID (0x2c0a:0x8761) for the Realtek
RTL8761BU Bluetooth adapter to the btusb driver. It references a
specific commercial product (StarTech USB Bluetooth adapter), confirming
this is real hardware that users need supported.

### Code Change Analysis
The change is a single line addition:
```c
{ USB_DEVICE(0x2c0a, 0x8761), .driver_info = BTUSB_REALTEK },
```

This adds a new USB vendor/product ID entry to the `quirks_table[]` in
`drivers/bluetooth/btusb.c`. The entry uses the `BTUSB_REALTEK`
driver_info flag, which routes the device through the existing Realtek
firmware loading and initialization path that is already well-tested for
many other Realtek Bluetooth adapters.

### Classification
This falls squarely into the **New Device IDs** exception category. The
stable kernel rules explicitly allow adding device IDs to existing
drivers:
- The btusb driver already exists in all stable trees
- The Realtek support code (`BTUSB_REALTEK`) is already present
- Only the ID mapping is new — no new code paths are exercised

### Scope and Risk Assessment
- **Lines changed:** 1 (single line addition)
- **Files touched:** 1 (`drivers/bluetooth/btusb.c`)
- **Risk:** Essentially zero. This only affects devices with USB ID
  0x2c0a:0x8761. It cannot affect any other hardware or code path. If
  the ID is wrong, the worst case is that this specific adapter doesn't
  work — no regression for anyone else.

### User Impact
Without this device ID, users with the Realtek RTL8761BU (StarTech
AV53C1) Bluetooth adapter simply cannot use it at all with Linux. The
device won't be recognized by the btusb driver. This is a complete
hardware enablement issue — the fix makes the difference between "device
works" and "device doesn't work."

### Dependency Check
No dependencies. The `BTUSB_REALTEK` flag and all associated Realtek
support code have been in the kernel for years and are present in all
actively maintained stable trees.

### Minor Note on Placement
The new entry is placed under the "Additional Realtek 8723BU Bluetooth
devices" comment section, while the subject says "RTL8761BU." This is a
minor organizational issue (it would fit better near the "Additional
Realtek 8761BUV" section), but it has zero functional impact — the
quirks_table is searched linearly and the position doesn't matter.

### Conclusion
This is a textbook example of a device ID addition that should be
backported. It's a single-line, zero-risk change that enables real
hardware for real users, using an existing well-tested driver path.

**YES**

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 972139729e8fd..cbb6ab2fd5e45 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -779,6 +779,7 @@ static const struct usb_device_id quirks_table[] = {
 
 	/* Additional Realtek 8723BU Bluetooth devices */
 	{ USB_DEVICE(0x7392, 0xa611), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x2c0a, 0x8761), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8723DE Bluetooth devices */
 	{ USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
-- 
2.51.0


