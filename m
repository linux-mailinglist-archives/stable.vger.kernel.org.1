Return-Path: <stable+bounces-196862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C960EC8360B
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 06:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B98A54E12DD
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 05:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B213C22068D;
	Tue, 25 Nov 2025 05:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDpg3F4L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="owZ52D3a"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13694315C
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764047465; cv=fail; b=i2wqWr2iSdY3qRxRGmBFO5T5HlNboQQSEyro38pTLEsgTR5bCFqyIq0IeiDgwbTVwryjaGDalYF/gSWFTtbqx3cQSYVI1QPaELU76oapyzhIzsDUrDtNMA9danI9cRcYVIrlt7bL/B+h12o7totzQ+2FF0mpY3uT/XL18pbyAnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764047465; c=relaxed/simple;
	bh=MIDNG5ppwUBvRH4981uOhsorejG+wSoV42INqRf+fmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WSVQn0S76kJfdTTBzWZvzgVE3OinO2EnwHaCpy6iBCzUacNmraiDGem2lylGkYGOj6NkphDKFJUDou+6CvE8p/Yp+o8+glbDjA3p8IptxrF1dR3o7KOnJzcGPZHPz4pd/Vm/TWb/HWDUZgmgKeuTfCfWczY0TFHETiw3lUDVxYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZDpg3F4L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=owZ52D3a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP1ChZE2363843;
	Tue, 25 Nov 2025 05:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=vh6f3AfIyZRDZ4rR
	XsyRTfGp8tla/EviJCpKSYsqX3Q=; b=ZDpg3F4LpyODAbKCrK08vOoJT5wKWv5r
	stnwFPhc8+PGJoAd0ZsgLwVlZTmeh/Wa58jjfI8FObU2y/eQJ2Q831gdvWKgmVXE
	dScAgPt+OQTdWm+BIkiIB9duZqkR+/EXkPZ8LKmkujNG9YZNK5Uir7h/snsMyyrQ
	JYls+QYqj2H+3CQmYGVKnpqhEdrFuJiwfbTKQGr51XDTTP/LAe07nXdVmmX+kmfR
	MjU1VeOh/m4Gth8BYdR6SEFSkCBkZnpGm8hsz9jbPH0ubL/LdWg/D+MqxQ5y3j5r
	verDwmOY7tAD5L9fL9macoauorCOqROT8yNlP159j+KK5riYYxCToQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8d2ud86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 05:09:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP4rIeh033705;
	Tue, 25 Nov 2025 05:09:38 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m8ycga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 05:09:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V15vP8fsg8J1I1T2yYz/HhZ1qWfGjZ3aLDYqiui576FQ9hv9q32qFo+jsOLTXqSMj8lEhCapBGlTKOjCuF8IEbHT7mp1rVjUioOavx/pxs5W2X6IedqcYmSsjRHkqbFA78ufkdbYeKkn+hRQgFo4Uk12tBDBJe8GrM1b9El9ghh+XnXTS7BEFmumnBvutdNghhwWX5i1rFcGx5poFfDECcge3wfNCYnxcrHzxH0sGQGu+dR++zpcjc190HyOVFhTz8MpahWgWpyfDlR/itQOq/KPyf/glyCvegkpt5xxTVVb8xh1jwF292XupmpyLx/spHmiTZg85dVSveF5tD9wHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh6f3AfIyZRDZ4rRXsyRTfGp8tla/EviJCpKSYsqX3Q=;
 b=QX8LqF7SB6odeGgBq2KNcJ/VzO4vUAY8yeuaISGvEDJUV4XdQJ/2tyzEwyNibOXEavhazhGp8R1jG99JUUr9a3tSTp2iYkpiXVaGHtmolkfHP9sTVWmCzJ764izXVusjTiqhwXw85t187qhgLH/8syq8FPORyj6Z/9iog9K16Ec9gueQQloeWmN4iT84GTMKqwDu6b41FdWykMZQ4RWXSrknJeIy8e9e91vovTQr2UENUKET38PZFq2QF1Fh3700QWhqieohDqU9WDfj50pKTXZeYJnRdSz2WIWitfORjlpCjzMt7ergqXfJo2+zXCO2g0/XjONTt/EXNB1mj+uSJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vh6f3AfIyZRDZ4rRXsyRTfGp8tla/EviJCpKSYsqX3Q=;
 b=owZ52D3avIH3srD4V2wAv9gFZJBLGBv2DBun0cbLqhbr101XXgpfhtirFY+eYkJKzhdjp6Lc8mbOUDaRLf735H4LRz3DmTiAqls5YNadtpcaYVwg5wfK6/5mcjTUpMr1ns/RUAVXn5f9+hmW09i4SIS2U7mMTO9gX4gswk8V7k8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7460.namprd10.prod.outlook.com (2603:10b6:610:15e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 05:09:35 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 05:09:35 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V1 5.4.y 0/2] Fix bad pmd due to race between change_prot_numa() and THP migration
