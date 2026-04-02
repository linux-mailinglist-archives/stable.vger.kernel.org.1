Return-Path: <stable+bounces-233056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJagG8OWzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:18:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2D038BBDA
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79FBA30B7ACD
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D57E3EF0C1;
	Thu,  2 Apr 2026 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="bs8QSxHL"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B83EF0B3;
	Thu,  2 Apr 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146405; cv=fail; b=Gu8h/aYrq1CGutsBNxUzLx4Qk621zFCgf+tQ5j0a+dva7b8VAaSfQMH94aKGUJJMZPDqFRZPeVdSrfGdbNa1fXrtbJHggeuygudtcfHeTWsrl9txQLeybNjS7gVB12TKVOGXGQBoSvKlt7BLfwKBypLGOLrQBvKg+x9bmAYNcyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146405; c=relaxed/simple;
	bh=wKjvX4A5ii3gy2R5kMntEbYOr8JYQWpmhCTx84xG590=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yri5nuw7Ky8jvGv462dsQJCe+zRfW+CblL6snKmHxovmYzgHk1u/mJHfloynsOkM98PItV6u6xxh2iT2/mfn7gpj9YGcTGu18gCGkd66DKm+9o2hHMqQ7t7WDPRobIm20A6BHUKh28an0/nVI89kllLVh0DpUT1Ghn7f9HM+TbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=bs8QSxHL; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrJBCvpDwNN+gUY/w5vhsZypx2tFQGgNIauzSPjms2E02m/aSmvbuivRLDk9fe/3sPtwTIymVpxCgUKQ6pHKf/UjCrYYhWlkwy0OyD3PEWYdU2fakbmjXEr++0yRESy0vTZXrErSCOWX04YHjvg1Wm1IjpS1wdsvSy5QLk9Plm8wx6Uo3MKXi82vlhalNr18oRRrwqlD3wwyy/qGRoGLcC1I90IleKuhj+4ORaAWz5rdMpSvfNMt9jhHOTOoiBTjqTryCVeNkgaE8I4ZfQ4RFQatXiMAQYzX+eKYUmjT2VGH+baJw1s7/cPso2xSQWDOC+P5YCOM4a0WRw1crPMs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwwucJ8yKRf8flv1O4l7hOnMbE2qDtKIcAyEDWgAC9I=;
 b=Y+Qol9+4Je1VgiI+GY2i5v/Z6tAdq+DPgP5IgW0vXLBHMMsS97wEu5mRxHEgu8tx9a1zlS9R4Jy0c2YEY6TQeppuZzBV0yt9uNpVeRCzKEh59zj7t5GC7uQ60QXMZ82Gt1MsufFtQ6SaWo8N1IdOyD0Q0bFQAd8Iv5KGmBkgB5xbFpS7TxtfzxMBetlRqs8LCnzbShVUvw9oQ8a3/EQXThAhLmOybQWs4Qi7NjWvVnhs9k4d+5vqLbauE46lqqVAbXekUTit4LARUT0Zb5tUkTx671JAqigzsELSp5AfENuuplS3ElM34NxjMCpAsTG5fV+eQsnq5LFPqaokuAQPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwwucJ8yKRf8flv1O4l7hOnMbE2qDtKIcAyEDWgAC9I=;
 b=bs8QSxHLQP0UJufUlHDJQB1sTkzBCyANjYB8H/47KKuIKTKsYBW3CYtORMEehxCxaajWjw2Hq1e+JOqOu2bb17+jgu2WETI9S0+LA7pM+JXbvqYzuGud2xORU3lqGYGmQvpuY8QI9Zk0TKcwqDb61jJUociX6JiMtho6ezQHm/FnVQGNEPHdyPttUWC7dJuJ9Clg0KuiHilHq3SifGq2HG35YULeqqJSONaTfCZop0TAAT7QEVKhx/JzFk7TpW/yHLVi5GtpeeUud3GzgrYK8CH1V078hcIvabVJL+/56Fs1pYmC8yqjapBryxN+263nCAA4r5DEw9iTbDt2sjsbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16b::8) by
 PAXP189MB1952.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Thu, 2 Apr 2026 16:13:16 +0000
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca]) by DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 16:13:16 +0000
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
Subject: [PATCH 6.6.y 2/4] vfio/pci: Use unmap_mapping_range()
Date: Thu,  2 Apr 2026 18:13:09 +0200
Message-Id: <20260402161311.63484-3-tugrul.kukul@est.tech>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260402161311.63484-1-tugrul.kukul@est.tech>
References: <20260402161311.63484-1-tugrul.kukul@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::12) To DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:16b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P189MB0966:EE_|PAXP189MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: c31d12bf-d45b-4648-3c73-08de90d2bf72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8hcQXbTfPJ2cfGkUY0M3TmtvjLfqNGgVMa0xCQdndnUGLsgvHkwK/Z0WoK3KbGGxY14ukvYdN9yq9w2y/HlyjExJYtr6/GEDMbxILriAN2mscwZnXTHfNEAbKCbNvMv4At2mnqvdaBM/k5isEwCSalldkxP/k3K3UKfunJhpylMUhz8v4vk5NK1aLEOclXsWCQQuK+gfSjsmVdCAXWUCySCRznWMusqstL3BTr66iPZvoYyRRR+CLMu3fwYLAk8XTmxI+j8Y7pmgIYKPwRoa7Bws9C9QXFQNrdEQkz86dt36qikk+uGeGAbhNGmVHEtwr9cAypjlb4Z9K2Bv/4WIyjLXAYVpPJcOT/F74PgNHXJ9fIBkfLEzNOvQz6yVeCFSC7IQ1UrcfB07Hx6TlaYI1R+7K2jatc3HeaLKrNXNo08kS04QD76+Z7muMgNddhApX8sPC2s12OGF98tPD2JmyPG2A2xpg02qd9vIde4tTvF0qKxe7hGr7RqOqJDqYc7qDGlvKpVdg57PTajOiCLC7NH4Tm2sYlmwaTkVn4yhtvVuV0MSUFzYh2R4QkdudVAu/qtxqhenJJ18zUQvY9E6WdsgQQUMj2J9yxB4wJTzk44S74NYRFksH+dtSUj/km2eODQV8NOx+zkT4Bf58LSHuhJPKU75Ytb2Npp6q7XGUUICi7TYproH6qgnFfqnf156YlP0TEzy4+KQPTl9DydOhfXYA5UdnMcKbQbNfGxZ1N4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P189MB0966.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kPoloO5x5UuoK5dadzwCDo3jRpJZbPagbqjlKf9bw19SXbdxHs+Jr4QAx4XU?=
 =?us-ascii?Q?pPO3n8Z8ok/a3c9aJTcfMqLh0MO9Zz9IFNuCHCoddhYK9kYzbT4PT4LFDYbJ?=
 =?us-ascii?Q?qlwZa/IO5Gzk8nkeoCczI1kBgfRkwJdWQJm6Q9iMmqIafcLccFTf8HdMBhoD?=
 =?us-ascii?Q?nFnWW7ASFZXQ3ivxnxYGIzTwXjEuJxdHmj2kjLT8Di7MT1wcQqEGqWyPHJ/A?=
 =?us-ascii?Q?1MZE5s7q0lNSpYWUalaLvjdU24YhWxyGFWs1VGNFhQKoAmnpAh/TXrRQdFMj?=
 =?us-ascii?Q?KN4fSamjGEdK5PaN0Uk9TcAs5hbSb2NEucxWej9M/GLfDHzSTbpQm/iMVBYe?=
 =?us-ascii?Q?ruBYuhqBbmFS51BmiSzi6/TLNnqf2tgSmfBCcop6Rd+/vmTafimNdxBTNuJ3?=
 =?us-ascii?Q?lCmc2SuIgIaEhF2icv+qmQ7pI8+gmjUK0VVWyWol4f6smBO24gG2o6woL6im?=
 =?us-ascii?Q?W9O1hX2pEZR8KTEAmt+zpqNOCHRXqs2Xc4Gsz3jmQIZjcB0DcN5CSx4bFFlG?=
 =?us-ascii?Q?3r07uxfN1jnOtkEjwS0kl2skJ6WYZUl7fsUgw2sKEfNbRzYT8XzMI8+Mh2+p?=
 =?us-ascii?Q?k4y7VxTs6jtdZwE0ddUFgdP3i1M+swR7/K9Xn7a+2G0AZm9V/40SUorJko8Z?=
 =?us-ascii?Q?zoy+MI9HxYeVx846eRy88chHNi1Ro9XYJv/douQdZ7UVLn2LpBRMIgBMgXcL?=
 =?us-ascii?Q?rdjhOxYX+SBy8qVQbmls7DagBOtSmEBq0K9LthOb/9ZQkwTTCoxXoOa+u8hS?=
 =?us-ascii?Q?Us1vHEI+LwoHsofBKLlOQjxURlKGNUYURnC7NY3W1APKMD/kd4XeNeE2rTS4?=
 =?us-ascii?Q?FYBay/lXdEdwdixDKSzf41Yvs+vFfQAghqFtZhG0vooHc+SsycG6B5KwJpN1?=
 =?us-ascii?Q?FtJoZ1HYr1FEutdTikgn4in617oNW+K5CQhfgsJJvSDgQr1mZakBwMiLIBzL?=
 =?us-ascii?Q?/LhS/boZaqBevCe+QDgo6xqajp5PVDvBYcb/NRq5XWsOgb92WNLDkmWoKhpR?=
 =?us-ascii?Q?ABaNMmEUeKcpZxkfuJ8dURhKl9jYZ+7DHXQyDe5CWZFTvK3C2iN1rGFTvYxp?=
 =?us-ascii?Q?CFNOze3i7CAs4KW4DvHBrS6IU21sNfCVvlYU9Pu7thLYb3W/LV7s8F0lepFZ?=
 =?us-ascii?Q?HIzorHZs6EWDxJDQeD6qew2oFZyAxKJAk+HPa8ttD8GN6FhwvfbHNrL2BiNW?=
 =?us-ascii?Q?zOBGK6RkBxI/BlqRNxAyV9ZxN7sfB2sxbyla4zZO49qcQEH66c6WNQcrw+qG?=
 =?us-ascii?Q?GlDnWigRs5yODRTkJ25Cy0jQ1zcOXQEUf2KbUNQsri1nqz8iXpzCCdVR5bnN?=
 =?us-ascii?Q?xvzVlPELOyv0X6uABCfgNjzuKdXhNdJ/zMRYIpAvhtEcHuLJXy5O7PdkTIxO?=
 =?us-ascii?Q?8VEfS+2OepaocIQ4DDcHqWYerquKfseCJ6uwfWad3O/5WAbptv+SpGuuilO0?=
 =?us-ascii?Q?iZo5SL1KL8C0JQtVY4OW7T36FyX1Q79b0fgl8le6URR9Pm7BhBvm9D1YBgOr?=
 =?us-ascii?Q?a79xtZHBudKjEtSpCP0HXh9Tgo7biqv7z76VDFi6WAUGjRPdZNqyi5wmCuBG?=
 =?us-ascii?Q?FedoWrYf6l7SZocGkRTGpiBtwf++hOjKAdjAKQkK9Z2W1+ce0zStkbT72OWY?=
 =?us-ascii?Q?9BzN7/wAAoEzJpkCB+0Pm6KymWE3pIvkU/ot7puc8OGuEcQH/Mj0u5IwqGGm?=
 =?us-ascii?Q?Se3xWEZnqBWTEzvw36BC7sjDdqbCIey/yoKXJMBo7LN/+wLL3k5XGaMmUXrZ?=
 =?us-ascii?Q?Er6qAZFMBQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: c31d12bf-d45b-4648-3c73-08de90d2bf72
