Return-Path: <stable+bounces-233057-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKN2BNWWzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233057-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:18:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7755238BBF8
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A592C30C7E7C
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809823EDADB;
	Thu,  2 Apr 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="b6XH1mHR"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E643EE1DD;
	Thu,  2 Apr 2026 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146407; cv=fail; b=fN400nRohEO3hTM2QhLLir4BDVhc4aQLN0bw38e0wBtMO/RpS0LGfR+dyomG5NddauRT+BvEEiqNas1lic9dfcD0cKrIk1aH6//sGiTEN+S8Fuk8mnzkoMh2I2a2tFtUlUNJE+dw5/xzajc6UlEea8CAluh+ALsa+fSKKgiTaf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146407; c=relaxed/simple;
	bh=oBzArlmjR4usYswws4I/x63xAxch4WVnn/1SaHxOZ0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9GIk7ltLCYfnJANz0lTVmpVvnk+bSsyP1InfH+Z9+axtZ/3cxTmxEaJGiDybPqq2L5sVPcaUKy0lovtwNhxrUgB6aKwh+jDw/O8sBtbpcAXlS7K/nng7x7Iqj7TijQtiW7H5hk5Uhiti6CW+eNdr0bIP/pkF/RCkQ+jZtTH1JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=b6XH1mHR; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrwLxfeakeOd9KshkY6AxVK/0z5TCu5sTVWDLKt0x5gV5CS7uQJtbWXcOePQEjALlaOUo+CFs1bzJRjv5iH0W2jscJaZY4RV+qHrz1uJ/kA9Isi1L3UbSB1QaXpfCGlV+ej1igrScJ4/EONRDGEg3WDZFNs0Oxoa8kSoxFSxvOk5SL1nXG58NGkn/mEogyEmD7wHsZwIJxDLADOQ6M9h/BfECBX0Lo/Bb2zBrnrddpovgDeG+Omw6AkdfCFA/2guF9aJp+IS/QNBuGQNDqw74g/yGfKf9s27/bKmj0llexxIN5pmSaKB9RZPxWW+4EpWdqSF4pDOAybjMjzXJtgc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ch+VTCEL45Oyf+kL2YZu6gHBiDZrlQ7lp8S0h1I544=;
 b=QptZVda5/Cggw5xRgq3rp2o6dBkJPDoHRR9INzSYEi11VqDc/+s7/X5CH0rRzk8l3qQ6m+Q8dKQY/v3myk6unbzc+OwFdqbkLoheNTAGMuHQdUHex2Tc7q+cInZsKQL5DjiYu6yGa5al8IncCISkDOe+t0zzAPK5z2T8JNS8iw7etHgfg109LiSh7eJbyAgcNlc7N6KaBkfJWbjJLoNMqQnfRPzqyCiimtnh0aObh/IeLPmqUl9pMCZVxRE3huYlR8Tjd0a1MAAG0LhXaoHXIwIAz2VZ9sdrYxPIFFUDiG/99z2uotzsOpqi09ssmY9vALd2rLuxInAbIucpiYF8jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ch+VTCEL45Oyf+kL2YZu6gHBiDZrlQ7lp8S0h1I544=;
 b=b6XH1mHRTNY44TR90SDTy5FNySlWdDmySCE+3BDNqwNzNavAxZ0z8mQUysb3tT+3c5gw9Zz/ITz80z7Z2JxGVqMVmD3p5ov3HZ9o4v0F3bgA9mDoLDvhEsvp3aWuty/86TVYoxw+iXTkJcgx9sfhrxnUSOQ3H3tfs17WSF7UiQO75Eg3oI9kcyjweMCpFQoAgcZ36fTU4YLxmoytHq81WE0zl3+4nb01rDChQhm61LqT72IuvZYgMxZrYc8NVUqzIHDpWobZiicbxlegIaXC68LvjNERB8cdPpQYn37JmdlyRZ9/P86Zb3//hV2m1Oiezftsiovq1REwUfnd4TTeqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:16b::8) by
 PAXP189MB1952.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:28c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Thu, 2 Apr 2026 16:13:17 +0000
