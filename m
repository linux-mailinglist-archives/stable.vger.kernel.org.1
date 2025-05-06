Return-Path: <stable+bounces-141935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17DAAD0BB
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E26277BE0B2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACF41547CC;
	Tue,  6 May 2025 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mEO07wwA"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8F71B960
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568961; cv=fail; b=ZbxaZTzdyByFGEAcFyysLGAOOvqmWa4DNP/V34j2Mw/eJM7rT694YdXF5hT28RoYvZP3Obu/2Uq4YJCZ/mcUYT6LRweOaIKcVL7igP2U3UVIRcxwBJwqwAeOUfU0E5+Ydx9QrzQ1h1LNrxkwCp0uwMz/JqsueuBNPmq4xvkNtVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568961; c=relaxed/simple;
	bh=S27m3vqrHdAg0IcpqGM9YK/GVk445uNHkt8NcpmOr5g=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=CVC0ioBnPEBuvIANrD+6e+Yac9ltgS++pQbexTSS/dkjf10en3xjYZwOM3tyZeDJ/ueoVNHd2424+8BBD3tYfyNjKnMMCE9N6wgCHZUj3dBeeZSmdLHlNHVvX3dcJEcZ9Y/fn0ZkjGG1imxnjjHJ7oCXIpyjKT1DEcupVWR2p3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mEO07wwA; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btwcATYNVOXAoc70KEMFcnYNVIMVh9zppOJ4n/PDvrB9Ye2hHntWliTtzWJBEg8AqftBjLGexZPNMifbwuZy3CxMgcmwdqzX178NdcAuPfCFQwv+MWQoX70/vZmO2yHbUyVjA1fKjPk1i61GJFeGrFih4sT/pEnVYoD6KlalY1+5WF4Ey6qU2+2WTcCg2uDw6j92k7SWzIqb1TrM8insVtS+AnOqfwnb8/G2C+QTPTKT5IjYdYTmxGqQ/lqg/MCxarhDk/qVNvzpSp37u5IqT0i+2Ixk5MXLVvat0/GJoTTqyQnsK7/RoL0sf7LGxk3/O39Kx3LcHO/hSpoeOZ3vxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKEPu1JaxqQ/NZYHYBfadeDzISnjDRR6IOuUsQH3W4U=;
 b=i1zZiZA13CpsKyBfrFdHH7TqPw33rxC/osOsew6IO3hYDbCuKBHihnFIYmuGS1KMivxfFcR6Gp7HDgNeqApcAP5jRJ+jxYMX5/jfIednBMRKnxJGZaPtCl4boRfKywmGPTs9Yy1orOZOKbYtqYk7NXw1tt5+AViWoXFFPKzVk3lpJH3q+xNtwwtZXP5lgH7uA+8WtqQGdSp587ERpjEUfTfmT7ia08X0NvepcvKND2AcoQGN7ot2fnqqYc7bSsgtgD5JWzuEqSo7afCZHTi/4WJohDuQUkeSV8WH0OBQrYnPVTTY57qSnAN7v0fgW+l4ScI4V0+dwWShmmVR5Dr4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKEPu1JaxqQ/NZYHYBfadeDzISnjDRR6IOuUsQH3W4U=;
 b=mEO07wwAHFCgdskXO32Zl2ehsSSQ3sK/IY4RSTWpWHL0vWhCxF64y9Q0MHSmVWEaTiR29Igp2eXqFUN+Vn6HGdcQSrDM/cRCPN3zaHBOrJMEZd6iLdicDr6J421BXoX6a6i3VEDRUJiUNF3/zT1cccbvj8jHIWfR8jFl6lx9Y2hPvbbKtRjOiScQSQ+auETKHMJWRXzG3dbH2dOI4Ddtbq08b9G8NXcAokhqEd/RTrN6fnH28pcUqlO26PWvqsEwaE9jUEbYalvcAMQJvBQnpFf/fwSk0SM47e9DnpAmJxs242HrGie3FNUVK5QB7e2js4pCyO0GAtjC3ezIdINHQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 22:02:33 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:02:33 +0000
