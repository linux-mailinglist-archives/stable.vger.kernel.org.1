Return-Path: <stable+bounces-141941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777FAAAD0EF
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D484D4E7DFF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A2A1EE03D;
	Tue,  6 May 2025 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JA2rv3wb"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2020A21859F
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570326; cv=fail; b=ETwjfzXmBjaM99Id9zrYU2itQNK3F+9ymmRUVT8QNyQThg9Cgtnu1BI7OZqDCUrkgr578trdBUl/ZshPo7mtlor9YRDoenHdg2Ic5qCzuv540boyV2AT2fbxZ1amRuZjnV7e15jDt5Iw2cASlW0T3oDRY16hg4+QwH1KxW2+ozQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570326; c=relaxed/simple;
	bh=h8ktUkPtobHHskW568MxCdqKu7qBnB8pNJncriGhIR8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J9jjIjPfobtrfGNkoh4oHqHyegIfn8efJcDBYs+ZVVLkuHA+SMzKUUX76EUJ+RAghRuWtp966z98ttrPR5njf0F72XRSJj9ytQZi+IjG1jkmdDfJoFxKNZHwQ50xAlBLnUwwf7amln+Xuj/HEfBst76PeZPbPuW4wiAfX9+UyDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JA2rv3wb; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCNT0Z/fq6zkXedKH7An4b3WiKqBm1Fga7HbsYMgxajxyEHUp2ZV1oJAc4FvoyH8VXjuYGrMU7i/nDDt00lFEpwD5WizjUeLchuK0/oUg4vOgPAFk/W311Z1gBBFJW/xtYDrbMVJ9L2m7VmU66H0HWCINxw4oXcXktaUXLNR5MHeF82pI8BsYzn/sAJXz3vk338QFbNNH5qvziHOP8mbhdKVAKPrdIzXPvJPxi9mBFW1Hx06C1gy71PqvvHwxALN1oq2mC6vRVC6XC594aEYx/TLWjt9mFrPgNgJlPRHHo/k/i52gYy65ns0j9rrsgtJYzWmE/jHwdc7DhjMLNHm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5NCeCwjW0CSkakh4nF7N9q2rMPfvX7k5et9+28NTEI=;
 b=odBpw4QaFxt6oZ4jWPR618PcEdxsRMVTzy/HYp4+nr4aPon6SpgPMuRUD0k3YjyIxbM4Xq+hB+Ye+lbq2SiYcgJ+a+5VQregAwlP3jOvUK1pgnPrSQ7JrXAwn9V2/y3Wn+JVKcaeecaXFw55IoTu9S98zKPT74tnD7BWsSnvHFzGR1L2KRfsSNApgwxhHL2rp4lm0IxZcUa72hVhCVtv/fKau+JYai6oqzBFICRpiU1oVbzYVBVSPYhe9XWNX+ESVjC+LvmCvXW8Qa4vZwT1TnWLpnHswtubgDF8YS5Jcx2OQS7akGYIrnYCFkVNirME+sCX/QZDjk86O9n1tYlZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5NCeCwjW0CSkakh4nF7N9q2rMPfvX7k5et9+28NTEI=;
 b=JA2rv3wbolj/0iakJuJkvs/3HXhuU76y0KOYAJlqv4c4lSdcgPuWW8XxMvV/6fzd6gvV+bSvlAprXpMdlm9LjaO+OKZU7HghEcqzOBnY0RibFN6HmF51ncgvSaugwAZniVJaL0FDLP/wNVmBplPY2kOO+/HoalaoQuFRAOpzFwH2Teecy0SavrgdqhgjpL6lHze+kcs5TYI5neX13LQoyfQPyi6jsEJ+xHSxWQ8HJBf1o8XkQkf7LE6oujpgDSBOeH2FRzYd/lM/vW0hHdgSaTtH6rBIhh2f0cAg7y399x9X5EGhYqenUVMjQHmJikH7HltGeDtxl8NG+MJSziEuCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 22:25:16 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:25:16 +0000
Message-ID: <8ca556ea-2f5a-40ef-b719-f5519abcb947@nvidia.com>
Date: Wed, 7 May 2025 01:25:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] ublk: Backport to 6.14-stable: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Reply-To: Jared Holzman <jholzman@nvidia.com>
References: <20250506215511.4126251-1-jholzman@nvidia.com>
 <11c4208b-ad97-4d26-80d7-e728ebe2552e@nvidia.com>
