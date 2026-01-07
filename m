Return-Path: <stable+bounces-206091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73269CFBF01
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 05:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 348383060268
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 04:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F01240611;
	Wed,  7 Jan 2026 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gUihwRIX"
X-Original-To: stable@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021136.outbound.protection.outlook.com [40.107.74.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A581522FDE6;
	Wed,  7 Jan 2026 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767759907; cv=fail; b=REByMmS9r079GdHCpshjbIHW2d1ZFIupjhVUJR+5nKs/dAx4GoRmqC4O4tNOhJv9Aq6/FK1Dcs4XQN/AixinIzV0RwyxU4i7EqMqX9qNlg2b/T/3solPm1xGXhUppJoLQz8d+IpnsOju93oihC0xXQONzi28h8yt0hoEi7eFdBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767759907; c=relaxed/simple;
	bh=Kcfa4j9t1NWpgPyTnT/ThRjhRyDXhRSWS9RWKWfS7KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWvlzCaf+4RruUktE5n6EvDYGtsdoAZ11jiVIG366cKX2SX/q829ydDluyCiw3M17kcZZAj9gtvLki7hMljT5cJxyuOVmg7olsYkpCdwC2Id3BmTxC/JwXO2UM35we6mNx6Xtj6hjKJCsxtcs0TulQYIYjKr+EZVfEr2Pa4LEGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gUihwRIX; arc=fail smtp.client-ip=40.107.74.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tE9dhkX+A0OJwi08hlPtUB8jEhw2gxzZEWl/3eHm3m1ob7knsFBDQgnQy+ig7nPs4HqqUhCgGaYD94fVrlBz4z3CuaFWvg1q69UYX8ITqs+wtLQAq66AoIOSL2V4ifulEGHa+uQiP+Wl7bSaCGCvgB/8snGNCBbW85F20Kg1RuOPrV8Ye0hjn2tERUDvaHWYMY+GyzfN3HSxd5fy856vCsfsAw1u8z97CNNtnZfb9oS53LMf4KlMQ8qf9ncNCmiMbW80jO6DFcEPtxM9+dv3aZGDn4R6nCl8xISna1Pcr6y97FJfgT3EJ2g8AiIgHN+RZ/7bLxyJyDRbPdtq00j5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/nnRjRPyIqJYccz+i/gk2YHh3A46yHOJYlQfUHQn64=;
 b=ZeJRs7V2L8jRO92c6RfeTXW5HVdfniT5FpV6HKaeUGYNyTop5GKX9aL0SNRY5xbjjO5M0/0hAFOZRnOE0PwvznVAO727GUNPZKZhEhWmBIc5U27owQhMbWE11qpZYeueKkdqVsVEmqsYCv/3irDSTAbxbWDScBEdvXhNnQviiBZNBkhnAW8/MM/GPi3tH1sc2JGLMXmvEykJLprI2FNEMnGvFTLJTBwPrHvBYdmnOJ0Q5govXtQ00ydaUwRmFWbbi7Ccsg7bAhLJaqEvxzWwtPoE+n/wJdqddsUBtory3l0oFt0c6JUWTrZ05wseCrmgw/QRuUULF3C97dCVpGfpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/nnRjRPyIqJYccz+i/gk2YHh3A46yHOJYlQfUHQn64=;
 b=gUihwRIXbOT6axQzNDvrijeFYTuJcprh/isgnTFahBlts+IHUZ8PihoFwS/hNr0WqxJ84dvWCxcUKwuEE19AKKyOSGtryuJ58IhNvtOkMFkE5OtDAc/nIzyiqIE5bBe3MPL4755ZLqrHnHdJyF3fRTnFIzhM46XPIYYxjyknifw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6892.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 04:25:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 04:25:02 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Frank.Li@nxp.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] NTB: ntb_transport: Fix too small buffer for debugfs_name
