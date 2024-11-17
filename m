Return-Path: <stable+bounces-93738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01D79D0617
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6942B282543
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE041DD894;
	Sun, 17 Nov 2024 21:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rITsfUbA"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD51DA61E
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731878356; cv=fail; b=m6zY/8q6Uhx8EcpvoHpqmf48jQgBVN2NE/XT26KhYeqF0QD9/Vfm0lK0dBN3lheLE/bcm3yJU6QdlF+AgVi5j88Cev6UsdbIQZxzuO3ZUVIWJL5wPy7uPcZINx74kWwstbVR2DM571QlyhDVAah8vNMXAkyScmUlcuhtynvRbn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731878356; c=relaxed/simple;
	bh=LR/kDkuy0dZnrOHgjMQvBbmQSDAr/qplJCiX084TSAg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kf3zyu3rKawRzfM+htpWnDueWGpdUCNkOedGAPIbOFWg6zvN/zYF1UnuqpB6C98vNPgO0i2mg5HkvpSXzUohmJkoVVqitDuTF/V3vC1uS+A+D0+Qr24NzWpvbncQRZFfLrGOxRK04EGF9FnY+HE1XSR46xf0yLLAyt75rk7bNkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rITsfUbA; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIXj3NxzGIXTgQJlO/VlhtP6IG+9gN2bmTlXptNsDtI20UOE2kSHRUbRktBfTbqkiIzhg/w06CT+YJ/rryfRzLITYwKQhjyowV9k46HoaLkzo+lj+rYAxWxgxjQeSSDdbUQixQGR4zcuoqsp0y2huMV5E3VeT5Fm8YWWLIOhO/PLoA/IoGSPFiRQpmdpYivBQ2gTGiCPCrH3TqdmvR4kHbt5hI+cb2neqzLc9jPgOf86dBDJajEX89v9nwSbTH4l9Jah4FARxWGPz2KH7Cps5p7sR3StehWMzNhnXMqUBnkPd0I7kP8rex90/Du1Ykh96fshsXRcH+DPIUAb+yZcQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoFYo/GPsgmSPHW4KEx3opNyUnt1tRag3P16R0svKEs=;
 b=wsLMk8sifyp1XUR+qiocscML1IJ84J2rytA2AP+RbxFprwVDDNRfP6ERksAGGSxC4A96QW1bxfPOvfaH39zBl/hiG56roIKpHXiYFFh8XF45kY22XGP9NsIvoqurAWodsO0Ah+htYsGFbxBk5tiVGtKkdB3xIyx0Ez8So9EHVssV0yNvCF1lZn1xY95NNDCiirypwtQBj4xF+qAvR+ER9ORtT29N2Uxda3CG7pyBpQoDp7cV1//tc+7OlfgGDOa8GoRNAV2plV+J72pwnsoYPDF/cSu6YyeNcXdWN6Iv7au4JzLL6QIj+0HuSSaswkDkv7gakV8eFx0SMGq99a9Obw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoFYo/GPsgmSPHW4KEx3opNyUnt1tRag3P16R0svKEs=;
 b=rITsfUbAWnZRzkt9Z5ch0638SnrtZbsRvkWqtfCiiobb6zrny5tx713RP0sFmQSSBz2MoZ6pGeb5ibJs8NBPpeSNoIOytnE4sP7m3LLszyrYa8UZFj6jLGUa78Zj0esXXPJHXa8g1N9vx8E8ytDDSRTxQmy3ctkJX+8Yurz8tbiF8GDWJ1twKa/nxWyxza7KCSjqofJd8rNTn48l227H5/dLvfBQCYGOQfuiIxrf0zDVuQ2PFy7Am3LshdzNIlmLhumMy9b+jViE32BK52eoYKLdmlDVLLhpE3okE6Fe0lzbZqvWixWuPdaIK/jUp+D8NuvxFgBhUQs9s46GkvDOjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Sun, 17 Nov
 2024 21:19:10 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%4]) with mapi id 15.20.8158.023; Sun, 17 Nov 2024
 21:19:10 +0000
Message-ID: <b79ed291-ad60-4be7-a2c2-19fedfde74c7@nvidia.com>
Date: Sun, 17 Nov 2024 13:19:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] mm/gup: avoid an unnecessary allocation
 call for" failed to apply to 6.11-stable tree
