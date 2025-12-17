Return-Path: <stable+bounces-202810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C1DCC7AA9
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB763091A21
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0CD3358C7;
	Wed, 17 Dec 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="S62q5Xzb";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xTQ62R5D"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901AD30E847;
	Wed, 17 Dec 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975026; cv=fail; b=X/8s30jxlwhBw0s06hiKiRTKcn+SC3Pnr4c/L71QVAwcsi6qMUrH749GbOlWYd/QhPBlEZsdwgcO1R6Lnjr74QSNTDTGyRjmZRBAuqKiltHoOlINHfNWrWzjNC2NhIXxwOx7QW5izVmcKf2FOYql0cxggMRluV/eWZ6AvsbKyyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975026; c=relaxed/simple;
	bh=od4TwteQ4asi9xtY5nX5unVATM6nfSQ4Y4z70aBBn78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oGoy3BtpooOgj39+vkzjU/3UQTfJW5FprEhCjFL/Eq+JFt+c+zN0+vtK5jIhSUfoONG7SI3OIwz7nP//hMGE2GLbm8b65JNx0OuHqSDauawRxVajSc5PnD3zJr8DOtqZS/ddz9u7bWbeXn3DNwisZ+5sRb9hXCDkSWbL+vMuBZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=S62q5Xzb; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xTQ62R5D; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH4XhCq933664;
	Wed, 17 Dec 2025 06:36:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0rrV3PrTXc9gpMFda7/CZhM/vb08mM6cvhTj51nx1u0=; b=
	S62q5XzbHRrCVc8pQnAdFGS2skhjoYHu7e5HGh0p6n5f9DJdOYL0u+k3pL3DJB6k
	QaBQzboKXdIYBdIyFcL09haKu+DjpLvilaCoQ4EZcjNRJ9Na2eZWPCCZI9aF/mYP
	tVT3alzz9W2BvMfZ1wI8U0/kFYXkJUfebs4+4WJfpQwV9rEHxcqsqhzjKKkw7Fou
	033rRzvAsVR8LNY+5s5KuHiIzSTiuY7PHSB+CJBhbpocO/iWfgtIPgVQ9XHb3gZy
	mrXNe3cHLlVqzq67cn6hVIQdzgL1CpTC8JLcaxAdga3Wa4DOweF4Mq8RI6ViwPs8
	10qkFisC8F627KSuwe21EQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020140.outbound.protection.outlook.com [52.101.46.140])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4b16e1vpsm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 06:36:45 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4c+FOjUjM3MTYBSwmByaXeIxJJUPHfYSgQMMAuJOkiCr5Oog0WZuSjltFmOZRZ0ZT76ul1PSb/i9Oa3jLclmRKe5jPUtr8mbInvD1ju6O1zAzZ5YSn1fcc2+EcGFDNIL18GLQ37GxjyWrPXtOzJutTb4imqv5KKySyo0gYC86VIxQnhyNyNsaec/uKMMa16/RUQC+6Xa3kRvfL7GwmKn1zJns43NQqV173ENyVSI8UBJ/YPg0NViXimju74EOBxyNdS/CEE6sm1PXc5VzlY5j3xjkuZnkI8n6JHfVA8ED9O4EShz8bkMTa8j3y8LfPpQFVXMtnem2a0bSvwaS5qxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rrV3PrTXc9gpMFda7/CZhM/vb08mM6cvhTj51nx1u0=;
 b=AVBJjg7hlomtFspSfd03pmQIRr6N4geaJZ/ipuPXThJN4ILFMZbP/7RwwFxJtgHX93Qr5qGEZmIiv3qyMNm8UDaQTVCTe/y6rXFcNI+IYgArhrQEPTMB34bkJj73fgEPtodV5r4lbZ8hjVIYCYyBR7TOiy41NZEvgNzJLKBtG5PwIV8BUAqCorJltTg8sDA1IFbUGQIjWO68VPglE3Y3SjZecrF1bRskA/xLWX0WF/QJJcRL8wu02PysVlGPOoLjVMAAAW/aguW60rEvq9Ex1cfMQpDap0TUYhiGOe1VPeOew28LbxXTWku67D8aJyT1F6K09QifkTvSo6Rv6QRI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rrV3PrTXc9gpMFda7/CZhM/vb08mM6cvhTj51nx1u0=;
 b=xTQ62R5D8vZpYuflZjZ+OvLTiomWb/e9lsDoLUwuCHvEP4PE909pBJBoKwT3e7jLbMAURsoi7lzELPgqfhDemQ7YRiSucIqsWmvTjvP7qAAcYqOhN09AgjxINj29fPlgrA4ARl2VzCpXViXq/wOzgk0TdEktiuVUvQ7e31a9NgM=
