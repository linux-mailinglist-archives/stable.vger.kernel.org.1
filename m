Return-Path: <stable+bounces-227541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJp8BZFJvWlr8gIAu9opvQ
	(envelope-from <stable+bounces-227541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:20:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C85C2DADC0
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C93C3015867
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D25E3B19D0;
	Fri, 20 Mar 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bGwZpzhu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F8pe6JvK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160F73B895F
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774012791; cv=fail; b=tmu4usYErYezKkSZr0nv6fBhdX7nU7Ww1o+WJK31g7I+PMZvfClMuUbC7fZikk9Q6/ttXyWkvlNaVdnN+omsu/i0LAc/PIKs+gEvhuSsu+xcev0McwmTXje0F6vL3DlZqR32b1r7mliZtH+D9ADVfnFRl3myz7s8CkOws8kGny8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774012791; c=relaxed/simple;
	bh=6hoIhXLFyYUO+gGj9nz6/3s82OSda2s8kxugOr8B9oI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XvWpcQfsy72OgnJtqfucyhjN6dHzjbdBCH/dFOkKxCOvSM3cc773Rxc+y/UhjoAiXA0Fkwi2/l6HJgKrp6an6QKZoZS2DBfQNI6cX9vFJqf2CZW00sKNkdYeQhvXrTdmOSigdjhXRZbbJuejCvgKgpYc1JD/I+trPWNmkjVHpSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bGwZpzhu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F8pe6JvK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K8XmTc3811393;
	Fri, 20 Mar 2026 13:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VFXlo/Egou+pN/yPgEwcQuXsKPu2pSfV49H97Boq/Xs=; b=
	bGwZpzhuyYfId6Pzux1+y9kMH8laMqrXtJUr2KtD+VdAaAjPRghANEwy1M7YwQIg
	IpCMwVWPyINgx1SnCYqhbkOjmxPVJ4KuhADQsWcUURc3+LaqTgjhleZndEfxm3Lu
	wQE4Qz/NdUI5Idd+joXzc1hv+gdr79dniHXRPRAqympL/QcdKWyPbtmtEqw3A1Ho
	vQ38VkGyNCF4clKjpiCmCyhdtR/eSW5hDvYXVydFayHtmv+jwgL0zBmSZQ+Usebq
	Jvievs8F9TXZOeItZFzzNdrzETai5loQHFgLFv/h8LSo7h1rhJ4rETnYghIm+OLH
	Vmgpcv3FvPnNOVQtuGUraA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx3b9fcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 13:19:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62KD2vhP017832;
	Fri, 20 Mar 2026 13:19:30 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4rtttf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 13:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xq5b0JgE2vxqwSNKwcHN53PoslwpMjYNZwhs43QO03VYzmjzpvM19CtRte957XL6ajhB2NYdfVVMCDH4LARiHn+Pt3ZLzrkvA8ZkBJ7kkt0IgVDv8BsawtnqFQhCTnbu28ps2wWh0exeuA6kYb3EwUxEkz+VYa1ZwmDBISUI4k5oEITkazqRrh3xOEHtrWJYX0qJNoxWH+z4qZuazEqt6Tkqiwaf5ja3/jal3/tQg3VZFckqJ+GVCh2t1Iazrg461otrsc6BXlA9j7mjnnCTdIgEW4iy+mJfsa1YdmQQDjZJuu8Vcuv2me9CPp/zldUshNgMQu6Bg8B6UT2Y+4Sm7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFXlo/Egou+pN/yPgEwcQuXsKPu2pSfV49H97Boq/Xs=;
 b=uMMx9l+Jc9oMhTG+IktVeqc6WMozen2ZaxyMSQKmxxHp49zH9kNWNm3N+gX52r9GLxUUj56dGFRrKaSNhfPYOGQxA/nhzNt0pqs/S+9CMJbndiipymvXu5Jd4+kIJ5+K4hEcg3el6Cv4YLU2+Ho61IakJHMz8UZ27cZc4BF1lN2nnQu3VnSN7bgR9mgQWt9mKfnxgcxYh8+SAJTKJkDZ6va9hWYFIifftWSiGwjNsfca+Jq92NV8WVb6+PJqwFkwlx0X47zCGAUzyEm6nx5pW+Ziv4JNJpF6k4YeXQbHH+/eVInIiGouzZs9rWbt8fyBsf+xu+PwkBkPQ6Bdsk1XwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFXlo/Egou+pN/yPgEwcQuXsKPu2pSfV49H97Boq/Xs=;
 b=F8pe6JvKGI82Mim999kQPPXq63lfBvsJWDII5a+qYRQpIPNtLcwM4MlgDyY5TX4Y+OQe3w2Ai502TgAbwBYlI6MXcxm0yso0tg0MyF0SWHgcjiMEU2ZTxprTi1+f218RAHi3Zh1p6czb6y15bs8EMJ9c+BeZ9VcwBQzworYlpdY=
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6) by DS4PR10MB997647.namprd10.prod.outlook.com
 (2603:10b6:8:31f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.23; Fri, 20 Mar
 2026 13:19:28 +0000
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83]) by CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83%6]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 13:19:28 +0000
Message-ID: <249a8f36-840a-485f-9174-14de89f8c9a5@oracle.com>
Date: Fri, 20 Mar 2026 18:49:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 1/2] iio: light: Remove redundant
 pm_runtime_mark_last_busy() calls
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <2026031706-gentile-unbalance-017b@gregkh>
 <20260319183438.2928887-1-sashal@kernel.org>
 <abxkBLNmhGlxp9tm@kekkonen.localdomain>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <abxkBLNmhGlxp9tm@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0031.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::9) To CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH5PR10MB997695:EE_|DS4PR10MB997647:EE_
