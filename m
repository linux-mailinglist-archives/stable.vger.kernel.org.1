Return-Path: <stable+bounces-95987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4169DFFCF
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E10F28195A
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3A1FCFE6;
	Mon,  2 Dec 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GXf3s/g5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iJ6Jcpo6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470341FCFE5;
	Mon,  2 Dec 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733137850; cv=fail; b=BFx4PgI0TLJv11ll81LNnA3XrUAtWoo0SXJwi18CvdlcSrM+R4pEsDAOATlm4elPesu983ci8QRm//RB/2RHtevPjAEC5fX9AYLSJBB+VDbHv83xB5Z6OcomVSoqqS60iyEBh35Wpv7/e1DAMZl8ggZQ3A58RgU3Dug26vhIJmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733137850; c=relaxed/simple;
	bh=/qBAHE6sJcYJ1V1cPSVpf0gtpNRj2w7FjwvsVSADYrs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bTCgJTMrHBTaHc+9U2APBGayFkPt7hGK2BzwYN3qJybONr3irPTJ5bOlEeSjTKQ3L2lNprf/4VX+oNdPLeDsMFQlRlJEKohi0Ieu4QlHVP2T/9JZLYN3tIAzcHYhzTX+Tghk9UgPsG6+xXooIXEBP5QHnGjFySedEylrjcmsGnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GXf3s/g5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iJ6Jcpo6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26Wx4J008605;
	Mon, 2 Dec 2024 11:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=TJqmjUKQ+6itdz/D
	WQkbiCgbViGDlahEDajQIMAIdQM=; b=GXf3s/g5WA16rrLZh+MtPYULfT2wNKtb
	JxYubLROYz9rJz5vHSFBEasyHzpUXzNKXKYRFsk7IZxjLtuLsshZAVsvnYPp2h2P
	RI/TtlMCJ+jqJ3ozaZyr0fvdCJ49ie+34j4eaaJZNawYjQUVv5r4d5sGBI90swm6
	B04k/0y/GBgm9Rzr5bo+A0mU7d2+D+wSi1mivotWyyTvddevrRULtxokUQL/q6rm
	sUw9URtBjkZJ1wiYYhsQGbh6s2tq1xtwhHu0PrLu0fksoqYWNEJANLMIBONl5i7L
	EHz7jnmxn/8OASdOAk/jmctJ1fG9GRw4L454XVoqvMPEhx0JmJAdkg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9ytkmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 11:10:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B29m0fp038108;
	Mon, 2 Dec 2024 11:10:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s56r6ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 11:10:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/wop2bUTEKzZhROKEWzqQp7/wsBNzzeOY+oV3TNM22oic9JCtXBvEXfVvAIoMI1ihKjteW81KI+GPpTtSVo75rbW9kr8UIcg00aqN2/IKmqRaKRLw2U8oa0ff9uH75UjWJddr21Jno8Ph6x3wKIoQJqv3rk1HcpDagH0nhSlQ99Hsv+ymVsL0iocjIKT//UMtuoUSVsLPdZpumyDmVdIQNEtVst/IhDmchv73cgr4WVZ/KpgWxFYQFWsXDIYfCtqQrhc0c+2GqFtK6pjW42ueDVJ9VHvUNu+OaiVRZsUgDsYRHv0I8OL37/vra87Z/zcvADAyRlFJJBOKkNKw6qUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJqmjUKQ+6itdz/DWQkbiCgbViGDlahEDajQIMAIdQM=;
 b=D9upLMHytvvzSboYZXcXGWP4V0AeSjFLjJa1nAlgb5WD1WQNEHHI/cOvKNJUDbGdjbzemd1txEPbkfcuQNjvz8tRBgX37wVvRiGufFIzRMCnoetogfus+sr7gdAkL0PAEa/lqQJIf8hX8iBG2GNw9ALTAzR7q3vmvSCep66l9kVa9/ucNsdxYpMZrKUd7MYStgoHxGDWKzbxxR1hzWtKSN+n5Z/vIYkk7rgt2TIjmB+yOnAl+ZcU7vcu0L9/41ONsk8BvkYfT1DN5bO/UocVq1ob6PVR0jBZ1uGlP1rfGx7CvGSfNOFNwhZI9iPaQJXmcCf/KfR7whI7MVyAWyS9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJqmjUKQ+6itdz/DWQkbiCgbViGDlahEDajQIMAIdQM=;
 b=iJ6Jcpo6OVGl8bxqLO0rKyjb6VdCvwuxnCouTB8aohB9wWNW2j3D0C3s2i4ZE895plUKBH07Ql0xadnSupRacEBCEiasW1aNDKXwmJD4hfz9evzXgXapLCFmtRP+MR1AjkB1lxd5bLUCITmivGVrEwaoI0JfjtO8RqCZS6Mndq0=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by MN6PR10MB8024.namprd10.prod.outlook.com (2603:10b6:208:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 11:10:42 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 11:10:42 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 5.4.y 0/2] Missing cgroup RCU patches for 5.4.y
