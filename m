Return-Path: <stable+bounces-65503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C178F94984A
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 21:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415CC1F21D70
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE21E73451;
	Tue,  6 Aug 2024 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GWh6tX6M"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020100.outbound.protection.outlook.com [52.101.85.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E822818D62B;
	Tue,  6 Aug 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972684; cv=fail; b=YH+5v4qk8SqiTyj1Df7SNE/y3fLAiFRdzEhgOvuAeXBgVU9PDB9Vbo3xJywb+tCesml1ZuZ4C3Nv5r+4NqOE70SX+nHBYvQCuq46UGbsDSFtVek8qfnAoBJRzCAznSth6XW/b9l+zSwPIyaLspNSfLAo8KS8t51UT0z7BD77r5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972684; c=relaxed/simple;
	bh=S5yazR/4DQ1DMv/jFORKzZ4HVQ3RVc24lce2+Uq7A6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hMjdadGYeM6xOTkH0yR7s98HGwFAFqZE9hMMqicgv+gQzXu8WSFp72TMyhzT0Esd05WHgd/V7JZSCUq0nIBZMaHB6LEUkrQO7qZdxeyK4l1gV4rchhIsoWc+FstmiSh6hrm5h2hf23MShSYOR9hfBJKQV5uK2qnYFCaVG4sLscI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GWh6tX6M; arc=fail smtp.client-ip=52.101.85.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAYUoNly0/gkIoF0Kt6vEAmJ8xzya1L8wujkIJz7dP3Id70Oz1MAUcUD3Sqi+o1S98fhgS/LewN7EP0lqKG8wIvlMC3gbPf2mA0PScKro7DS2fzyzwy54AzCPlvSWNyaZZxF7DSxFo92FUlMhKXSDBUqkZ8C6ncL+iaSJ9BoL7SzJGiU2eSG0C6uhAKD9rI4b0eRqekWWWf/4iWxJJtU2QLdFXIdN/jMpgb2J/a7O9DCPOAVOZIeocIA/vKJb3m2ek/UFqTkPvaPAvlibgABrOQhRvRppukB3YArz0J3bWS4aXdG4J0wOWDTgla9g15ObNw5lO6wy40sTrGJ2XnOmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8iks8r5tOSgpeVM3eb5uJBc8VIJekvTdR5tchC+UEII=;
 b=kXQgjQmQ2yd4w9+z2Q4RNR5CF4FX7Xtw6GZjbzc/2rlGvv37MpWMol1ijP00xYH4Wfk0P36b7c2GTCvEv92AP2CyVWOccQY7hwGNodaBnFkvV2RP6kMD9YHuCL372oQwXtVCjZeQgR7bY8R55NufwvV2wtFMNZ06RULDU8+4PwdKZsxDVhsAvv49VZwEdnDJ3Lczj9pDfAoRefLRkv/Oe3UW4DmbJIegTVYrPgbZC8betsPmhcYyv45AsQ/SG7B5v5aHmtcVdFmcW81WgDhecsmctZT3yqcgSyqr2Y6r3L+lItm7eSDepGiV0H4XvT/VNs5zoqGK00GPSnsIDRarhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iks8r5tOSgpeVM3eb5uJBc8VIJekvTdR5tchC+UEII=;
 b=GWh6tX6MCZjEHfj2MdXbK5oRcxMYPiQi7TMbjCfujrfJ/z3moeznstaVySj+vsgpt0eXOq+ByRemorebTz7AebBZFms4k9YNYDqq1CtHPmagyfPQmVEYBEw9E6blS2d1eILRe5qrVHEC1tNrrPRBnmg/QPTFjPu28LPofwDJMEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.24; Tue, 6 Aug 2024 19:31:17 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 19:31:17 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: gregkh@linuxfoundation.org,
	yangge1116@126.com,
	hch@infradead.org,
	david@redhat.com,
	peterx@redhat.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v6.6-stable PATCH] mm: gup: stop abusing try_grab_folio
