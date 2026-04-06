Return-Path: <stable+bounces-233456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BgFCe841GkksQcAu9opvQ
	(envelope-from <stable+bounces-233456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:51:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEF83A7F2F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4D46304A6D7
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C87E39FCA9;
	Mon,  6 Apr 2026 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="GQx6qY5S"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021107.outbound.protection.outlook.com [40.107.39.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA95301702;
	Mon,  6 Apr 2026 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515816; cv=fail; b=N+nuJnsybClvrs2ZD0gAb6cAzuRYhQSLNrFcpEhlHC4w5CUI8QjMiXD7x4qeQqPcVli59wYH6A5O6V1iIlae6PBT0joVzUmuiYhmFznVmTQuZf0Ak5kOmqeqM+mCeZIQ0OOJVASZAgJMwUfUL5+0tgwDrN1V1PyZyLi6gssKtMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515816; c=relaxed/simple;
	bh=7Ynml6zjeMNi2ia8F+WV7qVb3/jj8i6YjXpDh/WZkqU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nNFmTmcJmGmyrscBIdcZh3Kj8GUuxY3+O3IpOi9IxP34eRysr595eNrcAvtU5qWfIlblHPUutgGDUW4yFhJoEaMGDGNjT7DeFpZXCQfiPmjdNppQ3PLTELxk3F+rpoRZ7p+0TIxZw/KIFkNM8XDG6/ySC1LwiG7s+qW4cFGcy3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=GQx6qY5S reason="signature verification failed"; arc=fail smtp.client-ip=40.107.39.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8Ey9rEH35tdX01MuaoW6LHIPFM+DP8qjUtV5zizPM/a13C+JUGQP+hMusuhCb1g6jefRefUx86PTaAtO9uqO4hqdGGVwPs215562Sf19I9f0bh6z20CWIRMTzSNzhPuts/mN2vNUIFSbo7zJAXbKd1bx0o92dwksSfp2tUInZ1n8go+MXmpvMyZRwugZCp2HYk1AW1UXRgIIiI7sKk+9wSLoqwHJgZc71fhBLSpYJF0mD/onsZg+51OiVd9M8iUaUeyud0PaPtLzqD90lJTWmKgZl+uXC1Ibd8TdfbqaMV9u+W8koMz/VEUWsafwKBuD7zl/2izDAoEWFMMu55Qhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVzOgXajUk80S0N+A4BMePF+CD9wsaEqAI+nCMWF2ac=;
 b=RvLgJ8TmOLKVik+TZrVC3UVCk47ogCiAnq9GN+yrR8Gr+z8RFFEl+qao53gvtIkc5j8O82kPNdwkaRgmTmQUWugp0BU1D2x/UkzdDVsqO9vjayqy5SvnCvISCNDTrBu2EeRlXlukSzVAcVwWnF2YYChG005Ku+l2DZJJHkxQ6qlIuzw1DmyXP0J4fZN8q+KljAupvPzkfyGrT4kuIJNJAxbM3Wds9GjqpE1hUJJYwLDPgWNhgHwAsmsl6j+xMkqape/vsM6w54Xd7lM8NnU9lgiCuF0qx7aEaCPC2gwFeAnmAJb5Qi8fTqf92kI7jhgeM1F8Z+HbQkz2glhhm5cYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVzOgXajUk80S0N+A4BMePF+CD9wsaEqAI+nCMWF2ac=;
 b=GQx6qY5SKv0hXCiXgOJ4OmCuoET53rKZcf8erkYRSmA7UAVUEDeY7/zT09f+psc2zkEyfpiCasdEm2hQ6ylNIRvOcdrWBzgldq5q0nc25dBgTF+4M5W1Odeq/JXpQ6zXukVPWajsriwBb8rrzrSFfBaQMD2Xy+szbvOnSaJUgG0fUWIrbis4u1vSmYiceugS6XWSd3TG+AIkXS5WpzJa21hrcsAZ0p8qA7n+YePNQxP4XudnrMxwIc5qeWsgPaiuihvvU6CB845A1oi4u5Ny2OADMPScvqyWAb/28sLbHvxrfDHsiwZsZdUu3Dk79kEEm3VYjxpSKdbLf2aaKy1bHQ==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1529.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 22:50:10 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9791.012; Mon, 6 Apr 2026
 22:50:10 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 0/2] drm/amdgpu,radeon: fix integer overflow in pitch
 alignment
Thread-Topic: [PATCH 0/2] drm/amdgpu,radeon: fix integer overflow in pitch
 alignment
Thread-Index: AQHcxhe4vAcg6Tyl7ECcyppIjIL02A==
Date: Mon, 6 Apr 2026 22:50:10 +0000
Message-ID: <20260406225008.2787532-1-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY9P300MB1529:EE_
x-ms-office365-filtering-correlation-id: 5e8b937c-504e-4e30-f723-08de942edb3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info:
 tcx4h7iiiljokaWyqJ/517FDOQ4X1T8cBin27xx8syCzju/MIhiHpczSRUir/UM2LFOPV4gvj1S9XuMMD5GDGgOoHuC5B/nuOPGDHFwa/VY2XC2h2PS2ihKoqXOajiKmaeXq6tWeglFkFOQeFssvbDLpjYUOhWGfFoPd1/slfIUpc9sCTl5NPUjL1OLz3WTUaHBOZFknNP2sgVYU/A1vh0aKop52ke40rP4voMZ4HHgu9XSOC3wkYXMbMkkYqNHIJsHPoMegXDu5027BX2EayhWBUBNhpKWS8RyaAg7F9449wBriTGRhghB599Ug8VSKdeGZEnlglWmjLGPzBLONzanyUNf2l8zhw0bSUP7MpotRtpG+/fM4hTlsI1jmlNvcqGXEprkGrRXHRWv93Q0awMCS5N8Ci6JQR2pqeLoqPbu+uvZol2ZzgubAfWiHZwVbgO2VngiAz+qk0Qwv1c5ubA23JsCud7SQrQ7JUT50YQZUz2zTxCjZkBBmSxESriEMyU+zdSgCYvmLRHh8JajZPlqqGm5kuHKlamPmNPgk3wA1F+JqrAK2H/i90YrwLGfR/cjvtzlmmwKHvhK9BthJ8D91nQZTT3VE/qETMcw7zI+ldvMjBroxcf4xawfUyOIMFKQSO/jEs/hmYbFx+KRYdlAl92guihD/V0IGUsWd5feMazQbuROTrA56bk/HbqTdHO57KlGQe9mc1hEWhuS4RnVvDx/S7Mgx2sK0uFti4JyeKYW4HHWVCn/z+J42gB2Wi9bLHrHpqm06fnN7cYo2HDdUND7ELYtNuYiGWmnz5x4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vtmCdN9hARt9r4bi7/qxr8OyJPfKvdLMAw9EKUiZb5TKfJw7lQOb7JzpsN?=
 =?iso-8859-1?Q?/cXCY+17M49dirPNirBNFJdmz6ku/7Xx2/HJokIsyZXxk+ORa9YvG3TfDV?=
 =?iso-8859-1?Q?jV2HlTDivL/ENAdDLK2iyCssxVunb4YGwZdiSpjDCSGVOTxX5DGJ4BPSA+?=
 =?iso-8859-1?Q?Xe+rkn9TLFnwCpqXcMghCWky/pz4bYEfg6RrUaqQYi7dxXBsO+oFcfPJey?=
 =?iso-8859-1?Q?0xBkMvuWsqbRsCe7c0hczKY+ibdJGvNs1gHzWYLu5tVRkqsVmcjSRxzCvV?=
 =?iso-8859-1?Q?4TtUhMtvV0Qgz1GiyA7xaa//vFDb7I7VaS71CTYxluQdLDGvOFeDxKc/V6?=
 =?iso-8859-1?Q?B7ayCGBIbiAIprKKGBCS/RWgs29PqkJno3zC0XgepuKky7L63JiDQxtceM?=
 =?iso-8859-1?Q?gUULiv7AOcNRBEVeEnkyve5Qwri6MTsEVGkiG0yJSJtV/Kk536GYfrib2p?=
 =?iso-8859-1?Q?uxNpw4heLsYWB8SIK9VySgZI9INt50ti5CMhPfDZhJNMXHslYkxqwAeDc2?=
 =?iso-8859-1?Q?TwIYxespvJfyKz3QOMN49PvKvjAaeQd4WjX5FqELLj/046IJyFbuyULPYW?=
 =?iso-8859-1?Q?X2LsFf8PXJhCFq0YOK8sDUCdzChFD/HA+Vh5t0mp8OCp3aRNDVvVIFWpBy?=
 =?iso-8859-1?Q?Y7i3sGYuW2Dzb6PT5fJdaYr5eNJZ6LgyO2IcnX3HFD/AbgN42LXJMjvQ65?=
 =?iso-8859-1?Q?d2yLldtQLpgLypSmRG90W4SOFRWTqzOtdCbHGKIZFiuYn7NAgG3mzmk+Gp?=
 =?iso-8859-1?Q?aqvdET6UjLORoMc/jx8uY4HC5PHAr7bV8NNt+19vIm7C72WxmKJFffkHh+?=
 =?iso-8859-1?Q?MEDLgIxuze4zFTnUAts6LP69FcRszaL3K4cIbzksuNY6i7F67hVEjBhAzn?=
 =?iso-8859-1?Q?4OQZhoyhzj5vmxroljxAm2IyYAmc5GiODnoX1IfLgzoyM1nh350mwdIJyC?=
 =?iso-8859-1?Q?7YoYnUExUZA61WkyIYEHnT2Ii2Ee+/LftzY9O0FNdX/yadCvb++fVAYiI4?=
 =?iso-8859-1?Q?3qETV9l1vTBaFjO19rvBXJy9BreRUZOyIMF5Su+duFfdIlX9cU5S3IE7R0?=
 =?iso-8859-1?Q?iD5jQNdRpQ38R6ANcVGKcOxS2vocebG08EDcT6qLTd4KofdMXxTbTrF1wK?=
 =?iso-8859-1?Q?Ut4SJkjdkmxGylCiaY+z+S+LzUh7N3Mqry5adpwTk9lLY7jKpQdEHv4n0e?=
 =?iso-8859-1?Q?ISqQvQAHk1u/cdg0WJGSL8gkablTPCtZ7BN42HzhgTFBjVDMljAf+MKDaT?=
 =?iso-8859-1?Q?qXhT1b56z/kFdVgk4wocYzmjb3tQY2I4SxAsnCM7CVuDbd0JBwWBpssT5Q?=
 =?iso-8859-1?Q?+ePKiTCPNwnvkvUXKKoEDG/5RsQhcBesu8o1LlZXgDQiddmlHICa8jpoEF?=
 =?iso-8859-1?Q?sMvEt53/WBXL5J5PNEU0jDLQZqmJ4VyPpPcEPfBf4VV+gVT2GNfopaja+w?=
 =?iso-8859-1?Q?0HXMmlBcX9d5vmzYr6KDG+nykIJqOQ7FYQGxNTM8l255IOToUC0WdGkK1V?=
 =?iso-8859-1?Q?BvBt057TSEQck1AZsPMjtVs4SGMuR4XZD+ke/GQ9ycgPJaQi494WouCaBI?=
 =?iso-8859-1?Q?tHAPNUldYYP/G8ozsiIjXoQ/h5BWYvRgO3s8Ph7jGN5nqf14LiH7vJITeu?=
 =?iso-8859-1?Q?7U4iojMLTJmsXWq5Y8QeS/cHSz9XFJNVAL5W6CMsRWGplljpsDvKHP/Jqj?=
 =?iso-8859-1?Q?o/UKMoa9lpHul6IWbJ01WzfEk8qe+fYkW1V9z/bwuztvD+yTGv6m3kkxrg?=
 =?iso-8859-1?Q?h8qroVi81a6x+ulKb/Ggw5r4+rsaPq94k6xjT5O+3FvP6z8jUN4+WZseQL?=
 =?iso-8859-1?Q?SlvoAbiwdg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8b937c-504e-4e30-f723-08de942edb3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 22:50:10.0461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGCWbQmu5J7QKAVi96V+AILpTWhcK+TOKudjBVbOGqYdj61klm1QV7kXjdo9d55E5JI45WOIsXM0FkhmEWJ67w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1529
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233456-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.684];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BEF83A7F2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both amdgpu_gem_align_pitch() and radeon_align_pitch() use signed int=0A=
for the pitch calculation. When alignment rounding pushes the width to=0A=
a boundary value, 'aligned * cpp' overflows signed 32-bit int to 0.=0A=
=0A=
This defeats the overflow guards in drm_mode_create_dumb() because=0A=
these drivers bypass drm_mode_size_dumb() and perform their own=0A=
alignment rounding, which can push the pitch past the pre-validated=0A=
range.=0A=
=0A=
A zero pitch propagates to a zero-size GEM object allocation reachable=0A=
from unprivileged userspace via DRM_IOCTL_MODE_CREATE_DUMB on the=0A=
render node.=0A=
=0A=
Both drivers need the same fix: add an overflow check in the alignment=0A=
function and reject zero pitch/size in the dumb_create callback. The=0A=
proper long-term fix is to convert both drivers to use=0A=
drm_mode_size_dumb() as Thomas Zimmermann's series is doing for other=0A=
drivers.=0A=
=0A=
Werner Kasselman (2):=0A=
  drm/amdgpu: fix integer overflow in amdgpu_gem_align_pitch()=0A=
  drm/radeon: fix integer overflow in radeon_align_pitch()=0A=
=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 13 +++++++++++++=0A=
 drivers/gpu/drm/radeon/radeon_gem.c     |  9 +++++++++=0A=
 2 files changed, 22 insertions(+)=0A=
=0A=
-- =0A=
2.43.0=0A=
=0A=

