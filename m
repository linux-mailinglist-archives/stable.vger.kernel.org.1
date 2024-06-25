Return-Path: <stable+bounces-55807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8199172CF
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 22:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA161F21E3E
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 20:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640B17E457;
	Tue, 25 Jun 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="AfYpqkeN"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2113.outbound.protection.outlook.com [40.107.236.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF7D132127;
	Tue, 25 Jun 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348853; cv=fail; b=ajJVSjfJxoXYoyZuy1S7dWo+N0JV0Hrmg9+pVB1emR9w1nndgtRZNNDk2wSkAPR/JFEPlTkQmhTcfzJlWeis5+hE+gf7A7Ws7ZK83eyyEuYGx1dtlv4UY8DNEoL7AGrESBprxt/7GhUGzvEEy03hix8F2BPM1NkHPlr20JJL/eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348853; c=relaxed/simple;
	bh=zS2hKcpMfIH0BdVrteEYlNMrmRic2MWEO27WQsd56a8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LMCRJ9ba0unYVltY3RQgMcSWJk2qCbTdN0Exr5q4pihuJwQOeMSo9N/JXsNhgUN8Pd2O6dcL+bVkvU24SnfNV1IiK106pCYJS95Mi6qQ4VOxaWf3xksA3r8hrDJGN8JcaDRhTedlpXuV8wOAmbfuySD9HWHra/ofNzbjva4XWeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=AfYpqkeN; arc=fail smtp.client-ip=40.107.236.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi6uhXRCqduuq6usYJkiUNfjgI6YLmwkf/9fL90GHrtSclRJEdWLXNtrumyiIstzQ6WftaoTnPj39EjJVosS3e8G/G1o51k9TM4il4yb+Za8mCGABhN46hQUpNQMcOi6X/lsr0Mhkvd7TaQ0fVPBNkpKI9Bg64fMAdq2xHo/ruOvcPabYNxzeSARj7AcdK4UnMqPmopMmLKc3SKH1no0T2R1NGR93SZnGgCfByC1dJZbH6FG0enrE+K3T91MLbUpqeMlT56iCCxpcUJ4gFZ1HUAypzYRfJTUmfgQ0rsrX4aT/olBI2VGdXd50qZSon3Yc/fPLZ7xv15NK+vhtK4CAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMp2pgrapufMbBwpWlJn5dflYLAktTIDq4+ebpw7dYk=;
 b=T0uhd4c40L5qwEyCOfiHP1uJvyu7kJ8bQhvydMGRfBzdttRCZdGuk7Sm9Rx6VTYPXM5dc92Z+taAn2z5Z4Ecxk/4BUudxFTJr00aLXdCKeMWWRgDhbtvx8id2AET10yVpQa+YzqEXAb+A6q+HLFrLtJ244oXDSan13L26MW8/DaRuxgJXjV0lDqhJKLvNPHhOUgGTa04YHBivi/6SPWEeWwPoXS9Eu+HV7H3afEGfmJWo40a6x8jwQsuk/YzwJbXMX/zJh4VY1RCmWzpCshjd7QUSkRUzTdg7VXOyyCo7fAt95xDFYH5Vk85dGrZO9jirZ9mXYHooFdUS3mjIqOlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMp2pgrapufMbBwpWlJn5dflYLAktTIDq4+ebpw7dYk=;
 b=AfYpqkeNhj/Qot1aoBVhuRuP4ZiJpZiwKADBZ7xTCb6c1bovtzYQEujPybUZbtFp90B69JBd65z3bgC1h7LbsdwegiMbyfK57l80t8NwHJb5cMr8Dc7H6JCqVHOUT6bTo8j9mgM4M4dmGFuMF2ZmhFhLfnixa+9T5d96C6TvNuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 LV3PR01MB8675.prod.exchangelabs.com (2603:10b6:408:1b0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 20:54:07 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 20:54:07 +0000
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
Subject: [RESEND PATCH] mm: page_ref: remove folio_try_get_rcu()
Date: Tue, 25 Jun 2024 13:53:50 -0700
Message-ID: <20240625205350.1777481-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:610:4d::33) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|LV3PR01MB8675:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6b396a-aa3c-41fd-96ee-08dc9558f454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|366014|52116012|376012|7416012|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hy2a1ynPmKfSY1B1Vd24Zvnj+DFoxUruy1dGRjSQl7hFnq4K8MxLmJASMyYW?=
 =?us-ascii?Q?0JnboEV0+tEDXSY7NhnA2EYS6yoPVchrColyueGX1sO9mXCZ5mFXsccT7Hpn?=
 =?us-ascii?Q?+80gtyo50bJgrqgsR/NcmSU51kgK5vQJpTKwsVNT9Feo+AprOlrKqt3SiddQ?=
 =?us-ascii?Q?HOeYo4VIEY+YDyXWHRBCWfY0tqz9I5ctdrhFF6Yj3HEIEpDSTAVZBikgQfwL?=
 =?us-ascii?Q?NlHz4cf1Vd50JWljWS9vISBjFiJi4u0xz/q2hyDrTfVo3YZajC/eJcuyrdiM?=
 =?us-ascii?Q?fG2/ffQytpg5ySRBQQbtGVUYmD8ECjV8h+/TfD+r/yX7bXsZSqsgYieL0geQ?=
 =?us-ascii?Q?zEQ19S/4TiBLuyv9Cqj2Cy2bGh7FoicK4gf7miH9oIUoxo1DE5UGqt+i5W8w?=
 =?us-ascii?Q?3oW4ZJMmV3+FVhOag3m6MxHr+Y5i4VfNFLp+32LFBBXPYYtL1RFKDTQjFu4z?=
 =?us-ascii?Q?5Vh9O+cC3WN0cJC9N0zC9etzcgPYOjdjwtoBQvtLIxeH2u4hTh2thW4rxNkW?=
 =?us-ascii?Q?n09vLyhzCPCeiuF0ZuhSMhPJc6OjGlwxePQvdEZulbrqAxk75Erl2EgFbau2?=
 =?us-ascii?Q?FxdMgiwUkEmTD0ZDWIJJHTNI50+JS0kWAdHjdGVMg9DRdvbPXYxO/SqqqKHL?=
 =?us-ascii?Q?MHJOOF0bBctWiXhc2bXv2QucnoIzwchFs3ieKk76YUdPo5jv3yLT6euMnQlE?=
 =?us-ascii?Q?tJ5vFP0w4Cw0cIj/G7NSHCQMiSIzGDo0Va5CDA8/4sjlFeiGv3JM/jTzD1LR?=
 =?us-ascii?Q?hbZFq3DI/hgKjbC+XYAo46xeTafMbPfAjZhxA9l9cteNckrbttCc/YUmm9fm?=
 =?us-ascii?Q?GCufcgTIKDL7Gj5hwRTJUJRGcwLvg1KOLRA8cGT1WwY1EfZ1nLOa9S5AX61l?=
 =?us-ascii?Q?HtmvvptDzHl4DtBZAizDCCag4iExM/HPZcJfUkPB9CSyKtd2OS/9UnJMpGkO?=
 =?us-ascii?Q?9CL9qOcG255pS7lssq4SED0Z40xHPmSxPLOu7TRjqG2MI8HdYpWZH4RWJ3Pi?=
 =?us-ascii?Q?0wwCA5FeXJm81swurLJZ59hWsmryVOraAYSRHmhMh9E1AynH3wtngSnwVUDo?=
 =?us-ascii?Q?UXKDwXQM7n1j4iI+HeUOQMj8oArqmAdBnQHhQAD33NdfcJ1ob2/vQY6sh1Uc?=
 =?us-ascii?Q?lUkEaOAvugRFQfD3IGfrLSMZ/1UXEGXLg+v6KnIVjLbnF5vief81ezJMGKL8?=
 =?us-ascii?Q?+hWrxrpcepIkZIKWnAbyye/oGzrAfpv+OxHF29dShPiXn6LsT3FnUmNUIOJ5?=
 =?us-ascii?Q?lbL9PPNRzbH8nZwF9XFLCFGHTmglK2iUEGhc+yO++NcPJc9WOO7fpnD1xc7k?=
 =?us-ascii?Q?HV3D5T0Fz4L2EtNRFWTQuWHP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(52116012)(376012)(7416012)(1800799022)(38350700012);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ffv4aat2ya7cIiAzqWIv3XmBg+nLRosf7Hm3LnJOVivI3o2OwjjVD4hmFJeM?=
 =?us-ascii?Q?iXdKGvUB7M0mkZBN4D+GmpxpWF8KWHObhKAtVVHK2OO6s91rIlSmSevn4qsp?=
 =?us-ascii?Q?9PcmMQ68cMz+d7HiBLVnksWQ0NOudc9Q6G6N+U0YO/UiaG3orco+TWhkulOQ?=
 =?us-ascii?Q?eGR0Of5SKIFPdigCjdi5hYiKeiS8tR/lYndqf9Ju71akvPPLcbcGtVagsn6S?=
 =?us-ascii?Q?O+9L0xAHFURQgQQHHHZX4mAxPYHe0wbjrEgtsiSQ4GLaIdycHl0AhzXpY7E5?=
 =?us-ascii?Q?MwJfhklR7PKBm+i2V7rylksK4KBMDJa+l23CbkGGp8YtfGAIGrtcwxDQQ+6Y?=
 =?us-ascii?Q?8BnAEl7fD5Cmlp3gwo0DSKtYNsIm/qw7/Truj00TV+9NdcaG0WdqpeSCkXg7?=
 =?us-ascii?Q?a0n6IxOE4j3jQucv3b9Djv2ynuLqBMq1w8PR5W5uqDvUDImObv0WEQNih5mk?=
 =?us-ascii?Q?Z+t9SwYCOvJT46pzEO7O4pjcToWogf/6MrhsHLbX8P6tElAemRrmYnp47HLb?=
 =?us-ascii?Q?f5aRIm3866F7a5kn+SVmoXHm0CRSfPKsFmk5fKRUloXleTGZL2Fim9OFrgy4?=
 =?us-ascii?Q?Gu6S27yelaCQoiBmvVPZpUTniDQBlegAVN/Szsq9G/n1tTzIBbyK5mWzvP3g?=
 =?us-ascii?Q?lb0Js8y2TBWAC2QKc09D/Q40viHCFmeHtQdZtc0ZG0OadvsPt3AfoDu9uT96?=
 =?us-ascii?Q?27+q6Htnr6o1BvihA3jl8nPbCsMP144ivSTxiFNFGeXklX/TSo0ZH3ivCpB8?=
 =?us-ascii?Q?XcVTviWfI1wWCu3LCgpV6sTIaHv3jJqwUIXbrghGU9TQlOOZFcfZeRblYHgE?=
 =?us-ascii?Q?9IBGUvXm6psYS0Rs7tff//kKksobo3V9+p9XTuqg7Lu7fHO7+oCX2zsS4LJu?=
 =?us-ascii?Q?N7pmZawGHDofqsUQct2pAU/BeCrOgK2fHcF2vHDWQOQux4u8W5MiX0R3P7PQ?=
 =?us-ascii?Q?bvBHMsCy/E/dbkM0WHYGP+12UsJ1PMYz20d8BEK8ign3QIrFbPIj+fQVj806?=
 =?us-ascii?Q?ijw3pLGTWJrPavyEyO2O9dhfoeVx1jpVv8iAs+KtSH2DKOguk2aeB90QQnff?=
 =?us-ascii?Q?mwCuB6lkaIJNXJHUR4D76M7niqmjSkhkyyM71FWU5+u56qAa81noJrfsKSkG?=
 =?us-ascii?Q?TotWh30al5ZbU8QlN052bx7c6T3LajCPOzSnRBwx971h+afKfuqgyI5ZSHY5?=
 =?us-ascii?Q?DW45sZW3KPbuangNzp+HpqSFKnlw89gNwBfnfGaDDRBfsaS+czkdVbZN591y?=
 =?us-ascii?Q?QcdALJ6IcH/p0EVHmBHEU+xyeLWHS4oB9Rvk3yYiTe7f3KaAChw8VR3kkk7J?=
 =?us-ascii?Q?VLno9s5/hfDYEhI1+4F1Vy5AytHIYI3Iq63BL2dZIKEK26eWPcFHvUtMyFtJ?=
 =?us-ascii?Q?b+4iIcfDBe/JnbovHCvyTdIDmMkpDCSjVTizQdhVtQPVPcGq3Xi6TIvGz9Ov?=
 =?us-ascii?Q?/BtjH+UxlPhsHT6ZH5GHDftEp585EZIJK6tLSMU2n/crELLuUiaLDBV8/52N?=
 =?us-ascii?Q?HBazppZQmxBUXkXe11g1EFHwoHNllqZFtDWKNsn4KP2IisTVj+nRwfm451LA?=
 =?us-ascii?Q?Xl02rZOHbFjPpi1AfQ+tFAwrDmMSwVPVSXNVrhrO39N2BlTsrwxBITfBjSbB?=
 =?us-ascii?Q?dKVfFaRMkyN1uyGSw9IsYpo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6b396a-aa3c-41fd-96ee-08dc9558f454
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 20:54:07.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hZEBfHLyTmU/LpfJ6d4DUJVIs1EmMsnmCAvdGZCPR+ZDMfxKf88P9N7grytCynj5NlQw/ioYws9k62gwwTezBkYB7vUWGjojMqBg5QyPlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8675

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
Tested-by: Oliver Sang <oliver.sang@intel.com>
Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: linux-stable <stable@vger.kernel.org> v6.6+
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 include/linux/page_ref.h | 49 ++--------------------------------------
 mm/filemap.c             | 10 ++++----
 mm/gup.c                 |  2 +-
 3 files changed, 8 insertions(+), 53 deletions(-)

* Added Tested-by tag and collected Acked-by tags

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
index 78c8767c0a5a..37e2b2bb4a63 100644
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
index 6ff9f95a99a7..d1d85c41371c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -76,7 +76,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
 	folio = page_folio(page);
 	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
 		return NULL;
-	if (unlikely(!folio_ref_try_add_rcu(folio, refs)))
+	if (unlikely(!folio_ref_try_add(folio, refs)))
 		return NULL;
 
 	/*
-- 
2.41.0


