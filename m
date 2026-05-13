Return-Path: <stable+bounces-246791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FkzA0Y8BGoqFgIAu9opvQ
	(envelope-from <stable+bounces-246791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:54:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B63852FFF6
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71060303278D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDB3E5568;
	Wed, 13 May 2026 08:53:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023142.outbound.protection.outlook.com [40.107.44.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EC3E51FD;
	Wed, 13 May 2026 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662399; cv=fail; b=cIGv95fhk8dkpwMgeM13TNbirWOhfG6BTsLw0uE2tb/P1iIhFgLqlZxnRjT3xiqtnWn8klSxGpEsmFDZLUVGBFrmlOusQf3X91YvhM8eV0LZv4nOVHt2t8K5YY3YtEytCAdLonESrieo5cVzNmWakZ0IrFF66MbGWMnxNiieTSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662399; c=relaxed/simple;
	bh=yrgOKeAxakclGumUK6iLmIerAAMi9Y1UykmyX24Q+1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDYD92WWIZolgiVwmnRgc8skg9twg7F4/OZn+niLFV8hadW6JfNzuEL4OrbYnL6H0l/JVxOupw4O0VJ/sxR0ieWEKBVWRWzTBkZjGP1IrN9+Khy8cj24WBt9OqZy6cRdm63E9ljQ0VU6wnegPDS1Yi5WmW9FohnRwA0a2fgpXss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZG34D3qBxcRmoRMM6Wd9IPCZJ9i44HLxRbnQFmL8mXo5ciVqjkfFUZ0wAHC8CK7s9CBebkvAyiQZ2dyQ+FSzveLO5ufSLtRR2oPkJTDEAX2oEkKePLfXTnxoaeENn3iOrKd0juqErXSYiU3XppVEIw83byOFUILMN3b1zaZdFNAxDX0RP4MVTXMSgdRMmZfLSdILEKffqTBSmDUpWiiDSpVifZtG7wEhwJlmKuscJE7F0w5nyuXBvMXc9vc4OWPtFy2JJ9nqjcudGwe9GphVgGJ5xGgw6gB7+igsQGFJ02kCAqjKXefvc007Nq2as7u6M3JD40LaSJHgO/bMyYK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnLoD0v7n8N9EZBf6Ezp9IDfVPCPdKXnXw6k1yzNSsI=;
 b=ex2Bz1Vltk7Yx5BxGbmsOB+OWzzNzBi7czlVi5TzObRi6PK+kkDZoyrFYgRgVR1eTxz6xcVWoOOcDh2l53RZsC/o28JSMsOWbASloFOuUj/MLmmza+4LnQS07zQaqd5Y6lEBSEP34zXoa5LUtumUK9bMRdHs5y4MQkdi47E9HrFiVbcMCK4VFTyg27jJR+akFCoMwj32bT0vG+xEt2AgU3AOphnBBVtqt/eUilJ5KxuwYPjs4R5b4PnBFkS6Mry6WqWNNlFifxYoWO4fvFvVemF2G2gAuLX8Mrp399JNWrqpya1gMCcvpRRf24rWo4kXnwv1GsEZydtHS054QuGI9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0032.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::23) by
 TYPPR06MB8078.apcprd06.prod.outlook.com (2603:1096:405:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Wed, 13 May 2026 08:53:13 +0000
Received: from OSA0EPF000000C8.apcprd02.prod.outlook.com
 (2603:1096:4:190:cafe::24) by SI2P153CA0032.outlook.office365.com
 (2603:1096:4:190::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.8 via Frontend Transport; Wed,
 13 May 2026 08:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C8.mail.protection.outlook.com (10.167.240.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 08:53:12 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 08A364126F86;
	Wed, 13 May 2026 16:53:11 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: gregkh@linuxfoundation.org,
	pawell@cadence.com,
	rogerq@kernel.org
Cc: linux-usb@vger.kernel.org,
	Peter Chen <peter.chen@cixtech.com>,
	stable@vger.kernel.org,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 2/2] usb: cdns3: plat: fix unbalanced pm_runtime_forbid() call permanently leaks the runtime PM usage counter across bind/unbind cycles
Date: Wed, 13 May 2026 16:53:10 +0800
Message-ID: <20260513085310.2217547-3-peter.chen@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C8:EE_|TYPPR06MB8078:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8f62d86b-60dc-4447-850e-08deb0cd105c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4xfwnbUOKudtdbEiXaqDjOV/OD6m5joYZCAiqUcJRJyETzC8tycMZuPBy4LTgnNIguB6YNFTUFJXdHEEjNiVoZKz9g7B/VYyMG75peqbS5xPEkFKNRw2pxS7chPrj0DeC1ra652RRWlr9Pgv428mp9i/mFgbQfd51AHDLsedqotCEsz/0tdQSWXcCUBNf5Sf6/RRy81nKliGmN3XWddgg3oEgXpsUqRx3oKgt9vHE8DkeKd9w+AW1ZdHGYQ8B41OgqQNdtAVyiF42Z2tn1zvYDAnqI8bRDF7f27z9aydRzlCXKrOM03QZ1F8yS3BXjJnp8+hHzx3O/Is1r+/XYI/3c/WSJ8IfrnqEwtqA/vRxK4Qpe7CAju1azYwTFnuolwGJh3khh0DXT+qnVNrwG0hGAIz/Ooh/HU9SWf01eXydQ3JYtRa4E+HzLp3qr4EQbaXhH/JyJsECbM9c3/ZwdHsbHh9QLgu75HsjHj+c8uxyez3mpDu1cXwY41Clb4fCAEh7weIBnQMhlNFYTslMto117yNRRl7W8R7QYq+v6ND9UJvrHgEdSAWfPpsQ8Y+Z8Q3Jiz9NjkwH/a5a6oU9cFyuhXfB484DfgkCdIrBVJRImDhUoplRIPzHWC7acGOJBJnpmxI3Tkz3HXTrfQFs1Vz7zMKXpeP3GQo2zOhlN0l9wLdXl4SN6UQr5yqo+ilasDEtJNNA5xC/1HAvcXNjQ0PXKf2OzDNrKyzVX2WMJk4A3s=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ULNPZiSMAr2TPd+1fbtjSfvqZTyU6VewDtelhe65tQvBvYv2sa/cCsRSX+G9KFNG1uUB14sF8bKwlscy6y2Pv/kYbUVFkEC96eHv7t2KChlDm3iJ+p2AqMsLeRz6opxUQq8joaw7KKpht2REB8l7CiJr4u7fkSTOF73XAHszrS7AzXlqCotS2JfdBLZto+zDId701fMFPd/iDSsIxASz3TKJVJl/w331xWA55wAfqOk7TIwLE7XxtLa6rPxpt8/0QGfWuNZucJW38v9QaogGYEX/fgSbNJCb3BeEuLSUAUugsUmFR3r5HT8Xuqsswvl44V1ACs1uxo6s6zWEwSSmmtPChNhZiD5NA9UCo/PaWfZ+MTtvFXOQMiXi4ZUh8WsFsFsncO5bTcuylvzsSBKt7m7d1oHDLUBizTnFfd7EpI/7wGgbl0sYMykDLxvL98Tc
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 08:53:12.0165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f62d86b-60dc-4447-850e-08deb0cd105c
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8078
X-Rspamd-Queue-Id: 0B63852FFF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-246791-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.chen@cixtech.com,stable@vger.kernel.org];
	DMARC_NA(0.00)[cixtech.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Call pm_runtime_allow(dev) conditionally at cdns3_plat_remove.

Fixes: f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
Cc: <stable@vger.kernel.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-devicetree/agKaEePSFknhDBg2@nchen-desktop/T/#m21e1d9c1574eb127ce03c0c2a1a49002ce435b52
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 drivers/usb/cdns3/cdns3-plat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index d2e8d1e9007b..94e9706a1806 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -186,6 +186,9 @@ static void cdns3_plat_remove(struct platform_device *pdev)
 	struct device *dev = cdns->dev;
 
 	pm_runtime_get_sync(dev);
+	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)))
+		pm_runtime_allow(dev);
+
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	cdns_remove(cdns);
-- 
2.50.1


