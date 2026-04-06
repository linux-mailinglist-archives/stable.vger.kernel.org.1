Return-Path: <stable+bounces-233458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKEKIhA51GkksQcAu9opvQ
	(envelope-from <stable+bounces-233458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:52:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A643A7F4E
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70D65307B020
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 22:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2894139FCA5;
	Mon,  6 Apr 2026 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="Rc+bNYGp"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021107.outbound.protection.outlook.com [40.107.39.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462938F951;
	Mon,  6 Apr 2026 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515820; cv=fail; b=SliUN2iP1ayu4j2m9iKWnJczGIrj/wsBn9l3i3t5G9bbLdRMfD09IVkupU+mnQHWyh8gw2+BKUj6OIhWn2XLprGnNGnvs3sdugW42KTQuj6Vg3rA9zRkZaVV/J6pkUZHd8BVUiee31mSaEFyOBAjYchZhyfdG6NiWyLF7kJAV5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515820; c=relaxed/simple;
	bh=7rM1byFk5X8dkvHPlOxl3MmrEx5Cff8gMvLpBjesihQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kw8dTm1hnCXDSKOQMagv49I/Zt05XaN4ImBuPduOd4xWPwCdzlRHZExazCBOHqXAKlnDGagBDPVbqwnMqoP0i4g/5fTeqTq8gsfckJsmOGH65s8iDy4TnOXaI2d5Nw3mxwJKR6T7CrzASd6X/mQNaiBPFqn8MUnsGTOW3/M1sNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=Rc+bNYGp reason="signature verification failed"; arc=fail smtp.client-ip=40.107.39.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blArsEzCRbl2LZay1D0wBwwW+8TmRLJiihMcNWiVQyJ4zsX2HSUfJJfKCJ7vjG5Nfmi6rmw6dmRPD14WTyZOJLmmBe0ZjswaTP/2Q6GXl+EipkbucV/FB11zmxt6/Z4u+t7JxytwXc3/a2tVNi93xjzBB99rMVhHDQQ0uNqIwU7VcGqTUaHC1xmZAhpGeRG7NClJu9uOVp6dhO1htyA83AyV9xA8SHXOnpJNB7LKLx4jFmQwLSuTaZ3BK4PQ+PztcGZU/NdEMDRu/pK0KvpeOyxp50kBPuQ/PhZZmy80lofPs3Vqa0mcJRHt2hXcKfps/SUU5mmgpQtCsJdfo1ZoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkfmvl76KIv0za+D5yxQFQbYXaq8Hyl4WicvMyPsOhk=;
 b=gSW4xpiE66GUZd1X63pCfIhLyGM4VrKN8KzBLNQtzl76Vum+oZ4tD1z8sK81h6oNFQiLWxP/eaU6d1BMrskzwZ7VyrqbOvLLCIu7rPkb/g3G9KdW5h4Y9zxEYl5w2Pxnder238jahRkvqgg6t1X0xj0a6vg6pMkETsLMh2Y2E/ff0S3gBmMzjUNncg9EunkVSgU9hepfPmLQ592TRd7r4E0Jys7btIzIKNtGPBQO4o6F4OBCCVN7gj4tsJOUa/yI2HHx9f3EvjdcKtKKkVe2F7cxajWfqZ1QRl9O9bmV1Gey4npGGlHevFJDb3iQmswqp8CyqCjczAJlnoLykH/Gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkfmvl76KIv0za+D5yxQFQbYXaq8Hyl4WicvMyPsOhk=;
 b=Rc+bNYGp+1PeaxGvFybOyNUVKl8tlHHMBy+x0JB3TQDVqyTca7pkOe6vg+dQJfLA/5uEolJS2zDUVdMTPXAzY2F203HDUJpFLddpCY0oHHd64As7rmzFffLO0yMCoiNcMmusilVTP875rLSgap/uAnBWXc9v7B3jH2Mb2wjZj+84F4dLTcAjRKk4I0ipz59gS6WYPUeIaMYMqfgCYssZyNsNbLroeHcUuWxIMRWbUCNuTszE2SeUoFZo35UOPwcuNXXaNPuQYIooZ9bFlfSw99pgaA/r8BuU8ZF0vY4zoZ84XCM7PbfinGxSv5dIjDqr/XABQi4juT+UHey3V9sU/w==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1529.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 22:50:15 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9791.012; Mon, 6 Apr 2026
 22:50:13 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] drm/radeon: fix integer overflow in radeon_align_pitch()
Thread-Topic: [PATCH 2/2] drm/radeon: fix integer overflow in
 radeon_align_pitch()
Thread-Index: AQHcxhe6PJ0AuC9Nv02UL7vWN317zg==
Date: Mon, 6 Apr 2026 22:50:13 +0000
Message-ID: <20260406225008.2787532-3-werner@verivus.com>
References: <20260406225008.2787532-1-werner@verivus.com>
In-Reply-To: <20260406225008.2787532-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1529:EE_
x-ms-office365-filtering-correlation-id: ad7f0f28-85a2-424b-bc67-08de942edd78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 +/AupedmgxC/+KQ0wFk5Czc8MVZZOkiLIU+0Hmjd37og+ktV5Q7M2dy+XfXE/87UmLAoBPEdjE+XutFyssAqXk2C2HbJkHulaun04K0cr1blZmrqkERwzyy2xWsqLIGcoWiwKwtFLfrChF6AUfTUQHBiE8M5Vv2gr1LqO/iJEtjR5sxBFzWpIOQH9rUifpQ4QH4mx9ZJEepizNbI+AgqSrqBn046swcOGL3Qbvk/x49AKC36IIRdplK9k1KSN7rwInRAkyTOecD2fUqM7S0PUtwOfQHn1DO8y2K7qW8qRhpLvT3vn5sKBNcjBllMu3fm0npydR6tjerRpEOe8jPazy89D01KyTMhV+deFcXRAqtuDJ+I2RNl5CgU8ojjcd/9jVz22Ntcv/CgJNUakYr3POE2B4ZA3Gz17O84T3k8IXmGoKdPL/2bHhfn71ENlt0Wv3kPe1DHyQVqZdW4etV1U19t0l2Jst5UtswdJ5U6l9OnkB9OKZexjOY6X3s5+vmzcQ4CZ5CQr5DNg7pFhmjMXGj8kCO9OZvehQpIdcNDDNraBeOPSIfUi9EUkK22euMOL6SsqpW5YRy1fvhnaWgvPygf9UdkQbGMpI3+iZ4YiskWdB5ZYmIugHemMxJwnEPWZCfrOVo38n3SlxxzjyyZAr3EH7gAit0gAj3R3xxwfv8gmHBD5kO7v6UeNxbeTRXHuXxCPXV0PjMZnJKp4TcBfk4So19Dp4wBgl++TBzH9mRiSpgCASwojZK/ed1GHDDbWQGVbvb2yq4GonP79it8XrBCH074TNu1+q0y7AcNcYo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Z3Pk7HgY6Z3C+6nyuKJoZnlS25mpld86L9JKVfjyv2xK8f39SqMoPDDBPD?=
 =?iso-8859-1?Q?Rf9TS0APvGEoAffsvT0hhTSNKRGODGZGLk6cuCebMMd04+OQAzUWHX/Org?=
 =?iso-8859-1?Q?D+dq30D4VKAae6iqPDO+DlorL+mnux7w5mT0Y7TOGHaXMs7JAwK/v4+0y2?=
 =?iso-8859-1?Q?F+gt+ArB+Azw9btoMjLQYPvvVGi0bk6c9+oMOCd0OYoTU/PYqWV9QWq/H5?=
 =?iso-8859-1?Q?mnkfvbQtjsSk3tjeDw7pH5gL7Er45aC2oNUsuc73GLnyW0X2Ftt8MmrNuq?=
 =?iso-8859-1?Q?8tAEjEj9DXgLHHTRUOCQD+WEy2I43impDL3kF/DKGl/VW+NXp1xE9Ad/lE?=
 =?iso-8859-1?Q?EcM5ZTm7WGeXAKOttMFpE9fNp41hBEB0ogdYhAXDmaZ13SoCpf0kkSA+pv?=
 =?iso-8859-1?Q?dRG0saImCPIZ/NK721H+ed7jhxOoLUfsluHuW7D3aCZ2w/DbvpqTzRPTqA?=
 =?iso-8859-1?Q?jZRXojBlAhd+qAW4VPrT77qvJi9+QWz7QvXidiVh4y/mYL9nn1896edFMp?=
 =?iso-8859-1?Q?5oX7qcEb4L41hzoOEhr6KekyVlNFJalBIbyK8cAVVlkXH3OXGbrd8K1gA/?=
 =?iso-8859-1?Q?2Id9K8NlE7dMQKqjD/kLCvhYHktMjhfn808f8TmgFQJtP3XIEMCLljjXTn?=
 =?iso-8859-1?Q?chXuDeoXK2SOyq4AoR8L8Vop+nEM6XSD0Mb3nZI+yXW9ISAhJtmJID/zGB?=
 =?iso-8859-1?Q?0omcEwkImBsUi/zgDkslGE8ZtZ5o1K+RNgUiePw5aDrvjG7W7ZxD3yVzyL?=
 =?iso-8859-1?Q?RnhUWoH/pCY3q86+GInjdD3YB7di16NX291zZRz6Xdj0YlE19bvcf7d8aJ?=
 =?iso-8859-1?Q?OMAKKzRh4JwYZiyWgiHlNZ8XBclL3TzbEtXWFgCksaBXU/Yal5UFMAo7cA?=
 =?iso-8859-1?Q?ax7S6q5k9Qc5/JLis3Kay4X1Ew5lX/EUuqKT+ihdTFVQYK+FAhFaV1wdBy?=
 =?iso-8859-1?Q?lorFKhCNimJCaoVYjcXwywnoeN9ihYSeIAFpTwqw+hq8lIyNVN+XeYkteq?=
 =?iso-8859-1?Q?c6N/tdrEH0gSNViLa47X8OzixGUyEeuCT9BvnJ4Oz8DIt333xkfLkhbLwD?=
 =?iso-8859-1?Q?lzrE5oP9hhM7X1JT1Yr0TfkQk0ANQxxFxLSR/jvdkUATKLacClNXcMb8so?=
 =?iso-8859-1?Q?sXeCVzWkPYmJ5hGpDCEuJTYrzxLGMtGEljjpZHLK4Hp5Soo6Lu2bfM69V+?=
 =?iso-8859-1?Q?LlxSSFtGOSGPRwRiR7hf+QeKJG6qagR3BJKWEr9dJBGvd7YJcyqOw/Cvoz?=
 =?iso-8859-1?Q?qRxzovtmdb245AqynleD2vaMcJFe1vHTeNHXghq/dmQWFy/c29eKqu9PbP?=
 =?iso-8859-1?Q?VT0cJ28cKoidl072QyQ0QLk7n9ZAQmMdgf71OIaTVAGGiq16yqGHw+BRc/?=
 =?iso-8859-1?Q?ZrKT4qK9ePDuk72/oRrMwoT+abS/tulCf+EcBTwdElLtGkQDG9F660bYUB?=
 =?iso-8859-1?Q?XQcOCQN0dKrjTMBsldnNgNP+0XB4sBjzATHKkyozTlAX4JE0Jx1u0mDc9i?=
 =?iso-8859-1?Q?uFPe6hS/uvUIqqGojzqa7wsd2YVcByDcrSW/1tSWfznCqY57XgjDajTAQ+?=
 =?iso-8859-1?Q?+DSPI75ngToDKSz3uwBSzRvL7kaLDyFVAH8bMi3U8kZMMU/Ktzm8iEKrMl?=
 =?iso-8859-1?Q?CaC7lYe28foWP+PgWwLvEgdmJ4AeW3UqU1wxlY9Ln1aHRKZVOM592nZTl5?=
 =?iso-8859-1?Q?UG8KyFgONT6B3OysIw6bstm+hu3MEYeoellB9ziyxMrdzdN2SvzpxSneSh?=
 =?iso-8859-1?Q?bXiuchldTjHOE0j3kMx8f5TwH5v0FWo/Jklx0f6QfnqwCmMWGKdf2gPLmA?=
 =?iso-8859-1?Q?DcGahwI1eA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: verivus.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7f0f28-85a2-424b-bc67-08de942edd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 22:50:13.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDk/Wz5FimbtviDSaIICSubRpEQ/viG59LvJQ2gjruwAdyYM79uAkY0We22kPa63REmlNf3ctW+th3D8cXoNkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1529
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233458-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,suse.de,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	NEURAL_HAM(-0.00)[-0.729];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:email,verivus.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03A643A7F4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

radeon_align_pitch() has the same integer overflow as amdgpu's variant:=0A=
'aligned * cpp' can overflow signed int to 0 when alignment rounding=0A=
pushes the width past INT_MAX/cpp. This produces a 0-byte GEM buffer=0A=
via radeon_mode_dumb_create(), reachable from unprivileged userspace=0A=
via DRM_IOCTL_MODE_CREATE_DUMB on the render node.=0A=
=0A=
Add an overflow check in radeon_align_pitch() and reject zero pitch/size=0A=
in radeon_mode_dumb_create().=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)")=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 drivers/gpu/drm/radeon/radeon_gem.c | 9 +++++++++=0A=
 1 file changed, 9 insertions(+)=0A=
