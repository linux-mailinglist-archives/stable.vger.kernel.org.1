Return-Path: <stable+bounces-114260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF5A2C656
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C603216A9F5
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A3238D3B;
	Fri,  7 Feb 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="rxZd8eZt"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DB1238D20
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940235; cv=fail; b=gsr+tqg2k8LZLE0iUXX7leOEnG0yuLM24z7voRluyDiqP4Go+8hxn86gS7EjcHJhgoN3T1WC5xzl2LoD4+RJCP0P3uHvNm2UHPXIfRYQSGR2YvOTGtvCVXyukORZQhb7DlIBxBj7/PehnEnfiEjjtYOs40i1Qg9kOZKAVxhOrg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940235; c=relaxed/simple;
	bh=RBNVAmOaIPEXyRi4AHxyFeMf+SYFhd1L7h52rmgTrPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BnQAjlI/RrGhICT2+TGjltdQrgGzQ21/OYsV1Wcod7Br7BsUvGym6y6UQgoVR9XwoZfwZkyKyVj+XLmYk/T7yASrL80z9LbmZes5AJrbPmkR2UX1zCHcj64P4wNavZ/g0L0zez4goyjaCGu0pw84JmdkNZm2+XgUO8yQAHTOuOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=rxZd8eZt; arc=fail smtp.client-ip=40.107.21.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0mgM0PGtFikuyVBY9fZnSQxHQj1vEqj1cRb3Al28d6smvdNf+xD1SCPM7mh+YNupvCYNz2IAlCNbsFg8YnjwrBGlum1zckn6fNgOv0WsXJ1md1mda6i5d+VOsx30A+TjJ36dD+vLZTusjqkrge5PhDJ6bj9Lsp8FMf8WIqjQ/313jR1C16oRz/ebVyR3FMGmfdo+N7lAN8BX1VjTBgN8T9TWAf8dow6IhM//csLxnCWgCoi28OK59iQcPft3Y99FCLX6uu1ln8Vn/K/pPpd6fav7t3sAdrelgDDE0dnonuQSyynfQxw5rMnMirKazNjKNPb6XHF2Frwt4s7DO2egQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0TNnlrqME+MNvjZFKy4yuRbmihzIz2AygXbypuyRtU=;
 b=sjvnVPOfANEWyBI8pGOoH1MwFvKpnpkbs5daZ4rEi+UEQ3k77pAxpFWX6cQdbRSe8waA2itW5NX7BL6WBT5L5VpCLNBMKp+NIsaGe26+9gt1dgK62UKS+K7U1evBL8EohD+ypDDCEHeYV3A2CGMRdSGCe53BJZa1PgSksMpiAOAuiQgUO6XK6Fef4snU/hVWWK43980cO02YtaUFmxJ2xSx096flGyWWdu1Jk52IF/BBoXppbuD2Hq1x3GWQuDPouZwokRpUcuAeApzZw5broTxCv2f1gego3XEQSa6A3v2npqa1jub5giz5yvZjT0eH+cFvrOdJm2Ew8tFXw/WniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0TNnlrqME+MNvjZFKy4yuRbmihzIz2AygXbypuyRtU=;
 b=rxZd8eZtWnYIbQpV47DDKyGSdQ2H0+dh8KbGlb44ei3ULsT8NKl316adUrBn0R1DeDXvRbWe9o3YW+Em2CrOOqjE2aFX/uH4oiY8/5BKjtHPL1tVxEKwDgDPBYeJyZXzRrNS5ZupFWsq0Qnmdo+prKhx6PmYwad3fhbqsQv/s8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:14a::15)
 by PR3P192MB0666.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:43::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 7 Feb
 2025 14:57:06 +0000
