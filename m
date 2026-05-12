Return-Path: <stable+bounces-245430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MElmDB7xAmrpywEAu9opvQ
	(envelope-from <stable+bounces-245430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:21:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6E51D8EA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 11:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F69B3073491
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469BD3B19AC;
	Tue, 12 May 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SFpdtc6G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HcmIIgI0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8C3A4F3E
	for <stable@vger.kernel.org>; Tue, 12 May 2026 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577261; cv=fail; b=La6rqSAEvETuBxFq0UNWBqhPGKWwEObsXP8ojTbg5EJoV095+kAnJ4h/Vg+hzgSKRYEe9EM8vlV53PQdKdPxXuoJd03qR9REynly6+6g3LLxxWdBgGprvFETJlau1JKorwegEc8uCzpWCfJID/xSHNJRAiMhvH6Wj8YyPYS+zTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577261; c=relaxed/simple;
	bh=nxxXmMr9uskPNlLpioKPRKGrhdWASmJp7VqM2lsU0Co=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kkhrSjZM0/YHVP6YPVPFpyu4Ko3Ie5+OKimfnfTROqdkEB0v1nk3Bk5EzF1LJ50zGchwRUEkMWPxBLDipfyn9qKjE9UqXcINfIY0bH4n+H2vHWZ3JmQwR53D/h2LMH2jJdQFIdagj+v8kWC9m+9/qmXkjW3GD72qHoUmrT2krg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SFpdtc6G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HcmIIgI0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C2uhUk3759684;
	Tue, 12 May 2026 09:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f//m4p3MZ0u4qNrxl/5H6i1hjB6d0s7/BUiujaXfJ7s=; b=
	SFpdtc6GSVBv6ScYFH9r5R78tEUFuM3u0NiMxCcVoh3kejqEVbcHa1jcbRbzmAG3
	KPrxTHd+ngrWmVyWChAAZv+SIFCmy+lEcrq7E7INiBsfzWO5P8gX0kpLDTyouloW
	1C6fdyOKdPuBdUnAdx31kCHQf+LKMqm4zovngqVjdXg7G6hEi1mj/Zsi7A+XUdJ1
	CpCTAXMu4E8k9wabsnt55NXzePV39J5Hdr7cw29fQ/g80fh4X6L8IIgJMiBguVsH
	WbSUv0eWquvNx/HkAh/2vXw6xqGsVCCJP+w1Arou+CXWKnwUKO0xFDzSlTrCcCcn
	gRPMx1kuR/gsgzhFKsSa5w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv38ufk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 09:14:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64C9BBHW003515;
	Tue, 12 May 2026 09:14:08 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e3ne9xjgm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 09:14:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1dMDCTcraQvItykhfMc25zB8OzVDIuzE1hFQ94tYmpUwfZhXVNWu9ltI6adorblxkPazPLh6B0pBDVCFodMEFea/VQqLdlokfSD+ns8iKYjCWZhUrtXkbZ/5q2ra9o+naQZzut7doXzZZkxc5tqpI0I5/Be7e+kCxHlw3UtGbjqc8wY4fydEnsKjGeyvPn6aOktzIlzu+OrqkCooLREEgIJUN1bh3kngCt4jzBelCh6Jcx9KyX+XPA3Y+swq3Omp1BKZw8d/n1AxHoBoH9dSQm8olpYgF9QFEt9cqcxaf0VeHFccdhQ1jCb0l5rKogwxdvVSL5KwHGVJwQpQHz1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f//m4p3MZ0u4qNrxl/5H6i1hjB6d0s7/BUiujaXfJ7s=;
 b=RDcyRgZy1XAc9wocQKNpcB0hA+ZH9RYcAxq5SsAPWNoRtUghAieyIsWSp5gKgHVz4otsEiEjssIwicOTgvlq//+J+gq9/LIQuH44i0w5k1uEBKPgS6P/3Ayl0SRthXHxLbnpsuMfrE9JpyiHtRcvFgLxlvUN+Pbk+lagtTPrmf2n6zPnksop1KAkFEoAm7AHrPTKLeoRS6zxJhumoEnwoF5qHKQ2ZIUDV/bF8wHVg6mNS0ZLHSIa89MOy1G6UnpfgY6AvKM5ZiZEFQA0brGMmEpAQxEw6zoXJn4SIBJCtlX28Ab8ryRcml8BeRYC7DfcF1SETeR7S5CneZbcGIdDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f//m4p3MZ0u4qNrxl/5H6i1hjB6d0s7/BUiujaXfJ7s=;
 b=HcmIIgI06HEEbGh9oHDN+oXOePGZrzur9bSj1SZdUWg4JaWLwK9P+7dGcUu5mI1XzyzD+OrK2aYZueDhrq4sj/Z3nfnxvRLEtSD9WL5KluxVDtHGeTmE2ShXbuhU7LNX8jHYtH14VCNH5MmKwdjNb9yZITYXk2fEMiiLAPGRQb0=
Received: from IA0PR10MB7667.namprd10.prod.outlook.com (2603:10b6:208:48a::13)
 by CY8PR10MB6729.namprd10.prod.outlook.com (2603:10b6:930:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:14:03 +0000
Received: from IA0PR10MB7667.namprd10.prod.outlook.com
 ([fe80::d970:9174:bcc4:9b75]) by IA0PR10MB7667.namprd10.prod.outlook.com
 ([fe80::d970:9174:bcc4:9b75%4]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:14:03 +0000
Message-ID: <919817c7-2684-455b-8f62-14e31d2b5eb1@oracle.com>
Date: Tue, 12 May 2026 14:43:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] nfsd: fix heap overflow in NFSv4.0 LOCK replay
 cache
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, stable@kernel.org,
        Nicholas Carlini <npc@anthropic.com>,
        Chuck Lever <chuck.lever@oracle.com>
References: <2026032010-shredding-stargazer-b481@gregkh>
 <20260320113941.3971332-1-sashal@kernel.org>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20260320113941.3971332-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::6) To IA0PR10MB7667.namprd10.prod.outlook.com
 (2603:10b6:208:48a::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7667:EE_|CY8PR10MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a128bf4-e801-47b7-e674-08deb006cf62
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
 pJKqFsJ44WVPy7H+0A8mRw3RnRqIdZ8hrncXS0CGHDyUc0xMQC7DmUD0Z2EAMg6H9O600CbaDysXMXCWCstu111WE5ju++N4cZuDe9JnasyavDOdm+KOn2Rs5BlLkI1t0iswHLVi+a+isDDI4HsnReE/th/TMpOZhtl4viIOUNdpUYn/tDzRio93OSJPyEzB4cqyPVEVoeNpWJzVtUHBcSaRBiDAjKY1ifK+xJWz/T8WntynQ/BOIS6IFzxN/h2NDOovqjG6pdkVpnrCUo2RQnlGWLvJO6oMEp+MBkLFGxyZC/CmUrQzcSqbpLZ4m5U+Iq1UB6YByeDzUrFo350o1nBinqRwK8yLWtVRLRHW/6hud2vlCxVj/IhrfvuY/Qocn1diNOOht+An9sMS9d2Ruhz6rppDiKFnYx+a9vy781sKf428m61ODF2jDTW3B+0tHgjwnj+eEw3o/zi7eB7f0ErOMV6kgKbotMaEWKHcRj95DNfgpQ8nEXCOQgqvv7c5ui6Ww7O2xEb5oZmuGV6IGbePaSCB24n7CQzKYwuglmMIO36QO5LY/JIHLc/eYOp/Lm4/uWmJPhu8AfXF9xklMsp8BuWHAwFXM2WyLT8lT7uyvLWW+MpHK1CSkS5WYJZbPdv3aPTmaqmCzG0un+nAStnM9Pxl31vpvb5u2iH5KAv8kuEG1WFMkT3xdzoo1NPm
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7667.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cElIUTVaUFkwT3QvU3d4eVZ0b29YNmlvbzhYNSsyd2RxSTZXM0hHc1F5S01j?=
 =?utf-8?B?QytobWc0bXEyaEZCN3hsQjJlUUhDeU82NUo3N2lWRWFKVG13aURDdnZJdWN4?=
 =?utf-8?B?dDVKSjBJODV5SEZNVGw5bFRhanBWb0w2L1F6dGhOcEVBZnZSY1RUajhwanpM?=
 =?utf-8?B?bHQvRnVjZktxcUdCZG40d0ViUkRkSlFQTVltb2VweHFoSVdXaUJ4UVlpL0Rw?=
 =?utf-8?B?MmhGNlB2QzNRRXhpZDNKYnR6cHk0M2t6MkQ2Q1orUDVOMlBnK3hhUHI3Sjc0?=
 =?utf-8?B?QkFpMWtsbThLZzJzc2FsVmZwOXJCVDM1Ky9WVXpRaEZpbWdtakFPS2hhUjRP?=
 =?utf-8?B?eHNCMGpiM3BRb0xLK3NjclJNbGVCd3FWU0daYlNwV2xML0xHb0RoeVY0aDla?=
 =?utf-8?B?OVV0bGRUV00vNFJHVkxHM2YwVml4Q0JOSUNkSGlPNFB3UEtoWmRPRVd1bkoy?=
 =?utf-8?B?R1BYWkVCWlFRWi9hUngzR295NkhKMGNERmgySE02d1p3aWNmQ1JHeTB6L0xj?=
 =?utf-8?B?dEViNEhqTFpUWGlEc0hxYTdFTDJ2dm51eDJ6aTd4T2VOVE5GakN0Sm9IZU53?=
 =?utf-8?B?MGx4VmhtMjBBVnZCU0RLYWxtSXFnVHJzL3Z0OUJKUjUwcEs4QUFvU2hoaVcv?=
 =?utf-8?B?ODl1ME9VeWpPYmE2MnZxQnhOMlp1MXA2aXRWREkzdUVnamgzQ0wzWlBqbWd1?=
 =?utf-8?B?blhKaFZBT2szdUF2NTRyemhyUlNobEJ6M3hES29VV01ZZTFJTEcyV2ZZSTRv?=
 =?utf-8?B?OE11Wm4rVUNNOTlrMmh4ajBuTkpWVzV4R1A3ZFl2K0UybFJlcGlQS2NNMWYx?=
 =?utf-8?B?VVpEQWs0eWMzUWNpajdnOHo2dHpTZzBXS0JCd3U4V242SVJYbVI5MGU3c2xU?=
 =?utf-8?B?aDhPRnRmdERDVGcwbjRVVC82MU84RHBSZktqMHltUkJzK0ZrUVhTY1pGTmNn?=
 =?utf-8?B?bmFjdW00RjNrc3BUcmtmb3d5dkxocU9vMVByMFdpeUdXTHhndU1hSG9JRFd1?=
 =?utf-8?B?RThTL3o2NHk2bUE1MkJCaHBOVVY0d3RaRGt6MXBKRUxZZk9XUENYWWh0bnZB?=
 =?utf-8?B?SGlBbmJXUUJyUVV3SXdmd1F5WTlYWlRRSG5TT29EQVU0M0RIVWg4LzI0ekNq?=
 =?utf-8?B?KzlQWnpYdHVNSSs2SFRoQXdHbVRyRi9MdTQybm94czZaYXhDWWFqTFo5alhy?=
 =?utf-8?B?blg3eFM4SFFwdWlNM21CRXp6ckZaR21qdlhDNGQvVGRoVmdyOXdSQjluTFBR?=
 =?utf-8?B?bWRNVmRpV0dqajRLVVA1bXlvUDRRT2lOcUNCNVltL2tVMFdac3JTYytlZWht?=
 =?utf-8?B?WVhMejlTZlBlNE5HZGtUaEdyRGhwWmpYamNhbE1zdXVEZmQ1a09YL2o0bG1j?=
 =?utf-8?B?a09RSExGVldGVm13WXVSbWI0Sldocm9ma1ZYdWdBTUpjbnZyOWt4Wnp0eStU?=
 =?utf-8?B?VkppSk51dnJUOS9vUHFTbW1MY01GZUdSZGR6MnRsTXdlN09hVDY4N0lxeXNV?=
 =?utf-8?B?Ykk2Uk1UZUw4TVFtR3k1OWlheWJjTk51TUxzTFJpdCtqOW9lR0lEbU12ZkpE?=
 =?utf-8?B?Z2FQdFNFeGI1YVowNFQxSFlTbEpZVWx3dW1iZFMvaVNtTHROb2ltMERMYjFu?=
 =?utf-8?B?aTJWMktGWGNBTEc4bkE0Zzl4V041MWFESkw0UDhJV0VGYk14dmpzcVpUcEdF?=
 =?utf-8?B?S2FOSU5xaUNYZVNjR0Vod09icExTaVMrYUhoV3hXOXk2MTZnWVpiZHYzQ0g5?=
 =?utf-8?B?QWgvNUpzQVljK1g0WFJGZWFWem03L3FPam5YQld3V1NORVJDdFhNZWE3YTR3?=
 =?utf-8?B?WjFWTy9uYTlSZDBoVk12b2g0VlBicVNqNEtzc1RQQ0xwMGF1ZGE0dzBQMEg0?=
 =?utf-8?B?OW1zSFAxWDZvQ3VwaGVRN2JmOWZkZTdPR1FiMlV5eXJRaTA5QzN1dndZN3BM?=
 =?utf-8?B?QUw5RGx2dEU4RlQ1Rkd6ZWU4dVVXSHQ0QmJEcytsS1IvUTNUVnZoZ01sblNI?=
 =?utf-8?B?RE5vbzRORHhIVWdWSk5KUlB2L1lKc1U0VW8vTCtSR2JoRTRwTHNWZlV3T2Fl?=
 =?utf-8?B?Q3VSbU9lQk5JaDhqd3YzYVdNUU9mUGpCaWp3dkdRcElPa04ycThCM3Zwa0tF?=
 =?utf-8?B?eW4vRXU5VDRCMXdsZ3ZncVJ2dWpOajJ2c2M2S2JRNDhPT3RvS0k0Q2ZzVi9W?=
 =?utf-8?B?cVdDcWwrWDNTTHVCU2pSWDV4RU5nLy9ETHVINWN3T1BaaWRRU1J4S2JETVc3?=
 =?utf-8?B?S1hUTTdxYmxWd084VE8yMjMxNGRxT0NOOHZYdnNtRXhpVENJYitxc21aU2Nu?=
 =?utf-8?B?TDdsSXQySThoU2kwazNyR0p2Mi95emhHOGplV1RGcjJNUjNVWjNKMHY1R0R4?=
 =?utf-8?Q?NJ+yM8ZsKmLK2808=3D?=
X-Exchange-RoutingPolicyChecked:
	Y/f7j5+y64L/q4B+Y/7u64nyZNBmGVx78Mb8bC+ZgCmIPFnxfoQIgjlFYxtf71eQAndmnwOZQ4+GV1/I6hU2EtOHBhbodZ5AbQ7J4+NxEVVqwLXH8dSuSqDdp4pCG1Zrp5sAk45nQoG4jHDNjNveXQp7sDwxkQqr/6KKScTyrYWB7gC5mTSvYJEVlQg2ryoTGff2x5bxoDzUqjsYG3qbTGtwhEOP/Yaqnj8EJOPtij+qH9ROCxxUsfyUQekSTDARnHIGP3VDX91wpfx1pv+AOuIwbBrrqGWO+yLo/aXXjwyvkR4L08jYPwXEMXRbROlW/ESB1z3xn623llTV9rjEoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JY41PNW6+mDTQlvfE7sSWVLTkAybuKYaXLcVafaDIGGqH7zILhd6vojsx5QvJIXefn4rNJeLglAAahf9YIKQtNo6agCu5qqTaauW9Ep9+7tqPBywbv4At7/YP/ROGGvkQ3erKmTjr6BigJ9BSnw35TMBCASqBSVtb5cRbHi2FXPvEhUKOas+n9PIvoUNvj2j8xc79MHzwjZzbtp5TMyPEWB6E7pN2jRnXOWMt9pEeBo+Qt6gYYEx7EvpGeo6FYfElyaLwXNxjw5HtldXh7kXfghTGUmKnRUEgZEaea/lo4V89P7dEEKc4J9pkwbNxI/uN/X4a+mmNFbe79yYrMkNZHseUDKcafvo9l7qO3KUtzqq/g8s7BYxhG7Zy/lmOFwYVDXB53kayMwdsvoreRB89gXYJu77wo7B4QlvzblFnkpBqQ9JmUmfQHJFU4wTKrjGGsVatI+pY9mcJOYeW7aFuNhMrFXTusaLZo95+O3JzFo7en9Il8bEPRAQAJIU38V1OY6kcszhH8hPy01z9rnXmk2F1q6gdbPL+QoT3teLD73ODvBTO0lj687GCKP3XAtji0E69ah+8JoinnLSl+hUZnscuPTYNjyd6Pg1O9WAoYE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a128bf4-e801-47b7-e674-08deb006cf62
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7667.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 09:14:03.1100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEHpU0SHCRE+8wb5flyjAQtmlfM4jhFjJjLWafeiYkN36f/2ByDbIotHOSGSiGGk1x9ex7xEgVoi8D4isIBt+hkFMxPPTgt7VOlpgc2YXSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120093
X-Authority-Analysis: v=2.4 cv=Fro1OWrq c=1 sm=1 tr=0 ts=6a02ef61 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=6gl_cCoBAAAA:8 a=yPCof4ZbAAAA:8 a=naT6zBJ1ndDWAmmnnN4A:9 a=QEXdDO2ut3YA:10
 a=Bor9z-CvbNo2M6AZn8_k:22
X-Proofpoint-ORIG-GUID: niezUApJThsjvyORcn389TE72ZTaHXte
X-Proofpoint-GUID: niezUApJThsjvyORcn389TE72ZTaHXte
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA5MyBTYWx0ZWRfX82nZgq/Dp8Z1
 YmkYSAtqOcBHsWMCqgpdlic1j7kF5lcF9MrhqIUKQa88zJ/9LQyhcp6lkgjQUxar08OLacjF0pt
 QDqnImBLbmQY7LJrqfRKXudHVAI6MeymSadXe//fM7OMJSeTTxIjGGuk9Rxs25JrIjFDUIcYegv
 otEhXpDFSQsi89WMJb3teXIE1Jl4jO3tAkDwgj6Q1Jg5x9PRK8MCu31XVgSJm+yd3OmRJFEXN1m
 yCXAmLijDmDUZx6bcPjqTcyscSFGWCQwVlVwXRbLz5caNWAwCKelubhD5Tt3LLzdiVWQ8/IQpJ9
 aTkj64komvkU2FnBz8pZVu7SbvsaJE1hPgR3okpzKGmXzTsANVlHmFhN1+TBMwwr8fvMbI8fr2a
 iw9B2zUpwUxMPA26FyHU7P7HMG5GU2j23pWp9MU52yx/HtKzjraH63xBGfOpAV1PZY0lwG8mhiO
 uPA6WWyF2ocLv9EHqtg==
X-Rspamd-Queue-Id: 91D6E51D8EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245430-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anthropic.com:email,oracle.com:email,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

On 3/20/2026 5:09 PM, Sasha Levin wrote:
> From: Jeff Layton<jlayton@kernel.org>
> 
> [ Upstream commit 5133b61aaf437e5f25b1b396b14242a6bb0508e2 ]
> 
> The NFSv4.0 replay cache uses a fixed 112-byte inline buffer
> (rp_ibuf[NFSD4_REPLAY_ISIZE]) to store encoded operation responses.
> This size was calculated based on OPEN responses and does not account
> for LOCK denied responses, which include the conflicting lock owner as
> a variable-length field up to 1024 bytes (NFS4_OPAQUE_LIMIT).
> 
> When a LOCK operation is denied due to a conflict with an existing lock
> that has a large owner, nfsd4_encode_operation() copies the full encoded
> response into the undersized replay buffer via read_bytes_from_xdr_buf()
> with no bounds check. This results in a slab-out-of-bounds write of up
> to 944 bytes past the end of the buffer, corrupting adjacent heap memory.
> 
> This can be triggered remotely by an unauthenticated attacker with two
> cooperating NFSv4.0 clients: one sets a lock with a large owner string,
> then the other requests a conflicting lock to provoke the denial.
> 
> We could fix this by increasing NFSD4_REPLAY_ISIZE to allow for a full
> opaque, but that would increase the size of every stateowner, when most
> lockowners are not that large.
> 
> Instead, fix this by checking the encoded response length against
> NFSD4_REPLAY_ISIZE before copying into the replay buffer. If the
> response is too large, set rp_buflen to 0 to skip caching the replay
> payload. The status is still cached, and the client already received the
> correct response on the original request.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc:stable@kernel.org
> Reported-by: Nicholas Carlini<npc@anthropic.com>
> Tested-by: Nicholas Carlini<npc@anthropic.com>
> Signed-off-by: Jeff Layton<jlayton@kernel.org>
> Signed-off-by: Chuck Lever<chuck.lever@oracle.com>
> [ replaced `op_status_offset + XDR_UNIT` with existing `post_err_offset` variable ]
> Signed-off-by: Sasha Levin<sashal@kernel.org>


This patch does not appear to be queued in 5.15.y yet, although
it is already present in 5.10.y and 6.1.y.

Could this please also be queued for 5.15.y?
It seems it may have been missed inadvertently.

Thanks,
Alok

