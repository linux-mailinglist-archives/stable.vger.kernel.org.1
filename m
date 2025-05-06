Return-Path: <stable+bounces-141949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B3AAD199
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 01:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0044F1B65E43
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 23:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1AE21CA13;
	Tue,  6 May 2025 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iA98aQ/y"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9A7263F
	for <stable@vger.kernel.org>; Tue,  6 May 2025 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746574710; cv=fail; b=jz3qSL2oN9aiSYkr5yJGJ52U1+qk4y7D/ieUp2RgKfi64w9iVebG02yrUXQf1+mV3bs2DxlQ0DyskqL0KPeYgWjtrTfFbmub2y187Etz7rprB94ZoSa06EWbIBfHSZUgm+9O54tLnIHN6W5q+XRZawrcoXZO3nMjqHR08AaOTzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746574710; c=relaxed/simple;
	bh=UqjfoefFyDy5Ztimu6wySHzggLFNIUc/+TXcHmCPPHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHzLPlpDUOYN2I5Zd2ItIyumuoVk/Jy70pMhhjCXoa7i7HWpKi2qYx5gz8ZuPSArDPvZBUUDh82lWYFr2kTZ/Nfr6UROCC/MfqmfLb9E4I5f+e+VLk7cmHoQPbci2YTbjuDfV5rYVmJWbH6h9pyGSVfV4VkMH6PoU1JLA8guMG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iA98aQ/y; arc=fail smtp.client-ip=40.107.95.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOMVJttNugf27WnbiJSTriLkI5OJ4hFBhRXqDPQKilM1mcQz4j/fA2LBXU5q5GjS62MwfS4woqOBXB4cQul4Jwu9BMIu0Rg/C7/Wk+Pn8fLAEnp6ybybATVmrGdDUNb1Z/HUB9KOtJrzBh4zANp77NWB6jJJnbRwsKgGFEMQln70UoA/MpDmi5P5I0CaxzGyeeN37NjCwPnkWRaQ7uCytka0Rkbm3sWnwT8Map2UQK57hsEUPBFx33z1bDkipWsj8Yjq10nxGq+na6D7ytwD1iT3mfNoNz3v3XTE/0Q/NefbhdSyLRKQOwsEplV2/VbLj+oXckB/GXVxdWM9QF1Fzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScogIvvgUMDTLWnmheijnerrsZs+6rqgX/lUIHP72H0=;
 b=QCj4Tjyr9BfJzgCfMBZoUu2NJUB1GdzAI71Y4Z71BvEN1owhh/B8qID9/aFpPBJ2gEjhgdiELbnm+XhQfMB/+6Htg0/U5d3GeP18Or3qAT7DEXkMysytSpGjGJbYlqyALs7q6JAciok2u0UPNV/dkm2Kk0tVChLB3rElXow7Rj6cS4oChAiguHHXEElWZHJVNsohsx3Jbdh7I8q6ozHeoPbPAAmDz71VMWyE0+01wKKwInPCpohQFu7T5qgBN10MdjPXVVsCOb6C6EYcEuGKX9gehQ6B3hlm2oTaIeBRKX9jfCc6y2f0lSPWE5vZCwsqH6pbl5yYh+sM4siSAEkBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScogIvvgUMDTLWnmheijnerrsZs+6rqgX/lUIHP72H0=;
 b=iA98aQ/ylHW/D/I3gUlW7n63egGI+e0basLhwIsWqBqe6Gn3W8AVxAjTNPu+bmW+xNIrO/26OMDdPmpx5zdutjzONnqyyLTGYE2nCzYj4aD1+zFmT4W1ypKBOPijDO9MwJZSJrFdLCF12Vo5/BejKpP72CiwpHDIvGN225cdtZ5oCupV2GgTTtVbES0xUAs8wpqYu1QivoMjyzdy5i24ofDfoNL7zSZnJbeP8drJ8g1DVNcWEAMvKmT6/9JHu/XtgwBziuyVIqpIqJYXV2Zl/Lrd11Qygn+4pTqqZA1AJvxnRpIZbLZecCAp9E3GvAZ8CG5wiYHv8JUIpT9srlcMDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 23:38:20 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 23:38:19 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH v1 4/7] ublk: improve detection and handling of ublk server exit
