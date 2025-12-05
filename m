Return-Path: <stable+bounces-200095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE86CA5CFC
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 02:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67E7531A40FB
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F78F217722;
	Fri,  5 Dec 2025 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OHK4FfHj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LvQZUUrn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223D645BE3;
	Fri,  5 Dec 2025 01:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764897246; cv=fail; b=n+V4k2RQL0Qnbnsn8cxKgTHEI1Gc6iqYHtPsUK5UC19EyGvMNJsJ9Td/chq6iQcIV5mhtgWV9mcHTCkfetCA86wm1Syab2ZFqHzC1QtAGYMavCFXJfVUFdv2y1L22pq1aksEtHZGJDFBhKlIfhBPGdsqZ0NI2TarohL9h3XiatE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764897246; c=relaxed/simple;
	bh=l8UI3evWaA7eX9/7MdW3IJgDlakpz8d8nE/mizVAscg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fTiNWUCp/qPk7QmJPgifdx+PQJLdWwfGm3lGRWWhchIbvmSH3MmwLBmo9NG6tTSZvf5klVO40zgPCaCDxsyZOAxDWTjVeK+JeO3UrvijGHfzENeVw6iouajK/NvdBv13aS8FSJ0oM2ynGaGlAwOsUHqnjrvnU3kA7AkYm7WoaFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OHK4FfHj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LvQZUUrn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4JEtLc1679056;
	Fri, 5 Dec 2025 01:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EZZWdaZv03vvvGJl8CHi5DotWFTNt6Jk/2PYzLlK6tw=; b=
	OHK4FfHjy7tJgulAyMO2DT5ljgMYyFIX1fNOcG34oneKd+4uuavAFc9h8nNx8Ufx
	YI2XO64LaykgG0XcBeF3Sbmx0nSYw5up2VsnmUU/Q1Trp96qcQsyDh4sRjabkpe+
	LVwoUAcQj/+utcANRuhhQLBB8ikvWbC7oPjwhhftPBMCWRETEajDdI0fUAV3ieJs
	71UbGF7KlJxtvIF68f50aPt/5AucsEwV25tT82eVRdMMywdNBQh7rKq3N7hnA+5q
	yswPPrGSy0Gp6IRcjzthEae47yvbefwBHIEQHPE22re8uoVPvE5cYgcGGnA1v535
	ogpNYouixKj+tv2rcqxMbA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7u819d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 01:13:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4MbvAp011210;
	Fri, 5 Dec 2025 01:13:12 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9pwmqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Dec 2025 01:13:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFMXp5hOhKsBtW1Z/8fzPOFxdsXy+106mjgwgFePyQrgugVaP26uEebuUeST0F/87eeYrM3fXoeDNSSA8EpLftpUFBOjxw0hcXSpxrhraL7qZ8H2czcJgE+qvWlMw99bpoX45yTpCFDnHqobLupF6DnRuTT6gDj7m+iWJb1ig/8nij2SEPDztKP9CZlPhvolpP9ZATFDRRQOajER6OzZScRFA3lTZntA2J6TwTAGkgzGSnBR+BCs0bwsGi9D0iBu7CuCXBnNtYXF+OYvkFcFX2RXJfB9WkJj3hMXgza2MpSpbElhnYy2oAt8qUGxyO0sLtUxrN14+zzDk+cgiYnGLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZZWdaZv03vvvGJl8CHi5DotWFTNt6Jk/2PYzLlK6tw=;
 b=EmfVkpw1duEJTi12AbjhGeHrXcLZ3LRCzK6amdR0IpA9eAzpm3KdL8gJ5xSwXgbw8yvHcTq09shp8mG+yiS8uNE3GWjmodz8xFYsAQOTkOQw5EuFAN4H322HeiP2M3xcblHXXVL3Z7Ec9r58EY0LrejK/cBMd/i53gSkXZQoXIJfoJ2OsaAlaJTRvk65OKYQz3Hcu5yBZq0I9TB3SHAQqy6+JON4aSzkTkYHkip/R9u6jd2EkB/C6F3AD0baj0hiUnNtEkvmQIoHi5zn/eIiEZR9R8U5drpQyiyZ7ayjSyBVZRHuoWj6Wt3Qt0DPD7kkOj/b7QwlAV6B28HOxGy11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZZWdaZv03vvvGJl8CHi5DotWFTNt6Jk/2PYzLlK6tw=;
 b=LvQZUUrn1375mmr+AqIgmvmH25Y9lc0B96R9CG1WYonGYPJBLGTJyQVu8wnsR8WenrJWsD5ktcyj5DoifMfoO+sP5FbNt7eDANEf9QuhBHQTE1Gb9UV6m7gxB0e9mXs5ConoWwpgUuFv2l8bWLnZyvFh6HatlGL+rSeH7453PhU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB7180.namprd10.prod.outlook.com (2603:10b6:8:ed::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Fri, 5 Dec 2025 01:13:08 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 01:13:08 +0000
Date: Fri, 5 Dec 2025 10:13:00 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: vbabka@suse.cz, Liam.Howlett@oracle.com, cl@gentwo.org,
        rientjes@google.com, roman.gushchin@linux.dev, urezki@gmail.com,
        sidhartha.kumar@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
        mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
        atomlin@atomlin.com, lucas.demarchi@intel.com,
        akpm@linux-foundation.org, jonathanh@nvidia.com,
        stable@vger.kernel.org, Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH V2] mm/slab: introduce kvfree_rcu_barrier_on_cache() for
 cache destruction
