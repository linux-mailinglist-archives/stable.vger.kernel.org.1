Return-Path: <stable+bounces-227625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDWuIdyyvWlBAgMAu9opvQ
	(envelope-from <stable+bounces-227625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:49:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9DC2E104C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B039303D704
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C3367F45;
	Fri, 20 Mar 2026 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="KcCV7C1s"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93036606E;
	Fri, 20 Mar 2026 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774039557; cv=fail; b=dcctdXpXErAXGaVNEulhIlrPc5X/6+HgM6Mxkr8MMobCLHM8BpSIfrXbmXA4bT8S+ConxgYC/eEqR3gPZ0JftRAx7rkuvk/agdptF87l5a1jcaJGgZC1I9Rk/mXQVRXP+a+fClGOicwVizZsCvdFlfpAipi27KKRvBDTLep5URw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774039557; c=relaxed/simple;
	bh=ZhpRVqE70AKVYzCkiRYddGjPkErfZfoV260LrUrCRVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k/NIWqdBhunyWdEt0XS8gmxluA5e2+kbK0DUMihjTxLgVhczShtkb48GGM/B3kw594u9dxmvjA2UAm30sjT3IPseIOAxyH6jbIKZoP+iAJ9VPaIXf4Hr5WXIQbhPs6Z0uZ2hDIEZgIITX6zf1qwD5UEkVufcrhesZvy1CpaSHSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=KcCV7C1s; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KCfDLm3198032;
	Fri, 20 Mar 2026 20:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=4FFZj7+t0xkAuJpZLBCYIM8xzsxPZqWVgCgeblE1pgM=; b=
	KcCV7C1sBQUJFxux9E64JkocwB395kO8YYoYcP6wX2suZJo4fXUjHSgCCMx5BztA
	HtH6y+85TQMrHcyyXUMmFF28thWzGybisfI+g5M/3ccVCH5+1gEXQGB+JE+fGxeL
	+DAMehE13xkAkzWFn/CjRXKfd0olA2ZmbnJNohT7w6W/W7aizN1LGSeg3NVuisG9
	8qv5n77lCjiMak3FQwDjm2HP+Y6FrtbS2xhwcA+UPH6Zm8q4iTQiUyZ36sNosXMF
	affktQjUmBVkuzVKkQh7NcXIVJsmzztmVwoMCctYU6ytJ99UfriiQGi4HkQYYPhw
	ggA60L5fSL2V9GT453jOfg==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cxm66egtd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 20:45:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEfyTAKrHDbfhiGzhFNtRYrUsQuRUzWUfj476Y+bH8d8fCnQJvxgp/XSkn8q4C+MwCL38PCUmvSqWX4qE1/47a9UmQynKzbjTGYiprIiMhN/uzt4WkRTxutQly6lh5s6GBkzWhFKpKL9bURhJ8jeH4+RQvp+VROuK7665OuEp6Bh/oJqAtpJYiwsfuJ3Gpe4CFuLB/FalN3Cqav//xAcCFTYQNI4esRAerIce7C6EsbwhFmQ0lByniQ3QwFTViHYVNmg9k0ryXycn+WxaCdX5ym9feVkIYSpuStfK9s/gqWXko6f3ODWc5+nRGFxMKtaR9DMjAEAL0DFw+SyzHTdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FFZj7+t0xkAuJpZLBCYIM8xzsxPZqWVgCgeblE1pgM=;
 b=MH3ikubn7y/yVeuUEEseMBqcgcMglbnmn9cuDO3chi3Qd8Pt2xu4EYCK/4sinpMkinOpoYgWCAjUjGHa549N9zzdH1jL00W2aTtkERydy9FVqF/bRxsHLjfubY9sfWC33Qy7TxOBa4xjbXHXkHH8nyI3VYTCX8mHwkKuGT5c/kplA/vkHpojljrlosd2Yril9OtCI+VVWOIZSjo8psw4IBbeLfESztUf7aCrqh+9LSSXYOIU9LuHq+Ac0fp9la9a+BCt9Kh9b6wthLNnQ9OSw62IX/KyCNn7eD7yUHQ5BIsWQ0GWLNVRx7xOdLUF10zVpYGWynLXkrOoArkAyfZu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV3PR11MB8695.namprd11.prod.outlook.com (2603:10b6:408:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 20:45:04 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:45:04 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/7] timers/migration: Convert "while" loops to use "for"
Date: Fri, 20 Mar 2026 22:44:40 +0200
Message-ID: <20260320204442.32901-6-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320204442.32901-1-ionut.nechita@windriver.com>
References: <20260320204442.32901-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0296.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV3PR11MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f73d511-aee7-4f1f-4e38-08de86c19070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MKd3tBsvSHgIwiu9B4QeCs03t7iKumaYnLbKV5NwDlN8kRM2iFXaodxjQYwO8hBsLw5dcb8cAEiw7etrvipiizRtsOfNpqf3iILuEHyQsTrJ+XyG0G7oJnBoXi0FqCEkq0ibgGdh1/Cyn8N2fYbO0WU0g0PF1oFoIWHAcztg+yekk3Evw0Lbti3CEpYOOUZZeKRhsNIZRpY/TLeQL3e8d8HyHvFVvGSFdG7m93Ps8bYxnnyWvQVaqmemZcoJPUU5EjhMyr0R8aq0CGHmimh7t5wZk62oPc0WHjQbpx5xeuEXlXxaY/XrYyNeZIdeWVMRpkj5HlmSTBtKm5j4gAv/Tzcncjd8Qc6Q/bqbyOyGgOpf26p5gwUf8FZynKrSu/3sVm2XSq64SesyfsKEDj2NZxEGAix8picCWt7aD7PvLIgMAe/K6sx/afrP1Sy0tOEWbNX+HKfbyTvTI5cM4cQBjRNGNoVAVmh52TaPxcyeZy1mdGlpcsOuyFw3IEfkg+mtK30fYoWWPgssIK9BwjILQqVMZKyJ1+7KNCB4HBfXit79OJ/DuMYn+DggIL9nPwatpxy+wjiw9QM1DO9b+wykLCMp/qLrEqORyrpYv6mh2m03sM02CcYGAbt1HP3VRJl5Q+oRahh06yhQTZhAzF/M6srcQ4guMsmt+6nulO2u/hSTel71oxbNWN/+8BZEtOUm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xRIhF1GTz9OmTUkVWa9rUWiUbCJQ8LL5v7yRDGQnjVDtOB3+vSEt5h1vpAp+?=
 =?us-ascii?Q?o/0oeo5AKPT8eYLRGzzTEkGKnowifiVICHygCIjWmo0h7dfkoI9Wxmv4Hin6?=
 =?us-ascii?Q?zyPHFWH2f7EHeeEklkJpuxlIdrqZ9B18NOmP66CL60F9scjA8RrwGT/Lb8ZX?=
 =?us-ascii?Q?Rn7ZOH1IuNRZYeaui4X1fx2h0pbpWqk89jdH+V/QjTe38xcSfBypsvh6F+7K?=
 =?us-ascii?Q?16+nWJvKj87043eu0osdSXOF91/nU8vSa4v0qTCinoSToQLCzsPcInrcuy6+?=
 =?us-ascii?Q?xB+u4ph9Pjw6yYtBmgE72fIg4iLDc5tpo7VgPXwMyYLL8Si1jYzgafG81buq?=
 =?us-ascii?Q?WWhRB3eUFCaS/htJwB+YZakjFKmlxvjvFkkgpCG4wpoUvp0oYLRt8SQOhyoF?=
 =?us-ascii?Q?C49KDdo1z8Ni9sSH4z1vfidN2BDZ96Z6HhistFdy1z3uXXXWH840EZCQRF7c?=
 =?us-ascii?Q?rXdN3dqPo4Snm8mvcQiI+1f6BIejuG9Ea0kLmZJDVXTAGkQlCd5XpEV4/JG+?=
 =?us-ascii?Q?2KGKX+AmA9l6fqAJe/8IK5zNPt+407NNfzjQ0BbvlzVC9OB+1yBb8MgV/Mit?=
 =?us-ascii?Q?yg2wkrG4b9LQrQwK4VG65fMHBLzs77ByD/QXTxl1YHvIVnnI14QnnYl0tYGD?=
 =?us-ascii?Q?qfGxN9O3MUi3ncXsdwVcgVlNVSb5efQ2os0ZCT+r6DPt5n0FbBbu6XwliF5h?=
 =?us-ascii?Q?C7PKh5apfknN4Z/Qz+TIG0loJBNz3J+cw7JbB1NNcbkQm77KWxOr8KTYp/A6?=
 =?us-ascii?Q?BGKlYEqh/30q3b70RbFLy/rifvnIy5728a9pBlZMLm0SDsROhupkfW/yVtDW?=
 =?us-ascii?Q?GDxr4JrRBeC8z8CtFlSTO8OGYn+Xzj3hvQKBrGPpo427D5cpe5p1QHFJXE1l?=
 =?us-ascii?Q?GhYze2/vbt+yy+CqxPuKBHO1lR+RDe5OlLpv93L/eYn4HzH/iIP3s1KGJg8v?=
 =?us-ascii?Q?QmTFJ1GNk0zQocsOs3vYYjfdHD4fpnFyJRQ0z1IowSEoPggAYnhkxPx3llYk?=
 =?us-ascii?Q?4K7Cvlv+XdwEANJknuWWvd35NH3l6S3ISoUGiWT/7n5yVSIJ3LfJ7jHAp6Jv?=
 =?us-ascii?Q?r2i5+ZTsbwfh5drzGYnMcfd0s9DoY95bTB3OuuD1Ovq7D2aFGRC3m7XrN6hC?=
 =?us-ascii?Q?n/p4hjqMA/4y2RndsV5MyOFxRgjRGPbtmu9NXHTg99wG6zU5XI6S5WH5vETf?=
 =?us-ascii?Q?q/KCkiiEPM2WzJoYLK74Qb6LJMWuwiNWZcqWjCMANPUrnwlwgfJ9PFqra9vO?=
 =?us-ascii?Q?6Hu6fW25Odz2OAu3smeqvvZcpO+ckRsM+yI3ebWps6E5wYf4tUTQAQPXLoqR?=
 =?us-ascii?Q?S9ErEcnXCy09KLmU13pGdJhVUP2gGQV6JuHrFWNQTf8MY6kZcemapNn39Xi9?=
 =?us-ascii?Q?6dNkOf5fzLLQhQJO50RilZWGRUF5y7YLMqgiW0ik8qFpui7135X56a5r05K8?=
 =?us-ascii?Q?exafqa305/mQnMRJDfkLe24IaPgu/zh1g339NcTLfphqz93re31fC2tTC1Ty?=
 =?us-ascii?Q?E/6pL+su30/vEKbU5s5VQaaqckSWSNthYJaGIXpnscgnWd5pKw9XYwv99Y4A?=
 =?us-ascii?Q?6HvtmWMzvANbxMrPWPJeBcQA8hrN+cX6abwaJkPv18h9FW2zD9gXXYubphXc?=
 =?us-ascii?Q?pWWqU45CkAfBP9A8eg5tVYYn/QaAyXrlLsPXRmUh/VtwXrjJg4TKvYNK5ppz?=
 =?us-ascii?Q?cc647e9+zpWCrNd7fYSpibvtddYLp49lF2qwXDHFLENCgi6WvGj1YHffQzET?=
 =?us-ascii?Q?0PmclWyqnToRZAxCbFnxXXNjU5VegspvNyK6vHjLVFWw+CxCzil+ATHMYFee?=
X-MS-Exchange-AntiSpam-MessageData-1: lelt8CLGECHY2KHlaJ3TP9mOsxj4ttymUpk=
X-Exchange-RoutingPolicyChecked:
	Sqo8kALgEbxjqq4quffFkhlb9dDH1A+/VVi4OrgSTQWO5imfhL0EOkn3Q+XG+15sYZ/LP10UTPOPq+L8SUIRzyRcOmJubyDkgpm0NzJLYQh6uk7R9saqxp18CSKm2DtwDUhGdMz3/sD60TLdIuyIA7SEKsU5yIuRVpLDc9l5d6Du2RVllwlaf0MXDSbY82C2sHcnV3cTftq6iGPn6R0vjjjpAa2Uulq/4jgWHHGCha0U6EZn9FejjiRF7IHc/5xeSzgMxZ27xw7z3OvvVHIFVcs0f0rPPUamjVEMPvJP+FDyU+xAnwes6fq/MdcV16GA2Vm22NgY3tL1lAuFEQlqqA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f73d511-aee7-4f1f-4e38-08de86c19070
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:45:04.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSOvOgNBC7fD/+HmWt+n8lEChXNJ9dQA8lKhtP7NSUH3QT2MrhOmwSWeBhfEGUrvXfytHMBLUZsINZ+pRtY8aGENkTNTTScr8UOPFN3SP2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8695
X-Proofpoint-ORIG-GUID: enT31gEOP-2Xut8k8VdKTYTZ8mnYdDoM
X-Proofpoint-GUID: enT31gEOP-2Xut8k8VdKTYTZ8mnYdDoM
X-Authority-Analysis: v=2.4 cv=fLk0HJae c=1 sm=1 tr=0 ts=69bdb1d2 cx=c_pps
 a=GRGg88i0IYp+MSRJKvRoYg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=OI6a2Joh_PApT7YDg5AA:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2OSBTYWx0ZWRfX4gGngqGhhlSs
 6PvoVR9Vu+cc0dVhIZ3zioFr7TAVRckrAp4L9dN6fCUErFRng3IrZ9ohtKXjYORAtEYCC46S9NM
 7+/FiNaM1IkFqdGm/Nb8nHHpc4hvPXSGgn3NMDrdKTFV0lcPytbX5dG+KtPqTRMcyNHTN1BP1u3
 NdQFHQ0nat+TDUC+4K2B2j2reNCojKzj8DxFSy1PVVXlA2zrEYgD+RrYOsTiUqvSQTgDGWmRGU2
 kz6+3LJdnZIQpkMgA9IRRpbX4UB1ufiB8yV6Sep126UPIbWMUEX9puoPwtOdJF1VhBkWIdF1fzt
 occL8ytMrJZXNiJnr9eAKGZrchYaxkkWoPyVyBs0n6CdG2zAaO4y1y1rgTZ+dqyE4zMDtPHKPbC
 5crUUyNjguQ/4X8Kg4MQMsU1C2GD7rFR5NnSdZhdt/QSH2gofzvO98QG+JoJ8JFKmKaYQ17xSuY
 U2h9qKLLtgkQS4c1zdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200169
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227625-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:mid,linutronix.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: ED9DC2E104C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frederic Weisbecker <frederic@kernel.org>

[ Upstream commit 6c181b5667eea3e6564d334443536a5974190e15 ]

Both the "do while" and "while" loops in tmigr_setup_groups() eventually
mimic the behaviour of "for" loops.

Simplify accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-2-frederic@kernel.org
Stable-dep-of: 5eb579dfd46b ("timers/migration: Fix imbalanced NUMA trees")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timer_migration.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc5314c3..1e371f1fdc86c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1642,22 +1642,23 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 {
 	struct tmigr_group *group, *child, **stack;
-	int top = 0, err = 0, i = 0;
+	int i, top = 0, err = 0;
 	struct list_head *lvllist;
 
 	stack = kcalloc(tmigr_hierarchy_levels, sizeof(*stack), GFP_KERNEL);
 	if (!stack)
 		return -ENOMEM;
 
-	do {
+	for (i = 0; i < tmigr_hierarchy_levels; i++) {
 		group = tmigr_get_group(cpu, node, i);
 		if (IS_ERR(group)) {
 			err = PTR_ERR(group);
+			i--;
 			break;
 		}
 
 		top = i;
-		stack[i++] = group;
+		stack[i] = group;
 
 		/*
 		 * When booting only less CPUs of a system than CPUs are
@@ -1667,16 +1668,18 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		 * be different from tmigr_hierarchy_levels, contains only a
 		 * single group.
 		 */
-		if (group->parent || list_is_singular(&tmigr_level_list[i - 1]))
+		if (group->parent || list_is_singular(&tmigr_level_list[i]))
 			break;
+	}
 
-	} while (i < tmigr_hierarchy_levels);
-
-	/* Assert single root */
-	WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top]));
+	/* Assert single root without parent */
+	if (WARN_ON_ONCE(i >= tmigr_hierarchy_levels))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!err && !group->parent && !list_is_singular(&tmigr_level_list[top])))
+		return -EINVAL;
 
-	while (i > 0) {
-		group = stack[--i];
+	for (; i >= 0; i--) {
+		group = stack[i];
 
 		if (err < 0) {
 			list_del(&group->list);
-- 
2.53.0


