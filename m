Return-Path: <stable+bounces-226098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP9mABpxuWm8EgIAu9opvQ
	(envelope-from <stable+bounces-226098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:19:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB12ACE2B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9900303206E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7E3EB7F1;
	Tue, 17 Mar 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mpu1onrf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mz1VKLld"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC93EAC69;
	Tue, 17 Mar 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760781; cv=fail; b=aGowv9wPN5h7oHXXzTXAzn9LYDH8tijxBwvQLmDvA2IeOZ2X8b8Yu+yaUv1JA7DVVr6Ymcxtxhaabat6f8puEeUi5jbSctW8XrSWK5T7mHR0aiHcYCrDzCNXCKR3frGjs9A7RPJcx/ai+5vRQgWigPTiDSbA79jvtV6UdlKPQmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760781; c=relaxed/simple;
	bh=nHpHm34tOqg1blgh8eOcAuX+IX3wGXjZkG3EpTlHQC8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l5PNC8i0HPesbW9w01ZScm8+vM2u+UlA8/7NPch+Sr+oT70RB9RB+szCFiU4ncvQY/oY44HkMY4ly0EsDQV0gNCUWB/5VGBCMnNM7Z1cS7aDPFnfcn3pxMr0p6u8GpSjoy2Ei25qUbRwM9Ks2ormrP7VVSL736iL5Elh3pTqBIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mpu1onrf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mz1VKLld; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HEldqP690711;
	Tue, 17 Mar 2026 15:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fdQfkqbNGa2OHmxQzMkihW9MZKpFvhNHdty+vUhZQTA=; b=
	mpu1onrfxhZ99PFqnKSzuZ6C0yaCcQ8FWizBWnauz5jNCorI0KscTE0EHmPAOdGY
	/8Z2MVaWUX6UwR0Mr2Pm+7bPGlw4DouAmTBGsRxfw63PLBeX72Q0SYzq9ZJzxFeA
	0CmqBYs1+EbgSDuWG4JCN9BKn7MZGXl9boYgJptb4mgm7hm5mzFmY0wva1vG4TQw
	/nq/hsAuRbZzzA7Aug985orJtfsRJ+FfHrStkqfDOCl6+Zb+2sAquIDByaS8gIn7
	oISbH8UWlmxckyVHx7D6B1LYIKqnwjsdQ+rSdH5IunEexb1AqJT1ArnDX+8LCfXJ
	cUqnNKa36JJfrOV1ykk+UQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj64a16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 15:19:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62HENaFE003496;
	Tue, 17 Mar 2026 15:19:03 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4a8h2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 15:19:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8Iy4yPCxZpq+TLiVvHhwS0SvDw67S7GDO70CmIr3Kb/C927hyz1RadlbByZXJ+jCRMHIWS7COG6twNjJl0sOmLTF8Os5IvUljkUM3Mf+ZYlQh5P0XhG4FW/ZVCH/G6sw71QXuzuwB2FDloP2K9FajwQXoNBLj3TAA99f/4DzvGbDuiM16l8c2Sy0UwgA2fO/R3Q81eMBKv8yOEnJ8lR3bY7Cn3pSz5a+FFrv+e7Fe/paX2NQjMT+JAnsnVf1LEc6kLdOUVHUl447VUChRIF1lU500YX8defO+eg6O5xkUXVLqXVLAvIaR3jkumV9DGFFQy1WOa1yoEM8D+z3HJP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdQfkqbNGa2OHmxQzMkihW9MZKpFvhNHdty+vUhZQTA=;
 b=aGp9evetu1cKfJKmgBMfhvOyUzxUTZYq34J+55oZg4UwVoU7w/XThE3/NWvJYCOgIZiVGVoZD1sy73AJ+SKdLqL9L9aFn496luY7xtLf7oEScvXVYvw3uVFqTtYEduJQUzd80erObmxmTvaapF/KU892tVhAaS/QfZkFNZcnJjNt/YF5M3v6Sh+iYZ0E5TzqvD3EJzc2bHcNOsPiBwWW82Ppca2HuwHIQEDhGtF1Rfo7buJPcrd36uSoj9O1DVzkL2/I6c6Yi3Q9uihCBxdOfUYvMyORxsZB+L2sOl2Ki7FFrSMfL0/tQuVRwts5QCXPT8DV1Rtysds7qQPY6DQd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdQfkqbNGa2OHmxQzMkihW9MZKpFvhNHdty+vUhZQTA=;
 b=Mz1VKLldf4zn7jpF4umvCRiKl7bFdS8Nt8FynnzadyxMVffF4+j1164SMqohbio0L2rtbEo7mfLJEEHOVe2ZF4Z4ceP4v0Gi7g4yUss08KciakYZK2cuycp/zTJVidNjXBB15Na1NUOCA+RZqmLrH/fkx0vdqesIfADT9nTvKlQ=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DSWPR10MB997826.namprd10.prod.outlook.com
 (2603:10b6:8:36e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 15:19:00 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 15:18:59 +0000
Message-ID: <8b27a545-7d3c-44b1-a9e6-16968fa2e2a4@oracle.com>
Date: Tue, 17 Mar 2026 15:18:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] dma: fix dma_opt_mapping_size() returning bogus
 value when no backend hint exists
To: Christoph Hellwig <hch@lst.de>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
        sagi@grimberg.me, robin.murphy@arm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com, ahuang12@lenovo.com,
        iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <20260316203956.64515-1-ionut.nechita@windriver.com>
 <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
 <20260317143651.GA5186@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260317143651.GA5186@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0502.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::9) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DSWPR10MB997826:EE_
