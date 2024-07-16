Return-Path: <stable+bounces-60343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6566D9330AE
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CE3B23857
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB241CAB9;
	Tue, 16 Jul 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jV081UU8"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020090.outbound.protection.outlook.com [52.101.193.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1081B199EAD;
	Tue, 16 Jul 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721155769; cv=fail; b=TlQzDmdtYJDUdLChv9oHenUAhQrsZsnO8+jNj2K5PyjMy5j4ucQGsWcL0j0uCFUV4FPPDw59CpZGqZkJBUPJsoRxtiu4uoF50AVp98uQ05Dtxc4kZmvsoz0za2PE6/BwoA2EfRJl3fyAdAblAOEwGTLMzMNnMll8Eozp/OqEw5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721155769; c=relaxed/simple;
	bh=sPNmcGu4e+TvWuaAFydKe1ruAH/O7TB29J/Hqdy6kt0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fL7261BzB8lg7ANGg0P/Y5D55cGzvqri+H7Q5d+lS+3UsLh7ZJQwXXDSzStCKcHY6fEQVxxlZBca13nwUx9+Uzi9cHmyT5Fsemt/cMHvyWLvMHi8kbRoPan9yEUR37vj1rc/q8OhPPZoHhuL9aJc8pHlbXuNxaVTJWskj2nlMQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jV081UU8; arc=fail smtp.client-ip=52.101.193.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OziS1cTAznMrC24l/WLUw//aGE3Jl9TM2SS0sFZqCyb6wfAs6FY8s/4QLYTcQshTz0qmi8E9S3SEKddANish7bIeHzkKznXWA3nz/tpdaff5+pNHilexRgquG0Fxc1j/gCoy4x4vEUwjYqqgfi+GiSD10tuX2lNFq/lEt2yoUKsQpUooKppeghW0RZNq2Jvx0Pte/tBo9/EKHlKONPxGxYCqTBIbGKJVoRhBMZGY/kFEU9Mf/HxX8nLAiVBJxAENZw9YNt6pVIAjbJFxYOupPKPQFLSINERBBUxw+JzL/bWZZxVhY4Liu9KvYS+XeIIp9xSArLjGax4cH6yOTsgvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li41hY1m3kIhNwzYVlu3Rde3qeKnHBpoS1iUINTiIAE=;
 b=Juz5r0eQFLrw5xvHiKIfB110rcj4Vhm8vBinkoXs7H8C8aFRs6bCliPl2YDUoLCpjQQsyN1p7/YbS+5v7hyWi1vfK+bYsH6J2QCtosuy130n0MDBHU9lVict+8SHB/wYzb8ASF8GxM2smdJsKvS3hCN+1Zm8Nyt+nLFeD1W1WoiMgCmVBDh++LCHePi2A2GBll69U0nr7rYZrSf381n44futqwW0LjMn7RFA4z+iidGmcXCdskUE3pMxn5OlaRfAAQG1IaBP/DRTJg5OpDBUFhmLRAZyfIT86qWshYKvhvMkrY+aY81WAKVB+/vkBdn9wjO8s+td6wLZwMv/A9hAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li41hY1m3kIhNwzYVlu3Rde3qeKnHBpoS1iUINTiIAE=;
 b=jV081UU8dKSVfKgTg7hNhINpYj146mmDiq4/D9eIvnzjzwrSIeXn/dwGGyKDHFfVeyi2bKoWyOhSBG48nZQ9j8QD2dAlm8YKbEfrorgvxn1cKphgoTj/X0weD9E+3rsQuj2z3+XG5PGVlT8V4p5hwZ1LruFX+EJm9TTRWNg7upw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5471.prod.exchangelabs.com (2603:10b6:208:11b::13) by
 BY3PR01MB6691.prod.exchangelabs.com (2603:10b6:a03:354::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.29; Tue, 16 Jul 2024 18:49:22 +0000
Received: from MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80]) by MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80%7]) with mapi id 15.20.7762.020; Tue, 16 Jul 2024
 18:49:16 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	cl@linux.com,
	david@redhat.com,
	oliver.sang@intel.com,
	paulmck@kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	vivek.kasireddy@intel.com,
	willy@infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	linux-mm@kvack.org
