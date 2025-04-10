Return-Path: <stable+bounces-132118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B8EA845D2
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85814E6DF5
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C098C28D84A;
	Thu, 10 Apr 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OMvSOCzt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jJJ/c1DC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAE28CF73
	for <stable@vger.kernel.org>; Thu, 10 Apr 2025 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294014; cv=fail; b=WJBrVQ+REC6DVjgdPgWikfx6tnWjw2pXQVg2bkGvIufw/c5/pa3MG3RIouRqAKz9rwOK3RliAtKr0YBc3IRrU8BU3xQ+3UfYv671C41bmu+0AAPImM9hyOQgO9LyzncVLe1iPdJEEPui5dHQeMGzOEGqK3J5JMQe/jL7kGdZE74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294014; c=relaxed/simple;
	bh=km9juIDriPngtTeuWQE2yZFUdOcZXrgxfU1KlCxeSzM=;
	h=Message-ID:Date:Subject:References:To:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BB1UFOsylUcmrQqCKLoDwntgDtBA4BtFTliM3n0EVBDeGcq4evkG8BIUhW/A8c4YCxVFkBvxmnZI9GYesLAqAARhDzsHp4YfJBJRTEghWYMIHdAap+HIO4miXTgUTqaFbSiduzNdtYRWYiJjpIeNVn41MFIDz5HTUwnGeo/sVJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OMvSOCzt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jJJ/c1DC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADfsxI005196;
	Thu, 10 Apr 2025 14:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DqJB3Gdrzjzsg3MImYnZqpcbRIT64KEGb76ATV6otAU=; b=
	OMvSOCztT5FPM4dqga6FZvP3ZksQg6i0bg5+TvIRxsBQVeO+05j0Uc01C6pVe4bn
	fMDrLhAbzEF5Zn1OyeIMu8gLpCOfza843SEXOgTNwdm5NDgfUCDke4Kcm9yAdNGH
	AZ/jniqpDp9FxNSh0Q94CzCWIokYr8v62mMUT/nQ6l1NmNBtXYpqC7UnAZjJFUxh
	gdMsLydSn8mTBBhBIQKgxS2wnWc3gMwe56U6pOPcs0zpr9jr5iC3qfcAa08uXU/I
	kdmq7eLVVDoDn9LbD4XPuQPEjZE1IlSAs2M4ixz4yo7emJu8tTG+/6GpSUSgEu/p
	3GFF/99kTJlDTm0v3HPZDw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xf3mg20e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 14:06:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53ADBtnh022327;
	Thu, 10 Apr 2025 14:06:33 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyd10qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 14:06:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKSNHZ3za8I31W/13Q6cFAqTRnNkVkbfyTKVdza5+CdoBxWve0jjFhAL3lEsps/83Wkem2nOowU1lWnkjJ84t0YsHFfwiOIwTf2d2+XKA1+LVCs3S3NRa3fsj280ZotY+Dbjq7QzLHfd6yBrlaet/JZ5nC70wMp+jNLKQ0QXLnwoCgSEV8Bl/nBmtzl4ifAPH0X6L/QxsQiwA3J+JTW0fx9fV4wZkXHx+HXFpa7W6IQUJgBsgLcMihGjbuXifxF9YO5/FVEfHkUOkx2IN1fSbclVjjXuhOaPosTBWtW978Xjnf0t+pPacBUniGbLEm8ErWSJkqpA0WAZCkqIOi/xgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqJB3Gdrzjzsg3MImYnZqpcbRIT64KEGb76ATV6otAU=;
 b=bjQHwIK1Jt4v1gohrlLWlactLM0Ja0QEkaXmhYrDeQsKzY+AhsZdlyYyjP3u2iWLt4Ovp/5gyZey7WaLYaCFBoWiRpdl0BXHvF5gW0eVLJwdDS5pW7AGxI6VgTgMQlKCrTLl/FQym8JTk2EhyM1JmM6TrPlBw+iQo4aCLTP2n5bYOuG0GbWRV3IRgoPXLk4JaZs49mSxH/DOs6Rcmx+3F1+7MHQUMXTsDQZ+fgqWPIZfNbi4ca/6ozOudHffr9HIYcfCjocIjk9BIBF71HuE2jKN3OMZ7dTiF89ZkUhc+BgtYzMGDVgr4lzW4td573oIScZT5mxK+oqLdTnBtWG99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqJB3Gdrzjzsg3MImYnZqpcbRIT64KEGb76ATV6otAU=;
 b=jJJ/c1DChmoCp8LiTaqd8hjejBhTWh/9+TItHakUefPnBNpxN5UEpp+/isimmd2w+Lb3GqSXb4j3I6NJ/nIGes9pMZANdV71vGwCh162+oDrcH1p/pXxKdm4vaTxNP4K+UtOYjSQOyQTy5csgLwLMMmIQ2dEYNF6HMEVNSoW0h4=
