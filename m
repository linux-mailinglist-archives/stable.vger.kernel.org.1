Return-Path: <stable+bounces-141945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF03AAD195
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C0E4A6878
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A90217F46;
	Tue,  6 May 2025 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dxalgQcM"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419A97263F
	for <stable@vger.kernel.org>; Tue,  6 May 2025 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574689; cv=fail; b=HLVFHbqGjfF2zOyysMP7ajDZ1MZvHxBDLdvfofA1pzIpX3Xvzx3nDrlE1+MM93vddKtwemim9FgliiR5Fa4h1/wJ4NbEgQoV8Oy/qhVB8SSwbKcWtUx/i6tqZzyNdjw4pcz/DoeOtv8aOt5zu+z1Drc5UQlran47H3vmmOgflgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574689; c=relaxed/simple;
	bh=Agog5KyjtbssmijT404q/ZulrT9Yq1yVJuuz9U6dfQs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NygHN4h/MelzyzHcLqKZYh3G3Kpq0Sbzf7BiclZucEkezSymoulotjKMYzpMGYRTmDaU1dSBEji2oeLdRH+4vYh3UetwR/HiwHu+m+cwvCqvyj4kBNpIu67ObcOGdiiEwOxDhuoY16e/i2tXzQ+1Z5kKRz2vmckNPVH2Rzr+krI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dxalgQcM; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvFhW5x5FmND6wdwgpaObPeHS9/g12CleLC00DD/RQ3G0rI2i5AakbwqLa4atY2vq3SdH5EsVJRDdW3fGQBoGQJeL3mwYEApS0Nu7qsNrKuAjvLUxJ8dPMQywugEEhD6P4gXeO7JeT/bfYMXE1Wz5yTNWjmkYUqvZ8JFqwzOjsKRwPsAaa9tWfb3roRGSnev7wSTAackBCE8fxPpscQHJHMpUQvQzUz+Ror2jwIZ9Tcqgy3urZLrenGFk7tAUtDuGsn9h9/nZvo6EW0H6p+WqohGpho8bDQSMUFq12d24n/AZCEq8fgV9jYJTxsP+IY5MzXVEOZuuR/HnkLW+sytVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKDGuOIWfF5SRLNf9mKFh2d9NQztY+aFTmMFHU9gMbs=;
 b=vF1cJC5H31WSH1/kXim8UJgftMRHoy59TP7N62jPaBvSg0hgijwC9Izj/PQzluTwB//nEUF50/i57iEWZaH94r4U3DdYqc1bodtIZkfGWDNkm89g2G/2yAl1QHy0kdugMUygyZpi9Z/+BIcpuAMO5pfyXXpuAi6Gp33tecDgXfsPO/8oj4Kw49yGE90JR9uyvq/XAE2xeTT3rMFUiNyOmh5tDceTgrZlGxntanwoYZrYUy7uZLtFDkPhO/8Sv3cvY2bhEY3Vzado17OPfNpIPnilOCrKybQYNXf5ZNmx8ivwk9PcH7gHj9orEksqvVvZMK7kKE53KsLDOTvM816C6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKDGuOIWfF5SRLNf9mKFh2d9NQztY+aFTmMFHU9gMbs=;
 b=dxalgQcM1R7ETPIffl9YTjZTIIxR1Y9Q83vIgwmMAFNG3JkBjNSKap6QfF4VdlmLP26OForfZvNrNaqWGpMukLOvk6IsOmYFWPz4z7YMu6pQ2PGNoXacViZzhPBFCcr7w6ZYDKJIlSlV8wIonRKr7ceQ905Df1gX9TGHw1elAt0as7O7P2PvYchKhn6patdeAJuc7u8/aMI2j7rpQIf1+0M5zNkJLPH9a6gGdRLFV5MI6iAdVIyYzLC+WTVp/Z8VqcJJqkxe00pXxLcPOvuXNUfT4NMu3dCK2iodOiz6N/rZ+gJj27kFUKHn4iieakFBXS78/Cn0AJfuMZYFoSvlrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 23:38:00 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 23:38:00 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH v1 0/7] ublk: Backport to 6.14-stable: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
