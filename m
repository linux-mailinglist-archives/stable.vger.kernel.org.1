Return-Path: <stable+bounces-141937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1D3AAD0B4
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0C01C4115C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F9273F9;
	Tue,  6 May 2025 22:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yd8+hpfk"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AC82B9BC
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746569017; cv=fail; b=JHxrzn6i/DRK0jqoq24obye+wAoaV/sLvcDG2Su/SVJzvVd6diw8pIllffd9S6C5gAIHRj3qq/ZdhTJDSm3jqRGnz278SfRwXNfnWbBta2wK6qMbkZEVPZ6F1WmTpI0z9SBgTIPAJDZNxdnb3gIB/egIt0CffhBmXO7SYEqhC24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746569017; c=relaxed/simple;
	bh=uQUR4TaNESUQgu456qF2hf6EHktk9Ezo6P5ucBTMnbc=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=NJR3QELTW6gMM0JthjmAWSGTP7icCq3RzX+2wD5T7D3DX4aZtZjx3pF0EUfWwAVm2scLMcJKTTQ/TVeEKD7x0kcbyjxdKucs4K0HcfaqDfLL41+TiyfuljUbZGQogp0EwfvMIIxVxenSsIpahxzASwtmbWzMYBUWIjGOAKLIK0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yd8+hpfk; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvpHsanVRQtS+eC3SIds2eh4GNXpjOVN1Z8Ov7FKTZt3Jc2Nmbbz7YUma/k9yCTpeAJEifl8SznpWpTgFdI5+mSB5sHz+/FHO3+gXiVbPC6mJa6R6ywTCxH0NRQLscF34Ot0BG9TE565AxWB8IYtrtEYvrifRjqKjSUHAghvdENr8qzPaSbFLVBjOEeMFCd8UinJwwS04BiJpu6u9KsUWnNxbYT5aC3MiZzCFTY+mNwPAAngFmB7Iz/abS3RNIdrMi3uBpN0oYy2kPMD63inh4uG+CaxaUU/jX/aD7fiC884rOvn6sDG3CLblS7mz3Y0XMi3r9sbVxx87YVwDOldow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3izSPtlakGxlLYL7voruCZXyCFPYeMDUtkHJpXSlcI=;
 b=ZdkZM2++Bef26IdTnpIV/vxAN7OwuEnZH4kwCb/19mdWgBn391vWUDAasZVY9+UxNp4bHRfHRDeD7dVwrR81vMVk76ZDkNuN0HTYHGUZz94yHAYneV+7nOuAGiDff2IbsnA1Rj3MTczsGjrNHhz3fbVBpkvuEcptCDJEb5sCe0T/vLNu7LR1wfu2QwrX5a1QFCHRtmSnao+SdgTuunvOKKmMUPR+Z2ifIu3tRECcc4BsmSPBCjJvYadtpu1UPUvtyOYADtWT1IchOu9Sj3Gbd+6DoqSQGH2dxyseWbW76Od9cZW/rPTPJagbn1ZfSh4Rf7pF90IFaLLcgzZ6m+VbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3izSPtlakGxlLYL7voruCZXyCFPYeMDUtkHJpXSlcI=;
 b=Yd8+hpfkoNNlYGj3zs4iBhSLVHMsUHcuKycD+pKaNNEgcm3BDGQunz1z/5uwRVXM2OvSO+HoqYjIl0qcJgdrFRivFC37ooP6IQJf7ly85UNUUUIw5OjBbM9x/gHzJx1oFigdOcGqaUWw5o2v449EQLMlYwZabzY052nqiL4vPQa19toBbrNNfTOvWfv0J5mYD9wtyciW54lAFR/K056WpMlZzvgC5STQXS1JZAUx74gzJeSFSI4+ZZbwklpO3gZvJ/DDZBoQTNUUAUNeIB/tgfrkOQiGDRkKTTp28QETFKCituulM4kCvcfQfg9NaHjGnOSl1BkOe1ChWTtF7CzGRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by PH0PR12MB7079.namprd12.prod.outlook.com (2603:10b6:510:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 22:03:29 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:03:28 +0000
Message-ID: <bfde1b49-2296-4d39-bef5-b1e1591fefc7@nvidia.com>
Date: Wed, 7 May 2025 01:03:23 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v1 4/7] ublk: improve detection and handling of ublk server
 exit
