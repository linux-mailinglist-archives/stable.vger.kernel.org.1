Return-Path: <stable+bounces-233813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE/bBm4J1mnbAQgAu9opvQ
	(envelope-from <stable+bounces-233813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:53:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 817DB3B897A
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 09:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11C3B300CFED
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D37B396D39;
	Wed,  8 Apr 2026 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F66bdGeT"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012048.outbound.protection.outlook.com [40.93.195.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEE396B6B
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634719; cv=fail; b=pOAlm6GCzudfBNo091l39k31bJHMrj4ERLoQn5Ddbdb883eloKZGu4wwnfQiIboJwPp7cd2VAfmEnIbMlejaPE0GXV+L4J2BGQ6FIIMGwaAGgJuN4Zzfve2ZM6nUMqtLQR4bV4RGU1JctJWVLjNlb0aZYonsJnlNLcTwlosHv04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634719; c=relaxed/simple;
	bh=gXiEuw2VN+PLjtTw1+x7Y7UrHS+Ul64cWsUrdQlExfo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z8KKRjhUBKck7cfEoBl/YR86TzHDwYR4uAF+Wewn/cblwqjBEpWhOusBPghmVdWTRFZGkllByH6OABqf6yS9lKCFjVFrKdZSq8OP/PhoZxnd5x/CfdY3LDL7Kjlrkl82MqSV1oy1CdhwZ8dh9BJulYoIM/ksI9Xzz5xpRmrjgcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F66bdGeT; arc=fail smtp.client-ip=40.93.195.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBRpxORFhxKFV66JYG5Qvj19l39HgVaGsWG9h093Kt+nS+Jj7uhVzTWgykivnrRf/7OqediZiQWGIsH9MablMgrjIjM/vzlnMsCVvym2VAmKB/hQ190aLe/wAcu38KfPOn632NqrzWXljFuH28CijHjvrTGc54NadvMwVWApJ0wLXk+yf8079lXgJ8MewcZ3O7kXVsUWsK4EZwWW6lraPL0TY+BRV0wd+tnhgz1WTVmKynMLUpJr5UmJzQtvcN2cDyjiKIFroRpgyVBLCOrgUFbK8Nd/rZOcVdAublprYO7TjxS4kyY5QpdDLWBd781+VWrTVDS9RPNrfQtNG23RZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yon33QPKyaBEXFdYhgOzMB9lLxoWGdjHx7l0oGo62N8=;
 b=H4PDlk+fM9rPmEDRgdiys77FksJXn/NEmonxWAsxC1Fn3KKvOg88KaH4/rR8tuUIsmuicHz0hSBRN6jvdRkipcxult8MQQV8NQJ6uALr0YrYnkQRHfU7aMA5Dcp+yHU3vwovVu7eLOYswCQNkWtfguMvBTtnv24N+jpJ+NWUAAjLeUKD+jG1kOHfNTzTR5M9u0h2LceCeU/ulNuuI+QL/oX/GCdVcpkyfOpAX8oFR5rIGLOmB4PHvSM8YkKv6mj9Okc8h2Ml0NJB1lNiUDhbu+PQcVQcx0YUOItp/AbEYSQ9s42Nk630OHRL363zgi6J05cDRU1BCUuSVJVnrVZosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=syr.edu smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yon33QPKyaBEXFdYhgOzMB9lLxoWGdjHx7l0oGo62N8=;
 b=F66bdGeTJdf3XJoY4K4HWplJGgqqWiC8aiRQPnkE8vwj5IJjPzZX4gKWUEh5zb2cUT0wcZy3q59lib6gYALsro+o4SZ5i8jy08HVbV2J60puPyFpcdczHwKyPNhxIu8X71qCP8N6GwgZejqSeXWHQwa2QyaeuZe0yrVqFOq553STKss7bhSMVPeT5cbPPIMLbxOB2JqIAeanmSXHeLfoFExAqCSEK3Uh/8ZGX6jJrF6oBaP+qsnccFlyGi9/Ddb1a4T44YoY+TdGqo73HGq43xJBMZNAk2yOu4YTGHr3SIXHe60wpBr1StwbAEko/Uqx3fRGJhyXZ3h8m3AwO0loMA==
Received: from CH0PR03CA0331.namprd03.prod.outlook.com (2603:10b6:610:11a::22)
 by SA1PR12MB999227.namprd12.prod.outlook.com (2603:10b6:806:4de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 07:51:53 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::e) by CH0PR03CA0331.outlook.office365.com
 (2603:10b6:610:11a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 07:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 07:51:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 00:51:40 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 00:51:39 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <skumar47@syr.edu>
CC: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
	<kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Wed, 8 Apr 2026 00:51:31 -0700
Message-ID: <20260408075131.6221-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SA1PR12MB999227:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f8b925-2f27-4093-a200-08de9543b31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	NnNEUh4cZ+rjTZ/mSs81MF7UE9GrWTzLyxtD6jGniCEBMrui9iZXs0IyPbDvjgxSTs4dxwz7HSp0waCrL6VAJ3SqA94CmLBfR6O66LtTdzsmSRhj8/Bxb4AN/VpBjsucL5xp7XBX9BBBrNTE7KmnvfycG2d70tlYi1WQdsA4pq8gKCYGhZH2RWs6mojDKvPMeHB1ijQ2txbFGOQkryop0t6locHB2R9gbTsIr/55Koj/JE+P9+VK0MKW1vzybUZBTRHCXI1z3XnTl1TWuQ6wGqCb1FUWSfAp+tF+EP0t0fAELzQABbubT8QTQMS6OzyjNwY+EfFoVu3Nnbawp1nZ2914TDF97CXezASw8/fLpPkz5Q5wpm7bABrVvBgZUUzSSGfYMTKLZfsTT8cgx6+gj8s9Pd3I7PW90o5koYSJQeQEEg2BsgbJ2YCk9zYEfMA6JMhGs1fTST01U6cCKraf2Al3jFOxNsqdWbZDjfHNRhf+OUhz68+YmZMMF6Qec6VVdEtsAvKkhElsDordY3AHnR8G8Fqb0Sz6L7e7XXTXxCHoM2yHmxsJBK16gVhW8qefeNX33lN1GtVI6jCq0wf611/3BASl1nZXq4+u4pTZsS11AmVH/tw+6t8OosadAXTaH4aUA71PMgapCj2eZf0CblBURQTChgiDdtuFoLUzXAwGgatESBIdVAvhYqa0JpcVgnWLMW8zehtNMS/CMINtPYpsbnsAslQoEV5VYnb5jFuSfo9d2gG7frynppPlVRLZXpcaUG/N3CFD8xwjgMfQew==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fVvA7GuNr478hI1ueJKjGXSGK3M0RL6+AEb6Yfw42D8w6vea9OeGHRBx5/+W9JVEZ3wxBZBGlHi7Gx8IkVCWxln9G0rpQbQ9dkQ2/+7FGC8NKYnaPFd2WYgfuq92T4/erpmiST1rrlvDuqMMh3yaFnhRj/MMgw0ODzt2xP2mSGarcXpTqREapu6HMvcFcqX97UMXWhuaHLqiKxT2gjGZPGrZ1Xxw5OUd0URmtHHAVnGQopq5ihE/7wYKPaONfgQ/cpsdvcugEpMsBjTzFQvyZmliXtm/HMiS9IcDvQlVHODSKIrcf14XNefT/H3W7Xjb0e9EXK0mB5plJ0xKebn7cPZdGTfudWbx+e8gLUI9Vt+EEA+ef6X6U/GsRlqPuYIYbAz11FqxOU4BlBGJXk5bW2yE2tvGT3f4buHp7g/LoSR5pYVq++IqJil4mZUAB8lX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 07:51:53.1802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f8b925-2f27-4093-a200-08de9543b31a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999227
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233813-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kch@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syr.edu:email];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 817DB3B897A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nvmet_tcp_handle_icreq() updates queue->state after sending an
Initialization Connection Response (ICResp), but it does so without
serializing against target-side queue teardown.

If an NVMe/TCP host sends an Initialization Connection Request
(ICReq) and immediately closes the connection, target-side teardown
may start in softirq context before io_work drains the already
buffered ICReq. In that case, nvmet_tcp_schedule_release_queue()
sets queue->state to NVMET_TCP_Q_DISCONNECTING and drops the queue
reference under state_lock.

If io_work later processes that ICReq, nvmet_tcp_handle_icreq() can
still overwrite the state back to NVMET_TCP_Q_LIVE. That defeats the
DISCONNECTING-state guard in nvmet_tcp_schedule_release_queue() and
allows a later socket state change to re-enter teardown and issue a
second kref_put() on an already released queue.

The ICResp send failure path has the same problem. If teardown has
already moved the queue to DISCONNECTING, a send error can still
overwrite the state with NVMET_TCP_Q_FAILED, again reopening the
window for a second teardown path to drop the queue reference.

Fix this by serializing both post-send state transitions with
state_lock and bailing out if teardown has already started.

Use -ESHUTDOWN as an internal sentinel for that bail-out path rather
than propagating it as a transport error like -ECONNRESET. Keep
nvmet_tcp_socket_error() setting rcv_state to NVMET_TCP_RECV_ERR before
honoring that sentinel so receive-side parsing stays quiesced until the
existing release path completes.

Reported-by: Shivam Kumar <skumar47@syr.edu>
Fixes: c46a6465bac2 ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

Hi Shivam,

This patch is different than the one I posted.

Posted patch :-


		iov.iov_len = sizeof(*icresp);
		ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
		if (ret < 0) {
	-		queue->state = NVMET_TCP_Q_FAILED;
	+		spin_lock_bh(&queue->state_lock);
	+		if (queue->state != NVMET_TCP_Q_DISCONNECTING)
	+			queue->state = NVMET_TCP_Q_FAILED;
	+		spin_unlock_bh(&queue->state_lock);
			return ret; /* queue removal will cleanup */
		}

This patch :-

		iov.iov_len = sizeof(*icresp);
		ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
		if (ret < 0) {
	+		spin_lock_bh(&queue->state_lock);
	+		if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
	+			spin_unlock_bh(&queue->state_lock);
	+			return -ESHUTDOWN;
	+		}
			queue->state = NVMET_TCP_Q_FAILED;
	+		spin_unlock_bh(&queue->state_lock);
			return ret; /* queue removal will cleanup */
		}

