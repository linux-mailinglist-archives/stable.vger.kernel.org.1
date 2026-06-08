Return-Path: <stable+bounces-262093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SkJUAo0FJ2rQqAIAu9opvQ
	(envelope-from <stable+bounces-262093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 20:10:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 221656598F6
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 20:10:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=dBURuuT9;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262093-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262093-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C699D300BC82
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C787368D6E;
	Mon,  8 Jun 2026 18:10:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E302E9729
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 18:10:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942214; cv=fail; b=RD592TYdGdbnO/b/IA/T6mjQt7amG9qPFf28WKuq9h4rMci9J4evBqA6mZilZsq41xKO+6A32mxRRr3UTBjuH6yE4A0jpTbHS/zlu8vfa2pXqivzWVPeb9SMXpqRq88bsKREETVs2NssTBSCFxqri82Z9yAqqakj4ql2i4yupFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942214; c=relaxed/simple;
	bh=fLfsaH6NtoikyoGfO/Qjlaf+JxfVTYpCEisVnOaX4eo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D2xNYC6syA0abXphcbVhCOmE75y3rnNxIBoS6oYqcL/26VyqRZriw6EkU+MOhboCeABIAWRqJVCdTKN0PDSjYIrS7aXAZqBpz9CiZ8BxjRSvE6IUnDKxa3GwjyxvtEl51cHdd8ulCIyNPUsxZcgABjfuqkp9aDQ+U4//cXD+cMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dBURuuT9; arc=fail smtp.client-ip=52.101.201.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L12S8114G2WPZDvAWAnM0kpagKw+xnFfAIo9jDNXSjMysm/dMHLehwwJHgSYOxEuFW7/AxL+H5YAH8e2aWiSD00sDJSghTQ8KOYr4obee6Ktj3TK+8kAwA7fwRamXINAOa5JfmxofGLqBjevV0zwkgihyZNurkffv+IPhLcbETdLHfLdjiqNJ/5KvNo0BP2CDDGjRHLkgdDePZvo05Gkzm93ccpyuk31VRZInNUx75+9/Hd2PVp73/3UovhzoZG2mQ6W5UpwkVQPMBoObIz+hNgihzshy05GY51be+jOtSe6hcwucQYkPSbBuUlj+l6jWUxncfMxHb6HylgPllMr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dy1k6aoCLXX+zrz/2o8VTh8qoN9YMrt9dofiaZv3mqY=;
 b=Sz1A3gDFP7u1S5fDSbcw6/Iy5g8hKhXdjnJK4RaunKaACC17D5W5eBFLcwZmc2VvU1K0RgVVzNqcx9JSksgVAOPbyd8O7sk7cHB7WlR06EOrECnIJ9eFJg3SWagCuzYFP3ULImGxLmCh5m1UUCDnGseOTbpATZ9tNeFBJqn1/BA35Wx3Fgj7JBVeO6tPEVm5Hb/fUjHlrbEYia5DuhpSeW9jatPWm4wDmtJPfm73l5z/u0X53CfjvuYx2+xJ5BQOnf7UleWcRA/nyERAlTo5AqubaqatfZcSSHImyK2zsi1UKK3bbqd747so1wNLrWygFSZEufEolSe9qCq4/AFQDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy1k6aoCLXX+zrz/2o8VTh8qoN9YMrt9dofiaZv3mqY=;
 b=dBURuuT9qsr43UwsFE9uU7nDkjQqxDKYXiKlfFySDHK5S16sKVt2EKMfumkMYSFbh7QclBM1slHcaACyYvE+vIpS16RTHiBlbmRZp/fl7PhANcxxFlr37Mtw6Z+/AOQPvmL7SGddjVhev2kHDmoudFkmx/+6JFrGN5HGYKNRSS8H4q9ytzwAOGdSilCDFVMnreZxTNk06lBx9RQkp2NSwTWmjjw2A+fffAN2vOmt3BfXIzjw62SoyK1V12aqQES1z+5FztJ8poWgbSNjkanxNcmQEOEUVwdSfmjgV7KpUJCzoei0G6OXixpN/4gYSnLzeGj0pWZVo8SmAd91H+YkQQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF6E99B1BC1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Mon, 8 Jun 2026
 18:10:06 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 18:10:06 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Leon Romanovsky <leonro@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Lord <mlord@pobox.com>,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH rc] iommu/dma: Do not try to iommu_map a 0 length region in swiotlb
