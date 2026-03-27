Return-Path: <stable+bounces-230562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJjZLWHYxWnQCAUAu9opvQ
	(envelope-from <stable+bounces-230562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:07:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B6633DB99
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 180203040315
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229C82737F2;
	Fri, 27 Mar 2026 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uMHsUoKm"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977E23E350
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573660; cv=fail; b=IbhH+QaK2COfcD2ZcHkPWG1efuhD2sJPz9D81apJC4yGP8sZ4zQYqQeNqArzdtCWLDM2KE+3920fLxnqd3h2KHESJM5VB8aB0Xi/2lbxI+N7dHFJVgsUL0rv2Zl9x4vDZoB1H3GINPix1JmlsSq5FA1ya3vTWZD4jr+whP7Khno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573660; c=relaxed/simple;
	bh=T4DqvCfaiLtvjbITIOoLie91IQgGObc2vShC3nNjZAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YNR/59asTm6ZhxsUIf0YUYL9LJdxHd/xeLYCvHqqEfEWOpvpMiDpvE3oXVWXmtQGmvYOnmfj2DGZbPdNtcDxvQtKtteiU4k+gZLwTxL7LYXoKttQGvxOao7v6AhvgM7WwKhm3rVkpk/t2OxXoLZ+NC1i7GOY4MW1Z8x9uwPnR44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uMHsUoKm; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByzaK9GaDc2fmfRXFzTue5A30OCsrdFcsKTeQ1b1nmbiUN7NIjMJcwaYSb3904XW22kuQ25zT2AfpsBtLQ/U4upGAyNhhHnfizg5wTBesxaeU/HRXTX7kSsWyKfb8Yl6+jmQeaf1m4GcSXI5+vUsoTm1+8xA91s7nvMfgvZP4GQQ9gNgaLL2NWS6B/DxGomuNDQIMFdfOFS02U7MS/IRmfryiwt0i49DCUEmNkJjkED8rP6W+f3esVKKapeYIEqa+MwTs+uc6XSDVHl9b4fCo0R16NmtA1b57Nusq7o8f0NQ9p72DbO0CbZNLwdcsCehB+RFlO05MxVWiBKZlgbRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZvp6d13bq0QcbFaWIdW3Gp4BU04bbJURR5xAJyysYA=;
 b=tZM7aVQEQPtJHGSRxR63CGOfWa7yUeO5TSDq63aQOL5xsbcO6Crh2Bpw7O6dWuktL6oF3mWJwfn9RoyjHQbnBoDTrPbxLwC3eFCah4ZgK/VAPE7uhaB+ZAgVqHVmMYo5V715d2V3/SMruEXix//hR3LluavQXHA7/6YtHAMuHHzmO9tVCBO9Wo86V7QcYH3N4LDjXYRzc9fFZZ/gHCij6UOQ2eZqRJNipCOJbUs1O1ucZnVoyEWjNGmS6nLXkzcG6x38XxBuIAwhGFx1/jNflC5uYsLGemIBF7S3RThZF0cVYLHmTnqzB4WZomqeA9x3o2oK3T4C501aVBrYP5KpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZvp6d13bq0QcbFaWIdW3Gp4BU04bbJURR5xAJyysYA=;
 b=uMHsUoKmpWp+rqBUbexVSPD9HlO9zMLpn0BZ6Aw35bA3hPmVR9B/5yZH85SGz5xapruVhMdeafiGOQ9m+y8ZWT1N4Skb5VVwvcx1XBDylG5OSACxiXnxhmQqCyEivd98brQH10cJ7jLA4DjRzQlj9bvUJosbWccZ5dR752c62xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH8PR12MB7423.namprd12.prod.outlook.com (2603:10b6:510:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 01:07:36 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 01:07:36 +0000
Message-ID: <b1232b09-0485-4a2d-9ac3-63aafa3d3d24@amd.com>
Date: Thu, 26 Mar 2026 19:07:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 dcn401_init_hw()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 Daniel Sa <Daniel.Sa@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260321115514.2008607-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260321115514.2008607-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH8PR12MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: aa582c49-20e9-4edf-2319-08de8b9d3b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	h1YzZk1lZonWMk4sZcsZa3gTR6qeF367AmndFrp0g3g8Y3900Nerr1H4PAkidPYEWslFNaLibnnU39O2viVPhPp/24KmgTaI5dnGzt8zNMqBKCDzyjPRN+MGDg7Lm1+61NP5paxGKU5SIPWoi6wOhwjqjFf9JGmI6ar4fcf3ToUlPLiJEZgv+huWGIO0uGUoB48XMdAq+ImeUycVKEAL1CFZwyPPYWwgsF4TR39pxtkU/4/NRrV6SA8t5E23UC4EecVD8cEjBF7uPBX+XXuC632tjY+hbDWSdWRdKnLHgun4QVcprOPFb2qRZQTWDkoHIlUcKtN3Z7FYMS3qQd7Rjgb7oTe7EpyJ5FbAXJMWssHN3eBIp90n1w0Pq/Ghzwpx2mCnQOXendRgkzT/JX8fuxNcBgGpeRAqoZ5EDg224NA4SWF4yI2MYDvqIHD2fBeBOqH+mZU80Wb1kz4EtknidIbqO+1jqZY/AcWn08nWf1Qg5X/bdWot1pc+ralgoSZOF/9oWla+N4W1sjfmGdO+KObuVtjFuNa6doRhMYmF3d5xsJi93JiSkp0yaKpEp8NKv9lnShXEbWMAihznamavSc18BN0kQglcIWy8mbyUDH8Of4BSSrcAuvPiEsXeE/EmQECeA8A0t1Q+/W6sD0AjFCfWE1TJh3QpTH34wW/85dDr8qVC/jl8Abb+KwT/xyJi12DdgmRwDsJ2NjhbVmLEm2biIftS66c4GC7i5ThVQ/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGw4YWdNSEYxY3BSMXI3NGNpaHl5cEZTcnMrbGc4dURNdXBCZFBwWHY3Tllk?=
 =?utf-8?B?blRDNnNHTVRrRlJrZ0hQU25qRTNjKzcwcWFHWE1GaElGemZ6R05iT1ZjVkwx?=
 =?utf-8?B?aXlDSm9kK1VDcFJWR3RxVlF5YXBuNEZHZ3R4Q0MxMEhSOWdiS2ZtL2tTRjh5?=
 =?utf-8?B?REdoZjFadzZ0WnRMQUczNmdpT1BYMEd6NnorN2QwMzZsVUpEWTA5UkFLNjJn?=
 =?utf-8?B?UWRZZzBzUFZtbVd3VndDWTBpTGNkVmVIeWxPWG5sQ29tUExoNDNLNkJPNFdp?=
 =?utf-8?B?MTZsT0xndFYwaWFlcFhtSElSdDkzcDBFVmdGeC9BdllyNjMxSHdxSmVGTFlo?=
 =?utf-8?B?Q1N6TUZlMVVYRVlWc1ozUjZqNEZvbkUydjFqcG40U2Q5RU43SkVUaVFwa2Z0?=
 =?utf-8?B?ZWs4c1VCNkVtdURpTVR4djlYMTR4ZTNXT3U1clR2QnBPb3NTaFRYMWxwMTgx?=
 =?utf-8?B?T1NPc2k2cXNnZ3p3eUd3a0hObnY5ZlNIUysrSVRlTlFvQUxvNDEyREhOdTUw?=
 =?utf-8?B?QVNESm1kMlU2UlJ4VzdrMURYTFhRSW9UOUN1RUJKZHBjQ1ZuNU1OdWJ5TmFD?=
 =?utf-8?B?dUVFMTJVRGFzMFo3czhLcyt5ZlMyMit1TkRsbTJ0Qm9jVDFPcTczaUpGaFVD?=
 =?utf-8?B?TEc4WDExM1hiUngrNWxoaUdVbUxxZ2hQSVlEb3JFUUhiV241aUpRL3BHVmNj?=
 =?utf-8?B?dVhRMXg1UVFBcUNvMG9VN1I0d0JkcHJ0azhoVlBIUGdQaXNSMkVBQTZiZ05k?=
 =?utf-8?B?dS9DMGV0THUyKzJTaFZ2MzFXV3FqQVlKbm9pYVpmK285ZUYvYmtnV1ZCelh0?=
 =?utf-8?B?aldnc0tKY0VPMzZLWmxhSG1yV2FJUG9kRkVIeHU0OGswejlvQjRZM1NpMjFH?=
 =?utf-8?B?RVdSNTBVdGJvZG90UjdKM0hiOTFmRXdlaFZpRW5aTmpsZGxpa2VkRnNxTXps?=
 =?utf-8?B?K2p5anIveTdqTTd3dU5CdXlMYUJoSlBJSk1GUXBuSEdKTWgrYyt5ZFdQVUEy?=
 =?utf-8?B?VGFuYzFCQUdpNDB4ZlBhY08zeW9tMkVQZHRURHdkWTVmeGFKbTdGaHZvdVRx?=
 =?utf-8?B?Y3NZbTFOWmFacnVzeHlnSkJydFlZOGpudDlwTllzOVV4ekhSK3F3NHRqYVYw?=
 =?utf-8?B?eXZ1SXM0blI2YkNabjE3RmpZQkg1MUJrRWVhNEgyaGJqRlRWVGVjUnhIVmcw?=
 =?utf-8?B?ajVyTEd1M0xNb0xwSE5XVHgxTTg2MFBNb0ZKdEtXeUE4QUE5RFVEMWRSMi9o?=
 =?utf-8?B?dS9iQU9icmhDM294RElxRHI0Ui9COG5zMWtpa3VCTVIxUUdRMHRZZjJjRkEw?=
 =?utf-8?B?ODJMMFdMbUhUOGZRZ0toRFlXOHVYMHpMK0hNaGdkcEZxMFRzdUlvWm9QdXFs?=
 =?utf-8?B?clgwTTNJYWhHeDBQOTBid3Q0NEJOZXF1aWlQNTg1NnpwMEtzZmxLMUtGQVpj?=
 =?utf-8?B?cGxTZUFDem01OUNyUHVUMnNxUmZWNnJGUCtGWHRpQ3VOWWtVQVpyS01xNlF0?=
 =?utf-8?B?SjFGRjZiUHNGb2VNNktybER1ZjR2SWFJV1hYTEFNUFhKS0NxcDNkUWwyZFoz?=
 =?utf-8?B?dGF6VEJvdDRLM2pNVWZkYjVYamNZVU9KZDJ6cm5JRlN3TUp5TTlKWDd2QWQw?=
 =?utf-8?B?L1JkQS9idkR4Z3JTU21CK05sc3Jnb3ZUWHBPdHFMVWxEQkhSM1A3Lzc3ZHRx?=
 =?utf-8?B?UkNmanZOOVJVS2dHTGpNSEUzNE53cVl4Z1dPVnVvY2YrQ2tneXhYamdVK1I2?=
 =?utf-8?B?dHhIU3ZCTFdpK1FLWmxPRnM1TTFrUXRPOXovWG9xSHA1VDRzOFoyVXJobUdo?=
 =?utf-8?B?aDRjdDdUTkkyaUxGS0xIbHBqSEJiRGR4L2FlVDQ1eHN3dGRrRnN4aElPZmFp?=
 =?utf-8?B?L2xnQzM0VlVNSGtrdE5Gb0JiZjZ0UHhxNnUwQXdjZDNPUG1QMm9YRkx1dUUr?=
 =?utf-8?B?OFVxa1dBbklhQ2JINjV4Z2llM2E2ZEhsR2pqN3pmODY4ZHg0Z1ZZNW8xMExF?=
 =?utf-8?B?TFI5a3RkTEZJOG5ycHJ2ei9wYlMxNU9pbVh2Rjc2VzIyYks1cUpSSWhUdkl4?=
 =?utf-8?B?QnFqdGpMRGZsTnlSY1ZPTjV3TllFWisvUFdkenVVcGgrU1V2TmVsRFdzM0pu?=
 =?utf-8?B?bFB6Z01mSDlrbHo2NDQ4R0V0dVovekx6TlpnYjQraFNaSStZcjdJM2p6SGc3?=
 =?utf-8?B?RlhDRWVvdHBWb0IrQnc1SzlmYWpWc2xXZ01lT2c3R3Rrdkhza3FKVkZrWEpL?=
 =?utf-8?B?YXZraGNxRFJRZVg5c28ramVFUHVYYVE4QklnT1dmTzJISUJGbEJVeXllT0Yx?=
 =?utf-8?B?OUxsVWMxNTRKQWpGQXhJaWJ5V3ZSUld5bzI2L2dMYmxhR3dlSjMxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa582c49-20e9-4edf-2319-08de8b9d3b91
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 01:07:36.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHRG1Z6AKqeR8uMqeIFATAP9HrOO0c9AIkTwhChJEyUu5H++lDncGkYCgAQpJ6gOCCOH9VFp1aRlSaFh3MCW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7423
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230562-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.hung@amd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid,linaro.org:email]
X-Rspamd-Queue-Id: 26B6633DB99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/21/26 05:55, Srinivasan Shanmugam wrote:
> dcn401_init_hw() assumes that update_bw_bounding_box() is valid when
> entering the update path. However, the existing condition:
> 
>    ((!fams2_enable && update_bw_bounding_box) || freq_changed)
> 
> does not guarantee this, as the freq_changed branch can evaluate to true
> independently of the callback pointer.
> 
> This can result in calling update_bw_bounding_box() when it is NULL.
> 
> Fix this by separating the update condition from the pointer checks and
> ensuring the callback, dc->clk_mgr, and bw_params are validated before
> use.
> 
> Fixes the below:
> ../dc/hwss/dcn401/dcn401_hwseq.c:367 dcn401_init_hw() error: we previously assumed 'dc->res_pool->funcs->update_bw_bounding_box' could be null (see line 362)
> 
> Fixes: ca0fb243c3bb ("drm/amd/display: Underflow Seen on DCN401 eGPU")
> Cc: stable@vger.kernel.org
> Cc: Daniel Sa <Daniel.Sa@amd.com>
> Cc: Alvin Lee <alvin.lee2@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c   | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> index a72284c3fa1c..53d70db372a9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
> @@ -143,6 +143,7 @@ void dcn401_init_hw(struct dc *dc)
>   	int edp_num;
>   	uint32_t backlight = MAX_BACKLIGHT_LEVEL;
>   	uint32_t user_level = MAX_BACKLIGHT_LEVEL;
> +	bool dchub_ref_freq_changed;
>   	int current_dchub_ref_freq = 0;
>   
>   	if (dc->clk_mgr && dc->clk_mgr->funcs && dc->clk_mgr->funcs->init_clocks) {
> @@ -357,14 +358,18 @@ void dcn401_init_hw(struct dc *dc)
>   		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
>   		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver > 0;
>   		dc->caps.dmub_caps.fams_ver = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver;
> +
> +		/* sw and fw FAMS versions must match for support */
>   		dc->debug.fams2_config.bits.enable &=
> -				dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver; // sw & fw fams versions must match for support
> -		if ((!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box)
> -			|| res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq) {
> +			dc->caps.dmub_caps.fams_ver == dc->debug.fams_version.ver;
> +		dchub_ref_freq_changed =
> +			res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000 != current_dchub_ref_freq;
> +		if ((!dc->debug.fams2_config.bits.enable || dchub_ref_freq_changed) &&
> +		    dc->res_pool->funcs->update_bw_bounding_box &&
> +		    dc->clk_mgr && dc->clk_mgr->bw_params) {
>   			/* update bounding box if FAMS2 disabled, or if dchub clk has changed */
> -			if (dc->clk_mgr)
> -				dc->res_pool->funcs->update_bw_bounding_box(dc,
> -									    dc->clk_mgr->bw_params);
> +			dc->res_pool->funcs->update_bw_bounding_box(dc,
> +								    dc->clk_mgr->bw_params);
>   		}
>   	}
>   }


