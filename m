Return-Path: <stable+bounces-142211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3261AAAE98E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA0D3BA131
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483381FECCD;
	Wed,  7 May 2025 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JfxXsTTB"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7720E6;
	Wed,  7 May 2025 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643555; cv=fail; b=YDHPn8Xro972wmqJdErxqg7gv8eOJllvO8VpPyAbKZ4u0GNaOKoQi0JH+FLXo4xecVKDyRQ9HnescVeqqrjA43OUbUBm+oCoPXpcWoXqIWN8KOLb7/Fm43QUfo8Gl6nHv64HUKclkVauvdQgwBHDtYpE+ZZliwoBCNIlAfp7jg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643555; c=relaxed/simple;
	bh=oMxxoqx+Lle5wE+EpnWwErN0c3cnUKcd/xLDxI47USA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uu7WilTAOc/vVdXsVknqByuaAFBuJFfZKq7XmPEjJgu2MVfLHGxlHys4qrGeyBExoJ8WM+uXhGeHsoOzYUnqz2OpQnu57JLhJRQ2bdsKwkJFP6FJUbjpeI45RnXFhIJg0f8hXEW3xKPp+8ye35Bg93uy9axG+8IHKki+e5jnCAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JfxXsTTB; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVamDsHTNasVMjICordbtOdIHFlvfA+xciXUSIRtgej7J3iTV1QzcpuKIxpIMGNxLj28wzOFmzjE6EeUx817oUDgy+PnXkGAUpQAJ1ffZNZRcp+xuznk62SQX9e/HrcsBstuPB8mylbOXKLCZdwvczy5qi+E3ReM+Z0P++u5wLj18KfsCzeJISeqIK+PWkvUyF+AVtkJLxiWpz7L1BTCADVmvsHN2/ET5RUBPxyEgr3CFYXaWkis4ov/iiD+hbEX1Rz5bKreXwFrtUfCkjzCCG0oXMeWRcYNv/SG6lqFGfBnwmHNtk6zvMouG9J5jCqv/csk41QPFsFakkuXvOtd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFTfIuThTlooMWKsbHF/Eek4he/g6H+T9OgIXqeiiJY=;
 b=hv4GNI9CytQggmY28ynjQrjZz3Z8CJvIRHaFatiRY5OQIP+vMNfBYGrM90syrKkt8ucnDtzd3WqXWGmRaMnpm5/fX+QJcy43rTr7MWiIW+nocyNvzJJumViptvdeujp/LxBJm4dQr1RoB1mTd0rf3SHutrm5PfnaCBMsIx/KqalkwXq0msxjdJayAmQq4kFm/tbxAiqsrHA7C3CNEUZca4y4vTtua2i0o52xRe/Lzkwj2UoIHNFP9iJzAcjh7RBZpU/kTEZQ0n/Wdn9WopQDfHVshvf+N1SKpXDOyoVXmWIy9EEFp5/Bd7BJNcCijNi1F9Zsd4+iNR1hiud+w9wYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFTfIuThTlooMWKsbHF/Eek4he/g6H+T9OgIXqeiiJY=;
 b=JfxXsTTB6hoex0aQHuYot08ZA1YzQQfeVIWmC6HEDs7R81kmhfetx7WfYEjYOmL3agbGKnD4ypO/D6PhOx6myp1RAEQZKOA2CJ7C/rgDWudpNRLIWTEvQ3N6mlb/xHE+i5OuG9jMfb7SaclW6ALJqTUD3qdJtw/JM2m7EUFGnLhaT3t2naUYFKsRFiE0F+S0QGrj3ulIZjwfeVMQldp9DabCpTK5Xs5TqsoyfbEukJwQ4cJcOEHUYSZDIUL7XD8UzbxXLlwpebyqPexeGDSOl8UBRby6C7qe1/Yi4saVk6A57x1vctX1Hd8n0ASgGCjmyor1dKFcQGHYkTsv3QblmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB8761.namprd12.prod.outlook.com (2603:10b6:806:312::15)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 18:45:45 +0000
