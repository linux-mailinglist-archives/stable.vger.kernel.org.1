Return-Path: <stable+bounces-158485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EB5AE765C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 07:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4223BE699
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 05:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5091E51EE;
	Wed, 25 Jun 2025 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="L+V6Dmoq";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="L+V6Dmoq"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5991A5B8F;
	Wed, 25 Jun 2025 05:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750828560; cv=fail; b=os8crKroVkmFYJSI3NoYKPGdMxd7ez4J0yWZt9Ld9JwLPdSk6PYKv5q+oHU5Q4+Nap+563molnEqtDSDQpg4K0rPJec/J/jTkSO8Fz/l96M0U0loY6m9jUZAKGXpnLwbHUffg0EwuykuldzRC/AaL/uzbIruWOK5pPedLT5Qlo4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750828560; c=relaxed/simple;
	bh=bZFGdGgmIgC2VHHX9WQtLQzgnyospmrpnStgDMcfNXg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MsoHfan7O0uL6u5joHvkejtzFCHSVSj8sU8m6XwcznUy0u1XwThOT8D/HeBc5WQ9QfWAS8zbNFOukIGVlax0KVZ1LyCyBY5Y0O8vRZ3gTxVUQzabZeC61vBVoThfLHuh0/YIEkDWY/Mf5QREzvmxthTLglzyvAM4xh/3hMok21I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L+V6Dmoq; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=L+V6Dmoq; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Cwl84rdnPXh7Tv+YicmB86j6EL3BEz3c5Rw3MqEZueVmbyMTfjY32kTSaiXW0IjJlvf+Fi2nVwJ5+kY150JAyqRNLojI3/NQrUocppCrVNjBM0Wt1pN82qiG7rpD5aCJ3h7eUlEdPGzWbu8+1OJrU5N0t/ZBcQJPXB7+d4OWpXi6Dh+OGsuv5C84dMCvBfwflFFl7hrDVANAeWJ/Oa/QvdJvzDblvYrIL743bm1QycSaVBPoMzIug/1oaaJXNC+s0qDZ8YLRMV/pnvBrdAW/eoINeMs0EZQM8h66PFHMmYJwX/LhnXzMlzjPHyWqn2Ui/VGhj7zPEzanFqZljeFKFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lpPQsBfUxJ2gHqgxGYImynaBvfmfcFU+jJvP7d29hQ=;
 b=GBEBae/xSwB+zK0fjx3bmvcMU43329Nh4zVue1SuXrfcVOfXWEs1GBtBioOAI/YOonh7+MBli+6/tlk0WdHJhIcHrHk+VqSZkniFurV7GxH6zfFSBa/TlBbnoX43sndzE3cyBLTIWa9E6W8wVVJohNq2fLw4sd5hwK9ANTL7TiP6MpSfETcgwInNCTncB/NYhhbMig7oA4HQrQGDYWQsIUiiBy7asI7XnGkPLK2vPKrT+Ju73Hu+FOc2OAqoDpL0LHXY53ECJhUifwYtO/ZekzuJ/Jw3qNpMKTwcn2UsPhtY6lkId1xKthwc4o++VaAsdBHVYbOCm5E1Zt/xVxkW1Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lpPQsBfUxJ2gHqgxGYImynaBvfmfcFU+jJvP7d29hQ=;
 b=L+V6DmoqpICB4Q4Y4R5PW9XKgxh1/jaccmhy90asI577tBhEBTlMzxAm1IZHelGyqj2ThdI4Qv6sySHGwIgT21qEtjRYXlGI4rMGp4K+2etUVAW/6Uy9yOpw6fwlwYxatkYVwdL57opulrS/dZOIvXVqq+Eg9jKtpoXc6ZGMbMg=
