Return-Path: <stable+bounces-56010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C81191B294
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 01:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD6D1F23466
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 23:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA251A08CF;
	Thu, 27 Jun 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q4HDR/Tj"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506BE1C6A7;
	Thu, 27 Jun 2024 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530184; cv=fail; b=cWVXpP5SnhJAGjddO6PY7C8lI81HujSxgCOb3kkzg28e9nIVQB90/xLdQzmFk7Jmxy4z4PqWaMD/TcgZxrwxPhkVVqIHbXHE9pu/fjKJtvc+ZHzJzNhadA1CFgMFBUxCrKdZtUMugRA6mVqazEcSqlH7O+jrPCQjNbQhMQkT75w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530184; c=relaxed/simple;
	bh=AVBtKOQRwDopWmQr3I7w5Em65YCH4P8dMNbEedIp8/M=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nMjcYeAn4QhwQigLDq5FLlc7qm6XuubqwfrZN3ugqky9xK3/GdyP6gtT6ucekqF+nRWLlYyv9TTjSl02TOS/Z20XcF2UzIrcsXPHp5rQtFvd+CdLS63JD205MgTqPWO96LHSpFX2Ppg5/mGiBC/hIZxMP8v2emVtoMXkolDO2xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q4HDR/Tj; arc=fail smtp.client-ip=40.107.237.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKoKNovJw62Jt8I16CMxpgqBGwwNVa4yIOH14Humb8bdGITkidYb1rnJQgNVX2PloKhFtHYEhWIhBaKqcI0O8aZry2t9o8cb3aboBHBs0RLetGULreOKUuilT7ptHzafrMqEH1ukLM8o9Yzi3GxuX1H+mq/Sb1brtmG7o4+JeuJTy770SNGAXSex5j+U5hAYs/fDxc9cwciK+N8ZgmWZ+1d7QfjdD5FYu8hx03FacBkAH7pLUYpT9Gn7PZwAwef3TLMkELlmeizJ3vhnhYKWjNpGm7bbecl2/gR9sWzsw3PQu0brA0jKV/CmbRssapzuCl1NW2RC+iKjpBABltmdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkRXRcqZVOyNpv8MZ8kJZCZsOQYiq1wuapfrZX6zWwo=;
 b=GDvMFf0PH6twTnmalLjfFpM8OOtzlLZpeY7pNWpoX5bPC/jjWWV9gusC6g7M6uoB8L8gFkml8EBDSxQKNBzFlkorfFBV/r+/8IFDjEq6W2wSr96FWtCCmEAPfqKLSdVELaN8osVBH2RDALHbRG8/0aQZpp5nUAS2Er7lmSvUNd202IYmLdDwvTqNIrtVHRZoHCuq3eNAqXl6kqGpa5ePJIBLAA4utltb0p3rtzAjHVQ1qIE25pahlc87TUY8SOM7HMTRqrGVig7G2vlOs/dm04Z5WIfgiAteJ4dXQoT2hqSqnEZ9knbFPrGAnlgDzGnk6SMIAsYtN3WbxQQ2ZSMxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkRXRcqZVOyNpv8MZ8kJZCZsOQYiq1wuapfrZX6zWwo=;
 b=Q4HDR/Tj/JZ6Vq/GYInlLIr8R0ODQbPKFDo4Gc67VWA4O5NwqQQ3xfJoN4nw2uWIy8KpX1hHBY0GGDbDu2e1t7XweTXiijYbi5QRAeBvrasdyx42m/zhzVn/6AC2WbYZs1q7VcyLVN5VdTwdbyFUGDYAN+aF8oYg9V/s20Hoi1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 IA0PR01MB8380.prod.exchangelabs.com (2603:10b6:208:48f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Thu, 27 Jun 2024 23:16:17 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%3]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 23:16:16 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: peterx@redhat.com,
	yangge1116@126.com,
	david@redhat.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [v2 linus-tree PATCH] mm: gup: do not call try_grab_folio() in slow path
