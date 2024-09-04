Return-Path: <stable+bounces-73028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376BF96BA97
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3BE2816EE
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862D51D2204;
	Wed,  4 Sep 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="drMU2Akp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ErVEl4Jy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291DB1CF2AB;
	Wed,  4 Sep 2024 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449205; cv=fail; b=tO1j0YaLNsWnzffS+GG98rZ44eHak2+aqOU3lc4ucfD0p0acf6DZkZ+CIinh+hN5XzvKh9hNlpvBE4MH4bMYbrFKBPEL/v0cCvS0jTeBpTbRaWaqdG1v4H7VIT8eR0nBrSB8HLxrlen+jSdAkwJAlcbcb2DFEPTl2MacMTOPLCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449205; c=relaxed/simple;
	bh=3uCf+0BS1SQsDMNYkvrZPCzjwAhAexXHiKe5FN3dH14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FPI0mRJAnG6QF9wdzn90bBuG6pNHY755SIoO4PmGZ74+1VyizwIXnEPEhzzigInenZrpnhGe/BP7gpQWE04Qp8w4lNbnAzbAuh4gTsj6lsJctdUHKQOAaK9GHUSv4mr8Z/mXk58jyIeC6bXeHX9KFrOsBF4H1QCkX5rqK4zzuVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=drMU2Akp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ErVEl4Jy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484BMYl2029290;
	Wed, 4 Sep 2024 11:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:mime-version; s=corp-2023-11-20; bh=lnBvmwRgVXweRo
	T/wP0LkHpZC1h+4DYHh1OfKF6eXB4=; b=drMU2AkpgjJuexzKo/J5GRoDuciRmd
	TiZsDxrvpVnq19uayZV49ScQcTDFJYgW9MqhfR23yPPCSx5Rl+I0RszZjNlWLISd
	n5APPMB2UyZiHloR/qp0H9J0xwul4zCm1u2Ukc7Cu/kT9lIx8oj42PeBniy7LHf4
	h4UC7fHayZv4cMkXnvw5YgiejKadMw3XrgklDarrPrf9QRGa/fGFlaEHhpxGCifK
	/bDCw3y4xHK2PankhZj1i7+nUIFWqetM2pN5Srqyd5qqHQ/dJsOsMBQ6pocwRKb1
	dpImfiKj8PpoQYIuYrVa+8nGgW9lo3H1KgGQOXLPUUNec9ZKeJer9nfA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0jugwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 11:26:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 484AFnxM023558;
	Wed, 4 Sep 2024 11:26:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm9eudm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Sep 2024 11:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgcJPNuIOP1QCnPdVBrz9pJcEzhwsGggP/HEaE6ANumn+Pxno20pX9EW2UezSFPieTB3UXV75mdmUB+V7uu4PyZGEB/uWevKzkBztqnpJNEos4+tdzoUvXSDmR+JOwU8D2rpN6i3oOSojdHKdToRhQi7og6EiQeAE8psEVf9xBZ6WViAq7CDJm8Tou5yj6/B0tcjslHPatMwpou7APK4f6SY7Q45tl7y2pzjkgc7ymAIAxNlOt0N+tWbsrYFdo+tmzh0AMtUYAlsTFYyr7Yu+hex5T2tb/ARKkFBkunftiPcpcRFRbTmlfyJj6i1SQk8b7J5CHAGa7TfJ29rzLFaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnBvmwRgVXweRoT/wP0LkHpZC1h+4DYHh1OfKF6eXB4=;
 b=nUepwa9pRtMFlJFV4UBHBat4LZ3Rf1tMklijufBlPVIEdbUXfnvw4cxLVVk6d4cKkcsYH5CBV/Ed8L82TH7iObwNQo5V0TuOH54z1nTCuBApFInGm6pv//zwn+Nii9Y5oZJKZNaW8i5WerYlpUrdNmLaDgcCyeZi8p8Eszd4AdOfD1qBWIOs/7hYwG1eks964lpZy+4HegtKLr4TdE7fc5CMTLiZF7QkPZYQotfOVWCavQrEUi4iKq4GlHtIcT62qff2cHSkc14/TKmpoxsbUcdntPviu3vM/0Y9587SFZwyFNar3T4t8Fzl+SLETsA0nPnXwNA4H6gPv0GPsXOxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnBvmwRgVXweRoT/wP0LkHpZC1h+4DYHh1OfKF6eXB4=;
 b=ErVEl4JyeiJJYoT6g2795p6O3T9Fhvc7F6UWRKr552Nm51jgp2YK4O336A2dbnekOj9wloBpUup1h2LFmicK6xAy1ngba/rM+36VeHhWGWPybx9g0+b7ADmmjhTwVVHL5aVf4TvFIBJiFXe4eu6f9OPOsX1ERvIphMbw3WYt/Uo=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by DS7PR10MB4973.namprd10.prod.outlook.com (2603:10b6:5:38d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.10; Wed, 4 Sep
 2024 11:26:36 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%5]) with mapi id 15.20.7939.010; Wed, 4 Sep 2024
 11:26:36 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "edumazet@google.com" <edumazet@google.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in
 udp_lib_get_port().
