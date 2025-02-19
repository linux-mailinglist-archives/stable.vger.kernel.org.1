Return-Path: <stable+bounces-118356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE592A3CC3B
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4613ADDE6
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97882255E33;
	Wed, 19 Feb 2025 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JhZpVOb4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nMJ+xIDJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737DC1CCB4B;
	Wed, 19 Feb 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003837; cv=fail; b=vDUh3yoMWoNudJaeAhjCyBtsxyNUzkmYMANSfwfrr7nqK5MhLDWwaWPsApEGkdcqqq9YSPOrpBS3SPQTOxnOGLyUEVyYLj77KV3y3dAhwhsY7TwptGAbyc1mXIbUtj4IHzCr1vaFNSWdkloxixFpqqpI6B0cDXQ0en49ucQgljs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003837; c=relaxed/simple;
	bh=jE0vx9bk7BNOX0T4IIVB0HK+f5wW+OFOYfautQnmC9g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKcPe8y/LUpCCS5ecS78cyNHwF8NzZ3g+/QZ7KuLuZ5faPeERw2dnmaD3AQfQpsR7a2eora/k+e/RzkJz6/Jo7b6Yf8p5hPj9ySY+JnWTGiUHhD7zgY5lTEITDuke7VkOFV1nw6Qk4Ch62phY2ms34lye9vak4hlEqyQGOyJgvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JhZpVOb4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nMJ+xIDJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JM9mRO026439;
	Wed, 19 Feb 2025 22:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4sPdePGX5O1zebnncAfK81hYjRuAyFpdFQni9wy/IA4=; b=
	JhZpVOb4HLt5/wo6T+/exLfKxow0fOVAeiasMmzyC4987EWqyAxy8+SP8bMySaai
	ankZXGNrgNKokpWd+Tv7/S2BN8Hj932HgpJuSz9opZNVIO0x29DwSURHzwGeZJzI
	gA7L3aoxAF3KCRUO3Z87VceV8al+Lpt3FZs4AKJkKv8EF1W6CQHveCQ0JaVXxxfG
	BV255zNbtTpdUmrr2d2M0SsfNV/NBBGwWgnuDq/tDI+mn+R4Vr34eO5eallVlmak
	ZsvXsQM8AIaVj42BcRsHMrgHH6qbto+jX2wV1Ev8X2qky0enUG5MVsBrZ2JolIk1
	cv9m+acBHvesv+i5vwN4Zg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n2v6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 22:23:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKRXFf009674;
	Wed, 19 Feb 2025 22:23:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09d4472-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 22:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APc3HLICLX9qq0bE7iCEIcKTrMYZ3m/ttgM0EN/fmM11QDbmDjD2BhEtFYic3W8hnf2kuYwdWS5qgQzHJgv3yv+3qX6lWV9e1xq1P5RauLpBJq2P/j3XNpe+HODMk5GktT1mHSBM3qDKGwaUrTUWc3YTliLXGV4Vwk91ifyaMky+LcbpVlbQ6YC+5g8GWgrr1YTTjSan47DjXrnVUevtjf8Ro4AOkThueM9AgR5OjMq/70eQUDvhFp67oPBJc7pbkuR+6L/iXFw6O2Jyp30P+Ia/30iqv6KuYToSnM6rlylLYbGa0Fc4kcYAtMCuqfqPuh3VIox++QCGdyHrpG+5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sPdePGX5O1zebnncAfK81hYjRuAyFpdFQni9wy/IA4=;
 b=Gxs2K9O5XPG9EiOfqwujog+T9tYP1RLAtmaev4TaAm4nSKFfERWL1FkWtDrHJxxwS6org5i7qhyUOFpm0CgNnINSFs2+22/tGsFky/KufKAgzqgdFCMWnKUJA8pQsi9Jp283hPh5OqxHnlp5K04NDVW88SAUxru5yAf4LL+fm6MtF+++MUe6hKsPpzFdvzVxU1Ue3F7PJg/360yNP3fgalBrH8wTn3E+mCG/HR0KWv6wtrY3/0w+ebB0UD2uWYY/OhEkcAAlhzKA6CFQt/3EgQup6kHdRzBWXP3tZdlKCPew+2abniE+rpwwhC9QfzYqmsUdDvEco1Q1DUWT7eJRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sPdePGX5O1zebnncAfK81hYjRuAyFpdFQni9wy/IA4=;
 b=nMJ+xIDJPNiw5coruYeNL2mHq4CQQ12r92Alocb96h+6FN9PZ8GDO2drgs20W95BBwsidpyOcrTkAKUuWAPoeQ5GZgD2ywci2rTDDR0BdvwMy4X3ABElxY7LKWZOkEE2Q9IwcYZPaQykLDVBfljIYQTWek7MvAaR8Dof3n3hpVM=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by LV3PR10MB8132.namprd10.prod.outlook.com (2603:10b6:408:291::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 22:23:32 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8445.020; Wed, 19 Feb 2025
 22:23:30 +0000
Message-ID: <6df15794-4acb-4c24-adc8-a273f0fe1b51@oracle.com>
Date: Wed, 19 Feb 2025 16:23:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] jfs: fix slab-out-of-bounds read in ea_get()
To: Qasim Ijaz <qasdev00@gmail.com>, zhaomengmeng@kylinos.cn,
        llfamsec@gmail.com, gregkh@linuxfoundation.org, ancowi69@gmail.com
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>,
        stable@vger.kernel.org
