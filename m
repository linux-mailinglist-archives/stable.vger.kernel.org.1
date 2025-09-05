Return-Path: <stable+bounces-177897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851BB46502
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9854CA4628D
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA72DE701;
	Fri,  5 Sep 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b26VuJVi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DO02zJqr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F74285CB9
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757105755; cv=fail; b=MfuHBAQluR19eqyN4VmzlnfLWtelRI3ZoIP28+uVOZu9QOI6N6I/yySS4O6tmXqDH10ExSp14wfwGG+Apx8fiQWZcRhFBFHfzji5vJUKpqsc7WzSh0nJK5+ncqQMzSCIUkxqo8p/3LqKqKz0PuM+gzq0gGWWNYQHdfMLluYe9RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757105755; c=relaxed/simple;
	bh=onXD1Xgdj714L8D5ekvYDab1rOFMMSoELceU2XOs+aY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TRq3FhXQ3uqr8k8dAKoQYt5az0SNRTg0RZJRDkYu5h7C+bH3WlHHuW5ZVDTCwQNIi4ctLJFjKLlSx93KgJLAjBKiFwVbWKX0XBYDsZSfuQDyRn+V6U69m4LsSVJlnzFYg6EXpybRFFF8BNPh4uRilZgrN0O6AVOi4K8FmZzUryI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b26VuJVi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DO02zJqr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585KnuU5010820;
	Fri, 5 Sep 2025 20:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sbVBjg8exFjplNgJDxwGomM4icGe1t92cxIOj1bVrx0=; b=
	b26VuJVi0OTrN8rFU51l4C3KrjHMa3rfcFAJHyRQB0+SOhFPQMo0Rlf5GYOxZZIz
	W8COnsyoHdPm3cstUPWCNwwe7+l8fSyWy0cUF0mrEqMl2q9G1yQoY2To3dWH7vy5
	JDGikCad8AAyPXMAeXc+a1ZF4NOXYG8f8dYyohoogOTTSB2UWehpHuGy3+lBmdRb
	/MCsO6GDkzNHzQv3UukHf310gS2shQSdohQBZXDRLZMdJe+/1a96dqQMbCF9WF4H
	EX47GQxmoO3l/BaZvMrp9n6ScPTjM6vflG56U9AUnVkwXQBTnrq6JjwZ3jG5WFb8
	ofb0/L1t0R+wuqeCX1sDkA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49078500d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:55:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585JVJlF026206;
	Fri, 5 Sep 2025 20:55:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrdgp8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:55:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP2ikCY+sxKcDyft/mratYO/AuHacPSWHivioiOA1S05QZ22plIr818wL5nFNyTkdPFnBmbqE4BiDMg9If0xmet9LHoj1sV8zQH+lGShS8uHTywQ2iWuaaGrZGBOMuk6aV7CD0cltxYrC8hqdGdlhi6JxjOIEMbqFA/gom+lYisJ+A2gExDKmXvSbNeNKxRC5jcovHynFt/lqMK8l9iayscrOgZvw8DDP2nSRFLIW8DwEl9md8cQ+/olxWar1RIlPuFwEoLDVtOKY241wCzkWpZXPTdd6K/mq2hlV32RRGfQ1wcjXbP0E/yefWPPybSYalleKz2mhE9qesEGQjag2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbVBjg8exFjplNgJDxwGomM4icGe1t92cxIOj1bVrx0=;
 b=oYjoZc5Idxu6Tz6qZWL36dH7EzP4jBEldZ0lcPGhlkLu7Ks15WhePTzSYD4gWFSGnx0s2HMA5G/xtTOitE9PJOlf7n+1DJAW45LwDhU6UbX+YQUSSypw94+7U6o8hvAOurs7FKdI479mGx3beg2Iulec/qHLgT3QZW/avCokPawLq//eGpOel9nKzB7TrRccLPDGJYcWl/wuWcgGzQfIQu69HiMlNVWV4APXqcI8/cTpxHpGjU4Bv8IxuUtwAQX09vfFh6shppotzr2jONOXuXzeShjdUgdOaVgo11IT94hj4FmJMflvgeI8Tf9kFW0hNXkr6EqIMECm88RbTYx7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbVBjg8exFjplNgJDxwGomM4icGe1t92cxIOj1bVrx0=;
 b=DO02zJqr47FdW4pDpAiju3Z1qzLUXqY4vx5wzWYzb1MW5qGbuD1UK6MCfvgnwdfzKG1xMQLwmw9GhjaahoK7nnyyANpKvN55SDUMmv5lqyO1VSDK6bsS7PswCC+S1yy6T00TeeU1YsNE7eArmb/jrN97q1xWqQ267GAz1oGvP/Y=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CO1PR10MB4772.namprd10.prod.outlook.com (2603:10b6:303:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 20:55:35 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e%6]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 20:55:35 +0000