Received: from DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) by
 IA0PR10MB7205.namprd10.prod.outlook.com (2603:10b6:208:406::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 14:06:22 +0000
Received: from DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036]) by DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036%6]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 14:06:22 +0000
Message-ID: <65428b1a-19b9-4eac-af65-eeb0a5e298a4@oracle.com>
Date: Thu, 10 Apr 2025 09:06:19 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH] ocfs2: fix panic in failed foilio allocation
References: <20250408135904.52237-1-mark.tinguely@oracle.com>
Content-Language: en-US
To: Mark Tinguely <mark.tinguely@oracle.com>
Cc: stable@vger.kernel.org, Changwei Ge <gechangwei@live.cn>,
        Joel Becker <jlbec@evilplan.org>, Jun Piao <piaojun@huawei.com>,
        Junxiao Bi <junxiao.bi@oracle.com>, Mark Fasheh <mark@fasheh.com>
From: Mark Tinguely <mark.tinguely@oracle.com>
In-Reply-To: <20250408135904.52237-1-mark.tinguely@oracle.com>
X-Forwarded-Message-Id: <20250408135904.52237-1-mark.tinguely@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:408:e7::10) To DM4PR10MB7476.namprd10.prod.outlook.com
 (2603:10b6:8:17d::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7476:EE_|IA0PR10MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 9422f53d-e615-4258-6553-08dd7838df2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0pWeThxdExWaW4ya1BqMjgva1FiSkFDRzZQLzFBT093R3dmTHcwSFBndTgv?=
 =?utf-8?B?MFErZW9jZjg2RlgzSks3eVRRU0FTdld2bmFMd0k5SmNXaDhxVHVNakxBTUdx?=
 =?utf-8?B?MGprT3Q1RER5R0JHNzFrQ0hobVNmbXhzTjZKRENGNWdNMjVyaFUxSjVOQXlt?=
 =?utf-8?B?czdpcXMzVXB4OURUS0MyUzVnQWxjUmgwYjYvSjUwTWVvc3pBNDFqV0UwdG5r?=
 =?utf-8?B?SXZPWERsa1FuMGp6MkZQZ2huWDUzbksrNUkzZzZ6REN5SHBPTk85NDFpZy94?=
 =?utf-8?B?UWQxMTk0WFJ4SHdOZkloalNuWXVLZGszRTVmNUtFK0xsbGhRWVcyaThZMkFW?=
 =?utf-8?B?S2NGK3pXVzk3MHFJTmhvY0xqWXV3YmQvcndSL05lSjQ5Mml4WTdCZG1KeHBE?=
 =?utf-8?B?eC9XeDZRMTVSSWFORFBzQ1pUYVhxTHIyYk5PcVpFZGVKV0tTT3pXNWplbWpP?=
 =?utf-8?B?ODRQcFc3SFlWNWJtcjJjek9tUkNnVEF4MUpWSGN1M0J5VThZOUlOVGxLdG9N?=
 =?utf-8?B?ZWE2WWtQbnNHVm1GRmtQY3gxeVdiTm8wemxJcmhodEFpT1l5WUNDam5nOFRE?=
 =?utf-8?B?MFEwWG0vWnpuUktkYjZOQVZQRC9zWXA0QTcyMHlpUWI3TlltTUk3UENiUFJi?=
 =?utf-8?B?QS9ndTNnNW12elNDbXJMZDRGRThyLyt4OThGSENTWFdoSmQzeWtyRzBZQnBO?=
 =?utf-8?B?MGMzcDRnVkJ3Z2dna0pTM1dza1RYMnJ0VUFXamJhR2dLODI4bHg5QVh3QWxw?=
 =?utf-8?B?SkxITzJqSWEwTXR6K1dlUkJLZWJLVWl3eU9NckNmNkJIY3JCaVRPckVLdTBt?=
 =?utf-8?B?cEJDekt6NmZQUnYxaDFZY3ExRXlKQUZhb2sxUFNXdDdUZmhydFFGS0RYRkU1?=
 =?utf-8?B?UkxEZlJxSzJxeGhxWXJIZGczY3dIS09NNkxTenl4Q3MxZW9LWi81R1l0S2Vt?=
 =?utf-8?B?UjN5c2JVc2c5bStZUVlodTJnRC9kb29lWG0zMitmVFdxRHZxc0VLV3owQnFN?=
 =?utf-8?B?ZnBPUVYwc1laVE41NkpicXZTUkhWUFVGVlBsWk1JanpFc2Q2bjcxR1duYWRn?=
 =?utf-8?B?OURsR1JzQzd3YkFxUHVKVkIxR0ZlNE41MWE4MmRtSkhWOTRtMlhJVHNwTXpr?=
 =?utf-8?B?WVFTRjR2M21qSlprQVZwY1k2ejJzTG9raHIxbzM5TGFTNWg2V3RkRmVOckJl?=
 =?utf-8?B?QStzMDQ5Nm0zZU4wMS80QlRUNUhpcTF1ZHlmSFhDbVFuMi8xZUorbnFXMWI3?=
 =?utf-8?B?Z21HVmF6Rks5WUl4UG9PQUdBZm00ZW40Y3IrK2UrMHI3N09sV2dCbmV4Q0sw?=
 =?utf-8?B?aGozRjRLTTF5VDByR1pteWpQZStwbXBTQzIvZll3QzZHTDFXT0Y2bUtUcnc3?=
 =?utf-8?B?bml5Ym1uS3FxdFR3ejc2K1JJWElyMklibnMwWW9mbG5VSExDd3o4a0QwL05L?=
 =?utf-8?B?ckFLM1c2OHlEZ1lQWFJPTGVuMDZxQlo0c0ZXUWhOOHdTSGJSOVJhN0xhbWNo?=
 =?utf-8?B?U2hBb3ExV2pIcENlejBLS1NFQVFJMXZ5L2YrUzZPb0FzY2ZRa2xCK3NJV0F6?=
 =?utf-8?B?ME1JZ0JCWmdDWVB3MnMwQjd1UzY3akUvQXpGRWxyT3U0YXY5QnBsMERMemFl?=
 =?utf-8?B?VFNtdnpQVFBIdlhPQTZZNWR2bjY4ekFSenlaU3J3a0dVYjlDeXY4S0Q2OEtM?=
 =?utf-8?B?MDVFSUJYcmhvNU03YXZWNllwQk5QZlg0ZmdGK3dLSTdwOFNmdzVOMlFzSkZ0?=
 =?utf-8?B?d2NhRU0rL0U2NDlGOWNlRE92eDBOczhlQmVER1ZNYXZYTWQwb215OWdTV0pJ?=
 =?utf-8?B?c1pRTWZIeStMTTBxQ2xsdVlIbXJXTWlJbkFTekZneHh0djFSektVWmU3WFJZ?=
 =?utf-8?B?YytuS1JqZ25IK3AwTENHaENJc3VyVW55MlBFOFovZklyMmdISVBUL1RzZzh4?=
 =?utf-8?Q?bcWPYust2eA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7476.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmFFSEsvWWluSUd1QTllVG1iMUZnM3pSSEVCNzVOS2N0ZitnRXJuK1diN1BI?=
 =?utf-8?B?VkI4T09VYUdqeUtnaC9qQWFwRm40OVBpeDQ4djAzbjk1NWJNaFc2R3RaWHkz?=
 =?utf-8?B?c0VYZFpudm1wUlppWHdkcmFLVVdsSVNuZThQRHhnUDBBNGtmaExmYzNWWHhy?=
 =?utf-8?B?a21uN2VUTHVaei8veUNDbWsvTmFvVHFwSHdXYS8zNW45bnVGV1owNDdSZnE1?=
 =?utf-8?B?dXJCM1FsT3ZzTVhrVDlRR1FBdnJEQjFJbSt0Yko4U1orNjRBWUlCc2Uyd1BF?=
 =?utf-8?B?UzliUVVGcm9YdktYTm04VlRkdEFHMjdnT001ZnBITGN5MGVTejZidVdUOGlZ?=
 =?utf-8?B?dGZ4ZkJnK0tFN2ZRb0dqZkdyZndzSVRWQ2l0b1VFbElPUnBqZURYYXFYY3Jx?=
 =?utf-8?B?UlFNU2VGS1YyMkNsUjdiOGJJcm56cGM3U0dBYUZoTDlXdXYvL3g4UFVFY0t6?=
 =?utf-8?B?TWdra1NUaS9rc2hnWjhVTTcvdll2eWlLMGhDdjdBUE1WUG9McmordW9rR1NW?=
 =?utf-8?B?U3VkWmhnV2UreFZRZkErSjNQcTQwMVpja3pxbkdiZm92cTFuei9qejBtN1hx?=
 =?utf-8?B?ZjVQbmtKbmphWDVOa0IrdlYvT3cvSUx6RENOSUUwWDAxanJMTlVkOFFVRUla?=
 =?utf-8?B?Wnh3YWpkN1FWQmhwYnEwSWFZbmZPTlErZUZVL09sc3liMTk3czFENkNZMHBa?=
 =?utf-8?B?b3ZHbFJnVXpRMlJZQUtkb0dlTDRuTFhvSVg0Sk9td1RUYWVGVjZOR09teU9I?=
 =?utf-8?B?cW9DT3AwcnB1dDMrOXdldkFaR1YvY2JtSi9lYWtzOVU0MldNSnRtVGFpMG0v?=
 =?utf-8?B?VnRYbE1ROU13YTJ4VnVwSXNjTWNnb2s1TnZMSU01S1RxbHhwTWg5M2VGVzFv?=
 =?utf-8?B?SWxUeUJRa25aSGRzNmE5aTRFcGtFRng1RElWTFFqb3F6ZG0zOEloVWcrV0ov?=
 =?utf-8?B?WFl5S2RHZUpsUjY1Y0lURktHU0w0VmNwS3YvWDh0c1JIcnVTajlXamo2OTZO?=
 =?utf-8?B?Q2FZa3REdXZ3VHlEdlVJMnVHME9JKzFkZjNmQlNIdC9NcTZSNWYvWjZjV3Zw?=
 =?utf-8?B?d003aElCbUdFbjRZSW5Bck4weU9FM2Z2enYwWDJkN3FMcVVqWnRzbzFuenE5?=
 =?utf-8?B?aEJVRGRkdkxBRDN5RmluZkVBQ3M3YTJTcStlNzB2MFQ2MlR2anNDaFlYbHVm?=
 =?utf-8?B?T3AzamllMmllNU5Jd1dMUkM2TTJjdVIwM0dHeWh0OVljdkpoUGQ0V09jeU9X?=
 =?utf-8?B?SUNxYzh6UmVxMXRVeGVFK2E4OUs4RXoxVFlNV0dDUHZySlBIVWNRSVlOb1li?=
 =?utf-8?B?T2ZPM3hXQWtVSVJyZDYzbTZxckVZeVp5ODhyZFE3M2R0eVV3aHh1bzNOclc1?=
 =?utf-8?B?ZmNoekRDTkVNZjRtaWVzUDlqZXpKU2hFZnR4T1dhR1ppdFp2VDV6dTgzbmVS?=
 =?utf-8?B?TUlWTlVEV25oTmtFUENnUFVGRmlKdVJlRGJ1OGJxRUZBQVNpUVdsSTZrS0V2?=
 =?utf-8?B?STdqdkZSTUltcU5UZThjdlZQanpoaFRtSE80bmZ5Y2VaLzRZaGxBc2V0MDBP?=
 =?utf-8?B?RW5jRVJvWGhmTmgwZTV2L0tOenl0UGsxdUV4dFZLdVQ4TXRUMmRwS2ttUjFo?=
 =?utf-8?B?ZGxVQjcva0lzNlAxd2ZsMUw4aXJManBuVnpkWkFpeEM0RFlrRVE0RFRoVWpO?=
 =?utf-8?B?Y3hocTVRYXNxNi9RRDBpT25XK0lwSkc4TVBnVmZWQkZrellORzczV1h6d09C?=
 =?utf-8?B?YnY4TDJ3S2pXdGpYdm1TQXkza1FRa2tRWFVBNzBBdTl6ZGJPaEdRcFlmbFVZ?=
 =?utf-8?B?RUxJalRpT0Vwc3R1RU45SXhlMFhQdHpkVEFGODZkTFJBTU5LVXMxK04zeGRB?=
 =?utf-8?B?RGFqNXRpRnFLeXdFZEY2bytBQk42a09sbUtFMHdGdllJRFZXdCs4V3NoazBw?=
 =?utf-8?B?ejJtR3NCSjF3cUtEZlczQWY0NDR1Y2ZDbUU1UlFsdG4rMTczMmdRc2xtdkxl?=
 =?utf-8?B?YmZjaVdoOG9iWUttNUpxUEdPUGhrdnA0dXAyRUQ3TkZKaW9xdHN3c0FTcXJs?=
 =?utf-8?B?S0RNVTdLZ2psWjF4Vm8xYkNSdGR1RkFmZ01XcWw1WWNTbTc5RDE0NFJpTGFk?=
 =?utf-8?B?K2tDbitBOXFPSFRiZFlpZlNJc0tFdGk2WWxPNHA5MmIyNlNodGhsMmNINXN2?=
 =?utf-8?B?L1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jkkwl187rb3YIvNVSmmBg2nkfOg0jHUm31m3kU6j8KgvH9mZNGvF8RYtymDb46PcjxEmXE6AG27jCFoCJ5apBizObEW2j4H89CgaED+li3rY/FYzXPuE0yP3eZspJ+JIzGeWshvirSS/yeBFbUgPcqk6FDUO8JUupaGuN31WN6hHw33BgFUYo672iKQFGPNxCUO+Ck1qUBIYYz3eCuf4mKA+Djjj45M0+lb01l0QgLI8SisjlHPJ5sfl39WJ0WovvV0GuoqD0lGbrB3jy4JFvsGP5oF7X0CWaWyzPXIN2KFUvxrsrdK2aoEhz0w39bm02yD11yFEZuYOquDj6oEVcThT8rRyRbwx3n1+8nBBrtWaGs3+ngCtz0/KmvGDridj1Xv2c6GN56gnDsZK8vhwmPTmHB++ryi5n9ROGp6wWw+WBDDVvfT50FDf2p5V14qUKcEgo6Q+EcYMAmj4CD5ughEVmQ2mivydIO+ocmMNSzCIP8InvvazRhfnspuqJZpuMKbgzr/HQgjCKI0YkyYj5tOzm5RV7F0rNhd1mpkV0EpcD1OTTIbrs1Z8B9AWvsjZstUKL+CPK9l+X7Lb17kjt9j8vJsXqAowZFvhC74+8R0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9422f53d-e615-4258-6553-08dd7838df2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7476.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:06:22.1021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGVsROZYFMwK+uHiGl6SGEuZvoXO0z8DLfgiRO4btPg5fxeTjWaqZf+InX2fxGnulNGGDMqMAbrljVyGl6UUKAHkhn4F8p6VBa6SNmt77aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100102
X-Proofpoint-GUID: _KivkObQgUJZw6lWh7cFHUm3y5BTm9cb
X-Proofpoint-ORIG-GUID: _KivkObQgUJZw6lWh7cFHUm3y5BTm9cb


In commit 7e119cff9d0a, "ocfs2: convert w_pages to w_folios" the
chunk page allocations became order 0 folio allocations. If an
allocation failed, the folio array entry should be NULL so the
error path can skip the entry. In the port it is -ENOMEM and
the error path panics trying to free this bad value.

Signed-off-by: Mark Tinguely <mark.tinguely@oracle.com>
Cc: stable@vger.kernel.org
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Mark Fasheh <mark@fasheh.com>
---
  fs/ocfs2/aops.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 40b6bce12951..89aadc6cdd87 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -1071,6 +1071,7 @@ static int ocfs2_grab_folios_for_write(struct 
address_space *mapping,
  			if (IS_ERR(wc->w_folios[i])) {
  				ret = PTR_ERR(wc->w_folios[i]);
  				mlog_errno(ret);
+				wc->w_folios[i] = NULL;
  				goto out;
  			}
  		}
-- 
2.39.5 (Apple Git-154)


