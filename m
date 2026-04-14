Return-Path: <stable+bounces-237969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLDbEOSp3mmHHAAAu9opvQ
	(envelope-from <stable+bounces-237969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:56:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2046A3FE78D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 22:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 126E83022BB8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26FE372B45;
	Tue, 14 Apr 2026 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oseNf73+"
X-Original-To: stable@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAB8372689
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200156; cv=none; b=lOkN0zs1nDail9G7ooGPHIlXEccGn3TZHHWPnhaYGcG+Z9N3atbGsKvbXOBTbHW8EAWBuxYq/wM71n9c6mCVAADbRFcAvnFlhT1vOEhLjnF4xL0NaBw/fYE6xcBPMp2to8PcAWudmYVMA5yRw6fZGVLsxJyuM5Y1Y40wQkwQ3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200156; c=relaxed/simple;
	bh=9DFPAVujpGC2GbzOGPxwNbfZ04jWH6d6SPDB/WPoKNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=roxF94wc2TkGsHIfegQ7mFCs+vtUOQ0aOUv2Rx3DDmY6nkK3TKra1ZnXNIhj5dETGcnBxdTt6QZ1Eyikg8AocFo93FumklzWJ79KrVYuZjis7Fbxkbpg3E3j+cWbUrrD1RLINyMTETEB+j+tjAcPV5JYoePBF1KMWtT6d8W277g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oseNf73+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776200151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r6P0nneaaLMO0SWxip7riotnZ1csgytFAw0HMmy3OdA=;
	b=oseNf73+SKpQHNvMZ8YKgRenLVDRdLN2Oz8hqXGRhfANwfNce3TpX62R5NYaDxumesQuxQ
	OBB7jryuyrZmiHWJDqAhrSD2VlOeTUpShfNnpRNULCW/KykOlyQQcsdZLUj1Njfng/X1Ui
	WzdfU3dPRA7PSbDNbwqPPYJ1XL2Fsc0=
From: luka.gejak@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luka Gejak <luka.gejak@linux.dev>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix null pointer deref in rtw_check_bcn_info
Date: Tue, 14 Apr 2026 22:55:20 +0200
Message-ID: <20260414205520.157861-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237969-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 2046A3FE78D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

When parsing beacon or probe response frames, if the ap does not provide
a valid ssid ie, rtw_get_ie() returns NULL. The code then blindly
performs a memcpy() using the returned NULL pointer (p + 2), resulting
in a kernel oops or kernel panic due to a NULL pointer dereference.

Fix this by moving the memcpy() inside the if (p) block so it is only
executed when a valid ssid ie is actually found.

Fixes: 370730894bec ("Staging: rtl8723bs: rtw_wlan_util: Add size check of SSID IE")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 6a7c09db4cd9..2a8aec37d9b0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1204,8 +1204,8 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 		ssid_len = *(p + 1);
 		if (ssid_len > NDIS_802_11_LENGTH_SSID)
 			ssid_len = 0;
+		memcpy(bssid->ssid.ssid, (p + 2), ssid_len);
 	}
-	memcpy(bssid->ssid.ssid, (p + 2), ssid_len);
 	bssid->ssid.ssid_length = ssid_len;
 
 	if (memcmp(bssid->ssid.ssid, cur_network->network.ssid.ssid, 32) ||
-- 
2.53.0


