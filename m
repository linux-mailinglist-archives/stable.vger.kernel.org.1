Return-Path: <stable+bounces-67712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A795238B
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 382C2B2140C
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9171C8FC7;
	Wed, 14 Aug 2024 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nblc8vTl"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFED1C57B7
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723667976; cv=fail; b=U5hl2vp/qCRlOoIfWcr7IWOZAEgoWB0vOo2E9lIEtSs6F6lZqH4KYVydu6hBrolsW5CH1joryfzOjxW9QVP6Br3Rz+WDGFi+vC8QHWQNcit1auTdsr+2kaHdOXW8oPF2cMJK/2Iw6G6ZbzUKKtQm1W4YUTr0xJN3fuF9kjsqsJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723667976; c=relaxed/simple;
	bh=CBEqCNEKVZwzLjZ373k+3vLxnXhwIDKWM0iOOZddbGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=otWFEicy9efAzM2vznSpPbc64pfIjjn8thDGeuPaQxJwoumZpvNm4PcQXeIv7ZDCg5rtMC5xLW0AQ8oyhWZu0bCVXxa+YwGRGqj8OJ3XZZW78WQE0MvWPEpfelpHtQsqAn2NKwzO823Dxnj9G6HqvWRqs6tmi87VDHuQNQ8dCXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nblc8vTl; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvfBmjNSaYJLh57BMglQ1HG70+ZZ/nfQUzJ6JUaelYcmqrOBvbPDU7t7gnpNNx173FFMt8CjVaDzYOkpPU5sex8f78k9J+CyfPHh9zRrtttoRoWiflZMg3MQmYoy8mjNZVbAGGdej6Z3HK2h6ymwAAvw4AG5QE25lTvTOC+arJ/IwnVovn3KymSqGTsFwygde3UuWYuiqlZxm+JyhYYpEpGNZscExsW5kxi3dp6xfkBNI7UAtHojZJQSchRS5FcAozoE6abQc15w2kE+m2bUchXs6+f3Pbh5xKvgEzAyDSIsy42pZB0ItqeXe9Ey8Ob201HLHXD6zt5YdduQHKCBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiXzD54ayew3fIFfLysdKKqKC+UV7VyzKQ/XT65Ijhc=;
 b=DPq9cbVO17TcvkQeY5HlC3A/BHMaWYdOBM52KddBx4W0lyYcwOCusu3mmNn3zY3BR3rcsX3h9iC9MpFo2/jNL6E3tc4yJWCp6eDg+AtmpF5Mao+iUcXYT4toAN4m/yScILGnwx85KLDY7/zivON9FixgLHGsuRL+eb8AtiOC+H/LnMTKeuLL0Gy5nbItduTpW8j9YpNi08TQrMN9k2mEclivzqCRvvV8kdvHHotFTsRjlNDY78Rxk8CcjxAFj/9W2/oqijk4cROG0vAkjz8k7TkEvFKSsXzK9HYH/n2ui/Qri9Zip+Fb6c3kqU07wObqYVKb6q3MM+3xQyq1z6be1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiXzD54ayew3fIFfLysdKKqKC+UV7VyzKQ/XT65Ijhc=;
 b=nblc8vTlYR+xDz1qtGmahYRP/V1G0V2O/Yr9yY1UuAc2dBtZSQ2BxMRvftmgamWoRDyaFHmtpPzS5TWtSTizF6AckAVX6RtfiC8NuceOoPrj7Jctob7oACmbCn6TudtxxTIowcGcdHBR2QxncSywq5UJs1GkXCvDJqew8ZGj8HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 20:39:31 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.7849.023; Wed, 14 Aug 2024
 20:39:31 +0000
