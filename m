Return-Path: <stable+bounces-233055-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GCaNqWVzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233055-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:13:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A90B038BB11
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B93B3032329
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608E3EDAB6;
	Thu,  2 Apr 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="Pa2AKbHT"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735113EDADB;
	Thu,  2 Apr 2026 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146402; cv=fail; b=G0IBmkrqjZnNO5D96++0Y4/VkDSSO+ynD6cDA/b5NoQnWmsAG2NaBkdOlWzNjXGykWNx8SFuOHxm1v3HICNrHyueisyOTImBrDsHHAxnpILFJXOlgxWKSl7Hq3vX1QMD/l0BNkegGq6UYJ3vrIS98MROT+YOPYa5tDUxoW3PPbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146402; c=relaxed/simple;
	bh=dPOnEYWB5l+V4d7mO09kmDxlHkpGHiLdOX3/lEjFWAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFl+OgP5uJatMWgiloibZ0c5dhvIWHn0ptxWYOWSr1JLdIov0th9NeasDlURCdC/mP7q7FDcmj2i2jaHL/scyTkdFDiXwmOIok0xaq+RTHh2zM/ddVa/f2SWyJLrsDGyOZMxUYuXgKZBWUDsHy9Cklj3Hj/fYaWSlNFYkplOxs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=Pa2AKbHT; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5Px2xyB26TAWFTnzV7ua3TcBXi2p5Q15z6UDxEoBMBVuB2DQHfrkQScIlt9dnFTQw6GNm250bIsAZKltlHW2+ZGog9bCbxEwFBYvxatync/sjs5DrYyeMJ5BCt1UbO1HAoDKFq0E3taJiCF5a04n4v2xErewWUBTtMYxIhDrAFA2w6jY2VuaPa+1xXXKs4OLgNPxx9/Jq1X+FN+esn/HHDLfhsDCNWDIyUxHPOG31BwvLh6/va8aVtQ10JmepwtvkAcKtTk19vPlOLXw/Q52MikILQHMo7UUYTREJQmGOtD1Cp537Slnv8SJqd2h0qHKl6gsqQT+6lmQGUtyywZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+J6M7Xf3RRkbvALcDgcTy2z46GpeZS26iQuUWBuKL0=;
 b=ax8BolZaZvYtH5cUsmRnUK3uunE6iMGuP5Y3R6UE3XfMDu5VQSWf5ohQpfg0WhBfw7n2mW8PeMqgeWaSPvHLFCy8K5pws2tBSzeNwB+B9nLpVsnB2AjgEFR3/JQEcuaJ4dSYBXF1LlOziu2oT4u3ZprZ8EZKSGLwfJOVcfP3VCHA/C92OwjDOWJXRNLNCZ7GLvQ8q6bi1ziQx4tJYKeYcWloeGtoFc78tgca6ypznee2LCmZrEkJwphIaWbaeOWqmuHpxqK64zVLEtL/o62oIzf48fHWUH6UzRsieJgw9o1DHbPd3CXazjRAlE8HxhDffpyq5DrzeJxT6plObKnzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+J6M7Xf3RRkbvALcDgcTy2z46GpeZS26iQuUWBuKL0=;
 b=Pa2AKbHT7gyySk9LeZ4/HqPaIZTi5dKyG65mARvH3g14+xxyDdGrMQGPMuqEkO2eI9RFixQWykAtS8ux8FZRuqBaph5fJx/cabphMXafBqbXxBB2F+F3mw+WNEN6a2QkzAp0RC78um4kdFoui8VfrGOWJDX2rMQuZC1D50Hsy7QQeSi2k2JNkPyP1MydpFveuIjSMeclpXFUAhmIhjBU3jLujM/rRwpVKxJlLTw7EssfoeJutl7abo0U+F6nvh3HEwsp7Gc1yiyhQkfkTGsr745kq3WjeN4cH9G94RI0hRN+IJZToqeMyH+MXyPOI28WgzDoq4V2fdjmYa/ded3Uew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16b::8) by
 PAXP189MB1952.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Thu, 2 Apr 2026 16:13:15 +0000
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca]) by DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 16:13:15 +0000
From: tugrul.kukul@est.tech
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: alex.williamson@redhat.com,
	kevin.tian@intel.com,
	jgg@ziepe.ca,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	akpm@linux-foundation.org,
	mike.kravetz@oracle.com,
	linmiaohe@huawei.com,
	yi.l.liu@intel.com,
	axelrasmussen@google.com,
	leah.rumancik@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.nystrom@est.tech
