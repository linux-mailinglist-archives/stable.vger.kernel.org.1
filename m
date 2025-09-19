Return-Path: <stable+bounces-180676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1872CB8AB5D
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47373AC96B
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F295321F44;
	Fri, 19 Sep 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OUfvE6iW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wkWA3Phm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E8321F3A
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758301983; cv=fail; b=PBX+j12A7C9XrCBACNOnL5hBh5ABFiHnUf+GCrudpj2vJZgBXWurTjxBPr4JOrGvOgc3W1myYdYvPxO+Q5nCEpbjutAjQksnhKuQd5+fW0YP9o2/lfytSO09CSdlAT1mlox2Td/Zx2MbfhUoxerELWhlnVnCmyERH9nH/oHb4qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758301983; c=relaxed/simple;
	bh=RJq54SobbyDpy2FDBY+kTZfU3m1fDQ4TkEa26vqSrwY=;
	h=Message-ID:Date:Cc:From:Subject:To:Content-Type:MIME-Version; b=b/NKibKveHQJKX7ke/2EUF8wHLbS92RR8voXCFqAZT2rATtN49Cv2NPi6e2Ok52YY5dyM96y3CGsk6hxDxEQmEQ0nHKW4GRxPEp/5jcL/f/III7X0RqU31k8ht/yZKLf+Rx9U6vZAx6XNdlR6ipfrRrXqNQEm+mesf27sCO+H+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OUfvE6iW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wkWA3Phm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtpc6015804;
	Fri, 19 Sep 2025 17:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=XJWqRXShv9Lutm95
	OXU5i2csWOsmGWHAhSdka7oMnrE=; b=OUfvE6iWd121WRJyQmuRNiWJy8UcnhiX
	YKVdEoOvpEboof9fclAl2BnQlH4RCiyQig4AEzpFQeKp1BkyF5cLv/AjJXg/fTZW
	UefLYLFolxYFW/0YlqsrhJSqtVxeFMHvtxJYNKrbXIVmSqLqmuPbK0ZjepIisN7a
	0s7IwRxvPQZmfjbuILW+KnN/7uJ1ORiwYRmgQYeLvMmJ9qksRX8pyM0Sknkba3WB
	HVjbBnQbGxwx89k1QxH52uyyA4MWso0toi/bcTlScLMCBsZqghHh/XsIgs8Vvso+
	konI9cSqWuAor8RotBI5DCCocfekcxxu9z4nlAg36mdJbYfuAAfIAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx95y9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:12:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JH1cLW001487;
	Fri, 19 Sep 2025 17:12:45 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2gxbck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 17:12:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Izy/9ULEQ49/V/Kq1PPqjOGtxVWCAIgMf58iuAC/yNKEQFdSklVxCcj0B43oSgb5Uv8T+GC6KCbnGFfZgjS8yG5wxlKubonVGVWpk3dZRiEkgrOCU18mcsuPzEyNiMqjJ2sBYe9w/kQReo07KIOeoLMGWFZ97l05V40YInHrwqv/LyBCis3QAueLN0ApXs6ZnAK3pF18FB7rlfJCZoAy55q4mo5kkfQ/XtvKOiwWZXcctwDlxuSP6G8icVFvssrkmduELNm0BAcSqH24mzoOPrLI0/HtRxa6pwfrH3sHPXYFruZkqVXlPZ2LzSmYqz/ANHvoPO1UbB4xnKF857kUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJWqRXShv9Lutm95OXU5i2csWOsmGWHAhSdka7oMnrE=;
 b=MUVApFvl4xIhcXH4ipljWA5+LfYQqBlU6LyGvdyvsKux9T29N2/uJSNqTOHPMpLgieaC4ukxmXDY+l3wfmst0eaO62lUrHE8FId1qGSRsxjyFb6AjhjBOMAYqIW2R/lul086AuBxZVfDBl1ab0Melby9+ugmkWV72/dIwxAGbA646P808Jjvt9HZIfJTXayJi1HGank/KqW6Te+dGunryGLbwgO9ECgYhvEHGhLpPIZH+qyWvsbpgR4f5FjhSh17DUAZGzXwSswPB4aduaLae0BiYtf1FW7UBPgnQT5pXrK6waCUF6AzWdB1IFRa2u18uYa+OCrOSPg6Be59ve0QGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJWqRXShv9Lutm95OXU5i2csWOsmGWHAhSdka7oMnrE=;
 b=wkWA3Phm0SPguHhX/92PdBpMvamMZoMWBGWfWcNmhbKOCFbL+rJ8jt5wQXH6XGCDxyPowCeCaCaJcpVA6ARW6LLjuH3SmrafDywLdX7uKIcNud8QpXwIhycS6RHPr5PQY6N3OPniABBPAb18luRRJJueedeiOmP1d/5nPVdeiTg=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by DS0PR10MB7406.namprd10.prod.outlook.com (2603:10b6:8:158::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 17:12:42 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.9094.021; Fri, 19 Sep 2025
 17:12:42 +0000
Message-ID: <915c0e00-b92d-4e37-9d4b-0f6a4580da97@oracle.com>
Date: Fri, 19 Sep 2025 22:42:33 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [bug-report 6.12.y] Probably a problematic stable backport commit:
 7c62c442b6eb ("x86/vmscape: Enumerate VMSCAPE bug")
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, pawan.kumar.gupta@linux.intel.com,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|DS0PR10MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ceb94f6-aadb-4695-ae75-08ddf79fbe23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGM4WUV3dC8wTEdrN0NQYldnVWl0Y0FienVIZGw3U0xYOENBRnI5YzZlRk9l?=
 =?utf-8?B?OWViR2pCTEI2YVZJVFFBd3l2aWV6SjVXWC80bXgrSmFERVVoeHVVdDZhNndT?=
 =?utf-8?B?OUV0TjVJWXB0NmFOeGd0NXlDeFVrLytDNkhsbGVxeXEvWmlxSVdzYXJQanRU?=
 =?utf-8?B?Ry9zNlZXbjBxVmlPenZqOEJ1MFllWmRyUEtwMldlYWdCNTlzZVNLR1BieHZL?=
 =?utf-8?B?b1drMWN4U0tRYWNRSXl1NUYwM0tpRlN3RGFTUXdnUFdxSXFNR3RmNDhXbHFB?=
 =?utf-8?B?ZWFLYUlNcUkrRzY2SVd2STd2UEFITkhjR3Y1MnNHM01IN3JJcGphN0REZ1ZM?=
 =?utf-8?B?U1d4ckEzZ3UweWdUMWV5L0dzQmtidDZGcXFFcUNLK2JGQzRHQkxTdi96SjZL?=
 =?utf-8?B?VlZqZU95TXkvVmNJWUFubEZTdXhKV0VQb3ZvYm1CVmJHUmdnUENSa3k2azdB?=
 =?utf-8?B?OEhuRkZTclZRRjdac1BNV2VsZnVzckdGSy8rbFRpSTUxTHQ2U3kzNkVtVEF1?=
 =?utf-8?B?SmhoaUtSbGVYUzFtck05dENGb1NHWEtSTjJFK1g1WWdIcjhLY2hzMGVEdmdY?=
 =?utf-8?B?MWw0Z0d4WDAyUjZsbk40SkdvV3N3VkZkc0JXdVpjMnBWeG1kcHROZUkxRFhQ?=
 =?utf-8?B?NlE0ZSswaHduQURTc3dENHYyTC9ndTlWK0E5NUdoV0Q4dnUrT2VBcnpDU2lR?=
 =?utf-8?B?NWtSRnVKcnlrdkh1cHpBL2NLeVpUR3MzUC9GSXkxeE1meC9wWEdzZEZpTEkw?=
 =?utf-8?B?eEZrQVN0NmpPQ21nd2JGaFJkRHRldVdDa2Jjc2RyNTFKYWxMekFpNVJFMnNI?=
 =?utf-8?B?NnlnRWRCb3lYOHF3WGtTMzFReU1BOVJ4N2ZrcTg5aXpZMjVVOUpoK3hZcHFT?=
 =?utf-8?B?UFJLR2M2WmNpMGNtTEYvS2pyTStYUkxLMzFjdDlqbHVvVWd0NkxUV2VNTXUw?=
 =?utf-8?B?c0p6UGVwaTlVbktMY3l1RWN1Zm5tR0FUbUV6Y2pNdE4vNnQwNWRBTUpiVzZo?=
 =?utf-8?B?UGF1WW1mcTJmd2JTN2ozUTVGU29vNnJqcFE4WjJ6cmRCWVVJYnhod2hKKzYr?=
 =?utf-8?B?NW55OFcxdEJ2SlFEelhhU21maGpxQXRMeXQwZlBrRksvdjFQSW9KbWtlV0Ir?=
 =?utf-8?B?enJta1QzT3R2NnA2VDJ1NnBNRUllajNoT0srdWZ5bmNkZDIyczFGbDRGLzFT?=
 =?utf-8?B?c3dhNVBQS2U0SGJSZDFrTGRYTW1Qd2plenJNQkxVNEZVZW01T3pPaXB0UUdW?=
 =?utf-8?B?WVdnTG5PTlI1ZGYvYk5yL0tSK0VRKzFNTkxOeEcrL1VqOXg2UngyMS9mY1Ju?=
 =?utf-8?B?Y1RGQjVTamNkbkhxUUx1VmxCbXVtdjlHektwTC8rWG96LytGMzZ0cGtpbXBE?=
 =?utf-8?B?eUswQXBObCtOSVR5SVJKUnVKRkcweEh1NWdBa0wyWnVmODNzTDV0cCtiRkpK?=
 =?utf-8?B?OURvem5IUXlnZ1BXM2g1QXBaRzk1TDBvYnpyVUJZQzBINlJBWkxXZ1UzOXpo?=
 =?utf-8?B?N1gyTjhqcWxNOVFUZHJHM0RJclVOK05yVUNzWTQ1NG9ZcThWUStrcmVVbnhl?=
 =?utf-8?B?RUFzMVhFN3F3cTVYNTByVnkwSGkrS0hQN0FOd3V3NXhRTkM4VjArVkgvcHlo?=
 =?utf-8?B?Z1hiNVFLRS83TWtjV01kRWhOVjZvcU0vdTJmeE9MWTludmlYellFZXg5eFh1?=
 =?utf-8?B?b3FMeHJ6UVF6ckpzNXlJeEhtZmVaQmdPL2VqUjQ5OHM0aXVMOFM4dTVYK1VT?=
 =?utf-8?B?cythTVhKSTI0RE9UdTk5NjIveTZDd241aWJCTnBIeEJpOEpyZ1R0bDNXSlRw?=
 =?utf-8?B?WjNMcldocGxZa1hsemtZN3RVQlZHb3Nod2tyUzBxUE41dGRiSHZsa0ZOdFBq?=
 =?utf-8?B?eVlPOUJ3UHV6emwxQ0RsVWRBUFNtQ05weDI5UDdjZzNOdUFwN0dmeDBrQkNW?=
 =?utf-8?Q?PXzTQHuLOFI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2U4dHEyVXpqd09NWjZJWUdSRThJTnpUd1ZsdExHc1JHUHN6NVZRdW1XUERN?=
 =?utf-8?B?OUthZ2xYdjJ1VHJ3SDdFVDZvQ3dqMllsTzNaWjgvWEdGbnEyQUxYcHBsdU9o?=
 =?utf-8?B?eUNDSkRyVnB2enpZM3FNNjc5WGx5aXAvQnhldUZXT3k1VTVRenpjUFlDN2Zh?=
 =?utf-8?B?MjlYeDRUVXFaZ2tiQ3dIODdtUVh4alRFb1l0cnA4MzVPNXJPekNPQjVod3ZY?=
 =?utf-8?B?ZThTY1Mxd3ZqWGdDK2RnZ1BJaXBIY2huSGxXSXJ4YnBrVGpPVFF6MnVXaE1o?=
 =?utf-8?B?QmZnc0NjSVFJZXZOL21wOFR1cW9PV0p2ZFdWWnRJZDVmVWtVak82dU5hYUZ6?=
 =?utf-8?B?K0ZaYWcxbVovVWlOZjdXZHZGTmQzdFl3WGNoTFhpcW9vMlRDL2FzTk1EYVJK?=
 =?utf-8?B?bEpFL3VRb3dvU1kzeXQwSS80ZDVDZ2lqalFHRlpaMk9DVElOSWFxdDBsV0Zr?=
 =?utf-8?B?bnZGSnNubGZPS1BjUStycjVRa3hPWUJoU0hXVWY5VDh5RTVRUnRNK3RRWGZ5?=
 =?utf-8?B?Y1FZbGowT0NLWkQ1YVJEN0VrVXZhWUxBbFNNMWRjMEFhSmJ5bWVaOFVuZ1VU?=
 =?utf-8?B?VlN5dWQyVmhkVkZkd1dlb0xUTjZXYS8zOVRxcncwZVE4dWNEQmVnVnVzRjZK?=
 =?utf-8?B?VjNEWEppZTZwYSs0RSszeEEwN2x3NDRuenR3T0hTSzk0bE42eDRjcFhTem8v?=
 =?utf-8?B?OEpRclF3V3ZQK0dQUDY4WWRxdFkzd3ltZUlNUXFhSzc1SFJtRkpUME5JS1RM?=
 =?utf-8?B?M2lkbXBmMGdwMzkweUU4VkxIT1dsZWU3alFVMWFRSElMMVpRRUYzcGEya1lR?=
 =?utf-8?B?Q0tuSlZ4VzJJK2VGSWduKzY2MWw2SXVidmZJK0JLdjJtb0RPUlNmS3pSZWZP?=
 =?utf-8?B?NjVFVXpWNy9DSjQ3QXN2OHkzdHAzQVBoa0NVUHZOODdkR25rb01zeFVabEgv?=
 =?utf-8?B?TlFlblJRMWUxV0ZqRytQMDFaV05lM21WR3QvQS9kMloydGhJb3U3Z2tZaGpr?=
 =?utf-8?B?YTAyMy9BOWhLTXpZTWtsdzN4dlJjRzZZSU4xUW5CK1NKRmNNQVdwYzYxUkpR?=
 =?utf-8?B?ODk1SjhMcDFzdWRFdFNLT2tnVEZzdDN1aGlaeXZ6cG1vZTFOajM2VEJtZDBs?=
 =?utf-8?B?dTczck9GUU5jc2RZTFBldm9nSHROWVhIdzc0MHZEOXlFWk0vZTFoT0tzbEVL?=
 =?utf-8?B?Wm1KUkpkZFBxL1ZIZm1xdEtyangxQS9EVHdVTWYxT2JCQlJBdmJGcWI4K1Vk?=
 =?utf-8?B?MElhUzZDQ1d0SEp3dFZYZ2RHL0UyaW5mQmh0SzVpS25WdWs0alZGOHFhY2xT?=
 =?utf-8?B?dEpNNjd3ajVVc3VTZjcyaG9nOFpGZ2tqbWtsZjgrNVl6UkhGNWxnL05qcVdn?=
 =?utf-8?B?RVJTSEFqZG1Ud25PdWgrNFR5bTIwNUNwQ25EcGU3SGNucEtxTXNiSGF4bC9h?=
 =?utf-8?B?L0pXalAwbno4Vzd5WnhpNmtZYkR4cFpSeitmWWdRZG9BSnUxeGZGeExGNnlo?=
 =?utf-8?B?L29HNUdnUmFoQUxCM3h1SEM3WjhxSCtpVjRtbitvTDltRlBRTGZRbmx2RW8v?=
 =?utf-8?B?MXBaZkc2OW1YTC9hNnI4Qmk1SHUwRTc5eXA0MXMvRlNNclY5Y3I0aDIxVkdw?=
 =?utf-8?B?a013ZDBYSzNmaTU3RTNsaVp1TnFXek00T2crZVdYN1dlMFF3UjFvUGRQY0RI?=
 =?utf-8?B?ejZLbUVqdVhsa2poM0ZwK01CcUFkTFp4TVp3YkRuVE5tbXZYUThZVmdNOHB5?=
 =?utf-8?B?cmZySDdpSXprSWJrc2U0d01CNUoweDZ6MStHWjVRY1VpcHErckFRdkFyMVhU?=
 =?utf-8?B?R3M3TkdrdlJoUkZmeStWeERKNldKQm1TV3ZQbHh0RlVwSHBmd3FvNG5INy8r?=
 =?utf-8?B?a0crcU45dFFHTlUrZE9zZUt2Uk5BZWFvNklNOXZrYk1uUHdLUXRHOXVWVTBG?=
 =?utf-8?B?YkRSVnF6NUEvam9QWTM0aEpha3lCdWpJaHpBNG5NL1BybnZOMm0yYnpQUGdQ?=
 =?utf-8?B?S0NJdlFQMVloYzFzWkp3VTI5UHpWU2hhTEI1UVNPcFN4Y2JUNld6VVpXeDdR?=
 =?utf-8?B?NjBzekR3V2tnbStDcWV1ajh2cElLN3YrZUM1c3FuYUNjelhER0pCako1cUEr?=
 =?utf-8?B?VUlxQisrSUhpYjlVc2E2LzFuUXllNTZXM0pzTzc2MVh5TVI0MkFFYUFtM0dj?=
 =?utf-8?Q?fAv6LVXHSxqgJH6p5j0PWj8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DeudEyAVM8YGAlBq4H+W0n+23Ad6uQEncK5mRW8PWMPYdJlmYH1adJqrOxcV0u9XTK7eanUltFv5CfHTXxmXGO4C+uyajf/vYLunowID/bx4xNGMZXblivWYhvbbprlteUDmDAfD/5hVdyZeIMZMAg7mlWN1yXFEoc7iS4a/Uht1ZfZtJ+VEjqyRKehZ32OHU6ddInK5PHaSqXXRHr5L+dYSjeaScVmi6QVMmXaSvBYn3h3u7q/9vtIBGSrNtF12ha7q1IVsnckRQvhSqHexKakkp1ikMbX4r7uCJn5aAkKttOi09UCqOZuXNTLRykvp1Jm5MZ+FHn469J6BmgFK3tD0BQ1DYW7lTWwCFrIao5LycNy+xtg1ROn0oATAZqMUhd7/+ljNrK7dPP9XppS0DEb4SFS6kyyIWyR8E3kuVQU26i1bgNKIoB3vrnWcGBqFliaHfKSyIpcCcJrQME1OeLcxHhoV1XpdKIrdN2y6hgAGGE5RVIUImUKPftIxeVEJMjop/s5tCPq0uE6QgO1wpIwkNY823BxJbgcYfyI7cVP7UNWTBXgx0JQYOGNuoDSgMXgDV5I5jVskYdZWtLAxTHBo1pIZeFQ3VaH/XRoG0ec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceb94f6-aadb-4695-ae75-08ddf79fbe23
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 17:12:42.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Zt6jPBBrb5S+4RDwYV+gpXmOPqJ/wYws+KB1fpYG1U2H6PL5q+6H6CuRFO+rbZz0Dyvu4AEDGdvklmnTAf8Mz9Tazmi3BjP8ScdT+Tt3e4wAkFqTZwI7gq7/GlrUMZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190160
X-Proofpoint-ORIG-GUID: TbfRfXgr7rv6wbRHnVZclORIsy1qgYTH
X-Proofpoint-GUID: TbfRfXgr7rv6wbRHnVZclORIsy1qgYTH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6HfIPhnD38zB
 AQ2QXny+3VQyxwWdZiGw2A92NOyM9HWFir0MsEd0zFbT1LIZKfcxV2JnnVmApDZ3z6wiEWHfzrr
 wDYzeCZWvzhzGpuWflQ66bpKDazNQ9WsmTQBwqNb0pXeut+E0gp9SmxeejiYBDiaV5NHIFD9Tuh
 3ezQmzGazXedOU+f8kCoTDUlwWKlkEpfcQHXh/FD2VD0QaXjhNq7nk0LS6YlAPcasglsOyyHtGp
 9n++3gLYqgdkuQTw4PA9Ggq8BfTqtqVEe75iQrl0IWRaMwgE/HKdvsu35BAcZQjneak5XO9dFqA
 tnv6yU3NSb1QOW6x3/0xnWDfANsf3n0hx0mRqkizpxfThKU+EycQ6I0tEkTqgfziDJg6r0aEoYw
 YI2euoEm
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cd8f0e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8
 a=pZVrQ4IB6Q6w4ei1vVkA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22

Hi stable maintainers,

While skimming over stable backports for VMSCAPE commits, I found 
something unusual.


This is regarding the 6.12.y commit: 7c62c442b6eb ("x86/vmscape: 
Enumerate VMSCAPE bug")


commit 7c62c442b6eb95d21bc4c5afc12fee721646ebe2
Author: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Date:   Thu Aug 14 10:20:42 2025 -0700

     x86/vmscape: Enumerate VMSCAPE bug

     Commit a508cec6e5215a3fbc7e73ae86a5c5602187934d upstream.

     The VMSCAPE vulnerability may allow a guest to cause Branch Target
     Injection (BTI) in userspace hypervisors.

     Kernels (both host and guest) have existing defenses against direct BTI
     attacks from guests. There are also inter-process BTI mitigations which
     prevent processes from attacking each other. However, the threat in 
this
     case is to a userspace hypervisor within the same process as the 
attacker.

     Userspace hypervisors have access to their own sensitive data like disk
     encryption keys and also typically have access to all guest data. This
     means guest userspace may use the hypervisor as a confused deputy 
to attack
     sensitive guest kernel data. There are no existing mitigations for 
these
     attacks.

     Introduce X86_BUG_VMSCAPE for this vulnerability and set it on affected
     Intel and AMD CPUs.

     Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
     Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


So the problem in this commit is this part of the backport:

in file: arch/x86/kernel/cpu/common.c

         VULNBL_AMD(0x15, RETBLEED),
         VULNBL_AMD(0x16, RETBLEED),
-       VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
-       VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
-       VULNBL_AMD(0x19, SRSO | TSA),
+       VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
+       VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO | VMSCAPE),
+       VULNBL_AMD(0x19, SRSO | TSA | VMSCAPE),
+       VULNBL_AMD(0x1a, SRSO | VMSCAPE),
+
         {}

Notice the part where VULNBL_AMD(0x1a, SRSO | VMSCAPE) is added, 6.12.y 
doesn't have commit: 877818802c3e ("x86/bugs: Add SRSO_USER_KERNEL_NO 
support") so I think we shouldn't be adding VULNBL_AMD(0x1a, SRSO | 
VMSCAPE) directly.

