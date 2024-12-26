Return-Path: <stable+bounces-106140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B09FCAF9
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 13:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E287A11D7
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA0419F13C;
	Thu, 26 Dec 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ADBejanv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bTyXPSah"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DF23DE
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735217069; cv=fail; b=Ofnz8QKLJbFEN9aVxD3u5ypgZbKBSo0Ir+4jf4ynf1fCsM/90GRk46SdQf77sHpGd5B7GkIVd+1jmZz/Pd8pRdbs/JZiEpMUMQeKAUJkO6QfUiVWKj8FK7NGAQWYMU5yh4td4Cnxh5K8AneIEmC+sds8zwi5fFtQtCFPjorGU74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735217069; c=relaxed/simple;
	bh=Gv2O3xrVz8SKGX90s8SdtXDIzsotn1YZKvFQwL2/TKs=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmQEZ2RUJsv6GSWj+/6P0kTP7GX4zlwyJG6oBdm1opO2O1QOgSUU5Zgbqu+7g12esaLOOhn3/SZvzh/2awogEHMgrJTbZrmuc4gPTK6xheKmbOEUZv5Beccfiu0lnw8QuGfwuMvkgDVZNe3oqXWnW4suh6mTS31klMP0ovbhd7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ADBejanv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bTyXPSah; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQAfo7r007466;
	Thu, 26 Dec 2024 12:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=o+F2mjPOzxbnKAVX73DZ2dYF7p9QVdnBy2j7lf7LDJg=; b=
	ADBejanvthpcNw+MHrdlE7IrTk0k1S2WBxnJdYqtvOmMSJ/WP7tCyecxvjbAMolH
	aIirLGeL439k6/uQc1nfH5fVXWK+t24PwDuqvaB8OiVG4HrWLvvVf0GsK5lY/7SJ
	0oqFkUibYWlO+Ovls2Iz9Q/kLmFjzB8+IUy1izDGBoUKFP+maKpQow5QYt+ASk8e
	q6lLKvnpNvbLkOn+Oo6Jo5GV8kVNpV4zM4hXvQkCNRmSTTJrfK512yNUQ69pOuEP
	fWdmwO58yKPMvtTQBhZbeFVeuc3iOf6uHGQ87fhjqV5fi6MZpPszKMuxz23wzdsf
	CM+mLczi/0nDVSooMQIp1g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43rdfsh3p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Dec 2024 12:44:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BQ8Sd37015957;
	Thu, 26 Dec 2024 12:44:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43nm4fkm6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Dec 2024 12:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOJZP+frV1gy/l7YuWfj3C8MlUT6tKB+YQKkDntPQ+XgB5W9uog5uQC8QbEYFqRdKnYcgWBPVvV1BN26rKDFBBCrjxMNXoj4CNraUNXME+cH0AJLwasyEion6DIT0Cs2e96dcbk8dRpWCZN90mOL3HI7hwlU5OCYRZVo+fr3LyEpbZ+dr55hnd/Jd6V0+N6WRwLARAx6FqKNBx1lReaHciLtBtR52Npps+KPVzHaNh5zu9q8+zhfhUrtt780zKA1TocpGR+lrryWRKjMHCXxFdJLzJDkLRp3IEh87L4pZwPNfc5DlqYLFAxgbb2miIN1UTNTTYBUcUp+b+fTYjEPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+F2mjPOzxbnKAVX73DZ2dYF7p9QVdnBy2j7lf7LDJg=;
 b=bPrEpEv9xCyqVvBkKwBSuPYGXLqJbpQx2qLm3DjYxAzDmIngqtxKlTGP0lfDpfftn9TBEYvOGnEF+RgEs0/6VuyPIhovzXKvqBMMOnkIo27XwaJhbH7EUklQt4CmO9o3OJ3bcG2s5O9sJVDnrFLWl2jISe3ticYq8jDr1NvQMrlhu/scRNqHwkttXqqF4Fpe2x/WK0XYwg1Nw5fA5E0c3OPtvHLVLgPM6F9JSWRynyaWP/lhxV56lHxzV8wx3qySKjZFoRzrXnTYcvV5MUXmN/9yps1pzMFO3+A3qG5yMBxwTN/6/Us3EojULRxybof8fiFOWfyiRbFzMvAPhD5NxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+F2mjPOzxbnKAVX73DZ2dYF7p9QVdnBy2j7lf7LDJg=;
 b=bTyXPSahST8Tbm6gUmcRUNryAEM9wt4+UWWrxrjKmSp0iknloMiOOQ/JUnfWRyoev9WNDeNsSUqPMECHvb3MqtQVDQXcXyaOYy5Cb/GwUYAssVXx8vfhFpiOGg5R/wXbZakji4pAIZBdebtLQU/qimEm9jxidBOJJ1XFt56CwfI=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Thu, 26 Dec
 2024 12:44:16 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8293.000; Thu, 26 Dec 2024
 12:44:16 +0000
