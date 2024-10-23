Return-Path: <stable+bounces-87829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E80A9ACAD2
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 15:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7271C20F33
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350F1AE001;
	Wed, 23 Oct 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4odxQZd0"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA291ABED7;
	Wed, 23 Oct 2024 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689142; cv=fail; b=Vh6gVGZMwaDai5k3BSq+vf/9d2Mf9VsAplBi8BKdcvplgBbIVSANboPDpvufo8LdTG+YPlefWZc0WyLqtMPftsCNnmiL1/BYvGPHyetV5MUm/bGjOuZzQegbKh4m2bgclxT6aaWYpw8aPIVCbVkxopn3z3uPf/zzSp+LeXp2wsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689142; c=relaxed/simple;
	bh=qS4SuHFmq/xVWwn4fKotjXDSJjr7v0LF+9BCp31I41I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JE2j/3CfW5ZiD5h0s96VDeaVDHrgubj6zf3zFSzhY3KF402Q9HgtfWzMsPCLWcdUdDAiJkYYgCXrpljeJBrJsobcep2XDav9hmawquzZgGP06Z16ulf2qjL+I68zTxoq9yg9Bq1TYnNuacrewB+XHig713zdicJW5yzEl3JQjVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4odxQZd0; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugPG26NpuLiDIr1NJuEVE6tup72A+exQ8vLTFt7dQRnNrqdYwBegoWMzz7w2q2nObUXxNYpoYWZS224tLDm58lWWGswZ1sSPXwKUTRmcQ/xa0mgggh3efFw6DRKBgxRByDye1fmDvcpoIBAWJzoEvqHCRxxgQXM8RWJbbkQIPog8pr3D+oE1sI1RdV0XC9F/wci9WWe+ekEdFoX3AReuUNBTKli3zEF1nV1T5q0fD3zjMVngKiGmMJD4KEimmUXisbW+pZwShxw5IC9CbSiT7bOFCAUcG80i1bteGBcTEbUjaIL8aODkx9nbySi5MP6cf9gw1vVHmTtLGCWDgxAFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLKiR0WXDvHDNMW2s5Zm5on1IQD6ui6RuERqUPU62rg=;
 b=EaBi4KUGRxzqmXQUpNgyeRsOZba0fhaFbk8bb27qAEXVjDUux1rY27TxIeQixZrFHQVKlCrCRrAfE468oYSVUB/tS/4p0ZzA2QATboFYQPMPR9T0dhDq5uFjDVi087x5x0z7kNoJD3gXujzwC9AJryzZoGtlB6Ax2iP9keTKHnIq29pUchHM9DWh+vPBuaQHYVxA1TyfMQlD1TZ1MKtqNubp5uraU9JS9+Yu512ReM0uGZjKul7vXp7szzL4T54CMiWRPkX+ipVQFVNrQxrsUw0HxV4nhiRUMgj6fVxFcfDgN0IxwJU8jF4ikOAs/qgpctyvztMvQvCYBLOhGa3mOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLKiR0WXDvHDNMW2s5Zm5on1IQD6ui6RuERqUPU62rg=;
 b=4odxQZd03wqnLQbKzoFd6nFKUWU1Wtt1UnGlPOwDApzI0c5PdZQ5AT6ZZiff6MazfqmD3F0PARuADD+M9WfTqLOFTksvb1xrIEDnxnCziE40by9A0JkVDNCXS2+Js0vNWgn/94CYuPriuBj6Zu2zIkRBGnRPvLgvuWRULYXN6yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Wed, 23 Oct
 2024 13:12:14 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8048.018; Wed, 23 Oct 2024
 13:12:14 +0000
