Return-Path: <stable+bounces-209935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B33A3D2799F
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6091930D3D23
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C802868B0;
	Thu, 15 Jan 2026 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dh+9WMVl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QdYvF4zM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E761EF09B;
	Thu, 15 Jan 2026 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501169; cv=fail; b=bJEQDzAQY4H/z6dgLfny69WU5F73IM0AYh5WRtuZwqYhKeIHHYgtbLooFa7rFKPIvRInevz+++LpMLsGO73LpgC9Lt6mwf/OgXDJTUeZHzgMbURwBoSQG7s0HRrxURE6jYkc6AfY5mFpxzX8YvJ/ZTtD46i3rHlV3GodD5shTek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501169; c=relaxed/simple;
	bh=sAc6nrp2Krft0Yz9BGx8pNUewIDd8KRK+wni/gvA4I4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neOgwkpxfmoTADNXvHfjGVR2s3kzYUSlrssvz2re+mpywlAz8wXJxVE4xMZ6pPsycVZHzBmUFQowPZifCuSE5Vvbdnz6E2Cj+89EZ5wIVDj6D/EgttPkqg6nYej0dds+1U427wTeusWtFyto3UowzpFP4EupWLTit1ENT0tsXZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dh+9WMVl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QdYvF4zM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FDbUNA1940280;
	Thu, 15 Jan 2026 18:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4I658GVqVGijdfXqpBuwyJV3eb5kWGgJndL45PvSAnU=; b=
	dh+9WMVlhTmLdLzs+3EUkuwSVPjRF/JIsbjBsfghoeH2QD7BamqzyujtwFLl3nP9
	xRqwISLHHIVeeMSoIkiHZG5nQY3wZVmryoULmur2XGRUC3dXMg/xsOR72Hh5LVo0
	uX/f0XVhtqhtSspyxqkNAmHRSPXAtjFfaMiR21Rt3hgLxctN0KJOkL/hCgXXN66J
	J76eG63T0a3Bu0/3EjtZPD5aqTOWFguL65W+m1ivn7VRmFye87Wq8vZhLI0XRYwY
	EFC3aDx2I0XV8z9AB0h+Ov3FBKdR1LCmG4yzOJOW57GDGb0ceWwA9vDBCYh3sb7Y
	tfJxHVWHbsIZlzzxdGa5Jw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5p3brts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 18:17:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FHTDB2040477;
	Thu, 15 Jan 2026 18:17:47 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010004.outbound.protection.outlook.com [40.93.198.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7fdw23-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 18:17:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgJpTKKMLR4OXIWWnkpFuq+HTFVjIv3oCGSde/xkz8PBSBIQAzVcZPrn2TBU/WH/BJ3sWC8ZfM+nJuxxMvCy1+VW96Fu7lX5/56/V7LcpGMFHxe/kULTPbBsX6Jb6VluTvWTsRV/jauy/Tc6QbKtt9QHEkw6+fBzn89+Aisedc4f3OBFU8ZlGhv9G+bh/hrKuozd7eQTY+YQ9lCv9WCgRQlwih7GqYdG96/jg2g08I1TtqhCTaOjYvNegLZTWY89Lem8SjcddNviGaA7LApjYvUrfwf7Hue88gjjpG29+KjV/l8o+PkUhmrcXABiiHGKTZ5hpDxoqYKr3s0FCsvrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I658GVqVGijdfXqpBuwyJV3eb5kWGgJndL45PvSAnU=;
 b=pKijXnnY+zLeKWIRS/q1YSjDd1IWc6XDElgUcr4kvsi911xX+BHdkuteXsr3/i91gb1M0sNY+cyo40nPuJ1RS0X0TDAw0rI+w3ITXaOG04nd6cPR53BlbQyZZLq7LClhxT/6seoEcQIHPFiU13epkmpDKlxPe0JaRPcYVkpFIGIjZ8wQhWwdXYC88l5tMU2j7ewr4V7QoTHy2aAR+7qUAQ/mY8LknrRRa6ImwB2aRTIYxz2sx/9+MDXkddkHStULmN2H6hPtvj7cWWG/pUgQVmPZoyHDPABSvKKIWJaCrIA4jy+XeqG87JUALWCmnoaSXzuFubU314xg7sLBbQu8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I658GVqVGijdfXqpBuwyJV3eb5kWGgJndL45PvSAnU=;
 b=QdYvF4zM2Fo3yorvNCEqwnQVOeHWyLs2BMhLi/b4bZGjdR+KF1WErnvNQNreElXbxHrSg4PkvOA554PzhI1hB/gotz6LTYvwNZhG8c05L8NYTUAOTNih25JP3LZmExP2nUT6LWi+t5RpSyvEQPUifYRezQfIdzQH7r8/oC2QEgg=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 DS0PR10MB6149.namprd10.prod.outlook.com (2603:10b6:8:c7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.4; Thu, 15 Jan 2026 18:17:43 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 18:17:43 +0000
Message-ID: <cd880ec7-b433-4534-ac1e-4c5af4bea462@oracle.com>
Date: Thu, 15 Jan 2026 10:17:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mm/memory-failure: teach kill_accessing_process to
 accept hugetlb tail page pfn
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: linux-mm@kvack.org, stable@vger.kernel.org, muchun.song@linux.dev,
        osalvador@suse.de, david@kernel.org, jiaqiyan@google.com,
        william.roche@oracle.com, rientjes@google.com,
        akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
        Liam.Howlett@Oracle.com, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, willy@infradead.org, clm@meta.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20260114213721.2295844-1-jane.chu@oracle.com>
 <20260114213721.2295844-2-jane.chu@oracle.com>
 <d925a432-2773-3a02-6bf6-99a2e5e83727@huawei.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <d925a432-2773-3a02-6bf6-99a2e5e83727@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P223CA0017.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::10) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|DS0PR10MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ab965a-6a28-4ac8-3f73-08de54626044
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SFRVZS91OVBCS2dON1FTV2c3VTVQVHZjR1RFK21NRlFXdzhLYzRPZ3h6NHc4?=
 =?utf-8?B?VmhITW41blJmcXlYRXZzVTk2cTFhWW8zd2I3UTJIWGNBZWNzRUVId0k1Rm1n?=
 =?utf-8?B?aktQazR3OE1PZVloMHpzM29mS1VFaER1YThOVFVRSGtESndRb2lXbXhPckRD?=
 =?utf-8?B?RThscFRtTFFaRkMzd2s4dm9kRkhhNEtIUlZ6TzQ5b01DUWpvVG1SUTlZLytZ?=
 =?utf-8?B?SWJ3eEJLcy9PUDRzWXgxS04rU3FNTjlRY0ZVV1BsbWhGNDZjTWw1VXpzdDVw?=
 =?utf-8?B?eWRmN3UySlhIaGM3b0k2cTlkNnFZNFdaZmdQVS90QnE3b29OYnNDbno0dDdz?=
 =?utf-8?B?Z0xuT0w5U2Y0VmZQcDRUL2NPRUo3N2d0K2ZPTFJPWEtTcmFmaWNHbTRyZWxJ?=
 =?utf-8?B?Sm1rQi9YK1lxbFpVUS9OQW1yYUYwSkd6L211d00zdENRR2lHY2Q1cGJTVnVF?=
 =?utf-8?B?NDZON3prQktMZFo1VE5DSzRPNmgxbE5iUWM0RFFBcW9YajVtdVo5VG1ZR211?=
 =?utf-8?B?R3R3NllSK3gxM3BHQTYyNFdkV0puRVdMWnZXeFpkL0FrRTNidEc5Lzg5bDFE?=
 =?utf-8?B?dFE4MjEzTVJzaklKTWVxV01zNkM5Q3BGTVlkR2wvbDJJaWFtWFpHV3pJcjgr?=
 =?utf-8?B?NmttM0pqZW85YzBCclo3QWRGT0cvcitLL09Mb2IrbHQ4aEoyaHR0ZnF4YWtU?=
 =?utf-8?B?akNZMG5iTmk5OXUwNy9Gd3VIUzRLdlRWTGRpVDZpd0RPNDM3M082VTFCcTlo?=
 =?utf-8?B?N1RkSHRsT21uTlRvMTdwMUtUaExnM3RtMzE0bUFFM1R1d3BMK1dKQlEwdzRK?=
 =?utf-8?B?Q1h3a3dpZ1Jpek5JTitKY0s2T0dneVB1WUtMN05UZGxGSEpybldBeVYzcGRv?=
 =?utf-8?B?VnNhcXpGNThjN01UdWN3NDB0ZHRPMXlWbUx5M0t2aHdKYVFYVHozV2h5TTFy?=
 =?utf-8?B?VCtyQ3Y2c3htMUdnQmhnVjRPUmtWbEVqRGJzVmZsMWNnc3BORnVNV2J0VkdW?=
 =?utf-8?B?VWFZenFFakZRNjJhNG8yekY4d09nOHI4RG5RelViaWtoUHN3NjFMOFR2dVBW?=
 =?utf-8?B?TG4vWGlVWkp2eHd3YzlPQkp6MXRPamxhZVN5SGEzQkxDUjYrWXdHL243UEd0?=
 =?utf-8?B?MWZiY1FVdHBYOExjUS9qM3VFS0VwNkcxMXJndEtUVmJlMkNDa3lVaVZCbmdu?=
 =?utf-8?B?NnZzUFlTbzdZa2ZCZGVrWVFGZWdoa0dXa05DM2crN3RUT0xoTjB0MUpNYTVH?=
 =?utf-8?B?MXREbEhZcW0xdVNwNEdNbFFFSlVGY0traVF3Z21vTHRrNTdIQ05VcmlkTSt5?=
 =?utf-8?B?RUtlRVJUTEIvNkJ6aUduaW5GaGFYUXp3NUJtc3d0WVEzUng5K1dGVVVTRlVX?=
 =?utf-8?B?dGdEbjZ1dzNQVXBmaFQxbnFnQ3E1SUYrOExMQ0hhb3QyQUQwcVVybStja0hR?=
 =?utf-8?B?WEFNd1NzNFdGYi94ZUxRQzFubmZlYTVDenRuTGlha2ppZlI4SnU0eXJuMVNM?=
 =?utf-8?B?Smwxb2hVb3ZZcDJWWkg5b1pRNGg1Ui9sSEpKQnBteGZRNEtVblFXK0FDTVlw?=
 =?utf-8?B?dWJwbzlLWXlVYktFNmRDQzllWGVwQmxiMlV1MlkrUkg5MVYvWDJsbG00a293?=
 =?utf-8?B?NWV4RzFHU3RUK1ZadlJIR3JNQnFEYlU1bnRjbTE3dzFJSTdtcjJ6MWQxbkcv?=
 =?utf-8?B?WkpSVVdDd3kxOTNYRXJpT3lPOFpNSko5ZmdSYWRJWWZ4WWtTU2JoZEVydUlD?=
 =?utf-8?B?LzRFbjFlZitoRGp1Zk9jWENBSTJkaVRoVDcvdFh4eFR1N0Z0b1FtbEV0b2h2?=
 =?utf-8?B?eW1qeitMdzVkOXowSGNJbEIvKzJMS3N2cWFqMDE3WkdsRndLK2tidWxKbkhk?=
 =?utf-8?B?cmVXK3ZEMXJiQ2Rzd2ZXTzlhZEpGaUNxRUxqenduOUQ4NzlPSVc3N2NWQUlz?=
 =?utf-8?B?bkF1elZtRTJUZG1ENytjc2g0Q2QwbFRnWlpPUkZLZ2RaNkw5eDBEeFd3T1JI?=
 =?utf-8?B?enJid1BZTHpVSW05ZUcwUHpPYXhqcjNDNHNRZkJXMXZRbTl3T2I5ZTEzdjQy?=
 =?utf-8?B?cmZBYkVJbFZSVW4zOTBUY1U0RXdSSTV0NEpjVHo3UElIblovZGxXeTdzODF4?=
 =?utf-8?Q?yPzxq3jgUN3pinmy7z3uiIIYx?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Q0VyVG1oWWZOL2o5dXBiM3YwUlVWak50UElKcXJmYU1DT3MvNW03cmtPTUd1?=
 =?utf-8?B?dEhHTWJ5UmswMzA1bmhSa0ZzaFR6S045V0pLUkx6WEU1L3g3cDNBMFZmdlVj?=
 =?utf-8?B?QTJUdzlUZzBZaG1XeGozeDJ6UDFvZm5vSTJnQ1dJRG9zQ0pKSHR4dXBmQS9t?=
 =?utf-8?B?VWNydkNoelJqZ25mRjZEZ2wwaUI2czNrRGxLYTZJeXorMUJBV0hRK1d0VDZO?=
 =?utf-8?B?Qmp3NzdnYVhYSm1yaGIxMWhrTEhJRWxNTzR5ZWE1TmlwOW12b3R4UGJKc2JS?=
 =?utf-8?B?QUs0MlhNK3VOWXcvNjhENkpaUGNRYWRzTVZSQmpvU2RXQ1JKZStyYmJmWlBJ?=
 =?utf-8?B?N3VvazdEU1U4V3c3bERDOERZYjJxTzZyd0hKRCtYTDc0Q0RjdkthRkRzVGVz?=
 =?utf-8?B?NTUyRFk5RGJQbXdTZDRvY0trNmdWclRETDZzU3p3V1NoL2ZHQVV6NWR1NHdL?=
 =?utf-8?B?RlpyM2pYa3FYdkp5SUtaTFJFN1g0MEQvWG8wQ0l1ZHlJOUliTS9OTmxIazR2?=
 =?utf-8?B?MmFKVEpJRzZEekJTUzAzQVpoSHcwVC93bTdwUVVzS3dEY3hSTDBlWlBJcVow?=
 =?utf-8?B?RW9aM3FOWFhadjkrMW5WVHBnTDkzWHBqMmJHNWl6Qk45T3JOeTdoNUlVK2tu?=
 =?utf-8?B?TDVJOVF5SzRDRnM4UUZXcURzbFRVS3hTRXZVYzFFK3JLREZwdnEzdXpFVXZr?=
 =?utf-8?B?Q29YVW1NSjFnQ0pNR2JJNmJMR1ErM3NwQW9DNmMxeUFBSXE2dmtYUnpjL281?=
 =?utf-8?B?QjBqZzdCb1U3RW5hMlFORWEzaGRhbFlJRm9wOElDV1V6V1NVU1l3SnAyWWRS?=
 =?utf-8?B?TWQrMGdjbFhKV2VvTndMOFpocUd6QVF6YTF3UkdyQ3pLQmNreThsTEhPVkFq?=
 =?utf-8?B?VkJSRDQ2WEJQbFpLTDBDaEM3TEFTY0hZbjVwL3NqbnVJV2QzSTNNaGhmWlMz?=
 =?utf-8?B?eDBuT1hGZERXMlF1dmxzT3Y4b3l5K3hVL2p2TU43bEpIb3dkQlY5aHBoNmpY?=
 =?utf-8?B?L0p0Z3B1bzdDY2lOV2JNa0xzblJXNUpRbHZEaGM5RWdjaTNiRk9CbDNRK3Z0?=
 =?utf-8?B?UzlmV3J2bkV5SDhmSWFvUEt4RHJSNlJwcXFPSlN1bjJ6ZmhSQ1plRGxlVmpF?=
 =?utf-8?B?NUtDMk1UUDQ1QkxuaGt1dktWSklDUmpDTkRTSHpGekxZa3BBRzVWQVRranli?=
 =?utf-8?B?TE5hRm9QbjNnbVNmeDNLSEhhbkFTamdUL1QrNHRub1pmT3EzUmwyRVYvcU8v?=
 =?utf-8?B?QlhkUGFUanNmTEd0eGJaeWNFVzZKSS85c1N5dmJpQVJHTzVjZVdZdTJKVG5U?=
 =?utf-8?B?UTNkanpiUEZkTE5Ea2FSdFA4QTZ6MVliTS9HbTlWN0dJRGJ4VmJ5MG12UmND?=
 =?utf-8?B?V0xtVEo1bTlma1dZbG1TM1lROUtJN09BYzI4aWJqaVpwcHRJdTJFdUIreFhT?=
 =?utf-8?B?aVBBNS9odmhkSkNrY1NRL0xjREtrc3BOY1g5Mm83RDhaLzFGRnlYQVNwem9U?=
 =?utf-8?B?ajVGZXNmQUxiSkMrQ2lWR0hPUFdkbGVJazdCWUs5eDFDL2tPNmJ4cW1CYnNR?=
 =?utf-8?B?ZDBGcldRa05Kbm1ldEhpd3BWejU4czZYbjBmUk1kTVlIOG1MOGcrVUFSaHhU?=
 =?utf-8?B?NjcxRlFYWXVyaEZCOUR4dW5GMm1nSVBJYmpDQUZNVmxFT1RodGppa1VDVWo5?=
 =?utf-8?B?c2RnZ0lLOWkwUnFjN1JjNmFQbm9vZXJoYnpNQ09wR0pkc1NDMDdlZkJUK0Jo?=
 =?utf-8?B?MVJMZG1GSHdwSlQvZ0VaUk51bWQxK0pyM1A5VGtKYVVoRnhVL0xMeFlXNW9O?=
 =?utf-8?B?ZXZZODF4cGxOeU9GaGgyOUQwenozOTIrVkd1MEJid3Fra2pOUTQyWmVhZDFi?=
 =?utf-8?B?SGFyUjJSbHd2S0JoZzZBVnROTzhNNEdOUGw0MUFqMkdVNmJDbDcwYXZ6eDhx?=
 =?utf-8?B?T1ZzQjN2WW9BaVh5RnVVc0RXTUxtSG02N1ZBTlp1YXRuaGQxVDNmMmZsdGND?=
 =?utf-8?B?TWtNazh4dnc4U0RVS1lpSHl2SlFCWE1yMEk0VlQ1SGtnZ3J2UDdsZnNHK3Bk?=
 =?utf-8?B?VXVGVzV6bTR2ZDRQeVI5U3BPa2YxcDVMYUpNY1hidXdVM2Ywc1o0MDdjNnVv?=
 =?utf-8?B?dUJCTllIS29mUVNrcWhvcGhQOHBoZ0NFd3Fpb1Y2L1VQbjluTlAyZUI2SFd6?=
 =?utf-8?B?SDdZc3hpaDBVYkVoMjZkM1hJSGFTTVNNOUtHcEllSC9CVFRYWUk0OXZ5N2Vl?=
 =?utf-8?B?VDdSUXNCckVLVmxuakg3SkhETDBuV040RldLa0ZIT0hOWTdjeVVBWU9TUnBk?=
 =?utf-8?B?OVJmSHFobHJCNkNMcENIV1FDZitTamZjQVFLbTBWZ3kzSkNZOEZXQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rrhOSXGJpkK0SW936407/81quqBqR1TnOg/gRIqaVHRXq/qRwUB5cnhOrH+dOU27Q37qdRLlUtrISn4ZqtN7zVUzkKjRA0TY4rc3JCXJF9fEiMSdiIxwWT1PxArawVosDuQtTOXAExgg/nbehEEcbOiKpeljaGmDHSZLLmuinYroKvC9UXCrr3fWGSCVrOBdiMyxBfJRQtWKqEzhj3BKoDnEmypX2D7hJlycI/T6kmTXUkj582CzcyeL2S2j+CoeO89TYyXE2Gaqrpc+4N++uDTfMkiov6wW4azXLDa0IdtokkkUMUdh+N3ncJuH5o4Z1KpUMQ/Oh2hQiwe+dLZDVAjWVkHeQzqY/PnqWC8vti2TZ324iAMN8xURHg5RVWXKRTpDi5cVQ/5kOdses/w6VOEEPThLgS+xhw68MzOrT0s3IIcQfp9/lXiin2hiBjdpwVcuQxN75crZvHmkQ0Zj4bAzJj6Dr5O24KSH/2qIkZ4flslXL218VbzUAyaqxNG3qPDUNxMpNVg9LjsGLiVGQPk9iz3vxMvLluHCtXOgZ8+R9IS1xsCJykzFpQFA8/7HnrxZAydfjEmpOLvcR66UJuNc5CtjQkmmZvYhjbi9XD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ab965a-6a28-4ac8-3f73-08de54626044
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:17:43.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0yP8tvelvR+GcTidi+2Gj/zklIuM65C99G29PcW2494ohLpBWuB03Z/JHE56fNJzzTOCAt2qkZIh3JBZr48aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601150140
X-Authority-Analysis: v=2.4 cv=OJUqHCaB c=1 sm=1 tr=0 ts=69692f4c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
 a=i0EeH86SAAAA:8 a=5Zckf8guCu-V8f7WwOkA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: 26mo57bWZ3dBI726lAnEgy4HQ0nHnaoG
X-Proofpoint-GUID: 26mo57bWZ3dBI726lAnEgy4HQ0nHnaoG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE0MSBTYWx0ZWRfX+RxkaSAHTQEr
 T2W6w5XCApZmgg45fCKoaDnouWxeKoLSIXkYOYS2JSJzneun+CQ6jj6cUn59L5r/UxkZQD8jDsT
 PlMOWEqnLv4pcM2scvALdz+0rNFT2lawYT1BAsDAJC/2U/qSoZEMNgXoD07rn+JMWnMUt3Wi6LF
 MDcbqSPMPazzLxfw8ad0zf4P15HU2y0m+e4OE6BjdZHn5G8ZzcixB5TEadgTEkgGqGPEN1l2rXF
 KqaIbGC08iVopuAVzTyUXbaQ6d7OE9AWwCTCMUbec6unCmd3UF1zf6pCH65WaWVH+2rsWvxrR9T
 evHeNSGeVdmpOZWqrfEKTWdvWcW5+68KmEjuc2NlcZQM0NvjdkVU/1FMBPUU5pJiOsm0xFgpB7t
 uZCVaP4Hv3Ru6tbZE/5kE5GArbTOc2j2FCQy7G722c/HHhRg5D51PmBa5eVaM/8JF4JqyWZq3wA
 HDUxL8sj17jvxZtMv022Dp+9jWpS9YrXlBRDi63c=



On 1/14/2026 11:36 PM, Miaohe Lin wrote:
> On 2026/1/15 5:37, Jane Chu wrote:
>> When a hugetlb folio is being poisoned again, try_memory_failure_hugetlb()
>> passed head pfn to kill_accessing_process(), that is not right.
>> The precise pfn of the poisoned page should be used in order to
>> determine the precise vaddr as the SIGBUS payload.
>>
>> This issue has already been taken care of in the normal path, that is,
>> hwpoison_user_mappings(), see [1][2].  Further more, for [3] to work
>> correctly in the hugetlb repoisoning case, it's essential to inform
>> VM the precise poisoned page, not the head page.
>>
>> [1] https://lkml.kernel.org/r/20231218135837.3310403-1-willy@infradead.org
>> [2] https://lkml.kernel.org/r/20250224211445.2663312-1-jane.chu@oracle.com
>> [3] https://lore.kernel.org/lkml/20251116013223.1557158-1-jiaqiyan@google.com/
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> ---
>> v5, v4: No change.
>> v2 -> v3:
>>    incorporated suggestions from Miaohe and Matthew.
>> v1 -> v2:
>>    pickup R-B, add stable to cc list.
>> ---
>>   mm/memory-failure.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 2563718c34c6..f6b806499caa 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -692,6 +692,8 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>>   				unsigned long poisoned_pfn, struct to_kill *tk)
>>   {
>>   	unsigned long pfn = 0;
>> +	unsigned long hwpoison_vaddr;
>> +	unsigned long mask;
>>   
>>   	if (pte_present(pte)) {
>>   		pfn = pte_pfn(pte);
>> @@ -702,10 +704,12 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
>>   			pfn = softleaf_to_pfn(entry);
>>   	}
>>   
>> -	if (!pfn || pfn != poisoned_pfn)
>> +	mask = ~((1UL << (shift - PAGE_SHIFT)) - 1);
>> +	if (!pfn || ((pfn & mask) != (poisoned_pfn & mask)))
>>   		return 0;
> 
> Nit: Maybe "(!pfn || pfn != (poisoned_pfn & mask))" is enough?

That's nicer.

> 
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks!
-jane

> 
> Thanks.
> .
> 


