Return-Path: <stable+bounces-205074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B2DCF8229
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 12:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DDC9301691A
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9B2989B7;
	Tue,  6 Jan 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="brQwwUwm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kPTIsJpu"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446963A1E7F
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700091; cv=fail; b=DrwvbRMb4b9/srE6QewgL9e4VBkEEBz97VW9CB+N4Aw4Zc/MDQXOYf14bPb9H676WI4C5e5sDPG2QLsphj+pIGA7oK9CL7UX0dSxsuXDrE2X6ehmf9E5Lv/R7VG1KXtyTX9Mj/Wd3ExUj2sGmN+NQGc7yUjm0C5M0uqOnOqHO1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700091; c=relaxed/simple;
	bh=dwEV8REQGUlj1ZK0CV/6stxw5RtW+PkgMu9iHaCB/3g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oaJ0gBWifO1vHsdGW8dBch4APXn2SIG03ULNujeqVXn4Dq9ngsrPHBlUYho8BejSVZmhdrlfZKeIarMmXdxeeuwOiFCYMTL3tWkvmEGQUNuvnQ0EYG6eLoAD2JHqKGMCIJPTZZbdJt5CYZt2AxRWjrK/3NLxrDUEvCQwKKVWe10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=brQwwUwm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kPTIsJpu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606BZCaQ3659994;
	Tue, 6 Jan 2026 11:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=O7NrORcuKvhtmo9U
	D8sjXmhmbNfWF7fV5A/hSEtINyo=; b=brQwwUwmosEE0SptaeL5/y3GexhklAQ+
	1jTokOpxndYfxEqa4Cthg2OjzHZH7iErEc2lYp5oz1cu5eMWCoqEa5zr1MUZf3Nk
	HSh3MmZ13/k78N7kfVi7zeL5MbSLUr1tWDquFdT6AxShOZE0t5X/uMIsDfi2qJVG
	+QXxKHVM2J0rm/boOpBUbnRFYGTxJb3ofajnPPVIqW7lYu/RP+RwlgdgCqsCT9vZ
	AtGHY0euV3BKrmuYMhLHbhAREId6v2DVDTJjLH/tHwZuHKI4hspdxbhhhj+vmEZ/
	oDqxbXRwE5sKFoT5hwi5KGTlugiHWT0dDtOtsDyTeb2d6ingXvX+xQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bh1n880b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:47:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6069ODxF026331;
	Tue, 6 Jan 2026 11:47:39 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjjrgvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Jan 2026 11:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvyTgCuimbFKsxBGv04idRyqbMTrI2ByBQAaWPQOJ2x1aZtdiZT3Qbi4tD6TMpyKODyBZNWjVDiLwszV20LTxpPPCdJ14PL+Ucquo3ygaHwRxc/NHFNn/frxoJM01CFYrV7IVYAUup7JG+gdtGbIQ4BFy7t80OpqKuq+Tsg0Q5DPRkhFc3R6onOZu+gO2laB7KNWVvE909Yt4Bqk3soalMa9TB8b7QX635bzk2I1m3jcCs5SVk9rCnZOPv+TxiWBhY4QnQcZKyl8YNiXYja/i9SLyRWs/vCma3SGlQxI0dtnvyQ5oBu/qAtjyuc2OOa4Fna2+CxhtfMRTiqvxILuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7NrORcuKvhtmo9UD8sjXmhmbNfWF7fV5A/hSEtINyo=;
 b=CMTEmS9QAK+s+/FAgzVBWxoAKFo/h8vty0DGgoogvaf3cTxDd0mXS2x7RP4zJmUgR72XzmUGweWhrsOhiCYN2nosaFLD9YtY4rKwttT0zlKJoVMDI9W0BZlI8f8iEthdSGcxMTAivexUWeuAlTbzN9Hd/glM9EGIWQTvqbob7EyQY1TFsz9HASo8rvv1M5UEpTZcOPMX7q06pxNFbh7A6OL14XGnQXIaXCjGSlZ/3fxl5b9KbCS96uu4YVusj2vyw94IROOHkBcC2kZKTvduSdke14ziYNiZlWv0wDNOBcZnGf5ZHSyudQvmTq0HSY20gjRcnBEfCOYtrA7lJeporA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7NrORcuKvhtmo9UD8sjXmhmbNfWF7fV5A/hSEtINyo=;
 b=kPTIsJpuLPYxVqwBEMDPgRNz731idFCvR7nCBnlCNwApBMHgsLgPJiHNiJ5nUp1Iw64Cl3/b/ABgRCY4xAj8RruCcTVUUU/7axpF0iRdUuEeTh00sfBQWUSwSPk02+qRYmc19jIaWCaqSGhMAm6LQyu636eholypHkeScjqC4NY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB4551.namprd10.prod.outlook.com (2603:10b6:510:38::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:47:36 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 11:47:36 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 6.1.y 0/2] Fix bad pmd due to race between change_prot_numa() and THP migration
