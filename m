Return-Path: <stable+bounces-274923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMtmNc90V2rqOQEAu9opvQ
	(envelope-from <stable+bounces-274923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:53:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7451175DCF3
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 13:53:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=auditcode.ai header.s=zmail header.b=Kfnqd5Ux;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274923-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274923-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=auditcode.ai;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D286030305F3
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374F44B68D;
	Wed, 15 Jul 2026 11:53:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from sender-op-o14.zoho.eu (sender-op-o14.zoho.eu [136.143.169.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD6544B68E;
	Wed, 15 Jul 2026 11:53:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116388; cv=pass; b=lo8g5FmNFaZHyi264C06jELUHyWXaAIQ+lm55vdMSnqTZhVBDqwyWnJlUPYVmUiW2w6oemAgICHevU6L825LH+zIBnzajPkNYBXt6Ip09TnIEb6YTfrtrkRydxafP5Zw4U7XTfdQxJu+PUvtdkDsFuX2D94GIx7zeAaRzq4mWDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116388; c=relaxed/simple;
	bh=pINyIWzhaJ5wek9YGWBKycRmYp3BXjDh7zICXUJHMjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dx9s/RE3IMjI8b/No2qBH8avmBtHB9Xv5PnCQIJy8GO3eSGEOalf99djaYX/Gv5C0nfXfmxmNjIuBL0RAtrwIO24gNfSmRNDOTxKnAZAcNgMAtXqudkemk/KLCbQdM4mxd0sROZCb/CjJDxyAuradfgpngYo6qmcUdm4pmEFMiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=auditcode.ai; spf=pass smtp.mailfrom=auditcode.ai; dkim=pass (1024-bit key) header.d=auditcode.ai header.i=security@auditcode.ai header.b=Kfnqd5Ux; arc=pass smtp.client-ip=136.143.169.14
ARC-Seal: i=1; a=rsa-sha256; t=1784116379; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VQ1sdCq1zhMNFyFdvtAl6k0jJl9RhkM1lP4ikIozZ+hc+CRK90u2WAt1fp/Waeudn8J1WsM3x5Io0U+F72VJ4IETc/B0uOZwjTaTrSLIWHF5rZccOBpPyKorGljcAaVhfoOfmgCcuZminyLjgGdWnyR7Z8JSxmoYxYLhGL9gNSE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1784116379; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NOEHxMXG+0zfMUSw72tu8yb7COwFsrc9wNjzUAHTNP8=; 
	b=Pge1H2EdZMp8s5k68XgJm0NINSoTbmx0i1qE1fXJrzH/dxCN8VjBWE5Xu1zB4Ofd/OPt4hHKV8P8LrIIvKRS82e0KotjLjKZzViosXK0vPGAeQugWXPVY3LWgGohP+AfUPqCNYrNTCcapAsodjYNhslEqko9QTakV0mHLt7YEIk=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=auditcode.ai;
	spf=pass  smtp.mailfrom=security@auditcode.ai;
	dmarc=pass header.from=<security@auditcode.ai>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784116379;
	s=zmail; d=auditcode.ai; i=security@auditcode.ai;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NOEHxMXG+0zfMUSw72tu8yb7COwFsrc9wNjzUAHTNP8=;
	b=Kfnqd5UxLj0SjqnOfofz6lyOAR2xP0xSNIp+04tMQ4NOSw+JHEDbVxNSuHuTVLfO
	jFSTpN8zoE56gkJgoBYQR6mr6+cx9ZA3t7/uIUni3kXu9SKESF/YZTDZ6fl9l5M7ypN
	FrsLGGFMUAIZZGo2m3UUaK1wE18ZP7cekouGiWC4=
Received: by mx.zoho.eu with SMTPS id 1784116376415893.6852670391315;
	Wed, 15 Jul 2026 13:52:56 +0200 (CEST)
From: Ibrahim Hashimov <security@auditcode.ai>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] HID: nintendo: fix out-of-bounds read in joycon_ctlr_read_handler()
Date: Wed, 15 Jul 2026 13:52:53 +0200
Message-ID: <20260715115253.91029-1-security@auditcode.ai>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[auditcode.ai,none];
	R_DKIM_ALLOW(-0.20)[auditcode.ai:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274923-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[security@auditcode.ai,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jikos@kernel.org,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@auditcode.ai,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[auditcode.ai:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,auditcode.ai:from_mime,auditcode.ai:mid,auditcode.ai:email,auditcode.ai:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7451175DCF3

joycon_ctlr_read_handler() casts an incoming HID input report to
struct joycon_input_report and parses it, guarding the cast only with a
12-byte length check:

	if (size >= 12) /* make sure it contains the input report */
		joycon_parse_report(ctlr, (struct joycon_input_report *)data);

struct joycon_input_report is 49 bytes: a 13-byte header followed by a
union whose IMU arm is 36 bytes. For an IMU report joycon_parse_report()
-> joycon_parse_imu_report() walks that union (struct offsets 13..48),
so a report of exactly 12 bytes with data[0] == JC_INPUT_IMU_DATA passes
the guard yet is read up to 37 bytes past its declared length. The
over-read bytes are decoded into accelerometer/gyroscope values and
forwarded to userspace through the "(IMU)" input device, leaking
driver-internal memory. data[0] and size are fully controlled by a
malicious or spoofed Joy-Con/Pro Controller.

Receive buffers are sized to the maximum report length, so this is an
over-read within the allocation rather than a slab OOB, but the decoded
bytes still reach userspace.

The sibling subcmd path in joycon_ctlr_handle_event() already bounds the
same cast correctly:

	if (size < sizeof(struct joycon_input_report) ||
	    data[0] != JC_INPUT_SUBCMD_REPLY)
		break;

Use the same sizeof(struct joycon_input_report) bound here.

Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
Assisted-by: AuditCode-AI:2026.07
---
 drivers/hid/hid-nintendo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index e7302ec01ff1..11b5fe05acf4 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2607,7 +2607,12 @@ static int joycon_ctlr_read_handler(struct joycon_ctlr *ctlr, u8 *data,
 {
 	if (data[0] == JC_INPUT_SUBCMD_REPLY || data[0] == JC_INPUT_IMU_DATA ||
 	    data[0] == JC_INPUT_MCU_DATA) {
-		if (size >= 12) /* make sure it contains the input report */
+		/*
+		 * The whole struct is cast and parsed below, including the
+		 * IMU/subcmd union, not just the 12-byte partial header this
+		 * used to check for.
+		 */
+		if (size >= sizeof(struct joycon_input_report))
 			joycon_parse_report(ctlr,
 					    (struct joycon_input_report *)data);
 	}
-- 
2.50.1 (Apple Git-155)