Received: from AS4P251CA0001.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::19)
 by DB9PR08MB8388.eurprd08.prod.outlook.com (2603:10a6:10:3d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 05:15:51 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::a5) by AS4P251CA0001.outlook.office365.com
 (2603:10a6:20b:5d2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 05:15:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Wed, 25 Jun 2025 05:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtLqqLajd01fLvIl4pRja2eGwUPTsuIjtchIbp/o+863+eeAkWrd1v8ia6f1wcA2EIlhnEjM8/TpBs528XmYvj7qvJfSaMyfgs5/QiXVi1Q76MwlcAb0yi/F1saXngJl6a0K1CvGrr4AjJqfhzAYDeATRt7oRWe/ZFEADPT7I6y+QB1oxfxFr86Sb0Rf7FPbV9ILEnZ4BP4MMLCz7EmeokAG8GTjY+5rTB6WhCcQkHVRvVWIsoFV18NmR+r0YkFRCcD3zT+ZkqjA7hlfXvbsNCiBEyXq09Q7SEyz5y5sLU3fdY1mTLm2AUm8VIjwsxRwA+EzCy+OjnJnC11rXpfnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lpPQsBfUxJ2gHqgxGYImynaBvfmfcFU+jJvP7d29hQ=;
 b=C4dVoXZM59ThE1c2iSj1ZxdXNhwadWARi9ljuEApLK29WT943Bp4uyOeln+Dswbtp5Aw6jri8/tDHbXbA60DZDnNt0CNwuAA4C61MRaYPs3Ez5bYz5DYyetJCfhRqRmn1GDxxmiqznNDz98BKU9KeSime+mUTSeGVTJtLbCLGCrXnaeAhIIxXOHEv5eFE1M1it7FMRYmAHY/SXQTt00eq5TDdUbOrMWGwRFM4zdcmTb5Wxu/Sfh7jnvP1rktIIBYL2hTzkHZoiqgXBmRtRtvcyH1Rl27vxZ2m5tfcpIW2Xvu966xG8SY3s9TnGjcIGBq1V7DJ+NCikF016PBzOQv2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lpPQsBfUxJ2gHqgxGYImynaBvfmfcFU+jJvP7d29hQ=;
 b=L+V6DmoqpICB4Q4Y4R5PW9XKgxh1/jaccmhy90asI577tBhEBTlMzxAm1IZHelGyqj2ThdI4Qv6sySHGwIgT21qEtjRYXlGI4rMGp4K+2etUVAW/6Uy9yOpw6fwlwYxatkYVwdL57opulrS/dZOIvXVqq+Eg9jKtpoXc6ZGMbMg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com (2603:10a6:20b:402::22)
 by AS1PR08MB7401.eurprd08.prod.outlook.com (2603:10a6:20b:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 05:15:16 +0000
Received: from AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45]) by AS8PR08MB7111.eurprd08.prod.outlook.com
 ([fe80::4ea7:7e71:7dd3:3b45%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 05:15:16 +0000
Message-ID: <c63e9e0d-5f63-4e33-a1a5-426970370514@arm.com>
Date: Wed, 25 Jun 2025 10:45:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] maple_tree: Fix mt_destroy_walk() on root leaf node
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
 stable@vger.kernel.org
References: <20250624191841.64682-1-Liam.Howlett@oracle.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250624191841.64682-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::12) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR08MB7111:EE_|AS1PR08MB7401:EE_|AMS1EPF00000046:EE_|DB9PR08MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e41c6eb-8c54-405a-584a-08ddb3a759e2
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VXBpNi96VEo5VW9pWmttM3dZbWFWTEJtNTA4M09nU1plYXY4YWxqKy9HRlR3?=
 =?utf-8?B?TGtBRGtaemdGK21wRE9QTU8xT2NnallMSnFuY0lKejdYZEtxMStIQXBWd3cz?=
 =?utf-8?B?REphY3hjRm05cW1BbTBiVFFhajZ5Y3JhcFc1Y29qSXhGc1NnZmYrSVRNaXRG?=
 =?utf-8?B?QXB5OUJZM1RPZmUwK1puM0ZYR2UyWXlUN0oxODNWN0wvSE9WQ1hWb2JuYWQx?=
 =?utf-8?B?QVJyNlpqNkdpU1hoUTdzVnJjbVNhMzlvbEZWMHJYMkpobVREQzlaaGpGVnVv?=
 =?utf-8?B?Qm9mVHhkWUkrendPd3ZvMkNpUEthN3hLeGpSYUV1WEQ4NjcwL0R4TEVOWk50?=
 =?utf-8?B?UDJ0ZGZLWEtpTTJidHRzQjFST2JQWFhVSDVrdU1SWUo5OG8wS0xQSVNDT242?=
 =?utf-8?B?K2NZcktXRTFuNXRMQ1ZrYkI4aFJMa3BwTldSZjZtTWZrVFNnR05qUjVkUmlD?=
 =?utf-8?B?c0JWalR1TUhJd2UxY3NyUDdLY2RqUHJnQWJkVGc3a3dNUzA0b3g3WCtHb202?=
 =?utf-8?B?b1FzMnZnVy9pRWtFcUp0Ukc2MHdGTDJhMC9qWmFEeEFncUFobFVDbDdkU2w3?=
 =?utf-8?B?RGVZQ0grTW9pNXNwbERyUHdWSkRQeGdjVjBjK2RRMyt5Yk13bHR3WVVkMEFt?=
 =?utf-8?B?dXhCZ25VdnVNSmRxZXZFOGxlRVk2OWlVUWkvM3dLWk15MDhFcTNSRDlrejdU?=
 =?utf-8?B?bVVzL0FWaExzYVBEajRvVUxlbmNXeFltVFlZUlY4SE1nNy9hTHF4cDF4Zldn?=
 =?utf-8?B?TUlUUmdiRGFSa0QvMWJpZ2dFcnl2OVFBRGQ2SUVOTHZnUjMyRzFobzY2WEMz?=
 =?utf-8?B?MzFibk5TdVJ1Q0ZZU3Z4M3QrT0ZvUmtOalZ1SUdCNFhmQUR2VnFIZXlPb1JT?=
 =?utf-8?B?dEk1Rlh6YnAxa2RFWVEwMDFzeGhrSm9BVTRtRlM5RmRYd1lYb25SVVgrSzN5?=
 =?utf-8?B?NVJpeVdlbmNSWXhVTnpGSVA5WkhqNjE4N0FnTDlZcjJQVEo1eHZwd2NEUCtZ?=
 =?utf-8?B?SVZkK2ZwMWt5aHBPMTZMK0ZyWWMzZjhPZHhLZG5tSmd1cHhGVm5ob1dHMG1C?=
 =?utf-8?B?eE9XNEk0czVBVDB4ZVBHSFZTNXBhcnNUMEQyM3FKWmJtbFd3TnVQaU1rWGI0?=
 =?utf-8?B?REEreUpmWWJFRTJ0U2xDN0R3SXcyT2J3MCtNQ3RJdkxOaG1EMVV4N2I3ZXBG?=
 =?utf-8?B?eTZTRTRTNnlkT3lnUnFKRjQyOEFHT1dQYURoVTlhcWJsVm13WUJwRDg2U3gv?=
 =?utf-8?B?STM0Wno0elBtMzU0SE1YemRiVHNFVWgrNVUraFNrbVRmVWs4YTlPeGlRQ0kx?=
 =?utf-8?B?citpQnlsY2hMdEJHQ2tRS3U0S05oNUkrL2MydVFNUkJPVStEeG1YMXJyczBH?=
 =?utf-8?B?RXpVSngzVWpsazZ4OEVUNmw0Ry9STHdaYUp1cHlCc0VNOVRqVlh2aXhDMU1C?=
 =?utf-8?B?aEdkdDdnQzZHbVlyRzJBTytEeDN2akIyTnIreU9ubGtScStsd01GVndWd29T?=
 =?utf-8?B?QStFaHNQd3p5Um43NmZSVk04QVdoRXpXREI2K3JhNUV1elllRWFpZGY2aVZu?=
 =?utf-8?B?c2FQNVNyeXoydUFUQjhPN2xJSnNKOFRPWEtGTzhHd25sOTJJN08zVWQ2QmZv?=
 =?utf-8?B?UXBvSjhEVTg1TkxCNDk3SnFuWTFRYmtqM3ppeVJWZHIxVlVaN3Blam9XdS8y?=
 =?utf-8?B?RXlMRi9WeHNiTFU2LzhwNDE1Tm10SnhnbmtpSmp5dmpYdndFNXh1ZGo4NW9K?=
 =?utf-8?B?YVpQN2FnZW5oVkFMS1dCMzV6bFNRMDBsUnJ1L2lqM21aUHRId1E4NGxmTFBV?=
 =?utf-8?B?ejBmck03Q1NGWXhWcGVRSkxRRFowUDZCMENIdFdDZ3kwQ2FTQ1hKYXhxek83?=
 =?utf-8?B?S24xM1l3cll3UGNlYWIzVW1oK1ZMOFVaOTNWMmlQQ2MvMElvTUMyTGhOQWEr?=
 =?utf-8?Q?GdIGyjoJCtU=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB7111.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7401
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b4ae7ef8-c0a5-4c22-aae5-08ddb3a744f9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|35042699022|14060799003|1800799024|36860700013|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QnB5b25kS04wZEJ2ME9BZnFmRjQwWFBlWWVNU2ZIYjVnUDlHblIxbkk2QmlQ?=
 =?utf-8?B?RVJCQ0Y5ODFNTnZXTVRGbmNVRUZ4b2FqTStuL3JEOFZVTGRJZm1Wc2tTaUpW?=
 =?utf-8?B?NkRGYVArbmEzZGRnblFhNmJHSnFkUUtCd0JBN3hwZGRYR3dOcmZNUENCY2Ra?=
 =?utf-8?B?ZDU2K1g0YzdYSVNDcjFEcG5hdTFpRUc0ZEdHSGxGbm1wRldid1lZMy9ySmVZ?=
 =?utf-8?B?NmwyR3M3Q0s3NnQ4bGdNMVptdGZLQk9Wd0d5dWc5WWlSSzVUalpXcWp3TDdW?=
 =?utf-8?B?QURSenFKVVg4Q0ppY1M3aGJGUXVEUVk3RnU2TXpyTGVQSmY4NHgvVVFhdjVo?=
 =?utf-8?B?cHVqVmdBekxHWDNrM2R3azlucWhSRHZIM1hpWHEzbms2Yk5JRHIxUmFWL09U?=
 =?utf-8?B?TlhBeFFlbVdkN0NJeER6c05ZRXdrZU1YaEJjYVBHd1VUODNsSGx6bERvUzZR?=
 =?utf-8?B?QXgzd09tSjhEMVhmUFVXTUlOdE9NU1ZOU09VMEs1ZlM3M2VQbkhNSEtOV2pE?=
 =?utf-8?B?K0EwbEVoeVhqQ3MzLzZvVEE0eS85cW1nRkZ4dmxpejhieUpnSkZKQ2ZIeXh1?=
 =?utf-8?B?U3BqTDNaYzN1dlY0K0pKbTU4NWl5ZDQvUzJhVGZ3WkZOQXpUWkVBR3NoV1NQ?=
 =?utf-8?B?UitiQ3pMeHk0V0NQOVVYRyt6SDVyNkJ5VjB2TjNTMXFtcDYwcVYxODhmM2FL?=
 =?utf-8?B?TXVXQ2ZMVHVaWkJLSi9FcTEyQkRQdERiUEtGYTNIakxWbUdWajY3cWRXd3Vw?=
 =?utf-8?B?dEJpS3V3TTZEekJWZVJuejF3b0lWbzZMaWJaaE9jWmRHMW1oYmxOWFRNYU1k?=
 =?utf-8?B?ZjVjWi9VVTJvcmttM29pV0xzeGNBaDhxc1VWRVUzdlRpSkEzVjBiZG1OV3FW?=
 =?utf-8?B?eDBCS1BySkFmSmNtQlliWEQ4V254WUt0WTlsc2tzYmRSSlFqOVY2VlMyUjRZ?=
 =?utf-8?B?U0U0YVRQY013UnBlRThuYnNnbTVBL1dpQUVELzc3a1JWQlhzWWlnWTZtMHdj?=
 =?utf-8?B?N0NpWUJVSEZ1ODFvZVFvb3c5akFCbVdmVlhTTno1aUhXMlI5YlVYMG43NUJD?=
 =?utf-8?B?VVZOcTRUQW9HSGlmdU5iMTVqc3p4cDU1WUZLQzJMUWprOW5FK2xOZjJGWWJr?=
 =?utf-8?B?Yjl6d1poN2hPU0ZubU5GSXRFZlF5a21IUjJuUE5wa2ZuRzZ5c3dZSlc5RnJC?=
 =?utf-8?B?dlFZbnZvTml1NDF5VXgzVEgvU2RUcGlacEY0MDFNWGlPZGVUN1dtd2ZCaWlq?=
 =?utf-8?B?d1k3VnR4QXQ0emVWSDFpWFcwbTV1WE9WdzUyWWR1MDJoZXpGWld0eDhMNXVl?=
 =?utf-8?B?WXhLZUVCWEx3YWd2SGQwbDBSSVFmTkZRYkpTMS9WaVlJeGtxeXU5RkF0V0x1?=
 =?utf-8?B?eU1RNkt1MldUdytYQ2xZZ1dIZk94aXE5b1hYa05nMHhkRUFVL1RwcnQwYUxM?=
 =?utf-8?B?OVFPQlF2ajdkNngydmxTc3JlQ2dMQ2ZrZks1WEdDQUY1ZS92TVltR0ZzT0NG?=
 =?utf-8?B?OE81bm1iQ1NNZ2ZJWU5ubDFkVVJ3a3BwM3lrWE1PUno3czFxVzVxOVE1ZFd5?=
 =?utf-8?B?WHM3cmhWa2FYL0NHTXkxUEhuK2FEcHVUVHZMeXNZQlc1bUQ4Y2NORHBseFVM?=
 =?utf-8?B?VTNObEo0cnRJZW0rUHZibnI4TFhvU3lmMGN4b1dZNk50Nis0dHdPQkdaa0RW?=
 =?utf-8?B?RmRjNW55bXNINkhuQjRLQ0VtelFicFhRdVJUS01tWWYxcXdMWEx0QnVjNGph?=
 =?utf-8?B?cEJCNHhReGkvNVJCalhJZW9zUzJ1cFhuSVVXc2pGNGcwVzQrTWdzOUhsdlNN?=
 =?utf-8?B?eEFycnBXdmxUOGhqbmdaQlZDOGhNNHBtYUxkcFNxaGxyRm9PTGxydDZSRkhs?=
 =?utf-8?B?R1ZwZ2puayszV2dnYTA4TXZvV01rS3lKdkxqOURCeG94d21VK3BkcU5yZnor?=
 =?utf-8?B?YXlCVG1sTzhxY1ZFVTR4THVlWDRUMW5OVDJoa0ROVk9SNGVxZU04WVpHV2lU?=
 =?utf-8?B?OHhHSjkyaEVDZE1TTGl4S3RWRTNacUdYTEg0VENpckxId0FXL0ZZTU10WUQw?=
 =?utf-8?Q?Kw9lPJ?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(35042699022)(14060799003)(1800799024)(36860700013)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 05:15:50.4398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e41c6eb-8c54-405a-584a-08ddb3a759e2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8388


On 25/06/25 12:48 am, Liam R. Howlett wrote:
> From: Wei Yang <richard.weiyang@gmail.com>
>
> On destroy, we should set each node dead. But current code miss this
> when the maple tree has only the root node.
>
> The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
> node dead, but this is skipped since the only root node is a leaf.
>
> Fixes this by setting the node dead if it is a leaf.
>
> Link: https://lore.kernel.org/all/20250407231354.11771-1-richard.weiyang@gmail.com/
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>   lib/maple_tree.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 6b0fc6ebbe363..85d17d943753d 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5319,6 +5319,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
>   	struct maple_enode *start;
>   
>   	if (mte_is_leaf(enode)) {
> +		mte_set_node_dead(enode);
>   		node->type = mte_node_type(enode);
>   		goto free_leaf;
>   	}

FWIW I have been reading the maple tree code and this looks good to me.

Reviewed-by: Dev Jain <dev.jain@arm.com>


