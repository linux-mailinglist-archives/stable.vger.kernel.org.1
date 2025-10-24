Return-Path: <stable+bounces-189231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7036C063D6
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 14:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C553B10EF
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72EE3164D9;
	Fri, 24 Oct 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PPnyAKTF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P/q8xIlw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ABB3164D7
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308723; cv=fail; b=amXdIx1/hUCfmKoiiS1Lo2DLYc5N7EKFfSq+yY9MFYq60+OiMl0lE+Fxe8GtxXkmRc/u01wobAeJqAKQZj/A0PXHK61t3U+5DezG3E2YRojUIxqriJz5DauJ3ECVNVa175dIxwWFgBlvbsb/nVpm5GppnFP7MmrAqUNW0SgdmS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308723; c=relaxed/simple;
	bh=uJMMP+9u3WPl6vj0FzJz9eYl8X47L9S7ibdTElp13Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZPb+ct30uawXXOXhwhtiW3//z6i+hejrGm1M2yB0CuDuRpno1qvEvqcZyVyupuaYrVloEArzBq6VDvsl9rWpcUiLZN0jll7z/HhESTIIEue55Yody2b3LuSwVafSoobDKnvZ3TgQ7A+MCWGfbN4bp5XVdlfRc8XFVpmydRQ48us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PPnyAKTF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P/q8xIlw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NTFH021637;
	Fri, 24 Oct 2025 12:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=IenUaPv7e2acmq+1uehrLX+xRTsaZqipbeocCLm3gTo=; b=
	PPnyAKTFfojaItutP+NtrF4W5QvsRZrYIJY3Yo3j3OD2FTVoOPxcVDN9hq6mJfku
	IwzdRVwlUCYhSz736mRteuOnPIRpdlqmXOB+7KkoUZC2E9u9tGh/BaAHKizt9aL0
	j5HMn7qyjUyO2J7992xbgXzWO7egDdqlRMu5B8dACsvKg5nt9w1qtBccrghuQK3t
	j/uLCop5ovVsXUpHvDzjCMXv64I1puJmBJrd6p1iLyRE6CV6cNVuMsxZcW+rik+q
	gZdyond2z5bzRSwN7UWy/1oENgmY3DOKAEXBe3JfvoPVSrtysVDnvUDNQYU5wTit
	Ia1yTYWdalEo+EowKm3Yvg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3k4m6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 12:24:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59OCCfIj023268;
	Fri, 24 Oct 2025 12:24:57 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bgvd1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 12:24:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFVt/jucWswhyscH4qQwIsXDflB+z43YZzoOgIa6u5pDnhD/guhUzdAKxhM/q80USLCNvXjBAGTidvU51NacM/yoISE8G9OFc4cZYxU4m3kOm5e7r28yElbGUMtzB4Nfj5PKQxz5DMoE4I5hRT4sZ3T+X6gY0yCeesxHPgrm5syZx4cJo+fzeVA1PSKNfHBAGnj+MaysKutCeP+/4CHZSi5Qtv7h6pFeTEQVP/p1xa/Gn6h8jFDs4r0x/c9AcCjQaPqccWvVBWkOv986ffP4igrrm4yt4UKBd6okpseCjfqnUCnegi5sb+SWPaYXELLniTFqFLHQV8QI3voYwJW84Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IenUaPv7e2acmq+1uehrLX+xRTsaZqipbeocCLm3gTo=;
 b=VHW1avrFQ4aL8R+jrvXPwldgQmVSHHD2JPVf30BZKglJ1iisIZ2pMLmNAlKbljm+JeSGetXPhmiicLrAqP4xpVFSYLofYGsE79z0uA+dvOSgGXNoGNnHvj8460AT+lOAVk3fn2nHsrtHPOmIqjGTc2kvT6JqjQ/w2oJreF23BAu+8uiBkf5b2BccTsvbkAa/vS435WLFtmsOBjSrp/NDZemkdtjyJxonEpzvjV/EYygDduXY6tw1W5vVwaKyZ2gzvNPHNQxWead0fa+1aRMED0sMuc2BUnoDRyZeTb8HI3utDafZwZHRBiF9GUn+6knjA9GP4kYkCmCn4b1K9gG8Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IenUaPv7e2acmq+1uehrLX+xRTsaZqipbeocCLm3gTo=;
 b=P/q8xIlwQ0XORNyxcdlZx5M62NkRqewH9KJ3rin+3fX57D0slkZ2t+SfgatXOY/qExVJBdjfciM59+pofBIAYEnBU696CuHVZS4Qud5iJUBMNj/DcHe9q0D6tkA66i5h6FvAlRMwYmMCORF5CS5lizbH3qPgRQkuzYecAhCkauA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7901.namprd10.prod.outlook.com (2603:10b6:8:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 12:24:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 12:24:50 +0000
Date: Fri, 24 Oct 2025 13:24:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: David Hildenbrand <david@redhat.com>,
        "Uschakow, Stanislav" <suschako@amazon.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bug: Performance regression in 1013af4f585f: mm/hugetlb: fix
 huge_pmd_unshare() vs GUP-fast race
Message-ID: <a317657d-5c4a-4291-9b53-4435012bd590@lucifer.local>
References: <4d3878531c76479d9f8ca9789dc6485d@amazon.de>
 <CAG48ez2yrEtEUnG15nbK+hern0gL9W-9hTy3fVY+rdz8QBkSNA@mail.gmail.com>
 <c7fc5bd8-a738-4ad4-9c79-57e88e080b93@redhat.com>
 <CAG48ez2dqOF9mM2bAQv1uDGBPWndwOswB0VAkKG7LGkrTXzmzQ@mail.gmail.com>
 <81d096fb-f2c2-4b26-ab1b-486001ee2cac@lucifer.local>
 <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3paQTctuAO1bXWarzvRK33kyLjHbQ6zsQLTWya8Y1=dQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0230.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1e937b-7ddd-4856-f005-08de12f853c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGRNWmdBYklETHd4eXYrWVUrZ0l4TStFMmNxM005MVl4NTVvajBTSm9pZERP?=
 =?utf-8?B?M3l1Y0owREpZcy9nVk5zV2FIT3BJU3RZU29iRjlsLzhEN0FBZzNSR1gwR3lI?=
 =?utf-8?B?Mzl5Mjh4VjgzUzBhc1VkYzV6UTBQdDJoelVnb3NqUE1MSllmaWtYd2dqR2pH?=
 =?utf-8?B?RHc4VkxQRXVpbFM1YXdteXNSNkNNRmVUYzFrTWwwSS9GM1lLQ2psT2NLZTRG?=
 =?utf-8?B?dEVQMEMrdXNUbjB3V0M2QjZ3MWU4T01nQUo3bjIraEpqcnVRL3h0bmVueFVI?=
 =?utf-8?B?eVhCdUNtQkhzUm5JWEIxSTcwbFZNa3BlMTlrcXU5bFZVL3l6S2E4VHJ3dWdy?=
 =?utf-8?B?dG5ML2g4Tk1kcVFMN0ErcEdqZEJjVzYySjgvV2l2UUJIR1hvOVZMSkF3WDUw?=
 =?utf-8?B?MDNDZEUyNCtyYU4xckM0NE9nUVBBdlgxRXIwQnA2ZVJvZ1dsN3o0ZTU2Mys3?=
 =?utf-8?B?ZVhjZUNvU3JVSmw2djZHVS9SOVlOci9yNGt6dFplWTZwazM2dHdwVzhqNmtU?=
 =?utf-8?B?QVZMNkpDclJMTkJkNGVTTSthbWRSZDZVTG1xMWJaWW5wSmdlVXU2NXgzUjVE?=
 =?utf-8?B?ZU91VU1FRCtaMTE2UUdtRmFVSEtnQVEzZVB5VXVsdUVXdms2TXZJaFVJcDc5?=
 =?utf-8?B?TTF2L0pYc2Z6QkhaQmIvOG1pYldERGh3dDdud013eGI3MUx6a1RxQkJNVXRO?=
 =?utf-8?B?QnJCdHRCcFlacTQwVzR1SmNDS2M3TTNrbGFvWG1GaFNBVmwrRFBnRmhmK2Y3?=
 =?utf-8?B?c3pRRzZaZzhHamlGdXhJZG5pb2I2R1VVUjJjeFFuR2swUFhMSWIvS052NEZM?=
 =?utf-8?B?NXEvK1ptaGgyTlF5SWZ4UDAwZEM3M0RLTW5pTCtoWXJTR000UjdkeEoxWTls?=
 =?utf-8?B?N1ZTMjRzK3FEM1hnajVIZVhWbjFLOTZnUXFuYjM0YldBWkhJRnlRV1dSc05X?=
 =?utf-8?B?eVJ0K3RzTkM5Um11KzNTN05KdE8vb3dDS1FGUU5WRDdRMUphWGxMR1o1Smt5?=
 =?utf-8?B?a1pDRFVxU0FiZEdKMmZRWnI0ZStMVENnUk5kaHF2bGoxQXhCbExJSUY2c1Ax?=
 =?utf-8?B?OEw0UlNncnNuQlZhNnlvclhwZVduUDlCSTZMZU5UNmZreFgyNFpLYmIrT24w?=
 =?utf-8?B?TjNOOUFTcEU1MHZaZlFxOElzQWV6eXU1b0d1K0wzazE3SWZuaWdjVlJiMGg1?=
 =?utf-8?B?aGdjd1VicFVNMDJ2eS9pZCtmWlVCVFhraytIdGFZaGpxTnhEd1kxQjhMcUp6?=
 =?utf-8?B?aTFSOUxVQjhYeXA3Z1FIRFovdndSWGcrVTRzR2dlaXpuOFdOd3VSSEsrODNG?=
 =?utf-8?B?TjVmVjd3NUU2Y3d5cVlVUVNLN2tITmxva0FJT3Frcnk3TXErNGl0NE9Ccm10?=
 =?utf-8?B?ZHpPMm9TMVRjaE40V2ZEdkwrV1pxK1VvUW5zNEp2Z1pudjJlVzhIeU5jSkRk?=
 =?utf-8?B?UHBlU0loS0paUmIvYkRWMldLMkxYRzR3MUVNTSt5VmsraFBIZWp6cW5uQlJF?=
 =?utf-8?B?ZXhwS2tFZEwxUW5KSW1OZ29xcUpTUDhMODdNV3NOYUtSUUlyaTNiZDFpbTlS?=
 =?utf-8?B?M016VVM3eUJzWnM1b3dmWi9WTUtJQXE5enYrcnlxUUdxMkYza0VyeTlVUy9E?=
 =?utf-8?B?M2ZuL2RBdnZGT2JpcFdYekt5dEh2OWw0RHVrbkNUYjRtYlVwdmhzSjl5WkhZ?=
 =?utf-8?B?YVdkd1M3bUR5NmdXN0NZRTlFOWt5QmdMNTNkUjdkejcwNVRBSldiUkJDSC95?=
 =?utf-8?B?blZrU3U4bk1wY1ZWV2QwOTZMcmgxblpXVWxHQjhFcnRYVSt6M293bDZNZS9N?=
 =?utf-8?B?dVpsTTkvZ2NYS0xQbUR3YkVCUlI3OWEvdHk0SGZnRmd2Tk43UStrbFhYK2lh?=
 =?utf-8?B?MFVSWHB2NWlWUi8vVG40QzNvRkxWMXIwTi9pa29WbkNXQTJuenFJQ0F4YTZD?=
 =?utf-8?Q?Lly2DYBN72Rn9DK4yTWhCcKCVT47vxwa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFpXdmQ4aUM0dU1NVXNRK0NNY2ZsNiszRW5CdnoyVEY0Rm91NDd2RzRSTEgv?=
 =?utf-8?B?WTNuc29mTG55QytLVkdaOHJQUjJOdjJabzZmNktEZjFlSGdnRE5TR3A1c0tE?=
 =?utf-8?B?VVhMTnVyWGNWOThLRjNqY2dUTTNETTFnOUs4ZHBERXNqeEh0NitGblg2VjJu?=
 =?utf-8?B?RHVMOTByTzZ4KytpTElaL1E2ZGQ1aDdUQ1o0b3UyU1FtY091L3NkUnBBV2lX?=
 =?utf-8?B?aUFQMHNJbDN3R1ArU1JBNCtacU5vQUcwL3AzazQ4azRaeHFKSlZTVzZwSU9l?=
 =?utf-8?B?a0ZpQXBNTk5ZcjlLamNpV2NwZlFIVS9pMWFHaHZma0Q0Z2xkdG1WM3pJRmQr?=
 =?utf-8?B?RDJEVXpaTU5sSkd4ZmxTQTdham5Kb1k1THNDV0VLSmRrTjdxZmlBRm8vRGtN?=
 =?utf-8?B?Y1k3WmE0SkhNY0hRTEx3UGE0ajB6RVEvdmJncVhvZGc3dG9uRUx6alFCYkRE?=
 =?utf-8?B?VFlxQ25YbVBPendWS1YwKzcwYUQ4blJnYk9EZzhsQzEwcXE4Y0p4NGlDR0Rl?=
 =?utf-8?B?ZGovV3pRbzlFd0tmdVdBZC9LMU44Q3BsdmMvWGR5LzBuUmk1NmN1RUZod0ZF?=
 =?utf-8?B?N0xSWVE0M0VjamJxUWVyd3F4SWdvb2dBSDVGSWZxMUl5eXhnNUxSR3lxbmN2?=
 =?utf-8?B?THhoQVk2cmxRVytYUlBJWFRIY1kzaVFqWUtlcFNCTE9PYU5CTGZFKy9RN2l5?=
 =?utf-8?B?b3FYZDg5bzM3ZWFXUlg2NXBycHM4ZkZDWFB3NnMzanRaRm91M3FSbko4OUJa?=
 =?utf-8?B?c0RkeGZaS1BnR3J2emJxQXNFVEJmZGRYa3Z3SGx2SGpEM3V6OFpDdUhnQ1dH?=
 =?utf-8?B?Kys5eGRwNGh0NUlsUXhzTzh4MGVJaHZ6R1N6ekdtZndTMTA0b3Nzc0pFYWxy?=
 =?utf-8?B?WXpGdE5CN1pTSXF1ZS9RRGJ0bXVJWUxFL3VjZEpDMmtvejNieVpWQzJiU0R6?=
 =?utf-8?B?VnY5TzZiNm1PbnpOUGY0eWJ5aFVzQjJ6d2dhUEtUOWwvekM2WmhCY253VDFm?=
 =?utf-8?B?UzNJSjlwVVZyNGtYaG93b0Y1M3A1L05hSmxackI4THFhM2QzcDlDZFJOZWpF?=
 =?utf-8?B?dFJ3Vm5KTmlHQ0xLRDJRUWVSdnV5dS96WG9NNlJtWFVWV0wrV2pCRzB6NFBV?=
 =?utf-8?B?OGFoRXRLUkZ3NjAzUXFrNHJHK1hoRVFNK1pzdkJMKzhKOE01V1BMd3VyS1Jn?=
 =?utf-8?B?YXdMTERUN2kyMmt3RWw4MW80QS8rU2N0amJ4Z28vdUlxbkFTOXBhdmY1UTVy?=
 =?utf-8?B?V1Z2am5jMTlvWUxJbWhXVlE2L1BrYWNUZ1FIWWR3SHZyZ2daSnJLUXNuK3J5?=
 =?utf-8?B?TjJvM2FUb0JLcTFwQ0EzYy83M0tRTkl0NHU3MER0Z2VvY3gvYmJqY0pkNlly?=
 =?utf-8?B?eXFFYlBjOWFTVlNEQnNPS1l6ZlVJMDJZa092Zk1aOXlkcTZlcWh1YlVBa2hx?=
 =?utf-8?B?cFBLT0NkekVKNGVQeXpwYy9QelF0NDlZVXN1bjh3UFJNOGpFb2pUcklJVmhQ?=
 =?utf-8?B?QlEvck9ZcCtmZFR2RjNIT0Y1OWY0SzI1V3FPc2NUbU1TVThuMkIzZEhabFkw?=
 =?utf-8?B?QU13aWY5SDRWNXBTc2RuRk1CNUxhTis3R2hEdlhTOW5td1NjRmhTV05OWlZX?=
 =?utf-8?B?dFF3bzBFMm81UFRadjJZb1ZmUlhCNkEvdjh3cjV4ZWdzdUxEWTNPQ2VDRjVY?=
 =?utf-8?B?Q3hSRDJ1bkNVbUhBV2dtNWMyRWp6VDRscjlhd29hamNMRjhvcTVJa0x6cUdn?=
 =?utf-8?B?Y0FpQXhjOWpZKzQ2aVdmaTdOV1RlV0RSZzc3RmtZNERGM1N6QzZJNFEyS2JG?=
 =?utf-8?B?Ni9FMmxMcllSc2VGT1JZRDZWajVvSStGazV2UXJUajQ4UkgyRjVLL2E2VUFM?=
 =?utf-8?B?Q1ZLYlFJbTZwMmRqK0dyaHMxMklJOUVTbTVWczY1V01IK1NwREhFK2VTMjFV?=
 =?utf-8?B?S1c5ZjVBQkF4NUIrZExhYUJnZW95eXl2ZTRQZ0hPL005Q0xMSW9EWlFjYWdV?=
 =?utf-8?B?bEY2ZkptZ0FkM2NXck5DUUd2VzN5QmYwK2szM2lmKzVEem41U0ducklCb0hB?=
 =?utf-8?B?NEcyVy8wTUVCMzJ3Rnc5S2xDM3FIZnFFY1g0MlB6VlhBemN0bkVTS3E4c3B4?=
 =?utf-8?B?a1l0b2RmNTFBTjhZVUZ6dXQ3NlRYZEpNSXZWOXlvSU9WN1ViOTZHM1VLY2F1?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DmHrjA6aT96LZUjYmVkbP8ncs9vZfUOGMt30XyqjM9G6hiUuonGrwYV5APsX1HltaCqEPDwZC2PI9W5rfsxKSZGrnH88pKOCcRk+obkhvFkF8dDTYfbXEwhvjqOv+2tEzXkQw6pGLjWeS9JF/fV4jz3z1aI93rFkOlliDKnEMhbIlf+OALKhAGX99gx4o7iYlGyJMC+NDMaagUbinDecKY27lmODCRDkHp12iE1B+7DfawO5mof5Jaex4Q10BOjGSwfEwksJ406xGZ5cC3zKRjwZTvPwQUEI1+5g6dvGGxO8MFbdiisz2b4S5WjADNVBlBSqOaCTOmbiK1MpirITcanmGg1GzyKy7SNrdfcQSPYP+3qM0ZLBfv2IysMSZuIgo8MQuAhzmb6ioeMOzB4wfBQUNsNRbVASUj3ysD8EBGkUj8sTsTLYkJNtcPincSDUPF3nb93ZJn3uIRpHqqv9pwAZXfa9mWGj+65XKonAcBbhRluYyCnqP9ZbLyGXrNqlUpgNbOxLqdHkT6Ev3Gx5w+RXoQQySEEnfboTKeUIShHchmU+BNZj2NKT4PQZvsaDV8ELFR8AWU8B55B+PuZ9zObsHUdxb+pxeUt2YljRbgI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1e937b-7ddd-4856-f005-08de12f853c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 12:24:50.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7RKG/tKZrHVWYBpdxM2hAoG1NqrKqgs/u8gvgbBOgaPtJow5fgAhD3ucP/Yx60GGJPniL2FbXsM7vAjPiQMnKaiYJwqI6vL9yq75KN1zPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240110
X-Proofpoint-GUID: GtakjmHfxnNm-6I2NAQaQK755gGgmmDr
X-Authority-Analysis: v=2.4 cv=bLgb4f+Z c=1 sm=1 tr=0 ts=68fb701a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=BM6KPH7DSUm2abqAIDsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfXy5Wo5a7OkrsK
 78Er1IXMC226OjQq8gWOUHSwxaJKSnCrNleB5oX+HbIeljUnQW8KaSAMOrj6fE3x3Oz1iZJ9pE+
 sONppuajB+DZ+cHwjWS3glAu+kXEXzLt6tUeD5uT/nHElH/Zcs6HkWuBt1s5+0xOcMsuiF19Uba
 mNSYfOVkJmc6XRCaxNh6Hn/hGwNL+NlW2ig0OuCFAHd5fAvRIT+ZHSda8HZh474pNWPIqn1SERV
 KQOBl62kzmoji16ry//1YwY6ZHgCzuIGOFnKcpT9LiPrhEKsMLiwnvmLRfu/0ifXLatZducTRuC
 TS0ShcDkmKdqdwWCimPnBvZFwpMGIE6MBscqzmA9wd90af490sta7IPGlsqAw1Ha6Fd+wmJpjGY
 nCL/Uss0UN7Dzo/Sfiiff5A+UNjeIkic8IeUl1WIFDQNaoQa3as=
X-Proofpoint-ORIG-GUID: GtakjmHfxnNm-6I2NAQaQK755gGgmmDr

On Mon, Oct 20, 2025 at 05:33:22PM +0200, Jann Horn wrote:
> On Mon, Oct 20, 2025 at 5:01 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Thu, Oct 16, 2025 at 08:44:57PM +0200, Jann Horn wrote:
> > > On Thu, Oct 9, 2025 at 9:40 AM David Hildenbrand <david@redhat.com> wrote:
> > > > On 01.09.25 12:58, Jann Horn wrote:
> > > > > Hi!
> > > > >
> > > > > On Fri, Aug 29, 2025 at 4:30 PM Uschakow, Stanislav <suschako@amazon.de> wrote:
> > > > >> We have observed a huge latency increase using `fork()` after ingesting the CVE-2025-38085 fix which leads to the commit `1013af4f585f: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race`. On large machines with 1.5TB of memory with 196 cores, we identified mmapping of 1.2TB of shared memory and forking itself dozens or hundreds of times we see a increase of execution times of a factor of 4. The reproducer is at the end of the email.
> > > > >
> > > > > Yeah, every 1G virtual address range you unshare on unmap will do an
> > > > > extra synchronous IPI broadcast to all CPU cores, so it's not very
> > > > > surprising that doing this would be a bit slow on a machine with 196
> > > > > cores.
> > > > >
> > > > >> My observation/assumption is:
> > > > >>
> > > > >> each child touches 100 random pages and despawns
> > > > >> on each despawn `huge_pmd_unshare()` is called
> > > > >> each call to `huge_pmd_unshare()` syncrhonizes all threads using `tlb_remove_table_sync_one()` leading to the regression
> > > > >
> > > > > Yeah, makes sense that that'd be slow.
> > > > >
> > > > > There are probably several ways this could be optimized - like maybe
> > > > > changing tlb_remove_table_sync_one() to rely on the MM's cpumask
> > > > > (though that would require thinking about whether this interacts with
> > > > > remote MM access somehow), or batching the refcount drops for hugetlb
> > > > > shared page tables through something like struct mmu_gather, or doing
> > > > > something special for the unmap path, or changing the semantics of
> > > > > hugetlb page tables such that they can never turn into normal page
> > > > > tables again. However, I'm not planning to work on optimizing this.
> > > >
> > > > I'm currently looking at the fix and what sticks out is "Fix it with an
> > > > explicit broadcast IPI through tlb_remove_table_sync_one()".
> > > >
> > > > (I don't understand how the page table can be used for "normal,
> > > > non-hugetlb". I could only see how it is used for the remaining user for
> > > > hugetlb stuff, but that's different question)
> > >
> > > If I remember correctly:
> > > When a hugetlb shared page table drops to refcount 1, it turns into a
> > > normal page table. If you then afterwards split the hugetlb VMA, unmap
> > > one half of it, and place a new unrelated VMA in its place, the same
> > > page table will be reused for PTEs of this new unrelated VMA.
> > >
> > > So the scenario would be:
> > >
> > > 1. Initially, we have a hugetlb shared page table covering 1G of
> > > address space which maps hugetlb 2M pages, which is used by two
> > > hugetlb VMAs in different processes (processes P1 and P2).
> > > 2. A thread in P2 begins a gup_fast() walk in the hugetlb region, and
> > > walks down through the PUD entry that points to the shared page table,
> > > then when it reaches the loop in gup_fast_pmd_range() gets interrupted
> > > for a while by an NMI or preempted by the hypervisor or something.
> > > 3. P2 removes its VMA, and the hugetlb shared page table effectively
> > > becomes a normal page table in P1.
> >
> > This is a bit confusing, are we talking about 2 threads in P2 on different CPUs?
> >
> > P2/T1 on CPU A is doing the gup_fast() walk,
> > P2/T2 on CPU B is simultaneously 'removing' this VMA?
>
> Ah, yes.

Thanks

>
> > Because surely the interrupts being disabled on CPU A means that ordinary
> > preemption won't happen right?
>
> Yeah.
>
> > By remove what do you mean? Unmap? But won't this result in a TLB flush synced
> > by IPI that is stalled by P2'S CPU having interrupts diabled?
>
> The case I had in mind is munmap(). This is only an issue on platforms
> where TLB flushes can be done without IPI. That includes:
>
>  - KVM guests on x86 (where TLB flush IPIs can be elided if the target
> vCPU has been preempted by the host, in which case the host promises
> to do a TLB flush on guest re-entry)
>  - modern AMD CPUs with INVLPGB
>  - arm64
>
> That is the whole point of tlb_remove_table_sync_one() - it forces an
> IPI on architectures where TLB flush doesn't guarantee an IPI.

Right.

>
> (The config option "CONFIG_MMU_GATHER_RCU_TABLE_FREE", which is only
> needed on architectures that don't guarantee that an IPI is involved
> in TLB flushing, is set on the major architectures nowadays -
> unconditionally on x86 and arm64, and in SMP builds of 32-bit arm.)

Yes.

>
> > Or is it removed in the sense of hugetlb? As in something that invokes
> > huge_pmd_unshare()?
>
> I think that could also trigger it, though I wasn't thinking of that case.
>
> > But I guess this doesn't matter as the page table teardown will succeed, just
> > the final tlb_finish_mmu() will stall.
> >
> > And I guess GUP fast is trying to protect against the clear down by checking pmd
> > != *pmdp.
>
> The pmd recheck is done because of THP, IIRC because THP can deposit
> and reuse page tables without following the normal page table life
> cycle.

Right.

>
> > > 4. Then P1 splits the hugetlb VMA in the middle (at a 2M boundary),
> > > leaving two VMAs VMA1 and VMA2.
> > > 5. P1 unmaps VMA1, and creates a new VMA (VMA3) in its place, for
> > > example an anonymous private VMA.
> >
> > Hmm, can it though?
> >
> > P1 mmap write lock will be held, and VMA lock will be held too for VMA1,
> >
> > In vms_complete_munmap_vmas(), vms_clear_ptes() will stall on tlb_finish_mmu()
> > for IPI-synced architectures, and in that case the unmap won't finish and the
> > mmap write lock won't be released so nobody an map a new VMA yet can they?
>
> Yeah, I think it can't happen on configurations that always use IPI
> for TLB synchronization. My patch also doesn't change anything on
> those architectures - tlb_remove_table_sync_one() is a no-op on
> architectures without CONFIG_MMU_GATHER_RCU_TABLE_FREE.

Hmm but in that case wouldn't:

tlb_finish_mmu()
-> tlb_flush_mmu()
-> tlb_flush_mmu_free()
-> tlb_table_flush()
-> tlb_remove_table()
-> __tlb_remove_table_one()
-> tlb_remove_table_sync_one()

prevent the unmapping on non-IPI architectures, thereby mitigating the
issue?

Also doesn't CONFIG_MMU_GATHER_RCU_TABLE_FREE imply that RCU is being used
for page table teardown whose grace period would be disallowed until
gup_fast() finishes and therefore that also mitigate?

Why is a tlb_remove_table_sync_one() needed in huge_pmd_unshare()?

It seems you're predicating the issue on an unmap happening without waiting
for GUP fast, but it seems that it always will?

Am I missing something here?

>
> > > 6. P1 populates VMA3 with page table entries.
> >
> > ofc this requires the mmap/vma write lock above to be released first.
> >
> > > 7. The gup_fast() walk in P2 continues, and gup_fast_pmd_range() now
> > > uses the new PMD/PTE entries created for VMA3.
> > >
> > > > How does the fix work when an architecture does not issue IPIs for TLB
> > > > shootdown? To handle gup-fast on these architectures, we use RCU.
> > >
> > > gup-fast disables interrupts, which synchronizes against both RCU and IPI.
> > >
> > > > So I'm wondering whether we use RCU somehow.
> > > >
> > > > But note that in gup_fast_pte_range(), we are validating whether the PMD
> > > > changed:
> > > >
> > > > if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> > > >      unlikely(pte_val(pte) != pte_val(ptep_get(ptep)))) {
> > > >         gup_put_folio(folio, 1, flags);
> > > >         goto pte_unmap;
> > > > }
> > > >
> > > >
> > > > So in case the page table got reused in the meantime, we should just
> > > > back off and be fine, right?
> > >
> > > The shared page table is mapped with a PUD entry, and we don't check
> > > whether the PUD entry changed here.
> >
> > Could we simply put a PUD check in there sensibly?
>
> Uuuh... maybe? But I'm not sure if there is a good way to express the
> safety rules after that change any more nicely than we can do with the
> current safety rules, it feels like we're just tacking on an
> increasing number of special cases. As I understand it, the current
> rules are something like:

Yeah David covered off in other sub-thread, not really viable I guess :)

>
> Freeing a page table needs RCU delay or IPI to synchronize against
> gup_fast(). Randomly moving page tables to different locations (which
> khugepaged does) is specially allowed only for PTE tables, thanks to
> the PMD entry recheck. mremap() is kind of an weird case because it
> can also move PMD tables without locking, but that's fine because
> nothing in the region covered by the source virtual address range can
> be part of a VMA other than the VMA being moved, so userspace has no
> legitimate reason to access it.

I will need to document these somewhere :)

Cheers, Lorenzo

