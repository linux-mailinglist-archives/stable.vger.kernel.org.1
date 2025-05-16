Return-Path: <stable+bounces-144607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C633CAB9F7B
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62451A279E7
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 15:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F6219ED;
	Fri, 16 May 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ateme.com header.i=@ateme.com header.b="VacmV8VW"
X-Original-To: stable@vger.kernel.org
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022119.outbound.protection.outlook.com [40.107.161.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBF26AF3;
	Fri, 16 May 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.161.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407961; cv=fail; b=tfWsaFQU9MtbxtsBGcl6Iqn5RuioQqvyto0Zj2ET0Hi6nDesGm6GSMwX+4j4G8Y+U+y8Ii6XFmAmcfKSvdLb3ScklfKZNiK/GbmO3kSPPmZ4uzVhiitzDN3VRjEXRyVqzfsiXekuXDR2jeCvQgwdBU3LG4dz9jx4hfYnRWPSmUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407961; c=relaxed/simple;
	bh=wAxFe1u3XmerqvnMfk8EYYyR8/DYeMPiKvr50ydaLrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GohzNtI/dIESW5WnWELrWfTYJckZF3uZQnnItW/yoidY868OOrGqvr27Q84rJJ48pxDp5KyJqq3hsYqzmjIlpGBVZB3P8luoL6oIH7Gg5WD96j0xiI8S33RbEAZ3Fu0ADfwnp6WXWOuCcviv3aCySKDktbOXEbNpM77tmayY3c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ateme.com; spf=pass smtp.mailfrom=ateme.com; dkim=pass (2048-bit key) header.d=ateme.com header.i=@ateme.com header.b=VacmV8VW; arc=fail smtp.client-ip=40.107.161.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ateme.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ateme.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxPbqXdKaMaQcypRrE0XeaJ+ka3mc65T+8xpj3u1euL4R2HaQ+ea+3eUaEvCCSUyw9vUk5c38QOsy64zx2qx0h059RuNFQmoe9VoDu9wh6KxL/MpwRsFouGV2RwXaQKiYyuPtrKMMFoC/laaPPKquEvaMRBkvD+kktHvJbeIwxt+vDaWM8zg3uNp4igzbfGYq/ypjYGrDRQKxIOlGdbppaeEmN5eogCN4P+XNkmwp6XP3Mn8ncVdbstcqUxCKhRUm12eLKX9D5zREQ0OECv2LQTWvsBQQ8NjKe9e/KfFe5AGyZ66TJoBB8Zyrte6W5N66wgAfnbTmLwg9Efb3ggEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAxFe1u3XmerqvnMfk8EYYyR8/DYeMPiKvr50ydaLrg=;
 b=Q/QfJ+QhKQOVVkatWOsPBmJjxrQNWvjD79TWFcZM62SrF8rR2m6QItN6nJDUU9DDVLtRB1wOWPV7i+3kYl+S5RoZ/6EwQ/UjQv+ihDC2dHsGWKxHQdKj6q86kyts1sBWjz3lkTZr/yTwj7xtA+BNxaoxaTg+2nGNKVJDoJjczxh+EcyHw+F1Tb0Fu24lZRhrwIbnyduXer9V1RYTrADlaH09SxIkK2Zd6LPBuGxym6YPrVtsLN8cpFBwE97jkh4FCpUsux0zwiTBenKxpPeI+g1CfUVWaC8TuHPmB3ORKNSK7Mk29H+k9wG+GEaqwwxF79ACPDMK31MffnSDqqqABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ateme.com; dmarc=pass action=none header.from=ateme.com;
 dkim=pass header.d=ateme.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ateme.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAxFe1u3XmerqvnMfk8EYYyR8/DYeMPiKvr50ydaLrg=;
 b=VacmV8VWBZ4IHGQEpznRDAKncLj/5Kk8Nr1iHnHlGwd4CE1n8C7kp17Eos07sLPNZS00L+92daEv4M9HIq++czAOUO+Bc//TigcFXmcymBH1Oc6oeEsVcSLRz3P8sUB9OlyHXQLZFsFrHT3eVqtuJT3bVPepN6TJMSRh4RTzcgtcWHc61PC90dqiu3w43sfk0sW34JPjZ7b5IKH3dU4s136yHcyDD0wH0HtQtGxhWM8PAUgfc8mnz9REVMIOtEyIS+uL6ne67/gO0vlSC3SUbzAqCINAxZejSJu+5GqTvdtd3iI2xgH0O6rIB8q0liC+sBViViaHE4g9dh7kGnXaww==
Received: from MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1c::18)
 by PR1P264MB1709.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 15:05:56 +0000
