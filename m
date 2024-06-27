Return-Path: <stable+bounces-56002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F391B20F
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 00:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897EA1F212D3
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 22:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A941A0B06;
	Thu, 27 Jun 2024 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jGiUAR0j"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2139.outbound.protection.outlook.com [40.107.102.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFC266D4;
	Thu, 27 Jun 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719526480; cv=fail; b=QGSm02+uGFa9f66ZiGpOXk9kru1EwhHezcMFajt5xE7P7l4GJ7mElG0+bLC5l5MW4Zvo8/mKcy23G1Hj6z59pJu9YeaOWHs7ilA95lxPHt79KyicRlN8i9qNJrdHDyIKnBEX1MSyQLDJkoN3JibnZlBLyP9li6nkk932t0zQEW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719526480; c=relaxed/simple;
	bh=1z4M3ho4EpvH+Qf65L84LNJwfcgwvpKDgPKTGt+5V8E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tCQ58+l9NCakzF4W5rhmWGu84Dmjsx75SkVoLMAS5IiWTbKmNxT+yfriTox7s02hwR3yxaSp2KwDXJtoVuU23OHfZ0WCa3ECY0vTd0NlstcyLiHliSq8+fnS3iGsLPVd7HdevlC5Kr1XZRkNONszmbbQwbPm5RZROasXB0LtSCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jGiUAR0j; arc=fail smtp.client-ip=40.107.102.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7G9nbCT5z3cxatxhC5mmQUzieW8SRwEOECGSXzL1KL05jET8mxQ59NXjw+r7LESyJBYDdfFDyU28t6Kb1JeN8Gnx/bU51aZGUxINFV6ypL6rxDWFZNGsUhk/fQisk/3T6o1P8C4L1l1bRtHiepi3gBNa9G/Fpqv21+obTzikYj+GheWAN4OiECspSgULee9Aiudy+sB6s1UPuf1aJU8IEiz7V/pTl/O4QL5xdNFFLilGeR+PYqX9VqvAO4UmEZtilE6bA7lWHAIqIW3S0imgL2DfAz8tfiQSHjkWu53d2UTAtw/Q1VsOe3ynBiRiNA7vcI1ouWE0evBtQmZxWr/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9SEEaX4wCWQHpn11IWxiJ4btBFauz5Vg5bx6VpJh+I=;
 b=FG5mWRjfTV51CY7onPKUcPs+z3N7DEyVpaVS3c4jYSpI1s/yKUftTkvW9smUU1ov9UaEsQNbjquyNucxV9vO2l242ArzCYTTJnBZS2+i061A/5FMummvak+oAQiyk0blxgWEIDelmYM/fYwdAEVCjd4G6qyow8MN4oM2v9exOUm5QmwnkbgJ3zt3mFMICdb1HwHBI4VJw7HgIsy2UJDMfxdCcRDfW4tSEXDvMXCh7jAxnzVKySQ6EkV9qDx3AHQm5Jr+eaxPJPV4N5MyU7di7hmuuGfPiYkmnfQJf51j+nz2bvs4XOIc850+9ls73JmviUis+kiseHLrVUnfi6q/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9SEEaX4wCWQHpn11IWxiJ4btBFauz5Vg5bx6VpJh+I=;
 b=jGiUAR0jTz5piPS9OaJ65Lts7ZtPkH/VOTgltKBPc3MVUz1ilSAnT0dYygmTFTzb7yEz8wFyJdOtES/Dc8CaQ6gqc5MqamSzFnqJE+Kub9aOSo/KjJAMVU52E7+y+ULD95GYJsToXEs9fRMXsbYTcHdmIOBBsg4iC+QdwGdMiqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 PH0PR01MB6277.prod.exchangelabs.com (2603:10b6:510:c::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.34; Thu, 27 Jun 2024 22:14:32 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%3]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:14:31 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: peterx@redhat.com,
	yangge1116@126.com,
	david@redhat.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [v2 PATCH] mm: gup: do not call try_grab_folio() in slow path
