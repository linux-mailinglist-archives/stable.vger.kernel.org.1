Return-Path: <stable+bounces-274546-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xkWHHyaWVmpy+QAAu9opvQ
	(envelope-from <stable+bounces-274546-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:03:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396D75895F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:03:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GZPZ7e0l;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274546-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274546-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 293D33020B5A
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43441D647;
	Tue, 14 Jul 2026 20:02:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C841D643
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059368; cv=none; b=W9ClllYFVaYQ2TsIie9WFHuoP2m86asgLsw0TEuv9tqqp/typ7CyMad+N5wZrrfoeAgNt+T13XFpuqybZ8jEpkYEigcVJHAVUd5yh2m3S8A7zg+UIZ11+u7OUqdJ106GlyqP6FW4rUzsV33Qas0zMY3Fk8+d1F87eqtBlqmfCj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059368; c=relaxed/simple;
	bh=zkbq/Fi+/TGY0Uz8DWeP7AmPR6QTcCXf5z8eqpVYKAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcybHtKhY0ULhVBdUxCMEUGf8uuLCHxHvfBcXbGqADKXC5faoavGhvpdJtGmnybuL0YepqnHbw0NcUVPLMjWcSZYjOW16QCWKb7AJdSVP5IZIvUZkYuTwQWCr4Gc+7LAVcsZX/757VGLTChEQ+qeoognn1ENvZV7R0V2hNRBpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZPZ7e0l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA8C1F00AC4;
	Tue, 14 Jul 2026 20:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059360;
	bh=f/8phhMD9CGQ/X+ekW646XtIa++rbiFpQGa4NFaqK9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GZPZ7e0lmJg100cpiMrPf7yNJN41v2sEWC5gkJ5v5J/imPMPLqMYy2wC93NZApymZ
	 yZXo4hmMgqCqhTq2Y2eRVYyQaerPI/f5OD+E7qnF1iv2zSGoyuN2ImOw2bmU1azXLm
	 Lpug/CD8+k9a4dQibK0ksisj+wWz9QifQE/6G5AIsbwaTCtmKDV80I6blrQS7QFU+G
	 xx2PcGqDjFqrSeH4zrL3NuI4v40M1LPmiOc6rKn1uHr9TVZ8Z8aT8mIhgF2xyRHpcs
	 T5z+zUYwcs12WG4rZBpjDObOS7zqtpA9PCYIroIrRu6kg8wgQhT7vyVcp58gXRgc/I
	 IQKsydj5Kr36w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/8] PCI: Try BAR resize even when no window was released
Date: Tue, 14 Jul 2026 16:02:31 -0400
Message-ID: <20260714200236.3153778-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200236.3153778-1-sashal@kernel.org>
References: <2026071350-unfold-lather-d66a@gregkh>
 <20260714200236.3153778-1-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-274546-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linaro.org:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7396D75895F

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 121d3e9e4b217f2f23715901fb15c6a3ca2bab46 ]

Usually, resizing BARs requires releasing bridge windows in order to
resize it to fit a larger BAR into the window. This is not always the
case, however, FW could have made the window large enough to accommodate
larger BAR as is, or the user might prefer to shrink a BAR to make more
space for another Resizable BAR.

Thus, replace the check that requires that at least one bridge window
was released with a check that simply ensures bridge is not NULL.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-5-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ae72a34b09c562..55f3ac3f3eb1cc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2376,7 +2376,7 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 {
 	unsigned long type = res->flags;
 	struct pci_dev_resource *dev_res;
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	LIST_HEAD(saved);
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
@@ -2411,10 +2411,8 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 		bus = bus->parent;
 	}
 
-	if (list_empty(&saved)) {
-		up_read(&pci_bus_sem);
+	if (!bridge)
 		return -ENOENT;
-	}
 
 	__pci_bus_size_bridges(bridge->subordinate, &added);
 	__pci_bridge_assign_resources(bridge, &added, &failed);
-- 
2.53.0