Date: Wed, 23 Oct 2024 15:12:07 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: ira.weiny@intel.com, Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/6] cxl: Initialization and shutdown fixes
Message-ID: <Zxj2J6h8v788Vhxh@rric.localdomain>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: ba62edfc-f2b4-408b-6290-08dcf3644f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lNBmOIpLpJb/f13ivHY8XqK9XHlHCuMNf5duI4w5kRtal185R99/qX2Q7SX4?=
 =?us-ascii?Q?wOyrwEU7ZBpIId8vr+Be8hxk5kV2PMsVMj7wpvhMPU3CdB7fvyj0Zy0qdOYH?=
 =?us-ascii?Q?54fJ3IpX+ao7nH0Do6M36TkkqCbS1XDXSrjZMJtmAqfWVVE1eU5Bb0yuVmkG?=
 =?us-ascii?Q?NThBj3mbGzgdwg+cWeVBYKpqpIhN5A5JkhSHptJhTmdAiGyRj7EEhX5A1sRr?=
 =?us-ascii?Q?wBCR+2ihEN0ZLYkStvm5/LA0zPE2JNMJSgH96mgx/rBS4Bl0cEDumdn/UJ5S?=
 =?us-ascii?Q?wNXEJUs/yvuqy2tZb30zbogSKRNCH+B0Gi56YoZV5JeFcFFlCzDXZkOEWhC2?=
 =?us-ascii?Q?voel1UW2RnMbzSUD7Z7XWHTEyKnBUKLzjSnEFHYBqpnjRLAEK56HlXkNWWmC?=
 =?us-ascii?Q?fdIoSzTGAUbbyjay+WnOIm7LKAakqtysjAt3ySG9RuQ4va64i/qVpdbhmgLI?=
 =?us-ascii?Q?aktMYj/mxJx/WGUfhj0oXHc6fRMrtsl5oSopYbsID8C+u7x/8ZwAZ5rERtFs?=
 =?us-ascii?Q?YTTyv6LbBxRhKb9wk1Q1D5lB3eTr0nzpbB/eN1JehSh/r9tlMJMu1gq5aj3Q?=
 =?us-ascii?Q?o+KTcqW7kdsU4sLMQqxoK+NUtLBnIFIrw+rmMKPGzT3QF0LeUYuArmpapaoM?=
 =?us-ascii?Q?OhRYJoaRXOujR7LtfBe+it5uuVZSjf9q2YIKi11LN5ohXuqm9jN9/nKxkTby?=
 =?us-ascii?Q?RhbVtuDypJchUj9hU4coO1qYVHUEywSCwkM6JAOfKSijFQmpQAG0SF558/nB?=
 =?us-ascii?Q?ul0hkRlYbOdMOUYA9LCm6MwE5RzqsM117k1+3QeK3U0YGWNNJbaKBMfrZL+K?=
 =?us-ascii?Q?xtTZpdUaVCKHxlvFPOy06JRKCa531lMWULgnTPUw+bLdjPapPjz10iNacQYY?=
 =?us-ascii?Q?C/jIW9TcIz5JkhRBwZ0x1gpSh82zV+4Uh3l7FdH0S+QNItkKBJpu7OCPYdQb?=
 =?us-ascii?Q?99cm7h7l7JmNuoX5NR9VjzF4W6daM2xk0OThztuaPXIk8rrhk9STJiIp/gCs?=
 =?us-ascii?Q?r6csazAMzl5ZTqzGtbhf98LZuk8+BSwTCIBG8+VYDBObpRq/e1IJ1nG7Ikh1?=
 =?us-ascii?Q?9VJHGDHOuxPAStwm1Va0IieoOshgJqthF5sgI9GM17B/qjzDf5X8lYCCUhHD?=
 =?us-ascii?Q?Faftv2ii9NgXyq5aC/17+KeCIXjVomgbQKMV1LnTFLUKNSpbVjU4O548ACHv?=
 =?us-ascii?Q?sRkV6tbe1Ha5IjCVFx4hdJ0/4W56P3AgVEDIh3P3OwOt0Jewu5b5iOArvlxR?=
 =?us-ascii?Q?5gz02JFhKyQlIItO22xnKqNk85DwbJdxBhg4H6QEtjklkhUw50MiZD4jFN8u?=
 =?us-ascii?Q?JRMbPLM8v8A4JC2tNFPti7KJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v7Xpx9ihR8XVVF1qg45T6zEXbK2gcu2C9f78ihFrWQrb/iH7hv4YQ+jQ7xw/?=
 =?us-ascii?Q?UQLthH93SnskjjA2cj9NTrilS1wd8zs4UKdxN+dO7UqpnCWYVTJRda+CJqLZ?=
 =?us-ascii?Q?Mmlqt47jd0BYC77dknicrN+uUXtBbDsHq5pZOIYcKeiR2u7l8QJf8jquJ86N?=
 =?us-ascii?Q?qpRfnHymCxrm/Bm6EC05iUp3OZ1hUMNlg3B+juHoyoZgstI3mUlSc1PVLjPS?=
 =?us-ascii?Q?JNHNiPcBDnHO0PXC1HymBmuKUl9yfpQtajbFWGnJl03qL2ELqwBIigQtZsdy?=
 =?us-ascii?Q?YCY27PTa8UU0cTWj6kR3sYZ1InoyZFAXQg3fxkK9N8+S2FfPoRUYuEuzANqQ?=
 =?us-ascii?Q?BwzYRXbuNCW+Fc7JIMUUVyoiP4lbcJjPIOqmhZBnNXGga56e6SFHzj6gWC9M?=
 =?us-ascii?Q?P5Tg8ZQMLnn3PPy5VRCycTXBiJQolmD+b7izf5PzSwOomLyc3WgEkHkzKxnU?=
 =?us-ascii?Q?S6SxEs7MkFKVaUykOI2kFdFVi9c2YdnB97hZQP2wv7T/NhVx3FpzMciaU+qq?=
 =?us-ascii?Q?g+wokZNGahxLpJ7RkuaM6dotcJcW5sKZrBk68LC1Dik6IpV54DIiJuicUkiw?=
 =?us-ascii?Q?Ff2OVQuAGcmpUTRXpUYvwWGVXk4gWb4bfv5TsZXd/aV3FnyoPKv/cMYq9Ulg?=
 =?us-ascii?Q?Q6Fx1vdkLId37y7eCbbpnozigmIy/nye3IpKCTab1odHpHJafTh7NTFL03U+?=
 =?us-ascii?Q?hniHPrs7wLibsYtwvcpuHs3AKRyZ1DLVUfxOkkiYrxiANZAUHSdXSSpyUgUr?=
 =?us-ascii?Q?aUNv3BkZmXC9aUogQXIgVi/X3iczi/x9OGiA7YRx5n/Mqf404yEe4fuctqq4?=
 =?us-ascii?Q?vACvstWHGPbsAOgwqc0jKha3Nl36T5XL7PqtGaaCnA5JlsgDutJxUapCRpZE?=
 =?us-ascii?Q?wxpTar29ALLJ3mc7L/Bj1bjmcFHdRAL+H8O97YCGYp583qvpG2R+Fq8K8LF+?=
 =?us-ascii?Q?tGxBEKbuk/K/whDKrtcJX+leZaghxH6IyAeNsDvx9a1l9AmpZuNihpCVw4iH?=
 =?us-ascii?Q?eKHrH4twv4NUxqXfp4c4wgi0BNiV1voL+oaWFrS5rsD4oTDN5M471YW2zVF1?=
 =?us-ascii?Q?X7Eemc02jwwTuXaA6ip6eXVoLymeFMtu13AhFXQPQJWtpTXerAsppokxhBGE?=
 =?us-ascii?Q?ZYwYnGyqD7Ee3cwsKTrMBVWXuM3CF5J5eGmSctcDBKVJjm6hjMZfU3GYgK2D?=
 =?us-ascii?Q?Be4KsCz5NninlUyvrlO8PDUhzD1REobo9uyQicEiBF3hUpMiccHpSzqgWtCX?=
 =?us-ascii?Q?CKqOhQ1ukvNPi+Gro0gTIVLl20T2fm0ghRQvlf17ZFiDIUzEP01V+co3BKsV?=
 =?us-ascii?Q?vxXLDmaVnVqPz6+Oeveufic2y/f7FOPb7oufU6tA/4ETOvKPUGDKJQuRHdP3?=
 =?us-ascii?Q?HfAKcSvtrFJ3RlJYbTboz6c3oGUeroF1ohKsF5TAsi0rlux7IywN6DJwcOaH?=
 =?us-ascii?Q?qaAKy/dqxMsD8HEsbPNqx1dRH7h6yC6/Ru+sd9OLX48VeBdl/gjuJJJuYfDj?=
 =?us-ascii?Q?9Qf0piAcAu87azqNoW8ws0ZICB4X+/sJHJVOLs/8/znwT2ogkPLORFPxlrpP?=
 =?us-ascii?Q?CsTjPra6cPfldKVvPAxWv7Uog1SyMD5vrSDdBjtv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba62edfc-f2b4-408b-6290-08dcf3644f90
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 13:12:13.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bjz+zBXszkio/Xz//utpIBXbidgf9NlObCcBtjOCeHu9tCCe3nuOwWaNb38HTyRZeaHBS9BP3Vfmsi0yymJOeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091

