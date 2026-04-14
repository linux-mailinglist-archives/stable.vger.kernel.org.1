Return-Path: <stable+bounces-237964-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCT3Is+a3mlrGQAAu9opvQ
	(envelope-from <stable+bounces-237964-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:51:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E63FE1F8
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36AA7301A3B7
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 19:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF891314D05;
	Tue, 14 Apr 2026 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RhgsFDce"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE1314A9F
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196230; cv=none; b=A/IEhkhtMBhdLByijrQ/5gFhoMzcASHWoon9+KQd2dWrlK9+AGcxa0gCY+T/tJfs3eJE5vA0qpoHGmXXMlp0WtOITLs+eKRyChOjVXGBdC2empjT6EisPlDTLcj9J2bLnDmZP8X3gTfVp+6UgEi+9kaSSFNYly5kVYul+Hi+9lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196230; c=relaxed/simple;
	bh=DyX43exB3N4Ushpdz+THDY2bHaGuN0iQC+jFFQtUJ0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNiV7jx/2mfX8I5QWm6ifsuDZLA2Ew/D2QC6BYAUFXfndnZY2sayNqAPxSZVn6RdIABDMdrLExy+zL5yMvu/BDVs/KirbXQwCKf2t6omV114d+8Kypdz+MFhB7GzEDlrckGdIqCQHioYxwcu3AFikFu8lRfB5khPE+KzNDCTU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RhgsFDce; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776196225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8QvIvx3H+LYLSfWoOm3kOLIVw0Q8gYITocuslFEHp9U=;
	b=RhgsFDce0RPAj6D1HIpLprtRbVMJvaevavHTvjBbi3cWqST+NCmAzTjeMPyOe6eNgM8PNt
	Z8vMD6eHZFsVRZz/qOppJOEisINnRnS/u2R+zhdm6GUgl3NnCTK1oEuEd7EipqONvrSJ21
	9Asdn0Szfn6cy1Mm9QEgaxx3m2YE6+o=
From: luka.gejak@linux.dev
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luka Gejak <luka.gejak@linux.dev>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix remote heap information disclosure in issue_assocreq
Date: Tue, 14 Apr 2026 21:49:45 +0200
Message-ID: <20260414194945.138626-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237964-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD5E63FE1F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

When building an association request frame, the driver copies the
ht capability ie using the attacker-controlled pIE->length from the
ap's beacon. If the ap provides a length greater than the size of
struct HT_caps_element (26 bytes), it causes an out-of-bounds read
of the adjacent heap memory (HT_info and network structures).
This uninitialized or sensitive memory is then transmitted over the air,
resulting in a remote heap information disclosure.

Fix this by clamping the length passed to rtw_set_ie() to the actual
size of struct HT_caps_element.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
Note: Note: Alignment of arguments in rtw_set_ie() is intentionally 
like that to avoid WARNING: line length of 105 exceeds 100 columns.

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 5f00fe282d1b..a5f30c3fd47e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -2954,7 +2954,9 @@ void issue_assocreq(struct adapter *padapter)
 			if (padapter->mlmepriv.htpriv.ht_option) {
 				if (!(is_ap_in_tkip(padapter))) {
 					memcpy(&(pmlmeinfo->HT_caps), pIE->data, sizeof(struct HT_caps_element));
-					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY, pIE->length, (u8 *)(&(pmlmeinfo->HT_caps)), &(pattrib->pktlen));
+					pframe = rtw_set_ie(pframe, WLAN_EID_HT_CAPABILITY,
+					min_t(uint, pIE->length, sizeof(struct HT_caps_element)),
+					(u8 *)&pmlmeinfo->HT_caps, &pattrib->pktlen);
 				}
 			}
 			break;
-- 
2.53.0


