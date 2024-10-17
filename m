Return-Path: <stable+bounces-86559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B45C9A1A3D
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 07:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB491C22C7F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 05:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C215ADA6;
	Thu, 17 Oct 2024 05:50:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAEF1388;
	Thu, 17 Oct 2024 05:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144204; cv=fail; b=AHZP7ag9WCtfeJHiVn2ysVSLGaxonJUqrADkf0jtsKEGA58t6HgTD9/uek/Y45c/p3diB2xXuy3iCW5Z627z1WvaTO1rRXdy/rzK04EezhnRzqU88Pl6BkonmHpRtiF4U8DRqzYjGOW5Pr2ZBUQm+r/vXn34hPPiqeE7/nBreRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144204; c=relaxed/simple;
	bh=61UnXYdKhoXtrfRJvUckrBT4nw7iBxV3lYqvsE1aSdg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mUWdAUr0iT4Ip5KQI42lVa3SfIw2N6LH5+4IU3gt4UTj9biRs6ZkZbcYjA+rXyOg+t8Lok6E/Cr2gzAiptx3/uEk+GkHDTHqAzu+ZzoZTUd2HdENhr6kA63cjE2MzhqK1HeMhzA3pfnU9V+Hpy4Tui5QWDj218ymQO83t0HzKyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcecbOkJawIYe/ZUr5yPCm8I+yEKW4nVvymuSaSqDkzVWip1Z8zp7v6irdAQBfvoB2+A8/9nGhL7PkljRM9tzIMD0+v+rngPOvozxnBYl9V2ISPYQfjTht5cr211+fm49pTaIpdZn9zQdMd86nqTTgOMaggqGbu4YqshhsENG/RYngPWbP0Elsua0ca9qMjUNgDlRb3kTKZK3vTqul87JO3OrXWE+n2toc9M325FzYvJ49l13Ix6Y138UhoQ13etb0QJF3gWeUWGQZsClfghwGM30tlSa46rfzDxxCuMF5KiIQDxm1RVdanLm7YhYq5nbQLEm1C3BYGitIDMtxtXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61UnXYdKhoXtrfRJvUckrBT4nw7iBxV3lYqvsE1aSdg=;
 b=kUBeMM/HmOw55o3udueRJPUTNLFoJ7Xr3/0OmTgbhb6pxw9CvyEtwTdnMyIrjgAMpJP0elD1B/FZXk9vTlBTZrRxSi5xxYg7m0OiZonozzMeEtSSTR+yOrhmOkiPcPtsQc9r1GAqjA0C5Xnwb7RZNaB294VicWGIw11ALv6ILpqZNpBHTosOIKjM8nw/n0TVo7dJiYV+dbQfl/Zwf9zugxE9WT/qoLgQMrnT1CFFNK1EilxFQKM6oXkwg+NcUBcbMz38G6np7+0oR6Pd0fxr0ZWUO68lgylw+nZU0a6GNNdEeusttQRLkYZISloNNGL+pPNaBkie3oI1qfytV5r58A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1143.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 05:49:56 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%5])
 with mapi id 15.20.8069.016; Thu, 17 Oct 2024 05:49:56 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
CC: Conor Dooley <conor.dooley@microchip.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Emil Renner
 Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxXSByaXNjdjogZHRzOiBzdGFyZml2ZTogZGlzYWJs?=
 =?gb2312?Q?e_unused_csi/camss_nodes?=
Thread-Index: AQHbIAerDCyRJ1WJg0mmvQeCtV44grKKI3cggABMoZA=
Date: Thu, 17 Oct 2024 05:49:56 +0000
Message-ID:
 <ZQ0PR01MB130298186E09DA19CC1F7736F2472@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1143:EE_