Date: Tue, 25 Nov 2025 14:09:24 +0900
Message-ID: <20251125050926.1100484-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0126.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b44b83a-db33-4088-f208-08de2be0d34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0Y5MDlpd3MwcGpJaWJqa056dnYzOTB2V3huMkVpdWN0VVFlTnpYcXlSUG9o?=
 =?utf-8?B?cFo4ckVlbEhIUFkvWW4xc2I0UXhwTVZtRXNqa2tNRHd2cmtFbW9vTVg5R3FV?=
 =?utf-8?B?bmJTUXlDTVJ1T1BQVTQ5MG1aWXVuckp4UEhpb09pdFMvMzdIMW9rVWh4bjBZ?=
 =?utf-8?B?aFZmT01uMDIvNmYzWTRhVlgzM0VrVm5jTm1laEVpYU9pa1Rzcm1DQmI3QnRH?=
 =?utf-8?B?Z2cyamNSWmltSHJtSVRpN2NFVUVxR0p3NDZWL0pNYWVwM21jaGk0b2FnQkxm?=
 =?utf-8?B?UmYrbENoRnlVSlRaL2tZUTNPb1d2VEhWRmdrV2FDTmwwQmp4S2tzemttWmFX?=
 =?utf-8?B?alhTSllvKy9vdTRadTFXNExURGhSK2JGSUg0RG9YcUl5Z01teWxTaisrMVkr?=
 =?utf-8?B?bmlyM2k3MkhHaXppN3NTcmJWcUFIbCt0bllvRXIwbWxyNzdzaXI1STM1NHhj?=
 =?utf-8?B?ejB3ZXAzWjhiUksrczFRbkp5d2lpNC9SRlgrbmZNOHVZSTNTU1JOL0k0b2Z6?=
 =?utf-8?B?QXU1SSswMUpmb3lSWmIzVDBWS0pHTFJpNDJpMEJtY1ZidU5SSmdsVU5jbStX?=
 =?utf-8?B?Sll4bys2RFZRbGd0dlJvd0loWUR4c2FkK2JhMS9LZmpraWMwRVFGODNONFVm?=
 =?utf-8?B?QjRhU21RRFdIeGRqZG5qbGNZeHZpaVczeWpRY2ZYSFJxQ3M0SVRHei95L2ZT?=
 =?utf-8?B?eXRNYUhBVGlVSW1rcE9adFFoaWI5UGZWS2V1OUFoT2t3Sk45MjYwaFdWbDNj?=
 =?utf-8?B?U2Y1VUdQS2xaRnFLM3U4dk93eW83bmhlWDlmM0cwbWRTZzc0Y3RGaTBHcDQ1?=
 =?utf-8?B?Mnl0RUtSbUdrYVVQaUtpcTJUa09wZEJRVEV4a0ZMYUJzTnU0OUxoYnJNdE5R?=
 =?utf-8?B?bWovcHRwYWQ1cXJxaTNzOWl1cU4xbE9ZYmtPNmxOeVl3MWwvOU4vbENSb3Ez?=
 =?utf-8?B?S0REZWhDTExsS04yNktVV1VoVmtnRi9KWVRsTitaTDU3S2FJV3VNeWkrMWgv?=
 =?utf-8?B?Q3BSSVVwUXZQNElYTGoyRGVselc0aWhpeTdqekJBcW5hN0V5NS9QWEttVFI2?=
 =?utf-8?B?N0tDdzBLd25mY3pZSEVwd2hRY3dOUU9UY2NkZ01tTjZ4cVVUZEVEOWYybXhw?=
 =?utf-8?B?end6ZnAyYTQvay9INWlzSGl3VGdNTUlGc1ZpbnI4bDNpQlMvZkhFNitGZGJQ?=
 =?utf-8?B?ZjRJdkxUSDdDNUFZOEV1RVYrdzlmaXVhOXAzbGxsT1c2bFR0clZjdXRhTU1D?=
 =?utf-8?B?Yy8yWVYyZHJ6U3N5dU94UWZPZDVpcWN2b1hSYkpDRmFIRzdrYnJBM3lmcUdv?=
 =?utf-8?B?b2thWGNQNmk2TjNzZ1FRU3pXclJ1VnFTVWxGWUVrVVN2MUlBdWZJcUhvRFZR?=
 =?utf-8?B?bG40aTNNUEx2aDZtMU9VMVVnTnZHbFRTSDJVUnZkT3lSUXE0Q0ROUFdXUlBG?=
 =?utf-8?B?TGxLditodUoxeTB4YUxZYXcwUjMySW9rRVA1bkgxZjIrV2liOUpPbXZJdWIv?=
 =?utf-8?B?QjZRYXQxYjhNME9JV1lRc2ZzMTBWeWVzWXptditpMm1mNTAvU20rS2Zwb01L?=
 =?utf-8?B?dGpQNzJ3b0NrY3M5S1FSS3RLVDkyY0NQRlpHdnA3TEhNQ1IrNnJEYkxmNEU0?=
 =?utf-8?B?SWIxeWVzcStoZ2hsM2k1WS9oNFhVU0FSUDA3WXpDb2Y2cWZuYUUyUzJaN1p5?=
 =?utf-8?B?RG5heUtGSDIvZHR2Rmw4aUkyNk1DNlgwdC9GZGFLMzl2ZkpSc3hyUDA2Wkxj?=
 =?utf-8?B?VnRFaCsxcDE1NXFJRDhGd1NhdXpsL3Q2Vm5yR1crVHZDUnFTcFlCZzdORVgr?=
 =?utf-8?B?Zy93QkJyM2pRWFZ6U1YzaWZZTE83eTd5YUlURlZFQTZ1eHFhcGNxYk5UamYv?=
 =?utf-8?B?Um9SMkRBUzBqNEdTeVRLcXhRT2RCQ2lYVGRTbmlUS3JsdjlBRzdMSHlzb1pm?=
 =?utf-8?Q?ZK9jBNWqE+kXHm8w/xif7QCPeJI+eTK+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUpwTyt0OHBaY1RkQUEzNGFhZTdDVkJvNWdDKzNrUHAzcDdUSFRHcXhkdTds?=
 =?utf-8?B?VXZBSm9HSnhBZWNQQVVicW1IUE9PN1hSejBjaldZRFNkWkpCa3pYNHVkQ3Q3?=
 =?utf-8?B?QktHQjIzUlFxK0l3SXJCdVN3bjNlVGdzVEtueDR6QkFPRHE3S0pnOFpRQjA2?=
 =?utf-8?B?Zmdzd3NJY3hCSmgxQVlHek5VL0lQWU1aRUFOcEt3MVVCVnYwYTNqL0pONm1Z?=
 =?utf-8?B?NVJHTU1qTC9lSEdZRmpPYnlwcm5iMVBQMUJkQ3o4dFdoU1ZramNmUUtQTHo2?=
 =?utf-8?B?YzNtWUdtZzRNQnlhUWIyc2hNNTdJLzYyZCsvZGxjVnNwMVlZbGQ2UmcyU3RJ?=
 =?utf-8?B?akRpejFjK01qNU1YVFZEVHBLa3g0Ny9NMHVldWJxOE1hN28yRzNNdGVZa2RJ?=
 =?utf-8?B?MlV3cS8wZjRWdVNJbFErSGJRYWhqaHd4b3h0NEk5eUhVdmJNdm82QzI3Y2pK?=
 =?utf-8?B?NDdCaDhVRGRqb3NOanpEWGI2MzI3TDhUWW5pQUwwazdkY1N1bU5tZnVYUVZu?=
 =?utf-8?B?SXJPU3JOc0MwSTFuaFFvc3Z3Mk1QcHNGR2J4TXgxWXlXOFJLMXJGMzg2eVBn?=
 =?utf-8?B?SHlhWUc0RHNjVkEwcnRDQ0NKV3lLallmYUtnbW5LRXNIUVB1N3YvV2o3a2dS?=
 =?utf-8?B?cmkweWFrNkpKRXV2eGQzUDJMeGUyRWVhSEsrU1BwSjZaeFRzT3dhaWJXVkFp?=
 =?utf-8?B?dWlRM0ZyQjIxUjl1KzYvTWc0c2hIeHgwVTJXQjl5KzFIN2NudytzNVI1WWFB?=
 =?utf-8?B?Y1RxZkF1dGFPRnNFSVpZRlFXWWhNcGFGanRsTm1objF4WldER3lXcWczSVFH?=
 =?utf-8?B?WWI2RzIveVdMa05lNGdZR3ozcm9BaUZTSjQzQWhRRVBwV28vQ2R6UDdlTDdl?=
 =?utf-8?B?WjFHL1FvYXBWdFd2d1F6d0V5dGhGbFlweXFNVGF2WVl4YStKMUQ5LzlRM3lG?=
 =?utf-8?B?emVRY29lQ0l5N1JJcGJPTzR3WWpuTk1lWDhGdmYxQVdnZ2hVT2VlN1hRSWhH?=
 =?utf-8?B?Nis0RWY3UHJRQTBGSW9YOU1uZXQ1SGFKWk1FenVHVkFWV2kzWUJ1VEh3Sm1j?=
 =?utf-8?B?Rjc5aC82M1BvVHNJV2xEYUJMSUxmMWhzQ1JMTUZReUhFYStxUno0V1ZNbFVV?=
 =?utf-8?B?azJLV3FSWGQvd0g3elRUT2ZTZ3dITHg0aGMwT2ZLQnBkWGYvaFZSUCt2TXUw?=
 =?utf-8?B?UUhmQTJESVdrVHpzTWhCQnZzcVVYMTMyeGhOa1hIK0NjRFVZUDZ0cVR4bDFy?=
 =?utf-8?B?VWsxQXRpeVdSdkJUa1kwbVNUNlVlSzVva0JXZzJJdDJ4eXMzZWZDeVdKVkZa?=
 =?utf-8?B?MkVBQllTMmw5WXRUMjBjNmVsQk9KbzY2cEFoUmlncTd4OVNFVFNjMmtTUlFu?=
 =?utf-8?B?TnJGZ05JNmd6U0dJaDFGNnJ5cmtLRWsxTEtRL2JjSUE0Z0tGM1BtKzBOaE5D?=
 =?utf-8?B?R2J0YUZZa2lZYUlUNWNzbVJnSFBRb3lqbXA0cU11SzhROWN0V2xxOXhpMzhO?=
 =?utf-8?B?ZThlNjUxa1B2N1dCenNnNFRxWXFiZDcvaXNtV29rL29CTFF1SjE1dmdVN1d5?=
 =?utf-8?B?M0E0QlhFZDVKK3VsTFEwTXpSZnZpNnpTZDdCcFE3S0hQdmR3U0dCRmRxOGV1?=
 =?utf-8?B?MXhGU0pJaEFBNElsN1ZqcW9pMzBQa2xQL1lqR3B2czlMUXpwLzBEanBObUZv?=
 =?utf-8?B?bktKU0ZrTzJSYlprdE9WWkdxWDNQeFdLVlBNSTVneWxDZVREMlBrWWlmNm1o?=
 =?utf-8?B?RFNJSHdzdUNoaTB6MGRtQVhQT2hlakV3UmFHM2pYUDFGbXJZT3FpdXJ0dUhM?=
 =?utf-8?B?S2NsTk5Fb1JicmJBQkZxTGRsWmlTbUhra0gzSTdwSmNBQmtVdnE4VmZGaCt4?=
 =?utf-8?B?ajZHNWxiMTJPK1dqSmMybGROMitzaGRCWTdDeEZzWlNzZ1FET3RkaDA3QXpL?=
 =?utf-8?B?NmNXeTRDSXFCSmVBZ09ac0xISmpvM2VCMEczTjFkWGYxQ3FxK1FlQlhCdkZV?=
 =?utf-8?B?MDJocXVCVEVmdEVCL05RQmlNN2I2TC9LSUpudUZkNDgxTjBSbUEyWkc4R2ZW?=
 =?utf-8?B?UDVVZmJJTVlhTThUYXk1czYrbzFGbUZSSlg4ZStsMWM5YW5xRWhmbElqZTZt?=
 =?utf-8?Q?ROimLjOSSjQPUbnwR4oPLedqP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V4ubdEfkhklJvkQvIsJ0WC7clh1SmmqXDjzQYVGmeaZRWps9SqHSgtoB11quDz0xeqYb0gzUYst8G+2aPO3S0gCCxTLIK4OzJff6GxSV0PUzsu0Bh3qGcmmmaLJ9od0DSkIXXoWwODfPtOSJBuXY4KPRnnrsrc4Msu6d1wDz9GxX8Nsny2Goe8LOFgObECWAvLcRoKBE9rhLbVnQKbGKIa5pXDQDEKsl6lAedk3us+CwzTX9FMTB7hz+rL+eTKWjT34puWo5cF4O8OnKalGldvTux2BH6gjb47QjTi7kMb6DBQ8n9VWfeG3olSVSc3lEyV0oZrc+PPXCD+6L5mVdxeaGoD8tCTDcInG6Bdc1tQIBJ5B4BSEZ/5GI0RgwzXRbWu2I0Y6v1yk+YzdDspbJXTBsf7zfbgDAoD3NLUiRykempaL1kLXIu8FRxWZEoa+xCuheLdns9tJVMUUI4KV1EmK/v5CPwKoLsF7972UPbLjDhvTiAZTt0MJQmeJLWQ2qs03ee33KFsh9cOIP9wxO1eOEDMRhHUwElWIbb4U2M4maZaj+wkKP9miH9yGrVqhqrbqG8qBtnax+rPbrc4lDuVykkWZX9n0lLgybN/NK2MY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b44b83a-db33-4088-f208-08de2be0d34a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:09:35.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UBYxXgxee4XZsg+Z5ktW0/wKBDTzEcgoaYx2EbT8aHlDseObUIKjlLZt1lDMpAgUjP7ym49PWJWACMvWE97Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_01,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511250040