Thread-Topic: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in
 udp_lib_get_port().
Thread-Index: AQHa/r1NPQlaVMHOAkSVHv9ifFK3sg==
Date: Wed, 4 Sep 2024 11:26:36 +0000
Message-ID: <64688590d5cf73d0fd7b536723e399457d23aa8e.camel@oracle.com>
References: <2024072924-CVE-2024-41041-ae0c@gregkh>
	 <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
	 <2024090305-starfish-hardship-dadc@gregkh>
	 <CANn89iK5UMzkVaw2ed_WrOFZ4c=kSpGkKens2B-_cLhqk41yCg@mail.gmail.com>
	 <2024090344-repave-clench-3d61@gregkh>
In-Reply-To: <2024090344-repave-clench-3d61@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|DS7PR10MB4973:EE_
x-ms-office365-filtering-correlation-id: d03b655b-341b-4e26-b5da-08dcccd46fea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dmk1WGR5VDhwaStLRTFzTmdZaWs3SEVRM2wwQzVMOHFXMERCSWVxSWF2MEpm?=
 =?utf-8?B?U3JxSW16cmZ1ZHF2ckh5OVZHVkw0VnRTYk1FelhpZGh6U1oxVC9XN2dSM09j?=
 =?utf-8?B?UFpGSGsxb2tKWlFLSmpWeWcybkJBU3V0ZzlyWENsZWNIbXdrWXk4c0ZkV3Bz?=
 =?utf-8?B?a0pzSFNwMmJkZW51bGFxcENORnBGaTNRa0NVdWpqVXAzcFBNTllXeEZMbGJp?=
 =?utf-8?B?TXhYWHlvZ3VaSGt3dnlFT1NLbm8rZ2pxTVhDZ2toaGt4NFhHRjZJWHFrNjRF?=
 =?utf-8?B?NVJIVEpsdEwyQ2pRMVd0UWdpa25EQktoaTl6dTNrb0xoTE1GRmFlZ3BNUFRs?=
 =?utf-8?B?U1RQWXdkL0VFc3BUdGhiSWZPb2xkRlk3cXI1azVlVnAvWS9kNmwyUUEzOG02?=
 =?utf-8?B?QWJ4a0FiN3VnakhOMUNlWmV4dHFwTXdWdnhVMS9NeVlaRTB6ZGg2aUJKeVBx?=
 =?utf-8?B?cUlZY3AvR1RFR1NmNmhDZy9ZeUpWQ2xMTFNjWjlNa0NqNGR1angraDVLTVpw?=
 =?utf-8?B?b21QSUwwUmp4cnlqODZrdjRob1dmSS9mZ0lvZWhMSWpYUndBZFUyeVJsMjA2?=
 =?utf-8?B?TlNFT2RGZnpUaGNjZnd4NVk4RTZiLy84T1pubHc4V2xNckdLRDlMYXJRZ01u?=
 =?utf-8?B?TWsxeXZIZmwrT0JBeUdsaGxiRTlWL2tyaDgwRm1yY1NFZUFPN2FhZFNFOEsx?=
 =?utf-8?B?TWtCVFNpdUJ1WlNOUFp1cGl6Wm5nTWxaczF4R3lTcVBFbE9Ld0xtVkgyaFIy?=
 =?utf-8?B?MUx5WlZ0QzBTMSs1THYvTVl5Qjc3RGlYTCswcDYwY0dpUFI2blVxTW5pcWk2?=
 =?utf-8?B?SFJhN1BVVzVzYk9EZmRFUThCNFptSGNuSCtMcVNkb3hPTmE5dkova0ljQlVo?=
 =?utf-8?B?SjEwL2NhYTFoUVlLQ2ZNZmZGallMWkNxV3orL1p3Wjd0bmIyczFOa3NSTTcw?=
 =?utf-8?B?cFlyV1grU0VTeUNkc29qczdXdUpraytocjFMVm9UcHlVMVRTVlh0b1Z4cnZS?=
 =?utf-8?B?YnJhNkRFWlRSWm1uUGdTSXBQNDI2NnRSbDkzaDNId2N5NTY4QkxFd2J3UEFZ?=
 =?utf-8?B?dnBNNVZHZW9tQmcxU1BzS2NZd2RSSDVpbUEvOTUva3ZpUENTd21OWTVtYXls?=
 =?utf-8?B?SnI2eG9pNjN2SWpldUc3b3pJdk1acmsweG53bCtLRVpLMWlIYmNHVnRoL3lF?=
 =?utf-8?B?MEJmdmpOM1o3OE9pUTdUQ0JJdXd3S1VhWnhmbjVPVW1XOEtlSmE0NmNPS3cz?=
 =?utf-8?B?UVFZNmM2UGNGOGRTWHppeGlFV2l6Z1pudFZEZ2dHNUU1MmJrOXRveWZSbEZK?=
 =?utf-8?B?QUVvajBvV0hzU1JJZCtJd2g4a0ZDMUZ6VjIvc2dneFBhb04yUXRUTklEdHRn?=
 =?utf-8?B?SFUwMFBRU2VqNHl0VUFKaVJxT2cxalJCQ0UvQ2o3cnBUazJneS9peFhMM3Zx?=
 =?utf-8?B?ZjZ0bnZHSnhZQ0ZDUVYvbGZpMW9YNC82SE9scGtwVEpQWUJNU1ZJT0ZGMks2?=
 =?utf-8?B?Sm5uVjdnR05BNTgwcEEwdjc0RGx5UEc5aVFDZlBGQUdqTW1xV29vZEFLZ3Aw?=
 =?utf-8?B?MXNKVlRWRUt2aFdBcUVuVVdIL3dHNXJLSXVEc3cvOW9nZnpaR1pxd3FDUmFB?=
 =?utf-8?B?cVVEMDBKdHpVY3lZS085bnVIeGdJS1ZYelUwVHJSRXVyRmxXNW52Ympydmx4?=
 =?utf-8?B?bzducmxqZHZDSXdaenhVTFloL1dkbzVEYktJTURxVUNIUU1jbDlMTUl4OFBT?=
 =?utf-8?B?YmVhUndxUkVQQXBUZ3RaNytnWkQ1S2xkbEpNck9GZUVoV1F4RjNDalRVTTdR?=
 =?utf-8?B?V0l4TGUwajQrVVZNQWlzZ2lIRFBlbUV5Z1RMKy91YytTZm9ZbWJJZUowUUl4?=
 =?utf-8?B?V3ZxN1R2VzZzZmpkVXlRVi93b1crcElJaHczbFBGSGJzUXc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVBRdllGbkM3ZVV3QWJWakllUkRxSWg2ajIrMWNNQStwMTZQME5EeEpWRytC?=
 =?utf-8?B?U052YWE2L2tUSEh1MDU4S1hLUzZhWHEvd29oS3RHNDVLa2gzUHVmSmFNNjVp?=
 =?utf-8?B?VjVyRy9oYUJ1MHFIV2lJckRNdU01dWhvQ0JFK2kvNjZEZmJKdmV5eE1qWFF5?=
 =?utf-8?B?SkRPa0l1bEluV20wTFpuMS9HdkVMWTdwMTRtQlVRRHkrY0R1d1c0b0pDOERz?=
 =?utf-8?B?T2Vjam9IOUtySU9xMVNJL0ZwODgvRXRjeEg4QWkyVmg2RlFWS09BMTlsTCtV?=
 =?utf-8?B?Ym5zU1dHc2Izc2R6T0trVUZMN29lQnlyRlI4QmpkbW9PbE5kV25Od1pMcldW?=
 =?utf-8?B?WjJ3Yjc4N3BkZi81dmgwUFMyUEcwZ1VhS2kzYVNUR1VCbVA3SnlZdC9nMitw?=
 =?utf-8?B?S2xPWFdzLzNQVURid2g1OEIvMlJxWEh2MmI2THNoQUJQT0dsdE1yb1hld215?=
 =?utf-8?B?RWU5UG50ZDVEVnpYcUVISk13d1VyY1pENmZSbjBBbXVSb3pKdlNRcmRkWTd2?=
 =?utf-8?B?MVdIeVFlVUUvY1Q3NjE3bkFmQXNaZk5yZkJVbnRqTUhHNWgzUWhGS1p5TzdX?=
 =?utf-8?B?NjVJSkV1WHhaRkhvOUxLQ2FZNVNkU05TOUNjSkhaMkozV05lY2hMak1DZFdh?=
 =?utf-8?B?NzAwYXB4c1RBZEtkcjh2cWtBeDdGRm8vQkxuZFA1TXZqL1BTTmVMdFhMc0k4?=
 =?utf-8?B?cFJTbkVmNFFKaXRHeUIwZmI3bHZCcFFaUzN0VklxaWxLVnhLNzBoZjYxUjJj?=
 =?utf-8?B?UHhYU3BtMy9jbkpWeXZCZDQwN2NXWWplSVFmemFFVi9INUZsM091K1RVVFQx?=
 =?utf-8?B?YTVCajB4VVdaWGZRZEJ2bWIxV29Tb1BjdERFcTZTd3pCSnVsTzdNektGSFZh?=
 =?utf-8?B?eHM1aDM5eDBSNGlBZ24zanhqeThpVzV2cWFXalcvQjIyeHlSdU93blR6bU9W?=
 =?utf-8?B?WDcrR0Q5azFTL1JTR295QVhIUmdHcWwyMTNjU3V0YVllM3NDWFRUZWxqZDdH?=
 =?utf-8?B?SG8yS29nYTRycDRWZDN2MEg2SERPb0VUTDNacDBSdkI0WWdhZXNNd3Axb2VK?=
 =?utf-8?B?Tk1VZlJDdnJxZmtndUhPeEZMdE9UaFN6YjBkb0R2b29GOHIwSkt4THdxaERL?=
 =?utf-8?B?eVhWUWxPUnJYY1drSXp1RW9vSkVPUHBWU292R2YwN2pmNm9tRnhsM0RqdzVJ?=
 =?utf-8?B?aldLV29QZEVuL0MvRTlLY1VKbTRhOFNybyt0NDd6WjBHM2tlaXVJRGkyVUln?=
 =?utf-8?B?cXM5Umo0cEd1S3lrUW5ZeDd1cjEvelJHTnJmRENRRWI1YytzWmlWeDIydFVZ?=
 =?utf-8?B?WWticDFIcjRGTGhkYkNqRlh3ZnRjMHZlSUZpWE15SlcyeVdPUEYzanRVNkRL?=
 =?utf-8?B?VFp3Y1Rmc0FSUTMrUnVubENLMTdPN1FHcUJ5c0ZnQ1pRMFNRMWw3V2IzTEpD?=
 =?utf-8?B?cHZHdGxzbkpRdDMxTnJaVjNDaGlWa1NWdHl5U0IzdHZ2QlFoVDFiVysyQ2dU?=
 =?utf-8?B?ZHpUbXQyNGdla2picjNweWlRZkQzMXc5NFBWM2pGbFprd0dSYnIySUN1REpT?=
 =?utf-8?B?dVJKOUNYTUlhNWZiRzBicUZiTlVnUEhBd095NUZJdFY0U0pCQy9oZ0xzUW5F?=
 =?utf-8?B?Z2xoRVRKTFVlZ1BGTDNJT1gyRHZJYUdQcWw4ejIzNC90RU9VVHVlcWZTalp6?=
 =?utf-8?B?U0pBVDFUak1KSno1S3NBMzFOTVhxQzY5Slducy9tUmQvVDViOFR5QVNOeVlY?=
 =?utf-8?B?SFpIUVo5eUdGVlAwOExXQ0lUR0xTQ2lrNXo2ajlucjFvNnFCUEowMFNQcVVy?=
 =?utf-8?B?d09NYk5NOFVicTliV2tlNTdzUWIwMHpFbTE2eGJFVzhDTXovcTZqQi9RTlh1?=
 =?utf-8?B?MFJPRktvL1p6YkYxT3JtQWg3V2s2SUgzTjk3YjlpLzVoWEt1Z1pBOVQ4ekRw?=
 =?utf-8?B?UGRvMTBJNFBBUUoxeTVoUjVUWWVOYytObVZQNVlZaXQwUVdKZnpIMkZGcVdW?=
 =?utf-8?B?YS8yRVUvZEJGSUVVakdDZFAvUW5OcEZscFV6cFZWVzBHV1FkS1JLU3lvQkxj?=
 =?utf-8?B?bU5TREtYQVcrZEp1L3c5ZWZVVm80VzdSZ09teUpRSXMvM2hrdEpZdldPdm5M?=
 =?utf-8?B?dllsTFEwNkxTUjMzZmo1dGFEUEpEQUhxaldkdVdHZ2N6NUZOaXMxbVphMHNP?=
 =?utf-8?Q?BjhFivn7BskNpYMY3b7juh+U9b42aQ58A7IgFwoTKSfS?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Avl/sCHSO42RyeRk1keh"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ec0Ov2lMdcCgBf9rsjs7b6RGHbgBqZXUErYeiM8LAapHJNI0Z+vhIwHOe0CA3pbU252hMRBBlBY6YW6BHNS3njfXzKGwe3J5YEOGDVVTDB74Dz54kT+49VDwiCoJjfzAVKkBYygRc7vSRWWB6Kkye/ombsFEdiPTFC8MIZZaN/A9WYDDphc18CNwPLX+sduFlQ8JS596SHgTLdlMHBgiqIAo89wOC/KkVOmyepRMpZ5meY7kQ9GfY3afZ1cGkC1ur9S9XcJEtSuma4i61CwegsmG5OYHJbJDlY191E30D6rvP2DYRm1Q+sVIufysoFrb3PzW3H314UFhQmEjq1RI+Kom9OWuGyFsjY1XOfC4ZCKKJmLIQ5vxQXVqXoN+DjqkPZvmj5k6XS4J1yBZSo8eYU91R5ppg71EyDkjNXGjVx3jgzToPG215aQvUVrvw3FKqPG3spZlFeez15OBHKD1be9uWWnDCN2jI09Nmh/UhJAwKW+5NUWV0H+pjE7JAn/3i4uwIP9OVn6RL23y/Ii+Lrp6SurtsRS7A87Fc3iXAlZ7wFllhaGqNxH5t1ojC5NR/Lv4qwztaqz2XP+XRDMDCTLEiXedeSHpI74EnJb4xLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03b655b-341b-4e26-b5da-08dcccd46fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 11:26:36.2428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Zy3hag+XtdEsU8GZbbbF9HkhQ2K06sI6O1ddXp1WxVLtDuMcy2/PmaxPw6MWRb7balwpR8Dys6hc9s6I6zitEXjJzpzSVEXgUZni/Cv/Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409040086