Date: Tue,  6 Jan 2026 20:47:12 +0900
Message-ID: <20260106114715.80958-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SL2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::26) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3f52d2-37cc-4677-205e-08de4d196292
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFZZY2ZWNlByMzl6cnBsV2xLMTl3TWhwREt0ZVE2a0ZkeFRaWFpaSjF5UDUv?=
 =?utf-8?B?RS9kdHJhWXBHRHlSNkFTU0NWYnpiNTgzTWdpM3FQRVMvNEFJUHprOXNkdlAy?=
 =?utf-8?B?WEMxbUVoVS9SUGJZUVdQYTRBOHA1MnByQ1duekQvTmhETzdYSUlyeUtUMFZN?=
 =?utf-8?B?a0NsajZFSjBXNFlOc3dubmwvQko1QVV4bHNPZUVoaWhLbmRxZHVlYjBqTG94?=
 =?utf-8?B?aTNLbzgrRlhtdUJtcEV3dGZMTlpNa04vWGVOUFhQeWtGb28ydS82ckRNYmNi?=
 =?utf-8?B?MXZLS3JMakExV1BheU8xcnlTVTRhcTV2S011VkJzQWpRWnVEVWdBT0RiWC84?=
 =?utf-8?B?c05ZOGdGRmx5K0JaYjBYT0JTR3N5YTh1eHlYUHhDc1hBaVZGOURVMFVvaXV2?=
 =?utf-8?B?VUUyVDYwYmdWeXJ5cklmSmZBdnRkUFZmNkxCYVdWQitreXZnYVZCdTJkNTQ5?=
 =?utf-8?B?ZWEwRkJSbWZJZGtqZW9xL0JPRVZxaFdoOGhzeFl3T0NhZmtLSUZQUUMybmN6?=
 =?utf-8?B?S2dKbjdXa1ZiWFoxVGlQT1BXOHhLSUhCQUV2ZTJhMHhWT1FZd1VwYnhzWWtC?=
 =?utf-8?B?RXpQZUI2Y0hzZ29uMjlQdXpma0FLU2ZxTWNMdU1Ja2JRV21kRXVGVEltZXkx?=
 =?utf-8?B?WHBndSs1NUFPbUlIbENuMTNpMngvR2dxS09JMGJWdjBBMjlJcXYwMC9VNkND?=
 =?utf-8?B?Zkc4eVRDeW1aeFRRUC9RWHhWVmxHd1BDZlZiVTJJUitVRFYwemo2cktQSW1q?=
 =?utf-8?B?NW5RYVltUHZMazZQUHkyMzZ3M3JvNnM0WmZPS3NmcFFIbGJVa2hCZFdoUzF0?=
 =?utf-8?B?S2NqUVJlRU1RU3M4MlN4UHg5MlVOdDNnOFFkdE1Ocm1nRlIrVVVqdVh4YjY5?=
 =?utf-8?B?VmY2b3FXT2NEbVJNa3FFQjBVT2lsMGF4dlg5M1crRDMvUXpRNjc0SGpQNFZl?=
 =?utf-8?B?R1BRclBscjRMUkJEaUhxbXZDK1J1dllJQWVsZVJGL3EwWGg4bVNhSXdwRXNM?=
 =?utf-8?B?R0ttZi9NYVpaNjVOaHZ4M3NrZndyNXRXQUd6YWZ0aGd4bGJGUUZGMzV1aVhF?=
 =?utf-8?B?aEZvcFFPVGxUQ3o2NUNZMmg3NjhaNU1zNTlXRC9OOC9WbGdDamNoV25EcFEz?=
 =?utf-8?B?c1NXMi82azlhYlFFSk90S21udkxzU3U1aWdCQ04vMnBnZnZ3aU1nYk5adU5j?=
 =?utf-8?B?YlhYSlZIVGV5VXFEL3IzWUwrM1ZpTHhhNHc4MzhVS05aaUpBS0ZJaFlOcENV?=
 =?utf-8?B?VlAvQ0RXME16OE9EeXpUTzlFWkpZY1N0Tmd4WEd4Rkp2TlJpS1QwTTg5NXZX?=
 =?utf-8?B?NTNBbXF3ZjZHRytUbEtLM0NBZy9sZllaWFlvdTk1a1JvQlVEV0VITks0WXFS?=
 =?utf-8?B?UnlxajZqa1pSVkpkaGZueUg3N1d1czJuT1BpZVlSNEo4SjNZeHE3MTlQazNq?=
 =?utf-8?B?TEI1VEJMU0Q4My9XZnFFZFVMN2VaUmNDNlVtVlltbE5BdExKUXNDZk9CUDBY?=
 =?utf-8?B?NWVBRS9ZOThNbGtKdjVyRmhJQSsybW96dGo0TmI5SEhoT0t0aHRHM0NtTnZy?=
 =?utf-8?B?ZTRuZGUxWUZzbnF4eUJaWm5vemVTeDM1MDVHQnFRWldvY1ZtbHJtT0EyczFt?=
 =?utf-8?B?WDIwS2hHSEwydEVoS1hrK2I2SDRQcDE2cUZrUlpaSnJRS1liQVhDbDMycW9n?=
 =?utf-8?B?aDFES0gzQnhabDFWTW1EOHJHNzBGek9PYXRjdldUK3F5RGRmNnBYcmthQnVW?=
 =?utf-8?B?ck1BMEo2TGlaOFR2Tjl4dzh0bW5HY2tPZ0xpME1WRlBDbzZ0dytGQVdTeFpK?=
 =?utf-8?B?Uk1HVzJRbnJ5SU02cEFWWXp0UlhxQmlVT2ZYMldDTmRSUHVuVWFtZnBTZ1FN?=
 =?utf-8?B?d1dLMnNVVEZpOEswYkRKWVNXUlRNYXJMZEp6TWZDQXlMN0VVS1p0L1MyM2d6?=
 =?utf-8?B?QytVWGpsdll2cmY2emtsMTQ5WnlYVXR6MlpBWFpQOTl1aExWcEIrSVYrbGs3?=
 =?utf-8?B?d1VaYVh0cnNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzFiVm03MzdobUJHK3Y3TVNuMEZDQmF3SE5WaE5JQVNuL0Y0SjQwYW01VXBN?=
 =?utf-8?B?aEw0QTYyZFhzTGg5cVVKVno5TCs5NVB0NEY0VGpTeEU3UnowNDhobjI4NTBJ?=
 =?utf-8?B?WmNpV1YwUDVQQXFTUFZjUFR1c1VJMUEzY3NrSlB6QklQNURUdnAxQmluaTk3?=
 =?utf-8?B?eGpvbTV5L3Ryd3UzeE9YcEtLcWUyVkE1eXkvNUwrTFJHdGs1bzF2YklGV2k3?=
 =?utf-8?B?bDRSeE9TdE53S2QwcjB0MzlUOE1EU1BpQlN0ZFJFRUYxYnpxYVMrcHZENklq?=
 =?utf-8?B?NUwvTUZYSzNBWmlFNmZJUnpmeDhadFFJR1d3Yk5rN2h5RXNzN2RXWGZmUi9B?=
 =?utf-8?B?YTFnNjFtTTd1WTk1SjYvcFBHTWQ1U0FVZlNlUGl5MWp6eGhCZTNRaGRHazE2?=
 =?utf-8?B?ZEUzVXBtVm82YmgySVVtMUtMZUM4YVYzSmVJV2kwSWVJWFJURElxc0hiWCsx?=
 =?utf-8?B?dld0cGUxZjY2OVNxUWhVSzZ6dTdYS3NLeks4Y01NNDFYQlJjdVI3eFhDeFdW?=
 =?utf-8?B?V01BT01NeGlyT0IwUnF6NjEyMjFqWjJDQ1pLdWhUTk55V3haZ1lIbnRpR3BG?=
 =?utf-8?B?ZmZkMWFnOXp2cWdQUUJvQ1B5M1dFN3hDcGxTOThKTXlKQml5dWdmcHUrMzNq?=
 =?utf-8?B?RUs0M1ZPRFFwZ0tCTzU5SUcxZE5KQm1NMVFzWTRlcVdBclZxajZ2c1ZPRW8z?=
 =?utf-8?B?RDNQdlVpdngzaUlVVzBaeTVQYjB6VWgwNHNsbXYrcm5hRU9SNXdiVEJqa1Nr?=
 =?utf-8?B?a3hBMWRlQlVaVWNzRU9NekxRZXRGVWFSRjdNUlJxeHFsaitlWjZ4SHlFYnJ6?=
 =?utf-8?B?aG9JbXg1UG5tZmdob0ZKYmpDNGszOVR0MU5OeW9NU25VUXQ3TUJmZ0ZFOFh0?=
 =?utf-8?B?WUVicmJOUHBBRnJaVkc3Y3A2Tko1Q0JjUHk1MFVJNkhnaEZITXdLeUhvOFEz?=
 =?utf-8?B?OUUyejdNeTBNWHV0bU1WeHoxNUl4QWJxZ1BPNkw0czh0N1M5Yy9CK1hpcUts?=
 =?utf-8?B?UTNPWC95bUFGMGF0YnR2allYRHF3bDhNN0pYM0x2c1IyVTZIbUNmN1B0Yldl?=
 =?utf-8?B?U2VYUVUyWlFwK05pdk8vOFh6L0tmVlEyRVVKZVpCNjN3dHB1QkMxc1pYSE9i?=
 =?utf-8?B?K0t5a3o0ZzFVSlF4ZjhTaUxUWm1iZEk4Qi9rZWlTQWxtVzM5UlRGT3JOYVdM?=
 =?utf-8?B?NXZsSUVyMkswYUJlcXJQemxmTktyR25BM201a2pLVU1GbjUxblpwb2lJYTVV?=
 =?utf-8?B?Y2pKY1orU1FOc05TWGFvdGNGUHZUaU5yWUZwaHNvcW1hZmhHS1djN2N2VzNQ?=
 =?utf-8?B?RkkwM25ieEwyMFZlakplRk5BZ2t4OHhHaUlxQTVjZ3Qybm5WTjdMZkF3bFJX?=
 =?utf-8?B?UlNZOWtuNzVkTjVnQ0FZUU1tZ1NzMmJYbjVJQTdPVTJlVmt1MEJta09jREhn?=
 =?utf-8?B?VFZDT3RrMUZaN3dMbll2UDUwM3RRa0RWWmFUL21MK2F2S2doTkxtNTUwZm8x?=
 =?utf-8?B?bUJTazQwdVE2NHliMjJVOFR2WWVCblJFT1NyUmlOem9rc2pxcndVS1orSDdN?=
 =?utf-8?B?ZUZEZFkrQ0h6MnRJNHFTSzU2OUQyVHJTYWFqZG15MFJFUUY4QXdGNFFwSlQ4?=
 =?utf-8?B?bi96bkRjZS9PcEtGdmtLYjEwRzBHcXFlZ2pSOFRnYlpWT3ZRYk9sSnBTQ2Ju?=
 =?utf-8?B?SkxnLzlXVGVmUFJpZFFOVWJLOElIVng2eXdVUVVicDg1clBWbGsyUGRJZy9v?=
 =?utf-8?B?bUo5eHloeEhVY3ZQNHNqZkkrSytPRmJBTTVTVWRld0ZoeVdvTENDcG5US1Fv?=
 =?utf-8?B?VVloYTM5Zk0yRXdiUVBhZHZXQlhFaVR3a084aXdJTkZDYVo1cTFZS2VzZkFv?=
 =?utf-8?B?eHlXNU9UTUZRTGY3aVgrbVhQODdMS2JiVmI0OXdrMFJqU3FTZVZ3cXdWRFJO?=
 =?utf-8?B?bzNDdHJodmhwQWt6dU5zMWpYdEM2Q0UzaWhQMm04ellvWWVEUmx6d29XOEZv?=
 =?utf-8?B?dmt6OWdpYm5oQXpFUHFGWlRKM1FGLzBxSUViRXBTTVNpQm5vSlN5OEI4Ykcv?=
 =?utf-8?B?bXdKQ3lsSHhmdk5GQ0VxRW8xd0RUUENsOEpVckY0VHZZUXl6ZWlVRVRmWTAr?=
 =?utf-8?B?RGFTckh1Q2ttUndVd3V0NWQvSk00RnBWMDczR3VBMGNvS0NuOVhCc1FKNi82?=
 =?utf-8?B?cTQ0QlduQlFoWU9uNFcwUjVqL2JzQ0cvVnJCdW9hZ1A0c2RkQTdXM3M4Wkp2?=
 =?utf-8?B?T255K3MvaFhSenhiMG1CWDRNTG0vTldLSm9LT0NHMjBRWm1URjVINTNmUSs1?=
 =?utf-8?B?RVgwanc3QXVWSVh0WGhMc1grQkFtbC9uazRVWE1vZk9KZFFSQTgzdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R++GFrUbF/GvSb40rJ7qj/ksH4ZUA9mk8xJcTpekUkD2yRGN78JKBX4j11UQpcKHsemNb4topJhGI+LqIL4iA8y5tNfT6E3UZrzC1Y2RDeymB+4NxAd+MPZuI8UCnoOCSyLqOCT90/ryGdYz/YwBwYJJUuzslNYIt7yhIqFy+4fKUzhsTM1AYg2K1en8xWC0hQA6V1T4tZA5TeIcMIy81oxkKLpWrC7zq2Bbq80iEwoJ8Iz8Xn/TATI+bKCVtrD3yzVW6oHNCQa8Dk4S8lNV7XYnjmHW7gT1B3tz6Ozc94XhDPRH8tA/VSJP/Dj3CtSdLx+XO84LsDClvqkgwy5HBKPagIwY8yjJfqNDZR5cNu9VSRH8yMvz9IOEdd436MukQKR15worBtzL3hs0oDdzopJb2MZ8ooBvzZQ8vkWjhT9IYrsqhNb0p9KxQbLd1t8aVUb6oDx941nnj2JXHZXU+ALfOPuNp4l7cCxCvEx7EbBzh+6qRlPxcA487PUjlcuEN7YIlqW7ZzeTWciiNivOsFpZwjkShyPKPHXTygU+rwEPl7w3SYH6O+g450H7QA5aB/fHwEpmTo1/Ti2sCIx1bi3Sm/54A25pZSnnarYApOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3f52d2-37cc-4677-205e-08de4d196292
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:47:35.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4DPJkLeVmYQZd3fnxM40yctq+p3ZR86J67hYA0bD88eIJ0wk1nWkV2Dgq18uvZTSNsLzzbO29fOCGh7V66zeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601060101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEwMiBTYWx0ZWRfXz8vtq7CUwm78
 zAEJjH7C8lxGZLEUc2kYY3lVPeQKyDjCZ59eT1y+AXUj6tHQbNTRob5IPHcxO7sUPEfPBh6ZEZv
 ABD9vqNoVZs7up/7M8EUbTf8d/P+vnT7QVMJf9GnrrP3NYzqw9jNCHVqWwEnLLYTaRPunVbvg+B
 InjNUdltOACb57Zg1BEZ7o+jVED6ZNrb3rCWFxptV0cubtcPfQGlCgEr+5jM1pMfTAm293hgGxm
 HZGeeUJffMdHa3ONq9XsUnWsABnhOgwWsegM6E+jNXaMDzq4wQOT6nP/BhkICsUS2LvVJJOiTaB
 Fd2BjXr4oxPmiRfwwC71ZTyHyF3KIAEKUD5lIfSB5eID3bsqLOr3RyBkbcj+FDkGK2HyEZTtoYp
 DofKaR1W0M0cFFlHq/iewRATP2Q9loULNsi/uF3e/0OQvd9wRiXw9qMl/bCC5MOBRHmymj+KSgW
 024XZ89eEC9VX2ANs1q8RVyXR987wVNGwwh3IpfE=
