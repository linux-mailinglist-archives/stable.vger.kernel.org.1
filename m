Return-Path: <stable+bounces-220612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNX/NuFPo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:28:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 270661C85F2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 309BB32C431B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE93B3E4C49;
	Sat, 28 Feb 2026 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNS1as3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7142A3E4C43;
	Sat, 28 Feb 2026 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300495; cv=none; b=rC0PKb3UYI9iqGBvDzdpbVJ8PGGkHEaf47SsCtVsCdLNvZqCJrby5X1UOa9RBsLKcNtlcSHk5bx61eoorAqG/sE0Lday3xVl32l2m39f+ZUgjj4T39xggN5dqcHDNSvELiOV13AGUOKdxTNF8t8mfCAigwuYSyNgTOkDMcAcdn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300495; c=relaxed/simple;
	bh=H0ovsNNbol36+Kife4HmUx+3WE90tqwXkjqiM5xAd+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQzB8FJzQCDeYqL1Hn49MtB5zfUceheuIxluH3fUESfKTFjhp83+uGsEEoDRiST+Rpk85PX5nes0UnR2S7dXrNDqBXGGMqdhhftjJh1NdSvw7632UJnmpAN5yRdk5IEbNbW/v2BA/NlRcvLUYNI6G9lXj2LQ8f5xCNRjqYrTBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNS1as3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E462C116D0;
	Sat, 28 Feb 2026 17:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300495;
	bh=H0ovsNNbol36+Kife4HmUx+3WE90tqwXkjqiM5xAd+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNS1as3nYMx/NT903vP91IA1NY9tTXiSq0BQ0N488IrgjfFiF0SgRxKPqerbxpj6/
	 bv7imBtxatf+uYGWgW3HmkIIdoflGgeGTw6xegh3fmnAfRoQ7fnyc4mBBZFEbcWIlb
	 wRcrp+I/SM3BAJod7Kpip+K8I13b/2BcJxVXya7BnQ8LEwzLl4nAaHXofDc4WhIi0r
	 plokd2nEz/wIurZ5ftyhBSV581mu/FoQgtNVn3HWT6Uqix9SxHmoeBf3xuFW6vNTWv
	 qg1rozxYHMlMecA1ZpOt/fFa63q5KelC1GoCpsbtnRvKovzv+yQP+/4CN7ifRc9H/t
	 TjoF8aCglks0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 533/844] PCI: Use resource_set_range() that correctly sets ->end
Date: Sat, 28 Feb 2026 12:27:26 -0500
Message-ID: <20260228173244.1509663-534-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.intel.com,google.com,intel.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-220612-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 270661C85F2
X-Rspamd-Action: no action

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 11721c45a8266a9d0c9684153d20e37159465f96 ]

__pci_read_base() sets resource start and end addresses when resource
is larger than 4G but pci_bus_addr_t or resource_size_t are not capable
of representing 64-bit PCI addresses. This creates a problematic
resource that has non-zero flags but the start and end addresses do not
yield to resource size of 0 but 1.

Replace custom resource addresses setup with resource_set_range()
that correctly sets end address as -1 which results in resource_size()
returning 0.

For consistency, also use resource_set_range() in the other branch that
does size based resource setup.

Fixes: 23b13bc76f35 ("PCI: Fail safely if we can't handle BARs larger than 4GB")
Link: https://lore.kernel.org/all/20251207215359.28895-1-ansuelsmth@gmail.com/T/#m990492684913c5a158ff0e5fc90697d8ad95351b
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: stable@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Link: https://patch.msgid.link/20251208145654.5294-1-ilpo.jarvinen@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c791bca2891f6..cd1cd044aaf9d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -287,8 +287,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8 || sizeof(resource_size_t) < 8)
 		    && sz64 > 0x100000000ULL) {
 			res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
-			res->start = 0;
-			res->end = 0;
+			resource_set_range(res, 0, 0);
 			pci_err(dev, "%s: can't handle BAR larger than 4GB (size %#010llx)\n",
 				res_name, (unsigned long long)sz64);
 			goto out;
@@ -297,8 +296,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		if ((sizeof(pci_bus_addr_t) < 8) && l) {
 			/* Above 32-bit boundary; try to reallocate */
 			res->flags |= IORESOURCE_UNSET;
-			res->start = 0;
-			res->end = sz64 - 1;
+			resource_set_range(res, 0, sz64);
 			pci_info(dev, "%s: can't handle BAR above 4GB (bus address %#010llx)\n",
 				 res_name, (unsigned long long)l64);
 			goto out;
-- 
2.51.0


