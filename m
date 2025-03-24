Return-Path: <stable+bounces-125851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB7A6D4F2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B32188D1BE
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFACB21D3DC;
	Mon, 24 Mar 2025 07:21:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D70209F2D
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800885; cv=fail; b=AYwLNmKDKnvq3iChmEBi42ZEwxo7M8WpcSFXPaWGwemFmRgwqSrVQtmXybXKvVkVf9hZxR2/DLomQfYIq1A5ANM/UZZk8ZgP2nw8koR4aOGOkeQNcPXqiGNt3bzuPaBlQC9AKNWRtv1ZwB+0QvgbtJwizTwpwXMoedvjWEi43bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800885; c=relaxed/simple;
	bh=jOBnrpSArs72MrqIxdq9yvcwDuaewY4YRii6M9fjWaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i3GKsUUkEVskvk1yaUpxn64cn5NoWK4LVYmmRV8Galmni0sqfUB0Alj+NDDeDPVT1weDIWvWkkpMJEfJHoQo6nkrGjAmF3iPkVl4n5nRoVE5OwWIQbxTLOknfWsDyXKBLyeqZFPzeMYi0+2o1XNXJh7Pud/I3oNwqFYmjV58woY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O5v7lJ005911;
	Mon, 24 Mar 2025 00:21:22 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqk9fg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 00:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TupYnP/4QyEtlxXD6H3MBmYd39iH9aoOpJA2aaEOpFxOevzLh/ZelqsuecjkdvYt0K99lFv7+dhnUh5jbwtqHEwtTIHLQxWWSE6TWPv5CPd36mTyNzqlEZoC8ptb4GmMDNB/JpZFARTs+Ki1I3n6sDuNrYkUOQEjkownvhgYyfJ5LN2VZ/iGbLodYzl6i/Upj1SC7b3mpi6M1SkYBlOrR0FDrU7UKGxE/3ftRJEIE1nT+F2ukoozz2QA++tmJMbzZYfxykHnaVxBGh+qPWpRnl8TSUBmKTTkps+CYlFLVepmYe+z5ZvaLBJDiFUN7Yuodcu68j1++uOXNDdfnXBing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rb23Jz3nR0tmdxaqmeADckvO06GgBTxvLGcjglzSfp4=;
 b=qxbOauTv7pxQdXSusLJq/1xUl+jBBouFC83H+aUZDJpbHf6YgoXKqwpSnLg0+Wraidnijtv7px1HMW5S2aKuf40hF3kEorgKWraYKDds7mXowKqXHWrbG6tLetNNA8xOFo4zyFwnFrJNYTjNcWJkj3dcnlIsy+j4KzVSfc+NdiTUUP67lABTAY06T4p1WZsIHA0wKE2RlCIZXtAQKdzC+rqiPAWfJzKCw4Vz9U6Z7Y8nRQg/yamFPBxSlHmn2CoqE1gL8I3iptyG1Ca4aUp1oFuclk4W0P1sSDmCoWRk8QCxxxYVy90f0yTr+aaL/WNeKD5Zw3jKwOua+0O/U71QBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:21:19 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:21:19 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: regkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org
