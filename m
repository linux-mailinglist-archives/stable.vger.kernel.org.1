Return-Path: <stable+bounces-100302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0679EA986
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 08:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8EE1661B4
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 07:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E122CBFB;
	Tue, 10 Dec 2024 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kDUJEZwK"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F901FCCE6;
	Tue, 10 Dec 2024 07:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733815624; cv=fail; b=Kwv9DqVD/eZn9MfEKwb/Y7q6pMavqex+YVgnhUWV31kMr3/xiGYfLNSezujWP760Q7r0dB00Oe6jTRNJm7RBGoNqmT5CDt+tSCLFM6cBLNM+z6I/w898NWZZUZPdwDE5edqLDb/51EqgtPhiZO0QTWf93k9vJPcIaAfxVhwN9F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733815624; c=relaxed/simple;
	bh=yei8gEphDgKRuQ8SygjHtPfV70HusyePHCjE0aSKeRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pcRIs50k12CA90yKtTRY3QuH3LnuPlep0uXULvZxRW3O5mj7g5bzG0xzea+/5lk5R4/Ad+MpkyXnBQmNpI4+yLEBBlhqkm19zShPsQDUATeGaJSAutV7Wxg72OD4Q+P5pWdo7io5TsNr1XKDcR+ogb8nTFwBNCfHJBVXVIzzX44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=kDUJEZwK; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KK6QU8CTxMWwHjZBKIUbVETMVqpK5poawbRvJjRRzjCeY8gncbWe9iJhY7hA9phRJK53pJL/+szZykpnh/xVKZkS+09k98Xtt9ZiIZIlfpTZmFz0H8lrIke28B4qqkHR49pJ6c9hfPvkSx1bl1NXXgrzai1uPDv1NDoKEugAnANaQCfOFq57kizxkaujz2S3oo9r3nG6TY9EUJwFqm1Qm0M7BN1KwK95DTD5Wb3mg8fWDlD8UCSHT0IoY7MNVb0/LYV/8A22JTg303gKOR53xwHohlJs6w1OcD742eCjn0+5hZpvYLU8sh6oxTlT5of981NP3BAIDuy6TvBInyUYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PhnX+QO8XmXSI2rOpxd3yp2yJX+lpW1qoYoPJhpsDE=;
 b=R50zvDMsf4gMvZ4LKNPm6Lhv51to8avaixDw1o1iAHoh9Yd2cDBiXSDDsy58/0OLWnbCTqnyZyFCc5XuiQQdUxmAM4LVurx7CsTEzcosnYTxYX7JqF0atGEHVBG+dNv0VdF6PdqqEQrXRMI/yUmFV1dIpIXwkG6dRzuVzY4wjwGolXhT7kHCtaYI3uEG90IyBcoc+VrFPx2xKnIA7V9XmIU59xm7/diqXL7rePDnstUMaP3dLCiHxr+NNgslh5SsBP86a04fsWchUs5UpC5cuObM16OqtaYUJmz2OfVziDCRPC/AIJIAGKeG5zwQFWb5YqARYluZe2jHjiuiyeyIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PhnX+QO8XmXSI2rOpxd3yp2yJX+lpW1qoYoPJhpsDE=;
 b=kDUJEZwKSyDhKqECknyrzEt5w7eMTeeckfaGaFbMrjgkLcacz0rqyzrTc6L/n2YfFa2esD0xX47ujUe/PJ9hwA3CDOCDHUweGTlVGAXJVN3cZHDumfH4c6H0yR8P92A7o31OKwvBc5aIRNVYf3+NfV+tuFQsLmjpmqyHHUIAChH8gU1SXSvi9C2ohsmghdGgsUDbA6i544Wh/Kn9MhekNK5v1itZADX6FX8lDIRynCRlYNl7N/JR4Azdgg479RWQCQUHrlteKvr77T9JeTnLW0PXTakgOYjpfcikjtak6e7qLGzhHRurYU9j9YuUQtsBpv2+8aOFPxMHASx5tcLYIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7684.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:630::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 07:26:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Tue, 10 Dec 2024
 07:26:59 +0000