References: <20250506215511.4126251-5-jholzman@nvidia.com>
Reply-To: Jared Holzman <jholzman@nvidia.com>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Organization: NVIDIA
In-Reply-To: <20250506215511.4126251-5-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|PH0PR12MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: e36e2ac7-60f7-493b-d587-08dd8ce9d521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUN3UHhuTFFGT0xNQmVYa1oyQVNpSmdsL0g5cEdRTExvdWZGdWdzeHNSY1dC?=
 =?utf-8?B?eTRoeWdOR01rWTdDcFI0d0lTanljQ1Z4aEozVUp4RWFRRVlSNnBjOE5KMytF?=
 =?utf-8?B?dUZOTS9QSkhkTlhRaDFRSW1PdGNYaTV6dGdMMTdjeStnTVIwZUVYNXk0UUJu?=
 =?utf-8?B?ZW0yTFlJOVFsdUtWOEFYMVNQeWYyVjBxNG1wWFl0a20vN0FnVEhHSXpNRmxJ?=
 =?utf-8?B?VVQ5d29aQU5hODVoKzlSdXZpSmc4Vk8rQXNMOVVjZnJzdmF3WXR2YVlPYm91?=
 =?utf-8?B?dzVCaUMwazZxRjJPMDlIUzhmUUZxbithSkpBZUNYZTY2SHNUaUZnRldoa0JT?=
 =?utf-8?B?VDVaemJ5WitWY1NGZitrdjRocVBYN2ZnR25RSUY3WkhJalBPNm4rckFLRkRN?=
 =?utf-8?B?dEhrZFc5dU9kVGcreVZhOFFoYXM2TEloUWwxU0RBRnNUQ1lOZHNSOGZkV1BR?=
 =?utf-8?B?OXdpMytHSnRBQWlvRzBDVDFVc0FDb0hCdGNpbG1iSG93U2liVW02Uk9SVTNp?=
 =?utf-8?B?TDlOcTB5ZWdFU0ZsZHlUQjFhWkFuZFNneGg4NVI0TlVNdjlNaVZKOUFieFpC?=
 =?utf-8?B?MlFxamoyWmUzUTJRSDRVSUZtcHQrTzJGQnAydDFQSXpXckdFM2Q0Skhibllp?=
 =?utf-8?B?RC9RS3E4UUZKZUhFRTVvTmJJaXNXWGlXaDduNEdkcmZyQlhnaC9EczBlMStE?=
 =?utf-8?B?eVYvTjBuRU5EbU1uRmNaT0loNEluNGU1bnlISVRaZjRoalRXcFZWZVNVYjBY?=
 =?utf-8?B?Z1FnNzJpREF5ZmtvNGhXeGJKQWZ2Z0lyVUJFaDcxU3MxQTVneUxYWmtsbUpE?=
 =?utf-8?B?azBNYVFaalJvbFU0aFRkL3JXOXh4eXdONkU3VDlWTFk0ZStQY1MwRUFlUjht?=
 =?utf-8?B?UjFTZUtkL0RZNXZLbGdYUG50REk3dWJRSlI1SFVHemlFR21iMEFMeEs4eXpK?=
 =?utf-8?B?S3ZoSHQzSTh5R2Y3OThENkdWUWRpMk9NclRJczFMQ09OdWM5OFRkVk5ib3di?=
 =?utf-8?B?VDhYZm1GMC80RExDWU1USGttaXY5OGdZT25vMytYSnBmcnlzdlRwUWtKcUV5?=
 =?utf-8?B?Q1F2N25McStzZFBIODRyUXZFTms4SENjRTdvRmJOVkYrNFZaWTJaOTRnQWRn?=
 =?utf-8?B?THo2ekVXKzBQZkQ1ME9jZzhEeXpwUXZaRWhUTTlnNG0wWFREY2MzQk9nZnc0?=
 =?utf-8?B?YmthLzE1N2pYQUNyUEJ2dE9XV1JtRUJINVJ1dXc2aFNYeVhEcU1iRnAvQ0RZ?=
 =?utf-8?B?Q1hXR1NLbWxmRWlxclFONTVVb1FUVDh0TlowYTVGMVRnbnRVcGhQaXd6WVJs?=
 =?utf-8?B?VE5DRzZ2QnV6NE50SEpaUm9aVmpoN0ZHbWEwL0ZiTkpEUTlMOWJ2K1VjdkUv?=
 =?utf-8?B?Q0pySUMyU0M0Um1wTDFISDRQV3VDazlCTmw5LzB2NUNFVnhhSTFJMzdTYkdn?=
 =?utf-8?B?S0VvR1ZuOUc4TWpuY0xvc1VKMkpiZ0Z5aDh6OHRtRHN4d0FPanYrKzZGNVE4?=
 =?utf-8?B?Um9OVlRtRi80QzhPaTBZNEo2QlVBajhnZy8xWE9mWUlCb0poZHhRcHhPcUpC?=
 =?utf-8?B?R1Njc1ZUbXZReUNhSy9jQTQxOGkyZExqRDZIQkxkUU5tQU53TEtGeERyK3VX?=
 =?utf-8?B?clhtT0JRYzlCbFV3TmZ0cDdSdzJuRENmZStZUlA0MHBqd3dVYllrYk50ZytW?=
 =?utf-8?B?NnFHOHBhWStOa2ZkV3pPOHNKd1QyQWRFa3hjSFhIVy9UU1AydFlVaHIwdGxW?=
 =?utf-8?B?QUlXQktqUUhIZzU0czVlNWZLNkl4Q1U5TDhRVC9XL3o4VG1xQmprcUJGTWNq?=
 =?utf-8?B?cE8xYXB4Y296dFlpNUFTMEkrZnd3UEkwT1ROcE9odVFVenQ5TTNuM0xrSTdH?=
 =?utf-8?B?ME9zTGRiYUtpV25FUUNNK2xVODBWYWpTVE1keTVSV21hUXl0UzQ0TUR0MFg0?=
 =?utf-8?Q?i629nVkTvpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck9EdEIrazlJQTliSDMvc0ZvL3RnanZwSnMzak0xM1ZFU3h0NnpSZnNuSUlt?=
 =?utf-8?B?UXAyR0NtdmpNNHFrd0h1K2oxb3V1Y2hoQUNtNEJJUzZpWjBZWjM1K3pGMkNP?=
 =?utf-8?B?UEkybVoycytaZ0FYWmtISE5vYXBpeFMxRFZUVFFzOUUwM2N2eVFLL1RuQ1Ru?=
 =?utf-8?B?T1dtaEJHRTBrU2JwY0hKc2lVeDVwb29GdkIvUEhkR2JXSzY3MFNUM2MxZCs2?=
 =?utf-8?B?S1hIN1NVanBHZnNmWFIwemhta3ZVa0ZYZ3NPK1FpcjU4cytPZGpYVjlBUUVN?=
 =?utf-8?B?NXhCS2h2di91eUhkQnhXbXA3ZHIvbERCUk5Bb1lJcnBFOUIzNnlyeWtGYUM5?=
 =?utf-8?B?TkFnNGRVZTRSLzBidDlDQmxvR3FMM0xsMVVaRjUvNjVLbmVLSDZCbEdYZ1ky?=
 =?utf-8?B?ay9YbUxvL1IyQUpWc1V5cGFVa052WGFyZ3lEaUE5cVB0dDMxMTI1M2Z0ZDNB?=
 =?utf-8?B?UEhWRXJBeC9uTzV0OHhHeFpwMEwvbnh2blM3NUtkQUU3aTdTeldxY1ZjWE5S?=
 =?utf-8?B?a1BSbWppMkhZU0ltQlZjYTFLU1FraThoWnpiR1d6WENkaWNLaGtVQnV4MDhB?=
 =?utf-8?B?RWFwNzlPbHpLWWdnSmZ6YjRwdVhHSUMrcnc0bkxIdXArTlZVRWxUdTFFTG5s?=
 =?utf-8?B?Mnlmbm5rM0xUeFA1TllINEx6UzFrYU5FakMxcHV5YjVXSDJ4VzNJbXRqRmJX?=
 =?utf-8?B?LzQxWTF4R2hpSFFJUXl0dVNMd3U4Ykt1QXFTYy9Hbm8vRzliTWN3SEhiV0tz?=
 =?utf-8?B?NGt5c2tWWTFOaEtDazh5THlkZE5FVG5adkVaek96dnlzTEZYNTVCMlh2V0to?=
 =?utf-8?B?L3dzM2Z2dG9BZUh5bHRhZU4zaURObVM4YjJCbkc3T3ozK3o5TUR6eDdXTjA0?=
 =?utf-8?B?ZEpGQjd4UStyUFI5aXQvRFZjeGtHR1dkdktuREZxUFFmTy9nQnFFTFlVcEdu?=
 =?utf-8?B?a2hyKzBHOThLTCsvTUJxRzM5aXlDRHhNQ3NtUENEbnVDanRuZW9PazMyZ29I?=
 =?utf-8?B?anM3NTN0enQvM2RGL3d1VkdXQmVMTkczYk8zSUJaOXdreXB6emQxWFVieHlp?=
 =?utf-8?B?VHlDM2IxdlFCTGIxRWlCaWRUa0FqOFI4SzVvU05ONjYvd0hOM3A1c2R2UVFP?=
 =?utf-8?B?QVZ1aXVwU244N3lLa1VTZHdDeVRMbEtuRktVeDZFYkRlcXRNekt0M1Rhb0pE?=
 =?utf-8?B?YTM4eVRnaEU3dmxQVUJqdFh0ODY0TVpKeWYwSVpWT2tKbkxhVXNVTm1lK1dU?=
 =?utf-8?B?b3NwZnpUT1phR2VTak1uTEk5Zy9Bd3AvSDB5NGtwZ2FqYzJJZjBmbTFIVVBN?=
 =?utf-8?B?aWR6bmJSWitOYjVCajJiNGJrYjdIc3hmTElHM2dCMGZCRGRtYldVajhXRXpM?=
 =?utf-8?B?TTJtVzIzRHUya3BETUhzbTB4QTcvUTBXUEl3aGFMTTBNSW5vT1pNa05Tc1o4?=
 =?utf-8?B?R3ZsQjUwUXAyc3RGeUQ3S1RiL09uSWFSSWtzNGVVT0JxTkZuZ0tVSnc2dGVH?=
 =?utf-8?B?SGRKOWhrQUxaNzNkSE16djJDZnBaSW1hRjhNQ2ZJTDhnb0RzMEgydHM5bGtE?=
 =?utf-8?B?TU5EckdnSHV2cENNT0NsNUsrc2dxUkZOR09KVjV0SC9NSTFYTkxwTkdhZkNX?=
 =?utf-8?B?NzhUTmNkQWtMWTdlcjJXakpKazV1OWQvOWxIWGNOQXowNWYrblpjS2VScWg2?=
 =?utf-8?B?Tit2Vm9jNFJCRFJNbWFhK3cxekhDeXlaRVA1b2xLNzNkSlUvdkhKc1pVeUJC?=
 =?utf-8?B?WWJGeU52QlBDckplZERkNmk0RTNuWDczNitrWk9ueWlSZ0psRk9uRTY2R2p4?=
 =?utf-8?B?TUE1ZmdjMm5DUHZLd0RVTHpBL05ISG9oU2RYSkJ3WkNkd05ZRWN6UXJXSUVz?=
 =?utf-8?B?VldrcXFyWUF1Vi9tUi9rMjhuSGNhdXVrUlRkTVVYQWx2Ym5Sb01saEFRMlVn?=
 =?utf-8?B?cDhpeWZVUzNPMXFZN1FRVlc2ejR0YWhxZW1Xdjdna1Fid0xoZ2ZRdkpwYmpB?=
 =?utf-8?B?V1pBUmE2RXplUCtwOFI5UllXbzJmWGE3MzE0ZWM5Q2w4WHpoQTk4QTVuYUNh?=
 =?utf-8?B?SXYzaGR5dW5zZWFmOFdmZVhhK0FZaExITitTUzJiTWZQWUdyUTZLN08wRFcy?=
 =?utf-8?B?WjNFRWRWY1RGZWkrQnNoUE1nSS9rVUpZMUExYWxKSkp1S29FSUNxZHVMTm9S?=
 =?utf-8?Q?fG5ulgIPjRrqNAYWtBUMXOEOG6dGBhYCJaf3gUBlQeg8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36e2ac7-60f7-493b-d587-08dd8ce9d521
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:03:28.8873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0gIYb3CPdAb+5gHn5jQh4hkcfEDOgBJugwj762JtpduAlE9bzLpYFquPFB57SWTXw8FAMjpPyI1iFpEAAb4CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7079


