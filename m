Return-Path: <stable+bounces-205077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CBCCF825C
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6131030188DE
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C75308F30;
	Tue,  6 Jan 2026 11:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SIPyqmDm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gUDL2hmE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247E330DEA4
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700272; cv=fail; b=uqnAFh6hHHSR1/trZcABmvsmQ8Komr5kN1d3sdKTbR6/sxmhJnWyvtcnExI1SL9vf1hbL0YIleYp6a12Eu0wCafFS/Y57r/7zlJo8IxB9Cs+fcl6c/niS9KM6SON083tDBkhECDJGWhPpPHltfvQkoovlO0e3JhGoSBnY7w8HZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700272; c=relaxed/simple;
	bh=orhT+2a2cfHCkjyxFOaEMyiS1K+Fq2KqjwDQ0xMTBCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qOkCy0tCoUX5XyNDmY/Pg1h6wDuQ6lkx8e3LNZ+2HCh9weqSLtsnz3OkfUZbCcosQInpCsdTcHkk32Nk023KxBeN2/0LAt2pXyBlpmkhJ3SCYyle/hPx//FSKKHRociIDnVJIfd3Qz7fWT3/5LOskJIha46w8V3T3ac7s0WKlyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SIPyqmDm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gUDL2hmE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6069Pf2r3543538;
	Tue, 6 Jan 2026 11:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=oe/YG08RkoIrIM2S
	Ygnp16rBvj0bW0MZ0FymGrwKzO0=; b=SIPyqmDmP9KxuuvfiXHb4HxahV2olsui
	PX0wfJmHI4YFsZ344yzM1RWO/tzqxlM2BpmBEj+9wgsmjvq+bXQPgUhj14GVI7si
	nPqQqtBrbacPPHAG/CXlfCvGeUPN3hlJm4GIjTkqUHH5awgb8tWl2KtZPodyJmXO
	Qcwbx2eC9jkYFHdcG2gF0QfLcjOySes9b4EbT5tDMr6tL/pEV2vPUnyRfIWRIImt
	Qhf0fZWipHMkCTas+FkwfRI0k/VErd1B3rUN/X6cUgX4TsOKwHFeZ374yzpGbHG5
	nu6JaMfcp49jie7DyvorpcocI9DQh3bMpqLJOEzD2iG90Gr+mxgYFw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bgyrdr4e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:50:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606BGGFJ027500;
	Tue, 6 Jan 2026 11:50:46 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012062.outbound.protection.outlook.com [40.107.209.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj881mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:50:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nboVAEOy2exUZDXZw0280apnbAuGG70t0oOPfEAISyVaqerO2G2V3uQ/yRHsZXLEUSNCLIKeT7DcjeB4i2yEEogFjd5kbVYE9qkk221lYeAfqjkqKGzKm/fXBQaScdCLqh3PWZv5GGomdhL5sFp6jbcNKFrenDo61iEMHmwC1UAehKbFVGPT4wuHqviyNdlcsoLboXll2HUXW5wGiVrmWEb98VT7AIcqMkVGWkGwicVWnQNFPeLRYdSHgt6h0LGkbcSkjjithSNiOqcVeI74Ed12M+ojdN2dzJlzxe9LmPOIWK3KmUIU6zTjylyViSpuX40SsQ9ydT8qBSyaaUlp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe/YG08RkoIrIM2SYgnp16rBvj0bW0MZ0FymGrwKzO0=;
 b=lbB/wB+TLvaJJEWS9hudCT50wVDfnmg7l1GHBFMbmLZx5GUO0hYTpKeyNVtw4vGoLv9MOcjb+Kfewi4/9lvpVy7OI0gV7Wfg/nT8MHZ60Mu6FKmRrCFatPzn56atfPUe770OXiqPi1qsKKi/duSiXKK6gP8D232JBPOUN3jCKltf6S1s8hGH12nLt67r5iN50ZELovsyLhexDwiHK1RWex+8YlXzz+KGVnK+rY4GqLs+AAGmLLAKA19mUmBISKLpvTp/NWJWt7SNBdEnUFdJKGcq9c9jwHUCrt7iB+GWqmLfVqD1L07mFsvFw1jZ2n89vodMVw7Iafgeq61Ab5qCjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe/YG08RkoIrIM2SYgnp16rBvj0bW0MZ0FymGrwKzO0=;
 b=gUDL2hmESZEQkS+EJ8Ir3hMKhabIZ0GRoPtZqLG3lTCuV84D9Y7QokRoVIbpahU01DNI77E3C8Pgh5YcmSt6ZJhmaYE0yCccd7AsIDuW6If042FB5tAwhHA3NlZ3meO8NZJPJTnqgMyaxaExacIPkeIOrJ6LTwW2i52NDG98R60=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:50:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:50:43 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 5.15.y 0/2] Fix bad pmd due to race between change_prot_numa() and THP migration
