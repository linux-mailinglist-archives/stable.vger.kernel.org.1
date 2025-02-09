Return-Path: <stable+bounces-114453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB21A2DEF6
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 16:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377A23A645F
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E6C1DF749;
	Sun,  9 Feb 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K0P+lqkf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d/19HCOa"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085911632DF;
	Sun,  9 Feb 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739116660; cv=fail; b=Strpp/miOZVs14nlnx7TGfkLkgsUYC34DVgXIiWnl4lrBRkpGv2RUCegkVCqoU2L4gYx3Oz7VL628svc9s2sfV9YJeR5zcSltR1H93gw35lWD7uwKl6ENiC10k4DonDd9IyfPnHKtJjUh9YggDg7T4mwawD5zQQ8i7WY4Pv3Wdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739116660; c=relaxed/simple;
	bh=lY+OTT0gy36dYltJUdgGL23K3C9pM0f8hC//RxChsWQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MGu2XlgrL5HjHcMXN1gAvNEiGCMKVf/FnAzDmlNfJw+rP4slwAia5Yj2o+nZTTgXedhn/Kj/0jlVGS5sRJVA/6x4sUqSi1F10oQD3VQyiMTH3nAPRW1iUt+kJ9ns6UJenGYxFsn9EKhqcK6an3OMT5jM0qEZKbIqzCPgKMSxZYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K0P+lqkf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d/19HCOa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519FMwce004284;
	Sun, 9 Feb 2025 15:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=lR61WeB3dOcwpEJqXyg22ZnVksXXv8lLumjoGc7biOw=; b=
	K0P+lqkfe5e5tz6huNvHOO8L5W/smVFuwX/bjBGKIjfCEyMUCPkPAZ3To0vlWEZx
	l7f4tgk9hdRe4ZeDsduo4V4Kv1mic8eXOLEC5+t3JMRLYEtN9TfgGprEOLliLfFI
	6dWqjfTHHiFJ9uH9QYl3DZ/9vvpMTq2930mvvn4KgWX8BjrGWxDrXUB1lXrahDaj
	31SmKiU7PZuDdN0oNSZGcB0BXBj6PbNN3u34u66Am8wSUm6XoOtwnr00hNOOWT+e
	wUT2Xspl6fA2kxgGNlfTsleqjNGcDL9+oxz2saNAdS54zkhHasdFxsB+8IIRTdja
	MtGCZ6SEuE1VQGpCZF0YNg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t41rc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Feb 2025 15:57:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 519FoLOo012403;
	Sun, 9 Feb 2025 15:57:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq6j5pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 09 Feb 2025 15:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/BT5KBKvB5AXbpSpVQ2iY7bklnS1xksCuQyw58StMH3WaaWTKgSK5qDQcLMzRq95m2BUlLqQ5h4vpNfWEZUC2Ls84UsvW1NjBWLNCxlkn3j+D5HYoONMdhUmj8CKI+nsniCxrjMkNe+4k/omlp8AaPTIr8VFDS0kSyT43a1veIaYYglgFee3Q1Obqil/t+j+Id4Yal6qXaeWossco1PfyLlsNocAfjt/vWIMOydvwc73VqgS+k+B+bpRnQt07Es68oXTGDAwTKCJD6o69C6UU6hAFMtqYe1n49BxFi/21UKDY7xLWx4DB4cks6O13a0Ekc9ud16LEy+qTBuwWVZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR61WeB3dOcwpEJqXyg22ZnVksXXv8lLumjoGc7biOw=;
 b=FBpFdtIw19CGZHrUwSk64nSpwEQVCT7cwi+XmcMvockcFYWjHZ6w1Jwb8TdRpZaonPnlQhwE/UwKSsRWSOCIxbw2ujplmg0ng5xlNXxfltFG+mTJNY2ieg6YjPZnZ0Lb8pqycKxhsGVsh7/JyIljLE/PWougHSn13Ak9/gY0SKZnoceOfLQSmYqKsgXhOp4Pa4uo8b6e/RDwS3fYfmfzbiy2LyvhwkI0PNbKo2aESCkSzyhRMgCW0KaM08YInd+oT1Z/VsDUCpOjNuNw97H4ICjUv6TjlvWGSrsb7JNp/ma4SeoONxdvh/j6a+EP0h+w5EqWqb2U/sO3TVQ40DJ8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR61WeB3dOcwpEJqXyg22ZnVksXXv8lLumjoGc7biOw=;
 b=d/19HCOaaZZGm64L2q4M+KdrpEmWLdtSgD/9YZU0U/g5HwzROPUZ2nrkpxc0I+jatkqwpDzAm2iVN60kiUGmIHhJa3ciZk/E276Q/ksAZVWPKr98Ep5rRO7TnOVA3C3q0ZhSKm9OOhGPSBf9q+zInA+hEYnXQUDvR/8RbXvc0Tc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sun, 9 Feb
 2025 15:57:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 15:57:19 +0000
