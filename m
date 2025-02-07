Return-Path: <stable+bounces-114266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143FAA2C699
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 16:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFB5B16A519
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB101EB190;
	Fri,  7 Feb 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="W6dPRUHb"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2128.outbound.protection.outlook.com [40.107.103.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F7238D35
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941081; cv=fail; b=k0DhqRD/DAJbHpYZbbX8BUsy3z/OOBErZHB80LIB+a4C5babdGlsu1zj4W7cfeB++t+oM5qnbwzlOsirROTx/G4Im0yDg+RMDWO2Xa7L5GnLaSrt13/Dp4lD775XW0nQdpgUP5NmOKd/s4/Gi+Lvlz+zVqXxtu57iVa/352Y038=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941081; c=relaxed/simple;
	bh=RBNVAmOaIPEXyRi4AHxyFeMf+SYFhd1L7h52rmgTrPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BJZUjO/YIVIDNabpIFP0JzV6wajBHg0gKgi9tzkdJ6M0a3aBvSKkCvo6nZknT9g0a9tUPMkRZ+XQlQr/oNidgE+C8yw5O57aDjJVMn9c/l6v4Hhfo768k9JHBtAi1D91XPr9sNg32G+OlGk6JUpvb5XnxX5ePZYHeiDYTPYI6nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=W6dPRUHb; arc=fail smtp.client-ip=40.107.103.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hz1/yejqxgPXtbNTxyfbr5Q7yP1im855Y1vsD2qV/oIirONLfrXC7e1yd6ego6raT+xGz4FwYnJYoL6UkRLBn84avSFNpkkUB4oqITDDLoypdkRsyacvDIUBEA1MgIh62e5QYAiCjxXfr0XfeuGV+KPToYDFG5xjOGcPm62zeh2TtULNPVAzAc/Oo73wGCilopccXxcx0jBMx3mjLFhMtPlI8Rovn/PCsZdNM+C+gjTTd5rcb4zj7bsUIOB4/G4dQpjT0ShqhQpjyljWQm/CWfn9n2B+WcA8JdoVxyc4tugkp7BVThg1y92Vfm0NzJTejwPIvD8QXvIv8CF29Rag2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0TNnlrqME+MNvjZFKy4yuRbmihzIz2AygXbypuyRtU=;
 b=w6E65s6l/LyMZ5lQ5OvzGbc0lZrdwlAvlB66FbAUWiNIZgwH7733W81As2jCHWAMPjOGw9vqDYfrSyPtWYNPYuL01odTxEDVZGpXzIjwBJRtSkT/N4rY6ZLu0iANIHTb643bweVA5x53qYWaFNy1ijNEv7IRmM64hpmqJsDctZHFKwX9mprqI6x/RqV7Lsd39eTXRJIXNJ6YAUGinQU8Gv36x+zKa0jfMLLaXi7KpgJCmwuUWRnHLRytsEJjwzGZOLSULWb5mPMbCvbC/DVnPDZarxrCyTdlp7eDKxHbq9lM87+z0nIxjYhHltgB2GXSGIMGgL5OzNI8oXdtTo59hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0TNnlrqME+MNvjZFKy4yuRbmihzIz2AygXbypuyRtU=;
 b=W6dPRUHbOVoO/eGDmz2TWf7m+l8oKxulGwYFNAYaYVy6vF8nIjm7/oF1QV+xZwChhcsm5joce3MGWekWrK6PElMon/RZJoWsSLRj656ynN67UaG4kebApTAEkZacvQmW0SwbTUG1mhbgmPSpa583hEvuilK34JV/rNHDfiLfzXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:14a::15)
 by DB3P192MB2083.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 15:11:13 +0000
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b]) by VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b%5]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 15:11:13 +0000
From: vgiraud.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Victor Giraud <vgiraud.opensource@witekio.com>
Subject: [PATCH 6.1] net: Fix icmp host relookup triggering ip_rt_bug
Date: Fri,  7 Feb 2025 16:11:05 +0100
Message-Id: <20250207151105.2513351-1-vgiraud.opensource@witekio.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0023.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::35) To VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:800:14a::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1P192MB0765:EE_|DB3P192MB2083:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7666db-d5d8-4e8e-9a4e-08dd4789a943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cbyteXUu2S0mzD0mtmoA+y4CMDZWElWQRVjfv3dOdPTfR4R3ZBwcuOmuMQrs?=
 =?us-ascii?Q?EcLxry0OUq6qh/nsGxDMjXAV8QVVM9DNMpuicJkIqrBdTbgOF8hsKvVpHnFN?=
 =?us-ascii?Q?SRY3KIvAudbRjYah3Kj4NUefJZMy/LdW0OeyA5aOLJsDNC7N5DvOo63AoZuI?=
 =?us-ascii?Q?oU/YWyxa78VlQbQnv2ZxYdrPemn5kGKPaRAJmIWaiC5rFDs00Yy/mTcbBILc?=
 =?us-ascii?Q?BLkfoGoxr+B6Tc8zAy1zSHbSMY9aYh9/Fu95X4ureMJILXBJD7GIJPyQ9sCf?=
 =?us-ascii?Q?9W/4FGMdOib6+A/kDE7KPjsgD+yAZqJPHQ72XJ5XSjkVMONO2Fyw33iaOFV3?=
 =?us-ascii?Q?E3rVY8CJE9hknH2MNlZq4D730NTzx33DumG+cMMMo6kAINkoB1i0jIbFggZ1?=
 =?us-ascii?Q?KYgXCoA+MdB4Kga2UDHJtobFjQochrK9s68rfdT9DKk1D7IO7W7/WjUCtvbV?=
 =?us-ascii?Q?yJlol5OBmAbWV798ppA+B2tpAmEIDV/EGcbOr3f4LZu9gSPVrjeo/hIVjpPF?=
 =?us-ascii?Q?zHr13gXj69tkGFnTeAWdkiF4RflLCbGJ/qXblVrciYtMpyfjvwtvtvzdKE1S?=
 =?us-ascii?Q?C4WhFnkFGge6Vx5hD4vqOvJgE3t0d/jB2ry89UWux/HdIEAb2esFXyqFoBob?=
 =?us-ascii?Q?qzGMfTJz6Flwa2HyD+liy5u6keMQbuqeVmBx7kTfemk4HiXcQHVvVHCVKMHE?=
 =?us-ascii?Q?qjekKDAU4LmnFI4R8BavmRrIwBzNpkWpUnOKGYwkX4oLnzxg/Y+kQFToRkq7?=
 =?us-ascii?Q?Slh1Ej+ec4vIa9kJOPlX3sc2TDiWsAbf9spnxUIsJbyqjvIa1HgpP9JbeF/A?=
 =?us-ascii?Q?rL2+h3PW7X4Bf8FQiNk+qN8Lsz4hSdzGLA3wjnihY8CrPv8k0BwLOamFDeFP?=
 =?us-ascii?Q?1W2q++qbYfG+GfEF4HMMHfVQVCTGlY6ITJWkZc8N9RGjAQ5aj9lVrf/eS08d?=
 =?us-ascii?Q?3pL70SioE7e3kLQCzlztnaZSP0XRQY7HV7ESCDni9c2L1nwgfybw11iMe2YO?=
 =?us-ascii?Q?P9NXpk8tFjSc/8UxI+FxJH+/2+NfeulQUyV1CaAr4OMU5ws2E++HpGHgcz2e?=
 =?us-ascii?Q?TV8XKUsW43r+grveskE4e0r8h3L6PpwsEuMW4H+S4++csXAprQg5khI/hsDY?=
 =?us-ascii?Q?j0e0tJv6DZ2A1fwCdsQwsAKdh/2CXfsr1oKrpW0PTXe+t9hHQeZLmBC+0fAr?=
 =?us-ascii?Q?CJHryz7VVcCyXJsSqT00021WG+qHdHy/60ya8gUB72bBOLOfHCLx6ClfrBJ1?=
 =?us-ascii?Q?65v87l2IdH5OqCJLR8vZFS+NTLzlWhAguY1YYKPGGmklBYm7c23UJblAyx78?=
 =?us-ascii?Q?Kshvidbs0VhfdUNUY58slf+JDQnDizeUzK4zT0FGMLIaxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1P192MB0765.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/gZGQnVNA+B8US2TOxwJh+qZrDGWqdoo5CmhB7OlDmdOdtUmT1UWThSdfUC?=
 =?us-ascii?Q?Sa/jVDJ53Vx3myGd45iq+eto500LPtnIE90rEPquektmFjT4Jzta7IPnSzT5?=
 =?us-ascii?Q?W3KVdvOWqrLIIuOmXwBndMyzRpDIGPvLgmAMJ5yhoFErLVSc9mULEHh9yAQ7?=
 =?us-ascii?Q?MzWmnG+X4tDAdK84anJ7ePnp1zFqcs8rhzXUtIF9fyEn25zOmgo51qyne+j5?=
 =?us-ascii?Q?WR5UaaJsz+2MNVw9BbixGOZTirWkcdXY+/teu/o7tVzHdnRvL5PK5899PaB4?=
 =?us-ascii?Q?kHbBGBqghw+ysFf40XeGP/BCSV+lB3dXx6aBxION7BebaGN2xapxxSVeMqP6?=
 =?us-ascii?Q?iNV0LkXUOsjzXBcY3I3KzSxKqoE6srSnAXJZqDdi5egiI3FLc8mwGjQhqwPV?=
 =?us-ascii?Q?m3Rm2rau9FZqhdgJB6CDsPhiI8n8dc3TO+ydWAPYqPYkKk8xfWgpqJfQUAiA?=
 =?us-ascii?Q?vnl0TjPXkyMdh+XUivkFTj5qpuG6jWfPYkGv1rIGIuvVlCYqTfsoO/tR/baC?=
 =?us-ascii?Q?mZni+O+y606vE4mqCOcOOGADI1vNdCs80C7MwsvN8QhZjG3V/zX4snlFNHB9?=
 =?us-ascii?Q?qmIVJhBs1CWfpiTOdNsT1l4csXuql6FJpQJSWG6l/1tVVDSbVY66OyQhjJtM?=
 =?us-ascii?Q?9pM5BnbHtYo0V5Z+wB0Td4nsV3aGERROq00vTDERzbgeJglQKufodL6kzxwF?=
 =?us-ascii?Q?eIrlMLfD9htR1vR55remmDMNAuXLaFb4wpsWYaF9WrvRw3OHqFdjMTYR6CO0?=
 =?us-ascii?Q?3HiL1eqs+uSuNpD4yzJhdEddTkxAveuvrUCuTPXHscJZ/38w96nars/0Scuf?=
 =?us-ascii?Q?0b+iyo2rlp96yy6DYIC5YvsAr5CeMbbFuE1slyq7tBZ1QsGLVkHuY9DVoQMA?=
 =?us-ascii?Q?8uq7VlrPHxRWQBi4xbc/KCM/Peg5WNdvzHekGblHy1xFglZz9JiWd7g454P1?=
 =?us-ascii?Q?G5QLSFWDWLG3EJKmVweeulvRggFk6TU5+up/R3wxQtWUQrI4F3W5wbUTk0Qy?=
 =?us-ascii?Q?K+x/MBzoh/YIGFRB0rJTJ9YhBx0b0PvE+bCAGkfQw+mQ3GbXpFDYcVPdQp9p?=
 =?us-ascii?Q?qfgaUKdZFk/mD1Uurp86fkzAD1LHo14MDYDxKvjv5eC4HK/vrW8yZv4MInfJ?=
 =?us-ascii?Q?vkuUGXI/SL3Egm6tVeVlGVUgK76jcSOCOZBa1tZyb6DecJlH9W4nOP8MiYBs?=
 =?us-ascii?Q?WG5vmVaMlIYXwJmnaN1viH+N8EZECIEs4PX6+vd5NuoWPxi1wbZoknYpHLss?=
 =?us-ascii?Q?m24gR03nyxRtuzEpoAo9aCmspZ/uS9N+HwcH4RjLU5xse/KoB2mn3W4LL+wu?=
 =?us-ascii?Q?MIszXX8pUaPbz86WXSY050ZXOQ0JR6IS5Y+IgrIaXuGd24NuqLr80Tqy+YZw?=
 =?us-ascii?Q?YbhCLO313ygwjlx+ZZN080nZe0r+M0b+s9OV75CphXbqYRjJ/Xu0m72pPD7B?=
 =?us-ascii?Q?JT9YZnAsjz8RIzfao0teuagJLbs6HeJ77lE3Hg6QVryOvXWCX8ivx8MhK0W9?=
 =?us-ascii?Q?mJFESMri7bFvtsqkCmoW4J0Zp3XK53xihtNcP1YejqSZi8qQ/eW1XUUitVkU?=
 =?us-ascii?Q?zqDGDGo7gNuluAt2VIX/4fFA0Cpn8xg8rSBI9vNQoLRkaFLa5+vQ4YuctaZw?=
 =?us-ascii?Q?ZyTD0yV49AS7AGqx+gkkdbLYynsdUqFAx6OyhVXDwq1w?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7666db-d5d8-4e8e-9a4e-08dd4789a943
