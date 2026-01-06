Return-Path: <stable+bounces-205115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65858CF924F
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2443043574
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60D234404F;
	Tue,  6 Jan 2026 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihpNaxqY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nlJmfxLN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477534404B
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713977; cv=fail; b=tP+8T5r1RTFIauBatKpcLuN48hmcP7KQUPWoZJJq+rJ9383hNyXjD+v3dW+TsInF2/RZtXc65FztpBZfkpxNj72PQEePAWzlakOSjy2CTAHQpC2lxKfXrDepOd/LmszYmJnNqcrXVGQ5qdGaent26X8pU44xT94LoTE8BIJPpl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713977; c=relaxed/simple;
	bh=f4AXmUukTxlTR6FQ7H70+Nr8QTwFcRumDfqJewqtCNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OJ+xaZ8OdvLGBnif/IdT8tMYvMZktER09fF71HfNdliHry/m1Rxyd/rI67oSw8u+AzFEkW2ElW1p8Tk/5BvlKK3pvRTUCcq24cRAB6B4yMmvT1YsIXSOzePyJ7agaRqiU/ePSRTTjWIzFOklMjDUgfI1bv6/JjLfBplAr5WNjZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ihpNaxqY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nlJmfxLN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606FJst24030048;
	Tue, 6 Jan 2026 15:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kl0hwcb/JLpbK0i3hC3WQ0/CvdZOFJYGoK0pmluO+G4=; b=
	ihpNaxqYvKOfKKzmO6AQFkR12dnumB/I4B9wNcDL1WGbTc20aNUCqRMd0tI/nRWL
	GG8+8/EWpi4i/6YKdXFFyKPCBf1lKdk9BPAFwezUmxsg01TJkLo4lLhsY2CtbwTY
	AzKY6sHAfVldNZoBEtOS2gyteaycI1VolgLnhLOChnLzR8Fj0e/aDzWJD1wfbMRJ
	rxtzRx3m1+t+Cd/UnH08FTJmS1ArCuF0cooSKAooQ4icUpYg2QlJfDyxQCMWBFM/
	xNpSxgvlNB9WovzCJblJEc6LDjwY31TzehEXeoUjnI1/Ci54l0s3wC4585ipydQm
	XCBzUJ5d7OZNnVRJjC0O4Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh4xmr16v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 15:39:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 606EU98D021115;
	Tue, 6 Jan 2026 15:39:21 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjjr4kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 15:39:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QcokS3E6f2hJF8QvO1AnclW5ctRcb7+bN89+zFXLn2clhuErJohFOTLwF68cxXiNQE6qVa3kwAj/1TkZzUDrRoRITuLeWRVW4sfvrEgGhV45rpabvbhizJiSpeS1m5itfY6pi/RYwJGfFQh2Tjye4TqaPCXTAZRpe0QmaUSfRpN+cZIkS8n9WQOWciNqdfE7YWyuGrLCoGjNu2ja8mujZwHUjuZXqUuhz0XrCipP/wVwQGG3J3v28Z7pxZRepZQpNu55pB0Kd1Qolrh9fhfiUve2iQOM0R1eEFwf1Zxtnsys2qmTfgjPQXUe+MqfcBFrVoYMSkhlrnE+5sG/CLQHMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kl0hwcb/JLpbK0i3hC3WQ0/CvdZOFJYGoK0pmluO+G4=;
 b=uuWbntxJ1UnWRIqmz4z8Kh9V8F+DcbKoQQOVhvqoK4yMxlo4+54hpVZ9nwXEnOqX2Mg8q0/BURncDsLoTThyuPpo4pLr/FKiCco5sLLxgXsXfuizMdGQqSwLZAtMneFe+6FRRhVUF+E+ZlwnBZjv5RNjqFMjDQBPhRU1uxvbOdl0G3Y9ksnD/GPxON1yfuqneBOAdRHim3Mm03uVTNHmnvrKyjM9FCGB42Bjj86RCC8DH0mzhS8JZqSkyCs9/GpJuXFu6bwAvP241QvBIjzuxujjpsV3NopgDuakWp1+KTGGzzSY2zH/Qe3zqDpNNiSmDD/yBu/NRAh6ZOD39dG5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kl0hwcb/JLpbK0i3hC3WQ0/CvdZOFJYGoK0pmluO+G4=;
 b=nlJmfxLNpVj9G8cTp+gc2Tw+C3nBbDl0MCZbesv50KDcbKK48PyeNn7452abUsKVzdB90zHCcIfxsqCjK/fQTSTz7yS4pztej+UaoEWxVA5RcudrMehHY/zu6REvcpkOj7OVRegfNH24GoE9VdmrtbKAH979PXOX+hcmNFmAZwg=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by CH0PR10MB7412.namprd10.prod.outlook.com (2603:10b6:610:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 15:39:18 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 15:39:18 +0000
Message-ID: <11f47c84-95a1-431c-9a6e-4aa578b1f5cf@oracle.com>
Date: Tue, 6 Jan 2026 21:09:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4.y] net: hsr: avoid possible NULL deref in skb_clone()
To: Yunshui Jiang <jiangyunshui@kylinos.cn>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, syzkaller@googlegroups.com,
        edumazet@google.com, kuba@kernel.org
