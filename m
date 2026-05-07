Return-Path: <stable+bounces-244485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBVpOUsE/Gn2JwAAu9opvQ
	(envelope-from <stable+bounces-244485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:17:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F104E290D
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6605630160C5
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475BF2D29C7;
	Thu,  7 May 2026 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vJQC8e9X"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CD1B4257;
	Thu,  7 May 2026 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778123845; cv=fail; b=c8tsxt9Y6Mt3vgtIJL/5qmwLHyzEDPEnqh8HztVpvKqhd3cFPjPRxwfFjyHnW2q7aRLdXnX8uTAY+9EcpFLH4jMtzMPczMvUxB5vHG+NW+jEZUJIxfDXTCl71wNS/a6JKfw/91T4w7my2xD21EqXltfZiN8mjUd+8CMUOreX7vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778123845; c=relaxed/simple;
	bh=v5b0bO4IYPY94fPXW6+PlvHeAXTy1iy7DmFyjIg56iI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hwbiYVloPywwYT4ICs54rk7a4F8Njnom86E+FzushFRs7U063n5anXzyY3gp1ju6J7JELZP8/spglWQbs6JiE4LRWy1hXahzbJOyM6xMGTRBVLVayCCou3vc17nrSmADLKJxLcUUkza56l6Pf10s/2HHskTgOms8gyjyc4+DLe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vJQC8e9X; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjZOMvXbupZasEAId5jaryW8hBvYL4a8wBBFAF/2FOZVdvecrJUUtFvccSafMSNJgBqypYA4tTabnuqOpXmuCx7tnpQNLjYSkVXDJhUrhQxvraT1GlcXs0vbgyBL/wuA3lO5qyMycEksFYm5Yz7+F3u3nlQ2qTSN//pjvTQgKTZ4wuH0JE4blEjXsB6ZwIak87YUNNzI6ORRh57XwHk5JfduL/55xZ4EYWrk+fmRi9sz8C0Zt51YyPsbKppA8nnPibPd+BPE2G6ef3L949OeTPXsW98jAAImgcCPEC0QHpbKq7ng9L2S3AqBpMV3zYYKEpGjNK0H3Aw9fO13rJJ6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHYeVsZlYDuwrT66+RPKXe9mu5xt5fLGZJCRXG9QAmk=;
 b=PczrFe3WOzFQ4E+f+4S846b4D1AnLu8hqp/PYQ0QSFMHZyfF/GmjyB2om2nytjbN3nx5MlzJRrFJNLzWJAr9RqQXKWs3YIM+CMS9YJm0FoPu1pKTnw2U51Rf15cMhPAKaa8n1yG9uQGuNBz5zLGEwClrlomsuMyuGCsnpFH7UErHJ9IgnR4LIiN9TYbMZspY1bBPY13PW9RCxbqWeMRtNdtuTdv5nquyUvu1twNBT9BNiJ82yNydpp7pannuEeCcX1UerA0xfzmvRd5s/4Ks0SF/8ojr7jcIdHWACdP6IzMmPeYv1K7oFDPHj2tR9vTtGD0kfVvmKxWPgHYYvh6gXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHYeVsZlYDuwrT66+RPKXe9mu5xt5fLGZJCRXG9QAmk=;
 b=vJQC8e9XvLYRO51vw40rhhX8+aCW/DtRdRbCOOOj1ZUe3Qjvj32DgJYQLsCAcUIXYD7hBkL/rBFH4JBN9qktge71MtNRyd1BsYtPE3Xl+mAzi68G5v4ps8BqkF4Tf0GHJoYpFk+kNqk4T+H8KSniVjp0UaoGxReFF2WkosKRzUc=
Received: from BL1PR13CA0211.namprd13.prod.outlook.com (2603:10b6:208:2bf::6)
 by LV3PR10MB7940.namprd10.prod.outlook.com (2603:10b6:408:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 03:17:19 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:2bf:cafe::7) by BL1PR13CA0211.outlook.office365.com
 (2603:10b6:208:2bf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.9 via Frontend Transport; Thu, 7
 May 2026 03:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 03:17:17 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 22:17:10 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 6 May
 2026 22:17:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 6 May 2026 22:17:09 -0500
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.196])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6473H9nd2726995;
	Wed, 6 May 2026 22:17:09 -0500
From: Kendall Willis <k-willis@ti.com>
Date: Wed, 6 May 2026 22:16:45 -0500
Subject: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent devices
 of wakeup source
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
X-B4-Tracking: v=1; b=H4sIABwE/GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwMz3fLs0gLd5Py84pKixMy8El3LJKCMYZKBSUqaoRJQV0FRalpmBdj
 E6NjaWgABkJSpYQAAAA==
