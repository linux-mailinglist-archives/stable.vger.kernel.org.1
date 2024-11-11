Return-Path: <stable+bounces-92073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49ED9C3959
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 09:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E87ED1C21758
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6691552E4;
	Mon, 11 Nov 2024 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="cG/ebFfl"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECA14C5AE;
	Mon, 11 Nov 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731312132; cv=fail; b=McJXm9m+biotWB/jrpdt+Cr+0wNV5rS+z8b/LaBUIFBuUqoFl9KmFIkI5rMQHbC2K4HmCSUYLc1K+eLghrEoTSo7FainNjVPkuO05xnPwXj/8b7rmH92k1KupYpPm/YrPxdfl+ItJpgIZXvowNgGizqzOQxj8Dv97TWwIzDoloI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731312132; c=relaxed/simple;
	bh=kaIrbNcOHFdy9H7WBbfB3nVBx6CDRzA804gdYFwyy4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WhyKO3m/vVB+VCI5Y+VLAZRvEKMSfiVbG3cSUvyckokddmmls6rj57YJ87BOc6iumeQ8880LnZXIUmvGC9ZAheAMCiSPMseLZMO/86JTlx6TsYE8bj3TEpWgh2f/RzeJrfUXJ5JvG+YIzywHftpxQpzgnh5beRfgJnoPd/XmSrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=cG/ebFfl; arc=fail smtp.client-ip=40.107.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fp0qcrt5jBEqjA+Oqda8IaUaPg0Gl4o/lUyfAYnJ3DyjRtDZgrrxQ0uXCp7fjv9jKixuF3jpoFYU5d1cugd+YPIFqFL+Wi84c7rnil1E4jhgar75soiRLJ4cpN4/q0EAjxl3K5GYr7kNIillQKI9LG2KOtBY5aMbaJW2zRoRocxq3I2yTuGBn/pvIA1k55C/8BtbLmXx6j+JU0kGJ/05Gt9rsKlxnOIzPFkV8LS2FyqqhCvGGbCUtBsml9N+sQCaoaMFNfXLN65ASYQ1RIUUVczgP7bCpdNxjQ/Jti5HVFV7+f6MkRUTgf0LspanCGztzmH2ID/IjG/zOumHNo1Smg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaIrbNcOHFdy9H7WBbfB3nVBx6CDRzA804gdYFwyy4k=;
 b=ACy0XOvf0pQcr90+M1CUXgD60fIYBizmbsl/KpCjQBKqaNTfRmAJewqa5f/apmQQCI2xJHH6/klDNfA+JOyH4SiDwg/rkxo7xyQHqfkfUOXVmrMmB2iiyTYveP4qSYaduyC899hc2ZWZWiJHsvgsY/sG/E2hNGfVC02TW/Ku2XVlt4ib4uAkIBSex5ECbBZ11BlS0bwF+HuoVJdhzOFoFKZtMj6hvDRG4wv7+U3mokdYOZ1d/TvdNTXPZJnmMOtnemvfG3ir6VyzsRawQjU+lUR9Dz4ZGonvzZYBVGFSX8CzznlvD0i6kZUMGuzoFc1hjxhp37HaFvbE8yC9skqZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaIrbNcOHFdy9H7WBbfB3nVBx6CDRzA804gdYFwyy4k=;
 b=cG/ebFfl/1NaeYY1tjESnAVC4ws8pmD3lzmi+K7o5VTKlOHkg83MNBI6aMu2T4h8YBjYdOxQXO7uwqC9jNcMzgy3PcTT8xVGYQ4fV3+YzGPR/U7VvodDFx2SJnbhD/T9GUJ1pC0r5mnqVJVfYGeLUeDb8aKNkVOMe4c/g4VA0NSXSD3RlC67/p8HgjtYQxclte4INsGnShNQq2Z/UH1XJaHKt54lJqmNAvr2UVnuKT747QJJDZnsN9DrH+KAYiJsTBvKRYbBuRC8ven4GR2y8U2oaCe6UhRsgXRLyMs7tzUM2PWV/+MBq16oDkDhxGaMmVNuynGA14qflIqlpSTC0w==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by SEZPR06MB5738.apcprd06.prod.outlook.com
 (2603:1096:101:af::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Mon, 11 Nov
 2024 08:01:59 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%4]) with mapi id 15.20.8137.018; Mon, 11 Nov 2024
 08:01:59 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Angus Chen
	<angus.chen@jaguarmicro.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject:
 =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSCB2Ml0gVVNCOiBjb3JlOiByZW1vdmUg?=
 =?utf-8?B?ZGVhZCBjb2RlIGluIGRvX3Byb2NfYnVsaygp?=
