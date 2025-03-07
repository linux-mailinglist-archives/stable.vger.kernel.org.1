Return-Path: <stable+bounces-121388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9576A5699E
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 14:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A83616D51A
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 13:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDDD21A92F;
	Fri,  7 Mar 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d4GKsPEw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="orxr4aBJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A039D21A435;
	Fri,  7 Mar 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355768; cv=fail; b=o4Qn0TDkP6LsmXwZ7ISTjyvEx4Jcfyqb6dxA6nTFN5jt2XOSe0Tmf91Tvz68hQPmSmaRjkxtNNm6tWhfb8DYZcuH1m1EC7mtBSTpNeos9yVpID0lxGIfyRfwY1GGQH4u3hMNMyLeJzZ3jDMw7EOz+BJ1bHWlCJz32NNZML1SpDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355768; c=relaxed/simple;
	bh=HTLV+ZZKNM0jOkfdHvU64aNRmqfPklEf2XcSt5DS374=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jLtfeNmQxJBwl5bpKhzBJE3S/JBz3jKuZ15mYqJmZbsEgSP7/6cFzaelz/EhuH4MIlrdPUs+h4n932olW+I/R0yX4zC8Lw6QKXgVyC3AocObTpmHpAwJ9E5JwaclCPMwj4U5Nl/frupdgfOu1xV6zgIh9ev+/FX+fpX3M2vPof4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d4GKsPEw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=orxr4aBJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271tlrb028692;
	Fri, 7 Mar 2025 13:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z2LHdRuLIKYxGpkXuVVMXeWKO/Wx0TcrCxrPlxezhk0=; b=
	d4GKsPEw3ReoEsOvk2z+eeGUsN08hxa7rhrhcN7buhuqdVNXcxI0DcKscBd3uStg
	/GRPEpuToFgt8xcL6csZN9Wu2jbTYTlrtgZ3RalgkoYMizDDGWdLLARzVRbu8Cs7
	cA9VtkpOBRBe5RDtJRuxKzaEd1NrsXWECr+MFrW3Ky4pkWbHX9zu3QOvb7bjbV5c
	7tBDxhoKpP0dgZRQzyZiUvPwck6Gpj0AgAzrxDRmmEgBxL1d0vW+7LyGU+vwUDkg
	UCJr1co0s1sH/WKFL9xL7aCmavwEDhiv3R+mZSkyu2VYUvvHtzNtsJRY7+cEodhN
	mccP/QGG/hmZZDWxQj5trg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wv50j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:56:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527CVx9f019921;
	Fri, 7 Mar 2025 13:56:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rpemtfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9GesZvOzbXLq2GB4m4jV2qL4Zj7SM7kYkb/E9ExnAyiMoROZcAln92um+VRVo7cCk3bwpWAiarn9znRauhwY1XBMXqS5EgpaFWr5hiXH5zcL3A0LJLqvX6pZFCTuemfeJT3cQb2dWho7bPSakXFH4nM90rrK63bpCgcouRZQmgwtoz2sUVhZHNVoFty8BQTVCxMAtJa9Y1Jt20pTxNtMxEN+AHPHOQxZpTZ+mBJ+NRIorvO43Fex/4cP6xHizrtonEopnbkrg3i14XjDOomnx71wZ4sCP2sw0MYVsPNYTH4x65QR7JlVCen51svRY2AelVd1QKfGmyLEHuISJr+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2LHdRuLIKYxGpkXuVVMXeWKO/Wx0TcrCxrPlxezhk0=;
 b=RG5hgcSNTXLwbz7UmKgw+6iDsU76SGt35bpL3jVyXD6dAGOQ7U0eZao+mA8dFohXEQlpN4xyvjrae7R//aO9fbwxa0+h6mH9dvBvAXPswAOTPZaUt1gJisV6a2M4atWIcSPQACcSRO15F2Mf/JA6f47n9IHswHHuo5LVhQJSsLYEyF7CU+QaqgdsDWk2BmQgkURyac9dJYsXN0oQrrI4SzS8N+L27yTvM3H20MlaRjVZoL3sYzymOBnElb2wmm3TM1zfdOlR+cPglhbvB2MtAWW7/zIskNiNt4iFlZcraV2Cq97ivRjHIY9l6LnEcUSX8ZuurZLQ8RfuKndIRvuQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2LHdRuLIKYxGpkXuVVMXeWKO/Wx0TcrCxrPlxezhk0=;
 b=orxr4aBJZJH9zlFvOZsdtNf8TzRi/7zwKlNiMQLkl+VE7D2R22hAUhgMQ8CiJefXVsJ2iYT5gLomXV+hfT23Y50WimknOKcG64SgJZFZ51O7Dlv2zJcgqi4jgJLnYHrOTg3/oF3elrE+ISjVvRK9FCa+eO2vYyfEA3qNjZ1Ou7w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5902.namprd10.prod.outlook.com (2603:10b6:8:86::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Fri, 7 Mar 2025 13:55:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 13:55:57 +0000
Message-ID: <b3ce27d9-4b94-4e75-92fe-a42d6c97834e@oracle.com>
Date: Fri, 7 Mar 2025 08:55:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: queue-5.10: Panic on shutdown at platform_shutdown+0x9
From: Chuck Lever <chuck.lever@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <231c0362-f03e-4cef-8045-0787bca05d25@oracle.com>
 <2025020722-joyfully-viewless-4b03@gregkh>
 <0c84262b-c3e2-4855-9021-d170894f766c@oracle.com>
Content-Language: en-US
In-Reply-To: <0c84262b-c3e2-4855-9021-d170894f766c@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:610:5a::36) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 31480698-14f1-4a27-25c2-08dd5d7fc8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkJTb1gxejN3TU5LOExaYkdrcVovdkRkSTFPOE5mWlZ2djJZMmpUTS94WHpo?=
 =?utf-8?B?azlhb1psNld6NmpsUkR3S1g1MEkvNGpwa1lLWlV2V2JqQ3FXUWFybTZneFha?=
 =?utf-8?B?YTRta25QWDUvVjR2SFZXYmRjYk14bWI2djZSaUpucFE1NkJUc2I3a2VQejcw?=
 =?utf-8?B?QWZtN3NkZnIvZzVnNmN0UVJjMjR5STZYYXNjdlE2N2pBRTYwMkdwdzJkelJt?=
 =?utf-8?B?cWRJUjhlTlhtRWtGTVF3VUQyU3BoQkxwbitCckF2M0VOOGdMKzFNSFBwOGtY?=
 =?utf-8?B?ZWtJL21FTlp0MVAxUmZiN0ZhUmxJQks4dG9qM0diNUQyWmxOUVFaM0F2cC8x?=
 =?utf-8?B?azdneWJhd2F3clhmeUZ2eDd6STVvNTdNV1Vub2RJdjZLTndIU21qRiszelkv?=
 =?utf-8?B?WGlDaUhZam5xNHZleUlmWEl4L1pUckZUN09LeU9aWXlwUHQ1YTdmV1FDa2Nx?=
 =?utf-8?B?MG0zTlk1dUpXVXJVam01bU5KbW5kSFdBWnl5N1R3dHdZMHI5YTlPWmdLdWJl?=
 =?utf-8?B?NmhvTGxHa3lhQ0I3Q2JSYldmQnk3UnlXSTZhalBjMUVkMWErZDJrVjhpR2Jr?=
 =?utf-8?B?Ym9CaXcrQ0cxSkJUR0kxTDA5bTgxTVdFckhjL2VUeTE1V1U5MEovT05pZW16?=
 =?utf-8?B?RjdtRWJhS0JsV2pLQm13U254SWJ5K1FzMStqb0ZZL0FCSjIvL2xCMXZDeW9x?=
 =?utf-8?B?UmNKL3g3R0s5MEo0N09relI2OGJzNkxIYjFaL2JaWmVaWEtRUXRmckZIK2xS?=
 =?utf-8?B?WkExVFduQVJKR0RRaFM1YXd3VUFnV01PRVhicHpLZE96T3hrZmNnMks1ZFZX?=
 =?utf-8?B?bU83b1k3T2M3NjV1UVRDSHdtMzBQMUtkM0Qvc2prd2toVkI1Z3l4Rmo3VjNU?=
 =?utf-8?B?Y0M4bC9uek9BeVo2S1ZHVFVkTExwVjhBc09WSUJBRHdSdWpZd2VMK2lVOEZq?=
 =?utf-8?B?bmQ0bm8xNFpRKzkxbVl1Uk1MLzIzSENXTUlva0N1MWVwZ0hoSmdDd2xpZzFJ?=
 =?utf-8?B?UHg5a1FkYW0zWEM4SDEvZzVWUTJ1dk1wUWVWMldIWWlDRTF3R2tCczVxd3Vl?=
 =?utf-8?B?SFRNeUNIQ0FjTytlaW1iNFVLbHNrclQyL0NjczF5Y3RHcHlPd0kvZHhDK3RD?=
 =?utf-8?B?UytTbDUrTVIvZTdpdmFsTWE4eFdmb3RtVFl4anEvZHQrMFlKMHpDTFN3KzRY?=
 =?utf-8?B?TXlUMEJub0lqbHhiZzA1Nnh6cXFnaFlSQWRBT3JLa2dJNjA1L05BVXMyczFB?=
 =?utf-8?B?YVJOYmtxWTNDTytScXBXZXdsSEF6ejBUZG1aaXZCSTY5NUg3ZnRSRG5aYzVD?=
 =?utf-8?B?eWlSaWN3aitaODA3WTZ4NStrUkV5cUllNEdSNEhtbkhtTUg4NXczWC9kNjRW?=
 =?utf-8?B?RUE4OU9zSjVaVTZLYkxPL3ZkR0FkTzllYnM2YURqNm5ndXNkTm5OeEp6ZFRZ?=
 =?utf-8?B?NDFXYnFmMlB5TjJ3a01sY3RVNG5RWTRNd29nU2Fud1Y0RkJzNHVreHk2N0x5?=
 =?utf-8?B?eGNBcDZYMmkzVzBQSnhaS3NZSkdXYUtRdGNyRVNBMWpnZVY0ZVRnVzdWZUw1?=
 =?utf-8?B?dDNOUVhhNUc2REgxS2NFOTB0VU9sUjNEVUF0TDhSazlUMnVidi9XRHRjKy9G?=
 =?utf-8?B?WFBIRHU0R2VZQXhUNU1ZOHlDWS9OQTZVK1Mrbml4Q0twWW9qUWlob3ZLUjBv?=
 =?utf-8?B?MjZoUXA3aWVHc0ExNDlhRjBLMjJTeGlWak01OHUzZmxyaTRsNUpJSE0zSHpH?=
 =?utf-8?B?QlNzUXhDVU0zZWIvZkMyaUtsaDZPam13dXY1KzhzcDV2ays0VzB4RkNWcVRk?=
 =?utf-8?B?ZUNoMFc3dGpabTZibHRUUlRlNDU3ekcrcWdZbFErSGlkbE1tWmVHajBGT01R?=
 =?utf-8?Q?hRfNKAhY/cqiW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjdJK3ZpLzd3NTBLZksxVFZ3emxTbUZLZVQ1ZUhaTGZxWklza1JQWUxRK1VG?=
 =?utf-8?B?bmhJUmtQTmRHVzg3ZGxtUnhsTnpHalZ3ZzVrZnJjb2p3UFlWbkl2TEVwa0xr?=
 =?utf-8?B?SUtYcFd2TXhLeklEUUw4VDZEdFQ4ZXFqbnlXb0pUNmlrZDhkNU9pOXpkdWlo?=
 =?utf-8?B?QTRMUUw0RHlNVXhUSGFuMHJMcVRkYVArUVB4clc1eHpFSm5janJUU1pLUDM2?=
 =?utf-8?B?MmF4S3UyYVhXTXRqN0ZEMFJJMFJCVVZUMVh4VkRhbTRlRERzSWZwKy9JVTgx?=
 =?utf-8?B?dnYrOHJzVkt6aTl2K0lLRU5XdmpSZ05jc01lSUk4ZGplQ1Y5TVpmam9ob250?=
 =?utf-8?B?TUVrUGQ4QzFVbGFOS1lBWFFPais3S3RWbnpqMjVjYVJXelVUQTB2aFZnTEJi?=
 =?utf-8?B?MkY4TlJtV3ZkUkF1VVkwRWNnZUZSZGY5bjQ0dWk4TDhYUWNaQUVlaXYyNkRH?=
 =?utf-8?B?VitPUkVoREtpL2VNSTY2WFlGeFU3WlJpQVFsbkt6UzhzQ2hWNnIzVEIyMnY0?=
 =?utf-8?B?L0dVWnhiV2R6U21VejU3TzV1cStZbysrTzFoSXd6ZHhLTFYwSGJMSTdGci9I?=
 =?utf-8?B?UVVlY1hEVDYzVlBPY0ZVWXJlMFFtaC9Ec1NaaURldG8xU0lRejJXMXpjU1po?=
 =?utf-8?B?bVdsbzdRNVpkUFhOSytEYVczVG5IbG9PVkF5a3hxN0o1ejRqRURDeEtQNDBt?=
 =?utf-8?B?Y0lUbmhZdkRVVU5KWThSQ25uTFBMK3c0aW5KNXpFbG9ES1MzaTU5MjVHSDRT?=
 =?utf-8?B?TnZlb3hSWUJkUFNCU2QzeXdzRm5TZ0hXWmxJR0hsWm9xdHNFVEpHcnhmc1N0?=
 =?utf-8?B?WWxsM1p2aEJpVlZJbEdtblQ3clVxSjNwZ1Q1UE1uSzFaQjNRSUd6L2NhQllS?=
 =?utf-8?B?M2RzbGpIWmRXNXNWSjdzbmh1L0IzUVc2cjllcW5OYkNBSnVxOVpuL24waXdG?=
 =?utf-8?B?amdMOEZoc1Y1VmQ2ZG5udERsVHFKaWhkL3FTcWJKMzBETmtWb0h4bzNCTktX?=
 =?utf-8?B?a2p4enJjSUc0Ui9CZmJZNStSaUdNbzlJZGZMekJidzAzMCs3WDRjSGRzSEVr?=
 =?utf-8?B?NnlCL0NtUXFyK2N3QWJHQUpBeEoxaEp4THN0UzltN2FQMEdGb1Urc3RmWFVG?=
 =?utf-8?B?WmJ3Mmc2WjNxeTZxY1FNT3RlZ0xrNXExNjBvd05DeUw3QmJ1Z3VLMjBEb1JM?=
 =?utf-8?B?cDMxV1Z0cTUzOUtDa09IdXNBMTFaWitUWVgzVjBVbWNHbVNlNWdvRU54ZlAx?=
 =?utf-8?B?WnBacDJIVEp3RUFxYzY5NVlPM2R6cEJxRzNuTit2dmpPajM1V2p2OHY5ZDh0?=
 =?utf-8?B?KzJRSXNkQzRXYmtaTzkvR3Rld3ZZVGFKU1JKU0NDaVlsNjNMRExNVldlMkJF?=
 =?utf-8?B?TGU1ZlpKUlVUNnJGVlZsRTJBMUR3ZHdSRlRyV1RhUlQwMUpmdXptazNNNnpa?=
 =?utf-8?B?dmdyMmVQVG9NZ3lNcHpLSC8wcVhvNjU3LzhPbi8veUxCdWNBaTlLNmxZckdX?=
 =?utf-8?B?cmwzUzRFVjR3VVZ5cEl0UkhtN0VSSnl0MVhOTU9LV2k0UmE0cVdrNXBkRWR3?=
 =?utf-8?B?Mi94Wlc3YndBS2VmSnpFUk5EZm5ra1pVWWNQd0tXQmdVYUpKYU14R3lCVitB?=
 =?utf-8?B?cUpNNmlPcFF4NjV1L0J3L05pSnNlUVdKRk9ZZWdra3RuaXZtTzFnM0hhcDhh?=
 =?utf-8?B?anRoKzFyL1NxRDdtRWEyM3FmQ0xsUXlEbFBLdE4vWmxjTVRrcGdWbWJYU0Vm?=
 =?utf-8?B?YlE4UnppSlNQV1NxZUlEVGJpNU52ZDhDVXdPbzh5VXNkcGZqSEcwU2s0dVJG?=
 =?utf-8?B?OHdDZnNoaWFJV0x2VVRVMWo1bWFUTElmV2dZd1I1QU1ITStFTmN5MlI3MEYw?=
 =?utf-8?B?ZFhUZVp6eER1dnZCWFkvZ2R3WE9wdS80NnM1REgrMERMVUxYRFo2UGlBd3U0?=
 =?utf-8?B?WGMxajNlT0NNdTMrV0QvUmN3dXZKUWtJbUQ4L0ExdWIwSmhrWHNCeWl0dzgz?=
 =?utf-8?B?ejRlRzh3TXhESDVPR25BVmZUSDE5THFHRWxVZzJjWWZuYXhOUXIwcVFBblZX?=
 =?utf-8?B?N25MYzdOeTB6dmlmYlhnYS8rMjlUck1XUUYyUUhwT09Rb2cxaVJya2xMd1FI?=
 =?utf-8?Q?T0P+3740gU8xFkD0YfaHHyLUI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ekptCaE/Mcbgxd8j0oM0zyYy+nOJXCY76QmdztuYVp/uxSbiVodwgn4VSQ/hMaa4cHt7+9qWBbcEJTv0qGb5rbBLYL6UHgPiN0rsPAFBPNqsBjGrRlgHCa9R9SEpITrLbR5HErV+iusBfpZm+we98Jqns9YnCJlRengIPNNBrv4GJouGTWkI82pwCnxq8mpXEErZ/qcQIDnKHjp3+1WgSfALWQMQAuk9YaCCNgoY4PUW8drW/ufXLRduJDtS7kpcJm/hAbaLFE7lktwmAZESJj0zHPmmMk6/iaGfZOuSdKaqDsruBRTxM+061X4LSTP7OXW2IOS+cdVUxN3tMiJhZNqq9uuVO5yYU28J5aDbvhvcisf1njbqHiLY67uaOVG/p8mmZBEKucqSPypatqcP2k6ciP5E5TXaYjA37qHTW9iMpusz9JKG/yOQ/8MYroWctzHpJZ3hu0sbEgZZUYy8ZQQNWnPimkJDvNn9bBQlFcc0xJtjHtW9u3LhM+b06mmOITHYhZWjAMpasUXK6CxPXIpFuF7JmXyMp70IV/3JJsyXQPP1KKoJowhORgEgYY9YqVVvSlO/fs/i+JlhloJtq77MYnil5vc2AK/ccugGWKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31480698-14f1-4a27-25c2-08dd5d7fc8e9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:55:57.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjV5RZqIGiuH/sWB7OdsOE8pnP7qJCRdgKoLlughBRPtG7uPv+OoKJQgw5fOd+wA4tBW0y3Wn73/LRU+95DG+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070102
