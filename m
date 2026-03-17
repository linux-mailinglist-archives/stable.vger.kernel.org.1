Return-Path: <stable+bounces-225774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNTZDx0cuWkyrAEAu9opvQ
	(envelope-from <stable+bounces-225774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:17:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC9B2A6643
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EDA730B0C3C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2FB35A389;
	Tue, 17 Mar 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFdoG7QX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fgFt0FbY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DC35AC12;
	Tue, 17 Mar 2026 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773738757; cv=fail; b=sz13faUrdBmu5HiNPHOnwP9RWCkf0EkxtZUs1xHPnayz+FSb/qe0NK/gHwHniBCBkii1zyBNDp4irQnbOM1DyLngELk9IKP4wHhuizEDQGAI7YA+mmPxDRSUd4y4zSSJ/FUMEtSwwOnLb1bWD1uMqaAvYKREsfgpWdX6R+wLf3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773738757; c=relaxed/simple;
	bh=g6X0ugVqy4PU0zcXYt+umqksVNwGTl2CF36jAVOesZ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VgqTPOoMfe+ZCNi7bhRYWmXh4aA5Q0AmBfaBozamOF4DOjuKMwqwvYWmWBy7AwuBuRKzjcQiwhhQ7ghh+HI3waBXfcDtSVHiMtEn/9L4qYKf1Tc+WbYhC1DnaUn0ikusmLQojS9CpWbvMbgdg5UOvs3ibKuIEc0dFWxXmAa/PGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AFdoG7QX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fgFt0FbY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H6R21u157360;
	Tue, 17 Mar 2026 09:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PNs2uA6O41lRZZHBqDxfc6YIAOTRCwwu1qeZH0kAU4I=; b=
	AFdoG7QX4hExDTh1ULImbXdyDk2l67HTfqiEjw4Ci0nVohhhQtSSzxiZeZslAJVZ
	/XsWOSYOX/TvZT7ADoRhA7Agyrmen1MtM0ffTf+6B9tcIwnrNPuyeF76CC4Oh3FF
	1REgEP9geBxUUG0qqCumzyQtAecV6qVORbT4JAX+91b9UgVPjYkrAN03+VQjcNV2
	xkGJyfopJ4q3vQX/q5lZX7/BYVjXIYetpWkmrN9KwLWadeskcBwXcrSyJKguD8g8
	aYEcw1Hju3CWq09+r/Ml03BvjjRwZ6V2/2qeawzqDJeOwD9lG61tHDhjNqqJS/xP
	vpIcDuioIjaSgPc4xSDcIw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b3qb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 09:12:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62H7FA3v003353;
	Tue, 17 Mar 2026 09:12:06 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx49sku8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 09:12:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnAt6W71kFxnvZblefKXX3Ti0rv+0kL2RoTKnOfdXpdgs5wcAYREff5aOwe5ODUoL4Vxw4M8flyHA0spmkGRXI/dET3GquSIRrHybtevXYt/mIt6+8BqBHGxXd2DcDePkEsonvjbrFP7ME5PON2oVKoCaPWU7wDwfl3QjaioW6c1Fd7JLBCmAAHbhzeXOncwHHmAs4oUK3ClZGE4ZHcv1oOzaTy3fcbE1IhxsVXpLmgzz3xtVpB9I8kAESU2zvxrwNdfltq6yr6G402SHxRI3pI4hT38BUdbl0c3r1ky6862l5oZWEMztcH4B32nG0hr4lit468zVXlyyG/p4ycFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNs2uA6O41lRZZHBqDxfc6YIAOTRCwwu1qeZH0kAU4I=;
 b=h2hETTOSZKIyl6S1+asZWsgea8t8WRS3a9+k3LYhqPTdIZhZexgYFQcwMhqwjfhXwxGgiZQe4vb3AY+tE3mlFjBkcltqRb2j6zR9wvZpy68bmYDTybGw4tQsZMny4I+NFPrlaSt7eu/zbPSuc6bnlsoM+qxi75n5OsYYGOBGy0TaqmbvQZ/QHxgw0lg8CrX5k6y3pp9PDf2uy2tpiq9auyxSZXJo73Zi5YW28G+/y2aPZvN/sbwBVtI3QB39K9TnBYmYFep1vwNhtJ4nBejerGbAZYO08N3DXHjPeVcXRpQWjl9WAxn6hew+GvPNceuHujRxM8RhF9lZP7XSt8Mw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNs2uA6O41lRZZHBqDxfc6YIAOTRCwwu1qeZH0kAU4I=;
 b=fgFt0FbYX+8qRX3qcuHPCGH33X36C3ajNqvF0bfj5h93Lals/NzqAxdTh4T/pLFXTfDmLcsmm8/l8AiEdSkMOjhFooP9Z9Z+lcC526FK1IPqdj80fdRgJx8K3QivCGCog6WBZ4vGq75GrTp8VSSjGf8H/R/sScehZ7vN04QS/TI=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BN0PR10MB5190.namprd10.prod.outlook.com
 (2603:10b6:408:12b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 09:12:02 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 09:12:02 +0000
Message-ID: <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
Date: Tue, 17 Mar 2026 09:11:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] dma: fix dma_opt_mapping_size() returning bogus
 value when no backend hint exists
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me
Cc: robin.murphy@arm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com, ahuang12@lenovo.com,
        iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260316203956.64515-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::22) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BN0PR10MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 238dae8c-ee6a-4a41-82d3-08de84054083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	18QP1flUHJm4pKzM/zHJSf9NaTpTYB/8XPraQ2NqHkpGQpX+KMIAJfBlzGjzo3NhfTyfrWCGt4Lahy0PnAT5KbBLpisP32C8EeCUB7MylMHcXdq8HPx6AnnnSEp+KAlpqBPuVSvXD5rxaS+LoRpWTFd8GYZ3pyB6JmhRO583mKbig8xY42jbrjLtMAmjoqjLD6VRVyc7qUd36vNIzARg7F1T9UAwO/j962vINy9psCfG6j1u/iWtmQHPZ9MyKZXeDJYnYmX1Mc3oW5nBEzub2Iyie7HMrnChx9ZiBZ814QI7vCwBChyqzI6R8OG5GG34G8CDFc+ttQ2Ood+VxFJTuoRWr8gS6Hz1SyJLx83rWfZu/MTs9OuTjwKTMQE68RW/CkriMylU3sMJYYL3WRYWxtAbFlirRrYU5uku/0QWMLtHJQCJwRFAD4YJY3bNXbEku27TSglwUQ782DviIcch/WThVrl0JI+St15R3Qn2a5qpoYdC1+259SIjQjLPQ1G4FN3XHgOukG2LgYIqaHKQzDM29hAX0Wmbs6gMkxzEoKDDdsSdPdxM7a0LtzzdH50lsHP6i6ThyVK5YXySJUHhlKIvFhSMBzvpddqrJqH6/TV8W47vCd6T9BvPCmELxHeyHs7NW/wzTlioijxe+/8yCuR4UchvkrLZ9Ocqh/w75vBb+k+1fC8uXRArtIrtXsvhx4ghjZ6YjoEhtE6apnYUrWrYv5NpsHxlmfaCPb8dMCs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elNrNXU5bnpuZlljN0xOVlJJMjZSbDNXUmRjT2x6ekhlNnhxV1dNL2did1N3?=
 =?utf-8?B?Vk5nODNLMXZNWFFlUUVWSkE5RllUOHFOeFRJY2pDSlFGK1h1TUxyRDN3eG5p?=
 =?utf-8?B?dmZiUC8xcE1kTjdoZEVBTDhzTEpwK1FMK2ZTLzNjV0JYRDNBN0t1ZU1FTnhR?=
 =?utf-8?B?QU1jYXBXUms3dG1PKzJIMHN1NE1qVXZIZWV4R3plUC8wMmRTK2tvakRGK0xD?=
 =?utf-8?B?WVdQVURXekFoVjFiVWh1L1pydWJJcXRBdmtlNGozanc3THZmTXlTc3U3QXhq?=
 =?utf-8?B?NjBEeUpyc0RuNVhaMHRxcERWTlU0MFE1SUhmampZTWc4U3laQVNDeEJscVR2?=
 =?utf-8?B?YmhkL1M4ZUJ1dE81Q0pIZWFod3BKcGxMQ1FIcldBREx3K3VYZmMwelYwcGVo?=
 =?utf-8?B?bjZPbnJqZG8xQWJPRTc1TWFUNWZRQldweVRuWFQxQ1Yxc2llUnhKa2NCV1Vu?=
 =?utf-8?B?bmhMNFp0R243cDJwaTN2anYrdGhmdWx5NlNtWHphQldvQkFzbEViNjJpSmRG?=
 =?utf-8?B?djJtL3NoOWxSbDhFRjlyZUZud0dwZnhWWmVtekFPNU1DV2NyVXBob0JWbStF?=
 =?utf-8?B?RlNtY1ZwZmdvODBXQWlRdkdCd0h2TXlVc2RiVDhmV0VVWk1pZkRTcVJyLyt2?=
 =?utf-8?B?S212ejc0aU4wSVVnVTdFYXNaTDc1ejBRbzkyaGFqek52NmQ0b1hoSmdTUnVw?=
 =?utf-8?B?MTdpdHpiWjhoNG0vcVQ4b2FJOEZOWnlMelkrU3F0WWpKWTdUb0JSNVBVdkNV?=
 =?utf-8?B?dDlYTmY0U3lTR1NXY3RMOG53QXZYWmRkSUJXdmtKdC9GM09wTzNhWUNzUDM1?=
 =?utf-8?B?L29ZdG96MHBBWFgxbnBrYmFnYm5QTkQ2VHRlSjQyc1dTeEpyNjBCZU90c0NC?=
 =?utf-8?B?eDN3K2E2QS9RMkJMaUVibFpKUCswVW9XRStoSXlhMTZSZ1M4dVhWZi9vWFNu?=
 =?utf-8?B?RWRrSUIwRFVIYVBINVpqc0taWE85eFRDOWNjVFRTKzkzN3VkTnVQeXZqTTR6?=
 =?utf-8?B?ellLVFJvb0hrY1VrazJJMHkySmZaNjhiSndlRlh0NDR6V28yWC91T0tjV0Rv?=
 =?utf-8?B?WUtndmVFaFhZT0RSK21Ua0hKcXNBM2xUOHgzR2V5S3FFcy81Q0RPdm9WK0lP?=
 =?utf-8?B?bkIrTDJrd1dxVHc5Z3pzZWJRY1pjUmJYVmZaVzg4WTNEVDd1QUxrN2dHQThR?=
 =?utf-8?B?U2srOVMwNkVIWFhoWVZ0RDRMci9SL01ad0xtLy9nTnZQUXhTcDB5dWJ0bW9C?=
 =?utf-8?B?d2I4TFlRbUY3R0xDSVdMNkxVTCtJWUpWTmZENmhTR1h1U1ZsbjlCMTEyWE5B?=
 =?utf-8?B?c2VkbS9BdlQramE4YnBsN0x2RTRRa3Q2bUJkdTZVSmdsNk5vY2I0MEZQNHpG?=
 =?utf-8?B?SytiZDRiMXpCeTdHSTBNQkdLOHhUTjhNUXl1VGpHSVRNS09rcCtCL1ZnODlC?=
 =?utf-8?B?dXk4cW1sSzVNS3M2Y1lNcDVDY2JhVmNZQngwcEkzTkdwWmlYUjBlMll0U2N5?=
 =?utf-8?B?ZmpyMEkxSGF1eTI3VkZIOTdOY2tLaEg0MXZRZTc0TmVtRmtZaUFhM3FRTFhW?=
 =?utf-8?B?ZktZbkR0aXorNVExT0p3TFZadjhDMllZekQvVlNNdXcwTUppdUN3T0hwZTZa?=
 =?utf-8?B?RzZGWXdlUGtyL2pWVHQ3YjFqOTVKT0hITGFIa1hFUWFoOFpTV0E2UGZMZWkw?=
 =?utf-8?B?UDlaSlZuVWFGK1FDOUhNQjJxUWpDR0NTRG1pNjFKaysvaGhqOS94MkVCRGpl?=
 =?utf-8?B?QmFpbkJwd2k0Y0pBOXZCendwOUJWbFZlZzduTlZjQzI3SHhFdDRQaXd2Y25I?=
 =?utf-8?B?b3NqenpWZUM0bHZqZm51dGpSVG5hV1NOL1ZFeGhIemswemZLRlZpRHpKdXpi?=
 =?utf-8?B?RURTa0NQaGlYa1gyN0QvcFNyRFgyRWcwOGJwMU1YUkFMUm1GSlU4WkdPeXJJ?=
 =?utf-8?B?Z1hLQXpGVlNkVE16VGN6ZlNMdHUxeVpXankyajcyNWxRQmowM1hQbFQyMm9G?=
 =?utf-8?B?S05GdVJZanZKTjU1QyszeGgybG00WFVYU1JyZWRzNWtIeGFxWEdXRjVGMTdO?=
 =?utf-8?B?SEJCTFdYZTNIRW5zZ0MwRDMyYnQxN2FVUVhiS3NER1dIZTlkVWU4cC9iSXln?=
 =?utf-8?B?OUpaZFV4b2NzcUVsSDh1UmZROTRKeUtlejZRbHBvdTJOcVFQdWV1cGtrZm5k?=
 =?utf-8?B?cXFCci9MS00wMlBqWndOcVZpcU1ILzFnY3U1bnlIM2RZUFBoVU9FaExWeTR5?=
 =?utf-8?B?andkZmZjd3lselhGUlNHeDVuL3NlZkJOU2Mxd3UxNzVGSktGcG5kLzR4WDNV?=
 =?utf-8?B?WDllaUdvY2tuYkU5NkFYSGE4ZzNyaWlZcjVpZE1UMXpIbW9OTE92UT09?=
