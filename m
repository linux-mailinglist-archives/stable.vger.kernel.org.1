Return-Path: <stable+bounces-103998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965339F09F1
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D47016A393
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD81C07C1;
	Fri, 13 Dec 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UAbtrRCs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hU6n/mPZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825051B4F21
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086731; cv=fail; b=QtPtEL0BbWlpkRBhKhCJeA2eRU/c3cs9unE3QRMhoM3KCkItpcJ/bzn9ISBNilseAezJiIY8+rjIPSS6O6j27kF5Rk3yQJEHv+DovsMTo3ai/HTTugGtc0GQO8SsJv3ImVdNP+vRb4PBU+tUsNIF0EZBYEMUxJ8m/dEhSQk6zE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086731; c=relaxed/simple;
	bh=A5caEDvvMFScTwkQ4kUIrc7EB/3P06vqlltg/18/+k4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2GvCv33gxzL0gazYkdfbo7kNq2u8xYSrY1atfk4Sw/nXHP4fVBw1oR6nD8um1YAbk1gDeb1505jcBVPmw4YN7nsp56Ax1qSSKn+Vw+/c7v62FRqG2tZ3IL0gtBBENEpmiYH/SCNysp7oDtXjhnS6u1oDlTQe+q7vYs73JZqUa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UAbtrRCs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hU6n/mPZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDAQm0Q022655;
	Fri, 13 Dec 2024 10:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tOWMS+2nmht3o3I/4h6erygb/qYi7vsODInvROkFF4U=; b=
	UAbtrRCsQc2yPmHXcuNytAoVbkgDqrnzJhwQ4LRzw/UefKoFGKO2vADGOpAuUIKJ
	S2HTmYQz9JXGs0EwG5QAkP1Ado1Vyv4lgXkhsq+Hmtw3eQZDGF/1Xns+yissYSuI
	gE+UuqybhLWe1nG9ZVhzBpPbf/AWcs6JSthsizT2GibSz3i1dkyB+RGjOjMqZLqf
	VQ58xGOFtLzGcrW5lN6a0+xy0D89VbwgkK1ihrAtvLKlZyXh3p+CAAHnS+3ca55F
	vCNCl+gh/xrW6d9aVkOOTwNeMuk75/4hW3BcSS9T9KRweBDnnhQfGcVJ15y3retP
	jNPxEE8VJn/mvuRjw8ITfQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9aw8tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 10:45:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9UGIC020507;
	Fri, 13 Dec 2024 10:45:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cctccq80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 10:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acuzGljjGcj/jBO88HmCqcYny/Ul2L5jILZllcUt1Y0PiKo7TKbYn0chX/3pTpTD+262dCQ9IgCml2/fjVXbgxpOLZH1MtqO0z9f9gzZ/yyuPln4fXXzYDEsudSE31nC7QJEPOzPY/LjZi1cD3i9fCzyhy4itZ4tVps6EwsvbSzJscmqMjIMU2wATZ2DEg3aSWNrpC9D0B8X9bRkCFXCrlj8+BpqdLaZ5Sv6SH95gTFW4Rcb/KnMRRephuf0es+4MUzw8ZExlSD1dDOhde9Pg0bn42NRs0NvKIksOiyv5q5LS3EuNSy4wVj2aCc9f7YwEW1lXwFhrlNJSYHW4hXlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOWMS+2nmht3o3I/4h6erygb/qYi7vsODInvROkFF4U=;
 b=fttJs9+6E4JQ2KmCD9WHRyDRb34TaBkpIoNGeyIi2l9iAVRDHFHSorFeQuaj39fCi++feyDPFvXI2I8jaV0w74j48s//QYzEG4hB6uU/3WVK4I5NzPliAH222JwVcw/MvWsmdB+UmAdkHPzAnUJxNAEuMQM80xJnHCxPlUHn7o9H+0FEEjUFUoYUXANfxegvn7ezfG78CvaPZXAA+dL88l1VjJC1suijfhlCc5Zze/5J0MmtWNdKY7zbIMcR0O68yXSm8reV4yIRShlKxvn/U7j751pa+KMJwRdJecIH3E01I7mfOHkhRaRu2hfOkSkJYtvxvlKuE7kQG+YPp0nLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOWMS+2nmht3o3I/4h6erygb/qYi7vsODInvROkFF4U=;
 b=hU6n/mPZzzKcpFRGilRdCo63Xth7Ex4/mfk81Vmjhi3T0BljcDUq/1pqVu6JTj3suxALZhNUT+NmSUfyqlnPiV1RGmXRCj1L+YIyZjwVY6mm7jGlsg6ZqsKee0ETaSdswOmNU8W+rf3j9KW0FwK+xRg2IOViGl7KzTZ6xfZ3Lhk=
