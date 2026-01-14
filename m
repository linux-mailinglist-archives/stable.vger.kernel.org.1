Return-Path: <stable+bounces-208377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 279CFD20BE6
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 19:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D51D63028D83
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457CE31355E;
	Wed, 14 Jan 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PJBnftnw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qa4W5jvc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A62F39D7;
	Wed, 14 Jan 2026 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414588; cv=fail; b=BU1kCl7osDsqJ8zQIr47UUzUxnPv8g03TaqYwYYbwyFYzLpQivORe/a1yeyMw5CU1/vAdkI9KBZJgobBsMMj47E/z1sTFqk72O0E3EiM99JqRxpL1NPRDKxs3KTSxaSWqwIjboxSRC+UkpM4aAXMLdrs9tGxkKfWeklpYvz1ayU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414588; c=relaxed/simple;
	bh=VZoR4NxPOLE0uQWwO72DZWdBga6LKN7ytekJ8vNn2G8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gt+N7+9yqSn5o04PmABzDJp7ZveeURI3Sbcol7VTe/XCsTEF9TWQpgARHAQANkOe4wjJw+0EhKJJWL16eiYAhOsjy7eJ7K8Z03rItpxw1h2Vev53iKn3kDR5XmoHb/SmjzNB/jrpe+RHormrGct55JRwg8gQUqGqkgMEW2i/9vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PJBnftnw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qa4W5jvc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E7G2ZI2753003;
	Wed, 14 Jan 2026 18:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YKgmsL9xt/mhdoUkJCXfDnocF1i/Oa+3JdOUx+9Vod0=; b=
	PJBnftnw7nc031Q6Sf15MoQNIVYn2LCwJzfsiNcF8Cr0++AKYavl8hFXR2R4M4cp
	HrLxD/DjJi6/xz7cdakoBitbAbOgc1bt4j3XyQm2LXjBn8tsNV/ze9LFiC6NDu8X
	Qut7TyyC3/ano6ckMsciHbcwQIkAdDX1c7deFFHaTq9wNBWESb2Rtfv2BLQxScQs
	/4pYg/T0vAeYeJezr9qiQtiYxhFJm0GXrz+kQC7MoqnATdi54wNHEhZg++0tA6CX
	O/fP96YPbXMUjGuuJV8NljQIcMbEKpJOaiZsYX3Hrppt6WnVQPrrV6u6TKEmtlrZ
	yflMi3GRV/4kGiEirew48w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkpwgnpk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:15:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60EHrYOS029137;
	Wed, 14 Jan 2026 18:15:33 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010014.outbound.protection.outlook.com [52.101.193.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7m4tde-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:15:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7JXzwimt+Jshz63CQ8cPxdrJ/NFOqn528h6soRVDU8fbCpFzAs3gJbtR2CeQSukRMGhtTT9W1iolZYqKjN2+NcOPTk5l9BKh2WrVp0bgYkIJUJFS70qye72MQ8ruJEyto3MnZ7GqvU41lDTla6RjWRqpgSNG5Cl39+YmnbX+N3CthJZklF3MuLZUx4OtYXNVoVbRkU7LapEmFFnogrlp5VDVPh279R6i2EHZEd4VJXiMQdO1W1bVgLrotl48IQB6o5MMercCl4Ablx9/IitTbg9DLERo7kPIlyhe3pDNGaq5cP2z2ET6x54b7LMzstxuDVpbJPB3DwRsYIj2IA5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKgmsL9xt/mhdoUkJCXfDnocF1i/Oa+3JdOUx+9Vod0=;
 b=xHxL6Ff5RQSoirM9Cp4Qshb7PAmRlJbBzZ7WJ3ZU0pUXcxMft3V0bfQDllroUZ2CTcKrWiLRkp+92bgZcVQyBeOb0hgqiVyX61aNljIMrAP6p3zdqV+usbDM8N5DdVIm0errMtsTwAbVqEEI8U7TQGPf+YWefZhSalZY802yL018jcKW2xGCpc104TSDqFTbB3gF41z9MzuDfM+MDmqnRA9odqyUjDhAcJeV+llZrH9mYVfkO/UsT2Jnai3Fl0nrtmVUA7gdvxjYGdYZf4i0dvAN9CSLlPgPFZPcTVuD9/aduOVxQR3jUOxmtYs/6U8yV03ve5DLHR9CU+ooZ8HpEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKgmsL9xt/mhdoUkJCXfDnocF1i/Oa+3JdOUx+9Vod0=;
 b=Qa4W5jvcCuAtBaNYXEI1gB+EwNMGOUNakD7tbEH1ZrgId5+v9em8iQNFa6SUciA7RPfDZQ7wCWfAasIo/BE8PvUrMfuCBXiHudHt7cXAVwaj+ntPH3Xn4yAk8nUFNUsR5ukDjE/s6mWOq5Zxyh+oDgim+QuMu6gBbrsi/96FMFg=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 IA3PR10MB8186.namprd10.prod.outlook.com (2603:10b6:208:511::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:15:29 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 18:15:29 +0000
Message-ID: <43df0859-ee93-45cb-9c1f-5492df613ac1@oracle.com>
Date: Wed, 14 Jan 2026 10:15:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm/memory-failure: fix missing ->mf_stats count in
 hugetlb poison
To: Chris Mason <clm@meta.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
        muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
        linmiaohe@huawei.com, jiaqiyan@google.com, william.roche@oracle.com,
        rientjes@google.com, akpm@linux-foundation.org,
        lorenzo.stoakes@oracle.com, Liam.Howlett@Oracle.com, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, willy@infradead.org
References: <20260114153749.3004663-1-clm@meta.com>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <20260114153749.3004663-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|IA3PR10MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: c789eeae-2b16-459b-c160-08de5398e61e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?VFIyODdxMFhWN0V0djl5SVhTcGdDZ1ZWMUN5dkRrVjhTbXpncjNyK1l6MFhF?=
 =?utf-8?B?cTJ2VUtiOHFodUEwWGpkNmQzN2RXY29UNTRpQldkOXpFV29MckVNejBYUGd2?=
 =?utf-8?B?OWp1TmhwVTFwWlFNamVQKzg2M2N5THpHRlJkV3NrcHhvVDVENFg0d293V2Jy?=
 =?utf-8?B?V3AxQWdmcW4wOE1TRy9uVmlMVWh2ZVpTVmJFVk5iQkF0eCtXQVYwZlZzdlMv?=
 =?utf-8?B?b2NXMHRHSjNQZTh5Mkx0SUEveVBrMUZnWVl5TlI2UXhsVVM0R21FS29KeUky?=
 =?utf-8?B?YXV4NjhoakcwVkNvMVRBcFZXT2diN3l5RUh6blBHR0sxTDFGZzVkMnN4THpR?=
 =?utf-8?B?UGRaSFQyL0E2RlljaE13ZE9IK3dzM004bHZYRHRzaUYreDVCQXorR0JiKzhY?=
 =?utf-8?B?dlhMZ1VyNWFOTXBzeWZvdUdNOFFPWE5QaW1mekF6QUdMZDJYTk02cjRaR1Bi?=
 =?utf-8?B?eVN3Qlp0cGgycGd4Z1Q5NHUxcVZwMFE4WnJmZkFPNG9KUVJTUWxKQTdEWWxX?=
 =?utf-8?B?Wkgra3dGQjkyTlU4blJDT2Y3bmhhdHQ5SjFoWFlONm5yMjJDdElUN3BVZU9N?=
 =?utf-8?B?SmZjUm1OdzJXOExqS3dzY0Q1L2syQ0dLWVorNS9qQlFRYUtEOWpEWkxqeU5S?=
 =?utf-8?B?WlB0bGYzREtvYklXODNobGd5Q2dXeElBWm84cGMzSDZoMzlveDQ4Q1dHdVdo?=
 =?utf-8?B?YmQvV0tnTTlCQ08xMmRnK0l6U25kQjJRekYzTGJHSy82VmlZbjBnVFB5ZEts?=
 =?utf-8?B?amlQRks5aEIvdDNjTFdTWkpHN1Fob2s2VXJGNTN5THZNU0lkTDVhdmdUTEdu?=
 =?utf-8?B?OFpUZjNCSDhMaVJlRWJIYnkyMjNvKzdPcGd2c1hxMEwremZKT09yUUpHNGZw?=
 =?utf-8?B?OHNPQ3NRZGFGdld0aEtiVFgxZUZsWnJvekh2dGFTckF0NXloV1phenJYUGsz?=
 =?utf-8?B?enlMWmVsaWZXN1k1WUZzUmw0RjZHZTYzQ21FNkE1ZlJCc1RyUDJVWkQwRWty?=
 =?utf-8?B?UWZZekFDS3AwTkRya0o4Z09jMDZoOThGZmhmKzMyRm9GQXhIMlRCK3EwejBB?=
 =?utf-8?B?TDJINEVPOUo5RjU3Yk5rMmRSUUNyQkFCaDdEa2FNWmtYTXp6RURpbElaVkQv?=
 =?utf-8?B?anBJbW1Va29xL1ZsRFFiMkR0a0FyYTZWRFNYN3pTN2VRcXZsQUxTeWRxcmdB?=
 =?utf-8?B?QUNBSU5RcktzZyt1b0dMdFRHeUZnZlVaNEJJQk40c2tFcU5ua1VvbDl4ZXJM?=
 =?utf-8?B?Wmh5SHo3dDdEY0RkUUZDQloyK3RvWFBmY01RNkFTRGFFUUNteWZUR0JIb1lJ?=
 =?utf-8?B?RTRUdElRakJlVmpXVm4ycVR3SzVBMFBQU2Z2QXkraWNhZjhWL1FhRnY1VjFX?=
 =?utf-8?B?WTFaandUMkNvWjVWYzVwNXQ0ZEZHcFlraHBVbjZLRDBNM2V3R2xMR1RFeEp0?=
 =?utf-8?B?dVZRRnVHS2hWcjZUaVRNMnFvQ2RCNXIvS0dFOU5sYjAvNUtza2w4d2pVYm82?=
 =?utf-8?B?aFhSS3ZtTlJLeFJvdjNuUzBCQjNGeXlYTnQ5Q1dtUUcyK3lsUjVoRFNOVnE1?=
 =?utf-8?B?ZXNPVFFFTnYxaGtxazZrRkFpNUVySHhCYTk0ZXRnNnI3c2FwREZHVXpQOEhU?=
 =?utf-8?B?VUx1dktiODBTMFRqL3d2OTJSa3E0K3hwUmJBTEM4MHdaeHcwU0xDdkZOaXJ2?=
 =?utf-8?B?Vk9rdEM0M0U2TStkNUFOei93Sm5ia0JhT1VQMCtaQjNwMy83TndrN1BpWXd0?=
 =?utf-8?B?UjVycy9SOUh2QXhueGpTZ05sT0NyUDFBMHcvZExMUnNhMWl1Q2Y3RWNzVVh2?=
 =?utf-8?B?VlVlZ20rYUxnT0cyUVlabjF4TWpqMmY5SVl2eWN5NmZsdEJyWi9LbTMrRVIx?=
 =?utf-8?B?OGpLeVl4ZU9ZZ1JFZm5wNTlQc3pONUVPbGZUTlB0VmswVlFGQXR0eWwyTy9Q?=
 =?utf-8?B?M0Y1a1lEOUxUcTIxenlMRVJaTlB4T1Fady9JcmpQekRLclNCbHlzdURtLzkz?=
 =?utf-8?B?d0FPN3I1ZGgyZzZoTzJSancxOEdTS2ZJanhET1JKYXZzakFPTGJmMnd1UHgx?=
 =?utf-8?B?V3U4amJLSmRObjBZRVhxNnliL3JONTNmVzVEUUF2MXgvUEdYdlpqL0l3VEVD?=
 =?utf-8?Q?fCig=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VHB3eWR6MXhqNWhGRmcwOHVMQ0UrMDdkNHAyeEJta0NjWFZ3R0RtT25YZjJ2?=
 =?utf-8?B?ZWRLdkNDd1R2ckYzSVlZNHkyRFRrbDkxaFRMcTdpZmsyOWQwMktqYk1SVTRH?=
 =?utf-8?B?c21reW9XWE10ZllTNm9QZ0Y2eTNXQlArbjhueWFqMVRDN2dhbktZaWtNR1pl?=
 =?utf-8?B?YnhOd3Y3L3Q3M3JHVHVYNmJ3cUxvMUVtdGttdTUxQ1lTaXo1OEpoRHozTGdR?=
 =?utf-8?B?Z3BqbGxXZGw2WnAwTDY5d0dFdW9TcGRXaU1nWFZWMmZOTGdhRUd5MmJwSTBE?=
 =?utf-8?B?ZFBwekdRR0l3Nklha1dTS0ZmdkQxUnh1eGtmTTNrVWFNSVdqOUs4ZDJxdE9y?=
 =?utf-8?B?dHpnWmZDNkFZWXN6Uy8xR2lGYlBQbnVMS1J6bDFuVEVrRzc3OEk4S3Z1a282?=
 =?utf-8?B?SzJjaWt6cTNPLyswMnFiU1VkYm1mQklqWkY0dk5CWnQ5WGVwcC9RaDdsS0dB?=
 =?utf-8?B?ZFRYODU2Rmpxc0s1TGRlcmlQL2dXZTE3SDhZZWZIKzdSa21JbzAxdEMzL1hR?=
 =?utf-8?B?bitBakx6c3I3aHAyZ2E1L00zNEQ5cTZkbHA3bkNmZlh3c09Yd1FXNGxBWEhQ?=
 =?utf-8?B?Y3ZNVHBpd1lXWlRwQ2I1azBud2ZpMzRibE1LNHBGOTRCdkNZb24vblFXZ3Zs?=
 =?utf-8?B?RFExVzlnVjdNZ0VlZnZpeGNOUTlYWTZicmkrUEJFSDczNm8ySzA0K242eFNL?=
 =?utf-8?B?UHV2THhWWTNLVXdOU09aNGUra09OT3Z6c3dlTkFmT0lqR1VPZFdPc25ESDRx?=
 =?utf-8?B?NmRHdlhwc3Q2ZE1PNmc0ZnRBYUVpVUtsSFZOd2dDRjAxQS9oYUpWZVNrcG9t?=
 =?utf-8?B?eHlCTERTSnFQNjlwQkZYck9wVUhmQ1VZdXJ4eTNhRDJ2UlhSUjNDd2pSdFMv?=
 =?utf-8?B?Vk1YM0o0QjlWQTJSTEtyVWR2aVBWMlhUeVUrS3hTV0VCOENSNlBVdXFiMCtQ?=
 =?utf-8?B?Rm5GVjNzak5qbUx4WUl4cGNiR2l0cjRSd2U1eWpQV3NNQVdUYkRycEg4d0Nl?=
 =?utf-8?B?a1d2U2kxNWptdnZDT2lDMUIrOUVQb3pSSVJjMU1TYk1PRXE4M3puMzJsS2JQ?=
 =?utf-8?B?eVgycW9Dd0VGaVFnZ2pPbk9pVFlBQW00bXpkWTQ5TVpwK0RqZytTOHBDc1kw?=
 =?utf-8?B?T0NQdmVpZnNXcEtybEVtRzlLeEh1VmwxSkpxMnZtdFFLNHdzZmo2YVVSa0g1?=
 =?utf-8?B?MS9YSnBXQ1hYRzlZNStNblNXN2Jzam5TZGFoMC90MkZnZTZDa1RpRklkVk4r?=
 =?utf-8?B?V05NRjdEdUVPa0gweUtVWTJpTmI1ZFdYTUMyR0RPMWd2OU5zNzY0R1RGQnkx?=
 =?utf-8?B?WjdxL3R6bFNPaDNOZmdyOVlIWko1VWlrUEloY0ZaVW5HLzhiWHFlRjN0SEtR?=
 =?utf-8?B?WFNFdWs1LzIwNEVMQ0g5N0VlcnFrZGJXYlNvRlhsTVNtRTlENGppQm54bk5O?=
 =?utf-8?B?SW9YV2Noc2lJZEp0eEFZaWp2cWtHWW5zRU1oeUFMbm1oOE40NEZ0bnFWQ0Z3?=
 =?utf-8?B?Tmd3Mi9OK0t5S0E2c0xPRkhyN05FR2xmTXcrL3JzMjlxNzFtWURDSUtkc2dI?=
 =?utf-8?B?b2IzZi93TTJCUFlLdEs2YzNPVU9tVTYzcTNaM25MVnorMyttUUpFZXB1VzVt?=
 =?utf-8?B?NkQyV3I1aHppdE9MTllHUGhhTVRGczZ6YThrWEN1b1czUTVKbkFWUUhJeWVh?=
 =?utf-8?B?QWlHSXJLU3VMOG5YZitCcjlBcThJVjQ2alFxdzdDUUlUVWFuODRqRlRFQ01X?=
 =?utf-8?B?aEVYRkphby9veWtyWlVSdXY1RDE2VDhic0ZTOEJ3WEc2Q1JDci9KbGFBQWpQ?=
 =?utf-8?B?ODhYTDIydUZESi95ZllqYVozRjVQUW43TWxMQXduVDZtcFI1RkxHMXRMc0Iw?=
 =?utf-8?B?bzZWUEZpQXZnTnRvbWpDTWJuczE5YjN1ZG1BQzY1VlZsVVRCWkY1RmNvOStu?=
 =?utf-8?B?dkNBelpuSHRKUlpkcjB1eG5WUVRzbUx2MndJS3FsK2RVRDk5K1N0bWlPUWdU?=
 =?utf-8?B?MmpqNUVtdHQrWm5EOFNCNXNjbVBGNEkySmdnQ2tTcmZnSFdRUWxTbVhqWnRZ?=
 =?utf-8?B?R0orOE5vaXpJTmNwTWtCbVFQU2ZYZFNVeXd5aXh6MnJyUjVSUGgxczBHU3JV?=
 =?utf-8?B?NGJQYTE2aVhxN3JvM3VVeFZjd2ZkVG0rWmJyUHhycStNbEV0ZjJWWlZPSzNl?=
 =?utf-8?B?UEF5MExnbDRMckMwV2xyZEVJYTVOVkRzZktDbWtwNGxnMENGTG5Od0wxL2tz?=
 =?utf-8?B?UTN4azhJUmU0QjJMeTI2R1lVaUpGbHVXRFA0T2t2VjkyaThJS1NWb1l2SmdJ?=
 =?utf-8?B?RURacm1PbW5YOUJVcUpiai9UbFVuMXBLM25BcjIxVDRRL2RGblQ1UT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ELVWhIAoc63sXaOZiITttTAMGp2V9IJY0s0hFgxqGC4ZivN+8Bp6lBDdqk7mWAgXHeNWIuzPL4V3t5paJtKSZIzEtQqR+bRX9g2nw+on0brwfYe1K1Tb+tnsiVijWxWfxkwlNxl0iwuep0CeVb5KNFhiXOpaXW8v5YgPi02j4W/IAEPgsBllSTtOXgZRZgg1CE+n6i53p2SeHGe0+LU5HYIeFAWEZnhb15VIxpBQ3jcxCCT2+GON8xw6nqqM9jQpXMz6Fqs9fVh7XmdiLnQxrVoNkKp0rrkjiihS9BlMTxxJJ5SorMuPGWcYP5CBcrJm8npke2vcsIHgx+svVj6ks3ecdYQRDWJVg2+K+SjVjkIb9mUvymHZvL3tubeD/6oFNHahX946L8jk9mU7obXgPVF/Ges6hirbCF//6HQY2XBIzoOcCHqoCtituliVSptYlmcQ+i1CgP1j5DatwiNFOc+9lml21Qykcvinxej5JeXVmMof4QJluyPPOrySKWWo5AeIObdwIFHCXJSr8p7CNPKi5QHrHQivsGXMGOItu6wdiUmfWOEmtBWACTkw1r6OH5WdsiBnDKzigHRzgDNZcRF247ySZ5povsm+nSiS60c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c789eeae-2b16-459b-c160-08de5398e61e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:15:29.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRFRyOnYdi0fqUr+IcUL/cqX4rwsgTlkByihn0S8mnq7fWI9UY1Co7HldS+tu0OmO1SY24f6b5hhBUNnPTsYaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601140151
X-Proofpoint-GUID: dn9NqlMZWdYNNWtLo53TGFmK6FDyXUr9
X-Proofpoint-ORIG-GUID: dn9NqlMZWdYNNWtLo53TGFmK6FDyXUr9
X-Authority-Analysis: v=2.4 cv=ZtLg6t7G c=1 sm=1 tr=0 ts=6967dd46 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=0-JsNAt8oz3B69UVJK4A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1MSBTYWx0ZWRfXwq6Ev5lpkrBN
 s/6/JPx2TJRmlEseaUnwYG+/R8pF9YcAIM4+ykvZiaJcfcKqZRAolU7tYUySB/ShNPmh1EJK9yb
 y1lbrmQ22ZXlwX8k4WJ0ZmCI3QKfp4xjNmdwpxzA01zGPJRsrqJa8ZP6C49VG2TZcxtxJK7t+fH
 WqbFClqc8Z3KFa89YB105RXuc1h80tcqozGEwC8c3E2CFd7gaeuezfLdkWdR5R8VeM478JmG3kF
 N3fwuQt8GTb+bXVMPJg6ocLz0J3/z98l3eHZREVsOw95z0iP9a5Q/X7RhVIVATr1lQjxDl+aLGd
 kY+Nu0EBAGuVEBR4RRYbZlkZJha2A7sZzgcD9dg1rX1PKOGnTVhqLeQtac5gSC0UthY1uPGsnh8
 VbFmWnNsI4ebyPy8uvcBAbqPgAO1LwMeVtaY6gcidftsJbB5TXSk6YSLfEnkEjeq9VpRl4bLYlW
 0xAI+h/tT8JsEedN8D9Se7oF6t043HVQhsZ9ruR0=


On 1/14/2026 7:37 AM, Chris Mason wrote:
> On Tue, 13 Jan 2026 01:07:50 -0700 Jane Chu <jane.chu@oracle.com> wrote:
> 
>> When a newly poisoned subpage ends up in an already poisoned hugetlb
>> folio, 'num_poisoned_pages' is incremented, but the per node ->mf_stats
>> is not. Fix the inconsistency by designating action_result() to update
>> them both.
>>
>> While at it, define __get_huge_page_for_hwpoison() return values in terms
>> of symbol names for better readibility. Also rename
>> folio_set_hugetlb_hwpoison() to hugetlb_update_hwpoison() since the
>> function does more than the conventional bit setting and the fact
>> three possible return values are expected.
>>
> 
> Hi everyone,
> 
> I ran mm-new through the AI patch review prompts, and this commit was flagged.
> The review below looks right to me:
> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
> 
> [ ... ]
> 
>> @@ -2029,22 +2037,29 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
>>   	*hugetlb = 1;
>>   retry:
>>   	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
>> -	if (res == 2) { /* fallback to normal page handling */
>> +	switch (res) {
>> +	case -EINVAL:	/* fallback to normal page handling */
>>   		*hugetlb = 0;
>>   		return 0;
>> -	} else if (res == -EHWPOISON) {
>> -		if (flags & MF_ACTION_REQUIRED) {
>> -			folio = page_folio(p);
>> -			res = kill_accessing_process(current, folio_pfn(folio), flags);
>> -		}
>> -		action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>> -		return res;
>> -	} else if (res == -EBUSY) {
>> +	case -EBUSY:
>>   		if (!(flags & MF_NO_RETRY)) {
>>   			flags |= MF_NO_RETRY;
>>   			goto retry;
>>   		}
>>   		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
>> +	case MF_HUGETLB_FOLIO_PRE_POISONED:
>> +	case MF_HUGETLB_PAGE_PRE_POISON:
>> +		if (flags & MF_ACTION_REQUIRED) {
>> +			folio = page_folio(p);
>> +			res = kill_accessing_process(current, folio_pfn(folio), flags);
>> +		}
>> +		if (res == MF_HUGETLB_FOLIO_PRE_POISONED)
> 
> When MF_ACTION_REQUIRED is set, kill_accessing_process() overwrites res
> before this check. kill_accessing_process() returns either 0 or
> -EHWPOISON, so the check for MF_HUGETLB_FOLIO_PRE_POISONED (which is 3)
> will always be false in that path.
> 
> This means action_result() will be called with MF_MSG_HUGE instead of
> MF_MSG_ALREADY_POISONED. Looking at action_result():
> 
>      if (type != MF_MSG_ALREADY_POISONED && type != MF_MSG_PFN_MAP) {
>          num_poisoned_pages_inc(pfn);
>          update_per_node_mf_stats(pfn, result);
>      }
> 
> Does this cause incorrect counter increments for already-poisoned pages
> when MF_ACTION_REQUIRED is set? The original code called action_result()
> unconditionally with MF_MSG_ALREADY_POISONED regardless of whether
> kill_accessing_process() was called.
> 
> Should a separate variable preserve the original res value before the
> call to kill_accessing_process()?

Good catch!  William Roche has also pointed out the same issue to me in 
private.  I will fix it in v5 soon.

thanks,
-jane


> 
>> +			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
>> +		else
>> +			action_result(pfn, MF_MSG_HUGE, MF_FAILED);
>> +		return res;
> 
> 
> 