Date: Wed,  7 May 2025 02:37:52 +0300
Message-ID: <20250506233755.4146156-5-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506233755.4146156-1-jholzman@nvidia.com>
References: <20250506233755.4146156-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: eeabbffa-787a-44ba-16e3-08dd8cf714d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yx067yJ9GEAcxHOHxorj+K5QvF+m99d/aNAlBNIoYClH1JYMOV40zqQDFp/2?=
 =?us-ascii?Q?KtysbgAnx4WVTe/lKLxVNk9fIA9J7iFFYC83Mf1jPIc10MP/yuLvP/hqgY7C?=
 =?us-ascii?Q?ZOhHQXD9HY1Nqef6Y+bQk4SBvO7kN7b/9ypb1/VvLbcH8HlyrKy1YElQj/oQ?=
 =?us-ascii?Q?uQPs2j0qtBt9e8ZeVLro1/ZgrKis8uq+8Oc8UOWcw8upo4LdzQB9mqKLwTR+?=
 =?us-ascii?Q?zbepyZFaFvCVkdg9PloMtlf9UEvohznAM8cZ0ACN6zd96QQUi3FKw3N0Va8q?=
 =?us-ascii?Q?dNgLzM7zWqAf6Z0aezP5ynl9+6HAGU+gOWBZrN0GkfAk8f3DnXJbS/6TTp56?=
 =?us-ascii?Q?yQaYkzYuWvXBEXEI30g5CWPex+1x2W+F71vQub5yteqDn1s6a6BD+Y01wU7y?=
 =?us-ascii?Q?w+XjDjbfRvPeh9fkKO0GWZYcA3V4TnHcTSZkGYjf9lvv3+ddVQ3/w9TqrejD?=
 =?us-ascii?Q?5rgDx1emFEqy/0ED0ECNwPbmHEb4zmf6M7XSlucEL++/k6zJC/R7NSydsnyc?=
 =?us-ascii?Q?e01xpZIA1ba2TYOQ4Soop5LOWPhyxr7uYuvZh9RnZuPMXoGYy3mqNRjx1gnl?=
 =?us-ascii?Q?Um+rLGh7HWcuWHZuG9Jhx2+cDv+nr5At/dBM4GDMFFY+kzx5zKMb8b+ffUy4?=
 =?us-ascii?Q?4hNOqt1WLWrp7C0SGI9A2yz1zW7WYHJbqS/TCon/PBhlk98VXUqF/XWn5iNH?=
 =?us-ascii?Q?vbyvOKAK7bROu1n+x5/Ba/AJUOoGuNgHWcrobRT/fF8DImY/4e7Ngy0hReR3?=
 =?us-ascii?Q?o6pOfroAmSnYzManQOc3XuhbBhszMeZz7SUBYPXty1iFqxWKaDPUdypSeKcT?=
 =?us-ascii?Q?jIOcRzQtpP7nlHU03ufIuuwlcC7VBdHdKKDdlcOcPSv9WwLAIvDGshqZmfA6?=
 =?us-ascii?Q?ZVMUuE8gL328gwYCuRohAXcHUNrPYapx794LsqJRLpqyLyB6muAuePTz+0Il?=
 =?us-ascii?Q?+jLCmFQjmgGjgeQ96CyYiypBw1AuOBNzZV28Hso9676QHHqngYc7rBRSp1pg?=
 =?us-ascii?Q?K58Lb3NFE5Gdd0gO+ZKkh28DD/WtF1FXErMRdfdpd0zULlopUZqf/Ppb3SLN?=
 =?us-ascii?Q?BxkQE60O9bcs8AHiiOn75mDJF9zg+2zkgbtbNX1blUvdoupRpVAryePg1zGj?=
 =?us-ascii?Q?a3e9wzm8g2pNB9ICbfXeDKir79tc6+JpxswzHCdLwrrBrCHIewVVsNCUBRlD?=
 =?us-ascii?Q?D+WLgs2+oU+smmuV2JnSfeF19jZh1/BTIjzBv52EDruir+PfqfrE1QNrggvB?=
 =?us-ascii?Q?W/+u+N6/+AUHXdGczG1wE6NKPSYk8lgK92wK9ruylxtpUvDoRRnQWx6Z3Eox?=
 =?us-ascii?Q?9iztI66gN6naytdn1wAc6TJrqD6YGZS2qXgaBp9usSK6I/47fmshPckNpLGr?=
 =?us-ascii?Q?g7xAhrjSFauqwj0/e9XAobdynsHD4QpmbzyxCWCfxDs2xTkwZc6j6tnmXLK4?=
 =?us-ascii?Q?kszQD5/v8fA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zpHnaRNS7mUrawtMLrXNt8elyi9Vet68ZIdzFcvGJdO2TKKyIY0jfcqXwWhR?=
 =?us-ascii?Q?gtSaojxAe6qoG+3BhGAuhptnk1b8+ejVWIX3e5TMwrQf1FfM+4cdylU6FZ7m?=
 =?us-ascii?Q?FJN8w4nmF/mINbp2Bwc16Ax3QxLzci0lpfJRzkRUEs+6fu+V8zjh96qVGzTA?=
 =?us-ascii?Q?AqCeHOYEgNPB5bfyRj4maf4F9SUYZp9U3ub6uacKUP+Qr3QBSYpDDJcowSYh?=
 =?us-ascii?Q?XAD88lPJ1XvptxPaG7qA13UJ7RIIYEUYdd8g5DxvLVREHvZoBR6wwOVYAm1k?=
 =?us-ascii?Q?2/Mw9HbmPiu+k+SHqN6a5wWsHlNUrZ14/iqmIWPWWIFRJ//Su4J8/eHFuumk?=
 =?us-ascii?Q?1ZbXYbJPuOikrTrgfFXjAZTO+eSGAPI0Tvi8BMNDFV1DhuIbbHteblV6sbDv?=
 =?us-ascii?Q?/tzafRseGGbbGVDXinbKjzmqDPxRQjT1b1eyNMPEUcDT0Nx7qXy9nxZcg+/T?=
 =?us-ascii?Q?v3xUq3rlFqYmq/G4t0SrM8fc1XlWDPm4gltXKshxvtlhSswKyfFGXOzQG3Jq?=
 =?us-ascii?Q?MtiRgqTzbOAH+EHwsCzMW75MJsKDh3etwHuiyEtYB7JTVxWYSVawWOlE1hQf?=
 =?us-ascii?Q?YRInvEl1Bt8WfNE8diLSef0CArMzT43NqXYPNp2YtKZfEDmIZW2iZlIaquGB?=
 =?us-ascii?Q?I6x0UazQhY7eWnEh1xHpmIQiRgz24HeU+km3S6QDDNRaZuILiRFIx5T3QDFB?=
 =?us-ascii?Q?uUPL9FWd/uVlOYWLLK9mn6kJ/VLaboK1XK7D7mlCviYNT0Rk/Z1M2K7o/+7t?=
 =?us-ascii?Q?gzExS4RVxAM+iDx/uO7aQiiglgUK+wj8NHkFyLFCbrvveKGfxD2wHPGoGlx9?=
 =?us-ascii?Q?fu4X2yNrEs9I42gCLH9GegTUOhTxhq9frkI6vE9AQcJrH3coDC6iV6tdtyNN?=
 =?us-ascii?Q?9QO1eMrrmFUx1EdvJLh3J8rr+T8eCjdD/gfgUEWCvIBzklgOGhJhjHkpYmVO?=
 =?us-ascii?Q?QcXUwPRTfIUS0wpkrF3acTVieHIepztz9SDMBcyAFveO0gXmU0JEt1ytCC44?=
 =?us-ascii?Q?QYxA3obrrqMC3wcVeouigr3waQ7WRG0HNhfWv5sh8wELb6xxdXDxvlaEjaQa?=
 =?us-ascii?Q?T7f6uBJQNDGw85qCp9jToR4VOgXftbHfW6Cmq2nogPfONWM7GziN9oOeEl2m?=
 =?us-ascii?Q?9aXizY/h/tQin+UvSs+c/BoTMT1O3rEI7N+//kP+mH1dOnDuZWZtJDQBo/vA?=
 =?us-ascii?Q?ucWPXU3PxVGM6IE9aRckraK48h7Tnq4j8GwRsiZAKfg10uuLxEkBPnhoknKz?=
 =?us-ascii?Q?uWZmABVeKXgWunkwDVB13C/HW7wvTRSISjtpiyOCbBUYRqdE6ftgvQBZZww+?=
 =?us-ascii?Q?GT1CuVLq1zc31yyEP7p3+GZEd15qEmM2fNvVAFVTQhsIn56J0U26jq9pPW8A?=
 =?us-ascii?Q?yHGZ7fCVLxsw1n8b4vYKqmhsD/GZ1QtJ7XeM2uCWL9zWuoy27Exw2yYQERMi?=
 =?us-ascii?Q?wuVIYNTUy3DP4+b/wuM2sSKCy8ejsMCxJKRd4JFI4tNVrSRI0rGfNrFFtvWi?=
 =?us-ascii?Q?87DQXZfg9YUYheFCyi6xT6SdZ/3DeTbJooNbMT2sbohL+Fc3WaXUbrKKmgtt?=
 =?us-ascii?Q?CFSBm3t1osynMO/rovGjHCvHnrNPyqBTX+g2lFeQ3yu9hviZvxcAkHHv1hch?=
 =?us-ascii?Q?GbxwY1gYetDBunpYH1LvpPwwuCkMV7F+tVR8Hd2M4uHd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeabbffa-787a-44ba-16e3-08dd8cf714d0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 23:38:19.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIOGRyMjNYK8OtKQhFWL1ghYLbYdk/7cpSm3G2gqyboh+6FJFABiPlMeKoxxqVi7T1pwrZnSvGGzIhVW9XLfRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399

From: Uday Shankar <ushankar@purestorage.com>

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


