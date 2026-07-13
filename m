Return-Path: <stable+bounces-274033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0l6rNFlmVWqPnwAAu9opvQ
	(envelope-from <stable+bounces-274033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 00:27:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A81D74F7CC
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 00:27:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274033-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-274033-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E4A53028C6B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B6938AC92;
	Mon, 13 Jul 2026 22:27:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C06D2ED870
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 22:27:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981655; cv=none; b=o/4sh0QhLTddiDtq0lQtdjRXslVN2l8mJceYCBkLsAu7XRqN7dMei5RD9UQB5TMe6/H0WxnBcn7a7dVQD+p/Df+VmtNiQOwo4oKym07kKA2jZutbroHo6uf5MS43ak3wd1knQP7X8Ot40RfrzlmEROJuuc1YMHtqH/pJsoyQHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981655; c=relaxed/simple;
	bh=BPUbe4TsjMUBZtrWH9Dy4qFUI5sRAEfUFCY1Auk9u+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uafa+Hvm3Vb8Omn7WdCIKh//h9uyyxWqWUFuFovcvF/k30HujX05Bkq5c/aCohL9+c5GM1t1Z2r2OiXLlFwBVaeAcOl9aYRG/1kLEv6778j3CxP5ueo8+bqAYaOM4AG33ET0b56nKzYnafXtK1OKKfmOUc/CRJKeZGJQ3oCvjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 69D2292009C; Tue, 14 Jul 2026 00:27:30 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: stable@vger.kernel.org
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: [PATCH 6.6.y] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Mon, 13 Jul 2026 23:27:26 +0100
Message-Id: <20260713222726.28158-1-macro@orcam.me.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2026071351-buffoon-parameter-8f6b@gregkh>
References: <2026071351-buffoon-parameter-8f6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	TAGGED_FROM(0.00)[bounces-274033-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:macro@orcam.me.uk,m:bhelgaas@google.com,m:alok.a.tiwari@oracle.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,orcam.me.uk:from_mime,orcam.me.uk:email,orcam.me.uk:mid,msgid.link:url,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A81D74F7CC

commit 72780f7964684939d7d2f69c348876213b184484 upstream.

Discard Vendor:Device ID matching in the PCIe failed link retraining quirk
and ignore the link status for the removal of the 2.5GT/s speed clamp,
whether applied by the quirk itself or the firmware earlier on.  Revert to
the original target link speed if this final link retraining has failed.

This is so that link training noise in hot-plug scenarios does not make a
link remain clamped to the 2.5GT/s speed where an event race has led the
quirk to apply the speed clamp for one device, only to leave it in place
for a subsequent device to be plugged in.

Refer to the Link Capabilities register directly for the maximum link speed
determination so as to streamline backporting.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: stable@vger.kernel.org # v6.5+
Link: https://patch.msgid.link/alpine.DEB.2.21.2512080331530.49654@angie.orcam.me.uk
[ Update for missing PCIe link speed helpers for 6.6.y. ]
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/pci/quirks.c | 51 +++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 5df3a6ea6601..28fa0a9b18c8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -68,11 +68,10 @@
  * Restrict the speed to 2.5GT/s then with the Target Link Speed field,
  * request a retrain and check the result.
  *
- * If this turns out successful and we know by the Vendor:Device ID it is
- * safe to do so, then lift the restriction, letting the devices negotiate
- * a higher speed.  Also check for a similar 2.5GT/s speed restriction the
- * firmware may have already arranged and lift it with ports that already
- * report their data link being up.
+ * If this turns out successful, or where a 2.5GT/s speed restriction has
+ * been previously arranged by the firmware and the port reports its link
+ * already being up, lift the restriction, in a hope it is safe to do so,
+ * letting the devices negotiate a higher speed.
  *
  * Otherwise revert the speed to the original setting and request a retrain
  * again to remove any residual state, ignoring the result as it's supposed
@@ -83,12 +82,9 @@
  */
 int pcie_failed_link_retrain(struct pci_dev *dev)
 {
-	static const struct pci_device_id ids[] = {
-		{ PCI_VDEVICE(ASMEDIA, 0x2824) }, /* ASMedia ASM2824 */
-		{}
-	};
-	u16 lnksta, lnkctl2;
+	u16 lnksta, lnkctl2, oldlnkctl2;
 	int ret = -ENOTTY;
+	u32 lnkcap;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
@@ -96,10 +92,9 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 
 	pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
 	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+	oldlnkctl2 = lnkctl2;
 	if ((lnksta & (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_DLLLA)) ==
 	    PCI_EXP_LNKSTA_LBMS) {
-		u16 oldlnkctl2 = lnkctl2;
-
 		pci_info(dev, "broken device, retraining non-functional downstream link at 2.5GT/s\n");
 
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
@@ -107,35 +102,29 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
 		ret = pcie_retrain_link(dev, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			pcie_capability_write_word(dev, PCI_EXP_LNKCTL2,
-						   oldlnkctl2);
-			pcie_retrain_link(dev, true);
-			return ret;
-		}
-
-		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
+		if (ret)
+			goto err;
 	}
 
-	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    pci_match_id(ids, dev)) {
-		u32 lnkcap;
-
+	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
+	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
+	    (lnkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB) {
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
 		lnkctl2 &= ~PCI_EXP_LNKCTL2_TLS;
 		lnkctl2 |= lnkcap & PCI_EXP_LNKCAP_SLS;
 		pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, lnkctl2);
 
 		ret = pcie_retrain_link(dev, false);
-		if (ret) {
-			pci_info(dev, "retraining failed\n");
-			return ret;
-		}
+		if (ret)
+			goto err;
 	}
 
+	return ret;
+err:
+	pci_info(dev, "retraining failed\n");
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, oldlnkctl2);
+
+	pcie_retrain_link(dev, true);
 	return ret;
 }
 
-- 
2.20.1


