Return-Path: <stable+bounces-88115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E19AEFB7
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 20:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895521C216C5
	for <lists+stable@lfdr.de>; Thu, 24 Oct 2024 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15A21F9ECE;
	Thu, 24 Oct 2024 18:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="KMFmN1nt"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022126.outbound.protection.outlook.com [52.101.43.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FF12FB1B;
	Thu, 24 Oct 2024 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794788; cv=fail; b=qrBpRvZI+0fwafAE4URYQdsAM6zADox28jWLERGBFkYLPMj0yPC/U1IzAVg7l2oqJBRoNMDQuIkGAMyBNjY2hRB/aPaOezHcH/AE3eISnT+uwCLKoOKnm4WSrhlrHhvKfDbdQPINNbGWCBdff0JNSW3pp8IXARAmK7XS7H/6upU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794788; c=relaxed/simple;
	bh=aNWCR6VWJfGwOikHz4PGi8pX6BsiDAZ1X+BMWb2eh+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tzo06kYkVrRw825MVmumZmTM71120z83ANLNM33iEkUwRx23cvfWcioWMWrfV1vj1nXRP8TWZI2BsWtNYqrkB9Tf5IgLC+QdpxArIq1F6Uey2v+a1IzvRGtiV5uE+JWCGRAQS0Lv99VngGmx7m0ExdDBd9uRneaRTlk+BNI15DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=KMFmN1nt; arc=fail smtp.client-ip=52.101.43.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rz7qc4oaDR1XI6TBNFyJSMpPFoRIYnoZfvxGEElZ0LKy/+49at9CXfmuUbM0y/ExAor4WbbBcUbBYCFm0wAZThC1jE+SFx1eYppwrsKbQpF6GFJb9JZrWr3zlHjQOFs/9RZsywobVoQD/7T7lg6A7K1C1LsRi88gpKnhVcHjrYC0CcUy3jawUIJh/UIQQ0pOUtSnQPaAmyhOM5PAH5HggFkD1N1rz6589CaPAwU9BEPETfN9jlKDB0iEEsAx/7YLLY+3PSmA/SpUyQAdN1LBEomAkAS2YpDv8wPs4PflKwMRvrrOwvkKI4WxW+vMCFZaHj2T9/trSw7yc7cuhMhqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f4WoMUwQM6olCgHQBByBtHMBL+0t4yWVdbZoZ52ggo=;
 b=TFQC98yciQtg4qseCDXsgvc+AvIPc0qgQH3Kt8ta4MIF43oIcpAUwn+tLO3VdDTWnYuB7AsI3WtkZ729CVPGcWkS71ya4s+RFc1Uw7cVilKHCBH0iLXXpjX8KsOL8cqInyWbDJmHQnKRdZFCdmQP7SIHthWLRkmaKvBynTqHnBFzDe+/59zmue9YvAnGGq6IBjStfzSM7cw4RIBxAwWDeceTFCu6V01vT0NXMkz2TkRnoK6j2HjUFgibaZGw9trXqV/QsW1lThcuKpi+TQ85r8nv6NGl4UUhCU41W6LSoM3LyT6dzSLSEz2RJmWkCG6E2z6LbDl7hQoCynf/WgQnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f4WoMUwQM6olCgHQBByBtHMBL+0t4yWVdbZoZ52ggo=;
 b=KMFmN1ntE5czBkfCKSa/eGDqnb5i6PAizAFVz3B2WIyHwrSpqXiBUo1G6PozSeu22NheHAqrmoAIJHMRD2+91SqVywkUFEFnnliU5j+mU8Vn2zPrt2lcJyJU9fJSx42uutUwfwOI9vSSFWLQ9RyOrOoE5iZVFZHd4uobSBhjsms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DM4PR01MB7884.prod.exchangelabs.com (2603:10b6:8:6f::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14; Thu, 24 Oct 2024 18:33:02 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.033; Thu, 24 Oct 2024
 18:33:01 +0000
Message-ID: <e11629d6-c2dd-45fa-9ca6-7a6e38882560@os.amperecomputing.com>
Date: Thu, 24 Oct 2024 11:32:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12] mm, mmap: limit THP aligment of anonymous
 mappings to PMD-aligned sizes
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>,
 Michael Matz <matz@suse.de>, Gabriel Krisman Bertazi <gabriel@krisman.be>,
 Matthias Bodenbinder <matthias@bodenbinder.de>, stable@vger.kernel.org,
 Rik van Riel <riel@surriel.com>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
 <20241024151228.101841-2-vbabka@suse.cz>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241024151228.101841-2-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH3P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::31) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DM4PR01MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf4b5f7-8f10-4118-f596-08dcf45a4ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm9SQkoxL2pBQld1OUJXL2VKMlVpeUtiazRhN0JLZGtUaUdFd0s4bldydWJn?=
 =?utf-8?B?UHErKzBLUlpwSG55dk9wQWw0K25vQUhkOTAzT0hRcFEvZmZrcmw4R0hwMzE5?=
 =?utf-8?B?VUViNFQvUCtLM2huNGlIQTUwOW1QMUJlNHI1WnFOMEhZeWtMb09JeE5GMW9V?=
 =?utf-8?B?TTVlYTNBRHhwRllLOUJlUjRqUEgyNVd1dCtjbXMwV05xbXhBd0lqUVk4b2dR?=
 =?utf-8?B?TWQvU2JjcDRCVDdMOFk3OXE3bWR0a0Zzc29YM3BqWjFybmEwMEZLQzI0WWZK?=
 =?utf-8?B?QlBzVDFjZWFvMnVLakI2a2J6MThCQjZVV3pLWDVRUW5LeE5XdjBNdkM3QnZz?=
 =?utf-8?B?U04yOHpFaWtucEtKRENwa2VOejFYY3U1QkpjaGVMbmlwNTZocjJFdnk3cS81?=
 =?utf-8?B?bUFHWW94TmtGRkx4eXFaRjRuekRhSkZUakNwTFFSUG1mZnowVHRWQkgwMGtq?=
 =?utf-8?B?OWIxdUt4dzB5N2k1bUROR0hJSmF6UHhkUjQwb1NFTWZFUVc3cW1HL0tEYTRz?=
 =?utf-8?B?OEViZkFiRkhjcU0vVWFxT2VKa3N0SlVlMlhzWW1GT2NEcFpreTZ3MUQ2elFJ?=
 =?utf-8?B?UFRsMFZKaU1SQTVmWjY0cXJ5eDlkVDh3V01HV2pRV2dqYkZaYmY2UkJ0TkRQ?=
 =?utf-8?B?SDRsNEFPcWxHdG96OWhVaVhFOFQwQTZXTlNlUUJxWjZYQUVhenBQRHp4YU91?=
 =?utf-8?B?aEJDeEd3ZUN3VzFTZmlVUlFFVHlNei9iMUdHRXdRaS81akg4UUpldEF3RFZT?=
 =?utf-8?B?d1dmVUJWRkdzSFMrSkFSNDBWNWZKVTVBbE94RThMQW9oSDNSa2I0eGM5UFpV?=
 =?utf-8?B?NE5NcUNFY1R0VW1sR3ZHS2hqd0RVOUViT3NXTlJySGx4azYzSnU0c29RcTl6?=
 =?utf-8?B?eXFKQ3hLeHc0elc5d3JOUDhVSDk0blQvWGxGaTdLYUFmVVREOEZidDVYYkl5?=
 =?utf-8?B?TkJGcTVkbHNPSWlDSWdNbzJEdW1FTnNGYWJwbEJnK08zL3FBSU1BTmorRjJV?=
 =?utf-8?B?Q3hsV3V0K2Z5R1Fkdkd2SkIzZGRyWG9KNEpCRjl6ZStJbmtEYTNVejFhZm5r?=
 =?utf-8?B?eG1xN3BYSm52TVk2TGtzdEV3eUU0aElPZFY3VjVxQ254L3FkTDdwR3EwYWh0?=
 =?utf-8?B?MkZBRU1LRm9xZHRYSVBJc01TUVpxd0pHbnZSd210U0pEUVdDRFhsNnhhVUJP?=
 =?utf-8?B?ZGlVTWtPN1padnhWTU1aeUdrTW53RFRLQTQ4dXhHWlJqaEJoamI0ZzlFSjRF?=
 =?utf-8?B?cm9Vei9PbmU2ZFJ0R0tpRmlUUkhpeGpQSGJoVldYeWRSaHFJMUFvM3lGdjJ2?=
 =?utf-8?B?MVE1YklvM2dOV3dUM0lQOXlVMmFWNHdWMlpwMkpZQi9xcTFMUkxreHNGeDNq?=
 =?utf-8?B?Z2lNVVpuNjhmaXZ6QUpVUnE1ZmNSTElmQnBNUkFiRjVkSy92NXl4NldVcEd5?=
 =?utf-8?B?Q2REMDdOd29YWEZhS0FGYTJsUi80Z0pYait0Umw5MFVzeHBqaGJqeFdtY3NL?=
 =?utf-8?B?RHU1NGdUV2FJbmw4YkZaWVA4TnhyS2JvVG5KRDRFMFIzdTJYYy84S1hHSjBW?=
 =?utf-8?B?b2ttMllnQ3pJSGE3Z2RkbW91bWdZaE5TMjVQcUI1ZDJpOW5WcjZwK0loVFZZ?=
 =?utf-8?B?Vy9hUEhtZkJPY0t5a0VvSC90bE9OWjhUV3FaejBVUkdWQ3N2RU5TcFViM3Zv?=
 =?utf-8?B?bWV5azEvakF1ZE9wYkpya3NMMHBxa3NCM1QzZi9lTXNHRTFtdi9XZG90L1Jw?=
 =?utf-8?Q?souU5BqvYp54RxT2EioD0L4Y4yfNWOBxWPdbRNH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YURUOUd2eVJ2UE83bGM2MVU0Z250ODNpTUJrNFh2UklwaENwUTVMVFNyVjlp?=
 =?utf-8?B?MUtBTmlkeEN3SDJJd2tIWVZvcXZSdlhCZEZaQXR3cjNZYzkxVU9ON3BTZmZE?=
 =?utf-8?B?YXNqUlNhODFxTElmY1lGVUFGalA0S3NqZGNwUWJPb3BvZng4enlwRDU0OWV1?=
 =?utf-8?B?Q0RwL3FQL0tydXVHM1VLOXpGdDB5aCtLSzBTUHF2UWIrVVVjSXJmb3djWG9r?=
 =?utf-8?B?aWd4YVpGVkh5QWVzS2tqUjV0R1FtVTBkaEdHZzllK2hSdDdzbDhvb0Z0K1Z1?=
 =?utf-8?B?WlA4Y2l2L1I4RGJuSXNqU2VRcXRsMXdFK0gyTytEY1hKM2dzV3ZUUkhrZFBV?=
 =?utf-8?B?QjAyQm4yelBLWm1pbEdIODhKa25keVNKcUJSNGx6ZzlVdjVDdEE0QVRtK282?=
 =?utf-8?B?d282bXlDWnR1UThBTVdlQVJncThuaTUzZ1Bnbk9Wd2ZSL0VFVk1YL0lrRmlo?=
 =?utf-8?B?Tmt0RWdjZGJ5ZzJNT3AwRElBRHpqcmxtMjlNTE5USDZqMkpxYXdBVmdpT1hP?=
 =?utf-8?B?ME05WEZ6VExZdGxLVk5CUmNVTjYvWTRscVFCd0FDZU15c3BwMFhRRVl5eE5L?=
 =?utf-8?B?Y3RhWTU3N0IySCs4VGIrZ2N4QkFuU0krR2tMRjJJWGxHSWErRGUyVlZkNlhZ?=
 =?utf-8?B?enErbU5GMDV5ZTNmUXZ6QmQyVUpOOUs4dU40WGo1TE5US08zREVoZjJXd0JQ?=
 =?utf-8?B?M1VPQXBXdlVxSWgzTElWQVIzclhiVUtLeGI2YmxSMmhuQm9iRlBqZXlRd3A0?=
 =?utf-8?B?MXZhQUJPVGpReG5McE1Nd0xlMGJxRDRRRElvOUxVazZVa0FtbnQ2VGJaaTBp?=
 =?utf-8?B?TEJnbkNObXRuR2pwK3p5U21mZ3NQTVpyM3F6QUkrVnhiUEx6UXF5andyVTRF?=
 =?utf-8?B?VmgrdE5IOWUrSktoUjluK1hSTE8yNFExNlE5aXFwVmFRM21QYjBmdkZNM3dw?=
 =?utf-8?B?Z3J0TnA2YU1ZNGgvYVc0djVkUWh6bmptbWg0K2RPTlV0Y0JGaUs4WlU3dUJW?=
 =?utf-8?B?bUEyajNidkdrTWFJUnN1MzRGTG1SaXducExvenRScGNnaGdKUlNKQkxZdWFK?=
 =?utf-8?B?MWxUSXRlZzhrK2FQcFNOWHl6YlVLaENpT3IyZnhMczlKNDlMd3IyVHlHYXl3?=
 =?utf-8?B?Mjd2K091WjhjZDNYUHgvY1k5cXRkYVZWVHY4cFhBbVJVdFQzNE5sV0lHQ2xs?=
 =?utf-8?B?cFFBQXU3QnhqNjVOK2QzSlF3MC84UWVsVnUxY3BMS2JpWmQ4MmdlNzJ4ZENj?=
 =?utf-8?B?bWxJN0Q5OFFrR01aN3dlYmVrbHBtUG51THZVVU5SQzV4cXBvQUMvRjZIUCtB?=
 =?utf-8?B?Z1plbmlLOVZGcVRYZkFNVGFzb1VTMHdYT0FNMzlIUkl2ODNWSWRDWUQ4VGFv?=
 =?utf-8?B?YlFsSWFTcnJ6UGNXZnYzVDMydjNPWTJzODZiQ1RNallCZTcvdnVzR0E0ZHl6?=
 =?utf-8?B?N1NzT0ZScGNJY29PVEh0eFgvQ2tFQVpScFA3RFByZmEzZnF0U2RIZXFaZERR?=
 =?utf-8?B?VGU2UVMzT2NNVitDQUhEVVdxV29lbitRdkFWZGRIeWh5aHovTXNBLzJ2cTdK?=
 =?utf-8?B?VjMvcjltd0QvUEkxZVRzQkdBNEZOdW4rZk1TY1o4R1FxMU5RVGRucmpLWTNh?=
 =?utf-8?B?YU9aRWV5V1RjNnk5c0dacUNCOER5RFBTRUVzNTVOdnRGYjNPaFBmOG5CS2xR?=
 =?utf-8?B?aE1DRW1WS296UUVFMklBOWhGLytTVTIzcDJMU2RTekRFN2xOWlJ1Z2pVOWUv?=
 =?utf-8?B?bWVoa1U4T2JsczVJZGpTQlg0Wk0zSlc4NE54TDNtYjFBMGozN0JIZFplREVm?=
 =?utf-8?B?WXRBK2YyUk95aE1QWGVRcUlsMHQwVlpZNHpsY3gxNTZNWjBPT1QyUHNRYXdh?=
 =?utf-8?B?RXUrbXNPbnh2WDdZRkVuTUEvbjFuMXljbkVGa1FJdVBqTGZNeDNYM2ErTktq?=
 =?utf-8?B?NCtMTFdleHdlSGc1eEczbjk2ZkxOVUg4c21BZnpGQnRRMVdHam9hN0xkMUpo?=
 =?utf-8?B?TWI0Y1ZKWEcyS095cm9NTE9qSDVUZVZrdmU1QTJLZjJGVmh5bS95TGFBQ0lJ?=
 =?utf-8?B?NXVHd1hRdjFoTXg3cUdiQVlOalcvdmZQR0xCRmJtZ0xmVkRCM2lNUFJXeDdN?=
 =?utf-8?B?WHpQVUlkbkgwcXZIVC9xRWdVRzhEN1c4cC9hczhRNUJKUUN2eE05ZlNtejlo?=
 =?utf-8?Q?2LZOyAtxbU+xG0E7dok1328=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf4b5f7-8f10-4118-f596-08dcf45a4ab8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 18:33:01.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wud/5Q/H+Junjkwb+W7cHX5Z/EcgxJk00dj46QJcTqpcErY6LUDGiFptJfu3B2OFikbDRgO449bHTEbbDws1YIPw4M8t5BiUasiHZ1gWvg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7884



