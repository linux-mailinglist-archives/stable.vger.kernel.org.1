Return-Path: <stable+bounces-217695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EPzMCr9m2kC+wMAu9opvQ
	(envelope-from <stable+bounces-217695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:09:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E96831728FD
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDC9630440F1
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111F4345729;
	Mon, 23 Feb 2026 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="ZEDqpt2P"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8120B22;
	Mon, 23 Feb 2026 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771830370; cv=fail; b=ABAB9ObkNv3viFaAtZfLMCWVZNFSr9EydV7CnQRhpMonAttASMg7tSOLtL0JrIaTucaNwDraKTVqHYu3WUkMV3g3w0VMqGGlEDawKEY2DyQkyYz0LEeZ0HU2nIHBFNLAOmJxhgIvd5t4FKlpNFnpoCvVJhEUs6v7AygfLvf1ExE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771830370; c=relaxed/simple;
	bh=hSSS0C7TWpKmkPlqmMB1gTSQLac51WZlC09b52c+oWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=roSHwrQjxJXYqTH/7eYwPEZPvCNJlK7QZtj9WjnLS900XKh/85fzOcMLeX/nOi9qzQxi+H12e0dQdK+CXm6dwSrpf9MDck6f1nf9lLdwi7ZtXPdbD++j6X7w6vREk7LCS2kY9c9qa9x+E7F9wvXxfIRCwcUnq3QAbPuMQYxBzUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=ZEDqpt2P; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjp4UdX/yCSe6GOBNyRBFp/AZsI0HJ3xWZuOinXdEw+bOrPD2DBAZu7EAT5CsoihuHLF90KuVNkYak0G2xRYRjExtQV9lPyHyI14Gb6KTxyGWQ3SEPidTKvh8XVTqRZ+UwAPLOVYyQKMwZgCQMOT0DN9ZRsY/LwOP8OJuoKKJ69n0seOmOI5I5tlnuWdbNKZ3ZRHu3QllmdBh+PgiLsrWX5jjs5I9k2KEHUHscWwEe07Ep7AVRNeW6eoVGGIaVKkj1ZgyCSMi+6z1DUanUels8ab2XOC8ay9fJRoEWm7WH5gls9r0GGKtCZGSyGQM3RZNZCTewW4lf89LIS5/1maDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wumT2EugyCVjTXuG6hunuDcPHG6F1xmYs1tgjSgoyXk=;
 b=JWSCVtsq3qay8C0bqJsX75XOU9YIe789O3FfmmbEKhOkG4NyZWkcIBfRL+u4YsnrkKHfEmlH3/vfRnmeovRkuu7KpJLASZ9Ohx6Y71yXQi1qaMPn/VouvBCRYXqKHSGPcyaGipMoYxWajCDG7cfLjcpt0bOhEBe/s+xQEVuKEX/QApac6CogT59caZw9X3FXqGUE0Z2vWcoKe30wjCJoNdR1RggFldl1po71h8C1G6F+pnwUAm1Orc3C+wy0zpR6qMwg/p1nryOhYNgbJs9QMQ/M/rmiEhKEK7MsmFj0vs8obsFKS1uJbmBz87rxT60NHPKpcika+JknTJoRBtJO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wumT2EugyCVjTXuG6hunuDcPHG6F1xmYs1tgjSgoyXk=;
 b=ZEDqpt2PQ2JHyubHs0rxeQkkTU25e9YG2Vw7v81LS81vh93+l/8XsztnxliDVHVbRp5NwJlsQOsMedGfezZRtmBvIo9lJ9d/aXDwGTvlsyEXW19CyRoTn3lS2S6zLa7fOeG9wsXnfby89ZvhOQaggiLDzhlF0H6/ZhgBaXdkAx/Qya1Yv4cO9ogkefTI3SjOwT9aw9mDn1CqrPs8Z8pngr0Pmmz7MXJL0EvXCOhtGWtLJn/7/6HOD36rv13lufVoR036K/EXpRHzc/FbrCFmpWC+/N1DSR+6e2Zd+1UDHDdNC/V1QJQC7W8dE7rOB2px+vsGChwqXvtYQZiqN4RHKg==
Received: from BL1PR13CA0402.namprd13.prod.outlook.com (2603:10b6:208:2c2::17)
 by PH3PPF7ADB2685F.namprd22.prod.outlook.com (2603:10b6:518:1::6b4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 23 Feb
 2026 07:06:06 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::6b) by BL1PR13CA0402.outlook.office365.com
 (2603:10b6:208:2c2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 07:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 07:06:05 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id A2102FB3EB;
	Mon, 23 Feb 2026 09:06:03 +0200 (EET)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Samuel Ortiz <sameo@linux.intel.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= <clement.perrochaud@nxp.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] nfc: nxp-nci: allow GPIOs to sleep
Date: Mon, 23 Feb 2026 09:05:32 +0200
Message-ID: <20260223070533.106625-1-ian.ray@gehealthcare.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH3PPF7ADB2685F:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cfd1ab45-a420-4a43-07fa-08de72aa0352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kToz3j5DYNKteXVPM7w6/xes1AqinfwcoPIQJ+azZiEoN050yfWR+WoUxwTU?=
 =?us-ascii?Q?hWbRigyVL2OLVvg578q839vLEHK7EFkM5Mc2/2VrYBPsHXW3fj3I2O+8rXRb?=
 =?us-ascii?Q?hh/mik0+wE1MzFkgBFCRnu1kS9ZLiMxLCj6s0jatHmCR5/HtjdzXhip6xYI5?=
 =?us-ascii?Q?+g9V3dy8ObOeAdzHwxCqQspxuSpG0g3rHMxCxrtNUbOA5ao4F5UT0peuDMGy?=
 =?us-ascii?Q?80unzN6c88xMsOt7T3gWS9cNsgdQgtVexb8q0o9H2BTM2TkIBVauKjxN1ZFR?=
 =?us-ascii?Q?tgbrvBQAaeylwdhYO1jJDUdkOAUADgo2F0ZfMF2VIkTJT30rYnrp85HKVQ3K?=
 =?us-ascii?Q?aGSr9aRBBZXXWogMqUbXvpR1OyVgUA2J0J03RJUWuM+nwsdLZijfdv9yQ/qT?=
 =?us-ascii?Q?/qI+vn2sZ34RKMIPaLXaNA2/6tt+UVPM9ruKO5DVvpRKRfkMpB+5OAxv2Ny1?=
 =?us-ascii?Q?e42AMmEbreUroKce9OXaRsAUuH8xRHWjV+nKK7AlsGl50iJeJC9GNMgHyOlt?=
 =?us-ascii?Q?GGDy6vha+lOjXqI23CNtQkohuOXbCo+kfGOCMQT8/mobBkIJnB/7FGsUJAr6?=
 =?us-ascii?Q?pWrLXk+qMLMJ6dDmYD+TeXvlDOY44wAqpqkf1ZvHuTbY+uAE3oRS2c6DxXKD?=
 =?us-ascii?Q?ektWkl34U/4krJcFBkfJEzhSCcVLJx1Xv3+b/WHrgy5AGx5h/4b+je+VkcEs?=
 =?us-ascii?Q?rKdYbmdnyGWIjcaKVX4mWmShz8NpEkbICFACuzjpFuUA6tSlA+QraMV0M75F?=
 =?us-ascii?Q?X/MIBltpaqMQpiU+mL95EivgBRATyztxNIUARkl5BSl+PGphdbYrZMFEKtjf?=
 =?us-ascii?Q?khqcBOCuuGS5XOT4vcjuSLy78yy6DM/dnD6DMSO9kIbmaQ3Np16iRlGj+XXf?=
 =?us-ascii?Q?Q+T3bxUMrto9axz+ariBIFjXVdoF1P+SEMVeHcIaRmhFU6Ds0FT1jpUVx2xR?=
 =?us-ascii?Q?Lqa2K28sP/4X2WUMP3+8zxLgTBbGv4WSa6oM0P1wINWzeHQqK6ebZ6sVJ4Oc?=
 =?us-ascii?Q?ecr1WAtjtUVZQ5d62V3lwf/NjjxJ/zF6jK8RWFX07lSfJWj0alXvC65hUuvr?=
 =?us-ascii?Q?o056pE+NXZ6TKBqDjboLSsF1WHmJVSwgoPYC0iVsfTBTQikBBh8W5k4vilxz?=
 =?us-ascii?Q?EXm4Rf3fL8WeeoNlXLUcINLGl0gLAqdh/BqDjY4bg9clkfugORPSM3BbwzjC?=
 =?us-ascii?Q?zZ8JlxIQhQf6TtbHtKd33Mx/ouoPKqSJaJFSV++VK5SHh+HWmWW+bXf5AVoK?=
 =?us-ascii?Q?HuoSDsD6+JVXISSMCP/UBOnIqSOaFdqQSiBw9fmIpz3nQwnKpBvyoeagjs7m?=
 =?us-ascii?Q?IDYa7gyOUi3tlRxXEX8CC6jHXl27r9Fp/V9/0W6Xz4Kb4ij43T/52CZU+gwY?=
 =?us-ascii?Q?5qu8WZwupkkSvdqqVWdHi3zArObUwQv7GKSnrcHuLic34HnG7dyh+BGDiQ3V?=
 =?us-ascii?Q?yrZh/vz2yyYMtZzBikov9ohj6HiRoX09BLp+63deofTjLqyb0qLg9As7z5Pl?=
 =?us-ascii?Q?xcNPlcpNGpBUJO/h1h1U2+yWVXi/n1J127H1CxBIDXsj+RiIdKNqAJ0u0Ge7?=
 =?us-ascii?Q?R1wdZMx//4L0a91Wuv9XRxOvVLsNyS2oSrldrer9qaoA2fXiBHcE5SAwDVdx?=
 =?us-ascii?Q?AxNtBnOg6+Y2ZCrAPDbndGpfAf/99FhyA2i6vWe3G+AL8ozLOLDsW0oAOtnK?=
 =?us-ascii?Q?P1kbOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L42WRQaEPoVnzvV8BQht1/+3qwmNKP/2vzX6XkCisKp2zToLUB3Vb9bKnLienFdGV5MCX88XtN4MuZSHZVhVjuZ02+lzZrU4EWxPxysSt+qaO24E0xxPtvVuFfR5lOciYEYCdNP1Tv3xC7jnHsAlnjtqtpU5JxuOhVuc3Gx7bR76NSJ+GUv0Ei3daWhK46b0bGHYZB5eM3LRb/2zjJfqPNoofKH1bNDDLSwTCNmB4tp9BGfy1flR6thEcZYlcrf+kqOwOtc9+0w1PpK9dyZ1DcyXqkl/O9DZyGeHGG62I9op0ugaailb/0hvT3ogndwalyxbOoMH5aVJHkswdL8lzAWCBZ0OGaxIWP1m6yjhGASrxgSCzO59BJd27WxDTIa+D/KAxjCea98Ci7af7qxbKXt31+mYpTYXl22ES3QS74G8ptNh+Unxm+Q7vvDctlyw
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 07:06:05.6403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd1ab45-a420-4a43-07fa-08de72aa0352
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF7ADB2685F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217695-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gehealthcare.com:mid,gehealthcare.com:dkim,gehealthcare.com:email];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E96831728FD
X-Rspamd-Action: no action

Allow the firmware and enable GPIOs to sleep.

This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
connected to I2C GPIO expanders.

-- >8 --
kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
-- >8 --

Fixes: 6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
Changes since v1:
 - Add fixes tag (thanks to Charalampos Mitrodimas)
 - Cc stable since there are a few in-tree boards using compatible "nxp,nxp-nci-i2c".
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