Message-ID: <ebabf38b-23bd-4903-b4fc-b2a12bd5c166@oracle.com>
Date: Thu, 26 Dec 2024 18:14:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y 5.10.y 1/4] skbuff: introduce skb_expand_head()
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
References: <20241225192848-210522801797f885@stable.kernel.org>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <20241225192848-210522801797f885@stable.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 204d2b82-976e-4fc5-faf4-08dd25ab0231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d085bHFMb3lRWGRTVUhkWUdSNnM1MUVzaEZqOFZHTXNUQzZwSi9TSkV4ck1s?=
 =?utf-8?B?V1FKRGVyQ2hDN0dpUWdxYkxhanFxUVF4bWl0R3UwS1dOOXN5dGl3VWRya2tX?=
 =?utf-8?B?YVdsR1FwR1BDd3FWT3cwTlp0bnpndWVWTU8xU0xjR2Fic3kwS0xZaEVrUEFy?=
 =?utf-8?B?MzR3MmRmUmh6ZlpTZjNiay9Zd1hUVXJoVGhoQ2FoVzRsVXBPWDVXVGtjRjRl?=
 =?utf-8?B?T295L3NQTGVPWWthSWEwZWI3SElBUEhHU0RuU1FhTlhMQXk0ak53dEhPWUtG?=
 =?utf-8?B?M3JyV2k3clJMa0RPdHBIZGREK2xwY1hXK3R4OHdwc1JzUllPWDJVbmFOUzJK?=
 =?utf-8?B?MHljbFF4S09hcWtFWWQ1aFByK2lQa1BORDI4SDZDa09ENlg1QSs0SHo2YWNa?=
 =?utf-8?B?amFXczlNL3VieTJiSW91K1hvOEllWlZFRUsrWXdGb092Mkc1NERsR2RMN3ZS?=
 =?utf-8?B?YnVheHQ2eXVFQUlRK3UzN3VxdHlRRXFERldTN0EwTXkyUlN1T0VzcDhDOVdR?=
 =?utf-8?B?MUFPeWhtdWg5VS9wOXBSdXB4THVxK1U0OVNPeDJ2TGN0MCtSK2NJZ1J6eWtz?=
 =?utf-8?B?ZmFQZVpmbGRoR0Q2Q0NIYXJrWUZ6cVdyZHBMOEdoWk9FTkZlVEt1eVNwR3ZV?=
 =?utf-8?B?d3JPZGdGbk1DQkZTbVZsTkdYNk5vZU9NSlRaaGZJT28yWS9lU3MrYVgzcm9P?=
 =?utf-8?B?MmpqbUZFSXovd29HVXcxMjIzRHgyVEZoTExBMDVtQmZFc0tQUHlmblpOWit1?=
 =?utf-8?B?MkFrYTBqQkk4Q3lFNGNOb0VxYzZZQkhBWVNzSTFyc1VzR1pieHpKTC9KNjhv?=
 =?utf-8?B?ZXRNWkRDbXJjNmZOdjVVTDUvSFlwU3BCbWNwWGNHUXlXRDJrdHQ0UkpJWUZq?=
 =?utf-8?B?NXUzZTdxak4wNUpIWnJtbWplWnFWaCtPc3NDTFRyNE5nNGJUNzNTalBLTTQr?=
 =?utf-8?B?REtnVWVnZjVWTFFkMFpIZVFpTktpekJ1aXFaTzZ6ZGNhM0J6akhxWEdNa2ZI?=
 =?utf-8?B?V0ZnenFWZzVpRlgxVnF1R1RjczZYYU5hSGxSQVlVeGMyZVV3Y0JCRWRuRGQ1?=
 =?utf-8?B?NW5ZalpMNUd5ekJXWERJbVIybEN6NFVvOXhHWmVySnRBTTdiZ1hSTnAvSWVs?=
 =?utf-8?B?WEtiSXpoUzVRSGl4Qk90WENEcDc5UWRpcldkMHRiY1ZpbGw1RS90SUVpN2VE?=
 =?utf-8?B?aU9hVnBmam84V29pdmU0NmdGcEY2Zm9FVHFjbUV2emtvR2VVYTFTekRDeFI1?=
 =?utf-8?B?LzhFaVFUTGsrYzlmcWJrSXNFMzFLM1dxOHBpQ2FsTEY2SkhjNUM1MTJHZEtu?=
 =?utf-8?B?VHQwSFJ5TGxtUEM0QmJlMGord0R3d1JPU2xORFJtemFTdDZtTmFUSFRnRlJP?=
 =?utf-8?B?cisrb1lHNkFpSEFIRnRxQnRqamswNDRhcHEwTTNqSjJZQlN5RWxIZWdmS2Z4?=
 =?utf-8?B?elVVT0N2aUFFcFZ0SGVWTStxT1ExdkZmbXFOLzd4cWFZVUlUendlMFhWWXE0?=
 =?utf-8?B?V3BtVkUrY2pTTUtTTHlLOUcraitzandxYnJUVVFVbFRpb05seGJMWXdWSDhj?=
 =?utf-8?B?QWFjN0tqNnoxYTZob3o3RWRqNDZ3R21tazZyeVlqRDlDbTZhbjRJV0s3OVFQ?=
 =?utf-8?B?bGVtaWVmVkgwTWZxeENoeGlzL2RSaUpXK1V1QXJHaWx6QXRoVk9jMmxsMHRS?=
 =?utf-8?B?WWlPRS9WU2lEV2RyTm02dWJnL1NYMlpMOXptc29IejJzZXJieEFzN2liTXM2?=
 =?utf-8?B?K1lrQjlsRGdCc3lSMTVzZVpVSnNzRnRKNnBwZ2dHRmQ3OTg3b3gwalhZR3Rs?=
 =?utf-8?B?OUNhRGNaR0RlNzY4VGoxdGdVOCtad2xOcmlTY2lwZkgzZlRYcE1oNlM3SkdP?=
 =?utf-8?Q?zxpY65tJTQ0Hz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDc1Z0JoK29kViswVjhONW5VQXYwK014M2trd3E2TXZGMFpLR0t1dXZEZm9J?=
 =?utf-8?B?cGdLT1RUMjRGcWZUME92cCsrVWxlUkIxQkgrdFUzVEx6RjQyanFkZ2hqVENH?=
 =?utf-8?B?cjZBWStpaTZlSW8zbWNrb0FjRWJaMmVxT2ovNW4zWmlXVGJFQTk3T01TYm9j?=
 =?utf-8?B?b2VSZFVsNDJJL3JNOUZpZWZBMFVubUp5ZEFVZU43TGF6SUV5VVd0Vy9CN0pS?=
 =?utf-8?B?TFpub2NDV1lQUm9ObGFIMEVIdGtJcXhuSG1YL3hvTEFoNWMwQmxtaWNPTlFk?=
 =?utf-8?B?dHlEVzZUWC9WS2xndmhGWGNCS05UREtGbG1SYnY5d2JQS09BRnh1Zlo5aTEy?=
 =?utf-8?B?M2xNQ2s4UTFFRGl5UjRqNWhqd3lDRGxnRmFUQWN5Ui9NejJxSXJtdGtiSWhK?=
 =?utf-8?B?TjgzcWlvY0ZFbnNFMS9wVjQvcldwaHB6c3QrdUozc3RGbmZYMkVGOEhsc3dN?=
 =?utf-8?B?bGNiSnhkcnJuT2tHdVNnRndqRm9HeUZJU2hyeFJrQ1hrMS9KbG1ESmYvSjZQ?=
 =?utf-8?B?MGhSVGNKcjF0RkhTVnd3dE1tNFA0UXgvN3JLbjNxZjBzb0p6cklvY2N4WG8r?=
 =?utf-8?B?R2hKYlp0WGdkZmh6RHlMcVBlYTNtK3FoTUJSc1YvNzBwWE41RFdiNkx1YnBO?=
 =?utf-8?B?OXk3T2lQZGpoWEVNcEtwdHlsNTJzY1I3cjdGWWJRNk00Q3FuRlhZRi84dFB2?=
 =?utf-8?B?Mm4rUlJFayswVzNsSVRiMUJwWW1zMjQ2YXdKc3ZDNDFwRkZRenFVNGt5eUJw?=
 =?utf-8?B?cklabzg4ZDY0dmdkYzZpNGpoMDZneHF4dngwcU9lME9tdTlSMDFZaUtQb0xx?=
 =?utf-8?B?Q3hGWmtUeTJSanhYYTR1RUc5N0FFUytvNEN4UzduQ3JkVGR4WWJIRkE2YVBh?=
 =?utf-8?B?Mkxta01uS1hYNmtwSjBxNHF5NVZmczFFTWpWWGJlR0ZKRDhqNHowMVR5SUwz?=
 =?utf-8?B?ZFNrK3dydmc5eFdadG1tTDZCd1dFeHJaQWlsSE1haksyaHgrcENFZEkvNGQr?=
 =?utf-8?B?U0ZHMTN3VVRBMGNscUY5QUlCdDNjbFVkUmROa1FnWEdmUXJmMGlnT3g3aGZV?=
 =?utf-8?B?a042NlJzMFFTSE1YSzJWODhMc05sNi9SZzA3aTFLbmcyZi8wUUo2anBJWFpr?=
 =?utf-8?B?YllpUUtXNTdCanNqbW8zb3E3cWxwSjFUanFScFFSaGFRL1lWcXNMWTZNRUFB?=
 =?utf-8?B?Rjk3ZUMzTk5QR3ZKU3NCL2ExZ2xDTHdMZ05jOHM0ZkthbXMzMy9ocytrazhJ?=
 =?utf-8?B?aXN1MlI5SWliR0FxdVcxY0JFV1NzK21WTnBQT1pydWdYc055KzhXdWtRM0lZ?=
 =?utf-8?B?WTdIekZiMVZIOUk2UEpkQmQ0Uk12Y3pCcWxvbEJxRWtEWkY5bXpRQXVPc2VM?=
 =?utf-8?B?RytRY2MvakphbVdHeDZKOVRaZWJSdWU4dkdnZFhZMnlpcWJNSXdFOURzbmlz?=
 =?utf-8?B?anVSWXk4TjJ5cCt3eUpzeisyTXRzK2d1UlIzdFpjTG52bHpoOWJubmtKUk0r?=
 =?utf-8?B?MXkwTWthK1JoQzY4c3Nna2U3MDNYNFdzeTgyaFJLd01ZeFFnUkRtNCtZSkdB?=
 =?utf-8?B?WGhST3NrczlSbitkYzlzb3U4b1NYZlY0bWFJekVVQ25vVzNJYVBTMWF1Mll6?=
 =?utf-8?B?L3V1YU44UzZ6ZXBmMm5VcHBwbS9tWTRYWVNDOFhTK2dHeXNHK25QR0IvMGI5?=
 =?utf-8?B?WnpDQWpoZHdrYnpTVXRyU3ZIQjZ0T0VPSk5Fa1hoVHVCS2k0NjFlVDFWK2FV?=
 =?utf-8?B?Z3VaeWR3YnBkaktJQ1p0RGVsb3dHWGUvdGpyT0YyU3F3aURJWHMrVHJ0R1A0?=
 =?utf-8?B?RzJ2WGJUTHBMbUVxcDJhM3hDQWJVMHdrSVhUZFI2RWdUWTdNQmZoUk1IQWhU?=
 =?utf-8?B?TW9GWFcrWmFhRXNCdHFGVitJWU9UYlhlUlVHZG5hQ25QR0xlY2d6RktNa1hZ?=
 =?utf-8?B?UEtOazU1TFNYcE42aXQ4N2d3dlArb0tSOWlhRW5Xc3kzZiszcmlzeFJrLzNo?=
 =?utf-8?B?WCtrS0p5YXY5eVB1cXAzaXJ1TnJVLzJmMC9oc1N0cVRleEhmQmNlUjdmbE5B?=
 =?utf-8?B?QlRUaWxIK0ZwcTZVUk4vaDR6Z2kzYXVqWEFZN2U0QUJYbnQxVUpqVytYRFhM?=
 =?utf-8?B?aG4yWjdXdzU2Q3J5Um85SG9WcEJtaFZ4YkJKR1B0S2l6TWtSTUJlejlteDdR?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mUVYZeLDIHA4UjPlSLBjd/1pIWC5nUAHQbeSH8keS0c1HYpMNcDfwhFTvZ6M1kPkQjh3ulslaNMaer45sD3Qc73HApY4gW3i7TjwVYpqrgHkCPvwhLd8MJ5BkPoY/h68FVuYwnoqrX1TN3AlvpSHGXoSDQVmM0ph+J+4A3RG6SyDzJoPCYqymSrzVCnNW09+JG+P2W4N1To8ZE/THWpg2+/JTnyjIOX8eUlDD0D5oaAkFW00aG+4bQi0uBpuOdIzJSGRsfMPFyY/4849InGd739e5QvhUjwk1eHXrx52GawYfZFDxSTPANrgGZviMhPNK3ATkQAIc1vEkAw542LUDF4n8MAYoYj8ord5Vai7rtUWFKmVGAsNXus+J+oH/9/NHNW6lQ+5cvMJK04EsR3Zy+F5E/4xpKOcgwH7vaS4Qo1s7tLb8UyghhNfMXamQ4REql3npCpO7xPHdZzv87iWb7oYwLAWZQY1FgtrSm+/jhK4Z/sRD4afvtS35a5BCiwj/P3u1b3Yj2iJJSh9SHRZCWRitGUaPK5mD7flOxLFe0d2x/o59idxVbJGIcyPZ4uKi0w+LCF59GuDvtfnjD+ZKYsJwHcqyujcfyN8FnNKJMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204d2b82-976e-4fc5-faf4-08dd25ab0231
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 12:44:16.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9IWdOpOSy8w6kNhjkkVT0LWyaXXCfv33D4aWv7duaMutDSuE19m9r/lZim6wc5TA9U6dptGFMofcU0v3M3/qLIvgv1b36R7TB3nuXe4+Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-26_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412260113
X-Proofpoint-GUID: p5Hh1gzfZFQCtLp9vc58T0oP68Rca4-9
X-Proofpoint-ORIG-GUID: p5Hh1gzfZFQCtLp9vc58T0oP68Rca4-9

