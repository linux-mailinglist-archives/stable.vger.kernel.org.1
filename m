Return-Path: <stable+bounces-253867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DuDNe4EEWr5gQYAu9opvQ
	(envelope-from <stable+bounces-253867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:37:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E08115BC5A4
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DEB0B3006203
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 01:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B590122068D;
	Sat, 23 May 2026 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XpIzMpyJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G+zGV43j"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6A01F09A8
	for <stable@vger.kernel.org>; Sat, 23 May 2026 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500261; cv=fail; b=aZvdXrUpzpchVGWPDDE9XtAbXn6I8bdOehDfKLifbjkIg3uNafDjZ1qPffqz6+gyfAd0Lkek/X0Zw7Jm+x5a59qO3wFb9AZdxAh+yOPYNuyqBDkDpdJFNbQEtH/oR/kXl/sBizk98rvQh6t8J10ee099vOApUmzKTozgKv5ULKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500261; c=relaxed/simple;
	bh=/9YsSbU/cfy2n9HPiSNhhfIEXtGgdqYgN2D+8Cu7vA4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kcbNgkRUVX1sbIKgVIOdNKThJVjbPZV6eivq5dqwvMyRHFRrOCPJAx2dY3IU62oPuSXW6E8DQG180yAipW67WEmIN/z1x4dt9y05siRai0PTv+7OuMFM3Z/WSZJAC471WXGdMXNlQxM0O+ZR4MiiImu9eSnXDjOY2dSPBtWtN50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XpIzMpyJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G+zGV43j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MFmWs22077787;
	Sat, 23 May 2026 01:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cQwBUTyovffJXpRtlGeTU6JXZt01HX6s+SrJGwh0mvM=; b=
	XpIzMpyJ/N4VTQtrGkmD0pk3XOunEbsbq/RmWgeWjuKow94faw5t/WvA90E3asKT
	6gisAOWpCWgoQ8iofgzxvvBN7aeqc0l3Kf4usIPqb2BTXUy/1FjPMnsryAp9kOlF
	NBMsVc6hBh9czB/0ZNQvsZTBM7shjAuaL9x/P/fIGoVfM3BMyRdCCOrtCVC6D4LE
	AimfL4vJjcbkFjrCXpb8DrzU4KATai1dgYcuXQgix/3Rkkgy2ioOCrfC6XocEZbl
	JWmM2wPe8Rwrxn5XQ5yKw90+18sOBLiGRLPGUoxlMID2DrjvvTsGOcpOa6cvXjtU
	TMl18r7PHhjFmbBAqc1kzA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h4qc5bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 01:37:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64N1Z8ZN038281;
	Sat, 23 May 2026 01:37:05 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2p6g1h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 01:37:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwHpsBMnmo/LukTFd4NEu7x+rTKzslkdrfeJTufNgkCNwzFILLz+sLpRnvlby5Jv0ozO75eEfKoars91AAd8au91YnPN0gO28sFHG03nYzqtFonJwheUJ0Tb2zFpqLXWo/8lohtwO9uiaR2AUrH7FGG9pjJ+5CTwT4yUV+RG35YHBO3zMsoL2f1sto2IeaE0PGYa6koIwTIs7h59VidE1Ej+aricOaVAlmag++EBj+nacJNUm3ZgXXC0bxZQ9r3H+PIFpmNvU8KHzz5llhFKuEW3OXDzgPRN82S7jxQBX+0a91MYfxs56POTBgg0J0IrrcVj6R96CDxsLy4DHWd4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQwBUTyovffJXpRtlGeTU6JXZt01HX6s+SrJGwh0mvM=;
 b=JTySb1kyFysWxavdKHZNLP+E7wBkvlqaoR0UN6OUPr3VXfTfXWKCXvLHH8+HidA0b+xfeNyFJ1eYO+4zwPj7Y9ENRTXWHP7ASCJNAY22LMlKFXe5U2BPbHBTlmvr6tkQw2Z50594l7U4zH/gaq9Ku3XbKj8BAhs9vtmsiHdYQs31nD0mWckko/UKgC1v2cFzDxySy9Oq/VG/JWgXtTjtx2wOEIpx1CxvBlx8UmTFLCw64hmexdooCiNVSPt3fDfYhWy3eAxAzqNeu/hXdDeiZRoZohXcJeB8wMfUprn/Zwb4g4/0BOljYSM1XzF8XD/hLvHPEKv50PHqh1igPnqU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQwBUTyovffJXpRtlGeTU6JXZt01HX6s+SrJGwh0mvM=;
 b=G+zGV43jNhTWKiNazbeJm55pHJNtAxWG0gyCivnS+J5D1f7bpm51jPpMOsihXPvsEuFK3xljkgiNmr+LMPZVOYIPhhRVW7Lq9KFYTEqkUSLCigx9Any88/0TgHD1mYAyFIUIwwL4OEi3ZrtalLiVcJM/MJJ95YjK37PFpwBidDE=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 01:37:00 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%7]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 01:37:00 +0000
