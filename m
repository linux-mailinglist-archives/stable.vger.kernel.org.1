Return-Path: <stable+bounces-225768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHdrJagWuWmOpgEAu9opvQ
	(envelope-from <stable+bounces-225768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:54:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB112A6027
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 169AE3056665
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 08:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A13A39D6E6;
	Tue, 17 Mar 2026 08:53:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013013.outbound.protection.outlook.com [40.93.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616A39D6D9;
	Tue, 17 Mar 2026 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773737629; cv=fail; b=m6pRpYQZ82tjad6WX89CfX+qD9Z4mhWeijEW1AtsLoJU71U31/adnKRfB105ylSZldGq6YmS6LA1UvRDZnDb0iAzCWU2aVhgpF20VYGcogiqjgBMxBeCOb59eoiFVrSO+F4jEe4KEDBwGc8wthLDc6poMf/VRf2YTKLXZcuIJ6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773737629; c=relaxed/simple;
	bh=7jW8UKu5rwzPccsxAx23pe03uaXQ5JhPTDo4zA6LmVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d0atppnky7oTOU6myyXnmsjnipUmoGjtHyyeIDTL4eVcfHuOhE/tTb6delRxXKhIr0pFJ8FLD4YN0QIXeS59PQkgiv1ycup6lwUgDocpCabTYsE2BOTA81TeRuuzFIo5GbpFEkWhLxytlIa6bJXobxf5vxrx8nZTcfMQLomyzqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; arc=fail smtp.client-ip=40.93.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/i9/nJdCxSvo+QPt3FZoq+fadAjow4DVE/Ztgu0ALPUVdy4ql4n0WFLBDG9r1Rgqh2RL0nl4arHCXJGNCnPzYRnhztLR/ICgRNjhWrgjAFHvX9mobwlVVYLqSTeGq5KF+SaPXSaeSWyuIopDIz5y3BSevyEDqEQtl/cPYDIr/YTgT6NcElfIdDApqGohnEI14umUy2gH4cegrYEsuCRC/EiSEMM0N/IN+TLxvDHh5nei5tHr13MsQhXvmPwHHETBiqgX9vo3bGIblrjtUsywhB2hHRUxyP9dHhJX4jTVQ+CTLJG+wGvpkrLljz8ZhECRqmOijRWdgxSw+sXDD2ilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+e7m8SEfabIkWdxgvpEUCx8JtidmFe2TqP6GMggkZw=;
 b=CMw89Iss5+ESu7au2R++yeJcmhJjnOU8PZV97UzrahkM0BxOtV4jwmMTV57PMeycaNma02Bp6somGb2RpgV8irXn1udXroZbOAa00V/Xf9htPo3RiRR40r07F7DZKEfKG1Mh9+o2w8wrt3r7DROtpmizu0wlFHoMugQxrbNTGYFGb/qR+D74LkWk90QQZ34UgT+GqAfoOG9h1oHShJxPzV6B7S3D4s5wHUJdjSmaysyB4do8CD1SlTNQ53eCvmrKCl30B8qjjYK148+puJ/UGB9YYFNxi+iwxA/sXumOXVjgLMg4Yj4f4m8J8am7+2JE30X602vQv+yEEbVt0CTjSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
Received: from BY3PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:254::33)
 by IA0PR22MB4259.namprd22.prod.outlook.com (2603:10b6:208:480::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 08:53:43 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::59) by BY3PR05CA0028.outlook.office365.com
 (2603:10b6:a03:254::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Tue,
 17 Mar 2026 08:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 08:53:42 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id C65FFD9C13;
	Tue, 17 Mar 2026 10:53:39 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3] NFC: nxp-nci: allow GPIOs to sleep
Date: Tue, 17 Mar 2026 10:53:36 +0200
Message-ID: <20260317085337.146545-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|IA0PR22MB4259:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 106ec0ba-2756-4dd5-9e64-08de8402b0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	n71U363nfiK8OUEErF/j3/oPzjebRh9PpS6X00NFfr2CBfE0zRVflDEmKY4LWnqoIeDUWxFizlUzKIcQkGG4mBDP5Ms80olFKJpBJryzz1jLImIsdGt63ohN2H2/HSQw4OKMWojJBDxbezSIMGR+8dCjXt3HtYdKcd/uUP73gCcyRUKgX/zfVYKWFx8QoDUHorOu0vziTzC6K391erVw6JWt5KJCo6v7ReaoaqR/DBquo0dKjtVH3SR299hSObNB2h23aGh0S6Q/flLABcrrMnpujfoOLBEqnRURmEwKdTkFBTvLg+rKpuuFVXrYwHtgqS5Tn10inMdF2KaJVYiMqjY3QaEO+XAr99nHTi9UG2Ugdu9a6B6uu24l3hPAgojmrZzCcublBP3ac9kj6I58i2luCPrWLF/FdmveeFMmgtNK71JjQ5GhOSaVUGJdQKNi3abr5mOrhTqqEoVLkjahKuWbhlJnSvBLoo+qivEmVxmWAaOEHwZ6+fBRCJ0av7IATh0eyM0+y/qKQ1o01BPB6cgZOTx8wR33pkvgL0TJIm/T+42ff8A7eajTzgM/p8FdziqWS1KbGNHnF2vH4DdbmGoA5acudDcH6jKc+EgCrtveWqIPhzG+409DPH1KSou8QKFit7RIXyi8+8H2LRXV0MPBTIW8WEHfdjco6oquRl0vOBCBhUgCBrABC5MRr1Nd6vJo19xghhgO6bTKSYFOdczHGO0LTPs3MRDkKerqeKFhfRDOMEY5uXkrPsYogOvXmAJyAiEXYKK6mg5Hxtxl/Q==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qeLvlQTOd8ZMlP6QXRVmJYbMU0Iya5yoYVmVJ3Dtymm0SspyaZq5gBm+CMVtxe5H11dsKEF6XAido88OU4+Yvkx+aBmf7IhEaeweAmuSFvwBpLo2HuyCYO9GUqOgETQdRO73ziSR6iiI2CwN1i8iYfLWSNXAGHbDY9yYFAkdUuA/g8I4WDEFoARgLaEcO0p6PiRRIiAxTXrBpI/MLqt3DWCvOEU3mzfeoRpJ9ypYqBw2H4W/1t4yHN766J86VGjGoJtxw3IUeF0BfLFSwWMhj5DjU64MtaOPNYCaEsMPe8eXauW5NVdQASBLJDbWmR6L/IUbyqOMY4j0g1QfMy87yZochZ5cjVTaGZRDlxhEXNey0zslDlW6QomXCTv7lKQPkxgq7jMx9dhrAHc83Itafk1qCiuaqtWg+ZTOQTH3Y8KW2Zmfp5FmNlWNwS4XXmp5
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:53:42.0959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106ec0ba-2756-4dd5-9e64-08de8402b0d7
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR22MB4259
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[gehealthcare.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225768-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gehealthcare.com:email,gehealthcare.com:mid]
X-Rspamd-Queue-Id: 5AB112A6027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow the firmware and enable GPIOs to sleep.

This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
connected to I2C GPIO expanders.

-- >8 --
kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
-- >8 --

Fixes: 43201767b44c ("NFC: nxp-nci: Convert to use GPIO descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
Changes since v2:
 - Correct the fixes tag (found by AI review)
 - Use uppercase "NFC" in patch prefix
---
 drivers/nfc/nxp-nci/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 6a5ce8ff91f0..b3d34433bd14 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -47,8 +47,8 @@ static int nxp_nci_i2c_set_mode(void *phy_id,
 {
 	struct nxp_nci_i2c_phy *phy = (struct nxp_nci_i2c_phy *) phy_id;
 
-	gpiod_set_value(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
-	gpiod_set_value(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
+	gpiod_set_value_cansleep(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
+	gpiod_set_value_cansleep(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
 	usleep_range(10000, 15000);
 
 	if (mode == NXP_NCI_MODE_COLD)
-- 
2.49.0