X-MS-Exchange-CrossTenant-AuthSource: DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 16:13:16.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tpm2jbU+5AkW//bWqY1Dpl4Bbg9Cl5kzZXuD8kahg6JdC9nqBN1LxqCi+zogowwbqENvxYGNLmLB6r6ZzH5zlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1952
X-Spamd-Result: default: False [3.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[est.tech];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,ziepe.ca,oracle.com,linux-foundation.org,huawei.com,google.com,gmail.com,vger.kernel.org,est.tech];
	TAGGED_FROM(0.00)[bounces-233056-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tugrul.kukul@est.tech,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:dkim,est.tech:email,est.tech:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: EA2D038BBDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alex Williamson <alex.williamson@redhat.com>

commit aac6db75a9fc2c7a6f73e152df8f15101dda38e6 upstream.

With the vfio device fd tied to the address space of the pseudo fs
inode, we can use the mm to track all vmas that might be mmap'ing
device BARs, which removes our vma_list and all the complicated lock
ordering necessary to manually zap each related vma.

Note that we can no longer store the pfn in vm_pgoff if we want to use
unmap_mapping_range() to zap a selective portion of the device fd
corresponding to BAR mappings.

This also converts our mmap fault handler to use vmf_insert_pfn()
because we no longer have a vma_list to avoid the concurrency problem
with io_remap_pfn_range().  The goal is to eventually use the vm_ops
huge_fault handler to avoid the additional faulting overhead, but
vmf_insert_pfn_{pmd,pud}() need to learn about pfnmaps first.

Also, Jason notes that a race exists between unmap_mapping_range() and
the fops mmap callback if we were to call io_remap_pfn_range() to
populate the vma on mmap.  Specifically, mmap_region() does call_mmap()
before it does vma_link_file() which gives a window where the vma is
populated but invisible to unmap_mapping_range().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240530045236.1005864-3-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Tugrul Kukul <tugrul.kukul@est.tech>
---
 drivers/vfio/pci/vfio_pci_core.c | 264 +++++++------------------------
 include/linux/vfio_pci_core.h    |   2 -
 2 files changed, 55 insertions(+), 211 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f139360752e2..e05d6ee9d4cab 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1599,100 +1599,20 @@ ssize_t vfio_pci_core_write(struct vfio_device *core_vdev, const char __user *bu
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_write);
 
-/* Return 1 on zap and vma_lock acquired, 0 on contention (only with @try) */
-static int vfio_pci_zap_and_vma_lock(struct vfio_pci_core_device *vdev, bool try)
+static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 {
-	struct vfio_pci_mmap_vma *mmap_vma, *tmp;
+	struct vfio_device *core_vdev = &vdev->vdev;
+	loff_t start = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_BAR0_REGION_INDEX);
+	loff_t end = VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX);
+	loff_t len = end - start;
 