Message-ID: <07bbc66f-5689-405d-9232-87ba59d2f421@amd.com>
Date: Wed, 14 Aug 2024 16:39:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: AMD drm patch workflow is broken for stable trees
To: Greg KH <gregkh@linuxfoundation.org>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <2024081247-until-audacious-6383@gregkh>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <2024081247-until-audacious-6383@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0010.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::23)
 To BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4a2a15-f7c0-4b12-2828-08dcbca132d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVB1V2JtS1RGZk5UUXFLRGxtN2M1SlBaWU5pWlNldW5TV2VYNTZzcThhRmFO?=
 =?utf-8?B?MU1qMmlDOGtTR1ZqOFpDRDVWcVBLUHV0VVNJSGxHQUtqeHo3aytaNXEyUngw?=
 =?utf-8?B?UEwwVjNPeTlzVTJWN3d5RDJzZ1ZJenNpOE02OEhoTVhiT0g4MEhCMFdKN0Fj?=
 =?utf-8?B?YnVYV2RxT3RzTGNnUU5kd2NNU1hsK2FRZmpxcDk3WkpXVWViaVphaFZZNWZU?=
 =?utf-8?B?M0pDR3pTZlg1KzdsZHJJck45cDAzcU1acUtObFk1TWZLTlhWdVgzaUlqc09J?=
 =?utf-8?B?QXJYSmpIOWxZVkZNSmZ4UVdURCtWZGd5bEhzR0p1bWo0SjVLNitua3BiZmxu?=
 =?utf-8?B?N3VqcEFoSHZTY3htSFk2cWtVTFBYTFdqSkM5QXh2K1dNNzhHNEhsMjNGekc1?=
 =?utf-8?B?T3Z6Tlpvd0FmRXVQTlBqZlhOYVQ3UmNZS3gvb3F0Z1k5U2d2TjFFYWVrUnU0?=
 =?utf-8?B?ZjZzMzZRUkVnL3gvQzNtZTh3dG5DMVE0ZkxONTFDTjVGMUtWbXFQRDJ4VUt4?=
 =?utf-8?B?alJRNWZ3dFJBWHY4RGhQUkdNem1LOW9PcmV4RTQxNTJmaGtCY3ppaE1mSVBD?=
 =?utf-8?B?L3YrOFdDVU1lODBjamErdWtWa0x1L09RbEZtdWVSbWJLamR3Q2U1NmMydDhO?=
 =?utf-8?B?VE1YbGNkSVRFWHV0OGxkcUxkR3QxNCtHZ1FNTDgrQmE4TnpsS2NRaVJUSEE0?=
 =?utf-8?B?dVNOd25hOUlwN3BzazJENDVEOGptNFpyNmh6MkpHcEpqWGRNRDNQazg4cVc3?=
 =?utf-8?B?eE4wNllDbEo3RjB0UklkK2ZDbE9jSFZXS1ZmRVJWVS8wWWxGbForOGx0SXBK?=
 =?utf-8?B?TldPQ095eklYejZBSENIMHdnTzcvVUJFV25MZGZEVk5NQzFOWHFuS0Z2V2N1?=
 =?utf-8?B?QUZXLzNPZFpjM0YxVVNhMFNZQXdXVGxTb0d4OVdqbGc1YngwYW9hd0dPRktq?=
 =?utf-8?B?WkNweU1BNHdTck9uMGpVOE90OFJFZkNLVm5jYW5YbGI4Q0tWcXhNSGhha21v?=
 =?utf-8?B?ZktnTHdTQ3VIblhRcW1ZWE0rdTdTWmh5ejJHVXUrNjFhWGoxNUhUT0x6MCtj?=
 =?utf-8?B?V29Vb1JWOFU5NDVBSldBNjErVEVPM3JiN0lSdGFGdVRCLzgzdG44NGM1WEtY?=
 =?utf-8?B?UnFkbVlaaUpiL1ZEYU43K3NhVjZPMXA1cDlDSG1xVjFqR1MwekdJcU9rRHF0?=
 =?utf-8?B?WVVkS1cyNEwrY2FnZ2dJcnB1TU1FaS9oc3FGdlVld0xseU1VWE8yUDI0Y3ZO?=
 =?utf-8?B?b05yQlVtNGUrSGVGZUFJZWlGc0k4VDRIYkIrRndaVnZXblM4N1d3bWhqbWM5?=
 =?utf-8?B?NWVCYmtwQXpFMGtGamFNVHFIbjNNOEZwZ25jckNjZVZlQmFUMHhtaU9DWGVs?=
 =?utf-8?B?NW9zajlsMTR1V3BiUzI0a2dhR0Fjc3FndkZQVVp1bm9XbDFucEhJSHZDbWQw?=
 =?utf-8?B?dFJrcmtNWHpwR2hvaUpZeWVMRUErbHI3QmR1VStGNWNWdWdDQ3F4amsyUVBz?=
 =?utf-8?B?VFpVQkV1V2dSTlRZOWVUdW5IekNvRlJwTmpaYUhVNXdKTndYU1ZXTUFlT2NN?=
 =?utf-8?B?VVJWMHQxbUE1SFkyaU03dmNkQnY2akd4VzhzKzNDTFloV3RCR1F1d09RL1cr?=
 =?utf-8?B?N0hsa29DU2Y5bkNJNjBDK005Y282SENjT282MU9qQmVPOW80eDNNSDZLdUZv?=
 =?utf-8?B?eXpTeDh3ZnM5UC8za0RUUldIV0RlQ2d0aVlFUjBLOVBnRUVvelluU0xwajYy?=
 =?utf-8?B?Yi82ZnptbVBKaTNUdDI4MEpTdDJoQ1hNTlhKeDFEc2V3MFNRSi8zOUc4Uk8x?=
 =?utf-8?B?K3NveEZBYkhPeHJjQWVwUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU5DOGtTSU9UN1ltRWIvT2hxbUM4cGlUWThIWm91RU1WQlZoRWFLS1cwSDZi?=
 =?utf-8?B?V0Y0bEh5SWhtRWtaRmpHYUszZzlWN1diNjh3Y0tSbjJSRUlKM0t5OENWKytP?=
 =?utf-8?B?RDlGMHFxeWZNeU9GSExmSVVYNW13Z255Q2FkUG9jc2h3R2pETVpEdFNVVEp4?=
 =?utf-8?B?bFRYSDVqeUpubk9IamJTOGZZY2VNK0dxTEM4bDQvWnBPdnVwRnR0Rnd6MUZ4?=
 =?utf-8?B?dHJjemg0QzdHSG4xbWtKcWtRbTMybzFWY1NJbGlEQitLQlpjVGR1NUoySzBr?=
 =?utf-8?B?T1JuYXRYaWtsN3JwM3N2ZlhCNGFsdGVVanFCdEhDckUxaW9Oajh6bU1XUW9V?=
 =?utf-8?B?MEU2MTBreDlkcUJjWk10VDg2UHc2S09MdmF5djJUa3Ara1Y4T2lseTNWQThr?=
 =?utf-8?B?RkE2T1FxWkZlYmdiZnAwK0xQVEpmT3ZmZlFDeUJJUDdrTGNoTW9MZmFLdWZF?=
 =?utf-8?B?U2IyUk5nRjFEVGw5Y2JvZjV2SGMrT2tMem1JWEpjUDlrcVJhajRDSTFMcFNJ?=
 =?utf-8?B?V1VFTmtWY1JpVWx3MjBqSHRQYktONEhJQ0R1aE91RWxHTFV4dEhnNCt3cklL?=
 =?utf-8?B?TVRncU9WSE5TRjBCQlk0NmV3bDlVdHRRcnpKa3AzN1dCSzFxTjh5bE4xa0dx?=
 =?utf-8?B?OEgwWU00UFNWUG02bUJ2QWNmSTlwSXZwcFJQZTVHSzR2TUNyd0JMWUczMjlk?=
 =?utf-8?B?M1J2QzhQTlQyU3VBWkxXM0dPd3haV2tITXdZeXJzS1Z4WDFieTNqVmYwS1E1?=
 =?utf-8?B?VHMxV3MxMVhSaXVuN1VzSEZpTWRmMWdZckp1SlA2OVEzWW56MG1VNXlYdkVF?=
 =?utf-8?B?OFVuUGZNN0M2aWpHRXJhSkcybE85Y2tta3lQclFDaW8vRDFYV1M3dTlwUXQ2?=
 =?utf-8?B?SFFBQ0Q0Mytmakwrc1N3ZUp2RzlNM1JqMk5hZXM0bEM1L3RYVDA3THFEcXFa?=
 =?utf-8?B?UzJORk9ZNTE2ZFF6SmhLazRMM2FOZisrVFdFV0N2Uys0T2tRYmsySGY4UzZu?=
 =?utf-8?B?RnR3MlZsL0l2M1BCQmgvRlR2YUd5eXJDdHZ3TDZoRjE3Y05EV1h1eElqazU4?=
 =?utf-8?B?bTFMTHVoN3h2NVhwRDJxdFJJbWgyMDNMd05WanNVMENpWHRhY3ZxSTMwN0Y3?=
 =?utf-8?B?cWFDVGwyMTdaL29VdEdXZ09NVU5mZWtIM0dENG9hLzE1d2hxQWhGTWttUTI2?=
 =?utf-8?B?TmJPV2djdjFxVUIwc3owcjVYMXFBVTJqZnYyU29GeDBYSFJKQlhUVWhnSUVu?=
 =?utf-8?B?djVGOGJJeGd5UHM5bS9kYlZwUUNSWWUybnNidUJKTXcwRk1kcGRVZG1vWUhy?=
 =?utf-8?B?bkhXSGFxd2hEU0NhOVUraTRldWk4OFE1Mnc1SVE5WjZTMENINnBWcWt6SlFv?=
 =?utf-8?B?N2ZacWdmcDhya04vT3RHdUZqWmlsL1BZdUE3eWZ5Y2N2eElvUDhGOVpleUlC?=
 =?utf-8?B?T1hGUXdKQzBBcExWbXdSS0JCbnFiK29lYU9GdnFieEFmbzRpS05TQXo5YW51?=
 =?utf-8?B?WlJjL3laWTFGbmZ4ZFpqR0lXUnVobUNwVnlPMWNWcFM2VTZyNEpJdXRzSkRG?=
 =?utf-8?B?OUNPY0d5anhtak9tcUhCZm8xR3hDVXA2RmtZVk5mRmlneEtrd0tIME9mZjVE?=
 =?utf-8?B?T0ErZlh1Q3JJbGQvTTBBbTdhRWc2RE13VHFNYXFObG85bktnQVpGYXR2a2ZQ?=
 =?utf-8?B?ekJYSGlPVWtFcVk0d1hPVFlqamNqZlNQNklkZ1hIQzZhb3llNWNjS0s5NW41?=
 =?utf-8?B?MS9Dd3luNm91NTQrd1hpL3crV3Y1U0pRZm5oaWdNSXJ3emZzZmVGVVZCUmNT?=
 =?utf-8?B?WDlzZ0thUE9LZlBmTG5ZaGJlZFJGdjFudUM5OHg2MnkySDFNcHd3THF5SmRY?=
 =?utf-8?B?ckl0L09nZlliNmVhUDRCeEVZcGFSMWdGcjJpdExMVXdVVTNuRUJPcWxrNGhZ?=
 =?utf-8?B?UERwWGhocjM1cUhocGEvczhFcFErV3lXUTVxckM0UUN0cVlwMFlwOFdTcEo0?=
 =?utf-8?B?b0lPU2dtODNBWGhtbmFJY3MrSmRPbjRMK1NnQ09zYjdheXhiT3FreEh0Umc1?=
 =?utf-8?B?U3JJdEszZ3EzOENrMHp5MzlvdlF5ZTBjNWhDVHdhajU3bGVhc2hWTklpMnJi?=
 =?utf-8?Q?autJ6OsvHW4p4IqTFN052ge3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4a2a15-f7c0-4b12-2828-08dcbca132d6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 20:39:30.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xxq7RIm+AmHQ39+aiwQtYj9/ilcZk3QEhCFzK4dqTrRquxDADSoJIow8HYoDyOm7U4oeWBRl00Ati33inpJzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375

