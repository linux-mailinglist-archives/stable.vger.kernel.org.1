Return-Path: <stable+bounces-148158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF90AC8D26
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 13:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3613A6256
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C5227E8E;
	Fri, 30 May 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mC4fIAsS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lzhzo5PC"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E283FC2;
	Fri, 30 May 2025 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605766; cv=fail; b=maSFNv0/W4kJWCbCnTfzghtbdXVb+d/4m5fqpwTCPM5OZo2axLR/GLtaKYtrEAptWZUNZKX+ksAGOCNB+ldd7HU45fLGPo6D0YXVmLkQhlZ8XcmFmWJGrZlrSInZsI5E7gKRdc0dKv/0ddANKJZQAY6PLzl+wcfqzxliTPORols=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605766; c=relaxed/simple;
	bh=hAuMrB/lUZ4icyz8nplpSmtEFHwHbIWuUexGKmzf/uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JI/kc2R3H0QmROVjeAUXGTTPFsDFFtwtB4ht7a7tAAuri95cLAMrWfV3RSu+Ld+sUsG4oB7lk2rnSxifV9VlpugFOdxez+gGXGC4IQI33q7jcxTlgMKTblKkEWmPCHx16EealPwXB6L++sWBKKFHw63LO5VJJmgbOqlry7DbanA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mC4fIAsS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lzhzo5PC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAt0xL015496;
	Fri, 30 May 2025 11:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Uqv314sfJZvbwjumCv
	Gx/38XQ8iDZnOV2eAX24EFWQ4=; b=mC4fIAsSn4Teydi1ip49Evlqd286E8j1Uu
	DeRhWFd9tdG3C+joCz3+Lc08Sjz/e/+P8hjWzyPeLAJ/uI+W20CPt1BggPN3TFfr
	0rWQS5tK1AFfbBq1EU8tA6pb5h47mgRwFfhd09woQlzNrjBeorY3NQRKxB92Sar4
	8L/AnBTmlLHG4hvup0BvIxgzbFMl1R7X5Mr9/QrWUdhfKXfrPL7qFlN+d/fZcJEv
	rWBLkpALA1KP6Yx+d4Xaq2Amzpwl+xTRakaWg2lN70m8sOqrqkjhq42C9bx81hFR
	X4AvkBAjv9UcgLSb5DT1Q4S1YrVx+XXB6mmo8gLowDFIFyAaFG8w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u24dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 11:48:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAhZ0V019358;
	Fri, 30 May 2025 11:48:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jd6f4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 May 2025 11:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkmsqTB0bOT7x8nziW7sf85sHQaZ0TlIwa/v4Rnqukf0/N+HS1lUPxSoNYtNlBQRuFKdB401amaMJx4XAOPg57wiDcsIoJ4vDAUXuupO08jlz0OOuqnsXwhAGlHudIzFONLHG4SCXZGvIVXQEqIAyMMJkeD5yD0QrOAHJXF14GSu0TDwC/iPKjDCUB1rlMkKhVtBKLQ1avxR5Emz4Luw6dC5+ej6M4cU0MwdhVevxa/3f3d1oCdJgfQ3ZRRXTu7z9mcEh9Aa6LQhA2/lZ7DmkoTlzZGa1A3v8PWL7h+V9dQH/30xPwH2Ute6/fba1N2mulFg5NHaXMqdfmAb9NwpDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uqv314sfJZvbwjumCvGx/38XQ8iDZnOV2eAX24EFWQ4=;
 b=pCB6bVl/wuLngVJ0nHSXJ+t19Il5KcW5j3UzgM9XTq++3KTxEwyTeGmNewcqNIz8k3K9TJ1ndhWCgt6IJ1tqH2Ep0qHUX1eI03U36YRwv7lBcsUDY0gYDzQHnFtRxo8IBfaxOmJWIhxymHKtgYl3giMjWOjVO26UOISpm+Cm2KxinmOezo4VHqIUDTUJeI+I3WO1COy1kbLRdnqIsPWQNQr1KWgrhA+kjPbZ2SlAA9oOeh2jfDvJ3IXQ4FVm5EQCP3S0R9M19JkpIXqTMEFcTsYMzyQXlXmGnnUK4ys2uS9/SnpVFQkbmrwYBb/PrybweaAObWBnBcxonTfd2UWYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uqv314sfJZvbwjumCvGx/38XQ8iDZnOV2eAX24EFWQ4=;
 b=Lzhzo5PCHKvMu/RpNeuxSVVikPx/IVtQzTtrBtzTHobrv+bqLbBb+Jr2QtLOg9O7dL5RBurw4lkVqPyoZxUZEETjtrcKaLA44Qh8vZOoFwRlhCWIB167467ns1y55qIr3JNBAqfBORAxB54dXbcsFQ1GNE1EhcrwZWkjIvBiRgQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8224.namprd10.prod.outlook.com (2603:10b6:8:1ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Fri, 30 May
 2025 11:48:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Fri, 30 May 2025
 11:48:47 +0000
Date: Fri, 30 May 2025 12:48:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        pulehui@huawei.com
Subject: Re: [PATCH v1 3/4] selftests/mm: Extract read_sysfs and write_sysfs
 into vm_util
Message-ID: <f1dfdffa-23b3-4d4a-8912-3a35e65963e4@lucifer.local>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-4-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529155650.4017699-4-pulehui@huaweicloud.com>
X-ClientProxiedBy: HE1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:7:15::39) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c9a0e9-a550-406a-c346-08dd9f6fefe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wSAf49mzefs0dv2rE6i+v4QnAt9XfqjTB7rZTBc5X/B9GUdkTs5BSwATFRH4?=
 =?us-ascii?Q?g124XWQGsRT04boH3hw0OvpyEG1AhQt5NQYvIZKDmM4N9cjZDFLXLMsawNOl?=
 =?us-ascii?Q?Ued+TjhlA0Nbc0QAVsFxB4bl4kgWi4I542jogOfcX8BdBdH9S6r3Izil5RQa?=
 =?us-ascii?Q?lOPWSt6Q7zvz3imzNNbAGMCZrZBbAoT/dhSvnjXCworLQ6MUR0O5e62CyxV2?=
 =?us-ascii?Q?a5hyR/3touPYMSfQtojtt8MIcB04EjkCNgU6oEJUVjBsUn8GPIXRDhpqR/2g?=
 =?us-ascii?Q?Lu1z6VtjmKF2HM3drAQ9b8331kNg2NFqHVwscN8Kh5awDM7Nj97+L9JJtdXR?=
 =?us-ascii?Q?iIWii949Y8X9mbB/x76ClAz9AgSiYUIElLwlCGJv85jUA5DnqJTKk7+VMzaZ?=
 =?us-ascii?Q?WOXeXJ8XVsH4Qy9R92TJZBPYcoXKbaqDPRLvmY9us65jbzRXOFuNQ6mEo5OX?=
 =?us-ascii?Q?xbTNoMrljYc5Izy0a6JsTTiyc6tTopIJV5zwwWxL7RrcNYs+D5kUrJcoIQW2?=
 =?us-ascii?Q?ls+DN+4uHwZSdZ6orXCleHCIv56POe7Gsy1myb6xDb8bSzuOgoofRi1eMYB4?=
 =?us-ascii?Q?IOVDeeNhMzylh5WOYXwNIFZQXT67WiFxz33VwBYb9ZcHekpQdAOHgSHhOXkh?=
 =?us-ascii?Q?aWhsArA4H70WokarakHJsGp7xKxtiKX0VgyTnDJmyOqI+kRSbakBEZd8W2yZ?=
 =?us-ascii?Q?v6CBBvddLeKz1jE4wITEjJktm9nItYk5u9m/dOg167bDdCLOhS/WmjlSU/Z3?=
 =?us-ascii?Q?lhA6EvfZfDhVK/VQU9kLZPQixp7lHnbGfZTVHJEJufhMLF+9QQMhIKMjtzjZ?=
 =?us-ascii?Q?Bhytf4A8PFQeRK5kOx7CxVy+ho0QKC1bO8fwZ21YY0aSazBOoaIR19qhTWMp?=
 =?us-ascii?Q?Bhqr7jED2NFvEQR+ikBM945k83HZ8PokKd8lJob85zZrBV6qUd7W4DpKXJwx?=
 =?us-ascii?Q?M7k8rk4LNuxAQUIK4iuX0ForZF9sOH/+6j7P0iOGLvO6gIy1dydIyqply3kg?=
 =?us-ascii?Q?6nad1EvXnu74cq4pc5tCiV6kTVC6GoueK71uBidh+3CKqWHaj3HPbxwtmpas?=
 =?us-ascii?Q?JJBl3GanrJPTh+yZavRnbuAYxQPH0xwXXTE6/TUNt7k0/HKo/Q9qLyRlR9go?=
 =?us-ascii?Q?2Q2oY4E2hEMZIWGtAJiyo1ttc/PY/A93a9RyCeTI3icBmQj0DO3y7Qu2NAVu?=
 =?us-ascii?Q?O0aCPUEcC3w/zAoW54AQKsXoJxaFotrXj916Y4d5FFUWpN1qpWCoKg7vGuS6?=
 =?us-ascii?Q?xp3STzr9CUyNUoJ+cHDTRUwhpYDuPIszlPHPCoL/aHtcStb1FKXWRWstcG5r?=
 =?us-ascii?Q?XOtIfo5QJYJgDs2gcmcahvynl6ve842Au7EaMWncTLQY7YIdQ7USU7bfTi4d?=
 =?us-ascii?Q?OIwUcnrN4IiQWhgIdyqXHUIeHXVwljzz5IPgJM0iVneNiAdfn8seQ5SebJtn?=
 =?us-ascii?Q?T7CSwqWpkPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxTDRNSQrMF1TT3shwl3DjKahxecjVP3Kt4FWXMUgdlGYFHLGnUwJkwkqjLK?=
 =?us-ascii?Q?w4IEeiem41Vawl2Yeka5Xgcc3TytIyf/OK94l88b0pIpBKfMtYd7xaP+TFFh?=
 =?us-ascii?Q?U1jj5ljReShl8Ic/+YmqFjZmZZx8dIPKwlvK6ms1z5L5pzFqxhaWlrDm333B?=
 =?us-ascii?Q?lur66AG8D22jKc4rDpAlUM6Il1I+Ka6CVYK8haUC7kwzDo7exDufBwinHfOy?=
 =?us-ascii?Q?/noIU2k5xxGBIA24fosvA6arhg/+sXxhTJ+ssfxnWK1xfqtY2wshHPQh77MY?=
 =?us-ascii?Q?AjgesbtbT8y6bo6D4Tp9Z6AJC1zp76otOWRmZQbTS+t2E0/81TbkDfYB9qEC?=
 =?us-ascii?Q?w26BemQIknnT1t79TKAVNCEioEb5YdUtHzrZa6FZq8RPNj1cSpoz7JqFDz52?=
 =?us-ascii?Q?WN5eC4TMGnXuZHvHmRG8NDAjbzofQbh1Mf4QbIdioLhz8JKtfrwniZ/4MZw8?=
 =?us-ascii?Q?WI5rEB5sFAy11dFDjo4RKbXFdG4U+OCJb0vDlF6NtO/YuFY7CrJ5Z4tC81YU?=
 =?us-ascii?Q?/YIFSnknoegvlbGwlsjiLPKzCkzb3kk/y5pqAb0ha/3Lm0WNfqCzB9AD9qzV?=
 =?us-ascii?Q?N+1Ff1Ns+gACiTBxjbv88mYSCb617YTQbhl0ABbUxJ82d+lbF5fIMjgHaTCC?=
 =?us-ascii?Q?9TQp/B9Dn2piVkMoZH4ifhD/pQvIx6agVpTn5aHBacDmjACuJf/xT5BxhzUv?=
 =?us-ascii?Q?9UQJ//LAq9a6YdkoicSDlyosTGIQzMMCI0OLzyO4At6m2WOnRIJGcrmPFMkq?=
 =?us-ascii?Q?jjzelj2mpoHK4ea2+Ly71Euek3DMH9yx/MbIcXVHSHUp3zvCa4vCtxN9ckAp?=
 =?us-ascii?Q?z5k84I5+1FyWVr62l58UMYxIe5B2zHmv4AJDoNtfSS/oElxn9nQB0r1sv/Hr?=
 =?us-ascii?Q?t+G/vvS/bVd4/ZVRBpB+ntiRK+kTcE2Qfu1KFPPBtXR+5d0qlhTtWdskThEC?=
 =?us-ascii?Q?BbRvEBdU6n30WsUxhoyux+7u0/lt96KzLW8YbcBqBROXrMMAbLqvyY0QJ9Aa?=
 =?us-ascii?Q?sTV4XJ/uxvj80lTjnYbZlHeeFT21GgHj/LAsICubq8kP6n3El0tdXa2otFa+?=
 =?us-ascii?Q?9f2NDhwqkjS2OMkxElBiRmp0ie2JLVeLCbx2vljD34oVx/H5Tr6M7r/TyFEJ?=
 =?us-ascii?Q?SiZS/V0lZyeFG+MwsSFpKqu3TEdo/5FYHb3Yfo4dkiZCA8k3vTfTk9+sfl/o?=
 =?us-ascii?Q?ujgmQQitFA7tfueONzh0NrcuIf2vM5x4x0fFTsOmAf6xl856lLsc5OI4mFJG?=
 =?us-ascii?Q?TNkz4LQqO44wCGaCvx6PuDTV8ONaCIDkGX+rKOPjILkqrlvDgHjMh3sUO98r?=
 =?us-ascii?Q?+aeKvSOGda68NxHIWhqxRGZ8++gqY3hJ1taXFWmtJiqzbq03JeMft1GsdBzA?=
 =?us-ascii?Q?tMpD+yi4aQwhmDck4yu08t0K3s4xAJxo1LPlj9x9BG/NIAIUBj0ADhZuKIMw?=
 =?us-ascii?Q?Eijm2CdxDDnQIabUBKEDWg+i1NMvPumGsW/Kk3RV81qJkXGZ3fo5gBDHFEet?=
 =?us-ascii?Q?ZXuQAY+elwfrPyGlmeIu7M59G5N5D7teDUEcp5KGjX4NyXSf7cxQFdXk/Wrh?=
 =?us-ascii?Q?ZM7TcICgYq+gMbKCZAyGCGs9FXdD13gDTqNkGASoVPMPJoqNDyWm34zLt+GL?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	riBQdVqIEjS1V6RW0L8zaqA8nIi/I9E4W3fEllpemz4Ji07FTuyesPEd74vJflc4Ym5Caj2C52ZYGJMRZOs9apFGisaEwLc7TQYNENfKS4o8AQYWByxHCzHyEeWlizSjgh/ijNWH+SR88TCHbA+qgYjo7xTT4BNiRJT9wqL33m4OvR/bWbQ3pfT+PCaKpAUJHcBRkgv+3zsiCtfTu1cMT4yhL4z4Q9lgBCj2myEgl3gQDD1ypI7ZM1IO6PhXz/iYgsb0BFmMG5Ay9BTt1ic2Q06hJ1fjdPiGKGx4W2dlNAbaT59NKyWBhvZCgCyN/pDH2iNmEVJ1Sv5m7aERuBtYbvF78sDCMDorp0EEZyGV/5RFg8fLvqRZej+IaywSAHgcZEp8BiS+eAgC/LkXmgMOIFYPb6rULO9+2Snxv8CDZbsFSTblSUt3KSei2yVI/y1gU3aJ85aKjkk9+C4rqe0SkI88NfQEvCs9YaVOWFPRA6oEui5Eje0dCiBzrTVMvdHYzhGmNnwxM8kqtH7EzYKnrfn+tN9qasV1nGx5McgqDhTX7S/S/Z3+MnPqBfXRBPnR28o5Gww+usF1GH3B+xjymhbIbhGHmCWNFXXd6cDE7n4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c9a0e9-a550-406a-c346-08dd9f6fefe9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 11:48:47.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+lEC/5p6o32s8WerizFiqSkmhdLo57mU/Xoo6xKaSb+jJp0na2pRzl16Ffvdnf2GQ6l4eVwZcOTvEURuNIzhUAeymp32MA+5XwQhBqRBGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_05,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300102
