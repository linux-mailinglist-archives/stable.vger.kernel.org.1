Return-Path: <stable+bounces-254470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOerKg5fFmrelwcAu9opvQ
	(envelope-from <stable+bounces-254470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:03:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F475DEC85
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2C4300C92D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9803612F5;
	Wed, 27 May 2026 03:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="TdHzG239"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9023363C5A
	for <stable@vger.kernel.org>; Wed, 27 May 2026 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850900; cv=fail; b=h3k1B99sVBffcAkOQjTJgPv9fRQK43a8pgEpiDJK5O3g+C5LEViv26VilBIfTeNtt1hb3t/HA3cBG0a0n9lB9YTSrfQ7f562MfTcrXW55slzpiLyNztEZldD6VN6Aq23H8FORA8KpGl35H0UlNuwufWqNGGtb8V4UW564S6Khx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850900; c=relaxed/simple;
	bh=6Nr2SxvG13QpR8MReYURctJ9Zput5PDhLhuTBVfspMI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HpiZfamX4baDCwH4KzNYTOi56KZLt/IQFh3xyhIi8w+6udvkcZLYBu8X2suNxi6AXEJLiEgxChF3w1rYuG0kkZXlRePXkIxgyRqu/XFq2i+Orff4RieJR5AGAyMKKPsNej087hER/ypPpeZh8gOGkw+nLATJdKomLsOXvGCb5bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=TdHzG239; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R1veSN2143719;
	Wed, 27 May 2026 03:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wNoAr/lqtN4qXWwf5jgAuCnC6Ujp45XgsTXxqKl23tw=; b=
	TdHzG239tEgF7FqK+njpipJIIaybk6HZODyvtkk7BwkByYedv0QH5kTu0b8QWEJL
	A6HrcpU8uywJnLKrU6v8Pt5TtXibt+/95tRdzixXAJ5iyumky6dFf66T//Omsico
	wjlsu8SRqb95i6C/41S/1BJ3B9z9RybIrpadupsswrJFzX/wEKsYlUeLqAGww5zE
	2sXKl8QIUNhZkO3noxF87hRIRwGoZybK/HBbQb94xneFphdozHldFf7YZlb1sotv
	MN78fqtaIyOiOySLgpLOLu+kV4PzQ6ZFVWDNuiDKjfkH8ApLUAh9WM9eJmHa8MZ3
	ivwTa2w6F56Jma4pHW3Bhg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010034.outbound.protection.outlook.com [40.93.198.34])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eb1f057v7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 03:01:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCke8gBMhmOAnU8hlH1XeFeOysuWefdnYvP8i+vPqvgwJ2CEd3sdIP42yeOh9xVQnNLNHWdeby3Ixp9zwiwOeenG1oL76FhVaQ/ohfppTYDogSZJ7UiOTZykn+LPk5jX+Umnkh5jHwRJnDm01OgyMsEydAzeav3p1eymV8PwZCk582FNVqLLYZ+DpaBNn2pqt/a81X2P/IN38znwHSrk+r6q8Bjl3lQRcgGY1iY3QNPEjUvX/4Zb8puQZFu3sYFBMyZUZM5Ua2Qs8ptKlx7TA+HM76AmvVz4KKJfPOU3eafFU0I0qjMqR5dfqpKxnqVClKMx8SpzZArTcUm27R11/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNoAr/lqtN4qXWwf5jgAuCnC6Ujp45XgsTXxqKl23tw=;
 b=hyVx9eQ9FDGazQn6cQ6Rk0LZ5a+1larRufumB/9JKLzfdk8D36fadLcwGsYoEm1BHLHuZNfv5fHfozrzg+XuxDRIbdWvqOox4q0ihUH14W54tKfVmgKFc5dRE2OsvVszwHedtf23o4aQtxsO3MgtrRMUbHWz4K1A3XL35/vjYHw/J4c0aGGg5tqUswThKkqOMX1fUIEmt0tbOnnc4QdmzJGlbmi6KQ9+7zbwbg9NCwczI8XjntCJqPhxXCVVGrSvYM4PTFSBIGji7Ull2Twbyag622XvoX/e16pN9uDB59Er8S3CF9sLttyIOyxzsLGn48xuIbq4LoPJFjosT3APOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26) by SA1PR11MB8838.namprd11.prod.outlook.com
 (2603:10b6:806:46b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 03:01:10 +0000
Received: from DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6]) by DS4PPF641CF4859.namprd11.prod.outlook.com
 ([fe80::794e:2099:77b9:92f6%6]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 03:01:10 +0000
Message-ID: <3f1485f0-905b-4c5a-bd66-fb03aa9ea0cb@windriver.com>
Date: Wed, 27 May 2026 11:01:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 1/1] arm64: io: correct user memory type in
 ioremap_prot()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, stable@vger.kernel.org, gregkh@linuxfoundation.org
