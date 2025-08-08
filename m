Return-Path: <stable+bounces-166828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C9FB1E590
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 11:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731541AA44AB
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A562690C4;
	Fri,  8 Aug 2025 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ec2HQ9TH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kp573sd/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40126A0EE
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644949; cv=fail; b=oWCMwEb085f1vl5NUzMTHg3deUc4JKNEzVLtSofeBl0kt0Q48Zy7SORAiiudbgSrD/iOnaF2JN9AostUfsfXAs8uOyhfvhirzKYFWbW0JQlQ5yRyD9yx5693ktaRLIc8dM7dO4neS9NWYFsccYAsenKmh/Jp2yfyPbAZNraJDs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644949; c=relaxed/simple;
	bh=QP53obp2Zn8UjDPRFmKNfVbiVyIBDkdn20o7FF0M8rc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGiQB9yV9ZaBoKtLTgXNN6Bth0qCMNhTys2HJA7Wa6Zc1y5aNICQEJPxq9mAA952rym9BXo9b6NHy0eBQMR/qF9rjDzph7lAMUz4GXU9Ow831SJMNDr5bMEHNzHQ1dWN1laczugSg6FwL+0HSsl2upKfp3wra6Jgdg0xwYpuIhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ec2HQ9TH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kp573sd/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786YLFq032090;
	Fri, 8 Aug 2025 09:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vtpzScgwTiRVH16a+LfLNOEdvlp4deBYXeBze08Jua0=; b=
	Ec2HQ9THGpnu73M+vBy70Y7UGDE4Mxw3FOjBhToI/b/BGfjYET2XA4wBOoOVKz0D
	vqDly5UGFxkESoiuME2gk3wGoPDnk+lpJzSLIKZziLEXF6Utc8KUvpyQQ2QGY1oq
	jYIBT8fn7hzLDbm2J8l7fwQBGMO0sAN2n2Vp66ojtCyrAP85ccmIVI0+kWPZ4Lih
	4yXwWrPFbv7r/ffeE4BY8WrSzYpZcd0pQ2VLkHJbFd5KZQekpY++44C4Pba+Oxo6
	oXFnMrVsJcPsKpZqe2XO/e0OYTfBcGud3sqrQsKuW7A0XVefAq9I8u8aGGWxgejQ
	ckeMTRzSYdqaP9j8nzFTKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjwskc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 09:22:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5788bLUF032165;
	Fri, 8 Aug 2025 09:22:20 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwt2bk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 09:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXkYO1KqHUXlpT7nhgR3GYqWib2Dl64yKb6gaHBi0ODPNckrNo910r6/CJ3TMNN6K5D95pZifB+2dj30jNfHZfSsllJnYf9eo20MCKVMLNDBLfY0qRoaEO25lyv+DaYOPm9FumvQzM4ZZi0PNnfqIiQ3Sfq+g+9l+ldnc7JW2qNKoGa0JpUUCmc0FCT5dobn2P/Pm4cuFznTsbs4P7RnOpRq6H80sJdzlwXtdUqjMGTE3E9+RDn0oGZwSK9gakNL/REgxYwM3XY5wNESoYzqB0QP0CoI5cYu7SLrVbERIYYXoLdzCRZDfVqwJk8ulZnPrRb1ZsSQbFOeTG5tKB1RIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtpzScgwTiRVH16a+LfLNOEdvlp4deBYXeBze08Jua0=;
 b=P4ORpsrgmVhDruF+PerV/Nwpf3u9xQ6tsM30ziBIMN/mBbczO4xRMehbsF1Lf4NXo2g3oBxkA19pGShkRtUtjw/4F7i8vFLYZD8Ap7Wl3eAyS3tajltwleNerv/bKVqWjnqmkb1cv0VdcKMpaE49MsIKmny4ITH9Y8ksaKsGYoCnLMjmYrBVuRbN2mblWgsoE35AP0w9ydn5l0DWDA7KHUhZ1c6tO2RKBuXQghBz/P9ivsVBOjpIyAvPM3wlN5JvJQhqaVh41+mUvtXkYfmDLwkWDLYXwP/JS7Tam/Nhq57RJ7YjjlBKt4/++/tcXc1XT4iIKE//2NnY2+JFbwpnTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtpzScgwTiRVH16a+LfLNOEdvlp4deBYXeBze08Jua0=;
 b=Kp573sd/EJXIq8fCupuUimzuiTh7Oi+EMB21wKcDmcm3hYSyu4OAwMJ2Irb6bQFL5mgs58fRMONTNc7PYL5wXx4Xzcg4NYShKqajIS5FD6n1R8OPkAKFOLYvzN/qqmboDdNOQn8+fhlV18d8C9PYsysrr777oOyU823QnE7Vgbg=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by SA6PR10MB8182.namprd10.prod.outlook.com (2603:10b6:806:43d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Fri, 8 Aug
 2025 09:22:17 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.8964.030; Fri, 8 Aug 2025
 09:22:16 +0000
Message-ID: <25725164-1110-4a3f-9ed7-7e26922172a1@oracle.com>
Date: Fri, 8 Aug 2025 14:52:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] vfio gpu passthrough stopped working
To: cat <cat@plan9.rocks>, Greg KH <gregkh@linuxfoundation.org>,
        regressions@lists.linux.dev, stable@vger.kernel.org