From: Uday Shankar <ushankar@purestorage.com>

There are currently two ways in which ublk server exit is detected by
ublk_drv:

1. uring_cmd cancellation. If there are any outstanding uring_cmds which
   have not been completed to the ublk server when it exits, io_uring
   calls the uring_cmd callback with a special cancellation flag as the
   issuing task is exiting.
2. I/O timeout. This is needed in addition to the above to handle the
   "saturated queue" case, when all I/Os for a given queue are in the
   ublk server, and therefore there are no outstanding uring_cmds to
   cancel when the ublk server exits.

There are a couple of issues with this approach:

- It is complex and inelegant to have two methods to detect the same
  condition
- The second method detects ublk server exit only after a long delay
  (~30s, the default timeout assigned by the block layer). This delays
  the nosrv behavior from kicking in and potential subsequent recovery
  of the device.

The second issue is brought to light with the new test_generic_06 which
will be added in following patch. It fails before this fix:

selftests: ublk: test_generic_06.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 30.0611 s, 0.0 kB/s
DEAD
dd took 31 seconds to exit (>= 5s tolerance)!
generic_06 : [FAIL]

Fix this by instead detecting and handling ublk server exit in the
character file release callback. This has several advantages:

- This one place can handle both saturated and unsaturated queues. Thus,
  it replaces both preexisting methods of detecting ublk server exit.
