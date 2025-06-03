Return-Path: <stable+bounces-150684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDDACC3C2
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 11:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BF2174295
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BFD283131;
	Tue,  3 Jun 2025 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KEer7yBd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="v4p/RYDo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F827FD5D;
	Tue,  3 Jun 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944624; cv=fail; b=QAek8PSzYZUz1iH9Ut8Kt0DSyRIoWOuZSxkfuo4ppO4eq8bxDY5+dRvtWod7FbZoElEubwtfEadilJzsWmBwjdVfVvxJCWLwaDqYBf45TsCaKeD5Oum9LVoL4eHT7j9iDbKWnlKAe01r5rQW65UP1zT812Pt+MLnItcyUrLrv08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944624; c=relaxed/simple;
	bh=2rBYXsSI6NPvuP79F/OTvrSKW+VBtNvoFnRXTHSfxJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BVcgAkxS8wQBpvqohmUIDjwkjXbXTZkUydJuBuoPN+2G2DH3yJv71UbU3cbpbYf0LuB3Ksg0AeVZohm3916mjZsN8UOULTJPY7e4yippJ4ZacnLBcXDd1j/hWNT2JuBYK0LMjJ4tnHxPtIEHYyyVEt0qo8/8ImbEX63AD3qes+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KEer7yBd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=v4p/RYDo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5539rREM028453;
	Tue, 3 Jun 2025 09:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sAAu8bWicAEUoqZwlNEDlY+vlzqwAneDzgyKCGDRq8k=; b=
	KEer7yBdVQTvvx0eUh+/qZmQDkmjA1GHGISVtIbOiOwykEaV0psQt0eghBkrYfAg
	Zb9/yvEAICQX8J6OS1GGJ1w7xcCS6ghfsulk4cfWgEo5eBEQ2FS2wxn5pBzL8eIC
	pwJAzC0Gvt8yAWrFYg3UXY7vBk08l5O68ghWX8cK5Ua6lgwkYctKCEBVqEZLONcr
	3MrN2fxsM3r1aq5uplkps4QG2D9aYAAi/TKtIku+pjjz0FmmGXBTECR9kZpDTmJr
	7/GAI/O2JDnBn+xvIiMYBTeHMwlTG6xunq53dJDeHXIXQlxfxjf97u/7Fj8KLSD9
	18/Jsqm4KE4EPKGXWnFPGw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8g9hax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 09:56:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55380tNc030625;
	Tue, 3 Jun 2025 09:56:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7934x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 09:56:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyqF2PTYzjKl6GEdzQwrLi6muQCL8SFZoFStM46SenuWqE/n0RaOiuES0EM5UDmPhBPjrX7nUf1beJ/2Xolo/jxdmXZScMIeC9oVzp/10F8PqEQ0A+PLfl9D+LxjqEQgNXhN/ul7xBobH9013/mAYzy+wTDtB+fTMXY1T6PkDC+90vmseYP6TA5K91Z0fhKsLw/2PDQxKr0uKuLbDD1FFuTICkGWTLeta/HXUeN9v5KdhueosJtlFPW9TqhS2LGgrep0troLw3e80krxPauGdM1AepKx3bWLHW1YJ5Grs64rJ/VdHYS44C/eNXXIcg/NaUFJyNVPxh8Ercm+UscnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAAu8bWicAEUoqZwlNEDlY+vlzqwAneDzgyKCGDRq8k=;
 b=JeCcZHbzJA/PnpL2jz/poKm9fSErPPteTwkCw7nEOXVk46bG/cZGSWAI3/psq4FLJJuZxUjXJhCmVyQhRzUi6JIupj9WBFQCLfcGxqMyxWODgHMYRfY/iHpkqLEKvKMnQa6sXw1jvs1F1nJfgbgSo2iHN9l9qQOSPeJFh1WlzU/fS4J88Kuf/79DUnEd9KxmJiqO1r0YmOf3vQAN65LSAXaEPF3U0v1q7mTLuwOHF75WDCBH3fHNifrSsuM1R/eJrbYw4MIs8D+xqUu+2XYQJy013ldoEzygsfSXOfdQWDQvHGALJhLy9KKuPAmlbMkKyTlA7+bhFFKoHWL+4OfMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAAu8bWicAEUoqZwlNEDlY+vlzqwAneDzgyKCGDRq8k=;
 b=v4p/RYDoGg6Km9fEKNJc+y+lEK8oOxB4cf1ZhrZyJKm2lSr6F/HswTySFgddQKG2wrtS1EzlblH+MK/p2+5SCCkXkPT43BlgdPklKjtu2tTOfRLpeQL+ex6v18lmnBWwVk5sHz6Xb1/1cUt05ip1MXiaCyL9BsbJ+8rpBeCtTso=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPFDE34AA4C5.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 09:56:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Tue, 3 Jun 2025
 09:56:30 +0000
