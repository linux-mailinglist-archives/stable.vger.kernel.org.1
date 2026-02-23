Return-Path: <stable+bounces-217711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIzPBV8WnGkq/gMAu9opvQ
	(envelope-from <stable+bounces-217711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:57:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6EE17358C
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46446301FC92
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEE834D922;
	Mon, 23 Feb 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lgeDTD1n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cpHPFG95"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E450D34C121
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837018; cv=fail; b=tfhTb9gWcFrHKAWIAaO43pCMKoFrl31+0W35l0PMM9TLUfqhzLoUgy+UeCNACzmlTHw21l5WWvbeMXu0u5LyqLLy8Tsu5UhNJ9NUf7YCmA5yyqPZZnSbugKqD/IgDh1X/ZKNzcrWS5vbnosHgX026po1jt1BvsKNyoJeKucEhe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837018; c=relaxed/simple;
	bh=UfNxYuYPuvftEleii5P4hUKhWnj5JiU0L99+0pmqsdo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dKEfhDSS0FuyLqHYBpRLpwtz9Pi6kxQglCO+YnFla1S9VRuV5erTN0e11m2AmSD9NeX95mNP7k8hJkP1a9TBTm7v3htE6/QkQUiGeOnbqvgm7bzfWKHMIOzt5dYedZZ4waFcdv2UNqtXfV4i+XFv+gCZWwWbEkIlZt35Zh8p/Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lgeDTD1n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cpHPFG95; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N4Ui2I173505;
	Mon, 23 Feb 2026 08:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XxWNElsp4Qmm3JQTHRcfD4tCbAmEY5mgWmx7OIzvCMk=; b=
	lgeDTD1nXGg51WM1Co2EQ+eCvvlIB8WJ9eREWgPk65I4FJOJ/hBHcw918GANkvhY
	Wm/h/8u2Ir5bfjpBdqrubRdMhAshdY5Hw1QCor1QpT193vd11sYYHliDCDH0EID8
	hh4e7ILQUtnfBu/WnB/d/gQV+dKk/IcBRnrH/Bop/98v8aCSyj5VTor/JxtLNvy9
	s+KX9vSo5EA9RGn3D99eevI66ENzBivao8UBM8DtC5V0eOJgBbl+MWV1NECvUjgf
	TkW6JFS+nkL2sZC2sWJxf9uPeyZcCTyBIx62ZzeBbaMc7ebQeQkyTuhir/kSbKt+
	lbTO66GYC95WvFqtjuxkcA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3a01r88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 08:56:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61N6ogb1015577;
	Mon, 23 Feb 2026 08:56:54 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf358bvg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 08:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3Lh03DZ5xLbyNe0asrpjjn+BUYZvc4t08JhQoM3EeFaOZR1aeIix0LCmZDIqOZfswkGE0uFZe6FqTC1huqRlLaUogp1B4zpmAwJscUj672fDILVjd1uhXI5qFOIpostX6SRY5SdCh0ACIrJ+wOPJiZu4ZNypbPWMTP1gSmojZl3UxAKKZCECCc6fd+VUymRe4/8wOxu1Mf0Of3HJI3JP8eYLdSGyE1TljBQbppGQqIqFcIwETIqUAyB7qLVDuIVot2ru/azYY5QqfpynYIKYIKltxSCfF0aG1n5+gs2JNdXx4y5crOFoVbHjVJa4AC/yfCkhTNAeY+fw9STCetCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxWNElsp4Qmm3JQTHRcfD4tCbAmEY5mgWmx7OIzvCMk=;
 b=Etnb+30T/6d7Qvfi6a/aZKH0eSi9je18D6XBKH8o+Tt16x6lkg9BxP8NUYsqOlBcrnA4zVv9bFmwyFtL03gVuvXPFN+nrvr2z6GDIH6yGY7zoFSvHayy/aYeQVUk5/IzDN5CsDOD/MKfcfy1EkEJ6mDpCY28hDiskwhYiOxcI6b1t/8xD0+T1rpNPSq7yrkbfU+2a0h2hb9tqNWHVns6kMHCSmAtjRbWAXcizhMk+/DyU36P3PEOIj4rN2B/ki1hT6/wkJtUCYIxxf4mspZ5iRF8MqwNgDJmAhZLJGWRvzlc1U82aPqcM/NHdzTI84uLeQPo7kyvbvddPMw4Iks5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxWNElsp4Qmm3JQTHRcfD4tCbAmEY5mgWmx7OIzvCMk=;
 b=cpHPFG95HLNmC9ebpqswtP/sk/sTKVYyXXpQtFbtuWm2JvMnh1dv428GE6cA+UP/jdIvtfHa72/Lui+8QfDrll1oyDJ8JmSs0ZkmIU6vSdKr8VqXgQHD8ZtR336oGstdedz7Hg/gNx2y26HZn1BjbPRpxQs46mpweg0Qq3ywGSk=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Mon, 23 Feb
 2026 08:56:52 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 08:56:52 +0000
Message-ID: <ce957e8c-a73c-4259-a040-a1679e9caad6@oracle.com>
Date: Mon, 23 Feb 2026 14:26:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: backport fix for NULL deref in scsi_queue_rq to
 5.10.y
To: Khemissi Mohammed el Amine <aminekhemissi61@gmail.com>,
        stable@vger.kernel.org
References: <20260223074357.7507-1-aminekhemissi61@gmail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260223074357.7507-1-aminekhemissi61@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::14) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|BN0PR10MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 524513ee-15ef-4025-f8f8-08de72b97149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE5jTHhOcTdKZDVBMkExSFhRTTlESmFPNUR2MVVGWjFKYVhwS2x5cmlpYmNV?=
 =?utf-8?B?N1hobmJmVDQ2aVdGQUpVTGh0OW4wT0ptNWx6clhMSHUxNk9JWHJLUG9jelFs?=
 =?utf-8?B?NHdLTHVSMU9RTmh5WjY2ejZTZFVOM3E5b0pYZmFKaDhoVy9WaWFRN0RFS1Yv?=
 =?utf-8?B?UHVORjBaL3Bra2RxcUt2Y1N1ek9SQXNUYVdDYkJoUXFDVGo2T2FsWXlCOHQz?=
 =?utf-8?B?ZHEvOUp6U21kaWV2RUUyZzZ1cms0Y1NEQllTVjZ6akJCcUZmNUJOdStPREJu?=
 =?utf-8?B?aUJwS2dSQnVsQVA4c1M3TEdBbHV3cit5WDFDYXA0SnRxSlh0RXpaa2d6aVNO?=
 =?utf-8?B?S3Y2ZTFwTDRhRVNsZDRRMHphYWxQWFY0Y2JhV25GVGFYa3UxcENEOGduODYr?=
 =?utf-8?B?RFY1UUlObXBUS2dzUCtYL2NBNVRiUEVSYUx3MGZMSDY2U0lDdHdBSkhJVEw0?=
 =?utf-8?B?SkYxM1Y5SnpYczJta3JYOHZPSXZadGsxdDBUaldwRkR2RHNDeDhteUhkT0l5?=
 =?utf-8?B?dXpWSmR6TWU5eWdKWDdOTllwU1VoODR1SVRCYm9xNkc0RE5RbmhDVmxSdU9s?=
 =?utf-8?B?b2NvMnRFNE9BUjdzRk9YWUI5dXYvLzVNZm1waml1UXc5T2JHZ2FJS25jZys4?=
 =?utf-8?B?RmJyZWNoK2NLMlJ1Q25nelZYZEY4bG9aK3lpeXcxNlREWEdnaG1NZDZjWDdy?=
 =?utf-8?B?TWRpYzRMUERxbmhGOE1meDdRUlhrTVZvTlR5UlU0Yk5CNDZLM2VKTThjRFBp?=
 =?utf-8?B?cVpmcHl4cE92T2FObk15VE1XdGQ3TjZRS1AzRnpHVE9la3NUZEVyemdtL0g4?=
 =?utf-8?B?amV2YTlIWFpBZ05Ld09pUlQ1RUZIMW9MSWhnYVlCZ2dNY254Vi90V0V2ajZV?=
 =?utf-8?B?SEk4SncybDVIWTlaZVFPRDRtQ2RDMU9RZ1R4TXNndy9JeU9SYUdxVFZSOHIw?=
 =?utf-8?B?ek8wNEFaQUtUNzUvRTc5aDlPS1BFR3VvQ0tYNUVIZkQrYzFNcHNaWDI0TFMw?=
 =?utf-8?B?UmZYVFhCNUZkM1lBa1VBcm8xYVAva2o5dGlIZU1XSHZqa1c1Y0Y1YktLMmxq?=
 =?utf-8?B?MkFxUTBTdmQ0dElJNGJrZUs0ZDZ2VjlPc2tSeWo1ci90YWs4UDdaYkg1dy9Z?=
 =?utf-8?B?S0tmUnp6V1ozSHVwdmZZcGxURElNMGsrZzF2eXhJRGFoOCtvNldzSm5xTXpG?=
 =?utf-8?B?S2VCbFlRTXh4ZG5ZVnNFSDhwVzZhK0N0N3JmUmIyaEc3eDNtcHZHTmVqQkJa?=
 =?utf-8?B?Rm1KSFFCZ2dtTHViY1N3ZGR0UHJYd21PN3ZZMU9ESklBWVVMQWZIaEM4SUxR?=
 =?utf-8?B?UTNRWFhKMitEc1hCNXFYVVFrMllqMW9RUXZSSXczWnJWMDVZQ1JqTlNOVXZG?=
 =?utf-8?B?OFN4a2t4REZhY0NFdmVyNkN1R1hiYmM4RVBmanRsZ2tLcXAzeUhiaTE1RURj?=
 =?utf-8?B?TWFrY3NRWkJoQ1RMWTRYV01GVndhZEJJeVlPU3IxaUFrTVA3MU1yeDlQQXJZ?=
 =?utf-8?B?NGZRdXhmV3MxR3F0YXNXVG9tZGxEd3VRRGRCbHhjVXk1RERjbVltWWJMWU10?=
 =?utf-8?B?Qk1xZFdQbU1FVlZ0aFByWTF6VytVRXRvYm9ScWxqTGk3S3NKOXVHcm5JVWJk?=
 =?utf-8?B?bDFXSmtZRzBhMTl5R01ubG5pK3QybktXWVVwQzMwRHo4b251UVlmYXNmSVpo?=
 =?utf-8?B?ZEh4d0NPcHlGaTBXb2trMXFpVlNIUTJJa0NxejdYQWpXaDZkcnFrVFZFdm5u?=
 =?utf-8?B?RWFIUTF1YkczU1k3T2ZxVXFDOTh5QldlTGg3UjByQnpZZEFWUzQ2aEtpakRF?=
 =?utf-8?B?bXFmaUpQaUtsaml0SWE5bmhJeVJYNE1ZdW82SWtmSFpRTStvZmJENXczSmph?=
 =?utf-8?B?SXoyZXk3WEdHelFiUEl2bnEyMXp5SUYyekhZd1Q5QkRyTEpSZGwwd3MzTGtW?=
 =?utf-8?B?WDNpL3BtMFpZUVVUV0MzVVEzWlRpSGNRTDVBRm5Fem5LeVBFa0NqZUNWYkl0?=
 =?utf-8?B?bFhFblFmQS9tcDhhazlQc1QwSUU0TGltSVhld0xhNi9xUkFkaVdBMkttRSt0?=
 =?utf-8?B?cGtJeWl5a2RQRlBNNFlpV1FjTUcyeG1CYkJkemlRK25wVjdnSlgwMy9uN1c4?=
 =?utf-8?Q?WV9QlzUvndW5aGD8iVk97JENb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjd4NzVuZzl1MmcwZnhMNEk2alBqVmdTaTliUkcvR3F3WGNBRFNyQkpTSlZl?=
 =?utf-8?B?ajdKdHJJRGhlZ0hxamhTRVFhSUU4MktiVk9IQVg2bHhoNld3dkNoemFzL2hl?=
 =?utf-8?B?Q01tOGxOVVZjL0NPU21uaEJ4YWJEc3lteCtMRHBtaEpnMUZYV25JTzQ4U2pC?=
 =?utf-8?B?aEJvMkZpM0NmcDFvK0JUK3BIT2x4MjVsRS9kUkJSbXk2OE54cmRJOEgvdGFr?=
 =?utf-8?B?d3crb1VzK2VVUERHV2dpQjA1ZnVLVWxVejJPQ1ZEZzJqTFFlWlp2Nk13dHdx?=
 =?utf-8?B?UkZCNlBhWkZiTDRjeG5UV3FMdE5Cc3ZRSTJLOVRLWCtoR054RFJNelIvT0U3?=
 =?utf-8?B?RFdUL3NOYmgzMFFVd3JHMDc4RlZHQmFCVHBSYzBienZRRE8wWnQrOTJEWFJG?=
 =?utf-8?B?TjIzckc2VmwyVjVCNHAxV2diSk1qVFVWeEVUQWxyQVh0N2xodGR5Qmx2UFhE?=
 =?utf-8?B?QXFGYzZqUnJvVkp1aGpVTGdKN29IdmZLMWFPc2dxQkNiTkVPYUVTSmZrMTly?=
 =?utf-8?B?TDlUc25PZk1uNlBYWXY0cE9lbHQxcjdXZlhQd2xSeGUrdjQ5b210dFVFTUVO?=
 =?utf-8?B?QU5iVnliTUNacEpSNkZZZWpoRzlZZGN6WVhGQXhVaDgrYlh6Wm1YOEd0V1E0?=
 =?utf-8?B?RFpOSmloSDgxMWFBZVVKcEo2WnJ3UDdRNkozeE1ZcSsxNmd3OE5CUlRmcTFV?=
 =?utf-8?B?c0tqWlhhQVN5OUJRUkdYVFJ2TVQ2cDhDNDA1ZjRuVlRXQ3d0cWo0RmhsSVhw?=
 =?utf-8?B?RDRhMHVFbUU4eFMrNnhyZVl3b0xnRW04UjdNVExFRUdTOHI3ek5wWVF1eDN1?=
 =?utf-8?B?WStGQjdua1NaZk1YZ20zQ0dRWFQ2bGpQNElqbDN0NitmU1JpUTVpek54ZkdD?=
 =?utf-8?B?a0drZlNWK2U4b2g2a05QTTJRWmc4Y202U2oxb2tOMCtJL2tsZXV6OGt3c2s4?=
 =?utf-8?B?MTlFS0lBd0JrVFNJTTk3c1BidnVMLzltOTVqSmZaU2VOenE4MU0vaXhndXly?=
 =?utf-8?B?eDM3SXJxakMzRmNWdG9CekN5WjRzek91NUFTZEw3UStMeGVrOC9VZU1NYUlP?=
 =?utf-8?B?QWhzenUzR0M1K0hwRndLZVQ3TzRmdkUyd1BicHNSRWZsdVAxZXoybDN2RGEr?=
 =?utf-8?B?bVlOREpDMlVpa1hvaUF2djMrdzRnVDBtK2gwc20xa3hIMHBkTkNFejFRS0xP?=
 =?utf-8?B?cVhmL0kvUWcwR2ZIamFlRzN3bmtENjZ1b1UyY2xPdStXZWRTcWk5Wlp2QjI5?=
 =?utf-8?B?LytCd0dub2N4TFQ4emVKY2k5TmdmaXArSHZaZyt4am52TmVybWZXc2FwblUr?=
 =?utf-8?B?UTZUSGUrVFZJdU14OWZGY2xMQ1RYR2o0ZWNLdWRqd0J4RkE2a08xWDluMVAw?=
 =?utf-8?B?WmRsaGY0a2MrSUNzWE92bDFjbFNJbnJqT0paS3p4Q3k4ODVWQXRrN0lFdDZZ?=
 =?utf-8?B?Q2UxRVpOV2R5cjI0aC9qMnBxWHR3cW1nV3ErUTVsOHE2SE9qME40TVo0Mjdw?=
 =?utf-8?B?ZG9zRnRLVnByUmovZDBwU1AxVThvZFhpZGxnYVFlV1RRUGN0V1Y4NmY3WVlS?=
 =?utf-8?B?TFZMU2dEQllMaFczVWJNS2ZOOHJkb3FsN0VYelh2dVVXQTFOaFYzU0hoSFJv?=
 =?utf-8?B?RGl0Tkllbkx4Sk4vNnZFZGovTVhrbzk3R3RKR29wYy83NytQY2NDeXJ2TkFa?=
 =?utf-8?B?eVJOQkw0L3NJNXpNVmxCVGJZRmM4T3N5N0x4Vzhyakp2NVc3SWFIem44TGhi?=
 =?utf-8?B?dDdXZ2djS2RrcjFERW9HMTB4dUlaTXpIK3NGVUFHTDRLUUhveWxGcTluM29U?=
 =?utf-8?B?VzRIN2dvTHlqQWZ3R09KczFJeVcycXZSN3pZU21aWS9GcjhuUlJDYWpxRk1G?=
 =?utf-8?B?a0xBay9EZjcvdm9qdE1xOHNpZVcwSVlxNmk1TXJSblE4aHB1QktOdzBtdmpv?=
 =?utf-8?B?UWwySno1NWxTbkljejFQL0R5NU1jMkpzS2RwcXlGWGwwRkpRZHcrcUxmanow?=
 =?utf-8?B?dzd1QUNZbDhlU3E4c1d4c0RGZFUyRWdibndIcGptWmxORDNKSnZwcUNrZm5W?=
 =?utf-8?B?Rm9kbUpjK0RTdVhsejVSZEVZUTQ1b0E4MEI1ZkZGSkVMbGdxWi9aYkFwV0Nu?=
 =?utf-8?B?ajNXVHJSMUM3NTloQm0xQ1dsOUFkazhpRTZ0cEptSlNnaVRhL1o4clhvRnls?=
 =?utf-8?B?ZVZnMnBrbnJEQWZLK2pSZjhEODQyQTVVZXV1NlJpejU5YWE4Z1MrenEyUHho?=
 =?utf-8?B?VjZzb1pka0pBZjBXUnBjbGd0Z3c0L3VnZGZBQXdrMDIxQjNVQlRuWTJ4V3BB?=
 =?utf-8?B?Y29vYzNtdUpOS1pxTWRBdTZZR1ZnaTZvbTVjOGRWUE9RSzllWDBVWkN0R2s1?=
 =?utf-8?Q?Htyhh43kKfPd41tiC7QJF6PA8ZikZk83cOSqD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B6wkZ9RGBfokiBqvzZaN9FWKxQn2DPwjSusuTvpK4hVPywX1+UMPjnIXuD7qD1FCXs66+a3aydET4w9rF/tvDpi25/gtByFuZTvJz04xmz/lLENVbhYuJt8l0o4AdmorCkcHzSQig+XzUTRIPcWAhXpyxH4sQJP1dYq9ZehzWpaNZsxtAdvLqJvYqpNZYVVS6xjaanw7xNT9N28fXYoxCw95uOglCjJnO75CUCr+RTepT7gXwC0QgbOr8Fwh0tev8rqHKereEnPC91JoItYE3iiL4cWVwpO+0D5CLqxNfRrAb0yaXlRHzf9FnxHbZlBpErDWVrniAwWc8bZkNND0H5ynIiSh4rfOfIPZOP0AUURg/ZRaZKNvYnOKin6uhfug7lKO/xwRTVb7ZmDhh8wKzoo9rJ2mlkUeD8RFe2n9pqCN0jOIxtDuAX4Inhbzr+OpleUtB3yccTgYbYtbvoeq2IOLPidMwL4A+c1QXc8NyHUvBBGTErQPN3vR+sAfW5iDP+UYINxB5fK/HxsY8UzOfKwN3ZVjRPNqFlB8DQrZfm65ytPoIypA+sOOhCju2FRSd8i1YL0FcveWRHs9bV4qgEBH8yaM2eaoavkO/xCIUhI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524513ee-15ef-4025-f8f8-08de72b97149
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 08:56:32.9951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XredDoXMe/XqinaC15EoeFvVwyuOF0cEsP7mgqWne+7EV5Lem7xDqLPfMceWP4cVXTFWdcy2THYFLwnlAeSU+FJi4ME4z9gL1bonTILds9l5+Wy5mjZks4q5aLHk+QnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=992 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602230079
X-Authority-Analysis: v=2.4 cv=IskTsb/g c=1 sm=1 tr=0 ts=699c1657 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=vsD3YDzrLr-bJOWX2g4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WmXdzMoh5_8Sg8bJihhyX_iDsG85eQLC
X-Proofpoint-GUID: WmXdzMoh5_8Sg8bJihhyX_iDsG85eQLC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA3OSBTYWx0ZWRfX5fBpC07p0VBj
 4WBehlFIZBv/4urjbJOa6/lw0mweqEuBMlh0rW88+Nj9v7wKEMqKyvk8fmSYnVAk0ybhWnaeN/V
 1M2dVKAQcM5odoyzpQOdF55+2T23i3JIZ0EARnarRqxMUZ8rwG+MDaXxKYPPZjgj7EfFquHNo4K
 8V6IL/IVEF81sDYUePZFF0sPRNPgdWOjCZ3w4d8G6dc5LGs/QM/TkUuIZo4D60A+L8qLxVRW0Jj
 WqmVVlDHAGuqCZdSp879/TRdvWUHnBprarNzgHqByznbdRduNDQcNu44CyjUb1WGEqvFjMElzdd
 IpNPbQVKRpvkBR9mglmgzaHsT9l4eU4/IUdjUyzxZ6MXoJaKQ9rWMEh+fffRKVJvtMbKVoGbkiU
 R/pjL24zB1ZwVYT4r50+PINllBTDq+mj+V8sjRNFbpgcDZuoFufouf5o3jl0z5rXbGttOxsoStC
 uYvXYiMnRbR9BajyTrg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217711-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7D6EE17358C
