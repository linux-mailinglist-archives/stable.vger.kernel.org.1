Return-Path: <stable+bounces-147918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D84AC6398
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 10:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C88B3ACA0D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54791FE461;
	Wed, 28 May 2025 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="QJRvWUTQ"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2136.outbound.protection.outlook.com [40.107.20.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6A5246765
	for <stable@vger.kernel.org>; Wed, 28 May 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419407; cv=fail; b=KlrvvIGma/bHNIC6mgG64qOLAIWoYLIC4QVGZDfmOO4Q+S9HfAL9b4oiqxnm3Sb1Sj5Qm3CHf8x8ewkURawaNKUOXJOsU+tUe4/qCTSG7V5EJKdvB6BOLfL69aD+BZ25mPGCVV/VN0JcfhhLi8V+PVz30bEZX57wBSVouBQgtUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419407; c=relaxed/simple;
	bh=O+rrp4ZI/XHLPJvRGptpPrwnGNIEJgHeE0frd5naCaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BzoWlISpT7oUf6PkwcFMprNtR0cDNXo72u1d99a5Apnyvh/W7LjdvG8yC8Kw38L+0+Xtfu4sI6FwuvlVAebbxFZp8+AWBD/CC3gC8ZPvqfZgPAb2SHxT109j7+q3p0e+dGSeMc2aMsNQai+tkRgAPYdRTxLQ9TSj9WUcNQ+sBhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=QJRvWUTQ; arc=fail smtp.client-ip=40.107.20.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOmiRb5aavF/siFCN1stfHk0X4qNTVleKF9N+BTbaHg7KSNbVZDroQWTz+8XteVIuJlA5tfnZOWNQb83VyYB5QhCkMLKKyf6er/lhs+44t+YebRGyYaL/bkRGNH8jLdNzz2OmgwHpA6X+2knvowV6A7PulNzdU07kjiD+WclIvbWz0+uW8fKagE04dYKOOP91pTUQNL4QlYXkHL4vzn5DmRsegpp0DL4P/jq3tAkAAVrkA1pKgy39hqns+16sS8mra9VcbLnVkMo7V8t2ff4Rr6Nn8kEe7PxaRL7WmBQvjTZEhs3A8QpsDM/BS/w1qH0UUNPRqhgLDFvzGRKepF1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlVKfq7XZJlFRPLXg/xOzjHL99COvj+eCBGPMg+ShBA=;
 b=dDPHC6G2Qs68iLUSXXQh3eWezCIpnR/TODkAHWUaxfNmOdNa4KT9nRJ1Nazrql284nxuKSQW6VTjW4TP3jUW1VVdFjcx8opbIUG8HXxp3bR+J7Zy/GFat3XMexILV+TmmoaSggdXdpAu1+7pr0kF/Y7FXyFVGd/bgUVEhvJ0b6VB5/JnVn04xgV6f169ulAG3JoHHIReFuq5cY0vmWeYNDX/WUSCdYC2lZuVVPApgX3HPGcEONCs7I24POB0AVspr9oSggbu+8JUEQgQQN8s+kPMhdNQmFkDtWHlqkx/ZasS5Y5KpZygbybFE7k6chRfozEi2j0qklAU/+chvV8idA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlVKfq7XZJlFRPLXg/xOzjHL99COvj+eCBGPMg+ShBA=;
 b=QJRvWUTQbHwW5u1aV/YbaKHvbVB6v/t47H11AFZnvuzKTmiJ7zvsTsxYHT/yfKuBCZYlVMP440ud8kHwW5asC/tKpv+yFRpVxYz2lCED4TVMp3hquSZEKmYtoMnnhcpGMP2bvMZHivSXx8+95EYq7obOLCeaMn6sqRBtLmSCIXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::14)
 by DB9P193MB1340.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 28 May
 2025 08:03:19 +0000
