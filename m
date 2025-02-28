Return-Path: <stable+bounces-119909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F689A4935C
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801787AB7C8
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCB8245013;
	Fri, 28 Feb 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BM7dgC/x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zwnGZkt4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F49243361;
	Fri, 28 Feb 2025 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730857; cv=fail; b=Allc43Q0prx3XqbvN9H5xxRgcV7KPD2WcUROGHFriRY0vJWiCjxiMNSvZ5CSCkr4VEbXlLVV3+xABTBjYYF+QTiXZ1kasUOuHy690rgbS6OMW6ep46K4SxoCOaSb/jO8uRjMuIUJ9Gh7Fk8g2/1fLbIH4+eC9ZFTMtQIFAK4cDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730857; c=relaxed/simple;
	bh=OqksK3CXe95Ob1F+wskg5GYgPIpegbT6CkkbCcYoCDA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QQCtpBaz3iQjyCNhxw2u13HvZHFKb6Vb06FgIIpE0vxAGkL2plOkZ1XkUJVGFdaLhKM6RXomPh06C2ih/xdEidj5d/Ojvuno6vv74vM08cH6aSCB6/ioC/Sgp6DdelCpGmUFRsamswnQTtvy5UbnXINFBuHK2uNleiUPfCThnCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BM7dgC/x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zwnGZkt4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1BsRZ032617;
	Fri, 28 Feb 2025 08:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Z4/l5kDxVddHhZ7Wtyrd/05JoRdHW0kUYWuJrp0WF/U=; b=
	BM7dgC/xCNa0zRZkkY9hqXSn0zWi1bM6rbQcFvbp6ly8lrAnqqMfaQRQt5bXIovr
	332WwXbryl0BVXAWC4cj6oZqwSlcZTYCPmpuEo5yEMy+wtZW4oh5kEyIE8rKMdJJ
	cWteBxaQHX1rlQoLu+I69vf40t7RYkeMydXwhPTJ2y4wQDeYKZlSx5Pa1qrdkuYj
	RRobk4SzeEwTiVJ8jpIHGp30QdiSu+AQvC6fqYvbNEtv0JcfrBLsOMLnGXRtWXaQ
	oaGewDkV7Bqq9N/p+x9o04h4x6m9mjlMuori5n5xk1IjAmtVxA66yCpjb/VGInTd
	B5xvltPxnuhv+HISqkvNgA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfw1pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 08:20:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S65oei013230;
	Fri, 28 Feb 2025 08:20:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4530jwk0fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 08:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tctr2nDKRsHaouI5ySRLw6mNNhvEqX3fS7VlB/xAOqPSs4BmN+wH+Vq9a/4mnL7APPrhrbFAQib+XFfrUM0X3/X8RZ2a9Hj5/2ovddpC7D7u7ONxmeUi19ZVeFddoeb9YCGd0KOTdF7MC2Cddjy2AHm5DO0dShr4RYvvsix1iGUNzKvGvaWaSGbtsURAcjGeO9YRp73IBPfJH1tlToW5Yv2WcitbuGfK4Jlbww6R9zlf5Uw57lFD2xR8SD9+msE/ipZ4KIaqgck2aP1XcOSQc7O1xp3WXNxXpENNhNt6f7OrCepztkNrQL/SzcsLbYI7VVn4sln+Q9X2Zr8rsMjTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4/l5kDxVddHhZ7Wtyrd/05JoRdHW0kUYWuJrp0WF/U=;
 b=AI+EX4EUIdGODHpOuEwoGp55SZ06IV3dGZgOCpp63jfpvBeyQMvlzBY18kUB3El3SUbNZlkT8ksAFpks9zrq75Q6X+gJtPnP7XPVPhgjntbYws0NU0FoeZ7b6Nq6OPFQuC9JjF2oi5PupcI0O8sr0iRa601qWQIablyjUZbs5htPSN0ZBDEWGMMggFmY3LZsmfH3V0EQMM1Iy+Vn4bMVwjRzrLBUuynnBmDlwGexkQnjRqjsYQtEs8O63LbaxW0XkEHVTkH2a6ZhxBiTJwb1LPxJZ4ilaoW+aCYJ5kq2N3LSRhES8OxZ5/KbxDmkN81ZVEmU+UiMoJOn3tbI1D/H3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4/l5kDxVddHhZ7Wtyrd/05JoRdHW0kUYWuJrp0WF/U=;
 b=zwnGZkt4QlKbpkzvYDQhTYpVRGUQNId/nwMn3MqemPCH2p3F0ihjDpVCi9Uz475aKIalb6ip/QDjEjpYZHp6qICynVbVZrXNSWI9Iv7xBfs649/FlUzZz4M9dZ0SjEQOzYZ9YsnNFISdi+5nL5ziZk/IrhC9lJjKyN2N4GfZOB4=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Fri, 28 Feb
 2025 08:20:20 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%3]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 08:20:20 +0000