Date: Thu, 27 Jun 2024 16:16:01 -0700
Message-ID: <20240627231601.1713119-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:930:d3::22) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|IA0PR01MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: c05e4458-8010-4cc7-4951-08dc96ff254d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IIbnJeEP/RwbPxcjPAeX/UjiJxO24OZx6OqPo8Vi4nRTL5xS3IV4BuRK8vpv?=
 =?us-ascii?Q?8g82HpnvOZ8yKksXLmLtkFok50kGUjjtptHZ0IbgXurGWnynm1gxRrp2JcKb?=
 =?us-ascii?Q?voOUKr+KCI0Zvltn2/sHscQH515gqcUOnLSst1kbZosoaAaSHhd133y208qG?=
 =?us-ascii?Q?2CDAJ4uZ44qpUuy45vNR7vfdZSanyBXYnB6fbyKqNxz9AeN3FhHQhII9H3C8?=
 =?us-ascii?Q?20lZFH3FTZ3gH9sFCcROlRHFaluN69Mw/lhQhg9+S5q83SGuM+CGBqvdKxNq?=
 =?us-ascii?Q?wBBpeoGECa99YL4x/kViTK4GD4pbz1u0AVF/Yt+DE4lNBXdlAT+BCMWg++Fu?=
 =?us-ascii?Q?HGpAMV2B/Bsk8eBDH4ciKTWpWMyEzpRtyETtFzL2VnyBBiGUu5SBdBQaWZST?=
 =?us-ascii?Q?OG6Q2FHyMJ/2nHs1WJun1zLCryNQiEOdkCkemVbIfhNw+3ewBN6KWYXjSUKr?=
 =?us-ascii?Q?81oZKyzLBUSRu/9O9Lsrvi/LUWi8l8n4QjXsKM5glkzgpxqBqpPhrIx6erIH?=
 =?us-ascii?Q?4XQObyxs6H7Xyoo628voY5ceht+4pSe4+RM4ug8cEtIPVpujJvm4QcsuTKS4?=
 =?us-ascii?Q?8D1Nz2r4pmJs6dSTbTWpY4dx475qIkWVlCuOarIGN3DOXsj6yzU7t7jE4ljJ?=
 =?us-ascii?Q?Q3lZDNMe43z1gPT8MYST7MpP//SqDrn/oJuOka8mC3cU87p1vSjp+qGFO5Yf?=
 =?us-ascii?Q?SqIOTXKSSr2FrUYGZxgscHb2SmOGpkXgV0J9hXxH9gVGMli/IqDtWZCadM/s?=
 =?us-ascii?Q?a672cadGJKh58k5698FOng/Sj/RmsWiSRdt/pGirZ12aq72E9iNuFa2Wqh/P?=
 =?us-ascii?Q?ohjQdgPUMk78p0LWX7sRR/4gP9rBYJmGpcN+aT7gTnAaYrh24nfyl2MbUZJl?=
 =?us-ascii?Q?4Re/sxYl0INGTHKiXn8291nZZpXy1eQih2ww6b/hdayrgc48dDm+yrIhDH4E?=
 =?us-ascii?Q?aZwaX1vHT2Qu31pTo8tFiqf8Us1XgnMDKoIWAqz5SPVkKLctebxVsDJ/ARbi?=
 =?us-ascii?Q?8BpwOA3/jZstqdjn8s0i8fjex7o15cbVGmqHpYFUZOpJOM+M0AAiUD+0hKte?=
 =?us-ascii?Q?GuWovKzzN5dfRai9lKWcXMAKPdTxJnLmGlb8tPV+zweSU9ewBHo9iAdhXu/g?=
 =?us-ascii?Q?hdav6UL1GqdAU4BA/YvZt6h1SmXUct6Rd1Pg/ZZdhmUPnuuMxpIHskyx7rA+?=
 =?us-ascii?Q?5Bo+LkuW6UumGcNhdS2HDOmPuERKKJdOSubPje0rHKyM24XUmpVjWu6ySqG8?=
 =?us-ascii?Q?vMnTe4gl7GV4jEsiT3ciy9QQtG6d8W3qfBWBJX1ZbA1Wab2s8c7w0wFBxNr3?=
 =?us-ascii?Q?LihUIyYbRGbCiaA/BHFudyeDHibnkuaYVYk0ZwSpQMOvjqO+V9pnZsetrW10?=
 =?us-ascii?Q?f9Og3t0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQb00NcBc0WQvn4X5bHbHxEMCden3lavX/9Dl3Y/rAIClurc7twRaxvfUzH1?=
 =?us-ascii?Q?uv7OUAgFwMbUOyhqEsiPbk2zBKXzpC5ZX4vzm1EwEFFSoVcuDs8CRxVC7ePj?=
 =?us-ascii?Q?C5422E/+hyDHS5FaUgoo+/1A0LMmZudNGwGPVVmZo4SwC6mfSlhFJ07HnJaD?=
 =?us-ascii?Q?yk2kYGMeiG4NJuCH9flKDOyBnxxUNwJAdtJadboBD4cP9Q6mHxanbi1JCLem?=
 =?us-ascii?Q?Ue1gguR8O+9Cu3Ds3vFGoBADxz7HdGQdKBo/3A3FOt2hXVyJIFGzaAUoXqpz?=
 =?us-ascii?Q?U/HlfCx5w+7tk+1dAqBEBtpVSYgc1Qr7EbIpqhwQ1dpNukgDtCcDUldJ8Cwi?=
 =?us-ascii?Q?sRK39mGF1VosI3sKer/7H3fVwhASY0SvKfzq3xrv2DXXGL84dZ6mD6jeToBO?=
 =?us-ascii?Q?O15ktmjM9dNQY8PEt9o4bkUEl+rp0z3jZX5DmfOiVPoo8lEtThIesQQNeROW?=
 =?us-ascii?Q?86pbA5JV9YvZXsIvqZ5cHCK3CU+T2h6K9RCjegl1CgvanT9jtT9lNJFTVILN?=
 =?us-ascii?Q?Sd7gVXkcVPDfYR6CjGnyhKXKyRXQODb4m5PoSwfGkapmuhoIgWHlj1kJA9J1?=
 =?us-ascii?Q?j687drSzZKMO9hTbX0FzzQmKdeIHIAF9yByTvNwCnkGbNhi6NXQ3tJKmSSce?=
 =?us-ascii?Q?43BlKLKD/WUxJZfcBqbqDZDmLXAvdjedOBW12HtJzfifsQNaVVLYSL4XpLZ1?=
 =?us-ascii?Q?oQtpNZ+S4GgCMkkmRxQP/A9tajf8LSavARqa8EVfzit6ed66CfM6WFIfZ9R7?=
 =?us-ascii?Q?iVIqKhbx6l7ko9dFrKnpwVNtipATnW4mcySv/YNCOd85eXINSJevOmt+yC0H?=
 =?us-ascii?Q?76KBpeR0hyCJ8+BR6P8lMCAJXPXTySEh2V6WbXS9KVheMisci3DfeBkJr2l0?=
 =?us-ascii?Q?StWHqi/jAZqzuksqN5Lx/UgbysTuRsE5cH2e8acJrEqelO12QpRrrFsVDhWt?=
 =?us-ascii?Q?FSPeVfo8371DyPd/EFL0dMqYnjiM0midQHEJFDCwV05hGvPTtmiJANNiduIW?=
 =?us-ascii?Q?h6mugQBlv7lqRKKGEMFybsmJ4lAqMrtyG/VoMbi+2+nNfK/FhzNIZ7v0mvDy?=
 =?us-ascii?Q?TwpumNNCzNgE9Pl57OBlmyVUBCgmiP4r+xjoZyoesSeHONMEgaK6SQiW2/+O?=
 =?us-ascii?Q?23IVUrsFV5uxbalJL8WZQ9UuPQPx1bdA6kNOxCTUzkS8LEUKFldWoow+iuWR?=
 =?us-ascii?Q?fswcKrxI7hbLScXJP2naifTRITRpb/QxLeQVu3EAFr5WT0YbX8j7k+HjfeMY?=
 =?us-ascii?Q?vNRvyPw/pLHORRwmmX7tiar+0ZwdkQMU3z1da8KZkN67lO7+0afRswhVl0aL?=
 =?us-ascii?Q?PEuP8S/4oYHul5MM5tUGhXyxGQw9plGvNQTCuPCl1Wtwgmz3CLIW7dDCphFx?=
 =?us-ascii?Q?gc27lwYKaoMAN0QnPGPFI1bj4v3sgUhvka/Xn1DfIJgqQzkT5dZYXiDHmgkZ?=
 =?us-ascii?Q?un2RyjLY63hn9mjZiJFmP2pTCie1/KN2b5s/Kfz6s5Qkccwx2YhtHN3XVjdZ?=
 =?us-ascii?Q?JVpugu2LQg5pWVkbr2CFZsPrWk5dedsMF+qbOIUgyxmk9Gagkv/9AWCwS9fr?=
 =?us-ascii?Q?Wi9RzeY9cqx2hN4n3JXFGYPyQ1of/NkWu6eBDde3C09FFXcODX0HgU5KlNTZ?=
 =?us-ascii?Q?sie8CxwfhN+MqkgK3MYP03E=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05e4458-8010-4cc7-4951-08dc96ff254d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 23:16:16.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp93z7fJ9HI3CLd5qDYRsxjV1BwnCQpUaQL55DPWgUgrJ8CnYDEiS0BOXtWoeFarAiNM92KCrYaD0Chl8lYkuMbRTjHqnJc6YrPP7giuQ1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR01MB8380

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
 mm/gup.c         | 278 +++++++++++++++++++++++++----------------------
 mm/huge_memory.c |   2 +-
 mm/internal.h    |   3 +-
 3 files changed, 148 insertions(+), 135 deletions(-)