It will be great if you can provide tested-by tag on this patch
so we can merge this fix as well.

-ck

---
 drivers/nvme/target/tcp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 69e971b179ae..98b2ce9a70ca 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -407,7 +407,22 @@ static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 {
+	/*
+	 * Keep rcv_state at RECV_ERR even for the internal -ESHUTDOWN path.
+	 * nvmet_tcp_handle_icreq() can return -ESHUTDOWN after the ICReq has
+	 * already been consumed and queue teardown has started.
+	 *
+	 * If nvmet_tcp_data_ready() or nvmet_tcp_write_space() queues
+	 * nvmet_tcp_io_work() again before nvmet_tcp_release_queue_work()
+	 * cancels it, the queue must not keep that old receive state.
+	 * Otherwise the next nvmet_tcp_io_work() run can reach
+	 * nvmet_tcp_done_recv_pdu() and try to handle the same ICReq again.
+	 *
+	 * That is why queue->rcv_state needs to be updated before we return.
+	 */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
+	if (status == -ESHUTDOWN)
+		return;
 	if (status == -EPIPE || status == -ECONNRESET)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
@@ -922,11 +937,24 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	iov.iov_len = sizeof(*icresp);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
 	if (ret < 0) {
+		spin_lock_bh(&queue->state_lock);
+		if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
+			spin_unlock_bh(&queue->state_lock);
+			return -ESHUTDOWN;
+		}
 		queue->state = NVMET_TCP_Q_FAILED;
+		spin_unlock_bh(&queue->state_lock);
 		return ret; /* queue removal will cleanup */
 	}
 
+	spin_lock_bh(&queue->state_lock);
+	if (queue->state == NVMET_TCP_Q_DISCONNECTING) {
+		spin_unlock_bh(&queue->state_lock);
+		/* Tell nvmet_tcp_socket_error() teardown is already in progress. */
+		return -ESHUTDOWN;
+	}
 	queue->state = NVMET_TCP_Q_LIVE;
+	spin_unlock_bh(&queue->state_lock);
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
 }
-- 
2.39.5