x-ms-office365-filtering-correlation-id: c72a0a12-766e-4dfc-6e12-08dcee6f8769
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|41320700013|366016|38070700018;
x-microsoft-antispam-message-info:
 rAG/GuyFxBLHk8gMSgQ31671qZU2LdX/PF0AQSpfO7keQmOPmw+QC5ZDuedxbfxg91oL3JQ3nCy+MruwFg2K9O7sQix04t6qqQ8CDZYFIY3+f17JIWMuaRW7FFdZ3xzfb3MCC0z2NrWnHHqkslOHldVlAzQjEQ7RKSy/v9nDJ2hz2Lg3Nmq/UMCU9M18QN2XZwbR9Dy/JnD39hWXXwa6MBfpTFmjBWOyWJrxSLmrTMGgexxRDIyyHwI5lnJbN79BjFYrHPoijPBTLCaYaNU1QnNvfF3iPiQEi0zb1UWryzXjtk/A9aObC7LLseskwmpwnzpCU+P55K6xaVPCnVTs01kkzqanjMNlASBFdOPFTIv9OdYF7cO7I0C/5uWDxQQFMv5TyA17It46kWa81mI0UiJL7wy9pFrl6gEyrlwbu3qgFYPSWm/UmMHQkzgXRUJjvZ5Vg4vUwiW+bsohYG9Rc9wHE2VRHSAWRKQ7+caCdciCcCoA/v2Jt02PArN3z20kuGvDH1QJySUP7hVhGEROt2GblXdqHN+IiUA5g7bOYvAsO/bm3d1Xa+H1T888fNg7JmhKONwNC5UhDvQ/ojVlxtXaj3d/brHzjpvXhUXXwommh9CrGXSYjLFM5LQPde9J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(41320700013)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZXF0Y1RGa2l1cXJLTTNhVmg4cG1HN1BGWUc5V29BNmM4OTdSd1Nzc3RxaW15?=
 =?gb2312?B?czZFQ2xZcEZ1QzdOWmxaOCtEVnBLVkN1NCtISHFvaVo2R0ZVc0xiZUFNaDVW?=
 =?gb2312?B?NnlpZmJ4SFdnSTV5N0xjaGdNamh3S1JLU0lpRXVvUmpHajg2TE9IUE5UZFFv?=
 =?gb2312?B?Z0xOQjdadEFwTS9yaGx3VU9MQk1jU1ZqckROdzVSUHJsNWdFZzNhYmpLajNY?=
 =?gb2312?B?UC9QcUdkekdMVExUY25nUkpDSWpVeU1DNTJEUzhtRVJvbVdIcisxVTdYSXho?=
 =?gb2312?B?cm4yaTBBTU95ZmtRK05kYnBrOEFuS2d0dDJSa1NpNDJneEVFeWhFQ2pjZFRY?=
 =?gb2312?B?UHVXVmU2UFp6cW5rajdTSCtzeE9vc1ZDSXY4MWYyMXBQSDZ2Z1BDc3lNSjYr?=
 =?gb2312?B?QmlUZmRsb3JOK0ZTMWlVYnFRRysxd0dVWVhSV1h4Tmk3WjZRYTVsSjJkY0k3?=
 =?gb2312?B?SjRhN0VsZmM5cEJraUY3VjcrUy9rUHRVQUNWZ1cwbzFkcmI3T1FabGNlRFNa?=
 =?gb2312?B?ck1BcCtWWDhway8wTGp0UmdQY0VWbzF3Zm5tRDRFRGlDRERGQkZ6SnVDSE9G?=
 =?gb2312?B?dWtEVFoxb2czVDVYL0Q1R3pwNnVzaHVvbndENFJDYm9mZ29sYkI3TXVhUXRy?=
 =?gb2312?B?YkdDT2NlOTZzYm96RyttUVpRS0ord1pvOUZuUWF2NnlKOGlqdzg1QUQwRVFY?=
 =?gb2312?B?VktrNVBBdURJTWpKcW5iQXBBckpleWduUmprM3lnSUpTSnZkTjBPckhNcFRC?=
 =?gb2312?B?a216eUhmRnAwb1lUcGppSXhlYmp6SkxQdG9OY2pSRGNFOUpnbThwbHAyZE94?=
 =?gb2312?B?eUI4eGV5bzhoaHZ6VnJZNndIUFhEZFFYQmIxVnJURkNMdEtvL0pZNkFGMEx2?=
 =?gb2312?B?djFGQTlDNGFEL2JLOUl1U0hqb3F1ZG1pTmhvcktYYUtJS1AxOFdLSUNhdEda?=
 =?gb2312?B?ZkVxc3dBUWIvV3p6d1h6V2wyck9ZU0ZhU3V2MjFoM1NTUndYYzk5MnVxVnN2?=
 =?gb2312?B?TUtBMjBQak9XVDRGa3l5YVBxWjZuM0FtMmZZdGg4ZWtVTys4WUd2VHAvMFlx?=
 =?gb2312?B?cGdHTTlIRjlicjFDM29ZeG91Zk9SVFFsOG9wM1JwS25Ub3VQSUNtMGZqSDBC?=
 =?gb2312?B?ajc0aDd0cDdQR3hjZTM1ZzFXVGxWZ0xJeFJXMGk4ZTBEZVRuM09OSFljalpG?=
 =?gb2312?B?QXdHN284UUxLZjgwZm9WRXNKQUhKNXROeXZHcFFackkzNCtQOEgzYzFOUG54?=
 =?gb2312?B?ZEE5WkhHaVNDS3VHV0NOTFRFNS9hZTc4YkpnN3JiZFJyczZMMVR2dVQ1aWk1?=
 =?gb2312?B?cUp5NzZOd2YzbVZpd01ESDZCQ0U1THlQZUpPWlcrbGdweTBhTWdrbVJsaEho?=
 =?gb2312?B?UFhwRnBoYWtyMTIvbWhjRkZoeWhVRjVBODhqbEkxdlRDaDkzbVJaV1A5NWk5?=
 =?gb2312?B?bEJkZGhkbDUxaHdlYVg5S2NVeTcvekdWYmxIdlRXLzNPVGtJeklsU2RkRUJh?=
 =?gb2312?B?d0xhZnRJWmVkTnZKcjVqR2MwZ0RZQ3BxWlhkTGpZd3p4ZjkwUGtqTmVYaUpa?=
 =?gb2312?B?NkF4eTJNVXhMcEcxNWFJTG0xeWczSzB1SnVOK0IrclB6eGRqR1Y1eEdqMWZl?=
 =?gb2312?B?RFJEUjBxOUI1QVV1KzZkUnR3YjEyRkdHOG8xMWN0ZW9yaVp5bjJyODFQeXJW?=
 =?gb2312?B?RHhLL1ZlMDdLSnlpQm5WRTlraDlKTUZKcnZSUjNEenp5N0ZDWWNoeDhBTWZ0?=
 =?gb2312?B?U25zekRVa2hBWk8wKzZLYlVVMHlBdzhkSm9UdmF6QmFDUjZxbER0Mm1OZU9X?=
 =?gb2312?B?NlZPVHZzVnlrWjNkUys2SER5aDdKM3VuZlhJVnBJVFpmTk16YllxR2YzOTNP?=
 =?gb2312?B?R1I0Y1F2clZoRkxydUJURG9Rai9MOGx0Wng3aEs5SmZvbGphZUhLcDVvVm1s?=
 =?gb2312?B?ZEdMZHR5MFNFNmJlL0ZGVm5oNlEyTkxYc1d4QVdScEdLbzRnajlZZm9Cb1Nz?=
 =?gb2312?B?Nk5aR3Q3OFNpOXJ5ZldVRGZwZTNsUHJDUXozeUVuZ1BpU2Z6ZU9oenRJNkxW?=
 =?gb2312?B?aUxVdGQ3UzF1akhBVTNRTTNXLytMSFZnbzJoUTgxQyt6ckJFT3dZYUdoZjdj?=
 =?gb2312?B?TDlkMGxkZE1TUCtOOHEzMzh4MjJxbUFUaGtUZENVUElQN3lKV04rNklqdEd1?=
 =?gb2312?B?SUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: c72a0a12-766e-4dfc-6e12-08dcee6f8769
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 05:49:56.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dE0fm7YPRvNcwEO1rxZsUl9cm0cWtPLTZHPBhf4+amwJhWz+Nymh+ovs8pG1gg3T47tm8J3NPC+0H7EnI4a7XJrtO2WF1M9lYkhgeK25kDl4q5Qg+CdugAxGCnZNz6iL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1143

