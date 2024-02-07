Return-Path: <stable+bounces-19073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D193384CA1E
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 13:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543921F27D37
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A659176;
	Wed,  7 Feb 2024 12:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dcvnbCop";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iLE67pFP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41E95A0E9
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307328; cv=fail; b=u/is6UClzeAXnLMTLCk2oUkGPDI97odGp4E352QpFu3rK1rl0yKmpWhQBxoJgN8yAlRH4edEfNmEgLn5hxMZs8wic39UGbV8F52gBcsp7SCJbF+3JXCXx8HuFMAg0wbixqIeEZl977q5BzJEOt1q+AkF3/h+mLfrrMvHpPD8Ido=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307328; c=relaxed/simple;
	bh=qaGyMuuAVmLuoW7tVYYrN7a5hOurf8SJtNnSPWnOMWk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CGc0KXS65HEDJnuB6JXEBElgvfISEPREBbuVphNFwo/ymSKNB+21ygrf/v4hIwkxzpkSZp3vxcrSNxBw8kVbIWxs6VIre/n2J1pKE0wiN8huWLyzgc/XMPgrGW3DhkvXLUrNr7h+ys4JYQeLLk67AYTG+e61NE4/FhxjAnvKb8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dcvnbCop; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iLE67pFP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417AEAbh022583;
	Wed, 7 Feb 2024 12:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Btsr7ez8mXfs3SJr4cyBJmEdcGxfKWBL6PaPO8APrBU=;
 b=dcvnbCopvWv5oar67tXtqfKmaawY3/K17OWsOXAqsfL5xEsHhCqtEQhgpzno6DzZwVrP
 MRWB2FWYI9/z2fpAGBalSEG3dQ/KYWAmctsRPqa5ONM80Ai50gXCCeN+69LuxuwVJE5G
 70f309Xv2Z2lMh2AyWCkWM2QT2NP7LkHgCsJZp+GMlTASDpHdcrNTZl+80sAb10pROpy
 VLo/pNW3znB7CnQQxVabeqr4UMzVetsmHP/pbQD69jVnbXKzuCyGUkMdu2f9EdbBOAZn
 9PfGPbIDoPY9buVvrd1jesFU7pB+1LjZReuMB+7Q4hE9Ayni/Ce6vZya7LE5YHe/Flo8 aQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c941nge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 12:01:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417ApRd1039463;
	Wed, 7 Feb 2024 12:01:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx8msyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 12:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go406M3XOP3DaZyIk1ifOYGBRP9r7lYw8Vm2mscCbLouh1qPdgQzsyMnpQlLHr5WWVXVtZbAqdToUjQ66+1/6qk4lLRs+EL5PPQ5yJStqVzsxZ/60hQq7v2Q8Isa6BliOfRABeZum8X7ZXNW03Lfjitr/wArTDtauwuF6NKUoVc/DxJwV/nzVLxgNzkSiMU82aDmEwsNqqyrtlAvON4vN3YNs97VseIwUO7n/nLBsmbE5pfj5rO58Drf6yFkwOrrgjCEpQvCQSUG+bpesHmOWSYz1IzB5J3gfGwfkPfwnuYS8Mco7klulsoT9phsgO8auZhSEjXYlowapg/9oBBdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Btsr7ez8mXfs3SJr4cyBJmEdcGxfKWBL6PaPO8APrBU=;
 b=FA9BTLEJDSQeUP1+ppl8T3VUjBCVugHAmbmOkltuZmwrWVqtEUDZrHM8njEr6pm1yDqfNslt35sLDEZm6SqPjHOgQjmkO+dC0PyEtGolHPp3smo4t25pfi+MkMwFjr+fhDjq0F6rRjaoNaDnFhM8K+wZltGH5skgSA7cmPNRaC4kmLx9b19MGf0Xhw+OabsZJZIl4CVtg1SKeGXzi/l8U7ELcPhXFhp9VDnXEe41bYrgfx8gYBYVgSa7g92v2F4S6Ff7C/0XhNdmN2Pa8tlKnXK5rqg/zAuhLBn6ISQMctTx4gZt090TYoiRaG7wFEykUKDAm3lrdNJq0ikeJIrfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Btsr7ez8mXfs3SJr4cyBJmEdcGxfKWBL6PaPO8APrBU=;
 b=iLE67pFPyiH60A+WxBaEtIrC8RMHBll36FppEVQes0GIShxwePGIMO+7aD+ecySdtWbLInNJaomOIgvlWQXO0APL8SKnwb6/9uewlYxQlUDwW1C1jnmuVTuQJDdiMSjJ0iynnigvWXS3dRwhNU1AVIXx3gfVJh87Mdmn0KYlzg8=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ2PR10MB7600.namprd10.prod.outlook.com (2603:10b6:a03:543::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 12:01:43 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 12:01:42 +0000
Message-ID: <c4c2f990-20cf-4126-95bd-d14c58e85042@oracle.com>
Date: Wed, 7 Feb 2024 17:31:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 1/1] cifs: Fix stack-out-of-bounds in
 smb2_set_next_command()
