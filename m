Return-Path: <stable+bounces-93563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB79CF0FF
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 17:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFEF1F245DE
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 16:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EAD1CEADB;
	Fri, 15 Nov 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nbo5oFvA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w/f0dvKu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77113184523
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 16:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686746; cv=fail; b=SRYo/O50AVDQ1leVwAAG4wPCt25/41/8NT1tQod3WSlEUmqjxfN1BVTWk5IRDLv4Om66jFpIe9sr3UuIMmwzUS1WFCD/ssY9/Ckgg0rOzwc7oAeWULUpiVdrS2g4P7TL03qKe8f5N67Y1DoO8k73CZNMF8FDDsKICO5zAA4Cktw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686746; c=relaxed/simple;
	bh=odfRedbdDy6d6fqqU9l+WozXKaOwUsILx5MFj3VzUrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PIe87s777J64DshUFthdPPjDlwn8seBpHO9dOqXBibPtngR6lfMzTYgRhJ8xm/Vv/a24EFEXnQavHyYhO9+xezblvn6wHXN0sn6N7TfKBS9KglXUYN5SE8ZZ3qy5/mhHj65/T1Jyzz5XYrw6eICkzK/7dFrDrIjj490QtxSSM54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nbo5oFvA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w/f0dvKu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCS2c020915;
	Fri, 15 Nov 2024 16:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zM27zFPS5dpEzI5DGC8no6VBkWSTfAWzt4Ku7ICPKIM=; b=
	nbo5oFvAA2CyCSEnmDEQ+hYIVriiyVXa0p1HiGXrl/lKlgohJN83uUUqBVQKpAiB
	XHPisIo9CepJRjHyFVx+IfS5d2UhFe6LUrlB0iQ3Lda4O6nwL6iF9O2AAOYeA16V
	HfbqEqbWOcMCDsXpV3WnKxrCjIFpvPTZJk2lrilFh/ds3Sekyiodb+ZWk68rQvfW
	vmof2FXvJlfN8EAv7JwVwxem6LxY44Qq7yRU6XqH2erMembozhH9SQPYfIJ8gMUI
	4xQ8yPnhVqm2cYhrc+1ZjcetkRZ81oZx7R64pH00r4XR5JsEYJkQvXd92tPLNGVG
	eip/Zhb2btVWLxb9us38Eg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc3t0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 16:05:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFFNOmZ023918;
	Fri, 15 Nov 2024 16:05:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2utwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 16:05:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHyY7ulXEFT63p11zuCW/8CT5MupNoh22w7mBuSUhc5gdAzmwr2+lx7d2Ag7WQDVSRxoiA82ZrQjZxuGvHg7R/7VQknxdVspN5dNOYVBmOIPmYSGYUh/QxZJpWO/Gtw5jZKX75swpBfv4GCr1wMEaIjDszTmi3Xuoz4q7a8YIRB6bFv/scJnQ90+F5WQEqchRDPFlo4MgrG8QVowMP+f4Ik5CYvHaOBMTJJYXJFDvRTLvyb+aliAwo3/rbWLzUSUzFBNILaK8D0rREDoQt2Z1fMrOcLIiyaenMrGG7qC/IClO4GtenKjOkd6ad9kh7PEhKkZ4+Rnml5GzJJiT7mV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM27zFPS5dpEzI5DGC8no6VBkWSTfAWzt4Ku7ICPKIM=;
 b=ExxkkgC+7sheRP6M+zfsPnO2erMdF7qP1GTj2C5CzGrn6568OZvou1i2YJZ4JkZJTAD3Su9guemLjQ1hqewariRXFWtdycQoAPuykmbU7eTmr4rvwkzr1nIzaEOWAQJfrQ2nAw4pSQaFmqv4YbD1RTYeYjAUU1cP/JP89Df88vLMQUHgEtYCIz3QvK55hGgSIqSVH4mK9jh56jH0yIziDrYHokmXSg+0TCY9LLhPmu+p9Z+aF0Z8HZhpX2UUMvhbSfqbYR8Hj0nXBk6kfC5sD1AqGSJDjnGuEl33QxVQ3jnE3bLXk3LJrm1H1QwotnXYG/awafCiraycNrUpjuPwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM27zFPS5dpEzI5DGC8no6VBkWSTfAWzt4Ku7ICPKIM=;
 b=w/f0dvKuHAm58TD+dhZ5E3shO5C7YncAI2l7pVrzhsSR8SpguXa2FDSsuxafE/p/aIlGQR+T703jyOI+Imd6DTxIsNqJpv6h9uFPgKfEk1+oi9w+Ms46v5C2pgmXKPoh9QzpfmKqw7YbUIN8wDwGz33/ODE5AhHdTgG/I+eQaHc=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by DS0PR10MB6055.namprd10.prod.outlook.com (2603:10b6:8:cc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 16:05:35 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 16:05:35 +0000
Message-ID: <1729ae61-ca8a-4230-9ec2-493041761f91@oracle.com>
Date: Fri, 15 Nov 2024 21:35:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: mmc: core: add devm_mmc_alloc_host (5.10.y)
To: Dan Carpenter <dan.carpenter@linaro.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
References: <b5016bde-5d0a-428d-9136-cbbc15f2d70f@stanley.mountain>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <b5016bde-5d0a-428d-9136-cbbc15f2d70f@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20)
 To DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|DS0PR10MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: 30851c33-d10d-4d82-230e-08dd058f56ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG1KTlpvSHd2TVlQRkVFWG5Zbm96WkZqemtPOEk2V2syRUdSNFpHc3NWeDJq?=
 =?utf-8?B?K0s3czhUZlRET3ZoampuS3BHcjFpL0ptMGxKTEJUWE9neFZZekZEVlhMNENF?=
 =?utf-8?B?MTBTYk4rdkVNZTA2aVdQdDlaOG5jQUhKOG5SbFhTK2dvVHFnaTM0dDhhdkhH?=
 =?utf-8?B?bVF2bVpsWkN2ZmMzRlpqM3I3VVQvakdMQ1hPWmIzcHlwZ0tDK3pKRjVYbW5U?=
 =?utf-8?B?NlBpdWRQSXZsMVBxRU1zSDNOVG83bzhXdzdJdFEzL3o5bjNjeGlSMEpTaGhS?=
 =?utf-8?B?cFlCNzN2S1V1SEJCVFFMZkhPWjBaZmJnblNvU3g4TDBVT21OTlNrQTdJL0FG?=
 =?utf-8?B?V0I3NXpiV1NQS1dOaTQ1a1FLTE50UGpYc0s5YnFmVW9zSTVweUhQSG9pVW9K?=
 =?utf-8?B?NWsyNU1sYjErTjRIbWFJUDJIakZaZ0xYUExyTHpGcFpjOHY5cDNVZk15SnJz?=
 =?utf-8?B?NitmQVhjY2x4d0NIVHAvUVZzSXBTSTR6RWU0Nk5JUm8wRjQ2R2NsQVNZS1Rj?=
 =?utf-8?B?U1FBQ2JycitIRnYxS0JneEU0VjVuV0pZSkh1QVJtbDBTbXVibmsvM1lOUDl0?=
 =?utf-8?B?b1RvMk11aVJDS0FRelhhUjl5OUw0VVMrMGNNYy9xWFFGdnVYUTJWcFI4SUhh?=
 =?utf-8?B?YTVWbUJkSkZpRTZvSjZsUXlOMEcxbTUxcVZGV1BhL2NGWkNHSFBRZm9XSHd1?=
 =?utf-8?B?cG1uTk5mb3RyemlaY3VhNUpmR0dZQkw5bDBYLzVEaG5FZE5GbnNHcEJDYU9t?=
 =?utf-8?B?Y0F3V3hoWGcxZ2dOZWtjTng1SDk0NUZwbmg3V3Y2WVFSdmZoSkt1dG9YbU05?=
 =?utf-8?B?cHFFc093WG55TWNhUFpsZUhYNjJZQTdrTk5nM2dFZ1I4dWhrT2RDVGp1a3dh?=
 =?utf-8?B?L3JBKyswcFg5cXhrYmIwS3N3YXpXNFMvV0RHUkprbDB4RGNwRGFnVGhFSEpD?=
 =?utf-8?B?RHEwdXVGaTRuTFkxT1NiUnh6aExEWmd3aCtLZDRVSW1ZQzMzY2dKWmU0Tmw5?=
 =?utf-8?B?eFMyb1hZei9hRTdiVDhLSFJyV3UxaWhUM043eUFIYkxkUVIvSTBzaU16TUhs?=
 =?utf-8?B?SzJjRU45Y2t2RGY1LzRXT3Iwd0QycVJNeFhFWmlwd0RmMUxtdUNrcktmZkRL?=
 =?utf-8?B?bkM2OHdsU3NyRjgwYVRsUUd1anlKcjFGdkpYRDdIZVMzWVFhQXh4OFdnckFX?=
 =?utf-8?B?RDIzTGQ0bVRqWCtKMFFQVVhZdXdFSFFvTVZMWDhOMUxESzBFQ1JRbkY3MElP?=
 =?utf-8?B?b05IV1ozU05pTEdmVDYrVWc4NFJXWEk3RVpIZ0VGY1hjL1k3b3pHOUVJYWR0?=
 =?utf-8?B?MlhCK3pZVVhaQUprbHdmNlJhTGNNendSV1dkS0Y1eXRSRmNrc3N4QWZSc1Fk?=
 =?utf-8?B?NzdCazkraHc0MHlIbnZnb0hOTmJ5ejIybmphTmx5TkFUWENGQTc2ZlQ5QzYz?=
 =?utf-8?B?NVJzMTdnS3Vjd1l6YVhzV0tVMnhrM1BHZDBmVWFkdmcwekVVTkp6RTZ0alls?=
 =?utf-8?B?cW45VmJ2ZWNXdTY4TDFUalFBU2kvTldWU1lFOEFKOWFnQVpJQ3JDZ0xQSDZk?=
 =?utf-8?B?VlpXUlh3Z1QrL1dsM0hXdldmcHdlWmFNM2hGZGsxZnRiejVEVnNXSll0blNT?=
 =?utf-8?B?QlVOcHBuMUxxZ0RQUXh6OUNNOEc5MTd1bjRIZVNTOXl3Z1JTTDRObWpUVUJz?=
 =?utf-8?B?RW5hNUhIMVNjb1BxSDlwWGJJMnNpd2lGeUZZTnVIYm4wTUppSjdFOGxUblFQ?=
 =?utf-8?Q?r/4FgAp7mK/yi7puQr1bDGO7Q6QF+KWLc21cZUM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk1tamtQcFpwcWtDekhLenFNRWZIczZEMlA1UmU0dTZxWlFGUVZkUWdNK3pm?=
 =?utf-8?B?eitQOEF6SGhBelhSQmRUMVlyVlVpWVJzdDBMaHoyUkE2dUQzcWVsc1hhSEpn?=
 =?utf-8?B?OGNmRnRDUjB6Tmh5amJaYjFJUFI0R05ZVGJBbWlSdDZYTElPZGNCRXRaTnhi?=
 =?utf-8?B?REVIaEl1QVdUL0trYWlOS2NWMnl0UC94cUdCRTlEalBwRk5Ua2g4bWRHTWtn?=
 =?utf-8?B?eE4yY2ZBT09INXI4RERKQy9oK0xVOFU0MDBub3NNQ0YxekxYNms0b0R5L1Mr?=
 =?utf-8?B?amszM0UwRkFIVDJZVDdLbm9uVDdjbFJ0WGppUFFrMXlvNWs4MjY2WTV1MDZn?=
 =?utf-8?B?ME5nWFh6UGZTZE9PY1NtRFdyNGFLM05hMHJuU1FMMmE4aDlMY2ZPaERkV3M3?=
 =?utf-8?B?OHlXeXQ5UWQ0Q081UmpSanBwenVLSTNaamRlb3BRbTd0TnpJbTQ1VWY2ekhw?=
 =?utf-8?B?eGMzNFBBY3Bta0swbGptQlo3bDYwbXM1R0ZnWHlkaGR2YS9YR0xpeEhEY0U4?=
 =?utf-8?B?di9XWG9SMFYyd2JWbW9GWDRoOG9wdHRZb0xGcTlrZWV1eXUrVFc1U3YxM2lo?=
 =?utf-8?B?T0VjUXcxK0F6US9Wc3lyaitrV1hmTGlTODlpOE50Z1N4cHByNzhrRzVaQXJR?=
 =?utf-8?B?dHVoUWx4YXRiMFVwTTRZRFZtZVJFWHdZbU16UmV1OHZmYXpFV0QrRVUranZa?=
 =?utf-8?B?UWdET3RSb1BnL0FtdWVMYVVsZENzaVBuU2RybE9uOEM3b012cXYyUWNZaHlC?=
 =?utf-8?B?OEpNVm01d05iRUxpdGdFWk9UZll0UC9BQUlHb2g2cTBqeWVYaTg1Qmkwc1VP?=
 =?utf-8?B?V2JlUnBmQWRORjg5cVQ2NnByMDVCV2MwcnRueGZLRlpTUlFFZ2ZsTkEvVm9B?=
 =?utf-8?B?UVJlTU84NG9ZWFQ5THRxTTlhc3ZiR2NDT1NDZ0IxeE1tQnhla1dCWUM1WVVt?=
 =?utf-8?B?VTFPQjVTTDlpalV0UTVia1VmWlp6SThVc25jVHR5ZCtrT1dzdjZkVEF6Y29B?=
 =?utf-8?B?MUltbzcramxxeVRIbW9YdzJvb2QxT2lFb0VOR21SV3VQTHhQVTEzZHRSL2ZG?=
 =?utf-8?B?Rmg4Rk9RMTRhMU1VT2xpSSs0UkRCb2U3YmR0WGlRRVo2UlVaZ3c0c1hBV25S?=
 =?utf-8?B?TVNzbVJyQ3U4RGxoa283cVZHMjVPRzJaL3JMc0tsZ2hOL1M3K2VXNEtYK1hV?=
 =?utf-8?B?L3oxY1F5QmR3ZFJDMVhLK3JNRjgvK2ZMeW9nYlIvYUJhUDJ1VnNSdUpOYkxB?=
 =?utf-8?B?WlZuV2FTTitXM2xuKzkrQ0NWWlJOcTg5UVJzZitRUlRRYUgwSExjOEV4TGpF?=
 =?utf-8?B?bmFLbHpyTjQzUHJ1RFgvNXdiYXh4cDM2M0hNSVZJNm1wZHNENlRrUXgyWGk1?=
 =?utf-8?B?dSswTFcwOFNELysrSjFzMS9FUm1GMWJOdkhRNDV0Y2pwWXpOQzhqUTFiY21Y?=
 =?utf-8?B?Z1hMOEtiTWJxaG1lNSt2dnFZdy9iSk04RjVlcHZQTjU3WVE0WFJOUytlZmdZ?=
 =?utf-8?B?L1hmZ0hRUENHWUduUEk0WVdwWG5JWHpBanBFeHc0WUFaUWNFdlV1Zk1GY2tU?=
 =?utf-8?B?MkFLUlJsSDVRQkkrdWtFdUhxL3N0akhDZnlLSGhsRUo5cFZOT1h4QVFCTis5?=
 =?utf-8?B?U1c3Tk9Bc0QrYWpKb3E5NXRybk9ha0NaVSt4M25xSWJVNkZGdWlTeVNuSHU0?=
 =?utf-8?B?bVgvWUgxMjlyYmN1dEhuNitvK1JuclA3T2hpbCtZYlhNci9EQkpIZ09TR2hQ?=
 =?utf-8?B?Sm5jMnJFZUQwK00weE9sRy9tK3ZvR25zVlFrK2NGbDFUUkhuYVcvdExZemlX?=
 =?utf-8?B?NHlTckVLZnBxRTJyckhQbzhnek1VR0Y1aitPenFjQjJSdXora0lLZUpJNlJY?=
 =?utf-8?B?amNaQ3hKd0RFL0djU0U3V2srM2ltZmc3K1Fwd2dPZ3JWQTI4R3AvcTQ5b2Zy?=
 =?utf-8?B?OU5NN2phY0hWTllHdmJQcG1Qcyt0ODRQWXArTHY3Z202K0kxRDNyTjlnelJl?=
 =?utf-8?B?QUtRNlpHamtkUm9ISkF5cVIzb2h0RXRHb3dyUVB2RHh2ZTZ5Sk82RUhtVE5q?=
 =?utf-8?B?VTg2YXdsUE91WmkvMXQ0R1JKQnlqaEZiY1lEOEZBM0FDcHhNb0poVzVzaDVp?=
 =?utf-8?B?TG5ZQnkyT09IbUVUWEVPcmtGY2UzSktsRDZnRVhTWGRncERlMTVmVzV1M1dM?=
 =?utf-8?Q?WCwdik6knsqPRXPnf+R0Tfc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xib0I+06heOTQSlFmY3FnWHemiY0/CzJGj9uMYJVqdG4gMNBucnY0aO/1TIjff/y93gKJ/RnlLsxsXhPqP39vgeFgExamsMTM0rnce/Pn6ZBxKuXdUjITdSSoklhSFDonq0jQ/SFmxAucw6mXrIAdZhpW52xFeLwEfBnWc87/vu0VEjqt+qx0Zj5v/trII7HTMqHqBCVazworxTo1R4FMgajfGBF30OCPUi7Mea/ApoX215iEY7CioM07bhVDoHfV4Kj1wiXrsYY+1hTGX/yUX34+X4j9i2N9ADrvDM2c4TDc4YmgcAWgd4Vo10sMG8kMj1EM2bPCdC3DT5aFaameemxJVlvuzntYb2FFn52GXFZocO1p0rQGHIezyKXagkM+nt4QonS7cA85JikLSRhtqVy95u6t7CBFrW/sxePKcu8/hZTrYCtt33dNGao0+Q0/zHYTid5gKXfvsCIwjkvRsbkaytmu4nZZaZMwzVmfxFFHSlpJ69V2S4FY56pznUzgnGCO5Y4RfDVHGyYeHpDoBXVtTfG5iSAtOaV4jSNpluwk9NwiyKiKhCDW+sCpzTNPCQdiCHgqaojAKaYn2YqgLZcna37fH/LiWMz3+haqLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30851c33-d10d-4d82-230e-08dd058f56ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 16:05:35.6830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J3bqPwa2a81JLAUy8X+qvHT7pq4mc+v5+m8jVp07C3SpOpqjv7aDbnFhq26i8W8JgN7bJEU+iE0x8apBVF3+psnaSlgt0WfkYt2EJsPTcHZh0s6Cxga9q5NmmqbHrxX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_01,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150136
X-Proofpoint-GUID: ImNMwx9EpAJOyV6Wt1Cu1VSLhv_uqs-1
X-Proofpoint-ORIG-GUID: ImNMwx9EpAJOyV6Wt1Cu1VSLhv_uqs-1

Hi Sasha,

On 15/11/24 19:59, Dan Carpenter wrote:
> Hi Sasha,
> 
> The 5.10.y kernel backported commit 80df83c2c57e ("mmc: core:
> add devm_mmc_alloc_host") but not the fix for it.
> 
> 71d04535e853 ("mmc: core: fix return value check in devm_mmc_alloc_host()")
> 
> The 6.6.y kernel was released with both commits so it's not affected and none
> of the other stable trees include the buggy commit so they're not affected
> either.  Only 5.10.y needs to be fixed.
> 

How come we have a commit in 5.10.y and 6.6.y and not in 6.1.y and 
5.15.y -- May be we should detect those.

Thanks,
Harshit
> regards,
> dan carpenter
> 


