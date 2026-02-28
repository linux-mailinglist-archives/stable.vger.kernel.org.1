Return-Path: <stable+bounces-220411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCEEBqpIo2mm/AQAu9opvQ
	(envelope-from <stable+bounces-220411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFF21C7A0D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E95BC30BD410
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052B3AFC8B;
	Sat, 28 Feb 2026 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyzPMp8D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F483AFC83;
	Sat, 28 Feb 2026 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300302; cv=none; b=Aj0wSSUgZhxigou1xilqCL4Ihw3Dn/sbLSVDY4d9oe9jtVYA+WFYtPDqWI5qr/BWsn2Wz71C660/NNpiht0FtI4iZhlaJ7qRHyfFrHy896qQNsvmLxWleLH1FzgkTiP5scWK5E/s0D7wT0pvWUSte9a2AJdqt88UPthBIYGc8Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300302; c=relaxed/simple;
	bh=aijcopGcMNf6ly7LHvyf+1Uvz3pVBrbpfk0/UQrYOxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBPDObifBquJjKzWRgcUwx0rdS47JMrxEi/uGRFrlqt//Dej2VK46sj8Bx0jWOQKvT1no4lgsWqTkwkrEzGWLOfCOP/3/6sHTmAYqrldd4eoxIFCsOPNlbyUSElCVkta3zmR+J+VTE9hxo8fAimuWJ6V/OwGSpa8UA0iAxUD5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyzPMp8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D318CC19425;
	Sat, 28 Feb 2026 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300302;
	bh=aijcopGcMNf6ly7LHvyf+1Uvz3pVBrbpfk0/UQrYOxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyzPMp8D4IfARa8TYDHCN6rTk+tzQ5Ce+UHH8mbC4W8CLTefiLHC/EeJXJWBjsojl
	 Xy5n33eMagxlBTWrQLS/emkm0367RaJ8UsLX+Y1DPp+s3D+s6s/pScPXvDfkuutve6
	 zI4/m4s/rkAgArGVm/y9jd/oiYwF/2494mGUxT/VqKJjtEBWwVMadgVjOGdGGmNWbS
	 rqQ/nc0iVl67089mpwzpVTshKtkuu3yJxYk3QNe8dcjC/MnLWJcgDbKXImDsqPQ1LA
	 FXVqg5NnOaIRX8L4TotO+7+b+uMMrz35SAz4KgvAYEC7a0zDnIYYIGhVCnR9DtRckN
	 qkxjZZ4kbT8gQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Lucas Van <lucas.van@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 332/844] PCI/AER: Clear stale errors on reporting agents upon probe
Date: Sat, 28 Feb 2026 12:24:05 -0500
Message-ID: <20260228173244.1509663-333-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220411-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 3AFF21C7A0D
X-Rspamd-Action: no action

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit e242d09b58e869f86071b7889acace4cff215935 ]

Correctable and Uncorrectable Error Status Registers on reporting agents
are cleared upon PCI device enumeration in pci_aer_init() to flush past
events.  They're cleared again when an error is handled by the AER driver.

If an agent reports a new error after pci_aer_init() and before the AER
driver has probed on the corresponding Root Port or Root Complex Event
Collector, that error is not handled by the AER driver:  It clears the
Root Error Status Register on probe, but neglects to re-clear the
Correctable and Uncorrectable Error Status Registers on reporting agents.

The error will eventually be reported when another error occurs.  Which
is irritating because to an end user it appears as if the earlier error
has just happened.

Amend the AER driver to clear stale errors on reporting agents upon probe.

Skip reporting agents which have not invoked pci_aer_init() yet to avoid
using an uninitialized pdev->aer_cap.  They're recognizable by the error
bits in the Device Control register still being clear.

Reporting agents may execute pci_aer_init() after the AER driver has
probed, particularly when devices are hotplugged or removed/rescanned via
sysfs.  For this reason, it continues to be necessary that pci_aer_init()
clears Correctable and Uncorrectable Error Status Registers.

Reported-by: Lucas Van <lucas.van@intel.com> # off-list
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Lucas Van <lucas.van@intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Link: https://patch.msgid.link/3011c2ed30c11f858e35e29939add754adea7478.1769332702.git.lukas@wunner.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9472d86cef552..73cb6d587202c 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1605,6 +1605,20 @@ static void aer_disable_irq(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_COMMAND, reg32);
 }
 
+static int clear_status_iter(struct pci_dev *dev, void *data)
+{
+	u16 devctl;
+
+	/* Skip if pci_enable_pcie_error_reporting() hasn't been called yet */
+	pcie_capability_read_word(dev, PCI_EXP_DEVCTL, &devctl);
+	if (!(devctl & PCI_EXP_AER_FLAGS))
+		return 0;
+
+	pci_aer_clear_status(dev);
+	pcie_clear_device_status(dev);
+	return 0;
+}
+
 /**
  * aer_enable_rootport - enable Root Port's interrupts when receiving messages
  * @rpc: pointer to a Root Port data structure
@@ -1626,9 +1640,19 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pcie_capability_clear_word(pdev, PCI_EXP_RTCTL,
 				   SYSTEM_ERROR_INTR_ON_MESG_MASK);
 
-	/* Clear error status */
+	/* Clear error status of this Root Port or RCEC */
 	pci_read_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer + PCI_ERR_ROOT_STATUS, reg32);
+
+	/* Clear error status of agents reporting to this Root Port or RCEC */
+	if (reg32 & AER_ERR_STATUS_MASK) {
+		if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
+			pcie_walk_rcec(pdev, clear_status_iter, NULL);
+		else if (pdev->subordinate)
+			pci_walk_bus(pdev->subordinate, clear_status_iter,
+				     NULL);
+	}
+
 	pci_read_config_dword(pdev, aer + PCI_ERR_COR_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer + PCI_ERR_COR_STATUS, reg32);
 	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_STATUS, &reg32);
-- 
2.51.0


