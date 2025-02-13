Return-Path: <stable+bounces-115393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D149DA3439B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4FA3A1096
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EA7266186;
	Thu, 13 Feb 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VVcpiBLZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ou1Wd0gc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC31274277;
	Thu, 13 Feb 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457895; cv=fail; b=YemZvLzOl21/hwhhZZynJ5MPLxHxcIpEubiY2unjdwNTxN/XTctuEu+Qf6AGog/Wh8lFGvvVGdyNo0yydBe5hn4AhYQbIoY7wIKtclLLhrRZbRQdQLl4lxa2zqRyOyaqd5pdCrIx/oa9l6SYVN96i0MQA+6Uem7Vs5lNMZUdfB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457895; c=relaxed/simple;
	bh=Lln2/92jDP4nNtDxfoiovf+CqbZXlpP6kAHOsH/SVgw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oaY0qXotMUd3z4MJn1gPcesjvTbbRsn3p+FKQeA4w4Yy4nu3jRmP5l05xEhfBsM6FuFCSkjoay1eq4BpmpJ+tbFjs/q9EUQUGyEtRZNEKnqi2scwBz/7F7HQ/c6N4CwIgnXGpCdCYm5wVzCB5+ElDAP0+n9BL7aikrAcI790LOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VVcpiBLZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ou1Wd0gc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fekT001627;
	Thu, 13 Feb 2025 14:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kP8mfV+ermlZJIlCt75lVvAFOaHZvwzM19S71abqWoY=; b=
	VVcpiBLZFAohKsyxkAT1PHWqQbvJlaTTt0NTbv/AMmOrMfyDkAzWMPeiIuvjPAZy
	blyAsFeAR9azEEk2v0bt7DWYpW3MNSzldZrWdOE4jXOnbdwdb/LRnH13Nfv8uHKc
	mPsvRaIDt7iUxVf21wgpkWo7sycCOwgB5B3i100EPfDWzuxMwK2EhENPUftlFGor
	2NvtKuGRf9STA/NDbQp6p0lOk82sgDz/u3PbBQgAQYQYvqM/1ida5VHn4/m60oXh
	fgNkZ03Q6aJz6l3q2fed5xBZ0AFNgubLIPVQ660CSEPen4vCzHQOb0p23K64nQhW
	D1/hv5OgT/4vVSIGnLCkdw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qahp8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 14:44:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DEOqd0016237;
	Thu, 13 Feb 2025 14:44:38 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbtvwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 14:44:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJnMSlcuno2qtfnPz9SxDNyGE61OgAgMJdQu06jnFkmh1HmxkEyTNfqARgAUukV22lM52pL1Ru3Qo4plZwwNoTNbwFLZvlD07IJxNKsQ3aiRdt0S8HxxgxDkdaY3eycG3rgdXFWLl5y6IgRLPcCHyMQN6tGP7hVQ//10umOEC0wUQWPR1jD3cO5glnQfZSgcOpSQWLYjacCtxg9QrxkVDT698oBRfdT7gr2+TGAklgUVUQRbN1k8+8HE6onFJ3SWAvaCBsTF7kHDVMPJAacTVA2c/OQtkD9al86BE8q1UCxy5CN6waVSx6hAAmITChsvshSp6WzZBBduadL3nBenGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kP8mfV+ermlZJIlCt75lVvAFOaHZvwzM19S71abqWoY=;
 b=otdu9GfsdrkorScq5HAz7c3yCPtDr3RO13hc0WHSrAZ/9BRQuPWh5dJ1RQaiDBI0UhJnN3/XCKGimCb39NfmzHeuPoqv0+rbaGsfV5BVQ/iN7LHUnYBhO334h/Knrkz9S/UggvIe/f/10b2k0JlnHfDk6KOCgfE8wzRswDkmdow8ZtrzkeZyIkoV9yf//dIw/dVKtFUV2V47lZCRpwwGG6wgX4+7s3Y+8MU+lRo3PPVJyQ++DynIE6tNsMsLVt/o0FxHyPKcPqEBROQ3/4QupmCwS9PvYxkAibGh6OFhOcKt44yDJvviVZH5PDGrhgOC9VePa/jJ2nMomfuf0YnBlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kP8mfV+ermlZJIlCt75lVvAFOaHZvwzM19S71abqWoY=;
 b=ou1Wd0gcAQL26sjK+3oBOmk0qgNftdQyQRAH/ezMwjKmR/eeD1ss7GIgzoPKD4M5bo61E1E791BJI9Nt0LJHeNpDMVTWQqrsK/UgwR5B2isox9MzpUufMWDqzknEslTNgy/u3nzaDKbuxYYYziMUXRuqqpN0iMtK86tu/d4iRIA=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by IA1PR10MB5971.namprd10.prod.outlook.com (2603:10b6:208:3ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 14:44:36 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%5]) with mapi id 15.20.8422.021; Thu, 13 Feb 2025
 14:44:35 +0000