X-Authority-Analysis: v=2.4 cv=QPJlhwLL c=1 sm=1 tr=0 ts=69253a13 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=S0-RAjllWCc2AOp5NP0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fXpvR6_f91KfrqtXhaD7uL69twMdjGQv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA0MCBTYWx0ZWRfX2zSSgEG+NNb+
 bKqNlg4gRm1T/WKG1TivR8RPS8p7m7Qo+TXXSx59l/ivImJaO7gAuv+2QAdwD3xI0cXKd6wDIQN
 J2YnVDKK52aLKni7WYe59yHY2TlqaKlERkeFjTAigVFqT5DE0EPOfZRTjejyZrTAF3okDBDHfuf
 IoGKzmNmZr8YxaGkzSfQGSrbJKMbSFgISpaPPrCTT82ctsVN0JMjV2TH/bOxrOMKnTR1VX66H+Q
 2zHaqZUnoXlWNl9A9diCfjWIkTPDUwlpAH7HW64i+SF/+4iMVEctruNaGSplRfRYkO706qQ9hUJ
 MEo1x+CVY2U3mEcEi62HUtBZa1ZScPjLUZxLytuX0L+lcZoMFbFQUT9ZOwWbtXUYEy7DvEbN4AI
 YiYhj1hO9xwT1OuDkEbXM/RRj1MiVw==
