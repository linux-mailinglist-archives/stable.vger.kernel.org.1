Return-Path: <stable+bounces-226952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIBTET0UumlORQIAu9opvQ
	(envelope-from <stable+bounces-226952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 03:55:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB682B5620
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 03:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CF863061632
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 02:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C2271448;
	Wed, 18 Mar 2026 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YnAK3Tjo"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214EA1E487;
	Wed, 18 Mar 2026 02:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773802551; cv=fail; b=k1dR4uj+ua+mqnyFDPvt+mDwTgcNyjyyFI8rZpR53c56vi0bd3RBchDLkybZwxAkNeJ2frRk04TDEKum3LuV67w1x595W6Y/ed2BWiuOvzx+Vj+YbTcLn4H89AC5ZIZObkeaQWFdpYD57b/Uijm5Pn9yJAwB6SqthSgQzI6LFOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773802551; c=relaxed/simple;
	bh=gbYUF70wtYDERO0Yk6ZnrhLNJoYDIuSo4OwI3Flq4B8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FSSdEzdWE1kiPBkTXiRvrB4tIhKsLlY4JKCqRpPaNzMfvaIVzOcxWZ2aTgoFHL6xWomewOtIDyoYwiCO54DLDVde2NU5pHFSESkuW0bJKkefPYeqfLI4Jr4cN/kEok0fH4HX83Fkg+m8VcIFABr7qH4DlUBabZxNn3dOQAl4W34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YnAK3Tjo; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGfW3P4UqUqtam70SXc0AsaY9WavgZ+/BpWViBvkFoawKrD3KDXqqeRXSaouXm2ozrbU5nuw+n9dVpuNKq+t3Sh9mLJoCfBYAxfSTFil1JYpKuKjzTsUQjjGpPn4hcLH+CtRt/Mqzd3in1XZ7aNgsBIz822f1FCOSn/CY830HNOQCvQZxQ+ee7UvCJd/eIFriM5LlX60yAQKsnOG7xkLx2cyC9HdryVLtS6qD7DtXzVcvGu5YeI2te+JQzx5LTK72ImUB1kpdako7hyOE0xCcgro3KBt3OpVQP0pHV8bGGJ/bOrzw+F5cUFkB/ZTTTBOygP9eHQPKWDr9T4wT6fuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbYUF70wtYDERO0Yk6ZnrhLNJoYDIuSo4OwI3Flq4B8=;
 b=JYlJYrofyMQEzE8+VERhBoMpmUMJntqKgP6FTJDzwmklH2J4ZJEB67OUdrbUo+S9ilXew/t0LhFZdP82ThNIWV8/6FTmVRhpjCibaYVAFT2263rGoMYJIHcGkCi4B7lYNvvjFCxJEpA59S7pypoMtPKDcSa/KYt+L/dDXrGCWP/HGHemTVEO5U6qIa5rUlKuDJRh3OcXySDRFvomdZLQm8D1d0pw+GdsTeFvw+rP7mdo78X1zPlQNQFHkVRuGVLk3btpxzEIJqQtw61ruwW+TlhrWJ3j7boMXVkXQLZXvotOTXUbdva9Wp/k1X97lN8oFhWv25ZwUIZMQp6Ar5C/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbYUF70wtYDERO0Yk6ZnrhLNJoYDIuSo4OwI3Flq4B8=;
 b=YnAK3TjoTR6WpP+FhGmzY4uAAWjybImhy0jmAb8nN83+zU/50fgz8YYj2ukTU8BTeTTeXnjLqzva2JM121T+rtwT79SpazrWXLybgYg+mDRKTKVW6YYfY3EfS/j0iflJ5IS15FDzYMIaWVQErGvby17kv95YDv3VFWzZ+pK1bSgK65G3OtPiu/Uwqg1P3/odhcfY/RZ1t/uA0z62NIX07SxfMwzHyspCerfJuvI5Ibu9KJfdIWBLnP5QZTiOfecvNSu+WgvfQ0MYW8vZWAPK67Cc/Ove6jff9k1qEocplRYVuoHWsSC/22BEfD35EQ4GWHQ7V+/MqmfoXaVPRPZ3zg==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV2PR04MB11980.eurprd04.prod.outlook.com (2603:10a6:150:2f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Wed, 18 Mar
 2026 02:55:38 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 02:55:45 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Thread-Topic: [PATCH v1] PCI: imx6: Add force_suspend flag to override L1SS
 suspend skip
Thread-Index: AQHctdXR4rMaQwHMbk+Nxv/9or4V47Wy+e2AgACXyCA=
Date: Wed, 18 Mar 2026 02:55:45 +0000
Message-ID:
 <AS8PR04MB8833061F34B9BEFC9D19764A8C4EA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20260317061256.591362-1-hongxing.zhu@nxp.com>
 <20260317172341.GA93733@bhelgaas>
In-Reply-To: <20260317172341.GA93733@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|GV2PR04MB11980:EE_
x-ms-office365-filtering-correlation-id: 9d9555ad-f727-4e51-64c3-08de8499da3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|7416014|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 bV5m5eXsek7zkIol+3n3T6BNDXR2aorVeE7HnW+BTk+/sSOSzVjP9Jnf7CGZ4d34DDRjpX6dilufybJ04ta09uH23sWfuSoscvUQ6xePBbzxlprT0iRzBpXgU+JbpL4mjlIntbBc5+4CZKmnEiMLmEB78LhuFgkDiHUf4qEW4dCWgHlttRjaN2p7GSfo1QFbdxIrfq37M4sxAzQBnePl7NUG4cl79xyC/Hjfuzohf/ZTk/I4a+v4GoNbAqobeWzxKZ5e8HgrXAfvsZxWaOvdZ4P9m6GGA1todWESJUU5YQ3HDvkRNpKMfn9xuTEJdo/dW82YPVSo/K58nB1kogWKB6Cv3gw986gWoQMSr0+kPzV+p9C/+GJbucFBY7mYeuiMXjFyP+ym6GgR8zcDslci8Weef+zHKZjEEh9pAdwMMrKNZJyZPlUB/GhIh5nRC0DDa8Fe93S5RVxsDPfkRSime7wIKma2K6ajtnJ15D9Wj4UB+y5e8RBGCgjPs/2FfP0Ay/8L8AtO/J0RNULBF/DErQHcxIBdsvLFY25ZZ2u/bh12BurqePpoCIZ3qpIC0PwHjhb/FgyY+9juemR5Jc/uugO9S0qvDuqCDYncswF0Jtb4BfvfkcFPqawwsthqOL7UftTfjP3vflBOW4ADWKct5y9mukM3KQC40JT4REFyUEgPqapddQL+8E/pk4MGmP3s4vj3vc/GIQTkMvup1npuKswObRzMu1anWqTLRNI0JwFi7B8K56n4LoxfhVt6bD8jPtJBZBmi5v4KsDpQLq0lhENpedTGgxTgb0MG0BneCNg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(7416014)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?UGFPSWMzdkRoMnFpNE94aENSWERIM0liRVBHYURiak0xL2tJcjk4MnNCbnEx?=
 =?gb2312?B?TlllVmNmYzhlMFk4T0dzQlp1Qk1pTVhzMjZlUFpFM21COUlxQ2c2Q2FqaDdt?=
 =?gb2312?B?QTlmdlhGVkQwTzIrc1FPamZHQ091Qmx1UW11emhpcDh2b3RmTmhua2QvSWxX?=
 =?gb2312?B?OHZEU3dXclFFWnZkSFVxeWl1YlU2OHJGSGIzbGZBOUc2Q0ZpcGJwcDRZVWxC?=
 =?gb2312?B?QUJFa1lwMEc4ZGRoWmZNaXVjUFlpRjRwQ0lMUzJENjUvOWV6TEhOQVEyakpT?=
 =?gb2312?B?QjJpc29kZ3UrZGllQUlDbXBmaVJmaStJVjB0ME5jUWpJTmgzMkVmVU5rK0kz?=
 =?gb2312?B?bUVoY2Z5RklVd1pzNzFjUHdpKzgyTHI2ZWs0MlR3M0Zma095NENlZmxJTVZB?=
 =?gb2312?B?Y2JFNlF0VzBFN1cwVXlZemNRM2NlSEFSZ3dEblJsQ1FoU2p2a1p1OC82Zld5?=
 =?gb2312?B?dG42QUZvaEZTYVFMU2FuU0F4cGw2OG9UK21sWW5jaVdyZkZGQ3VyWGdadElD?=
 =?gb2312?B?TWx0a0gyNEJRb0hWMmJRdTZxL2JBWjFvUUpydlIzNzVpVlZ6NFFwVHB6b3R2?=
 =?gb2312?B?NFdwcE1xVXhPTXl3MkU2SGpNWHZjK0IxU3RUT0JQQi9pZWp2SUgyRUY1aFFR?=
 =?gb2312?B?UVlyaEJub2dUVU4yeGNIemJocUpJM2JpYUFmbXBhV2ZPdWpJYlhhbXhqVE1z?=
 =?gb2312?B?S0FLMWJKcEt4N2ZxN2VCVzgweTFMTU10emhSblVTTnB3WmFMSHA3WkpjTDBt?=
 =?gb2312?B?VGNNaVVBTUp5ZlhQOWQ4ZFVnNUFKaWJsTW91R1IwVmpIekdmdlhaNUsvT3VF?=
 =?gb2312?B?bVpQd2MweDk2YThyTG1VZHdMaHFzMGh5L3UvQWI5bUJ5dlhrYnpxdVZrcXQy?=
 =?gb2312?B?NzFwVXBxS1JUTXhUNFFZeEZkd2JrRTduaXQ2OXpiTFFGSVlaekpjWk5VQ1Zm?=
 =?gb2312?B?NnQwZm4wSnpWVnFRTHcrL2R1WnZOUWJmSElVTmQ4Q0xBc084T09TNGVHTXVQ?=
 =?gb2312?B?UlNpaHZMYzE2Z0FnRCtEZEtXV2VYRUgzcFJiYTQ1TFg3NFVqSzVPcVJYd3lz?=
 =?gb2312?B?bytBS0IxOE1oOUFqTWd5eDduSlordThPOVFZL0kvMGZ4L1k3RE9vZjVPL0pD?=
 =?gb2312?B?YzRKdVlCWWlHWWhVQTc0c29kL2dzaW1mZ2RqK1JOYkR0dDNZbEp1dVVWcWRD?=
 =?gb2312?B?dlNIQWQ2Ri9DT1JDVkk5RVpGc3ZuZ0tPK3BNcnp5anAwbnJDQk9IKzFvL05V?=
 =?gb2312?B?bldsbStOSDRUMTd6cnp3N09nMnR0MHE0c1BBazZRT1FuTGpmMU01YlBtdU9Z?=
 =?gb2312?B?VnZab01DU29NRWh3Tmk3WExyM0NBSXdWQ2d4T0JzakJiajBpWFBIbjZuc2Zw?=
 =?gb2312?B?MWpuQVhsQXlYVHRTQWlPYTBGeXlsNXlaUjd0ZE9vVHp6cnhOa0R2NGF1OVlw?=
 =?gb2312?B?cys5bE9pM0hsQW5qM2tLbUxQRVRueldXSElLZXMxcFgrNjlNaXMvVXc2MzFj?=
 =?gb2312?B?K2tpUlBUeDhGOXJWZzhMSFpXSEQ4SDdrZWgvVGZ5clFnMHN6MjFxaExrWXlk?=
 =?gb2312?B?VzRYNnhCZWQ1SllreGNURWFmcmJpZnl2aEt0MkVzWEpUb01YdlA5aUxaNm56?=
 =?gb2312?B?UDZaMXg4OVhGa3RPMGlsL01wVk9CUXkvckIxckJGL0lrZUI0M1YzRDJHQWVr?=
 =?gb2312?B?VW5jZkxRSmlkWDBWWWJDT3g1SXA4encxcW9ORk5zN041ajFDWkNRcVpmbDRE?=
 =?gb2312?B?dUx3cTA1cVkvaGVvQjNhSlVTSjJiMVc1QThyNHE2RWpGV2diaHJkMHNMenFH?=
 =?gb2312?B?dEJneTY0aWlwN2w5VzFTZkduYkV5SFJ3bzRCcWFGMktXc0hVdk15S3liaUFE?=
 =?gb2312?B?OWxieXZ6RzhtaExNVHVKVGdJUGhmNDNhQUFtQ0djeWZOemFwakFpSEUybGMr?=
 =?gb2312?B?RlNDcmFmYS95LzJmYjFMekIrWGlvZldCcTZELzdjM1E4OXJRR0ZZSHlkRkhr?=
 =?gb2312?B?UGtYdGVwMHJwVGNmRWszNVUwK2ZyTlp3MEtzNnRhOGxKd3FleE44VU5hbk1i?=
 =?gb2312?B?blBtR2ZwZzJ4Y1FBb2JUNG93Kzc4VE1RQVAvcEZjRVErUVpOT1JiR2d2eEwx?=
 =?gb2312?B?OUtMbEMxSTgySDVyODVtemd4clE0RnZNUTAyc2hkS2JTMUtZOFkwZDlsVjR4?=
 =?gb2312?B?V2c1YWtnT3pGc1RBQjh1VGhTTGtNK0RXcmNFb3NFTFo1QldUSU1xQU5MOHdx?=
 =?gb2312?B?Zm80cy82aTZnYkFTV0dyR2k3VGFNUnBnVmh3d2wxQnRadjZRdWxjOURkczdG?=
 =?gb2312?Q?ivnrO6ZF6t11FS/t9n?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9555ad-f727-4e51-64c3-08de8499da3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 02:55:45.9483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWifYhyKVKExGavmIp1gJAoYtGhPkjZ8fYzDYVD/ibbvAodmm1uiI1qVtGlqIjfPIlW1qXmGLt7en3Adb1ctzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11980
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226952-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,pengutronix.de,kernel.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email]
X-Rspamd-Queue-Id: AFB682B5620
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjbE6jPUwjE4yNUgMToyNA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gbWFuaUBr
ZXJuZWwub3JnOyByb2JoQGtlcm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwu
Y29tOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MV0gUENJOiBpbXg2OiBBZGQgZm9yY2Vfc3VzcGVuZCBmbGFnIHRvIG92ZXJyaWRlIEwxU1MN
Cj4gc3VzcGVuZCBza2lwDQo+IA0KPiBPbiBUdWUsIE1hciAxNywgMjAyNiBhdCAwMjoxMjo1NlBN
ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgYSBmb3JjZV9zdXNwZW5kIGZsYWcg
dG8gYWxsb3cgcGxhdGZvcm0gZHJpdmVycyB0byBmb3JjZSB0aGUgUENJZQ0KPiA+IGxpbmsgaW50
byBMMiBzdGF0ZSBkdXJpbmcgc3VzcGVuZCwgZXZlbiB3aGVuIEwxU1MgKEFTUE0gTDEgU3ViLVN0
YXRlcykNCj4gPiBpcyBlbmFibGVkLg0KPiA+DQo+ID4gQnkgZGVmYXVsdCwgdGhlIERlc2lnbldh
cmUgUENJZSBob3N0IGNvbnRyb2xsZXIgc2tpcHMgTDIgc3VzcGVuZCB3aGVuDQo+ID4gTDFTUyBp
cyBzdXBwb3J0ZWQgdG8gbWVldCBsb3cgcmVzdW1lIGxhdGVuY3kgcmVxdWlyZW1lbnRzIGZvciBk
ZXZpY2VzDQo+ID4gbGlrZSBOVk1lLiBIb3dldmVyLCBzb21lIHBsYXRmb3JtcyBsaWtlIGkuTVgg
UENJZSBuZWVkIHRvIGVudGVyIEwyDQo+ID4gc3RhdGUgZm9yIHByb3BlciBwb3dlciBtYW5hZ2Vt
ZW50IHJlZ2FyZGxlc3Mgb2YgTDFTUyBzdXBwb3J0Lg0KPiA+DQo+ID4gRW5hYmxlIGZvcmNlX3N1
c3BlbmQgZm9yIGkuTVggUENJZSB0byBlbnN1cmUgdGhlIGxpbmsgZW50ZXJzIEwyIGR1cmluZw0K
PiA+IHN5c3RlbSBzdXNwZW5kLg0KPiANCj4gSSdtIGEgbGl0dGxlIGJpdCBza2VwdGljYWwgYWJv
dXQgdGhpcy4NCj4gDQo+IFdoYXQgZXhhY3RseSBkb2VzIGEgImxvdyByZXN1bWUgbGF0ZW5jeSBy
ZXF1aXJlbWVudCIgbWVhbj8gIElzIHRoaXMgYW4NCj4gYWN0dWFsIGZ1bmN0aW9uYWwgcmVxdWly
ZW1lbnQgdGhhdCdzIHNwZWNpYWwgdG8gTlZNZSwgb3IgaXMgaXQganVzdCB0aGUgZGVzaXJlIGZv
cg0KPiBsb3cgcmVzdW1lIGxhdGVuY3kgdGhhdCBldmVyeWJvZHkgaGFzIGZvciBhbGwgZGV2aWNl
cz8NCkhpIEJqb3JuOg0KRnJvbSBteSB1bmRlcnN0YW5kaW5nLCBMMVNTIG1vZGUgaXMgY2hhcmFj
dGVyaXplZCBieSBsb3dlciBsYXRlbmN5IHdoZW4NCmNvbXBhcmVkIHRvIEwyIG9yIEwzIG1vZGVz
Lg0KSXQgY2FuIGJlIHVzZWQgb24gYWxsIGRldmljZXMsIGF2b2lkaW5nIGZyZXF1ZW50IHBvd2Vy
IG9uL29mZiBjeWNsZXMuIE5WTWUgY2FuDQphbHNvIGV4dGVuZCB0aGUgc2VydmljZSBsaWZlIG9m
IHRoZSBlcXVpcG1lbnQuDQo+IA0KPiBJcyB0aGVyZSBzb21ldGhpbmcgc3BlY2lhbCBhYm91dCBp
Lk1YIGhlcmU/ICBXaHkgZG8gd2Ugd2FudCBpLk1YIHRvIGJlDQo+IGRpZmZlcmVudCBmcm9tIG90
aGVyIGhvc3QgY29udHJvbGxlcnM/DQppLk1YIFBDSWUgbG9zZXMgcG93ZXIgc3VwcGx5IGR1cmlu
ZyBEZWVwIFNsZWVwIE1vZGUgKERTTSksIHJlcXVpcmluZyBmdWxsDQpyZWluaXRpYWxpemF0aW9u
IGFmdGVyIHN5c3RlbSB3YWtlLXVwLg0KDQpSZW1vdmluZyB0aGUgTDFTUyBjaGVjayBhbGxvd3Mg
dGhlIHN1c3BlbmQgcHJvY2VzcyB0byBjb21wbGV0ZSBzdWNjZXNzZnVsbHkNCmFuZCBlbnN1cmVz
IHRoZSBwY2ktPnN1c3BlbmRlZCBmbGFnIGlzIHNldCB0byB0cnVlLCB3aGljaCB0cmlnZ2VycyB0
aGUNCnByb3BlciByZXN1bWUgc2VxdWVuY2UgZHVyaW5nIHN5c3RlbSB3YWtlLXVwIGZvciBpLk1Y
IFBDSWVzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiA+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnDQo+ID4gRml4ZXM6IDQ3NzRmYWY4NTRmNSAoIlBDSTogZHdjOiBJbXBs
ZW1lbnQgZ2VuZXJpYyBzdXNwZW5kL3Jlc3VtZQ0KPiA+IGZ1bmN0aW9uYWxpdHkiKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyAgICAgICAgICAgICB8
IDEgKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9z
dC5jIHwgNCArKystDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS5oICAgICAgfCAxICsNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
aW14Ni5jDQo+ID4gaW5kZXggODFhNzA5MzQ5NGM4Li43OTAyZDM5MTg1YTUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtMTgzMSw2ICsxODMx
LDcgQEAgc3RhdGljIGludCBpbXhfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+
ICpwZGV2KQ0KPiA+ICAJCWlmIChpbXhfY2hlY2tfZmxhZyhpbXhfcGNpZSwgSU1YX1BDSUVfRkxB
R19TS0lQX0wyM19SRUFEWSkpDQo+ID4gIAkJCXBjaS0+cHAuc2tpcF9sMjNfcmVhZHkgPSB0cnVl
Ow0KPiA+ICAJCXBjaS0+cHAudXNlX2F0dV9tc2cgPSB0cnVlOw0KPiA+ICsJCXBjaS0+cHAuZm9y
Y2VfbDJfc3VzcGVuZCA9IHRydWU7DQo+ID4gIAkJcmV0ID0gZHdfcGNpZV9ob3N0X2luaXQoJnBj
aS0+cHApOw0KPiA+ICAJCWlmIChyZXQgPCAwKQ0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9z
dC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9z
dC5jDQo+ID4gaW5kZXggYTc0MzM5OTgyYzI0Li43MjAxNTRmZDRmZjAgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMN
Cj4gPiBAQCAtMTIyOSw3ICsxMjI5LDkgQEAgaW50IGR3X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1
Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJICogSWYgTDFTUyBpcyBzdXBwb3J0ZWQsIHRoZW4gZG8g
bm90IHB1dCB0aGUgbGluayBpbnRvIEwyIGFzIHNvbWUNCj4gPiAgCSAqIGRldmljZXMgc3VjaCBh
cyBOVk1lIGV4cGVjdCBsb3cgcmVzdW1lIGxhdGVuY3kuDQo+ID4gIAkgKi8NCj4gPiAtCWlmIChk
d19wY2llX3JlYWR3X2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ1RMKSAmDQo+IFBDSV9F
WFBfTE5LQ1RMX0FTUE1fTDEpDQo+ID4gKwlpZiAoIXBjaS0+cHAuZm9yY2VfbDJfc3VzcGVuZCAm
Jg0KPiA+ICsJICAgIChkd19wY2llX3JlYWR3X2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5L
Q1RMKSAmDQo+ID4gKwkgICAgIFBDSV9FWFBfTE5LQ1RMX0FTUE1fTDEpKQ0KPiA+ICAJCXJldHVy
biAwOw0KPiA+DQo+ID4gIAlpZiAocGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZikgew0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0K
PiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBp
bmRleCBhZTYzODlkZDljYWEuLjUyNjEwMzZiYmU2ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ICsrKyBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gQEAgLTQ0Nyw2ICs0NDcs
NyBAQCBzdHJ1Y3QgZHdfcGNpZV9ycCB7DQo+ID4gIAlib29sCQkJZWNhbV9lbmFibGVkOw0KPiA+
ICAJYm9vbAkJCW5hdGl2ZV9lY2FtOw0KPiA+ICAJYm9vbCAgICAgICAgICAgICAgICAgICAgc2tp
cF9sMjNfcmVhZHk7DQo+ID4gKwlib29sICAgICAgICAgICAgICAgICAgICBmb3JjZV9sMl9zdXNw
ZW5kOw0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0cnVjdCBkd19wY2llX2VwX29wcyB7DQo+ID4gLS0N
Cj4gPiAyLjM3LjENCj4gPg0K

