Return-Path: <stable+bounces-229495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPU7Ou1fwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 813522F6D1D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7854E30FCEEE
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791AE3B6360;
	Mon, 23 Mar 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaiEFRRj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EA23E33D;
	Mon, 23 Mar 2026 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279416; cv=none; b=ZLm6ucdITY4mcOMb4+tmlkr1oS1f5KuAhz/mMKJNNeBYhOfbGRTUv1dGmah0YGxff0zAskGtW6SD5zWSvTUYR0g27oIACiHinvRcdCgVFS2wvkm4aFltqLz+BDPTQlXP5TBYCmt1Imp70ZLdna1mNSFsIJ1nMkfG1aMx6OIM4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279416; c=relaxed/simple;
	bh=OyGyeMik9fWY0UMfEEKimu1ZZ8LLsFlXz0ylexkhzBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pydeEtLFCpv6iURXLs3PhNc9xb54Yiq2ZXCMBH3lkh8gvnVxUwiIH+7JH1Tu8Ya2asd+JAQLvzFNUC5K2MCYxl/V0Y1JKTIjqF0EblBqgPv7WH+ReCELnN/5S6X+6WezMmyvCobxJ5JIVfUy02RBJ/vJxMdg5GIw/APyiwNHnlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaiEFRRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7CCC4CEF7;
	Mon, 23 Mar 2026 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279416;
	bh=OyGyeMik9fWY0UMfEEKimu1ZZ8LLsFlXz0ylexkhzBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PaiEFRRjpve8nF5TYgr9lUIVSX0sm8GgcahNMaxT8Jlmc2wuf6a9JS7XYRN7FpgS4
	 fR/4ualvZgQlBd12c1ig+lM0vLyd0cEGCFDlSEAY3W3Eo0fsv5JE+oNxOjDbhdmPq/
	 nXPh68ogaHzoPZeqhpK/2L6UyybOp3H4CPsMfuh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Puranjay Mohan <puranjay12@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 022/481] PCI: Update BAR # and window messages
Date: Mon, 23 Mar 2026 14:40:04 +0100
Message-ID: <20260323134525.784672230@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-229495-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,google.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 813522F6D1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Puranjay Mohan <puranjay12@gmail.com>

[ Upstream commit 65f8e0beac5a495b8f3b387add1f9f4470678cb5 ]

The PCI log messages print the register offsets at some places and BAR
numbers at other places. There is no uniformity in this logging mechanism.
It would be better to print names than register offsets.

Add a helper function that aids in printing more meaningful information
about the BAR numbers like "VF BAR", "ROM", "bridge window", etc.  This
function can be called while printing PCI log messages.

[bhelgaas: fold in Lukas' static array suggestion from
https: //lore.kernel.org/all/20211106115831.GA7452@wunner.de/]
Link: https://lore.kernel.org/r/20211106112606.192563-2-puranjay12@gmail.com
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Stable-dep-of: 11721c45a826 ("PCI: Use resource_set_range() that correctly sets ->end")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h |  2 ++
 2 files changed, 62 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 516eaec6488de..2975a5c781df4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -844,6 +844,66 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
 }
 EXPORT_SYMBOL(pci_find_resource);
 
+/**
+ * pci_resource_name - Return the name of the PCI resource
+ * @dev: PCI device to query
+ * @i: index of the resource
+ *
+ * Return the standard PCI resource (BAR) name according to their index.
+ */
+const char *pci_resource_name(struct pci_dev *dev, unsigned int i)
+{
+	static const char * const bar_name[] = {
+		"BAR 0",
+		"BAR 1",
+		"BAR 2",
+		"BAR 3",
+		"BAR 4",
+		"BAR 5",
+		"ROM",
+#ifdef CONFIG_PCI_IOV
+		"VF BAR 0",
+		"VF BAR 1",
+		"VF BAR 2",
+		"VF BAR 3",
+		"VF BAR 4",
+		"VF BAR 5",
+#endif
+		"bridge window",	/* "io" included in %pR */
+		"bridge window",	/* "mem" included in %pR */
+		"bridge window",	/* "mem pref" included in %pR */
+	};
+	static const char * const cardbus_name[] = {
+		"BAR 1",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+#ifdef CONFIG_PCI_IOV
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+		"unknown",
+#endif
+		"CardBus bridge window 0",	/* I/O */
+		"CardBus bridge window 1",	/* I/O */
+		"CardBus bridge window 0",	/* mem */
+		"CardBus bridge window 1",	/* mem */
+	};
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS &&
+	    i < ARRAY_SIZE(cardbus_name))
+		return cardbus_name[i];
+
+	if (i < ARRAY_SIZE(bar_name))
+		return bar_name[i];
+
+	return "unknown";
+}
+
 /**
  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
  * @dev: the PCI device to operate on
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fc760fd3ad948..4fb02de24271b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -251,6 +251,8 @@ void __pci_bus_assign_resources(const struct pci_bus *bus,
 				struct list_head *fail_head);
 bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
 
+const char *pci_resource_name(struct pci_dev *dev, unsigned int i);
+
 void pci_reassigndev_resource_alignment(struct pci_dev *dev);
 void pci_disable_bridge_window(struct pci_dev *dev);
 struct pci_bus *pci_bus_get(struct pci_bus *bus);
-- 
2.51.0