Subject: [PATCH 6.6.y 1/4] vfio: Create vfio_fs_type with inode per device
Date: Thu,  2 Apr 2026 18:13:08 +0200
Message-Id: <20260402161311.63484-2-tugrul.kukul@est.tech>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260402161311.63484-1-tugrul.kukul@est.tech>
References: <20260402161311.63484-1-tugrul.kukul@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::16) To DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:16b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P189MB0966:EE_|PAXP189MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8801af-eb37-4de1-9a0a-08de90d2bea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jRucQv/Dol8/Rp/7uEb0B99+NmHoMcrAqc5Pm7e3fnnpd2OvT5ki0P4Lahg5k7gBbAQGbvSTtomKaOLioEf2wDT1shhPC9yavcIvLnVcUcn04UZT+1MUk/VIC2V+8Ymb7I0QNRrIfoGEk36G5VjMy25XRjbl0tIhCb/bN9rgjmlv0UldC0WfjMoZEHFXS7c1sWPmnf+nRl/bL/1aNe/DNWBJqD1/Ol5xzR7dC3B9+6JFw+HuQNcPnEQj0WKcmS633jvu/OxspjEhqVjedHr7fLh607Jc0tn4N3teRfsckeRcKMJdt4hD2fbUFkhJtPesWOo9OiUGMnquGcaTe4Msbkhe1MYfhCoequDtNKlG0xY6mHxrWt0+L3+5xaZ0aEcir9c72a4tvviHYVWMwc8MdDTZzAcMG1Iw7zfEMSG2/lguNOxpDeWXQsopWfzNEEDqornSAm0osxBqM4QJhiHRBZNW9lfOARFRgGObtS3cqy8duk/USwUE1JSmMiErDR1m2e736qA46id1F3g9HFXOBPLx2kxArLvpFgwZRPhzbCDXql+kdStauqdkQACf8DClUVofCGYEppvI4efuxhsZM0AFOwQIyPAWkAX9hPOcDFMKeflwu0RJypkS7LUlE7oWj9QyqFvjNZSE6MThk3NM+oK1pPrGloIywMMFuVPCGm8/d0KuuxPrkwNc3baalzIwqYK4zlhosk2kO9io4dIHxMdeJbnuW+IsGpw9koKWvO0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P189MB0966.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y1i+vp7RUgfx/Km+Hd7eLCZJKXwmbnmXRknfBYHxoh0oZGGQ9t9rjhMOZ9cG?=
 =?us-ascii?Q?95eFuzb+9alUxHfIhN0XkAgHrKT02Ln7mYkJtKQldGck8DWHFvF4CQX9IQeR?=
 =?us-ascii?Q?ILxNjK8A4mlQfps/e5xAZigj6Q2UOlF5MxpQZy9i9nwpoqgntLyqwiEtody/?=
 =?us-ascii?Q?lXU4ChncWcf3aEYC/86cCMM9L3qU7FK+CeXGGk5mOQEzM0FVqVHCTrur72/7?=
 =?us-ascii?Q?GZLmyCpHHU3LJmFzY/LqAll91MNzUP9LPaEfKVo/QvbAqron5KE9JJfsiXw2?=
 =?us-ascii?Q?1iDxVx9AlRI5GLTa+i7x+BvCAmcUUd6SUWRLeshbErBN5aXlLqSoC+FM6xVy?=
 =?us-ascii?Q?9nEJVUKXBKkawSe0QLBEz/muyw6LvwpjcFy0cBemCqWTW0RErahtd00LSu3/?=
 =?us-ascii?Q?/d5CZFUkuPnERQ1vlTCrx3KhUNBy3ZJKYSW3RAWdvEOZZugN+jwFz1YIjlPY?=
 =?us-ascii?Q?N0/sHPBJXfKxtyirXRFXDU3iViCCFdLRFPzOKfrnN9uIDHezFhFLMe05n4sC?=
 =?us-ascii?Q?jG7xYu2nca/niCVRrqHY5p5Dvl7e4N2z/LKhHY9Wsq7VJVbvsuEjVYHf51BA?=
 =?us-ascii?Q?5L9bwErCLkqkVGKKbo827MpjaSZXsyWIgOB2LLfDlIIdsnt+GbXgZrziI2IO?=
 =?us-ascii?Q?ibO/qiui4fXs8zG+XeZ8yxAMKRCVZntTlvFVqIo7GqbhXp6QiFTo44LXX+mW?=
 =?us-ascii?Q?ba/X5oOLwQTzwAg0JmflXGxzCzEGnQfZwYRpuRa8985MclCVbp0opPRdEWRq?=
 =?us-ascii?Q?Ly/CKVVV519Im1n3hiO7wAdFiqUAet8vzPrcrBZStakcsblOJ07T/h1odfQu?=
 =?us-ascii?Q?Ngx4GDZZegQojQo2WODA9FNw5wR73aj2QqxFANGhSQ4XGHftnQIawlFYRnPF?=
 =?us-ascii?Q?dUh/+9KCAw1wgiiLBxBFe74whBNemC+q2ygAvMuxeaSUxj9LhcwB3Z+/vUVn?=
 =?us-ascii?Q?pYK6OKuH4K6XwJZnV+gabffO/BJekJW0NTcKqvzbwiv34C0XTIhZ9MmV+aPz?=
 =?us-ascii?Q?LgB0ECb65LGIZFWZjtUfx0EzcgljUAPOUDx+O0DC9wzaoOGYAtcqgi7mN0Va?=
 =?us-ascii?Q?Z4EuLdSWMbq5NhGKtzVkCt3Vv4wdDikjLuBgfjC8v0kEKoGKDKbSrePY0vZZ?=
 =?us-ascii?Q?4pN4kSKcu8x8tf1pvuhiX80C9MdCH5sl7cHSLkK3CLbwx+9ZICVzr9QYm6Dd?=
 =?us-ascii?Q?z4puiuWNC379M2Bw7ojXUHvnYEvX+PrUkJWZSLOyg/ESYOObRJtGaXbqcCDH?=
 =?us-ascii?Q?hu3/Nf+m1LgToK6IS4arbPlhc+Xju+zXIjSaLgPosWWGpEidjehb5beFJUQp?=
 =?us-ascii?Q?IpFap2flHWeQgI2Eg0Ykl8uwC07JONroP36S03p1orZ7o6SXemfhtbF/f+ss?=
 =?us-ascii?Q?u+WwK9u5VjW1RkxLPGKCjGX2eW1X+13kiz9NFDIs0+ENZkNUoDMtiyGUNdyT?=
 =?us-ascii?Q?3jJgviMS9ot4RSZmB8yXI2rfNcdnPhBTJbN0MfOZ2z3Jta7r2RNwfODbZE0v?=
 =?us-ascii?Q?WRITnWDY4LPUW5268WfAGuhZCU5yLOb7sCGJRB+ydtfLE1V9qDyET4DWR2x9?=
 =?us-ascii?Q?nNNS5qGVbkPLtW06S4BGx59rpWypptfXdJ2VV7CS9Rxm1JiSlPSkIHRGr/Jw?=
 =?us-ascii?Q?mgBgCJS3QG0yJA+q7Z/YgX4bcfMB+0L6Yjh32qlxTB6vvUwEk2YpYG0BjPxR?=
 =?us-ascii?Q?sDdmbnnaJmWOi9siXInsJOLFNulcakus22kl1zg2QMwbRWZpz94OCUnXuFSW?=
 =?us-ascii?Q?RX6ZLSm6SA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8801af-eb37-4de1-9a0a-08de90d2bea8
