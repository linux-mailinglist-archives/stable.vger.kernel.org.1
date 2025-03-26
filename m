Return-Path: <stable+bounces-126657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B8BA70E92
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 02:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB971717E7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D57EEC3;
	Wed, 26 Mar 2025 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fREyI0mW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N8R7ngBv"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4B2BB13
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 01:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953573; cv=fail; b=WXG0Ki61xNhfQZMuhcFHVROzZU7aYCUi+GBgIG+s9i94weQM/caIjGsRYYu9Z+BGh8egeQuyjj7IvsnrJ82VoFr+uM3lyk/Qe3XKzGsQ+NU4WszNSKS2147+fu2+02Z/qokLhoxYZTljHnAIGw+6nxMdGRtPwFljnuTHU0oSXHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953573; c=relaxed/simple;
	bh=W9LRLyyfxnlpyYwkXTiSrjJg2AGtmuDdGmdM2YjTeW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5sE9YAM1EnZf+we2HVirfgo01Zxf2lsMJIJG2UgBLOP7t73MCpD873yEtOC/GrcluUs/t/k8VFB61cLGXpGYHanqhd6/DApwuq2qmsvtVFGP4j8d5qHadrwGRuOiLhS/hNLQ66Oioz3v3u/a0Q1RJVBh6a2EJfxfybHlnbP8Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fREyI0mW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N8R7ngBv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLtv9H032309;
	Wed, 26 Mar 2025 01:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6fSFj4reVlNWPjGaR9votuPwwZCw+UzuUpmGZO78N8k=; b=
	fREyI0mWnhbSkv/5auUJIIQUYPJvlN8PzVM6olrDFK87JHkQ+PYCPmpnXqkgXdZT
	jpQIwKdt83MmKF0+kXJ7AR7s12oJEbJ+G8khV0HYVkhADgG7u+e/2je4yEAjX2Vr
	PUld5erRA6dRwq1ZqQZbD72lIVPzobgwHJLlDQ3gqjlQrJ63ptElMGbdyhQx1kGL
	bTu5zG5//Q1fGB+Aq7Z+w8KdZDXLrUA23ZuU39YRfjbJjO/1MOvCEElRYoLJB542
	keYgxUCeZhco3zBLdYHWl9mJQbdtJper0qTB8i39KMndvvVYZV81Q/CM71PC8fTO
	klBLBXpOSBF3NXYmFsexWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnd68cut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:45:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q08Jx0029569;
	Wed, 26 Mar 2025 01:45:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc1p7fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+j0T36Bcm/2niz7hN06kY6a6BN2cdcEtZiLq9jLtdYHvk0xoZVlkbBylLvaz/eaDJ2bDhe7WkTszww9JUaPbByrH0q/dkt6hDToyS9bVZVwHzqwYYoJmKc3VTBjityIQLSY58oCetpI240wfRP5KUa3PH+7klvad4hUF4tSbIhRRTzhG6pCW2OmCjd3EXYS3Um/wzMz45jyqKmM0kzUn4AkNaOey2zSgh0Tv0Ddhy8vnBGT3+5dTfjhZ1K5ax80e0+l1PeYboZatiGqaxu8vWTb5usnIc8URol1zaBxuryVPYFQjBUwaB7Uvq3vVFMyeuOCXjHstfAkFpOFgsvMrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fSFj4reVlNWPjGaR9votuPwwZCw+UzuUpmGZO78N8k=;
 b=Z9LHmoA5cGFpRSqZMgeZy++hOREsAeww8FaljYxGfgcvGfODqWRtoHWC4VT/XP4UN3NG/LhV8IlhFvCoXjf+9tmkjB8DF3DYdntx9dyvFV8zsZPZ1U3EyWEw/EQdZSMbtqPyHUY33nW1AbhTdAhzpu4HKCxJ76qaK5APxztJg/Bq2A0zDqpJC7JLmAUdFgeeGtiGQYWXOcawuAYJdKPtn+c4IFNywT6Wn9z13QxAO4onDLXEsVTyREpfmIpKwczG8SpToXm8MdZTJbB90aaPY/CwXoxTmV6CyNIMdnRbz22WGcd2XZIn9BpZTiJMRPtVLYDQJJAcsAtN/qIXxpB4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fSFj4reVlNWPjGaR9votuPwwZCw+UzuUpmGZO78N8k=;
 b=N8R7ngBvxnFpVF4BWfTE0hp7DKrLHHbAIiesgYt0RRe33nyUvvth7XLicCELkLhpjvfJjgy6kxqQpaXBi1oH4PpZyQpXTGG1yPVH4oEyGtKJ0Z0o9i7F3Ahpk2MNfH+BW++HzBspaDSLUXeblYQeUiFACsZqd5yiTSOiAz76BCI=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by IA1PR10MB6688.namprd10.prod.outlook.com (2603:10b6:208:418::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 01:45:39 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%7]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 01:45:39 +0000
