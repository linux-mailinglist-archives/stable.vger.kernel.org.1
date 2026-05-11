Return-Path: <stable+bounces-245327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLTJAH1VAmr3rQEAu9opvQ
	(envelope-from <stable+bounces-245327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:17:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9F0516A9C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 483B63043FDA
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B4406264;
	Mon, 11 May 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gIk8HPeB"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFA3C1412;
	Mon, 11 May 2026 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778537814; cv=fail; b=h9xenEOWzppWtF8sCRFIeztsHeDZzzN1f1h9WQsdRwUWru4QpJUtwF4IdbCIPydOKPb5zpywBd5XnNeM0xapAUPAsNhN2N9lNtgUwEi5YW64snchuZ/xM3dRQNQpopYvd1GKOJtfbsmmwExZ/1o4u/p/xMOdzRxmcgyu0zsCW8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778537814; c=relaxed/simple;
	bh=HfgwYls86RaW7R9E0jyTZWuKDGMjaXg4hlyD7cMcBu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XK3zCAa8dP1SF41Iu9hKRPf7Pot9Ah7kcDOoWef9r1vJNvWuKL7e/qZlW1Ij9O6ZEqQQ5MIePodB7CvAd+q7AD5BYdls07f59oR5GmkRtWUE38zGeg5ZvJXa+EcJC/hrEZeGzV7OJwrmPL9ARc9cqfHsJumoPzh1hF8lWnGhZSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gIk8HPeB; arc=fail smtp.client-ip=52.101.62.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+q2nyMdTGO+lPjq53s0QQfzlW/7I3pNg7wctPnU3tBSXrAkOv3Tk9zgzlywsEJ2c3n5KsU//smTM6YUBrL426rdujMtZjnotUPK4RSZO0BRaOczGXpB6TYncJCg4UsBoi6i/Q6NmLI5CC/nDBPUdJL4Do5EfPBJ7WCKo8hBZPw3ebpkoP7jP68J8uV54fJyZEzj9XNmWo34Gi/BtnfssRix/TEobbp2QvYFo2Fy5m98E3qLAc0NK31Lbc8pe8PnRyQjpdVhJRA+DbAE6N181nzY9HGg9AHWeapruI/dsxw2aX1Oj8h41mk+YhKWbpIDr78pR7PKIOgsIUwNn6fMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLBptACWEuHxRTLLKBBFt/5Fwxq0JKQkOrUKj5zB58I=;
 b=XZzc9CMY2Ha21BXjz8yuVkRWQKjocpJfppngZ4fHEFYsqGoNXPDnTaYbgjbLJO6AKR3U6H2Fbd0n06uwcxu9bJ2eHJRQC7S+Ihs9oytEh02tbHYbc+gk4kv6g/3F7Nj8sNaoZedxYer8bMwIavaIbvHhyoy8H1HQyoM8jVlaRwmIjA7xglHu4VvNzfXH8x6pIFRWbRHZ2jyvzeRaYngb/Oj12iSsQh3l4FGhyCO6x21SHDtCnHFG3RvAkXNcAUe3czR3sTPYiUav1Q6mX5vIHbCprUebVpyJsbLWSvK8zBT97Di9fPCDd/rrZr28KxyJ+O/bpsnkHrYHQFYCLGX1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLBptACWEuHxRTLLKBBFt/5Fwxq0JKQkOrUKj5zB58I=;
 b=gIk8HPeBSygu5l2MaBUPDN8jc+w4CNb1ihihe6eps315fov0ofJnl0MeI3tQ+KiG590pMYqJK3lyIQDXCNYbrBxYOcT/oYFanqPBA44xK/CffMYkT5XeTfLWuLyOJSF3pQQEylU8rPvF/rNsB1MjJanTQMuv85tVKl06IQAma76F1FdQEdArYJU7aQgYLnGvMdZ9vk9XQ5ax2Ni0OHXor0uZ4PpBrxHvjeLPn8YvgPHCohaqx7kEngllv7SjOy04Kjb/fI/13AEIAKO6HP4+TW6mWDCuZ4uW/82QuGzU9kzhU/9bJvdioqG3z+PS2Bs5IzYZ790PtJKtVp11ggQjXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 22:16:48 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 22:16:48 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: Alex Williamson <alex@shazbot.org>,
	kvm <kvm@vger.kernel.org>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	rananta@google.com,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] vfio/pci: Fix racy bitfields and tighten struct layout
