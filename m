Return-Path: <stable+bounces-232962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJi/I0Y+zmkImQYAu9opvQ
	(envelope-from <stable+bounces-232962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:00:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D63875AB
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E8473131A56
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300953DD53F;
	Thu,  2 Apr 2026 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="pWguNNmu"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023112.outbound.protection.outlook.com [52.101.72.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16D3DB656;
	Thu,  2 Apr 2026 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123349; cv=fail; b=sSpI3jm9uQUSJHLDJgOxbpmwtmxGuMLdysCJaZqZhKuT30wAnRtTFhG/1awULwmgsdhXcnCfccNeh/8V09Ou5+yzBglNMwKdWlW5Rq2l6j7Iujvbb3XcCBJdCU+PcQt24fJjlAq0BGsoCt0n/4aTJT5VK5IKxu0hulzHGOSs7Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123349; c=relaxed/simple;
	bh=NFsMN/9SRNeRDz5bO9jieNZg3HkaVU+Yun35SBztXnA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jupgmp6re23TM+2eE6V+AUJBDDffNDtYZUoNDqSzi+OGZKKsOSdlW6x7m58LTpn/GXxU8O5vlSCAzs/Vio23B3EgS6rM+D2OHLrdT4X7f/KW5IFyTjLnLmw6twpxnQLKvr0TSfYWnhkqlJwwsYIvleD5sRWGVlDSlGL7RfbDkaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=pWguNNmu; arc=fail smtp.client-ip=52.101.72.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uL8OIjIbuEdAejJmiwp6yjD7UQnbgPMEGmcdUSmI47bfjVOGNyQ2bkxFCm+tIc4BhHAl88XFlA12EHSesvGHHLvCaqUc58o7yzYYTnv5+bPChYCCCXL0cPu4YBAYgfAHbOWCdKkGgJrP8ui3Wj+H8X2lveH4xcE187R2hIDtGtz5fZHZGhHEmmAr4S/xwXLBkPL+DpdkxDsCaHdOr22yFlwh8nr8fyeumMqxSq6BN2oQqNxVFXvHBa5UG7RYOkrwL9uKCBWNhnJ6iMGQA9anTx+1uv/dGFrdBTaBJRJxf9V6GJmdrdFZrKrzxcJgrEQUPF94L/jqcNiKWRcsllCvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFsMN/9SRNeRDz5bO9jieNZg3HkaVU+Yun35SBztXnA=;
 b=PD/MI+P3TtWLxyKxfGypbrTJSUqG5U9kludborJXicgpXV2i5O8fYKzYkoyoffhfVh+gCT0pSEv8uUTaqMhgyEP4fCmnGUExtrBKhC6AhfkYDPH1RRnSsOQDMrk05QJYD1TW5qXo8cJlxl9Er97hK6ocxxD2U53rpd7R1Noi6qSn33Gyy/rEzN1sKWh792r16DA6xxGhrKhWaOAOCm0SlpokKsl3zXx5Xm43kFGwiu2qurwXTtNlyBNpTtpcikUuDdzID9Jzbx+AHicIJsukizf9HypkpEEPRBJ4ygpdY1EroGf2lARAjfSX8Jnat5ThhKy8WHlMWJGqNAXkl903Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFsMN/9SRNeRDz5bO9jieNZg3HkaVU+Yun35SBztXnA=;
 b=pWguNNmubCHiz/U4lg5dqQsQ72sCDTd7eZPwO8ax8yJacBTUnW3WFE0gcE0nXn4yhMTcD1wbNJhVQ6wm5l68YzCJ2r8VK6RKLLwzXbZq8E+S8tFTosH762R02Ifhxo0PnUUlN272DghHuJKoEwtR3MgSuYK/rzYchm/hU/SeFXXMKGC0l9a3fPMmYrpUSM8ei3pcxyzH8wAqpnLiXqVw95YWB8r3Z1jnvmJt8EgorGi7P8dM9nm1hDpyGpEbQwi/+1hznYfruPw0Q3thOoaTFVnajTmk4F1F2/ViEW4Ql8CamcorA+znwtcFqYa6TxMfPmUG02OU0PjdgonyfipGYQ==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by AMVPR04MB12651.eurprd04.prod.outlook.com (2603:10a6:20b:773::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 09:48:58 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%3]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 09:48:57 +0000
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
Subject: [PATCH net v3] tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
Thread-Topic: [PATCH net v3] tipc: fix bc_ackers underflow on duplicate
 GRP_ACK_MSG
Thread-Index: AQHcwoXtbgM45gO9AE+JdR/jF4ztBg==
Date: Thu, 2 Apr 2026 09:48:57 +0000
Message-ID: <41a4833f368641218e444fdcff822039.security@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|AMVPR04MB12651:EE_
x-ms-office365-filtering-correlation-id: 248002f7-c58d-4c0d-e94e-08de909d0f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|56012099003|7055299006|18002099003;
x-microsoft-antispam-message-info:
 tTc2VIxCrINzSNqqqq9SrEdIVp5hz3SW4fsnnk8ZzhFw+IxJIrAQfvgTXUOf2DWV9qxSwKjrON2WomfptXHf0E2y7Yv+B+EuN43EiDqcshHRLe5HsAkmYZomGT4L/lShaCb80OmmYNsNKbor4sukkGlOVo4taecMHMlW/2AMRzSX8ubwa7mGooWZoLGp3MYjThLkRC/dHLnkHe8eHWfuM8f+VE45CacaZrsqdbQtfeHMF4+i3Xl9usgk/vCjt/nLTcn1loVQyUCCQUdkLNimAc4Cj/nOUIxAXwtM4qwoElfPOF7RdVmCfUBK4XWDRcR8iDxjZC2SCOiIliiHro8Wexfhi49Q75uMBJ2P25SEL1e1706brQny/P98aasQEdvE5bKy8MdwGTH+oXP2zF44XU2e7s/3ClycKnzm1Uk9lS8FyrRtdvNdfNc2TjddapF3h4tlpFx7uua+zgfC4xVVyIkzISQMD69s64+OIQu95sxpVU+coVelf4B86Msv/GUK7K0wI3LQ/ABiAkXnVryYVCQe2v35KIWEDTQYoo1+6iz4X3inRtjg38JGaW08w4EACITGo+4ddineuT3uDA47Zh8F4YXEYAKvb7KegELW2f8kspJdywwl6YHwTKkbBhC7oZiiVLx4jJziwa9ISRR0LYNjYT5AQF9V++Ldzw/+AfgLp1sTpyQY79Wwf2aa7x8k+8eoxiEthtTkPPjmD516KPszCtnMzy43tNN9F+3xpfJXngfvZrNcbdRs/m/JjlTX5hyRVjtbuBu5hz26HAmsXq4LxtciKX0AVJmO5gB94UyXnx1xXidM72+YpYKprHBb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(56012099003)(7055299006)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW5ON3A2cm1tcnhITUFsMzhYNEVZT1NWMFB6V2ZxNkpZRDhxcTdSeHZPSDRm?=
 =?utf-8?B?UlJuUDZnN0ZOdklTMENIaFk2VzlEdXNHSHdqZWlxWCtiZUVTS2cvc2RGSmtv?=
 =?utf-8?B?UDdoNTRSRVUrYnNLNUNERTJLalprS3pzRHhpSi9Ub20wandUNWhMTUovU0lx?=
 =?utf-8?B?RE8rU3lBTTZQaUE0MDB0RllueXNrYzN5NjhsMXlUei9FUUh6eHV6OWU4Umdn?=
 =?utf-8?B?K3FuZHYweVRTSnU2a0tONGNLbHRWRWVXR3FPdG96OWgwZm92VzV0ZzdGS1dX?=
 =?utf-8?B?alZWZWFTU09TRkYrcEF4Wlk5b3lYTnJVcG1pUk9UbWYrdnF4MnhFVG91SDRw?=
 =?utf-8?B?aTdINjZZdmdiTUlFbExnL2VsSWFwaXFHajlpK1F1bUxQQ0M0RllXNFVaWUxV?=
 =?utf-8?B?RGFJcE04S3o4VHltcmMraHlLY0ZVY0dZRTVLR2FXQXk2Rk4velZFNmU5QzY5?=
 =?utf-8?B?V0gyU1ZlbEpSQ0xnRGdQUSt0S1lJd3Q5Q1NtUTI1RUVBcVMyb0xFamczT2xR?=
 =?utf-8?B?UjdHdGJRVm9pZGZJZFA3V1VyTEZFNVJmZ0xHS0hiaTZPM0djRXp1U2h4ZnRP?=
 =?utf-8?B?VVZrcnRSb2VTUFlaZi9OdGFjejhqRnBoMHJZOW05Q3kzOTYzb3hrczFBQWRk?=
 =?utf-8?B?aXNadUFrVDJSOURRNlFXcjNJaEM5VDYwdFZ4cDlXSUNhcWxkUElGS3NteWFG?=
 =?utf-8?B?NTNROFpHK1ZFbGNxSlo1MmI0bWIyOUhlL2orSkNLbkNYMWZ6cGttTFFZS3N0?=
 =?utf-8?B?ekdWSHJ2VmlRbnJRUEs4cUMyNUpnY001R1I4Nzd1S3VtSjVSQlFHY2RUMjMy?=
 =?utf-8?B?RHZTcEZ3d1ZVcFhxYXlvdlFPNk5PYW9RKzdHcXBvYzBpRTZ3Z1NueW1zUHVh?=
 =?utf-8?B?VjBqNkk2SlJhcmVFeFlYZGZlSG5pMUllaUxOWFNPbERPTnluS290YWJKTHdq?=
 =?utf-8?B?OW1DUnlFaFBlTkFQNWxLcW9hSDYwYVZFSTRsVXl4TXNhYjJ5ZmR1QmhiZ3F0?=
 =?utf-8?B?cEhuSEVEUE1yWEU5WGo1bkZpbDVjVnZRZXk3REJrbVJHZ2pnMEpLekRsRHRC?=
 =?utf-8?B?WHdJTnRGa0V6d3VFaGpOcHlCM1pQVllpblpRMEFuOUtHQTRFSHJ4eE1KWmlm?=
 =?utf-8?B?RHk5MDJrZ21vbklFMk9WWDFLU1FlK05EMmIxcEloeUVldFV6emR4MzJtNG01?=
 =?utf-8?B?S3RKT1J6RHVscStvYVAwS0NXaGV1K0EvQStxUi9EZWN3czVOby9pYW5kOG15?=
 =?utf-8?B?NDVSNFV2SWFrN0FhWFBhQUJtMU9FNm1iMTRxTHEzTE9kQTIzY3hSZzUxaEdB?=
 =?utf-8?B?cjJwUmZCNEt5bkw2Um9acE51V0RGb2RsRjlnVWY2UkJQK2F2WWtwcXQxYktD?=
 =?utf-8?B?WDlrMVdtMStNU0pVcEh0Mm9mRnFKYjBMYWZCTE02dWlWR09WSU5NWmNMWmhw?=
 =?utf-8?B?dFBaVzhEeGxIdmtiUEpzSjdka2wyeUkrbURwUHVBL2VDc0xpdm1Kd0NCY1Uy?=
 =?utf-8?B?R2lYVEdkSno1YXFwNVVMb3h3Mmp2Z1MyY0cyY1JYSkwweU9YRmY2QkNyaUl3?=
 =?utf-8?B?ZSsxdFdlNGVJSGIyNVA5VlllYWVJMnYxUVJMSTh0MTN0YW8vVHZPZmk2ZnJS?=
 =?utf-8?B?YWJlVExzVnpaS0JpRXpNc0hOQ1JpTC9hRlZtYUozM2Y1SFpZZjcrMDBBMzE2?=
 =?utf-8?B?bGtmZVV2RjNIRG5OWUUwcHExOEc2Z2xscmZjU0VOOXB5WW9lZjdPWGtJK2Zn?=
 =?utf-8?B?eXhVZWhwRDBUc1JJYWNhL0hGN2RRZXFDY3NsTnhxUmNLZVduWTh6TGdYdFFM?=
 =?utf-8?B?WjRBUWFQdmU2T3drWjRENmxRT0JESkV4OUdkYmlhZi9tS3BpMEtHMEw4aXdM?=
 =?utf-8?B?Mk9kWlowRjBwUU11VDJHYUw0L1pHZ3UyMEc0U3ZPeXlnRyt3Mlo0YTdiUVVw?=
 =?utf-8?B?SFZmZ3ZPZkJTdStUK01RUWpaQjhKVGRseHkvUGJFU2tGQlFxS0hBUnFyNFVs?=
 =?utf-8?B?QmwvMW9Od3FrcEZKbUdOYjl6VzJYTlZtNVlEWTJhbUxzU2t6bURRYnp0Qmtu?=
 =?utf-8?B?d1dUR0VZQjhnZjlXVHk4QWxPSm4wU3dkTEhQUXRWY1VqQWlJVXBtTFRicW5Z?=
 =?utf-8?B?cXk2bHd2MEs0Tnl0UGh5eGdQTE9yZHJSY3FyS21wYU14UlVxWXdsdlJmVy9T?=
 =?utf-8?B?RXZQb2xLaHMxYTVyZmhYNURDRlU1OXliS29xeTFySDhibUJlVnhHTnJVN0tm?=
 =?utf-8?B?THN5aXdvVmZHU1ZKUWhqUGhoalJDREY3cTFaZFBTQjYvaFJxL2RFbHlOaTd3?=
 =?utf-8?Q?r2I72ht8sHmNYa6JZe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9FE9DF06FC1C149927E540FCCE3A674@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 248002f7-c58d-4c0d-e94e-08de909d0f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 09:48:57.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPUGwBxlHZLUvRmRFHXyYlq31lWoQ+2b6N2aJ+CWzHp/8hOHdJHjBJn89aQBNJlje1XDXiCjknzXl27dZPLpJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR04MB12651
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
	TAGGED_FROM(0.00)[bounces-232962-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 769D63875AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VGhlIEdSUF9BQ0tfTVNHIGhhbmRsZXIgaW4gdGlwY19ncm91cF9wcm90b19yY3YoKSBjdXJyZW50
bHkgZGVjcmVtZW50cw0KYmNfYWNrZXJzIG9uIGV2ZXJ5IGluYm91bmQgZ3JvdXAgQUNLLCBldmVu
IHdoZW4gdGhlIHNhbWUgbWVtYmVyIGhhcw0KYWxyZWFkeSBhY2tub3dsZWRnZWQgdGhlIGN1cnJl
bnQgYnJvYWRjYXN0IHJvdW5kLg0KDQpCZWNhdXNlIGJjX2Fja2VycyBpcyBhIHUxNiwgYSBkdXBs
aWNhdGUgQUNLIHJlY2VpdmVkIGFmdGVyIHRoZSBsYXN0DQpsZWdpdGltYXRlIEFDSyB3cmFwcyB0
aGUgY291bnRlciB0byA2NTUzNS4gT25jZSB3cmFwcGVkLA0KdGlwY19ncm91cF9iY19jb25nKCkg
a2VlcHMgcmVwb3J0aW5nIGNvbmdlc3Rpb24gYW5kIGxhdGVyIGdyb3VwDQpicm9hZGNhc3RzIG9u
IHRoZSBhZmZlY3RlZCBzb2NrZXQgc3RheSBibG9ja2VkIHVudGlsIHRoZSBncm91cCBpcw0KcmVj
cmVhdGVkLg0KDQpGaXggdGhpcyBieSBpZ25vcmluZyBkdXBsaWNhdGUgb3Igc3RhbGUgQUNLcyBi
ZWZvcmUgdG91Y2hpbmcgYmNfYWNrZWQgb3INCmJjX2Fja2Vycy4gVGhpcyBtYWtlcyByZXBlYXRl
ZCBHUlBfQUNLX01TRyBoYW5kbGluZyBpZGVtcG90ZW50IGFuZA0KcHJldmVudHMgdGhlIHVuZGVy
ZmxvdyBwYXRoLg0KDQpGaXhlczogMmY0ODc3MTJiODkzICgidGlwYzogZ3VhcmFudGVlIHRoYXQg
Z3JvdXAgYnJvYWRjYXN0IGRvZXNuJ3QgYnlwYXNzIGdyb3VwIHVuaWNhc3QiKQ0KQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNClNpZ25lZC1vZmYtYnk6IE9sZWggS29ua28gPHNlY3VyaXR5QDFz
ZWFsLm9yZz4NCi0tLQ0KdjM6DQotIGNvcnJlY3QgdGhlIEZpeGVzIHRhZyB0byB0aGUgY29tbWl0
IHRoYXQgaW50cm9kdWNlZCBHUlBfQUNLX01TRyBhbmQgYmNfYWNrZXJzDQoNCnYyOg0KLSBtYWtl
IGR1cGxpY2F0ZSBvciBzdGFsZSBHUlBfQUNLX01TRyBhIGZ1bGwgbm8tb3AgdmlhIGVhcmx5IHJl
dHVybg0KLSBwbGFjZSBhY2tlZCBpbiByZXZlcnNlIHhtYXMgdHJlZSBzdHlsZQ0KDQogbmV0L3Rp
cGMvZ3JvdXAuYyB8IDYgKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvbmV0L3RpcGMvZ3JvdXAuYyBiL25ldC90aXBj
L2dyb3VwLmMNCmluZGV4IGUwZTYyMjdiNDMzLi4xNGU2NzMyNjI0ZSAxMDA2NDQNCi0tLSBhL25l
dC90aXBjL2dyb3VwLmMNCisrKyBiL25ldC90aXBjL2dyb3VwLmMNCkBAIC03NDYsNiArNzQ2LDcg
QEAgdm9pZCB0aXBjX2dyb3VwX3Byb3RvX3JjdihzdHJ1Y3QgdGlwY19ncm91cCAqZ3JwLCBib29s
ICp1c3Jfd2FrZXVwLA0KIAl1MzIgcG9ydCA9IG1zZ19vcmlncG9ydChoZHIpOw0KIAlzdHJ1Y3Qg
dGlwY19tZW1iZXIgKm0sICpwbTsNCiAJdTE2IHJlbWl0dGVkLCBpbl9mbGlnaHQ7DQorCXUxNiBh
Y2tlZDsNCiANCiAJaWYgKCFncnApDQogCQlyZXR1cm47DQpAQCAtNzk4LDcgKzc5OSwxMCBAQCB2
b2lkIHRpcGNfZ3JvdXBfcHJvdG9fcmN2KHN0cnVjdCB0aXBjX2dyb3VwICpncnAsIGJvb2wgKnVz
cl93YWtldXAsDQogCWNhc2UgR1JQX0FDS19NU0c6DQogCQlpZiAoIW0pDQogCQkJcmV0dXJuOw0K
LQkJbS0+YmNfYWNrZWQgPSBtc2dfZ3JwX2JjX2Fja2VkKGhkcik7DQorCQlhY2tlZCA9IG1zZ19n
cnBfYmNfYWNrZWQoaGRyKTsNCisJCWlmIChsZXNzX2VxKGFja2VkLCBtLT5iY19hY2tlZCkpDQor
CQkJcmV0dXJuOw0KKwkJbS0+YmNfYWNrZWQgPSBhY2tlZDsNCiAJCWlmICgtLWdycC0+YmNfYWNr
ZXJzKQ0KIAkJCXJldHVybjsNCiAJCWxpc3RfZGVsX2luaXQoJm0tPnNtYWxsX3dpbik7DQotLSAN
CjIuNTAuMA0KDQo=