Received: from MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e250:72c7:9cca:c5ad]) by MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e250:72c7:9cca:c5ad%3]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 15:05:55 +0000
From: Jean-Baptiste Roquefere <jb.roquefere@ateme.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Vincent Guittot
	<vincent.guittot@linaro.org>
CC: Peter Zijlstra <peterz@infradead.org>, "mingo@kernel.org"
	<mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Swapnil
 Sapkal <swapnil.sapkal@amd.com>, Valentin Schneider <vschneid@redhat.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: IPC drop down on AMD epyc 7702P
Thread-Topic: IPC drop down on AMD epyc 7702P
Thread-Index:
 AQHbr9zhl/8RWJ02Dk6pHFtpBzdc+LOo+aeAgA/I94CAAz3LAIAH8N6AgAAhnYCAAC0kgIAAAbKAgBFGlYA=
Date: Fri, 16 May 2025 15:05:55 +0000
Message-ID: <db7b5ad7-3dad-4e7c-a323-d0128ae818eb@ateme.com>
References: <AA29CA6A-EC92-4B45-85F5-A9DE760F0A92@ateme.com>
 <4c0f13ab-c9cd-42c4-84bd-244365b450e2@amd.com>
 <996ca8cb-3ac8-4f1b-93f1-415f43922d7a@ateme.com>
 <3daac950-3656-4ec4-bbee-7a3bbad6d631@amd.com>
 <CAKfTPtBovA700=_0BajnzkdDP6MkdgLU=E3M0GTq4zoLW=RGhA@mail.gmail.com>
 <de22462b-cda6-400f-b28c-4d1b9b244eec@amd.com>
 <CAKfTPtC6siPqX=vBweKz+dt2zoGiSQEGo32yh+MGhxNLSSW1_w@mail.gmail.com>
 <c0e87c08-f863-47f3-8016-c44e3dce2811@amd.com>
