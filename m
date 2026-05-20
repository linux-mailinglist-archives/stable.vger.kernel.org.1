Return-Path: <stable+bounces-249789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dyvDL8t7DWoVyAUAu9opvQ
	(envelope-from <stable+bounces-249789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:15:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDDF58A805
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5E963008287
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0774439C00B;
	Wed, 20 May 2026 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="f6EMx2uw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DC12D7DC6
	for <stable@vger.kernel.org>; Wed, 20 May 2026 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268482; cv=fail; b=q9wvlrTaUQhxXSHeWr8CfOZziJts4MlFdbI4msyu3ILbDNvMpvnaFtkqv/LY/Og62zezu5plZTs5/u/qyr+S+5ezvC0fROWT1z1JXqOAaWGpsJ7rBaGZZjgdr+pANaG/SZ0Phl3wJlaTF15um9wppcLDLiTK96yGbLzGX0Xvd9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268482; c=relaxed/simple;
	bh=xMaJ/HA4q/zGAYOlSkWZQnawY+vUlY9193uGmWRBTWI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iX/D9h7aMUcVEI14+k2PGX/9ygKh6sTvJSnzhj+tLuGIhhuBiN26NsLekmRZznMTZResahJhsQ2FjkbZaqYW4wAQ/XO0tNc/HglcWwb49wVeBNjA/AviGZwAU0bIskMN6GwpkFtmVIALaO3ByDPhGqynhposS6wJivkxI/td1/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=f6EMx2uw; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K51rAq1372086;
	Wed, 20 May 2026 02:14:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=qKfCm0jFz
	TJKt/sIc6IDIYXftMOiF0QxVFwQSMgLO0c=; b=f6EMx2uwdOeTFWiiSjpBUYadI
	PRSBADAg8d1MYB56eK5oW9W1+d/wllz7agZ27owNv+fkTbc3/jREanJGj3kC7/4Q
	hgBwjYSOKtc33bP+nITLRdB47yJLztQN2dpvqdl7nzBJ9ZFZSykz0BQoq1XuO/zh
	OIMjkUBs9o6Fhvc5MTWY9z+YZPxIK9QFx9dK68yOcXMEYnbchjAPJs7s00U0fLHC
	ssTgKZxh/CXsV9KCbQyFeZw/iUaHrqxECf6ki/YPtIwVDuU1IjIxpEqv50XQdGWl
	WCwA3PQNAin+fockoWlcgNYu4F0H+mnfb5kguQ3xPJdpSwV8x6W71ww+fjJEQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e6r3gcw53-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 02:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/xvyxM0Rrtoe3nImn0XUr7xuzo7lBDRyV+Tu8dwq8WyZ0bdSvwO+U1aX7JJZJbm3nRDvYwYE+OYdkGFGHQ9Hzl2LzqNLsGOOKXmeeHkW1+VfMP7e2iuLPWabgZFFGCi8evQ6JQaEqGo7HQwiWEuAVxZkDo6XWm/FUscqYl+XmTlj/zm0FZhUWyhSDdxaKHVthTEls4oaHQBhIfqLgYjQ2ll3OqdChWVoZsPhtV4bmIXrTsVKOlb1z8YQK6YfOj+vpxBfAyD51rnomwE/sjIBFbVg33g14jvTBesh6Xy6auSbXwg57Ff7ksRpVpHhRy5Ry5WbMrPEWfkq+HUthgVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKfCm0jFzTJKt/sIc6IDIYXftMOiF0QxVFwQSMgLO0c=;
 b=ITZyKUWy0yaDrfHM2igGwCkJ1hNTQDGVJdLcVOjrvAqW9l96PwxgpGY0/n39ByKogbe5orS3PdiMitSjJ8pQ6L160LRWL4ngzMNNg3KIwd+yH4nXIKUmtBIPf2eqC0T1Qic73My6H9Jcv799krFmkciX1o/hCbPcy/mI14lR1Qg7L0FZiK1vpZ5Tl74/pSWX76qCwsc4agKYZjCsiijcBjcNbaPriplD8pzFIeUH44wxfnO4KQCVzh0y1j2hvzhXbk6WIcj1WuftQqD+1twj8GXgUb5jo9v3Qm4yXNJXjsNnJJepK7MJ16Dc+PJPGJGcuGQ0mZ1YEIeSXea1qFaTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by PH0PR11MB5175.namprd11.prod.outlook.com
 (2603:10b6:510:3d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Wed, 20 May
 2026 09:13:51 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 09:13:51 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: will@kernel.org
Cc: catalin.marinas@arm.com, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: proposal to fix CVE-2026-23346 on 6.12 or older kernel
Date: Wed, 20 May 2026 17:13:36 +0800
Message-Id: <20260520091337.3799553-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0029.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::6) To DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF641CF4859:EE_|PH0PR11MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e1d5a4e-94c5-400b-188f-08deb6501b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014|5023799004|3023799007|11063799006|56012099003|18002099003|3613699012;
X-Microsoft-Antispam-Message-Info:
	TwI0+co6U8WFNSshtMzhW/iLqK8uGtqVlXhd9U8tYAWG5KBx4WYrP3cPVQCuYcVvwxiPFl2iPocycMrBENCFIZOQfN23eio23gC8+KpDawfjObp0CiRLLQdsnLsD7UqsPN4e62o1Zfaigs7EN17Fh6HyQnHqyRA1LxA2P5QFUHiv3p/1aUy83jC+TvQPIg5ThileIpeDWjUqvLb4f6uqLbSZVOnDAfxvvCJlZh+7/rsINglkm/UmbGF9vyGeggWLF5DTDuv9Jk8Uvk5N9gh0+Ir/inuc+et7kz6rD1TOgsgfXbpZuwbX4LBSHu7NCODmkZ9VO1QARMn3f1oeOZ6+rx+yR9BwcYBP1j8nqTCtr6TT2dsfLNnqWm8XQONA/V/2GsWd1VVVnbC8GxQG9skvXgn5NEm5Zkfl4pY0WyWMCeHVYHL6iA/iUOmzDxWLp5IC/vDdgREt60xJ+kI+zN/RvulxDcq7fAhu5+lJeRd/6nKMQh8wYn3j95v9NYM6GGNMmTlFm/1CzfKgmSYZVPbGgBTutOurbGXSIQXUmlqWEdSnpPHhMOPjzwZyJ4ASMXMRyDjc/NtYWQojgsk/yzAEf2omFtTZbwgp0IJ1BQnHLujpAOTw0WElHJzY+g6X9Kc6ML7iG/vcxz5MEN4tnvNOpRLJpjM6j9R5oOqsjnZ0Mb8mlp4ItlgSwIWl8KxHdz7vfvI+8mnZllsFuw0f40H+1RqB83znLR6fGlCoESiLDvO92kI/2vH2XyjB8y7HOXsWGxG1mhQCBCx8eun4imugbw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(5023799004)(3023799007)(11063799006)(56012099003)(18002099003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oe9UK/3+VEPPlNmi8jDtXMf2uP4K/0a56eKOJ9EzKx8g1Bj377UsekuyfrUq?=
 =?us-ascii?Q?9jU6u9cADcbz4zK4UKOd7FbTI9gBgILBWISOpKo2Z/kyG4ePbUO8UYJblJMl?=
 =?us-ascii?Q?hOIZtgnazUBkawkHiW2FrzGRZ5G8th9mbt6/TCH1D0TILizI8MGAJ1d6BnYq?=
 =?us-ascii?Q?jrj2v3NB0syK1N98oEqVq1CZU5e0i12iik+cGELZkCufkaaaR2mYzgOOGneB?=
 =?us-ascii?Q?/Th1fljPcfSWjzqrVE0nRIxp8/M+rfO7eA+ebY47w4AeGeENNDbrLlWeb9rm?=
 =?us-ascii?Q?0xp7E8fWIKLDF/DjvvGiLpzTmiQsyObSm59UOslpWN+q4UhLLlkJEJ8GF/nr?=
 =?us-ascii?Q?YGhXk+F8uWq4qE+sKBA9K9zEILREIqy4Z4t3MgWtFl+TooizSu/g16jLmAoA?=
 =?us-ascii?Q?7xrufT6U2Zo7Vc8IAykX6YVtasLDmc+tc/JWhGe5ucZ1oMzbnXLvwz10KYn9?=
 =?us-ascii?Q?DrRfjN2xFk09RvwaaVrqLOewy2Jhv4dyIK69EIpJPEW521uhxjtW5T46Tqiq?=
 =?us-ascii?Q?la6QzO7AZY6AAHLw4ylJKUz7hOD/2gVhX+MRJ2ltUIYJhfmQLu8k0Z/0h8eC?=
 =?us-ascii?Q?99/LDn1aLRG8s1BzYN+awrrXRjvDmmRj4/JfXrdYYBy3YyW/JMR//xnL4//x?=
 =?us-ascii?Q?F5LH2LyM9DMgcQsrHYKhJ/a/g21vPuf3QgK+YK25jT6lxEC+VlCk7ES5W/ht?=
 =?us-ascii?Q?GTZ8Pa+zLqWp0hTv73IrK+8hxFYVoCHh+F3jSVGfBU6zKHPARmy/+bvZNkFA?=
 =?us-ascii?Q?ZTU5grjgDfCN5cQ0trj1HsT6A5lkHXOhkE+4uNTjXbCJt09IXMj/sNqNjLlX?=
 =?us-ascii?Q?MwFXAfqYGnb6ocWWqUYRgr53bYtLFenm7R754GH2nWADu1jFgHDZlxibQpYl?=
 =?us-ascii?Q?Gfbd1QF9lM3gtIm4XMFRNVtPnnsG1SKHanlur7z2mlodEE+C+Fj9XUzOta94?=
 =?us-ascii?Q?3ZB2h1DyVD62+8iN1OtHd/HlRRm/misfuGmGd0yV7u1r6gv/o48p5SEQhqjh?=
 =?us-ascii?Q?uZMS7B0Rl6gpQZw8FERBnqfkiBTl2b99atNcstePxLVqfRFtnpxnaHwCmtUQ?=
 =?us-ascii?Q?YTQDqdaACbUahXQ3/gcw6COVAWZ/wIAlr/4nOmNAX6AGdXBoCu03JoaKnl4y?=
 =?us-ascii?Q?9gM0EMOOBjG2fLlEJ9cz6PgbgQDVFVgNrI69C2LfE7vx6hZLjwzNvHfe39P0?=
 =?us-ascii?Q?Rdwa9dINa8if9NSqYKsegYPoQORpHoxVYlVPMNc3CIBHxHnZ7kHzsVkYoLUL?=
 =?us-ascii?Q?Qwot+VKCCEboRAqIlxNnbZPUFBmlLLveD16Qi1WVnv5RSnxc1pWDAYxPwybg?=
 =?us-ascii?Q?HsufyWaEzsfMOzp274CHvE1xE9+DXbOvYePFMWr53egXVe+TwaOzIsijpXtb?=
 =?us-ascii?Q?1PJoeHNvVdDs9fu2gLQY8BNCnbAct/TwdTYR8tbVrriGq/YccvfIT4gfTU7f?=
 =?us-ascii?Q?YpcpZxA6atProb0cZg/vHAxMBarRholyRvxP7o0eIBxxddVXKACTAD+rXgD+?=
 =?us-ascii?Q?bw5qMGCZ3cyTrmeS9JnM0IRnzzB3nReEVwANAcquYdI00rgTs0651PB/A2sW?=
 =?us-ascii?Q?wQBFv2YwB9zPuPFkGk2wHUMrVW3cTXqBuyM3i+mxHwMA+QQ+H/TE6nmL5hWT?=
 =?us-ascii?Q?7Np3S8GBGEbdRSFuL4RtbUaUSA2ddi9hoHT3/8mhjViFnBiNz+6Y1eikmEAn?=
 =?us-ascii?Q?7BJX3ikyc1YyMqaladkqyn5/aLsVA8EboGhRz6Sv6qfLRgQz34Y12bV9YVSC?=
 =?us-ascii?Q?kAWTQ2J0v+9jrmfkEhyNKp9xcMa556U=3D?=
X-Exchange-RoutingPolicyChecked:
	eT8KQOvxPoMdB0Xcr+R3q0MfdXEFMXvHWE9F2M4QXVZ9OPuXSPFeBWFdN6DmEPGbdK+6e7FYRmDhm5XHWvknhNK0W7nl8G+vD6KLPYjGst0czm3Kp3F7HDCr8Aaegy2lJWxF2G9ZHTfGpU6MPFjiFEyvWvNcTl88at9hRJSJHXMFaS8ry/1ktDhnRuf2MaMPYKnYT/2JeNy1k9i2NlBVjOcnjuVGUsUiR7ZxsXmnWwWZQp9B1vYCRlvGXCLwjhwk+vKRvQ+Y+hr0hpweJcRQvP4dwHQIIufYDi6bdq4jIsXS9U1pXdNak2czNFawCtfLi8c9bQhByVx7K2fFIaDBAA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1d5a4e-94c5-400b-188f-08deb6501b9b
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 09:13:51.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QIF+hGRwGauTV/xy9LEYaEQhMFo1LxMYMa8D+iZRCzsiBj+oCdi8/QULry/hVz/ORfVUt+tazn0QxNe8BomdbQkU0s2zec4VepemK2foBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5175
X-Proofpoint-GUID: eeA4KcfTDOpcz1YOjWlXbf2MJqdPgveM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4OCBTYWx0ZWRfX8LS1SxpjfPBh
 p7bSZQpKyRGhd6yA4DhS3nKbf1w15wG7qwibJVnxch8/gQYQoetCXm/f2m5XtTl4ZjkNFCtJrEg
 mGJQKGupoaOJZ2vya738Op9uG+lV8+ljgXgi/qu5AXufnu6FkGLnfi/I+qpuJWxpiQ7d227+HBI
 xGv7LbirrdMLWoD3+0KuFePtkCaNZJLpWxeRSzSBfyJu2f5jxlLwo4ig8SibWZkAPKi2/J86YdL
 3Q4Md6fdorUT1ahxRc84yk7cTA7nOjA2RGo5akNbD3wwqbaufiW80QWJy8kP7IN60hIa7k2R8r0
 sbnazDH6nGrSPv6HM5v6Hqg5c4TfIxYl1tk3KK8fvv2Bzdx/R5/BxV/ZKQOqQaWNP4ORi2OB4QT
 2pScfqZLUG7qWKCXHDq2pVI2/Y0+NJ9dZlse43Bz30hM5ejXz2nDuTr9MkIY6PHtLT1rBQOhYJD
 N6rQyDLUh0N40o42p3A==
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a0d7b74 cx=c_pps
 a=ItoRIIcZIWT0tNr6APkIeA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=zuSxMGlbhfVIKaXoyrkA:9
X-Proofpoint-ORIG-GUID: eeA4KcfTDOpcz1YOjWlXbf2MJqdPgveM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200088
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249789-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xiangyu.chen@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3CDDF58A805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Will,

I am looking a CVE issue(CVE-2026-23346) on stable kernel. It was fixed by
commit:8f098037139b ("arm64: io: Extract user memory type in ioremap_prot()").

I have already reproduced it on 6.12 and 6.6 stable kernel[1], but
directly porting the upstream patch's macro changes inside <asm/io.h> creates
circular build dependencies due to the architecture-specific GENERIC_IOREMAP
refactoring introduced in the stable kernel lifecycle.

Since this issue was triggered by generic_access_phys() passes a 'pgprot_t'
value determined from the user mapping of the target 'pfn' being accessed by the kernel.
On arm64, this 'pgprot_t' contains all non-address bits from the pte, including user
permission controls (PTE_USER). When a process attempts to read the target memory via
cross-process subsystems (such as reading /proc/<pid>/mem or via ptrace), the kernel
re-maps this memory using ioremap_prot(). Since the PTE_USER bit is incorrectly preserved
in the temporary kernel-space mapping, it triggers a level 3 permission fault on systems
with PAN (Privileged Access Never) enabled, resulting in an immediate kernel panic.

To bypass header dependency traps safely, I have changed the backport code, this backport
confines the fix entirely inside the implementation layer of arch/arm64/mm/ioremap.c:
1. It uses pgprot_val() to safely unpack page properties into a pteval_t mask.
2. It introduces a targeted safety check (if (prot_val & PTE_USER)) to
   selectively strip away volatile user permission parameters.
3. It maps the memory through pure kernel attributes, leaving standard
   peripheral device drivers completely unaffected.

(see [PATCH 6.12 1/1] arm64: io: correct user memory type in ioremap_prot() ).
The code I have verified on qemuarm64, after applied the fix, crash won't happen anymore.

So, could you help to review, if we can use this solution to fix this CVE on an older stable
kernel? Thanks.


[1] Test steps:

1.1 Code & script:
C code:
------
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

// Using QEMU RTC HW address
#define PHYSICAL_ADDR 0x09010000 
#define MAP_SIZE 4096

int main() {
    int i = 180;
    int fd = open("/dev/mem", O_RDWR | O_SYNC);
    if (fd < 0) {
        perror("failed to open /dev/mem");
        return 1;
    }   

    // Start map
    void *map_base = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, PHYSICAL_ADDR);
    if (map_base == MAP_FAILED) {
        perror("failed to mmap");
        close(fd);
        return 1;
    }

    printf("Put those info to script PID:%d, VADDR:%p\n", getpid(), map_base);

    // Keep running for script trigger the issue.
    while(i > 0) {
        sleep(1);
        i--;
    }

    munmap(map_base, MAP_SIZE);
    close(fd);
    return 0;
}
------ End of C code ------

Python code:
-----------
python3 -c '
pid = 506
vaddr = 0x7f9de3f000
f = open(f"/proc/{pid}/mem", "rb")
f.seek(vaddr)
f.read(4)
'
------End of Python code------

1.2 Usage:
Ensure kernel enabled the CONFIG_ARM64_PAN and CONFIG_DEVMEM

Start Qemuarm64 with -cpu cortex-a55 -M virt, e.g.:
qemu-system-aarch64 \
    -cpu cortex-a55 \
    -M virt \
    -m 2G \
    -smp 2 \
    -kernel ./arch/arm64/boot/Image \
    -append "console=ttyAMA0 root=/dev/vda rw earlycon" \
    -drive if=none,file=rootfs.img,id=hd0,format=raw \
    -device virtio-blk-device,drive=hd0 \
    -nographic


After enter the qemu, using cat /proc/iomem to get a vaild MMIO
address, here is using RTC address (#define PHYSICAL_ADDR 0x09010000).

Build the C code, put the binary to target qemu system and run it, the
C reproducer would output the PID and mapped address, here example pid
is 506 and virtual address is 0x7f9de3f000.

Fill pid and virtual address to python code, without fix, kernel would crash
with "Unable to handle kernel read from unreadable memory".
Based on crash info, pstate: 20400005 (... +PAN ...) and FSC = 0x0f: level 3 permission fault
Call trace:
[ 678.563102] __memcpy_fromio+0x50/0x98
[ 678.563436] __access_remote_vm+0x294/0x3a8
[ 678.563901] access_remote_vm+0x18/0x30
[ 678.564308] mem_rw+0x1e0/0x370
[ 678.564534] mem_read+0x1c/0x30
[ 678.564754] vfs_read+0xcc/0x2d0
[ 678.564975] ksys_read+0x7c/0x120
[ 678.565192] __arm64_sys_read+0x24/0x38
[ 678.565450] invoke_syscall+0x5c/0x138
[ 678.565729] el0_svc_common.constprop.0+0x48/0xf0
[ 678.566038] do_el0_svc+0x24/0x38
[ 678.566264] el0_svc+0x38/0x108
[ 678.566514] el0t_64_sync_handler+0x120/0x130
[ 678.566823] el0t_64_sync+0x190/0x198
....

The behavior is the same as description of
commit:8f098037139b ("arm64: io: Extract user memory type in ioremap_prot()")


Thanks!

Br,
Xiangyu

Xiangyu Chen (1):
  arm64: io: correct user memory type in ioremap_prot()

 arch/arm64/mm/ioremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.34.1


