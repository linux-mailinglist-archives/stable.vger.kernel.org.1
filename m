Return-Path: <stable+bounces-142021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B850FAADBCB
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA02B1B68170
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA20156F5E;
	Wed,  7 May 2025 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OUdMZamy"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A98248C
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611256; cv=fail; b=mV7OFHLEYJV5c4vUsHoGWQzk+PsYFIntNLkpYNOQpTALb03DpRPOGgWn50Jjon/JfT0rwpjYOK7YBDo19A2aOJtF2Qb6aaMIR6Y1NasOsfdZxrgSm6dl4iJDGnPCeA59Ezba4RNalV6ma/5PgRXeT814W9wTKrp5cT0IgPNIKs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611256; c=relaxed/simple;
	bh=DgWItI/eVNKz1GoQwiI1MwVYlGM0LLPraPbxuWVxYYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TlrexUXet7pMgjjM2K/oqzaQ3cGfZjxKrSpN6efbeh4Ui5BJ1nRYO1ZMY72ldEnBKfFfCW3HvkbYisPmcRoh4ulCgy+cIYj6D90K+8TTzYUucjF/ZC2v6KXgTYwWBCvq0cV/BP+nP0Or8WBBdWZyrFx2TvLs74cGS8p+YTJGAA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OUdMZamy; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeDF4iJ4tGMDkUxzBlMQR1RUT2icY1GeSwvdHBROF8gPmfnnyRrD2za+LI6XUFSHEjEEqxDtOJ6WsbsOub2O1cePbMUw1HcbiDYne2Y/Cj5rtuCR+x1yYwn3jzsggjA98ILc3RdpAsKkMRxVIQPPyVXX2lDZu2UkBrwQA8lRBQFJoSTAtA0OPohPyDgZKiYMry/MJ2jpMZzhL6Ip63OnpOwkBVD8nFaT8+0kbo9HjXy3DlHunUG4LWrw2iqXLo6dqMhBrDUtCJcMLvZPTwpIelkovVJ7kCo+lOxOLTe1l3xnPRp+v+OMNlca9GSSPpDUaC9Oe4whiKhL4rux0JOCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEnx6yR4yD45+PW0KIEdqSGtH53/zzapD/ziVU/GEqQ=;
 b=Y8wEFS27PW78tLtveY6PoFKu7yHo79BwZhQa0hgM6sxsFgw3+CmPUgnC7DfVi3ILTo1838y267grDs0ynMi/Q6sop1qumSxR3Ma2LMbHUf0piSqSn24L6ByGVHU/J5Z1jo2lf9aTztlUCCkK7x+XOGT8Q8paUw291su5ONL4391EJp0HR4ywqRaYiPC8p/B05j6Eu31Dyo0v0qzJT9pNGOUCpu//UMsPtrWji9UUfA070fAehafVVAHYVOTuSgr2hLyi9z/mQk7BbiUdhqVwTX9KR80wouUano9SVz9/ucir2fdLV5WeDZMeRonqw/pwvS5gkimmHvvgsoXPuK223w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEnx6yR4yD45+PW0KIEdqSGtH53/zzapD/ziVU/GEqQ=;
 b=OUdMZamyQiLZhjZQaGz0jHJW4HnNX4S4wPRGrtdZ20A4bxqdbm5+i2KhIu4gxGtLuyza/cqfEveFzWqH/d8hLFts+daE+4MNESPQAZlQIksXAy3sCupvsh0o+ADCBxv9c7KOxCDotjjBYayRTkpf2GqeNrR5sjsOVEswF12xqq720xSqKiWAHZB4Ev3ChqyqEo15HZlR01aFHLcUGO5xg1+RMVsRlWJBlkkeT6IBPhCcxYIqJvGcX1cSln6nI5Reem60qyGkJGY/aDefqwKrD0xJgAQfct50DqsLzMJNofxCSwcKFTs2Wj4bBntCUQ7mzBd4aE6uXJ6E511JTkV6VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 09:47:25 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 09:47:25 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH 6.14.y v2 4/7] ublk: improve detection and handling of ublk server exit
