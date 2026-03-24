Return-Path: <stable+bounces-230232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULMlHWEBw2nRngQAu9opvQ
	(envelope-from <stable+bounces-230232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 22:25:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC84E31CD33
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 22:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFBA301BCC1
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EE035E956;
	Tue, 24 Mar 2026 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="NZQK7BZR"
X-Original-To: stable@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021080.outbound.protection.outlook.com [52.101.70.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E1C2459ED;
	Tue, 24 Mar 2026 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774387545; cv=fail; b=e7MLFyyODHEst0N6mWp5hwb3JXWwNk3DLdY/qQesv1UgJcYdJ7lamutaWf2FKs9YwU1YZCIi+KLrMvmVtZKE40TPflnbfAW8CoQchJIQZdRzoAN7ZCMChPvdIpyPwfHS/zUBduQoaJvLo58ryQ8dIyHKT6r9L+l5FZY4VZu5Xzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774387545; c=relaxed/simple;
	bh=3zroUDL8PruDCok/XHki1fGhx6cccvhbttoj9TxjOI4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OIoLP8eT4huyzrNS828GYPBWnWfyWMPw1HLfh6XBCgGTJO4aJCXcX90zjPxiTtEmBZpzaUcIR2pxD+6XM0U0DQBaAr9W3BK7/ozSFT0OVMzt1QzI5Kd9aP19HSDGMcfVOerKj828TiIliaIyYjy10cNztMoM5MWVHzn2MLCPubs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=NZQK7BZR; arc=fail smtp.client-ip=52.101.70.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzHIXZaFdEPxNW6z5M50wq7WtFAa3+vNd9yIiGeRoC3OZGBqiMlX2BRUIr0HDjHjVSu3A5vst2DIHa0MlKmYnSad6CytlFb7N5wrV2FDqAh4dfcSj0K3Mn/73TJY0/0J0eHUuKDWv5hs3FVHqMu0c2LU8smXj90q6iFO25yBPODDtt5LNrqwfGgMWAaKNt6CLc4m+LDgDYeUIMTdr8bS4FJGRkTEun4n9Snbjw5n8hls3PkvR0zXmPheC8iL9HUMSJy/xxDr5dPp0HDH0QMigjVGAYHSL2qjNLpNyxA6a++kdmzxLzzxixeZxQxIXRqUlY4BBjNFnegQX7L5EQ6KKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zroUDL8PruDCok/XHki1fGhx6cccvhbttoj9TxjOI4=;
 b=lrGU38Z1rc3hg4VoTuOE0CZ2beVVKbljNBs8oJuc7PCY2AZvQSxTpH3jZtnkETsfGlak5tQVXExFSzwHqCVgoWT3gbNQXtjzYlpogOJfRo2AI/WLRjp5kwVS6idJaTBS5JTqW3KnpMI+1E6QwU2i4NbH6bxlnbjrCi6QdQRCSjJf1E+rdXERZJ4L0QqDPwX4gsPWfpX4pyZqibYoBJHDHFm3crcBpoR4VudhBU+Nwy2P40DpvDdMNKigSnvD50NgJ/XY2nIyJ0I/9lhCHzmVnB6AZ07RHt8GoFxkOWGFnoR78hJR1HZ1FogeFRWNChrFFdvwV7V/C3PlOJ6BIMz+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zroUDL8PruDCok/XHki1fGhx6cccvhbttoj9TxjOI4=;
 b=NZQK7BZRYTj/TmwZdAdkRlwJWWUvNSa4dDkO/K9Nk3AGPvy7MzMNrY3UglQos89FYAUSwg9iWzR7FJjOqXmYylkOYjr2JirdZIIZ0BBeJYKAALI8v8R6Q+ad6WMxoR8vtyXy8cuvHIjiVxoE77TB5c5JoF0mVdcGFstrdksXgJBqXdhBO7nw1R3XHgLRvPMJ63p2kIeHGYPTWTkPr5aPt8FJod0DmgmfJPV+N/GfNEsAtK8TWrfLbxtgsDCjvsMSou0EdIIdFga6DNb0aUaOESdffn58ogzRxGQqmHFGiLbSROZVsEm7nWxZjjaFzel9h12hHv8oEmL44nOkU2g2jw==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Tue, 24 Mar
 2026 21:25:42 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%6]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 21:25:42 +0000
From: Oleh Konko <security@1seal.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net] nfc: llcp: fix tlv offset wrap and missing bounds checks
Thread-Topic: [PATCH net] nfc: llcp: fix tlv offset wrap and missing bounds
 checks
