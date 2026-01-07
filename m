Return-Path: <stable+bounces-206083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAECFBD35
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 04:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6194E3002173
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 03:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B7F19B5B1;
	Wed,  7 Jan 2026 03:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W5EG2UnJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t7wB/tNz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3958F18A6CF
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756120; cv=fail; b=eu8bg7ZLKoRNNKnRzNndyWofkDZhGtncaw4OHpY8GzmIyvojsXaalhKVH6SmU+vSlGgiE8hvPLt3y1ZKbAG0E6/mEgbX3En6akNGUyncT4DV1G4T6HYfhDGbXtRSnMcQnaZn3Sw5iO3JDY618fF0alSQ1CvnBDW/extgVCv0uMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756120; c=relaxed/simple;
	bh=3QQ86DkoPf9xzBWhAwjg2TjI8v4vV9ptiW6nIiwVHkw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JW3vSyGMiVV1yZ9Siad7E+2ddmfnLzUVJMJskF2u/QET6JxUflVz403AvPzwsJYOZQH392gSYTL8yicFBBPOvqcEuEd7KNNOTfHgypjL7czLzrdDTdkS4tTlIgsA1IRrRg42ItMFR1RYEiJmiiBjSn3+WIydxUG8PBGz3qva3Lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W5EG2UnJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t7wB/tNz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60736fBC1034950;
	Wed, 7 Jan 2026 03:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=dA6iXfw5+o9oveYf
	LbqOkfRsjgqPsTog50S2a48cy4M=; b=W5EG2UnJDVh6S72xzjsqPmN0In2kujuS
	QLYlSMjK2I9b096VpytrdEyPbmaO9DfSRwb6VXNh6Wj0NG80BTmOEr/dwJkm0tuX
	jfYa7OVjZNfv9RBUD7KxaQ5Yf49xkzPMQZw24IYkpL7jaBLDCZpn6Wm180NDmkSR
	yEIu3hs0M0JKIgWKBHvhGqAPijmpLjR1V59ADK41VeH446mydaSRz9Urw/OTd7Bq
	cqfJCGQY5SVBwiuUbqYfDNqfrX9je16Mf2HtzywEPUnewYH9SsG+fvawTh7iE3XG
	LYcx44WSIdsoBNreSA9cML8daJnsdWli0jyYbpqnPA23+dxe6Dyntg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhf93r0e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:21:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 607349lr026378;
	Wed, 7 Jan 2026 03:21:31 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010062.outbound.protection.outlook.com [52.101.201.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjkm3x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 03:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFkUJQQg58JsNwuFJnGSLwWPcBd6tIhFSl9u1Ov33v4jdI5L80mhe94jdaj8Xxgzd5Q4bfmYFk8mP7uXcTbHuw9DV2WBEXdS7kL3qAbkEkvGPMwI+9gycVYN6DchuDhMBUyDLRjPb+Fd/nQZdjYB5h9SOml5J197bznKJNUQh8jOV5Yw+j4/9fmbedv/hi/lyV5JwcV7WOh3pdzL0Dbjy9NQmqVh8e0YDkMnXfGYQdZ4szVHHzV1tOExhATOQUP5UoG0wc4S8+o8G2IIOzbFgLyTu3lUBpFKZhwSEyOh6P59PmnVcF0Ot0kN8D0pxRjq3eFYcZg0Q7OAFEhwvqf6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA6iXfw5+o9oveYfLbqOkfRsjgqPsTog50S2a48cy4M=;
 b=zTya8ugqGfJLZiFG3GYLywTR8ZlaC6Ov0Zplmmh2kj/W6AL+vkPcs8JC8S35DDl8MqSsPzeHDOWCjHX3gq31tr+yijuHKC1Sl3Clh/4OMFF2CHfZbJJwVXiPqAHRpvkTfBa0IbbmHUuEb5b/a7mGwv7+EPf62BSu2YcfsXP4o6oZIhOMv/Gebl//pC01gxQzUR2CehBIJCudcWflObX0kpabfPTwGnygvTcDQXRUvPiABkb95lS7j0gPi/ApaEmH51kcrth0DhHnUSPufosdF/COQtp18e3c6XSwEeYG3BXI+9KoM066oP5h1zPOKyTVsCzNdj9HApgTGcRUkxz/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA6iXfw5+o9oveYfLbqOkfRsjgqPsTog50S2a48cy4M=;
 b=t7wB/tNzyFDHfdn+H9tPO2qymikS/2xKbwoLQlNyP7JPbBQJALXfQexoBIIZPNMb7VOx7r9sASsBZQoaU8c9cX6T18FKVsiJWtXTvFQ47WWSDT27LnR0RzAWTOpx0jACtcJR7KhJnH7ty31kfdizzqPZdIuiB2bdmv9BKm7fuDg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4116.namprd10.prod.outlook.com (2603:10b6:a03:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 03:21:27 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 03:21:27 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: stable@vger.kernel.org
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, david@kernel.org, dev.jain@arm.com,
        hughd@google.com, jane.chu@oracle.com, jannh@google.com,
        kas@kernel.org, lance.yang@linux.dev, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, npache@redhat.com, pfalcato@suse.de,
        ryan.roberts@arm.com, vbabka@suse.cz, ziy@nvidia.com,
        Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH V2 5.10.y 0/2] Fix bad pmd due to race between change_prot_numa() and THP migration
Date: Wed,  7 Jan 2026 12:21:19 +0900
Message-ID: <20260107032121.587629-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0144.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::17) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c8fa48e-9457-402c-2bbf-08de4d9bd82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG5mV3Q4OGtMbWNsSDNzWFRycERrQ1ZySDB3STVoU3d2SFIrRDdiUEsxMitO?=
 =?utf-8?B?ZWdpOVUyZXF4Uy9NNldQQ2lLZDZxRWpFVjhaRkZPdTRmdFMyRUY1cEh4Vis5?=
 =?utf-8?B?YlN3c2NCcG9lKzdYUHVRUldXYkpJU0MyQVQwTXI3K0VyTGFkSlBGR0cxbC9v?=
 =?utf-8?B?N2dKaGNzRjZBRkxFcVBGKzA4SWVMemp6VDZsTWFTVjVEN3hKNmFlanA5M1ZF?=
 =?utf-8?B?L0VnR1JObDZSWFZUYThQdUJPWkltcWtuYVpPY2pyNFFqNHFrQU15a3dYOW1Q?=
 =?utf-8?B?ejdLRFM2TkZSTEtGYzFxMGNHQVVyMFhQNWVFUkdsVWtTRjRJVUR0bWRPeExL?=
 =?utf-8?B?S0tyN28vMGk5VFdRdDBwcU4xZ0RjVXc5OHJhWG5FckhLUW1tc3BFMlJtc2JG?=
 =?utf-8?B?TUNMR1pzempwbi83V2ZrNWZsdHA5K0dZOHBzaHp1RFpSWXJMUmorOWs0d2lD?=
 =?utf-8?B?SWNwYVUwMVJRY3RWeHpBRDg5Tk9HOGNhemN3SWJVcVcwRkZqSjZsTi90b3kr?=
 =?utf-8?B?ZUxocXk5ZE5BQm9UVm5WOWlmT1JVL3VaTGRudk5ROUc0V3dSSGFJQUJHNlJR?=
 =?utf-8?B?OHhHdERveXZoTThLTkN0cXozRG5oWkZHYTNMMXp1UWg1WkVkTDlrWXBLWmJY?=
 =?utf-8?B?THBMWDAwcUJCSE9FZnJwWnBvaFEyTURBc0xqb1BZQitzdDRDRXp3SzI4QlY3?=
 =?utf-8?B?UkJ3ZmE1NjR0OGNEeWJjUnZVQm9BdFZMRWplMUtSd0MrbjVYV2hpU3ZRa05V?=
 =?utf-8?B?S2FJSHJDbVRMS1pNNkU5L09QcXRUZk1FRkZMVkswMG80T256UCs5Z0M0emF4?=
 =?utf-8?B?S25pT0k4K1R2UWRNMXZzU1JzTUF6QTZCNXlqaXcyS2dGajMwSlVHZDdXWEFo?=
 =?utf-8?B?bG54SENPamVjRlNRWHdpVDhoL2ovYzdscXVsR1VUSkFhd0lHTEJKMXI0cno5?=
 =?utf-8?B?RjFsMm9iZWRxVlVZRFBQZktvWE9vWEZWbU9oUjUxWHhRT29zbHhqQmx2Y0xu?=
 =?utf-8?B?QXM0MFhucDVTM0N0dDNhYWlFVTcyUTcyWkNpWTQrOHU4aytVdmJmdU5NR1lM?=
 =?utf-8?B?NFpKa1A3dGMvOFQyKzJMZXVFcnl3MWRHMVVMSUIzcmhrZWFrTXF4aml3Rmh1?=
 =?utf-8?B?NE1wTGpKaGpnbmhadEk3bjIvTHI3bHRoa3h0MFRvV0VuNndKdGRzNFM0Rjk5?=
 =?utf-8?B?QkpBZ0kzajlkS05yY0xPTDgzV3JjM3NOMlIvVnlTdWpyTTV2WDVJZExZL2RR?=
 =?utf-8?B?N25DekdJaTRHMVRmOEtmTDh6MVFyOE9LaEF0d1l4SnJWb0dHWjNseUVvQUZG?=
 =?utf-8?B?WUV6Vm43dlpFM3dRQUFQY2hBaE9LZ3Zmd25QU09GWGhYYzJNWUVwWW80MHlw?=
 =?utf-8?B?dm40WE4yZHNBRndMRkxESVBHVGp0RndrTUpoeXdJR0YxWjVxN2N6U0d3SExu?=
 =?utf-8?B?WXdjaHdSZGY3bm5DYllma1FwSXUxRUI5QjdZWVhMWEZZa0trUm1ZRVFza29Q?=
 =?utf-8?B?dVdjcHZTYzNpVlNVcGZPRW1WbVlXaVU3aE1hZEdDNDVtMlVGenpXNUo0S04y?=
 =?utf-8?B?WWFuSkdLVGtlQ2p1enlNVXBEZVB5UWpwcHdFVjBsaUwrT1RzYlYzbS9ZeWlq?=
 =?utf-8?B?K2Z0T1FEZDE4VHdRdnZnS3k5a3BiY292aGNIblpyb0ZhN1QrVGhjSDNMR21S?=
 =?utf-8?B?L09xcC9ydVhPMm1RM3NON3ZZTDZjSldZQnpoQWhBdlczQTlMb1l1ZHdJcWRE?=
 =?utf-8?B?ZFE3bkZjbEl2bzNIVk5IU21uZW5zRUJBSHFjNjhGclpZZE4zWURyNmFVcTZE?=
 =?utf-8?B?d1BuL040c2Q5T2ZyOVBWa3A5Q3VEdlpzL2VORGlYSTl5RlNSUlhwWXRrSUVN?=
 =?utf-8?B?ODlicnllU3NzZFpZbmRUN2RCOWZCZjFKUkJMMTlVd0YrR042TGRGc2dYTHFZ?=
 =?utf-8?B?RGpRQnNhTlpaTzFwdis4NG5yNldHaStLMzduZnc3c1BkaUdyN21ucG42MGs5?=
 =?utf-8?B?dXQzS2xpMFRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NTl1TTJscktMRVNZWS9wdE5KcDgrUUc1U2tnT2NNSWlRclRhV3gxVGR1WE1T?=
 =?utf-8?B?TnJ6bFdjeXVIaG45bjFkOUEvODIrcEhKcUJ0VnlpWkNSeFFHSmhjaVROd0N6?=
 =?utf-8?B?MmN1MGsxSlVleDJmZ3JtRUFqWFVsSzM5ZWNtV083T1JBKzRXNnAzdDY1Wi9u?=
 =?utf-8?B?VE9waHBkSS9UV0k5aGJNNWpZN1VHcm9Rd0p4L2hMWmVJWXI5ajNhQXU1bUJB?=
 =?utf-8?B?ODFXL2pYZExweXhCWEpONy9QU1VhTzN4Q0x6TlF0VG12cmpDVEZ5anpETlBC?=
 =?utf-8?B?SXVYUnVNUEFTSXM4YTg2YWFoQnNtQldQQkFJYURhREZBbEx6dXpXRm5ZUWsz?=
 =?utf-8?B?Zmx1UjFaWis1VW0vWVNsVzlIVWRucDZ1SXJ0M1FEVDhkNmNka1R0UWl4Q2xP?=
 =?utf-8?B?ZWwrU2JvaTVuS1ZFVjFKZUpFb1lXbWRWYmVEdlZWU09Xbkp6N1NZWXpLeGJV?=
 =?utf-8?B?dW04N1hpMkNIRjZGekJsdnpYbWNtUy9aMjEwY1g5S05sYlJnN1VUODJtcTI3?=
 =?utf-8?B?QWF5TTJrVHN3MTVOcUN3bnM1N1c0TmtXbitOcjFvOFZWOVlMazRYYThQSjF6?=
 =?utf-8?B?ZHQyTjFwUkRDeVpuMlRmSEtDZ01JdDlBVlVVQmhFTU9VMUhrcEtxYkNZQThS?=
 =?utf-8?B?Mmd6UDBGdERYOXF2djYxMmZHM2djdElzYlBpSm1IN1RGaVBjL3dsSVA3Zm40?=
 =?utf-8?B?dVVCUmRqZ0ZwR3dBQ2tLMEZvYUpWOExHY3NyajMzdGVDZVdzUFl6aHBJOVNV?=
 =?utf-8?B?emNSNzRRbmtiWCt0dnlya2JYb0EzNVRMUVhIakZHVTkzTTQ3ZWpMTm16T09t?=
 =?utf-8?B?NTJyTkZFSXIyTDhmcDBZdjF5bUZuSWI0VEhPNGVsOFdUQUJYL2ZLdnZqeUN6?=
 =?utf-8?B?dFNML1pLNTJxV2g1TXVlVnh4OTVSbnR6U0pGdVRMdFZvK0JvaXpxRmtOVnRH?=
 =?utf-8?B?eUExbFkzNWNFR2dXSVRlY1VFLzJmNW1JYnRXTHpESmVyVXBRQUlQbnFtTWhi?=
 =?utf-8?B?MUJFS3ZGaTFnVnBza1pmTVFCaVlyYlEvYll6L1ExdmdrMVZRZTl1UWgybTlL?=
 =?utf-8?B?Sk5JODl4VjhNNnVDSE5uT3lRQ1FMWXRTWTFOc0twT3M1VVRvTGM1ZVF1V05E?=
 =?utf-8?B?OG5FZWxDWEFybENQZG9WZE9Qdzd4YmZEeU1FQ2hTWmNhVE9HYmNoZUNCKzZt?=
 =?utf-8?B?UnE0VHlOV1pDL2U2eTFSOG04WllWRGttYTdRWWpWeFVQMEs4K0F5RW1UUXFD?=
 =?utf-8?B?Sm11YTRSQkZZU21EaGNLMU9JVVdBNzcveVVtUWs0dis5b0V0QTkzMHVXY25V?=
 =?utf-8?B?Unh6Zi9wU3dQZDk3cXg3U0xMNnhpOHAwRVJnN2QvcjBpM3NkaE96cVVNVEVu?=
 =?utf-8?B?K3JTTjBYRWR4d2VPL25IeXRkUWxjV1d2bjBGTjJJUnpubjhrWS9kb2FiaUpp?=
 =?utf-8?B?WVBOQ0Mxd1d3elh4OThiVzhMOFhMMk43Y1A2M3JuNjg4VzhPQ0NGa2J1RG5W?=
 =?utf-8?B?Zm50SkRWVjhVNm8vbGhMT1pyMnNDdkd1RW1JNE42VGpzcjA2a0FVWW9YT1Fy?=
 =?utf-8?B?ZDJUWDlYc1pPWXV1S3YzN1V5SEhQUjcvWUFNdUpGK01rVUtnQmhqN0F2eFB0?=
 =?utf-8?B?N2pNVkZEWHdxY3hyTjJMMlM4MGFOeHdrcXZnWnhDM3BqVHJtS2ZXUnZxT0pS?=
 =?utf-8?B?b0t4YldERi90M3ZoUlVYQkN6RnA0QnlZSzFUYStWK0tTc0ZZYTQyQUU4UXNv?=
 =?utf-8?B?OElkTU5VSFpHNTNaOVpTcjRUVmIzM0x0c2k4dTJKZ0xFUythVEVNSXg5K0Va?=
 =?utf-8?B?YVhhVjFkVWt4a3dsazM5VmRSZFVVMDVXdEFWQi9LQlJHK2lxN2NscVAxZ2lF?=
 =?utf-8?B?ZG03alRRNDg3YTM3WFVUSTJYcHllN3VkMEJFVWVUSUhYM251UnRsOVNDRUZD?=
 =?utf-8?B?Z1hlVWtKK1NnNUFQNXNwOFIvLy9mbE1ielZhcFRodUVKcEZEcnFzNVBKbkIr?=
 =?utf-8?B?eXV3RGdvN3pTOGhnT0ZaQlVTUERETjc3UmVRUklzK3c0dU9nbGwrOUJncnF4?=
 =?utf-8?B?NG40aWJkWmtPTlAzZUtsem44ZFB4NWdXYUFOam1HZWtzTjRBQ3pjVWNsUGxn?=
 =?utf-8?B?U24vTnBKdTB4VjdTa2M3VEJoUjh3NjlXdzlkQXNuN2p1anpSUGdNRVBZR21k?=
 =?utf-8?B?UFpqNE9JdjRiLzdtcWlEYW1kZ1MwWHIrOGhlSHBXZDhJd3VldWpJRTlZQ1B5?=
 =?utf-8?B?R29jNVdWMWFUWmJCV3BSS2ZKam9EbE5QQWVtTGMwcmx6cUg4TitZWjlJenFx?=
 =?utf-8?B?R1hibVdORHBpbktCVkZsdWVMa1c2N0NQS01rcEl6UVRiOERabDJMUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EqsOy3ZE9u6bBlLmZPqj0ZnB84LuhWJdZn/O6VmCNwaVaW2nwj0U/dlaDUTj0vBtVCipD0X7hcHZP19iEivpNHi0hIqhD4KOmOQew4Fs1pLoRUmST8zA4udUqjZCr648syanSQAHCHinnT0B2zqcNW4TjhKSYZ9z85GfaWJIibcR/svxGfDaAH2XpRR2wUKgEygFUZjre4K7pGzi4t8W05phqIw681GusewiBLyd3nfIr5HQyW0oEsJsnk+m8QE9geefRIJG629Mhgu4zXZxnNUF5DVmySO3c8B0KsyJF3+84ujPBsknM9iiwZ/pHPCDW0w9OBRhMtKamDV2eyJDbM5Zq86g2mjEohER6EwgEo7rkJ4/1141oFqHMw6VY3XsEzbO10jak/8famcy4z/bAd5ZMDxjM7UFzZS5PyKJaW6Wh3GzlKJxf4p3peIqCT/h3ez6GXy1OtF7wjB0wNUqeVjmPoydr1YrFr1xEMFFSWBA+4/Wc6FaWLrT0KCiV/YgKXW+QTKsCuuDtMQm3x2jIahKiGbki1zaO4MYmTpyjS5nwC0jeySJ6XhMIGKhYWcPIlVrLtt5La+xEals+Bn9RB901TD4kkSyziWC9mngFQM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c8fa48e-9457-402c-2bbf-08de4d9bd82a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 03:21:27.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHni1C7A+/6Ll84Dia2SSaynHmXT1GHlxlKU16SkKKoNUTeQOTsi62gi5ASwNY5CCELsTaLSGGtHEx+QA/fJqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070025
