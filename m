Return-Path: <stable+bounces-142017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB6AAADBC7
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA071B6818A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79399156F5E;
	Wed,  7 May 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g1k0YoXV"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80572612
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611237; cv=fail; b=Ea0L9AxIbBxmA26AHJcNlzeYGiqgNDT33+pbj+e6LznkUwwFQ/ISpUYIPG4rzcukuIE3njix15scKpsBUe4DTZV8d39PF567sKyBm6H2lLDt+L33s5bGnYBbrZNxkt2iAIBUYpweCoJF0xwsUjbvjoYzGVybb0rORLeUaFjGv7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611237; c=relaxed/simple;
	bh=Agog5KyjtbssmijT404q/ZulrT9Yq1yVJuuz9U6dfQs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SJOo4svzQC5Q/egoPh8RGG4PAGv0CEAICXkxPmZXzvCAEYqfVSE8pcHSoMa7L66PisanCoeUZho7ykhyryJGB2Dkslc03VxtTb2nLEO7YsbXR9+LWmKA7QVKD4iVEMDKddgLtxHAZMXfQEFhN8cztKVZ90tPjAlqZxxqwnGVCXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g1k0YoXV; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhurV+m5BIUAT+L3CLsatuCYrCU2oJ09hfQm09NyQOVkIzPbKlq2MfjE56Fb15g5qa3Ew88FQ+TSOn6x0Q1pw88vHQrKGvXmdSFC5I/xOqkpVdkGHgXbzptZhl/qXQ0DWMXXzPAIMee/wLvRcxXSjgSa5OOUU+r9lIvToD4iPqFNIAlmrvHqBkRYhjTweQSie5jr8zYwnT3pxWc4hzRPYhP1vwaPbCUJv57gtKSOSskU/x3hf3Dc7FqA/U2v8Ej8JBq2xfmB1Y68uzBS9jPcYQY+7VbwtncFpB/uOjmz5K2CWS2s9YyFLriqc+zdqG1SSo3tTPR3o5XbmLGwDGmkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKDGuOIWfF5SRLNf9mKFh2d9NQztY+aFTmMFHU9gMbs=;
 b=PToG6g9+5b9+a1IKEJMkZNR4gdw413GRmaZtaJXzEKzU6/u3oPWUDOQCHyZ9SHsy78IyLOagq007nA80SlYXk3F5fAWeIQ1W65rAlkGWg2ABSuwpt5lQ/wSlhdCQj2+WvfFwGjdKQYsyT55+2CWBewFxmGUvSFuNRsTGB/sw0L/evc/n/kv2uULumzyaW8j52W3Wok84IrJJIK5KT3LY+wT2H/cSqCMhLzEhCY1AD3DYhLuLHTqFYwpE2AQXUDAdB8NjDRnWRHrbzIUdlPwIYs5W8UeBx8mTmtc5l/rKMU0VvfMWMVh1n6nAooV6AZvKiFHywU2xL0Vpzf+Ez1F5uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKDGuOIWfF5SRLNf9mKFh2d9NQztY+aFTmMFHU9gMbs=;
 b=g1k0YoXVXhGSd/Qg+Mixje7gaM29yQnKNUcb88BNnPniOY4Pm3k/vdXp8Q9cYNAIVjsurPR4uAShx3wVErBr1EtGOVOtbxFXDeeEiME2e82CiRi8cw2IZzZMCPBQmlPOXkYKlMHxMR7SVrm+xX0m1sclyGAIIbdveM0/t4Y48lAzb6dryT1Ab2O1fVk27Imd7JUmqsWWBJXRcX2v2yaWknI7Yfy7inT8pwXs/bpr85NJbSHsCRc/6V8iLVHEet8/QxooXexgWwDUtGJ8t39KoNZOzVug5PqN3da5xcKp3kAsl4nLU7uRc040Qa/dLzH0Af47jjCSJ0oj5O3aod6nhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 09:47:07 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 09:47:07 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH 6.14.y v2 0/7] ublk: fix race between io_uring_cmd_complete_in_task and ublk_cancel_cmd