References: <20250213210553.28613-1-qasdev00@gmail.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20250213210553.28613-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|LV3PR10MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 115f63b6-d424-4de0-33da-08dd51340a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzBKUjJ2ZU1nSTRoWkJkcEc0WHlNRWhNQzFkMEFQWTJjZGxXY1ROUWxSU1dP?=
 =?utf-8?B?YVZaaUQzSklsd0FHRjVMaHova3Nrenp2OUMwbVpJZEcyU2t2c29IQ3FPQ0xa?=
 =?utf-8?B?WXhlVFQwcnhlSi85NVhLMmxXbzlEZGszeUU4UGo5SDFKRkFUOUVMUXJBWGE0?=
 =?utf-8?B?WmMyaHBLVC80a0RnckVwdzAxYlQ0L1g1WWM4ZG9TZTR5SFdzYURGeXNFa2Nx?=
 =?utf-8?B?OENYRXl0bXk3Q2V0dnk3bkIwRk53SnkzcmF5ZEVTYVJaT1R2OVIxdVEyM1lG?=
 =?utf-8?B?d3F2L2tMMFdEV2s0aHJPUVhHc29HL1hPdkRVWFZETWlrRUxwZGdaNGtQaXBT?=
 =?utf-8?B?WUFwWmFFTnFsdVlxd3V1c2hJdkVvamFGVksvbFZMeEx4dW1CczhaWEpMakN5?=
 =?utf-8?B?WDlkL3pHdUFwNVJXcTNKZkdhd2daaWYraGcyd0VNdTlvSkRwbFRGUTJPTjcr?=
 =?utf-8?B?TU5LaGp1anBJV3ZiLzFIMTQxSUhSblRYcmNTck5mSFM0RDlSbXdTTm13TDhD?=
 =?utf-8?B?Zy9hYW5Ea2tBT3MyZlBrS0pNRGlxRVl5NUE0a3A0YjhHNkhxemtjcUxweU1s?=
 =?utf-8?B?MUd4MlE2Q29JNEx6bjF3SkI5Q3BRNUtJbm1iYVhGRTVJZnNuSTZ1Mlo0disy?=
 =?utf-8?B?dGo5dlNLOUltcnlWV0l3NThPNHN2ZkYxUzNPdVkvMEliajhmdkdXbklmR1N4?=
 =?utf-8?B?eEJSZGluekRoWVQrOXIxK3ZvWSs4RklkQ2NNcW5IMXM1cFV0VjhCTFZweFhO?=
 =?utf-8?B?UDlxclJBVHRpb2F0cmJ4RldjS3E2eVNlZExUNFVUNlFCSm1HOFNRWWN4ZllC?=
 =?utf-8?B?MXdFNjRFNXR2eGNjTDdNeGFsb3pWTkw0eGNEUENDaUpIOUMwR2dFWVhPdzg1?=
 =?utf-8?B?bU9aV2IvYXVDN3BNajZNZnpoUzZLRiszV0d5a01aNGprU1Q5dmlzVHlPY1Yr?=
 =?utf-8?B?aEwyNUx6ZjZ6Z3JzMTJvTmczWEZzdG9YdnJRMFZrdjFQamxUcWVTajROaUpj?=
 =?utf-8?B?Qmpyd1dTY3o1VXQrZ1BJZCtVR2VwUmlVU0pMWHR3cWFONlNTaGVyQ21tbVJ0?=
 =?utf-8?B?MUViMjgwbkJDODVIa0llWlNCSEF1VkNMZnBLMnVyeU1wTVo3RllaeDNrazVo?=
 =?utf-8?B?UTJ0OVFwc0V5K1hMYVZzMHpQNC9qdVJWbGIrWVdZTjYvRVVSdFFDZ2dXV2dU?=
 =?utf-8?B?aHF1YzJ4ZXMvTi9VVE8vcTBlb1pDai90cGhJVzlRMlZHRE5ZcGoxS1owUmxW?=
 =?utf-8?B?NFdEK2JOOE1hQmR3R1NXWTlHZkJMUnUrOXc1VW0xdmxwQzJ6ZjVleVQzcEVr?=
 =?utf-8?B?M3dycDAwRGpnTkN2OE5keUJCV045ZnZWUHg0MktGZ01FTlJNNVNLZitKVVJP?=
 =?utf-8?B?N1QxR3FyWmN4M0F6U2wwUGlpQ2Q0clZyc2hodGM1YVNFWkFlb0JDSmZjOHBo?=
 =?utf-8?B?YTNRT2YzUHNkTXBjTFBIZ2pmY2VBMWlkVGd2TGNHaG1RVkxocFlrN1NITmZI?=
 =?utf-8?B?dWJLZFdTZVYybVJFZVdiY1lCYjJ4ZWVtcVZGaWlPWU9IVTBCaTFZaDFqeGQw?=
 =?utf-8?B?bWIxZ0FvNmlRWk1nOVFsRXhSUHorVDd6NTNLUnV6bHVKN0FhdU5QendJYXZD?=
 =?utf-8?B?MkRpUU9JTGtPbFdiYitsV09vVVA0anhJUERSN3FtSHhuM1FvUVh5aC96ZHFG?=
 =?utf-8?B?THRWdnRqM05mU0hwOHkrUjR4bExSdU5waU50djlXQzh0cnl0eVB2cGQySmVp?=
 =?utf-8?B?T1ZFVVRYdUJDczQ3cVdtbllJbC9LdkJuY1ZNYWhQbVVTd01LRnNmNlloUUVV?=
 =?utf-8?B?OTJiaXBKYmlDbUM4UElWQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlxdTdKYk5qcUFDNTFaV3JKSmVoRnNubTBtS3RBT1FBMWcveVhZMHJpWk5t?=
 =?utf-8?B?NENvdkhMVjUvQS85YW8zenMrNFNQYXkzc0hYUi9oTTBxQVQzcTFDZURaWUgr?=
 =?utf-8?B?Uy9YWWRkSmUyVnNjdUY0OW1OZk1CMDFjTmlrNm96Y1dDK2RNcXNGN09nZzBS?=
 =?utf-8?B?WjVKbzJhWExNLzh2ZTdKQVN0RURUV3hSMmdrVk9nNmFIcnBhMThiRmR6Sjhl?=
 =?utf-8?B?MytKMmkwSWxZdGNFOVMyQ0NhT3c0NzY4cXllNHBydzZRWHhTeG1jQllaaFM5?=
 =?utf-8?B?QnV2OGIxSitRQUFXU2VVbFArZndOaE5Gc2k4OHlPdlo0b1h1eHVra29Ddm9p?=
 =?utf-8?B?TXQvTSsvZEdXL0dMdXcyM2ZkMWZKbEM1bzZ5RWh3M0tZODVML2FQYnhtRFU4?=
 =?utf-8?B?TE43U3doL0V0WHNhdC9ibEFqYXFaZEhlT0pNZ2Rnc2NkR2NneTZIWWVwTFRw?=
 =?utf-8?B?T0lKdHVSczcvZVZHbnlkeDN0V2VLU3Z1Wng5L1hHcUYvMTh0Uk43amhuVUlE?=
 =?utf-8?B?ZjNGYUN1bWxyM1Zqcms3Y1E5UzJQYmhWNExhN1BUcE94cU8xMFE1dXgydW1j?=
 =?utf-8?B?MWF0MWR3RkpLaFg4UEVORExZRzNWblBXWC9VTGgwcWRGYWdIUjVSZmtMSy91?=
 =?utf-8?B?Y0Z2cFNxNjE1TndCcmxteHZvT0JiRVRZYWgxbnZOWlRkMkpCNmd4WEhKdndE?=
 =?utf-8?B?bU0vK3RvdmNoaDNkeHFETDdIWGhub2Qwdi82NlpOME9iVFZKYU1waDNyeVhD?=
 =?utf-8?B?YVhyMk41OGIwSzZ5NjdidHlVd3lEMHlUMGEvSGdldDJkNTFvMnFDTjJIUEky?=
 =?utf-8?B?R3Nkc05nNUJhczJDWWF0clU0YVFyT0w0ek9ic2svaXE0TlZhek9TVTVpbktw?=
 =?utf-8?B?bisrSkg2N01mWGJHU2RXZ2NMS1NzcklpWkdITHB6ZTd1WnNKS1pxY3Jmd29I?=
 =?utf-8?B?YTdSM0w5SlRyby9iYzFUbnl3Ni9tVGRLV2lQRkNQVEM0ZXZpeWxiMHU4Qy9C?=
 =?utf-8?B?Q2VBUEJGcnloaTBzVHZYY3piTDMvUDNoMDdiT1RocE5ScDM2Y2kvMDd5UjR5?=
 =?utf-8?B?Z3d0Z2ZzbVkzOXZCTjRlSWZ2N0Y5di91REFkK0d4S3lFenRiMVRFYWY4OEFs?=
 =?utf-8?B?UGlQMVhqblRaYjFxRkdKaEJWY3YvMlg3WGdtQ2dZK1h4b1hxZHVBcTAzVHlK?=
 =?utf-8?B?cDNpcEFuMUlGZGFGOFdrSGdxd3BpcTV3dVdRcEN1YU4vWnlBa1VCTVFtWkZO?=
 =?utf-8?B?a1M3VWFOS3gwWGpkYWh4S1pnT2tLdWxZMWtQUTFZMGZ0cnRKNmI2MW8xQVVY?=
 =?utf-8?B?NkZxQ2VaaVphblk0RkJxbWZuMDFqRnFWcUVLUnM0RnRIRk82UkJ3ZTUzOU5z?=
 =?utf-8?B?UkxLRVNBTmdkMkw0c0JmOEIyaFVMNTVxZDJPWHkvYUJaeWdIOW0xaHdyMkJJ?=
 =?utf-8?B?dDVLM0RVYkt1MnNqNHErYWRCMVF3WmJqNzJUTVRXdE1HcGhXdVQ5Nks5MURj?=
 =?utf-8?B?cjVpaHJjaTNaRHZFK2VOa2FOdGxUQkI5ZVRLcXEvWjBPU0cwZE5mMlBQUGMx?=
 =?utf-8?B?WGpWaTFxTmx1S2FXakh4Z0RwMEJUeWdEdkZHNXkyWStDRk5tYUlRUEFqQTdD?=
 =?utf-8?B?aGdDOU5tY1FSMmxGZXdObVA4LzYrMDZUYkVpU052QmFMWW8yWGFHM3ptRVl5?=
 =?utf-8?B?cjdCcGhWVWVYbUd4L29hdisvMDlES0hGcU1YNURVWmRaYWJIbXZxR21mcnEx?=
 =?utf-8?B?Wjc5LzNPU2pWKzNlcVdmb01ZL2NwbEllTGk5Qlh0OFBEQ3BIN0hueWhKSHIv?=
 =?utf-8?B?SmpVZm1LY0NVY2UwaUwzVk9wUnZ4MnJwK09KRzZzME9Pck1pWXhXQ0VBTlpx?=
 =?utf-8?B?Z1JsU1orQ21IWDVidEN1Zkx6RS9CTTNnZEdScXYwWWdTaXZPK1hlamRwTFVY?=
 =?utf-8?B?SzI1WVhQWXdweEdBbEo0MWI2b1g4czBmNDRRbmpNQkxPRHIwdUV4Z2FZRm9P?=
 =?utf-8?B?MjRteG1Rd0hTY21vVzQ2TXV3cFpxbnBZMDhwTDBScHpkRWdoNFoxV1RFODBB?=
 =?utf-8?B?bk8wVmRjcWIzOXRpeTF4UktsV2JWQnB2ZU9MQXBxRTc3N2dNZnMyZ0F0QlRx?=
 =?utf-8?B?aFkrY1VKYzRqNG1WcHk0UlkzK3BhSEduRkhnZUxvOEdWVjB6dUlkLzFCdDg3?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NBGDZA75RxEynx/yOn3l5PoTeSOrnbXbgWvEGPYMJTcaT5tV4dysln7fTaLzwjYrsIQmBsCi412hNxzc4NUZagWF5HAzMbABlx2BnoiDr8VqlyT3RN++AjtLPqdG7ytpeDfqzDI4EnJwn+THnB/lfvmYjccH7vvFiUweeHmUWQRVm4JjHqUWbeVL5393b9QM+iAdLIzZ8kJ0e+FNrWIlUTN9idsniQYldnDEznUPJUS/C+mWthYMk7fZiQ6ACGyNu2jw0Bj2c5duPsymOpVRx8EjX1uySOiLDrVVqKfzsUwRO5uHjEomVk8vcUfDaag0+hXpKAHW6/ahhyQ9BN9TGSvczbpih02nzxP6ZDp+8Q/WZiLSN3xoyWB1u6feM8/wQDtjwiNyAj0mXYc6tYXZEKFVtAa9yPPxNzEOwTusOSRt1LmU0QviVgvNPMTrfhskd5qKIpLlSYwlx8XMnYez2DHHgUKtgxOE2zPTYdUXk7lq+wkxqZiQpDWkCZyBCH9VSynDVHq1qWQLPyEMwLwiAJ91xJM0MR7BnP9dr9nK6v7Z20Wa3Fk3nV26gLYEK/0Cwy9VNhB1B7io2dQYbgTd12HtyM+3H5nsAxzSTdvqFrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115f63b6-d424-4de0-33da-08dd51340a1e
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 22:23:30.7332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1T8IzGyLSEEjXDLbBDegRvabpF0hQDTF1UnJVo8zdzpGx08RAj4j3fxhaFtlchoQF1JZmEbJ66QUtmqATGwepqDlNRdNrHel7Q9NUFHRs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190165
X-Proofpoint-ORIG-GUID: yk0pftGCBOsrCGwe82V-mvnTtu6VUQEI
X-Proofpoint-GUID: yk0pftGCBOsrCGwe82V-mvnTtu6VUQEI