Date: Mon,  8 Jun 2026 15:10:04 -0300
Message-ID: <0-v1-8536728bc89f+469-swiotlb_warn_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LV3P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF6E99B1BC1:EE_
X-MS-Office365-Filtering-Correlation-Id: 79904bf9-b2c6-4f71-d324-08dec5892b1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|11063799006|56012099006|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	h5wo4zvtbwSxkJyZY3AmvM2nw361aH/T3UpgoFBe7MlZ5n+y0oVpFxK2bXho61VlsysUM9d9APpMtDpGavK+YN+dbVzNq0ofIOtgTPV/3IX0QfVx/oqgMdnhKixVinWlglty5Zt6Xfu9cOBi4VJmaJ/dTeaFLib1H1tABeLOSy6cxtyQqZjTBw6Eoyn9YvP3DQu87hMi0YsKHCr5hktpAPZrmSszwkCI0ttNvZspzxd4uV+nqCytYbTw+Yxnvn6Zbl3Ll01mfGvAY8jE3WAee3ueOl9j046FQj4gTFSm4gIEj8aOQkOenNkaFoG3BzErULHYkpab4xQAZTHyREQLibLfoIaux8gZ+2eAYVlMfNSyqtFwqvJOHMoZO9du3CO7WMr92PgaCYuE6nQgb/lV8AnmTFSkl4fgGlDykZ+s2B0lLjJclE/Z/IuAuQeqvsQZNiBBuTevR0kRCV//AerGHujnraswZ4S0F0zvp9L8VXIGucf4BqTj5pzElfoSiS2mzfrXX+9zAGvM8t0V3SWSPHrsxkFzfQSFuGRxTL3oPQ2XiUrl3/m+kfFZAhq46pmqeFKiHKp3qIB5FCsQ4/ObAH6lK2/qSataLzGQwP20BNrUTk/JZzxPo2cle+90honvb7xcD/C6h/hEpzbkZfeNAMm1kom0wNcjPgqHEzh575ROSB5+f9r7CELmUVISRuwa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(11063799006)(56012099006)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pR2w3e+6/eCVAuRswKiZKZMInj+WmZOfIXbN/JwzTjb4aUTjLYtFm5Cc09Dm?=
 =?us-ascii?Q?Z6NImWQigObmeOxYc6lose4yo/PLv+4SJQWuPRLnPd0Gcy0AM6RidtP3vypb?=
 =?us-ascii?Q?bEb8mli7Z6cCCVSzM6zNUQMUjChSK1WyZ0NOdHgpKiABc9ALG5D9BfBSrLOa?=
 =?us-ascii?Q?+4C0GyR9nO/36bbVDGmuuU9lyRvS6Y5ME6QVl4DT4Nz638mw/Rrpdwa5xpy4?=
 =?us-ascii?Q?kwj41AZRy0pkZ2CKUkCeyk5a+u24Dve5FNuLcKT2nXp/k5A7LJ5VhQhB/q24?=
 =?us-ascii?Q?kWvevtVrBQOAgX5nIRWu7EEiQ3tHOu3rxbKhZ1gvNrbf5+Syx0ktXFmug5rQ?=
 =?us-ascii?Q?YiNz1K/21OTNcmGY0olsFWMeAavu6LnxNeSGTY53hmTrC2E4VqeyVynAY7Ic?=
 =?us-ascii?Q?Jrcsm1ei2UrsWNWSeRatd9cM1eOffQM3kIGcpMB5c7KDQfOnzkI2gOOpCMtP?=
 =?us-ascii?Q?w4SIOTMnjQmGsV2Bd1kt2jRbsmSSLbAMER/hEHvTtHBnsIO6aTIjE+64ePPY?=
 =?us-ascii?Q?IHhJlEXrpawwFh5Y3pavFZGMsBGYoG7cwnD6/gbEpleiIABpnLQzR1vIBJSI?=
 =?us-ascii?Q?HnaQJHM4D5lUh1qhf5S71GNfkj+RQWjun3XGp9LbyHcuASqNqrsd6k4C9Vgy?=
 =?us-ascii?Q?nyq/AGswICIzype3NBelMC7m0OoUtnrbDoWIWofRJ/M1p2hTFQ2YXk04rTIg?=
 =?us-ascii?Q?xIVGrQmMfg+1tD3VpYgdVFSroISA06pcYLm8ArdFYqv1x2r358TA1HATa/TE?=
 =?us-ascii?Q?2s0RDsIIjtdQmi2Tm2ETjk54rRuRnxRhcbtPKPV87OznrYCwqorBr9CiQdvd?=
 =?us-ascii?Q?AnNH9adXd3gonscuh/IPDsgrvR37rL2YsYAUudQCH7d5w2RCI7aMm1B7RNVI?=
 =?us-ascii?Q?ve5e4qw8bgs3UI6FfHMta+VmLM+j+HUERRxzZwF6kMNzOOU0ViFEDV0OcHWh?=
 =?us-ascii?Q?8nyLbA7YuEM2qdVkEGR9zr6UHpa1snv53BIZcGHRBiNLftcLE1jZqW4hueRX?=
 =?us-ascii?Q?eCXW7LQo8cZoWE/YTIAU8PUB/FWsxgJ4WZuNCYm1P5rVMxwlMRoTnZuP2GPg?=
 =?us-ascii?Q?m97L4xCfAiCqHukY5i+HR5GuBEJyS6hie6mjxUskXrxpouvgoHnfEPyf1Sdm?=
 =?us-ascii?Q?dpw+SmoBPkdeyeqSnL3qypH9feoCdwhb+9HSseKukRp/3GC1TONTOFrEU5qH?=
 =?us-ascii?Q?I8g1NFdQersxmyTP5xVu1eLQEAK6A0S7ADPPpxo82o+1bNoq9++ogcL24iD1?=
 =?us-ascii?Q?MFTIOmP4OTRjcWW2uq+381QWpS+4N9zl0gdcIzlO4TacTU78AxmsXVx0Bx3E?=
 =?us-ascii?Q?vb3KFIphVpGl+Kcx64Mwz9nu+32B+K+GLvfsYX/2lEyfsAgacgrRQExizbWZ?=
 =?us-ascii?Q?XPf7d6xeOvrKappUrw+kW5/TsnEJ/W3z5SaXZnPk4svjVJ6VM9Ug7mVIcI0A?=
 =?us-ascii?Q?7RvyeQp9wpmiyQZvRv9t+PZAGpeCUAUMDzCAU7FQTdfL75qX8bUb2hMJpd1z?=
 =?us-ascii?Q?UdppIEkY7DHu7/NVi7L0K8j61/8w8/kRBYtmSCpyujpziWVN2L6orQ2BZ7eK?=
 =?us-ascii?Q?ceXhmAT06zUDV0YwcGTnXaPL0WSxWPdCdq2Cy505aOF59NVjs/RVXFRWC5Hb?=
 =?us-ascii?Q?w2uO4Qo+1tIrjGpiN6D82kHxJX2wlrGS5529FxBYXuseY0AOOTVPiatA5R6c?=
 =?us-ascii?Q?/kIzhEJZFW3IsPqDFbmza5H36mkMXnHru04m4cHzqSOgq3xC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79904bf9-b2c6-4f71-d324-08dec5892b1d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 18:10:06.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjdcpRRuyZIDahLphBoI30+MerJCY8f30e0i+XRQAy4h4UQ5spZiYPsdNwmXDJJ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6E99B1BC1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262093-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:iommu@lists.linux.dev,m:joro@8bytes.org,m:robin.murphy@arm.com,m:will@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:leonro@nvidia.com,m:m.szyprowski@samsung.com,m:mcgrof@kernel.org,m:mlord@pobox.com,m:patches@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 221656598F6

