Return-Path: <stable+bounces-60345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD69330BC
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7C41F23A4F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC041C6B7;
	Tue, 16 Jul 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="PXUWVgeg"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039BF1B94F;
	Tue, 16 Jul 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156025; cv=fail; b=jp1TksPMItB672BQ4/k8USbosld+kdrqsEWuSrmkYnPOwp1GgDaddJGaWcF8UbEMaHW/27p4BGCQwQY3dnuZ/6IwkCceWGAL9I/9TILWU2AQFD4K96gaErxmGtXJF1VtRzksJ+8pTxk++I+oh5FQlH9GdPYRWNlOT6sc15zVj7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156025; c=relaxed/simple;
	bh=hR6zdoNco4dvbZP12W4Zq+7ywjSbMoJSqPF/xH0biL0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AeD1PkAaNmwVqbcqtbXua3PVuGXRuUL4q3vyMlmBSXsbp09i+Ravkb2MfmQl2XZbhtN2I++IZ1sPRhrsb8cRBue4dUjOrbmCnXaWdWnATWHLjXEjSNkL28UNmbrDT2XIze4XreDqQesZ4745ZIraRyl4q7WLh+AkN6CDPMyXwPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=PXUWVgeg; arc=fail smtp.client-ip=40.107.92.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Klt9xm6zcRqALeAnPTmgpIyAaSu8Ej4iUdK3Mbne6GcHNG1hW0x1ChN2FabUk8ihqEF4L84lUEfYbYexgbU0VvVd0uzHb0f0Zjqv5KGQlCTF9HYODXdilUryAaEn+3rGNcx/059W4f+Iu9Cds9whmYwGV09+84/7SYYFYmJ+f7AZLTWxF4BtxTux/juEb5P1iUO4B5+DPoUk15jpxzgZNFsmFg8Z9U8CvGzkDNoRzdWT05XO8sxi9fZ2cVvjVLIP9QyS6l4b2jwNYAJzfaXIW7GdENNtapv2Grba+5dwISkUGhvTzQGjS9tXxs4dHbQVoC+tQrsYf5uEUJK0kzYaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6E3EhUOjog/KjXYSXe+LFhR6cRE/iOox2EfrXOh8Ew=;
 b=xMp0SDFz35NJy537ictewuRDdv+tq2xJFKiz7dmAKMjuJHTrm6LoctgaU4DDUjYAkrR1nJyt8P1p6secuEezKlxu3C6FaU1D6GYIBaOKtImfMRta//spa92UGMkLr0AL5XfXNYwTisdoOFz2bOw4MQPk32m+XN8rA2GWOg+d+FeobkXiMn496GKMFP/wDiK/Gp1/SWyKNt2JfoAhWRMre5nH7Zjylv5t58e71bpNz+N/x0K1ElxDTKaOeWVBavY1FzFxhvNFitkhIBrVrQaE5miuoNTDraJn/E/7RqjsxoQfW/mh2yrwadCvyh5/QgQXUTyAIUryZcqg90cGsJGMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6E3EhUOjog/KjXYSXe+LFhR6cRE/iOox2EfrXOh8Ew=;
 b=PXUWVgegn6EP6sEVfIb/Qc+6T1MbJ2xc44CWCoXhsfjphn5GF7xKgY6EYU4m9kPOoP4FuzDU/qdx6Omg2JpsdgmCmIA0LPmB72CanU8MtxEeoThcI2vG4ajTJdpA5X5C2HdDI5u97r9ir/U2j+40GzEeQGH+J+nu69ArBewLPfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5471.prod.exchangelabs.com (2603:10b6:208:11b::13) by
 DS7PR01MB7591.prod.exchangelabs.com (2603:10b6:8:73::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Tue, 16 Jul 2024 18:53:39 +0000
Received: from MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80]) by MN2PR01MB5471.prod.exchangelabs.com
 ([fe80::dba1:7502:f7ff:3f80%7]) with mapi id 15.20.7762.020; Tue, 16 Jul 2024
 18:53:39 +0000
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
Subject: [v6.6-stable PATCH] mm: page_ref: remove folio_try_get_rcu()
Date: Tue, 16 Jul 2024 11:53:25 -0700
Message-ID: <20240716185325.1454812-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:610:53::39) To MN2PR01MB5471.prod.exchangelabs.com
 (2603:10b6:208:11b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5471:EE_|DS7PR01MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd1873e-0b1d-4d4a-1f2c-08dca5c89af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FIw8hlt8c3wq37LIqYKe0vgoTZ7AYbe4CcEGBIrUOeYzhoYB8S0S8MfSnLvJ?=
 =?us-ascii?Q?N6MC22x6cZd2BlQMvaZGKeKcDMKFDNY/t+vHV2MX2lkGXGc87qUVK8vzo1t9?=
 =?us-ascii?Q?LeVrrFic4/TY0ktY4j4MScxgBicYZmyunnx2cCfWKd61+xTH7egtVrOihKT9?=
 =?us-ascii?Q?HPzm3T+NGzPpcv8lupbm9xkrM5buLFjH8m9s4/BkY8XwRB60fkMx8xE3zteS?=
 =?us-ascii?Q?11tkC88kawPAO10qLMBzrc1ccO8eZnRHZCTpB622DqEJKEw6RknIo91ohTfD?=
 =?us-ascii?Q?uK7Q6I5CInB4kcQ9FEipxloIsfj3VoFR4jYDHHkrbejkICT13QkNgz4yUCGr?=
 =?us-ascii?Q?b+VcdWy/aoSSBX9M7RWN113uDCQIL3oLXROQur0t+WfJd+N3gIcb+39FPT7Y?=
 =?us-ascii?Q?xDDveg/T9B6boIP1UxCPt2AGxKVfZNWQwJaSMe+fxUfKVyX9byX/VjTvvWWX?=
 =?us-ascii?Q?Yy5bBMDuBqYr9+FN2Ylz3v+UG/sj0o6LtDO/C1prXnA0lRhzY6KDRiD5KkR1?=
 =?us-ascii?Q?f7ZbySzKqzT2TnJnhIqrvbFGH8ZTi7WdZZ2u4MLxEpFrfcHCatcWxcU9C3el?=
 =?us-ascii?Q?Hv42Xd38uvVxK2hxluaJmAHBvoTdyuyooRjQnrrbE/YSC/u89qA4NuT0K5J1?=
 =?us-ascii?Q?cS/OPsbEDs9jXYPu2w7SizZGRp+ukUsUnP5jZVLJTg1SXdqv/FMuRksDWPBZ?=
 =?us-ascii?Q?c4iYejYBxJbWjjjV8SrX3CaZt2wSBCSsDSP0DMIRotuxY19Bhh5+7Isb+bXD?=
 =?us-ascii?Q?RRJPuMLrI21fAdyqtIbBVjBZD/vCV6AVelnpGY4fYFKgGtAdv5x8QfyAfVcw?=
 =?us-ascii?Q?pev3r+MiYkUH7SsLEL0aQn8FVYTWUbR8tfGeK0Nezyt+x99egaNBMliJtaPZ?=
 =?us-ascii?Q?oOg66APZ2spSAY2gXoidOP2X1K6axabeqVIEuIqItFeq7jBmGKUDmnWAGLeN?=
 =?us-ascii?Q?ahc8q+LeRw8CqeyZxmyOKWGFEieuFSrV4JSjyQStPB65HjcNjcUL1N9iD2a8?=
 =?us-ascii?Q?FQR586M7F1NG1m2Wsfo2pYcsMS0nJ0db0i0hI36Y5NJSrlftJAcFpibxjv2e?=
 =?us-ascii?Q?JRQsPPFmP0tzGQFFu9uvPlr0KT5VmRJHof7pvSgEaeW2F/B1BC0gAWFC0+7b?=
 =?us-ascii?Q?PxACgQz8SwNN+xeYy9cDDRFKS79rvfnvjBBE5nbQBUZHOi6N8unOeJBdF95u?=
 =?us-ascii?Q?rugpsiYU53gyawNbyyxu4tXnZCEAgABu6ywmW6oyls2uVqPq5stS62s8tbsJ?=
 =?us-ascii?Q?Y2gr07lza/mKHJE5Uw9v59sF0rOozirB90zcbwfzECt8Qk9NjwSPQrDgUcic?=
 =?us-ascii?Q?9GSNspEHVAejDlYFKELj6tywBUBfiwzpSSUW2cAO8Rnuf68l3Bi8AyyMpFpb?=
 =?us-ascii?Q?ltebfNIHwump8qUH2mFuMPXsZouT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5471.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c8bNeGl0hngMg8Pa2Rkz54SrXE4G7kjpitvE/F2vtyjbRrG04n1hpllv8zSa?=
 =?us-ascii?Q?i91cnCEixub72f5J7S2kv6RwzU7RBUHEfleE5zBspDHAb2+3edTsA3Z9QFCI?=
 =?us-ascii?Q?rWE+2nLIKzIfGQNQq+8OgKl6tT9AuPVRK7TbTh8/YFMzNKedgrgsGPXGLCoO?=
 =?us-ascii?Q?sXAgMqtBup6KPPPDTNzGMHmHWbXtJHMlXsJXOER2a61TrMzS07TQUkLbQ8Bc?=
 =?us-ascii?Q?q4L/xYC1Dw+NBRSxa1Hmgu3AyInhbNfL+jF3+oRn+UIR0UOvdqnlZOghMDsp?=
 =?us-ascii?Q?2LP4RVwvHiFdbXH/a/9de0EnTBeewhUVddgMOKSERJJKj237FG73UCTpV0Ao?=
 =?us-ascii?Q?uGjXwUlqL0Dn2N0sqgYkaJjwrQ6pnM6sHUpPmUDZoQcB0obn8PFGPMDjeUoH?=
 =?us-ascii?Q?i8vq6ylqvoqS1dKGXkVcefazVBBgyAWFYWHNc1siV5GVhowVXe5e/jEHxSsV?=
 =?us-ascii?Q?ShN5Smt+LL9FamgmJwDXWp73N3ZBRSOxNS2lEJyK1D85NgDjmEGdjzY0aowx?=
 =?us-ascii?Q?qBOXSRifJPAZSXD0p8/zcHVdTjPLJ8QN5l3nTmV4BPIUP0w3P2CB0PxyVOzG?=
 =?us-ascii?Q?ZnOSffzWxPhKsU8iVLHzwruaUFYY/0oviHo8fRn5hFxTF8lVIUtfARWwUJDC?=
 =?us-ascii?Q?LbrRAkxju91a1ZdycKQ2/9Fb1VWxZuAbskJrkYTCmAAEB3cO24BMb+rpvClS?=
 =?us-ascii?Q?Ig491dZck+ix1pRWuZ55aZPpW6sOM2dvWyC0NMcEU17Xbba1pUY0+5byPKEr?=
 =?us-ascii?Q?9ksD7JvsbKZ9pPeql76FpentD5L0ePDUewzp67B2VZWSaLFHp7KU8h1wcSUs?=
 =?us-ascii?Q?lFw2FvyhycS7wm3b+3+Nz0TD8/piBuHEVQYY/bYstVhng/150xiUf2pGoqKh?=
 =?us-ascii?Q?VglAy/lAXE4HJCv1T5BqNldTCERArVe+acJFC1rzzE1E+VKLyQ6DJY0zWNRa?=
 =?us-ascii?Q?VFaU/fe3d2RJQtCurUtvanEoBEphkbZl1tecIIyE4aupJesSEKPvgdrNZYDM?=
 =?us-ascii?Q?4fyadE+AVswcBqEFv2uRZ9NKAUlpX4bMbzx/h197O5qLjo1MCGsiOQwgRgo/?=
 =?us-ascii?Q?J+rf93l5YZAkeVeGv7+QiQNt1xBWIAjcxqfx+tMD3m290dElyoBjkML89f3d?=
 =?us-ascii?Q?XDiRGU8Vgdv78Gyd+OMoXXtfmxeEXGrgTKAxiCczXOXEeUXTRY6ET6kA+CFl?=
 =?us-ascii?Q?JeDfyelGOq9txDt3cSWCke0ehmT+BQZHtiNQNZXK7TpKUee8w5R+tQEB+alo?=
 =?us-ascii?Q?Md2P0hBnZdKdNZoD1/5SSHmLPEkshExwz5gJL4PNX8ZHqfKa0Vx3fnEMV+fz?=
 =?us-ascii?Q?aBLIqvU2NgvI/CNDzlIfhDIMTI/SEyzM5o7ghkyJyXki3zHu8+9PY2GO4kZg?=
 =?us-ascii?Q?z9my2squNCJuj800HifPijyAB6p1q9NZbewGvuWRBHwrqIeJdWtI0X1Qyr/5?=
 =?us-ascii?Q?Rx+lMig9a/cQPdseDBVaZ+R1YZsHFeG3zP7eW2XKZ1ehx1AZFVvCsLJm+7Ob?=
 =?us-ascii?Q?hig4FU9fij4eaOVKU0iZTtRsqtoGBMIHhMhUmH5GZv3rOAsRKUns+Ix3+xDT?=
 =?us-ascii?Q?0m/AGzvFDGOF56VBtD3W5wVhCsxySPcmiWFcDZjklbHXUS5vPYId4BMlAQoW?=
 =?us-ascii?Q?AuvyZ7ZruPdfee3Vf72Zhag=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd1873e-0b1d-4d4a-1f2c-08dca5c89af1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5471.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:53:39.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MMloOxWHzSd5k0WQsPqk7Kwe058jFrgbL0Hp3u92992WvfFjIUvcibUqEI3b+ETodaHaF4Z/OpAtqHyAUIc9D4bhz3tkCPQPa7BlqzpQrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7591

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
 fs/afs/write.c           |  2 +-
 fs/smb/client/file.c     |  4 ++--
 include/linux/page_ref.h | 49 ++--------------------------------------
 mm/filemap.c             | 10 ++++----
 mm/gup.c                 |  2 +-
 5 files changed, 11 insertions(+), 56 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index e1c45341719b..948db2be26ec 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -496,7 +496,7 @@ static void afs_extend_writeback(struct address_space *mapping,
 			if (folio_index(folio) != index)
 				break;
 
-			if (!folio_try_get_rcu(folio)) {
+			if (!folio_try_get(folio)) {
 				xas_reset(&xas);
 				continue;
 			}
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 7ea8c3cf70f6..cb75b95efb70 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2749,7 +2749,7 @@ static void cifs_extend_writeback(struct address_space *mapping,
 				break;
 			}
 
-			if (!folio_try_get_rcu(folio)) {
+			if (!folio_try_get(folio)) {
 				xas_reset(xas);
 				continue;
 			}
@@ -2985,7 +2985,7 @@ static ssize_t cifs_writepages_begin(struct address_space *mapping,
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
index 3dba1792beba..5595a0ccb0bb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1831,7 +1831,7 @@ void *filemap_get_entry(struct address_space *mapping, pgoff_t index)
 	if (!folio || xa_is_value(folio))
 		goto out;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto repeat;
 
 	if (unlikely(folio != xas_reload(&xas))) {
@@ -1987,7 +1987,7 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
 	if (!folio || xa_is_value(folio))
 		return folio;
 
-	if (!folio_try_get_rcu(folio))
+	if (!folio_try_get(folio))
 		goto reset;
 
 	if (unlikely(folio != xas_reload(xas))) {
@@ -2205,7 +2205,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 		if (xa_is_value(folio))
 			goto update_start;
 
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -2340,7 +2340,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
 			break;
 		if (xa_is_sibling(folio))
 			break;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			goto retry;
 
 		if (unlikely(folio != xas_reload(&xas)))
@@ -3452,7 +3452,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 			continue;
 		if (folio_test_locked(folio))
 			continue;
-		if (!folio_try_get_rcu(folio))
+		if (!folio_try_get(folio))
 			continue;
 		/* Has the page moved or been split? */
 		if (unlikely(folio != xas_reload(xas)))
diff --git a/mm/gup.c b/mm/gup.c
index cfc0a66d951b..f50fe2219a13 100644
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


