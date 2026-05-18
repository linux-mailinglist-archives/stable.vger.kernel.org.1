Return-Path: <stable+bounces-249367-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M1FK5JgC2pgGQUAu9opvQ
	(envelope-from <stable+bounces-249367-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:55:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F852572791
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 20:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE33302C6E1
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D538C421;
	Mon, 18 May 2026 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CZLccI/p"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8B384CEC;
	Mon, 18 May 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130422; cv=fail; b=NiXdwBdxlLbk/ugl9rlpWUTcHJwfr3OZDFvP0V0UlM7ZGhsIa838g0USRkTd+hYXJ8do01eL9EBb6MEUZYGE7xxJO2GynBbuI6AxlSdr44rCnu0MLVsXf0+7OQWeKDwW9Olks24fKhsKriSJIvTrielDTzxu/8AeNUt2aYfwtXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130422; c=relaxed/simple;
	bh=yrbKTN7Ludj8PbmUeDAkK7prjz2CRuTnNRU3wLAcCg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lieqst2sBr7L5pZ0tHetz5MZHDcm0O5gsWFBlMPhztYM7OdcUb9UbkPJn9qbXV0iO5dU26NmNAJlZqzLoCTqqOyXMf2nFnnGXa2PwO+rl7l3F/tlvyIPFACosJRXbMi11Mec8W4QufnAotMxnMyz2tsvJe3WVAh+PPmPjaRXkgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CZLccI/p; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRtRXUi8U7DUQXt25i7gcDfiadmyWGnR/RePMFnMUVpoZ/Y+PCBjH09ipPe8bTJFmFgjZi8Yoz99TRYmhYt2QeozZlyqpTvHqtQ+PoE4bO4CTVJWALEmb4D+aWxZd5G1cQiWlQyolWf4J/OfUqfCIbdDSBTWP7j1hNOSJg+gUzs7rOJNa429wthCZrR5y9U+2ftjWStZ2/nN87oxxKss+p0xtsIEPVgR3o9Ftii6PDSZQwU1NpS/otBjvxdI2U83N/KqMLfDnQdg28n/W7WxtMvFGWoA2MOSrn69SFUSDqsSe9vu3+z/JnJnYOzbtT6vVyhCfPevDihODhR5aEXlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuYifMqXao8Y9CTm4gpb1TIZxOWIvoTKOSMBR1RKrvo=;
 b=kgn7q+B3k8ugxja9vZ9m5QhQHltnYzN0zC6SgRYfri/+FnW/7CdiOxfGpw+FewATGvu/1mesxklQZ2sFGioUCBQCiY/132kiIzUlvB9BSxrXZGQ9BrhmsgXfLExcOxIKVtIgmWj8nYO5kXzOFUAHxwwPZBRdW4JCponQL+dRDi/zA+3nO/oFM+P54MVo0DdFkdH9WFJCdeKxq4U81lPVxpt8BaejYVRFcnC6YSOIqIuNxC/1QiDT6uu/314+oLxccVo0/7Ib2Z27OHY3iqQRb19Ooq3sK23P6BY7G2D7DU+Rh7HrbHJ4R0RNymgioe9k4nNTHRf/i+OfHaAy63Vq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuYifMqXao8Y9CTm4gpb1TIZxOWIvoTKOSMBR1RKrvo=;
 b=CZLccI/pP0wJT947dvO6u0xohqOWdDPhTcDTxLBaWJ0+Aqc+NsQdlxbI2Vr2OMYdgwl6XL7+j8Vp0Z9BVxwEa0bhaEtO87B9UabZn/2e5V+AHvfM37gB3YNnMFjiPGCC1M8FWz/ican/1EU/E8BGV+BS9iF80nnn23z6X9yTEVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by CH3PR12MB9454.namprd12.prod.outlook.com (2603:10b6:610:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 18:53:33 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Mon, 18 May 2026
 18:53:33 +0000
Message-ID: <37823e80-01c4-48ef-b873-c3424024625e@amd.com>
Date: Mon, 18 May 2026 13:53:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: loongson: Override PCIe bridge supported speeds
 for Loongson-3C6000 series
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Xi Ruoyao <xry111@xry111.site>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Ziyao Li <liziyao@uniontech.com>,
 niecheng1@uniontech.com, zhanjun@uniontech.com, guanwentao@uniontech.com,
 Kexy Biscuit <kexybiscuit@aosc.io>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 kernel@uniontech.com, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Lain Fearyncess Yang <fsf@live.com>,
 Ayden Meng <aydenmeng@yeah.net>, Mingcong Bai <jeffbai@aosc.io>,
 stable@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20260518172138.GA626799@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260518172138.GA626799@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0089.namprd13.prod.outlook.com
 (2603:10b6:806:23::34) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|CH3PR12MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4f58c4-62c2-40d8-ae96-08deb50ec261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	dpdVuViJDKY3SkqpEino2VFUaXUT73OQm/MrXjDhWLphmV3cxdQ91cMHx9qngP5DSXZ1jJgRvdECo6CBBIzENzDPyT526ceTiouQ0Gc8f4nvLHnUeVqM6WlrJ4lqzlSMvvX94nCtodbaW2pCfgDFf7m3Vs+J/F2KQ2FH2sKvBWao4FUWTGG7WNczw57LVgtnDNQE0R/JVpS2pnSCWmc255m00l0P0DvVU00q0eAq9LtWUr1VWz4k1TXDQ/rvK+89Ge5FBuO5j3rrppJuxOkldERMa7HlXhtbCPsK2wAowcApr64OrW3TFw64n1kodz7x1nrf6GPBq2ccj4bO0bxeiXJzlafFZVac999suWyUnDKtkyUofRDMwd2dyTVfQrVMzUSynkKahMJgZ08UgHpVMrsxQ4b/yWnOvgtiPtyM960B3wIBsAu7VRMRjpaxSsqdi0M51qhC9ZxXqd2zjMFVlXQHX46tyAEtRDNOz9HaIuzqK8dLgbLyOwTGY+qjiegNpTCObjXyKjsnCbz5WsCtMLrajCzb0MX1aM9+LiGR7VLN/46uosS0j0t1wvUL7BrPDBvpGkJsoL24b+AojvrCkR7HaffgNS50N8m5W1MzkNk4ND8NBJcL+erFJAUR3pVk0V8ArTjlnVpjAK49GLdHgAd1VJYDiR+hRNjlOqWPlle36jMW799/uxWLmdwNY5a73klzPy3lHzngd6v8gAvW8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999147.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmtZZjVUM0NxWE5nRzZSaGNLeVBiKy93b0FSelVjcjl6eGhtUFQ2a2ZMN2xx?=
 =?utf-8?B?NnpVcDU3RmxEWHZSOU9tQ3pNZmVSYjNyd3doN1UzT0tnZDV2YVUyVW03VElL?=
 =?utf-8?B?cFJYM21vZzRkaitFM25oQkF6TzJ2QldFVlo0WjJUYnFpZ2xzdzNOSFNOTnUw?=
 =?utf-8?B?ajV3V3VvRERDbHJKKzBvUjA2UWk5dzZxTFFwb2hlYklJM0IzVk5FSG1MYmEy?=
 =?utf-8?B?dFVnYjBHY043VUVEcXBIMFE0QUpZNVdySFdVRUtEakRaRlp3b0JoM3dBRjVh?=
 =?utf-8?B?TWlkVHgwaEtPV1QxYVdra25FR28zSXNOSHZRNlFlZ1E2RHBDODV6SzJ0MFM4?=
 =?utf-8?B?QU5EVnAzUThQSGtQZ3IxMHBwbEtiQlJ3bFVMbnBMVWRPN1RFWWFmRlJZWE5I?=
 =?utf-8?B?eDFXa2t6c2JBN3RKUTN6TlFBdDNxQWtCR0t1d1lxRjVjdXNIY1FVL2hiQTFo?=
 =?utf-8?B?MVNNOW43T0c0Z2ZocC9IK2VvMGdsanJJYUR5cFVubjZYTE9LL3hEcDZremRt?=
 =?utf-8?B?UjlYbGhQMzExYjZSaTVwOGJZWjFHQ3oxRE53Z083d3RWQW05bWIwWlpBY2V3?=
 =?utf-8?B?YUFDZkNCb1hKUGg0SzZ2Tkh6amhRM0NzSEl6bmJqcFk2cDJROUExZHZ4eEdI?=
 =?utf-8?B?MUlRRndwQWdic1V4RENvWlhrOE13blBYQkxMU3NIelBVTDdQeXF6cDVPY0ZP?=
 =?utf-8?B?ZmIwT3Y2NFdIZUludnVQNDNvblUzQklOUGI1THRIQzU0NkNoZzFsZ2kwclMx?=
 =?utf-8?B?T1JzMXpLNldCSEZtbEl4NkhlUXh4R1ZEUWNCMjJBM2E3bDhFcEhVTXBDaUFr?=
 =?utf-8?B?M3ZMNzM4c28vNENqbFpDRDF4Y1FNN2tuRlZZaW5UcnAxT0hBNjVwWWFKL1d5?=
 =?utf-8?B?TzBKbDRybzI0c1VHVWllbFY5QXV6Qms3M0o5WTF6dUtHb0JyMnJvV1dHV2ND?=
 =?utf-8?B?NktiZmV6dkJUbWJuSjhHc0hkLzRQVURlaVVHR0hGZjZwbzhlVjlmTm4wandk?=
 =?utf-8?B?VFFGZ2dpSiswYkRFdUI2YWdFMjF5bmY0YzEzbnJ6aGM3OTVmZ0ttUG1EWkhL?=
 =?utf-8?B?S0EzTGVncVlYZlk0TjRSOXp3YU1SZU0rbDhDN2NXN2g4M2hsNVNlU0Z3NnYx?=
 =?utf-8?B?YTRZWEVPbjhsWWRrUklmMlFKbDIzSDZZTkUzZkhXUVVJcjNwQ3JnTktod05P?=
 =?utf-8?B?YktQNW9rb1FWU2NpbXk4N0I0VEhmWlRjbkJ2TDNMeHZxZTIrOEptWThXWjJw?=
 =?utf-8?B?cUJKQ3VkN2kyUXcwdFcyd2F1bVNvSnlyMlFMaUlVOHVQVGN0QUVRbUhNNXFL?=
 =?utf-8?B?NU50N1VoM1JtWHhZS29kOFFydVBBYnlNOFR1NlNvYXpldDB0VTV6M3Zmd0ZE?=
 =?utf-8?B?Y1BveGV5L3A2dlVPeWtiemwvbG4wd3RCcHVnQ2IvQ0VrZmJ2OXVtUG0yckxB?=
 =?utf-8?B?N2tFL1c5VFdyRFFuNlJ2MEM2RHcvTktERE9ZU3FKdzVaQTNSRFJmRW1iMDcr?=
 =?utf-8?B?TnV0Vlo0QXRBdERLblZOZUhrK1pjTVB3eCt3Unp3dVQrQU1WbnB1a2ZUR2g4?=
 =?utf-8?B?TWxmc01IeDRuTzdVQ0F4ZTAxMDhMaXR3RTVTcy8rMG9yMjNBMjNLT3Z1RXJO?=
 =?utf-8?B?UjYrZmxxVi9Kb000RjFXdU9XTHJDbzRpbStKaUo1VFFnelpwSjhsa1h0T3Zu?=
 =?utf-8?B?aG9jdVVjVXA5Q1MrcGF1dUNyaXJ3d3hod1IwL2R3VHc2dldMaGFpcVNjNm9h?=
 =?utf-8?B?dXk2UCs0WCtvV2JyVXlxMDNCQXhibTVhMzlld05ROEJaRndpTjZrVFl6cTNV?=
 =?utf-8?B?aG1ZelVHQXhMTUp3OFUzUGFqMFIwMnFsMWxZRVV2aGRZNlM0bnlyb2ZxbHFM?=
 =?utf-8?B?eDcwODRnRWgxSExlNGhkTnh4OHlhZVBEclIvYkNQVFpPUWxSTjVRR0ZTSWxS?=
 =?utf-8?B?aS9jQTBMN2M3dU4vbU0yZTJSNzZ3TENVY242NUtJQy9Zb1YvaWY0OGFKd28v?=
 =?utf-8?B?aVlGRVQwcWZOMElYV1Z4WjNmdzUyV0h5bXl0VW1wSEJjSGZpMWxncEJJVU13?=
 =?utf-8?B?SFRUdU1rL1pGSE1IalBUUUc3b2Vqc2J1WDdIUFl4QlhhWFFaQTNwTTZjNWV6?=
 =?utf-8?B?NytCSmhzSGJmejNkMjVNcE1vZzMvc2x0RUFRNXlpdmlqUENzekduOEJtcnYz?=
 =?utf-8?B?TzFVSDlrUWJaeXpaeVcwenNMaEJsN25PdFZreTJZV1hubHBTRXc0Q3IxSmtM?=
 =?utf-8?B?bm9KNkVENVdmV2FlbVUwMnRDU2dIQVY5a3ZZNTR1M2hBc0wrZklEajUzbzYw?=
 =?utf-8?Q?oudPGAMxgIAE/6Htas?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4f58c4-62c2-40d8-ae96-08deb50ec261
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 18:53:33.1188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClaMWNhzCTP+xy980fiDZu+rD65qXf1WKHlxrgy6H7RsOaoWvxT7eA8KVA7UFttq68iDwXYfFi91dsXWZhAUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249367-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,uniontech.com,aosc.io,vger.kernel.org,lists.linux.dev,linux.intel.com,live.com,yeah.net,loongson.cn];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[live.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4F852572791
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/18/26 12:21, Bjorn Helgaas wrote:
> [+cc Mario]
> 
> On Sun, Apr 12, 2026 at 06:17:31PM +0800, Xi Ruoyao wrote:
>> From: Ziyao Li <liziyao@uniontech.com>
>>
>> Older steppings of the Loongson-3C6000 series incorrectly report the
>> supported link speeds on their PCIe bridges (device IDs 0x3c19, 0x3c29)
>> as only 2.5 GT/s, despite the upstream bus supporting speeds from
>> 2.5 GT/s up to 16 GT/s.
>>
>> As a result, since commit 774c71c52aa4 ("PCI/bwctrl: Enable only if more
>> than one speed is supported"), bwctrl will be disabled if there's only
>> one 2.5 GT/s value in vector `supported_speeds`.
>>
>> Also, the amdgpu driver reads the value by pcie_get_speed_cap() in
>> amdgpu_device_partner_bandwidth(), for its dynamic adjustment of PCIe
>> clocks and lanes in power management. We hope this patch can prevent
>> similar problems in future driver changes (similar checks may be
>> implemented in other GPU, storage controller, NIC, etc. drivers).
> 
> Why is this paragraph here?  Is there code in
> amdgpu_device_partner_bandwidth() that wouldn't be needed after this
> patch?

I don't think that would be the case as this patch is a pure quirk for 
one device.

The policy we have in amdgpu_device_partner_bandwidth() takes into 
account specifically the topology of dGPUs that have integrated PCI 
switches.

We need to look at the speed and width of the link partner connected to 
the switch not between the switch and the GPU PCI device.

> 
> This patch updates pdev->supported_speeds, which is used by
> pcie_get_speed_cap(), which is in turn used by
> amdgpu_device_partner_bandwidth().
> 
> Is the point just that users of pcie_get_speed_cap() (currently just
> amdgpu, radeon, and sysfs) will now see the correct maximum link speed
> for Loongson-3C6000 bridges?
> 
> And the "checks" you refer to would be the tests in
> amdgpu_device_get_pcie_info() that use the results of
> pcie_get_speed_cap()?

I think I agree with Bjorn to drop the paragraph, it just adds confusion 
to the reader.

You can have a sentence along the lines of "Updating the speeds to the 
correct actual support of the hardware avoids quirks in drivers 
consuming the speed information".

> 
>> Manually override the `supported_speeds` field for affected PCIe bridges
>> with those found on the upstream bus to correctly reflect the supported
>> link speeds.
>>
>> This patch was originally found from AOSC OS[1].
>>
>> Link: https://github.com/AOSC-Tracking/linux/pull/2 #1
>> Tested-by: Lain Fearyncess Yang <fsf@live.com>
>> Tested-by: Ayden Meng <aydenmeng@yeah.net>
>> Signed-off-by: Ayden Meng <aydenmeng@yeah.net>
>> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
>> Link: https://github.com/AOSC-Tracking/linux/commit/4392f441363abdf6fa0a0433d73175a17f493454
>> [Ziyao Li: move from drivers/pci/quirks.c to drivers/pci/controller/pci-loongson.c]
>> Signed-off-by: Ziyao Li <liziyao@uniontech.com>
>> Tested-by: Mingcong Bai <jeffbai@aosc.io>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> [Xi Ruoyao: Fix falling through logic and add kernel log output;
>>   add Fixes tag and rebase to 7.0-rc7]
>> Cc: stable@vger.kernel.org
>> Fixes: cd89edda4002 ("PCI: loongson: Add ACPI init support")
>> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
>> ---
>>
>> Changes in v8:
>> - Add the Fixes tag.
>> - Link to v7: https://lore.kernel.org/all/20260121-loongson-pci1-v7-1-fc79c85a574d@uniontech.com/
>>
>> Ziyao Li's original commentary message follows below:
>>
>> The reason of not just copying pdev->bus->self->supported_speeds is
>> that we're concerned that this approach assumes the upstream port
>> reports the same capabilities as bridge, which may not always be the
>> case in future silicon revisions.
>>
>> Our current conservative approach ensures we only enable speeds that
>> are physically supported by checking the actual max_bus_speed. For
>> example, if there's a future Loongson-3C9999 where the virtual bridge
>> reports Gen4 support but the physical bridge only supports Gen3.
>>
>> In this scenario, directly copying the upstream port's supported_speeds
>> would incorrectly report Gen4 support for the downstream bridge. The
>> current patch ensures we only set speed bits up to what the hardware
>> actually supports, based on the measured max_bus_speed. This seems
>> safer for future silicon.
>>
>> Changes in v7:
>> - adjust commit message
>> - Link to v6: https://lore.kernel.org/r/20260114-loongson-pci1-v6-1-ee8a18f5d242@uniontech.com
>>
>> Changes in v6:
>> - adjust commit message
>> - Link to v5: https://lore.kernel.org/r/20260113-loongson-pci1-v5-1-264c9b4a90ab@uniontech.com
>>
>> Changes in v5:
>> - style adjust
>> - Link to v4: https://lore.kernel.org/r/20260113-loongson-pci1-v4-1-1921d6479fe4@uniontech.com
>>
>> Changes in v4:
>> - rename subject
>> - use 0x3c19/0x3c29 instead of 3c19/3c29
>> - Link to v3: https://lore.kernel.org/r/20260109-loongson-pci1-v3-1-5ddc5ae3ba93@uniontech.com
>>
>> Changes in v3:
>> - Adjust commit message
>> - Make the program flow more intuitive
>> - Link to v2: https://lore.kernel.org/r/20260104-loongson-pci1-v2-1-d151e57b6ef8@uniontech.com
>>
>> Changes in v2:
>> - Link to v1: https://lore.kernel.org/r/20250822-loongson-pci1-v1-1-39aabbd11fbd@uniontech.com
>> - Move from arch/loongarch/pci/pci.c to drivers/pci/controller/pci-loongson.c
>> - Fix falling through logic and add kernel log output by Xi Ruoyao
>>
>>   drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
>> index bc630ab8a283..a4250d7af1bf 100644
>> --- a/drivers/pci/controller/pci-loongson.c
>> +++ b/drivers/pci/controller/pci-loongson.c
>> @@ -176,6 +176,42 @@ static void loongson_pci_msi_quirk(struct pci_dev *dev)
>>   }
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON, DEV_LS7A_PCIE_PORT5, loongson_pci_msi_quirk);
>>   
>> +/*
>> + * Older steppings of the Loongson-3C6000 series incorrectly report the
>> + * supported link speeds on their PCIe bridges (device IDs 0x3c19,
>> + * 0x3c29) as only 2.5 GT/s, despite the upstream bus supporting speeds
>> + * from 2.5 GT/s up to 16 GT/s.
>> + */
>> +static void loongson_pci_bridge_speed_quirk(struct pci_dev *pdev)
>> +{
>> +	u8 old_supported_speeds = pdev->supported_speeds;
>> +
>> +	switch (pdev->bus->max_bus_speed) {
>> +	case PCIE_SPEED_16_0GT:
>> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_16_0GB;
>> +		fallthrough;
>> +	case PCIE_SPEED_8_0GT:
>> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_8_0GB;
>> +		fallthrough;
>> +	case PCIE_SPEED_5_0GT:
>> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_5_0GB;
>> +		fallthrough;
>> +	case PCIE_SPEED_2_5GT:
>> +		pdev->supported_speeds |= PCI_EXP_LNKCAP2_SLS_2_5GB;
>> +		break;
>> +	default:
>> +		pci_warn(pdev, "unexpected max bus speed");
>> +
>> +		return;
>> +	}
>> +
>> +	if (pdev->supported_speeds != old_supported_speeds)
>> +		pci_info(pdev, "fixing up supported link speeds: 0x%x => 0x%x",
>> +			 old_supported_speeds, pdev->supported_speeds);
>> +}
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c19, loongson_pci_bridge_speed_quirk);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_LOONGSON, 0x3c29, loongson_pci_bridge_speed_quirk);
>> +
>>   static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
>>   {
>>   	struct pci_config_window *cfg;
>> -- 
>> 2.53.0
>>


