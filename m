Return-Path: <stable+bounces-110996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9227CA20F81
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82D57A32DC
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAB1D2F42;
	Tue, 28 Jan 2025 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f1Qm6/F0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IgQGkLWB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1C1AF0B6
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084678; cv=fail; b=AK0JLziu88H87ktIFvhAC1zYmVNkcXi/1GS5mhY2iFqZTX+DDThtg0rW+2OqFFc/goJYZ37Lhz0V9bRZXJzFO3kTY6Eml3OGPFZ7m3eWMyKVSRjuNzrC/CQoUwlqaTPVov6h4jOCzuRcBzdFvOW/LOu8NVvbHMN37Nbp5VJwOiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084678; c=relaxed/simple;
	bh=dzHfQjNesJt7b4x413zktzFycHZmVvvsj85x1px9nVs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SfMKtgVS0rr7SydOsqoyLCAOdXoTZtI/NA3pnG+OQgtFUDQx8FELwXf4rhXXODSJta3yoiPtGiF4gKrCFaGUz/NmuKTLk24jAYGXlvkENUHReT0phpL0MD2cImOr2nRDsGy4wTrsZGqrhrzJXHEGSz6iJiwyH5IScS42OPBOWGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f1Qm6/F0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IgQGkLWB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SGqMHw025001;
	Tue, 28 Jan 2025 17:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dbLf2NrIsvrdYyaq1Qsx+bs088LgJkRSal2NJFOCGek=; b=
	f1Qm6/F0MNOTkH0a09frq4ixoDvHQtEwiZOR2/WTyx1WcF+e+w3PG9a7tXChxmmd
	McRfPDtOO7LqfjsQBf/P+1xJ0XffpRT0xBQWIm6swZ9+tpPxU1udvINHzxqz/cGM
	fG0IOwMR7JQzywJ0r8Wjm6CxK4zqxLmCY0Ih2dE3sNdwaVm9uwjRfpgKTnNc1Ek+
	8BihFL5LH/wsloifqv9f4LdpGgHxUmdFsxSbx+FJa/v7uSy8KkL0FfHLuIoulCjb
	+jbF7sZqmwKPjd8RUvn2n9seMn0LdvuIZYyXdMQCLLMrF7O6c48LOxYzqPo3nCZW
	pmd4gVfeqQH6ysGZwOHr6Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f34q02dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 17:17:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SG2HvE004169;
	Tue, 28 Jan 2025 17:17:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd8q995-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 17:17:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlLjwXl+XJ3LJL6RmZF5eA+NfEsx+J2VAhDvmbDzJnTmKEFt7asesaAYS1r53vzEPPjNg+y1wxQJaabs2rR/Z+/ymamHleTA+bKHTcOWCHfRdwXks/0AVbk0L567HvoGv5Mf+sd5FQjDAt/L32ktQCfPsYL7tPgR3ls4uxcgEvTX1EWd2FaJHsDiJEDMKw3BmfBEsPWcC8inMvp3RcGHJpoQMb6BwGWrYtEMli9pADJFDuDygSduo0UlxqYFb/ed8BctpYyqcaQ8zNPrHR2ND82rMg0BnQEv2Z/2Db2/PpVfRKZ1vtHnEeZ7F48ypqFPCXapNYT/ELiLPPg/omekhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbLf2NrIsvrdYyaq1Qsx+bs088LgJkRSal2NJFOCGek=;
 b=J/TCw0VCVgF06I7icnlazgoQVQs8flC4uFkiO0aQVrAtAvtVnJ3JKYkkqgIb1qA26S3wawsX346Vxj0CK2ONotg97XGREz9djP3Xgwpftw+bbGKiRVA+/4oJxfUVnb0tZfywWRF2I5rzXw4Os3gsODhr3LhqK+9SRhiIS9BCwDwU/5EqlJ71FptwwX55y2YcU5RAtRGdvRULf4OuyTeO0MTOGY2+sJMrogHD/JGbg51eeB++NsI7neD7DvfC41Q1zD7p7WV3waSsPtSPJ7nH9VkT+5cEJsgpLANP0ZtDUdMtWXo3/tovUbYaGaneZhJUzZG3yGk+NBaRF3xznIi12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbLf2NrIsvrdYyaq1Qsx+bs088LgJkRSal2NJFOCGek=;
 b=IgQGkLWB1MtVs9lBfLzXHW51SISbcUskDAHeLyBsXDEktUqL2/22LA1NcbUu0cYBjOdPlGh2mUAlKfXEHvbeF2hhp16urPkGtrNB+N0OueQIpQFETjF2dOu6a/ghkx1mFI4a0myXovJlSQy8z81fNKMDUjN6/m310BLRQShgKhY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.22; Tue, 28 Jan 2025 17:17:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 17:17:36 +0000