Message-ID: <aTIxnMhVK8eHx55P@hyeyoo>
References: <20251202101626.783736-1-harry.yoo@oracle.com>
 <CAJuCfpE+g65Dm8-r=psDJQf_O1rfBG62DOzx4mE1mb+ottUKmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpE+g65Dm8-r=psDJQf_O1rfBG62DOzx4mE1mb+ottUKmQ@mail.gmail.com>
X-ClientProxiedBy: SEWP216CA0025.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbd5170-8722-4403-4e4e-08de339b738e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wis2TDlwVlVpWHk5T1JRekRTSHd1Nmswc1Q3dklqMmxCc1JiSnM4SUZvVmNC?=
 =?utf-8?B?YjJSb2ZWME9lZ1JkKzRVWmRnZjArKzV6S1M0RTRhalh0bmVROUJUaWxlbzJB?=
 =?utf-8?B?dVNCS0M2dWRYMjhOQk5YeDBlS1U2ekRkZ2t3Q1JJNjNwYSsrdEZjenFGMVdk?=
 =?utf-8?B?N3BtRlB2bHQycGs1ZnZ1QU1SbjFzQ3QyY2NGdGdPMDZNck9NQVV1S3RzMVhk?=
 =?utf-8?B?Rk1adFY5UzBMWTJyeS9sQWVtUVczMms3KzFid3dGL3FTU2d1elFmUVZyaUxl?=
 =?utf-8?B?cWg5L1JWSWNib3NWbG1pNU5wR1JRanpEdHBCTm1JN1QrSG51MmZiSmticnhx?=
 =?utf-8?B?WFBKTnFMcW1lWWxtdWE1R1pMOEpnUitYakhjY0dqTU9EUy84VkE4SXF1bCtk?=
 =?utf-8?B?NlViZ2QwbFpYbWNsdXdrREE5TFV1TGdUWFBmZ2NUb3BXcjRtNDRLTlFDSUhs?=
 =?utf-8?B?L21DTDFybGNVVUhpaFRtbWdmbVE2dWlWcHN3Z3VUOG12QU5rTVBVTkRuOGpW?=
 =?utf-8?B?QnhROXo5ZHZZTmRZNkRiNmF6MDZUSys4blpOOHljaGxzV0tZd0tWc3N6RFJi?=
 =?utf-8?B?SHlJZjBpcEVPdlhDeHp6YXJFUlozbTMyZ1VQQXZpSy96Z2lIcjlsc2J3MTNh?=
 =?utf-8?B?UEp6T0ZEYU5lTWdqd0FNYmxFd0RIWTEzY0lOVHdzQTNZWmg4SmRKVC9KL1dp?=
 =?utf-8?B?cmoyWlpwZDI2eWVhMkZ1QXBJOVo3WnZFS1pWdzZhSmt5RWJIQnhxZFBxTDBU?=
 =?utf-8?B?bi9OaTVIbDBBb2g5WllkaExlY0Q4dHNLR3d4M1hJdTBWNEMyQUlRS0hTQitN?=
 =?utf-8?B?WXVoQVFQVnFyL0kvaVA2bmkxeDF3MklWMG40RUxQUVFyZHhHaDk2R1hQQXZC?=
 =?utf-8?B?TER0OStVdk5zOUJMTkZibzN6K010dVlxZTdSeFRNQTRWZEF6RllhZFRaLzl6?=
 =?utf-8?B?ckJwZ1VWZ1pxQ2JMZHQ1dWhVeTNldzVFd2xjTlhyZUEwM2ZnWEMyZ1RJK1Mx?=
 =?utf-8?B?WUZ3b2pjTDRXRXpOWEpUaXk5bFdPYkhwcFRhWWdjMlRFcUlVdTROTUJ6NjZE?=
 =?utf-8?B?WDdsRWVRRWN3ZmNqdHZaZkZwcjVWcmFhRndLbFl3MlJocmFQOTRUandVc0ZK?=
 =?utf-8?B?UkRpTWlvVTMxM2hJUnpmMmg5KzY2MG80L2VLallTNldoMzlrNE13Q0FmSys3?=
 =?utf-8?B?Y08yTGpFWFBBUUdTZVM4V2F0VmVJUklhQklmTklUcFJFWWRxUWIycXMvTXVu?=
 =?utf-8?B?TE4zSG11WFZ6UVcwY2w2OHpSOVZhS2RjWXFUaTlTWGVqSjN0MWNuZWJ0NzFQ?=
 =?utf-8?B?K2RjNWFlcjdZcUNpdjNJRmdqeElybzlTRjIyZEdrMXhzL0JkWERyM04yTi9p?=
 =?utf-8?B?ZmVoRmlkczB2NUI5SU16VnhVQnhicWhFK0lzZmtOS25rSEZUMkJJZGxKNjRq?=
 =?utf-8?B?Qyt0Tk4rZW5nakhwVVV5d1FLcjFPVWZjZUQ3QnJRcmF5WXZSRmx5czY5Q2ln?=
 =?utf-8?B?WE1YdjBJbVNUL0o3dzFQRWcrS1hyTGJJYXZxMERVdlJLQ1FHa3hzdmxCK2pN?=
 =?utf-8?B?QzNoVXdkYks3V0NKS21UK3E2ckFmQ2JLcWcrVG9jR3gvTXJHY2Uzc0dxVnFQ?=
 =?utf-8?B?T2xhVStSL2xJaDh4cFFFVTNmeURjRGxQV0hoNzRpem5jR3hGekwvMGR6OUF2?=
 =?utf-8?B?WFdyVEc5ZnJOTkxXSTZvU3Nwem9pT2VKUjh4ZktmVm5aTGhrM3B4Y0VLQVBl?=
 =?utf-8?B?dExyMWxRaGxwdEpocWlTSW94a0J5SzlKYkNZMGRIcU1XZUYwTjc2S1FzSFFo?=
 =?utf-8?B?THdJR3ArSEZJdEZSMC9kbGh2RjBoQUd0ZElTSkdjZnd1ajNtdEF5Y3VIYzJP?=
 =?utf-8?B?Q1J0Snp4YmlmVGNhZUoxWkFKcDE2VTBuSlZwUndWbTRyRXVuL0NLd0YvU0ty?=
 =?utf-8?B?TjVJOTdBOVZ0YnhhTUZhSEJWRmI5ZldJVTdmOEtuWUlmTVg4NFBiWmZGNFU5?=
 =?utf-8?B?cWMrbnQzMCtnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnU1YmtIMk1LdWM2bGxxMVhTeWRtRk9KeHoyMDZJVlhhd1Q1NnJMaE52NmV3?=
 =?utf-8?B?QWJQNGdmUHlsaFhjVTJqOXFCTjM2NitaQzlJY09raXlodVV6ZFZEbG8yMWV2?=
 =?utf-8?B?UTU0TFZXMkhWcTVWbU1aTzNjK0NUY2FETzRWaUg2NUNIb0VrcHltQkJXejZQ?=
 =?utf-8?B?S3VYejJUSGFRRHFOcG9tRHhRckZjeGcrdC9pNDF5UzFiTFhaTDJlK3o1Qmli?=
 =?utf-8?B?Z3NxYTF6bUdodmJSMTg2MHNnby9Jb2Uyb0sreXJNbVE4RmdDN1Y2RXh1ellS?=
 =?utf-8?B?czFrY05iZVdzek9pS1ZrRlpjNDc4bkZLRE9Za2VJYXdqNzkwbmkwWE9JY24y?=
 =?utf-8?B?Uk9CRzUwKzc3bUZWeWlaZTRuOE5YSjNuZUNjaGRvOWIzcW9zQ2UxRHE0STFK?=
 =?utf-8?B?bGtPZ2poS281UUNYbzdYdjY1UjIvRGI5TVZ0RXdscm1Cc0lBNEFyaHI0VFV1?=
 =?utf-8?B?UTR4MkMvM3JTY2ZCTUtmTnpzYWs4U2FWOVdyYU1tSnNKa3QvSHhselh1dGpZ?=
 =?utf-8?B?TFE5SE5OMy9LNjlRQVNRUTY3WXR1ZEdocy85RzN5UXVKZTlKRjZOQjBYTGI1?=
 =?utf-8?B?aW5VQmwvOFVoc1hHK2VnYmkwS0NwclFKU1B1aklSZXNVb3cxdGhNeFc4bVNM?=
 =?utf-8?B?cTUvcUpMV2ZyYTlCRGZZY09UL2cvdkhiVW9FZXc4bTFMc2F4ajR6OU9rbWpl?=
 =?utf-8?B?ekRzVlFmaUFwRzNoeVFpdmlJOVBFMUpidk4yQ28yU09oSVdjY2pPTlVQYy9U?=
 =?utf-8?B?OFRwaldGdUdkRXhDVTlYTG5ZT1pMZWppQytJb1RBZXhkODdEV0g4cm15eXBH?=
 =?utf-8?B?THlXWktuSEVaTnlqa01lV29KS0hqQnE5Q2xmUHpBN09NUE9ScWpkTFJmQVJr?=
 =?utf-8?B?VWtsNmdjc2lEcU9YdHBxaUlJNkNuNFRsbW5pZzRtVFh5eWNQc0ttMVFoOWNQ?=
 =?utf-8?B?UnplSDgySFVaRkVVTmx0WTU5R0I4VmFoM1pxRXdISFJ0TG5JSzVGZzQ4V3Za?=
 =?utf-8?B?WG9UaEZaUko4ZloyUjVzRWY4WkVmU3RsS0lFMjY3U2xXdWUvcEVxNm1mallV?=
 =?utf-8?B?Z3ZwdGltUHNxbHFRd3laYlVVeGpsSUFwWlJFTmYyMkpNbzk1dXpyWW02bTdq?=
 =?utf-8?B?bk9EYnN1eEZXaGp5R1ZWUUVubW40aE9EMzVNLysram5xWVE2bXhaY2g1b1Fn?=
 =?utf-8?B?ZVR2cjl1SW5OdndkRDBSUENsNXNTZDBVb21YL1NIQkN5Und6V2E0YW5kd3dL?=
 =?utf-8?B?b2FJS25UdG9ZaWlVaklWZ3JNVHFQOE1KTDRDeXdQRFVzdzI3UEFhL0hKV3dp?=
 =?utf-8?B?a09uWjdURWJ3Si9LVXBxdS9FM1dqNTRnQlV0Q3BrQnA0R0xuaTIyWi9zdXJi?=
 =?utf-8?B?RVlieGRROXFVeUxtUkRZamZOOFk5cEF2Tk5lcncyK3AvdVpESi9XcS9MM1Fl?=
 =?utf-8?B?Z293UzVRR3IralRkaWJIYXovQmZCR05Hd2lGSFFFbUtJQmxURW93NXhLT3Y1?=
 =?utf-8?B?ek56V0tKUjlkVG9seWdMNUJmR0JScXZNZEt1T0NVeXM4ZDl4VlU2U0Y4TlRQ?=
 =?utf-8?B?Y0tqZlJDN0IwWVFlSVlQdDZXWjR0M1JBOHBWc29LZ0xKcmJTL1Z1bjh0SHU1?=
 =?utf-8?B?dGh3bU1RWVFpeFEyTDZtOENBVmRHeHltTFNjT2dpMUt2RElNR1JtbFBySElK?=
 =?utf-8?B?TlZtc1NpUkVYc2ZhMU16NUY3ZGcxWDdiWWZXUThaTDhuNjh3TldNU2ZYNTN5?=
 =?utf-8?B?Q2d4WEtic0VxcnJpa3l5Y0xlN25sRlloMFdSalE1c1RvQ21JRjdkcTFSTURS?=
 =?utf-8?B?V2tGQ2ZzNnozazcrMWRTeW9BVlJydVlrdlkvSmZTSFJFcGtlNHlrT1pCNWZP?=
 =?utf-8?B?SDgvZEF6RlR6UC9ZamdBTXZtaXRrRDM4UnhiU0tPcndyWUgyOVMxWThCL2FL?=
 =?utf-8?B?cXZPMjVRVlBScjBBWndEK1BHaUpNc2hRU2p6bUg4UFE1UFZheUVpMnZVK0Zq?=
 =?utf-8?B?Wktib0ovV2J1T09na3BUNzdOWnplN0ZQTkxzbHdibmxibFR4M0I4bURmaGEz?=
 =?utf-8?B?Wm80djF5TWFWb00yTEVQQ0FrRTIwSlE2cnVTMHdlS1JCOGs5bTlaemptU3hq?=
 =?utf-8?Q?74DUQ0qtzowz8bZLtaBMvqhzd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q5WggcjeiOidXfl0Wl8j0mgM3n4frxsUtXT+yXoGat66LohX8jFq9Iy9z6RfmLiLpygRCExPpelz1zJSC2sZd73v6JcgBpbkOV6r2opcrCrZs4dKv4BdJsfmUnR1rxD57lf0Pvf+0UrWOG/1kX2568MTpifjqxXnnd1BVxH0pGuKqkw/VhYcx6ZnnuL+6TRWQdUGuIFVhQT1b0NvvuefFYwlY4hRAyo7JVTQJ8BZZPk3l05gIcJ6FbcfCnDSTbTjNavYGVJ9CfEOBTbHrTXZ9lh689Zq/j4HpNawhCWpP1IfgePH6uRMJqoYut69BMz+xVlLZPAFDsf8AS6Cjgxgw68FCPxbSKGL3eoTdBSCPWfgM9jO6GiWguZI77mzwUaONJ1TMSGes0jVj+WBpZ+F86qc0/X+7NuYC2jVMEsBgGZIp9tEiITU0Kp/3S0LqxwZUH8gw3JzWsS5rGNPnnERUfL3WJ2GyJIUK6K8qtImsJWuHsO1gw9CaIJpiMfqc6wfmFwZuHF3zzKKA60FgKwAP5qsjock8qOqjEx12MsbfesvgAZy5NSDWlo+rHHnN8qGp9bspZuW+MxrTE7DEcyg3IiGlD+seQ8wCOu7iI4JevI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbd5170-8722-4403-4e4e-08de339b738e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 01:13:08.6285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfpz+QBsjsn4xIQ5L12/R1BWF+lMExaGEuee85clodpMyzygPZ4qjtkK/9PJ0IIyaKdQpUbrLHn0qcjlXs6HTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512050007