On 10/24/24 8:12 AM, Vlastimil Babka wrote:
> Since commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> boundaries") a mmap() of anonymous memory without a specific address
> hint and of at least PMD_SIZE will be aligned to PMD so that it can
> benefit from a THP backing page.
>
> However this change has been shown to regress some workloads
> significantly. [1] reports regressions in various spec benchmarks, with
> up to 600% slowdown of the cactusBSSN benchmark on some platforms. The
> benchmark seems to create many mappings of 4632kB, which would have
> merged to a large THP-backed area before commit efa7df3e3bb5 and now
> they are fragmented to multiple areas each aligned to PMD boundary with
> gaps between. The regression then seems to be caused mainly due to the
> benchmark's memory access pattern suffering from TLB or cache aliasing
> due to the aligned boundaries of the individual areas.
>
> Another known regression bisected to commit efa7df3e3bb5 is darktable
> [2] [3] and early testing suggests this patch fixes the regression there
> as well.
>
> To fix the regression but still try to benefit from THP-friendly
> anonymous mapping alignment, add a condition that the size of the
> mapping must be a multiple of PMD size instead of at least PMD size. In
> case of many odd-sized mapping like the cactusBSSN creates, those will
> stop being aligned and with gaps between, and instead naturally merge
> again.

Thanks for debugging this. The fix makes sense to me. Reviewed-by: Yang 
Shi <yang@os.amperecomputing.com>

>
> Reported-by: Michael Matz <matz@suse.de>
> Debugged-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229012 [1]
> Reported-by: Matthias Bodenbinder <matthias@bodenbinder.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219366 [2]
> Closes: https://lore.kernel.org/all/2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info/ [3]
> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
> Cc: <stable@vger.kernel.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>   mm/mmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9c0fb43064b5..a5297cfb1dfc 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -900,7 +900,8 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>   
>   	if (get_area) {
>   		addr = get_area(file, addr, len, pgoff, flags);
> -	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
> +		   && IS_ALIGNED(len, PMD_SIZE)) {
>   		/* Ensures that larger anonymous mappings are THP aligned. */
>   		addr = thp_get_unmapped_area_vmflags(file, addr, len,
>   						     pgoff, flags, vm_flags);