X-Proofpoint-ORIG-GUID: wZp14-124Zn2MYd-qSoNGUjETXg2Etid
X-Proofpoint-GUID: wZp14-124Zn2MYd-qSoNGUjETXg2Etid

On 2/9/25 10:57 AM, Chuck Lever wrote:
> On 2/7/25 10:10 AM, Greg KH wrote:
>> On Thu, Feb 06, 2025 at 01:31:42PM -0500, Chuck Lever wrote:
>>> Hi -
>>>
>>> For the past 3-4 days, NFSD CI runs on queue-5.10.y have been failing. I
>>> looked into it today, and the test guest fails to reboot because it
>>> panics during a reboot shutdown:
>>>
>>> [  146.793087] BUG: unable to handle page fault for address:
>>> ffffffffffffffe8
>>> [  146.793918] #PF: supervisor read access in kernel mode
>>> [  146.794544] #PF: error_code(0x0000) - not-present page
>>> [  146.795172] PGD 3d5c14067 P4D 3d5c15067 PUD 3d5c17067 PMD 0
>>> [  146.795865] Oops: 0000 [#1] SMP NOPTI
>>> [  146.796326] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted
>>> 5.10.234-g99349f441fe1 #1
>>> [  146.797256] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>>> 1.16.3-2.fc40 04/01/2014
>>> [  146.798267] RIP: 0010:platform_shutdown+0x9/0x20
>>> [  146.798838] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
>>> 75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
>>> 68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 ff e0 0f 1f 00 c3 cc cc cc
>>> [  146.801012] RSP: 0018:ff7f86f440013de0 EFLAGS: 00010246
>>> [  146.801651] RAX: 0000000000000000 RBX: ff4f0637469df418 RCX:
>>> 0000000000000000
>>> [  146.802500] RDX: 0000000000000001 RSI: ff4f0637469df418 RDI:
>>> ff4f0637469df410
>>> [  146.803350] RBP: ffffffffb2e79220 R08: ff4f0637469dd808 R09:
>>> ffffffffb2c5c698
>>> [  146.804203] R10: 0000000000000000 R11: 0000000000000000 R12:
>>> ff4f0637469df410
>>> [  146.805059] R13: ff4f0637469df490 R14: 00000000fee1dead R15:
>>> 0000000000000000
>>> [  146.805909] FS:  00007f4e7ecc6b80(0000) GS:ff4f063aafd80000(0000)
>>> knlGS:0000000000000000
>>> [  146.806866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  146.807558] CR2: ffffffffffffffe8 CR3: 000000010ecb2001 CR4:
>>> 0000000000771ee0
>>> [  146.808412] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>>> 0000000000000000
>>> [  146.809262] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>>> 0000000000000400
>>> [  146.810109] PKRU: 55555554
>>> [  146.810460] Call Trace:
>>> [  146.810791]  ? __die_body.cold+0x1a/0x1f
>>> [  146.811282]  ? no_context.constprop.0+0xf8/0x2f0
>>> [  146.811854]  ? exc_page_fault+0xc5/0x150
>>> [  146.812342]  ? asm_exc_page_fault+0x1e/0x30
>>> [  146.812862]  ? platform_shutdown+0x9/0x20
>>> [  146.813362]  device_shutdown+0x158/0x1c0
>>> [  146.813853]  __do_sys_reboot.cold+0x2f/0x5b
>>> [  146.814370]  ? vfs_writev+0x9b/0x110
>>> [  146.814824]  ? do_writev+0x57/0xf0
>>> [  146.815254]  do_syscall_64+0x30/0x40
>>> [  146.815708]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
>>>
>>> Let me know how to further assist.
>>
>> Bisect?
> 
> First bad commit:
> 
> commit a06b4817f3d20721ae729d8b353457ff9fe6ff9c
> Author:     Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> AuthorDate: Thu Nov 19 13:46:11 2020 +0100
> Commit:     Sasha Levin <sashal@kernel.org>
> CommitDate: Tue Feb 4 13:04:31 2025 -0500
> 
>     driver core: platform: use bus_type functions
> 
>     [ Upstream commit 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f ]
> 
>     This works towards the goal mentioned in 2006 in commit 594c8281f905
>     ("[PATCH] Add bus_type probe, remove, shutdown methods.").
> 
>     The functions are moved to where the other bus_type functions are
>     defined and renamed to match the already established naming scheme.
> 
>     Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>     Link:
> https://lore.kernel.org/r/20201119124611.2573057-3-u.kleine-koenig@pengutronix.de
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Stable-dep-of: bf5821909eb9 ("mtd: hyperbus: hbmc-am654: fix an OF
> node reference leak")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 

Hi Greg, I still see crashes on shutdown 100% of the time on queue/5.10
kernels. Is there a plan to revert this commit?


-- 
Chuck Lever

