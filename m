Return-Path: <stable+bounces-146214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124DBAC2869
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 19:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AC01722A0
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 17:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F2297B7B;
	Fri, 23 May 2025 17:19:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35855224AE9;
	Fri, 23 May 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020769; cv=fail; b=odrs3nmVrSOCyBudqXjb+G7Lb4W6OMaTedx3GcsbQnJBgkW2/IfCNvpD0Ivdv+nn1S6Xyt+2caxLkn4KOeywVdL+KkUHq76qwwr2ynnguDlEYMGA/CBjzaynUZioRZjDxG/O0uUKCzyYdNbpFGNGgeQhGUKwZVlwGmY9AXrJcgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020769; c=relaxed/simple;
	bh=ub+WELNefQwRZA8bkcmWuZgqD4M2/ehqkjphJnhtZcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qnGsrXub1VFEvHuVePS55LCqvBXv1cpY95OkHEhylfN0t1x8QWsnhzfxUvhbYfyYglYYnfiXdYg3ZNi+1z5Eh5yl10BsyRAdXzb8SK3pMSjkTmcoo7rWmT2BAWYse3uxo5rZwQEh29YcDuPo4bLbRFSk7+YW7mje0XUA9lPrkR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NFgecO003492;
	Fri, 23 May 2025 17:19:24 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfwv40x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 17:19:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3VHVmTcU05BMXWP3zNfQpZr6e5oPXAldKlqa5csZWirULnlElf9NvN/I/tzkSDCA6lgRPev6I5VEMWx2KREACv89oKUO5FkkjcjdBweIpZ/RggPrjlMYLqxq3BaKL4+0fwdhdZgXQZ9EpFytV0MPu8qAtatfApfN+fIHRwuHceuHIAIzjXKSRCwUbYiiJj2tcRdIX0iWUY91uaT4NuhLuzcS9+m+7Tts0htWC97DP+G4XmiQnYRRke51ufh2mqw6CC53PYaG9BTQZQlv5u/E5sOBDD6i66fEMnR2Vpz2tsJBAhBCY9QPj7Oe1Gopfew2q2+H+phJ+DKZZ4mq9FsNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEBsMIJfwQsxFPekoU8dvYGzD3OTGLPLA0ugC1tFDJI=;
 b=WJz3T97cDV9sVB9+RKwu3OFEBSYKgtszS4BhiKEH5DIIvWrUR5aQyB44+YlWsHIeW72rkvDI6R57j6RpuWMr7pMDERg6zYrlGSzSrSDwMF/fjzXNl/AbN3YaFrGIn6NJ5b/3J2lIyKqvWh7Khvpo6lu3cd/tgWdPt35bD3+kR4CDUoh6p99z1ghT9HaswvNt05+MdAaA01KxII15/twrbod0LkX8N0oiZjvvVCEaBhJWduDuUWBZLYjLlgAyDhm4x1tgNRLDYfGJr86fg0kW7qctv5D7v5DciOnnRkOobW+B9ATFnB6aZpnqIST51wJAAOsw9tIU38VlUB1gXUX2RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB8189.namprd11.prod.outlook.com (2603:10b6:610:18d::13)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Fri, 23 May
 2025 17:19:22 +0000