-	/*
-	 * Lock ordering:
-	 * vma_lock is nested under mmap_lock for vm_ops callback paths.
-	 * The memory_lock semaphore is used by both code paths calling
-	 * into this function to zap vmas and the vm_ops.fault callback
-	 * to protect the memory enable state of the device.
-	 *
-	 * When zapping vmas we need to maintain the mmap_lock => vma_lock
-	 * ordering, which requires using vma_lock to walk vma_list to
-	 * acquire an mm, then dropping vma_lock to get the mmap_lock and
-	 * reacquiring vma_lock.  This logic is derived from similar
-	 * requirements in uverbs_user_mmap_disassociate().
-	 *
-	 * mmap_lock must always be the top-level lock when it is taken.
-	 * Therefore we can only hold the memory_lock write lock when
-	 * vma_list is empty, as we'd need to take mmap_lock to clear
-	 * entries.  vma_list can only be guaranteed empty when holding
-	 * vma_lock, thus memory_lock is nested under vma_lock.
-	 *
-	 * This enables the vm_ops.fault callback to acquire vma_lock,
-	 * followed by memory_lock read lock, while already holding
-	 * mmap_lock without risk of deadlock.
-	 */
-	while (1) {
-		struct mm_struct *mm = NULL;
-
-		if (try) {
-			if (!mutex_trylock(&vdev->vma_lock))
-				return 0;
-		} else {
-			mutex_lock(&vdev->vma_lock);
-		}
-		while (!list_empty(&vdev->vma_list)) {
-			mmap_vma = list_first_entry(&vdev->vma_list,
-						    struct vfio_pci_mmap_vma,
-						    vma_next);
-			mm = mmap_vma->vma->vm_mm;
-			if (mmget_not_zero(mm))
-				break;
-
-			list_del(&mmap_vma->vma_next);
-			kfree(mmap_vma);
-			mm = NULL;
-		}
-		if (!mm)
-			return 1;
-		mutex_unlock(&vdev->vma_lock);
-
-		if (try) {
-			if (!mmap_read_trylock(mm)) {
-				mmput(mm);
-				return 0;
-			}
-		} else {
-			mmap_read_lock(mm);
-		}
-		if (try) {
-			if (!mutex_trylock(&vdev->vma_lock)) {
-				mmap_read_unlock(mm);
-				mmput(mm);
-				return 0;
-			}
-		} else {
-			mutex_lock(&vdev->vma_lock);
-		}
-		list_for_each_entry_safe(mmap_vma, tmp,
-					 &vdev->vma_list, vma_next) {
-			struct vm_area_struct *vma = mmap_vma->vma;
-
-			if (vma->vm_mm != mm)
-				continue;
-
-			list_del(&mmap_vma->vma_next);
-			kfree(mmap_vma);
-
-			zap_vma_ptes(vma, vma->vm_start,
-				     vma->vm_end - vma->vm_start);
-		}
-		mutex_unlock(&vdev->vma_lock);
-		mmap_read_unlock(mm);
-		mmput(mm);
-	}
+	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
 }
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
 {
-	vfio_pci_zap_and_vma_lock(vdev, false);
 	down_write(&vdev->memory_lock);
-	mutex_unlock(&vdev->vma_lock);
+	vfio_pci_zap_bars(vdev);
 }
 
 u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev)