Message-ID: <7652c63a-8d00-46f6-8cbc-b712a0ef8722@oracle.com>
Date: Wed, 26 Mar 2025 07:15:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] virtio-net: Add validation for used length
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Larry Bassel <larry.bassel@oracle.com>, stable@vger.kernel.org,
        xieyongji@bytedance.com, jasowang@redhat.com, kuba@kernel.org
References: <20250325234402.2735260-1-larry.bassel@oracle.com>
 <628164ec-d5cf-40c3-b91a-fe557b521321@oracle.com>
 <2025032503-payback-shortly-3d1c@gregkh>
 <ca78826b-bff7-43e2-8ab7-f4679e13726a@oracle.com>
 <2025032554-petite-choosy-9e9c@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2025032554-petite-choosy-9e9c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|IA1PR10MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: d5143e96-28ef-4bb6-3cad-08dd6c07e918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1FIQmxBZG5VTHVwWjMwOElZTmNlMmdsMHFJWU9LbTVtWUdudlc1VlZaRVZa?=
 =?utf-8?B?VjFhQkJ1MkE4NEUwL2czSFh1QTV5YUFKc1EzZDU5bm10R2czNGI3bnNIK1Rs?=
 =?utf-8?B?eEJjSkVOYlYyckVZa0hDZjcxdm9nNGpkUFAwMGV5ZjQvQzNnclV0ZkRVeUNh?=
 =?utf-8?B?QXBwTHFQOHNyMnp3dE1YMXFQamRUS2tKYTFCZEZkdlVUMlNDZzF5QlFuSDlk?=
 =?utf-8?B?ZkJZS3oydlFYcngxUWhUNWp1dVcrWHFjR2xJRjZxSll3eFJJbFJaL2NORVJo?=
 =?utf-8?B?UlhDb05JMGxJelVxSVlveUpqU05WazJWcW5oVUhOTFZqVmdLQTMvQlQyN1lG?=
 =?utf-8?B?UkU3OTI1VVlyd2VFakJORVhVOWFRSWdkM2xZbU44SVV3elYwSWZEVEM2VTEw?=
 =?utf-8?B?cmlaZk1HU05Wc243N3ZENWpydVlVZk0rTEVxUFBNMlBneTBlOU56WkhUUENC?=
 =?utf-8?B?a2pCaTFZeGhabFUyYUw3ZFVvZVR1c0dBbFlBTVNUbDdHL3R1S0ZLUkx4b2NZ?=
 =?utf-8?B?WitrZGZKdDAzeUc2azJnSnpIK1JiQ1pIMCsvOURSZkU0OE5MUFBuYXJXbEJ0?=
 =?utf-8?B?TlBaRHduU3BSaG1ZSDJrdWxvSTRySEZOMFdHSy9Lb25iRU10TFpkV0s4WVFh?=
 =?utf-8?B?OU9tU1VvekdEaDM2ZDQ4TGFnNGZlT2IxN0J1VFp2ZVBNeFJsVG1Vcmp3UFk0?=
 =?utf-8?B?UEZRZUVoUGFCdms1UEJLaUJiOW5ZMm5haXRvOFArUXFJSTYyVUFWYkpkbGZm?=
 =?utf-8?B?VHRJVGFDTWl1czY0bWVtSy9QT2xzNndXWCtTMGxRaUEwdHpPbDV0Nkw0VmIr?=
 =?utf-8?B?eWwySGpXdWVHdUhaLzBJaHlEU0dKekNIY2Z2dXgvSDc3ZnF6WC9sSloyVFdt?=
 =?utf-8?B?aG54OUs2eTJ4OW82TTJ4TkRqSzAvU2ZHMi9tQUM5dExnTjRKcEk1ekVja0JS?=
 =?utf-8?B?eFplczZ3eE4yZEQxYUZsK0lCcjNyNHR1Z3BDTTF1dllwc2VxMWpsQ2NVOXlq?=
 =?utf-8?B?VDl4OVFlZnVCdWhhTnVGSzNZamU5MGh2M01oR1FYMlFFUjhveTlVc3Z2S1Bl?=
 =?utf-8?B?WjVQNTFCalRibEY4M0ZUMUVPeHBjSzlNMEV3b25zalRpTWtmdnRoRkMwU0w5?=
 =?utf-8?B?ZGxERHFSeG5HN0YwQy91d2ptSHpTQjVlek5RblhxRG93Mldqc2RaUmFNRzFW?=
 =?utf-8?B?c20rL1FEbUpVWlBuUWh6dGN6b3phcEdxbk9zZlR4Y0ZaV0tiQ2FpdjV6aXl3?=
 =?utf-8?B?QlMwR0hhYXB5V3hWYVVyaWJZZFFxcU96SXh5MnpJU2JnV1Nua1dXR1BQdUtV?=
 =?utf-8?B?VTkxRG9zY3JRcno2YlhqcFRCVkpHR1Ztc3BvTXdVTDg4azIxaDFqWmROYVkx?=
 =?utf-8?B?MmxmbGt0L2lEaUwxNk16K3M1a25ZQldrUHhka1prYVBnTnN4WldGYW9QTVdL?=
 =?utf-8?B?Ry9JOEVsNmFGMWk2RHdIN1k3YWduSFllQ3Z6V1AvM3ByY29LOG9vSi9ocWhD?=
 =?utf-8?B?M3U1QlRzK3pFcFJyZGFYV2Z2YlJpbDRvRngrZWkweEF6dGVNMGZaVE9IUmV1?=
 =?utf-8?B?UldCNGY4MFVDVWpjOERVT2QzOTJPZkk2RWtkMmdiWHQ3MGhLUnpPdkhTKy83?=
 =?utf-8?B?eWQ0RUgxamFldWErZTlkQlRHWmNkRTlhTWNhOG9IRHV5NnlqSm9QVUNlNE80?=
 =?utf-8?B?TzRsb2g2YjNIL1ZTS0krQXN2NGs2S0RQa1QvNkhSYlp2R2ZjS1p2S3p1dHp5?=
 =?utf-8?B?VkJ5ZTZUQUgxS3E1S3FoTFJ6UjVMTDlhNU9SRnVHbTl0NVhBZ1VrVXRONk93?=
 =?utf-8?B?SXZucWpuOXdGOFVKRlAreXhhcmhtMHY5a1pXV2VNWEUzSElSZEEySWJHelA4?=
 =?utf-8?Q?jYJAgTJm6KoGS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmYzdVVyWGlIMlhDT20rOEpoTkJIbnllcktjcTIyMko0TVZvTGEvWk5mbVlr?=
 =?utf-8?B?WXZSSklMb2NjS1h1bEs5WEZKdHlnSm9GR0FvNjRUK0RQZUxmREF0cVFGZXZq?=
 =?utf-8?B?bThsa0dFSmY2aGRsell1enM1c2tnWjBNTEhJRDU0Z29tenlESHp6ZjBXTFZy?=
 =?utf-8?B?SU1lRTc0RjljbW4xckRma1RTSVN3UmszV3lMaGlyYmVXaTAxSVpMdHFZcGlS?=
 =?utf-8?B?S21KQzdTR3h2WURNQ3BvNUI4NlVDNXpYY1ZZSDFEM0FkYWJVTFF3d1owVTYv?=
 =?utf-8?B?VEE1MFVQNVZleUxBYnlmblZEQmlQbzN5TUNZT0NtWTA3V1lkQUpHUjI2eFZq?=
 =?utf-8?B?UHgzV3F1SXdndWRiTEhRdlRBZ0wvUU9TOVlKanBTL3BXcVZ0bUxyTGlWWFlQ?=
 =?utf-8?B?WGZkemthaVdvZGQyS3hidU1iRFE5WHFiRkswcXAyb3JvVURvS1VUSHp0ck54?=
 =?utf-8?B?VW81dVRiTGhMWklIZjR6UG9idmJucy9tdEdnTFVDWk1MeHpNaWZKRlhsQldD?=
 =?utf-8?B?cy9KV01lTk9QSTFsTHQrQlVSWjl4ZldYR1pOYnVkVjhxRm1sTFY5a0NxZUVr?=
 =?utf-8?B?b1dTaDRDYkFNeGlXcXJYcW0xazFkVkF4dXY2V3lTb1BLcm15MGR2UXF4YVM2?=
 =?utf-8?B?Z3RaRHBJMHBrdHZqY3hOR2hBOXlUTWcvTURxdjVNYlRXL2pnRTBZWWdZSitI?=
 =?utf-8?B?SnEzY2M5b2JzTEtSVGZhZ0sxc0EvbEUzaTFtZmQ3WFNtR1JLdHNpTEpVT2xZ?=
 =?utf-8?B?dkRORC9rSHRLbjcrN2tiK0F6VmJrMEVEQy9ydUJzYjEwYjhhSWt2YmxNR0dL?=
 =?utf-8?B?NUhuaEVsYXNxWHdjcjhCS2RMZlhPdUZkNFBQelhGeXlLdHYwSGtXOEswbVdw?=
 =?utf-8?B?bGZBQ1RuK1JkZjZ1di9pQ2VmUjdpQ25sclB5L1F0RmJtVnBieG5kbnV0M3FU?=
 =?utf-8?B?K1lBRFdWSWMzcVJBcWt2Z251eE96cGxVZ1JFblhQbXY4QWJNMG9QQWpjQTdz?=
 =?utf-8?B?Z3VGeEMwbnh2RXhlQmJjZmY2RVp6YnpIeVBiR2o3cXVtUVFOTWdsNEJ4aEV4?=
 =?utf-8?B?cnpZZEEwYkFCZXk2eVo0SEc2NklMenBqWk5GZFJ5RkI2WlkreFZPbjdDMDNa?=
 =?utf-8?B?b0o4RHlEdXQydGE2RnhXVURPekNlRHpoc09panpkUVovQUdxODRaZEV4R2V0?=
 =?utf-8?B?dCswa083c3hhWGdMdjltZVRrVXEyKzFCc2dVWDhEcnFuQ25oaEdzbEpJdDJZ?=
 =?utf-8?B?azdrTXBuV3V3N3RzOVlwaTdpWUtBN0UrOVQweG8vWS9EdnhJUDRXMERXc09Z?=
 =?utf-8?B?d214NHc5RWEwTXRPWTAwZmJNQ3QrSW9HNUFpYU1GR2loZGJNYVVJU2F0WGJK?=
 =?utf-8?B?ZHA4Mmg5SnhwblhvQU0vS0ZyRG9xUXd4cWVHQVBOU05YVWR5TmY0NkQrekMx?=
 =?utf-8?B?T25Ibm4wUXdRRkhlMkh0RnpJb2o5WEIvZDRkNnI5WkRtVHIwZ04vSUxnQXFI?=
 =?utf-8?B?NXZZbmlpOWhjY3NyRVY5UVVJdFNBU2tTRCtmeGVsWW5hYTAycjRJd0JCd1I1?=
 =?utf-8?B?aEtzRm0weEVGMmRBRkVIallUTGJWNHl3ZTU3Wmh5VFF5dHVOeDdmSkgwQ0hx?=
 =?utf-8?B?MU1hLzNqQ3VQMmsvOGk1S3g5UFdiTitzWGhNWjNMNVIxbFBYSVV4WnZSN1Zh?=
 =?utf-8?B?UXZRWGhUTGxMVmY0dys3TUNZZkxKeUlGSHZuYk9CU1oxYW1oYXdNUmxhazVR?=
 =?utf-8?B?QlhCbjIvbEtpUVJNVHVlNnhGTTQzS1RVOTFGSnh2aG1aNnlmNVM3c1lqcFJK?=
 =?utf-8?B?d0QrUURUVkEvTFl1SVRJWGI4d0J5ZXlNWEtYZGlVaDRQeFZhc3BGLzE4QU15?=
 =?utf-8?B?SXE1VllBcFJranM2SXNYT0hMTFdJQ2Z2c3lienlaaDN1cXp3dXdaaXJ2NGZl?=
 =?utf-8?B?ZWhyZ29Xa21MY2pOSm8ySEVuUjFWaUdkbkV1MTVuM1liMzBSN1ZXdHk5cFdk?=
 =?utf-8?B?dWpFUmpLSDJUS3Y5YlNieTZQOHpvR25CcXBCQVpvZFdjT2RWU2pVMHNoazNE?=
 =?utf-8?B?ZUhGSlYya2x1QVBFejVIbWlJb0ZZU0lnOTcwaDhSeldqTkhITkJRbVhqUFc4?=
 =?utf-8?B?SFAyWHAyb0hUd3J3VUtnVVNJRnlsalhWcDR5REVNdzVCbkNVU1ZTZHNyZSsz?=
 =?utf-8?Q?zaBCco+RnAzsuLSsKz6uyqI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B8ighR0n+HQ7KJnPx2WMf6XV5jiB9mdUc/hIrykGRCwR6DoBG9xy9zxwIjVxZoBHzvLrIOZodlyTi5gcmnTOLGXZh6GpPOP1kUX/6lYRn9MxSxXjE2xY3bBsOO/yih1EhB6sNJlCiTLqiMPh0wvwUTA53gyBOEUV34rpJB8UjwKchw9Oo+ML0sxho+UQ4++TLGbvlGhN5CLvBfkPun4qpIBelS2FpH60NI6/WK2x0+hprm0W5LlNv3eIUDe9ctivBbso4qZmzqzWqLesum4owiauUeODCKKo5HYDo2zGUbJgxxLJ+Vks6jxuNxo+kL/aSrfziL3vzrb+l/2HVrEfhjLoPikvB1R8kRYFpN/hCUzqbwLX4fsDMLk6dUpNl7HoqFHvby1e5Ae8fQt2iuGWehVZ2RnoLPv4bL6cGOaCi2aZnLfrmYTWszhGHVlNI3jxeQfYNn7Gmb7jtTNn6MVUigqKczzk0nFCtqT2vj8KrfxmKPWhH+v1Fs7btdwb7aPleB+KqScWOb+MzwtPacu/KqQmSKyUl6RZNi8yZqj2p6ZBsIBISqKMZyg5SL1MtuhBLn1aO0K3OFLLQTLPMpQNFhP3FeFJDXd9ZKWTEBFXF5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5143e96-28ef-4bb6-3cad-08dd6c07e918
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 01:45:39.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya4IyIcHbSRLS4greQYv2O941Sau38W7ojxLqcnqGdfcQy7vk2L/ee1kCjpPJ2wDqMmQsJFvw2Mk2e3NmAgWrubukT2YVZxu6AruuwvthhqrhpPP2+JHHzJLTfBzcD+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260009
X-Proofpoint-ORIG-GUID: eVqxFxhFDUYVUtKOJz7vNc3OT5biynwE
X-Proofpoint-GUID: eVqxFxhFDUYVUtKOJz7vNc3OT5biynwE