Subject: [v6.9-stable PATCH] mm: page_ref: remove folio_try_get_rcu()
Date: Tue, 16 Jul 2024 11:49:01 -0700
Message-ID: <20240716184901.1454546-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:610:cc::14) To MN2PR01MB5471.prod.exchangelabs.com
 (2603:10b6:208:11b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5471:EE_|BY3PR01MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b01c947-37f4-446e-3ccd-08dca5c7fe7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vckAC/F+YmCrWSrUXOIHzyFOvrP6T/otv3Yri5naTC/1y1cSock7gCCo6/Mo?=
 =?us-ascii?Q?hnjAkQxUgFf7wkxvHmBxdU080Ug9rW7NMDzd7YHO+eL0/aBVFaOjaFlYiHfE?=
 =?us-ascii?Q?muGI47eR0asiAzRHAP0E314CXMkEfkGzAX2IHWTaXzrefYmOzeel/a/F32Pv?=
 =?us-ascii?Q?9fAk9MFdhoFpdkWT8LfnADK+EZgk4SpXWjNbue6XYku8MlYpdtCRcZKWlm8X?=
 =?us-ascii?Q?Q8eoUbzoQF6Z00UYLRFlArAD7NFfDNl+RrSN6m/Dxrv6ShmvI3KfX7zwZ6O8?=
 =?us-ascii?Q?D7jHpD+dT0gzOddcjsI66V0blT/TWSZ9svQ3CyLVY9diooo6wznJ5HK1U8Sn?=
 =?us-ascii?Q?AR3pqtihhOg+V50vdBxW16haDb2WiRBqi/8/o08kU0/b8wO1gxehXA+UuJU4?=
 =?us-ascii?Q?4wAdzy+whRXtjDMbSwAQ/yZW47qDndljHzwpNtTAiUPRkKRzfT8V2GdC2Pj8?=
 =?us-ascii?Q?trQERzdzEXfUzdFXuN1QXLAUQjooy8GPjcQHYfAdNBMN0ZDYgXp1S3JrCZ8U?=
 =?us-ascii?Q?aFsRzymCiIorwSu/KrQIyY7WyqvgKghX1mpKqvRZbIVEmUrjapf/I/yJNgi6?=
 =?us-ascii?Q?4Jg1mQ8NcXvrXKX97LGZwka1ewwLjxuAzJhG6XlnscAvZCzk12+j+PXX2Hyl?=
 =?us-ascii?Q?R6OFo7P2pGfZTBhOh9gW9o7l1W03HI+JC/0BwamRwXfr2s2CimxyfWJL1cjY?=
 =?us-ascii?Q?HvAk3JB0sEt3lhgkQg+N+bgzP37UiSlSa3YT9/5MkrEhtczekFXVax5u/0cK?=
 =?us-ascii?Q?LH+hdCB9SwTdVWdXDXjsdU4N9A5ZhED5NIGuC756h/JHY13wTIyyevsHEXlN?=
 =?us-ascii?Q?RBsyroCqQHhbb67VEqjJA0uc/e+se6npwIKuLNwFgppavkQuji0qDqM0CUzM?=
 =?us-ascii?Q?qiqSHLKF2sK2Ks2w4CBouDV4WgRcPiY0/LGoHGm1re3vOS33XA4Gzw3i+oYG?=
 =?us-ascii?Q?N1Sgv1g4Bjg5ed4J8INiNnDbmRCb5tDxYwcHvltdasanS0B+gbLR8hir+mFg?=
 =?us-ascii?Q?l7c6SPCqshWE8lDL30S8VUcWQwV9OeX/KlFZSgSIR+cJ8m2OVMtFIr9WU+LK?=
 =?us-ascii?Q?DQf5u/QLZ55zpFepVa+D0usZcucFLhQQorphxZorURcqfFQAf6WY6HTPo8SM?=
 =?us-ascii?Q?W8/AxCTNEguY4a1q3GNUXuoc+CVjCcdhc3r8swMF/PFBj6p2YCtvqWmeQXh3?=
 =?us-ascii?Q?7mqmJsOIYUguX+SjkwBgffaJSNYV2mjSblQnL9nSiCWe/wCM5lZ0DoOH3Tva?=
 =?us-ascii?Q?tqPkbjBdTAivU+JaWOLc4wNM+4p98IZ2SVGncC5cv5mZs1xMUB1Up2C8hmwo?=
 =?us-ascii?Q?MslCijt3Uj+VVANAHwtIkTOLntGr0uLsfTXgR88HkWCD/ibJxbbffC+HY6ZU?=
 =?us-ascii?Q?5saiLqovyjJ9KRtLRNtvGAAS7Msu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5471.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4Ux321u4Q5iCouLRaFVBQCI4jsXuEslbcwwXnhPFqcC3zhz/HmXJPJ2KRJZ?=
 =?us-ascii?Q?M3drWXDiKg4w4ZKqyP/bqFjyc/dwOgHu0NapgdZBSh4ybilWdcqSfAXH9xQv?=
 =?us-ascii?Q?Ua/g/PCF5kbBRwHB9kBNANKk16w6iXMfab++Sh0fZGSTUqxL3dwO+71ClHzd?=
 =?us-ascii?Q?HMUXcvMKPi+cQOKdMktBGKg1l3iefbxRkwzk3vQ/JwKFhQUMuS8uR/iKGreV?=
 =?us-ascii?Q?HNZSjskGZuZBZBZferi5DisMv/6WI4Wr6p0+2XEFYkS4fGQnX7cYhmocIpj+?=
 =?us-ascii?Q?QBJtqzvAVCMiQXBrSI0YcpQBvELR0m/c4IjXLravuML5PIgUT2UN1mVjHf+T?=
 =?us-ascii?Q?R9TZfmPXQb31L7dy46Ddmf92XVnxxsdARhuSg4CUT22a01Vx6u9Ip3Aq4A6O?=
 =?us-ascii?Q?dLCoOo80mNesZeSe+oYJUXDNkZcbJ9Zsue52rUz8TsPkpBZ6z6m9KgQOjccB?=
 =?us-ascii?Q?BfrHHETO/e5QaMQBBRBG+WSc1Aza+UyuSUuZHXaIOmG5q0TLYznSX+RwYpJP?=
 =?us-ascii?Q?pmcCNTmVfJbit5Jbd5jgvIUBgWva6CyY7rlxmWG8o3t+8FRlgq2EIjCVFJjB?=
 =?us-ascii?Q?Q0qm9SzPdw4WsXIpdJtSACTqMgYvYC/ReVTEXiAkXmCy2+G/CTHRuapmofm2?=
 =?us-ascii?Q?L2jqwNlayXNQTRgp3jDRxo/Ma1GviAA06ittQdyZYPdPgYGTekhjrtpk2fN9?=
 =?us-ascii?Q?50Ej2A8+Bji6cRpjEnVLP3nixI6G68RyRN58FJzUGBQhoxIRDqGzslpzdEe/?=
 =?us-ascii?Q?golJSiGtN/3OrRuO2Go5vc6SgvkQMt+iXyK4KerE3+fybn/q/js3UKbhqhH+?=
 =?us-ascii?Q?eRvkTRix5yU792BmZutKbYVotTpfbHkS4RSwSy0tyzBm3Up4K0YtgGNnD9hG?=
 =?us-ascii?Q?Vby3vDEEpBdeQ7lfNWHNx+9dd8LhshAgK6Qg9wNdzkgvmJ6K3h8RRBL4KHy8?=
 =?us-ascii?Q?CgqUl+Oqpav9wufRz9YsmASmSKKJ3DnhLyRKyCzoqZcx1aGYC/aiW2QB9Jv2?=
 =?us-ascii?Q?/3iSld4XGwAJSE10CwMFhw9O8eNDcrPFIoVM6VbOtYWvnIZWcwEeSCYbu2Rw?=
 =?us-ascii?Q?HCVIyZckxFSA9ymGG9M3NyqXe9jGyWPNUacJEH2bkRA+RX6PMTT4gLH9aFk4?=
 =?us-ascii?Q?Y2ErLGjoH36I8/PkYpLoV7vrVbI1OH3ysWuYohdZZ0cKCIhsHutH44iXzpxA?=
 =?us-ascii?Q?nCaIyJGaMabmm7Blc6tqYfbZNS0jdc3ux7OILG634TEDabZ38+fYxPPMl6YY?=
 =?us-ascii?Q?+6f6ZIszBjojqzPamLROEeTw+poc8xhj1RTLj6TrrZcBm3vPogcD3amEa6rY?=
 =?us-ascii?Q?XxOVgQb2Dj2WfEi9uSxRBS44aQddAMzaU3N9dYdRGY6hxH4p/YxzN7BKQ/iZ?=
 =?us-ascii?Q?OMaMQTZQ+LnN73rJlw5uNTPrekV+JFnJosKjxMoadORXjbzQH8VN+9w7VAm8?=
 =?us-ascii?Q?spEdGi/t/boNxLVGnF8BBHSswOueJSFEpAy+52595K/L+JOMCb+Ke1Wlku9v?=
 =?us-ascii?Q?FJREHFx+mPYhyE9FZBHQZSds7b0dhM5h2KE+gltFa+VQ3y9IzBTHWPFrqrNj?=
 =?us-ascii?Q?Hg0ivE7ARvnWL7hL5aMF9FOor+MBE/lWSfqSUW8Zh6h1RcDcPUsP7Pfoj56y?=
 =?us-ascii?Q?h7bFyqJgd49ZHmGfqtz3JCc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b01c947-37f4-446e-3ccd-08dca5c7fe7c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5471.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:49:16.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ6+YUvuqfRP5T7IkZebkEBdNwl7q/nER1MosTMrliOR1fJnl1IjWxyZOhomwRt0b6y8kuF1nFOBNE/SATwBZLvLkCkjxEzTRboy3tMtvlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6691

commit fa2690af573dfefb47ba6eef888797a64b6b5f3c upstream

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

Link: https://lkml.kernel.org/r/20240625205350.1777481-1-yang@os.amperecomputing.com
Fixes: 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages != NULL"")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Tested-by: Oliver Sang <oliver.sang@intel.com>
Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: <stable@vger.kernel.org>	[6.6+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/netfs/buffered_write.c |  4 ++--
 fs/smb/client/file.c      |  4 ++--
 include/linux/page_ref.h  | 49 ++-------------------------------------
 mm/filemap.c              | 10 ++++----
 mm/gup.c                  |  2 +-
 5 files changed, 12 insertions(+), 57 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index d2ce0849bb53..e6066ddbb3ac 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -811,7 +811,7 @@ static void netfs_extend_writeback(struct address_space *mapping,
 				break;
 			}
 
-			if (!folio_try_get_rcu(folio)) {
+			if (!folio_try_get(folio)) {
 				xas_reset(xas);
 				continue;
 			}
@@ -1028,7 +1028,7 @@ static ssize_t netfs_writepages_begin(struct address_space *mapping,
 		if (!folio)
 			break;
 
-		if (!folio_try_get_rcu(folio)) {
+		if (!folio_try_get(folio)) {
 			xas_reset(xas);
 			continue;
 		}
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9be37d0fe724..4784fece4d99 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2753,7 +2753,7 @@ static void cifs_extend_writeback(struct address_space *mapping,
 				break;
 			}
 
-			if (!folio_try_get_rcu(folio)) {
+			if (!folio_try_get(folio)) {
 				xas_reset(xas);
 				continue;
 			}
@@ -2989,7 +2989,7 @@ static ssize_t cifs_writepages_begin(struct address_space *mapping,
 		if (!folio)
 			break;
 
-		if (!folio_try_get_rcu(folio)) {
+		if (!folio_try_get(folio)) {
 			xas_reset(xas);
 			continue;
 		}
diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index d7c2d33baa7f..fdd2a75adb03 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -263,54 +263,9 @@ static inline bool folio_try_get(struct folio *folio)
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
index 30de18c4fd28..367ea201468d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1823,7 +1823,7 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 	if (!folio || xa_is_value(folio))
 		goto out;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto repeat;
 
 	if (unlikely(folio != xas_reload(&xas))) {
@@ -1977,7 +1977,7 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 	if (!folio || xa_is_value(folio))
 		return folio;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto reset;
 
 	if (unlikely(folio != xas_reload(xas))) {
@@ -2157,7 +2157,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (xa_is_value(folio))
 			goto update_start;
 
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -2289,7 +2289,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (xa_is_sibling(folio))
 			break;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -3448,7 +3448,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 			continue;
 		if (folio_test_locked(folio))
 			continue;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			continue;
 		/* Has the page moved or been split? */
 		if (unlikely(folio != xas_reload(xas)))
diff --git a/mm/gup.c b/mm/gup.c
index 1611e73b1121..ec8570d25a6c 100644
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