X-Authority-Analysis: v=2.4 cv=Rfqdyltv c=1 sm=1 tr=0 ts=693231a9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=hD80L64hAAAA:8
 a=jZ78U4f2dzK9kpcga1EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12099
X-Proofpoint-GUID: -_TXn55d5DsqxzFTwRVwi0KYXu7aM1Xz
X-Proofpoint-ORIG-GUID: -_TXn55d5DsqxzFTwRVwi0KYXu7aM1Xz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDAwOCBTYWx0ZWRfX303vtZ3HieVU
 WT7/4KkoSe63iByYrdputdBkhnO3Yy8PYOJ/0z6ycZtcQ7aGDy0P33cXhlFmRhHop8RuFvI+7tD
 +1RGxdPd7bZWvVEFpnq5H84/gqBnSDHmU2h77srizCbagf4TWBgsiS+BEnwU2e3UDf3kJSIMMJL
 7N48ur5Nh2pTcH80JE+2WWJrVE4lG8bMuNuRICMW7Ci/s/iZ1KYUBOc4f5V51fh0yaO7Hj6YsAy
 Qr8DsFCs6f1cwdfR91qM7xs4h6kK+TWnXxMiwAhKWkQMlk6yhGbTiAqxGeNqGYIQQWcHkFqPpZF
 Qjnx4lg46LID9W8CP+rcGyWekWVA3ovX6c83BaU7Te5k1Vc1l/Ad9DOPXZp5dIjH7Tl7YCypssY
 b0aEQYfEbJL42e8ged0UHlyz9xkgGfJpTLDeU9yU4AWrHLv7YIE=

