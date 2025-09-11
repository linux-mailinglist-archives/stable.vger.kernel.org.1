Return-Path: <stable+bounces-179284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1710BB53800
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 17:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF6B5A4171
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 15:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9E346A11;
	Thu, 11 Sep 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdlCbxMi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cPUoshhh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABEC343D7A
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605250; cv=fail; b=OYAI7VgPV/LcQufRV+4FeMmXYmoqCHh3tvxAkQlee0cdhpcKUJk9pEMORm1lgU6k+Mz2+r3rrq01/LMFKF6VQuSGeNxO2AotepETetyN3TdUuv8GDZesQ5IDovi3Y6J953/l0hCVT7XtOLPHF0IY4S7810mNZwDY3N4HscyB2b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605250; c=relaxed/simple;
	bh=YgXILpWOmOLJER69r4lZ44QIm8WDPGfQCV/0yPaopzc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tHeSuFFonkqU2iGOKaY3bGeX+KVjLohAJt6lt6eyC7snJFNQqLiNkz0YVD6S6lSqBM1lb8LYc9Sajb8bkVX9eUcGPmgsCrFJq6YLfkLu3/YYtujfbMjGVsxN8GI7fOIFA6pz+N+//VVtn+/xGOp4ZG4n9wFNQ3hmhoWcLfbo0fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JdlCbxMi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cPUoshhh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtkYI019589;
	Thu, 11 Sep 2025 15:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QTNgpAgQ47hHtH4qOq5LbdGKasl8NCuUv54DAK0lOtk=; b=
	JdlCbxMiupcWYAizxpUIe4qr8p1xFupyM1E1sSG/txW+N1/QPQo4t3zHpHQZNsQo
	XiXue9AQAgnon4kW/mSiQTszjRt0YvgGfxTbIsUrzvR5nKySt1KirRvMUlBqr3Ad
	U4fmAGZRIkXS1hELVWksh0Q8tWn3wgMRrorB26fio3kCP86Np0ge+prNXhHM6dUs
	RApn4eYoZcVsLRxsmm8CZ2hQsEYgn54weiTQP/5qH7sdUSVb8wlQKZUvRX6IPjR3
	VVb4enKMCev/HN4OkjUaUluCjqx5OLBZ3E7KlRPSkjXEPRxd1vBluEKrz4a7CyeM
	XyA/aXx+E3taoVKgJZoWZw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shxekt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 15:40:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFXSCN038913;
	Thu, 11 Sep 2025 15:40:33 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcmccd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 15:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5190VFTc2ktNkFOZEHQt5TLn6EuvjiQiREdPr8a78A4fCQ86HpiGvOKug3kHo9NdQ1+KrNkg8c+pMIVFJN4UU0AuwJob0NYXhtsd5VogJCQiaVFESGkbrPG5Xo1hx+WrOr5sgOqcAOwN5cfDHZMrR3c3aULTXdH9iITFbifdfzGqk4pls4D2zNosH4RneJdcXmiOoSVslVWizURVLpfIDOYdspJcIsk0xOxW76xcz6Q9O4sJNyLCDoDjYwSRTiW48av2D74UGTIq3MTNMlGpOQ/YdVfcmTLeCrKMRUij3iCTPRiGCneZf+PTVLkER3yKoK1+wmO9Aab8uGU8zDYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTNgpAgQ47hHtH4qOq5LbdGKasl8NCuUv54DAK0lOtk=;
 b=DqGz3j5r1C7YkotSwv3wwLMvW6sJSRBKTzJdpgPmu325aup43DegEJT84V6ChyoR6GFA1erUXCWW0H7k7m52XzHxHInwwekEnawInaxrscqW1F+XnLBfpJrNYiv2kXETOsEiwLMA9usVT8A/W8mpjtJQ40o3Xp41wUNltZ3BIF7qq74NlqwIXeXJh1PoPd5k9A9KQ6KWOwSJ626aDg+yT+3F4nCovWYiIfAxf/whdUFFmXagBWHrL3plGjJBW9u8+TTM+ZRwQQqbY7CM6cnesTJWjyIIrt3UzEK/zZSfydaUzxr65MAGupNyBHJL27CzJnDo+t4Nt5lzKVV75MDjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTNgpAgQ47hHtH4qOq5LbdGKasl8NCuUv54DAK0lOtk=;
 b=cPUoshhhEVy+OtMJVljFyNz3p4eCQaJXg9vrEwwY6GJGE3EEsZ+AXAdgrzcWpslIzEMI5znDHROq7gbz4NbtGKsGOA86/nyrlM4k2a/53I5XcyYUj0Zs8Sir8clTM6tE16+SCPULNZuywDPt7TBU8/2ahSfBrFoRBu6Av2jNQX8=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CY8PR10MB6562.namprd10.prod.outlook.com (2603:10b6:930:5a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 11 Sep
 2025 15:40:29 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::312:449b:788f:ae0e%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:40:29 +0000
Message-ID: <ddbba881-5c51-464f-a41d-2ea39e0183b3@oracle.com>
Date: Thu, 11 Sep 2025 11:40:26 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5.15.y 1/3] KVM: x86: Move open-coded CPUID leaf
 0x80000021 EAX bit propagation code
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, sashal@kernel.org, bp@alien8.de
References: <20250910002826.3010884-1-boris.ostrovsky@oracle.com>
 <20250910002826.3010884-2-boris.ostrovsky@oracle.com>
 <2025091158-cloak-murky-d3bd@gregkh>
