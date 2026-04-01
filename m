Return-Path: <stable+bounces-232846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIwTCSZszWnvdQYAu9opvQ
	(envelope-from <stable+bounces-232846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:04:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55137F982
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 21:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 978DC303C642
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 19:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CF8247295;
	Wed,  1 Apr 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TYTJWxw8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ekmo/qiR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782A6175A6E
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070100; cv=fail; b=qnvnXmWNnJ18y9Mtcyp9ew5OPvJPHKchOxIHSFR7q6K52l8rl02bPNg0WScluwAGprcgmVLDU0urDAGvN8WysqnDolskHK94rKO0K+2VPx8wP1kUUb5+LfujkZsumbWUcSLlICuz5eaq8kZJ2LKsgBVNmIzacEbH9tQQ5xXw54k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070100; c=relaxed/simple;
	bh=zkyy9hLiSleiQEG4ZQfO45xsmjRIvDRI2cG2bEwY7k4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cUdDuu/pmLcOrj1KtG8UymlkEtUfabY3jYxWYGD+DnTAZQJBjq/Pvlf49X8WZ1A3gH0YLvsRSB3XhCGlhy4yEj4/hnVcwW58CeeFb1+hVgP4ZLLGhBliDfMMVJnHQDbEDdt5ZjHKPgjyunVKug/qgM6Ndf+AyQgY082mhXPMhkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TYTJWxw8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ekmo/qiR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631F8Wvu3036132;
	Wed, 1 Apr 2026 19:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CZIkjDomLWML6gRWKftnISXVV7N3fyAvMSMV51sEiW8=; b=
	TYTJWxw8JF8+OACCnJsxpDQgZ2J+H4JIIIm9csmN3QGccIdS6yzuf5R6EqLX3S37
	Mhqvwpe9ahZchjbE3mA9+EPAUOqD4maCnREwd/XD/xiv1OsqRfTbOWfkmmNIpLdG
	A0y/va+uTS/GGqnf5sI5tqmBciM3OxqhE6WQmFABBgIGyYNxwrD6EpgojZd/jCyd
	FWEfDoSdrUFhhfg3g9QN2QdpVmKD0gYU1elArQZNyCgdDXN7ipAgaAVckf/OGASt
	yZypkEfE0UDHzjAWOLlO9miSyo4DKoaodYf1UpYJiDZwba3orq0bmk27Sm+hXlK2
	SKIN39cCAtBJrghr/Bj+Pg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65daf3w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 19:01:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 631IcfeI002478;
	Wed, 1 Apr 2026 19:01:23 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65ej211c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Apr 2026 19:01:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFPhxhyza37TVFIjZcIZ4wFcLBe6Wopt0RVtwlYcabyrO7fJ08ELEzkjTrNz3StK+Y5VZvswto3b9F+PiIE/UxqQ2Id9zcmX/Ir8nCwXp5veCJeLEqxQdxlC8XnG28CoEVDmuo5eafYlLg9R0cFZrNFEasLLdrs0o9/2X254AlNcJVjyVg9+Fh5Rifjl8yjCKqgUjtSLVcLnWXztYEarRXuuMLB+CT95Qnf9N8vSkj2LYtVP+oh+cUUnCVjzGNrTXpkozbG7oqnGy4bCmq2isd9Y/yW1lK9g85cJCc14+0kqWiSclYe9vHEODN9D3pUROsw6rMucg9X0BUMI2N0Udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZIkjDomLWML6gRWKftnISXVV7N3fyAvMSMV51sEiW8=;
 b=R7oRkNLEUmmLJofY9v2idT3zFGcK2wki+fMKYnee4D0P6a67AGmqLcGvAoDs4LZyl72Ku7GPafZpC1pWrgufkDlu2/SoGtNShCI0XX4eMVAdpdXv39klz6HnJRKirD1QiamhzFNlsfLincl9oJaib284MNjG8EOKqVrD7meIr048sMxf0ihzVPMsguV2qOiWVpgnR/vmXpS0jLRG1sNnUV+7biVf54dVN1ZGKieCXdfVkw3nXamAwSY3IWt0Gf5qqRQtfZz8a70+ppfDoOZm9S2gmU+egh5yewZtOdvW2PCR5bFnQHFLabqchCB5xitsbCXZ4GUENVsI+ewCrdLqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZIkjDomLWML6gRWKftnISXVV7N3fyAvMSMV51sEiW8=;
 b=Ekmo/qiRd7HHVChIG80q5qQbivfVTbhDOLbvosO20zmTnfYqgCjUtucrM2GSRPZ4ibMhoHrbVCkt34KaTL/1MHG9hrc+c9Kg4RFFO8m9k0dAJqin9LHh+IpBELXKSENVL45d+U26oz5HPrTunK+JbNBYxJxHVcrQYYDTYJW+41w=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by PH0PR10MB4727.namprd10.prod.outlook.com (2603:10b6:510:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 19:01:19 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 19:01:19 +0000
Message-ID: <e5296586-c00d-437d-b7b5-bca4ee3a330a@oracle.com>
Date: Thu, 2 Apr 2026 00:31:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 2/9] landlock: Fix handling of disconnected
 directories
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
        =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>,
        Tingmao Wang <m@maowtm.org>, Matthieu Buffet <matthieu@buffet.re>
References: <20260324140456.832964-1-harshit.m.mogalapalli@oracle.com>
 <20260324140456.832964-3-harshit.m.mogalapalli@oracle.com>
 <20260401.Ahd4leZ5Dix3@digikod.net>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260401.Ahd4leZ5Dix3@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::15) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|PH0PR10MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e23b45c-e175-4d3c-7e3f-08de90210eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	akCmjQrw9R6oLkcBGiiam52yVHOZRvaC+fvjuBsAQcVkUDA/EIIUS7GLoDPRVNjGkSn1lecRt2KLWM7vo+M+g4jDslNUxPqGwBYBRg7Zh3yj7TEwImnOVrIGID5B4Yo2/F/OV6OuGH46btceH/OPp/hMetni2Zj5xAsdHQhso4TlVsWbhpOkTvv/gOOEVY/4WP3nDUJBv/d0QTR4Iky+CDOflaxVaqOlOdnpLMv7O05gV1SQSjuLxhgr0hmWArljOWIHUrHwySmtph3MYtDPAW5b7VkkUWa/IX8sh15cTsf7m+U4ML4tSYWIhbXNNRlPC1iBmM4z0aJeHfMYK3HwyCfFpF/JQa2BHYIP37yDhyBZk7GY9erPV9PytEpXbqOAjNMHBgse6DPL0S8a2W4AfF+I9268qAlHt5D6V9XS5//+ZfWsaJl/VtMKg3ZljNmLxZt8E0FvpTl7aw+weXFeJjSCmaaizkm2KKaR8aY1T8CwEX60ldPZGfIfj4hwp3GkPSJcaLYaLi2MJzBwFEoR3VVqdJDdkl1B4oRLIu6BxZeVRPF253Vh1j3JUS+/j87bbgFqcqPUIZeCdO7gqVsVkXKQ601BIT8kqOhToWjk6G4WXTg320QgbQ68g2MV/HbQrvyXHAtVV6QNUl6MiRogwAsl9IEtnBYr3TXEIjEj2wSwYnkyFZv742JTA2+Izi7K+3KQclG5W+VRpRq1KM2XuLMPOeHvnQr2qaAUNmgsZf8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1dicXdOWE8vVTA5TEVMZUhKalBTbGwzZ3JBVExzcU1XcldBcFYzS1o3K25v?=
 =?utf-8?B?TldnSTA0cFA5NDBVU3NIME9sYVdDSUI2ZExobUZCQTN2LzI3YkVBV1ZTNzlY?=
 =?utf-8?B?em5aTlg2R3o5OHMydVV5NTdkSVIxTXB4MWlXVW13akQzNDMrUGNqRVN3THVX?=
 =?utf-8?B?bmtLVGFrbDM0eDYvVWE0Z2sybjFCOUhoSVJXVE1rTkpqMGZGaHpDQ2ZXR0I5?=
 =?utf-8?B?YU5LTFkxYmkyMzlaVk1uNzZVejFxYlhNREtCalNwNGhtWnNnMXpwSE4wczdt?=
 =?utf-8?B?VUgwRDgvWmhBajNpbCtFR1JBa2gvTlZZM2JvbjNpczBRR3ZQaXNueUhLQkxy?=
 =?utf-8?B?SDFmQk1RUEc0N2VhbnRwRW5TR05vMmxIV0Jvc0RqekxReUFCUldUZGlMWklI?=
 =?utf-8?B?QnN2aytPN3R6TXhNZVVJbVRaVFJqaVFpb3B0MysyUDRhSjdReVE0a2VTYnYr?=
 =?utf-8?B?UzVDd1FCSnFwMjd1aDRnc1VmdmZSTmJyc1E3VWg2UjJGTWhtaytOd2I1N3g3?=
 =?utf-8?B?d3BoTzkrL3FIVktPeVM3aVZSbmlTMVY1bzdXSlJUUFJySzdjOVFxSjFrczRl?=
 =?utf-8?B?YmZ2TTU2MGF6RXdFWmJGOG14cVNCQmQ1SVpqclcrR2lWUXBTYUJrM3VCR0tY?=
 =?utf-8?B?aXVQLzRkT2ppRkFSa1lzRWh5NldzK2oyR09sVVRCSmVubGJRVVUyNDFuMGs0?=
 =?utf-8?B?Nmt1cnh5ZjF0VlM5OEZhV05ueUhOdTVuOVdPakxySm5KT3VMdDd4aTBkbVk0?=
 =?utf-8?B?RDM0TWR3dWU0dzhYYkljR3dUL1d5VXUzMytERDZWa2NpcnR4WnVnYVcrUVNF?=
 =?utf-8?B?c2twbU5pTUp1em9FVGJBR1FTNUxiUncwOG02V0dOM2ZuMWxKblNtanFmejRR?=
 =?utf-8?B?THU0c0g0NG1vSDU4YXJpTjRHN1R5aU4vRkVMQkZvOVhMaTYyaDlHRUxDVTFu?=
 =?utf-8?B?VFN1dk5COVV4akFlUFJNY1FhOFd3bkxDU0QrVzE4RmpkWjlyUWxPY29sdHNJ?=
 =?utf-8?B?SlBnM284dys3cTFwVEhoaCtQVXY3SVpJS3lXN1Q5dCtyZ3JUNFlVNnhzZWV0?=
 =?utf-8?B?WTBRZUtZOVZBOTNJaGpjUG5DZHhQU1RXUnFtTWQvUTRLTXo3NFl1NithS3du?=
 =?utf-8?B?UU52RWtNUitTMUhXKzhaNXl1blBEVHhiQklsOTlDbi9BYTltZUVWb1RybFc5?=
 =?utf-8?B?TjNiZzBMSkViMVo0ZSs1czVpQmcrMHlZMWJldEc3U3B1Y2RORlNVRXU0ZVpV?=
 =?utf-8?B?TjVmTUpFLzdMbDVPYXYyK3pmYkt5bERQSFhlRkx3d1E2clFGOHF0M1h5T3hS?=
 =?utf-8?B?c2t6Qk9JRFNtSE5mbGRxalVSS1JQbmY4aE9ZUUk0aHkrY2M3MTBIbC9MVHZN?=
 =?utf-8?B?U0RYdnJJVVRYNWpGTHBTVVllbjJZRzlQWnh3endMT1FTa1RzL3dxL1ZDVG1F?=
 =?utf-8?B?Nk55TCtndmNlWllhMW5KRHZoem91UGJ6U09QVFA4a3J5dk5kQnpYNDBzdVp4?=
 =?utf-8?B?ZExHcEFJdS9Nb3lRODlmMy93WWJtaTdaeWpjZ0pHN1VlS0NnOW1kUkxlRE9l?=
 =?utf-8?B?VFlYR2FMcXpTRjk1WTZOTWJFQ01INUhaV1ZNdk5VWDhsdVdTMEVXNkwzSW95?=
 =?utf-8?B?V29EYjA0OHJhY2FsaFBnMzJtWE9RckZCd1JzTEhsd1hhUlA3Q2ZVNTEwT25V?=
 =?utf-8?B?Y2l2WGhIVEpoNjRwRlBwbXRoMTh1ZmxDLzcwYzgvK3VXOS83OW1XWGFyczNK?=
 =?utf-8?B?MEhxbWxISEhQOGQ5bFcvd0FRV3Z6ZEZuNGhLZWVsd21HcWlzaVZ3QzVaRTMy?=
 =?utf-8?B?SDlLSkNzME93RS9vMjhpNEhLWVhCdksvTzJNTU1OM2RNblRZNUczWmVHeENM?=
 =?utf-8?B?UHd5LzliN3U5bUVWN1Qwc0pndTUxcU9UTm9NMTFGQ1hab3JYS3JlT29jMjFL?=
 =?utf-8?B?bGJtSEZZcUtBemZHekt4ejdNUFhTTy8xRFhYbHVwMUc0Ym55ekliTGRuKysv?=
 =?utf-8?B?ZHYzdkx3eDh2Rk5FVFFXa1l6d3BMa1U4Mm1rV3hXMCs4aERVSFVBNDkwdFBL?=
 =?utf-8?B?M3lFaEhpOWJZMW90VUUxc2poRnlPd1pzWHkwbThzcjAyeHp4c3h0dTFOYW0v?=
 =?utf-8?B?NUFXWS9jQ3Zndm1CeVNNNHQvS1ZHS0M5YXlOelJ6TzRsRzkzZDhKZzlCNkhy?=
 =?utf-8?B?RjJXbkVWb0l5OWdTTHUvMDh0RjdSS3hNd2ptSUxweTVnS09GaHVUc1JZSWJO?=
 =?utf-8?B?ZDJwV28yVUd3UHZ4SlFxS1ZucUhOWE10WkZCTWZ3NmhGYlFyRERqWi9YWVRw?=
 =?utf-8?B?MGJ5ZWJIQTZXV1JWam5jcUkzWWtQZ3dSMFJoVm9sQ0JzOFQrUFFtNFdqaVox?=
 =?utf-8?Q?cAEW1z1XaHStj6kTSfZbn/RWK6rByOlq0Pkc4?=
