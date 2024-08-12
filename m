Return-Path: <stable+bounces-67373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641894F66E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4E41F23AAD
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CC218C341;
	Mon, 12 Aug 2024 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Gll6RLED"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020142.outbound.protection.outlook.com [52.101.61.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97381189BB8;
	Mon, 12 Aug 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486382; cv=fail; b=tsbbJa25IuAeBNlLv7Fl54SEjmmt8zVu2hYxxl1L5h1zgKPKF+L9L/yx3PH+NjcmMwcr+YsZydTaUrA69vZbWzJtAnD0kB412BIOQd4if08wVSP5OvDzCcsdCnZplm1S8qXP2ie5/fPX6eIY0722/Zcm81vPrUzJwvp7uTjVybU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486382; c=relaxed/simple;
	bh=BFfvdApXv3FTYuJS4/kQM4o5ZpNHKnq5BGYQhi6gE3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvcHq2pLnnVOAz0K8DkTj1u+nRPOxLLk7v+tRqrcdwfKMURbyokWnvxMzfujYxW1fq1otEOSmnT2tFH9RRu0DI+XA+uWGfVGyDq+O3g4MNAuXvoiI8i1LE1sH69qZLEJCWNbab7Z/DhRSGSnrk0OPliLusBsKeyi5QI+vZG0MiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Gll6RLED; arc=fail smtp.client-ip=52.101.61.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7cVgQe7ADDu+84LcywpA7/FX2f+ESfi2XQ6CZf58tXZGnjN/gw55MX0nnzZua9TUSwjWtV8WmwJIQVzruz8TNIrubmW/mA+mE+4mCQ3h5MuqzM/2Hp64+i7m6qbmu85M1Q1PbUutWdMCSdk+bM4hAgWol3pm27yc0byQjVubH/btlFiHSLG0oALq/bgiMAHN+AC83Wse5xIJx/imiP6PSm6mZxSScca1IMrKTa0zLosTKKSVHtW6KOm0/iwHw6Gifm52guHKEp4wkuBSQw5YXE0ygUaptYJ9VoIskId8yq+JYcLS9lWu0qzp9ytk2oKHG2Uqssbbl3q6JA1QUBPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPEms8Z1bDgizvpacUeELzkgZKoWowBQ2X13hk/icH8=;
 b=vdO03+04RYAHcMCaBFE76ePwL5Q3S0ycD3BGHs9WIJQhnmD4Dz5Sz1fYAcWynysP9I0YwsbxdZItCrE++Sl60f4PhdxKoSA619b8zmQLKOB53xh2SWYA+a+mN70DHYAs42UVfPib5Yu6SWPzMqSzeqw36ImYBgUx48INR9NtnyaFmZeEZPMgJEyoylc0/0v860pIL3lM2THlAHO6/4sZotp/NSJRxQ3e8L/CwaMdgkUX2DzP70xVA7/KKGaKnc1TUMUhryQ2/mc/NSTghysAuVcRCfFDjG4IkarRzNVoijLzzXytK6O/KNlVNklMNQV4xhHHMMHdBfr7TR1Wdmzhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPEms8Z1bDgizvpacUeELzkgZKoWowBQ2X13hk/icH8=;
 b=Gll6RLEDSPVMITGkGJNGLFw6zfgQ4HIcJHvsDoECURvXZMHgFJybk7Vv5TqxHG00d3Tu5Jqz0GPd7LIJm1FePlaZcOh8F0AYkveLIfN0eEToTQfJ6Eg6eabGIpzBQJnj7SuEjNcxrSkFrABs3/jIBW46T1hrrnbHU1dcnzZ+btY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BN0PR01MB7133.prod.exchangelabs.com (2603:10b6:408:150::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Mon, 12 Aug 2024 18:12:56 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 18:12:56 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	yangge1116@126.com,
	hch@infradead.org,
	david@redhat.com,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v2 v6.9-stable PATCH] mm: gup: stop abusing try_grab_folio
