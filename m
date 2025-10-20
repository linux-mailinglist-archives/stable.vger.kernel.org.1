Return-Path: <stable+bounces-188255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37265BF380E
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B0DD234F120
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 20:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BA62E2825;
	Mon, 20 Oct 2025 20:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LZClYa+O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g4BtuOA1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA62E0415
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 20:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993500; cv=fail; b=TUvmFU6OzlSBP+lMvG+DMW+3idSxJwmSTyKfo9L5qx2eABHah4VvEf2KLC7FLhMVa68iTMIRTqAlOuSpYJZEQlv+r8bbTjaGk26gzXYBjxEZgeBmX8PBmARGVq9Hb4BC6ggeBADLUFkk9WsVNvK/ULbTug74Xhu7ML2QlBMF9LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993500; c=relaxed/simple;
	bh=zIdKrdbpSQLjGXrSM5fOjSuxDvyRsBzELpc3J7m6/Ss=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ly0d8bfKQd5+8HcNzriUBWHpqgyLqYmsvlDHAQJ0IWPioI6ojIfYmbaGw5xILpLvyxRIKizFRsNaf9SHvn2aAeU6rRR3zbtjvhPuzVbSKpOgWUUxYAThnC4+WzVzxlo7TTKucIQqYVEdtr2gQ8l+0x/ItX2LCNbonY10XluyvF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LZClYa+O; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g4BtuOA1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KJulVc014687;
	Mon, 20 Oct 2025 20:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=q8ZBjDWONLuZ0wGHlIxjnjTji2yqYX2Y3KEu6O3fH4M=; b=
	LZClYa+Oo4oMa17O6iVxUdLBCLGm1YgR0xuxY5/APn18vzM32WHtDzL4nXjsV8Yk
	UsyJzoVS29FHj7TcSB6Fx2z+Y0auDNZDjeYOaw/89NHPxtm4ngkVzONDTSRairxh
	/Utp8tS5cjxuABdkNhxgphwQTihEitG29QvXEdlZfY7X9kTcMgBQrNtb5TRDBeHS
	9dAQKa24RuOKdysxevouFB0lbuV9rmj/G5p3WQG5LfhDl0jpimK+HRw8dq1DPg6f
	LR5Qtt4MtowO0M5xWW/DVU6xSOrFA1iUmAv334yKoxZMObYaufumhIeVzO8fz6yP
	EHv6tcOxruUAsKYRHuVc1w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2vvu2qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 20:51:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KKea16026301;
	Mon, 20 Oct 2025 20:51:34 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bb4v26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 20:51:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPXoVsL6rnjC5ekW9Msd269ek1s19z6PzrjZTYJb5kLDKDcXkhNjxvV1QLQ+l8IOM8lH1ulCNv3elBuen8x5rQTjOQnfMG3rkZBi4b6oZvOYGVK/CNZpDcp0xWKdVMsc7Xa06x61bB6Ktk+5aNF6AT7ImhF4SezjPiLc5g5MIUghZxZwTz9Cnp8QmPqBuXb2OvIIZvk7AF264u1neVzH7HTgDdkPSjB++Oc9p9stz/XDM1LPHbf2C0+7swNXr7TTsumow9ImmI/v3vvIBhM9mEo0Uys6xyxUTUb7AkibglU3hirOtzBNlxpb+OqB9Z64tEn+exDlJZhehz2l5aqS5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8ZBjDWONLuZ0wGHlIxjnjTji2yqYX2Y3KEu6O3fH4M=;
 b=luEQ5kGrxX8Hls+Wb/OvaObloM5RzS16nRkIXMxtQwTyDxQy77lnfk0g58XND/OWUxEQkEr/7AN9LqeAmVoE0vIIet4wstVJXQqklh9d/tLHVDTCK5mQihktpThL3GVsWSUv45zYQARKzqHNGCXpVnCtCVOa2mZ+TUSRu5pt5CsSMSuBmSV8ooSOKuPsJMToFyb/nsNzchi6XdFxxJ7AobJqaDNrhWXPSbiSAjn37IktwYzw/2Yw1z/xa6KVmD0nGN5wT7cWfQDZcG8mhBNfoYf53s3jMbjhk/ZJLYNNCoFYWEGe+Ow+OqnNLvQ6uMMKvAnMNlbX7LJDY+fNAjZofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8ZBjDWONLuZ0wGHlIxjnjTji2yqYX2Y3KEu6O3fH4M=;
 b=g4BtuOA1Cc0XosijpM3mvHjy9lVovfrsQ/8EImjOfkAsR0ABnkgwcWcW0qCAwxFror886E5pRdatZo5n1n1JOfAEGI2UG6J+328dClX91Es2kWETxPEiSXidb8XCkRhwLsiZUZorRcUXQFUHpjvKziAliIoqPXpqT3Uo6TfYreo=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 20:51:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Mon, 20 Oct 2025
 20:51:32 +0000