X-Change-ID: 20260506-wkup-constraint-9b0261b04df1
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Kevin Hilman
	<khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<tomi.valkeinen@ideasonboard.com>, <sebin.francis@ti.com>, <devarsht@ti.com>,
	<vigneshr@ti.com>, <vishalm@ti.com>, <vitor.soares@toradex.com>,
	<ivitro@gmail.com>, <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778123829; l=1442;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=v5b0bO4IYPY94fPXW6+PlvHeAXTy1iy7DmFyjIg56iI=;
 b=5ZwKsL40rqmXK7xp/RQM7zaU24Kk2vk9zUb3P94XDwGJI3/M+NZXSIn7Lt/vNuR/XhI/P13iv
 P3BbqeQtFixDFi2l1S9CnWLz1RFMYaueR007MTV9o0au6QLqG+fml8S
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|LV3PR10MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 366860de-7b81-4d0b-3025-08deabe72514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5uojdVGdDObhNgWTcVmK++ThAK8hZexKA1rX5KlPXdR5Hqv1nAPvct26WSVnNUYihzBQ0qkEB38VcmO9jSQrKE/+cerUn8ma9sb/CmsOhxFwvBQagRdScYuGkROwAIdChG21YClx1EHDCTNcVUnPbzKOWhaqP9YTVS+g1eOPs0D6WctjfALkFAUF5JeyPgGHhFDqTgcSg3r297MHAd85txkgOPkfahd+Om/OKFI2YmqLppnUYSo/W+zFZZb0Uj1UWZwZ5H0riCJSYYlNvbevXOsE+/cGAEo8cpF5fRZ4lxGKDGpcsxtoJcHL+8QxmbV5D81GmDNA1SqQlslblkx6o5S4OGSKfTMFAVlGLihQADV+ylznmYr6Rc394YbArPWEmAAmB3GTAVMiQ/2HNRyD8Y9sk76YUydht5EMLYtdUb1n+K0F5OOTUB5ldo7RmP9vNEzp9G7srdR8zhHOKEB0Z+W3xOJ13EvbpFUNRKv4av2SakwiGUz+pPqkJNqEyKtIX3wvAsjZwyjwJzp3ulKhWbd4kXnc/M7Daqele7rm+RdKn43adB1ULh7Mq9wtz17DJ9USH7oJMhNh0jfvp8pnPR1qgZ4S6twKMCRt9Ff5M1ytjIfUvZKo51Zsu5+Mrs9qpGuKnS7IsY/xBjbRYnoIN6+tU5m/VqWzpyNTr/7lZW0qwmPCG2dOklHOROZxJ+nsc0DPt4q4lkFC4oyZwv18gup51f7wW9x9gH53I4tfONM=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bkw3WWz/UmDDREdeAgSFOmsKZBoh6X+GtDMsLSoTjGJkZnSIsb/3O6TOFL5yy+1Sl8w+qEG6CaQgk/HFwq0va8O5BqHxgAXfNmpsUWkO6x59Zt/Pxq9uxSbXac/TRQIk3VKEpWkyvZzHSx851MJJg93BmNI1/mRbJBZYu62bhNLQdkdCjVme3e1hOzyiIp3A1O5bS5DFcKYWcl322NV/QdlYl8Jfuqq3T4cmaH2hLby304ptV8QTbPLaMxsRlgPdEXRkGVPl6lymsTDa3XNSXzDVln2zPUlreTy3yPL/yJ6zbkE2asMJf26ToEOCFxPuUmfr0iNvEZ7jlDNWK4t6hQ6FUy8TDvOIS4WgFGNt4ZDRh2zqg0MJbgwkO3f2lh6RY6tkhccXEg11cMFNuNry2G8sJZ6nZsAUhE6cM3V66pmfgA59/hSbLEonWscUiuWC
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 03:17:17.9840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366860de-7b81-4d0b-3025-08deabe72514
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7940
X-Rspamd-Queue-Id: 94F104E290D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-244485-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,ideasonboard.com,ti.com,toradex.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toradex.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:mid,ti.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k-willis@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Set wakeup constraint for any device in a wakeup path. All parent devices
of a wakeup device should not be turned off during suspend. This ensures
the wakeup device is kept on while the system is suspended.

Cc: stable@vger.kernel.org
Fixes: 9d8aa0dd3be4 ("pmdomain: ti_sci: add wakeup constraint management")
Reported-by: Vitor Soares <vitor.soares@toradex.com>
Closes: https://lore.kernel.org/linux-pm/c0fe43a2339c802e9ce5900092cd530a2ba17a6b.camel@gmail.com/
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
 drivers/pmdomain/ti/ti_sci_pm_domains.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
index 18d33bc35dee1b3bf6107af1e414db377d515199..949e4115f930b93b18216fde46131b5c8931c9aa 100644
--- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
+++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
@@ -86,7 +86,7 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
 	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
 	int ret;
 
-	if (device_may_wakeup(dev)) {
+	if (device_may_wakeup(dev) || device_wakeup_path(dev)) {
 		/*
 		 * If device can wakeup using IO daisy chain wakeups,
 		 * we do not want to set a constraint.

---
base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
change-id: 20260506-wkup-constraint-9b0261b04df1

Best regards,
-- 
Kendall Willis <k-willis@ti.com>