- It runs quickly on ublk server exit - there is no 30s delay.
- It starts the process of removing task references in ublk_drv. This is
  needed if we want to relax restrictions in the driver like letting
  only one thread serve each queue

There is also the disadvantage that the character file release callback
can also be triggered by intentional close of the file, which is a
significant behavior change. Preexisting ublk servers (libublksrv) are
dependent on the ability to open/close the file multiple times. To
address this, only transition to a nosrv state if the file is released
while the ublk device is live. This allows for programs to open/close
the file multiple times during setup. It is still a behavior change if a
ublk server decides to close/reopen the file while the device is LIVE
(i.e. while it is responsible for serving I/O), but that would be highly
unusual. This behavior is in line with what is done by FUSE, which is
very similar to ublk in that a userspace daemon is providing services
traditionally provided by the kernel.

With this change in, the new test (and all other selftests, and all
ublksrv tests) pass:

selftests: ublk: test_generic_06.sh
dev id is 0
dd: error writing '/dev/ublkb0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.0376731 s, 0.0 kB/s
DEAD
generic_04 : [PASS]

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-6-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 223 ++++++++++++++++++++++-----------------
 1 file changed, 124 insertions(+), 99 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c619df880c72..652742db0396 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -194,8 +194,6 @@ struct ublk_device {
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
 	unsigned int		nr_privileged_daemon;
-
-	struct work_struct	nosrv_work;
 };
 
 /* header of ublk_params */
