Return-Path: <stable+bounces-225725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKhTNQSjuGmkgwEAu9opvQ
	(envelope-from <stable+bounces-225725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:40:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E22A24F2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 116A73016B22
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F32222AA;
	Tue, 17 Mar 2026 00:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rfRQi3DS"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011024.outbound.protection.outlook.com [52.103.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686621257E;
	Tue, 17 Mar 2026 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708031; cv=fail; b=igi87Q/AvUEgp6C1k5bBVuA3qO0mIMSQ0ZPcVj5aDz2t8xTSUNr7ZbwVS7VhzZTCGbM8gCP1gIsDDhbgsZmtCISsrorWCmJTa24TMklgG0ReUTSOwsKcBS4rrisC5b/Leh7c5gNDZhAM6ImW6/otlk3rPaXzGRHYDY5UPAeLamc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708031; c=relaxed/simple;
	bh=l3U32+ueWs/ItYFnplOGr1EswLeG8dJIlmQVlgMLb1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s5xJ8lkrfp3z+cnr1sCk4eAUvpMmgrnLaKmsS28XCmwEH2iNx03VX6yPVa5u0Op/E6nzUwUkwtq/riTwIxugBVbN7gQLtLkGlieAZSsOvNVE9c6WrurfOeEwajA3ZZO9sWPeFpNzbYyv75VNwZO99QQ7IUznS/vyLiK637IURVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rfRQi3DS; arc=fail smtp.client-ip=52.103.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOoD5y/cEyvdhx+TXM4beNruClG/6lBYNYFUlcrCjCsumh4xDpWP27rZxmqcnqFP2ZjdXaHhQww1fy0o6XRn1lTmQLqRazLBp8r7JS052cF2t2PN/tV26Q5W0M1XZnt/lIvjZAZOsRR1571q1fFlXO02qByH78dNORUUIxTy2TobAhaJdULEEl9WYwxGQ4rVHrOus7qTILxIsSMWQMNsTp0q0E816hSZt8aLsMJ0050cdCyRg1ZTCnqOAFASpmt+B59Ekn1LULh4ZGu71ijdX5jXHMq467lH8muIwaUBJgetVeKiX86SpYuSgNpQXjmSiNiNcGaVGVYiXI+WIFTCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANIkp0Q1Goa+5ZF18T59zLT5TxIxj/7Ofdixavt1xkg=;
 b=UaZ2cTOeMYsBFzBeK8nV/FLS++mjcC72IHubNjWCkjLfeUIEj2T+R3XMw5wLDrfu1skyln1Ix85qen+CcgqJyoZRtuIntz9vGJRluWLv8g3h/k8KgEpnvOZSbbePJTcLpJamlBUIJd2obW0LorhdQQppPjHtgvtAH+HQOSl02JhkvcFsw2z4Pp9smmwg/q6nMmeO/JarEGHQCniz6/6bNtgvr7J1h6mA+zEg57VIYFH7ybHY+vNgxhUyx480pqg8izlzjG/Qg4f9eRpSAdBtQypYyzRRcuc8jRawo6MvrTgH80EAV7wcTa2rkr8BQIfJyDdU5s5z2aXoAl86TjpZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANIkp0Q1Goa+5ZF18T59zLT5TxIxj/7Ofdixavt1xkg=;
 b=rfRQi3DSX4PB5zYABxqEpBwGA91x6k5GTuxjGvTU4eGMxOxcLHw/Q8RlOp0VT+K5G9/fNNoqxCQRfApmqI28lPApCf/XbpmF+TzOeXCmhREXSQuIIo5Go4YOUBjzqdGNF4o2wUATs9uiZAEqtVEYoSq0lWrdnN0E5nQf17FK9MwuLV18T3CORMnrbWfUHKawu3VyNnM1py4bE1kkPPBPMW26Mbhol+yjaP1qHI3AaIzvjlmvuJASQacnOl1Jv4zg/732sG8N7qdB2mOWfhYZnstgILe0fpTsyG/a9NcxzKlCKhE1/LVMqQ6SaOybc06s/bk0cbvEMxHOhzXGjcy9+w==
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::18)
 by SY7P300MB0276.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:236::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 00:40:19 +0000
