Return-Path: <stable+bounces-239170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOYNDiJR5mkDuwEAu9opvQ
	(envelope-from <stable+bounces-239170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:15:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8485D42F36D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55D79304B29E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CA4949EE;
	Mon, 20 Apr 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnk7IG7W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D0E4949E5;
	Mon, 20 Apr 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691942; cv=none; b=OfDlpcfS1y+pDzioywzEb5qpaFZY0Eg374oyVa3ak+en0PSNnnp8rTMrEloeqm+glwwIoybghysPGi6DthBvxi7R6JA2nfnsuWMszmnvE/HIcz1h7T7WXX+8N66ZJ+Y0Q14PFCFKEABoJKb/xvnIM0qxES1pkWJyuaxjmRpQGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691942; c=relaxed/simple;
	bh=KzYo12aYS3BCH19VKtE7E6iBBGrK9f6IPuWdL3PJ39Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2zR4FZPRBbF6htjmA9UDv14IRPo/h1/4B/+ysge9GAV4Z0+slvmw5LKLZfXFiHaTv4lVywd5qtGRyBhk8qzIzNVC5Tl1spA+JwQr2hQ683j/OtAl1uuMoxSHGQQt91d58ephpY77Z8mePTRv04vO8uIollf6vuR5gpqEygbZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnk7IG7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A0CC2BCB7;
	Mon, 20 Apr 2026 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691942;
	bh=KzYo12aYS3BCH19VKtE7E6iBBGrK9f6IPuWdL3PJ39Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bnk7IG7W6SbGAEcK5S4leTwy0uaZYYu9/ZiatDT7uNCITpYtBtP+ugZwmmyAchedU
	 Q40ondNlPHvwFMJ6DVON5h/wO1KDsaYBwAE8tHZdppqvXbVavA/9p39xX0CAWJ8h3I
	 CX7WmX1C/aNxLV+2C1/kp4s11iGTDOxXqWgtMUtGeO+1sX7TpKq4d7UtMVYUTBDTg6
	 7XKf4eTVznCXsQTlt3dwzbEcW0ssyhf+pfAsdft14bzPWRrOEpGxuPPvMKqUfanJ/v
	 86fkdFf3K/2I1TVVw3RA9NbaSB/570lkMcdEoQ+1CUq9ac01ZRsViaTPdybbrgM+BJ
	 sAme47cgJ5ytA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Even Xu <even.xu@intel.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] HID: Intel-thc-hid: Intel-quickspi: Add NVL Device IDs
Date: Mon, 20 Apr 2026 09:21:16 -0400
Message-ID: <20260420132314.1023554-282-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239170-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,intel.com:email]
X-Rspamd-Queue-Id: 8485D42F36D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Even Xu <even.xu@intel.com>

[ Upstream commit 48e91af0cbe942d50ef6257d850accdca1d01378 ]

Add Nova Lake THC QuickSPI device IDs to support list.

Signed-off-by: Even Xu <even.xu@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 6 ++++++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index 14cabd5dc6ddb..f0830a56d556b 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
@@ -37,6 +37,10 @@ struct quickspi_driver_data arl = {
 	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_MTL,
 };
 
+struct quickspi_driver_data nvl = {
+	.max_packet_size_value = MAX_PACKET_SIZE_VALUE_LNL,
+};
+
 /* THC QuickSPI ACPI method to get device properties */
 /* HIDSPI Method: {6e2ac436-0fcf-41af-a265-b32a220dcfab} */
 static guid_t hidspi_guid =
@@ -984,6 +988,8 @@ static const struct pci_device_id quickspi_pci_tbl[] = {
 	{PCI_DEVICE_DATA(INTEL, THC_WCL_DEVICE_ID_SPI_PORT2, &ptl), },
 	{PCI_DEVICE_DATA(INTEL, THC_ARL_DEVICE_ID_SPI_PORT1, &arl), },
 	{PCI_DEVICE_DATA(INTEL, THC_ARL_DEVICE_ID_SPI_PORT2, &arl), },
+	{PCI_DEVICE_DATA(INTEL, THC_NVL_H_DEVICE_ID_SPI_PORT1, &nvl), },
+	{PCI_DEVICE_DATA(INTEL, THC_NVL_H_DEVICE_ID_SPI_PORT2, &nvl), },
 	{}
 };
 MODULE_DEVICE_TABLE(pci, quickspi_pci_tbl);
diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
index c30e1a42eb098..bf5e18f5a5f42 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h
@@ -23,6 +23,8 @@
 #define PCI_DEVICE_ID_INTEL_THC_WCL_DEVICE_ID_SPI_PORT2 	0x4D4B
 #define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT1 	0x7749
 #define PCI_DEVICE_ID_INTEL_THC_ARL_DEVICE_ID_SPI_PORT2 	0x774B
+#define PCI_DEVICE_ID_INTEL_THC_NVL_H_DEVICE_ID_SPI_PORT1	0xD349
+#define PCI_DEVICE_ID_INTEL_THC_NVL_H_DEVICE_ID_SPI_PORT2	0xD34B
 
 /* HIDSPI special ACPI parameters DSM methods */
 #define ACPI_QUICKSPI_REVISION_NUM			2
-- 
2.53.0