X-Proofpoint-ORIG-GUID: fXpvR6_f91KfrqtXhaD7uL69twMdjGQv

# TL;DR

previous discussion: https://lore.kernel.org/linux-mm/20250921232709.1608699-1-harry.yoo@oracle.com/

A "bad pmd" error occurs due to race condition between
change_prot_numa() and THP migration. The mainline kernel does not have
this bug as commit 670ddd8cdc fixes the race condition. 6.1.y, 5.15.y,
5.10.y, 5.4.y are affected by this bug. 

Fixing this in -stable kernels is tricky because pte_map_offset_lock()
has different semantics in pre-6.5 and post-6.5 kernels. I am trying to
backport the same mechanism we have in the mainline kernel.

# Testing

I verified that the bug described below is not reproduced anymore
(on a downstream kernel) after applying this patch series. It used to
trigger in few days of intensive numa balancing testing, but it survived
2 weeks with this applied.

# Bug Description

It was reported that a bad pmd is seen when automatic NUMA
balancing is marking page table entries as prot_numa:
    
  [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
  [2437548.235022] Call Trace:
  [2437548.238234]  <TASK>
  [2437548.241060]  dump_stack_lvl+0x46/0x61
  [2437548.245689]  panic+0x106/0x2e5
  [2437548.249497]  pmd_clear_bad+0x3c/0x3c
  [2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
  [2437548.259537]  change_p4d_range+0x156/0x20e
  [2437548.264392]  change_protection_range+0x116/0x1a9
  [2437548.269976]  change_prot_numa+0x15/0x37
  [2437548.274774]  task_numa_work+0x1b8/0x302
  [2437548.279512]  task_work_run+0x62/0x95
  [2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
  [2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
  [2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
  [2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
  [2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b

This is due to a race condition between change_prot_numa() and
THP migration because the kernel doesn't check is_swap_pmd() and
pmd_trans_huge() atomically:

change_prot_numa()                      THP migration
======================================================================
- change_pmd_range()
-> is_swap_pmd() returns false,
meaning it's not a PMD migration
entry.
				  - do_huge_pmd_numa_page()
				  -> migrate_misplaced_page() sets
				     migration entries for the THP.
- change_pmd_range()
-> pmd_none_or_clear_bad_unless_trans_huge()
-> pmd_none() and pmd_trans_huge() returns false
- pmd_none_or_clear_bad_unless_trans_huge()
-> pmd_bad() returns true for the migration entry!

The upstream commit 670ddd8cdcbd ("mm/mprotect: delete
pmd_none_or_clear_bad_unless_trans_huge()") closes this race condition
by checking is_swap_pmd() and pmd_trans_huge() atomically.

# Backporting note

commit a79390f5d6a7 ("mm/mprotect: use long for page accountings and retval")
is backported to return an error code (negative value) in
change_pte_range().

Unlike the mainline, pte_offset_map_lock() does not check if the pmd
entry is a migration entry or a hugepage; acquires PTL unconditionally
instead of returning failure. Therefore, it is necessary to keep the
!is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() checks in
change_pmd_range() before acquiring the PTL.

After acquiring the lock, open-code the semantics of
pte_offset_map_lock() in the mainline kernel; change_pte_range() fails
if the pmd value has changed. This requires adding pmd_old parameter
(pmd_t value that is read before calling the function) to
change_pte_range().

Hugh Dickins (1):
  mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()

Peter Xu (1):
  mm/mprotect: use long for page accountings and retval

 include/linux/hugetlb.h |   4 +-
 include/linux/mm.h      |   2 +-
 mm/hugetlb.c            |   4 +-
 mm/mempolicy.c          |   2 +-
 mm/mprotect.c           | 124 +++++++++++++++++-----------------------
 5 files changed, 60 insertions(+), 76 deletions(-)

-- 
2.43.0