References: <2026010511-wrist-squiggly-afad@gregkh>
 <20260105080025.1441005-1-jiangyunshui@kylinos.cn>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260105080025.1441005-1-jiangyunshui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|CH0PR10MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a65f2a1-58d4-4b46-b0f8-08de4d39c0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFpYY3F0MWpySEErNG9HUmkvWUppcmZOZzk4Qmo4Z3pKbVVJZTd5ZnZUb1Nt?=
 =?utf-8?B?YkV0YVV5UVdudTFoK1I1aXJqTVkrUkV3N2IvMEpXb3FtTThmbWRUUVk2MUU1?=
 =?utf-8?B?Q3lOLzRnUUlxYmR4UUxsNDdHbHhWcDhKMkxqZzRyZmpRTHpvclA2dDFrTjZO?=
 =?utf-8?B?Sk10eW5CSFRFbGFCVktlWDlCMzY4cVZxMk50QUxudVdUTU5KVE9TL0wvN1BI?=
 =?utf-8?B?LzN4dngrNjFGK1RYcVZjOUpDa2FtYjVQMUlWUlJycUtJdmp2VXMzZEkxSHlv?=
 =?utf-8?B?SWlNNlduNVJhZ05oKzVGRHVvVE1NOVhyVlJUcVdzWXJ1anNza2REOHZoZDFF?=
 =?utf-8?B?SldYekZjWVJWYUFscC8yZUVvSnAxdHFGbElCWW5XK0hhM3dqR0xIMWpnMUJY?=
 =?utf-8?B?a3IvUXZ1UkVpanZYMnpoK2Q0eEd4WEZTL2hxakV5d2IvNm5pVjRLZktXMDdv?=
 =?utf-8?B?NXNxRXZsamlyQWhVbHVWSzZQdmZzaCsxNU1NRHowQnUxWEsxeEsrMHp4ZHpF?=
 =?utf-8?B?WUZMeUNya2J3c3I0b3dubkhlNHMrZFJhYkNFZVBILzlNRkxsV3FFcXcwdktQ?=
 =?utf-8?B?QmRkZkIzSnBLbWdWNjJCbE4vRGlSRGhucVNFWU5YcThsTVFDSWNSRWNHTlE1?=
 =?utf-8?B?ZGg5SWpZdnVOZGNycE5mTHV4bS9JNXlvQmNGakVHcGg4emFZK1plWGRybEJ5?=
 =?utf-8?B?bEk0VFFQUy9QUUdlWGZTYlFIUDNuWk9qcElBZkQrRDZSdjFHbWsveXFZV3V4?=
 =?utf-8?B?R000TEo4NXB3dUJLckhPb29wSHp4UWt6MzZJN3c2c2NQc3U0d01FdUE5WmQw?=
 =?utf-8?B?Z2ZVMjc0VXVrc0N6ZjdvRE8xaVlDWktSQ1VBZ3VtR005SUJJeEpFcStUMGY0?=
 =?utf-8?B?UkZ4dFNOeTl6MFJsY0hHVnhTd1d2K2lBUlBWSGlqdFdvaTNqUEYrUWJwNEln?=
 =?utf-8?B?bEx2YURQTFZuV0Zsa3VnNmhtaVF6Skt3bkhWVTZzdWJDNkRwb3dqMmQ4TlR3?=
 =?utf-8?B?Y1ZtTzM2eUgvUzZaWkZoL0tCN3lhdGFyelBjdG1teWZZV2d1d3grMEpsMjM3?=
 =?utf-8?B?SGJ1cUp4b2EzQ0tuUWlqdmt6QkZFd0xDSEVpSFZZdTBTbFFjL2pXQWxFbGt5?=
 =?utf-8?B?MHo3Z0V6cVowTEF6U0VucmZnM2xvYTBrdU81ajBPeVFsczBXL29BRWJDM2xh?=
 =?utf-8?B?MUpJUHBDMnZlVVBnUGcyZC95aTZnY2JLdXE2SVRRMmZXcHVLSE55ZkJNbUJ3?=
 =?utf-8?B?TVQ0blV4UkUyVVdqNHlKQmlSYlBXa2JpVGxaZnlTTnJOS3lOZDdWZlYrUy9m?=
 =?utf-8?B?RDlPQjhON1RhNXhZUngvN1VzS3pZcWt0Qy9JK2R4LzlwVjhFcEpCa3NjWVV1?=
 =?utf-8?B?cHRuUGlxWjVCeHBqc2I2VUVjUU51VXJGeXZXZlpCblFreXk2SFpZWHhXUmFW?=
 =?utf-8?B?cmpTREQ3UkdKcTc2cFV4WEtSakVuSHdCZmw0WDVvTDRRWW5hMTI2L0Ywem1U?=
 =?utf-8?B?NDFrVGYvOVFwMkN6b0Z4RldxOUZSdGZhTzVJdW4wdktrZGt1clVCU1R4bXdw?=
 =?utf-8?B?NG5sMWt3SHRQYU5XNktoZXkyWk9ZUldXdkRoUWVXdmQ1TndOUXZwV0tVTVhn?=
 =?utf-8?B?YmJkZUg4MjFINkJUMHN6WkxSN1JVZmZlSGZ0VDNVZGVBSmxrZ04rVC9VN0xk?=
 =?utf-8?B?RWZBa3pGTHROTDBBOHI4dTkwSW1FTldkMnNabW82a3M0TndhMTEyaFdhOTdW?=
 =?utf-8?B?blZyUi9aSHVoT0V6TjF5WUUyZ0FMQTN1a3crbWdjekxpZVEvdUF2MjRVS215?=
 =?utf-8?B?NU10MnQ0N1IwdjFiNUdLZXFLUmFvQVFCd1NIVTNyUG9qaXFGaU8yS2dKVEFk?=
 =?utf-8?B?VkpQMUVYdW1PMDZDV1drU0tDL2YzaVJWSVI4c0pLcUFITWJ4c3A1RUY3VFp4?=
 =?utf-8?B?S1VyaEVOM1d6OElwQmZqNXFkc0FaK3ArQVhENzhOMTBSZEJlc1p4WmptSlRI?=
 =?utf-8?B?RlVMSFNOc0J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cENxYVZCRFVHTmhvdkVHbmFBeHNOMXB3VWgyWWc5N2hkaFp5MTF5QTNKdDY2?=
 =?utf-8?B?dkhZaWtVZzEwNVAxRTlxdEtaUHFaRlVFUVlqMkNWQmQvaGVmQi9XcnNQZFhC?=
 =?utf-8?B?ZnVBd3p4aG13NEx3UnNaM29XQURuWHB3WnFrSUtwRVE4WDZtVVA2SXFMcEww?=
 =?utf-8?B?L0kzZ3dXUk85N3VsaWVUMzBneUltb1g0WGV1Wld1MCtLeGFGbU5MWEljTkVq?=
 =?utf-8?B?L0xkOXFyd1JpVU5UM3o0TFp4dmZudzVlZnc4SGx0SmdmamFPWDlaS0FnNGVh?=
 =?utf-8?B?VVJFdjFtd0dTb2pBVHk4ZVRyaHRrZkVUd0VYM3E1RDZ6SUFHRWU0Zi96SWw4?=
 =?utf-8?B?WlBlUDZ6NXU2UjlLWUdERld2dkRETWpuSkxnbEw0TTVYVlE4L1BBNjhNMDVx?=
 =?utf-8?B?dEtWcEVjUkN4dnpQalk3RTJWWGRIZTZMVW9ON1pxcHdkdWR4M3ZrQVA4SkdP?=
 =?utf-8?B?dlRnQnc4VXAyOGt3ZFZGaTlVeDFXaFJRbi9kK3I0aGxXb1RZZXRKRVJSdnl5?=
 =?utf-8?B?akFjUmt0WmVKeFNEQ3BDMDBJbHpwZjBUZVdQclBmL2t0K0VGclljRncrTlhu?=
 =?utf-8?B?MFVGTlJWVWY2SW83TlphWlljUnRxMWlnY1lmcEkrcCtCK3VybUlxUkV4ZFJo?=
 =?utf-8?B?NnR4RW9xNzVqQU1lNTIrdW8xdGZPR0l0VkQvWk1VVW92UE1XL1RBRjUyQmVh?=
 =?utf-8?B?WFBWR2Zva28wYUJGbnZRMXhYakVScE1qQ0k4U2JCR2NFelh2YWxSM21EdHkz?=
 =?utf-8?B?YUNKMVRlek9pZXBnYjllSkVZUFlqN0xaaXZ2Z2R4UElIaEF3VlA3MWd5NTJy?=
 =?utf-8?B?NTczaVVLNXhCSHFKUnJkaWFsVjBNc05UcVEwbWY2c1NIZkMrMTJMTzFwRThl?=
 =?utf-8?B?V29nWEh2dTgyUjEzQm1raEg0NU9NSG5GYXpzMDU1cmo4c1l6UGRBSllLOW51?=
 =?utf-8?B?OGo2SW1NRytBMGZpZlVVRUhFSjU2RG53Yzh6T1lJMjllQ3JMSE41RUF5eWMw?=
 =?utf-8?B?WjNtWmVWTldFRXE3NllXTXE5RjNHS0FDMWpQbXh5OGRmbzhDVC9FUnVURGNI?=
 =?utf-8?B?MUQvQk8rc2hqQ2tWLzZJOVdRT0tPRVFSL0Q4VVpod0RFUUxPcloyWEwrek5P?=
 =?utf-8?B?dDhiK2IrK3pvTklyc1lmeHNDMWQ1T1hCcnRycVFJODVaRGY4b2tDNTB5YSts?=
 =?utf-8?B?QXZZME5tOFBQWGsrQkxQVWpiamVSdDVzWmlhS2JIaVVWT2JKMkZlWVMzcys2?=
 =?utf-8?B?VXA5UElHdGRaL1NqdlNCT1IzbUVvcmx1bmtabmVBMkphamMrQ1gwYzZ0WUU2?=
 =?utf-8?B?NjZabFQzSWM0VU52OUZiTHc4RXp5WGdpSG42bHRqbDVsVGw5RnNWbzI4aUZT?=
 =?utf-8?B?bER2WVRyMlAwR0hQQW1YOG9VMVdkU3JYN2ZGRFQvZ1RwUmtsSE9NajJYSEhm?=
 =?utf-8?B?SVBjcUNtQnVIOWRmSTRWTUxLRXBhN1BOSU10Q1ZRc255R0laMUhMUDI3NHEy?=
 =?utf-8?B?ekdVWURpL3puQjVJczk0T1k1UFBSQ211RGhBMk1hdCtKS3dEUjVQVWJlUk1B?=
 =?utf-8?B?VHZEanJmeExORG9DRFF1RnRHU0xWaGZKMmEzUHVudWdGOVE4K2UyZ3VaZmZn?=
 =?utf-8?B?LzB1MmVWT1BiYW5IdjRqaVVGWGR2QTBRTUFzT0dNR21jbXYxWmw4cnVpS2lC?=
 =?utf-8?B?Y3N2OG1Fb0pwSnRtNHF6ZUJtSm5EMXYzTWd6QzNKNlBlOStwT0FaczQ1VHIz?=
 =?utf-8?B?cHBObUM1WFlwZDNydWN3REVsdjFvcGdqaHhDRnFJMHdVOW9EVUlEcjVwMnRI?=
 =?utf-8?B?amRXZnNWWDJBM3hxR2pabTFINmVlalh1aGZhQXNQRk1IUG16dHQzeFVIYU5N?=
 =?utf-8?B?cDRBdVNWZXJGOU1sa3FsWjFOc1ZqTHgzRVBFd1U0cjZSOGkvMDRMMk5nV05C?=
 =?utf-8?B?bUlMZXhla1dXWjBMM3RtNDFaZGFyWjZ5aERMdU51WG5OKzJlV2J5RUdPMUph?=
 =?utf-8?B?L0dDSVFvdlJiVW95cldhRGM3dSt3YkkyWVZoaFJhVlRSNzNpWG0ySFp2OUpv?=
 =?utf-8?B?bEpJamNWVmJWVTFmRzduYUQ5d0kyMnNqRlRQeUNCZUo5M29UTlBYQmtMcjRV?=
 =?utf-8?B?em14a016OEVOU0hvNEt3QVQ3WFVTb0JidkMzR2JYWStJb0tDcXVHZnQwVzZK?=
 =?utf-8?B?b0lSdUhtSmxFMW9nc0kzQ1FtMCtJZnE3WmFYYUxoWVVRZ3RJOXladU5TNWtk?=
 =?utf-8?B?by9lMTlyM1dkaDNJdTd4SzRncGM3Nzh5WkJCV0FMNW9KZUx6cU13ZktRWnp2?=
 =?utf-8?B?TmZkM0RVZGpoVy9HUEE3RE1lcjdNZ2pyT0RpS3hDQk4zYmxwbW1oUlNqY1Rr?=
 =?utf-8?Q?IWuNMCDmOJlA5A2XCJayEOQ6pOfIkroEsNZJN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vR+ExAOXlgHJF7c+jam7JtdZin6kdLHC+E+TQDmnj5YXjDbU8q+UxARNk03KgJQCro+iwwN7XURBnkSrUec8UUYfbU2utDqQw4QL/XR3gPVhZXvU30RAuK4Q5FKGTWBq2R6VmGrwfN/mjxuVqVzT3ezqNcLDAGMnJND8+ozIrhRnjSrIukbZ4sD0z+dFGn7EE2nT6BTl1pI5S0xVT7A363cd/CMOzJuQCslJZdDboq/vNHQviD/0LfkPSVALAzSdEKj4/kDZBQWqU4/KimYyklSoOMIgxZH5TVRmfwySwbZfh6xGmRNT4WiNlfgkHrtSrismbOOArnE34cLUUnu94JeeIBqHaGJK8bcdWrTPNV+FuVk8UG8ROXBrzxAVvT9qZhmV5zuAqI3dNAtmHoP2kaWcNF3GjMJAKTG8bqlCv0MTa5TDA//pwYcuNTdAocsCJfUkZBXxD98kHJLWM3KVG1hKaMxcdus/dqryW5YOtQqw3HAp8tydczfr5VDniBIETNXxtQ9bv8Gun9dx6+ve5tke9M2aCExojgt+9hgD2RGnrZi1xaioKPB8jQxjoVeNpcAKVINV9TeGJkJFbHBosAxyJqDgBWX4HbB8m2ke08c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a65f2a1-58d4-4b46-b0f8-08de4d39c0db
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 15:39:18.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT3YTkVhpWWN7+WzSR+DZ3jkbmscoTYN6OKYHuxdrR4bTP8l/zdytuNZDxY10vTzKdR2J0Yit+Acg80P4L0JSIjWe+A68hlnOw/LGopZsr5scaCpORsb5nmm3kMUTkTq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601060136
X-Proofpoint-ORIG-GUID: OHv6sevtqfUtMwN4UmNyzlQ22cX6zZEW
X-Authority-Analysis: v=2.4 cv=Ep3fbCcA c=1 sm=1 tr=0 ts=695d2caa b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=edhTKeKxgkscaBIcN3UA:9
 a=QEXdDO2ut3YA:10 a=Qn6xTRysOZEA:10 a=FoiGvTp0eMAA:10
 a=_sbA2Q-Kp09kWB8D3iXc:22 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNiBTYWx0ZWRfX13thnJEQ3EBc
 84/XKyvR5QpXRe38DueC8MNsNOGJAvTBQCLY0sScnfsJGa9dDtHrhZSA1YOybRGse16YJ2Aways
 oz8G/5uw8w15EDICXJholyFyfiGcOv/GBvxrNUueD42+og5Zt1Hj3lk212ty4z5QNPxz4ef7Mks
 dosaMSoCK6nOZhiTuUqOl0vnRco7wMaKvv/b8wWwpFJP01xP4qQzAZ189qhnlnTLoLbbbzjimWh
 htY6+J/R/J0cr/Xo70+5OzVf58a6ox6QleacqLtpNjmPuNx9h+LyMAZqp//SvhM7+3thjHF7ob/
 Tc3mQJJuy+F7OvHNUMQ+NKTKfGMtGeNYPE0YkoS8HjlWTpPLAnYV3Jy7kOxo+aHt+zmUsNiXWJa
 wjm+olNNIU5gImVDPpDrqG4jCRtsSNAz+mtfmTCFothtpxjsJLLfxk18refXFF0r/h7aTOK9oUf
 gt6fVYBDRvWN3lRx8gFHcDYo4FxqoJGcz2+mKbQ8=