Content-Language: en-US
To: ZhaoLong Wang <wangzhaolong1@huawei.com>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sfrench@samba.org, kovalev@altlinux.org,
        "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240207114743.2209367-1-wangzhaolong1@huawei.com>
 <20240207114743.2209367-2-wangzhaolong1@huawei.com>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240207114743.2209367-2-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0043.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ2PR10MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: f3963ffb-370c-4d91-5bf1-08dc27d48cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UXFlWzmUladwyG3T81XjjKURxNq1NEWynRYC7ziiRabynoPll6qFL53uP+d6lRyfyu+Ssr3dTM+D4rzLSzqZcIQShUpyqznRU2Zbg2CBcSpP/IzdkiL8F0/HpfgIQV2z8p/z1P2BJ5L2Y70GOpjlCtKOoYvVya5Q8oDbuUY7Bk9bxHtwSZZecAtSxpttNBYhQ1OxFdxdldGxqn3nGE3NzMu3Qic+lwjICCdOn1VrQXydxEzqN4cJXRlOZ+rfEVGpadrH07AJu+KzsYMo+JUJlBX331ri5CFpcxeF8M661GcRerg97ao0Y5gbVRNmo3Eq+4nQoKOl2wEENUQE7kCuzJKUU3CGqZ7s1cdC3l3w6VU2eoAnnkkX3vGQohD4UHjdI0lPScOQksd7iskBSq4PQFyiYUX7Gu+8pLYZI9PtBYOYLny0QbcgOS5Gaq8DSl2dmNRXA6ZzamxSyBcIlcoQ96/emX+kekOOHFjZ7pNsGw+eOoqMQout2RQm0y/geb997TdC/wUSXvigLzf69Vt/KoHmm/6vqDmQaCVrbxS7PgHNaPRzI2QYnD+cLFyucqxZHP553/EId3ju9yrS4C9T5veC7vJKWKtxllV54Tp3IpXg+5+0/rWHSBmOCziwFWKsWFv6taIMx3BBLnpz3vY5xMrKmdHfKutPEDEK80D39HM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(31686004)(2906002)(38100700002)(41300700001)(66476007)(66946007)(54906003)(66556008)(316002)(26005)(8676002)(4326008)(8936002)(86362001)(31696002)(6506007)(6512007)(53546011)(2616005)(6666004)(5660300002)(107886003)(478600001)(6486002)(36756003)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VzJrOXJMdGdDdndMak5XN08rRzRIc0RrSm91VzZRRWkxM284TlNkdVljU3Vu?=
 =?utf-8?B?UzRpVjdvV01GcnBnSENwYU5NbC81TU5OY0ZIeENjTmJJMkR2SlM2YzJKd3Fx?=
 =?utf-8?B?SlFMTzR6WnM3dUF4ZXF2THNWWnhQKzlkVE5EdzdPazlqRklMd2Y4MEQ3ejBx?=
 =?utf-8?B?T2JNbG03c1lqNGVWT2ZRVG5vTEJhRXBEWVducmo5ZEFMS1pQZklpRmNlYzBp?=
 =?utf-8?B?N2MvOTJGRjRldjZHMkFGUnBBdGl1L1dMeDBHYjJpbDI2L1hzdDFOSHFxRmtL?=
 =?utf-8?B?RERvbVhWTW9teU4ySXE0OTZmVEpkaEpCRTlxRnhlUTJXTnBmYU1YN2ExQnhC?=
 =?utf-8?B?Z095VkpaSTVWWWNSelVpQk5hcmpyOXNOclR6V2RNd3ZubHVoTFAxNnpOZjZF?=
 =?utf-8?B?WmI1a3B2MlUzZUJoTjJFMU1VYVFTNjdoUFpnaW9QeEZtci85ZC9TVlAwS1k0?=
 =?utf-8?B?cVR5elJuS0tGVHE0UHJaMC9OTmwrSy96NFh3WU9OeW1XcHpSd3ZyRWFmeEFU?=
 =?utf-8?B?TCs3YWs2N3hCTEc2S3VieGJBSmpzTThFTmtLMDUrQ0VrL3ZtbnZrM2dIdlBo?=
 =?utf-8?B?QkVIbFN5d01xczV3QmhDaHozU0g0U0k5bVF1cEpibk9BMURFSEFmNVhuLzRi?=
 =?utf-8?B?NUl2bnVIdGlwenhUMklNanM1Nks2OWx3MTMwZUpVeTN3UWhGK2JYZVF0WHYy?=
 =?utf-8?B?c3FSR29QUDNNK1o4N0hsL2R1MjhreGdoY2MyeTBTTmpEUmxxM082ZVdWcEgy?=
 =?utf-8?B?VngxTzJDNmdmajJZZ3ZYKzM3eTNNVURMK3dsK3ptNFBqYWY0Vlh4NjJEQ1Ba?=
 =?utf-8?B?VUE4c0lXdUVJMFdCS05zU09LODlhTlpUc3NZWVJleForSTBTdzNxQ2QwRFBJ?=
 =?utf-8?B?TENBSDFKMytDYmxTWHIwVkE3dzc0Z3I4MjNacUxrcUpoaTQrelF5RFloUzZq?=
 =?utf-8?B?dktmdTh2eHNPd1NGUU5QeWpBOGFETVlrbUllR0Rvbmp3dGRnTjNGSCtRM3I5?=
 =?utf-8?B?N015T2NFSnAvaS9xNzBhUmhjczk0MW1ZV1pIcm02VTlWU0VHMnFFdWRTZDFT?=
 =?utf-8?B?ZDZaQnk2Uk9DM0V2ZHJWTkRDaUNlb0ZoaHQ3NC81eU5CU3ovWE1oWTBsT0Jq?=
 =?utf-8?B?Z2x0Si9NR2J1eVBnYWJlWTRHc2FHbnNMYmE1ZW5iTjFCb2JLMU9pWUN1aW9C?=
 =?utf-8?B?SG9CVVpPTk52ZnVOOG55R29WT0g3RlE0RTF2ejc2UGNzK0ZJWjFkVThlMUdC?=
 =?utf-8?B?TDBXdXVDaVBraTVQaEc1dkllNytaSUY3Z2g4Rkw3Wi85M25sS21Namd3K0xL?=
 =?utf-8?B?RitxM2JUa2E3L2VhcDFLQWxWdVI2dmorUmtjYkJFWDY2c09GWFAwaUNia2xN?=
 =?utf-8?B?V2pzdXlGQVh3VWhQb1RVMXVKN0hnU3Q2S1B4UG1qTUhPa3B2Mi9xb0EwZFZn?=
 =?utf-8?B?WjFMY0JMczRpOWdhYUtjRkFLYVA1ZVhCL28zSjR5R0N6RU5PbnIreTBtMHRE?=
 =?utf-8?B?KzltSzFSNWs1dmQ5UmIvS0k1dUJDQk5zUDFvRzRycVEySmdhbnpldStOK25D?=
 =?utf-8?B?dlpYS2h4bzYxMUo5cXArb2wzUlFNOElNcFNmNlV0R3dzMmFSOVBsNERZZEtR?=
 =?utf-8?B?N1pOaHloaUJPZ1FyOHk3aWZyS1NSamt4NEs4d290b21Ja29xOU5VekpxL0hW?=
 =?utf-8?B?MGVSSHRORjRVaHkyOXRVOW1qblpaL0JTRVBUVTYzZ3Z3T1piVlBBYlNvRXl3?=
 =?utf-8?B?QUVZZ2txK0wwek5tbFd5dkp3MkFIVWtyL0JINzh0TmNiK1BJTnlTbTMwVkNm?=
 =?utf-8?B?dlB5TEo1RlEzTEFRNlFkZHdwZ296aWVMbmNueFl6NHU5SW93RDRKY0FFZ0Rl?=
 =?utf-8?B?TGl5WVZWS0JqVlExQWJBcG4wRys1OVMzem9lS2c5eExIY0JRZXlaci80c3Fj?=
 =?utf-8?B?RjRLUzZVTnJWWEtqYUNpZEZSSS9IdlRoQkZpMC9QK3oySXN0QnJaNThMZ3Vv?=
 =?utf-8?B?dU1TMkFGaGlDMWNUbTNDbUcxMURjajU4Q1czTW5VRWYzTDFqRUtZZVJhdmND?=
 =?utf-8?B?Yy9zbk9RYUJlSkxmOWlyTmNIRG1CMUVDYkc4eXR5RGU2NmN5VGQ3a0laZ3lj?=
 =?utf-8?B?amJoalFjTi9uSXZvc1UzeTBQaW15YUtPOGNjVUVSUktxZGRqTWhGcHlQak5u?=
 =?utf-8?Q?JUIgl8qxnJgwpW9ZF0/JmSg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WrvY5dglBqmt32TkeSWrRpc3hcpxYqJBr2HdDNoR0Uog0f7JEAx+2kMm69gL6U+arMv+TX4TRvJR49+4p0lDjtPxVYOytFMmDeTBEVMxBpDAyMn3UB2rnRV5rs4Z9hq2DzMmP7AESYaz8naxUdeWeBVWVmYYLpLQ9lbvQMbtLhzjMtob23+HwW0qEk4R0vZ54MlioOUoIa124Na9rZ6ziQPbF110DYbNTyFvDbMWbjBCY0sF/fhkOleUULHmlzDH+TGmDw5mNKSV0yy6hbQ2qyhcTcjQVZSq8/FlTEb/cAMmt5sL9b5QZhdD8k586BPd0r3exzKRlS06hvho76qsdzZ3gPzcKlCyg1H1mHD+KPJFAeQLJt35ETnwGyoUPRSO0AXoen08FtYLPjqxl5+vyo1zFz/RAkJhfHskodBZj9LUMqcmTNug/5MgbWZQOlOSB698KiBz6+Ceg3XcT/vkzwRRBl7s7sPJTzrcJh/aHpp8osl0w1TjKgKdurv9wanQbmcHa0dRMiYxI1X3dxPWUjDRLYal9wZSrymQDjkmF8UmcF5SvzHfCczPqQ89IRmzxeefEiiiywqyDDi6Aqp5pDT28WTOJZSbx6R4uguFic4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3963ffb-370c-4d91-5bf1-08dc27d48cb1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:01:42.8996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7NvGtumddnh50iu2kdcyeYoat1F6qgxy1U5UUQnvM9DO21i+ZzxDZw4jO9KFwLec92EkY20mtNXNVscyi1E7HZczlxGv8qOpVm8AZ4hmwTdIjkSDSOVNoMxsDM3GQz4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402070089