@@ -204,7 +202,10 @@ struct ublk_params_header {
 	__u32	types;
 };
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq);
+
+static void ublk_stop_dev_unlocked(struct ublk_device *ub);
+static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
+static void __ublk_quiesce_dev(struct ublk_device *ub);
 
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
@@ -1306,8 +1307,6 @@ static void ublk_queue_cmd_list(struct ublk_queue *ubq, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	unsigned int nr_inflight = 0;
-	int i;
 
 	if (ubq->flags & UBLK_F_UNPRIVILEGED_DEV) {
 		if (!ubq->timeout) {
@@ -1318,26 +1317,6 @@ static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 		return BLK_EH_DONE;
 	}
 
-	if (!ubq_daemon_is_dying(ubq))
-		return BLK_EH_RESET_TIMER;
-
-	for (i = 0; i < ubq->q_depth; i++) {
-		struct ublk_io *io = &ubq->ios[i];
-
-		if (!(io->flags & UBLK_IO_FLAG_ACTIVE))
-			nr_inflight++;
-	}
-
-	/* cancelable uring_cmd can't help us if all commands are in-flight */
-	if (nr_inflight == ubq->q_depth) {
-		struct ublk_device *ub = ubq->dev;
-
-		if (ublk_abort_requests(ub, ubq)) {
-			schedule_work(&ub->nosrv_work);
-		}
-		return BLK_EH_DONE;
-	}
-
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -1495,13 +1474,105 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 	ub->nr_privileged_daemon = 0;
 }
 
+static struct gendisk *ublk_get_disk(struct ublk_device *ub)
+{
+	struct gendisk *disk;
+
+	spin_lock(&ub->lock);
+	disk = ub->ub_disk;
+	if (disk)
+		get_device(disk_to_dev(disk));
+	spin_unlock(&ub->lock);
+
+	return disk;
+}
+
+static void ublk_put_disk(struct gendisk *disk)
+{
+	if (disk)
+		put_device(disk_to_dev(disk));
+}
+
 static int ublk_ch_release(struct inode *inode, struct file *filp)
 {
 	struct ublk_device *ub = filp->private_data;
+	struct gendisk *disk;
+	int i;
+
+	/*
+	 * disk isn't attached yet, either device isn't live, or it has
+	 * been removed already, so we needn't to do anything
+	 */
+	disk = ublk_get_disk(ub);
+	if (!disk)
+		goto out;
+
+	/*
+	 * All uring_cmd are done now, so abort any request outstanding to
+	 * the ublk server
+	 *
+	 * This can be done in lockless way because ublk server has been
+	 * gone
+	 *
+	 * More importantly, we have to provide forward progress guarantee
+	 * without holding ub->mutex, otherwise control task grabbing
+	 * ub->mutex triggers deadlock
+	 *
+	 * All requests may be inflight, so ->canceling may not be set, set
+	 * it now.
+	 */
+	for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
+		struct ublk_queue *ubq = ublk_get_queue(ub, i);
+
+		ubq->canceling = true;
+		ublk_abort_queue(ub, ubq);
+	}
+	blk_mq_kick_requeue_list(disk->queue);
+
+	/*
+	 * All infligh requests have been completed or requeued and any new
+	 * request will be failed or requeued via `->canceling` now, so it is
+	 * fine to grab ub->mutex now.
+	 */
+	mutex_lock(&ub->mutex);
+
+	/* double check after grabbing lock */
+	if (!ub->ub_disk)
+		goto unlock;
+
+	/*
+	 * Transition the device to the nosrv state. What exactly this
+	 * means depends on the recovery flags
+	 */
+	blk_mq_quiesce_queue(disk->queue);
+	if (ublk_nosrv_should_stop_dev(ub)) {
+		/*
+		 * Allow any pending/future I/O to pass through quickly
+		 * with an error. This is needed because del_gendisk
+		 * waits for all pending I/O to complete
+		 */
+		for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+			ublk_get_queue(ub, i)->force_abort = true;
+		blk_mq_unquiesce_queue(disk->queue);
+
+		ublk_stop_dev_unlocked(ub);
+	} else {
+		if (ublk_nosrv_dev_should_queue_io(ub)) {
+			__ublk_quiesce_dev(ub);
+		} else {
+			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
+			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
+				ublk_get_queue(ub, i)->fail_io = true;
+		}
+		blk_mq_unquiesce_queue(disk->queue);
+	}
+unlock:
+	mutex_unlock(&ub->mutex);
+	ublk_put_disk(disk);
 
 	/* all uring_cmd has been done now, reset device & ubq */
 	ublk_reset_ch_dev(ub);
-
+out:
 	clear_bit(UB_STATE_OPEN, &ub->state);
 	return 0;
 }
