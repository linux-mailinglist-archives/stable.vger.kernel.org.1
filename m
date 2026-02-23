Return-Path: <stable+bounces-217692-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dpavLyP0m2nj+AMAu9opvQ
	(envelope-from <stable+bounces-217692-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:30:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 486131721BA
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 07:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EECA300CA30
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A65D3446AF;
	Mon, 23 Feb 2026 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WwifSU3J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L7ExtI4J"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CE3EBF3C;
	Mon, 23 Feb 2026 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771828254; cv=fail; b=i1EYijgdjx1cRTiLMKHBpBdiFZrDQ2MgFZmcjmPeVlyjlMuVifLbc9y8Y7PfEBr/MbBbBKEHFJ0+uZQoE5QBxTQ2YmigW3qqKVOxWhOqREgMVeuHy1o/hqqUa8Pr73cSZJtN6oHT2+rFnLtGHvePlU7nigh1yyyPiFfVTcmm6kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771828254; c=relaxed/simple;
	bh=kQ0GJ5HeRU7XfWac8wgmcDfq9mB6HObvGJelkyTmTlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BLVMgy3efsQhnLRGMODpnoZWT49K64UMTixV2GHSOcak7T3mRSYKMPVbNQ2jcS6DWt0x+bkRDGn+1G9H326UIN6qGJFRft0rTjiTYwRPbsEB3AvAqRpNf6rVIKuLp8fZIMi8OjLbkMoELWsJxXKrlITz41yilFsgWHZmvEhGkO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WwifSU3J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L7ExtI4J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N2aBFU898296;
	Mon, 23 Feb 2026 06:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=55T0cSu2E0V7x1rX0NLG+rwOZt9MIFdLoQDVT86m030=; b=
	WwifSU3JECVTZ2w47CjSEciBK8T/0qAjCkdM66Y4DL6w+1/F6FA5KaPEAXq66W/k
	++BQy1ZO+40S+b5gq5AwB1Bo6DIDlFqy7JXczw5MmOfQRgiCjhDrerF3+gKLHcyd
	zx86tlBTqKZ6pn0o5yUUeWjqlbVMwy2VzdjN/sVdLyrMPyq4zlp1lPPqK/BnfBjP
	rF95Q/lVm8ulmHPPaNl5yLhicuH4ecSAysXqzjyT1kSCeq0KCNazSlkC24qSYfCL
	1rBew8njaq2h8vkGpZjMUARalYwRMyFfUfzsRlHBBp8y0Lrq6v1xgkyUoTcib6WQ
	mrKeVjoMv4Mf8B49DghGMA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf34b1m8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 06:30:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61N4uCdY006423;
	Mon, 23 Feb 2026 06:30:46 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013045.outbound.protection.outlook.com [40.107.201.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf3587w38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 06:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuTPFFIAswUIweKXTnKxq4bE64dZG5goJeB9/ISyHj+AeMRrngb/zI9lFtkFB2P2iauRw3K6QrZmZTqIphbsc1tHJzkepDZFk3hOKzBUNoJqRiGB+qqOmv2CpjaC4wfFeOR5BheYlQDshwtsFNHEijb5lLLvyv/4fHIjy1vD74XwsksYAUsUWl89Fd3pw9u8nyGGjQl+LqdteuMU5FApOruRPijPENONW8olbYXy3R0ZBDUcBATSOk5i8pEZ9iAQhu2k+x0tm/wrmu0wMA5NRfFKmXqzx/WNFAEeh3OjzR7C9FB6W3PHd0IsSgpDvQIDoeKJK4uCzIBfyJ8xat5dZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55T0cSu2E0V7x1rX0NLG+rwOZt9MIFdLoQDVT86m030=;
 b=F98jP9p9KLjWR/+A/m6LUAOUsCLv5etaE4ORpctl1VHjxgBJcBLFl3k6vKej9Xpu+UjskUTCz8wGmkyHkw8S5UzbF+KbSS9Ya21JcddJoN43DeKyPqZNhc9NmKinhXpaEQE2pzgdW1bSGua+2khqeWQVj6rYympjldIw1eYUewpktFcu5HYyiDxt5x6n9WOEltQ6wWd/OtX+7LklFyrauuGd5Z+C7eQHCFiKohlrXKZ3Y+7rjQGcmNGLgiVH6ezeBGcGeOkFiLU5OOrtQzyTMYJGml6vzyAoUbFiZJlzZfpy0YDRjyKTdiq1Qs9Lhhnj5UZeIJZ0aXgV7J9g0fe1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55T0cSu2E0V7x1rX0NLG+rwOZt9MIFdLoQDVT86m030=;
 b=L7ExtI4JKP/2YFUuNEfUYHGssw0V5FiFeLT8q/ivhaa6XBXurJm4+v91W27r/ASi+KfXI0U2qsa7IwC8ozuLlzP7F5xlwYY7WMeOVFrlr/m8W3pUO+rpmlVsJD1cff80CkylydP/APLJL6KY6+kf9amgnlF7HRcGOUS3VRZQYeo=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Mon, 23 Feb
 2026 06:30:42 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 06:30:42 +0000
Message-ID: <72c82840-5853-4a7f-96e7-51225f61abca@oracle.com>
Date: Mon, 23 Feb 2026 12:00:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 00/14] Address pkey self test failures.
To: Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>
Cc: stable@vger.kernel.org, kevin.brodsky@arm.com,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        linux-kselftest@vger.kernel.org, Sasha Levin <sashal@kernel.org>
References: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
 <2026021904-unclothed-flavored-cdf7@gregkh>
 <e1cb6b3f-ab40-46a8-a338-70e4a18f687b@oracle.com>
 <a45eaddb-9e17-4e82-8a78-a1d1f6e3d735@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <a45eaddb-9e17-4e82-8a78-a1d1f6e3d735@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::10) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|DS7PR10MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 689ea9c6-b296-4323-29c6-08de72a5114b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGxaemxkQUwybXdvTDNjRlp3bWpjb2pFNmJNdnp6MXRhc0lyK3BYak93U0dJ?=
 =?utf-8?B?TzJvREFETXJSMVBQUm16VWFlblRIUlFmUnVoUzd0b2FqZkllZUg2MVp6aGRs?=
 =?utf-8?B?cmpSRlZERFl6Ujdzc2c3N2txN1JiL0lYcjJNWExxcmFnM3JlbjFTb01mVzNy?=
 =?utf-8?B?czZlM3NmRmhWeWlTQ0U1S0xuOVoxZHdEWk5lbTZtTFlvQnY4WjVqdTRPTS9V?=
 =?utf-8?B?bDA4SGpqQ3REb0VRYllGQlp3Nm4zbWlZMjc4MXVvclFhQlo5bjludUM0S29s?=
 =?utf-8?B?UFExcmt1WmtvMDE0WjE1MkFIZW5waGx3WFpacWJ6SVFGNDBiSmdYbWtUMTNx?=
 =?utf-8?B?am91SXRwdXp6S0hSMlRYd3BCeVo5M2JYSXc2U3N1bXQycGRrZXhLb2oxNmw2?=
 =?utf-8?B?WXlZaTVXdkhCS2g0RW1WRGlaNkMzaWRDcnU2eHBVUTltTzhWSzljZjkweUtk?=
 =?utf-8?B?UkV0anl0RDdzTnYwWmxacjFaYkZJUXJ0aDVUZDhRdjVQTnUzTmF5R3hMVmxO?=
 =?utf-8?B?U0dNUzBtRnQ2RkN0TEtra2VFRit6RlA3d2phY21WNGU1dWdVeWpxRVkrSm93?=
 =?utf-8?B?eTlhSmc5YS9WNzFvbVR6bVJqM0t2TmpWRzlDbnV5cGFiQkRGcjdaUnpWTk5l?=
 =?utf-8?B?cFFDM2JtRUx1aVlxZk1IUjlwekRKY3pXMHZEVktvR213UVo4ZzJOTklreTQ4?=
 =?utf-8?B?a21WV3dISm9RUW1JNFRsYXlZekozZCtEOVREWldjK0g2YjBUYnlaMDBnUFFz?=
 =?utf-8?B?bURZOVN1U0lnNTY2Z2wxYjJhRUp3clQwNG5Fby9aNWxsODJQWkt1VG1YRmNs?=
 =?utf-8?B?QlBUeHh6TWx1c2p1SzBpdDR3QkFRTlIyblpaTmkyd3VDMnF4OWZTdytqK0pJ?=
 =?utf-8?B?VXBoTStHeGlxeWIycEJRMlFSRHgxa2tKc1c4Rm1TNW5jNXd0eFhrc2IrR1o2?=
 =?utf-8?B?Uk9uR2xlU1lGM1ZpeDRxbDE4MEhka05LcHR3VDhvYnF2eEJKUEQzeVpkOHRO?=
 =?utf-8?B?ZWVDdWlGS0Rkbnd6SHI3aEtPbVBVQ3dDYkZSWG5BcHVUalJFaWxLVkdTRHhW?=
 =?utf-8?B?ZjFFcmlNUzVWbS9uWkxqQ0pRQTM0MERmWUlaaExFVGdPN0gwbUxjcUZ0ME9l?=
 =?utf-8?B?UTJocWhKelgyRzlSQ1ZCdVhyV0hqcUZCc2MrQS9zN1h2N2M4Yld0K1V0ZnY3?=
 =?utf-8?B?Vzc5SGVyM2dUeDJtM1U2Tk5Fa1JIaWc4MnpNclhDWjExUW9RVHA2cFRTZWZC?=
 =?utf-8?B?K21kQUI1WWptbFpGSXcyS2xOTHBDdTk4MlRNV0xEUTRsZjNja0YrQ1dwQk41?=
 =?utf-8?B?TGlsQ2NVQVhlRXZab0VWN2hFSVpxYm9tVE83RXBpSFNMbGZUUHlKWW54RHJG?=
 =?utf-8?B?VzNjeW0zNEkyR1VrSmhFSnFIZmhTeldlVzVTNVRPaDQ0NklvQWFTQWgxVkRJ?=
 =?utf-8?B?UVhoRkJqSm9yclhNMmdUTWZTbkVScFN2MnM4M3U2WllYRUNOU0owRVArM3JE?=
 =?utf-8?B?YUJ1OEgwTU1jMkF1bHpmYTE3cWROZjdtVUYvWnhaMFMrWDIxOHpBajZvbjlY?=
 =?utf-8?B?Z1JrYzRrQnlhd2JNVm9MVGJYVXRabmg3ck9LVXdaVStCNExSSytMSVBaeFJE?=
 =?utf-8?B?aGJuM1RYeFF4d0I0ZUNUdDRQSldIVmpTbk8wZEdVWEpKbHBReVA1aHJDUnVQ?=
 =?utf-8?B?T0RTcFNxZnZ0YzllQUI1K25IN0U5NkpDN1ltRkNjemtndmpjQkVSaHFkVGJw?=
 =?utf-8?B?TTc1elMrL1ptMU5HMHhHZUZwSU4zWjRFcFoxajFSMXpXdnQ1K3FvejJtTHhy?=
 =?utf-8?B?b3hlNUR3Zjk2TEJDbUZXQWROSXBqeTdHRFJaRlRVR2ZNOVU2L1ZFazdpVUk1?=
 =?utf-8?B?QUIxdURIWjFGYWNlQnh1MjFvZ1N1Rno2UnM3SjhEc0tvQmVjZTBRalVNN1k1?=
 =?utf-8?B?UVZvTFczWDM5QzE1cVRaNHBSbHJRSElhV25wSVhubmpzSmVVdWc5SzJZZHRL?=
 =?utf-8?B?aFVjUWVTQ2NYbmNYSWh5ZWdCZjN1Sm5MaEE4V2xtNU84SXhBYXgrc3pkZ080?=
 =?utf-8?B?V1hydDlWbzNPdUtOS1hRYXU5eG5nNVZIWThoUzd4eE9pNHFVTGdLbFJxVjdq?=
 =?utf-8?Q?lyv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWNhMjl4Q0dseTkrNDdnMkZ1OU55blcxeHFjVzgwQ1JuMkpRaWRQT2dxdG5U?=
 =?utf-8?B?bk82bm9nVk1XS2ZINkRxbGtJT2xXTjZwVnBnOFZGTlhDMGdQZU0wTzQzd3g3?=
 =?utf-8?B?VDJpWGZyWWliU0lTdHhqeStONWxWaHJZUjJiTldHMDZSQkVWc2VJU3ExQ1Jl?=
 =?utf-8?B?K0xVMTArem1WTWpjVE1kemNiUjRYdzhITlpCbi96ZEFmMTJwMzNTY0dTMU1a?=
 =?utf-8?B?Q2ZFWEtpTVVkNksxMFZ0aE1LaTJicmRRU1NDdVVjamJuOW1meVM0a1hocVc1?=
 =?utf-8?B?RXRWVFMwNG5RSFFwMmNYY2NwQjdkcE5kWGMvWTd5WitUZW1ZSU8rVlc1SXdO?=
 =?utf-8?B?N1VPQ1ZsSmY1ZytYWmU2eGNaVlI5Tisvd1JzZXhHeEtDUmhBTUp4OTBkZlJa?=
 =?utf-8?B?blJ3OHlrMnZVMlpHbDExTForSXJaV3VlelZEM3pGSkZoRUpoOGRmNGhuL1Ur?=
 =?utf-8?B?VzREZzN1bm9oMmp6a0RlZWlhR1dOTjh1V1M4dXBiVGdwZ1k4aDdTLzFrRzJo?=
 =?utf-8?B?bEZlMmwzcVFIN1RzTXROR3dESHdtTkFhUmpNM3F1aDlZdjR5SEpibzNzNmFU?=
 =?utf-8?B?UndQSXVOeFo5TUZ6UTVkK3hUWjA3bmtRMnR0QjlSRS9pdk4zOGZzeWMrZm5P?=
 =?utf-8?B?REpSNjBvSzM3U1hIc3V6N3Z5N3NYeHZvcmV5M05Tb2VUL1A3ZTgrdCtQMENQ?=
 =?utf-8?B?VnUxengveXhpcFhjK2EyeElpT2VxUWhuR1YyMDVOS2NvemRaUzBrSHYrWHc0?=
 =?utf-8?B?czVMY3pmTlFUemJlY0Q2YnhUano5ZkdNTnN0RVM4eVZoS01SbHVsdXluT2lD?=
 =?utf-8?B?TDBMSjR3M2RRQ29rOVNWcmJtSTdBSmNwT3BBL3ZHS0MvY0FmMWtocys4aWts?=
 =?utf-8?B?aHl2a1dVdFJqYWR4SjE5SFpXTWtWQmM5dUhwT1hnYTlQN3Jib1hOUXJzYXBs?=
 =?utf-8?B?TWVuMTFCVnljNlE0a0F0Ti84cGJIKzlWc3lwQ0RxZE5CazhBVy8yNWQ2UWVV?=
 =?utf-8?B?Sk5CUzlRTjIwLzVnRlpWVkNLcmY0UksvSDVQMm93c1F1N21rdzhiTVV4bGMw?=
 =?utf-8?B?V3VCMmlnY2JTQmhlb0RoNzUxbE9tMGdEUUFyNGpTbnkxWkw1T0RHVzVIcDhu?=
 =?utf-8?B?UFBHK25OVWluNmtmbTNESkdoOEMrbVVLRHpZcWhUcnNLRDd0ZG1nZklLcERq?=
 =?utf-8?B?S0JMQkVTTU5IbGNra1VyM05ZMXZDU1dVaGV1aHIvU1ozdWRzSGNob1RmQ2V2?=
 =?utf-8?B?UkZPUHFBV2J1Qk92UUNCYkowMzVIT3ZWVzZnRnBWa292WXAzS2NtL2V4RWtY?=
 =?utf-8?B?ck1RY0hJbDd3OHlVekN2WVhJSkIzVEZoT242ZjdCUWcyL2RCTHdLWlE0bkJ0?=
 =?utf-8?B?RTAzNlQxTHhUT2xlaWFXUVRObHBVTzYxbVpFdWptQ0h4V3dSTFdkbzJiSGJF?=
 =?utf-8?B?TmtUY1VCa3VmRmVNUkp2ODNjdnAycmVSMkxnQ2FiQ1dxWGprQjZ4QzJnYjIx?=
 =?utf-8?B?UG9yUjFQb1d2UUV4b3VVWlR0VmV0eEpOQy9mRG4rbThGN1R1QlorbWw2NGlJ?=
 =?utf-8?B?MTJ5dGd3QVJwTStWVnc3Y3RrYWtVWGRBK1hQa25pR0ZXZU4yQXRjTW05Tmwv?=
 =?utf-8?B?UitQWlBFYmdyS0p5ajJTUExSY3Z6Z0l4WWJOakNKeFFBKzdtVGV6TEJ0QUR1?=
 =?utf-8?B?VkphVWxheG03MUNNWGlVei9lVk1ZS1dORjRwOFdkSjAyWXljdFF3NGtyV3Jl?=
 =?utf-8?B?Q0c3bVl6Q1ZTQ1A2YTU2UG9kaytaK1VtNTBpMXhRVlZJcWQ5dlN3SU5wbUV6?=
 =?utf-8?B?R2dIeU1GU0tQZ1hzd01JZGJndksxclprSkE3OFRNMkN3REZQcFBwN3ZhR20y?=
 =?utf-8?B?dGZqSURlZ1h2N1NjQjRZcHpRRTFub3Nka1U5YzFmSGtRMGorbjVJU2M5Q0pI?=
 =?utf-8?B?SlIrREZIR0xYUGhZVEF4dWtzenVQeGkwTklhUEk3SkkrL0NYTURTN1VyNmxp?=
 =?utf-8?B?RWZEVmM4RDJaOXpaVlJVMEIwN2dmbm9BazVPWnQ0aFE4bm5STkwvRGR3ZDJo?=
 =?utf-8?B?Q1ZCWHVDcWxpL2R3ZlN1dk4wM3F4ckNkdFJDMlpwTXN5cmZLdDNPaEZxdEh1?=
 =?utf-8?B?bHhSSnI5dllmUXFEV3dHQ3E5TU1qRXFRL3djQ0xuZXZhUERUVzFSNGk4TVc0?=
 =?utf-8?B?dzFlaFZZU2llZG45TWM4Y0NYSEtOc1UwUjhraGU1UEVtUldmcUR0UnZaV0dw?=
 =?utf-8?B?Q0tmdXFUVDJHeVVYVzRjRzZWQy9OWmV3dW5xeUhja2NrRm96UTl2eC91ajR4?=
 =?utf-8?B?eVoyZVV6NkxoMGU4MnlNaW1MMjdDUFNGNFlFaDQ4dXYzaEdBRlZGa0VWSnM2?=
 =?utf-8?Q?dq1B+6E84lXP5OhC5YzSrmE1q+WIShajgH5an?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s0nrBOs0ob0TwiNma3CjgKcFQiPyiURQoV5BemqKsfcjJntdipBQmAJXR+aRSoj8j/76UcdjecZtgGHFLoL95Hbar43CD+W+NQf4yzeGaazEjkmeb9FW/onZBxgag1laROg+qsiSzy76a1Kia65q8Pa1vKGgxZC87vgym9jSMbD8pTz4/TjUJdzzab3DRnqNR8KP2BcuTSIMr0qPPWWH/wnROjCgA+ZXqnQP6liBQHUROlT89z+M5f/uv4IMVMAkOVgvARfS88zhIOVbXLC0sXhOYCQL2CiJyxf+Ai3wrOtZOCgIasfy7FIoczYeESvpj9yhwLQKfXyYTPBOvGwZVWua4R89Fi/5IwvSwQeZICsIwVdZ+odwCZo8oGPPtYvHZDRkMsf3qo2NZ8RdXxXEFXuJbOuALGhn3PJ/dR1OFnGYo9/pRQ7jHz4QvJIWrtzKkwhStToKbn3XS6s3HWVALqMuhHyvIR3/S5Sxpom+GDM72Zj7ZNIo/s+yGb1Vu13fwXvlFYaGC8JkBK7JW3gQ9xlofrWNJXpHXXpWuJLMp+4ePXV8iAaYrDrFTOAc7lgsrM/cMa6sYdoCjTaReoE+n+ZGKHZ8l0vo9tv0Ush0dsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 689ea9c6-b296-4323-29c6-08de72a5114b
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:30:42.0447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/UV7/pWZtVaLDpyUYx7To7scu6zCA7JnhoxBAusW8/9KcX/bP48Enrv3LFz2uIAO53KHTvAiK4YpGVVl38y2iY+vaErkNXJ/jYKy3uJudNhEmMJjdLHvV+X8KYdm/+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230055
X-Authority-Analysis: v=2.4 cv=GrlPO01C c=1 sm=1 tr=0 ts=699bf417 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EKmplW1N_46hwRVZdtAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fpCRI6Pyy_Aft3zr_Hht_GxX-H-8YHKM
X-Proofpoint-GUID: fpCRI6Pyy_Aft3zr_Hht_GxX-H-8YHKM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA1NSBTYWx0ZWRfXyv7xYbGHkqRK
 SbNuBXeX0qndwzb7fjj3YlUYqSDZe9RkfmCfzrDDzPUVcyNOe3s1NKYc5D2LaKIUcwdmrxFNlwl
 tRyfcVohUX3V6j//Ri5OupgwPaaFOck2N7DoinfVTR9sOhhc0OrMj7xJHOuq6mEx108OMTOtr/0
 XV0nfMqyqQtvX55ePVsM5YFsa9XUc8Ez8jcazXhrYpg/xY1efDPVfY6hkLz6Po+wh32+37zYwii
 b2H58Rf4I7M1+mSTjZCJOeoxyQYMjai5kxFV8uM1UtGrDQ6pnG3rG8IY+oS4GrOwyaNNpjyxtob
 FuRaDqXz1fPhoV/Nw+399EbAjqxCL5G/UOrrb9+3ZyeHKcx7rNqdoIkaN6XejU059EyljLfz+9p
 1louoXtnsDlcBlWjsVnF4kielkG40V82VLB6SJulG0BeN0vMiduiKaQvgIJcyFOP2rVQYS9sMUa
 k2k4Tli1dRmQoCOWeaw==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217692-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 486131721BA
X-Rspamd-Action: no action

Hi Shuah,

>>> Shouldn't you be always running the latest selftests on older kernels?
>>> We don't always keep selftests up to date at all, as you can see here,
>>> but newer selftests should ALWAYS work with older kernels.
>>>
>>
>> Thanks for sharing your insights on this.
>>
>> Couple of problems around this, would really appreciate your guidance 
>> on this.
>>
>> 1. Not all new selftests written might be correctly skipping if the 
>> feature is not supported in older kernels.
> 
> They should be skipping if a feature/configuration isn't supported.
> The right approach is to fix the test to skip.
> 

Thanks for your response.

Regards,
Harshit

> thanks,
> -- Shuah
> 