Date: Mon, 11 May 2026 16:16:02 -0600
Message-ID: <20260511221609.3837652-2-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260511221609.3837652-1-alex.williamson@nvidia.com>
References: <20260511221609.3837652-1-alex.williamson@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:1ca::17) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: c5024a3d-2942-42c4-f816-08deafaafeac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	urHmcG2CYlZSxXTa6zY6mdyhqoAfncGm1g55wPrwxZ9EhvDUcX0DQSw6ku2Z0HLRr9nDyYAtyN+cvQ+Uy/XLw4yVpbJgpsYmI+YppXr1Urw3L3OYa6wsS9J51ECgkfkQF7HLi/U9ZgYHZFOOvl9cdsX9qvv2VjvbRvIeUedQD4+yD/0Nmw6MlMKBJB5Zk1R+ifI7KZB6Pk2DvfcfsHjGySyzU9EcFWbB4WE31jpgcYw4b2bkyo0yhZti7LRWXMArTFPPOzRdg6vKqGCJ1JPiHD33MkD/kqah7RUd8mEz01FKR+w9GpFrp6qTmj8gekbhOey2VXnThTU/Njf9+2zfZ6wUpw0J+QgjYS3FAn4e+3OqTW+jab4/ZRqZHtxv01Qon9HzJQTk6i27ik/pqfLm+SnYEEeJv7fWh9pGsS9kxTbrUlXlG67aQXy/etoq5MTTHamOgt+rUzB8apCi1sFgMKkHlMfKPJOavygHnL/hY2PcmP2s2L1ojIrdgQhTAL6tuoeeEVy3YCsFd+BDEpCZOfto/ZyH5Ex/lFxrbQ1Yx4aR8iFCOMv+W/s9S2g3AEBqQ/Yn76/lAbkDy/raz9tyBGptUcnB0IbIBdnh+3WLmO+bOtVTWi7yIkGAvPYnoVU/4y/ZatUqYyISK0DZ6bVpKcRZiA9GJEtviTbwcJ4hG41lGq51cK5dWHm2Q/nHZvWN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0k4HicT/auo4vTcm91lMnHzNzlvuzeMI03hbXLdrqTuQXh2I0Z7Nqc3W281H?=
 =?us-ascii?Q?iMnh04g9mWHlQXaX7hr3pIrlZn0DZ8UVxMAYDQ7A5IxLHo/6mQKFe/kADdAH?=
 =?us-ascii?Q?M9j63Huujm+QKvurMhYa8E7HlFLVb6X6bnIAIuzF4Tdfrtly/FRF3888ZL5q?=
 =?us-ascii?Q?TnDFtZ52Skh0NvYsX5uXr0qRSos3Kx+RnVT8pieiF4o3GnddQvHTjgyV8pUl?=
 =?us-ascii?Q?AcS+F5rvzhUn1X+WDKY/lKnCvJOQb/rRd4QmabmbJYTHbCuOu8KiVEdVwT2B?=
 =?us-ascii?Q?FQQJBqwBTvH7km6xLd7rC1slsZ/BZSQ69MIH8q9ZJ2hs70nlmlMx8RB66c3s?=
 =?us-ascii?Q?xDZfVQn+avy5WaTC9KRsNbarvugj+fSrGA+t4jFvHtrvrzKFlVLg7+5hh+ye?=
 =?us-ascii?Q?aRfowLm6UUkLVIN0lpRAsPc1yi3H/lBgzH4+E/QERuAlwXW8zhJxGxB4HxSd?=
 =?us-ascii?Q?H0GtoPiY3iSlO+cJOTWijvE5lUJjJ/DIZ7LmOpcoATFfPgSwu2E6qanYcLTT?=
 =?us-ascii?Q?vRE3/DXxaiVoyjqlYF1gLYYED0cyFHpKzSmFjY9sCShsaR9hUGk7F/+Xd9WD?=
 =?us-ascii?Q?ESqrYnz4QiDrAB5PKJoro1be183nGAwq4CIow/ta0hOR6G34z0agd1nDFQ3p?=
 =?us-ascii?Q?5AQpSfvPiHFtJd7I2bfN9qQBcBlHf30uER/cRsfcSL8Wh5gelE+O3C7gJMI6?=
 =?us-ascii?Q?Fylg/GAGG3j5TTo1W4bAelv/kTHk7mXf6sabb8mdTmvoK0xNbKz6aW39cKUL?=
 =?us-ascii?Q?AwdpcI40QX2SLV63IOkf09M3ztvDeeMTqhbQDxQkFFvFLQxXhkhH7O3WVGaN?=
 =?us-ascii?Q?FKLWpEx2HUNJqv1iXCQOKvbYO06P7+uTuQLl7sEOvsk13y9KjS4//3em7LhW?=
 =?us-ascii?Q?JKv4ZywBPGmNaI/DCdJ/S9NvnUrHSzXIydgXeuJJtNiM9w6OlKAaIsMUYGmm?=
 =?us-ascii?Q?27BkU9OZjeEcJRMM3eJtS2LjhimpKrOiI3HIUXzCLjGqmW8g9SzW02GorDBy?=
 =?us-ascii?Q?NrjUFIaUF6wMQyUqSFolKZDILA8K+OTNYuxzMaFlnSOlHSgYeTO8DBr8YGKI?=
 =?us-ascii?Q?0HV9trJM3U3UNtsYc43l8z1kdGeK+jLpm/Kbqu2nZcgtA8TibQvqIipaZTgP?=
 =?us-ascii?Q?kvi+/rXs7jC0TETkyXjQSaSg71J9b4/bveI/rTTp03sIFpLBIydz7wwrk1Sw?=
 =?us-ascii?Q?/UGgcb4+ymqMHAa2wo7u2FdQZrBmhOOjqqaAx8g/b7R95UsFpkuE8uVae3Y0?=
 =?us-ascii?Q?co3wSkaTKTqzOyQrtfgyTh9z2zUOLh4pjEI21AO0sfBvvME/ymb54GBfa985?=
 =?us-ascii?Q?6pt9Qmw/M313PYqxzpmc9thrq7ZiWGp1jaBg/1AVnryslyzv7qfPKZyMgSVJ?=
 =?us-ascii?Q?ZVX00Z6lQ6k8Tmblv0yKjc/8hHs+6DC9mQqXXrbztwPEK2YqxuedGGaQNVLx?=
 =?us-ascii?Q?bhSm6Dt+0GW93qgv2/F4rV2s71hCg+SNW/XdHC9exwnnaqilNUGqhy5loRiS?=
 =?us-ascii?Q?OTZPKtXQ7v3J5PJbv5m5bsdAX4OhHytMETnd17lC67cfC7X7WHeLqLJ9RAHn?=
 =?us-ascii?Q?YFREA9bDUmEEkmzkjteBv426TCeO//gshNfhRxKWC/KKo92DnSmAK3+mVdEL?=
 =?us-ascii?Q?KXFtOUqkRNvDd7TJNFFX00XVCUCkifOlP/dm+UT3Hmvihp86o5ZlMLZGyDpd?=
 =?us-ascii?Q?sxBGmb13cFamcaMQ9UxTNNz571FrRToCsBz3tfBfR7tBwgsTvtFjQVwbz4IC?=
 =?us-ascii?Q?YAovDN4hfg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5024a3d-2942-42c4-f816-08deafaafeac
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 22:16:48.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9BWzVJCOmqe5cVtrRsht4EVDxUtu8ymktQglhWOJvDKguy51XY+UXGke9vg8+8SrTxFt2xmKhTI9+bvj46z/oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321
X-Rspamd-Queue-Id: 6C9F0516A9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245327-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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
 include/linux/vfio_pci_core.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f..24e8db5b1c0d 100644
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
@@ -117,16 +119,14 @@ struct vfio_pci_core_device {
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
+	bool			pm_intx_masked;
+	bool			pm_runtime_engaged;
 	struct pci_saved_state	*pci_saved_state;
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
-- 
2.51.0


