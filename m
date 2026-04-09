Return-Path: <stable+bounces-235289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Q8KL5351mnsKQgAu9opvQ
	(envelope-from <stable+bounces-235289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 02:58:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F373C51FF
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 02:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84FE63009E1B
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 00:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26829221F39;
	Thu,  9 Apr 2026 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RdrOr6rt"
X-Original-To: stable@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC422BB13
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775696277; cv=fail; b=OTr7vXZP7lT90BbDGjLvSiOZR29iV9b2+kliIBsfF7CI6+rCHmogg5tMvdLxGTEWDdimzKNsHTu9BdvxLY/tuOpJMV/QIIqhV1l6sqHWV0O7zPGf60Xxecqhvu7+z+8bf4LXXfWnNzNqgBYmDr+gdhIMC3UCEKZUhFvvJae6NBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775696277; c=relaxed/simple;
	bh=gecLzW3hJb6l+61svuRo6WwXiR6wSvnDDvGnGTmuzLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m/kk+va4yb58CIQ/JKQXmovQrR8YdFl10YdnZKMYP3LInqSZVJyR05am+2a83uyzfV167I09/ybV/Za+34J8W3sVZH9a+PHUnnh/YKOLST1dOEfKVO+1hjdGrBhQSs+dYT/2suKD4nS97+4NDmT3+yev8vl+yifWtEWVs0uBY2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RdrOr6rt; arc=fail smtp.client-ip=52.101.56.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rG4eInXp8sLECfvwehEE/QL1iUMdRuzd5zCZVwkUcoj7w9mtr3XDgZ3fh8Uay28rUWQcdxZmI+Go7RebMvuMIeU8Nm+FmJUs+EqHMFickwyCFAOK4xjDaeuAunr4mpHeWu6UwCfA8mxIA8G6og3AXzN9U+oqRsCqfZWe8eceHUs+0fUsLhx+2/V8Do3/WB0gpREWroEqv72odPP7R/WUiQ3VKRopCBFrbM6FaX+Lpfw644xJ6wjaNMnfKhJ5Wq6dbF4z4CdXPp7/+SnNd32+trAo2Uzdt+8ppALOi2WZn/He3vbPOY2zohL7avja9Gq7ccvK8pJVRBKy5TqmvdP5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFuWgQ5iTxj35Dos/5prPpRhiQyObWv5yXsyjrcwOlk=;
 b=Y9kUsRG0NFR1RjbYO5a5PYszxMpTNDvDz3J7yB+bdzFleWRtLAct3bWqpKQeSxd0Mu5qHuXqNyLxb6lCzH4Dq/2wbx3Shd1x/4+wwhRaYMr/mOvXIj6USYqa2yVfjkZCPpsFJbKf8JMmBQJa9U2TEVPdoO3flG9crj4qtyWSykOB9wwTv7knuIfk1tnKP1kvMBYoUHwIlb9Z87KI9Yuw+JSczMpKeL0YMS4V8rwUSgfurwYmvMIj/Bx0WB4cTFy+lYcwRAYixCoJPLO798NpoTYVOJabHmETwIl61KcICZgIqixCujanvl3GeH4XkWLqyFUc6ZxSEgjTk7Khc0FCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFuWgQ5iTxj35Dos/5prPpRhiQyObWv5yXsyjrcwOlk=;
 b=RdrOr6rtZxYBUGi6j4xrBRvMFoMKk9Uf1ojowDPts1SUKi8v0r4+JutSsL8cGAzp0ezXFgkOx4/n8TNjFneTSxzlesgDKFBsUcGmXyjNxeMaBB4yB7rAwiDPBI+eww4HS2LMyxefgbyhOB6+E3OLuzORIkNdVxuEVkxFLsRT2DDd6NBa9cjCJjdumZBp+qwGmW1toeZ6p0Pkz+U7AACyyD+SCa5xXJLVKE4dUT88NLNNDGJ3RzbLz1Iz582gd84ZXrtgjgTFFxK4WvX/K974MQpSgtlxxxt6OnFQQVJRZltCZCHYUrchdgTzR1IYkz4lwodmiDUZlldfzstx7/kCtQ==
Received: from SJ0PR03CA0286.namprd03.prod.outlook.com (2603:10b6:a03:39e::21)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 00:57:49 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::21) by SJ0PR03CA0286.outlook.office365.com
 (2603:10b6:a03:39e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 00:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 00:57:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 17:57:32 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Apr
 2026 17:57:31 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <roys@lightbitslabs.com>,
	<kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free
Date: Wed, 8 Apr 2026 17:56:47 -0700
Message-ID: <20260409005647.112289-1-kch@nvidia.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: ae892c10-867c-4657-ace1-08de95d30547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Zi229WM+3tLF484KKZESlhjIjwMZDlQ7Fu8fNYO/e9ZwtPyuX5zhA3Yvlqj8phruKvCKYIcQYToyNevWVTpxge2B7dVdAt1DyQf6PxaXpqTf2edDnJi1M8s0u8LxfXExSExT2Z3z8gpevLcfA1vEH+DyAK6sze+reAIgETIaSoasqCr8VX80R5SgyuiOd9BMBloT9Rw9jkuHDL66Dpd5bIEp0Ba1DRrIvktrSvZ9/WWoKTgK/U4/2e1iuk5Ga6Avis/A5WrWybsfhb6Xd6OoDRLhtJqFenGOOuNGAOLUznf5cNX2mRA3nHJAalQLOmY32gUaM0q+OeXbtKx/VenF5TFj6KukKxE+tYiGAc3LQas8zD1CM6Qyt/yGTBu6jxAmptxbLtMgg6eZXND3CJ7vLIzSHo19vLDDF6Mn0SP3jsiNDFgvXTnqibX25ogZLKhtvw8UYl65Lw2VK/f5AsiGEOdNw1u+lxgQCwhb0Io6otJPBgNkv1++3zxRd7TtK/rVXo7sUboPMy2wDmFNHiv6eZELHKACqDeFXJKeo1uvRDLdJXtEo2mbetCpclzTP6Bk5u1BI+saIgE3RIeCmZXII9zch8jjlcUWA+FKjfDUaHeaGZ+JOf5eXsdHN7lg01i3D7atmX92E1TLC93OubcTzAR2LydOaVyYthxvtf58QBbxSOeAQsGntoi4xr6p5idzA/N/okyCsEHoHn4T0TjBEiwsozCpodAiva3dp0QYu8oG4FuPZ+K9QDYLewNFF1Jb+zaKHAcqYVfaYOvJZ4bugA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C7b/qUuMQZCIAslRxA0o83EdOzaOZPAfr7wqkjAzIpGqK9+Ga+zLw1C8OwzDA7hD6ocyeMByN0b6kR0mDKueJGuuAoU6uEGWbLPB/sJXhBViVPLgj3gyqAZPZCEdhKXXJXi11Nb7ay3mMhBkOUtvgWMuI17+35bvIWThqIPoeikzpgaiFY3JqYmnB8s2XtcsY+D9YoT2rT0WVJXEotKF9PAJ6rNK6BJJSbYAiXGd8roS11H5ztM4Ni0jLRWstr6+6ic9lx4Siz0HgLGunhHI8ZWP25b7iM4FTlmCB4Ck08uPhysTJyNC5B0esHL2WpvWvPS0FN7lfuzKvIprfqjfzj9zs3snSFbAC7A8fr8ato/0qpPsBkBB4Lnrbbxg5qZMbEpnqfrR+ja08eKE31PAjp9z84lJwPErlycFMOezAq9E2RhHNFWPKcn+x4EdY7OG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 00:57:49.1083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae892c10-867c-4657-ace1-08de95d30547
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235289-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kch@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,qemu.org:url];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B5F373C51FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nvmet_tcp_release_queue_work() runs on nvmet-wq and can drop the
final controller reference through nvmet_cq_put(). If that triggers
nvmet_ctrl_free(), the teardown path flushes ctrl->async_event_work on
the same nvmet-wq.