Message-ID: <0c84262b-c3e2-4855-9021-d170894f766c@oracle.com>
Date: Sun, 9 Feb 2025 10:57:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: queue-5.10: Panic on shutdown at platform_shutdown+0x9
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, "stable@vger.kernel.org" <stable@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <231c0362-f03e-4cef-8045-0787bca05d25@oracle.com>
 <2025020722-joyfully-viewless-4b03@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025020722-joyfully-viewless-4b03@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB7243:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe0b5a9-791d-4a3a-90f6-08dd49226ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1cxV2pueUhHR2dpL3NjWGV0Y1dDSGNqMk9KditqNjlJTGlZVGx0M0VvNHRq?=
 =?utf-8?B?a005UEloOTMvZzljQzdRZkxqbkZWMUtkYzhXZUJkRFh3YWJ2NGg2R1hTbCt4?=
 =?utf-8?B?UUpCRlFEajJYWWhUMU1za25BbEVuQW9ra09iTklsckpYekdNdmlOcURPNFJl?=
 =?utf-8?B?VlFHNUk2OXUyNUhUWjNxNUtrVDBrQjFFdUJ1aU15MkNTTnQxZEhzUlFhMjI3?=
 =?utf-8?B?SVBWMyszMUZwMHVzS0s4REIwTGRrcHV3TTFHVCtKSnk5VFROSmNxeXVYcVNB?=
 =?utf-8?B?RmtiRXp2ajNJRkJ6bUUxcWsxdy8xS2JDQmNPRklOeHh4RHNBTVdDbkx4WitF?=
 =?utf-8?B?Z2JscWdIeUZpcndhSnNKMU1vYVYrNUZ3WGNydXp5WS9xbWNOck1aWStneG9P?=
 =?utf-8?B?WUluWFJxcUVPR1NXZG96WkFKbVVMZWNiVjFPUFdBZkRWYTNhVnQvNm1PSG5o?=
 =?utf-8?B?MWVhMXV1UVlqeElldmVRU0ZSZWZWUm1aeVByVlpjZWdTSWR5eDdvNUVmdElB?=
 =?utf-8?B?aEpLOHFXdjgvNTk0SzJKNy9nK2N4RytLTVRmb3lTS2RaWjRIejhPVzVOUERV?=
 =?utf-8?B?RE5scU9PaXVyQUt3VVozaU44UGJjMHo4TEVwQlVTZFBjTVVMdnlpeFZabllT?=
 =?utf-8?B?VTRSVTV5TVdUakdqclJobFJlRXduOTM2Wm5SbDQzb21CTDhFL1B6bkQ0VkdR?=
 =?utf-8?B?SU1sdXpoNG5GRFVTaU9uSWdWWkUvK2c3VjUvNmNSeFpJQlE2dkNNaGpyaDZn?=
 =?utf-8?B?aEhubjYxL0lOUlN1RlArc2ZURVcvbUxRd0Z4MjFLaG9TWk5lTlJnSFBJbGoz?=
 =?utf-8?B?QjlEd0ZtaHYwK1dPT2VlcEUxdXRkeGE1UUlzUnoyZnNuRUFwOGppUFlsU1dX?=
 =?utf-8?B?akI4TVBXZWc3dkh3UjBnZTlsQi81R3doc0QxaFA2TjJBcXZSbnduWDhRNmhj?=
 =?utf-8?B?dDVOM0hkOHQ0RlV0QkI5Sy9FS1FTdE1VZTVpaTZmU2liUTVQSHBWUmVZNFNs?=
 =?utf-8?B?aTFVSW5UOGowNU45RjdKUDgrc3JPSFJwT2VHNDZqd1RTQnUrOGZhTlJIVzR5?=
 =?utf-8?B?bXRLZnJZMkdLK3l3SVNUOWp1MnFYYm1ETEZzcjFVcUtLSDRWZlZKaXZRUU9h?=
 =?utf-8?B?dkNOZVo3R25hQVc3UXdFa2FYUWFJSWRoeXYzM3pJbUlSMVY4YnNtRXRuV2RG?=
 =?utf-8?B?djQ2M2lDSDJLMDkvTFNuOEFVTU16ZDRJdUNJNXhQa3VqUXFtTjd1YXNacWdh?=
 =?utf-8?B?cTJBRTA3UDFoRVdOSEFnTGxraStFVmFpMHVEaXBCaVdZWk00aGczTnJlUDRN?=
 =?utf-8?B?R3pVTXZrMmNhaGh5VlZhLzQrMVJUeWdwOWdNN3dPVjlsbFE1bG8rQ3Biek9K?=
 =?utf-8?B?QXRMTDVDMkVFTXhxUzJWTDUyblo4ODBjL3NUNFViajdyYkFlL3BGYXp3K0FO?=
 =?utf-8?B?aFhjSmtNZTlBeTJ0czFrdzBhOFl3dzNBZ2FWbUtIa1NsSVRGMm1qZkdzQUJI?=
 =?utf-8?B?RTVrU2FWVURSemhxR04xZSttQ016ZGhLZVYwRWNYRHpIUElNb1BaMnhpK1dw?=
 =?utf-8?B?bkhzNUZUS05leFAvV0ZnMW9Eenh6WEdQWTdPUEV4aUlrUDRlSGdiaWVLMkZO?=
 =?utf-8?B?VE83MTdQN1JWdmlWNHZhMkNGN01SZzQ5ZURqWTZQWU4xd0JTRDV5cWVDRG9x?=
 =?utf-8?B?QjhBWWdwTUlnRGNVRHZlQXZLUUZ5Y1VYcnhKUVF0YlB3Q0xNeTJFeUxpY1R1?=
 =?utf-8?B?aFNwRmpQQm9EMDRKUUhwc0dGdTRQYkZzbzM0bkVqbTUxdmNtd0E2bDFEc2Mw?=
 =?utf-8?B?M1NydER6SzAvMG44U0JVOW5kQnA5SkFiSklLbDNNSndQMGg3NFI5OE1rQ1Yr?=
 =?utf-8?Q?VzTlkFkaji8Qb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1dhWHdQRUNiOENxWDVXZmhjL1ZQNjJmcVhVMkRORHVyT0dRNlVDVng4ZVl4?=
 =?utf-8?B?QlJtaERLWWw0amlzdkhqSkwwVTluRnFJYVl4eUdOck5BZEc4M25DN2VjWk1m?=
 =?utf-8?B?aWN4cHphVmExVXhOQUU1UHh1UGI3ckI2cGNvTC9PYkZxYWJYL0NmZUlNb3hn?=
 =?utf-8?B?UzlMVEF6bHl1dmhBLzRFaFdBRkE4aFQzZzNzVTlPYmdvNkZFUTdzcnJ5WkFM?=
 =?utf-8?B?eWNSWHovTzY3ZzhhNEJDaEMyNFI3U1hlM09uczhFNklrRGIvSlJYVEszQWRs?=
 =?utf-8?B?L1MvSzZvWjkramx5NzFjSnNEL2dvQ2Faem1MWTVyY0ZSNk9ZNmg5czJJaWpj?=
 =?utf-8?B?MHJoZUVxQ1E2UHBOaCtlNFJpejBwY1NFRFdFckNUSGdvY1dVNnd3R25FUHlZ?=
 =?utf-8?B?ZEYyNHVSQmFuZEhGSWZxejVhUXFrcUxHRmp4TEdrYnFzR2NKaWZESEc5TFpV?=
 =?utf-8?B?K1pHcXh5ZHRBVjhlR21oMWFnR2kyWDU2dHZoOXZ3NXBrQ0R4QkFVTVdhbFdC?=
 =?utf-8?B?TWRTaVlPS0dlMUxwYzlac05nVGVWeEw4OC91VmVWSUh1QWV4ZFIwZmZRbjQz?=
 =?utf-8?B?Vmk5TGF5V1ljS0FOcW5EVUt4c2FlSHZCSnVxZG9oTWg5RlhXZkxTeS95Z0d3?=
 =?utf-8?B?cm5DVXdCME16TUFJZ0dXMUhjTlZvQ21iZGFBcFM3V015ZUZXUXhoSnZrUGJv?=
 =?utf-8?B?YTRGNjdNMStjUy82L0R6UlI2eUI0b1UvQlMwL1h5M1NSTmt5UzM3UW1XUWpu?=
 =?utf-8?B?L1ROT3BEMGNhbHllLyt3YjI0bmJGdXd3VWZEd1IwbmRJWWNPL1F4dEpDNm5n?=
 =?utf-8?B?SmozdW93bzB4MDA3QVNmVWpCYnBmTndKK0hGN0szZDZXTVM4REdYS2pPYTBZ?=
 =?utf-8?B?bDFHN1dQb3ZoaVI2dXc0UTV2enlUemhteENTdnNzcWxJNkJSK2s5eXozRnV2?=
 =?utf-8?B?UEVDTFlHdnllRmFCSzdSSHVmZXhyOEFWOEs3YVZHc0c5cEVEQXRzdXhNUGhs?=
 =?utf-8?B?LytUdEt6Q0J0UmVLcW4wbVlORkJoV0tVN2kvU2h0Rmh5M0xmN1Mxa3l3SUQ2?=
 =?utf-8?B?UVZ3UDhud2kyejBXYWw5czBSNHNhL1Zta0NMNDlBZnRCR08zdFJjM3A3dXli?=
 =?utf-8?B?V3VpbHFGcHBwT1U3TmhvNzF2N2lDaDhJOThQc0paaVdjOVF3dk5ma3gxVFNG?=
 =?utf-8?B?YmUzQlJnM2kxODQyWURMb3M2cHloUWh2NGljZVlFeWg5Ynh1UFBxb3UxSW1D?=
 =?utf-8?B?T1BIbk9nQVc5Vlk4SVMxYURZZHBlTkFNa2pyMnZCLzV2b3ptRm1VM001eDcx?=
 =?utf-8?B?cWRyUzJDM1JmMmkwZHJZUUxRZExpalBNR21OczhqaXBVcGJWRTluSUc3dy8w?=
 =?utf-8?B?TnBoS0pwbEZaWEFBM1VmZEkrK0VGSElpQzVnWUVYaU1pSXRCTWpvQXhrcUcw?=
 =?utf-8?B?bkg0Nkl6SEN3SGRKRGFMWnQ5VzFsamNMY3F5M2w3Z09yMWJHVmRpWnB5dGtU?=
 =?utf-8?B?NUVKWUR3YTU5eldDR1NhOTNHTXlsenFkSmdmNzBuSERTSmtZTkdjbEcyem4y?=
 =?utf-8?B?WWdqMjN4aExPeUtwVGx6QkJqU1h4ZHNsalNBblhCTmRQN29hamdNRGxpQkFv?=
 =?utf-8?B?a1lnclR5Qzg0SU44RjBuNTZpMTBON3hvQ1hKWWpUaWQwNDhMZHhpejErb0Iz?=
 =?utf-8?B?TjRiUG96NmlCKzY4TERaanZKckpkaU9ITGJwL1dlZDJEK3d3NThBUVIyZUNS?=
 =?utf-8?B?aDhyTGM5L3Z4bXUyeWJnai9VUDFhazJ5UG02WjZFYUZTcFlwNE0xa01sV3NU?=
 =?utf-8?B?cFlnTWRuU3R6OHlhT1B6SWxaQXVKWnRtN0dRT1hKRkJBUEM3TG5aVWFRT1VE?=
 =?utf-8?B?SnE0dDdKbjhmNTNPcSsrdHNpL1lOSW1RSXB2Q2lUMXRuU0YzME1hS1BQNVR6?=
 =?utf-8?B?R1NveEphRVUweldUQ1o0UjdubEdPNmRQVXFUSHJFUUpmYkc5NUE0bnRnamFQ?=
 =?utf-8?B?UjhlU1hRUkJtenNXc3AvYU5rcDkvRW1WWnlXa3pwZ0hmeXVQeHdrTGJLOTdh?=
 =?utf-8?B?ZzdSY2lQNk5iWk5LMFdzMllDdmovZUlGMTlGWUYyTExWZmluYUN0RDNnYzh4?=
 =?utf-8?Q?LNEhNwPY1s5bngjl3QBg4vIRm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ru3vAdq+om+/OY50glkLWUWd5BxQon/ClpOg8p7Uon5hoUcRmN8cfOHKoePmNr8oi4Mg4zmVHiyiP25BkwjrnRZ1yC0FPLLzOrF/lilNEKe8wTrIOxyybaa15PPUCk8l/57E5RASX9mcTNfU7xlgFLLF9e12Iz8Pkoj2fx75ZX6q7JmhsCDPUSPK8NqgtC74TH6HLWUgYkppM1BloPVzREzM5oCdGlDZB1LPjGkbZg9kFqCT1v5IbhIkTVnbwUAPyvyWNl+y8RDvl+1X3cO3b7dHQq/cQlPWta+a/+COQcmUTc/fwM5Cqe2urNHgYVAQEGZG4eEnE/JphTKGg4sc3PFpcqH6EYnGOaSSnOebaZX4Cq40vrlMjAC9YM5Jb7usnsFzcGcCk7aP9GkzSFqAJ/QA1L+oOjkcoLBWAEeBr0E2zC0+Sofp+nC6/Hj47Ui4mLngtTGfxGm3Tljgteiski2oGrD/xtpJl1DwJNMccXXAPcC4GrHDGQK65yGe62r5m2qRiykaHSFysrWlJm8U7ab+GOBy65WqxDMbcEOl3xrffMjh6M4xhourjQwQIc+Ww/CDvHj8Mch3YSeJnMAAgPTxJrQm41sQVHroEOgrsoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe0b5a9-791d-4a3a-90f6-08dd49226ed4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 15:57:19.5132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7XQNriDnZMZMUHAFhiHzNKhLnpMiU/tZdFBMe3Zg2MijhJKSwcTCGzkdb7AWQJzPANibSsrQVUey18N+fmrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_07,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502090141
