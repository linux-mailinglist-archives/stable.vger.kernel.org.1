Return-Path: <stable+bounces-52623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2D790BFC6
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 01:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74DCD1F2225E
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 23:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A8199E80;
	Mon, 17 Jun 2024 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CdhWiWub"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2090.outbound.protection.outlook.com [40.107.101.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357D163A97
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718666749; cv=fail; b=PLpgjwG93rizUutgJkhZm+UOkNDSqWAxwqX73Ig0DH03HcepdlhwsCmxVEdKWx24SFpq9lXQukAxoJq99AHQtqQRnjm0H7NLrgARGRYl9XJ/IPJ47XeTYDMBnEF+xZ9emFnCgQRTefKCMd6f+hVU+gSa0AgTTZB9u46KT4bkq60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718666749; c=relaxed/simple;
	bh=1ybOO5ov+jvu1hi2kjw7a2gSjzF4yWNEe9at2+NShaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pUWkK1uRZl2kwljOYJVBUpC9WtbFM1mJYi1g+FdItXC4h8r0KYh1+WHwACwT1H7RvJnugh6bAO8/motO0xY7qagn73r9RTXfXxuFFjxWvbbiJIafhg12Fb+Mm6jmfklA9hl8H42z2BeAvIyqPsEBQkRQooj5nYsfcOYprGnGtXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=CdhWiWub; arc=fail smtp.client-ip=40.107.101.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcEbMNSj0DXqJzBauO8dFOecowkEEaWLUbEHaGvSmDpBEPbK5tUIt6QZ5PPaaHa+B0tG5uGXlJTIX0thbmh/+0Cjab8qs4xp4wKvsuUrwL+qL1KRiFrhf1vIFj99AaA4QYhKBOr1igl+om4e3qE0yP+soPqpS//zlLbsb1gY16u54Le4pWgGi1A0n1nAQBD/ZVeSUYjz09sbg4HlJ2zyHlNvoZslBoVEIJxvUiWM59TdtqDXXfpCaXM7NWKKQM+waXJ+xG3z1QGzjwIcPGGZogFX5jBfSFOoHSyaUrFDEFUUdwRH1mytwzpbZjU32GI6Hs++MphpM2h+74/hhs9/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQkqmjlSEca+4EdUjZ7j49tXxF5ho9Yk8WhN8mUrCw4=;
 b=A+R0wxLbHr1UWNWU6dRC23iznw+AJrG2LtJTjEuSDiawMBZbNOJRipLC5evYVR/pdjmJlS0ID4Oln1MsmqRr3YetDskNONJIWfwKdBBCMb2V9AuLj4ZFACHR7yy4/mrl8RfAnvI189pYTk00AxzNlAtZ3Eluc5Em+V7geL0CeWm86GU9MiotP+4x68yCjNwIvP7rhB1p5sa9ht7TqDXXoH4fDW4NNLMV81rDmdEhMiRsV70i75YoP8NwzI7G7ecYqzF2KS1f7u0I2trHwzqNkzQs9BJZZsKa72Og/iJ1zyNhqWc/aQrLHd+mTmLm+xrkxMGrZdgGtCnsIuvlQRX1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQkqmjlSEca+4EdUjZ7j49tXxF5ho9Yk8WhN8mUrCw4=;
 b=CdhWiWubEHpaALggtiRTguEArdOgKVQJKA8Pi8lnfBnQ/ELQBszsdT8NCwf7+Crnvjj+fpehJU5//a8k2+F7szDTmBuPNHRiuqLDV4ETkyCkqu7/wYtiWb8fiWioQR0c4a2v02jiPYbuYwaAUL1QGWt95spFkFJ01WEqQmK9E/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY1PR21MB3919.namprd21.prod.outlook.com (2603:10b6:a03:524::19)
 by CY5PR21MB3543.namprd21.prod.outlook.com (2603:10b6:930:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.10; Mon, 17 Jun
 2024 23:25:44 +0000
Received: from BY1PR21MB3919.namprd21.prod.outlook.com
 ([fe80::c90d:c54d:7c3a:69fc]) by BY1PR21MB3919.namprd21.prod.outlook.com
 ([fe80::c90d:c54d:7c3a:69fc%4]) with mapi id 15.20.7677.014; Mon, 17 Jun 2024
 23:25:44 +0000
From: Dexuan Cui <decui@microsoft.com>
To: stable@vger.kernel.org,
	mhklinux@outlook.com
Cc: Vineeth Pillai <viremana@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 5.4.y] hv_utils: drain the timesync packets on onchannelcallback
Date: Mon, 17 Jun 2024 16:25:07 -0700
Message-Id: <20240617232507.488-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To BY1PR21MB3919.namprd21.prod.outlook.com
 (2603:10b6:a03:524::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR21MB3919:EE_|CY5PR21MB3543:EE_
X-MS-Office365-Filtering-Correlation-Id: a5341c32-9cfc-4be6-c9f2-08dc8f24cf7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|52116011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H1CGvCGf3GJ3x0rT48MU1KLty9gTYKhjPaiS/6Xsa3HaFq3a4AJcd29wvRAK?=
 =?us-ascii?Q?tEszWRafD6P/FGAaFsZPpCnMqjk6il3XyJ2t/8qTokDvCWuBLiCAgOGO9WQ3?=
 =?us-ascii?Q?0joRTJoDx2O5Lck+XmtuEuDmMPXaCVoXrLP6xqJZZzYrsBznyhKDgaQ0AA49?=
 =?us-ascii?Q?Qc3cZftJxSy5+NgcG5/dYk4rHFt3Xjyhm+JvNS8P+tjknL0h/7V52Ecwuw1V?=
 =?us-ascii?Q?IHG/O9Tnp8vIr5oEXatoa0qnGcyDifl+j28EADsSfPB5BFS/IXDdj0//tloc?=
 =?us-ascii?Q?fwiRaW6FtX9pIbdY3qyWRhGF0dCV8ojxrM/70yJ2EJIHdQhwJuma/2EVelKn?=
 =?us-ascii?Q?Es08nMGhBBXOZpXKurUysGXUpGUJY/p2DuYRVVxskp3LAfRYTYNz6VMHVTDH?=
 =?us-ascii?Q?+8Y4IiaYQTMryJBJoxih7bms/IYb15vAJ5LeTIFi5rHKwlVzwmWelTs/guXU?=
 =?us-ascii?Q?7bI6TZIAGGaX0piridChgdOiqaS8XW+Jqs8xQoGZBezxlmbqz/YDdwPHKgPH?=
 =?us-ascii?Q?enNfpPYG6qVVzpRQksBUxAQkFzeF9TPXp/FLmkRzE9RXETDuc0K4ikjQ80E5?=
 =?us-ascii?Q?Mlf1IIA5xNRtzPctr3z0nlARojfRltTwi3a44uJi8qED6JeXm1G6/q0ecTMH?=
 =?us-ascii?Q?a4qDvnoSObMTDcs5nHa0qseAgMHMVCObi5IGWtXiEAU0tWpUJuZx6Q94nBmJ?=
 =?us-ascii?Q?9n1DizoMKv+QPYASSIpiVv+dom7TVpQHH3wR1sMGTs2lTsx8n0sFbfXOH2Et?=
 =?us-ascii?Q?3H6De5mw3AGdDfgyQE2A4moDH3zX86p2ZDcvb2G9eRpLuYjdnsSa9eqeJ2pk?=
 =?us-ascii?Q?tIuoqbIO/Th3SmxSzb0LQp2UnODAP/SwvywbmnoV9jo6iwm+dKaeCvqteiPu?=
 =?us-ascii?Q?TCUmGWH5xuujz1jiRD2mchDB780L49C8p/DuehaVNvT/P1tkvisyUZyRnTil?=
 =?us-ascii?Q?XgPWDBlpqHka21RkmYpmWZntbQPaFLqxEKVeqpZmdjN9LRGHXmnjydOiASgw?=
 =?us-ascii?Q?XSnssMv7jdVtmzk8XIAsWksDyR8EdZaP+r/NZmVs0iXj9h6kkrPdJjL8OOtK?=
 =?us-ascii?Q?/sR3PUzBzY1xf2RaBm17kRxOSyg2Qr95VhtLKaYtwRcxEV2LYuwN5n9dXJy3?=
 =?us-ascii?Q?O5EW2zqubWnL+gQa21VGA4YL4/i/rZyCum5BBZ0+h93OTHC12dhQJDt6NeDo?=
 =?us-ascii?Q?IiYhMhYVImBvRwjAOAIeVfxG2lVvGd8pBHlmtBxi6Ed22CHboPFaw0r+8tb0?=
 =?us-ascii?Q?E0XJezy587U05lt4nr79?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR21MB3919.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(366013)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F87NwtMe/Trw+fiiJoXf2rhs/2zg7jRsg2QwtdQp2Ka8v3J+ZwYDPVD+J4wI?=
 =?us-ascii?Q?N3sz0XdxoXOjUhLBv5utgYknpjIiywCtFE6xwQxG/tGTo8/kIBrBzntvsA4T?=
 =?us-ascii?Q?BuVGlbdpU5iqEUqmhW7C0O4bMVg8/br4TYK4hVoEmwAVOPgp1hWYfE1uII4m?=
 =?us-ascii?Q?wlSerArLjjdI7+bD65p8yk7jhQX0kGOiBz8NzpOdeqbJY/IPoOr2wpduIl85?=
 =?us-ascii?Q?NaTzuuIxm/K5oStxX7PoodQbtLZ6+cS5IDnXZxAy2qp+wy2Bwaysr5lPLWND?=
 =?us-ascii?Q?zhArCqwmFSjcULrnHQVOL0RjFbp5rfjZHbqnrgBUKRaU90T3hD4FxqVJiNy4?=
 =?us-ascii?Q?LCzkyNukmj2ycsx1sZRB/okfPaKm/4d9kQMijub12/mk6lQDEjOOXyWask7O?=
 =?us-ascii?Q?2Um8C1J3Bdp3aglERpItf+5QKFwaGkKm4ye7Owul7sh5O1a1IS+K77lBaxEP?=
 =?us-ascii?Q?6zBIP5aDNKtovjQ9G/sPaGQbNe3FRohgtOcK73piGsE3B8b6FyIUMUsPGqRd?=
 =?us-ascii?Q?h9WUSDYJSM8YoBj1RJtgypFzXwfXPOJ9rvzhE81N4+7vCZfz5xyjy3Dy14Xc?=
 =?us-ascii?Q?KWqzUIC/Q+pBWe6YYhJlZp729pgwrKzMlfpr6EgXsodtp1mzfFOa9j9ARQdo?=
 =?us-ascii?Q?+ucISw0I4rMgSq/lDCwkIyLxZ2F/OcCsqedDjwypxmWk6+CjVv5w94EyPzr9?=
 =?us-ascii?Q?lzAhcRsEctagUIreOOt+e9Q9Bz24SyR3GZ0bp1hqC5A0ibsT2V8b7X32VPIQ?=
 =?us-ascii?Q?5/JbD0eVyJ97q8o3LH+4F9pw/m3zX4wCpqdwV1S4nE2VGZ9D4uDqsgqDawN1?=
 =?us-ascii?Q?Zg/FxoeVTLbSYx7lmBHRdqNFHfJuBzrKzxBdxKzC1O/xIqIZ1DKS6iLeYBAn?=
 =?us-ascii?Q?fBivnpwfINv/uCx+HVewDivNy1gm7zNrLRrwGiWYAyIIKk5CTA1Dq14ICcJx?=
 =?us-ascii?Q?YIfGrMI/mG5zFxwv6/DTnYKRA0WkLdugNryDlwL3k8f7jH2nHDzekEXfLzRv?=
 =?us-ascii?Q?3g+LUr6e0TlAlaVuu4OiK3468IIPnneIRuxl8Npf4d/Zl9Xn5Fh7tvo31k6j?=
 =?us-ascii?Q?j5m9WotUKjrUkBQO9MoJr0KNlkBoY0mqxxFTO5K63l/syFA4PmiYTSueu3xI?=
 =?us-ascii?Q?vpST8v5mlxRN13JiyEbjesvEaYOoaEuLKOeTcyua6Yq0TFmMl8qPKiyZBCf6?=
 =?us-ascii?Q?VVRWb709iif+qN8BwjvEtBBXfInsYUj0HpjJUNHTCH2lqknqyLyKIDLDQ21d?=
 =?us-ascii?Q?6A/iUUF5KcC7i823GlmVIcGib8a66/Zm6fk6LtHVybBtRlOioXWk9kGM/KSG?=
 =?us-ascii?Q?RFYjCn9rHcpGMQa05mET657OMuT/GJ8cnbe6HmD/K3uaTXlkkNsKp7nRJqOO?=
 =?us-ascii?Q?QFDHcSxe9R5XztWugXvTtd1Ig4wixXfK4IA3OYOZOrjIUOdEwFmw9Njcuqjg?=
 =?us-ascii?Q?NDYtsSBsUm9LNW4Uaftz9uglraDkypBQPImI7wxTcFudLwwX3vpceXM7iNFH?=
 =?us-ascii?Q?DzZNRYEv/ct8x88R6B5BfPA3/76T0Tde3WlkPsxG3ACp6Ig9ATe8VjPgwrjx?=
 =?us-ascii?Q?gynUu6v7JkbSd852654MIfme0FHZ4k80LPIMJF45cFFoIO7w93/YMvMCZHyY?=
 =?us-ascii?Q?GAKDa505S22TB0UOGXHKHsilAvrDhJ7NP47DQsIR+Zb7?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5341c32-9cfc-4be6-c9f2-08dc8f24cf7c
X-MS-Exchange-CrossTenant-AuthSource: BY1PR21MB3919.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 23:25:44.5643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxBaiwFUli7NENiUZwu05hIVB42389GtouDyp/rUWJEAP76IYakgTWu2xyzpehWTSVsG1SNIb3QdNIesMcApUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3543

From: Vineeth Pillai <viremana@linux.microsoft.com>

commit b46b4a8a57c377b72a98c7930a9f6969d2d4784e

There could be instances where a system stall prevents the timesync
packets to be consumed. And this might lead to more than one packet
pending in the ring buffer. Current code empties one packet per callback
and it might be a stale one. So drain all the packets from ring buffer
on each callback.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20200821152849.99517-1-viremana@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>

The old code in the upstream commit uses HV_HYP_PAGE_SIZE, but
the old code in 5.4.y sitll uses PAGE_SIZE. Fixed this manually for 5.4.y.
Note: 5.4.y already has the define HV_HYP_PAGE_SIZE, so the new code in
in the upstream commit works for 5.4.y.

If there are multiple messages in the host-to-guest ringbuffer of the TimeSync
device, 5.4.y only handles 1 message, and later the host puts new messages
into the ringbuffer without signaling the guest because the ringbuffer is not
empty, causing a "hung" ringbuffer. Backported the mainline fix for this issue.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/hv/hv_util.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 1671f6f9ea80..48f9b1fbcbda 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -283,10 +283,23 @@ static void timesync_onchannelcallback(void *context)
 	struct ictimesync_ref_data *refdata;
 	u8 *time_txf_buf = util_timesynch.recv_buffer;
 
-	vmbus_recvpacket(channel, time_txf_buf,
-			 PAGE_SIZE, &recvlen, &requestid);
+	/*
+	 * Drain the ring buffer and use the last packet to update
+	 * host_ts
+	 */
+	while (1) {
+		int ret = vmbus_recvpacket(channel, time_txf_buf,
+					   HV_HYP_PAGE_SIZE, &recvlen,
+					   &requestid);
+		if (ret) {
+			pr_warn_once("TimeSync IC pkt recv failed (Err: %d)\n",
+				     ret);
+			break;
+		}
+
+		if (!recvlen)
+			break;
 
-	if (recvlen > 0) {
 		icmsghdrp = (struct icmsg_hdr *)&time_txf_buf[
 				sizeof(struct vmbuspipe_hdr)];
 
-- 
2.25.1