Hi Greg,

On 26/03/25 07:07, Greg KH wrote:
> On Wed, Mar 26, 2025 at 07:02:38AM +0530, Harshit Mogalapalli wrote:
>> Hi Greg,
>>
>> On 26/03/25 06:47, Greg KH wrote:
>>> On Wed, Mar 26, 2025 at 06:32:19AM +0530, Harshit Mogalapalli wrote:
>>>> Hi Larry,
>>>>
>>>>
>>>> On 26/03/25 05:14, Larry Bassel wrote:
>>>>> From: Xie Yongji <xieyongji@bytedance.com>
>>>>>
>>>>> commit ad993a95c508 ("virtio-net: Add validation for used length")
>>>>>
>>>>
>>>> I understand checkpatch.pl warned you, but for stable patches this should
>>>> still be [ Upstream commit ad993a95c508417acdeb15244109e009e50d8758 ]
>>>>
>>>> Stable maintainers, do you think it is good idea to tweak checkpatch.pl to
>>>> detect these are backports(with help of Upstream commit, commit .. upstream,
>>>> or cherrypicked from lines ?) and it shouldn't warn about long SHA ?
>>>
>>> Nope!  Why would you ever run checkpatch on a patch that is already
>>> upstream?
>>>
>>
>> Ah right, not in this case but it might help when the backport is a bit
>> different from the upstream patch(i.e after conflict resolution if the line
>> in code exceeds 80 chars) -- checkpatch.pl might help us do it in the right
>> way ? (only in a case where there are changes between current upstream code
>> and the stable branch where we are backporting to)
> 
> Then run checkpatch like normal to catch that if you feel you need it,
> you know to ignore foolish warnings from checkpatch, that's just normal.
> 

Agree, that's the best approach!

Thank you.

Regards,
Harshit

> People doing backports better be experienced kernel developers as this
> is NOT a task for newbies for obvious reasons.  Which is maybe why no
> one has ever brought this up in the past 15+ years we have had stable
> kernels?  :)
> 
> thanks,
> 
> greg k-h


