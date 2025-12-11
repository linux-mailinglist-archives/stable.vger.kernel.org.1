Return-Path: <stable+bounces-200770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD63CB4DAF
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 07:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45036305D1D1
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 06:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90CB295DB8;
	Thu, 11 Dec 2025 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rmKIPqVr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD2286D70
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 06:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765433532; cv=fail; b=Is7zDsEN4z49aYj6F2ZRfK3PXYsRZHsy4hhIypV0FwcJDNbD1QCIUSoj4zU+WFSqGcIfdWhxY4bpKk6pmaEhsYOZ1k3HP9doKWazRttLmxMYQmPJMv9s9LuA3qWk7M38SnaDKt0fBMoqmyzF0CWprXJANIvBczdZ2WoEj8Kb4JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765433532; c=relaxed/simple;
	bh=25vgXgLm7sfGEN6AHpzjC/nRqteYUa8KT8IVur0Y+RI=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hXOMenfhaGlCZd2aLJpfHnmKGmBXHqPl15Z62uQY+qE0VNfE7KGCKw8mdh4OM6ZMG5zrR+Kf1KQkWA6rPKGCjXRboQt6BfL3hNiyjds+kHdM8Eb8iqff7L72TVxer9/ujUiaMxAHvXtcUfvh9S9GgAuCEQOlOWGR+sKEpL+i2OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rmKIPqVr; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BB5cc1t3736619
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 22:12:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=yalbkzWd2sNR6YRx8C9inZIDkYwlCaDlVVAydBUewyU=; b=rmKIPqVrcheT
	KXj9OJFuQVAwVaelrtWXOmiKKyu3HQQrUCeYVE3EZP87MHo0D0aI1tveCh9Dcp3t
	JqK3LL8laDfpq7+s2LmOyimsdpdv5UNmhdVmtUTpyVDK805KG/Xat8mGUWfSeFI0
	v+vCsYgZDJnOzOplF/PLOaBjw5mqIoT8zoKSE4kyoaI/aCbGg7H7kTFkmCtovkq/
	bPRFK2OAVRFLC1aUJG2KJSH4ZFtySsfQD0slsHWRTginq54C5kiOcmmnvrxje/oc
	m/AQQMCDUOzhuZLe2oJObMT3rlNI8CssyS6T4EeYbyq7FKVdlLtVyA6KiJLvqbqe
	fPvTMvQHwA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ay07u1puj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 22:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCZZ3AJ/fA2e/aJYow2PlwlusyGsvi+sqvorkSHBRzMCiDM3eoSLl1EWMChvwSgNZG6vyKzDBLebYGqyESu2/scOLdHF70SBMjzxJpw5JMg9bVTa59+jKuPJbXC1Jed4pPLntSLdiRxe8wlNvf/haUT7v0fPW/eorQLvOJ7O7FxlBJmu1oVeU8SqgSIqJY8qTiHCCrb6C6fDJUibubUbQCljzZjdCC0BhkpffscnlHyBx5O1azn7vHHjH0ePkhXk14k5NC45mPAKfQI8ujZfEYsvBrJ22/aBjQf7feE2McGicfcfJ3xGNUffig1C0xE0+8O9wBMdH5nwxcrUnsAouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yalbkzWd2sNR6YRx8C9inZIDkYwlCaDlVVAydBUewyU=;
 b=oR2UXd+q44RBifmTA2ztGkAbU9Yp7MGZydoN73gNLCdeTo6mqNXBmkzOvbtMVX/V7L+rgff0PLVr9kf3Ib7YydA9UFN+iDdoXdMEhe1pykICZ2kYg5ZgsxQVjuASE9VejqxzVGqSeVRIHbaZUYbPYyfrUPu0gbtGuK/p4N5hsS2kIu/XaBZ3+vDOpbjZynKF+yordAjj1l/XdDjwlBOJFPYfASRAyhg3C+Qti88zr5c9FxaanOobdT9p+NLgniJ/U9Gi4VioS4gTQtHzn/a3gXI92rANzAbg1sb3xSZGIwiGYbsw4Uw1Z9Y6QAV0UVh4SfXj3ulbGEGGqC6V+yhHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 06:12:06 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::76d2:8036:2c6b:7563%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:12:06 +0000
