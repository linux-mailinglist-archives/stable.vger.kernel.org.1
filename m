Return-Path: <stable+bounces-237972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHaKH2mv3mlmHQAAu9opvQ
	(envelope-from <stable+bounces-237972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:19:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC70F3FE916
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3025930E5D2E
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 21:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84947246781;
	Tue, 14 Apr 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="axLBG723"
X-Original-To: stable@vger.kernel.org
Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazon11020102.outbound.protection.outlook.com [52.101.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94731B824;
	Tue, 14 Apr 2026 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.152.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201286; cv=fail; b=ND0IWPcnNrhj/dt9UiTCRFI2lpYOP119yX6LFBS4fYYM35O9DnHPtaNBYKVyC6MLasDO7EjNod2FZjGAXoCD3JuPX5qU/F3n8b4kAuJoiR44+yyT+fdvmM+DSL+sX1/5aCBcvemGGORvtDwUyrd0TlbpVVfyeCt2kVk9zsSaJa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201286; c=relaxed/simple;
	bh=+6E6qWLxqXIr4jab/S5mlo3BXaoad28wAomw2LD+IMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lA2BUphHHQwcPq1W7qN46gEVUMPCvXWJlPm9djLBxKxrrZOGjF3SfkZaj7bOf8MpRX2lQ+i52UbrjBQJtYYXQj14493D7tgbMw7i/VUcc2nEwlcStZVktmn90Zl28SEV2G0iyPstyDJn7BQ41Ec0+ZHOIm/j9UmyztuzUKSFvhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=axLBG723 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzdtWF4Di3wvOLA0g26F50mAdmKHdDBQCfQ6wi1VDJp7eNTIcx6pujtA0BDRZ/TQJDBNCbqqzbQ4Qr/AMuEnErNwXsTte9TcLhFW+As7P75OmT0B7EkN32SKDdff+h7V2GWFluJFF/jcJxH5MWbEoIcIVD6RuNzQkMDKJUHoOR2cnbn+qiIPzEx3q0WYsPMXu9f9JUxqSLC6a35awEAunT9CK0EYmjFmWigZRxrMLf7CoCjAF7ISjqnnyWTu4bq/Ur5tOw8yzLf+3izri6mYdUvj7SeLeJ5krFg6D1LDCX4GVac3X+AYLetPlPsgWabqRaGJiN7Lgl5LxG3T0qcQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayVwbGrlFXW8bwQ2gqiZBOC2Y8ZRHPJrBIq6FlPJ3Q0=;
 b=zJ7vVyEOZVDPiGQqqtOg8PDPFslJH80+2iEVOn+iH0FpRKjeXSn1JEuYyrYnz7vPOZuknSsiNF5o/bt2pt5NL4zuajWzisCnNG8/5EjaPYnkm///7rHi8lC15PfLJiHXqws2ZIVdOiluvA17H0zr6IdqduMnPFtl6jNE/3KwBH9R+5AT0uiLXJriQiCflLMpVLiY2qiZMhPIKcRyBJ9zhTdtl9QFkRlIxXhJhAP+fIdnI8NhKyaUe2MLvAC/4GDEkod9XoePGcU1BKN9Jv6BBP9ONlPxmQl4dWwoy3pX8Km176hjd1tQtP2/lDzOoF89qio5orzjak/DJqL3Sy1+gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayVwbGrlFXW8bwQ2gqiZBOC2Y8ZRHPJrBIq6FlPJ3Q0=;
 b=axLBG723D28ZzEEn7yCv+0q9uM8ZrU577w27sHT5H4fvrtL36Pwf79wTH5MRq3SG7Ic2zloSv4BLclcx7ZVjyev4R2jr71aXuZkLkol39IZVuGml6x4SlkhxcyVAjauMBThsgOX+l7DVyCXKgtq6PLOpRjYClyk5pqWEor+JBQwOXMuMn4bAOdoHeqVdoLvm8p7+5ufwpQRQ0PGSXto9D7wL9Y0STV6nHKeDbGWLdrh0D8FacE0O4uH2kz+7SgnEhZuuk2IRVaW1iBTzU40f35xqYAvkEDB80S2JLqVIvU+dPlK9kvK8sAK8difo3JMnqBhwmhBqq/3tedFiIK/4Rw==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by MEUP300MB0221.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:21c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 21:14:40 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 21:14:40 +0000
From: Werner Kasselman <werner@verivus.ai>
To: "alexander.deucher@amd.com" <alexander.deucher@amd.com>
CC: "christian.koenig@amd.com" <christian.koenig@amd.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Werner Kasselman <werner@verivus.ai>
Subject: [PATCH v2] drm/radeon: fix integer overflow in radeon_align_pitch()
Thread-Topic: [PATCH v2] drm/radeon: fix integer overflow in
 radeon_align_pitch()
Thread-Index: AQHczFO02DccrNv460y5pGbLVq+GrQ==
Date: Tue, 14 Apr 2026 21:14:39 +0000
Message-ID: <20260414211437.154315-1-werner@verivus.com>
References:
 <CADnq5_OVN+uCioTWNeuHkGpkUU-VhEio_uMEBMVur6-hWXwtug@mail.gmail.com>
In-Reply-To:
 <CADnq5_OVN+uCioTWNeuHkGpkUU-VhEio_uMEBMVur6-hWXwtug@mail.gmail.com>
Accept-Language: en-AU, en-AT, en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.43.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=verivus.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB0853:EE_|MEUP300MB0221:EE_
x-ms-office365-filtering-correlation-id: 159baddc-6d17-4918-7933-08de9a6ad72a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 xFC2T3DkaO9IZjVpVlFeRIWeEX1n6D7qRsw1Btn8diUzapYUI522z076+L8g9leuzi6aXj3sJLWCpfRBLIddTsFPP+xgi1ssZhsnViGwk/uYrNdVuRV8/+0hx+YuBkaIjzMd66KKIpiatmQMEEd7zcdWQtMcRJG7xQET04SHKrNSm1hivr4SWN9YEEqm1E35e+1vzRpQ9JTuX4IXUoareoq+Fww5HzL4RgRB6l0RIsEgQo9K73+SBH+vwiAkcYgzE6PKDJKcknLzPFP+iYl0jE4RsZ/hMUbQt5RRAzAvHY5s+/ADpRazS5+v3vtk8jG1KFHpoh+nrxR9DTJ+eQu8rx5AXJIUggDEA2Je0b8N8T6E3dI0R5V/N88uLdYl8bMPWSn1+t5yiGqrefMx/09X7SC9ujiy9eNoKvy++yHxzJ9X4qZvGxz2aS+1m8p+RMS5GwM55qc7XucmUVdeos7uXilEJOEyVCGlGEdZHQayy+agG1rvVBSAGYuSo3rDV6xGMWig9rUHDjy5lsRDLASXvvYna18uvPWVY3ZkwXJYvqHmiFHDDzc+rl4Gg5j2qkQw5Km61Z8aFgLmRqwzUwR7IhHxofIJTjwh1g5oSlGmZpTng39Ugwi43eATanq3ZR+0/ehqbFFsWTfI2XUJRRLpQLe0mOT1taQX0sQh3kh6kSGtkb4TXy4fov5iSd/7x5zkGjdfjlc1NcU9AH8gcWvk6P3MRqtTor/xK4hCCqZJRK0rfSJDa8hBAAtXJYDCWPIUzo5MqfD0cHp8yn75Whgy9+L7EYuam/7j5o5HOYJBvpM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ii7bXfXY4T8Z2y3O3bzeshS1LYFMyFlK1Floy8miCEwO1YdzX+fYhZzc/e?=
 =?iso-8859-1?Q?fddRTvfSmp9gW461VA5cWWDbQcyFDFtRWBQBYueEd9Oq7F0Fvc7xhRvj8U?=
 =?iso-8859-1?Q?+uDhNZxepBMwVabJfLL98/3sMswZe63UIrYYWp6aqiHn/R3nSyB6RGN5yZ?=
 =?iso-8859-1?Q?IetwlM4Iqa9IYTQhnYP/FzZxicuNvYlzqs3McodlJVcC8IvaR5DI7xbcDy?=
 =?iso-8859-1?Q?MOUxcqUqSyM2pwyXQY6YxjtsEjueUgXcc6JSAo2F7iqkDEgxR9ijE7gmdM?=
 =?iso-8859-1?Q?/H4qJgTPlMpqXmKOz339pregF1vAepk20alELh7OWlnoJoOWsuMIp9va3c?=
 =?iso-8859-1?Q?xnkGJSBYOf5Ewz07rZzV2tGVcZ97egtOHIy2D5GaKSFjrTHzynmk9oO1tG?=
 =?iso-8859-1?Q?3qDWLCxeJDhaDpCwkaLGqxfgdQUJCSM/vEUXXrcazKTHfcGXubI0minDJm?=
 =?iso-8859-1?Q?YfL3QlLlyW7gVwRSWHvPLlL0jzxj6ycHzFYp/4ANtoY12u1rKJ67kYPCmg?=
 =?iso-8859-1?Q?qsMR4jWS9hHvKWeRnr3D+GbPvhdkQU/MB6Br7fmsDiwJO5fzq4GV+nl1UT?=
 =?iso-8859-1?Q?u8MBc9HsdK2AeWqnGw3oeq6XqyRBgkBYAH6v3HIqOTkFbSoaivjnBcvAP8?=
 =?iso-8859-1?Q?IwOYf1wdsxZSB2pjnAyrRzfbqdygz3UXiMR0LmkYh/IVpTC2gsAfglSLz8?=
 =?iso-8859-1?Q?d9kzEKCiTlIhwNNt8GIAwTo9W+zWZxK6UkIxeO6mS+MB5X1Q0MG1oHfEj6?=
 =?iso-8859-1?Q?qQ6ZBUA5cnTC6DbNR2cUQXVFytxpPStCFVgYTMTNm0+xkC3avNAw1ERhsk?=
 =?iso-8859-1?Q?Ylp4KIzMiRr5j3E+nyDCmm7V+YGcDsOC/6N82bNFsT5hBaxMnjfVKbBCEu?=
 =?iso-8859-1?Q?6vTWf/4uBEucIrsFxwg6P/8kAu6XkDa+e3fGEUVtmX73Of8Q5t9GhAuJd1?=
 =?iso-8859-1?Q?MNsKcGiAcq/SqBL9io8V1WbaGWGyhCmIWWna+ZjTp7IFQfa1/7reFns6ps?=
 =?iso-8859-1?Q?4/lBtktb8Km99WWkJPJ2diDQPJpuF2Sy9Ghv0oWYh7UrQGB6U8PXA26FZC?=
 =?iso-8859-1?Q?lUx/MqLSp3KVrnUpkOXyBSlREhQ/WLlaPBAurZW57vxVuAInLEVJjoY8p+?=
 =?iso-8859-1?Q?QVxte4cVQx4Xy1IgaHpYAiVdCFxgmANvn3gAPdt+FrkKE13HbHFsR057tC?=
 =?iso-8859-1?Q?ylDH7uO5e9XGEJQ/ESeS53A0o77DFY5svM97gbWc6xpL58Bn8kNgbQ7GrU?=
 =?iso-8859-1?Q?1CzYLQ1rMZSrCZuqIfFFQCZgM4Bwmj22DcLRHydvO+ytEwNxavF1eYpLXV?=
 =?iso-8859-1?Q?g2ns5DYCcLUJcQHUXAgD2pre29FpP+b0WMQeHZfocGsKakc/bnVZMNJ3Gx?=
 =?iso-8859-1?Q?+6iMQq4d6K28BJGh9PIbIy0K5pcriQUTFr/et1SMejpZY4r4Csx9iNXp4e?=
 =?iso-8859-1?Q?qQfzP4brEu2qaCrYSVGoLxfKeQIPZA0bDdts+JvBZkBnRdyIpbnumGhVBY?=
 =?iso-8859-1?Q?mDJpXQ5pDPWyvLRx1X2LMjL8d4lT+O1H4mG7YIwB520pdjMmF8aJfTp6EI?=
 =?iso-8859-1?Q?FX1G53I8yp6ywkqb77zz6a3XOyBONwMaoEJ2AUnTFGgjrAEDgIR/OLP7px?=
 =?iso-8859-1?Q?gpMHkx9s6jfHPfEwY5L2/2rTbbSdriceUQ6uqrQkqK866RMgwOM8B1t+OA?=
 =?iso-8859-1?Q?B3A+eQTkcSirqq+3/3JzIvXfEYIhaiHhwzuDHsE+zj8GwJkJsGJvoEoqLz?=
 =?iso-8859-1?Q?CuBmg1JsOZ5kZ+gsWSoQAhNOer53aZbDm3XmKDstaA8AvqryRz0CD/dMwK?=
 =?iso-8859-1?Q?96Jk6KrGxw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 159baddc-6d17-4918-7933-08de9a6ad72a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 21:14:40.0192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 887Bqg0uHgURISa4V8ttCxxwSCpFcRPuS+1uGrEY6fS4vihytmZB9wAHhUgVk/OYhU2aJ8fp1+ZL15eVxZcafA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEUP300MB0221
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237972-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.497];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,verivus.com:mid,verivus.com:email]
X-Rspamd-Queue-Id: CC70F3FE916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