X-Proofpoint-ORIG-GUID: CX5ekd5ashN9eXmwRRpWPOfNkUFt9oUv
X-Authority-Analysis: v=2.4 cv=aetsXBot c=1 sm=1 tr=0 ts=695cf65c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=tRLCnyKIFssYOeyxpVgA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12110
X-Proofpoint-GUID: CX5ekd5ashN9eXmwRRpWPOfNkUFt9oUv

V1 -> V2:
  - Because `pmd_val` variable broke ppc builds due to its name,
    renamed it to `_pmd`. see [1].
    [1] https://lore.kernel.org/stable/aS7lPZPYuChOTdXU@hyeyoo

  - Added David Hildenbrand's Acked-by [2], thanks a lot!
    [2] https://lore.kernel.org/linux-mm/ac8d7137-3819-4a75-9dd3-fb3d2259ebe4@kernel.org/

# TL;DR

previous discussion: https://lore.kernel.org/linux-mm/20250921232709.1608699-1-harry.yoo@oracle.com/

A "bad pmd" error occurs due to race condition between
change_prot_numa() and THP migration. The mainline kernel does not have
this bug as commit 670ddd8cdc fixes the race condition. 6.1.y, 5.15.y,
5.10.y, 5.4.y are affected by this bug. 

Fixing this in -stable kernels is tricky because pte_map_offset_lock()
has different semantics in pre-6.5 and post-6.5 kernels. I am trying to
backport the same mechanism we have in the mainline kernel.
Since the code looks bit different due to different semantics of
pte_map_offset_lock(), it'd be best to get this reviewed by MM folks.

