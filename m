Return-Path: <stable+bounces-161795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E1B03491
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 04:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E684516FACF
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 02:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DD81B041A;
	Mon, 14 Jul 2025 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="jHDqfFwn"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE42D7262A
	for <stable@vger.kernel.org>; Mon, 14 Jul 2025 02:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.130.202.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752460998; cv=fail; b=W8jIa+nCfZL89WarwEXwuV4k2X8hOmN379LNJqe+kzV2eS95LOnXo3owllItMlM//FluUO70BfoRucu1VPh95UjbjWznnDHcpG7NCJHaGEhC33qxZk0P/la/KhtyzIggEWZ5ITfxFutybpalSMa5cxKWYnckqKXdndDqoNcOQr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752460998; c=relaxed/simple;
	bh=qfE/95MqZCkILFevlMdCq4aouF/7ztntqP0qlarSm3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H3D12HhrE6gYw9x4FUPl2UFHdpXx6UIqJjTHYB4E3GQcy0bADhKJEEKENqYfqHQUUo3iMGr9QOoQ39QmGvRokR+QNyxHN97B1W60ruVCbIZbwlF+cgwFdpgcnrWphEqnWlpKhKvZGgDyjUOw5fQRBUeXM46sOdx9j1Pha8mAM6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=jHDqfFwn; arc=fail smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 56E29TQu072965; Mon, 14 Jul 2025 11:09:29 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752458936;x=1753668536;bh=qfE/95MqZCkILFevlMdCq4aouF/7ztntqP0qlar
	Sm3w=;b=jHDqfFwnz6T4Bsgpthqen6bzcbc+9sIvx0MPqYhisYzTAmRwg04Grnw4AIK/CGrNBeZxM
	8TQUjSes49weW3gkGJgZZPwyf7XsMuFI6lqXse8w1sllWS9Dm+AHmEONREMGiPAvoiFANqg9rbKBe
	vSLk2WxpNuUD3jagpuY389KFPhl9pa2uxD1JoiZMQiBBP1tKKJmTn1jco50gygj4XOLvCUA9rYN43
	/7JxCa6xQ0rLvfK/IDydJG5hTCLHIAf8RUcfxcp7Uwf2VfQucykZ9GGKqs3JZ+Ro7HlKdfL4hRBur
	Fj3nWmLFWkPVxCrEqet6i/gm0x8YZoMYHjNa0U4+qg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 56E28uKT2015966; Mon, 14 Jul 2025 11:08:56 +0900
X-Iguazu-Qid: 2rWh5b6vIqDqgx53kM
X-Iguazu-QSIG: v=2; s=0; t=1752458936; q=2rWh5b6vIqDqgx53kM; m=SSQP3sZuLNUYGF67BEOro9zRjzd1/TXh3pOkxbpZEpQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 56E28sqQ1020700
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 11:08:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7TQZNpAdHuh5G2FIKt2c+UNQg9FC3DaG5mHu2E7F3LyN9sOfyprKAh3+v7dQ3Bh+XLNEGvNuedFwMOAO4etclWK8EYW0NUGNqPe3/s4EVtlh4kSYbQp6zlzW2TbrIf2V+dkR4NNcdMYgaQ6cx+19wNTxUUYXor+TqSx/7r8lP1m/QGwe8cn6MduaP0ww5h8VKI9JtievZZsx3wYNUz1SLwQc2oOAKewB3awmcckLV+sQAvB1tGcgELAEGV5GzEz0bCbAaiw2O0XY8f5z6nejXp3mAriuEwp2VkgooFgmFCOOFEn427z4GgRaxioJnu90jS1q5NTGPJ9T/RNngBclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P21RHauWSIF+aXzGFBpH7Wzk7UmerEmkmJq9vLDGaJ0=;
 b=UJD5M60XVCRcjRq4qa9QsUjcnTworSLkCy2CE2HTMNN9JTmbzMXDfNWkvWl1cAR7t4ElwvNGYeKBlRcLGZxfNvNwHRtX4zvjOw9Z+F/yrvyXlPuoT9FeJ6ItsdZARBlOlxldlOfla11h5eu6nIQBNrHUxGsr2N/xZ+yAjiVJF27cxbZ903bzCuYXyBBetZUB7EcfAq9JjV/ZKavoFUPBwaWFJWCsB1kh0n0oQp/CZMcIZH/P9mYwsxu7k1qDR1ycuMhfQ01fC7rYxovqSCGsTTSZWGK71TxlLW5Y+MR3cGsweP/e48ZI0ySugc4VSev1xmGSS8K5ZpugFbzJVp29xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, <sashal@kernel.org>, <snishika@redhat.com>,
        <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH for 5.4 and 5.10] ACPI: PAD: fix crash in
 exit_round_robin()
