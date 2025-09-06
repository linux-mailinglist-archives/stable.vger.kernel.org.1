Return-Path: <stable+bounces-177924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3717B46854
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 04:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999811C829CE
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 02:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A7E199230;
	Sat,  6 Sep 2025 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EVj5KxmP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c0gNDphS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69895DF49
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 02:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757125039; cv=fail; b=hDRJ8fOBLKYFuVLTKpIOlLP+wxwmnKQ6xX9ApArr6RZgu8obUG5s9wxnaYiXdMDh+FVixFuBlzWfbi5pflM7vLGwESnEvJrSx9YLfqvYfCr0bXknAkEUgHIOBSJ0gLJrIoX64jefQUy5h6BAziQfk8w555lDrdNIFAz+We7HMcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757125039; c=relaxed/simple;
	bh=SraiVDQJESd2nDyLxuk+2HbFP42ZAdFAAfCRhoJDOpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UHfxvqNDBWOONqdPtpdW0G7aztRNlmvQ45gxOEEdZZOANDgykxropSQv72lU/fhcZwSJ4Aob1lxMqxVKhKnkjdHLhzc63M5L2qQ/cAD3u4Hls0we8QMCnpPx+SkkRTNixERaJbWTPnUGMXpHB0AiGyl8ifNFxQwmbUrIIGie4dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EVj5KxmP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c0gNDphS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5861t1Vh022457;
	Sat, 6 Sep 2025 02:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j4URMYbzTCoof/qrZzff+DKOM8z32ygPaGN70bC1Qxc=; b=
	EVj5KxmPBfeRcdE2xOEIrG2cZAylgZLMwHB9fX8JgtEFOeRV4JvVINAILZI/B1GI
	Ir35NbNUJBp+CHRff42YLBoD/YRf0OGcipicpAuiijZgfJlvFfhVFNXhahAiSjZD
	oWMPGiuvQAnvFtMPWjLIL0t6zv3McD9lxSej9IzniYCs+pyZhyJgJHys9LhWesRd
	zwBDCOw4vcjBAfbrJTb1vX3Rs+BUZvF2WCOp/tzEANXSdk3+6pMh12ka9YbFgWRu
	D75zp8WD+Tun9pYencrB3kSjozfem0FvwjHM68dXRHRwv0/yUFIgnb30vYvQeIyK
	GEe8ew2lSS574ej6Ox7ZRg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 490bq0r0e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Sep 2025 02:17:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5861Y9CE013623;
	Sat, 6 Sep 2025 02:17:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd6gq1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Sep 2025 02:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIaq7qI+j9iF2ASsbv9y357GAGiOYbQVIv4pwaYoDKFE5WO7M5wXdBpHN4vrfn1MgUchvslbuzk6ZjsZ+O/tBMjJ4Y7UwtDCV4Sb7DBMocA0qu9sfqoAhtQ10k7SXAstTGCtnlOZubI8aEpzrZh0TjnHaELTCxLD0vGzecv8YpuVAYvVARaaLyrYbctAb8L4Aa5LuvgQVNfg+/NFqCzUJRcrQnksk4AzAwGKbYjqefI6PDrkeqhgNbOHz95sn+9Mt6ePnvDp/NXpEog8BMhKF57xphNodKxGWemkGkI5lRmTaKBC3wAJV1toH1au31c/PER8xfEk/u5bGFJGQolEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4URMYbzTCoof/qrZzff+DKOM8z32ygPaGN70bC1Qxc=;
 b=NY7Fqsnf+vH33CfsffhB9FG1eCfZtcpvdmA1xnZyWm0AyMgvpmtLSs3Kqj8e8mcr6V3eKINtfjBJjiZSBIaY4/VqFD3uDDgzI/rQx+HpdGhwCThk2YShleXH6CWQa11nYF+vxqu/DRbKPxZXrKlOMdDJJ65XGkFGrvDiCOX1Z83DS4txcHePCIQzz4zDOpMyHqwvwH+owCNWJxuhgNZqgrjNuGUmLPoFcspbCddsasHrv+OurrvtRE67vl3dVC+UxMbWibVMdesVvZlZG+qfdSPFvHSK8wE+55jkzBN6dEDA4TDbx82BrvbMslq6wqeFlGuTQAdlfck26IfCDqOqOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4URMYbzTCoof/qrZzff+DKOM8z32ygPaGN70bC1Qxc=;
 b=c0gNDphSwlwJ0PKouqi6ON7qpakcu1DwkxB3U/+Fu9lVQPAma5xLLYgFXFZT0fgZfVN+gpHyeJDTQKTlvaX9lRhI/56L9ofU8zdz039Wqbh67OlW7ojfpdEq9+jg4SNW8Q4L+pujcXFJSLSe+OwvlVbj7WOD+XqHPsf5X2IRx4k=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by DM6PR10MB4138.namprd10.prod.outlook.com (2603:10b6:5:218::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Sat, 6 Sep
 2025 02:17:08 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9052.027; Sat, 6 Sep 2025
 02:17:08 +0000
Message-ID: <8a53f86b-9d5a-47f9-a4f0-74a9c5c0fc78@oracle.com>
Date: Sat, 6 Sep 2025 07:47:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
To: Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
        syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
 <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|DM6PR10MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: f23a3c4b-ced2-434a-49eb-08ddeceb7ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVFNNUNoREJVeld3TnJEdkVFRWNqNGh4a2dvdnZDYXNoNWZtbHFEdVFwbDJF?=
 =?utf-8?B?Y2FFdVA5K25OZXY4cVlXYTJENUpkMXJtQXJySkkyTFZzTVJSWllpb2JLYndN?=
 =?utf-8?B?bUNlYi8xR0NLeEM1bDE2ZHVQMjBFbFl0eHhVY1hlUnU5Qm44L3R0RHNKcnh0?=
 =?utf-8?B?cGRFKzlZaHg2NGhQUTVkcmhNM1JsOW9DdXpDOEkyQkpmOEppR3NaZWJaQUVs?=
 =?utf-8?B?TDNJbXNWeHhZQXN1QlNvZjRmdm9QWi9KQmNYZ0phYjI5Y1RMS3Y5ZnJxSFp6?=
 =?utf-8?B?UW9hTCtTNVBTUnZMVkQ5alZVMVJycmlqaTV0ZjBDakFxMGFJeUJpSGlqMzBi?=
 =?utf-8?B?YXlPUHcrYzJ6b2JrUWs3SzJwSlZKQTFKa1Zhayttc1FKWmxRbnA4dU1SK2xJ?=
 =?utf-8?B?dkNlczU4c21VcWN2UTNyTjQwOXZOSEw5b1RzaXRPQkVaVC95QkRSNmUyd0My?=
 =?utf-8?B?RTVLM0RCc29GaUtlUFpTcjBOdzh4UFdWWWdIUmY5WDdNZlluVGVEMzBoTTRU?=
 =?utf-8?B?MjQxU2w3VGUzRWZtM1ZEcVBMdStwbWtNWFlVZUxPYXR6eVowT0kwckdNdzNm?=
 =?utf-8?B?V2ZKVUc2SExYRWJyaS9abzlwbzd0VHZwckdFUmVjZjRmVmQySWRNaktqenMr?=
 =?utf-8?B?WXVYTzFQUWNOcTBDNndpZTFwUnllT01vMW0yN1Y2cVhOR1pGWVY3cTdTcm9H?=
 =?utf-8?B?MktEM1QyZCtCOHNaTStnc0Jaa2xOSHdzYmJoV2hKcVlESkZkbnZhM0FxRDBh?=
 =?utf-8?B?Tmg4RENFMXZMenU2SFFJWWZ0OFRHVVFESGZjZUtxQ3kySXhpTzZWeDBnRTJT?=
 =?utf-8?B?ZUh1WURaM2NZYWJhakM4RFl1c3pvZHM1eVMzRDh3NXVHelVBNzBOOGkzUVAr?=
 =?utf-8?B?UjMwNUtPdHQrSzBLeHhKWTRLTUlxa0ZsL0F1bU5VS3hOK0grR3pzUUJ0SHh2?=
 =?utf-8?B?ZEIyYmdHQ3UxbzBubThodDZXa24zUU4wckRncUMxY09hUTFwU3MxaEFXQWk4?=
 =?utf-8?B?aWlXNkMyenJOYlVGTjFqL091WFF4K1JUMEEwMzVJNVN1Mkdya29zSndQWnp5?=
 =?utf-8?B?ZHZzMUhWKzhvZkJKdnkycngwTGROc1pqL1p2dVZubXhoQkYxSTFCUFg0bEg5?=
 =?utf-8?B?SktzekovOGtsS1pIN1BIUXFlVEhoSGRhdUZKWm9FMUh0aGlLOFk5U2tjZUZk?=
 =?utf-8?B?TWJINVZzREFtbTVqeVJpbmR1VmZYeUoyVzVQLy8rWUI1OG5FY05IRGo4S2VH?=
 =?utf-8?B?VkNxZ0FQSDRGY0JWQzNiSHU1N1BLcCtWamFMd05rcnRQNTNNMVBuSFNJRnFC?=
 =?utf-8?B?eU5aS1Bkb0p1UXhoMWZiMWhyaW5oT1czeTJZZlJNV2pPMzR1TXZHeWpNaXRI?=
 =?utf-8?B?QkRFVS84NTIxbjRldWpYZzRKZ0pXc1ZhY0p4WVRnT0QxK3dTY3hkZTkyeExj?=
 =?utf-8?B?VWE1a2FxV1h1UEVLeWI3QnNkSnA2NEVHVUlaU2hHVTAwOWRjeTlCaUZMUmV0?=
 =?utf-8?B?RCtLYnRDdCtBeVBocW4yamFoVkdtOHMyWjRqLzNRTG5sZTBHK2d5eGFmUDdN?=
 =?utf-8?B?dU1PUkFCVGNYemhURnJ2aWdKdXJVNU4ya2EweDMxSThKZU5tcEZqaXVIUTlv?=
 =?utf-8?B?Z1pDT09RaFhsOTJzRHZCaGYrcWt3eDJjWDJKbUJkWjZlM3N4Zko5cHNnTnpR?=
 =?utf-8?B?Mmp3TUpJYU1jRmxpRWdjeXpFeHdCUGsyZkd6bmlWZGVBMlhjTUNuTEQyMWJZ?=
 =?utf-8?B?eEpwRGJRa21TbE9TWm5mZVZaQlA2YnVrWFphakk5ejRXUmFvblNtV0IzZ3Nt?=
 =?utf-8?B?SGRFRzFVTWZGNHcvOVBuWVJyU1JjNTJvYnpuZDlGL0NyZWo0M1dnQkUzR0Z0?=
 =?utf-8?B?QW5INVNyQng3aVlrcFBZdlArbDlNdk9maWVqb3k1U0EvNzJqQXpmYjJKTDEy?=
 =?utf-8?Q?Kwau6GtXvRw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTZkRnRiZ2Nxd1Nmd2l1K1ZibHovZEZVMnpiakkyYzVNdVkyTDY1RklhVjhx?=
 =?utf-8?B?c2xwdlZoTHc1WDFkUERncFpHWmxYdlN1Vy8vd3ZUTElPcWdMT09nRUZNeG5u?=
 =?utf-8?B?VEhUbEtpN1NDa1IzbEErcGsxdTBLQ2J4TEIrdlFpZXYxZzhOUlI5ODBWUUI3?=
 =?utf-8?B?V2ZMU0JzRkRXMGdXV1hQU0J1ZGJYTTZ2UXZzNEpFdWFBZHFpcWFnaGlmbGM2?=
 =?utf-8?B?dTFUVVpFWUFhWWtGVUVuVFBKSkRBMTdIeDZVYVZRaXZZUHlwbHFvQVBBdC9w?=
 =?utf-8?B?ZmtraFZSTTZQRUJPRDZuWDY5NzM5ak5qNHMyUG9xWFdhelBEdHBZcUdxbjdI?=
 =?utf-8?B?QnYrRnpoaTEwVWpPOWpLS1FyQ2krREoxY3IxK3hWK2tDTFZ3Q212cEgrRlh0?=
 =?utf-8?B?eUJLMjIwSC9UYS8xeWEvYTRYbldsZ1plT0krSUI0TUtpaTJvUWttMGhaWUxD?=
 =?utf-8?B?amVOZVJlOERxZnpqYzlVY1IyV0JpZEYyckRzTzkvWjNpZ3ZYNmhVZWQ4Ulp5?=
 =?utf-8?B?VnVsQVQ1bi9TVStic3BDcjZHUCtBcW52VkVBVXhrQkhHWG9GRzJzNFBQOUJB?=
 =?utf-8?B?bVVKQjUzQzlEQlZHVkVJT2ZOdWtUOWhxVFloeVRuL1NSYXRiVWhtNWxBRWxC?=
 =?utf-8?B?NmR6bGp5a1lUSDZWeXMwUjhUVWVjZ2xyajhvOFBnV2FiS0xMcUkzUjlFRUNN?=
 =?utf-8?B?VlVWeEd1VE5kWVMxa3JaTWpKelROYTI5Tjc4ek91T0paNk5reGpQdm10TzZH?=
 =?utf-8?B?Q0MrYk1GZnVyYUF1K3BrMm9sTDY1SXpSMlRuanVqMFByQ0pWOG9NYkd0Q0dv?=
 =?utf-8?B?eGxGMVFKbVdRbHI2K0p2YnNNcm9rbXdoNUtqNUdYaEFrS0hvR3FhcFRJSTNa?=
 =?utf-8?B?OFpENFFRSnZzdkFRWE1henhzYXVtam44U011RDFVRElUcldhdllYMGNEZHBJ?=
 =?utf-8?B?RFplc1N1Z3MvVWg2aytXKzVPek9INkUvL3Bielp1YkpNSGM4ZFQxL2VOakZG?=
 =?utf-8?B?RGRkYjJmWHVHRHJiS25FQ1dDcitnYWJ0dXkvQVFDNmNwY3ZYU3o5ZVg5NXpm?=
 =?utf-8?B?a1NTd3pBdlRHN3RCbVdyRWROajFLOXR6UjNNcHVJUGV6KzJuemxxRjNZMDcz?=
 =?utf-8?B?bXhLdXIvZldWZzJkcEx3MWlEeFpzcjYxZkxIRERCQlREbm9vblNvM2pmYmlw?=
 =?utf-8?B?eDVjaVNYN1g0RlJ6NllueTlzTWdnZWdjazVpMUNyWWgxZGcweTFCWGRNWTF6?=
 =?utf-8?B?MnVCYTNSUTh6WDltaythZjArUEVnalQ1d2hjbEJuNzFobUZmMkxTZGlZVHZS?=
 =?utf-8?B?Z0Z4TE5CRlRHNy8xazFBTllEUjVZOTFLWmQyMFBoUFZTS08yaFBZaEdpMHQ0?=
 =?utf-8?B?bEplRGZLNm9JVEN2TDltcW9CNjV5T0NUYkY2a1lkVDgzY1JrM3pQTnFGaXFE?=
 =?utf-8?B?YmM4QmIrcUVWYXNvRWRYNEliUTVnTS9DSDB1YVMvV2ZVYzZ0TGxOdU02ZzF3?=
 =?utf-8?B?VDlyN2dPamhaTlplUVNZQnlwL1BlYTAxcGVySTcvcTZ5VVBiUUx2VCtyZGxW?=
 =?utf-8?B?SlRlU2xsYUhvTHhJTWtuSkovaGlxczhjMDBmeVlQZDNoRktMQ3FFV0pwQnU3?=
 =?utf-8?B?Qk5tY3owbDZCZC9EVkxYZGNEVEpRS1BmSHh2ZU9PcnBxZFk2R0JTMGpLcThN?=
 =?utf-8?B?VWtPQzdXU2diOHZWd3FTNEc0SHVRUUVrc1kyUk5jY0ZmMmZqVnRFWGhMUTlQ?=
 =?utf-8?B?eGJCQzMwTkZ5WllZbVIyaCs5UmRGUFk5SGZJMFFkTFNwc3NLTnRleThSclhB?=
 =?utf-8?B?WjI5aFF5dkQwR3M5bUZtb1JzV2dVTklIRXZyMFhKOHZvSk5EcTJ4d0cwUzJU?=
 =?utf-8?B?TlVIeUZUL0l4Z1lmeWFzSjczbzNGNVNSTW9YcHQ2cm9JWWV3MnBEZzlBdnRY?=
 =?utf-8?B?VXQzV2s5WFEzYU5uYWw4TDVZU3UzWHAvK0NxTWd2V3Nib0h2QkVLWk41cnVl?=
 =?utf-8?B?VTNHUFpCR2c3OVpLMVU3WExHWUpIUDVRbExsUVpYRzhMVUNHQmZFMEEwb3Zi?=
 =?utf-8?B?ZTdiMEQ5K2JXYUI3Y3lKdGcvcUNiVE9SckZPT3ptSjljVWpLYlM0QlMwTE1o?=
 =?utf-8?B?VzAyaGZSQng1cW9OY0tjNVkrTnpvWndTeHZGZ3c4NzlvZUp6VjlOWXFhaEkr?=
 =?utf-8?Q?Nu3iucJzMSoIeUZyo00k9l0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3reJ7tHaqHAgUz7jWClIC4N+d7ToMaQa3XJ7GVeo5N7VCSfaJYyr759TOJcXrBaMxHvMjkYE2NZKXs/Qgf4p6QvVga+wRMRoP01hCxPZfs1Nn1u3XTRQFsQ0JQ+EpSdBD8fsshuvmuNvGea4Ix7u7jHu6oXs3MdTlVS/By1zVEWI3w0AX4sry2K977haCvG7nb/YLMHaR2TSPBJm6e+OGGen5Qof5oV3GN/qJQ42Kb/UXavlRhFJI5GshVKU8ZrMvdJl2ZQlpadL10IgUgU+bpc+2F6ztOQuE19bbCqCYT+/nDh4QKkL4iWHhdeagoeiiBL/NVVO8viDTqAZCNfZBzUzjYdmdFMYidF3dayBti7evKzBNLwsSZfQfFxzCbODlcVmC2oA/2oCm7wCoL5ffkqtkD8E4r3C+IsUqQVf8jfyoZmYPI+RMV/rhi3jnbBFrMs0c5q2LIWkQu+YGPMNwM3TfTRuyQw00TzQRGWe9rlBvJpjCjjTsnGm2NKRiXS78H0NiderUixAWQnsth1FYHGYgqBzfPAJh3kjh2XBsj/fqasnvy+gRdSvIJyWsvonSO9r5r1Pf8AOHAB6ecopvDoQJDdXR22SsQ7mhBT8uOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23a3c4b-ced2-434a-49eb-08ddeceb7ab8
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 02:17:07.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrvwrcZg0Pr3O/ywx5pLfjB1JjCaZuc85174opBz0syVVadcg7cCkMMSaj5/thj0F9VJhoMOhmx4YyjVDKEGluSZ+Bc4oZBzroWVw1dDKOwQmnKxJ6xFf28sMlalBr2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_09,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509060019
X-Proofpoint-ORIG-GUID: KG7ChAWJf9Y5IamImphqUpoEvXgZiTpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxNiBTYWx0ZWRfX0vr5fhtV9hlX
 MMmhv8YHmGvyI6fyO+xcc1P7i4B1SXK833bdh2LxI6kFTcbbcdpn9CDMSakd3076auyFFBCJ0XZ
 3Qr9O5bKHGuQtVjpE4RUQrkozUuak1N6bL6Dj4BahZkX8p6oyFeAkjNVegXNr95IwQQypgolZ26
 zaA+hp/qpjyZVuLeD/CaPXPQVKDAp2ym9CddVRH89MGa/R99UoDtzbfrS6mplhUUPeYtIzzlcG3
 WWiyc+EltrXRAZ4RA8FWRu9gs61a7ufghAk+2zrcW64LabIT3WJozL010vQ1ZUbIxaw9xgYyxWM
 ENEe18+73jXghFGN3cMbo5TmkYU2FK5g4tC3dViuR627ggi4c2IlSiupvTpx3W/KLPkAHUrgChd
 R4rwhwcR
X-Proofpoint-GUID: KG7ChAWJf9Y5IamImphqUpoEvXgZiTpB
X-Authority-Analysis: v=2.4 cv=BeLY0qt2 c=1 sm=1 tr=0 ts=68bb99a9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=0BbqfCMfcvvt-T4fheoA:9
 a=QEXdDO2ut3YA:10

Hi Jens,


On 06/09/25 01:28, Jens Axboe wrote:
> On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
>> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
>> index 5ce332fc6ff5..3b27d9bcf298 100644
>> --- a/include/linux/io_uring_types.h
>> +++ b/include/linux/io_uring_types.h
>> @@ -648,6 +648,8 @@ struct io_kiocb {
>>   	struct io_task_work		io_task_work;
>>   	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
>>   	struct hlist_node		hash_node;
>> +	/* for private io_kiocb freeing */
>> +	struct rcu_head		rcu_head;
>>   	/* internal polling, see IORING_FEAT_FAST_POLL */
>>   	struct async_poll		*apoll;
>>   	/* opcode allocated if it needs to store data for async defer */
> 

Thanks a lot for looking into this one.

> This should go into a union with hash_node, rather than bloat the
> struct. That's how it was done upstream, not sure why this one is
> different?
> 

We don't have commit: 01ee194d1aba ("io_uring: add support for hybrid 
IOPOLL") which moves hlist_node	to a union along with iopoll_start,

         struct io_task_work             io_task_work;
-       /* for polled requests, i.e. IORING_OP_POLL_ADD and async armed 
poll */
-       struct hlist_node               hash_node;
+       union {
+               /*
+                * for polled requests, i.e. IORING_OP_POLL_ADD and 
async armed
+                * poll
+                */
+               struct hlist_node       hash_node;
+               /* For IOPOLL setup queues, with hybrid polling */
+               u64                     iopoll_start;
+       };


given that we don't need the above commit, and partly because I didn't
realize about the bloat benefit we would get I added rcu_head without a 
union. Thanks a lot for correctly. I will check the size bloat next time 
when I run into this situation.

Thank you very much for correcting this and providing a backport.

Greg/Sasha: Should I send a v2 of this series with my backport swapped 
with the one from Jens ?


Thanks,
Harshit

