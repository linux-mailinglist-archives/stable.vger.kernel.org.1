Return-Path: <stable+bounces-83438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B25BD99A29E
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 13:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF6B1F2493C
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 11:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7381121502F;
	Fri, 11 Oct 2024 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZomOFLup"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7B21500F;
	Fri, 11 Oct 2024 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645718; cv=fail; b=smXI/8/15gwWVpBfM/7u2bKb/8KyfSHT+ojj1kqOGNTED96D524NVajJNCqIruOI5BQi2S9xfXiGWUA3tawtyGGH8ioed676N2btiJ2yC9tUmaKrsWznotgFITqRkDMLyv0IZH80nZIREpOueQImVmHaIPVaq2PYZH+2UMJdK5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645718; c=relaxed/simple;
	bh=B3wWBUVlcBaTElJ9IKPoTshx321+oXJHd+Krv+RpZ9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mpCHZyZiYYVUKkV/TOiTQIu9YkBZY91oLLDQQI8IIftoPCZ3jGQh2we/4HbdLYeK07oisoSmMPoP/7fxjckS1kk0Lmh36JF2EqmbEtZIpcgDzxzXEsnDtj7mDfQklCyYZY7nPwgQSGYSyp7ftzzSeDK7kOfpqNaeIrB0KvEOAdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZomOFLup; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXfET+srXmtaaKJvTF+cER44UI6oKJAs1D7uqqDL4gflj87jU+nKJLS7zLi5KQELvxsIq+PcGQhgkB25TIm4sUsPA5PbQ8uxdS15AXyxLDV36YDr8qjsSL8pFpjsgynNZ03TOF8xLJHE8t5yv6CKbqjAUZwMbVmXYZMEK/xeZG7rvVnFK/TJ7H5wQ0FTJ8dIT13k+ZHttDER936DOR6t/ks6CQyhSPGKttOULB4uhFuETXmQjB+79DvaIbdnIKqozcMDo95uX3vGB1BSGJssYcabLvbNcI8uhmHw7F2eRZoG/rPZQ6F6jLKT/ww7Vih0tEmNgxeL/PSGj+2tyJcr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8W/uOXLUYsdf85MObfMwJf5OrOyAtPK7gl1Qz0flkA=;
 b=evnyvEoGT1/OhGAvY86TI/QCgc30g+8KOZWaJpv5869EyYtPXKulBOjn/ck7eDKtFhI8o0/7g4qEc3bw87YZi4XMdI4bTvI9aiu0uIdNYUTOn33/wJ3xAKYmOXviL+g+9C+FpTgng+H/HfkF5jYpF4tGMAo+ZR5xAsrpifGc+znsJrpQ0xIWzlja9CPHoyTe6vjs8Ma+QikrT5ugjsF+uA9XnLG4FIQxzBA3RBLiOd0pfTtrATHhWQC877viArG6bmGnXVribuK1BmchaXWTA9gfnJEoALbTm1UMyQxayLpCGVUVBIYXkfoQhZxlchzFd8ZPuuyqqWd5r3r8juVTqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8W/uOXLUYsdf85MObfMwJf5OrOyAtPK7gl1Qz0flkA=;
 b=ZomOFLupnxtb+twwsIy0szyGHDycD/U8viAUbJzsAappe4yvdPE7zJjR4+uP17y3FUr2bkSqmheJ4czAgC+r76AewioH7POezdspPf42uJDcnTwL9UbLILu4JluZROkMFfSlMurcCjBb85g6LKPskQBBse3N9nRxKbSFkK0e/Cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 11:21:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 11:21:53 +0000
