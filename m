Return-Path: <stable+bounces-223771-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBmWMxjMr2nWcAIAu9opvQ
	(envelope-from <stable+bounces-223771-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:45:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D990246933
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 895C8302BBA6
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971A3EB7FE;
	Tue, 10 Mar 2026 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HcZP8kEG"
X-Original-To: stable@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717F3BA246;
	Tue, 10 Mar 2026 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128583; cv=fail; b=pRqA/tjxFjyVQquU36LJMcpqqzce8yEACAPMQXYlcrkRNbyc+7VQrzak39YWv1fvL+scHpKtWlMjpgrm4Smm+GJCFBl/nxZTYGnhZeOofi/9oGZ8ea3lYH/8+UuCq6GzPETpnYoCcAuYfCCBp08tLSOObgk2U5g6LllVxdI7lrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128583; c=relaxed/simple;
	bh=Nnx46I59pcIhoRnRt6rLoyuulLvEh9FyH7GRYwy74XI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X659fgLlRqDJfg5wsQ7l3lO8HWjKNa6EWAfdsE3dYmTJhxBkYkj+VIgYtmWeIU95zi3LQj5kdy9qeX3CkX2beRsraXiDrvloF5ful3a6nlKIr+BNo5iFODoqDF7ItC2H5sOqekMSPduH/rksWIzJX+3+2UZhRoOx/abNqVbguMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HcZP8kEG; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvTyUo8hdDTngsGbikSB2RLSp8Q3TrSiPV1njWQDWmBXjpWvz8VDjh64d23gNki/T5EsarQt/wpU/QTxz8FNXmrVo7ogrefVeLPRrpIjxz2kiJg6012otK0uJXm0yLoZvpcxIkA4S2H3tRjDGx4wtbE66TwvjFsa+baHPFNworerBmQjGyz1FSvWjafKey9nruf1lbQwaV3itP72h3rrqmjhuRxXVMJA2W+s3xnQtTW0uVi2A2AI0wQGb96z1FVcj5puzkLQsgZYFZV6pPD8jAd8u9xjPh8gbiSb5lXTWuymUx/Ub3A41Jw4SZP1e4ypvPQqvHO1YRvKMss0VrZjaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU5bLAL3JfczTMY4OIm61GF0gkBAKkf2KzUdfRxssac=;
 b=RG3pueDw95N+HTuI2cKU7RvPYqTqW9jaQcm/IDWCAw4Xw+P2Pe1HRLQNJC2aNJyDSt3xTc3yWVB1fF2yzYIZhUXP9JF5EE7ops3K3roVprRmk0ZzCXyvn8FNdQ9EcjBujUIeZvoirb9M4Ib/+7Hs5pQ4HARM/LPKQ4vCmQ8+5P2suESrCDKnmskcRsrZAiBd9NW1er6QnplB9xOUChnc2v2Urmy3D4vr4ykks48WvKYhow8e7Nhj1uWwqcOO995GDI23nEp8Ycu+O83Xs+bMGEEaTNMRikugMVXfHJM3WLtK5IrB56nXwTaskVGsXNE8rqnIkiirCfAVWYuCdW3pQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU5bLAL3JfczTMY4OIm61GF0gkBAKkf2KzUdfRxssac=;
 b=HcZP8kEGlAMbYZx8xJDFT/3XY/U3eaLgPhV3rRnaVk7ZK60S3Aeivdl55SIXgpUmIx3akA5RHzwNt/Ql//YsuIZJcVKR1hVlM1KmqWtlQb5iHygBvqPfDcyuCFJK3+ro5LnKmMVsCSfM3zgb6sLqshLx3nM2ws8qaWAgCO0A8Og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 07:42:54 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 07:42:54 +0000
Message-ID: <1166aeef-0c93-408d-b265-9037f2840074@amd.com>
Date: Tue, 10 Mar 2026 08:42:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
To: Jonathan Cameron <jic23@kernel.org>,
 Christofer Jonason <christofer.jonason@guidelinegeo.com>,
 Salih Erim <salih.erim@amd.com>, "O'Griofa, Conall" <conall.ogriofa@amd.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, victor.jonsson@guidelinegeo.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
 <20260307124118.1d527749@jic23-huawei>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260307124118.1d527749@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0085.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::22) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: f70d7b23-f245-4db3-e441-08de7e78a3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	Wrjicr17DFouPDCgOX007NPFvjbPaUHqtXDRPXR5+EGakoSblOxEBprIo8nF0CGSNOCGUp+UYWQh8RuAq3Me/tjKu1QlDHb0QxmdGzx+AaHeB3pop/nP0P9LuFQTewa33UAiwTiFrQBr8FDhXNwikjMIFQvvKVLSTD//aCyH4yrO9sNV5g6rGu6M4bt5LPDB5jRfK3xnH8wXjG2MK03ZVbYfHcmqgM74rM1glfP422pNlyI/wiKyrpRgVSLuxQMZAxAZcmRI4wxTkhwI4WmxYqxDhtJNQml42qBZtrjnAtpbfTgMj4+1u6t56KET2zERG+TLyKygvbVAmyCZM7oYnxY7GPntBmwGeA3XMMM9Q+AKTKK1juOO94PRSmPOXXZwoknyjc6acqt6VBd8g6yI82MZKzLUIgC7UoV8hA7nAa8xzhbjDeEpdd98gCDZQA3VVhttu772rKOSzyBWIN2Yji3OxP4p7w8f/3K5NxxkIir+7odlInXVJpmaarPDpPhkMJlqecKiNm0/q9EUQoB4DIyBpgn20rDhr+LtkYrFvesyYK0+wSlBqa2Jp3q9HbqeCStoZVj5itSKJMF3j/4VRvYaca8xpndAIbnQd8FObKhXWgTM4k240QXHMh1OFabOXhGkX0QCKX1uC9Uo2VLWQ/uI1XtLLU5wXU5v6AV2kjFiaXhGSz3XFIcpB7tXnj3vHyT4Bl7XdwgrFNLfOCYcD+/w/sMUV9eiJrdEt9Wcv3o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUJlUjM1OXY3MjhNTFZFYUVSOGdVc1g3amNpYnB5ZmVpYUdYYUhYbWNmdjNG?=
 =?utf-8?B?N3ZCby9RM3grWmVzRjRvZ2doQTR3RUF6bEE1RFVpeWN0dFFTV2xDcnljUk5I?=
 =?utf-8?B?MjNTZnpUc2kya0U1VlJqdi9rZlluSWlJY1RsVlVmbmEray9YM2JGYlBJem9n?=
 =?utf-8?B?amZtL2orRVhscVc4VmJnZEE5NG9IQ3NCL1V3bFpjOC9NT0xWcFV2bG1GWnJ0?=
 =?utf-8?B?V2NkcXA5bkRCaU5naUtDYXVwSnZ6cXVMQnM0Y3FnWjM3eWxENm80bUdkaXR0?=
 =?utf-8?B?aStpWVIvZ3RDZmpkODdYN2hFNW1aeWFnSHlNKzkxMnhhdVRwRzJYbE5JR0hs?=
 =?utf-8?B?QUc1WmZEMDM1RWJVN1JGd1prOXpWVFBkQ0tvdzgwZ3NuQmNWTzNzVzRyeEQ0?=
 =?utf-8?B?YmpSNnd2eWxkL0xKa1VuZVlhZzhsWHBDRHBVUTd1QzNmVjlpT2tNSEFBUTQ4?=
 =?utf-8?B?UUdQTUtrL2RjR3ZBN2Zham53WFNjZllQWElpbG1NbjQzZDJLSHlsbW9GL1Q5?=
 =?utf-8?B?QlhjVFViaDBDT0lqVjU5SVlBWDBnQWpWNVNpQkt0UmdOTmw3dEtuczArK3pR?=
 =?utf-8?B?VmhxVERCempWcG9qeWVaZk9BK0N2QXQ4UzlvOWNJeDI4UEFpUHhKYTJMMlM4?=
 =?utf-8?B?eTcveGlhMUJ5dm43cVFtb0xRSVpmTDlLbkRQNWl5VCtwUXhUMSs2Q293TUZj?=
 =?utf-8?B?VVFPZGdqVHNzSm9tYU05OTZTc0hVK1FGVnpEOHVQTXk2dU13ZW1SWFpUYzNv?=
 =?utf-8?B?ZHc4ajQ5am5sbzFwUDFqbGw1L2ZINnFORkRhSzNjZkhTNE1qNnFqYWtpeS8v?=
 =?utf-8?B?RHhpT0JnRmR3THRUZXdueFU4YURJUThwU1hFRi9rKzE2VVJtSnNqMWRObnlZ?=
 =?utf-8?B?MWRGQ1ZlVHNJWUxQa2VqaUR1aHJXUjhtUFRHOHR2a1FKb0NMYVEwelJ6OHlG?=
 =?utf-8?B?dFIwUG50RWNuZkN0NS9sUTUwNHgyRjRvbDg0d3VJdXRUU3JmV1prMzRyaDBJ?=
 =?utf-8?B?ZnozWHJPM3MvVk5XSXJkMFgvd2RvOGVQUWRVSkVpKzFYcnBxbzVMNWx3bzdK?=
 =?utf-8?B?MDVoWG1aQUJuTUdQVHNoZDJKQVFvTVc3Z01MYVh2dk96QlM2TDRoem1uTElk?=
 =?utf-8?B?TXNDSGFlZGV4UXN6VXZ6NlJzTEpOdFoxb0NuTVltbVJLR1g5WG1EejFxbnV0?=
 =?utf-8?B?MHI0MWUrMm8rb3NtZnhhcTZRVHdpRW1FN2VCUjBwTFdrVmU3blR6Q0pEQ0NQ?=
 =?utf-8?B?T0ZmWHMvZXp4YmFoTVJodURwMDRydnZxTFR0MlN0MzBGUjBSZlhNdU80a3JF?=
 =?utf-8?B?d3JtY1JxZ2Zod1M3SnoyNlZUOFI0Q1A4WVJlcmpYamRaQ2FNZGl6c01Hamhi?=
 =?utf-8?B?cjFwQUFzNW00bll6V1djdDJjRW9hR0xyckNUYWo4MU54UTdkN0lxWWd2blov?=
 =?utf-8?B?eEE3ZjE1bVhaRTBsTFl2ZWFSTTZpRjFZeHMvLytOeFRxdjQ1TnR6SU00azVU?=
 =?utf-8?B?bHd6U2piaUpBZHBReGFTZEsyQkZJbTVvR1MvckJHR0hBaDdqRzREU0ZSbUs2?=
 =?utf-8?B?Njc5VEQ4WG04NjU0a1F2QjFyenh4NGZYVXFHdHJqTjhPYVNrR2crTUlDclJ3?=
 =?utf-8?B?ajdRTWs4d0p3Rmk3dnZnak15b3NRRllMM3QrTGNhOEpWUEpod29qbElLaDFi?=
 =?utf-8?B?TllIR2d5dithMmFQcThuVjhXcFNrdXlqckRxa2R2eHJIcEM2anMvUFc2TjBx?=
 =?utf-8?B?dU1BbFdRZ1VIZ1c5d1V2eVNlNmtVTGNQQUMwMWpyR1BxYUVQdHhJRXFiSmUw?=
 =?utf-8?B?UnNMY1lpVjY1Uy9RRXN3Z3dLTzEzclRzc0xCdGtISzZna0pZQnErZEJhZy9O?=
 =?utf-8?B?TGFWM3lXcUpaZjhsRlFadnFNTExxWWRtWGdCNUlPMktJdnZPR1B4TjlFZVhG?=
 =?utf-8?B?ZmlCK09sWTU3dWpOaEFPaGhVTU1mc2VPaS9acUh2cDJUYWZXcWlDWGFXc2pV?=
 =?utf-8?B?QWFHTUhyZjFzL1pmTklTL2pEVit2eFI5a0pwNHNhT1E2dmxFVHc3N1ROaWda?=
 =?utf-8?B?dUlxeFg2akFYVHpSbGZ5aGJGbko3dVJldHUxaW5LcDJDLzN4ZXJzWENpVHFk?=
 =?utf-8?B?dDUrMmgwVGprdDhwMjU3WjI2cVVTdTl3Q0wxdWVma3BTSSt0cmhsOG1JU1Jj?=
 =?utf-8?B?N2F4czQ0d1dkeXhTd1R2Q2pGTDBBOEVnUWJYZ2pDR011SEN0K0ZoYTliNFdn?=
 =?utf-8?B?RU02M0ZXTDdKOHNoeE8yMCtrbUhJTlRYWTgzQmtQNmRQaXZXMm1tKytvMk5Q?=
 =?utf-8?B?eCtlSmhJTFR4SFo1c2g2UDcxSnc0dnJxOVhvTTdVa0hYK21lRGUvZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70d7b23-f245-4db3-e441-08de7e78a3d5
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 07:42:54.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhRP2cSaCqFsgTfZg7rvmFrRAjNP4VFgc8EwJuPAtxOkYU5/wXBh6Hw2DZ5t2i7H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
X-Rspamd-Queue-Id: 3D990246933
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223771-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.simek@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[guidelinegeo.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid]
X-Rspamd-Action: no action

+Salih, Conall,

On 3/7/26 13:41, Jonathan Cameron wrote:
> On Wed,  4 Mar 2026 10:07:27 +0100
> Christofer Jonason <christofer.jonason@guidelinegeo.com> wrote:
> 
>> xadc_postdisable() unconditionally sets the sequencer to continuous
>> mode. For dual external multiplexer configurations this is incorrect:
>> simultaneous sampling mode is required so that ADC-A samples through
>> the mux on VAUX[0-7] while ADC-B simultaneously samples through the
>> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
>> VAUX[8-15] channels return incorrect data.
>>
>> Since postdisable is also called from xadc_probe() to set the initial
>> idle state, the wrong sequencer mode is active from the moment the
>> driver loads.
>>
>> The preenable path already uses xadc_get_seq_mode() which returns
>> SIMULTANEOUS for dual mux. Fix postdisable to do the same.
>>
>> Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christofer Jonason <christofer.jonason@guidelinegeo.com>
> 
> I'll leave this on list for a little longer as I'd really like a confirmation
> of this one from the AMD Xilinx folk.

Salih/Conall: Please look at this patch and provide your comment or tag.

Thanks,
Michal

