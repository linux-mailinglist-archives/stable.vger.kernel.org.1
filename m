Return-Path: <stable+bounces-244633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMwIFMPm/GmGVAAAu9opvQ
	(envelope-from <stable+bounces-244633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 21:23:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BF84EDFB9
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 21:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62DCE3066A80
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 19:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A36247DF8E;
	Thu,  7 May 2026 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d4zs7JUC"
X-Original-To: stable@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217548095D;
	Thu,  7 May 2026 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181750; cv=fail; b=ehS614cutJl469XwygvRDjc64LPPj8jkhiDi8XSuu5UDUGLN5rcFdfh8UXc+4DMFeojZU+gwl+wJD20oU/jd+zRu4XRCzsPOlSORtsgEqUzUic0yJF9eHBUNnlcSwFlxyI2ATzBvsErFG6MaWCS2+kd4N0L9GIdVR7YsAE09NT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181750; c=relaxed/simple;
	bh=WT6XdtABcM6qpeW1fmJnt9m48jTOU9/WezB+CdIW23s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/0vrZCkRHPvw7lw/mie+lUOUE8wLhzPW+iH6Zx5P3o5cbgx+EPyrZggO+w/Ap4ONczfLbakSX8PN2UdR7b6TBHMKcy8dE+k99laUscEmqtmHio7xqm07ZJpn6IIyPUJObsKrN/8Cyt6NE5m7OQwMQDg8lmSAi6sgRg+EydgbGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d4zs7JUC; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0ETvnyMba8d39AZtyrjW9rt8o3qsE3+vY8VapP8rhrGJ787a6i8Wi8kCJlyV2g1AMIzhiJa+6/lB2lkuuCCQCqhVBO1htVRkBCS5PWjW+mxSbIVnhH1xeeMpBrilzY105NMYAQCoHpHsHQtOnMcysB4YvVW/2sirXyP/WTdHnaOkiVfITwrabVvlLctuXyBp8aB1NFiqJrZC9uQUj+/yzExa1ymPTzjUhDZS2tnvBNIpTWecqxnp4ZocQzlhtEGd+VeQ5DXvJZE0hlSrFMlP49qAEJIOjre+aD7AOgvca123GOWljpFTnxllqIb6TIcve7UHYE+Wcg0pSLRgiOcNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPpoyFXRGcYcd8vm5fTAbnjlvB8triHJU6M5VM4itrI=;
 b=XSpry5U5JKFoRhn5Gj8Rti1cTMD/N31FqiDf7efIvUnlFBerZhCimhqVzQKrhtYpjn6tVwXay2I0XUGnW2GTf+WwwNNUQJUrRXa8zJNP8H5JOacHZHGurzrx2sZQHP8DRnBBI5SRTHh0EsXJEqUFmL9ZFqvFBl6/P5XJjdQT+7eVU3/QPIJO4fsWddXZneuPwlz5de0AhgrzlKIOSHjFEJJKj4vHS36L2dha6g7ITkFsIfAwoxy+tfLY4qqRaUN4nCAeVz8rn6FVv3aRTgBycS+6DmdPNc754Q51qdhumJXi2MRKRri69SBYi6Yx8eOGU9u6SpXgUML57M+KEa7e1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPpoyFXRGcYcd8vm5fTAbnjlvB8triHJU6M5VM4itrI=;
 b=d4zs7JUCu/x/+TYSOkpZVOD+rBjBi171yqSxQUge7w1U/lK5qV/YZ84Ns26X1WUjhrJRx0knDY37LBJd5/ewYVQpIT8/X0S68cPOa2c2Dshxli0OG0s4z/esoGa56GztCbxYfDcx+T4XxGIHLb1DmtLGfFQUzgCYWHzoHs0E8tZWKdya/3LnP/DKEch6g/cNL39PlMvCWaToVh8C6PO++RSVmWl29lzZYKHmZ38cOsp/98N3qxeNkXl0jiJS9biBoM09+9BJhtW65WzHyssw1XGC7TCIskp6yV2t12KlHM4V00WWBO4IzgR6vmPZvkGRlDrKgZaEcL4EWfv/EpoIlQ==
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
Subject: [PATCH 2/2] vfio/mlx5: Fix racy bitfields and tighten struct layout
Date: Thu,  7 May 2026 13:22:02 -0600
Message-ID: <20260507192206.1350046-3-alex.williamson@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: b9446913-7d44-45f3-b36f-08deac6df445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	r+oD8qKplXBqcL+2kHerV2pCQcrJaEwvoDbQPl/O2a1LuiPFcauod+SRJtCOZRLGRmoK0j1J+IDefLD9wCGKxlPINFFz9vagqhXD+/FDQNh5hzlavwSLhIsyswIksoufJg/uI9zxkVFukfFoZtTuBhPew+LHHSo0G2WP7HVcF4RZ7q+BpCCVdw+Ox9MX1PLP/PyvS6eiccYlw+R3sDEKFZ0UDSxpp8BfgZs26XgLktEpKOCHNwhBc0TRVFj0fo915Ul8BjfEwG5xxS42bl986Y74c/86PMRocGfdEaHR0ahoQrGdruq1UlWLZBLzSW7JjFcYKbjDA+li2AgZ8ennTGyUWrt3lauxX8Zs9HV7WabJNMrTd33njKyxGMXKcruFatcnR6ZHN1C6b/JRIQSs9qZReOT1jzOc0Iy6zgqijEdjI8SKw0dIGrMkjWAozODetTp0bsNt7YGCMfS65FMY1dAk3nnlWLNxrzNOxheWvTECud5jg2djHv1chZezlGY33TAaUdR8x/7kiJidjQtx4MCkgPTgYtq6942LOGqHJX/EXTexN1CAYqonrMkUGZYDdewvReF/aXlDfqs+xnQ/rPvo5xD6YaMGa7oxzozWLWkOv4C4uOt+NOfoELDtz0DzSXbNgV76FqDfis3P5a+cREJ0O1Vvx2EGJpGTIhnA9f4yJDCeR7l1unQUhRBjls4A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p0zofnUSXz6+YbPCIfsbsQLKHN/KRqO1qkLIoJu+f+TDIns+yuX8cscvv4Pg?=
 =?us-ascii?Q?iUys2Y/ZaDAIdMxWFFvgwBHUvkJ6S9Jb5MdRJuYZWqrAMS5ONg9kFJ3tsBXa?=
 =?us-ascii?Q?fVTesBevnWszl8+Saq0EZL3j9u6d22OhfavNW+nbs40FlKGUS18ROBxBaXDx?=
 =?us-ascii?Q?PjRJIoMIYIcPdzphnyKeGzwzrNvAz5LvSPIUCfS0JijAvGputa36gwtjQqUW?=
 =?us-ascii?Q?iijyIbSQYwqhREIXgKti7ahAsUtaPi5wu25Gxvvv0VKzwMLE2YRMlIbPl5oD?=
 =?us-ascii?Q?xq05lM+SJzv7cQV+nW0COp0Vcbm3bLr7HyJWJEKMS6fzoK0Z8fpy47PXPikA?=
 =?us-ascii?Q?3grJchHidb+UEZ5e75qsXOgI3XNII25litKeT7aAezIiL3IYogOVi1vjz/Dm?=
 =?us-ascii?Q?ygCkw1K40zTFDTlllwQp+UbEEJVDP6RzoJlVEryhB+DEMPEAMQjZ26jTTkix?=
 =?us-ascii?Q?stQEawgnVTwCraCCKOQeSM1uXbO6lfygIiP0x7SvfznzU5PYv4o5zjuCoK5e?=
 =?us-ascii?Q?X3B6PaeIjeJ64mK7/Rn3kaQ8VRJR7H2AO8RZUUxx/C61vRGauKc2eQTTv5Uu?=
 =?us-ascii?Q?SIrH5ukKoynlTkhs59/F9jXOoATeOWPjfoMX1TWMHcFkrfEkGGVfvmRrIZtP?=
 =?us-ascii?Q?B0RZLZPcdZ9tWajFeTkRoVWUtHYwBT17QPueLI8S3fPHkJoTbY2mxD1C6Ecl?=
 =?us-ascii?Q?rW1ymSXGXLvyH5A4bN6M0J5pZLCgGs8YGGVURvSx452VVMHocBJuwwhr3L58?=
 =?us-ascii?Q?XGkNb2FVppPIDWJX7008Glk2fA77MgGZUOm31z9bZqUW4zu7S2Adx088EqOP?=
 =?us-ascii?Q?dicEN3ZsyLaVsTMDQJ77Pw50O0IQVDGoiAeAi3voyPaSBXkqfG1D65XL+Zz6?=
 =?us-ascii?Q?NTXZxXienDUkujBOkmDgPuLNX7Ypy5fraE3lTNxYxvdrKdRZbjE9j1MrrD28?=
 =?us-ascii?Q?ED+8piuO9znCiY4hpRppqsXBN4LZHmN/+aqqwGnrT6e/GEXh+uIYFPjzNb9Q?=
 =?us-ascii?Q?k5F5bM2AMD+Yiqz9AbjCa8jCp7UW95MPO6hJf+nxA2NbBJ3oJ5puQcxFnwfi?=
 =?us-ascii?Q?FuSXpr8ZDxmM45opsWS1VyamVdcI1YENJ2h+xu8pSpHzOQzA50hLDSXtivsZ?=
 =?us-ascii?Q?tfbIiqxmVimMdJYidbHtldaxbDdh4UiKvsQW+ikad3S6dSru0Bz2vkkn0+h4?=
 =?us-ascii?Q?S/BVnzpcnDSai39M+3GiGU+7akE0l0E/c6sohwNMyaz0o2nnyEJo00um9yV2?=
 =?us-ascii?Q?AWzzsjo4oB/62DOh/jVQxkml9gFTBVyU11TMb0hdZ3mqTbikoclldxpo4wSd?=
 =?us-ascii?Q?qUyaIeuk1OPmYRSLG2fhUkXK+Ke3EDDV8AKYxhbEzwUok8iW9QnGIt7PEYzz?=
 =?us-ascii?Q?SiokGHSjekFG/JQKOKZcM4xuwaqwtMn4w24VQ5Z4075ADgLqbNnHNZDsoAEv?=
 =?us-ascii?Q?zW0dzM3VMzjrBd7qaRhIdsaCtzzdDN+vaOMPQYS1+MeLDh/KrpWp2SoQzXHt?=
 =?us-ascii?Q?CQVvygN9DPLi45dyW5CG9WpLRz8iHoTa7ohzRBdjRr3Wo3ii/V8m3B7WJw5N?=
 =?us-ascii?Q?iE3wl6wSsBJF7TTjzJfQ7ikXrN8RNSR8vTMhEX3+2aj1FM3BBOscCVpJMm6T?=
 =?us-ascii?Q?lP2MLAWBht5MQoXuKOMKR5fgQjWYmPxxg2M+xHGDWfyPc3zR6WPKQc2ux/wb?=
 =?us-ascii?Q?5qPpPYigFeHfuYQGTCPXg8sv8AmyIB2ri0RJpCsj51f3CbkwytP8Odx8JEub?=
 =?us-ascii?Q?uvcFa0qQMg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9446913-7d44-45f3-b36f-08deac6df445
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 19:22:18.4254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0BlojcbxyTRhrxMx8Uq2fDTcVfblm3rA4i1bdXK+0A2b10W7TxgJWNOY/94YG1l+d/zD2kFgsxnU2AlagWn8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
X-Rspamd-Queue-Id: D2BF84EDFB9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244633-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Action: no action

Bitfield operations are not atomic, they use a read-modify-write
pattern, therefore we should be careful not to pack bitfields that
can be concurrently updated into the same storage unit.

The split fields (is_err and object_changed in mlx5_vhca_page_tracker,
deferred_reset in mlx5vf_pci_core_device) are mutated from contexts
that don't serialize against the other writers in the same storage
unit, so a bitfield RMW could drop an adjacent field's update.  The
remaining bitfields are either probe-only or share a single writer
context, so they stay packed.

The page tracker's status field is also relocated to fill the
alignment hole the split exposes.

Fixes: f886473071d6 ("vfio/mlx5: Add support for tracker object change event")
Fixes: 61a2f1460fd0 ("vfio/mlx5: Manage the VF attach/detach callback from the PF")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 drivers/vfio/pci/mlx5/cmd.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/mlx5/cmd.h b/drivers/vfio/pci/mlx5/cmd.h
index deed0f132f39..b782139eb8be 100644
--- a/drivers/vfio/pci/mlx5/cmd.h
+++ b/drivers/vfio/pci/mlx5/cmd.h
@@ -158,14 +158,14 @@ struct mlx5_vhca_qp {
 struct mlx5_vhca_page_tracker {
 	u32 id;
 	u32 pdn;
-	u8 is_err:1;
-	u8 object_changed:1;
+	u8 is_err;
+	u8 object_changed;
+	int status;
 	struct mlx5_uars_page *uar;
 	struct mlx5_vhca_cq cq;
 	struct mlx5_vhca_qp *host_qp;
 	struct mlx5_vhca_qp *fw_qp;
 	struct mlx5_nb nb;
-	int status;
 };
 
 struct mlx5vf_pci_core_device {
@@ -173,11 +173,11 @@ struct mlx5vf_pci_core_device {
 	int vf_id;
 	u16 vhca_id;
 	u8 migrate_cap:1;
-	u8 deferred_reset:1;
 	u8 mdev_detach:1;
 	u8 log_active:1;
 	u8 chunk_mode:1;
 	u8 mig_state_cap:1;
+	u8 deferred_reset;
 	struct completion tracker_comp;
 	/* protect migration state */
 	struct mutex state_mutex;
-- 
2.51.0