To: gregkh@linuxfoundation.org, airlied@redhat.com,
 akpm@linux-foundation.org, arnd@arndb.de, daniel.vetter@ffwll.ch,
 david@redhat.com, dongwon.kim@intel.com, hch@infradead.org,
 hughd@google.com, jgg@nvidia.com, junxiao.chang@intel.com,
 kraxel@redhat.com, osalvador@suse.de, peterx@redhat.com,
 stable@vger.kernel.org, vivek.kasireddy@intel.com, willy@infradead.org
References: <2024111754-stamina-flyer-1e05@gregkh>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <2024111754-stamina-flyer-1e05@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::27) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 194f48b8-b130-4e95-37d0-08dd074d7a52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjN5QklnSGFXall0VlVSZ1VRaFhmenpVeFJoNzl5bkFRczF0VnNiQ1ZXWmJN?=
 =?utf-8?B?MDgxZ0VRYlBtcHdhNm9oblpqOXd6Y29XSTlaODkydDlyazRhZ0taT0lFWjZ0?=
 =?utf-8?B?d3ZNWW5GeUlxTzZ4QVJFdGpzSVNYd2VCaC81WmNxeENuRnRVTndJZ1hEK0FO?=
 =?utf-8?B?Zzc1ZThaVkV2VC9GVEk1aHdwdWYydklHZWNFQmprUlVDYXZDdDZ2eERtS2t0?=
 =?utf-8?B?YmRLajVMaWc1YURxUlZwa1dUdVVLZldJOTRUUEhwd1A5YWJ6a0NickQwNmpj?=
 =?utf-8?B?Vm1BRTV2b3l6UHNxcmNYbktVYzdUZFdaeWNJS0svaSs0Q1duV2l2bm1wOWh4?=
 =?utf-8?B?VzBXNDVjd0grME1SenNWRWwzTGhTMWljYWZtV0tTNWY4MTRPTmhBc0NEMGRk?=
 =?utf-8?B?ZVFZaUJBZXFVN05uMmRMU3M5ZmJqNCtMaHFBSTFkMk9LSDkxd0tWUGl6U09Q?=
 =?utf-8?B?VjlNbURNQnhqOWdsTHczL0NUTGdiN3JuYlI2WTVsSWZPd0F5MmhJeFdZV0Y3?=
 =?utf-8?B?T0t5cTVELytTYzdjUkR6L1VES3k0VHd6SlNqaXl4ZTlPVGlZa2kreGNwUGlw?=
 =?utf-8?B?bi9OVnE4djdxSkhhQUFOb0twZVJ4VkxENWpNWThkcUEyMmJqdTM3WEYwbUV1?=
 =?utf-8?B?bE8rQkYzNFJPdmVuUWUyM3pQV2FCV0ZTbE5yTzQvUzJEZTE5bWxhUHdjTER1?=
 =?utf-8?B?bmJMSnlIRk1TN3M1UjlGZVhHcWV0M1BlbHZETUxDUUdFcUNoeEJWeGhMY1o5?=
 =?utf-8?B?VTBoZlZSanhLQVhPcy9mUTJTMjdHL2lSa1lUZlhpZGFQY3FVbC9YS1ErOGxr?=
 =?utf-8?B?Z1FSb2IxQTVwTW4yQ2dnQ1BjVTVzeTZ5MDZicnpXdVVBRkE2VVcxNkc1YXdF?=
 =?utf-8?B?dGtaZ04zblhvL2JQcVVhK1QzMUt0UEgzcS8xR1ZGd3JqMWpRbU9WQ005N0Jx?=
 =?utf-8?B?MXJIamZ4WXJJM0JHcE1jMHcwaGFzTGhpQU50Ti9NMEpHcTh2Wk1oTlJqR0sw?=
 =?utf-8?B?WUxXS01uc1BIZ1VnU3NROHczN2hvSk1qd1gxeFovRFNzQVdPMHg2NnQ5SXcy?=
 =?utf-8?B?V1UzTFlxd21hYXJ5dVE0YTRrSTc2NjB2RWxVdXJWaEh5T09LNmZZbldWUWxC?=
 =?utf-8?B?ZEVMNHRrWWFhREJpN2lnM3hSVDJrelZ2c1hmdytxcEY0ZlJMZ3hyaEZCQ2li?=
 =?utf-8?B?MzFaenVjVXRPN1FFcXNFMXBqc0tkQVlMd1hGYy9tY2E2SlNYdTRRN3JlTWM5?=
 =?utf-8?B?MTVNeng0RUdsVk9rQ3NEUzRvYTd3UlZPejhHQVRPMzZCVGZIcTJVMHM5dnpj?=
 =?utf-8?B?TXFweG1BNHJHRXhlMVhiVFpqeFZvUlM3bU1DQm5kR1BOdnZnN3hURnNiNlZp?=
 =?utf-8?B?N2l0bWZubUw5ZlNJRDNtaWt6TkxhT2ZnOGEvQWRKMFZBbFZCMVg5WlQwMlAx?=
 =?utf-8?B?R3F0S1dpK2FVaTRrT3pjUEtPUllTbE9LS3gwSjVTdVFvWWRZRWtiME95QnZX?=
 =?utf-8?B?bkdjM2QvWTlHUERJN1g2QnBmZ0F3VnVxa1RYa2NUZi9KTFkyOWs0NzNNWXQr?=
 =?utf-8?B?OW92K2lQRFVsR3lDTlYxWGpwa2MwZmNnY0NXVEJJdzRtQURVTlM1ZUZEeXVV?=
 =?utf-8?B?SHBBNFRRN283SlptTExSWWdvMys5Ny9iaEgzakgyYjc5Z251djlCemhmVkwy?=
 =?utf-8?B?VEkyN25qd3k0RWdRdHdGNDFHMUZ1SHlvVTJDWlV3bXJVYmYyVUNENnMzYmFy?=
 =?utf-8?B?a1U1SDRlaDkyOTFkNFZsT09qc2ZONE5SeHdPVjNrM3IxL3RSOG1va25UZWVq?=
 =?utf-8?Q?6yttEMdk7lo09HqKWy1O5Sx/4JjzuOAqA3vcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG9QNU9iNVNUbzBCWnlBdVhaU0pxNTVaN25EV2plTVIyL3dySHBuVHlMWWNJ?=
 =?utf-8?B?UE9ITVJaUFBCWWQ5bGNxVi80VWJmYTVZSDJkRUl0dDhZUVJXMjVWdnNTamUr?=
 =?utf-8?B?eWtEU0JKekMxWjNBQjJzeU1OQlNWYjdGMHNSTmV1a0x1Y2lmK2s2R1Y5MDl4?=
 =?utf-8?B?OUs1WEc1Y3lNWGVXcEwwaDViWE1mTk5BMmRxUlorZFlmck9ZUjJXdVFWV3N3?=
 =?utf-8?B?bGJ3QnVGQmJtYjJpVk9qN3dlbENkOFdscWp1cSt0SERqd2dzZGYwK0I4WFFn?=
 =?utf-8?B?WFQ4YllVanF1L1FqWU13bng5clgrRU5DbjNpSzk2OEJNckltUnFkVktTTEdZ?=
 =?utf-8?B?eGJIYXRLK3hXV0xsSnY1bVNrVXpYT2w0RURia09IcVkzSDJiSG5ORVU1bDh3?=
 =?utf-8?B?ZktNYUxYQXROdGV6R0F3Y1JxL05ocXdEZHQzTzRGak5LTHdVY25ZVnpwZnBs?=
 =?utf-8?B?QzNvWXEwQVNDT2FCSmpXVVk2VXhtazg4NFUwL3lITjdUaC9abml0VzFOZGI1?=
 =?utf-8?B?RkZZRmFxdTRFYVRlRUlYNXVFYXFQdGZEcXMyOHlCSUxla0hrWkg5cmFmekNY?=
 =?utf-8?B?ZS9GM29aVkJLTDhPNkt2Ync4VW9zNlpIczdLN2hLR3N3TVpqUXhvTnRRdWE5?=
 =?utf-8?B?TEViOUxmRk5uTTk0OVcrcG9zSUFXYTh6UUJkMHFYUjRMMEpsZjVNMDJvUUVK?=
 =?utf-8?B?eGZWNlEyOHFjYWhJZkN1UjVtNXhIcWpCZmM0U3psazUySDh3dlFxTWYwOU5G?=
 =?utf-8?B?UlAzenFvWDYydDEwN0pFRXYzb1g5RVgzbGpEckRTdXRLMThKRmNyNjZwRDJv?=
 =?utf-8?B?MnU4cGphZXhNTWN5RWRQWURwMlhXaTc4NHg3OVo2S3EyTXliNVpoSy9NY3N3?=
 =?utf-8?B?dHdhaUhFR0xKNzVvMWY4REJHOXFRKzltcHU5ZEc0cXpEQW8vTHBpSnc0b0pI?=
 =?utf-8?B?eDZ0L2FCcGdnUStiak9WaG5uNFc1anpZb3ppZGZNR0ZWakxYZkVGVW9maGZp?=
 =?utf-8?B?VStaYTh6a0FMUDROSlJxSUZJV0g2MlkweVlPbGJKVFRBNzU1bG5WNFVRc2JM?=
 =?utf-8?B?Mmd2SjgzWW16cWV4eEw1VVBZc3BEMFpBZXVPVnZuQmRoR0YxRm9FQ1plV0JX?=
 =?utf-8?B?RDYzMWJhSUtrZnlveXRrb3Fzc1l1Z3JvRDFtTFRQK0Zwd2hYY3lxUHMrL3Qv?=
 =?utf-8?B?Z2hwaXBWZVpHdjRkQWF4ZCtiRzhSaVVRVWlFR1hSYUVyeHg3WFdRcmVodStp?=
 =?utf-8?B?b3dZSkFkMys0d0taOE9HQWRLbUE5UjE4Uk0yaC92WGJLeUZ1dm5SeFZvbFBn?=
 =?utf-8?B?NWZvYmNCL1NiQU9UWjFreHBHYWY0eEM4UHZXVFBVY1dLMEdTaXplTGNrMG9D?=
 =?utf-8?B?M3hRSFdYNmt5STBaWlNDWFdLUlAzbzNTZ2J2LzZMV3JvZS9ZWlBDelRJbVYr?=
 =?utf-8?B?TVRzQzYycEowM2pmQy9oZDBYY3ljVktXT3NvRmdEc3kwU2kvQWlHaXBrcjFO?=
 =?utf-8?B?bmgvRW9uVUQ2VERVM1BXcFJ5UTZNMGVWYWw4c1ZUZGh5RGdoRUpoUVBaRFBa?=
 =?utf-8?B?L0xjajF4U2hEMUF2QkZxQTdwc0lrN3d5Y25ZTnI3T3ZleE92d3ptTDIzT2pa?=
 =?utf-8?B?clB5eHI4bzRHeHBPdVNlQURqUkl5bXBQeXpBWGJHREVMNmd0WGZzcXJvb0s4?=
 =?utf-8?B?RWFjTkVzMlNBRS8vVnlyWXE0OHpaUWhUNmR0anpvM2pVQkcyUy8xZkd2YXh5?=
 =?utf-8?B?amhaN1hVZDJ3cThabkJZR085UmRFcmdTWGxzeHhsYk9KNnFoRGgxc25GU3JD?=
 =?utf-8?B?NHd3c1VIM01LVVJvemdobXV1RldqWHk5UkV5Y3pDMFlNOTExM1JYbXdDN09m?=
 =?utf-8?B?TUlhZjFGU1RlSTZzREZRaUlMNG80WkwzczZaNEZXVjFtZjVOYkFFb3pRODZM?=
 =?utf-8?B?OXVuMjFEdm42SXAydDJIZGR3RFlnWTB0K2Irbyt1SlppcGVkOEtXTjRXcEl3?=
 =?utf-8?B?a2U5WTFXckNFdUhzOWdKTlJWRFhyS1JDMjAwbGhuY3VCRG42dDlvNjN5VGR0?=
 =?utf-8?B?YXhnNXVDaWpnV2dUY1ZaOU45OWJ5aXQyRzJ1d3hsVmduQVQzbXE3Z2Q2OXV0?=
 =?utf-8?B?bTF2b3Bmbzl2cjlrZ2J4b1MrUG1TZm8vcU9FRVZsZVlhVVFjT2lEck1hOVBR?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194f48b8-b130-4e95-37d0-08dd074d7a52
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 21:19:10.3704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqhHMMhjtFN1Z/hnwVLc+twJ+3UZmpdmzeCzSFflWMMNMN7kp7cD0LoCDIWM5AqoqonyfOBaHpcE//jLcOYlLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857