iommu_dma_iova_link_swiotlb() processes a mapping that is unaligned in three
parts, the head, middle and trailer. If the middle is empty because there
are no aligned pages it will call down to iommu_map() with a 0 size
which the iommupt implementation will fail as illegal.

It then tries to do an error unwind and starts from the wrong spot
corrupting the mapping so the eventual destruction triggers a WARN_ON.

Check for 0 length and avoid mapping and use offset not 0 as the starting
point to unlink.

This is frequently triggered by using some kinds of thunderbolt NVMe
drives that trigger forced SWIOTLB for unaligned memory. NVMe seems to
pass in oddly aligned buffers for the passthrough commands from smartctl
that hit this condition.

Cc: stable@vger.kernel.org
Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
Reported-by: Mark Lord <mlord@pobox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

This was discovered because iommupt errors on mapping length=0 instead of
making it a NOP, so it is an became an issue since commit d6c65b0fd621
("iommupt: Avoid rewalking during map") making it a regression this merge
window.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 54d96e847f161b..381b60d9e7ceaf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1918,12 +1918,18 @@ static int iommu_dma_iova_link_swiotlb(struct device *dev,
 			return 0;
 	}
 
+	/*
+	 * After removing the partial head and tail, there may be no aligned
+	 * middle left to map.  The tail still gets bounced below.
+	 */
 	size -= iova_end_pad;
-	error = __dma_iova_link(dev, addr + mapped, phys + mapped, size, dir,
-			attrs);
-	if (error)
-		goto out_unmap;
-	mapped += size;
+	if (size) {
+		error = __dma_iova_link(dev, addr + mapped, phys + mapped,
+				size, dir, attrs);
+		if (error)
+			goto out_unmap;
+		mapped += size;
+	}
 
 	if (iova_end_pad) {
 		error = iommu_dma_iova_bounce_and_link(dev, addr + mapped,
@@ -1936,7 +1942,8 @@ static int iommu_dma_iova_link_swiotlb(struct device *dev,
 	return 0;
 
 out_unmap:
-	dma_iova_unlink(dev, state, 0, mapped, dir, attrs);
+	if (mapped)
+		dma_iova_unlink(dev, state, offset, mapped, dir, attrs);
 	return error;
 }
 

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.43.0