# Testing

I verified that the bug described below is not reproduced anymore
(on a downstream kernel) after applying this patch series. It used to
trigger in few days of intensive numa balancing testing, but it survived
2 weeks with this applied.

# Bug Description

It was reported that a bad pmd is seen when automatic NUMA
balancing is marking page table entries as prot_numa:
    
  [2437548.196018] mm/pgtable-generic.c:50: bad pmd 00000000af22fc02(dffffffe71fbfe02)
  [2437548.235022] Call Trace:
  [2437548.238234]  <TASK>
  [2437548.241060]  dump_stack_lvl+0x46/0x61
  [2437548.245689]  panic+0x106/0x2e5
  [2437548.249497]  pmd_clear_bad+0x3c/0x3c
  [2437548.253967]  change_pmd_range.isra.0+0x34d/0x3a7
  [2437548.259537]  change_p4d_range+0x156/0x20e
  [2437548.264392]  change_protection_range+0x116/0x1a9
  [2437548.269976]  change_prot_numa+0x15/0x37
  [2437548.274774]  task_numa_work+0x1b8/0x302
  [2437548.279512]  task_work_run+0x62/0x95
  [2437548.283882]  exit_to_user_mode_loop+0x1a4/0x1a9
  [2437548.289277]  exit_to_user_mode_prepare+0xf4/0xfc
  [2437548.294751]  ? sysvec_apic_timer_interrupt+0x34/0x81
  [2437548.300677]  irqentry_exit_to_user_mode+0x5/0x25
  [2437548.306153]  asm_sysvec_apic_timer_interrupt+0x16/0x1b