v2:
   1. Fixed the build warning
   2. Reworked the commit log to include the bug report and analysis (reworded by me)
      from yangge
   3. Rebased onto the latest Linus's tree

diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b..6be165224c1e 100644
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
@@ -203,28 +114,31 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
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
@@ -233,7 +147,7 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
 		return -EREMOTEIO;
 
 	if (flags & FOLL_GET)
-		folio_ref_inc(folio);
+		folio_ref_add(folio, refs);
 	else if (flags & FOLL_PIN) {
 		/*
 		 * Don't take a pin on the zero page - it's not going anywhere
@@ -243,18 +157,18 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
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
@@ -535,7 +449,7 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
  */
 static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz,
 		       unsigned long addr, unsigned long end, unsigned int flags,
-		       struct page **pages, int *nr)
+		       struct page **pages, int *nr, bool fast)
 {
 	unsigned long pte_end;
 	struct page *page;
@@ -558,9 +472,15 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
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
@@ -588,7 +508,7 @@ static int gup_hugepte(struct vm_area_struct *vma, pte_t *ptep, unsigned long sz
 static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 		      unsigned long addr, unsigned int pdshift,
 		      unsigned long end, unsigned int flags,
-		      struct page **pages, int *nr)
+		      struct page **pages, int *nr, bool fast)
 {
 	pte_t *ptep;
 	unsigned long sz = 1UL << hugepd_shift(hugepd);
@@ -598,7 +518,7 @@ static int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	do {
 		next = hugepte_addr_end(addr, end, sz);
-		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr);
+		ret = gup_hugepte(vma, ptep, sz, addr, end, flags, pages, nr, fast);
 		if (ret != 1)
 			return ret;
 	} while (ptep++, addr = next, addr != end);