Subject: [PATCH 6.1.y 5/7] binfmt_elf: Use elf_load() for library
Date: Mon, 24 Mar 2025 15:19:40 +0800
Message-Id: <20250324071942.2553928-6-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250324071942.2553928-1-wenlin.kang@windriver.com>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: fa249ef9-2313-4445-2737-08dd6aa47913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?07H6PdoahwNiHEfuFV9Xy9lfXZTZi8Jx2N7GviwWcULVk3cjVzx1Aj+mXEyu?=
 =?us-ascii?Q?bS4+2n0nWu6yVrhlgFTe1Yne/oRY17IIxgPHw/IWNg6CWe1dwteqr4emsQzp?=
 =?us-ascii?Q?fUkiq5keoghinlsWj3OC6oEfd6gFrc7Ku75ij9lYJUx8ykJIZWGVi8al8qRE?=
 =?us-ascii?Q?BggWsTm32DhY13VI4iF0QLyokyWTwS5ctBzrvcllbjMCLgDojAentAt1GuSN?=
 =?us-ascii?Q?AuNOnu+wYVOMkZLvyCqTq2WxfPUaFB0MXsDPpd5me8nwfYfd53p/MPwSbLIs?=
 =?us-ascii?Q?BYbHKdUmbdihaXylC3fdYsHEoJE4kTvVHQkK257qeFi2bkgWjFqzJ46YX6Bs?=
 =?us-ascii?Q?Rfw3sSA2RYeyCKTrNvak3DCtnaySIOjey0FN/zKCpXFs41GCWvZ3gxeohgOm?=
 =?us-ascii?Q?LLKM0dKqH9mTtp5O4qJRvTnSq2is7IQMqknS/25tNsjHC1arT9j+TqpO6kSU?=
 =?us-ascii?Q?J7m3oS9K/MxOa5kLEDOCuGh3d0oZVF6NrK6C+yjImk8TWm1okxvsLQjV+QID?=
 =?us-ascii?Q?i12Ub33YjYNMD9Zoxw/PlUNb7uhZJbAAFz1MD4FA1QHZDVLX2+Z+6jWlO/Fi?=
 =?us-ascii?Q?HfTzKBKDo42iUaUyTirV/DYW4Y09zVaCj9B+LBT/nY15abl9Deg6+yrxlyiN?=
 =?us-ascii?Q?blqQRl9wiBD0BsoGlNwggP77d+lIuMIcJKHX6Rq27GnnqEdiJyitIORLfb4A?=
 =?us-ascii?Q?mvoEMSUO5Fwu3YYNyEtVUfzpcy+mGGoulT3uUvEjzQYRUq1U8AMtX+Ywh0YC?=
 =?us-ascii?Q?SYJdm+3MTZnPtm0CVzdMrDNcEEimlSgrzeAftW99+HzxSU0x2LCzJHY9+lbT?=
 =?us-ascii?Q?pNCmcblJYJBIdUue6SV22NSnwkFk1SJQmSYnHFertgZXy4EiGdXFnI1atu/D?=
 =?us-ascii?Q?PUgmbAeQKsBhID0SGU0sKZo3qgtOJzsHPtg6hay2kIFn+GFwk4pxz/nDPojm?=
 =?us-ascii?Q?LaiHAorjOx5SJgK0o4a0YXXs97mnZvk7D4kWERnAalVpmi9FIooFBCZLBUiR?=
 =?us-ascii?Q?kMCwhUxXuRqGnFWqQsxXudrl0TW30rJHua/sJwVzM+WJkjsTElkTtDqcm7FW?=
 =?us-ascii?Q?1CyZzvuZE6wngP636O0Zq9JSFYY8IhVic48MIkBtO0f27jmTvYp0LEqPsc8v?=
 =?us-ascii?Q?zPuz1jsyk0d19pdvjci1AHlQf2uGRHqqjpAjlSIB8BhxxC1lZwFXuzkbELBv?=
 =?us-ascii?Q?nIki0SK18i/Pr+/qqxGo0z4UD1AYsmPyG+/K8/0ZECdSGxFHKyR+mukFdZHN?=
 =?us-ascii?Q?9uHdqruqEFtPxQhM/Y0Fc459HiDLf+d+5xHa4qVgCTIBqbuxmAcPti/m05CF?=
 =?us-ascii?Q?gqr2aoyupHhgvuAMUYjokGoov2+Fi/Wkz/v+loZIk9wN2c3ozqnTjzvCXOHk?=
 =?us-ascii?Q?eXsTGHffyUJshFG5peJSy8HcYTxYiEJvZWYy+JmognxdyjDpdX11wAm3h76r?=
 =?us-ascii?Q?ZNcta7Vg6XTUnIDjDAseBsRD5oKQ73m0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EuUqH6LtM5HSxVnfsKhbqpYs5HilG/LH92Q6LsrlHYDfyMml9Wo2NXIeQdVa?=
 =?us-ascii?Q?CtP912PBPnt1HIqLHikCbOiAAhWzn2UPeHXmB0gXTuK+vAoT5vvJsLnH/VzU?=
 =?us-ascii?Q?+XQIXveXaFV4Rs7v17D9mJvIFEXfM0vNxC0vydDJV3Aec3vAznC2uTEebDar?=
 =?us-ascii?Q?86lyrsm772GEwUiQW+Jf222wUDEIySz2oG65AVxZrRDr619mWZWwB0l9AP7V?=
 =?us-ascii?Q?laP9rH25fAoT00Ep22c45NI1aL1p0sA4QWA93aF2vCfMVq5eeBVefRYdmcKG?=
 =?us-ascii?Q?LDShgGiGJarL5i5G+NA6yp65wVdFy9m68ZnPYzMD9KYIE1ZBXhfo6Ut9rK2o?=
 =?us-ascii?Q?Cj1LkiVIwe7hVBJM9uNjp8iBr62csc6LJr+h7SstcNy75iQOTF5reuqNF6M3?=
 =?us-ascii?Q?8ZhVrI4ABTVo3MhZFPlzVWhb3PDEdxmN1jCeqRSvosKy11vsCU4RlUJLlGss?=
 =?us-ascii?Q?WjxnEoqH7qTZwNn3UFcCe7Uts4+OZ0x0187kJKDxoBBjBz/TmmFd7vLqwv9W?=
 =?us-ascii?Q?9NQYZB+VkuK7o7v61zRWbs4ncW23VJ/9LHY+/cAKigxY5LHKTeNviG5gUg5E?=
 =?us-ascii?Q?TM1Va3V8so1fPFD8agtspbOE4/IMvaibJcN6LcM4eJQDkDvfMBQgSMDI9fOE?=
 =?us-ascii?Q?f6XIpItKc1OV0ugPbWOAbqYxdZVbA4ryCJukPmIKWrvhqcmtx2agdpnDMwOx?=
 =?us-ascii?Q?TMuYzXlZ8PLLKXhwpMbX+mUlOC2qiu5xsErUNbvS6WCcGXmSZvhsSYwVuWtK?=
 =?us-ascii?Q?yfLyq00prUGF7Xfvla1IdUB7sHlUVmWe518OaICivODT7HhNWx0ChYmEdLr2?=
 =?us-ascii?Q?R43POGqeGaW7fuqRfITwmjkghkxN2CV9FoWJHeofcKZZouUpuB550U7qpKFH?=
 =?us-ascii?Q?YmVmcl5CD7JgEJFAs/kJFHtclBjOSNlFB1jwvaAbkOIZIBKxgoFJBfvx3NST?=
 =?us-ascii?Q?tTNfZjd+6gjMKSigaGuKRGPconR22P7OsTFp1fedtXU1RhAQzWoPNYQCDo9E?=
 =?us-ascii?Q?xYt2sPqqypZjKefym63Wp3zWT1eYIHRfjwQlOSosnpFLm10UHdFiU0iNwMNT?=
 =?us-ascii?Q?E5Vn2uBLnQivp1R8b54U3p5d64TKkXLB/kdc9epxQBr4I1jfchn9crKuu+KP?=
 =?us-ascii?Q?yVjUcy3JB5rH8kBB0l6ufmcDdkVsVnixlTNi4dmipda4ZPz8N3SBBOuZ3e+W?=
 =?us-ascii?Q?i9npSF7dX8CoDydrhDPa+JKbMAJuteDPuKnFiW4ZmkKLx5G79PF44Pe+iEUR?=
 =?us-ascii?Q?QP9J6HrNWey8YI5rtoYbJKLWnMPEYsbDI/1nu7vnxnNVYSTRHViu0HwSa0qD?=
 =?us-ascii?Q?1dyfMSd1p3rndp1LayOOCyM0IEcZGZN8McyhsJhnClKx9ZH+bkjp+PMn38QZ?=
 =?us-ascii?Q?WND4Ok7rp+zhUEDI51TvDMTXgbAEU417uQsfiEw+1APZaNKA9tBAxrusBMDv?=
 =?us-ascii?Q?iSfP6UJyTXbsiwUb8O3xTec7Me8sTVyb2n9Fuh8xw2UgD6q1d90NznLbcIly?=
 =?us-ascii?Q?wPMKEOAuz+kPYhLJP60wo+36LhqCrqzEEUbmITZgAKfW4lTAh44NA4aKorLK?=
 =?us-ascii?Q?IWPnDshqeN+ArLBVTFpmuseEWuXt8M0NIDScGQ6AIN7SjZGvTvqG9iKxNjJb?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa249ef9-2313-4445-2737-08dd6aa47913
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:21:19.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2X5YKnHmp+Y99SOzGcU9w6Dsye2YDb0yXlaGJZtbJq/1HQKWXDV3is+OFK5OdtaMfpUH+9zkftm76EQM6HH+11TcoUhZUTFO8Q58HlToXbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e107f1 cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=drOt6m5kAAAA:8 a=37rDS-QxAAAA:8 a=PtDNVHqPAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=nZ8kGeCxs_7PGkKCuCgA:9 a=RMMjzBEyIzXRtoq5n5K6:22 a=k1Nq6YrhK2t884LQW06G:22
 a=BpimnaHY1jUKGyF_4-AF:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: VjjIW3uMyGKu1v8Qp7_PyNVzcnx_L09A
