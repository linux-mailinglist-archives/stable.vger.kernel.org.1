Return-Path: <stable+bounces-200451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64468CAF801
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BDCF3011AB4
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D752FC874;
	Tue,  9 Dec 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aeT/cL4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bOhCKzOy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4828726E
	for <stable@vger.kernel.org>; Tue,  9 Dec 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273606; cv=fail; b=QENc9tV/g4CAajY1s82LpF9MM1jW1DWgchQ96it8gIV0wEpAdpiKcoFt9if16rwMII0BAO5/+mwFYtWVTSWg5XXZMFghoY7s3OuOg9KndvsnwsZQ+2cYdkrVdF3kB9OFO1T5yBBQasdSv3guAdI99qKV21F1MjV87/pQdIMDEHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273606; c=relaxed/simple;
	bh=H1Zh+s0hWIs3fnM96tAdp6nqkpcjIleL45Xnt7bgYSA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QrZ1SgsSVYDP4TgdWZHFZZELv35KRwphDkOTz2GfgLS2iw+V0QtGoSUBM/NHi3lkp8ontAcuGOZQUwsHG1jOSNlTtG7qAZVqu4Ml8SFM15jM4TWnzPrU+x3/ealfTp2A8nydgPzX4xpwDLQPfBh1Hc5I6+ymwTDADNTsX31G2I4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aeT/cL4E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bOhCKzOy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B99aUP1449379;
	Tue, 9 Dec 2025 09:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JMgAoSB7biZBChVvpXdt4INH0LDe5ikYbFQYd91jW1M=; b=
	aeT/cL4ENr6LMrGGS3zbiwW5OL4P8Hrt1g2h5zf5yL6mXFBz+Y8hGPvj5jc9L8nY
	NTSCsIOocJ1tyZOeTrKXwVTg1HzlBMxDsp+o3JnF7JlVsCnl0b8xT6EMhRMTACMU
	3DiCBw1ZKiSP6dG1hLThmp+YBMTFa4iUUx9H0ToZlb6QLIZxclv7g62CWSKf9eB7
	0e7G04SsjBeyAwpMzTEttPewrFinmaHhPAhIMZLEGuK7PxXae7t73oqBkvJ6Wh2l
	n+B2plr7nlCa9hbkiulUOFn6iMEhUI1AVTzke8wEuXDC72eKBnOVKeNbseIWqlMk
	sLcs/M1+/lhYYVc58o8pdQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4axh9h80cb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Dec 2025 09:46:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B97qjJL040721;
	Tue, 9 Dec 2025 09:46:35 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxjnhnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Dec 2025 09:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpSTyae386bW8+5vwHHPyEYrJ9g0tGQxGFv5wEuG1daf+eRTMGdbsIfSUyEvwW1m+2JzDXR/HCAL5EP+Ef/oR1HulHJEkxVpoLWRcfhO6UqDkDHKUuel+tJuYtNCGF1WlSPQJa/y36MStQlhZPDlpVN8/7xNzQAfg+UZBALF5dZ4u0IkOMg3rnP3SDoiL94J4vC7PeT+yVs4TLb0KmkJ/oUHmGkb76EJxq8Rq1PO38Qy49ymkrh9ORuN3dJ3hJQUjrUIKiS8rOrcuUP3mwDdl5D9qykNLrDAodgC7cu38ji5gZjHau6GDtapR2+KWjLVDT4A5eNIe7eKUgf+nNo3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMgAoSB7biZBChVvpXdt4INH0LDe5ikYbFQYd91jW1M=;
 b=wSosHMZ69MJMBooBTBDctZ77dToY0r6we9O6dMvXKIle9lYmfUso+vzSk9IO+ZxaOlwlegXLqLdpsf68uA2njltGuJ2ujnkkNvbf9P+YygHceqy3FGCd6lf7B6a8dAICN5s6eCAr/sQdJAdcdqB7oQFyhpsxy5JmmqlqBWKoFYL4w0zYjn9qmiGR/udai9N6VBfitXhSmypX5M8QiqsL53SazA3Tiq6EggKQ+8VoMDL+hfsI2j9xqeNjQfD6Lzg/Irzs5/dl/4nTExH0IqWAhLPCTtY6reGqHL+QTKVkeaUgXwR6oeYpmyLiddmLHIhazBHMkdjEKGu+XIU2nNQjNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMgAoSB7biZBChVvpXdt4INH0LDe5ikYbFQYd91jW1M=;
 b=bOhCKzOyN5CkLUG6cem7imG8/3+ODjN7sIfegOchEVe7/rAvIK+sQQgM+FK+3//ycFqWa6inBZdJDUmcp038J501psPjxMF8UUuz1Ij5iNLEXZVxOUoIr4rxVm9UeLOG/WSNJru0kfIT5MBaL2+H0kAb9x+nTxCx4h68PmGrz3k=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by IA1PR10MB6218.namprd10.prod.outlook.com (2603:10b6:208:3a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 09:46:31 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 09:46:31 +0000