Message-ID: <1ec6c026-a6bd-4694-a3dd-224bd09643f6@nvidia.com>
Date: Wed, 7 May 2025 01:02:30 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v1 2/7] ublk: properly serialize all FETCH_REQs
References: <20250506215511.4126251-3-jholzman@nvidia.com>
Reply-To: Jared Holzman <jholzman@nvidia.com>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Organization: NVIDIA
In-Reply-To: <20250506215511.4126251-3-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 027565c4-38e3-43d8-3579-08dd8ce9b3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGpWMHJTdHAwSWpwd293Z3VlZ2hsNTE0dEVIUkZKL295WEdUZnlMdVlyVGdU?=
 =?utf-8?B?bU1TWlRTMG9iMlhkMlJFcjBhdEpkY3N1bUVOTkxFQXY5dW13anJtU3ZZN1J6?=
 =?utf-8?B?M0tnVlNVOXVzNCtXZi9VMDVzeE9BMVdLdDdCSjFQUnVQUHFna0JpVHhDZHZC?=
 =?utf-8?B?d0pUclQxTGw0YXZ1QnNuL0I4QWViWXRhdXd4ME1haURjeXBXWXkrRGdhNjgr?=
 =?utf-8?B?aW5FYkZUd0hHRG1RWmE2Zmw3NkRQVzRUbTM1UEFHODBITHNsUVZzVnFYbTAv?=
 =?utf-8?B?aE5PSHhXN0JLcURsRk5KTWR4MkdubFFGUVkyNmpiWUVTTXJ2a2wwM0h3TGFY?=
 =?utf-8?B?QzFtaGFqU284RkxZSXhFaFNUL3FSM3B4TGpFSW1kdlJjdnRpRk1YOU1BbFYx?=
 =?utf-8?B?ejlMeUpvQ3BBdzU4VGFKWmxkTDZ2c2JDbFJpZHRmcjVBRmw3ZWo2ZjdXNVdy?=
 =?utf-8?B?bk80b0F3WWJ1aENKRTRKVllyYVZZSi9YQklVb0Uxb1F1U0g2R3o0ajI2c0Rz?=
 =?utf-8?B?dkUwOTdTTitCdkdVWDFKSmxxbFQxbDRiMXk0OHVEaFJOM2d5RW1HMHJWdGZk?=
 =?utf-8?B?cExrM0l4U2JFTFhmMkhDbFJSd3ZJVE5UMzhqMVh1QzJxQytzcmFqVW8weUlW?=
 =?utf-8?B?cEZiUnBhOHcxbnZkSmE3NHFJQzhDVXAzY3RUV3hRYWIwSlpZa1hGdHRsaDdI?=
 =?utf-8?B?NDYzdjE1d0V5eC9CN1hFNzNLbmxNVkhRYXBTK2V2ZDljRENFL2tiSmlzUzJ1?=
 =?utf-8?B?aG9idUJJWGpvSE81WmtHWWFqZHQ1ZHN6bVg0YlZDTDRzVUVpMFhtNFQvRVVR?=
 =?utf-8?B?M3A5dU1zR1BmaGVqQW9qa3FsOTNLaXhYejE1OWZZR0JYOWRWZG5WRWQwaFFW?=
 =?utf-8?B?ZEtOMERhK2hsNk43YkNpTm5FWWcwUGdJMGQ0ZUVWVzdKNnhCUmpCWFlHTElS?=
 =?utf-8?B?TWNDVDRTTVp3UGZoSWVOWWUrcFA3WlVLWStoZ0h4US9lay9ldkxUNDl5YUEv?=
 =?utf-8?B?SVRIRXF4RXRacFVyVW5xc0tzaE1sQ2liTWNHZjRPTFdqSEhRRExCOEJuanlm?=
 =?utf-8?B?U2tZQVl0U1NVUmN1UEtBL3lkOEwxS2NZenA0N0NSdkY2U2FlSjMyZFJ0Vklp?=
 =?utf-8?B?M0NHalAyV3ZZQnloTkRzcERmRnVSOWpmVVdHcDYrQ1Jtb3lZb2oraGdOclh0?=
 =?utf-8?B?WEU0RW9uZ3NPelZXeUJ6Tm5HbEhKS3E2L1hzRjJDa1ZCQ3dlS3JST1VHWEJB?=
 =?utf-8?B?WFYrQmhNU1ZIdVFpdXUvSHVzNTAwRUxJVnRic2haL05YbHRIWUp3alJMdmdP?=
 =?utf-8?B?R2x3M29wdllWQUpyR0hkeUFoeldKbzJjUkNqYXEyc1E1ZFVFYkkrTlBFZlRu?=
 =?utf-8?B?MEhSajBXR3JVYk0rK1VXRFV1Q1IwbXgwTjNZQ2FPWWsxazdOYTk2bTdnUkMr?=
 =?utf-8?B?WW1RT2xSdzZKZnYrU0dseTJ3enFWMW4xdGd5ejlNSy9IQzRrZHZmdmptaWZ0?=
 =?utf-8?B?YUF4c1Q1ODdGSzNkbjY0YXVvejZxemk2aVNERTRWcjFSYWFCbEE2Vkk1dlo0?=
 =?utf-8?B?V1lsMUFCWk1WN1VuNU5JMmZWQjR4R0RKNHQ0UU9veXFySHQ4R0FJVDlmK3Y1?=
 =?utf-8?B?TjMxYlNCMS9sc2cvL09kYUwwcUZMNDhhWmxoSGRwWGpobVNMZzVESlQ1RHpD?=
 =?utf-8?B?cHhaWndxT2NZMkVIa0RoK3ZmVW5sOTZhSXNhSmM5Mm5MVnoyclpOU29EaDlZ?=
 =?utf-8?B?Tmp2YUU4SmExdzRWQi9yRUxWdmZEaU5ka2UvNzFGOGxGZ0hDYUVMazJlcHBh?=
 =?utf-8?B?TnNTNno5YmVaWVhPV1owaGFOeUp2YTFOUVhvT3lleldSaHplSlR3OTc5SDZP?=
 =?utf-8?B?ZGFIWmk0QyswZzhoQndtUEtrOHlaSCsrUk8zcDMyQ0lRQktmcEc3bUpVM0lh?=
 =?utf-8?Q?v2EPsQqO8lY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2greEJoRFd5cGlEWTZOSVVuSEoySWFvaWVGUFJFTWFUbXMxaDlzcFFaQmE4?=
 =?utf-8?B?cUJVQTROV1FvMFFTR0lWY052cG1iKzJSempLa285cnV0dG9VRDVYK1dFcUo2?=
 =?utf-8?B?NnA2WHdTREUrbjR2Qzh4TDdvQWhON2d3dzVFNGFMY0QrTTBKbS9wQlVPS3h5?=
 =?utf-8?B?dXlqUkN1b2VIbklzVWVNWHZxQ0dXcEI3RGFOTlhlVVNHZzVNc0I5NU5mZzNH?=
 =?utf-8?B?TGVqL3c0eVBSNDJWRGRrQjN4M2tnMVFBWitNakhKT2IyRGlmNDFQQXMvTFdq?=
 =?utf-8?B?Z1lzSW9PZUdEaVV2cUYzRk1vcG9yMW9VZGg4ckZYTkNvMUg5Rnl6OUJJUnN5?=
 =?utf-8?B?VHZnOExGbUtwcUJsdFliY3FqVkRVdjF3VXI0emtnbjFjeUlVTng2TkY5c2FE?=
 =?utf-8?B?SGZsK1E2U2JxSmlaV0lqUXY2OVErbVFRNVcxZVpIMVRBcHhmeGxQU3FBcm0z?=
 =?utf-8?B?UXgwK1lBQTg5bytlelFXYXV1aFdpQzNMbi8raHBSSDIxYkRLM2lncXIyQW9H?=
 =?utf-8?B?Mkxqbk1vdm1ybFI2Qll2bnk1N0JDT0RLT3pMWTE1L0FyamJjL2FOZ0ZsSVBB?=
 =?utf-8?B?ZDVOdzJIcFNzaE11bXBRWXJuMEJwM2VtSkMyaHkwYUtpaERTcEtYK1FzdXhZ?=
 =?utf-8?B?UE90S3JWemV0Y1k3ZUt1SmRtQWlka2VpQVJjU1ZOTzFlNldrb3ZlZUpRK3Jr?=
 =?utf-8?B?bUYxR0p2SlIxcCtXOWI4SEQrTUdKR3ByS3dXcWtmVHpOSStlOHIwRWRGSVBs?=
 =?utf-8?B?TE1HRUNLSStkRGFuN1NjNnVxQWZZTjhVVVI5b0RaL0FKQ1J1cm1mdGI3aTZy?=
 =?utf-8?B?OWlZZ05RQU9oQy9uelNOVUQ1ZkI1cjZiYnBKZnFVN041Q1JDNWd0eU5WYlJz?=
 =?utf-8?B?V1cxQVUrellxR1ZKOEF0eWhJOGZIQTFHbWdNcnFYWkVEczBJWGFLK2VjdWt3?=
 =?utf-8?B?OG5ITjcwdGwxNk8rVTFzRlJ5NVRZcDk5VG9SQmxzdC9Cc2RKRkN3UkQxYmcv?=
 =?utf-8?B?Sk5aVSt4aGJ4NlgvdW1KVjNPYkRuRTgvdHZRRGg4dDJxRFlmbXhYTkJVWW1a?=
 =?utf-8?B?Y2t5bVk3WFRRMnpCUElDZkhvdXV6VXpUVk1Hemk2U0JxanJOVW5GOFVWTjFw?=
 =?utf-8?B?MTVoTisyYXZuQ2k1ZXpzdWJRbXgxOWlkTzMzNU1pR2NIbi9ONU9aODJQVFRo?=
 =?utf-8?B?MkptNWtNZ0kzKzdyaGRWOU5FSEFwTnlqYnRFM2p4VXc3dlRjUzd2S2VwbDFo?=
 =?utf-8?B?SXpPRjRpbE9Pd3QzenBFd1Q0VHh4UXRQL2pYRitqdWVVcWtDbTZJV2pwZEZS?=
 =?utf-8?B?aE9WVUZiNVRDWFhuWlN0WXI4MkVpY2wwZE0zLzEyb29mYk8wL0ZQejU3Q1RD?=
 =?utf-8?B?Rmc3aW5OQUFrSDJVYVlzOFhKWFlaQlhzTEQ3Qjh2NXc1MlR4cmdtdjlGYTg4?=
 =?utf-8?B?VjE3Ni9RSG05a2hKanovamhmKy9EeUVKL3QrVlFKdll6bjl6NjZsSUszTGxT?=
 =?utf-8?B?Tm9LVytjTURUUHlTTzFPcGZibGJWRTFucW93dWhEblFtVzBWaGF5and0RDVE?=
 =?utf-8?B?T3dqM3YzMkVLWkhvNDZJeHlXcnRwLzU4dW16STlNQUd5RzIzaHRVSFFWMzg4?=
 =?utf-8?B?WjZ5eGxyeHMycUhaUTZ6MmRzSFUyaXhtak1QL2paYzBmL3hOeEVVZGJreTNQ?=
 =?utf-8?B?NDNsM3l5d09UM1ZZNG5SOExHeFhyTnNySDI5SVFrY2NVZzRkdDRLeFlCMzZw?=
 =?utf-8?B?TlFlTXprUG9veDk4S3hiZzlWWFF1endVeml3MlBuaGVjMjNyVEZmOW5UT0t1?=
 =?utf-8?B?ZW80RXdWdHpndmMzRFQyWVBKWlhCU2JmZjRiaGNRVkl0dS9aclhNUkdSYnpR?=
 =?utf-8?B?YVlIVmF3ZHhGWlpzNXlpTEtmNHlCamJWV1kvS05aZCtVQlY3RWVvWnVRak1t?=
 =?utf-8?B?c0JOUjlMaUg3RklvcGU1R0NXc2hrek1SVkJIQlVZVDByc0dnYzdsVzdRbWVn?=
 =?utf-8?B?RGZ0ZUVsL0Nzbjdhak5PQzI1blBkTTZadnZrMnA1blp6RjJxMmJBa1JiUW1Y?=
 =?utf-8?B?UmgvK1pRSitRajkzU2lKazZlM1EwRklvc3E1NDQvSE9tbmJhTVpvdFRaMkQ2?=
 =?utf-8?B?eGlDV2NFalFtYm1tK3lqbXpXaWVsNmpiNTNJbUJEQTZscSs3UGRPY1c5amgw?=
 =?utf-8?Q?Jf6V+skuvUpsq/PsN6xuQttCJWfFty7K/Sxppxom09FH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027565c4-38e3-43d8-3579-08dd8ce9b3cf
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:02:33.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCxdrHcpOnjcye7uo+vZGGKMXbFqNsDBqWLqdWFdcUV955JE63XseSUV9Z7CNBaAlFGdnZ0e/vWiupEN6ktPXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079