X-MS-Exchange-CrossTenant-AuthSource: DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 16:13:15.0671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5y1cuFV8n2wRs+R1gt6ddeQDMn9wxrtBQ+6fY5UnbtLvzPOMieKXS3N9O3W3r03Ioa7Ac/SnJxQuDjEU1IATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1952
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,ziepe.ca,oracle.com,linux-foundation.org,huawei.com,google.com,gmail.com,vger.kernel.org,est.tech];
	TAGGED_FROM(0.00)[bounces-233055-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tugrul.kukul@est.tech,stable@vger.kernel.org]
X-Rspamd-Queue-Id: A90B038BB11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alex Williamson <alex.williamson@redhat.com>

commit b7c5e64fecfa88764791679cca4786ac65de739e upstream.

By linking all the device fds we provide to userspace to an
address space through a new pseudo fs, we can use tools like
unmap_mapping_range() to zap all vmas associated with a device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240530045236.1005864-2-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Tugrul Kukul <tugrul.kukul@est.tech>
---
 drivers/vfio/device_cdev.c |  7 ++++++
 drivers/vfio/group.c       |  7 ++++++
 drivers/vfio/vfio_main.c   | 44 ++++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h       |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index e75da0a70d1f8..bb1817bd4ff31 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -39,6 +39,13 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 
 	filep->private_data = df;
 
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+
 	return 0;
 
 err_put_registration:
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 54c3079031e16..4cd857ff0259b 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -285,6 +285,13 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 	 */
 	filep->f_mode |= (FMODE_PREAD | FMODE_PWRITE);
 
