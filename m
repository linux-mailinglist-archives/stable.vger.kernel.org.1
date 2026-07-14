Return-Path: <stable+bounces-274582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQ3oHJmyVmpCAQEAu9opvQ
	(envelope-from <stable+bounces-274582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8961759200
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H1Zkstuv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274582-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274582-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5148C3046D7D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3015C42BC34;
	Tue, 14 Jul 2026 22:04:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEA926D4DD
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066669; cv=none; b=FcrkCioGxVdBLfb6PvFEZU/FrsL8yWUzOOEVkF3y7DMnRTBVb4LRssGaqOegth2SIOER4iJalatOwmwC+7PqPYw+MzTeQAZevbpY+kMSssQS3ENNpBgdaH7Kfc7cajU8Psk12ZgfscLmR+YKFUEO0E7yNHyUiVzPs2UIy/Tw3P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066669; c=relaxed/simple;
	bh=7ztOmE6yB9LZysYffcdXVd0rKFHw8ldDaFlDdfLkJAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep88Alxdl2DkLYrb7y6VLMkzCPs0pnoSI0rJCTUNeFWXc0FwHDj6M4jwkHJh0RP5AD5SKll3La/xcVksaYnJy1RcwOp7S1g6YuaeeM0oARpM+mypywVm4TDlKn2Hy7C8OsjeFVMqGf9Z9brYptfcLEJlXn53yQqgv+wH0d56pPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1Zkstuv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A541F000E9;
	Tue, 14 Jul 2026 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066667;
	bh=+SK7f5x6Bh0+AKXNLioqZRqctoeu33ZiCG/g+yRDI7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1Zkstuvc4IYleNiRANain9gB74as3Xy0i6fwZX+tveXkLIqIXX4ovu/V+wWfaBRU
	 4iPygh7jmFze6Dn6XXYWOahJ7txeFHQ/m3THh8ropMtpnbpuIvQopIaJQJS0e5J7Ic
	 KwolbJ+8rdaZcq55gceH1FAMk03M/ua4oJmEN75UvlDEWTty4ih4r8Py5V+x3blbKe
	 r/AMBAj1c11BFt5/hEPMp+DF1FESEilzJCwPEC2xX7pTcsSzYS2ZFl38FTcsI04t2s
	 jN9cEEucJIuLKOwoU4Xc1yUE7eaduTyZNqOykHibUltK6PWqKJTUiTn52BHfN9ZjsT
	 DduFUniY1z23Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Nenciarini <mnencia@kcore.it>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/6] PCI: Skip Resizable BAR restore on read error
Date: Tue, 14 Jul 2026 18:04:21 -0400
Message-ID: <20260714220421.3334071-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714220421.3334071-1-sashal@kernel.org>
References: <2026071358-dominoes-employee-70eb@gregkh>
 <20260714220421.3334071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mnencia@kcore.it,m:bhelgaas@google.com,m:sashal@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274582-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,kcore.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8961759200

From: Marco Nenciarini <mnencia@kcore.it>

[ Upstream commit ee7471fe968d210939be9046089a924cd23c8c3b ]

pci_restore_rebar_state() uses the Resizable BAR Control register to decide
how many BARs to restore (nbars) and which BAR each iteration addresses
(bar_idx).

When a device does not respond, config reads typically return
PCI_ERROR_RESPONSE (~0).  Both fields are 3 bits wide, so nbars and bar_idx
both evaluate to 7, past the spec's valid ranges for both fields.
pci_resource_n() then returns an unrelated resource slot, whose size is
used to derive a nonsensical value written back to the Resizable BAR
Control register.

Bail out if any Resizable BAR Control read returns PCI_ERROR_RESPONSE. No
further BARs are touched, which is safe because a config read that returns
PCI_ERROR_RESPONSE indicates the device is unreachable and restoration is
pointless.

Fixes: d3252ace0bc6 ("PCI: Restore resized BAR state on resume")
Signed-off-by: Marco Nenciarini <mnencia@kcore.it>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/666cac19b5daa0ab0e0ab64454e76b4d24465dbd.1776429882.git.mnencia@kcore.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/rebar.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/rebar.c b/drivers/pci/rebar.c
index 0d6efefdc56ade..548894a3fad5cf 100644
--- a/drivers/pci/rebar.c
+++ b/drivers/pci/rebar.c
@@ -130,6 +130,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		return;
 
 	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+	if (PCI_POSSIBLE_ERROR(ctrl))
+		return;
+
 	nbars = FIELD_GET(PCI_REBAR_CTRL_NBAR_MASK, ctrl);
 
 	for (i = 0; i < nbars; i++, pos += 8) {
@@ -137,6 +140,9 @@ void pci_restore_rebar_state(struct pci_dev *pdev)
 		int bar_idx, size;
 
 		pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
+		if (PCI_POSSIBLE_ERROR(ctrl))
+			return;
+
 		bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
 		res = pci_resource_n(pdev, bar_idx);
 		size = pci_rebar_bytes_to_size(resource_size(res));
-- 
2.53.0