Content-Language: en-US
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <2025091158-cloak-murky-d3bd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::10) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CY8PR10MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 0059f2c1-5c56-43d5-e355-08ddf149890f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djFVWHJ1RVRQbEVHRmR4cDh2MW0ycFhWZUU5b2V0cWFCcHI0YUFLMFlNNGhs?=
 =?utf-8?B?SXYwZ1Zld0VxUXpEbk9PMW8xQXVCZTNSVk5ta3lzcFIvd3ZGV2hiaVdkeGdh?=
 =?utf-8?B?R1VYdnVUMDlQWDR6eHdvaTFpVXpuVmsySGpzNTVQTXVQYTBFb1ptSnloSGN6?=
 =?utf-8?B?TytIK24xK0MweHd0WkR4bWwxNFlYK1ZsaEdLbFNlUGVPYTVVSTFsZUppZlJL?=
 =?utf-8?B?T2NnemYvdUJHaWtXWlAwNUFXYnN5N1F3eWhHN0I3dDVHQlo4TU5iWStic3Er?=
 =?utf-8?B?aS8vNTBQNFpNUWMwTUJxRkRoK2lqT1pnbzloWElQamp6SUMreGsrVExVUFNF?=
 =?utf-8?B?YldmNHN6RVl6NGRWSk5wdWtPV0tlNDg0dEp5TjBTOU1JWUd3eC84OFhGVmhy?=
 =?utf-8?B?SUhDYTNCU1M1ZExyMUR5RFliam43d1d0a0dLU3p3Vm9TckE0c2I4bFBWY2RZ?=
 =?utf-8?B?R0NOVnNHZHJnQUFjd2dXRTZsSjRrRi9vSFVQK0RYWExuLy8yRzZ4MHV2ckM0?=
 =?utf-8?B?ODRVdXVsQ25NdC9RS2drTTlXVWJrdFVycThhTGVJMTR3Snhja0w5cGhOUGRr?=
 =?utf-8?B?YzVMOWJUT05YWm95S3dzVnAvOVhwR0l2S2Y1OUY2OHV5Y0ZXQXZhbjRlbjFK?=
 =?utf-8?B?Q1JraVhZYXRVOTVXRmdPeU5wSjBjQlRmUEZGelFlcUdmY2RNUzVtaE1yeDhy?=
 =?utf-8?B?YTdKWFVIcFR4RUcxd2hma3QxZmRlcldldEhBZGRBdWpWWDY5QWYyTlFkOXQz?=
 =?utf-8?B?NDFnc3hUdytPaFJYMHhERndURXJWcVhQTXFkREN0L2FYTE9uUzE3RHo5aWZL?=
 =?utf-8?B?VXNHOUlYL2FSYmR5VW5QT1YrcWZVUjZ5K0txbGNVdlZ5NmxXNVZwNE05d2M5?=
 =?utf-8?B?UVhITHV6SGZpZ3AxZWFrQ3RIbDM5aW8wdzJROGQ3Y1Rsc2JCdkQ0YmNlSlpU?=
 =?utf-8?B?SS83emFnM3pFbFJHdVFGSlhoaWc0WUVFY05iaVZqcXBkTGlnRXM4ZTl3M1Jz?=
 =?utf-8?B?b2dOOHZLdUx5TUo1bXhmNENzbTFuNkoyU1g3bWJTNXJZamlpNzMyRTcxelRB?=
 =?utf-8?B?RmVwMkNLUlJ0Nm1ZelRQS29XT0JIQU1KZFZ0dDlMMGk1cm9saENidHpsVzM1?=
 =?utf-8?B?UDExdFoxY01DY1RidU9xSlc3bERtMWFZYjZSQlFHTUgzMzVaazlFcGJvQkVN?=
 =?utf-8?B?cWlKNXFrTG5jQTl1eVNwNVIzWmFOY1ZRQVkvVWhMUUNPOGZvaU1YZ2hvWkYv?=
 =?utf-8?B?QVdqQ04rRkh0YmN0N0dISnBBUDhFc2ZSME53emhmdjZjcnVYSjM3a2V6akNh?=
 =?utf-8?B?Qittc3pyQXBTenk3Q0RXdHVBN3REM1ZGdXpiK2ptcHR5dFUxTzYzWFU5WmYy?=
 =?utf-8?B?a25scC9KN2NvSDh1eGQrT1FvM1pvRytFRFdTOXRjWjRLdzBHN01qOGdMVmxV?=
 =?utf-8?B?K1FCQ0xqeWhXdjNoMUdyay9NejZoR2lubjBHUEI0TmFDQW8yWm1POTZ5TFVS?=
 =?utf-8?B?dXNpMGpsazg5dHR4WnB1dGFMSU0yR2RmTTVKYlBFeTUwVk5pNCtsU1NQZ1BO?=
 =?utf-8?B?dTFJYTdlVEpPby9GL0RrYmx2VUc3dWszNkJoTG9hdnBvZkR0UVFwb2xHanBn?=
 =?utf-8?B?RDBDUkxqTU50bDVhVVQ3N05NbG9zNTRZYVdaSU5kMW9NM3Yxa0FaOXpybkIw?=
 =?utf-8?B?STVYY2RzU1BOME0rSTFwWG5kV09kY2U1L3RWWDRCeU1lQ3I5aEd1b1BzWEhp?=
 =?utf-8?B?Zm9pUmNoeWMzUUZJb3hTWEdBSzBlblViRkFpNEJCWUR4OU5MYWVuTUVkUDNt?=
 =?utf-8?B?K2oyb3ZhWVNmQzJaWGdzOUZSdUtFc0IxSHQ1cEtOaE9IM09DS0xxQmxXNk52?=
 =?utf-8?B?a3JBbkhCUEVWYmhLdnp0R3JMNVBMY3h1WFA2Q0c4OWZSYm01SUFSVms3QS9N?=
 =?utf-8?Q?Hyvc/n4EL3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTR6UGNHakkyZUROY3JmU3B4ZDNZNGVPdVkrUDYvQTY4WldaaStHR0FRRHVN?=
 =?utf-8?B?T3ZVamFZem1HajQ0STh6NmZlR0pwSG91WEo4UCtjRjk1SmN0UGRZT3ArRFVV?=
 =?utf-8?B?MUhpY0NQeFFLS3VQVHBqSWZtRTNqZVRZTkNKM3dkM3hrQkxDdTN6UVJrbXpH?=
 =?utf-8?B?QW9UL29Oc3dOKzRJbnVidnBzSHg5cVc5L1hCSUtXaENMV0V1Z2FmVkdTT3Av?=
 =?utf-8?B?eVZiZVlBZ1FOaUl4eFNwckpsbjdwVk5RVm9zRHN5WXBBbGNCN3JpZlF6d2lk?=
 =?utf-8?B?ak54N3p3SnR1dERyVDlPdmhNa015dUNyandlcDN4MlZLL3orVFBIanVZMlpL?=
 =?utf-8?B?d0s2ZFUvQmxFNGxETkllcVAyaklBeEZhbkRzQ3lXZnZtQzFtei9WNmR2Z0lh?=
 =?utf-8?B?bFU4YzNOT0xKRUxTSnJ3OHR4d1kwQXpoQUVvZmVucTI0VlNNcmozQnZhV0Nq?=
 =?utf-8?B?L2ljMWM5aDUyUDBIK2YyTTk5dXdhUWM4MWFYQURBUHExQ2RaSlUvMnQ3TDdy?=
 =?utf-8?B?bmNuVEhMKzdWdWN1WWx2clZEZkZjMmV5VE9PL1BxZS9TVnhwb3B6Q0x5UTRY?=
 =?utf-8?B?MHBCUDRnakJ5N0gyYnFZUVdVMU80cW9pWm5la2Vudno0ck43WXJoQXM3ZGsy?=
 =?utf-8?B?STNSMm9RTTRpcXVJMXdkYWJyNkZGVlFwWjJ4UHB0SzFycmVNaVR0R0ZMU0NO?=
 =?utf-8?B?NXZ0ZlFsaHhoK2JLWlpvQm1FTzZIcHEwSmZHUytJTnRjNkJNMkpubThDdU53?=
 =?utf-8?B?K3VkV3lFN0pqdExWZmZvdm5uWjhMdHFKZThTd0dtM0Q5a0tuZjkxN0FrZ1RV?=
 =?utf-8?B?Nk1oRWpkUzFXUkM5UklWSGxnR2Y3RFZJM21ZZnF1YlN6WFRCdFh5cmkyUlBx?=
 =?utf-8?B?YmFxd0JFTDhITkhYYnpXZENHYlZ6VS9kZ3hwdElveHp4RGpnQVMycEk5Umhz?=
 =?utf-8?B?K0lWeDVGLzMyaGNnSzFuMXJ4enFCcVRYSjV6WEhXRDlUcDRtMU9tbzFybk1w?=
 =?utf-8?B?c3UxVTVLNFRWVlp0UzZnSUl4YmpoRUpwWFJFU3VmeENQRzMrSlhPWUsxMHRX?=
 =?utf-8?B?Q3NsbFNObjA3eEQrSXliMkhPQWphQVpGcy9kc3JQRE1WbW5DWUFmOW91VC91?=
 =?utf-8?B?OStnUzczMzRkMHp5OVpGdzROb0QwKytQaWFqaVIrUld6K0V4aHpnWlRJci9R?=
 =?utf-8?B?OStYVzFZU2RQMkxmaU5mOVd3c2tUdUZLYXVKSXh6ZHhzbk9pWW9NZlFKdEJu?=
 =?utf-8?B?QXVjc1BBQUtnRXlSL3VYSG5iTlArL1djc0RLQlJ3bnBtQXlFWFhibm9iTWhU?=
 =?utf-8?B?Z1M1bXEvMW4vTzJkc0wwVnFrKzJHdy9sL2JweG9DVHloWFhZcGY0emV2NEFn?=
 =?utf-8?B?cmlpVEpMenZ2VlFTTFZaRHVEZWJHNkFSREVRMVN1WkprNFN5bWlmVnBueVk5?=
 =?utf-8?B?WHgvZzJhSWZvK0NSbU9jaFlJUTJzd3BleXNzSytxTTErcDRETTRCZUs3U253?=
 =?utf-8?B?T3VMNDNrTWpvQm12SWtRQ1lBUmMwaWsrV0ZrUXh4MVVudUprUk0rL3pxSnd4?=
 =?utf-8?B?ZldsQ28zdG43enRqM2c3Y0RaVkg0OHFVS2tiNTgwLzBzT0JJcEdTRDd2WUkx?=
 =?utf-8?B?c09qcnFJZDNtTTVTdkc0N0VIVkRYS2pVTGh0eDVhdG0wMGxZaCtZZlJPaGZS?=
 =?utf-8?B?NmhicXRqa21FbVpFVi9va3dWS2hwY21RbzBiRVlQN01Ua0YyVG8xUHVJb0pW?=
 =?utf-8?B?L2NjQWhaN1UxajFaZDVRdkpwTmJpRGM2b2dUdll5UHNRTHRRV0QyZnB5elJ6?=
 =?utf-8?B?dlMweWNFbWtKenUwOHFEVm8zc1ZWN3hnaG1hTTJjQkxSdTZJMXpTZm9HeXIv?=
 =?utf-8?B?djBWeEJaMnhpc1l3ZkRwczBTalp4NnFQa3FLUEJucFNwSmRFTFdPNXdhT1J4?=
 =?utf-8?B?YTl0dHN5dWlSN2M0TUp2TlA5MDNlN3FmbGRHMVd0ZjNabWFDN1V6bmxiV3ZP?=
 =?utf-8?B?V3hoU3JEeG1wdVRsOUxNU0FwWWlYai9lZFFSSFJLd2lhUzZmTmdXcmVEOEl0?=
 =?utf-8?B?SFJHNmNrRmJIQ3dPTzNUdHNQWThxdE9MNXBhVVFhellZTytTV1lsU2tsajZ5?=
 =?utf-8?B?QzFSN0EwNWM5eHVTdmxpVUJsVjh4WUcwUkFTa3hlNVlzSFhpa0V4MkFYbUpT?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HAUXWVoDLK/+y7Ly6yM3wQH7OqhaDBOPv7DiO9/bTUsM0ZJAwheoAsBq9dWzpakjTPMptsCFs5+cunHc4aSP6OU/Sz4GKjqjzcQP8zw0Gje36J2/lb1dVWAZJwfgdEpGqA7+a8EJM6pT1vA6ycrp0nQ/nXrMsbDzcZJ6My+6doXjya+DQrCVHMsI7JgNCUsk/NWH49/XOH+b3U4UKVMP3Uy4dRuDryaYggWBjBVRrNZ8p8n8qH37LOltvg242JB5ES4RBgudvMAyhGN4voZEjkmPL6iokUsaEdXMWjc8iXMlwI9H9hYtJOVE82TbU8SarX722dkaypH8wEc3vdf8PEy9Vtzbn4APvMNP4RHoS4o/ETGMLPA1RwfgodzEnmEuUFbi5iCxNYA8vkKm2+rv0xK5RS40UqgLtnr79AjnZB84ParyUEJoqNop6F8ypoiXHHNNwSGGLjhOijrlOztjfZQKmfPpD39pmecaa6y/alNE/2MA8vHPtR1fE+wZOAW0ig0OOdMVxfGBQgxWbfraRpih+oj/W4kBndkB2Xxtj8dPpkbfgM3x+nKFzbJ8PBhorNtCZhYax9anDxQI6OpCajd5sMnLPdWK+fub5Zq783Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0059f2c1-5c56-43d5-e355-08ddf149890f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:40:29.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbnqekD7z5gEAw6+IE/O2u6O3l+mnhm6gSEA7RxiEaSYe34rtVVsfuONHkLVq1M6Wxv9u9Ki46JNh3qTlzZd/joN12R0gyB/Co7nh/1Qz2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6562
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110138
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c2ed71 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=zd2uoN0lAAAA:8 a=clnl95lqczUkbP4S-psA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX2q7TFRd+CiZ+
 tcZRgtf34gsJ04H2m5NIXV2WoOKUu1MfFqZr8jZKxXxYeJtuZzeQwwx3l3HzLoFXBtlzjKrn1KX
 LoRrWPyJkOcp1dG+GNZiQ0G7QioX61CI3OpbDI1D8u7/5d49WO1DW4stLQceqjMlIo+AL1BK5hk
 ukmiF2ztDsjIa4lUqcZN6Ue6ndfon3Wyp6w76IRDENH/sG1uJFk4c8OBgchOrNKdegB6qN8cJ+A
 ieSBPJgpYhxqTRSOCT/wOJPYhzUL+01u3N2wAlmj8If+CKXH3rG5qscdtVlxDqKylwz8jmO5Ye0
 4NCFc/E0qWNg7qo5U+0O+0Y0kvu8t+C48RhjPVk4MCY9zT/qdsJkkOyTwibHNuq+B7CzlVbqSbK
 24wiOs77qox1qnwOGjdIdbgVU245Rg==
X-Proofpoint-GUID: cVUr7dlPTOvACuvrJN1xf-kj07svNwzV
X-Proofpoint-ORIG-GUID: cVUr7dlPTOvACuvrJN1xf-kj07svNwzV



On 9/11/25 8:33 AM, Greg KH wrote:
> On Tue, Sep 09, 2025 at 08:28:24PM -0400, Boris Ostrovsky wrote:
>> From: Kim Phillips <kim.phillips@amd.com>
>>
>> Commit c35ac8c4bf600ee23bacb20f863aa7830efb23fb upstream
> 
> This isn't in 6.1.y, so backporting it only to 5.15.y feels "odd" and
> will trigger our scripts trying to figure out why.
> 
> Why is only needed here?  Things were fixed differently in 6.1.y, or is
> 6.1.y not affected here?

Hmmm... I think 6.1.y is broken as well, including the need for 
f3f9deccfc68a6b7c8c1cc51e902edba23d309d4 from 6.2.y.

I'll test it.


-boris

