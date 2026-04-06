Return-Path: <stable+bounces-233457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK9cJPs41GkksQcAu9opvQ
	(envelope-from <stable+bounces-233457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:51:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0322B3A7F3F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 00:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7B7B3051168
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 22:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3939E199;
	Mon,  6 Apr 2026 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b="KMTDBZ2+"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021107.outbound.protection.outlook.com [40.107.39.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359F539FCAD;
	Mon,  6 Apr 2026 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775515819; cv=fail; b=jnIeDYli2COo2SRZzk1ouogImFwR6gAooCGbBXNF7EnuqtlB9h0KJaavBlgpB1QBcbCDWQEsBI/LosUbZQjJwqLBR5bXU7L94ioKi4Eh+rGbUn5r6xOTzuV/EnZix2pRAYSDIgFpcv/37uK95omkUuOlBPX6fvNT8uSbGH0Mk88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775515819; c=relaxed/simple;
	bh=jAdmtDBoK9EV/jWX4i0giIDQdd3XZFS5k2x9ihQ61lo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=trsTmRon3fGp65/xMrJIdYbcsU+VBRFY1+RxiqhYUdB+Dfu67TEOch2BRDtdfRfPsW7arClUmQb81UasGK5fH+gH2qCP0HkGopYYwVoJxVHlsniJfC93bvyRaMfWEHyjH9KT8ztgpvcRJogQQGXWfHfcP01Q6PmCDbcuajYjZA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai; spf=pass smtp.mailfrom=verivus.ai; dkim=fail (2048-bit key) header.d=verivus.ai header.i=@verivus.ai header.b=KMTDBZ2+ reason="signature verification failed"; arc=fail smtp.client-ip=40.107.39.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=verivus.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verivus.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9vzYbTAMJVK9OdJx28jsiilUR3CPILG3x89ikhzpb8Pmqr5FA8MdmSEBIznacyj4Mxxl4SgTMGSNiDioMx2T5Vjmb4fGD8JQsJu4FPLZV1lG4rudRiF4+ArZPSZwHc1x8HLIWHkT42/kBZCcx5qBRC8b+RhBuHSxkKpPtk97MXH+IJ1PcsrewnvnU8p9eqDbJgMp4b5TYMgdIdDGTq2gwJ4ES+kUChrU8jx33Go32q/XDKfUxd54NsL94s8+wQ1LLmc3W2hWS5fE/mrn0oHZWhPqe9/qZpjibzt86BBEJ54flqFz9wm5uMqVzQwGYi4ykro0ZQzFTGIATLGikJQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vY2M/BwX84PgH4VQS6sFL4OoLnUpIx9SLELGPeLbSs=;
 b=bPHmSorqds4WqJaLYynhtZ+i7cPa8toFvm4eAARkXCSeOhLAdGera+6wJ4LOrUXTlCfL4l75ruWjuUzC/TE8mTymI6CMYaME+jYoo23PCJpGO+7rXx/EHRS10qrKXplvhPcPLN1Aaaec/BSJ2Tc6Bi9qRMhTGXAH0JI0Nu5i3gdyfEchawih5uSVGv3DB3X8boV6iAkcxbru+wHwXnzBz0hmcbsEfctLimTbe6esXNs5092XwnK5m8Yl8lZdH5LtawNg2W/6nw5HduuQa65DdzOIzTsZb0rDTKhOAthhIGQqbHn8qiQHlh8QIWd2+5KbNXCzCFGXEto5AUrr+ZLbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verivus.ai; dmarc=pass action=none header.from=verivus.ai;
 dkim=pass header.d=verivus.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verivus.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vY2M/BwX84PgH4VQS6sFL4OoLnUpIx9SLELGPeLbSs=;
 b=KMTDBZ2+UUphcnNzXUtxVb30YsmUkUUHYn5UnRSQuzWcdqJQey7ctnYRP78iF7yMC8ChgFmseBzKzQ8lIPIhFwVNG/g6tbxXphtY44SUQL2jOi4/G9UpS3CAsUyn21YtDMAJu5ct8FGXMDEcHaXEfWqA5ZtQkpttdBz1vyy7mi8+CiaTM5orK2yI5r1egmeVwoNewgRFdaRZ+K6oUHVQ31LlKEir4Qe/v3PcHN3F6kvHtUSRXv4toXKMRKbyhsSKK+zOEnuxtja5RYxFsXzAy0lpiILrQVVrHqEeCGmIzN4kfvn7LFLIOTTzNQPUrF9a76RFoQltmHF8JR/eu3KC5g==
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::5)
 by SY9P300MB1529.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 22:50:11 +0000
Received: from ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2]) by ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM
 ([fe80::1e3f:9cb9:4a95:b5a2%5]) with mapi id 15.20.9791.012; Mon, 6 Apr 2026
 22:50:11 +0000