X-Proofpoint-GUID: XLCPt7hB7U1gsRJcZz0-bDpnyK5OrFNl
X-Proofpoint-ORIG-GUID: XLCPt7hB7U1gsRJcZz0-bDpnyK5OrFNl

--=-Avl/sCHSO42RyeRk1keh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03 2024 at 18:28:14 +0530, gregkh@linuxfoundation.org
wrote:
> On Tue, Sep 03, 2024 at 02:53:57PM +0200, Eric Dumazet wrote:
> > On Tue, Sep 3, 2024 at 2:07=E2=80=AFPM gregkh@linuxfoundation.org
> > <gregkh@linuxfoundation.org> wrote:
> > >=20
> > > On Tue, Sep 03, 2024 at 11:56:17AM +0000, Siddh Raman Pant wrote:
> > > > On Mon, 29 Jul 2024 16:32:36 +0200, Greg Kroah-Hartman wrote:
> > > > > In the Linux kernel, the following vulnerability has been resolve=
d:
> > > > >=20
> > > > > udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > We had the same bug in TCP and fixed it in commit 871019b22d1b ("=
net:
> > > > > set SOCK_RCU_FREE before inserting socket into hashtable").
> > > > >=20
> > > > > Let's apply the same fix for UDP.
> > > > >=20
> > > > > [...]
> > > > >=20
> > > > > The Linux kernel CVE team has assigned CVE-2024-41041 to this iss=
ue.
> > > > >=20
> > > > >=20
> > > > > Affected and fixed versions
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > > >=20
> > > > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed i=
n 5.4.280 with commit 7a67c4e47626
> > > > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed i=
n 5.10.222 with commit 9f965684c57c
> > > >=20
> > > > These versions don't have the TCP fix backported. Please do so.
> > >=20
> > > What fix backported exactly to where?  Please be more specific.  Bett=
er
> > > yet, please provide working, and tested, backports.
> >=20
> >=20
> > commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99
> > Author: Stanislav Fomichev <sdf@fomichev.me>
> > Date:   Wed Nov 8 13:13:25 2023 -0800
> >=20
> >     net: set SOCK_RCU_FREE before inserting socket into hashtable
> > ...
> >     Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> >=20
> > It seems 871019b22d1bcc9fab2d1feba1b9a564acbb6e99 has not been pushed
> > to 5.10 or 5.4 lts
> >=20
> > Stanislav mentioned a WARN_ONCE() being hit, I presume we could push
> > the patch to 5.10 and 5.4.
> >=20
> > I guess this was skipped because of a merge conflict.
>=20
> Yes, the commit does not apply, we need someone to send a working
> backport for us to be able to take it.
>=20
> Siddh, can you please do this?

Sure.

I see there are Stable-dep commits too, but the seem unrelated and
require some commits from another feature patchset. Do I need to
backport them too?

Thanks,
Siddh

--=-Avl/sCHSO42RyeRk1keh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmbYQ+UACgkQBwq/MEwk
8ipuqxAArBfyFDRLXGQbGgnWR9GA5W+u8n1WSZcOI5Ed6I4WxIrECOUUr/kXxdDn
E1/mCdV/8MqNuRJBlziAZpnrrS76xExGXbgBXMynbM2Cemf4NZMdfPM6FXzgxOGX
hp5N1vNczh8SDb3M1W6u9FP5vfriJRPUcNvpUf+zVHXeJmRiEnghNNyRQl1u12DB
y6vtxsWjZhx7nz9gC4C4gq43t+Ht2ok3nhHahekwbEOBHfRJOiUO5mJt8yH7dYG/
N6Z3iiKkW1pWDrzXHa9UDJefUt2H0B0dC1PsHqkx7y4cm9GQgvlvhsxauMAeLz2g
vJfxwGJ0bdtN7nY87DanI5vDGhA4B4vyB03SbEs73nulY/7jCsutRoiPGFeqHKuj
3+zZIwmVuqW6LCldJMtR9+wmNe0DxGsmyVcvWHDlJB5fe96b9ce3Ps+1Zj1g7qas
az0flN+qVo3ZsvgHJGTfPnZy6Mv3X/WcM/tQehgKmXqR9DXHMSbWvoZp8YBR+NhZ
WfwciDuBsOJZ8LNfk8SWOIay1MWBbyA6wpjt3vmssg7BriOkhL/urwoP2tiVNZPB
sgLc8gcTiT0jl5cwJ7uWM7BuNQgIV9SbPU4hYZclrTtSZ6yJp2yWnt0yuCJ+ePaP
8im7MY9oTfB0euZFnTrlAxue02Nvv3Tcs2folcUv4xNN0MU7bQ0=
=uL+5
-----END PGP SIGNATURE-----

--=-Avl/sCHSO42RyeRk1keh--