This is due to a race condition between change_prot_numa() and
THP migration because the kernel doesn't check is_swap_pmd() and
pmd_trans_huge() atomically:

change_prot_numa()                      THP migration
======================================================================
- change_pmd_range()
-> is_swap_pmd() returns false,
meaning it's not a PMD migration
entry.
				  - do_huge_pmd_numa_page()
				  -> migrate_misplaced_page() sets
				     migration entries for the THP.
- change_pmd_range()
-> pmd_none_or_clear_bad_unless_trans_huge()
-> pmd_none() and pmd_trans_huge() returns false
- pmd_none_or_clear_bad_unless_trans_huge()
-> pmd_bad() returns true for the migration entry!

The upstream commit 670ddd8cdcbd ("mm/mprotect: delete
pmd_none_or_clear_bad_unless_trans_huge()") closes this race condition
by checking is_swap_pmd() and pmd_trans_huge() atomically.

# Backporting note

commit a79390f5d6a7 ("mm/mprotect: use long for page accountings and retval")
is backported to return an error code (negative value) in
change_pte_range().

Unlike the mainline, pte_offset_map_lock() does not check if the pmd
entry is a migration entry or a hugepage; acquires PTL unconditionally
instead of returning failure. Therefore, it is necessary to keep the
!is_swap_pmd() && !pmd_trans_huge() && !pmd_devmap() checks in
change_pmd_range() before acquiring the PTL.

After acquiring the lock, open-code the semantics of
pte_offset_map_lock() in the mainline kernel; change_pte_range() fails
if the pmd value has changed. This requires adding pmd_old parameter
(pmd_t value that is read before calling the function) to
change_pte_range().

Hugh Dickins (1):
  mm/mprotect: delete pmd_none_or_clear_bad_unless_trans_huge()

Peter Xu (1):
  mm/mprotect: use long for page accountings and retval

 include/linux/hugetlb.h |   4 +-
 include/linux/mm.h      |   2 +-
 mm/hugetlb.c            |   4 +-
 mm/mempolicy.c          |   2 +-
 mm/mprotect.c           | 125 ++++++++++++++++++----------------------
 5 files changed, 61 insertions(+), 76 deletions(-)

-- 
2.43.0


