Return-Path: <stable+bounces-212835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +sJFMEssfGkpLAIAu9opvQ
	(envelope-from <stable+bounces-212835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:58:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A53B6F4B
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 04:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DF0D3011129
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 03:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E7352933;
	Fri, 30 Jan 2026 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UQp7+dc0"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023126.outbound.protection.outlook.com [40.93.196.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F952F5A01;
	Fri, 30 Jan 2026 03:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745478; cv=fail; b=AdLFqiL7OwDGfrCkMHBcQEyrY2RwFfBHwWF+ADgXmk9k65oKEStoPhf+CWRZtoxrGTMuu11TvYjsPgWI6OLwAGV5nC7z0ny/GfBnHabxRzDgq6ca0ZXp6FpkmHy+kc3WXN2XK/XDMOeDz+iuEKXCPrzvl5bj9zNVeKVc38BXDpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745478; c=relaxed/simple;
	bh=waKtvMA4yfZDb5ITGtk+T3kCt8M4W3qg9ZikZD77/WU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=Am8D0HVe84J3sKFWNzEaVbruWcQPKWLdKJkMsnea0N9EColfYjT9kVTmKG4V6o1X6lgF0FGMr+MKQU1MChUMvpu9Xq9lXUt3PkGjnhRn7I9QXXpPSeCOy5fT8pf9Nd1X0DOPSlFGn+o8Hcs1xL9MLJsL6wXbnSTmsdWi0n49Vrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UQp7+dc0; arc=fail smtp.client-ip=40.93.196.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3TLVPTz50Iy+GIlBfoPn1ZxBoSXFWh1JbmiLkxaU0O5jtsIIgD64VUF063bSQpnjDtN4ZKVi++6VpuyF2lYBU9E8A4f8+5+qgVCBK2Ccq3aAXcudEMq/6uKt8jSr/FnPdfEXBefFxNwn9ToKEt2mpOKYyDi+GZfxKWzFIAfeRR3OPStCk7bbKL1gQo1SvW7S9BxWTQ6eydMtI9OVgdf+hxH+1FV0aDtd8Z5TdX8ROLX4uZtmujufDDGZGGg8ljQudISv8JxyjMsZT59fjTX273fOgiCoIMTUOLif93P/h7DB8sd28Zu6GgPKlaLrzkklosU/jTtHmRcPpRdREPVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDhFrWue8nVkOG3nQowFHXwgfeIXIS3fxNiam5V+7JU=;
 b=cELpDlEgXw6hIk/yRlxw4eWfGMF4EjXTAOsk7COrxzKIGhKxyucKbYIr8BL+hIofir/nfJMqD31AtlPJxSxAP/r0rz9p9DZ8ePlnTIuMhl/O5leEQVaC8DgBodEf5p6hWCVwhlW1VfRpfs2BmRJM6gWKKaswLfY9z7d/wWVONAuL0/gkXYjPKUYw9QKxeM4wmiYymnQsxyNAxTGhasXS+f+UZp6Mdv4I7jxoCLTIRqBcse47XsUBGMbJ13KuyWt26KuDxXP+/uXjUecE457emarSDS30JYtk9nEiS5RDqozb4KxZvEEv5g/8pqcfToRplZY1G3zdn4mq2mg0B+kw6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDhFrWue8nVkOG3nQowFHXwgfeIXIS3fxNiam5V+7JU=;
 b=UQp7+dc013zfgwM3lRY2wxqPHp51LgtR3YKi2S7JZIHSvdbXtIrYOMQQtHW3yceUZuRXNLutta45RTqlYhNF8+QFh730YfEm9F+SV26vxZhVKm0BwjSTItvS4d5/hBpFGmSZt3yxnCty9NIWlmSph9B4GXLMuY+C+8Mmlv9mdeE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 SA1PR01MB9108.prod.exchangelabs.com (2603:10b6:806:459::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Fri, 30 Jan 2026 03:57:53 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::86f5:4db2:7ad5:7fc4%6]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 03:57:53 +0000
Date: Thu, 29 Jan 2026 19:57:51 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, linux-perf-users@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Reject unsupported hardware
 configurations
In-Reply-To: <bb47722fc593baf1e1cc0f944089592a4ec708da.1769695523.git.robin.murphy@arm.com>
Message-ID: <0b85786d-ab5c-e9ed-f060-e7854810b1bb@os.amperecomputing.com>
References: <bb47722fc593baf1e1cc0f944089592a4ec708da.1769695523.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: MW4PR04CA0330.namprd04.prod.outlook.com
 (2603:10b6:303:82::35) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|SA1PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: c66dd694-d20f-4386-df66-08de5fb3be42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lA/wP4viHb1xNh1SjWOO+IQQWqYlnu89gHKTWvc4QhYQIQK2Ouh83YcsG1Zo?=
 =?us-ascii?Q?WOOfjRAIyZZg4yl21T0dJPaGgwa7TJR24er5JxInsgREvtEtaedYwPBH1v6d?=
 =?us-ascii?Q?Vzh94yfAnU4hZ2F5ozkTd4fIwpRJh6Jo57kN2pw72hhwy/zS8ziCBUy2atmV?=
 =?us-ascii?Q?Kquei9C/gulh1NAQTfMvHuFJRp/0XrKZQsNqpHxdOJVRvBPhH34VMe0t9ewL?=
 =?us-ascii?Q?2d7+sesEceG9dsnMGES5HsEO6aFCfG2iM9RCZhgVCpeONqNfrTYOTAAV3rwg?=
 =?us-ascii?Q?0pt4SpaxyjPFNVGEZ2mgdQv8+FjjVpsQM8zV97rvaUityh2sbYTsmqKzT6MG?=
 =?us-ascii?Q?6/RYUubSAXbGJwmEf+fNpA6pj5GAIUaVo7GzadvM8jMYkkPbS6T2VUTB+4mz?=
 =?us-ascii?Q?kXRC5doSRZhvV3Y0YRjXgttWsUPz098O5yQuRkjRTYKJvlDhQS9HXK7BT6uO?=
 =?us-ascii?Q?DvpEyclai8Cy9g+hMGuLh9sPEYnDBC4gXwHXdHGwANyb9d+FLvlO7CuA5xZD?=
 =?us-ascii?Q?kOtyjwPlqPZpR4ofZZs6fDL3F08qVPJfXWUnwa9XNPczFM2rkfFXF4fuwZV1?=
 =?us-ascii?Q?KaaUXZiDF9Yd3i3exIJKNwu0VNQBIyhD/Pk6v8UCIMMjpfMJteC74hHlG9SD?=
 =?us-ascii?Q?QX6PF/Awfz/Mn0vExA5/Z6j0GdmHicelkfsN3NKuE6B4kwglQqrwnq1VF/2e?=
 =?us-ascii?Q?ANS7wlVNZrbWqND50N94Z7Q7NhsRyunVqSLnI0tY5N3/wufSBCERcn4aDLSw?=
 =?us-ascii?Q?uyE8k1Wog/qk63vkknO5MgkOi4mK+WjCX3M2nD5/gBmSkiJkwxUY0GGFHqVA?=
 =?us-ascii?Q?/aAWNF4azpVajYPZyb198KYtX2icMdNOZnb6hNiBfvVVHcC8FuIJH9M8VZs8?=
 =?us-ascii?Q?1GiGlQ/LO4eAeau+YI8zvL2Wxtm+WVKAp3ntg2dFdh3PwHniB1EWt1/mLMXL?=
 =?us-ascii?Q?kEjqDJsLda+kEGaPiE30gmlk7mMkX1mVlBoVkmTsrxH6v1hxUg+CpjsQfnyq?=
 =?us-ascii?Q?/QbbKjm9+Oeh8MUOjDNNZjbLe2/73hAlNZYPm/QeLIvzn8XJsa5o5kLnBszs?=
 =?us-ascii?Q?ihZAwmmioYkfOKgekCJYsMmlCq81Lt6e3SiRkdkRwXIg2Kbljy7jvWohUf3a?=
 =?us-ascii?Q?s/SpFLB799yIN/bQ83T0r7aO+cajrGipWVpUkd+Yp1NVo8p80SVaI9GPtCLi?=
 =?us-ascii?Q?3GAxUxyxnWv8af7erKnxdJDuiV4fUxlCpCMQ/DgoGDAURj0KhLb8heU1VTEb?=
 =?us-ascii?Q?UfCovuKBsNneHw6DFy6Xlnx+dVpdJGTpmnPTWz9t295jDYREpb3CUAyKn2aG?=
 =?us-ascii?Q?6FKeoX2MxILJuF7hhdNztVMiqS4vKjYRzhMOLR6jmTJKsUHsSJE62ZnU4Qm+?=
 =?us-ascii?Q?eEcgJw5t7vKy+dtfAiaZeQfMtVON/XqUZABpi1mAwz6ZzAkHIP/1mSayXxaF?=
 =?us-ascii?Q?sEXn0CNfxXlCAxDR8UA6+ekp3VAqg+SGjvzOFORUHLFtLgF4WIBBW3or2xaF?=
 =?us-ascii?Q?NyR8/owoRNJmyNdiiEgAKQw+92sOyuzt6RYeyRNdcyAgv+vlhcxOZL3bDHZV?=
 =?us-ascii?Q?OXbsqQkJhn1vRxCG4YY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sddWSaYx+r/oF7zQpUeXdPRQDgMHrZDi/HC9CziL1BbMftemV1SnQ9gdyk6Q?=
 =?us-ascii?Q?px4icg4QDKRKSIWLlTf1VrPruP/4juZXcrid2obvHhG5KBFw1KDmFGnKMYg/?=
 =?us-ascii?Q?CJkbfVE90a31wCfyYEkIEAOJ233Vx+oLLqoWRTCqJ5M6oNN+FRCNQtVJKgqG?=
 =?us-ascii?Q?H4b1Mjdi8lDffK9uRat5QopfblQB70Dky7lW7l9w/rScBaxwq67eH+34duRU?=
 =?us-ascii?Q?Wf3YrIyhYVpO4E3pr9eoAuN6qTkDAa6195ysRyOh8TQ7YxjE488eAMAN36ek?=
 =?us-ascii?Q?EQCoIehbB2fqXnjLpB/Po3w43gnx+gJSjFwHdEgDBfbj0c4Ko3HTGQE3sx8L?=
 =?us-ascii?Q?ZWkI54/JJxXg/w2QbEyKPmk7T34FUQFmc4ghKgRPZNct4LORGPwQvyDZcgOH?=
 =?us-ascii?Q?9HbpSck65UI6KTnPxBU09zLWguRaRiETw9HC133gMBOzH4uGmqKxaQLOjfQp?=
 =?us-ascii?Q?9BzgSP/Yi3fFht9XgDvvn49zWK3WsZwkYXvTcgEkRTrNV3JKYdDkQSEVxVlB?=
 =?us-ascii?Q?a9I/jGBFkcxwmYyxbl+Is1EBDu/Yb5Ab/wHL8CAYeAMBbxsoN/B1zaylQJlv?=
 =?us-ascii?Q?zqPysai04GSBxdkBYTuwzqBKxbOeh6WXaJCLjLJ2fpo/Rh7Z+jmge2Zk8/NS?=
 =?us-ascii?Q?pUCBflvFNc349JUikeoycDfKhIcDasbq56k8d6O6oDdnRUaNEg051Mq1A/Ly?=
 =?us-ascii?Q?x8yafsXT9Ycl7LMe/AAo9yTCgCA6jZkMZi82ZAe7QYCA7uemxdgbRbDMEimV?=
 =?us-ascii?Q?eyCZHQGtaRn9UxG7aHSelRznZCI7VG/vfHhWW9QxvR5uYdABdvU1D8NBFHkB?=
 =?us-ascii?Q?fkIlPdbv0a0dAlWBFRtV84/KSZPJarEB8Eu0uZC0EJ1eV1g1rGpJ50HKA1dC?=
 =?us-ascii?Q?xVUAEA9RfVO3dI5oBmBR/l7GpP0KERfgLgCKBLlq69hUSv7te6h46Pqs0QJc?=
 =?us-ascii?Q?/iVoum6Yp6B4aVntIomtOUuZIUnBwNZgYunrVLE+W8di/DVc7Cl1UJPQMocr?=
 =?us-ascii?Q?Q7W71K+9EW9WBsX/JTUskdZZ3Wj6MVesvNl4IjUXNy2XdPf96QnCEuEIys1B?=
 =?us-ascii?Q?5i+gIQu7QiA2POdaz4RwnityC/py7xym4aYYWqjU2Kcs3yDy7j4/11YUu+qt?=
 =?us-ascii?Q?nXrV42CsE0GvWIi+HQxlUf9oKvKRB3UNuoXpDrPNlzvQBrKjT0FVZWFDRboq?=
 =?us-ascii?Q?ly6cOcuoa0UNQ/0th5hzCJ5qC2Huqc3aB2VrV7QH06nznaNxAYmJJ3mNDwWW?=
 =?us-ascii?Q?TF4/gZ8eLyYBRk654EpqdCUlz8r4q/PmlIRzTX+UoS6LucqS0+I59ScyB65D?=
 =?us-ascii?Q?pCwmJaBY1UxXJ/CfjZBY/1TtAzi6eHO2pE5YS5SFfbH7kZ3EhWhKS+Lx+0jh?=
 =?us-ascii?Q?HOUDso6V+t15EVXJ1TnqH6ZIw83USYzzIqRT9jrq1kImBmc9NUgNq84/bN7F?=
 =?us-ascii?Q?71pxo42xZTXSJQOjzsbRnss3PBiqUdGmCA3DSV4d7Dq84f6aSdQuMkcjFfSv?=
 =?us-ascii?Q?F5766IIByWDcbOtCJy/SJ+7TCiTD5/eE9dHW+6B0ttzmv1sEg5RGUVeqxSKf?=
 =?us-ascii?Q?EtuAU4AAUnaDqBCK6pq3dSPD1XF5nGg4Y+9HHvUJxSoMhsgzjI6uKut/CbLq?=
 =?us-ascii?Q?+jba8O116wqIP/aXkaVdQMsSQmt1QKd4fHv+vbL3kpBuZeqUoCg4fhjUOc4n?=
 =?us-ascii?Q?wkB4QB8foRT0nOYMPJ2VN1IDjf4njrag32whMYCl8DyvuHL2FCcmN1vnv55i?=
 =?us-ascii?Q?QZ/4Q1k/uenhUd72nivR93Rf0MEfEJs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66dd694-d20f-4386-df66-08de5fb3be42
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 03:57:53.2941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDVtekTLKHuZrd9SMKtme2o15c/NCLs+hsf+1Bg9JYlNYNfVlFJvFWk01PatTlvwuezP1EYIfOQZXwqY1cpPZjmRWNp4AzLoZuPxE5zt6Q9TP8IXMNVLgfbMZ28qqEfb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB9108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212835-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilkka@os.amperecomputing.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperecomputing.com:email]
X-Rspamd-Queue-Id: 33A53B6F4B
X-Rspamd-Action: no action