X-MS-Office365-Filtering-Correlation-Id: ae34ad6c-8ad7-4a73-4477-08de843883af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	WBoiEQsDvrqh32eTVrGFxYCljriIjtQiAYTMk0gaF4Ms983p+hRUnATcjWBqOgNwwiKi+vRRqh/Z6yvljBqp2M98xfiBg2MWADwWDCkkDbyGgMIGCpyzRva0xHTZCWzaWrGnhU5oaAYrA6Driu/ssEfiGiM/bYRsaBEx5vm+GMOeuU5NZN0JBIW6jZD3oSe1boO8R/yBmujHk//dRcP9+BPqM6VnGWmPJ7yLTp7jabWTfVL7CPt9MdP2a/XfbsnDwd6SYpGxWJVXQRyMYBB6vmHNm1jmGO8sL1wYLXbvVlhCHqtm79qDTFpmRmxNVfQMxRblZipSgiheDV7pkA0eJS4Dtj2J5anyp7aGwq8DPn7ySTj8agc5G8aJoMFOw9hOFKeyb666PucUBZtHadVieqqxkElIpq83KErHc/648VH9ZdXKETSHI3fcwgygHrdqvTvI6NqK5f5cFmw7wg2Ji/uwy3hAccKeD9pHshnVMMuijj+VEhECi9zK0Vqr9aExDx/zkOG59CjuvFQXb8JBe5OdZ3FuCbx4bRf1irSvfZadsjX7DmLN27mD2QLVXDDAL5/WRhQLjck0R0WeUjIEvfYHRhNyY0jB//hkLCyTr1xfGV3c4BJGb97NX9n0xUTfSDZ0aUI4k138iVrOPaTQFFwBbHAts1LMPiD9tzH83oIO3eoFqLDzxdcYsLnYssdKtnkIOI46iUJZBzuImOX0yWTUG3gpNiff5XJieXgaDn0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEVSb29Zc1ZWZEFEY3dzNmlHdmUxOEVnbkpPdmsrVjcxdWs2UkVDeGRzQ29E?=
 =?utf-8?B?ZVgzWWZyd2Y0QjBPcjJiNHNzYTJkYTNtVC9YVXlMcmxRVWQ0dTBTTkoxdWZU?=
 =?utf-8?B?LzZnWFg5QjI5bTlxTEpnTFRQMndzbGRxc1NYZFcySjV2blBka0VlM3hhQU9K?=
 =?utf-8?B?QnM2dGZUc3ZJSVRqSW1CeThKV002YjNXbVNPZzJWVDNueHJFNWtZOGRxQko3?=
 =?utf-8?B?dUpUVDZQREM1a3UzNDRMTlU5akthMVdBcFJvTC9CTlNjL0NwOU5EL0VqZ0Ew?=
 =?utf-8?B?bmdhWHRoYVAwSy9reU5VbndWSG4zby9sbElzMi9McjRTZEQ2QStoQk1FRDRB?=
 =?utf-8?B?YWI5ZUxKNTFJU0k0S05MV3dHRVBaTEFLeEY3RytxSU5rSENJcU1uWUlLZ3hK?=
 =?utf-8?B?L3lsZGV3MTBrQWtjS1h6bGVCdmxMZHBvdStzT2tFSzJuSm15SW85WDErK1ZS?=
 =?utf-8?B?Rk9ld1dYYmhIbTRrd2JudnBROFp2ZnNMOUxqTFhLRFA1UU1COFpxeWxUMW9U?=
 =?utf-8?B?VTFtWElwZlhEZDhGYnhjTk9JRXJJN2QzSzY4QU5MT0crV0pKN2ZvWWZSazRv?=
 =?utf-8?B?Tyt1KzFHQ3E1dzF2anJwdm5rNzNYWDNVNkY4aW56bWlYbEFPMElMVTJqTSsx?=
 =?utf-8?B?cFBWdDh5WllMY3Y5ZUYzR01xSEtGcDZUSmxYQVVZcjJPdUpjQmh4VUh1VzlQ?=
 =?utf-8?B?SDNUZ0lhOVVXZmZBY0I2ZHBpakJGVmlpQ25jWEc5dFA0YURnSEVyYWQ0a0w5?=
 =?utf-8?B?UDEwT21yNkZWdlZQS2JCbFRlVzVQK2dhdFczMklnb2Izc0FtRExWWS9aT29n?=
 =?utf-8?B?QzJMMk5XT3RkK0R4TkJoSEhpUkNJTitYYW56bFBobHR1VE4yaVUzdERpS05Q?=
 =?utf-8?B?M1lEU0Y3RGVtK1hMcUtibFB1SUFnOWlEc0d2NGJwWHlwTUNSM2pHdFF4Z3dr?=
 =?utf-8?B?c3NXM252VkZxT2wrMmJpVnJ1bW1VMFd3QmVDOXJDdmtuc0IyVjNQMzF5QzVX?=
 =?utf-8?B?SERtMFNCYWxQNWdzK2R2R2Vvbk5zNVZGaFV4dWpicUVJT2RJTU1RS2JIMysy?=
 =?utf-8?B?VlhOMWkxUUNiNHhHTTljYVVMTmwzTWVpRjVOVlBJdW40SDdSTGlZMmVVYzY4?=
 =?utf-8?B?cCtvOGEveFA1NGE0MytVaFpZanR4dDM0dWJ6WXBDQ0wyN2MzSWFEUnVUdHU0?=
 =?utf-8?B?eTV4Q1RxUmgzMk4xWGplKzFQY2dVeEY4TUJsV2hxdEZLMU5qMi9LNTk3N3dB?=
 =?utf-8?B?U3F2WDhVdnVBa2dmNkhyQVhLMDVTV0hRMjNJUDduMm9BTElsN1hkU2xRaStF?=
 =?utf-8?B?QUxYSDNodTlLL044OUozNVZZbHZHbmdXVmNmQjErZ3BEd252Rmg1alBVWmhW?=
 =?utf-8?B?VlJTSzhnS1lHV2ZIcnhYVDkzK01DODFWS25sdkdhK2pMOWFPbkxUL25nb2xM?=
 =?utf-8?B?R3VJRUxQSm1FTDRNUVE4WnFFTlFPOVZsblJNUlNIK3FkS25KaGFzZnZZTWNX?=
 =?utf-8?B?UGZDYllub21GY3VXZVZFc2UzckR1MHNYTG4zVXAvNTlOR1JGWTJjL1Q3aWl4?=
 =?utf-8?B?Ukt6dWNjVXhMaitxOWd5Y0JWNWtzWHNpMHRkTzV6cVQ5M3VRTkRHTWR1V0lX?=
 =?utf-8?B?R3pYT29wb3B0QWdzTUVLdmttQUtBQVRqc3BHOGcxZEpRVGdCYlBqSFFPS0xy?=
 =?utf-8?B?akpVMEFGWXduMEgrYlJzL2hleU9NVDlPSnR0THREZlFVcFVSV2RSQ3M1Z3N4?=
 =?utf-8?B?enNyd0h0Nlpud04rbUlsdFlJY2JHWXkyN09LYjVpeElLM29td3habmM3U0Nn?=
 =?utf-8?B?QnE0Tko0U2x1bitBZjdqdFE2UGtsc0N3d09YRkluK3NicnJyNk1iR1FpdWd0?=
 =?utf-8?B?eDAwc25OaUJxYkR4RXp2enJhOXFaamZWelFBSjZHOVFTeitHdVo3L2hhM3M5?=
 =?utf-8?B?ZFZHSjE4RmtiMHE3SmplbmdmZDB3cVRFbTNCS3hXOGVKdmdNTEExZ3RMMkpD?=
 =?utf-8?B?dlJMbHFBZThsa01zLyt3VEtXbklzUytsYjE1bzc0ZG10ZmtqVVZLN1NSd1Fs?=
 =?utf-8?B?SGRLQTdCbHJzajhMdk54Qit5eGFNMGozQXgyUHpKbHhBSXMzbm5nL3BRb2lK?=
 =?utf-8?B?STllMWFtRlJZVzJQZ0lWZVV6b0swTVF0dnZaZUVRK1ZsNi9sMHhsYkZ1MFBl?=
 =?utf-8?B?dlhnbGhuU1F3NkdMcHdZQm4rOWVXNjU3WGI5OFo2UEdUM2ZFeitGd2VndmVu?=
 =?utf-8?B?MlVzcEVjaW81dEM3VW9TbFUzTUxQTmJJQS9BRWZHZ2ZxZXdXbTVwcVpvbHJk?=
 =?utf-8?B?RnNObnVJc01UTFBkaUF6YTNTTE1xWTkrQStBR1dSTTF0b0Y0TDhCTEhyOGIy?=
 =?utf-8?Q?SEf42coD7djPaU3A=3D?=