Received: from VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b]) by VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 ([fe80::9356:670a:78a:d38b%5]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 14:57:05 +0000
From: vgiraud.opensource@witekio.com
To: stable@vger.kernel.org
Cc: Dong Chenchen <dongchenchen2@huawei.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Bruno VERNAY <bruno.vernay@se.com>,
	Victor Giraud <vgiraud.opensource@witekio.com>
Subject: [PATCH 6.6] net: Fix icmp host relookup triggering ip_rt_bug
Date: Fri,  7 Feb 2025 15:56:57 +0100
Message-Id: <20250207145657.2504508-1-vgiraud.opensource@witekio.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0198.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::16) To VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:800:14a::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1P192MB0765:EE_|PR3P192MB0666:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8aca2f-6f92-43c6-c441-08dd4787aff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aP4uSwH9MmUVbBmi9m3ENxJ3XPQuD8kf1inOEBD/fkM/jTYucTCkHHZkbXLP?=
 =?us-ascii?Q?SxTFen0+sNg2SO+cTNGrEKgH9zT9ej/a3Hi1EnL1TQ5Sj/WwAYpA+ZEtzrEY?=
 =?us-ascii?Q?AG2CcyXOzjygCU5ogEnZCg5kWnCYIycgkS2RitWKjSsAeJ/oJrjxm4qDeaZW?=
 =?us-ascii?Q?XHGbG8ph5w7RnT731yZv0O3IFEz5CmU6ReBgv5U/ULCHYCXwAW45Z5MdNloJ?=
 =?us-ascii?Q?F7d0rKBuHf3E1gKTKlQEQh1HdLT2EKRDkYEvFuVdKd2Xv6moMfxG6Z9ICr2T?=
 =?us-ascii?Q?mgKl1qE6iVGLsjfLRFLHa383U8C0Jm5ckWBUSJcMzzQM+FI/RACwSRzx3v8f?=
 =?us-ascii?Q?OT7XPshPU78zGi+rptbueRCOP/ufEBdtx5OFNnvtOIY9wlpE8wN37tEWH1gf?=
 =?us-ascii?Q?neDslskdAvl7392sWAVPuiMpuMg/4Wjg4rvJxam67Xo51bfnWdp8pVMQJzZU?=
 =?us-ascii?Q?wThRMBCbqWmIknrFZvbnBL3UgrQuJsZN2CntBI4Up/4ThsH9KdFxdjZ/a6G1?=
 =?us-ascii?Q?lGJg9pMuS88oThvVT4KRU8Oc62WGBc/0DUt5dMd+gKPOK028tnMh/EEcJ3kB?=
 =?us-ascii?Q?Jlfp+A/I9qTSDbGN3qofcMFsHv3/qxmBoGXT9b+nKSq3wN1M9MHfobGTk4F6?=
 =?us-ascii?Q?eiLDtxslM/sYvNbODMNEdtj1H9tCZmVCOgzX0VzpZ3Y5H7zcPjpthO7og50T?=
 =?us-ascii?Q?klTdU4vRdvJhOdIpM4cCYqQubuii4YcdSBtugrhD0oW3/4i26vy/0FdgN+EW?=
 =?us-ascii?Q?IVQOkyrhTIjUK3YyOtPMkpGZH2zlUXOY0zkB88jRKeBq3+l3MlA+29oXaJqU?=
 =?us-ascii?Q?Dg0Fsy2ZLosWtjs0XTdgcfMjIjoehf23ALCj4jBUkdroZqPuLK91MHi7iqCX?=
 =?us-ascii?Q?o0bbhJ6i6yH6cs/0ygzo3o8AuXHo0cF0pYnzoZsGzhkrAlSB8n7qcuGcejRP?=
 =?us-ascii?Q?yiFguzYwFhDTTZkL+U78fpC4VE05/sZLVVsa3TEemQlp0eH4bPREXNX//X0G?=
 =?us-ascii?Q?zq/oD0JSmMRNgd2pgLC0jukhEdDc/w8I7ws6dLD3tB6KBm0vYnWJQ36FFPha?=
 =?us-ascii?Q?A6N2R0DMN6LXmkb7X8CEXAfx33uLqvtUntM07uYG39l+VE6FLKIXt7/4FQvn?=
 =?us-ascii?Q?TukeUJOn0TsTZbs4PMIUPPB9VtZlkrGR4mNPzvsYZTzoU7HzZbGLgHEXiA/V?=
 =?us-ascii?Q?THPZgkG5vmyp+AbgZ+5ZC+FPAFrzJGL+eN3Qx7LEIl89M1I90Pziq0frkpb0?=
 =?us-ascii?Q?plEH+kacUNPTNTbQt5FZbFSSNirlr2uxvc6G6wSsdk4don+DUGUOu0KLpJBl?=
 =?us-ascii?Q?CStq+hwnBpuYNZMGr6doxxSxHwxcziFj3VtM/ieEtlB+kQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1P192MB0765.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sEc4ln1AqIGJrqdbBS6ZtHmt5P8OnSfyhI00v7e6X2dbQL2IMiPBpohTUzPu?=
 =?us-ascii?Q?roZT4OGXOqIpu1+hFACVHEkCAuLZ/DPIzJfwErv1U4OCWfiaupZwyFeYbYZ1?=
 =?us-ascii?Q?QwhbZBos0tsJdZWpykAeGIuFc5pzM/LN1moDpUnHwLxtK+7vRUOFueOmGewA?=
 =?us-ascii?Q?gZaisC1s5BUyZO0ukNrQuIC8etZaoOe6ezEzrnjImg/TSxtVz9IOR5TnlWxF?=
 =?us-ascii?Q?vpsDZZ2jZ1Khz82onNpWSSyU75Oy1OAO3Vq5EPxyfHwRo/tZElC28AFCdIP/?=
 =?us-ascii?Q?2ubfKbJe3kJlhGvxb9zNoOO6JJ+ZkaBPWtl/GSAowPUZ2RXuio13Nw/ek8jX?=
 =?us-ascii?Q?8rRShxqvJ4GNNrTa75QPeoyNwOdX0op+T2oIta1lwby5iDufQiAvaLGirf8m?=
 =?us-ascii?Q?gaRHWbs53/inIcb+FViy4C169G17y3Beqc7+LFgVBgAenGJ3yiSsBiU/bs+0?=
 =?us-ascii?Q?1gqN9McvXWzw8CmZ/QLZir4SMlmrNpFTI7ZKdyJLlDV1fu9bnY+RV5Ewmakt?=
 =?us-ascii?Q?eGWIQBQTkFXs9IRfsZERLZRyYZ0kIJFZi+SS4N14IN1YpeUuLpjqboPnEOyB?=
 =?us-ascii?Q?ac+mPHT/+MyUt1m5WNBoypfTJt3iYL5X0lZJ7I/wjKyaCgvpN9oIjj2YK+T2?=
 =?us-ascii?Q?wzkbZuoVRtQOHq7EFisU1SYZnKcGqvU+EnC0xWfrUpzUhP0fPwuUOJm5JnBi?=
 =?us-ascii?Q?cjntYv2hbjG13J6URS1MKXTKlSa8tbtkl/IvFPfEWbiW7bf5gTQFyzJJD5WI?=
 =?us-ascii?Q?ThDuMDlyP2OWYJb/pJtEJpBUyCCY4WVZub4QdaVSnK2zmIrOH/7jbcJsPuJS?=
 =?us-ascii?Q?v4tb1jO1WjRUuEI4WJbTIsqvdH6Bt5dFh+1pwUa4mCibgoc9R33F6WkDLPR6?=
 =?us-ascii?Q?RDi8QfYNBFFsaoOx5PaHVvMAoXNkbUNcbZK8Z81Tbn9wfy+TRdZNWvTt+kKg?=
 =?us-ascii?Q?GnGQPvm4cAb3qNV0guzuDBzF8iseEOPGNhkoy9iwAsKAfeX401e97KDg9YeJ?=
 =?us-ascii?Q?ScD1LtaTTzW0qco0X70Hmy9eA9mhCpHdVVgBwB03HEpft2ucr8nx70Eu+DgC?=
 =?us-ascii?Q?C7FWmT1BSGuaJkRQcFc5bIS2jL0VKxbox4w4lWxfZk4JqH4StMJbagfBHvWC?=
 =?us-ascii?Q?pyJ9T/zYQ6957EaR+p8JVlgu8V3wNqSRdoUUokQuaEG2U/H6dYj2uOvsASzX?=
 =?us-ascii?Q?AwGFMNYXk0gjMVz55q2TzB9rNUpAuy7MnsMhbfmJIPEyL6GnGbxFP9RMtTEi?=
 =?us-ascii?Q?7lXA2qO70lsG4P8MK4L8mygCU/3V0eyCchNEo68rnpYX6HfgrrPwHN/QkJH7?=
 =?us-ascii?Q?aEiniWIFdMFmXfBUXEDi0kgEtGAp6QXtbhzWygA5uG8FASa780D7kIA3AoKI?=
 =?us-ascii?Q?5TJyeqoXiGJgredRGmmo1c001gVhQpP9NsO8Ab4tn9OnB07yh7g6mBPY9LMF?=
 =?us-ascii?Q?b4igYyy+i66vDwL1GVQ/yp389Ljnch+yEZZXcEnuDv3QwBeXcx1bYVGMDA/c?=
 =?us-ascii?Q?vbgYOWg/Uc38ZJ9THfbJoN99xQfZn4jhf6EDRmd7dMQRTXdPlGRcqGBKSAn3?=
 =?us-ascii?Q?/mtLnohs/+lRLWCc7PV/BoDUebjiceyO+j24Ng1KgAsl/e+HEAwJDpCpEpjn?=
 =?us-ascii?Q?6MvKLvSZ/MIEJkSDfJ6Z3EWYazfFSK8GcRaPL8SOFod0?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8aca2f-6f92-43c6-c441-08dd4787aff5
X-MS-Exchange-CrossTenant-AuthSource: VE1P192MB0765.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:57:05.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvxBpHIyaDaSSJUwtOsd72p5QVPbppyxf5Vq/GLigJUhmx3PyhJRkQALCuCNmWVj+mST/RPe9igCBmT+FYf1pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P192MB0666

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