References: <20260520091337.3799553-1-xiangyu.chen@windriver.com>
 <20260520091337.3799553-2-xiangyu.chen@windriver.com>
 <ag3o-RbDTQWWazwF@arm.com>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@windriver.com>
In-Reply-To: <ag3o-RbDTQWWazwF@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY4P301CA0057.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::15) To DS4PPF641CF4859.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::26)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF641CF4859:EE_|SA1PR11MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 05c14605-03b6-4a38-a78a-08debb9c343f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|3023799007|5023799004|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BZBqCWDCI7Y8L4+sYqYv+R2hrfPU6ycg7WqNlSmI7XQ0mdd+ioL7aQTC0JQfkE1xWQJzLWqj3vVSV/QzHuTold0Xn8tbztY9BPvop11cDbSiDj6p01Bp4RimxO10kxavH6p6pHC9NxqvbKrc9KPvNkXBV0FCwQbwf6H7K8eF7yczSmHrb+3qsEULJ7ECyDDa0PBJJcHp2tIYwTaYbpXxcYYxc6Ol+RmInQN1pnkBliCsiYF9EoPTvHKVdhGgCvUlCN2ShVsUT7TwfMd8mRyTVW7cmtrpQwV3wKs9KUFd3A41liKLzTcS63krDu51O3nNfzKkxZQ/5ew2zM+mbzKlsEqG+3gG0PCfDdGdFKUAPs8mRsJ3mGvdsFvIkxe1Nb0QyrPVl31CchfX/9Tv9VzEZwkMYNvJuN39orrJYIa590VonE2ItIlkQlp95WMslIeT4q71ULCLUUbDMJA2wJ26/JaZK1W1/PPcpAuVR2VbThHvPwM29iwaWvxP/Lm06ALsPr5zOPcjNBDl6w9ppxCGWJBWYDwKhuCnrQOVpAEztvPx5xZ873cXfa6WYVtDM2ioVnISY93v3WprMlipxSSyfDnImXbAFc3bmsv1/UKZ6zr/SMVNMT1q+R/63IZiW/4pSI0ltK7lW/ueGUb3rdP3Xr6ruE2n3pw3YM05ZJG4qD5ArHWLp61rmxjo+pw3Lwwm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF641CF4859.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(5023799004)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU1pazlJaVB1bHRVSkw2L2dKZEdDRXh2YW5Vdjc5REpadTI2TXJaZTJRWlph?=
 =?utf-8?B?aStkMFJiSi9sVkg3UjF6Qk9PcEc1Rnl6blhucFJqYno0UE1LZjNMZ0RCNmd1?=
 =?utf-8?B?Qk1CbEJIaHVRNmsrLzhNU3R0L3E5ZnZLVkx1d1k4Zi9xaWZ3eXlselNiTDR0?=
 =?utf-8?B?RjEyRW05OElObjdwUWpJT3ZBVFJmay9uVm41K1VqanJjSWlScXhGSUdxeHFB?=
 =?utf-8?B?cGIxckRRcHo5ckVMUGRETVYyZmozOXFCMExvNldZYUtjdFlyK0Q2V01TSCtS?=
 =?utf-8?B?S0YyWC9sMFlUSTlicVRkajQ3bUxLMTNxZHpTKzNiOGJpa3I3WnYzWnlBWUpu?=
 =?utf-8?B?eDcwQWFERDBiOHU0dXBBQkwvd1lvcjRnZ2Z6aFRUNksvVExwSytHVmJqL29G?=
 =?utf-8?B?T0xjOHVrZXdGR0FjNjF1ZlQrbDhXRVgvcHk5a2h2T2lnTjZibVB2QlhTODdz?=
 =?utf-8?B?L3lrd3FhTHpBR05rakg3VkFpT0ZhaU5yNWp6RmtKb0FtamNDcmFpdkROdDl1?=
 =?utf-8?B?dUk5eFhtS3dXYXBQYTc5N1NGSzRkOGVHa1pnY2F1UHQzSEV0N1c0aFJqYzMw?=
 =?utf-8?B?VE85K0xYV0ZONDZJWkdpOG03d3RZMDZaYWphZmxhQXF4RXBTdUhWdWVHN3lP?=
 =?utf-8?B?aUt4SkkySHA2Vk1TV29CSWJEbkRVMFVlOWtsOGwrdG5WZThFQk8xVEFjMTJh?=
 =?utf-8?B?ZTh2dGl3U09kMEtmYXh6eTl6QmxzM1Bma0lFdXV3N200L3B3M2J2Q3lpUUhP?=
 =?utf-8?B?Rm41TVZCMHlxL052ZG51OHpEVzF4ZGFWNnZvYk5iVGoxcWRueFpiNUhOallI?=
 =?utf-8?B?OVFIZ3BHVFRRN1h2bVZKeFRKMG1hd3BaOWx0Rld1RlQyT2FaQWFQMXhmN1Zh?=
 =?utf-8?B?dzVlU2ZGZUQ3V3ZLQ1pqbS9FWFZUMlQ4WmRmaktJcGE5Wld2S282S1FsNXJV?=
 =?utf-8?B?ZnYzWUhrWlJEaE9LSC93VHp0SDhZb2NsSGhXMHByNjZvbm9GT05UOW1CMENp?=
 =?utf-8?B?KzlTRzg3VkNpNTI4VGdzOTZmWnI3ZjVzZ09xT1VOaXFDUEpsc1lGWWdaZ1c4?=
 =?utf-8?B?WEMybzhRUnpnTWVOcUdGUVVYc1h2VGJmZ01BRXNBSEovL3EvQStHQk1IR3BW?=
 =?utf-8?B?cXlTK3hkVVd0S2w3bmhLVmwyZTF1S0ZQOUd1d25tZTlUUjRSa3ZzY2VUTllY?=
 =?utf-8?B?ay94amdpc1Rjait6YnFxOWhKZjZ0UnA4SGVNYmdrbmRvS3VhNUZqQmFyM0xF?=
 =?utf-8?B?RzJTSXhkN2ZYT1JwbklLODBJdEl2b1BHc1lrdnNxRy83aWtCeG9vZFhZcmlJ?=
 =?utf-8?B?Y3BsbEluQVFvb3N4TC9oWkJIQ0tUVjJFWXNvVGNlSGJQUUhlZkxIQmRJblVE?=
 =?utf-8?B?UGMzTTZ4VHVUQkZJMm1xajBlNUYzSHBJaFVHWjVDcDBEM2dyV09HS2ZUakdD?=
 =?utf-8?B?OVFCRmxBQTU1SURGYVF5SVBvcTkzSmdVQ3B0VUV1amxNMEJnT05jZWIxL1lu?=
 =?utf-8?B?Ry9RVjhnOExpRWJhSUx1RENiMEtaM2Nkdk5oS2p5Q1hWZytPSXlEV3YydHJR?=
 =?utf-8?B?OGhQSmRVS2QvaERxSWVQbkFTeURvU0k5aHk4QWUxWFNWYjlQdDVxQmtLMXdV?=
 =?utf-8?B?L1pTM3lzSzZHcklEMjZ0UFg4aThHNDRGWnB4ZEFuNk5ER2w0RTdBemEzNHp3?=
 =?utf-8?B?dWR4c1ZMc2l4YnVzbERtckdLY0gzVUVpSS9ueGltcDVoc1M5WGNJQzdOc1Rl?=
 =?utf-8?B?S0VESWNoa2k2Ty9qaHdLa3hxcVV4aGZKMnpHVDNTMkIza24rODh4L05WemUz?=
 =?utf-8?B?NTh3VGRWQkl4Wm8xdDdvbklxTVVkU2ZFV1VobWtOZFBVOFZTN1QvdVdja3J4?=
 =?utf-8?B?NXFYcmNzdEVIbUluYW0wREhKUnpxb00rYVR4VlJRclRrZ1lEdE54Y29KMGxx?=
 =?utf-8?B?c2tuak44SldKSmtkOE1jMzY3eUtMbmJNSExKOUtqR3QwQnVtZi9zT25RTzRG?=
 =?utf-8?B?aGswb3hhUW9ZZlByeWE4SFZ5dzhoZFZEOHNFSVBhWHhqMVJoSFRySjdVSlY5?=
 =?utf-8?B?czRzMFA4d0lmby9RU1o5WGVjd2psZFl2SU92dEo3Y2NvSlE3WWVTbC9QdVJU?=
 =?utf-8?B?cG9jaW13T2NTODNXNHhCelJKYU1JWjU2blZiQ1NwODd0bmdzTHo4VU1vaEp1?=
 =?utf-8?B?dllWbGlrZnQ3cFozNDQxbi9iV3lWcTNLYk0yeU9XTmNlYlpnU01VNEQxM2h0?=
 =?utf-8?B?WGZsTHRaQU0zRXhHSFp6WnFzajh0N00yQ3pJOEg4YVVvK3UrenpjZFVkME9Q?=
 =?utf-8?B?cGxHTjlROWk3MWtBYVNqQmFBc2FBcEw0U3NwR3pGU3pSMFBIcjFMa2pFM3Bp?=
 =?utf-8?Q?CUJW8xqTMnUh2ggo=3D?=