@@ -625,7 +545,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 	ptep = hugepte_offset(hugepd, addr, pdshift);
 	ptl = huge_pte_lock(h, vma->vm_mm, ptep);
 	ret = gup_hugepd(vma, hugepd, addr, pdshift, addr + PAGE_SIZE,
-			 flags, &page, &nr);
+			 flags, &page, &nr, false);
 	spin_unlock(ptl);
 
 	if (ret == 1) {
@@ -642,7 +562,7 @@ static struct page *follow_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 static inline int gup_hugepd(struct vm_area_struct *vma, hugepd_t hugepd,
 			     unsigned long addr, unsigned int pdshift,
 			     unsigned long end, unsigned int flags,
-			     struct page **pages, int *nr)
+			     struct page **pages, int *nr, bool fast)
 {
 	return 0;
 }
@@ -729,7 +649,7 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 	    gup_must_unshare(vma, flags, page))
 		return ERR_PTR(-EMLINK);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 	else
@@ -806,7 +726,7 @@ static struct page *follow_huge_pmd(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 			!PageAnonExclusive(page), page);
 
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -968,8 +888,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	VM_BUG_ON_PAGE((flags & FOLL_PIN) && PageAnon(page) &&
 		       !PageAnonExclusive(page), page);
 
-	/* try_grab_page() does nothing unless FOLL_GET or FOLL_PIN is set. */
-	ret = try_grab_page(page, flags);
+	/* try_grab_folio() does nothing unless FOLL_GET or FOLL_PIN is set. */
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (unlikely(ret)) {
 		page = ERR_PTR(ret);
 		goto out;
@@ -1233,7 +1153,7 @@ static int get_gate_page(struct mm_struct *mm, unsigned long address,
 			goto unmap;
 		*page = pte_page(entry);
 	}
-	ret = try_grab_page(*page, gup_flags);
+	ret = try_grab_folio(page_folio(*page), 1, gup_flags);
 	if (unlikely(ret))
 		goto unmap;
 out:
@@ -1636,20 +1556,19 @@ static long __get_user_pages(struct mm_struct *mm,
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
@@ -2797,6 +2716,101 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
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
@@ -2962,7 +2976,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
 		page = pte_page(pte);
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio)
 			goto pte_unmap;
 
@@ -3049,7 +3063,7 @@ static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
 			break;
 		}
 