Received: from DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca]) by DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 ([fe80::48c:33b2:d870:d0ca%4]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 16:13:17 +0000
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
Subject: [PATCH 6.6.y 3/4] vfio/pci: Insert full vma on mmap'd MMIO fault
Date: Thu,  2 Apr 2026 18:13:10 +0200
Message-Id: <20260402161311.63484-4-tugrul.kukul@est.tech>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260402161311.63484-1-tugrul.kukul@est.tech>
References: <20260402161311.63484-1-tugrul.kukul@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0396.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::24) To DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:16b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8P189MB0966:EE_|PAXP189MB1952:EE_
X-MS-Office365-Filtering-Correlation-Id: a18d9703-799a-4b8b-4936-08de90d2c040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	//Hk9jMSweveNEpn9rZz7w3ujZcbo9TZU5dkDzj1Yviay1Q7rNxxR98h9NpxW0TBaGd2AvbXFWcw03cNkmMtadLK6KI3AGnQpgCUxl7DVT+oqTsP0NjwiEBKOzocSMlhj02otuQib5H8es1s9YU4pLHDzhn+sxVoIe5zZPXtrWNSKrV4zHlQ3yXtnMlHXL74U5+e8jSVOTykhhwTE0gT2IsCItQifCQqm4MnAU/KvDIocXDLr9Mg4FIxSaZKDAiwjqx+BObR6qUvJbyhE1wRwUh8HOVHfNVb9A4F1UapWZ0IWEJkgATwMjh8GjjS6BXRK7nwtb6ZzZ+nGD4M+08aXsoKxaTqUA2SkqAQJ9pzsgBF/Qp2df4pyOgjkOXFMTjYrzIcDeFzNPOgMU6LzOLMlGrELGqFS01CI4a1L9ficYr/DRsYzeBuaGlhl3B1a5b1CCKugR/beG1CvyP+cCoo89p9griZhay/k2I+ugErHlaiCs4+9BWvBEfklQEdDgs8HA17Dv+ObRDRbjR7jx3ZlRAfzRKTcPOXsE95NDyLlbz6WLyK9sNbyeOhYOvMzq+UG29pTFAwlR/GLfjuJIK85H37uoCH33MdiFBJDprgUqT+9A3Vp3ZNLYr/F6wgpYM9nSGkqiPAKhpmdT0Sd6UAIxjUKdbZ36t0j36Nfwmmg5lTrziQlsZ+PwzYmWdLzyIz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8P189MB0966.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cCMxZWjX1Z26EQ5K45jlKrl4pXURVlkIN+9YlCyjXjknNKwMmBBkxCNvjN2+?=
 =?us-ascii?Q?m4zJ/SN5UeAjei9W+HEOZF/KsvomMJ4ecgaVKzAcprnjpISrjxIT8MYk4YgZ?=
 =?us-ascii?Q?Zg/LBaqKabL8zc6H5501EouBWWIfvGcc/srUsCBsLv1AHprJOWsQZXqRn+KH?=
 =?us-ascii?Q?HbtbxJzEBoE2g/5xb2nedaauhT1L2LuoHNd0Yi8mAAL/RWyeQMDMzNKDEcng?=
 =?us-ascii?Q?w8dRiGQHt3RJkaZd98DRFM6LEEhBYHE7Y6rHlArpwqc8RRTQ/UoW+t/XciU2?=
 =?us-ascii?Q?ywuXNVlQwjhRpPYnIlTlMSccgEO72IjrH0402KFXJE7cnh3kjcQoZv4w+2ug?=
 =?us-ascii?Q?hYktJciAegTeAA5DgE3wNRz2oPgkp3PrYOp51+XuSxPHz+YZz6jL0dxaZzvf?=
 =?us-ascii?Q?7EGq4IkwuxgtPa/LtpphDoljKxnRPFRHMuwKaY11M7coovTDCwg4oPOxA/hg?=
 =?us-ascii?Q?JaCzoFqlKUCU8MaqhL7V4Rwz/FVolBwcZvM4Noml9c9wUeQDEKPl6Sx2SuQb?=
 =?us-ascii?Q?zP1QHx2cbszRR+Vbqn66F+Ij1cpBKX3feQnhAAkoHkPoW0HqmqUy11G2L2bG?=
 =?us-ascii?Q?qk0md3jrrMQZTMbUvwqhGP9BZ1WlNMSJz+NsdbepYxxdN1h4eDM0xFiOnvQ5?=
 =?us-ascii?Q?apruzcIQT8kQ8h3cvmnTzHckdOkZwPuPR5NwSJZoURiuFV/TRXcniJ7cUcZ4?=
 =?us-ascii?Q?3UHeVULiOtReEGXEKFQZDP49aKYNrpmWKXHaBn9vggyDoerpO5NR/nPh9eEb?=
 =?us-ascii?Q?cNjttnFT5SXarjauJgVLBZFqfiv2oNhehZJzeNCBXQXG0f5aB87HD2CRkZ/i?=
 =?us-ascii?Q?n1N/hQSLJ2ABb9SHxc9DW8nCBExTn9Jn+hCkSo/mXLAoyHknCSCPmwpqaXW7?=
 =?us-ascii?Q?j5ikkD/s8UPymrYYLnY3j3Uk6hi8mQaBvcw9gvcgAFx65xKoJ/AVnoEgQqwN?=
 =?us-ascii?Q?KTK09tzOzmtxkZMJqDEmZF7oBrdGHrNHQBachgE8loxGt01R6euj5a7o/LFX?=
 =?us-ascii?Q?++DXvb3MWj8awUW/c4J3AhbGZaD92lTAsSxBnR58fNKgA5qwjih0zTnWzbbN?=
 =?us-ascii?Q?RsYDjGj6FcvPCGIbLIls+LNeiEm/0d78/bBeuelCOZyCXUFtUzeimMX/ekcL?=
 =?us-ascii?Q?4DZBqZ4nHTXiOEUmLbsSJFZNwYiv0VoiW98P1IaNjYEyJ1sTwvRnWF6Ijpzi?=
 =?us-ascii?Q?0sFsxsSZgUrwwyWltcBd8YXitCCv8vCVNiaijMy/dHqnM0CyCvSQsaQihI1P?=
 =?us-ascii?Q?vNItNTcCDAdKIvQkq+V6Q31d/fgDyXgMppizD12JLaSDPdcUHax+gStkmeHt?=
 =?us-ascii?Q?zbbYxg/JkjjgwLjbGYlGluNBFPXWRs4iKon7ShSce/uJ0QUX/7Np6Mbqt4iS?=
 =?us-ascii?Q?tOoLWOL/YltYrPSNLg30h0vhRn2JU3MxBO5Gv8+x7XR7NZXUzSu4qdqTtxOo?=
 =?us-ascii?Q?tCcqmjUslniWqVPREby9GazmO81o4fJzZ4iCiOzXFxyGakRBrAZaxRLehW9i?=
 =?us-ascii?Q?hya0dSd8lmN7dOwxb6f1oXVr8Q03JlEatBk2jTr9lLF7Y1n1zaStSo3N0Neb?=
 =?us-ascii?Q?6/8cUr1TOQNC9ShaJBQMCWxup++GMNtVnipzW6x3lHcjcdF1EOyO+LmQI2Ij?=
 =?us-ascii?Q?yDm0e7ueaQLtd36z9JXmqfBwrs8H1QVjLQ3i5ehqcw7oIZqWZQYDb7EVMf7J?=
 =?us-ascii?Q?LeCAdGFZs5zjUodyEFX+ZdJPJ4ys5gLypTaQxeGhnfmPpTmVyTWMMXou5MWY?=
 =?us-ascii?Q?br8DzviVQA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a18d9703-799a-4b8b-4936-08de90d2c040
