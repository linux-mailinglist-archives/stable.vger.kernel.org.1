Return-Path: <stable+bounces-244783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qE3ND+f+/WmklgAAu9opvQ
	(envelope-from <stable+bounces-244783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:19:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C067D4F8938
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41F733046CC5
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67653F9F39;
	Fri,  8 May 2026 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Q0BpvZzr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81D3FB7EF;
	Fri,  8 May 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778253407; cv=fail; b=f1tKZhCrOn/Fsd6dx9hqF83Gj7qDBDTb2ZJWj2yV6FAmm6/BDW2T5Olt3s6fqcQOmPzCl4PEfLEsjvb3IiWbTNUP7l6LDwbHKDNDrre693sU4qgRt1rXo6x4DoMFfI2bT1AGJfoiUBpYMV0mQml7fhTpOlA26UvSjPhe5ktZBvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778253407; c=relaxed/simple;
	bh=qTcONwF96iymUc+GCKRE+hZmtjVNmVMqzlAeA4T2hmM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Alxtp24OhtO4TxHWd05jc81CHEpbjYPlbS8Hfp7md0gBKKwUpAhWKJnIaZhrZjSQDXBpwJQPj7mHAi44SKaMLg6oojbRpq2CfgwYe3lU6YSp77DqnBXj/hHHRiwyPO4DGoShRndAGx8RA/GofO4KByhkKAURxVmX9S6Tx0DLdig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Q0BpvZzr; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648ETZYK2514827;
	Fri, 8 May 2026 08:16:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=hWIiPP3Du
	4ydz4SOJR2h9FJx06XphlpAMktsdgTb02k=; b=Q0BpvZzrcQ2SIoX0PmmUyj41F
	lUQ8/31drF2Wvm5uSum/Vfxb11XSiz/G7kinKFOyQFfzZJMmeqShFnZmam+w17s1
	22uCnhSjTDDivdxuWvdUkd5p/qb0jnEjAdp6TupNl1kXdz787zEFt5GipUMNDCbT
	jLH5GqC6C4FZR39HDDKqyMIWVQjkmsa76FTVPEsIbnf/ZxFb5/75HH6942+4cwnj
	mQ6O5HvyWBfjUKKRqzl3eqIiH1q9IHjVLeuKTD/pMf1DSCCbKiRnpBwLd4REo0TI
	bgTWKu2bKDOs167USKjqR+G3n9s8IVJIAV2XvwF2ZluNwHyv/lyNtw8tbqItQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1hmn0292-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 08:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMM/6YX0hUr37AH5u53VH9o6HsmaEt7wCMnsfHE76b+s4iDzN26SwwMKTL9+WHoYy+3XRCDuEs37P672TvSpPiC86tBY2/DaUAl2A2v/zlZbbUH7E4EyXtHtOcqedmY9Bzoh2gOhJduPzs8dRDOItaSyFVFtAvXDmUjbbWRialBfiMvJoJ4a7TUKDNHeGBU0zZK5Dt6qMXKyj6WqcBVl8YgUZPMgqvDpimLlWfi41BNWUK1OldXfO8TGyfsOx5DUuKI/uG14ToTgQxeEAb7aGBVSiiynsifDQs3hLtqDsBifWglaQPr3VIX6Yi/ZiC5t3C63zsVajekVIBVLKticpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWIiPP3Du4ydz4SOJR2h9FJx06XphlpAMktsdgTb02k=;
 b=jiqAGSKMrnem9MC9jpZ5F5uRCR+huaImmcUlCOZTO+dtU4/4qyxaWK2D43P08M3lndP26CkgV4d8016dgxX4zStDnSqA+fzOcCG9X/rYxo82y2+VQQIRvX97Qj4wVS50aXTt6uQO20JczaP3vL9zWCjSrnKSPwAksuUEVBsZvum/kz0ggf/dT1eD+fcnJF6UGhCFqJ/AxL2jYE26KLzY4k4VKEkT2y2a24OpPw1BsxK259A7DTtpBb0p+OmZIQ5R4fH40raiMOGDOBlwMAS0cBXHVU/qrryQkBDbblIxiGA3xMXEsS0tVvf+AzT40hQsHO8MnhAFs56HrDqhtPPQTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 15:16:19 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 15:16:19 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, linux-serial@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, ionut.nechita@windriver.com,
        chris.friesen@windriver.com
Subject: [REQUEST] Backport 8250_dw BUSY deassert series to 6.12.y stable
Date: Fri,  8 May 2026 18:16:14 +0300
Message-ID: <20260508151614.498810-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::39) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0c39ec-60ec-4a71-7404-08dead14c187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X352he3djy4Ox199YGyd0aTCRYqUPgDrNRgPX+ANnFjymsNFEU50Y8Q3K5H6DpSLtKqr6kXIJhFqKfSwywgOLwk108nMkb2m01OSx6A8+D71maRWXkONtyCpwxvy5vJ+fEmR7XuBjqJTioJpbKRKYjDts37HcF+dD0TmEZh1Gsud9JtqUWyNP4KyrxF2PbTKGTDJfbR+v3aiZ1SaS+a1vJUfV/m+kp2Nz1xjVCjjmC/YU0eySuj4mUSVr6G1+yDxbnW00H6UlJ6IeVkmMyPbhFpFdfQbX/MKtliNDQwO8cPiADjQaR9kP7xzoD3VA1NWHV2QX+deHj7w7RNPnBBxQAN2PLa8G0bq2tBFGooVplHs+31xpbsqyCrfzntgBYY97GESv1fBvmzV+udAFcGZY6eE7Er8hX9TtnLFbC/8kTqHnXTIg7ErhdEHAKm3YiqZ6EKlq7x01W9O5GLDO9O6Gb1xrRXExyOpFirGH17muZxGYoQs5EOoS+VpTP0tmB52t6IJ2HUkw54s08MXu7Pgfh/Z4dqlUpZuUDTPXOYSWbdDZDDf36oelGoHBRsw7d9JKDaGfbMkSBoocbA1u2ycsTMvvHVYlvzYqxIzfJp+xlYyF2D1udBFXGjMoZ7y1QuNO78v/WYenM5E3DSmYHmmVQjsPLnLG5ESBgrZbEka0BxSAT2KGIuJuX4+CSCdcn9K3fzDwGIzS6nhbmduCp/qZ+OtpfI2T2sVfijINdX0HhPTyhe0gHartXw930NC7qj7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0JYOFFySDVUMFpJVW9ISjRVZGd4ZmpOSGw1TVRyZ2hpOTQwTFAxUmNzSUxy?=
 =?utf-8?B?VlBEQzQ5LzlTbCtscG1mb0Z0SHBJYmdFSlRtYWRWOHVlM09rZlN4RndiRlcx?=
 =?utf-8?B?YytKaWlBdC9MRnFINGQzMlpLK3RnMUdCc0xzUHZyS1R6Q0M2T2Y3eTFBQ1FN?=
 =?utf-8?B?MDdPOWxxRWRvWDczc08vQTgyZDQ2MEpjVDY3SXN5WWRYVWw0RHlmTUNiYzQ0?=
 =?utf-8?B?OU1SWUVvOW4ySVZySzg5MjQyQ2w5aVFobzJVdnJ5Z0RWWDExaldvZkVFNGpu?=
 =?utf-8?B?SitVMURyelM3M1BPUXFwVkU1WGJDQTAyVzBkK3AzOCtYSUdPekgvbGQzc29w?=
 =?utf-8?B?ajNZZjUvdDAwQTJjNXJkSWdMQTlIUjM2V0FHR3doazIxV3NEVjJBVVVjUGt6?=
 =?utf-8?B?ZkVUOVA4N0Zxdnk4bmVYMkZVMzV0T0ZIWkFaTnFKOWJoaFROMFcxWEhzN2Fk?=
 =?utf-8?B?dXZ0ZDhhcHZ1M3RFbjE0Vm9VVGRWWmI4SS83RkZPZG54L1Vnem53djNTSytG?=
 =?utf-8?B?c2szK3NVbGc2NVc5Wk1xUUh3aWYyVVpldE92N3VoNUNIQjBwL0dzSjZkTFIr?=
 =?utf-8?B?c3NxUGZ4V2gzNHh4NEg1bmh2MGFwWTl0c2JNSGcxWkhhTXBOSnBxVmdsQnNQ?=
 =?utf-8?B?S3ViMWh0MXpKSUxjdW1JRjA3d1RSaDBJTEFNYXFwY1o1eDFFNjA2Tlp3WWFY?=
 =?utf-8?B?M25uM3FTOEU0b1VwRTd6SnQvN3FidVNVd01PTzVFZ1VBd2FHZzdqTlFTM3Aw?=
 =?utf-8?B?bzlLeWNySk5pZWtEc2tGOHhqdFB4ZmxPdmJYeWRWTUkyOCtEWTZWTDlWcTJn?=
 =?utf-8?B?aFRFdnZKZmFNcDQ1WVBBbEpmODdMbklsV1ZsV0Q2K2VtZ245eEo2TmQybVZt?=
 =?utf-8?B?TkpiSElmd1lJdS9sSXltWnRlQnVnazNYa1JvYzZhUzl3eGlUa2JKcVBscnFn?=
 =?utf-8?B?V3h6SDB1dURtREE5Zm0rd2ovc2hZZXAvaGRUMHpyL1Z4N0hUZTNIWnBGd2hw?=
 =?utf-8?B?TUxpSk9TSTlWcmhuYXF5M0F2ZG9tUFhLUWRxcHNiOExFUW0xQnZid3VJbGoz?=
 =?utf-8?B?ZWxFNnRjR3I4REdEaXcrZThZQ0VUS0gvSE5rYTJuWnRvUlRKQUZMNkRMYlVT?=
 =?utf-8?B?WGV2Q0tOTXliT3hraTlaNXNwYU5paWF0TDd2S01teVFvalNsbmcvbFRudVJk?=
 =?utf-8?B?NldwZVNRdW5vdmdNU254YndrSkh4d1pOSGEycVlOdjd2SWRyY00yNEJJc1d1?=
 =?utf-8?B?bWM1RVdPTitCQ1d1dzhXK2h2Vmt1bC92cklNRndsMFdtd3ZWaDRJOU1zR0V2?=
 =?utf-8?B?N0daZjVjSVN4Wm5FYXMxS09Kdld0aSswMUt2bGV0WmpYemZQc0xUeUtkUm5r?=
 =?utf-8?B?YUxjQ1BrcVhkU1FoMXduajBEMkpzamxsUUcySmkwNjFuOWNDd3Vsa1lieWZP?=
 =?utf-8?B?TFhicmllbkhIQnY5SXM2YXFuWXBkdGcwMWdGN1lkeVVnSjJaTDhjK2Z5a1VV?=
 =?utf-8?B?dUZybEJQU2g2bytadDU3Q0N5WitIUXJBSUlYK0xMMWdnMEpwb1FRT3FGdjIx?=
 =?utf-8?B?K1M5dHcxYlVrb3h2UDNjQnEyWTMyTXd3TUJsbS9IKzJTRktlSVpubWV5a1U3?=
 =?utf-8?B?c1BoQSs0N3N5YTFOS2UybU1jNFBXaXplODBSKzNlbXhBWkJUZ1FOR3hKTUNy?=
 =?utf-8?B?WTlLV0d2KytsWnA3ZWZvanY1em1xN0VsdmFaZXZWMkd3dTNiUkNnSVltUkJ5?=
 =?utf-8?B?L3o5QWo2QWNkNU5heW00eXA3R3Zzd2pwUG5PSU1ZbkozVjNIVzNxVUFXRVJF?=
 =?utf-8?B?cTF0S1RZK3hZNzJmOTM5Tmk0UW1NdTk3SjNzM25xVFBQZnJHUmdWVzdGdWgr?=
 =?utf-8?B?a29zOCtWeXdoVlhXLzk4b2pzTkcxOUNOSElkcVc2d2xJRlBYSnRMazBDUWxO?=
 =?utf-8?B?QTNoem5tbWxkdjFpdU43ZVl6WGNUS0ZEQmtwK2hDNnN1QXJwQ3R5RkN1cHZU?=
 =?utf-8?B?SnpRL1ZZYThiMTZUT0lsdmU2QVpVdmhRU2ZYaXN1MmswY1ZnZFlKR3FpT0FR?=
 =?utf-8?B?VGsycHhoVGlUcGxZeTJjNklveTJxdTZQN0ppNGRrUG16VFJpZm5HZ0RtSGMr?=
 =?utf-8?B?MjNudWhGMEV4Tm9VcWlYM0Q5NXNRaytKdlFKSjZ3bCsweWk3aE45Rk9ZVjNQ?=
 =?utf-8?B?SEdmd1BxZkJRYUxlaWNrdFZpcnkraHJxalNWNWxRMkNOSHF2S0xyZEQwck56?=
 =?utf-8?B?QVpPKzYxb1o1bTlxeXFZTHhkbmlBUHJYMTRwS0RNRS8zdElJTUFjaUg2MERt?=
 =?utf-8?B?enRQbExnS0NDWVlHNFl2eDRhWkZubjhGY2lNTWE3Y3pXSGpVV3JrYkNRUDVz?=
 =?utf-8?Q?h1coCcF1ciZV/tLQ=3D?=