Date: Tue,  6 Aug 2024 12:30:36 -0700
Message-ID: <20240806193037.1826490-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 97911ddf-c9db-4afa-6a03-08dcb64e5726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcFILm5aMhfEQRLBVxLvyxf9Hnp7U4IcxCqPdJNZYDU442t3koVAK9hSdcDg?=
 =?us-ascii?Q?gsq3PdY/PBtTbnByBqXrnctolpl1m6l3163FPPFTrHRMgBlp8utRILjByqLf?=
 =?us-ascii?Q?qDX+G2RSjxozvoxjfjhZgzM6FT1sNdTB2jKOKPvpE1ORcEjXp2ti2fB0XTuY?=
 =?us-ascii?Q?91LQj0xOlEU4qYWG9v3hywNcqT+yklGeQ4JxmW+SHQSIkeJIxBBGuVPi9cnG?=
 =?us-ascii?Q?kGmoZnr5tHUoWFXZO7PpgcgbZZSBwmbjtR7E1UogNcr5VfjMN2xzx5Qjnijq?=
 =?us-ascii?Q?5fOU3oMTooxdgH6uEUh21StIXeUnCXZV7Tue2MYtpc4rVcLRDDyso7jJFOeZ?=
 =?us-ascii?Q?ccnkSmy7cT/4Rx2eWqWXt6gVuGvnD37F/aJhi4h9WwHjfn8SoCJSdjd1FWLR?=
 =?us-ascii?Q?FJRE4l6O9prHCZz4Ag2JnAkyxEuuUuDarG+WtEn8T3QumHOe88PwCDNxDVuS?=
 =?us-ascii?Q?ASaeqzfQ7BmEh3D2YuzeZt78qsxXwpSdc7BfjgeM2qS/a4JkBnX+81O9E0W7?=
 =?us-ascii?Q?WK2fgP1TKAhT9UqGhRIKLMLzBPttormx9sl2QKm6Xgiu/ZgmIL8Nw/4CkNnF?=
 =?us-ascii?Q?XDVPAtofR843i13IcWPzDc88osxNFTWR3uGRKrG3E1hW3w9yaz7TUpQfMD2z?=
 =?us-ascii?Q?QNgT8YRnM/EuWLosvaqlhJphtJTO1KfrVmOr8ie0zFs9Pvvz1KgXVfIyFqoi?=
 =?us-ascii?Q?Lv1cMaykag8TwRNwyWUZK03j2DxrSrz95fsGs86LAwyPPKf1RvQVGUYtCPhs?=
 =?us-ascii?Q?ZtpRId86jogxz4DCSE/9nokndWn5rQWHhm0cJvLjY0IChswvYneFx4KgsNgQ?=
 =?us-ascii?Q?IPc/Hc7d3EXRtge3v41DnFfdPvf0LHi+sUpV2Td18UFeLsPSe9fN2USuS9VP?=
 =?us-ascii?Q?eD+A28418FPirdfmuuq0Qdao4Ecyq2fLrPUey0rudAZvoYGFEt+JwltxOHxG?=
 =?us-ascii?Q?j2af0358wdGKZRdCjRGIIN8NAGLCwqrEvwBHIydrHdjRxvahXsBCc9axDuoj?=
 =?us-ascii?Q?lGM+lOoqW1IGSJk5vMKt9kb3dFd1XEExvQibYTCpDX3P0uwOMJt15qEIAtiy?=
 =?us-ascii?Q?Gm45HaGCGGW+KoSGBrVbCtegoMVJpOeY8lo4/5EocEbvpNzgsUw2NJrvEYLW?=
 =?us-ascii?Q?OnjXTLPbT5PX1bnQERXftS5wCnJBkWhCTPbZOFpNJdoXHu8nsRMVzmLE7dEi?=
 =?us-ascii?Q?BZpUu30K8Mw1+wW1tJ1AzaZKcXMpThWbHY540BCiLdiYiakUR1dSxYg7541L?=
 =?us-ascii?Q?YTer9vhjvxJspMg6u178LhhPmK2JUlkmZ9BfDdC0AlwiTN2cJRkVZqxxRbff?=
 =?us-ascii?Q?TX0HnxEaBHknK+AMxMDbsSd7ZhvN1QzavqSUjHlhI4/CAvyRBW+XUhe9tlQN?=
 =?us-ascii?Q?puOvLec=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dFN6ZHREJIbEP/MOEuoFvjYtan9OnAPL1haq4jTfAxzYHORwV8f8ruv36AQe?=
 =?us-ascii?Q?NGfVCM9h9p26XBp0etZUu9UWQ8b2JuYslZXOM4qX//f3kME8MTrmTxqM2uuG?=
 =?us-ascii?Q?uGqEoSy6PvcdnZQ7qJAvqQvNKzxz+gbdfHw3Wtthoa+6L0sbZ+fwYIjeJq7Q?=
 =?us-ascii?Q?QMF68QR90oQwGjNrVUVKwskXwP0Xha+UugnUQsKE6kAfz40AzS29+6kxjZt4?=
 =?us-ascii?Q?OVpWkSDnwMQqaEmA5DErGamQRxSTsQkaZKttiqBJ4dCsF26Yq2YwFNReE39h?=
 =?us-ascii?Q?WDhS9Qj0vheUzQus5RKmIij8DxDbuqujEAHZ4X6oo1A1xK5FNSVwT+umsLgW?=
 =?us-ascii?Q?7Cq+87InH+SdIMbVxPAWgaz1RvV7Roq8CyHpDB6PVl/0EJ6JbdMxn6FXMmkI?=
 =?us-ascii?Q?Hr7mCXuk8N6rJpHvt3LzFXqqOw6zCd5Pd8Bi4e7C4dYvOiULq1TooBjZrpxo?=
 =?us-ascii?Q?I+gm5r6I1Iw4mXWQ/JpRoqTpMIaFSgbMzPgI9xT7ALNESyzvjQexdF3uIhRP?=
 =?us-ascii?Q?c/X1MWDu3GkeYywZ+27QQBoLFkJQl4aNtW1hDYUup1S3DnsP2/2weC2flZAz?=
 =?us-ascii?Q?WawoMjbyZ8YXyD92IqKEIVPXI+zsHH/5/3fGyLXjrWEVxyMN6guM7Uzpt+dy?=
 =?us-ascii?Q?aUolvfrvcf6cywwi7+FH9Tm56XT1G0SV2kW2vFBkRFubV3AIQ68K64TKQRYd?=
 =?us-ascii?Q?vr6WZJyem+q+tqtY0RzDA+zZeg7fEpwMIxsVDCxP3I4tcLpW1J1MdyrLYbsO?=
 =?us-ascii?Q?nErvGqtScVOqfV1CywL+Fm5QHXFunEGpuFs5cE1lqh0C+zrCCrJ+Jx5bko2w?=
 =?us-ascii?Q?z5ZyxuBw27SleUa0WgHZ5TbQAsuU5U3p/1VgJGw/KrtsmoAX96ghRXhljXQU?=
 =?us-ascii?Q?uLoAtaGXBUTQKe1VyD0l2fJOzBhu1pqyLmj6yllHarAzxIQ/LW6PFlDkZ6N6?=
 =?us-ascii?Q?W6r8npZgVzYU4RJ2kfq7xB/TJvGZYqB716w/gQfXwxt1p8oaoQulXySPnB0U?=
 =?us-ascii?Q?r56h5ZeQUjjUSa28OkkJkhtkYo4po+SNMo7ElPZ/dlhELWY13drMtc4Bli3o?=
 =?us-ascii?Q?9jaGeL4X2nJfrBz33R6Fb5qWiD/lce8XMK8Cb7DsK33q5d0EEJBqn3P3LMYd?=
 =?us-ascii?Q?77eLLEXGSkMOCQu9UNzS1OoXd7Q78542sRoibZdOKucI/bL01D2AiwkAmiT2?=
 =?us-ascii?Q?5D6ESXFHfThYVMav0wCvYwiP2DFVfyPXoDvYKBFTuxC3wuyiwMNUEKZ4LNNQ?=
 =?us-ascii?Q?FVp+Pi6yL9dgSbZTcIt6Puv0Sg5M5gI99ePIqSI9/Q/9Zg/DqJ5QSfoiYz7o?=
 =?us-ascii?Q?1PQnRksrGfdIZWLPwdW1AEszBZ3xmCi2rd3ljHbpYx2vH8ZbgzNRppEfbHgr?=
 =?us-ascii?Q?XIwfHIggDXyVpFUC+fiz5ah5dW75vuQtSGfmKUiEYxbP833I+Rg8mREH7cpw?=
 =?us-ascii?Q?6HZln8kvGIQdluA4EAL8M9cd1a0A/qFhgw8TB33sarV2W5eNDFnwTM0t/Cte?=
 =?us-ascii?Q?LlEU+FacVp6317T0pQRuABeROi0aPdTlekZ0pcS5zY9Dlm5Sopwm06fJoSFF?=
 =?us-ascii?Q?ugnj0yeAbRiiVAGHU1vyAPRba2OUH50Ub+zqMBJVUkAPxl4agI97FmucNHdM?=
 =?us-ascii?Q?Zl2XnAaqCIKoe8qi73mf0Gk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97911ddf-c9db-4afa-6a03-08dcb64e5726
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 19:31:16.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOhuAa61IiB/75BJwQAWOi6ASKt4zhxkd4G8+Cz6L7FDkOnJ5pqGe0CVLTQBTc7KfVY4L1dVnhMOK0rtluiO4l4uqAq1HezwaFS0Dtlemso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6228

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
 mm/huge_memory.c |   4 +-
 mm/hugetlb.c     |   2 +-
 mm/internal.h    |   4 +-
 4 files changed, 134 insertions(+), 127 deletions(-)

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
index 79fbd6ddec49..fc773b0c4438 100644
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


