Return-Path: <stable+bounces-274544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UfHHMC+WVmp8+QAAu9opvQ
	(envelope-from <stable+bounces-274544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:03:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE27758968
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Sygvlmn+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274544-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274544-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EB603072B44
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E1F41D63F;
	Tue, 14 Jul 2026 20:02:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80293F1AD3
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059366; cv=none; b=lbX9RQwVO4IaxAonnKgzb0sGAsN79EGnnQwWvs7mWS9g3qdKNSj7f4UkgMcxvVqEucWrHsWZMYZUHsXcBmgQlvZpNHZyYyjzcwOjCA4Eb24PkcG2Ipq6UFHzTjbKyTJF1zy7Gm64FeCS/JoryrYgOVTpz7qITdS5uk1qerrh6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059366; c=relaxed/simple;
	bh=n6fjsI7kaQvKFWti2AE14QXNqPiKPpdNmiUqQHXsjcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2IZiLOfC3zkEtI9kB/USXXnhyGEMOn9mkMorRZyegS/ySFB8P24AGnlL7KyV6FddSJ1GoWLXzVPtkH6FSmUVtCScpXZLdPCBcb5tQrRYrho43tIOUBJO2Fiz+i3XdRMOwbrKSoQT1zmsVsgp1vsd8lpX/0d4wArQkLcvEv5UVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sygvlmn+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135F61F00A3D;
	Tue, 14 Jul 2026 20:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059359;
	bh=uHvp0aIabr+fKPH0MJGuzi7fOhkqx1Xe+iBBHaXHnA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sygvlmn+8ZDkiIU546ga+qbdTEkqLoa5BHPIh/UerKj9UedtjCjdUDpAOqjSn4Ayi
	 I8WN6qA7InveNNDE4rq/XSp42UEuConKKE5cxjw/pQOC2elkxzmxDxtIdeBzdb029x
	 7dITI684Pd16ESeiWqXYU9O2DVO6YSOGYSqbirFFVSkYo56qRrk/IgMMTeZrur8ZDy
	 QbX7AD9vDOq9brx96PLtTiZxKwszESppo+8raUYObeil2qwTx831vSkuw6pU1LkXVF
	 fHuyColgooA1GGPtNSweZCxrB8OOLGi3quNSG/kwXu8vK5/M2gZ9LJv6QwI0ze5SPP
	 f502TDDHklKZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/8] PCI: Change pci_dev variable from 'bridge' to 'dev'
Date: Tue, 14 Jul 2026 16:02:30 -0400
Message-ID: <20260714200236.3153778-2-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-274544-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,msgid.link:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EE27758968

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 34c702ea0497e092a487eacdf28a037f43e3e39f ]

Upcoming fix to BAR resize will store also device BAR resource in the
saved list. Change the pci_dev variable in the loop from 'bridge' to
'dev' as the former would be misleading with non-bridges in the list.

This is in a separate change to reduce churn in the upcoming BAR resize
fix.

While it appears that the logic in the loop doing pci_setup_bridge() is
altered as 'bridge' variable is no longer updated, a bridge should never
appear more than once in the saved list so the check can only match to the
first entry. As such, the code with two distinct pci_dev variables better
represents the intention of the check compared with the old code where
bridge variable was reused for a different purpose.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://patch.msgid.link/20251113162628.5946-4-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-bus.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 522e25d725bad9..ae72a34b09c562 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2431,12 +2431,13 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 	}
 
 	list_for_each_entry(dev_res, &saved, list) {
+		struct pci_dev *dev = dev_res->dev;
+
 		/* Skip the bridge we just assigned resources for */
-		if (bridge == dev_res->dev)
+		if (bridge == dev)
 			continue;
 
-		bridge = dev_res->dev;
-		pci_setup_bridge(bridge->subordinate);
+		pci_setup_bridge(dev->subordinate);
 	}
 
 	free_list(&saved);
@@ -2452,19 +2453,19 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 	/* Revert to the old configuration */
 	list_for_each_entry(dev_res, &saved, list) {
 		struct resource *res = dev_res->res;
+		struct pci_dev *dev = dev_res->dev;
 
-		bridge = dev_res->dev;
-		i = pci_resource_num(bridge, res);
+		i = pci_resource_num(dev, res);
 
 		if (res->parent) {
 			release_child_resources(res);
-			pci_release_resource(bridge, i);
+			pci_release_resource(dev, i);
 		}
 
 		restore_dev_resource(dev_res);
 
-		pci_claim_resource(bridge, i);
-		pci_setup_bridge(bridge->subordinate);
+		pci_claim_resource(dev, i);
+		pci_setup_bridge(dev->subordinate);
 	}
 	free_list(&saved);
 	up_read(&pci_bus_sem);
-- 
2.53.0


