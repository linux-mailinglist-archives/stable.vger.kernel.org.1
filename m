Return-Path: <stable+bounces-119468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C1A43A39
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 10:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C638179104
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049F2641C5;
	Tue, 25 Feb 2025 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="yymiusmU"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD89261574;
	Tue, 25 Feb 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476741; cv=fail; b=FZkKtL19bwlsvc4QiZgBhwYMxCD3H6LOYko7scXI69X1LpH0TuIlr5WP3nQ1VD8/Ym8+Y4Teu4VWdC4ynhYWVZRzyCNXdedjZwv8joSBfKDhJhxCs0BpdhlkkrXSGlUYU4h87uYuIYx+F3YhOJlIGbyuWuf9RwGMsNZ99fpAg5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476741; c=relaxed/simple;
	bh=dTiraPPNyjWqdf6f/BIXGMau1JDi3nGsdbqlKdIDazs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BuMH0yK+QeEuXyHYNJpQR4JihS40DhsUw8sCiFRVl7h8Atw+T221ReW5/8DQz0XkukkRzgKdo/5MDXY/NXF5Sk2IG7bSUwZ0Yk8StGuVWV6Stfk0ZBqC/RBsomJfRMONDO6aSSDxKQhRRqgWNMwbUrHXNeS06surMTsiquFRzI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=yymiusmU; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK6zO0nyI/9577TuHPMFRQgWXFWRfytyKvChPng68hrypseIHdQRlBgAT0kjP4zoewiMSh2kJtUBvgYZR7KIztp1t0fBwZDAom/NfZ4DaZV4lP2UO6QqCfT0E0a3mlkSOyAGLmKdnvS5m4fh26gvDp0QevHcqx1vdCn6FdEL54f+uGEaQziXucdyWpIdUmZLK/53+7FJ6EaaShUb6PuU7r/bvnmkwKGOPVmQEkBgahGzYlXhLknzGO9pUvXfyBx9rvO19fnip+NGdM2YffH05NXZLuW5DehxqXuWiYXev51M3kyHcxUfhoL2cvO6bAMRwl7LFTLe+r1z1iUDhWGZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTiraPPNyjWqdf6f/BIXGMau1JDi3nGsdbqlKdIDazs=;
 b=TxplxgKk/dAMgHL2EtxHDfoGV5hH19nmVbxJsW6dbE5FICrZAcRlu5ykdt4QA2dkiojRPimKr8cmxfLDmV43GD9P74f/z8yyzIrXnCvzXBLYvAStPj6PS1DaT1fAmGEIv2rqFSmX0UBHkefluxWZ7AqD/D+ifleNJtmV2meSVOdwyZRf05L7Hfb9nTOFdEGwgxP0uU+wWYrqKxO8jqefZ0/gerVlxMgqM3iZCMzaoGVSSTCRVr54dNyamdWzUCuJ19WqKcps/VnhRMcPC8tzwU05KHGHQEKdTdNi9C0zOF/Hp+UJmOQHV35tONDLf+El0vDzAT8ohmypgGXFxDDg9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTiraPPNyjWqdf6f/BIXGMau1JDi3nGsdbqlKdIDazs=;
 b=yymiusmUi2dx3SSIeL0JJnw6UZonGIVlSzlLsJiZtuyYA9Zz8v/u/TxamH+Fmj8tHs13z8ymMuLvWfdkIvLljZ0Tqz6AThTlfz5912466MDL3Dd4zOQTkuT33HlCUWsgIJX5l8LF4StfRFeKRRjwLlMlOBe+CmIJbvMnkg4nGPkOvRXIx38a9AVX8j63c74AqbuZEGhybbg9iF3ymsHrG4gftOlZPF7OCjkItpW4jMjruX2Y0GT2Zb2ejz2F7MAOKk6wMPEDBnX+305VrNWx006Aegq9WlprZ/uJMNF+NvbdpEJsBf5cgzPOwbUbVI2T8O7mpuMs4KV4SIHj7+gVSQ==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by AM7PR10MB3975.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:137::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 09:45:36 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%7]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 09:45:36 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC: "Ziegler, Andreas" <ziegler.andreas@siemens.com>, "groeck@google.com"
	<groeck@google.com>, "joseph.salisbury@oracle.com"
	<joseph.salisbury@oracle.com>, "williams@redhat.com" <williams@redhat.com>,
	"Bezdeka, Florian" <florian.bezdeka@siemens.com>, "stable-rt@vger.kernel.org"
	<stable-rt@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>
