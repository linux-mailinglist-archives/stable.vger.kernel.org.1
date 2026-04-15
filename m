Return-Path: <stable+bounces-238224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNalKKAO4GmzcAAAu9opvQ
	(envelope-from <stable+bounces-238224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:18:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 313FD40886F
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 00:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8973B3151719
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56033815CB;
	Wed, 15 Apr 2026 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="cQx+8WZ3"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020131.outbound.protection.outlook.com [52.101.152.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03034383C80;
	Wed, 15 Apr 2026 22:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291239; cv=fail; b=kfnBwlp9tADpbMIUMi1fmRMje4pYnv5d9XfGA0OdtLSMbvt9N/VRcWajLMK6WRMGH4fmR+FsJvEwxP6o1x3YvH31LyEco/qeBh0EXnAX5RJdpEG9V5d6oUoSo/Uqf2pXzNSgYtmCVT4RWRW0PcJifHsxH0mF2lrcDOgg6KhGpVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291239; c=relaxed/simple;
	bh=TvGUGA9ae+aMvyLF7d9OWnRmwQHDoJCO3YuN3j4Kx48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J6Bj+iw9CWR0bVmMcTPflAql5J5HGEvnRrA0/I1gMjUrV4wuRdPksN0xblif1ZxVjIc+L3jHKEEWNwa+vT3/K7F1c9GmiYo+RQF5CsMVc+APjlf7gnGIIgEvbCPOgHsG6403l0x0K3ivwJzxxewycsrDDtpR2v5zM/8xO5AlhdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=cQx+8WZ3 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.152.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/rMoCv6gH1hYojm2zmdyZgye2tgt6L43+7TFc7+x7cXulFFub2AvzdEmEFJUSC4FXXlHas+1zsMokpD/1bG3ZiqQaBCaWuWyUvczp7f1ngDJtHK3y8c0nfSJ0A9b3+k4la4sf7+Sb3YZ90K0DV6SFOd6FviYl7yeb/eaDDjYPMfMz8Tiabny7DpQZUPCK1aYAXuu7jXlxRURzvUozPaFvlvTguqNrqB6RlPSDvwvxpUea2AMKUa3Tzub/ZyN4vMI+C91VWq67QGZG1cu2Ic+41ev8JylnIxXsyHS/KUdgPhjLc8Be2PzefQ/l33efU34YPS6Pyo0bNimQpO7ZxI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzRZCi3r6ShmFgtnLwQ9BxhAnhMetiEVRtksjNEe9GY=;
 b=krfjmPxRHUYfGjRNh8d0QhxfECXFmGJjNNSsd5lc8XaWVuJAkreKxcGKNemkbOFTcmVASe+gbG7PTUcDHSqRy8pFID2ounbYkKP0JbaP2jQ+XNHOtqnwmDT7xaz4GYh/krkdRODFjYo/dI83ELAwJ6R7TjlNphkT3TCqJ8Muj8HHEO8Hnhzhwk6SFdJydbQn/fF1VCQPbvL340LVXs5WsDYnvUFFQgQFEg8nE+2DKH8GbS5B7hwKBdnYN6UEM1Qc/jYjCudzvsEifPMp2h4ansjCI3OVUUCCzdjJMFoO5d9HdAB3GQ+PqYEADCyB7R+wQlvXOFgUMcEWwxyiI+sguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzRZCi3r6ShmFgtnLwQ9BxhAnhMetiEVRtksjNEe9GY=;
 b=cQx+8WZ3Tbt17TEg/EVqpHClHsO4RIaSsfvvpND/AmcId+Xf0XB7QqSGLMY2psieh8WQAYe9AdOTjjWutQm8pH4ERZMcjipB/r4Ze0/l4YUEaRXIfzb9PnvDnVqDkv+sx64yu2jIvW3D++SFMLup4PTxgs1+RSm1opjdfzUWhOzZVJZrR23beSyjl03E2f0iisB4oQbgSEwyzNqy79ZUT+SwRufSPBRNSOCJj1pF3N1Fu8SkQI+B6PhgemAnR/iJi97Yi/vbH0QiT6biFBqgxKIfGmHbJLnHhhTBRuv9zTpLznJiyJ56UWEDz/7Tn/3/qBFYn3GUHXnozu71hqmDyw==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY7P300MB1372.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 22:13:53 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.023; Wed, 15 Apr 2026
 22:13:52 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "alexander.deucher@amd.com" <alexander.deucher@amd.com>
CC: "christian.koenig@amd.com" <christian.koenig@amd.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Werner Kasselman <werner@verivus.ai>
Subject: [PATCH v3] drm/radeon: fix integer overflow in radeon_align_pitch()
Thread-Topic: [PATCH v3] drm/radeon: fix integer overflow in
 radeon_align_pitch()
Thread-Index: AQHczSUkJTa8wbZqiEW2GRBD20v1TQ==
Date: Wed, 15 Apr 2026 22:13:52 +0000
Message-ID: <20260415221350.1178094-1-werner@verivus.com>
References:
 <CADnq5_Prw=X66ByOAutSV_jFCJ7guuRSMPWnEqttr+xe_j_Y4g@mail.gmail.com>
In-Reply-To:
 <CADnq5_Prw=X66ByOAutSV_jFCJ7guuRSMPWnEqttr+xe_j_Y4g@mail.gmail.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|SY7P300MB1372:EE_
x-ms-office365-filtering-correlation-id: 5cb3099c-a7ec-413b-314d-08de9b3c4714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 mbWMNki+uW+FoZSdPbNz85usPtLju1VO5VLnar8SizLlo2zaTuJeYrUS+NOD2OtYGsp7T73D1/AgK3uAs1YmFJCXEwWjBXuTpsT1Nfd5l4VHKzM/8RUJv2OAEH1ophdUyP98XuKwF0oo80nOKLfkn62aD6qFUPFpCqLNR/bz1iBkR7e7Lzabu3Fzp45iybj4PFhx3LtYExgwZifSMVH3yig/IQZ2zi9afMzVK6eyUe1xEmHj1D6CtYF6Q99BJaehzG1QBPTs7i6p7b7Bny4STDVulm1hJcJdTEavMaXM7gKNWcCsPpZ+c/win7q+gHQR1sWb7DQvD6OMfBh4YLq9Dgii3Z1P0esOk93DBLEDexVdwFX2to5OzAES9Gu4YNA6FboUX0StaHpeY0k+fIXnOXJxGfzW0unvl+SdfEv1YagBwQl9qj2NFalqJ2FE6yRBHpXsF0h+Jek152bS0zrPMeHGdaHNhk67HpB9LiKxVj1BVK58DVkI2rh4UPbidGEYSvegCsACzx0k0/U40eztYQxMz4zVTxwNoAr0RoIaODjRW5OM4KIE0ZK0zbwb610iJ2V1sba8Biyq1hJ0XppDqzdDvoS2KUKKC4Gjjl3V9id/ZNrQFVsP9FuvX6BnAQ9oAWjAXqPXv1dyxezyEp1Z1mHuXuE6wY25SG3EZZXWvWXG9oxobqRboCl+Jg83COJA9/ZLuROgcqFtluF+ye5CYEUSo+VkBu1waeV5WyU/lT81FYW4h5ctZyDv4bfihNMmG5S96NqBGuvtxP7nm3EJThQFohktV3hFdHN2UpxTTpM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?y6Rza9Urk+6mMmudcKsii/wG+KnBK+9YP994TnSk3m3VUyB/8xowA6O6GJ?=
 =?iso-8859-1?Q?aXXkAIQoVeI7aQyQibgCYVS7YaqcGdtndg5wpKeYKO/afOhhMIXbIt93cA?=
 =?iso-8859-1?Q?FfJKvLxTdUOXfe48srMqLL1G1HMOp1vgKnCZHBl8J44L0LZleEgJSUjb6v?=
 =?iso-8859-1?Q?qOdaRqz/NeXdUlcwe4jbxkP0C/UOLt5QjdoyswaEAm7iRjsonNTKQ2xkWy?=
 =?iso-8859-1?Q?BZnT+1OzxrCA/VSeHpS+dVMW0/DKrtO618GR7SvwZNe5J1urV2ly8yJfxT?=
 =?iso-8859-1?Q?OyGgmn1Fmco+E+4hylcxwmYsqB04kv3j7q/D09Zs9BMa9mKTNISzQY58rc?=
 =?iso-8859-1?Q?8jwQvlqpAmPDQlS++wD3e+eHbSYlMH4FIJMB7rAreTdI4azj/FCJsiC9Zz?=
 =?iso-8859-1?Q?72mhDSyasHw1jmuoXiDZpqpd744XmaMLVt2N2o0aA8uMNtUFcXE7AoQGLz?=
 =?iso-8859-1?Q?p3SEnQQF6Z2POi1W5wWnVjG9p8uFH+PxnaxtSq4+M7sUzQHzY35DYPlvPg?=
 =?iso-8859-1?Q?cjSL1OF5Cetc7nN/6DPueje6VChZr94WrKJfBRMsXSVTpBwQlQ4E6v4jfD?=
 =?iso-8859-1?Q?XVlNsZlAn/okiNWFOLDK86kXSm5p5kDyQDhwsvC8iNHs2VfdU6E9UwEXcq?=
 =?iso-8859-1?Q?D4IHSRKR3/ORILL3eRDOQSFiYcY0hGYJx/Th9bval70DB59GGfi6uqrNMI?=
 =?iso-8859-1?Q?QkNB4ay0/BZnULMUEUiKv6Eqn/HtMiE3lu63jDLKdYWOYdOMchVz081fcd?=
 =?iso-8859-1?Q?YzEqZnqIMnl+hz9L6Mz6afzrZGvYVZwh5ojvARWUoc+2da0AnEiEcjotiU?=
 =?iso-8859-1?Q?JaZ1BFqZxmijaLrOB5dG2aqhZNhMH88Y+hF+YIPD7+1yha1HPxZywhZpgX?=
 =?iso-8859-1?Q?/3w5LZa8I5WKO8zpYFALPWL4yVXcjbjDPuBd2f+YDDy5RHZ8ysyahiigjw?=
 =?iso-8859-1?Q?Ic7SDjC9njXaXiYQjtTNOk0tXLWeeNsyabVr2byj/IV5nLaWNN0kvQqD74?=
 =?iso-8859-1?Q?5paY6smn7GODHabX8T9CVqii/dnIfKvfCIOmlAIt0izoiR9eC3M04IL10O?=
 =?iso-8859-1?Q?hYsTp2I4/MFAClDH4j4lhRtsL7HKl8+mDERwRKR2IWL40IZMRv7WoTDhpo?=
 =?iso-8859-1?Q?UISfMjXfM+LEFWbEIyDK/s8Jr/Koi5zXkYYctJK1AYCfpVnaqeyt6/rYto?=
 =?iso-8859-1?Q?4levqdoDgzVLCiDN+qfprd1Nz1oCwdV5lm9f1Mzfwo9qG1wQXelHI5hB8S?=
 =?iso-8859-1?Q?ehTTu1Ld0DN7s3aJY8TNv54HMlq0ZOZ2jTXX8zfTt8PsOlzs1OAB1QNB0k?=
 =?iso-8859-1?Q?zQ73s/DvYGAEGmdtFPWvCSZv/1Cr0Z+JWSUCp7BFs/Pn+BhrN7irYveDfR?=
 =?iso-8859-1?Q?KbOo0oPhqtu2kd456mJhess6uZDeSsu/PHDXwYF1HGfKpI//ne+BYCjrmT?=
 =?iso-8859-1?Q?Lqb/Mkmkugt48thmoapYTClQlnCcvhWrAnbIydXW1cAxQvUXX+lXU9nDD2?=
 =?iso-8859-1?Q?WxUo1teRS/2lQ7+UB2lf+jIq2CTT+pMnZKo0n8tYtJPWrSrPB5DozPLpDU?=
 =?iso-8859-1?Q?TK04CgqXAdZuP1ubcURY7GFbL7QvcUn0nkHMWZoVg8p/bJ+LNXPAV06llb?=
 =?iso-8859-1?Q?COOPI5+0J2N/Am6wLcpkWEdmPg0w4S5cgeMcU49XY+987fxSDZkwR5uKUV?=
 =?iso-8859-1?Q?IJxxxYmDAELUwSlFrdB+IcrLieAcTt5S83AFEbtcWNudphDRMUBG4T9iHG?=
 =?iso-8859-1?Q?+QTx95PKdDc6WaW+tqvhvHEm8p4bBn+8Xxcx5u0Y/8pPsiZvbsHSDsASkY?=
 =?iso-8859-1?Q?ZblyjIUCaw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb3099c-a7ec-413b-314d-08de9b3c4714
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 22:13:52.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hw3eLoKBgecIaKMKIoARjr9UZSXTZ0TiC2giSjtWihA0JDGHgkG5AenpJnLTzCHZO90wzJGMQWRFsSkG4dZGjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1372
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238224-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,ffwll.ch,suse.de,lists.freedesktop.org,vger.kernel.org,verivus.ai];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[verivus.ai:-];
	NEURAL_HAM(-0.00)[-0.460];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 313FD40886F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

radeon_align_pitch() has the same kind of overflow issue as the old=0A=
amdgpu helper: both the alignment round-up add and the final=0A=
'aligned * cpp' calculation can overflow signed int.=0A=
=0A=
If that wraps, radeon_mode_dumb_create() can end up returning an=0A=
invalid pitch or creating a zero-sized dumb buffer.=0A=
=0A=
Fix this by using check_add_overflow() for the alignment round-up and=0A=
check_mul_overflow() for the final pitch calculation, returning 0 on=0A=
overflow. Also reject zero pitch and size in=0A=
radeon_mode_dumb_create().=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)")=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
v3:=0A=
- Squash this fix with the earlier zero pitch/size validation change.=0A=
- Use overflow helpers for both the alignment round-up and final=0A=
  pitch calculation.=0A=