On Thu, Dec 04, 2025 at 02:05:07PM -0800, Suren Baghdasaryan wrote:
> On Tue, Dec 2, 2025 at 2:16 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> >
> > Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
> > caches when a cache is destroyed. This is unnecessary; only the RCU
> > sheaves belonging to the cache being destroyed need to be flushed.
> >
> > As suggested by Vlastimil Babka, introduce a weaker form of
> > kvfree_rcu_barrier() that operates on a specific slab cache.
> >
> > Factor out flush_rcu_sheaves_on_cache() from flush_all_rcu_sheaves() and
> > call it from flush_all_rcu_sheaves() and kvfree_rcu_barrier_on_cache().
> >
> > Call kvfree_rcu_barrier_on_cache() instead of kvfree_rcu_barrier() on
> > cache destruction.
> >
> > The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
> > 5900X machine (1 socket), by loading slub_kunit module.
> >
> > Before:
> >   Total calls: 19
> >   Average latency (us): 18127
> >   Total time (us): 344414
> >
> > After:
> >   Total calls: 19
> >   Average latency (us): 10066
> >   Total time (us): 191264
> >
> > Two performance regression have been reported:
> >   - stress module loader test's runtime increases by 50-60% (Daniel)
> >   - internal graphics test's runtime on Tegra23 increases by 35% (Jon)
> >
> > They are fixed by this change.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Fixes: ec66e0d59952 ("slab: add sheaf support for batching kfree_rcu() operations")
> > Cc: <stable@vger.kernel.org>
> > Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
> > Reported-and-tested-by: Daniel Gomez <da.gomez@samsung.com>
> > Closes: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
> > Reported-and-tested-by: Jon Hunter <jonathanh@nvidia.com>
> > Closes: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >
> > No code change, added proper tags and updated changelog.
> >
> >  include/linux/slab.h |  5 ++++
> >  mm/slab.h            |  1 +
> >  mm/slab_common.c     | 52 +++++++++++++++++++++++++++++------------
> >  mm/slub.c            | 55 ++++++++++++++++++++++++--------------------
> >  4 files changed, 73 insertions(+), 40 deletions(-)
> >
> > diff --git a/include/linux/slab.h b/include/linux/slab.h
> > index cf443f064a66..937c93d44e8c 100644
> > --- a/include/linux/slab.h
> > +++ b/include/linux/slab.h
> > @@ -1149,6 +1149,10 @@ static inline void kvfree_rcu_barrier(void)
> >  {
> >         rcu_barrier();
> >  }
> > +static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> > +{
> > +       rcu_barrier();
> > +}
> >
> >  static inline void kfree_rcu_scheduler_running(void) { }
> >  #else
> > @@ -1156,6 +1160,7 @@ void kvfree_rcu_barrier(void);
> >
> >  void kfree_rcu_scheduler_running(void);
> >  #endif
> > +void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);
> 
> Should the above line be before the #endif? I was expecting something like this:
> 
> #ifndef CONFIG_KVFREE_RCU_BATCHED
> ...
> static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> {
>     rcu_barrier();
> }
> #else
> ...
> void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);
> #endif
> 
> but when I apply this patch on mm-new I get this:
> 
> #ifndef CONFIG_KVFREE_RCU_BATCHED
> ...
> static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> {
>     rcu_barrier();
> }
> #else
> ...
> #endif
> void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);