Message-ID: <a33f888c-2121-46c0-8fcb-7ba469309a8b@oracle.com>
Date: Thu, 13 Feb 2025 20:14:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 0/2] Fix rtnetlink.sh kselftest failures in stable
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
        jiri@resnulli.us, liuhangbin@gmail.com, kuba@kernel.org,
        netdev@vger.kernel.org, stfomichev@gmail.com, shannon.nelson@amd.com,
        darren.kenny@oracle.com
References: <20250208185521.2998155-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250208185521.2998155-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|IA1PR10MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 645e650b-9ed7-4a63-e4ce-08dd4c3cef12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjU3Nk1IRm5FZ1JJSnhVZWdMa1FFTmw0QUFkck55KzJ6TXcyc09lMmI3elZh?=
 =?utf-8?B?a3ZDYWR3MzF3bzcwcTF5d3NBM3dYdmxsYzIzekk3djFvU0E5cHA5blZNNHdZ?=
 =?utf-8?B?amhyUG9uY1pUT1dmU0R0QXhkYSs5dGd4blV6YUh1RlQvMmRJRlhiNnY1aU5l?=
 =?utf-8?B?K2NpdSs4Y3BuQ3BhUHZaRTMzelN2d3RuYk5FMmMyOUNmLzF1U1JvVGFyQmZx?=
 =?utf-8?B?Yy9hTGJCSjlCVEpJN0JMNGE3eW9iNlhEWkRxNU5SeXA3dmliNmkwTGxEOGxB?=
 =?utf-8?B?SnZpSFRYajNhNytMblBjK1RBWExpZk9rSzErcktETGxCTndXbmtlT1FQeFR5?=
 =?utf-8?B?bVFxN3BxSGVkRVB2UjBHYlUwLzAxYWh1WTRNbFV0dENFMzV5Y1Vub2NFTmFa?=
 =?utf-8?B?dllacFNobk1ZZ0pNcFNiL1pKZFV5MU4wdkdTOEd5SS9kLzVlS3FyTEV2bEli?=
 =?utf-8?B?OTlGOTJoZmpObjFFNmZqNWRLbkpFWkFNV3d5U04vTU51Nlk0TXB2Sm8wdGsv?=
 =?utf-8?B?N0ljUGl3SENRd3VNT2g2ajRwZ2R6UUU3VERGTkdhOEdjY3FXSFVWT0lMQncr?=
 =?utf-8?B?d2xsNVBFdWt3SjJXcmsrM2VlZUhQRWpwWTBhZU95UzZPUTNuSEZJUWY3TEtF?=
 =?utf-8?B?aFo1OVMwNjFVRzFneUlWek1FWFRnNE1lREJVeWx0endvb2s5ZEE1WjNBS2Yw?=
 =?utf-8?B?RFo1MnVvR0RaRzhCcDljVEpERlZoZmovQnpqY0lFUDl4SjNLU1g0a2k5elpl?=
 =?utf-8?B?NXltZ0FCSUJNU00vRExLL1pJa3RUNjRxN3M5TnVsenY0THY2Rzh2ekExS0JV?=
 =?utf-8?B?RnNBYjJEV2xEa004bTlFQlVFWm1SelFuYTJ1RHlHU1MrNndIcjBjVnd0RzFw?=
 =?utf-8?B?RkNycklja3FuMXJVR2JKd0lubFdEOFBocWtSaE9oQzRSZHI0Zkx2MEVOUm5z?=
 =?utf-8?B?eWQzUFlieks3ajM4RUlobDNYYkNIdWFmMnFZY01ZZlVGUDhsNTQ4ckh5Y0Uz?=
 =?utf-8?B?WEZ1bFl1TWtwODRzdHh1RjZNRFc1MVc1Qk5FUVozeTVucFI3NHJMcmtnZjR3?=
 =?utf-8?B?SWNweTBSRnU5cW9KUytuOFEyd0dFUndiL0hrUHdsQmpvNExXMktrVDVCME9C?=
 =?utf-8?B?NDBNRDJJOFU3NDBEOTZUclg3SDJHWUQra0RpU0VUUk8vMWhlQmpwLzY0a1BX?=
 =?utf-8?B?WDNOL0ZsZmN3V1NyYXpZNkN2OVNtOEhITlFSYkdZYzFMMVQ2d0wxbFo2NTBQ?=
 =?utf-8?B?SUZrSHRUN3NhOXh2UkoyZ09KZGFBSTVPQ2xaU2tzaEpldkJYUXV1UXQ3ejdz?=
 =?utf-8?B?SXovWnAyUXBRZnJBam54dXhLQVJwTU9DTElrN3lPTW50RUZrMGJjMFJLSjRP?=
 =?utf-8?B?TEFYUUx0T2hzaWpzQmhPTjB5RWF4RmFickY5WHJ2RGIwcDZwMzI5TlFLSnIw?=
 =?utf-8?B?N0VLTnRocDhUTDh0bVpPU245cm9aQlpVR1k4cnRybDhwOUZLYlRMUXJIZVV0?=
 =?utf-8?B?WDY4ZysxazRpdWc3TFJVU28ySUl1ZFpPYVNKV3djYk9tN0RFZE1LVURHSS9l?=
 =?utf-8?B?ckdvUlFORmV2NkRleGxXb0VOUXdqTDBGZ2hGdk9mY29WSDFsWmNuQy9YNm4r?=
 =?utf-8?B?Wm5DM3dFd2pGQkJIaVAveVpBZzZScDFpVSs0bm1IMEFhWGtFWGsxRVFMZmtu?=
 =?utf-8?B?RXBRU1NoYnlHc2xMZzVsNnpJNGFVbk5QK1VkVldpclR1cWZXT3NNSk9GclpS?=
 =?utf-8?B?eEpYZFFSU1pTWUFRMjFVTE5udUhkN0xoeXgzZFE1ajY2Yk9jaWYvRTdGL2JS?=
 =?utf-8?B?eTVPQTJ0VUpOaUVMUjYzcnJObzhtelZVeS9WV1F5YS9JNDlTSkp5OVg1b0VN?=
 =?utf-8?B?ckkvUDhXTU9ZMEVRVXovQUtkaTNmc0tEMHN5WlE0R05KNUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk5aTW41WkozZHNxNVczc056cEwyQ0dnc3oySlRiYmlHN3dEUTE5a1lxaFNh?=
 =?utf-8?B?Y0RQbW8xUUp0TWYxeG9abkFBU1ZxbTdYbGkwb09jNVhzQnZyZGg3N3lTVW0z?=
 =?utf-8?B?Y3VOSTUyZFZiMHlHbUdDbXJkcjUwUVlsTHdBWCtRdm5sc3NpVisrOHpoUmVn?=
 =?utf-8?B?QkdwVXJsd0pXNEhmVFQzWTJ1VDF1N3E0RGZmd2tla3plMDY1SGxTV0owRHho?=
 =?utf-8?B?eCs1LzZuZU1LMko2RjI0Vml5Qmh3UHFySm9kcUpaUmoyOXVNTlBkR3NHVmRx?=
 =?utf-8?B?aTdtOGZycHBXODA0cGJJVHZORUxBMi91cGhhZStsRUJLSCtvckMrY0lJZTZQ?=
 =?utf-8?B?NFBubUM3TWdGNHVoajFNTzhUVHZYNWhTRVQzUnUxY0dYbkVac0dPOTNDQWdL?=
 =?utf-8?B?OTAzY2pPUjhZRnhtaVIyVUVJQWVtUU1iTEo5TUVhOTRuVjgrVzdGMVdPajVL?=
 =?utf-8?B?eHoxZ0d0TzdGL1lKM0JpSHBnMmh3c2ZMdmpUSUo0S1VpUEoxc01Sdzdwc3Q3?=
 =?utf-8?B?ckwrM1V1QW0yN3NNalN1ZVJyMlMvMzRxWlBoTWRoRUJIdlowVzlQNExWc2xk?=
 =?utf-8?B?RUZDOWh5cWUzREhwc1I0VkVoWm9iY21UZVp2elExampqV1U3T2dZeXlXcnBW?=
 =?utf-8?B?SGhUZHJjQk52T2hhYXppSjgwYVhCTHYxeWtrdXA5ZFREbzNrL0k3ZkRsSEpr?=
 =?utf-8?B?U1Z4MFE2aGhkOWp4RUp4UHpLREpxbGZHZ3hRYkRYbVhBUnI4M2dpcWkxOC9Q?=
 =?utf-8?B?ZGIzRyt2d0I2dXdVdDdPeUVzR0dMMjVKck5iMVk3bUFVdDdQNk1xTXZzQUE1?=
 =?utf-8?B?SUNCeUM1M2lZQkpQQlQwTnd4SUI2NjBiZURzU1J4L1FvYysyYmZlVS9ZT0Nv?=
 =?utf-8?B?eVo4YjB1eHZVeGsyMUVjdmlKbGFEeS9XTGxEMXBkNzhreEc0RU90UmFwY1Rw?=
 =?utf-8?B?QVZGeDZENE9uVVF3K21qakQ1blgvVWZSTmhGR1B2eExsODkxQVdCVUJlSWpT?=
 =?utf-8?B?L0Y2V1VZSENTQ21rU3p2K2hLT3FvVmNDRVE2dE9uTjlsUUszTG5KUGNrZndN?=
 =?utf-8?B?Rm9aQWVFMXBFZHAzbyt0czVYdHF1VFJBeXA0ZkRjQkhjWXdXMVBvSllUOTVV?=
 =?utf-8?B?eklXcWlEWmdNaGRYazNERHk4cm1QQmlmS3ptN0ZOR2xVYkYwTXl3akZ6ZjNs?=
 =?utf-8?B?WU5zUVhQSWFMSHgzSnA2THZ6OS9LVGlSZzA5NGMxa3lNdlRHTnZiZFVPZlBM?=
 =?utf-8?B?V0VoaHJWamFySy93ZFNiTSs0L0VvdSsxcFhNWnpaRFZ6b1BjZkVEWFYxK1R4?=
 =?utf-8?B?T1p6MWhiTlJybk5MZkd1SlM1Z0EranF6WUt2QURiRDJHQWJQUS8vcnJ6ejFw?=
 =?utf-8?B?YnpkUWZNMzh1emtzSTkzUExCSTlWYkJyL3g4OEROSkdFaGRtNyt4eDZ5TWl6?=
 =?utf-8?B?UFBYMUMwTnpUUkkyb3QweHl4cU9TSjRqRW93d2t3cXZTWHJtVkZhNVpoeCtm?=
 =?utf-8?B?NDR0MVp4ejJLWlFVN2xubk5CTFErTzBxdnZZejVvT3ljNjM5M2xTMkJzYm8z?=
 =?utf-8?B?VXhseVFsWmM5c1NHQURaQmJneHdXRTZUNkRvZ3lsVTF6am5mdktyUmJlaTFS?=
 =?utf-8?B?WDRES3plM3IzMjR5aXptN2FjU2J2cEpXUzdjcnpGVmRIT2hnZ0laSkxPVDBI?=
 =?utf-8?B?dzZUeFJETDNOWVQ4TmRNQzM2SVdPTktCSVRjdEtXZE9mUDZaNGREaDlROCtq?=
 =?utf-8?B?WlpvelIvSDU3QjJzNlN1MzY2OWlOTXcwWFdjQlVyNmM4Smo4NGhZaFFHNFZv?=
 =?utf-8?B?ajZGQk85aUZGTVpwcThzMEZmdlhGSDFISG95TEVpcktnM3ViRWEvTlJoc3k3?=
 =?utf-8?B?S25sWTVRUjkrYVQvM2xoc25RUjhLbmM1ZEpiTUJxVXgvYlNjREhvdEJFejFy?=
 =?utf-8?B?Y3RMNlMwZnFtbTNzT0pwNkRMQjM3VzdzQ215Y04ydnVyVkhxNEMxOFFnS3gr?=
 =?utf-8?B?VFljYnpmK0xmaVJ0YStCdjNkb3NKaEhDb3luUldIM3RXcGczT1FIWDJQMHFV?=
 =?utf-8?B?bnBQT1BqSENRdW9MRG51dlF1aFZQOENFcnViTEpUSXlwOGhWa1JHMFZLZndk?=
 =?utf-8?B?ME9WZmc5U2tSOStjOGpiMHFDWHNtTTVtbzdYN2JQRFoyU3UvbmpiRC9zdDZD?=
 =?utf-8?Q?HuYyIUOHTX4bGrB3LDRbIas=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Umdvb1fVM0GIg0EcInUrYXeHz2jvzXSix4cGh2Gw7FSIK7nA7dEYR2obkddClmdixgQA4vJzRKJuugRAH1s8X74ipMMBzC/wm5fyrnLky3YZf+A3Ro3nR3TDPkLUfD4IGewqASTRn6e6AwU3YrdEDwFS7cX+yC2yubBbJptJyEFHLA2BBhhmJF5CjT3EPGK53YZuzgPXSq92exjYWY2Vv0OddOLTTO+9t3VwTuoB7g7iBAeFHFSE1LpEOCWtKyu2IAAThec56n75LR9I3px29wfviAvIUPwKmY7cYmeUsyGyxxNT8EmnhQEEVdypXS/cUU7z0bUls8HubGMU+1anZNgeD0llaV/0kl0VzWp6fUPkLCngN22Vu+t2fmqYLtHbG7NkCXO3V9IV15NNJRgQtlQdgJ+3GofEENq69n7hhTdwzJBmy6FXxXau3J9ta12XLJDmxh13+ZDkpTJp+LST5VOmM38U77NAxz8j7AFAsDLmI5J76JgkE/yuGs9AMVf641BcYDOifFc8eTCBWj5rE+iL0Bi2KpMlGnaFhMnHtZYGL2wRzAgvsyjnjEG/vK0YY6PtPVQ8j+0XWFwJZ+Er81NqmcXgrzQPjHcy/AvCoxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645e650b-9ed7-4a63-e4ce-08dd4c3cef12
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:44:35.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1PrJmEfDJouaPlSXG1f/+7Za1vuY9IADWCF4pd1x6Ai6VbySVXDOZ5ilzORiQ4Vp/q0tdwLq513bw4AfxGyeIYK70lDVVxy20YfRzCvxfD9OdgF3SzSczr6IF/SWV5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502130110
X-Proofpoint-GUID: PsZTy5YQtH_n4SitvhdTbzQz3UowfGF5
X-Proofpoint-ORIG-GUID: PsZTy5YQtH_n4SitvhdTbzQz3UowfGF5