X-Proofpoint-GUID: OHv6sevtqfUtMwN4UmNyzlQ22cX6zZEW

Hi Yunshui,

On 05/01/26 13:30, Yunshui Jiang wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit d8b57135fd9ffe9a5b445350a686442a531c5339 ]
> 
> Changes from upstream:
> Modify the logic of frame_get_stripped_skb() instead of
> hsr_get_untagged_frame because the 5.4 kernel API has not
> been updated yet. Keep the core logic identical to upstream
> commit d8b57135fd9f.
> 
> syzbot got a crash [1] in skb_clone(), caused by a bug
> in hsr_get_untagged_frame().
> 
> When/if create_stripped_skb_hsr() returns NULL, we must
> not attempt to call skb_clone().
> 
> While we are at it, replace a WARN_ONCE() by netdev_warn_once().
> 
> [1]
> general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
> CPU: 1 PID: 754 Comm: syz-executor.0 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> RIP: 0010:skb_clone+0x108/0x3c0 net/core/skbuff.c:1641
> Code: 93 02 00 00 49 83 7c 24 28 00 0f 85 e9 00 00 00 e8 5d 4a 29 fa 4c 8d 75 7e 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 04 02 4c 89 f2 83 e2 07 38 d0 7f 08 84 c0 0f 85 9e 01 00 00
> RSP: 0018:ffffc90003ccf4e0 EFLAGS: 00010207
> 
> RAX: dffffc0000000000 RBX: ffffc90003ccf5f8 RCX: ffffc9000c24b000
> RDX: 000000000000000f RSI: ffffffff8751cb13 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 00000000000000f0 R09: 0000000000000140
> R10: fffffbfff181d972 R11: 0000000000000000 R12: ffff888161fc3640
> R13: 0000000000000a20 R14: 000000000000007e R15: ffffffff8dc5f620
> FS: 00007feb621e4700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007feb621e3ff8 CR3: 00000001643a9000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> hsr_get_untagged_frame+0x4e/0x610 net/hsr/hsr_forward.c:164
> hsr_forward_do net/hsr/hsr_forward.c:461 [inline]
> hsr_forward_skb+0xcca/0x1d50 net/hsr/hsr_forward.c:623
> hsr_handle_frame+0x588/0x7c0 net/hsr/hsr_slave.c:69
> __netif_receive_skb_core+0x9fe/0x38f0 net/core/dev.c:5379
> __netif_receive_skb_one_core+0xae/0x180 net/core/dev.c:5483
> __netif_receive_skb+0x1f/0x1c0 net/core/dev.c:5599
> netif_receive_skb_internal net/core/dev.c:5685 [inline]
> netif_receive_skb+0x12f/0x8d0 net/core/dev.c:5744
> tun_rx_batched+0x4ab/0x7a0 drivers/net/tun.c:1544
> tun_get_user+0x2686/0x3a00 drivers/net/tun.c:1995
> tun_chr_write_iter+0xdb/0x200 drivers/net/tun.c:2025
> call_write_iter include/linux/fs.h:2187 [inline]
> new_sync_write fs/read_write.c:491 [inline]
> vfs_write+0x9e9/0xdd0 fs/read_write.c:584
> ksys_write+0x127/0x250 fs/read_write.c:637
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Cc: stable@vger.kernel.org
> Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Link: https://lore.kernel.org/r/20221017165928.2150130-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>

Note: 5.4.y stable branch is End-of-life as of Dec 3.

Please find the actively maintained LTS branches here: 
https://www.kernel.org/category/releases.html

Greg's email has more details: 
https://lore.kernel.org/all/2025120319-blip-grime-93e8@gregkh/

Thanks,
Harshit

> ---
>   net/hsr/hsr_forward.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 7073724fdfa6..5c1b9cd6dd52 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -115,8 +115,17 @@ static struct sk_buff *create_stripped_skb(struct sk_buff *skb_in,
>   static struct sk_buff *frame_get_stripped_skb(struct hsr_frame_info *frame,
>   					      struct hsr_port *port)
>   {
> -	if (!frame->skb_std)
> -		frame->skb_std = create_stripped_skb(frame->skb_hsr, frame);
> +	if (!frame->skb_std) {
> +		if (frame->skb_hsr)
> +			frame->skb_std =
> +				create_stripped_skb(frame->skb_hsr, frame);
> +		else
> +			netdev_warn_once(port->dev,
> +				"Unexpected frame received in hsr_get_untagged_frame()\n");
> +
> +		if (!frame->skb_std)
> +			return NULL;
> +	}
>   	return skb_clone(frame->skb_std, GFP_ATOMIC);
>   }
>   


