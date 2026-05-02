Return-Path: <stable+bounces-242583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHPqAAlx9Wk1LQIAu9opvQ
	(envelope-from <stable+bounces-242583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 05:35:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 627784B0CC1
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 05:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4FB300C598
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 03:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D09B222580;
	Sat,  2 May 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="jsM8XjaE"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33361A683E;
	Sat,  2 May 2026 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777692930; cv=fail; b=IcyWiGBRAVhzIp0XPZZ19Q9Fb64jX6KoI/WN5oVYIkg15CdTB8CFba5zxBUQDhLNxoUuIWdNwBu35j5YgHRhqFcZ6ngvskatMEhBsPI8uZDzI019xbrKIrmnVP0zt0DHk6hd+0s5RR5awGzsm/nWpxoyrUeDVX6QwjOywb7eOg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777692930; c=relaxed/simple;
	bh=hRYoL60hN/UsjlZhSppq6eOtCUhEb2kzo41XToUqqwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PNW4FjudJ+QETkD+J94fJ9RFdfaFsWaLmrzbVs1ofGV+crc4GxiYEKbKccnvoD6IJOfFFb36vu7+wJwwtz/SJDt4WO1up0l5rwVYCmYUHC79bopZSG2t3p5iZdeF/BV0mkgpyrA1extbuuv7AJnrQgi7sUCD2JExjzskEMPqX4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=jsM8XjaE; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+7XnkKEaYLVf9vyQUDRuHL3pNELtfaFUj6oqoR9glWWnfFmrrk7DfjLAmUvYQaTLFL52ICfdht1RxJ36EOZA5d6nVN/JDl+wI34HcxpqvPDuFnlAtpPoOfvikQ0QwjIoB0N8WzW5fPBIus2R2jAexvFTO/uqq2JjycbumGEkPA6I7OcdZsj4vgwrTzIAP12fw3FOdfgn0atr7iF8GjbKR4w2A9E+9k6kVIEA3lmcyqvibxpwZBx5iofCPjQ2yF9JoRhmFZCwNAd4O6qZ6IHWhwLEVjXZh4rbfm5iB9oMdsC8YX8g6EE9rFWHAoQ9ag9hwh/Z5z1WzMMWyTF9cITbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvDAZZmBFPeo0F8Y4uIStc7DWXaKgMKjZb/yI7KWX+o=;
 b=ERJiSLBZuFDAmKTxD+2X25q377kQhR/+JcFiEqyUVrD3VkiDVjroSgegB8fTQUnXzvaoqvRcYaIlK15N4302ThmfOVw4wLUUL8529qH3uUG0IlUK4PZVqj2tryZ5iA5ipA4l1qwBPKUd/oIYmXt2PgmcA0a474JzpNNXc7CR6ZhbPZKjpNP9ANBGtObUatej+vcXfMNWa9+ybcAH5bCai03w+4nTvJVinfpDYeBXiLpr/jyA4MhsMq+aYaun5CYm/7/RzLu8tudUz2LlE8aZM47ouH8AAP6+hMRokv1hH9oVJbT6Z9Srb4nbyVPgTcM79hEzi6bfD1/b53HGj6whMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvDAZZmBFPeo0F8Y4uIStc7DWXaKgMKjZb/yI7KWX+o=;
 b=jsM8XjaElSIrYU3NXF9y1S7bnRlgxLB2QCqE6wkJh/blBdWPkJrbRxPbMekp4VI8hdsg+MHgCgdlj94t+XdxckAZkRXNtmA9IWWL8ZjEF+uW+nmMhIql2l/3us0/FE8KeN9+6htxIYnstJlsWYcT5aE9cOUxL9thoVPVV+lqNnqUgEQqjGYbluHG1ni+hzqWWk5+hdQPo+aF+6h/1WOfsmg8iGckk/YQBq5McUDPGkL/JoejujMFW4ZUGTL2UZoEZjuo6oxqY+zsa2tEiNwapxCs6bIV7QHdDJQnyp+cyet78G7DXhiWA6Qbr67Pzx7IYuKbQ5Wj6q4C65NykQgSsw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 AS8P189MB1223.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:28a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.23; Sat, 2 May 2026 03:35:25 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9870.020; Sat, 2 May 2026
 03:35:24 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>, "ying.xue@windriver.com" <ying.xue@windriver.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "tung.q.nguyen@dektech.com.au"
	<tung.q.nguyen@dektech.com.au>, "lkp@intel.com" <lkp@intel.com>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, SnailSploit | Kai Aizen
	<95986478+SnailSploit@users.noreply.github.com>, syzbot ci
	<syzbot+ci779e8ed86620f383@syzkaller.appspotmail.com>
Subject: RE: [PATCH net v3] tipc: fix UAF race in
 tipc_mon_peer_up/down/remove_peer vs bearer teardown
Thread-Topic: [PATCH net v3] tipc: fix UAF race in
 tipc_mon_peer_up/down/remove_peer vs bearer teardown
Thread-Index: AQHc2LYkD8YFjqF7R0iF69rUxPDWPLX6F9Qw
Date: Sat, 2 May 2026 03:35:24 +0000
Message-ID:
 <GV1P189MB1988B432C75AFDC1131F2BC8C6332@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <CALynFi5d0DuGW50xq7xQnsDPdEuN5jBGTqh8bcsUwxk6L-FAdA@mail.gmail.com>
 <80ae67e96de2f702028e5bacc89db4575e1531ca.1777559945.git.kai.aizen.dev@gmail.com>
In-Reply-To:
 <80ae67e96de2f702028e5bacc89db4575e1531ca.1777559945.git.kai.aizen.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|AS8P189MB1223:EE_
x-ms-office365-filtering-correlation-id: b6dca385-6aa9-4e54-7648-08dea7fbd881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 /qoFFyp2VEwhS+BW7wIBBSDCDNvjGZfR/mBatamFjOjL4GJSjBy3DMAOHOPWuDchWWtwzICVu16gU6mTpiLUf5aNzauSf9ZqNteBUmkgvRo/7VDtyzocaTzi5v16XgzM7miDKfhQ29v7QT95988u4x1HpUnTOSDdTnMsvlOjykt+OE5DNIM9lHCvCmwL8L6nMkKm4L4HR7m275oHBz0U4DByVjHsAzQMNOoPfPft07mkKiWDa0tqgvCjSHMSpy61PO5hwqJ0/EdLkL9NACOZ2tDI4Qqa+ahtb8WDpX9K+0DJ9Sesb+JJCUPoEU77fymtAKk/0ant1bAzyi95bDQIyWyIgS9Y4f9VNlT2HFHUoYmZtRzYXzY3UbPM/vOWcdL82SxqGCiL/YwT7WCk0shoCEqNwOfI/wiglo2ReS4aLuhhbDCkyhD+gTqNDejCXK14kPB862DqLB31/zAItoWNBhlbQg2on0xF7HE57QeYInbaJXH5yT1BZ5CN8YRXP4zC3t2FwTAszsx48uK2zvc0pDOxhOii7q5fHI+619kxaN/xWsUszEtnZkDMEoG26FVgwUZcwLRT6RHronbgYw89M2iFpgsPhBrpdfHS8PUsqh2UvtbW9HdNpR2Gg1Xm9BaoaX5fHb2R9Wdj8e1q4fyl+QBwGR9NO/nuo2KYfjUGYsdjzViK/hHwsZu/9I2UPk5dHNBRmYp+DLiGmCvvdr0Ucg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2t7Aot7S88yNXRTJT29vRO8vGvt5LgjI61BtilM1uulmfY9ySYN1C0Wctz65?=
 =?us-ascii?Q?qYMjOkH55TbewPbhq/rb9FP+c/kQ+8sHyWC3FSNpAFFRD0I5NKIK7x/LVzsJ?=
 =?us-ascii?Q?7wIjCUk5n3mehXP6iIfDjzenySL330ilV1nu7m2lo1y4fepXOD3Z2ZIsaXm4?=
 =?us-ascii?Q?u+tw4vn1D7OBZKvSPZwEOxMNh8OU1emYC+xKjDZkZjDH5L0T1paNkoEGG3Ir?=
 =?us-ascii?Q?8uO9cqEzkpU3WL+sYheUUMLDqeiMQzvc6rJeWrZe7JBTT/1B1VCZ2UHvO6+j?=
 =?us-ascii?Q?es4x594cCLilb90lIrSLEE80JaFtsAvujNlCqUrl2dQuIJEf4mkIrRlq1y3c?=
 =?us-ascii?Q?UZHKjDPvxy3bIx5jNY7tZgMQxX6I4MkB4Gr9xE+fftLLOgVLPz7Yc6hg4H38?=
 =?us-ascii?Q?nH9GSP6mOiYcIfxDStexnoqkMecrAxkoNvn8ZGHKou9eTNgxqppYOJ4frgs7?=
 =?us-ascii?Q?QYfh4zpCM/L4LIJhnfItjRNIKO47RS7332ya4O9YDq9i4+l22PsCuDRhUEqf?=
 =?us-ascii?Q?z9nL3TGQp8nW4xXAFvKnE90OrVKFi2aJ2HUWkm71zRTJw03W9xJ/rn+YK/wt?=
 =?us-ascii?Q?9hwE/FAPKzGNvmAuOSMCOGZPtUd2SLkiI6WfHMKQdIfNgvkoooCIajPWwsYZ?=
 =?us-ascii?Q?zI8IYvPu4BIhcPSp/hMpiKF/VHAZ9tCG0y5WOBtLqEy9/6EIkZsDDe3tP+Vz?=
 =?us-ascii?Q?Zr0WV+BX1SGSSMUEhhT6oV1PQjZwf42UWkoiPKsZv+9AQ1Fh3OqdBO4Vd6SU?=
 =?us-ascii?Q?BjmV7gS40qJakwLZ+dpT+Y5MepWpw3zOwVx3q4OpPrZ4UI38HdCX4ZYsU3Uh?=
 =?us-ascii?Q?6/wjH0t1fKS3RCBdu9Uq/56cZnYpbGf4DQuAhyYjSw/1LPCSdTEb3xbOlW27?=
 =?us-ascii?Q?1Av6lmVIYZngQGMaSUhj3nF8xNFYLo9JM5LvocW9H8LAJ+aLKzXwS3mwtQVy?=
 =?us-ascii?Q?UGvDBI6mGIItJuJGKO/xKliLIyHnvm0qO7YC374DO9tIxsdt6ZtPUHvV3lHC?=
 =?us-ascii?Q?FnifNMBKXzlupJRefGdOU4RwEoYaO81CjiX2B/YJjYp63Bue5zMAMiAEyVwb?=
 =?us-ascii?Q?NG95iH2wt661XPgMwresaHq7ULu/qsd+2OhMIVtUadiOSnshQ/t5UYQsFwOq?=
 =?us-ascii?Q?9f5Z8tz1uhtVuzeOTtAfzMSKffUw3ahC9NwNa4GTqjXwQ7+DToal2WdlxsRs?=
 =?us-ascii?Q?qitsswgWtMsnyN/kPHvrUWoDKgHZqkZbwpt1Wp1Zm/bOXMmlgB3t4Ql8yBw9?=
 =?us-ascii?Q?sDDjaUBn7BmMy2eKzIDl7UhfPK3wNEU9LYyvr7zDHJsBACJNO6gSShL0IxH0?=
 =?us-ascii?Q?x1wY7SJvwnZwA1EC/vruBQmFkJqx4hNKlgSUcAYM/fzb1r+v5nc6eT7sfpJ1?=
 =?us-ascii?Q?AhHAecMzBnW+pC2sDC5Y+wzd6XwTEBMcQS7x3WVAB0bgVZPQd0u0/OWr0DeB?=
 =?us-ascii?Q?EVUbHjCJGHYbjJvNwdmCjJqGDDVUMxipYsA2Gdax4SVluE+bDZyVa8ERCj9V?=
 =?us-ascii?Q?ESnT+mWSTevV3dRWyxdF6djBpZJ8+OzWplPsg34x0L+4H2+Vz7hUomXG1K6G?=
 =?us-ascii?Q?KD1OilVmQrwVa959qxYftv/EADjS/o9rt44y1tQV7Te51gZx1UosikJAK8MQ?=
 =?us-ascii?Q?mRBFUNjVS/BAEm/PkuBDbpDl290CeD68oXZk43VAJyM8S/cVgQydzWy7nq/8?=
 =?us-ascii?Q?RQnUgBfq9TKouFSXFsyqbDTBt3RY3MQFzc9FXD2WtysjoPzL5RLkET0OJLYC?=
 =?us-ascii?Q?akuRpu84Tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dca385-6aa9-4e54-7648-08dea7fbd881
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2026 03:35:24.3753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Iooz0c+2aDnLv/OCr5PDaqlJem117tpGnwuu/TWHJ0jknRJGoUJqpAXmnfRNSGA2XCXqbrGd6RfI1G+cHy++VV+tyN4x4P9u3IVkx8pVI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB1223
X-Rspamd-Queue-Id: 627784B0CC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242583-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[est.tech];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,SnailSploit,ci779e8ed86620f383];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzbot.org:url,est.tech:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

