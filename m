Return-Path: <stable+bounces-152183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A78AD278F
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 22:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E99165373
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 20:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD4A1CF7AF;
	Mon,  9 Jun 2025 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LM09U93u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EhUXLu7F"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94194F9DA;
	Mon,  9 Jun 2025 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501030; cv=fail; b=mpYXS41v2eF56srEu8xUg0kLd8HToTTfPnVixlOV6kp5xopyLDSBfrMoQwjw79MaKfy35SQ6DSHn0R2epJIwIZoCow0HeRfYbzzWc5kpDjlG/4fJq24lQpwCq0+wH0jKLOE/OzQqZqCbNXBDGq1tKf8BUz9GUa720LzR9U+kDMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501030; c=relaxed/simple;
	bh=0CfYJE3jLikQa2M+kG88pCH1XCmgK/0qlshlWO2h0J0=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=AKjd3tuEZfQM7UyXG+8hYQRKp6daSfjv924SIR5FuIAGlUMI224ffcSU9PEWF4ZVfs6fnXJSjdebiotgIWO57w3OrXXMC5JDL51e95oj4YX4rj4KrRcAZHosTJgplA5kCpkTgZy8hpKnQwxxS1Yvaz3IOJ9fI2zkxag5fh66oqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LM09U93u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EhUXLu7F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559FZf7S011928;
	Mon, 9 Jun 2025 20:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=jER9YuBOJpSWKgau
	C+nxEgtnUxu0SoV4mheeaJ3doEQ=; b=LM09U93uil5VLalotuc5X0Ly7f1etU0G
	Mc+EKLvFmLoV+SoGesnSU0DoqbrsNo7d6ntG9g6AyJsl6Sj+9ioydxGisG61K/VK
	6HW0JSH1FBnp21+KOUgmOv61p+YdBQP1SWtEDQNnY95ZTMJB86p4GU1ogkFitbjo
	grBTBvKYpP1WXxAOZeh/4J69yTpiL3LsAeGR0GB1G4Jeqn4L6KIoc9UD6ErtML4x
	9g5IeK/n+p9Fv08I/xSf0G3zHjzwnMR1lu2DkWSsTPlqcF5Mq4aXOLtcZupNIEJF
	Ji/QeLMfPUzXBPwP0YeQbOTW8+jcdx78vf+rbncUoP8NAYpysNKD9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbeaxhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 20:30:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 559InoB2003273;
	Mon, 9 Jun 2025 20:30:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bv7vpp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Jun 2025 20:30:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKU30Iozq37tvMmYu9dTrDFrCN1OjhLRD8Vb90cijYweGCj3bKI3Xz9cdeHs+NrG8eaQ49GWUvOZdTFc3SgERQnuKN6Xewe7GLsGgWyipXhyrDG2zJ5I1vP/3KrdhkBULEdjp74Shp32JgBPBed2og5i0tIr48Tf0SROQvSCfBOpToUvq+LzyBW/JdCJCsEfu9kiFi01RcSplt1LzCF8w1bbZl1RezApiLRdaoCNxSIrQ4N4KEVK4hwOGY46nOMUOcdjw1+NmON6aoh5zFSf0+vDINexALk1eBC+Fs7s08LoxzRQwwr27nkGlIt68CziozeZiMSFqFG8BMCABrkjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jER9YuBOJpSWKgauC+nxEgtnUxu0SoV4mheeaJ3doEQ=;
 b=u5tlrDTTpZAgB3Fa4auW37DzmWaNa9jz46je6LoYyLj4l9KbDM9NyvBk0vHzzeaq/Hc85bi+iKcq5QInEpxbbdxuASYeA0WEf3OuR4bwBhAur+3F2taiztS7x62saa6R6N0qWTNo54cL6OvmgB19U77B5HUaE5NrxwKkTjlxNaf7qUhR6TqnjvaX3cKi1d1uBrkF7X9Wj9veWrjyrOmqAm8o4gO4I4pEhKJ+WlujCo74ZnbhxgHgS9DK8Qqv/iJVOqwXtoBE87er16BOdC+G0QRhG7VgmBvmqRC1OHfUmXGJpdFHusQ3WZ6dsqTgOmrMf8q/B8L9ZGwNW2J57XYklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jER9YuBOJpSWKgauC+nxEgtnUxu0SoV4mheeaJ3doEQ=;
 b=EhUXLu7FQ9eb9axusUhNATTKvHBdeOb+A6H2228CI9SeustwcwjAl30YA6JPisDpBN9NInIu8wb999xj2BhDI0rShC986vHuyvIDPHZXGVPfY9DqfO2n17gNgvUY034m8tL4UTcjuLMieDyvEF5D0m3fdMGkovXCOfUly1E3LNM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:30:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:30:21 +0000