Oops, nice catch!
Interestingly this didn't break CONFIG_KVFREE_RCU_BATCHED=n builds...

I'll send V3 shortly.

> Other than that LGTM

Thanks!

> >  /**
> >   * kmalloc_size_roundup - Report allocation bucket size for the given size
> > diff --git a/mm/slab.h b/mm/slab.h
> > index f730e012553c..e767aa7e91b0 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -422,6 +422,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
> >
> >  bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
> >  void flush_all_rcu_sheaves(void);
> > +void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
> >
> >  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
> >                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index 84dfff4f7b1f..dd8a49d6f9cc 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -492,7 +492,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
> >                 return;
> >
> >         /* in-flight kfree_rcu()'s may include objects from our cache */
> > -       kvfree_rcu_barrier();
> > +       kvfree_rcu_barrier_on_cache(s);
> >
> >         if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
> >             (s->flags & SLAB_TYPESAFE_BY_RCU)) {
> > @@ -2038,25 +2038,13 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
> >  }
> >  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
> >
> > -/**
> > - * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> > - *
> > - * Note that a single argument of kvfree_rcu() call has a slow path that
> > - * triggers synchronize_rcu() following by freeing a pointer. It is done
> > - * before the return from the function. Therefore for any single-argument
> > - * call that will result in a kfree() to a cache that is to be destroyed
> > - * during module exit, it is developer's responsibility to ensure that all
> > - * such calls have returned before the call to kmem_cache_destroy().
> > - */
> > -void kvfree_rcu_barrier(void)
> > +static inline void __kvfree_rcu_barrier(void)
> >  {
> >         struct kfree_rcu_cpu_work *krwp;
> >         struct kfree_rcu_cpu *krcp;
> >         bool queued;
> >         int i, cpu;
> >
> > -       flush_all_rcu_sheaves();
> > -
> >         /*
> >          * Firstly we detach objects and queue them over an RCU-batch
> >          * for all CPUs. Finally queued works are flushed for each CPU.
> > @@ -2118,8 +2106,43 @@ void kvfree_rcu_barrier(void)
> >                 }
> >         }
> >  }
> > +
> > +/**
> > + * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> > + *
> > + * Note that a single argument of kvfree_rcu() call has a slow path that
> > + * triggers synchronize_rcu() following by freeing a pointer. It is done
> > + * before the return from the function. Therefore for any single-argument
> > + * call that will result in a kfree() to a cache that is to be destroyed
> > + * during module exit, it is developer's responsibility to ensure that all
> > + * such calls have returned before the call to kmem_cache_destroy().
> > + */
> > +void kvfree_rcu_barrier(void)
> > +{
> > +       flush_all_rcu_sheaves();
> > +       __kvfree_rcu_barrier();
> > +}
> >  EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
> >
> > +/**
> > + * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls on a
> > + *                               specific slab cache.
> > + * @s: slab cache to wait for
> > + *
> > + * See the description of kvfree_rcu_barrier() for details.
> > + */
> > +void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> > +{
> > +       if (s->cpu_sheaves)
> > +               flush_rcu_sheaves_on_cache(s);
> > +       /*
> > +        * TODO: Introduce a version of __kvfree_rcu_barrier() that works
> > +        * on a specific slab cache.
> > +        */
> > +       __kvfree_rcu_barrier();
> > +}
> > +EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
> > +
> >  static unsigned long
> >  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> >  {
> > @@ -2215,4 +2238,3 @@ void __init kvfree_rcu_init(void)
> >  }
> >
> >  #endif /* CONFIG_KVFREE_RCU_BATCHED */
> > -
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 785e25a14999..7cec2220712b 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -4118,42 +4118,47 @@ static void flush_rcu_sheaf(struct work_struct *w)
> >
> >
> >  /* needed for kvfree_rcu_barrier() */
> > -void flush_all_rcu_sheaves(void)
> > +void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
> >  {
> >         struct slub_flush_work *sfw;
> > -       struct kmem_cache *s;
> >         unsigned int cpu;
> >
> > -       cpus_read_lock();
> > -       mutex_lock(&slab_mutex);
> > +       mutex_lock(&flush_lock);
> >
> > -       list_for_each_entry(s, &slab_caches, list) {
> > -               if (!s->cpu_sheaves)
> > -                       continue;
> > +       for_each_online_cpu(cpu) {
> > +               sfw = &per_cpu(slub_flush, cpu);
> >
> > -               mutex_lock(&flush_lock);
> > +               /*
> > +                * we don't check if rcu_free sheaf exists - racing
> > +                * __kfree_rcu_sheaf() might have just removed it.
> > +                * by executing flush_rcu_sheaf() on the cpu we make
> > +                * sure the __kfree_rcu_sheaf() finished its call_rcu()
> > +                */
> >
> > -               for_each_online_cpu(cpu) {
> > -                       sfw = &per_cpu(slub_flush, cpu);
> > +               INIT_WORK(&sfw->work, flush_rcu_sheaf);
> > +               sfw->s = s;
> > +               queue_work_on(cpu, flushwq, &sfw->work);
> > +       }
> >
> > -                       /*
> > -                        * we don't check if rcu_free sheaf exists - racing
> > -                        * __kfree_rcu_sheaf() might have just removed it.
> > -                        * by executing flush_rcu_sheaf() on the cpu we make
> > -                        * sure the __kfree_rcu_sheaf() finished its call_rcu()
> > -                        */
> > +       for_each_online_cpu(cpu) {
> > +               sfw = &per_cpu(slub_flush, cpu);
> > +               flush_work(&sfw->work);
> > +       }
> >
> > -                       INIT_WORK(&sfw->work, flush_rcu_sheaf);
> > -                       sfw->s = s;
> > -                       queue_work_on(cpu, flushwq, &sfw->work);
> > -               }
> > +       mutex_unlock(&flush_lock);
> > +}
> >
> > -               for_each_online_cpu(cpu) {
> > -                       sfw = &per_cpu(slub_flush, cpu);
> > -                       flush_work(&sfw->work);
> > -               }
> > +void flush_all_rcu_sheaves(void)
> > +{
> > +       struct kmem_cache *s;
> > +
> > +       cpus_read_lock();
> > +       mutex_lock(&slab_mutex);
> >
> > -               mutex_unlock(&flush_lock);
> > +       list_for_each_entry(s, &slab_caches, list) {
> > +               if (!s->cpu_sheaves)
> > +                       continue;
> > +               flush_rcu_sheaves_on_cache(s);
> >         }
> >
> >         mutex_unlock(&slab_mutex);
> > --
> > 2.43.0
> >

-- 
Cheers,
Harry / Hyeonggon