Message-ID: <fae7de97-57d5-47f5-85b5-b32aa28f06ef@oracle.com>
Date: Sat, 23 May 2026 07:06:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
To: Ben Hutchings <benh@debian.org>, gregkh@linuxfoundation.org
Cc: imv4bel@gmail.com, aaron1esau@gmail.com, ben@decadent.org.uk,
        malin89@huawei.com, pabeni@redhat.com, rajat.gupta@oss.qualcomm.com,
        sd@queasysnail.net, sultan@kerneltoast.com, tanjingguo@huawei.com,
        stable@vger.kernel.org
References: <ahCqJlqexPCiB0P9@decadent.org.uk>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ahCqJlqexPCiB0P9@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF0000017B.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::46) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b20173-76fa-4146-6ecb-08deb86bc897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vk50P6lB86fw9WLYjquXVsmOxRZv0LDPoYNg2RX7J+sjKnnknkYHpHyaQ4HBGkAWSFuFsYZtpWvtlhSbq6TZXl/6dZxc+56JqAu+NTMQkRhKgF7BaMXdTGHa/SPTvgHQoF62SCQaLdPoL9F3juupXxtiFzAmcBybbIgK2TfXWZzdhMfiayoFpjjh/YpPULWgZD5ZA6qp7HqI426Hz053BX8b6TD7JUdyd/Y8cg8yKtnh87+uXVo4yRTkZ7FhIfWjC7wqcXnitZYatbmKttGaqSJ0UnmIie5r/vXH5BOVey6OiMGOHU9aN4q+cPYv+uIw/U/G2S6NOUHq3VFn2BvAatbEDxdHrr+hzAQdVyadeUgbs+hzHXJ4J6xqEzo1nAKoAONI1/se57Cqy9YaPQwribIpkIAXcGusYII8TZOL02GZdmt5vGluM4vJmxB7JBSnznkexeudE49c+917+EodXzsmhLqiujZZOz5e/sxqcspojMQ/ksZ21vkfWWkLCvX9XhB2QxkJbgGI47WAWQez4Z1LPTsGMU6sRdNHBpLFaQe3D1nCAkh9pYkommec24CPHjTTO8vf3H4QJhWrQ0o1gH9JwBPXNCaZwTSuA8/d2bvw9byd6oCYtUNvplktJmkd0AR+X1qGknJpgQb6XplK4A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWZhaEEwVGl6N2xpUHBEazdKcVZCZUNmNmpiVFhHa3ROTnR2d2ZGeDFJV2hN?=
 =?utf-8?B?SGJvdW0wL3kza2kreWxJQ2FJMHF3cmhzR0tIdUxxeEVrVGtzUXZ1bXJwNzdC?=
 =?utf-8?B?Mld6azB2ZnJyeFdXOW1qVzJMS3RyLzU2cWl3amowa2twb0k4em9ENEUxQXRy?=
 =?utf-8?B?VTBlUkd0OXc2Q01uTDBxZytJdGJaMTkxcTVrZUZXSmxYZ2J0dENlcGlNbDJG?=
 =?utf-8?B?eXpiMDVVbWVKNFRnc1lUaFM4RHM2cDdPV0xWUkVFM2JOeld2YXhaYTc5dGVr?=
 =?utf-8?B?QjR4OFMyOVVsa1NjQXlIYVR2aVlFaW1XbnhiaS95ZCtRa1dNT1NHbUMwTjUz?=
 =?utf-8?B?UDdNYkJkV2ZTTzFFSzBER0tXLzcxeFU3QVM4cEZyWnBlNm55cXpXeXI4TGs4?=
 =?utf-8?B?Y2NTdWg4VlNWU0h3WXdYRGFtVzhKVncxRm5SUXNHSThpSkpjakZ4cUV1NzJp?=
 =?utf-8?B?NzJLVUwrQjJaWkltUEUyN3lOa2xCd1FDSFV2Q1lMU0I4OXc2OXUyMm9SQTRX?=
 =?utf-8?B?UHBXd2FZdjhnYXpZSVgvV2tFZW1IclJ5OHl6YlE2TTB1eWtnaE5VOHo5aStG?=
 =?utf-8?B?c0RqM2VBSzVXdUh4VCtxSHk2TUNTNno1TDE2ZExlZDRRRStyRzFwTVZZU2ZQ?=
 =?utf-8?B?dEdnWW1UODlpLzFqRzZWbHh6dDltemdjVDN0cHM1Zm52L2lXcmthd0tDdGdQ?=
 =?utf-8?B?OWJ0QW9ES3ZWcFdWK2hOdFU5UzZqSWdLQ1IrazR5RVBuMW02bGc1NTVKaDZ3?=
 =?utf-8?B?WUt3dWdROWI2UktCT2ZWaGlVaVIvSEk4UjFGOHhIOVVYNVgxR211UThGczZE?=
 =?utf-8?B?Snlxb1djNENuRDhmQURyczJSNHNqcUFjRWEveGxzMmRLUzdISThORW4xS2lj?=
 =?utf-8?B?ZXNiWWdhT3VCcFdzUXFhcFVsc0c0MlZpdVdlQmwxYmVQSWZCRmNseDNkUkVv?=
 =?utf-8?B?NktqZm9VQ1hpVHBNZmorZlZkaGV6QWd6Y0ZZbC8yeWNONmk4QXhrdXZFdSt3?=
 =?utf-8?B?R3hxd1F4Y2tKK3NXcXZnSnU1YkRDV2tDOVVHTXYwVGZ0aUtDcEhJRlZPWjlo?=
 =?utf-8?B?OEtLVWZqVjJ6MDZ5UnRtU3c4UlZKcnM2UmZuTjlBMmVocVlKZmIwbWxXbFln?=
 =?utf-8?B?MXZySDJzQlFLYnRBM0JJMHFTQlZIM2xUVWZiTkYremVpbkRjSFFtNWxOYUN2?=
 =?utf-8?B?ZXFMY1hVSU9KZS9BelJJYzJidmo1bEJya3YwajR0eHBTd1k1aHM5MUJSdTMx?=
 =?utf-8?B?VXVCRFpLUXFUeGZKRm1WeGxpaU5Va3A4eVZLTVJGamZCVWVwQ1BuQzJ6Wkpx?=
 =?utf-8?B?d283dDlQZXVCOTYzYzcxS3BBUDlmKzdCOGZSMTFiZ3BuR2VmN0JhcHJHZ01P?=
 =?utf-8?B?aTV5ZkZQVmkvSHBydnkyRHgwazAvUDdrYnk2S1VWOGhnYzlSVTNvWUlFdjkr?=
 =?utf-8?B?enVOeTkyUldERkI1cTVBSTdaa0JsbTNjbSs4Q3dJc3k2UUV0OWhTZWM3L2pP?=
 =?utf-8?B?S29oNGxRN2xFQVVIY0hVSVFNTmRPZlBhWjhXNlkzZ2NlSDJmU1F3Z2RlWmJp?=
 =?utf-8?B?bDYwbXQ3MUQxdXZpVGFJeXo3YW9wZDBjY0FrTEJ4N3QwNFFYSCtrOTJiVXlI?=
 =?utf-8?B?bXdNRjc0aU9HZU81ZUwwNFFFL1lLeXI3ZXNNaWYzVDNzcWJnK0F3Y1hXWWl4?=
 =?utf-8?B?dGhxOExYQUdKNnVsR0MxUW81QWJ2NnBEWGNEOWVDOHlBSThIV1YyeTdXc00z?=
 =?utf-8?B?OElTelNyUXFkU2MrWkllczZ2MDJTQ0hDbzRlK1RxSUM3MndRNUkwRVVmUVhj?=
 =?utf-8?B?UHRaR29Pc0FFN3hYbTU3V2FMTnQwRkpQZ09lSkxuZmUrZ3hzcUVUSkhDa2lT?=
 =?utf-8?B?Kzl4TkM5emhmRGVjakFzR0dMVitxRlk2WWVIblFhNFlYZG03YzZGbFBzUW5h?=
 =?utf-8?B?bjQ4WEdlVmliYklnTTh2a2p0MTNsWHA5eTRoTjVlaS90alZnWG91VjgrQVBZ?=
 =?utf-8?B?OWxaWm1nOUdwbVU4blk5Y3RHS3RocWR6QmV0elBxak1MQjdJZUV2MDErcGxo?=
 =?utf-8?B?c0djSDEvWC9PaG5jeUJBak9JR1BJZ1NKMGNNczFXbktiQmw0dVczK1dkRXJn?=
 =?utf-8?B?Z3FFdzBGcjlGdzh2b0ZmVUhndWlXMHdrMXVuZmpLSnJnQ2NKMEd5VzdsOFd1?=
 =?utf-8?B?Rk5HdmsrdDh0ZGFZNFN0UVpoY2dDMjBTS3RralhORHI5ajZMTzhFMk1Xb3Ew?=
 =?utf-8?B?amxsSXRJRWxreVNvS2xrQnViVVlRY090RDBwdkUwVFFjUDBPdmdyQ21tY0dt?=
 =?utf-8?B?ZHZSNVlkT0hXcjN6WjMrTHdCdVZtSVFmbkZUdVhtS2E4MWMxUGRRb29sNjN5?=
 =?utf-8?Q?DJPNY/kpJABWSzijMEfRPyHquSrPr1PnyYxpy?=