Thread-Index: AQHcu9TEe70waZEgdkmP07mjWVVWZQ==
Date: Tue, 24 Mar 2026 21:25:41 +0000
Message-ID: <463598db3dea48fc963e8431181ae68a.security@1.0.0.127.in-addr.arpa>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|AM9PR04MB8100:EE_
x-ms-office365-filtering-correlation-id: c79296e1-b9ba-4b8d-758c-08de89ebe711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|7055299006|56012099003;
x-microsoft-antispam-message-info:
 XlORdauOnBXCEC7fvgflmcjl4oQ9kJ2eVAiTPTsD5gy1ehb40STJi0et3w1FPBCNMPlD7sPO/wgLTZV60P0KMoy8zzcq1kPnuYmtr5vQsD/sPESgEhei0hs9zEOLif/EUQ3K8pBo5p6GzuqI1Q78CILeL2b7cT3dWgPnf7fiE8uekXg6yGXWVCBRAyxiN51oXPE0zFx1abfgD1S6m2XsThPBEr0VHLANbV4dBAuM7d4eo56ezg1bDp42sxfwepyfMONU6o+RJgfHzWTrRuDI+xFdzhDkoWHl5JL8nC81YQ+3WF1FjA6bvYw94k0uU16lh/Fe+z+0a+BfbMNNLliHeCJYtOKwdQ6D6qq+xkEP/CpKkpX1iX6FjViLrTII6UNjbISVwYvHrmy/2UOCscEffcjBuMzXIbQvxgMhW+NioTXme/6Ot35WQUHFqdzqx6qs8Af8LEEzz6p3xgHo6/PhfO7LCO48GZLT8fmZDSdySY1GgTkNm+h38YBpVbHwPsZCFHf4lh1JRkwI7nb2Mj6xaptR8eAlblxy2PfdQulAx/pHm3Uu1a+m9a/gPpRqkSBfplY1zBgZqeKU37u+7H3SP1gXqTZFCZfkLE7w+wBalccpeiyUZq39y957OHDh5BdfE+4mBNm4uFAPLuW17TwgirszqPtyu7iOW9G9YMyn3u41iyCuuNpMgAf4EQNHBRvubrS1K+IJ87jUzaCeFJ7fW8Wl60LbCOcyF5CiNr4xd5yoKBoPZ21Sl73bPZUg93lCCPyxrvgBU9lzTidC9cG7HUo+YPXeqvjep/7zKzYde0MznSkeqTzrfG9+Qs1MGESk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(7055299006)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0kybHNQNC9Ua3FvY200SHJ6OGRtOHlrM2VkOHE5QVcyOXY1SkllUHZ3YW5v?=
 =?utf-8?B?aGJlUkFuYVdOd3VWQko5azNaM1FmZDI0VFZwc0ZqcGwyNVI1VEE2aDZHRllB?=
 =?utf-8?B?aitVb0xhMVROak94RU5WTExVZ0xWN3pkTlY2aWpVVnR2Sndac3hhWm1hUWdR?=
 =?utf-8?B?MXN1aktHb3RWaCtVbG9WZ2dneWJHSjVLTVN2WnhEQ3EzbUZZYXVjSnQ2ZEJv?=
 =?utf-8?B?dmhWcWJ5Z2Q3Yk9nNnROZURLRUFKOG92blNyOGlSMjJud3hVNnNuZ1ROSDdv?=
 =?utf-8?B?a0JrZjcvenpEejMvVXBOck1ybEJLL3cvUFE0blJGQnJCZTFhUGtiUWt5NW5L?=
 =?utf-8?B?S1NFb0YwWnRVeEZPcDVSYkc2MmxWMVdaejlYZjJNaGVrSHNUc1ZPWm8rL2R1?=
 =?utf-8?B?YXJZczdnWFM4MUpBUFA4Qk5OVzN3ak55bkpwVVFQL0JYUVRVOHd0ZjAvdi8w?=
 =?utf-8?B?QVl1Y2tDUjkxQWNHaFBhaTV0d2ZFeHhDT1VLVDM3ZjUzZFEyNERyRDVtNG4w?=
 =?utf-8?B?OUR3dTJKQlI2RDFTY2o4QUtqa1d0VVFUUmxWTms2MWZXc3k1MXZqQmRxZUlC?=
 =?utf-8?B?MnU5czhmV1IxTnFyL1RPU0tvdjA3NUhFM00xWjVoc2xsRk9aWUlFYnZ2T1FJ?=
 =?utf-8?B?KzdRU0p1UjdxYkg3MHM4UHBqYXZqMGcrK0NYckJpajErVURXOHFKU01uanB1?=
 =?utf-8?B?YVJZbldFb1R4Z0FCNHNjZmhYVHJLNGNTQy9vaWdEVUYwYkZPcjBTcFJtQWZr?=
 =?utf-8?B?QXQyVTE0b1VnTjlMUVczMTFqNGhPNFdRQWFWVnZ2b2ZFaW00YXpxNjF1SDNM?=
 =?utf-8?B?bm81Q0hVenN4R0NGaWFhTWtVdGt4b1ppNUVsU0hFREdENG9RVW9XTXQxMzdC?=
 =?utf-8?B?dmNja3NFTHRkclkyQTJOQ2s2Njd1MmJHRHc2SXo5R0hoRHNrYncrVlZWL3JL?=
 =?utf-8?B?Z3RQbm04aWJQTUU3ZHRHZHFxbzNuQXNWRHRiUUtCWkJuT3MrTHNDWW5nMlhV?=
 =?utf-8?B?YnQ5aytzcjZManB6ZVEvVW1DVlhKNFFobGRtbzFLZXMvSUFhTThEYXkvamtp?=
 =?utf-8?B?WWpiaHgvQjJFS1Z2ZHRCcHJiSllyTld5TkNuSDE3MXIzaWgyZG83VE5ieW93?=
 =?utf-8?B?V29za3dRb0IyRnlOSHZBdG9YTDF0Z091T3hVcDQvNWVOYTF3N2ZBaEFiUEJW?=
 =?utf-8?B?SFJtOSs3U3VaaURPUGVpVXpmcnRjUVp6NWpzRWZOTEwwSFhXSUtNbkM2Q1Jh?=
 =?utf-8?B?NURYVW0xQ2VFeVE3UHJLRTlXc0VTRWsremVKNHhnN05hZlJjN01TNDV3OEJq?=
 =?utf-8?B?RHMrdHdhbFVzY2Q5RENuUC9YTWh6K0RCTTcvS0ZZV2VIK0Z0TWh3VFRsWEZr?=
 =?utf-8?B?OEc1MzNUTjNYWlEzSUFRU0x1WFZ3d0tndmM2WVFpbDhpenhiQkZLdUNTeEJN?=
 =?utf-8?B?NGp2M01DOEJKZUFURE1wWTIvNVVPakt2ZGJkaE5OdEdiNzlKUmM4OCtTb1pH?=
 =?utf-8?B?STFmWldOZEZxZHoyUXUxcmlTZ0svamJBWEMwOE9pM01TeWc5UTRTMkxrVmNS?=
 =?utf-8?B?cmJxeHpYRzdDN1puYkpybTZHandLZ2I2NHcyaWpobUEzZnZ4dm9pZldNYVRX?=
 =?utf-8?B?d2xRY1RKOXl5a0c5bEsrQkJyeXBVR2o4MmIyeEVZWGZidDJVY0pqT1lSTDY0?=
 =?utf-8?B?a2poTGV3NXpHbDF1RDY1UWJmMkJ3RnRzcGlJWUVXb1VZdHd1NnFKWjZEZ0dW?=
 =?utf-8?B?czF4eWIyM2pqbS8rSlBsVzB5Z0haKzRPL1EyWnRlNFpBR0ZhUEJwZDMrb2x4?=
 =?utf-8?B?TGtaY1o5dWd6NmZrY3hRWnBOODNnQW1BVEI3NFJvYzZnTGtMeXpoOU11RS9n?=
 =?utf-8?B?aHJMOEx6cWFScktiVGVLcjNVaFB1Z2F5bEJxdkdaVElQZzJZNWYxWmJEVndK?=
 =?utf-8?B?SWV4eXF0bTlCdEZHVmh5d3R6QkRvN0ZjQmU0c05JeU1aVEw1cXZ4OTlVeis3?=
 =?utf-8?B?Q1hNWnZwa2xWSW5SNThlak92bHJwQ2lVR3hrTU80d0RlMEpCRUY5Wkpwc0FJ?=
 =?utf-8?B?cDZMT2s5QjM4U2VrRmJpZmtETFNZZ1J5cXczSGhvTWNWcElZYVdmQmVYZlVs?=
 =?utf-8?B?dlhUakRqNVo0elZuMWQ0MU4rZldlcFM2OVZIWmhBM0NwZkN1UTVoMWNxalBv?=
 =?utf-8?B?czZVS1N6eTVyNFFJRGtVcVNVRmxzMHMxRmZIaE15eXlKRVhzemRDZGlCMHd3?=
 =?utf-8?B?dVdERlZycFl3a2VHdHBxNDQ5K2Jldmw0cHgrRW84VlMxOFUwMytIR3RsUkp5?=
 =?utf-8?Q?zpVHbc12/X25uHyBF/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A39E68A12ECFE140BB93ABEE713D8F9C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 1seal.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79296e1-b9ba-4b8d-758c-08de89ebe711
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 21:25:41.9749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxqcx0ACqa30N/JYTG07gV0uGha7qO0CoEM5+5Zt14dFshSfezBG5QWhg32d71KHVrCwugV60gDklJQVJy6/9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[1seal.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1seal.org:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230232-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[1seal.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@1seal.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: DC84E31CD33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bmZjX2xsY3BfcGFyc2VfZ2JfdGx2KCkgYW5kIG5mY19sbGNwX3BhcnNlX2Nvbm5lY3Rpb25fdGx2
KCkgaXRlcmF0ZSBhCnUxNiB0bHZfYXJyYXlfbGVuIHdpdGggYSB1OCBvZmZzZXQuIG9uY2UgY3Vt
dWxhdGl2ZSBUTFYgY29uc3VtcHRpb24KY3Jvc3NlcyAyNTUgYnl0ZXMsIG9mZnNldCB3cmFwcyBh
bmQgdGhlIGxvb3AgbWF5IGNvbnRpbnVlIHBhc3QgdGhlCmRlY2xhcmVkIFRMViBhcnJheSBib3Vu
ZHMuCgpib3RoIHBhcnNlcnMgYWxzbyByZWFkIHRsdlsxXSBiZWZvcmUgY2hlY2tpbmcgdGhhdCBh
IGZ1bGwgMi1ieXRlIFRMVgpoZWFkZXIgcmVtYWlucywgYW5kIHRoZXkgYWR2YW5jZSBieSBsZW5n
dGggKyAyIHdpdGhvdXQgdmFsaWRhdGluZyB0aGF0CnRoZSBkZWNsYXJlZCBwYXlsb2FkIHN0aWxs
IGZpdHMgaW4gdGhlIHJlbWFpbmluZyBhcnJheS4KCmZpeCB0aGlzIGJ5IHdpZGVuaW5nIG9mZnNl
dCB0byB1MTYgYW5kIGJ5IHJlamVjdGluZyBpbmNvbXBsZXRlIGhlYWRlcnMKb3IgdHJ1bmNhdGVk
IFRMVnMgYmVmb3JlIGRlcmVmZXJlbmNpbmcgb3IgYWR2YW5jaW5nIHRoZSBjdXJzb3IuCgpGaXhl
czogZDY0Njk2MGY3OTg2ICgiTkZDOiBJbml0aWFsIExMQ1Agc3VwcG9ydCIpCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnClJlcG9ydGVkLWJ5OiBPbGVoIEtvbmtvIDxzZWN1cml0eUAxc2VhbC5v
cmc+ClNpZ25lZC1vZmYtYnk6IE9sZWggS29ua28gPHNlY3VyaXR5QDFzZWFsLm9yZz4KLS0tCiBu
ZXQvbmZjL2xsY3BfY29tbWFuZHMuYyB8IDE4ICsrKysrKysrKysrKysrKystLQogMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0
L25mYy9sbGNwX2NvbW1hbmRzLmMgYi9uZXQvbmZjL2xsY3BfY29tbWFuZHMuYwppbmRleCAyOTFm
MjZmYWMuLjE1N2FmZDYyZiAxMDA2NDQKLS0tIGEvbmV0L25mYy9sbGNwX2NvbW1hbmRzLmMKKysr
IGIvbmV0L25mYy9sbGNwX2NvbW1hbmRzLmMKQEAgLTE5Myw3ICsxOTMsOCBAQCBpbnQgbmZjX2xs
Y3BfcGFyc2VfZ2JfdGx2KHN0cnVjdCBuZmNfbGxjcF9sb2NhbCAqbG9jYWwsCiAJCQkgIGNvbnN0
IHU4ICp0bHZfYXJyYXksIHUxNiB0bHZfYXJyYXlfbGVuKQogewogCWNvbnN0IHU4ICp0bHYgPSB0
bHZfYXJyYXk7Ci0JdTggdHlwZSwgbGVuZ3RoLCBvZmZzZXQgPSAwOworCXU4IHR5cGUsIGxlbmd0
aDsKKwl1MTYgb2Zmc2V0ID0gMDsKIAogCXByX2RlYnVnKCJUTFYgYXJyYXkgbGVuZ3RoICVkXG4i
LCB0bHZfYXJyYXlfbGVuKTsKIApAQCAtMjAxLDYgKzIwMiw5IEBAIGludCBuZmNfbGxjcF9wYXJz
ZV9nYl90bHYoc3RydWN0IG5mY19sbGNwX2xvY2FsICpsb2NhbCwKIAkJcmV0dXJuIC1FTk9ERVY7
CiAKIAl3aGlsZSAob2Zmc2V0IDwgdGx2X2FycmF5X2xlbikgeworCQlpZiAodGx2X2FycmF5X2xl
biAtIG9mZnNldCA8IDIpCisJCQlyZXR1cm4gLUVJTlZBTDsKKwogCQl0eXBlID0gdGx2WzBdOwog
CQlsZW5ndGggPSB0bHZbMV07CiAKQEAgLTIyNyw2ICsyMzEsOSBAQCBpbnQgbmZjX2xsY3BfcGFy
c2VfZ2JfdGx2KHN0cnVjdCBuZmNfbGxjcF9sb2NhbCAqbG9jYWwsCiAJCQlicmVhazsKIAkJfQog
CisJCWlmICh0bHZfYXJyYXlfbGVuIC0gb2Zmc2V0IDwgKHUxNilsZW5ndGggKyAyKQorCQkJcmV0
dXJuIC1FSU5WQUw7CisKIAkJb2Zmc2V0ICs9IGxlbmd0aCArIDI7CiAJCXRsdiArPSBsZW5ndGgg
KyAyOwogCX0KQEAgLTI0Myw3ICsyNTAsOCBAQCBpbnQgbmZjX2xsY3BfcGFyc2VfY29ubmVjdGlv
bl90bHYoc3RydWN0IG5mY19sbGNwX3NvY2sgKnNvY2ssCiAJCQkJICBjb25zdCB1OCAqdGx2X2Fy
cmF5LCB1MTYgdGx2X2FycmF5X2xlbikKIHsKIAljb25zdCB1OCAqdGx2ID0gdGx2X2FycmF5Owot
CXU4IHR5cGUsIGxlbmd0aCwgb2Zmc2V0ID0gMDsKKwl1OCB0eXBlLCBsZW5ndGg7CisJdTE2IG9m
ZnNldCA9IDA7CiAKIAlwcl9kZWJ1ZygiVExWIGFycmF5IGxlbmd0aCAlZFxuIiwgdGx2X2FycmF5
X2xlbik7CiAKQEAgLTI1MSw2ICsyNTksOSBAQCBpbnQgbmZjX2xsY3BfcGFyc2VfY29ubmVjdGlv
bl90bHYoc3RydWN0IG5mY19sbGNwX3NvY2sgKnNvY2ssCiAJCXJldHVybiAtRU5PVENPTk47CiAK
IAl3aGlsZSAob2Zmc2V0IDwgdGx2X2FycmF5X2xlbikgeworCQlpZiAodGx2X2FycmF5X2xlbiAt
IG9mZnNldCA8IDIpCisJCQlyZXR1cm4gLUVJTlZBTDsKKwogCQl0eXBlID0gdGx2WzBdOwogCQls
ZW5ndGggPSB0bHZbMV07CiAKQEAgLTI3MCw2ICsyODEsOSBAQCBpbnQgbmZjX2xsY3BfcGFyc2Vf
Y29ubmVjdGlvbl90bHYoc3RydWN0IG5mY19sbGNwX3NvY2sgKnNvY2ssCiAJCQlicmVhazsKIAkJ
fQogCisJCWlmICh0bHZfYXJyYXlfbGVuIC0gb2Zmc2V0IDwgKHUxNilsZW5ndGggKyAyKQorCQkJ
cmV0dXJuIC1FSU5WQUw7CisKIAkJb2Zmc2V0ICs9IGxlbmd0aCArIDI7CiAJCXRsdiArPSBsZW5n
dGggKyAyOwogCX0KLS0gCjIuNTAuMAoK