Received: from SA3PR12MB8761.namprd12.prod.outlook.com
 ([fe80::f72e:615c:e83f:b78d]) by SA3PR12MB8761.namprd12.prod.outlook.com
 ([fe80::f72e:615c:e83f:b78d%7]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 18:45:45 +0000
Message-ID: <49699aba-c9d0-4e79-a6a2-051bde16f331@nvidia.com>
Date: Wed, 7 May 2025 19:45:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "spi: tegra114: Don't fail set_cs_timing when delays are
 zero" has been added to the 5.15-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 webgeek1234@gmail.com
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
References: <20250507154528.3166427-1-sashal@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250507154528.3166427-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To SA3PR12MB8761.namprd12.prod.outlook.com
 (2603:10b6:806:312::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8761:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a09ab1b-ada7-469e-c17f-08dd8d97607f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KytiSEk5NG82R2duV21xYUM0c1VmaU9aRllEVHVxY2dDalU4MjN5bWNVaGlk?=
 =?utf-8?B?d2orV2xpY1VwTHZtQkViMndrKzB3aitpcUU4OXRpYVBlT0JPYXd1d2oyUkFS?=
 =?utf-8?B?TURiY0J5d3Bqd3JlSUZCV1BlS2FYU01RZDlZYVNzSXI4OVhxa3JPbHVieWt2?=
 =?utf-8?B?dmhDRkFjRTBLemdyRlRBNDRtQlJmcGsycUdmWG5PNVUvL3RFVWpiY2lpcVI0?=
 =?utf-8?B?YTFLT0dPZHhYVmh6TkRZa1hwRnlZSXJiOGsrUWZpZDVxWjBtdU14ZkZqYlND?=
 =?utf-8?B?T0wycHRxcGpja0taTjdsZmRuZk1HazhwWEdyMmZmU0tiOWY3eExKQ2o2MENV?=
 =?utf-8?B?KzUwZzk3bDZYK1RkcTgvYks1VHVTNmJZL3RmR2pJMmhGNU42SzRGbC9oRXJx?=
 =?utf-8?B?WW1ad1ZWQS9rQXN1czJaRXczbzEvRTVaNXQxbGo5V2VZTU9YSjVDUTdxWVEr?=
 =?utf-8?B?WjJTSjFzcjVsczhPSjh6VGdMblFqbTNER05mdWxJQTZDZ3NpK0dvM0xtWlQy?=
 =?utf-8?B?V3JNSGFJeTBTbUJiU1FzTlVRaGZaN0xHY3VQTmdLZDhPNS92bFVQeTRuYThF?=
 =?utf-8?B?bmh4b21iNnYvRktwL3laSThDTnA2cndIZG5zTFRKZm1lc1hIdGVQRFpBQWFH?=
 =?utf-8?B?QXVQenVybC9zU3QzU0o1V001QzVxTGNPUlJpRTNybXpNNGt4VlV5V215MkVI?=
 =?utf-8?B?c2dGeUtBalpVM3pSZFQ0MngrTUphZDFINjE0d0R2TnhEYjBWaHZBbHloeWJz?=
 =?utf-8?B?YzBrZ05RYllwT1ZHdzcybys1V3lPQU02V0xmQ0lNZStDSDQ5d2Z2d09TQzEz?=
 =?utf-8?B?ZmVkTjVBTnlCdXVrbW5hbWxzZjFUY1ZrMkN5TGhsejlEVWtYbEVBRncrS1Zh?=
 =?utf-8?B?a2dtdFd1TzIyRFFRZzhRcjNKK05HYno0dXhhbldHZE40MFIveERlenkvVXd3?=
 =?utf-8?B?VzhtY3ZsMnovdjhLTW5nMDhKR29ZRVo0NnV3dXgrWXgrWUo3TW93S1F4MDNk?=
 =?utf-8?B?MU1paUhFNktnNFFiTkc0RWcyS3lncmtsRkxBQ3lpUW95dFVEUFZLTnBJcGFm?=
 =?utf-8?B?U1lQUEpEbWYzV3FseDE3Q3dQNUNncVczbmo5d3ZSQUJ6Ly9iQjhKbFN5L1l3?=
 =?utf-8?B?c2RrK2VXbE5DYnRhZjV3Q3c4MlNaRkQwVDRnQVFrZUttTlpFZHc0bnpkUFd5?=
 =?utf-8?B?bEFKRXRTU3dJcU9JN200V2x4a0syM2lGNFNYRVRMbnNPb2FlQjJwYTJVK25m?=
 =?utf-8?B?N0VlOVMvSitTeU5pdmxyMjJJNzAvVGNEaU5jZTFsWlRKejU3NWxtbkxnUGJz?=
 =?utf-8?B?WkI1c0hPbFN4WW1oblA0dkkrSkN5Rno1bFkxWEZsT0E0a2toNlBuWUZLck5E?=
 =?utf-8?B?WXBXZzA4V1A4T2prTmMxMUgvbzgwMDNyK2d1L21adG0xRlJjWVM0Wk5ZdGVv?=
 =?utf-8?B?bDlhVVNYdzc0c3VTZWlwSXJWbE5KallBRFhpZjM4VEUxdkJPTjl3T2dWRWhK?=
 =?utf-8?B?UU0rUS9mbzFhcUhtK2FyUWQ0cDdseENFYytsR0dSWUxaVW4vcE5UUEhxVFE1?=
 =?utf-8?B?UEtNTXVneFZhWkFnUEUxekFyazc1cFh0VWpqRGpsTjFLbDN1VVN0RTZyNUNz?=
 =?utf-8?B?VWFKVEJwbWFtaitKcmp4OGFrNng2VHFKRkR6MTVVRjUrVTZsdFpxMVNaSXRl?=
 =?utf-8?B?Yk9WdXJGMWM5V2NBZGFXbnU5MmNzZGNXK0RaRm12b2FNL0x6aDRqeEZUbTVD?=
 =?utf-8?B?bDBHTktKU1RqU0VBV1Q0YVRXMGNMNG90UzNsdjZKeWtlR3NRU0RQZnFtVWlo?=
 =?utf-8?B?V1JEbzNvOUxjVlNoTE9TNjdFQmp6eGIyL0t3T0RVSFZIS28yOXE0cHhPZzkr?=
 =?utf-8?B?L2EzS1pacG0wOVRPd3crdXQxZ2V3Mk1SaGhUbVdVOWsraFBha25DM2ZRcjVk?=
 =?utf-8?Q?cCAzQaLMBqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8761.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEFJd3UvNUdoRE1heTdrL3lFd2tUdi94eTVMNHQ5SmxiTU5IbWh5cDZtTDVt?=
 =?utf-8?B?c2tTZjNtak42enB1N1R6Ujcvd3ZWQmM5ZnFSaDhZQXRSZDFNYjdjTXpCMTRG?=
 =?utf-8?B?aTdLRmtwTDczaDZHZ1ZtWkZIS1JnUm1XWkN0RHNUcHJrRXloVW1pMk8vK0Fy?=
 =?utf-8?B?M1ZiVmxJY0N5UU5NY2t5cXFZYUVVQndvT0tPWDBBbjlqMGZrSGFKd0ZtNVZU?=
 =?utf-8?B?OUVzdGNjallwclZKVGtmdCtuMDFSZlg2dVdlTit4aG9VT3ZqVlpSVEJsN2Y5?=
 =?utf-8?B?L0xZQ1FKR3ZINlJ4Q0tWa2VDMUw0cllCcmM3NEdLWFBtNklZVTRXVjMwLzNY?=
 =?utf-8?B?K2Yveml4MWl1TktsSGdPM3RaUXhjcTVDa3lkdmVnSkZqNnZxak9nUVZ3ckc5?=
 =?utf-8?B?NDI4WXFDRldEVzJEQUxFMHVPNFU1aTJ1OHpwWFk0WjBldk9IS1VVdytiSXQx?=
 =?utf-8?B?UTA1TGM5bzkxc2RvWUFVb01sdnYrc296QnR3YW40STBSUFozNlgrdEUzN1B0?=
 =?utf-8?B?SU5iQ0x2YU80ekFzWFlwUE1vaU51M3ZKMkgwbzVmQXM4N042N3hkblVpekp1?=
 =?utf-8?B?QWI2T09HT1g5Z1QxOUt2ZGRtaWxzZzA5OWg0bGNrWGVHWnl5bXUzRkErMmx6?=
 =?utf-8?B?b3I0SEVadENQV2JNdXJ6aWFIV1hYaEIwWE5YekFxMkVneWFzVFh6NUZXMU1Z?=
 =?utf-8?B?TWZPbm5VTTVZdmI2MGRVdkd6VmRpZnUrVXRCWmxMWHUwR1U1OTM2c2Z1SUZG?=
 =?utf-8?B?NDZRRkZJaFBXY2U0Q1JwMUwwTlBhUjYwMXVPZnl3aFFrWWFpTUFGT3hRWUZD?=
 =?utf-8?B?RGlXb2NaS3I3b0NTVlBnOTVVSmhScXp3WTc3dkVGblpzVlhiWFQyUFdDd1FK?=
 =?utf-8?B?WkF3YmxsdWFIRGNFYlQ4K3lPbkttYjlhd3J0TXNrU0pIWEVvblgrUUEyRUdG?=
 =?utf-8?B?cExUZk4yMFQ1dlo4cFBtTmZWVTJaQUZKdktoODV6QnZxVmVjWEV1MFZUM3VX?=
 =?utf-8?B?R0dGOGJWMDNLTkl5a2ZGZDBGUzhLSnk1MUhaOENSWU9ucWFwMXFpbFFjMkZa?=
 =?utf-8?B?MlZHQnovQ3FiSXBYUytabW5NZmxzZERiV0FPQnFWT2N4V3ZpbWJJS29hc1FV?=
 =?utf-8?B?enNmckNVY0dTZkNDVGFObGQzcEZ5MXRYTjBVeHlqYlg1WS8xZFF0THZBbEMv?=
 =?utf-8?B?SXZKSHIxSFJZZGZZemRnOHpiTzIrTU9mb0lJSlN4dUcrZXB6Qms4bWdSbFBV?=
 =?utf-8?B?eW5Oc3dMbGJhcmx3SllXVEN0K3RzdGdQSk5iZVk1d1gzOVBlQ1kwbkVBYjFU?=
 =?utf-8?B?TjYvWWpveThzbHBxOEpRL1c0OEgxdXBLaWRuZzBBS3dvNXN6UXczaFNBZmRj?=
 =?utf-8?B?c29XZ05Cc3hVVWVwcWtrWCticldMNUJUT3FDUkl1aGJmdldKV3JKMkhGdnYy?=
 =?utf-8?B?TzV4RkJxV3VEOEJseS95RzNhZGhTVUFCeEl1akdHUk1TR2cwU051VmV5UHBr?=
 =?utf-8?B?ZVExZGo2Rlh6MzlkTWMzSHIwR3ZiRGZCSkhaSkZDUm1scWJrS3gvUXYyemxP?=
 =?utf-8?B?cFBYZk9WTnFUMlA3SmM3K1Q0NWhEa0t6dTV6SlBvMlo1V2tpaVdDUTZPeWtM?=
 =?utf-8?B?a01Yb1pEcFVDYnEzMXd3VnQ3K3hYVDgvNnpOVXlMYlpyZkp2bGEyVWIrZFlI?=
 =?utf-8?B?bVd4NHBtbWNabC9JY0N1Mlc1Wk9oR1ZUMENQZkdGMjJUQWxVbFpnemVEdUtX?=
 =?utf-8?B?bjJPQzJnajB3MkJ6cWJxQlZhenpQTE5rVmRXVmo0ZVBRWTdCZUxTTy9ZYnRT?=
 =?utf-8?B?dWc5a3hyK3lyODRGTVR5OHZiR0o2djZ1anFlUFpuVDgzdDVJN3Mxc01CSGJl?=
 =?utf-8?B?dlVNZytxcmxhdm44a1pzc0RsM2FWU28yN0ptUFNjeThtZGtTaGxhQmdKV2ZI?=
 =?utf-8?B?cjB6THNYZUpraUlvMVk5cnBQZEo3cE5rc2tJU1phRU04TTJ5cnV1bGN4c3Vn?=
 =?utf-8?B?eXgxZURNMksxZmh5eGw5TDFCZlc4OVIwbWx1S1pqTGc5TEtucTF2cGNTM3h4?=
 =?utf-8?B?aWtYVmNkSEZ2SVhrTjd5NGFhL2RGcVE3WXpZV3V5bnNQdmY4Z255SWJCNEo2?=
 =?utf-8?B?T0N3SXJ4aXN0dlhKMTRaWVRYbktiZVJWL055cTdOamdBZVBreXVHbm56R2ZK?=
 =?utf-8?Q?wJzAyB8KZgfZ2GbmH4mCv5Iwo1hYQeR86hqB+066SFBm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a09ab1b-ada7-469e-c17f-08dd8d97607f
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 18:45:45.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClmIKaNu8hGHK+oNu8DGLPwjT6P3gVzs+nfMUZgv5KXYkonJT1efM1wAJM00vVkNZtJ+UNENscv6r9GUxp7NxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364


On 07/05/2025 16:45, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      spi: tegra114: Don't fail set_cs_timing when delays are zero
> 
> to the 5.15-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       spi-tegra114-don-t-fail-set_cs_timing-when-delays-ar.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.


Please drop this from the stable queue because there is another fix 
pending to fix this fix.

Jon

-- 
nvpublic