Received: from AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18]) by AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 ([fe80::e973:de09:5df2:4e18%7]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 08:03:19 +0000
From: Axel Forsman <axfo@kvaser.com>
To: stable@vger.kernel.org
Cc: Axel Forsman <axfo@kvaser.com>,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12.y] can: kvaser_pciefd: Force IRQ edge in case of nested IRQ
Date: Wed, 28 May 2025 10:03:07 +0200
Message-ID: <20250528080307.130196-1-axfo@kvaser.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025052430-pettiness-opponent-56cd@gregkh>
References: <2025052430-pettiness-opponent-56cd@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B61.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:14) To AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:3ed::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P193MB1652:EE_|DB9P193MB1340:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d341ef-9ea1-4bc9-a9cd-08dd9dbe1bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gq32bAT2/pcQnuUDcdxmhjpPUeSCfE6NlYIIonTdzLQe/GAEpn2yXKb/M7tX?=
 =?us-ascii?Q?6NsNSXFLUDshMcl+l+bSyItXM3wGF1cd8cwNOqtugCcA6sP7nXcle/tDfTCL?=
 =?us-ascii?Q?RTNmotuRzYUV8OErLgZNRbodDKY7ISM+HuL1BoCWowZZKFUkMcjJdgzD3uZD?=
 =?us-ascii?Q?gIXgz74+UjhBlJdQB+7Ux/qYVLkl2t/YBtGQkzDFwAOLVmlXEiqG6WSn9/tW?=
 =?us-ascii?Q?DaErwCh0DmkF3Qzdl539ET9VyhYIWm5HRCEtdD1Iu9ZyTLEmTfFnKhEc8oOI?=
 =?us-ascii?Q?7zeR+1spuZLjd9aaN4BQavbWhO35iyxRCmvF+8yre/ff6LtyUxE11IZD0FCk?=
 =?us-ascii?Q?nLTE+m7JREVaz9SHWZwF2ShI+b39oddvxU6OKqjlsXNofzHXD7unJHeqI/5K?=
 =?us-ascii?Q?FRFZaVBdk4H+uk3gUkKCLMb8L54oopQZXLzpaTJ36H/RK8d5KAQpMGVvKbrB?=
 =?us-ascii?Q?IPxjrjtsiiVtFFKXeL0zNEMWqQv/jLcgsaX0iB8DRD0rb8o7NtxujYToTZy8?=
 =?us-ascii?Q?05jRZuZqnT6AldQhOJTxJK6hlT9r7f5l21gYAgaDzooDx6E8DQVxl8LzolY4?=
 =?us-ascii?Q?ycbW8gE0NoVE0JEYbLTvu2dHaq8z6mJ3KTZkr4hk260ZPB/9rrfrd9Vc/hpD?=
 =?us-ascii?Q?B/HalcRqatSVhUkfTzj7fbykLIiDkQiLszmA3OHIDlMp3HisBPL21GbQBl7w?=
 =?us-ascii?Q?jPLy5H3w6GtIcu+q/xhSXE5n73y7dJCcMZpl0pjgiLU96NS9AYRd1qOJSKKw?=
 =?us-ascii?Q?KVE1L9hPL1xak2hGkTaJq3AySYAvvUWGtMAh6RYZpuhuGBdXENPGgRa7gQ/T?=
 =?us-ascii?Q?yctu9E4ikaZLxId2Ed0Xzl/L4s73O+j/sGxKK7a+/4/Pum2uqzx08VM/qOpa?=
 =?us-ascii?Q?GSW/mEsOr8anuStKHOzj1MG/brtuXuWLNl2kHhZuOg2MUffFHt/oQR25AaN6?=
 =?us-ascii?Q?3sK2fPZXhaPycGZ4Xlij2xc8+QDUahH7x50CLZqGwyHHXJSpWh0YWk1UFS4Q?=
 =?us-ascii?Q?scnhToj79T2tqQWbeKoaMw+aLqpIBKopKuc0uazHr9jBHQpzOAUFw3p3ygxi?=
 =?us-ascii?Q?MPiWY7Frlvd+QiqcyzmmddedK69Wbf102coEIAgWm/dwUqL12msOX3Rtsl3s?=
 =?us-ascii?Q?UknyTPqCKOsKUNwm6I94BjsCOtzDRKBd7q4bCfOCIbnHsBsw7U5amQ2CToOC?=
 =?us-ascii?Q?IlmJ4XqsLOowMB8YuCFzvV7gTNCnl8REafiu3GRaK3mE581+Zw1sLhqY/VD2?=
 =?us-ascii?Q?d79rnWkwQpipiJPiH6K10aoln0xadvF3oPeXfY0j+s1KsS+2a9JSE+2Tk04l?=
 =?us-ascii?Q?78cJqAxrGhDuhM8Lxe+PqRhuF52iTm3h2FV0LFtzt99l5sl4MLxIx+rL1gf8?=
 =?us-ascii?Q?HMBRyXs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1652.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/xsBounv81PmADZMM3/YJ7QFdycn0JYmSwKQDzkHQN+tpq+MdNqSLEemCXrS?=
 =?us-ascii?Q?SawFp/dq11q05nOmI93KsqJAD9dSZDPdaxeLwUGnTb+abteQv90vzU1+ouU7?=
 =?us-ascii?Q?0gYNxCjUQM9Q35voqDWykWWEfXW57X4ohP+fqJ+Ixg2Lm33Ad7TBPHrw+z6v?=
 =?us-ascii?Q?lHQJqupDJjMpFkbsgwYr7MiT5aT7n+tSZkNaH+1lOftmws0fCmhr9T3DTYmY?=
 =?us-ascii?Q?wpM+WfqVf3VgjY/3XkAqnCvyfuSbU8EFqDBmLgXHlHvExERB23vKQuOqu9zN?=
 =?us-ascii?Q?ezZwlQ9z0J9oc1M71vhMuGYV4AOpjg6JQwljytNifXAP1O1kArX/zo/GDhW6?=
 =?us-ascii?Q?EkIEdWiwzXjEc1ie5zT7PXiX95j9GgvYKjuferMtQhsZ6UQrRx2TwFifWJd0?=
 =?us-ascii?Q?DEgXqX4yyueQUYZ4DbbI3A8niSjxymofaX1pNNBQ7kZpHHV8jHC3Ox4WpqCf?=
 =?us-ascii?Q?DfhXqnn88OqBYnJBJtZaFJE7caKVlCb4oNiJxcicThqC4Ac73EtaJHR3fw6y?=
 =?us-ascii?Q?uuKJZHAF7yvQ9MQeJJ5EC9rkzm4CdqBvpD9lIUu+xn+Z6f4IdLyCB5spEtQS?=
 =?us-ascii?Q?XQx8HT0ZdgKXHSRUJVULSa0Zc5hAircQf+Myw4MAVlvYwB7Ha7tZpMY0xZfi?=
 =?us-ascii?Q?9Uz8iNUJ5PgmaS8n56eaOUKfaQoY4dGOapcJPrcgvuHOuhn2S5WhOoGXr7tQ?=
 =?us-ascii?Q?u7tmWOsNuahN1RJr5vLvvpi0bdOOjWdeeSiRKSLqDlanMmwYS60fGERTC+4D?=
 =?us-ascii?Q?Txqi2PoFxcPD4mcyJqRt5yISnxwmhSL9uwasWOgidnGXojdMVztM308ooNps?=
 =?us-ascii?Q?BOzzpgyoritbVTu/aXTiqxPKwiCIo3vdy3SuCNoZDpQb1hJvcQG4JrFGwD1t?=
 =?us-ascii?Q?jwFqboflwk9ByPp0LMYmb3fF97HjySCz4Z7OiE2a2ndKxA8BkO/vlpFDkqPt?=
 =?us-ascii?Q?VJPyru4MGn8jTWGBA2ExqMGcF0k5BMmFcO5X1I6cQibnA1yjqU/RRbBjq9Rc?=
 =?us-ascii?Q?+LGXJ1qNKJHAuKV7a8c6uqqHMTJAaPpTegV4O0M3LZ8CHX2+MgocD/bUUXpn?=
 =?us-ascii?Q?qdh41cZuiTZifoVY2N9lavT2gWzSVkLKcl4o4dfxOGp3N+4Wm4vOgCdBo6oT?=
 =?us-ascii?Q?4eRjQLf8ZWTI/yJCF/B30rd2Flc9JbUsuBbJ7SlozxCNGZ+URunFLyrV83d9?=
 =?us-ascii?Q?VZM5sAVVj8hjYWtUFk5jABjFNTa8J1lkgzF2QvUHeK2yQKWxYWy9crtUkL6Z?=
 =?us-ascii?Q?/w8OxLrJ4Fdwp1i9NPkxhki/LQ+G3Cfc//APf4MxTinl5HR3K9n/xZXCLUdB?=
 =?us-ascii?Q?T0uQZJMWErXcXnjb5g7BzJrRBOZHI2+0rpbA6eOP2Hv7Efyx5XWRmAL6R30H?=
 =?us-ascii?Q?DTOviUmQknkhOg5Bs8H7j/VT1nt0LEEeNkLpatX/DqqxdB+oPbKS8n1NR/lR?=
 =?us-ascii?Q?6FRs+JVC826H+F5Fg87HGLwKPwSZEOt6r3Ton1Em2ctpkRDSR3vTzjj1hTSe?=
 =?us-ascii?Q?QT6N4spj1d11qnHe99aMQZlgh0rBWrsYkFHzsAO8ITf+RP/AFag8PZxTYxk1?=
 =?us-ascii?Q?HdmuULxOFtwD5Ag0+d1TL/cERvubEvhhRXUNj2+h?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d341ef-9ea1-4bc9-a9cd-08dd9dbe1bcb
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1652.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 08:03:19.3608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82XM/kUldcrMQ2F4s3enyu2qOoaz11jB50kvT6Nun+SSu4x/RYnMh8CzheGv197t/QEgl4fub2yHTcN4YOWW0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1340