Boris Ostrovsky suggested me to verify this on a Turin machine as this 
could cause a very big performance regression : and stated if SRSO 
mitigation status is Safe RET we are likely in a problem, and we are in 
that situation.

# lscpu | grep -E "CPU family"
CPU family:          26

Notes: CPU ID 26 -> 0x1a

And Turin machine reports the SRSO mitigation status as "Safe RET"

# uname -r
6.12.48-master.20250917.el8.rc1.x86_64

# cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
Mitigation: Safe RET


Boris Ostrovsky suggested backporting three commits to 6.12.y:
1. commit: 877818802c3e ("x86/bugs: Add SRSO_USER_KERNEL_NO support")
2. commit: 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX") 
and its fix
3. commit: e3417ab75ab2 ("KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 
<=> 1 VM count transitions") -- Maybe optional

After backporting these three:

# uname -r
6.12.48-master.20250919.el8.dev.x86_64 // Note this this is kernel with 
patches above three applied.

# dmesg | grep -C 2 Reduce
[ 3.186135] Speculative Store Bypass: Mitigation: Speculative Store 
Bypass disabled via prctl
[ 3.187135] Speculative Return Stack Overflow: Reducing speculation to 
address VM/HV SRSO attack vector.
[ 3.188134] Speculative Return Stack Overflow: Mitigation: Reduced 
Speculation
[ 3.189135] VMSCAPE: Mitigation: IBPB before exit to userspace
[ 3.191139] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point 
registers'

# cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
Mitigation: Reduced Speculation

I can send my backports to stable if this looks good. Thoughts ?


Thanks,
Harshit

