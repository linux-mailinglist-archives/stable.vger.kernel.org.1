Return-Path: <stable+bounces-166800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB7B1DD0D
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 20:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7DC18C1BB9
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 18:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4545218BBB9;
	Thu,  7 Aug 2025 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VvIfbIXt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dizxcNfs"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C94C23DE
	for <stable@vger.kernel.org>; Thu,  7 Aug 2025 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591521; cv=fail; b=X+LlT5kLO07TmdQER2pR0ZBSI0MnZ1HW/o5tKx+OxrG+HRdg6pzosEsKgxrAIIT8SHKoCxbEjlXAkNYSrkUVdAhLqs73vXmFbSogs5/IdR5BoBkzy2V35T9xvRvoSeN8hwunDS/pvRfLIDGUUwW3ACX5+GBzwdvr27jFBJhXSnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591521; c=relaxed/simple;
	bh=KBBfSWsb7Rv+pPpZhUABAHbQ3oKSc/EDitlYueltOLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jLkwv150B8qzfw1ZY/K6Uh0zXCAcG64WQy9jdwC8pSiuslrjntzAO0g4ZZIHoFIkMD1JKBNLb8aITPO47cwC+sNwJk8zh4LMwHCXvwqav2h8V6gWBRTUu3Gmvw5hvEHGxgaEf6HfY8oCbStIdfHV6OkDNCfAQLi+8B1vTjf7oiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VvIfbIXt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dizxcNfs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577HC8fx005117;
	Thu, 7 Aug 2025 18:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f1dPPsVYHrOel+PLaRQjaawgj7xegvuUmgRxrINRwjY=; b=
	VvIfbIXtkL2u3fK/CYdwwV8BQUuGMLicnqDOORULgQPzc4NualNz0Dr2jQv0msvb
	xGwQnMWvt/HozFyDOvgG74XIDImgsxZylEs5bOsy5HdXC56Rui7JX69Cc8ENN4tR
	q3MFPt3/qMP3DNig01lP9CH4KgjzhVVC9QSihanxnBhHLScNlkW/ieEeWJY+0bVN
	bzmkpi6eUGoCyPL3K2t3+XYCTBH+XK7UoY1A64t0MSHVfTpP3tNb3Cews5fwLYRx
	+ypkxT2a7YuUysCak7rxWCFers7CmesWVcj3n55J5fFkfD7auVU9TkTGds/Z/Mj3
	b6LNvK1FOYd4qum6EbE4Zg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh4r38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 18:31:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577IEUDF009749;
	Thu, 7 Aug 2025 18:31:53 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwnsb2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 18:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtyVtWWegJFw+z9u33tmzqUVXzPO52b7Cl8aG2nqtW6KWl3DL+O5ow9opXhpjgd5qdAL8HAn46eTMG9xD8kN9AxIVPy6ai9FRprnE6+SME719sW3QqroYh0vHunNA84BcKjldHpO/qdLTzFplDvklYcu1DrIdzBG7CBmfjqsrHX7zrSnioBNBCtC++DgZQlfWylIwg+PKvaTX15/WvC0OjKYLc+dEkZmPZ2P1hgsGvjrrlI0el36K4VakXqf+CaE9O83XsHHQM9KtkNEWijVllALECIpndNGNSvpsaUPZWfiiJXDlsTXoZYC8LwKvAjnNpjz08xP4prOpTVyn6sNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1dPPsVYHrOel+PLaRQjaawgj7xegvuUmgRxrINRwjY=;
 b=oYkPStDbM1y+w5mudK3lz9ALrPM6fF8NSvs3nESf2Sq+h5N+DIO5RB6cxzYvBWj7e/IIJsoj3Pm/sJBvS3/PPsUdoWY+rNwd7TKmXsGchvG7gar31CNeD8f45GdQCpAesYb/ZCppPOuEWHlcT3e77DZ3NCfdvcYkgtbFyanSBBre0usGwG5gGU7iKGeoa+OGrD4+4V553DYEOyTOO7raAcFjdb3kcPKowf6Fs2U8XJEYqTChkG7Wa0kXjOt9W/eACk1jvErO5vNiH9RxMTEcREMALh0GmxRPtQfld41dqHD7r7zTUmrsHA+rqM8hA9FPoVOTfKhNLGQct5sMRjm1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1dPPsVYHrOel+PLaRQjaawgj7xegvuUmgRxrINRwjY=;
 b=dizxcNfswd9Zuo5U9SUxalUaugtjzHDay9BJwTfDlzcG25TBI+2TYvCQRmDaV6cMGcCXQGe0NKF6zfz8fY1/C8V/6l4dQGw9yvt0EIDkX6gWpBohVBzHA+s+fsJgQc2Z+yg1KNTbwbH7m/iNKtxvhBJQ5IMaKZmpob1tPT8trWQ=