X-Proofpoint-GUID: WBHTAY7_uQScQYcceIpFYiR5xg72LqYj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDEwMiBTYWx0ZWRfX1Ujh3N9xhG6O DKhCDq2ZMWmA4Ql9U+AliHHPcWNQLIx+6UiL17dL7kFCa7XT3QZv4NdVPj506JwFy1JmQnjhDRo 2fAGN7bdhRlpFoWBmhdVdXAXxRmoqHVl8xgMOtc5jHW1cAsUYfok5wRm47zbOZ+z12sdkuJKJM8
 68XOtZTUKEYiWfRHmyCEWmGOPI9AEcBNyqrCVPrOH9azw2b+itPgL0WjnTOR4UcpaTHX2irzKin 9W3r06E9HMR8II5Kr59ilbWa/IRNqIs3uc0K2AqmRbPlpN8+vpf1d1J42LZbytS2OIK59UTCPx1 7lOWCnYqT/gpIyGmgYiThppqORnQpMpVJUqnL0K/EYqWOfRmuQ5Ix4iex3m32e83FhW6sutZwyq
 ilr0Mt6M0qksDJGlCn9g+YsQ2D1WnuueaK0y5eb2riNERmkitoehzlfxE8yK6Pg0H/Nb321W
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68399b23 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8 a=JMi2l19wJG4tvER0l5gA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: WBHTAY7_uQScQYcceIpFYiR5xg72LqYj