Message-ID: <bfb82a48-ebe3-4dc0-97e2-7cbf9d1e84ed@oracle.com>
Date: Tue, 9 Dec 2025 15:16:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.61 lts] [amdgpu]: regression: broken multi-monitor USB4
 dock on Ryzen 7840U
To: =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>,
        amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
        regressions@lists.linux.dev, bugs@lists.linux.dev
References: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
 <ea735f1a-04c3-42dc-9e4c-4dc26659834f@oracle.com>
 <b1b8fc3b-6e80-403b-a1a0-726cc935fd2e@student.kit.edu>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <b1b8fc3b-6e80-403b-a1a0-726cc935fd2e@student.kit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::18) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|IA1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: d5871eb9-4bff-4be4-7b00-08de3707d4f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXB0RDZWVHFseVp1eSt3R2dhOTBHQlRNa0xVZ24raFYxNm9rT3hzUTRHdG94?=
 =?utf-8?B?aVZEWXpSaHlJMkFMYWNDbFdCZjJtMjZscE5rWlZBNzd0ck1yWDVkYXF4NEdC?=
 =?utf-8?B?V25XTVNjbUtaaXFJZHZSZ1JGdnhHdWV5SU1VWDBBNitjNVJDVjBDQWdhWVRl?=
 =?utf-8?B?bWxZUlZ3cVgreHVzMmpUQjlhK1ErOHQrZ2ZFZWZPUnZld1ZhYUZ6NURRS2dQ?=
 =?utf-8?B?NUJBc1BpRGlROXJrV1FFcVMybkdQK0JOWVVuOEJWSThERGtWa21MMjNjZzBy?=
 =?utf-8?B?WTl3MUwzSUJSZk5maGFmRGg5dlMvaXo3dndEQkp6Z2RUZUdsQkN0Wmk4RkxX?=
 =?utf-8?B?Z1ljUGJvREUwR3MrYzhVNVFMMmxtUVRIbFd0dlNOSkNLVTRNVDduVEFSMzBv?=
 =?utf-8?B?bzFZSFk4UkUrNVdKcVhoeis2elRaZEJ0R2lJU0JVMFRVSlY4R0JOeDRyNi8y?=
 =?utf-8?B?VGEzaExjUWJSeU1VVklIc0FPbFZLQXg2M202WFV3QXFzbWtaandPZHdML0Vn?=
 =?utf-8?B?VWdiZFU0NDJ2OXhuMlUyOGFYUGRjWlZsSm41ZEUyOUpVYXlrZk80UTB6SzM0?=
 =?utf-8?B?MERVU2xpeUovS2h4Rk1vYXpER0xqNk9rdVhGMVVaeE4zb0JKRXY5ckkvS1dT?=
 =?utf-8?B?RG5XWnk0TW5QTGlSZlcxbTZHVlcwK3gwSUFlSWt3ZHBFZnREZjdxbVRLVWY1?=
 =?utf-8?B?bE1Ha0Q2L2V2UEpxcnYwc21UcUhNbnhjWnNzSWdCN0o4RnhMcmhoNzQ2NUlE?=
 =?utf-8?B?ODh5c0FVV0JNalZ6S0k5b2FuNGJ0a1o0N1BsWlBjeEx3ZWQyc3hwL0NWdVR1?=
 =?utf-8?B?akNlbTI4L3dselhSeHlxSVpHdjFpQ1NUdDVRRmxQTDA0SnV5YzNqc2cvN3Vl?=
 =?utf-8?B?UHlSYzBzSWc1M1diUkRpN3pBR25YSExMajVMWGd5dVhKZmNwemVZVkhOdEto?=
 =?utf-8?B?Q3UwVHhZUU9ZUTBXM0svd3N6RUU1bWo3MGd1cHp3NFpUcWFPM0NVYXA3TGM3?=
 =?utf-8?B?d1RnSFptY1BkK0ZqVjd4ckx3U0lEcTBUZElCOTRidXEzbXNnSW9EMGJuampV?=
 =?utf-8?B?YTRzWlBadWFGamo5UzhjMDF6VDVtR0t6a0tZUHBaazdrSmJTeFJlby9oakpi?=
 =?utf-8?B?S0pvRXBHeG5KTmtteWh1VS9IVzdFNTJIQW1WcDFOZm9RV3VBeTRyZnVNTkli?=
 =?utf-8?B?MHVGbUYvZjdjcjlRWU5tdXFUTE81ZnF5WlVQK3JKN2hPOVhxRFBQWkhuT1Zi?=
 =?utf-8?B?Q3Bsa2E5UkNxeUNZMmJQT2pFU2lEeDhKbWpKYmJSNW1kMUp2MXhhSzEzQjVI?=
 =?utf-8?B?U2tudy8wV2tjNU55cUtyNWpUL1Y5SjlidWRMcGpaVzdSOU8wMVV4WFNZSWkr?=
 =?utf-8?B?QlBDYVE2d2hleG15WThHRHoyUjRJOWtKQU1HTFRIMVkySXlKR082bTBGV085?=
 =?utf-8?B?ZXZqd0ZCZmQ3YlUzYTZvR1h3TG9ZbFhnKzhkb21yYldOY21Mb1Q1aWE2Qm41?=
 =?utf-8?B?ZVkvc0hpUVo3MExVUDZCVkthcERVbTJQNTFwaUtXMG8vRGJicWV5eFljc2RB?=
 =?utf-8?B?YkRtbzMxSmpHUE56L3VUNHBHMUY2YUZLS3FPUnFHOVlFSVE2RzVsdk5KaWJQ?=
 =?utf-8?B?QTNiSzJGeUo5WGZyN1FCeHY1aE0xSnJhMmxlUmNWQnE0N1Y0YW10ZUxHbWVm?=
 =?utf-8?B?QlMweXoyc2JhQ1BLQnhqaXZJWU93ZktpZkh2WXBucGVhaU9JNEQxRnZpMFZs?=
 =?utf-8?B?RVJmZTlaeDhINGFRQXRybG9PNGRMS1Flelg1cXlhYzFLUlIrT01vOC9BT1FQ?=
 =?utf-8?B?b1NDS3MwM1Y2Q0lTSlNSdytkWitnUWlqZ1U1QVNsb2NKMUY0dkdNQkJubEJR?=
 =?utf-8?B?TGRyaWFwV25URVdkN0tWWjUvMlVqNzNOZzlNNysyZmZIRmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmJ5VUZ2YWhwTytVSEcvWDk5emdJL0V0b3M5N083WG9qRkpVT1dHS1VlSlNu?=
 =?utf-8?B?Nk9jTVNCNHFIU3FZSjN6VC9mYlVxM1N2RHc3RlFYbkdxdHUra29pVUYyT1pI?=
 =?utf-8?B?NVQ0NHQ3ZWhxNDFqNVg1VUlHaWlxZlBjajZiaUp0UlpTZE01ZHp2MUtMakhQ?=
 =?utf-8?B?a0FvVGpqWG1ONXFiczFLVWtFRzBUMjNmeTRRWWsvcGQzQmR0cnJ6NjFZaDhS?=
 =?utf-8?B?bmhObjJjSmxRckdmazNkTVlwbkhrVm1sbWFYVy9BTzdhSEcvc1hOZDUycDNy?=
 =?utf-8?B?SVBkeTNOQTlZYmJlQWVLc3dkOGdieXJiRkdSL1ovaW5oZWNBQkRwMUhjSlVk?=
 =?utf-8?B?blFWWjR4cUNnZlh6S0VIM1djaU0xSWRWclhIVGh5cytuaHRLMDZJaHhBSWg2?=
 =?utf-8?B?TVJ0d3ZYUnJzSmRFZ1lpNVFXQi9Uck1MM2g5Q20yRDJpd0RNdG1iZVVGQU1q?=
 =?utf-8?B?d1VJNkUwc2VNdTNVYy91RTR5VXplU3gwUVVXVHpjQkQ4VUpTd3MxNWxRRGdI?=
 =?utf-8?B?cE5LZVpKMkpDME1kVS91MjZFaHRZUG5NbXhBVW13U20vQ25jb2hzeXE0UWVv?=
 =?utf-8?B?Vm5BeTFqcGdldkRPTGdmbXMwSCtGbEVBMGk4UnlRYnExN0lqVGI1eVpEYVlr?=
 =?utf-8?B?Uko0QURTVHV5ZWVyM2xnb2YzU2pRamRCeW9jeDA5WldYMTJVM2N1dlpPQzc3?=
 =?utf-8?B?U1JSTkxKZEhDUjRIdEQ2R05WbDh5d0c5MVYrR0ZVRXU1Z0dOMlNJVHNWaUlF?=
 =?utf-8?B?cXBVRXQ4dkRaRFFJdy9qMEhSUWF0RUVNaXp6M3VJcFNwQjFrTkFsWm00ckpj?=
 =?utf-8?B?cGRsUTNtb0JGR29UN2VpQmtYV25ZbFBmRDJHcXpxN2pQaEJyTzcvU2hLYWlk?=
 =?utf-8?B?VHBMdWgydC8vRThyVk4rNXZEVmhzbnkwQUpxdzRsSzdGdHdOZW1ZN0swcmJV?=
 =?utf-8?B?QmdmVjNLcVVQeUV6VE1acWx2Zk9nK0ZtZmc4d1kxQ2wvWm9LSmYzRW5ZV1BC?=
 =?utf-8?B?dTJtRnEvZ3hmSUZ5Tkp1M1hDYUM2N2NWSjIxM1AxRVMzOHVyVmd2RkVHaVcz?=
 =?utf-8?B?Tk95VGQ1YUlPTEdRK0lUdUs3K1pUS3RuV25PQ005ajR3NFhjNjhveXRhMW5J?=
 =?utf-8?B?M29UdzBnRFdjTFZyNCtSR3FHZnhQdEFZNU12NTExc3N0ZFhNQ0RlRnB0Y1NM?=
 =?utf-8?B?YjZXM2p4cFBDempRdHJiZnE5T3JDNDJTM2JzZms5TDV0Q3BabHUvV1B0d2Mz?=
 =?utf-8?B?UlFFbWEyWlZlNE1JTHJmY0xnbUdnbytFN2UxSkljMUUveWppTTBJZ3R6SlR4?=
 =?utf-8?B?cDRwSnRGMFUzY3gramlnbStxMHN3dDFmdHJSczRLRERaVlBSanZFTjZuYjNn?=
 =?utf-8?B?cWN1ZlpqOUYwcHBMZ3ZSOUVhRlEzcm8zcW5aU0JZenMvVU9tWSthWmdnYmw5?=
 =?utf-8?B?dzMwV01JdzZsYVRQTklzZmtQMWlPTHMrdmNtZFhCZm91YlZ3d0t1eUNmVFlM?=
 =?utf-8?B?K2VBK29vczhhenJxSlNvODdCcnFKZTFKNGZVeUt6aStia3djd1hWMXVGRTE3?=
 =?utf-8?B?TVpIT002N2E5WkRKZUN1KytjSHoycTZHajhlRWFuSCtodlF1Qloyb3ozRDU1?=
 =?utf-8?B?SmsxSTlkVGhPUHVIbWNHYXNpTnIxLzBUcUozSnhHamc5RW80bUd0TkdKNkRN?=
 =?utf-8?B?V3Y4SFhabTQ3TGRPbFNtUFJjNVFFQUlxZG5QSk92QmhaS0lYUWU2Yjdxcy9U?=
 =?utf-8?B?dXVpb2xTa2NiYTBucmg3dWFPeWRyUXVTQ1FVeEYrR2tPekZNK2V4dGlMK3d6?=
 =?utf-8?B?MXM4UmtnRGoyMFY0M3Blc05qbXhIU29DN0FaOS9WQjZBY0s1cjVBMUFyaTY0?=
 =?utf-8?B?YVdaWmQ2VlRlNUxPU1h5V2lZaDE0ZlZBalpvVUtpSzd0VVhlVDVDZGlKbVBT?=
 =?utf-8?B?ZzRTT0E0WVVKNDUwK3FVS1kxZHNHZGdVWlgyNUNZOFF6bGVuUlR5ZFMrdkth?=
 =?utf-8?B?cEhwT2xnMEkzT2hvOCtMendzMUJSUVZsVlQ5RjZMQlBXT0lLN1VHeVVkUVN3?=
 =?utf-8?B?SjhkcWQvZElwZFZOaWNFekdydFRBTHl2Y2dEMy9jK1NTWGxxanJrZ1VXNk1q?=
 =?utf-8?B?dVBsZnQvSFJPUUZOdXNaTGh0eDJiZmNUZ3QwVGNmNEdFbkxvVVFBcUpZTVpX?=
 =?utf-8?Q?eztOcdWAwXZfyG8FaWAZFQs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4uG+jdLmFZGX3nsMSwDraBHC8EUa3Otzw6oAE47iQRLVihi8GH0lxvre0l3bd5hBGWOZgk96JO3r4A/WkgclYsD84fnR+7bDepoQ/pVAnkzmKogVY99Gnl7dnbETH+wsxzFnB4JiuYXo2+QcCJFp2mXLeoOnPLBNZZzj+0SM4LXnfDEcxbEBHZVxMZB/lbSoMqCoIY1jxdXr0Xqy40D1d0fmy/PlDwhJSw22p4F225f6aUQBbRCxv+Q4HqoVvvQ23Nb0qbuQGBCt7/XCQ/fis+LTbLok0RMP0y97vkQ2fcHcsvify3cMxCt/r1xdSbQ1Astg2HZ5TGq14CzOfn1lnGWVqpHn0KiVqhVBxgKDwkIcBX3k9plZKdeRBnVOh2fxFgXbKDiM6SwCHCHM8l9V/kManS6uzn+7IgeXJkOAcfoUxNJXbPZ82MaHGhyE3F8+NU97nKG2qAon52Nro6+4gmjoN5gwicbCEkJChE2sG1FuuBTVA2YWsP9/nexjcmL/RfeUUdky2BQIbaIes9pJ5tXSOI5MHln0Mzo8qmIgwO1yugX4OKlPzGwUd7k2J6jR9D0D+xhSOaK+E4/KHVLbPMxdmR2wrA+HPTFO0cYzfCE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5871eb9-4bff-4be4-7b00-08de3707d4f1
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 09:46:31.2084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBTOOLh8nkOdgmHWp5bhKG7wbD6+lEc8fonekKNzA53QQoMQP+YBX8oS0uyxsxPWTe6fKz3bD9AveSpBQF+CxEKgcAWW10eqcjSSku16px+tvEpcb1MKcVjSlP8UBqRE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512090068
X-Authority-Analysis: v=2.4 cv=c4amgB9l c=1 sm=1 tr=0 ts=6937effc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=ag1SF4gXAAAA:8 a=fYlXGyh9f4NhT4mdIL4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Y44HFFKAhTwA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=ntf awl=host:13642
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA2OSBTYWx0ZWRfX3r1zgOW7oYyL
 OBuRLuta8hEeihHr9D+kx1u6m/Z+YgpztdzA+EoyC1akQ9Tc0e/PIZDmKk6NxCNkZzDGHSpkOlU
 VKk+LrPU0MysAT2eTMM5NPeeW/emd3bQGGGhCyrrT2Mp0YFmBsKarOHFic8Xd/ybEzolD5EddPv
 tAfJFBh0TGIx7LkBEgM2dP6RSLVbypdg03Qn1Cvq9bEZGiSJlARGitefXI2+6FqHdT87RZTfpHC
 BpQzr0AaQp8uPyYaos7SQxU2Xrs3akmxbLvJmLqp6JbZtG5pvTaOykbxUc86fWGYYqXJGEUOYit
 fE1hNEVIFc+yICvhIfyrhPDDAPPyR1F9xSEwWN04dTuK4G1rx3fs6c1svJLaIDl0A7HJP6BU6gs
 GX62YZfWoyHmuqjXfcE7+FkL8fy7dE+uph10aLNi2XZ8gsvRCLM=