Message-ID: <ddd53a77-1e95-4307-a04e-9eeeadf98c80@windriver.com>
Date: Thu, 11 Dec 2025 14:12:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Request to backport net/lan743x crashkernel fix to 6.1, 6.6, and
 6.12 branches.
From: "Zhang, Liyin (CN)" <liyin.zhang.cn@windriver.com>
To: stable@vger.kernel.org
References: <e349d73b-43d3-4f4e-b5d5-44df0c91f8f4@windriver.com>
Content-Language: en-US
In-Reply-To: <e349d73b-43d3-4f4e-b5d5-44df0c91f8f4@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|LV8PR11MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d490c85-56d4-45b8-1783-08de387c35e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZE1rdm9nWWY2ZjFUaU43WTY2MmpPcXpBcTVKNU5MZ0tWZGI4TGYvTW1EQnJ5?=
 =?utf-8?B?QXdoWHU5bXM4TGpDTWpIeXh6YUNaWXEwS1gwRmNVTm5wcTNwbGllenI1NThY?=
 =?utf-8?B?QytiMTFENjIxaXZ0SHJ1YXd4NCt0amorWXNvRVBraFhENGtlbUkxTjJFZFVQ?=
 =?utf-8?B?SFZJSzd3dzVxMUc3Z3pBc3FjVnJvNDNZN2NSK2svWUM3Ym8xUVdkTWlHenVv?=
 =?utf-8?B?Wm9DdjdSTW94ZDJnNWJXOU9XcE1ZNGpZbnJWZXBUbkx2RkxWMzNWV0xEUjJ4?=
 =?utf-8?B?cGFlNGlaS2t6SU53eENkN3FvZW5Zbm50YXZacVBuaFlPOGhqc0hTTGtVMmsx?=
 =?utf-8?B?WXlJU1JtbEFicHpNV0xDNUJxbEppd2hia2hrajV5SDFzQXhLcFFqN0o0bmRs?=
 =?utf-8?B?eCswTFVVUWNpYS84dHV2ZW02MG1zSHpUeEg2d2hEckN1TUNoQWdWUHpRNE5D?=
 =?utf-8?B?OFV6MmpoOFZnd2JXT3UreEtIRjFlVkJxSnZpOHhXeWQ0MmZRZXVrU0E4eHoz?=
 =?utf-8?B?T20reTVlK1pBb2ZacUpkaEw4aTJTNnlBdXUxYjFKdUFQYTh0bmw1Q3BIUTVj?=
 =?utf-8?B?M0YwVGZwdHh4ZzFGYkx0aU9oUm13UXVvSXhGcHVyNjNjbkNsSW1ybG5WQ2s2?=
 =?utf-8?B?anJST3VocHhzL2htcFpTdXRmZVlyR3llTzJ5R1JpSUVlVEhJTjMxZS9Ubkxx?=
 =?utf-8?B?SnJJRkYzS2tFMEtnVUVWOXgwc2NpZ2tsKzM1SENTckNxV1BDNzNLbWIvSVJl?=
 =?utf-8?B?RnJMVU9WM1N0SFN2RGw1WTIrWTdMbHNidTk5RlI4NHBVd1Zody9pTlpoQ1JL?=
 =?utf-8?B?UTBzWE1XUk9IQVNRUlVNVzlFcitteE1kcU9yS1JXSDN4azZQZVdTTWhpYlRt?=
 =?utf-8?B?elNWR2pZb0NIWS8rSWhBQkxUcVVWcVlLTVNWYjdwNkNjWUR3NWd1VDA0eHNJ?=
 =?utf-8?B?a1NmdFdUeTdydDlrKy8yNGVQdUpuRGhSS0UwVjRTVElSaC9vUGR3eDc3Mlc5?=
 =?utf-8?B?VVBIWWVWMnAycHcyTWJkWnYrRElsczFuVy95cDJZbnRXd1V6RHkwa2F3bGQv?=
 =?utf-8?B?dGdmWE1kZzRvOS80VUEwNWVQSG90a1RwVlJHSndQZFFrclNXQlV5SzVGWFRK?=
 =?utf-8?B?QVVwS0JjUG9yY3FpN1l4VnVndmVLa1ZXRDBjMzd0RGw3ekpxUDRiTmkybUhG?=
 =?utf-8?B?c1ZOS0trYTYvbHdWa0ordThONS9wd3FXaEN3UmR1eDBXUmJESjBuSGNOTzM5?=
 =?utf-8?B?TE16eUNKTUxjM3R1aW8ralBoVU55OGIySFhkbS9VcTlxTkxoNndiQ1ByNmVV?=
 =?utf-8?B?MEEwTVVjNmhzZjBVTm1qMVl5WU8vMjVqV0hyYXlWZnY4SEY1VDJGM2NOeGh2?=
 =?utf-8?B?MTJzK29xbWVxVE1JZ3hINzVHSzJBS3Y0eUVzWWhyNDhnWC91YWtvQTNwQ1hk?=
 =?utf-8?B?c0J0N3ZTYUJ1L0FHS3QvQ2tMVkhNNEEzdmsvc1NxRm92U1NjdHVBTkJBK3BH?=
 =?utf-8?B?Ukd2ZmZoYk50L3pJTExacndjaGZ6NXVTUkxFRmppdUgwR1hKd0N3VTd4cU5m?=
 =?utf-8?B?b05mVFRsOVZMYTBERWR3SkZnTTVvOEdmNzBRcHIyanJNMUo1V2NtUXIralZz?=
 =?utf-8?B?V0FDaDNLUkNIa2ZkTUJJcmoyNU9pc0lkekwwMGpGS1c3c3FaYjFuVXhXOHB5?=
 =?utf-8?B?MCtQVDluNFc5RnplaVBySjZiNG9zTHM5WWQ4RUNsaFdLdEpGVnVhVUtZRk9J?=
 =?utf-8?B?YWlCQU1lVGYxWVdyclpMQUorZC9ramZmdzhNQ1lsU3FGdzR6bnhOUVBRMTlq?=
 =?utf-8?B?aVlhSGtqaWpYRGVRbWdneW9yNFlUekpiUmliTWV6NXBEUjRiWCtOY25WWEh1?=
 =?utf-8?B?L3ZBQXFvdUVGaUU1R3N1VkFEa1F3RUw1TkhrN3dYRFRIRExQSXJhZ3QrWlpv?=
 =?utf-8?B?RlAyb1Y2M1BBYXVCcFJlQ09ianJ0S1RVR3VncHhJUVpOVFlINUx2MkNVdHB4?=
 =?utf-8?B?MHNkOVVQcDd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWY0ZUxoN0NlT3Nzc3pvQ3RiZ3l6K0tVZUEyMmwxSFd3L1FuQ0FNQjZiaXpP?=
 =?utf-8?B?Z1pkUVhtalU3bkpRVmhVcWZHRFJZS0tKRml3VXl6SU1hRmFPWFVadDhzaDU3?=
 =?utf-8?B?OFNmV3VWWmdMaDRTV2FyUzA1VkgwU3FSTXlnTmtMNXQvNlAzWitrSDdOQUlw?=
 =?utf-8?B?cWZpemhJM21zT3o3UFRNK0kwVElzYUwrdEhwZkR0NGhJYzhnNk8zeXphY29T?=
 =?utf-8?B?YWYwWlMzK1ZneVd5OVlvY0RVS1Y1VXVza0EyeEVZek9RTU9jN3pRa05kWTdK?=
 =?utf-8?B?dnZCQmZsYW9aVTJOTTZoZUt6WktQbzJhZmVuREdpRkJ6dWpoWWlDZ0tzQTR2?=
 =?utf-8?B?NC9ud2NhMFlVQitnenEzcklWbUl3Zk9hSWMzZDBSYjcwY25LeEN3L1hKYi9X?=
 =?utf-8?B?S0Iwc0NsVDBVMy83QmFONzZlQ3BWcXZKR3oxZ3E1SFNFbGk4ZjE4Y3NDVkV4?=
 =?utf-8?B?ZDF6Z1ZTcnF4MzhiWW9CM3Nsc01XVllpNkdPZ0ZVZ2pNMmkyUitUTDlwTG9F?=
 =?utf-8?B?bWF1MysrRytYU2wzbWZtZVJ0MVhXVGUrbi9QTXBrMW04RUMxMjNLRFg0eDMw?=
 =?utf-8?B?RGFGZ1ZkVWdXQTcyZHFqSVlGSEhQcDZSRTJ4N1hCZWpQRkVobmRGSm5vWDJ5?=
 =?utf-8?B?MTZyRWFDUHZEcWNHLzdtbUNXNi9PRStycmMzQ1RXV1V6WVdrdnFkaFkvY0Fw?=
 =?utf-8?B?eE02TmVVMCtlUW5WOGtHMkZNN1Rsd2hzaHRONWpiKyttVGlRYmxDNUJ3U1Q1?=
 =?utf-8?B?cUNqQmFudVBZMjh1MGhOM2UraG92eWlyRWM0U2hjWGV3eHIra3drU2wrL1V6?=
 =?utf-8?B?WU82MWpPckloUUNLbUtZc3pmOHRLSjAzeW91L05wdHRyWTZHVVg5Z1kvUVlZ?=
 =?utf-8?B?VEJDQStJUklCY01mTmEyNkVYS0hxejVOakVJVmFITCtmOWlUUUQ5WEpJUTJ4?=
 =?utf-8?B?UUtsOGdveldaUnNNSFdqZ3pBUTR4SWZZdDE5NFNRZ3FUbElmNXNLaW5vK0xF?=
 =?utf-8?B?MHE2dmF2eU0vZWlZMXNFeXI2QUpsa1dCY2dkWWxyZTVJMkVseHpQQitRbDlU?=
 =?utf-8?B?b2FkdlJmazhPd1hPL05nbStZckRJQXJwS1hOSUtNVDlnazBQdFJpVS9tRG10?=
 =?utf-8?B?ZC9MSjdYUWV4Q1ZnQXU3Nm1UQUY5WndndDVJdTl6Q2xIdTJPeGk2Z0FqRnFh?=
 =?utf-8?B?RUVWSXRmZTRrSHZ2anN2WnZsL1JrWkpxa3JPRVVEcGV1MXRjTzBNalZWcDhT?=
 =?utf-8?B?NWZZUWRIZDErNzZNdTA3T3lnZ0k4amxlQ0VKZGVIS0duQ01hMjE4SCtmbWVq?=
 =?utf-8?B?cTBFZzM5amIyNDBtelhibnI0YWYyMkhQQWdhc2xBSTdWV2t6R2V1KzM1czN2?=
 =?utf-8?B?NE5RTHB6ZnR2RXdMem0zV1F1MlpFNUpKQ3VjT0h3dFJHMTliK0JBSzNEVnVn?=
 =?utf-8?B?Skt0NGtITHBrZ1V1bFlrTjJnSjRCWkdaTmNPVjhreTBLL0twQ3NqdGxvTWF5?=
 =?utf-8?B?a3U1K3N6dWlENENzeDB2d09iMi9FNEpBbGttYjJXV1JxeUFDbFdEeUVTamhi?=
 =?utf-8?B?azhIbmUyWGI3MHJWSFA1czNxSzIvN3NUU3JvY2N6RFh2TnM3a01HZHAwQnBR?=
 =?utf-8?B?ci9KWE10WllJQzkvQ0l2U25neGcyMUE2azVuUmNDbWdjY1pYTDMxeEJPaDZU?=
 =?utf-8?B?eEhrM3IySlpkTEZkNXp5clg3RCtwVlRRRi9xQmc5S0pFNVRtZVZQc0dORGcy?=
 =?utf-8?B?ZExsVmFxTUFKMEtSL25TaU5vZkxLbktmYmZLcVNsenVxOU1xekdKVWxHTyt1?=
 =?utf-8?B?L0svYmpjZS9ScGNxMHcrdE05MTF0Q25IbmRGV0FiYVphL1Z3K0ZBRzVkRHFG?=
 =?utf-8?B?RDRXbzltM0JkQUNsOElyVFFQMWc0eW1Db2ZMTWZTRXpQdHFjdDRaZE4vb1dp?=
 =?utf-8?B?NWlsVlRQQ2FFUm8wYU42aUFoQTVsYVVDRHM2dEZlaXJKa0F3TENvRG53WUJZ?=
 =?utf-8?B?MSt6RmlnTzc5Y0ZJQnhqY20vVWF4US9rYjVMeTRMYmptV20wNlFiUW5RdE9x?=
 =?utf-8?B?N2FWMnBSOXdVWC9GNEJ5Nkh2TnlQd295a0VXNkVjc2FBV2NtNmtFSm5BbENm?=
 =?utf-8?B?M2pRS05NQUs1cGJlRjMrK0lMck9lVVNQTDBDMjBWN2wxT1JzQm55djgzTFQy?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d490c85-56d4-45b8-1783-08de387c35e6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:12:06.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETDwHgVzg1u/OjYt7xOmlRufAah1C3cySm+bT9XqE0z+/WSCoQWyi4CK6LDj7+nFCXHyTYCctp+C0+Vl9BdfnmIcTxTRjxvdMHa234ZDcH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748