X-Proofpoint-ORIG-GUID: ipFk8D7rBCk4pBEegaV-rOuVtDvNKUwA
X-Proofpoint-GUID: ipFk8D7rBCk4pBEegaV-rOuVtDvNKUwA

On 2/7/25 10:10 AM, Greg KH wrote:
> On Thu, Feb 06, 2025 at 01:31:42PM -0500, Chuck Lever wrote:
>> Hi -
>>
>> For the past 3-4 days, NFSD CI runs on queue-5.10.y have been failing. I
>> looked into it today, and the test guest fails to reboot because it
>> panics during a reboot shutdown:
>>
>> [  146.793087] BUG: unable to handle page fault for address:
>> ffffffffffffffe8
>> [  146.793918] #PF: supervisor read access in kernel mode
>> [  146.794544] #PF: error_code(0x0000) - not-present page
>> [  146.795172] PGD 3d5c14067 P4D 3d5c15067 PUD 3d5c17067 PMD 0
>> [  146.795865] Oops: 0000 [#1] SMP NOPTI
>> [  146.796326] CPU: 3 PID: 1 Comm: systemd-shutdow Not tainted
>> 5.10.234-g99349f441fe1 #1
>> [  146.797256] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> 1.16.3-2.fc40 04/01/2014
>> [  146.798267] RIP: 0010:platform_shutdown+0x9/0x20
>> [  146.798838] Code: b7 46 08 c3 cc cc cc cc 31 c0 83 bf a8 02 00 00 ff
>> 75 ec c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8b 47
>> 68 <48> 8b 40 e8 48 85 c0 74 09 48 83 ef 10 ff e0 0f 1f 00 c3 cc cc cc
>> [  146.801012] RSP: 0018:ff7f86f440013de0 EFLAGS: 00010246
>> [  146.801651] RAX: 0000000000000000 RBX: ff4f0637469df418 RCX:
>> 0000000000000000
>> [  146.802500] RDX: 0000000000000001 RSI: ff4f0637469df418 RDI:
>> ff4f0637469df410
>> [  146.803350] RBP: ffffffffb2e79220 R08: ff4f0637469dd808 R09:
>> ffffffffb2c5c698
>> [  146.804203] R10: 0000000000000000 R11: 0000000000000000 R12:
>> ff4f0637469df410
>> [  146.805059] R13: ff4f0637469df490 R14: 00000000fee1dead R15:
>> 0000000000000000
>> [  146.805909] FS:  00007f4e7ecc6b80(0000) GS:ff4f063aafd80000(0000)
>> knlGS:0000000000000000
>> [  146.806866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  146.807558] CR2: ffffffffffffffe8 CR3: 000000010ecb2001 CR4:
>> 0000000000771ee0
>> [  146.808412] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
>> 0000000000000000
>> [  146.809262] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
>> 0000000000000400
>> [  146.810109] PKRU: 55555554
>> [  146.810460] Call Trace:
>> [  146.810791]  ? __die_body.cold+0x1a/0x1f
>> [  146.811282]  ? no_context.constprop.0+0xf8/0x2f0
>> [  146.811854]  ? exc_page_fault+0xc5/0x150
>> [  146.812342]  ? asm_exc_page_fault+0x1e/0x30
>> [  146.812862]  ? platform_shutdown+0x9/0x20
>> [  146.813362]  device_shutdown+0x158/0x1c0
>> [  146.813853]  __do_sys_reboot.cold+0x2f/0x5b
>> [  146.814370]  ? vfs_writev+0x9b/0x110
>> [  146.814824]  ? do_writev+0x57/0xf0
>> [  146.815254]  do_syscall_64+0x30/0x40
>> [  146.815708]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
>>
>> Let me know how to further assist.
> 
> Bisect?

First bad commit:

commit a06b4817f3d20721ae729d8b353457ff9fe6ff9c
Author:     Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
AuthorDate: Thu Nov 19 13:46:11 2020 +0100
Commit:     Sasha Levin <sashal@kernel.org>
CommitDate: Tue Feb 4 13:04:31 2025 -0500

    driver core: platform: use bus_type functions

    [ Upstream commit 9c30921fe7994907e0b3e0637b2c8c0fc4b5171f ]

    This works towards the goal mentioned in 2006 in commit 594c8281f905
    ("[PATCH] Add bus_type probe, remove, shutdown methods.").

    The functions are moved to where the other bus_type functions are
    defined and renamed to match the already established naming scheme.

    Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Link:
https://lore.kernel.org/r/20201119124611.2573057-3-u.kleine-koenig@pengutronix.de
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Stable-dep-of: bf5821909eb9 ("mtd: hyperbus: hbmc-am654: fix an OF
node reference leak")
    Signed-off-by: Sasha Levin <sashal@kernel.org>

-- 
Chuck Lever