Message-ID: <612fbc1f-ab02-4048-b210-425c93bbbc53@oracle.com>
Date: Mon, 9 Jun 2025 16:30:19 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
From: Chuck Lever <chuck.lever@oracle.com>
Subject: Request for backport of 358de8b4f201 to LTS kernels
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:610:60::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ffca0c-e989-43b4-bfa5-08dda794747d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1E3MWhXU0p5VEw3RFFGUDYwNDJIbWtWMnNGSk84eW5NV3ZyWm1EMDkxcXhp?=
 =?utf-8?B?QS92OXZyNlZPTUIwSHYyRzF4V08xa0pGVFByY00wYW9TcHZHTVhDR0NNbHVW?=
 =?utf-8?B?eGR0UHFRbDlLK0xGbWh3aGlUUlpxZjNOUFhQRCtjU0hoeVRvcVhLTkdXb1pC?=
 =?utf-8?B?YkVERlFBZVBQYjYyY2N1TVlqQktxSjBSZUVzUks4NE9RZ1FwT3Q5U1YvLzVp?=
 =?utf-8?B?cjgyVmJrS1BOUjBTeERKRVVnQ2FXTGFaNmhQQkpEbFc0Sm1mS0FHbVF3UFM2?=
 =?utf-8?B?RkloVkZnSzRrWGhTRFVSeVRXU0JadHd2dmpaTnl1RlpuVE1iNCtNWitSSnht?=
 =?utf-8?B?OHo5OGJMRUY1ekxZaFB2ZjUydzEzcGNTUHdLZ1B3aVNzZ2F0bEZveE9IcVNy?=
 =?utf-8?B?aWhlQ0VHYjY2YlRROGdEeWNJaVIyaDJsMnFMTDI3cXNQKzBjcDllcm4yWits?=
 =?utf-8?B?ZDVRSlJZOFZldjZHdUVtS01GS012R0Z3SlhZeTdGc1Zobzk4K01EZ2tJTDJJ?=
 =?utf-8?B?MEtiZVkwaGg1WkZSajRKR2hKTlRaM3kxcEx5c243WjRtSWNwV0QzN3FnV2w0?=
 =?utf-8?B?cEVPYlNyRU1RNVlYamlRaG5KbEJTUDNEc1B4bTFCQ0xJWnlHNEtUN0xtV0JB?=
 =?utf-8?B?eGV0OC9TN1FHL0tPeU1KbDhCV2Y5c0NoWUFnVFd3VnVScjBMSHNXVVo5cldo?=
 =?utf-8?B?VHRsMFdKWkExN1VrUnhqUkpjY2hnekRHcVhLZ05vUVdCd2Y4T0lFdGZMSnRs?=
 =?utf-8?B?YU5Vc0NQS2tVNHlyWjRaRjhQWWpTbE11SUF5Zkl1Z2FETWxYZUVqZ0tlVm5L?=
 =?utf-8?B?a0dHQU9BY1d2cXphOUJ2eDU2WGNtMXVHV0I2aEZrVXQxUFlPSSt0K3NVaGtp?=
 =?utf-8?B?MC90b1BxRGxWSTRjakREV1JWNXNDNjNVZTFZQXVYN2p2WExhSG56MGl1YkNl?=
 =?utf-8?B?Unl4WmdDMWtVT3lpUU9tbHJrL002elBKNDNKeExWMytwYlhzRmhDYnlRYlJy?=
 =?utf-8?B?S1F2dU9Xa3daemZ6NkhjT1dnNDdHeU1NZU9xWWZIVktRVm9RSVQrOUVsK3B4?=
 =?utf-8?B?Y2dqSzdhQUlLNVBrWFQ3WkJLK2MxQlBVbC8xVFI5THNxeFVPR1FMNHV5WjQz?=
 =?utf-8?B?TzJSZS9wMDg3QVVRWS91d25ZS3FDUkVSZ1NLdWpOTlN6Z2xwbUxGZUpsRlh4?=
 =?utf-8?B?ME1ZS21nQzF0Mkx0bDQ1dmUvWEQ5TkEyVjQ5TFZNWUpDT05ENFViN2YvcXJD?=
 =?utf-8?B?TmdlbzkycE5ndkc3MXhtZTFOc29GTVEyMklhdlQxWHprSUpBa3A3TUJsbmtq?=
 =?utf-8?B?ay9Kb3JTYk5Gc2t0T0Z0YXV0Qk55U3poKzBNeC8yWlN2UktHYndDZCtCOUc3?=
 =?utf-8?B?bS9uVVlZRDhCcXdTK0dRai9heGdSdnJKVkVJTG8vdVNxMFpIZ0FycXU0NENI?=
 =?utf-8?B?OUYvN3Y2WExoNWFxNEc0RXg1ZmtqQXlJL01lM2RLaG9hbTkxdXM4Z3VGNzcz?=
 =?utf-8?B?bmR6R3VZbGNXZCtKQmdSc25Mc1NOei95OGdrNy9qK1poS1N6RWdDaXBNMFJL?=
 =?utf-8?B?RDIwZ3BHWEdQNDB3S3FpMXZjTG5ENTUwNTZHMmh3SEZqb2FrNTd3YTBqUEpl?=
 =?utf-8?B?S1owRDhnMVlaNkp2U3dkUGZyTC8xNXlNV3pIYXoyMzlHeWE2UDV6MXJLeEdy?=
 =?utf-8?B?dlVDUGJnUytZbnpQS0ttbWwyWGF4c3VwL2I0Q01KTk9wRkdoQkdnb0lGaWRr?=
 =?utf-8?B?eEpMN3gxLzhKa1NJZFh2UDIxdUlyOEZ0dmpiSzdaWFoySUc4dzU0NGtLZDZZ?=
 =?utf-8?B?OEtic2ZTbEcvR3BDTWViMDUxL1loUHNaUjg4ZTFEd0tQQ255VlJRYjBFVC9I?=
 =?utf-8?B?bDhMRURiZXU0UkZVVzRjSE9SVUFXVkVJUXpOVi9GS3h0YXYrTTF5NFpuY296?=
 =?utf-8?Q?3M6RIlVc7P8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlVLeVBtOVJSS3hINHFKWnozTk1BOHladlZkZzVqNVVJT3Bxbm5JMDBlb01G?=
 =?utf-8?B?dElXQWY3YXV5UEc2dklINW4xczhXQ2NkWTRpWDEzajcrRFRmOGpJRGhMbzBG?=
 =?utf-8?B?dTRNMW5UN3cxQS9rWUhFalp5NFp6bUIvNFNrK3N1bFQwUHRKaU5GemQ2TWNV?=
 =?utf-8?B?U0h4dE44QldCNnZtUjNJTEJ1RVAzc014ckNvUUdXOUFicE1FQW5UOGt5eXJB?=
 =?utf-8?B?ZmpuL3JYdGU3a2lFajdFdWhOWUFqSmZ3bFhXU0d6aUlaOFJZc1BneHZHZVNZ?=
 =?utf-8?B?UWVuNmhBS1VUcjA4Nmc3ekhZdGhISzN1QUdqamFwaFpoNzV0dUt4em1yM0M4?=
 =?utf-8?B?dWtSMXFYYUtja2dYTjJxUDByNEtLM2dzQ3JuZzk1N2gwK3hDV2ZzTTREZlRq?=
 =?utf-8?B?ejExNkFDaDRZYlN6MUxuUDVMVFdReXhEQnlTNVc4cUZDcVhyOVVpTjlnKzlY?=
 =?utf-8?B?VU9KVG9JZ2wyV2JEd29ORDZVaHF3am1CamRzN3pmL3ZXa2k4Y0JHbHdpbk1W?=
 =?utf-8?B?U0dvRysrWkM4K2psOExCSUFZMWpQeHRWNVVCU3BBaW45MzM0cDFhRWRxQldn?=
 =?utf-8?B?bnREc0JIQU5Sa1Z4Z2YwZEphU3hkNG1WTkU2VmNTRGl1Q2ZMTVJqaEJBUEtD?=
 =?utf-8?B?ZGRNNXZKSysvaHM2a0R2VmlwblROcmFjZFBlaFVaeDl6dkhVNE9LRkFqZmsw?=
 =?utf-8?B?TDhtckh6elRYWi9QNnhyUENEdUZhQ3pEOXR2WDVrT3UzYThlK3ZJV28ya0t5?=
 =?utf-8?B?RXUvdHp2clFncjM2T2tHdXpvcXNubndnZ0ZrTHBsMzZCcGovUTVZOTVKdGFk?=
 =?utf-8?B?UDBKdlRVL0kyamU1ZFpPMXl5dTh1b2ppbExuK2c4ZTIwS2tCSkJRbHJta0xu?=
 =?utf-8?B?bUQvQ2wyYlZWb1hYcHk3bjhidmhTRk1TbW9CbktyYXpGbU1xeVJIdnVpMlB5?=
 =?utf-8?B?cm1TMSs2ajA1OUdLMERKM0RubjdtQ0xyN0IrcGFOdVJuVlBGL0VFMXNYWWxs?=
 =?utf-8?B?cE1ESkwxcUVHay9ZOUpTRWdmZE8xcDd1NGN1T3NodUR1eEtHbzBmckdNeHNt?=
 =?utf-8?B?cXllRHZ2a0NtN3JkNkZ3bCt1YjhDUHlQUkFJaW8wb0E0dS9Oa3RUck54ZzU1?=
 =?utf-8?B?ZVVTR2tqaHUvMHNxM1lLVmNnREJOb3dsTkE5ZnZiT1dtVW9VbkJPRnY4WSts?=
 =?utf-8?B?eWZscjFjUGxCaGo4UWxFaFczajNLOVluTHBmUG41MDVWYnhnVWxwbjMySTAv?=
 =?utf-8?B?RUI5R1lRZXpHdllFeldYUEVrSFN6em5qaGRVcG9EM1R3R2tyOUFzWGZWQXZx?=
 =?utf-8?B?eWRsYkNHZUtrcjdtY1RhSmUwbHgvUnhVVEwyZ2JxNlZ4dGlvRWFWKzhyT0FO?=
 =?utf-8?B?cldlZ3A0dmZVcldvYVpkNnlIZWlrbTB1UUUzS1FWQTkxbFBJOVhjL2Jib1JJ?=
 =?utf-8?B?aExCZ1BiOExQdTF2bER0QmZ3Sm42cmRGN0JuV1ROSkhVTVd4M1UxbjNaM2Q5?=
 =?utf-8?B?bis4bC9rSFJRc1QrS21ibmhISkNTZGUwcDBGc0dlbHdlT2RSMDVsc0ZmNFlG?=
 =?utf-8?B?OVJxRVFyd1NlOXJYZ1R1V3kvTDNkVGVTRStkUzk2MmNEeVhhS2J4ZjZNS1JI?=
 =?utf-8?B?NzBGZXBCOFd1a0FzSU04eEZ3WkZqdjk0YVpmZXpnWWQ3TzN3b2JvZEdNaXlI?=
 =?utf-8?B?aDhSN2tyemRLM3R4MFZhdGhTa205SFlqd3VnRlIzcXlydmV4d1pBTjdjbEF1?=
 =?utf-8?B?U0N0WmtyVS96dkh2c2J0WHhQSkVFQ2NOcWlmdDNHdDM5MGtRZURDR3cwbWtD?=
 =?utf-8?B?UFhMY0toZ3FxM2l4UU9adFJWRmdGWXZ1SjJSNHZ4dkhCOGZLVUZxbXR1TUZ1?=
 =?utf-8?B?QzlJaEd4N0diRk94M2FYYkhJNGhFRUk5VExSN0VFcFJ2SVpsUDZnM2UzenZE?=
 =?utf-8?B?RTlFQmRSbFlNMFlpRW9QZWowZXQrUXp0TVJ3RnM3TnQ1bzFaMHptczFLMElR?=
 =?utf-8?B?L3pCL3V0NWprazFDeWNYTG1sTndBbmpRMEJxblI4bnZZWWhzQkxickFCbG45?=
 =?utf-8?B?Y25MSlJNMnI5VHh5bk1rMHF6WGtObnhsdFZuWUh3bms3ditGaXp4TE5Dcmsy?=
 =?utf-8?B?RnpocmJVRVE1V2ZvdDFUTmx6NEw4QlZvMXBacHhiVXpzZVl4TXJJQkR2QkZ4?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r7Oyjk6NMwmaq78RAjNPkLTLObqjZtO37eIUCxX3OpLU15zUsMTgP9GdCDSF1QGik9HjonI6e7Yuk9aRV8GGqGUSNaIgiIReZG7nqOF3lWKAyLX3HLm5C/wavj7cyiQ8gVO/kod07eJPa8qss0Ps+8Q5o5Trz6xjenz5d8+w+53+A9VotZwuU1YPbE8bXcWdgvlm4OCvfomnBPcaw48s4Wndfl2TLSG7n7cJlodU+J9m4HnAL9yeEE3GBWlNOI6kIw/b0NhFB9+pOG+ibTI1vBnbuErnZbb5VCXc3kbytt1sM1CkUW+l7UIGqvPEoqEO0x58dxf9AktBU5a4V2tLRVpFq+9WR9hWDrQYnZW60KEfCIQiSHKPMMi14FKeTIYt6mAUutDA0ysfHAOizbxp577/uvssF3az3tKgzGb4fmf5VHr2sicgvRvtXnt45Y/+T4QrFb0vh5GH8SSM2ydwsbmGqXvIIApX7wSKOpPn9Ps8u5dr4Cmba+eG8/Z2a6jd4qaHPw7KpzR3o+xqlPSYIPY2HXpFCPY6sLKC0tsY+X/JhD0sfgSg/ptmqzBnMVdbrKr/OnOWtvzl8pJECeo6Uco6cVvq27juYnThfWRrcD8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ffca0c-e989-43b4-bfa5-08dda794747d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:30:20.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DgMSFOFOwEcKkn3z/G3b9CI/4+PErqgDPcoS6v+7m9c2Q7DYJqQL61shk/9hLyC7+7ZD4Nr2x8R40vEeRt2PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_08,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506090156