Date: Thu, 27 Jun 2024 15:14:13 -0700
Message-ID: <20240627221413.671680-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|PH0PR01MB6277:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bd068a-4bbb-470b-c5b4-08dc96f684ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B9NwBWvcKevAR0XqC7BV8Ych6shHqKbOZ9QDxguYF6kUJN79+xLnaI9H9LT3?=
 =?us-ascii?Q?AMgegnGgJb2M+Zgjxn9S+B5h64PXan65dCA88e1dZrzz409zPddpY8vW+6dc?=
 =?us-ascii?Q?9sXzw8vbnuaJf9pDyOHCWZuaFeWmTogZY5B1CVWDAr7KGN7syLE06u4Zywwc?=
 =?us-ascii?Q?czV05bJ8hN9cKsjUCbIYtS47+gWysvZsGoIk8cVsXPClPCAYPJF/QJ3Ge1Qa?=
 =?us-ascii?Q?8wJkfhdH7y0E1cLLRcq9upawGYB9DBS8ymY2+oz/51DgvwVJJTkbBcbXXmt8?=
 =?us-ascii?Q?S2PW4WFLdHhCJcHfEfajEXvcZVOR/dsRedpdA0OLwHmf1cIBcFpmM6kC520x?=
 =?us-ascii?Q?Dc86C6LDK6oZ4Sg3GM7/5z88mP0wGDVBflPxlCB4l2gHe9VI84XXrAUAJZmr?=
 =?us-ascii?Q?YA83LkiZ/A/sqJGu1pQZ4EeGIVfwgDDdw7HZ6bNSEkH6TfU8x3UWcdFrjTbj?=
 =?us-ascii?Q?YGZhlqOTwtXUIagKqJccNOVExVkZHJRQcuYxwaLd3PBCuiUhhtWv0mYA6MUO?=
 =?us-ascii?Q?z8DaegEgPyAief+hdu4QhBxwX/kD3sKeMDL6M5ojJ/UU7W6HFQSZiuO+0VJj?=
 =?us-ascii?Q?hEMQDr9ll2hdRNlCpwkZvcGZXRcKyQqOY/8L1TA2RrCCeQCap7TIcZuST3ve?=
 =?us-ascii?Q?fFn8s6/aSSKVlqHu1eaUpl9weCxI0ofxT7Xl2AmxdONywMh9ny/b9Vjbq8ok?=
 =?us-ascii?Q?bckV96oig+xW8/jdxHZz9YQigHJq6AbxfYLKQA0oX1o8jA7LQ8iZy2fC5N7A?=
 =?us-ascii?Q?/7nINJeZO3IP63jzv1e5WaDq2ncRCaSzbn6oPbEVn8mgjtnAtfJfw8tENGa5?=
 =?us-ascii?Q?B+2T2V/YOB948dnz4pF76HXumoNyPpwxQ4dueB19cRlyIz7GF4eb8rWMkkSp?=
 =?us-ascii?Q?A/3F8y1SrbfrV/pRqTGR8RUmtV2QP6L2WNhH4SDEKiBAPXQU4xzCQpQ0HIxw?=
 =?us-ascii?Q?ku09C//+/AZsdGPcAZHpzj50Mm4LuBIqLOSbykXleSF+D8O9HsQY1dHv7MIu?=
 =?us-ascii?Q?QpadTEsqPj3IXaE4QZnsSICdBtn3FVHjOJ0jVQnXVZ8+r7HC+ovI5Y8maxG8?=
 =?us-ascii?Q?AVN+/cBEJMLTUX1h4CkIlr2LIWeYINtWkN7qEe+JdpSkLmXv4KTHACL6oprQ?=
 =?us-ascii?Q?T13+0qPY3fxBpgDAdOCeWjqP6lAYWNPNxbFbBJ+6MZB7z+CTF7TwpOU7mEZJ?=
 =?us-ascii?Q?Nmwwgig2JYNJUaf1E9DDPsl8D2Jc6ay5iM88NgPuRvckthqTbEKeVMx9aSJ8?=
 =?us-ascii?Q?ZJxgH0hlhWd78P7sCaDvi72+cO2gsNfeuKOy6Z910TWMrC/M2z96vFMi+HLT?=
 =?us-ascii?Q?9tzFvQqp6KmSvNsf7dPOD7sTu4Yaa4R226sntR6c7I+gu6KkembnkA/vN4+8?=
 =?us-ascii?Q?Av/kQoI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZFekydcrxGMdd2aUDrPnd9hxnHh8ldGGHXSZFi70AL4JPcqPBMPbqZQZYW/R?=
 =?us-ascii?Q?MWCdDxK7Sipc+zEnJcYFEV0nIw9ypvX4/WwpuNBojI4I/mHRhw27fNlPoS0V?=
 =?us-ascii?Q?ZFO5HVJtLOwC5Z2OWPBzK/v+2EIHjOvlKvLLwBOYZXhv5QlKvH0+7i5bBPPr?=
 =?us-ascii?Q?F8nqVGUShZj8ABo2Gxs5F22B4+MJmLtShKgXj0SuzTd5eJbP9r7cG97n2ni1?=
 =?us-ascii?Q?QbVJ2k1l2qLT8BOZYRTi40WiPWAmsrY3hcFIlOYrvU7a/TCeUXyl+gPUsqJP?=
 =?us-ascii?Q?b/Vl5DIMKwtZJfKjlt6WOe1poVD98jHrvhpD4Cqg4NLxCWw0kkyHO+G6LZf/?=
 =?us-ascii?Q?3zx1V9Xhfv1hfeQ1o8OVWoGminRJKM03BED8cudG0ZoC16EZsXucO22si+qS?=
 =?us-ascii?Q?U3gTc8FvNXuyTNUAlScZf3bndUIRqkaN36gnqRfy+qepn+aqbD8nDxALySP4?=
 =?us-ascii?Q?6EQmVnErz8YawJAP+pV41Wrh66Fqph+OKZmvWPo94hifE6F77iSRtCfU+f02?=
 =?us-ascii?Q?7xNdgyNYxKU9hX35iLtg1+FQvf6KlCXVYRwWAWt6z+EJ5EcdoQyIAXYt4HtN?=
 =?us-ascii?Q?kwJ+D5JSE9CORoRoM7viIJ8Qmz3U6mqno0rGZyqfJ8qbd7bJIDaXbJs+SnBR?=
 =?us-ascii?Q?2124/D1RUNS2u8EpulK8Lf5MizPWCVDFLRTaK857C3V6kYFRcT3t5Q3rVnnW?=
 =?us-ascii?Q?1VC9MtbaF6yakg9YbK2z+OAin0Qi2PgE+0TCZLrBu4mDzvKRVPOjvVg/N8B2?=
 =?us-ascii?Q?DtnQIMSyYwD2JUDvXOGamKTyTPPoMoP72GqUOUam/2TAl3tjZi/UO4jQkWC3?=
 =?us-ascii?Q?rAwc4mmFFaLXcMDllEYF1tlOGkkLQUmafBbF6HNImqdihnH2NszTHMq9dB1K?=
 =?us-ascii?Q?Gmq0BzbVVd9ZLR9of3wSFzVioe+rEKKOxBWV9J4xbpyJyPYgHhuI51vQm8Bg?=
 =?us-ascii?Q?nppkXYZBjXiILkb23UdfBclWUbYSdfbt7hp6xMl8VJtnjmqlxUIH6loPtYp7?=
 =?us-ascii?Q?mfp52o6Q7fvPhME25MgLFCGNcJsvbnCLI/9/ZuqiN1sBpDJmSMXpoJO/U5jw?=
 =?us-ascii?Q?A5xF6z4+Yb+e9zYiElES+LOWr8uSDjAeuXtVuToeVoi94LFL5KuWql7K85rs?=
 =?us-ascii?Q?m6OqUXUBSWeXxBf5VHewEy/Sn3nU7+XlWsjDrowWFkgCYb9Ze9pUQe/7NJ69?=
 =?us-ascii?Q?PGmcfBLWWpNlF6U09LbCEjxeGUnwqTvQ1Ag0koBNOV3IVPNBC5dCvrJsZFSg?=
 =?us-ascii?Q?wmAHaHjtLLglmVXizeNeLczFOctBK/cpLE3lEodjiPmh/TgeRiiiE98GEWsc?=
 =?us-ascii?Q?2SYlFU/2Uz0+B2MTJ27Hm4qKa7VEBOLtr1CcUzs5u+4hIo7SamdYVGGihfqX?=
 =?us-ascii?Q?/W4x46YtULoBIB0I1ag97knsR7q77nQfpQ+hgGa8ycXF4gYO/j9KYsWWadJQ?=
 =?us-ascii?Q?vIZduvhJcwmxeuycelY1d58NBwoVhzxnOa6BBup7zIUkPamghr/WXFD97O3c?=
 =?us-ascii?Q?2eHCF/D7vosw+yG5CVOo+2spwvTO7nlLq14/Vlsb+TUQ742rudWWkT24tpkM?=
 =?us-ascii?Q?DBFLvL2zeU8k5tYZA/kZyEmg1oajO2+D3miii6Nj/q/t6erxtPfrMun2hJ7o?=
 =?us-ascii?Q?gY6Pvn4QfVOT9u84XbVCFPE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bd068a-4bbb-470b-c5b4-08dc96f684ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:14:31.8782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9OI0soXSoaZtTovObWgAU9WnkOeXpnPCGXi+zdEvuBmBBjj2D/rBLWwcdKopUFvwSp1MtMFpnjsuw4GUNkJX1p/QvaKNL25DLAJAeqZWE+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6277

