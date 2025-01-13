Return-Path: <stable+bounces-108438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53766A0B835
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49620188455F
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCBB1CAA6C;
	Mon, 13 Jan 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="mYPZP5Z9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFF822CF36
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 13:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736775227; cv=fail; b=JYUAZ6dzuutGwoqCoTmWIrsaDJ4AX9hZYigQqTNt7qVzVOga8htZ177qwekZbUct/omzbu1vjw3bwLQd2wlUIgJ5u+NIhZ2n78WyDzxGLR4hFGp6kFUHAq3/kt3d4nYzZTRzPgHP+u0quu62scJ1gq1BeyUFcCyorTT9qiPyjzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736775227; c=relaxed/simple;
	bh=t/lhBLTuHDEkImxNkg2tdxYW5ZywM8ls01Q/UrsjE44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rhCoYW1ki5lImEVl6Ti9EG9YjEE5fgo8/XZXwvUlm4zALmK8Ka3GnPCBn6h9MMZNEt4NWhkmEySRhdm1UlNpEoPtJJ57kDbOd7U4+KNaQsj8MVxH3lWlx45bwS31987ZYJXLLjjtWwqfL2p0DvR1HkR8VK2nPfHnu5G7vU9Pnus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=mYPZP5Z9; arc=fail smtp.client-ip=205.220.178.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D0562U003366;
	Mon, 13 Jan 2025 13:33:33 GMT
Received: from ty3p286cu002.outbound.protection.outlook.com (mail-japaneastazlp17010004.outbound.protection.outlook.com [40.93.73.4])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 443j0h9927-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 13:33:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEe22jksTE0rGT54qFvUull1DWdRJAJTGt+/UE2foCfCiR4tInGTi1uZ1wsXGgujd/ukdt1v/eV/Cldj4OlAQUFUsvxZD09uL/zad0CxXi6EHQe3rjVwcxCsmGoM0m25m0hIaMpDd/g/ipuhFaN3E7/GY7eKIlgVp4VnzdVkUqxkSzftPdF39ZziL5hRpm0DaKZy0ZJrcSbpWVI7OQPADAZoupO7Fmp4ke4wPpC3DMeYYPNU4y3G5nXzevsCmEKVs+9lPe7GVOq49Qv/4qPuZYakKFvZIeX2k5ySS7YheAqyxdDS5Nba1S/y8ceyE2sSo6p6VW2n/vxcAxF7GqKvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O4TVszIhS3IlsqQ+R/nSYLOMvr76zV8p94iwHRn4ss=;
 b=WpfMiOva4km9/a0/UZQTun3wySqau9elIeg8a5D7i3N2+HOVHCu8DrR3aEed7IyIuaxrD9tAj4K9Y5lBFfrbCUFAwipMKc7shLQ0i7jXShspyrL37gN3dueICC3fdXVZV6PyY4dDNe4YCk8icaYEHXlNTJGTcdzYWbRMhn5qy97IvKu7ECSL99xBoPj4hp62DFnl9ejZt1/+2cBZmKcYFD+5k5ZUXBqE5GnlzlwwlA9/PalC/tHx0nikdO0YWEQbrR77CUJUAgOSvW+Bhe8x6hXh6wC234GyTLTlHPhU3+PVlRnepLI7nQXenmc/w5RitfW2He4VOj9/C3RUmenKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O4TVszIhS3IlsqQ+R/nSYLOMvr76zV8p94iwHRn4ss=;
 b=mYPZP5Z92t0EFK0y0wG4NJi/Vs5ni6tqkcEY90uKuxmohM+RjiIJ19dSNxEUAj72Fb/Lyn0Gp9XRJqZa/AuS6kSgelkEO9lzKCM1WJXZhHfejH9KxzZNwU+axyovFqFQI7G62a1Nj8cVIprWONncgzuq1rFZeF3D66AYK18NgSTZda7N43UP5PX2RmT+nisWwL5ZE+pl3FP0Ai3dPh+GQn1cAzUvjjVnUU6vS3eOgzw6EtqeUEiWaAoK2YCFh4ubvY0MbNpEMUoQGEci5akeMiJKfRRQU5pJcObxkOxni56aV8fIvFkHVI0uAXDm1OfYGwRFTxL2Nv1DfU0lLXuZOA==
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a7::13)
 by TYYP286MB1594.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:33:29 +0000