Received: from CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4]) by CH0PR11MB8189.namprd11.prod.outlook.com
 ([fe80::4025:23a:33d9:30a4%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 17:19:21 +0000
Message-ID: <74e68adc-2f52-42bb-a459-4e8791fcb7f0@windriver.com>
Date: Sat, 24 May 2025 01:18:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: nfs mount failed with ipv6 addr
To: NeilBrown <neil@brown.name>
Cc: chuck.lever@oracle.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <> <ba4f9f5d-0688-4537-b721-7b2bda8ead8c@windriver.com>
 <174800241235.608730.3027057856480430075@noble.neil.brown.name>
Content-Language: en-US
From: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
In-Reply-To: <174800241235.608730.3027057856480430075@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0320.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::16) To CH0PR11MB8189.namprd11.prod.outlook.com
 (2603:10b6:610:18d::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8189:EE_|SJ0PR11MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: 790412c0-5a32-4e47-6e4f-08dd9a1df518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YktMRkxsdCtQbFNjamlSSEZNRVBQTktyZjR6N2szYWtwdFNCZWxvRjkvZVcr?=
 =?utf-8?B?STg1c2hDSUgwdHFnUVB3bjlTd0FDUmN2bTUybjcvSEpJWHFNZTZBWE14QXNO?=
 =?utf-8?B?NmtWcFhvSWxGNmJ2cHAwTU9PRUo2clY1bnI0SHBJanV6dXpleWpCbUJUdUFz?=
 =?utf-8?B?L29VRDVsbjhNWm5hSWl6NHZvYjBLYklrMnY5TzE2WmwyZHhyWXlHMUxBSWFh?=
 =?utf-8?B?WEVsdzh2VlJGU2JtM2dqUlNLbDVmOTF2anZ1cE5vV1p6ZkpTVUhMNEpzZm5Q?=
 =?utf-8?B?UytUcXZGcEk4bkZxWWNuMGFTNVdFcngzRGdhbkpBUFdqeGMxdGZpRjh6QWhH?=
 =?utf-8?B?ZkU3ZjZPVnc5TXYvdDkyTHE0TXBhZko0VGZEQ0IzNnk3SUVwUGFnWkhmbUZk?=
 =?utf-8?B?VlJHd3ZZQVplZjRZbnJQVFQ5dTNTMGlxM2pwTkQzWHNGL2F5Q21CYlNJRHVi?=
 =?utf-8?B?WWJFN04vL2U3eFczdFZaNWJKZWE0c2xxNitjTjFEMHlTay9kZ3g3Wi9ZSS9Q?=
 =?utf-8?B?dzViVTB6MnNMZ2dSV1Jodms0YnVqTTBwUFI0cWtZeGxVK1ZOQ25jRzMvSkRR?=
 =?utf-8?B?dWpWeFVQMHpBZTVDZURwVWZIQUE0bFQreFl6MlRncVhsSXkwZWg5RDNlQmhl?=
 =?utf-8?B?WUFQS1E4QytzT1hPM2ZrQlZTRW9lRzU1Y2NOc3g3cExwWUZndDFyTTU4Q3Ry?=
 =?utf-8?B?a3JkWkhsejIvZEZKTWV2ejZzVnFOMnRpN3hDTWFwZTVXbnM5UHlZd1ViekYr?=
 =?utf-8?B?OTZPU0U5anlxeURvRUs0M0tZOHQwODJtM25WSGVSVWhvaHUrQ1cyWHFjRGEx?=
 =?utf-8?B?OWVkeE9yWXFrMkN2b0FBU0J1TDRWR1FqM2hTeUJGWHNobzgxb3ZRN3AxUGhC?=
 =?utf-8?B?WkZOODJhTlphTmRoVFNIbFFCeUkzL0xyOHZxUGxDMkRLb3pLNE9VTkx1bnZP?=
 =?utf-8?B?RnpOdkQ0ZkZQRzlxN2ZIUkVXU051OUx1ZjJlRS9tQjF3SUJvck16R2xCSWRG?=
 =?utf-8?B?WHhBS0JCeUlXMWdsZWdQMVQvbkh2R1Zjbi9kcGRjaURTNGFYejlYN0xpa1Nr?=
 =?utf-8?B?bHoyRm8xVEF1dVgxcU9uYWtXOEd6a3Q4RktNODY1clJpVmtuQkwvdUwrVUVx?=
 =?utf-8?B?MENSemxBQ0MySGExYXd1b0YvQkY4Y3VURi9rY3RMajZLd09hcGErN2V0WGpO?=
 =?utf-8?B?dE90cDhtZStDN3NmdXhpQ2QycjRvb2dzcTlqVHMzbmI1UGFrK0kyTEs4QnlU?=
 =?utf-8?B?WXZaM3k3R0l3RkVLNlkzcTlNb0ZRWSs1Y3BxbTBlNWg5MHUzaFEyRS95WjM2?=
 =?utf-8?B?dWlZSm9RTFpqQXJUNUJwY21URDZPbkYxajFoWWZMUFZMMHRSQkd5RGpDZkZw?=
 =?utf-8?B?WTFRN3pwTXV5Rloyb3h0NUF1TU5WRiswY3BCOTlscjNvRm9JbVpjbEJuNThL?=
 =?utf-8?B?Y2xvZjM2T2MwZVJIb3I1MGFsRS9SaDFtS3NiaCs0cWtZemtocnZldEtvb25Y?=
 =?utf-8?B?SGRyc3diOFhJay90aDdLeThmaWJKejhrOFNUSWRrZVF6OXlnS0JTWkxJSXFv?=
 =?utf-8?B?b3FCb2FuVzEyb2xDTGVIYmRYNlVldUVxYittSjJBT2VlcWQ2WUNmTDQ0ZVFq?=
 =?utf-8?B?MHlMYld0WFpMRlhrU3JURyttNlBHa2NPaFBtdHdzU3Q4THRUQ1FHblp1UndD?=
 =?utf-8?B?dk9Mak1WWWtOenBXTS9uS3dIU0VxNmI3Y0x5Ny83Vm9SWDY5d0dQOWlyei9O?=
 =?utf-8?B?SUxXTnVDVkw5RS9sZGJCWUpaK25QV3ZQS0ZreUJUaVhDeTdyUWV3dzNkb2lk?=
 =?utf-8?Q?yN7rpHPYsfyWLUj/dwZmmLHfss8k/CkmkeV0M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8189.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3dvQlVrWGw0eUZKZERsUlpNSHd4Y1FhNDJOeEJYMC9Rd0h0cEladXFVSmQr?=
 =?utf-8?B?eW5sdFFJT0JEbTB6SmVyWkZBSHNPMERaNXBRdlJJVDVGYVRTMGpRYjFneHJQ?=
 =?utf-8?B?c0JOL1VNRUtNeVlxdDJiaFpNckh4d1BSeGV1OXRGczg2eC9KUGEvSzhHd0dQ?=
 =?utf-8?B?NUlydlFDdVJnZDB1Nlc1WnJzOGkwT2hiSFJjeWZsV3QxdkFUZkZmMWtPcnl2?=
 =?utf-8?B?ZXo3aDJQL0xvOWNRSWlCVHBva3M0L2xDbjlzVzdYSjF3c0I0VGVvUURPZXJw?=
 =?utf-8?B?UmlIV0dTL2hyZkF1NnQ5T2M3YlpnUmM2eGJqTDBCWjllM0ZHdWdoTlNpTkwy?=
 =?utf-8?B?TWxwOXlDMkpWOXpYeDlaUlNjT1FFeHJBalptWFRwWHMxNkdYcXZLbm84cWpO?=
 =?utf-8?B?d2djWXA0eHBJbUpDZFJKMUgvbzRxZjVTY0p2NXRYdDBGWDlLK0M3LzdhS2Vu?=
 =?utf-8?B?YnNTNStHRStHWHh4Zk1oL2dvZUdSb0FKOVNwUlFBbHQ5Vkdjc1YrbGdPR2l1?=
 =?utf-8?B?RmRMVE9mNGRKdUFVWTBDVXpCUVhGaXVQUHFOeGZmYmxQZVNTV0ZwN3g4d3pO?=
 =?utf-8?B?YU5tZkJrd21XaSt2UW9qWnl2Y2F0eG1QVGgwNnV5Rldsb1BhTXorTFJIVjcr?=
 =?utf-8?B?L1JmeVlqWlVKTWlSdHRUc1V6U2I1MGF6T09vQ09OdmNVMHJDN05XM3VKZ3lP?=
 =?utf-8?B?M3N5QWtNTmh2TjFKVTM3c1orTjBtMjM1SGVJRXFaZDhxWWhkNGxYREpwUTJp?=
 =?utf-8?B?clk0RS9YY1RLdDBCU2VwT1FFaXB1VVlFdnozWmZzaGREeEZ1TzRsWUx1aEhX?=
 =?utf-8?B?M0NCVHdWL1J0SEVCYVd5QklETm5LTERldG9NaWxLMmFOMTNuMmxhZ0NjQzFP?=
 =?utf-8?B?TWdjSmpCbEFsc2tLTndaS29INWEvcnkwMmhNcUdiUUVYVi9hYzZZM25qaUlp?=
 =?utf-8?B?bzZRRUNkS1Q2RU8rT3RWeURlcWlqYVNqZDFoMEhLb29PYkZKdzE2SzlqaHJI?=
 =?utf-8?B?aUJ4S3gveXJGYVF1STVpVUh0MjBpTmc1blNta1J3S0VzdURjRWdBS2t1NmtV?=
 =?utf-8?B?YjN1dlQxNTVET0hIN0FYcW9sZlNaekdLdEtZZzcwWEdJSkljYkVvZS8zWVlt?=
 =?utf-8?B?UUVSd0dyMkJxUTlFejFiM0NhNUN0U3FCVHlyaXpLc01IcnlMaDh0REhzRjdZ?=
 =?utf-8?B?YTRmWWdNeEhvYkZIdjdUakhxR2wybkNtV2NkU3JOWUp4MTU0RXI1b2hHMEJm?=
 =?utf-8?B?b0cwdmhLbkN6RU9BVzZQTlcrK2tHM0pONlFjakw4M0J0Nkt3UWczTUZyeHpj?=
 =?utf-8?B?ZE9pOTh4RnRsdWJBSFdVSnYvbGJ3cUxza3pjMEtoL2ZTT1pkRDNTcnZnc0NE?=
 =?utf-8?B?WmYyakZaKytNVUpjMXY1eFFYOEkzNUQ4ajhQVE42dW50SDFhVUFTaDBFSlM4?=
 =?utf-8?B?Z2JibXlMN1A2OUNFSVlVSHZubCtnWDlTMU5YSjFCMFpqNzBBY2lpUVBkN2Zk?=
 =?utf-8?B?Um01akhrYkJlWlNVWWdhWW1rVm0wb1B5VlcycDQxak4yZlJLcFRQN1A5bE9V?=
 =?utf-8?B?bzBuMXpZTXFJSGNkYUk1RXlSWkd1Ym1RdGd2UGNTUXRaYm1nUnBoVmdsdG9X?=
 =?utf-8?B?cERYbGdGMklkdmErTkdnYUJTVGdjc3FRN0F2V2ZuS2ZLVTltNkk3dE5kUGor?=
 =?utf-8?B?bnVnaG43bFBuRzdTRklIVEU5WHZMTS9qdVRVRUFKemlwL0pvZkpiN3h0OWdL?=
 =?utf-8?B?V2RWV0R2d1dGQnNkQVIrY1d1WENwbmt6aFNqVVp5OXFseFdBdXZpMlh4dTQz?=
 =?utf-8?B?WjFIMEw2MjVEaW1Lb2V5N1ovZXFLNnFCb3dlK2FPNVVOOU1naHNTVDZOckJ2?=
 =?utf-8?B?T0FIZHRSUkhsOWhVUmdEOHBjcXdPdzBaU0kwbWNqWDhmNkI2bGhmNzdjMURr?=
 =?utf-8?B?cEFUYXA1WlpsbjczTGtDeGMwR0IrWmJDVzlmdDh3NnNZR0FXRzRZMTVRZ1ZZ?=
 =?utf-8?B?TVF2Yi9DUnVMaTVtV1RsV3VVNndNOWptT0xQU2ZBaXVzSGZWQlo5b3kzWWpu?=
 =?utf-8?B?MldOUWt5VU5xMEdQcUovbFd3UzFLQ2pvM1lQTjV2Q1ROV2hzUXBqWlY0NXc2?=
 =?utf-8?B?QjZway8reEJaMWV6L2tBVVhqNGVHNmZCRXdGWFJ0Q2pUbG13Q1VXWHoyRXJP?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790412c0-5a32-4e47-6e4f-08dd9a1df518
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8189.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 17:19:21.6035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfhHwy0yUzHZY4/fWaVshkfjs5z7yRhmJzMNNhaxM5i6cZQ5UZwT2AChcaQOk4uvVHKOK1eUCYJs+CpDprELun1CziZfrzKvuy/HN3tdRbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDE1NyBTYWx0ZWRfX+KaKuT62Dmkl /fDfb0m8OQdSML7qJTUCav56m2lUEFaE35dphXfcqk1U8JMfWW1fUzkErA4m1cTj5JWWs0nvJbM NIlx9o6IKG3EY31NT7MWM03Qx0UPciqorWujOvy/I2O9KZNjK9Vd34d0M6ql3ihr55mu4WJRw7k
 UgymwrK8B82/3LcolNlgHJZz8vN82rYdHbG1gDr43RzhNuXYAn7u2iGte3SYZnwNWUUHzLOxc92 NpvdMIArVUs3ZLUTwP6hNXBGA34k3AFLEIJUxWO9PJTK3zCS/so2KR0WutlQjYdC8llwWoqUEqi obIX6azJDeIsw0XvP0ilerA+/wrkByvmrfigRYO/2YHX3OYuNGcGzLR+8O+0piRKYj3Wmw6/Cvr
 90tnB6cyGv+dj7wICdeY4AQM833kAT2bibDrJdC09tDcMINU2T5tVUlhPCBmawcZ3+/+q3um
X-Proofpoint-ORIG-GUID: SfNHQS5K2R5xN9FOHxghYFHiEsPbrmLI
X-Proofpoint-GUID: SfNHQS5K2R5xN9FOHxghYFHiEsPbrmLI
X-Authority-Analysis: v=2.4 cv=b6Cy4sGx c=1 sm=1 tr=0 ts=6830ae1c cx=c_pps a=/81dOUaqqWO4f6DVepChjA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=Q4-j1AaZAAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=nTGYnumo5aSTyKUZ_VgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505160000 definitions=main-2505230157


On 5/23/2025 8:13 PM, NeilBrown wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Fri, 23 May 2025, Yan, Haixiao (CN) wrote:
>> On 5/23/2025 3:42 PM, NeilBrown wrote:
>>> CAUTION: This email comes from a non Wind River email account!
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>> On Fri, 23 May 2025, Yan, Haixiao (CN) wrote:
>>>> On 5/23/2025 7:21 AM, NeilBrown wrote:
>>>>> CAUTION: This email comes from a non Wind River email account!
>>>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>
>>>>> On Thu, 22 May 2025, Haixiao Yan wrote:
>>>>>> On 2025/5/22 07:32, NeilBrown wrote:
>>>>>>> CAUTION: This email comes from a non Wind River email account!
>>>>>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>>>
>>>>>>> On Thu, 22 May 2025, Yan, Haixiao (CN) wrote:
>>>>>>>> On linux-5.10.y, my testcase run failed:
>>>>>>>>
>>>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount -t nfs [::1]:/mnt/nfs_root /mnt/v6 -o nfsvers=3
>>>>>>>> mount.nfs: requested NFS version or transport protocol is not supported
>>>>>>>>
>>>>>>>> The first bad commit is:
>>>>>>>>
>>>>>>>> commit 7229200f68662660bb4d55f19247eaf3c79a4217
>>>>>>>> Author: Chuck Lever <chuck.lever@oracle.com>
>>>>>>>> Date:   Mon Jun 3 10:35:02 2024 -0400
>>>>>>>>
>>>>>>>>        nfsd: don't allow nfsd threads to be signalled.
>>>>>>>>
>>>>>>>>        [ Upstream commit 3903902401451b1cd9d797a8c79769eb26ac7fe5 ]
>>>>>>>>
>>>>>>>>
>>>>>>>> Here is the test log:
>>>>>>>>
>>>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# dd if=/dev/zero of=/tmp/nfs.img bs=1M count=100
>>>>>>>> 100+0 records in
>>>>>>>> 100+0 records out
>>>>>>>> 104857600 bytes (105 MB, 100 MiB) copied, 0.0386658 s, 2.7 GB/s
>>>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkfs /tmp/nfs.img
>>>>>>>> mke2fs 1.46.1 (9-Feb-2021)
>>>>>>>> Discarding device blocks:   1024/102400             done
>>>>>>>> Creating filesystem with 102400 1k blocks and 25688 inodes
>>>>>>>> Filesystem UUID: 77e3bc56-46bb-4e5c-9619-d9a0c0999958
>>>>>>>> Superblock backups stored on blocks:
>>>>>>>>           8193, 24577, 40961, 57345, 73729
>>>>>>>>
>>>>>>>> Allocating group tables:  0/13     done
>>>>>>>> Writing inode tables:  0/13     done
>>>>>>>> Writing superblocks and filesystem accounting information:  0/13     done
>>>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mount /tmp/nfs.img /mnt
>>>>>>>>
>>>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# mkdir /mnt/nfs_root
>>>>>>>>
>>>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# touch /etc/exports
>>>>>>>>
>>>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# echo '/mnt/nfs_root *(insecure,rw,async,no_root_squash)' >> /etc/exports
>>>>>>>>
>>>>>>>> root@intel-x86-64:/opt/wr-test/testcases/userspace/nfs-utils_v6# /opt/wr-test/bin/svcwp.sh nfsserver restart
>>>>>>>> stopping mountd: done
>>>>>>>> stopping nfsd: ..........failed
>>>>>>>>       using signal 9:
>>>>>>>> ..........failed
>>>>>>> What does your "nfsserver" script do to try to stop/restart the nfsd?
>>>>>>> For a very long time the approved way to stop nfsd has been to run
>>>>>>> "rpc.nfsd 0".  My guess is that whatever script you are using still
>>>>>>> trying to send a signal to nfsd.  That no longer works.
>>>>>>>
>>>>>>> Unfortunately the various sysv-init scripts for starting/stopping nfsd
>>>>>>> have never been part of nfs-utils so we were not able to update them.
>>>>>>> nfs-utils *does* contain systemd unit files for sites which use systemd.
>>>>>>>
>>>>>>> If you have a non-systemd way of starting/stopping nfsd, we would be
>>>>>>> happy to make the relevant scripts part of nfs-utils so that we can
>>>>>>> ensure they stay up to date.
>>>>>> Actually, we use  service nfsserver restart  =>
>>>>>> /etc/init.d/nfsserver =>
>>>>>>
>>>>>> stop_nfsd(){
>>>>>>         # WARNING: this kills any process with the executable
>>>>>>         # name 'nfsd'.
>>>>>>         echo -n 'stopping nfsd: '
>>>>>>         start-stop-daemon --stop --quiet --signal 1 --name nfsd
>>>>>>         if delay_nfsd || {
>>>>>>             echo failed
>>>>>>             echo ' using signal 9: '
>>>>>>             start-stop-daemon --stop --quiet --signal 9 --name nfsd
>>>>>>             delay_nfsd
>>>>>>         }
>>>>>>         then
>>>>>>             echo done
>>>>>>         else
>>>>>>             echo failed
>>>>>>         fi
>>>>> The above should all be changed to
>>>>>       echo -n 'stopping nfsd: '
>>>>>       rpc.nfsd 0
>>>>>       echo done
>>>>>
>>>>> or similar.  What distro are you using?
>>>>>
>>>>> I can't see how this would affect your problem with IPv6 but it would be
>>>>> nice if you could confirm that IPv6 still doesn't work even after
>>>>> changing the above.
>>>>> What version of nfs-utils are you using?
>>>>> Are you should that the kernel has IPv6 enabled?  Does "ping6 ::1" work?
>>>>>
>>>>> NeilBrown
>>>>>
>>>> It works as expected.
>>>>
>>>> My distro is Yocto and nfs-utils 2.5.3.
>>> Thanks.  I've sent a patch to openembedded to change the nfsserver
>>> script.
>>>
>>> Can you make the change to nfsserver and let me know if it fixes your
>>> problem?
>> What's the version of your nfs-utils?
> The patch isn't against nfs-utils.  It is against openembedded-core
>     https://git.openembedded.org/openembedded-core
> which is what yocto is based on.
>
> I was expecting you to manually edit /etc/init.d/nfsserver to make the
> changes.
> Or you could possibly:
>
>    patch /etc/init.d/nfssever < THE-PATCH
>
> NeilBrown
>
I have verified the patch, it works as expected.

$ cat 0001-nfs-utils-don-t-use-signals-to-shut-down-nfs-server.patch

 From d99df205d0aca0703a49834df39435442044433b Mon Sep 17 00:00:00 2001
From: NeilBrown <neil@brown.name>
Date: Fri, 23 May 2025 23:58:09 +0800
Subject: [PATCH] nfs-utils: don't use signals to shut down nfs server

Since Linux v2.4 it has been possible to stop all NFS server by running

    rpc.nfsd 0

i.e.  by requesting that zero threads be running.  This is preferred as
it doesn't risk killing some other process which happens to be called
"nfsd".

Since Linux v6.6 - and other stable kernels to which

   Commit: 390390240145 ("nfsd: don't allow nfsd threads to be
   signalled.")

has been backported - sending a signal no longer works to stop nfs server
threads.

This patch changes the nfsserver script to use "rpc.nfsd 0" to stop
server threads.

Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Haixiao Yan <haixiao.yan.cn@windriver.com>
---
  .../nfs-utils/nfs-utils/nfsserver             | 28 +++----------------
  1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver 
b/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
index 0f5747cc6db9..053980271c05 100644
--- a/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
+++ b/meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver
@@ -66,34 +66,14 @@ start_nfsd(){
      start-stop-daemon --start --exec "$NFS_NFSD" -- "$@"
      echo done
  }
-delay_nfsd(){
-    for delay in 0 1 2 3 4 5 6 7 8 9
-    do
-        if pidof nfsd >/dev/null
-        then
-            echo -n .
-            sleep 1
-        else
-            return 0
-        fi
-    done
-    return 1
-}
  stop_nfsd(){
-    # WARNING: this kills any process with the executable
-    # name 'nfsd'.
      echo -n 'stopping nfsd: '
-    start-stop-daemon --stop --quiet --signal 1 --name nfsd
-    if delay_nfsd || {
-        echo failed
-        echo ' using signal 9: '
-        start-stop-daemon --stop --quiet --signal 9 --name nfsd
-        delay_nfsd
-    }
+    $NFS_NFSD 0
+    if pidof nfsd
      then
-        echo done
-    else
          echo failed
+    else
+      echo done
      fi
  }

-- 
2.34.1


Thanks,

Haixiao

>> The patch failed to apply.
>>
>> $ git am '[PATCH OE-core] nfs-utils don'\''t use signals to shut down
>> nfs server. - '\''NeilBrown '\'' (neil@brown.name) - 2025-05-23
>> 1541.eml' Applying: nfs-utils: don't use signals to shut down nfs
>> server. error: patch failed:
>> meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver:89 error:
>> meta/recipes-connectivity/nfs-utils/nfs-utils/nfsserver: patch does not
>> apply Patch failed at 0001 nfs-utils: don't use signals to shut down nfs
>> server. hint: Use 'git am --show-current-patch=diff' to see the failed
>> patch When you have resolved this problem, run "git am --continue". If
>> you prefer to skip this patch, run "git am --skip" instead. To restore
>> the original branch and stop patching, run "git am --abort".
>>
>> Thanks,
>>
>> Haixiao
>>
>>> Thanks,
>>> NeilBrown