X-Exchange-RoutingPolicyChecked:
	Gs97cdqbKpyWpHMqymhwVZt3sTURxJyn8VIxRxs67RGasCJFRj/BGdjZeg/WHEbsMqMCTlPl6Etz1nSon5F0Xb4vAGoAFGrrhuBe8O0ayRKsew5BvLHNsQ8WX4wS0mIUM5Yml5i+yZYhsE8qiSTKYrEDKZr7Ll6CZYyRNZ2kKP8CXNfGMDmqmDZQD6GfWlnXiRxj9Bk78AZ1nxm82NFX0vUTzxDBUgkQs+Jswj2dHA8LnZVChY7JlB6NB9UCYTSbORSPvVXrjhu1wGNPx4IOPtpuaGUzkPMd2fd04j2SJFDp4xdgnA7VzwyjVwwaQnyhhFeMdnZAAgZYSsNLRHXlYw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lhGZob+8mD/5T8ZWvVGg4Ve2D9Bmc+iycRq26gQkjgxzc4e7JiCgGk98/f437tLI70tt1H7/L4Cj/3hgcLfjZxTTZUDCdmjGdiKpjDO+/NO8MYg0bpZ+bsyfzNeb/51LEfhIDf2+CYfguv8iQ2jCTbx603LiTPMZsFQfCKkbTd8SmI9/xi/+HWlxdbGR/9PHNuO4rXCI8Lc5rqLbEoxW/HFa8Skl9z+ymMD7dWYRFd2+atDcTqZF1dTW/hSxcIb8B08ElRePKjj/7Ue/83fAlUiyHqbUBaR69hX+MxQa4H4n8ulGN8e5IHbK7EDmxy87IjXXtXvNzFJf/Hy62REUmfYfJdsikchG+q4+P06lMJ44HvVukaNxSnD31Drru6skzQTGu8kH+aqBN1H1NSCXUWGV8xfwotF6YrrOHWkHyeTEESAG3UtUExfwBf2tW0jDiWVyQXdTVPGp4HLyzFuFtYItLHIVOmGSE3Mb/6Dp/4qG/yAbRzR8SM2S0WLyui+sEiP42RkFAO3+TKXj/sAqokj4iGAEbNVf3cQUW8zkqZzHm2XyWyNw94QterQ0UAP61FPox+Avt0FbztLTiZZdX1mojO1KEtDGZfSqBhKS7Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae34ad6c-8ad7-4a73-4477-08de843883af
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 15:18:59.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zHLjdGZj+R+rHJAzntDljHk0h3XQGySplnbSO8T2hYvfI+eXJ5RYPaW/v/0mQkIR6Lk54gDIUW0z9WLVYnwVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_02,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=981
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603170135
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69b970e8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=i6RuuZHAm7oPeoWAvO4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEzNiBTYWx0ZWRfXyi63lWlYaaoY
 351syeJjYMPbC7A5y96RDK4Tw9vqDrNjKnDSk4s/kAcEpGB2LPYSW/rXIkMguEKTn75eNSFbX7o
 GSvPY1e15GaJPmW7P1fiw43+frXurH6RkLVGZpiKkDBR4vo7ZN+TXH+UhHSu+ABiJU/52ryQ4Th
 emMdvq2caIEH1AF3umdyh5k1oxVJ1iKv50+s6OiwRf+csL3KaWpkpwZZLICe4p++4vR6rdKQN9T
 94YO7KX/rFzdM0im4MdOsjZuKqgPnkVfTnSWCd2b2xsJaU/wPV8vuE6WP9XHa1vHc+avOHXIT8A
 sG/Oo5TswY0uTQ1fvCgty5klaAGFfmxj6Umf2OWsWT2HodSISIz6IUdOUFcwW2mhz4wLicxpGWB
 7Xp4gOUQEDNk/ZbNup43pa7FIs59tskGEGlWOyj7tYLXvnFiv7MCnxvoB6OdmQ64l89a56hrzK/
 b8aS1sw/pBXKGpLyKOA==