On 11/17/24 12:33 PM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.11-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
> git checkout FETCH_HEAD
> git cherry-pick -x 94efde1d15399f5c88e576923db9bcd422d217f2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111754-stamina-flyer-1e05@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..
> 

It seems that the last hunk didn't apply because it was just too far away,
as far as I can tell. I've manually applied it, resulting in the same diffs
as the original, and did a quick smoke test (boot and ran mm tests).

Here's the updated version for 6.11.y:

From: John Hubbard <jhubbard@nvidia.com>
Date: Sun, 17 Nov 2024 13:08:00 -0800
Subject: [PATCH] mm/gup: avoid an unnecessary allocation call for
  FOLL_LONGTERM cases
X-NVConfidentiality: public
Cc: John Hubbard <jhubbard@nvidia.com>

commit 53ba78de064b ("mm/gup: introduce
check_and_migrate_movable_folios()") created a new constraint on the
pin_user_pages*() API family: a potentially large internal allocation must
now occur, for FOLL_LONGTERM cases.

A user-visible consequence has now appeared: user space can no longer pin
more than 2GB of memory anymore on x86_64.  That's because, on a 4KB
PAGE_SIZE system, when user space tries to (indirectly, via a device
driver that calls pin_user_pages()) pin 2GB, this requires an allocation
of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
kmalloc().

In addition to the directly visible effect described above, there is also
the problem of adding an unnecessary allocation.  The **pages array
argument has already been allocated, and there is no need for a redundant
**folios array allocation in this case.

Fix this by avoiding the new allocation entirely.  This is done by
referring to either the original page[i] within **pages, or to the
associated folio.  Thanks to David Hildenbrand for suggesting this
approach and for providing the initial implementation (which I've tested
and adjusted slightly) as well.

[jhubbard@nvidia.com]: tweaked the patch to apply to linux-stable/6.11.y
[jhubbard@nvidia.com: whitespace tweak, per David]
   Link: 
https://lkml.kernel.org/r/131cf9c8-ebc0-4cbb-b722-22fa8527bf3c@nvidia.com
[jhubbard@nvidia.com: bypass pofs_get_folio(), per Oscar]
   Link: 
https://lkml.kernel.org/r/c1587c7f-9155-45be-bd62-1e36c0dd6923@nvidia.com
Link: https://lkml.kernel.org/r/20241105032944.141488-2-jhubbard@nvidia.com
Fixes: 53ba78de064b ("mm/gup: introduce check_and_migrate_movable_folios()")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
  mm/gup.c | 114 +++++++++++++++++++++++++++++++++++++------------------
  1 file changed, 77 insertions(+), 37 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 947881ff5e8f..fd3d7900c24b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2282,20 +2282,57 @@ struct page *get_dump_page(unsigned long addr)
  #endif /* CONFIG_ELF_CORE */

  #ifdef CONFIG_MIGRATION
+
+/*
+ * An array of either pages or folios ("pofs"). Although it may seem 
tempting to
+ * avoid this complication, by simply interpreting a list of folios as 
a list of
+ * pages, that approach won't work in the longer term, because 
eventually the
+ * layouts of struct page and struct folio will become completely 
different.
+ * Furthermore, this pof approach avoids excessive page_folio() calls.
+ */
+struct pages_or_folios {
+	union {
+		struct page **pages;
+		struct folio **folios;
+		void **entries;
+	};
+	bool has_folios;
+	long nr_entries;
+};
+
+static struct folio *pofs_get_folio(struct pages_or_folios *pofs, long i)
+{
+	if (pofs->has_folios)
+		return pofs->folios[i];
+	return page_folio(pofs->pages[i]);
+}
+
+static void pofs_clear_entry(struct pages_or_folios *pofs, long i)
+{
+	pofs->entries[i] = NULL;
+}
+
+static void pofs_unpin(struct pages_or_folios *pofs)
+{
+	if (pofs->has_folios)
+		unpin_folios(pofs->folios, pofs->nr_entries);
+	else
+		unpin_user_pages(pofs->pages, pofs->nr_entries);
+}
+
  /*
   * Returns the number of collected folios. Return value is always >= 0.
   */
  static unsigned long collect_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+		struct list_head *movable_folio_list,
+		struct pages_or_folios *pofs)
  {
  	unsigned long i, collected = 0;
  	struct folio *prev_folio = NULL;
  	bool drain_allow = true;

-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);

  		if (folio == prev_folio)
  			continue;
