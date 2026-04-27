Return-Path: <stable+bounces-241365-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFtvDiOI72mtCQEAu9opvQ
	(envelope-from <stable+bounces-241365-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:00:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD24475D9B
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC34D3073C11
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B6F31AF3B;
	Mon, 27 Apr 2026 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="nsZ2NNDt"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71433FE36;
	Mon, 27 Apr 2026 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304597; cv=fail; b=eTFws2j6RjygBc9Rr9rIxi9oviJprCBn4zG8KuzDnqUXizCK7WI0ptFE4RoU7ViQCOynxsHh36+JocWob2+n40S8ar4Hy+rotqc8p8rzD1JsuapyBHQIu87eMZYyKC+JbqWGYtBUnjVrBd1LL0PornDTzzdRc+hryOk5gZgT1gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304597; c=relaxed/simple;
	bh=WfFOyvrIeScPAinwGhACm8C4S2fS/QvMHxPtF+JBQjc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=S2THWGdDX2s8vrCDyFewIpbgkEBjwFRLOMxrcph4jIPPSFfBZwCL6fYDbynNBcHMGqfFm3OUEOISwjYOwpASVimwI6Hmwhk97PlXI2lZDvpkBVc3bQmq/3qlETMlWbT/TUsIWpYrRRZj11iJtxKc/L0/Xr5T+zyF+z0Rw8X5g7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nsZ2NNDt; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qq5yM5ZTp8ulgxYcFl1fTTZuSWRJvBFA4PQuHqLGQF4F3gLO4ZTUqRHLTzYgxR84xULgUeWrld88zn7N6EZyKqe+/210HR3utZWQB7by0OokA7RDXU42hLd10kWBc2sIlzPmLn+U6afZ0zrV4Z6LcEYMDZdAqWVJtVbnQz24Rr8GuDuQJJRr6uLxm9eYPLfOP5C/fElWJ3DnZxPAhxrOuvIFJ9naFaFQybAbLSkYpn6LYv7LOO08+CGb5ZqNBS5IIMrlpH2VT/A9LulPwTwYMzlHKyrHAX+k5mNNaqkNlmT3OA65lsOYCpbfG9JPYB/6p6EsBWMg+O7BftIGHQV4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7ihmzJ0REVG9nuyFVLknbBHQO/7ZtuRAmaBtDEPXvw=;
 b=BCEHvUxZEXatqZhebSOM1EAf8cXmKRtcq4eRxG1jf7WxcMXjj3gzkNTrAlFL4QBab+kMZ+XrouDUXolc9sml6C4J5tFOUVv4696hysB4nWxmXYlnFg9NxRQeM6DwcZlWPA3jTmJ67Ef4IigV5+kohpVlcbkNLqXtv8ZmjzzKc+Vi5RaX3IbePGTGtppV7QczSNYLh/Uohz1lep0UjgYwDQPeRlHu+0DCSDDgPqkvExprU+dSTf92jlL6Ox5/63s9ekiouB9wy7/RU4OTxBUsfPIwWFa5foqVFZNE6VFNEYS8/Th8L9kqLporJnij5grzL1RRnM/VW5iia65kYPIeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7ihmzJ0REVG9nuyFVLknbBHQO/7ZtuRAmaBtDEPXvw=;
 b=nsZ2NNDtLV/HN55Jn9FjXH0He8vtvxizAb7QiLJlyzYG4BVr3b4+h+TkcF9EFndsYgGvvKJ6yAGCj7bIiG6AjN983IAJ0NQjxyobb9ijCBzzcZBNLOngqRfjL3VdjZh93gTs5T28jkoJTAYIU6OaDIqrJ74BKxtAcD1C7ZH/hWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2114.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:43:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:43:09 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 27 Apr 2026 16:43:01 +0100
Subject: [PATCH v3 2/2] rust: pin-init: fix incorrect accessor reference
 lifetime
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-pin-init-fix-v3-2-496a699674dd@garyguo.net>
References: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
In-Reply-To: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
To: Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777304588; l=10835;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=WfFOyvrIeScPAinwGhACm8C4S2fS/QvMHxPtF+JBQjc=;
 b=0n+wdGANGc8E2j9QlSZKQFc5zItNKIbuMWBbr60VAUXG19RiFestLVOh67DxVM0IckkUANV5J
 DOs5UcyJpwYD/HrxRl5sNQZJM/vhGb2RJfau52jY4yOGSx0qhvZ9AcU
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2114:EE_
X-MS-Office365-Filtering-Correlation-Id: e742cad1-dcd9-46b5-0e54-08dea473aeb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fe0YwkCQGXKAQ1zSkOEdNr9fr77yDM5AlbF3BFlE+/pnsdNLDgzhGOYbQrxf6l3124H6cPda/887Wbjarg0GQV6CuK+BoWQeJ7uYS99okCnj2h7ip1YN+5iOXJT8VKc55Xq9elZyIDtu/nfDTNi2PrcuNC6jfURSpFkO4y9omfBDk8yd8Q15RLg+gnlO1hKdfJ8r8gdsJDrs/VV/0pXLA6p7xzjzgdwrrH0KBSOHcrCpXh1Fqj203+X1KvXTcPyiCOgwE6HsH5pVejeBohDGKRTWbnnysVEPo2HOf19yGvJ3RUdgYBnlbX8/ohDe4aqNKaColLJuLsLmsGhT0vi4kEDrJtQ6O7lMEihDYnzD24PYtaugLASVkuxR+xrEx4o9z9MTCwps0Ftu6FcFaA51HWeyFEtla8O2aaWMQWTt/wAfUWEtbf9deqrTMh0U5EX3K3Gd8uK76JHLrrW+4pmF7IuKNRGNmdtOvGqlsN9L00AMtUcKUnA+KN3Wx/mH8GjqWOy8EiLcVd0yme8tXqC8RXgyoeGm0+zYEpgXGS10HZZzkpWyPGP23evp0BmRSxPTNYC9gZubqGO+sGZptlrLc/0nk5CP7XJZoKAUY59XgwJkBeaLb6HtHaZU8IPO8fqK5p7oYThZ2K3wxBnlOALp4SYtG951GZjHwUbEqrcKDAeBJat9GoyGwyHaV2g52Y2claAZsAe4+JAk/zf220xMEiAKelJ/SH+8ksxWgz7tVNo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmJmRFNsYzlRZ2hib3lrMXBMOG5nTFZvRThvU3NqUVYydDcxWXV0TG5LOWM0?=
 =?utf-8?B?TW82MnptNVM2Z1dkblpNa1ZZeEJ4NWg3QWVxTlJtcXVmV2xlN2p4bUFUWmMw?=
 =?utf-8?B?N3JFMjdoVzVibmp0WWd0b1ZtcFFITjhacUFZbDVBTnRNam9PK3pER2lBK1Vv?=
 =?utf-8?B?REY4dnhZTWxicU5xdGEzVFljeXdQWWxoRnlGMktRaThERXJPbHBSR3pJQ1hy?=
 =?utf-8?B?MERQK241NzczSERpK3RlZlgxc1h0SGpmb3lNbmlUYXJJNEZudnVHTzZVMXQ1?=
 =?utf-8?B?R2wxVnJBdmNKTFgvM1ltNGhLSEwybFNleUdRc0E5RXEzNHFmcnQ3bzlySkNC?=
 =?utf-8?B?d29EaDZwSjBKdmpuR3Y2V3R4bTM3VjVLSGdXS2ZOMENNTEtVTXlISjRLZ3RS?=
 =?utf-8?B?dzlublF0R0ZoeGV3UzVDMUtobnpvWGQvS0VCdE5nN0dXcXJ5clpjcWJscGsz?=
 =?utf-8?B?c0dnR1ZTZGJtVkVvVUNQTTJQQnh1TlFGRnNkUFV2MzNUZ1I4MWxLbnphRUxK?=
 =?utf-8?B?bzMra05NUWMrVTY5Z3J0SU1jbU5QcEdRMUJNK0tRSWJ0WXlxMG9HUUdFNW5l?=
 =?utf-8?B?YTNobUhxVG55Yzh4K2Z4WkgzOGFRWjhUYjlzMW0rV2xSZFNVR2xhSFB3VGpJ?=
 =?utf-8?B?cnUrY2gyYk0rdzFDTXZUaVl1Wmt4N2lVWWRaUjhyN1I0Z3M3Z0l4ZS9pckli?=
 =?utf-8?B?dEUwQndsQ1hLUHhESmorOUpvaURJV2sxWW0xcCsvUHpnVDYwUldTZXErSGNa?=
 =?utf-8?B?RC9mc1J1Vy82a0FXVUQ2d0FVSHJBMjA2aURkdlQ4SFNrN2RBSE5YelRQRURY?=
 =?utf-8?B?SGo4RXQ0bUdudWRadFpLZ3liandNaGhsR3ZwOE5LWTMxdFdlVThza2hMSEox?=
 =?utf-8?B?aU13enRLSm9JUmxHWGpzMlp3SEF2Nmd6SlI4WXV3ZVdWSWs1bklnTHRvcTJ1?=
 =?utf-8?B?QzFUZk1VT1pqaXJrSFQyci9WZjJDWnI5OHpvR2tzOGtwNU94Q0U5OTg4NEhF?=
 =?utf-8?B?MUUreUlzWmg4WnkzWkc3QUVNL2lLdDRPVVprbFRNNEJyaHN0UVluMEVyellS?=
 =?utf-8?B?VG5zSS9NYldRYi9NMTNDQWc2N0xBSytOcGhROHYyWUxqQlV3VDRRQ2luNmJD?=
 =?utf-8?B?MEIzOUJZM0JJazRyV1l0RE9EVENHUVIxaCtDK1NYYTVyOW9lRlZpSDRhQllB?=
 =?utf-8?B?QldWck55T1pZaE9zLzI0VGNkWGdmemhrc05ZdUF0YjVBTzY4MHdxZXpUR2o0?=
 =?utf-8?B?SnRkbWRWTDZiMlFvU2J2amRYTVErNU5tMHJkbkgzZzQrZTdqdTlxbGtuR1o3?=
 =?utf-8?B?eXM0ZkN3WjJOMC9zdmdSWnlidnNhSitqMUhJTFJXTzBEWG1oSmxkVlFNa0x5?=
 =?utf-8?B?VkpzQ0ViSkRtQWgrYXJrNmNIRElNd0dKWTV1NVJjc1pTSGNwTVdvVFRaYkdt?=
 =?utf-8?B?SXNNRVV4ZkxlMmdUTG9ZMzVDRzN5TjE3WC9NbzNtZVFXV3FjbGJxMXlqb0NE?=
 =?utf-8?B?bEdDN0svV256TFdoZ0daVUZZWDdTbzlFbUZ2SmUrRlMxT1NvSlhobEhsd3dS?=
 =?utf-8?B?S2tJU1h6RDhmVUpzMTlTRHBMSk45ell0dU8wTzhaNlBYNUNDUndKSENQRm9W?=
 =?utf-8?B?Nkl2cHd3K0ErQnNVR1lSL2ZIdEhvL09OY2NGdXZDVFE5SHh6RXZVbmk5SnRQ?=
 =?utf-8?B?dVYvRHlzTHE4OUVWdm1NMWo0RWVOZG5GaXU2am9zQzhuMUxUcE9jT0JZZTVh?=
 =?utf-8?B?aWd1aGlKQXVpaENxV0dDb2t2dENaRCtadURhRVFrT1pUQUR1djRYRGUzVGIv?=
 =?utf-8?B?ZWRKQzRhZDJhaGhUS2F6VDNxR0QrMGFaWlM2TytGaDBpUHJ3T1MyaGNmMTlY?=
 =?utf-8?B?ZC84NzMzQU5DZzdKdEdwY2hHZ2JLM1pHd1BPLzZYdjVsZUx6ZGNvZk84UUVZ?=
 =?utf-8?B?cEEybkFkbmoxT2p4b1BhVXBDOWtQT0crRlFoY3RPNlRnbWYvd0w0anhjUEtK?=
 =?utf-8?B?cWRpRnIrZVdONmtUV0Y2L0hROWliZHpOeWt3KzFaNS8xSlpqYUdKMHpwc0x0?=
 =?utf-8?B?OGpCeGMwSnphQ3dFbHF4VDNYZjFVU2lkbHpmMk1pcURMN3lXZE94YWNoUlQ1?=
 =?utf-8?B?cGUyVlNKQmhDTmxYUFMvT1g1NDhCQ0U0cGZXTHhJc1hVejh2SUdpbzEyMHRT?=
 =?utf-8?B?SGh4MGxxUmdIRmttOXg1UkM0a3daVDZ1WENhRHIwc29udktsZ2U0ZGdZc3dh?=
 =?utf-8?B?OEZ5TUF4L2dnNFZSa2YwcUpSbzN6ZU52R0QwR2lKNERlRzBsbVNWN0QzL2Uz?=
 =?utf-8?B?SXZSaXRNN2FIN2RubUdKQ25LS3JDT1NIdFJPU3NtOWxhTHA1bDJoQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e742cad1-dcd9-46b5-0e54-08dea473aeb9
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:43:09.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiwpQ0w9+C5nEizdJZtKhEVEb/OweoWg/aHDf/GBYxign3HAa0ujL5Z1GlQ6+aK/TapQCrxfoRm3c8pgu+bgLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2114
X-Rspamd-Queue-Id: ADD24475D9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-241365-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

When a field has been initialized, `init!`/`pin_init!` create a reference
or pinned reference to the field so it can be accessed later during the
initialization of other fields. However, the reference it created is
incorrectly `&'static` rather than just the scope of the initializer.

This means that you can do

    init!(Foo {
        a: 1,
        _: {
            let b: &'static u32 = a;
        }
    })

which is unsound.

This is caused by `&mut (*#slot).#ident`, which actually allows arbitrary
lifetime, so this is effectively `'static`. Somewhat ironically, the safety
justification of creating the accessor is.. "SAFETY: TODO".

Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime.
This results exactly what we want for these accessors. The safety and
invariant comments of `DropGuard` have been reworked; instead of reasoning
about what caller can do with the guard, express it in a way that the
ownership is transferred to the guard and `forget` takes it back, so the
unsafe operations within the `DropGuard` can be more easily justified.

Fixes: 42415d163e5d ("rust: pin-init: add references to previously initialized fields")
Cc: stable@vger.kernel.org
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/pin-init/internal/src/init.rs | 106 ++++++++++++++++---------------------
 rust/pin-init/src/__internal.rs    |  28 ++++++----
 2 files changed, 66 insertions(+), 68 deletions(-)

diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/src/init.rs
index 0a6600e8156c..487ee0013faf 100644
--- a/rust/pin-init/internal/src/init.rs
+++ b/rust/pin-init/internal/src/init.rs
@@ -249,18 +249,6 @@ fn init_fields(
                 });
                 // Again span for better diagnostics
                 let write = quote_spanned!(ident.span()=> ::core::ptr::write);
