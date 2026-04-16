Return-Path: <stable+bounces-238377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNqHCMR04WkCtgAAu9opvQ
	(envelope-from <stable+bounces-238377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 01:46:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B4E415B57
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 01:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E9DE3034B31
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD933A4517;
	Thu, 16 Apr 2026 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Zv3H7fPV"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020102.outbound.protection.outlook.com [52.101.85.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E43A16B8;
	Thu, 16 Apr 2026 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382892; cv=fail; b=vFhWWC5+XOBloHi36GnXxY7VhwKm/NMsW2O38v56qyHWWgXkWmC2cXZCIx4s46xXqsQScJ/x8O6LPxtLny59BsE7zS5WEUjYZMwAqohvYVLPQlwWVsNJM1eslOdU8o0ZFuMFXA8SseF0Wi95j2Q8jrp/5ga9XVcLa+LezfDDuCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382892; c=relaxed/simple;
	bh=73zhiKbwGRES5MrgjHjk6KETdbvk6FKQKjdvvfZ2CVI=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dmeAD83b2mWQx54EoXK6cyjvoEfB8oUUrp62W0Sts63nwhL44DARPVKtiS5g/gIo8F9g6FbQGT89+0RTmyRro3RtGZjXQRN39K1y60babQk0QEkmzNXIlY8sVvkmEDyptmfOe3wpAiDdQuYbiMgJqKg16wFC6I6jXE07oWr2f3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Zv3H7fPV; arc=fail smtp.client-ip=52.101.85.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJvOH4mnDVo/VVSv9N2XpC9BR2W7bTkY2F62/4wxqXprs2oTuOz4YXqHX8JB/EnUHhtxRbOLWuyGkXmqMmVkXw9ONGtfqQSu2RT1bVEAGePxcjVENU7NTjGI0R0TNlAKVc1UxAu6zRY6gDZRSXd79y5oXQfNp9i2QQNKCsLWYy6jC3Icb34pKWqf/jGm3H8JEFF/+ZYNzrnMWdWHd9UlB/vb9A+ON4SDwTyvG8Dthakm5OGXTk8wlNAnh863ZvLccitk7SL+zNjIumxz666RPWaij/vGEIhqnRXXxauZ6681C+pOjcSB/YCMf1JVS+dhcQx5zyjO+BSZrLHyeBsNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhaXRPXdMCtt5j+SWTRY8sV4gV2JYYzQG7a2loqjY+4=;
 b=rCKQSw9ff/Bb0/Qc/HSKNWTUt0b2s/tYZP6FOpamGsNIYtgbZYy7IXwSHZlr8TjmzTw7YK7LepWtZMp8Iw6Hia7wMNBGuA+iS7tOlNDS8A6ZjeUKx1eWGuwsZa+9MBJYUzo16Ty+Fy5dnUUSWNiJcD2G5lZL9S7kOAv9DrbsuRp3RFb8pv+dhSOfdfXfmCL1X8AZscyIT/JtIgl1wmg1TQf6dJwmHtZltkbhOR6WpLlOFedc9vaFV+nP4TC+T7RjUyTgxq4wLvmIjamvR7s4vfBhbz8BrangJVM6gvKi1Qphklaa3M2X22dPe02hJE5fgiWk2s0iJPDjzJnGtNNLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhaXRPXdMCtt5j+SWTRY8sV4gV2JYYzQG7a2loqjY+4=;
 b=Zv3H7fPVKbp0sI/88GhlyzJEzNwh4CmAqlby9aQhoWGuYRxKobCsSHEEPubGsheG85ul4kQMBhjlFaLA5HmZJHttAOavAMPp0/TVKQ2mFnz45JUAQqbXn8xErRW/JZsvKgBmI6HuJ37uJHy3J5jPBFynSSEyBSKwryguF7YlA+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN0PR01MB6877.prod.exchangelabs.com (2603:10b6:408:161::22) by
 PH7PR01MB8053.prod.exchangelabs.com (2603:10b6:510:270::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Thu, 16 Apr 2026 23:41:27 +0000
Received: from BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::3a8e:b149:407d:a9ee]) by BN0PR01MB6877.prod.exchangelabs.com
 ([fe80::3a8e:b149:407d:a9ee%6]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 23:41:27 +0000
Message-ID: <8661fe28-a651-4624-b0dc-7c32817c9670@os.amperecomputing.com>
Date: Thu, 16 Apr 2026 16:41:24 -0700
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
To: Kevin Brodsky <kevin.brodsky@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
References: <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com> <ac-W9oNM_O5RTtaf@arm.com>
 <beacee23-c177-47a1-b8b5-743844b617a8@arm.com> <adTPFrlVCEt-hioX@arm.com>
 <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com> <adTh8d9k3y5ybemL@arm.com>
 <567dff89-9f0f-40a0-ab10-22e061b4faaf@arm.com> <adfDoatH8hj6zN7_@arm.com>
 <07054475-6b07-4b19-a393-cbe037adef8b@os.amperecomputing.com>
 <adfw_hNDsIWwSAIv@arm.com>
 <e4682b9a-9c18-44c5-a892-b12ce4745474@os.amperecomputing.com>
 <315131b7-237b-4705-ba84-e03a484128da@arm.com>
Content-Language: en-US
In-Reply-To: <315131b7-237b-4705-ba84-e03a484128da@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To BN0PR01MB6877.prod.exchangelabs.com
 (2603:10b6:408:161::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR01MB6877:EE_|PH7PR01MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 5370b30c-a95d-47f1-05ff-08de9c11adc3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	cSzVtfbh9hrwoVyx6iqG830j/rSwEYEwViAzZyjkFGMpkfndz/myiFA7PAcLu1Eq9m7O0HwYQujou3vgnhPu6y+/hhxyMeoI/WOlPYjTjHm8wsM2TVDlK9ddIcwA3Yfh3kw40rzAfyKg5v8n2+DTo7x02H5siaijmvpZZ5iWUuo6TlID0tKjDKCFHDIghKk87HrHCdPGvjZHSMmqN73RxgZmYiwI+cxp2tzqTjWouIVuIgbfvZBmK18VG9N9dUkrohfS74wzJPA0xtoGWP/GwOYHXC09J2x1Ei2Ov+PusbU3u8mWYJkngnw8uIKeFX77M2zcqUkwNLFy2o3+kSxAUQwVAByyUeLwpHxxCKtJW5OzBbP3DtoJ7Ntc+poTKm5VZaviNDgQ3rvVKNPgx45EO9AG+V7vnKOqW2AB0veFrAOC/saioJB0KctXbHBkS9zFwpFvzsh2/NQyTD4XFar/dEhVCt6fGP6W1bWEIB0UC4Q74xKy8/rRKlItWsUEwfd+rbASZSM+tDrwfKhkpRCTZKYMjgl3QiyBAEukJ4GPYl2zHU79SafWcC47j1uZBkL/4oipQvWJ3fJ0wLfMpyvLVtnYf/uQWfQKoZK4TcwrkKmPLvHxBPDIFEwHs8V2p+Lwd7OyiyVbvtoNErfdLkRbd9rAgaAybmTXZj4DaEtgIO2QhjErOEHe7JQCbzhLNOcYIDzjzsEcPuWXu60JrHzS/h6bc33qvhSlP1540nVXaJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR01MB6877.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1ZRU1BxYTlmTW1MdFFaVks5TU5ZaUFtdlc0ZUxrUmhYSTdDYVVuOUR1RUoz?=
 =?utf-8?B?d3BtRndFOEhRWk9SSk14NklLMUFiRUdIWlRvMWptRFpQeHJoY2Y2WXJFSFpX?=
 =?utf-8?B?YS9jWFB4N2tXT0RORm8zSU9VTHNnT2xHbjFhSStLNjV3QVJDa2JJOWtUMk5y?=
 =?utf-8?B?bGNJWjlGODFtTHdqcTdxbE5PcW5jcE10RG9rN0kzTzdSTGhFYjB6eFV3a1l3?=
 =?utf-8?B?K0Y0dG5sNkJmQk41TXJQVmUvYU9xUmZCR3diUDRvdmlwWGNpd1BPRnZKeWMz?=
 =?utf-8?B?b1k4SHFwc0kwbzB1Tnh0ekRuTVJZMkh6U2JRZmRsN2p3MHdtVi9xM3V0NkR6?=
 =?utf-8?B?MGE1Q2E2cUFDS216eXZvSFNwWkxSU0toaGJQaVlWdVBqQmpYVVdLOGMzNDFu?=
 =?utf-8?B?SW9JbFVxWU5GM0tDd2tlaUZrNC9mWCt1NUdobjFtQmhlY2ZXbjBKRkcwZk1t?=
 =?utf-8?B?L0pTb3pTQU9ZTVZnSDc1ZlIrMjcrdkh4WHMwMVZXMk00MmVXUzEzMUdjK3V5?=
 =?utf-8?B?bWx5Q2ltVTlhTURBRXZmZzVsQTNuSVJzRTlwNUVyY0JlcmdBdlJJNFpSaXJP?=
 =?utf-8?B?ZnQvcUd1R2N4WktNdC9aU0l5RDlHWURjNWY3ejh5aVFuejUzR1ZseEUzTkM5?=
 =?utf-8?B?dkQ3LzduVlN2WVoxRVE3OVNXMXpvcVl2OWhVWUVWODFLaXRUUjRJTkZJVWNm?=
 =?utf-8?B?QUZBTVphZGVvbllVV2NXUzlDR1FvbUtLVExtQnpVSnZja0dDUnlvb2F6SGVs?=
 =?utf-8?B?T1pnY2pCbXM5bW1DZERYSUQ2TUdzalVtdVdUTTBoM1EyNFJ6enhPMWpub1NL?=
 =?utf-8?B?QVROckdRcEVCK01qeVhzUU4yMFJ0V1RWc25CSnRyWis4RG5namZUNFY0Nzcx?=
 =?utf-8?B?MCtEQmZzckphQ05nQ2tyZ0F2UkpGZWVCdE51d0t6YlFTMkVyUUh1dlBqejNa?=
 =?utf-8?B?RlNnUlVZRmhJOVphNlhBSk5tV1RHODJPQlZCSFozVDA3b2FlQlA2RFR5TzJH?=
 =?utf-8?B?RlZWK3ZFL0pEb2ZoU3VDdy9sSkhrL1FKTUM4RzJHb01PK1B4VjdkcnVJTVEz?=
 =?utf-8?B?c3h6TGhMb0VhMmRJSWh5MnVqZWhxYWRpcDh1U0dXZTFLME85QWl0VTBUUk9E?=
 =?utf-8?B?ZlhadWQzQVZ6MWFsUG5iYU9YNGFPR25CZEhiZlArOW0wV0RCN3pMQjR4YVRF?=
 =?utf-8?B?dU1MUVhCTnBUS090YUtjbC9sQis2ZFlTL0JvQlE3aXBoK2JORFJsL2R3WVdQ?=
 =?utf-8?B?YkYxZXJuWGl3TEpMRmc4RFJzR09hQVBxODMvWkpVOHFNTHpmcTB0L3FWRGZz?=
 =?utf-8?B?WVhZNHM1RmVvVDkxVldnK1EwNWZrQmZjQXhCaEhybm1kOEdpbHB6dzgxMVVp?=
 =?utf-8?B?SEM0RW9iRytiYVJGck93RVNhS0Jobm5hL2c3Z2NxRFV1aFhqK0N0TXF1VWR2?=
 =?utf-8?B?YWxuSFMrL0Erdm04b3ZYOW0wdGJhTlBRdHBQQzQrbzhRVm1OWmZNclZMVUtB?=
 =?utf-8?B?aWVZdkR3ZTNlYnducTR5YzVWM09ZRDk1WDk4NkVOS25uTEd4eDIwY3VVMXhR?=
 =?utf-8?B?Z2l1WmxMTnQ1UG9Vd3dlWUhMR0NsRGUxSk9WSFFvczF5TmdVUnVqeTFHNTU4?=
 =?utf-8?B?dHBRQ3F3VjR5VzdycXE1TEozSkZ5dnVYMWlxVnQ2TkFoUllrUHlmdmlhTnhN?=
 =?utf-8?B?S3kvTzVlWTFrV3E1SFIxcjBDWVExWmlFbGliOEQxS1ZOQkE2NWJvZ2dKRjNi?=
 =?utf-8?B?Y1gxVWEwamltenh2Tkt1RmpyVnBNbmJpV1RmQ1VIV0ZpR1JhMTdmUVluSHBG?=
 =?utf-8?B?ZG5RQTJhekVUeHVWMlIrUjRHeFh6TGoyYjRqdWdMT25MUW1tZjV5R2lQRjBM?=
 =?utf-8?B?WC9TNjlQNkowSG1wODBxbVNIM0FiYWNwWnhIZ2hnUlI2alJhbS80MU1tV0xh?=
 =?utf-8?B?WGs2OUJudGV3bExPbmNmTTZzaFBQT1A5bkgzTm0vR0N1aUltamlGdDdXYmdU?=
 =?utf-8?B?QU1Zd1Q3djlXOE15emdPWkw0aVdJa2w2NC94UG12a2VmN0NxQTJscUgvdENz?=
 =?utf-8?B?OC9pczhoNmFGOXFZQ2IyV09kZ2pHMzdRUStyRW85bUd2eVBLMm1GOFRUN2Yz?=
 =?utf-8?B?SkNFVHprSEFVQlBJcjJIWjVUVkZabDJBLzRvQ1h2QzNQZHJxQS8wV2Z1YWFk?=
 =?utf-8?B?RC8xQVE0ZVBuOVNBM3VQTmJ4SWV1azdoTlhxVDJlcEhtMmo5V3h5c1B5bHNs?=
 =?utf-8?B?VXNYSWp2M3VrRzU3dVdWcVBiMFBXaDA3cW9MSDhBSGNzMjdjcm4wOHVFVDNp?=
 =?utf-8?B?Wmd1OXBEWXc3OXpPR1NWcVE5SEs4ZDhiMHpmRy94dkd2NHN5MGdtOXFLckkx?=
 =?utf-8?Q?sD+xSNkxeyq8GoI8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5370b30c-a95d-47f1-05ff-08de9c11adc3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR01MB6877.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 23:41:27.7473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWgsFvk5TxyMr2cxM6EY3u+/LFe5oyl/qTqQBK+P4U9DGTNNnBsqtwKhVJ3/kUloistTzkvLY71wFmyLU+tLhdZcgOFRv/qGs26omjEsgJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8053
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238377-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang@os.amperecomputing.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,os.amperecomputing.com:dkim,os.amperecomputing.com:mid]
X-Rspamd-Queue-Id: 72B4E415B57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/13/26 7:57 AM, Kevin Brodsky wrote:
> On 10/04/2026 01:08, Yang Shi wrote:
>> On 4/9/26 11:33 AM, Catalin Marinas wrote:
>>> On Thu, Apr 09, 2026 at 09:48:58AM -0700, Yang Shi wrote:
>>>> On 4/9/26 8:20 AM, Catalin Marinas wrote:
>>>>> On Thu, Apr 09, 2026 at 11:53:41AM +0200, Kevin Brodsky wrote:
>>>>>> What would make more sense to me is to enable the use of
>>>>>> BBML2-noabort
>>>>>> unconditionally if !force_pte_mapping(). We can then have
>>>>>> can_set_direct_map() return true if we have BBML2-noabort, and we no
>>>>>> longer need to check it in map_mem().
>>>>> Indeed.
>>>> I'm trying to wrap up my head for this discussion. IIUC, if none of the
>>>> features is enabled, it means we don't need do anything because the
>>>> direct
>>>> map is not changed. For example, if vmalloc doesn't change direct map
>>>> permission when rodata != full, there is no need to call
>>>> set_direct_map_*_noflush(). So unconditionally checking
>>>> BBML2_NOABORT will
>>>> change the behavior unnecessarily. Did I miss something?
>>>>
>>>> I think the only exception is secretmem if I don't miss something.
>>>> Currently, secretmem is actually not supported if none of the
>>>> features is
>>>> enabled. But BBML2_NOABORT allows to lift the restriction.
>>> Yes, it's secretmem only AFAICT. I think execmem will only change the
>>> linear map if rodata_full anyway.
>> Yes, execmem calls set_memory_rox(), which won't change linear map
>> permission if rodata_full is not enabled.
> That is a good point, AFAICT set_direct_map_*_noflush() are only used by
> execmem and secretmem. excmem only modifies the direct map if
> rodata=full, so the proposed change would only be useful for secretmem.
>
> The current situation with execmem is pretty strange: if rodata!=full,
> but another feature is enabled (say kfence), then set_memory_rox() won't
> touch the direct map but we will still use set_direct_map_*_noflush() to
> reset it (directly or via VM_FLUSH_RESET_PERMS). Checking BBML2-noabort
> in can_set_direct_map() would make these unnecessary calls more likely,
> but it doesn't fundamentally change the situation.
>
> It's also worth considering the series unmapping parts of the direct map
> for guest_memfd [1], since it gates the use of
> set_direct_map_*_noflush() on can_set_direct_map().
>
> I think it makes complete sense to enable secretmem and the guest_memfd
> use-case if BBML2-noabort is available, regardless of the other
> features. The question is: are we worried about the overhead of

Yes, agreed.

> needlessly calling set_direct_map_*_noflush() for execmem mappings? If
> so, it seems that the right solution is to introduce a new API to check
> whether set_memory_ro() and friends actually modify the direct map or not.

I don't have data regarding the overhead. The set_direct_map_*_noflush() 
does walk the page table and they will be called for each page for the 
area. It sounds not cheap anyway. In addition, it may split direct map 
into smaller granules unnecessarily, it may result in unexpected direct 
map fragmentation when rodata != full.

So it seems like introducing a new API is worth it.

Thanks,
Yang


>
> - Kevin
>
> [1] https://lore.kernel.org/lkml/20260317141031.514-1-kalyazin@amazon.com/


