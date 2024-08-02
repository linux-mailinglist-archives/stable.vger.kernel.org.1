Return-Path: <stable+bounces-65295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333EB945D4D
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 13:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF1AC1F2271C
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB131DE86B;
	Fri,  2 Aug 2024 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FmClF8IJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dVCNJG5F"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D212614D458
	for <stable@vger.kernel.org>; Fri,  2 Aug 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598531; cv=fail; b=SrVkNfgHYHdGTyIi80GvTVonXESzwokVWuuGnmHZyduPneSwzZd9Bid+Pwc9XRaY6Pra8SVLuTDOHl45IZEsQRB6zh1djF6vMRHMnWXctbmpaeaYk7GOszY7nhziZ0UrDtN6YuOodTtBjwrpqBvj28G4mdAn0HP9odcgfCAZ4PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598531; c=relaxed/simple;
	bh=N2JOPmyrS3OaULH9evK8FzuSHZMF8RpiK22JbTNnQ64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vv/s8OEGQFDwggfKLSoGuwNJtP0fPxenCs5aBwkrCNWv/mwWx23RJbYWzqm3B0W/Oas30+MS3zdn7E/PAqFaH/4r0uDjtg8Lazo6NlrTD03VqqMwjTqzaCrqjl/b2CMCzxgPdXJt/FE/b1OYhozIlUIbqxc52qtkzlUBkWLQ2AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FmClF8IJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dVCNJG5F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472AMf0b018762;
	Fri, 2 Aug 2024 11:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Hlx/qbwhkBOe8w/4Xu1/SIGUh1aPDbwXE8wnlR4lI3E=; b=
	FmClF8IJfbo/Mz2hVW+NZZO2ke/F5EsOUXZKi078NCcteOIgA1hYzHKkxtznwzMB
	+FzKwE/Q3pFK0SdrH5tgHNH4koFTkPy77NUNLSytGYL1TNeDHtnPiWTr9TofvU0J
	PGTjDp8oqUnZFLM/hYMeAVPQjfyjftRo2WVIjecXN7B43OPExOx/b1/D0t76t8py
	RRw9j8QjGBXlaVTCaK4HHj7CNKvvAQotwM9au8sYc32bviFfYBTndXWOVtH+HKZF
	eul/LO7fJ1QOIS+W5ZxeATv3irJs7sxjZsJTtG+BximXCYzNnuUIfJc8HWorki7R
	AZm+clVuQJG5hdjGj20rEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rje8gy4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 11:35:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 472Au48I003815;
	Fri, 2 Aug 2024 11:35:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40p4c438hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 11:35:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yljEUbBUdXanoY5gEjG00OZLglU2zuUMlKRSLS9HLWtt1I7MHUFspHSzOpK9L3mPtV2E5cE29SNzv84XteWsMOZWvKunC0HtG1tKjHEQdm3N3PEp60ojDvE/8IHvryZRR22tnzxezyKr5WURuf4FN+7YOWvM9WRVGW3Scn3ObbtGT7ijooaoRRWemMFeXHO2yZ0nHpDVsh5d4vNJXqNejIa8pOy8zG7Gg/o506JYiCoUNtYGWZcpFO6KMqYQBLc2mCvNY3qsouoWlcWjY7HQc9nMb6q6mco3uVZok1IaM+5zw2QezuSsNhsSqyBoALbZqvAslNStA815b6W3xiG3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hlx/qbwhkBOe8w/4Xu1/SIGUh1aPDbwXE8wnlR4lI3E=;
 b=AO6V7R26crzcraLGfwNYR9kjoOe0vNXo9F4VeMcvzXDdYySzuXWfephqFretJoqB5Nv1YrFV68tdMFgrCWbjO6evUFeMrnIb2YPANetKNwvY9vw7QC601iKVO3H56ShS4p8i4V/19pAFUxDtSjENaCd96NUcU7nRKlldJRrZsNI7twVEtEMiOdlifLkf3qXMpgyjJBI3JkQ2RRDrPc3AOvXBeQBmdEvGXiCfd2oQJDv92/++Zv7VVJuG7F2w3k2lA8nD5YMI5VYTPkHVMuycrnhgmsXd9DaNJKPtI/toKMI/PogPnmmtnwzKPCXcAP0htK6TnTehbYei8qPhZCYdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hlx/qbwhkBOe8w/4Xu1/SIGUh1aPDbwXE8wnlR4lI3E=;
 b=dVCNJG5F0DymsyvzoInXAediHNs0sWGFwm5RrgVUt0cNvnijdBQ8Tqrpa6ByLYr/CGFKzgkgpqkllSsUfeqqBAhJLGcN0l1rvH02PSRzXVl3gfzlXqG002o+gvf2iwCg3puxy/rNwac95mljDpWH00VdlUjrM6WFOkPsKn0QWPc=
