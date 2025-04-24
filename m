Return-Path: <stable+bounces-136533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D1BA9A534
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B68B3B5664
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C21FA261;
	Thu, 24 Apr 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b="Mq4IHoJK"
X-Original-To: stable@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022100.outbound.protection.outlook.com [40.107.168.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0A11F582E;
	Thu, 24 Apr 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482033; cv=fail; b=QZDrOiSGqThsFsZP2AXujOfAGG6I0kskmA3VO0gCerSkhrrRq1+Cclr4SrPPg2O40FWLkKvMctM+m4cvAgjhe+vroYLvih54DZIfS3lqOQZxaSSHfgK7ijl9EGdREW4PRyuNc05lCy7uTbCDYVyuPbccBEPh2xV/bntTD2P5gvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482033; c=relaxed/simple;
	bh=z8v4DQAhwkIC7bK2imfVNB7w1cfxKSJ6fCgtzTTIbq4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rtj2YNiu9KL5RjAMrTHN9dCjcbAvRZ3WygOY696REOz9snayELta/OsDHSvUHz1akTvtnnPcBRJe66g4Uk4i2A83PbWT2bV0sOCFEUpyYiR1qgH7GT9sBuUP2qwCNImT5MWhThzCAkuqdIcN7BMxY6JgXWUq/yXA1cO04huOseg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch; spf=pass smtp.mailfrom=impulsing.ch; dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b=Mq4IHoJK; arc=fail smtp.client-ip=40.107.168.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impulsing.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sb8xOoQScq1TIzEmRElt/YDDDA1VbpV/BAVPh1O6DEzRVuK4x1WY+T1KrAaM+EmICOOd/ATCfxOsXSiVgiFprMzX23Lw1MxoeORWrWgOF6y2AKnZ1sUcdJWbQcHO/6RTaT5rsBLNzDRf1Lr73wpIvlPVHzYGPxmOBzU9Akj9QskNFAtkF3IjLZJpW6TXwFh0CXPKrin8YjZdhsORrh0AQuoAmEjYpJ63bNQ9TaEw4eupqIGpIGB9yXjv/RFFEdH+KAhFbJtTdffuN0itVhi0F3lJEeQ8b/Bownkj63dxi1l8jLoNkCIeoxHK4I3HsZ7Q90kbjq0fZCgtPxDoFh6wCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8v4DQAhwkIC7bK2imfVNB7w1cfxKSJ6fCgtzTTIbq4=;
 b=aBIOgGJCbX3v7VV7D9LXLBDoSi4qLsCzcEmLGEinbWDaR9oenHnYYM4/N+XOXIq0sj6WntyBFACQgUVErdeWmQRwimADiR6HvAbTW7Y9ZQRPTxcF+UwoOKrI1eg8igEJyyBU0aota+tk5S0iWBlxd6SAHsBcn17k1/I/Ow5AOOmkql5fRcM0KHmbSMzFj4139x7sXTrMe9HBQUpakGPvh51YH+KlZU+4ANnoTMnX8t2boupL1zu0TnRPsQlrAKHeDg811nvIY14InvKqBeI12jX5pgY6+yNNrFEBEIpOHexAFmiTcBk+ZqO72GXfFoeCh+IpRap40yNULDzqwzQcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=impulsing.ch; dmarc=pass action=none header.from=impulsing.ch;
 dkim=pass header.d=impulsing.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impulsing.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8v4DQAhwkIC7bK2imfVNB7w1cfxKSJ6fCgtzTTIbq4=;
 b=Mq4IHoJKzdzic9E9RHbY/5IpyVFH63moC+eGrXniQHqRf1EXg2kri+Qsk8VNEW2v2bqQ0mdZwEk4dsvQxOyBPM7Ivue/gSDkrHe5rH04QuVe6yzx0eMgyP1ELTHBV3z45TGTggyYAlAoHNH6rRogv9GaOnlZTzCftsG+XjcAhntPw5sgfu4HTUpJREvIxdxv6wrMYTbic51G69Mq8dEM10dbt2jUWEQ5UVY7hrQG2tLu1605+UJXlj9hYy0Fd4iShGsCXJ7O0hHGYxRVednzIdHrChbYq0/qpJVWmRs3CUtXVEqrUvmTVCYWPe5AwbsDFrTyiHE/aLzoSr7oDgXx1Q==
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::6) by
 GV0P278MB0002.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.10; Thu, 24 Apr 2025 08:07:06 +0000
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819]) by ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 08:07:05 +0000
From: Philippe Schenker <philippe.schenker@impulsing.ch>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
CC: Francesco Dolcini <francesco@dolcini.it>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: EXTERNAL - [PATCH v3] arm64: dts: imx8mm-verdin: Link
 reg_usdhc2_vqmmc to usdhc2