X-Exchange-RoutingPolicyChecked:
	ZEzo+lEKhdXPlclDHiWZ22ukndNzfKgJkszj63rlZtiDPsyGe8y+C6PU+o3oAarL65PSarwVhyAjAWeOmEqyjZQIQzEcdbtCYz8dxZPD3aT3EOOUleAItgsxcFYnfkGQstIebiTRKmGsMsDKIH8rMV34ioGPiACfnwPiEc0yytX06BhQjJnHWV+os1PiZ05A4xIswvsSw0duRV97C3WayWHI4AlyGA9kAJbdD+SBOZXVqocTWJiGYyKsy/bBQptMPMeuub/FNEQ+Adycd0SEKzf+qwzoI2KdhXXEf9QsbyvGD+JFCA4gRHx6aIlz7LXlPwjHRXPXLS0TNP0EIYRu8A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c14605-03b6-4a38-a78a-08debb9c343f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF641CF4859.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 03:01:10.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBmiJKX9CI366vfw5NIwuK6DkEYCOXceNwQ8jzK/YkhEIhE4bDmQEUzA+J9x4hDpvsVPxAFWIKg98O7Fyl7cc/fndp+Vd5fRN9uxjdXqVqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8838
X-Proofpoint-ORIG-GUID: DPObyAqugG0uTB_U7luewO5WnKnluU7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDAyNyBTYWx0ZWRfXzndqXF/CdGAZ
 yjprQ9BxRJtQ93+hL6NcJZ4V+rw74Y9M/pu47+j6M/F5TibN9+RxsCyHQySKxi7nTGL7Tw3x9Cc
 gmB+usZPQzoLuw1iNX+B7LfhYijIWeQRocWSwhLIh1sqbG+2p3Rqxflz6rjcNGe34TLUm1cphey
 um0ip8hm/FYtkQfYrK0EJ23swvc3b9fQLDaSYEsZEfKobOYsJ6U9HNuKl5+UK69aZ8eKja8ubYb
 WdzSR93qwuthKcpyFgcl1LfJlNbLAhfcqPzxNsPOSQBJCEnCjG5XPiwNBLpt4XQowG8SPu1TIIS
 niOjFgY6F8CKMp8a5MmmnXnnnaGSu9w1Du0svPM7TvC1QxWSmAyaFngFLjCje8LT1AxRGhIIWFe
 lImC9xnpnkFx9wPLzlGIOgI37775dBvEPVM5dslZ+E3mjAoMLfFN4hqYq1kgwAQdWLpqo7fHo3+
 iaduiufqIchE/OwTBQw==
