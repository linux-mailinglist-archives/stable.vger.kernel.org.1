Return-Path: <stable+bounces-121297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AEAA554F2
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 760D2188BA83
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E2226BDA0;
	Thu,  6 Mar 2025 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JeHJzQTC"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4725D542;
	Thu,  6 Mar 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285608; cv=fail; b=a3Mx3Ber+SP1Do7ErfEoRwtj3KRaFkrSLM2K8lxW0nt7J3osDOIJUHTidH9IHY3qJVmAe3Mh1iAeJs/Xvr2ISE7w2wmlf/J4v1MxV67WP6SJ2MBUNZENDtPDGs0PkTthGFG4LkdfWTTRfON7jLZGsh/f6yVpWehm2t8rWmst8Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285608; c=relaxed/simple;
	bh=diSwKF+yJRTlWDjwkyPqnZzwXstsAcVoQ7K4fbAJrz0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYyeNDIWxKUkS5m04fBa9DVeGQHYXLjMuwBqHsZIzeWPFMT3nGOp2+FSvIORse3htnmqAm/wV3Uycj2+U8sWqBi25r6hlXVF6WIVl9T1WeWVj2Utu433qdpK2SHtgc9YcQk0XEk/Hfh0LBVtxGL/+XaLCvNSjl5g6hUibKrswCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JeHJzQTC; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlDVoGPOpStuYaEs7f+m+HHK6VA1tFSPkwRgs54gGojiSHCT0hudbk0JcyW81ru7Zd8oPlcHcLqN7443nCKJY4fCU+dKjQk0lzgWZp/qYGOzSIwR15QsdNobaVOhY/zLIh9BFQlMMtuEPjj75B4Z7MhAgdCz5L9qgKghvzjc6BJ4CxobZVKmaY3OdVtSQeyvPkRdC9jgdInxF8E7McoZUQ1qJ9psXDVysd3Ekw22PLqUeJmbGCmPz40r4eunToTg3GOAkNnXLIRwU82ooC8iLjcqyhmGqfCQZwDXy1B0e3Rq4zGR5LV8CtAK/Jv7CJdluhH1Jq6VQgCCAGKMEcXeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnpKBO02keNzl3Z58x6RPZP7TqmDeBKQgpLzylHluhg=;
 b=nJvhrbS1JDpvtaeOGn0N0p6i1WrqygG6pv1qnqSHBNTa5urB3F198kH/h4J+7BZmMqurs/J2QnE5+dm/zM1KSy7sqyRAda8P+Kh6GSIn9QFa1OdSq0WC6jkq8myzMdoxlJuOtwtinlfEpS2Sk5S95FUU9eRi7o+jkV7gWFIfuK1TjPz3YxE5TSnzULg8hYWYvHdm/B6Wh10I1XWY6VBhr2Lf7CZmXRw18+0+1BMyJvcToTlKwfotCJaxZ+Ni/ixDbtWHtCSrkON026wWXae0jggTdOWpBo5fR5oBDAW+jrLAIHxn8C7yaU/obXF10QpUPrChiXP/I3jSZLJdGhQCQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnpKBO02keNzl3Z58x6RPZP7TqmDeBKQgpLzylHluhg=;
 b=JeHJzQTCbd2ueWFQLsYf+riHDMyVYwGQMkKuuM+KYMLEQk800nJi202kxv31A8b1iVqGxGzjqCY0FDIEaRjYZ5IoaX2LYW4x0yyxdGN3HMZrDQ+xFzyDTfmhkF+S18uQIkhxWgRa/88vdvG/m4V11lOVH0+20ME5j5le07/9jpcKX7cwpICXJOACEkaqY5ZmB51Pd8Vrf+ctGVOxmF91ITUJNagaisuM61Kbhz5by3er+BUL0rTubUgKXyzX9ugHwo+rlwbPMvxixi1iD1HrkDUGQnv8Gg6MlOxOraDOS9fSuLwOl4FugB/IMS4V7YRdadSb5wdtQlxACxkTfCTvtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SJ0PR12MB5674.namprd12.prod.outlook.com (2603:10b6:a03:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:26:42 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%5]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 18:26:42 +0000
