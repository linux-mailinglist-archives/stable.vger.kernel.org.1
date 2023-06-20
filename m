Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8568373746A
	for <lists+stable@lfdr.de>; Tue, 20 Jun 2023 20:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFTSgh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 20 Jun 2023 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFTSgg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Jun 2023 14:36:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BFF10D0
        for <stable@vger.kernel.org>; Tue, 20 Jun 2023 11:36:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGDsUM032732;
        Tue, 20 Jun 2023 18:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uo+3eompHd56nRlmF3oCb+9lpMwWgczkYXf6vY7MDpk=;
 b=2717884lfnggSlIh0+iWmf7icQ2+IHu06lPrSVOJDUcFFGmDQ8ba/SiQZ4wpYNupYnEU
 ZxCs2ZXWJ14Gvv626LK6FJHvVpUY5j3r8+Jx9gjrx997Yc9YrIJCH3g84dVNA26O32Jl
 ObmykrS9rnGc2De3hVMi+O0L81ZEam7brvH74Asg8kH9wIO0yaZGQamnvq5zuL/SvesG
 8lpPD6zpRTYwnUwmkO9E9jzRAgjXNAKzRnLDrshxzjWjcMu1Dgw4u9u6Jmg0Dg2E6oij
 6OiMPbL2/yexHvtJvxrFY9zqBt9ZgdoqU9tC/Jc4s4U5l4YW2xO7yR4wkOF/jqzIocBH Sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcnkhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 18:36:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGtgRI005858;
        Tue, 20 Jun 2023 18:36:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394rqv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 18:36:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0wZhGPbsFjgbgpspgEoql1thBAi9/ef2pR6SFdt424uk6HBRsyZk7oPTTxA7HDAB5KFnW1/6INHPDUuOsKBfDgmWiER/E0mSNRLV1T6heZfKMeXues/5wJMzQfzgiEKkvQ3/keP53IE3NgXfzuXVeqvMeCA/QDGThNEgWQxiVnOw3q0ejYurZxlUw+38o+fE2S6vNPjt7FrQ0AuTLrddmGvIVfBA9xAyEMluI/hEdVaU3usJeRONTSTDs5fr6uxll0HRGVz7xkR+eiV+xwT6soQ94TuXT0WCo2oEwQXxS1SIkWVX2g08/tawZPwjMOkQOFeVnubUkZpNlFktrhizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo+3eompHd56nRlmF3oCb+9lpMwWgczkYXf6vY7MDpk=;
 b=ntprFSTq3OaZyaxiqE/4o6AJvM5RQzOBXcbpYQ5TGJxqvpiYJzpL5FsMlG6moWkDCo9fzcOa/wbe1Hr0C8h98mkBljwcrzD51iXlVP90MqcaROOGlx94vus6i32wWHf3f8/7l1wY6jtu2Zcr5yA/cI83MpzJz+t1OrfTOoyrpsAeg0bFVBjgoPhXuagA0IWAIrUFaeGtyzSPGt53m0ynoxJ9OIz/x2lmlTejpfXNnubuCkXlCVNepripLC97WdR0tj8+Afrm3pyWFPTb2N2HQLICa8G9Y+OO9JCAUpGsCsK+QKU3bOPAzMFcdcR/Wl2ss2botxR3kD9b92jPT2colQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uo+3eompHd56nRlmF3oCb+9lpMwWgczkYXf6vY7MDpk=;
 b=d5DAg0TFiHwCx+xogg6pSASS8MEub9of95T7vY+kIYasEcqg4/jfDM70I0sGgo9G7uSfOKDkB+6cNzdBfMisPSlhYy+GevAJ4JVbW4gjeE7z0wOehwpQ3BRjfZp3aM3/lkWE9EIH9EGXf7ELswSSg1perqGM7XIpNY/IEDWjyEw=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Tue, 20 Jun
 2023 18:36:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a81e:2d31:5c2d:829]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::a81e:2d31:5c2d:829%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 18:36:18 +0000
Message-ID: <ce871e44-cd07-9f6f-8668-7ebe503b470a@oracle.com>
Date:   Tue, 20 Jun 2023 11:36:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [5.15-stable PATCH 0/2] Copy-on-write hwpoison recovery
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, tony.luck@intel.com,
        dan.j.williams@intel.com, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, glider@google.com
