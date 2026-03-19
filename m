Return-Path: <stable+bounces-227205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCKNH3Zou2kbjwIAu9opvQ
	(envelope-from <stable+bounces-227205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 04:07:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C82C548A
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 04:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77933302E842
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23637285073;
	Thu, 19 Mar 2026 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GzFhGuz7"
X-Original-To: stable@vger.kernel.org
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011063.outbound.protection.outlook.com [52.103.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ECC31ED68;
	Thu, 19 Mar 2026 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889647; cv=fail; b=Tb71CHKRCBvwsNjMzsGB4csja9hxc07XI2UkGO0kTldCylUjUQCa5nuwalaxhrQjNiKnW34qUG7jp4Fp+FD4ssGP7cf2DaCHLfz6NKBIao4YTUnYsLffxzNM6x59e0tefMpxkkDheJg+V0v5vtcY2avlGZJSmBhBWmj+hUulFcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889647; c=relaxed/simple;
	bh=xt+gF9mxsU+zBbV4VS1Ir/AIq5L+Bv1rx4NN33eLkFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QEApiEHom64bai/thhbzfvL1M7u3yG1YZiWt8cfg8n0CMcChsKkC/gfaGgG5huwCUDsxLQ45blaI35IYDSZ2ut5wJ8b4BqMbUaLWe17NTK9VEYbT5K0AGh28hLjYYaQ+tQqGIyEFDwgDWFBBcwVWQ18jK4BurO6jvpzcvqnde9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GzFhGuz7; arc=fail smtp.client-ip=52.103.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LE7bre6ncp05GhQUMHiqhshw69E74u/exGuAdVgG6Su6BLRvmAxhgfzQIS5Q4Ho4ewKvWqZFIGOg3KrzQZhgxq6BIH1dQrFhWdWAmAIZHCK/IHlx0X2bkJtv1vFKTXnn+7rwD9jnZUxpbKN67N24RR/g0Uzw+XnUPYUb7WeslLs9vels9AKP2uU+soLxjCl3M8HPYcN/Nhm59mqUIOQMrhFT1OsDNXhVqOkpI7cVehb6AP+hdLnxNKiROkZgUkdI8Rls9FxLsHwdkbSH3wuV9CGJWoqVFE5ZcLVdSUZAqKMXD51zJdrzw8OmU5UlXbaSz+wJQlUD3x49xQZ02QHCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt+gF9mxsU+zBbV4VS1Ir/AIq5L+Bv1rx4NN33eLkFs=;
 b=QIeFISfvuX183SDIVxtOtQWRYyrO8T4PGKe35R8jSsmdX83Q9QcJzIH0lkwDneUUlZa9H/sdRoDTj1q+FW1xeWz1ePwbKagcwQJXGJN5JWL2n6W4HiYcO87SwizWCqmfSLZbiLUSZYECakdQ+nIu+vi/MOq/aHDllwyWKMOfl7qkaz+8S7GNzZ4WOopVsXOQmyeIl+II92CTW2lqsE4GF8HlkkQrMlRKrt95hznIcFHyAmJoFhlJ2J4Fs1X9Eir88gaqg7qbnqK7cqXUM6OctmREYdw0E9Bz5ZIPtUMDKT/XhucPgfMllY0IVuqCu0wwAlBvJOT7lUQx4bH0lT2DaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt+gF9mxsU+zBbV4VS1Ir/AIq5L+Bv1rx4NN33eLkFs=;
 b=GzFhGuz7dTCsuQKsYag699u5bErxiwR79SbpZUh82UYA6oD2bOuDTfWpdQ/0fur8+sEkSmrWGXxE+4BewdltF/QONE8pmSknC4G20x31mFCOZHJrhCS4Ey7wdIzo2jeuEYEvMFOaFRFRyU2KXfHbVjt/+GcL0oYGDjVFP3u8dPaOxktfn40Ng9xncPPmyG3bBIPr6a+1IMvMCwO+RDz8sHq9CK9VHZUDz5XHQWW2APFbhQJHIrEkSEl7SkKFPyLi4nKq4z+2eoKTnLPnPDo705TPHe0OXJ7vsXws5e3tiM5y7SDmUApgeUd4BmmkZkMzzdezvpa7fJlP4jXwuTzbAQ==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by ME0PR01MB9496.ausprd01.prod.outlook.com (2603:10c6:220:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 03:07:21 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 03:07:21 +0000
From: Junrui Luo <moonafterrain@outlook.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>, Tedd Ho-Jeong An
	<tedd.an@intel.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuhao Jiang
	<danisjiang@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: validate RX packet length
 against buffer size
Thread-Topic: [PATCH] Bluetooth: btintel_pcie: validate RX packet length
 against buffer size
Thread-Index: AQHctdY61Dq49ymkaEyMIMM4bCt9t7W0AwuAgAEsO4A=
Date: Thu, 19 Mar 2026 03:07:20 +0000
Message-ID: <9034828E-423E-40B0-86D5-2D773130F9D9@outlook.com>
References:
 <SYBPR01MB7881DD95CE054BC53AED4A21AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <9135f7c8-73d2-4cdd-ab82-25945d3324ae@molgen.mpg.de>
In-Reply-To: <9135f7c8-73d2-4cdd-ab82-25945d3324ae@molgen.mpg.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBPR01MB7881:EE_|ME0PR01MB9496:EE_
x-ms-office365-filtering-correlation-id: 1af0f0e5-3ccb-45c4-3c54-08de8564a2ee
x-microsoft-antispam:
 BCL:0;ARA:14566002|22091999003|51005399006|19110799012|15080799012|24121999003|8060799015|8062599012|31061999003|41001999006|461199028|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?OTN1K1p1TTFYcmJIaDlUdXBNWDhQOTBBSFE5ZVNQaFlRZWFEcWtaaFY3VVNs?=
 =?utf-8?B?RFpwUW15TjY4L0Vzd29XMEkvc0NvUmthUWt4TXI5WFhOdlRXYjJlYXc2WlIy?=
 =?utf-8?B?TWkzWmJtVVlKSzY5OHlIME4rS1NzS3liaWFNYThQK20zeXdNR01JUE1ES3RW?=
 =?utf-8?B?MFR3M2tnZ0pYSzBuWkJLNEZIN1ZBYmRTMG05NHVCaksvM2JLay9mUGtadDZ2?=
 =?utf-8?B?bHRSWUlJZkk3ODl4RXE2MEtuanM4QnJUUjhQckFzSkREb1RQYjc5NGZiUFkv?=
 =?utf-8?B?VnJ1a2l5eHNtaFBGbjRYOFZqMFk5NkVxWWZmK0ptSW5YUldTbGhabjBPOHBU?=
 =?utf-8?B?Nkd5ejhxMHgrM2FCZnFIVTFHWUxFMnkwaVRhbnN0TFdMQ3dTZnNuKzA0NHRm?=
 =?utf-8?B?M0xwL0JQOFZvaHJVcGZ1WWI3aVE3eGtWYld6VExhSXZhSUladlhhWmMzeG8x?=
 =?utf-8?B?WFNQUk1BUUlHL2FvZDdkckFyRExFS1FBUU5DZTBqZjE0NDFqSG01MWpJTFdW?=
 =?utf-8?B?OVhkRy9TRmpOcExhMjVha2wycWRTelZpL29kTHZBaEU4bVFWTDFzYm9nQ0Z3?=
 =?utf-8?B?UnJuekZIZmowcE44WVRDTzFyaGx1ZDYvREtUTUdrenpjeVZxeGRhWlJacG9H?=
 =?utf-8?B?OTdKUmNEUE5XNjFkM3BoSjlDZTA0c242RHBMak4wOGdLektBWGxpRjIwcW8r?=
 =?utf-8?B?eTZGSXozcDF1ekZQMjBNWXlES2d3RXZKczI5L2hDZWlkVktzUXNHS3BEOEN5?=
 =?utf-8?B?RStDYWx4Y3VndldQWmpIYXlDbkpuUEx4S1QvRzJrTEllZ245QXQ1cm5Bam5m?=
 =?utf-8?B?cGlMY21Gek13ZnI0WFJvWVVobUhPZEhBajY2NDFmSkdLdHhPWEZYSER5Zkhn?=
 =?utf-8?B?ODA0NG5zV0pYd0ZSSFlrZjg5OVFZRlA4UUNwMGQ2bXE4ZGdUVlMxeVNINHlv?=
 =?utf-8?B?Ym4xTlRSVWk3Y1BCNGRwMTNPZVZGbUVDZ0phYVFvZncvdUFvRmVFOTUxVGxL?=
 =?utf-8?B?bG1tbHp0NVdmYUJtNEVxTG1lTnVrU2ZKSHNaUWRiRFdpSWtSeElqd2lJUUlX?=
 =?utf-8?B?LzJyVXpiUWUrVi9DbHVETlFEY2RYMW54RnRKRktRK1BoSTFIM0V5S3pyUzRF?=
 =?utf-8?B?TE13aVBzeDRiMVZPRkdmazZvU094TCtibk1SR1hiRnlQMGF5ZlRxNHRlRUxv?=
 =?utf-8?B?RDJyb3hWczRmQjYxaG5CQzJsTnNWeTdmam9uNm5sV3AwMFdweGpDdEIvNFFZ?=
 =?utf-8?B?N0F4QmN1dFZVM2xJQXA2Sld0TTRsUFlYY1Z4dzFkZHE3R0JBZ1BxTUdDWDkx?=
 =?utf-8?Q?6+E6UmTyL1IA3C/21y9l844TDCmrlzKGLo?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGMybC8xdmg2d3FaTlREYUM0ZnB3eWdMRE0vSXVnVjJEU3RlWmwxNXExY29M?=
 =?utf-8?B?RW5ReUk0QjlGb1lNWTNrNE8rckhTc0FhNXdvRndUMFM3RDMvdUJDWEpvZnFI?=
 =?utf-8?B?WkJRd1ZJNllISmVzNmI5UmRHeThqR0ZxQjBYa1h0QTg4ZkJCb1A4UnZxc2la?=
 =?utf-8?B?Tk1yK2U4R1lkVHJEUk1ZdWoxZGptR29yK2UrTTkvci9sYUI4S0crV1djSjZR?=
 =?utf-8?B?WEJMbnZsSkVSbWg1MzFhOXhuTXVjMDh2Tk1tL2ljSWFJT3JMLzNoTEVXZ3Ry?=
 =?utf-8?B?cWNrNUM3T1lCLzR6Y3lxVmRqdVpkRmhCbjYzYnJxeXdldDlDellvMEthSldQ?=
 =?utf-8?B?Z3phZmVCejlVdVBidUJyL0xVeFNnTE1wZWhQbkpWTUhOcW5IWHgrU3pqU2Zx?=
 =?utf-8?B?cjczSXd2dU5YTjN4ZE94bml0djNweEMvdUNpSnBzYVZ0WWtpM2o0eWFhSVJE?=
 =?utf-8?B?NURVbjY1K3RxMDhvbytzUDZiOUhxeVkrQWJKdlJOMjc3ZU1rcGhYSmkzT0Vi?=
 =?utf-8?B?V2RrRkpVVVdCVVhwYUxQNFhXbFAyNTY4TEFJckxBaGs1UkZZTzBoU3hCSGRQ?=
 =?utf-8?B?bnZwdkY0NThwTkljbXpLSk8zK3Bjek9kUmRPRUhvZGVUbVIzVWJPWlJDRlBF?=
 =?utf-8?B?cTJGdFFlenRhVGRrbEkxM1NrbW04bWR0YitZZ3ZTZ05Mek1DbkVuTm1pSnZU?=
 =?utf-8?B?UEpwZGwvM0lzUmJuM3VUNldISHRVMkQxR1BSdm0rL3FBQnBrWHRSbzh0MzBU?=
 =?utf-8?B?TlRDbjBPd2c1Z2dlcWpyTnFzREpNNkdkYWtSbmZBQWtxS3VjZ0cxL2ZhUHV4?=
 =?utf-8?B?S3E0VVNkRG12SysvQXl2SmJsVjBJTmZmMDRpc0tLNzkzalhhQ0FTV25hcTY1?=
 =?utf-8?B?bDVZUWNtOGpiTzRxSjhRRldtbXJPdEpsbHZidDVmVHEyWFJ5R2dUT0VRazV4?=
 =?utf-8?B?dmFuNVNPL1dzdzAwakNveEtRSDR6ZXAzMGlHdXg1Wk1MdG1yWVlMTW1EbUlm?=
 =?utf-8?B?dFM2bjRxczZqRW9DazFtbFdtR1AzMFI3b2NhUzB2ajVEWVVNVFhXaTA2MnlG?=
 =?utf-8?B?STJ0SmcyUkVyZjRoekovbHl1cFNaUlRrRGZBOE9oa2J0R1d1T1FwODI4Qmc0?=
 =?utf-8?B?djhxNU5HMEhrSkREOWh3bGY4MnNOTm96MTVLZUFJeHJOL20yOVZJVFBCRlFi?=
 =?utf-8?B?RmsrWWduNGJ1ZVE3a3BLbHJFVXVSbmRJOVBGNy9IRURpSjdZc1VMcFZsUUJD?=
 =?utf-8?B?NEVBUGo0eVhieDQyQnRYU2JHSHdkWDkrYnh1cTZQOGRqZTJXNWhHVXRIWjVG?=
 =?utf-8?B?THAwM01UcXZpakRwOVZvSVBrQ1RWYTc2NUh6L29aeFpET0pwN0tnN3RzbWNN?=
 =?utf-8?B?TkRZb29CSDZOMHpUUnZxeG81a2tOMTFrZzlJZjNhYkFKUnZLaW5VM1B5RXZJ?=
 =?utf-8?B?WFlQdDFjdXdzeHlYbUNVZ3ViVjdyTUNadEtxeWxMVkUvV21heUlsVklRdHYx?=
 =?utf-8?B?a3lWOE1ZazZNQ0NaY0RBa0I2WTJXVjVTaUxkdVNwZHlIS0lkWDhFN1NFZ2Vr?=
 =?utf-8?B?elZoRVVOSDJhVGd0T1krYzloK1g4NnZncTk3N2JpdnhuLytoWVJ0Z3ZFNHh6?=
 =?utf-8?B?cURWVUxDZVJVN0lGSlNmWUpaYSsyU2tsZjdhSm1mcnVuOWNtdDZTUVpwSVRG?=
 =?utf-8?B?WDdlQStHNW8zU0syUElQTC92Ti8rZzNjOXZPbVpvRjVuS3d1SERzakRlKzF5?=
 =?utf-8?B?eVpiNXl1dGplMjJBWU9ySCtacmhvWVZHOTZ0Rm5oVmZZRTIrNEdHb3hIUFpx?=
 =?utf-8?B?QkdJWmk4dFRPeWRXNkNmS0JOZ2tyNFI0NzFtZTFnVnIrWjNqNCtSK3B5NGlN?=
 =?utf-8?B?MHlJSkF0REliaU5zTitMai9IakNzMEVhdXMvWnBjVkZ2d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20E759108981E342B66916AFC3A8F008@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af0f0e5-3ccb-45c4-3c54-08de8564a2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 03:07:20.9378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0PR01MB9496
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	TAGGED_FROM(0.00)[bounces-227205-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[holtmann.org,gmail.com,intel.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.385];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,outlook.com:mid]
X-Rspamd-Queue-Id: 190C82C548A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgUGF1bCwgDQoNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpPbiBXZWQsIE1hciAxOCwg
MjAyNiBhdCAxMDoxMjozNUFNICswMTAwLCBQYXVsIE1lbnplbCB3cm90ZToNCj4gVGhhbmsgeW91
IGZvciB5b3VyIHBhdGNoLiBJdCBiZSBncmVhdCBpZiB5b3UgY29uZmlndXJlZCB5b3VyIG5hbWUg
aW4gdGhlDQo+IGF1dGhvciBsaW5lIOKAkyBjdXJyZW50bHkgaXQgb25seSBjb250YWlucyB0aGUg
YWRkcmVzczoNCj4gDQo+ICAgICBGcm9tOiBtb29uYWZ0ZXJyYWluQG91dGxvb2suY29tDQo+IA0K
PiBObyBpZGVhLCB3aHkgYjQgaXMgbm90IGRvaW5nIGl0Lg0KDQpTb3JyeSBhYm91dCB0aGF0LiBJ
IHdpbGwgZml4IGluIHYyLg0KDQo+IERvIHlvdSBoYXZlIGEgcmVwcm9kdWNlciBvciB0ZXN0IGNh
c2UgZm9yIHRoaXMgaXNzdWU/DQoNClRoaXMgd2FzIGZvdW5kIHRocm91Z2ggc3RhdGljIGFuYWx5
c2lzLiBJdCBjYW4gYmUgdHJpZ2dlcmVkDQp0aGVvcmV0aWNhbGx5IGJ5IGEgbWFsaWNpb3VzIG9y
IGJyb2tlbiBkZXZpY2UuDQoNCj4gQXMgdGhpcyBzZWVtcyBhIGJyb2tlbiBvciBtYWxpY2lvdXMg
ZmlybXdhcmUsIG5vIGlkZWEsIGlmIGl04oCZZCBtYWtlIHNlbnNlIHRvDQo+IGxvZyBpdC4NCg0K
V291bGQgaXQgbWFrZSBzZW5zZSB0byBhZGQgYSBidF9kZXZfd2FybigpIHRvIGxvZyB0aGUgaW52
YWxpZA0KcGFja2V0X2xlbj8gSWYgc28sIEkgd2lsbCBpbmNsdWRlIGl0IGluIHYyLg0KDQpUaGFu
a3MsDQpKdW5ydWkgTHVv