Content-Language: en-US
Organization: NVIDIA
In-Reply-To: <11c4208b-ad97-4d26-80d7-e728ebe2552e@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 0caa05a7-9922-4160-7bc7-08dd8cece025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2RyK250eXZrbXRNTU5SQ0NOWk5EYkZWd3JvRk1IT1FMTGI2Z25MWkl5akE4?=
 =?utf-8?B?czRUenYxbXhudnE5ZzZ4T25FdE96djdlQnQ5bU9sK2NuZjhYVTZpbkZSV242?=
 =?utf-8?B?MXZueHBsRVd2SHFzNVUzMlZoSkprWnFhY21KRWdLQzlJVHhTTFFySVlUdEJv?=
 =?utf-8?B?by8wMWFYWWkwaDBLdEsrUUh1NmlsUVI5Z21VdXBWNVVSRWtqRXRnUjRXa2Fj?=
 =?utf-8?B?dHVybkNsbkE2KzhqbnZmSks5Z2VpVFRUZDNMMXpsNHNLMFNkK0xKVlNhQmtk?=
 =?utf-8?B?MEJmMDdtcCtZeGZwb2FMeFdrNFdieFhZS002K1N3VlQyQzZ0NFhhaE1QcmZ5?=
 =?utf-8?B?NS9MNW8zWHJvanJxUkxQWUtIc2JacTdJWDRDTlVSWnZ6UlpmaWFwRlc3dTU5?=
 =?utf-8?B?ejRKS2RTTnN2UExGcjdCdnBLQkExLzZqUm1pOVZuWVRyMGxNMWdQRzBHcXJN?=
 =?utf-8?B?dXNpOGhVUWltN3dDL2tNNFRLN0p6UERkbHZBNS9HWjB1c0J5RGpsb3JPNE5J?=
 =?utf-8?B?QXQ3UW4rVDVCdk1zVjJSTVc4OEdpV1RndlJEaGlTZ1ovSkZ1QmxlLzNKRDZY?=
 =?utf-8?B?WFhxUlZjQ0NrandwNFJKUVlBSU9QYmpCNHRGYkN3ajlxMUVJRmloZHdkSnR6?=
 =?utf-8?B?VzdZS0E5bDZQS09iYm1ZbWIzZ2hCOUhrVm8zK1VQb3B5dDl2VVJnelVBbVRW?=
 =?utf-8?B?MG1ZcXp4TzVTckVsSlJna2lNM1QyMllaYzV0TGIyZWNSQ0U4eldoOFdFZzhS?=
 =?utf-8?B?TWFNT0lnajhPZThaalNQbFdHa1hjNjJ6dTJvdW0xUkRRNTZOS0swS3JMS0xu?=
 =?utf-8?B?SDdzTHV2UVhuN0JQeU9DbzRVRGRNVWhLck5kTzB1K2xXYisxZjRudGgwL1hJ?=
 =?utf-8?B?aTBUUncxajdKWjc1eWNKRUNmd1pER1lZQzRkajJxUmdaclhjVXlmSkVIeVVN?=
 =?utf-8?B?enVJd2JBL2N3MWI2aXpvWmkvbzBNRndUYlRMajRBWjg5ZUh5STI0MXpkZHpY?=
 =?utf-8?B?RGtMa3FxTzRyR0dNL3BSUzJXNUVwSXY2bGxVSUx3Y2xEekhsSnNrWVJVZ1VD?=
 =?utf-8?B?WVVoZnBtd1RheTZGdmZDVTFYWG9ac2FFOUN6d0M1VnhLOUF3S09xQUQxcXhj?=
 =?utf-8?B?MHdtdVk4bi9FT0tVZ2Z1aHYzMjZLK1hueUlxWG5TZU9FSC91NWNUanhKaXo5?=
 =?utf-8?B?T0d5Mm9ydnRPclRQeWJpTVBnaVZrMjRrTWorTjlsbTdhUE5idnF3bnZQcGVW?=
 =?utf-8?B?b3hNT2J0MngzQkNYWUZQUTN2NjZqMXB4TDR1OEl4REhUNDJYL0ZNcThXWG9G?=
 =?utf-8?B?S2xzbkR1eUQ3dlNjcGFzWVJxSGI1WmtLNTBUTGxuc1FhZzN1UmhDK0dtVWlG?=
 =?utf-8?B?eTRaQkFKbTBVWmg2MFhmWkVNYktxQ2VOWUpMbTdUM2ROSUlHcG9JVnBCSk0r?=
 =?utf-8?B?S1FjTFBFcDh4VEc2Rzhmd01LUmxJNnZFL25yekJIZi94azdDZE1Ua254elVS?=
 =?utf-8?B?dXpIV1dOS0x5akozUzRKb21NVit1cERIMGpNS0hUaVA2bnBxUkVrU2Zlb1I0?=
 =?utf-8?B?TXpZQVNkRE1zUGpLT3JJeEZzZzBYOWtrWThtMWx6NHZ2NDNGaDhIWjlpWHda?=
 =?utf-8?B?NGtmajMreFVxWUdHU1ZUZThuRjY1NzlHc3VzU0lOQmdjQ1VYMFhZUkJpRXNQ?=
 =?utf-8?B?ZElENEhaZDZVVFd6SisvMVFOaG9Sd1BMODl2elREZitGTmFlcDcwNzd1Y2hW?=
 =?utf-8?B?cGJZYzNXdEMyZ3BsZVlmRnd3TnQ3MnFzNXNXNHZxRklDZ1U5NkxCV3hoVUxY?=
 =?utf-8?B?OXZtbk1QTVhGV1YrZzRVNUFSb20zK3QzNG12NlptZm5FTjZ2dGFqaDhOajZ6?=
 =?utf-8?B?czZRaS9jOXpFZURtWTZ5NmZUTHVMaEhxVnhiWGZIbWdqbnRZaWR0cGFENnNz?=
 =?utf-8?Q?lqWDAHPD+Mw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WldxdjI0RG5uSmZERHVnMmJUV011c1ZmSmJHWDhVNG5jNEVsS0FyY3hYaWJz?=
 =?utf-8?B?eWhiMGFXaVZqMHo4NGhsWEkyTm5MNzIzZmUxeUpvQVRaUHRmYzdxQ1NPcmRP?=
 =?utf-8?B?VGh5cUtjMTl2aEpRck5lQ3VNTG5DWkV3WGxwejh1eDhLMFNPdEFKQ29Nd245?=
 =?utf-8?B?SlIrOFZCSXR2MGdLUDRXdFRQbWN6SXBxb3d4OW1zdWhHWmRISWhPdGRsSzFy?=
 =?utf-8?B?eU5jWnlXbFFQSTZtUDBydzRxOU9aZGlGcWNLNUNnc1RvemEwMjE3bmRaUmNY?=
 =?utf-8?B?ak1oaGtCMkZXQ0RHSk5aZHZtK0M4ajcxZER0aXhWL0ZiYTNxN1BJd2Y2cGQ1?=
 =?utf-8?B?Yit4QXU5M2Y1SlVWOEpiclN6RXFZSlFNdk1hUEt1MnZzTGp6OGUwb3dRQWpE?=
 =?utf-8?B?OTllc25hdmhTWTNTQXZwSUVTcHpnaGZzckVVeUZzMUJkU0IvMFdCdkNqa1Bx?=
 =?utf-8?B?b1NmdVhzZHUyc09tVFNJT2FsOVBkTkxwRWdhbG9WM1ZSMlFiSmZkSi9NWlli?=
 =?utf-8?B?SlZLZTZkdFlReFdmSVFDNG13VDNhWW5oWndWYUVSYldZY3FZT1drOXoyVXpi?=
 =?utf-8?B?dSthVHV4ZWtaZ2NIMjBWeFF3QW4waHpERzY2dXMyajJFYlV5THNkdXBiNHBh?=
 =?utf-8?B?SmVyUXM3RGgzekFsNklSNTBRdGVEUENpUWtEcW1xRVBzVFVLWVo4aHNoSjZI?=
 =?utf-8?B?bGpGa1dwMEliQnNWVm9JblJEMG9hYWlQbVlCSm5sL1J0ZjFmNDlTUWhlTmhi?=
 =?utf-8?B?RXVVNWZGVTdPZGNDTlUwTHBWZERqdEpkREg1VGxscG1qczJGaldTQnp1TFZl?=
 =?utf-8?B?RFNZWWdycHRDQ1REN01uOVpkNFVHN0VNOUdwbzBhRmw0K2YxajhTaE1ySXRt?=
 =?utf-8?B?TmJ6OHcwV1Njb3hGN2p4R1UyeWlKMTZYanM3aitJclAyeVh2c2lVcXNYS1ls?=
 =?utf-8?B?cDdkaTZDbnRieUtwdTIwV3Y5Qi9oUWplREh2NGp5M1lDR1pROFBjcE5nWnhU?=
 =?utf-8?B?N3MxME9WMFJTVG5qaGVQOWdQdTB1VHZpejZKdldKRmRSNmE0SHprSGZzSTAy?=
 =?utf-8?B?SVVmQ0xpZDNiRVZGeEVsRERwUFlEbHVYVzBsLzF0ZnQ2ZDVGZk83MlgxcnJw?=
 =?utf-8?B?TWdyeEZmQVFlOGhRQ0xiWTQzTXUrZWNycHU5T2NuNlhMSm1pMlNDQWQ5N1lO?=
 =?utf-8?B?KzR3TUV4MldncVU2QVNYdCt0Qk9NOUt0ODN5RTBoMGpKWjFldXFXMlcwa3BZ?=
 =?utf-8?B?TEJDc2RwemtjeG1ubk5pOG1mdVZaWEd2NFppSGNFek92N0FpbG4xb2grd1lu?=
 =?utf-8?B?am5kdVVyb085VDJ1N0FDRDFRb1NiYUcvODcxRGNIaEZQdDZaNGFoMkhqVnBm?=
 =?utf-8?B?alJJQ1lhSmZZVnFxQUFOb292TTlYNS9tcWtzeWRqWmZTc2RHLytkRlpQZlds?=
 =?utf-8?B?aHZsd28xci82VTM4cDVFMTRjYmhLTWwzUXZtODV6R3lIWFgxN1dzWFN0bmVJ?=
 =?utf-8?B?ZEdGZWtDUVNnSUlQK0EzbE04M1k1VTNkKzh2STNuR2h1K1c5NXFjK1gxTUM0?=
 =?utf-8?B?VDFSS3NnNGx2Q21ReC9ZWWNoOG1PVmVHaks0Z0NIZFpuRHZsRzhibFZub0dG?=
 =?utf-8?B?akxZdjVpYnVvOVlGRVRaU2swaWYwZnE1dnpwMExSYVRPZll3dGdKaGJ2VjRI?=
 =?utf-8?B?aFpLcHM0amNxT1lrMWR1VGprbmt0cm5XU0lNQlordUVwckVndldqUWlRMUpn?=
 =?utf-8?B?NFVWQVJwME53L1ZJcDVMQW55N3dCYnAya0hoTTFCN3ZmZUJsZkwxcDNvaXRV?=
 =?utf-8?B?M2w1eFhwZG1yNHF0dk9tSko1RzlIR2R0OTdLQVVWcEZwaHhIaUV3SEhQQ25K?=
 =?utf-8?B?Q3MraE51WlRyOU43dkdhZ3luVWY2N0ZjeGZRZkFScEd4d1AyeWlqZGo3YXZZ?=
 =?utf-8?B?K25nbkdGMU1DcEc5dTJzVXo4WHhkSUw0b09hR3ppZk80Z1pia1NvS1N0YVdL?=
 =?utf-8?B?dDIxQUk5NE5xN2E0d1cvWEN2QTFjMURIeW5nNUF0ZFVyVkNZU2g2ZDd4RDVV?=
 =?utf-8?B?eTN6em9HYWVMWDVZVms1N09KcGhvUllFREhtbXBFeEVnc0JQR2ZrY1M2VWUz?=
 =?utf-8?B?aEFyUkhtNjdiL016MFdCUWx4MTJQcDFiWnJrTDltSUY0bitiSkFDSk5aQlEr?=
 =?utf-8?Q?kBRIs7frfuWaoPxFAzQ+VnsRK++YBF2jhjUeHR9L2OJz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0caa05a7-9922-4160-7bc7-08dd8cece025
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:25:16.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwA/wVhbBbpnQEKn3Q+AWUrOQOP1BcS+/jETJt93B0J7N2LCiHnb5YDkuryN3G9nM8WTCgp6cm5R1kqWgW7LZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

On 07/05/2025 1:00, Jared Holzman wrote:
> 
> This patchset backports a series of ublk fixes from upstream to 6.14-stable.
> 
> Patch 7 fixes the race that can cause kernel panic when ublk server daemon is exiting.
> 
> It depends on patches 1-6 which simplifies & improves IO canceling when ublk server daemon
> is exiting as described here:
> 
> https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/
> 
> Ming Lei (5):
>   ublk: add helper of ublk_need_map_io()
>   ublk: move device reset into ublk_ch_release()
>   ublk: remove __ublk_quiesce_dev()
>   ublk: simplify aborting ublk request
>   ublk: fix race between io_uring_cmd_complete_in_task and
>     ublk_cancel_cmd
> 
> Uday Shankar (2):
>   ublk: properly serialize all FETCH_REQs
>   ublk: improve detection and handling of ublk server exit
> 
>  drivers/block/ublk_drv.c | 550 +++++++++++++++++++++------------------
>  1 file changed, 291 insertions(+), 259 deletions(-)
> 

Sorry botched this. Will resend.