References: <20230615015255.1260473-1-jane.chu@oracle.com>
 <2023061926-copied-glowworm-8cee@gregkh>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <2023061926-copied-glowworm-8cee@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0076.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::17) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|DM4PR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ef69c39-bdfc-41c0-0ceb-08db71bd3c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrT4bY9BVgeaI9yQ/Twy0YAOtBLz6GFCDaivjEvqFdZXPabKHzANbOI6ZYj/y+1A8TXQ/nukuGAVWx+940LL1pv41X9K2KMRKVNBfEX9HazSw0TpsplKjgGy0J3tkvUaYYW1HRNDOlPxQblTJvL6xIZPpQrvfDAHxKMYGKVf94P4HopW2RENPtt8V1QWoJI9zVQNAT4UCgwq4L0zPmX+Ftr4d9ky5T0IvOyvVY2IF/q7+sRuvQnjRAfg0nXeZWmqiE1z3K/HkX3z4IJf/5sM37vIFPN6tAR8A1wFqy6yj8IzyNE+OSqXcX6mjSgmVsMbMgD8J78svQ2TR+46ydXLmXm19eq4/3nl1FM1TdH1sfjKupO/1EShIpXyCbqdqfqec1xVXLd+AY00JmLXbCPvXFIWtOMYLsfYzbdF671VnkQKuODfn1PPjtIVImZmZdDa+L2noY7clRFaom/OlP3t3DRBAiI3QD0LZbNzW4uu+S28HNO+QRwhtnkvzbu2MgZA1iqSSGZE0OZBaUgINSIC7ykmkhjondFPx7FEPbnGMSb3GQEB6PIgH+93oC/anX2ynB/qyLkOIMu94hUBHlGasjK5V9BIB2Do+clziRaRTzawToWIuATXBIKZizXiqU2iDXvIx5M7vAUwsDx7KRPceA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(36756003)(31686004)(8936002)(31696002)(8676002)(41300700001)(66556008)(6666004)(86362001)(6916009)(66476007)(66946007)(316002)(6486002)(4326008)(38100700002)(478600001)(44832011)(6512007)(5660300002)(26005)(83380400001)(2906002)(186003)(6506007)(4744005)(53546011)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2E2STF0WXg1VlZKOWtnUFZOa09JRDJQdmx4ZTRGR2JySFc2MUFDTWVrVzhs?=
 =?utf-8?B?aHVMbXhyaTdtMFRzQVFqTllRWHBKRDNxR1A2STY2T1BWLzVqbmdWWi9jT2RO?=
 =?utf-8?B?TWU2TG5UZFZWUkwyVUdPWVNDTmlHT0c1dmxpV2hIbWdDME5qeTZia01GS0pU?=
 =?utf-8?B?dVhQL0VmNUR5cVp1dU1VM2FVWmFzWlRiMmpHWWo2dURJbDdkMnhFNHRFMTk5?=
 =?utf-8?B?WWpJc3NWeHpXNTVXRytmV2llY2tmRnZmNGZ5Ri9uZ1BHYk9kRm1iWXJhajNV?=
 =?utf-8?B?YlFlbktMSWd6cFRhRE5CUzJNRXJsOEE3d1dJRStFYUlVYXc0dlA4MlMxNWpj?=
 =?utf-8?B?UWw5WUxUNGJaUHQxYmFWSURuQW4vOTh1V2pRcmtST3hUaUt4dG5VRXl2cndy?=
 =?utf-8?B?Qmg1UE5hbnNVeVFrU2FnQytyVGNjbnFrTXRyc1JXY1BKWldta3czQ3VKT3A1?=
 =?utf-8?B?cEpZTGxwcWZjU2cvcFpaWU0zdDZCTmRweDlxSUFISVBjRFI4L3ZQQjM2cGN6?=
 =?utf-8?B?Mm1BaVhmSWpMcVRRKytZOTBEcmFNQWJHdFYzWWhNZkZ5MmVGa0VUK2w3czhB?=
 =?utf-8?B?SWFrSW9xOFZjN1pueU5zOEQ5R0tBci9VM0dIc3BaNEVzMHQ0cGQxbjFzVUZL?=
 =?utf-8?B?eGF4MlROWHV4SWRwTVhZMUV0TEVMSnB0cFg3V2JBVjZlcE1mbnpISEhCTGFS?=
 =?utf-8?B?WVpzcjdWNFlNTWFsODZ3M3RWY1BCa1Q2VEk4SWltTVpjWFZYZGR6eUN5c3By?=
 =?utf-8?B?dVZYb3crYlRQS3I3UTEvTG50VDh0NkJmRWlvOHZpUUxOWFV0YUZ4cldMaHRW?=
 =?utf-8?B?aU1GZVFjRURJVkRCN0VJQWJvektURWc0OHQxWkNjYXB1OTZHQTZtMFRaaktu?=
 =?utf-8?B?OHNYZlRqVDNIODFLSFo5eXVBeDExRFZ3U3VkZVBLcnJ6ZFMyVUx5QW1kd3Bw?=
 =?utf-8?B?U2U0cUUyT2ROVEh1MzVZbXZ6UGdWbStaTnVUQXVRd0txS0l3d016S0lwZjFk?=
 =?utf-8?B?ekZyMFhBVHJzTDArL1YrK0pvYnczRWFncFd6K2ZzMlNGRVByRVRHM3ZJdS9F?=
 =?utf-8?B?S0xDSldhNU45VU1kT3kzcVNlTDNpc3l4Y25xdkhadEJCbmgybk5hc0UvY1Nv?=
 =?utf-8?B?eDdOZWFhYlRRUnBGdkwwamZzeWJXMGRQOVhXeGxNQ2VNWmUxeE1lWXdaZmhr?=
 =?utf-8?B?VTEwUDR2U2lCRnlGMVU0ZXJVcTZJTUhocWtWRGg4amFhSXhGT3YwNjRoeWdm?=
 =?utf-8?B?cTNkRzFrUHYvRFl5N3BBTmcyOW9XL05tOFQ0dC9vZmY3UlV2akFEM2xlM2N0?=
 =?utf-8?B?K01FNktXbjAyT1BJemMzcG5uOVg1WHRWaXBYWWhEb1NwMGFQRDZQWXZxQ3lp?=
 =?utf-8?B?d1g4SDVSZENtdGoxQk1CQWgySElaSTh3TVE3dnFxNy8zZUxveDMvYm1OWEhk?=
 =?utf-8?B?S1lvUWdVK1graVc0Ym1ESTVyam9xNU0yK2RONVZDZDhuU0FERTlrYkpUaHhW?=
 =?utf-8?B?S0VWZHF6dHRPU0kzVlh4TkR4NU5KSUxRczZHdlU2SmloeHFjSFFXTU4vOEVU?=
 =?utf-8?B?bDJaMU54MzdHcVJQSkg1NVk4WkFYWnpjOThTWWg2amhIS1J2UFBHZ1JVdGNG?=
 =?utf-8?B?MTc1VHkrZndSMkcyMmdrdU1SRDVFUm1GbDJDa1RlRzNUQXljV2F4TEp0UTZW?=
 =?utf-8?B?amdBaVU0V1hhb1o3dEhFRmpjY3cyUE9jMHowNjlGYWtadTZheGpQR3RyVnhX?=
 =?utf-8?B?akQvWC95ZVV4dVN1bEdkWmFna0tnQ0U2aUxVeE1wYWFWZ05mVUxUcVRUMUZJ?=
 =?utf-8?B?R1QyODJwTzNYZTlteWdXckxTT2JaRm91SmlJUjA5UXNud1NRMXF2OWpVcGhl?=
 =?utf-8?B?Z1g0a3pNai82RHpjWXQwcUR0bGdlYW9sV3JTREZmM1JIV0dRa3d1bTlJQk9Q?=
 =?utf-8?B?Sk9zeTQxYWRqdkRhUi84N3A5Y0FuelhCN2dwbW1uR255ZU05R0pLQWVsYXRu?=
 =?utf-8?B?OTJOT1Z6VzduZHdKZjdwbHlpNHYrOU8vY0ZSUFVOTk9qdmtZZUw5YXpsbStk?=
 =?utf-8?B?SnQ3RHhKR0tSWXRqRDZ5SXRZQkxtUnBBQ0UyN0krZ1EwMnFHZTRIcFlhRmRO?=
 =?utf-8?Q?N1nCNlwR80CcPhjSDVLeqnO41?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mSWYmLD3Un4CgCITjai9wRZO49Y6YKHs0eF99L+WENbmketlyIcIVUtLE09Icb2MtRGC4nzBRUIECzCEZWl8fqqqPV6VseErnnVHhcYEE2YGqY8NkLV8rqo3jlRjtG9NvAuGXR7PZrvB8mZv4nDOVaj10dSU3KXmjJnYiYnPvHcDSrwEn2fo3snpfbjI6eKJ76Es0ja6JY9+kkMNdkDhQmKwZNIncI96GRBsJs3zn8KZFhCa/XEz+GmTs3PtGDUVY9P/GWR94AMqDHt6ZFvsMXDvwy294iJ+qfvaovV7a22d644PIr8O+qqDg+SLx7VB7C1rh0PX79VTJiMOrq5nZhbCL4yaVDCxHXVZKXvwXgragUG7JyTB8icyc7zKHEKUXWNNFBhQ+ZQ0Rk4I9M5TOcvPmNoyXCQsAwiKaF7X8s+208nZrQNAr+GQrCiUx8YspR7in0mWWRibVMtBplovw57Tnef1B6regSi/s8lbcft6svkpH+BrHsAdpmFAVEkp4LjhS4agE4x73F+taymvIQ85Z4aeoZ6OZXi/qSozu+uJrGOypm9m15GuXjpp6ODTW+B+4nLhCNhbDipj1JwDUYFXMQYWRR8rF66luU3lL8qspeOkToY/e74H2iNynLNI+YMPJAFMm/1kqKNrhEBk+XmbgRFJF1IPuwo7ih6+KIfsqFamNVN2JF/xV2M2rgKG80trmJ3smoeX/VnAhWA0J84Oz2pkBcDozM8su6zAvWxfQRfj93FQX2bvx0VysG11m00KOyRa8PsF9idWa7StzWpgfmU6+k1rT0XJ7DxSwul7ssrETsLTjXDaMv1w2ta0A1cX0byA3AUEn9l+LMLIzJ0tf5Uw8WN0jmdZp5ZF5Da2/F+uxtmvsqq1vldq1nHlSFaSUE8Irw4C56YdKDKgpS7QWP5sq4Ij5C/skAur15s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef69c39-bdfc-41c0-0ceb-08db71bd3c62
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 18:36:18.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ue5061H+eSGe1s0rvfZ+vVXCA7pzR+L5RGr+6hymkCrB2vWTqbDLH/kG2eBYhAFvZ2lO928tYvBL6VE8AnqqDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=638 adultscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200168
X-Proofpoint-GUID: c5mIOevHAzq9uiOQdNX_1-Az316772JG
X-Proofpoint-ORIG-GUID: c5mIOevHAzq9uiOQdNX_1-Az316772JG
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi, Greg,

On 6/19/2023 1:28 AM, Greg KH wrote:
> On Wed, Jun 14, 2023 at 07:52:53PM -0600, Jane Chu wrote:
>> I was able to reproduce crash on 5.15.y kernel during COW, and
>> when the grandchild process attempts a write to a private page
>> inherited from the child process and the private page contains
>> a memory uncorrectable error. The way to reproduce is described
>> in Tony's patch, using his ras-tools/einj_mem_uc.
>> And the patch series fixed the panic issue in 5.15.y.
> 
> But you are skipping 6.1.y, which is not ok as it would cause
> regressions when you upgrade.
> 
> I'll drop this from my review queue now, please provide working
> backports for this and newer releases, and I'll be glad to take them.
> 

Thanks for the guidance, will do.
To confirm, you're looking for backport to both 6.1.y and 5.15.y, and 
nothing else, correct?  Just curious, why 6.1.y in particular?

thanks!
-jane

> thanks,
> 
> greg k-h