Hi Greg,

On 09/02/25 00:25, Harshit Mogalapalli wrote:
> This is reproducible on on stable kernels after the backport of commit:
> 2cf567f421db ("netdevsim: copy addresses for both in and out paths") to
> stable kernels.
> 
> Using a single cover letter for all stable kernels but will send
...
> Solution:
> ========
> 
> Backport both the commits commit: c71bc6da6198 ("netdevsim: print human
> readable IP address") and script fixup commit: 3ec920bb978c ("selftests:
> rtnetlink: update netdevsim ipsec output format") to all stable kernels
> which have commit: 2cf567f421db ("netdevsim: copy addresses for both in
> and out paths") in them.
> 
> Another clue to say this is right way to do this is that these above
> three patches did go as patchset into net/ [1].
> 
> I am sending patches for all stable trees differently, however I am
> using same cover letter.
> 
> Tested all stable kernels after patching. This failure is no more
> reproducible.
> 

Ping on this series:

6.12.y: 
https://lore.kernel.org/all/20250208185521.2998155-1-harshit.m.mogalapalli@oracle.com/

6.6.y: 
https://lore.kernel.org/all/20250208185711.2998210-1-harshit.m.mogalapalli@oracle.com/

6.1.y: 
https://lore.kernel.org/all/20250208185756.2998240-1-harshit.m.mogalapalli@oracle.com/

5.15.y: 
https://lore.kernel.org/all/20250208185909.2998264-1-harshit.m.mogalapalli@oracle.com/

5.10.y: 
https://lore.kernel.org/all/20250208190215.2998554-1-harshit.m.mogalapalli@oracle.com/

I noticed new stable rc tags being released, so pinging. Sorry if I 
pinged before you got to these.

Thanks,
Harshit
> Thanks,
> Harshit
> 
> [1] https://lore.kernel.org/all/172868703973.3018281.2970275743967117794.git-patchwork-notify@kernel.org/
> 
> 
> Hangbin Liu (2):
>    netdevsim: print human readable IP address
>    selftests: rtnetlink: update netdevsim ipsec output format
> 
>   drivers/net/netdevsim/ipsec.c            | 12 ++++++++----
>   tools/testing/selftests/net/rtnetlink.sh |  4 ++--
>   2 files changed, 10 insertions(+), 6 deletions(-)
> 