In-Reply-To: <c0e87c08-f863-47f3-8016-c44e3dce2811@amd.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ateme.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2587:EE_|PR1P264MB1709:EE_
x-ms-office365-filtering-correlation-id: 1dcfff73-8493-4aa4-b653-08dd948b2897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WWxmTHp6SkJyWmwvaENwbmFpWmJVMmN2RWN5aHF6bGRLOW11U1pvdDI5cW5E?=
 =?utf-8?B?ZTRpejEyVHdwRG8rNmgxRHNpZWVkNCtYSEJsamF2NUR1V3pVaERveFFDTGVy?=
 =?utf-8?B?TGw1bTlKMWgzT25YS2E4VDZlUEtJaHVKUEhnQXo0V05jeVhqN3BwWHpTYnhN?=
 =?utf-8?B?YjVHRDdoU2VQekQ1SEducG9JNXpsbmNUU0pweDlGdDdRdDhLdXBLZndiMWtl?=
 =?utf-8?B?aE9ZZ0VieTMvbTBabWVhZ08xYmczMUpFdU1nN2EwTVJ0aXNuKy81VzRqaDlM?=
 =?utf-8?B?bWFFZWU5WnlBN1V1bHNUb1Y5ZWJ1ZnFvMnZVUFY1WGJUZCs3bXhOaFlRK3dH?=
 =?utf-8?B?cjVOR2dVT0RpU2s5VlVLQVo2RUlhYjdXWkJjcnFUUjd0VEFOcFllc2N3RTZI?=
 =?utf-8?B?aDAraEE2NXU2WkRiUHBtZTF4M0pGb2hqRDJaMTh4UWFzTHNMQzBTUlpWdEdS?=
 =?utf-8?B?VDZiT1dHQ2xQMnEwZGZEcmlVRmxxeHhvQitjR3czN0hvQmhrQkJmRW0vUGdo?=
 =?utf-8?B?UHowREV6SEE3SFJXbHE3T3VRRy9BMkxyNEhXa2ljbGlMa3I3TXZOQisvRm1Q?=
 =?utf-8?B?K1h6c3ZxTXpXWmdPTXQ3T2QvREtnR3lBb2FOeDdoWVFLVzJUTkZNcW5rZlRT?=
 =?utf-8?B?SjZVSlYzbktnRFhvK09iVFNFaUpMd2pYZGgyTWdTRDIvRytMa2cxTFhGNkp3?=
 =?utf-8?B?YlZHTTdlY0hNQkFsTGhKaGxoMjFTdW1sd3ZldGloWWc0NUNVdE9xV0luenBT?=
 =?utf-8?B?RDFsQ0RCNENCWGV1dWtPMFdpcmYyRTVLRW4yL0JEN1puYmZjR3lqbWFpRjA5?=
 =?utf-8?B?K3g0TEtBQ3VWaENZbmptVUJ5NUNvMXRrZWRoc1QvL2VFdnFGYnAwWVFCOWlB?=
 =?utf-8?B?NXZ5RE5FY3F3eTNaQUpkbnF1YnB4bXY1SENJRHpGSGl2NEl0SlRONisvU0VT?=
 =?utf-8?B?U1h6emRSZytDaG5UdlQzYnh4WlZyM0VFN2tRQjdPbmM1M2QxTlEvT1EwcU5B?=
 =?utf-8?B?REpsc3Nud0U5bnNSeFIwV3o2dVRWTUE5RGdyV2pRRG9WSVUwK0psZXAwSHph?=
 =?utf-8?B?dFpjOVhjNjdrVmFDeVMzNEZYUHBLUm9SeUp5NE1Bbk5ZNmkxR1lhZUZYaHNS?=
 =?utf-8?B?aHpGV1FiUTJWcHQyNWNJc1NOL0ZmV2EvdldTbWRmYUJmNzl2cThsOU5naWIv?=
 =?utf-8?B?RnAzNXV0SnJxdVc4UHhXKyt3YnV0anFReHFJM2d6SWh1MDg4YnlkZEdDRXBh?=
 =?utf-8?B?Z2MxUVVOQlRDR1dLWG13OWxmVkd2QVRNc2RtVElPZHh5RnVCOGhoL05xZXVp?=
 =?utf-8?B?cGxaYlVTajIxVHNDZkppU0YvMElEd25EV1VQTGVER2NmcmtjakFZcUxWLzFP?=
 =?utf-8?B?WkZ6UWNHNWdYbkswekxHS2pOMkhvRVA1NTlicjZWbTlxdmV3Q0VCakQwWDBS?=
 =?utf-8?B?QWJIenhydkp3WnczYy9yZVZmcm80NzMzTVZWYnBNTGozQjBySDQwYmY2V1V0?=
 =?utf-8?B?Z3dva0tISTNVUTVIdE5WZzlFSnFOeG1PYzJkdVc2aWlTSWljb2FvZlEzc1Rk?=
 =?utf-8?B?dStVbVZCT0cxb2pJVHQxb0thNzRSTVdxSk1yRXRGYzQ1dUNCVm9ES1J4ZVQ2?=
 =?utf-8?B?ZlZmOE9Nbjd6b1M2aUVPRkFkZUZoOE9icmlzWFJZSjFMeG9ZeWdYR3hJeVBU?=
 =?utf-8?B?NnpUeHJCYk5NVzJhRFJYSklqY2JBcjJXd25UR3RpQ3BvcnNNU1dEWGlYSnFK?=
 =?utf-8?B?Q3V0b3piZURYZkdqTXRacWZmWktoSWNwcy9paXBrOG9CeS9kZENHMGIxTkhC?=
 =?utf-8?B?bjlVYjdxcFJkaG1Na1FRVWN4Mm5pWDgvRE45Q2pRWS9YSi8rNm1ERmZ5eWZT?=
 =?utf-8?B?UEh2ZkJyVUhScDJaS2pjelZ4ZFVuQmd1WHNtSXVIY2dsbmdNNmMzWWpKcU52?=
 =?utf-8?B?NmZFRkhiZDN3Zi8yZEcxSTM0VjYwRHJ4ZjJhRTlPK1JWaEd1VHdLNDcvSGJM?=
 =?utf-8?B?aGlPVWxsRC9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXdOM290NVY2T0cyYk82L3VJbFd3Tnk2Y204UE9SZENnRkdKV1BjY0tyRUhX?=
 =?utf-8?B?aXRyRHRFRVNWT2pFeWo3STJjazdwU0RvYmZ5LzdHalNhYU5PdC8waFJEOHdP?=
 =?utf-8?B?ZjRCSUhoa0hoS0RFSHBHRWhyb2NDbHhyYkszVVRodklsK29tWjl1TVF4MVVt?=
 =?utf-8?B?djBXZmh1c0grdGo5eUhZZ29lQVVsRDdEaUdUZW1ITGtXaTdxeWQ0NlFwSzBB?=
 =?utf-8?B?SFpwc1ZiRWhWdnNsanJoUExOd0dwa0dqWDZ0YmpuNUk2TlZYNEZZVVVSK1ZU?=
 =?utf-8?B?QWNVMDlmQ096WGxkKzBQeDFFQTY1b3NJWmNveWVkMEFTWFI2MlZPcWNmNndJ?=
 =?utf-8?B?K3Z0TjFmbDBsMFlWVlpMUzNqQ0Q3ZVdDK05nRVZGeS9JYU04VjFTd0pSNmVP?=
 =?utf-8?B?OFJrMndkNWtRSmZWaXlEUHQ3MkV1b0RyR0tIRUJKQVFWKzhGL1FXTGNZY3ZI?=
 =?utf-8?B?UW1pc0VCcXpXUmhQcDR6ZDhaSWcyVktWeDd2U0tCTDVtWWpTbFhNSC8wRHRI?=
 =?utf-8?B?bVRkTDg0NWNHQlh2amNmUXZqUHBMbGhuRXBrcjIwL0FpTEhWNXhVbTJIcmdr?=
 =?utf-8?B?TFQ4Q2lNMkNkVDdhK1pKcFZNajg2ZGVLcjZZdHVQNzhrV1JsQWkzNjMyYkc1?=
 =?utf-8?B?MGxIbEFJNGhQcWhRVDRUUlJxTDcyWGxXWmRONGY3Z1NuNGZkK09kNDhvZndk?=
 =?utf-8?B?TEpWMy9QQzB1MU5xY3lVb21aSGZLQkZnQ0h3SXh0UWhDTkFZWG9Rd2xSQ3Vw?=
 =?utf-8?B?SXJMTm9USHNEMlpNU2RpUUN1VDUwWEFpd3B4MERPUXI4Wnd2dFhyVkQyMW9j?=
 =?utf-8?B?cDQyUkI1RmNCaG10S3pOV25vWGpKR3NwalJSS2xQQUhocjc2YXRXSGJKR0ty?=
 =?utf-8?B?aFlkaVhVUy9WaHZJQzFtUXV6dzVaajByU1Z0S1Ywd2JhYS9TTkdaWWtNZXpX?=
 =?utf-8?B?dFpXOUdqRnZJS2NuN1NRckt0ODIrVzZuRE9YMnlNelh2RiszTnpWVHhHSHhv?=
 =?utf-8?B?UHJrUk1Rb2lUSjk1UmduYlFlOW1IMjJ4VExjUjNCNjFqYW1GZ1hjTXZXRm5w?=
 =?utf-8?B?YmdMc3lCQno2amxXaDNacDJ0aUZPc0lEeENLRyttSlNkb1pOQ1VYUENGQnNt?=
 =?utf-8?B?MC9vUnNjM3NJOHVrd25Kd2VrNllsaGxMZE1SMFBYVlpKaGlDQUg1TjFFbGhX?=
 =?utf-8?B?MFQ4bE82WnVWT2hhSlVSRXZtdlNZa1dFYVI0RVBaTHhDQUlvY2c2QWhtcVNv?=
 =?utf-8?B?SC9kS01PTXVYNG85YVh5NXg4OWxqL2FiS1JvYlFWRUFVYk03Q1FtSDYzeWpz?=
 =?utf-8?B?d3Y4K2I4TFlQQkljZFRlTlhBcnFmUDN2RjZhSVBsZFc4cFBDRVAvNDVIZDJ1?=
 =?utf-8?B?RmMzV0hMZStxelZCSFR5NnNHNGFqNmEyUlhpTXY3NjFSQUZXRXcwMzZEeE9N?=
 =?utf-8?B?WlJIa29iM2svYmUvU0xETGpFaUZwdXhwUis3dkdodDZpeFNjUzlILzNZOVhw?=
 =?utf-8?B?R21GekhZdGQxY0NWSkRGVXZZbGhReCtzUW9pUk9iOFZKZDhpQlova1hOUXZ2?=
 =?utf-8?B?VStxRmZMUzFnbG5vaVRPWGRiNCtaVnJXM1VZVjQ5ekR5TnZzOG1sd3hQekds?=
 =?utf-8?B?ZExsbU9CRjMxMVZJSDRqdVFudUxtRzg4Zkg1dittenY5YVVTTzBESFphU0lo?=
 =?utf-8?B?MmFpMEw2T04yc3dCc2FRbFFVdEdXUkQ2TTh3Yk1FSk5iY3ZWcFFuNDBWQzJH?=
 =?utf-8?B?aGpLSW9OaCt4ZkgrVDdud3FvVUUxUGpmazdHUW5tdkNTM3QyRngwVHdKelBF?=
 =?utf-8?B?MUoyeGxqVXFLTUd3QTNpUm5DdVNrSk51MmwxZit3UVMzOGc4Z0IxaWllam40?=
 =?utf-8?B?NVBERExVODQzdEtHcTc5alZLRVZnK2htcDdlMWRHSnRZSHA0OWF0YXQvWnAz?=
 =?utf-8?B?SGkraWMvZ2FlQm4xOG1YVElOd1VzV2F6RE0rdm5KMmRnQngrSTI1VjJFOWs2?=
 =?utf-8?B?Qy9tZzlhaVJQb2pPRVhBazBlSEtIWnNXS3JCdFdobno4WTJqTDAwQ2NLMUgv?=
 =?utf-8?B?MTgwaEl5bEtjeTVsLzJOSmF3dDJSKzl0S2ZlL3BsU3Fxb0s1L04xcjM0dSs2?=
 =?utf-8?B?ckZMcFEvL0x2N0ZMemJJVGRsWVlRV2VYMGQrN0MzS3lHRldyL0o5YnpMMWp0?=
 =?utf-8?Q?Wq8rtdFu7Tobl3M4aahGvHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <102642E96E807F4CB4E4795822E030C0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ateme.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2587.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcfff73-8493-4aa4-b653-08dd948b2897
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 15:05:55.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99ffcb0b-61fb-4a70-9dbf-700e3874ace9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uPu9H5ja8a5nFZ19Ieswbu7e4MFmFFiAwBzk6K57xYqOk52jQNMB7eF8NL6YkDCAHt43SD+IyRh9w9tJWrzNCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1709