X-Proofpoint-ORIG-GUID: 54lFcdT2rPiEidVUQTpPosSoWnZLfCzU
X-Proofpoint-GUID: 54lFcdT2rPiEidVUQTpPosSoWnZLfCzU

Hi Peter,

On 09/12/25 15:00, Péter Bohner wrote:
> Hi Harshit,
> 
> sorry for the late reply (and replying privately at first),
> I had to wait for the release.
> 

Np!

> Unexpectedly, this is NOT fixed, persisting in 6.12.61, same trace.
>

Sorry I guessed it based on the fixes that went into 6.12.61. Sorry 
about the incorrect guess.

I don't know if this is a known issue then. Couple of thing I would try is:

1. Is this reproducible on MAINLINE 6.18 ?
2. Can you bisect the cause between 6.12.59 and 6.12.60 ? (using git 
bisect) - Documentation: https://docs.kernel.org/admin-guide/bug-bisect.html

thanks,
Harshit

> regards,
> ~Peter
> 
> On 05/12/2025 19:10, Harshit Mogalapalli wrote:
>> Hi,
>>
>> On 05/12/25 20:52, Péter Bohner wrote:
>>> upgrading from 6.12.59 to 6.12.60 broke my USB4 (Dynabook Thunderbolt 
>>> 4 Dock)'s video output with my Framework 13 (AMD Ryzen 7840U / Radeom 
>>> 780M igpu) .
>>> With two monitors plugged in, only one of them works, the other 
>>> (always the one on the 'video 2' output) remains blank (but receives 
>>> signal).
>>>
>>> relevant dmesg [note: tainted by ZFS]
>>> (full output at: https://gist.github.com/x- 
>>> zvf/128d45d028230438b8777c40759fa997):
>>>
>>
>> Just a note:
>>
>> This looks related to whats fixed in 6.12.61:
>>
>> https://lore.kernel.org/ 
>> stable/20251203152345.111596485@linuxfoundation.org/
>>
>> Try with 6.12.61 maybe ?
>>
>> Thanks,
>> Harshit
>>
>>>
>>> [drm:amdgpu_dm_process_dmub_aux_transfer_sync [amdgpu]] *ERROR* 
>>> wait_for_completion_timeout timeout!
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 15 PID: 3064 at drivers/gpu/drm/amd/amdgpu/../display/ 
>>> dc/ link/hwss/link_hwss_dpia.c:49 
>>> update_dpia_stream_allocation_table+0xf2/0x100 [amdgpu]
>>> Modules linked in: hid_logitech_hidpp hid_logitech_dj snd_seq_midi 
>>> snd_seq_midi_event uvcvideo videobuf2_vmalloc uvc videobuf2_memops 
>>> snd_usb_audio videobuf2_v4l2 videobuf2_common snd_usbmidi_lib snd_ump 
>>> videodev snd_rawmidi mc cdc_ether usbnet mii uas usb_storage ccm 
>>> snd_seq_dummy rfcomm snd_hrtimer snd_seq snd_seq_device tun 
>>> ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_multiport 
>>> xt_cgroup xt_mark xt_owner xt_tcpudp ip6table_raw iptable_raw 
>>> ip6table_mangle iptable_mangle ip6table_nat iptable_nat nf_nat 
>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c crc32c_generic 
>>> ip6table_filter ip6_tables iptable_filter uhid cmac algif_hash 
>>> algif_skcipher af_alg bnep vfat fat amd_atl intel_rapl_msr 
>>> intel_rapl_common snd_sof_amd_acp70 snd_sof_amd_acp63 
>>> snd_soc_acpi_amd_match snd_sof_amd_vangogh snd_sof_amd_rembrandt 
>>> snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp 
>>> snd_sof mt7921e snd_sof_utils mt7921_common snd_pci_ps mt792x_lib 
>>> snd_hda_codec_realtek snd_amd_sdw_acpi soundwire_amd kvm_amd
>>>   mt76_connac_lib snd_hda_codec_generic soundwire_generic_allocation 
>>> snd_hda_scodec_component snd_hda_codec_hdmi mousedev mt76 
>>> soundwire_bus snd_hda_intel kvm snd_soc_core snd_intel_dspcfg 
>>> irqbypass snd_intel_sdw_acpi mac80211 snd_compress ac97_bus 
>>> crct10dif_pclmul hid_sensor_als snd_pcm_dmaengine snd_hda_codec 
>>> crc32_pclmul hid_sensor_trigger crc32c_intel snd_rpl_pci_acp6x 
>>> industrialio_triggered_buffer snd_acp_pci polyval_clmulni kfifo_buf 
>>> snd_hda_core snd_acp_legacy_common polyval_generic libarc4 
>>> hid_sensor_iio_common industrialio ghash_clmulni_intel leds_cros_ec 
>>> cros_ec_sysfs cros_ec_hwmon cros_kbd_led_backlight 
>>> cros_charge_control led_class_multicolor gpio_cros_ec cros_ec_chardev 
>>> cros_ec_debugfs sha512_ssse3 snd_hwdep snd_pci_acp6x hid_multitouch 
>>> joydev spd5118 hid_sensor_hub cros_ec_dev sha256_ssse3 snd_pcm btusb 
>>> cfg80211 sha1_ssse3 btrtl aesni_intel snd_pci_acp5x btintel snd_timer 
>>> snd_rn_pci_acp3x sp5100_tco gf128mul ucsi_acpi crypto_simd btbcm 
>>> snd_acp_config snd amd_pmf typec_ucsi cryptd snd_soc_acpi
>>>   i2c_piix4 btmtk bluetooth rapl wmi_bmof pcspkr typec k10temp 
>>> thunderbolt amdtee soundcore ccp snd_pci_acp3x i2c_smbus rfkill roles 
>>> cros_ec_lpcs i2c_hid_acpi amd_sfh cros_ec platform_profile i2c_hid 
>>> tee amd_pmc mac_hid i2c_dev crypto_user dm_mod loop nfnetlink 
>>> bpf_preload ip_tables x_tables hid_generic usbhid amdgpu zfs(POE) 
>>> crc16 amdxcp spl(OE) i2c_algo_bit drm_ttm_helper ttm serio_raw 
>>> drm_exec atkbd gpu_sched libps2 vivaldi_fmap drm_suballoc_helper nvme 
>>> drm_buddy i8042 drm_display_helper nvme_core video serio cec 
>>> nvme_auth wmi
>>> CPU: 15 UID: 1000 PID: 3064 Comm: kwin_wayland Tainted: P  OE 
>>> 6.12.60-1- lts #1 9b11292f14ae477e878a6bb6a5b5efc27ccf021d
>>> Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>>> Hardware name: Framework Laptop 13 (AMD Ryzen 7040Series)/FRANMDCP07, 
>>> BIOS 03.16 07/25/2025
>>> RIP: 0010:update_dpia_stream_allocation_table+0xf2/0x100 [amdgpu]
>>> Code: d0 0f 1f 00 48 8b 44 24 08 65 48 2b 04 25 28 00 00 00 75 1a 48 
>>> 83 c4 10 5b 5d 41 5c 41 5d e9 10 ec e3 d9 31 db e9 6f ff ff ff <0f> 
>>> 0b eb 8a e8 05 09 c3 d9 0f 1f 44 00 00 90 90 90 90 90 90 90 90
>>> RSP: 0018:ffffd26fe3473248 EFLAGS: 00010282
>>> RAX: 00000000ffffffff RBX: 0000000000000025 RCX: 0000000000001140
>>> RDX: 00000000ffffffff RSI: ffffd26fe34731f0 RDI: ffff8bb78c7bb608
>>> RBP: ffff8bb7982c3b88 R08: 00000000ffffffff R09: 0000000000001100
>>> R10: ffffd27000ef9900 R11: ffff8bb78c7bb400 R12: ffff8bb7982ed600
>>> R13: ffff8bb7982c3800 R14: ffff8bb984e402a8 R15: ffff8bb7982c38c8
>>> FS:  000073883c086b80(0000) GS:ffff8bc51e180000(0000) 
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 00002020005ba004 CR3: 000000014396e000 CR4: 0000000000f50ef0
>>> PKRU: 55555554
>>> Call Trace:
>>>   <TASK>
>>>   ? link_set_dpms_on+0x7a5/0xc70 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   link_set_dpms_on+0x806/0xc70 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   dce110_apply_single_controller_ctx_to_hw+0x300/0x480 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   dce110_apply_ctx_to_hw+0x24c/0x2e0 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   ? dcn10_setup_stereo+0x160/0x170 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   dc_commit_state_no_check+0x63d/0xeb0 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   dc_commit_streams+0x296/0x490 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? schedule_timeout+0x133/0x170
>>>   amdgpu_dm_atomic_commit_tail+0x6a1/0x3a10 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? psi_task_switch+0x113/0x2a0
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? schedule+0x27/0xf0
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? schedule_timeout+0x133/0x170
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? dma_fence_default_wait+0x8b/0x230
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? wait_for_completion_timeout+0x12e/0x180
>>>   commit_tail+0xae/0x140
>>>   drm_atomic_helper_commit+0x13c/0x180
>>>   drm_atomic_commit+0xa6/0xe0
>>>   ? __pfx___drm_printfn_info+0x10/0x10
>>>   drm_mode_atomic_ioctl+0xa60/0xcd0
>>>   ? sock_poll+0x51/0x110
>>>   ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
>>>   drm_ioctl_kernel+0xad/0x100
>>>   drm_ioctl+0x286/0x500
>>>   ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
>>>   amdgpu_drm_ioctl+0x4a/0x80 [amdgpu 
>>> d75f7e51e39957084964278ab74da83065554c01]
>>>   __x64_sys_ioctl+0x91/0xd0
>>>   do_syscall_64+0x7b/0x190
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? __x64_sys_ppoll+0xf8/0x180
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? syscall_exit_to_user_mode+0x37/0x1c0
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? do_syscall_64+0x87/0x190
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? do_syscall_64+0x87/0x190
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? do_syscall_64+0x87/0x190
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? do_syscall_64+0x87/0x190
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? do_syscall_64+0x87/0x190
>>>   ? srso_alias_return_thunk+0x5/0xfbef5
>>>   ? irqentry_exit_to_user_mode+0x2c/0x1b0
>>>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> RIP: 0033:0x738842d9b70d
>>> Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 
>>> 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> 
>>> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
>>> RSP: 002b:00007ffe3c7ed230 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>> RAX: ffffffffffffffda RBX: 0000634abd49c210 RCX: 0000738842d9b70d
>>> RDX: 00007ffe3c7ed320 RSI: 00000000c03864bc RDI: 0000000000000013
>>> RBP: 00007ffe3c7ed280 R08: 0000634abc4049bc R09: 0000634abce43e80
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe3c7ed320
>>> R13: 00000000c03864bc R14: 0000000000000013 R15: 0000634abc404840
>>>   </TASK>
>>> ---[ end trace 0000000000000000 ]---
>>>
>>>
>>> regards,
>>> ~ Peter
>>>
>>>
>>>
>>>
>>