Date: Wed,  7 May 2025 12:46:55 +0300
Message-ID: <20250507094702.73459-1-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::11) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: e685e580-0691-4ae8-8b72-08dd8d4c210b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+pYj+DVX7m/0RjJ6yx6cD7Cr0z/9mdREPOARrv5toy1i7gM5iMKOTRRzvWWu?=
 =?us-ascii?Q?UzkgCOlXCjkI9y5tqBsShI8jZxlUZ7l1gk0ulHrugNMmMAXe9JNv4vpXk2Bs?=
 =?us-ascii?Q?/f/oldbF5tv/hwqkawyIYFN0wKTj0EpHPQjOul0Wmz9hRElVA9CEzsKIITrS?=
 =?us-ascii?Q?0kWIdipT7ms9n4tGJI0BT83DKlbgy7Mm5sDi4C9K5aglIVHpKydl02XygPtB?=
 =?us-ascii?Q?Y2x9Ud6p0GV/qMshCdZ6V0euDLWfWJk2J/TZI8wciBGcG/o9nkPODv+xVoGX?=
 =?us-ascii?Q?ZM7++Ja1SZT6Q7OJp9Kad9LfGlEWjWmNjKRYWA+o7229p4eappddZ9Wd8Zzp?=
 =?us-ascii?Q?KU7fJtPFsJgdnnXDYi8zH/7nPqBnniP9+bxSkzzWy1dxL9IJrWHtH18QUQFY?=
 =?us-ascii?Q?gNsoQi7AZk20+sdeCGztx3i5uXwBnPLsToBUIz34w/XJiIT+Dl3T8sVsXteS?=
 =?us-ascii?Q?NIkPDj6n32pQBIJaf6RCHtMxH8yFnH7T67XaZFtJ86zSQUc27lLVvTz+DLe9?=
 =?us-ascii?Q?cW3lQwQYoIW14sZRPdXPKvjU3HfbLPB6gcpyyPlfDXmKt9wT+IeWZPbbafHZ?=
 =?us-ascii?Q?7UDKHGGBO804EndGvcCrnyWwk/jsmyxdrAHpBzmdQJuDRPMVc2YHQ6faRa6K?=
 =?us-ascii?Q?HXCxoL1X0oJ4yyehX1FjlXEeOs9mxCuh4tcIdxfYIjuJ+7MH18r85vQE6gjE?=
 =?us-ascii?Q?5mNejbuE0R+HV5oTs1Xt5efKXC1Y0FXlsF3UWtloB59yMz83CVuOvc2hGvaE?=
 =?us-ascii?Q?42a3am2TLz0Ar9PXAfVVIGLc8H8Wva0EKdAzOvAAhSz3/g5yX05tsB0xPhGX?=
 =?us-ascii?Q?7LkTd2uvKYmKS6Mfuqz2W/2KKP4qtdp250m/zOrAKByzAw0sXtsfgMN0UqTR?=
 =?us-ascii?Q?lMfZi/8f/dDDGnryFDDMKDxYBkcBrpnqOkBUt6183+sumZu04xmIvk2CSWU+?=
 =?us-ascii?Q?LZtihMyirdhBG67IxPAcuLtta7E5pohNSU2V7BQII1FmRSUO1R6uFno0K7WS?=
 =?us-ascii?Q?gUKmrsDJo0/8uRL/ZHwAkBaH93TOH8GqHz3CIqAXENPp+ROXpitXhmsr7Z88?=
 =?us-ascii?Q?m2jJK49McZWduX8YlxYqrUwRT3NpirxoLD+l3MOmK8U9hnGS79g+zK9ovgcq?=
 =?us-ascii?Q?R4NwH29sKpZgjYmDhJWtKNrvDSVCvf2Y1c4GoezEOi7XpmcM0tD1ad55ZZ/U?=
 =?us-ascii?Q?+6z97ByX2Ov30qH0w7i77QUXPfItqGyx+lCwhPniEO/jWAimKOBI3zXN06AL?=
 =?us-ascii?Q?+/2rL8qMN1iCACu7fitoJwmr+BVtrzByhzvHw8o22roV5m6BUBrmbv5VxkWx?=
 =?us-ascii?Q?5mFhuYY2jH62aM5mZpRMjSuqZGELwli3nCesm4cp2KyYz1KUuNV8BDxx9fX5?=
 =?us-ascii?Q?9hmyqg6VaML2r4vp7mAdV1YFuZDt0/L4VVDR06CRBGoFRfC/JvK/8wtTtOeo?=
 =?us-ascii?Q?Rvsx/otEvRw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nJzrG6PAazNSIaNhxo8nCe22KVYI5f8HaXnGeEetCOg6hB9EXC78fwxivrZY?=
 =?us-ascii?Q?Huf5uHGw2v5iO7X1x6I0yM/IzRUfJYbKaIJsQmELYmeSJVkwtc9p+LFGYYrn?=
 =?us-ascii?Q?mTOTiBUamJxz70xuqP5iAm3dX8sHfMTMKC22LMndM+6FsAy/lYvdNbg4RR4G?=
 =?us-ascii?Q?HM4eFk7qNpd3KtqdGcPHuH1BjCLuqoJkOZR8x3K5UhzCFNlj1M061M52KuQo?=
 =?us-ascii?Q?IAgW+utPlLvkk0DKo7ESJEK08Bu2yocjA3Pi7IpUZ435ee8jZInZYnA2nRGP?=
 =?us-ascii?Q?RdgBriMkv9d6SwQFHa6b3RWxMsrS6D0OMGz4kTHXK4qRU368+yUSJ9nvjIS9?=
 =?us-ascii?Q?iQik65JpLzWx/ShX+LuSSRsZhZwf2vc1719z2PkggjcRKlrhyfS2dn+lg0CA?=
 =?us-ascii?Q?ye6pbIqtOAHyyhGE7aK6vgEfyhVp2txYk4svB3Z14kT+hlgazhUVz2c9fwwk?=
 =?us-ascii?Q?HAsRtBgWbwd1FLH/4mDaWc9WMvXb5S4PvQbUANt3+IKqWafJOVosdiPsWaxQ?=
 =?us-ascii?Q?C4l45gaX5cmQqQllSvn614SkN7kK0SaNhn16S4YP7d7AK257e6wFOURbgIJG?=
 =?us-ascii?Q?TZoIdpL0TE0loWJZpcfeI5y7MxPlS/GpCRyJ1RwzXM4/2BhsFCrkUid/P9hH?=
 =?us-ascii?Q?PekZX6RFJLZ4v5ANQyKN0KwBkTRHGYcp9ViPPNuzrZte9oVzdTwgOzZSK6RE?=
 =?us-ascii?Q?RRiEE+KO/Efy5c9+SfrhhdF4X0LgnNcxu5f8Gxkui7JL+8g+/hgd8QsQC6HH?=
 =?us-ascii?Q?R4Y4M4o4KdCd01hvtzvBuG8LuugzOjjifHBHjJ1sRyOJxHf8LP/Zc4Q5JlIy?=
 =?us-ascii?Q?PsL+l4hFkZ2Pwu9PWmD4tjPjv8IEvJdTe7Poa1zWGuMMqQkcEDDk5pCozrYJ?=
 =?us-ascii?Q?qxgePgFpEhR8Z3lMH0U6i/WDxdN41MqhPrimvk913yZvc1d4wc4ibyWx+C86?=
 =?us-ascii?Q?ULKIzCcbNpyGPt+SwSgu0MtiWNiVQhvUF607ndGYpf/iwUQyhUIcM0xIYJ5t?=
 =?us-ascii?Q?GYmM+rZyXk7FmRRObJclma9U+qbxBTcQHZhcAQWVDGEmDFpDFimQHAS/bDvi?=
 =?us-ascii?Q?GQa7IePvndIEB1N4MG/pmdbia3JTLRFOVc9CLPdQ0L9MGVmyGkgoHnP9iuzG?=
 =?us-ascii?Q?fY2BZ/AwuvosQPTi+ensFdD34bcn3NU5XeNCvIGDIAEnHQCfTujUH8mXW7i9?=
 =?us-ascii?Q?TLYLrAy5gKZv+GmJuriB/Ei0RToHLtcOECtJkPp/PXJBpyWhcB8+a6vRu+jh?=
 =?us-ascii?Q?rk1hOk4dDMXXbxl1l/QkPQBHYQC51MnAZdeioKMIiDwzbbFjAfuYFAf9Dh13?=
 =?us-ascii?Q?rW657hd+NMeRUUbXsN5QjGgZcdVj/9jY9sIUMbee/eSFC0hE/AQKhO1oUIYF?=
 =?us-ascii?Q?CrwnHwUVIMmWBj5ACRkxV2ZyRD4BGTXQO4ZiDOpIXyux+blRHp6e7NTZTmNK?=
 =?us-ascii?Q?hN8EbpHJ2rmrzSZA+iMeg1adPreY733RfyUVmgH4dKBedWR+8nKai3htpJqa?=
 =?us-ascii?Q?zz8RWdyRdRWFDsM/sVr6MOKBagD6aZv9pWKfZn5IrjCGIu9Z6ntCUsXKQSXc?=
 =?us-ascii?Q?A0TeWaXMSAA9v/h9/RibATNP3yrb6FFPThLIsKmx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e685e580-0691-4ae8-8b72-08dd8d4c210b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:47:06.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkMmVYOY3FDK062JK3OVkyME5ucqL9poOqiWUQE0UaBCn2pzWevYmKkn4L5BXx5qqUOa7X5asuve8xV8w5NxBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

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


