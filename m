Return-Path: <stable+bounces-232946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E3vFzwxzmnIlQYAu9opvQ
	(envelope-from <stable+bounces-232946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:05:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C131E386728
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB278301E3D5
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C608E19CD1B;
	Thu,  2 Apr 2026 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="sBqfBBj+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0948854774;
	Thu,  2 Apr 2026 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120425; cv=fail; b=PrZEVS+UA//LCAEG8MSoaoJeUkq4os0b3Mf8OTkToSzgt/pSrIIbPKClZTDlmpDs+QRi5CwM2PCI8DgGSOQGPEsWooLbGTUeq4QXSoNjOtD1YDRdTz99b92+5HfELDJPRUhAbhKKsU7Oec5e+37V+zkc/vKD0XU1TaEQaBgbDFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120425; c=relaxed/simple;
	bh=K8Mw+4++mKi+Ms+iR0XLRhwPDkObnsp96UZUaIBDStk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YV3h5UPS4tW+OijW7jrdtHSeRLYHMOVnizCpsgIBhQGyCl7OAl77OQ3ngMvb7KrD7QpELK6lUE4JRUazp4Md3CnOFGaoY1POs0f+t02HFfpsDSd9BwvUIhKd4qe7Hhtr9ZXOVmpv5R4VkNmLmMS6xOmB+dHym7kirzSoOSph1HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=sBqfBBj+; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6320kKIe576753;
	Thu, 2 Apr 2026 09:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=LJyczQnu+bQNRjmD0CzxpfZM3Vrwp9kkBHcsRrvX0QY=; b=
	sBqfBBj+xKIjqw22sasjKeMQByQtBEaXKDcBotpI83chtVZH7X/iXk1NfFoliwiu
	pdd/aIDv5uLvJuB78ZECEhJqQPbpw+mwe1m+O+K76q/0TjxRRvcHoPq91mTeBm3F
	jW7My1yZLbSrG72ndXWPdw2dw0/yj05Lcn1rWs6VFkM5JcQd8KnQXObGfxrZSei1
	m0Ie/oODNwVK+e5uXB6TArpth8UOpwIBly2+O1JFLpdbQDzNFCpaHgOC1tUVBiFG
	AjIP2N93Z66axZDSzPaDzwY7Rsd50iB+FBotRkQqjcTKz4/xFG6Tg13eB/L6h9J2
	7ZaIHLo6KuIPTG9gXfwI4Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4fhxt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 09:00:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0R6Snd42K5voDTNFX2bSMP7Dx6YmoHeT+690/4XohFF7hK0+6m102afW+cEfl+K5ktGv7vDD/FlP4+kPCQOmCMTdVMdVV3gxZFsE6XtDFhCqal7571tUGq1uSZs9oQMezpS3AMFDScwXspGBHbHcCE3kRCgC3kampwa1FRY+5SnUnE5FkXOcB2Ie7fJfB4ybNMe7fnh6a9IrmdTYqZZkFwC3l+SWQcpxNbNxVgpZDfxSHXC0/Oy2h5mFOi6iFXpO28GpHMKTIiQZpQO7mMZvThjB0P8w7HL+aK/JgC0LtwePAyx8XpUsJ4FGkY1MPQvyaC2pGPvIP0L/+jiJG//IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJyczQnu+bQNRjmD0CzxpfZM3Vrwp9kkBHcsRrvX0QY=;
 b=HMbBev/NeEtSs4/adXFbUlGEaDgHXeWNTjgTQYdmtmA640ERK+LZcdXdG4hV7okC3bGIywMHBd4VHGfC4NyxRfRSVVFNUcU6EwNp7tUMOE2MVbhKl0B/all2JOVzZa5fZYHFBvgbrKBTHdoz1LfNOxKry5q4wSA7gcI/jiVD/At8tfhaBpPVtqlQDm3pkkFeWPNyGEpJpIx9+JSxy+GZ0rXlHDX3NxD53FQLIWTYYiYSVixTKJA8fy4pM5Qo2zDYXhVwu6TYjyrcShghlHIgtaI66t04PVSNu8ZCmYV8yd5MPxCa+bo2HbCHZUi5q4vZQ1wzHhkGFZgLZFvgMyaQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by DS0PR11MB8687.namprd11.prod.outlook.com (2603:10b6:8:1be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 08:59:59 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 08:59:59 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: namcao@linutronix.de
Cc: jan.kiszka@siemens.com, crwood@redhat.com, florian.bezdeka@siemens.com,
        ionut.nechita@windriver.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, frederic@kernel.org, vschneid@redhat.com,
        gregkh@linuxfoundation.org, chris.friesen@windriver.com,
        viorel-catalin.rapiteanu@windriver.com, iulian.mocanu@windriver.com
Subject: Re: [REGRESSION] osnoise: "eventpoll: Replace rwlock with spinlock" causes ~50us noise spikes on isolated PREEMPT_RT cores
Date: Thu,  2 Apr 2026 11:59:32 +0300
Message-ID: <20260402085932.49162-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <878qb6x9af.fsf@yellow.woof>
References: <878qb6x9af.fsf@yellow.woof>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR02CA0069.eurprd02.prod.outlook.com
 (2603:10a6:802:14::40) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|DS0PR11MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbea15b-a8aa-48d3-18ba-08de909637a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JTW67vQvlAN+3/0yhG5QkCTddrLUYKL1QB3WS3M6v5mFnKBfbH6holHm/G13gS3whV2aHxpOZKrL23ua0WrBDOBagquhbtl40pzyieFMv+X3YEtIHkhrJAlq5MJHPyxNrdkshH7ycoWhGP4F1NBdyL9ox9lDi3aFH7wra4+7+3De6oX1nJZEd6Ha8EVSpSMOK3Y5OxDypcckYcMRRp+njoIhoE/iq7xUwHKXBjn7FQksIwq7gWWBoF5R6yFyPKsPEqEyO/5QSgZ6HS5PGyPS30dG552gn0h+bre42jnGmeSocTUNgAXZ/3OIkD0/C4zEX0yOSu3oEleNwJuOQRxwhDc28TnLnOAp8Wn4rKQK9iWDkH+PLITd+qq/2fSDx8cvY+cM7jLb9VVPro5GBHHlRzo0H2+8MfN+90JdAz0VqGpWECeoF8mnmTbK0nw+5n2kC8COnxpwkRpXrhqC2dtXr7mmge+a9u33pHORgo6OiGJf3HBT5KOa1AttOqLKOQ7Cl66sRTiJCFbw1y+0VFouWkFxIrIIdGom8aNMROHxhq2IyK7oseVhJM9VGTKkr5tnBXoOZhb1eB8m1Wfgc63WnzhlKa/6HLzd9hF+BxIoCoSmgkiWVpttOksEuqxMj+qxchgVnUqBXzeBdyc9gt6nf8Mvk+fCXLs3ME4GD5kJJjrE0gr2Jg9YD4fXAic0Xj4e7DRn+dV6Vqb/XwEq/NWWQpusgaGJ+bqGIKKw6bIW0Y+VnSkD7bf9auITrdyyWqakBBWFI7NSk/wgjI9ZcrM+Jj8dogNQsqjNLeFpZwSxzBA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ISD0e3NklphZconG48XR+5x3vjx75ONFm1qyPmX3jFWzNHs3Dx5FmmkGNd/?=
 =?us-ascii?Q?M5xIonGPDH0Jfe5naDqHTihSjETq9UZgVIIWTOkrKBedZA6PGIs48tl/PyII?=
 =?us-ascii?Q?WH5Sq1DTIxnNgbtk37mCcwRzrCnfrJ39sEUZXeHD41kjlWkN2GToewfMVOdr?=
 =?us-ascii?Q?NCsS5C8QDFYKcfhFkbZfHiHPY/864zhnaxzgzqHVUQcd3wesEStgt9WXDTPB?=
 =?us-ascii?Q?Lf0+b5m74OM8x1w753/zABFTSb/nUs1nFPsiIlx2PJl9wgkuK8Dbfpa1Vnva?=
 =?us-ascii?Q?WzVcLRlHdjBVYMFWMSCnqrINRnqety5Y/SUJ/XJaYdjwIx0fDN/9Zq9KeUdp?=
 =?us-ascii?Q?HCRXgEPLXFjKLNisCrFnVzRdkIq0pgTxXcys2ucBfoeOSQ08BJFl/LNtBd9F?=
 =?us-ascii?Q?0Pu66w8KIasdx+Y2EtQvHgD9F5R4XbqiuzcLEiwoKOKQpvU6yVmOFwrFK2/Y?=
 =?us-ascii?Q?UEzf9FYCQ0CJV8rBfpjoi9rkNlS/qtvUN3otz31SsL3C1PW+CiWH7GTpROAW?=
 =?us-ascii?Q?magDejgKbnEHCOeWsejumCq1knTTJkjznQLEOvx2UywaWMGRUU2X8I68lWau?=
 =?us-ascii?Q?Yh482wJNE/3+uoK5MadH46ZCnnGHytcgYmLd2zAJ7fwWq1sbJx0501d3NWhZ?=
 =?us-ascii?Q?0jRWN0CVmUkojoZGu+5bDPvVPUOioo63ZLsq8yO6GIhdfqvW6WSoqyFrHtEU?=
 =?us-ascii?Q?3r4hGk9a3WklzyxaBanSclWu6Q4eZA8JmdN1XC43vccqMr9GWVIT4tqn2flf?=
 =?us-ascii?Q?5mtG5Rh6j3hLIi7ASAv8Yyi2cbGMVUHmE9SQ6aoq4dvV0E5SeBphf28Spjfc?=
 =?us-ascii?Q?7Ov28fdDC9iB8+1PXp37On+cciuMINdkRDnh+gzuwMrZa3hOeblho2yvyuSf?=
 =?us-ascii?Q?dkF3mhxqhHXQ1ihAYpaCTi38QuUlOQ678WEeCa8KQbuX+vtqMQHJeLjgJfwZ?=
 =?us-ascii?Q?DlUZbl6YfR4AZLjK5Cb9EBXI1dZnq2N80bX86XQ6FXQ5YetRo/ViG0eaPoji?=
 =?us-ascii?Q?sQz6P80JdrXWCz576rdKJ7MiT2pgo1EJZfyqfC4GRUw+ljoi75j2aYWw0/AZ?=
 =?us-ascii?Q?BhHadaxW2wi4X3Q1ZDoQC2JO8WKHB9Cq3MnFITa6a6V8gjJvPWBdNwdyUCnZ?=
 =?us-ascii?Q?7me280O3EMlKbPsEXieF3Hbj+R+f34WjCjwnLIGM1h4VC/karCUJBIkTTI5Y?=
 =?us-ascii?Q?LbALFsV/0d8ri3Xp/Cql9Lp1ti6jVMaYt2iEIEj234hxxoXf4//6fruuWlhu?=
 =?us-ascii?Q?HXULhSm2LH2hLACzvwYlqSf6cQ5dly/oi83dZ7DPglHeYjD9eBfKpTY/ANpI?=
 =?us-ascii?Q?mstxnw2kUm/gzhmFTNVEtQ8Zxm+FfCcamlWYZX15oFIZWNJ3wi1M+cd8EhVI?=
 =?us-ascii?Q?XB+Z3VsGy5O+zGITBOzUXRYjDzOSkP02B0amsjQ8RYOsz6fgPnDkRJOmhjnI?=
 =?us-ascii?Q?IEhS4kX6l/c5wwump10m99bD9QzaNUD3EUgX7f8viIL+3OLzRCcRQq2eVltd?=
 =?us-ascii?Q?T3QT5aNjlqMfckfeYriTZvgwNSNZmG8UtFKClMWcIYO1lBKnhlekgBcPKYuX?=
 =?us-ascii?Q?Ganb6fRazu2jXcDx2MTJsMfCcAG+U1zrFh9zYygJwCb5OPSUFqSuzVpGt8gd?=
 =?us-ascii?Q?RwEmex/Y0c5wabZXADD9LiPlU1NlExFRVFtvTfyCZ+KckwixKx7baIe7z0N2?=
 =?us-ascii?Q?e0l0W7+zIUN9NuuZKxJzefG5pGwxtj+Nx7eTa2YTFHjeXMM4HnVv42DbHdW1?=
 =?us-ascii?Q?TLAZKK2i9mwXSIooHj2PmbRKSeuDc4I=3D?=
X-Exchange-RoutingPolicyChecked:
	Lyj3GPG0iMkU2KK+FcO2QoIUAiLuT2KCGWpdu2u5BP8AeKo0wMezY6HgzV7/JejLVZAaoLO7Ppu2T+3gXCPtSEhw+VOI0kjv8FNcFCFaHXi746ST/WeHCBbSOV58u2rrs8f9QMQznwsMOPyEbhqsdgEFJnNa63DPOER/2mMdQt24a0tt7ROUohfXc9B6dMe1FrrEKt3vqH5gIf+zFjkgp4WfdNr9tfF/+yBzjReZbRpw2lJ8Q5H3Cnl5i7aPdkKfM2PGXuuKHV7t6KAsgXhAkAP6IUwT5aDUVkzale81WrA8KRi4hu0mCTQPec+tCFT/mTEjt3vLxU7FYLdbmhthBA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbea15b-a8aa-48d3-18ba-08de909637a1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 08:59:58.9642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIFEyW7anIsGKv09k4X0BON8QNRu65gfOzDBcktoIL/On755DjWJQGp89sIsRDsTHw8A0JOL1nf25MwRH8SkxjiRoXmPbmfhxJozhbiWukA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8687
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69ce3012 cx=c_pps
 a=qMfGPIaByV4ZnHoTJsbowg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=n9AEmsn67eXyJ6AevBkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA3OSBTYWx0ZWRfX9Oe0227oMDs1
 eWORC9Y1CLmE7m2AMQ93ZYzvBo7YJettEJNtU9DLIYqfNc4dQPCwfpFs18jd13nzWgKemymaGJW
 so7lH3NRsIFvb2Uy3blRnpcn1rI0qgM8FrVU2/zk8KEvCjtBKaiU9AUGayxAsgQgFZSn83g4UaF
 elO4x8Sda7jQhXL3Q7O3n+Ssf2PhHDFVK14BJStulzgPTuByptjS8gqJIsRmW2gJqFby5Y6DFB+
 am8Ixteft/mGGSyP4hp510myLIrxb1mpoaYNO6So3bG9NupRz6RkuxWwIN1LDKcFTPfIpOyKZqN
 czk18GvTHSUa+5dj0jhzJZ4fPYUQ6Xvan9Yl4Pqk/47t8DRR72w+BMRSyecbWCz8emGpQZ5b4lu
 BDV9tLcEBk69d+gE5+j8W9Anv1EAyihp+XS/jbRxAVV1X27GTzlwhZaWQ8+Z30LDhznoYAJNlln
 iKwPFAxugW823cJTWoA==
X-Proofpoint-GUID: hXDs8adFyl4qJeQ-B9d9Rd_--NDWm0G4
X-Proofpoint-ORIG-GUID: hXDs8adFyl4qJeQ-B9d9Rd_--NDWm0G4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020079
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232946-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C131E386728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

Nam, thanks for the feedback. I agree with your analysis -- this is
really two separate problems:

1. epoll_ctl D state hang on 6.18.20-rt (kernel-side)

   This hang does not reproduce on 7.0-rc6-next which still uses the
   spinlock, so something between 6.18.20 and 7.0-rc6-next fixed it.
   A git bisect would identify the fix. I'll try to get to it when
   time permits, but since this is a different issue from the original
   report it will be prioritized separately.

2. eosnoise self-noise on PREEMPT_RT (tool-side)

   You're right that the noise and IPIs measured on 7.0-rc6-next
   originate from eosnoise itself -- the BPF callbacks on every
   tracepoint hit generate ep_poll_callback() contention that the
   tool then measures as system noise. This is a tool problem, not
   a kernel regression.

   I'll flag this internally with my team. The fix is likely one of:
   switching to BPF ring buffer (BPF_MAP_TYPE_RINGBUF) which avoids
   the per-cpu perf buffer + epoll path entirely, using per-CPU epoll
   instances, polling as you suggested, or switching to a different
   tool altogether.

Thanks to everyone for the thorough review -- it helped separate what
initially looked like one problem into two distinct issues.

Ionut