SGksIENvbm9yLA0KDQo+IEhpLCBDb25vcg0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0K
PiANCj4gPiBGcm9tOiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0K
PiA+DQo+ID4gQXVyZWxpZW4gcmVwb3J0ZWQgcHJvYmUgZmFpbHVyZXMgZHVlIHRvIHRoZSBjc2kg
bm9kZSBiZWluZyBlbmFibGVkDQo+ID4gd2l0aG91dCBoYXZpbmcgYSBjYW1lcmEgYXR0YWNoZWQg
dG8gaXQuIEEgY2FtZXJhIHdhcyBpbiB0aGUgaW5pdGlhbA0KPiA+IHN1Ym1pc3Npb25zLCBidXQg
d2FzIHJlbW92ZWQgZnJvbSB0aGUgZHRzLCBhcyBpdCBoYWQgbm90IGFjdHVhbGx5IGJlZW4NCj4g
PiBwcmVzZW50IG9uIHRoZSBib2FyZCwgYnV0IHdhcyBmcm9tIGFuIGFkZG9uIGJvYXJkIHVzZWQg
YnkgdGhlIGRldmVsb3Blcg0KPiBvZiB0aGUgcmVsZXZhbnQgZHJpdmVycy4NCj4gPiBUaGUgbm9u
LWNhbWVyYSBwaXBlbGluZSBub2RlcyB3ZXJlIG5vdCBkaXNhYmxlZCB3aGVuIHRoaXMgaGFwcGVu
ZWQgYW5kDQo+ID4gdGhlIHByb2JlIGZhaWx1cmVzIGFyZSBwcm9ibGVtYXRpYyBmb3IgRGViaWFu
LiBEaXNhYmxlIHRoZW0uDQo+ID4NCj4gPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+
IEZpeGVzOiAyOGVjYWFhNWFmMTkyICgicmlzY3Y6IGR0czogc3RhcmZpdmU6IGpoNzExMDogQWRk
IGNhbWVyYQ0KPiA+IHN1YnN5c3RlbQ0KPiA+IG5vZGVzIikNCj4gDQo+IEhlcmUgeW91IHdyaXRl
IGl0IGluIDEzIGNoYXJhY3RlcnMsIHNob3VsZCBiZSAiRml4ZXM6IDI4ZWNhYWE1YWYxOSAuLi4i
DQo+IA0KDQpBZnRlciBmaXhpbmcgdGhpczoNClJldmlld2VkLWJ5OiBDaGFuZ2h1YW5nIExpYW5n
IDxjaGFuZ2h1YW5nLmxpYW5nQHN0YXJmaXZldGVjaC5jb20+DQoNCg0K

