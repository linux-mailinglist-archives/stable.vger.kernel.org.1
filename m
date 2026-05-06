Return-Path: <stable+bounces-244385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOzlMkg/+2nTYQMAu9opvQ
	(envelope-from <stable+bounces-244385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:16:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5D04DADAA
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 15:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 605A5300A4ED
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 13:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807E3ED5D8;
	Wed,  6 May 2026 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="xszJfZQT"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F543ECBC3
	for <stable@vger.kernel.org>; Wed,  6 May 2026 13:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073412; cv=fail; b=AUZuKX9CCZFx+I/5+Zm9/LDFUlXOSl6yCzI/q8DSm34uN/uXWxrl8y1KnrLxQnYO5th2RYL2FdcTVP4WuF5USQnaqJY8XaUFz3RdQ6B6nfSfFC2ocOwNU6YhaFk7kdhm/fMxmxYdDsO+lpVuErsk/sAy/KvHucwcL0Ef7yj4a+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073412; c=relaxed/simple;
	bh=bwx3TsKoqDYv0NTrlVNdniypEaHobElm1NWURP46v34=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RpWo88GoATQ78Gb2ODql0jBhXjtDfGribD0rN0JzS2+fr6Kym0mtnLF1qNAzPNKUE9PeZ7fchNHZvG+RzOKnpV4rQwKnC4WdDPJjnUNpKxn6VkhgK29oAIhOFqu9BT2ed7wTGIN0BJw3MyaCnpDRW/fD3tSRz2Y4li6RqKN0Z5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=xszJfZQT; arc=fail smtp.client-ip=40.107.159.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTVyg23zEoT5Iy8BsKK9e1IAsUigFil8BoBwMnSAZ1Y4uiDO2VjkH7XKTNlqSIg6iRbTTW1ZKxtHmT4D/ZPxn1EfUlIMYI6Oe5Atp6nUG1bkRUlWiKpzKMAz5wSYS9pgQfdbbhAdBMuw43uqcu0Y7S26Iy8Ag6COZ/pty89VIkt28cbSHquor/8Neuy73cQNKm6a/q7dBawlOIP8ycdOtWus0PWi04EAaAzZtTOZeKRc1Kl9jTlCJ4nfi5cHIIue56njt2T4i+4sb2s7Eoh10SmSLrOa4StYiVZKpoS/V0L0twPW8IwuoQbSrz4CDDOHCxEBC4W8sPYd1SGnMUPl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KyPT8Y/mLElIARyqk4oPnab6WAY83Dza2lKzeKD4hc=;
 b=fCaPEo84041N/z4lHh0/Ba/b25BDRFtYoSdCn6NH2q34GUbYjxuD7caKmp+YOSXBfNuNOTeWTN1rdJY3qobh+q2vJi9auxm22uUAWYfuBrJIrcPcB2nsqzNVamQ5ltxVjTWJ0/BFHfjeVdUkBmwvGMwjirccs/6icaAx8KpqNWTQxsfm6RJYby08rkmH6I0e892SJQOFaCk2GGrVQBW74vkxwvMDhr7VC5dfoedUPlNRCeQA85re5o8NYiXBfSqTs23hS5Z9owMOzzz4A0T9Z+1Imijc8Ch+q+YNOayM1K38nOhuFPMb+H7NdTo7ty9jbx7xPEu8n3vkJHX2Ln4vCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KyPT8Y/mLElIARyqk4oPnab6WAY83Dza2lKzeKD4hc=;
 b=xszJfZQTcuomFaqew6bhr0s0RoE4CqYYrbHMeCafJGkD6nX/gpmCXnZn7oQ9HTpoOnq51WDjO6UaMqREdNYYpj2jpmnL27iP2h6Uv0hTDnXM9jGfUnUf9CHXaRSctLZ73A+3ZG2T5sLYk1Cia5usoCyLyqVqQgTcn2FYaEtXF5p/y8SSRu/v7Ih86IcUtcZ7vw8agiY14pvqbyYhndiBSZUL2xffuyugH0H05CfIhCObLh1qZP+5kjyVzE32/osGajREjTAOiuDThWD99cKlVobFVt+ZOGqtUrljWhIDN4y8Tt1RUO+L4v/CMIH1LZbPy9M2Xp1khearlMSGobGQsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by GVXP189MB2055.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:6a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:16:44 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:16:44 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Chen Zhen <chenzhen126@huawei.com>,
	Jussi Maki <joamaki@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	ysk@kzalloc.com,
	42.4.sejin@gmail.com,
	Yunseong Kim <yunseong.kim@est.tech>
Subject: [PATCH 6.1.y v2] bonding: fix use-after-free due to enslave fail after slave array update
Date: Wed,  6 May 2026 15:13:20 +0200
Message-ID: <20260506131319.525949-2-yunseong.kim@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::8) To AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:39b::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB1752:EE_|GVXP189MB2055:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f7f0cf-68ab-4254-79ca-08deab71b81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dgQwUPNIKI8Cmk4kbn2fwaCLQVYd/eogUFhWPRYwfo3ienyecIFK1n39qRLYANszj3s98RrfvbUy/I6KRfLQAtwFKffhfwZMZqphOkZ8OVKerHrY0bNUCFd68FNZfecDyCs0BoHr3t+tOHnWJ48LYrDK+odd+x1/LfbpEAsss5rSuLNsnFEECSFJMIMwwgYCSqJRJbEqd2P8DcWSrErwvxFbfJXvjTKgNw/EAxa72rS6zZ22blj8HFABomLLQj+mAAlV5bgoqIaEqxbATdkPoDmnkmFxawDc2Pe0bXH9fzEYt/OOMBHJO8mW2JomSKP/v+Yze9xZHJpJJzlIK6ulPWRBoG/KVtO6e2FxQvOdUqQ1CorKF1lAqyLWLw31PcNyPDz5/Z77jfeGoCbxSdogmKlp2rM9DK5gY7dK1P1VOE7dgzEGoVqClQIjdnlKI/ozOd7wDFzokrroCrZaN/sPi6VKVRHoMy8wlrgpnTF0z4E5QjIOzM0pLTxuoTQ/ln98AiQXhq0KpTPZkQ+/9RMzHeLOZjnWQl7elU9jO56qM5enjOeN9ijFuzE+snljF/X1Xs0H+peIY3RPhiKv+HSmPCyojGrGGgtM1bxXadiZLG1c8SA7uE93ZW1o0bf7QUFMoZ+cAgvOHZArp1l9e/LiNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T09HSFhjVzA0L2diMlRnZVptMHhGY2tPMG1EUTg5Zyt3V1dyRFVobTBJVU5x?=
 =?utf-8?B?SE81UEEzMnowckR1bktZcDVwTUkzNlJuWmpmK0NSTkRwaWJ3dG9YOWFHeWxP?=
 =?utf-8?B?eGFOcGg1S2R0VUNSY0tyY2xwcGF0RzJwK0xRVHZmWC8vSVpyTFB4S2J1K1R5?=
 =?utf-8?B?eVdMZjQ0WTRsQXBCRU04dDZNcndkOWIzSEhiU2hjZVVVbjJsRjdOcFdPT3gv?=
 =?utf-8?B?Q1IyRkxBdHBaYitHSzNTc25BeTRpamJsVFdBNmZCRkZKcEx1ZGJuL2tDNnJW?=
 =?utf-8?B?bW1QUkQwY25tQ3NkRWppbUt1M3VjNGpVNmhZcldaaEI2c3RFaklxb2EvSXhy?=
 =?utf-8?B?VEZHQnUwS0xKSEVtbzZiRHhqdXlMTXRPNks2UHVmUE9UWGoya21NTW1qcmFm?=
 =?utf-8?B?eWl0bnduZlprSUZhN2dTK1hIT2tyU0xPZDIvN2NuVHFNK2NDUGU3RVB4dVRR?=
 =?utf-8?B?djV3QTZTS0JsYkRqb0F0MU4yb3BlaUFPeG05OFdvSlRoMWhseGRjNUR4MVNY?=
 =?utf-8?B?SXdQbXUxd2w0UzhxdEFOMVBxKzRPYm1WQ2l4dUVaRGJ1TzhnWlZUekNWT2hW?=
 =?utf-8?B?Wmo2d0x2NUZFc1k0QlFZTFRNRGJ6dS9zamoyekJqTDRHY0x6VzJCVTE5MERB?=
 =?utf-8?B?UWk0dTd3OFJTaUZacXYzR3Urd00yY3VDZFdoVDNnTUp4T2xKQ3Q3bmlNM25m?=
 =?utf-8?B?c3dXRVN0WW1aKzhlVmJlQlFTN0xhTENySE9PTDV3TGh6MnRsK29ISVByUTJH?=
 =?utf-8?B?WFFUZWhSSFh6RTRuSkhvaHJUWmNQOHZVL05JTHMxTWxUUGs0L0hZZzdUYVVx?=
 =?utf-8?B?eVhheEVUVThQTkVpMjBjS3RVU1lSejVJeFA0L09jMVdmV1hQTDJjKzEvdElX?=
 =?utf-8?B?WHhUaERjR056ZmdBSEdnaXdZMjU1aDh4R1JLOFR2U2pub2VmekY1bWhsTWk0?=
 =?utf-8?B?V0ppc1B3SW9XaTZGdWRxNVhuWU1wVjN1WEE3aTR5L0tVbGdTODZTMFZVMm1Q?=
 =?utf-8?B?dll2SmJSVkduaWE5YmI5UlE4LzUxV2pibzBEblFtVkVaSWdHUGhJVU5ZeWk3?=
 =?utf-8?B?dGptK3JyQ3NoMGFPTTRLOTZTSVV3NG9RbktWQnQvQkh4OXphSGIzZHZYWVNV?=
 =?utf-8?B?aXhVdjRkNWttRTM2eUtWM0g3c2tUNDhFdDdpWG9hQVFyNDczSC9NY3UyYzkr?=
 =?utf-8?B?MnFtaDh6c0RFamZBeWdUY3VrMEZGYXJMSzRVYVd5OWtHUTZ3Q1ducXVjd05x?=
 =?utf-8?B?bjl1R0FzY2ovUWlBZVZqeUtVN1BJSnpPOFRhOGFTUzZUZ2tsTlJCWGN3YXJo?=
 =?utf-8?B?VzlDc0x4NHlGdXVIYjR3Qi94QWsxdWVaRE1OcnpGSHh6OG11YnBMdU45TVlS?=
 =?utf-8?B?dkczNkM1ci9NayszcGdmWVBkVmpUUVBrNVhvL214RGk4NVIyc1pRNStHc1Q3?=
 =?utf-8?B?QkVwUXp2QzJLTWFqaHRMbUQxemJ2UzZoaW4vdmdlcTBYb0NiM1Fpa2c1dkpm?=
 =?utf-8?B?VVFLVktSTDBNOSt3eER5d210aVh3V1B5UjhsY2hZUnU5NHZveWh4cVRLTFk0?=
 =?utf-8?B?SFoxc2R6cC83enpWUWhvSlVhMjB5U2xGenVqZ1lDNkFZZi9ub0lVZGlEK1A1?=
 =?utf-8?B?K2wvekxJSVFvdHgySk5uSnpqRmdXenpJWFNNUGtuaE9VVDdHNitLdzRTaWdD?=
 =?utf-8?B?byt1dWY4VENHaFFmOVFvTGFwR2Z0TVpISEdZYURsSFJxQkVEWlVReHd3empq?=
 =?utf-8?B?VFRnc29ROEZZMGg1T0pIK2tVWjUxRm4yalpycytzYU9DL1A1VFZ0S1BWMXl0?=
 =?utf-8?B?b3dEZWZuRHlzZHpMMjIwcEVUZ2MyM2hmTEcydUdoVVNFTnV6U1MvUVc2R2N4?=
 =?utf-8?B?and2ZWFrV3RNSHdqdEtRNWQrZGttcjdzR3JJbXRQNTBab1pkZ1RPTkNreEUw?=
 =?utf-8?B?SFo2VmdTQmF6cmdudEt2WEVFM1ZRdzAzUklVVGw4NFovcUs4NzVrTlZEckJa?=
 =?utf-8?B?U1hKcEkxU0VSNHJYZWVCNHlya0MrRnJyNjdyZ2NSNjZ1Sk95Zlc3OENQSnE0?=
 =?utf-8?B?YVd5QW1TRHB3ZlRFMVVzVjE4WVJieFNLSExzSkgvL2pvMjhOak9OOTN6Yzha?=
 =?utf-8?B?QXNNY2dNK0hDVFB4Skl6T3hwVVNFUzRjUUMveExYdjRaMXZ0ZzNTM2k2NzBu?=
 =?utf-8?B?TzB5QWphMy92enpvTXRSRmF6UUdjSk5kamRkZTlkNjk2aDNmOEJQOUxRcEVz?=
 =?utf-8?B?ODM2KytQQkJyS0pNdWdOaVZTbkI5ai9NOTNPeW90WGpOaExwcG9MZmJCY053?=
 =?utf-8?B?OENVeDh3NGg3aWZTK0pOWU4rVFU5VWtFeWhSc0x0dk9lMXgwOG5SQT09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f7f0cf-68ab-4254-79ca-08deab71b81a
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:16:44.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO92oWdTOIAdC5hWwkVXA1XVeReppr3XgEcKEBgvXEv2F9QmjGoD9m57cqgI9edsLjA8FoAbQhnext2QWB0GXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2055
X-Rspamd-Queue-Id: 6D5D04DADAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[est.tech];
	TAGGED_FROM(0.00)[bounces-244385-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,kzalloc.com,est.tech];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[est.tech:email,est.tech:dkim,est.tech:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,blackwall.org:email]