@@ -2336,16 +2373,15 @@ static unsigned long 
collect_longterm_unpinnable_folios(
   * Returns -EAGAIN if all folios were successfully migrated or -errno for
   * failure (or partial success).
   */
-static int migrate_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+static int
+migrate_longterm_unpinnable_folios(struct list_head *movable_folio_list,
+				   struct pages_or_folios *pofs)
  {
  	int ret;
  	unsigned long i;

-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);

  		if (folio_is_device_coherent(folio)) {
  			/*
@@ -2353,7 +2389,7 @@ static int migrate_longterm_unpinnable_folios(
  			 * convert the pin on the source folio to a normal
  			 * reference.
  			 */
-			folios[i] = NULL;
+			pofs_clear_entry(pofs, i);
  			folio_get(folio);
  			gup_put_folio(folio, 1, FOLL_PIN);

@@ -2372,8 +2408,8 @@ static int migrate_longterm_unpinnable_folios(
  		 * calling folio_isolate_lru() which takes a reference so the
  		 * folio won't be freed if it's migrating.
  		 */
-		unpin_folio(folios[i]);
-		folios[i] = NULL;
+		unpin_folio(folio);
+		pofs_clear_entry(pofs, i);
  	}

  	if (!list_empty(movable_folio_list)) {
@@ -2396,12 +2432,26 @@ static int migrate_longterm_unpinnable_folios(
  	return -EAGAIN;

  err:
-	unpin_folios(folios, nr_folios);
+	pofs_unpin(pofs);
  	putback_movable_pages(movable_folio_list);

  	return ret;
  }

+static long
+check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
+{
+	LIST_HEAD(movable_folio_list);
+	unsigned long collected;
+
+	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
+						       pofs);
+	if (!collected)
+		return 0;
+
+	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);
+}
+
  /*
   * Check whether all folios are *allowed* to be pinned indefinitely 
(longterm).
   * Rather confusingly, all folios in the range are required to be 
pinned via
@@ -2421,16 +2471,13 @@ static int migrate_longterm_unpinnable_folios(
  static long check_and_migrate_movable_folios(unsigned long nr_folios,
  					     struct folio **folios)
  {
-	unsigned long collected;
-	LIST_HEAD(movable_folio_list);
+	struct pages_or_folios pofs = {
+		.folios = folios,
+		.has_folios = true,
+		.nr_entries = nr_folios,
+	};

-	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
-						       nr_folios, folios);
-	if (!collected)
-		return 0;
-
-	return migrate_longterm_unpinnable_folios(&movable_folio_list,
-						  nr_folios, folios);
+	return check_and_migrate_movable_pages_or_folios(&pofs);
  }

  /*
@@ -2442,20 +2489,13 @@ static long 
check_and_migrate_movable_folios(unsigned long nr_folios,
  static long check_and_migrate_movable_pages(unsigned long nr_pages,
  					    struct page **pages)
  {
-	struct folio **folios;
-	long i, ret;
+	struct pages_or_folios pofs = {
+		.pages = pages,
+		.has_folios = false,
+		.nr_entries = nr_pages,
+	};

-	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
-	if (!folios)
-		return -ENOMEM;
-
-	for (i = 0; i < nr_pages; i++)
-		folios[i] = page_folio(pages[i]);
-
-	ret = check_and_migrate_movable_folios(nr_pages, folios);
-
-	kfree(folios);
-	return ret;
+	return check_and_migrate_movable_pages_or_folios(&pofs);
  }
  #else
  static long check_and_migrate_movable_pages(unsigned long nr_pages,
-- 
2.47.0



