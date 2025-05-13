Return-Path: <stable+bounces-144210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C032EAB5C02
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5116D19E5631
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A41E8328;
	Tue, 13 May 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aZ4KmDdB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S3s83fAc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7FF1A23B7;
	Tue, 13 May 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159578; cv=fail; b=A7AfuZ/SeZNbb80xUdMSfJW0Y6T98rpoHe4LNIDaXVlMhZm1PYjcSzY9ZsGJtoJHUdwlLcOgs+2a23sh08oPC55E+dCbJJmwkoYOHngmAGrr1NS8cYimznzci30s4XWlkvX8pJf0GGvPQsspQsGkz+eBhy2kuIk1l1OgIu2uO0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159578; c=relaxed/simple;
	bh=kukyl8frdW7kBzt7IEUs9+K6ZNHkTPD6mJYr385Z7lk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=on2P9m57Dy1x1vfKI4TXUIc3UIlQTD4VeF348zFUDa1Q7VxADvTIwf3Np9j5IZLTEVFMXl9RirC7bSFs2Drm2uhLkCH7WJtkUudD7hS2IPsupKVrvz0CrEBqkLQNV9Mqw32H/MSZOeCcGPZv0l2Ip2gXQwp2qQMo31lnECZ+kUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aZ4KmDdB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S3s83fAc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHLne018782;
	Tue, 13 May 2025 18:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hxLzR6B9tXaGHdQvEbTz+0UYPeVWlyTzAmc/4etSWTk=; b=
	aZ4KmDdBL290aYrNC/ImjcL1lyaC9qMPa5Wyc7BM7v7udMyWohTdMuOhMV/8hRcq
	T7Th/r0MCDzw1ybCk+ky8bCqiry/4pCHi7CdutOPU7dOHcpjP24U2mKrDWjjdxe1
	gOfrjl/p5tfKPoiUbIBKWM3ySLFrJjBDg5iVRScVO3zq6pj4rSpfsPRtlEBG6SjA
	HoQj5C26xiL1R3vQ95riPDI6HRiXytCQuUBYmusGg+uE2bxP8FApuhmJMJV8OpGH
	xESzvcmrMa/WsSQ9VHP4oUnVyIcJlvkc87HOqFH6QJo74Amuogo4joajp+lru36H
	cUc2MDiQFspXzzAhPU+lCA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0gwngey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 18:06:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DGp4hp002573;
	Tue, 13 May 2025 18:06:06 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx4qap3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 18:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJFnXe0qUCyKeFyutPj3AC/P36/kyFsALwUb/C4zzflH8WwKAKkVlWObynchNw8t5y4H+8uGHjGvJCYE+7UXp8Y0p8xiGk7NHSOlfSwLwzaQyMMZcvvF4d5H1+/ED9kGEefBYy16Ch4+WZJFiZlmixjTuXAUMcQudG3lRenOFB5+P/7NXx7JWyx0GFk8Ln6opQR44U0hNfF549aX1pJ1KNq62pA/JbazirI90Gwp9U9LFqfSFSuyjZbSRK144CQaPjX6JawRwFcINf40f/VtHWaTX+Niy03IdJln/8HjVHx5u9iIBEFv5nQC87ApmjKQwTRJmH+GZ8Oubui1dPyeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxLzR6B9tXaGHdQvEbTz+0UYPeVWlyTzAmc/4etSWTk=;
 b=gqwWytnDNxeaoM1me/iaEXZaCUj32gNzI6KsTZjKliKakFRO6sakQcUylUirXRG3xDM2TxWcilLDjdqJ7zFli+5Z8PWWmN8SNTgLR4tkPyfZB6LSPAGAPrspAtmFifqplioRBz0/UJ7HQ/mFnK4K50jUUVq2OayjfXiOP3+SGYlfyGTuBZTOSR11piIl4t/ecfDfZV6JGb5LeUR3N5mtFAhdtlPbh1W5hTMNrTSO/pjJUl6L1te8ZMSjPOp6YKx62eJ2KgD4h9eDArU8IV0cBcA6HrUQP/maA4BLBpqmJEOCHsZfgCZV1QKXj42FeTg/Lk6nEccD/iX9w3uhE2vXzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxLzR6B9tXaGHdQvEbTz+0UYPeVWlyTzAmc/4etSWTk=;
 b=S3s83fAcypsRL+Bh5yYkJ/lvx/H/2HuDKbTuSdOnEaQNJRGLdTpKQ2aWNkrUc+WzjGtI0oZlGDxK0iKs8G96HzZmQ1cx78R37RqrD+iUvHLFVwA6AKyeqs/yknDy1S3boC06QJ8/CNJGpFGo/hbQsNZNsKPeloQsr7A7g0mWnFk=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by PH7PR10MB6578.namprd10.prod.outlook.com (2603:10b6:510:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Tue, 13 May
 2025 18:06:03 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:06:03 +0000
Message-ID: <74d81bef-c77d-4b84-a50a-665ff852fba1@oracle.com>
Date: Tue, 13 May 2025 20:06:00 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
To: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org
References: <20250513025839.495755-1-ebiggers@kernel.org>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250513025839.495755-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::16) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|PH7PR10MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2bc19e-0579-4a27-859b-08dd9248d306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek9ucXZyc3NmVTVGdlhyL3hXWmhNcmVHTG9DdHBpRXN4Rnd5b3VrOCtlUEl5?=
 =?utf-8?B?c2xmQWE3MFJGS0dYS09OZTV0SGtkTFg0TXVEZWQwYnRUN3lxcWx5bDBHbVpC?=
 =?utf-8?B?VmVqM1pBSXZwWTBQT1hiYjVydm5lcDZiYXJlWVBtYmxRVU1VcHdTa0lreVQ5?=
 =?utf-8?B?VDdYekJMbzQwTUdheEh2SHkyWG1jRjNYdlhaQWZVQ3Y3aWJsdlhmazNteFJJ?=
 =?utf-8?B?N1MzbDI3SjRLZjN2QXFaRmVOY1RoTTg0OUdkSnlSNW5XeVNtY1dxalp3Z3c2?=
 =?utf-8?B?bVp5U2ZYM3lVblBTaHdNYnVJS3haWU94d2lyYk1rM1VWdjVIdUxkMlY5dENh?=
 =?utf-8?B?NXlRRklWbDdxb3dubEF4UFlqMFdBc1ZGUm1EN1pwenpHeDUwb3JKcmg2OFR5?=
 =?utf-8?B?S1pCQldTUk1XU3hrNGdnMXUxUWQzVGxsR1ZrZmxQU0JJN3p4MHROamQvNUFH?=
 =?utf-8?B?QXZoQmp2S3d4cmE5MENSeVA2NmRHUEQ5L2EyVmJIRElOUFkwS2xoU2JPT082?=
 =?utf-8?B?VTNQb0x5OUZaTGJVZkVid3NPL3gvaU1HWUtBeUxab05iaDN2RUxqMHd1MjB1?=
 =?utf-8?B?M2hZL1dCNGdWLy8zZUZqUm0vWHoxa1NoY0ZURVNzMXN5NVF3WkNYQXh3WHp5?=
 =?utf-8?B?SFdtU1RkUGhBQ3o1RjQrTTFQVnRMUkhJNnp6Y1FFWldQRzdtbk1nQTdOUUFo?=
 =?utf-8?B?VGk4bjJzREg1U2YxbHBoRitpdUF0VlZ1KzZYVlZQWEdBUzBjcVNBWitIbVRw?=
 =?utf-8?B?Z05ya0tNTk00KzBpWjRONG9ZSFdtOHBlYjJFZnVmTjh4SEYxeVkzTUU1WG9S?=
 =?utf-8?B?VGtqaENGOHJJSVpDbXBOd0ErOUtoN3QyVlpPREt0SllGbmo5b3F1ZVRwdW16?=
 =?utf-8?B?SlRYQ2F3dGFnQUsvUFhKRHZzaThFdTVmVUVWbk9HVWNvL1RyYmpIUitLNy81?=
 =?utf-8?B?N0UxV3VDaTNPWmxWeDByQzlZOGZJMS9tTFhRM3RKdVd5N21OZlJHQ1k3L21E?=
 =?utf-8?B?TkxhSDFINXo0clRCcTlFNHVwSXErUjcxaFlmMitMaTZkNkMrZlR5UnpET05T?=
 =?utf-8?B?TzU4VmxqNW5Xd2RvMnJqNmJIY3dEWGtEYWh2WkNUSDFiUHE2eUYwczZnL1dn?=
 =?utf-8?B?VjYyZ0V0NTdxQXF5U2hHNjU2R3ZPaWhyTHBIeHZUS2dKSEhSVk5Sb3U1YVBv?=
 =?utf-8?B?K2FJdzk1RmNhYks5MVR0c21TRUl5Qk9wVVJ3YnZVK2tZMEY4RUxwQVE3V3pS?=
 =?utf-8?B?UEtpbkwvUFBWK3IrYng2YVF2c1F2Tm5iT0tteExvQVQreURQcWx6cXVSMndm?=
 =?utf-8?B?QnlyNE5Iclc4c1NzMFBhQ3FLaDNFUHVXWW5Db2xieEdsbkNiU0FnWmI3QkRQ?=
 =?utf-8?B?blRBUkpjWDJQcWVPT1hHeWdNWC9rWXg0K3R1UU5yWmNBdE1QeUZFUW1wdHJH?=
 =?utf-8?B?b2hTL3pPOUNmN2g3SXV4YllyM245MG1ySVJGejBFSTNGRWhJTTVKOFArSWRY?=
 =?utf-8?B?K0p4RUdMVlM3amh6MzA0WmFzZ2ExZFJOaWxmQk1hWVp3L0gwNy83L0tmWnRH?=
 =?utf-8?B?RkpvalpXamh0aDdGbmorZ3BaaHlVMk9ObUFMOHIvOFpQVzlHclZWbmQvZGlM?=
 =?utf-8?B?TmVJUzdrUDJrbjArNTZwNzBuRTZMa0hYZDBZVnBYcXRNek1DeHl0aHhrNDRR?=
 =?utf-8?B?SWVQWkoyVENaRlQxRTZOU1Z3d3NEQXoyOG5IczRLR0hvb3ZzUE1abVBPa0Yw?=
 =?utf-8?B?TW1sQUc1bWsvVlg1bnpzOXZqeXh6cHdheWZOWXREUHFHMmliU1duTGQ4N3hX?=
 =?utf-8?B?U1RhcVpQVmlKZVJ6YTBqVy9weGFWR3Qwb21MVHRLTy96ZDV1djFEMGRlWGxo?=
 =?utf-8?B?ZnVyQ3AzWXpjNHAwVVFCRS9oSjU0cEJvRVQxUUEydzRpanJxWnFYTXk2cUtN?=
 =?utf-8?Q?iBesbvWaTJ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnZZTGVUNFp5Q3RncU5FUzZlSGtRdHpwZDBDajhZUGtMY3FEVk5xOGNHdGJG?=
 =?utf-8?B?M0J6Z3N6TWxPMXJiekV4Sm9KaXcxVFN2dDhhWjR1MTEveXNIZ2IrcksveDJh?=
 =?utf-8?B?b1EvTXlUNUJZYzhINjN4OXVnbVV3bkZlYW1MYnhTVFJhVWxPUk85d1Mzby9i?=
 =?utf-8?B?NWpwbEVKMFBPbU5OMVV3Z20rYzYvOVpndlQ5TWtodlFaaFkyNUJra0RTcGJ1?=
 =?utf-8?B?bS9URnUvS1Zuei9Gc05YMmFsN3FKZ1hDN0ZTVVZjWUpVUVVxSGJNWTAzYUx0?=
 =?utf-8?B?Q2h3MXNBWnJWTkVKVW9IaWlmcnYrQkVEbk4rRGRjQVFsZXY5NTJNUDM3aDZz?=
 =?utf-8?B?RFNUK2JKTUJkWStJRmJ5ZWkySGNxd1pXcThtaUtacUNJUC9XQ09ZdlhkQTNK?=
 =?utf-8?B?VDhQazk2clV4dGc1TUk4bDFqbVZjNUtXZW91TGphZDJOV053cHR1QnNIcVRP?=
 =?utf-8?B?MjM0ODNFRC93SVFPSTJIWTR1TndOaHpSWmc2bEFkdmVQWEMvRC94Z0x1YzZm?=
 =?utf-8?B?YzNveElYZkJoOUszSHpWRUNyRVB6eGZCYVhrZXRPMGRBS2ttaERGcGtDbXhN?=
 =?utf-8?B?MjIrQi9OVGdxYno3OEl6U2NGRFJlSlMySW9nS0d6cURBUkZuMzFZOHp4SzZX?=
 =?utf-8?B?WjhSYjlGSlE1UnVVQWJtRHRKckp6UG4reFZ5elMxVG42azM3T0ZVa1dOdkFN?=
 =?utf-8?B?eVVHazhsYStTbGVzdHV2Tm1lUmRVajlYN2VMditwa25Ka2hYTDdoS3M3bklS?=
 =?utf-8?B?dGlHYjBoRVRzaW9INERuUUhSVW9kQWpiR2JxbS9vOHorRllLcXZPR0dLS2ZS?=
 =?utf-8?B?YUphL2Q4V1QrcWtVMno4Vmd6QTRqZjBORzcwaDcwZEZpNGlnckRZZ2ZCTk1h?=
 =?utf-8?B?RGJUUW56ZXBDNFMzNWMvN3pDeDFJa3BFeTZTdVNCN3paMTBRSE4zWW5TMXY0?=
 =?utf-8?B?MmR6b2htR0dWM3d5UVRMSkFPSlhzalJVeHc0cUVNb3VBZGIzOERrNHJ3aWFn?=
 =?utf-8?B?RDZkR3lvWXc4SG9QZkZvMFJ5ajNOdUhMNnB3NmhQUGtLOVN5Mk1abUw5MGZz?=
 =?utf-8?B?YkpFbThnSU1yWFlKTWJQSEg4cDRnNFUzcHFldFJIU2RQODFlOHpLVmJ5OG1a?=
 =?utf-8?B?cGtCa2NVcUFieGhoNkZ3SlpGZC93UEUwcE1jTWsxVEdkMjhWNlVtVXo5UzFV?=
 =?utf-8?B?RExYRVdQNERuNDV0eDBGbkpGWEJJemhkTi9Eb0VhaHNtVGJTMWtZeGNqUUtQ?=
 =?utf-8?B?RHFUODVKSzVKaE53YitqZ1JRTCtuODdoNDQ0U0VXZHA0cGhJUm8yQmpBWGky?=
 =?utf-8?B?cmY4eEhIMUJaQW9DSUpDcWhmZTdOUVcraHlNQ09sMWN2SkdPbnVyVW9TaW9w?=
 =?utf-8?B?dlNlVVNPN0tXbHJkYlJuRmlXVG9lZ0FiZGJTa1hYK2tHeGlHRUU0WG05aUhp?=
 =?utf-8?B?bGkrT3loTnZUU1Yya0p5SDVaOVNFQUFvVHFIT0J4Z09veGZCb2VtckowaHdJ?=
 =?utf-8?B?K2tERHYyVDlVbFJBTHdkYUFTMHNqU3lTK3ZyeEM4dlBudEdpRmlDZFdRZjUr?=
 =?utf-8?B?ektNclA2TXk2U2llN0JTQ0xNN2g2SEFHVGY2UUhqdWFqaXU1c0ljNEtwS1hQ?=
 =?utf-8?B?RllsUkI5aHZycHhXSENFekV3Y2R6UGxiWEg4dkh0TVBUZC9zSXFNcm14czl3?=
 =?utf-8?B?aUNRMDRjY1dENkd5ZVNXRms1VnpuMUxrY0JlUHEwb3gwcFVHYmhJQlc1L2FG?=
 =?utf-8?B?SzdhOSs4QmF3NnFBWTFiMGw1VjVRUXJxVzgwMFpaei90KzJnQ1ZEVzZtU0JK?=
 =?utf-8?B?dlloUnhYa0I4RlFCR2Jxd0ZzMDdIUTZOdUFSRmJMTDhZQXVZYVdwNmh2L1Mr?=
 =?utf-8?B?MFo4TTdJcXJKWHJmc2R4VWxuYWxNekhBdVFVWDVNZG9lZkVkUlhlUW1Odzd6?=
 =?utf-8?B?eVlQazhzU096T0xScVlqNlpJR0VpRDJJL09BTDRMbGJUK2d6ZTh5UUFDNFBy?=
 =?utf-8?B?dWcxbGhETnZ6dTcyQUFtZFNtd0ZmbXNROEVRYUpCeUo4cXNQMGJIVkNGYzZ0?=
 =?utf-8?B?TXcrSi9PWUQ3UEd3L1dIMUtUdnRGcEZSR2tLWFpBTXhtVnJTSVdHVDhBMldL?=
 =?utf-8?B?QUcvZmxLZFErTTdKc2JUKzAxUUtXeFFtWHNoWEI1OWVEdzlwMGVRVFlxZWFo?=
 =?utf-8?B?Q0d3SDJxanVoNXcyOEZNSHd4d0dQRkVVaXVqUEJJd3Y5RzFnU2xMcjN6d0xQ?=
 =?utf-8?B?eURYb3NBTjlaRFNIbU5RaE45WHlnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sMckY4VEM/KrKqWlUJd/z4VTQh4PDGqm+QVZobLX/TKnoVzfqfZSC5rJKj+DKZPi2iBHHq/C7poXQ7OYBgiDHe0umDwmioXGAWR51hzsga1+zig/C8mzMBawXKeXrzbagJL8XcFM140/UMsJIKjdlpY1VmwgV5Ohb8hc3CqzmQSnSRjPE0Q3aEo7bfOC0u1lYK3U/EOxsptBxLQq23YImKBx3UMP+CInIS6hDsWjZqtVVLWzcoffFq/VHgsiVf7fAQaVR/plQgaxWAJtskCAd48xla60zgkQjq+QR2sMHXwgI3blpAOo0Ygu5/Za7NlcBJ5CNXittJSzNjv0GixQemGt4pJgU+OEnrlrKEiV3BeQ9Alzf1dBtKiAnHDmB2hF1NJaMgcE+WFmv0kvK1QvsvCzDZ0xsO+FeItXEvBuDRmijrz8cw6N0s1HYwfGqgj66suXRnheKRC6kI/Fi8D4TiaRWuHhUcOEqT6+eA5axDrruGnXdudkuNGTNLHuwHsFYEvhuTWQGCUIzhQeJPAu23b2tYIGCPdUoydy7TsNbIPfGa4Bz3TdCgnsGI8PeHnhrd++B++VIa+2DjpkYVY3nVU6PNq/aA5L77hZYCEiy7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2bc19e-0579-4a27-859b-08dd9248d306
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:06:03.4009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TU9FUP6HpUH0c7nzmfEiYOO5O2vvHm0sKTb20EACyZGNi5fz3ifaIV598eNQq3aWTEJOB6YqEGeVMXKo7gz4TQUOXCYoS8ycaNf/0N6MwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6578
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130172
X-Authority-Analysis: v=2.4 cv=M8hNKzws c=1 sm=1 tr=0 ts=68238a0f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=S8Fhi8tFek0lTXm9LyUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: t23RgAPrT9BxOZEavfrA9MRo5FgKo_m8
X-Proofpoint-ORIG-GUID: t23RgAPrT9BxOZEavfrA9MRo5FgKo_m8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE3MiBTYWx0ZWRfX5wTaGdDSlWXl aDHmwYXk4lJe+nD8ZO9rgpcPnul1okzVjPJ+bwouO2flBYiCVeiobn0U18k6pxVxx6hoqbbGa5H H9SjxlAyN+ZUSd6rFsIoN+AZADPdZ/16/vDMGcqdotfH2Nj8YEnBTnFKCnlaVbLNlp1AW7gmvK9
 mKqlaBMiDMI1qlEDi0BA8IQ8QyJza833RXYvwkoJOnBAy6fniOlxFl7p4QWxirFQKAKqN5g5I82 vCje+cFrNe+BpHfg/5JVrTVQxqlVHmUcMsDtzbH7IUuy7nPAiz6CPZUsYNVs7F2Xxe3ekkHTNbi H8k9y+oOpghYqRLY5sDDH5jtX1bb2+OdhT3+hxlnEIiqa+4J7faBxV2P7BD8tMfElWrhkiJBLu3
 Cl1YOKcfh2KvJ0RB/7kEsQpA2DhiyDTl6hP4uX5dFShR9bVC5aiXBNWj7tpnfubnN8D46TMK