References: <718C209F-22BD-4AF3-9B6F-E87E98B5239E@plan9.rocks>
 <2025080724-sage-subplot-3d0f@gregkh>
 <b30b2f11-0245-4d73-b589-f3a5574ddd00@plan9.rocks>
 <06159138-b27e-4b9e-9fdd-51abc1e06469@plan9.rocks>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <06159138-b27e-4b9e-9fdd-51abc1e06469@plan9.rocks>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|SA6PR10MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: f2cfaa09-d17a-4224-6f2b-08ddd65d113b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjdDNXBQWkowa0RZVTRrVGNDWk1RczBnN2tZTVdJSm5qS3h4U3JFT0gvc2tq?=
 =?utf-8?B?ME03c25neWxiVk1uQlNFWmQzREkyZ3UvWktVTVR1UlNBOTdwb1ZsMVhsS2JQ?=
 =?utf-8?B?czhpRm5HcEgvaTQ5ZmZ0VXE3LzNxUWhPdXVBSTRlMjFNUWN2MkVNdWdwUHR1?=
 =?utf-8?B?dnZ1ZXN3WElTdlZGamZ1V2Zva3dRaUpFUjZmNUZtM0ZiZGFtM2pvVlljK205?=
 =?utf-8?B?cVhLN0ZKazVPYU93SlY1MmZwRHVxYU9nOHpDemJzdlAyV1dZK3owczJrNWFx?=
 =?utf-8?B?R09Lb2srZW4vbC91NGh0N0ZjVlZvemxWUjBibm9qTVZTejJtcHhuS2dScmJY?=
 =?utf-8?B?bFRwV1ZEVEpXWGRrdnVWNlBFNFZocEY4UnhvZjIvVHEvV0ZFTG5EbW9UaEh5?=
 =?utf-8?B?cEdkVCtsVkNxLzlqTVQwYmFnV2JrbUlzczFDSVgzNVo3YTZsZjdyM2dKc2Vo?=
 =?utf-8?B?SWpqdmN2UVV2T05UUnM1TU5xL3VNeHV5QXBMeithSHUyQUdxMDhMekxNbzNM?=
 =?utf-8?B?cjZJQlRjVmRrcHZxOWNyWXpReGdCVCtuRFdJdjROSjdkc0lyTDArdEIzd1hz?=
 =?utf-8?B?TkYrQ2prVkgxeUxXd3Z5bit5STFFeDVQMGY2elJaVDF3TmQ3bTdTZXBJL0NP?=
 =?utf-8?B?RjEvbUQrMDNGSTBKUFJNWnUrUE1qZnpaWWJXYVNnQUIxM0NTRENIMmNZTlJa?=
 =?utf-8?B?aWFIcTgvOWRBSG5vSHc4N1BPYkMvby9HUmJaV0RhOW9jUWNrRjl5Z0FlU3VX?=
 =?utf-8?B?SCswQXladGxHZWNodDJySTJRemJRMGlzQ1hvZTVOMDcwN0RFMGlKRkgxM2Ra?=
 =?utf-8?B?WWZmQXZyKzRHUkMyWU9YSHRJT3d6cXlqKzFWam05eS8weTkrZUs1VUE0YkpH?=
 =?utf-8?B?K1hZZjFyYmFiUitoRVFoSncxWWlBeTMvN2dzNjdJTkkvRENPZDlOQWJUTEV6?=
 =?utf-8?B?MWVLcS9QYzNHclFJTUtGR0hRYVRYQVhTQS9RdmhmNy9seTcvN3JTUzYrT0pv?=
 =?utf-8?B?bysxa2I5YzBwZlUrREh3Ni9CWlB0WmJoRlBuRGlxTkYyUDlZaC9UN1E2YUdK?=
 =?utf-8?B?ajN0RERmMWpGeXFnNHpQbFNJMk8yV3YvZHlzbjZGdkxnUU1MNjl6SVFSQXpX?=
 =?utf-8?B?M3lWN1BXUE1MYm1uNDMzbUlIUDdRdU1TR09aV2E2VDlDRUg5ZDIrRVpiQlpa?=
 =?utf-8?B?V2JjdHJoL1dNWVJmRDdPMjloSGprV2R5bmlCQjhlY3Q0eitmVkZUdFErZmts?=
 =?utf-8?B?RXhRam1jclBsYzZEcms5M3dlODVTU3hMWTB6Y0pxNDlPTm44aWg3T0FlTkEz?=
 =?utf-8?B?SWF4Q3lzRmhaOXNEbHc2SHZ5Q2lERzhJNEpoakk1bXgwYXpPdFkrUEtzdG56?=
 =?utf-8?B?c0FZQkhMZXNoSS9lOXQwaWNHdC9CRm10MmErbXY3TTRJOUVJS0NtbXRHMHI4?=
 =?utf-8?B?RGhvUStiK2h5VEdNWjlFMEc4RzRVTDZtOGFnKzFNK0hGakw2Qnd2YXRKR2xj?=
 =?utf-8?B?RTZ6NXdaRGlaSTluTjk1ZzcwWUlMVDdWWGNjajBrT0E2bCtMUkZlME0vbG5a?=
 =?utf-8?B?Ylc4QjZyano2ZXZISHJ5SWZBc1AzUWRXaGNEaTlJR05TbWFYNFdUVTFDNHYz?=
 =?utf-8?B?NlN0RDgwdlJHWmRQREhnaFFrQlRQY3hjTkRGTllScnNzd0VsN2F4cS90aDhF?=
 =?utf-8?B?WVJaZDYvcU9wVTRrR2s5dmVYS3hmQjN3QUowczhrWGFlUFNhYUQzUWNoenNV?=
 =?utf-8?B?NTR0ZDVTcXdYOVVjM2NYRUdYUk9TdC9pK0xCUWV6czhhOXRneXNNMTJTSDUx?=
 =?utf-8?B?K1FUNWhVZnVWRUY4aVRvK0lkRGtmRGlXVGU1TXlhTWl6WXczdjBzMW9GeC96?=
 =?utf-8?B?NXhDWmp0d2xSd2ZzZ1RUVVJvWjJQc20vdm9xUy8xY3ltRDZMV1dnbUQ1NUI2?=
 =?utf-8?Q?NWxAZHXXvow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2dBZzc5RXd4ZjBneXRWYjBnTFNXU2ZDN0pJZStaQUN6V2F2eGdNS2VQeW9n?=
 =?utf-8?B?a21kZjJGanRrUzk4d0RvbzY4SFRiZjFiTEdPVmxORDVDR2Z0emFoYjdKNjVu?=
 =?utf-8?B?bFJacEJqNS9HWWFVWGk3cUE1SnVHR2RPU1dUd0RUOHNFamVwMVorWWVoQnJY?=
 =?utf-8?B?dE9rSnRNb1hQamNJTko0K25ENUQ2VG5NOWkwL0d5NDNlc1lHWTFsVEFzNjR0?=
 =?utf-8?B?WWprN05oaC9uekVKczJ5MVUrZ1BCSUZOV3hDV0lEVW9JRlpGRHdTREZwWnNr?=
 =?utf-8?B?MnQ0c3o0WUhOK3A5Ukd1b09EcDY4MldoNjFYNHZweGlNdEVNcHhOZFd0TXZt?=
 =?utf-8?B?UWNxMVppNTRtZ2pQcHRaS25VZW1WdVgxMjVDeHA3bkhuQ0p4dmcrb2Ryc2dV?=
 =?utf-8?B?U01oL0xraWFiVmNZZ3BrUG56dUhOMFFMNnF5RHNESXBnLzJzQ3BIaElBc3N5?=
 =?utf-8?B?bDB2MXY1VTREcmhrcHhndlpyazhGOWprdlhjSWxqeWg0UFdReEMxbno3RytL?=
 =?utf-8?B?cVVIOHNNeUtsaTdTU0xMTFViL3BKY1IzKzFtK0RBeExlNWphZlRidUhwUDVI?=
 =?utf-8?B?dnJYNXU1VHJhdmxyb1JrZ2xmaFZsYVNUeTY0ZFI5dUQxbG9kOTlBZEVrN0NZ?=
 =?utf-8?B?ZmpiNHhibUs2S2M5cXVBNjFJblpVZC9WZk5ONWhGZWcrWnlscXNRdFJRRnpU?=
 =?utf-8?B?anFYbEh5eVJGa1phYmhQdnN0YmNFVnMrTDh5QWMwY3JtM3g0bXN4WkNCeDlX?=
 =?utf-8?B?UUU3amxXbDVUNy8wSk1ITWxkL0xIMXVXVURPZm5vRnpwNERaRllSOHV6SjZQ?=
 =?utf-8?B?VW5aL0V0M1pFMHRlMVZCbmhUaSthRC9GU1pQdE5PMWpKQXR0QUc4dzRuZGpt?=
 =?utf-8?B?RUp4R0dNMk0wYkttelpiVkJQWklnUys0K0ptNzlMR3phNWZhTHBhMm1KNTRC?=
 =?utf-8?B?anIra1hpSFQ2eHc2MnlTV2lLS1pDTklwR1pmVkRkYlBieWJSUVBub1NsRk9a?=
 =?utf-8?B?dzMrYVRLVjRjUlRuS0N6eFJtTk5iSnlnL0tORWMzeUdDbS84NTEvc0k0ZWpU?=
 =?utf-8?B?bFlSWm53WDVlU0E1N1RGTkJiWUpnYXNkQlRXY3k4cVIvOXlQb3pWcnhxTXdK?=
 =?utf-8?B?NGkrdmE1THZjM2NVQmswNkxrSk1RUlBHZHQ0SE40d3R2YUJkSDZNc01pVWRE?=
 =?utf-8?B?Z3UzRGp2L3V5MFBZN3dQTG1QZ2t3NTF0UFY2dmtCWGFGUzBnNnk5a0JaZytw?=
 =?utf-8?B?eHhYTWt2OGg4b0NVeTBFdlM3S2liaE82ejRmVjJpZVN2R1VBaENHMTRUSVlt?=
 =?utf-8?B?UmRQVDMxdkIzUzVvdDZvVHdrenVXYlF5c29xV1psZXV4bDJVYkNrY1BQRlpJ?=
 =?utf-8?B?WXZlNW5KU0FDT2pvUnpDTXlRSE1HMUV6aXJFdlVDSzVsWUlkSEswOVpEb0Nw?=
 =?utf-8?B?REZJS3JkZUNoSU9hdm16VjNhNnJtbEcrZGhxYkc1aStZK2k0NVBFbDVDNkZR?=
 =?utf-8?B?dk9BSm1UZUpGZDVBRllUV1k5aTNIeWNQcVRpcmlxSmNNK05KSTlmVDlQWURl?=
 =?utf-8?B?SXZGaUlRVHRCS05yaGJhVnVEM0UyMkltdEJpazZONjY1VTRObHNTVnFwNFpS?=
 =?utf-8?B?TmZWbk5wRlg1dUFkb3dqUWNlOWhGOFM0Z2RaL2V2SE9PeldyTHBWYXhPckY0?=
 =?utf-8?B?OFZ0MjZDc3pFR1V6V1BYdFZBU3Rvb3h4OFlXRnU5M2pmUGMrYlc0SVhENUpS?=
 =?utf-8?B?TWxqTXB5NkY2b2Q5Z29FY3hUWGdVUmtnazdydlNQc0NXdzdLZGZTMUFDcmRB?=
 =?utf-8?B?SmtaMzZuL2xUUkRsVU5VdzFueDRja2dOMFJWQVNQajBXaDdGcjM1QW40WS9W?=
 =?utf-8?B?bllQTnlwTmcxOXFPM0NBWURoVENqNU5LcGVWVE1GSnJIK0JoNGpUWjlneUJH?=
 =?utf-8?B?VW10L283bVo5UTBONUo2S0grT0FaUHpTbEswTGRTek1zWnplVkpQTkRRR2FT?=
 =?utf-8?B?NnUxVmZTK29iR3MvODVjUCtGbTFuaXk0WnNoNzgrbWdFSTJyVjRPS3dBdjVB?=
 =?utf-8?B?VUpDSytxejFpcndCbWRpb29LVUdBTld3UzVpajA2YTRQNXptQUZ6RHllcnRV?=
 =?utf-8?B?elB4cVRWTGVmVGE4YzFMNDhjb1VlZVQ0dk9sbzlucEN4VFpsUVkyYTdqbUVG?=
 =?utf-8?Q?imx4p97C5HdCMJV8wAIg1GY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Y99csAi1bYKf4RwhscIN6cxVfDPspGkkJyNeFYo0OLIHu+wojnQJePZT7LI+CsAZRb3gLuYqUPTFGPE6lPL63Rjm4R0kH9JVUzrcvReA0lEj+wj/mjpFGMG5ncOno8ZTDj63o9q3M/NyyespK40CXcfcPEBamLXg8OzflhJaAEG0hxoLbossjNccsYLhBsVnwmy5+5LFWMrCdY2S1cM5wPLSCWukbyAGdLPRLU/+cWbHCYfiYM8piBWOZkhkaAwEyPgYygfS61ni01LCZE9YRG1E2wmIjYkP2q9qeV6kSovYhAdKHIQdqcGHCzTkYrh8RzZVNmxAJFilUXVOgwH0B/n7ZdPmN5HzAvzrfY0BpZCLGoyCSPqRDpX5Vznw8gldW2UoudNUTjxmHS1WAcP4f6UpVlRCblMC3cJPkEdczcG1TIkDaPrLm/Pj4ZTSmI4ZYS6/VLM9DELWYDZOP24piNgpN70KF93UFgXUcSueNRZtWq+6Lda4F+VoA9BsxOPTaze6B7JHyA9/ymlQrDhSiijYKpmPOqtRYg5DziqMGWX1xOUv13meZ9D6scLb716xA1MkC6lNAQxYAnp1u0Tk6N62EK3SVA51vJGJw++zhA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cfaa09-d17a-4224-6f2b-08ddd65d113b
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:22:16.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LnI1SP4oJGAStdH//xOQc7xTcI5pY3z6WKUq6BpBVW2xmzCAXmoNgfVGl6y4tJup+zgergrrpDJB+qS47o/DWgQDHxgsSKBO+VkoDgfKUmBTQH0qQoEZt48YPl7mgDR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8182
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508080076
X-Proofpoint-ORIG-GUID: o-Z2QeRgqkyElFP6fgBdhqO-PogTu8-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA3NiBTYWx0ZWRfX8EzmmPRTtVNN
 YIP/mud0rOAFDIYh2FBnILq81GqcaNV9+zB9RG9fF5dl3WCNd0N0eyGuGhAJUulVX5KdiEc5HHu
 hV+WAm/9SKL6wal34e7hxTnNTEojE222PrLR/apDJSvH8EUIztM7xkG5XfM6xSVGHjHN1VQ0vkJ
 1b3ZKoYGShwl1hJVENavja9vbZ+C6Jv9iX5fRn5++7449GT0AyjZWhSdaBD+4RX3+MB6pqKB7b3
 atyQ36w1iY06C/3obwo98ynLzQa/3CjxaF+8HtFNQH/0DVQnX7OOHY+qPm8un+5ahajmPBkgqRD
 acfcgQm/HrM+zjzfjVYpIhOJHGIvXHe4tDWaNXZCAj10M8ZfftzborL/JQDfJflP9N9ZlEqRwo6
 15VunofnRzKdjaW59CSqlesBtXShcaW4CtizfIPYzSJAedwF4iup7sdaZ7hwe/0GOxBUwNL0
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=6895c1ce b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=ag1SF4gXAAAA:8 a=2oJEeyrFVGyRxqO4gYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 cc=ntf awl=host:13600
X-Proofpoint-GUID: o-Z2QeRgqkyElFP6fgBdhqO-PogTu8-O

