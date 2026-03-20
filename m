Return-Path: <stable+bounces-227612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AhOIGquvWnIAQMAu9opvQ
	(envelope-from <stable+bounces-227612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AF32E0D78
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 21:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907E630838FC
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 20:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085BB34B683;
	Fri, 20 Mar 2026 20:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="SOuq9FHh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14A192D8A;
	Fri, 20 Mar 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038616; cv=fail; b=ZL55sRt3BM+NGccUpOln0Oo6gGVRWjLcVNpHYoQa0u8k0+4Ts8XM/ISbXPN/NsjWki9UbEa6hzusJ/f0k7Rp+ap5Z75F5VcytSR2wykciHTtrNwm85YLasccGFee1WqqD2XpKXP76wG/5MExSd+Woqy5jYZRHSngI8I/vM+sLsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038616; c=relaxed/simple;
	bh=54xY4R6c/Ku60wipxMObSMN5QrtiBh4WhKS/0gpQdCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUJIDCUb/+CW+oWiTGO3KzyCYqxVxxK1ItZRX6YfxO+ENSOTZ+8IoYstpIEeM4aFj7DaxxzFYvLlW5YCLgJ11vSN1Ou6GER/UKy26zESNGe2pjXEEVwT1jG5sn0NqC6Lsqwyr8IQZ6rVr2glXjerSdDhlMTbd20Wlgil4CfY/zE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=SOuq9FHh; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8qbZx324122;
	Fri, 20 Mar 2026 20:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=buowrR+wenypGBpsXeOtIpyhWRKImiIiPv4F0TBNLDA=; b=
	SOuq9FHhq2ta3FBptnFnyBkMYZS9YYQJwNycmeR9+BMklmgKzm+Ko4MSEZS71UJh
	K2287NYkoQzk0ycbXjuizpE8Y/5QEigc1uIehkov2r7tbnK44v5ccVwAxNMqbkTM
	BDDB96SJG+iSpLjJn2VR9sU9plRbO+PDDX5tvCAQmkV51rGWltXL+dcy4yXLPfM8
	iwC0H0x1gV0I6R3nF2ld8vGbIbzUMgMddjLgND0JMbRyAekmIN2cja20tWZNCa0F
	P6GmcMqNaaoC9INZD08Ve2Nx3UQX5hsqYlhrkF9KtoUNcSgMAfDRwWhYklY42T0u
	dJdY9UC45wovojC7tCjfnA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cy9anw33g-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 20:29:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGAj5cA8L1tGcSua69g9d0uqCQJFqNym7fYZvN/hWg0WN1LFpki3ivfpRRayuxsZaa5nyu+xZWsaCPwfswlp9LabhqpEOGOW2cj0cjs6oF/UBZ6k8R59CTlRRRJ8e9mDHzsroJc+Dd0jfid/6ZgpU1e7hCwSf+/J8dffdvGkmCpF+wiDRn0tdIkTscvq7eSvZ8yLJxbgx+1KJExpMxA0Lqf0xjUyLNyVS3JLSH/aV5uU5K6jV+lw81xFLKo4LCYvneh8w/ZyxXmBpPm3rxq1+WBFwQF7kTSijUv/LtGIfKupNTVQUO3zY1akH0Z33m27ZtJL61cAX5nXzyXTbuw3tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buowrR+wenypGBpsXeOtIpyhWRKImiIiPv4F0TBNLDA=;
 b=M0tfmNkihy1/MEA2c2jgV8cgB2SX7++8wR41XfAS8TZvVBLlUbLB++CqsXsN4weDl9gtgA4mJa9faw6LX/vCS9dzZTDYquUFK3JmSSsQOOGsYvchp5iEi+g0BR8poqvxYMQn6wOo8P9EopFRIXFJctJawF2l58T8zIouIQc7r4+cpHDnj/KCpUpkqHJUG8IR0Xft3pxhHR4Tf6NqyWSqa24tFxUYFRRJ3sg3zaRt5QU5cRgVyI+l5KD6Hp8Nj1N4Gim83p9Vgj0v6HcyeHeDHblTNMeMSV26+Rksekw59/l4pBrl00dW47vVMITFhMH4JegiLOoFdUjj9FfXoyOWbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Fri, 20 Mar
 2026 20:29:26 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 20:29:26 +0000
From: Ionut Nechita <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        christian.loehle@arm.com, artem.bityutskiy@linux.intel.com,
        quic_zhonhan@quicinc.com, aboorvad@linux.ibm.com
Subject: [PATCH 6.12.y 2/6] cpuidle: menu: Use one loop for average and variance computations
Date: Fri, 20 Mar 2026 22:29:04 +0200
Message-ID: <20260320202908.24377-3-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320202908.24377-1-ionut.nechita@windriver.com>
References: <20260320202908.24377-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MW4PR11MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e9f65a-35a6-42c1-3290-08de86bf6124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gVwVSJ8Orqcl1FVaqqtUYS5lNvkQRdgctCmsuPEENCIzHkTENIlOoKBzd789RsKwGQhR06ln0E+pgClfkk9WkfYjPSv7Y5GE48ykVNS5VM2Q6adpMY5h8zCzXlx5MAZrNP1z+VN8HhgOleVBh4++GjP+xeNJzt2IWehsn6YA0cqd2l10Cnh8deIWN1I/pmM+jZi1uwJC1Z2kL+zl/624s9kPaP1z92UxjFi0kcP6Xs4ZiyPfbVwGAsrELGUwc/48j/RB6y6ZPzUxSNVHwQRz2XUwMpC2PotWOn049YxIqF8kykD/65eaElOebGYsx23hTvBiUXdESm8LBIS3aXW2zXqc8G9P0A+sZaBpnm8PxQPWTFtEf7ziYJP+KgElhY6vr1d6DIDz290eAqHsPj8RRY4iPSSRX863T2vQhcdpTRCwrY55g+/Wdtramg3cNgBOQpgMLAbo/2X2PzYMgV1QPglQjSeRZerme1dFW/aof5ifYKekM6T74GIx0p/F6OD10zjPwWCLWUELROnTbsm5JiRuHeq3KHti9/JQhx6Zlojilz+1jf5QwglMKIB8sgCXmsMDvR/jqrZoV6SbeGV2jlnf8QsIanc029G3wglD8Ah1Hf0k90XwgHKJTWMrMVunBNWec+3Lj4arOs4iQhM7zpp/tOf+gO1IEi6bgvh79ooim6iXzhTEPYgYSuAka6to
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DetkVO4wxsA5Gv+OY83sLl9ZGNFpamLfRVa1ckpjQcuOjJXrglsJa7mJTEzr?=
 =?us-ascii?Q?+GDMQQiTIhPXDFGToFsgX268ceerDGo+efyMfVs7GxRrmJ8oUD0Sm80FuOSz?=
 =?us-ascii?Q?10nnADAcfsoDYh7zTzPlaeVsk4XwMaowq2LIbLUD4bOXzvJiTdTAwLLfsuKY?=
 =?us-ascii?Q?e8zFHhBQCsOXNhNPb/XjeAlpzJ6Xok6RjTuTYe6BpyN+esYt/Kb6i7AEbeFI?=
 =?us-ascii?Q?G4QaDTzK4dr4LjD7XmW+icBFqBEE0jGuDQqflH/eZvq8NlvoYB9JxeCCTrRp?=
 =?us-ascii?Q?wV7sTXIX2uro+GXErj94Doz1P++8O1C3XxJmPE71ebYw6vMsQPdPbDyPutrI?=
 =?us-ascii?Q?CnTuUv8DyhLcpHYoOA0HGoKI/+Z38zLfMt8MrZh5P+s0kqQQ9wazDM2g4INl?=
 =?us-ascii?Q?MgtIn9u0hwym9gUHEaPygJ8QAVL4xmQmycEXI8AV6RQDdfxopM8+KHVbVFPg?=
 =?us-ascii?Q?pjjUeFiyaNp7E8wvbv1hh+kSfRERA23mbLKp3oBn2717SRPVFZabIEL9Eahw?=
 =?us-ascii?Q?oGeuS+danOLzpvu0+3ErjJuWQp4C2zkeqpVdNvEDKKifCgtpLuZEvmTlGHBR?=
 =?us-ascii?Q?jORMvk71G56gvZ8M158CG8v0DU7kW/m8eEaGGMy2Mfu06SdspxBhc26f5QtN?=
 =?us-ascii?Q?vehF2gJQJ9k6T590OsKsI5S60J3YC3y9qz3YFKPLyz8849lSV9TWZtp6W/Re?=
 =?us-ascii?Q?1LaAQehr1ZEH3PTuwFYJATM9kzhW54FuhqdQSyl3aXoECJom7020iGuJycKA?=
 =?us-ascii?Q?oo2VCmyXmou+eCjy2hSsC3+C71NLU3Fdn2R/FvuaPgaOdbvGzwwC8W4iGuRQ?=
 =?us-ascii?Q?vHftItNhHUsHqridxyBQ25Bgkbs3Ys1UPuH6j4rf6mggw5GZKGl3PRepehgE?=
 =?us-ascii?Q?vT34cotRdnSWx7tMMg6KVZ+yui2VTxbmbx5UWJsBMo8xX5teSoMP2qhbO6Fn?=
 =?us-ascii?Q?wJV6CBS/39PwfVnTSH4Y0rXDM+HBnJHrN09QldjhlCJuuqay26dcx1ONDpNt?=
 =?us-ascii?Q?Yne4DzNkFaGyrMOgMRyMb4sTpg7mQhQTjN6v8uB5R4dntGSHqVjpk5pL+BhW?=
 =?us-ascii?Q?sgD7KVWX7tabFTrlHgMErUJDhiu7OKgfMchPxFeQ4foN3mkzjZbS5I7Ljh3I?=
 =?us-ascii?Q?R0K56Wj8OfsTvgjynYzxAXU31vjuWTpBPi9dMOspdJCbKOf7i20vJVt4+59w?=
 =?us-ascii?Q?0pcdC79aItEZ3NRxeqUangCP5CJUoBqotaMW68rhONYyKoBFAn4U8K3aLYSD?=
 =?us-ascii?Q?L/3CqzU5BvR9epHozrH3G/dXbtD+jSmjns2BXtdC62RiWuurXpPJzlbdSTdG?=
 =?us-ascii?Q?0/iAz5wp3kHENacqT3+nziIcWymqcJbPjXFM+LdVVbc3N8OuRXDWdyJYnAcx?=
 =?us-ascii?Q?/9Nktier8B5uYhRftzdL0JUDF4VHRNjVIbgWZMOlk83pJt5j8nd0BeWmmwro?=
 =?us-ascii?Q?IjDNcyJppmK2BY6T1jf08lY7frIkBqEOImrFC/ChOOMAb9rMvQoF95lLc3u8?=
 =?us-ascii?Q?ORSfCMHLdM8DXl97xjIl1aUM2Q+pqa21LHZegFUQhVy09ALjYSorH3IJlx+5?=
 =?us-ascii?Q?mEJNStMl23O/cbAiclrDZcl8T0tweHOunsVwLG4Lsi4pP91nehDahtMWDGc3?=
 =?us-ascii?Q?OKlWHNjJPeMIP0FARVdjx81kzR7OTD2RteRYLsJ2AIzJsJlHuxYDYbjTSTMt?=
 =?us-ascii?Q?2AnjecNdmUNjgR6gY1o1gpWWo+bFb61SkyQjHARvkGbL6eQBFh4W6NzEh0lA?=
 =?us-ascii?Q?O1R6D8onuBNN+ehxB/Xxi8h+EcwXu3VbCDzKrtH+DWKUzUlA4IqLbh6TBV8R?=
X-MS-Exchange-AntiSpam-MessageData-1: 0PjNnuF/HYq+RT/yuWcGTgZC2Hjwf530AnI=
X-Exchange-RoutingPolicyChecked:
	WcN+R5TsLvISCPl072FYIszYGMeZiM8hXKOT1RImCDHqZtkzMZ/HKJVlun07x+eUBSRhZ2U8XznDmMMPzgsSaAh59p03tCHJu+EaU1ckeAK+uPpuhmqGZUEovtqDzwW4z7bXPVmvwPgjpykU3jiDJ/DIMsb5MhmJGW6x5XoF3ZMoIAEB2NKOza0bfl9htT5PkeRrw+3GHdCVfo0JTWziVF8ZnvbanxO1QG5xoNbfA3U+zk91yA9cP08BdXmLZV6N6aLV/5hEoSdvQ2iynSFF9Es82eNqy6O27e0FWvt4XWz8NoUbs+DhNb1ClDUrlCG7nOIvBsYetUBVTYuF2aooxg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e9f65a-35a6-42c1-3290-08de86bf6124
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 20:29:26.0756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hO5IOLULUJEGb9mZfsisVTXWVcCAxJIjBBkx1ufqviSjiXo/0NN8yzuF3P2LUj5c6uDMb4fSJI8zmYIAkw49S3sBL8ELk+J+DHWMyhIluI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-Authority-Analysis: v=2.4 cv=IrMTsb/g c=1 sm=1 tr=0 ts=69bdae29 cx=c_pps
 a=g4Zu/129bcKSj1q/f/8ScQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=bC-a23v3AAAA:8
 a=p-nOP-kxAAAA:8 a=QyXUC8HyAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8
 a=MB4APrNTnA-WWpN6w3oA:9 a=FO4_E8m0qiDe52t0p3_H:22 a=XN2wCei03jY4uMu7D0Wg:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: f9dadr_a9d7Ski31k2gZBI9CtE6q6YBO
X-Proofpoint-GUID: f9dadr_a9d7Ski31k2gZBI9CtE6q6YBO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE2NyBTYWx0ZWRfX5q9xYLjFiUtT
 h4Wl7+uJvko4c/nFXF7H4FOSrS9UqZ2EhTZuZpSCM57tgveY/W6gEf4gIFNCJXK56uGWv6JdM92
 hEsPjCbqvXHMK9fBzwv8BRwrGx0NqiQu9A8Fw+g/ghFW0AwNvPRurzAOLSkBE9ObII/nV5SEq4i
 0y/J7rXyvkf6K7oLblxqfQIM59YQNBN6KLJMyKjEihPTUjoFbuiqH/Nll4DNJrZxKEry8gpMGhV
 9uO5AHIHofT0zMIsDH1Dbhqr5QJDSIZ9ZWFgFdEiqqlrZ8xCPWrhnc3YhoMI7pMsBZmXhOMC3yy
 nVxqq3SlFACXhi3dgma/fFqOGYOFPsXhsjXls0U64XQBU5S5UoL1v8vT1clk14JVuKW7qI8Rw0m
 zysmHG6sHL5L8DJNQlOATLuEJXWDKhVQXL6gYNxLf+qJmqW1I1m+qTZQvWxT0fqtJiKoirxaleu
 33IsQAGdp5HE6MMAgMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200167
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_FROM(0.00)[bounces-227612-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:mid,intel.com:email];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 23AF32E0D78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use the observation that one loop is sufficient to compute the average
of an array of values and their variance to eliminate one of the loops
from get_typical_interval().

While at it, make get_typical_interval() consistently use u64 as the
64-bit unsigned integer data type and rearrange some white space and the
declarations of local variables in it (to make them follow the reverse
X-mas tree pattern).

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://patch.msgid.link/3339073.aeNJFYEL58@rjwysocki.net
---
 drivers/cpuidle/governors/menu.c | 61 +++++++++++++++-----------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index dd7e2a965878e..8943bb8f19190 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -124,49 +124,45 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev);
  */
 static unsigned int get_typical_interval(struct menu_device *data)
 {
-	int i, divisor;
-	unsigned int max, thresh, avg;
-	uint64_t sum, variance;
-
-	thresh = INT_MAX; /* Discard outliers above this value */
+	unsigned int max, divisor, thresh = INT_MAX;
+	u64 avg, variance, avg_sq;
+	int i;
 
 again:
-
-	/* First calculate the average of past intervals */
+	/* Compute the average and variance of past intervals. */
 	max = 0;
-	sum = 0;
+	avg = 0;
+	variance = 0;
 	divisor = 0;
 	for (i = 0; i < INTERVALS; i++) {
 		unsigned int value = data->intervals[i];
-		if (value <= thresh) {
-			sum += value;
-			divisor++;
-			if (value > max)
-				max = value;
-		}
+
+		/* Discard data points above the threshold. */
+		if (value > thresh)
+			continue;
+
+		divisor++;
+
+		avg += value;
+		variance += (u64)value * value;
+
+		if (value > max)
+			max = value;
 	}
 
 	if (!max)
 		return UINT_MAX;
 
-	if (divisor == INTERVALS)
-		avg = sum >> INTERVAL_SHIFT;
-	else
-		avg = div_u64(sum, divisor);
-
-	/* Then try to determine variance */
-	variance = 0;
-	for (i = 0; i < INTERVALS; i++) {
-		unsigned int value = data->intervals[i];
-		if (value <= thresh) {
-			int64_t diff = (int64_t)value - avg;
-			variance += diff * diff;
-		}
-	}
-	if (divisor == INTERVALS)
+	if (divisor == INTERVALS) {
+		avg >>= INTERVAL_SHIFT;
 		variance >>= INTERVAL_SHIFT;
-	else
+	} else {
+		do_div(avg, divisor);
 		do_div(variance, divisor);
+	}
+
+	avg_sq = avg * avg;
+	variance -= avg_sq;
 
 	/*
 	 * The typical interval is obtained when standard deviation is
@@ -181,10 +177,9 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	 * Use this result only if there is no timer to wake us up sooner.
 	 */
 	if (likely(variance <= U64_MAX/36)) {
-		if ((((u64)avg*avg > variance*36) && (divisor * 4 >= INTERVALS * 3))
-							|| variance <= 400) {
+		if ((avg_sq > variance * 36 && divisor * 4 >= INTERVALS * 3) ||
+		    variance <= 400)
 			return avg;
-		}
 	}
 
 	/*
-- 
2.53.0