X-Exchange-RoutingPolicyChecked:
	jlCH7azAGF6Cx1MxBtgEFV6wmyTpadQyT1emNSemZOX+fS4/eOqGkGEWlPQhC06CNsuWiyzSvGg3IEQyJODfOia5yYFZRsHwgcyz/R/nb5gob7C64ya5c6bZofJcqcR//PVE/HPExpLBCvVSukI2Br9g8j2o+fvFXCzB17o4lFsr8JqRHaURo49CFOlLV9tKFsk0Cqm65yNetn3rT9pROe2AcY2kmNx456nfmS9fwO+HkUuA8Yb+GerZTJeV83qTQWY4Q2f3aBnmA56k5ghXmBouN4gjCgLitcIZVhnT1Y0PBlhO274T7dP4mek/n9lAmvK+bhVgxeRbWFsLI1LRDA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UMyrVo5xEXJMNQjXX4Yf26hDzPWsg3pc2d4DDUUQTn8BHpN9Iyqk61VOtHvry/xsEnXjc64nO39xAvYD8QqIgq1If1cvPlkE3HNtXtPA5xMvjUs8V2bXh0okhAGmI6KzuNpcmguiBjQI/I4K6MkJRYJg44Sn9qcC+es4Th3VnBK45f7v5JSrHfhVb8/dZ9oKwIgTCDVY9oTTZcOVfmWJu8l3wnEhP+i7TJ1hKOEO7btC2wTgaIman7D9qFrMEZYKF/iQvA0Ty+by1+hwL7YxEiWPGqHTC+p2hRwN36s3SdNqeLpaBZAdEen/Opl/FRMXzshP/MwZSLiaXGlA2sqHOajYbJi5ZFAern7RikYmwVHoSaezkNjrz3AVWiwoWfP+zvB9hZhFet7lvBDMWBCQDgjttLSJu459g8krjhyuvVj4mSwgqFL2xo1e0qIihU7n3Ic1SmBUlWnmrdO2wVu0sGUBJcermUjaRBzfHoBGjORbC8Xc55FUQVRDDY0emqYYDS+25wvyRYIVUVQYFpO55iL7vCxPGVA+fl25OHq5bIt72yImtzL4n105WTXyJgmeDAcE4A6FD9J2p2irsDZXMLQBhPSD9VrU2gg0KBtI/fY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e23b45c-e175-4d3c-7e3f-08de90210eaf
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 19:01:18.9016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bBZNPRtUFU15Kln030Xes92AiR+SZ9Mr/BPdVLXegzIAsSnw0vk5SmheoyWE8bKg8CHT763Cst/P0RBio1P9M6g79Nfas+dHCrPvu3MNHimN5lUdw1PxcDBKuOWKX9w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2604010178
X-Authority-Analysis: v=2.4 cv=IPwPywvG c=1 sm=1 tr=0 ts=69cd6b84 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=Oz7HQFetavHjlmfIKK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12291
X-Proofpoint-ORIG-GUID: GtImoCWfKy34OHxxbX6souc_SldHd2qx
X-Proofpoint-GUID: GtImoCWfKy34OHxxbX6souc_SldHd2qx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE3OCBTYWx0ZWRfXzLjSVNJR/a69
 DVOI/1BXJzcI5ypv3bJMH1my0Upzzd1WIlZhQvGY8YhkBvcih6a13S2tKOlJQLD/YyayDsGfCAy
 q3H4w1JepxrMcjbzAGtFiwTXQEXvuzTqnOwi/VLv7Vk7vMSGKwS4W2EH1XG68wu+1czgn1cJsZ9
 uRcCW+D28c7IWkZ2KISkzCx4/Ryt4v8q5WSSk9U0b7wsW9zXsGZYHOozi6GyJRVoySLAOHCPqSj
 FEORCthsk09/yiXSquKieat2f4A/TORtHpvCn4zFU6lMkOLISXOxn+y+7HPFNQuLGl883fq0bHN
 mP7CqAtcU+jLFVT4GDIDxxhmxieeoEdvncwsj+O+H180asapcAZfipTZsCJZ2UsnM99SOor5qnn
 JCLd65ciNiMLn6dEskbiCLZc4YoXGSIcxWKpguCdfbWhI1fylUE2mhD32icUDyzdTWw0t9vAA/+
 ZmYh98lKr3Jst64+/GuH6LXFZqcYWCrZw1BgMOuo=
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232846-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: AA55137F982
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mickaël,

