Return-Path: <stable+bounces-69670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7356957D2E
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 08:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06EB51C23E7D
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236A13D279;
	Tue, 20 Aug 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cJvcJr6B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sz0Tw1cF"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75DA14B09F
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133491; cv=fail; b=L+FOALIvUiTARB1xwJbJBgF96fvbwBDw64tLntmJpJyWNZu081s7+udwxEoQvkbZJ6uAAW93/zwzns+1q5Sg763nR/4FqmnEu/JcMIsw4RBvDZLsT0kiTcLButQ1oDen8URp1cZKgL/lRxcp5sdfAeEKFnXDj8A1zPXmGHgDvIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133491; c=relaxed/simple;
	bh=ghsY55Dkw11UvAJQ/FcHQzK3B144bXFUDYf7IsdZwRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rFKh0O41btj4/sErHAkM8PJj+9el6xQhqt565U16JkBhsyCshba5DIdq65rSSDk+Tc2XuemFDK8hbVAbb/cKbLm1dFfb8YwZCNbWrd4LybBydtvkRzXmqvE+p5/48iAiRv5p6HT5afbi5DI439io+cewbpDZ/aPkYZtn7+e6qBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cJvcJr6B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sz0Tw1cF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JLKHrW022332;
	Tue, 20 Aug 2024 05:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=I80pdhTnDfBeWfRaRLQFjEUxh1qVe2CCiS/Oc2yOFQs=; b=
	cJvcJr6BHvct+7gQ8+kLzPL0aov5pxyqjuOatL/U31PftxtsxppDT/ApnPyGWbbv
	hrYjgNY4oOxBF0jQRLbyNMexlfiZ/FIqKzKIQMeydna4rKv78H0QELI17h1SLc94
	UoTwSAx8/QzUnMRQxYLDXL6ucTsO+8QbXIknQXnnpuPb2QN2nfTh2AkQOcbDjwuA
	jvCF8l4tYsaxNEMPLNob6wOyMUg8OWHsdm0f4GBDLppUqLhtL91C6tVp3fY29s+Y
	CFK2dLytSIVE5/2AKv57UzlKzohBd1KtXl+HP8+pruSzOI/UtE0SKoX1sh6EG14z
	0EZm1xLKkUBWgAIoqHG2Rw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m3dm8u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 05:57:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47K5O6A8009307;
	Tue, 20 Aug 2024 05:57:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 414my9h25a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 05:57:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJW5iivP5edCSxkc+4VbqxYhc66YadGTlZ+tlZHnQUPp5klegXeSw9w0q6qX7oBGg8J7CEAZN+bd/8b50Naj8fiLr+FABbEK5t/p2S5Gn6XG/OvRQitsD2AJu0c7tXAn+wO8c+m2ZjvDd3RTX+NC2WaKge58n6Jhvj/IOiT5fLJwsDCRAhy3J7wYYVwzC2W1+v23aLDPsrlbBcy8piiXBjP/uXjiRfNzIObC7Y24J7wVmvxMA4lngW3DuFzRSK/11wAhVYzQ5rSFiQUQ/CfumWJlGb+WA3u+AEcR3eZpZojsEHcw0yKare9P+5hkwH4VrRajma2umxSoPTMxA3bKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I80pdhTnDfBeWfRaRLQFjEUxh1qVe2CCiS/Oc2yOFQs=;
 b=BP08Z3JPNtkhHixOp3vpFhAwSrF8sZ9rwN8fCgt9KxO8gahgHYN4Y5U5jEe3sIhK55aApeh+Gqhxt5NI/MLHGZKSs5N9QtTVIYrQxtWCDh6PTOy0syopltLfX5LjEIGwed89Gz0qBjRgv4jOb78RkRikxr7IqGLT+favgTDrPMleh7J1Nc46POBHB8zmyIzzhwBD7lmHMHZyIZG+CCXkcaPfIRfpNuorixvXtUpJYX9QBbalkECM85eRK8nCaTLaowy3+R9sf3vFOTrPDklhEzSobrSMWb6WQDShP17WNOBv7B4zuS6z/d7Z8n3KQmfpsJTd40TlOnLLu4riztG05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I80pdhTnDfBeWfRaRLQFjEUxh1qVe2CCiS/Oc2yOFQs=;
 b=sz0Tw1cFekJfzokh80WfXB9mBp3AZqJPgxvpCXyQ1cvSf+Nffe/d4bFuL0BO6bJkcdMVChMZD/jLenn6cmKxb0MCWgIwqF+XD9XSOIvSmEDZyYAMbJcnW8mPzacEPQ0Z1FzXOGf56C5sY6fFeLtumpVXUzJrXRi2sVF4eqRBWgE=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 05:57:53 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%5]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 05:57:53 +0000