The try_grab_folio() is supposed to be used in fast path and it elevates
folio refcount by using add ref unless zero.  We are guaranteed to have
at least one stable reference in slow path, so the simple atomic add
could be used.  The performance difference should be trivial, but the
misuse may be confusing and misleading.

In another thread [1] a kernel warning was reported when pinning folio
in CMA memory when launching SEV virtual machine.  The splat looks like:

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

Per the analysis done by yangge, when starting the SEV virtual machine,
it will call pin_user_pages_fast(..., FOLL_LONGTERM, ...) to pin the
memory.  But the page is in CMA area, so fast GUP will fail then
fallback to the slow path due to the longterm pinnalbe check in
try_grab_folio().
The slow path will try to pin the pages then migrate them out of CMA
area.  But the slow path also uses try_grab_folio() to pin the page,
it will also fail due to the same check then the above warning
is triggered.

[1] https://lore.kernel.org/linux-mm/1719478388-31917-1-git-send-email-yangge1116@126.com/

Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
Cc: <stable@vger.kernel.org> [6.6+]
Reported-by: yangge <yangge1116@126.com>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 mm/gup.c         | 285 +++++++++++++++++++++++++----------------------
 mm/huge_memory.c |   2 +-
 mm/internal.h    |   3 +-
 3 files changed, 152 insertions(+), 138 deletions(-)