Date: Wed,  7 May 2025 12:46:59 +0300
Message-ID: <20250507094702.73459-5-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507094702.73459-1-jholzman@nvidia.com>
References: <20250507094702.73459-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: d418bb9a-e5f1-4e11-e7c6-08dd8d4c2bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?snHLyA2vDkjfzYxX5+6zJ+a2OU5nAdv0Fxj9i95yjMVyETun4+9XB9y3JZWg?=
 =?us-ascii?Q?5uuGoG3oPEubNbuzi/DrrybTJd30DXUdisceOtViOtEu9whkGrMSwVW3fFJ+?=
 =?us-ascii?Q?y2BF44UzdKuuWYxDK37CPWHs2i4Qb3BY9SzrbbPxyA3CzyW5vryH54qBrEmE?=
 =?us-ascii?Q?v8vvIvpefjaXOCu0K5v1xXFwIslO+D10MKj8FSU/W1rsBej7Q+N6xy+MdwdB?=
 =?us-ascii?Q?q6YS3AMSPcwkTZqliP6Y3+KeAIqFqC/pBqDJBguWTmQ64QW4gN1jkz19gDqr?=
 =?us-ascii?Q?wXlzxl2UmZzNQA/N9HF0Tpeh4d/4dwOqhmO78rIHsSDTUtRoBuCp3uEt3w2Z?=
 =?us-ascii?Q?oaBEwVfiJ1Yl//AAzASGIdLtpOG/Ir8iIeiPpaBpjrdk306lgCybAQERY0Sn?=
 =?us-ascii?Q?b2y1NWZUzzdanmCFGaj92oNunOC7vSCxcaKLL1v+8rN1y9IGj9d/rgk5YD+P?=
 =?us-ascii?Q?1x49pZJLOd3EJLzmQ1TfH2ikWU4e84H9ZAUQjlFXP6NFkR829cnRIn2tHiXN?=
 =?us-ascii?Q?2WrjEckk9sc23M6ampIqLxxfeWTxv1HoSbK5/IBwhTaIFh4K9/Z5zntAbruF?=
 =?us-ascii?Q?zsGUmZE4NwAEwaa4gAyqxEOGhBNlseEBGBpJGkKN+8dCLtIakOtB9tJMEy5A?=
 =?us-ascii?Q?tkK4kxFmedX+3VvmGX2upQkQuL+vQrcSd2YQ/5zYoURnwHHiPeaNQ5s+cZq9?=
 =?us-ascii?Q?sUSYE6H/XxUruKdrWM90uVKFrPTxjlnEUb2ygQcnK1rh0b0YKCEaWAPd30Ly?=
 =?us-ascii?Q?yUZKEIqoTUT7GntPxkcFbBnFEH65+xCDIm3XD9kNqsSSYjWAyjcfnTRw6o5W?=
 =?us-ascii?Q?TtwnVzfuQURCy4t/tAc/LdIkDlnP11zsKyCirA5Zq/YKtq10h47x/SZLQUXZ?=
 =?us-ascii?Q?lAwsjzEbllSyAARuvM/t21IenWO5fB2uGOf3icpZCJMcPZAxHLEfzNZAtsp3?=
 =?us-ascii?Q?YaILcYZ8Urvmzzcu4pRo8zRMfFx5C4Zd1ixmbzJVzs1IivKT0MiUx8oyyU4s?=
 =?us-ascii?Q?CmzbYbHFDF0z8KqE0nBh7rStAVFUOkiixoNMTlPEOQtIbtVhhZEDl5THTcoF?=
 =?us-ascii?Q?cBRDea6bU8fjK8RvxtcHK/SoO9kmM0Xwqimw7FyUu70Eri+tmYi6hbvP/al8?=
 =?us-ascii?Q?MV0UcVnqHHH9pRNvxvKduDLNGbqGfzUfse1jr4yDA55GbnNObiLwZEBWROC5?=
 =?us-ascii?Q?0enrQ2mOqft7VPT0PjmW7S/F/EJieGlIII1H5QR6//nT4RWdRMyx/y1I3/42?=
 =?us-ascii?Q?FdMOqA+kgEPhIkdriU762kQhXj2hQSqmDvg2UhWsJSgZw/8e6NM8flDhlFUs?=
 =?us-ascii?Q?99LFuEgXsH4M8+FfMB/DeG9bhvM3oFQrjgcyik9WubE2SpJyGeV9+ZV6B3gE?=
 =?us-ascii?Q?GvUxl4YYEraD0cyyrNYuQh9HqQCOafFayRqi8yDQ/ce/DQ0k+6Jufkvz8AO4?=
 =?us-ascii?Q?NrBz1N8AfKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IhfY/S2PHQ29igt89LOMungyb0bIVHR0gt/2ZhESrJx/YjQGufPuQFXJkoDU?=
 =?us-ascii?Q?noa6p+cn8XqbFLmKgDas7Cb+/OP+hrHCVTeUdY+lGSw3pda5xqy8YBtrp7xI?=
 =?us-ascii?Q?Vjq2rs0pthbPcmAOcLeZqHMlU0mWmfDdOkoCVMi2Xe3B3NR4XChhpJ1s/rer?=
 =?us-ascii?Q?XknkVBCRs0/oV30BrxHRLLjetBxY63G9PCi3SpW+FhhUM6jC0xLbpIyhK9vW?=
 =?us-ascii?Q?dSVpnCG8c2t/4jI4FyAGhuy8LerQ5ZWTf1BC4TjxJ4Iwqy8sSF/QFqoAecBY?=
 =?us-ascii?Q?O+fx0maWPqahnCY3vjCPaoQBrmX7WC6BlblidiYQsOfoU+keJrYyZWQCkqmB?=
 =?us-ascii?Q?qhRzvkIQtDsQg6Za3YqQwLQ7itLG21mfBjXUBs74fHlhwS2PYB1708Fz3LJV?=
 =?us-ascii?Q?uAV6a7RSbCWBCuN+UDPNfztsBrI/7YLmZoKSEj80dEvoVJhQhMCuFskEMBs7?=
 =?us-ascii?Q?u2MyiH/FmOQ2i2ELXX/tsccye/HWgEmPIJY0iarYHKYamJZbZP9AmMySX7k8?=
 =?us-ascii?Q?c7qzFsWxlHLgLLfI4HEW34cl29gLxf67V8VyoyMI+ebmhdo0hJHCtCGQ17sr?=
 =?us-ascii?Q?0maHxomjWPO1+L2sVy+lXGq1UDV1rfMJFpjJjB6vdET/HZybu0N4WT3FkuFi?=
 =?us-ascii?Q?V892wSJAEVHqEyqzkS1KLC4YBmkdYhIqowvTduwUuEYZOhCE8t/rfxucjRc1?=
 =?us-ascii?Q?/7LDD9ZvYsDe2tlNKRqfrz6xY6WFJNoGlB/7MciK5y1PFtbMMc8CeCZ8176v?=
 =?us-ascii?Q?QKtjVkENhnYbmpBiQBp0FdXgXlr5BaVFdWdx7M1h4j05PFu6jnG5UNvCTAX2?=
 =?us-ascii?Q?IOwTZQ66Mvq8uwNt2j1SKg5k53Aq+q+7rsTPXcugba1jSTHthJaa+om5d+64?=
 =?us-ascii?Q?y2EpaIa9Cs8G9heVR8veuIb3QSm2KaPtqTVt0noPhVrk0ZYM8u2h2siXyVC+?=
 =?us-ascii?Q?uVEhgVvOHMvmBxf9ePPTWRyk/3/CWs7p4HeGRwQhrWFnCEclMax2uKX+uejT?=
 =?us-ascii?Q?MhAkBelhjmcYliZLHby7YJa6Cab+GLt6fISFst/FETH9kebSIH+DwydfoGtU?=
 =?us-ascii?Q?UtqYDBYS7N+m0bK1r+77VCiiWGwSfblv8iEoCpU/Zgt0e083FuD3HewRL1i4?=
 =?us-ascii?Q?+hYDwW4/aXSbDT1iS3w4I0DgvN18hUfYAu2c9JtaBf/6D2UvVLNizP5XgV//?=
 =?us-ascii?Q?mGYrWihfcVMzMdK5JqtJU1J9w/cFx2RJ3CmWJrvCZ10VfO8YSK5+vxExoeTi?=
 =?us-ascii?Q?qxZJzV/i9yDsHayNnI1e72L8Q0pqhfDju8LV/UG+fKz8AnqcHFXqtJQ9aV9o?=
 =?us-ascii?Q?S+yuHgUQhZGKED8wphPGSRw13IL+Y9Qg8u+cNyYYIgBFlzQDMBirO196Tv18?=
 =?us-ascii?Q?6hgvwBMUcJ/yp3Fjb11wP3DpOwRZapk6r5vUj822ki/MkG2da1DMM/FmqVOl?=
 =?us-ascii?Q?LubY2U8ascJsfADfYhgrmXHEJ84OYVm2uZoQfpcKeWeSMYKeWIlxiZwE8iiq?=
 =?us-ascii?Q?qc+jOba5QI2jSEFF3BsUKsb86vfT67EwdLUeXyaa0r5YJNZ9UYfRzim/9yrx?=
 =?us-ascii?Q?YDuaFPcHqcKmnDfwoySxvXc8SMVdLwpcplhveprq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d418bb9a-e5f1-4e11-e7c6-08dd8d4c2bc9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:47:25.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTlQ+WTaQQo5vg/0MseubMsRPFW7xGtUvQRT6t2DOmgKN1qx6ZE8u5i/HNz6PGiMU6OPAO2ncB+3Qbh/3nnfdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit 82a8a30c581bbbe653d33c6ce2ef67e3072c7f12 ]