From: Nikolay Aleksandrov <razor@blackwall.org>

[ Upstream commit e9acda52fd2ee0cdca332f996da7a95c5fd25294 ]

Fix a use-after-free which happens due to enslave failure after the new
slave has been added to the array. Since the new slave can be used for Tx
immediately, we can use it after it has been freed by the enslave error
cleanup path which frees the allocated slave memory. Slave update array is
supposed to be called last when further enslave failures are not expected.
Move it after xdp setup to avoid any problems.

It is very easy to reproduce the problem with a simple xdp_pass prog:
 ip l add bond1 type bond mode balance-xor
 ip l set bond1 up
 ip l set dev bond1 xdp object xdp_pass.o sec xdp_pass
 ip l add dumdum type dummy

Then run in parallel:
 while :; do ip l set dumdum master bond1 1>/dev/null 2>&1; done;
 mausezahn bond1 -a own -b rand -A rand -B 1.1.1.1 -c 0 -t tcp "dp=1-1023, flags=syn"

The crash happens almost immediately:
 [  605.602850] Oops: general protection fault, probably for non-canonical address 0xe0e6fc2460000137: 0000 [#1] SMP KASAN NOPTI
 [  605.602916] KASAN: maybe wild-memory-access in range [0x07380123000009b8-0x07380123000009bf]
 [  605.602946] CPU: 0 UID: 0 PID: 2445 Comm: mausezahn Kdump: loaded Tainted: G    B               6.19.0-rc6+ #21 PREEMPT(voluntary)
 [  605.602979] Tainted: [B]=BAD_PAGE
 [  605.602998] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
 [  605.603032] RIP: 0010:netdev_core_pick_tx+0xcd/0x210
 [  605.603063] Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 3e 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 6b 08 49 8d 7d 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 25 01 00 00 49 8b 45 30 4c 89 e2 48 89 ee 48 89
 [  605.603111] RSP: 0018:ffff88817b9af348 EFLAGS: 00010213
 [  605.603145] RAX: dffffc0000000000 RBX: ffff88817d28b420 RCX: 0000000000000000
 [  605.603172] RDX: 00e7002460000137 RSI: 0000000000000008 RDI: 07380123000009be
 [  605.603199] RBP: ffff88817b541a00 R08: 0000000000000001 R09: fffffbfff3ed8c0c
 [  605.603226] R10: ffffffff9f6c6067 R11: 0000000000000001 R12: 0000000000000000
 [  605.603253] R13: 073801230000098e R14: ffff88817d28b448 R15: ffff88817b541a84
 [  605.603286] FS:  00007f6570ef67c0(0000) GS:ffff888221dfa000(0000) knlGS:0000000000000000
 [  605.603319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [  605.603343] CR2: 00007f65712fae40 CR3: 000000011371b000 CR4: 0000000000350ef0
 [  605.603373] Call Trace:
 [  605.603392]  <TASK>
 [  605.603410]  __dev_queue_xmit+0x448/0x32a0
 [  605.603434]  ? __pfx_vprintk_emit+0x10/0x10
 [  605.603461]  ? __pfx_vprintk_emit+0x10/0x10
 [  605.603484]  ? __pfx___dev_queue_xmit+0x10/0x10
 [  605.603507]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603546]  ? _printk+0xcb/0x100
 [  605.603566]  ? __pfx__printk+0x10/0x10
 [  605.603589]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603627]  ? add_taint+0x5e/0x70
 [  605.603648]  ? add_taint+0x2a/0x70
 [  605.603670]  ? end_report.cold+0x51/0x75
 [  605.603693]  ? bond_start_xmit+0xbfb/0xc20 [bonding]
 [  605.603731]  bond_start_xmit+0x623/0xc20 [bonding]