Received: from OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b]) by OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ff9:b41:1fa8:f60b%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:33:29 +0000
From: inv.git-commit@tdk.com
To: stable@vger.kernel.org
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.10.y] iio: imu: inv_icm42600: fix spi burst write not supported
Date: Mon, 13 Jan 2025 13:33:16 +0000
Message-Id: <20250113133316.236077-1-inv.git-commit@tdk.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025011348-broadband-cough-1f57@gregkh>
References: <2025011348-broadband-cough-1f57@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0155.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::16) To OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a7::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1942:EE_|TYYP286MB1594:EE_
X-MS-Office365-Filtering-Correlation-Id: 9253c3e3-7d46-4f5f-e4b8-08dd33d6dd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H7kqLmqtQuRt3JCQ7MPA0WBzLaQCnVI44+28WFeik11/yjo+jJwPDPcB8Dag?=
 =?us-ascii?Q?qq4J4GwvQKwRgnI3QA96m9MIdMapmzkb8G74+BObP6EnXJiJjkgzM1vxyL0H?=
 =?us-ascii?Q?pmkCP+OjuuqqXHK6EMyzzF/90fpuX3z+yRKvuj90JAPpNH44CFh1cgY5CKwz?=
 =?us-ascii?Q?BgCr8dDji4rCd+N2SRNZA5263YcJDBRv9deUgFTe6d4Vex+w8NxfAye2wum3?=
 =?us-ascii?Q?qArvE4joVmkY93EApo5DX37ZzbjZjEs0b9iABEULv0YZdG7vj+iOHhFwZGIb?=
 =?us-ascii?Q?9oJabzbWR3evFahO6qs4lIClOuIhGLOzJ5apEK9U465oq7VLJRKYy4ULpJdl?=
 =?us-ascii?Q?6wl8Qlu/8g40eD4YrMDtpoiC934No/YOD1cR6EjWNc+GYNdRPS9BaXx2vAUs?=
 =?us-ascii?Q?pEFbWo6Axk/zDGp09yy0ExtWw9878A9eXl0RhlkiQMrRq4uUFkDtgJcbAcZa?=
 =?us-ascii?Q?GGY2lDvacrlir0wSiNnv+2CV1CBnhc4q21iksBc6cFb8dblcR1BRYNVmW/9b?=
 =?us-ascii?Q?i7tiwzR7QPK9Iskw5pVYxggndwzbA/CGkqkebqXjXcChxQztioIG8CuEOiOB?=
 =?us-ascii?Q?Ro8LyP0m/SwcR/v+L+pgbwAxZFVM88tAmC2dyLE7exTwwYQ1wafVVR2S8wuT?=
 =?us-ascii?Q?mn9u3174shMf5aWO8nZQVg9JZvzdtimb2lDbYJ4keJ2L3H8yZhd22TZkBP4X?=
 =?us-ascii?Q?kOuurWKHKIkyki0WRnPWJbgfM/DejQg+nmNaQp2yqOlXlt+8jp7dNnmwjozx?=
 =?us-ascii?Q?F7hmgIOS3s0nE7lFtcfcqZ1JYBVRLTJcrt3kIRzAj5Nl36BF7IeHJcj5ODts?=
 =?us-ascii?Q?h2ti53iW6ToXFx2ecM9gyWhgH45DQMYWwy6c4IaABbkgtitCO7WDz/LEdaeT?=
 =?us-ascii?Q?qjDucmu8FBWKochQLKd0P1v9h+Lem50ZHLlZ+1Jb31CVhR9SdA40NlojnRwv?=
 =?us-ascii?Q?Nl7gFiadAHTc5m8ppnC3FVOJI9yoKo0lK8/SpJIz6Ai4YnwVQ1PlHXnldAGu?=
 =?us-ascii?Q?t9HXvSFHlqkP1boLbDQBnq97F/j41fEWMCLBp89z6zXLFnLsWiQ7fIzmN6LA?=
 =?us-ascii?Q?+/HY2msv0U6vCcMGsdum8/wpmNe1XEp20pJDpFm2lKKPUyFcbrODXzG30koq?=
 =?us-ascii?Q?sUg2T+7bl6vPm3AZcj9H/LY2QezslcXBmshGFeJZrLM4RkAxVqri97+yWe96?=
 =?us-ascii?Q?dytFRbwsgx19yTi21yoyiSMjCCRSarJAeggwDJE4PZDAmr9EDWP2U/cWr+MK?=
 =?us-ascii?Q?rebNY0iioNZ2IxxRRpUb8UOVhWRNPUBA/Sx2TPY3N9+IIAUb9a81eRc5f/3y?=
 =?us-ascii?Q?RWQiKHDpud6kMMzAMs0LrVQyRKWzZBbduRHCwZacSyDdfPOmx+rIjM/o5PT4?=
 =?us-ascii?Q?Jn6pbgYP+QIg5ONuT2z17IIMYT9pevJsT+PpRzvY1dJX5j3fS8Ak+nH4CQrl?=
 =?us-ascii?Q?Rg+dYnwNm9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0InnLKMgPTp4zyB0fQZt+W4ESD8GuolDoKOt86tdvUXFHzTs+T8RvXVUSxO?=
 =?us-ascii?Q?0WLHxThbK9WYMMyyBCxIsnYGUQTZqs99WcD2RfgJET8hNewQScUmysPrgpgF?=
 =?us-ascii?Q?u90ajFKJY5ekc88MlZOK2rZPucdxbbTEd2qwpXkvDvqYYCFKRfXYYvFAPD9M?=
 =?us-ascii?Q?zHisZPgVX3gNWy4BjAyxeT7eoVrXDFHlciBo9Gdr6VaH6fES9plUef7MW5d/?=
 =?us-ascii?Q?KL7R7z7ZzcslfYAJEuHVMS10uiVj/LzvrzL86xdMYEZUUEYFALuO5HdJa5kR?=
 =?us-ascii?Q?zacuP068Hc0AdrvH68Oj7g8c+2sTHIC2j/UvdUdG00dkVkuBp9tvmlKZX17z?=
 =?us-ascii?Q?O7Zj1b5xrjMuyWTGg/784fEI/XFf7/FDlK6Z6OPWvjfM2lFLBg0SGk8g8Q9L?=
 =?us-ascii?Q?191ZoRqauphYxcSJUYE6thLA4lUA5D5U0k9H4/dU+CiYr6byOV2Z3MfMBKS3?=
 =?us-ascii?Q?p+ZrO2+4gJBi9XYqnx7Vl0+5fHCUzloQDOfw+24v024Wf+LOhrOnf0+7igCd?=
 =?us-ascii?Q?74ZFDdXTLyLzurY4cECtP9iQeu9IN9Clf0/uODg6zVE7yRVbDIe/8+MIVs89?=
 =?us-ascii?Q?fQtL36TJwSW0rf/odMqi5/HZbekhGy4fbZBpw3+XI8x245oWu78fZ7y4TqLz?=
 =?us-ascii?Q?CmlmWbe9GX0G5+SdpC0ss1EwOpwxEV9CIeXwe3m9lhlSgtE9rwFPxyqYB4XM?=
 =?us-ascii?Q?1vsF4T5DLhmaenGIaQsG03Kx+/XzAyEPnkcEkvEMG0iBdphZQJrfXCcYvE8w?=
 =?us-ascii?Q?J8RDeq1DazJUnH6dvnp8c7H0YH3MyTOFMebVpq/QheYl31JnAYZwgI9QLlQx?=
 =?us-ascii?Q?3zIr6fpejaK1vIieiGYrRlFD99UK3cdq143/FNetTHjah+TpJTrSoei3kSY9?=
 =?us-ascii?Q?OnP2xVzdiMOSCPONyHhXMlx6oCJU0Y7P7pllR+dfN7/CSTvupWALZEodEJxa?=
 =?us-ascii?Q?vOYXdAFwRU2eqIVjRjkvaKmQ/EDfVeoShqYJtWnTUuLBilkVCDeu2YesWz/o?=
 =?us-ascii?Q?T7fnILYxy7e1S8I2ClMeqtm7Szzd+bT0N7RDwSrvjQmjgzMqJDbTb/8hRv7a?=
 =?us-ascii?Q?qboe6fzGOU+qUkVuxBcYDdMha4+pqtZv4Wc5nOD7rQgY0DDjhBIKn7ySdyOy?=
 =?us-ascii?Q?PxHCeJJSfh90rj5w00HHtfBrm4fTL0lTGEAjEmKpBP41h8P0MvNFFUWKzj6P?=
 =?us-ascii?Q?6QqCMo1d/vVBetQhod/hcY4hM+CW9q9gqf00dMs14xuh0T1a3a+XEMvE+ARL?=
 =?us-ascii?Q?7MT2JksVHs5DrYtJeZNARq0x2LBv4fwJa8szqcsJ1l08qeKrywcC1exZbVzs?=
 =?us-ascii?Q?HUJbXxlbI/3C+WIPyqAT30JhCVudgBuvf3oGx6LrnY1sgZROkjzGxfJqNu10?=
 =?us-ascii?Q?fpo/3Ta5ENoO2R+1FYayAmvhrCuCrkO5gbp/LSJ0+6EAL4pkNFfQTMDltAak?=
 =?us-ascii?Q?+/PLP3ldn7RsXcBZqEuwSH308q3xIYjNDsGF//DrZ7C6eIF3S6r3GSpMEVJq?=
 =?us-ascii?Q?4vs0XX+fURNPAPQ7UVTRMnjGoHftEGxZPiRwhZkb3JDEbpHaWLdd1yBROXQK?=
 =?us-ascii?Q?VmRmQ/rZuGtxhMJsez8gp3i3HrIsan+gAHnPSChj?=
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9253c3e3-7d46-4f5f-e4b8-08dd33d6dd88
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1942.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 13:33:29.3328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPCYSxoMYVq2G4yvQdfjKRHUffOc6EhfcOLx4D9moUUSB14XkzCmdsCGOhxPlEVxE5bPFd01+FiVSWBTeUhLiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1594
X-Proofpoint-GUID: O4DZGkhXQqu248YydMc54LeASRvEWU0b
X-Proofpoint-ORIG-GUID: O4DZGkhXQqu248YydMc54LeASRvEWU0b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130114

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