Message-ID: <31150028-374a-4bcf-8e3a-f67615c9b197@oracle.com>
Date: Mon, 20 Oct 2025 16:51:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()
To: Scott Mayhew <smayhew@redhat.com>, stable@vger.kernel.org
References: <2025101611-revisit-ranging-52d6@gregkh>
 <20251020205004.1034718-1-smayhew@redhat.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251020205004.1034718-1-smayhew@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:610:32::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: a4ecf628-15a3-4a96-eea4-08de101a7352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2d4QkM5VGdCcmpla1RUV3Zvdms1U3FHZnhBK1BSVDkwc0lrblBYMVJmRFk1?=
 =?utf-8?B?Sm8rSFFXRmkyTGMrNzd2ak1pTGdKYzNxWlVoQkprMHBwNnEyZ0xpT0p3YUpJ?=
 =?utf-8?B?S29MT3YyOUpHOEd5QlgwVTVGdTVpSzhkU2hFS1A2aVQ4ellTbWpSVUloZTdS?=
 =?utf-8?B?MURkRlpZTzBlTngrNjY3UnB0SXU0ejB1SjRYb3VGRkcyeWY0YlRsRHNPUW45?=
 =?utf-8?B?bFlNTW16ZU5NRkVEdUhmc0oyeTl2VlFpSWJBSFczUzJEQkV2cmovemlmQlJO?=
 =?utf-8?B?LzlhM0lCd1VmL1pST2R4LzRsMmFuZTlMS09sNGkrTDJHVzNUYlg3QVowSjRX?=
 =?utf-8?B?Vll1Zms2N3BHUTZZaEtuZkNYU0FwT1N5SXB2eWtRM2ZUS0ZxTE9LZkNUODRX?=
 =?utf-8?B?ajZzUkVXWTFBM2FYQ2cyZzJWbVdKMmZQc0VQVTBteitsSkhrN3N3NlBaUmJZ?=
 =?utf-8?B?djA0MDZHWllvcUJFNWxuMHhtcWc0SHJ0aUg4UHVmVEUwbFhIWElLR0hjbStB?=
 =?utf-8?B?V3BZVjRYK3IzY1pTWXp4bXFRcGNQbTF3N0RvQkV2SWZYejBTcWNEcGJHUXVO?=
 =?utf-8?B?RkhqRnZVRTBIRnBoK0xzQ0VmNVlFNUxqQVdmdW5tWnZoQ3lUQythT2o4b09C?=
 =?utf-8?B?ME1ITnZVWDFUTTBIZFRLZnFiaDVYSDB6RnljMnIzNEpmWFNBL0tleVh3bFVW?=
 =?utf-8?B?MXJvbWxKV0R2eExVRCtrU0JqY2QxcUJmQmRNeGYrd0FlZ1dlZTk0N0RxMVlw?=
 =?utf-8?B?Q3FSRmNqUnl3cFVOMzQ3VmlhQnVsbHh5OVRUSFBFMFU5Slk0MWdsOENDN0dR?=
 =?utf-8?B?aE9hN0ZOWXBBZXZDWHhFTXIwLzVjNUFMWjFWakhPWkhlMytYa2dxWE41YXFW?=
 =?utf-8?B?c3hrWVdFK3hHaTVwL240R0FNTEkvVGF0TGc5TU1BZXlRd0xPOXpFY1E3bUZD?=
 =?utf-8?B?bS9LTnFwQU5FRVNmOXNsLzhsblAzT2FVNDUrWmxidTV5RzlnQTEzcWhTZjFD?=
 =?utf-8?B?bGc5M2RDTW1hZGwrazl5MUxKZ3VsdnVNTWlLaVdDRmw3VDUxMStJNm5DV2c1?=
 =?utf-8?B?b05YM3k2T3hpUzYwOXB6bmVFOTlyZzhDU20vaVY0eUtWUGN6TTYvRjlqL05v?=
 =?utf-8?B?cGhhOTdYRURidTloRFB3ZHRlR1N0Um5oeXZsVm1uOUN5S01aNmhkcWtDN2tK?=
 =?utf-8?B?SjgvVi9BRlBDQ2FXRk1iSDJKYlpUa05EZWhBbmdtdlRrLzZGdzJuc0xhQWla?=
 =?utf-8?B?TmsrSW9BSW81YUVESENud0ZXY0lqYjJ6TllMMnM5ZTFFVDNYamszZ3Faajcz?=
 =?utf-8?B?SmJxOTVzNHMwYVpIeHk4YTZBOFpoSmZNMDEzZS9kUi9YRG9EMW92SjF3UU5s?=
 =?utf-8?B?eDR0UDJvM1hCbmwxYmtHelNsQ3VSUFpPcFpuVE91T0haWGhORkhlMVZqeUly?=
 =?utf-8?B?QzdmZkFNYW8wdDV2bDVUTDlwdEVCbnpaT1I1ZXd5SW5aWGZERy9xYXBTdFI4?=
 =?utf-8?B?aWFHVGtEc2VSS1BjWG1NeGFoQTZDV2k3SlVubGtMV0NCbS9aZEsvREt0Q055?=
 =?utf-8?B?QzV1Tm05SjVoYnpMMkppdisxaVNFNUxpS0c5c0Rqb2liUEtxUjl1QjFtb2Jl?=
 =?utf-8?B?WEdIRlVXaHZqclFnbm16VTZUTGx1S3Evb3BXYjU4T0tyR1V4djkwUWEybGtH?=
 =?utf-8?B?c1ZmdFJPMkE4OW5ZNzJtTk9Ed3FDekROam9BTGFMdlVGaERLM2FhN09JUE9P?=
 =?utf-8?B?RlBwbHdNcDM2a0NXYU8vNDlBRU8zMG5wcUh2K3BSbHVSUnBWUHVPbUloK0Nt?=
 =?utf-8?B?RXR3Y0NkbS80YjFsVEtpWDlQYy9DdGJBZzFRcWV4bFJmVjdqNW5JZ0QxMGhu?=
 =?utf-8?B?ODEvSTd3enp2WEthWVROUTFhQ0JoTDBaODNJTjRvbTRZQXRYdmRkVWVTMzB4?=
 =?utf-8?B?dXBRRVdDQzV0Wlg4cUhJQ0JqamVHZWFYRlRQNU83akN0TTZ0d01BNFZGdmpZ?=
 =?utf-8?B?NjVKeEN1dVVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjNnN0JsUEV6b2NtSzczc0NTdnhBU0pwRENoWWdhWWVxQ0NJUzBlVU1iMjl0?=
 =?utf-8?B?d3pISkpWblMrSVkrTnN3b0x6NjF5WURMSUw3TGhPb1JTazcrTU9yK05HN0xB?=
 =?utf-8?B?K3B4ZmhLQTVxVXRObC85aDRmMFQrRG54VlR2dlFFNlFoRzVZNjBPNVBqelhV?=
 =?utf-8?B?bUU5d29mOHJQeVY2N0FvLzZ5THpqOXBNMG5IQnFUTFVRZlJMMVhaamNEVkFz?=
 =?utf-8?B?ZHdISEM0NHZJejk2ZTZPKzlQVVhjbkU4TmdyV2NreXNHbDY1NHhiTHVGWk52?=
 =?utf-8?B?U1FWRVBCK0ZIUCtNd01kZi8xa1lqTHhBUXBpaVpNTlJhU3pFcStzK081bERD?=
 =?utf-8?B?MTlaSHpYYnpzbDFUaStxekVOOGtER3ZQa3lpcDkxcklXMWZ6K01hSDgwSEJH?=
 =?utf-8?B?SHBwQUtCV0J1OUVPaFBCQWtiY1V6dGRYTWdrbjRrTGF6VVJCbk5iZktXZThQ?=
 =?utf-8?B?QkZVYk9VQytjZ3RCbFFJb25zckVSMk5iYUQ3NS9iV1dvL2UxY0QzT1d5TE9V?=
 =?utf-8?B?OG1WMnJlcWtrZkdhNTVoRzJDWEJLRnpBbnphUlFFTW9WdFZCRkxsV0doSHlh?=
 =?utf-8?B?dStiR2Y1TlhYM283TU9RcElKMlBzMUZNZDZKeS9yekkxMlcvOERFQS81RjN0?=
 =?utf-8?B?NEE4ZENjUmJmTHdEbngzSjJpWmViakx4ZzFENGVmRFZIRmk2MDVpS0hnSHFn?=
 =?utf-8?B?aUh6dHRjL2pYeUlWc0JKN2VxdEVOazRZSE9pWWcwTy91bjRnYUcyVkhlQjkw?=
 =?utf-8?B?MXJ0WW1aeFFON09CbXRCYnNNZUZFSFF2eVNPSWI3VW9mTVNJQ0lnb3k3Ykp4?=
 =?utf-8?B?emVBUlVoUy9oYnkxYlpVQlpEcWpzSEw4TEtTQ1o0MUxLSnZ1KzY0djV6Syt2?=
 =?utf-8?B?MkxJT2VsNEsyNnNLaWNTcUJBamtadHpLTktMSElSTjlvbndXd056U2VIa21a?=
 =?utf-8?B?ZGtXcS9qb1VKYXBGempCdWNiUm1BRTJ3OVB6TXlTY0ljN2Vab2lOVE52Tk9D?=
 =?utf-8?B?SWU1MlRPWGJwNXE2R25IL3RraXFPYXdWOHVidzRMYU9UT1ovbUZTdmFKL1hp?=
 =?utf-8?B?a1FBRmd6d3YyY1AwV05remtiV256dCt0ekcwRENyaDZHelZLWUZQeGZUcGQr?=
 =?utf-8?B?Q0tGMlkvS3RvaGRpbDNXUkFhakdSUTBpclJoWE5sMUJxc3BxMFI1YlpnbklC?=
 =?utf-8?B?SXpuVC83dDNQbWVoZGVWdHUzVlRWVlpMeTljTldBUjlySnR2dytBVExUZ3p1?=
 =?utf-8?B?a1ozMVMzSWFHbDlEb1VIYTdIVCtBZUpXZlFZMDFpUVFsdTdNTE9jbEh0V1cw?=
 =?utf-8?B?Q2poMHg2aXBZTUdOTE9DV2RaS1hrZEFJQTNONzhIL0xxQzIwaWVNWEM0R2R1?=
 =?utf-8?B?dHdEbVFpNmV0TTZZOUFFSGdkZjE1VkdEdkVEMzJKTllRK1pLMCt6bjFZTGRu?=
 =?utf-8?B?MkNoMDFucnRackExSEN2RXVEMlVQTlRpQVhMNVRWbjUwdTNyZkxpTU1ubXl3?=
 =?utf-8?B?YlFrMzMrWFhaazlNaThESkJqazRkNFJXVW5LMnBOTE1qWHQ3RUp3YmRhWjJz?=
 =?utf-8?B?MWVRSFFPU1RMeVBkSC8xdDNYeXFDUHNhSVBhQk05eVdodGowSkUwNlQ5ZmM3?=
 =?utf-8?B?TXdPcm1tMmRkZEFIK0tZMEVOMUxjakJ2dUxIZmRIU0JUWGE3cTVoYmMrQXlw?=
 =?utf-8?B?aU5kSzlXUWhaaTU3V3FLMWJwaEwyUzd4U0VyLzZEblU3MS9lcExvdkZudVNW?=
 =?utf-8?B?eTFQWEh1ci95WGY4amk0ZnJLZlcvVUhVYjBESFkwQVQvbXIzMDNrOHFRS1hY?=
 =?utf-8?B?VW1rNGZYR1lhZ3N6a2lib05VZHdzYUZQcWdVTWZ6b2dGWlQ5RHVxU0NFOEsx?=
 =?utf-8?B?ZFBwN1Awamc3UW5wYVFudzRsODlkYlhRKzdReGYvS2VvWHlNc1JhRVV2YU5G?=
 =?utf-8?B?QUpSRXdQdjZCN01kQmNyQzhEOEt0SENZQ2podGtQU2FJNlBGSC9NeHc0eUV0?=
 =?utf-8?B?U0crNGdmUXRTTGxPbmhDaisxaWVLeEt1cnExMXkxWFk4Z0tjSk9kOVNFaUNZ?=
 =?utf-8?B?ZjBHRVRjZ0oxYXRKcmVPOExLVGZXM0lTWEhvTzVRcGhqWmdPODlLY1dHb002?=
 =?utf-8?B?R21KVk9qTkpLMXI3aXh2SjdBNFZUUlJXS3V5ZC8zYWdUL2JVSG9rN1JQNGx4?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d/z85+yU+SNcNNV8cYdHgXNSran2O8QbLncGXkn8zHlVP7kjOzGx3rWnKNkwOmmAZszAOBb78eOrrgzLoJ+n/rbz9SvuuhXK5uqts4QUXEP7Fc+pcwdBaokowluyx2fKIy0EFoOV6gm0LGZ2bxVmb1Mz96tkUoTvgbnruY5ApH6UWUk9/jQ2JyUkBzNSETMr8zh9yD0yvHSoLJVp+qsOssBNCAGVXyhOVC+ebnI9RlUT420QvzRnPYrKUY2Z9045NuuTxtXDgsrl6i36agmRUraj5jXywfjfpxClzrgict+QUTp7hzv2C3qw566rA+k7m9Wb+6LzpRvCbmyRStXLil4g1arOPRr/SLbSmMDowftcKuyDpFYzKOI00QI8bRUOVReBk15NEngsgJOvZnhfYgBdsfWMt53uhDjzdyrF+YKu9QeM5X0Z3Zq74+ywY/zQjViHQeV9mkpa/GY8ynubLp6ijUve/r29O6R4iJ36mVbXjgJHl+NfI5e2lgGDl/SEhQcOO4aLV+3W2WBpeRnPi25Qfe1KdsQ20gceB9nJWZozIJu+r9zjSHzAed7QiAx/JeHjLd50ghpJnr6lRXKbsXelj6MtYD4MEGszB3xz7b8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ecf628-15a3-4a96-eea4-08de101a7352
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 20:51:32.3997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGQj9Jdpxe92aVMTMnxW/kYhvglaWPovLkamVdT/ENXuvzTGGU30opgeAiQ4zAH8C6ygjaaD6w0Jgtgw3XjQ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE3MyBTYWx0ZWRfXw4MO3/8dQ4DM DAFRqOospHFVcKX/DzrzInh41UvXZVOwFFKH5GoV2gBDwrX07JKAarftDFE5XTHYJf/cJBTLTKs rllxd0B7IfWXa1+uCFjM8zXjQczBsoEsykeGeneCF9ctZvgA8v83SO8VQqxeaO3DCVEq1x6Qswl
 CNA20vpSl6HB4h5IhzP1+3iXkWo058VIWwwhTHPkWZNf3/Ug7pIFAEn2Z9pP62RWXBvHNrKK/Lu eKkNrcxksT0sXHeKhDxjufbM9FsE6hRnDN7Ri/ZYC6crADCoWHvQ==
