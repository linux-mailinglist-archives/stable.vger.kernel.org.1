Return-Path: <stable+bounces-231246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFC2EumVymkR+QUAu9opvQ
	(envelope-from <stable+bounces-231246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:25:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85AA35DC69
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18EC1301FCB7
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624E336EDA;
	Mon, 30 Mar 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="QGXgUM4M"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022140.outbound.protection.outlook.com [52.101.66.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C073334C05;
	Mon, 30 Mar 2026 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883117; cv=fail; b=UykjlvD+UpfM4b4T8FJxMKdHKM/0ctc+3QZ9RaylrY126IbWJ+Arz0Eh680W4Kp2/IjXMSv2D7igF1z0VEl21YA4pcOdDH1hkRE3qHve/MzQTMBA8cgLE+OPBW2WtnPivu+6ehwQpxieKRjT0kWsYLZsiXCmcJ6jSZo0jXJTyaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883117; c=relaxed/simple;
	bh=lF9SVCHj/EMo9LnMnAZkcOK9dwZBfnHtGDvFkmwWJVE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dwHMbq1wkjDedbAM2EDdtRMlhgbkNikRygN0e28hbSgZlN7IprBglfSHVIO7PsS5Ph0L3xW35RAnJaoqpQnnfyA8vVXdljoSXtmsECvs/qb3gJhc+nFUa/hhXVCr1z2fU/AG6yiH8c5qWjubS95Fo1Z5iScSqOici3j9jY6WIdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=QGXgUM4M; arc=fail smtp.client-ip=52.101.66.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCRvaT9AHj0iiXAbH9eaLaAusJrqdq03K8P2HvixlfM9Qfzu7ZR/0hRVtgCx2TWyyo+VVeo3MSHrhKbMIaBQIE8UJiiUo7c9xquwu6ZOES3xxMhPcaKJh6qAVNdsfUvdKWWlGHwViekNbyjfTdTd3bv99U6VikOBq919jX56NWpNg/0ZwSrkRJyBgqLsjCRz4MwhHw+jbkql0ffBvZ4BBP9GWgyCnPxUtXAsfIA30zIRnXST+cMekA3QfLgfG5dOMu+uLCpL8bY5T43FSw7/XgdnX2F1+cgvE/k722GJRXctRY8Kl3lnq5SpU2yw/lwW/NEPBh03oT/czmADib1gAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lF9SVCHj/EMo9LnMnAZkcOK9dwZBfnHtGDvFkmwWJVE=;
 b=GXmDqt5XB3aTFdD7/7mfBPYHM+lcAA02LoqyyjGlHUymcdTPhoaknbmxAh864PG4xBtm9d1MLoVrTuBFHTtmUs21zP49NRsxxFVvTAE1eIXeyYxyHVdN7ii9FVjzUtL+XHBgGIQi0AHPDS+/yp1qpCChQZqWgTec39s7fZOLAxPYpJN0oMIuCECq9udNlrC5DXRrEcBqA4ePeE8gX2ejw4rquBFQfpkc6IDF4mRICqydXfY9COSpRu3vXYEyLaYK0Rjv/rDF2SDViPjlGUZQ4al/liL46mCY0bRUTMPq40/RtlGTVKLiozkSBNhOixFf0aAHJYiU0R+Js7/lR0LOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF9SVCHj/EMo9LnMnAZkcOK9dwZBfnHtGDvFkmwWJVE=;
 b=QGXgUM4MkepAU1TnkMEEtDfgUPPcsYP8uUAQtlT/wCnZzvHJLZJVcVRvDnFd/tfLXpG6RcNy9mFKsj4HbQ4RAVw8kj9yuVGxuLFLMeUHK5VpPZsEurgr1CovBWbznEf3N7THn/ONC1bvpED4OfgsMy0SrNsk80f1MEZYqOuFPP25X5P1JPKENSwirlpeAWXfI/bkMndO86HVqgZ400W7Y8Fapj6zyjOQy7TFbaN2Nzo1VZErnZ0+gIRLr6CDizXmFxKZpUHzDTe45Y7EMTzwV6WAkOW3LMqU3IP32ufe0JfoTfGf2mGCE5mc3fy5vYgeTbUJGW6EnRFi9bzpBA54mQ==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by FRWPR04MB11103.eurprd04.prod.outlook.com (2603:10a6:d10:172::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.27; Mon, 30 Mar
 2026 15:05:08 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:05:08 +0000
From: Oleh Konko <security@1seal.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "jmaloy@redhat.com" <jmaloy@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net] tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
Thread-Topic: [PATCH net] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Index: AQHcwFaZgpnD0jkjNUO+2TpEMAczLg==
Date: Mon, 30 Mar 2026 15:05:08 +0000
Message-ID: <043673b8636b4f60a52589330cb55e83.security@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|FRWPR04MB11103:EE_
x-ms-office365-filtering-correlation-id: f33fce6f-b59d-4ea0-4e8c-08de8e6dbbd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|18002099003|56012099003|7055299006;
x-microsoft-antispam-message-info:
 +Iy/HMm0YvLO2Pc4gSStmpKG5a6YoezapfZt2u+V2N2MEA8nZ/a2bD1oNJdziQGRBUgjuJ+dVpDhOa5DLZ5POU8tlF3D+BjEl6wodBRW0gwgveRnV9w5MAr+KJ7jJUcIoXUMBw4fuw73HHTmzcx0h7cLz3T2T5ia+5bPyY+6w4oZxoIYhdgQpQCdD3M6O0UCAPbd80BGwa6mkXtfaqflV/83f/3ucvR31P+yI5QWpgiRsf+ABHZJ812UiMrF9mnsIadmnJWOyJ6LhktCqv3h6pfYh6oXy11WGFAD0YHjom1nD9s6X004CERkuQpFLyFpU1McvNUVmGllqd+WDSKe7/NKwQIH+W2IF8NbigC3ziSTphB7mjooYmcOS7qusGZXPUu9uVk92ONli7rLn983/QKg3AE6nyaOObcUd9fzfaoZfTcAoEdB6aNEnw/MiYEeFliAowsYpfg8SKFwU6vMRMkagxGFzgu+CR/M2Bu8vS8ALpPYUnr71fP8ipvVKCn2s0SniClXa9Nupw15G8RMPWqX573HoXlH+1QT3EC/9oGHGUKs8KLzUo3VJwnJVKliIFGRHqFpEdt0AzaS/ZCPs+xbc19wmWQkecnkESffoJ2R1B0aHAVI+3abR9fN06iDMZNuonTLHTfv0mV43M7UGgvxusdoNHAE+Q+IowrlF3CmRV4r5+S5gh+ExptNnAD38gdRIWfpGObv6O44bVrAqHU3ciJ7WfORVZ6ynOyzDe1HGz6tw+kNRxIPQxkKuJp/1qMPXiEsqqjx2rn34w3WnlcfYIxSPl7towoAV14Md+MDZAi3S4tg9Hx8/jNPioLz
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0NSWTd5ZE4zc2hhTzNHaVplVG04L3REVERkQnE4VGFnMFRCMGQxTmozWHJi?=
 =?utf-8?B?ZHpYUzI2R1dRaUx1azVtWHJuTkVWTEpKTm1EYmVDR3NJaXViQ1Y1NXZOcnlp?=
 =?utf-8?B?dnhUbTRvQ1VBd0tHR3pkaUNHZ1ZVYitEQjNhVEg2SnA3bjMreHZWYUdxdmNa?=
 =?utf-8?B?aC9rZU0wUXZ2YTdlYjUzaFhkLzNuZHZSd0JjRVB0cVFPd2FUaUdHalhtdGVV?=
 =?utf-8?B?dXEzVFRvV0FGYVc1Mkx0ZlgxUjN4a3RtMkJwMTI0VGVEVGk5U0J1T0x0bG5m?=
 =?utf-8?B?UVNxUXRUTHRlU2U2TG0wSHBWeXFvT09mci8rNUJDeHJUWjlJU3NFdTBSZTFX?=
 =?utf-8?B?dlBJY0tiRk5yM3o0QU5QYm1VQ0hpYnhRS2p0eUpRWHdmRFk5Z2dPQlJlV1hM?=
 =?utf-8?B?VDBDb2loTDBLbTY1Q3JwT3Q2TGNubDBMa01mOGRYQ2RwRlhCSFFCRHJVZ29y?=
 =?utf-8?B?V2dyRkluWFpHNjJVVXczVkZ0SWVLWmJLZFY5QVJwcFBteGdWU3RHZ09HclY4?=
 =?utf-8?B?R2dZUGJGTThrQ2dDanRlU3pWSm1EK1V1WUZmbFFXVHEwVzVsUmY3MjFyQUFw?=
 =?utf-8?B?bXB5Nk1xQTh1ZittL1c0bE1KZU11QkN3S2JES2htVDFnUXBQWS9ocGVSNG1i?=
 =?utf-8?B?NXYzWDFDSldnV0ovYllidmNXSUVQTEx1ZXYzaks1M3RjeGlTVEdsdGRFdlRT?=
 =?utf-8?B?N2wxZ2ZDaTNQRW9MenQ0Kyt5b1VPM0dnWFRXR0NQbmpqWGdEdmZLUWNiaHgx?=
 =?utf-8?B?Q1NKU0IwYXZpK0xXU0E3ZmNmNEVaRFNBUlFMWXd4ZEtTWExTQ2dUR1VTUkxm?=
 =?utf-8?B?d0FJc0JoYWRsaWpGcVpydzVnMGdFVWxzaUFnK2pLOEFmVGc3V3FkQnExSzRG?=
 =?utf-8?B?QkJmc3crdi9FUkhwZVlCaEJaR29YSUlUNXFoRlNURGZ4emtCcFJyNlZ6T2RP?=
 =?utf-8?B?dDFMVDRkci9PeVYrUGRaU0F2VmVxbTZ2MWlQVHE5SkppMnJwaXMwYzRnNjcv?=
 =?utf-8?B?dUVIQVBRYTE0ZWd0MkdqcHBReHNXT25UYmlpNzRoSVhwdnhZdHUyaDV3UjJK?=
 =?utf-8?B?NmowVllKWmErSDBRVTlRbW1BU0xTQk5uWnlkTEpCdFIwVFQwbnpyTFJrRThi?=
 =?utf-8?B?aUxyaTNIdUN2cGVBZHExNS9YYmxaQ010bzlUWU56bm5ULzdleWJIQ28wWUtV?=
 =?utf-8?B?S0RZRWpwcDZUQ1cyT2NuTkk0WHFXSjNSSkw4UGtPNHV1eDJueEFMMG1FNmFn?=
 =?utf-8?B?aGQrTzUwaFFtcUtVSVE2RE1YZ0tMUEFtVityRTJwaGtTUXIva3hCOHM2Yzdk?=
 =?utf-8?B?TnBDT0FjNGQxVzgvRWR5WmNYSzgxOTBYUXUzTzExM1o5VHVnSlNDMmFqeFNm?=
 =?utf-8?B?QzI3Z1h6TFFBRTRCdldNZSt0ME9qbHVZTDN5MW9NdENEbkpFdnpUYWVtTVk3?=
 =?utf-8?B?UDM3d3MrTHljMVh5Q2M5R2NWc1RLYjBQNXdoUWZXQU1TOUtOajNTM2NkNTlo?=
 =?utf-8?B?TVZUKzhoOFIyUG1zaVpLSUNNVnFsNGxoU1Q1Y2h1aFVJRkxTQVpsU0xXS1dr?=
 =?utf-8?B?OEtqVjdvOWIyc1Fsb0ZpbnJ0Wm9WNWxkSHJwMk5pZWRmVEcrc2hpc2dWS2FH?=
 =?utf-8?B?VzBNNXNselJIRVluQU4zRFM1YlUzbEsxT1NPSldHYnhLWWRJTHovWU16L01p?=
 =?utf-8?B?eHBJVFZUcmdDaWtjVXdlRk4xWUF0d0h1WDh4b0s0OHhpOVIvZkZhQ0xHMjVU?=
 =?utf-8?B?VWU5czM2K2x2VG5yemZDQlNzSjI3UWtDb2pxeEJjZkRCVTlYMGpjSWpYanh3?=
 =?utf-8?B?U3NabGNqemVRaXRMQjJaRW9BeWJMdzFEWEZUcXpIVzFDNUVpNnhCamRqSlVi?=
 =?utf-8?B?dVpOU00wS0FUcXk0QW5WOGszc0E4Q21kQXVYRkRtUnlvMHcxTjlpTElTcytX?=
 =?utf-8?B?dVVKaDZPb3RacGk0VU9qOUFWMzZRQTFTWWcwNnJmQjcwb2hZbm8wTEk3WXYr?=
 =?utf-8?B?WjJoYlVtUW5WaXU1Q0VkVkRFdGZXcjN3SVhrMlo5a0MybzE0SERJcnpkV05n?=
 =?utf-8?B?cjVBaU5kemlQL1grd0kxWHdBL2dMTElRaEU0MmI4MUpaUENhU21OWHBReTcz?=
 =?utf-8?B?UG95U0dGNlFKcEpxRVFvcW54RVM0TldoNTVoUzN2QnltRWFwR0FySTMxeE5m?=
 =?utf-8?B?NVc4RjdGQ2Y0azZjbGR0M29qMTdHY0czckZBblY0MFNKQk5nU1AvWDBhWTVy?=
 =?utf-8?B?YVhHTnVKNXoyYnFqM3pMWTJ3Q0svQWhNVitrS1A4SmVZenloQmg3RlJkYm1M?=
 =?utf-8?Q?S1avI+MjTGGB1gLsR/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D24E1824543384287F3B9822C5DB3A3@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f33fce6f-b59d-4ea0-4e8c-08de8e6dbbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 15:05:08.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dix0V0QLU6xnSqCLJN1oU4piq2c2pStsS3iK2yuTOyD8OrUwryCxW/udOJ8hHTOUAgdr/yiGm8o+Dyxi72iqlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11103
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[1seal.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[1seal.org:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231246-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[security@1seal.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1seal.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1seal.org:dkim,1seal.org:email,1seal.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B85AA35DC69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhlIEdSUF9BQ0tfTVNHIGhhbmRsZXIgaW4gdGlwY19ncm91cF9wcm90b19yY3YoKSB1bmNvbmRp
dGlvbmFsbHkNCmRlY3JlbWVudHMgZ3JwLT5iY19hY2tlcnMgb24gZXZlcnkgaW5ib3VuZCBncm91
cCBBQ0ssIGV2ZW4gd2hlbiB0aGUNCnNlbmRpbmcgbWVtYmVyIGhhcyBhbHJlYWR5IGFja25vd2xl
ZGdlZCB0aGUgY3VycmVudCBicm9hZGNhc3Qgcm91bmQuDQoNCkJlY2F1c2UgYmNfYWNrZXJzIGlz
IGEgdTE2LCBhIHNpbmdsZSBkdXBsaWNhdGUgQUNLIHJlY2VpdmVkIGFmdGVyIHRoZQ0KbGVnaXRp
bWF0ZSBzZXQgaGFzIGRyYWluZWQgdGhlIGNvdW50ZXIgdG8gemVybyB3cmFwcyBpdCB0byA2NTUz
NS4NCk9uY2Ugd3JhcHBlZCwgdGlwY19ncm91cF9iY19jb25nKCkgcGVybWFuZW50bHkgcmVwb3J0
cyBjb25nZXN0aW9uLA0KYmxvY2tpbmcgYWxsIHN1YnNlcXVlbnQgZ3JvdXAgYnJvYWRjYXN0cyBv
biB0aGUgYWZmZWN0ZWQgc29ja2V0IHVudGlsDQp0aGUgZ3JvdXAgaXMgcmVjcmVhdGVkLg0KDQpU
aGUgbWVtYmVyLXJlbW92YWwgcGF0aCAodGlwY19ncm91cF9kZWxldGVfbWVtYmVyKSBhbHJlYWR5
IGhhbmRsZXMgdGhpcw0KY29ycmVjdGx5OiBpdCBvbmx5IGRlY3JlbWVudHMgYmNfYWNrZXJzIHdo
ZW4gdGhlIGNvdW50ZXIgaXMgbm9uLXplcm8NCmFuZCB0aGUgbWVtYmVyIHN0aWxsIG93ZXMgYW4g
QUNLIGZvciB0aGUgY3VycmVudCBicm9hZGNhc3Qgcm91bmQuDQoNCkFwcGx5IHRoZSBzYW1lIGZv
cndhcmQtcHJvZ3Jlc3MgZ3VhcmQgdG8gdGhlIEdSUF9BQ0tfTVNHIGhhbmRsZXI6IG9ubHkNCnVw
ZGF0ZSBtLT5iY19hY2tlZCBhbmQgZGVjcmVtZW50IGJjX2Fja2VycyB3aGVuIHRoZSBpbmJvdW5k
IGFjayB2YWx1ZQ0KaXMgc3RyaWN0bHkgYWhlYWQgb2Ygd2hhdCBoYXMgYWxyZWFkeSBiZWVuIHJl
Y29yZGVkIGZvciB0aGF0IG1lbWJlciwNCmFuZCBvbmx5IGRlY3JlbWVudCB3aGVuIGJjX2Fja2Vy
cyBpcyBub24temVyby4NCg0KRml4ZXM6IDc1ZGEyMTYzZGJiNiAoInRpcGM6IGludHJvZHVjZSBj
b21tdW5pY2F0aW9uIGdyb3VwcyIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KU2lnbmVk
LW9mZi1ieTogT2xlaCBLb25rbyA8c2VjdXJpdHlAMXNlYWwub3JnPg0KLS0tDQogbmV0L3RpcGMv
Z3JvdXAuYyB8IDExICsrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL25ldC90aXBjL2dyb3VwLmMgYi9uZXQv
dGlwYy9ncm91cC5jDQppbmRleCBlMGU2MjI3YjQzMy4uNDFmYTdiYjMwOTEgMTAwNjQ0DQotLS0g
YS9uZXQvdGlwYy9ncm91cC5jDQorKysgYi9uZXQvdGlwYy9ncm91cC5jDQpAQCAtNzQ1LDcgKzc0
NSw3IEBAIHZvaWQgdGlwY19ncm91cF9wcm90b19yY3Yoc3RydWN0IHRpcGNfZ3JvdXAgKmdycCwg
Ym9vbCAqdXNyX3dha2V1cCwNCiAJdTMyIG5vZGUgPSBtc2dfb3JpZ25vZGUoaGRyKTsNCiAJdTMy
IHBvcnQgPSBtc2dfb3JpZ3BvcnQoaGRyKTsNCiAJc3RydWN0IHRpcGNfbWVtYmVyICptLCAqcG07
DQotCXUxNiByZW1pdHRlZCwgaW5fZmxpZ2h0Ow0KKwl1MTYgcmVtaXR0ZWQsIGluX2ZsaWdodCwg
YWNrZWQ7DQogDQogCWlmICghZ3JwKQ0KIAkJcmV0dXJuOw0KQEAgLTc5OCw4ICs3OTgsMTMgQEAg
dm9pZCB0aXBjX2dyb3VwX3Byb3RvX3JjdihzdHJ1Y3QgdGlwY19ncm91cCAqZ3JwLCBib29sICp1
c3Jfd2FrZXVwLA0KIAljYXNlIEdSUF9BQ0tfTVNHOg0KIAkJaWYgKCFtKQ0KIAkJCXJldHVybjsN
Ci0JCW0tPmJjX2Fja2VkID0gbXNnX2dycF9iY19hY2tlZChoZHIpOw0KLQkJaWYgKC0tZ3JwLT5i
Y19hY2tlcnMpDQorCQlhY2tlZCA9IG1zZ19ncnBfYmNfYWNrZWQoaGRyKTsNCisJCWlmIChsZXNz
KG0tPmJjX2Fja2VkLCBhY2tlZCkpIHsNCisJCQltLT5iY19hY2tlZCA9IGFja2VkOw0KKwkJCWlm
IChncnAtPmJjX2Fja2VycykNCisJCQkJZ3JwLT5iY19hY2tlcnMtLTsNCisJCX0NCisJCWlmIChn
cnAtPmJjX2Fja2VycykNCiAJCQlyZXR1cm47DQogCQlsaXN0X2RlbF9pbml0KCZtLT5zbWFsbF93
aW4pOw0KIAkJKm0tPmdyb3VwLT5vcGVuID0gdHJ1ZTsNCi0tIA0KMi41MC4wDQoNCg0K