SGVsbG8gUHJhdGVlaywNCmxvbmcgdGltZSBubyBzZWUuLi4gSSd2ZSBiZWVuIHZlcnkgYnVzeSBs
YXRlbHkuDQoNCkRpZCBoZSB0cnkgd2l0aCByZWxheF9kb21haW5fbGV2ZWw9MywgaS5lLiBwcmV2
ZW50IG5ld2lsZGUgaWRsZQ0KDQoNCj4+IGJhbGFuY2UgYmV0d2VlbiBMTEMgPyBJIGRvbid0IHNl
ZSByZXN1bHRzIHNob3dpbmcgdGhhdCBpdCdzIG5vdCBlbm91Z2gNCj4+IHRvIHByZXZlbnQgbmV3
bHkgaWRsZSBtaWdyYXRpb24gYmV0d2VlbiBMTEMNCj4NCj4gSSBkb24ndCB0aGluayBoZSBkaWQu
IEpCIGlmIGl0IGlzbid0IHRvbyBtdWNoIHRyb3VibGUsIGNvdWxkIHlvdSBwbGVhc2UNCj4gdHJ5
IHJ1bm5pbmcgd2l0aCAicmVsYXhfZG9tYWluX2xldmVsPTMiIGluIGtlcm5lbCBjbWRsaW5lIGFu
ZCBzZWUgaWYNCj4gdGhlIHBlcmZvcm1hbmNlIGlzIHNpbWlsYXIgdG8gInJlbGF4X2RvbWFpbl9s
ZXZlbD0yIi4NCg0KSSBqdXN0IHRyaWVkIHJlbGF4X2RvbWFpbl9sZXZlbD0zIG9uIG15IHBheWxv
YWQuIEFzIHlvdSBjYW4gc2VlIA0KcmVsYXhfZG9tYWluX2xldmVsPTMgcGVyZm9ybWFuY2VzIGFy
ZSBtb3JlIG9yIGxlc3MgdGhlIHNhbWUNCg0KKy0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQp8IEtlcm5lbMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDYuMTIuMTcgcmVsYXggZG9tIDIgfCA2LjEyLjE3IHJlbGF4IGRvbSAz
IHwNCistLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKw0KfCBVdGlsaXphdGlvbiAoJSnCoMKgwqAgfCA1MiwwMcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfCA1MiwxNSB8DQp8IENQVSBlZmZlY3RpdmUgZnJlcSB8IDEgMjk0
LDEywqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDEgMzA5LDg1IHwNCnwgSVBDwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMSw0MsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDEsNDAgfA0KfCBMMiBhY2Nlc3MgKHB0aSnCoMKgwqAgfCAzOCwxOMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfCAzOCwwMyB8DQp8IEwyIG1pc3PCoMKgIChwdGkpwqDCoMKgIHwgNyw3OMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDcsOTAgfA0KfCBMMyBtaXNzwqDCoCAoYWJz
KcKgwqDCoCB8IDMzIDkyOSA2MDkgOTI0LDAwwqDCoCB8IDMzIDcwNSA4OTkgNzk3LDAwIHwNCnwg
TWVtIChHQi9zKcKgwqDCoMKgwqDCoMKgwqAgfCA0OSwxMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCA0OCw5MSB8DQp8IENvbnRleHQgc3dpdGNoZXPCoMKgIHwgMTA3IDg5NiA3MjksMDDC
oMKgwqDCoMKgIHwgMTA2IDQ0MSA0NjMsMDAgfA0KfCBDUFUgbWlncmF0aW9uc8KgwqDCoMKgIHwg
MTYgMDc1IDk0NywwMMKgwqDCoMKgwqDCoCB8IDE4IDEyOSA3MDAsMDAgfA0KfCBSZWFsIHRpbWUg
KHMpwqDCoMKgwqDCoCB8IDE5MywzOcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTkzLDQx
IHwNCistLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKw0KDQpXZSBnb3QgdGhlIHBvaW50IHRoYXQgdHVuaW5nIHRoaXMgdmFyaWFi
bGUgaXMgbm90IGEgZ29vZCBzb2x1dGlvbiwgYnV0IA0KZm9yIG5vdyBpdCdzIHRoZSBvbmx5IG9u
ZSB3ZSBjYW4gYXBwbHkuDQoNCldpdGhvdXQgdGhpcyB0dW5pbmcgb3VyIHNvbHV0aW9uIGxvc2Vz
IHJlYWwgdGltZSB2aWRlbyBwcm9jZXNzaW5nLiBXaXRoIA0KOiB3ZSBrZWVwIHJlYWwgdGltZSBv
bi4NCg0KDQpUaGFua3MgZm9yIHlvdXIgaGVscCwgSSdsbCBzdGF5IGFsZXJ0IG9uIHRoaXMgdGhy
ZWFkIGlmIHNvbWVkYXkgYSBiZXR0ZXIgDQpzb2x1dGlvbiBjYW4gZW1lcmdlLg0KDQoNClJlZ2Fy
ZHMsDQoNCg0KamINCg0K