X-Exchange-RoutingPolicyChecked:
	YnyeaQBC46xiu3xBmi7TQIY37JJ23KSyU3XNUAqbYAHJLEw2zRN89NlyOCKxRGlOINNvDP/2opavqUGef2To7dZACdlZEUzzNPzCGRWj8l25mLk11g7e1TBnqz5kRImK6KHkGGsDIxsxPIaVZAmkqnQmDH1HIDDI864EL72uic0hjKEwHKAYZHJAjBBMb6qlfZTD29kjKK0cmEGZbj8ZWXVvNddHwV8uCq+Fr/YzKui9VT7kehl7412dVwjLWFn2XRAroEOmkBiKu4RuHxoK2dE3V7aEG9Qu/aywaYIefDUCvw2wdbyoBDqEq9RwR1+jRh+lbIY+Iu6FaCtSQ+S43A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0c39ec-60ec-4a71-7404-08dead14c187
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:16:19.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0faiPcXJMPyoIlCZF30BDax2ZDQcQuTvtiPvDX3UpyHBoaT/JQKAi7X6nTVRFixOmUzcTi5mZQxiWCggfcT+ILnyppzFR3ufNn2IPX2PFvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1MiBTYWx0ZWRfXygAplH9NWQpu
 IOEOqac5iciYINEJr5EeUC9qYxDwU78b2Uj5fZ2kqI6DBKZOtZSQGsL4THPnW6shQ9DQY7pBor+
 dPult7JA4nKz5VaeSpCAWTDexm+uCVvZj+Y+VCpkzsDa62iOHpQCG3Xv/NEBeVyhA96ZaVbPasn
 vjNxAGiuhIPfUkAz7MPbik5flo2Ub6LfHzG+Og1fnImNlpxKuafno19rrom6iS6eCVglZUIob+O
 /n7KVLY8zaej62z7cywwgPE7K0OBBdu3LL2fwBTRmtbXRCWfr74+opWARYMKnsFe0EIopBp8MHL
 W9dYV3GdGS8Nran4daHDN8I35bQPcsr2VyrirPF1Yk2vpKwQqFu5I1mrHcJgaAzx9LZFnlVMHQc
 dImYGaeeJJhaugt1pYngm0GoPdh6jq7j49KBqnhs4rSoAReacuyuPd7QUOF4xZa07aNC5KqOU2B
 TcEcXKsgJ0kFj60hwKQ==
