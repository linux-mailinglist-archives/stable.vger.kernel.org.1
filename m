Return-Path: <stable+bounces-136942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B510A9F8DE
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797CF1897CF8
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF22951C3;
	Mon, 28 Apr 2025 18:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dy0T8wR7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YjcHo9HT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C32957A0
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745866312; cv=fail; b=h/AC6FXIq7yej+bBvn9LHUasaEtCPNApJN1glDSIRY+6SLO3avZMI/HVEL2ESnpuJFyKVsVk/QvQ/7JBmIPFG6leorOT2WZw7J6qN5Jsxg+D8GXl42LdcqkX+4PFo8O56gsX1QeODlsUN5IgPkLiimqy77tZ7Ef8It5k2FOJZLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745866312; c=relaxed/simple;
	bh=NH9Xuyn3uy1TyHmi8bchOTNYmNmRsd4G4V/nFTSAYWY=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=UoC6FJADs93xCbBy/T0qJLRNvwkviNDLkIlc27pDsPUxRKj9OXt4oo6xeXTsywhlLgz3C2FuTAkGrEth4BhqN4ER93WFg9FK3DDYZ6HMVGWBz9JdclLaOGp0JN/gtmmhANuYpmh+PYtrJPDap1X3UEjSX/5iXQ4qaU/z1oUjsO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dy0T8wR7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YjcHo9HT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIM4eU007877
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=whYx4azu/gaYy8ag
	veqRwabPgRIiJCQNHjLJ0hCzn9o=; b=Dy0T8wR7YiBgOWVcCl8QnbovtRtVRt0L
	xGrs/qxE/SMkUtv+t5Rmt8WzxG1mPTui3UtcW21EZqD59h+DOlhNDjKLitQdxZ9G
	P34FT6e8jw/p3DI9f5w3Iykna5K5X/xmHQJIeuyyq+Ty+UE5qwKqO73Q8l2bjlsP
	8Mmwx3lf+PzL1qK9I3qKL2kY/96CnGt49NiMt2vG8WuOX/UU/nmlnxHCC6j/biDw
	OnUFmRCkDd2o8EJD+VDgLiuprCqOe2ipWWrkDFOvmFPZwRggFpiklvMt+jKg8pCp
	D+gFFKTUH5Rb6izZC5T32UVIBEjjZSDEIp+KQhY/OUZ83kAa5l+aew==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46aevtr287-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:51:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIR1Ft035387
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:51:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8ka3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 18:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFO0KAQTCbZkZEiIX+8Oqj3A4akpgAJBFG+aX6H4uRgah3dr0f22HGTdM0yjdxF7UtKbHEFjiAir0I3Zws8EKfNIJP2pC+P5w4eOalYBKkqYTpjCgR6lG7sF+rv1WXlbf7pPgeCQpePwo1qAuu911KO4VI1dRzwQflAkkAyknEdM1a7Tl53u4fK0mXsNIGZzmYa3CJXnxsNMXY3NYvoHyIt0ZO7MZwFRshStZmIwqOhcS3MS7FjZklhRfOcNDKuKksi3qg/8MAmLTGLMOkkN2YZLsRHNimGt3rYWROuP29pqPRu+1ECcWdjp1Qr0R32f1U/ebuZyeJ93QBCUZctJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whYx4azu/gaYy8agveqRwabPgRIiJCQNHjLJ0hCzn9o=;
 b=LS21I9oKOLPVCrGXAOaLYPPwbjbM3Z09dD6TUlWsEBDwFJvpxQ6Zp92a+SPiJBect1QJWqwtsQEBq+UUOa4fxbsIa+QTZx+FCNEpSVyY2bzS+TvOU63C4yBxzWllX67/3Br67OWNZFzWiVlgasCQTKUVmusR96xOjhJGSOjXuPKaImr4plsDzZqHudYutJcfMmGLh4OjQSI9wu2CASKLYJaCFwydMRXy9dvBEq/StcfHHcfwaIeebe366ccebSc7sSxZ0KLWQoZiY5NsNwHwAZ4mQ3kma83YcJanbkVSgwp3i4lJYc+J/GP4he2+qS2DID3rX6l38F+j6X1uyBQEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whYx4azu/gaYy8agveqRwabPgRIiJCQNHjLJ0hCzn9o=;
 b=YjcHo9HTJm9Qyv0isQCwrJuZvqgN2Kog0/cUK5QdjSA6SEgD8NyN1ktJ2fZamSNgFNlXov/v6DL5FYb/4pjgp3FysItacj+97PposWW3LQb1FlbRBa77cvrji04THm0847+iWf7jo0mCyjJNCCb4aIPh0PuhqKuAl6XfYe5mekE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB6759.namprd10.prod.outlook.com (2603:10b6:208:42d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 18:51:46 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 18:51:45 +0000
Message-ID: <707a42f7-09c7-48e7-9b87-4e4dd1dfbde4@oracle.com>
Date: Mon, 28 Apr 2025 14:51:44 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: platform_shutdown crasher reaches LTS v5.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::10) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: c39d7722-0f8b-4e46-9006-08dd8685b98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm1UUEZoTkhZYjYxMThEdXJCNExMRlExYkdaaU5uWnQ5a1NmWWdZVjFEWkxo?=
 =?utf-8?B?WW9BQlN1bHQzUUR1WWM4b05EWlV4bDk4bTBHWFV2dTJLRHpiRTZlVjRhcUU1?=
 =?utf-8?B?OHVpSWNWdGQ5WkFzWGhqUS9STXlMYlltK1E2bHd6TUw4SWJ5bGtxWVRod1Jp?=
 =?utf-8?B?bnpHRStJUVI3Z2RJclZxR3JOVk93TEpqTHVmU3JablREQTEwMExUeENObDZj?=
 =?utf-8?B?YXBLelFSU1pqSVhnSGI0THhjSzNDdjM4ZzJQRkJITWM1Tks0RlplUlZEdlpt?=
 =?utf-8?B?Wm1vWmtLNVF0dyszVVN1Sm1uTHpYQ0R5U1gxRHFOZ3AwRUhaSzRmcUh2aitr?=
 =?utf-8?B?dk5IK2dNdXJoU2tOTzBTK2dHUmZ0YWhubFNGc3krRmFHMWxyTEQzL3pvUm9L?=
 =?utf-8?B?Y2hhcTloMlFBcWNDeGU5N3ZiYmtOWkhmYXZ3cmNyZkUySE1tSFd0NXFSNlIy?=
 =?utf-8?B?V1JFbTZqU0VSbGpCcjd1OS9VRFp5a3RBU2pGYTJIWnNML1BGZlBIdUNvNlhy?=
 =?utf-8?B?dXUzdEJtUDVXTTFXamJMRk50UWJodWdDQjZZVURlNXcxSjVxWUdZNE82Um5r?=
 =?utf-8?B?NnMyb3d5ekhNZkx1K3pkUkJzQitCK0pCK3BGUStyWFRvc0NlNHRtTmgva0h3?=
 =?utf-8?B?cVFxMVYrbTJNMHZQME9ZamtqQVpCUXVCTHZRWDA1ZWpFSzVhN1hvd3AyUDZq?=
 =?utf-8?B?TUdqbm1PR1U1OEVMeEFxQXVmY3NxSzB5clF3ZjR3d1ZHN1V3OXJielEwQ3pQ?=
 =?utf-8?B?UHQvT0pRalVxZ1dZRTYzaFhTK2l5TlJYT2tmVS9MSTAvK0xYWk10N1dzYzhS?=
 =?utf-8?B?dzJPRlhKdXdDU3hpTk45ejRpdXhqa2lyMVBzdVJQamgwa3JxR2NYM2pjU3BO?=
 =?utf-8?B?MkV0VlUzbUNNeXpoMEczMUlnZUxadHFhRUZMZUFyaHVrVG9ta2FjZm16V1dV?=
 =?utf-8?B?d0RFSnFPUmExVldRNGFTVFpyUkdMWHJwZm9QaFNWUDhpM0xwWWVLb2ZsR2NO?=
 =?utf-8?B?cHgwa29Fa0xyTUo1bTZNRzlzQmlzQzE5bFNvbmt4VzBMZzBXcEpvYjVKV0hE?=
 =?utf-8?B?b2lpbWV1Yk9oMmxHTGVyeWZ1ZkR3ZDYxbGZSeUdvR3ZmRlNZTkdaUDFyTER2?=
 =?utf-8?B?OWV1VXNnRExmZSs0ZVQzUkl6bjYxeXhTOW1tWHlvT3pXa1FTK0ROR3FnY2JY?=
 =?utf-8?B?YitLVlRkc1lMcUNEVmNSMkdhM3JGb1VhcFdUUHRFSkdxTmo4dkVSK0Zlb1JC?=
 =?utf-8?B?MHllNVRuaENDc1V0dzRmamJsbzI0eFlTajRmalEra2xQR09MeHcvUmN5WEc4?=
 =?utf-8?B?UTVReU5QWWJGVUU3c0tVa2I5dlM1c1NqeUhramhwZkVBeTM3cFowOGJ3T0dY?=
 =?utf-8?B?b2N6a0FnWXFmV3p4U0tNaGJtTXJZM05aM2N1bGxVUVkyOUNadWRaUDV3OEN0?=
 =?utf-8?B?WmliKzZIMC9MWU1OVVNxTUFQdUY3aHJaV0pZVjJHSDVSQWpVRjlSQ0JMWjJq?=
 =?utf-8?B?cmVyT2tsUERScXhvVjdSMVpvYnc1Smd6LzhON01OeTNzdXZHNUJqNEYreWY4?=
 =?utf-8?B?amdRUklqWHZ4dlB6aGZNVTFyQnFWSS9sVVhoMFN4d2k1QlBMc2wzVjI1SVRp?=
 =?utf-8?B?L05wZXNObm9weFJ6emxDTmFkUjc1di9LVFo4OTc1Zm41cUMwY1VCbE5ob0tR?=
 =?utf-8?B?NHlCSVhMclV4dlZIamx3cVRJdEJRZGFEd0wwb1EwL3E5MUIrU3VuVHRFU1ZX?=
 =?utf-8?B?UU93V0s3MGlYQnR2Nm91UE8yMmVmTkk5RDZWdzVJZmUrd1RaU3JuSEpHNkJ0?=
 =?utf-8?B?Rk50VmFEbW5PSmllaDI5ZmNmaHY4UjJGaHlXVjRqWG5zZk53dEVxdHdROTJm?=
 =?utf-8?B?YU9XdmxOdUd5elRLWTBmQVVhUmptUWpLRWhlMmxyVjY2RW9nT3B2d04zc0Vt?=
 =?utf-8?Q?oGwft2CbjkY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTJtSm8vRWdrUThlOWlXWXFuR3JLK1ZtZVhTS1VNemFRZ2NtN2h6dU41b1M1?=
 =?utf-8?B?VXFsc0Q1M1RXMWVQOU9scGhxRSt3QzVrMVJPZE55d0FGaHdjVG1rRy9PYlAy?=
 =?utf-8?B?OWRXWmNuSjdSN3FrMjBBWFpzaTJzT1hJVTNMcnpjR05TT1JmeHdnSVoyL0Iz?=
 =?utf-8?B?YWhDcHRUVXZDaU1rekdYY2owQUtEZloxVkhBRE13Myt6OUhxVUdJTkY2emgz?=
 =?utf-8?B?Um1zRDZoL2ZRUnhQMllBOWY4MVhNY2R4TFJ6ejIvTm9nNXBsNG84VUpnczJa?=
 =?utf-8?B?N25YZDdWV0FQTHFUdjdUSTdjdnRsbEVSY3U4ZGxuZktGYy9QYmpCR00zRUt2?=
 =?utf-8?B?ZzJOcTU5SGVjQkExWW1HSllXdUVZVWs1NTV0L3hhbXFsbVFwelNieXRnbU93?=
 =?utf-8?B?eUFWVmhHanplbFFCNlVQOGU0OUJsaThrV01iZXBOSitWSjBhZ0xITzg3ZzVF?=
 =?utf-8?B?R0R3YjFvODBvR3ZGMEFqeStxajM4Lzdrb01yY2k4Y0w1R3A3TENBTlpFNWRF?=
 =?utf-8?B?ZXBpSnhSMVNSQVR2QUdMVmVRcSt0RFkyMSt1TDdPUEtKdmJmbVNHYVVkblhH?=
 =?utf-8?B?WFphWjgyZjg1aFYyYUZRVzhSblE4Y2QrM2hNdTlHRGpTaVY1ZDdBNHF4OHls?=
 =?utf-8?B?K1NZUitpeVFNNkMzVXNtUG5oYUYvSFpkUjEvTnhXbHJlcGt2LzFndEk3YjVx?=
 =?utf-8?B?eUYwalA4OG9WeEtHTXhRdWc5dWM4NUFpNjRKS2xCd2M3Mmozb2x4dEo2YnBm?=
 =?utf-8?B?ZXFvR0YrSmUwQ2YzM1hTcHlqeEtRVGJndXVEOUxiTVVDRk5Kd2NibEU4WWtr?=
 =?utf-8?B?Smh1d09qejBRYVpCaGNsbUZMdll3ckZZQjdlY2hudmpEYXh3TjlqR2JSU1M5?=
 =?utf-8?B?dkR4M09QcDNTZGwzdVI0UWpqK1FLR1o2TGlkUm1YMjdZdjlzaHRIYW5LSE9o?=
 =?utf-8?B?c0t6MW83MWZFZDZWMURTL3hGS3REMFduOG1UY3d1M2hHbVNoSStuU0RyTTR4?=
 =?utf-8?B?bEdvemdoSDEzVjZScDR5YURGdzhseml0WFZBa3pOak1lM21TU0h2ODlKNlA1?=
 =?utf-8?B?OFFvUDZmSXc0MGVxNzBLTTRjR0NZNmJtNW5EQ1FpZ0hmMUVwT3NVYVEvcWpY?=
 =?utf-8?B?ektYeEl5emNxaTdwVm80eHJDQURYb1VQTnYzL3hrVUNjdmRaUE9QYUh5Wklx?=
 =?utf-8?B?NDduR2llQng0NmxlU0YzRDdLQWsyblZ4MTluMHc0MDJxZW9JTjVwSHBtUm11?=
 =?utf-8?B?OThZejVKam83VkRFRFZtVzVDa3FKOWFEVXVBWloxT28zang3cnpUaEVCbDFr?=
 =?utf-8?B?M3ppSEtnSFZlbDBGaitwczNIRWZCZktSUjJWazMzb3F0d0s5SksyQmZtZ2ZC?=
 =?utf-8?B?N2RYSnQ1RGphMVAwYWFBVXk5ZVBjQ1BTYjJ2SHordnFZQk1vcVdFWmF3N0ZJ?=
 =?utf-8?B?UmRSd0cxVUg4RW9OV3FaeXVCRElHR29TcXBFQUtOaDErUi80bFdhLzBXdWlL?=
 =?utf-8?B?RldpQm5LdldNTTdMK3VWVEJuT3R1bjJPSG13UUw1U24ydzlONmtNZHJKc0xn?=
 =?utf-8?B?TnJyQU44K2dFbFZiRXFuV1JIb2NYUHg4c09pZGt0RmhvRlgvVG9VSHV6eDZ3?=
 =?utf-8?B?THh3UkdnK1lkb0JCSjY5Q3ZHbURTWHZldldPU2JIZGgvanZSYmFGQXFhdGtB?=
 =?utf-8?B?dVNPOFRVZDBDdG5Hc2R0bFdhZC9QcU9ONko1WnhuRDdjQzRwWk1NTFgzZmZ3?=
 =?utf-8?B?RXpDZjVHK25tdFgvaU9PQVorM0xhSDV6YjVyMkRlRjdWSCtTNVVRN0U2bUhy?=
 =?utf-8?B?ZlRHU043UTA0c2VsYzFFUVdqVDlSOGtQazI2VXFOM2paR2FIZmJPMlBGMURP?=
 =?utf-8?B?Zk1LWWk4MlgwUng0OTBwbFF1VmdveUdzOGVOc2VEUHJWaHdESFFWYXoveWlu?=
 =?utf-8?B?aGo5ZHIycURGNlJYa0FORGpZZXd4SHFWZTRSS0o3MG5lNS9nWEc0blRVekNw?=
 =?utf-8?B?RnhmMHpqeEVYQUNkTEplZnNFWHlNQ3VGZFByZWppUFdqS0h4RXcxMG5PcjRu?=
 =?utf-8?B?YzgvRjlsWTZVSVpiMjZSQng2T2pTcndwN1dFeHdNYUltNFE5U3Npa3JPdmZp?=
 =?utf-8?Q?s64PqbPje/gHiKCEsVqbAWwVP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G5yzdoSOnXyrTmD45WjQ1ztls43TjfWDoyMUNwKSKJKUiuossRvjYF9PA2503AmaZl6D+ll0LRas3TwZxekTsrKU65Dz95nnB6xaBtch7CGagHP27uSYTk0nHzr/XVgYczp6kW9CC+TXUE/fk2uUcNX30rPaaqNKXQMQDdUIgW7PSh5LVC1yeIz8H5Gx8sNcvYHE5rJDZgYqcvc++5al4mmL5PdYmIXGzaO8g5WfjyWGVsxU5l5ynGMH9Fs99szO17QQhzCZ9YUgGe96cgBGhta9Agwm1zzbnKCb7Rvfp/xaVZf8mg/hz4ZoUODTNqRNao241EUGezpikmRE515QyIKEjQye4ZI/2rKZv50augpQaXxy/K/2KR8X4zpbzvN04SqHGfH8IG3Edwr77IHr9iBTwnmdJOdJYnAWiOmVHzhM4/BNyMb+wz846i8ZQZ2n5ChH0o5rVDpdHUvqyeYk2Q7CL/oLhTprWxbGtmb9/fPLcgCZdPlbu5k6PTaO+1Eq1OFzMvnXw5pb1kvEsjYh8U35s9Mz4Q3ojFOTgWCK6q0Ji2ajMNn+rh+3S7k6HhO0Gz+5+tiiau3iQKBaF2U4EiIUyAgSlvJUuHEevbBdTPo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39d7722-0f8b-4e46-9006-08dd8685b98a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 18:51:45.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALW21NNvijH+IXazniZ6OJGVP+4YwEqyaSPsKuPdlvjAJHPrsOQVA+ooXpWNNZwFxdySB+mBfn1CN32JHFlkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=949 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280151