Received: from IA4PR10MB8421.namprd10.prod.outlook.com (2603:10b6:208:563::15)
 by SJ0PR10MB5581.namprd10.prod.outlook.com (2603:10b6:a03:3d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 18:31:51 +0000
Received: from IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77]) by IA4PR10MB8421.namprd10.prod.outlook.com
 ([fe80::d702:c1e0:6247:ef77%6]) with mapi id 15.20.8964.030; Thu, 7 Aug 2025
 18:31:50 +0000
Message-ID: <babc8b84-b033-4375-a8b6-14d909cd363f@oracle.com>
Date: Fri, 8 Aug 2025 00:01:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] vfio gpu passthrough stopped working
To: Greg KH <gregkh@linuxfoundation.org>, cat <cat@plan9.rocks>
Cc: regressions@lists.linux.dev, stable@vger.kernel.org
References: <718C209F-22BD-4AF3-9B6F-E87E98B5239E@plan9.rocks>
 <2025080724-sage-subplot-3d0f@gregkh>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <2025080724-sage-subplot-3d0f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0247.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::18) To IA4PR10MB8421.namprd10.prod.outlook.com
 (2603:10b6:208:563::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8421:EE_|SJ0PR10MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ee2339-df3f-4b7c-c15e-08ddd5e0ac7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjE0amc1Rms4WmpnMlNUVzNnOUQyVEpyWXovK2dUaUUvcTloNnVSL0YzL1Bo?=
 =?utf-8?B?MkorOVJhbXlxbXNnNUc0UkFPY1lZTmVmUGNCeGZEcFRTYWVyZ0JBZXBPQ2pX?=
 =?utf-8?B?ZEFWZmJ6b3A0QWEvcU1DT0M0ZTN1ejVZVDZhTmtGejZ4YWV1TXQyL29BMzZJ?=
 =?utf-8?B?VzYyNEdudHRGZG9FSmV3cTdodXNseWxoLzRCSEFMYjlhcEcyTE9BaFliMllV?=
 =?utf-8?B?OTgyR1NLQ3lyemF0ck5wR0FlSXJWL0JRUjhBMDU3SUdocVU1OEpLWnRYNzNZ?=
 =?utf-8?B?S2NTUStCTGhoTTczc3NEQ1VJSGZvYllOempJdFpsQ2hPUnBjUDZEU0I1MXhs?=
 =?utf-8?B?d0FqLzY1QVdmeTJjMmhGbTJZUUpDcUMrcklraWtQdHR5MjBOam5tNlR6Zy8z?=
 =?utf-8?B?RFlXK3pWME9VZmdhWmZPM0doanZvMWhoOWI3dEx0TGNpVm5UMmc2K01UcnJL?=
 =?utf-8?B?TVpRVzlHZHR3TlJybmlWNi8zOUYycFpSdFpLNTEyRHNKck15eW01NEk3R1hX?=
 =?utf-8?B?UUFHN1M3ZnJuTmZ3U0RxeGxWZ3V0ZnNCWXY0Z3VYWUdDZ0pFSFVYNDllaktC?=
 =?utf-8?B?YUVzdURZcVBaSGo4ZHpnOHZBV0RlQ0ZMMk83WnAvamt6MjM2SnN5aDNwSHhi?=
 =?utf-8?B?TUcrR0xONDRVaC9aTVRyeEFhNGhOL204OTVjU1ptdEFubU83MUdPOFl0Tlcr?=
 =?utf-8?B?ejRaZWh0L2tJOWY3cWU4ODFTMHRONFVyUU92S3g1cTU4QW0zd2ZGQVpOSWpa?=
 =?utf-8?B?MTU2dXcyaUZ1SytIK3RlTVlYcHFQR25rUnhRYkhlZDhtWWhTZW9hbzNDOCtP?=
 =?utf-8?B?Rk9VdkZyOWUrUllubkZ1NDJCejdNSE5nbGtBVDdiWGsxdURvSCt3SEdIRUlN?=
 =?utf-8?B?cmU1NVZ6d2VtdnUrbUhnWStjc3hTYm5NbHNwbTQ4ODZiVzBZTFU4M2Z0QTky?=
 =?utf-8?B?QkpQNjFKZ3BuR0N0Y0VsMUhWc2FVcUZhSytOK0tuSEswaUJBRFVwWEZ5Ymtn?=
 =?utf-8?B?bE5SZWYxVUprQXhLcFh2SVE4ZHdweE1pZjJpWTRQN2VQVHFJWFdGT0U3VnZI?=
 =?utf-8?B?WE12UHNGZmZrUUJvY0tTMUozQ0V6ejVqd290Nnh1engxZUxSQ1N2SVFHT2hN?=
 =?utf-8?B?elZrVGpTOW9ybkRodDM3ZmxjUEIyMi9tU0tuSzVuaDRlQ2ZmbjkwN1hJZVRL?=
 =?utf-8?B?d2NXc1UwYTczZGk0Y1hBV2xNb1dvMlRoNDd2ZGpyN0pRb0Q4eUY3Tmw5MkE3?=
 =?utf-8?B?bldJTlR2NDhHcHExejFuZ0VxaDlGOGRrcE5XcytVZHpBRTNrUzhZUkovaWlH?=
 =?utf-8?B?SWdoQlQwZHN1UDZaWGM0NCtKLzlTdGVoaDY5MDRaQnRDUC9MeHBRdmpyQmZt?=
 =?utf-8?B?cG9KWEJndHBnSmRUT0dMRGM0Z1pqUDRnNm1Kb292R1ArYXcvVlA3RFRuYUxZ?=
 =?utf-8?B?SEpZbXdmR1hKRE1jY3cySXI3VHhYOStnMy9MN1NLeGJaZFFnck44MEpLbmty?=
 =?utf-8?B?dlNhQmFvUGpGaVZvNitlQVQ1SXQwSktucnN0b240WC9BV3FMOTlwcXczYWZK?=
 =?utf-8?B?VWlJOUZTTkVYejdXcVZET2NwcUJtaGxaMGthVy84anRYLzhQU1dkRFFwNmVM?=
 =?utf-8?B?SVNQY3ZSclFHRFVEcjRsMG5JNkpZOXRIcDJKdm04YXVhb3l2ZDkwckhOZTNo?=
 =?utf-8?B?MlBoT3lYSkgvVGdySjJYWUVKRFRmQWlGbW9wU1paOXA4K3UvOGk5UWRHRUpZ?=
 =?utf-8?B?QzREbENKV2Y0eVFiUEYzdFg4Rzg3QkNOalEzUm43VkNaa3hrSEhWL3o3SUlk?=
 =?utf-8?B?bWFWaGVaSWsxTnNBTWhWN2EwYmozNTNqWnBKMkxObksrL09vTEtOeTlsTTFU?=
 =?utf-8?B?c3JoZDdERFJTNjFvOGpYM25JM1hxWGhpVjFDNXB5VVdJWTc3dytQV000NDJl?=
 =?utf-8?Q?ESlPA4QSZj8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8421.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG5xMUlGeVBOVVVmdndoU3ljNy9jU1BkbjljS3NYMVJiZitHRVR3WEtvOE92?=
 =?utf-8?B?TFhkajJQR0w5R3cxb3NkakFqWU5LaTdHdEdlTW4vMys0NDc0TFgxb2x4WkI4?=
 =?utf-8?B?N0VIOVh4WjV4M3JSeEM3UjNhZzlhOWRZT0U0c1cwTVBsVUtDWFAvVXJ0Ni9O?=
 =?utf-8?B?RTkzS1ErMlNqOGJGZ2diZnpmOHZCbENka3VaRG5WYVFqZHBuMGR6NW5saFRF?=
 =?utf-8?B?bkNiNHFrOTQzWVcxcDlDSGZ1NXlmTk5PNkFjN1A4RGpMbHVVOVp1eThnQXMx?=
 =?utf-8?B?a1BOV3UyVjdQTnI0NzliZ2x4VGtyclJ3ZytVaVVtZVAydk1WL2VVM0VKR0RT?=
 =?utf-8?B?UzRRK1lJTWpISGpUU1dPWFQ3WHRPWDY3ZnR4cVd3Szh2YkZoN0x1NkFMWnA2?=
 =?utf-8?B?UTlRdW1nSG01a20xOUF2OGQvZ2RMbnZuTmNORXdxZUs3ZW5lVk0zV1pUdW9T?=
 =?utf-8?B?a2p2bjg5bmZzVFNBekM4czZWUGEyanpSY1h2amhQT21YY3h5Q083RURZR3oy?=
 =?utf-8?B?NEYyWGliWHBRZFFiM2Z6WXFiZ01OT1J2d2djMkZpY09QSVY0MGlVZVlHVitC?=
 =?utf-8?B?UFVpOVZUSDBKWWpGZUJvMWcxVE1ES2k0M0ttZHNpVDQyTUVmRFY5Y1pqcmZt?=
 =?utf-8?B?M2Y4M2ZwWFBrbjAwQVByckgrejJaVExrbTQwQjhCZlY0a252YitQYWE2amls?=
 =?utf-8?B?NnNkRUxPS010RXhhTlBKaXJmUGwyN2FtZUhmRHQ2NlJNemhhMUc0UjBrTDJV?=
 =?utf-8?B?YnhOeUJ2azk1YTZYZThYL2xsUS95L0tpem1hL0xFbklBbU5zVkFrRUJWWjA3?=
 =?utf-8?B?SjkwaVhhNFVzQ2swb1lXZjFBWXljNm5MdEtnVjByMTJOSTkvRFRQc0g5cThz?=
 =?utf-8?B?VVJkRHZsVDFLOUc0R3lDSVZSdzZhYW9OcG15aHdyTWlhOEs1Y2tyRVlPVmp2?=
 =?utf-8?B?bXptdlQrSWVBRGJxeHdWWDRpOURjUjUrUDJnSllaNTVBODg2SHBZSzN3Zkc5?=
 =?utf-8?B?aEIvc1hpSFJ4NDVqYTY1endnQ3l2cmlEREw5Nm45UDVIYW83TDZYNllDWlpm?=
 =?utf-8?B?SHNWaVIwTE54UTRCNVR3U09QTW9DZ1hLdEx3MHpQMmpvbWFtbTJ0dm04akJn?=
 =?utf-8?B?c0FvYjRLemVoVkZQNmNZdnlzcWpIb0YxRVgydHFMZ0hGUzdueEkzRDd1QlpR?=
 =?utf-8?B?bXFGT3NpSnNUei90V2dBMlNHVk5DNTh4bWY4OUhIS1NpTHlCeTZ5MVZtWWtJ?=
 =?utf-8?B?cHVtZGxGS0pTTDc5RGZkb0N2UDZtWTMyQldiT0NZWUEvdm9ubVE0clFRSExT?=
 =?utf-8?B?bk91YnNoSm15VW5sNFI4bGw2MVEwWDUvd2JMZkppRFRLc1BZc3VJRXFJTkE1?=
 =?utf-8?B?Mmk3bStVT0hzMkh3OG5LeVRKL2o3YmNlM1V6TUc0cU9QTUxiVUwrRFozbEgx?=
 =?utf-8?B?ZkkxUnU1bFVRZmhjSFRoREhkWlN4OW5sNmt1blViaXg1UEI1Y2VNdU11M3hv?=
 =?utf-8?B?ZEVMUTNuVDB1WDBsTDVocWhBQVJ6R2xHd0xhWktVNUEwbm9PUGMxVncveGVn?=
 =?utf-8?B?UUFyNmFBbEVrcDF6M1hnSktQUnhKNEl1NDhnRHBSVkc4WkFob0lBTHR4YUlT?=
 =?utf-8?B?QTIvV29nRTNGZmFXaVBRdnJIZDdWRUlDTU9pbnU4S1loMEpLNVFqZUwwZkNw?=
 =?utf-8?B?eVFiZGk1blBoVDJLQy9SZ2JoN2ZuS1NFK0FhaEFWMy8ycmpMU29lM1NzSmZu?=
 =?utf-8?B?T0o2MXdNNEl5RTNzdmZjRG9PZytPVEJXbWhsbitoRk5uSTlMcG43czBlN294?=
 =?utf-8?B?Y1MwWnpndS9nVm1oRGJ4c1F5cUpaUGhKL283WEt5R2pONUp6SEZOTXpyWndV?=
 =?utf-8?B?Z3JnajhwWDY2UmhJV2p6S0NnVmdIWE83M3RtTWNiK0dqOERtNGp4NklPazhZ?=
 =?utf-8?B?Z0Y3c3NPbzh6cHpjZW1ZbGhDR0NLNEJjbDNaK3hpMXYyOHNaV3ErYnJrYU14?=
 =?utf-8?B?d2lINFpjWm1mbHYweTV4WUhsbDVMT0ZIeG9IRURkcHdPMVNXQ0hZMFh2NTNv?=
 =?utf-8?B?NnprK2E1L0x4dHo2MkJsUUZaTTl2R2J4Z2RvU0s1Zm1pREUyaDZOZk1XdU5a?=
 =?utf-8?B?YkkrcCtaSC9jOE5UQmlBZDBHOVYzQ1V2S3ByVGRlYjZwd1hQVG5RSktmMDF3?=
 =?utf-8?Q?aHKlP316iAPPGJULPST/s6o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zmvjZpY+Zm1LmM6o7cC4BproesEplWMrCsdYjqnVEwwiSNOTaUVbmzN0uNnT0qWQrTO6BJ68z7+sTnZLpxJcADNRBasIj0DMz10J6j/470WagMuf+hSCJ6dB4FrNpVF/ATCK+p38lQ0XQHl1cg6bjubeR674BhEt/HTDE+GxIVRCug7VL7XootC6qBdXl+du2VKjBNPGSqp3VKhHpphfAhaWnR38z+nDdUIN+0r20ljCgbNHWelIpXvvo/LdCm1Wh0cWxT13QELnSyttWKH394N52D8R96NKwQ0GH+2UnRvXiXSnj98IsZxPphQyGlZaL+VsPPAlWGgOq6qXsYHRlW5A2elNMgamuyxnHu+7CjNh484KK/WW36Zb77ML1u6V0B12WpcElrxNPBuK1PAZqu/nrWGJ5Y86Ptq/s3WBlKAH4tH4r+1MhlUm+GO0+pLr2xPkmZF767ilu+NoR1T/SlFjrruBoxexfEfp7MkqmooAqMFUY1ZkYyzLpG/QWR3+GyVMkZZPK3oSEphdmB5c99orpRjBWS1AA5v8NKqfCoKWvkeL7YfPBmiRAIxtLvC3iY8udmTqOPT4BXKfjKTUotuTE0GNQngDbcFeMfmTCRw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ee2339-df3f-4b7c-c15e-08ddd5e0ac7c
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8421.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 18:31:50.1060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0lT5Q3pxpmPL6WHN0QkOz/t44qUejgv8UB6VTG9AFxlcqzW3Q+t3bgIVowfB/QoYTsD6rbqgCv9WRejDbb67qMn114WXcNiDS8Fk8+oUdCcNE/sDUaLKaprFskgMVP9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508070151
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDE1MiBTYWx0ZWRfX1TpUg2UAiJqH
 DD3ZgeZ+xhb7L6bj2vCUBie0q1X6UeOkN3hj3qjSOqrrw/Gqof3uQwhJVA7CcH5eOcMmJWnttjD
 jauFwCDQvTBQTLTVNjYA+GD4aU668PmrzdgOf0Gj8T4n68luwZPQHhKX/OBzknHHJBgCxZAQTxv
 9X6Uce6Ewgp04CwCTKP2V6SzuJgtrYy+L9J4nyQuA3Ke7yA9/Vh6WNmbKMAZ9GUprBvjWbxZYtF
 iAFvtFNS+xJbLxYPwI5syJyaapMOviULPk6c/Ql2DBWqM32FUkFJYlzI2IV92jmjDgWapcCJYLM
 j8oBooFH5Lriqmor2iD5XhKfNmi/vlG7pjwnvx0sgazqKwJd6biBsmodwgGkilSsflY5UOY3HO5
 RNVNG6hufpMfQUgeR6HgMxiWp1kiLz8NG/SfHFxWTbbhmEOb/XQT3RXZNYTTbkg87AflmRx8
X-Proofpoint-ORIG-GUID: X26UVaNLIzhz5wJkKZemFhpHCwl17Ojh
X-Proofpoint-GUID: X26UVaNLIzhz5wJkKZemFhpHCwl17Ojh
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894f11a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=0kUd3DXMgacpLyZ-ylQA:9
 a=QEXdDO2ut3YA:10

Hi,

On 07/08/25 21:22, Greg KH wrote:
> On Thu, Aug 07, 2025 at 03:31:17PM +0000, cat wrote:
>> #regzbot introduced: v6.12.34..v6.12.35
>>
>> After upgrade to kernel 6.12.35, vfio passthrough for my GPU has stopped working within a windows VM, it sees device in device manager but reports that it did not start correctly. I compared lspci logs in the vm before and after upgrade to 6.12.35, and here are the changes I noticed:
>>
>> - the reported link speed for the passthrough GPU has changed from 2.5 to 16GT/s
>> - the passthrough GPU has lost it's 'BusMaster' and MSI enable flags
>> - latency measurement feature appeared
>>
>> These entries also began appearing within the vm in dmesg when host kernel is 6.12.35 or above:
>>
>> [    1.963177] nouveau 0000:01:00.0: sec2(gsp): mbox 1c503000 00000001
>> [    1.963296] nouveau 0000:01:00.0: sec2(gsp):booter-load: boot failed: -5
>> ...
>> [    1.964580] nouveau 0000:01:00.0: gsp: init failed, -5
>> [    1.964641] nouveau 0000:01:00.0: init failed with -5
>> [    1.964681] nouveau: drm:00000000:00000080: init failed with -5
>> [    1.964721] nouveau 0000:01:00.0: drm: Device allocation failed: -5
>> [    1.966318] nouveau 0000:01:00.0: probe with driver nouveau failed with error -5
>>
>>
>> 6.12.34 worked fine, and latest 6.12 LTS does not work either. I am using intel CPU and nvidia GPU (for passthrough, and as my GPU on linux system).
> 
 > Can you use git bisect to find the offending commit?>

Additional notes: I looked at the log and am listing probably relevant 
commit, if bisection is too costly:

68e58f579121 PCI: dwc: ep: Correct PBA offset in .set_msix() callback
523815857b1e PCI: cadence-ep: Correct PBA offset in .set_msix() callback

These two might be interesting ones to consider. Please ignore this note 
if bisection is already in progress as these are pure guesses.


Thanks,
Harshit

> 
> 