X-Rspamd-Action: no action

Hi Khemessi,

On 23/02/26 13:13, Khemissi Mohammed el Amine wrote:
> This backports upstream commits 35fe6fa57b99 and 6ca9818d1624 to 5.10 LTS.
> 
Note: the upstream commit is 6ca9818d1624e136a76ae8faedb6b6c95ca66903 
the first one(35fe6fa57b99) is just a stable backport to 6.3.y branch, 
so saying backport upstream commits A and B when A and B are same might 
mislead a bit.


> The original fix prevents a NULL pointer dereference in scsi_queue_rq()
> when a BSG ioctl is issued with a zero-length request and a NULL cmnd
> pointer. Without this fix, a local user with access to /dev/bsg/* can
> trigger a kernel panic.
> 
> The crash occurs in scsi_command_size() when it dereferences a NULL
> cmnd pointer. This was confirmed on kernel 5.10.0+ with a 100%
> reproducible exploit.
> 
> CVE-2021-47552
> 

1. This is not upstream commit message, alwyas use cherry-pick -x and 
document [ Upstream commit 6ca9818d1624e136a76ae8faedb6b6c95ca66903 ] in 
the first line of commit message, don't alter the upstream commit 
message, append the commit message with SOB at the bottom:

something like this: 
https://lore.kernel.org/stable/20260219101318.2442406-7-harshit.m.mogalapalli@oracle.com/T/#u

2. Documentation can be found here:
https://www.kernel.org/doc/html/v6.18/process/stable-kernel-rules.html
^^ Check Option 1/2/3


3. Also, neither of the commits you listed do the same thing that I can 
see in the below diff.

4. Also the CVE listed above doesn't seem to be related to the commits 
you listed above, can you please double check ?


Thanks,
Harshit
> Signed-off-by: Khemissi Mohammed el Amine <aminekhemissi61@gmail.com>
> ---
>   drivers/scsi/scsi_lib.c    | 6 ++++++
>   include/scsi/scsi_common.h | 2 ++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 03c6d0620..4e86bfd3e 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1174,6 +1174,12 @@ static blk_status_t scsi_setup_scsi_cmnd(struct scsi_device *sdev,
>   {
>   	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
>   
> +	/* Check for NULL command pointer */
> +	if (!cmd->cmnd) {
> +		scsi_req(req)->result = DID_NO_CONNECT << 16;
> +		return BLK_STS_IOERR;
> +	}
> +
>   	/*
>   	 * Passthrough requests may transfer data, in which case they must
>   	 * a bio attached to them.  Or they might contain a SCSI command
> diff --git a/include/scsi/scsi_common.h b/include/scsi/scsi_common.h
> index 5b567b43e..1d9dcadb3 100644
> --- a/include/scsi/scsi_common.h
> +++ b/include/scsi/scsi_common.h
> @@ -21,6 +21,8 @@ extern const unsigned char scsi_command_size_tbl[8];
>   static inline unsigned
>   scsi_command_size(const unsigned char *cmnd)
>   {
> +	if (!cmnd)
> +		return 0;
>   	return (cmnd[0] == VARIABLE_LENGTH_CMD) ?
>   		scsi_varlen_cdb_length(cmnd) : COMMAND_SIZE(cmnd[0]);
>   }