Message-ID: <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
Date: Fri, 11 Oct 2024 12:21:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, stable@vger.kernel.org,
 Zijun Hu <zijun_hu@icloud.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB7PR05CA0057.eurprd05.prod.outlook.com
 (2603:10a6:10:2e::34) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a0aadff-3941-4fa6-8fc5-08dce9e6e864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MnFtY3pwMUU0T1F0cmZBVTU0bXlhSGVzWk1MdGN2RHZTMFFxOFFRSVdZaTE2?=
 =?utf-8?B?N0EySmtlUGdUWmhDaGpjTVdPbVU0UEdhVzVvdy9GY1JtWVZiSDVkeVZVWG1R?=
 =?utf-8?B?dW44STZQcmRjUjBNZy9tdG8rR3FFemYwWDdsNTg2S3ZUenZvV2tueXgreThn?=
 =?utf-8?B?c1dxMXp0VWl4b2lsdUxOcjI3QjY5bWN5dGsrZkdyQ3dhVGxvdWYxbis2SWlo?=
 =?utf-8?B?MjhWbmxUcjVlWGRFQmh0VkhEQmJCTGpTaWxxMnYvVXlqcGI0TUVLUEhBaVY4?=
 =?utf-8?B?dzdXTDNndCtCUEl0TlBHblhrdFI4WE4vS2FZdUpjQWhkM0Z4Y2ZTUkRMVHl2?=
 =?utf-8?B?c2pTeDlSRWhGelBDYjV4MHJUSkNILzFaMm1kN2l4a3YyV2pMTGJvUHBZYjFs?=
 =?utf-8?B?dGRJL2ZWUExsTUsyMmUvZE1oWlltUEpWTkFhdTg4TlBaczU2NTRqZmRXZkVB?=
 =?utf-8?B?WDFFMklhQ0hPRXlTKzgwY3BtRlh3ZHpNblE2Zm9qTjROTXU1L2tjU0k1RlpL?=
 =?utf-8?B?UFNMK2dKSW1QclVXS3diTXg0SC9CaUp3VjlkdGVVMTlNajhIOW9aMXdHSmp1?=
 =?utf-8?B?Um4rV1lWZXBSKzZ0dVZNdGlMamN4Rk1WRnljRzZtUHVQNkd0R1ZFZ2I0LzJR?=
 =?utf-8?B?VXcyQTlPSDNyUzhhN1JJSkovQjRQc0duWTFoaXBkbmlEanNKQVJzeWtjWXhM?=
 =?utf-8?B?clBZcUlKK0p3cDdvSlY4WmV2Y2UrSVlmSFdPZmQ0Q2dqNXdCSTltYXo0UFBm?=
 =?utf-8?B?a3FoVFVCMCtrbnFLV29hbHh5Vld2SEx0c0FpblU3eU0wVDRUWFlKbzZ2aFdy?=
 =?utf-8?B?NEZxMGhBVlp3TzNYWXpHSW96WlZQeE0wRUFUMUtKcFBrREdLVjRxSG1lT3ZZ?=
 =?utf-8?B?ZTFhVU8yV08vc3FPOFg1WmlaVzFKVFhUM0NBZ2hXUGpOTVVFZm1ES085RGpD?=
 =?utf-8?B?QnRIZlpZcjBwZzR4bkI2OWtBM3d6T0luaUloYytzeXVyT2hndGJNd3RodFBN?=
 =?utf-8?B?Y3dScTQzVGNta0xMdTN1Qm1GS0E2S0dTSEpwRTFkaFkycVlId3VKK1FaL0lZ?=
 =?utf-8?B?UmUvRU11azlNQmtibGZDeTY5OWRIMXVnRkpwcVgycUxjQnMzYU9paExwRnN2?=
 =?utf-8?B?aGZjeVpmSEZicGwxTmkvRjh4bUJzczBUV2JJT3JxK2tCcDh0K0NXYjhRdXFp?=
 =?utf-8?B?NTR2QllwUXNWSFBYM1AvN2c4K2lJUlVUMTYwMjNHMC9VenBaMTFvQm5hSEkw?=
 =?utf-8?B?dlk3bUxPNVdld0NWWjRxL0VvTEMxT0k2SkUrcjVDMDhBT0RIa0VPMGNyUlJ0?=
 =?utf-8?B?dXZZenpId3R1ZUgwb1FFUEJqc2RhT3hlR3NZOWN1T3o1ZncvNTZETmJ5QmJB?=
 =?utf-8?B?THlrbTEvalVmdE9HOEt1UGh6Q3doc0MvMXplc0tvaSt3M1hQQVRXTk9ya2xy?=
 =?utf-8?B?T0twcER0UG9FRXI3RlNubTQ2Tk9BbWRHRGY4S1ZyekYwWVd2SnQ3TmlTaG0x?=
 =?utf-8?B?QmRRaE5pZWdRN2Y3SUM0WlFKczV2VG40RXdObnBzUXJOWWNGbituTXJoS2k5?=
 =?utf-8?B?WVgwYWhIRCsvK0lOMlZQVkVyNzZBZEd2Y3lLMThKamwyUTdRdjBneEFqeURp?=
 =?utf-8?B?eUFVMTA1RFZJU0xRYnBzckdmVWdsR05Da3NTbHRuNVpBbU16ZHNjZS9KbE8r?=
 =?utf-8?B?ak9SbHBtVHE0UHloc2h3RzJxa1ZsZWRDcGI1MDFwdDhmNUtjNzB5eWtWOFBD?=
 =?utf-8?Q?r2CoTYoKAekIJzaGcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFpT0Z5RHZsUWNJWXVDVVlveDIybXMwV1JBNkdsWTB3Y1puUGNQT3F3cE9K?=
 =?utf-8?B?Uk9tRi80L0RIVEo1cVZSWExKMXFmOGlod2toUjVvNE5PSkNJcmhmekV0VzZ2?=
 =?utf-8?B?b05JRlhaQ3RrTks3WUhZTHp3MVA4ZWtNVW5ZcTZBOWc4NXhUYmFYMjBXYmVF?=
 =?utf-8?B?dXRHbVlxMUlkOVZlZG00alBVeEY3K0wySHpwWEs3bjBqSFFXWFRIZHdBeVVr?=
 =?utf-8?B?SlVqcktFWmVKaTUvaUtsb1JWd3FwWlJyanZna0ovaGpiQjdYUnFQR0VZa3NZ?=
 =?utf-8?B?Nm5TeXp4M0NZVWYvbzhTYjhTUlBuaU5CNmRXcXJXSEljNUdWNU1JVEF2Rkp5?=
 =?utf-8?B?ajVEbE8xaXVoTnFzWmlYenVYR0liTi9SU3d1UXBnMjdOVHpTUGFtV2p4c0Vw?=
 =?utf-8?B?SEUzcWJ4U2RubWd0cWFSbEhRaFJoYUMrYzRjVlRVSXNHei9yK1krbnpSRmlD?=
 =?utf-8?B?MVFWYnZQL3BlSGZOamNvcUw0a0VuZjIxTHNVdDVqTE1qbyt3bDFWd01BRU1W?=
 =?utf-8?B?bkRHMG0wK3lSNW1yVGhnMVpPVWJkZXl4YzU3c0tkb1Q1L3NrbDQwcy9ZLzQ0?=
 =?utf-8?B?Tis3SUx4eXVDRko3NitkY05hS3ZVRlFTSHIrUjNwZ3JwbndjMmc1SU1VQ0pm?=
 =?utf-8?B?Nit2K2hCM3JvcUZGZzBIbW1YZUhNWGdNNGJ6bExjOHUvTjJEMTJ1RC91cmdv?=
 =?utf-8?B?a0VWR1hmQUNROWZmcmREUDNyaHFoOXpRcnV5OFpTS1F5MVBkZ2p4TjdLWlJn?=
 =?utf-8?B?d1lhb1k2dzRDaUxkN0lGVVEwdkl2TUpHSU5Ka1dGU3RSaXI3RXhSNi93NXhG?=
 =?utf-8?B?cnZDamVvNjN3V0RJclM1VEMwanBrdDQ3NzZjZ1hiajdONzB6SWpKU3hDWlUv?=
 =?utf-8?B?RlUwcDBzQkRIZzZzZ3lwOUcwTXNBcEhTMDFia041bzdqVkZjZCttUytSaUxU?=
 =?utf-8?B?ZVBGOTh1OWZ0bk9jL2t5RU9FNHQwbHBIN0FOdG15aytRWnUzZkVSeW5iYUxF?=
 =?utf-8?B?dlQ5c0JNTmlDcXdDUXNWcTZUMFN6clRJNkdrNm5sRW1seWllQzY5cGdVazJX?=
 =?utf-8?B?cEI4d3FNU1dmbkcvL29UOGJXRDN6aWI0TzA4UHNXbWdFZFNQRWFzVWdlL3FX?=
 =?utf-8?B?a0ZtczBkNENuOGpoeGNoNlJGSDJhenNmaEVsdjF3NHNGWlE0YXhzQ3BmdXht?=
 =?utf-8?B?SkVNdDN3VG4wdVBseVRoQ1ViUENwdGtwd2tUeVN2ajRjTGd0YXFpRnhNajhV?=
 =?utf-8?B?VEVEU3dpK25JZml5NU5rREwwWU9peVpac2wwZWJ1TnROdXZJUFZqVWZxY1Jp?=
 =?utf-8?B?NmtTQWZ0OUVjcHpDZ3c0M2FuYUFyVUVWWlJ6ZVpSZ0pFWFk1QXN1dVIvc1Nt?=
 =?utf-8?B?UlllbTg0dnZ1ck0rSW1STUp5UkhVNU9qcnU3TmUxQllpa2ZEaHJCRTlJSFJp?=
 =?utf-8?B?VHU5SWxSNnFUaG4xUXlCTkRrUExvUnBFTk51VTFjUjRFTWZ6NVZ3cW9IUmYv?=
 =?utf-8?B?bXpxcVhhdjlSZ0hiNTlOWFA5N0hsenZabEZsMUdwMHB2VUhrdnlhVmdYeGU4?=
 =?utf-8?B?Y3JVYTNzWHF4T0xzRjBtbGNEUGkwSlhGamZMVEFlZVlNYnM0cGtwQ0pQNzlP?=
 =?utf-8?B?dmFqbzI4NkNIRXZZaEhacDdVdTlZbm9ld0tnZ04yN3NLaUUwTDJYNmxvUG9k?=
 =?utf-8?B?aXFTUlUvQS9vNHU3cktaOVRZdEZTSGFET0dYczRxbyt2R3NwdVZXT2dyTS9q?=
 =?utf-8?B?ejFvMGJWaDhidVQzSTNLRitnQkVkMmNLYS9DZVdRUFMrY3RYekdYTEF1cXha?=
 =?utf-8?B?S25GVjJRTFMrQkJhZFFZQ2dURm40TmphaUYwcU9OYzJQektRdW1CVE5PMXN5?=
 =?utf-8?B?U2c2UjJPRG9xOHhHR3puckQ2TTQvOWhvVEVMRDdSbnlnWWhzZUR6U1ErNVlN?=
 =?utf-8?B?bWFDaGhMK1hkemllb3pNdVpYdlpCZFZBeHVjd2swYXc5MlUxTVd6emhiaUor?=
 =?utf-8?B?NWJUY1pZVzFMeGM3QVRpS0hsQmNsUW5vR29HOUc3T0ovbDYyNG9YWCsxZnVZ?=
 =?utf-8?B?SnAvNEpBZjYyWm16TXZZc2hsUER2L243cnBCSFViK040MzB1cWNrcFdYS21m?=
 =?utf-8?Q?UWVezekBO2L+dSbEhfdJv+pF8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0aadff-3941-4fa6-8fc5-08dce9e6e864
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 11:21:53.3378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ee8saWw/XvdhR6GQtri9Hyn0hcbvJG8y58dM5DxrHaUODkQL/D+VfoOEq3UFA1HLcLQe2yZruLuiOYrAPqt65Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325