There are currently two ways in which ublk server exit is detected by
ublk_drv:

1. uring_cmd cancellation. If there are any outstanding uring_cmds which
   have not been completed to the ublk server when it exits, io_uring
   calls the uring_cmd callback with a special cancellation flag as the
   issuing task is exiting.
2. I/O timeout. This is needed in addition to the above to handle the
   "saturated queue" case, when all I/Os for a given queue are in the
   ublk server, and therefore there are no outstanding uring_cmds to
   cancel when the ublk server exits.

There are a couple of issues with this approach:

- It is complex and inelegant to have two methods to detect the same
  condition
- The second method detects ublk server exit only after a long delay
  (~30s, the default timeout assigned by the block layer). This delays
  the nosrv behavior from kicking in and potential subsequent recovery
  of the device.

The second issue is brought to light with the new test_generic_06 which
will be added in following patch. It fails before this fix:

selftests: ublk: test_generic_06.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 30.0611 s, 0.0 kB/s
DEAD
dd took 31 seconds to exit (>= 5s tolerance)!
generic_06 : [FAIL]

Fix this by instead detecting and handling ublk server exit in the
character file release callback. This has several advantages:

- This one place can handle both saturated and unsaturated queues. Thus,
  it replaces both preexisting methods of detecting ublk server exit.
