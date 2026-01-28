Return-Path: <stable+bounces-212663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJWYK6lhemk75gEAu9opvQ
	(envelope-from <stable+bounces-212663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:21:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1188DA81F7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B51A8302D5CF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 19:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7A8322B79;
	Wed, 28 Jan 2026 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IMgsUXA2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012A1D5CC9;
	Wed, 28 Jan 2026 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628070; cv=fail; b=U4HY32ZPrsKB2+MX2IbXVZot2RU5KIecNmXsiOub3q81qyah40LnKiav4F6ADksiONceFGnm4/6HdrQo3dmI/X3md3S6tMpkResDq7Fb5YX+fbiHUTdfXD5cmnG1FtzKTvJHsZph/06EgF5Ztldqo7qUfx7JsDLkucY5A69QXn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628070; c=relaxed/simple;
	bh=/5rDuKyccI39z+BDayXGSZ4Tuahowt1FdCBZN6usOj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sMIAjVNoyy2epIp06B3sxJzyvG82KYxeWuMQQXIdMOYRavb9HNqtb/EQjJYf8UxcbrFr76/51OtypH300as/JgsJFRELwn2oI1jL+R+jsMCxorq214rjrHRhmUX6iUuZ2VhiWM7+exCco9cxiZl7HkY6KRk3OHQKe7//dqFj/Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IMgsUXA2; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60SJF4Z32248256;
	Wed, 28 Jan 2026 11:20:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=3Jrc4de4LgyczWTzCdak00725+38ZlOAXDjASx1f2/E=; b=IMgsUXA2Da6S
	dFip02RIHz34b+IBTJjNLqIfHsGn1GnA2JFkU1iqcQi2o0h5brdsRcVJ3tyY8q7j
	Ng+kwweeN3jkiekLRQphw2Dhknf2IKGAiyl6/8fvWImbyAAmT1eUaAuSG/Ny+ioG
	Ly76uNv3ZXhte/Cay9e1mOJXDfV2vL5ZpMDVxgDnUGIHruEDdCcEWafx5D1B6BfI
	fLp4cYqsXcT8gPk4aHX/wOnvRzSI2jeaGvVuEn6VhQdW4SIz8MGsEEwZuroLaw0c
	5IUFnD0pKPLWI1P3AShxWSCd7qZ1m7b93EUJBgL8Lpa/ICfw+T8uO74Br949Krrs
	xH4YBLHGbw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	by m0089730.ppops.net (PPS) with ESMTPS id 4bykbwc55h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 11:20:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIwa+jJzdT7s6olY5FK3bRmpDtLc1gyj2So6hgkM1kCFiJX7iNT1jHwv5fPDnzemU8k+8knsyPSlecfjOTCZkMruTh6zCQSjk0nYgMxqGoI13oQHn6xf7wEor5/CTQ4rr7qIj0uNvEE+a/4ERJ7i4tUU7tdhZRxrvU/JSsQA1iEhk1vj4qpFl+XULoj4XFvmCvgFZ5NVy35+kup1b8WptXG8is2K7rQ4zhgKRSGStpLtKz7J5XWfoUkYolUkWjaf2tLev+7XAHeY4bjx/c68P9eoyGcrOxq5bHDPEeq69Mtd03wE26oA8OiZo9pz0cByyn/Bsl0GI7+gwbQH8iDesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jrc4de4LgyczWTzCdak00725+38ZlOAXDjASx1f2/E=;
 b=j7JGnPcdAIZxnZ9j91fa1G388YC/uMhTJpd5Jw6cQW+zWaNNVLuyjWiIqe41C9iJz4gy0zbVF/dyg3PjcqykUorhZgMlqzzFux/lFMKvD/FJ808ywCg/fFCQ5EyMWjOkZLpw4mXaW3gGfvVSRRyMVNMIIJ5jseq/bjSQr5RMMw+kzPleewh31lK1QY3M/SzM75NpKwq2JtUwxvsOl+4bzX4wEYQH88kgUcbSVxfIeSOtLjDqKcvpJeMYHQf+V5qvSu6Rb/1RMFWUDWoIN3MTZbPT9Sd7EaNHYdS+3eWIdlW+r7Opw5d5u43mvXBzLWysDo63+EotIPxF/FqmDA+DkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by DM4PR15MB6273.namprd15.prod.outlook.com (2603:10b6:8:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 19:20:23 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 19:20:23 +0000
Message-ID: <32a7c9a6-0844-4dd1-b092-badca305546a@meta.com>
Date: Wed, 28 Jan 2026 14:20:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/shmem, swap: fix race of truncate and swap entry
 split
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
        Chris Li <chrisl@kernel.org>, Baoquan He <bhe@redhat.com>,
        Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>, stable@vger.kernel.org
References: <20260120-shmem-swap-fix-v3-1-3d33ebfbc057@tencent.com>
 <20260128130336.727049-1-clm@meta.com> <aXo6ltB5iqAKJzY8@KASONG-MC4>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <aXo6ltB5iqAKJzY8@KASONG-MC4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:52c::7) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|DM4PR15MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0bd036-2b35-4764-aae8-08de5ea248be
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGlhbW8yelFkbGdkcUU2V00wL3psbVJzLzVzV0pFT3NWdG9WcDBRZW1za0F6?=
 =?utf-8?B?M0xGd1JZdkpuS2tFWnlkUnF0UFRSNUR2SFdmcTVCTjRBQnNzbitqWWtodk4v?=
 =?utf-8?B?Y0Q0Mnl3L05odzMyUkYyYjBhd3BVdHNjbjF1Wkw5dU44dW1ET0V1bGw4TW9p?=
 =?utf-8?B?bk1TRmRha050UHpoQnAxaGpWUUxGRVduUXEyQVVSejBacDlIMkRSdWJnQjI2?=
 =?utf-8?B?QkxhTEVPTXBodXZjanZhVkc0TGg4QmhzZk5zV1dQZHFHNWpOL2ZtUWwzMEZm?=
 =?utf-8?B?YVVIRnloWjRnSXFseno2WW41YzNkdE41Q1kyUXZIdzRqZlc2WHQ2QkxBYzA2?=
 =?utf-8?B?Y2VpZGlNNjE0MGZmd3pzb3JxeElaVjd6RVYrWW9DaU5pNkQ4amtNaWg3V3JT?=
 =?utf-8?B?RVcydHBzU2lCUUtHOFFCcEZiQ2NHYVZTQTAxUTNuTDJIeWMzbGljNW1hSVFK?=
 =?utf-8?B?WlZTZlp2U2JmQ2o2N2t1Tm9QK01hTTNPS1ErVEQ5VGg3MzFuWDRMMGxqUGNT?=
 =?utf-8?B?ZmdSaGVSbGR3cHNja1VrdUIzZDc4MFdFbnJxWkllNjhJTHhVb2JhZnlmN2Ja?=
 =?utf-8?B?M3RSNmZRTmlKc004Sk9Sc0tYS0JGai96NzN0Y2IxQ0hvdVg5TlVVTTl0andj?=
 =?utf-8?B?M0pnQ3VrRG9hTDNnZTQ5VTJJRzFQNy8wTW5JbFEzZS9UcGNoN2pIbktIT0VX?=
 =?utf-8?B?cUZySEVoWUVtUGhtQWtVMGluUVFKV0l2QnA3RWFFRXIvQTB6cFhpaXhTYjha?=
 =?utf-8?B?NjdEVGpTdjMwdTdsZTFkT2JRaWNPZTdlaW0zckJ5ZG9Bb3FrUkRpaGNXUnpN?=
 =?utf-8?B?c0ZlYWFhSVZCSDQxQnFpMUhmT0ZJUWF1K0Q0bHd0dy9KK1VhV1BOYUZMUll1?=
 =?utf-8?B?a2pvV1c2bEgwMkRpWWZYeWdaRWsva2tJNXI5cFNlQWE3R0J0a2lNRjVhNUcy?=
 =?utf-8?B?UWZLd0pEbkdpK3RHeEFDaE5Cajd2U1lxN0hydGM2TFBkbG5UcklFQm04SWNk?=
 =?utf-8?B?Z0dKYXNKNitMVHB2dVpsS1A2Q05ZSVIvaFN6UE9SajF6bG1QZXVDNHp6SSs5?=
 =?utf-8?B?M0o2ZlNrY1N3TTYwUUQxM0duaTUxSlFyZzBCdWE0Zm9nZnUzWEpNZzFWeGVy?=
 =?utf-8?B?YTVtQUFzVC8rNVZEMlR1eS85QW52OXpzalpDZjNiNWd2OUdlS2d3RndBWm1Y?=
 =?utf-8?B?Ymw1emg4c2ZrOUR0eUhIRVIxSEV0aHdOZTlYWE1US0MrOCt5YnM1aGxjKzE0?=
 =?utf-8?B?YkZ5MkpCRXdKM3QxdWpnMmdyZlBHS2tHMExxWHVtK3BkZkV1Z0laZng3YlRC?=
 =?utf-8?B?WVBmaFVHeTVFTHkzM0RrL2g1MHpXcDRJYXRTK1VlbjF3bVp4Tk4xVjZVam83?=
 =?utf-8?B?dEwzQ0svc3MwOFdWMWcyZ0ZSaFhDQWU2a1pYUDZnWkVBelNqQkd3anlkbXgx?=
 =?utf-8?B?eTRyT3VzSElPRDBnRDBxb2xvSUhHeUx1MHIyWjZkeVRnRzJEcjhUcFpBZmsy?=
 =?utf-8?B?UktwL1BaV0g4L3J2d3RLVjZZdkQ1bXpYbEs2QVNkN2I4UzNGS3R1Q1I0NkQ3?=
 =?utf-8?B?TkhMSnF2VXBGdStUL2RYeCtpcnMyajVEQkpiVzhEVFB0OTFWTjRlS0NKdkV3?=
 =?utf-8?B?UG5IT1BTVE9ZRWkvU3l1NGpodERQdUExd1F5Q0ViR0VmNi9KRXc3RnZXaW1t?=
 =?utf-8?B?dlFzcDJXaktQSDl6TndBdGdaQmNsdUloT0tLR2dVWFZtaFRLV2lKeVJLUVZa?=
 =?utf-8?B?OG9oZ2xNS3VnK29BRmIxdTB1RjhQcWFOWW1uZis1ZFhweDA0V2UyYjFmZXps?=
 =?utf-8?B?NWhBZFd3MUVhZGNsRzQ2NFJOaDVuOCs4UUswb2o1TnkwdEhaWnBJMHVxNTVL?=
 =?utf-8?B?eDdkRTNveTFNck5LL0lzRW5uNTRWL3JRakw5N2lHZ0gyQVArcWRRS3A2VUh2?=
 =?utf-8?B?NkRKWDNveWwzc3FWVjB0RHdpWEM5LzBPWHppR1FDb1U5NW5kTVh2NE1hSlln?=
 =?utf-8?B?V2EzZ3dMcEpEc01uY3RQbm5iR2UxMUdCNXdsQmdkczhOQWV1Zi9ya0lUQlo3?=
 =?utf-8?B?MThYd2xCdloxRXZzRHJRbHpTRzd3ajFBQkNJV0IxTnNhZk5DTDJnTTFSZjgw?=
 =?utf-8?Q?Pmaw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkJUNi9laDhIZEFpTVJGOWY3VE1jczdiVTVQbWY1ajJkYVlhSmZqdjRML0d6?=
 =?utf-8?B?RG50T0dxV1lhWWQ4Q0N6Z2l0bnFJRVhLcmFZVWNRb1p4cUtrc1A5N1FCaWpt?=
 =?utf-8?B?N0ZGN3JaYXBNeFRXVW1lOFlSQXV5d1NpdVV1Rlp6R0VMM0N3d3VPbThsb0lG?=
 =?utf-8?B?aTZHTE5BQmZkVjRiemVWdnJwbmVlRG9ISHpCL2dOdFBESnM5UjZUVEVRWkJI?=
 =?utf-8?B?Qk0xekZ0Qi8vN0pNcFp4VStacnpNemZWSkIvSlF1TTJndDkvSHVkdC9KV20x?=
 =?utf-8?B?N0ZRUlh6UXUwQ3hSbTlTZlV4SjVabm9PNC80eldQcWJTWWZQMUdrL3VKZGZL?=
 =?utf-8?B?SGhiTVk3T0kxM3p4KzR1S0M2cWE3V0JQVFRrS2xwZ21vcmczcjZoUDJYT3Nk?=
 =?utf-8?B?YSs3WTVRQ2VHbEIzWE8zM1kxNnFFUlRRV2Z5VUVvS0tqQ0lCcTFRMm0zNk1S?=
 =?utf-8?B?STZzNW1XdUVNR1A1Z3FMNzIrK0F4K29GWkNzSkRDMzd0VTM3YjExVWhycXVB?=
 =?utf-8?B?UlpxeGg3Z3lTd2laMkdDRGRYNzJINU40M0VkTysrc2pucW1JeVBGY0VYTFhl?=
 =?utf-8?B?QmhQRk1rTEh3R1Jjd0hUSFFOVnNPRFdpNnNSR1F3QkRiQmI0VE1zQjlYcWdH?=
 =?utf-8?B?aXk5b2lUVlNLNTJiMk1SaS9PK1VKS0tCZkdGazY3bExVQk1Oa0pFcnhpWmpi?=
 =?utf-8?B?RUZTa1lzVEx1ajl1SDBLdzVVK3ZHRWl1RFFHdWVjcFYzdDNvRTJEWnFUNlZ0?=
 =?utf-8?B?MjR1UFNiUkxkTmhZRGdGTDhEQnpINEVwSEtUNERPZDB4U2tja3h0Q2dUR2U1?=
 =?utf-8?B?dVNXTzljUEY3dnJpNUNHKzJad0dsUG96Uy85eko0NVpWdHZ6dG43T2tGcHRR?=
 =?utf-8?B?UXhWS2VobmpYVGdpSEFuQ0NzQlRDejFqUU52eFFYNDd4R0NabFc4cTUxbnBX?=
 =?utf-8?B?eTRQL05DeGhzQkg4dTNGZDZHVDlrTVRJYjhmYm9WVGozQmFJV2o5Tit4STht?=
 =?utf-8?B?UEp5ZWdMT1ZUbHg3M3FqYTlJTkF6NjlmdGVucFpVbmw1blM4a1ZPQmlvYTl2?=
 =?utf-8?B?dlNjcWg4V2creDIvTUorSzdUUWJKeEZhUVpvMFpiTlZoUXVtSzdZNEczMzFY?=
 =?utf-8?B?T05KSWNvd1E1Z0lkTDkwdm1lMkFVMlMyMEhTSlhlY21xa01wT2djY0o1S25V?=
 =?utf-8?B?c0JLQ2RqTmhjQUtqb2pncUEyWVhEN3F4TnhiNzdQR2Q0NzJYWjZud3E4di9I?=
 =?utf-8?B?TGprL09FOUxqSUE3c3hSK3dJaFM2K0wyN001elZaZmozOWtJeEdqNEptVW5h?=
 =?utf-8?B?RUE1ZzBWakJzVndHNVRqUWgxRHk5czNjeHVVYis1Q2hlK3JuL1VoVm0wUU01?=
 =?utf-8?B?U2dUdEcrTStrNnoyMmVMaXJFZVBnb3dmeFNvSzFhbnNUeE8xUzRiTnhDYUgv?=
 =?utf-8?B?amtvZ1lTaFkyOUJJdGYxbEgyMUU0UnkybTFqRHh0ZDkyU3VGRzY5bERmQ29z?=
 =?utf-8?B?ODhQT1lxYTNxTC84eVRaV2lqTWpEY0YvQlZpTkxYNDIrV2dFeXl2WDh5WThN?=
 =?utf-8?B?QmdNS0Z2SzZwazA2b1BaVHpIL3ZwSGdkYW5PMXh5bGpVdG9iQVRnNzYraEpT?=
 =?utf-8?B?OTVHaXhKaDRzMDZ2V0MzUGxDOXgxWm91cEJqU25hd0JvS2JqYlVZVXNTMkRQ?=
 =?utf-8?B?TUY0OEE4VDNUNTVzRXU2ajZISVFOZlNaRHVrSFdkbkNjOHIyTENNSWtmcTA5?=
 =?utf-8?B?ckFIYjdwU3dDNTJ5NFJNdDN4TmgwdnA3clpvZHBFdC8zTUhuS3VsOWV2aDNl?=
 =?utf-8?B?MXczaWhyK1JZdFozOWlkRUhvVHduL2ZIMUM3ZGE2bVJpTW1ZaFdTcUpndDZE?=
 =?utf-8?B?SHNaMStVQmJFMWhzbFNTMDBreDFLVk5zajBZMmVhNU56d1FPVllvMDlNWk8z?=
 =?utf-8?B?T3NBSEhPbUg0dk11Z0xYL2lPazZrSUZMUTBLYUx3aWR4QmxFZUxSYzV2RGFy?=
 =?utf-8?B?Y2IxdGZrNXFham5vYnQ1VStydzRGWmoxRGhvMlpWOXhmTWc0V202bk5IREgz?=
 =?utf-8?B?MGZtY21yZW9ZanVheUVyWElBNmpPK0EvZDhubjBORDQwSGF4VG0vSjRuQ3V6?=
 =?utf-8?B?T0Y5cXJEU0N0NGdIeHhTTXVLNFc5UlRvM0w5cmpyRzZuZkVUWEhwQXdYYys0?=
 =?utf-8?B?b1BrSlVqNUY3VDJYeWxmTktqeE5JWHB0MzFZcnVPNEErM1dGWm1NVU8zWGkr?=
 =?utf-8?B?NmM0Y0pGWkxDRkFlWnZMRCsyTEFGOEwxakREK1RrNG00YkV3ZUNCeVlMd1NI?=
 =?utf-8?Q?9w8rYI4mxAKZaFELl0?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0bd036-2b35-4764-aae8-08de5ea248be
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 19:20:23.3145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /EohBzTPi0L63LFdU5wyOpPrcy1PXt2q7Q9GK4u9coABavTF1UH1Q/XXpx/fPz/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB6273
X-Authority-Analysis: v=2.4 cv=O6Q0fR9W c=1 sm=1 tr=0 ts=697a617a cx=c_pps
 a=0JRlrhwbVVPmsaj0kffiDg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GvQkQWPkAAAA:8 a=qGJZMtbXaoSNzlnTLp4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fqAA-znrdSvvdx7iNpMSc_rVs_PjnvZH
X-Proofpoint-GUID: fqAA-znrdSvvdx7iNpMSc_rVs_PjnvZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE1OCBTYWx0ZWRfX6ehjUQPLOkJT
 hIW7hs7Q4v9ww/HLG2Eu1jG0ioGc8zw3Wn7T6uhe9Hh3EtQeRVmsCzjwdiGB/s9I0Xo7c4jgCUw
 0+Ir19Ng1bUB5f5UivaNxbYw5FzDQHy8lBy9IvtOeN4d/3Oda6dbOf5Md31A37dIREqUK2IWeoO
 aNe0VyY8tqXTve1hDYLPq7CJEHYboo7g25aVjoG8QCH9S/wJrcu1vhoMnfUMqnMAcopxeRHXZ++
 75mTQVO6KFISTSfjRTJlKvbHp95zHyv5hTpU6TBb4Q+RYDt8Aqf/jBziUwHYlwTOQdgiR8ieQqh
 22XBYOgN8DvQ2wbTx6ifiUtBJVcp1zSKzxpQ9efXEkNn7mAnFNbGKYHlveKs+hb8yGfjJSa1WKD
 1sXaXSMXrrxR4e1nk7rBSP2CCzBOTQQjn9+wDodY542sIbTLQmyjxBVJt6BSG6zQFeKNfBDX+HB
 56d/vZveD4EZ2UDvdoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_04,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212663-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kvack.org,linux.alibaba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,huaweicloud.com,gmail.com,kernel.org,redhat.com,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim,tencent.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1188DA81F7
X-Rspamd-Action: no action

On 1/28/26 11:52 AM, Kairui Song wrote:
> On Wed, Jan 28, 2026 at 05:02:34AM +0800, Chris Mason wrote:
>>
>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>> --- a/mm/shmem.c
>>> +++ b/mm/shmem.c
>>
>> [ ... ]
>>
>>> @@ -1191,12 +1203,23 @@
>>>  		folio = fbatch.folios[i];
>>>
>>>  		if (xa_is_value(folio)) {
>>> +			int order;
>>>  			long swaps_freed;
>>>
>>>  			if (unfalloc)
>>>  				continue;
>>> -			swaps_freed = shmem_free_swap(mapping, indices[i], folio);
>>> +			swaps_freed = shmem_free_swap(mapping, indices[i],
>>> +						      end - 1, folio);
>>>  			if (!swaps_freed) {
>>> +				/*
>>> +				 * If found a large swap entry cross the end border,
>>> +				 * skip it as the truncate_inode_partial_folio above
>>> +				 * should have at least zerod its content once.
>>> +				 */
>>> +				order = shmem_confirm_swap(mapping, indices[i],
>>> +							   radix_to_swp_entry(folio));
>>> +				if (order > 0 && indices[i] + (1 << order) > end)
>>> +					continue;
>>>  				/* Swap was replaced by page: retry */
>>>  				index = indices[i];
>>>  				break;
>>
>> Could this code infinite loop if a large swap entry crosses the START
>> boundary instead of the END boundary?
> 
> Thanks for the review! It's really helpful :)
> 
>> When shmem_free_swap() returns 0, it could be either because:
>> (a) The entry was replaced by a page, or
>> (b) The entry failed the boundary check (base < index ||
>>     base + nr_pages - 1 > end)
>>
>> The boundary check here only handles case (b) for entries crossing the
>> END boundary:
>>
>>     if (order > 0 && indices[i] + (1 << order) > end)
>>         continue;
>>
>> But what happens if the entry crosses the START boundary? If
>> find_get_entries() returns a large swap entry at indices[i] where
>> the entry's base (calculated as indices[i] & ~((1 << order) - 1)) is
>> less than the truncation start point, then shmem_free_swap() will
>> return 0 due to the "base < index" check. The code will then call
>> shmem_confirm_swap(), get the order, check if it crosses the END
>> boundary (which it doesn't), and retry with the same index:
>>
>>     index = indices[i];
>>     break;
>>
>> The next iteration will find the same entry again at the same index,
>> leading to an infinite loop. For example:
>>
>> - Truncating range [18, 30]
>> - Large swap entry at [16, 23] (order 3, 8 pages)
>> - indices[i] = 18
>> - shmem_free_swap() sees base=16 < index=18, returns 0
>> - Check: 18 + 8 > 30 is false (26 <= 30)
>> - Retries with index=18
>> - Loop repeats indefinitely
> 
> I think this is a valid issue. And it's worse than that, during the `while (index < end)` loop a new large entry can land anywhere in the range, if one interaction's starting `index` points to the middle of any large entry, an infinite loop will occur: indices[0] are always equal to the `index` iteration value of that moments, shmem_free_swap will fail because the swap entry's index doesn't match indices[0], and so the `index = indices[i]; break;` keep it loop forever.
> 
> The chance seems very low though.
> 
>> Should the boundary check also handle the START case, perhaps:
>>
>>     if (order > 0) {
>>         pgoff_t base = indices[i] & ~((1UL << order) - 1);
>>         if (base + (1 << order) - 1 > end || base < start)
>>             continue;
>>     }
> 
> This still doesn't cover the case when a new large entry somehow lands in the range during the loop.

FWIW, I'd have been really surprised if claude actually fixed the
bug...I haven't stopped the prompt from making the suggestions just
because I think it helps explain the potential issue.

> 
>> where 'start' is preserved from before the loop?
> 
> How about following patch:
> 
> From 863f38c757ee0898b6b7f0f8c695f551a1380ce8 Mon Sep 17 00:00:00 2001
> From: Kairui Song <kasong@tencent.com>
> Date: Thu, 29 Jan 2026 00:19:23 +0800
> Subject: [PATCH] mm, shmem: prevent infinite loop on truncate race
> 

I ran this incremental through and it didn't flag any issues, thanks!

-chris