Date: Mon, 12 Aug 2024 11:12:38 -0700
Message-ID: <20240812181238.1882310-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240812181238.1882310-1-yang@os.amperecomputing.com>
References: <20240812181238.1882310-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0360.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::35) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BN0PR01MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 0082da78-1345-48a3-b1c0-08dcbafa6417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wxx8SNLZ86bWj+seBjTiiDbMUNxnP+6hOT02iAc2XcwUiscv3HWioRAJ3TAI?=
 =?us-ascii?Q?wWQCdw6eo3IqcGhQO0fkkNusNwK4X0k9oDUWVoKh47+kv6JbF+m5/MUmGbqS?=
 =?us-ascii?Q?bMMKdF6P7U/hwYNKUUmfPREH0uNbpdtgwSO7Lf8B/w+yw/QmLUget9Lxa220?=
 =?us-ascii?Q?5o2R5UU5wv/isFLcpBy7pungqaPUvQNsvuucnTIGr7Ft3BJYh0JOBPWmkGXk?=
 =?us-ascii?Q?yfCDpUdLpqr+gT8xslbs14pUByP9tH5i960NFX3zcrLsSzDXvoZkZiDc8ZH5?=
 =?us-ascii?Q?YiMO+Ys4ab4a0cMTblpNfSs0loACpg3KEVf6y3f8n75Vs/PpsAkGWDTKVtx9?=
 =?us-ascii?Q?1W6f5tHM75im4r8QsJjRPwzpw4CQXUKfB+oIExq1yV5iW3li4oXKgmCRd74B?=
 =?us-ascii?Q?tJ5FhQzJP3v255sMGgWaPxQr6nMe9hQsI5bJ5HcBD5tEAf7hP1Seg+4h9AXB?=
 =?us-ascii?Q?RG0IO4keztkNcOAUO+JVdReTfMeYgO1MkD6SpEquxmsLZ2NvY6VrLhwGkUMx?=
 =?us-ascii?Q?BkaCevNN+UQnqBDy/XvRyo9WLC/A3Q3Qgr7grbyXdzmhNI9PYRcP6+7LAdFm?=
 =?us-ascii?Q?ikaDZLbdD3ZA0kredNcBsFIN3M3PBb1IocwibTmHdRB+Vc/VRqLeh738Sy9J?=
 =?us-ascii?Q?c93SBTzVGXsIQbW4ENh29/joVnNRFimlPqge4SxCxbiEVQ8YzraeJK1BUS6i?=
 =?us-ascii?Q?KfQODH4+n8p7t5RV1eVNP0Gd31+YlPdKs8np7PmJIkxzCeqUFlTe5EQZ3cCQ?=
 =?us-ascii?Q?RXevXIEwuX7D2DeWvQpktnkiV8LZWwImBThb2MlcbnMGCW9BHwVaDM8jPTsT?=
 =?us-ascii?Q?9Kzx+y1CzwlWViTzeIsnwxx2ILSEYL4HrT6FwLHDhBzyPSJ3emsGRGaExCYL?=
 =?us-ascii?Q?H3akDaS4da7YoBwCYHCP/JDn2eDHHjOyXflKp2PJvAmt8XR7CmVsbbQVRv1U?=
 =?us-ascii?Q?wgRNNoxj2YpDniG8/7qMAoUk+A6osJMEa2EgTVcBNjcO3JIX3LI36SpUknCh?=
 =?us-ascii?Q?Dkp3t02HO++y4QyWDageiWxLmrr0zPz4U/JczTmnsn42korOT+mEZx9EcFF1?=
 =?us-ascii?Q?7rm7N1OPz0Uh6jua8fuSOwYL5YCLtR091P0PQePnUXiH8VdTjxHbfxhgb26x?=
 =?us-ascii?Q?XOQDjgN54AWaeGRVMcoTGMawJGThQrjICL8MtnQNtkriPJo+cgmp8cyvm2jx?=
 =?us-ascii?Q?siaHZuszW7j/ef5v0l4q0Pk1JUUxMAy5j6m+hNlbGJ3mOKWCJEvUnkD1+J5e?=
 =?us-ascii?Q?/NdKHNcxGUbXiEdVm8HdnRCVPVspqeJVhURpiOGcztDyLkmEvm+uQGVVuXB7?=
 =?us-ascii?Q?BKp5CMfTE+YTGGvFEhMVo+swzdO1DHKBPwCM09wFXy3b83cckfPnFTe2KkZX?=
 =?us-ascii?Q?Y086W1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Sbq42EpzxBamHzgej8TaKGIgrqowlhJdc6HJfh7mfImHuP1wfoLGQ405Wrz?=
 =?us-ascii?Q?MzTPNYR2e2YWEWR+tZjY3KHHylOeKcilDl9ZYis6o3fVFdx31YrOKhftuNIi?=
 =?us-ascii?Q?pWZ7F7aU0LSEJVhlUeTbLB7eks2Ioclk0pKnMhCB68YKVSRJIiy02Pn13Rnp?=
 =?us-ascii?Q?c00AvMSEJSAoOw7xVH46NgMRjPwgk6igGVM/hpfSn+qmg+x8MdnfIKBGTtVE?=
 =?us-ascii?Q?Duco2jkRcc2kCpYYxkgqcevhxKM8/GCndpqLgM/IDfLdUWC7T5+yn+ilsnx3?=
 =?us-ascii?Q?rvd1bGypUYlE6jtzIQAQ6xMeG4v3M4UyfEfJw5JlfEDwdH62ROm5Ob1gc5hu?=
 =?us-ascii?Q?10j51WqVmUUHCoMLP3Pe6fZi9VekACRVmIP5n7dbHrzQUMheQtvk4dfouoWt?=
 =?us-ascii?Q?u/FbD8UCO+pp0SZbjw+hAgdsN3puqQwbAe2gwghkdQNMm7F47KgZSU0haR/1?=
 =?us-ascii?Q?CxZRrrsA18uvP6vc79iIsaeKZwmZLf2rsWvU8ly88vH9cB3pxgeL6Bzbakzw?=
 =?us-ascii?Q?B3yXD6VGQgFydXtJMcDkxuSexntAa/4hh74zTyqllUkBucFQsDOzzxSAcqqY?=
 =?us-ascii?Q?E8oXJyY4KTnLUSD15EHJQebiUG1lK+SnturGBuKc0F7BORNFlgH/BmFZuxlZ?=
 =?us-ascii?Q?z2KOWqAx20KhFX9DozjkIYvtxlnFNlyXN8U2AEwXOVoK0HSqEuBp8h7Qfeiw?=
 =?us-ascii?Q?CQzNtkA0LAHMEUiwi9aYVAirUaa4iHl8gi1+kVh5NsYpYMp99brGWTyPzF5G?=
 =?us-ascii?Q?TFirussnkurvj7j9kNb70ckzCNrmuM8AzhTFHSRW4JCvEDBAw/x9zWOK4HZ2?=
 =?us-ascii?Q?+YT+2gWpeHj1CWDVeBd84BRthCjh2i+qS3Qw0bEgEdPdZJ41buqsuGBQr+uR?=
 =?us-ascii?Q?VVWl7TueD1dAaMmmfATAziMJFH3miHk1qJW4+xM51Tn3GdsGPfhAV553jeZ+?=
 =?us-ascii?Q?wFbb/uMB/NOw2TQ6I/I8PxX+swz48GtpR1J1BfH00mcM6zVqa3sUGIBZharn?=
 =?us-ascii?Q?PzPDL485ydnh0e/cyu/ZJOhs4YSSGCwHWVkcYk+L6RCRl6hUdwQtJrNeWEDf?=
 =?us-ascii?Q?WYPXhVRsQ12L/nFsrUugZ16R7kynyf9tPAQ2E9Znl4iDfnJXtxs6Mwd4fe53?=
 =?us-ascii?Q?YYf9NJPyeufezWcse4xyi6o2ejbNUiKhRfiiNZOtGGeqjRwTA+BAHAw5tLVf?=
 =?us-ascii?Q?XPrbC+6PRdGZpxVGHHFiwRMzyXViOr36eJIqHuPouDlkz85eM4JyJZim61uW?=
 =?us-ascii?Q?0Eouh8wEVSHxhOfH9Vr2hgolXLuN/kXYE7rHP/ZmGwK/8u6O/ezasaStMYQ2?=
 =?us-ascii?Q?ArAD79x+K/DR04ZUTXaQ6aAINenuOsAenrSQFZYuPpXqzgWQfVLim/irDXwo?=
 =?us-ascii?Q?kNS5aGEuiHJA44hxHMKGZwhwegXmvXLkY6ioEVI2NlwJYM1eDW9Je/gQm8B2?=
 =?us-ascii?Q?/ewwSRoqq7q+wjszIqhhWJBAVt2oZIh1bpRl1ojOXChR95w+Mnas4qv6M/WM?=
 =?us-ascii?Q?a74ZfszJuIddtcLpvrzvrZ3rH5bkHWxL705uvsdiChhvhngbKEEUxh7rfZJN?=
 =?us-ascii?Q?TX2mc8QJP5qnUkxQhusJOBBYw+Q36s9pJi/i+O0FD2ATgx/j2OHJbX7XbF+q?=
 =?us-ascii?Q?qbxNpwmjbj9v0vysGSdbXC8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0082da78-1345-48a3-b1c0-08dcbafa6417
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 18:12:56.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/yNccPuXPCj5nFi8ypNlYTGUgSgzMOpnI58Q5QUxc9cSPlel+xFZX33FPIe3s7EFlFC/0aw/iIfeIljiZNlKaFWDlQ6KFyvuWjuVaMh5jE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7133