Received: from MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18)
 by CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 11:35:17 +0000
Received: from MW4PR10MB6297.namprd10.prod.outlook.com
 ([fe80::f9fc:aab3:6419:893f]) by MW4PR10MB6297.namprd10.prod.outlook.com
 ([fe80::f9fc:aab3:6419:893f%6]) with mapi id 15.20.7807.026; Fri, 2 Aug 2024
 11:35:17 +0000
Message-ID: <a6266fe4-3f33-453e-94ef-2f53d2e5690b@oracle.com>
Date: Fri, 2 Aug 2024 17:05:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 1/1] tls: fix race between tx work scheduling and
 socket close
To: Jakub Kicinski <kuba@kernel.org>, Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, valis <sec@valis.email>,
        Simon Horman <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <20240307155930.913525-1-lee@kernel.org>
 <20240307090815.2ab158ed@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240307090815.2ab158ed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6297:EE_|CH2PR10MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: fb24d54e-dc82-4b39-7407-08dcb2e72f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cklPVEprS05mOGFGb2pwcmhYQWZlTzFjOUlLYmhRVTRpMzhyL2s5aE9EK0c3?=
 =?utf-8?B?RmUyd3lnamJzdU1TVVZlcFEzQjIxSjRUYm45U2s3bVJXcnFzMEVYbUNwYlNL?=
 =?utf-8?B?cTlvdWZkN1BNY3lVUDJTbDRrbkw0VTBaYXBNQVBERStiRmZwSEtZVm5STHhZ?=
 =?utf-8?B?Tmk1ZjNxelJidFJQMlprUm40UEg5a0s4RTgwRnJScVZrSnJma0JZRzIyZkVI?=
 =?utf-8?B?WFM3Mk5vaUx2RXU5bWVqaWpsTUNtNEltUzBSbUZmOThyZzhVWGVhVlRscWRx?=
 =?utf-8?B?UHA4NGZ6QlZvZEFtaTExR1cyNEdrSTNUSXRmT2xWS2tENlJoZ3R3UFdhMmUr?=
 =?utf-8?B?QW1VVDBrZzVmdCtpenlkYitTcG5aV1VNcjF2WWdpa2pUejQ2eVNnRWQ0RDYz?=
 =?utf-8?B?V0JGQUYrR1YzOENoWVVmWFFaNVBzTGF4c0IvV1JrWlFMSUZId3U2SlhQRjg4?=
 =?utf-8?B?UHBuTnVLT3pnTDRiRHJodjIzS0ZPRlJzcTE5dzZXZWJxV2Jib0xKQ0k1V1RX?=
 =?utf-8?B?d0d5ZjZMRU5hUVRaYlFIRExqQXJ3NHFSWGc3T2UvenBidkNWc3JLS21LOWxY?=
 =?utf-8?B?U1JEUS9ILy9rWmxTRTVFb1J1OWI4Zm5GT3BSOEI2UUtYSzBvaGc1bnhXWkVQ?=
 =?utf-8?B?Z0J0U2NZYndrUU9ud3NTc0dHN2VPaU1vR1RCU3lhM3grbng4RC8rVTBWNTI2?=
 =?utf-8?B?ZWtkOE5peW9qaHZNRW9Rd3BSQm4yMlU3T3dMQ1J0RkNZbnBpMzRtZk5PVkRR?=
 =?utf-8?B?S3NlajBlOStVbjNVTjhoUXZsM2xSUHJxK2ZBMVZOeFk1N0pWZExNZmMwYUVw?=
 =?utf-8?B?K1p0R1ZNV2dxSEd0YTUwMEhaMFZhaUpLcGRtbmQyclNXQXZhd0RySURjWW9p?=
 =?utf-8?B?TnVoM3VzSXVkWkpzNDh4Z21Scm1OY2NJU0wxaENXcnM3dTlMeTFtV3hYUjZ1?=
 =?utf-8?B?SHhreXZGblF2eVljU3ZYM2ZZQ25sYVpQYzJ3WTJsbmlHbGQvQkorMWpwOGZt?=
 =?utf-8?B?RVQxUm1iTWhPZU9qZ2t1Ukd3Qk9sUkNEU0RnZnRUeHJONFBZWXkyWVNOc3FU?=
 =?utf-8?B?bG1qbytPRC9rNFg2WURhWHArQVVIeHFwRHNTcnFPeFBMT0lnWnJSSzNqWUFE?=
 =?utf-8?B?NjJLSXcxM3prOElZdWsrOXpuU2N6am00cjlSaE5XSlIzVTMvSTVRWjlSZlRh?=
 =?utf-8?B?U3A0aTdhYVlYVDE2MHVXNjR0TFFNN0tFQU5IMTI0MStzS0ZwZVhYS3hYMzFo?=
 =?utf-8?B?TFcrZ2RDZDQwQ3dSajh0ZUVsVXNicmQ2VXdJOHU1dk96UTNsL0gxRUpLOTNE?=
 =?utf-8?B?b2tTUVpoOXR5UWV6VHVKQ0NEWVluVC9IZFhqekh3Q1hDOEtNckVudCtvQ1VQ?=
 =?utf-8?B?bzNZTzQ2Q1ZibTJzUFE2Vm9rTmRFWU1rejhQeDU3eHlrMHBsUlZtYTBGVnFC?=
 =?utf-8?B?ZWJhNGJTeVVXNmpQY3NSc2VUMk4vSHZkNWVTTEJ6N3E0eTRSYW1XS0NxMys3?=
 =?utf-8?B?SDhzYWU2cS8wSmcrNjZIUnovc3hXZkh4YzEwc1VPNTZranUwckJPWmNzOWY3?=
 =?utf-8?B?S242YlVvSUNlMllkVmdTMSs4OTF3YzFxZktpWER3M2lDNzFyZWExUWJmNE5t?=
 =?utf-8?B?RHBna3Fqb1JpZXA2UVEyUGxxc0orUzFHMTZhSnJHdG5IZUlSM3hRK20wdFNq?=
 =?utf-8?B?bmRSWWVuNDF5QkhCdTVObEs4MUdGTDRUVHBDUjVaU0lYcVVjeWV1cGRBWTli?=
 =?utf-8?B?eDdMUEZrRnRlVGppdytGK0s0eVQyeU81QnZuaFR5b3RJeTBhS3ZRNDFkdnNY?=
 =?utf-8?B?U3N3eFlxVm1mWFp6bmVYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6297.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2Y0U3A1Tkl3TFlrYy8wQ0pkVE9GampDblhVTDJUZWloQnlYV2l4VGlOcnFC?=
 =?utf-8?B?K3VWWG5LVG8rcy9BT2pQSkNNR3dibXlNOTVLR3ZWcTFVcDNkNlhxVWtYNisw?=
 =?utf-8?B?SEhXYWtFWDI4cVhaa1I1MGRTRXlKVTlOL3lDbFB4dnVYUS9xM1FxM1hPYlJD?=
 =?utf-8?B?ZGUvSHJ0aDJuVC85ckVoUUJmNFZ3cnJIc2tkZ0J1dzlONk5hRSsraXlvTit6?=
 =?utf-8?B?Rml0KzduZ3N2RUM3WjVCem9hU1YwcVBhdllQOGZ3WEVOYU92anE4bHJmZENL?=
 =?utf-8?B?ckIxMjEwRFkzRVZyRE5TQSttWnplWjRQMU83OGUwM2JqeFJSS3hYMnlIeThv?=
 =?utf-8?B?ams1YlNwdG9HWGg0eHJ2ZDR0eVpia3Rtdlp1N3ZsSXdUMDF0RC9wYkdiV2dq?=
 =?utf-8?B?SS9nNjFjWFhYTkpIeGFhSlBibVZkUkw3Y2lMajlTK2pOcHFpajRHeEpOaTZm?=
 =?utf-8?B?YldKSGJ3aWFUdUs3Ni8xbkV6eEV4eVEvZ1Y1djJNTnJlOGdNaDI2ZHpYL21q?=
 =?utf-8?B?bzFjQ0JFTWhSTTNNb1g5WjZUa0d6WnFuVTZueWFpclk5Y1hQT0p0bk1TRHFq?=
 =?utf-8?B?Z2JzM05rV0xPZllXa2s4dUhnTUQ0UUJtYTBNa3dOc1pvbjVqWHREU09jMUdS?=
 =?utf-8?B?YmNIL01JUE05clVGRXErNXBtTzN0TWt6NE9qenN2ajdPeVB2NFVOaXNwd3pQ?=
 =?utf-8?B?bDA1Vnk0T0Ruc0ZQY3hoZU8zdkhoNTVxUnh2N3BveTRxRzBVTVpKRXlmaVdr?=
 =?utf-8?B?cFZZSnBjcnJMOHNVNVpTSHprOGs0MktSbjhpakVOQ3gvRUtSNDVpZU8zcGZj?=
 =?utf-8?B?SGc3NW9RdW05UmJ1RU1VblF1Qi9yZlpoWVlVK2k3eUwvRlpsOE96L1hkV0Fk?=
 =?utf-8?B?dUJnY0VxOStKZGlqRjk2WmF1bXJ4RnNuUkxQTU02bndxU1Zka0FrNE8yOG9v?=
 =?utf-8?B?NHpZSFZZZkhHNWd3QzR4TTZlNm5pZTJCcW9TUXkzc0lMYms0VDRqUDFyNXBh?=
 =?utf-8?B?YkowUFJxQnVUeXNET0tTODhhaWR3c24zd0dqVGZzUnZheEVBSzdlMFBZakZn?=
 =?utf-8?B?L2Z0YzBsSGRsQ2k0R0JybXNGOXhFMFVkKzdvaHo0KzBmaDBWenVxNW1IRGli?=
 =?utf-8?B?bHJUb0NURTA2WmtNZlpPTDd4b3grekdsaVdPY2hTU1pKeVdqOWNvaXJadWVw?=
 =?utf-8?B?RTJyNExkNDFXcXJTTHNlclBaOWJwVUV3RFJuWVIrdVRuTlBNQ0ZJMGREbGMr?=
 =?utf-8?B?ajBuWTliMTVuR3BTQlNQZFJEOTMvY0dNZ1lORjhlekd3WGlkM3RTTHVoeTVw?=
 =?utf-8?B?bFJITS9NczgrdWhEWXh2SlhvMnUxTURteGx5TVlLNUlJUml4RDRRdkR3M0xQ?=
 =?utf-8?B?eXJ4L1EwY1hqbzlycGJLdTNIZ1JQZlkxSEJEaHczREptK0owbVFEVTJXdnFp?=
 =?utf-8?B?M2dBL1dkUkNOdnRUMUEzWU12WHlIK1UzNXlnMGFlOXMxMHVIZHVpcTNMQWlE?=
 =?utf-8?B?R0Z1OHIvT3A0Y0pqYkY0Lys1TGdlMzVwa21VRTEwaUJEV09PUDhIbzQ5SG9K?=
 =?utf-8?B?WEZVUXJMQVNaTDRNd0J6SC9EYjFoeHhTVzhJL3h3bG1KRUFyRTIra0M3T2pr?=
 =?utf-8?B?dmhVTU5jM0puSmRuK0NnSk1SMWpaM2gyY1RxZUtKSGk2U0I1UFEyQ0VnOWxy?=
 =?utf-8?B?Yy9nY3d3K2d2T1RLWndHcXhWNTdEQzdtVUdhZ0Y4anVaRDBaell5aFBZSHJP?=
 =?utf-8?B?RjU0anZ4VjhBR1NLN0NnLytrcFEwQlUza0pOQXQ5amRMOVdDT1NJNEF5QVZG?=
 =?utf-8?B?TDlUQ2JwSFZ6RFBKUy93R2YraFIwU2hQeGxFZTNRUjRwV2RlM1NubHRxb1Nn?=
 =?utf-8?B?ejJOL1Zvek1mWW9wMXlDb2tMZ0ZJYTlvcjIvQXI0Uy9zQjJuWkpJSm9Hd3Vq?=
 =?utf-8?B?blhtM1J3cHlCUytJLzFyaS94ekJQbHUycE55QldMVHduV0YybVd0TU95L1BS?=
 =?utf-8?B?bWRDbVpmbS9hU1dCem5nYVFWZUZ3UnBEL3Z1NVNubCtiK0EzWk9jOTVyQjg5?=
 =?utf-8?B?ZjZYZitxVnJHNi9MVjlteFI2VXlCMU4rK2NQZ2JKT2lDRmN0WEZPZGQ2eUdk?=
 =?utf-8?B?c01pOXZYc1liYmNYdmtzNE1rNXhhZi9Zc21SMmI5YzZGWXRrNTRDZlQ2bXdo?=
 =?utf-8?Q?aDZAUR3kyJdxkc3TH4TSBtU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e/uIbnIX9PBz78pUgD8PhYWHbxPljhMlnqk0ywuVQA83m+ZBFmSbv4yl+yN3lJ9QU3EV1kft4USBmlDbj3gCsX92Tqjyi6qleQeSJZZS32zbuiJ2FRTui337K2JDJnP69zqzYjGGhTIAMBsel/aAS1k0yE7+keTLfqPHN2qmyX0sHTjdpunvfdPsTSuC+tAsTuSbf6f0+vD3pfElysq6zlElG2+hc9RlT5FdixgwG/ZQjxYVIjhlhVcEoqo82mA2EZn7bGGiap7VrDOTEN4QQsJgHPTeEOSIUcQkEIREzhzN5CX5PtV1fkmBT9fMZp6Rgi/vKeF1qJNUlXNhJ0fIRniUDTSFEBWV/T4V6juTmx3ykAC3yPt1nbjZpK8u7grBuXbYISdzaHbn+OPaR2uQtOTo14QfbiibEvg/IIiToDW8oSdhi6ypgx1aS9ZiicBAN3fYIMqvy+7OLrXNCxrR2hHgKjZ8+kTXmrxu6a4GPo05uTswjGPZjgbRS/FORnJ/5ud2b/sV9Ew1eQcOva3zESr/tG8RLN0Be3+KvlCepoDoZ3f6BKtFM5nNuqY6miH/JCfmsJddnffLGvPDum/g22AUEtRQuvrOEnZLqeeRpuo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb24d54e-dc82-4b39-7407-08dcb2e72f0a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6297.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 11:35:17.8985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2PpO6divglwMrJTBfpPESQiMTF4Cn1io3NKW5X7aqBUFFxuoUKohY1aQfUTuQeFP6YT56DJr7CkF5TmUprV4pDyz1vLfTqMH8PZ7+ALWg4PbutgW/8R54pDFLzy32sl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_08,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408020078