Received: from SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::bdb1:7cdc:238d:2bda]) by SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
 ([fe80::bdb1:7cdc:238d:2bda%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 00:40:19 +0000
Message-ID:
 <SY0P300MB07691E08E5283FE074C81BE2C641A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
Date: Tue, 17 Mar 2026 08:40:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when
 !HAVE_CMPXCHG_DOUBLE
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 linux-riscv@lists.infradead.org, stable@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
 <CAMB2axN9xYPzAJVQVywx3sxYa5ViRxt2oktt1LFXsSD_XsuJrA@mail.gmail.com>
Content-Language: en-US
From: Levi Zim <rsworktech@outlook.com>
In-Reply-To: <CAMB2axN9xYPzAJVQVywx3sxYa5ViRxt2oktt1LFXsSD_XsuJrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::18)
X-Microsoft-Original-Message-ID:
 <dddc67af-23cf-426c-b957-a7038f69269d@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0769:EE_|SY7P300MB0276:EE_
X-MS-Office365-Filtering-Correlation-Id: 030df721-7f3d-42ec-42b8-08de83bdc357
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|41001999006|23021999003|51005399006|6090799003|461199028|8060799015|19110799012|5072599009|10035399007|440099028|3412199025|4302099013|12091999003|1602099012|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWozeHhsVXhmZjAxa1YvdW8zRXp3V2c5bklWQU1MdS9YTFk1Tm84Q1pNaEtB?=
 =?utf-8?B?cTlSbnpOdWR0cUFERHRCWmw1RmdPT0lQR2VLVE5zdDlLZEEvTVFiUGRKUmVE?=
 =?utf-8?B?U05IU3hGN0dWMnBUdUNqalJmSm4rekZRRGFBUWJiK21Rbm84bnZPWENLNEdB?=
 =?utf-8?B?UjVmNERoZGZveGc3RzdRTURSRUpHK042SXJxV0FZc3VVQUE5TVcxMkVLWWtz?=
 =?utf-8?B?TjJmVGVCdStXWHF2cWdOVlZSSDFzRWNnc1ZYamJqQittdy9JMlJteWhOMGFC?=
 =?utf-8?B?dS82elp2bnYzd3IySGtFZnlmZ0RDaWtiQks2dTdqSHZvWkxjd0I0OFJ5RjhQ?=
 =?utf-8?B?R1BPRnFNdzFBSUtRU095S0pHbnJBa3plcmRTaWo1SnVwczl5NnE4UXNVMWhU?=
 =?utf-8?B?R1FvWGpiZys2clQrZm9oR3pUTnBUYTc3UnUrMEV0YUVIM2FRYzBPMTZPQ2M0?=
 =?utf-8?B?NnBCQ0JrVGgyY3JUdE9ZU25ydy8xTWx6UTRuL3V3R0w3cy9ZMGpzWDA1RXlN?=
 =?utf-8?B?T21MV0ZXVW9LNGJ6ODJmQWFBSVN3RC9EWXNmditGdnNsSWtUMFVXTDNRdlJU?=
 =?utf-8?B?UHIyc3h6TWx0NThseEJLUEZvRmxTL2lmM3Z6Mms0aFpwNlpkUzhUZTRnMGQr?=
 =?utf-8?B?eTlqbjRKYXhqSlRVbUxHTkd4cjRzUExwY0FnTm5JZ3ZaY0VDNlFLRWdGQmlz?=
 =?utf-8?B?b0hHVWJ0VzN2V1JSQThENFpoTFhXQlJrdUtXcFpOTzJhYXpBUjNNYnhJOFJs?=
 =?utf-8?B?VWluaWFSQ0dqVmlDd0dSMGN5WityUnNFWk1HbmR0UFBaRUNkUytkZC9ENS84?=
 =?utf-8?B?T3JZK2J2Tkh4MlAzQ2VBV1RqYjFkQzQ0K0dhT1pEK1haS09zbVFkSktJejVp?=
 =?utf-8?B?MXgwTDFkcUJZeGVCR1ppelM5U3JEU3lxTUFXNkhhbnJBamErQjNnRnd4RTM1?=
 =?utf-8?B?RDN5L3o4RmFwZ3dvNGV4R2EwQXMyQ2dqMzRGcHc2K2gvTVZZRnpRbVJnOWZG?=
 =?utf-8?B?c29xUVdLZXlNalVMcUFxRkNLa1ZiTFBlR3lVWjgxY3NXdTh2bGs0ZVByMmh1?=
 =?utf-8?B?N2NndWxWRUpPdzU4THFCNDZBZlJSdTFJWDB1UUczQjNzRVZsZlFVcnNCS2o1?=
 =?utf-8?B?QjlsRUdkUC9qYStzTlVmbUlWRG9kcVVBYzlGK2lHKzJkL3E2eUFkc3VOR3lr?=
 =?utf-8?B?Y0trZFJmelh4c2pTb29SSy8waURickxZbnJtVUwwaWlJYlFuRkZtUHcxV0ov?=
 =?utf-8?B?M1QxZ3dtaHRheUxUT1Q0dERjQktCNmJNTHdCRE5Ha2VxeWFnRGJReEtLRFVJ?=
 =?utf-8?B?RlB4TXo4Ykw0eTF2dHllUUJ2STZ4eS9IUEg5aHRZWTNlV3JYZGs4bDR6d1ll?=
 =?utf-8?B?WVdFSFZiQ3oyRWNLQWRwc1FHcXowVWZvbUpTSWlBaHliRVFsT3VDdzl5THdX?=
 =?utf-8?B?a1RBYXh4U1U3WitMb0NkZlRvZklmakRhbW9sQTBnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0NiNjNWY2F3d2FKRFRwUmtKOUxJSUNzUnF2Q3hETm5aWjIyLzF5SUI1Mlho?=
 =?utf-8?B?cE5MQTVrUEpRd09UdldwRllHNjFpWDFsd1ZxMEFEN25EWEFLNTcvaGYyVnhN?=
 =?utf-8?B?K2t6Ti9tRHh2QkVBdTlneEM3VlRGR3ZqbnBuUkQvSVZLdWV5RzJibk5Ga2M3?=
 =?utf-8?B?WENFaDNpd0VmUGQvendyeWgzNG9WemsvMTA3ZUdmVGJTcTBvZ0FGZVFzK2tw?=
 =?utf-8?B?dkhsNEF1N0FidHNOOFdEcGhjOWZ5V0VXYzh0dEp2K2FRM2pKaDRqTXFqVjdh?=
 =?utf-8?B?WFRSNTlFTjMzMkJJaTMrS1I3UzFnR1MrN1MrckZUS3V0YmlHWEo0QTlVM2hC?=
 =?utf-8?B?YWNmNlBoUDlEcFJxOWFERVdlOHl2cVFudEZKditLeGxva3hIZWlmNmNCNU9p?=
 =?utf-8?B?VU8rdU9FOUpNeXhWY01rWXVXQWxqNjZpRXJhTHdyVmpNMjIrcEU3MUdmUS8v?=
 =?utf-8?B?U0NIOTRpMTkwNU90NGlTNkV4QkErVlVtMEI5QmxXMVhJUXFtN2Z0aC85bytI?=
 =?utf-8?B?bnpBQlVKSEoxKy9aVFptY1U0T0t1TE1pS3BGekdrZXN2RVFRcVVpakR5NFA3?=
 =?utf-8?B?TUUzWEJvaXkxdnlJVWZ0R2ZDenBMYnUzZjFTOGp2NnBreW1zdjVMSzc2c3Y3?=
 =?utf-8?B?eU0yQzJUT3JPd0pkY250dkUzcnlXL1B2MDZNS1dUOGhlUm94OVNDdzZ2ZHoy?=
 =?utf-8?B?dlpaQk0rZUoxZWtqcm5QT2JDcDhVQUUvUmJrejRQSU9XdTFVYXpCTnpRVTN6?=
 =?utf-8?B?dFVNZEtrOXZwSFVrRUlhWmxmaWhxV2FoTHRDVmo0TWdpdVNYVnlVblBlM2JY?=
 =?utf-8?B?VjUwOExyQ2MzOElFVVV4dzlJd1hFMXViTzhLTFJqUUtodXU5MG9xMVpDUE9z?=
 =?utf-8?B?clJva09Lc3ZPK1cvQXFWdlEwN3hpWWN5K2FNSzlZUm4rZFo3bjdmRlZZMTQy?=
 =?utf-8?B?Yko2MWpEWlpxUmJkSWpmZTE3YjNEOU40ODJScWd2NUpYNytLTVN1em1HODlV?=
 =?utf-8?B?UUlHcnlaTGc4Y1BhWW9JS1JTNVdLMHNaSUs4N2VKQXpVTXluWnNiaS9LbUgz?=
 =?utf-8?B?OE42TW9QYXNSck81c0F1am5NMkp6Q1R3V1VwZ0xVNUMxeXN5ODZ5ZVlCNXk2?=
 =?utf-8?B?SGw3eTk1cTBST0FMZVhES1kzQlpSSVJleHQyRjFJM204NWhiTDd0bU5yb0xV?=
 =?utf-8?B?Q05ia24yZ0hmUU9WcnZxY015RXN1VjcvT1VVNFpiSTJXTFEwOUc4ZlN4aTZX?=
 =?utf-8?B?b2V4MlN1WmNEaGNtUnJNSmFoNDVvN2hCdUgzS3RBS0xNcEpiQzVkRVFEd0Z4?=
 =?utf-8?B?MXlQVVJDVm01Sk8yWEdwTU4yZ2VaWS9jWWxidGVNaTcrdUUwMWhyQ0VqcGkx?=
 =?utf-8?B?T0plL3dTQXFDM3pEOXBueDdab3dBcHR1NmEwdlMzcTVkR2E0eVA0OUVLOUkr?=
 =?utf-8?B?eElIZDUzL0pFYkdDNjNsbzZiMWQ2dXpsUmQyNm42bWI4R2IxTzlldTZueEpP?=
 =?utf-8?B?Q1dGTTNaVm1UWGQyT29hQk5PQ1R4d3U2N0MySmhkTjUyU3JaeGFTdEpkRGQ1?=
 =?utf-8?B?VTZmZzV1TWY1WElYZkVNVlVsUS9Nblo0TTNyZUVDb3pXcnFmSWxoNHdZUlF5?=
 =?utf-8?B?aHRBa0RDNGlqRmxQaC9JSlh4eWhwTDVaZzd2bll0aWpsOW1zUVo1MmZsaWIr?=
 =?utf-8?B?cW45cFRtalR0STVqRzNRQWdKYmxMcEhGNzBFbDRPTlVXLzM3MWZqK2VEa0hr?=
 =?utf-8?B?dVZSSkhUWXlnSHJkV3dnUWpDMlN1RTcwMlJsTnlRa3ZybDREVXg3cDN3RVlV?=
 =?utf-8?B?aWNOSTJKOTUxcTV1N0U1RjJBeTk2MnU4ZkxPM1IrbnpwWEF6MmdRblRidEVO?=
 =?utf-8?B?aU5RR1NqT21hdHVpR0VoK1JPRnZ4S3FEUDFxdklaRHBqTHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030df721-7f3d-42ec-42b8-08de83bdc357
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 00:40:18.7497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0276
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rsworktech@outlook.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225725-lists,stable=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email]
X-Rspamd-Queue-Id: 255E22A24F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/26 3:53 AM, Amery Hung wrote:
> On Sat, Mar 14, 2026 at 9:02 AM Levi Zim via B4 Relay
> <devnull+rsworktech.outlook.com@kernel.org> wrote:
>>
>> From: Levi Zim <rsworktech@outlook.com>
>>
>> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
>> For example, this causes bpf_task_storage_get with flag
>> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
>>
>> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
>> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
>> for correctness. Add a comment about this limitation that architecture's
>> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
>> bpf_local_storage_alloc always fail.
> 
> Let's not do this.
> 
> This re-introduces deadlock to local storage. In addition, local
> storage will switch to using kmalloc_nolock() entirely.