X-Proofpoint-GUID: DPObyAqugG0uTB_U7luewO5WnKnluU7F
X-Authority-Analysis: v=2.4 cv=PZXPQChd c=1 sm=1 tr=0 ts=6a165e7a cx=c_pps
 a=sh6lJpoQSmOZbBTv2jax/A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=7CQSdrXTAAAA:8
 a=Og1Fg_hJh15hFA4d6oMA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270027
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254470-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:email,windriver.com:mid,windriver.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiangyu.chen@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 22F475DEC85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/21/26 01:01, Catalin Marinas wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, May 20, 2026 at 05:13:37PM +0800, Xiangyu Chen wrote:
>> generic_access_phys() passes a 'pgprot_t' value determined from the
>> user mapping of the target 'pfn' being accessed by the kernel.
>> On arm64, this 'pgprot_t' contains all non-address bits from the pte,
>> including user permission controls (PTE_USER).
>>
>> When a process attempts to read the target memory via cross-process
>> subsystems (such as reading /proc/<pid>/mem or via ptrace), the kernel
>> re-maps this memory using ioremap_prot(). Since the PTE_USER bit is
>> incorrectly preserved in the temporary kernel-space mapping, it triggers
>> a level 3 permission fault on systems with PAN (Privileged Access Never)
>> enabled, resulting in an immediate kernel panic.
>>
>> Upstream already fixed this issue in
>> commit: 8f098037139b ("arm64: io: Extract user memory type in ioremap_prot()")
>>
>> Directly porting the upstream patch's macro changes inside <asm/io.h>
>> creates circular build dependencies due to the architecture-specific
>> GENERIC_IOREMAP refactoring introduced in the stable kernel lifecycle.
>>
>> To bypass header dependency traps safely, this backport confines the fix
>> entirely inside the implementation layer of arch/arm64/mm/ioremap.c:
>> 1. It uses pgprot_val() to safely unpack page properties into a pteval_t mask.
>> 2. It introduces a targeted safety check (if (prot_val & PTE_USER)) to
>>     selectively strip away volatile user permission parameters.
>> 3. It maps the memory through pure kernel attributes, leaving standard
>>     peripheral device drivers completely unaffected.
>>
>> Tested-by: QEMU ARM64 (Cortex-A55, CONFIG_ARM64_PAN=y, /proc/<pid>/mem read)
>> Fixes: 893dea9ccd08 ("arm64: Add HAVE_IOREMAP_PROT support")
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> Instead of re-implementing this, could we cherry-pick the prior commit
> renaming ioremap_prot() to __ioremap_prot() throughout arm64? It's not a
> straightforward cherry-pick since we changed the prot arg from unsigned
> long to pgprot_t (across multiple architectures), but with some minor
> tweaks we can get the patch below. After this, 8f098037139b should apply
> (hopefully unmodified). Please give it a try:
Thanks for your suggestion.