Subject: Re: Please backport: netfilter: nft_counter: Use u64_stats_t for
 statistic.
Thread-Topic: Please backport: netfilter: nft_counter: Use u64_stats_t for
 statistic.
Thread-Index: AQHbgqyo/ubgamX+F06BppUGCzCM2bJrPPyAgOyRs4A=
Date: Tue, 25 Feb 2025 09:45:36 +0000
Message-ID: <910e6de16c6c598127cab557dd7725eb08237862.camel@siemens.com>
References: <20240927155656.Z-s6BO9B@linutronix.de>
	 <CAMLffL-PTp+Y-rXsTFaC5cUJyMMiXk-Gjx59WiQvcTe46rXFrw@mail.gmail.com>
In-Reply-To:
 <CAMLffL-PTp+Y-rXsTFaC5cUJyMMiXk-Gjx59WiQvcTe46rXFrw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.55.2-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|AM7PR10MB3975:EE_
x-ms-office365-filtering-correlation-id: 04142ae1-43ed-4d85-8f34-08dd558127a7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3lnQ0NKT296UlR1U2ZkTFFhVHZMeDBiaWhnZU8wNU1BZVNQS0hESE5SUVpT?=
 =?utf-8?B?WVRMQkkzbGlzeFphRFpDSHdYVFh4b3QybWhQclBtSkxkdndFMFE2bGVUYVFu?=
 =?utf-8?B?cGVpS2RWUTlYdmg4QW9QekFYcUNrTzQ5MU05dGlvOUpoVHRZVWozWXVJMWpO?=
 =?utf-8?B?T0l3eUNaZ29tYXJyWGtRRmZoQmRXZFVHSVZNamRHU1FWWUtNL3cwWEljQUlC?=
 =?utf-8?B?NW1TVHNZVGVkR1dEY0hXNzFEMmZtdGRpejhxUy8ya0cxNDQzTDlTVWU5dmF2?=
 =?utf-8?B?YTVXWm1LbDAzaEdGTWF3bUw5YXZ0SFRYbzNxYkc4KzFzL2pFOC9BbDBSU0RQ?=
 =?utf-8?B?eU5MWkNmTWJyeFBJUUY4ZjJ3UFMxRHpRSGc5SFNhc1M2Z0tXWTljU3RScUtT?=
 =?utf-8?B?S0JYakR1UGNMQmFtUWNEZGVvWWxKcjJhZW5DWUpUa3hSanJ3aVNiVEYzUzBW?=
 =?utf-8?B?eXFucCtPWHpDanAzUnJhYUd0Uyt4WTRHZnU3QSt1SGpEWFdkYXJJbFRRTzJv?=
 =?utf-8?B?WWV4WGsrK2hwRDg1RUZnZDFIdEdQdWk3QnloTHk5OWd3QXNRUXIxemlwTFIw?=
 =?utf-8?B?T0J0UmJFSGc3RXFwTG8raXpSK0JZZ1g4OVYzWWltWWdqQ1ZLMHltSWQ3c0Nk?=
 =?utf-8?B?QXMyUi96NGE2Q292cXViSUVsTUY4ZzkvQ0V3U2E1Q1lXcTV5cStTa1g4WEgy?=
 =?utf-8?B?ZVQydE9UNEJ2SFZxWlE4Y0JKcjVzclAzdExzTmYvWnlBK0VGUEVKS0VsbzlV?=
 =?utf-8?B?eTNkaDBWYzNNYkpKcTNSV1RtaWNTT0ZRaDN1V293c1JsTDBvb1NQb2JtT1l6?=
 =?utf-8?B?QU9yMElDQnFESE1VVnRsNStWYVZuTHdNQ01ucFZHSEp4bG1xSmFCNmUxclFk?=
 =?utf-8?B?UUQzelphczc3Rnp0ZFltcytkY3VQb1JzMHBkRGVEWEhuUElsU2VWaFJxOWo0?=
 =?utf-8?B?SkVTWFd0eGVkY2VQaHY4M3ZMT1Y0UnRkdXVGUGZRR2JtUko0cExvWXkzaWFS?=
 =?utf-8?B?UnBTbnRCRWVYbml3VTZPUXMyREJoOXd3TDNXUmRWNjNHR1B0eGQyM3kzMVNR?=
 =?utf-8?B?UXRpYXdjNFI2Q0NJcGIyVllzUUlrdlNFSnR5Znhlc3VIVk9EQ1N6TTZseDlB?=
 =?utf-8?B?VmRhdzJ3OURTUlA1cStTZzJ0SWZTa1d2cytoSUY0Q2JnOXF2N2d2NDRtNEdH?=
 =?utf-8?B?TWJIMnM5Qk9VWUIxcjIwUzFUbzA4RG5ZNzBTYzVoNDR2RDFWSm5SeWR5WVlx?=
 =?utf-8?B?OWs3NmJPQUlYSWdVbHY4MzIwdk8zcHd5RTJ6VlVhUlJDWm45eDFxelNjNmJK?=
 =?utf-8?B?TDRFMjVIejloOXVLY1ZPT3BCWi9KbDRGaExWTmhRbUlOeWtNSDZlTml6RGlw?=
 =?utf-8?B?R0gycVRyY1ZUUE9LUzljWExMT0hYL3Zod3FPTWdoK0J1eUcwd0VRTllrRHgr?=
 =?utf-8?B?Y2Y1SjV0NGZFaTVORmhGckoyN3dIYU1peVdIRXdMT0c2b2NzdStBU0RJdzc4?=
 =?utf-8?B?VS9ZOGVRZ2o5SVNzbWNrRGVaQWpvVTNMYVo1QTJ4aWRWL0VQeXRpcE9qcDVT?=
 =?utf-8?B?NTdwVm1YaUd6OFBCak5kelhxK1k4R2hqZ2hrWVJLM1F0amtIMUpaYTkyeVha?=
 =?utf-8?B?NEc3b1o2UTU0OWYzTndKZVFWYyt5NTlyWDlEL0l1NkdJQThEcUlKVk1kY1I2?=
 =?utf-8?B?Y3Z0VFEzSG9vTFkwMXNmL1V3c0FzTWtnb01CR2xnTi9NMkIyQ0U2cGh0OUxy?=
 =?utf-8?B?dHVQZ1hDVW9wN0NEQWRkUlppanRwUWFVazBxRVM0NEtZYm1HTk9LRmYyN0ZL?=
 =?utf-8?B?M1E4dDFaaDRjNW9TZVkwZkx4WTlZbTQxMzJQRnZLVWE3SlV5WHM2NmtFR0hN?=
 =?utf-8?B?bklZcjhVS05udFArTUdOK2xGd1hJaC9aOWc3UlVWSVlOWFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGtVMHEwU0p3Z1U1ekxTdHg2eTN6bVZSU3RHL3ZNRmZqeEJDQ0pMaEphcFFk?=
 =?utf-8?B?ZXFWTGN2MDZEUS94QmZReEI3VTVRT0NYM2VYZXZNNTRvc2twV29qNGFzVTVa?=
 =?utf-8?B?UzVJaityUFpGUkNoTnZiZG1UZE5OSkdReDV6SllHR2VocUo0VlVkWExOczgx?=
 =?utf-8?B?QjZYZUpBMWRJcXFuRTA1TVJEeG9wNUpwR2I5YytKbWdsZWhtaEhReTlRVTZN?=
 =?utf-8?B?ZFRDR3l3Tnh5SUxnZ0lMR2dLWjN2WTJyRFdxNmUrS0puQkk2WlAyY2sybU5w?=
 =?utf-8?B?QlRudnFiUVlTU3VMVU1ZdXJKRzR3TldhSzgwNGxaeHdCZkFCbFd5eW5tTmxk?=
 =?utf-8?B?ekphLytkR05yQ1g4NWdBVWViaUJaMDhMbThLYUI3QkcwbDR5MGNFTkxxVDVp?=
 =?utf-8?B?a2JvbmFSY24xTTlUMUVwNTV0MHhxdmpGc3M2d1Rjcy8wZUZQbzdYa3RUcDlV?=
 =?utf-8?B?K2xyYXZLczBuRVFGSVJzMXM4Y1d1TTA5WUU5eEpQNFVSYW1SN0lGWFdJYlMv?=
 =?utf-8?B?TmdNZTJidzdCVHozZlZXR3VoNk81TWhzZkp6aGlQaEdLSmFrQ3ZMNTRvSGM2?=
 =?utf-8?B?ZzAzL1dFUndaMmN4UWk5dExGVWY5Ykw1alJCMlA1M2FKUXNVQmNUUlp5dDRQ?=
 =?utf-8?B?WDlrR0lReTBiQjJvY3VLR1oyY0VKWmNkb0Z1MlM2MHZobXpwY1JTZG9rRXF6?=
 =?utf-8?B?ZmE0MUNOeStLMEgrYWtpYVZ5cHVpSE9Ra3BhY1hsS3EvaUV0eE0vYzFwQ3Ex?=
 =?utf-8?B?WkdrY1BSMWo0WkZDelVITDhtTlp0TG03eWRuUXd6ZXpQeC9Dd1RHRkZsT0ZN?=
 =?utf-8?B?dDl6alVIVC9OQTBsTjhPdzdBTGRVY2FuQjNJVFREOFlreDZhSGo2aWpRdmZp?=
 =?utf-8?B?bU9lSGFTZU0zd2RqRnZVK1JoRjNUTHF4WS9xS0dWWm9keFlZMWhUdnlQWW53?=
 =?utf-8?B?eGRibmxHQnplRTFjNmFkU0FsNHMzTW1NdEdZN3VVd3dPYUgwc0tQN1cwbFRz?=
 =?utf-8?B?SnprUnVodHk0SzFEU0IzWGxWOXlrR2IzTjRVTklXUUx1N0M5WHZCRmx2QXV5?=
 =?utf-8?B?alY0TUxHOGxJVlhWNHNPMjNuYVZreGJsUVNhN3lsejRZL1RNVmw0bjZ3aHkr?=
 =?utf-8?B?bnBmM0UwTktuc2VFNFVXQkgwazR2VDNUQnVlSStvUFFlUHFKQjhoUGs1QlZI?=
 =?utf-8?B?Zy8vU2kybDVzRnhiMGRaSk5RYTVUZUV0Zi9mODVBdzhXd2NPaXM1bFNnVHVX?=
 =?utf-8?B?K0dqQlljbG5QQVA0QlpoNW93eXU5WnRiR3V1TVoxN3pERW9HSVYybzNLbEtC?=
 =?utf-8?B?QzBnRGVpSnhLN3kvYjJvTHNCek9rcXBzclJRanM5SHlNTnRvK3dpNUZSUWRE?=
 =?utf-8?B?NklIQkhoRDlUcnRjM0NDUTdaUGVsalNsTDFhVWxNeDlCQ3AxQkRMelNXYmdT?=
 =?utf-8?B?Ry9OTU1wMUQ1bFNOd0U0dyswd1luQ3YzWU1pUEc3dVpBUTU3UjFVSVhQYWpL?=
 =?utf-8?B?T29hU29BWlBFMGI5WDRmeXl2aHVER1doMm4rbzk3enVoS3Y1NXltcDNEUGJj?=
 =?utf-8?B?REowWjFXTmVGME5hbGVzeGprWlI1NTVadDd6Qm56T2xHUmhGYVUzQnJYUU1Q?=
 =?utf-8?B?ZUU0Um90emFvUlJkZkxhRHFGMEZCRjhkMDRkWDZ4OXJ6K3YxTFIzRmFsb0ZB?=
 =?utf-8?B?Z3FuVGVCcXhuaVJFV2NPU0MzYW14UlU4ekpCNlJMQTRJVWd1UXk4N29xZlhQ?=
 =?utf-8?B?RmhaMDQwYTlES0VqWC9uazNoclZhS3M5MnByd0xCMWJ2Q0JGbDNPeCtMV3RI?=
 =?utf-8?B?dElObDZxMjRXSmNFbzR3QWZ2amZPVDFKYTN4aHR6N3FvM2M5OTFZZXlYajRP?=
 =?utf-8?B?SE5WQzZSdjUxYjVwWERNODIxc2d0aW5OT0dJZXB2REpwVUNleFI3cHlmUWEv?=
 =?utf-8?B?cS9LVEJ1MWNvU1dmeTlMQnNCTmtLNGZNbHBMTXVtdCtWNjNFSEpLbWtjTDBU?=
 =?utf-8?B?eDZuSGYrdDlsNjQ3WmJYcEo5bnNnVVpLWEd1NDBwcGdHZFJXN0Uvb1owTHlH?=
 =?utf-8?B?Y2t5aHFIOWFjalJQRk5YR2JpQlZPeWk1NFZTRHdwY0lxbXN2bVBpTGZDQ3Fx?=
 =?utf-8?B?eC9OeWpndXFNQ3pSaTFHcjFRWExCSnJ0eXM4UWlHQnB1MEluSlZSNGdTMFRa?=
 =?utf-8?B?UFdsQXpRYnh4WDlKdFVrejRjK1Nic0lYVWl2bWVEcWplVStRQmlKN0tyRjJS?=
 =?utf-8?Q?IBXohBqaFNPYyWXYSJqqtqiw6LzxTOzmSsQiBS4qo4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1E6276535C4464FA8A4ED4B09938D01@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 04142ae1-43ed-4d85-8f34-08dd558127a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 09:45:36.0357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xtR6MMkM2hTrXNW4LzxJcaJUMmcH295H6YKWp2Riduqks9t7wHiWfufHHvjW0qgUO3ZujdqCduV8zPl4M54vjqzEuVDdJsTuXlvWvZJRVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3975