v2:
   1. Fixed the build warning
   2. Reworked the commit log to include the bug report and analysis (reworded by me)
      from yangge
   3. Rebased onto the latest mm-unstable

diff --git a/mm/gup.c b/mm/gup.c
index 8bea9ad80984..7439359d0b71 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -99,95 +99,6 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
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
-		if (!put_devmap_managed_folio_refs(folio, refs))
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
@@ -205,28 +116,31 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
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
+int __must_check try_grab_folio(struct folio *folio, int refs, unsigned int flags)
 {
-	struct folio *folio = page_folio(page);
+	struct page *page = &folio->page;
 
 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
 		return -ENOMEM;
@@ -235,7 +149,7 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 		return -EREMOTEIO;
 
 	if (flags & FOLL_GET)
-		folio_ref_inc(folio);
+		folio_ref_add(folio, refs);
 	else if (flags & FOLL_PIN) {
 		/*
 		 * Don't take a pin on the zero page - it's not going anywhere
@@ -245,18 +159,18 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
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
+			folio_ref_add(folio,
+					refs * GUP_PIN_COUNTING_BIAS);
 		}
 
-		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
+		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
 	}
 
 	return 0;
@@ -584,7 +498,7 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
  */
 static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz,
 		       unsigned long addr, unsigned long end, unsigned int flags,
-		       struct page **pages, int *nr)
+		       struct page **pages, int *nr, bool fast)
 {
 	unsigned long pte_end;
 	struct page *page;
@@ -607,9 +521,15 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
 	page = pte_page(pte);
 	refs = record_subpages(page, sz, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
-	if (!folio)
-		return 0;
+	if (fast) {
+		folio = try_grab_folio_fast(page, refs, flags);
+		if (!folio)
+			return 0;
+	} else {
+		folio = page_folio(page);
+		if (try_grab_folio(folio, refs, flags))
+			return 0;
+	}
 
 	if (unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
 		gup_put_folio(folio, refs, flags);
@@ -637,7 +557,7 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
 static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 		      unsigned long addr, unsigned int pdshift,
 		      unsigned long end, unsigned int flags,
-		      struct page **pages, int *nr)
+		      struct page **pages, int *nr, bool fast)
 {
 	pte_t *ptep;
 	unsigned long sz = 1UL << hugepd_shift(hugepd);
@@ -647,7 +567,7 @@ static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	do {
 		next = hugepte_addr_end(addr, end, sz);
-		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr);
+		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr, fast);
 		if (ret != 1)
 			return ret;
 	} while (ptep++, addr = next, addr != end);
