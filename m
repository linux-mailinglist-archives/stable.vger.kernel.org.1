Return-Path: <stable+bounces-144266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5979AB5D16
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 21:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42C0167FB2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7B2BF98B;
	Tue, 13 May 2025 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ArrMfMtd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tNnq8Luk"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FF2BE11F;
	Tue, 13 May 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164237; cv=fail; b=if5PHgQ6NK9TOcJm+mMOD4pOc7sP5StxFsHDm5Mea+bbp5epozGDLzrlhiLxLfehyd6oO42mL7/ScAJitWVu6RbGnFJuytJFfPIJDB00NKniwiGEj0Qu5cx5U/LsngJEmNnvkAWnxfB0e+vhFYSqAeWafFrXTttQwH3ijUuXOZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164237; c=relaxed/simple;
	bh=7Lwloioaxe0QqnuedlaEKudZS3/Lj8srO20qTbjr/tI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Guvm9tbMewpGoqPxNzoe2UT3GK0/PwgxLULHkTZ12NxgXIxhlHlnLdRmX7HTpSa32/dbe3B8omJCQfNPm2wSzHtSvT5jaiUtA/bfzQufRt1MVUUxe66VlvS/14FCnKU4K1R6M8AFCVhDaYCK6TAh7Reb9spAu/4E1TQtbNkzWow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ArrMfMtd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tNnq8Luk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DIRlms024542;
	Tue, 13 May 2025 19:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QXZwqU+LKoujHApUGBnQbfvunaKpq+q3dvlbroEqEeo=; b=
	ArrMfMtdr0htaD38LExSc3VCTGsCM7+/PRRbg+YfFvORCY8aNJR6mYIgVxSz5xA2
	fBnYN0FwThwf3gdDXf/qyk0/Y1iArbJ6SnW8Vvqj+9FzUMOtoZ7MW2LtfhEOXzuD
	wCQHEW6kRUaHa7Ma++l8QhCfhtA5dcbTg18TKo6hwcEudtjxSPHru/VgrpO14etb
	lE71embvL47sS1nppgVi1savmjYCBfvWdsxs+5Om25m/NhJRRqBj1Y8+F3iQ7myZ
	gR66Mr0mdO+rPmocuXt3mAmZ/Q/HsfI25khG9qj7uJDiBOwT+vW3qEHscP3kgeC4
	u/DN+XVeGKD0s9F+iErQXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcgr3d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 19:23:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DJNcpO008892;
	Tue, 13 May 2025 19:23:38 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mc6vr00m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 19:23:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zucu67mL+/G7pKzh5HYjS43sqXm6Z4kSFhlf/u4Uc+8gBmGEoelOnaapEnDiyzFIz7ZQAwxY05e2wj9SSgZmvJf5Jn6ZpgGc/rduyfAmEJJ1UVJ0GelYH/bDYq1fQ93IcS17lcBzebVosPs3GPQaTI+6OHo+NNFLfuLyBRSvzq4Snpo2OIe0v56HpbMx8lK+3jSwmgFmZf59GJbJ9G0TmPPkr/jLDIrfaB/vUAQVTv/zTD2EBMZyMFOPusV2b+w6zJWqgJxnxpttFTJIap950eA25ZgZwXJVdUFSaD/AM8h+RcqszL6kbrE8mqXBMPGlNv3kgdC+tb/33I3RTLKNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXZwqU+LKoujHApUGBnQbfvunaKpq+q3dvlbroEqEeo=;
 b=D89nvpESH/1GCi1CxinqQmhWrJRWLnw9R32CtADNIQ1oRuIBmQxlCNDSzdm0VCcqglTs5Y+foU3tLe93rJnEyWerYD4R1PJ4ythwukz0Wqlsak0LgHgH/neq/EvUurfczZ4thx7E5OaSjCro2ShcRUuExDRu6pDj2HcSDAP9zfgIoaMfzT1Sds6CBnENONCVOSSZ568QvGcnumVJS/AvPvfq/MXvs+F/fN6TfOxXoxbUpxR1bO3AzHIRa+FlTTaDwk9OfvFRJoJY74WoWalnpIX6LRaNRFYmfkDkNK5KHOZdf3FAq8mcDya6QB2oKiksErOYKPK8x2q28zPbnsXOIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXZwqU+LKoujHApUGBnQbfvunaKpq+q3dvlbroEqEeo=;
 b=tNnq8Luk0iCA4SU5DaPU281YTCyxhOZb4QGkJEsxUSkoyR5LoSwX8beK3P9sEtEsGvf8ubJ/OjRpUkEn4aHd8J1WagQiqAMV4nw0MSk25YUpVDib++xDd5mdc3vUL2qcLuc5heNmjrxodxPR/dXMm6cLOa67rhKFldu/3tNjtps=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by CH3PR10MB7960.namprd10.prod.outlook.com (2603:10b6:610:1c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 19:23:35 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 19:23:35 +0000
Message-ID: <2b706c51-5518-472b-b251-c7c8c39d3a1e@oracle.com>
Date: Wed, 14 May 2025 00:53:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
To: Steven Rostedt <rostedt@goodmis.org>, Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250513025839.495755-1-ebiggers@kernel.org>
 <20250513141737.3ce95555@gandalf.local.home>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20250513141737.3ce95555@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::18) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|CH3PR10MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd2911c-c2bf-41ef-5a7e-08dd9253a79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bExyeUU1Ti82b3R5TDBraGZTNWNXc0lNdXplN21GVkd3UzU0MVdSY2VtUVdz?=
 =?utf-8?B?TStiRzlHeXhJR2RzQkkwazJ3OUluUTVTU0lUdWE1c0lzeGRIYk9RSXJib0xO?=
 =?utf-8?B?bGhwQ1VQN2t4by9FL0txbzNwYkdOcFJENzhqTTMxR3VpYU8vd2RaaitsRU95?=
 =?utf-8?B?dnZ2VldmM3lRTnNncHRoRDJrWnYvNXJ4ZVpTLzVmTDZNc0dsdzVSN0IxS3lB?=
 =?utf-8?B?VWpFWDEvM09DTEJIUXd0VUlSTW9qbmJmSkpHRGphZHJmdStxYXBhTVh0dFJB?=
 =?utf-8?B?MXIxdmZJVFhLWVZPVjFMZUNpZXlPU0Y0M3pPOWdDcWtLNG5MYWh3bTdaUnhD?=
 =?utf-8?B?YzA5bU03a1g2NWwxbWJ5QUs1VWphMHRpbHZrWjFHSTBDdk5sVEhTaGw5SU9Q?=
 =?utf-8?B?SWdUSVl4eGhjY3NyUDl4TDBrbHIwUnVka1FPenNTMy9QOFdubkg0Yy93K09l?=
 =?utf-8?B?NTluU1BGSWZ1bUZSSkZ3dUR0R0Z3eGZhbjlIR2ZURG5HYWFvd1N3NGNTdXh3?=
 =?utf-8?B?S0swbCtiRGJQYW43OTB0YXJBK2k3cnNvQzd4RVpTWnJiRHFyOWw3dmJOd21J?=
 =?utf-8?B?YzFYWEY4ZWJWei9xcGxTb3FFZDNwN2lSV0d6Y3dmaHBMVWdUZXlEWStCRGZD?=
 =?utf-8?B?NS9WaGhQTjhVZ1p1MUNCcDlTN0xsSW8rMzNhb3YzRXkrT2Vqb0FDdGJHT3R1?=
 =?utf-8?B?eEJibTRyajlPZnp4KzRGL0pBeU9aampOQlZneC9TNENqZ29kQWh3NEVrQ1o5?=
 =?utf-8?B?S0JLYkw4cGp4Qk5BZkpKOVE0NkRraW4wZE9GZDZzTWJUemNBQkYvd3hpTDcy?=
 =?utf-8?B?UDhvZ0hyR1JtTzJRbTJxNVUxWTZsWEtpMXpVRWZiMWx6L1UzVWc0U055dFl3?=
 =?utf-8?B?U1BzQ3k3Qm9wQWVGdFpOY1hQWmxqcTd5TW9GbHczNkhvcUVnV2Q1bTNBcC92?=
 =?utf-8?B?QTBIQ001MWhPR3pBOFlJVVl0d2tkWjV2ZTN3R3paNEVPcUp4NmJLbTdSbHox?=
 =?utf-8?B?bFpwQStySEliRVZkWThmVUhsOTMyWFV4ZEx3QjBDWFN1Y1hMbXQwMzRSM2lV?=
 =?utf-8?B?NEptNVBsV2RZdlNDYlZZajE1NERheCtHQnludlVZRi9PTmx0WTV1VUZCeGxN?=
 =?utf-8?B?Y2JiejRWMGFCS3hELzBFRnEwZnhBNTVDaTBTYzNxRVRSQzZzYlcvK2lsa3A4?=
 =?utf-8?B?ay9lNmV5TWR5UU5nN3djNWhqNzJPMDVUdUM0WStnMXRRNjdBWlBSS1Avd0l2?=
 =?utf-8?B?cjZhYzBYZ1BxUm5ZT05acDQ5dWNZOEVieDh2aG93NkZHbWxicnBNSk0yZHhw?=
 =?utf-8?B?SHp2eWdVS1FTRkh1NEVGYTNMS0hyLzZmaU1hRGlUdWdMZEV5VndOQjVQNGJo?=
 =?utf-8?B?ZkFiZEZ0Nk5xSCtKd0h5Wlo5QmVMOHl6WjVsaTRnakJMWTRkVUszM2F2c2NO?=
 =?utf-8?B?RnZrUnlFUCtqU3UzdjllN0lyNDNWVWNEdWlCNWF3Wk1RbVlzZC9hamtKWE53?=
 =?utf-8?B?cm1NOVpjYnZvaEd4RjR3QjkwbFhMenJ5VjdkZFFrQzN1NCt1cm92aWJhZzdm?=
 =?utf-8?B?RGIvVFMya1dqMWpvYTg1bE16ZXZMNlJtTjZzc1FhVHBuMXlIUndiUUlER1pQ?=
 =?utf-8?B?M0E0NEEvWVNqQ21CQnVWU1lUc3dVUFZ1cGsrSTVxWXpHdEtHdkQvamxXYVpU?=
 =?utf-8?B?RE52SnNtZ3QybU4wNkVqR1pjUW1JWjVoYmRSN1hzQWF4dkN1aDlCRkd2NGFq?=
 =?utf-8?B?VFBZVGUvQmxNNjk5TytwV1lyK2RZSXVuVVVvVVY3U2JmYjdHSDByQlpLbUJs?=
 =?utf-8?B?aVQzQ2xnOEF3SVFwNExsNk9va2xVS1NiaVViMnNSZFVGcUFmeGlaYm1wMTdG?=
 =?utf-8?Q?QfJuf29aZwbS3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTM1ckZhWHNkaTJ1aDhSeUFidTVxRTlKczVvZnlhMTRCL3BDZGNmWWMrYWw3?=
 =?utf-8?B?VENTalNkV3pIMm5IV1JmU1gwSEZDUU5ZR2dUeWZWRDVWMDFsY2NKV3djMnlI?=
 =?utf-8?B?cnFtWFJFS05ta0lhOVdKTzhVc3RqaXhZZ0llU09oQ3BMUEtQR1EzRllwUkhD?=
 =?utf-8?B?Uit6VVgwaTgvOEIzSE9heEpwUCtXVkx1SkFlY2Y3SThFZ1paNHRqeEIzNmFY?=
 =?utf-8?B?NzJoWXVlbjJWQTZZcmpWRWRDY2pDQjN2dVMvOXBycHQrUlo0citScTVnWnBU?=
 =?utf-8?B?ZlhINU9sSGZMbW5aZkp3aEVmWFV2V3VZUU42OENzNXp4NEdqU1ZpZlJZS0ll?=
 =?utf-8?B?MWROWkYyK1RzcjNsQlNWUU5wMnZvdHFaaGRGVlRSNFlVa1VRc3dPWVpweUlY?=
 =?utf-8?B?L0MrK05EV1RaRGNZRlJPQXNwci9uSHdZWmdNbDhHUVlaTnB3SHhSdGVaNy9u?=
 =?utf-8?B?c2NtYjUxUGpQM0JiRi92N3g0anM1TzBCTEFMZUc3V3RaaDNyYTJsVlV1MUVk?=
 =?utf-8?B?NysxTE90c3FjN2Y5OG9GaVhmTkpBUE9iVGNLY0lEcm5oMHV4c2RzbWpXQ3Y2?=
 =?utf-8?B?TFg3LzVBUGZtM2hlZXR6WGFEVStlWU83RStTemFvMVFBbHpqNC9xK3NyYVBB?=
 =?utf-8?B?c3dNREpoZDdtWlV2R3lOMEg1YndOSnQ2enAvdk8vRDZQRkNNS09aYTUzeUor?=
 =?utf-8?B?emdSaXRZN0V0N1NRblNZZG9HamhHZExjUDZlUnF3dUw4U3NIeFJrbnVJbU83?=
 =?utf-8?B?VWp5U3hPc2pQVmtYb0JsR1pDZnF0eGdhMDIxWHIvRzFoeE51Q0dPMWdTOXAv?=
 =?utf-8?B?OWJUNUl2K1FvK2g5L1FzQ3BadVdzL2c4ekc3d3JyRWY1T2ptdlFWY2ZWU2NR?=
 =?utf-8?B?S3Q1SU5jQndKeHBMRFBMTmo3YVBmeHBiUkFzaUJIQS9HUllVRFJMM2xVcVEw?=
 =?utf-8?B?dlhTQXZGY0NENndkU1RIeEZKVDZhZXdwL2ZWei9vOWwwTHdUUzkvRnpUWHBv?=
 =?utf-8?B?RXFMSFdtcjB5MVpTZnBYVmovWXVxTytZTndvdWRmamN1Rjh2bnNQUndBQWt3?=
 =?utf-8?B?Yy91WEl4YTgwTDJwNDlXRjNPTWcxR25mZXhsQXNYOVJHZU5tblBqbGdDcnlM?=
 =?utf-8?B?RWtnSlovZmJrQkk3MEVuRG9ZZWVSbEN5b3JzZXFhMG1ReTlicVNXNG5oNDE0?=
 =?utf-8?B?amZWczB1OTJVYTAwZzlxeXZ0S01FU1dpMEsydU42ekk2SHZUSlhwa3E2V1BX?=
 =?utf-8?B?Y0NEQWZ6WFZTZDZONW9SZWRSNXFCL2NhZHoyUHBHTzlISVc4K2lsQnJNQ0wx?=
 =?utf-8?B?bkF3elFLUk5Ga0djZmw5TE9WN1NWUWl1QnljZHRHVTZpWkorK3Zlbmh0UTg5?=
 =?utf-8?B?cjVINDJiSTZrVjI0RUliZUVWai9mOTFXMzl5Y1E5RUN2K1FuUHVGSks0b1c2?=
 =?utf-8?B?YzFYbkhqeHErVHZpWlZhRm1IYXIzcmJNUWtRejR3aFYraThWOCthWk9IdXJv?=
 =?utf-8?B?eFNBZ2Ftcld0WEpCSlBlTkFjOXZsRENRUUY1Q2tLaWxNMGdEVmxiTFU2Y3A2?=
 =?utf-8?B?dHo3STA1MUpGRzFCaGFmYWhVeFpGY2JYdHhZeUVCZ2lab2NYRENoc0VkcWdh?=
 =?utf-8?B?NEt6YTlTZGxLNDNPb0FYa1c5QjlBKzQvTnVFa0RxTVgvamN4dWJraFlycjdX?=
 =?utf-8?B?eDJDMndZQmtMdXdZeUlQVnZSQ3lxeklPUzRpanNzTUV4Z1VyK3hZV2ZoREJ0?=
 =?utf-8?B?ekVOOHRBSXh4Qkt5Q0xOaE1QOE01V1N5ejVWOVhaaU5kcnlTd3FxQi9UYkV2?=
 =?utf-8?B?MzdSWml6Tk81QlhyZmU1SHAvUDFtSnNOU21ZdW1DaTJpRWE2WkhWZHorRTY0?=
 =?utf-8?B?TGZnZzduRG5PamgxdjhtVVJPNE5oT1dqZ2xwSHB6ditXbm5VaHNXTTNqdHph?=
 =?utf-8?B?M2ZoeEp3YS9odUpMY3ljVW5ZNXNoWHlySjBwT2p0c1VEdUxtWGFIZ0JzZWtP?=
 =?utf-8?B?aFhTbFVYemFuTHdrS0kveW5qYk80Tm5IV0FpVHhiSFdBc1Q2eERTemFPUzVF?=
 =?utf-8?B?YWtmVlF3Vno3VDVUbGVad0J6VzI5UUJUUW9OeDBPMEp0cGNjK2JVL0U3ejVz?=
 =?utf-8?B?K0UrQmY0MFpQNnhPSThLTDd6ZDExT2NIWG5Ddmd0dlZhRHU3MGlwaDlreGht?=
 =?utf-8?Q?1FCAyzP9IF67iZB8bLTetgg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vgoU2O3VJezWNTCXeKlHsyEOOjlRcP9kKzXSbBpiycb6LiNP8oC5LxCWwC6IezTVzxUvwhDRQDStAfFpqfFxNsxzvSAIJMwJSIBwsns5qMDISQnc88PS+EPV82ZdjngfZWZ4bRn/gOTrzydbQuMgxn5wk59COR1ARGzMOiQakJUg6dY5+dHxAPcVoKvvIqsD005fA8UX10OpWPcuml1yDH/EDmXl6P2fyNsrUWm8zIud5rj4pVZs7mcWaoLM1HtKlPOfk2+jk27jV68itxPq64RuX1j3q9I4xqVpJ7sg80p/07gwdu6i23zxN4MRLxJsykcmbU5zJ7lu8F4+7gbOX4ftHBBO7T8TVKYOjLbbw8s8InvVwVL2HdeR5g2f1xd1dLl6jsS1WJr4W+FNlAU+6tBm5Bu8dOqu7EWEb/J80VYtDQ+jYFLgyDe4sklz7fd6OIXRS5g2fEidUxaqWB2QEkAGYdbTPRIYLQZMkAFnFpDLBwhfmX5/Mmbl0cB9VUJzqhRpLkGfLvlurbNKYnfppXcVTPZcXzpvj5e/eYwI3Bib1YfNVTLxUtVxDtB9lFaXDRERobrbiHH5Bwy9e0N997MAHClp/PUZO+gsgD8dn+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd2911c-c2bf-41ef-5a7e-08dd9253a79e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:23:35.2651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQXIEIiiFiJtXzvJHOlHFiqJTOoid/gNR/Krim2QXqDn0wCFNyvMAQF8aU9iBdA6xurPmpI7B3XHxd8I3kCpx/wVuuQZGqoeetuFp2OXIDj16PLR36lAh2qngJfzgeoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7960
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505130184
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE4NSBTYWx0ZWRfXzQzhett8s86p APvnC5/HN+PKVFjYpqr6gHOTviEiS04HR92KtzK0xKVrCdnqmJkOuPkFBmTP2fRmQ1foQI8Pecj T2iKh1e9H/98Oyd2z/G87TM1nwq/emBMEtSxpAUD+MUboNl36MsAqlsYgvmjepTB5kkFOzaJwRt
 8QPN5MD2PJMRsdI196XU9/yVnGl5Xyv7ZJvJcWQwBklniD8tqFlYsPjY6iSvi8dVrrV3chaIoOz 6WoX/0/2ZLF0JsROkH7Ss+mJddGg6Fbf6MozZ3yFfFhDFY7P0YSCizaYum5uSNiaM6QGMEKxMIO uGyCwSR82hhd16sautz86GZ4ihRFd3PA6aOlZAuenYitip5HaEyrg2Lgd9lGQbpp2MDpyBV0eEJ
 hY7BqmkBxqSGGtL8xpwcgf9DbHtz71haKwVXNRz5J66mBC/vO9enojpAy9WD78e9N5kL05Gp
X-Proofpoint-GUID: jouWIaxHM6NhfaV6AP2Vvt3Fa221UoJZ
X-Authority-Analysis: v=2.4 cv=fvDcZE4f c=1 sm=1 tr=0 ts=68239c3b cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=LtfXezWpUvz2qa1GnkMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jouWIaxHM6NhfaV6AP2Vvt3Fa221UoJZ

Hi Steven,


On 13/05/25 23:47, Steven Rostedt wrote:
> On Mon, 12 May 2025 19:58:39 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
>> Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
>> Cc: stable@vger.kernel.org
> 
> No need to Cc stable. This isn't even in Linus's tree.

It is now(today) present I think: 
https://github.com/torvalds/linux/commit/872df34d7c51a79523820ea6a14860398c639b87

Greg queued this up for today's stable-rc which was released for Testing.

Informed him about this fix:

https://lore.kernel.org/all/88d537d6-57be-4fbc-9722-15997a022abb@oracle.com/

Thanks,
Harshit


> -- Steve
> 
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
> 


