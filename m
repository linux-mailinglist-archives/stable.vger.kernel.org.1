Return-Path: <stable+bounces-258247-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOgUJH8kG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258247-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:55:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B94610A62
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1E5D300678E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2AA261B9E;
	Sat, 30 May 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGi5+ne9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B70341AC7;
	Sat, 30 May 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163709; cv=none; b=RAbYjKIPLY9zBxmjPyc2Uha4AMmdWSSfc8ux7DuYkv+5ZdkkIVAb4I7DFFB/W93uSCy/kSJWyiN9hyDles7Xh6z5vcKqjR3vTcSJfQAi3C5vb604rRqrWLy+QqtUU34IgCKSh0riQKII6HhK68bq9ue738TIxtNpbGmI3ym6aPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163709; c=relaxed/simple;
	bh=drW4+MLtI7IamaDzFKQQ7Z+GWsSdzhWt28t7ii2M/EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=au4RdT+pr+0dUpa4bAbZqOv4HYUfvvmvIXXFb0dzH0R24wOf7uO75Xu9JIQgfJCRR8kwZlIF10VINQ04svSqyVRvTWimZkPV/vntKeMdl0KNksFxC03LuGBsO5RsjNaBhVeF+Tj9x5d+3idTexm4iUcHr2Ey6fLTbYY7zPKFnbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGi5+ne9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7698B1F00893;
	Sat, 30 May 2026 17:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163708;
	bh=FHgWuEPI4bqSmSORRBOFYGxCQ3jy1OfBHJKJ+Dv6gFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AGi5+ne9IgKhwDIrGLm+uWIAfykFmLkrGtemgnatDXNNmUaFKyJi8kuPg0NE7O0tD
	 Ndg64Yx567sHCLE1Ad92GV1sOprLSvzTxMfF1NghzMaLp5+V3q6+0xR3j5ht/LRuAe
	 pinNYbB91YG0MNpuhqiBDlYdc1jLUAUVh0GVAOTc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH 5.15 339/776] PCI/AER: Clear only error bits in PCIe Device Status
Date: Sat, 30 May 2026 18:00:53 +0200
Message-ID: <20260530160249.334119394@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258247-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,alibaba.com:email,intel.com:email]
X-Rspamd-Queue-Id: 41B94610A62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuai Xue <xueshuai@linux.alibaba.com>

commit a8aeea1bf3c80cc87983689e0118770e019bd4f3 upstream.

Currently, pcie_clear_device_status() clears the entire PCIe Device Status
register (PCI_EXP_DEVSTA) by writing back the value read from the register,
which affects not only the error status bits but also other writable bits.

According to PCIe r7.0, sec 7.5.3.5, this register contains:

  - RW1C error status bits (CED, NFED, FED, URD at bits 0-3): These are the
    four error status bits that need to be cleared.

  - Read-only bits (AUXPD at bit 4, TRPND at bit 5): Writing to these has
    no effect.

  - Emergency Power Reduction Detected (bit 6): A RW1C non-error bit
    introduced in PCIe r5.0 (2019). This is currently the only writable
    non-error bit in the Device Status register. Unconditionally clearing
    this bit can interfere with other software components that rely on this
    power management indication.

  - Reserved bits (RsvdZ): These bits are required to be written as zero.
    Writing 1s to them (as the current implementation may do) violates the
    specification.

To prevent unintended side effects, modify pcie_clear_device_status() to
only write 1s to the four error status bits (CED, NFED, FED, URD), leaving
the Emergency Power Reduction Detected bit and reserved bits unaffected.

Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260211124624.49656-1-xueshuai@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2220,10 +2220,9 @@ EXPORT_SYMBOL_GPL(pci_set_pcie_reset_sta
 
 void pcie_clear_device_status(struct pci_dev *dev)
 {
-	u16 sta;
-
-	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
-	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
+	pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
+				   PCI_EXP_DEVSTA_CED | PCI_EXP_DEVSTA_NFED |
+				   PCI_EXP_DEVSTA_FED | PCI_EXP_DEVSTA_URD);
 }
 
 /**