On 2024-08-12 11:00, Greg KH wrote:
> Hi all,
>
> As some of you have noticed, there's a TON of failure messages being
> sent out for AMD gpu driver commits that are tagged for stable
> backports.  In short, you all are doing something really wrong with how
> you are tagging these.
Hi Greg,

I got notifications about one KFD patch failing to apply on six branches 
(6.10, 6.6, 6.1, 5.15, 5.10 and 5.4). The funny thing is, that you 
already applied this patch on two branches back in May. The emails had a 
suspicious looking date in the header (Sep 17, 2001). I wonder if there 
was some date glitch that caused a whole bunch of patches to be re-sent 
to stable somehow:

    ------------------ original commit in Linus's tree
    ------------------ From 24e82654e98e96cece5d8b919c522054456eeec6 Mon
    Sep 17 00:00:00 2001 From: Alex Deucher
    <alexander.deucher@amd.com>Date: Sun, 14 Apr 2024 13:06:39 -0400
    Subject: [PATCH] drm/amdkfd: don't allow mapping the MMIO HDP page
    with large pages ...

On 6.1 and 6.6, the patch was already applied by you in May:

    $ git log --pretty=fuller stable/linux-6.6.y --grep "drm/amdkfd: don't allow mapping the MMIO HDP page with large pages"
    commit 4b4cff994a27ebf7bd3fb9a798a1cdfa8d01b724
    Author:     Alex Deucher <alexander.deucher@amd.com>
    AuthorDate: Sun Apr 14 13:06:39 2024 -0400
    Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    CommitDate: Fri May 17 12:02:34 2024 +0200

         drm/amdkfd: don't allow mapping the MMIO HDP page with large pages
    ...

On 6.10 it was already upstream.

On 5.4-5.15 it doesn't apply because of conflicts. I can resolve those 
and send the fixed patches out for you.

Regards,
   Felix


>
> Please fix it up to NOT have duplicates in multiple branches that end up
> in Linus's tree at different times.  Or if you MUST do that, then give
> us a chance to figure out that it IS a duplicate.  As-is, it's not
> working at all, and I think I need to just drop all patches for this
> driver that are tagged for stable going forward and rely on you all to
> provide a proper set of backported fixes when you say they are needed.
>
> Again, what you are doing today is NOT ok and is broken.  Please fix.
>
> greg k-h