Date: Tue,  6 Jan 2026 20:50:34 +0900
Message-ID: <20260106115036.86042-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SEWP216CA0021.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b6::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 8faaad2a-3b79-4191-d4ea-08de4d19d231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NERhUDg2NEI2YXV1VWRtdmFWaTJOZ29YdkJBaC9IQ0t0NXZ6d2hzK2V2VlhK?=
 =?utf-8?B?YWIyQmk5cVluOVJOelQ2TnFSZ2NUZ1YvZVFrNmY5VitQRXBFTmNQZWtpVDEy?=
 =?utf-8?B?cXgxemxreDhQNzgvcVRLd2dXR3lJWHhCUEgwbkJ0RThwUmZpRXJNTUFtYTVD?=
 =?utf-8?B?L01Hb3dzOUJvWERvWm95cWdwUWc0by9ZSmhtMXdFZFI3dWlpTmJ4clJFUlVC?=
 =?utf-8?B?cnhnSnVNOE1ZRkJvdmlqOWZkZFlZM2FLOGlwWDV3dkZTU0NmUkQxeFZCbHo5?=
 =?utf-8?B?WWkrYnBHYzZPSHhpWVhUTjVHeEhXNnAxdnhBNkR6UFRLS0pNeko1cEJ1Tm54?=
 =?utf-8?B?bGRkYzdjcTIrRzNFeTdSM0pPQ045K2ljSzBCSk94R0s2SWYvdFNqYmhJRmpM?=
 =?utf-8?B?RTFhbzVxTjdybXRUa202MW5IYU9kZXFkRjR5WDFWVVU1c3dzSmZieXZKSFdU?=
 =?utf-8?B?ZDlHWG44ODVBZC9GNTM3Vzk5SmEzVldnYURFZ3E2a0pEYmJycG9DSGhrakdR?=
 =?utf-8?B?bnlZUk9iNjRSKytGNlVPdTRKZDYzaU0rb04rVGEvWUNyeFBseFJoTENiVUVH?=
 =?utf-8?B?cUw3QnVJa1lNdmtWNXpla3ZBbS9ZaUIxOEV3dzExRzhXVDU1UGhWUUw5NjM5?=
 =?utf-8?B?cUdTQmJuQ3JHSUIxTHU3anNuZENQbkFyelVSSVBhS0RZTmZ0NUNnblBSNU8w?=
 =?utf-8?B?Z0NRR0Nsd044M01DQWQwQU9uZ0l6N0VjYURkV21JRnpMZUw0SC9YbWpZOVRj?=
 =?utf-8?B?UUpJRklkVWg3UkYvdlByRTk4Um5WbHE2RFVsVjVjSzMvR201NW1QZ1RlV1VC?=
 =?utf-8?B?bXZodllvY1NlSHdvKzF6alpoaUdWM05QS1VkTDZ3Z2dtZFFubXUyWHVNK2l1?=
 =?utf-8?B?bVlxb2tjMDc4WlFYTW0wMzBrVjdBVkJxNGllNWc3TnFGdkFrWHVHanZUNjll?=
 =?utf-8?B?TVZaekFidkdDL1Flc3NiZHM1aVlpeTNiTi9QRkR0WFJMK3JlSW9tKzF6ZTZl?=
 =?utf-8?B?bmdDU2k0T1YwKzQxaHdlb3RSZE94RXBFZXpnUmRwaTJna0FuYlYwN0R2Q0RW?=
 =?utf-8?B?T0hJR2huWHdJU2gwQ3BMREs2KzlzSXFMOFN5TnM4VmFLUStRbGVtNVVYTU5n?=
 =?utf-8?B?dXNFdmNyOWVWb1d5aHVqRHVPZmhaWkJtbngzQ3k1YXZ0TFJFWkxTTDNCUTJr?=
 =?utf-8?B?N0gzU25MVW8rbExUMnhSVWprOGIrd29qYXpDVmJvejlyYjRIMXhSMXJvVWkw?=
 =?utf-8?B?UFd0T3VPY3UxbTFNbWR0dFQzeHZVM1Y3RC9rRC9kak1pRDl4Nkh5dGFrZlU4?=
 =?utf-8?B?Mm9EZDBTdGxkc0hpU3BCVjF2dUhrMnMrWTlGNGN5aWNIMzliMHVwa0FKK0R6?=
 =?utf-8?B?dGdZdlhNODRaVnFDaEppTUlmZyt4aXlrbURieWJ0M3lnUUNUdElBaEZVazFT?=
 =?utf-8?B?ZHZDTEVNdmNuT0Z5UWtXSEthb3A3ZkYwNUoydWowUTVQYU5hV25Dc0Y1YS9C?=
 =?utf-8?B?cFVRR2d2MzJsa3NYMVJKbVdoOC9NZlc5Q3FKQ2M4cnhnODVnUEpjaW9EVUZJ?=
 =?utf-8?B?NGcyemZyc01RUXl3U1ZONkNJRzdZZXlmc1ZyZzZWR20rMXdqTmR0bTc0TjhF?=
 =?utf-8?B?d2xSb1ZUWXhCRzNNM0t5THJtSW42Q1J5MlExVy9xUG1JTDdDQk0vSE1DcE1p?=
 =?utf-8?B?a0FZN3RrZFpCVWhSQ2RtQTBMSEZVWWtIYjVSTmtHUTVUcDBLdDJLOGJaVzRP?=
 =?utf-8?B?dG9qa2UyMzNsQU5Nb1VOMGh1SDNnUEVEM3NhSkFMZUgxeVo2YTdld2U0OTEr?=
 =?utf-8?B?dUdua3ZXT1k1YVR0NS91NU01emhCSGV3NmF2Szk3VWJ3VU5qUXNoTE9iZ1BN?=
 =?utf-8?B?cFpSOVZGQTNWbHdxSXI5aldlcG5KbHhGTm9DRjl0RmY5ajFhQWdsOG5pakpT?=
 =?utf-8?B?cHFUNmxDUjlxNGVJaVRlN05NVVppVEVKVXJkZmtkVk5UcGxOaTZCMUJVRjBV?=
 =?utf-8?B?QTZiMGorMmNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjFKS3F4cGQ4ZWhRTHFHY1FoV1U0andyeVVDcGdWZUIwVXpTOHR6RnJIRVpM?=
 =?utf-8?B?dmFnUkFiemRtYWtJOEZIWUNKS1VVdEV6MUtZUFR5Q2M3QkVYMUYwU0hicEY0?=
 =?utf-8?B?VGZTclFyUHl6a2EvcGdnSnhYUGdZdVlFMEhNZW5hMVU2ZVlmc09vdWc4b3Vq?=
 =?utf-8?B?eUZwSHVaYmN4Ukdoam5EczNHYkxna3J6cXNOeEpscFl4bGN6eWtNRUhCQ0ho?=
 =?utf-8?B?bXU4a0NtbVk4emRoR3BMb0F0d1l2elFkMm5kVFNUb25lZjRndk5HTXpuVDhq?=
 =?utf-8?B?cU13czJqaEtuMWt0N2hJS3drN1Y4SHJUQ05ORGptWXpsYnFzdTFDRHV4TlpE?=
 =?utf-8?B?d2F0dVdFN1A3ZkhpU21pWklYQnRHTHJuc2Rmd2piZHYwL1k3WlJoaHVFRmFo?=
 =?utf-8?B?QzRSWmxDditveFlycitnSmsxc25VeTNKMUxSVUltUFJmNUFETWl3TlVPUE9T?=
 =?utf-8?B?anlxU1h6NTgvRjF4NnRuejBnM29BUlB3aTZOblk1M1ZwNHdRZFA2VkNONThS?=
 =?utf-8?B?UXVqN2R3MDJuVjFBekRGT3pXZW4rSDc4VTg1dzFFdTNEV0ZFN25mc010MHRU?=
 =?utf-8?B?SUx0cFQ1MCtzUGxGQmd3aW1TWkFXdG9NMTZ3YnhHeURMUDROTWN2eGRhL3l5?=
 =?utf-8?B?WUlYTHZ3QjV1M2tlVi9Sa1NCOTlFQjZvWmFwaUZTMWlQSWNCZWpzYnkxQSsw?=
 =?utf-8?B?alB3SHZtdGx1WHZ3eHNhOWsvUlZDOW0wamZpU3lDaW9pcVRISjUzeEtaMjJD?=
 =?utf-8?B?NXNGTTRITUdZNjIvWnBtZ2hMbUs0T2Y0RnU4Vi90MkxxcXRLcmZac2NSVGRK?=
 =?utf-8?B?OS9RaThuMEFVd0h0TGFvL2k0ZkZyOElRakEzVDFkOENham5EdjZka1JVRTVT?=
 =?utf-8?B?eGxpczFZVHd6RnVaamVXUFQ1L2YyWEQ2WTJtQUxtcmJhbDhHRU9Iamh3bmNl?=
 =?utf-8?B?amRDMW5PRUY2QUJsTGw4V2IxMWZnRmZvSjJpUWhCdldCeGZTcjArZEt3eGky?=
 =?utf-8?B?bTJwaERkY0s0V2ZjY3dQTGJvd3lQaWhTRHZjWVhIYUxKaVQ0SjRvSXBsZVV0?=
 =?utf-8?B?SHZiTHR4MHE2UVh1ZXJaTU5MdnNEekhESm1uMFV1cjNUcFhyVVR0VWpGbVdK?=
 =?utf-8?B?Y1NvWDJ4Y0s1N0pKYm9FOGkwM0F5SGhpREpTb2JMVFJEK2U1ci9CeFNzd2Iz?=
 =?utf-8?B?RkpIbUZaSnh3US84RlZvc1NlRVlPcVBCeDhZZFpxVm9BQWJDd2dqU3dzZU50?=
 =?utf-8?B?NkM5UHBNSWk1VmhMcHVRMWRBYUZEKzJjOUl2UTBjVmhreG1qWTQ4bGJ1MGpu?=
 =?utf-8?B?S1hSaDdSV1dtaVdDaDhNc2ZBcWJIRmRpSjVxRzQrSkFoWDFHaHNndGZjSFoy?=
 =?utf-8?B?cHYwM2J6YXZ6WERlZEhMWTBCTFlZcG85SGticU1tanpHb0xENGJnSUpRZHJ6?=
 =?utf-8?B?V1lTc0JvQlAwRm94MlRIS3JwdjBOL3crajgvWWxDQ1ZiWUN3NEQxTlQzY2x3?=
 =?utf-8?B?ZHIzYkEvb2tFMGg0WUh1L2pvM0VLVEtXMVI3dzBNS0VVTGMyb2Z2Z1pYU0xw?=
 =?utf-8?B?K3lMelFqTEFGQVluVXUzR1JRZkpaWDFjU2VYci8rek5sY2hySkhxZHd3TlYy?=
 =?utf-8?B?Z1FrTXljZ09tVWZxTHVuYmt2MEVYdXlIam43T3lWL2gvekZaRXJSTk5YRGlq?=
 =?utf-8?B?Q3E0L3BKZUxBcW5GTzg2UFVvZURabDRwWGhxc3RUWUZDUEhnVDdrZHc2cTR6?=
 =?utf-8?B?NWVCb0lqOXRaaFNwSE1OWWNJSGJsTTlNdGxNV3RyQmRId0Q1M2lOYUN0bUpw?=
 =?utf-8?B?VWQzdWpURDlLZ3dsd0tTczFNSU1vaEI5THNUam9XTWgvSEU0Q213bHJNS2pk?=
 =?utf-8?B?VWdLTmRGUStDS2VMY3NmVHRtV0MxRkU4dTFnOWM1WXJqRGNJMDloN3VnYkEw?=
 =?utf-8?B?eTFXUDRBalhlMjd4QWd0dWk2ekk4VStpQ2psOGNWc1hoVG16RGc0SmhNNEZD?=
 =?utf-8?B?MGNEalV6MWF2bEorU05BcW1jMUlabzk5WEp6UDhoMU9nS2VRc0Mzd0twYmlJ?=
 =?utf-8?B?TjdDVk1GUTFkd2dmS08wZTNWUE1Zem0vRkljNlI5Qitvby9senU3ZVpSdWRp?=
 =?utf-8?B?ZExVcGpSQmVYTmtpYXdrY3dlUTR3R2x3L0Z5azdHZ3Jja2NHWVUwYVdzaVpW?=
 =?utf-8?B?bUtIUVQzbEFzNVdxZ1B5UlRGbExpMUNhS3p5ZkNiUlFWOVBMMXI4TlNpS0Zu?=
 =?utf-8?B?QmRvbTJ1SllUUFIwU1BZdHh3dGtjZVpaTktBbk0vMEZjSGhkZElDdjlSZFJi?=
 =?utf-8?B?RkpsUFp3bllQSURteTU2N0QxK2hwM2pQSGNGcmprVTc5QjR5OVVxZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KIsaDpaHVJFIX6eawoxTeZsBa1A0j9U8jDZFI+2yYzu3w6g1LWy8t1ddAE+ZG+WW6z4P1pXvZA/U1iG6qNrLH0V7mreNKsjDKvzDwvW3WGUlJXBWhCQlrT0gC7HRNvs6sveDXludvMeHiGF8srBTf09w+Vcp2DS3aZuCQ0638PMoWm97DRrn8nr2rhnyUgbUqvoQJEJ7qlTtPUhJorJVa6BKATlNSxGXi92eDXNyVWKKpdLhg9PnUxKrDaezX36b8p2ZNRlZncJ8QlJPzVclNy3LjIwbtYNrS38c2NHF/Ybz3jpTDPtJWqRFgo5os5r+qoXemtcVlGVTlxJhHlZQo1Eqe8b4TbZbTiIWoOn+fg7+FFyDM6rv39hajIMc6gdHLrnytNAkzTGnJJMDPS0RPjTl9U5BsAYLAMjVNT4n88dOr8JT5zEXj62weHyVnA5lgSK6IHkBadssscbkPJapY+Iwi0ZaI5K+s+jlhUaPoLpcI1bkL2omYXOJwYRzz+YSjPuXs7NkpKgaBQou8zMBGDA4qlOh4zQOL9Z2aofO49zstveTDGi7jD91pO+fQ4lmoaCZZcekslWtE6pcPkSbxwAz17Qlb37Tx6XcKanh7zc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faaad2a-3b79-4191-d4ea-08de4d19d231
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:50:43.2316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQuub+pi9MAMMPb/4sEp5+45FFvVQrZhVocuNCGB2hAtOd5s5RPAilKLCvMewQczMvzrF8SP3ipRVp5OplQQHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060102
X-Proofpoint-ORIG-GUID: dSsm0AfQwkI618aW5qlUYEiqoZlYPTYA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwMyBTYWx0ZWRfX7LhxU31v9SZq
 i4x6ljW0miVV1FiRKrOYUvN5yYIniNGK3IVrbGji4J3/4FjcFubnXYOjkz8X6JkkelcyqKl9/97
 vWlbTxHqhqqTjiklwwVXOrgLppI8SIIb/bzA3vPRyPJmO480adQdUtQPKwr2tU8FLwSf3x+Hd7I
 jNhE8UHRU1THz+uzQmSTkqESKJhVxf0TuzaaiFKt2vVsycSxCAQxhU31AdYI/7F9ksNEjCEyrI2
 Qlb3UnJYzprz3jNJRonpGJFYdodkukEmzztjGmD++sK3Q2BC3V3dhy3aHw0uUw4S/PWIWve5YnS
 sSmwx9HwgU4ubEjn3xHwsZBBhcDyvfkUQGNL/Vt2gQAxutDnqhRe7+PBz0xAmqEEvhOhYuGs73R
 N+cFlugaajgaI/caCc+9yi8VcwCXppDsvRpInAs0yuWFoA19qmK9Ty5zjR3mnOMsKwhUlUfqOXL
 8us7bp4bjUo5MoKvr/g==