Message-ID: <14620f80-33e1-4755-8178-5dc7e860689e@nvidia.com>
Date: Thu, 6 Mar 2025 13:26:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq
To: paulmck@kernel.org
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 RCU <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
References: <20250228121356.336871-1-urezki@gmail.com>
 <20250228121356.336871-2-urezki@gmail.com> <20250303160824.GA22541@joelnvbox>
 <14b61981-35ae-4f87-8341-b8d484123e56@paulmck-laptop>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <14b61981-35ae-4f87-8341-b8d484123e56@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0135.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::20) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SJ0PR12MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 048069f3-eacf-4f1a-09a2-08dd5cdc7152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NxazdUZ3Vjb2haQUpVL2dEaG53NG4yakMrUFBiZDF1VU5uU3QxelZsMUxk?=
 =?utf-8?B?NHRickp1Vmk0VXkrTmpwRTR5N1ZHODlxcUJiNkxqTjRiejVpTHZQUm0rRVl6?=
 =?utf-8?B?MiswNy9vd2tzdFh2c2ROSGdHcS83Uk1rdHZubnQ5SjF1Y0l3M2hBcy9CY1BP?=
 =?utf-8?B?MTBxMnBBb0VGM2wyaXBzZFFuL1JveG5rNGE0SmF6dU1TdlJIaE1HTWZsMWVI?=
 =?utf-8?B?WWFYcEVsNCttcEJ0aDdicjAwQzZGRHlyNmJzSGFiUlh0R2VrYU1wTjhTaHNI?=
 =?utf-8?B?dUl0QlNSQ0hGbjVuN001N2Y5TUh2MFNtV0w3VWEzaUNSZDBMZERNVENyeHlR?=
 =?utf-8?B?U1ZPdDB1ZGtIbTV1L25WdFFhb1NYUkQ1R0NWL2tLUEk3bHhCbFIrZGI0NWl5?=
 =?utf-8?B?cldCL25PRDQ2UXdWNnNVZ3JKaWM5blppZjdJdmZydVplQi84eWlsWDNSdnpl?=
 =?utf-8?B?Y3VDckdvd2hLY2g4YmxBZExvSzQvY2pvbUg0S2xvSGxSS3JpczJ2K2NHU01o?=
 =?utf-8?B?Y2hUVGlPM1lzYitVWHlsNlRoSE1IWFhFT0VjY09kYVFtNWxpYWMvZzNYSTJW?=
 =?utf-8?B?WVJsRHFUd2ZrV0pFY3BjQkh4dHFEZEgzV0Y4NTdZS1VxUFRDQ0J4WWp0Mlgx?=
 =?utf-8?B?WC9Fd28zbWtYQ3JmWXh3S3oyc0FHcndKdnpVSkVJMzh2cDZyaGdaQXpsM2dV?=
 =?utf-8?B?SEUzZExaRCtzay94M3lGdU40SUlmOVRMVysza0xjRE1GWkRmV1RNUzN6MVVo?=
 =?utf-8?B?Y0Q2a05HbVkweWJlcnVWa0pKTWdNQUlMUHRiMk1hM0VraVpkSElpMHpidkJB?=
 =?utf-8?B?Q3BrRWxBV1JUazhIemxaV24zbTBxY3RvU0ZyTUVZdmtSN2FoaSsyV0lNNzdB?=
 =?utf-8?B?eE5abDFBT3lRY2trRWtjdkZzZ0dmZmxWYkU3eTRyb0paZ3dicy9scW5FVkds?=
 =?utf-8?B?V0JOM1ZYN051WVFTRnI1QmtZdDRWS1FDWE5TOEM0YVhCZUVTaFA2b3lWWmFB?=
 =?utf-8?B?TXh5QnljUmVkMHZqZjgzWmRIOWdXbHNKZ3pPQXFMOGRxNS9TcTIyUldnNVVK?=
 =?utf-8?B?R2E5UU4wbmlvcEJxQzA0M2ZacDk5MTgwdUlENDEvQVJSaXhlbDFtVzRWS1Y4?=
 =?utf-8?B?ODV6dlpCQmtrUURTNmZnM0doMXJhNy9iUVhXWXlEbzlLS3EvcjJXY25LQ21j?=
 =?utf-8?B?amJjV0VPL0FBaXhSTmxUZys3T2g5dEFxc1N1aElKQS9FOFh1MWZ1cUdmcmEw?=
 =?utf-8?B?WHVrdnlmazlxdUZJZXI0c0w1a29aalA2MEpvMmp5RzIyeHZzSURoNE9NRXE1?=
 =?utf-8?B?UWhSWW5sT3pZZElaZitaSzUweHUxanY4MHRXdWhOWEtxNExxSjJXTU82Vm03?=
 =?utf-8?B?UDNGcDhXSWpER2poSkVod1NZblBrZnRCVVl3cCsxYklWMW1ZbHg2dnpCYzVa?=
 =?utf-8?B?cTViSHFOK05hQ1RNaE1FS2p1Z0o0V1plZmVTSGJ3NDQvWTNsckJNL3R6WmFK?=
 =?utf-8?B?S1RXWHcxc09KKzFDZjFmMUZxT2RuTHNQYk1xMVFxZ0lTeHprWWJGczBXOERr?=
 =?utf-8?B?YVk2dmIyMWhFV1Bhcitub3NVZFVRY3RQWE5mRXN0aWJVS3B3VmRObU1YQ3Zz?=
 =?utf-8?B?R1Zyb0piN0dBL3k0cm8xTkZjRmhQSWYydmpBS1BWQlArN2VRdG5mcnVlMVNv?=
 =?utf-8?B?cmxlZE5DUHlwNlludTkyd0J2Wk0xTzRRdlE4REJjU3VzUDQ2Wk9vUVZPcklr?=
 =?utf-8?B?RGlDNU9LRmR4WllZRTR2SjlRTXZpUlFpNmhSTkpKTWtWaTVKSzYvaERDWVYr?=
 =?utf-8?B?M2E2MGNIWUoydjBJK3F0UFRZR0llbnNwRUpqeWlPM1RCUVJJcEJWMXdyRjV0?=
 =?utf-8?Q?40TAiY9hC1pDP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2wzb1pIanJQb1JNNDcvdjh3SldYQVlPWEdtM1pZczNPamx3emxWTnl1ZGoz?=
 =?utf-8?B?U1dud0JLb1NBeEZEcmFxVUdYSTk4a0Jmb0k4aWEzRXA4ai9tZU1PaGNqeFlS?=
 =?utf-8?B?clVNUFJVQ0lORENzQ0pCcUYySnZ4aXdkaGxVelA0M2VpUk4ycENHRnZtN1h4?=
 =?utf-8?B?WmhoN1BsL1BUWGdnTjhRTDRKTDZIUjVENW9rY0ZnVDl0L1Y4TEFBTzZQMUJ6?=
 =?utf-8?B?YTB2eUErK0xYTjdkNUgzb2ZTNDM2VHFBemcyV2N6ZUdBUWRWUldRUVpmQnI5?=
 =?utf-8?B?UnQ3QjZwdlRVTFQ3SUhjK3dERWFsVGl5eHExSEFYUWQxQ3J0YWNpTDFZZWx5?=
 =?utf-8?B?eTIvR2hvQjNBVHRkQnBTNVpFenJlWUJXR2Y2dlY1VC9BNUFSb2xtTlRXUTho?=
 =?utf-8?B?d2lvRExtRExJdFYveWNxUTd1THZJUy9xOFVUeEYvcDIzQ3psS29YN2xKMVZp?=
 =?utf-8?B?Q2RzRzZtOWJnakxjTEJKRFFIU2d5MnNpS25Ha2pKdHhVSi8zd0VaZHRGWHB4?=
 =?utf-8?B?ZzBPUlpFVWRpc0Y0Z05vZS9wcm1XRnpZdktGVVdRdVBNR1pmUTRyb3NMUFNT?=
 =?utf-8?B?TlI2dXE4bjRsSzQwVDNrcG41a21MbG41RjljVWRpWU12eXR0dGN0VU9ZOUdU?=
 =?utf-8?B?UnRXYUJEUWNTODQ5WUpvd3I2K3RORmJEQTk5YkgvWk5vQWJ0dzVrc3FsRVlD?=
 =?utf-8?B?ZXBMNkNIQW1EU21UNERVK0p0ZnlrYW9QK0VTeXYxRHBEL3Q5MWF5Y3hYK0pW?=
 =?utf-8?B?SkdXSms3dzB1a0FkaHRrdDVTTVdTNVJ5RGhWVUIySHFGdWFoa3UvUEpaMW5o?=
 =?utf-8?B?R3ozeXpjcHdjRnEySU1aeTVNcitsYVRoQVdIRDBEdm5xaHcrdGNrTkU1bHhk?=
 =?utf-8?B?UHZXOEwxa1hEZndSOVh1MExxYUZISEU1WUVmWE9NOFVHaEl2Q0FoTHI4ZU9J?=
 =?utf-8?B?N205MC9TdVM4Yk5FREhrdVFIbWVQdzhPNVpPcTE0S2gzdU9zaHVvSjhML2w1?=
 =?utf-8?B?RjFnK2tvNUFMeXlSWEdQblFiaVBnL1BoZXAvUjQyVFViUFVOMzVSNkxWa2wx?=
 =?utf-8?B?bXY1bWFXZEtTcS9lbUZNRkJWQnhaam5CTnhORC9mUk1ZT1JLbzk2NjIwTEhV?=
 =?utf-8?B?Q2RJU1ZKUG5nV28zcFA1ZldlWTF6WUM1MVF0UHNLL3lnS0Yyd1hrYlhTNmNt?=
 =?utf-8?B?U29qbytVcVNJT1JwQjd1bTNxSnI1Q1BhUHZLWGhONTdKZzhmSjByNUpVMDNp?=
 =?utf-8?B?ajRqRDdacDVEMDhBRFdjTXV1NXc3Q3BGK25ZY1k5ZTdsMzZKaGVxdEVUMlRq?=
 =?utf-8?B?WXJlTm9HTkVJL0FOVHBsSVVHUkRBYTA3bDlUaFlaWVh2VGk2VGNLQ1UydWZU?=
 =?utf-8?B?azBMMkdIY01XSTJoL2ZrUktlWjJZTmF4Y3lneWJEa2JJR3pBa0ZNU1hxTXBP?=
 =?utf-8?B?SnpoeFl6aEZPa2NZS2hKWnc4bU9tUENOMDVBcGZEbmpNYW8rZGNaL0QyYWds?=
 =?utf-8?B?UU5kTVA1aVl0dEtKRCt4Zk8zRm14Z1JPMnlXMURLZGR0QnBBLzlEelFZcHht?=
 =?utf-8?B?bzhGK05yNy9oc3Zta2wxSkdtbGs3SzRaMDZDYWUvVWxyUDRUd3BsUXZFVmZN?=
 =?utf-8?B?YXNFdlk1Njl6OXBCZGhBSDFubzJrQ0Z4aUovemJnVExoNXliNjdtUlVLaUJ6?=
 =?utf-8?B?c1lDV2RFZ3Z4MnE4RVkrajBSWlFHTlhDbUM2VHkxUFVMSGFmb1V1bW9LRHZ1?=
 =?utf-8?B?WHhkRzNLc3EySjlkVTg3cWNDd1hkd2xiU0VNM3c4WVNRMmlPTUt3WWZralcz?=
 =?utf-8?B?YU82cnpVV0R6dU1zY1dFdmJ5UTRsUXFXUDN5emRuRXBXdDBIb1Q1a1V1cStI?=
 =?utf-8?B?WWMzbVN0cjM1ck1CTGxGSWprVWt6cGhLQkpzMCtaeHY1Y3NGWG1uWG1sUHda?=
 =?utf-8?B?MXNWZGIwSFhLOGtmMVVVNE1pQ2h5Znk5YVE5MHptbDVwTHVobVN0Z09rSURM?=
 =?utf-8?B?Mm5WRUZIVkVKYnBTQzVMZjBvWG8rVFd5REVMM0xvS1BRVUtJem5TdVdWNm1a?=
 =?utf-8?B?YnhjMUU2MlhJazFjc1FrRndSVm9MWDRGWTUxWUJmeGRBRHJjZ2dxcGtnVzgx?=
 =?utf-8?B?Q3FLN0VlNkRzRmd3OXdMVmhiNkdSbC9DOHV1amZWNzN1R04wakQvd1JWdzlw?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048069f3-eacf-4f1a-09a2-08dd5cdc7152
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:26:42.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76HeNFs9FtmDwAXxoROxRvdvYZ4oh11Di2XeujvlomA7f4bsS7/146BYzeC3iGnILv4a05+X1MxExdSdRY2wAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5674