X-Proofpoint-GUID: j5OFCHfGRuB1NCxcoWcQkO22in5EvbNr
X-Proofpoint-ORIG-GUID: j5OFCHfGRuB1NCxcoWcQkO22in5EvbNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAyNSBTYWx0ZWRfX6voLW/roF9O/
 ND0/GTBp707SYnV2s17ae5H/nx9pqSfdZ+K39CdQifAytdfXshmYoTTFhoeLl2OOhSsJ7bHImiV
 7O+iRw1WTqkk03v3UraUqkw97QhHvMb0If8Irs+wDGq3bBCi9/lDsqWZxt7I9dO++8u2rIo7aEX
 ljb3aUub/oNrd06eBluGGlOxHTw1H3CrX+YAeSlLo3gYvL3Bqs6azLx8shaw486bCePSnmbubwQ
 ZXw5/s0Gcw7fj6V+THhHHLQmQElTjaV88QL+VxJj/KRJAYkZea88+VHEBNlPAAVkK7q4oW8fZZQ
 r+ur1cWIrVX7VuJYhlxLxKJ4qd1H7IIHrzQZrD82DaC5jNEB6zPfcqUylOKAsyhFpvuR2Zcerzs
 TtmPIIc5ICprLz46C7zYMtUiuqmcmO50B+S0BKev0YUYnPuVu2cPTGXubOyTX8XuBK06mRVh2ln
 usBGIHw4PqSaYMOltjYWlZSpPgylJ29tAphRCq9E=
X-Authority-Analysis: v=2.4 cv=VYn6/Vp9 c=1 sm=1 tr=0 ts=695dd13c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=tRLCnyKIFssYOeyxpVgA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12110

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
 mm/mprotect.c           | 107 ++++++++++++++++++++++------------------
 5 files changed, 64 insertions(+), 55 deletions(-)

-- 
2.43.0