X-Exchange-RoutingPolicyChecked:
	Nb3VtvrdixKqhxuT3GDjsIONQb/Kul32LNGX1yCpR6cu1UxvGt5wi9K90APkiZ4D2fVheO2GYmDX4nul0zHL9hDZBXU3ldgYtJ+Rqfk4dLERsVI6Iiw/lMJd47WNYCahytERGuxsyULD1nK2g1bDQ3FpGK7ojCLbpuB05qEsgeFGi0iBCin/Dk5CLXh7nB+8hAQACBQ3B4YKdYatBqOoZdR2YoPKG1+SJw+rksiT+764wJqM0w0PEyqGfVTpA5N2ViqHc654nErlO/HTThlFGudUH9Uz1K4r5QiXxWGWvtXi+xgwnYWzY8ELPPGj53RXnPDKA+oZGThqDJO1/xbZ8g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9MgyhUKpc5KUDu4Zt6ABT7dkBd3KuYsqjuh67Hm+mVx41Rl7pIwNcq9sialbEK9H1APaqeMQjVRAod8m3U+p17nkmait923emnpLgBIU0WdgugzBEfenaepwYzbC25oBIbbi5KFSq0yMqc5lkZ9La7OA85J/V3Xmt0iMAUPzVr7RfUEr7rcoHBq/iJSXQTeXfnDpPTw8zRLJm2SCThE24l1mnUBM780VJGc3mCAb6iD6nH62qo13rqU/9piR+BAxRHTRUNDaAgtFMDXw9CnlEGNScs9PNKCbRkVACKIE6d7Jfs0PQ6KPGrJpI0T3zPWXWR/Z1ikF0z8CrQPHzc0SL9MaH32VKFr4O0dr5LWkQlD47kF67cez4YVsAL0dKSGGCUA8YyAJH5h7GQgYBG6ep6lEY1+Ih291DZ1sumMvIA0KIJHF4TFqWA5OIKoQZL8bngcGRmSo/QWtmr/MLO+27AOKK+Ni829jjzftTpFwGEvIWII1J61oig9Jy4Ym6ZQ+K/2wlfDeOR6vqvHnNyzNMx8kwXnP7vvDPPf6Ni86T3A0vWr0c2NUGD+eaE3VFNpuS8W0Pmm2j+Vx1e2xPev8qr06aROeT/uMYBfG20j1Eic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b20173-76fa-4146-6ecb-08deb86bc897
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 01:37:00.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWevcWE9EQKBnKBx07K6SApBba6A0dNw6qZkFMRvXeUO0jzmMTTSZ/F7Hhxk7VyIaiw2D+gL+Da7ejnd0YMb/28fw4iL/VL05XuVLgcTfzqOyKOfT4ILp5+vJmS3uEQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605230013
X-Authority-Analysis: v=2.4 cv=NdnWEWD4 c=1 sm=1 tr=0 ts=6a1104c2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=bC-a23v3AAAA:8
 a=pGLkceISAAAA:8 a=AeCkNC4mAAAA:8 a=Ia0HVi91AAAA:8 a=8T59DR07AAAA:8
 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=xNf9USuDAAAA:8 a=WfExQWCggy4nfKAogZIA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=3H0rhiSm_XezoJcgKFaR:22 a=dzohbJX8CEHOwgtOZ_jj:22
 a=nH4QB3FtVBqZfhiODIJV:22