From: Werner Kasselman <werner@verivus.ai>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
CC: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Thomas
 Zimmermann <tzimmermann@suse.de>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
Thread-Topic: [PATCH 1/2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
Thread-Index: AQHcxhe5Art/gXsGGUOIk5VGpX9Reg==
Date: Mon, 6 Apr 2026 22:50:11 +0000
Message-ID: <20260406225008.2787532-2-werner@verivus.com>
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
x-ms-office365-filtering-correlation-id: 1ce11d30-fa47-45ec-78f0-08de942edc4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 oiukZNUK1PIXB7OzVOBKTLavDseeZGxkL5sPdz0YYVxWD+uhhGjKzMErDNvz7YdMGFXjgoFv9TUq32nkDNMMLZGQj6D6H3T/NS/PYATiYdds4BbCC2+epUXHnOdQkhgAUnNxjHPk0EnWJroVLW3CDqzDHpzz08oo0rESgr8RIks2cJMj3zuLKsCzgFmJPVS/nKXI/Sc/gI1c/rq2q6BpLYWB6KEExhoCPeIHZG05zax4KWoXkP17nuCqKE1VBJE+oloa1nHhewB3ZYtsmILwjZtqPM8EJOfhBM0HwCySO6A3pnc6gzMclKDQ/RkoeIE7W9f1Mnc3bqxX2CXakNpG+B3gl+hH3dPqf3N8CBHtn8uwpjHhgNaIlBs+LdRgKOy6Ns9Vjtfet64G/88vVf6WWTY5LljoTum8KwAachG8JtrhWUd304COgDIDiPwdUddaDW6/MksM+SYcOs9Ij2C9Eny31mqX4HCfcSu0yI+IZo0iwN5oTYU1K3eXW8W10LFFrnMLowPoJBFhfTstOuxQnlLQi7p9EUbkIhQRh7AxW840feP5sJq0EK3HqyrSmHfg78x3oOJXSSHeSzyhlKss5y1BpvQuF4JPxUwP93UOlSKnYg+2UOqJCTz0BFzsVisto2auNLu8ggos8H9SR3ygaSzBSvrrq+P9QpE35AY4163+7gV7xOi9H1hWeaEfybJZ/G+wgiOBEDZ5evzAB7RB/AI2VN6U2vySaMYbTFLTeScgHF5HUJYKox1QHJsxkpv8aTHKILmsRpMm7iS48cD1J3/uzdM3M81OTfimq+eSmoA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ME0P300MB0853.AUSP300.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4le0RZTIsoYQNRjwb4UzrA/OC8m+9/EtPqHLK91ZDLEuG0B9growufDaUN?=
 =?iso-8859-1?Q?9CJqvifntt0Qehspmjzi1zxbAQvWl4OACFaIOScgecLSllxM66cBRKM7Td?=
 =?iso-8859-1?Q?4a1J1D2I+rlsDRWd+PE0F/vvCyS8KI93sOBkEAbDOdXSiWJYONLYfXlo3O?=
 =?iso-8859-1?Q?xnLnxPCv0/Ljx/I8e4EJrPy7NjmPxfaC+IuvLuF8SYf8U5cSb3KOQRWM4p?=
 =?iso-8859-1?Q?RH9A1jzlVEsHLGKzSokjJokKeU2sgIHZ0TrAU0zmjHj2mBdu3ZxsvqwIfP?=
 =?iso-8859-1?Q?r1f63Q+lQGdAKekBMitH7cape6UcnnXsMQEZIy9We2nEXvG4izT6YQSuN3?=
 =?iso-8859-1?Q?CdR3nQk7BIgAyUTSvAsYYToec1+4KZQaanCNDNDJYCNXMI6wVydywRJEYa?=
 =?iso-8859-1?Q?fvk3+pr7BmPZNIAqGKvUd0o3DXZN7Rn2goyaZ/w/D65r2rVXlPmzgW16zw?=
 =?iso-8859-1?Q?nlAWzZXlve0GiKAqdSkMw1BaIO51+MTlX+aJiE9wEnebZZs5N5m28kTzhH?=
 =?iso-8859-1?Q?nBOVlyOXk8KOS8jE5qxSgZay1V/B06K/dT+913EaSiCBfedlsXJEBt6EbG?=
 =?iso-8859-1?Q?3oGPG387tcCm76F3ecF/EzVU2RvVw79hIssRvVX17rGal/R6+Vki4r2wGs?=
 =?iso-8859-1?Q?9wjP4aYZaJw1u2FYhevER+3dEAN7pCM9E1b4QZ8YUp08x0m5QJuEPeAM6j?=
 =?iso-8859-1?Q?A1llylmznBkuoBD3gCEHXfH1DQJwJfCZOPX7+F+Rhy9P+RSc+X+PsEwUuw?=
 =?iso-8859-1?Q?PLjwdxkH7PshOfOnkMnVTGQzFF32AVGD2iTpzHkDpRnaUdzWeUzdYA9/Bt?=
 =?iso-8859-1?Q?LgdQ+9Qoz5GTdaw3dgjyfigBOIIQUEjmufXFdhmHrzfw92efhug0KzA2Iy?=
 =?iso-8859-1?Q?IjTah0GRBducMwi5gtKoZqusn3JFot+jjtVF3j+dA3kDmKBAWF6OTqa7R/?=
 =?iso-8859-1?Q?AZZnWyWGPicxG0pnYuyGOVwpn0JnfOJhQzSP1Zi0eTYu6iJM8oTmutmRbh?=
 =?iso-8859-1?Q?VlV2x92g5lkAQ0RiYfqB4muCrV8hZURU9NqRGrmhviv0wkPj0CqrgnUd6U?=
 =?iso-8859-1?Q?7LGoyoPz3kDrA0QIAPMqUrNpE+93pvFZ4KsQvxBot2hRAKNFcCYBXZqoIS?=
 =?iso-8859-1?Q?93DpM6NWF7o6zuFAEs1HRJmWkGJMMTXNJOB4KPE2GkFUoAWe6Mc7ek8RRi?=
 =?iso-8859-1?Q?oHHcB5d0MO87EA1ci2iYTxkFUoqfI7Mh6bIrI/rcvDzJEdOku8vAo7LoT2?=
 =?iso-8859-1?Q?Va825aEf6i4VA3k+YkADYQralV5UmnuLqJQm2dpDT3nnImAZRl6fLqb+H0?=
 =?iso-8859-1?Q?57JlRLRpppGy5jNcuz1/0RtycLPSV2Fsrc+H0170l6mxcqh30uJznwtgtf?=
 =?iso-8859-1?Q?sxF3H1g6F/QEguAw8olse4JWMP9ITae3KiP3ucdrpmYZY9cZoVlu6BnWLe?=
 =?iso-8859-1?Q?7OhWleovElICHo0vuOnpn6Xzr/EftcIAGf52D+s+o5mbfGxrKFcs+FiMJv?=
 =?iso-8859-1?Q?tVhnoeI9DspomSwjPVONGyIZrAr66byTbdzy9kAXhoSAUDt/wxV7Enw8Lq?=
 =?iso-8859-1?Q?P0/LKFVDQyWb4uqp6VWTKsVSAJVB84DMSv2n2PPyLLWq4j6sfdrG+Du9PC?=
 =?iso-8859-1?Q?j7Dtwkq5qRn9WV71ChxqGQ35PYyQk2Tc5KR/KhC9EpowNb4OwqF5ea5hwx?=
 =?iso-8859-1?Q?qTRslhYxzygrLmWk2TJslk7zEaVs/xsRwDzNwxRY3p+HTZ61gV/tqgyZJv?=
 =?iso-8859-1?Q?HzV3XYKDwyOsFDYDNhcX4MkaJB5FSudX+ia3rnvnlFrIuheLkp+9ysHDfx?=
 =?iso-8859-1?Q?KA84jd8GpQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce11d30-fa47-45ec-78f0-08de942edc4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 22:50:11.8558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccdcedb0-4edc-4cc8-9791-c44ee6610030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0VQ2kTeRZOQ+AvH+TFZyrgDeZjocdaE+yt8JKxn3OFuF2/9C6l5Mueoeq6au9shPB2s6NKWxqTFEZOaRakegg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1529
X-Spamd-Result: default: False [1.64 / 15.00];
	R_DKIM_REJECT(1.00)[verivus.ai:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[verivus.ai : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233457-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.699];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[verivus.com:email,verivus.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0322B3A7F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

amdgpu_gem_align_pitch() uses signed int for the pitch calculation.=0A=
When alignment rounding pushes the width to a boundary value (e.g.,=0A=
2^30 for cpp=3D4), the multiplication 'aligned * cpp' overflows signed=0A=
32-bit int, producing 0 or a negative value.=0A=
=0A=
The overflow guard in drm_mode_create_dumb() validates width * cpp=0A=
BEFORE the driver callback, but amdgpu_mode_dumb_create() bypasses the=0A=
generic drm_mode_size_dumb() helper and performs its own alignment=0A=
rounding, which can push the pitch past the pre-validated range.=0A=
=0A=
A zero pitch propagates to a zero-size GEM object allocation via=0A=
amdgpu_gem_object_create(). The 0-byte BO passes=0A=
amdgpu_bo_validate_size() (since 0 < man->size) and is returned to=0A=
userspace with a valid handle. This object can then be mmap'd or=0A=
referenced in GPU command submissions, potentially causing out-of-bounds=0A=
access to adjacent slab memory.=0A=
=0A=
DRM_IOCTL_MODE_CREATE_DUMB requires no DRM authentication, so any local=0A=
user with access to /dev/dri/renderD* can trigger this with e.g.=0A=
width=3D1073741760, bpp=3D32, height=3D1.=0A=
=0A=
Add an overflow check in amdgpu_gem_align_pitch() to detect when=0A=
'aligned * cpp' would exceed INT_MAX, returning 0 in that case. Add=0A=
corresponding checks in amdgpu_mode_dumb_create() to reject pitch=3D0=0A=
and size=3D0 with -EINVAL.=0A=
=0A=
The proper long-term fix is to convert amdgpu to use=0A=
drm_mode_size_dumb() which centralizes pitch/size calculation with=0A=
proper overflow guards, as is being done for other drivers in Thomas=0A=
Zimmermann's dumb-buffer series.=0A=
=0A=
Found via AST-based call-graph analysis using sqry.=0A=
=0A=
Fixes: 087451f372bf ("drm/amdgpu: use generic fb helpers instead of setting=
 up AMD own's.")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Werner Kasselman <werner@verivus.com>=0A=
---=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 13 +++++++++++++=0A=
 1 file changed, 13 insertions(+)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gem.c=0A=
index a6107109a2b8..b4341abba20c 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c=0A=
@@ -1246,6 +1246,15 @@ static int amdgpu_gem_align_pitch(struct amdgpu_devi=
ce *adev,=0A=
 =0A=
 	aligned +=3D pitch_mask;=0A=
 	aligned &=3D ~pitch_mask;=0A=
+=0A=
+	/* Sanity check to avoid integer overflow in aligned * cpp.=0A=
+	 * The caller (drm_mode_create_dumb) validates width * cpp fits=0A=
+	 * in u32 before alignment, but rounding up can push aligned=0A=
+	 * past INT_MAX / cpp, causing signed overflow to 0 or negative.=0A=
+	 */=0A=
+	if (aligned > INT_MAX / (cpp ? cpp : 1) || aligned <=3D 0)=0A=
+		return 0;=0A=
+=0A=
 	return aligned * cpp;=0A=
 }=0A=
 =0A=
@@ -1273,8 +1282,12 @@ int amdgpu_mode_dumb_create(struct drm_file *file_pr=
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