X-MS-Office365-Filtering-Correlation-Id: b86f1ed7-0011-481d-a79b-08de8683504e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	Mpi+oTE7xvOWxtZQ/F8rSnx5yifv4fQAN6Gxf7Wkt10P/j56FmmdWONuMjpu5OIqrPS3jdrl2CXe5v9aWZG2gKQpORMgprc/p2XWJfrAvvEJUwXItHZleyW4PBnxD5E1B2TpAluZnQrf3OVjWi/IjZjW1cHqzmRNztR75VeiFHzGib97NwXeLNziAgqY5FlZz577Ih4IBCfG1tSO4W0x6EZz1FiEB7II73EoUXNVxl2L++rOPkLYZzjcXyYWfKg0dLaMbiZXzTATz/oSr4ST904Vsnfc8mtoEVUvdnVwiz/KJ/2DlALYr2G8ZUh6Bp/BCHjnMNPPEhTK8X9D/aiV0rfVCRP0jMsbtHNWELtZCRAbs727kBe/KW+dzK7p53BC6JOkoeofMuAwFdVePAFNGZ1r7NKMyPg+GIDg03lPfUap84mVrLKb8kPuzM8UymLgLfDYYnzQc9V8ssHcMs0k9nMWJZMIPsC0ElCSYjyyhBV2EZ91DTVSBDoNKxxqWry9ds905KgRpewoP49rNS34jekYmznldQZ1lSkUQx33AXyNZRL6z2G2n0hlk1pk06qvxwL2oUe9GFKr7yEzPIr8+JWgPTncvyWhIp0CbGYVbPtBc7Xq93Uf0g02MGnSgj0gbl8NNdvMvPOUXZ+OkRmqgR6fy+zi2wy9gY1NOXLmHu/VuJcjAy9kohfImDkdJ5hlqEpDIRrM6iL4F+M6jVlmkdvGpn+Jp3WLtXogsVXBOpw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH5PR10MB997695.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NC9lZTFnZWRyNW5vcyt6bCsvajhaUWQ0dUlPdHhyZ1BoVEZOUWhZWWl3Rngx?=
 =?utf-8?B?dXRRakdlbHMvRDBZZXRzSHRtY2Eva0VXL3IrTUFmaVlHSTVHYjJZUWNaWnU4?=
 =?utf-8?B?N2hQUGd1dCtIZGJtcFNneHFRSytTT1FMbTM2UExEUzEwQllLeWFYdi9wS0t1?=
 =?utf-8?B?OHpIaTFVZzF3Yy9YRC80Z1dGYk5WZ09pRTNnQ2x6TktodDVER3NublZoQU1s?=
 =?utf-8?B?ZjNYZHFqbmJ1NEFVRHNxekJOaEhHNFZ1eStBaXpUOE9vT2dnamgzVlhSdEVR?=
 =?utf-8?B?VnoyZ0xld1VGcmVoWFpKNzBGUnFTRld0WlJ6aGY4ajc1NzZXeVo0RkJGWE9V?=
 =?utf-8?B?Y3hPR1lNTmVXZERUZ3FyV0tzZzlWdkRXaGlQdXYrcHRCZ0Z1THNyTDh1Q1lJ?=
 =?utf-8?B?TnFab29Ca1MyZHROdmozR1NaQWpQZHVLdlA4TVlnMlJQU1NrMEZvQ3Q1cXhS?=
 =?utf-8?B?SUFiRjF5anpuWjlLSXhnZ2s5SWlqNk9XOWdKb2QxYXh4TjZWL29ONytYYUxJ?=
 =?utf-8?B?dGJkM1E4OVAveXR1RVl0U25jRkVGK3JCSXh4SXNOMWZrK2llKzgzb0t6ZmN6?=
 =?utf-8?B?VFFkekg0aHN4V1FvbDZ3aHBBdlRRNmZvdFV4VXdSbTY4dDV4aHhnUEhaRWM1?=
 =?utf-8?B?Y1pEUEh4Kzk5eUxVWHoyQ3J3V3hVbWRhb2QwZjhMRmU1QjJ1V014ZzVHazBl?=
 =?utf-8?B?VTVyZHIvY3U4QWsvSWxTN0lUbkF3ejEvQ3pCSUVxcUxiN2RQS0JQbkp3dmZB?=
 =?utf-8?B?SHhpRGNuZEx2c2FPeERTQStFSFBFY2JiUmlmbS9VTzNBYi9ZRzAxUFRoZnlw?=
 =?utf-8?B?M3lKY1dTb0xHSlp2Ly9Iam96aXlvKy80c2JtUGhTVUNBQktyQ1MxVzVMWVFY?=
 =?utf-8?B?bkdPWEFWdVYwbHlwQi80YkI1NjQySEtDSm40UzVHekpwMmVxZ2FKTDgxY0JI?=
 =?utf-8?B?QS9Vc05VSldaZEJrOXZibDd3UFJFTzhvQWM1aVBxSmpXVzY0VTQ3U0tGM0k0?=
 =?utf-8?B?bjYvRS9WQ0o0YXFrTDVxL1lrTzIzL3NtTDlxdnlhczBCTzdlZTB6MWQvUzg3?=
 =?utf-8?B?b2pDci9jRHdrc1Nla1I5NGJDS00wWjh4eUhPQnp3a08ydXNVTE9ybDhDMXFk?=
 =?utf-8?B?dmlIbWIyRUppRllpRVdhVCtPbW9ZaUc0aWcxdHdCNGllZVNoQzhGcmh3NCtn?=
 =?utf-8?B?b25aZVd0N0NNUmlRdEZkK2c3dW9Uc0JNWWtnNGhhelNDSVZqZ1QyaVVXNkpj?=
 =?utf-8?B?dk9aWUhIcVZoOFpOdDJsSDJvcUVTYk44VStkK1p4aGVNV3NqWlh4WXYybllX?=
 =?utf-8?B?M2Z6TjhnQlZDL1dtWXRRSWRKc2p1bENVRUN3a0QyUE1FNnVmaXBMcHJNQTlF?=
 =?utf-8?B?WmNsekM5ZmR3VkpRamtHYm1NMndjSHhHNG1IdUlJSEI1MjliY1hwZ3dUZ2VO?=
 =?utf-8?B?WWJzelFqbU56Q05aTzZZZTFpRnJzSm5vVlZDNTZ5cWlUb2RBaVdmVmpHUHdG?=
 =?utf-8?B?dzJCZDlSaVpZRW02U0FLaVAxSkVaOFhwTXIzOVBTenNyeU04djFKQmpYWlND?=
 =?utf-8?B?TjRyZTJxMncvemg0bzVEYUQybmRSZWxMY0RmUnVlcFVwY2JDRnR5emJ3bnJ1?=
 =?utf-8?B?TFdvZHdsR2EwMHhaUENuSGhhNCtNK3p3RDArQ3VOKysvZ2NaRzAzUXJFZllh?=
 =?utf-8?B?S2pJYjNZenNRbzBMYTQwUEhOZGdNQ3FTanNVN1NmRVcwdktxYlRrQ2F1WFNH?=
 =?utf-8?B?bHdqRDVEMGFuYWlPUUViTklrZjRPd2xrOHVjYXJRRjFKK3BaV25kMkFXUE12?=
 =?utf-8?B?Q25LWWUvTDFHa2NYcTV4ZUV6N0lvOHhja1dTcDJJTUVCaGdpVVZ2MjJyZEJL?=
 =?utf-8?B?ZWRiL0hNekdLaUlZa3J2R25NbFdtNUxFL29jd0l6YVdDSjh2bHlWYTUyNUdk?=
 =?utf-8?B?T3ZkMG1xYXFVOEV6ajB2SXA0WUFTOXpXOFM5ZFdQRm9lL2dMQlk5YVZlVWor?=
 =?utf-8?B?aEo3Um9LN1ppb3JwQmVDQlZiUEs4cGpPajB1YmZUZjg3SGRRbVZGLzR4ZW82?=
 =?utf-8?B?OGlNWjNHM1E3K29IYk1raURSQmFOQU5XaTFIR2xUZUZuM0x1Mm05Y3N6VFVH?=
 =?utf-8?B?RTZqNy9udDZ6ZGNvMVk0Q0xiM2VId1Z2LzhTV0s4ZHM4Vld3OTRxbkhUdUFF?=
 =?utf-8?B?UmxDekNPM3R2cHorNk1tcnpHTkRkUEVVMjZHUnlpM0dvS3E2c2ZxSld0N3FF?=
 =?utf-8?B?MzdMUGVwRXFCR0UyNDR0b05jdStGSTlTdlcrdERERC91VG5iZTJvcU85aTIy?=
 =?utf-8?B?NThrM1RVS1B2K2RuWWZablZjcEY4K3dIK20ycm5sUDJySzNadnR1Q1pobVlM?=
 =?utf-8?Q?oOCslFGZjHp4PlpJqS6lmkZ2VoNJp27kBd/NO?=