T24gRnJpLCAyMDI0LTA5LTI3IGF0IDIxOjA2ICswMDAwLCBDbGFyayBXaWxsaWFtcyB3cm90ZToN
Cj4gT24gRnJpLCBTZXAgMjcsIDIwMjQgYXQgMzo1N+KAr1BNIFNlYmFzdGlhbiBBbmRyemVqIFNp
ZXdpb3INCj4gPGJpZ2Vhc3lAbGludXRyb25peC5kZT4gd3JvdGU6DQo+ID4gDQo+ID4gSGksDQo+
ID4gDQo+ID4gcGxlYXNlIGJhY2twb3J0DQo+ID4gDQo+ID4gNGExZDNhY2Q2ZWE4NiAoIm5ldGZp
bHRlcjogbmZ0X2NvdW50ZXI6IFVzZSB1NjRfc3RhdHNfdCBmb3INCj4gPiBzdGF0aXN0aWMuIikN
Cj4gPiANCj4gPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3RvcnZhbGRzL2MvNGExZDNhY2Q2ZWE4
Ng0KPiA+IA0KPiA+IFNlYmFzdGlhbg0KPiA+IA0KPiANCj4gRG8geW91IHdhbnQgYmFja3BvcnRz
IHRvIGJvdGggdjYuNi1ydCBhbmQgdjYuMS1ydCA/DQoNCkhpLA0KDQp3ZSBuZWVkIHRoZSBmaXgg
aW4gYm90aCB2Ni42LXJ0IGFuZCB2Ni4xLXJ0Lg0KSW4gdjUuMTUtcnQgd2UgYWxyZWFkeSBoYXZl
IGl0LCBpbiB2NS4xMC4yMzQtcnQxMjcgd2Ugd2lsbCBoYXZlIGl0IG9uY2UNCnJlbGVhc2VkLg0K
DQpCZXN0IHJlZ2FyZHMsDQpGZWxpeA0KDQo+IA0KDQotLSANClNpZW1lbnMgQUcNCkxpbnV4IEV4
cGVydCBDZW50ZXINCkZyaWVkcmljaC1MdWR3aWctQmF1ZXItU3RyLiAzDQo4NTc0OCBHYXJjaGlu
ZywgR2VybWFueQ0KDQoNCg==