=0A=
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/r=
adeon_gem.c=0A=
index 20fc87409f2e..2cd179fef347 100644=0A=
--- a/drivers/gpu/drm/radeon/radeon_gem.c=0A=
+++ b/drivers/gpu/drm/radeon/radeon_gem.c=0A=
@@ -828,6 +828,11 @@ int radeon_align_pitch(struct radeon_device *rdev, int=
 width, int cpp, bool tile=0A=
 =0A=
 	aligned +=3D pitch_mask;=0A=
 	aligned &=3D ~pitch_mask;=0A=
+=0A=
+	/* Guard against integer overflow in aligned * cpp. */=0A=
+	if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)=0A=
+		return 0;=0A=
+=0A=
 	return aligned * cpp;=0A=
 }=0A=
 =0A=
@@ -842,8 +847,12 @@ int radeon_mode_dumb_create(struct drm_file *file_priv=
,=0A=
 =0A=
 	args->pitch =3D radeon_align_pitch(rdev, args->width,=0A=
 					 DIV_ROUND_UP(args->bpp, 8), 0);=0A=
+	if (!args->pitch)=0A=
+		return -EINVAL;=0A=
 	args->size =3D (u64)args->pitch * args->height;=0A=
 	args->size =3D ALIGN(args->size, PAGE_SIZE);=0A=
+	if (!args->size)=0A=
+		return -EINVAL;=0A=
 =0A=
 	r =3D radeon_gem_object_create(rdev, args->size, 0,=0A=
 				     RADEON_GEM_DOMAIN_VRAM, 0,=0A=
-- =0A=
2.43.0=0A=
=0A=