><syzbot+ci779e8ed86620f383@syzkaller.appspotmail.com>
>Subject: [PATCH net v3] tipc: fix UAF race in
>tipc_mon_peer_up/down/remove_peer vs bearer teardown
>
>From: "SnailSploit | Kai Aizen"
><95986478+SnailSploit@users.noreply.github.com>
>
>CVE-2025-40280 fixed tipc_mon_reinit_self() accessing monitors[] from a
>workqueue without RTNL.  That patch closed the workqueue path by adding
>rtnl_lock() around the call.
>
>However, three additional functions in the same subsystem access tipc_net-
>>monitors[] from softirq context with no RCU protection at all:
>
>  tipc_mon_peer_up()     - called from tipc_node_write_unlock()
>  tipc_mon_peer_down()   - called from tipc_node_write_unlock()
>  tipc_mon_remove_peer() - called from tipc_node_link_down()
>
>These are invoked from the packet receive path (tipc_rcv ->
>tipc_node_write_unlock / tipc_node_link_down) and hold only the per-node
>rwlock, not RTNL.
>
>Concurrently, bearer_disable() -- which always holds RTNL -- calls
>tipc_mon_delete(), which sets tn->monitors[bearer_id] =3D NULL and then
>kfree(mon) without an RCU grace period. A softirq reader can observe the
>non-NULL slot, take a reference, get preempted, and resume after
>kfree(mon) on another CPU, dereferencing freed memory.
>
>Convert monitors[] to __rcu, use rcu_assign_pointer() on creation,
>RCU_INIT_POINTER() + synchronize_rcu() on deletion before kfree(), and the
>appropriate dereference variant at each read site:
>
>  - tipc_monitor() returns rcu_dereference_bh(...) for softirq callers
>    (tipc_mon_peer_up/down/remove_peer/rcv/prep/get_state).
>  - tipc_monitor_rtnl() returns rtnl_dereference(...) for RTNL-held
>    callers (tipc_mon_delete via bearer_disable, tipc_mon_reinit_self
>    via tipc_net_finalize_work which wraps in rtnl_lock(), and the
>    netlink dump handlers tipc_nl_add_monitor_peer /
>    __tipc_nl_add_monitor).
>
>Also, get_self() was a thin wrapper over tipc_monitor() + ->self deref,
>duplicating the RCU-checked load that callers already perform on entry.
>With monitors[] becoming __rcu, get_self()'s use of tipc_monitor() generat=
es a
>lockdep splat in tipc_mon_delete() (RTNL context) because the inner load i=
s
>rcu_dereference_bh().  syzbot CI reported this on
>v1/v2 of this patch:
>
>  WARNING: suspicious RCU usage in tipc_mon_delete
>  net/tipc/monitor.c:108 suspicious rcu_dereference_check() usage!
>  ...
>  tipc_monitor_rcu_bh+0xf5/0x110  net/tipc/monitor.c:108
>  get_self                        net/tipc/monitor.c:209
>  tipc_mon_delete+0x10b/0x4d0     net/tipc/monitor.c:704
>
>Drop get_self() entirely.  Each existing caller already has a valid mon po=
inter
>from its initial RCU-correct load, and mon->self is the result get_self() =
was
>returning.  Replace each "self =3D get_self(...)"
>with "self =3D mon->self;".  This both removes the duplicate dereference a=
nd
>fixes the lockdep splat.
>
>synchronize_rcu() in tipc_mon_delete() is placed after
>write_unlock_bh() and before timer_shutdown_sync() + kfree() so all softir=
q
>readers that already observed the old pointer have completed before the
>memory is freed.
>
>Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
>Cc: stable@vger.kernel.org
>Reported-by: kernel test robot <lkp@intel.com>
>Closes: https://lore.kernel.org/oe-kbuild-all/202604301148.jfXKC9HF-
>lkp@intel.com/
>Reported-by: syzbot ci
><syzbot+ci779e8ed86620f383@syzkaller.appspotmail.com>
>Closes: https://ci.syzbot.org/series/6267bc07-4172-4821-b3e5-dac381479d9d
>Signed-off-by: SnailSploit | Kai Aizen
><95986478+SnailSploit@users.noreply.github.com>
>---
> net/tipc/core.h    |  2 +-
> net/tipc/monitor.c | 42 +++++++++++++++++++++++-------------------
> 2 files changed, 24 insertions(+), 20 deletions(-)
>
>diff --git a/net/tipc/core.h b/net/tipc/core.h index 9ce5f9ff6..cd582f7a2 =
100644
>--- a/net/tipc/core.h
>+++ b/net/tipc/core.h
>@@ -109,7 +109,7 @@ struct tipc_net {
> 	u32 num_links;
>
> 	/* Neighbor monitoring list */
>-	struct tipc_monitor *monitors[MAX_BEARERS];
>+	struct tipc_monitor __rcu *monitors[MAX_BEARERS];
> 	int mon_threshold;
>
> 	/* Bearer list */
>diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c index
>a94b9b36a..0095a62ae 100644
>--- a/net/tipc/monitor.c
>+++ b/net/tipc/monitor.c
>@@ -99,7 +99,14 @@ struct tipc_monitor {
>
> static struct tipc_monitor *tipc_monitor(struct net *net, int bearer_id) =
 {
>-	return tipc_net(net)->monitors[bearer_id];
>+	return rcu_dereference_bh(tipc_net(net)->monitors[bearer_id]);
Please use rcu_ dereference() because the read-side does not use RCU_bh mar=
kers.
>+}
>+
>+/* tipc_monitor_rtnl - dereference monitors[] from RTNL-held control
>+path. */ static struct tipc_monitor * __maybe_unused
>+tipc_monitor_rtnl(struct net *net, int bearer_id) {
Please use simple form like this for readability:
static struct tipc_monitor* tipc_monitor_rtnl(struct net *net,=20
                                                                           =
       int bearer_id)
>+	return rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
> }
>
> const int tipc_max_domain_size =3D sizeof(struct tipc_mon_domain); @@ -
>192,13 +199,6 @@ static struct tipc_peer *get_peer(struct tipc_monitor *mo=
n,
>u32 addr)
> 	return NULL;
> }
>
>-static struct tipc_peer *get_self(struct net *net, int bearer_id) -{
>-	struct tipc_monitor *mon =3D tipc_monitor(net, bearer_id);
>-
>-	return mon->self;
>-}
>-
> static inline bool tipc_mon_is_active(struct net *net, struct tipc_monito=
r
>*mon)  {
> 	struct tipc_net *tn =3D tipc_net(net);
>@@ -358,7 +358,7 @@ void tipc_mon_remove_peer(struct net *net, u32 addr,
>int bearer_id)
> 	if (!mon)
> 		return;
>
>-	self =3D get_self(net, bearer_id);
>+	self =3D mon->self;
> 	write_lock_bh(&mon->lock);
> 	peer =3D get_peer(mon, addr);
> 	if (!peer)
>@@ -422,9 +422,12 @@ static bool tipc_mon_add_peer(struct tipc_monitor
>*mon, u32 addr,  void tipc_mon_peer_up(struct net *net, u32 addr, int
>bearer_id)  {
> 	struct tipc_monitor *mon =3D tipc_monitor(net, bearer_id);
>-	struct tipc_peer *self =3D get_self(net, bearer_id);
>+	struct tipc_peer *self;
> 	struct tipc_peer *peer, *head;
>
>+	if (!mon)
>+		return;
>+	self =3D mon->self;
> 	write_lock_bh(&mon->lock);
> 	peer =3D get_peer(mon, addr);
> 	if (!peer && !tipc_mon_add_peer(mon, addr, &peer)) @@ -449,7
>+452,7 @@ void tipc_mon_peer_down(struct net *net, u32 addr, int
>bearer_id)
> 	if (!mon)
> 		return;
>
>-	self =3D get_self(net, bearer_id);
>+	self =3D mon->self;
> 	write_lock_bh(&mon->lock);
> 	peer =3D get_peer(mon, addr);
> 	if (!peer) {
>@@ -651,7 +654,7 @@ int tipc_mon_create(struct net *net, int bearer_id)
> 	struct tipc_peer *self;
> 	struct tipc_mon_domain *dom;
>
>-	if (tn->monitors[bearer_id])
>+	if (rtnl_dereference(tn->monitors[bearer_id]))
> 		return 0;
>
> 	mon =3D kzalloc_obj(*mon, GFP_ATOMIC);
>@@ -663,7 +666,7 @@ int tipc_mon_create(struct net *net, int bearer_id)
> 		kfree(dom);
> 		return -ENOMEM;
> 	}
>-	tn->monitors[bearer_id] =3D mon;
>+	rcu_assign_pointer(tn->monitors[bearer_id], mon);
> 	rwlock_init(&mon->lock);
> 	mon->net =3D net;
> 	mon->peer_cnt =3D 1;
>@@ -682,16 +685,16 @@ int tipc_mon_create(struct net *net, int bearer_id)
>void tipc_mon_delete(struct net *net, int bearer_id)  {
> 	struct tipc_net *tn =3D tipc_net(net);
>-	struct tipc_monitor *mon =3D tipc_monitor(net, bearer_id);
>+	struct tipc_monitor *mon =3D tipc_monitor_rtnl(net, bearer_id);
> 	struct tipc_peer *self;
> 	struct tipc_peer *peer, *tmp;
>
> 	if (!mon)
> 		return;
>
>-	self =3D get_self(net, bearer_id);
>+	self =3D mon->self;
>+	RCU_INIT_POINTER(tn->monitors[bearer_id], NULL);
> 	write_lock_bh(&mon->lock);
>-	tn->monitors[bearer_id] =3D NULL;
> 	list_for_each_entry_safe(peer, tmp, &self->list, list) {
> 		list_del(&peer->list);
> 		hlist_del(&peer->hash);
>@@ -700,6 +703,7 @@ void tipc_mon_delete(struct net *net, int bearer_id)
> 	}
> 	mon->self =3D NULL;
> 	write_unlock_bh(&mon->lock);
>+	synchronize_rcu();
Please use kfree_rcu() instead.
> 	timer_shutdown_sync(&mon->timer);
> 	kfree(self->domain);
> 	kfree(self);
>@@ -712,7 +716,7 @@ void tipc_mon_reinit_self(struct net *net)
> 	int bearer_id;
>
> 	for (bearer_id =3D 0; bearer_id < MAX_BEARERS; bearer_id++) {
>-		mon =3D tipc_monitor(net, bearer_id);
>+		mon =3D tipc_monitor_rtnl(net, bearer_id);
> 		if (!mon)
> 			continue;
> 		write_lock_bh(&mon->lock);
>@@ -798,7 +802,7 @@ static int __tipc_nl_add_monitor_peer(struct tipc_peer
>*peer,  int tipc_nl_add_monitor_peer(struct net *net, struct tipc_nl_msg *=
msg,
> 			     u32 bearer_id, u32 *prev_node)
> {
>-	struct tipc_monitor *mon =3D tipc_monitor(net, bearer_id);
>+	struct tipc_monitor *mon =3D tipc_monitor_rtnl(net, bearer_id);
> 	struct tipc_peer *peer;
>
> 	if (!mon)
>@@ -827,7 +831,7 @@ int tipc_nl_add_monitor_peer(struct net *net, struct
>tipc_nl_msg *msg,  int __tipc_nl_add_monitor(struct net *net, struct
>tipc_nl_msg *msg,
> 			  u32 bearer_id)
> {
>-	struct tipc_monitor *mon =3D tipc_monitor(net, bearer_id);
>+	struct tipc_monitor *mon =3D tipc_monitor_rtnl(net, bearer_id);
> 	char bearer_name[TIPC_MAX_BEARER_NAME];
> 	struct nlattr *attrs;
> 	void *hdr;
>--
>2.43.0
>