Burst write with SPI is not working for all icm42600 chips. It was
only used for setting user offsets with regmap_bulk_write.

Add specific SPI regmap config for using only single write with SPI.

Fixes: 9f9ff91b775b ("iio: imu: inv_icm42600: add SPI driver for inv_icm42600 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Link: https://patch.msgid.link/20241112-inv-icm42600-fix-spi-burst-write-not-supported-v2-1-97690dc03607@tdk.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
(cherry picked from commit c0f866de4ce447bca3191b9cefac60c4b36a7922)
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 11 +++++++++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  |  3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 995a9dc06521..f5df2e13b063 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -360,6 +360,7 @@ struct inv_icm42600_state {
 typedef int (*inv_icm42600_bus_setup)(struct inv_icm42600_state *);
 
 extern const struct regmap_config inv_icm42600_regmap_config;
+extern const struct regmap_config inv_icm42600_spi_regmap_config;
 extern const struct dev_pm_ops inv_icm42600_pm_ops;
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index dcbd4e928851..14c7c40a3f82 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -43,6 +43,17 @@ const struct regmap_config inv_icm42600_regmap_config = {
 };
 EXPORT_SYMBOL_GPL(inv_icm42600_regmap_config);
 
+/* define specific regmap for SPI not supporting burst write */
+const struct regmap_config inv_icm42600_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x4FFF,
+	.ranges = inv_icm42600_regmap_ranges,
+	.num_ranges = ARRAY_SIZE(inv_icm42600_regmap_ranges),
+	.use_single_write = true,
+};
+EXPORT_SYMBOL_GPL(inv_icm42600_spi_regmap_config);
+
 struct inv_icm42600_hw {
 	uint8_t whoami;
 	const char *name;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 323789697a08..193afb46725d 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -59,7 +59,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
 		return -EINVAL;
 	chip = (enum inv_icm42600_chip)match;
 
-	regmap = devm_regmap_init_spi(spi, &inv_icm42600_regmap_config);
+	/* use SPI specific regmap */
+	regmap = devm_regmap_init_spi(spi, &inv_icm42600_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-- 
2.25.1