X-MS-Exchange-CrossTenant-AuthSource: DB8P189MB0966.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 16:13:17.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjdEtyMM9l95fCn86p89k/+jaeq+GMBe4xq8ekQXJwJ5huOHywqKKGYpN9/06yJxnuHNfxxqYDN9jgiRlqm94A==
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
	TAGGED_FROM(0.00)[bounces-233057-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:dkim,est.tech:email,est.tech:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7755238BBF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alex Williamson <alex.williamson@redhat.com>

commit d71a989cf5d961989c273093cdff2550acdde314 upstream.

In order to improve performance of typical scenarios we can try to insert
the entire vma on fault.  This accelerates typical cases, such as when
the MMIO region is DMA mapped by QEMU.  The vfio_iommu_type1 driver will
fault in the entire DMA mapped range through fixup_user_fault().

In synthetic testing, this improves the time required to walk a PCI BAR
mapping from userspace by roughly 1/3rd.

This is likely an interim solution until vmf_insert_pfn_{pmd,pud}() gain
support for pfnmaps.

Suggested-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/Zl6XdUkt%2FzMMGOLF@yzhao56-desk.sh.intel.com/
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/r/20240607035213.2054226-1-alex.williamson@redhat.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Tugrul Kukul <tugrul.kukul@est.tech>
---
 drivers/vfio/pci/vfio_pci_core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index e05d6ee9d4cab..55e28feba475e 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1651,6 +1651,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
 	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
+	unsigned long addr = vma->vm_start;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
 	pfn = vma_to_pfn(vma);
@@ -1658,11 +1659,25 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	down_read(&vdev->memory_lock);
 
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
-		goto out_disabled;
+		goto out_unlock;
 
 	ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
+	if (ret & VM_FAULT_ERROR)
+		goto out_unlock;
 
-out_disabled:
+	/*
+	 * Pre-fault the remainder of the vma, abort further insertions and
+	 * supress error if fault is encountered during pre-fault.
+	 */
+	for (; addr < vma->vm_end; addr += PAGE_SIZE, pfn++) {
+		if (addr == vmf->address)
+			continue;
+
+		if (vmf_insert_pfn(vma, addr, pfn) & VM_FAULT_ERROR)
+			break;
+	}
+
+out_unlock:
 	up_read(&vdev->memory_lock);
 
 	return ret;
-- 
2.34.1


