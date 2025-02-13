Return-Path: <stable+bounces-115206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488DA34278
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB746188D103
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376C28382;
	Thu, 13 Feb 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hxRRkY4T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xs0Rxk/2"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304E4281360
	for <stable@vger.kernel.org>; Thu, 13 Feb 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739457250; cv=fail; b=FNco4K5k8fhMPJdA468Jg4W7tE/sNxtt4U4hB2zqb2gwf9pP2MLK6Mw45QiDQ8cG+/79BjwuCaI3MVQ2IsJE8BtXh/PUA7GmbE9HxrBQqJwR0v5jxcptsPmr/SkfNbdnECzTJdOMf6uOqMrx8dt/+0suSxVIDqKg+ofock4GAd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739457250; c=relaxed/simple;
	bh=sXNEVG3Gb0msQN1xVcwJggONOK2VleV2hrk3HPNPuTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lmLbU1O5bNAYGnZvpjvBnyRZGPnmW9JuK8JIQUDn6io3e2NN0mc2zk+RhOMCBll6GqYtAliX0PvycWJ3CDiqqgUUUjCoB2mw/k5YhpOW8XLjGtXsI8Vr4O1sgI0Xu9pL+zOk3epqP/OuBjyLX48doQegndH0xbuDKQCqVw16oAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hxRRkY4T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xs0Rxk/2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fqfH022145;
	Thu, 13 Feb 2025 14:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=S0ZDPH360H8ZFgXZrXJ0w+RtlCEh+MCkeAjuZiMaII4=; b=
	hxRRkY4T1NNYnQSxj3/ov2Avq5ywckjYij30LbiFURbJf6mRrGDAR8LtSX55TZ/s
	8+so9bMe3TU9I5Qg03d4PdvTXtoS8WdMOU/mN2U2WmP5gkiypaZQCLQSECE0SrGB
	slPe/UXK2lnXUSreAfsCCbyteEjEoogHltp3fv05bpT/B+GI0M6Lf3eDll+iAF+Q
	tsU8ToKVG0xKeBA9qORhr/AoFpg4NkKLeiWGkknzwyQQh6n/R9ijLNLILT0WdXOx
	u7FSYbUQ7+HjSM9zvWYm6WxF+gcWCMj1vR20saGg5oKV16CZcbvRi4cpGIl+4Zt8
	sDSXhiFCooOC8+h3eSCcsQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t49mwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 14:33:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DEOog3012516;
	Thu, 13 Feb 2025 14:33:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbrtnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 14:33:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHSNRamnIgTMJy6FmTHFdirpP0VDVlAVwocxeW0TBpN3diuHsLdTfjsYdbs4qg5JahbIPOVkMxv+ikPPtMn/xicIH8Ey7XKhVxzcfN3wS2H9nCM5O97C838xB39IHD9c2NsCK3H36JQDPksrU4tdF0CL3YCXLSN7I1QAAPEIlfvpBF6eo/32MoHiAVqM2YWrp5Um/UK3SxjvD9xRP7uIpBVPPdLS0qK0sfQxEJDJhkv6QfAH/7iJSbZZOigYfDFGmiboh0Oy1C2yMVjZJm0YOcm2hzuJTFkCrHmRvMv6xQFi1ZjqDw1yqfI+aKoZo68RWlRjNgHfTgv58cH3trm7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0ZDPH360H8ZFgXZrXJ0w+RtlCEh+MCkeAjuZiMaII4=;
 b=wm9hlnV07WKE5f7QovIdxmDcdY02U0yHwnQtsOX1pmhvGNohGQ6HliGlzbZfzbwNZgqo/EQZPmbZvHZVkZ9xyQeB0UU5PU/8x+lYM5hJlp76GIVDQmm+hk5i1XTD2kYvAxMhgea1qhzyhLN8xgeXZQ/R79nWN/M515D1V4499TySpjXJEGOcnIxL9dZgbCpPJVwqD/5hDu6W/rmMkwvEAPuJyuFX7482JURl4Vwtcl9o1apNtpRIRNqhWwQKMmujdOV8HQs4VHu5xRSxNYRMGx3ZneNCisyqZJ0ZFkMz0T1ug/6kBwmmZosY+HJKc3/ncovxYqapP/sEPBbJsi+ZQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0ZDPH360H8ZFgXZrXJ0w+RtlCEh+MCkeAjuZiMaII4=;
 b=Xs0Rxk/2rJsYNRl3S7V3dahmkgbG35CB0bjTCRdHpcx9vmAOpIAdE7UNipdf0j4yNB9CI2BAGmHOQPVjrTkFbbG+xF755o4IKViELDOukCmfIOYO2r7zJiq7VWMNBVu//TI06fVFE2kqyyOpVe0/gy4KFJJ78xRddqXieBku8BM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5836.namprd10.prod.outlook.com (2603:10b6:a03:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 13 Feb
 2025 14:33:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 14:33:51 +0000
