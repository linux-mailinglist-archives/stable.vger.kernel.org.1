Return-Path: <stable+bounces-67374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A9194F670
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 20:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18591C21B32
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6618C908;
	Mon, 12 Aug 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NrsAl7JV"
X-Original-To: stable@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020142.outbound.protection.outlook.com [52.101.61.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA31189BB9;
	Mon, 12 Aug 2024 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486385; cv=fail; b=VXZ/hrfwfab73URvfb3zOJLWXQJBGaUHJAwX6wMmuo1pVyTZXGfUz0JXHDhjdEQ33XfGy0bnCBo1vVQfgK2dE94BSrbB/ZUpKWFTbFSzZDn4s7CXgjsj95u+yCdHgt90mH8deoiZj92RBHESF3GS+HJi3VSfpWxrAGKQFU5Spp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486385; c=relaxed/simple;
	bh=hFyIqRo/G1wetegzFzZyUqSemcRg53aLLkSclPFRvLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dqHw8P91ac/p6ZTencfJIIKo5IL+RH/717ZCrzayozi4yNCIViE/rOABWLk8RaTg/L7cPSw8i1Fp1jkOw74jz+ewmXOcR3U2+3YVhzQvSQThbgwhXK4EF46A2sOoj8rsiDfcvNq54WinKgJiBe6VrWxBLDSiY4qFY8Mm+4WriZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NrsAl7JV; arc=fail smtp.client-ip=52.101.61.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pahw+SAhBdevI6Sdb7mEz9upnVMUSBvPim9x013cUToMqir2wdXROdEG/goOwSZMXH6qu76AYheDaMGjT9tVM1fLZdVRFe4xemveH4pKt3HcB0AW17GfPpIRDW7EcvzR/PScqnB8KpmWjRt9AVRsZib0Brw8I17RPlf5V+iZmJI0UfGV/xJRCUcGPmu1EMpjKlFSSUxtv42KKMU5a1sLXl8vz2jvtXGbCcL0hBcL2GuR00UbRpL54D/6kM7lDfIlofFH/ij2q11T4gsCBK45CSkiIS0KhpSthYj0WN2VOe1W2HZv/YXntDsxWivcRPUrjylzVEhkn/gY6sS0OK79Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VBa+SEIKYozsYohqHAmvD6dKMpfK6jluzkdaIAfajA=;
 b=KS289loQcfN9PTxk7vK04hEUOJF5JcxFzbORfjgesKKjcHJtRhwZHIMUOwq2lBpcPvgTdvT3Pu5e/2wmB4kQM5YiYIa4tTOc94lP0y/uxwM1jDRrmwD+iTHjz6l2VOLvnwkAXj+IdEnyDcBfjcr5w13FvZUIciZC5KxcRoNzzP0kUtOET3LpdXKLu1OrJ8XL0+0PTcd0E9FJc3ZGnD03xXuXWVJeTiOR+wH5YlPRCw4ThM2KdvxBGThIchpRc62aqlr1I3irLuLccfApmYk0gv9rOKINuE7Bt3GEQfgTkIBv1IWLeNieFKJ51mvRRu7Etz/9IEh0vfohmDx+2LgESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VBa+SEIKYozsYohqHAmvD6dKMpfK6jluzkdaIAfajA=;
 b=NrsAl7JVnx5y8qj/zEyao/AQVhsKCOMwxtbto4rRmE4X7qw7r0S9Jcfdt/tGzmTJWD5Hz8BCxj/KE/XUMmwCAngaR4cbslXkI0N9w1kK51TQkENiykOOmqjRvUPM5/1TPIiZ3QBt2FOZbCM3WiHBwDlxWjdSPrXwTLkIPfbzRn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BN0PR01MB7133.prod.exchangelabs.com (2603:10b6:408:150::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Mon, 12 Aug 2024 18:12:55 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 18:12:55 +0000
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
Subject: [v2 v6.6-stable PATCH] mm: gup: stop abusing try_grab_folio
Date: Mon, 12 Aug 2024 11:12:37 -0700
Message-ID: <20240812181238.1882310-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
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
X-MS-Office365-Filtering-Correlation-Id: 70bdaac6-6367-4da9-7e13-08dcbafa631c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w5pELXQ1Dl+vmFfaFtHxN6PV/uluafwF2mdKi99wKeCADPTOI2KVBZaGtFlK?=
 =?us-ascii?Q?KTT2PwZ8+41QpqIKrQdt06NvG8xgEMVnh2pJmhOTP0oSHHD2yuBhhWVv7xPu?=
 =?us-ascii?Q?gYp12M7KPCGXxsEqn/ciBEWepj24KvbLKDQxP5N5Gsv/AemkE9ngpgmrFvy3?=
 =?us-ascii?Q?aMP7bWrksHBsqSBzHRFKMOm9VsaRa0GNGNjbdaXUTH8gyjSoDQtcvtlZARhH?=
 =?us-ascii?Q?mz/lZDFxXfBKyieH6+brmMXFkM6pek0v7yoWeSx4xcHoQq06gm0TI0Em+2J0?=
 =?us-ascii?Q?ANyNhJAE7ly8KZc0bYaO5H1I8aDkEbcWf8XN0CIMvJDudKPeZb7b6cVDxSTq?=
 =?us-ascii?Q?8jb1Gt4h5oG5fsNAYz+mj8TsUfgJR5XsD0ij80fFswJMLWgurQpaNDL2C30z?=
 =?us-ascii?Q?Kj10sc7VgUbExpr9mzqhMZZDr+4fV9DqysseT3dvBsX7BXjQtoZ35akt94P/?=
 =?us-ascii?Q?bGmn0GRfsiErf+mq5fIV2WtxCCFK+X/seyy46jnljtgmTVcBNDTSvurBQH2w?=
 =?us-ascii?Q?wN7uKtawnvqsszSdtLrK7hoUbcehEfj0FGNcm3tmXm+pAxuraZFcoJ+UagQh?=
 =?us-ascii?Q?zH76fVjAdaVrj8lNz+lY2bx30vmFnA4Gogh3dIs/ZLkr15eiaa44bs//BQTx?=
 =?us-ascii?Q?dL2wwH3AA0RDCYxBiKuhCCXrJn4WN5vRJAuabNW2FmiVVYHaTcSEaq+1VNHt?=
 =?us-ascii?Q?Fsp4oQ0YvhraQT1yxEg1nQCjFOwjecBaSXTCGN6G9YUo+6IU4bfTqZErNHlS?=
 =?us-ascii?Q?KlVxhgHXLJbFWzHWEkt1xYQQrqzoAO8IguM5ZwDB9MG2ghDE/KwawKQi3cDV?=
 =?us-ascii?Q?Ws8imFSt8TdKdpwyw9cCsJhg3T4R8KK+YnTr+LLDmFJWV30ub5oKZsgVeAST?=
 =?us-ascii?Q?Yf25wN4SwQdfuasU2dQYsQW97Zn0A5EECrsYQMB2q5DIqY7+gIKJ7wHr1dAb?=
 =?us-ascii?Q?istEK4A67nd/wliQE3D+j1MclxwX/hHr35Qpy+v87UGzVEkPxaz1PuQQmnH4?=
 =?us-ascii?Q?QXnYlbcfqP3uXrbEQXfS1OU1ujAHIY+qMwSx8ynXLRXQXDcVpK7yILxAHtnN?=
 =?us-ascii?Q?3bwHcN2A/9ER14uw8wTnxhZWFDt5E6mXmWL4fhxbN0y9gWynPnwZwsR9GXSm?=
 =?us-ascii?Q?/LEKeaEEdCHHzr2p+SHuBLuIMVycM9kfdAZPDmKvQkbfSpz/427KAdFTdyhs?=
 =?us-ascii?Q?eJsPuwf0mo7/TaDMnmFfJJToOkLJKAvc61GgX1tiw0kiJmOcinIFNis+YPRd?=
 =?us-ascii?Q?RRkhiM29gMaRDhNsPLSHzHgNHSRI7ruwi0eZ3k3FPWnw16L50ga3cTs6FNIp?=
 =?us-ascii?Q?s1xtjngm9gkWD+jI57JutbQ/an5t6g0RRURotqXD/llYQ47AtdTZxF9cFz0O?=
 =?us-ascii?Q?AbfFF9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pNjKMDFCBEjuh8HDj+b59PqTQui4siYuoXX/RahkIt9jKkaUNFslPGXxJC65?=
 =?us-ascii?Q?M56VQ2Xl517LOsJ8KunFMBGMHkTIPEu7FOaUDQ1F2F3OeC2PAXqHhYXDKe9k?=
 =?us-ascii?Q?mOcHVQntUZx5pij/s5IufEYHlxf4VTc97IuTCdOVzbzfaH80ZB4SWkYiQkTj?=
 =?us-ascii?Q?QUKfM1d2XKfj998DnqhgkfHAvP3qjvd30nUxxasRJ54/DO0Wgrb7eXgH+ViY?=
 =?us-ascii?Q?Im4f9jg70HVPL1uSA3HgTPMwctel8zPtgmaLw4hOLSnZPttH8D3FUVzreFIK?=
 =?us-ascii?Q?vtaxOd0Vuj6Wes1sStBxuepM8xX1wRV08RKAJIS5UfzqQ1x3PSCoJJ2ZTpgp?=
 =?us-ascii?Q?nWAx0HF28L5oSX+fMlsv564al6j7e7fRoqrU1qiWxcPniF65gD+KL2FcNsYE?=
 =?us-ascii?Q?feQgdzcZe8OumPQuaQP7zVZKfJpDJlmZ5YCXIUZ0JK5qEhF056mv+z6In3Ae?=
 =?us-ascii?Q?KmdX8ZEk174esGgfXXEegCand6uWEkcYJk7YkRFqnM8hIIzBMs6Mrw8x7adZ?=
 =?us-ascii?Q?RT0C8of2Xlfq11v4o1x3/pp7UmEb95j+es2P5bpa7MKmqJRx74ag5xSNH1C3?=
 =?us-ascii?Q?U2sCBK7aZcS11C4xSRfO4DfEr3Y6FVkWkR0Exbm4MFALws7+KXc67s2SqGdC?=
 =?us-ascii?Q?uLDlQv4tRtkYYimSDW59DQkO/QPfQfOdJxEs01FVY6Z0Lg4HvCVqUJAnCNoR?=
 =?us-ascii?Q?ZwS27t2toem54lMb6JGwKzC/H45aY81MlbN0OpUF5nkIpHTYdoXRTIATpkdy?=
 =?us-ascii?Q?C13jlMl8HpdD0HkLA0KMrsWj6JyP4O6SGpSMdll+sDrTA2mUBZzSrG8lwF4T?=
 =?us-ascii?Q?MKAQ2BqL190dq9Pk81HHljuOrkhoAPOiEpc6tGrYbpi51HBF5s4kPuK3J/ah?=
 =?us-ascii?Q?NQazjpkO4KjU5t1GKIw6wUyvwUa50c2GCZQZXwjBqY1zKsVpJKkvJpuLUFQ7?=
 =?us-ascii?Q?iiWOo50lqkSJoHGQ0/TsxWN6pbCrsS+ieuhBwC7PeZIMegr3319jCSvpbx+U?=
 =?us-ascii?Q?snW3F35rcBlIcozJwkJ0oJvW1Tpc6R5e7G5SrjYDljuGRb9AxBexXjJMLMab?=
 =?us-ascii?Q?Fjzl9csP16BMszIYiKqGjKnomwjcPrGLxrtuAE3iArKDxMGWtDk9BJXg3ofW?=
 =?us-ascii?Q?DO8JTobqzqECBERaI0HGVrk7e7VE+PsRHGkoi5SqN4qeD9TXNiAlsgHfDN4Q?=
 =?us-ascii?Q?y79xBsZl5iE4piIH+2+P+YxNtnDFfbYBmBoxqfrEjjsEMTI23qbGV5+lqTFu?=
 =?us-ascii?Q?pi6zd8oO3FgfxP26QkPzcf4UoT0P4pyRYBpjQjhHdJe3RzzJ9Cd/VJd5CF30?=
 =?us-ascii?Q?0Wr2PbPC3vCvBMztgX7gA4x3BMsC/GkjVGleDURkSLD6CMaSTx6Va9Lcxh4Z?=
 =?us-ascii?Q?Osbn7ziAEDqCTfxmwvYY9mKTtaCmux4dkfqN7OW2cx4btb8mfyBI+jfKpKpo?=
 =?us-ascii?Q?iCbRVl812d3gp5i6EKA3Sm9yKtnp8nLGw/RXasEHrhEQ6EgeIy5dhwdeRH9L?=
 =?us-ascii?Q?Uq3SS/AKVltnEuVTnqvvKU6OF9CXaJqDGtdcGLCf9nrD69KKeHiFKoUkDQ1Y?=
 =?us-ascii?Q?lnK8t+dLmZ7/amoFmQjs/V5YeMgd6VfI3TKwr+fgUENXRPRFzilExD2ELyHk?=
 =?us-ascii?Q?4cuH2MEizPXTbZ7SS0SNP9E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bdaac6-6367-4da9-7e13-08dcbafa631c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 18:12:55.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlysaCnQ2uPUz5ciF8w89sAuS9TNr5Z4e+A0NxEQcYG+rsJ3zPJE54nXiQNsS+qZGlrzOzFz6Bds00SyH7nmVgRUOw/NBL0Ie+f/5NT31kI=
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
index f50fe2219a13..fdd75384160d 100644
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
-	 * barrier in page_try_share_anon_rmap().
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
@@ -899,7 +811,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 			goto unmap;
 		*page = pte_page(entry);
 	}
-	ret = try_grab_page(*page, gup_flags);
+	ret = try_grab_folio(page_folio(*page), 1, gup_flags);
 	if (unlikely(ret))
 		goto unmap;
 out:
@@ -1302,20 +1214,19 @@ static long __get_user_pages(struct mm_struct *mm,
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
@@ -2541,6 +2452,102 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
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
@@ -2605,7 +2612,7 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio)
 			goto pte_unmap;
 
@@ -2699,7 +2706,7 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 
 		SetPageReferenced(page);
 		pages[*nr] = page;
-		if (unlikely(try_grab_page(page, flags))) {
+		if (unlikely(try_grab_folio(page_folio(page), 1, flags))) {
 			undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
 		}
@@ -2808,7 +2815,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 	page = nth_page(pte_page(pte), (addr & (sz - 1)) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2879,7 +2886,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2923,7 +2930,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -2963,7 +2970,7 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	page = nth_page(pgd_page(orig), (addr & ~PGDIR_MASK) >> PAGE_SHIFT);
 	refs = record_subpages(page, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 79fbd6ddec49..2e64897168bc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1052,7 +1052,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
@@ -1210,7 +1210,7 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
@@ -1471,7 +1471,7 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			!PageAnonExclusive(page), page);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a480affd475b..ab040f8d1987 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6532,7 +6532,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 		 * try_grab_page() should always be able to get the page here,
 		 * because we hold the ptl lock and have verified pte_present().
 		 */
-		ret = try_grab_page(page, flags);
+		ret = try_grab_folio(page_folio(page), 1, flags);
 
 		if (WARN_ON_ONCE(ret)) {
 			page = ERR_PTR(ret);
diff --git a/mm/internal.h b/mm/internal.h
index abed947f784b..ef8d787a510c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -938,8 +938,8 @@ int migrate_device_coherent_page(struct page *page);
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


