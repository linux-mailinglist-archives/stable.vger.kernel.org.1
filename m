Return-Path: <stable+bounces-111704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03B1A230B0
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D38713A5EA3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F061E5732;
	Thu, 30 Jan 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EHg4VpJ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wUYlSfvK"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3071E285A
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248935; cv=fail; b=CcSbg6I31ivi4jZIZuARw6h9WLuHsuNtPQC53ZjW1qjsKvamOAzmddWPlUCgy0dq058pvNmzpf1tyfzvjMgPtPGszEidcHyvBLpMxiFb2S3PtYKeDSSuFK/zv2N46W8Ii2FMN7An5oAfxEyyHm7GnWEIwCo+dsEKO1IZPBG9LPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248935; c=relaxed/simple;
	bh=lPYrpkNrQv15GWG/LOqZYC7wma75mznTYeCMeonHk8E=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=gemyNU4yV6vnGVF49k28xHIO9myXqprvoovM2Tc830bkB3dFQPyAonlaZ87QV+W4T79F2GQg2Ld7XUUIRdQEu34whQUAB2gfIVLytGIYwH9eqY7Fm3clCm5z3voGns4Lmux1naeLaSJEnghiIkd7XvlnZPRWw4YKiDkDj+cA9JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EHg4VpJ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wUYlSfvK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UEavFJ016705;
	Thu, 30 Jan 2025 14:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=1T5Nwuf7WtqpHWls
	o+7l554ZUq3gigUcxYcKoQ4miN0=; b=EHg4VpJ1HipbsKOsY1NDlIIxFZxaQHHz
	MKDuertDCTRorK7l0oPkp8y7J/Ry4+M/sEFmrj+VTJKiilYBatLqko9VR/zJl6Ff
	Vpp+B3PzUU7PAAtYVQdUAQjdPlSi0ojra9zBRmhxyL84i5dtniQnRbJtflhhUC5I
	LSJBiIMnJhvNKrTwnwgRSn9uIE5C5j3wXjTcfJCga8cK1pXEDLz3x1tk/zemaHEu
	h+4vtzMhr1vtLegnrT4XXRvj8i0rznDOvtgiWzSXKds3cQ/TLhGRoz3UkWK5GmVC
	JTnAq3TsX3oZOgYZb+b37Df7ZaxzBE2L8K2SaGvS3EgskqWHAIB8wA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44gbbcg1ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 14:55:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UD7ESO034141;
	Thu, 30 Jan 2025 14:55:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdb60es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 14:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p474WGQI24Hwac6AtVeLNp+30ZufztqA78MaY94FK2SsYZPBeUF8oX81P+nhZexQmpZrFzsP8DPs0YlYE0QCNbjpMycaccrXlaIHX7tNDqeCRy6YgCvYg19IHgrE0fPFHDZlynnlmfhzy9OMJn8A06ksBMJLz+LXkTWSslQF3z5BnKn5RB7afggUkvtdW/QFms8+7ehB5wiVee5KYUowf20wGXuSOmhVWVoJDSYxtA6TsIL44KCdRw1ePiwSUwmCubCMi0HBvvFelCCZYd8K820RSZ3oAHLP2z9shbiZUYcik9zDWn+Tk4Q4/UNTYvjYoH2nx4853aBjfUEMp3z3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1T5Nwuf7WtqpHWlso+7l554ZUq3gigUcxYcKoQ4miN0=;
 b=Z6Q3IR2DVgeyT0iQiltHVohgaMHfeE9MMrU0bRfq2t6rfDc48xV/ee03qv+w53ViS9JGhHFFx06gHfpDLBDMGxi3NjBY/4z+Tcw0LKZKW00k+ZofBck7P1/OAgwDNQa9iCG1mjou5ZVesmwu+cqem3+Qz4xUQ6L+ie9c73tP93a/JLEAWtAFNSmZIsfUL5wGZSbCmk9kQl6X3OEnJirJ5aGmtHIxsyKQZ1/5YvNcyqWjpUU3B3zF+/Yvd2lr8afHCc/IEF1JiRKXPuAPsfHTVGlpRplTPnvuvsy8x5IF4OMj2g/bCDybTrOESQYjHsSquyv8yWzy0FKLMc6vFoA9Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T5Nwuf7WtqpHWlso+7l554ZUq3gigUcxYcKoQ4miN0=;
 b=wUYlSfvKpIIpbvFBdkzvICpKG47ONWQf419flPn8dOAaHkTR8tc6v9wa6svWzv4XFicnikh1MXO0G5QvCCReC5LWZ4UJS1bvWZGIRSqYZ8o/qACXNqlxlAYx51qo2mGADOYt6aYr5e8VcfrHdyyCZOdYK3VIe/ga6qer/6Vg0E8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6230.namprd10.prod.outlook.com (2603:10b6:8:8d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Thu, 30 Jan 2025 14:55:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.020; Thu, 30 Jan 2025
 14:55:27 +0000
Message-ID: <80e35d0e-1786-4dd2-af77-6b33de80d8f5@oracle.com>
Date: Thu, 30 Jan 2025 09:55:25 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Request to apply 961b4b5e86bf to LTS kernels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::8) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: c29c1198-4d35-4286-19b1-08dd413e21f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUQ5Tk8wWUw0OWg1bFg2WWVRSWQyKzhSVzIreVl1WnFIb3UxRTJxMHJoT2Y4?=
 =?utf-8?B?bkQ1NWUwWVNWbUsvckZWeXVPS2hvVEdhQU1WUlR0ZGNpL1BjdEx5WkxkaXhW?=
 =?utf-8?B?dnV6WGVoOWliZy9PbHJhd2E4VThjZlJiUGtlUmMxMUFzZndtYlNRekVIRWxy?=
 =?utf-8?B?N0UzQ29jOU9reWwzbXdreXhTL3FNRXE5WXhHVkMySkhOOElEb2lYZXovcVlr?=
 =?utf-8?B?NVh0Q0QwQzFjZFZ6blNBZmZiUGd4eXNDUGM2TlFLUkk0QjFKZmVaU3UyTDZ6?=
 =?utf-8?B?QW8zZWNpN2ladXhRNzB3Sy9ZZWRRWnZUVFlObnhxOC8va0RxQUZacnpGaFBI?=
 =?utf-8?B?SUl2Z0pQdFVPUGdqc3NPdWNJeGU0S1R6MVM5SHlVQkx3Z2VUb3owenlDV2R0?=
 =?utf-8?B?cnBya0dPVVk4Ty9TRkJCQkp6ZDZJemVnUUxTbXp2bVN3VUxydTlJZUxTTHIv?=
 =?utf-8?B?bnVkcEsydm9VVThPMDA0RmZaQmlyZDRlYzVPVnNsQkFMTGt6UkxtbDZTVVJC?=
 =?utf-8?B?TVpGWENKaTM0S2VxcU9jOTRGbGdwbjZUUXZvQlExQ2JKZ2NwRUFEcVNJUDFs?=
 =?utf-8?B?SUxnelh1RitjQXkrTlloNzlHSDAwRzdHbVNsQmcxcDNQTlRJZlJOSHN4SUs2?=
 =?utf-8?B?M3VXcW4vdG90a1pwN3FYS3cwZVY2cTRIN2NhcVJGZGtyMVJKZ2xHQ1NNNXNq?=
 =?utf-8?B?R2lzVExxQjBoZ3ExcDlhN3BCWGhoWlR4NG5Vb2x4eUdIRUtiZTgvY1ZtaFBS?=
 =?utf-8?B?UzhjNHNKRFh3Z0RYWE01OTNXaTYzWHZxOWhYMGxkWmJ0QW93YWFpV25GRExP?=
 =?utf-8?B?UHUxV1BRR2NaekNMandQcXgvQXlRYzNpVnd6ZW5ENjYrcHZWOTB1OWJGYUFh?=
 =?utf-8?B?RUFnc3dUZjhsSFozRFdrbEI3eGhMM3JaZzJLeW56dUxZWjFvcGc4RkVWQVEv?=
 =?utf-8?B?NnhvelhDRGZwdlpMZ3MxeHFaWDhFbG9nazUzQXRJdEFMZGlWc1JOVjhVa2pU?=
 =?utf-8?B?L3QvTE9LeitoMkRSc1gwd1hQZjA2OGY3VC9nMVc4dFpVNVoyMis1Q1pwNUo2?=
 =?utf-8?B?ZC8xZnh0ZFVoSGxvVW9PUk5BVGdDMDNPSytWMHprTmd5SHMxMmR4WnJobGk4?=
 =?utf-8?B?VU9kRGZxYjFlSTRMcFhOb3o3d0tVdzJHWmJ3Y2MvRUQ0NG53eFRQZ3BmQjZo?=
 =?utf-8?B?R2VTdHlUVGhGZzhaKytoQjBaNFl3b1BRRzBiNGJDclJTQmE2dlNER29BTUFh?=
 =?utf-8?B?R1lOY2VCbUwrNE04bjRvS21CVUlicytJMCtPRnc2dU1hSDc4bGtnR3NhMERv?=
 =?utf-8?B?aU9qS0w1UlBuanVpUW5ERmtlNWF6b2t2RE5Wc3B2cFNtSUlYb3kyeDBSRnNH?=
 =?utf-8?B?WEEvY0Zpc1NPYk5tUDdxck53VWV0UnYrTEsvZFFvV1VSRnFaT2d1KzZTNWda?=
 =?utf-8?B?bGlBQm56RmF2VmlsOS9LTXVGbXJaOUM0QVdQbVFORlVvaVZxMTl0Vk9aNDJz?=
 =?utf-8?B?YWg1MDRMdHhwaWFRSEpicmZqcnlRMzFESTZhTVF6cDBWclRHMmpzVEVHUnFn?=
 =?utf-8?B?cjBuM1FJak1tWGFrc2FsZnZ5SFVGYXJkMndScU1HRXZaUFBocXNxY09SQUVa?=
 =?utf-8?B?RlZsMDJZRVZESldiQityZndMekE3ajlzdVdtTE0zU2s4L0oxRHpsSUJSOVBI?=
 =?utf-8?B?SG01ZWd6aVB5ME1Ba2ljbzNiTnZvR1Z4dEFXaWMvRDZvVUpRa01mK2k5a09B?=
 =?utf-8?B?OS9vSHh5UXRLQUE0dzVta1o0bSswUTNFcXJTTmtMNlNDUDZBU00zejA4MlQw?=
 =?utf-8?B?cndkMWFXL1BUZ3N6RE56QTFwelBTdVJHOGw1N3pnd0paNVhKOGpITnhjRDZV?=
 =?utf-8?Q?U2LZCwwb6D5Yc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFExWmIwWWQ0NzlORGtmVGJQNHhkekdEUzdxQlBMU214cVdMWlh2Mzkzcldj?=
 =?utf-8?B?QkJQTWtrdnFnNXFFME1hOXo4bW43RldmRUl1b25sdG5IbllEZ0pEeTFwSkly?=
 =?utf-8?B?eTlZdTRIamlUNEIyZm54Skk0RGs5Q1lpSnpVc0hKdldkTE01NDVkOWhlR3pU?=
 =?utf-8?B?SUhLREpiRnNWUk1FMklMdGhQRk5BZDhMY3dYNDZscFZCWUFuUVJaVzQ1SFIz?=
 =?utf-8?B?Rkx2aGlENnpYenZVV1FpK3MzU2ppcXFhSkpKQ2k3QXdKWXBmUWVIZ1YvRVVU?=
 =?utf-8?B?U3pWSWxlNGdhU3IwdE4rKzNLRSs5R0djQVk0V2dLVHJ5ZTVWTnBkRTE2OWt0?=
 =?utf-8?B?L3djZDZ2RWxXNWI5WkRuc1l5Z1BOb1JiRGxSMmprVURhQVVrUkJBNjMrV0h3?=
 =?utf-8?B?OVhna0I1elhtZWpKZys5UHVRak5Hd25VYTZzQ2VhYW01TFhsRkRDTUlLcHR0?=
 =?utf-8?B?RUhNK09GcVNsSjNVLysvZHRBTXljN3llK25YM1ZLZUNDVVYxU0RLN1YzazAx?=
 =?utf-8?B?VHMxanJMSnNPU1Awd3hPVDMyd2pzOWh4T2F6SVZneUtocG85R3BDVjhrUlVW?=
 =?utf-8?B?NXMxV0dVTHpNUVNsU2IyVmFnb1Z1ZmJUL3NmZEJoSklJSlBOY1R3bFdJRXB0?=
 =?utf-8?B?aXZURjBSWnU5NGhLWVVpQmg2L0h1U1g1RjBCSnVSWlZJbUZGVHR0OUkxT0FN?=
 =?utf-8?B?NC9vK2ZWSE5LbXVWNmJvTGhNMnY2Tmh5QjhsaXlpY1B3TFBzbWZXYzBiVFJt?=
 =?utf-8?B?OWlxMXdRY2xmYkIxMEV5RGZkWFpiTElCL2UxSEszQ3d1SDVVZ1pENEUzcHFN?=
 =?utf-8?B?MCtxWHUyVDZMR1Roby9mUGliU0xzYW5IaG00T3Zya1dzVEJLWHJCZXZuZXlN?=
 =?utf-8?B?R1lQYzF6dlM0SnFPdTdPc0xmeDBqSFB2SGU0WGFtVVFhamtQdVNpUXhRSXA3?=
 =?utf-8?B?S29PTWQvSG5GLzFweW1sMlc5RXVrZXZXVWhjdWo4dE9xOGwwSmcvWHZHdmtE?=
 =?utf-8?B?UmR1dlVBYWYvNjhaQVdTVFE5NzVodjlpQ1FpUlJwWDNaZlEyQ0RzRkUzRlpo?=
 =?utf-8?B?TS9lZjdDNlI1RWRXN1U3WVp4THJoQW13RUg3OUZnYml5NWVmZ3VkR3NyS1dp?=
 =?utf-8?B?aDQ2cUlLN0JSS1VIcXpmb1k1Mm1CUzRoOGFVK1FCUU9RUGdvSDJBVU9MWXVR?=
 =?utf-8?B?eEhldHNUMUhyQjZwUUF3K2I1WlNSNlRLNC9FTVJVZWFVVHdTSHdyWldSaTJy?=
 =?utf-8?B?ZXk3c2xoZ05mVUk1YU5zZkNvYzlIZXg2RW9ndkwxZjZ6Um5vOXhESFhMODZQ?=
 =?utf-8?B?YjVQbTBsdW16Tk1EQjFUK1hSYUg2WkpEK3oxVm9zUE9kZWw4YWtKQUQzREd2?=
 =?utf-8?B?VUlGMVNPTkdiNTAzMUxtdHAyRjFCMUhBVkdaWG9MQytRQ24rNDFYeERQWnFy?=
 =?utf-8?B?MkJGaDUvcHBlZFRCQ2NlNURNQXpiMXFXdUVqNytvSzBNcVExU3k2czlDeVhi?=
 =?utf-8?B?ZzdCOCtvbDhFeVpFdjZ2NWhvZ05SeWtJZXduOGIzZkxlUUYyZDZSdHZkd2RE?=
 =?utf-8?B?SzV6aEFaSTVPRld3N3JGTnpTMk54K2JQTDFhQnVDeXlaWHVxb2ZtRFNSYmM4?=
 =?utf-8?B?OEFieGRwci9hN3hTYm5vQkNKNzRab0h0eFNWWTZxbWkxazBsbHIxeDdIZmJi?=
 =?utf-8?B?MWZXRWtCODczL1BCKzloNnh3SVdub2Rhdjhva0pRR0U4TytVMjdPeWRQUVdt?=
 =?utf-8?B?Z2dNSlN0VzJtZEhndDBNcmQraHBKTHhYZnVSaGtVOWt1ZGNEVDBDV0RtdUgr?=
 =?utf-8?B?QWhpUjlnazhGRWpvNXloMStyaTJONjVmN0ZyV2pxRkR3c3g1clhrak91ZlBM?=
 =?utf-8?B?WVAxM3VMWFYrQ3RJekk5SjIzWERubytZdWhzMDRGZlN6VVFNUDdpQVVCU0hP?=
 =?utf-8?B?VFNXOE9GN045a0ttd0hJSzQ1d3Fua2Q3cE5RSjZmdzUwVEpmb3laRUU0ekl3?=
 =?utf-8?B?eGFUME83cTlsSEdVRStsckxTNENBZ3I3ODJjOG5xNFhYL1pxQkRENzZabXQ2?=
 =?utf-8?B?R1VYdm5JYURnS0xLUys5NGVmVG1DSkNBb24vb0hTVWprNlIyaituTHE1bXZT?=
 =?utf-8?B?UXZEaGhyN0xmRWFFMzhUbGJnbVkwZDBZRDVuQzBKQnZaTTFGejkxTjVKVUov?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TH9KVfhwVXVeuqyQ+ICDYdLVXZTP/ATWt78P2GpOEKGmLHV3MrjE0sAJH17TevbyIytcnxtUnFmk/D/qffwnFkYZuIe4dL4wyvIVMnBYsszo3dDPbE4SW95SFL3zij1dMMY7ZIYbNDZxH3um9SlsjOwOeSd4qLqk0NYoFf4VMs8/jJBcsssGsa6+3nWsrLrUKE7+njZ/i1fEtuwXad8m/foDQpM6FiqWp7U992ysb3K/RdAfH5pmnvDYbCtIzqMaMT4ygNbX3aWVdWjbk3yj8C1ZnhHOUXB5u+BktdCnjdffTNmGIERvII5bp8sF97G3irquSoLAx3RS3qpwUOQbRiqXcMFs2GFm5PIJnA8HNbklK9X4OCQxFHxS2TNXTsQHqYCxL0NJR/xjhcWaTWWZI4+YRBst0Q1/L36N8C0I0eTRjDSwoX4C7BCBxhrTM0AKNGSoFp8vCpR5c/o2I1x6A2T24AJhVT7QMbkWBs/Mxk+xJYIizTfnCEFQN93HyR7i5GFPUJNiQPrVbkZNFPxETmrBaUoxADkieRELqznPBIBH/D7ydaT+TYrWz1ipa0qGd48Ozzhja1HfufcqMhSePKiYLwLRDqRWDLZWh1IM4CQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c29c1198-4d35-4286-19b1-08dd413e21f0
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 14:55:27.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfXmwjRLxRpxzgQmtNZGlz5LBGDGcJXBJE5gqFvlV3qB8cmH0UN7uEBXk1jb5ErtuJNk5lzBrKiUjaGfEvUJ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=779 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501300113
X-Proofpoint-GUID: sNOQVTNc2SGswDnvphiIHEWbelgSPSju
X-Proofpoint-ORIG-GUID: sNOQVTNc2SGswDnvphiIHEWbelgSPSju

Hi -

May I request that you apply

  961b4b5e86bf ("NFSD: Reset cb_seq_status after NFS4ERR_DELAY")

to all LTS kernels that don't have it?

I've checked that it applies cleanly to at least v6.1 and run
it through NFSD CI. It should not be a problem to apply it
elsewhere.


-- 
Chuck Lever


