Return-Path: <stable+bounces-237720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHF/EufL3WlGjQkAu9opvQ
	(envelope-from <stable+bounces-237720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:08:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE1A3F5B14
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 07:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF226300E5AF
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCF9283FD9;
	Tue, 14 Apr 2026 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="VJhZt61+"
X-Original-To: stable@vger.kernel.org
Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazon11020083.outbound.protection.outlook.com [52.101.150.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65312C21DF;
	Tue, 14 Apr 2026 05:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.150.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776143330; cv=fail; b=ZFIyHajMFBdFEa6uLkD1iVcT53nqJRbVAa7MWi842PmaTurjHXVtmYsbR3LzgdioeXN28Mx6bHizYUBJP8qp4+lCFGu/MpGd481lusu4iMNscgjjk/eJMv4SyT7+2njhYtlvLvH4oO/OtLGBKSmKJaPtdug1u+A6DSICs7O43Vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776143330; c=relaxed/simple;
	bh=myBt51HtJQQAIRIFJ6JT6cSlCp/LmyKOCUQ4Ks2eGTw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N5Akh4koNkpMXEoaTf1/bUNPDUFyuNoFGxVpy9WeMQhNWgoYTO/c2ehNyftwo2dJLasEf6CyRNq1KpPVfOeP/T1AtCNQTMhENtL8JTcktBJG07p5d8ayF6MArrpOWdsJAQV0iUXcnUUkpph0F9mO3w58EJQ/W+W3+KMfsyEdPPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=VJhZt61+ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.150.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqjWg/XHfQw08EoMjY2wFWlnTWFfLRuTw0thJzFAmw3sRAPlNC4BrXpXFAgk1VlfLCg+Z0ttBi61OhqsWERDAI4n4S1594tMaUJdBwUsHsttMYckmyD+OquweNnNcnmcUZPMLuTubV93JhStGON8UyB66+oQD1o2yOm9JGOiaUJdJZLGYTodAUrh0/VWt+6MMRZEbEZTjYjps51KtCfHG9DUCdr0KPUycXLzDAh78YHCE79MfZs5z7RhsvMf08E8OYOKBkrH0mCdokFg8cfMRi9LqCWlMcfn96n1BphUUNo3hn2DBRJUIhnJgagSRcQEtUcZerx0EnbihBWWlY7MXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zchg+lqbHt28YksbX8bCPYnMvLlftotdwl+HJd475Mo=;
 b=seFo4ogoSQHytVv5IFVYAAFgYrrJRezUj4z6jdF3+UIAD/PCWdZqiukzY2E8hPxPbdxieH0ZIM2WVw1tC6xBUysUD4sb0epplPolzGoVlhXvc10geulU2PHmG3KdU9A+pIuKEbN9SbbeQaZyJW99Qhqz7vy4Dw3aZGYc8EU4bFgIbHZ7dqsEB+NlrNQN7EwUkiFrAjOrYt69R2P8LaRmh9NTgalk4xeV0XNfPHdA3YC4DMZCkOkcFYI/xQSjhdRKPh0938ihgiWWlsEQdj/EGOR4x8G49EII7JZ7TEZAFwxuS2iOSxUcA/HaF6zcQ1r50V52t2EWkqbtdmSkNBz/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zchg+lqbHt28YksbX8bCPYnMvLlftotdwl+HJd475Mo=;
 b=VJhZt61+FRW2cmtA5wdArkihyL+eDrM1Wo+8H7ljCYYnWC8RyFwehzRovqszWKcpuP8bRIRUMXm7yI2yVnYORJB3sdq+IdTCNGPYbovvximXeAxHNco2UYBECFFqmmFaRdPQbLZsQDtCM95YMkcwmvC1bcvWrk26i9DcLTHjS9ByaCPxr10P8M/4hTdp4+EJkqsEW3Tq5BRzWSxDJZZ+sCHKjpWedFcfY6tauKymAG+Soubt8oxG6AHg/MudBh50YtOno00o/FBZOZn/rP4oLu/cHbr+Z7siRqaBRSojHPhdCtGHXw3siS/CJDAaP8hEoxZnI6vgcB+tNr/tbuosdw==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by ME0P300MB0738.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 05:08:42 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 05:08:42 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH v2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
Thread-Topic: [PATCH v2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
Thread-Index: AQHcy8zDxF1cRH/ziUyO+ZJ1bKaRhg==
Date: Tue, 14 Apr 2026 05:08:42 +0000
Message-ID: <20260414050840.244705-1-werner@verivus.com>
References: <20260406225008.2787532-2-werner@verivus.com>
In-Reply-To: <20260406225008.2787532-2-werner@verivus.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|ME0P300MB0738:EE_
x-ms-office365-filtering-correlation-id: 05ff443b-bf7b-4ef2-c979-08de99e3e5f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 8TOefaesFWmDOGEKm8ueJu1Rq+bC+PbrX3BbK9pJNkZywA5KTocUt3CgPwvQLhNAQSStL2mxFBUJo9YzahD6/sBD42i2JxQWGq7BZLhbTLAlEPyHczgcixMyzCaWv+mX1RCd3H0eWByxJ6xE6YLNUZZgPC44XsAwGg1uJhfYnUhseSyW1odPiIlTk3469ZIISC423/7cvfp5zKDEnb5ZtyhiXsx0U2BANJw6nGRK2/jIeRv33UC2AUMTfaryqJiVtzrLqjzaO8ZW2eMeORQuEX40o8Nmba5UQKhg4JKkAxDjWNR0GJGD0Pw2jLJfoFQBKxrjG1BonjtfP1bvBpGOO6j3RAuFPEWjvi9IUCUbXqI/gThRcoDtcQabHNeKE5MYFiJcD5jI0WDJHPX3+05mDqgZF5bZSpEU9qRO46yVd5GjLYCtF1xTRH95qX5+FvmkLB1YXPFenIqZecD3prkYmXrS4VRYLVNKdlpCHpKqMl7GhS5ojeMOIvW/aOcGyXUh+nCywMjzvVJ02BgT8erluRwt1sg6xbduisghPHSC/Qu7C/FdUq5XFZUpXza0//wHuvNS+yNqEBsmEPW6PspEHKwmKbQ0BvsNcnaesoKhsRNOYfelAxLiI5wv+aTbftiP8YrmUzU7f84wOUk6RPKveeAgkEKdn7qpps7kgGxjXAwRT2NnnfQjxkTyQkCkvLxWz8Shg6oIRmI2HuPkNQQyKLS9sI6FIyKdH0uW1tSZsrMAMkmsyAgm2IVLmT6KDixz3k2Ilor3Sm3SuIEUobNTfdunXCg4lmQS9OP2wdnJbnY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qtg7kDWHRw9DYzy4IJXQ+rN2fnIY6tqh1lud1RxDQC5IK+qSnukmNXdTpa?=
 =?iso-8859-1?Q?TuHbeem6+edlYAMFcQP7DgEvU0HSpbq6oV7dgO9d9oSFOxTs29yaORkgjA?=
 =?iso-8859-1?Q?fz6hC9e1WQA1Z7xs1ay3Ova3BSRzmNM6aJoUEsXofVQUwrvyuneJf18Vct?=
 =?iso-8859-1?Q?hfV+kVIwlW+51LN41tal4NdnJuZ8rkWnBIJdDoAon8434qRQS6k/11ZC7S?=
 =?iso-8859-1?Q?viHtTVLA8np9wrt5LlEmxMj2XqsE2TX0RkVWyLPOoLnez6KBhg5o9aixgf?=
 =?iso-8859-1?Q?KOvjTMiqscCJQqbQE5edlsBs1iLnLXxZGO17eo0/PR3Y9ud29BBNNta8gl?=
 =?iso-8859-1?Q?FRSGex/9g4bYpMf+UETeo+DfAQDjWyO14cR3y4085FXFaaGnVlvN7Gl08E?=
 =?iso-8859-1?Q?In0O0QxYKkmIKRGHgI09ztGcHpsM/TI0mwNte6xmPosNxpOwm+fT0Zc24B?=
 =?iso-8859-1?Q?lo+v1ZLKPbzsphKrd4wMJ6hh2efjcn2DhmmPmoCAUf4YRRXSIzA9QDMD7r?=
 =?iso-8859-1?Q?DPBHECaYhtwLZ3qeWlEf8vdGPE1Bya4FVU7ADE/J4WlE+QL8VM8oEvqMfk?=
 =?iso-8859-1?Q?5Hli7VasWT8XLxlY2CdrEC1MRDcbnLeRtASp8W5PYEPuVmXPURcUx0ZxSq?=
 =?iso-8859-1?Q?avnHaQrIakip4H72UWBrqfxIGdMf5SE04z8jUmQETip12Ii8iM8VCSKepI?=
 =?iso-8859-1?Q?JcXs2hVUuIeWQYVexaQP6ZgrmZdXdfpJ4DJmYLDzYe6FnfLIhlb/xVLvmG?=
 =?iso-8859-1?Q?5aOWIbGUgNhnMhfRYgZ7ZC3RewsAQn50SsoTcaEYL/mLY4loSsY2Wk5Sir?=
 =?iso-8859-1?Q?KdNuOxKv+iA8sQnMoW5N/f07OKPpX30x5Q59ZbH3wMLQ9RhySqpgenMx1g?=
 =?iso-8859-1?Q?GHTmxiLQu0UDwtF/u5rYZ6dLqQN3IAQx0bvfro3DAXU75YIK9p2uFXBXwp?=
 =?iso-8859-1?Q?qZjCDpyKSHtsKPRowUVtdaL83oj2pWexM1kUjLvDDD/dQT6PoC48TgvvIe?=
 =?iso-8859-1?Q?YbSI5iDBAt4jtlaTG/50uYc4/nbIK8OfBslhK/2jxwizY8l+sBkzSRJrwG?=
 =?iso-8859-1?Q?oDfc3EG9sohMDHqcD5rLb4YXaAdKfGWAQ4os4UxGVrnwfMIdtxpXOYlqjC?=
 =?iso-8859-1?Q?5+PPsLuocftiovZ7Ljl84EqFT52jFU5bGgMgPvXjzP1jPh4cW8+ajHb2LV?=
 =?iso-8859-1?Q?I2pbPK6pr7HdXrwlggZMHfO06tRXhWGCdPfzUwrx7i1SBvKa2wL9xZNulx?=
 =?iso-8859-1?Q?Pfeaa4Hc4ybb84TWSC2u8ezZL+XjQjhBaqXBvJ59L4RGDvYOYpPSTOul2X?=
 =?iso-8859-1?Q?b90UZY/ByJjnOodrKK2LKBl5A2iA1qo3oAPJ/K7yTT7XGyftjavQMWwEcr?=
 =?iso-8859-1?Q?mNysn58gKWffz32VR/H5LMAfA5j84x7d66UdQt0UFs51i8PMncCmM9GxJ0?=
 =?iso-8859-1?Q?ML8G13vILOh9HFxbfPe0R/qZ/AP+IZKp5Uc3pouO9UlfNYzsj1ngbDbt4x?=
 =?iso-8859-1?Q?15qjmx5qlyN5bo1oO+qkATYXcqeAC8wIPQ++GNx1SDhxMccZEHMHEcLnwh?=
 =?iso-8859-1?Q?LKNhh+bAJtCu85+/srrj6ip2NeDemzevHfXmDCmkth5FQ0aqkA4LRg0sWq?=
 =?iso-8859-1?Q?jBkMgid48oULtl5wRHGozyMmpb9hR4Oo5My/cjBthj7evm6u5NDw163ywU?=
 =?iso-8859-1?Q?2PWlRnHm4KR86prHAW9UDw7xH3Kf+A7UEDX0mkViJ/2IE9apiTUbACaQPB?=
 =?iso-8859-1?Q?HphXbWGIh6+1ZpwejQ3PSeLc0ymW+skJA+5J3X8TVafpFA5X6TTXfzH6++?=
 =?iso-8859-1?Q?OlR1A2GmDg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ff443b-bf7b-4ef2-c979-08de99e3e5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 05:08:42.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWZz8uRa4XuaOVAV6FT3OLdK7QKGg16wdIGvNIDApuPbLKOa3rAnXZjmNVXS05YrmsfOq/xz36nBHYPE25x0bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0738
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237720-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,suse.de,ideasonboard.com,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[werner@verivus.ai,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[verivus.ai:-];
	NEURAL_HAM(-0.00)[-0.392];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFE1A3F5B14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amdgpu_gem_align_pitch() is passed u32 width and cpp from dumb buffer=0A=
creation but uses signed int internally.  The round-up add and the=0A=
aligned * cpp multiplication can overflow, returning zero or a negative=0A=
pitch.  A zero pitch propagates to a zero-sized GEM object allocation=0A=
that reaches userspace via DRM_IOCTL_MODE_CREATE_DUMB.=0A=
=0A=
Switch the helper to unsigned int and use check_add_overflow() /=0A=
check_mul_overflow() so wraparound returns zero.  Reject a zero pitch=0A=
or size in amdgpu_mode_dumb_create() rather than allocating a zero-=0A=
byte BO.=0A=
=0A=
Fixes: 8e911ab770f7 ("drm: amdgpu: Replace drm_fb_get_bpp_depth() with drm_=
format_plane_cpp()")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 25 +++++++++++++++++--------=0A=
 1 file changed, 17 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c=0A=
index a6107109a2b8..0d9309f792a4 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c=0A=
@@ -27,6 +27,7 @@=0A=
  */=0A=
 #include <linux/ktime.h>=0A=
 #include <linux/module.h>=0A=
+#include <linux/overflow.h>=0A=
 #include <linux/pagemap.h>=0A=
 #include <linux/pci.h>=0A=
 #include <linux/dma-buf.h>=0A=
@@ -1223,13 +1224,14 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device=
 *dev, void *data,=0A=
 	return ret;=0A=
 }=0A=
 =0A=
-static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,=0A=
-				  int width,=0A=
-				  int cpp,=0A=
-				  bool tiled)=0A=
+static unsigned int amdgpu_gem_align_pitch(struct amdgpu_device *adev,=0A=
+					   unsigned int width,=0A=
+					   unsigned int cpp,=0A=
+					   bool tiled)=0A=
 {=0A=
-	int aligned =3D width;=0A=
-	int pitch_mask =3D 0;=0A=
+	unsigned int aligned =3D width;=0A=
+	unsigned int pitch_mask =3D 0;=0A=
+	unsigned int pitch;=0A=
 =0A=
 	switch (cpp) {=0A=
 	case 1:=0A=
@@ -1244,9 +1246,12 @@ static int amdgpu_gem_align_pitch(struct amdgpu_devi=
ce *adev,=0A=
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
 int amdgpu_mode_dumb_create(struct drm_file *file_priv,=0A=
@@ -1273,8 +1278,12 @@ int amdgpu_mode_dumb_create(struct drm_file *file_pr=
iv,=0A=
 =0A=
 	args->pitch =3D amdgpu_gem_align_pitch(adev, args->width,=0A=
 					     DIV_ROUND_UP(args->bpp, 8), 0);=0A=
+	if (!args->pitch)=0A=
+		return -EINVAL;=0A=
 	args->size =3D (u64)args->pitch * args->height;=0A=
 	args->size =3D ALIGN(args->size, PAGE_SIZE);=0A=
+	if (!args->size)=0A=
+		return -EINVAL;=0A=
 	domain =3D amdgpu_bo_get_preferred_domain(adev,=0A=
 				amdgpu_display_supported_domains(adev, flags));=0A=
 	r =3D amdgpu_gem_object_create(adev, args->size, 0, domain, flags,=0A=
-- =0A=
2.43.0=0A=
=0A=