- It runs quickly on ublk server exit - there is no 30s delay.
- It starts the process of removing task references in ublk_drv. This is
  needed if we want to relax restrictions in the driver like letting
  only one thread serve each queue

There is also the disadvantage that the character file release callback
can also be triggered by intentional close of the file, which is a
significant behavior change. Preexisting ublk servers (libublksrv) are
dependent on the ability to open/close the file multiple times. To
address this, only transition to a nosrv state if the file is released
while the ublk device is live. This allows for programs to open/close
the file multiple times during setup. It is still a behavior change if a
ublk server decides to close/reopen the file while the device is LIVE
(i.e. while it is responsible for serving I/O), but that would be highly
unusual. This behavior is in line with what is done by FUSE, which is
very similar to ublk in that a userspace daemon is providing services
traditionally provided by the kernel.

With this change in, the new test (and all other selftests, and all
ublksrv tests) pass:

selftests: ublk: test_generic_06.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.0376731 s, 0.0 kB/s
DEAD
generic_04 : [PASS]

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-6-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 223 ++++++++++++++++++++++-----------------
 1 file changed, 124 insertions(+), 99 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c619df880c72..652742db0396 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -194,8 +194,6 @@ struct ublk_device {
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
-
-	struct work_struct	nosrv_work;
 };
 
 /* header of ublk_params */
