Return-Path: <stable+bounces-80577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39A98DFE1
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A3AB2BFA6
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FE1D0E22;
	Wed,  2 Oct 2024 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MlSWA8oG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jTuvKvov"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655721D0E24
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884086; cv=fail; b=R9wjKCRWg5fnLaRFR8W7akKmlH1om1FzYde++KBBDswUcjc3+05OehtPCWIhggBtwou5qc/aI9cxZmzPzoUE7uPYmYSnueUs/WPb/hDXIfqOmmkKQt9fTza6d97kcOXhlOUXsqSCzwpQx2YotzRY08IntPXzymHonuT+0b25oGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884086; c=relaxed/simple;
	bh=Alb8ZqivrKvK3e7xB2kuNWyWqRt1rTGOE5tR5SYXkaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HNXrkYJGays8k7060FXcxfW2Qk37GEcI/K3QAfWF0o8oKpCpL69BOLJ1oni6LcxXxrcrwOFsJGTAvhdlLI0RnJOfhAc7zl54YnlaWQX6Ujke6rkAj+ev4xo3Y9rHT/WSCubXMxEen/PifIcH+2oanCxqsjSFiozM+BprscdQESs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MlSWA8oG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jTuvKvov; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Fg8T1009116;
	Wed, 2 Oct 2024 15:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=X8yTWEM1Xc2qRWFSlONxHMOJSC7pzW99uOPkliLd0Eo=; b=
	MlSWA8oGSyBAjmsWw18nOffrg059Tn3giirygwY0ogWo9vglkxpV1LngfqOxACbc
	C6Ox5LLSlPybGjsK6qeb06xkAKCZp3G1YgrJodswuO6kIK27VdDzXji7yrm0Tfvx
	ZY8DxB6RBdcUyqpKsj/FSusnsAowrKtKvzedW7xWZXXOJ18RL/3d39qWydQA7dTh
	m49FUI/bt5B1MlFQVrut1++9KqThvuUKZv9MpH6rgiwJw1NUCN4WOkYkF4xKtVIR
	h2ObGVjniZhbRUP1OQB5yzYvg+Y5iXU27TnpUQ+MldmHs3CtJSMlUhjrkYsyOeV1
	QBuNvTZ04oIMrMiWD6Y9FQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9ucsx7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:47:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492F47TI012674;
	Wed, 2 Oct 2024 15:47:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x888t27b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 15:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1vlXWjvtSlOm0+EYJBUaH54laXr5m2lnr0UMkdiuGQFOxouQXgS45YL5Ym4iB1pI1DGwECfllcKbAATpKBedEif3Fb4D21CNnLiqq54Jx5oAGjz7ndOARsRcxhy1W0IFnIKmMi01IRaztEp2ko0ywDN87D8hunZqL4pS5+uYh+e4pLFOHPoDnmyJxYYtc2Bj5WzEjPBJNgG7TJU1gJfBXPOsTibY+7LzdiJGuF/J9h75NCcVmqu1GVemJDSMR0APgR9EcF9bF6f4n7wppSBFlGpZCI7q8CQf9V47ag3K/u+LD8+HNjem60e+dkbCovm9+tNizM7Nm+CXjpi3tM0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8yTWEM1Xc2qRWFSlONxHMOJSC7pzW99uOPkliLd0Eo=;
 b=Dehp7oIEk8vvno70L2+OApx1OVGUtuJBdTMyGz1x6SkF0MgTMWimwlyCJJCfucpsSESTirQvTVCFSvwuXjbvay5ZIKg9M3fDkifbmpaKhZZlAm3pW1zrORGHzpGi0H6mLF7xlU44t7pk/PhCXvpVasJjMQoCJ9env+ih127WyCMqfW9hvl4CBSG/sXmNL45AbzRHheCcMu6EPCF49sbBcYXnId+wL6MZ8peay1lLHGiDgvaqKON6cTel6WRBgaTVfxtuIZwOZajekxC/hRji6V4rIjkAgcstyVRm/XdBrBFeSxlX1hRnSMUEUQF2yDuRl3rlttVVgo+HAyOYj7ireQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8yTWEM1Xc2qRWFSlONxHMOJSC7pzW99uOPkliLd0Eo=;
 b=jTuvKvovJCtBwm3pMbc2V96+pv3972S3qJqfVIuD7DsA+5yEyGVTHG4tqNn5llJKfM6hJrNG3QLxsytzy1rb+lvVyK0coXpVFf3yC6Gcz9iT8ZDHuj5bBWkYo9X/ogEjxHE3aVPJ12o3F7AV35PyioBcKl4sNi4XHbugFOtT3xQ=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by MW5PR10MB5827.namprd10.prod.outlook.com (2603:10b6:303:19c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Wed, 2 Oct
 2024 15:47:13 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 15:47:13 +0000
Message-ID: <69e265b4-fae2-4a60-9652-c8db07da89a1@oracle.com>
Date: Wed, 2 Oct 2024 17:46:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
To: Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
        mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
        ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
        shivani.agarwal@broadcom.com, ahalaney@redhat.com,
        alsi@bang-olufsen.dk, ardb@kernel.org, benjamin.gaignard@collabora.com,
        bli@bang-olufsen.dk, chengzhihao1@huawei.com,
        christophe.jaillet@wanadoo.fr, ebiggers@kernel.org,
        edumazet@google.com, fancer.lancer@gmail.com,
        florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com,
        hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl,
        ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
        kirill.shutemov@linux.intel.com, kuba@kernel.org,
        luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
        mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
        rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
        vladimir.oltean@nxp.com, xiaolei.wang@windriver.com,
        yanjun.zhu@linux.dev, yi.zhang@redhat.com, yu.c.chen@intel.com,
        yukuai3@huawei.com
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::8) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|MW5PR10MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe3bcce-ac9a-4853-2313-08dce2f97b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHlWRVpsNXBvMEVGaVF2Tm5PQ1dJMStpS0l4Wkt1T2d3WlZOQjlEN0RDWlBH?=
 =?utf-8?B?cEVoRGxhRlFLR08rMXBLTGR1ck4xMlV6aDl2VEF1YkgrdXJ2a0VabzlMWWpj?=
 =?utf-8?B?NVBQWTB6VVZxUmh0MUtVZ3F4NmMzek9VM0RSdHZ0Y1VaRm5ZU3lYRkhoYnpq?=
 =?utf-8?B?WGJHM0NBeVFvZ1hNMWtEY3IxYmwzUGtieDl0RWY1aTV3eUtoYkdTNTNXeCtn?=
 =?utf-8?B?RVhlT1ArSkorTHhIb3NTMGhvV3hhRG5TS0N6L250T3QxNk00cmFnSkFHOFdK?=
 =?utf-8?B?OG9JOU1TK0NUNzk4SE5vamliS2dZN2MwdG9MZEJyZTlSaUR6N3d2VVRkVWMz?=
 =?utf-8?B?RDIwYnZRTTBWcXBtR1pUN0tLNmJ5MnhQM1lRQWEvNnNYWWVMT0V2eWJaN3hZ?=
 =?utf-8?B?ZmcvaVVJWThLbEJSWlF1OUE5ZkZ6RXdhdkVSNFhaNmhwZGdLbWZRbTRPQ0RR?=
 =?utf-8?B?MW9XODE1VXdFUDEyMWh4Rmc5RmpoT2tBUTRVc3pxWU04bklMN1p3dWRPZWRO?=
 =?utf-8?B?Vk1IaWFGSE9rckVWYkY0YVJpeUNmYUlnMWs1NFNFdkxnU3BYMG1jRSt5VDRS?=
 =?utf-8?B?VW8zT2dlcVBHNkhNdnZwblJlOU9vU1RFMC85WW1XQmpYc21UbkVHTEJZc1ZG?=
 =?utf-8?B?SmprTW93Yy9PMFUxNWtKMnVxdmdUcVU5ckV4bjRqMG81VHl4ZXQ3T3FXOXBj?=
 =?utf-8?B?SmlqMEJxbEVXN0MxOHlwdDc5akpnRWlkYzllUWNlbEhnRmJEL3IwNnROeVpm?=
 =?utf-8?B?UCtScG9xbzhndjM4bHZqTkZsd2R4QlRuTitrVjB6M3RrOWdsTXpqM01NZFRS?=
 =?utf-8?B?NURrbEpCVE1CQkR1V1VQS2FVQW1oSjJsVVFpbFVsZEwzMnBtbVZnZDJ0eEVJ?=
 =?utf-8?B?MjVTZ2luRUdXcmFtbjBYWjg4YWxqZTgwUE9xc1MxVlFONWVwVmRVeWxZUjVs?=
 =?utf-8?B?VGwxSHdWWkZ3eXptZ0NLTlZhblUyOW44bUpRVjRFRkRZekx4TEZ1MlcwSmZv?=
 =?utf-8?B?Zy9acnp5MSt4LzZXWEU3T04vM09lZHF5K1h3V1pCenR6TENqSmtlbFMxTFN2?=
 =?utf-8?B?N04wK20wN2VVY1hZYm0vMDYxKzV0ZTVhbTRiZjBKZGlxU3dTQi9YT0ZtQ0VC?=
 =?utf-8?B?MWQzRkl4bktoVkk5OTVjeFF4Vnlta2Mvd0xnSCtyMkFQVWpLWnBoTENRcHFI?=
 =?utf-8?B?ZW5FRGpNUDRDU21sUjFIaFBJZDVRU0Q4MHVxcm1zZXVQTWpFeDJBSDlVeEhF?=
 =?utf-8?B?VGZUQmY1VjZYc1lNandXNVYxeUMzMHlENGZFdi9RMllxVkJNd1ZGRUtUYmtk?=
 =?utf-8?B?UTcwaVFZZXZkRXdWdTJ0OG53d1ZRNUFkTEhpZDI5bU5kcVFGVk9nRGtwRkhs?=
 =?utf-8?B?eVNjdlk4T2xvUEwrS1JaTnFuTzhwYSt0VDcxZEdBSHhEL3NwcmdiVGhYY0Zi?=
 =?utf-8?B?WStKY3I5SEREZmlKOEhIdm04MkdTdVZHbUEwc0hMdm1tRHdxblVseWtNOHll?=
 =?utf-8?B?eENKb1hKdzhiS0RVMHI4M0N6azRnLytUWFNRakt2Nk9md1pZNzZvSHpLRlo2?=
 =?utf-8?B?KzV6cWpQWCs2cVkrdDhWVjRaVGdFOWZWbGxjeXQ4VnlLeHgySXVHM25jbnBu?=
 =?utf-8?B?bFZzOHFCeDNjRXh1RXdGOHVtRDd3VHUxNGFpRW1HNnZKOFN4T0xPYU5JWTVm?=
 =?utf-8?B?TC80N01BQTR3b3U5RVVrZHRSQjFHbzNvUkxzNDZ1ZGpXa0tHUWxiYU53PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC9qTmZXVTR0cHE0eGJzdEp1Zk9oaVlRR2ZxRHJNU01ITFYybFZaVjR3RXlC?=
 =?utf-8?B?TXhYTHVVUVZhazhlcVU3Z0FhZnllYzl1RVFQaTJqUUhDalZRK2MydnpuNDUr?=
 =?utf-8?B?Sm5nbjJBMEYrU2FFL0Y2MVkvYnh2bVNrc3cvN1hwK1VlekdwbGVjWDNMMmgw?=
 =?utf-8?B?RDl0ZWVkejZPMkpvQjRiWVFZbkh6dkFMR1FFZDhSUW9wV1ByTXF5US9FZG5z?=
 =?utf-8?B?MytxZVAzOGdKL3NyMTEwTGVYa0tLanFXbGlaNDB1bGlRUDZqQUR1QVR6TkZE?=
 =?utf-8?B?S1VEMkc5eWwvS2JVbUs5dmtXNVpOaHJPeFJvV01lK2haUldaWlhuVG5QbCtC?=
 =?utf-8?B?dENBaXI0dmNrTHVnTHhRWDVaUlRSam5JbmlRdE9SN3loYmdjNldLK3ZYeUhu?=
 =?utf-8?B?OTZKeC9IUzN3aXhYNzRHZjlkVXFWOWZHMXJ3ZDRlejM3VUpzQ3Qwak5zaEtG?=
 =?utf-8?B?dXl3L1RKUDA3Qkd4R0RNTE5OQjE5YUhDR0QzdzVWcHg0b3B6WThFb3o4QWpM?=
 =?utf-8?B?bEMzckVPWW0zU0VZazkwYWhHRXJCejhlTnQrQ1NkYUFSYSsvbHRsOCsrWkwy?=
 =?utf-8?B?cHJWb1FvMGF5ek9VM0s2U1p2SkhENHVtUm1rU0ZVZDVJVDlDYmVuWWpXWXBr?=
 =?utf-8?B?YmFSZ0oxakZndk9pRkRMejVjRjZlV3JFUTRudzRoOEdwVFdIdC81Z2k4TlZj?=
 =?utf-8?B?WktnSk9sTHRpY1pQQXlISThCZ2pSRHZPK2tUYUtCU0tuSHNvUDlIaGlQRkd1?=
 =?utf-8?B?ZFFOR1B2TTZ1K0c4aXAwVUFYbWJ5dmhVQWMrUW5pUmRERlBuVnRBVVp1eTU0?=
 =?utf-8?B?bGppekRDWnNIbC9ZUFo4TTdjMmpXTjUzS3U4eWUxWWtGNzIwbXdnZ3Q3SnZG?=
 =?utf-8?B?SzlaeFRLVFRvRkNWdlBoY2N2Q2E1MllqSGR4bW01QTlFRmJlZmQ4eC9NREhm?=
 =?utf-8?B?MGtYZjZRc0UycTVoVHlvSmljbnVPTjc0bHA3ZVVHSTBUUDdENktLaGNxdi9S?=
 =?utf-8?B?U1FaeHdKdnZXKzFMUmNGYWZqL2J4UEEvSS9ZOWVON2FVSVN6TUc5NWVGak9Q?=
 =?utf-8?B?MWd5VVRISXNIaXlYNlYwSjhGTnNsTlpaREo0TG1Db2F1U0RPb2xZcnBweUtE?=
 =?utf-8?B?QXFMWGpLOWUyR2dDN3I2TmVlVEh4UHlsY0RlMG5QUUJvL3o3eVJkYUVxNHdM?=
 =?utf-8?B?QTRDV0lUUElJelYyMnYxejRkdnJ1TFdYQThvcVFocGU4Z2luWTIrb3ppVlZz?=
 =?utf-8?B?SFpNSUhvWlNUL1VLc3JFbklmKzhqVThmdFJRQzc2aUxOOGZDRzdLNTZlaVFW?=
 =?utf-8?B?cmQ5ZXNXTE9URnJhUVpJRHJtTUJHZVl4RmRieDJRZHd4VXF2V01ibHF2NTFz?=
 =?utf-8?B?MWU1OUlreHFxV2t4aTFqekorUXpETTZJeW01cmNkb0hUOXZxRXBWYWRzZk41?=
 =?utf-8?B?QlRpSTdhcXhNbVlxZlp4b0FUU0cxNjkxRThERjNYUVN3V1FmNkQ4N2NGOVRV?=
 =?utf-8?B?RkdsQkRtcWo5SllWellQamszZmFsTG92alM5SWdOZWZwTW4xK21qTHFYMlJU?=
 =?utf-8?B?OVo5WmxLTU4rK1NSZkc1VVFzcmhkQVV3OGRDUC9LVmxiNlkwY0NPRlBXeXdC?=
 =?utf-8?B?Z2U2M3RWaGhKWHZrV1ViQ0RUSTNxRjVnU2c2dHQ2TmJaakpZYWZ0Yk5iUTg0?=
 =?utf-8?B?VzVPSzEySVlubGMyNzcvK0thcHc5MlVMRTlMVjZCNWE5RjlxM09Vd2dHUFo2?=
 =?utf-8?B?bWdaV3BEYkxwd1luQys3dCtWczVmekdqMkFQbWlxanJxUWF0OW4rdUdXQTJa?=
 =?utf-8?B?bTN4endsMkszckk1RHR1M3VFUGtCcE5XN0NOQzZPRTQvNjN0YmlTKzIyREJw?=
 =?utf-8?B?NEJkdUZuY2RzdHBFVFlJc1pra2dnZ0dMSUhzdWkrTlNWV2FlbVI5cG9rTnQv?=
 =?utf-8?B?VlJ3SnFNejlzMmkrMkVtRmFvc1FaWk9ENFNxY215SHhWbkZabmtYUkpPNE05?=
 =?utf-8?B?QXhFYUtQRHdUUHVIVnNLRWZTTTFQSTNxVThuaXVISTFuVVRuVFpmWVQ0TmJ6?=
 =?utf-8?B?YXVQNG95OU45VElqYmZSKzIyaytFWmhEZWhXSDlpRVhMNTZmVXhaeHJZOG9S?=
 =?utf-8?B?SDFsWlJaOWhnZ3lVNkxSdHZNTDJVbjFscjB5cG40QjkyeFM1RWxuRkt6dDBl?=
 =?utf-8?Q?lE5ATPKYxsEAjuwwNegR9eE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0cChAIA3vNBqrEVbGmjqWZiTWjY9iZHJKjz7Cp9cgAhD01Pef0/M6vuV5YuvZ5TTWcaEoe81QYbpcdtFvIpa5dm3i4MKV2SvMu9AMN3iN/dHMwQg3pgOQ19tQQPZFHvTnrbMOwrCyK6u/vpxbP7MrMOgmRgYZ2dicXVv5FoezfYFEx9iV6MxwdOrmQ9E+dNMUUDvAdU8O9yqdowtIc2jiiWJeBWQ48a4DTGi7/TE4gdAIdgmtZyre80kwyva+KD6bwSEUKkcn1yPHsl5BGpo8OWDtir8fNSdURZmlNDP1rfTCeAfM0yYoa1oqVD2OhhTF5AkoxXjP9CY8aaU9rJ3onB+5zg5W0PeAHiJv5TJbKNsSJqG7GtJx8kw1idPFRuCxZApe+96snZJKxE5lnCHGGntUNmAerBIiIbDSe0v4pwx31YK2ETXIca0KtxMgYjw/kzsCLnSPLY4lyb1czVPswDd8nXjVcbtI1ssw5ShcXZ09iY0FGAahpZR7pgnvcEqstMYI5Jyyk9AZRmflpxzlfHN6gmH7hl4MwOkssl9iVCQ7KqksF68Wkm5VLSaznmNpF15tAf+E1wSNcUOvJ9DlPUcDDK6rsUK300JOspaBAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe3bcce-ac9a-4853-2313-08dce2f97b9b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 15:47:13.1704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byfvM5me8t6D2Ow8MWf8IfN1RS2CQLUe4VQ1rXCEb87PUGoPa6hfIYS9u8tmdId1j8BbSQi/Larn5avnUPndxhTT6Ea0XBpcWmyPC+HJXIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020115