X-Proofpoint-GUID: 6HXesBetiDCHDXweW5Wiv8nIZsZURLEd
X-Proofpoint-ORIG-GUID: 6HXesBetiDCHDXweW5Wiv8nIZsZURLEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510200173

On 10/20/25 4:50 PM, Scott Mayhew wrote:
> [ Upstream commit e4f574ca9c6dfa66695bb054ff5df43ecea873ec ]
> 
> This is a backport of e4f574ca9c6d specifically for the 6.6-stable
> kernel.  It differs from the upstream version mainly in that it's
> working around the absence of some 6.12-era commits:
> - 1459ad57673b nfsd: Move error code mapping to per-version proc code.
> - 0a183f24a7ae NFSD: Handle @rqstp == NULL in check_nfsd_access()
> - 5e66d2d92a1c nfsd: factor out __fh_verify to allow NULL rqstp to be
>   passed
> 
> A while back I had reported that an NFSv3 client could successfully
> mount using '-o xprtsec=none' an export that had been exported with
> 'xprtsec=tls:mtls'.  By "successfully" I mean that the mount command
> would succeed and the mount would show up in /proc/mount.  Attempting
> to do anything futher with the mount would be met with NFS3ERR_ACCES.
> 
> Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
> so we shouldn't be conflating them when determining whether the access
> checks can be bypassed.  Split check_nfsd_access() into two helpers, and
> have fh_verify() call the helpers directly since fh_verify() has
> logic that allows one or both of the checks to be skipped.  All other
> sites will continue to call check_nfsd_access().
> 
> Link: https://lore.kernel.org/linux-nfs/ZjO3Qwf_G87yNXb2@aion/
> Fixes: 9280c5774314 ("NFSD: Handle new xprtsec= export option")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/export.c | 60 +++++++++++++++++++++++++++++++++++++++++-------
>  fs/nfsd/export.h |  2 ++
>  fs/nfsd/nfsfh.c  | 12 +++++++++-
>  3 files changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 4b5d998cbc2f..f4e77859aa85 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1071,28 +1071,62 @@ static struct svc_export *exp_find(struct cache_detail *cd,
>  	return exp;
>  }
>  
> -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> +/**
> + * check_xprtsec_policy - check if access to export is allowed by the
> + * 			  xprtsec policy
> + * @exp: svc_export that is being accessed.
> + * @rqstp: svc_rqst attempting to access @exp.
> + *
> + * Helper function for check_nfsd_access().  Note that callers should be
> + * using check_nfsd_access() instead of calling this function directly.  The
> + * one exception is fh_verify() since it has logic that may result in one
> + * or both of the helpers being skipped.
> + *
> + * Return values:
> + *   %nfs_ok if access is granted, or
> + *   %nfserr_acces or %nfserr_wrongsec if access is denied
> + */
> +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
>  {
> -	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
>  	struct svc_xprt *xprt = rqstp->rq_xprt;
>  
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
>  		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
>  		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
>  		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
>  		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
>  		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
> -	goto denied;
>  
> -ok:
> +	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> +}
> +
> +/**
> + * check_security_flavor - check if access to export is allowed by the
> + * 			  xprtsec policy
> + * @exp: svc_export that is being accessed.
> + * @rqstp: svc_rqst attempting to access @exp.
> + *
> + * Helper function for check_nfsd_access().  Note that callers should be
> + * using check_nfsd_access() instead of calling this function directly.  The
> + * one exception is fh_verify() since it has logic that may result in one
> + * or both of the helpers being skipped.
> + *
> + * Return values:
> + *   %nfs_ok if access is granted, or
> + *   %nfserr_acces or %nfserr_wrongsec if access is denied
> + */
> +__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp)
> +{
> +	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> +
>  	/* legacy gss-only clients are always OK: */
>  	if (exp->ex_client == rqstp->rq_gssclient)
>  		return 0;
> @@ -1117,10 +1151,20 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
>  	if (nfsd4_spo_must_allow(rqstp))
>  		return 0;
>  
> -denied:
>  	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
>  }
>  
> +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> +{
> +	__be32 status;
> +
> +	status = check_xprtsec_policy(exp, rqstp);
> +	if (status != nfs_ok)
> +		return status;
> +
> +	return check_security_flavor(exp, rqstp);
> +}
> +
>  /*
>   * Uses rq_client and rq_gssclient to find an export; uses rq_client (an
>   * auth_unix client) if it's available and has secinfo information;
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index ca9dc230ae3d..4a48b2ad5606 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -100,6 +100,8 @@ struct svc_expkey {
>  #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
>  
>  int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
> +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
> +__be32 check_security_flavor(struct svc_export *exp, struct svc_rqst *rqstp);
>  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
>  
>  /*
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index c2495d98c189..283c1a60c846 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -370,6 +370,16 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  	if (error)
>  		goto out;
>  
> +	/*
> +	 * NLM is allowed to bypass the xprtsec policy check because lockd
> +	 * doesn't support xprtsec.
> +	 */
> +	if (!(access & NFSD_MAY_LOCK)) {
> +		error = check_xprtsec_policy(exp, rqstp);
> +		if (error)
> +			goto out;
> +	}
> +
>  	/*
>  	 * pseudoflavor restrictions are not enforced on NLM,
>  	 * which clients virtually always use auth_sys for,
> @@ -386,7 +396,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
>  			&& exp->ex_path.dentry == dentry)
>  		goto skip_pseudoflavor_check;
>  
> -	error = check_nfsd_access(exp, rqstp);
> +	error = check_security_flavor(exp, rqstp);
>  	if (error)
>  		goto out;
>  

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

