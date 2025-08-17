Return-Path: <stable+bounces-169897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A735B29478
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 19:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE2A189A47B
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC23226CFD;
	Sun, 17 Aug 2025 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hIToX5WE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i1da5Xxy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC31C5D57
	for <stable@vger.kernel.org>; Sun, 17 Aug 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755450697; cv=fail; b=QlTMiHWh6ArEwxxs4euoLc29zzkl2YiKOOuWXbkGNJo5pez2Rt3U8cl8WewzxoRrfL7KTFDeCRV1hjhFDS6qNASihp0sY73/XDfibmLr/KBdaYjROMJYTSYEaCcOaUVFOAaQm+qssZ4+SWym3rOs9hL93EJT+kcErZbuPYphDpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755450697; c=relaxed/simple;
	bh=mo1lDuEOAiDd+mxUNiXIEXjKP9ji8TSbxZbrE1weyAM=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=b/HQQ/qQBIZo0AyQmU1JiGRfWLNf8NpBS5R8SaYECQfO2cyMhfT2+cgf5Y8BJFr1l0LEpJDMJ9KfmIvKoW8saIa1MvIEvhDCM3DWrxUtUhPbOni/Sk3dUoImhi7XWVsD94khd2TLy6Dkwd6d96OjcDtYoFXabhociC3o+PJZPww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hIToX5WE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i1da5Xxy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GMpGhA025390;
	Sun, 17 Aug 2025 17:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Udy+vbxDIfouqPKb
	HJzz5yQG4xvFCP63HJqIV5kKzvY=; b=hIToX5WE5LsxViF4WJd+JpSYndSVgfMC
	qzSDe90Imv8TmaEi1y0Rj1pB0WHBfC0nO2JgL0ldDgYupVekYr+0s8701yoNgc3H
	s61w4pbRYA3p3/+SYuBk4MPH0zXCHk6nuB/L+RQDxc7VRqBDN7JUkAs3nBpITDM+
	CIkhisNoqg+Ss5GcXHB8LaH4SOjAO1cXVrKZYW6JI8PBdQ7n2XRuo29tPCS2iXQE
	Tt40nE2VsSTlJPEWZApxjNTrJlDc3OAacilhDiz/xTpK598YkxlbTor6O9v51Uwf
	/i/IGZz+1FQ7BEPZHNBy3/b6AeObj7T+utOePssI1d++rJFd9cwGIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jgwe9pwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Aug 2025 17:11:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57HGiJZS024474;
	Sun, 17 Aug 2025 17:11:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jge8235n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 Aug 2025 17:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRT1sEQrfOnqdQXdDfZAOXCkgOnliUXPix9wBSHa+YTMlMrN5f1WrIXRLh6/2IhV14JobVsFSpc0Osu2DSkwOlz7JsXS0NawZe1Lj0NxDCXNECq/Wm3UJ0c5DBHXsTy+PwsvHY5ztfLqm8UoQE7dHyf7bYOlZvBMDwo/JvjtbhZaEb5mYWFWmbsQR+n1rbSA3ZTdj2TiwYKv06+4AdFSYU3JIsIWD0DsY1T5JpV64pkIuAe3B3JUHxtKTNAVGSaXK/RYKzuRRc5l/loUfR7BkSSw4plbubcCbi5V7ucAh6peOh4coTiuOqUHHVa/POhm7OnLQpwtlhVFCgNXcqRk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udy+vbxDIfouqPKbHJzz5yQG4xvFCP63HJqIV5kKzvY=;
 b=GsdvCEiGMtKW9Imltff1274BFFS8PTYDZz3w4h6BizI+nthF8Wwcpbmpn5bPWgdp/AH7t0SxZogO1BnbTZZ1F3PyiYQrv8kpBlufEdqjodlcJk7eakTHsBT0BSVpeCbP/7IgnmrbqvuReulJ5yZVDCu66ewDZrBIxqS0iuMmUi3X7Wd4r/WN2j2Hvbrdk9+IcddoBPff/rygJjUFw3/mEH0t7bwKso3aTQwaBF9xjKSd1QVGqv6QlMBtsWFMGdBICClMV9GUq6Xc225KdPJqdqUEUZgRyIc5l8kCLx4Ds4rjunGbf1/bCfNDiHkFIkeFYrCRW2bAeMgcYNDOIE71YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udy+vbxDIfouqPKbHJzz5yQG4xvFCP63HJqIV5kKzvY=;
 b=i1da5XxyJPWazbm+2/wG5iVBi+IFmSI8eObAk9nywEXJqSFqP3BxY45rzZJADBvudEjnV+B7qE5piZzRWJ+d5hFtzhJ15FoBUdxszG+p1Avq13HnoLWAPrjU8qOHOCTaTP0vEr/3XwXbmo9uITIrdbiQKPjstnJ6fq6W5/sCoeQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB8000.namprd10.prod.outlook.com (2603:10b6:208:4f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Sun, 17 Aug
 2025 17:11:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 17:11:17 +0000
Message-ID: <1f29bdc8-986c-4765-ba82-9d7ca2181968@oracle.com>
Date: Sun, 17 Aug 2025 13:11:14 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: queue/5.15 kernel build failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:610:20::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN6PR10MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f863321-df42-49f1-58d3-08ddddb11420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVVJQWl6ZnYzeEltaUJXN1hDQkYwb0xPM0o1TUZGdXR0eXhUOTN5VEMvWVZZ?=
 =?utf-8?B?R2hzM0ZvU2czUDJnbUVESzJON2F2cit0NVMwcnV4S1hvMHRmZ0NjZ0hKVE56?=
 =?utf-8?B?dzBXZFIvQ3g3RnpOd2JSM2hpOXdIeEZQRkJ1RWxmdDdFU1M3OGxuTkYrbXVL?=
 =?utf-8?B?eE9wTTBJTGUweEdRYnVZZ1laWkhPNHh6dFE0UnUwMDM0QXhlUm91SXdGUGl0?=
 =?utf-8?B?UDRuclRDZ1VMMFF3Y05LamUzb3VrMTkzVjhZUWtORVNaMmI2Wi9mcENSVHVW?=
 =?utf-8?B?WmpFeUhVdWlqMjJ0YWN4Vk9tdjFWbjh2YjI1RWI0dzk2RldpbFcraGU0R3hl?=
 =?utf-8?B?ejgwd2h3UksvbUY2RVJhNjd5RXFWWVZPdGZpR3AxWWpucldiMFdEb3BSR0NF?=
 =?utf-8?B?dUlHNTlERkVQSGdwNHFGK3VkYk4vOHdKeGtpZjRRV09JcFRma1F0TWMvdjdx?=
 =?utf-8?B?VDh4THR1aE9kdzhvTDdkeXY5c1p6bE5uT2F6WUlrRkVCTHpOOXYyTWxtT1dM?=
 =?utf-8?B?UXFUUmM0K09hN3JnSFU1Q1g0R1U3S0ZBRDVQYkVjeUpJempVN1AzSXF4QjN2?=
 =?utf-8?B?OXV0N21CMUFHWkJKV1VYbEwwdWNxSzV1SyswL1FPR3hpTnlJYUFDSWpHYkFH?=
 =?utf-8?B?S2J5NGpMbnV1bjdHSzhoL3FYMDNvaXFEVTUyeXE0Zi9OQU9IaEdYeWJoZ3Zu?=
 =?utf-8?B?Y0pwbTloamRpbjRhaVhWbGcvYTNxM3NuZlo0aVgwSnRJMUl6cnJFc3JhK253?=
 =?utf-8?B?Q3hjTE90LzhXRGVuNHR0RU41QWkxbnBIWlJPMkVsK1FWazA3M1poTWJMaU1p?=
 =?utf-8?B?TVFWTlAzYzZ4ZzJWRVIzZjFzL2dWRGo4S3htUXpjbEQwSzZOeExsQWh4b1Bo?=
 =?utf-8?B?eElhVTBvWUsyeWdPWTdOR0VmMkIydW5iOXVvYUxoYitvbmFFVUpZcmhEWVlJ?=
 =?utf-8?B?ZGI4VERvUElsYTEwQnJlUGRNMkt6MkFaNzVwclNmNjdLWFZEeVVUWTgrVjNj?=
 =?utf-8?B?RDVqeDVEMTFCanJCY2x1UWU1ZWNqdWg5MXNWUEp6U21qNDJybUtKL2V0Smd6?=
 =?utf-8?B?UG1yeUkrUGZweWF6MmU2MEI5Tmo4dktYY3I5dUI1Nk9qeGxVZG5TV3NDOXBh?=
 =?utf-8?B?R1lRaVUva1BES2w3UXBEK3prejB1bFRSOEkwMGN0YXBra0d0QytLeXRINlgr?=
 =?utf-8?B?RmsrOG83cDQ4bWhmSCs2cStydEdXdDhjMUw1djFzeDQ3SjkyUmhRVDRlNzV2?=
 =?utf-8?B?dndpWHRRYy9XWUJIc1IyMmlaTnk3TERmSUdmU09kQ0hZbnVNdDdlRDRRcDBY?=
 =?utf-8?B?aml3NUxoUEhJT3ZCc3cxblA5bUJLb3NJMUphWWliMkFhMDBTNlZYQUdEVElV?=
 =?utf-8?B?TVRuelJZTysvZEUwUlN4WEpHYjZDeW5rOTlza013OHMvekxrWGM2Y2oxOEFG?=
 =?utf-8?B?VGo1dHhreTV5c29PMmdvRnFqV1czU1ZzdHZCNnRjV1BsMURMTlJaWEduNHVF?=
 =?utf-8?B?dng4OFNmNGV1UCs0ME1McWM5UzRrblZFVjFBL1UyalVKQ2dkTWltWnBjTkJC?=
 =?utf-8?B?SmhLZXJ1N3lIY1dPQjQzdkhtMnpCTmNXVDF1aURiVWNqZ0Q2K1RmQVlHZWYz?=
 =?utf-8?B?NHRuVy96OS9QZndhWCs0dmZPMzVZNUQ0L0k1SkowK3p4TFNydmpGanZYVUQw?=
 =?utf-8?B?YlN2RHJFS1o5QU03MG1rV2tXZ1dyeVM5aVZCcmlBRVJMWXdGWFpJRVU2QUkx?=
 =?utf-8?B?dE0xTURWUDYzUFgrRk5jbzNCZExWSFkvQkxhZXRpeFVXa0VWM3QzelVZTnFK?=
 =?utf-8?B?eWpiMzlaTXJ3b0ZmWVdtSlJhSE9kM21kWUNmWE4xMElMbE1ibE5uOFFnVWlu?=
 =?utf-8?B?SnVKbnVKUDFxNy8wTmNEaFhzMTJ4QllEWmY0L3JMZ1VYaEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U29UeG9MN3Fjby81SE1aOTBySVRMZVMwREYvSHRLdCtBUmlGb1o3ZzJ4czJw?=
 =?utf-8?B?UytSVjF0dFFJZkMyTW13YmpzRWpBbkFnS21KRm1MNDhnZy9aMVFtSjFNaWx6?=
 =?utf-8?B?eTZtZHhpWmRiaFh1ZUxQeEZjcE4xZUo5d1M2eFpvdlZnUTN3NE1ha2tSaGdi?=
 =?utf-8?B?cUJoYmY2SkNtUVVUNnFYOXJWYjJ3ZDdnQWVhck1BeFdlVXBTQ1AwNXpDMVRL?=
 =?utf-8?B?eklDRk9MWG83QjNCaTExMzEzMml3dW03SlllVXpYODRYV1hpT1RJOGFORU03?=
 =?utf-8?B?a3VmTzFRdkhnaUxWRERZbFU1WnIzNUFhaGJvVkR0QjQ0VTZzdGEwRFBDS0R0?=
 =?utf-8?B?QXMxa2s0OGF6dTl6cWE2Nk5sNW9aMjdzejBrVzJMSUFwZE5ZMVBjbTNQNzZm?=
 =?utf-8?B?QmZydEUwUHZFU05wUndUZ1ByWGtieFc1TDUxMVlVT0x4MkJwajREV3BsNXNr?=
 =?utf-8?B?RnNBR0t0VHFXMnBuM25qRm53aThpVG1QL0pHd3UvNkM4VjhudXBRS2hQMVZ4?=
 =?utf-8?B?SHV5bUxIMXFqbW9HeWlHbjlyTU5jbVdOcFZZODJYbC9waXdudkFGV0p4RzVa?=
 =?utf-8?B?L3hVeVlWQ29oeHc1S2NEWVdkRytyZHpET0RTbEE2T0ZoSHVOSGgzOThWSVho?=
 =?utf-8?B?cWZycXR2Y3hFVHNUV3ZvRDFjTmpqYnRnd0gwUzB1ckdtbHZYUkUyNXkwS3VL?=
 =?utf-8?B?c0MyeTBoMU1YeDBNYWtYLzRTT29ON0t4U0E3NVZ4b2lTeUVXYi9IUDBwaGVi?=
 =?utf-8?B?V2wyQ001b2U2WUVTaVpSTWo1dXhSZ0IzNTNDWHI2SVlTb1lJWUdHd21GblF0?=
 =?utf-8?B?azdpVTB4eDhtL1NwY3JJeWlPQVdWRVVXcFZxeWZJQm5GQkliYVRnTWVpcWN5?=
 =?utf-8?B?bXZ2eXlGYlVYT2ozTWwzSGUvcUh2Y1MyUjVNeUV2WE8zUlovNFZQRForaE50?=
 =?utf-8?B?aWtibTlIUC8yYXRyRlRwRm1QdS9WZVVxZnNjUGNUMWJ1M3FoQkJjMG1Xa1ZE?=
 =?utf-8?B?ekZpTHNhLzd0NE5ucVg0Um9iWmZ5TnA1dXppMEE5SGE4c2J1N3h2cVVEWFZT?=
 =?utf-8?B?b2VlcHRZZEYxbE9POU1YNThraFI2TmpZUXkwSFprYys3Ylh1dXN1RWdUZ1NK?=
 =?utf-8?B?RWhROVZvV3RNQ0N4TDRCZUlLV2kzVEI4Wi9DbGp3NVo4R2w0MlhNNTRpd3dt?=
 =?utf-8?B?WWpkNFRrMXVlQkNudHlrOXM3UHk4Y1dySjN4MmE2OXgvQjFHaGJ3NERKR2RQ?=
 =?utf-8?B?aFRGalpBbE1QaW5ZSERIMTg0bjhyZmxDQlF0NXZzai9abTJCOGZFQktaR2Zw?=
 =?utf-8?B?ckhzeUdzU0VtWjg5anNXZGIydzBCV2dqaDdtSHQ2SWhsM0VOY1hycWJRT3Np?=
 =?utf-8?B?d0poTXI0YWFkdENWWklLYlRjUW5HZWdDanMxbnVnY3FTQ3h0ZUs5akl2d0pt?=
 =?utf-8?B?aVlZcE1obzVzbG5jS3VCUXY0WVNMcGVjZXlvU0FzdERjN1hTd3dLTmxNMHlO?=
 =?utf-8?B?d0VVYWZLcEtreHhJbFVERmxST1BIajd2eFphK2wyQVIrY2RiNHZrMStxeFV3?=
 =?utf-8?B?S0swTW04YjhGdE9JY3M4TzR1NUFDRzhBa3ROMjRFVnNBck5laDlSSjM1emtt?=
 =?utf-8?B?SzFRbmhuK1ordEZVVDFoa2pPZ0d3YjVyYmlGWW5wbGFoM2cydm5SVFNWZjhj?=
 =?utf-8?B?M256ZzBxTHNpbVpVekticFFUUSs2dmxoL3N1anBaMjQ5K2hvcy82ZGNNaFQw?=
 =?utf-8?B?UDU1eHpIb3dhbU9zT0ZRd3o2MWIzb1NsWUx1NkJ1R2ZCOHE3NFZYdzZld3N1?=
 =?utf-8?B?ZE9LSDIrQVBoMHk0R0FlMG5LamIyZGNNMEp4MjEwc3kzN2U1RzZOdGwxVXlx?=
 =?utf-8?B?SFNOcVd5eTJuYUhpT3BzU1pZUEliSHE4MUgwRzZncnBvRDU1d0N2UnB4Z2Qx?=
 =?utf-8?B?VW9LR3NzdE5HZDRFZ0xQMHE3MDRiZ2VkRTU4anloMGpiTGdTaFNDVlRlY1I3?=
 =?utf-8?B?WVUweGUxYjZoNUcvdDJCeU81dkFyazZOa0g2UXpjbjJhcWV4Si9Lc1lzR2NF?=
 =?utf-8?B?anRaMmorNjE5ZG9weHZjWlBxUFFyOXc0czk0cmtvNFpqTHFpMWlINDNoOGJZ?=
 =?utf-8?B?MTdPQ1hydnMwVTdjc25URndyeXh1aVlJM1FBT21xeDJWZ0dYQkowMXJjLzhD?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pxpIaXUaN+yn359o8K0KfoCxM2TnbmSjPo6r4cikXXr9ZU0TnMnpyCdD5SvTOEq6ZOjjHiOYY2iRQilZTUXjQp0Z0u22KPmqwVZvaXMghnBZP1fVsNYmsXLx1H1W8SU6MJLuur0zzmOL7jnPyKkqB4yNpjxbmIdAujhiR0cUWNtr3OtmwurRzxzReAEOUFmYnlvu4H1gjt4P5PyDIC4vidj1Bd/6O0oVIAtC1w3FGAGlzadMVt8yKzzOXN+0cL7eNES3IEXb2jhDMyc7D2/qgwVj95tR/MpkE93qztEABCIFJ6xHUTEZyOkt6BvAI5vI24DxmGld6gIVOXev92XqPKTeIK3Qc5gVCJqw+tI/khqGaPmpkwyLEs/UA+SlDpIITRtWZ7NhpnscSqzCcxUOpeCMkV1GjhaGmwXlgwal2ZH3PZWxbSNjypFbzsqcId8ZhAla+Muw88YpH5fO1MwjemwyMzvFTzw87EUl6Lj/lCMwzOfaAKuz+HSVBGM5yKBb+M08NsWaLiTndqNqvkxUsSbxL2eFJou+Lo0uqwwU4GAXGslRgG+EnBLp4tfRN+Uu5PCFO23Ut7wGX5gKtHFXnN+Sh1zaR3/zxbVbfZoU7EU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f863321-df42-49f1-58d3-08ddddb11420
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 17:11:17.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DarCGKvQ9/AyPW0bbSpfKC4hlRebyXZa8Bmk8hB2UNhNmlb4iox4PyJXIHxRV1xlNf/D04xBDnI5itMjAEsleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-17_07,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=598 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508170178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE3MDE3OSBTYWx0ZWRfX6nmeaSWJp7sy
 wYhpUjkA2rV7YHwLuT/EDP6Rb+WTclG3d2grXTzuEXGYETMsKTizeCbhRxvQNkUaOzlAnCTcPhM
 xSrCTRCpVPCAIme3lDwrjUNhNP6UEFjgt8vJNfX3MLOfXzgZNJuSgb4BUbRvTYl9WlzcM1b083Q
 Sbi3laIe5SP6vhN5QSYpM07quNm7CYSYE3zIEUK143ipAIT6gO9byMNGevHMysdKkVV0ldn/LDH
 ntByMe80aKhmiJFG0uDuqWvUWwjQIhmjYXvsle1LvHlpBlbeMVjm5ggKx24noKt53Eg8oq9JMZe
 iq0S0+Hxz5M6XCwWhN++HYtKJP3a+hW+GUwBPUXHhStoX97IU3zfJnfbLE/tuGxPsbH38RIHvjZ
 9Hf1zhXMZ/U9iNoVsjbq2jAae8ramtWCFY+alIvZCs80bJtWI9ZUlHYCn6eOFZiI22xczXp2
X-Proofpoint-ORIG-GUID: OWiF7obt7d-jOnDvuioKfbG0Yewel41d
X-Authority-Analysis: v=2.4 cv=arOyCTZV c=1 sm=1 tr=0 ts=68a20d38 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=ooogg7l8Is6D_OXFmr8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OWiF7obt7d-jOnDvuioKfbG0Yewel41d

Hi-

Building on RHEL 9.6, I encountered this build failure:

arch/x86/kernel/smp.o: warning: objtool: fred_sysvec_reboot()+0x52:
unreachable instruction
drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
vmw_port_hb_out()+0xbf: stack state mismatch: cfa1=5+16 cfa2=4+8
drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
vmw_port_hb_in()+0xb4: stack state mismatch: cfa1=5+16 cfa2=4+8
drivers/vfio/vfio_iommu_type1.c: In function ‘vfio_pin_pages_remote’:
drivers/vfio/vfio_iommu_type1.c:707:25: error: ISO C90 forbids mixed
declarations and code [-Werror=declaration-after-statement]
  707 |                         long req_pages = min_t(long, npage,
batch->capacity);
      |                         ^~~~
cc1: all warnings being treated as errors
gmake[2]: *** [scripts/Makefile.build:289:
drivers/vfio/vfio_iommu_type1.o] Error 1
gmake[1]: *** [scripts/Makefile.build:552: drivers/vfio] Error 2
gmake[1]: *** Waiting for unfinished jobs....
gmake: *** [Makefile:1926: drivers] Error 2

Appears to be due to:

commit 5c87f3aff907e72fa6759c9dc66eb609dec1815c
Author:     Keith Busch <kbusch@kernel.org>
AuthorDate: Tue Jul 15 11:46:22 2025 -0700
Commit:     Sasha Levin <sashal@kernel.org>
CommitDate: Sun Aug 17 09:30:59 2025 -0400

    vfio/type1: conditional rescheduling while pinning

    [ Upstream commit b1779e4f209c7ff7e32f3c79d69bca4e3a3a68b6 ]

    A large DMA mapping request can loop through dma address pinning for
    many pages. In cases where THP can not be used, the repeated
vmf_insert_pfn can
    be costly, so let the task reschedule as need to prevent CPU stalls.
Failure to

  ...

-- 
Chuck Lever