X-Proofpoint-GUID: V1ZQRO9NUdyGg3lSng6UrJQLjDXA6G_l
X-Proofpoint-ORIG-GUID: V1ZQRO9NUdyGg3lSng6UrJQLjDXA6G_l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDAxMyBTYWx0ZWRfX1XJ2rt7C4gSZ
 1qNnXlLCzRUXUZNTymPT1xccEF0tvMHXk4xP6p3uORU6vlx23+L3smXDHpGBlT51d/Q8UKCjp5u
 ieGkfwXpbLnsyyr40EkRHyg7XSC8vXf995Ho+dxz3CCBqzLV5KVboChPPvi3KwFcy0t79VNlzdx
 +OZL2Q1FEPDLusaKw2eUGNXs1VALUUr79F5q93GpPcEkHDo50eMe0ESOQkPXqC9GQjxyxI05tbA
 Zw7It1TxDKhZ+964FBpc/4l3XCRknOGIl40Pbd+MABTO43hgD0sEfn8ZYqJYu6tBZ6C5qcN4l+H
 tj+gTiMAFOAFceHT8/EnecXD7E7ZZE9yFPAhrjWynrMrKg28CBrp0Sg3MzZ7S5scOSiXNUUf1an
 X9cJksBl1fjyQxLGjVmwismTZcmScgoBLUW1fUgpYrnC/fmydkDuEEy7tf1Yu5rZu/HFzcZupuM
 YnZbjpHCHmSoMQqKwbw==
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253867-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,huawei.com,redhat.com,oss.qualcomm.com,queasysnail.net,kerneltoast.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E08115BC5A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ben,