@@ -674,7 +594,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
 	ret = gup_hugepd(vma, hugepd, addr, pdshift, addr + PAGE_SIZE,
-			 flags, &page, &nr);
+			 flags, &page, &nr, false);
 	spin_unlock(ptl);
 
 	if (ret == 1) {
@@ -691,7 +611,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 static inline int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 			     unsigned long addr, unsigned int pdshift,
 			     unsigned long end, unsigned int flags,
-			     struct page **pages, int *nr)
+			     struct page **pages, int *nr, bool fast)
 {
 	return 0;
 }
@@ -778,7 +698,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 	    gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 	else
@@ -855,7 +775,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			!PageAnonExclusive(page), page);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -1017,8 +937,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 		       !PageAnonExclusive(page), page);
 
-	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
-	ret = try_grab_page(page, flags);
+	/* try_grab_folio() does nothing unless FOLL_GET or FOLL_PIN is set. */
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (unlikely(ret)) {
 		page = ERR_PTR(ret);
 		goto out;
@@ -1282,7 +1202,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 			goto unmap;
 		*page = pte_page(entry);
 	}
-	ret = try_grab_page(*page, gup_flags);
+	ret = try_grab_folio(page_folio(*page), 1, gup_flags);
 	if (unlikely(ret))
 		goto unmap;
 out:
@@ -1685,20 +1605,19 @@ static long __get_user_pages(struct mm_struct *mm,
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
+						   foll_flags)) {
 					/*
 					 * Release the 1st page ref if the
 					 * folio is problematic, fail hard.
 					 */
-					gup_put_folio(page_folio(page), 1,
+					gup_put_folio(folio, 1,
 						      foll_flags);
 					ret = -EFAULT;
 					goto out;
@@ -2876,6 +2795,101 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * This code is based heavily on the PowerPC implementation by Nick Piggin.
  */
 #ifdef CONFIG_HAVE_GUP_FAST
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
+		if (!put_devmap_managed_folio_refs(folio, refs))
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
 
 /*
  * Used in the GUP-fast path to determine whether GUP is permitted to work on
@@ -3041,7 +3055,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio)
 			goto pte_unmap;
 
@@ -3128,7 +3142,7 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
@@ -3217,7 +3231,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	page = pmd_page(orig);
 	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3261,7 +3275,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = pud_page(orig);
 	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3301,7 +3315,7 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3355,7 +3369,7 @@ static int gup_fast_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr,
 			 * pmd format and THP pmd format
 			 */
 			if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr,
-				       PMD_SHIFT, next, flags, pages, nr) != 1)
+				       PMD_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
 					       pages, nr))
@@ -3385,7 +3399,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 				return 0;
 		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
 			if (gup_hugepd(NULL, __hugepd(pud_val(pud)), addr,
-				       PUD_SHIFT, next, flags, pages, nr) != 1)
+				       PUD_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
 					       pages, nr))
@@ -3412,7 +3426,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 		BUILD_BUG_ON(p4d_leaf(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
 			if (gup_hugepd(NULL, __hugepd(p4d_val(p4d)), addr,
-				       P4D_SHIFT, next, flags, pages, nr) != 1)
+				       P4D_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
 					       pages, nr))
@@ -3441,7 +3455,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 				return;
 		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
 			if (gup_hugepd(NULL, __hugepd(pgd_val(pgd)), addr,
-				       PGDIR_SHIFT, next, flags, pages, nr) != 1)
+				       PGDIR_SHIFT, next, flags, pages, nr, true) != 1)
 				return;
 		} else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
 					       pages, nr))
@@ -3842,14 +3856,15 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 				    next_idx != folio_index(fbatch.folios[i]))
 					continue;
 
-				folio = try_grab_folio(&fbatch.folios[i]->page,
-						       1, FOLL_PIN);
-				if (!folio) {
+				if (try_grab_folio(fbatch.folios[i],
+						       1, FOLL_PIN)) {
 					folio_batch_release(&fbatch);
 					ret = -EINVAL;
 					goto err;
 				}
 
+				folio = fbatch.folios[i];
+
 				if (nr_folios == 0)
 					*offset = offset_in_folio(folio, start);
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7ce28f6b7f3..954c63575917 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1333,7 +1333,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
diff --git a/mm/internal.h b/mm/internal.h
index 2ea9a88dcb95..b264a7dabefe 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1226,8 +1226,7 @@ int migrate_device_coherent_page(struct page *page);
 /*
  * mm/gup.c
  */
-struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags);
-int __must_check try_grab_page(struct page *page, unsigned int flags);
+int __must_check try_grab_folio(struct folio *folio, int refs, unsigned int flags);
 
 /*
  * mm/huge_memory.c
-- 
2.41.0