Message-ID: <be95b807-dfab-4a4f-9e00-b498e548361f@oracle.com>
Date: Tue, 28 Jan 2025 12:17:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
To: Greg KH <greg@kroah.com>, ciprietti@google.com
Cc: stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Christian Brauner <brauner@kernel.org>
References: <20250128150322.2242111-1-ciprietti@google.com>
 <2025012815-talisman-ageless-45f9@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025012815-talisman-ageless-45f9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:610:38::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e823d04-d754-4bf3-2061-08dd3fbfa8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDh4bndOcnlVUVZXYUNOcmtscTVrT2ZXeW95bStIanJ4Ynp5QjQ5aW1DNUpv?=
 =?utf-8?B?ckYyV1IwTDVqdTRhM21wZlRiNzhqQnBqbzh3Q2xxcmdoTEN4MWw0V2YwZmth?=
 =?utf-8?B?aldzZk9MTVpxZ0k5ZU5Yd294NlA3eGo2cjVVVWYzMjd4WXNENEVNeHYxbmU4?=
 =?utf-8?B?bTRZNVlsbnk4d2hCWXIzY0cwNlVuWEhJNUc2V3prdW94N2N0TGIzelU0cVNE?=
 =?utf-8?B?c2JIUmMzK3ZrUU1STkM3R0pXTFpmcWdJcjVmaEJ5anhQdGU1ckZOeE5UTlhK?=
 =?utf-8?B?cHl2alQrS1VsdWw4SmlzTTZXUSs3ODR5MVl0WVRsd3F3bWxDeXhHTTFmczli?=
 =?utf-8?B?eXkwcG5LMTJ6bFJieFNaNVlEbHRQSG5GU2xTUkVXbG5sRllhMzJHU0Ztc2cx?=
 =?utf-8?B?b09Udkh4Njd6NGpKb3hiNWd0WFlHQUM3anc1ZFM3M0JMWS9SZ0pEclhaL01a?=
 =?utf-8?B?cjlYMFVWQ2VDbktXSk9jaFVGaUtYUkZFc0dVajNoODVqUUd1cjViRW5UaWVk?=
 =?utf-8?B?dG0xSGRzamxaMEZQMmV6QXNwWTVSNnRvejh6YkprVWlpY1V2b1BzSlgzU2tm?=
 =?utf-8?B?L0ZsTnMvMnZucmdWUkE4dmYxeThlVDk4Y1RTSlRkWDBaMXZaTUhSRjVMRkZq?=
 =?utf-8?B?d1NIYjlPLzI3L2hEclZZcEtHTExmSGZQY3RNcm90NC9SK1laWjZTakpDa3o3?=
 =?utf-8?B?MXpQK3EzZ3J3NUpNSFVNeGFCaWhDY2o2SElPdHI2aGxFdzd1NUJTcVBrZHpJ?=
 =?utf-8?B?WXgzOWxoZGYvQmV2MUw0VUVOYlByT0dRZHB6bnJObVlTYnVXa0U2VUREVjFX?=
 =?utf-8?B?UWNsV2hCOS9WTWtkdmxpQUx5dlhaeU16L3g1cjZXS1N5MEwrOTZka09KMnd5?=
 =?utf-8?B?WG1CNDJFV3ZrSlNLSy9Ja3h2YkpNS0d2aG9DM2dGanVTSVNiQjJVS3hiazJo?=
 =?utf-8?B?ZWgyU1FMZHlRZjhPZTlzN2pWUXR1Mk0wZnZCK1BLU0R0SVNVaXViU3doYVI1?=
 =?utf-8?B?TnlxM0tKa0R2SDhpRVE4eTFSWk5VZzJpSzV3QzlTNmF4eDZFTXdCZWFZSFFO?=
 =?utf-8?B?b3RRTnRLeDdOWGVvVGRMMktBOFpOZk0yNkNYSngzUzN4SWlJRW94cGVYQk12?=
 =?utf-8?B?cThJNU5nMTdSMDM2Q09KNENTeE1KZ3NvWnBBRVgxZDZsUlU1VWlTSE5Ia1Rk?=
 =?utf-8?B?T1ZwWHpDWFRGaDRMb3lqS0t4TlBSdjR2aGhiNkpwNllkOXBNaHBDZGxaVFNy?=
 =?utf-8?B?ZDJGQWxLeWszUGxaOG1UUFBocmtTZm9XK3RFaTViSFVDLzVmMzZ3ZVJWTmRS?=
 =?utf-8?B?b0hjVTI3Z3ZLNVZ1ZE1XbGt4YjN5bmpXcytVb0cxbkgwSWJ1UVh1Vm1wR2U2?=
 =?utf-8?B?dFdwcGQyQVJoVmliNmVndGFVUHRUTXVkeThUQUswa0tuUWlKcHBMRlh2VUJN?=
 =?utf-8?B?aHZ6UDl6Y04zNExRTktmTkplMFpld09LaGFuVEt3dnh5VnNHV3ExaDZEUjlK?=
 =?utf-8?B?SUV0L1JNRFpFVjdpSFlTY0M0NUFrSFJraEtBZkVjb2xtMnpRNVNXNEpmUkhj?=
 =?utf-8?B?R2lLOWxpY0MrYXQzSWx4S0xmQjIzRGo3VWdMNFJMNEwwQVRtblVnVzQzZzRU?=
 =?utf-8?B?eFVXUUUvK1ZrVzk1WW90d3V0Z3JqaDRKdzArbHpqYTlUMjI1cHhmeGxKdGpt?=
 =?utf-8?B?SlcyUC9ad1FlaURwM0pmUmJzOENDbU1rbnBUYmJkcStEczVhYVhQT3lXRUI4?=
 =?utf-8?B?RFd4NUdsbHhWV3djTHVqTmxxYXphdlcvNG1BWU9uczNNbWhxYmZPM0hOK2t6?=
 =?utf-8?B?c2V3UWpyaVV5TDJNTjcrT09ZVFRTdmx6M2RpcjJkSFNYYmVBbjRNWFhmQXFW?=
 =?utf-8?B?UHdrSTRaTlRCRFJRa0VnTXg5MW1XU0xXKzNOaGJSWGt6akE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0NmaWZsR05JNDgzZkR1TmlnbFY1UW1UUkJzc2tPTGxTYUtsOEZGbTY4M2k2?=
 =?utf-8?B?cjZsVVdBaVVPMUpKSjFrenZzL3dMU3pocVJCZzBrN1d5bkhlY3BMN3VxVnhV?=
 =?utf-8?B?OXNaTlJTN2xWU0F0aFRmalhOL0t3RXZFd1YvS2NrWnloYVdqbVNVYlJnd0ta?=
 =?utf-8?B?QUxRekZmVTV4MnNrWEJJVEhTSzhlcEZYeHR5U2FsdlJrZ0h2aURrSmZhQWpj?=
 =?utf-8?B?ZzN6dmpNRUR4VkhmK25hZkxQekc5OXJJREhwRkpVSFd2T0lWNzQwM2lZZU5a?=
 =?utf-8?B?SWdKRWtDbnlMZ2NxZmNwUzJtOEsycWRYdDVFOWt5Uk9oQXoyS0xDY1I5OEZa?=
 =?utf-8?B?S0Z4VG1pY1N6WTJGZkxZUGxQN0lueVpYZXF2VVh5MU1vTkNpOWdXM0FYbHdJ?=
 =?utf-8?B?ZzJxaEl5eTNyOVdLK1YxenROR0wzNXR6dGloTUh1SFNzREk2YkVSRElqWDJs?=
 =?utf-8?B?aVozS0dvcE1hTW1GSWVvNXdUQlhMek1ja2JjclVFM2JqV2lRMisydVpmMGJt?=
 =?utf-8?B?YzRYQmh0dHplVUk4dEZlS1E3Q2piRUVWalBhK21yaFMzRStlazlUUE9pM2tz?=
 =?utf-8?B?M3VjaGZKanBaTkw0cm92R1ZmODNHRXl2VnZvemUwNlFvc2gxc1A5YmtJamRr?=
 =?utf-8?B?azdxZUZoUGJyKzlmZDUxdUFsWHFYdlVxRXZrYndnK3NXNkNZNWh2eThoUmVL?=
 =?utf-8?B?THdVVUd1cW5ta0NRTlpoazNReGtCQlZKZjNWNmlqdDhKZFc5TmxuS0YwbGF0?=
 =?utf-8?B?ekZwQ041SGpieU1ROCtZKzBDYnF0LzRRTW9SWDF5OGxTbmx2VzRqL2ZLZzcr?=
 =?utf-8?B?OXZSdXZXZGMydkIrbjhwSlJsLzJSZ3Z3S2JnU0J0N0thVlJCbzl0OFRLS1du?=
 =?utf-8?B?Vk83TWloMjZ6dzJSVThRQVp0RXBIMkJjTkdobUZPN0hJeEV4RkxEUFd2TXJq?=
 =?utf-8?B?cEt1bnM3MzQ1c3VEVzh1YURnMXV3WlVPVDU0TWVhRXVjZkpsSlVZWnp0V2tl?=
 =?utf-8?B?RXhlbUdSbEVkVHlNK2RCRVMzWlo2YzUxWUhVbnNJdmpBOVFBV0N5d0hnVGJx?=
 =?utf-8?B?OVRaRGdmb0I5dzF4UkQzcCtyQWZWZzEwTDFCVS9zeVZTMzRyS1lLMmJ5N0Yx?=
 =?utf-8?B?ZEsvSVNDZ0JsaThtL2oyTUQ0azYxOS9vWUV1VmNIUk1RVDhCWkJJd29rSXhQ?=
 =?utf-8?B?RXFkL1dPZkU3T1NPYnNoK3F6U3ZrSkJ0WGFuRU5qMDRBU0JHSFhac1QrclpH?=
 =?utf-8?B?bk41aG1JZkRvYkMveDVCTE9ZeTVSY1QvMDcwcEFEZ0YzSitERUdsY3VhVEJt?=
 =?utf-8?B?OWczM0xxOWdxcHpsRVVDdC9GMnZsZHg1QmxKMWU1c0JkK0NMaTl5akE5dEVO?=
 =?utf-8?B?NnhxMEp3YkRwVURWVGZuaTJ5UjJvWGIzRG1qR2NPaDQ4N2J5eUxPakNYT0VK?=
 =?utf-8?B?ZlZVTDF0Z1hvZHV6SnorVHlxL1pCMEQwUGRlODdtcFpkcGVEZkZDb3VNN080?=
 =?utf-8?B?MVJRNmUvNVNGakhrY1VTbndFZXJKWmpiam96U2NacytJcG9iUVFmZ0ZCSE4r?=
 =?utf-8?B?WFdlV0s4NmRTd21MRFJEUDIvRU9UWkllVC93ZlczUldaK29LSUN0SkZDRUNv?=
 =?utf-8?B?d3ZjeGZPVXhVUjl3QlNzNEdybHJhRG9URTVZNk1LWlluTVdlK1p1YSs2cmFD?=
 =?utf-8?B?RklqTFFHZFNvKzM0ZC9pcUwrMVpoa2FVdGlEZGQyOTlaREVyNzBXVHM4UWdk?=
 =?utf-8?B?em9oTnVsNVN4a21ON1RLVENPQVFKZzNid2oxMGVlbkxZOS9JTU92ZGVuS05M?=
 =?utf-8?B?T2h4V0tsOUZtRXJoSGczZGRIQks5aVNMcndaQ0E1ZmNabm5FbDB2QldnZUpr?=
 =?utf-8?B?Tkw0NTJuSTVlTWxPbndtNUF6MVZIOU5aeVBJam96bWRvQm5OcUtOb2JvTzZO?=
 =?utf-8?B?cUhYbUxtUEpuTkRtdEYrNXQydWQyUDdlYTZBcTdaT3dTQ0NoaUxSNUJST2U3?=
 =?utf-8?B?c016ZUpuQjVPMXlEUXZLQkhQakFlcytiaHZSbWdtOTFsUGh5VndTSDI3clNK?=
 =?utf-8?B?aWZodlR3OHJtdCs3Y05DMDFrZkp5WXRpU2lWYVRuR3BOaTU5Umw0ZkNRWFFU?=
 =?utf-8?B?VUFPTUR0Y0lSYlQ3N0Y2UDI1OGdKei9mcHpJYTdvRGt5a1loekZobUViR21L?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sMzvNRX8BKp48ChLg0AXuEFD+H26rz/tK2LYF6e8cT0VX3unWAedBu7QMJJbxotsDAj4iQOThKDgFYb8fCGhHT7akGaGg0NM69XYh7mLZaDrlCzinDECKIK+ae6+l9icOEFdFkv6GWebfss+35JoxvF0QxDFNfYSDQPMsEjhDGBVbGaomtzAFI4ZEovzCKtUs+fkVIAT15UmNwFwoqaA/AYRAV1u01EVA7JP625xP/q25NEVTYKxzfXvhOOBmjyzSwN6an+7bpT/HIxjfPAFWpxHQcXI9Kl8CPzeO9DW0Xgbxonj5gDctl3yRBLA0QCadU+1GUGBzerCCpT266zKxjkkvi5k4AJADA5/D2afv3mRzaCxkQuaGEygeVTKe8Lod9iv23BeXEyes/T4qTm0ytmjR2WVwPs0Dr4ZxcNxD7McxO808Rox0QbjdiTeC/ymAu1WForBfzvWj/t57z7kd+FALLbN7DSHFzsSMuB9cM/dLm4age0MAotgu059PLSiY67qthJ64LvbgZe9w00IdX5pII3k+nLyAPsNSKD2vazU1wTfi4fLCW5OE9XKL2wuKPu9AQVqdQFfp2QqjTK1Xzdu0gSIR4mlI05M9LHAxSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e823d04-d754-4bf3-2061-08dd3fbfa8fa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 17:17:36.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7dXzy6d0CMwpI2FA+ukLZdjGIDwsGamymFg4+ySC8IGSyobAxPWVgYhDmNoWPBTw0XTi75uHq1+ortlXttdPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501280126