X-Exchange-RoutingPolicyChecked:
	R6AVlnOfhcwIa9P5o/a3OxyGwWegCaT4gZv5N6pqlUttlY+/BQzFOk4NSN53g1g+psSvkOaLGs7JjPHUOgq29AVidb3a6wnZn1DDvsxgf1aVyQ31uHm/QetP9eSf8OlC3+rOfTE59O+4orncySc7d+B+cv3zAVPpK1Q//vBiP47A3UuumQwQqr63Zr2AvPS/te97ebRb+3qD5dN9yhC3S3pc2xBYyaEWXdFGi7ZGzJfNTa3yWFB6mm4LeA8WkDOEKz0kCFy3ZFaZPNmO5lwxde881unUznxerAwZIYRWqiZIFOVJPLOxNbUztiEY0jXDcZGKmD0aGC4Fqcq6UcFUHg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L7p4p8S4NjSPhFXu35/y6cG80UulrgDaxSzAwD0hstyJjN47mbjMNvlHesK3S2TFypsAn+yFBwbmMs59fjtgSaORQs+/Qz5GHdPYc/HStCv97P+Ddf00u3bOFEcy+EjWsE7jvweiZFWh6OAIX8izDBcNjMaAooZ4TXo6UY1Y2O7ynQ9va8BO3y/mlJBe8nKtChB9beAJTjTcs6UQ6VOMl69NJ7zdhrAH2XthH6883lJRe8xn9OVZqeT3ba1Uj7oDMO6tGCDU7yV41X7czRghdU4c5hzKc066SN8jkNTc3fte8XcBa3ooSRA4y1H6TpIYnHOdNWq8FYqyqetwoURKdKcQ2pe6dQGG9VifLvy6RKTMqpPQJe5w2phwqoVZ7S9/XJFP+wc18U2oUadqY6vqLX8uMFS2TaDRgIgvOF05ttcS1TUkVRLl1KSIkyD44/18qyhg+PjMW9GsTyQPE6r5NLPR7QNgwFbFxDsiCuITm9h/qRJm5lS6p6r4e+1ZuipBmWZtitbvj2E9Pt99I/GHKpZOOgFXNSSCRaYo+HYSicE0C8PN7PRqjFiAQV5/YBbEBZYFWq21lMiXfq3qMbmwLbWCCKByvJBLV093SYz+Dxo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86f1ed7-0011-481d-a79b-08de8683504e
