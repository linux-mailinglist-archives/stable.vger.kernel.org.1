Return-Path: <stable+bounces-238480-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIdYOM4Y4mm61gAAu9opvQ
	(envelope-from <stable+bounces-238480-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:26:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA4841AC91
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4663059FE6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C6738F624;
	Fri, 17 Apr 2026 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="y2Y11RDx"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46238C421;
	Fri, 17 Apr 2026 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425161; cv=fail; b=I9JjE6wdY8F0pYYj3RWPPFpTfd/uWWtHVWH7M3hYENfT5Lb8IjGSQkZ7QUzhAoiLToWkKlMj7603SSYr6oZDZGSBu0qXjIv2+nSgO/sbxUo9jyZDqriPZAsdJwAokQCwgZIBgw4FbBfxyeB49cJfFtsbkUyjvSUBrDEX4Q0c1z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425161; c=relaxed/simple;
	bh=gJcRXTkekf54sCkHBiNRNGEOsDJmcEPEu8mccUtGxX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CoN6p4/auAIf6A+OCZ2WTtEdZyfF3A0rktyNLOq+DjRJnKiv+Ex/DoUgkvJYZdbYNHgq1Km6fI67eUR/oGpJlbIPLpL86nTcbk+UuINxEY4l2Xhkq30yMdLxPf/jyJa/aubo+5zVlrDIdIiwwb5CflrakRVIVpMiAGW0RT+xO2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=y2Y11RDx; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+A8u/BbreyMbiRdqsUnZonuuD30+icAfExfJtXeNxNrirKNj3Qc+qjyhyHVCjZv4vos6jUVeUkU5ccRaHy8lPkJFBiGL5bXYdqhuhclvtnT61GkmoytfYvhGMGw/IZq+Mvgs+bSL9S+afPE+YymSI+F9e/QYQCgax/jisM1G2RbbCKHhBXVofintvAiD/aNGJf2WoIucilVargv2mzjbB+hf+RCQCrXPmpCEcm2oNa932QhzkraK96Nb17FOUr6VtdP07vtGGdXW94Z8vgC0YxPXX/Lzn9o4W+a6xF4FDpg8juwlso/L83jWTgJ7BkU1EN5ns3GGdpAbgL3ukpy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCMwMa+CCtKKDAdILAIJo6LXwzuC6gTtF9fmG7iM/rI=;
 b=cD2Jgj8PS6RfI1w664j52D10ioERnMrjzWwET9t2qRg+JGYQv4oX1CWwZcO+0JcQtmiWdhD8DV/e22krdoQCQcyYsXvViTUM3Yd1RQSEfZP7u3owyTCnpZ2YPO6cmuDcEs/osc12S/5DC+MUqfNautn5yZT4IgrICkOAHmX/pcmkKNfeb2b3byLNIbXqnT8RQq3kpmn7wv1e9yI7ocTqM62F4pmh8L22W64h9G+0M2sR7pFiYNFNgOFshNRCMldCWlOORs4zKHbot5FKFijs+Fpsz9OSPhSpE1BTByNqhg3MIWdZLP7isREsA92R0dodrBM81Vp2AByXkv983Z5r4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCMwMa+CCtKKDAdILAIJo6LXwzuC6gTtF9fmG7iM/rI=;
 b=y2Y11RDxwFUfPdyfmHa+gikGWoBLWZxtZngccVW0DGokpNXrw7jlo/YrIor2wzjly4dkm12bcT2dzqGqwFgz17qJMJDY0NU0yCUUZzzPn7yK2E3Sd2F7FSXXWOEqruVYatEy39GV0mPV2L0RE1Y/tOfsVTfx6y8Ldteb16gTMRERiOJO/BiTL5gHWEYnAANlNEz+ZQYKhCcQlhxawy3YOMsfgzF9hCRGinu2L83X7OTlcZxWdXs9M4m3/JgA2h7fIRujto6M0Sv+oYbheVBe/bp0n3v5evtREsKFMGzTUVjYwlpc6XerOWxCA6nPOOdw6TmkZUzYMP/aD9+noU5sNw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PRAP189MB1876.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:299::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 11:25:56 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 11:25:55 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net"
	<tipc-discussion@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Jon Maloy
	<jmaloy@redhat.com>
Subject: RE: [PATCH] tipc: crypto: require a NUL-terminated AEAD algorithm
 name
Thread-Topic: [PATCH] tipc: crypto: require a NUL-terminated AEAD algorithm
 name
Thread-Index: AQHczj9n26pdW82ZQUe8x1AdZMXpmbXjGl6Q
Date: Fri, 17 Apr 2026 11:25:55 +0000
Message-ID:
 <GV1P189MB19889C5578B81060154B7B3EC6202@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260417075353.30662-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260417075353.30662-1-pengpeng@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PRAP189MB1876:EE_
x-ms-office365-filtering-correlation-id: 4e47e36c-e399-42a7-3556-08de9c74173b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 3ZaP4NLFdmo6egpw+0LD3r6wL3ZINxn/KP2TOhJ/HQU7tMCIagVsh1xWX+83VgKnT/tUuPBmUlduqgZpvHbNcIl4rjBQluGN3EjxU3c4NIBZ9xA6GZpN6Ylj6/SA9ZsIlb4mz+Hirae6w4tiUJU0J2HJuzzcv1DvQQZCNOzvY9rnxaQJ9r/XibG99dbP95EIoW2e4CqnG+sneehpOQcHayR0C3zIkFa3ypF4CKf9Lc4gSfmvk3MFPZinL3UNKn6/Q0HAP4ybV38jNQB6EZhyPD8p4hrpeUZlh/6yWZT7PGHMpEkkhg3rO+ob/LZzIzVpaae2s8NPwmZ3HhPIMUm0CThT6+vVssmOQBX8bquIGkGDPjVBquFswbbPGD6NV9wrUqTb/m9iOZfFSC3aa4F9VB2eDa8zbuIrvglrnn0MPVVXuWhv+Kdkv+eX52IRFlxqk7b+1libGB1t3PR5JEbypIC+Y0fbIfAr9hTiGiIoaeK5SAeDTn/1PNv0bMpUqTqak9ThfWmv6709eSOzg7zD7ZeD0v5ce8N7Tg0frUaPsb6yp1yled+uopznsNeQxDgMUX8p39Ikr8Mo6PcmgT1e8Xbl6cXnzZ2ZRGEJPgzIZMjhUdfaJGmBUZ/SepDzNIhQNqLGyA2VugmjZ2V5Rxr87bw8YJF3wuyBozCRdopdOk3SOUTqBV524iD0zCtzZJPe4T+7U0aOfZSXRD9yPfS9UEcXf7Onteladcyg2auht2tD2zWHFEH6ynDGpsBNuJT83G6ZWL3lP0p0sE8jClLoSk6u5cpoWEposdu+EZKl+eU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?N60wdKcLLCs5X8HwEd/2UUiFiU8kTa1aLojX4AA6CCUU4KVBiN6jQjhQkuvN?=
 =?us-ascii?Q?HbGkEFJdabdqgA7DWEdY/umPAT7DB91jVDJugRUmYkfg5KgucFD7rBefxGQa?=
 =?us-ascii?Q?o6Qw0c3udSPvHrYC3FHM8M+YK8szmQJ/rXRVkSoA615EiXkOExikCn2tJf0c?=
 =?us-ascii?Q?BIED0+8nC/zWD0vCbqRK04lZlzfUy3yym2plXy+grovmC6Dm8vPmWvwTEwjG?=
 =?us-ascii?Q?u2eyh7CaZiEYCq0f6UN6X4/qWduissprGOzvo8vDMYh26arxbdLYU+VBA1Fv?=
 =?us-ascii?Q?/zBu94NMwYNyk1T/2MFHYBKg6y4gPV2svIUPnvzYtT+9l/aTSlwjX1iBgxt6?=
 =?us-ascii?Q?Yuhdqr2y47v2HYA6qjeE9mxZeMa62QQ3FInhUSF2K4bNGH+O7eIBtmpRTK18?=
 =?us-ascii?Q?h1rcspUbZzxJ9WLhy02CtJm09N+kCmNsO9lRgwbhhaC9xwSaTEFzPG2lSG4E?=
 =?us-ascii?Q?0F8zJxcS2KzJK42ylMXT5yOhxPUe2n6M3iVEHqWTS8sV3iYzxpGnAu/TonK6?=
 =?us-ascii?Q?EnMpufGx2yyENMvPt7TJEjiy4O3X1t9hsQLKBo4C7721SR8LmLP6cFODExj7?=
 =?us-ascii?Q?pGmmSIGe6E1zpUHHxJ7/pBXwFNnth4TYKUl3Ftmh+pP/83KheCaUVpsyWkfm?=
 =?us-ascii?Q?CJ/c+yFz1aVO5aLncqX6cF1Y1VhN4g4oSBYfoGE73u8V8SDZXtY9om+MrbZJ?=
 =?us-ascii?Q?mvRDID1EhD6y5Ctj4szena4EL0euXjLkUeXwPv8rxpXxGYSHcPo0/JWmMPT8?=
 =?us-ascii?Q?w/I3ex4PUwH0NUqyJT0rEjM7+GlfbInxKsL+evB+k7+gP9PX/v0O+OIF7dpF?=
 =?us-ascii?Q?oqGdHUtS9rQkBVLohfD31ctztGVxz7Un9ITvPm2hfD9KaYSjlLFeoNMhPE17?=
 =?us-ascii?Q?7dm4kGNqX+w3D6dSEQqDt5xb6qZYS3NvKWJIj9pkO81Gy6lD9U/zrGCESxDB?=
 =?us-ascii?Q?aUh6Y8g7T/SYJp+7i429nzHuBaDbv4P7gjazXba1lHWN4CQwTZgMnNwB3w1V?=
 =?us-ascii?Q?kWxnyITrQHEVXygZC+0IdWkmGXL2PZBJj/FhcdZY0pAMPSB46QMoPAb1j5h8?=
 =?us-ascii?Q?iBmUBGEYvaLTWIuhAz+7ULSq5WOOMmH3my1i98cQMQ/2vXVVNzDwHaTlMYQv?=
 =?us-ascii?Q?vBysHthpJn/9l4zQaFGjJrA4GljsuDpkkAcZFcLVqNUoiPvsETSdxLsqAP2W?=
 =?us-ascii?Q?84KcEblM/4WnPVcj0lJhFgguxctgIXYIF6wO9RrrTiShtWFKqORLUrFzT49K?=
 =?us-ascii?Q?yPW+i85fFNLAzLBE8Xumo3aGdSpV5tPgub3rdgCCX7RD68u52BDO69SO1R/T?=
 =?us-ascii?Q?CsDxM8SfFqL8eDhmRXNqWmuiDnP2Ir7XHlsAJeze5RKxR87DN8evhIbQt2M4?=
 =?us-ascii?Q?dnaSiJuXwTo1TR6sOeH+JgcDkfD9typ0HZgIzhVU0YJLdgZbTzKYFfzd3YXK?=
 =?us-ascii?Q?+MyHA6fE4+j4damv7Lhf/n4tYQZnJnIaytIbZJVJIcCZ4lvjD93AofdS6b5T?=
 =?us-ascii?Q?gSgg2R4/MAUHandhwhRpdboCZ/yAZHUIxNdWsQuUoTBKTIfit+hyamZMJ5xQ?=
 =?us-ascii?Q?QhwbKOV4SgzqZrTJoWrIMlIfXivLLI39a9X65ZW5S3s/ggqRV3/uhz89QFYs?=
 =?us-ascii?Q?RCHF5nTp2uwVAYfdUxeWp8oa7LOmsJrORIDUjNjx4djIuOFF+wNaBKeMpXyb?=
 =?us-ascii?Q?GuCm+q8aR1H7Xxah0YiQbC7cX9wE+QrOgU4CjAk3JxahsLQBw/VLWRuKTuHZ?=
 =?us-ascii?Q?xM6bWqjvlA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e47e36c-e399-42a7-3556-08de9c74173b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 11:25:55.2842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJKuXfyfWalBV0XexoZJ93Zlw9lxwo+q8/fbq6aRC+ihov2vstPLPkFf08fxcoJnrFQDwxSlQEY9Qerdw2060X5dierC5mC7uHYQtyYx4xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP189MB1876
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238480-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CA4841AC91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>Subject: [PATCH] tipc: crypto: require a NUL-terminated AEAD algorithm nam=
e
>
>struct tipc_aead_key carries alg_name in a fixed 32-byte field, but both t=
he
>generic netlink validation path and the MSG_CRYPTO receive path pass that
>field straight to crypto_has_alg(), strcmp(), and
>crypto_alloc_aead() without first proving that it contains a terminating N=
UL.
>
This is not correct. TIPC guarantees the algorithm string is nul-terminated=
 one.
>Reject locally supplied and received keys whose algorithm name fills the e=
ntire
>fixed-width field without a terminator.
>
>Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
>Cc: stable@vger.kernel.org
>
>Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
>---
> net/tipc/crypto.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>
>diff --git a/net/tipc/crypto.c b/net/tipc/crypto.c index
>6d3b6b89b1d1..60110ea0fe7c 100644
>--- a/net/tipc/crypto.c
>+++ b/net/tipc/crypto.c
>@@ -307,6 +307,11 @@ static void tipc_crypto_work_tx(struct work_struct
>*work);  static void tipc_crypto_work_rx(struct work_struct *work);  stati=
c int
>tipc_aead_key_generate(struct tipc_aead_key *skey);
>
>+static bool tipc_aead_alg_name_valid(const char *alg_name) {
>+	return strnlen(alg_name, TIPC_AEAD_ALG_NAME) <
>TIPC_AEAD_ALG_NAME; }
>+
This is not needed because TIPC only supports one algorithm name "gcm(aes)"=
 which is 8-byte length.
> #define is_tx(crypto) (!(crypto)->node)  #define is_rx(crypto) (!is_tx(cr=
ypto))
>
>@@ -335,6 +340,11 @@ int tipc_aead_key_validate(struct tipc_aead_key
>*ukey, struct genl_info *info)  {
> 	int keylen;
>
>+	if (unlikely(!tipc_aead_alg_name_valid(ukey->alg_name))) {
>+		GENL_SET_ERR_MSG(info, "algorithm name is not NUL-
>terminated");
>+		return -EINVAL;
>+	}
>+
This is not needed because the system guarantees that the string passed fro=
m user-space is nul-terminated one.
> 	/* Check if algorithm exists */
> 	if (unlikely(!crypto_has_alg(ukey->alg_name, 0, 0))) {
> 		GENL_SET_ERR_MSG(info, "unable to load the algorithm
>(module existed?)"); @@ -2298,6 +2308,10 @@ static bool
>tipc_crypto_key_rcv(struct tipc_crypto *rx, struct tipc_msg *hdr)
> 		pr_debug("%s: invalid MSG_CRYPTO key size\n", rx->name);
> 		goto exit;
> 	}
>+	if (unlikely(!tipc_aead_alg_name_valid(data))) {
>+		pr_debug("%s: invalid MSG_CRYPTO algorithm name\n", rx-
>>name);
>+		goto exit;
>+	}
This is not needed as explained above.
>
> 	spin_lock(&rx->lock);
> 	if (unlikely(rx->skey || (key_gen =3D=3D rx->key_gen && rx->key.keys))) =
{
>--
>2.50.1 (Apple Git-155)
>