radeon_align_pitch() has the same kind of overflow issue as the old=0A=
amdgpu helper: the alignment round-up add and the final 'aligned * cpp'=0A=
calculation can overflow signed int.=0A=
=0A=
If that wraps to 0, radeon_mode_dumb_create() can end up with an invalid=0A=
pitch value from DRM_IOCTL_MODE_CREATE_DUMB.=0A=
=0A=
Fix this by using check_add_overflow() for the alignment round-up and=0A=
check_mul_overflow() for the final pitch calculation, returning 0 on=0A=
overflow.=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: ff72145badb8 ("drm: dumb scanout create/mmap for intel/radeon (v3)")=
=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
v2:=0A=
- Use overflow helpers like amdgpu.=0A=
- Drop the stale zero pitch/size change from the original submission.=0A=
- Fix the changelog wording around reachability.=0A=
=0A=
 drivers/gpu/drm/radeon/radeon_gem.c | 12 ++++++------=0A=
 1 file changed, 6 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/r=
adeon_gem.c=0A=
index 2cd179fef347..8ce180e22d1d 100644=0A=
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
@@ -826,14 +828,12 @@ int radeon_align_pitch(struct radeon_device *rdev, in=
t width, int cpp, bool tile=0A=
 		break;=0A=
 	}=0A=
 =0A=
-	aligned +=3D pitch_mask;=0A=
+	if (check_add_overflow(aligned, pitch_mask, &aligned))=0A=
+		return 0;=0A=
 	aligned &=3D ~pitch_mask;=0A=
-=0A=
-	/* Guard against integer overflow in aligned * cpp. */=0A=
-	if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)=0A=
+	if (check_mul_overflow(aligned, cpp, &pitch))=0A=
 		return 0;=0A=
-=0A=
-	return aligned * cpp;=0A=
+	return pitch;=0A=
 }=0A=
 =0A=
 int radeon_mode_dumb_create(struct drm_file *file_priv,=0A=
-- =0A=
2.43.0=0A=