X-MS-Exchange-CrossTenant-AuthSource: CH5PR10MB997695.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 13:19:28.2175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AVp2QBbvMIMmw0oG5ctQrV2eDcabb8yuMxcowQEgLnZyCe+fkzifeyqDIMLTFImbENaGz46TZISlKvJi5XiFCHLbSQSBzORq4PLor/5mzFg/NEPBOXtdA5Ae4VfxrTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603200105
X-Proofpoint-GUID: HmLizlQVwG2dya-n6btq6pfDkHlzbK93
X-Proofpoint-ORIG-GUID: HmLizlQVwG2dya-n6btq6pfDkHlzbK93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEwNSBTYWx0ZWRfX8b635K5Q3YKc
 ixjgDviSseslOxZKG9x1gCRH+v0ctO37WK7lj+SQzLn61JofHldbdf2A56Zv3cSHc7zDABoJ3Aa
 EMosqvwEFKdu37o/UFzVJo3XmdPJTvad5C4wPRwxSMS7Rpo6djc//2s81BRZXYEKuxpJPjgbuw1
 uE7dNJYWnyb4Fs32N5h7csD5AViosgYWu0TAGYHtMR87QxOGw7m2f86Em6Vat+4iXytXjm67nw4
 sZXMHj2oOKSiBK0ErGidTCvwnLxB8rCHnctPlz611lZQ6Y7D+oXoMC3I87YiiQXbw0q+5goEaEF
 U2XBZ2vahePYVXQ/CnX8WjhlFduI9ZlODrBouRGWKSJV09t7e/ctFiEIw0NmYJRfJKh/Yxa8iKp
 /oCMrh1SUMxeGYQK/ewvTtfo5IQQPZoQfp9MqaPJOTg0CWNyLU728R/NNDU9MuZ6SDmVjv8UQsr
 jwE4PV+vhF+vnz5P4copfZ9/mZ/VmmMX4bp6Z94k=
X-Authority-Analysis: v=2.4 cv=IN4PywvG c=1 sm=1 tr=0 ts=69bd4962 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=QyXUC8HyAAAA:8
 a=MAHdqFti4xjTJq1B8lkA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 cc=ntf
 awl=host:12273
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227541-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,oracle.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7C85C2DADC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 20/03/26 02:30, Sakari Ailus wrote:
> Hi Sasha,
> 
> On Thu, Mar 19, 2026 at 02:34:37PM -0400, Sasha Levin wrote:
>> From: Sakari Ailus <sakari.ailus@linux.intel.com>
>>
>> [ Upstream commit e15f23dd5305d123b571aeee56415d9e90f06ca4 ]
>>
>> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
>> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
>> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
>> pm_runtime_mark_last_busy().
> 
> This is true from v6.17 onwards only; do not apply patches removing
> "redundant" mark_last_busy() calls on earlier kernels as these calls are
> needed there.
> 

Note: I was checking this and agree with you, looks like the 
prerequisite is: commit: b3db492e8335 ("PM: runtime: Mark last busy 
stamp in pm_runtime_put_autosuspend()")


Thanks,
Harshit