After reviewing the code, it appears we cannot directly backport commit 
f6bf47ab32e0 ("arm64: io: Rename ioremap_prot() to __ioremap_prot()") to 
older stable kernels. This is because commit f6bf47ab32e0 depends on 
commit 86758b504864 ("mm/ioremap: pass pgprot_t to ioremap_prot() 
instead of unsigned long").

Therefore, a clean backport would require the following sequence:
Cherry-pick commit 86758b504864 ("mm/ioremap: pass pgprot_t to 
ioremap_prot() instead of unsigned long")
Cherry-pick commit f6bf47ab32e0 ("arm64: io: Rename ioremap_prot() to 
__ioremap_prot()")
Cherry-pick commit 8f098037139b ("arm64: io: Extract user memory type in 
ioremap_prot()")

However, the main roadblock is that commit 86758b504864 introduces 
significant architectural conflicts on older kernels like 6.12 and 6.6 
due to context changes. While I could manually resolve these conflicts 
to pass compilation, the patch touches numerous boards and CPU 
architectures within the arch/ directory. Since I do not have access to 
these boards for verification, forcing this cherry-pick carries a high 
risk of introducing unforeseen regressions into a stable branch.

Reimplementing or hacking the fix for older branches might similarly 
jeopardize kernel stability. Given these risks, I suggest we keep this 
discussion archived in the mailing list rather than merging the patches.
This way, if other users encounter this CVE on older kernels, they can 
refer to this thread for a potential workaround or solution for their 
specific systems.


Thanks,


Br,

Xiangyu

>
> --------------------8<------------------------------------
>  From a38c5529973892914c1c967d43a2abcdcd9c6287 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Mon, 23 Feb 2026 22:10:10 +0000
> Subject: [PATCH 1/2] arm64: io: Rename ioremap_prot() to __ioremap_prot()
>
> commit f6bf47ab32e0863df50f5501d207dcdddb7fc507 upstream.
>
> Rename our ioremap_prot() implementation to __ioremap_prot() and convert
> all arch-internal callers over to the new function.
>
> On this 6.12 branch, ioremap_prot() remains as an exported wrapper around
> __ioremap_prot(), since the generic ioremap_prot() prototype still takes an
> unsigned long protection value. The wrapper keeps the existing behaviour and
> will be subsequently extended to handle user permissions in 'prot'.
>
> Cc: Zeng Heng <zengheng4@huawei.com>
> Cc: Jinjiang Tu <tujinjiang@huawei.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   arch/arm64/include/asm/io.h |  7 ++++---
>   arch/arm64/kernel/acpi.c    |  2 +-
>   arch/arm64/mm/ioremap.c     | 12 +++++++++---
>   3 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 1ada23a6ec19..e6ad41131d80 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -274,15 +274,16 @@ __iowrite64_copy(void __iomem *to, const void *from, size_t count)
>   typedef int (*ioremap_prot_hook_t)(phys_addr_t phys_addr, size_t size,
>                                     pgprot_t *prot);
>   int arm64_ioremap_prot_hook_register(const ioremap_prot_hook_t hook);
> +void __iomem *__ioremap_prot(phys_addr_t phys, size_t size, pgprot_t prot);
>
>   #define ioremap_prot ioremap_prot
>
>   #define _PAGE_IOREMAP PROT_DEVICE_nGnRE
>
>   #define ioremap_wc(addr, size) \
> -       ioremap_prot((addr), (size), PROT_NORMAL_NC)
> +       __ioremap_prot((addr), (size), __pgprot(PROT_NORMAL_NC))
>   #define ioremap_np(addr, size) \
> -       ioremap_prot((addr), (size), PROT_DEVICE_nGnRnE)
> +       __ioremap_prot((addr), (size), __pgprot(PROT_DEVICE_nGnRnE))
>
>   /*
>    * io{read,write}{16,32,64}be() macros
> @@ -303,7 +304,7 @@ static inline void __iomem *ioremap_cache(phys_addr_t addr, size_t size)
>          if (pfn_is_map_memory(__phys_to_pfn(addr)))
>                  return (void __iomem *)__phys_to_virt(addr);
>
> -       return ioremap_prot(addr, size, PROT_NORMAL);
> +       return __ioremap_prot(addr, size, __pgprot(PROT_NORMAL));
>   }
>
>   /*
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index e6f66491fbe9..a99476819e6b 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -379,7 +379,7 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
>                                  prot = __acpi_get_writethrough_mem_attribute();
>                  }
>          }
> -       return ioremap_prot(phys, size, pgprot_val(prot));
> +       return __ioremap_prot(phys, size, prot);
>   }
>
>   /*
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index 6cc0b7e7eb03..ca008a4732ae 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -14,11 +14,10 @@ int arm64_ioremap_prot_hook_register(ioremap_prot_hook_t hook)
>          return 0;
>   }
>
> -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> -                          unsigned long prot)
> +void __iomem *__ioremap_prot(phys_addr_t phys_addr, size_t size,
> +                            pgprot_t pgprot)
>   {
>          unsigned long last_addr = phys_addr + size - 1;
> -       pgprot_t pgprot = __pgprot(prot);
>
>          /* Don't allow outside PHYS_MASK */
>          if (last_addr & ~PHYS_MASK)
> @@ -39,6 +38,13 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
>
>          return generic_ioremap_prot(phys_addr, size, pgprot);
>   }
> +EXPORT_SYMBOL(__ioremap_prot);
> +
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +                          unsigned long prot)
> +{
> +       return __ioremap_prot(phys_addr, size, __pgprot(prot));
> +}
>   EXPORT_SYMBOL(ioremap_prot);
>
>   /*

