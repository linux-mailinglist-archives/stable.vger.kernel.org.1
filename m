Return-Path: <stable+bounces-246790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OcTNdg8BGrDGAIAu9opvQ
	(envelope-from <stable+bounces-246790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:56:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C5E5300FB
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13C8D3100D7D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2943E5A04;
	Wed, 13 May 2026 08:53:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022075.outbound.protection.outlook.com [52.101.126.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1033DD864;
	Wed, 13 May 2026 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662399; cv=fail; b=W6pp52fFj5Gx0/Id1bf4O1iT+vDeSR5CA1mt2J3DpcpflcT8qai4YJArj8g15KdxyJqkgoZG9BRq05Kvrx0OSxT7iQ4Zz/bJjJbs8KAqmcO9J/2dU2hV713w40EMjLxczzweG8PC4ZpHFc5AeAYvHU9ZhsxDPp/qbrDyAZlc9Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662399; c=relaxed/simple;
	bh=M8KMIbtmjxU0Y1G19PoCKJKsLTLwvznDuAsIny+0J0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tvZUrYXCxf0Q5pgM2c4YNyB9Uh/B8pBegaI+e1o1GhEJOKp29ELDIMH0KcW2hB1ODyJPsZtZhXBCc/i3syspYnWx9Zd1yQ0+FZ0aF7HvyAI6d3K/pj8Zxz76k5/Q3mBPcFnuoyViZ/Pv40XhJ7BKbO/eAo3t6DF5I6oCSfjtE20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBe7YENmtBPTQNuPdDsBbt10puD7FCsJDcZJKsW6354r7YCnbHHeA+knIBZQA62upFZ7JyQu5sCHKHn+sZdqlxOiRzziGY1Cas81K0vEex9gYy3tXsRn52Wkr5cu9vnUPy60R1lH2q9k96lgD37Wg4CM+Kov+Ks/oTPzhkLyfUZgUBZyfn4eKWKjNtRyM6PPut+k2zoVpnaRcHsP4q05hJeTpVfcKOaQPU8DLg8JJ1ytO7VyqPXEl+oVCT8Uyp/wnAEBhiq2LA0ckbHTnIjDWCy+Vu0ylinAlTlN6DaZqsFnwAuB2TKqAHl3Dy+A65BSBgMDYCBQ3v/DYAEcOZkktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgFxraV9tu5TfwsHL7uz7Ht2tRuB1SABvOw/YKwz3C4=;
 b=ZCWtf1VAnfiiNCBS63plce0d6L5feIit10Jk7HzG93uDjf01XUjztmR8RptpAgCtARLSB9PeoZPwLtceMoG034bGVu2k/jIzqqamol9okBhUkr0q+zsZ2LpV39DExDX3+fwBn42r+bpgUGDYazuLXjxa4VdYn+bAhVSch9l0RYVCaxkPaXdw7KhoedozzW9JMCA6qJ7BaMjIIA22zZNhem074qn0ZlerzKBv0wakNXq9B9nMtnHw2KSPrYYp8m7F81CuuKxId1wNMRA7YIweipQQfRxhwkgXR/fOfvr8kfHox5IELCvRQsQuBH47NJJCGLr9eVN33MVoilo9AlEtVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0125.apcprd02.prod.outlook.com (2603:1096:4:188::13)
 by OSNPR06MB8787.apcprd06.prod.outlook.com (2603:1096:604:49c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 08:53:13 +0000
Received: from SG2PEPF000B66CC.apcprd03.prod.outlook.com
 (2603:1096:4:188:cafe::20) by SG2PR02CA0125.outlook.office365.com
 (2603:1096:4:188::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 08:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CC.mail.protection.outlook.com (10.167.240.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 08:53:11 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id EE9A14126F85;
	Wed, 13 May 2026 16:53:10 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: gregkh@linuxfoundation.org,
	pawell@cadence.com,
	rogerq@kernel.org
Cc: linux-usb@vger.kernel.org,
	Peter Chen <peter.chen@cixtech.com>,
	stable@vger.kernel.org,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 1/2] usb: cdns3: plat: fix leaked usb2_phy initialization on usb3_phy acquisition failure
Date: Wed, 13 May 2026 16:53:09 +0800
Message-ID: <20260513085310.2217547-2-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260513085310.2217547-1-peter.chen@cixtech.com>
References: <20260513085310.2217547-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CC:EE_|OSNPR06MB8787:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4926abd1-22e1-4350-2b1c-08deb0cd100a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nrzulKln6GoUS1m7+7ZTHmAKHVBD31g3AVbDyM0M1QR9KQI9XvIFwJ0VzBGQVIhE9sosSf4xCYDGZ4hqaMsiKlid9XGwezFBaaSvIQDEQuDwKPJcgdk3gSoO/5TMNTdbFH2aetagmlVOThYLGaS1CBTPYTE/3W8/lqFmyHT7ATQxOcGytRiH4IHSFFVhUF4vr+t3/QTsmG0ttbTF3WC150Tj2GHbrNsK4/tzeEC2kjpb3xUjBKBDTQVLUCgXA84/4uLVk/hCyIQexpcUwnYlf8z9Hq8mCZi12c1EvQ0yg6L1TBCJtvPUs2akAWPVIqI0BghsOUtvzvg+CfTByULVWsvJ6qlOSBSmGHJoDG1GPFceVX78aJsVBNJlpfVWcHsL76NPaZA0bMy3xIvtW1M5L9HBE14DzJ3SnEBqev91laurhibnkjcSmQFchoYRVKHpw5TPCVNBw/uE/gGmZ9Ei9KCHSWGdwVFxe6HEImyvaCaULwB2yeKMreue7KWJCMt8rnbBWwl4GjADd6VN+q3plzVRHuwOixKSqYK5bicAVPrVyw8gxx7WaaYqNX9lznHy3HKByUoK4KMCXZFOSlvOJhIUM44fOiytlJyBsicLpfYuEadu8cAuXrdkiWjn8ZEFeiPvWYafkPKcyemhbF+jMeO2EfE+MlWvPm0tEiQ0/13XiyRMCpEiX0jjXahdXTHqz1JU2MOgk633ilUiD/JupGHaiHVqjh6jdJEdy2k1Lqo=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ImndNZfy24AWYkCRnirkmpbB7f4EUgCvipOZ2e4XNxLk6MBc48XxdgqoVU3xKBBVYOLVxox7sinawCsAOfFActVrcEKQa5px56X2cP7YGKPVyJ1IqFW68LilC1MFDE0hOHtX0NTqGIAqnuaYAZLvyNsJQi+NHK6rMaQjwekdNKTs56HId5Yyi1eol+kxb46tS9e8EHjeSOP6KE22MfO8XImesbyH8P/gspxlFpLIity6CcZM63nhXkNvGHqB8ltLd2T4z0+Dr9lzcnOIoSpF9m/g6aO7vLg6BGJo0VE+m4ImKn2PiqZNgsuQixYjRtAi4xiyjl/mtl+dcyY8HClFXAtoUxHAUmLZJm4MXPlvaLisc60FGwDhfZ1DIOAhf911tFUOZUfXTICKSXAmUp6yqAOpNOKDHhqWFLD6AXf98MIat5+SlRJA5U6OmF1bWhep
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:53:11.5368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4926abd1-22e1-4350-2b1c-08deb0cd100a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CC.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8787
X-Rspamd-Queue-Id: 33C5E5300FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-246790-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@cixtech.com,stable@vger.kernel.org];
	DMARC_NA(0.00)[cixtech.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Move usb2_phy initialization after usb3_phy acquisition.

Fixes: f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
Cc: <stable@vger.kernel.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-devicetree/agKaEePSFknhDBg2@nchen-desktop/T/#m21e1d9c1574eb127ce03c0c2a1a49002ce435b52
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 drivers/usb/cdns3/cdns3-plat.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 735df88774e4..d2e8d1e9007b 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -126,15 +126,15 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(cdns->usb2_phy),
 				     "Failed to get cdn3,usb2-phy\n");
 
-	ret = phy_init(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
 	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
 	if (IS_ERR(cdns->usb3_phy))
 		return dev_err_probe(dev, PTR_ERR(cdns->usb3_phy),
 				     "Failed to get cdn3,usb3-phy\n");
 
+	ret = phy_init(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
 	ret = phy_init(cdns->usb3_phy);
 	if (ret)
 		goto err_phy3_init;
-- 
2.50.1