On 22.10.24 18:43:15, Dan Williams wrote:
> Changes since v1 [1]:
> - Fix some misspellings missed by checkpatch in changelogs (Jonathan)
> - Add comments explaining the order of objects in drivers/cxl/Makefile
>   (Jonathan)
> - Rename attach_device => cxl_rescan_attach (Jonathan)
> - Fixup Zijun's email (Zijun)
> 
> [1]: http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com
> 
> ---
> 
> Original cover:
> 
> Gregory's modest proposal to fix CXL cxl_mem_probe() failures due to
> delayed arrival of the CXL "root" infrastructure [1] prompted questions
> of how the existing mechanism for retrying cxl_mem_probe() could be
> failing.

I found a similar issue with the region creation. 

A region is created with the first endpoint found and immediately
added as device which triggers cxl_region_probe(). Now, in
interleaving setups the region state comes into commit state only
after the last endpoint was probed. So the probe must be repeated
until all endpoints were enumerated. I ended up with this change:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a07b62254596..c78704e435e5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3775,8 +3775,8 @@ static int cxl_region_probe(struct device *dev)
 	}
 
 	if (p->state < CXL_CONFIG_COMMIT) {
-		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
-		rc = -ENXIO;
+		rc = dev_err_probe(&cxlr->dev, -EPROBE_DEFER,
+				"region config state: %d\n", p->state);
 		goto out;
 	}
 