Message-ID: <f7a6897f-6960-4b77-9fe5-9ea0a95d2104@oracle.com>
Date: Fri, 5 Sep 2025 16:55:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5.15.y 2/3] KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO
 bits in __do_cpuid_func()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
References: <20250905200341.2504047-1-boris.ostrovsky@oracle.com>
 <20250905200341.2504047-3-boris.ostrovsky@oracle.com>
 <2025090527-kelp-vice-8448@gregkh>
Content-Language: en-US
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <2025090527-kelp-vice-8448@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0088.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::29) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CO1PR10MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: 37f6af72-9170-4a96-307d-08ddecbe8fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1MxMUhUY3JOZnBzNTRBa3BodGt4QVNkUW8xend1eHd2ajlOa1hvVUkvREgz?=
 =?utf-8?B?dE0wamRzditIOXU3enJ1aWdqa1pVVzhOSmpsbFc5TWhUUXNuYjVwNVRxMDk5?=
 =?utf-8?B?bDhkMnV3N3c1V3VUUW9IUmRFZ29ZYy90bUtUYlkzalFDMmFIQ1RSUUx1bjlF?=
 =?utf-8?B?Y0djazd3djhFS214VEVKaDQ1N05XTldhVXY0b2JHcUloMzB6OW1zQ3pUSUIw?=
 =?utf-8?B?aGIxM05BM1pDN2xQWVZmWlBNUmNvSmlkQzBVZFNiY0hRNEZ4YlFDTDd4enJh?=
 =?utf-8?B?N2NBUmhVVWVtREVzRTBDbzljRDQvMzZ1QXJRYkFSbHBhcExJMlUwbmd1Y2w1?=
 =?utf-8?B?TzY5TGEzRThLVVMrditXL2JwTzMwQ1J0QUdhaGQybkN0WHY5WnliZjV6ZjJ1?=
 =?utf-8?B?K0Q2UkNkeHRXaWVXdFNlaXlPNFBkdTgzSjBON2wvTGE1ZFlQeXZzUDJlU01y?=
 =?utf-8?B?T2IzeVZCUERHTldKS0UyblBaMGtZcXJneWVGL2xwSEhyQUpmUzFPZURNY243?=
 =?utf-8?B?QXpGZDJMVWRBdmI5ejA4Tkcxdit2SDVHbVptelB4WTY4VE5hNlN5WWlFVFdK?=
 =?utf-8?B?SndTd2VVdElzbDVTZURMUDgrdHFUbW1EVEFWR0krMUVma3AzME1KZjFYOTBH?=
 =?utf-8?B?ZU5zMWdiaGU5R05tZGZjbmRLTmlMZ0dYVm1paFQ0azJzK3dXMm9iN0FuQWF0?=
 =?utf-8?B?cm5qNmRsc0kya293NkJseTlaTjRvQkdFc0pFc3lVR25iNDhud0gxSVNJb0Mw?=
 =?utf-8?B?S2pMblg1YUE3aG8wVmZ4SURYdVNDTnZrWE8xL1ViMVdNSUx5anpMWFVIdGZm?=
 =?utf-8?B?MG5hOERuenc5ajRZZUcyM3lpaDEzb0ZRVkozVHViYlJWRzhpVTYxRy9sTTZi?=
 =?utf-8?B?b3R6cE9zeDg4UzVwaUJHRzNHSFhVUjAyNzNGaFZTcmpKTEk1Y04weXBlZHhH?=
 =?utf-8?B?NlJkZXF0ZkEvSmoycFdSeTl4TU5GcGRuL05qOVZsYzVtcTZnTHhPcHlKOHps?=
 =?utf-8?B?M0tWOG9lZkhrMk94b3dMMUoxUnY0Y3VHdklTVHh2UVNOZU9SM0x2RUlJcTFa?=
 =?utf-8?B?TU1zbFNrN0VmOXN3eG5Kdk9jR0xXRnBjbDRsZ0wrc2FCQXR5c3NqenozbU9x?=
 =?utf-8?B?bGVtWjYyT1d2OUhCVjV0UldLZlNKYnU2YmUySUVjNWhnSEdRMWZubU1mdDBV?=
 =?utf-8?B?NDVCcnllUmc3YUFCSjNjcHFVbXk2SXdkWm5TMmN6dHpRVlluVmZ5akkyaFF1?=
 =?utf-8?B?RXIxUm1pb2s5MUdUdkVBbkI2cFN5SFdlSzRBdzBwQjAwaHdpSVdhTGZORXY3?=
 =?utf-8?B?blFjaFVzZmZ2cTI3anJCaXlWU3JQU29hdml2VU9OT1RHV3lJbDZqSFNTUkF4?=
 =?utf-8?B?SmJ5YzBhRXVOayt2YzZ6bGM3ODdQY3VoMXIyOFFQVWVRVzFGNUZNOXNBb1Ns?=
 =?utf-8?B?N2g0cnRGMldMSkFBV29jbElCRGp0UHdwZkRTWHpibGFnYTJpZUJjb2FkREc1?=
 =?utf-8?B?TnNaOFRkbUlDOUNJanFJMjhyRUp0U0RSSmN1WG9PdjBYOUI3aVBnR3hyeWUv?=
 =?utf-8?B?VkNmbEJ2dXQzbDZNeG9pTll5NWxPL2VaUjF1bGc0cDRPSVZkalF3SzU5cnZE?=
 =?utf-8?B?UGxNS3lSQW04MndFbDRyQWtmQ0x6alJFbVZFTHpNdHQvSE1NK2ZCSVR3VDdQ?=
 =?utf-8?B?ZVVBYkt5M0h4SE5zVHpDSjl2cjQwTlhDTWZHOTUwWWE4ZytMcExRMmg3OWoy?=
 =?utf-8?B?bjEvNHJFMFdGeDV5NlVjN29waS8yeWRyd1JmM3lQVmF1a0NEZFJYRzVEdjJR?=
 =?utf-8?B?ZDkyRmpXMElsZDN6cisycjFCVkt3TmJ0MkhURGpTeHQvVGJtMjh1K0JCSGdK?=
 =?utf-8?B?UVFSaWxYVGREeHpqa3RwTHZRODJlVS9jYUdkNzlGWTdOQU9Wa1R6Q0F2bEdn?=
 =?utf-8?Q?r+1MGCjHLzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akppMmpHOFV4dEcxd0xLWFpLbzlqMUNEZnQrM3l3cFprTGtOM1hMNzFJNXEr?=
 =?utf-8?B?bTM3ZjRVcytKMWdYTGZhdEw4YnZvbThsZ3FLYndRWlhiYndHdFlHT3NRUEVD?=
 =?utf-8?B?R0pidnk5d2RIOGUvdk5FendhL1lway9GZ20yeUhQY0lLb0dJWXdFazVKTUYx?=
 =?utf-8?B?cVpqalBwTHlqUy9sWWc5a3JCMXYrSzMxUURoWGhFRmVOL05Mc2gzZGx1eGk1?=
 =?utf-8?B?SHRGdjV1ZUZJdWlPRDZvQVl2SFlhWG9uZnpydjRtOU5MVWw2ZGl4cGN2cXJ6?=
 =?utf-8?B?c0dBWTVxRHpIdVlXY2FNWWVlRld5TGNOMDhQNUJHbGNCZDd5NHZrbzIrVlUr?=
 =?utf-8?B?MDNFaHVUSlNrbDRRU2pFK2VRUDN0Rk5XaW82dUVTbXRXSmRxU3ExVDR4ZGIv?=
 =?utf-8?B?WkJ2WEFNbkk2Q0cwOEtaRnFjSzdIMjVFczhXekM1bkJxNkJYdENJd0tVdU01?=
 =?utf-8?B?TTUwVTZnTm5POEVhb0tDSVVXNWpvdVM0WVhxN2ZGMnk3QVRTdTVzK0NyZGI1?=
 =?utf-8?B?TG1La2JUNERVM0pPU2JHeWJ3V2RiOWxLRzFHOE5QenhOaFd5STZEb3ptcmRT?=
 =?utf-8?B?dEpqUmpmdmNZUHgvQ3M1ODd6a2lXRUFxbjNxY3hRbithQVBaVHYzampqYWV5?=
 =?utf-8?B?T25LbDRFWnJNb1p4QVZid3d5ejZwMUtUMnVSQzNTSm11QW8rOHpZUm42WVho?=
 =?utf-8?B?U0dlSGVGbkVFR0VJTkgvUWZzMG9zd29sOHhWVXdQQ055N2tRK2dMdHVybHlk?=
 =?utf-8?B?MkNnR0pybVorazg1aDBQbFVrQjg3ZkRlMHkvMzV4K2dvNW8yU2Zpa2YzbVZj?=
 =?utf-8?B?Uk50WUU3dC91b1FCYklCcFgxU1RVSTN0VGdHRmJvWWc2Mjg4dTVMYjBYTFdX?=
 =?utf-8?B?SW9MV3YvZ05rYVpRUStpYW1OOUhZZEkxMldsT1Z0d1IzckNxdjFsYmlKY01t?=
 =?utf-8?B?akdMcm1NbmhNQVFHcE4rc3lQR2ZyMzUybUhNY094Qm1KQldzS2VkdktubXZj?=
 =?utf-8?B?UndIWUdaMFhBL3ZoZEJLZlBjRU9PaWVQUlZ1THdYajBIZG1JcG1lMVEyVXNn?=
 =?utf-8?B?UWVRT1hTL3ptMWdqdzlJK1VrZ3FxYmFRTUFUVHppajVZVGtxa3liYmREdVRq?=
 =?utf-8?B?czR0SjBoWnRKd09kZWdjdmdFWVR5VDBWSEY3T1RzdVprazZ6UkdyQWdpdmZP?=
 =?utf-8?B?aEg0YWtURSt4VmNYaW5peWkvUlRvc2k3bXY5VUk5M1JtZWdtc2JvcnErcHBM?=
 =?utf-8?B?aG5hOGlDTmMxKzMwTDNQRGwyTWkzOXFYR2xTNVJnbFJwdzgyWlhpc05uUFox?=
 =?utf-8?B?YkoweloxVWgyWGRQamRFbjI1bjVaRzBtc2NHMkFmSnpXVk92V0dmb3JaWWgz?=
 =?utf-8?B?OHhlMER6ZVhtZ2FneU1sY3NUay9wR1pOWVRDbUNNUjNmdXVrTUVVZ2RxRlM4?=
 =?utf-8?B?WWxRcnpSbkd5RkEvOUplRExlK1FycWx2T05TUUxldG1hUnZyMnJBRGQ4Z2xr?=
 =?utf-8?B?d3BUV0YrVitaU3pYQkFxOFdxWDJ5a0c4WDNQRmtQUllpUDZVSHEvbWZ0aDdw?=
 =?utf-8?B?Y092UmFDaThEc0pENlcwbG0rMUlQSUZFWmxmTEoxUmova0JkQ1p6SHN5Rzgx?=
 =?utf-8?B?d3czVkg5bUtqNDlkamVQYXJNbzhEUWhlSkdBSVV4UTVUMEliWDBlZ29JSWtl?=
 =?utf-8?B?ckVCWUVraVJMajgrazB3YWovMGlGZDJkWmtoSDNTKzFWRjdmeGduYVFRRGxm?=
 =?utf-8?B?T21PY1JCZWlrT0dBbGJRR2ZoY3ZzajUyVG5pUmVSYzU0eHZBQms0bWRBeGVn?=
 =?utf-8?B?dkRDNXljczd2NllBa1lGT3RTODk2MXZKR3RsSVRFMmRPTTllKzc5bWczMG5n?=
 =?utf-8?B?d1NHTXpzVDZKaXlyM0pSdVYxMjVlWCtJL1Q5N3VwVkladUN1d3lKRDYxT3M2?=
 =?utf-8?B?a3lEMkN5VnBlRGJkTzYxQjdGbTRmUWhtTTlZUitKWEhqYzNlNHY0ajduamtQ?=
 =?utf-8?B?MmJLUGR3NUI3bzlWWHN3dkZrYzRvaUFHS2pGcjVQcDBYRGdMdXE2c1hmekpD?=
 =?utf-8?B?RGpXdUlEVUtyakxVS1E3RnZIT2RjL0tKWmVBcTFWVnhJU3paMWkwMldEbjZm?=
 =?utf-8?B?eVBSTlBBVFZ5UVRib2JtVXlaRmpHOEFOVTJEMzd2WFJRaGZaQU05S1hhRFlY?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BgsiBgD5eu1V0DVf2I2wT3B0o4ZTZm0MdJ/tSYYDtj0A1FS92Coy3eT1+TmTO90grTTuidrhBahi7tksKbwcm1a8QUP7GbT91HBmkpxjvJarLnweyDS9Y7HaknkK/GjftcSTkIW80f1V+qMPFXkZ/FB0WQewbBC3JBlzaxrqu2oqtT8LGSLCVdIqTY2Ajt66AmQXxLvlGQtebIxVK4bV09ujMDci4/tw2wzFu5k49tubCwj4W6HS5HauSVlm+Z1y/8pI/t38JYhaZTAd+kD3sWgv7X8uOBIS2zRwaNS/rbJavnQ8erobeIzn3GvoDyMIk50fd80Ht5W19r2PyXTtEo/xu+uJP2xnDTAmEP42FVZCYBKzeFRP6qnDnXixZuU9pKW3rUkTf6Z5YsONvnqTdnqU7aIH3QTemgDUPE+fmSwXIH85c6jzBA2h/TXxG8gSqs5mWO7O7jj6TMAK0ADBlz5x1x5aSal46C34Ux3MX/ufi0AcO4P0erq/3I2MlsCQKR2gBpnXveINvu3pkGfG10tt3Y2i7AikjOE/UCkCTUodYsSgKF8QmRW1PUctBY0bisQtFCGGu/3VI3D0C85df42AUE9AIA1sv1zJIarTaIk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f6af72-9170-4a96-307d-08ddecbe8fa7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 20:55:35.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfGJ7wZj4sHj3qc5LRDO3mFtPrNepKERQNN4d8KA0AyLBsNmy4s9uvBiGubOeOLY1viMNhgMe//I22cPEIl+mdJepWd0oTTH7qtaZ2Xd010=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=910 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050206