@@ -1597,37 +1668,22 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 }
 
 /* Must be called when queue is frozen */
-static bool ublk_mark_queue_canceling(struct ublk_queue *ubq)
+static void ublk_mark_queue_canceling(struct ublk_queue *ubq)
 {
-	bool canceled;
-
 	spin_lock(&ubq->cancel_lock);
-	canceled = ubq->canceling;
-	if (!canceled)
+	if (!ubq->canceling)
 		ubq->canceling = true;
 	spin_unlock(&ubq->cancel_lock);
-
-	return canceled;
 }
 
-static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
+static void ublk_start_cancel(struct ublk_queue *ubq)
 {
-	bool was_canceled = ubq->canceling;
-	struct gendisk *disk;
-
-	if (was_canceled)
-		return false;
-
-	spin_lock(&ub->lock);
-	disk = ub->ub_disk;
-	if (disk)
-		get_device(disk_to_dev(disk));
-	spin_unlock(&ub->lock);
+	struct ublk_device *ub = ubq->dev;
+	struct gendisk *disk = ublk_get_disk(ub);
 
 	/* Our disk has been dead */
 	if (!disk)
-		return false;
-
+		return;
 	/*
 	 * Now we are serialized with ublk_queue_rq()
 	 *
@@ -1636,15 +1692,9 @@ static bool ublk_abort_requests(struct ublk_device *ub, struct ublk_queue *ubq)
 	 * touch completed uring_cmd
 	 */
 	blk_mq_quiesce_queue(disk->queue);
-	was_canceled = ublk_mark_queue_canceling(ubq);
-	if (!was_canceled) {
-		/* abort queue is for making forward progress */
-		ublk_abort_queue(ub, ubq);
-	}
+	ublk_mark_queue_canceling(ubq);
 	blk_mq_unquiesce_queue(disk->queue);
-	put_device(disk_to_dev(disk));
-
-	return !was_canceled;
+	ublk_put_disk(disk);
 }
 
 static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