+	/*
+	 * Use the pseudo fs inode on the device to link all mmaps
+	 * to the same address space, allowing us to unmap all vmas
+	 * associated to this device using unmap_mapping_range().
+	 */
+	filep->f_mapping = device->inode->i_mapping;
+
 	if (device->group->type == VFIO_NO_IOMMU)
 		dev_warn(device->dev, "vfio-noiommu device opened by user "
 			 "(%s:%d)\n", current->comm, task_pid_nr(current));
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 6dfb290c339f9..ec4fbd993bf00 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -22,8 +22,10 @@
 #include <linux/list.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pseudo_fs.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -43,9 +45,13 @@
 #define DRIVER_AUTHOR	"Alex Williamson <alex.williamson@redhat.com>"
 #define DRIVER_DESC	"VFIO - User Level meta-driver"
 
+#define VFIO_MAGIC 0x5646494f /* "VFIO" */
+
 static struct vfio {
 	struct class			*device_class;
 	struct ida			device_ida;
+	struct vfsmount			*vfs_mount;
+	int				fs_count;
 } vfio;
 
 #ifdef CONFIG_VFIO_NOIOMMU
@@ -186,6 +192,8 @@ static void vfio_device_release(struct device *dev)
 	if (device->ops->release)
 		device->ops->release(device);
 
+	iput(device->inode);
+	simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
 	kvfree(device);
 }
 
@@ -228,6 +236,34 @@ struct vfio_device *_vfio_alloc_device(size_t size, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(_vfio_alloc_device);
 
+static int vfio_fs_init_fs_context(struct fs_context *fc)
+{
+	return init_pseudo(fc, VFIO_MAGIC) ? 0 : -ENOMEM;
+}
+
+static struct file_system_type vfio_fs_type = {
+	.name = "vfio",
+	.owner = THIS_MODULE,
+	.init_fs_context = vfio_fs_init_fs_context,
+	.kill_sb = kill_anon_super,
+};
+
+static struct inode *vfio_fs_inode_new(void)
+{
+	struct inode *inode;
+	int ret;
+
+	ret = simple_pin_fs(&vfio_fs_type, &vfio.vfs_mount, &vfio.fs_count);
+	if (ret)
+		return ERR_PTR(ret);
+
+	inode = alloc_anon_inode(vfio.vfs_mount->mnt_sb);
+	if (IS_ERR(inode))
+		simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
+
+	return inode;
+}
+
 /*
  * Initialize a vfio_device so it can be registered to vfio core.
  */
@@ -246,6 +282,11 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	init_completion(&device->comp);
 	device->dev = dev;
 	device->ops = ops;
+	device->inode = vfio_fs_inode_new();
+	if (IS_ERR(device->inode)) {
+		ret = PTR_ERR(device->inode);
+		goto out_inode;
+	}
 
 	if (ops->init) {
 		ret = ops->init(device);
@@ -260,6 +301,9 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	return 0;
 
 out_uninit:
+	iput(device->inode);
+	simple_release_fs(&vfio.vfs_mount, &vfio.fs_count);
+out_inode:
 	vfio_release_device_set(device);
 	ida_free(&vfio.device_ida, device->index);
 	return ret;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 5ac5f182ce0bb..514a7f9b3ef4b 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -64,6 +64,7 @@ struct vfio_device {
 	struct completion comp;
 	struct iommufd_access *iommufd_access;
 	void (*put_kvm)(struct kvm *kvm);
+	struct inode *inode;
 #if IS_ENABLED(CONFIG_IOMMUFD)
 	struct iommufd_device *iommufd_device;
 	u8 iommufd_attached:1;
-- 
2.34.1