X-Proofpoint-GUID: -XDcGV_zb2pMZcAeaBYsqAvCrZctR8yR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE1MiBTYWx0ZWRfXzE2EEeaG//5r 83nrMaAkRehIAMptLHtEtPYNw44N9QKO6B+8qnz15ajJCEkARpaLMOCRJnLI3BhdbF5QEpxc68A nD9f9YHZEjugcCCsF5M02685v56dDQKZAGHezYlo4z99WrDORETMbD6f/E8+93YFKaSXz5POjsS
 GwS0sjSUR5lFBJxWWkYVfhAAxvYS35YZtQUw1coTf5j5BSbqsWl4rTBnchxudHBEKvmBJpw237g GYNvgbhi+kc9lVWd6IFfC49C1paw55+kDDS2EPBLXHSZfnm+yKs1s6U+3ZIIO2INNNg101VJMER uU4C8qVI34iILEusSWa65cPec9e9uCP8C66kJRfV15Rxhi5JHzYZStYjXQVnZ6/fd4yh4cIAQ+J Neutc4lf
X-Proofpoint-ORIG-GUID: -XDcGV_zb2pMZcAeaBYsqAvCrZctR8yR

Howdy -

My queue/5.10 CI test runners have hit this crash on shutdown:

[   42.547410] RIP: 0010:platform_shutdown+0x9/0x20
[   42.547955] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 e9 35 2c 80 00 c3 cc cc cc
[   42.550016] RSP: 0018:ffffc2ff80013de0 EFLAGS: 00010246
[   42.550630] RAX: 0000000000000000 RBX: ffff9e6805d2ec18 RCX:
0000000000000000
[   42.551444] RDX: 0000000000000001 RSI: ffff9e6805d2ec18 RDI:
ffff9e6805d2ec10
[   42.552263] RBP: ffffffff9be79420 R08: ffff9e6805d2f408 R09:
ffffffff9bc5c698
[   42.553081] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff9e6805d2ec10
[   42.553900] R13: ffff9e6805d2ec90 R14: 00000000fee1dead R15:
0000000000000000
[   42.554717] FS:  00007f05a6960b80(0000) GS:ffff9e6b6fc00000(0000)
knlGS:0000000000000000
[   42.555633] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   42.556291] CR2: ffffffffffffffe8 CR3: 000000010960a006 CR4:
0000000000370ef0
[   42.557105] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[   42.557919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[   42.558733] Call Trace:
[   42.559044]  device_shutdown+0x15b/0x1c0
[   42.559512]  __do_sys_reboot.cold+0x2f/0x5b
[   42.560015]  ? vfs_writev+0x9b/0x110
[   42.560444]  ? do_writev+0x57/0xf0
[   42.560859]  do_syscall_64+0x33/0x40
[   42.561289]  entry_SYSCALL_64_after_hwframe+0x67/0xd1


It's likely due to this recently applied commit:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/5.10&id=09dc7a2708efc8eaa3efcbb1d50b2d8232b41114

Maybe commit 46e85af0cc53 ("driver core: platform: don't oops in
platform_shutdown() on unbound devices") fixes this issue, but I didn't
test it.


-- 
Chuck Lever