Thread-Topic:
 =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjJdIFVTQjogY29yZTogcmVtb3ZlIGRlYWQgY29k?=
 =?utf-8?B?ZSBpbiBkb19wcm9jX2J1bGsoKQ==?=
Thread-Index: AQHbMkzVPsdcEHgF6kCJy18g0Sud77KuhSkAgABHMdCAAAlCAIAA7Y2A
Date: Mon, 11 Nov 2024 08:01:59 +0000
Message-ID:
 <KL1PR0601MB5773FD459FC71707E5FB0B7FE6582@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20241109021140.2174-1-rex.nie@jaguarmicro.com>
 <2024110947-umpire-unwell-ac00@gregkh>
 <KL1PR0601MB5773F9F97A6AFC7E5D987323E65E2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
 <2024110911-professor-obnoxious-f411@gregkh>
In-Reply-To: <2024110911-professor-obnoxious-f411@gregkh>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|SEZPR06MB5738:EE_
x-ms-office365-filtering-correlation-id: 1e503769-8144-4439-bf9b-08dd02271e51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3h0VU9OeTQ0emJtL3VRLzNYeFdCc2xKejVRMlBYdW9sSTZUT2Rob3RsUDJj?=
 =?utf-8?B?SGxQa0hnVTdZYThDR3JSTTUvMzZWQ2E4VXRqTDVveEVTUHFJb2lQSDJDQmFR?=
 =?utf-8?B?aHVQaG12R05ha2ZEUUJtT3M5TDN1S3UvdnI1K2tGOWJxYVliY1hPZ2ZadzVM?=
 =?utf-8?B?OWhLanVMU3pjYkZySlhqUlRLRjJtdzFLUlpodTJBQm56alVoWVlzM2NiSUp3?=
 =?utf-8?B?ZHg1S3hhRkZOT3Q1VzUrVC8xUFJLdEFqeFJReEEwd3BUSTVjcE9WRHA2ajVl?=
 =?utf-8?B?eDVzVU1VMTY5NHFOUThmMEd0bkNSYkIza0svVXhjdThkSHdRM2ZrQnE4U0NQ?=
 =?utf-8?B?OS9ESnp0SWo3Y3B0ekJkYW55T21rOENCakRLb3AwUVN1ZWh4d041aFI2Qm84?=
 =?utf-8?B?bXFQMXpVWmVqSzRiNG9zajMxYjRPdkxCOHNBVWlNclpEbUZ0QVlEcmhvYitt?=
 =?utf-8?B?UXFnazRvQ2Q4bDAyL3JwaHFQRTc4N3lsUks3aGRMWVJsKzgrcE1MbnpZUGxu?=
 =?utf-8?B?dmRVbTFHVUNmc0lsTk00dlNzWG5NV2dUbDhIc1g2MnJxYTJWdEVIQkVvTENE?=
 =?utf-8?B?YTBScFFzWEdPdk9abnFuSjhxRFJwUllFTkhxQlc2U0Q2cWR5K1BYVGdKMEJk?=
 =?utf-8?B?WmNjS0pRV1Iya2FyWjhFWG84T3JvaFoyUTYwNkk1WFFMdWw4VUN3cEwvcDhZ?=
 =?utf-8?B?dzBLcVNiYjlpV0dIdzFRVGd0TjNpMXpOYnkwZVNIRHRmKzBZVmczVXFPLzNB?=
 =?utf-8?B?NzNGMTVraDBEdVJaOUxQSXh3SFhPMGRxdTdxL2g2ZFBJWnM0V3VFMDVwandR?=
 =?utf-8?B?OU5zUUgvRzVGbWdldGtxeERNczJTN09IWU51eitkTkd5L0pQaDVGc0VwV0xp?=
 =?utf-8?B?YmFzaXZLdS9DeUl2ZTFVU2xoN0hIbkEyVVJJWDAxU2RXYVpqYzVCV2hFSk9B?=
 =?utf-8?B?VWxqSld1VnZtbmF6RzVnbldnNEZWd0lXZ3Z2TDkrOFo1a1FCZk8veE1FeWdx?=
 =?utf-8?B?ZTROTzgzU2t2Tm11VGJBY0ZwSFI0Tk1XUjVZa1NUNW54VmZ5TUdLWCtCNVhN?=
 =?utf-8?B?amx4R2RFT29nNWN4OVI1Z0RKbVNnSXhMblQ1WFpRTDVLcFBiME91OGhFeGNV?=
 =?utf-8?B?bVdhSXo1ZVNpSEdnTmVHYU9LSW56NUdRNmx0TE05R3p1K1FaZkxSRlBDV3VK?=
 =?utf-8?B?cUp0TEg5OUNRMkpGV293cHgrTHRlWFUvcDN6UEhMejFKVkVId2c5enllZjNQ?=
 =?utf-8?B?RzRyZ3ptNWF4SHlweDRVZUJqbWJDSC95VlR3S3luTG9QdVljci9CSXV4bVpt?=
 =?utf-8?B?NDAzZ0YyUGk2VExJWGltV09XUjBHZXhzV3FUU05UbDFYenpZaG90OUYvZGxK?=
 =?utf-8?B?U3Z3emhoR204RnRwQU5NeHN3cnJjaDVHWmoxemxKbTNvNDYrZmV3ZVhxUkky?=
 =?utf-8?B?ZXp0T3IzOFVsdVZqK2p4UnIyVm5nZmU4STVINFl2UVRVSjNOeFh6bndjOHRY?=
 =?utf-8?B?YkpvYmlXZnpFek5rZlNDVjZBSVJKemJEVHFDcXgvOUVYVnVIdkU4MTVlOGky?=
 =?utf-8?B?cXJzaXBld0Y2dVBjZ2pyRUZCazVVTFFkVHlrOXdlS1NINk8yZXlZZjN0RnBa?=
 =?utf-8?B?M0lHWlNHZ2NlMTQzbFhIbm9PVFhOS1BQVmZhUExrU0U0eUFpaDJoZ2JRY3ZF?=
 =?utf-8?B?T1EwYWYvb1BlWUIvbnYrbGFqQ01udVpQVEZNUm1oblhaSEpVMVpkUXVIV0xt?=
 =?utf-8?B?V3FRcW5DeExQVVFPREdEZEhLdThrSVZKMFRkSGQxSkVSbnNIb0ZSaDdSN045?=
 =?utf-8?Q?Bqm/YcV+mmtmbv+dvROiHagfwwL0zAhNjCzMQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmtIcUgwYjJzTERVZHo5WGtkWkFFV1pLN2dpMGtYQWcxbWdjamZheFVaY1Q5?=
 =?utf-8?B?OXhtSWY0ak52K0ZYenBtdEo4cUlLaEpFT28rVDVFYStSbldlVkxWM2lQTHF3?=
 =?utf-8?B?MjNmNzRuTis5MHJ4WWJadXVmbzV3VkdkbXlUK2lPV2d0VGk1K3V3ZCthUHJJ?=
 =?utf-8?B?UERCM2hUa1FVT0ZDbWltTEwvMHgxUmtMdXZSM3piWjA5YVNkOGlDUm1Hb2FR?=
 =?utf-8?B?cjM2TmFMd0Y2MWNHbzdlV0tod211NVM4SE14QklFOWptQmFWd29tUE1Xekls?=
 =?utf-8?B?OURvYUdGYldpelZJUitUcWVjcWhWODAyNGJDbGhwSVdJTll6MWl4NG9za2g4?=
 =?utf-8?B?RzFiS3NuWXd0MklTcTlLTTYzTE9CbHV0TEtWS2NLcXVvWmNUVGxrZmE1TFlH?=
 =?utf-8?B?L1V6bmNQRDdhV0JFOWZiektCa2QwSjQ0d1ZLOXVOQjUxSHR1RVZ5cGFNNE8v?=
 =?utf-8?B?LzdWZEt1VTBIUXVDTUFaam8vVzNzRjhMeFFVQnI5TkxSUW92eVlxRHhmaGI0?=
 =?utf-8?B?UVQwMnZSQ3BHY3EyRldhRDc1Y21IVjZFeTFrZGQ3QmM0UWpJOFh5SmZ6Tmtt?=
 =?utf-8?B?UDRvN1k5QTAydHFFOHcxTmJKZExDeUNFZnQzVlQvQUJZQWlmblp2T2hBRitS?=
 =?utf-8?B?OUs4Nkp6TmdZMjY0SG9qdlFnYW1IUjBndHI3cm1aVVQyQkFVMWxPNzVhVDQ5?=
 =?utf-8?B?MW5qckFZamo0aTBmQm14ekRlMmkyZ2RZUW4yd1NZc3JmZCtxZy9EU3I1cm5G?=
 =?utf-8?B?ZXNHVm01bktub0h6bEJwVTZxeEc5blFSRUVPUUlDYVNuQ2FvZjFQeTd3UC9G?=
 =?utf-8?B?WjAwcjBSNUxyeW5QaGRNWlB5T0crcHNkaGFqUjVZZmdhcmEwNFRkYlgxU2RN?=
 =?utf-8?B?U0FkSFVud0FzeVJtdWtLekdrRjNWaDJ1MWFaY0RFNmorU09ZMTAzLzQ0bUc0?=
 =?utf-8?B?ZHN6MVRQdFByWW9yUXRRN0RPSVdxSVRiNDZQa29lOGJkSDlDUGljc0oreGE1?=
 =?utf-8?B?M1VZSHZMaUMxUlBKSEVYNmJCdjFyTXZ1Z2xLU09vOFd0WHpRZXpkVXlEWG5N?=
 =?utf-8?B?OGNKdnlRUE9iTjFKaUg5b0VZeFZpUFdzdTM2cFF5Z1ZURzJJUHpyeGxybkFX?=
 =?utf-8?B?M1dGZm5vcng4RThHdTVzb1NkSXVoOERjOWxVN001NXNScGh5T25WMTRUa0lO?=
 =?utf-8?B?ZW4vSFRhNDBMays3c29TRkpSSU9lUVl6RzQzako0VVozNUFzUGY4Z0xiYldX?=
 =?utf-8?B?SjB2M1gxaTNKZGdKTnBtRnltdXJYRDlHemRTUjY2ZEU5Q0hCYWs3MVRmdzgv?=
 =?utf-8?B?ZUM5Z0NhaU9yUGdja0hGNG53cmdJTmxRRHBIUTAweGp4ZE85dUEycjZtSFhz?=
 =?utf-8?B?UGJtTHlPNGtEUkxzZWlsa2VuK013N3N4ME15QWJlaXhrRyt0Zmt5bXRwTjhw?=
 =?utf-8?B?T0JUTU1PbUMydkZJczF3bzFNN2RWaGprK0xiNnZURXM5Y256bUZDcUUrRlVu?=
 =?utf-8?B?aWhaY1JLZzI3OVpWOU5qcm56RGtkTVBhdGtXM3NsTEZLN2lHZUV6S1FNRCt4?=
 =?utf-8?B?WEkxbUJNd3RPVzVHNWV6d0ltaEZtUTE5ZnYrSkpmbllLek1aYXJISEhXWklV?=
 =?utf-8?B?dlhlOFB0YVNkNThxMXFCamJsWVFhWnlWQTQxWDZGR05uTVljM1lWZGdhMVJj?=
 =?utf-8?B?c1YyYWdZb25mYVFVVzVMck8yVXBhMmFVd0ZGazF6RFlqZDgxVGpuMG03OTQv?=
 =?utf-8?B?QmZyTlUxdWQxVnBERy9pcHRDUFp5ZXNwdHdjb2p1NmFHZ2tBRFVPWXo4bmRj?=
 =?utf-8?B?YzBBNEt3Z0pvbTEyL1FDd3RnbnNzU3Z4YnpmZFBjb3VnSzd6a21UUDlGMWJO?=
 =?utf-8?B?QVBGeEJjNGZteXdraVlYRjYyRjdRL1krQVZ6Z1JEdDJnZStUTFhUOElnTGV4?=
 =?utf-8?B?RUE2MkZwV1A5dVRZWVN1bjQ3eGFJUjd0ZzRiN3BWaEFPSWRGSWdJVTE2UzVS?=
 =?utf-8?B?UHptZ01BSVliajZGNEtsSDFRSmZseEgwdUhBNUo2VmdUby9wd2VLRmliREho?=
 =?utf-8?B?WTl3MTJDMXBMQkJkUHF2T0I1cUxtYy9MNzdjTnk2RTZnU3ZDOUxsTjhrWVVL?=
 =?utf-8?Q?vP1i45YKMxImOSMAbUBd/zuTX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e503769-8144-4439-bf9b-08dd02271e51
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:01:59.1722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inExh5rdYQSbSjZYqAvvT//El+tfGXc7GO7VhQ0FuuVYsqSjw+xBdNnafkE83vYI+zfu9D/VZFywXy5VjW7NLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5738

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEdyZWcgS0ggPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjTlubQxMeaciDnml6Ug
MTk6NDcNCj4g5pS25Lu25Lq6OiBSZXggTmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCj4g
5oqE6YCBOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBBbmd1cyBDaGVuDQo+IDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT47IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4g5Li76aKYOiBSZTog562U5aSNOiBbUEFUQ0ggdjJdIFVTQjog
Y29yZTogcmVtb3ZlIGRlYWQgY29kZSBpbiBkb19wcm9jX2J1bGsoKQ0KPiANCj4gRXh0ZXJuYWwg
TWFpbDogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gT1VUU0lERSBvZiB0aGUgb3JnYW5pemF0
aW9uIQ0KPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0YWNobWVudHMgb3IgcHJvdmlkZSBB
TlkgaW5mb3JtYXRpb24gdW5sZXNzIHlvdQ0KPiByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIFNhdCwgTm92IDA5LCAyMDI0IGF0
IDExOjM4OjQzQU0gKzAwMDAsIFJleCBOaWUgd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS3p
gq7ku7bljp/ku7YtLS0tLQ0KPiA+ID4g5Y+R5Lu25Lq6OiBHcmVnIEtIIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4NCj4gPiA+IOWPkemAgeaXtumXtDogMjAyNOW5tDEx5pyIOeaXpSAxNDo1
OQ0KPiA+ID4g5pS25Lu25Lq6OiBSZXggTmllIDxyZXgubmllQGphZ3Vhcm1pY3JvLmNvbT4NCj4g
PiA+IOaKhOmAgTogbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgQW5ndXMNCj4gPiA+IENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29t
Pjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4g5Li76aKYOiBSZTogW1BBVENIIHYyXSBV
U0I6IGNvcmU6IHJlbW92ZSBkZWFkIGNvZGUgaW4gZG9fcHJvY19idWxrKCkNCj4gPiA+DQo+ID4g
PiBFeHRlcm5hbCBNYWlsOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBPVVRTSURFIG9mIHRo
ZSBvcmdhbml6YXRpb24hDQo+ID4gPiBEbyBub3QgY2xpY2sgbGlua3MsIG9wZW4gYXR0YWNobWVu
dHMgb3IgcHJvdmlkZSBBTlkgaW5mb3JtYXRpb24NCj4gPiA+IHVubGVzcyB5b3UgcmVjb2duaXpl
IHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gPiA+DQo+ID4gPg0K
PiA+ID4gT24gU2F0LCBOb3YgMDksIDIwMjQgYXQgMTA6MTE6NDFBTSArMDgwMCwgUmV4IE5pZSB3
cm90ZToNCj4gPiA+ID4gU2luY2UgbGVuMSBpcyB1bnNpZ25lZCBpbnQsIGxlbjEgPCAwIGFsd2F5
cyBmYWxzZS4gUmVtb3ZlIGl0IGtlZXANCj4gPiA+ID4gY29kZSBzaW1wbGUuDQo+ID4gPiA+DQo+
ID4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gPiA+IEZpeGVzOiBhZTg3MDli
Mjk2ZDggKCJVU0I6IGNvcmU6IE1ha2UgZG9fcHJvY19jb250cm9sKCkgYW5kDQo+ID4gPiA+IGRv
X3Byb2NfYnVsaygpIGtpbGxhYmxlIikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmV4IE5pZSA8
cmV4Lm5pZUBqYWd1YXJtaWNyby5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBjaGFuZ2VzIGlu
IHYyOg0KPiA+ID4gPiAtIEFkZCAiQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmciIChrZXJuZWwg
dGVzdCByb2JvdCkNCj4gPiA+DQo+ID4gPiBXaHkgaXMgdGhpcyByZWxldmFudCBmb3IgdGhlIHN0
YWJsZSBrZXJuZWxzPyAgV2hhdCBidWcgaXMgYmVpbmcNCj4gPiA+IGZpeGVkIHRoYXQgdXNlcnMg
d291bGQgaGl0IHRoYXQgdGhpcyBpcyBuZWVkZWQgdG8gcmVzb2x2ZT8NCj4gPiBISSBHcmVnIGst
aCwgSSBnb3QgYSBlbWFpbCBmcm9tIGxrcEBpbnRlbC5jb20gbGV0IG1lIGFkZCBDYyB0YWcgeWVz
dGVyZGF5LA0KPiBzbyBJIGFwcGx5IHYyIHBhdGNoLg0KPiANCj4gVGhhdCB3YXMgYmVjYXVzZSB5
b3UgY2M6IHN0YWJsZSBhbmQgeWV0IGRpZCBub3QgdGFnIGl0IGFzIHN1Y2guICBUaGF0J3Mgbm90
DQo+IHBhc3NpbmcgYSBqdWRnZW1lbnQgY2FsbCBvbiBpZiBpdCBzaG91bGQgaGF2ZSBiZWVuIGRv
bmUgYXQgYWxsLCB3aGljaCBpcyB3aGF0IEkNCj4gYW0gYXNraW5nIGhlcmUuDQo+IA0KVGhhbmtz
IGZvciBkZXRhaWxlZCBleHBsYW5hdGlvbi4NCj4gPiBBbHRob3VnaCB0aGlzIHNob3VsZG4ndCBi
b3RoZXIgdXNlcnMsIHRoZSBleHByZXNzaW9uIGxlbjEgPCAwIGluIHRoZQ0KPiA+IGlmIGNvbmRp
dGlvbiBkb2Vzbid0IG1ha2Ugc2Vuc2UsIGFuZCByZW1vdmluZyBpdCBtYWtlcyB0aGUgY29kZSBt
b3JlDQo+ID4gc2ltcGxlIGFuZCBlZmZpY2llbnQuIFRoZSBvcmlnaW5hbCBlbWFpbCBmcm9tIGtl
cm5lbCByb2JvdCB0ZXN0IHNob3dzIGFzDQo+IGZvbGxvd3MuIEkgdGhpbmsgaXQgbm8gbmVlZCBh
IGNjIHRhZyBlaXRoZXIuDQo+IA0KPiBEb2VzIHRoaXMgZm9sbG93IHRoZSBwYXRjaGVzIGFzIHBl
ciB0aGUgZG9jdW1lbnRhdGlvbiBmb3Igd2hhdCBzaG91bGQgYmUNCj4gYWNjZXB0ZWQgZm9yIHN0
YWJsZSBrZXJuZWxzPw0KPg0KSSBjaGVjayBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3RhYmxlLWtl
cm5lbC1ydWxlcy5yc3QgYWdhaW4sIGl0IGRvbid0IGZvbGxvdyBydWxlcyBmb3Igc3RhYmxlIGtl
cm5lbHMuDQpJIHRoaW5rIHRoaXMgcGF0Y2ggY2FuIGJlIHBpY2tlZCB1cCBieSBtYWlubGluZSBr
ZXJuZWwgdHJlZS4NCkJScw0KVGhhbmtzDQpSZXgNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgN
Cg==

