Return-Path: <stable+bounces-244632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNYUMLDm/GmGVAAAu9opvQ
	(envelope-from <stable+bounces-244632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 21:23:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B4B4EDF8C
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 21:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1429730600B7
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 19:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099747F2FD;
	Thu,  7 May 2026 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J3N8fDoR"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07C481673;
	Thu,  7 May 2026 19:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181747; cv=fail; b=gRaqqIYl+W8UtCC4XtyeqCm3EfT5GAtifzOZAyEGF+wFKmDWDKcvabsBEpeZoYfN2WnuW2hQFVpha+8yv11ODVZr7UQO09o9P4o4+KOXJupy3yAJfMESg9EosE4mcybd1benb0vYRHen/TQGKwzo6d3YwKaXx3UbxBKhdpcZTnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181747; c=relaxed/simple;
	bh=MDxJfxf4fG+N6a1Z+1YhER2NXBHeOUH7eJ5HWt71dEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d8os9/2+xDp5VHh4RKf0sQlV84IYKUEVb4CER9jT5Nr67W0l4HAaAagvKBAVtSY4rt4W7YMqJsoCCFX+JJJicq6wtzvD54GrssMq23vu0rbrWz6T8NHdue03DGVojqtsjJmaOCQX8DYecbOQqwyIK/kCrMKXht4FTsoJdc6bL8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J3N8fDoR; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kf5pnCzBg/S9TdHcW4P3YDw+Xmobd/9TYkiTnOdh6ZRnx89VIsTh1UhWsmo5PBB4kQqyEQtUOYGQUWhlaG3IbDXWYwbCs9aDEkjcP3gcwwAr0R074y0LieIvOFYzX24BekkuOfakKXWAVW3KmfdPW0WizDO0DqUp8/IPzKflqizFqkbU9x/f82oilFMjcdn8MeMqawEh6LS0m5G33uH9w9affuqGfb/mSdffyj98hDOAEIyYq7LVa5hmZJ41SYs1kPuF0NWAgdBtEJxb9UkhA+F4SrHlKWinkjZFeJd9CQh0T95W/uDFdy4grD6p8InkEEp9KMh9YGEG8nIkyCl8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqD7VuA8ZZUSXNRH9OlTUJF80pu84KcvouIJd+DTCCE=;
 b=PQ0hQU+1nPjRYY1zqEn85b1ws10CVIG1BuJNhTA0eKEbf7Cr6FV4hZI6M3yC9hWfqhHugH5h4jcCxMkSbFxho2xqKpjH5+ftB0ShzvoaKNPWEEUVn5zie64c2+cwkeUkGl5O0hsj6GmQQX7BvLsTToFhnTwxBVXDHPWe+6PhLhEBgL0G9hrEW1xgYpi6baw5S3QZXHHeC6yTuic/tHNKH+F6l66Ekrr/OA9MupTYWaA6CeQMSvjedMNot37yx5BbyHb8mPHsOzYIK2IWGNZiNL+4PMe0zrMCZEarZ36xA7ZFguRmvCK3UAcabz/AQdvIGh7htY8L1/jnrzNeH86xNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqD7VuA8ZZUSXNRH9OlTUJF80pu84KcvouIJd+DTCCE=;
 b=J3N8fDoRkxk82bgz1JBj89yiSFzZ21sD7RiPKtYGvN5+b2tO/QMyFNTypycNZzcuJ8aDFe+Q2IJExi9ZK+J62EsEe6/0wQLUegTio7JG4fq9qM3qLi7G3TBI7+Rxp4ZrIM6jmKgdjlLA3wu/8KCxkhG+4sAEZvnbrBNCrtwZMegB0ubHlleWF522xP1Emk6Vrz+JVdn4Vxdl3CYygVGxx7TTfM1yxi3seAbocd54uuDGwsWhJzryYKd42ZIseFBywRT6+K2Xi16KvPk49UOA8Jiwopf6paz8Hs+ORtqHAo0Pdm4WZ5nrRNDXAt9jMB4RAGnvIVGdXFBjLZMjF0nIOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 19:22:19 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 19:22:19 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: alex@shazbot.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	kvm@vger.kernel.org,
	jgg@ziepe.ca,
	rananta@google.com,
	yishaih@nvidia.com,
	stable@vger.kernel.org
Subject: [PATCH 1/2] vfio/pci: Fix racy bitfields and tighten struct layout
Date: Thu,  7 May 2026 13:22:01 -0600
Message-ID: <20260507192206.1350046-2-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507192206.1350046-1-alex.williamson@nvidia.com>
References: <20260507192206.1350046-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::8) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7cec18-0ed9-4c35-6ba4-08deac6df3b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	E1VBostbLTy/ER+VaLoBV5dr6iS3pa84TlqipyXuqP3aviN+W3jOcPSMN994bfYtZNuH50c1FSkhSSdvbX1dDy6DtBAjGO7ycM+z7X4ou9dWQjOqgrHIrvJaUrU4NFNRM3l/6IKx3uygaksSUHPrI0smp6eAIyu7EJcorXj3XunYdc8FL+cw1vJ9NQEBdt6sqHyNWgoMo9k7J+QlgXGYY2M7KlR67qsOC49MuW+fScMMYnYzpOLsptxa7lHecR/aDmhhj9UTJOkfgYENjMyOZwdSaNMKOvB1/vwO5gJrBBLG+JHyWsPmWCv4M/sHlQJSXkG2RquUzwvZfgx5RvbpaSQzdpwP/hMA1y+LiRx0dy0aeZa3dnLwrEjBF3QG+L3FWnRfUWO7QxjU5rcZyCa+uw2vmcb92BSz8OgdV5aY77quBfY3Ze+XVKb8ShEvnma4bsNz18PXUHxYkkeb3eVxk7npbkR2/owibZxOPlgGHJzAWThXTAds33f8gN7mTPw0jBvgxLa1PSWUgjYRwkZCwiSW7gjdHwCNMlSakVCSyAjU/QXc/GEa6sJ6b8h+gdBwELjtQVq0tMEWF30lvrbaK8iax4C2jKXy66+N9yUwhLpez+ZK01rJ4E95e9/aAzVuaYoidH19ETlJRRNGLt7ZTgEkhxGelBgQGTEMHNO6Ztydm1sVOkI6F1tBiaPOXoYC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dPBSeI5nOijZfGGNbcQFnDqNAqj0iF8RaaJ001r+xz0T86F/XdFchp9IHA3F?=
 =?us-ascii?Q?UnV/TfOoxdck7NMKNLe3lLPOejUSO4C7qjsCuPVVxAfJn8ofUglQ6MZyR8XD?=
 =?us-ascii?Q?GCGZb+5FAzaTtWyj508qrnnnaawcMC4BlkIuNrIrU+2N+BWhxs1ldlKQs//w?=
 =?us-ascii?Q?JLUA1rClVr4TrRdYPmTx4hf9inezBK+gLWaAE+KguvXIt0sotTmTSW3VEMiA?=
 =?us-ascii?Q?mESYXlauhtBdOS0GQHP2dJxlcb5XWYsXkyO19ojEmg3ub4PMGQrxWAioQ0+N?=
 =?us-ascii?Q?m+9tAKXf/1V2BrlNBKnX4i/9fi+Uk2lLdFBAgMv3LutXYklahkDyIs/4vU9E?=
 =?us-ascii?Q?pNc5N+9HsvHpnr7KJpwb1bL7edfSeAzTmIaROkBg6iE3koXJzpd2eEtKCCNZ?=
 =?us-ascii?Q?DrqfCruk5Mb+1PBKiJYgOp2l3CG30t5mk/iQb0udwhauI9rf9orMKCTCJaC6?=
 =?us-ascii?Q?3Y9nJr/xqMjOk/IXsyzBgkuQnttJjDe9tVsYLWrw9BgakRW/8FrocmTFcihb?=
 =?us-ascii?Q?6vlGp4WGU9QApzb531rxlFTzDiGgl07nAzgttylLdQ16MPNQ3s7kI2SFDrSa?=
 =?us-ascii?Q?50d7mKZVfQkY41i6cxNpGDpMPNG5IaLCb5FP5gpK05NKTh0UfTxiB6RDCZMH?=
 =?us-ascii?Q?8ZIyluNmyx2m7RlKV/uSH6867nZtXUG9zGgUvkeH+pJ+zsGZ/v3hgO27B1iJ?=
 =?us-ascii?Q?OYh51QL99GNJyWGWqUMNMNGI6jLj5k+O+KopZtq/HDGt/6NqK0trb7iZ7E0h?=
 =?us-ascii?Q?dHrgjOvqT7D/Cr5O4FTfNxmEYSiYmiJuKZlFA29nyndMrcs5piV0ZningFun?=
 =?us-ascii?Q?LNg206mlwwxpKLOAo/pNlIIW9NHHW2vtiR0DkoEZjYE+3S+RIhZr+St17yu5?=
 =?us-ascii?Q?f7O4y111l/rCP7+4yDhDVky7o5chvmaHMbX59YNbw8/RHWjITYLAkO63Li2O?=
 =?us-ascii?Q?TyZHP9kvbeKGsub0kOsZMuTvAbBqfCenRu2hPoo3/Gybn1siuu9KFUkPDTpQ?=
 =?us-ascii?Q?QqM7XhxNfFOtB3lcE49LR6w8ehx670rchIZ3cOuMaGuosJdZqPSZwLPO1hpb?=
 =?us-ascii?Q?zE22+obhC4ZHASjAZQmDvyIVwajoKANqezzyQk7gquG4UCY1AxY/MXMfr6PD?=
 =?us-ascii?Q?ISn0/iELc7fHmfhUajREFryYCa4fGYCuXKAoRes71vMz+0xMuatM/J2yTQtW?=
 =?us-ascii?Q?NlpuyzkrEfiday4rROkl2gOuxSVmANZ172ktvzdP8IZUU8Dxnxd7qA/I91S8?=
 =?us-ascii?Q?1dS1tlsB07JbisAjPPRsJcMsGgHUHB/UW/0R3lBCZ450Qcrn/8LMuKrFCd6d?=
 =?us-ascii?Q?ns/81DETpTAkIXIlgVyffTsQJnxWHdD7CetENHf2Df4FDAqeXW9RE5a4N8Lw?=
 =?us-ascii?Q?6vrqIubRzKv6D9Gb/KzGHOIKFPMmcFTVzhQwgJyQlHzCpxsoCxAKvYHb62VB?=
 =?us-ascii?Q?KVUGqJVLptA/dLJcqy6jiQEnoVxWMjVIsODQAegDL5D6xCHO7YQXkvo6tRGC?=
 =?us-ascii?Q?1YoezCDP0fy0NyAEJNjyXz40ZgKP5/g/EAi7/AtHyYhqvycx5dEW4WF0ushe?=
 =?us-ascii?Q?JvdGeyBrLCO7vLdkFlVDcJITFg9r3NDQ2QJoR4vM6qMAvXV69GxAskcrgU1d?=
 =?us-ascii?Q?JxNXLU0wbRhy1zz3q4HDsIy8PwoJS/epvZcRJMjIFpBzbwOGVtsB4wxsIXIR?=
 =?us-ascii?Q?CE9D12Xjpa6jtE/4THn88B4Fr/pDkJxMIgsOzTwOyi48c7rzmqhtfNlrnu6G?=
 =?us-ascii?Q?1+IE+uuLNA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7cec18-0ed9-4c35-6ba4-08deac6df3b5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 19:22:17.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ck1HNwwRuARh6vnUVaUbFStfsLyL06xOMOp5GakG9guRb9vKsXGVpfweNkplxLyFzBMVislLGuGG8yu2yEJNow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