@@ -1668,6 +1718,17 @@ static void ublk_cancel_cmd(struct ublk_queue *ubq, struct ublk_io *io,
 /*
  * The ublk char device won't be closed when calling cancel fn, so both
  * ublk device and queue are guaranteed to be live
+ *
+ * Two-stage cancel:
+ *
+ * - make every active uring_cmd done in ->cancel_fn()
+ *
+ * - aborting inflight ublk IO requests in ublk char device release handler,
+ *   which depends on 1st stage because device can only be closed iff all
+ *   uring_cmd are done
+ *
+ * Do _not_ try to acquire ub->mutex before all inflight requests are
+ * aborted, otherwise deadlock may be caused.
  */
 static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
@@ -1675,8 +1736,6 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
 	struct ublk_queue *ubq = pdu->ubq;
 	struct task_struct *task;
-	struct ublk_device *ub;
-	bool need_schedule;
 	struct ublk_io *io;
 
 	if (WARN_ON_ONCE(!ubq))
@@ -1689,16 +1748,12 @@ static void ublk_uring_cmd_cancel_fn(struct io_uring_cmd *cmd,
 	if (WARN_ON_ONCE(task && task != ubq->ubq_daemon))
 		return;
 
-	ub = ubq->dev;
-	need_schedule = ublk_abort_requests(ub, ubq);
+	if (!ubq->canceling)
+		ublk_start_cancel(ubq);
 
 	io = &ubq->ios[pdu->tag];
 	WARN_ON_ONCE(io->cmd != cmd);
 	ublk_cancel_cmd(ubq, io, issue_flags);
-
-	if (need_schedule) {
-		schedule_work(&ub->nosrv_work);
-	}
 }
 
 static inline bool ublk_queue_ready(struct ublk_queue *ubq)
@@ -1757,13 +1812,11 @@ static void __ublk_quiesce_dev(struct ublk_device *ub)
 			__func__, ub->dev_info.dev_id,
 			ub->dev_info.state == UBLK_S_DEV_LIVE ?
 			"LIVE" : "QUIESCED");
