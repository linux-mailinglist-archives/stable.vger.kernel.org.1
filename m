Return-Path: <stable+bounces-221587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGMIFGaZo2kwIAUAu9opvQ
	(envelope-from <stable+bounces-221587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:41:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C77091CB62F
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FD9531C56C6
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AED2BD030;
	Sun,  1 Mar 2026 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH/xY92u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE513B58A;
	Sun,  1 Mar 2026 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328648; cv=none; b=c+kiFBnPmmidg+CtlUyoCym3W7NkNA/9HVXuRTvovS+GDN/422j/kedIYiXbBxIaL+AXcqfUkdK8d92O/SSceBVevTgLkAzTRqeey3k+Ixk6s6iRd3o37cxZAWqQ7E2s5uPefPJW8IJpQR0CO0BoUiJVBC3jUDOsrTrKtarKLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328648; c=relaxed/simple;
	bh=QQNqQy+c9NHqoKa20Up8OGm3l8I+Fz+aWKoCMSX2ZDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G/dvf8l3MZ37kSXeh0cIt1cA2PWFikgPZrVMbubLfcRhgTosqQHsUry/v5iIjmsYp/jRUWvazMxaIMlbBlLdbGepTV+fllEwZWqHL5Jn50O4Q0ErUNveRQBYhJiqjtCJW1Cs0xLksc88hM3arPSY7FDMciNCxP0P+aO3LkP/430=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH/xY92u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C8CC19421;
	Sun,  1 Mar 2026 01:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328648;
	bh=QQNqQy+c9NHqoKa20Up8OGm3l8I+Fz+aWKoCMSX2ZDs=;
	h=From:To:Cc:Subject:Date:From;
	b=XH/xY92uyuu/bueOd5kvUpLeA7Bj3vkG5SlTN1KCviq+rEfRG0pjJMO+RJ66QEMpN
	 kIyLlgMU848FEnf++krGPYHTnM8kQnsDFjTrZ6w1woQ1dzcW/h0pbrYaVAtph6w12w
	 ohaBWib23v2KHfKHiW65JM5DRaTclTSAXn6S8+Z5db0rSQOGuA39D4TrYP8Faj0vuM
	 4DHGObpvGy0vBK47UkvLTd/fN9Q+RcSt+BIUqsBAtvVDMy7m1b1B8GsXCi2mu5wILH
	 vDF2+LfCzLIOTbIOIhVtayiOyGSmUTtVQQ6Ba+oDiOtp+bJnf9R4wtJIZ3YgjYml7w
	 LOSzkpJzy4z8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org
Subject: FAILED: Patch "PCI: Use resource_set_range() that correctly sets ->end" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:30:46 -0500
Message-ID: <20260301013046.1689049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,intel.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-221587-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C77091CB62F
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 11721c45a8266a9d0c9684153d20e37159465f96 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Dec 2025 16:56:54 +0200
Subject: [PATCH] PCI: Use resource_set_range() that correctly sets ->end
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/pci/probe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d9..ad5ae05aad3c8 100644
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