Hi Dan,


I think this is the same issue one of the patches in type2 support tries 
to deal with:


https://lore.kernel.org/linux-cxl/20240907081836.5801-1-alejandro.lucero-palau@amd.com/T/#m9357a559c1a3cc7869ecce44a1801d51518d106e


If this fixes that situation, I guess I can drop that one from v4 which 
is ready to be sent.


The other problem I try to fix in that patch, the endpoint not being 
there when that code tries to use it, it is likely not needed either, 
although I have a trivial fix for it now instead of that ugly loop with 
delays. The solution is to add PROBE_FORCE_SYNCHRONOUS as probe_type for 
the cxl_mem_driver which implies the device_add will only return when 
the device is really created. Maybe that is worth it for other potential 
situations suffering the delayed creation.


On 10/11/24 06:33, Dan Williams wrote:
> Gregory's modest proposal to fix CXL cxl_mem_probe() failures due to
> delayed arrival of the CXL "root" infrastructure [1] prompted questions
> of how the existing mechanism for retrying cxl_mem_probe() could be
> failing.
>
> The critical missing piece in the debug was that Gregory's setup had
> almost all CXL modules built-in to the kernel.
>
> On the way to that discovery several other bugs and init-order corner
> cases were discovered.
>
> The main fix is to make sure the drivers/cxl/Makefile object order
> supports root CXL ports being fully initialized upon cxl_acpi_probe()
> exit. The modular case has some similar potential holes that are fixed
> with MODULE_SOFTDEP() and other fix ups. Finally, an attempt to update
> cxl_test to reproduce the original report resulted in the discovery of a
> separate long standing use after free bug in cxl_region_detach().
>
> [1]: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net
>
> ---
>
> Dan Williams (5):
>        cxl/port: Fix CXL port initialization order when the subsystem is built-in
>        cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
>        cxl/acpi: Ensure ports ready at cxl_acpi_probe() return
>        cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
>        cxl/test: Improve init-order fidelity relative to real-world systems
>
>
>   drivers/base/core.c          |   35 +++++++
>   drivers/cxl/Kconfig          |    1
>   drivers/cxl/Makefile         |   12 +--
>   drivers/cxl/acpi.c           |    7 +
>   drivers/cxl/core/hdm.c       |   50 +++++++++--
>   drivers/cxl/core/port.c      |   13 ++-
>   drivers/cxl/core/region.c    |   48 +++-------
>   drivers/cxl/cxl.h            |    3 -
>   include/linux/device.h       |    3 +
>   tools/testing/cxl/test/cxl.c |  200 +++++++++++++++++++++++-------------------
>   tools/testing/cxl/test/mem.c |    1
>   11 files changed, 228 insertions(+), 145 deletions(-)
>
> base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
>

