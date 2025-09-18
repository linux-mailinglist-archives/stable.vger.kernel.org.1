Return-Path: <stable+bounces-180560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91159B860AD
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 18:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182851C86C33
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5351631960B;
	Thu, 18 Sep 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JoPGxKnK"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023108.outbound.protection.outlook.com [40.107.201.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196C3195FA;
	Thu, 18 Sep 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212648; cv=fail; b=hmkc+fHolR9Q8hVAecdRqslrg0pOxHRflPWcTKIJ7d6DJSJmlMmTEU3SclNd5LkqbhcF7c9YYIPI045vKFvoYAyLiVGNRlHCkRj4GJc/jXmQhVhfMJcZOeoIPiFuRPpNaLhmt2FPWlV7SmHpwmLH9RwTRYj2q8JA+jEtyWMeMG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212648; c=relaxed/simple;
	bh=zVnSOvCKsPFSx72oW1EGykFEtdxQjApUtiJXGQ/3nCg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CCDfD0RWCWIET2F1u+jgl9fT5XoD3zdCRXptnLwbQRLqG06ztLiRomC+NDgl+YzhKoZPABNUjA18E7mnTnJgLAXMGeBinynSrKn3fUx5tb/CXNHhgLprzRXy1zFAZWJgerPHXjI9mBX+TDnrMsnTHfGV7M7KDF3lAmyo2LRcih4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JoPGxKnK; arc=fail smtp.client-ip=40.107.201.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL4l2YUFw9o6TB1LBfX6mDJCn+CZLZvQzk0RpXR9ssiEwWLzWJmNUjZ1cT4Yka+gcDxPe20oxJ/iHLFvhla4PdgNpiyyS4q5sxyGN3jo/cHJvuKIpMgaSDHRLDHWpM16wkJ3Xb0UTEa4Xb33DvzZ8ViEHCZdy3PyeAgt/expN7fitBMKQldDTngoaE+L1HO6lohgIoWAuw9j9KQ7J+IujZFo10b+ez9RnhzdPcsnfjVH9mk3ol3iP5MWz9OWINX9WRNdqFedS+ehCG6UqyRPMYiCHBzNAF6yKvD7T+xaXGqhLZglwUDaax09omfeFMXlKSmZeLOjd+5U83SW3IfYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYWBiuxVYCN40YFikD9rdRlsKiW3Tie02Ykt4D0/KX8=;
 b=Vc5cYHZJ7SWuHOr5XwUrSxu0Ifmv+kBvXOm/9+JsyTzIldaFYfGgwiekyc9DY28Kd9dupc8G7FkP76DvUnfSq2lOWthfJUvvJBPDKYPhzAQ6OricbwOYOv929CqK5G/W2aAgwsti+3GN7MbMA+8yCqlLRnRN85TuEMvGGHkPkAxB8oTrGWbYAdNviYdQHouZt3XUBsvq5bbb8XQCxfNQrnkCbLJIz2YwO6s6II2HDPq6iDzyAS8m7LV4OP0L5ov4ZzFZaUrk0aIQZ0wdsJWB6YGuE4Hu6dYy+EggYhJOwrJoJXGO/NUAAvdjyz+MhdsTvOcNf7mIV+xQwTGh4pAjhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYWBiuxVYCN40YFikD9rdRlsKiW3Tie02Ykt4D0/KX8=;
 b=JoPGxKnKdTnvZ9F6MpKDNG7KbDfIfNG1PNo9ptVV4Lx/3J5dphbGHhlU1Fiff8GUSvjt3OejSyh495pPnXj5ZNtVZMcyAJ0XyNNiggbQqV2p/4O99Hd2lUT328YhrDZljAHQfdJdH/VsNczpICthsORSZ3Rary/yP5c6LsGC8qA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 BY3PR01MB6612.prod.exchangelabs.com (2603:10b6:a03:355::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.13; Thu, 18 Sep 2025 16:24:02 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 16:24:02 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [v2 PATCH] arm64: kprobes: call set_memory_rox() for kprobe page
Date: Thu, 18 Sep 2025 09:23:49 -0700
Message-ID: <20250918162349.4031286-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|BY3PR01MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 362a7510-b823-489c-8682-08ddf6cfc77c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZazfZ3wL2vapK8WVTdHjG5IKq/PBfdTixdrxu0fgSthHED/PX9UmLcDBvoOY?=
 =?us-ascii?Q?Uc2oCOXEHER+lg2rb+KZqTUMsn65xS8zmAcH+i1Xn79MtW6TVdkBoI+2/sv+?=
 =?us-ascii?Q?AB/y/sM+6ATWXAPBqn7irhioOsCC0BKRxKflzH0NFil+ONiYiccUEz6Oml/B?=
 =?us-ascii?Q?WWyDavZZE3p2UiP6VSEIh9Cq8LcObXG/jjgbLNMw/fJuRJVtd+fkrBJ3ncuO?=
 =?us-ascii?Q?u77CvEXCp6i+KtFKbBBv0fHr8aeFIplJszQoLVNQFJOfoYxXQ4hgD6mrOW1Q?=
 =?us-ascii?Q?bfbGufzq/z3FP+qe87yzkMOThLgKPGuZ10GdrhEy0O+t1SHqsXA+n+N38HqY?=
 =?us-ascii?Q?k12j0LKoQiJYQHF7dl8d3DnOyKOvjwWtI9aEsK/NUpjs3ApCAb/pO8lu8uDE?=
 =?us-ascii?Q?SxnJSTX0WswHSsZcR784h/frjhmmt73GTB9e9Xj76Vh42rVBuyCzNXPNejFv?=
 =?us-ascii?Q?d9HYhOGjDU9B8lO+Zk3WCWbYyCJgpYS3uPjBPffNk13xssWru9ze9rUoNEzs?=
 =?us-ascii?Q?DrFSt4rmWX9QgVSWkcb9g1pUldBtXYj9f2Nki8seAR/qKs0Exvl6Losh0ITo?=
 =?us-ascii?Q?m0mwfgAC8Zn0CPQkNddrPnjMdQ4axB64HJJzFDm1tkoThQpYthCD7maO46NQ?=
 =?us-ascii?Q?rlsDJibHMIXTQUYnxeiH0C9LmBRr9Rb02hqtFg+Pf6Y96j/dlLjbec7qQ1Ay?=
 =?us-ascii?Q?ehW2/VjvmNoM62IfDAK3i39jLZrOMnMYiW/zN9TtAj4UZFWM/WgszOsG2Cnw?=
 =?us-ascii?Q?pC+KWUiSvNeatgIJQtkr1n7F6hvHB+DKtrMv9WLhH1R2O6+0EBSnsoSW3lYF?=
 =?us-ascii?Q?z7m3vqZyUHESKWBhqCF3YQo43m7RV2CljP4X3RpInEoO/aH8SAE87v07F0tA?=
 =?us-ascii?Q?xR9IFe47Jpj3UqA1n3pRpr+fzqdoCe6xbchWml4lzWzj3q8HuyOn4tTlKCrl?=
 =?us-ascii?Q?crGBYDnChcjjL9hRMW41/gXYYuYM0slZenzLqGqG4eZ20xNttd3yQoRPyKkf?=
 =?us-ascii?Q?+W9DEl57b8Kg+169D91Hr+fsxQbTRUXhc1wpaW5ikQvdBgTP9jXyftrNnEnI?=
 =?us-ascii?Q?/6rnA6eVTh6dduUnG5qJyoJauOOa7D9nMQrHkzjFvWoJbJWDuoI4Cu3F/VEL?=
 =?us-ascii?Q?AaH4Ne1qFP3eYf5g6dl06AaqCyOowukAgFt1h1kdSZNHP3hpMEDvv2Vk4UJu?=
 =?us-ascii?Q?jmxL4nrRLcj0w2458ndkE4Sb8IYzuD6PGtxcqOQbkQ8XjpwhVsNHJxI2BhPw?=
 =?us-ascii?Q?UN8el8F9dHYWG75NFvIMvc4oxmD/Qi10sPoLgaVbEjJJAuhXG5Up+DkXlWhu?=
 =?us-ascii?Q?29rQUX8vJI65J/EVRn6g25Yb5LdK/h4KcisKSnrlRY/STpwSD6I5pMNmvzo0?=
 =?us-ascii?Q?7+XpPSo7OTOppkONzMjY+xrYW/I1JsWJMtiqXI3UXljEI04e2nVp7uaGQ03a?=
 =?us-ascii?Q?kgGWerk851d+MyGT92eOoJ3Rg3L4RdD4wfnyiDYE7OhaW50kIXvgJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ywwa12W4S39Zl99um1C5Mkt+lSebzXsrkvwlIYdt10J5+qjp27TZaXEurKK/?=
 =?us-ascii?Q?LRNnS/inrFXWRr3AjcOQf7JX/oEDokebC9d5dwC/6zZzjPQvSqipH+/fclyK?=
 =?us-ascii?Q?sRCLt1C5t8Pocu+MSPFe1tJxMtPbQNKTY8yWiWtbT0fcaF1j6ZgLoFM8SpkU?=
 =?us-ascii?Q?jJh3PEtdbNa4/DxwOIzWEpSv9QKcuiAUNYa8RcymeAqvBvEOOCsSu1s3JEdt?=
 =?us-ascii?Q?YE6fM/Gxe9Ok4IYqYLDSriSzvIMmjF90EjIoJE+DO4KPPHno9tTNLMfWpIRZ?=
 =?us-ascii?Q?3j9HvhchFgOtP8ZECxlcWflCtR4Cvn+EKLX9kO1WiiwOxRb1SVISU8SsHVi2?=
 =?us-ascii?Q?mMJbdazZjriCS61/uiJ3jTwsR4aiEgsAnW5HDyy8hBOFbyZbDmMAogVNvcej?=
 =?us-ascii?Q?PMEumr8Q8YZaXJSZe6Azct7bO9rWI1U1wVYsv+m8/UQa0ws2sLeMhnOtYC7o?=
 =?us-ascii?Q?Y1kBLz/5L8t0ro3lxhAXB/Q6S7xI57PdbW2L+DNR9h7Zaf7XOB84uDfwQb6Q?=
 =?us-ascii?Q?p/8tb9evFpCZtoAPN4I0b/NK1ytk1X+Iz9kN3z8q4IeMWpPjUDGI6i7C6R4p?=
 =?us-ascii?Q?zoOMDWadIb4HCNZ6CwhSWOAaTTqNXr6yWBfkxRG2NMCzzL20qU/Rvu3JtGt2?=
 =?us-ascii?Q?XrJmOGzobxdF3FTENJm02LlvwKhmraBgQ14ARchltr2tp2eZmYOGNyLkiy1S?=
 =?us-ascii?Q?CpXr8bVaKBfXoRXYosWbTYiTuOAqF4K0k7qg7MyN0jlWxu6v+TE28GHusKoe?=
 =?us-ascii?Q?WkDRQnDl0y6TF5IpnNzPL71NzCbHc/fHhmz0p3YQuO2pHPJEd4PAY9cfxNJR?=
 =?us-ascii?Q?xzrVaUWJnBFvbc7zPEguDK1PsyzCzsJRbZBaGzDv6aD9CmHnkHGAP356UVB/?=
 =?us-ascii?Q?UymqG4Yg2QWc85s8tvhuQBnDVxKTst+LVZCyScqgrNMuTR8VkZLp7Pd5k5Rt?=
 =?us-ascii?Q?n7QozuCYZZ7GUqNV2B8eK+0/dXoopmSM/xAQfdmc2YFVb9s1qQSWAxBKbNUG?=
 =?us-ascii?Q?90KnYsGzG/04DT4Cjijc6Vwd15RUKjLHEPky/GaoogbB26szzDvrkKg4KcRw?=
 =?us-ascii?Q?54H3/sUryO/a2tuauFxh/dDMrifdwxVWo82I3+Si2c0e8MIlr+OoP6qhTdkj?=
 =?us-ascii?Q?Waz4+MA+bHMCPwZL2xBTjY8LSwVmm0op+M73NNjACMdSE4MORMt/skmFtTro?=
 =?us-ascii?Q?AunCNrX5XkEjHb4m/FerMyzi3HHj7ghdGkzm6DXtcfB3BwgiYNwn0XTgGo2v?=
 =?us-ascii?Q?fAPgNWqR1k1jc+m2pfp/NSZMbnBll3DzqWNIfPdeyqN55E5Tf2NLstB65nHt?=
 =?us-ascii?Q?U8o5vHYC7NkcW0F0xUwJLGbAdV8Hsmyr+HuFlx994ZChMjBGPV6nYZLlZLS+?=
 =?us-ascii?Q?U/oFHdzlJdEV+CTD0/u0AuKfZey18oISWcHbEGE6lP6sZNrSG26W7jV6W8zB?=
 =?us-ascii?Q?AWLEbmjP/yGLyyab1IqFsd3t6NMTakid/QU46ps4RqxpkkKbGb5ebld7wgu0?=
 =?us-ascii?Q?o9Rgbd5m+kyxtcVI9+RZBzKq487/99LPBulw2VmFQCXkek25vHfYGjQ5Dz/d?=
 =?us-ascii?Q?Gx9mc3ej8dUTaSO2o0dWbzwm2nSH8YCU7PaM17jNN7H+GwqN1dJ1Gl90aN54?=
 =?us-ascii?Q?MU265sJDceUzj24l5wwaiLk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362a7510-b823-489c-8682-08ddf6cfc77c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:24:02.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8WwRdE0H/rf1lyXjY1OVu/dfF26ofwq9S3TvMRpOmNZ8YAhqPlyOopT0U9DQ6I/i8iDSHrZuPRphY2uEMiuwi9jl70QDBDjDUJwTrayrsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6612

The kprobe page is allocated by execmem allocator with ROX permission.
It needs to call set_memory_rox() to set proper permission for the
direct map too. It was missed.

Fixes: 10d5e97c1bf8 ("arm64: use PAGE_KERNEL_ROX directly in alloc_insn_page")
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
v2: Separated the patch from BBML2 series since it is an orthogonal bug
    fix per Ryan.
    Fixed the variable name nit per Catalin.
    Collected R-bs from Catalin.

 arch/arm64/kernel/probes/kprobes.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 0c5d408afd95..8ab6104a4883 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "kprobes: " fmt
 
+#include <linux/execmem.h>
 #include <linux/extable.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
@@ -41,6 +42,17 @@ DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 static void __kprobes
 post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
 
+void *alloc_insn_page(void)
+{
+	void *addr;
+
+	addr = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
+	if (!addr)
+		return NULL;
+	set_memory_rox((unsigned long)addr, 1);
+	return addr;
+}
+
 static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
 {
 	kprobe_opcode_t *addr = p->ainsn.xol_insn;
-- 
2.47.0