Call chain:

 nvmet_tcp_schedule_release_queue()
   kref_put(&queue->kref, nvmet_tcp_release_queue)
     nvmet_tcp_release_queue()
       queue_work(nvmet_wq, &queue->release_work) <--- nvmet_wq
         process_one_work()
           nvmet_tcp_release_queue_work()
             nvmet_cq_put(&queue->nvme_cq)
               nvmet_cq_destroy()
                 nvmet_ctrl_put(cq->ctrl)
                   nvmet_ctrl_free()
                     flush_work(&ctrl->async_event_work) <--- nvmet_wq

                      Previously Scheduled by :-
		        nvmet_add_async_event
		          queue_work(nvmet_wq, &ctrl->async_event_work);

This trips lockdep with a possible recursive locking warning.

[ 5223.015876] run blktests nvme/003 at 2026-04-07 20:53:55
[ 5223.061801] loop0: detected capacity change from 0 to 2097152
[ 5223.072206] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 5223.088368] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 5223.126086] nvmet: Created discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
[ 5223.128453] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[ 5233.199447] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

[ 5233.227718] ============================================
[ 5233.231283] WARNING: possible recursive locking detected
[ 5233.234696] 7.0.0-rc3nvme+ #20 Tainted: G           O     N
[ 5233.238434] --------------------------------------------
[ 5233.241852] kworker/u192:6/2413 is trying to acquire lock:
[ 5233.245429] ffff888111632548 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x26/0x90
[ 5233.251438]
               but task is already holding lock:
[ 5233.255254] ffff888111632548 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x5cc/0x6e0
[ 5233.261125]
               other info that might help us debug this:
[ 5233.265333]  Possible unsafe locking scenario:

[ 5233.269217]        CPU0
[ 5233.270795]        ----
[ 5233.272436]   lock((wq_completion)nvmet-wq);
[ 5233.275241]   lock((wq_completion)nvmet-wq);
[ 5233.278020]
                *** DEADLOCK ***

[ 5233.281793]  May be due to missing lock nesting notation

[ 5233.286195] 3 locks held by kworker/u192:6/2413:
[ 5233.289192]  #0: ffff888111632548 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x5cc/0x6e0
[ 5233.294569]  #1: ffffc9000e2a7e40 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x1c5/0x6e0
[ 5233.300128]  #2: ffffffff82d7dc40 (rcu_read_lock){....}-{1:3}, at: __flush_work+0x62/0x530
[ 5233.304290]
               stack backtrace:
[ 5233.306520] CPU: 4 UID: 0 PID: 2413 Comm: kworker/u192:6 Tainted: G           O     N  7.0.0-rc3nvme+ #20 PREEMPT(full)
[ 5233.306524] Tainted: [O]=OOT_MODULE, [N]=TEST
[ 5233.306525] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[ 5233.306527] Workqueue: nvmet-wq nvmet_tcp_release_queue_work [nvmet_tcp]
[ 5233.306532] Call Trace:
[ 5233.306534]  <TASK>
[ 5233.306536]  dump_stack_lvl+0x73/0xb0
[ 5233.306552]  print_deadlock_bug+0x225/0x2f0
[ 5233.306556]  __lock_acquire+0x13f0/0x2290
[ 5233.306563]  lock_acquire+0xd0/0x300
[ 5233.306565]  ? touch_wq_lockdep_map+0x26/0x90
[ 5233.306571]  ? __flush_work+0x20b/0x530
[ 5233.306573]  ? touch_wq_lockdep_map+0x26/0x90
[ 5233.306577]  touch_wq_lockdep_map+0x3b/0x90
[ 5233.306580]  ? touch_wq_lockdep_map+0x26/0x90
[ 5233.306583]  ? __flush_work+0x20b/0x530
[ 5233.306585]  __flush_work+0x268/0x530
[ 5233.306588]  ? __pfx_wq_barrier_func+0x10/0x10
[ 5233.306594]  ? xen_error_entry+0x30/0x60
[ 5233.306600]  nvmet_ctrl_free+0x140/0x310 [nvmet]
[ 5233.306617]  nvmet_cq_put+0x74/0x90 [nvmet]
[ 5233.306629]  nvmet_tcp_release_queue_work+0x19f/0x360 [nvmet_tcp]
[ 5233.306634]  process_one_work+0x206/0x6e0
[ 5233.306640]  worker_thread+0x184/0x320
[ 5233.306643]  ? __pfx_worker_thread+0x10/0x10
[ 5233.306646]  kthread+0xf1/0x130
[ 5233.306648]  ? __pfx_kthread+0x10/0x10
[ 5233.306651]  ret_from_fork+0x355/0x450
[ 5233.306653]  ? __pfx_kthread+0x10/0x10
[ 5233.306656]  ret_from_fork_asm+0x1a/0x30
[ 5233.306664]  </TASK>

There is also no need to flush async_event_work from controller
teardown. The admin queue teardown already fails outstanding AER
requests before the final controller put :-

 nvmet_sq_destroy(admin sq)
    nvmet_async_events_failall(ctrl)

The controller has already been removed from the subsystem list before
nvmet_ctrl_free() quiesces outstanding work.

Replace flush_work() with cancel_work_sync() so a pending
async_event_work item is canceled and a running instance is waited on
without recursing into the same workqueue.

Fixes: 06406d81a2d7 ("nvmet: cancel fatal error and flush async work before free controller")
Cc: stable@vger.kernel.org
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 33db6c5534e2..a87567f40c91 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1749,7 +1749,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_stop_keep_alive_timer(ctrl);
 
-	flush_work(&ctrl->async_event_work);
+	cancel_work_sync(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
 	nvmet_destroy_auth(ctrl);
-- 
2.39.5