X-MS-Exchange-CrossTenant-AuthSource: VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 15:11:13.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5yAbiz9RyD+RvgSLHMQGTcN5pKbW413NQ7tzvX2XhQPXkdkonoZGo5of7Wg+asaftfcd88KdekSh7AQBXq1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P192MB2083

From: Dong Chenchen <dongchenchen2@huawei.com>

[ Upstream commit c44daa7e3c73229f7ac74985acb8c7fb909c4e0a ]

arp link failure may trigger ip_rt_bug while xfrm enabled, call trace is:

WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
Modules linked in:
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b3cc9d7f7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:ip_rt_bug+0x14/0x20
Call Trace:
 <IRQ>
 ip_send_skb+0x14/0x40
 __icmp_send+0x42d/0x6a0
 ipv4_link_failure+0xe2/0x1d0
 arp_error_report+0x3c/0x50
 neigh_invalidate+0x8d/0x100
 neigh_timer_handler+0x2e1/0x330
 call_timer_fn+0x21/0x120
 __run_timer_base.part.0+0x1c9/0x270
 run_timer_softirq+0x4c/0x80
 handle_softirqs+0xac/0x280
 irq_exit_rcu+0x62/0x80
 sysvec_apic_timer_interrupt+0x77/0x90

The script below reproduces this scenario:
ip xfrm policy add src 0.0.0.0/0 dst 0.0.0.0/0 \
	dir out priority 0 ptype main flag localok icmp