Thread-Topic: [PATCH for 5.4 and 5.10] ACPI: PAD: fix crash in
 exit_round_robin()
Thread-Index: AQHb5WPV1Pq3Zndeg0+4j+s2VpBU4bQrdH8AgAWHYNA=
Date: Mon, 14 Jul 2025 02:08:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D024F5BD469000A887489254A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1750809374-29306-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <2025071024-move-barrette-1e52@gregkh>
In-Reply-To: <2025071024-move-barrette-1e52@gregkh>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYVPR01MB10750:EE_
x-ms-office365-filtering-correlation-id: 359ba730-f866-401d-1f8a-08ddc27b6152
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dmM0RFl2REh6Y0NVaG1rQkJSRC9tSFNYL2pNYmRVTEhBSmhsMUdKa0pH?=
 =?iso-2022-jp?B?RmlrVEx3N0tFRU5waFluQXAxVU9PUTNpVWd0NjdleDdtZFNiWSs1YUVU?=
 =?iso-2022-jp?B?N0dwU1pjWW40UndkODdvME5yNHJSNzg0L2RHMUlPVENOMDhzQ1lINm9l?=
 =?iso-2022-jp?B?YjdZZ1BUZHprSnJxRXZTZFVLUVMyYlRmWnFTa1ROTStVUG9pN3kzdjZM?=
 =?iso-2022-jp?B?UXc4OFpXQVIzYVdrdnZuNU9PUjBlc05GYVI2dmd5bTMxR2I2cUVkb0Jo?=
 =?iso-2022-jp?B?WVVvODIrMHIxRVJ4cXA2ZHd0NTNwaEhYVDJjQWQ4NTJ1bms3YzNBK1NP?=
 =?iso-2022-jp?B?L2h3eEJvRi9QYmErM2VZbFZiZFVwbDkzbXZsRlFRWWhZQ2M3R3JVbG9w?=
 =?iso-2022-jp?B?YjYvUkxpYlBrYVdDYkxLZHdWM25iVlhodW9UbHdUK1FjMmhpeFMvK1VO?=
 =?iso-2022-jp?B?bERVc3hhV0RJUzRXS3Z4WEpYUVpQS0FSOFVKMTRvNVh6bUxoVXkydXhz?=
 =?iso-2022-jp?B?VnJzN2dtUlc1Mmg4Qmg5Unp3TFdKdWRwTGlPSGl2S3FKeWd3dDVKeHpR?=
 =?iso-2022-jp?B?cTd4cDN3YURSVWpCemdNamdPNEtKdy9GejIvTFJoRzRoQVp6bEZxcGVr?=
 =?iso-2022-jp?B?UDRLNDlSYlJWMSt5bVlNSzFSTmc3WmVMTmZaU0c3ZXFCMVRwQ3RFU2dk?=
 =?iso-2022-jp?B?Q2pMOGZaNjBOUkxkbTNvKzJYczk4bkp5UjBsSjNScGNQb0dKeWdiM3lU?=
 =?iso-2022-jp?B?MkR6RUJFRmM0VWUzcDRuTDJVMlhaYThIOVJlNUFXcjY3M2hyNUNLcGZT?=
 =?iso-2022-jp?B?Y1FoWGJmRVdXRzFzSVZOeEFPZmJpTmdzUlN4bkl3dVN4TlVIUnVPa0dG?=
 =?iso-2022-jp?B?Vm9GZ3FsSzNuTlk5cjJOUE1XNjNtdlQwUTZ0N0pUUkNCZktzb2hnR0tM?=
 =?iso-2022-jp?B?b2ZuY1Z4OGJuNm9SZ3M3U2Y1NVVqcS96amV3MTJkZzF0cklLdUc3U2dN?=
 =?iso-2022-jp?B?ODh0bCtwZVQ1c0x2VFlVMkI0ZVNlM211RlVtNm44WXhYRDZsekRZbXk5?=
 =?iso-2022-jp?B?M2ZPUGRLeWR3M3NRVHJGamlITWFzcTc4a1NEUC81aW9kelVCbXAxY1Vt?=
 =?iso-2022-jp?B?bmo2QVFNUmtzOEZUOCtsWFZ1dWZOMWlXZ0R1MlRLRDNHd0tZeHFSUVZJ?=
 =?iso-2022-jp?B?azAzQms1K1RXYVM2dGZlLzFVYU93dWJrYm1ta1paNmhSTXNUTWpuRHBZ?=
 =?iso-2022-jp?B?UmZPOUd3K1dtRUJCbTZzZE5rQy9hZk9VbFUzTXBmbzBRQ1ZLMmFNbDJW?=
 =?iso-2022-jp?B?UzNNS2lRUzJwYzZVWEwwNFpsN2dTc1lFSXZuV0NyNW0vUUxqMGhwMmIz?=
 =?iso-2022-jp?B?amlPa2lQR0hFS3VWT1lNSmRjam16cWpSSUU0cUtaZkRSM2Y4RCtOaGt4?=
 =?iso-2022-jp?B?dFNJMVZFTnlRNVhoNWdHUnc0ODJtVUg3TUFMa0Q1eExWUy81Tmd3RW1y?=
 =?iso-2022-jp?B?MlM4aFNONjNNbTU4SU1LdjJWa2s0RUdOMXFueUhUcWhVOGszVlQvckQ3?=
 =?iso-2022-jp?B?UWt6UGkxYk4ybDZURWY1NzljaW00N0NiZ1Z5NldQU3Jwa3FqYXhFZFZ6?=
 =?iso-2022-jp?B?TW05SnlRMlJNM0NPTjZpeGVyV3E1R0dUYkRMREk5UmZHVWRSZG1xZFJz?=
 =?iso-2022-jp?B?NUVkRXo2V3VOd004VzVnZUgvSFVJWjFvaE1xQzJJMkh2ZkdGRC9yQ3Jj?=
 =?iso-2022-jp?B?WkR0TStMVzFITW80Sjg3Znd5d2k1MDhpRDh5cTF0OVI0L0ZudFpVdGJK?=
 =?iso-2022-jp?B?alBTTmdxcTdPK1V1dUROTmJTcXczUy9uWmt1SFlSQWpEMEE5WVkvYUda?=
 =?iso-2022-jp?B?cFNRZDFIeTcxZnhqakR3SUpPcmlHZktVWUxCclFoNXdmZGd0VFZMbEFX?=
 =?iso-2022-jp?B?N0doSEJlem5TckNaaGxVWlhlUjcrNk53eGlvNU5oK3FTamNaMWUrcnoy?=
 =?iso-2022-jp?B?ODdGQUZtbDk2SExTaC9hSXB2VTNFM3dEUmpab0tqejdvS0szeU9FSXY4?=
 =?iso-2022-jp?B?K0IzblJBNHVOWnNkT3FjOVVOSGtTZ009?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?L29BYWxVQzdmTEc0QVpwWHMweDZsL096YkxqTS9vSnZDRDFDc1pDTk5O?=
 =?iso-2022-jp?B?Qk9kaWhQWUhEelU4b0RxM29pdTF3ZE1Ob0p0MnNFNGk2QU5qU2tZWjF5?=
 =?iso-2022-jp?B?ZEg3NDZ2MkhFckovUS9GQit4NFMrd0lkNEpTdk0vRTJBNVZLR0Q5SzYy?=
 =?iso-2022-jp?B?T2dha2ZCNjd0eDlLa24vSHM2UkUxNi9xVjVidDAwNndTMHA3OHJDTmtv?=
 =?iso-2022-jp?B?OGI2aXFHUXc2ZkdkRk9YVEVhS0xOeG5RTjF4UnNMNUlwNE1pTmIyVHhX?=
 =?iso-2022-jp?B?NkVIKzZlL3F1NFE4SkVjZjVlOExySjNKSWgyRWFzT0JuenUvbEZicVM2?=
 =?iso-2022-jp?B?RXRaWWw4bjYxT1BGWThVSWtnT3JwSFpYM1pRYzlaTHA0Ymptb0hFdlhF?=
 =?iso-2022-jp?B?Z3RGMkIvTWlCYjZCT1lyUTBiMEJaY2RjRkdoNE11N3NVV2NKanB3bG01?=
 =?iso-2022-jp?B?ZXJXZEpsUUd6SGt6eG1oRkphZ1FMNjlBd256eW5meU1CQnl0RXpWT0VY?=
 =?iso-2022-jp?B?TmtNN0FHbmVNV0xIei9xSEZlUzdnVnBpaEhOWTd3TEZ6cGUvZlJkL2tm?=
 =?iso-2022-jp?B?ZzJxdHZ4ZHhtRjU0WUZ3UnBzV0hXVkhUbTVyN2hwSEkreHBIQ0U0UkxL?=
 =?iso-2022-jp?B?dUVMN2tMVmJRVWtmdGFrKy9wRVR4ZUZ0cVd5c0haQjlGREJSbm5uRUZh?=
 =?iso-2022-jp?B?L21OOWVrSlVhaUlwNHlyRG9mYVlPU2d3dTVXSFJLOWJnU2d6aFFaWHJB?=
 =?iso-2022-jp?B?bVA0MzcyQ2FuTk52Y3c2UzZoNUFEUlVKc2xYT3FoMnVOSkhWUjlBM1Nk?=
 =?iso-2022-jp?B?dHMyNnY2QjdiaFJDaUtuUDBGL20rWkpvMnFleU1ybC9HOVFuYkJ6MUxa?=
 =?iso-2022-jp?B?R05mbVB2YVV1SGxNN0NrUW5ZUkJFR24yUzFaNGgrb29qbDN3amQzb01o?=
 =?iso-2022-jp?B?VnF3aGQ4V2oySS9YMEY5bFNlbzJUY2ZuYWpGenhXNDUvelROVzROYnJQ?=
 =?iso-2022-jp?B?dmE3STl2dk5GWUJRTHc0VGV2S3FVNGtWK1ppZ3NlNHJFRUNPQ1RUM3JS?=
 =?iso-2022-jp?B?VUVXUWFTbklaT3JIVC8raU1BY0dWZ1hpM01HTVRXRExpT1hmUlljbytV?=
 =?iso-2022-jp?B?VnllZmFJZzRrWTgvaE1WaW5ZcGxNaUhIQU1CK0NaNXgwQllud2xJR0Z4?=
 =?iso-2022-jp?B?RTZZOWFMU2JvRVlkMW80d2xreXR2ZlFaQmxwNVdDQWN4MXRYTWFDVjhs?=
 =?iso-2022-jp?B?c004OW1BanJFbXIxT045TmhXNVhDNjlGY05Ub3R2YkNVcmdOV25tTlFW?=
 =?iso-2022-jp?B?ZDRVeEE1Q3RRdUhRbWdRbURYNm51VnNvampldFVsZWRvUGhlbG0wNUg3?=
 =?iso-2022-jp?B?bzJhR2NYMU1rTWpiYTIyWnlJRkp5anJjL2ZhMGpDOFVjNW5rWDl6Zmgr?=
 =?iso-2022-jp?B?UEVBVkVJRVRUK21WdVhOR3duU2JDOXI2Y3hEcVhHZFduZDk5Z2FLeGp5?=
 =?iso-2022-jp?B?MmEyU0daNWduZDVxUTc0MnpYV3NDK2JCU2RVTEJsdEJKRktMMk1UNS90?=
 =?iso-2022-jp?B?VkVCOVRqeXNSSGxCdXA5MkRpbzJHdEVHU21vaWpPbzdNb2tiaFg3NFI0?=
 =?iso-2022-jp?B?THNRc005UkYwVUZ6VDBKMjVyRzk5VERwSzh1SVV5UHhhcGlUZDQ4SS9D?=
 =?iso-2022-jp?B?ZXpxdS91Zm10UGx2L2M0ZjFjNHhCRzhUa2NXMVhHQ1FpRkg5TmZiTlJo?=
 =?iso-2022-jp?B?M25sZDVhSWRTaklQdktLLzQ1TnR0MldvcEszSm1ienk4ZkZoMGF3c2JY?=
 =?iso-2022-jp?B?MUlYL0lGYUVBT2VOQk9TYTFPVXBtdVdpNWpGL1d3cFd4dWlUWjIrRzh4?=
 =?iso-2022-jp?B?S2gxd3B0S1EzSjE5T2RQa2x0eDd3SU5RTWQ4R2x5U0l2UVR5QmNWOHFQ?=
 =?iso-2022-jp?B?Wmk1bG43a1NMcHpHajlRZHpZdTZCR0g4MmRPY0VYZ2tRSEtlQ24rMU5V?=
 =?iso-2022-jp?B?WDJVeVV2c3M5a3p0azd3bU5JanJzZzcvWFEzWVpiRHAzcXdIcHcvYUhh?=
 =?iso-2022-jp?B?L1F2bG5HZ3p0bCtaYm9OZFdhMXJsdGpSVStUeDk4YkZ4ODN5Nm9tK05p?=
 =?iso-2022-jp?B?R2lxVzg2Y3piMDRZYkxYb0NxSmpyOWdZeUZUQXk2cUNDUWtaeWNzZGps?=
 =?iso-2022-jp?B?SVJhSldrWWozRkxjR3p6Um1GOE9MUGZmUkx5aXpNOVRWWVZ0aG1rbVU2?=
 =?iso-2022-jp?B?ME54VjJzZS9CcTcvWjBhQVBFZ2FhL0pBUSt0QjluRGlUSzN6V0M5WGV5?=
 =?iso-2022-jp?B?M0dqRUVIOHg3a3VnbFJKQytCY3B2eTU2MVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 359ba730-f866-401d-1f8a-08ddc27b6152
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 02:08:52.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2CmIYuUrv0k6+eYn1u1YLZVe11rbU7KqWZegNACQCA7KcMkCv6JJin4psiAH2hTUyBI9mcFSaUEo6JNDops3i5O/QdkJ/aqMEXxhobUB/pkIlj2fF75M27/2sm0mcvQA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10750

