Return-Path: <stable+bounces-214412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EnSFW1NhGm82QMAu9opvQ
	(envelope-from <stable+bounces-214412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:57:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED288EFA5C
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 08:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF873304650D
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 07:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B8C35FF5A;
	Thu,  5 Feb 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1GjaFyx"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BD35FF4B
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278096; cv=none; b=MrsLLJ0ErHD86arnJEmC9sLX7RsbRO6CcIwKeBYbdba2F2k2hCEXZSuxW3/CEjaLdX0IETgRfrtskXOVgjNVBcdT1pFwFu1+diJ2gVKrdZrYpTuoZ7iM/hRuNk2GxdNkZOYcKFLo/X4uWYIubGEBsMo/azLIEuEYK9GehXIUDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278096; c=relaxed/simple;
	bh=0QPmD3khOolAd8Pn3PVfrdLjo36wnyy1/CNnpQc+9/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J/T9QKXeZ5OJ5PdqE7zl7WypgIzyhhn0/L6ORNItZb/0U0Z2A4vLXP8xYNnRS2PG3QtPhYu+29CPknHOoPlHQ56+yvfbjab6IocUDEnXIEnnbt1sIsh8kyuduNnoJunviB3eJubvEHBsgFGQclG5iTNOfnNhhtmbnm1v9MdNIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1GjaFyx; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12460a7caa2so910927c88.1
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 23:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770278095; x=1770882895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBBtBB/edst42TJYyd/52k6/BJT8oZp8WOZjI5v+niI=;
        b=U1GjaFyxz667KWALHbxvEBqm7+KBwkhxn17k3vKfnCJGD5+2IFzFku7WgKg7rjr1uX
         tipYHVksbun5YboKWycLlNUTgzP8RwakDVaLJ9DEeEXKt2ZRto6qVPNSx4ArE3qruVdO
         hblI/i6pIFQq/hYYTO23WZR7inwB5aHPhxqOiDoNnZ7DJj/NBd98xbpzIlRonTegd2BA
         OLOnc/IvF0V1LlRJXJh2Tr7D4ZY1jjVQDXATQD0PXpFY46FNJbN41XNQAJUh8UkasbAQ
         SwxG8MqY5HlvxYnFWRBimdPJziJjhYBPDQxyENm4FPQpkHF5f+UWTKc9HA0Rfqb1m9pl
         m2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278095; x=1770882895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBBtBB/edst42TJYyd/52k6/BJT8oZp8WOZjI5v+niI=;
        b=oj5DMtJq23q1awXSGF13k+r7tvyr0/6gce7pnYFG3nvt7Qj+NFZT8Swv5IPL8paSTv
         e8057QMpFkwF3xM95qvM6a2DJJTf5u9LP4L6mKQjvj9AOSnNg990ZbY1S+8jf3nTtCs/
         yWWACKHDoPatCo7n5zcc2it2pHnqgfwkMsxUVfMG4cUidkIhug36zu0PjVIlqhYJt/s+
         hQ/7Ro/ZCqIGBK3i33TBAB4izQJxZqm5vtePzqHnTXT2hhYN6eG5DzMThXANUb6W3b1e
         LW606EgMBav0VraXHX/833auzM6VXEHN+4jQbdrDKOHkVbZqZpeYV4aAZnK4QwtOV/gF
         exlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1xwtKGXsy+pjfrYewVDmzZhLMXLkrdVG5sOWIksI0SXDIcONtGqXJ6BFJy1QzFqZq/2uKg3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSULO1HJ5TAgDd09bb29Q5CSKhJcnfM8kHiDO1o5rPGK2yRymb
	Ew8ggNJGPrvjByHJjH5kWYb53wUBRm5FisCQS3TV29G5LRnrjDmr7BaR
X-Gm-Gg: AZuq6aIUhau8TvMg7p7z04G5j6Oob5+UKQR2ChMIPRvFgBB/3wAyLxP1/avEjuDiqHM
	1OH0c16Ei9EgDnpEYBhJU57wJKRXTrn1Kxbp/53h3UIY+HpFiqoAcAJEFGK0oQ2pxN/AyleCQll
	Twl18ZmMejGTuMds0ZWUCdeBzgg4LMSOZWCBO+H3fJ/kiAACEevrCxzOdvaFOxUr/Kq6iHWHOQC
	GPOJybe5GEEtLvW9C8KDFM+irfh2af8B+eTg6WbiYXsnxuDtZguUFxytspRqrbfphrWNuWVSKHj
	XLGftC7EzkUIt39BkJg8HDHmm+GWXS/4IZhODxq0UpcuClzhj3xSU7d+nafCCIEkACrQ/WIXQvc
	OoK+TmJaO9Hmr9kETcwAnoQlnT4F3hn4V9z9x0Pkbo+b1KGIoKsIY4UItuYDiSlbKMAxdAYIfxU
	k4yzVvpem1BxLL55LGSFdlgzrfaCUnZik0z9BYplHYSgSH0ZVnqq0hFmB/xldko+auzsDW1BV7d
	wmANJDa+i4pE5WhMqyzzGGc09GH1NNRJVkAfe8mKhITa1RF4NTCe/X30JWUVarNuyHdnmbMf0ht
	cgFt
X-Received: by 2002:a05:7022:252c:b0:11b:9386:826b with SMTP id a92af1059eb24-126f48ea569mr2767700c88.48.1770278095077;
        Wed, 04 Feb 2026 23:54:55 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4bb8b02sm4007563c88.0.2026.02.04.23.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:54:54 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	Alice Michael <alice.michael@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next] net: intel: fix PCI device ID conflict between i40e and ipw2200
Date: Wed,  4 Feb 2026 23:54:44 -0800
Message-ID: <20260205075445.43347-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-214412-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED288EFA5C
X-Rspamd-Action: no action

The ID 8086:104f is matched by both i40e and ipw2200. The same device
ID should not be in more than one driver, because in that case, which
driver is used is unpredictable. Fix this by taking advantage of the
fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.

Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c  | 8 +++++++-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0b1cc0481027..2c8f449ad659 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -75,7 +75,13 @@ static const struct pci_device_id i40e_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T4), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_BASE_T_BC), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_SFP), 0},
-	{PCI_VDEVICE(INTEL, I40E_DEV_ID_10G_B), 0},
+	/*
+	 * This ID conflicts with ipw2200, but the devices can be differentiated
+	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
+	 * devices use PCI_CLASS_NETWORK_OTHER.
+	 */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, I40E_DEV_ID_10G_B),
+		PCI_CLASS_NETWORK_ETHERNET << 8, 0xffff00, 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_KX_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_QSFP_X722), 0},
 	{PCI_VDEVICE(INTEL, I40E_DEV_ID_SFP_X722), 0},
diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 09035a77e775..b0e769da9415 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -11387,7 +11387,13 @@ static const struct pci_device_id card_ids[] = {
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2754, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2761, 0, 0, 0},
 	{PCI_VENDOR_ID_INTEL, 0x1043, 0x8086, 0x2762, 0, 0, 0},
-	{PCI_VDEVICE(INTEL, 0x104f), 0},
+	/*
+	 * This ID conflicts with i40e, but the devices can be differentiated
+	 * because i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
+	 * devices use PCI_CLASS_NETWORK_OTHER.
+	 */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x104f),
+		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, 0},
 	{PCI_VDEVICE(INTEL, 0x4220), 0},	/* BG */
 	{PCI_VDEVICE(INTEL, 0x4221), 0},	/* BG */
 	{PCI_VDEVICE(INTEL, 0x4223), 0},	/* ABG */
-- 
2.43.0