On 01/04/26 20:54, Mickaël Salaün wrote:
> Thanks Harshit.  BTW, the following commit should also be backported
> (and it was specifically created to ease backports): 6803b6ebb816
> ("landlock: Fix cosmetic change").
> 

I did see this as an approach, but I felt like for CVE backports keep 
the cherry-picks minimal if they don't really help resolving conflicts. 
I had no conflicts while cherry-picking and its a cosmetic change so 
according to stable rules I didn't take it as cherry-picking the final 
fix is clean.


> The current patch should be backported down to 5.15, but it needs to be
> adapted.  Harshit, I can work on it, please let me know.
> 

I agree and will give it a try, and if I can't do it I will let you 
know. (just was focusing on new branches first)

> I'm wondering why I didn't get notified that some Fixes patch couldn't
> automatically be backported.  Greg, is there some way to register for
> this kind of issue?  What are the rules to not automatically backport
> patches?
> 

Greg can answer this better probably but just sharing my learnings, 
Fixes tag is never an assurance for getting a patch backported to stable 
or getting a failed patch notification when it fails to apply, CC:stable 
is the only way to request backporting a patch to stable.

Commits with Fixes tag only(without stable tag) are not guaranteed to be 
backported and particularly if they have conflicts. So, for making sure 
these get to stable I suggest to use CC:stable that way you will also be 
notified if the patch fails to apply.