Thread-Topic: EXTERNAL - [PATCH v3] arm64: dts: imx8mm-verdin: Link
 reg_usdhc2_vqmmc to usdhc2
Thread-Index:
 AQHbs48w0QwgOvbFxkuKoITcJDMRw7OxA+uAgAAGkgCAAAFvAIAAESGAgAE8lICAAB7xAA==
Date: Thu, 24 Apr 2025 08:07:05 +0000
Message-ID: <209ffb9015b1398f6e6cd28891508d72ca66f7fd.camel@impulsing.ch>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
	 <20250423095309.GA93156@francesco-nb>
	 <222ce25ee0bb1545583ad7a04f621bac2617893c.camel@impulsing.ch>
	 <aAi_PPaZRF26pv_d@gaggiata.pivistrello.it>
	 <9eb7b15068eb8a4337ad0ea2512d02141afd491c.camel@impulsing.ch>
	 <aAnXK0sAXqfTNaXg@mt.com>
In-Reply-To: <aAnXK0sAXqfTNaXg@mt.com>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=impulsing.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR3P278MB1353:EE_|GV0P278MB0002:EE_
x-ms-office365-filtering-correlation-id: e163f767-a3db-4afe-f51c-08dd830700d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUVuRzBFZFdKUlVPQnVUQ1NlSWplRlhGUjBuUm0zc0dGVWF5SDJKZFNibnE3?=
 =?utf-8?B?MWZXcnE3Y2JDaDNJZ1dUcUduMjFWc1FFMGYrYVJJVm9MNzBSd2dpVzNVc0tW?=
 =?utf-8?B?RE9qZ09jMUJVRWh4c1RqYTZsM0FFR0pvZUtacEhKSjRZVThLRmFJMXcvRmZW?=
 =?utf-8?B?c3E3dlJCQmZxVy9odkVCZk5Xc1NFNWhwWFl5L0E0TlBPNEJ2QStNS1Fta2tC?=
 =?utf-8?B?Ui9DSVh1YWE5NUFzL0xRVXZDSDJjUk8rMlZlNFNoaGtCOTFZd3E0bWp5bjEw?=
 =?utf-8?B?SmFLcXJ3SHUxQzB0THh6dExOVDJHSU1iRUJLc1VrMXNUL0pRdHorbzNjbkQ5?=
 =?utf-8?B?Z0U1M0ExamVvMTBEbG1VME5icFQzd0s1NzlHNCt4K2s2NEw1SGxBYTFKbXpE?=
 =?utf-8?B?YU90bE81dmJtNXpMam9BUkh3YWV5bTZjTlVzMmFXaWgrMmEwL0tsbnBnMmM0?=
 =?utf-8?B?UFM3MlB5czBmWlE1eUJXM2JiajhzZXR3anRWTzZnL0hLY0w4SElUZy9WQXNo?=
 =?utf-8?B?NUJ2SThqdkJnUmlOUTFlZmNXcVJxWEhjQ3hiWmVnTVVvd203UzU3OC9oanh4?=
 =?utf-8?B?UHl5Z2tKbnFIWFgvWC84VThabFlvKzBpbjFCY1lIVW9KMEJhNmlnRTBEODk4?=
 =?utf-8?B?QklVQmYxVVg4VmhFWnV3blVLSXMyb2d5Y3FXN1Z6UWNmclg3NFBSNTZwYVJx?=
 =?utf-8?B?SVB4N3pIZG40d2ZSZVZMKzkxRko2MzZtZ1phVGI2MzNBdllKZjI5bjA1Rmwr?=
 =?utf-8?B?aXF4Y3Q4djJDRG0rMlYvQi9yRmVZWWhMb3Y5bENxaTBybXdreXBITjR6Q2hW?=
 =?utf-8?B?ajltOEw3cGlkTVc4RDFaaTZjdEZxZ0tybFNSQ3JmMS9NcnRmTXJWOWtLM1Zl?=
 =?utf-8?B?T0NIMlNJMWk1R1BjUkduT1ZpKzQ0R0xpTXJJMjBhS253TVJmY0E1VE9Mb1ly?=
 =?utf-8?B?czJoLy85TkRiRGxONU50QzF5MytEWWtaWDQ5OUt2Rkp4TWlIbVpSWjJNd2ww?=
 =?utf-8?B?aVBFYnhWdUNkL3NIYWRXYTRyeDdkR3JubHJac2JVL1MxWjR4cFBZZEpQd1Iy?=
 =?utf-8?B?dTFFSmd5Zm9nZVBKYWUydVlOSkxzSG5DaTIxaEVPRmdhbEZLNkhvOER6QlFN?=
 =?utf-8?B?VTdpM0FNVG5LRlZ3dFdTZjBRUWRtU2I0N3JpZUlDekQveGdvVEtqZk52c1V4?=
 =?utf-8?B?c2ExVmZhWkpnbU4rRVdqUk1RLzZUc3ZaTnZSYmNPTXEvaWlXYmJLYlN6NVFs?=
 =?utf-8?B?UUdyTk5LY0pISHg4UmFMbXZWTHkwaGE0VUFMekEvRGdhK0JjV0I0K1Zyd1U4?=
 =?utf-8?B?ZWlXdHJlb1BxMFpJOVRpMkUzcFVkdkxERXhlNGM5VHlLTXM1dm9EajlRSVY3?=
 =?utf-8?B?NlBPNFJ5U1kxeFI3UVlOR1dURlhITUhqenNsMkNpRmlTWk9Vdm5WS0ZYZGI5?=
 =?utf-8?B?L0ZjVEVoUjI4cVVkRFpycjZqY2hpd2E1amcxRVB3T1ZneEhPNE9jZ0xqcjMv?=
 =?utf-8?B?MkkwRkZrUjJweGpOSWtIbGJ4cVhFMEI4RGI1bG5iSkRPWjdNdGpJTDJhRldG?=
 =?utf-8?B?Z0VKRTVUY1FCaUFzS2UzYUd2bHREUUhsazBNK3NUa0FMQ1dxWjMyMWtnZmVw?=
 =?utf-8?B?ZlIyalNHTjNmb3pkMjYyVUpkTW9GV2ZibHNoS0xHckFMNnlNdkh0WWk3cko5?=
 =?utf-8?B?RnRXODNGd1czRkNpVDBnT1N3ZkZzeVdZWlg5eUs0REs0UXJLRXFrTFZZT0pV?=
 =?utf-8?B?K0hEdUFiM3hTR3g4a283aEZCVDR0ME9lSlVoS2FCRVdiRGdjdk56NVgzUDh2?=
 =?utf-8?B?NkxvbEo2Y2ZreW1MYXZyOTcrU3E5UVF6TnczQ0hWazZOL0tGUkxQZGVZaWFX?=
 =?utf-8?B?ckVJVFVYMUM0dlhteldZaE5LMVFIeGFRaEJtd0RBalRkVDAvY085S2lqRUlF?=
 =?utf-8?B?b0JMVEN3L01zRzFMUGVMVGFrM2ZzZkN1Q09yTCtTR2wrNWpoSWZDdHV2Wk54?=
 =?utf-8?Q?gobYSqXC/Lq1D/KfBsb/RPN730ddIw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cWs3bmMyYy9iM2Z1eU9hdU1qV3VzbjVMeUNwbVBkVGViU2Vsa094MlFlUWU0?=
 =?utf-8?B?b3ZEVlhqVXMwS3BXYlJzekszNTB6NXZYMXg4VmlxZ21DcFVvWVpMTW1McXli?=
 =?utf-8?B?L203NmZYR0xjZDdmSnFJd1hnVnBkazE5MUEzTGtzSitIbnlsSHlyMlJqMHJk?=
 =?utf-8?B?UEJZbi9NV0JtaE5oVk13TmRZRGVQeUNDWkZEUDZxSUI4cXlMcHhQdDVDT0l3?=
 =?utf-8?B?dk1pRFpvMkRPeG5QeHAyelJwSGFXcW4yb3hWUVUrdXR1TC9neHBUdTFXRGdN?=
 =?utf-8?B?QjNPYXlSelkyNDlsNGh3OEZybjlMK3FWSVpXVDJaT2ZsTDJiZnR4Vmk3dFJS?=
 =?utf-8?B?TmhsTHNjZUJTZGR5d0k3KzVGRkdKaGR5TTl3VXArVWdpTGZucEl4YVFaRm8y?=
 =?utf-8?B?TzQ4bCt1NWNFdk93RHkrUk1PS2txN1hIb1FWdEJocGN4cU1JNVBKSVNydzhh?=
 =?utf-8?B?dStmaGFjaE1wQkZzSmhRNklWNDdBSHA4SmNDbjhEZXRkUm4zTUpTMHByenB0?=
 =?utf-8?B?bi9KMlVid1ovTFBuak5oenVLaXpJOTlyT0Z1UW80TkVkbXNrNXlZTTk5TEdU?=
 =?utf-8?B?ZGt4NWhxTUQzQlQyTU9qWGRxdVI0cURBb2RHVTBDZkNQdmN6TnBlYlVlVDUr?=
 =?utf-8?B?Yld1MXdGZkFKR25rcUtJcVVYWDIvOHRqZjhmdVg3RFAzWU5oZytQWGhvL3Vw?=
 =?utf-8?B?ZHlDMWsvMGlwZTMxOUxDVy9wMkdiZlBOTFhYUWMzT1JsZWkzWm1qRXZaNkJm?=
 =?utf-8?B?N0daSzUyYzhlUjhJOWlIdTdPdENqOE5NSXBGSnBiQ3pSSFd2ODIyU2FRdURB?=
 =?utf-8?B?MXZsd1pwbGZvRVFVcWFZUmk0K3RWb2pONmU1T3lqYUlJKzI4NFR3Sm1jVnNF?=
 =?utf-8?B?ejJZcGhsUFJQSDk5eDRjcXZRc1BXKzBia2VhQTUyM1R5NDZJMHd2Nys2Q0JT?=
 =?utf-8?B?RElmOFZGYWFSdE1oWkZwTFd1NWpSN0JoK3BqR283dmVIWFdibWxCY2swT3o0?=
 =?utf-8?B?MnZLeFIzV3BWZlU0N1lrdEZZM2tuVEJMVmFJb1BYSytOaHpYWXlLYXpmVStL?=
 =?utf-8?B?dklUbWtBbXcyeVJZM2ZVeEdic3NUQWt0eW13eVVyaEpYUm0xaW1FQUNNZ0Vv?=
 =?utf-8?B?eklqWE56SlJXRGRWUHRYVnJ6VmNLcGp1UTh2S08zVCtseks5V2txOGltdTNJ?=
 =?utf-8?B?YTRyR09iRDJXZDVQamlIZVdnazdFQ0dQbzVhdE9NaEd2NGdlajZUUFRxRmRL?=
 =?utf-8?B?ZnEyY3hGdTh3VkdKL3dzMUtaTC8xdUVlbDZMcVhlbktJN2xLVUJMQ3ZPVjZG?=
 =?utf-8?B?TmJBQktXRzkwUDMvaFIxRjdLUUNFakhkdDBRS2hkM3lLUUhSNmNFa2IyTDV6?=
 =?utf-8?B?c2paaStDVytCY0tpbE92ZmRsUkUxK0JuWW5sYzd4Z2JqZU44a2ZNbFBjTkMy?=
 =?utf-8?B?cVptOWtGd1k5a0JZRVo1NExkczhPMTNDR3JLVXJTNG43SGZNVCtieWkxZmFy?=
 =?utf-8?B?dC9MK3BUM3ZCOFZrZzNhSTlhL1FkQlFCTGFUQUMxZTlkWld4TlhiYzVpYjBk?=
 =?utf-8?B?Umo3TXY2Tk5ncWxaOEhmKzBMejJibkVwcVJGN2ZsczhwbEpFY0JBT0g5aVdG?=
 =?utf-8?B?bGxuTUVNSzRHYWtmRUVYczZxK0t6Z1VnMzBpa0YwbTAvaENCMU41RTAvcTJZ?=
 =?utf-8?B?U3V4SHRaWmo4QUJZVDVWK3A3R0Q4bHdYeXF4WDJEZkFLRHZrditEOTZNWWxm?=
 =?utf-8?B?KzZyQk8rMGpsWW1obit1RGxaQkhlMHkvWnpuWFBKK3lDK2t5czl5Tk5lV1FD?=
 =?utf-8?B?ekhUYlMwOVIrM3JPRDEyUFdXUlFIL25NMkNYWHEzZ1RWSTBkTU83eWc5cndD?=
 =?utf-8?B?azRTQkRjVXpMNzhQbWFDSkpTcWU5bzROcnNPWjJXK05Ba3lXY2Y2eVdIdnNR?=
 =?utf-8?B?cXFDeFNWSUxsR0ppS3EzT2M4ekRhbkQvejhtcHBneWZJS2hVakQzVHZqK0Q3?=
 =?utf-8?B?NFF4RU5HMkFDSzd5OWNhNmRoNmw5cDV4bHd3ZGs0VGI3Vk4xaVVhNzRHQmd1?=
 =?utf-8?B?Tk92aXVXaXdhaGdLOUtFSUllOUVuNktxMTU1WGd0clhVbWtCUG1RQ2UrN2ZH?=
 =?utf-8?B?Q0tvUVR3cFVGRGdkSzlGZ2ZLdnV5a2xPK2srQ3NicElNaGJpV0JMaFNCcnhw?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="=-cCYKt1fPUx+yN2DJBNKy"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: impulsing.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e163f767-a3db-4afe-f51c-08dd830700d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 08:07:05.8018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86709429-7470-4d0c-bd3c-b912eebdee40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qXxqUzVVmCkXU4CYFuG2EDtOWsiVgwKQeUJltkqn7HX+yZmbmpKGKZ962U5PKYe5d8bQV34QOSol57rX3evmXTW1XH+whnh+kejMDCdQHGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0002