Hi Greg,

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, July 10, 2025 10:36 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: stable@vger.kernel.org; Sasha Levin <sashal@kernel.org>; Seiji Nishik=
awa
> <snishika@redhat.com>; Rafael J . Wysocki <rafael.j.wysocki@intel.com>
> Subject: Re: [PATCH for 5.4 and 5.10] ACPI: PAD: fix crash in
> exit_round_robin()
>=20
> On Wed, Jun 25, 2025 at 08:56:14AM +0900, Nobuhiro Iwamatsu wrote:
> > From: Seiji Nishikawa <snishika@redhat.com>
> >
> > commit 0a2ed70a549e61c5181bad5db418d223b68ae932 upstream.
> >
> > The kernel occasionally crashes in cpumask_clear_cpu(), which is
> > called within exit_round_robin(), because when executing clear_bit(nr,
> > addr) with nr set to 0xffffffff, the address calculation may cause
> > misalignment within the memory, leading to access to an invalid memory
> address.
> >
> > ----------
> > BUG: unable to handle kernel paging request at ffffffffe0740618
> >         ...
> > CPU: 3 PID: 2919323 Comm: acpi_pad/14 Kdump: loaded Tainted: G
> OE  X --------- -  - 4.18.0-425.19.2.el8_7.x86_64 #1
> >         ...
> > RIP: 0010:power_saving_thread+0x313/0x411 [acpi_pad]
> > Code: 89 cd 48 89 d3 eb d1 48 c7 c7 55 70 72 c0 e8 64 86 b0 e4 c6 05
> > 0d a1 02 00 01 e9 bc fd ff ff 45 89 e4 42 8b 04 a5 20 82 72 c0 <f0> 48
> > 0f b3 05 f4 9c 01 00 42 c7 04 a5 20 82 72 c0 ff ff ff ff 31
> > RSP: 0018:ff72a5d51fa77ec8 EFLAGS: 00010202
> > RAX: 00000000ffffffff RBX: ff462981e5d8cb80 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
> > RBP: ff46297556959d80 R08: 0000000000000382 R09: ff46297c8d0f38d8
> > R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000000e
> > R13: 0000000000000000 R14: ffffffffffffffff R15: 000000000000000e
> > FS:  0000000000000000(0000) GS:ff46297a800c0000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffffffe0740618 CR3: 0000007e20410004 CR4: 0000000000771ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  ? acpi_pad_add+0x120/0x120 [acpi_pad]
> >  kthread+0x10b/0x130
> >  ? set_kthread_struct+0x50/0x50
> >  ret_from_fork+0x1f/0x40
> >         ...
> > CR2: ffffffffe0740618
> >
> > crash> dis -lr ffffffffc0726923
> >         ...
> >
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x=
86_
> 64/./include/linux/cpumask.h: 114
> > 0xffffffffc0726918 <power_saving_thread+776>:
> 	mov    %r12d,%r12d
> >
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x=
86_
> 64/./include/linux/cpumask.h: 325
> > 0xffffffffc072691b <power_saving_thread+779>:	mov
> -0x3f8d7de0(,%r12,4),%eax
> >
> /usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x=
86_
> 64/./arch/x86/include/asm/bitops.h: 80
> > 0xffffffffc0726923 <power_saving_thread+787>:	lock
> btr %rax,0x19cf4(%rip)        # 0xffffffffc0740620 <pad_busy_cpus_bits>
> >
> > crash> px tsk_in_cpu[14]
> > $66 =3D 0xffffffff
> >
> > crash> px 0xffffffffc072692c+0x19cf4
> > $99 =3D 0xffffffffc0740620
> >
> > crash> sym 0xffffffffc0740620
> > ffffffffc0740620 (b) pad_busy_cpus_bits [acpi_pad]
> >
> > crash> px pad_busy_cpus_bits[0]
> > $42 =3D 0xfffc0
> > ----------
> >
> > To fix this, ensure that tsk_in_cpu[tsk_index] !=3D -1 before calling
> > cpumask_clear_cpu() in exit_round_robin(), just as it is done in
> > round_robin_cpu().
> >
> > Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
> > Link:
> > https://patch.msgid.link/20240825141352.25280-1-snishika@redhat.com
> > [ rjw: Subject edit, avoid updates to the same value ]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49935
>=20
> Why did you add a nist.gov link here?

I have added a link tag to add backport CVE infomation.

>=20
> NIST is know to "enhance" cve.org reports in ways that are flat out wrong=
.
> Never trust them, only rely on the original cve.org report please, as tha=
t is under
> our control.
>=20
> Also NIST totally ignores numerous parts of the cve.org report that we pr=
ovide,
> making this type of link contain less information overall than the origin=
al report.
>=20
> And finally, no need to add links like this to backports.  If we were to =
do that
> everywhere, it would be a total mess given our rate of 13 CVEs a day we a=
re
> currently running at.

Thanks for the explanation. I understand it.
I will resend the patch with the link tag removed. I will also not to add u=
nnecessary tags
form next patch.

>=20
> thanks,
>=20
> greg k-h

Best regards,
  Nobuhiro