X-Authority-Analysis: v=2.4 cv=DsVmPm/+ c=1 sm=1 tr=0 ts=69fdfe46 cx=c_pps
 a=5XdDR3/zV2dQAmk0xmzXVw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=t7CeM3EgAAAA:8 a=0MlOKdgn0ep1pOAb65gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 8_g32nIaMS8vEgiWNd3wyq2znJdZFPqy
X-Proofpoint-ORIG-GUID: 8_g32nIaMS8vEgiWNd3wyq2znJdZFPqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080152
X-Rspamd-Queue-Id: C067D4F8938
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244783-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Ilpo, Greg,

We're running kernel 6.12 (LTS) on production systems with DesignWare
8250 UARTs and are hitting the BUSY assertion issue that your recent
series addresses in 6.18:

  Ilpo Järvinen (7):
    serial: 8250: Protect LCR write in shutdown
    serial: 8250_dw: Avoid unnecessary LCR writes
    serial: 8250: Add serial8250_handle_irq_locked()
    serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
    serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
    serial: 8250: Add late synchronize_irq() to shutdown to handle DW UART BUSY
    serial: 8250_dw: Ensure BUSY is deasserted

Patch 7/7 has Cc: stable, but it depends on patches 1-6 for the new
infrastructure (serial8250_handle_irq_locked(), the reworked locking in
dw8250_handle_irq(), etc.).

Could the full series be nominated for 6.12.y stable backport?  Or if
that's too invasive for stable, could you advise on the minimal subset
that would allow patch 7 to apply cleanly on 6.12?

We've attempted a standalone backport of patch 7 (squashing the
necessary helpers from 8250_port.c), but the IRQ handler refactoring
in patches 3-5 changes the locking model significantly, and we'd
rather carry the maintainer-blessed version than risk introducing
subtle races.

Our environment:
  - Kernel: 6.12.57-rt/6.12.87-rt (PREEMPT_RT)
  - Hardware: Intel platforms with DW APB UART (snps,dw-apb-uart)
  - Symptom: LCR writes silently ignored under Rx load, causing
    baud rate / framing mismatches after set_termios

We are available to test any backport candidates on our hardware.

Thanks,
Ionut
---