@@ -1714,99 +1634,41 @@ void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev, u16 c
 	up_write(&vdev->memory_lock);
 }
 
-/* Caller holds vma_lock */
-static int __vfio_pci_add_vma(struct vfio_pci_core_device *vdev,
-			      struct vm_area_struct *vma)
-{
-	struct vfio_pci_mmap_vma *mmap_vma;
-
-	mmap_vma = kmalloc(sizeof(*mmap_vma), GFP_KERNEL_ACCOUNT);
-	if (!mmap_vma)
-		return -ENOMEM;
-
-	mmap_vma->vma = vma;
-	list_add(&mmap_vma->vma_next, &vdev->vma_list);
-
-	return 0;
-}
-
-/*
- * Zap mmaps on open so that we can fault them in on access and therefore
- * our vma_list only tracks mappings accessed since last zap.
- */
-static void vfio_pci_mmap_open(struct vm_area_struct *vma)
-{
-	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
-}
-
-static void vfio_pci_mmap_close(struct vm_area_struct *vma)
+static unsigned long vma_to_pfn(struct vm_area_struct *vma)
 {
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	struct vfio_pci_mmap_vma *mmap_vma;
+	int index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
+	u64 pgoff;
 
-	mutex_lock(&vdev->vma_lock);
-	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
-		if (mmap_vma->vma == vma) {
-			list_del(&mmap_vma->vma_next);
-			kfree(mmap_vma);
-			break;
-		}
-	}
-	mutex_unlock(&vdev->vma_lock);
+	pgoff = vma->vm_pgoff &
+		((1U << (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
 }
 
 static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
-	struct vfio_pci_mmap_vma *mmap_vma;
-	vm_fault_t ret = VM_FAULT_NOPAGE;
+	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
+	vm_fault_t ret = VM_FAULT_SIGBUS;
 
-	mutex_lock(&vdev->vma_lock);
-	down_read(&vdev->memory_lock);
+	pfn = vma_to_pfn(vma);
 
-	/*
-	 * Memory region cannot be accessed if the low power feature is engaged
-	 * or memory access is disabled.
-	 */
-	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev)) {
-		ret = VM_FAULT_SIGBUS;
-		goto up_out;
-	}
+	down_read(&vdev->memory_lock);
 