> I also noticed that other Fixes commits were not backported to stable
> branches whereas they can be cleanly cherry-picked.  I'm also wondering
> why they weren't pick.
> 

They might be clean cherry-picks now but not when they appeared 
upstream, that is one case, and Fixes tag doesn't always ensure a patch 
is backported to stable.

> FYI, here are the ones that can be backported without needing changes:
> - 602acfb54119 ("landlock: Optimize stack usage when !CONFIG_AUDIT")
> - 60207df2ebf3 ("landlock: Remove useless include")
> - 7aa593d8fb64 ("selftests/landlock: Fix missing semicolon")
> 

The first one doesn't apply on 6.12.y(6.12.77) , maybe that's the reason.


 > They should all be backported, even if they look like cosmetic fixes> 
(because they might be needed for other fixes/backports).
> 
> Here is the other one that needs to be adapted:
> - e4d82cbce225 ("landlock: Fix TCP handling of short AF_UNSPEC addresses")
> 

I think the way to get these to stable is include CC:stable along with 
Fixes tag. As documented in Option 1 of [1]

Now that we have missing fixes, I think the best way is to send 
backports to stable@vger.kernel.org

I wonder if it would be helpful to make this explicitly stated: "Fixes 
tag alone is not a trigger for stable backports, CC:stable is needed if 
you want you patch to be backported to stable kernels(and also get 
notified if it fails to apply)" ?

[1] https://www.kernel.org/doc/html/v6.19/process/stable-kernel-rules.html

> Thanks,
>   Mickaël
> 