-- 
2.39.5

I don't see an init order issue here as the mem module is always up
before the regions are probed.

-Robert

> 
> The critical missing piece in the debug was that Gregory's setup had
> almost all CXL modules built-in to the kernel.
> 
> On the way to that discovery several other bugs and init-order corner
> cases were discovered.
> 
> The main fix is to make sure the drivers/cxl/Makefile object order
> supports root CXL ports being fully initialized upon cxl_acpi_probe()
> exit. The modular case has some similar potential holes that are fixed
> with MODULE_SOFTDEP() and other fix ups. Finally, an attempt to update
> cxl_test to reproduce the original report resulted in the discovery of a
> separate long standing use after free bug in cxl_region_detach().
> 
> [2]: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
> 
> ---
> 
> Dan Williams (6):
>       cxl/port: Fix CXL port initialization order when the subsystem is built-in
>       cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
>       cxl/acpi: Ensure ports ready at cxl_acpi_probe() return
>       cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
>       cxl/port: Prevent out-of-order decoder allocation
>       cxl/test: Improve init-order fidelity relative to real-world systems
> 
> 
>  drivers/base/core.c          |   35 +++++++
>  drivers/cxl/Kconfig          |    1 
>  drivers/cxl/Makefile         |   20 +++-
>  drivers/cxl/acpi.c           |    7 +
>  drivers/cxl/core/hdm.c       |   50 +++++++++--
>  drivers/cxl/core/port.c      |   13 ++-
>  drivers/cxl/core/region.c    |   91 ++++++++++---------
>  drivers/cxl/cxl.h            |    3 -
>  include/linux/device.h       |    3 +
>  tools/testing/cxl/test/cxl.c |  200 +++++++++++++++++++++++-------------------
>  tools/testing/cxl/test/mem.c |    1 
>  11 files changed, 269 insertions(+), 155 deletions(-)
> 
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b