Date: Tue, 3 Jun 2025 10:56:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        pulehui@huawei.com
Subject: Re: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan
 during vma merge
Message-ID: <fbdc12c8-762a-4ed6-ae44-a464494b9ef3@lucifer.local>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-5-pulehui@huaweicloud.com>
 <9117d6d8-df01-4949-a695-29cafe7fe65f@lucifer.local>
 <c093f0d7-58b2-492b-bba5-5e1007a78056@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c093f0d7-58b2-492b-bba5-5e1007a78056@huaweicloud.com>
X-ClientProxiedBy: LO4P123CA0651.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPFDE34AA4C5:EE_
X-MS-Office365-Filtering-Correlation-Id: efa10860-eb1f-41e4-18f2-08dda284ea18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1lyN1YxN1psdGk0UkFFSTR5UjZZbzROa1hDQWNwV1d6L25tamFQRWNRTTc3?=
 =?utf-8?B?OU9OemppSU96YnhiZEtseGZsdWRHQ3J2TGhMWlhFVWpNb0lmRVFBdFl2UEYv?=
 =?utf-8?B?L0pxRmNIaWt6M21uaHZzNTlQWnRFSjl4WUtoM3V0S1NDeUw0M2RtdDZOK0dZ?=
 =?utf-8?B?VVdHWXBmdC9UaENqdHVjb1dDbytJelpRNGNhYitjUjdPNW5ZOWF4NjlYN05n?=
 =?utf-8?B?dWdRVk40VFdCQ3lnY1NObXFmTEM0MXlvU0d3dGFIcTJaS2F1d1QzUlpjSmZR?=
 =?utf-8?B?RGxLRjBkbXFOa2FqckN2aGhSenNibHptbzJ0WWE4NTUxYkNmOEs0bC9jMDIw?=
 =?utf-8?B?S2tZeEFRK1J2TXR6bDg4TENHdERzTVhvY1R6cldrT1AyRUdYUEhQVGRvWUFh?=
 =?utf-8?B?YkdZbWR2UXdjT3pTbzAwUCt1QlMyNzNtbkZZYXRIZkp3M0FreFovK1FrVlhy?=
 =?utf-8?B?M3dxVmNDWm40bDVTdDdENUl1d2pCR2xzTkFVZFRQY3MvQ09pQ2pDd2RIQTh1?=
 =?utf-8?B?MDhocW5lT2NIOEFCMjY1R1JqZ0NjZTQzMUpieHNEVlhLQjZvS0Zjek1ZRnpU?=
 =?utf-8?B?V2RrdWY1MEFkOXpQb25jNTlXT2hsUVNPNWkyRHRRanUvdjcrWHc1V0VMNUZu?=
 =?utf-8?B?TnlNaVdjREY1VnlJWE8xMmNhZGNFY1ZaVTJ0SUx6cDFHRVZESXlvUTNBcGh4?=
 =?utf-8?B?cldyeEpGZmZ4dlZvMUtMVU1wMm91Vyt0Sjh3aDYwbjFXL2pUdFd2cmhoSVlI?=
 =?utf-8?B?bVNQQVZtYS9YL1FwUjF0RjhCVVIwVGs4RXpUNm8rTmhTNkVtWm5nVUlyMlNs?=
 =?utf-8?B?Q3h0TVo4QzZOcWlmZEtNa2NlVGFhUnlXQU51d2JoY0YzcCtSZ2ZWN0Z5S2Zu?=
 =?utf-8?B?WWYzUUdmOWVORk16aVRkMWl3ckxwSzV5MWF0eUVsMkkxQlpoNVU1V00yKzQ2?=
 =?utf-8?B?NkhjY0N4cTJEY0luYTZraC9nUnBwREQzb0ZjejhNc2RCOVVQam5mMTBzWmVu?=
 =?utf-8?B?d1NYd2JSa3FURnViTEs4NGJPN0lDOWQ5OGtxdU1DRFNHNjNiNk1ocVpyZ0lD?=
 =?utf-8?B?dDlwdGZtZlhGV25BSG5xWnlvNWp2NVR3RCtwZDlaOTA0dkswUWFOQi9uSWhB?=
 =?utf-8?B?R1hIOWpWNkJLeUx1UzVoaUpJSUFLSHhlVDJqeGpObkNEZEVidUxTMjc0S0s2?=
 =?utf-8?B?TTE1dGlaZ2JvWis0MnhRRCtlZm1qL1NjVkhkb3poci9ySTlZV0YzOEVsUERN?=
 =?utf-8?B?QTcwYjJUOWZTUUxzWEhnNEpJY3FrL1FKckZCUit0QmNCai9OM3Z6NHA4V3JG?=
 =?utf-8?B?RDlZMGQ4aVJTdFVDTEp3OHVZTmY0U0hrUVk1VXZWc2pBcklSS3V0c3lsSjc4?=
 =?utf-8?B?ZkthVjRxamRPZUZJdFpRc1ZrWjJiRDZrY3Qwa2cxK2sra0EwcU9zYnVyRzY5?=
 =?utf-8?B?eUdLalhwSjRnMEl2VDh2NWI5eVpVb3NVZ01TaU92eENzcmF4VXBrLzJCVXR2?=
 =?utf-8?B?U1E4ekFMZkx4ZHpnYklYdUZXeFVUQkloemxqdXY5UFowaUx1OFhHZ3MyVWxv?=
 =?utf-8?B?U2FyU2lzOWsrckk3aFM0S0RTUVlGTWl4ZkIxa1NJZ21sSDN1WXJXb2NRa2la?=
 =?utf-8?B?elVPVkhkR1lzK3EwYXZreEU4aHhTcUd2cU1zRDE1Vys2bFhPdWVmQUEzMW5C?=
 =?utf-8?B?Z0haYVpPVmV1bG5kWFJxajJNdlVIcWJpamxWQy9NTnFjaDdwcU5BUjd5eEFw?=
 =?utf-8?B?ZkVMM3FKN3pVaTArM2ZMa201QWptY2tOY2lBcDFPdmM2cFZZYml4RmVscTBq?=
 =?utf-8?B?aWNlTjYwNkE2UnBOWjBrWnAzd2E5VDd0L0w3a1NuOHdNT0NwVTVLUWk3c3JH?=
 =?utf-8?B?WW9pWk5rbzVYOGRnWit1NVZLWGFYYStUVW02NUthOW1OOHZ1d0pJeUZWTTcy?=
 =?utf-8?Q?TG8LUOe47ig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGN2cGNjbGtSdzcvd1dsUjROL2xYWllxS2NrZ2REdFlncWlLdnA2YTA3U25j?=
 =?utf-8?B?bCtrNE5kMytpQ3NhMU1SWTBtckxVb1JEbi9rSUUveUJLYTB1KzZJL0c1eHBG?=
 =?utf-8?B?TlpraGZYN2trbXJqY1R5cHZTQUdpaEJCNlRwclkzMWlHRHJjOGtpRU9OOGZk?=
 =?utf-8?B?UktvUkx0TWhuZnUzYWwzREFPSHB6bjV5SE45UU5LWXdKcis4S0lqMmRsWVc5?=
 =?utf-8?B?N2syT08xR3JKVzRzV2FRNUFmS2ZJeXRrZWVKK1dhWUZtRUZ0YXlSbHluazFC?=
 =?utf-8?B?K2RheWplcjhoV3NUelNWK1FqZnExNUVrSTFNenB5MDhkYU5lcWpHNTdzR2dT?=
 =?utf-8?B?WE13WVlneVhwbmk5aWora2hzZkRrRDUyVFVzTDFGT2Q2V2VrU0s2Tnp3VFN5?=
 =?utf-8?B?OFljaVVlRnZVemZvVkNnL0U5ZEpOTm9ZM21rZmc0Z3ozTVdQb1UvcnE1RWxQ?=
 =?utf-8?B?WnJhWWNrT09PL2VVaHBEcWZFejl3SzJuN1JxRGVYNHEvT0NOUmZpR2RJQUV6?=
 =?utf-8?B?eFRsNDgxVDdvc284bTUzMVFWVXR4cWZEbEl3YWExSEt6RTMrSllaV1VTSGlK?=
 =?utf-8?B?SkU0NlJ5OS9GRVdhRXVxZk5sWGxmNFVPRW5seWhUbUFYWVBVNVFUTFU4d1dS?=
 =?utf-8?B?bTV1cXNkUUcyVDhvQVZ4QXlnUEdYcXpqUTloQzI1R1BGQ0p6dU1JR1ptQmI5?=
 =?utf-8?B?amxIVHNhY3ZtUm9GaExTenUrZ2VkZzRJVUx0NG0vNy8vVTJ3bStGUjlPa2ly?=
 =?utf-8?B?TVowSmxKV25hTG92MEczNmw3NlFYMTdxVm9HMmFVU1p4MFpvRTduODkrUFFH?=
 =?utf-8?B?VTNTN3grelRoaU1mTkUwNHVUZVJkUWtEMGJOa1dTUlF4a29kSkxEVjhCZDl2?=
 =?utf-8?B?ZEh6VkEvQjQ1Vzc4d1J5UlBaNFNiR0NNWE1lTnlQTk0zZW9UTWp3aDZQY0xJ?=
 =?utf-8?B?YjZFdndydHNKR1VWK1BuQURUZjFHU1NDRzg4YjFGeWRtUm1valJRSkR2SUJ0?=
 =?utf-8?B?YkFJeVRGaTV3SHVIMWxlZlpRcUsxZkMvUDIrNVpyMEQ1Q3ZPd1BrVWNoVDAz?=
 =?utf-8?B?UUliQVlMOENuVnZFVUNpVVhHc1Z2ak42NHROSDViQlBEa2RILzRKaUtiK1N4?=
 =?utf-8?B?cTFoekZxZnUxcXpBWXgyMXI0WmErYS9PN0J4Ni8xR01DcThuSVYybVQyc2pa?=
 =?utf-8?B?WDVZTFY4SnhmRWhSRkZkYnpJckVqUkVmdnZWYkxnVnhjbFp6UE91WDh4MkF1?=
 =?utf-8?B?TngrYlpZQVA3Zkt4T092cmsxZ2F2QVJqMENhTFlYc214Sk1scVFNbXdyR1Ra?=
 =?utf-8?B?VTJBUzhZU280a0M2SUNLSWhveCtGc2daUFdCK0VOdDZLMGZKNlFuN0dXTDE5?=
 =?utf-8?B?YXlPSVc3MTBuQlNjc0hqbVR6TDZGaGVFeHNlT2IwbHdQMEJtZnVhdmQ1RFVL?=
 =?utf-8?B?WjRCQnY4TXV1dXNkN0hvMTVaWTBnbi9kaUlGckFJTVFicEFtZXpnU1RsTzlZ?=
 =?utf-8?B?NG5JenZIU2RlUXpqSFBhUEJZaXord3VldmsxWC9uUHJTL0YxL2o5Q0JBcFZu?=
 =?utf-8?B?UDNvL1YzbXhsYk9vNEUrZm1vaDF3UjVudm1pYlovNVc3RjNOVnVJMmJabito?=
 =?utf-8?B?ZExKaWw4RHlocUh6dUdjeVNkeDdjc3Vjcno0T1JGR2xHRXFyNTZSOWZiQWNY?=
 =?utf-8?B?ZkdIdnF5OWRFSjJ6SXZ6M2hFWUpBMzVTSlUzQ2RMY3ZCbnFhb0pSNm5VaGc2?=
 =?utf-8?B?b29raUY3TEljckcvK3poRVMvVEJWamlYMnk0WmtCYkhrc3I0NUphQ3ZBYzJy?=
 =?utf-8?B?M0Fhb3dueDVyNFpiT0ErVXE4Y3RXbTZCWG84Qyt6SndXNjJkWXJsaThtdDJS?=
 =?utf-8?B?NW1CdkdYeUdkWGEzakEweFpacmNWS3F1S1U1MnE5MU1IZk92dVVzZDY3SHNO?=
 =?utf-8?B?alFoM2RrN2VNS3ZlNWUvUVUzZnRwclRKclZ0aGlxTllRZitkekY4WDd2aGls?=
 =?utf-8?B?VFNRcUxzcCtkVkhmUERXdExpSXRzaENtd242WEdVVzlKZVRYZ3gxazRING9J?=
 =?utf-8?B?U2laSngrWGpONGZ4c0hWNUZVTWpLbFBrc21WNy9JZ2ZaNUZqODcvM2VBUVNv?=
 =?utf-8?B?OW9abDEyaFlsWm1meEVWUjA5QjdnamJNQUZ4Y3phelk2OFpPVXY3ZUt5TG5l?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5CuTUPmLqsV+elA7AjNJu3F8dLEW/blIA5hjOmzCUR4/YpW3MBBCY9SgaE1yKUbDBSJ6dvGYpSUlMxyzMsaca01mqRlrL84OxPyDjDak3ltHm95UbwtHxY5vyDtSVW2Y7XICDOslKl2fD+X5Rg3L55kKYVWXEahe/G/U98W/TIUbS511Yby5fDhKrrSb4NXwIAW6Qi0IdhtGy1P9A48GOTML/JAYdwYhRwrwcVrjjeqdLH+Abiod0s3oAGjMQaULPmCD8Hcuvphfd+AgBpn+0xSHy/STU02eNMH5wTvJ+iUeeqlgo5hyUz7iDIlXJq6AKbxq8qEaBoxLHDfu06LU/g0OSbj38vfmXqogXxIG2i/ILGdZFxODQphGLXg9aUxMQhOFKyeJ3D0bYQYVbnlymFfbFZEDUGq72o0BVW2jbcBmqc2vo7pc+17kvCbruQTFYNtW4GdmcRIcOnGYiJvl+8f+tl9GnkqHH6kcGIP6QN2nWHi4INi9nO/tGvNU6AfxY/GI2eKRr5ZYnpjjxnGmRdLrBKsLu5RzXv83wR87JbcUbkkYci2JHiXgU9wnrN4LWIlGJIJnP0nx+WxcJ/YOLmPGkxm/qRLeWjr6slL/6a0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa10860-eb1f-41e4-18f2-08dda284ea18
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 09:56:30.3949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KV1VGsyOsz0hi0zluwfqufwJPvpLReH2J9OtwIaKdX+w/TD30ShVPrAZ59iLYJNnqeHurq0KLLWcG/kbd/KDbPC0KydP6acZy2Dzg5/fzD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDE34AA4C5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506030086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA4NiBTYWx0ZWRfXxyDDB2nRSp3/ odIFeQaJWKDGak7hXzWifiL0qcyMA9u7IC4S3ZnpvQ+ONdmcfkRlwIOK1dXn658FUJdbkN2cDvU vP+7x42WufzaucZ4L3UP2aSnQVhuCI9HTpPASPYtB20R4dMGEIRz/KAlbZ5FYgoO3OmxIl0Aqbo
 LLMsHtwgzNdq+zYMd2wj27XfhRlfi3VRihFz+unuHZH84Mg7pqmOU/g3yONhxUJB4UmBOTnuyQf b4yFj8IL4eFdjp3W2Cc8woHXE8JUxvdujcA34FfpdD/B+/WuJcPIHOVl4TTnq/raY1aTG2+VWsD HnJIJ/xFkqfKnJH6q3aETq00TA8gi4kAYIc545gUjJK1U0EvgYl10CqD1xxnV0UKS2aeV1XKSPT
 B8VaR5PaBlyIK3zrU//n9w14kFuFAB43ddDeE04Wxu2VrybMRD1PkjLG2ieUkJJcGTzsye71