Message-ID: <e01c39ad-6f5e-449a-b24a-db3b7984030e@oracle.com>
Date: Fri, 28 Feb 2025 13:50:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add alignment
 check for dma buffers") when booting with Xen and mpt3sas_cm0 _scsih_probe
 failures
To: Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sasha Levin
 <sashal@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
        =?UTF-8?Q?Radoslav_Bod=C3=B3?= <radoslav.bodo@igalileo.cz>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
 <Z6ukbNnyQVdw4kh0@eldamar.lan>
 <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
 <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>
 <2025021548-amiss-duffel-9dcf@gregkh>
 <74e74dde-0703-4709-96b8-e1615d40f19c@suse.com>
 <2025021533-grime-luminous-d598@gregkh>
Content-Language: en-US
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
In-Reply-To: <2025021533-grime-luminous-d598@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|SJ1PR10MB5931:EE_
X-MS-Office365-Filtering-Correlation-Id: 496f2b5a-267b-4e91-9ded-08dd57d0bd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVcremo3VC9yQnNLMTRvcHZHZ3AralMrdkQ4U0h6cTYvdklUdFRRZU5SR21Q?=
 =?utf-8?B?dDRxc0VMVHpWS1Zhc2V0Q1FxQjA4YjNId2FGRHpuWEdIRDdKMkZtaE45b250?=
 =?utf-8?B?Tjc1Wm1vVHp3Mjk0WVhSN0NHeEhrakhSLy8rZUdQRXdqSDhtRnBVTnNHQkNW?=
 =?utf-8?B?dnp4MUdnMzNpNGQvQVZWSk56RkNjVy95L3BRczNmalVBaXgyTVcwYjNYTmp5?=
 =?utf-8?B?dEIzMUZJQmhRUHhFMkpaQmFCTlBqcUFOZXh3ck92eGpQQ1lhZStoMGJWUWkr?=
 =?utf-8?B?VHlROE9tZVV0bUFqa1VZaHF2eEorMkExdm1qZ01CQkNTT1ZXVDc0U0JFOVBG?=
 =?utf-8?B?U0pBLytMYXVsTEsyUDhGMkNlWUF6Slh0MVRkaDJVb01lYlczc01VWDFmS0g4?=
 =?utf-8?B?Mi9FaXR2NU1EbnUvVUE4YzQ2RWU2cmdzcGhpQkpSWTExSEN1U09MWDVVME5R?=
 =?utf-8?B?K2dxSUcvR1ZwM0U3WmQxaEdYMVVsdHlMTUQ5cXdSWHhONkdsejlnS0xYK1FI?=
 =?utf-8?B?cWNUZU5sc0wxMm1RN1lWWkZaOE0weS9ZOVlPWDE1MGlLUm9zaVY1ZDBnaGs2?=
 =?utf-8?B?V0tNSXZjQVF3UWppS1NKckVGZ1htMFZ6ZzJHSUgwN2lyZWpvV0xTbGZjV2xL?=
 =?utf-8?B?N0NnODJHQUMxN3YyTDJLK0pkK2VFWFljMnkwUFMyRjNWa3VROHBMTDlIVFBR?=
 =?utf-8?B?ekx4TzBKTEhaMklRaVQ1TmRBNnphVXRhYUZiUytOOWNPWHc5Qk1TVnQ4UUtp?=
 =?utf-8?B?bG1tby9ZMnU0RW5xMzdOUHVITGsrb0UwTXRvTnlXYkZzYTVZUEwrakRGZWtx?=
 =?utf-8?B?ZkZ5Mk1ZcmhFaEI5N0ZqTHpXaEk3VjYxaTR6dGJERUxpSFNtMFZXWUJWNmRN?=
 =?utf-8?B?ek8ybFRwS3hiTU50cmZlRlVYSUlpY2xhdjBRTURENTNaMkJTV3VoYStka0Jm?=
 =?utf-8?B?REo4b1ZKOEljUW03N0hVOGw0TFp2QW5aak9Lb3ZSd1pRYlFFc01WMHQxd3J3?=
 =?utf-8?B?eVZ0djBKR3lBMTZWL0haczlCYzNSTElERGxkSnhUYkFCNWl3LzdYbmFVbE02?=
 =?utf-8?B?RVFrTEJ6Y0FoNmVKb3AwdjNNaHpDRmtxM2dBRmJuTytxTGJOVzArZzB0NnN0?=
 =?utf-8?B?TGhOZTVyOGtRSGdIWnpzYVh0ZU5oTDRzaGR6UjQyRGxiMkhxcnJSTXNYSWpn?=
 =?utf-8?B?c2dDZkFSNVNzU3JYb3E1UHY4RVN4dFpEZzFneDZMTnZEU1dDaHFnR1RRa0dS?=
 =?utf-8?B?ODdOV3AyUXB0ZVp1bUZLb1NVTjRVaTVYcisrWGk2RFdURklXbDRNRk16Lzdj?=
 =?utf-8?B?TmhJRm1zV2xPdFhLRGx6MFd1VkdHN25QZFVaTXhYUDVYYzl0NE9VZGNrM1V6?=
 =?utf-8?B?STRJaWFieHRWNnBsVzBUWTNWdWNlczEwTEg4bkNyNnJETmZHUUpqZlllbG1k?=
 =?utf-8?B?dVhzT1RXYXQ3UDREK3NYcE94WTFVZ1N0T0xkaWdEL2pDbDFrdDl4VkJXci82?=
 =?utf-8?B?aDc5VGpmd0pJdklVZ2JKNk5FZzZwQlV5ZHYrVEJBUnJxRGsvREhOdHd2RGZx?=
 =?utf-8?B?ZmVUNzE3T1dTejVTSWFvY1BheUJSUHFicGcvbWZJcmF3L2tuOXY4OU9hN0Qz?=
 =?utf-8?B?UWlOKzlKS3c2cXk1SGNOUzYrWVkrMU0wVlpyZlg2OXpjTWU3Z2IvR3hqbVkr?=
 =?utf-8?B?VTRzOXU2RzdxUU9OSC9EeFhBQkRBNWpPN052N09RSmhyaHc0MVJHcHhqWm1K?=
 =?utf-8?B?TEU3VEJla0hQWSswbnFrMVRROVZET1Z4UWRDQjhQMmxmVnZ5NktEUEdRWnFW?=
 =?utf-8?B?TnBONUl4YkZYS1NQWWFrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTRKalh0clRSQWRQeHBYcElERHNpV2c3QjZRUlhnUXJmaWJpNXZEc1RjSXhh?=
 =?utf-8?B?MldGcnlnM3hrK2dZMHFjaDZ6dTltcW9CYVVlQ0VHVWFxZDNpM3F2WEgyQVhq?=
 =?utf-8?B?TlBxbnBRaHdodFRTZDczVHB3SjZZTjRLTWJtNGgvNVRSVEFoTkNIanBCcUd3?=
 =?utf-8?B?dmoycHBOc1JGSHNUQXRwemIwUjdhVDlQenRBUHMrVkFDK0VPbmgyd0VWUXo3?=
 =?utf-8?B?aE51M2RRV1hnSFVONnFockZ5UDY5a2ZxeDExTXEram41eStsa2RlMkMyM2t6?=
 =?utf-8?B?Q3h4cnlDWS9kMFBHa2dTYzZFVTJMRnlQY2JQajJDWENJUzlZRzZTYWFwSU1v?=
 =?utf-8?B?NE1XMFNhOW8ralRvcGdlbjNBN2ptQmtYZEdLYXZpS1FPQWtoTjBmWllUcHVK?=
 =?utf-8?B?ZllBTTV5Qy9LY3o5VS9TcXEyVTI0bVpseEFQVGpFKzk2b0E0T0ZseGlmRFEw?=
 =?utf-8?B?cmdXZnl4VGVldWRFME1HOU1LVWRzRDNUWk9HQWVDRkFNaHVlZlJPOTlRVUlZ?=
 =?utf-8?B?UElod1Z1NzdaNitPdm1ELzcyL3F2UmJ3RlhkV1lOZ00wWGFBVkhWcDNRU0Ri?=
 =?utf-8?B?SDVmNHZ4MHFYR2x4Ti81KzNpRUNjUmJFWGRPeXFhWTFNTnU2SVJMWk5PT2pu?=
 =?utf-8?B?Qkl0SVhPZXU0cko5ODlrTWFqOG9UK0NhM1BqSlhoSyswT0k0YU9OTFZxT0RL?=
 =?utf-8?B?NVJDSWFhWjc0RDR0R0RxdkJGU0dmMHlFd25pTy9XTG4veUJ3YldJWm9zdzhs?=
 =?utf-8?B?MzA3dmtUVHJGLzNHK1JIS0RUQitRWlBIR0pXTlNGNFV1WWR2azVLYnFlL0NE?=
 =?utf-8?B?djY3YmQ3bXJEbS9yQWw1MHJicWhOUFRLS2VKdVByS0Y0RkNtb3N2RjBnTmRC?=
 =?utf-8?B?bzcxaW9vVFpacGQ3aUUyeW1QTTY1Q3BOVFg1M25leUhkVDE3R0E5ZFljT0pH?=
 =?utf-8?B?emxFQk9vWVJxN0hlZHJKMmpLaDFsblBBZ051eGpGRHVYRXY0ZlFCSDZHUEw3?=
 =?utf-8?B?R0dUNFdUZjZrRGFqbC9jZ0tjTmlKNjlZRFlmd2dUUjYvM3BkMXplUU90RGdI?=
 =?utf-8?B?Mmk0ZkhUMFpLVTU5UjFrYjdvU2dUYUh3TDNxbVlNRG9aU3ZWMDVJVUY0ZDJl?=
 =?utf-8?B?amhHUDU3ek0zNnpmK2hYU2M5NDQzTll4VGtReEkzSGpNdXZpYXVvWkxjemFI?=
 =?utf-8?B?K3hici9LUVpYeTRUODcweTN4TlQ0Y0MydXJhb0VtcjNscXhSbkVRZ05LajZ4?=
 =?utf-8?B?a1ZLOUZEQTNrZXFIR0JNZzJmanJURE1FNE9Qd252QnUrSC9hT3dzcTBGb3NW?=
 =?utf-8?B?U1hLK29wSFBjdVFtRWExTWYrRFhXM1VPRWhNaENxeThvUTk1QzdEaU5lQ3ZB?=
 =?utf-8?B?b1ZTdGRJQVo0SmdTV1d6MjY4MlhtNTc3NjlJUHZSU3FuRERSeVFCWEs4ejQy?=
 =?utf-8?B?b25DWVBKZk9NN1hhMUNmdW5oZ3ozSnUreVN5R3A1V1RVY0YzbENweGxUaStB?=
 =?utf-8?B?QTAwTzlWR3NjcVRzdnNETEdZNXhXaDZyeGdicjZ0MW5tSExoallSV2dqK2Jq?=
 =?utf-8?B?SWQ5d0hoVXpoQmY4UFJvdnprZmZQcHA0RlZYdUg0VDQ1V1J1eWllTDZQTUdv?=
 =?utf-8?B?YzRDajM3cTg0enM4bXorOXB6ajNtUzE5V0NMa0JjSjZ5QjNEZk1vekU4Q1ll?=
 =?utf-8?B?M3pjd1NpbnZBaG56SXZPR1JmWDJXUW43NzdwSHZ5ZFNoZitkUXpWUnk2OER5?=
 =?utf-8?B?TDlDUVpwYVVZVS9oQ0JvMW1tVy9ldlhkZTd2cHp1UnZyWExEWWsvWWFORHFV?=
 =?utf-8?B?T0Jkd1k2R1VxVWUvR0Jtd29ib2p0R2hQSnh6RzM4TGU1bE9MVkx1S3ZiWlF3?=
 =?utf-8?B?bFZNbUIvc0d1SWZLYWw3cTFFS2RtaWQyL3lybHhETW5oeDNBUXA3dVJaZkFq?=
 =?utf-8?B?RlRnRnh3UmVaZDJkeVRyYVVWMjZYeDl6R1RITGF1NDBHZDJlUENYN25DNjkx?=
 =?utf-8?B?UGRsTzZzTURpZit0OFgvb1hVYWYzbDJjZWZuL3c4bXFXdVhjbVJnRlFURG1D?=
 =?utf-8?B?T3ptb2dmeVVEUjlBT29TYm1QSzFjWnErYndjUlZjbDdXd1ZtQ2FSMXI0eEVt?=
 =?utf-8?B?VTFoTWwyeEs5aFRRa0ZWbzhMVFNtVzNMNWJieDZuNTRhWUc5bUpzR3lkL0pW?=
 =?utf-8?B?RXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ahUssE1u5kO1r+qj0kBcUUC9W5iBRCr14DAn2aarGthWsNPLU7KcoveH2pTPQmNykPr077vT9QiRgMFIgtXgBtbRM8y6tv+DmXcN/gXtPNGgPbJDBZCqDUurb58IJ6HoAeVs8MONfuYKn6F7AnGdmQs3ewn5DOK86a8K0aj0xH23eq2337yMnEG3YIIufcxlixtlN3JaYpN4c2YYHwNC9Y0u+LF2a4b47nJE2wQa1XnHo5QY8rvXuoiJQ7z9uvT4nIwbT9Hy9QwOvgUFzz3RBMJ/7PJCKG8N+KeeA/gBSGdDD6iOR5wDU4jjZBLsnz7XzVdMQ/sc5jyGkEwF9DKcQlOE13/4Oy9Ua8NPl+QselL1/2d8SVYebsNTWt8tMlchpiPD/H2OJDq9wW4JsUienRy3Qfe6pscifmAOy+qVGY/xz23Z480esuHZ0AioYFrDyJEHa5c3GTCVG/RYAb53r1J/RII2EpeGhn8NwkhJ1CvYDS1YV2BuO33YBlXJ7S/7/O0BCLsvx+zRH+j9Jg/QKtJ2IbXCmCCJuukNztsd/2inxp3MwHLyaILxTAmJq4ZA3eaK3580+LNzM+hZrvZAvZ4SPSZGhKcuzXuQ5k39oS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496f2b5a-267b-4e91-9ded-08dd57d0bd5d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:20:20.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uza+jDohx5Owvg3116xnq0jhRsU8cYB2zdb20U+Ezv1B3N3L8l9EFubSAN7rlAWpqVAYrRtXiim4Rv3ICB8l3s403RuZ2MdYD0xPo6D5th4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_02,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502280059