X-Proofpoint-GUID: ypEejsBic6LBAGIgjp58efpe0dlKdw18
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDIwNSBTYWx0ZWRfX1RLHB6NeIWN0
 lhUvVEieFQwWXMe62+lhmhhCBSmaJGN0NzmyqkxZP+ITK8+9pam/XsLPDl80Gv7nGOWI6CZMhej
 FKp7kmlvBuXWk/IoCM7CkeO2F3eMusuEfRdQxQNV2+khtP1inx4kYRazSiagvzeUH5Lc3nr94vo
 uPQ3B1CcCZvPPSc6/yDn1NvabP0kTzPBZuWp6k9oxeqnbPkN4LW4ES91ZGDELwsxCnaIonx+rUK
 GD7CUNiiF7XFCN3/UfIcVJi2+8DRoyaC1wvk9NHhoKbX6rDQYHtgUoufKum0vd4PuPoJTE9hwpG
 sqwiEtnv+r6qEzgTKS/lUZeH0sIJV7yLLZ9aEZlKCfEtmhjz9s73ZV2r1YkdvvPSYR5rNrVGZvX
 pSx8LtmhFJ6BQkaWfdOfNwy9wVfxGw==
X-Authority-Analysis: v=2.4 cv=E4rNpbdl c=1 sm=1 tr=0 ts=68bb4e4c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NmRLZTjJBxQbIzQ860MA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: ypEejsBic6LBAGIgjp58efpe0dlKdw18



On 9/5/25 4:44 PM, Greg KH wrote:
> On Fri, Sep 05, 2025 at 04:03:40PM -0400, Boris Ostrovsky wrote:
>> Return values of TSA_SQ_NO and TSA_L1_NO bits as set in the kvm_cpu_caps.
>>
>> This fix is stable-only.
> 
> You don't say why :(
> 

I added Fixes tag there. Do you want me to say explicitly that 
c334ae4a545a (which is 5.15.y commit) forgot to do it?

-boris

