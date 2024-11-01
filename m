Return-Path: <stable+bounces-89479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4839B8D32
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 09:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A731B213BF
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 08:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE772156C76;
	Fri,  1 Nov 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Qv6a0Nm/"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEAE14AD2B
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450121; cv=fail; b=mBESgKhJfGb+Hs0TbogvEja1pezCMNCH8rShiUhS91pGL6++atmBatV+NnQseAUislBHMK3JfCB2G7iDEeWySCcBGsBlFTn3Oo4TuM4k6AAvMR95eUPKMWVtRYuYx0uhdgdBEiPuZZrYke/dzBYeHPvwZDPRgp0ADmTZ36IqrLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450121; c=relaxed/simple;
	bh=x9kiyJIeWFEEXaQUOqCeDR0CJTTEM99vYMyC0jFxPLA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EbeYsoWGRlqvhLuxluQ3nsYD7OrgoYtAQNVSMDKtsifLikGSCyLmAOAz8urdjC9M7auZnhPy1VKXnPTEM5AsaojaUihf/TM0z9+4/OBrzkbjcEbhSjXaaE96avlv1bT2nA15A2YtgBaMgQ3BWqUp+88ofxp8+JZPx9kpbRUGbek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Qv6a0Nm/; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlGGl633IgmvkPpehFuJExyoMte6yzG2Fw1nsd6ao8tnO1ARnuabk/JMiyvmuixe7GMZlFH0LVbLOkVxaxaK8uahw/6mrYAxvMzdinsgXlsBWtIMOQbn2Bkwc7YBiQ0JvsqsnHDg97C/ENqNlAQHgRUik7oSNTDchYG59Njlv4HpGDwy1kkE1qPcqZa1YLsdcuAVSxe9Qg+oXt0EL4ZEuVE7IDQNTjXHxMv5/RuiQuryGpsIGmtJO9rRAl7qWeruHxv22YyqF7XJHGj2RbXpMLZZHWFewf+54vqAlP1J+wk+Nrs/JlYcdjhbtytdMz32wRbskDhbi03xDE4KrXiqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GccqF57Y5efcNiX9PpYxGLLDnOVz0U89nSD7SyWhc9E=;
 b=WO3Jru0YrOJVmAa4D5HiKA8Zdolu5LfpwwOJvYSO0VCr/V7GctSr/XKO8nDmKDO86uyFS5lrXm8qYVNjBMZYfharus37NzEY53Bgz2WeMI7ysHWar+kMlD4RecK4pc/RA8l7lOSMp7N0HsMs3bZLPwi/a2JfO/804qlU/jCr+IlWUH3CIX3vmP2AlYU+Krp3zVy03Wycsn97ajSemq2hdvdQmJLcFQ0JeOTSfKynDD2hVtJDxXGxHj9BtUt5UsYJkylhfl9Gl9VrS1NV27bGdkWaape6STnC+rirbR4y9Hocomv0NGAKRpWXsp8iQcOCXaJOSfKCbxfQR8zjO4ZJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GccqF57Y5efcNiX9PpYxGLLDnOVz0U89nSD7SyWhc9E=;
 b=Qv6a0Nm/9FSN5lUWnfWbTzKOrbJu26AsuRy0QzkA0wCqIty0v5OQ6I5aKNxhOIwPC5cQ5Mj+tIQTpdmsy2Ty9AAfNSOVCutVoHLktG1+tEePHf1RySBh8zS61HHYzTZIrCNra4rvtl+o5zYI+7kARUxaDpT2D6mrbm24fDX9f+7fz4YH58if+shR7fSFbKOBg1un6Xn0I8Q9OQGqymXNAE/Hxwwe6TJTTAOwMaKZp4rcXzHvtKWsZe1cocIODcRvlWcXVdGhjLQym4TBOPUtdFv/8PC1UsGfIp8fizlDjy5JvDqe5MXRsJ3wyH5wgmC5IOu4myV7SP+TessJCq2fTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com (2603:1096:4:1ec::12)
 by TYZPR06MB6022.apcprd06.prod.outlook.com (2603:1096:400:340::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13; Fri, 1 Nov
 2024 08:35:12 +0000
Received: from SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd]) by SI2PR06MB5385.apcprd06.prod.outlook.com
 ([fe80::967d:afda:6f4:33dd%4]) with mapi id 15.20.8137.008; Fri, 1 Nov 2024
 08:35:12 +0000