I noticed the PREEMPT_RT case needs kmalloc_nolock for correctness and didn't
disable kmalloc_nolock in that code path when !HAVE_CMPXCHG_DOUBLE.

But in the original series [1], It appears that switching to kmalloc_nolock
is purely for performance benefits and not for fixing deadlocks in local storage.
And I didn't see any "Fixes" tag in [1].

Could you provide a more detailed explanation? Thanks!

[1]: https://lore.kernel.org/all/20251114201329.3275875-1-ameryhung@gmail.com/

> For riscv hardware without zacas extension, I think a workaround with
> some performance overhead is to enable CONFIG_SLUB_DEBUG and
> slub_debug options.

There is a patch [2] that enables HAVE_CMPXCHG_DOUBLE for riscv so I think
it will not be a problem for riscv in the future, even for hardware without zacas
extension because the kernel has fallback implementation for zacas.

However, this would still be an issue for other architectures. Currently only
x86, arm64, s390 and loongarch have HAVE_CMPXCHG_DOUBLE in 7.0-rc4.
I don't think letting users enable slub_debug would be a reasonable workaround.

[2]: https://patchew.org/linux/20260220074449.8526-1-mssola@mssola.com/

Best regards,
Levi

>>
>> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Levi Zim <rsworktech@outlook.com>
>> ---
>> I find that bpf_task_storage_get with flag BPF_LOCAL_STORAGE_GET_F_CREATE
>> always fails for me on 6.19 kernel on riscv64 and bisected it.
>>
>> In f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock()
>> in local storage"), bpf memory allocator is replaced with kmalloc_nolock.
>> This approach is problematic for architectures that lack CMPXCHG_DOUBLE
>> because kmalloc_nolock always fails in this case:
>>
>> In function kmalloc_nolock (kmalloc_nolock_noprof):
>>
>>         if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>>                 /*
>>                  * kmalloc_nolock() is not supported on architectures that
>>                  * don't implement cmpxchg16b, but debug caches don't use
>>                  * per-cpu slab and per-cpu partial slabs. They rely on
>>                  * kmem_cache_node->list_lock, so kmalloc_nolock() can
>>                  * attempt to allocate from debug caches by
>>                  * spin_trylock_irqsave(&n->list_lock, ...)
>>                  */
>>                 return NULL;
>>
>> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
>> (But not for a PREEMPT_RT case as explained in the comment and commitmsg)
>>
>> Note for stable: this only needs to be picked into v6.19 if the patch
>> makes it into 7.0.
>> ---
>> Changes in v3:
>> - Use macro instead of const static variable to avoid triggering
>>   warnings.
>> - Wrap lines at 80 columns
>> - Link to v2: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v2-1-576e33e4fa67@outlook.com
>>
>> Changes in v2:
>> - Drop the modification to the PREEMPT_RT case as it requires
>>   kmalloc_nolock for correctness.
>> - Add a comment to the PREEMPT_RT case about the limitation when
>>   not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
>> - Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1-1-24abf3f75a9f@outlook.com
>> ---
>>  include/linux/bpf_local_storage.h | 1 +
>>  kernel/bpf/bpf_cgrp_storage.c     | 3 ++-
>>  kernel/bpf/bpf_local_storage.c    | 4 ++++
>>  kernel/bpf/bpf_task_storage.c     | 3 ++-
>>  4 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
>> index 8157e8da61d40..d8f2c5d63a80e 100644
>> --- a/include/linux/bpf_local_storage.h
>> +++ b/include/linux/bpf_local_storage.h
>> @@ -18,6 +18,7 @@
>>  #include <asm/rqspinlock.h>
>>
>>  #define BPF_LOCAL_STORAGE_CACHE_SIZE   16
>> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE)
>>
>>  struct bpf_local_storage_map_bucket {
>>         struct hlist_head list;
>> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
>> index c2a2ead1f466d..cd18193c44058 100644
>> --- a/kernel/bpf/bpf_cgrp_storage.c
>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>
>>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>>  {
>> -       return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
>> +       return bpf_local_storage_map_alloc(attr, &cgroup_cache,
>> +                                          KMALLOC_NOLOCK_SUPPORTED);
>>  }
>>
>>  static void cgroup_storage_map_free(struct bpf_map *map)
>> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
>> index 9c96a4477f81a..a6c240da87668 100644
>> --- a/kernel/bpf/bpf_local_storage.c
>> +++ b/kernel/bpf/bpf_local_storage.c
>> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>>         /* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
>>          * preemptible context. Thus, enforce all storages to use
>>          * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
>> +        *
>> +        * However, kmalloc_nolock would fail on architectures that do not
>> +        * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
>> +        * bpf_local_storage_alloc would always fail.
>>          */
>>         smap->use_kmalloc_nolock = IS_ENABLED(CONFIG_PREEMPT_RT) ? true : use_kmalloc_nolock;
>>
>> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
>> index 605506792b5b4..6e8597edea314 100644
>> --- a/kernel/bpf/bpf_task_storage.c
>> +++ b/kernel/bpf/bpf_task_storage.c
>> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
>>
>>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
>>  {
>> -       return bpf_local_storage_map_alloc(attr, &task_cache, true);
>> +       return bpf_local_storage_map_alloc(attr, &task_cache,
>> +                                          KMALLOC_NOLOCK_SUPPORTED);
>>  }
>>
>>  static void task_storage_map_free(struct bpf_map *map)
>>
>> ---
>> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
>> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
>>
>> Best regards,
>> --
>> Levi Zim <rsworktech@outlook.com>
>>
>>