Date: Mon,  2 Dec 2024 16:40:22 +0530
Message-ID: <20241202111024.11212-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|MN6PR10MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 119fad87-50ec-42b0-2dbd-08dd12c1f5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmF4WmFTc3pWc2paM3lyTzRBTWRoc3QvanJrUVNYcTZMVFRlSWZJcGhlL1pW?=
 =?utf-8?B?QWpEbzRlZmZuY3o1N3NRc2VCNVhsellFRjk2YzBDeUpNL2t4Q0pxNklwRFVT?=
 =?utf-8?B?OWt3YUZncDIyRGdMRkUyTUFlczJnbjFNWTNtV014NEdVZkRyQk5ka0hyVjl3?=
 =?utf-8?B?VkJUVkRUNU55WHhCSGhqYlpQTEZqblowUjlTdFZIV1ZUN0Rld2pHTGs5SlZJ?=
 =?utf-8?B?N2lRVGs0a2sxektDOU44Z1V3YnNMWElncFFTd1BxRlJ5WnRoa0llVGRzMGs1?=
 =?utf-8?B?aDVNT05LZzdkUnRSNllLYlp2alg3dElOdG84NmtvWXNGN2VxWnFBT0x6Tmdn?=
 =?utf-8?B?M1JBdm5Xa2pHNlVxZXp6NE1RbEg0S0VXMHhUalBtd0trY05neklEbSt2M21K?=
 =?utf-8?B?VzJva1pXWUlrVlNya2VJcms1VHMzbHhXdTREeWlJelFLaFJ6cXZvOUlkUDB4?=
 =?utf-8?B?UmFTUVdvMHFjZHFIenhuN3F6VlNhNjVJTzREazJNZkFWdFpTektzSnQ1cHBR?=
 =?utf-8?B?aHpycmhpSzQ3VVZIdkNhemtKUlpYSndzSi8vNTMrMVA5Skc2NnJhciswLzY4?=
 =?utf-8?B?bkhTRVBFUlQyRHZkZVZISFVZeEhhRzR4VEQ4Mi85RStoWEpnd3RmL28veWRm?=
 =?utf-8?B?S04xeG9vV28vR1A2MGxpNEFjVnpwSCtOYlIzVlFyRUJaQWl6NjlsNkF2VTRS?=
 =?utf-8?B?dnJkNjRPamcxODZRazI5am96QkF5S1FXTHlweDFaK3RITU5Zbm1jMEVOWlRW?=
 =?utf-8?B?dVV4RWJIejNWR1NmcDdIMzRtQzIwVjhRQWlpVUQvdDJOTzdiNm5EbHRtTEpV?=
 =?utf-8?B?dTByc2RoZmtUa1ZROEJ2UTkvRUVGQ3d4UkkxZUdjdnFidC93WTQxekJ3OXFO?=
 =?utf-8?B?YjlsUGQ3ZlZ3YTFXZFVrYkhTaUxlRnByNVc0OXBNZHdSWklDSjJEcTQ1a2Z1?=
 =?utf-8?B?UkFJejhJallUVEc5dmx5N1RES3FYeXdFRU9XdVg0eThvcXcxcXQ3LzN4MTVB?=
 =?utf-8?B?cHRyTGkwanBsMEMvRXFHY3hhazZYeFFnV0JmUzFFSDJjb3pFcGRER29xODE4?=
 =?utf-8?B?WlNKZmN1ZFFHYnRHQWovQnVDV3Y2amViczFVbERwYTFQcUZOd3h4ZUZWY0pm?=
 =?utf-8?B?OHlZaGRPSjFPSlMwcHRBQzVJS0xVWmNMZ3pvRVZFZ3FydDF4WUR6bUNMbW5X?=
 =?utf-8?B?RVJxY0xmdksvbE92YWNKMUR2dW5LU3BDQ09iejVsWGY1N1FyRmxkYUUvU2ht?=
 =?utf-8?B?dHR4SkVrL1F6dDJyYjRianRWL3ZEQ1JMVnVRcCtaTlcyRitrVTg1ekJ4Wndi?=
 =?utf-8?B?UXBTZmlPUm9nRWxGVnFpYno2Z1V2YXU1VTdaNHdkandFOGp5THdrQjg4STYx?=
 =?utf-8?B?YzZxM1lxTWI0TC9DOTdCNVFzSFd3UUtFNDdjUHg4RGV0KzBGYjNMNHNGTUxs?=
 =?utf-8?B?OWlnZk0wcmp5N3JvclJzQU1WTG1TUDMwK2tRNlJLRlhEZmYzWjZFUGo4dnFK?=
 =?utf-8?B?aE1kN3UydXQ1dmJBOWNrZFg3TUoxcFNZb2dxRmFqdHpNN3VxSUVtc0ZGNHJs?=
 =?utf-8?B?b2JpbkRCTldWcjhFQ2tzWTAvSkIrUmRLdE9mMnN1cDdjeDV4RmlaS0NlaGIz?=
 =?utf-8?B?dmsvS2E4aUdZclZPUmtSUGtFaHVrZmxmaE5RREczNnBBV3FLUksyV0I0SUJG?=
 =?utf-8?B?WXBzaUkwRXhoanpmM0kzSFN5cmZUaURHcVEwbVp0dU5IbUpsMk5wVE5IdHpZ?=
 =?utf-8?B?aFpIeWp3cFN5bnBuOTF2dWVaZHUyOGd6c0YrVHZZVjY4ZkdjS0RJNXFGZWZt?=
 =?utf-8?B?ZXhFZFYwem92NzFoZUxndz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGc4Z1dMYkhxaFluTWNCSExPMGRCTlljTmFUUElEZ3huRS83SlIzUmN6T251?=
 =?utf-8?B?a1pNSElQMVpSdlpsZUFyMzY1ZkdCYmpBMWJtUHdSOFJ4dENTY20wZWFLdDg5?=
 =?utf-8?B?Z1lQQ0o5Q2pTS2gzRGRyWitVRVhNdDJhRk5zS2tUSVk3RDhNdnMzV2lzbUE2?=
 =?utf-8?B?bUJkaHdUaThwdXYrUDN1QkJlaUt0UE9DYzhPRXZsZy9ZUEpMRkVPUmg1RnpZ?=
 =?utf-8?B?NmY2Zm02M0ZuQ0Q4a3l5eXJlN2EwNzF5QzJxUlNRNTh6bVowdG9EaStJdUg1?=
 =?utf-8?B?ZXBoaTlzK2xQNEttYmluVmtic0FkRWdFamxiMXFDUitkd3ZsSmlQM0JXWndp?=
 =?utf-8?B?RmRPbWQvakdkcHBFYXBOcWdoVExyTXVUTzhQY3E0aXlFRWVRcEcwcUZBQ1FK?=
 =?utf-8?B?UGdPT3IyWnhLN3BmM1cyaHlVcUtHZWc2VUVmMXBCSVBhWk1CQTh2MW5sQVhE?=
 =?utf-8?B?Nyt2SlF1bS83eHkvdlhlWUlycUZ4d1VyMnpUU0ZNZlNOR0ZuWWNzaG9IaXRQ?=
 =?utf-8?B?Z0R6aDFGWFo0b1Q3UlM2dFdISnRJRUQ5K0h5Zm5ndkI4MGV0VmRBREFhRGVs?=
 =?utf-8?B?Vk1CUTdCUjFtYm5GT0NrNUdWblF3Y0NTeHExS1lnU3VveHVMeWZncmY2MlVG?=
 =?utf-8?B?ZDFXODZUcXRZb3VEL1dqQm5yZVZyS3ZZSGdxemMyQTljY1pwNjIrQVYwbFdT?=
 =?utf-8?B?N2tBa0dXNmJwWWxmcmk5Sk9hYjZONERESkNTaFlVeVY1WWpDOUYzODdmR2x0?=
 =?utf-8?B?Y2k4ZVViVXRPVUJXckNZUFZ6eEF5OG1ZbSsxVmwxZlBVTGNmNTR5UmpnanVu?=
 =?utf-8?B?bVJoZGVqdWNLYUJETjBjWmhnaXQvek9FN1I0bEM4TFVIeUY4OHYyQmxRRlY1?=
 =?utf-8?B?N0xQdCtTWml5eWpOSG1tVFhGUndWYS9IN2RrRTlObWJubHU0d2xNeENpMGxl?=
 =?utf-8?B?MUxMbDVaVUVIbGFNdUxveDBKR1dzZmVJMTVQQW1mVStLcWhDaEJwNVRqOEVq?=
 =?utf-8?B?VGgyNTRmeEQ0OXQ4VXJOMmFudWZUUC9nM2NoTTB1aGpibVRUaklXc09vMlBJ?=
 =?utf-8?B?dFpHVERJQWZvY25RcFFNRks0emtEdVpjQ3V6THFadUNKSGp4UlJuVk9hazVm?=
 =?utf-8?B?VE5wemNJWTNMRmhuejd3blk4R2pOMWFRdnpJQUNGREFya0U3OTN3a0NqVlJa?=
 =?utf-8?B?bmpiSndvNlM2Q1VWdVBQRE1lYVVieTl4blNqUWtxSFdZWGJFWFBsU0N2NmEx?=
 =?utf-8?B?aTdxSDBLd3BRRGNtMWt3a0I3NWgrbGwxZHl4MkJCYm9zbzJwSTIvdVdDdi8x?=
 =?utf-8?B?czZxSnVwOUlYNTVYVW9oekpwR2VrLzR6MGhKUEYzSFpZWHEvcklIUzViK3V2?=
 =?utf-8?B?enVoMlVzRmlWTnMwdVZyTnFzQStPYk95RDdQYXhMOWpCNnF2bkY2L241Zjhy?=
 =?utf-8?B?cmVOR2h0Z3FwZzNWdm1TTnBodURVazYvbnRjUnlXUktDSUhKTmVPMjJpcWZl?=
 =?utf-8?B?d1BhbFVJV3hTejJCQUdubEk1b1NFOUQ5TVFLalhxcUFhUmpReDk2ZERhQXE0?=
 =?utf-8?B?VmxrL3BuWTY0cUNHdmRhV01XdE5wY1ExK2lyNWtoalQ1RDdydGE0Y1VFaG5z?=
 =?utf-8?B?TzVQWGVoRFVHdTR3ZVVkOW51RlJSQlBNMm9RNytjUnVHejRidlRGYlVPR1c5?=
 =?utf-8?B?MGFnSFNOd3NFVVhHMTNSaDgrT2hnNWVHRG1IUHo3dk5Rd24rYmI4QkNvZjVS?=
 =?utf-8?B?TGp3WHVHT1dmY1FEQ1UrcTc5RE1CNndKNjlHNW9kcmtnS2J3NjB2a0hzbm9P?=
 =?utf-8?B?d2VQTHR3K0ZzZWFkVTlNdE9QUlFBN29qbEJRMjUrbHFvVWVHNVpWdUJZSlJZ?=
 =?utf-8?B?ekF3YzgwdXl1VnBqcXdiQXdvTmlHWUVvbmY0Sk1NTHdrSzBuYTZnL3VMOWlr?=
 =?utf-8?B?dXRRaXV6YzhSNWZESTNubGtBNEhrUXhieTZLc2lwTzc5eFJ0Vjg1ZWwwN3Ix?=
 =?utf-8?B?OEdBSWl4YWQ2bEFENHAvR29ySGt1NEgvQjJlU2NmWnlDMVFSMEZ4c1pYZTZ1?=
 =?utf-8?B?NnFidnFRdTdWVklRRlpodVA4bzhBZ3lodGhkN1VOTWQ1V0djRWZ4aEUwdTd6?=
 =?utf-8?B?OWhOOFIybGo4dVRSODY0UFk2bGdEdngrcXlNYnRJYU5sWncxWkhqZ1hkNTND?=
 =?utf-8?Q?tgTfQXbP5i+/JrKU/W/gQ1g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GQfq1MJab0r3Yjl2i5QXTum+UsZ9Rc8rCWJcyJMXz6JTExQE1eq6pHjlReo/utEuL79va1KFkWsDF1M+0pgGDMO7f5HMnBvZTXSPjthXtdhyhazArWAjc75aAOT9RmgTg2VhJUjgP80g1I0m03tIO07/OcRNUII3p2Vg1vtj06jz7PL99n16HhyCpOMfXE+SycSFRFkDVvqgrH7/H65nvnVGhtQTYKmIk8cy+S3VBBD4mboxboHwymJPuyhOB1jrcfQipu2b3Fn0mONDJpIOfRPUNjnjaw5xS/Ax1TSwQW5N2jUe5D/V9goz6lB3KqqIkGCK0emdETEojGKu6L/Tg9NhUYF9Q4jRE+zRscHR1ETWknlIyu6OMLnO5mUzVUXUiZwDigUkT4fGAXpim77OKRJgZ6WHdMZA3ULZY962qVPGECnpOBYtTC/G7AZQsZhlFvssLwCri5LqH9UEiSbVpa/2+V/NZtq73YC7ijVgHtXAWQAIc0PFFac4Ny04I5Ax7xQrlSrjfktSSYlFyO1bK4o2pmirRSFn0ydfNyfuQDsFPeKD7r9OAr4w3XpurPpSY6NYO9jfe8mCMwjHEgLYC9QshSH+NC/G12iFO4VXxzU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119fad87-50ec-42b0-2dbd-08dd12c1f5a8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 11:10:41.9459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/2gUCa4YxCaXwqo0BmjkNi9qst6sA0d5ngNRgMtEGskVAeis5PVBY340123b2MU2C6/ncur69TdcU/ZLFW1iiVFSft0SrripWQaRfDZcrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=782 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020098
X-Proofpoint-GUID: E8JZlaOB5B7Rix7YxsH9fsKvMy1CpZq-
X-Proofpoint-ORIG-GUID: E8JZlaOB5B7Rix7YxsH9fsKvMy1CpZq-

5.4 doesn't have commit backported which introduces RCU for cgroup
root_list, but has a commit fixing a UAF (and thus a CVE) which depends
on it.

Thus, we need to backport the original commits. See thread:
https://lore.kernel.org/all/xr93ikus2nd1.fsf@gthelen-cloudtop.c.googlers.com/

This patch series backports the requisite commits to 5.4.y, which are
picked up from the above mentioned thread.

Thanks,
Siddh

Waiman Long (1):
  cgroup: Move rcu_head up near the top of cgroup_root

Yafang Shao (1):
  cgroup: Make operations on the cgroup root_list RCU safe

 include/linux/cgroup-defs.h     |  7 ++++---
 kernel/cgroup/cgroup-internal.h |  3 ++-
 kernel/cgroup/cgroup.c          | 23 ++++++++++++++++-------
 3 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.45.2