Message-ID: <d631a304-a532-40ce-927c-ad7939bd9477@oracle.com>
Date: Tue, 20 Aug 2024 11:27:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y 5.15.y 5.10.y 5.4.y 4.19.y] Bluetooth: hci_ldisc:
 check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: liam.merwick@oracle.com, vegard.nossum@oracle.com,
        dan.carpenter@linaro.org, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Yu Hao <yhao016@ucr.edu>, Weiteng Chen <wchen130@ucr.edu>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
References: <20240802151133.2952070-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240802151133.2952070-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DS7PR10MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a77c8c4-e4e7-4c15-5ff7-08dcc0dd0789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlMvc2hQc2szZTZ5ZEhDR2R4eGpsTHdBYmZOeXhmOHRibWRHMUVZQXZWZHBG?=
 =?utf-8?B?OGFmUFVpdEFuSC93ZHhXODBOSlVSZ3MyU0RtVXRSTzBwYTllZzVpR0dNWDBi?=
 =?utf-8?B?YlphblZ3TkVUMi9XUWdUMjNOZGczelBZUWdUekl5Sjl5Z1k5R0JpOWFtNGgy?=
 =?utf-8?B?Z0FMbWl1SU43WEpvdzhnc0lEcEppeDdkQndka1JJVnM1d2owQlIrVTlITDcy?=
 =?utf-8?B?RGtoRUo0eVBYUDVadE5yWE5HbXRaWlIrYTVBNi91MUY0OHErQ2RLcFRWRFZj?=
 =?utf-8?B?a1ZDODFvQ1c3S01BQzY3MHFuQ0R2RytnTkE1RVVHV2tsd29OZWlSbm8wOTV2?=
 =?utf-8?B?c2toRi96UytDVWgrL2dBVklvQ01uejI4c1NBQml2Sm0wZitHakptTjQ4YTJN?=
 =?utf-8?B?bjhMTTR3OTJuOXdCWHlxMzlpekgyTENQdHpWZVh5aExNTEtLY3hoeGpsNlJn?=
 =?utf-8?B?c2NjWDNVblM0QkdOaVFaRkc2WUlNcGp2Mkp4VVpWYkNvNEsrSTlkOTVWMmZJ?=
 =?utf-8?B?ZXpSV25ZVEp6WEZjV3NudmNSZUJvRTgrbFBvUm92aXVBSjRjcUtObEw0QjIx?=
 =?utf-8?B?czZ1amFxbm5TSFJrK0NDNHFLQ1orbkEzcE1XeVNBdjdzUWl5MjhZN1lDZWdm?=
 =?utf-8?B?MndjQnBpeklNSVBGM2lHS05sYloyYzc0T2FER3dFVVY3UE9VUXp1ZzBwMElH?=
 =?utf-8?B?M0xoNE9UdDEwcW9ldG44Nk1xazhINFBPVnNBVnNXbyt5b3psWW9PVGx1WFov?=
 =?utf-8?B?RTlrSFd4WnJERU9BT3hxNXpFTVp3UUp2M253Y2IwS09kQThTU2x4b0FEMWNK?=
 =?utf-8?B?MkJuRWJrdVBPOEtxVkRHd0h5VVE4dWFCUXdvemtBRlFBK21HSTR3NDBXcG1z?=
 =?utf-8?B?bVFoZzZIOHdnTVd0bUIyOERaWHMzY3BhLzk5WU5ucmozSXo2MG9vc01EYVZI?=
 =?utf-8?B?c2MrWElNbTgvMGF3ck9HdnJKVE83cThQTWdzc2djdFppcklrTjRiWlZzNDdx?=
 =?utf-8?B?UU5vOGZRSy9tK2piUWJpay9Ybmh1V3JZSVY5Sk14Y3J0bGRCejBvcFNtN3dS?=
 =?utf-8?B?dGxGbExlZEhDWC9oTzhkbFpENHRXWjFhYTlYTm5SSVMyN2xGZklVRzQwSS9w?=
 =?utf-8?B?NDNkRTJ5WXB3bTFBK25PTXFRVi8xdmVkZCs2c2tlS28xZVBHTWFaNXdVRVE3?=
 =?utf-8?B?YW9qcnlWVHVzUVRSNFMyVkUxdjRkQ294U1h1dWFsbEsyL2g1YWhSMStmcDc3?=
 =?utf-8?B?SVlkQnVkTmhIbDliU1RJeHNVa2lvaTFNcXg4ZjFibytlVUVGNlZOZktiK0FO?=
 =?utf-8?B?OHo4RG1qZWRjTC9nMU1PbnpQeHJVOVZHOCtTUFBjYTJQUXJPZ0c4eUh6TmRr?=
 =?utf-8?B?L2RJUWtyRE5NT2J0WERySWRTY21rQ2s2NllrdU9xR0ZFSlA0dnhGZ3pSaVNY?=
 =?utf-8?B?WWJRazV3WER4a0dVV2tGajJPUUtOVmp4aVpqUTcvU1IxNXVVNVhPaU5aamoz?=
 =?utf-8?B?d3AxV0RJWVBDVVhJbU9hcmRVaWhIdHltWTczaEhqRncvVUM4SjM4K29yOHNw?=
 =?utf-8?B?QVBycVl2RlpQUWFCVkJLQXNNVzlUTkpvQ1NVTHRoVEREdmoralRuZmpRekhQ?=
 =?utf-8?B?bm5Gd1ducUxJcnFENEVLSTdJSWN1aHZJRi8zaGMvUDUxZXVBSHBPRFMyc0hH?=
 =?utf-8?B?ZjVsLy9Sb0t3NExLT2pFOEpWNEJnTVVvNUQwTFJVWU9SakVuRG11ekxubDNB?=
 =?utf-8?Q?vV1VC1p9GzELTg/SjfYUF5u9lQ+VoFFein2fc4W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTlBUThHR3B2TStjUy9hamJnK2tOOU5zREROYkc4dUNQK1QzYytoTDRkWGtK?=
 =?utf-8?B?RCtQTmZ5bVNtZWZZalF0TEU1T1dYRHBTMXpSU3V5L2dLbzhXdm0ya1BSSTV6?=
 =?utf-8?B?MW95YWlQY1ltdElMdXd4K0VkcFhnMDNTd1BncGZhNW1OSG4zN1BCbHZlUzJN?=
 =?utf-8?B?YUpRSVdxcWYwSlM5dzBSWmx5T2JjL0NuY0Z1NEsyazhCdFVHR0tSem1Cd2V0?=
 =?utf-8?B?NzBYamZiNlNvaGV4UTZVdXJVTEhEZ0hEMTJ6OG4wYVI3SEtlRE40d25abU1x?=
 =?utf-8?B?eXAxQk0zSDdQaUFsWUF0VnpzeXFBcjRrZUpvTWplTStDQkdETzhvZ2FpQmcr?=
 =?utf-8?B?SDJITDZicm5TbFVwa29kbmhkYUVHbit6OHlmVDRBK2pUdFpPb0pPa2FiaXp2?=
 =?utf-8?B?TXZtT0RCM3FqaXNXaHFDZUExaGxxV043YVgwLys1eDJZK2xZcXVnakoxQkZ4?=
 =?utf-8?B?cm1vTnJEU0hrbGdocThSSEp2WnJ6VFVJMktDOERrczVKWGNmYTU3bFJBQ2xm?=
 =?utf-8?B?TWxlUkhDVjd2TVNBcmMwUjV2MDQza3dpYnJ3OFU4bFFXandrcDNVODNEWEFM?=
 =?utf-8?B?QS94QlUxT3cveWJ2cHNXYTNnUjh2TDZzYTNReDNoTThrMzJaQllPaVJxc0Jh?=
 =?utf-8?B?bytSODJMcjZQQSttcUIycks0T2oxVGJPc281a25IUXUyZk01eXZHT3c3czBV?=
 =?utf-8?B?QmxwazhSb3dGUVRZc0tSYTNSR0tBeTNsQy9qaGRBRWhJMFJ0Sjl5S0RKODdK?=
 =?utf-8?B?UzFVOWJlbzluWHdrVGduWFJ0T2lOVzZOOTl1MWYxWWd6U0ZkRkpBSWI3MGl5?=
 =?utf-8?B?MEZ5ckQxVmFrMjZ2cTBuR1NDZjZNR01UalJWTTlIdjhFUW1seWVOK0IzMjhp?=
 =?utf-8?B?NHU4VjBhelJpN0FLQll2QS92TmthK1JSMHBDOHlrOUZQM1BnaHNnWFdseXZ3?=
 =?utf-8?B?TTBrQW1tMnNEWjROYUtPdFMvYkR3SzRZOGlGTmpEYnkyMzU4aEpiMFpzMkhx?=
 =?utf-8?B?MGlyMUNlKytFU0dtc1lmN0ZKTml5aHdSM0RBcFZ1YXJUYjFXQ21tS2FlSnZi?=
 =?utf-8?B?Q1doMW5qUVJkMmMyc1FUcDJwSGhrVXZFMTAyeWJGOEE3QWtSWWsvLzhaY0NO?=
 =?utf-8?B?akJ2bzdWL0kvOTcyR2FSdGZhL1NJd0pvZnpaaS9tcllwTUJJZkRjTnN6ckxp?=
 =?utf-8?B?VzBSbmNTbmtid2NyUmxnekN4VGVXMkZnNVVNUjRSb2ZvMHBtTzhtQ2Z2c2pD?=
 =?utf-8?B?cXNPeTJKUnE5dGFISG1KNW1UcXRwL2FQdGZKcXBSTGczQ0k4ME1IWDQzMHNv?=
 =?utf-8?B?bDFyUkg4ZjNlMjc4YU1ucDdkZDZ3TFBNTDFzeFhLTmFqUDY4anF2VGlrWUtV?=
 =?utf-8?B?VTZHTW12NWtuVDBDdFAwODI4c3lIS3dvWFAzMGJFYmJRNkhQeHBGU1Z4NU5z?=
 =?utf-8?B?SkF1bktMcVVoZzRvK3JlNnpDWGpzS1JuVE9SVWlxV3hQcmVkdXVKSWtPdmxQ?=
 =?utf-8?B?aU41T25LdktBNXJiNG45SU5raWpkMW5yUUd6YmhmZGR1RzFpVlYyYVFEVjAy?=
 =?utf-8?B?c0VUaXdLWTR4dVl2K2FncjlNbG5CdmNFZzlqSnBLWEcvb3NnR0dZQy9VUXJv?=
 =?utf-8?B?bjJMc2N2QWJvNjBhUFpUMjdJWlpSS0xyeWdURS9STmFybXNQTXRsblNFVnl3?=
 =?utf-8?B?eC9ma2lJM1ZLY3dlM2J0RFFLRmRBRHkzMHA4N2szMUpYMXlNK2FjdDZmVHZG?=
 =?utf-8?B?SXRxUkdpL01wVTJTRGdtT1V1SEM0REw4ZFNwdDZKbTB5ZmYvbFNmSXJxT3Rq?=
 =?utf-8?B?WEkrb29qa1JlWXRFU0UrZTFDWDR1aU5NMmR3L1lscVIxL2pGQjNpWWlDWEo5?=
 =?utf-8?B?K0hmM0N2N0UvZ0pSSnNTTlFZc1F5Z0ZpaXlpOTBYMi9FbFQ0TUJQTzVpR3R6?=
 =?utf-8?B?cFBXUHZnK0NoVlRCYnQ2L2NjeDBJWUk5NjJXUXRldzlQbnpXYm5ORmNRSFpP?=
 =?utf-8?B?aXNBdzM1V3pwaVdHZFhiWEtKdFFLN2YvVTkzY2xiUmdwTUVVZzhLbFcxODl1?=
 =?utf-8?B?azNrYTlIK0t0L1lid0tiUlRBajhzR29VN1hxRm9GQnJEeDQxalhQQXoydFhV?=
 =?utf-8?B?S0daWmdSZ3hCMkU4aFI4Mk11MGVoTjBuRlgvb29NNTZJS3JMaEdFQUhZKzN6?=
 =?utf-8?Q?y8Tt6WllEKEOUDXndJli3oA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VjTuBGrQuNz14Ne39XwjxZx6Gpj8PbHP/US4pAjkBi3qQDchrhcGMc4RSMWjFH09b9spuBojiUBaAIkmLCTASut/DY8UY9Aeh3DRBEwsZvIFXQKEdouylKZkqMtjm3R54ffdtyXdbCftQKMndIQJMeemtUyrqRENLsCGe8XYc0C8t6B/9ZeyDzMcqqFxxCd3eKGsxc3YsI7wlcgNAz2Ct6rMf3w66eLkt+yYQbjTFdPN+rUBgdFGmxkWj6tAFcnaEH44qbyCk09qqPJj4gmT6blU6NbhQB1t8Dqh85Wb/J4uRdZapZcgdLgA9+u+MPqlKXwSP0kqoctjvnii9fsEnTbT3Yu3/2dCQH5eI0FzpuOnFmZD92rCnyPCT9STc3gAhPgEN9ZjkWjCkldJO9CFDP+206BsOvQR34PVW2zHjYkRayugZXPqULpttFKOOHmv6zGgSXHrK5nXcC7H2AlHWkB/UiLu1mIxJ892K88DWzpGJL2sfkqCxSGrv9yszr9gryNsEvE0tvVoG46wa8pPjW5iGIKu3FUCDIgHGCRpiz1kxYnR8OfIe0jbrF6iBUrlUr/qvZB0i4pmossMXm4guvvQZrjcw70493nn4Bu1nDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a77c8c4-e4e7-4c15-5ff7-08dcc0dd0789
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 05:57:52.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lnwOU+7RovVgai43UNEjC6PH4qkxudB/vF3c+Ns/7tj0G9rtiGMFPIbJEwNMJq4zvJ34OyuvHzdFYD/9k/Lpm/1WRh8SwWX/lnzeRN0ponZoBKI0d7qcBUd1WuBSpI7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200043
X-Proofpoint-ORIG-GUID: deCNTk_g2EZUB63yrzp1LsEJfuxr99XM
X-Proofpoint-GUID: deCNTk_g2EZUB63yrzp1LsEJfuxr99XM