@@ -204,7 +202,10 @@ struct ublk_params_header {
 	__u32	types;
 };
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
+
+static void ublk_stop_dev_unlocked(struct ublk_device *ub);
+static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
+static void __ublk_quiesce_dev(struct ublk_device *ub);
 
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
@@ -1306,8 +1307,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	unsigned int nr_inflight = 0;
-	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
 		if (!ubq->timeout) {
@@ -1318,26 +1317,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
-	if (!ubq_daemon_is_dying(ubq))
-		return BLK_EH_RESET_TIMER;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
-			nr_inflight++;
-	}
-
-	/* cancelable uring_cmd can't help us if all commands are in-flight */
-	if (nr_inflight == ubq->q_depth) {
-		struct ublk_device *ub = ubq->dev;
-
-		if (ublk_abort_requests(ub, ubq)) {
-			schedule_work(&ub->nosrv_work);
-		}
-		return BLK_EH_DONE;
-	}
-
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -1495,13 +1474,105 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	ub->nr_privileged_daemon = 0;
 }
 
+static struct gendisk *ublk_get_disk(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+
+	spin_lock(&ub->lock);
+	disk = ub->ub_disk;
+	if (disk)
+		get_device(disk_to_dev(disk));
+	spin_unlock(&ub->lock);
+
+	return disk;
+}
+
+static void ublk_put_disk(struct gendisk *disk)
+{
+	if (disk)
+		put_device(disk_to_dev(disk));
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
+	struct gendisk *disk;
+	int i;
+
+	/*
+	 * disk isn't attached yet, either device isn't live, or it has
+	 * been removed already, so we needn't to do anything
+	 */
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		goto out;
+
+	/*
+	 * All uring_cmd are done now, so abort any request outstanding to
+	 * the ublk server
+	 *
+	 * This can be done in lockless way because ublk server has been
+	 * gone
+	 *
+	 * More importantly, we have to provide forward progress guarantee
+	 * without holding ub->mutex, otherwise control task grabbing
+	 * ub->mutex triggers deadlock
+	 *
+	 * All requests may be inflight, so ->canceling may not be set, set
+	 * it now.
+	 */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->canceling = true;
+		ublk_abort_queue(ub, ubq);
+	}
+	blk_mq_kick_requeue_list(disk->queue);
+
+	/*
+	 * All infligh requests have been completed or requeued and any new
+	 * request will be failed or requeued via `->canceling` now, so it is
+	 * fine to grab ub->mutex now.
+	 */
+	mutex_lock(&ub->mutex);
+
+	/* double check after grabbing lock */
+	if (!ub->ub_disk)
+		goto unlock;
+
+	/*
+	 * Transition the device to the nosrv state. What exactly this
+	 * means depends on the recovery flags
+	 */
+	blk_mq_quiesce_queue(disk->queue);
+	if (ublk_nosrv_should_stop_dev(ub)) {
+		/*
+		 * Allow any pending/future I/O to pass through quickly
+		 * with an error. This is needed because del_gendisk
+		 * waits for all pending I/O to complete
+		 */
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+			ublk_get_queue(ub, i)->force_abort = true;
+		blk_mq_unquiesce_queue(disk->queue);
+
+		ublk_stop_dev_unlocked(ub);
+	} else {
+		if (ublk_nosrv_dev_should_queue_io(ub)) {
+			__ublk_quiesce_dev(ub);
+		} else {
+			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+				ublk_get_queue(ub, i)->fail_io = true;
+		}
+		blk_mq_unquiesce_queue(disk->queue);
+	}
+unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_disk(disk);
 
 	/* all uring_cmd has been done now, reset device & ubq */
 	ublk_reset_ch_dev(ub);
-
+out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1597,37 +1668,22 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 }
 
 /* Must be called when queue is frozen */