X-Proofpoint-GUID: VqBW7bPwPih4oQWRCnqp_HrEHN28ayUy
X-Proofpoint-ORIG-GUID: VqBW7bPwPih4oQWRCnqp_HrEHN28ayUy


On 02/10/2024 17:26, Jens Axboe wrote:
> On 10/2/24 9:05 AM, Vegard Nossum wrote:
>> Christophe JAILLET (1):
>>    null_blk: Remove usage of the deprecated ida_simple_xx() API
>>
>> Yu Kuai (1):
>>    null_blk: fix null-ptr-dereference while configuring 'power' and
>>      'submit_queues'
> 
> I don't see how either of these are CVEs? Obviously not a problem to
> backport either of them to stable, but I wonder what the reasoning for
> that is. IOW, feels like those CVEs are bogus, which I guess is hardly
> surprising :-)

IIRC the ida API change is not a fix for a CVE, but it makes the other
patch apply more easily.

The other patch is a fix for CVE-2024-36478, here's the CVE assignment:

https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36478-d249@gregkh/

An issue being a CVE just means that it has been identified as a
"weakness" and assigned a unique identifier, it does not mean it's
necessarily a severe issue or that there is an exploit for it or
anything like that.

Unfortunately for distributions, there may be various customers or
government agencies which expect or require all CVEs to be addressed
(regardless of severity), which is why we're backporting these to stable
and trying to close those gaps.


Vegard