Hi,

Ping for this backport.

Thanks,
Harshit

On 02/08/24 20:41, Harshit Mogalapalli wrote:
> From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
> 
> commit 9c33663af9ad115f90c076a1828129a3fbadea98 upstream.
> 
> This patch adds code to check HCI_UART_PROTO_READY flag before
> accessing hci_uart->proto. It fixes the race condition in
> hci_uart_tty_ioctl() between HCIUARTSETPROTO and HCIUARTGETPROTO.
> This issue bug found by Yu Hao and Weiteng Chen:
> 
> BUG: general protection fault in hci_uart_tty_ioctl [1]
> 
> The information of C reproducer can also reference the link [2]
> 
> Reported-by: Yu Hao <yhao016@ucr.edu>
> Closes: https://lore.kernel.org/all/CA+UBctC3p49aTgzbVgkSZ2+TQcqq4fPDO7yZitFT5uBPDeCO2g@mail.gmail.com/ [1]
> Reported-by: Weiteng Chen <wchen130@ucr.edu>
> Closes: https://lore.kernel.org/lkml/CA+UBctDPEvHdkHMwD340=n02rh+jNRJNNQ5LBZNA+Wm4Keh2ow@mail.gmail.com/T/ [2]
> Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> [Harshit: bp to stable kernels]
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is backport of a fix for CVE-2023-31083, it applies cleanly to all
> stable trees and I have build tested this.
> 
>   drivers/bluetooth/hci_ldisc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 865112e96ff9..c1feebd9e3a0 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -770,7 +770,8 @@ static int hci_uart_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
>   		break;
>   
>   	case HCIUARTGETPROTO:
> -		if (test_bit(HCI_UART_PROTO_SET, &hu->flags))
> +		if (test_bit(HCI_UART_PROTO_SET, &hu->flags) &&
> +		    test_bit(HCI_UART_PROTO_READY, &hu->flags))
>   			err = hu->proto->id;
>   		else
>   			err = -EUNATCH;


