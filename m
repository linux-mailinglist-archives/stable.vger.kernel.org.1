Return-Path: <stable+bounces-135263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CC3A98869
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 13:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F28B189F9B7
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 11:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5A126F450;
	Wed, 23 Apr 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b="leqpZE6q"
X-Original-To: stable@vger.kernel.org
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021090.outbound.protection.outlook.com [40.107.167.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DE21FF5E3;
	Wed, 23 Apr 2025 11:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407397; cv=fail; b=WEpeqcSC1q9Tp7Gd7YND2/VSOH92cZa+YxcrCT4j2/YAUz0vxM29UXNtTmsAwTWtWF9FXDkhmbVB/uJWpmTnZ5zO2Bxoyuub/NU9CTcaB32NbCcqN85x4VRCBpwxz58NDnJRBkobbhbKrvbztqTGdnEGd6za3QmXsNrI1Tzm71w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407397; c=relaxed/simple;
	bh=PgNKLgYhMxugSiR/flQwUIE0ou8If1aUetrl9aPrz08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dyygEmVz2uVq1E45d/e/5v3Xy2iO4hkYIMXInGSvC+VCXti9RDu6sCHh761zNIjGSJAns98gV9OifNHgYPbPi7Pc9/elNbstMnm9CUoHivqhg/v3JfPtA0bNC82zz7XRH9UoyRN0+ONjlKT5IkUuBaOjEJs+eeULt5h3SmSt1ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch; spf=pass smtp.mailfrom=impulsing.ch; dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b=leqpZE6q; arc=fail smtp.client-ip=40.107.167.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impulsing.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiLBZ6KCDcOKaIY4Ipu0OTdYaj5VfmyGgKlZaRU7Y7iJ+isnj9KEqiwDO+GRG5bTJLg4aTtEnzTkgdKfJYUnNj9zONUg54dgD2I3tdPweQ2M1+8LGgRXiA5J7ChMofp3o5PgjRg7E+IJiDe7VpvAjz+ZSQEkhuv/gHoZUNFeIN/sRyQoAmGJzmqkHnX46dYWEzK6yaJnunoANEvzh489bvEcppRF62BRwVPF2iJ0vd/0faq4N1mY9s9+XalARj5MxrpJUKntNhvVJkbqcwQCwyIJZAoXgQyAWSb2ifIHipwowkNuj0rOBXRaye59paHKHzqzduuxC7X37u427WtjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgNKLgYhMxugSiR/flQwUIE0ou8If1aUetrl9aPrz08=;
 b=Bol8YkV1JfrwcVzLqp6KBMMLPXqyeggnDlrZpkUmkMPqab5iRgXPOwjlaYSY5EgilEhFvBBtgjNdVM/Ry32fBJrCE6IogUea5n9sW/Gr1KaQdbNMqUQZZFV1pm3y6tqjt8QV5Z3PazVgfZ0fxIBrezDMgYehnRo8Om8VhcoQbrpDxXeGrYfvJRag7sryfXnpWTkFSRDUsanyUNGKUv/451gDvnVA56qK94eVHagHbs1O/EbBtQ1y6Udz07mvTskN63lKXqlqxNucDPTz/RUBWZXGIEHF6vbPYvffASqlA8LMxJc4Z4QPQ4ttOs1stmTWUDcgeF2cTJDEuLxiIzljxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=impulsing.ch; dmarc=pass action=none header.from=impulsing.ch;
 dkim=pass header.d=impulsing.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impulsing.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgNKLgYhMxugSiR/flQwUIE0ou8If1aUetrl9aPrz08=;
 b=leqpZE6qU+07uygJc3a1vSUX7p72aHXSq4v8gt4DV5lado7QQJR/Meep6UaPbjgNwV4JZSejdw6RQNZWcDMfqZzLJbNyII9g4wOp9Szm3KBBziHGG3CiTnETHi1lTm/HwUsrhxDO7K5GM18Hxqsg/J9PnXQWRx2WNvsFI1T5Cghqn+Z37qBiwKCltlz8hKCl3zDsBF92dpip5H1ZgcTpvfUzHo0o2tH1/LtMypUTcIWaylza6wp/Un7FSGh/1Q0sGGGjFpfLO9EpTcIiuztZn6W4kH+CFZxzFzSwzHmfVnC1L/+mcG+oIouirzIvgxzxxZYqEU+sediL7n+EX/GZNA==
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::6) by
 GV0P278MB1503.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:65::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.9; Wed, 23 Apr 2025 11:23:10 +0000