Avoid the driver missing IRQs by temporarily masking IRQs in the ISR
to enforce an edge even if a different IRQ is signalled before handled
IRQs are cleared.

Fixes: 48f827d4f48f ("can: kvaser_pciefd: Move reset of DMA RX buffers to the end of the ISR")
Cc: stable@vger.kernel.org
Signed-off-by: Axel Forsman <axfo@kvaser.com>
Tested-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://patch.msgid.link/20250520114332.8961-2-axfo@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
(cherry picked from commit 9176bd205ee0b2cd35073a9973c2a0936bcb579e)
---
 drivers/net/can/kvaser_pciefd.c | 83 ++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index fee012b57f33..bd3622d4f6c7 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1643,24 +1643,28 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static u32 kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
+	void __iomem *srb_cmd_reg = KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG;
 	u32 irq = ioread32(KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		kvaser_pciefd_read_buffer(pcie, 0);
+	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
 
-	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD0) {
+		kvaser_pciefd_read_buffer(pcie, 0);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0, srb_cmd_reg); /* Rearm buffer */
+	}
+
+	if (irq & KVASER_PCIEFD_SRB_IRQ_DPD1) {
 		kvaser_pciefd_read_buffer(pcie, 1);
+		iowrite32(KVASER_PCIEFD_SRB_CMD_RDB1, srb_cmd_reg); /* Rearm buffer */
+	}
 
 	if (unlikely(irq & KVASER_PCIEFD_SRB_IRQ_DOF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DOF1 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF0 ||
 		     irq & KVASER_PCIEFD_SRB_IRQ_DUF1))
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
-
-	iowrite32(irq, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IRQ_REG);
-	return irq;
 }
 
 static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
