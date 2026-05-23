Return-Path: <stable+bounces-253905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4L8aCWJEEWo4jQYAu9opvQ
	(envelope-from <stable+bounces-253905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:08:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 323905BD657
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72CC23008D22
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 06:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376E334C1F;
	Sat, 23 May 2026 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PshydlTK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lcSvj6Ta"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA9932B119
	for <stable@vger.kernel.org>; Sat, 23 May 2026 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779516495; cv=fail; b=m7dY/lKb1TzPOuTrhv6lYIkFwWeQMvBNs9Dsl37IjomDB+WBM90tuO0SzcRBrWUFk23Pdx1kozU6uyG/LG1CEJBIXxJT5ZCtgvOSIcyzVvl43FdqttFxju7ZJkxKz5ffHHBQmxEe25z1JAQZoxg58vkyusSFkzIqZB4H+qFOM8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779516495; c=relaxed/simple;
	bh=zU+iz/fxHj06fOUUsNul74L/XxknS56967hJtIMPtoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OXfmtlPGl2sa3+eUYXimXOArcdstCJ+4GV8TuEnuONTADObdtoo5Y8+4tUrsqJbw77xgQbb1azRDhDea/xYsCi7LNpwO44TlKHq+MjccQEMv4lzvX0UFHrQdg1n5g7TDzFwhKV/VNfSjE+iFjCeWsq71hlH7OafoxOcWEzl41dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PshydlTK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lcSvj6Ta; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N3ZaV6966580;
	Sat, 23 May 2026 06:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RPe390lQRTYke3INCcGx7yU2Ar+hdbWFzCFjRgS9J5w=; b=
	PshydlTK82OS46ZwV01YpRjF3mdg3x2C3Ff7OVBnBarm50E22ljdmCsPvJaOCRUJ
	Kzr1u4biILCT5Ejw8IC8p337fyboH0hl9fnb+ru/5Y7NJ/GUxFuIf31yIL65K1Q/
	bmIcl2YflZZXNUSYF2FkQakTQ5BZvibeS/Ucsha2T7AbG0ESGhYLEUKRcbOVhb7V
	qPnYPn8GzPBCDXrUDepjPpLSRG+dAhawThZ4qaYtN+poYuU97wBUt0blT2xQKN92
	NZerkwj7v91u/5Yg9EEaKlPq3eP3nS57Zh5qSU3WdWW8G3ifU8irrPHxL82VeazJ
	rs4qCS+iRUF8NWksbj6tOg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb47gg2e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 06:07:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64N64iVl021079;
	Sat, 23 May 2026 06:07:51 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2p5mky5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 06:07:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbPZybSxyakM9rBn9NiRmovrgicGUCLumMGZWHBJGkkqiru+GfnCbonapDvEEruaeqvNNUyfo2pW6gCSEgGUYP9QFTWd9I5DdEtAlz0q85OE0s8bGKHk9asyPuS7Dih1BATWpibR08cD8wTxc6YGFsbnHMRHCN6o1o9g5bXhI3qCt8MBzJOWeXuQvzoWava6HJeszBHZMLIz4as7uOYK74Yixi+5byMMhBBCeI+Acup2w9Ts18R4HCkcBdYruGK/ACvI1jLfBYFTacxKe9Njq78y9nFx8GZTb6lOks+I9iOzw5ZzqBHIdjdGJUPcGIhzVmk1UVfqIEwPOGx9oCFG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPe390lQRTYke3INCcGx7yU2Ar+hdbWFzCFjRgS9J5w=;
 b=ZDjbLj9QPgXYEIc4oNOstr85Un7IVIljdy7teFMrS9PAw/qs+AQgSrN+/oLU1oHaFiglzFg3XkwWTbFu49VOWxYwwc2zoXwVNfN6zaOWXWiqUtbFNo3SwyoRqTJDtvktkFM8DhyH8xjWRocuhfxCo6yCa8AKP8Q6c7q7cq+Bli+SKIIdBZ2t0jC/xFEnCnVHXaLSbkNKvmPg+jjk/2LpkPEqzfhuY4gUGTEtbhnAcDsV7APxKMXSUR5rJqynINoxsLQgrMirRa4zhNi6NXFav/aMW5ikZ3T1Zlqvkbq+K5CxadOz94qd1Ael1jltS8yK8q22p9cVMepJQvleLTToCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPe390lQRTYke3INCcGx7yU2Ar+hdbWFzCFjRgS9J5w=;
 b=lcSvj6Ta6m5pPFARDoEfnow93dzvABP8Eyo5paTbh5JZ5dn8WvV3xCD2HzYPcscdPtZ3KavmzHVXXk7ldjKO5Gx3kAEBmEwvxil9X0FZWMw4Foc3hzrE4HETkiqg+T0HMFkPVAOxiYP+QrwXp4jBnp+2BIwWnhWbjkcxjbsq8/o=
Received: from PH5PR10MB997710.namprd10.prod.outlook.com
 (2603:10b6:510:39d::10) by PH7PR10MB6081.namprd10.prod.outlook.com
 (2603:10b6:510:1fb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 06:07:46 +0000
Received: from PH5PR10MB997710.namprd10.prod.outlook.com
 ([fe80::2edc:9811:1c7a:5a8a]) by PH5PR10MB997710.namprd10.prod.outlook.com
 ([fe80::2edc:9811:1c7a:5a8a%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 06:07:46 +0000
Message-ID: <e200c3f6-08a8-46fe-b14a-64c7f93ff96a@oracle.com>
Date: Sat, 23 May 2026 11:37:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10] net: skbuff: preserve shared-frag marker during
 coalescing
To: Ben Hutchings <benh@debian.org>, gregkh@linuxfoundation.org
Cc: vakzz@zellic.io, edumazet@google.com, jiayuan.chen@linux.dev,
        kuba@kernel.org, stable@vger.kernel.org
References: <ahC38RZJN2O3Ur0R@decadent.org.uk>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ahC38RZJN2O3Ur0R@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::10) To PH5PR10MB997710.namprd10.prod.outlook.com
 (2603:10b6:510:39d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PR10MB997710:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f5afb5-300d-41d3-c246-08deb8919c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QywGPzoHH1rizOwF5MWx3G7Cl6lJnbizE/iUUy4rTdCLtIQmEaWL2AaYB5KhQ4ixgJ8wrixFeIKuFW0RbBeFuR7pvgGwhxOtOTdm9MBmykJtGZH4z4GdK+fR5SF3lNHhI5CTf5/SF1kSu3jltlJ3WyFUmWUBsFG0Bqo4QlCB9tHhVHxNEOBZEcFyF59kHQChXtTf1+u5UgZXio6hUsKGsSrTqS78hISI9hdkwvLBPfIwWD057T+vuY4xRupAkVBqgLR8+qODaj0Wecxy9lAdHG5Y8KEc8mq09aHGNCxBKQnFBrwaKetc6J3GfnaNMoIi780/EaE2e3f4Xjd5bzWX7j9x/3gKXgs0r+1jNiasraxSbwdoKRuO51C/9WDNM85+xNp1E/4fn6CRH1zcBEQR2DQJcSHd0rrda2ZjoZxgTveE+EmyjkjmK611iRShbUsu4cnYzuvp96c3CEn+I+zvk1DyU3dq7hCRR/Q7n8GIIEHOU1TgS7EhmGbNd3gtaB8Y8wyEnWgNJW18RPBuFQt7r9GZNjTgW+Zo0E1IEnlcvCRUd34HAZjATA4OoemRS1LCVPd+6MGMVxL8bFuQjwBcR4WdtqI77tQ0NS940uKnVsgZ837FqXhmbaCMFseXqsWfN9xhEodEXvoLdJjvRBoLwA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH5PR10MB997710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkxWSDZsd3psNFhONXZGV2xEdUNxaUFsdmt3RXhPd2lsTTl5M3NOWlBOS1Y5?=
 =?utf-8?B?b0doeTA1ZnVES2dIV0Y3RHV2VkZHanU1OGZRb29hZnZQQzF0dERFL0VFNkY1?=
 =?utf-8?B?VzBkaFM2TVVaQk1uOU1KSVpKUHYxN3FqM0RTKzZYNEpJWVRoYkhYUlVGVVdr?=
 =?utf-8?B?QVVMTkJPRHBacHNYMGVvNFZ0VTFnT3NoNlRIMFVjbG93MTZ3SFFhNVNFTmRj?=
 =?utf-8?B?S0ZLS29mVFJqckZLK2lGd1dxeHBOQjN1MUJZRTNrWjNVSlhRckdmRTBOaEFC?=
 =?utf-8?B?M2xhYUNrYU9DWXZyeUF4OWNLTmRzSjdqanR4OW16QTZ6eTZoMGxsem9ubzZN?=
 =?utf-8?B?Yjd5UFZETFI2Mllkek40NkdNREpkbWxQRTdSOTlmUjhlVXlkekFVU2R6VnhK?=
 =?utf-8?B?L2FHTEI5eVZRVWtjcG1MUDNadjJEUmxGV0ZNQ0l4SWxLSlNkOG9OQUthSVJm?=
 =?utf-8?B?Vjg5ZlpZVFlLM3JpY1pTd051TWJwSzI4ckdFVk9MRllDWkNuOVdCcHlKM3VZ?=
 =?utf-8?B?M241Q3krcXRXQWJ4WHRyS0NpQ2JFSGFsRmVETmRNQVVONjJEdUlRV0lpRHhC?=
 =?utf-8?B?SWpteVJsRFd2Z2hSS0hrektSTFNtd0grWGNrRGhiSFJCUzNTOWtZUEI3bzJL?=
 =?utf-8?B?RlFreEtWVUNOTlFrMlM4L1lMRnhXUktBZ0tvN2M4Y2pRNkpJSmhYWTlOajhS?=
 =?utf-8?B?TCtMblczOUhYR3BOUnFKTW91RVVxL09naTNZdjFtbVVzaXJtK1FXaFhUaVRK?=
 =?utf-8?B?RlZoUEZDaXNnZ0tYczJEdzZPTXNGdTlxcVdYbWZuSGIzYmtzcC9xRUZxQnNE?=
 =?utf-8?B?ZlZRNzFSQWFJamxMNlZxSElxMFFjWWxDcGw2cTNvZFRDSW56ck4zSDBtd3Zt?=
 =?utf-8?B?SmZCVE02K0NhQnpOQlVFSXUxVlpsbFVXWWZ4SzlKTFF4WUFvNkllbWtWTVJl?=
 =?utf-8?B?aVQ2MTEzQitIakI1S0hhZm95S25jTDdWVlZydnhqSXJxTVo3aEFJVHFlMEdX?=
 =?utf-8?B?ZXlqZmhybmFsQjJJOURDNTJ2MnRKQjd4cTB3SFJmd0JQN2c0SEJDM09HcFVG?=
 =?utf-8?B?VVYrcTlrYThKNmRLL2g4VUdZdFFkc3VTT1p4RDBOK0phd0NSRnVPSjdOZWhF?=
 =?utf-8?B?SEhQZy9iUjM0ZW40SkFFUWh5bFFTY2RVV1M5allNTDJxSDdleVN5b0l4Q3V5?=
 =?utf-8?B?WFZhVk0wSEdzZlJWVGU1QTQ0bU5lMlhBVFQ2SXRvOG5uNGxqbFVBemtTSEJF?=
 =?utf-8?B?V0tONXNydFpFREZlN1NmNXhlbVNJMnJhR2hISzBOaG9OQzFjdDRkMWdveS9P?=
 =?utf-8?B?cmJmTm5rZk55QzJLZUczK3l6dlpMNmpiSUpHcml3SHJDQktKTmkvQ3pDQVFs?=
 =?utf-8?B?ckx4aklpNldxMEhoWkNTcTdZREFBQjlYaEkxS2M0TnRTOEYvQldIMmNpZ05Z?=
 =?utf-8?B?YnFkY0lKTkYxNnA3U2xieGoyRlp0bGxLTEI1TUUvUHVBVzlkS2l4UWF4TEpO?=
 =?utf-8?B?cW1VNS94S3FrMW9JYm9rV0ZjeVZjQ2grcVBXRzR6K2gxZnRhcFRkZUlFbXI0?=
 =?utf-8?B?S3BmdW9WcWgrZ0FBZ1E0akRONFlqdjZYUmUwYnZCNTZ4cnhiRVd3cHBicXNj?=
 =?utf-8?B?KzJvRjBqQ2t0a01aaFI5SGI2TjJOayszb21kOU54N3N2bURpbjQvTzdZdDFn?=
 =?utf-8?B?NkRGOGNMb2VkTmZQZFNlbUNYcGdHblNteld2cGhBdHprMVNsWmNqbUZ6NG9j?=
 =?utf-8?B?SU5FOVhkTFc5eDFmZXc2dnZkMU1uRUI2N0NvbVE2UmVpeDBqa3JCcWtlTzlU?=
 =?utf-8?B?eTdtS2tCa2YwUU8wUnFabW1wY2gvWkVCYThXaHBnenRCeDdhay9PSE1GMTdm?=
 =?utf-8?B?SEJ1N21DakxRZzRvRU8xVXBKQWRWZ3p1NCtNODVPa3hmNWJiV0duUHZWdGxB?=
 =?utf-8?B?dTROUXVmazJtQi9aMjhSM1cwM2lwVGRWTnNjWkxoN1ZrR3BFMlFKVGZOT0d0?=
 =?utf-8?B?dndRa1pheGx6Q0phb21KSHBvSVhFNEZTWjkrSWZJdzhReExGS3g1Q05zR0VX?=
 =?utf-8?B?UjBDbERrbllrQ0hlcjNiVytzU1RqSERoZGlBV0FQVmlGRW55MTZZZHNyQ2VQ?=
 =?utf-8?B?dk41dHJYU2NKYjBZeUV6Um5mdFhpRlFwT2YvR1V5ZFh3V1A1bERPNFJVb251?=
 =?utf-8?B?aVorVDhMUHp5M1AzOWtkejlEczZsS0xVckFxU2JuMktKNFo2Z2hWbXkxa1py?=
 =?utf-8?B?MUZjNnAvK2xrK29hQjVRVllyM2tDbVJPWVJmaFY3UDdaZGplNGNrY2I2TFlE?=
 =?utf-8?B?OE5MamFlK0Q3ZGdScXkxVVlXcHNubXJwRGpUODJmSnpaVDE0azNrSDNFaGx5?=
 =?utf-8?Q?z8n1DG9OkKmkZKKgDsPt3NXK8gzw4hvZ8JLp6?=
X-Exchange-RoutingPolicyChecked:
	Yg1MiwCw1Q3AUjk0G5RcSWT2z9RIaqIXUBXiyukrNoxCBJ/tW30uoJjbJvMk4awSK5DEvOLtoCj3jQwR1i+XsUYmvs4EzOeD+sHqZ7pDePgFRsfuVnzDldXnhz05G43IWTKDVU+3jVV5Epv98KK0lxfegYWTanXbAFRztGuakTvFHbv2Yi97n+XtSdYJuY3TEuHvCIsSxbLBhLid/iK01ZJ3QN8PNK3lIevzkOmsOqPpMUwplAnBUbQRu6QP6zlbYHDqcZhamQ/DFKtKiDLcineXYJ+TMmzZ6FlbPBFOHPMJk+Gdwofy13tUTU4oDUuhKohFjrtRmSjUUrns3JezAg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FQcHiEqo/K4KpTypFcen86XffHExTRDIus7yBsYulGYSTehjFnFUNc3SDKE2i7hgFjxD8/tSE7QdBpyDym4S63c3yuM8CTBhoD+yQf7VZTCe5XyPCXWvKuAc0pp4/M0pK8AVX3yAUiSuTXHCvd4Lkza1bukHPoRrfjVk5BCf+m6roHgt35CmIkO+LKjO3bppzr61IcV6s0aFt7VUe1X0g3w9Aqo14JyZyfLeE2WzRmwdB25Lnc9nwFmBGK4UkPUmo6xLXskfkWCW0JoVHw0wfpPsjQ8W+AP8K+kAjwaDngG6R/bxVZmqpQinlEMCAGyXHMwowP5YKYudCKtgocZl5vMg/VROIkkFHizNnR+OPDZjcof7QWFZ7cI36SA/T3cR//z5mE9YNlhl0NaA2v3Q1Xf9oQYZAz24bGOrtFZ1LsYFcykbC120aMCWtwsqsarW21UAqgnU68UwSBVsgM5O+8WNXf5Lz5UQBLnIUtmc9bMx3iUMTGlwIJgLtU6tn1i8iCBiCUaBK7vXQrBRZJ5SMmy1e8zOCojFy6SsK23N2KeHH+O37D14C+ibNSzArB0zLtk36+6lTY7YUkDnAscKuZrveU8BGAvwgHpPf1aW32Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f5afb5-300d-41d3-c246-08deb8919c33
X-MS-Exchange-CrossTenant-AuthSource: PH5PR10MB997710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 06:07:46.5668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jj9fNCZdktX0Mem229XDPS7aHtPjgsEiRwdGTqoCIMH6xGwbpCwl47b7Fg7HWlAZ492szlnof/qB1lrSrrhLdTseMwyqHrB+7doIocJtqnfWirXLDwc4SJ3XkhPsT6f/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605230058
X-Proofpoint-GUID: NedWlyhyltXFg-s9OnBbPkx5V4ucKfGD
X-Authority-Analysis: v=2.4 cv=LtmiDHdc c=1 sm=1 tr=0 ts=6a114438 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=bC-a23v3AAAA:8
 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=xNf9USuDAAAA:8
 a=1N4z_McScmk1ydz4GeEA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13835
X-Proofpoint-ORIG-GUID: NedWlyhyltXFg-s9OnBbPkx5V4ucKfGD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDA1NyBTYWx0ZWRfX3Kzv4utkvH5T
 7GxSYMVIpIjqJbNCcLId/LmcP049kc8QFjVH4IdDl1O9tku55X0LHMC0Kdw22K4MsUFnTUjLGR0
 qB5I+Rr9R4CznekUS2kZ3H6TW6O4h1fgCzLflePORUoERotTha99uTNhdz5dsGZFlTTmZK1C3fD
 H2BJOe3AFjY3VP7htzZeOnTBYk7LwpC1dWUv8h+/POJXpuy3++wcFjuFhNsmEnaMdpYOpP7SxFU
 sSl8p2tMbsGV4Ea/dnVgL/Vol9uuxrNwQzvCsJbfWAOXBkBG3xr5Xc+047w/yxqFt6TPjlWjd/p
 R9lGcI1EDt0Fn4YWz7jp0c/4vm1QXsrvu0EItRd92Dfp1tD55sYF5p1Jqd6rWrq2ElSR1WYJ7wI
 2wJ0I7gkP5XC0+q6RxWuIiCnzzS6FOlII83jdtbjHNEDUOeeTfWOtgP3vkjap5XvnMwBrqKuegU
 bIJ2r2SU6o07sHeYB97yOW+ey5Vrab6qK5Y8a5dw=
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253905-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,zellic.io:email,oracle.com:email,oracle.com:mid,oracle.com:dkim,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 323905BD657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/05/26 01:39, Ben Hutchings wrote:
> From: William Bowling <vakzz@zellic.io>
> 
> commit f84eca5817390257cef78013d0112481c503b4a3 upstream.
> 
> skb_try_coalesce() can attach paged frags from @from to @to.  If @from
> has SKBFL_SHARED_FRAG set, the resulting @to skb can contain the same
> externally-owned or page-cache-backed frags, but the shared-frag marker
> is currently lost.
> 
> That breaks the invariant relied on by later in-place writers.  In
> particular, ESP input checks skb_has_shared_frag() before deciding
> whether an uncloned nonlinear skb can skip skb_cow_data().  If TCP
> receive coalescing has moved shared frags into an unmarked skb, ESP can
> see skb_has_shared_frag() as false and decrypt in place over page-cache
> backed frags.
> 
> Propagate SKBFL_SHARED_FRAG when skb_try_coalesce() transfers paged
> frags.  The tailroom copy path does not need the marker because it copies
> bytes into @to's linear data rather than transferring frag descriptors.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Signed-off-by: William Bowling <vakzz@zellic.io>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Link: https://patch.msgid.link/20260513041635.1289541-1-vakzz@zellic.io
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [bwh: Backported to 5.10: Set the SKBTX_SHARED_FRAG flag in
>   sk_buff::tx_flags, instead of SKBFL_SHARED_FRAG in sk_buff::flags]

right! due to missing commit: 06b4feb37e64 ("net: group skb_shinfo 
zerocopy related bits together.") in 5.10.y it is only in 5.12+

Note: I did the same for downstream UEK(OL) trees and was planning to 
submit them here. Given that you posted them before I did, sending my 
acknowledgements.

LGTM from a backport point of view.


Reviewed-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

thanks,
Harshit


> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
>   net/core/skbuff.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 297a2efd6322..c195107434b8 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -5315,6 +5315,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
>   	       from_shinfo->frags,
>   	       from_shinfo->nr_frags * sizeof(skb_frag_t));
>   	to_shinfo->nr_frags += from_shinfo->nr_frags;
> +	if (from_shinfo->nr_frags)
> +		to_shinfo->tx_flags |= from_shinfo->tx_flags & SKBTX_SHARED_FRAG;
>   
>   	if (!skb_cloned(from))
>   		from_shinfo->nr_frags = 0;