From: Uday Shankar <ushankar@purestorage.com>

Most uring_cmds issued against ublk character devices are serialized
because each command affects only one queue, and there is an early check
which only allows a single task (the queue's ubq_daemon) to issue
uring_cmds against that queue. However, this mechanism does not work for
FETCH_REQs, since they are expected before ubq_daemon is set. Since
FETCH_REQs are only used at initialization and not in the fast path,
serialize them using the per-ublk-device mutex. This fixes a number of
data races that were previously possible if a badly behaved ublk server
decided to issue multiple FETCH_REQs against the same qid/tag
concurrently.

Reported-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 77 +++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4e81505179c6..9345a6d8dbd8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1803,8 +1803,8 @@ static void ublk_nosrv_work(struct work_struct *work)
 
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
+	__must_hold(&ub->mutex)
 {
-	mutex_lock(&ub->mutex);
 	ubq->nr_io_ready++;
 	if (ublk_queue_ready(ubq)) {
 		ubq->ubq_daemon = current;
@@ -1816,7 +1816,6 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	}
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues)
 		complete_all(&ub->completion);
-	mutex_unlock(&ub->mutex);
 }
 
 static inline int ublk_check_cmd_op(u32 cmd_op)
@@ -1855,6 +1854,52 @@ static inline void ublk_prep_cancel(struct io_uring_cmd *cmd,
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
 }
 