X-Proofpoint-GUID: ar8OBTo28Gm1M9ZDi9_JVmWitJc5fSPf
X-Proofpoint-ORIG-GUID: ar8OBTo28Gm1M9ZDi9_JVmWitJc5fSPf
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[windriver.com,samsung.com,kernel.org,kernel.dk,grimberg.me,arm.com,oracle.com,opensource.wdc.com,lenovo.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-226098-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.g.garry@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B7CB12ACE2B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 17/03/2026 14:36, Christoph Hellwig wrote:
> On Tue, Mar 17, 2026 at 09:11:59AM +0000, John Garry wrote:
>> For SAS controllers, don't we limit shost->opt_sectors at
>> shost->max_sectors, and then in sd_revalidate_disk() this value is ignored
>> as sdkp->opt_xfer_blocks would be smaller, right?
> That assumes opt_xfer_blocks is actually set.  It's an optional and
> relatively recent SCSI feature.  So don't expect crappy SSDs or
> RAID controllers faking up SCSI in shitty firmware to actually set
> it.

Sure, and then we would have io_opt at max_sectors, and it seems that 
value is totally configurable for that HBA driver.

However I still find the values reported strange:
swidth=4095 / sunit=2

I thought that they were from io_opt and io_min, and 
blk_validate_limits() does rounding to PBS, except io_min has no 
rounding for > PBS.