On 2/13/25 3:05PM, Qasim Ijaz wrote:
> During the "size_check" label in ea_get(), the code checks if the extended
> attribute list (xattr) size matches ea_size. If not, it logs
> "ea_get: invalid extended attribute" and calls print_hex_dump().
> 
> Here, EALIST_SIZE(ea_buf->xattr) returns 4110417968, which exceeds
> INT_MAX (2,147,483,647). Then ea_size is clamped:
> 
> 	int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> 
> Although clamp_t aims to bound ea_size between 0 and 4110417968, the upper
> limit is treated as an int, causing an overflow above 2^31 - 1. This leads
> "size" to wrap around and become negative (-184549328).
> 
> The "size" is then passed to print_hex_dump() (called "len" in
> print_hex_dump()), it is passed as type size_t (an unsigned
> type), this is then stored inside a variable called
> "int remaining", which is then assigned to "int linelen" which
> is then passed to hex_dump_to_buffer(). In print_hex_dump()
> the for loop, iterates through 0 to len-1, where len is
> 18446744073525002176, calling hex_dump_to_buffer()
> on each iteration:
> 
> 	for (i = 0; i < len; i += rowsize) {
> 		linelen = min(remaining, rowsize);
> 		remaining -= rowsize;
> 
> 		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
> 				   linebuf, sizeof(linebuf), ascii);
> 	
> 		...
> 	}
> 	
> The expected stopping condition (i < len) is effectively broken
> since len is corrupted and very large. This eventually leads to
> the "ptr+i" being passed to hex_dump_to_buffer() to get closer
> to the end of the actual bounds of "ptr", eventually an out of
> bounds access is done in hex_dump_to_buffer() in the following
> for loop:
> 
> 	for (j = 0; j < len; j++) {
> 			if (linebuflen < lx + 2)
> 				goto overflow2;
> 			ch = ptr[j];
> 		...
> 	}
> 
> To fix this we should validate "EALIST_SIZE(ea_buf->xattr)"
> before it is utilised.