X-Proofpoint-ORIG-GUID: VjjIW3uMyGKu1v8Qp7_PyNVzcnx_L09A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: Kees Cook <keescook@chromium.org>

commit d5ca24f639588811af57ceac513183fa2004bd3a upstream

While load_elf_library() is a libc5-ism, we can still replace most of
its contents with elf_load() as well, further simplifying the code.

Some historical context:
- libc4 was a.out and used uselib (a.out support has been removed)
- libc5 was ELF and used uselib (there may still be users)
- libc6 is ELF and has never used uselib

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-4-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 64c5e5cd0cd8..ba1ef7e3f9f3 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1308,7 +1308,6 @@ static int load_elf_library(struct file *file)
 {
 	struct elf_phdr *elf_phdata;
 	struct elf_phdr *eppnt;
-	unsigned long elf_bss, bss, len;
 	int retval, error, i, j;
 	struct elfhdr elf_ex;
 
@@ -1353,30 +1352,15 @@ static int load_elf_library(struct file *file)
 		eppnt++;
 
 	/* Now use mmap to map the library into memory. */
-	error = vm_mmap(file,
-			ELF_PAGESTART(eppnt->p_vaddr),
-			(eppnt->p_filesz +
-			 ELF_PAGEOFFSET(eppnt->p_vaddr)),
+	error = elf_load(file, ELF_PAGESTART(eppnt->p_vaddr),
+			eppnt,
 			PROT_READ | PROT_WRITE | PROT_EXEC,
 			MAP_FIXED_NOREPLACE | MAP_PRIVATE,
-			(eppnt->p_offset -
-			 ELF_PAGEOFFSET(eppnt->p_vaddr)));
-	if (error != ELF_PAGESTART(eppnt->p_vaddr))
-		goto out_free_ph;
+			0);
 
-	elf_bss = eppnt->p_vaddr + eppnt->p_filesz;
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
+	if (error != ELF_PAGESTART(eppnt->p_vaddr))
 		goto out_free_ph;
-	}
 
-	len = ELF_PAGEALIGN(eppnt->p_filesz + eppnt->p_vaddr);
-	bss = ELF_PAGEALIGN(eppnt->p_memsz + eppnt->p_vaddr);
-	if (bss > len) {
-		error = vm_brk(len, bss - len);
-		if (error)
-			goto out_free_ph;
-	}
 	error = 0;
 
 out_free_ph:
-- 
2.39.2


