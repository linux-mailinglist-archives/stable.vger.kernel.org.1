Return-Path: <stable+bounces-110977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8C5A20DA2
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83701619B5
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DC1D61B9;
	Tue, 28 Jan 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RIlXMbkY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XhV5aEAS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658EC1CF5E2
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079518; cv=fail; b=SQ46oX7+ezQFtzWGQoe2Ss5cAdOZLwVFG00IAXwqlHYzH2IesmWsq7KfaUr2q1A1M0l8amiCXAIUK5piRe4T/wil/tgN71T968JKtVJLMG8g3Nzn7r0SwHWDQThSQ2KkEyiqmcH7O4Bg+qfDJAi19P7pBeBobDCPborNl1VO6Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079518; c=relaxed/simple;
	bh=aHBxLC/sd6ATp7cc5iBTPS0ly2PqXubHOkaqlT8vq2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mChCgwwpu676k6gduNDEAwdV4+BZdJIePWLaU+ijC3HT1xw3pUG1zJC4zW7lr+OMsDzlsB9uW9IyLTJnJp50Cj2gxJG26ko9pZjaZ5Qdgn0YJjQhGUkOOKo3LLvC3OD0YFHGVAZOnSJknGCpAbHfVbfdkGYHSOly/ZI4TgnCuP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RIlXMbkY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XhV5aEAS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SFlose025054;
	Tue, 28 Jan 2025 15:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qVHiKR4ohkwZym1lh3Kr7wYfKhH01nyrvzbiFvm88YU=; b=
	RIlXMbkYQ1UW0amT9ZZh3XNJSXM9aY2LdBicrw8MdgP/kmgqWzOC+35ocL+sKWY3
	KDOzhqohAd2Ef4C4x8lpIcuVWYIPqC0+Lh91pPvFsoabn0WYggWn3mtGB0eQ0mjB
	XjxW1u4mKZJuqp8sJFIQPktvdjRKKG2kpcJ4oV7Tf9Rqu626T3poxZPrS3VX3upq
	fUacV37Qpx8/UW2xZ6gRX9yP9JR96bjnQ9XRjxOwoJuq13D8N7E5zRt/WeP0E3Ps
	zSKTngrrcipeLYqxsy+in2atEU+wimW7A28jU/HQpqDGRXeMF7Dh3pXoZTD6C0Pi
	AJLSwi65YahKEgpgzkVeZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44f26600b3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 15:51:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50SFeP8X021423;
	Tue, 28 Jan 2025 15:51:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd8hykq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 15:51:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tjLxGL1+ZPtamwgx6h6jtlb6CliOMlZlyXQtmKzlCmpl34EjKbV3CAxCHsk7bfw9mrN9tflMB04NpgN6uzOEAMCxbYx3oUE6sR/FUu5QuYccxn0UisgmRo4eZKZwpQ2LYgGh4aRcHe09Q5ONBST0k3R3s6UkzQJ6Kbm7gO9JM9BMPHks3ZPUhXI+ABY2XRYTMj1MyWeyZ+USkxRj3hVDeH4Uc96qOWYkXEuXFYPZZUIVghZwtkMzszyk2tiV5VOSwyhVNE2HiyUkUe+tC60UA2ljTXfEw4KqOtABLAR8BqYZOTNHMmbvtGVD1tNfzr/ch/zUhEEGHru25Omm4GdZNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVHiKR4ohkwZym1lh3Kr7wYfKhH01nyrvzbiFvm88YU=;
 b=uGiS5JeB1xxqYp/9kfVWtgLVq+BJpxCg51R2QcXRmgNiGkh/SIeuo0EzEzrTGJrjCgy1cmYXppiS7dafjw0zTxm9ApL6P/UYbiThgjrA9Brz3mcNDNkEoeLkEnvICjsXPcACpXijriTMTm8uG2mAk+NfPrQ4bYNtM0T+rXvlQNgWu+CVReLWYGfZkF3vUWiCX3H7zY/Y/BLu/bI+u3rLm5XkaSVPoCRJIpBdOh92p3kRLaDXdUL7BZu1HU9s/yPkboeuhZcZXa+TimcxXGDcS5Cm52I12e1rUr7Jsfwf5DRbTGA/xDFzflLI5VdhoSRWOs8T4CRxcAG/y7DYRwtQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVHiKR4ohkwZym1lh3Kr7wYfKhH01nyrvzbiFvm88YU=;
 b=XhV5aEASEpURiEp2ebCsH+/Mz3f5sUglys+H+Eifv/2zu+UQUygV33YGIYgUipS76/XVbK944LdmpaswvyCTlurG9e5F5gawuYBP53VHvx96N8h8PefV6Je8DaVYzskCKu4lKKnv/lf1LEUOw/6yhuFn3Ciou2FjHWkWnSESxv0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5837.namprd10.prod.outlook.com (2603:10b6:303:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 15:51:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 15:51:40 +0000
Message-ID: <f02f523a-dff1-4608-93f7-a0edc3bafd14@oracle.com>
Date: Tue, 28 Jan 2025 10:51:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
To: ciprietti@google.com
Cc: yangerkun <yangerkun@huawei.com>, stable@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20250128150322.2242111-1-ciprietti@google.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250128150322.2242111-1-ciprietti@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:610:cc::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW4PR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: d8949b70-160d-4a63-e836-08dd3fb3a7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUpBeU1IaVVoMnVPOXU0WlJkb2kzaFdhSER3RCt2ZlFTekxPNjdnY3o1SDdD?=
 =?utf-8?B?TWU2SldnYUdSU3V1ZTdYeGNOeHNFeUJaSTRsTjg3b3VuaHNLWVBsenIzeFlh?=
 =?utf-8?B?ZGN0dWdjYTk1c0pzakpGN2pua1VxbE5JMUFwc3J2NHgvb3NyNHptNUVmdWlo?=
 =?utf-8?B?WjBtMnNwY09GeEcwMTI1WG5tc1dML1p2WXM3ZEswVWxiUlFJOGlFVGpHRlJB?=
 =?utf-8?B?NWd0ZVJEUHlOS2wxVS9ONWhBWTlWcS9IdDVuNmdWZk9nQlQ3TkFKRXZVVURi?=
 =?utf-8?B?NjR5RkxvdWFsWTlZSWVGdG1JejRZWDc0cjd2MzUwNFVyN1FvMklBTm1mc1ln?=
 =?utf-8?B?UTFvMUJCOXVzczZFeTZIM2hHNFJuUUJwODZkK0RpbFZrZ1B6VW8xMzU0dUt6?=
 =?utf-8?B?S2JMaEpsbDVtTGFBWGNSdjZaR1RWeEhXRDUyczg2RUE5WEl3YmJUdGxRZ1Yx?=
 =?utf-8?B?YitnK3UxRFduTGs0aWM5RlpmR1M0YitvNG9sbUljQmdsaXUybS9HdkNxeFhW?=
 =?utf-8?B?RTR6a3B1MUl6ZDBpL3RWc1ZUTVE2T0FPa0l4TFh0S25hN0JDQUxMTTBFK2Iz?=
 =?utf-8?B?MXByc28zc3k0aWQvRW1zM3FRdUNKbWVPZVhTbzVwRWczMTQ4VnNSOHRKQk10?=
 =?utf-8?B?bzdwQmRlc2t3bnJWd3lPVFFsRmFuVWxmYnJ0TDFyQW9aRzk2NWVBQWJJYXZa?=
 =?utf-8?B?MTh5T2ZzeEJIWk5Cek96OTYrcUxwMEY5TVFVcEdwVUVHQzlzQzRQTmkwZWJL?=
 =?utf-8?B?eUN2WHo0ZDIybk1MNExiUWtzb3FGL2hVSWdCWnR4SkxqeWdTS1ZkSlRxWVpU?=
 =?utf-8?B?RVdDOFNRK1lmSHoreDcySFd3Y1dHOXUzQmtyajhnOEhuSGtHa3MxYXVDTGFQ?=
 =?utf-8?B?M1JCdVRsamcxaFg0K1lCVm8xZlNhODA2bEUrN1dvV3hkQWVPNDdDMjZ1U2pj?=
 =?utf-8?B?cXlXdStEeCszWW90RnJJR1Q2bGlpQ3ZaVmJMeStIdCtIM0lkMUFMa0dYbzZz?=
 =?utf-8?B?ZWhDWTk2M0FFbzR4Mm1MVDRZODh3VHFLSlZOUTFNcGcrV0o3VW8relhhTGxj?=
 =?utf-8?B?ZnRrZnlEVGh2Y0RFSGNieTJjZGh5ZlRsWlZrYXN3dVA1NUVwOGp0bjhvYzh4?=
 =?utf-8?B?T2VVamI3WXYvci9sS0dVdVZETXZOaVRmQmRnNXhwUkUzSGplODdxRGI2S2ps?=
 =?utf-8?B?dVlDTGN2MGtqUjJZZDQ1bUVHWUFKQSs5MjA4aFo5WllNQm9XZG84VU1nVFpG?=
 =?utf-8?B?SmswblpScGlrNlJHUnJqcTRuclB5UWNRbTB0UlZlUWdYbTdoM2xZa0JrM1lJ?=
 =?utf-8?B?RVZQbkZEb01WRTdHRFh1TWorS2hneTZyVmVqVzh3Wlp5Rk11Wm1wTy9QTXZZ?=
 =?utf-8?B?U3U1MS9QQ2lBNGlaU1liUmlFaGVJM2xxZ3JUQ3lxVkNFUHdHTlB5VFVIT053?=
 =?utf-8?B?ZXJaaS9zS3NZQjJ4T1dBSmlzLzFQVEk4ZkNNYmFRRXA1Sm1KU09NWjJWWFpC?=
 =?utf-8?B?bUVxTkNhMFI0TjZKN3JLbUdaT1prOTJhTks2Y2hrZTVZdG9nM2xkU2l5WFVJ?=
 =?utf-8?B?OVpaU0lUa2NMSlhYV1RzOVZCOEo2ZXBrUXF6cmVIOHEvdXVva2tsTTZLMHdz?=
 =?utf-8?B?YTN1VXV2a2RyVEdSVko4MVg4ZGlrUU5tVTU0Q21VcnZvaFpQRWk5Q0RpZjNi?=
 =?utf-8?B?dzEyY2UxTUxTQzJpcWN0TTZ1Z1kzRi9yRGhWTVN0Y2lRVEVManN0VEpodWs0?=
 =?utf-8?B?YUdHck5XSFNVSEhsbmtXdEJBUS9rbm1PSXpMTHcvN2xzYmRyeUo3MUdHR1Uz?=
 =?utf-8?B?eXAwVlZ4YUNhVnNrdXNvQjFSQmJRQXh2dEhvTmsvaE8zQ2syMVJXZHJ6V1I3?=
 =?utf-8?B?NkR2a1JCUE82cTFmVjlGUE5nNWVkeDg1THVrZ2F1d1RyUFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzY4dkRzTWpOWWk3NE9XcGVMRnh5eDFjZS9pWXdWR2duSDdjU1pQd2NPa2JH?=
 =?utf-8?B?SC9JOEZ1VGZvQWxwYndsNEJuWTk0WVNldHltcUg0T2Y4YTNPdWhJdXRCK3Bz?=
 =?utf-8?B?RGdFZldhZVdJWkliMkRpczNBUTFkYnkvMnZOdnl1RVNuYldmZ2lCTWJ0c3pX?=
 =?utf-8?B?NWRtTVRPNlljUDVtOGE4NmRMY3prbVUyNzdYYnYyZWRWTkV5QUYyakFNalNs?=
 =?utf-8?B?UjVQbzRPZElMWVFsb0JZSTcwc1hxeVViUm9WZFlHaW43ckdiUFZ1T3Q5V3hR?=
 =?utf-8?B?MVM3RlRaUWl1MnYrdjIyUmJ1WTIwRTV4VGJjV3lOU0YvWGhESWpMVUtzVWJM?=
 =?utf-8?B?ZFA1L0l4bmZEWGpiVG0zZi8weDdkRUhqUmFBdnlDanhqOW5qTGNhMVNvU0tl?=
 =?utf-8?B?cmVwaXZ6eXFkZXNPTVpiY3ZtdXN2ZmpaOGJuWlU2cUxDWjF2Vis4aGxiMzl6?=
 =?utf-8?B?cGlEcHAzV3A0ZHMwY0VENFA2L0dlbDNXZ2VZQ1dOZ1d5cXZhLzJSMmE2UG9x?=
 =?utf-8?B?UnZkdXBzamhkbVVtUnFSYTU3dVJEMEpEaXFYbDR0OXRhZHFkV2hpdHJKQnpa?=
 =?utf-8?B?SWxKUWFkTHF6NGVkdjRpVHlCaTc3ZVVGdEIza2dwWVBPNFZSOExiY2ZrRWFN?=
 =?utf-8?B?ZlF6ZGMrSEsybWtpYWVxUS9mTFdVWCtSbEF3aWJHMUhMMXBEckp1dW8rQ3Uz?=
 =?utf-8?B?N0sxR1hCdExmY2ZCc3NVcXVOMXcrR3h6enltN2pGVDlRLzRIN201bGd5UnEr?=
 =?utf-8?B?dC94aU9ab1NRaWNwU3hGZEtlUDQrRVN3b3JXQ0lQR214VXdRQjVVSlhHWEpv?=
 =?utf-8?B?YTZ1bmI1RzRldUVmblkwcjRwOXNkK1NHTDl1R28wODdGR3REUWc2MzNXTnFQ?=
 =?utf-8?B?ZXRWNUVuVTN2aGhTaU5yV1NTenBobUFCUWZqdzBvc2ZITStLcGs5LzhKM2Uy?=
 =?utf-8?B?R21rbCtidnNuMC9nU3ZuMmp1ZThJbnk1NmZkcGZHYW5LcnNtek95NGR4RnRZ?=
 =?utf-8?B?VjZ5T3hFN0JFc3lxbVdaR2JzdGVyZ1NPeDVFKzU5bnN5MUhyTEd4SHVRYW9I?=
 =?utf-8?B?RXJDckhmWGlDVWVrOTlZaHI2STlxUWtEeTBwYXdXOFc4WWQ0eGgwS3B2bTQ5?=
 =?utf-8?B?UytUdzhwT0hoc1FGZmR6aTdGRmpVeDdOU2QwWkc4MWY3enh0ZGRoNm4vbjc5?=
 =?utf-8?B?d3drS1p0TjJCUm1Rc1AzVmlEcjNkV1B4c0haNkhkaUNvcm9iUVRFMzUyWkxZ?=
 =?utf-8?B?d2h6NENxa01rV0Z3cTJ0VWFYQk5wQlhBNGlJQm5aNzhkN0NEcXBxdjc5MjlJ?=
 =?utf-8?B?SGFpWTR0QlhNczlMdXV0OFhFaUFjc0c3UFgxTEtKek4xNTV1NVBUMmQxNmpa?=
 =?utf-8?B?Uk9WbXpNNmRCVGhpTWNGdUlKblhSRkI5VlU1alV4cU5FVTNodTJ6UmVPcGt3?=
 =?utf-8?B?cFNNZk04M3NUWVRDSzBtaGZaakQwdGlIVGtjTmZXeHEya1NWZzFhcTZrOGNX?=
 =?utf-8?B?Q1NFR0M2dmpQMUJ3VGROWFNvTTZjUjFGanpxVXBYOGdqWjhvVDlJbk1CYXAw?=
 =?utf-8?B?WGFsdlVKR0NRdjJCdGt4TUxacHgvTHF3QzRZcEdoZlM5WGZ2TmZqZGxrZjAw?=
 =?utf-8?B?OXZWNm53Y0d4NlcycEUrSDBsOWxRS0wwNThOV0ErUUZIS0h2eWJGVmFINU0z?=
 =?utf-8?B?Y01HWVRKL2pFTDh6V290WFFhYzhLS0loYzBsNTRMOE9CdmlNMVI0Z2NzczFN?=
 =?utf-8?B?N0NWc0VPWFA2WGs1cTh6cFd3RlJFMFBwM3JUWUlGazVtQnNPbmZVWmxLOXpp?=
 =?utf-8?B?dk9HRlJtaGtLa0srTWZ5V1FBR21JYmFPZ1hhYVVzZEQxVkVPR2RweUF2clN0?=
 =?utf-8?B?YXBGcHNhRXplYTR0NmlTenMzejUwQTBiRHpCRnBYaGFLMUg4Yk9laGtXRmFG?=
 =?utf-8?B?VUhCQ3RDdXpxRXBHeUFlcGV3blFFQ0VrZHNQcC9aVHE1SVF2RDQyU2xsN3k1?=
 =?utf-8?B?RVBuNks5Tk4zcjYvQ21ZcVFyV0s3MWRmQVN1WE9VZ3gyTnBWQzFCdml5OVV3?=
 =?utf-8?B?R3dDaEdtUDBuVXVxc3k1RSs2VUNTeXhqVmtXNXRUTk9RMnhpMkpCSjlpSjg0?=
 =?utf-8?B?L0twSmhxL1V5NmhvTXFwZWh1UFFZdFVGWTF4VHZIVW5pdWlxaUpkeGVnQ2hL?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z6gYCvdfeXFVOA9Jadq0012cg7AWoCJRUj/Rx4r4juXAMXWIIALv77IgkF6PkLzGpWUyrYvy4rAkd0BwaiqI65woX8/vTlf6d8+F1hsuhEA9MdbGurwZxutN7txsSAROz+Gla5wh3qMbt0N8A3R7rYiRdaffRPLZKykT0Y9Teop1GzZ27jjcBOLOQ7e9AJUBxtBh6IjjCIfC4yXS9V3b4fDbO7bTjF4wJX2ZoI4ChBr2+b2v6DMHca87va3oE2PDTzz4ivUC2MPfYpGTz8MkEYZ3RDDWzG053qEJETxeV0U0KgTYBet8z6Hjs+GeFF1tvPBg7gArkBkQ0MY/sQ6ZgAL+ai5yHpivbRSf6S+10AcsE1K1gmFCiDxhsxsR1w0C1Xm+Kvfene2mF3zTWbi28rZ/xUgZJEaMkoK5D/0x4UCHo+TSG2JM5dhXyiq5y3Myq5HRnuwZXw70QN/oHt7VWyRi4bV12H4w+c7e+5JHUhrjVbZzgAnRGn+Bjg++s/aZGsdeDUIcCjlJEkCnLCSgHEtMtCTEVFgYaF+7m0O29+BqVGjLei92sA1YmqMjbOtyLtx7J+ECNVITMfiNBQyXNDpmd0rhgHqgwfGHMw5Ag+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8949b70-160d-4a63-e836-08dd3fb3a7eb
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 15:51:40.6974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwa3sjxF1ys7q5UYhNOUZYDeu8ZLjSgKJ4z6Oj2QFzkdZwZo/J1b7NrYDf/zEx/9OAZ0ucNHxU9BnFEfNVmtBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501280117
X-Proofpoint-ORIG-GUID: dS_hwhzXNYRxLqUg6r9zbx-agxrMu9aT
X-Proofpoint-GUID: dS_hwhzXNYRxLqUg6r9zbx-agxrMu9aT

On 1/28/25 10:03 AM, ciprietti@google.com wrote:
> From: yangerkun <yangerkun@huawei.com>
> 
> [ Upstream commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a ]
> 
> After we switch tmpfs dir operations from simple_dir_operations to
> simple_offset_dir_operations, every rename happened will fill new dentry
> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> key starting with octx->newx_offset, and then set newx_offset equals to
> free key + 1. This will lead to infinite readdir combine with rename
> happened at the same time, which fail generic/736 in xfstests(detail show
> as below).
> 
> 1. create 5000 files(1 2 3...) under one dir
> 2. call readdir(man 3 readdir) once, and get one entry
> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
> 4. loop 2~3, until readdir return nothing or we loop too many
>     times(tmpfs break test with the second condition)
> 
> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
> directory reads") to fix it, record the last_index when we open dir, and
> do not emit the entry which index >= last_index. The file->private_data
> now used in offset dir can use directly to do this, and we also update
> the last_index when we llseek the dir file.
> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Link: https://lore.kernel.org/r/20240731043835.1828697-1-yangerkun@huawei.com
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> [brauner: only update last_index after seek when offset is zero like Jan suggested]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrea Ciprietti <ciprietti@google.com>
> ---
>   fs/libfs.c | 39 ++++++++++++++++++++++++++++-----------
>   1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index dc0f7519045f..916c39e758b1 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -371,6 +371,15 @@ void simple_offset_destroy(struct offset_ctx *octx)
>   	xa_destroy(&octx->xa);
>   }
>   
> +static int offset_dir_open(struct inode *inode, struct file *file)
> +{
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +	unsigned long next_offset = (unsigned long)ctx->next_offset;
> +
> +	file->private_data = (void *)next_offset;
> +	return 0;
> +}
> +
>   /**
>    * offset_dir_llseek - Advance the read position of a directory descriptor
>    * @file: an open directory whose position is to be updated
> @@ -384,6 +393,9 @@ void simple_offset_destroy(struct offset_ctx *octx)
>    */
>   static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   {
> +	struct inode *inode = file->f_inode;
> +	struct offset_ctx *ctx = inode->i_op->get_offset_ctx(inode);
> +
>   	switch (whence) {
>   	case SEEK_CUR:
>   		offset += file->f_pos;
> @@ -397,7 +409,11 @@ static loff_t offset_dir_llseek(struct file *file, loff_t offset, int whence)
>   	}
>   
>   	/* In this case, ->private_data is protected by f_pos_lock */
> -	file->private_data = NULL;
> +	if (!offset) {
> +		unsigned long next_offset = (unsigned long)ctx->next_offset;
> +
> +		file->private_data = (void *)next_offset;
> +	}
>   	return vfs_setpos(file, offset, U32_MAX);
>   }
>   
> @@ -427,7 +443,7 @@ static bool offset_dir_emit(struct dir_context *ctx, struct dentry *dentry)
>   			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
>   }
>   
> -static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
> +static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx, long last_index)
>   {
>   	struct offset_ctx *so_ctx = inode->i_op->get_offset_ctx(inode);
>   	XA_STATE(xas, &so_ctx->xa, ctx->pos);
> @@ -436,17 +452,21 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   	while (true) {
>   		dentry = offset_find_next(&xas);
>   		if (!dentry)
> -			return ERR_PTR(-ENOENT);
> +			return;
> +
> +		if (dentry2offset(dentry) >= last_index) {
> +			dput(dentry);
> +			return;
> +		}
>   
>   		if (!offset_dir_emit(ctx, dentry)) {
>   			dput(dentry);
> -			break;
> +			return;
>   		}
>   
>   		dput(dentry);
>   		ctx->pos = xas.xa_index + 1;
>   	}
> -	return NULL;
>   }
>   
>   /**
> @@ -473,22 +493,19 @@ static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
>   static int offset_readdir(struct file *file, struct dir_context *ctx)
>   {
>   	struct dentry *dir = file->f_path.dentry;
> +	long last_index = (long)file->private_data;
>   
>   	lockdep_assert_held(&d_inode(dir)->i_rwsem);
>   
>   	if (!dir_emit_dots(file, ctx))
>   		return 0;
>   
> -	/* In this case, ->private_data is protected by f_pos_lock */
> -	if (ctx->pos == 2)
> -		file->private_data = NULL;
> -	else if (file->private_data == ERR_PTR(-ENOENT))
> -		return 0;
> -	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
> +	offset_iterate_dir(d_inode(dir), ctx, last_index);
>   	return 0;
>   }
>   
>   const struct file_operations simple_offset_dir_operations = {
> +	.open		= offset_dir_open,
>   	.llseek		= offset_dir_llseek,
>   	.iterate_shared	= offset_readdir,
>   	.read		= generic_read_dir,

That commit has some other problems, so we're currently considering this
series instead:

https://lore.kernel.org/linux-fsdevel/20250124191946.22308-1-cel@kernel.org/


-- 
Chuck Lever