Date: Wed,  7 Jan 2026 13:24:57 +0900
Message-ID: <20260107042458.1987818-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260107042458.1987818-1-den@valinux.co.jp>
References: <20260107042458.1987818-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0063.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: f88cb822-7b21-4052-f5db-08de4da4b9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?njkH/ef4o+MM8D8poSktLNhMVNgxLS9u5SY5QnYrj6xfk/5k05DvQ+4DhNZO?=
 =?us-ascii?Q?G230CsIJIBdMC7x0qGk11cFMYu3ahgZX59TYBXltaBhUNPWh6/3gV5/N9ZHw?=
 =?us-ascii?Q?N6ql8QJxt56HrNuLQFUoRopcyn2o4LA0x+a9l+RnKcHa5zS2Fdklw4MuTJD8?=
 =?us-ascii?Q?Jvh7O2DPq8twGg/1AhkoT7/2TRFUjUyX165NfevKQ9oB12mqi11ZEDu0moc8?=
 =?us-ascii?Q?HUvX6s84aNyZ8Dce7zUYw/FT2V2mdOTChynP9nxh+1owBwhgzu/uJayK12KQ?=
 =?us-ascii?Q?wrh+At8NfOBuSH6yyu/v0/Yji3ncmzKGziFCk0BMB6xCX9J+G+qcm0KcMfcf?=
 =?us-ascii?Q?erujzPIXl+7zNgjWUl5MCko/vgFOUQz39WXUNJ0Y8/i/hwJUu+/5pmH2NlAA?=
 =?us-ascii?Q?YiMt8jlZEda1uYdoThYq0hn3Sv0S+nGL9oLl4OTpHXC/zfpnDOi7O4EtAHXP?=
 =?us-ascii?Q?Z29AGHDHA74A+BFbroALe+U7Yc6AVyqrrUZeaj7lxh3QGGtzdCVywUcdhtrW?=
 =?us-ascii?Q?9NlaNkqYgkcsWcOEGUUS90tOsfnJTGFN4OZp/UB2qBYzxiAG6MndJYeHoc2l?=
 =?us-ascii?Q?8StI10PP2ZlfLuIn9wkQcHDsWbJtmhS8JaOq7C4FDZgpK3VOWTDbLndz2c8w?=
 =?us-ascii?Q?/9ioEoz45cBfKvvaL3IyybXqsyuAFuX9B6D1djEc82WbAE6DU9CMlY5L4zZ2?=
 =?us-ascii?Q?swXHvHJleuZ6MqnTo/FqWEqMgZceLRr7e1AJp2NsZ68Sks+Jt+KbnIEvYioQ?=
 =?us-ascii?Q?yqK6jyWWTcjRcf3XclwHDCpZUewTbFMoS2LECAwG8yuZDynOsX8Pqv5NfJln?=
 =?us-ascii?Q?wlzw7fkn3/Wo9gWwRoODfujVEZ/tcLCkRk6oKzAaxG5SchJVXsvG/iscXDxr?=
 =?us-ascii?Q?6hfriH7paqK6QzEqRyeEVLG8E5ZzVezep8sTjvmrMjz/7cSsdRoFipc/oRet?=
 =?us-ascii?Q?LEDQZAYTZogD8PrsgSBr6ofS8hXFGyJBaOleXhFkbJ5ZfTJi+GCcA09UDGPv?=
 =?us-ascii?Q?zirOzfLTszH0OditMvVYj2Hg1QA6v/kB71j6onOSo2oCSZWWN7QoDR0S74oD?=
 =?us-ascii?Q?Z0yip95CwRCn2cIkmfSb2BUBn+sE6/JjiHqN5/+RCNDfJfCDYHT+eLSUjc7A?=
 =?us-ascii?Q?F+ObU6qsfjGqJA0N8zxMWPODIvbkdjqdpwvuCPcL6ghLNDK9ZEyfWIMXEHyw?=
 =?us-ascii?Q?+RPoTYI3OVpcemyBvfVA6dpv8Grdm/6SlVj6npm9mS4jq7vDk+etYH63OK8R?=
 =?us-ascii?Q?wOHZ7fDL8dW88hKLZIine307G2SZcyIm90bsC63oxbLi8g1Q5gps6WkZU/g2?=
 =?us-ascii?Q?0HOmO2abhogyQayhJoEh60pAwnYfOIbC6GlZKoXpbIbOryfWBOQoVykVgbJd?=
 =?us-ascii?Q?0i1xGEmIdByxy0dXh3b5r6dT9TfPDX9aH0bd72f+R0OFvOBUhwpDiCbCnqOy?=
 =?us-ascii?Q?QDO+CtZqD/0ndx0fO96p7beGp1EuUTE9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wWZuoBbJIB4JyZ4Una5QtSctPV881ESTOLFxitYt6W0j8r48j8Oqy14oUAiY?=
 =?us-ascii?Q?jHC1kY0NMXxMrrcIZJ9rzMSWKZRBYzuJVn/UIKGlcSruxfF4H2QoT3qyJzCn?=
 =?us-ascii?Q?/aAgH7eVS39ftY/Rf4SP1XL92JGVn+J9UVFMwGCZRSzuZxMmg/Pv0oWVj+6R?=
 =?us-ascii?Q?0lF+iYXPcF0mOHxEOsQ2hafGtpG6+V+efIw3Mdw5owrHt54WYadpvxSu75l7?=
 =?us-ascii?Q?HR5Mhhlpr+ZvkwydvK3HZKig0wyMUvI0oOkLPhOTtq6XhRnh+N2cWRsw1l/q?=
 =?us-ascii?Q?qfcIfs43YsLShSN2f6kHKcB870sKHMXDC5thM/cud5+h2utJcjfa8UG6G5oD?=
 =?us-ascii?Q?3NcUvPH3a/5aAGL1C34+6HYBTxOX9eqCD5EoiDcacrkw/xEMvf9qRDMzsJWY?=
 =?us-ascii?Q?bOPj95XeT0Ci5sv5vXWfFPASqUodZQADVpYDmrox1BtyCGzAqTNZ0f0qBwgH?=
 =?us-ascii?Q?+e6JctP00/1iA+N3/ix8U1omfT0jKfAWwvyb01UYTAjscL9zDosiePy9hjx2?=
 =?us-ascii?Q?pvou5Lyf92/cGeLWvvz20IcUy8+z0IQmrlAHW8C+cEnVpa/eyLNyp7gtfzV7?=
 =?us-ascii?Q?CTwv0TcnIRa88230U7Vn65RI5mYkUca1LK3+vn1d0hcKUAuJiXSzwsM+U04n?=
 =?us-ascii?Q?YKsnU+eCS9OyF7ilehv121SLWRRQpLha/ghhbrnp7OKpCkUCT4/Juy0Ay1rE?=
 =?us-ascii?Q?ISPe0Vmghmp2IVSPFl3vzIxPk3zqQ07j36sXjN+CVxsigAx2ZWuhCq9oqsMv?=
 =?us-ascii?Q?kNdmnKUok/rK3uS3bs+2pItnGfKykkWhkNRvuQspqY6CzKIQPE7H3JBR4XQ2?=
 =?us-ascii?Q?unQ/vpP33M4XmI8dusEtxGYXQwkmRft5IItYHYKE4l80OV3YpL9OMN1W4oLp?=
 =?us-ascii?Q?RHH/1oMIvS2tDxuXJHdDfp5SsqR0ZaD3jkcr32qvX8me5im/oWzWAxnQB1Cq?=
 =?us-ascii?Q?NRk+uc3xFCUkcZv6/CKFoEYpwsnyMt/c1UglzuSJKrGwE9xyD+r1yzyMkNru?=
 =?us-ascii?Q?ia3tLAl5bt641HZ/SKRa8hGB13myol8rBgMhrIJaW9N2bUaXdZjhQQHtfzDv?=
 =?us-ascii?Q?vVUbp8zKspR4SC/P6j3Xc61VCr+pqbZegGqsRIy+2LunIh2JJzOdG3JhTRZl?=
 =?us-ascii?Q?3/abhs5QRLsK3T8AcI7x3qDXG+r41dqAPuR7cLzusaIWCQvlSsGb6ryjFeAh?=
 =?us-ascii?Q?4yFmL/CMVX7rSU6xcDphXFe5Cg0HYZ+KhfX4/bA38cqD2nYA1jbiaGhSWNL0?=
 =?us-ascii?Q?ItffExkeaqnxZqMYmnMDJtOoFy9ZEAOBC++WtJYdh/eYmwbSz/afVVkV6kms?=
 =?us-ascii?Q?28X/+Lj/SWg5V4umDTyjWhM/PU35fC4J//axejAQboLpOdHO2cc8OSH43fmQ?=
 =?us-ascii?Q?u+hldA/aSAuyfcmwPcY5r8oUP55dbHum3DJQoX7luRVkouLRAXpgE8mt+nkc?=
 =?us-ascii?Q?laKKs0yL9lJLzdYU/KTDLu/l5aAWWdvsBvvMWSpShmASpW7k+K3y3HJGSXGw?=
 =?us-ascii?Q?WzdHk3zuV1Gqb+QvJuAuDQoFzRNWsh58tJXlVTqUF0c0lrF9QAJOfyq8Qgfq?=
 =?us-ascii?Q?7f5/KGMqXJGzr2EDTPK207gMY5qTz7qSVinmDGSjE1jUtdR8NJujaBy62UyX?=
 =?us-ascii?Q?TSS0gB6CHGhaXoYHiWYu3AlPLIQS60+3Iq/Jwp9P6gLNgbO1UeyCAw/nyABA?=
 =?us-ascii?Q?YFTICk8KtA2I7ydsZ3ioQVeRuzpIxHou5jkr5a2gRUAiRCAsFAk0EXG9hH1t?=
 =?us-ascii?Q?VWhVyGF7b9tGi6lIXIV/M6f9kIy27ykL7IIfymcb2uLhetGXwTpA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f88cb822-7b21-4052-f5db-08de4da4b9c8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 04:25:02.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12gGP695dcaqykaZKFyMzrFSDauBRe6ReyNHSOmNCG3cFsiu7C14+Wuz6OFHec7Y8RhuIXjjWeTS/BRzVOgowg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6892

The buffer used for "qp%d" was only 4 bytes, which truncates names like
"qp10" to "qp1" and causes multiple queues to share the same directory.

Enlarge the buffer and use sizeof() to avoid truncation.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: <stable@vger.kernel.org> # v3.9+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3..857c845bfbe8 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1236,9 +1236,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
 	if (nt->debugfs_node_dir) {
-		char debugfs_name[4];
+		char debugfs_name[8];
 
-		snprintf(debugfs_name, 4, "qp%d", qp_num);
+		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
 						     nt->debugfs_node_dir);
 
-- 
2.51.0