@@ -1688,29 +1692,22 @@ static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
 	struct kvaser_pciefd *pcie = (struct kvaser_pciefd *)dev;
 	const struct kvaser_pciefd_irq_mask *irq_mask = pcie->driver_data->irq_mask;
 	u32 pci_irq = ioread32(KVASER_PCIEFD_PCI_IRQ_ADDR(pcie));
-	u32 srb_irq = 0;
-	u32 srb_release = 0;
 	int i;
 
 	if (!(pci_irq & irq_mask->all))
 		return IRQ_NONE;
 
+	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+
 	if (pci_irq & irq_mask->kcan_rx0)
-		srb_irq = kvaser_pciefd_receive_irq(pcie);
+		kvaser_pciefd_receive_irq(pcie);
 
 	for (i = 0; i < pcie->nr_channels; i++) {
 		if (pci_irq & irq_mask->kcan_tx[i])
 			kvaser_pciefd_transmit_irq(pcie->can[i]);
 	}
 
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD0)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB0;
-
-	if (srb_irq & KVASER_PCIEFD_SRB_IRQ_DPD1)
-		srb_release |= KVASER_PCIEFD_SRB_CMD_RDB1;
-
-	if (srb_release)
-		iowrite32(srb_release, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 
 	return IRQ_HANDLED;
 }