Backport commit:

 commit e0caeb24f538 ("net: bonding: update the slave array for broadcast mode")

The BOND_MODE_BROADCAST condition was removed. Because introduced by
supporting commit on the v6.17-rc1:

 commit ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")

Neither of which are present in this kernel version.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
Reported-by: Chen Zhen <chenzhen126@huawei.com>
Closes: https://lore.kernel.org/netdev/fae17c21-4940-5605-85b2-1d5e17342358@huawei.com/
CC: Jussi Maki <joamaki@gmail.com>
CC: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://patch.msgid.link/20260123120659.571187-1-razor@blackwall.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Tested-by: Yunseong Kim <yunseong.kim@est.tech>
Signed-off-by: Yunseong Kim <yunseong.kim@est.tech>
---
 drivers/net/bonding/bond_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7fe7485fbb16..d38d31a83ce5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2256,9 +2256,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (bond_mode_can_use_xmit_hash(bond))
-		bond_update_slave_arr(bond, NULL);
-
 	if (!slave_dev->netdev_ops->ndo_bpf ||
 	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
 		if (bond->xdp_prog) {
@@ -2292,6 +2289,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	if (bond_mode_can_use_xmit_hash(bond))
+		bond_update_slave_arr(bond, NULL);
+
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
 		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
 		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");
-- 
2.53.0