Date: Wed,  7 May 2025 02:37:48 +0300
Message-ID: <20250506233755.4146156-1-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 44be7467-1705-4644-59cc-08dd8cf709be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Luy73BvMSDSe25qkC9AtUco6VpRE//fHdFVOjYJC5YFPTytq1eUBFIX9X69V?=
 =?us-ascii?Q?pRHDcvewrQuk5bOH+rE94T5j79H8P+SA63l5V8dUeNEgQuDmkx/AEkRpNW7u?=
 =?us-ascii?Q?zWGzGKd1PQNWMqlVW2OD/THjWQ2oYlgZTxjUokSZpb5pweODkFUvXlSKbXsk?=
 =?us-ascii?Q?tghNsNQe9tZrat85Px/nPuM2Ig5GRhpQlQrB+xhx69i9Zabs6pUYaXteKHgg?=
 =?us-ascii?Q?cIzOhnR3Gim+W47a5ZFL6OzZEzLi7bovRwjh6Qrn5pc1dqawflky7ZEkouEt?=
 =?us-ascii?Q?Mp+92WfnHczlWulLuwQopzA0zx0++FFyjV8375VBa0e1d9AxNLmrbyVy5tVR?=
 =?us-ascii?Q?LyD0SuXjdi0prFy1nwIsRXjtddEG93Vh7o66ECaqL8tIoic0YJ97P7+6HOxd?=
 =?us-ascii?Q?VgCfNEOhiItDXmyS+E7LCbQlig670haqqiHaWYZjRUvVuJe6Q8EhjmlW3Fwb?=
 =?us-ascii?Q?UT8sMLDjjX6JvuyOiStZbPfk76l+YZX7/vsWxfGij2os/0gI/ohuZ+QGbvnB?=
 =?us-ascii?Q?NPPgLEDyM4uEeI4j1E9gGm2Tk3NPDoVfZUqa5g7SyvC9TGR0tfOD2vdYB87B?=
 =?us-ascii?Q?dYY85GLfjjeoKY7/z6R1YXwVgiisab06vV8hq0h+MtbymSSZXMHdIBSgLkRz?=
 =?us-ascii?Q?N6YQgMFEnxjKs7NbnvBGd0Ye7OABhus6GGpStIFYLXroT90lTZNjPATkXTFk?=
 =?us-ascii?Q?2x91YNsXUUiWd+PEKmLiI6WCKTkOU9qfGpajIE1yrO8P+qCE+BtUgqXxsrtC?=
 =?us-ascii?Q?hNVueH9zbVUjZ07710SRaK9Yr4PhM6M6CRZeKb76frQZ3LVVBsoR685jdRMZ?=
 =?us-ascii?Q?XadnlfOMiXfkpG3vzWPe5Q5skuGT4b7lRqv/LLIeaM0OWPv2ky1ne9mbSwtw?=
 =?us-ascii?Q?biVOswJbomMn5y3xqaKAEMOVSLscHohi90ZkR1KVqN45ytVNzs1bxE5ZN1GA?=
 =?us-ascii?Q?a52m3a3doXXzEcrQXirtCq6t9xZs1vjpuBMxG8QNAqj8b5gGHpseL1B1Z2es?=
 =?us-ascii?Q?t8rl9dckGBO5qBvqGBy2wE//7Q9C2NYDesDdFDwZ9Y8b9QjRSrzP54CzvyqM?=
 =?us-ascii?Q?XUl4sujdKFCvWdlkAhOONMEZgkCRIG5Wi/K1LxNQ5W2V49slMccZHUMYnguI?=
 =?us-ascii?Q?MmkqTjDUrAW/bMDYL9/FgFAkWkHebJUAE9+fm4uUUI9KmacmySFq9/+zBSni?=
 =?us-ascii?Q?A68qsmfZH665HJKGEs0Bujkcl2PyARFFzUkv1XTtDyzM8DG4GeoIFXwT2v6X?=
 =?us-ascii?Q?AQ8MrWv0VuBSDBY8DE8D6l0+rwm5bP/j3phv8bZ0TLQPDD4LCSfVvfULDxuS?=
 =?us-ascii?Q?JYQJRMIFn08QybSpPZ2AbjB+DWXzacfCIXLxMd6KZB47IAGkVfjMcNE4D60+?=
 =?us-ascii?Q?hNrEI3Orguwnx29egcYxwz0YoEynT5fYjVETm3GH0o1MNs+8Qpgk6yaKCtGX?=
 =?us-ascii?Q?IArSyjayURc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OoZb45gggSiGyf8yT0ydBBHbyVcncT2axDpOce46jNF+ITjzDvEtix54dWUK?=
 =?us-ascii?Q?vRSPvXa04G3It9hntulXZIkCamuiT3iDxpTJmu9lgxUFZ5iH8YqTLF4WMwix?=
 =?us-ascii?Q?m9wf37qR58/caqdPAMZQtqB/gyDPQuxnDFI0giXHeAcnzLR/tIJM/UVUkCHG?=
 =?us-ascii?Q?MytWGM/ag8NIE2obDkr5E0CHA/+RYe8/gc+WVBGMzjEOOWCalCOuidqC/Kfv?=
 =?us-ascii?Q?dDoZrR1bJLeO6s/32zkZFvnz0HgTGAw0xxJ1gKrivz0xQhxJiPY1dyj1jjCk?=
 =?us-ascii?Q?dLWBKa2PuNZ/75rTB3ByHGN7gLE4dH+kDP4ZcbpI6o7cj8T81YseJviwj+ru?=
 =?us-ascii?Q?7m1c7uN6jKi3plUjEik0HTuFiBTDyBNWmeJ+l9NrUp+Pk/VgbIk71VSKHJXP?=
 =?us-ascii?Q?ODVdTYEUTt0/wyXUt6/DRmxbVe/fNkwp/38cxbk/XkSkxYO9bOvISce64YYH?=
 =?us-ascii?Q?rePSV7WZIG1773KT6grSxhvWmP/X1waTV0MmvxdqaGQARritd7GCr+eRe9BT?=
 =?us-ascii?Q?LXIFqrBCVus3YUfWMqrGiRFs1mqODJfufDygZkucWoOiM8s37f/fx7mRF3O+?=
 =?us-ascii?Q?DM6fRXQH+ocaaxyS9YnPJeQ/XlF7aukFm3KKylg+KebHI+byMFWgGKkr3teK?=
 =?us-ascii?Q?ZyYB2R/pyrDM2SUAgyECiDq4KZZtWSaeVZm+iBghUYmty9AcyTHlXkerwm3g?=
 =?us-ascii?Q?5VExprc7Wmn/KflQEKAnVTUbcTaEBzrc5dMQ584LOmLnMIRC4FxWQ2LRVsIC?=
 =?us-ascii?Q?U8dD1ANNsoaI65RXJeG4KOikrk47oHzkPh5aAl+tDluZpoc9C4QZM4n7In3S?=
 =?us-ascii?Q?KjOfG++EZ6k6ULY4AAvc61rKCxfrMjETZGYJSozWPSwzDwBmKwST4jyqcwWl?=
 =?us-ascii?Q?gaxxuRREhOeOUUZl4Mqyfy7S/UNLMhxVgVyUaeTB/p1A0S6yd59tIBMI7N74?=
 =?us-ascii?Q?Dlbomw+ZNfTOPtCoofKamO3EVwayezEBFropb27d+G/tN91agmeRnZncvqK0?=
 =?us-ascii?Q?pcZxSIEA9E3hO5L8GF29HkwH46VFNnpv+Gf3kzEkcuE8hm49BlQePPqfH15P?=
 =?us-ascii?Q?iPyDiqzWpiPyvs+hEbKK7hxhSAfCcYzUd0g8XTq6oKxl1ZswyKsqrz7e//Q0?=
 =?us-ascii?Q?h95q1G8Wmh4TdIDVlKH7lkzzVVYA+fl+QpKgsc8dEoKsS78+5eJY5utGm5O/?=
 =?us-ascii?Q?q6QTK2zSh1GFaV+0dioTx5WKHqKEOE3MjgNxZ6uzrk1cZamdugyyBUV4EARj?=
 =?us-ascii?Q?H+DohYzrD3F64FmngW9BPsmbkjAA0UN9lme0cyhAeFZ7VrZlOaHsiBYN/hw5?=
 =?us-ascii?Q?oWOjrn3Y9miJFjioogeLf3/xFoC4O90ygAm8BEpntPlHS0KD93f8CswEfLY5?=
 =?us-ascii?Q?uFB+hD4pyb8ayKKKRmxEeazFvp2x+rOpd2cUtpBKrSssccqJfOJipk9Ly0AU?=
 =?us-ascii?Q?tsgiPJvB2K6lZeI58vk6QsB1hOH+VIgdsmuScChgXneagUSWKEOrBGNeBi7t?=
 =?us-ascii?Q?oLRuZONk5k6RirvmuRm1YH7tSvgRjyaChr+T+FP3CP0P2qMyasCuQLAzk8AO?=
 =?us-ascii?Q?kN6GwqtELPQzN3Vc/3LaGdmMfi0cAqrH3mwZACPjBgGhsEm4n8ZMEw15U6tP?=
 =?us-ascii?Q?PFWR1wmqj1eDqimLdBw1ENCEKB53UxmXQxCs2kLQ0Htb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44be7467-1705-4644-59cc-08dd8cf709be
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 23:38:00.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWdo4+RUTqeWWqIRDIyT7M1VXXyVMut/KKZU/zXH4dofkrSY0qsXOsAVbasGu68UOBgT3x2wQ3dmdrSNYxj31g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

This patchset backports a series of ublk fixes from upstream to 6.14-stable.

Patch 7 fixes the race that can cause kernel panic when ublk server daemon is exiting.

It depends on patches 1-6 which simplifies & improves IO canceling when ublk server daemon
is exiting as described here:

https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/

Ming Lei (5):
  ublk: add helper of ublk_need_map_io()
  ublk: move device reset into ublk_ch_release()
  ublk: remove __ublk_quiesce_dev()
  ublk: simplify aborting ublk request
  ublk: fix race between io_uring_cmd_complete_in_task and
    ublk_cancel_cmd

Uday Shankar (2):
  ublk: properly serialize all FETCH_REQs
  ublk: improve detection and handling of ublk server exit

 drivers/block/ublk_drv.c | 550 +++++++++++++++++++++------------------
 1 file changed, 291 insertions(+), 259 deletions(-)

-- 
2.43.0