X-Proofpoint-ORIG-GUID: 6tbAKVnhcXFtTTxb6wEQRGUveFeX8g-m
X-Proofpoint-GUID: 6tbAKVnhcXFtTTxb6wEQRGUveFeX8g-m

Hi ZhaoLong,

+CC Kovalev, Mohamed (who also worked on this issue)

On 07/02/24 5:17 pm, ZhaoLong Wang wrote:
> After backporting the mainline commit 33eae65c6f49 ("smb: client: fix
> OOB in SMB2_query_info_init()") to the linux-5.10.y stable branch,
> an issue arose where the cifs statfs system call failed, resulting in:
> 
>    $ df /mnt
>    df: /mnt: Resource temporarily unavailable
> 
This is true but there are other backporting efforts on this and 5.15.y

The latest is to backport eb3e28c1e89b ("smb3: Replace smb2pdu 1-element 
arrays with flex-arrays") to 5.15.y and pull out a similar one liner fix 
out of the stable-queue from 5.15.-stable queue and 5.10.stable-queue

Reference threads:
1. 
https://lore.kernel.org/all/7903fc0a-d0c5-20bf-20cc-d9f092e5c498@basealt.ru/

2. https://lore.kernel.org/all/20240206161111.454699-1-kovalev@altlinux.org/

Applying Kovalev's recent backport[2] most likely will fix this issue.

Thanks,
Harshit
> KASAN also reported a stack-out-of-bounds error as follows:
> 
>   ==================================================================
>   BUG: KASAN: stack-out-of-bounds in smb2_set_next_command+0x247/0x280
>   [cifs]
>   Write of size 8 at addr ffff8881073ef830 by task df/533
> 