X-Proofpoint-ORIG-GUID: pBJmdWK9OUEGVBGSFKfB6j88nzm29uqC
X-Proofpoint-GUID: pBJmdWK9OUEGVBGSFKfB6j88nzm29uqC

Hi Jakub,

On 07/03/24 22:38, Jakub Kicinski wrote:
> On Thu,  7 Mar 2024 15:59:29 +0000 Lee Jones wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>>
>> [ Upstream commit e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb ]
>>
>> Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
>> may exit as soon as the async crypto handler calls complete().
>> Reorder scheduling the work before calling complete().
>> This seems more logical in the first place, as it's
>> the inverse order of what the submitting thread will do.
>>
>> Reported-by: valis <sec@valis.email>
>> Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> (cherry picked from commit 6db22d6c7a6dc914b12c0469b94eb639b6a8a146)
>> [Lee: Fixed merge-conflict in Stable branches linux-6.1.y and older]
>> Signed-off-by: Lee Jones <lee@kernel.org>
> 
> LG, thank you!
> 
> The 5.15 / 5.10 / 5.4 fixes won't be effective, tho. I don't see
> commit aec7961916f3f9e88766 in the other LTS branches. Without that
> (it's still correct but) it doesn't fix the problem, because we still
> touch the context after releasing the reference (unlocking the spin
> lock).
> 

commit: aec7961916f3 ("tls: fix race between async notify and socket 
close") is backported to 5.15.y as commit f17d21ea7391 ("tls: fix race 
between async notify and socket close") in v5.15.160

So I think we should now backport this fix e01e3934a1b2 ("tls: fix race 
between tx work scheduling and socket close") to 5.15.y ( this also 
fixes CVE-2024-26585)

Will send the backport to stable kernel list.

Thanks,
Harshit