X-Proofpoint-ORIG-GUID: 3GdBoFeyF-MBnuYvfx0ecjmb2uarZjIn
X-Authority-Analysis: v=2.4 cv=Cb0FJbrl c=1 sm=1 tr=0 ts=693a60b9 cx=c_pps
 a=0nW3/h2Bs9e5w/EoXaYwaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Swh4HlgNjT23l2z2Lj4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: 3GdBoFeyF-MBnuYvfx0ecjmb2uarZjIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDA0MyBTYWx0ZWRfX/W7p2zUh7BUL
 n50T9qSzbCNbY0obx0r8MafbI12nUy0lS04AplubTj4Jbsq6Y12H3SjtXuKwFQlcKS9SGMqIOPW
 Mp0FD2cnaciJ+m6xBF0aXiDGoBTbcvEHlz9JGOKx5t5DZd6sw1jep3z+EOavZ+MHvHYT2sZkShY
 DB60wygK7qbklyHUV6oNeZobk7yh5bz751DEITA8R/h0R6njwxGBpuM1kQ1IPRcwdjdvWuLVJ82
 UNaP25H66RTld0rrqH8ZMy0V1L4PX09qI2yL2H1Ku32GBp93mcqtVAr0Bt6uDFBZt9wdXHKWU+p
 DjpKrQW1lOGwzzeuvBjaebaDWqOpy61gzqpl+zrQuTs+btxtXjcKK7wwKMrx2MXIQ6+CNNqx362
 M2+3uz6aqUCF4wXiG95qqlI7uLbfUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110043

Sorry, fix the typo. It should be "linux-6.17.y stable branch:", not 6.12.

On 12/11/2025 2:01 PM, Zhang, Liyin (CN) wrote:
> Hi,
>
> The following patch has already been merged into mainline (master) and 
> the linux-6.17.y stable branch:
> net: lan743x: Allocate rings outside ZONE_DMA (commit 
> 8a8f3f4991761a70834fe6719d09e9fd338a766e)
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8a8f3f4991761a70834fe6719d09e9fd338a766e 
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.17.y&id=8a8f3f4991761a70834fe6719d09e9fd338a766e 
>
>
> I believe this patch should be backported. Our customer is 
> experiencing an issue where a Microchip LAN7430 NIC fails to work in a 
> crashkernel environment.
> Because the driver uses the ZONE_DMA flag, memory allocation fails 
> when crashkernel reserves memory — preventing the card from 
> functioning, especially when they try to transfer the VMcore file over 
> network.
>
> We are using older kernel versions and request that this fix be 
> applied to the following branches:
> linux-6.1.y
> linux-6.6.y
> linux-6.12.y
> Could you please help backport this fix?
>
> Thank you for your time and support.
>
> Best regards,
> Liyin
>
>