On 3/4/2025 9:55 AM, Paul E. McKenney wrote:
> On Mon, Mar 03, 2025 at 11:08:24AM -0500, Joel Fernandes wrote:
>> On Fri, Feb 28, 2025 at 01:13:56PM +0100, Uladzislau Rezki (Sony) wrote:
>>> Currently kvfree_rcu() APIs use a system workqueue which is
>>> "system_unbound_wq" to driver RCU machinery to reclaim a memory.
>>>
>>> Recently, it has been noted that the following kernel warning can
>>> be observed:
>>>
>>> <snip>
>>> workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_scan_work is flushing !WQ_MEM_RECLAIM events_unbound:kfree_rcu_work
>>>   WARNING: CPU: 21 PID: 330 at kernel/workqueue.c:3719 check_flush_dependency+0x112/0x120
>>>   Modules linked in: intel_uncore_frequency(E) intel_uncore_frequency_common(E) skx_edac(E) ...
>>>   CPU: 21 UID: 0 PID: 330 Comm: kworker/u144:6 Tainted: G            E      6.13.2-0_g925d379822da #1
>>>   Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM20 02/01/2023
>>>   Workqueue: nvme-wq nvme_scan_work
>>>   RIP: 0010:check_flush_dependency+0x112/0x120
>>>   Code: 05 9a 40 14 02 01 48 81 c6 c0 00 00 00 48 8b 50 18 48 81 c7 c0 00 00 00 48 89 f9 48 ...
>>>   RSP: 0018:ffffc90000df7bd8 EFLAGS: 00010082
>>>   RAX: 000000000000006a RBX: ffffffff81622390 RCX: 0000000000000027
>>>   RDX: 00000000fffeffff RSI: 000000000057ffa8 RDI: ffff88907f960c88
>>>   RBP: 0000000000000000 R08: ffffffff83068e50 R09: 000000000002fffd
>>>   R10: 0000000000000004 R11: 0000000000000000 R12: ffff8881001a4400
>>>   R13: 0000000000000000 R14: ffff88907f420fb8 R15: 0000000000000000
>>>   FS:  0000000000000000(0000) GS:ffff88907f940000(0000) knlGS:0000000000000000
>>>   CR2: 00007f60c3001000 CR3: 000000107d010005 CR4: 00000000007726f0
>>>   PKRU: 55555554
>>>   Call Trace:
>>>    <TASK>
>>>    ? __warn+0xa4/0x140
>>>    ? check_flush_dependency+0x112/0x120
>>>    ? report_bug+0xe1/0x140
>>>    ? check_flush_dependency+0x112/0x120
>>>    ? handle_bug+0x5e/0x90
>>>    ? exc_invalid_op+0x16/0x40
>>>    ? asm_exc_invalid_op+0x16/0x20
>>>    ? timer_recalc_next_expiry+0x190/0x190
>>>    ? check_flush_dependency+0x112/0x120
>>>    ? check_flush_dependency+0x112/0x120
>>>    __flush_work.llvm.1643880146586177030+0x174/0x2c0
>>>    flush_rcu_work+0x28/0x30
>>>    kvfree_rcu_barrier+0x12f/0x160
>>>    kmem_cache_destroy+0x18/0x120
>>>    bioset_exit+0x10c/0x150
>>>    disk_release.llvm.6740012984264378178+0x61/0xd0
>>>    device_release+0x4f/0x90
>>>    kobject_put+0x95/0x180
>>>    nvme_put_ns+0x23/0xc0
>>>    nvme_remove_invalid_namespaces+0xb3/0xd0
>>>    nvme_scan_work+0x342/0x490
>>>    process_scheduled_works+0x1a2/0x370
>>>    worker_thread+0x2ff/0x390
>>>    ? pwq_release_workfn+0x1e0/0x1e0
>>>    kthread+0xb1/0xe0
>>>    ? __kthread_parkme+0x70/0x70
>>>    ret_from_fork+0x30/0x40
>>>    ? __kthread_parkme+0x70/0x70
>>>    ret_from_fork_asm+0x11/0x20
>>>    </TASK>
>>>   ---[ end trace 0000000000000000 ]---
>>> <snip>
>>>
>>> To address this switch to use of independent WQ_MEM_RECLAIM
>>> workqueue, so the rules are not violated from workqueue framework
>>> point of view.
>>>
>>> Apart of that, since kvfree_rcu() does reclaim memory it is worth
>>> to go with WQ_MEM_RECLAIM type of wq because it is designed for
>>> this purpose.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Keith Busch <kbusch@kernel.org>
>>> Closes: https://www.spinics.net/lists/kernel/msg5563270.html
>>> Fixes: 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_destroy()"),
>>> Reported-by: Keith Busch <kbusch@kernel.org>
>>> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
>>
>> BTW, there is a path in RCU-tasks that involves queuing work on system_wq
>> which is !WQ_RECLAIM. While I don't anticipate an issue such as the one fixed
>> by this patch, I am wondering if we should move these to their own WQ_RECLAIM
>> queues for added robustness since otherwise that will result in CB invocation
>> (And thus memory freeing delays). Paul?
> 
> For RCU Tasks, the memory traffic has been much lower.  But maybe someday
> someone will drop a million trampolines all at once.  But let's see that
> problem before we fix some random problem that we believe will happen,
> but which proves to be only slightly related to the problem that actually
> does happen.  ;-)
> 


Fair enough. ;-)

thanks,

- Joel