-	/*
-	 * We populate the whole vma on fault, so we need to test whether
-	 * the vma has already been mapped, such as for concurrent faults
-	 * to the same vma.  io_remap_pfn_range() will trigger a BUG_ON if
-	 * we ask it to fill the same range again.
-	 */
-	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
-		if (mmap_vma->vma == vma)
-			goto up_out;
-	}
+	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
+		goto out_disabled;
 
-	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot)) {
-		ret = VM_FAULT_SIGBUS;
-		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
-		goto up_out;
-	}
+	ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
 
-	if (__vfio_pci_add_vma(vdev, vma)) {
-		ret = VM_FAULT_OOM;
-		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
-	}
-
-up_out:
+out_disabled:
 	up_read(&vdev->memory_lock);
-	mutex_unlock(&vdev->vma_lock);
+
 	return ret;
 }
 
 static const struct vm_operations_struct vfio_pci_mmap_ops = {
-	.open = vfio_pci_mmap_open,
-	.close = vfio_pci_mmap_close,
 	.fault = vfio_pci_mmap_fault,
 };
 
@@ -1869,11 +1731,12 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 
 	vma->vm_private_data = vdev;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
 
 	/*
-	 * See remap_pfn_range(), called from vfio_pci_fault() but we can't
-	 * change vm_flags within the fault handler.  Set them now.
+	 * Set vm_flags now, they should not be changed in the fault handler.
+	 * We want the same flags and page protection (decrypted above) as
+	 * io_remap_pfn_range() would set.
 	 */
 	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_ops = &vfio_pci_mmap_ops;