ip l a veth1 type veth
ip a a 192.168.141.111/24 dev veth0
ip l s veth0 up
ping 192.168.141.155 -c 1

icmp_route_lookup() create input routes for locally generated packets
while xfrm relookup ICMP traffic.Then it will set input route
(dst->out = ip_rt_bug) to skb for DESTUNREACH.

For ICMP err triggered by locally generated packets, dst->dev of output
route is loopback. Generally, xfrm relookup verification is not required
on loopback interfaces (net.ipv4.conf.lo.disable_xfrm = 1).

Skip icmp relookup for locally generated packets to fix it.

Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241127040850.1513135-1-dongchenchen2@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Bruno VERNAY <bruno.vernay@se.com>
Signed-off-by: Victor Giraud <vgiraud.opensource@witekio.com>
---
 net/ipv4/icmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 9dffdd876fef..ab830c093f7e 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -522,6 +522,9 @@ static struct rtable *icmp_route_lookup(struct net *net,
 		if (rt != rt2)
 			return rt;
 	} else if (PTR_ERR(rt) == -EPERM) {
+		if (inet_addr_type_dev_table(net, route_lookup_dev,
+					     fl4->daddr) == RTN_LOCAL)
+			return rt;
 		rt = NULL;
 	} else
 		return rt;
-- 
2.34.1