X-Exchange-RoutingPolicyChecked:
	MB8GN2+ITRz7Jq+hQY+CsY8bjjaoHacCWNxMq5oWyB+n0OTLrzNwMwC8StEmE0lMmVO5rkkzScNklGs+Azucomd+yVTa6iq1A21qpESlScg5Lj+/HMHDJAmAzYKcD9KHDSNPFCEfNpR0z/PldwWypNnHLK9oM86GWdXQ/zScd1+oSnJQ0CKiAl5rA5i0v31MdpaUbwJEUNsOADaUrY2sbunoUnQzIpKhyg6yJKwLi8d3ZE2lEexDzTNtPObYpbF4KJ2ZnE/OgeWItBC2sMZl+pW6MS7JD9l6ahEvKIk54D4mX8Yv2jJqiM9FOfmypP4YsbEwMsDzxuFx4XffX7Ra7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BxYmuva+rKDyB6V29MZ2MQz4dCUt7JDuI+xA/G1hrx+2rnGrNJgDRDoEfcnd76LkyQgPXjEfHvyYHKapxFmJDIigVHyAWvE9qkWriHq18/QWyROZUgge85KD4jU8OqtrsSckRy9WlaNIrOYyvOkcM9b2jB0X+mB+UMub3w/AoW1Fe9pnPM6QUe9kM4fq8XUXgtxh7QaRCf6iedIlv01qApOMmYSmBGhgFWRLxbAzZiwQyhbjWtXPfdNFhw7O7ZxW5dY7gyKQ9KOcoC1hYd6f6NyVTxatAHNuKDJmYkbL2S/hTMlKMC86j+33YZBZS/o8xfg4BM5zj715WB7g7z50qkwYt039Ytds6KzA8WarjbLIFtaOGabv1ZCLAqUsmULiaqWgJpFTE9545ktpyH47XnpkoUGCOlxiC11HysX3e7zx/AoMjIISdAd6i9FP6YeZM/NtqY0XqXz8zQ3oa6doBoBfOylxIzYSWM5Xtm/5FMPr+lZk422lc54hiDJavpyEIpPczJlD+j5Jt92xXj9ljMGXM9CkQGTw2JBw18nSCXOdOA5XCDseHBn75PtkuFNagx+ydaFKKudpVE3tewau4gf8HKjUkn/M6xC00erAHIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238dae8c-ee6a-4a41-82d3-08de84054083
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 09:12:02.7516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFTRCJtn4juSFuYAVs4su0C+U6eM5DJGDz9W3D+1uo4xUwWbGYRFJvN0z3+gE2OOWJmamENbxStEdBnS8jSrZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603170080
X-Proofpoint-GUID: Gw1akDy5BuXcP8-SS76BJyLEtZWax5ZB
X-Proofpoint-ORIG-GUID: Gw1akDy5BuXcP8-SS76BJyLEtZWax5ZB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA4MCBTYWx0ZWRfXwi8V1khlHgir
 eg15RRNStCUgaDF2T3Kiz5Lph7gfD0SstC7dxwhiDbNmCTZpgpuOLBCyaTEmvd6/8p4t/kBPHhz
 nVqYes0fqQRFy/F5u0z22UtWS8MzsE2eVTw279Cm28iBiBIEBQRO0udQoz8uow35OxCPTSj4B8M
 B0hU3Vgc4BDxtzT6LUEPmGJS/XZYXhMUFL6YmvAsWBNF0n5u2Xh2r1LH02vQDdHXWlRmxJkznrr
 REly3ub5RpjQahC8wn31vakl5aug5r3d40uAZdXpuhY27QkB8pHelKQJF716TTIY8WCGZvOMxnQ
 R9zY+rZ7QSNUmAkQh+/Y1AGPiE7y+EU+V5LS5mZi/0n7hVpMIJlIftrrlIfYAu5ar5MwfkC1w/W
 0Mn+aobfu1FGBzzgvteVipVipuJWwihywfW4loyl5caWF7cl9/PNX/Cy6zxb4GuElFSct2EJUM4
 GMAHMW+nHWAE/d9zPAA==
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69b91ae9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=RTaEFEZCKIQwyuaaZKsA:9
 a=QEXdDO2ut3YA:10
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-225774-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:dkim,oracle.com:mid];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.g.garry@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9CC9B2A6643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 16/03/2026 20:39, Ionut Nechita (Wind River) wrote:
> dma_opt_mapping_size() currently returns min(dma_max_mapping_size(),
> SIZE_MAX) when neither an IOMMU nor a DMA ops opt_mapping_size callback
> is present.  That value is the DMA maximum, not an optimal transfer
> size, yet callers treat it as a genuine optimization hint.
> 
> The concrete problem shows up on SAS controllers (e.g. mpt3sas) running
> with IOMMU in passthrough mode.  The bogus value propagates through
> scsi_transport_sas into Scsi_Host.opt_sectors and then into the block
> device's optimal_io_size.  mkfs.xfs picks it up, computes
> swidth=4095 / sunit=2, and fails with:
> 
>    XFS: SB stripe unit sanity check failed
> 
> making it impossible to create filesystems during system bootstrap.