Received: from MN2PR15CA0002.namprd15.prod.outlook.com (2603:10b6:208:1b4::15)
 by DS7PR19MB8853.namprd19.prod.outlook.com (2603:10b6:8:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 12:36:41 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::b0) by MN2PR15CA0002.outlook.office365.com
 (2603:10b6:208:1b4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 12:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.0
 via Frontend Transport; Wed, 17 Dec 2025 12:36:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 64C8D406540;
	Wed, 17 Dec 2025 12:36:39 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 58FB6820247;
	Wed, 17 Dec 2025 12:36:39 +0000 (UTC)
Message-ID: <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
Date: Wed, 17 Dec 2025 12:36:39 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
        stable@vger.kernel.org, niranjan.hy@ti.com,
        ckeepax@opensource.cirrus.com, sbinding@opensource.cirrus.com
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS7PR19MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b07fb2d-eb82-47ac-9a09-08de3d68edf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|61400799027|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmpiWUJLVncwQ2ZKb0dXQStqQ3BpaGh1djVPL29jNVJZWm1DTWlqMEJ6R0dS?=
 =?utf-8?B?WjI2c2NkMlpBY0cyMjJEa1QvWFR3cnlaVFpFQ0pGRHNvMEZNa3BhLzNqTWNT?=
 =?utf-8?B?MnMrOHVzMlkwY2ptYlgxN3IxdExNNkxpZ3BYRkQ1QmxsZ3BsV0g5UHdtc2ZH?=
 =?utf-8?B?R0NsWmRyOWVHNENUQnZWSjZBVHBzQ3RsMXZia09TbWk4NWRBRXdHQjc3WjhY?=
 =?utf-8?B?VXhSbEcxaXhOT1N6T0dpUUhxU2NHN2FiRVhsM29kNEFubm5zUEliL2w1aklt?=
 =?utf-8?B?RkJtQk5YNnZCaFl6K2JTdE16WjdmVFNMamdTeUNHc1dKQjlZR21KVkh0Lzgz?=
 =?utf-8?B?eXgzL0dRRHBBczc0RWFVMDRLUU9PbDFmeFNGSHNXanB4MHoreTJxSGlCK2Mr?=
 =?utf-8?B?bkgwU0hiSkpiejJVbnhJQWhjV0Uyd0Y1MXdGL0JFZzArcWhuU2cxYXpaQnN5?=
 =?utf-8?B?cE44R1JvSzE1VkVwKy8xVkRnQktoNVMrREtSY3N5N2FHRDV0dUxqNlJWTWJR?=
 =?utf-8?B?R3VhZ3doZzl3OFBmY2pTamdmNzdEek1FL2ZWdjhhWmFlRUFZQlhDNEFWY2c2?=
 =?utf-8?B?ekgyeGhheWNVbTh5dkVhUWJ3dmxNcUNlc3hLZE95cjV3NFNGQWlHNmJsN3Jo?=
 =?utf-8?B?SlNwRGJJL2FNNUlNb0JzMWZXQkc5M0lKZVArWmExVzYwbXBpZ2c5Y0p3dCs1?=
 =?utf-8?B?ZGs0ck1ncjhzdTkyZmtiak00a094bjNlS21HbVh5eklNNHlFVmNrYzljL25E?=
 =?utf-8?B?c3E0MEd0S0dNdkp4Q3NhR0lqTERkY01ydldFWmlLQW9kbDhabUh0MHIwQUFS?=
 =?utf-8?B?dGh6a1kwdVpqTVQxTFBaOG9MamM4RnFKazQrTUZTajdMYlRSOUlraUFXd1hm?=
 =?utf-8?B?dU9rb3lnT3VHVm5YeWlmN2ZuMlhlaDVRWlREZGJ2V3k3Q2F4bERwQ05TS25h?=
 =?utf-8?B?QVFaVVJMRW9xM0FVWVdDR3VYWlBPNkFqbEJZNlhRRGlvZjVRTU16bTRacXhS?=
 =?utf-8?B?TmJIWXgxMHpvZlUrN1hsNzZYbHdiNTFUaWNWRG8rQ1NhVDFaL2VOMHR0RDU0?=
 =?utf-8?B?SkJjQVZ4QnV3SkhtYldxS3puRjhWVDBQd1dnSG02WkRCcGVMTytoZFlGMXBK?=
 =?utf-8?B?NTBlMUZkbVNsalBGbjU3S3pJSmdkaUw1R2FtZkhNb1ZEaEFXZTdXV3FRTk04?=
 =?utf-8?B?SVF0WTd4blAwTTNMQ2g5bEFwMDJSQTU3TTlJMkhRTmc2clRFRlozcVR2UVJ1?=
 =?utf-8?B?RitqVzloM3RJTEJUOCtzcnhWSW9Gc1U5bll2WGtDb1JUVy9LOXJ1a01RNmtm?=
 =?utf-8?B?OGZCSGVKYnJFMG1ad3Q4VFFEME1DUE9Oc1BqUVhlU1UzdzhWR0JseFhvTmZs?=
 =?utf-8?B?Q3I0Z0E0emN1ZFN4SDI2WnRqQ0lwU01iMmd5STVRV2FwTDQxS0kydHRPR244?=
 =?utf-8?B?bG1vTG9ZbEJWOXh1WkVrSEJrdXZ1VElnOUsrMFBWamV0T3RPU2FBZkIyb0Fv?=
 =?utf-8?B?U3MxZDFGcFRVTUpKZ2N5UjJQTVgwQ2pNeENGNk5wckV1MjZjRVBEbE9Id2d0?=
 =?utf-8?B?M2krSjZDZ0ROeWMraTRvL0lmdUQ0dlo4VkwxODQyRUhERXZaa0hjSVYvVHoz?=
 =?utf-8?B?MWE2SUgxdjE2V294MU8zeHZDM0xacHdzRUJxejFSZEhVVE9Xc0x1SHJmcjJo?=
 =?utf-8?B?VGdyQXVma1lvc0hjV1kvYm9ldTNORjJNR1IyZU1xOTk4cnF1dFcwRlcwaU5O?=
 =?utf-8?B?Wjl2cE5lZnBqaGVId0d3Q0cySGtpNDEvV0VrQmNkb2pHc2lIVmM4YnBvMUhZ?=
 =?utf-8?B?djEyZjg4ZENPdEcwYmlUWWpEUktjRVVZTXZxRHJRamZYSXVsU0JhMXR1WGlI?=
 =?utf-8?B?dTNsWEZGVTduYzRLU0Y4ZG9GeWVKcGEya2VLWUtrWXFOT1hRWVIxUTRITXMy?=
 =?utf-8?B?M09oUDFMOGJvbEJuM2gwOWdlcS9idG41U1I2ZlFKZlVJVXV2U0liaTFPNlJv?=
 =?utf-8?B?d2o5S2ljNzZrSUthaDZtM1BielJVV3ZVdW1iZ2hlTEMrWlUwMEtZNTMxL0dS?=
 =?utf-8?B?QU1LZUNtejNtVjl6RnVEVmVpcW5CZ3cvUHhOaDJHZmhudExPYkJneGUwdWc4?=
 =?utf-8?Q?q4WU=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(61400799027)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 12:36:40.9118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b07fb2d-eb82-47ac-9a09-08de3d68edf4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB8853
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDA5NyBTYWx0ZWRfX4g+YzJ2ogoRz
 4Tdkx6OjbJttkcSacub0gitcANmfDt6pdbYvhTVRRHYh4/G4vS2s/Uqe0heviaYx5ZsG2KYdcqr
 1qMBKOrjYF1be4VEpGOADzv+DUMiVjMcHGQO0SiuqCbinqE5i6WZeZGEKhO9KZ/aDmdNV9xDc6U
 s3EaME/uSxoE2nIqH4oJfR8hW3O6CTJTDsAv7tOvqP05BaET1mam2BPyC7NWuOv1zWbWFNn3zuw
 moJBd2czhLjtVO7O7zjAo0fi4VpuvP/Jz3EhNLrEnpJn6CScYqwmxRQDFjr5fm+eD8+tcyYQvac
 UcLlbZUarM8rG/8qVF4A4vfOdd4hhwlWn/PD/LB9dGGdhphHDZzUiA/+i/xVwuccoo2IzLugZUD
 TfEB5mHHOzQpyxg0svOwYpBhm+Kszw==
X-Proofpoint-ORIG-GUID: Cwd6r1H42CySKYjzN66nPc1FDb_2Ip6w
X-Authority-Analysis: v=2.4 cv=Qdprf8bv c=1 sm=1 tr=0 ts=6942a3dd cx=c_pps
 a=5/KMVI1Vldy4iaYcMZAHcw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8
 a=dEfZe-9WOU64xMgf_CUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Cwd6r1H42CySKYjzN66nPc1FDb_2Ip6w
X-Proofpoint-Spam-Reason: safe

On 17/12/2025 12:20 pm, Péter Ujfalusi wrote:
> 
> 
> On 17/12/2025 14:16, Mark Brown wrote:
>> On Wed, Dec 17, 2025 at 02:06:23PM +0200, Peter Ujfalusi wrote:
>>> In 'normal' controls the mc->min is the minimum value the register can
>>> have, the mc->max is the maximum (the steps between are max - min).
>>
>> Have you seen:
>>
>>    https://lore.kernel.org/r/20251216134938.788625-1-sbinding@opensource.cirrus.com
> 
> No, I tried to look for possible fixes for this, but have not found it.
> 
> I think my one liner is a bit simpler with the same result, but I'll let
> people decide which is better (and test on Cirrus side)
> 
Does it pass the kunit tests for SX controls?
The ASoC kunit tests have specific tests for SX controls.
The original patch failed those tests, but it was merged anyway.

