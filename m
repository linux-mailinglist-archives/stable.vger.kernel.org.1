Return-Path: <stable+bounces-66081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6617E94C446
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 20:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF701F2681A
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 18:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897EA147C86;
	Thu,  8 Aug 2024 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="H9eguaS2"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022102.outbound.protection.outlook.com [52.101.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC947146A83;
	Thu,  8 Aug 2024 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141573; cv=fail; b=KSsLfISx0d+fih00RmOmAAIr5mua4M6yceUkBWjSICcRwKruuOWOxeUzaXKvGgfAY8/lY9evYYzLS4xC4ntstfHYaI4Y12stklqbKY9hPArL5c532juxJ9ff+kd87q9aZIIsaPzU9ggTcogDuOghsG0CIa99sYv8MHZ9H2/PBNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141573; c=relaxed/simple;
	bh=iZwHhy9hVDDE68CezuZu1cTyPbffC2zdnLeIpw670lo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fLM2LtS8JBI4YJT4K52DewKwA0xCkueL+VnHgvPQ1IvHJOM5enavO88TrxESIS5z/nIBsTQpLQd3oc4gEAc37CYFjHx36w4hs2ZDGAfmd1kbqCW+Z3ojmZZS0lyqVg1G3M+skAzNd5Gv541Tv1Fh0hopWB8a/WdRXV2kgJGQQ8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=H9eguaS2; arc=fail smtp.client-ip=52.101.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsgcU6SejkT2aUoOSn2h/9zJc8sT83ENwS+2Jmp6YVHZELowC8pmoDx1WXANHetAdRSdo7Iw+/4BDjEofDsHiC9BYbugtaXH4UtxsREkzTmjnhevkup/YpDYieg2zcEWHsdRb2MIoO8QbT7fQPUpIZmlysfgVa6mxD7cVoA2RZrFEaTKx7sFVQLNzEtFepJxIIOWpqrmIxtg2X3GFt6K7BQR8hGdDIy6pP/Ps7BzheMmkAw0OgnyYupK/JNyMMkLNe5Oc9rn63OX2z+yAog9CfOsXq228LL0OLljh7A6RM6VJFVj8NskRZ6lLHvXrUkJKHBMLQKNWBF4a7d1dd/aAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y81390UmOZxGl78Khjhro36NrV0o+p6KNr+180uCSD0=;
 b=TaRHGFqOKAf5r5Wi1cbxJckVzhCvMnpQvl5B/v/0EMlxe6OzV0jrdWWT7m1fp3Af5QziEvDa75XnoLyFl1tuBpwkPiO4u0MGdaKEyUTr9cp3qPV9ySFtqcXlrmS30TghjpQsmUvGl0qTjr60/HfROD41EeT3D5FM2Gf6VmGX3kK1Swn0mSZ3ekMq8G+hwpFE6Hk1YO1KlDFVAjpstZdNpH1qOqemIyeoFKl3XvFHEkAYGhIrUL/E57vvf+6RUsTKUIa7zMyzC/0iV0V56QaP0ocAHbVUi0cMvKTztEY1jmza6LP6PMbzzi6a69KHY8M10XQwzgDIzlrRBk/hXqSedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y81390UmOZxGl78Khjhro36NrV0o+p6KNr+180uCSD0=;
 b=H9eguaS21raxKiAa5E+Dgin6dMHnN6fhepPPyBTa1uMIkSeGoKhwuBuTgDm5l2Gw0wZdUBTMz7Z6//w/udu8PlHA7WEf5vVCFgnBmfqh+ucy2g2U5dujvD0vodjhoE4pQBmAgnzTbQtURJHOlXRHhaJk5xaikTMQPO+mZ5XJRfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SJ2PR01MB8206.prod.exchangelabs.com (2603:10b6:a03:545::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.22; Thu, 8 Aug 2024 18:26:09 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 18:26:09 +0000
Message-ID: <1be3a4fc-bcad-4237-bc9c-8b476e25fde4@os.amperecomputing.com>
Date: Thu, 8 Aug 2024 11:26:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v6.6-stable PATCH] mm: gup: stop abusing try_grab_folio
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, yangge1116@126.com, hch@infradead.org,
 david@redhat.com, peterx@redhat.com, akpm@linux-foundation.org,
 linux-mm@kvack.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806193037.1826490-1-yang@os.amperecomputing.com>
 <ZrQYbLGWVf9zOT1p@sashalap>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZrQYbLGWVf9zOT1p@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SJ2PR01MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 69cb7ebc-55be-4944-f515-08dcb7d79293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTJiaytRRzByMk1mZHlyV0tOdTVzc0tMdis1U1N4eHNTUXBBekRvaEZ1Y0JT?=
 =?utf-8?B?QzMrcy9SR2RJQUpIWUZlejFUQ3ZUWE1hd1YxZ3F1ckVyYk1QOVdMMHUvRHdO?=
 =?utf-8?B?MHlPellNTXJOY1o5M3BBaVFiaXo2aCtxYXEwaytsOFhuVVlVZnNJYnJwTmNj?=
 =?utf-8?B?M1hRc1d2R09tQ29pclN0K20xNlg5WDloWHdxWFd1VFRJVlRSekNQVzluN1c1?=
 =?utf-8?B?MGcyUFhpVmY2VHlrUEZDVk9BNytFc3ppL0pkRkxieWY3R2FnNER5Y1dldTJr?=
 =?utf-8?B?YjFDNWZaUC9WTFpFVHhQRkJKU1NVdzlmdVk0Szc4MEU0RU9RMlZBS1FnVU9Z?=
 =?utf-8?B?Q3VIdkVwTXZUb1JRYUVXQVFwYWdNVlA2dUlyYWFnd3V6YnV1M3ZMTUp1a2NX?=
 =?utf-8?B?dmJhRmNNZjNmWE9PaXI1bW1uSm44bXhYRTJXaXhhWWpkSWZRdWd4ZFZXelBr?=
 =?utf-8?B?WTBFK2Yzd1U0WkVzc1Rhd0lEdmRwM3B6VDFrMWRVcXFXd01qZ1FGQTdFMXpC?=
 =?utf-8?B?cGthQlhoMTM0UDZlV1BWUEovRzRvcTJwSm9MRzVlTDJQYmo0UjFoM2R6ZXNE?=
 =?utf-8?B?WWNzaFZJUnBsZFE0Vk1jc2ljNTgzRGtIU2NKblptZUxRd09MZnVDVE1FcXVK?=
 =?utf-8?B?SW1IVEZjUlJNbUNJVTZQdWhFTFJjVlpaRDJvdlBXa0pEM082WGF0NklVL3Z5?=
 =?utf-8?B?amlydzdYUzZUMStLMkV1WG4ycHRsWU5LSXM0N2dNWURYelBxRklHMmUvNGFr?=
 =?utf-8?B?aDF5MURWNDFTbWF3dDJrRVdTdzVvUWIwdGc4aWkrRmdyaFJ4OEJaVlVHVnNo?=
 =?utf-8?B?UVhqVVlSNUVzdFlHUnZPTXZJSXQ1cTQ0YnpkajVENEY4YXVTTW5ybDJmVFgx?=
 =?utf-8?B?SFdDSEpaQXdHa0hubDhhNVA2SzRhdzVLRnJFQVM1SklmQm96b3RkaGlPTW1a?=
 =?utf-8?B?cFhhNzJNN0hzY0VYOW5EKzhNSDBGKzd3dDRLQ09RUDcreUpQM2ZhZWVtaWRz?=
 =?utf-8?B?MytoMW4xN3VGbUxTeGt3YkMwQndVS3NxS2d0WTY5VDFnQTU1MGJoZHgxYXY2?=
 =?utf-8?B?R28wYmZiZWJUSkpJRUVSWFlDditwMHBPSDN6Y3FKSjNERUdmdzdPczZEYmVL?=
 =?utf-8?B?cmM1NzBENTd6dFNYTzRSSWkxQ2hqQnoxL25JejZNRlFjanIzZUJ5NWVkVmhv?=
 =?utf-8?B?S2ZFVFJxcDZzSGdWejI5WDRxMUJ5cG0yUGxxSm9VVmJhdWpuenFBQmd2dW1p?=
 =?utf-8?B?WGkyQkxVdzMrZllrZy9qQ1VQZ21XZmVOTWRXTFp6SnAvUTY5blE3SVBUVmJi?=
 =?utf-8?B?VnJjamg5eTVmd0QrZkRsdWlBaVJ4M3BRbkJXMEZBZ0pIdG90WVhhNy80ZStB?=
 =?utf-8?B?YU5RYVpNL0lmeUVqVm1UajBDOVBhVTRaRXNadGJOb0pSRzdwaGtNSCsyTm1P?=
 =?utf-8?B?ZjFHMGZESmR1eUR1aEg5TU9yS0Z6Nncwdjl0S1lXeDNsNmFzYm1PU0QwWG1o?=
 =?utf-8?B?S01UdEl5VUNPRnBKbm0xTk9BU2ZLRFBCTVZsbHN1NXdHVC8rVC9iNnEzc0V3?=
 =?utf-8?B?VHkwMHVTN3ZzOHlMR1BrVTQ3VEhRK1prc0dzZWJmcWplaGhVWTZDTWxIY0VP?=
 =?utf-8?B?UkRSY0I3K1RBd3hDTnoyVVYzRm9LUGV5Z2Y0bXUxQ0IzYW5TS2sxVVlOMlF3?=
 =?utf-8?B?UFhDSFVwZEhtTWdwc05vRmpKdExvYWd3NUNic2VCdk1oeWxTa2djQko1Z1hm?=
 =?utf-8?B?TWdPYkV2U1ZpZWdwRSt2bVFwbjR0WmdYNWlVZVp1L2tjWStkNCtKejZmUW8w?=
 =?utf-8?B?SzFablBYUU14NlliMWlyUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzdpT2pXZVo2NGJTV2ZDYWpONGo2dzlnQjhLcmliQVVLRWk2OC80amFNTzlN?=
 =?utf-8?B?QVNGN2Evdm5wdVV6WmpDZTV4N21rcklqdW5XRXBBTDVKZSt1YXlybmxyd1Uz?=
 =?utf-8?B?OHFnRGNOOUFnVlU3Tm0zeEx0N0hJVlRHTzNMQUM2RVNpWHduTUNVaHIyaEo0?=
 =?utf-8?B?OWgwY0I1WVhJT2JaRHlnQ2JvWjBsclI5L0VWRWkxMFFTRTFPU0hnN0RXSmNo?=
 =?utf-8?B?U0hYZ1ZkeFdPTXdhckxIL0VycVZBb2JEanlqcjNYdDlRSmpJNEw4dUJWOFlV?=
 =?utf-8?B?bzJRc080azJkZWMxTFZZdExubDVHRFFhUEVIZHR5elNtZjgxWUxIdit1TVRM?=
 =?utf-8?B?bU5Bc0ljdVNnU1hJSTNYMVNVNXY2MnRTRTU2REFpc0VMczFWVFY2RGRzMEd2?=
 =?utf-8?B?SksrNm5rZXZYZHYxLzIvWnlBUWUzK3J4R1dDcnowbkRGZjQwMFFIeWFiYS81?=
 =?utf-8?B?RHpnUzFreC92bzJNUmN0aGZaWnd0dERpUC9qaldvcmFFa3lhMFJ3MEdaUjFW?=
 =?utf-8?B?UEQxcnk2QUdkQlE0S29HdGQyMWExa2I2eSsyeUtjUHB4akVTNWdjbzM1RzRC?=
 =?utf-8?B?WVZLcklQeHNhSGd5YVJ6aTk4blRrcUN6NHcyQklHb2ZJQXhza0Qzc2ZtV1R5?=
 =?utf-8?B?cjJVOVIxVmwwRTFBaURLUWh2enVadCtlQWRJN0UrbHgvMUJaeXpSYmR1MHhJ?=
 =?utf-8?B?TGxhMlk4L1UrUDIxeUJwUVppTkFJOCtiWnNveXFmeGwyMVAxZGUzOVZyQmYx?=
 =?utf-8?B?R1Zybys3SVNaVC9kbEhXcFIyVDk3cTNxem9leTVKdlU0Vlo1bGo0RjZKNXBs?=
 =?utf-8?B?S25EVTdGdEJBV2kvTVhxTk1xOXR2S0J0YVNXTWxKcnczRG50dEdYcHZQTTYr?=
 =?utf-8?B?SVBVSVlMYWpySW4vNVk0bXl0cEdrR2ptb2NBWitmZTdZTkN2YjdpK1hndytv?=
 =?utf-8?B?ZkcrK3FvUGlsNGgzWFN4akhkRmZJWVVMVldPRENBaWI3SkM5d1AxeENUWCtH?=
 =?utf-8?B?YXV3ZHJhMFBDUWg5Q0xaNHNNSjBEejVLQUhxRmo3TXdFSFphQUtxM0VRaVYr?=
 =?utf-8?B?S1RveGZuNERjZlhYeE5OTGY2UStVUWpHMmxwRUFqM0ZXcXNjMFZ0Tnc0aGRu?=
 =?utf-8?B?U1lOcHNyK2t2UXdSQW1KbFhqeHU5ZkphV3dXaXdSZEltSjZvQkRTOEZ1YkNJ?=
 =?utf-8?B?ZVhsdGlFYmY3SHFZQ2RtNHNjTmlZM043TlVtY0JuUzdGRHFibnMxbkFpaFdI?=
 =?utf-8?B?Y0tSUEZoMVZkdmFrMktSc0U5NCtQOTdTZzFPNDRwd2VWQ01EN1U5ZiswVE5k?=
 =?utf-8?B?bW5TSUZXcjdOWTNLVCtMb2NLUm9BYW9LVmdnSjU4UUZ0ZDVtRkVTUm1BMTR2?=
 =?utf-8?B?aDlFc0VKd0pISnp3dXVEZHV4VktPWUxvcHg0aHFWb2dnNjlJazhKVElwZEcy?=
 =?utf-8?B?eTAveXpxWk8vejFSbGVLUW81SjZ2NHlzbEFXclUwYWltREUxQnhSK1FVeEM4?=
 =?utf-8?B?SnYvZk1hUE5jMm5Pb0lBTThQYU9rOEhJYjR2bndZZUZackZQd2NwNzBXQ0tS?=
 =?utf-8?B?ZVZhdmlEb3lkNFJFRGl6Q1lPaXJNL25ld3pGYnRhbmJhVUU3Tm1LMlltQmhL?=
 =?utf-8?B?T0pvV1NTajV3OUtIZzBtUzlHSDEwM2w2R3AydTV6aFNOQlJqVXZuUGo5THVE?=
 =?utf-8?B?OWNsT0hZT2dPcWtzMHE1alRiVUpLUDhCSk02cEZvc1EwU0dHL1dEVW05YmlF?=
 =?utf-8?B?QUgyVXpLVnVZbUJCZ2FjUVJuaXBUdjh1Nm9yT2R4NFA2M3RlNVIwKzdwcm9K?=
 =?utf-8?B?NXJDZ084QUVDZnQyNGZ3aVhxbHV2RWZVdnducCtjSDVBcWhkZnNBSXJHWVND?=
 =?utf-8?B?TnJoa2VadERMZE1xd015Z0hUZ0xuNmh5eFRMc2xiSnpyclBqb2h6VjZrNWJR?=
 =?utf-8?B?dFFHRk50TE9oMWxpSEEyZjNocnFKQnhWUEx1YzFWU1BEQVlMZUpCelB1cjdC?=
 =?utf-8?B?Z0lWc0c4TEZNU1BvcUxoYlZENHZKRW9JeXVZNFFjSXk4QmVFai9XZEc3NG95?=
 =?utf-8?B?YmRsVFg0cHhCU0lvVlpIUFNML01pam9VeFhtaDIrUDdPUmZzanprSDlzRVBL?=
 =?utf-8?B?MC9ZSEdrOEp1T0ZZc2paRHh1cU9GQURtVXpHdE90cnZVdnFwZW9kYjhCVkRG?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69cb7ebc-55be-4944-f515-08dcb7d79293
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 18:26:08.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SJazVMAUAyC2FDe7gmpjGaXG1TngzU+OnCusM5b14Vj3X0YAfzDHI4D2u8Jw9P8Y4NbU1WLcD/KGInwqVx5MHEejQh7e2xMMebm4qHDdpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8206



On 8/7/24 5:59 PM, Sasha Levin wrote:
> On Tue, Aug 06, 2024 at 12:30:36PM -0700, Yang Shi wrote:
>> commit f442fa6141379a20b48ae3efabee827a3d260787 upstream
>>
>> A kernel warning was reported when pinning folio in CMA memory when
>> launching SEV virtual machine.  The splat looks like:
>
> [snip]
>
> This doesn't compile on 6.6...

Oops, CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is not available on 
arm64 (my build machine). It is also a problem for 6.9. Will send v2 soon.

>
> mm/huge_memory.c: In function 'follow_devmap_pud':
> mm/huge_memory.c:1213:8: error: implicit declaration of function 
> 'try_grab_page'; did you mean 'try_get_page'? 
> [-Werror=implicit-function-declaration]
>  1213 |  ret = try_grab_page(page, flags);
>       |        ^~~~~~~~~~~~~
>       |        try_get_page
>