For SAS controllers, don't we limit shost->opt_sectors at 
shost->max_sectors, and then in sd_revalidate_disk() this value is 
ignored as sdkp->opt_xfer_blocks would be smaller, right?

What value are you seeing for max_sectors and opt_sectors? That mpt3sas 
driver seems to have many methods to set max_sectors.

Thanks,
John

> 
> Patch 1 changes dma_opt_mapping_size() to return 0 ("no preference")
> when no backend provides a real hint.
> 
> Patch 2 adjusts the only other in-tree caller (nvme-pci) to handle the
> new 0 return value, falling back to its existing default instead of
> setting max_hw_sectors to 0.
> 
> Note: the scsi_transport_sas caller (the one that triggers the XFS
> issue) already handles 0 safely.  It passes the return value through
> min_t() into shost->opt_sectors, which becomes 0; sd.c then feeds that
> into min_not_zero() when computing io_opt, so a zero opt_sectors is
> correctly treated as "no preference" and ignored.
> 
> Based on linux-next (next-20260316).
> 
> Ionut Nechita (2):
>    dma: return 0 from dma_opt_mapping_size() when no real hint exists
>    nvme-pci: handle dma_opt_mapping_size() returning 0
> 
>   drivers/nvme/host/pci.c | 15 ++++++++++-----
>   kernel/dma/mapping.c    | 13 ++++++++-----
>   2 files changed, 18 insertions(+), 10 deletions(-)
> 


