Return-Path: <stable+bounces-112138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D4DA27021
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 12:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59E11885910
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7AB2063F1;
	Tue,  4 Feb 2025 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JM1ETMb6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pSaOhK1r"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91A78F33;
	Tue,  4 Feb 2025 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668034; cv=fail; b=cCPJcl+uIZj8PasGQdRldomaxuEBQ9MRiO8MKQCwRtizemlWV5T7NLkgdK8FVJYVesO0qiANbwxJ1RtPYYHoGlzzPDDKIdAmM4lg4qsZSOho8fQfO4kdTFN4kE52YNzBq4CGw/onqYaLymXoG593Pb3wjGJvTbX7hhgjALIpWLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668034; c=relaxed/simple;
	bh=xIEssw1n8ys367f7TppBZsLlLu2Vh6iTj5M5weTZc6U=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BaLSH0i26BJwvnwsZGow+MLWDZZCPGUpohJxPPubYoThdqWnUXIxS+MV5rjA+dNutYAcZrSHS5Bs78O2tiRBA7DEdOMW6ZLzE1a88SjBR/DEAhxNSko1/GIkSVxReeKKfwWt3y5L58LeV88O0zlZ+6BTd6ckQr3h+aBFpO4zfzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JM1ETMb6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pSaOhK1r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514AtniS002365;
	Tue, 4 Feb 2025 11:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xIEssw1n8ys367f7TppBZsLlLu2Vh6iTj5M5weTZc6U=; b=
	JM1ETMb6XKSnaE3OA9WgmjtyWAR5n1698DOWoq2K012TAo8BQhmy6WMw7ZhxdY6Q
	DiVv2hP5zjITsf3YoruWL4CJQpjCJKt2baNZofIdqRF+K3iQeSsJFttnAZBdvuZU
	pttl8K74xaVnWQ5o6GAxljnTBWKgaht85nbydtrYUeR2TCbUQlG2aJvKV8jruAU1
	64RsdzsTo1Ao9jgzRRaLOj0I69OUFoc13RdYeN6bwS1+l5uJw1k+bWm3HdGjC7UA
	jX92tx6NNR+EUE91MJ2E5HyvrX+RrwzNPCmHXTGMl4/dF+GtfvyyhbNkFiJxzyxv
	dzc0wxHcgqqC0zusF/JDYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy84hfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 11:20:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514B8AEq037820;
	Tue, 4 Feb 2025 11:20:22 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8ggts92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 11:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o920HixLcA5fpnWLAzv33k1Qk2s2US9s2ggXhIY6+xqGUqysuMyD5hhli83qxAmwZlUH4XiPmlkh1yzn2cUEY8CuogetXi0KfT1Z0MbBAsuvnFbf1bruH9rCjCDhVTkjh71SapaUCl0d+ZnJwnQ9ptmi33GYO4bzGa24J3k6AM72/fpAp1I3WzPJr06V3+dLP+U8/a6iDMKH4dmDIvyVQEUInSkPU920+WMTMyIEJF3c4jFumOu5u2rGL6p/9eQvA5yr1bTT7UWvTSfs7Pg4VF4uDH9c7RhN95KfHJDuibXv/0aurvlRn37lcVEiW+mmkeSQmgLoagd9XMjEpyNcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIEssw1n8ys367f7TppBZsLlLu2Vh6iTj5M5weTZc6U=;
 b=QgLCJBH8493uzGh1ae6mVIdhzj/iDEbSCHz/CKqnAi4tlnJtApYrXPcy0UiAjg371svP22bKR15oUMeq8li/AL00FFn/mEujpZNfZqb1eac0gOBhcWGu/ctkp6RmXtyXFvQieTl5Aw22IsLHEVM7XAtqyjB/2XSdsphLRsxqgdUP/vVrm+aehvMfv/gx08DVQ/kZl3JwkfTe4EkStRnpt5NK8xuQCPwMasQYY3Cqc/7p7zp3oHHob0kcBg4PqOCKMyDgDLmp1JK61h4BYSizhBSpfRrHaflVTOb+l6JQiPYS4X7Wg+zEryiAiSS8WqV9qhhqW+J3EBmPRRtZaDWB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIEssw1n8ys367f7TppBZsLlLu2Vh6iTj5M5weTZc6U=;
 b=pSaOhK1rMTx1a5k8op+6CICfd9eW6QXD28QpMdx9+YnJASbxnqyg6u55JPha8h+3RaYPli370KrXLUtS5LqMWNCDt1ur5TazLaV6xHV+lhotoCMyz3gDLA95Vk9OhAKRjHJPDQ9Lgy2qQkX5qv3n/ngs2UuiVby/kxT5LaRMTRE=