X-Rspamd-Queue-Id: 85B4B4EDF8C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244632-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

The split fields (virq_disabled, bardirty, pm_intx_masked,
pm_runtime_engaged, sriov_pwr_active) are mutated post-init from
contexts that don't serialize against the other writers in the same
storage unit, so a bitfield RMW could drop an adjacent field's
update.  The remaining bitfields are touched only during probe or
close where no concurrent writer exists, so they stay packed.

While reordering, place virq_disabled and bardirty earlier to fill
an existing alignment hole.

Fixes: 9cd0f6d5cbb6 ("vfio/pci: Use bitfield for struct vfio_pci_core_device flags")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 include/linux/vfio_pci_core.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a39a13a6576..8bb3fa0e41dd 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -101,6 +101,8 @@ struct vfio_pci_core_device {
 	const struct vfio_pci_device_ops *pci_ops;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
+	bool			virq_disabled;
+	bool			bardirty;
 	u8			*pci_config_map;
 	u8			*vconfig;
 	struct perm_bits	*msi_perm;
@@ -117,17 +119,15 @@ struct vfio_pci_core_device {
 	u32			rbar[7];
 	bool			has_dyn_msix:1;
 	bool			pci_2_3:1;
-	bool			virq_disabled:1;
 	bool			reset_works:1;
 	bool			extended_caps:1;
-	bool			bardirty:1;
 	bool			has_vga:1;
 	bool			needs_reset:1;
 	bool			nointx:1;
 	bool			needs_pm_restore:1;
-	bool			pm_intx_masked:1;
-	bool			pm_runtime_engaged:1;
-	bool			sriov_pwr_active:1;
+	bool			pm_intx_masked;
+	bool			pm_runtime_engaged;
+	bool			sriov_pwr_active;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-- 
2.51.0