=0A=
 drivers/gpu/drm/radeon/radeon_gem.c | 13 +++++++++++--=0A=
 1 file changed, 11 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/r=
adeon_gem.c=0A=
index 20fc87409f2e..8ce180e22d1d 100644=0A=
--- a/drivers/gpu/drm/radeon/radeon_gem.c=0A=
+++ b/drivers/gpu/drm/radeon/radeon_gem.c=0A=
@@ -28,6 +28,7 @@=0A=
 =0A=
 #include <linux/debugfs.h>=0A=
 #include <linux/iosys-map.h>=0A=
+#include <linux/overflow.h>=0A=
 #include <linux/pci.h>=0A=
 =0A=
 #include <drm/drm_device.h>=0A=
@@ -812,6 +813,7 @@ int radeon_align_pitch(struct radeon_device *rdev, int =
width, int cpp, bool tile=0A=
 	int aligned =3D width;=0A=
 	int align_large =3D (ASIC_IS_AVIVO(rdev)) || tiled;=0A=
 	int pitch_mask =3D 0;=0A=
+	int pitch;=0A=
 =0A=
 	switch (cpp) {=0A=
 	case 1:=0A=
@@ -826,9 +828,12 @@ int radeon_align_pitch(struct radeon_device *rdev, int=
 width, int cpp, bool tile=0A=
 		break;=0A=
 	}=0A=
 =0A=
-	aligned +=3D pitch_mask;=0A=
+	if (check_add_overflow(aligned, pitch_mask, &aligned))=0A=
+		return 0;=0A=
 	aligned &=3D ~pitch_mask;=0A=
-	return aligned * cpp;=0A=
+	if (check_mul_overflow(aligned, cpp, &pitch))=0A=
+		return 0;=0A=
+	return pitch;=0A=
 }=0A=
 =0A=
 int radeon_mode_dumb_create(struct drm_file *file_priv,=0A=
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