+static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
+		      struct ublk_io *io, __u64 buf_addr)
+{
+	struct ublk_device *ub = ubq->dev;
+	int ret = 0;
+
+	/*
+	 * When handling FETCH command for setting up ublk uring queue,
+	 * ub->mutex is the innermost lock, and we won't block for handling
+	 * FETCH, so it is fine even for IO_URING_F_NONBLOCK.
+	 */
+	mutex_lock(&ub->mutex);
+	/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
+	if (ublk_queue_ready(ubq)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* allow each command to be FETCHed at most once */
+	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
+
+	if (ublk_need_map_io(ubq)) {
+		/*
+		 * FETCH_RQ has to provide IO buffer if NEED GET
+		 * DATA is not enabled
+		 */
+		if (!buf_addr && !ublk_need_get_data(ubq))
+			goto out;
+	} else if (buf_addr) {
+		/* User copy requires addr to be unset */
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ublk_fill_io_cmd(io, cmd, buf_addr);
+	ublk_mark_io_ready(ub, ubq);
+out:
+	mutex_unlock(&ub->mutex);
+	return ret;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1907,33 +1952,9 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_FETCH_REQ:
-		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
-		if (ublk_queue_ready(ubq)) {
-			ret = -EBUSY;
-			goto out;
-		}
-		/*
-		 * The io is being handled by server, so COMMIT_RQ is expected
-		 * instead of FETCH_REQ
-		 */
-		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
-			goto out;
-
-		if (ublk_need_map_io(ubq)) {
-			/*
-			 * FETCH_RQ has to provide IO buffer if NEED GET
-			 * DATA is not enabled
-			 */
-			if (!ub_cmd->addr && !ublk_need_get_data(ubq))
-				goto out;
-		} else if (ub_cmd->addr) {
-			/* User copy requires addr to be unset */
-			ret = -EINVAL;
+		ret = ublk_fetch(cmd, ubq, io, ub_cmd->addr);
+		if (ret)
 			goto out;
-		}
-
-		ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
-		ublk_mark_io_ready(ub, ubq);
 		break;
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
 		req = blk_mq_tag_to_rq(ub->tag_set.tags[ub_cmd->q_id], tag);
-- 
2.43.0