-		folio = try_grab_folio(page, 1, flags);
+		folio = try_grab_folio_fast(page, 1, flags);
 		if (!folio) {
 			gup_fast_undo_dev_pagemap(nr, nr_start, flags, pages);
 			break;
@@ -3138,7 +3152,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
 	page = pmd_page(orig);
 	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3182,7 +3196,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
 	page = pud_page(orig);
 	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3222,7 +3236,7 @@ static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
 	page = pgd_page(orig);
 	refs = record_subpages(page, PGDIR_SIZE, addr, end, pages + *nr);
 
-	folio = try_grab_folio(page, refs, flags);
+	folio = try_grab_folio_fast(page, refs, flags);
 	if (!folio)
 		return 0;
 
@@ -3276,7 +3290,7 @@ static int gup_fast_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr,
 			 * pmd format and THP pmd format
 			 */
 			if (gup_hugepd(NULL, __hugepd(pmd_val(pmd)), addr,
-				       PMD_SHIFT, next, flags, pages, nr) != 1)
+				       PMD_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
 					       pages, nr))
@@ -3306,7 +3320,7 @@ static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
 				return 0;
 		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
 			if (gup_hugepd(NULL, __hugepd(pud_val(pud)), addr,
-				       PUD_SHIFT, next, flags, pages, nr) != 1)
+				       PUD_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
 					       pages, nr))
@@ -3333,7 +3347,7 @@ static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
 		BUILD_BUG_ON(p4d_leaf(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
 			if (gup_hugepd(NULL, __hugepd(p4d_val(p4d)), addr,
-				       P4D_SHIFT, next, flags, pages, nr) != 1)
+				       P4D_SHIFT, next, flags, pages, nr, true) != 1)
 				return 0;
 		} else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
 					       pages, nr))
@@ -3362,7 +3376,7 @@ static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
 				return;
 		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
 			if (gup_hugepd(NULL, __hugepd(pgd_val(pgd)), addr,
-				       PGDIR_SHIFT, next, flags, pages, nr) != 1)
+				       PGDIR_SHIFT, next, flags, pages, nr, true) != 1)
 				return;
 		} else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
 					       pages, nr))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index db7946a0a28c..2120f7478e55 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1331,7 +1331,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	if (!*pgmap)
 		return ERR_PTR(-EFAULT);
 	page = pfn_to_page(pfn);
-	ret = try_grab_page(page, flags);
+	ret = try_grab_folio(page_folio(page), 1, flags);
 	if (ret)
 		page = ERR_PTR(ret);
 
diff --git a/mm/internal.h b/mm/internal.h
index 6902b7dd8509..52db9219b2db 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1182,8 +1182,7 @@ int migrate_device_coherent_page(struct page *page);
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