Hi,


On 08/08/25 14:30, cat wrote:
> fb5873b779dd5858123c19bbd6959566771e2e83 is the first bad commit
> commit fb5873b779dd5858123c19bbd6959566771e2e83
> Author: Lu Baolu <baolu.lu@linux.intel.com>
> Date:   Tue May 20 15:58:49 2025 +0800
> 
>      iommu/vt-d: Restore context entry setup order for aliased devices
> 
>      commit 320302baed05c6456164652541f23d2a96522c06 upstream.
> 
>      Commit 2031c469f816 ("iommu/vt-d: Add support for static identity 
> domain")
>      changed the context entry setup during domain attachment from a
>      set-and-check policy to a clear-and-reset approach. This inadvertently
>      introduced a regression affecting PCI aliased devices behind PCIe- 
> to-PCI
>      bridges.
> 
>      Specifically, keyboard and touchpad stopped working on several Apple
>      Macbooks with below messages:
> 
>       kernel: platform pxa2xx-spi.3: Adding to iommu group 20
>       kernel: input: Apple SPI Keyboard as
>   /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi- 
> APP000D:00/input/input0
>       kernel: DMAR: DRHD: handling fault status reg 3
>       kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>       0xffffa000 [fault reason 0x06] PTE Read access is not set
>       kernel: DMAR: DRHD: handling fault status reg 3
>       kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>       0xffffa000 [fault reason 0x06] PTE Read access is not set
>       kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
>       kernel: DMAR: DRHD: handling fault status reg 3
>       kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>       0xffffa000 [fault reason 0x06] PTE Read access is not set
>       kernel: DMAR: DRHD: handling fault status reg 3
>       kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
> 
>      Fix this by restoring the previous context setup order.
> 
>      Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity 
> domain")
>      Closes: https://lore.kernel.org/all/4dada48a- 
> c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch/
>      Cc: stable@vger.kernel.org
>      Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>      Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>      Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>      Link: https://lore.kernel.org/r/20250514060523.2862195-1- 
> baolu.lu@linux.intel.com
>      Link: https://lore.kernel.org/r/20250520075849.755012-2- 
> baolu.lu@linux.intel.com
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>   drivers/iommu/intel/iommu.c  | 11 +++++++++++
>   drivers/iommu/intel/iommu.h  |  1 +
>   drivers/iommu/intel/nested.c |  4 ++--
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 

Looks like a duplicate of 
https://lore.kernel.org/linux-iommu/721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun/

And the fix for that was 
https://lore.kernel.org/all/468CF4B655888074+20250723120423.37924-1-bbaa@bbaa.fun/ 
which is present in 6.12.40, so maybe update to 6.12.40 and the issue 
will most likely be fixed.



Thanks,
Harshit

> On 8/8/25 4:40 AM, cat wrote:
>> I will perform bisection, yes.
>>
>> On 8/7/25 3:52 PM, Greg KH wrote:
>>> On Thu, Aug 07, 2025 at 03:31:17PM +0000, cat wrote:
>>>> #regzbot introduced: v6.12.34..v6.12.35
>>>>
>>>> After upgrade to kernel 6.12.35, vfio passthrough for my GPU has 
>>>> stopped working within a windows VM, it sees device in device 
>>>> manager but reports that it did not start correctly. I compared 
>>>> lspci logs in the vm before and after upgrade to 6.12.35, and here 
>>>> are the changes I noticed:
>>>>
>>>> - the reported link speed for the passthrough GPU has changed from 
>>>> 2.5 to 16GT/s
>>>> - the passthrough GPU has lost it's 'BusMaster' and MSI enable flags
>>>> - latency measurement feature appeared
>>>>
>>>> These entries also began appearing within the vm in dmesg when host 
>>>> kernel is 6.12.35 or above:
>>>>
>>>> [    1.963177] nouveau 0000:01:00.0: sec2(gsp): mbox 1c503000 00000001
>>>> [    1.963296] nouveau 0000:01:00.0: sec2(gsp):booter-load: boot 
>>>> failed: -5
>>>> ...
>>>> [    1.964580] nouveau 0000:01:00.0: gsp: init failed, -5
>>>> [    1.964641] nouveau 0000:01:00.0: init failed with -5
>>>> [    1.964681] nouveau: drm:00000000:00000080: init failed with -5
>>>> [    1.964721] nouveau 0000:01:00.0: drm: Device allocation failed: -5
>>>> [    1.966318] nouveau 0000:01:00.0: probe with driver nouveau 
>>>> failed with error -5
>>>>
>>>>
>>>> 6.12.34 worked fine, and latest 6.12 LTS does not work either. I am 
>>>> using intel CPU and nvidia GPU (for passthrough, and as my GPU on 
>>>> linux system).
>>> Can you use git bisect to find the offending commit?
>>>
>>>
> 


