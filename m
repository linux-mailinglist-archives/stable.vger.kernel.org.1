Return-Path: <stable+bounces-230519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I3dDwaGxWlc+wQAu9opvQ
	(envelope-from <stable+bounces-230519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:16:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA25A33ACF8
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25F6830D7D57
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA41533A9E2;
	Thu, 26 Mar 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pu6TwsrA"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF129BDBB;
	Thu, 26 Mar 2026 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551966; cv=fail; b=aMrCo0YG5SMPpJ4CvtiOXFqiURWWXBq0U2Lbq6JlYCj8mHw87O/F3Qx8OhOxFQajk0FApnfdbJWZnUL3GZUwXOfFXJVsxpJZjNcqbL/VjxlmigBaZ3TTUoIxSRJUcE2ueCwswm/WjCU3a23sN0Nd3gW9wAMV5UypYCLXWngLzz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551966; c=relaxed/simple;
	bh=dnfyzBpbX1UHwinnQUPszcUuC6cjXmqBVjEUdgOsEC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=giAEJdjXi2cx2aDHFDq0aMAB0JRakGEOAQRwTuKQgpkPM2FYXxvLJ5khqgq7USNepeVnPs3lHyXt1zyHw57R6rkCthv1b3wwGAv7yfVTqxlLDz+0ujKgI2It3h1m8BDXFYWq++YnL17V8TQLEVEFQlFoYTDpZ9FbkH3DUU4XA9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pu6TwsrA; arc=fail smtp.client-ip=52.101.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdWDpZIEPXCvgpCVIh1u4PsBstIZcy9JkLsoB1yPu7uldx+mQse+yXPMc1cS1i776KthzxZBfz/9Oi7SGYOxxwIc244fvTm+amjMHSf/eLAZ6m+7J+FJ0iTOffV4Ta9wCz/SgjL+R2RQ0psudI0aS39lcxYsBY8hj2RZS6afyWrrcKc6PKZ1UCQjnUa9kRilg1WQ0Y4CjxuP84JsTbjSMMEtz5lIDZO95e+/8ZPck2EXVvM6uDRrt2NzBzjKJfj9Z/ne8O1of0RvzGA6J6B8MN/xEBz9jWLWpsUT/wfxbR6BpWXK3r7oMargbumRrHr7j/UPEdeTaFhJ1NAgmjdnTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EC57Ehl4RjnWUGTi5K1vCpa3xhWLybvxsc+3E9s8bs=;
 b=Wfgv+va2VAvK7kgFwVI9DKlaOpApjlSi/bXG1rL4yIPWYJeOBVbVyWk9wCR77iLxuGEa5iQpPTh0gbik3nzXL+Aw8KqWjqy6XrsK11PTxI1jpOhn/5MuZHr6s+o3cOiZs2OCA1ekupMSW/1wyUKhPG+/S6UoVGxpVxCjKdb9cxh/O+ObWAwoVgFBYSUHeBKuYBJFnzGWfsbcEgwMm7aF2o3GUtqoz97wgbOXNJg2jCx91AmZXEfSnbpTH56+LpjzS92eMoUFKmyxps4XWVBYIQ49cBqYldjuOuJalExoQjwJhS8DHg8Ig+UkQEgseJgz8NYaDZ3VN2Mj8sgw7/7fdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=perex.cz smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EC57Ehl4RjnWUGTi5K1vCpa3xhWLybvxsc+3E9s8bs=;
 b=pu6TwsrAV0ui9Ogi5QhlvOV3374D0onco9yPNm75+UcMy9/uGGT4ORoqno2YOZQ1OCLM2VB0M12PgYO7/XABgMzrXeLaVp5MIXAqtRpqb//ggoSje9XkZk8o/OSNSkw2yTkdLvjRyBbBcyB59koKAdt6OKkdjBliNTH/PAuHGUk=
Received: from BN9P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::15)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 19:06:02 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:10c:cafe::6c) by BN9P222CA0010.outlook.office365.com
 (2603:10b6:408:10c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 19:06:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Thu, 26 Mar 2026 19:06:00 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 26 Mar 2026 14:06:00 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <perex@perex.cz>, <tiwai@suse.com>
CC: <stable@vger.kernel.org>, Juhyun Song <juju6985@outlook.kr>, "Stuart
 Hayhurst" <stuart.a.hayhurst@gmail.com>, <linux-sound@vger.kernel.org>
Subject: [PATCH] Revert "ALSA: hda/intel: Add MSI X870E Tomahawk to denylist"
Date: Thu, 26 Mar 2026 14:05:38 -0500
Message-ID: <20260326190542.524515-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: de8b24d6-d412-46ea-bcd9-08de8b6ab83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|32650700020|82310400026|376014|36860700016|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ioTT9wL5AFEu4suMpgvm59nbw6A7DkC4iwoWi1NMbpj3IqWFjf4N73KPb/6iT1fdtfn87oxPGf5tdTmclUJy/vTgihCMvzmisvbqLFLap3ZNYpGPDeihfEUOoXxSI+ReGQPpli/o2hM5RyXjptowe0+JrUJssYCBbYMJ2pVRjKu2MZlz4Nbs7p3SlKozLt97WfmdtX5j3RXtLv7GPAz81jDGiw6OmHg/2wGtSoQZJLiDMrdHNrWBbF371owSxuIwcZTVWsKo6ZfQe4PvCOSmQijgOwHjw9yyQoCbrQbPCEmU9BaMLhRbrDd/d5rDxjmzkqB+IrcQqlZ1wAgmYABBrLc5LkaVcA+lFqNE043pNwPrd72lUoC1O8jSkwfFv3yYFcDDBHYVZTwBfKJ9a0Qvvq529wNx0Aiuta2yurjWkb8So22bQT8jyBSSN6o1Xsyu0OyQeGzNn4INWvCK+a1Ko5yMpQBDvBJ8fYwZh+D0Iw+tj+qF58aUxwZL4mVWW6BUiE6rjcpSt/gONCCjsPGvByffwPhxW9vrPrwwZcayUndylgFQU2sYVp01X9k7JL3enDqMvpZhqY09F6A79l5CPlfbsXJVauzd29FoBGe3xtt6ItlcRtDB8Gvsf2j8QAvsGTf+wSlPATUrXB+igs0Z2PbHMgJqyE0LWKOGZe+ckCULMy3ZAGbU4UXtCzUutfde0DJTXXgdNZthiu74OHH3hD4dAh/+0k7ERoQ3cKoGhJ0bnltvGg+bbu5dVT3Y2sO7wSoUHiBpJCVBMHtWiF7C8A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(32650700020)(82310400026)(376014)(36860700016)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tsbCjfudQPe9O54Qg94WTGMLwgww6vUy9gjmagHOi+5vQZ5MThEhP4eu12S92347XcOjxdiNPfA1N4zlntYesxQuu2bTu/smRXDP5u5A414cCxocYQ5psHK5BfE3t28f4+vnpIOrmwmtEzQY4OGDjw9+CX13p7JVFyxTdS8FjqoUopT+RpzfhSRmPTTuknVQhTOLx9BktYPy3/73z9a+2sanaXtKK6QAI7I3r4v1FC4JQNBS6beTrXrvzt1l5oyyrsPdcgVxNiiW+rZv8kAkl4lNmnG3ms37sRHJ1EjOGtdtcFhSQjpezXI1zNeRWtJ2t+gt9WhTTeKbOv6EDR0IEziicJlO/QjhUbKeSoVqUaIJGLsoVvWzE6w5MBGzaOXF4pmM3ZtGuJQvEQixdFN+8A8qUcSZe/n1quolzfZ6HmNt91pgrGyyUyXr/3+dSaR4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 19:06:00.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de8b24d6-d412-46ea-bcd9-08de8b6ab83e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,outlook.kr,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230519-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AA25A33ACF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 30b3211aa2416 ("ALSA: hda/intel: Add MSI X870E Tomahawk
to denylist") was added to silence a warning, but this effectively
reintroduced commit df42ee7e22f03 ("ALSA: hda: Add ASRock
X670E Taichi to denylist") which was already reported to cause
problems and reverted in commit ee8f1613596ad ("Revert "ALSA: hda:
Add ASRock X670E Taichi to denylist"")

Revert it yet again.

Cc: stable@vger.kernel.org
Reported-by: Juhyun Song <juju6985@outlook.kr>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221274
Cc: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/hda/controllers/intel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 3f434994c18db..2edbcab597c87 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -2077,7 +2077,6 @@ static const struct pci_device_id driver_denylist[] = {
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1043, 0x874f) }, /* ASUS ROG Zenith II / Strix */
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb59) }, /* MSI TRX40 Creator */
 	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb60) }, /* MSI TRX40 */
-	{ PCI_DEVICE_SUB(0x1022, 0x15e3, 0x1462, 0xee59) }, /* MSI X870E Tomahawk WiFi */
 	{}
 };
 
-- 
2.53.0


