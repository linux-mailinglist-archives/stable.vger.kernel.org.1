Return-Path: <stable+bounces-223772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ2iCb/Lr2nWcAIAu9opvQ
	(envelope-from <stable+bounces-223772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:43:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BA02468CD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 642083014903
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C63D410E;
	Tue, 10 Mar 2026 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="p0xquZgb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B2B35E952;
	Tue, 10 Mar 2026 07:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128630; cv=fail; b=QOCgPe+/+g8d/o8fWKTX8mS3KAwdVFxWne5BRYaIiMznSr0JnCDzLueaYTQ3f/A5t0ya0OJoQGwnCBbiFKJuOaYnhnI1QGpRv0VapUkcXwIaQeW0tVqXheyncqEt/RV2LGYLZNTDbNlGuIzjIMwo8OAdXwXH/1DTEk52DLLSXzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128630; c=relaxed/simple;
	bh=tjku6ey4sojlSMTwtT6L2odXfs2J1O9pTRnXX/8hJWc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DgfBoeLIvquriuWyoaDrjrXYRxUAsvpzoRxfFOA4sM6ukmadzNdtqMypHJ3jCSR0HfHyLb7WNY5I2dnF9VkElQpIK+M+wBIX1ilFH78kWEct1N6eIDDHwf0ASe689g/j5Vt4jFpCU0v0ewlmMx2nGtoIE2BvO28a4T8q4wKsFmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=p0xquZgb; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A4m76A317251;
	Tue, 10 Mar 2026 07:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=3i8YiuJRc
	o5dk7ZIx4M/A4b7t2Wnx3fV+UT1f1iNyeo=; b=p0xquZgb9VOVfeVejqZ8twhoF
	wxL+BtIsbWXoYT1ZXxkoef+A13oi98gRps2p1LmXxi7iI9SYqODu+fto6PNT4Ol8
	ApiddWy0WhH6PtUjMRYlAY15qo+TD2Qz7EyXXIEtND+y7RIZrOqa0iyVsoD0AnO1
	nt2RfkMr4W5UKc8oqAVuUMdiBO4OiVwvDNC6ag8fFTmlYzwzSTNjDzVYkvxSdSVI
	s9WuqG+1O/GmQnSrZG4/ZOlSLRdqwgrBBshFePhmhcHpIbncJ0/T9e8ZM4HjFSlN
	9U2yA+0xpjAESjh3hXJdpOAVEn+tROzyGNjvpPCQKcfJZ4ywHPdVWf55gzpCw==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011011.outbound.protection.outlook.com [52.101.57.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cr97vb12b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 07:43:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vY1Wfda60RJ7NOiVGfu2gl8luhagyykuJoA6JebA2R1dzaPOdXLpR1iSh1niDXNWFLMJQXi3Ab9PYDp+B3dU9IEaEMwdclpzkHV5vTyqlO6PwrEFeEfA3L5ApT69NSHi9Y3MARBCbYzVCO62ldN7QWYizWio5H7MrQp7daPDuA844RJKJ9oPKiaYmC16zVPItQmbQzAMprefFm4U6k+CKGpbQk9qWGEFTZ0wlysX4KRrrnyhE+fKaLf7YfwrjvijORfaljA8z4Ncma/iS8YUfvKqnt4BNkbaRp/bG3/YpX3ASr2MEiDMHzXXWWyCRhmfvq4y4JYXcTzahS3x6fBoqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i8YiuJRco5dk7ZIx4M/A4b7t2Wnx3fV+UT1f1iNyeo=;
 b=b4wKV+w/p8LgCwoUyoMe3KIfEfKMKZUHz5U2pUdwUFPsJkesdNYmYaSW5KfGczkUwIg8FCjxTVwDpvcK3RkqAV7PMi1jNJXbW/BTSSFnBkaaY7MnLzNvsvulXvYLU2O2gL2R3KN6e6opREDQXVedIrW6Gj273k3iB6ONRKGKQDnDt/EPX28qBMj+n2HOxbQhvtPE4kxkhbveM1h3mVNDt9+97W+/68fsSCcfdsK54/9Miq1tSb35d33dUHdvfWwuxAijGewDWGdOLICR3TY6wiSX4LKvNggSJWkGRwfx8uS2gkXKUj2S3nkFHADEVx1jOQtQfHf9KUaQx4wxWd9T7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS7PR11MB6296.namprd11.prod.outlook.com (2603:10b6:8:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 07:43:22 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 07:43:21 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v9 0/1] PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect sriov_add_vfs/sriov_del_vfs
Date: Tue, 10 Mar 2026 09:43:02 +0200
Message-ID: <20260310074303.17480-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS7PR11MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: dc53eecc-8037-47d1-58f1-08de7e78b3f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|52116014|376014;
X-Microsoft-Antispam-Message-Info:
	gv/lsGyHv6KHCV7fqu/SxlgPHyKMF6r8cvE8DHKhpH5DQ3gdS9x9HRiiyVjwklmJzcTbx7Zi5lXNDfChByZDiYNlZ9xPCsehnXfPSQMVAyi+MqnVPTdjnDd6CBO8PUo0zMtdtW2zb5KBxY89dFRCA1IwbnoIClr42heSu2THBpQ/vmgMAMFR4ZFf/THmNYK8D/dO0P8RTui018BR58564q61AAQtZhRLGZSRJpvrEMeMb6TN/j87/91U32PWVstOE9cjXEbgdbxbxlgO9mlFPsSyVZNr6NYrhMRiiwwPSfZg0sg9caT1THzp/dZWY8Tjc2jFLTQosOJTOV1+0iPwQW8F0fYV9cDNF6+ReueSoR5R28JwPiC3OiWO/XWPm5b1/JTDVWRVAsKdX49yklw3Oc+ggSxvXSvPl1Z+IPUZJz6ffqjJDfr4gaVublJcQ8WK57Kxqn4jF7/LTQHvsnHmeaHntJDyiehyTQCemmTU31kGFvNl6LaI6i1HHHFQ8AZGKSwnB0dfJ+Ab08V1nwGYzOFsiHemxU7T7uqYt9q/TADB4iqdw1d3WM1Z84jkgSkGjVteCNFuL1NPCJ2kH0/KhCTmtasz48Ny0m3WqjoOcAxdMVSCyP+ClNfHLzsjivqOHT6WlVAhf0uVZsl8LT0oAIp09rLrwuHtFH6BlLe63smWIIoC70PSp/RkHkPidTJdfhtcXNiroot/49HKKnuF6nIi0ZRZpzmfysgzmCxwxJ0JsyEvXyHqkM3c6KUWLQLh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(52116014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7UxWCDydNstoeelv4OMC2PkgEgVtoY4jXNIONM/LnsyyarTGGJWU72EQVmBV?=
 =?us-ascii?Q?6bMb+9QT+gjurD+Hln26r3VK1aWHBiFFj9PIxKqkjQV8MIeLEmXgZdWKuU9D?=
 =?us-ascii?Q?DFLqgERLEwmJkRJQNCU6vnpIzbFio+qWKC1wABy5Z8oE7FSr+CX4Hzxf54Us?=
 =?us-ascii?Q?77WFzp6iyap+7pr2XT6nM80bbQ4uP0Gi1DzBproOFt3Anew9g03Htg0Juiwp?=
 =?us-ascii?Q?P/IaovIYQCCli7QxE6CMQQWnbzlawsvClbPYAFdG03RvFlqL2iFEUTIXbNf/?=
 =?us-ascii?Q?rihE/isvJMP5w4fkdQ8QwnmGaN3vs/f4FgLw8ynddMrEi9xrYAU2Mbh/SEtf?=
 =?us-ascii?Q?k9fwMLrbVe48Gle0o54JcgyswG9Cg2ruCwsGJ/jQpiPj2IqowPGStdJ1AXuc?=
 =?us-ascii?Q?inVNcIYfFEsauYKmm+qtDfbH3MnXtncC5RwLOpBBvi29zygEvox62M1cL35W?=
 =?us-ascii?Q?UV6049EfQF4qDuYwv2BA7XM3N0PbnJV6spTRgczHU8m/XJeY0LQn+IVjmFQl?=
 =?us-ascii?Q?DOG0scsIBFlqXNjzQh/Rg8Y2s5DNanwWNHgIYioMA6EeQyJmK/zFq6UdX3R2?=
 =?us-ascii?Q?zgQFqAukZ2xomcSvfMs6IJ7CbAt4t5OxDQdeCYTS4kNLUM//EGAp4SCng76w?=
 =?us-ascii?Q?DtdBqRwr7LhuSkzlYQuJyVZxT3DV8zYb7/O0zxRyM9JBtZsiXZnEJu2Llokn?=
 =?us-ascii?Q?Lrkb40kHUqpfMwk59EK2KioLt34r7w6zl//o3yFjTRvzgoxu4Sj5t0VYqJEB?=
 =?us-ascii?Q?B67yp9KDHchVZuJGwfYslSKyLFVAiAsRzTX/apDUY928u/ahfklhsOBDPvHa?=
 =?us-ascii?Q?DUpIcchTXD0fzUznTgUyoFnN36coSy2EkoACyQ5Up+v4TnmR8OOw4GpGf7sE?=
 =?us-ascii?Q?sxk+DKaIC+TqoQlduFpi3vzFmBXLHxZ9fVQWZEnGuV68cL/HxcCqwh5n5++Q?=
 =?us-ascii?Q?g7gPozp0VZqwoV5kCIi+pX8JA9f9aSYuof9iEiJmimdtqwEkkt+UqFeAiB83?=
 =?us-ascii?Q?2t9xXXYH3L+cgVkaTz7+GuM4E6N4echdYTy0pwCHKmoNCGps/cGXqlDYeRRx?=
 =?us-ascii?Q?lrrUNJxWtPgqHQ+7JV5OyoqHo7UD/wTrVORWr+CK2qyYaf0ZQmP9ELyryxTN?=
 =?us-ascii?Q?ZQZY9Znjf3rUcIlUSL+tFKom2WFgnkw5HHGVDHuS36caHwUxkGHB73HnMRmq?=
 =?us-ascii?Q?AHQXIh1unWS2LLSCHhKRyFNv3dz9RBaM4eQy/B5Ed0w/29nwfrLCjCu9rnAI?=
 =?us-ascii?Q?y2lFzJjcBqFvRsTW5itWjRUU42hQA9PJe6YyblNYLRsCGVIP9EtYlDEn4FHw?=
 =?us-ascii?Q?lEQTUIbUrmxGQT0Ra1N9exOsoWAa9UqNFkIlT9/pc/4XF3bMHp6kShuI3jeD?=
 =?us-ascii?Q?lcVsHIIFAa5XFOA4boXo/ggFUaGw0acpJRCW3QMeLIHges0zAefgcV68qQOn?=
 =?us-ascii?Q?rkVuO52aFUZCLooutH/l/NUp1ZqaYhurMecCBVXzx0eBBlamTamhLVqFOIvB?=
 =?us-ascii?Q?sZ8xsKTXO4S7Gs0H9uiQ5HrgS4q6VMvxMyiUW8kPkz9AwJV2yLUcQPYih58b?=
 =?us-ascii?Q?/N3GMwtgQh3ItYnydcqTtqQw6N0bUhoa0/hnUwtIZHRaDXHohIVkT7bm4Rbx?=
 =?us-ascii?Q?C+knW0DSeNWR0B4xkJc5VGlVHxyFc7OmaEWn4BjP4iAfsqSIvScrYj/bIiGb?=
 =?us-ascii?Q?QkG4Q4wlI7TatMAVfYtf/CIkxlsbyeUy/RXONV1RZJReMeC7FZqP15TqjEDX?=
 =?us-ascii?Q?S3Z3IFOEG7PEfVmBHrDHeH4ddnNCrC8San8cXrRbfscJMztSz+Dh1MTQaLZO?=
X-MS-Exchange-AntiSpam-MessageData-1: XrV95SorHifaHE3Pg/Tm+GbGyKD9Li6nDH4=
X-Exchange-RoutingPolicyChecked:
	C+Eno7rs3sAE1FgRASKC+YBkPNs1/q7uE8xfN2Qi8+n6ssV3KqaIApQ5cvj+3ufMtVltPzcBUE0UbdlqJEhk1ifbhwSAdPhufa7XfV9QfLp/N1SJe6ig5dXQTsFDDoa1XTlI8V6lcxMxkFCQDM9LV8tTI8Y5o6hjDeLYofHCVHKd1jXtfabRTq9giMYX+Um9ehTVQ2OQjVPKpO5OtSZzkfrCtaiz+JJ3Z4DRDnS5jjd4rk+oQCxmLLUYBqIQofyHb5tPCdOQ3zyI8lG8ZchLsWlUlFu1shCrFAUGVeFRzE3k6FJfit6jAwwWkoyxpsYNjHfV477TpZs0pwPrTZJN1w==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc53eecc-8037-47d1-58f1-08de7e78b3f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:43:21.7353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpQUzM4B3RhsMpou4V0n8Pk9NDh5VPpPulstWn3H7VRt5AVh463BnDfBXxVkElMlw7B9fO1a7nGqE4RTiAIwX7QDZMAnROH3wj8nA+/a/xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6296
X-Proofpoint-ORIG-GUID: zynZL5iJthCQQ-8RBrDA_Y50jpZ2BzJD
X-Authority-Analysis: v=2.4 cv=B9a0EetM c=1 sm=1 tr=0 ts=69afcb9d cx=c_pps
 a=XMRsWg75SVOZ480bTkGGOg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=BuE3I3jV3YnUUluD74EA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA2NCBTYWx0ZWRfX4LZ/7B0fp++Z
 4TEAjGw9qIC+1IninXF2fFhlBIvSHtRGv4UOtCsTsTbRqybU7RhJ6jzpmxt1Bb5xqx8JLV4V0dD
 JDRuaCtUPV/Q9rGkejykwUFLtS04smwS7q2EjUqovFYDbT8S58xwXxmwMNsiGNmOuHXJ8L+tWqD
 YV/EmrzKlAipuiRF1ThusyYCO5eAbQksBz1NIyjHOjw/e2u1mN4PjOL21MBxSGt8BQfmcaT8vzt
 nGsgMqzayiV+eoeB+N/JDHtUkfcOBtMneEiJrrVb5Vy2vIZciFNiblLGa7G2tg+uzuGGSsDoA3B
 BML6zx55VkzKmD4mTyjgHOnnorFw/jpyL/n7StPU972RvV6FzfXDwB4wgrWb250gaByR5cmzZig
 bqYw6OplcgRhwJQmUO5OlPP25NHg9sjyAKbZRGLAKvQ6LpeizN3ZnQVtd0H13yX8iZl/YPgx91v
 dBb7KK1QJUjM3H+Yw/A==
X-Proofpoint-GUID: zynZL5iJthCQQ-8RBrDA_Y50jpZ2BzJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100064
X-Rspamd-Queue-Id: 30BA02468CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,wunner.de,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223772-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Bjorn,

This is v9 of the fix for the SR-IOV race between driver .remove()
and concurrent hotplug events (particularly on s390).

This race has been independently observed by multiple organizations:
 - IBM (s390 platform-generated hot-unplug events racing with
   sriov_del_vfs during PF driver unload)
 - NVIDIA (tested by Dragos Tatulea in earlier versions)
 - Intel (xe driver hitting lockdep warnings and deadlocks when
   calling pci_disable_sriov from .remove, as reported and discussed
   in https://lore.kernel.org/all/20260227214048.12649-1-michal.wajdeczko@intel.com/)
 - Wind River (original reporter and patch author)

Changes since v8 (Mar 9):
- Added Reviewed-by from Niklas Schnelle (IBM) and Tested-by (s390)
- Added Fixes tags for commits 05703271c3cd ("PCI/IOV: Add PCI
  rescan-remove locking when enabling/disabling SR-IOV") and
  a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable
  and hotplug"), as suggested by Niklas Schnelle
- Removed the rescan/remove locking from sriov_numvfs_store() that
  was introduced by commit a5338e365c45, since the locking is now
  handled directly in sriov_add_vfs() and sriov_del_vfs() where it
  is actually needed, reducing the lock scope (suggested by Niklas
  Schnelle)
- Rebased on linux-next (20260309)

Changes since v7 (Mar 8):
- Added Reviewed-by and Tested-by from Benjamin Block (IBM), who
  ran tests in the IBM s390 test lab
- Rebased on linux-next (20260309)
- No code changes from v7

Changes since v6 (Mar 6):
- Replaced local pci_rescan_remove_owner / pci_rescan_remove_count
  variables with mutex_get_owner() for owner checking and a single
  pci_rescan_remove_reentrant_count depth counter, as tested and
  suggested by Benjamin Block
- Dropped Reviewed-by and Tested-by tags per Benjamin Block's
  feedback, since the implementation changed substantially between
  the reviewed version and the current one
- Added Suggested-by for Benjamin Block
- Rebased on linux-next (20260306)

Changes since v5 (Mar 3):
- Reworked based on Lukas Wunner's suggestion: instead of introducing
  separate pci_lock_rescan_remove_reentrant() /
  pci_unlock_rescan_remove_reentrant() helpers, make the existing
  pci_lock_rescan_remove() / pci_unlock_rescan_remove() themselves
  reentrant using owner tracking and a depth counter
- No new API: callers simply use pci_lock/unlock_rescan_remove()
  without needing to track any return value
- No changes to include/linux/pci.h
- Rebased on linux-next (20260306)

Changes since v4 (Feb 28):
- Replaced local pci_rescan_remove_owner variable with
  mutex_get_owner() to check lock ownership, as suggested by
  Manivannan Sadhasivam and agreed by Benjamin Block
- Removed owner tracking from pci_lock_rescan_remove() and
  pci_unlock_rescan_remove() - they are now unchanged from upstream
- Rebased on linux-next (20260302)

Changes since v3 (Feb 25):
- Rebased on linux-next (next-20260227)
- Declared pci_rescan_remove_owner as const pointer
  (const struct task_struct *) to make clear it is not meant to
  modify the task (Benjamin Block)
- Added Reviewed-by and Tested-by from Benjamin Block (IBM)

Changes since v2 (Feb 19):
- Rebased on linux-next (next-20260225)
- Added Tested-by from Dragos Tatulea (NVIDIA)
- No code changes from v2

Changes since v1 (Feb 14):
- Renamed from pci_lock_rescan_remove_nested() to
  pci_lock_rescan_remove_reentrant() to avoid confusion with
  mutex_lock_nested() lockdep annotations (Benjamin Block)
- Added pci_unlock_rescan_remove_reentrant(const bool locked) helper
  to avoid open-coding conditional unlock at each call site
  (Benjamin Block)
- Moved declarations from drivers/pci/pci.h to include/linux/pci.h
  alongside existing lock/unlock declarations (Benjamin Block)
- Simplified callers: removed negation of return value and manual
  conditional unlock in favor of the paired lock/unlock helpers

The problem: on s390, platform-generated hot-unplug events for VFs
can race with sriov_del_vfs() when a PF driver is being unloaded.
The platform event handler takes pci_rescan_remove_lock, but
sriov_del_vfs() does not, leading to double removal and list
corruption. We cannot use a plain mutex_lock() because
sriov_del_vfs() may be called from paths that already hold the
lock (deadlock), and mutex_trylock() cannot distinguish self from
other holders.

The same class of problem has been observed on Intel xe, where
pci_disable_sriov() is called from the driver's .remove() callback
without pci_rescan_remove_lock, but .remove() may itself be called
from a path that already holds the lock (e.g. remove_store ->
pci_stop_and_remove_bus_device_locked), leading to lockdep warnings
and potential deadlocks.

The fix makes pci_lock_rescan_remove() reentrant using
mutex_get_owner() and a depth counter: if the current task already
holds the lock, the counter is incremented;
pci_unlock_rescan_remove() decrements the counter and only releases
the mutex when it reaches zero. This keeps the existing API unchanged
while providing correct serialization.

The rescan/remove locking in sriov_numvfs_store() (from commit
a5338e365c45) is removed since the locking is now handled directly
in sriov_add_vfs() and sriov_del_vfs(), reducing the lock scope.

Link: https://lore.kernel.org/linux-pci/20260214193235.262219-3-ionut.nechita@windriver.com/ [v1]
Link: https://lore.kernel.org/linux-pci/20260219212648.82606-1-ionut.nechita@windriver.com/ [v2]
Link: https://lore.kernel.org/linux-pci/20260225202434.18737-1-ionut.nechita@windriver.com/ [v3]
Link: https://lore.kernel.org/linux-pci/20260228120138.51197-2-ionut.nechita@windriver.com/ [v4]
Link: https://lore.kernel.org/linux-pci/20260303080903.28693-1-ionut.nechita@windriver.com/ [v5]
Link: https://lore.kernel.org/linux-pci/20260306082108.17322-1-ionut.nechita@windriver.com/ [v6]
Link: https://lore.kernel.org/linux-pci/20260308135352.80346-1-ionut.nechita@windriver.com/ [v7]
Link: https://lore.kernel.org/linux-pci/20260309194920.16459-1-ionut.nechita@windriver.com/ [v8]

Ionut Nechita (Wind River) (1):
  PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
    sriov_add_vfs/sriov_del_vfs

 drivers/pci/iov.c   |  9 +++++----
 drivers/pci/probe.c | 11 +++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)


base-commit: c8be6ef92d9bc54f012627375b87b44d3eefe451
--
2.53.0