commit f442fa6141379a20b48ae3efabee827a3d260787 upstream

A kernel warning was reported when pinning folio in CMA memory when
launching SEV virtual machine.  The splat looks like:

[  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
[  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
[  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
[  464.325515] Call Trace:
[  464.325520]  <TASK>
[  464.325523]  ? __get_user_pages+0x423/0x520
[  464.325528]  ? __warn+0x81/0x130
[  464.325536]  ? __get_user_pages+0x423/0x520
[  464.325541]  ? report_bug+0x171/0x1a0
[  464.325549]  ? handle_bug+0x3c/0x70
[  464.325554]  ? exc_invalid_op+0x17/0x70
[  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
[  464.325567]  ? __get_user_pages+0x423/0x520
[  464.325575]  __gup_longterm_locked+0x212/0x7a0
[  464.325583]  internal_get_user_pages_fast+0xfb/0x190
[  464.325590]  pin_user_pages_fast+0x47/0x60
[  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
[  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]

Per the analysis done by yangge, when starting the SEV virtual machine, it
will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the memory.
But the page is in CMA area, so fast GUP will fail then fallback to the
slow path due to the longterm pinnalbe check in try_grab_folio().

The slow path will try to pin the pages then migrate them out of CMA area.
But the slow path also uses try_grab_folio() to pin the page, it will
also fail due to the same check then the above warning is triggered.

In addition, the try_grab_folio() is supposed to be used in fast path and
it elevates folio refcount by using add ref unless zero.  We are guaranteed
to have at least one stable reference in slow path, so the simple atomic add
could be used.  The performance difference should be trivial, but the
misuse may be confusing and misleading.

Redefined try_grab_folio() to try_grab_folio_fast(), and try_grab_page()
to try_grab_folio(), and use them in the proper paths.  This solves both
the abuse and the kernel warning.

The proper naming makes their usecase more clear and should prevent from
abusing in the future.

peterx said:

: The user will see the pin fails, for gpu-slow it further triggers the WARN
: right below that failure (as in the original report):
:
:         folio = try_grab_folio(page, page_increm - 1,
:                                 foll_flags);
:         if (WARN_ON_ONCE(!folio)) { <------------------------ here
:                 /*
:                         * Release the 1st page ref if the
:                         * folio is problematic, fail hard.
:                         */
:                 gup_put_folio(page_folio(page), 1,
:                                 foll_flags);
:                 ret = -EFAULT;
:                 goto out;
:         }

[1] https://lore.kernel.org/linux-mm/1719478388-31917-1-git-send-email-yangge1116@126.com/

[shy828301@gmail.com: fix implicit declaration of function try_grab_folio_fast]
  Link: https://lkml.kernel.org/r/CAHbLzkowMSso-4Nufc9hcMehQsK9PNz3OSu-+eniU-2Mm-xjhA@mail.gmail.com
Link: https://lkml.kernel.org/r/20240628191458.2605553-1-yang@os.amperecomputing.com
Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reported-by: yangge <yangge1116@126.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/gup.c         | 251 ++++++++++++++++++++++++-----------------------
 mm/huge_memory.c |   6 +-
 mm/hugetlb.c     |   2 +-
 mm/internal.h    |   4 +-
 4 files changed, 135 insertions(+), 128 deletions(-)

v2: Fixed a build failure

diff --git a/mm/gup.c b/mm/gup.c
index ec8570d25a6c..f8cab5c4c0fa 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -97,95 +97,6 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	return folio;
 }
 
-/**
- * try_grab_folio() - Attempt to get or pin a folio.
- * @page:  pointer to page to be grabbed
- * @refs:  the value to (effectively) add to the folio's refcount
- * @flags: gup flags: these are the FOLL_* flag values.
- *
- * "grab" names in this file mean, "look at flags to decide whether to use
- * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
- *
- * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
- * same time. (That's true throughout the get_user_pages*() and
- * pin_user_pages*() APIs.) Cases:
- *
- *    FOLL_GET: folio's refcount will be incremented by @refs.
- *
- *    FOLL_PIN on large folios: folio's refcount will be incremented by
- *    @refs, and its pincount will be incremented by @refs.
- *
- *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
- *    @refs * GUP_PIN_COUNTING_BIAS.
- *
- * Return: The folio containing @page (with refcount appropriately
- * incremented) for success, or NULL upon failure. If neither FOLL_GET
- * nor FOLL_PIN was set, that's considered failure, and furthermore,
- * a likely bug in the caller, so a warning is also emitted.
- */
-struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
-{
-	struct folio *folio;
-
-	if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
-		return NULL;
-
-	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
-		return NULL;
-
-	if (flags & FOLL_GET)
-		return try_get_folio(page, refs);
-
-	/* FOLL_PIN is set */
-
-	/*
-	 * Don't take a pin on the zero page - it's not going anywhere
-	 * and it is used in a *lot* of places.
-	 */
-	if (is_zero_page(page))
-		return page_folio(page);
-
-	folio = try_get_folio(page, refs);
-	if (!folio)
-		return NULL;
-
-	/*
-	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
-	 * right zone, so fail and let the caller fall back to the slow
-	 * path.
-	 */
-	if (unlikely((flags & FOLL_LONGTERM) &&
-		     !folio_is_longterm_pinnable(folio))) {
-		if (!put_devmap_managed_page_refs(&folio->page, refs))
-			folio_put_refs(folio, refs);
-		return NULL;
-	}
-
-	/*
-	 * When pinning a large folio, use an exact count to track it.
-	 *
-	 * However, be sure to *also* increment the normal folio
-	 * refcount field at least once, so that the folio really
-	 * is pinned.  That's why the refcount from the earlier
-	 * try_get_folio() is left intact.
-	 */
-	if (folio_test_large(folio))
-		atomic_add(refs, &folio->_pincount);
-	else
-		folio_ref_add(folio,
-				refs * (GUP_PIN_COUNTING_BIAS - 1));
-	/*
-	 * Adjust the pincount before re-checking the PTE for changes.
-	 * This is essentially a smp_mb() and is paired with a memory
-	 * barrier in folio_try_share_anon_rmap_*().
-	 */
-	smp_mb__after_atomic();
-
-	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
-
-	return folio;
-}
-
 static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 {
 	if (flags & FOLL_PIN) {
@@ -203,58 +114,59 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 }
 
 /**
- * try_grab_page() - elevate a page's refcount by a flag-dependent amount
- * @page:    pointer to page to be grabbed
- * @flags:   gup flags: these are the FOLL_* flag values.
+ * try_grab_folio() - add a folio's refcount by a flag-dependent amount
+ * @folio:    pointer to folio to be grabbed
+ * @refs:     the value to (effectively) add to the folio's refcount
+ * @flags:    gup flags: these are the FOLL_* flag values
  *
  * This might not do anything at all, depending on the flags argument.
  *
  * "grab" names in this file mean, "look at flags to decide whether to use
- * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
+ * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
  *
  * Either FOLL_PIN or FOLL_GET (or neither) may be set, but not both at the same
- * time. Cases: please see the try_grab_folio() documentation, with
- * "refs=1".
+ * time.
  *
  * Return: 0 for success, or if no action was required (if neither FOLL_PIN
  * nor FOLL_GET was set, nothing is done). A negative error code for failure:
  *
- *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the page could not
+ *   -ENOMEM		FOLL_GET or FOLL_PIN was set, but the folio could not
  *			be grabbed.
+ *
+ * It is called when we have a stable reference for the folio, typically in
+ * GUP slow path.
  */
-int __must_check try_grab_page(struct page *page, unsigned int flags)
+int __must_check try_grab_folio(struct folio *folio, int refs,
+				unsigned int flags)
 {
-	struct folio *folio = page_folio(page);
-
 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return -ENOMEM;
 
-	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
+	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(&folio->page)))
 		return -EREMOTEIO;
 
 	if (flags & FOLL_GET)
-		folio_ref_inc(folio);
+		folio_ref_add(folio, refs);
 	else if (flags & FOLL_PIN) {
 		/*
 		 * Don't take a pin on the zero page - it's not going anywhere
 		 * and it is used in a *lot* of places.
 		 */
-		if (is_zero_page(page))
+		if (is_zero_folio(folio))
 			return 0;
 
 		/*
-		 * Similar to try_grab_folio(): be sure to *also*
-		 * increment the normal page refcount field at least once,
+		 * Increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
 		if (folio_test_large(folio)) {
-			folio_ref_add(folio, 1);
-			atomic_add(1, &folio->_pincount);
+			folio_ref_add(folio, refs);
+			atomic_add(refs, &folio->_pincount);
 		} else {
-			folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
+			folio_ref_add(folio, refs * GUP_PIN_COUNTING_BIAS);
 		}
 
-		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 	}
 
 	return 0;
@@ -647,8 +559,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 		       !PageAnonExclusive(page), page);
 
-	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
-	ret = try_grab_page(page, flags);
+	/* try_grab_folio() does nothing unless FOLL_GET or FOLL_PIN is set. */
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (unlikely(ret)) {
 		page = ERR_PTR(ret);
 		goto out;
@@ -901,7 +813,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 			goto unmap;
 		*page = pte_page(entry);
 	}
-	ret = try_grab_page(*page, gup_flags);
+	ret = try_grab_folio(page_folio(*page), 1, gup_flags);
 	if (unlikely(ret))
 		goto unmap;
 out:
@@ -1304,20 +1216,19 @@ static long __get_user_pages(struct mm_struct *mm,
 			 * pages.
 			 */
 			if (page_increm > 1) {
-				struct folio *folio;
+				struct folio *folio = page_folio(page);
 
 				/*
 				 * Since we already hold refcount on the
 				 * large folio, this should never fail.
 				 */
-				folio = try_grab_folio(page, page_increm - 1,
-						       foll_flags);
-				if (WARN_ON_ONCE(!folio)) {
+				if (try_grab_folio(folio, page_increm - 1,
+						       foll_flags)) {
 					/*
 					 * Release the 1st page ref if the
 					 * folio is problematic, fail hard.
 					 */
-					gup_put_folio(page_folio(page), 1,
+					gup_put_folio(folio, 1,
 						      foll_flags);
 					ret = -EFAULT;
 					goto out;
@@ -2556,6 +2467,102 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 	}
 }
 
+/**
+ * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
+ * @page:  pointer to page to be grabbed
+ * @refs:  the value to (effectively) add to the folio's refcount
+ * @flags: gup flags: these are the FOLL_* flag values.
+ *
+ * "grab" names in this file mean, "look at flags to decide whether to use
+ * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
+ *
+ * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
+ * same time. (That's true throughout the get_user_pages*() and
+ * pin_user_pages*() APIs.) Cases:
+ *
+ *    FOLL_GET: folio's refcount will be incremented by @refs.
+ *
+ *    FOLL_PIN on large folios: folio's refcount will be incremented by
+ *    @refs, and its pincount will be incremented by @refs.
+ *
+ *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
+ *    @refs * GUP_PIN_COUNTING_BIAS.
+ *
+ * Return: The folio containing @page (with refcount appropriately
+ * incremented) for success, or NULL upon failure. If neither FOLL_GET
+ * nor FOLL_PIN was set, that's considered failure, and furthermore,
+ * a likely bug in the caller, so a warning is also emitted.
+ *
+ * It uses add ref unless zero to elevate the folio refcount and must be called
+ * in fast path only.
+ */
+static struct folio *try_grab_folio_fast(struct page *page, int refs,
+					 unsigned int flags)
+{
+	struct folio *folio;
+
+	/* Raise warn if it is not called in fast GUP */
+	VM_WARN_ON_ONCE(!irqs_disabled());
+
+	if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
+		return NULL;
+
+	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
+		return NULL;
+
+	if (flags & FOLL_GET)
+		return try_get_folio(page, refs);
+
+	/* FOLL_PIN is set */
+
+	/*
+	 * Don't take a pin on the zero page - it's not going anywhere
+	 * and it is used in a *lot* of places.
+	 */
+	if (is_zero_page(page))
+		return page_folio(page);
+
+	folio = try_get_folio(page, refs);
+	if (!folio)
+		return NULL;
+
+	/*
+	 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
+	 * right zone, so fail and let the caller fall back to the slow
+	 * path.
+	 */
+	if (unlikely((flags & FOLL_LONGTERM) &&
+		     !folio_is_longterm_pinnable(folio))) {
+		if (!put_devmap_managed_page_refs(&folio->page, refs))
+			folio_put_refs(folio, refs);
+		return NULL;
+	}
+
+	/*
+	 * When pinning a large folio, use an exact count to track it.
+	 *
+	 * However, be sure to *also* increment the normal folio
+	 * refcount field at least once, so that the folio really
+	 * is pinned.  That's why the refcount from the earlier
+	 * try_get_folio() is left intact.
+	 */
+	if (folio_test_large(folio))
+		atomic_add(refs, &folio->_pincount);
+	else
+		folio_ref_add(folio,
+				refs * (GUP_PIN_COUNTING_BIAS - 1));
+	/*
+	 * Adjust the pincount before re-checking the PTE for changes.
+	 * This is essentially a smp_mb() and is paired with a memory
+	 * barrier in folio_try_share_anon_rmap_*().
+	 */
+	smp_mb__after_atomic();
+
+	node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
+
+	return folio;
+}
+
 #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
 /*
  * Fast-gup relies on pte change detection to avoid concurrent pgtable
@@ -2620,7 +2627,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio)
 			goto pte_unmap;
 
@@ -2714,7 +2721,7 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 
 		SetPageReferenced(page);
 		pages[*nr] = page;
-		if (unlikely(try_grab_page(page, flags))) {
+		if (unlikely(try_grab_folio(page_folio(page), 1, flags))) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
 		}
@@ -2823,7 +2830,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	page = nth_page(pte_page(pte), (addr & (sz - 1)) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2894,7 +2901,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2938,7 +2945,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2978,7 +2985,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 769e8a125f0c..c5c3bab8b9d0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1274,7 +1274,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
@@ -1434,7 +1434,7 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
@@ -1696,7 +1696,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			!PageAnonExclusive(page), page);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index c445e6fd8579..d3848f56038d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6931,7 +6931,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		 * try_grab_page() should always be able to get the page here,
 		 * because we hold the ptl lock and have verified pte_present().
 		 */
-		ret = try_grab_page(page, flags);
+		ret = try_grab_folio(page_folio(page), 1, flags);
 
 		if (WARN_ON_ONCE(ret)) {
 			page = ERR_PTR(ret);
diff --git a/mm/internal.h b/mm/internal.h
index 07ad2675a88b..cf9a54ef2641 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1096,8 +1096,8 @@ int migrate_device_coherent_page(struct page *page);
 /*
  * mm/gup.c
  */
-struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
-int __must_check try_grab_page(struct page *page, unsigned int flags);
+int __must_check try_grab_folio(struct folio *folio, int refs,
+				unsigned int flags);
 
 /*
  * mm/huge_memory.c
-- 
2.41.0