Hi,

On 26/12/24 6:51 AM, Sasha Levin wrote:
> [ Sasha's backport helper bot ]
>
> Hi,
>
> The upstream commit SHA1 provided is correct: f1260ff15a71b8fc122b2c9abd8a7abffb6e0168
>
> WARNING: Author mismatch between patch and upstream commit:
> Backport author: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
> Commit author: Vasily Averin <vvs@virtuozzo.com>
The only difference I see is that this patch has my signed off by?
As seen below, the tests also pass. Can you please tell me what is
needed to rectify this warning?
>
> Status in newer kernel trees:
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (exact SHA1)
> 6.1.y | Present (exact SHA1)
> 5.15.y | Present (exact SHA1)
> 5.10.y | Not found
>
> Note: The patch differs from the upstream commit:
> ---
> 1:  f1260ff15a71 ! 1:  ee7ccf9396c7 skbuff: introduce skb_expand_head()
>     @@ Metadata
>       ## Commit message ##
>          skbuff: introduce skb_expand_head()
>      
>     +    [ Upstream commit f1260ff15a71b8fc122b2c9abd8a7abffb6e0168 ]
>     +
>          Like skb_realloc_headroom(), new helper increases headroom of specified skb.
>          Unlike skb_realloc_headroom(), it does not allocate a new skb if possible;
>          copies skb->sk on new skb when as needed and frees original skb in case
>     @@ Commit message
>      
>          Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>          Signed-off-by: David S. Miller <davem@davemloft.net>
>     +    (cherry picked from commit f1260ff15a71b8fc122b2c9abd8a7abffb6e0168)
>     +    Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
>      
>       ## include/linux/skbuff.h ##
>      @@ include/linux/skbuff.h: static inline struct sk_buff *__pskb_copy(struct sk_buff *skb, int headroom,
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.10.y       |  Success    |  Success   |
> | stable/linux-5.4.y        |  Success    |  Success   |

Thanks & Regards,
Harshvardhan