Agreed. The patch looks good. I'll add it to jfs-next

Shaggy

> 
> Reported-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
> Tested-by: syzbot <syzbot+4e6e7e4279d046613bc5@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=4e6e7e4279d046613bc5
> Fixes: d9f9d96136cb ("jfs: xattr: check invalid xattr size more strictly")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> ---
>   v2:
> - Added Cc stable tag
> 
>   fs/jfs/xattr.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
> index 24afbae87225..7575c51cce9b 100644
> --- a/fs/jfs/xattr.c
> +++ b/fs/jfs/xattr.c
> @@ -559,11 +555,16 @@ static int ea_get(struct inode *inode, struct ea_buffer *ea_buf, int min_size)
>   
>         size_check:
>   	if (EALIST_SIZE(ea_buf->xattr) != ea_size) {
> -		int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> -
> -		printk(KERN_ERR "ea_get: invalid extended attribute\n");
> -		print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
> -				     ea_buf->xattr, size, 1);
> +		if (unlikely(EALIST_SIZE(ea_buf->xattr) > INT_MAX)) {
> +			printk(KERN_ERR "ea_get: extended attribute size too large: %u > INT_MAX\n",
> +			       EALIST_SIZE(ea_buf->xattr));
> +		} else {
> +			int size = clamp_t(int, ea_size, 0, EALIST_SIZE(ea_buf->xattr));
> +
> +			printk(KERN_ERR "ea_get: invalid extended attribute\n");
> +			print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1,
> +				       ea_buf->xattr, size, 1);
> +		}
>   		ea_release(inode, ea_buf);
>   		rc = -EIO;
>   		goto clean_up;


