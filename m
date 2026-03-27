Return-Path: <stable+bounces-230709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMU2B33OxmmuOwUAu9opvQ
	(envelope-from <stable+bounces-230709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:37:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C15234913D
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C82D304751E
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78669410D03;
	Fri, 27 Mar 2026 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="esrgSx5o"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC8040FD9C;
	Fri, 27 Mar 2026 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636642; cv=fail; b=sxFIg9KJ0lSDQIBo9CkFpPRfwobsyiZ01OhalzW199ml85qjPjMtK8VagyWoXxljDX/z8xZ9iZhfMyBH0YB8JoV0Pnr0XghHEs6267MXu6E6f1bbfiqV+5ysPDuN1cs2Otf9fTw77yurETfvMpwDs6vYPtPnB2TpzOoIrQMTvrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636642; c=relaxed/simple;
	bh=UF657KgCAfFwpF2HyYhVw0A6pTkE6BsH4TRia+vi5UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ci//3xM1tcrK7Ow+yAuOZ/y3qgknUnwtLE5DbjU1FRiGXKy/rN6ZkalHcORpgNiMFAAdPak7bNNNw4iGhDxiIzgkLscqlzw0sEBeC7L3H7C/DJpamvkCB7txtjjZE5M1dnYFC5FcRPiYN9J2haF9UOksn6FKrQ+FS9HkttevYsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=esrgSx5o; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RH7ZST2692107;
	Fri, 27 Mar 2026 11:36:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=gmNQGKTuCjW3ILjncg5s4XlrJMUgpV/pVV5AXGWHgHk=; b=
	esrgSx5oiZ5rvGmRhEWJjZmbARdJ1SDUOjIU2xpHXKY99otyIp7TXe8WVDBE18/a
	cceLgh4x1K0AHgbSLqHpOOkfhm9LlJL04AB5lrIqP/9s3dogK720N5kSrqqx12G+
	0mxAEMS8of41iVJHc3R6SHkt0fZuBK5O9GiKwFerHab4po6lQh3opW6SCnYTFFtm
	1fD5tb3dAm/ZPvFAmgbjZyHGhV2nK4x/DOKxpNY4xLaUyCLZAWakXJK3o3HhW71K
	cxoVsIUa/XJ/jbnkmFGFcVmIjiO6Y3QN+CItUyLbtYip37kbibVGfbDA9cp6p7U5
	DQCo7LiK/ROuzTlOOZHcCQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d5x13g34h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 11:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyZMeej3Skt/TR6aMvS6t/8DYhxUdDSsjcAEwAlM/QHWlGv0o/1yt+Lh4GqLu6+29RifYMdY+RaPhtfbO5v3HewlmKBYE7ron24/+qcgyID+Bii31kxxdYrivdTIR9hUtGWliW63EObHtSwkxY7byf6an0NTLZ63MSpQJCfRUlwQe1UIKkTsD2mT4gnR/MDKDsag3nFxxj04vcgCycQG2Yo5sKTsLQltNIUJZtqRbugPGcetg7HJJCucQyWDp/JIVq+0ma0Bg8dw/vaX4kvDJwWBXsnuh3e026bZUjRCaqy40sqDgfzVhe/cG6MoMCOQDhDx4lvA10vMTAODFZ4ZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmNQGKTuCjW3ILjncg5s4XlrJMUgpV/pVV5AXGWHgHk=;
 b=USkHg/ar4lgyBw44KOTwagGxycet7YX7xTTSpAtGLh5xQGEJoqcDYr0mkegfcDSAg7Umo7QdEovLKldB8arjRDOusarwPPmQb3oP307PE/RDliz+UiKHdBMqPt6tYUl8N53X/bezFZBA1+xHoZiSA2e1HVpvULgK+u2YuRS/xRHi+SxXO4DhPo2pm2uR0rgpHXepwrOI8EJzQkpAAoe8PY45Td4IPwXs3mTq0NsTquLAJBFBhyavieqqccsMpXRrNDMNVE23mDe0V150tD9HssHqxJNF3DtRVqFe+ajR7I7L04ZOEbl3YbV8W07ZrY4oGtkryLXlnRxyaslCIj8zCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by IA4PR11MB8913.namprd11.prod.outlook.com (2603:10b6:208:565::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Fri, 27 Mar
 2026 18:36:37 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.004; Fri, 27 Mar 2026
 18:36:37 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: florian.bezdeka@siemens.com
Cc: crwood@redhat.com, ionut.nechita@windriver.com, namcao@linutronix.de,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, frederic@kernel.org, vschneid@redhat.com,
        gregkh@linuxfoundation.org, chris.friesen@windriver.com,
        viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com,
        jan.kiszka@siemens.com
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock" causes ~50us noise spikes on isolated PREEMPT_RT cores
Date: Fri, 27 Mar 2026 20:36:09 +0200
Message-ID: <20260327183610.594667-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <480f889c1744132f39983178fbad90ad11e081ed.camel@siemens.com>
References: <480f889c1744132f39983178fbad90ad11e081ed.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::14) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|IA4PR11MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e31b83c-837d-4b16-5294-08de8c2fc73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gMFaCCJ+tMuY0LhoXPrdSKDKu6WDpsOj+rdoNAe1f9N7ExzH6q7b96D6a6Dl5v6ZrSAwCjlHh2ukendkSz1cbyLrXwX0kc4Yfw9BKqRIhAyx4pqiDgVZzWiGED+9G1JQz5W2p3r81wWp7BI7otuhO/uBkgVvkbbImh4s2mW4UdmHmrnKwDzZOhXx8smJgorszS/VL7N2nipyEzy/lrnVM9zE98fULL5yYYQCdBaNOl7sZbQ/2+zWWi/Utl4N8XnLvqQaTu7OREVFO9SFKCe2lR+cYa7JXD8flx91DkjpX+LSHK3ABcQFeKmoLgsuU6q/fZmOn/qF4AijwSEA9v1kTXcyLddVJLI+X5/sWuAjfnQZ18wmLsdl2JwFTdaOheZoeMPQ8WTbLClheL1xDGR3URRTLD/0idzz6fzq/dlAHKx9XANeNV9jULiZntGr0Vpy276HjFcKZSB+F8O/OYrMZHnWZynMgr4Qop/3HKLv2XxfzdNvTqgujx2JrTm1SKIDMERqpBbsKVmiKs7X1OIPUZijQjEixBvXupaBywh9lzURYrKJU85IG1AxsLXKxToVlbmFiFXSeSiyduE5JY3nnEiMxxJjcf6l9xzNmXcgRU//nggzUZ6FX2SCdUIYgaAL1izX70xehF0hs3QJ1bv6l3iMSulub1I79W69XoRQtSNDCfG2rxq0a2id6/zx6THML2CVqali97sHZxV6UuEgI4SeQJ4hIoh/fx321fxuaPjzbMGUQsZd1tMpXiEWFJmxa+zylYH8h/c71SVSQ0kOP8ae5V41LCW5D3MyWnO+RTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OExkb2V6WVhBMzJCakVZVk9Cb0pReVhWUHU5VyttMlFvOWtxK2pDQ1plZmxp?=
 =?utf-8?B?enRDL3VxM2U3c3VVOGZwc1hjejlhMkF0eURCdmR1R3RVVm9VWFFTb2lMNm9m?=
 =?utf-8?B?S1d3eC8rUHdndEU0SzhBeVkzbERtNlFTWExjaUpmemFsdi9ncHc4cGM0Y0Ju?=
 =?utf-8?B?OGNrcjRBRzFkZXVPbnJYdmd1REFrVzl0WGROdlFPZUk3ZEZVUFY3UTlhRUJO?=
 =?utf-8?B?aEZNT3IyeXA1VnlLaVZyQzA0OWhhMlJEc3hqamgwRXlVQnpTWmplbkV5dDBy?=
 =?utf-8?B?SzFLMmhNb2NPdklxWmNDMWlqUTVnZUMraWFjNDM0R1NSOXpOd0oxdDVlcUVQ?=
 =?utf-8?B?bVZvNk8wYmNjVW9ZRGkzQkEvWG5ZT3A2T2dUclVCRjJ2MXg4M29XMEtQM2lF?=
 =?utf-8?B?S09yUE1PaXdNRm1QU0pIL1ROaFBqZVllT1VndFRDYmlnemU0d25ZNWkyWlY4?=
 =?utf-8?B?ckV2c050eXFuT1lPckdGMFVSQUV0TXIzQTFaUUkrMTBpK0ErSFNGTHZ6TlZa?=
 =?utf-8?B?dGhYbWxTTUZxdTZtcm1OUzNQVCt5QUlNY29zeWdrVEVMV0dGL050RElmQm9Q?=
 =?utf-8?B?VHZpUFZMUGg2TGlQWUVmR2MzYmg1UHdKQTJYcFU2M2MzVysrVGp4ZzdRRmE3?=
 =?utf-8?B?N0pza0pwaXo3Zm1yVGJQcXRicWg4RW1Wdm8zNENsQVpGQkIzRWprK1FFemYx?=
 =?utf-8?B?T3E3YnlScEQ2b0w3a2FWU3k4RkFvYk5pcnFCaUU4bG5VSXV0TUR4V2M3L21I?=
 =?utf-8?B?a2xiOE5TWm5UTkxIZnh2cVFNakhncmpwZkFNazRvK1lzYTRGeDE0aDFRalR2?=
 =?utf-8?B?b1dTbHdSWDhTenVSa24zcldRN0lobldTY1M1TUUvb1d4TlE4NFZZNERzczFF?=
 =?utf-8?B?WDhxSENHcmhBSnNhdmZLZlNPZXZvOW1tNU85ZGVEWWlLN0g2cU5ZcHZBYzdY?=
 =?utf-8?B?ZDg5WDBSY1NBbkszSGYxNVkxVkd3M2VkeEpqK0JDUmx6S0NUN3diNmdIajY5?=
 =?utf-8?B?Zk1Sc2I1Y2NyenBJbGtqVERGUGNDUmlsYncxRmx5YWE1S0FWbThYd3h5anVs?=
 =?utf-8?B?Vnk5RUNSSlJtOUFXNll2a2VGUXBicG4xSUdQMzlWKzg2Z0xsMjA3Sm9aVUpU?=
 =?utf-8?B?NVJ1ZEZobmdkNmNsdHNLeWpUVllSbFZSSFFYcFd3L1ZORlE5am8yQ2hjRHpG?=
 =?utf-8?B?T2ozaVpNV1BUUms2RnBzZmYra1NuakMvd3ZnWUk5RUU2cTNxYkxBOXNZdFE4?=
 =?utf-8?B?S0FZS3dqL3FIYU1lcjJZYndHS2NkRVBJcUJucWVUQW42VUhnZzI2R0g3M2Nr?=
 =?utf-8?B?M3MvTmlsajltZjV1ZU0yOEx0d29TVzNkNFNlL2puVkhkODFNSklGNmZLY3Vn?=
 =?utf-8?B?SWpBYnNhOFhPdmxoRXpEaVI4cU5tU1N1N2tsL3ovM0VGQmtNTjBsZDFvd1VZ?=
 =?utf-8?B?RUU1OWM0OXd6dVdGZFdKc3NFdXFEbHRXY1pqa3EwRFdXcVdyLzFjNlE4RG5x?=
 =?utf-8?B?ZmloUWZRQjFDMllWZ0VPTVNFdjZteVBVS1d0SHRSQk9VMnd0K0pzSWZZZlhK?=
 =?utf-8?B?VlNlN0RuemozdW5VQ3VVUE5aWS9SV1FDYTk2NjBoMGNCVnl1Y04vZTR0cDZ3?=
 =?utf-8?B?UkdrWkdPT2RYSnI3OEVuTy9TVWk3c1FzS1Q3NjFYc3NRZnVnRE02U1djd05q?=
 =?utf-8?B?NjdWNUxoZlMxL1Z1eXdTVHBaa3FsNWR2VVI5NkpLOTE1dnJzWUpSVUppbUJQ?=
 =?utf-8?B?V3FQQ0paUEExMFFKVDhZYUIrL1R5TjB4QXVpZmhpL0VabkdKSjAvRVYxYWlR?=
 =?utf-8?B?T21VQlZFQ1VoQmMrZFdsMy9WZTczZ3o4cW9aYUkrMnZRRTFncEk0cDZzb0pZ?=
 =?utf-8?B?V3lBSUhmeGlGUDZOV2NNL1dGdnRDV1pBWm1maVROWkJTNTIyeXpuZWtZMmY1?=
 =?utf-8?B?SE0xUGxyV0QvQlk5YTB6TFc5NTFuUjNQYU9STmcxdjYzWnNtWkt6aDJXVWlu?=
 =?utf-8?B?elY3RDJkVUFLNWcrT0RmK1hFNHRoSmp6TUNZWjBQMHVaVWJjUnNuQncyVzVR?=
 =?utf-8?B?bzExakFZUUJQSkEvWXNvYVcrNk9lQnR0citod05DWmF0ME5rMkQyVDJPbnZh?=
 =?utf-8?B?dmgrcmVZTjdldStFN0EzYkQyUFpvamhzZWlEcXBUdE16NXFMRkVIUUd6c0Q0?=
 =?utf-8?B?RE94VU0zTWxJaXA0MzRzTWxGak1YMUc5b0ZySEhmd2VyTXZsMDlKeGJIci9v?=
 =?utf-8?B?ZWZlOS93VTc2bHh1cXJ0UEF0SVN5TDVGOHRrTU05Y0RkQ09wa0ZZMURjMWs5?=
 =?utf-8?B?aWhJWEZHWC9tcHRMY0hTSXN6eXI1cGdEQ1hGNTdiY09PMUdKSTVUaGpZaXVs?=
 =?utf-8?Q?a73jcp/z3XRFhqYY=3D?=
X-Exchange-RoutingPolicyChecked:
	pvZkQMS8Rd63O6s03NM3xmJjKo71ZO2qwZKfSsRAm84ueZ9py5TA1Tb7Pvy85LZ07ZWfjl72UtIpdZZa2YdRqRNsWppIl2DCjEM7Rz7hFIDSc3eBkvgq9Q7iimcvqH0bZdUjrf1XKwlTNGLWdiC7Od1S7RUQOIjxrHRcezCOCINN/YFhvVCpEci0L3KLtwgJjhG9iYRJHlzNVCR4DTW/4Wri+G6rcLovhJQI2leSsJI9KTcfnZsvAXRtIe/cbJPonJhjopxNWBAfdfQpSs3fLV0/UzwhI9pXiXn2PNWJmVf1cyE9/BdWf6b+YQvc9QQitigVjkCbqsm6gl3ESlHuJw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e31b83c-837d-4b16-5294-08de8c2fc73e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 18:36:36.9701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQjHxLlbRDAlkRiw7s0n2mmXfRprNewioH3WDpiylHEaD3qCMl6Zhy0ofh9mJqeZKFPO1+Pizz4nwQ/BXiHNsjOYDhOg/ikr5STKJhHxgjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8913
X-Proofpoint-GUID: M74SDUkZIJejIjBzSdIVd22bovbmcMGI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEyOSBTYWx0ZWRfXy/h3JxpfmCok
 4wHo5lVRtIeLcHn/Xz5et1i0NrLGljahRb8i131x1QfmgXUrBmtkTpK3z6Ek2BsXnXi5Oltho8R
 QRikuudfRYfpG9Bxf5c/4ZFTCNahA1LB1F5Q+QK59lwJUpYgafx9BuxasAdcXOogo/mm8kOXnrY
 37H2IRgbV40K0+cOvtlNRYPPLRT/yUCLPpnl8+ZuxtZjYXPclnE5z8KVcX3Xaly+O4TmZK2RFdw
 eEvCTBW6j3hIbek9mBrtX8nBlphvD0jPKfcGCV/eBHoWbeOWQp6P0L6BE4KQ48hNUOeQM4ouImT
 O6oso35GEuB8BMqXTx5tMfvQDaBNzXbxD80nZNAVBf271P+pcAjkmTCl7rxubt4cEhOgLMxmaaW
 LZweyS2P+Qa1UrDcNFROIlkRHvNYmsWlTRCkYSdDwgGHwtGy8UtZeM7jXN6UrQpIDUcz0g9mJ6i
 fkpDemlwdtjlLA3xyUg==
X-Proofpoint-ORIG-GUID: M74SDUkZIJejIjBzSdIVd22bovbmcMGI
X-Authority-Analysis: v=2.4 cv=HI7O14tv c=1 sm=1 tr=0 ts=69c6ce37 cx=c_pps
 a=TO2QspbEOyvqwnNCDF3LgQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=p0WdMEafAAAA:8 a=t7CeM3EgAAAA:8 a=SaXOdp-1M5Rb1tYOMy4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270129
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230709-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:email,windriver.com:mid,gitlab.com:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6C15234913D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

On Thu, 2026-03-27 at 08:44 +0100, Florian Bezdeka wrote:
> A revert alone is not an option as it would bring back [1] and [2]
> for all LTS releases that did not receive [3].

Florian, Crystal, thanks for the feedback.

I understand the revert concern regarding the CFS throttle deadlock.
However, I want to clarify that the noise regression on isolated cores
is a separate issue from the deadlock fixed by [3], and it remains
unfixed even on linux-next which has [3] merged or not.

I've done extensive testing across multiple kernels to identify the
exact mechanism. Here are the results.

Tool: eBPF-based osnoise tracer (https://gitlab.com/rt-linux-tools/eosnoise)
which uses perf_event_open() + epoll on each monitored CPU, combined
with /proc/interrupts delta measurement.

Setup:
  - Hardware: x86_64, SMT/HT enabled (CPUs 0-63)
  - Boot: nohz_full=1-16,33-48 isolcpus=nohz,domain,managed_irq,1-16,33-48
    rcu_nocbs=1-31,33-63 kthread_cpus=0,32 irqaffinity=17-31,49-63
  - Duration: 120s per test

IRQ delta on isolated CPUs (representative CPU1, 120s sample):

                    6.12.79-rt    6.18.20-rt    7.0-rc5-next-rt   6.18.19-rt    7.0-rc5-next-rt
                    spinlock      spinlock      spinlock           rwlock(rev)   rwlock(rev)
  RES (IPI):        324,279       323,864       321,594            0             1
  LOC (timer):       50,827        53,995        59,793           125,791       125,791
  IWI (irq work):  359,590       357,289       357,798           588,245       588,245

osnoise on isolated CPUs (per 950ms sample):

                    6.12.79-rt    6.18.20-rt    7.0-rc5-next-rt   6.18.19-rt    7.0-rc5-next-rt
                    spinlock      spinlock      spinlock           rwlock(rev)   rwlock(rev)
  MAX noise (ns):   ~57,000       ~57,000       ~57,000            ~9            ~140
  IRQ/sample:       ~7,280        ~7,030        ~7,020             ~1            ~961
  Thread/sample:    ~6,330        ~6,090        ~6,090             ~1            ~1
  Availability:     ~93.5%        ~93.5%        ~93.5%             ~100%         ~99.99%

The smoking gun is RES (reschedule IPI): ~322,000 on every isolated CPU
in 120 seconds with the spinlock, essentially zero with rwlock. That is
~2,680 reschedule IPIs per second hitting each isolated core.

The mechanism: on PREEMPT_RT, spinlock_t becomes rt_mutex. When the
eBPF osnoise tool (or any BPF/perf tool using epoll) calls
epoll_ctl(EPOLL_CTL_ADD) for perf events on each CPU, ep_poll_callback()
runs under ep->lock (now rt_mutex) in IRQ context. The rt_mutex PI
mechanism sends reschedule IPIs to wake waiters, which hit isolated
cores. With rwlock, read_lock() in ep_poll_callback() does not generate
cross-CPU IPIs.

Note on the tool: the eBPF osnoise tracer itself creates epoll activity
on all CPUs via perf_event_open() + epoll_ctl(). This is representative
of real-world scenarios where any BPF/perf monitoring tool, or system
services like systemd/journald using epoll, would trigger the same
regression on isolated cores.

When using the kernel's built-in osnoise tracer (which does not use
epoll), isolated cores show 1ns noise / 1 IRQ per sample on all kernels
regardless of spinlock vs rwlock — confirming the noise source is
specifically the epoll spinlock contention path.

Key finding: the task-based CFS throttle series [3] (Aaron Lu, merged
in 6.18/linux-next) does NOT fix this issue. The regression is identical
on 6.12, 6.18, and linux-next 7.0-rc5 with the spinlock. Only reverting
to rwlock eliminates it.

To answer Crystal's question "when would you ever reach that path on an
isolated CPU?" — the answer is: any tool or service that uses
perf_event_open() + epoll across all CPUs (BPF tools, perf, monitoring
agents) will trigger ep_poll_callback() on isolated CPUs. On RT with the
spinlock, this generates ~2,680 reschedule IPIs/s per isolated core.

The eventpoll spinlock noise regression needs its own fix — perhaps 
a lockless path in ep_poll_callback() for the RT case, or 
converting ep->lock to a raw_spinlock with trylock semantics to avoid 
the rt_mutex IPI overhead.

Ionut