Received: from PH7PR10MB6505.namprd10.prod.outlook.com (2603:10b6:510:200::11)
 by IA0PR10MB6891.namprd10.prod.outlook.com (2603:10b6:208:431::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 11:20:19 +0000
Received: from PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54]) by PH7PR10MB6505.namprd10.prod.outlook.com
 ([fe80::83d9:1bf1:52cf:df54%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 11:20:19 +0000
Message-ID: <7cc90456-3aeb-4d94-b25a-1f4e54b71dde@oracle.com>
Date: Tue, 4 Feb 2025 16:50:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: v5.4.289 failed to boot with error megasas_build_io_fusion 3219
 sge_count (-12) is out of range
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc: Konrad Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        stable@vger.kernel.org
References: <7dc143fa-4a48-440b-b624-ac57a361ac74@oracle.com>
 <9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com>
 <2025012919-series-chaps-856e@gregkh>
 <8eb33b38-23e1-4e43-8952-3f2b05660236@oracle.com>
 <2025012936-finalize-ducktail-c524@gregkh>
 <1f017284-1a29-49d8-b0d9-92409561990e@oracle.com>
 <2025012956-jiffy-condone-3137@gregkh>
 <1f225b8d-d958-4304-829e-8798884d9b6b@oracle.com>
 <83bd90c7-8879-4462-9548-bb5b69cac39e@suse.com>
 <b4ab0246-3846-41d1-8e84-64bd7fefc089@oracle.com>
 <de6912ad-3dba-4d66-8ca2-71a0aa09172c@suse.com>
 <686986a0-c981-4aa3-ae88-92a34368129e@oracle.com>
 <5a7d969b-b2ab-4fac-b95e-4a536e2c8d5c@suse.com>
 <17ed9a71-227c-4e7f-8fcf-402dd00f3837@oracle.com>
Content-Language: en-US
In-Reply-To: <17ed9a71-227c-4e7f-8fcf-402dd00f3837@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PH7PR10MB6505.namprd10.prod.outlook.com
 (2603:10b6:510:200::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6505:EE_|IA0PR10MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e5a420-44c3-4fe3-22a2-08dd450de841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjB5WVZzV0ZCeTdCbGd3YVRsOENWUkVtSGg4L2JnWkxMZzM5aERyU1pFMWly?=
 =?utf-8?B?ZmM1b2hIK0ZLNVgycU5HY1FLS1dHS0twOXJ2SHU3eitXSHJoOVRGYUhCeWky?=
 =?utf-8?B?SjlQblhmSUVmL3VRV3VtVVdsUlRGcHIzQVBDTnI4Tks5eUtaR2xCb3c1aUxy?=
 =?utf-8?B?RWRHb0pyNmRlaXBhNTdWLzVPRStRNWRERENOOWlaTXFPaHZWeEl3UXNGRVVw?=
 =?utf-8?B?ZWU4dmd6WXFpb3hIOU1PTzYwZzFyaWNTNUlNdUZCNXdPcDFPSGJHVlNqNm9I?=
 =?utf-8?B?ejl3RkdiQ2pXM3lxTktDdE83L3VNOUJUM1lpcFdpQnNMR2tnTkxCTXVSYU9O?=
 =?utf-8?B?bk5zY296ZWtrdzZqcG1kTWs2TitqN04yREptdnZWcVhXUklYc0JSejF6V3Ja?=
 =?utf-8?B?UFo4cXVWb0hEeCs3V1pTLzJsbUZUQjZDQ213VVpoeURrcmF3MU8yZUt5VFZu?=
 =?utf-8?B?K210eWk0MmdzeVRHVnJmamR0MFBSUHYyWElIcFV2Rkw3byt5YWFzd2VPaDVS?=
 =?utf-8?B?QnZiRnJGaWdZNkRjdkFEVEFhQUQ0SUVDNlhuazE1elhBY01xazJWeG53WDlq?=
 =?utf-8?B?Y2NocWowd1dYejNWVnFlN0FiUUYyazljQUFRL0hhWHY2Z0ZFYUJrTCtLUjVG?=
 =?utf-8?B?RVVDNXl0YXZrd21jWTcxdTcrUDgwVlFXOTdDSkxsV0JoVE1uRjZRVmM0N1Ax?=
 =?utf-8?B?REZHZ2VpNk1iVXN2RTB3WVF3Tkw3cXRESFY0d1ZOdmhIMkVpS01VRTE2ZThr?=
 =?utf-8?B?VjJFeXp2RlNocmtxRldwOUVNNmNCd3ZwRldpS3d3OXFYck5IMUNWMlVHM2hP?=
 =?utf-8?B?WkkyM2JVS1o0VXhUMndGSndudzFrTEtTelFmTGtZcVl0MUVmdjRjT25FTGgr?=
 =?utf-8?B?TWJKeGhDWEU2KzhPbjR6RC9FUVhyNzdNSGQvMm5qZHF3dnI5TlIvR1ZCS0Z0?=
 =?utf-8?B?YzJFNkMzSHhjL3BwOHE5aS8rNTZJWDkyWGhuYW5adGU0YnNoTDk4SjVpUGF2?=
 =?utf-8?B?VzdWcGNudmhSUGtjU3N3UjcydmVuTlhVS1VpMCt2MDAzTlpNV1VOd3I0RUdi?=
 =?utf-8?B?TWFrWWFkc3ZYYmhSMlBSY2Z0QTdBVm9uTjdiSERVRnFuQ1FWb3dCVXN0aFNu?=
 =?utf-8?B?VmxEd2tJZTNTRUpkVkd1bGlMN3hWZU5kL29HWGRoZlUzYW9yTkFaODljM1Rn?=
 =?utf-8?B?eDEwMS9OVTZ6Z05XNVZOSXFxZmxDS3hmeXhUVUhrdUJLVGtjWXljblJXNWtx?=
 =?utf-8?B?U0UwRUs4OEpYT3NFcWQyZkJSeS92Z0tNNTJPeTE0L1ZoUW5wOEVWTFVDMnRS?=
 =?utf-8?B?bVRvZEJZOVhSRHJEK3ZTWlRleHhxenpMdWVZY2YzL1BmYUhURVg2aXROY0lr?=
 =?utf-8?B?Ri9XdTdhQ0wveWg2OWhXR0JoMEdVLzByVTFVZXE2aGo5ZmJmTmdxQXVNT3BW?=
 =?utf-8?B?TUUzckN5QnFVUFByamtKZkhGc2gxM1V5N0tndXhHTTRUS25yYXBHTUkxTG5v?=
 =?utf-8?B?blhLdFlQTWNMdEtZM2Fzc2hMcnM3dE5VV3FFaFRFb3pWd1dDVEFrYTVQbFBO?=
 =?utf-8?B?UzI3Y3VPZGtmbWV2VlZFRzNpL1FOSUdONmRZTExxTVd5c0g0aUR0VllnZktq?=
 =?utf-8?B?R084bnZOOUJuVm15L0xCWVR6Q05Sb2ZhV2ZZS0gvVGNjeUp0aU5tdEdleGp1?=
 =?utf-8?B?K3Z5VktobWxGN0hjVmtxN2RuR0xNQjViNjBGY3lLWkNjY3RYM1haTjFaZ3Zp?=
 =?utf-8?B?QVlFenhwZi9lQzltNSsveTNSd2ZFdytDR09CcmQzYzFlTDNYQzNaMFc2cjdF?=
 =?utf-8?B?U3pYaDRtZ0d1b2cyL2FYL3NiRklFb2E5aUh2Q21uV2U1WEF4MVpnN2ZGZHNE?=
 =?utf-8?Q?mWDsGYogiTZKs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUx6OWxQd09PVFZNUHlvNEpXU0VEa0pGaHNMejhvOG5ySWFCMFN2SjdGNGds?=
 =?utf-8?B?TnlpdVgwaDh0OS82QVFWcmw3MFRDSEJuSEZMbkV4U3ZESTJKTU1rWXRFc3JD?=
 =?utf-8?B?WFo0RW93amJaVkxTdE00aXJLQXppK0NWSDRzK0dkNnB2cm0xWXd5bWlHV0pk?=
 =?utf-8?B?SU5DUitvb2JiZ213UW1Bc2R3WG1RZVRkM1o0SWY1Y21aV3B2NmpWMTRtMXBD?=
 =?utf-8?B?MjhudThHTVI1ZmFlRk13WkNSeDI3bXg4N3Z0VFVIdXJTeW9wV3ZuUWdhWWdq?=
 =?utf-8?B?ZnVqVlc3K0d6b2Q3SnpyTXo5aWlFOHU1akVXOThNNTA3RmhDenNnVGwwNElK?=
 =?utf-8?B?RG5hbnh2NDBNbFR5Z2kzUGFJdng2MTRlOSt5REl1V09NdzdBWE90SzdlZmVt?=
 =?utf-8?B?a1RPVGNDTXptelVCa1pVUExUdVU5OTZ3UVh5VzRQS3JSbUI1NDlkV25XaDBk?=
 =?utf-8?B?YURXV0Y5QjJCRXRzdFhaMnlBWGFrWFN6S3pVbi90VlZ3N09rd3NGeWNEL3Nq?=
 =?utf-8?B?cDRZbXVDYkwxNWNjQVVWK3hEaGt5dHBUMU5TaGhJN2FsNHIweDlSMVluZG84?=
 =?utf-8?B?Y2hRRkJDanZmT1ZZdXQ0M1ZSeWEyODdzMFdhMTVQa2xINWtNSldUZVNqd1ZY?=
 =?utf-8?B?YW84b2l3RFV6N3F4U1YzWlE2R1pTdW1BOEdzTldRSXZIdHhJUkR1ZW8yejlT?=
 =?utf-8?B?V3JuUHo2bEk3bVRBU2dxMFpyRTUyY1RNT3FzRC9JWll5UFF2eFRINm5tQTJo?=
 =?utf-8?B?ZDBJNG5taU1YNG9tazZ0WXp4ckl5bGdQN3RSOE1jazhPaWQ5dzI5ZHlCWHB6?=
 =?utf-8?B?N041SldEOHQzRUV6UTl1bm8xR1Z1M2NiT3JHbVFwdXNCbWFMNVJTV1Vnc1lQ?=
 =?utf-8?B?M053YWhMWWtYbTNlZXBoYmd4b3JFdG5DYlhOS0dyc0JLd1BVcHlVRXdUZFJx?=
 =?utf-8?B?UE82YmFNdnIxbEluc1FGT3FhQWozNURjbCtIckJpbTRHWUtnTGJ3NHBXazNV?=
 =?utf-8?B?T0YyK0Rqd1I3S0Z3Sjczdjl5V0ZaYkdTV1RDQXRRbXVhTGhnK3BlbWdoQ0xV?=
 =?utf-8?B?dmtmcWFwZXloODhxbE5SOTJUVUFtTHVjeUNqcFRhbzdJU0g1S1V4MnpLeEtQ?=
 =?utf-8?B?QmdiTnluc1Zia2FQcStjQXQ0SXZmL1JFSGRaYmQrM1FQdGlwd1FaOWdML2dz?=
 =?utf-8?B?ZHppZndBdGdpOTZWdHU0cEhzZ3NlbmltdEkzUFV4N3ZxaUh0a1p6MFBEQmtP?=
 =?utf-8?B?Nmo4ZElIQzFNcDF2NzZYREFWZFJYZFlYaXVHVUhCeU9ORHoveUtMMXRoRXBy?=
 =?utf-8?B?NU5YSzRScSt4NEF5NXpKSVNpRlZxT3JMK2lCZmh6VGxSR29tZDJSUUV1Q0R6?=
 =?utf-8?B?d21OK2xWQStSSUxZU1hHd0FvYWYyYjRPWm51eGRpMXJHVkl3OUtmK3B3dFN5?=
 =?utf-8?B?MnpuSlRhc210bUpDRU1ZQzAwem1IOTB2TlFuVFBmczRxSEVNS2VhR0FGTzFJ?=
 =?utf-8?B?di9CUzNaOXNoOC9BeEEzbTZkQUZNU2RzaTBsRWJwbGZDMm9pUFNnZkFTTFhB?=
 =?utf-8?B?Zk5VSTF2YVkwNU4xRHNwdTYrRWhEYndZSk1obTRSNHhHQ3NKcHNnK2dnT2VX?=
 =?utf-8?B?R1ZNZkF1NzErRHFIT0EzMXZCNVI3M1U1VVZSeC9Ec0FKdGN3VFJkUytQTldE?=
 =?utf-8?B?enRlcy81RFY3TTZJVDNMeGJiWTFvaGxneHY1NlR2UHIrMFVMWWc2VGxEY2Fo?=
 =?utf-8?B?QTJwMDJ4UVhubVQ2dFVCMVNkNFVTM29Wc1RtSXA4MjBTVXVscHRDSE5iTmo5?=
 =?utf-8?B?bmRIRkZzcm9pWG15UWYwbnVadmU0MW9KcnVwMjFwY0NJSk53Q2kzUThETk93?=
 =?utf-8?B?RG9MWFVyMmdHSjR6L3hvbHpLVzJzR0FWZGFNdTEwb0hTV1RCRU5tcGo3ZFg3?=
 =?utf-8?B?MWEzaXpSNmN6SndlWndhT3BtRGZraVNtUjVpZGoxeGU1ZSszVXRKT2p6NTFu?=
 =?utf-8?B?TzVzK1dDaFcwU1RuWmd0M3lpbHBwRXlUME5ZZ1B4L3JPSy9IVnNPK2hRTWpv?=
 =?utf-8?B?Y3Q5RTdiSVEyUGZjQkFYRTZBbFNwNDYrMktQZGUrbHNKRW00d2luRGR1M3pv?=
 =?utf-8?B?T0VWWlZKV3BaaXBZK3FCZktueFFMeXB0ZklvSFd1a2VLVnVYcTU4TGVhVWVE?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JBLngPtOsty7Ewcb0pumokFQKg/1Knep068cWoZAPEVe2WCcbF9qH6jy5WnklQIm7qVJmnMvSfw4jf4sKF8ZIHP45wYTND6ZHSK7mqazjY15tUx3gSyENyhEd7XKmPM6QgdrM+9YzmkqRnR+V79yhpzr1P9scYAM3MB0Y4nJCe5VZKqR0xASaj7BfWdEEFby5XA2n5xttG3nFTzfJRJg459JAIwjoHloKxKiU5B69PuX17Jy+V/sj7Mekp4Ua3xuIpkg03eG202Fevk8wr8jsjVHaJutAXFOWTN7guiR29nBhWzf2Is8EujbCJPXccaiWy0cWEdcI/NF5lq2iJ2Z5qm9Ilp6rxLi3npohvX6v9xKNdHILlIV/jYgalWKZTcknSEy3yUYUNWMzaYwWFywF9nU39xSE8mRDLLsgm1G0Nf0cRFoVhupp78EQDTj+D0lNQt1wCcpl4qLivKlX63UKbgLfxtt8tu1IaHN1fE1JQ3KvR0Z1WuCj4i/jBB9Sput0R1+mATUde4koPXBEhcdf3YGwDRa/ZTgZucCG3o4BZw6ErJR70qqwaDewKw/BItSWqqU7n7+IXkl/BGlLV4YCR+Izx1KdzvvZ5roS4fcHBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e5a420-44c3-4fe3-22a2-08dd450de841
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:20:19.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuXZsLpuIxwRbZVbx9ZxDUkBusWFdk5JWi+W/OIN5a3lbTPiZADMMFqEN1sRxbc8rEBNYBil7J1DlSxkI9EHUA3LbVJyY8OVLpiiiYC7yK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040090
X-Proofpoint-GUID: HPc8LnpciuQUL2e8rbOchsVQDfZILn23
X-Proofpoint-ORIG-GUID: HPc8LnpciuQUL2e8rbOchsVQDfZILn23

Hi there,

On 31/01/25 5:35 PM, Harshvardhan Jha wrote:
> On 30/01/25 6:05 PM, Jürgen Groß wrote:
>> On 29.01.25 19:46, Harshvardhan Jha wrote:
>>> On 30/01/25 12:13 AM, Jürgen Groß wrote:
>>>> On 29.01.25 19:35, Harshvardhan Jha wrote:
>>>>> On 29/01/25 4:52 PM, Juergen Gross wrote:
>>>>>> On 29.01.25 10:15, Harshvardhan Jha wrote:
>>>>>>> On 29/01/25 2:34 PM, Greg KH wrote:
>>>>>>>> On Wed, Jan 29, 2025 at 02:29:48PM +0530, Harshvardhan Jha wrote:
>>>>>>>>> Hi Greg,
>>>>>>>>>
>>>>>>>>> On 29/01/25 2:18 PM, Greg KH wrote:
>>>>>>>>>> On Wed, Jan 29, 2025 at 02:13:34PM +0530, Harshvardhan Jha wrote:
>>>>>>>>>>> Hi there,
>>>>>>>>>>>
>>>>>>>>>>> On 29/01/25 2:05 PM, Greg KH wrote:
>>>>>>>>>>>> On Wed, Jan 29, 2025 at 02:03:51PM +0530, Harshvardhan Jha
>>>>>>>>>>>> wrote:
>>>>>>>>>>>>> Hi All,
>>>>>>>>>>>>>
>>>>>>>>>>>>> +stable
>>>>>>>>>>>>>
>>>>>>>>>>>>> There seems to be some formatting issues in my log output. I
>>>>>>>>>>>>> have
>>>>>>>>>>>>> attached it as a file.
>>>>>>>>>>>> Confused, what are you wanting us to do here in the stable
>>>>>>>>>>>> tree?
>>>>>>>>>>>>
>>>>>>>>>>>> thanks,
>>>>>>>>>>>>
>>>>>>>>>>>> greg k-h
>>>>>>>>>>> Since, this is reproducible on 5.4.y I have added stable. The
>>>>>>>>>>> culprit
>>>>>>>>>>> commit which upon getting reverted fixes this issue is also
>>>>>>>>>>> present in
>>>>>>>>>>> 5.4.y stable.
>>>>>>>>>> What culprit commit?  I see no information here :(
>>>>>>>>>>
>>>>>>>>>> Remember, top-posting is evil...
>>>>>>>>> My apologies,
>>>>>>>>>
>>>>>>>>> The stable tag v5.4.289 seems to fail to boot with the following
>>>>>>>>> prompt in an infinite loop:
>>>>>>>>> [   24.427217] megaraid_sas 0000:65:00.0: megasas_build_io_fusion
>>>>>>>>> 3273 sge_count (-12) is out of range. Range is:  0-256
>>>>>>>>>
>>>>>>>>> Reverting the following patch seems to fix the issue:
>>>>>>>>>
>>>>>>>>> stable-5.4      : v5.4.285             - 5df29a445f3a
>>>>>>>>> xen/swiotlb: add
>>>>>>>>> alignment check for dma buffers
>>>>>>>>>
>>>>>>>>> I tried changing swiotlb grub command line arguments but that
>>>>>>>>> didn't
>>>>>>>>> seem to help much unfortunately and the error was seen again.
>>>>>>>>>
>>>>>>>> Ok, can you submit this revert with the information about why it
>>>>>>>> should
>>>>>>>> not be included in the 5.4.y tree and cc: everyone involved and
>>>>>>>> then we
>>>>>>>> will be glad to queue it up.
>>>>>>>>
>>>>>>>> thanks,
>>>>>>>>
>>>>>>>> greg k-h
>>>>>>> This might be reproducible on other stable trees and mainline as
>>>>>>> well so
>>>>>>> we will get it fixed there and I will submit the necessary fix to
>>>>>>> stable
>>>>>>> when everything is sorted out on mainline.
>>>>>> Right. Just reverting my patch will trade one error with another one
>>>>>> (the
>>>>>> one which triggered me to write the patch).
>>>>>>
>>>>>> There are two possible ways to fix the issue:
>>>>>>
>>>>>> - allow larger DMA buffers in xen/swiotlb (today 2MB are the max.
>>>>>> supported
>>>>>>     size, the megaraid_sas driver seems to effectively request 4MB)
>>>>> This seems relatively simpler to implement but I'm not sure whether
>>>>> it's
>>>>> the most optimal approach
>>>> Just making the static array larger used to hold the frame numbers for
>>>> the
>>>> buffer seems to be a waste of memory for most configurations.
>>> Yep definitely not required in most cases.
>>>> I'm thinking of an allocated array using the max needed size (replace a
>>>> former buffer with a larger one if needed).
>>> This seems like the right way to go.
>> Can you try the attached patch, please? I don't have a system at hand
>> showing the problem.
> I tried this and got this error in an infinite loop again:
> [   25.827922] megaraid_sas 0000:65:00.0: megasas_build_io_fusion 3273
> sge_count (-12) is out of range. Range is:  0-256
> [   25.828447] megaraid_sas 0000:65:00.0: Error building command


Would this require a change in the megasas driver also as simply
changing xen code isn't fixing the issue?

Harshvardhan


>>
>> Juergen