On 23/05/26 00:40, Ben Hutchings wrote:
> From: Hyunwoo Kim <imv4bel@gmail.com>
> 
> commit 48f6a5356a33dd78e7144ae1faef95ffc990aae0 upstream.
> 
> Two frag-transfer helpers (__pskb_copy_fclone() and skb_shift()) fail
> to propagate the SKBFL_SHARED_FRAG bit in skb_shinfo()->flags when
> moving frags from source to destination.  __pskb_copy_fclone() defers
> the rest of the shinfo metadata to skb_copy_header() after copying
> frag descriptors, but that helper only carries over gso_{size,segs,
> type} and never touches skb_shinfo()->flags; skb_shift() moves frag
> descriptors directly and leaves flags untouched.  As a result, the
> destination skb keeps a reference to the same externally-owned or
> page-cache-backed pages while reporting skb_has_shared_frag() as
> false.
> 
> The mismatch is harmful in any in-place writer that uses
> skb_has_shared_frag() to decide whether shared pages must be detoured
> through skb_cow_data().  ESP input is one such writer (esp4.c,
> esp6.c), and a single nft 'dup to <local>' rule -- or any other
> nf_dup_ipv4() / xt_TEE caller -- is enough to land a pskb_copy()'d
> skb in esp_input() with the marker stripped, letting an unprivileged
> user write into the page cache of a root-owned read-only file via
> authencesn-ESN stray writes.
> 
> Set SKBFL_SHARED_FRAG on the destination whenever frag descriptors
> were actually moved from the source.  skb_copy() and skb_copy_expand()
> share skb_copy_header() too but linearize all paged data into freshly
> allocated head storage and emerge with nr_frags == 0, so
> skb_has_shared_frag() returns false on its own; they need no change.
> 
> The same omission exists in skb_gro_receive() and skb_gro_receive_list().
> The former moves the incoming skb's frag descriptors into the
> accumulator's last sub-skb via two paths (a direct frag-move loop and
> the head_frag + memcpy path); the latter chains the incoming skb whole
> onto p's frag_list.  Downstream skb_segment() reads only
> skb_shinfo(p)->flags, and skb_segment_list() reuses each sub-skb's
> shinfo as the nskb -- both p and lp must carry the marker.
> 
> The same omission also exists in tcp_clone_payload(), which builds an
> MTU probe skb by moving frag descriptors from skbs on sk_write_queue
> into a freshly allocated nskb.  The helper falls into the same family
> and warrants the same fix for consistency; no TCP TX-side in-place
> writer is currently known to reach a user page through this gap, but
> a future consumer depending on the marker would regress silently.
> 
> The same omission exists in skb_segment(): the per-iteration flag
> merge takes only head_skb's flag, and the inner switch that rebinds
> frag_skb to list_skb on head_skb-frags exhaustion does not fold the
> new frag_skb's flag into nskb.  Fold frag_skb's flag at both sites
> so segments drawing frags from frag_list members carry the marker.
> 
> Fixes: cef401de7be8 ("net: fix possible wrong checksum generation")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Suggested-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Suggested-by: Ben Hutchings <ben@decadent.org.uk>
> Suggested-by: Lin Ma <malin89@huawei.com>
> Suggested-by: Jingguo Tan <tanjingguo@huawei.com>
> Suggested-by: Aaron Esau <aaron1esau@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Link: https://patch.msgid.link/ageeJfJHwgzmKXbh@v4bel
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> [bwh: Backported to 6.1:
>   - skb_gro_receive_list() is in net/ipv4/udp_offload.c here
>   - Drop change to tcp_clone_payload(), which does not exist here
> ]