-	blk_mq_quiesce_queue(ub->ub_disk->queue);
 	/* mark every queue as canceling */
 	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
 		ublk_get_queue(ub, i)->canceling = true;
 	ublk_wait_tagset_rqs_idle(ub);
 	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-	blk_mq_unquiesce_queue(ub->ub_disk->queue);
 }
 
 static void ublk_force_abort_dev(struct ublk_device *ub)
@@ -1800,50 +1853,25 @@ static struct gendisk *ublk_detach_disk(struct ublk_device *ub)
 	return disk;
 }
 
-static void ublk_stop_dev(struct ublk_device *ub)
+static void ublk_stop_dev_unlocked(struct ublk_device *ub)
+	__must_hold(&ub->mutex)
 {
 	struct gendisk *disk;
 
-	mutex_lock(&ub->mutex);
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
-		goto unlock;
+		return;
+
 	if (ublk_nosrv_dev_should_queue_io(ub))
 		ublk_force_abort_dev(ub);
 	del_gendisk(ub->ub_disk);
 	disk = ublk_detach_disk(ub);
 	put_disk(disk);
- unlock:
-	mutex_unlock(&ub->mutex);
-	ublk_cancel_dev(ub);
 }
 
-static void ublk_nosrv_work(struct work_struct *work)
+static void ublk_stop_dev(struct ublk_device *ub)
 {
-	struct ublk_device *ub =
-		container_of(work, struct ublk_device, nosrv_work);
-	int i;
-
-	if (ublk_nosrv_should_stop_dev(ub)) {
-		ublk_stop_dev(ub);
-		return;
-	}
-
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state != UBLK_S_DEV_LIVE)
-		goto unlock;
-
-	if (ublk_nosrv_dev_should_queue_io(ub)) {
-		__ublk_quiesce_dev(ub);
-	} else {
-		blk_mq_quiesce_queue(ub->ub_disk->queue);
-		ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			ublk_get_queue(ub, i)->fail_io = true;
-		}
-		blk_mq_unquiesce_queue(ub->ub_disk->queue);
-	}
-
- unlock:
+	ublk_stop_dev_unlocked(ub);
 	mutex_unlock(&ub->mutex);
 	ublk_cancel_dev(ub);
 }
@@ -2419,7 +2447,6 @@ static int ublk_add_tag_set(struct ublk_device *ub)
 static void ublk_remove(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	cdev_device_del(&ub->cdev, &ub->cdev_dev);
 	ublk_put_device(ub);
 	ublks_added--;
@@ -2693,7 +2720,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 		goto out_unlock;
 	mutex_init(&ub->mutex);
 	spin_lock_init(&ub->lock);
-	INIT_WORK(&ub->nosrv_work, ublk_nosrv_work);
 
 	ret = ublk_alloc_dev_number(ub, header->dev_id);
 	if (ret < 0)
@@ -2828,7 +2854,6 @@ static inline void ublk_ctrl_cmd_dump(struct io_uring_cmd *cmd)
 static int ublk_ctrl_stop_dev(struct ublk_device *ub)
 {
 	ublk_stop_dev(ub);
-	cancel_work_sync(&ub->nosrv_work);
 	return 0;
 }
 
-- 
2.43.0