X-Proofpoint-GUID: D92LXDWnft9VJYICJREWajaSvFrGXnAU
X-Proofpoint-ORIG-GUID: D92LXDWnft9VJYICJREWajaSvFrGXnAU
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=683ec6d1 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=i0EeH86SAAAA:8 a=e1FQA5puciH5vB_lAFwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714

On Tue, Jun 03, 2025 at 03:08:22PM +0800, Pu Lehui wrote:
>
>
> On 2025/5/30 19:32, Lorenzo Stoakes wrote:
> > On Thu, May 29, 2025 at 03:56:50PM +0000, Pu Lehui wrote:
> > > From: Pu Lehui <pulehui@huawei.com>
> > >
> > > Add test about uprobe pte be orphan during vma merge.
> > >
> > > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> > > ---
> > >   tools/testing/selftests/mm/merge.c | 42 ++++++++++++++++++++++++++++++
> > >   1 file changed, 42 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> > > index c76646cdf6e6..8e1f38d23384 100644
> > > --- a/tools/testing/selftests/mm/merge.c
> > > +++ b/tools/testing/selftests/mm/merge.c
> > > @@ -2,11 +2,13 @@
> > >
> > >   #define _GNU_SOURCE
> > >   #include "../kselftest_harness.h"
> > > +#include <fcntl.h>
> > >   #include <stdio.h>
> > >   #include <stdlib.h>
> > >   #include <unistd.h>
> > >   #include <sys/mman.h>
> > >   #include <sys/wait.h>
> > > +#include <linux/perf_event.h>
> > >   #include "vm_util.h"
> >
> > Need to include sys/syscall.h...
> >
> > >
> > >   FIXTURE(merge)
> > > @@ -452,4 +454,44 @@ TEST_F(merge, forked_source_vma)
> > >   	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
> > >   }
> > >
> > > +TEST_F(merge, handle_uprobe_upon_merged_vma)
> > > +{
> > > +	const size_t attr_sz = sizeof(struct perf_event_attr);
> > > +	unsigned int page_size = self->page_size;
> > > +	const char *probe_file = "./foo";
> > > +	char *carveout = self->carveout;
> > > +	struct perf_event_attr attr;
> > > +	unsigned long type;
> > > +	void *ptr1, *ptr2;
> > > +	int fd;
> > > +
> > > +	fd = open(probe_file, O_RDWR|O_CREAT, 0600);
> > > +	ASSERT_GE(fd, 0);
> > > +
> > > +	ASSERT_EQ(ftruncate(fd, page_size), 0);
> > > +	ASSERT_EQ(read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type), 0);
> > > +
> > > +	memset(&attr, 0, attr_sz);
> > > +	attr.size = attr_sz;
> > > +	attr.type = type;
> > > +	attr.config1 = (__u64)(long)probe_file;
> > > +	attr.config2 = 0x0;
> > > +
> > > +	ASSERT_GE(syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0), 0);
> >
> > ...Because this results in:
> >
> > In file included from merge.c:4:
> > merge.c: In function ‘merge_handle_uprobe_upon_merged_vma’:
> > merge.c:480:27: error: ‘__NR_perf_event_open’ undeclared (first use in this function)
> >    480 |         ASSERT_GE(syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0), 0);
> >
>
> I did not encounter this problem when compiling in the
> tools/testing/selftests/mm directory, but in any case, adding the
> sys/syscall.h header file makes sense.

Weird, it can depend on what system headers are implicitly included due to a
header in the dependency chain including something else. At any rate, I think
Andrew has already updated this?

If you send a respin obviously do include this fix.

>
> > Otherwise :>)
> >
> > > +
> > > +	ptr1 = mmap(&carveout[page_size], 10 * page_size, PROT_EXEC,
> > > +		    MAP_PRIVATE | MAP_FIXED, fd, 0);
> > > +	ASSERT_NE(ptr1, MAP_FAILED);
> > > +
> > > +	ptr2 = mremap(ptr1, page_size, 2 * page_size,
> > > +		      MREMAP_MAYMOVE | MREMAP_FIXED, ptr1 + 5 * page_size);
> > > +	ASSERT_NE(ptr2, MAP_FAILED);
> > > +
> > > +	ASSERT_NE(mremap(ptr2, page_size, page_size,
> > > +			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);
> > > +
> > > +	close(fd);
> > > +	remove(probe_file);
> > > +}
> > > +
> > >   TEST_HARNESS_MAIN
> > > --
> > > 2.34.1
> > >
>

