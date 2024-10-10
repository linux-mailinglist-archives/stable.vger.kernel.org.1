Return-Path: <stable+bounces-83374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC85998CED
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 18:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB20281BF7
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E991B1CCEF1;
	Thu, 10 Oct 2024 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0uwVr4w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k3th0AMM"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CA2207A
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576737; cv=fail; b=iA3VsOrOPPy0fVr8odU9AxTYu4SBN8mqnbNq8CUsAszPiQSrUacIzbZvtcXpAnTvCVH6RsD4UNom6fstaqq6wehkaXxCn/Jemyt7QJsqfl+ka3kQpprPE1ZvNJ1qWos9tsip6+jFDziba21HxWjxzFCKh/hw5nMkBuL152G7Zig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576737; c=relaxed/simple;
	bh=/6E088JBySX1T4fEnDqoYOYNRO+Fs5xzOvgLS+nCyVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YaGxuqYcM1U88NoCh/bLdvi+YHR1NWFzJMJMrfo84+EmTG1MkW+ZIbDCsLNghOz4bfeRI5iaZ+VAgllQZapZJkLW6hdJS5cDIUaLB/i3lX9dU1VvF1x3D2zAe/hf8IIOnWtm7jEDdYvGUjGGmXCiNbi/FgEFq+wcnAD3DTeKgHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W0uwVr4w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k3th0AMM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ABMedZ002842;
	Thu, 10 Oct 2024 16:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/6E088JBySX1T4fEnDqoYOYNRO+Fs5xzOvgLS+nCyVQ=; b=
	W0uwVr4wMOjedyN8EXNm6nafNCgSPnPcMQmqhsX26LS04M6DLDmlymS0IKfHDtye
	OSbpkKd3kTDA5W9UFIr9fTXqHFIis3VROZaMuAHDaOoRCibaAm5SXbjAHweRfNjs
	GSo3wn4H74uY3uSkFsEO8cOhCW0Yo4HlQuROJnjPEO9oD4rVC9KfoqxdUGVHEXkb
	4w8iV56dmECo2LTWy+ixlwOwB7Wm90bZW5nq+tKULpf9nytIjAwrLANE7OxkIHiY
	XPQ/w+SoCZGzQuRUCcaDgHLx9u+w3H1sNATynDy+cAbIfn54Xtsgwznvmkt1Ow+E
	POBxA5NLe60dkKIgs4iMOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ek66n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 16:12:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AFnNow017144;
	Thu, 10 Oct 2024 16:11:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwgjuna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 16:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aiH2MyIk4r73p50u13RnVZ9MszLCYz+jdgzdJoBXJR7lHYmAhP8DT4tmO8YSBn4XaK/2wIpsAZ39jycWVSja9OKKh1TgBk7JDBM0FGUGgAa1x2liwh3+ospaiNuK9kKwLPqSez1b8ZlmxLXtuo0QL2borK3LW1mp5pffy6aCXby+uDiJ3wI5KGCrmb4pSbhDy/IV8QJjgkw8HEkO5Np9mpx3+/HDmhuXcqiCBjAjTuHZz1/RcOVxB+xZds6oHcmhzLG/BPwMhbKSpf8t79ENiNKGu7Is3tCWEIhFgUl/ZspyNVeZBKhS/gyWqOg61DUtJNFX1PZkUsVHeDUbpg5ERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6E088JBySX1T4fEnDqoYOYNRO+Fs5xzOvgLS+nCyVQ=;
 b=fK+bxPhMl/iu5Y8hld+ElurJb8rOf167YNeF4jgffCSGutXJrbTV5rVaFvqpC8C9fEbGTgYwOS26KhndgzBQw5WyziQ6jCMahdiHg1/uIP0t1ifx7E88W6cnL6hCEEwoFwSfitiDD8EuawD8Ypkntw8Ole8vfJxv4xLUke3/cTrmSkCAeb2NZwN7TLtXmkn0P1v7XsDA3yAdJ4BGWaHgaaqWmF/+NrSKJMEg+BH3Xhu+2FmR/BCZc0DoEsWxYLnomsdR2ZcJyyg2PiV7v2mGGB2L0oAktu9CVIo4NMpywp/a7hi5N4Nts5EdCH4zFq41yBJhlFMtYeTaFZNl3VQM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6E088JBySX1T4fEnDqoYOYNRO+Fs5xzOvgLS+nCyVQ=;
 b=k3th0AMMJ7TSpsnNktBIZa4gptXsUmo24s0DauvYgYofV5W8s8BWv6RSwGD+3st3HoXN3ZvcO1UkT7nRJYdqZiMEszFAnW5V1cm4nKdKkLNSgvRo38zhELI2fkIFjPY2VLcSWxGGWYHv3dmLPgtd0PlBdVkPO+Avz3wvK8zfrH0=
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com (2603:10b6:a03:4ca::6)
 by DS0PR10MB6773.namprd10.prod.outlook.com (2603:10b6:8:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 16:11:52 +0000
Received: from SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb]) by SJ2PR10MB7082.namprd10.prod.outlook.com
 ([fe80::2cd7:990f:c932:1bcb%6]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 16:11:51 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: linux-stable <stable@vger.kernel.org>,
        "sashal@kernel.org"
	<sashal@kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "jolsa@kernel.org"
	<jolsa@kernel.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "flaniel@linux.microsoft.com" <flaniel@linux.microsoft.com>
Subject: Re: [PATCH 5.10.y 0/4] Backport fix commit for
 kprobe_non_uniq_symbol.tc test failure
Thread-Topic: [PATCH 5.10.y 0/4] Backport fix commit for
 kprobe_non_uniq_symbol.tc test failure
Thread-Index: AQHbGdGbNoTjnZWLdEWNgQWyeocORbJ+bOkAgAG9ooA=
Date: Thu, 10 Oct 2024 16:11:51 +0000
Message-ID: <D36D144A-02BB-4F79-B992-00C2BF6FB8C9@oracle.com>
References: <20241008222948.1084461-1-sherry.yang@oracle.com>
 <2024100909-neatness-kennel-c24d@gregkh>
In-Reply-To: <2024100909-neatness-kennel-c24d@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7082:EE_|DS0PR10MB6773:EE_
x-ms-office365-filtering-correlation-id: 32e2cd7a-332c-4ff5-f13c-08dce9464087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NG5Gay9iS3p3eG5QaG9JYmZPMVI0Qi9VSldvVW90SGZWVDlFVlVsUWlzVmFi?=
 =?utf-8?B?VURrR3BZRlNSa05HOUZFKy95V01FaEx3RzF1d3ZGQlhXeTFWL0cvcG9LZU0z?=
 =?utf-8?B?SldXbWlCMys5bHk1ZXlDOVc2bHY4NE5sdnZhd0tqMGExY2lmSzZOWUlhRmdC?=
 =?utf-8?B?dlNNb2kvN1VYSUViOEZNTVUxNUQzbVBFZXZjMnVycDdpVExWdkNYZm9hR0li?=
 =?utf-8?B?cVVDd1o0SURQemk3alJjL2V5azFzaDN4OWJkV0Vxam9IZlBKZWNXVFJjZ3NU?=
 =?utf-8?B?eGlmU3YyR29FOUpMS1ZNVnlpL3RXUUlHVmVnOHBTYnEvQzEwR2wyUkdxbWdp?=
 =?utf-8?B?aVcwSGZmUk04TE5TVFV5SFpmaFA0NEFqUGJHaVg5THFHTlduWVNzMnU1cDJu?=
 =?utf-8?B?bXFWMWVreXljQzVZMzNCbG0rZytqQ2M4Qk5vRVNIbFRGVUs5N3RvMUhBS2h2?=
 =?utf-8?B?eHBpREN1bVR3NUZmZzAwR2lmY0cyUmxZL0hrdnVzRjA4TDVrYk5DNEp1ZEVI?=
 =?utf-8?B?WE1YZ2VzMHNjRC85ZXlpSWJDV1NzbjA4TjZ0Tm5FUWNFSy93eENvT2h3eVBq?=
 =?utf-8?B?RE5CZ0NMNkltL1FVUVIvYm5lV1ZlZ3dMK0tEejkxSjEzWlJJSUZGdno4UlBh?=
 =?utf-8?B?cFlWQTY4amRyTmllMjBCU2E3UldOQnlJSzhEZWxDT2hRbzFYeU9QZlJ5TjBP?=
 =?utf-8?B?anRRUEJhTWRCZWFWSjhpRnZSOWZMSXhzMFRTZWU2Uk9JcFRRMmJIVjQrb2xI?=
 =?utf-8?B?U0FSZkNTc0hjdStpOTlNSnBtUSttRllUOFBZakdNeTdFcHluYXhTZ2VYeHZx?=
 =?utf-8?B?ZWw3V1JwOHF5dU05b0NCelF3R0JnTkZKdHVCYXJQUFVjWmw0WDdGU05qWGxC?=
 =?utf-8?B?OEE4Nk92L1NGQ0NFazVsa3V2b3lMN0xWNlJNRVZzYWVObmo4R2pJaEJxd3Zq?=
 =?utf-8?B?WVVObG9oK2svQ3JVajlBeEpxelQvSnpKblJGdzFQUFphSGdtamdKSmVkZ0l1?=
 =?utf-8?B?dTcvdUZrUVBtdHdab2wrTEFjVGhXY3U3Skl3SFJCdnJSSWxCWmdoZlhSbEtJ?=
 =?utf-8?B?RDlpWjZuZTJYbUY3ZWZIbk9QK3kzTWNIekFOMG83aFJEM2hpaTNLNzFuRFdi?=
 =?utf-8?B?UTFzTG5Ud1RzNHpJd2NIM0tmdkhTQ2k4NmdZc1puMHlabjlVOXRlUUUxOE9T?=
 =?utf-8?B?ZmE4Q0N1VnA0KzczQ2hsdWIvM290cDQ2TDA2L1ZVenVlZ044VWUwMWRKVlZo?=
 =?utf-8?B?Uk95VVFiRHRkWHNjeHJ4aWhhZFo5Sms4d1FUTFh4ZEF6dnFMQWRRbUdnSTA2?=
 =?utf-8?B?QUp0dklFanNmZE56NmVDZnJLS256QUxVSm9MUmxsVWZDVlc1WTQ2UkRiSGps?=
 =?utf-8?B?YnNCVWQ2SXl3akthTUtsU1JibEYzTU9HcmZYQWVVdTN5eS9jSkUxSm1PWEt3?=
 =?utf-8?B?Z09YMXVlSkNtYXNyb09aVjBoZjBwRktKRy9HdGlwWHc3ZTJXb0ZlMEh2M3ZL?=
 =?utf-8?B?Rkl1cXpQakkrYjZxYTNkMXErVFNVTmFIUDJmOXdMQm1Zdmp5Lzh6M1RKTjVv?=
 =?utf-8?B?VTJmSTRaVHM4aVJyaU40ZGFzVnN3L1NyUVJ3NnVZT1pzN0NBb2MvV2szeW9Q?=
 =?utf-8?B?WlZBSWpoZEdwaFRSdXZ3Smp5OWZQK3hqV211L1EyMk9PODN2YmxNTm55R0R5?=
 =?utf-8?B?R09hTThzQjJoOFlRelhZVEVqZjVkZzhranBSSTdVZzgxMTBIaytta05ncGZV?=
 =?utf-8?B?a3FNWTM0b01nd1Z5Zkw5ZFpOQ3lOR0FOWFJNVG5NeVJFNWViNkFhZzZhZUNx?=
 =?utf-8?B?a0tDNGFLK2RYbXlBRS9QQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7082.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDFFSFllaVFmQWNoTVMrV2gwZG1PRGFVYUU2Q1h6UGNmdlZIWjF6N2dDNW01?=
 =?utf-8?B?Nk4wQmdWdEZwcURIVjBaQVR3cDhsMFF3QWJDdStSRVRta09nUnJHcEUyWG9U?=
 =?utf-8?B?NDRXSnl0eXcvWE1FcmRkeXozN0hZbFFMYkhmTytkaVlFZXV4L0lzQVZybDJx?=
 =?utf-8?B?RHlxTTYzd2tpQ0ZSemwyZEp5dERBSERvQzNoZVBqZkdFSEVQUm80U0FEMldK?=
 =?utf-8?B?TDBoVk9EN3pKNklydEMvWlBrajN3dmYvbFp2aGY3UjhuNExSU0FNSjdjOEV4?=
 =?utf-8?B?WEUrakgvbEp1dGVKZ2ZuTDJ5cndYc3EzdEJDdktUTDhSd0xUS2ViN0E4ZlhL?=
 =?utf-8?B?WlZSaE5Ybmw5a3k3ZGRtbUUwOWZPWTZkSkxnM3A2MzNMcU43VG9TeVNZNU9P?=
 =?utf-8?B?R3NaWTdRZmhRakNyMmdXWERWbUZkdGVKd2FVdkNubGNubXV2VjJvOERtMzVS?=
 =?utf-8?B?VmJPcGNYWE80V1V2UE9jV1djZVFEcTR5N0VSdndLZVNaQnhETjNOMlJwVnVX?=
 =?utf-8?B?NXVpMWg4dHlwZFpxRVpHUGtrdkFPczJxNW1pYjlxbDhxVWNQSUZwM2tRd3B0?=
 =?utf-8?B?RDEvQXEzRnhZRkhDR0pCaFQ5SmxoTWptcS9hZE0ybzRwUmhyenhDVkg5K0hn?=
 =?utf-8?B?QlNmL1poR1Y4RzNWS2lyS0NJS3BTcEVOWVJ1MVFYNnRhWkc5UkVkbWNGVEZM?=
 =?utf-8?B?QmQrcGlnVjNtQ2oyVGxnK2djdnhEZmdmYmVXcDQ0QThZem43UFBkQm1janFQ?=
 =?utf-8?B?RkRWU0xLeEZZWG9uSXhrSEI2MEVDV1JHdm5RRTFZa2d4dzkzS0VSYkZHTEFG?=
 =?utf-8?B?UkRZTVphNW5kN2RWRGljZW1jSTFTMUFaUmpDemJhT1FDS3dkNE9tYmZhUlB4?=
 =?utf-8?B?TmJJL2VzclNrL3ZGTS9HdVJRbktmQkhwY1ZTemhOQWhXZGtRWGt3S1hzWE1G?=
 =?utf-8?B?VFFKTUdNV1FONVZmV0taNjVxZ0wrQ0pSNXRVV3d6OSt4UjZtZVpoMjRMbXNy?=
 =?utf-8?B?OGUxRTZMK1d1Qm1TYk1ORGdZc2NaanhsQ0ZVWDQreTFqcDMvRUJ3ZGV0V0tk?=
 =?utf-8?B?dkJWanArNnVTcExXL1RYNEZHN2c2TmVTVXdIV05NZktGQkZucTJ6QnVoTUdx?=
 =?utf-8?B?d3RMQVpuQTdTdDZLcEk1bFdTUldHaXYxOFF4bDNRbVI5d0dQY3BXVUpsVG82?=
 =?utf-8?B?VWtpOXdaU2tPR1BnN1p1VE5oZ2JRZ1dNR0pVVzU1cWE2eW5MbFJvNEZHbXV5?=
 =?utf-8?B?S1cvdHpqLzN6WEpKanhVempKbWw4NHlValo1T1ZBSDRyenM0SFArb0dZcUpE?=
 =?utf-8?B?RnQxVE1lL01qZ2RZRU5hdXozdGpMQXlPWXBiNVF4SHRjY2tGWTVyYzNpclQ2?=
 =?utf-8?B?dHU1V055SExITjlkc292dnBocHVUU2NqZE8zTXZBM1FtRjRPZ2pDWS9lbTZ2?=
 =?utf-8?B?aDJnejV0V2c4RE1mcUJvbk40MFZKdDJjbjB3MmdjU1E3elFDeFVieUZIMjJR?=
 =?utf-8?B?MW1aU0hKYmcvTDdrdUVvL1VnVXp2ZzM0Z0RWUnhicUdZWUJ0eXZiR0RuTDNu?=
 =?utf-8?B?S3hERXZtUWtWRjBSemVURk82MGovTHVUaGtCZGtSanlxTGdGUDA2eTdzM0lT?=
 =?utf-8?B?RTJPbTN4c3YwNm9xdGpjOVhrMS9mSzVWaHlIVkp3cUJYaUNNVkZxZ0FMWlZN?=
 =?utf-8?B?WmZNSlpXejMrdmx0U0ZLclN1UU9ZVFYzMjFQdmF0VUNXVjRVU3NZdjI5SEtW?=
 =?utf-8?B?OGVuR1JPYndCZndqdjVTSXNZMG4xQzhBaHp5S1g4a1lXWGFSWUQvVjk0Rzha?=
 =?utf-8?B?ZnRYZlJndkNibms2TTJCdmZidTcvR09NQkdITTFUNnArLzVSZXcvMGgrT3hN?=
 =?utf-8?B?MUlEeTluSUVDRWZGS2ZXWFJyYUtSZUZrQTBiWDJoZzZqOFZYbWIzS0p1cnp4?=
 =?utf-8?B?REFnUG13VlREVzF6UVFhRUpKVnk4U0ppVFcwUElHZ205UmhkMFVmTVcyVXlz?=
 =?utf-8?B?dkduWjVkaHJZTHd5aEkwT0pvbVE0NEJpOXZWTy9zaFdlKzNmYW4rTWI4ejZG?=
 =?utf-8?B?bnJKdlRjL3RSSURTUzMzcng3RHpTYWZQTlBFNE5VU1ZCZnByY2RnNU4wWXR1?=
 =?utf-8?B?N2xDQ1VBSzA2NzZIOFFHVno4bFZDUzRSaDBuclFRWjlDeEF4QnkrQ3ZVVi90?=
 =?utf-8?Q?8/hvpmlpqrCQkOGwyFnb5gM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C63B562E8B7D2A408C05D82825756AEB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wqerZBahuxY31mkdZpaEDFQ5o3xgXxnxRWucqFdQNR14bKwOv2IihtB/t5G3qzEf0Dcbo2aJNJTFOu3XSX3hHOznJgn74K8tkLdkseWa/keRu/nyfwBdmodgFSiDYBhkJdOdQLidljFMNR8qBvEc2moiXtrQgEaoPhJSRwwM0NmCIKV01tc4UhLU4SD6c+CMXPiyVsh+HAfLKeBYojTJ/Cyre/+VrIrltRp5OYfh+h3tYJ00dvGj4rT5+Aqx8JnZdZ6KGc3arrIY4ATgW+Jg0LkQ/nNdDtRomqs1nHs3dQjuObGQpR74bYndHa707BGImPeYI7eQ0jq2oa2vmTlnCMUBdAG9gHe6B+fu6NiPMgQ/mNeDLagHtYxId4gUk+ZOQYtO/p+Uzbj5SBNBHa9wy/07TlTOQrmBlgLRazOzVunOgInathSR9m0sxu9hKm86QHeLh1FrWJipvh9kBBQugTHOhXrth3U3/4RUxc2hNl5MNaqSJU05Vc86eqP6bwsvJzGxdCNXc0cDoFZzotIjTTOt1cr+JNzAiOaBXqJIe+ynkkC3Et//WJjKdycDzP9GIzzJfqGcnsSMJtGrt6mU28qdCYJTs3CriCQdoEJziaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7082.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e2cd7a-332c-4ff5-f13c-08dce9464087
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 16:11:51.8879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iIfMvRRUhaRoBbjvhkIz1d8Us7IrBmac/F9Z3gHUQ1pkA/KQXVKMCCAAb5iGvZuNUoXHLLbG4F0fIzIdwwDyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_11,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=869
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100107
X-Proofpoint-GUID: XxmyeR8lz3ewWBacB2ZtxRYbi863egIY
X-Proofpoint-ORIG-GUID: XxmyeR8lz3ewWBacB2ZtxRYbi863egIY

DQoNCj4gT24gT2N0IDksIDIwMjQsIGF0IDY6MzbigK9BTSwgR3JlZyBLSCA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBPY3QgMDgsIDIwMjQgYXQgMDM6
Mjk6NDRQTSAtMDcwMCwgU2hlcnJ5IFlhbmcgd3JvdGU6DQo+PiA1LjEwLnkgYmFja3BvcnRlZCB0
aGUgY29tbWl0IA0KPj4gMDliY2Y5MjU0ODM4ICgic2VsZnRlc3RzL2Z0cmFjZTogQWRkIG5ldyB0
ZXN0IGNhc2Ugd2hpY2ggY2hlY2tzIG5vbiB1bmlxdWUgc3ltYm9sIikNCj4+IHdoaWNoIGFkZGVk
IGEgbmV3IHRlc3QgY2FzZSB0byBjaGVjayBub24tdW5pcXVlIHN5bWJvbC4gSG93ZXZlciwgNS4x
MC55DQo+PiBkaWRuJ3QgYmFja3BvcnQgdGhlIGtlcm5lbCBjb21taXQgDQo+PiBiMDIyZjBjN2U0
MDQgKCJ0cmFjaW5nL2twcm9iZXM6IFJldHVybiBFQUREUk5PVEFWQUlMIHdoZW4gZnVuYyBtYXRj
aGVzIHNldmVyYWwgc3ltYm9scyIpdG8gc3VwcG9ydCB0aGUgZnVuY3Rpb25hbGl0eSBmcm9tIGtl
cm5lbCBzaWRlLiBCYWNrcG9ydCBpdCBpbiB0aGlzIHBhdGNoIHNlcmllcy4NCj4+IA0KPj4gVGhl
IGZpcnN0IHR3byBwYXRjaGVzIGFyZSBwcmVzaXF1aXNpdGVzLiBUaGUgNHRoIGNvbW1pdCBpcyBh
IGZpeCBjb21taXQNCj4+IGZvciB0aGUgM3JkIG9uZS4NCj4gDQo+IFNob3VsZCB3ZSBqdXN0IHJl
dmVydCB0aGUgc2VsZnRlc3QgdGVzdCBpbnN0ZWFkPyAgVGhhdCBzZWVtcyBzaW1wbGVyDQo+IGlu
c3RlYWQgb2YgYWRkaW5nIGEgbmV3IGZlYXR1cmUgdG8gdGhpcyBvbGQgYW5kIG9ic29sZXRlIGtl
cm5lbCB0cmVlLA0KPiByaWdodD8NCg0KU29ycnkgYWJvdXQgdGhlIGNvbmZ1c2lvbi4gSWYga3By
b2JlIGF0dGFjaGVzIGEgZnVuY3Rpb24gd2hpY2ggaXMgbm90IHRoZSB1c2VyIHdhbnRzIHRvIGF0
dGFjaCB0bywgSSB3b3VsZCBzYXkgaXTigJlzIGEgYnVnLiBUaGUgdGVzdCBjYXNlIHVuY292ZXJz
IHRoZSBidWcsIHNvIGl04oCZcyBhIGZpeC4NCg0KU2hlcnJ5DQoNCg0K