Message-ID: <efaa6bcd-1c53-40c8-80a4-d2c48d2e02b5@oracle.com>
Date: Thu, 13 Feb 2025 09:33:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] nfsd: release svc_expkey/svc_export with rcu_work
To: lanbincn@qq.com, stable@vger.kernel.org
Cc: Yang Erkun <yangerkun@huawei.com>, Jeff Layton <jlayton@kernel.org>
References: <tencent_950F86B5018E36B766EA4357D2C8BA1AC705@qq.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <tencent_950F86B5018E36B766EA4357D2C8BA1AC705@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:610:cd::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: ef869539-4243-48fc-e782-08dd4c3b6f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bktDekx2bjZ6VmJhYWNFQ3V3SUVlazFhTTZqcWZWRDNUZHN5OUhTalU5Z0Fq?=
 =?utf-8?B?U3hMbXNvK3NSNHNkMFBMdzUvZi9SamJNWVJHNlFnQm42d1FSOXJObFZmZXdW?=
 =?utf-8?B?RjhZeXAzczMvYlFLczdZY0U0RkZwSWJTRVRJaWFkbjJ2ZmVtbVpGRk9sdUlm?=
 =?utf-8?B?WVlDYlM5RFVzeERhVlFIVTNyTHJnQ0JOUGpackNhS1RwRzdpTnNhLzlURTVS?=
 =?utf-8?B?S1ZlaVFNWHJBdmZSQ0hUdjZob3VaZTh1WTBmM01NU3JnN0hFSnBzNkgzZ2hu?=
 =?utf-8?B?NFFTbUJaekhGcDlCYSs0eGVmUWg4dlR4YkhnL0lJZUNjTVIxUUpBM1hqMENJ?=
 =?utf-8?B?dGJKWHRJSHZCN1B0Y1kzUzRhSU9sRXVGM1RxUWptMmJpUVRXdCtQbVFKM2tG?=
 =?utf-8?B?WkhJNFJ2ZEJXUmVlOXJpY08yZmVrSUhDNHdyZXBYS3p4Y21SdXE4VjRxYjJj?=
 =?utf-8?B?OVNxMFVTTDFKK2ZoTThjd0xYTXlFbzZBaUtPd2tJOWNvaTZuZjdVVTQzc2Fz?=
 =?utf-8?B?eXFLc0o1cUZ6MmF0bFlQLzdxUXVSUFl6MHIrUEt5ODd4TU9NRkc4KzZaUE9B?=
 =?utf-8?B?c2tDdFJXYlcwaDVNc1YvcGtOd2tYcmowbTZ3NnJKRnZBNFZWaTh6WnBCZ1Vi?=
 =?utf-8?B?OGdDTDN1Sm9hay9VTEY4VDZaQ0dqRDVwcmtEOEhiWWs0V2c3TnV0bTJCZ2pu?=
 =?utf-8?B?L1AzZXJ6ZVhzRUlFdGhVTUx4VkI2eGhHWW1iWTl1S3VDN05zb3BaaHd5cit3?=
 =?utf-8?B?cFFwM0pJc2J5dG14a1AybmNqOXYxZjNCYjVRZ001bWFMSkdHVk01WjZmL2Vy?=
 =?utf-8?B?dWttbTZTS28yc05ScXE3ZlVPcHY4NDFUWXJpVjB4cld0eE4xUDdYS1RwZzBD?=
 =?utf-8?B?MVRBUkpqd2t0WklFM3dwWU1Bb0h6Z1B1eEtBWVhaUzRrZkw3RmhqR1ZUcHQ4?=
 =?utf-8?B?bjlzeUxpazNkbjFCeEY4OFZ4cHFqYWpLRnMzZzR6bUxrMlA5ZHB0WkM0SThu?=
 =?utf-8?B?RGJqeGlqM3pDaEpzQkd6VGl0WVdUQy84RHNISm1XUFRWUjlBZ2dycWwyc2Rs?=
 =?utf-8?B?Z3VlNVordjV1SG5yYzRjSTd5REJsY1dMUkY1S29CRjZDaStCcWNTaGVPYWFZ?=
 =?utf-8?B?aVRZQ0hhMUNwZmZNWDBMWmtpZk9GWmNHaUQrVDlZazYwVXdBOGNNWmNib0RP?=
 =?utf-8?B?c3Z2WW5UamlxY1JEZzltOFViak5KaCtOM0VmV2FTY01NRktPNUJGMk1KSDVj?=
 =?utf-8?B?Mk5ib21LT2JwdmVkNUE5UVcwSy9tNW9Ud1FiMTF3YVdGTnA1UUVwRDJUSmpl?=
 =?utf-8?B?Q3U2TjNLWnY3ZDNib3ZnbHk5UVFwZmJiN1haQnhMTXFZbm5Cb0lORTltblRV?=
 =?utf-8?B?S2hrbVBJZ1Q1RE5EdnllSDVCRzcvc1VJWG9hVHFvOUpaem14eitCVkd5TFkv?=
 =?utf-8?B?Z0NYcE1MbTdVdEt4SVlTeW9FYzdpVDJBT0k1K2FvWXdKTnQ2b25ObzljNTJr?=
 =?utf-8?B?Sk4xRThyVkZoczF4WWcyZDRyUVduVUFMQjg5czdUbE5JVnBqYU9XaVFobUpu?=
 =?utf-8?B?MEhxa1ZObnJzNEhLZzlLTlF5bG1qSVZLcjg3eG1LTXlpYzJycXI2dEplWVJF?=
 =?utf-8?B?b3djUU43ME5UTytzaDhZZU5XdHZCT2RoYkRZM3dBUEgrSDhQZWswSk13bE03?=
 =?utf-8?B?dlZlaVJ3dTJGb0xyNFd0dkFBZlNUaitaT0lncENIdWIzdmJxcmhOcjJJanBY?=
 =?utf-8?B?M0p4OUlNR0dxWW5mc3d6T3JqeW9yMjdlWGwvbVdNZGVETE0rMzVCem5IZG1I?=
 =?utf-8?B?cjdMY0t4NVdWbVV2QzkrZ0gxeDJsL0thSXpSMUh4V2lvTVR1OEdjVFlwYmU5?=
 =?utf-8?Q?df6lOg8qm5En3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGs2cXIveFgrM2hQOGlUeFd4SHhSTkJWTjV5emsxeU1yM1JYOUdwMGh0bGR1?=
 =?utf-8?B?cWMya0pUMDNvM3Y4V1VheWZ3NXlyY2lFa0o2MWtJa3JCSHViMW50R1JuOGtV?=
 =?utf-8?B?YURySEx5TEVzUWVuMGlHZk84dXpvdHpHZmxPMFI4SXFqZTdMNXo0VndBZGdQ?=
 =?utf-8?B?TmxaVUpObzdJbXF6bDdwVTY1MndiSDdOYUEyVEROem5NdWlyMzZwN2tjQWFR?=
 =?utf-8?B?SVh4ZUc4MXA3ekcyVHZiRHluRkdYZkcxQmhqVUJRM0RQcmR3T2I2b2duNEhv?=
 =?utf-8?B?UnlpcFhiT0MwTGI1TXRkQ21XKzJ4eGNEVWRtMlJZWDhlVWlCejVoZmlVZlo4?=
 =?utf-8?B?QThLd0J3N0s1L3F6YkgvMEI1QWhqRFdtSUQ0UWgwK1VVeFgyLzJiVzN2OWFj?=
 =?utf-8?B?K3Y3MnlMWUhvY2QrTStCM0kxV1cwaDhuVjlyYWFyVG54U2pzcTNjOGgvK1pw?=
 =?utf-8?B?NmhBdGptV0VFWFVUWDhBbldKalZGN2h6aWF0akhzS1ZLKzkzUHZ1N2VFaDdk?=
 =?utf-8?B?cysyNkZtN01SUTl2cG5Jb0k0TlluaDdTd1lRMndNa3dwNGtzWktNdjgrcVRD?=
 =?utf-8?B?N2NaOEVGeWNVT0tzN2h6SisvQjVad0t3amNvTFowWFZFZ0tkS2l5V3Y2bHI5?=
 =?utf-8?B?STREUVB1d25tQTd6a3MySERpTjdoSGFUcFVmNHNibHNyWDJPbWNmYk1VbklK?=
 =?utf-8?B?bnFiRnJCelF4Rkc1a21ST0QxZStES2pEYTRKaGJLRDV1THZGYm1Wb2tKcktu?=
 =?utf-8?B?QSsydUN5aGVvdGwyZEhWdFVLSjdXQ1ZSbm4vOUxlZ04wWklHc2RSOFkvejNG?=
 =?utf-8?B?UjRVLzVPME90blFJZ3IzQWowS3hpQjRCVnQxKzBweStFS1JrOHl5UWErRnQ3?=
 =?utf-8?B?M3hQaUE1bi9rSDJOdWRxYkFrc2s4eExpMDd3bHlRZ2lrUld1M3oycFJMU3hw?=
 =?utf-8?B?K1V3cWk1eWJhU3UwbVI5MXRDQ3FaUFJtN1NSNTgyMTRVWGJZT255UGpxY25I?=
 =?utf-8?B?dDRZV21BdmIxWXJoeGNzZTJiM3dJeUdDNUxOVnhaV2tWRWRCaEdtTEN6ZVFR?=
 =?utf-8?B?SUZWS0R2aDJFVjgyK29rb3EwMXZGd3p4Ly8wd3E3RnZrQ0pKZ0lxcHdyWUUx?=
 =?utf-8?B?bUxpdU95ZVhMRWxkZnZqRDI0VGUycU12dTVvWm9xQWZpNmVrV2FaM1M1enp2?=
 =?utf-8?B?UnNxWE8wYUhNNUJKM2lBNU9oVG9nYkVscVc3NVZjam1Ud3NWK29nYmJzcmJi?=
 =?utf-8?B?cmkvbDF6NlpTVzBuQmlmS3AvdVRoNExyNjZsMTNoOHVvdm9lUDlpdkNJcUlN?=
 =?utf-8?B?M2VZV1VWODdBQVpkVWtOdlMzckFaLys3VFQrZTBOK29FTmRVMS9wcndIL0Ni?=
 =?utf-8?B?Z05RWHYxdE1jemxNSDJXcDNlcWFSS2JQKzhaazNjRHphemF0eWJ1UjVqYVRK?=
 =?utf-8?B?QWh6TElpYU9nV0xzeTFpbldXYWpiZGhFQXpHNms2b3c4dEUrYi9qWlBVeC83?=
 =?utf-8?B?dW0yTDQ2dXdrS0o5N25wTFJ5VXJmNDA5R2MvVnh2VmpJSWdDVTVjdWlsT1g0?=
 =?utf-8?B?L2J5Ky82ME9aZTRYOUxnMnAxb3YvTEtjaWV5WVR6aC9aQzdRbDlZRWdkQTA1?=
 =?utf-8?B?bU10NkxxaXRiZmR4YTBnZWQ1bWNURXc1cWtIQVJVdnY5eWtCUWIvbE84cXdC?=
 =?utf-8?B?VHAyR2tSRExPRVBXN3ZvVnhtbE5oZ0lFWENNdzFoM052eHord1ZBMmJ3dWxK?=
 =?utf-8?B?T1J1QWRYR3JGcGlZOW0wOUtKV2FGMFB3amJwL2gxRDhrcHBpaWRGV21FWUxJ?=
 =?utf-8?B?Qi9KR3ZzcmJWZU5UT1JZOHFGK2lmTmIvRjlwN3lzSUJmZFYyYk9iMUhLYzU0?=
 =?utf-8?B?bzZvY3IyTG5DSzlXRzd3Y0l3RUJZK0pMekFEVVhyTG51NlhVZ240ZkxyKzlJ?=
 =?utf-8?B?UWpyQVA3eks5OFovcktHTXpuUWQ5ZEV0djlDc2U0czNaMWxXYWNKazhOUHZX?=
 =?utf-8?B?eDFaUGZIUnEwRXRkTnAvMG9hYUdVaFNlTHdpMkNuODNJUUZreVZ1dzRzS0hz?=
 =?utf-8?B?SUd6RFAvaSszb0JZODhPenl4ZFVPSlVGaTE0NXJ4YWQySUl3N2J1RSs4dSth?=
 =?utf-8?B?TERCRFUxeDRnMkdkclgwK0hFWFBRMHB3OGhsVi9UTGFvZk9zaHJDK3hvakl2?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nvEI5ykxJwAawNYUz5QUVAsu279uSY3XONIRXmr8wnsIRb3zDO/5D0ogDBx8zynGdBLFY6UuhePhvZzAh3NOkZi8Cn2rbJKtEOmd2dBfoCi1FrSBk30GJpVPvZShWr7Y//DvpxYvIXm1py9igzt8YNuW+gWVzryDWTCjv0AcjAk1AAVuNjin4l8PCW3ev9xXBUNrpifYbhRCgF3umZYGbviI8QaqpUeSHdLozGv4+GrvYLMbY3DhXDujZnZN/loGGz90Qwz16hSaQEvMZby6AFjn7G8NSfylvJ59HUakGKd3oqhNgsyYLlx55Kbcs+CIrH9k4jmESA1SM9yRUaPLj/cRGtrg0Z/26De0s26qNBHc8JTqRkBj/3nhmttfJktqXs+bQhECRxmshYwQUjHmclrUbOmh5zeUkXLJsc666htu1ubG6eIMJ4SScl8ClyZQeduebsnxX9ug8d3XifA2kTwNB6d1pZGlAA1PXI3wq+/5vuRlgwgECyg/Qr6FWv4iK1a/EomwqM4NDhpmnFsQecA0k4b9WpkWjXQfWv3FdNrNox5d5wy9gJ5X+DZZSpw5HFyrP8fD+zWBzZsavO3ykVU1IzMuNwxqJ7N8iLsy704=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef869539-4243-48fc-e782-08dd4c3b6f50
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 14:33:51.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6IfUv7kg2Wmcitk7Pkplt/70lBElOBdbbITC6JeqDC+BQP6FZr5jBWLVJHcjyh7wKqvxY3UXx21yQY6PB7I/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130109
X-Proofpoint-ORIG-GUID: aIlVK0sI6Sm14Hc3bPAMio6SjNTt8I8C
X-Proofpoint-GUID: aIlVK0sI6Sm14Hc3bPAMio6SjNTt8I8C