On Thu, May 29, 2025 at 03:56:49PM +0000, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> Extract read_sysfs and write_sysfs into vm_util. Meanwhile, rename
> the function in thuge-gen that has the same name as read_sysfs.

Nice!

>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/ksm_tests.c | 32 ++--------------------
>  tools/testing/selftests/mm/thuge-gen.c |  6 ++--
>  tools/testing/selftests/mm/vm_util.c   | 38 ++++++++++++++++++++++++++
>  tools/testing/selftests/mm/vm_util.h   |  2 ++
>  4 files changed, 45 insertions(+), 33 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
> index dcdd5bb20f3d..e80deac1436b 100644
> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -58,40 +58,12 @@ int debug;
>
>  static int ksm_write_sysfs(const char *file_path, unsigned long val)
>  {
> -	FILE *f = fopen(file_path, "w");
> -
> -	if (!f) {
> -		fprintf(stderr, "f %s\n", file_path);
> -		perror("fopen");
> -		return 1;
> -	}
> -	if (fprintf(f, "%lu", val) < 0) {
> -		perror("fprintf");
> -		fclose(f);
> -		return 1;
> -	}
> -	fclose(f);
> -
> -	return 0;
> +	return write_sysfs(file_path, val);
>  }
>
>  static int ksm_read_sysfs(const char *file_path, unsigned long *val)
>  {
> -	FILE *f = fopen(file_path, "r");
> -
> -	if (!f) {
> -		fprintf(stderr, "f %s\n", file_path);
> -		perror("fopen");
> -		return 1;
> -	}
> -	if (fscanf(f, "%lu", val) != 1) {
> -		perror("fscanf");
> -		fclose(f);
> -		return 1;
> -	}
> -	fclose(f);
> -
> -	return 0;
> +	return read_sysfs(file_path, val);
>  }
>
>  static void ksm_print_sysfs(void)
> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
> index a41bc1234b37..95b6f043a3cb 100644
> --- a/tools/testing/selftests/mm/thuge-gen.c
> +++ b/tools/testing/selftests/mm/thuge-gen.c
> @@ -77,7 +77,7 @@ void show(unsigned long ps)
>  	system(buf);
>  }
>
> -unsigned long read_sysfs(int warn, char *fmt, ...)
> +unsigned long thuge_read_sysfs(int warn, char *fmt, ...)
>  {

I wonder if we could update these to use the newly shared functions?

Not a big deal though, perhaps a bit out of scope here, more of a nice-to-have.

>  	char *line = NULL;
>  	size_t linelen = 0;
> @@ -106,7 +106,7 @@ unsigned long read_sysfs(int warn, char *fmt, ...)
>
>  unsigned long read_free(unsigned long ps)
>  {
> -	return read_sysfs(ps != getpagesize(),
> +	return thuge_read_sysfs(ps != getpagesize(),
>  			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
>  			  ps >> 10);
>  }
> @@ -195,7 +195,7 @@ void find_pagesizes(void)
>  	}
>  	globfree(&g);
>
> -	if (read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
> +	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
>  		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
>  				   largest * NUM_PAGES);
>
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 1357e2d6a7b6..d899c272e0ee 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -486,3 +486,41 @@ int close_procmap(struct procmap_fd *procmap)
>  {
>  	return close(procmap->fd);
>  }
> +
> +int write_sysfs(const char *file_path, unsigned long val)
> +{
> +	FILE *f = fopen(file_path, "w");
> +
> +	if (!f) {
> +		fprintf(stderr, "f %s\n", file_path);
> +		perror("fopen");
> +		return 1;
> +	}
> +	if (fprintf(f, "%lu", val) < 0) {
> +		perror("fprintf");
> +		fclose(f);
> +		return 1;
> +	}
> +	fclose(f);
> +
> +	return 0;
> +}
> +
> +int read_sysfs(const char *file_path, unsigned long *val)
> +{
> +	FILE *f = fopen(file_path, "r");
> +
> +	if (!f) {
> +		fprintf(stderr, "f %s\n", file_path);
> +		perror("fopen");
> +		return 1;
> +	}
> +	if (fscanf(f, "%lu", val) != 1) {
> +		perror("fscanf");
> +		fclose(f);
> +		return 1;
> +	}
> +	fclose(f);
> +
> +	return 0;
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 9211ba640d9c..f84c7c4680ea 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -87,6 +87,8 @@ int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
>  int query_procmap(struct procmap_fd *procmap);
>  bool find_vma_procmap(struct procmap_fd *procmap, void *address);
>  int close_procmap(struct procmap_fd *procmap);
> +int write_sysfs(const char *file_path, unsigned long val);
> +int read_sysfs(const char *file_path, unsigned long *val);
>
>  static inline int open_self_procmap(struct procmap_fd *procmap_out)
>  {
> --
> 2.34.1
>

