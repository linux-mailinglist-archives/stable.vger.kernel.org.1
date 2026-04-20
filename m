Return-Path: <stable+bounces-239410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIXOB4tX5ml5vAEAu9opvQ
	(envelope-from <stable+bounces-239410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DBE42FE25
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DEF53390191
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38A332635;
	Mon, 20 Apr 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sryq3dk3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C22D77E5;
	Mon, 20 Apr 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700175; cv=none; b=iaWONlNxlbUwyxeJzTONDq/qHBgQP8K3obXuJyXVz9rrgCNKIZNlTIjDEZKsYuI77kORvOFqLWob6o/82PURkuoJkMgjqQxyjMgFFnmK6nuBEzhEUMkRqQE2SS0r0qlo9Tm9AqXIc3XXkg5UXoykJ2/kmsiKu1cAtdZevVBkNko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700175; c=relaxed/simple;
	bh=oDqYG3R+ssGjvK2eiTygbEzIGyPlYVQzgxJgIbUtELY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2IsKT3+DOrTnry1py/xj0kjFC4Ac6H/0cpEByjzdGnmuDtnz7aR2HhiU/xKSsOaDDCDnqKtHynRAC1WO+GT8qhHOnemtFLM07o0xbvTq6zyng+eHvCCrcCW5Qt19bVNOidH6jhjzY7hal6mro17SpvyTRQ/XQFGK0WLKB4qcww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sryq3dk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220C8C2BCB4;
	Mon, 20 Apr 2026 15:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700175;
	bh=oDqYG3R+ssGjvK2eiTygbEzIGyPlYVQzgxJgIbUtELY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sryq3dk3qJyq8/0pKfMxdBoswOfzI7OW1ybH4YYLciPhF3m0+v4Tk7YRoxIwnh2tf
	 m9RvoUT+1QNEZ/kBY33eX+wmgf7IgEGAF711yzbHx3iGaoFL/ZllzfxXdXTrPKhSQ+
	 TC0gO1/sGGAvGC3GHqd0vtMMW2GEz39a6DlAXn2k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Even Xu <even.xu@intel.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 038/220] HID: Intel-thc-hid: Intel-quickspi: Add NVL Device IDs
Date: Mon, 20 Apr 2026 17:39:39 +0200
Message-ID: <20260420153935.407080721@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239410-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.com:email]
X-Rspamd-Queue-Id: A3DBE42FE25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Even Xu <even.xu@intel.com>

[ Upstream commit 48e91af0cbe942d50ef6257d850accdca1d01378 ]

Add Nova Lake THC QuickSPI device IDs to support list.

Signed-off-by: Even Xu <even.xu@intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 6 ++++++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
index ad6bd59963b28..b6a69995692cb 100644
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
@@ -982,6 +986,8 @@ static const struct pci_device_id quickspi_pci_tbl[] = {
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