X-Proofpoint-ORIG-GUID: BLsp6ZQEzTf9s9_r08U-OGvY7xfWju0R
X-Proofpoint-GUID: BLsp6ZQEzTf9s9_r08U-OGvY7xfWju0R

On 1/28/25 12:12 PM, Greg KH wrote:
> On Tue, Jan 28, 2025 at 03:03:22PM +0000, ciprietti@google.com wrote:
>> From: yangerkun <yangerkun@huawei.com>
>>
>> [ Upstream commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a ]
>>
>> After we switch tmpfs dir operations from simple_dir_operations to
>> simple_offset_dir_operations, every rename happened will fill new dentry
>> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
>> key starting with octx->newx_offset, and then set newx_offset equals to
>> free key + 1. This will lead to infinite readdir combine with rename
>> happened at the same time, which fail generic/736 in xfstests(detail show
>> as below).
>>
>> 1. create 5000 files(1 2 3...) under one dir
>> 2. call readdir(man 3 readdir) once, and get one entry
>> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
>> 4. loop 2~3, until readdir return nothing or we loop too many
>>     times(tmpfs break test with the second condition)
>>
>> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
>> directory reads") to fix it, record the last_index when we open dir, and
>> do not emit the entry which index >= last_index. The file->private_data
>> now used in offset dir can use directly to do this, and we also update
>> the last_index when we llseek the dir file.
>>
>> Fixes: a2e459555c5f ("shmem: stable directory offsets")
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> Link: https://lore.kernel.org/r/20240731043835.1828697-1-yangerkun@huawei.com
>> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>> [brauner: only update last_index after seek when offset is zero like Jan suggested]
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Andrea Ciprietti <ciprietti@google.com>
>> ---
>>   fs/libfs.c | 39 ++++++++++++++++++++++++++++-----------
>>   1 file changed, 28 insertions(+), 11 deletions(-)
> 
> No hint as to what kernel tree(s) this is for?
> 

Just to be absolutely clear: NAK - there are some problems already
reported with this patch upstream.

We have a patch series pending that addresses this issue in v6.6:

https://lore.kernel.org/linux-fsdevel/20250124191946.22308-1-cel@kernel.org/

-- 
Chuck Lever