X-Authority-Analysis: v=2.4 cv=E9XAZKdl c=1 sm=1 tr=0 ts=695cf717 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=tRLCnyKIFssYOeyxpVgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dSsm0AfQwkI618aW5qlUYEiqoZlYPTYA

V1 -> V2:
  - Because `pmd_val` variable broke ppc builds due to its name,
    renamed it to `_pmd`. see [1].
    [1] https://lore.kernel.org/stable/aS7lPZPYuChOTdXU@hyeyoo

  - Added David Hildenbrand's Acked-by [2], thanks a lot!
    [2] https://lore.kernel.org/linux-mm/ac8d7137-3819-4a75-9dd3-fb3d2259ebe4@kernel.org/

# TL;DR

previous discussion: https://lore.kernel.org/linux-mm/20250921232709.1608699-1-harry.yoo@oracle.com/

A "bad pmd" error occurs due to race condition between
change_prot_numa() and THP migration. The mainline kernel does not have
this bug as commit 670ddd8cdc fixes the race condition. 6.1.y, 5.15.y,
5.10.y, 5.4.y are affected by this bug. 

Fixing this in -stable kernels is tricky because pte_map_offset_lock()
has different semantics in pre-6.5 and post-6.5 kernels. I am trying to
backport the same mechanism we have in the mainline kernel.
Since the code looks bit different due to different semantics of
pte_map_offset_lock(), it'd be best to get this reviewed by MM folks.

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
 mm/mprotect.c           | 121 ++++++++++++++++++----------------------
 5 files changed, 59 insertions(+), 74 deletions(-)

-- 
2.43.0