On 2/13/25 6:46 AM, lanbincn@qq.com wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d upstream.
> 
> The last reference for `cache_head` can be reduced to zero in `c_show`
> and `e_show`(using `rcu_read_lock` and `rcu_read_unlock`). Consequently,
> `svc_export_put` and `expkey_put` will be invoked, leading to two
> issues:
> 
> 1. The `svc_export_put` will directly free ex_uuid. However,
>    `e_show`/`c_show` will access `ex_uuid` after `cache_put`, which can
>    trigger a use-after-free issue, shown below.
> 
>    ==================================================================
>    BUG: KASAN: slab-use-after-free in svc_export_show+0x362/0x430 [nfsd]
>    Read of size 1 at addr ff11000010fdc120 by task cat/870
> 
>    CPU: 1 UID: 0 PID: 870 Comm: cat Not tainted 6.12.0-rc3+ #1
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>    1.16.1-2.fc37 04/01/2014
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x53/0x70
>     print_address_description.constprop.0+0x2c/0x3a0
>     print_report+0xb9/0x280
>     kasan_report+0xae/0xe0
>     svc_export_show+0x362/0x430 [nfsd]
>     c_show+0x161/0x390 [sunrpc]
>     seq_read_iter+0x589/0x770
>     seq_read+0x1e5/0x270
>     proc_reg_read+0xe1/0x140
>     vfs_read+0x125/0x530
>     ksys_read+0xc1/0x160
>     do_syscall_64+0x5f/0x170
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>    Allocated by task 830:
>     kasan_save_stack+0x20/0x40
>     kasan_save_track+0x14/0x30
>     __kasan_kmalloc+0x8f/0xa0
>     __kmalloc_node_track_caller_noprof+0x1bc/0x400
>     kmemdup_noprof+0x22/0x50
>     svc_export_parse+0x8a9/0xb80 [nfsd]
>     cache_do_downcall+0x71/0xa0 [sunrpc]
>     cache_write_procfs+0x8e/0xd0 [sunrpc]
>     proc_reg_write+0xe1/0x140
>     vfs_write+0x1a5/0x6d0
>     ksys_write+0xc1/0x160
>     do_syscall_64+0x5f/0x170
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>    Freed by task 868:
>     kasan_save_stack+0x20/0x40
>     kasan_save_track+0x14/0x30
>     kasan_save_free_info+0x3b/0x60
>     __kasan_slab_free+0x37/0x50
>     kfree+0xf3/0x3e0
>     svc_export_put+0x87/0xb0 [nfsd]
>     cache_purge+0x17f/0x1f0 [sunrpc]
>     nfsd_destroy_serv+0x226/0x2d0 [nfsd]
>     nfsd_svc+0x125/0x1e0 [nfsd]
>     write_threads+0x16a/0x2a0 [nfsd]
>     nfsctl_transaction_write+0x74/0xa0 [nfsd]
>     vfs_write+0x1a5/0x6d0
>     ksys_write+0xc1/0x160
>     do_syscall_64+0x5f/0x170
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> 2. We cannot sleep while using `rcu_read_lock`/`rcu_read_unlock`.
>    However, `svc_export_put`/`expkey_put` will call path_put, which
>    subsequently triggers a sleeping operation due to the following
>    `dput`.
> 
>    =============================
>    WARNING: suspicious RCU usage
>    5.10.0-dirty #141 Not tainted
>    -----------------------------
>    ...
>    Call Trace:
>    dump_stack+0x9a/0xd0
>    ___might_sleep+0x231/0x240
>    dput+0x39/0x600
>    path_put+0x1b/0x30
>    svc_export_put+0x17/0x80
>    e_show+0x1c9/0x200
>    seq_read_iter+0x63f/0x7c0
>    seq_read+0x226/0x2d0
>    vfs_read+0x113/0x2c0
>    ksys_read+0xc9/0x170
>    do_syscall_64+0x33/0x40
>    entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> Fix these issues by using `rcu_work` to help release
> `svc_expkey`/`svc_export`. This approach allows for an asynchronous
> context to invoke `path_put` and also facilitates the freeing of
> `uuid/exp/key` after an RCU grace period.
> 
> Fixes: 9ceddd9da134 ("knfsd: Allow lockless lookups of the exports")
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Bin Lan <lanbincn@qq.com>
> ---
>  fs/nfsd/export.c | 31 +++++++++++++++++++++++++------
>  fs/nfsd/export.h |  4 ++--
>  2 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 39228bd7492a..78db46f6cbc6 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -40,15 +40,24 @@
>  #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
>  #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
>  
> -static void expkey_put(struct kref *ref)
> +static void expkey_put_work(struct work_struct *work)
>  {
> -	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
> +	struct svc_expkey *key =
> +		container_of(to_rcu_work(work), struct svc_expkey, ek_rcu_work);
>  
>  	if (test_bit(CACHE_VALID, &key->h.flags) &&
>  	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
>  		path_put(&key->ek_path);
>  	auth_domain_put(key->ek_client);
> -	kfree_rcu(key, ek_rcu);
> +	kfree(key);
> +}
> +
> +static void expkey_put(struct kref *ref)
> +{
> +	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
> +
> +	INIT_RCU_WORK(&key->ek_rcu_work, expkey_put_work);
> +	queue_rcu_work(system_wq, &key->ek_rcu_work);
>  }
>  
>  static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
> @@ -351,16 +360,26 @@ static void export_stats_destroy(struct export_stats *stats)
>  					     EXP_STATS_COUNTERS_NUM);
>  }
>  
> -static void svc_export_put(struct kref *ref)
> +static void svc_export_put_work(struct work_struct *work)
>  {
> -	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
> +	struct svc_export *exp =
> +		container_of(to_rcu_work(work), struct svc_export, ex_rcu_work);
> +
>  	path_put(&exp->ex_path);
>  	auth_domain_put(exp->ex_client);
>  	nfsd4_fslocs_free(&exp->ex_fslocs);
>  	export_stats_destroy(exp->ex_stats);
>  	kfree(exp->ex_stats);
>  	kfree(exp->ex_uuid);
> -	kfree_rcu(exp, ex_rcu);
> +	kfree(exp);
> +}
> +
> +static void svc_export_put(struct kref *ref)
> +{
> +	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
> +
> +	INIT_RCU_WORK(&exp->ex_rcu_work, svc_export_put_work);
> +	queue_rcu_work(system_wq, &exp->ex_rcu_work);
>  }
>  
>  static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index f73e23bb24a1..fa545d8dcc36 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -75,7 +75,7 @@ struct svc_export {
>  	u32			ex_layout_types;
>  	struct nfsd4_deviceid_map *ex_devid_map;
>  	struct cache_detail	*cd;
> -	struct rcu_head		ex_rcu;
> +	struct rcu_work		ex_rcu_work;
>  	struct export_stats	*ex_stats;
>  };
>  
> @@ -91,7 +91,7 @@ struct svc_expkey {
>  	u32			ek_fsid[6];
>  
>  	struct path		ek_path;
> -	struct rcu_head		ek_rcu;
> +	struct rcu_work		ek_rcu_work;
>  };
>  
>  #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))

This one probably should have included a Cc: stable@ tag.

Acked-by: Chuck Lever <chuck.lever@oracle.com>

For 6.1 and 5.15.


-- 
Chuck Lever