Received: from DM4PR10MB6886.namprd10.prod.outlook.com (2603:10b6:8:102::10)
 by DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 10:45:18 +0000
Received: from DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38]) by DM4PR10MB6886.namprd10.prod.outlook.com
 ([fe80::bdcc:98f5:ebd5:cd38%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:45:18 +0000
Message-ID: <cead071a-f60c-42ac-80dd-f3fb1d937e48@oracle.com>
Date: Fri, 13 Dec 2024 16:15:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][5.15.y] gpio: pca953x: fix pca953x_irq_bus_sync_unlock
 race
To: guocai.he.cn@windriver.com, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ian.ray@gehealthcare.com,
        bartosz.golaszewski@linaro.org
References: <20241213103122.3593674-1-guocai.he.cn@windriver.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20241213103122.3593674-1-guocai.he.cn@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To DM4PR10MB6886.namprd10.prod.outlook.com
 (2603:10b6:8:102::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6886:EE_|DS0PR10MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 93717790-a881-4b69-6543-08dd1b633c23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXYvVW5hS25FSDRSa0VtcVorUWlPTWRnajF4UmJrVjMrNXo0NmtlMjh0dzZp?=
 =?utf-8?B?cDFZdm5XdTRxNHQzZEt1ek5qbU4reGVrOStLc05wZlUrRjVBK2VDL0UzRFEw?=
 =?utf-8?B?TmFRdi93Sjl4aWhTTU1rNERaVWxUU3p3Q2VTT1hQQTFZUXRoVHFDTE9CZENv?=
 =?utf-8?B?b3ZSQVlWYzFUWDJ3amgyNjNkYVpVMzROYnNIZjNzd2p5bGQxVFBVOVVKc2pO?=
 =?utf-8?B?S2puR1hlbDJYWDhGUnJHaXhFWjNXLzR4SlQxS21Ubk8vbUR6K3NVbmNmUzdV?=
 =?utf-8?B?RGp2L2JGNjkzajFMbDBRUG5RR3VqNElwL3ZxbUVCWTlIOGhQQzRGcEVUUFdG?=
 =?utf-8?B?V0FibEo5OXMrRXJJbklnd1c1bHZsNi9PcEU2ZU5vMXhsN0c0eHFpT0N4SGM0?=
 =?utf-8?B?UXorSnhmWmxxUnhpREpIZXZ2VyswM3lma1FXZUl1d3hxTHFJeU5uMVN5SG5M?=
 =?utf-8?B?eW5yUHJPbG4wVzVqeW1nYUhaR1hzQXdBRHNzSTN4a1BFRHptZjV4SGZxV0g3?=
 =?utf-8?B?Z3hzY3g1WUs5dTQ2UGRJSkFrYUFETDVaMXJCQmRiby9aSDVvUEtCUVdvZzNK?=
 =?utf-8?B?cUJIaEpmb0xSb2JqbUExM1phajN6bHpiNnF2M3JYN0JkUmppa01DUjY2NGRB?=
 =?utf-8?B?TnZRRUJqcitGdkZSOGpKQXpxQ1VlNlNnRG5MZ3pEK1pEM0hJWkxHcVhGVkEz?=
 =?utf-8?B?eEh5bXFFcWI4Z2dPbHRuOU1qSFdPZTlxZVBEUkI4cWFubmdLNitKRGVCSU43?=
 =?utf-8?B?djJvT1VEanRvaG5PbmhuZnZyL3NlSk9nVVhYYURSTkZxTFJBUkFBZEFHWVFs?=
 =?utf-8?B?RmplNnEzQmhlWXNvMnA1OFZYbktjdm1YdytTVk9xNEFtS3k0SGVNeTY0ak9W?=
 =?utf-8?B?N3RVcUZJa1hUaE9DS0ZBYjNsSlhjM05HcU1ONWtpVEFSaGxNWGhOOFBUVW5a?=
 =?utf-8?B?L0hkeURjRUszT0RObE92NndnNFJuK1JIamY5cCtiWUJ5VmJubllGeFRVVm9E?=
 =?utf-8?B?TWFDSkNlekdBZjdZT0xsUnJEZDhKbHFzNTJtRDM3di8za0tZTHp3MzVmVzJt?=
 =?utf-8?B?RURYeGJNNG9pcGp2T1l5R2tDUzNyOFFwb0xwMHNPajA4R0UvaG12YXhqUEll?=
 =?utf-8?B?bGhHajdaUlRzbzBKc2hKR3BxRHpBUGlwRmwzUkFDZDY0bVlZUVUydlV4NXFp?=
 =?utf-8?B?Mk84dS9DdjNVSWZKSkFMakxLR3pPUXVOQStzNXJQRWUwSDdRdFMxNWxCM1ZY?=
 =?utf-8?B?d2p2cU9DUWtqN3poL3pGeEtWQTJtZFZBSWg2U0dodUhUQmJCUDVSSHFPSVlP?=
 =?utf-8?B?enVOdVBWMmczK25Vb3FjZTZnMDNnaFh6bHlyUG0zZU45Zm50YUQ4bUlrQVdY?=
 =?utf-8?B?TnVRRkxNRmVkY3RoY3RxR2J2dkpqdTJTUkovVnd3QkVjcFo3RFVXQmJHQ3Jo?=
 =?utf-8?B?SHN0Y2ZNbzZROFdGNWdPNTdEb0I0R29PR0dhclpyZFBKVGlZV2dxUVdaeHgy?=
 =?utf-8?B?bmVxZ2lSZGJYaGVrUHJJY0ZkbHVDWmZ0OTFhQW9ma2dyN0dPL1B4ZXhIYnhr?=
 =?utf-8?B?Vm4wNXkxMk02ZFl5UndXb3hnRmkzcW1TeHhtT1hBdXVWMGxWNWpEZ3FkUkxo?=
 =?utf-8?B?VWF4UktZcUFqbXVrY0p0OHVJMjlySnJGcnJ4cHBnOXF5UzM0TkdCazN3cEhW?=
 =?utf-8?B?aHpiYVpJWmx6SGYzdjB3dEVlazlnd2pXbGZ3cDIrZjBUNW40a3BMYTE2cXlK?=
 =?utf-8?B?VUJFUk41VmVVRkxKbVViM3RQKzEzM3MxOWNraWN3T3Z2WjhLWkhCdy9OVDNv?=
 =?utf-8?Q?OiooX54LdhzATrMp1ofVhq5MYs/CKjyegUNYk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6886.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFhWNitIMy8rY0UzTlJIVzdrOHU2bmtKdGVsSldFQ0dpaXJsWSt6MzhZTFRP?=
 =?utf-8?B?VzVJRTdERDRpQjJjc24zV0NreDFtb3laOW4wWjdRUU92ZzZmRVFFYi9YYlp5?=
 =?utf-8?B?UUF6Q1ZBNEx5ZG9TL1BKUWN5ZU5vUk1GaWcrb1VZdVBSdEpZU0lia0FtN2tD?=
 =?utf-8?B?TDBDdzFQUzU0aHRhK015SXVwbm14bk1samJOMFZlUCszMDBVK0dZcXBOSFBV?=
 =?utf-8?B?VzhVM3ZGR055U0tVL2wyL1FjUTByYkhaTHhpSW9FWGJiUVYyV3dVWlFSK1l1?=
 =?utf-8?B?NkdLYzZIRmxYOEd3WE5qelEvRDAyNHBPcjhlcUZyTEhCWFk4UmoxL2V6cGxm?=
 =?utf-8?B?YXcxYjdGVm91clpQRzNRbkRFZVhCM2kxMzFXd1kwU2dWNE5sMWUwaWpNM0RL?=
 =?utf-8?B?dGlzMnZDck9QMnVnTmJhbmJNUGxqVFc5d1Bya2lGaGFnUUlHSXhTemNjdG1p?=
 =?utf-8?B?eCtybHAzR2lMK0VGVXU0eWZjMSsvV2J0VEFiWFZobjVwRWNubXQ0NHlINFJH?=
 =?utf-8?B?UWY3cVdWcWNwT0Y4bnZxZ0dmRXJMRFFiWXNYa2ViZ1lZd2FnYm1KV0p6NlFl?=
 =?utf-8?B?dDNqRWVhSC9DT0p4dFJITWhCaHphVVprUmtIanQ1aXQ2ZHJPTk5IbGpVYi9w?=
 =?utf-8?B?SGxzZmlYaGYrUjMxY2QwZnVEL0VtR3lZR1BzTEJkeml6SkNhSkU1TUtGY2Rw?=
 =?utf-8?B?NE4zK2Jhc0JOYXUyTEVYS2lIc1lORFRDWWFXTWhWYlFYRk1kSTJIQi84OVgw?=
 =?utf-8?B?d0xxaHJwTEVmRi9CcTV4eTVxUEdaNTI5STRzQkw4QTA1ZXpHRk9pMC9zOTln?=
 =?utf-8?B?eTF2L2xPWTVORS8xT0JncWlLcXNYN0tHWURmVGJxSWpTWXd4WklydkoyMWlJ?=
 =?utf-8?B?MlMycEx3NDVrSW9YNGQxVnpKOW13OXAzU2EwZ1BCYTJlOEYxSk05bVNyRHpF?=
 =?utf-8?B?a1FrWHJYWHR5Y0p0L3Y1YnQ2WmllNmR4VlU2ZGZ1NnB6L2hPMkI0RzFjZmpw?=
 =?utf-8?B?bkh2azFOaHZ5YXNVY2RBa3g2cHU3MFAvdXhab01rQmFsM1NDUlJtSkZkMFk1?=
 =?utf-8?B?Z2VSN0htNXY2bDdiTEJMTXI0M3NvSnQ4YjljYnhnOG9LYWkwSkU2UTVlMzBS?=
 =?utf-8?B?ZkVuSzhpd0tUMDhQZTJmbXFIcE5WVlhUOHJ0cVY2N01KZytXbU83REFnSEt1?=
 =?utf-8?B?NHkycjVZMlZUTU5QL0w3QVRwVEJRNXZkbG9lWDlERjBISENsUTVMTHlQKzdi?=
 =?utf-8?B?K1JKNzgrakJVeG1zWE8ybjhtL2JCTDZjcGRtWjI5aUFoKyswRTRZTFlSR2Ew?=
 =?utf-8?B?NVlMTHFPRDJBK3BuakNaUnl3V3dlejB2ZmpHUTlOMElrRGpqeURLWWRRdllX?=
 =?utf-8?B?WGwyU1pEYzMzMnlSRTFFNjlQYUlyWS9Rck1mMG5kNnVsWEtLdWZZMWEzM2VS?=
 =?utf-8?B?aC9YWVVVTjV1UVFhS1QzVnp4dlFad01HOFNadWhCVGhoaTFxcUlnd0lMNGQ4?=
 =?utf-8?B?Uit2emI3SHpteVhXVFNZWG9NMDQ0akFmcXYwam1Cd1cvUHZVREk4THFFUVEw?=
 =?utf-8?B?S2Q4ajBMc3F0eE9XNVRVQjZyVnA2NjhwdjRlUjc4dE1SaEVIRWkrZ0RDVTE3?=
 =?utf-8?B?NG9GUmZqWDRXYUpqTTJTM2g2ZEYySjFkS3JUYm55ZlpjaHRGNDgxM2g3SU5J?=
 =?utf-8?B?ZEJ0TFA1S0YzQTUyUElaczE2VnZiNVhXZXdHNUlyT3hEOG8zZWt4V1A5Y3JY?=
 =?utf-8?B?Z1A1NTBSVndQOGU2WDNJWVhuR0hsY1k0Mno0a0tIZGxSV2kzckdxanNwc3dy?=
 =?utf-8?B?ZUFLckJnSXkrWUdpdUNzQi9Bbng2d1pMTDJYdWJ1Ty84MVA5UnM2eTRyb09w?=
 =?utf-8?B?azRnVjZsYmtJZE9yMUp0RUExYkpTRzlpNjgwWGRBcEo0anp3K2FLWWpNWUtu?=
 =?utf-8?B?Zm5vWnV2VmhsWDBDUTlFejk0NnNMY290ZWFwUFhXSkEvTjA3NVdIQThNOXI4?=
 =?utf-8?B?Z0ViQnF5WG1TaDZ0aGJVNk5CbS9rUWNiSlBvbzNlU3ZPeitoTnJ6elFqYzhZ?=
 =?utf-8?B?ZXVXQmo4YjJ0Z01VRDE0c2xDL0w1cU9tNW5CcFh4UnFLZ0xqZ3hDUXZCVmhs?=
 =?utf-8?B?b2xXTlREQnFVd2Y5VURaNEF1ZGY1Z0RCblBsTE05QXNNMldPMGgzamkwZ29G?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	otJPDfnmsRp1aR+cfqT0AQStplpatIfohpWotKdhTBO4gtWMVtPbafZqZl3WctAwEDo3E0deCU3VTMJzdKMXAycZUMADGihWYGDOf6LaNlIJDNpauxF7eaNeyc0Eb0p1yFDNvwUF+WOIv+0izneaIx/EuNfWtz3WOMPMyJhXuc9zLe4TA0H+bjcfkSFDXcYUfIy1Npe018sjv4PVokIGJr3LfzJ6pqXspeO0EUZYhJX10zAGpi2AcXRJxaqWYvBlAUfFtFIUT88/k86m/A/25zfNMvTxKsQFF0vvFNcKjViaO9L50vUi1XhvcafGdc+8wAVpMFF68h7Pwt0K0BfuymiVJBvgiatKGoFyIpA7YAqRdSXITgfHFRIcKYfYpD47uV4f3gSx8es3DpHYmR8LIOfjOTsb9VGgPKbBNknnYdnBecw0M0RjsaOeTCy/liBO/13U5mr050+d4MayjQ1tEZUJWxR0U3aVRrgUHjc/5Tm43oIMgqB76qDAocrOwHv4FO5cwv9FVU/w25LJAwZR/mlcgFV8kDUkiekU33V1wiE10sIuDMGCoxTQ2MOrnudNRQ+FXcEpLveCliwyQzuxRKxgOPZaAw1rGfgnaiF5bbE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93717790-a881-4b69-6543-08dd1b633c23
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6886.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:45:18.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6pWs3LDvYStFRptf+NuuEKNhAp8K2HTLnzQ3B4SQQuLYQNbLhpHq9Hj6iR1jHehG4kUpGj/DQQqhvx/dU1LK+b3c7SyOGAgwVT47wnmFR95UCvw5Fw3il4bOfGFImm8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_04,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412130074
X-Proofpoint-GUID: ezSV0wU1LnfLxMNwt0vjZ8uDMzA3DGQd
X-Proofpoint-ORIG-GUID: ezSV0wU1LnfLxMNwt0vjZ8uDMzA3DGQd

Hi Guocai,

On 13/12/24 16:01, guocai.he.cn@windriver.com wrote:
> From: Ian Ray <ian.ray@gehealthcare.com>
> 
> [ Upstream commit bfc6444b57dc7186b6acc964705d7516cbaf3904 ]
> 
> Ensure that `i2c_lock' is held when setting interrupt latch and mask in
> pca953x_irq_bus_sync_unlock() in order to avoid races.
> 
> The other (non-probe) call site pca953x_gpio_set_multiple() ensures the
> lock is held before calling pca953x_write_regs().
> 
> The problem occurred when a request raced against irq_bus_sync_unlock()
> approximately once per thousand reboots on an i.MX8MP based system.
> 
>   * Normal case
> 
>     0-0022: write register AI|3a {03,02,00,00,01} Input latch P0
>     0-0022: write register AI|49 {fc,fd,ff,ff,fe} Interrupt mask P0
>     0-0022: write register AI|08 {ff,00,00,00,00} Output P3
>     0-0022: write register AI|12 {fc,00,00,00,00} Config P3
> 
>   * Race case
> 
>     0-0022: write register AI|08 {ff,00,00,00,00} Output P3
>     0-0022: write register AI|08 {03,02,00,00,01} *** Wrong register ***
>     0-0022: write register AI|12 {fc,00,00,00,00} Config P3
>     0-0022: write register AI|49 {fc,fd,ff,ff,fe} Interrupt mask P0
> 
> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> Link: https://lore.kernel.org/r/20240620042915.2173-1-ian.ray@gehealthcare.com
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
> ---
> This commit is to solve the CVE-2024-42253. Please merge this commit to linux-5.15.y.
> 
>   drivers/gpio/gpio-pca953x.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 4860bf3b7e00..4e97b6ae4f72 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -672,6 +672,8 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
>   	int level;
>   
>   	if (chip->driver_data & PCA_PCAL) {
> +		guard(mutex)(&chip->i2c_lock);

This wouldn't compile on 5.15.y

We don't have scope based locking backported to 5.15.y.


drivers/gpio/gpio-pca953x.c: In function ‘pca953x_irq_bus_sync_unlock’:
drivers/gpio/gpio-pca953x.c:675:17: error: implicit declaration of 
function ‘guard’ [-Werror=implicit-function-declaration]
   675 |                 guard(mutex)(&chip->i2c_lock);
       |                 ^~~~~
drivers/gpio/gpio-pca953x.c:675:23: error: ‘mutex’ undeclared (first use 
in this function)
   675 |                 guard(mutex)(&chip->i2c_lock);
       |                       ^~~~~
drivers/gpio/gpio-pca953x.c:675:23: note: each undeclared identifier is 
reported only once for each function it appears in
cc1: all warnings being treated as errors



Thanks,
Harshit
> +
>   		/* Enable latch on interrupt-enabled inputs */
>   		pca953x_write_regs(chip, PCAL953X_IN_LATCH, chip->irq_mask);
>   