Received: from ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819]) by ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb85:95c7:b27c:a819%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 11:23:10 +0000
From: Philippe Schenker <philippe.schenker@impulsing.ch>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Thread-Topic: [PATCH v3] arm64: dts: imx8mm-verdin: Link reg_usdhc2_vqmmc to
 usdhc2
Thread-Index: AQHbs48w0QwgOvbFxkuKoITcJDMRw7OxA+uAgAAGkgCAAAFvAIAAESGA
Date: Wed, 23 Apr 2025 11:23:09 +0000
Message-ID: <9eb7b15068eb8a4337ad0ea2512d02141afd491c.camel@impulsing.ch>
References: <20250422140200.819405-1-Wojciech.Dubowik@mt.com>
	 <20250423095309.GA93156@francesco-nb>
	 <222ce25ee0bb1545583ad7a04f621bac2617893c.camel@impulsing.ch>
	 <aAi_PPaZRF26pv_d@gaggiata.pivistrello.it>
In-Reply-To: <aAi_PPaZRF26pv_d@gaggiata.pivistrello.it>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=impulsing.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR3P278MB1353:EE_|GV0P278MB1503:EE_
x-ms-office365-filtering-correlation-id: f9727a96-66da-4c67-1ff5-08dd82593a5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1BhUE1HY3N4ZlN5MVl0NXVwdVlReHVLMkVIaVpSRE82KzZtazJHWWRuM0R2?=
 =?utf-8?B?RytNMGpjeEZ0eHp3c3VLQXFYTzJ3MGNFVHM3dnRLY1krYm5Rb09PQUhWZW5y?=
 =?utf-8?B?YjZYMlJ1TE5MUFQyNFBvbUFCRHRtUk1sVDExbDAxcGVqNCtIN1o2Vi9KVm16?=
 =?utf-8?B?clZBNEFVOWYyQTdYN3lNWGNmaGlUbDJlUG9BU3J1eWxEMG93YzRBSVI3Tmln?=
 =?utf-8?B?bVJKeFNQMEpFRVZlWG5jaDk5YW5IN0lVYXFpeHRBd214bzUwVlVOanVTVHIx?=
 =?utf-8?B?VFdXK0djT1daN0QrdUNKMVArV3BLbjY4T0FibTdFV3VoeGJ6ZU5nUlBMcnpt?=
 =?utf-8?B?d0orZlVDZDBUNWlPUTUxSFIxQ0NLSXlVZlVjTDViSGkwV1lwM3hJUk5GZDdP?=
 =?utf-8?B?UFRpY2tSQkFQR1FsbFJmWFlYRDQwZWF4Z1ZBWHhDaFRFRUlrM2FMT3lPMTJu?=
 =?utf-8?B?NHZPUTJBRkxJNHRoUDhYUEFXNnFSQ0MxNVJ3M25udHhVWURMZk9PdWVpcFhW?=
 =?utf-8?B?d3ovTXVMaHFlQ0dpV28vUkNiR3RqcWFjU3BxOGdZY0Q0Um40NEp4QXF2NXd4?=
 =?utf-8?B?ZnFDeVg3SXhOa3dzWC92TXZPYmExV2JaSTNjejJpSkE1Zk12Ty9BVFFsVG1z?=
 =?utf-8?B?NWZyTG1VTVM1dnBMcUNvWFF3c0J6WGZXc1drSStNbFg5Y0hNUHhSbEtEK0pV?=
 =?utf-8?B?OXhnd2RSZ3A3Uk9SVUFwOThoeVZabnphWjlkV2hDcDR4ajc4VGs4dUw1K0Qv?=
 =?utf-8?B?dEQvdjJwMkFKaXBkelVXcW9DMmpJTENNL2Q1VzcreVFZMGhnaGUxU05abHcr?=
 =?utf-8?B?eGY4cXpZVFBHNW9zZ3lESXNJWVoxa1I3QkdZMTdkRXI1VVdLdzBoMWQ5ZXdC?=
 =?utf-8?B?RWJCeGNnbTVjTVF0QVhjUUZ5UXZCMUdDL3JYMVR2eE5uYVNMdWY0TGtobUhm?=
 =?utf-8?B?U09xZ1hHdWRBR0pFbmpvRldKbnVuekUxdWorUnpYc3dickNEdGpFaXBmdjBj?=
 =?utf-8?B?dUh0MDZIYXJPMEJGY3hFRGsrakZBcFE0Ymx4aVJLQmdXY29GOW54dTJ4L2tt?=
 =?utf-8?B?QlhOMVZKbkJQOExrOGpCVVMwcnZjdis1b1I4S0NnYVVWdWd0Uk83VitUNFFi?=
 =?utf-8?B?SE1ydmd6MklxeXVSbzlRdU1meDAvTCtTOVVSZEc5OXNEbzIydGsxZVByWUtu?=
 =?utf-8?B?eXEyUlJ3d1Q1b2NYRjA3TStlK1lQZndncjUwVkZxUTBNckExMEVHN0JzQXVh?=
 =?utf-8?B?V05SNFNiUWg2U2wwY0dMK1lxZnA5OU1nTUNxelp4WURvUWxFZU5ueW1SVnVa?=
 =?utf-8?B?SEswQzh3VXovcURVOS9QaWdVTVVCalF2VXZPWmZCRVJqcXpNL2FKa0VQenJs?=
 =?utf-8?B?cGhLS2JITVhwSTRQelRpcUZqTCt0T041Wk5iNTFBbTkvRTdvK0V4a1FucHNK?=
 =?utf-8?B?aFpjcGQ3b0QvbzJESnFTaFBwU1ZCSHE5ZmlhZ01pNGd5UENZQ1dEUTRYMG5W?=
 =?utf-8?B?NUNoZml6Vk5BejNPUW52RzV2VklFc3dLUU9SMDBzcUN1UkhEaXVmRDZWRXRl?=
 =?utf-8?B?LzJTL2dYNWQwTXNUNzk4UTRjZFhNeG9XdG5UTnltdWFoMU9KMDJjY2pjSExW?=
 =?utf-8?B?cTR1MTdkZllJOXRuTTY4K011emczL2lETXBXb1dYSGRyMGxaNlExMTNWK3pO?=
 =?utf-8?B?enBlVHJQV3laWDlsVENBSk5YWkhtU0ovRnZ0ZFNKV21oTnowVWtkdEhwek9t?=
 =?utf-8?B?clA3M2xJV2NlaklDUGZQbnlKdGFNVm5NSlQwNGprZERGMWRSRlpnNS8yOEda?=
 =?utf-8?B?UXdEWVFGMEUvcHVjVWRPeDVnaXpRVXdLa0NEcG1mM2J2NlYvQkJQTmpMQ3VY?=
 =?utf-8?B?dSt1TlVoVUlNTlNLZldINVpRRjJVZGxsRkxXN1M1VVZKMmdMamR6T0ZxNFlh?=
 =?utf-8?B?T3BsemY4eEhROGVBVTlyUTUxcWlFaUpzRnhCdERZZjdRaG1PMVVJRVJ5a1A3?=
 =?utf-8?Q?fC1prKXQwakmUXnk/5u3yzxFwRJUYc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(4053099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UGFMa3lwTERJVXlmcUdTUjdvTCtadHY4bi9XN2dFS1BDWXI3bnhWOERLWkxv?=
 =?utf-8?B?WW0zOExsdXRlQ3JKQVZidlZucS9XTEdTRUJ6SVhVVS9sUy9yYmlqRkF1c1Js?=
 =?utf-8?B?ZWNGdGtSWW5WMC9xaGdZUmhqcXZyVFZGcUV3YzFVVjB6Zmp6dGNMekl5REJl?=
 =?utf-8?B?WXhabzlnc0NTWTVnUHBhZFpydzJWcFo2RDl1T3NvRVFTN0IvWTIrSUV3dmMz?=
 =?utf-8?B?NmtuN0puckxPZVo3RzRTNkZZeFFsMkdlbEVyRkhJNmthVHpoYlJ5RGErQWEx?=
 =?utf-8?B?ekxWT0JnQ3FiaGZnVVcyNUIvL3NCaDhmcklpZlUyRGdsV1QyU0ZYcktiTmF6?=
 =?utf-8?B?Vld4T0RhWU9SRFNQWmU5NWV5UjFXTzV1Um9wSHVXWlhhcmxZZEREbkNxRjNC?=
 =?utf-8?B?NjFNemNvSnBvVVFuMU44N21UQU9lZ3A0QXFtUFRkNklzWGhGUmpVbW9zQjNa?=
 =?utf-8?B?Qmtha3ZvM0RHSnEyeFl6VnN3eW5ucGJ3VE9SeHhtR2wxRUtEQXJjR3ZEdWdB?=
 =?utf-8?B?S20vTm45WXlrZ3hpaVFpcFhKMmNvdURiTlpqejhPYWxKWWN1QnY0b1BLTThD?=
 =?utf-8?B?dzd1RnVaWkJZU1kwcDh1T240R0V1NFU1MWRHakhNZWhkc2psOWZucDJ4SUhw?=
 =?utf-8?B?eFdwcUZUNVh5bktVb2NjRGdqOTg3VE1NTHJPblByL0Rpd20zQVh4Ny9md1A3?=
 =?utf-8?B?OExFRnkvS1pwY0M4OFFOSkdxb25uVlNpbHdJdy9SeS9nMUJISGNkN3FuNTFX?=
 =?utf-8?B?dzZvazhNTVl6OGRsZU1ueit6cjZvYkp1L1pIdzZHSHRaZFlSZ1ZxY0lGMyta?=
 =?utf-8?B?dXBKR2pCbTNkVzRSdXZFaGQxejg3clN2SzczKzYyMTE0ZnA0T0VyRzJqaWJm?=
 =?utf-8?B?M0VxK3hXQVpqSzNvbWp5VzYySDRQSFVPdjl2OHAxMnNINVhiU2dwcmorS0tN?=
 =?utf-8?B?bUsySXl2cGU5UEFOTEtzcmpXblJiVVVyYUR0YkFqa21oYTJBWUZZYk8xcVhT?=
 =?utf-8?B?M0gwQldFSTN5YjFlenpPR1FkL1MvTURqdU1OYkl2TDRXMXFGeTVVM1JuMUpa?=
 =?utf-8?B?NGZycXFwbitFUDI5TkZCaEdIeGk1cFBZdVZIMERDMzM1djhsTTY4VkpwVEhP?=
 =?utf-8?B?SEx1a3MwNzNtL3FnL0d1K2hSbXIvZXJHVk8yaFB5Tk5JbC8zVFVGdlhMWUVY?=
 =?utf-8?B?OWJsWTVjbk9IYVVIK1NyVjJXNXpVbVJzTERmMHRFWWhpeW9WbmdTSjliUzh2?=
 =?utf-8?B?ZHVleEcrYUNESXJuNUgxb2NWQWlWdllwTjJVVGp4Tjl5OWpNUW50T21iUzlw?=
 =?utf-8?B?d2E4bCtYY1QybkoxWjNiUjdleWcyM2R4VWNkdnpnR3ZYYzA0cFBuMm1nNmI0?=
 =?utf-8?B?VkV4aFdkWGJtQjJ6Q1R3V2hlK3NzS2V0Nnp0M1lNWmg3MVl3NVp2dFJndi93?=
 =?utf-8?B?NElNVGwrQ3VlMmUyeCtaTSt4U3hlV2NQM0k2Z0JJaWYrb2RKb3hCeGVZcGQw?=
 =?utf-8?B?MytGSUxBbDVqd1JWNkg0ZkFJcTRBVnA4bkJvdFV0OHl0Rzc5WGdzbndNdUtt?=
 =?utf-8?B?ZzVSWGRSSmlldFBTd0JMWWdlblFKaTAwZ2JGTVpPbGJ1WUVBbVc1QnlZeDk0?=
 =?utf-8?B?eWZzMzlqTytsMGFKWU5rblR5c08rOG5rY3hPRjVVUTBDU1hSWmYxZ2VmWkdC?=
 =?utf-8?B?VmFmVUttejZQNXBmZ3kzRmJ2eDN0RlZhczV2RzZkWndNOVd4Vk1pVmZwVkNI?=
 =?utf-8?B?RVlwTUhuMXlET1JvdEhKUnZaMUk0cGhnYnRVZ1NWekI4K3RsZ1FGWndEZDla?=
 =?utf-8?B?a2FsYWU1bXJBTC85OVMrRjFXbDZIYm5iTDA3cmYrSjV1QW4wNnk3Kzh1RzBj?=
 =?utf-8?B?bDBIeW9NNWVjZDZ6RmlPdC9pT0x6N1JOM254eUtPcDJtWkZkUE5RQmcwUk5t?=
 =?utf-8?B?SFBQaDMzRDdyV1VRdTRZUVNGRW5vS01YbldvYnU4WGRDaWgyNmYybWJOVnR5?=
 =?utf-8?B?SUF1Skl4dVVNclFTb1lSQjlwVWU3dTM5L25BSmNzOU9aRytwQmdKU0JyVnNj?=
 =?utf-8?B?NE1BaDFsZ0pQWXR4ancydWxlUVAvSVRRVFRuMU1jc1JqRkdPZnJBQUJzSW55?=
 =?utf-8?B?bGplTVZ6ZlpWNVFTVEhyTzVaUjlPWUJFd3NydDFlZURNT1NyZHNiK0czRGRr?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="=-ib0iunkRx/LQ6EiKk4Fs"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: impulsing.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR3P278MB1353.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f9727a96-66da-4c67-1ff5-08dd82593a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 11:23:09.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86709429-7470-4d0c-bd3c-b912eebdee40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7UWLUpQJ3f9vwNhd008PEtealsUgQQR5Jh8hgBbhyvWVL9VbN6Zfn9GMhpi9SJyh65mgHQqYGv8TtoK/CCbI8noyTkGyq9TRbpxW5UK6wcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1503

--=-ib0iunkRx/LQ6EiKk4Fs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-04-23 at 12:21 +0200, Francesco Dolcini wrote:
> > >=20
> > > I would backport this to also older kernel, so to me
> > >=20
> > > Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support
> > > for
> > > verdin imx8m mini")
> >=20
> > NACK for the proposed Fixes, this introduces a new Kconfig which
> > could
> > have side-effects in users of current stable kernels.
>=20
> The driver for "regulator-gpio" compatible? I do not agree with your
> argument,
> sorry.=20
>=20
> The previous description was not correct. There was an unused
> regulator in the DT that was not switched off just by chance.
>=20
> Francesco
>=20
My previous reasoning about the driver is one point. The other is that
the initial implementation in 6a57f224f734 ("arm64: dts: freescale: add
initial support for verdin imx8m mini") was not wrong at all it was
just different.

My concern is for existing users of stable kernels that you change the
underlying implementation of how the SD voltage gets switched. And
adding the tag


Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for
verdin imx8m mini")

to this patch would get this new implementation also to stable kernels
not affected by the issue introduced in f5aab0438ef1 ("regulator:
pca9450: Fix enable register for LDO5")

Philippe

--=-ib0iunkRx/LQ6EiKk4Fs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----=0A=
=0A=
iQHTBAABCAA9FiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmgIzZsfHHBoaWxpcHBl=0A=
LnNjaGVua2VyQGltcHVsc2luZy5jaAAKCRCNEONHaGhfGm+DDADQb7xJQzPvFcDJ=0A=
eOouTqsOCV0lYfbDuws/X4r13l6mnzsFQpvDZ8+bOsJ/iuLAZj7o28NdP5o1SROD=0A=
afXfZbvkZlRExtDBA88K9fy418JNYUf3jm/h/Vbpct1qXZ2Z33dSfpnipj1V7wAj=0A=
xcNZCZtSyGA24zy6e9uYYyPvIX3BLGYsbJoyIMpRMAQFT4GzNSfXgkZ1eJfFSeSG=0A=
1FctW/578R5aO/imjvuWQ7f/kCSWEP5z3ecV0M7cEYqu8jTXDvkq2X5WTff8qkpo=0A=
f3pCK4pWDceGJbtVNy7UqW1SVwzVw91sFYMXOKgKcH3FLH8JsOwSTH4mTZKrHmVN=0A=
zsAyPpSzKhxkVeniIlkVDfUuKvTtwKTBS6XveAjpmg4Qy/Nj+HGsOI3G3E4c19HB=0A=
2r5FLTVFScJZPnuyPW2iZ54x8cc0lQlws7SsSdwmkf78zyzH83Vn4D1oIhYPnmnb=0A=
MEIQ7/Fir47IN++WHG/zqw2+Q99tmoWr28WDraGcbxDPW2A+b+4=3D=0A=
=3D4zh5=0A=
-----END PGP SIGNATURE-----=0A=

--=-ib0iunkRx/LQ6EiKk4Fs--