From: Xiaoguang Wang <lege.wang@jaguarmicro.com>
To: virtualization@lists.linux.dev
Cc: stable@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	Xiaoguang Wang <lege.wang@jaguarmicro.com>,
	Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH V2] vp_vdpa: fix id_table array not null terminated error
Date: Fri,  1 Nov 2024 16:34:48 +0800
Message-ID: <20241101083448.960-1-lege.wang@jaguarmicro.com>
X-Mailer: git-send-email 2.43.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To SI2SPRMB0003.apcprd06.prod.outlook.com
 (2603:1096:4:1a0::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5385:EE_|TYZPR06MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: b102c95f-3164-4936-2f27-08dcfa501973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYSiJaKsN90gshvJbqlIA0lCBip+FPghojXBPv764GcG9mjh3m0o/9gVfXsx?=
 =?us-ascii?Q?Vlt7R5fc5rI8hOUhZF5MiqB5RYQyBk1OH7Oait72k9BOy+t/rjG5f9DuCOgO?=
 =?us-ascii?Q?5uFJcbecRUbL9NR9HRBphdu4uyRVhTRSWZPfcDVmM3L7xreNIe8tLvpP8oKt?=
 =?us-ascii?Q?iTLNmaCXoUnp9Zk+QIQ8toUY7H14BgbJConmviXKRwRbrKFsDbyL3qFGSJnu?=
 =?us-ascii?Q?bppHax8I8flUL6BkB+wTBkG22QA23MEqcDv30o8YQ98SfoSKBPudybu0eYL2?=
 =?us-ascii?Q?kKEu0vqJEOo4xtobmXoQHrCnuRvgRGWfu7+pfI9gosS99KuNdKTJwdRBbWyR?=
 =?us-ascii?Q?De171Nlcm3sYm3U/zPqVG512rDr+rwlnSFf4wo8fml3OUYj2ep0s+r509UKH?=
 =?us-ascii?Q?03z6Aqs9YY5mLI0I5i8A9ZE9erPRfvjOVZkEEzlhWRdFkHKfxEYWP9Bn/3s2?=
 =?us-ascii?Q?WqGnRgnBZ5sNA0cof3HunLg2W7zUZZ0+kJHhS8WwJrRwGOi367MuABjzrkv4?=
 =?us-ascii?Q?6zJCt0C58vysZ1d3vO/FOdO9AuYx0gN0Ta8oOUYKgYMgtHxp5fkkUuM0WIrD?=
 =?us-ascii?Q?aFs4DOepajmSoJo70Xr+83j1PjT0+SJ7Vck2/zs9wdtPEf59srFn0dkUl7Rg?=
 =?us-ascii?Q?O0iYZLeELxCezb6KsadSZGtde7283pTtHSk9wUW689KQi30LfN53dVt54Akx?=
 =?us-ascii?Q?hX/g5ClrflA890uQYP0CgYHNc9ILhK7IvI3akzM4/KGevdh7dejBH21VPUDm?=
 =?us-ascii?Q?zupvppRbcGwkJNPUOR+NXX4TmtoluJUEvesBLi1gbntWp4DdCyGIKBw1cu2z?=
 =?us-ascii?Q?UWWAyacCLafEldl4Jtq7WYZqGDTjqzZScSI1lMC+m/27IBYrq0+SS9nfVZhU?=
 =?us-ascii?Q?moBu60z03BWNCV4lu3WQqEz+LiTlOAefF7oqYcIZGUQdQBqrbr86CNoWu86W?=
 =?us-ascii?Q?H1VYciJ8QOz4yhN2BDLOnD9vtXLS1s6WE58/zSn9gcwSYCGTConBDhxDwA9S?=
 =?us-ascii?Q?dv3KeorAv1CNX0dDgr+65Y2peQSaj6+fvF+0Cyf11kzyfHuru22as9lCRs3T?=
 =?us-ascii?Q?2AOScaiyOt5Bo4Q62xdf2tUMRLFjMx/pVUctLcVhAY5JWHWQRzlxGnBSPJWB?=
 =?us-ascii?Q?gs9K30B9t8kiyYWWPVtGoXs3dIKwJ1bMjVFWun/rJu108eOxxmc6JCibECE8?=
 =?us-ascii?Q?8uBCvUNqw9y3Xv/Ud6sGdzDjfxk+jw6arESUT11XqtlupcbKtvdzl4bOvsSC?=
 =?us-ascii?Q?dULUEpY9NM9zLJ37rClKCcTY382dm/JQwp/AY2p+48rofBbns0M7AI9NeDIz?=
 =?us-ascii?Q?m7J01jF4pEoxgT5QvbsMB965QS2V7L/6V0lQKJ/qCBE/TEqhdoy54P6U/KdV?=
 =?us-ascii?Q?tGFV69I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5385.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bcDdYt+DzJPNHkSoaYhj/Bbn5lLlDmHtFvSbeQw98WwId2pyRtBfl1iIy8Fe?=
 =?us-ascii?Q?x/5PgIjRXfzEK1zrWsxTPKQFUQJ52ONUaBM4fpU8SpT/YlgJs96WolyvxJDJ?=
 =?us-ascii?Q?7PsW8FoaOdV4d1TKsyyaXn0owGsGo24GIIQSslzwj7riqC1oL310+3ukACea?=
 =?us-ascii?Q?jGZCmAZo3bo0CloyC0hSRn3yYnyA1JiAKGgapJYCXlkoR/3yJxWOOlGqXwhL?=
 =?us-ascii?Q?lhelMWlPVcy/jGOYm7J9hPahrARhQisPqicAxLmSvph45RX1K/gYfNEMqkDn?=
 =?us-ascii?Q?tguU4hVRHd7+ycd9X6Ak6MlHBvjgqvna5JPWlTuvti7/CXRwPIWEGt9M4u0+?=
 =?us-ascii?Q?nHlmxOr+XQCDFIjCxLus0j/u/V4Iqbv1TQ2DSwMXumyR0RPnWJckkJ+0OyDv?=
 =?us-ascii?Q?hWe0djHnfSEd78EF8gk7EDpWn9j2qiv02YmVIiFcmSjytsGFjpjRrTgcOr+t?=
 =?us-ascii?Q?ywwo9mk/SHcR2+Uj7Yrsw1JodQcOL4p7lpzlgsEFLbzZIo2KjxXd0ja5TTZA?=
 =?us-ascii?Q?lr5exvuYihAihfxyz6//xrQ4YEKFTY4gOpqS85pvNOzhOx6Ya/O/qmFm8oT4?=
 =?us-ascii?Q?z9snINLmcx5t5hDpImH5U9k2mDrxRZt6Z4imvSbV6TnZ1fMUHwU3l9sD3KVi?=
 =?us-ascii?Q?CjVrqL62nq0+9Vhdi10QjnpqpvdK+mdeDLo7L2sjAQaFY8hSm7Qn/dTU9xcL?=
 =?us-ascii?Q?w8cqcZlFRT1ftsENlngPMDjKUQ40S+s1IyhRkuuZbcxUWcFEFMm39QnQ/xQC?=
 =?us-ascii?Q?bNtw8/0D1PuBlPhnaeSd30T3acYbTz2fUWhdty3ETTr7JvvQhLIoE8RVSjrE?=
 =?us-ascii?Q?cOLykIFNUrmOi2olllS0SBMKgRcy204GoQSebyG0JyVq4LHdquVI88ulNUjQ?=
 =?us-ascii?Q?NbMft7RkceO9POYY6Nn6ptwFfgv3vhGsRYJ3EYmpwNVVI0DgZDZu2lYNWGPQ?=
 =?us-ascii?Q?7ciaNU0KwKwf90rjxYz83K7nY0SgFohB0DyyJp3juCrs3MIDLFbH4lwo0Dt4?=
 =?us-ascii?Q?Vf7gf5qp4xmYPpb6QkItXclmzusbU85Z9y/vAFBnZLZy9iAEi56n/yBFD6Zw?=
 =?us-ascii?Q?mXucKBOYPoX7uvc9WHjv0N74+XSsK/53p3cUvAlD3ZGIpppZUCnDxM/ucjhq?=
 =?us-ascii?Q?VJ42l51GTlMyHmWJ/NKYcOohEpY7Lkx0uXYHK7tUyykeG2WOhY5p/lWliHMW?=
 =?us-ascii?Q?rGCT7t5zDS0qBJl9w1boTiz7fOvEAf0CijCSpU4MGl2rNsrUVObAeUdiPHX0?=
 =?us-ascii?Q?9rZfjddJEfhxq/SVmOsi9Xum4ay9zyIa1MHoOPZLrgGN57XVKhh42xeUBksD?=
 =?us-ascii?Q?jOu87sjWguB2kY4/lrfNH7s1rumVPcaXAK0jXIPTsQZvOF4TGVx0b/qOE4Uq?=
 =?us-ascii?Q?Va2Zzd2DX3SLzz9FONpesrmzO7XOPwLgYxoW625pcrMYZ6esgEVZbPYjx/F+?=
 =?us-ascii?Q?wLTN/bfTDpftPXtLz/xepYXDrYJQJu7HMK8vGBpFz2tE1X3sflzCyU4FlBLj?=
 =?us-ascii?Q?Lkm0ylqz1SKlonChRUPagaGYtFC+3008FmWnxEId3RCfcC9eAVktoAb9APJN?=
 =?us-ascii?Q?OEh8c9yejRY9c0+nvSHDvzGmFpv9MG1on0dbT/oWnRP+I+fc8pGqZnmsCVMF?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b102c95f-3164-4936-2f27-08dcfa501973
X-MS-Exchange-CrossTenant-AuthSource: SI2SPRMB0003.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:35:11.9749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /03I+o7G1oPUNHdqwhhRzdKV9YKei1aRdOhfsxj8hkTWdX88W41YTZfOsv3xEp1MUZny86zkZBAy4N/7qV+YDRUmd7Jmew9m8dGcKFFJiX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6022

Allocate one extra virtio_device_id as null terminator, otherwise
vdpa_mgmtdev_get_classes() may iterate multiple times and visit
undefined memory.

Fixes: ffbda8e9df10 ("vdpa/vp_vdpa : add vdpa tool support in vp_vdpa")
Cc: stable@vger.kernel.org
Suggested-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
Signed-off-by: Xiaoguang Wang <lege.wang@jaguarmicro.com>

---
V2:
  Use kcalloc() api.
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index ac4ab22f7d8b..b6410a984f29 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -612,7 +612,11 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto mdev_err;
 	}
 
-	mdev_id = kzalloc(sizeof(struct virtio_device_id), GFP_KERNEL);
+	/*
+	 * id_table should be a null terminated array, so allocate one additional
+	 * entry here, see vdpa_mgmtdev_get_classes().
+	 */
+	mdev_id = kcalloc(2, sizeof(struct virtio_device_id), GFP_KERNEL);
 	if (!mdev_id) {
 		err = -ENOMEM;
 		goto mdev_id_err;
-- 
2.40.1