-static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
+static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
 {
-	bool canceled;
-
 	spin_lock(&ubq->cancel_lock);
-	canceled = ubq->canceling;
-	if (!canceled)
+	if (!ubq->canceling)
 		ubq->canceling = true;
 	spin_unlock(&ubq->cancel_lock);
-
-	return canceled;
 }
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
+static void ublk_start_cancel(struct ublk_queue *ubq)
 {
-	bool was_canceled = ubq->canceling;
-	struct gendisk *disk;
-
-	if (was_canceled)
-		return false;
-
-	spin_lock(&ub->lock);
-	disk = ub->ub_disk;
-	if (disk)
-		get_device(disk_to_dev(disk));
-	spin_unlock(&ub->lock);
+	struct ublk_device *ub = ubq->dev;
+	struct gendisk *disk = ublk_get_disk(ub);
 
 	/* Our disk has been dead */
 	if (!disk)
-		return false;
-
+		return;
 	/*
 	 * Now we are serialized with ublk_queue_rq()
 	 *
@@ -1636,15 +1692,9 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 	 * touch completed uring_cmd
 	 */
 	blk_mq_quiesce_queue(disk->queue);
-	was_canceled = ublk_mark_queue_canceling(ubq);
-	if (!was_canceled) {
-		/* abort queue is for making forward progress */
-		ublk_abort_queue(ub, ubq);
-	}
+	ublk_mark_queue_canceling(ubq);
 	blk_mq_unquiesce_queue(disk->queue);
-	put_device(disk_to_dev(disk));
-
-	return !was_canceled;
+	ublk_put_disk(disk);
 }
 
 static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
@@ -1668,6 +1718,17 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
 /*
  * The ublk char device won't be closed when calling cancel fn, so both
  * ublk device and queue are guaranteed to be live
+ *
+ * Two-stage cancel:
+ *
+ * - make every active uring_cmd done in ->cancel_fn()
+ *
+ * - aborting inflight ublk IO requests in ublk char device release handler,
+ *   which depends on 1st stage because device can only be closed iff all
+ *   uring_cmd are done
+ *
+ * Do _not_ try to acquire ub->mutex before all inflight requests are
+ * aborted, otherwise deadlock may be caused.
  */
 static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
@@ -1675,8 +1736,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_device *ub;
-	bool need_schedule;
 	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
@@ -1689,16 +1748,12 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
 		return;
 
-	ub = ubq->dev;
-	need_schedule = ublk_abort_requests(ub, ubq);
+	if (!ubq->canceling)
+		ublk_start_cancel(ubq);
 
 	io = &ubq->ios[pdu->tag];
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, io, issue_flags);
-
-	if (need_schedule) {
-		schedule_work(&ub->nosrv_work);
-	}
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1757,13 +1812,11 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
 	/* mark every queue as canceling */
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_get_queue(ub, i)->canceling = true;
 	ublk_wait_tagset_rqs_idle(ub);
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 }
 
 static void ublk_force_abort_dev(struct ublk_device *ub)
@@ -1800,50 +1853,25 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
 	return disk;
 }
 
-static void ublk_stop_dev(struct ublk_device *ub)
+static void ublk_stop_dev_unlocked(struct ublk_device *ub)
+	__must_hold(&ub->mutex)
 {
 	struct gendisk *disk;
 
-	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
-		goto unlock;
+		return;
+
 	if (ublk_nosrv_dev_should_queue_io(ub))
 		ublk_force_abort_dev(ub);
 	del_gendisk(ub->ub_disk);
 	disk = ublk_detach_disk(ub);
 	put_disk(disk);
- unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_cancel_dev(ub);
 }
 
-static void ublk_nosrv_work(struct work_struct *work)
+static void ublk_stop_dev(struct ublk_device *ub)
 {
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, nosrv_work);
-	int i;
-
-	if (ublk_nosrv_should_stop_dev(ub)) {
-		ublk_stop_dev(ub);
-		return;
-	}
-
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-		goto unlock;
-
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		__ublk_quiesce_dev(ub);
-	} else {
-		blk_mq_quiesce_queue(ub->ub_disk->queue);
-		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = true;
-		}
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	}
-
- unlock:
+	ublk_stop_dev_unlocked(ub);
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
 }
@@ -2419,7 +2447,6 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	ublk_put_device(ub);
 	ublks_added--;
@@ -2693,7 +2720,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2828,7 +2854,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	return 0;
 }
 
-- 
2.43.0