Thanks !

I have got the same notes.

- due to missing commit 8928756d53d5 ("net: move skb_gro_receive_list 
from udp to core") so added the hunk in net/ipv4/udp_offload.c
- commit: 736013292e3c ("tcp: let tcp_mtu_probe() build headless 
packets") so the hunk corresponding to tcp_clone_payload() is not needed 
in 6.1.y

So this backport looks good to me from a backport poitn of view:

Reviewed-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

thanks,
Harshit

> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
>   net/core/gro.c         | 2 ++
>   net/core/skbuff.c      | 9 ++++++++-
>   net/ipv4/udp_offload.c | 2 ++
>   3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 52b91cfb3bf1..ea6571c01faa 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -281,10 +281,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
>   	p->data_len += len;
>   	p->truesize += delta_truesize;
>   	p->len += len;
> +	skb_shinfo(p)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
>   	if (lp != p) {
>   		lp->data_len += len;
>   		lp->truesize += delta_truesize;
>   		lp->len += len;
> +		skb_shinfo(lp)->flags |= skbinfo->flags & SKBFL_SHARED_FRAG;
>   	}
>   	NAPI_GRO_CB(skb)->same_flow = 1;
>   	return 0;
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index fd743051c898..8bc4b26de5e5 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1798,6 +1798,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
>   			skb_frag_ref(skb, i);
>   		}
>   		skb_shinfo(n)->nr_frags = i;
> +		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
>   	}
>   
>   	if (skb_has_frag_list(skb)) {
> @@ -3789,6 +3790,8 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
>   	tgt->ip_summed = CHECKSUM_PARTIAL;
>   	skb->ip_summed = CHECKSUM_PARTIAL;
>   
> +	skb_shinfo(tgt)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +
>   	skb_len_add(skb, -shiftlen);
>   	skb_len_add(tgt, shiftlen);
>   
> @@ -4362,7 +4365,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>   		skb_copy_from_linear_data_offset(head_skb, offset,
>   						 skb_put(nskb, hsize), hsize);
>   
> -		skb_shinfo(nskb)->flags |= skb_shinfo(head_skb)->flags &
> +		skb_shinfo(nskb)->flags |= (skb_shinfo(head_skb)->flags |
> +					    skb_shinfo(frag_skb)->flags) &
>   					   SKBFL_SHARED_FRAG;
>   
>   		if (skb_zerocopy_clone(nskb, frag_skb, GFP_ATOMIC))
> @@ -4379,6 +4383,9 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>   				nfrags = skb_shinfo(list_skb)->nr_frags;
>   				frag = skb_shinfo(list_skb)->frags;
>   				frag_skb = list_skb;
> +
> +				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
> +
>   				if (!skb_headlen(list_skb)) {
>   					BUG_ON(!nfrags);
>   				} else {
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 58cabb2bb32a..35c014e10f24 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -546,6 +546,8 @@ static int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
>   	p->truesize += skb->truesize;
>   	p->len += skb->len;
>   
> +	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
> +
>   	NAPI_GRO_CB(skb)->same_flow = 1;
>   
>   	return 0;