@@ -1730,13 +1727,22 @@ static void kvaser_pciefd_teardown_can_ctrls(struct kvaser_pciefd *pcie)
 	}
 }
 
+static void kvaser_pciefd_disable_irq_srcs(struct kvaser_pciefd *pcie)
+{
+	unsigned int i;
+
+	/* Masking PCI_IRQ is insufficient as running ISR will unmask it */
+	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
+	for (i = 0; i < pcie->nr_channels; ++i)
+		iowrite32(0, pcie->can[i]->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
+}
+
 static int kvaser_pciefd_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	int ret;
 	struct kvaser_pciefd *pcie;
 	const struct kvaser_pciefd_irq_mask *irq_mask;
-	void __iomem *irq_en_base;
 
 	pcie = devm_kzalloc(&pdev->dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -1802,8 +1808,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_IEN_REG);
 
 	/* Enable PCI interrupts */
-	irq_en_base = KVASER_PCIEFD_PCI_IEN_ADDR(pcie);
-	iowrite32(irq_mask->all, irq_en_base);
+	iowrite32(irq_mask->all, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
 	/* Ready the DMA buffers */
 	iowrite32(KVASER_PCIEFD_SRB_CMD_RDB0,
 		  KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CMD_REG);
@@ -1817,8 +1822,7 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return 0;
 
 err_free_irq:
-	/* Disable PCI interrupts */
-	iowrite32(0, irq_en_base);
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 
 err_pci_free_irq_vectors:
@@ -1841,35 +1845,26 @@ static int kvaser_pciefd_probe(struct pci_dev *pdev,
 	return ret;
 }
 
-static void kvaser_pciefd_remove_all_ctrls(struct kvaser_pciefd *pcie)
-{
-	int i;
-
-	for (i = 0; i < pcie->nr_channels; i++) {
-		struct kvaser_pciefd_can *can = pcie->can[i];
-
-		if (can) {
-			iowrite32(0, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-			unregister_candev(can->can.dev);
-			del_timer(&can->bec_poll_timer);
-			kvaser_pciefd_pwm_stop(can);
-			free_candev(can->can.dev);
-		}
-	}
-}
-
 static void kvaser_pciefd_remove(struct pci_dev *pdev)
 {
 	struct kvaser_pciefd *pcie = pci_get_drvdata(pdev);
+	unsigned int i;
 
-	kvaser_pciefd_remove_all_ctrls(pcie);
+	for (i = 0; i < pcie->nr_channels; ++i) {
+		struct kvaser_pciefd_can *can = pcie->can[i];
 
-	/* Disable interrupts */
-	iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_REG);
-	iowrite32(0, KVASER_PCIEFD_PCI_IEN_ADDR(pcie));
+		unregister_candev(can->can.dev);
+		del_timer(&can->bec_poll_timer);
+		kvaser_pciefd_pwm_stop(can);
+	}
 
+	kvaser_pciefd_disable_irq_srcs(pcie);
 	free_irq(pcie->pci->irq, pcie);
 	pci_free_irq_vectors(pcie->pci);
+
+	for (i = 0; i < pcie->nr_channels; ++i)
+		free_candev(pcie->can[i]->can.dev);
+
 	pci_iounmap(pdev, pcie->reg_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.49.0


