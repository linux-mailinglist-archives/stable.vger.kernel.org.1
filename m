Return-Path: <stable+bounces-47961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A18428FC02B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 01:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472FF2832DC
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1D14B061;
	Tue,  4 Jun 2024 23:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q1A1DPoC"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2109.outbound.protection.outlook.com [40.107.212.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779DD535;
	Tue,  4 Jun 2024 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717544964; cv=fail; b=d9LcNvQvZYk6/ZKrhI9iFKqWiZUxHcN46GlwtLlS1K9UKH4nVQaqjUvABgrG1VCzsK6BmNosFrflzATZpt3ELwlupq1+AQMbPL6WE0fp8nD8TA84yZ1aS+oEmb4yEx347yMf335OK8M65euP9m7KZESAkSggZLeSqjqco1F6518=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717544964; c=relaxed/simple;
	bh=c75d3Tr4dNd739eEeAO/mb24i4VXwVZYKcKKV9bbhJk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kfuDarGgRXzHc1YcbgtdITXCytiR9X9LYlqF7OBdJCD4g+TfhL/Kb7cOlYwVzgAI5O7KEB0e47xAUFi9iC5aoeZl0YTX65ldUvbhGTnLOWYT/+BPF5S4H/YFUIu25YVsfhoPHcwmegc5oVbnSzHgtdM1n73cQ0x9BRZo3BPrLFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q1A1DPoC; arc=fail smtp.client-ip=40.107.212.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9xOTAdyLKc/07rlaz5jRzBcXUk8n0baDFx2uoOXcyWkjmf+EQ6LTdySt0VxnFfAvCocaytq544aW1DOEcQWSnViXkeoI0W20JXkJQwnqGKvpQZZwsEN4+rQLxc1b30TlFyfXYRItNmfTSiRZAGx2IKVrDJf7kCGpUJwvd5ezYn99aa9Jng09u1irp7jerw2e83uKrhlYMmNFqsThO4asCYiCkawrbb9hvBopZfgCbChfmV99ise8dZQX2D4qpIjQ6oBqzJX1QtdPoObFTwfnTPp4XSatlL5rWvQ1sVU7XWVcl5/9cNIFazY/nAU6DI/lkjxdM7ULrCmrWJW3c1nCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7O7/r5POaN5FbgrD4LDpQYGnVCFI76fgP4riHmKhUn8=;
 b=bq15ONj4KoEyxYWyp3EP/XsV0AKWb9NbF6Ls7DMgYU8a/RSm/kJS7/uGdXMRP6ICuCZFuWceWWQBf+HDmFEVa+0TpHi9nDiMrmQ4E5x4MF+pLJkPdoVXNNEh0ny+yRBfEiUzHkGcKHyQWakJ6hY1DrQ2d9I2zUcuwqzdjSuGfnkVIvrEeTN2KygnWZeNkqF9OG63L51pn2SexyUoYrMyC6kWYvIs9JMsxvx3cfHr+4XqbGxEdGSf5k7MXa89eJawzUoD6zKF2P5z67Rj/789e4j5SOPRm+xYvHQzSoIpoqNTSg03bze8/pFFj0hEbwZRwCGZzgxWUzwXYHGdcYls9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7O7/r5POaN5FbgrD4LDpQYGnVCFI76fgP4riHmKhUn8=;
 b=Q1A1DPoCvQTtmGOa8ZGPb0eubtQObmSQkrNigHeg0Sahqzp8W1iEwqzTs7lyiSFM0e10q2KIvRCwplibQ/r3R3GqVlyVktHjReqVVbTE/fS6XT9JH1HWWSzoFdl2N7ZAIp3NJwzpbU36fttCbMSGpvYC4zTjAJum+01Jn3ZyOdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 CH3PR01MB8575.prod.exchangelabs.com (2603:10b6:610:168::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.30; Tue, 4 Jun 2024 23:49:15 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:49:15 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: peterx@redhat.com,
	oliver.sang@intel.com,
	paulmck@kernel.org,
	david@redhat.com,
	willy@infradead.org,
	riel@surriel.com,
	vivek.kasireddy@intel.com,
	cl@linux.com,
	akpm@linux-foundation.org
Cc: yang@os.amperecomputing.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm: page_ref: remove folio_try_get_rcu()
Date: Tue,  4 Jun 2024 16:48:57 -0700
Message-ID: <20240604234858.948986-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|CH3PR01MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: e1b54cd6-d675-4c62-a66c-08dc84f0f133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|52116005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mpPjGGP0w8tZTd9/ZDg0tKb4mImmw/xKjaqTT8A7vQq7j4ZK+jq+XIf4VGCx?=
 =?us-ascii?Q?qJ+VK14GBOj5VMsezkCu9xh7inco6uKbiet5zYucrdYNZ7cv37Dl1N21WrtS?=
 =?us-ascii?Q?F5jXcu20BWIM4jvSzjh0inMuCG8RBlTN/1bsh4xCJYX3bSwNBXzxk9lMesT/?=
 =?us-ascii?Q?Fkws33WX2+i2f/UfYW+S/SmyYY8AWBlLie2rNRYNJRjAJylERXtJJqgQDltC?=
 =?us-ascii?Q?OYWI8tjsG2SZzdGv5a1l6PhWmzDyDYJPO5nVcjDcoBeKbMSbT+bbvlRodtvg?=
 =?us-ascii?Q?RXYWMt2Ww2hu4VoqdgG97fWoHFnuWGc4vjGbRe2xrGIQUoWrWoP/JSaYzluW?=
 =?us-ascii?Q?yb2uhPHoNX0TmYVcuasFvybSYNRuDG0jAHxtur+c8tj85inTaJtYyKe0l7eX?=
 =?us-ascii?Q?ofq8iXwh/sXyF8UerrVhXhOJLMhR/BcSztBrqVxzMVVX5/+mJ+K5S3qdK8gi?=
 =?us-ascii?Q?oIohgvNZnJzXlCvOzW+4/bJXbzXbEFgNku5qHeKAHalqgUflssSl+uUu7orj?=
 =?us-ascii?Q?BoJnOVGRFOCpeao7C/8jQFqAz88744XPiKn/q9GHx9PdAyK4dRq7hmeZ/FBg?=
 =?us-ascii?Q?83188Q/UmdYvrgLHY7GMkr5+yrwX2tWBV9bCPoY5SZ4jWpEZnfLqzeoiQkke?=
 =?us-ascii?Q?KndWpZznR6f54qsgI9sHlEAc0BgZwKQZJ8OZRp/bXYhtDbOI5yU0AtLVdunH?=
 =?us-ascii?Q?zkJTaPvHiO0d8GJmCqZt3BXoby3K6regHgbGLjmowQaL+ccV/junwi8H00Gk?=
 =?us-ascii?Q?n8mviR/XglyVV9x5FI0KYPB1MaVKw+5YYCBKTVtPTBhzAFG6I7rIsYbE4+qv?=
 =?us-ascii?Q?L3rvoQkfaSgJHoYL7oA6xr8XZ3LetgDmVnJPBAOrW5qvGt5hYD+tb8aPm9Kb?=
 =?us-ascii?Q?czmjxl7wKidMB0tjJN//YjPxTLGaVAoUoqwwj3p0ZXE+zKld8gKRHd/t1k3W?=
 =?us-ascii?Q?aNydy7KItbBCOHJ63Dun4M5u+vB1kEpaYFjggcc3QGUJRXBH7VJbg4a6EzMz?=
 =?us-ascii?Q?gaqXOFYQsRRJipj8MvS9CD5lyCWgHv+kncYk3K9fSYZvCfmGS2H8o5lw9EV5?=
 =?us-ascii?Q?ZNGYEv6m68C2BYHAAEZ4yuO3jd9b6fIPRvTa1waM0WZqaK221OriU9tZ6Elj?=
 =?us-ascii?Q?YfkB0k8b/y1fBR8Kv/38oaovYQ+sXKd8ATUqDptJS0miim652EBkTcXzD/Qw?=
 =?us-ascii?Q?SECOS7HuxpaVbEQd9wOCMQ/dN4Qnji6rEwnppJWx5ee4XuQkFMzI8+B38mai?=
 =?us-ascii?Q?EPyliMjfcAAbzO6bGpvmwYugAMNrtz1s9yhbG/tRXcovKkivFDUDL75lpfOI?=
 =?us-ascii?Q?C8et2m6ufDAvgAqdqzjCmV20FkM4GB2yOTwPjYHeR65ZEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2A3dMv8bQjeL1FrflgoDPHZvkRUvjA1SjMiQq4B/RIC2XizqfD3fdTe9qZn?=
 =?us-ascii?Q?SfriyseZSZqKnhSKo+lfmp23fLNAAq9rO7v8OViT0yfwtZFa+bV4Q6nwUbje?=
 =?us-ascii?Q?kp17m1W9xk0vJx+apR6kjYlMA9J4JJ2LvU8WY32GMsTo6amEkhxf8rObIPjT?=
 =?us-ascii?Q?QrOld7sd3palkXZBvAyI60dXqdaUhNhCJT9AMvCef+HnJus1hHOliqyNgNI9?=
 =?us-ascii?Q?kSux6pUJTNavKeaCHMtykrSBJYY5ZI9gI+nP8TFcxEVXZruVse2tM2WpYgoq?=
 =?us-ascii?Q?fay2cCW8E5k9XoSOjtueysfCS0tqRmMpMFsRPUHJ0ZpwTumpZiTFQo5qQpLN?=
 =?us-ascii?Q?a6txpgJ0AhFrGvJSD18AzomsvR7Q0bKkEyaESjqJprXnYa8mqwNkRzQ1CtQp?=
 =?us-ascii?Q?I1IQK9iY2Xs8f6M2IpDbXD/jCRTXlmDvScOsrw2Jg9xLyPBfxK+eM6D9Y81G?=
 =?us-ascii?Q?a8kJYKnWVb/0UEZzR8VVLdfGPXhkucr5q+5MxiFL7YEhdgNH81qufb1QvSLh?=
 =?us-ascii?Q?lefFGRdBi/xPxPHNtD1epaXMx/+9Z80KVYS3fEbKqp6xoXsDUKqrPb3w05P1?=
 =?us-ascii?Q?16W3WgXmrVgEFaaIELqIcCuaMQKwHXZx3eZ8JcjXVJzyNohBQrqHr71K9G9M?=
 =?us-ascii?Q?TGf+5DIYCLYXxb/9K+jMUkSR0PJkxMZA1heRe8mDSw/GUEs7RbFK6qxqysYa?=
 =?us-ascii?Q?dkTxtx3bXH48H+AWwelCTpOVKJFRjiEJE3B+6nfM34ikU9f5Syf4Dj0wlFhQ?=
 =?us-ascii?Q?Aih65ExYM9H6qAfXoCwHqPEhX6DV/845GES4G9NH7/grgmwI8/xTihB7wmI/?=
 =?us-ascii?Q?VQ4zJQ0uQFq22HoeNw+I885r1skHsxbAJeOkNiWsvJry31fMRf3VtuZ/L/hY?=
 =?us-ascii?Q?IR2IqqM1fHsEnxFS0Wi6xM04PYqZd1GVrWGGbLuZusdt9bBfr6eWs7wbflS2?=
 =?us-ascii?Q?BHyG9juDSz9sWTs0tU9rc8OAVNyySiFmBuWVsCq2m5VGLDsHLzdPW12ifQlB?=
 =?us-ascii?Q?wLGvP/jKTJMzu3nN83C6d4H8gR5CR5SfEFpJa0OXKFKy8RQUzpZ7Tsvi+kN6?=
 =?us-ascii?Q?x+OTndbIWpjwBwt/f0PraloYNg+6w6+ar0bYVKa2VFT3OIFgBMXOVONgwovy?=
 =?us-ascii?Q?+GjFA45QuUd8ToNXPh3ll1/xE7+aRLTnEGfxmBRiufU1HYPYG8JOo8qzHIpb?=
 =?us-ascii?Q?htckrZXiXJCBiIv0svioFyCtQvl1B3sp02vhsTulPEBaYAcJi9fKFuA2vD5p?=
 =?us-ascii?Q?ws8RTrtJOu43BAXRPq0WlWvsvz8AfTIsf0DfGJmFJErmysVstO/YhiMPb9YQ?=
 =?us-ascii?Q?9cCUfo/bgnYMtPydZY+/PDlnpMYwmUk14Lnk/GTnxv13apIsqCJEacecYU/t?=
 =?us-ascii?Q?cNjezRZAHuE6jQ5v1m6WgqgwOq0WkLVxVdNV0K3D9H/Hxb5SW1aHJOJgEcEg?=
 =?us-ascii?Q?03jHEROBcX4D5pDmoUuuyTCdtSnHB7+hNcmWHDI8gqJ4CvHJ3T+mJJHi5qIn?=
 =?us-ascii?Q?HncwJBCy0YvYskazZw9vaneuha6F2GbrI8Is2KkAZrSKT9HCRdDhHh9n2iyi?=
 =?us-ascii?Q?8KscW5hQZsa8ktcHs9dclwUEo8rjAvIgM+tvJ+8YSl7oObGPk/xmIUmaGpOc?=
 =?us-ascii?Q?HFDwJSZmLhmwNmVv2v+X7Ik=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b54cd6-d675-4c62-a66c-08dc84f0f133
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 23:49:15.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DxAejY2MnVmMjQ48imu483c/X2f9x1CdUzZDFIKwAw4Rs/4XQGSsCULOBbZ6dKOoxTGrNItR/frER4xrkKzag0yBOdp4N8sE8Vwq/XOxpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8575

The below bug was reported on a non-SMP kernel:

[  275.267158][ T4335] ------------[ cut here ]------------
[  275.267949][ T4335] kernel BUG at include/linux/page_ref.h:275!
[  275.268526][ T4335] invalid opcode: 0000 [#1] KASAN PTI
[  275.269001][ T4335] CPU: 0 PID: 4335 Comm: trinity-c3 Not tainted 6.7.0-rc4-00061-gefa7df3e3bb5 #1
[  275.269787][ T4335] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  275.270679][ T4335] RIP: 0010:try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[  275.272813][ T4335] RSP: 0018:ffffc90005dcf650 EFLAGS: 00010202
[  275.273346][ T4335] RAX: 0000000000000246 RBX: ffffea00066e0000 RCX: 0000000000000000
[  275.274032][ T4335] RDX: fffff94000cdc007 RSI: 0000000000000004 RDI: ffffea00066e0034
[  275.274719][ T4335] RBP: ffffea00066e0000 R08: 0000000000000000 R09: fffff94000cdc006
[  275.275404][ T4335] R10: ffffea00066e0037 R11: 0000000000000000 R12: 0000000000000136
[  275.276106][ T4335] R13: ffffea00066e0034 R14: dffffc0000000000 R15: ffffea00066e0008
[  275.276790][ T4335] FS:  00007fa2f9b61740(0000) GS:ffffffff89d0d000(0000) knlGS:0000000000000000
[  275.277570][ T4335] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  275.278143][ T4335] CR2: 00007fa2f6c00000 CR3: 0000000134b04000 CR4: 00000000000406f0
[  275.278833][ T4335] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  275.279521][ T4335] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  275.280201][ T4335] Call Trace:
[  275.280499][ T4335]  <TASK>
[ 275.280751][ T4335] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
[ 275.281087][ T4335] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153)
[ 275.281463][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.281884][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.282300][ T4335] ? do_error_trap (arch/x86/kernel/traps.c:174)
[ 275.282711][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.283129][ T4335] ? handle_invalid_op (arch/x86/kernel/traps.c:212)
[ 275.283561][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.283990][ T4335] ? exc_invalid_op (arch/x86/kernel/traps.c:264)
[ 275.284415][ T4335] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568)
[ 275.284859][ T4335] ? try_get_folio (include/linux/page_ref.h:275 (discriminator 3) mm/gup.c:79 (discriminator 3))
[ 275.285278][ T4335] try_grab_folio (mm/gup.c:148)
[ 275.285684][ T4335] __get_user_pages (mm/gup.c:1297 (discriminator 1))
[ 275.286111][ T4335] ? __pfx___get_user_pages (mm/gup.c:1188)
[ 275.286579][ T4335] ? __pfx_validate_chain (kernel/locking/lockdep.c:3825)
[ 275.287034][ T4335] ? mark_lock (kernel/locking/lockdep.c:4656 (discriminator 1))
[ 275.287416][ T4335] __gup_longterm_locked (mm/gup.c:1509 mm/gup.c:2209)
[ 275.288192][ T4335] ? __pfx___gup_longterm_locked (mm/gup.c:2204)
[ 275.288697][ T4335] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5722)
[ 275.289135][ T4335] ? __pfx___might_resched (kernel/sched/core.c:10106)
[ 275.289595][ T4335] pin_user_pages_remote (mm/gup.c:3350)
[ 275.290041][ T4335] ? __pfx_pin_user_pages_remote (mm/gup.c:3350)
[ 275.290545][ T4335] ? find_held_lock (kernel/locking/lockdep.c:5244 (discriminator 1))
[ 275.290961][ T4335] ? mm_access (kernel/fork.c:1573)
[ 275.291353][ T4335] process_vm_rw_single_vec+0x142/0x360
[ 275.291900][ T4335] ? __pfx_process_vm_rw_single_vec+0x10/0x10
[ 275.292471][ T4335] ? mm_access (kernel/fork.c:1573)
[ 275.292859][ T4335] process_vm_rw_core+0x272/0x4e0
[ 275.293384][ T4335] ? hlock_class (arch/x86/include/asm/bitops.h:227 arch/x86/include/asm/bitops.h:239 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228)
[ 275.293780][ T4335] ? __pfx_process_vm_rw_core+0x10/0x10
[ 275.294350][ T4335] process_vm_rw (mm/process_vm_access.c:284)
[ 275.294748][ T4335] ? __pfx_process_vm_rw (mm/process_vm_access.c:259)
[ 275.295197][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
[ 275.295634][ T4335] __x64_sys_process_vm_readv (mm/process_vm_access.c:291)
[ 275.296139][ T4335] ? syscall_enter_from_user_mode (kernel/entry/common.c:94 kernel/entry/common.c:112)
[ 275.296642][ T4335] do_syscall_64 (arch/x86/entry/common.c:51 (discriminator 1) arch/x86/entry/common.c:82 (discriminator 1))
[ 275.297032][ T4335] ? __task_pid_nr_ns (include/linux/rcupdate.h:306 (discriminator 1) include/linux/rcupdate.h:780 (discriminator 1) kernel/pid.c:504 (discriminator 1))
[ 275.297470][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
[ 275.297988][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
[ 275.298389][ T4335] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4300 kernel/locking/lockdep.c:4359)
[ 275.298906][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
[ 275.299304][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
[ 275.299703][ T4335] ? do_syscall_64 (arch/x86/include/asm/cpufeature.h:171 arch/x86/entry/common.c:97)
[ 275.300115][ T4335] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)

This BUG is the VM_BUG_ON(!in_atomic() && !irqs_disabled()) assertion in
folio_ref_try_add_rcu() for non-SMP kernel.

The process_vm_readv() calls GUP to pin the THP. An optimization for
pinning THP instroduced by commit 57edfcfd3419 ("mm/gup: accelerate thp
gup even for "pages != NULL"") calls try_grab_folio() to pin the THP,
but try_grab_folio() is supposed to be called in atomic context for
non-SMP kernel, for example, irq disabled or preemption disabled, due to
the optimization introduced by commit e286781d5f2e ("mm: speculative
page references").

The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
boundaries") is not actually the root cause although it was bisected to.
It just makes the problem exposed more likely.

The follow up discussion suggested the optimization for non-SMP kernel
may be out-dated and not worth it anymore [1].  So removing the
optimization to silence the BUG.

However calling try_grab_folio() in GUP slow path actually is
unnecessary, so the following patch will clean this up.

[1] https://lore.kernel.org/linux-mm/821cf1d6-92b9-4ac4-bacc-d8f2364ac14f@paulmck-laptop/
Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
Reported-by: kernel test robot <oliver.sang@intel.com>
Cc: linux-stable <stable@vger.kernel.org> v6.6+
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 include/linux/page_ref.h | 49 ++--------------------------------------
 mm/filemap.c             | 10 ++++----
 mm/gup.c                 |  2 +-
 3 files changed, 8 insertions(+), 53 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 1acf5bac7f50..490d0ad6e56d 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -258,54 +258,9 @@ static inline bool folio_try_get(struct folio *folio)
 	return folio_ref_add_unless(folio, 1, 0);
 }
 
-static inline bool folio_ref_try_add_rcu(struct folio *folio, int count)
-{
-#ifdef CONFIG_TINY_RCU
-	/*
-	 * The caller guarantees the folio will not be freed from interrupt
-	 * context, so (on !SMP) we only need preemption to be disabled
-	 * and TINY_RCU does that for us.
-	 */
-# ifdef CONFIG_PREEMPT_COUNT
-	VM_BUG_ON(!in_atomic() && !irqs_disabled());
-# endif
-	VM_BUG_ON_FOLIO(folio_ref_count(folio) == 0, folio);
-	folio_ref_add(folio, count);
-#else
-	if (unlikely(!folio_ref_add_unless(folio, count, 0))) {
-		/* Either the folio has been freed, or will be freed. */
-		return false;
-	}
-#endif
-	return true;
-}
-
-/**
- * folio_try_get_rcu - Attempt to increase the refcount on a folio.
- * @folio: The folio.
- *
- * This is a version of folio_try_get() optimised for non-SMP kernels.
- * If you are still holding the rcu_read_lock() after looking up the
- * page and know that the page cannot have its refcount decreased to
- * zero in interrupt context, you can use this instead of folio_try_get().
- *
- * Example users include get_user_pages_fast() (as pages are not unmapped
- * from interrupt context) and the page cache lookups (as pages are not
- * truncated from interrupt context).  We also know that pages are not
- * frozen in interrupt context for the purposes of splitting or migration.
- *
- * You can also use this function if you're holding a lock that prevents
- * pages being frozen & removed; eg the i_pages lock for the page cache
- * or the mmap_lock or page table lock for page tables.  In this case,
- * it will always succeed, and you could have used a plain folio_get(),
- * but it's sometimes more convenient to have a common function called
- * from both locked and RCU-protected contexts.
- *
- * Return: True if the reference count was successfully incremented.
- */
-static inline bool folio_try_get_rcu(struct folio *folio)
+static inline bool folio_ref_try_add(struct folio *folio, int count)
 {
-	return folio_ref_try_add_rcu(folio, 1);
+	return folio_ref_add_unless(folio, count, 0);
 }
 
 static inline int page_ref_freeze(struct page *page, int count)
diff --git a/mm/filemap.c b/mm/filemap.c
index 9fe5c02ae92e..0fb5f3097094 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1847,7 +1847,7 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 	if (!folio || xa_is_value(folio))
 		goto out;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto repeat;
 
 	if (unlikely(folio != xas_reload(&xas))) {
@@ -2001,7 +2001,7 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 	if (!folio || xa_is_value(folio))
 		return folio;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto reset;
 
 	if (unlikely(folio != xas_reload(xas))) {
@@ -2181,7 +2181,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (xa_is_value(folio))
 			goto update_start;
 
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -2313,7 +2313,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (xa_is_sibling(folio))
 			break;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -3473,7 +3473,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 			continue;
 		if (folio_test_locked(folio))
 			continue;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			continue;
 		/* Has the page moved or been split? */
 		if (unlikely(folio != xas_reload(xas)))
diff --git a/mm/gup.c b/mm/gup.c
index e17466fd62bb..17f89e8d31f1 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -78,7 +78,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	folio = page_folio(page);
 	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
 		return NULL;
-	if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
+	if (unlikely(!folio_ref_try_add(folio, refs)))
 		return NULL;
 
 	/*
-- 
2.41.0


