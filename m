Return-Path: <stable+bounces-23722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB8F867A44
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 16:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F0A28F819
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 15:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33E12AAE1;
	Mon, 26 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LCgJpQci"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2712B12AADB;
	Mon, 26 Feb 2024 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961336; cv=fail; b=UxCdyJ84XKzDr5QwytMBEWMZllflqC3XcScYh1CntIhRwsGA5MCI3a8HJguLM+mLQd/khvkXF93niSETrO4nU+ZgPKjEqzsYN/AJo0bljFNJAXU8UJ0JYjB39nWhDyVgscsMJcwCCpozJvPetPe6r0AZmneXaM7WWnbFgzrBlO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961336; c=relaxed/simple;
	bh=YdMZS1UtMHwbAVJzQNo1XNWROuUDykI7hC/xrF95oKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dn/6XcHDTTFFt1DHOZNhPGVHBv2dc5o2ljwIaVyWzUM5q8BDM8DDeAC0gyODNaIzM+PxlCrzrXO4itTMaYOhzqSusyTgkTVRYT3HoLUVRCnC8RhiVpvaiQV8/tN3YHZKr/GcN/xqkIvsBqgXIsoy3MZdR+Cx4FjF9DOCN3e1Ob8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LCgJpQci; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuB4zRVHCtyJyq70Tmp+PrSwyHQuLPfA4jw/pVu9t8Zsxo5moQDYKXpix8wtB7ofh8ilhH9riEFryVs6TiQKP4oLZgkUwxuFZPz4xTGfVZ3bGM3KCMfCkIPMvWDMiGFbkhc14S3ZwyWDxV27FSjFvIgN5TgGVOnQV95vZUzeuSZZcV0Q3L2hV1gUwo73HoARL8bny9n9dlrHLt2ZhamQ0VoYKY0DmekfxRKwr1L1mzdCBUakGRp7RHv9VzBg5Gjx0GfabOgA1+5d+mCh1Wa1KfIzvhw12KVcNrWvTffO+JIcqB2obclqL4POqtspYxQjzMRqgqJyn8X1n0eYTyFguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QLhsWcSviG7b9IuSixYkSaVcO4NPKAj7cqlmilRl/8=;
 b=MpYMP8wM8nhZQ9Gm3+4lVmzatiBp5hTesN5ImiTewDr9BbCWFhbV+NbEOjaB6OPnWe0NeThUXCZoHzYmbfWaNqPxzUTNESgJ6HLF9SLwam4eayM1zvPoUT+iHkmUi0qdTldaGTk04HisHD/XkxqXEUtQKiSngkHQKwfJIMtBepq36Y9dN7qacv0eLKeXsl5P5hLNOe9q4vQeQWkMPpYC0HPVdhmeLvW2jwMIEAqJzPR4UTkCa5TL2lnX7jr6FTqO6B77RsnOGeoVIBqbb26YPt/kj11ztAZK/4lsK4rTeuAE+uBBZYOZwAGrSZiLAiBZZNwOfd/3Z/SLi4XdMr9UsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QLhsWcSviG7b9IuSixYkSaVcO4NPKAj7cqlmilRl/8=;
 b=LCgJpQci4feRIa5bC3mxjaNP2iigfOvo0NtzdgsSBgDPS1YXHja2xJlCY9cV9vZIkK3rOw+RkPYs/IOJnrD2IXadGWW8bzoaqqAYKu3W43WoIGcMxdTwL6IZgMXSMxxx6lTFJm77y5pp9Xr6+OBpBEoxvTSFcc1fklDZY8iGnfg=
Received: from MW2PR16CA0052.namprd16.prod.outlook.com (2603:10b6:907:1::29)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 15:28:52 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::69) by MW2PR16CA0052.outlook.office365.com
 (2603:10b6:907:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 15:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Mon, 26 Feb 2024 15:28:51 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 09:28:48 -0600
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
	<linux-usb@vger.kernel.org>
CC: <mario.limonciello@amd.com>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, <stable@vger.kernel.org>, Oleksandr Natalenko
	<oleksandr@natalenko.name>
Subject: [PATCH v2] xhci: Allow RPM on the USB controller (1022:43f7) by default
Date: Mon, 26 Feb 2024 20:58:31 +0530
Message-ID: <20240226152831.2147932-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|LV2PR12MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: dec61508-660b-4b4a-b712-08dc36dfa2f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s9CmYqUwOBFUcoWXsXCBLk4WF+/qJ7v5/TVPOviNJqeAQSGnaJlI+6VG69C3j69jISLlkg3LzVMWBz8wb9O/YxU6DO3bijX2FSc+VW6DHTGk75X+/sYvJenkRczr96foGbI5DnwCQSeVTaamjl3caOaTfbc83Y8mQ+2ddKeEeoZBtfAQykEKUMHTUSQiB6AwxFXFdWi/nbVJD+wF+l2+re9YUAFdYOxMFs4PI26waukKq/Mey2zQ4/fIZAQ3MAZgljt3QsMxOAIrpGuJjORmZuGGBelQA3F0TMQL4lMaTr526CTxUKyyFvTSYIQh6Ya72l6p0VyHiHV2Eq2JoAoznEv3nqyqz5IzlNI0pVFjWB4AAA3UkBUP0XBlNgXlPzie9JiQjCriTohycS/+Xm7VlQ7yfylTlW1EKFdDCo1+9FMMMbDs+qbbKEl2s23xFgDSa8+kw6+pG3F6Wu0UH6iwYP+JMi4hOYhkkSUt/rMaAfD8HavOJK57VbygLmgYKlruPmkP2akeUTAxBQYGQmrqQkbWlTh4t76CdQ0CBpsDnuTJiJVkeYGYt3A4EKTA949gzLBuKADOdMZL6ZszwF0ceGE5hctmmLSazKDpWXxNwg0qfDihsbiDhwtzCIH4DwoY2XYFM29J1i+epp0Q30A7MdVxv8KId78OVBhVxVbntcXQ3HzjH/0adAKyGx3dP299WL9hIkhMPzir0sCtG4Jn3fzSokKDeFLSIFHzDDMkGR3zhVMvA5TtgJi/5e+ELTtF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:28:51.7496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec61508-660b-4b4a-b712-08dc36dfa2f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

The AMD USB host controller (1022:43f7) does not enter PCI D3 by default
when nothing is connected. This is due to the policy introduced by
'commit a611bf473d1f ("xhci-pci: Set runtime PM as default policy on all
xHC 1.2 or later devices")', which only covers 1.2 or later devices.

Therefore, by default, allow RPM on the AMD USB controller [1022:43f7].

Fixes: 4baf12181509 ("xhci: Loosen RPM as default policy to cover for AMD xHC 1.1")
Link: https://lore.kernel.org/all/12335218.O9o76ZdvQC@natalenko.name/
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: stable@vger.kernel.org
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
Changes in v2:
	- Added Cc: stable@vger.kernel.org

 drivers/usb/host/xhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index b534ca9752be..1eb7a41a75d7 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -473,6 +473,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >= 0x120)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
+	else if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43f7)
+		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
-- 
2.25.1