Message-ID: <9bd2596b-00f2-4c46-ba1e-f35f2d1eb584@siemens.com>
Date: Tue, 10 Dec 2024 08:26:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 4.19.325
To: Pavel Machek <pavel@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, uli@fpond.eu,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
 jslaby@suse.cz, Christoph Steiger <christoph.steiger@siemens.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <2024120520-mashing-facing-6776@gregkh>
 <Z1bX3HioMftPtien@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <Z1bX3HioMftPtien@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0018.eurprd03.prod.outlook.com
 (2603:10a6:205:2::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 63418576-f315-4f2f-e402-08dd18ec08c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDR0Q1NtYm16YXV1SGoyak82MWdBUVNYM2JKNkJwb0hEQmZUblovMlVXMThZ?=
 =?utf-8?B?Nnk0SEh3SnFxVEZwNjQ5cXg2NncyVitQaXU1dGdoRFpzUGtXaDVHNlVhV3BC?=
 =?utf-8?B?enpxRUV3cmFqZmM0SmFuRXRHZG1oc200MTNuMnZvTTZDQTNxbEFINnBIWUhT?=
 =?utf-8?B?bmttc3ZWQ045U2ZDekU3cjQvR1VDbnVmRjMrOWZ5NkVTelpxY2xZZlJvdk9Q?=
 =?utf-8?B?SU1DVUdmZmZkQ1JEczJROXV1ZFNWN3lIeFdIY0NwTTVLK1A0Y09lZmV1eFg1?=
 =?utf-8?B?MytGcDRENFZVRFFoNUoxS2E1YkJlUGhKdFhqTUJSMis3RDdtLzNqVWZpS0Zz?=
 =?utf-8?B?VFhxbkl5Qkt4Sm1haG1jc0prUW9KU1BqT1NEMlJMaWxzM0ptUng2L3NaRXlh?=
 =?utf-8?B?RDVIQ1M1aEJiQWQxUC9rRjBSVDhUU0NYOVVpUHZ0N3hBRVdQQnFxQVZHbWpH?=
 =?utf-8?B?YzdXViswRy9qQU1aQ2RTLzBNdzAyV05iUjQ3Z2FjLysxcjdGekRIa1c3S1Zr?=
 =?utf-8?B?T0sxV05ydEFQM05Eb0ZqQWhPdllMblNERGdxelRaNC92ajR6QklmV2FvSXBW?=
 =?utf-8?B?NE9sYjdtSGx5aTZNSzZCMjRYR1lFd1JXU0puUXVwWEtsdFVDbG1hN2hLQWlZ?=
 =?utf-8?B?ZURBN1hGZUJSSUNPc0dCWU5KVHZsaFJONFVYdm9RSlVGVGd6TEFSMlhyRlJy?=
 =?utf-8?B?dWg4ZWlLekpyMmVLMG1ybDlBK2o2eGVuUXJhMjYzcHNReTdyL1B3cnhCWS9B?=
 =?utf-8?B?U0dOM0l5VmlYSlBjT1RWYjY3aENhaFErMlRnSTZuZnJWWENodDdKT3VaR1kx?=
 =?utf-8?B?L09WRDFqMUhGZm83TTFJT01IM21kUjhYWWxpMFF4T3cxeEI1MXRYUlMyeEVs?=
 =?utf-8?B?elBMS09XUmtvQmZMMDRhNU1qMzZIZzlqblVyMGdqcUJSa2tPNC85bnhUMGJI?=
 =?utf-8?B?VGw1RHNBbG5QVk1EZHVIcmpRb1FtYmRDTm4zTmNpdnNpc2xzejBQcEhFZVp5?=
 =?utf-8?B?U1c2cW5NelEvOVpzNUZ4QUl1K2l6YlE4Unk4UlhBQWhRdGNLYzJYUlZlWWtJ?=
 =?utf-8?B?cDl0SFlaenFYbUdiRkVmcU9PMUcrSEJWdUhEeGFzd3ptTUJGckNORFRrQTdp?=
 =?utf-8?B?UHloZ3I1eGIxcWg3djZaL2hQSDQ3UDBYejBoUGZ3NzdtQTNEREpLR1kzQWE1?=
 =?utf-8?B?NVlFa2VISTQ2a1NKeldpZThXcEZxTFdvaFp2RCtaWWw2Uis2UytUWDZBaXFp?=
 =?utf-8?B?TjI3MHE5T08rZndjMkhMWFl0a3RBVEVrUDBySFRNeG1hTTIrS3JsaFNzL2ly?=
 =?utf-8?B?L01GaGJtZEN3WkM1S2taK2h0SUF0dXJPcncxbU5NMXBURmtKR0JKWFhKWEYz?=
 =?utf-8?B?aTl5L0JXTCs2RzFETC9XbHZUYnZkZk1NNjd6alovWjVhRmJMaGhiVCtqWGQr?=
 =?utf-8?B?RFliWWlLZUxvVTlwN1VkYXRncnZkcEhIMStJdEswa0twekx3UTIwRVJYd3dM?=
 =?utf-8?B?MEdDY2pWYnhGRlJudkFVTWZsOFJFSGRpSDFtTDM1SkFlL1YybW91Q3U2a3ND?=
 =?utf-8?B?WWwzSlhCUmtDdGNQUWo5VGhzUHU4VmpHTGthdC9FcGdCeEs3SThNRVplSmgv?=
 =?utf-8?B?cGsvOTlsdVFGL1hwYkVSMGNBOVhJV005MktWeUZzSHVZTElsQ1Uwd2pmckVq?=
 =?utf-8?B?cXdSaGwrNkIyYUlQQmp6QnorRkhUbGFQditaMDZHVmtkaXd6WE02TWFzVUJn?=
 =?utf-8?Q?XfN8EgC/D2phPteuko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG9GR3hES29hSEl6TzBmSVBQRzJ3S1VJUjIzYkdGTnRwWURYTHROM3JDeTdy?=
 =?utf-8?B?RmxKMzlwOEQvdlo2d3haeCt3amZEd2dKU1E2QVJzS28yZ08xMGJXWm1URklx?=
 =?utf-8?B?cUcwYWZNdE1vYzQ1ZWpFUGxIQ2NwMVZ5Z0xoTGMyVFR5UEVNbEVPZGdRbkVO?=
 =?utf-8?B?MXBYNFVxNEtpaHNVQ3dhbys3Z2VQR3hadE5mRTUrY0xDcE5HbXB1MmNzZjFl?=
 =?utf-8?B?UVJjOVJnR2NOQnJEZzd5K3RwQ0VKN3pGOUNDRlhoMldCVXlORU5yY1l3NFR5?=
 =?utf-8?B?UjdBZzIzUWNvb2paN3pqM0RkU05ZN2xMOXE3amVEbnZyLy93enZpTXNRaVdv?=
 =?utf-8?B?WVZyaExST2QxR2ZyWWN6T1FGR1U4dVVxSXBUZGhyZXEwK0VVdGFUbjBwZUE3?=
 =?utf-8?B?VGhBWnFxRjdmWkY3bjQwOVZjNFJ0Nm1ucG9NWEsrSzhBakp6M1REQU1Hcnc5?=
 =?utf-8?B?T1JLMzEyaXZhdk9adkRPTHpBNVkwT2hRYXZRWk1Wckp1cVhybkdVdFpFelEx?=
 =?utf-8?B?Q3h2Vyt3amFkQ0RLOGEzeStRY1UrRXBTNTNWSWhCQU01a2RpYmJMTU5ZdXpR?=
 =?utf-8?B?QkVmNHBIZ01yWk1qNU03aEVwNEphMGxnWlgzYTJSZ3VRTXl5WEs5NHNzSVBN?=
 =?utf-8?B?TStMWkFCRnZndTBwSzBwNDZrMldCVzZvM29TWDdwUmhIazZwdHkwQnFLTm51?=
 =?utf-8?B?dzUwY2Q0djB1dVNHT0VnQy9GU2NnenU4ZTZGQU5YdEwzRFc2N1lpSjlvWHZu?=
 =?utf-8?B?c3BIU0M1RE00MHpZZVRZSC9KcklYQ2NGUU43VWdMSktXNk1xNlQxNmcwaGxC?=
 =?utf-8?B?UVdJbXRyZjVVU3BhS0h3ekpTOURVNSs5SFVYT29nVlEwcTRJRW5tWjUxeGNT?=
 =?utf-8?B?TzErdGY5Q0IyNEEzdzhrMVpaalpsd3ZzSm1seTgyZmx5M3BTWFJRRWtJWGxN?=
 =?utf-8?B?Sk56bmZhUGhRQ1VnblNZOGlWWUNyTllvZEV0TUwrZ3ZJWjladzdJRjRHeGhT?=
 =?utf-8?B?cU9IWmJnYzUrVy9tZFJwaDdmOXFScjFPUjJmNU1FWTd5MzFnajRBbmtCaGVV?=
 =?utf-8?B?OUJPZVlSY3B4eXE2TngwZnFBb3lVZVpCajlCOWdyTFdWVmJBd0ZhVWdMcXRR?=
 =?utf-8?B?MmdxejY5TG5paW9RTGlGTVNxMFlGeDl3VkhTK2RLbTF0dWt0a0ExQlk2WEY2?=
 =?utf-8?B?cXNwb1c0NVBDNHBpd0wvbnlJRGZybnd3OHRVbm90VUxkQitKMit2azF5VnJY?=
 =?utf-8?B?QzNQam01RzcvT0ppVmVPSWI0c25YNHhiVG0yVEhnVlZ0V1BodDB4VUxVQ1FF?=
 =?utf-8?B?UVh1bDRPSmxYN1hRWCtuQnhveTRqV2M3ZkQ2Sk5xREpzbkZ4Q2huS24zN2Vh?=
 =?utf-8?B?ZVRNY3FCaCtYMnpoYm15cTVwYS91UDUvL1VZdEs3cWsxTWE2VlJkOVhuVUlU?=
 =?utf-8?B?SzM3ZTBJR3NPY2lrbDhCS0lJMjZBenh0RWpXR0p3Y0g1cDBUWDJUTkVrUHNE?=
 =?utf-8?B?OHhSZ0pPQitkN2E1M0wyVW5CZmRGMVE4cTBFYkVVZFp6NlVqL0EzSmQ2U1Zu?=
 =?utf-8?B?VE9qQlhQdFprSjc2L0crNGEwZ09VZjlZZGZON3JMT1lEMUJDdFhuajg5RkRQ?=
 =?utf-8?B?T2lubkVoQmppYXd6OGJoUWhydnp2aWYzMjltMEYyU3NWa0VoV2FkS1pnQUxw?=
 =?utf-8?B?c0RDYnhoSWhCdTAwR2RMR01PamsyMzhVQ1dvazNOUk5Yc0FkTi9vSCt0OUtV?=
 =?utf-8?B?a0FhdmtrOEk0QWxEN2pGd2IxSmFhMFZDSEZVZnhkbVJlZ0tWTDd6MFY5VnRB?=
 =?utf-8?B?c3V4OHRacVZTdVNvNkRHcGtUTXpzeUR1ZkRaMHR1UmVIdXZ5ZCtHeFFYMk54?=
 =?utf-8?B?VnltTithZno1Ny9vbzE2ZFJiaVNoVEJjMnFlSDMzQ1R6anc4ampOMU9xVXcz?=
 =?utf-8?B?Z1hTSmp5Sm9uZVNaRkJ0bHR3L3hRYWd4YmNpc1V6bzVPNXlSY3AzbHY2LzNE?=
 =?utf-8?B?WnpzYzlpSlNBTUVLVnZJWXNFUkkveFFFUGxpRTJQYTR4bFdsMHN1ZmVGaVZt?=
 =?utf-8?B?ZHVjd3ZnRWp0ZXdrWXBoeENJYVppOUhQRTQvSytGK0o5cnVrWE13YlpGL3R1?=
 =?utf-8?Q?xGjNv01bShjN5gj5vh4TWUhP/?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63418576-f315-4f2f-e402-08dd18ec08c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:26:59.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqcRwPddk3UM0x52VU9v6/awH0h5JgvsdSb4dory3plm8DByrHWQA7wKP1oymkzyvSojLcnLv61Nh0rjg7kqgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7684

On 09.12.24 12:43, Pavel Machek wrote:
> Hi!
> 
>> I'm announcing the release of the 4.19.325 kernel.
>>
>> It's the last 4.19.y release, please move off to a newer kernel version.
>> This one is finished, it is end-of-life as of right now.
> 
> We (as in CIP project) will keep this one maintained for few more
> years, in a similar way we already maintain 4.4 tree.
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/tree/linux-4.4.y-st?ref_type=heads
> 
> There are -st trees, which is simply continued maintainence of 4.4 and
> 4.19 stable trees. Plus we have -cip trees, which include that and
> support for boards CIP project cares about. We'll also maintain -rt
> variants of those trees.
> 
> More information is at
> 
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
> 

It's likely important to note in this context again that CIP kernels are
maintained with a focused scope to address the needs of industrial use
cases. This is guided by input from our project members but also
includes broader community contributions.

For the 4.19 kernel, we prioritize support for x86, arm, and arm64
architectures (since 5.10-cip, also riscv). We actively track
vulnerabilities, fixes, and backports for components identified through
the selected kernel configurations contributed by our members [1]. This
configuration-based support already helps to filter out a good share of
CVEs, and we are working on tooling to further compensate missing fixes
tags or other lower boundary annotations [2].


At this chance: The CIP project has also selected the 6.12 kernel for
providing extended long-term support of up to 10 years. That will be the
5th kernel we are maintaining, after 4.4, 4.19, 5.10 and 6.1.

For newer kernels, the CIP maintainers additionally accept backports of
hardware-enabling commits that went upstream only in later releases and
that are non-invasive to the surrounding drivers and subsystems.

Contributions are warmly welcome, from test reports, over patches, up to
joining our project!

Jan

[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config
[2] https://gitlab.com/cip-project/cip-kernel/kernel-cve-triage

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