--=-cCYKt1fPUx+yN2DJBNKy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Thu, 2025-04-24 at 08:16 +0200, Wojciech Dubowik wrote:
> On Wed, Apr 23, 2025 at 11:23:09AM +0000, Philippe Schenker wrote:
> > On Wed, 2025-04-23 at 12:21 +0200, Francesco Dolcini wrote:
> > > > >=20
> > > > > I would backport this to also older kernel, so to me
> > > > >=20
> > > > > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial
> > > > > support
> > > > > for
> > > > > verdin imx8m mini")
> > > >=20
> > > > NACK for the proposed Fixes, this introduces a new Kconfig
> > > > which
> > > > could
> > > > have side-effects in users of current stable kernels.
> > >=20
> > > The driver for "regulator-gpio" compatible? I do not agree with
> > > your
> > > argument,
> > > sorry.=20
> > >=20
> > > The previous description was not correct. There was an unused
> > > regulator in the DT that was not switched off just by chance.
> > >=20
> > > Francesco
> > >=20
> > My previous reasoning about the driver is one point. The other is
> > that
> > the initial implementation in 6a57f224f734 ("arm64: dts: freescale:
> > add
> > initial support for verdin imx8m mini") was not wrong at all it was
> > just different.
> >=20
> > My concern is for existing users of stable kernels that you change
> > the
> > underlying implementation of how the SD voltage gets switched. And
> > adding the tag
> >=20
> >=20
> > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support
> > for
> > verdin imx8m mini")
> >=20
> > to this patch would get this new implementation also to stable
> > kernels
> > not affected by the issue introduced in f5aab0438ef1 ("regulator:
> > pca9450: Fix enable register for LDO5")
>=20
> I will wait a day and send V4 with what I beleive was result of this
> discussion.

Sorry if it was confusing. I'm perfectly fine with your v3. I was just
not agreeing with the Fixes-Tag proposed by Francesco.

>=20
> Wojtek
>=20
> >=20
> > Philippe
>=20

--=-cCYKt1fPUx+yN2DJBNKy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----=0A=
=0A=
iQHTBAABCAA9FiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmgJ8SAfHHBoaWxpcHBl=0A=
LnNjaGVua2VyQGltcHVsc2luZy5jaAAKCRCNEONHaGhfGtbUDACxNSNCUYOTsIrX=0A=
U8nlZp38H8JVy5aYjgQy9wh/Iw2UMl1ZnfLnVLZp/nYhFrGQl8cZWmg0miJkFXs9=0A=
5jlfPJTI4TxcTp6RxWSLyTtBBzM2bX2LmupUthej08bFMz0y4CdXQKTI+fcKx8Po=0A=
tT9vUj95kF4Y2KFPqaMdsYw9jMjOQu7Q64YbDD+o8WKWtuxS9zmDHTjLB/3cnQEj=0A=
t7cCo5IvuM0NQ5zd6Xcp9nH639SBMMhVztQG2YnaOSRpuCc+Rdyga5DKMAWbbJD7=0A=
a9I2dMNpKpv9XllMQ1wYmm5+uCNDyqj1FyyGEo8LZHIO8aCBV3Vl7QGIzOWXTjZD=0A=
adGWUBJX/cVKALkmCsLww945htXgrPNU5f+utZ7pPFwiiNv7yI8pVbr/YqxfbB/8=0A=
KEYZu/DDjwmK47oN6oiyTY3kpwvDSoViM13OZWH7eVVMjdpqr/q9/WSLbOm4mNQ/=0A=
h3ZBRZbI1OZBOp3nxjHHFYWedWA7Oj2Uov0yXDKBWNdtqureA5Q=3D=0A=
=3DYpCb=0A=
-----END PGP SIGNATURE-----=0A=

--=-cCYKt1fPUx+yN2DJBNKy--

