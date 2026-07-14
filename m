Return-Path: <stable+bounces-274580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l5sKBaqyVmpJAQEAu9opvQ
	(envelope-from <stable+bounces-274580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1429D759216
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:05:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X45n722F;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274580-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274580-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F4D9301C5EA
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C5842BC54;
	Tue, 14 Jul 2026 22:04:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA442BC4F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066666; cv=none; b=Mmt5IVxxnbyBu6RfKHmMHFtmmlmNanVeY+X4cn26fO4zW0Vx/745eyW7ypRC3dDlcLA9tKIOIvEPu4KUXlTPPMm7g2VXvy4qwUGDjdaOErRqagSIFrfqcOWNzG47vxwFPLlT2Vo1Z8C3tYpg90QLT8qOa+sJVdsWKNamTKPnQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066666; c=relaxed/simple;
	bh=GKamvIrydQVBRiEqPC81D9MVMbFCHcNW2OhbVUUIYl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LiapAUqgxC1yycJcITY2Z2lVd5CNfb46O/13AWEN7OdbOVuZwh50UOxC45/nQEz59IUdR2AGtUdjgZFGUi0lR17eD4CTlMBxDGe2zTNivanYWUSfdQFxClnpxxj1gHawc8zPWPsicBqeC6SeRAPAStoNrn6yJdMUiEgfthtWTsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X45n722F; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C8E1F00A3E;
	Tue, 14 Jul 2026 22:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066665;
	bh=VtWbKXeUgjVNU037TTpMKnxhBp+P/wzxvZPQBvJWxfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X45n722FPW8lv9MFIDB0ZOvKUVoNgQV7GovREzE1JVbCFpT/pRqOyys9xj/0nIflV
	 2z4oqR29SaVQeWCG8Ys1iFqzcnDE/J9H6TdI1FQ7VIj+GwwEL4cPauubqt/lUNrF7E
	 Eu3Lf+qATgO53uXC6zXgteJ4krKGt4/qhE7EiBHoD+rlnv8A8akurk8o96KcBSEYXt
	 KyHzgKJ7axscX6rQ4GhTFlSLc8BM7yEp+dNrJIDw1E+Xhe3yAqdsueNdW/CwZNBuC/
	 JcceL5HcRwHAsWrOd/bR7+LJsYxinBZuDyH/sMMe7DIkqKmBY6YnvXm4WYgBBCSYk4
	 0M+rHumBf8nmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] PCI: Free saved list without holding pci_bus_sem
Date: Tue, 14 Jul 2026 18:04:18 -0400
Message-ID: <20260714220421.3334071-3-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:ilpo.jarvinen@linux.intel.com,m:bhelgaas@google.com,m:alex.bennee@linaro.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274580-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1429D759216

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 1d8a0506f69895b7cfd9d5c4546761c508231a8a ]

Freeing the saved list does not require holding pci_bus_sem, so the
critical section can be made shorter.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-6-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 58dddb8b4d1d2f..fdfac3b49bcc0c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2400,8 +2400,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		pci_claim_resource(bridge, i);
 		pci_setup_bridge(bridge->subordinate);
 	}
-	free_list(&saved);
 	up_read(&pci_bus_sem);
+	free_list(&saved);
 
 	return ret;
 }
-- 
2.53.0