-                let accessor = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                    }
-                } else {
-                    quote! {
-                        // SAFETY: TODO
-                        unsafe { &mut (*#slot).#ident }
-                    }
-                };
                 quote! {
                     #(#attrs)*
                     {
@@ -268,51 +256,31 @@ fn init_fields(
                         // SAFETY: TODO
                         unsafe { #write(&raw mut (*#slot).#ident, #value_ident) };
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Init { ident, value, .. } => {
                 // Again span for better diagnostics
                 let init = format_ident!("init", span = value.span());
-                // NOTE: the field accessor ensures that the initialized field is properly aligned.
-                // Unaligned fields will cause the compiler to emit E0793. We do not support
-                // unaligned fields since `Init::__init` requires an aligned pointer; the call to
-                // `ptr::write` below has the same requirement.
-                let (value_init, accessor) = if pinned {
-                    let project_ident = format_ident!("__project_{ident}");
-                    (
-                        quote! {
-                            // SAFETY:
-                            // - `slot` is valid, because we are inside of an initializer closure, we
-                            //   return when an error/panic occurs.
-                            // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
-                            //   for `#ident`.
-                            unsafe { #data.#ident(&raw mut (*#slot).#ident, #init)? };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { #data.#project_ident(&mut (*#slot).#ident) }
-                        },
-                    )
+                let value_init = if pinned {
+                    quote! {
+                        // SAFETY:
+                        // - `slot` is valid, because we are inside of an initializer closure, we
+                        //   return when an error/panic occurs.
+                        // - We also use `#data` to require the correct trait (`Init` or `PinInit`)
+                        //   for `#ident`.
+                        unsafe { #data.#ident(&raw mut (*#slot).#ident, #init)? };
+                    }
                 } else {
-                    (
-                        quote! {
-                            // SAFETY: `slot` is valid, because we are inside of an initializer
-                            // closure, we return when an error/panic occurs.
-                            unsafe {
-                                ::pin_init::Init::__init(
-                                    #init,
-                                    &raw mut (*#slot).#ident,
-                                )?
-                            };
-                        },
-                        quote! {
-                            // SAFETY: TODO
-                            unsafe { &mut (*#slot).#ident }
-                        },
-                    )
+                    quote! {
+                        // SAFETY: `slot` is valid, because we are inside of an initializer
+                        // closure, we return when an error/panic occurs.
+                        unsafe {
+                            ::pin_init::Init::__init(
+                                #init,
+                                &raw mut (*#slot).#ident,
+                            )?
+                        };
+                    }
                 };
                 quote! {
                     #(#attrs)*
@@ -320,9 +288,6 @@ fn init_fields(
                         let #init = #value;
                         #value_init
                     }
-                    #(#cfgs)*
-                    #[allow(unused_variables)]
-                    let #ident = #accessor;
                 }
             }
             InitializerKind::Code { block: value, .. } => quote! {
@@ -335,18 +300,41 @@ fn init_fields(
         if let Some(ident) = kind.ident() {
             // `mixed_site` ensures that the guard is not accessible to the user-controlled code.
             let guard = format_ident!("__{ident}_guard", span = Span::mixed_site());
+
+            // NOTE: The reference is derived from the guard so that it only lives as long as the
+            // guard does and cannot escape the scope. If it's created via `&mut (*#slot).#ident`
+            // like the unaligned field guard, it will become effectively `'static`.
+            let accessor = if pinned {
+                let project_ident = format_ident!("__project_{ident}");
+                quote! {
+                    // SAFETY: the initialization is pinned.
+                    unsafe { #data.#project_ident(#guard.let_binding()) }
+                }
+            } else {
+                quote! {
+                    #guard.let_binding()
+                }
+            };
+
             res.extend(quote! {
                 #(#cfgs)*
-                // Create the drop guard:
+                // Create the drop guard.
                 //
-                // We rely on macro hygiene to make it impossible for users to access this local
-                // variable.
-                // SAFETY: We forget the guard later when initialization has succeeded.
-                let #guard = unsafe {
+                // SAFETY:
+                // - `&raw mut (*slot).#ident` is valid.
+                // - `make_field_check` checks that `&raw mut (*slot).#ident` is properly aligned.
+                // - `(*slot).#ident` has been initialized above.
+                // - We only need the ownership to the pointee back when initialization has
+                //   succeeded, where we `forget` the guard.
+                let mut #guard = unsafe {
                     ::pin_init::__internal::DropGuard::new(
                         &raw mut (*slot).#ident
                     )
                 };
+
+                #(#cfgs)*
+                #[allow(unused_variables)]
+                let #ident = #accessor;
             });
             guards.push(guard);
             guard_attrs.push(cfgs);
diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
index 90adbdc1893b..5720a621aed7 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -238,32 +238,42 @@ struct Foo {
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotten to prevent the drop.
+///
+/// # Invariants
+///
+/// - `ptr` is valid and properly aligned.
+/// - `*ptr` is initialized and owned by this guard.
 pub struct DropGuard<T: ?Sized> {
     ptr: *mut T,
 }
 
 impl<T: ?Sized> DropGuard<T> {
-    /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `ptr` when it gets dropped.
+    /// Creates a drop guard and transfer the ownership of the pointer content.
     ///
-    /// # Safety
+    /// The ownership is only relinguished if the guard is forgotten via [`core::mem::forget`].
     ///
-    /// `ptr` must be a valid pointer.
+    /// # Safety
     ///
-    /// It is the callers responsibility that `self` will only get dropped if the pointee of `ptr`:
-    /// - has not been dropped,
-    /// - is not accessible by any other means,
-    /// - will not be dropped by any other means.
+    /// - `ptr` is valid and properly aligned.
+    /// - `*ptr` is initialized, and the ownership is transferred to this guard.
     #[inline]
     pub unsafe fn new(ptr: *mut T) -> Self {
+        // INVARIANT: By safety requirement.
         Self { ptr }
     }
+
+    /// Create a let binding for accessor use.
+    #[inline]
+    pub fn let_binding(&mut self) -> &mut T {
+        // SAFETY: Per type invariant.
+        unsafe { &mut *self.ptr }
+    }
 }
 
 impl<T: ?Sized> Drop for DropGuard<T> {
     #[inline]
     fn drop(&mut self) {
-        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
-        // ensuring that this operation is safe.
+        // SAFETY: `self.ptr` is valid, properly aligned and `*self.ptr` is owned by this guard.
         unsafe { ptr::drop_in_place(self.ptr) }
     }
 }

-- 
2.51.2