Hi Robin,

On Thu, 29 Jan 2026, Robin Murphy wrote:
> So far we've been fairly lax about accepting both unknown CMN models
> (at least with a warning), and unknown revisions of those which we
> do know, as although things do frequently change between releases,
> typically enough remains the same to be somewhat useful for at least
> some basic bringup checks. However, we also make assumptions of the
> maximum supported sizes and numbers of things in various places, and
> there's no guarantee that something new might not be bigger and lead
> to nasty array overflows. Make sure we only try to run on things that
> actually match our assumptions and so will not risk memory corruption.
>
> Cc: stable@vger.kernel.org
> Fixes: 7819e05a0dce ("perf/arm-cmn: Revamp model detection")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> drivers/perf/arm-cmn.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 2903e01f951f..24fec53ceccc 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -2422,6 +2422,15 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
> 			dn->portid_bits = xp->portid_bits;
> 			dn->deviceid_bits = xp->deviceid_bits;
> +			/*
> +			 * Logical IDs are assigned from 0 per node type, so as
> +			 * soon as we one bigger than expected, we can assume

Should that be something like:

 			"...as soon as we see one bigger than expected.."

Other than that, the patch looks good to me.

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

> +			 * there are more than we can cope with.
> +			 */
> +			if (dn->logid > CMN_MAX_NODES_PER_EVENT) {
> +				dev_err(cmn->dev, "Invalid node number: %d\n", dn->logid);
> +				return -ENODEV;
> +			}
>
> 			switch (dn->type) {
> 			case CMN_TYPE_DTC:
> @@ -2499,6 +2508,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
> 		cmn->mesh_x = cmn->num_xps;
> 	cmn->mesh_y = cmn->num_xps / cmn->mesh_x;
>
> +	if (max(cmn->mesh_x, cmn->mesh_y) > CMN_MAX_DIMENSION) {
> +		dev_err(cmn->dev, "Invalid mesh size: %dx%d\n", cmn->mesh_x, cmn->mesh_y);
> +		return -ENODEV;
> +	}
> 	/* 1x1 config plays havoc with XP event encodings */
> 	if (cmn->num_xps == 1)
> 		dev_warn(cmn->dev, "1x1 config not fully supported, translate XP events manually\n");
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>
>