X-Proofpoint-GUID: 7hbKj4wnirFdMwugddzj3jpmsVM2uq4f
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=68474461 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=qfTAls8ygNILnr04Lj0A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: 7hbKj4wnirFdMwugddzj3jpmsVM2uq4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDE1NiBTYWx0ZWRfX0ZepDN2wl5By 5xvy7dK6TwgLg21WNt4Xt9xQKIadQGdqgdHXB4VM3Ph/+ea20tTmunPLpetwXDbySVIUQEb7mEl uy86fEJO12ju8Vm3Bh9oBm+JRNZu2LcCtQRZ26JbJCUxiUQ10feO3YU1ptoxtGZigXwl3oHxsEK
 7qhfO6+QGpR+Pyf+xLXZl+oi7N25lRy+QD9OPDqd2wVtsPKe07Z1/pu/EQVKFbbp8isJAXiZLEQ nVQWe+pzmpfrJTmlIwxKn4t2Md3kBJLkwtJu1bcJY6rKe+0T34Mfh5kR7034s16j+dZ8UL2iSII UxtZo+QoxQhC9MYuIWFAmVTag0Mo63pDNY2wRL5yYbvIiht4T7ccpcjIWLd2YXduJteIvDI9ULn
 wEO/KmBVptV8Pao3uCoZjIt9sHqCd1ZLiYIZhlRY8zIsRovaNn+BxgPcrIGwuYJmlvfo9a6w

Hi Greg & Sasha !

I ran into some trouble in my nightly CI systems that test v6.6.y and
v6.1.y. Using "make binrpm-pkg" followed by "rpm -iv ..." results in the
test systems being unbootable because the vmlinuz file is never copied
to /boot. The test systems are imaged with Fedora 39.

I found a related Fedora bug:

  https://bugzilla.redhat.com/show_bug.cgi?id=2239008

It appears there is a missing fix in LTS kernels. I bisected the kernel
fix to:

  358de8b4f201 ("kbuild: rpm-pkg: simplify installkernel %post")

which includes a "Cc: stable" tag but does not appear in
origin/linux-6.6.y, origin/linux-6.1.y, or origin/5.15.y (I did not look
further back than that).

Would it be appropriate to apply 358de8b4f201 to LTS kernels?

-- 
Chuck Lever