X-Proofpoint-ORIG-GUID: NLBj-h2iwpV3PY8q4PP6BFhz11A51GrI
X-Proofpoint-GUID: NLBj-h2iwpV3PY8q4PP6BFhz11A51GrI


On 15/02/25 8:25 PM, Greg KH wrote:
> On Sat, Feb 15, 2025 at 02:39:46PM +0100, Jürgen Groß wrote:
>> On 15.02.25 13:34, Greg KH wrote:
>>> On Sat, Feb 15, 2025 at 12:47:57PM +0100, Jürgen Groß wrote:
>>>> On 12.02.25 16:12, Harshit Mogalapalli wrote:
>>>>> Hi Salvatore,
>>>>>
>>>>> On 12/02/25 00:56, Salvatore Bonaccorso wrote:
>>>>>> Hi Harshit,
>>>>>>
>>>>>> On Sun, Feb 09, 2025 at 01:45:38AM +0530, Harshit Mogalapalli wrote:
>>>>>>> Hi Salvatore,
>>>>>>>
>>>>>>> On 08/02/25 21:26, Salvatore Bonaccorso wrote:
>>>>>>>> Hi Juergen, hi all,
>>>>>>>>
>>>>>>>> Radoslav Bodó reported in Debian an issue after updating our kernel
>>>>>>>> from 6.1.112 to 6.1.115. His report in full is at:
>>>>>>>>
>>>>>>>> https://bugs.debian.org/1088159
>>>>>>>>
>>>>>>> Note:
>>>>>>> We have seen this on 5.4.y kernel: More details here:
>>>>>>> https://lore.kernel.org/all/9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com/
>>>>>> Thanks for the pointer, so looking at that thread I suspect the three
>>>>>> referenced bugs in Debian are in the end all releated. We have one as
>>>>>> well relating to the megasas_sas driver, this one for the mpt3sas
>>>>>> driver and one for the i40e driver).
>>>>>>
>>>>>> AFAICS, there is not yet a patch which has landed upstream which I can
>>>>>> redirect to a affected user to test?
>>>>>>
>>>>> Konrad pointed me at this thread: https://lore.kernel.org/
>>>>> all/20250211120432.29493-1-jgross@suse.com/
>>>>>
>>>>> This has some fixes, but not landed upstream yet.
>>>> Patches are upstream now. In case you still experience any problems, please
>>>> speak up.
>>> What specific commits should be backported here?
>> Those are:
>>
>> e93ec87286bd1fd30b7389e7a387cfb259f297e3
>> 85fcb57c983f423180ba6ec5d0034242da05cc54
> Ugh, neither of them were marked for stable inclusion, why not?  Anyway,
> I'll go queue them up after this round of kernels is released hopefully
> tomorrow, but next time, please follow the stable kernel rules if you
> know you want a patch included in a tree.


Hi,

I see these patches in 6.12 now and upon manually checking these patches
cleanly apply till 6.6 kernel so I guess they will be eventually back
ported till there? 6.1 and older kernels have conflicts while cherry
picking these commits which makes it harder to verify them as the test
machine I have runs on a much older kernel(5.4) unfortunately. If it
could be at least be brought back till 5.15, testing this would become
much easier.

Thanks,
Harshvardhan


>
> thanks,
>
> greg k-h