@@ -2173,8 +2036,6 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	mutex_init(&vdev->ioeventfds_lock);
 	INIT_LIST_HEAD(&vdev->dummy_resources_list);
 	INIT_LIST_HEAD(&vdev->ioeventfds_list);
-	mutex_init(&vdev->vma_lock);
-	INIT_LIST_HEAD(&vdev->vma_list);
 	INIT_LIST_HEAD(&vdev->sriov_pfs_item);
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
@@ -2190,7 +2051,6 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
-	mutex_destroy(&vdev->vma_lock);
 	kfree(vdev->region);
 	kfree(vdev->pm_save);
 }
@@ -2468,26 +2328,15 @@ static int vfio_pci_dev_set_pm_runtime_get(struct vfio_device_set *dev_set)
 	return ret;
 }
 
-/*
- * We need to get memory_lock for each device, but devices can share mmap_lock,
- * therefore we need to zap and hold the vma_lock for each device, and only then
- * get each memory_lock.
- */
 static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 				      struct vfio_pci_group_info *groups,
 				      struct iommufd_ctx *iommufd_ctx)
 {
-	struct vfio_pci_core_device *cur_mem;
-	struct vfio_pci_core_device *cur_vma;
-	struct vfio_pci_core_device *cur;
+	struct vfio_pci_core_device *vdev;
 	struct pci_dev *pdev;
-	bool is_mem = true;
 	int ret;
 
 	mutex_lock(&dev_set->lock);
-	cur_mem = list_first_entry(&dev_set->device_list,
-				   struct vfio_pci_core_device,
-				   vdev.dev_set_list);
 
 	pdev = vfio_pci_dev_set_resettable(dev_set);
 	if (!pdev) {
@@ -2504,7 +2353,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	if (ret)
 		goto err_unlock;
 
-	list_for_each_entry(cur_vma, &dev_set->device_list, vdev.dev_set_list) {
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
 		bool owned;
 
 		/*
@@ -2528,38 +2377,38 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 		 * Otherwise, reset is not allowed.
 		 */
 		if (iommufd_ctx) {
-			int devid = vfio_iommufd_get_dev_id(&cur_vma->vdev,
+			int devid = vfio_iommufd_get_dev_id(&vdev->vdev,
 							    iommufd_ctx);
 
 			owned = (devid > 0 || devid == -ENOENT);
 		} else {
-			owned = vfio_dev_in_groups(&cur_vma->vdev, groups);
+			owned = vfio_dev_in_groups(&vdev->vdev, groups);
 		}
 
 		if (!owned) {
 			ret = -EINVAL;
-			goto err_undo;
+			break;
 		}
 
 		/*
-		 * Locking multiple devices is prone to deadlock, runaway and
-		 * unwind if we hit contention.
+		 * Take the memory write lock for each device and zap BAR
+		 * mappings to prevent the user accessing the device while in
+		 * reset.  Locking multiple devices is prone to deadlock,
+		 * runaway and unwind if we hit contention.
 		 */
-		if (!vfio_pci_zap_and_vma_lock(cur_vma, true)) {
+		if (!down_write_trylock(&vdev->memory_lock)) {
 			ret = -EBUSY;
-			goto err_undo;
+			break;
 		}
+
+		vfio_pci_zap_bars(vdev);
 	}
-	cur_vma = NULL;
 
-	list_for_each_entry(cur_mem, &dev_set->device_list, vdev.dev_set_list) {
-		if (!down_write_trylock(&cur_mem->memory_lock)) {
-			ret = -EBUSY;
-			goto err_undo;
-		}
-		mutex_unlock(&cur_mem->vma_lock);
+	if (!list_entry_is_head(vdev,
+				&dev_set->device_list, vdev.dev_set_list)) {
+		vdev = list_prev_entry(vdev, vdev.dev_set_list);
+		goto err_undo;
 	}
-	cur_mem = NULL;
 
 	/*
 	 * The pci_reset_bus() will reset all the devices in the bus.
@@ -2570,25 +2419,22 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 	 * cause the PCI config space reset without restoring the original
 	 * state (saved locally in 'vdev->pm_save').
 	 */
-	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
-		vfio_pci_set_power_state(cur, PCI_D0);
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
+		vfio_pci_set_power_state(vdev, PCI_D0);
 
 	ret = pci_reset_bus(pdev);
 
+	vdev = list_last_entry(&dev_set->device_list,
+			       struct vfio_pci_core_device, vdev.dev_set_list);
+
 err_undo:
-	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
-		if (cur == cur_mem)
-			is_mem = false;
-		if (cur == cur_vma)
-			break;
-		if (is_mem)
-			up_write(&cur->memory_lock);
-		else
-			mutex_unlock(&cur->vma_lock);
-	}
+	list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
+					 vdev.dev_set_list)
+		up_write(&vdev->memory_lock);
+
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
+		pm_runtime_put(&vdev->pdev->dev);
 
-	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
-		pm_runtime_put(&cur->pdev->dev);
 err_unlock:
 	mutex_unlock(&dev_set->lock);
 	return ret;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 562e8754869da..4f283514a1ed6 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -93,8 +93,6 @@ struct vfio_pci_core_device {
 	struct list_head		sriov_pfs_item;
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
-	struct mutex		vma_lock;
-	struct list_head	vma_list;
 	struct rw_semaphore	memory_lock;
 };
 
-- 
2.34.1