On 5/13/25 04:58, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Fix several build errors when CONFIG_MODULES=n, including the following:
> 
> ../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
>    195 |         for (int i = 0; i < mod->its_num_pages; i++) {
> 
> Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   arch/x86/kernel/alternative.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 48fd04e90114..45bcff181cba 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -131,11 +131,13 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
>   static bool cfi_paranoid __ro_after_init;
>   #endif
>   
>   #ifdef CONFIG_MITIGATION_ITS
>   
> +#ifdef CONFIG_MODULES
>   static struct module *its_mod;
> +#endif
>   static void *its_page;
>   static unsigned int its_offset;
>   
>   /* Initialize a thunk with the "jmp *reg; int3" instructions. */
>   static void *its_init_thunk(void *thunk, int reg)
> @@ -169,10 +171,11 @@ static void *its_init_thunk(void *thunk, int reg)
>   	bytes[i++] = 0xcc;
>   
>   	return thunk + offset;
>   }
>   
> +#ifdef CONFIG_MODULES
>   void its_init_mod(struct module *mod)
>   {
>   	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
>   		return;
>   
> @@ -207,18 +210,20 @@ void its_free_mod(struct module *mod)
>   		void *page = mod->its_page_array[i];
>   		execmem_free(page);
>   	}
>   	kfree(mod->its_page_array);
>   }
> +#endif /* CONFIG_MODULES */
>   
>   static void *its_alloc(void)
>   {
>   	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
>   
>   	if (!page)
>   		return NULL;
>   
> +#ifdef CONFIG_MODULES
>   	if (its_mod) {
>   		void *tmp = krealloc(its_mod->its_page_array,
>   				     (its_mod->its_num_pages+1) * sizeof(void *),
>   				     GFP_KERNEL);
>   		if (!tmp)
> @@ -227,10 +232,11 @@ static void *its_alloc(void)
>   		its_mod->its_page_array = tmp;
>   		its_mod->its_page_array[its_mod->its_num_pages++] = page;
>   
>   		execmem_make_temp_rw(page, PAGE_SIZE);
>   	}
> +#endif /* CONFIG_MODULES */
>   
>   	return no_free_ptr(page);
>   }
>   
>   static void *its_allocate_thunk(int reg)
> 
> base-commit: 627277ba7c2398dc4f95cc9be8222bb2d9477800


