Return-Path: <stable+bounces-135055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A41A9604B
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2BE3A2395
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF85230D08;
	Tue, 22 Apr 2025 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b="IrS0m6/E"
X-Original-To: stable@vger.kernel.org
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022143.outbound.protection.outlook.com [40.107.168.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209FE230BEC;
	Tue, 22 Apr 2025 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308660; cv=fail; b=hhYa6ylDKz9UrQ2JgwikDI+cI5ZsG4BqDx7XGKZhMmWIT96zZGT8az8VDlKXYyKZ+FKeeEBwGqNH9SpMp9c2F3soSRjVGg2iZKuQOC0+b9HnngA9CDkhdX45j10tqBiBoYS2142OlllhZ+gZ8/+CoKI53cZdKkGHpJOFULVzD1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308660; c=relaxed/simple;
	bh=kVlCn+W2j6DZZ8clIkOjrRj1kKZ6Gwd6CslNTiVEH+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pW/AYWL/TiE1BboH/25/UxvdwDTiHWOnoRCOSYGQ/u0ugTQe4qQezIOP+md0wpwyJZ+DvfYU+nQwRCORP2oKYU21bUTUWBEzgVG+A83y4AfckC+ivs9/yWOLGzNz+bb6bWS4CVJ7GaiepOx0SCr2mPv/6GIzoBoKQLsxodtzUH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch; spf=pass smtp.mailfrom=impulsing.ch; dkim=pass (2048-bit key) header.d=impulsing.ch header.i=@impulsing.ch header.b=IrS0m6/E; arc=fail smtp.client-ip=40.107.168.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=impulsing.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=impulsing.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOpCGlu3aWzTLfcVeW3d2Hnno5OFVxANqoYcBnl8Ui0Wl0eNh+OMnEWLA4RBaYUrxCwoIXPRmx5iqEdl7obVolxXNQaDu+NRRM7IiaD7AXnqlPjl4BPq9yugN2zVTxgtoUjFUO8veiybp1oz5kfZqyyqeyoQYBMKrh268HqDvoOLTE4Una3wSnjHIk/KCqHUZuJ2aHRwJXn92i5QI+j8q3f8ZKRWhYcW/No3TSrtOEqXeZId03QWKwtOmiZNy6ByyrUYj59vY7d4/WAmjrDd3gO3FZXGikCgvZhGt+2C+5IaKuqWmXBAmvmDDdhYwkAqrPS2WdKSkw1TOJJCvgQUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVlCn+W2j6DZZ8clIkOjrRj1kKZ6Gwd6CslNTiVEH+I=;
 b=C38NfaTYAW4rji+k55vSoLMR4z7XsP4Azv04wwUCKiImWGWmi0/WR7j1tJK6nsxko8PJJutRr7DNEwhMl4JJeD/nGjyCE2ThDyP/ruKqTAsDRmenOTIY8xu53f56+V9t7nXKmOd3NUrJEKWmpYExInWxyql71ZQ3KcJ6J9l1jst1Q8LhXMGsgU5O4Q597+QfHOj+FPeaGSBbWvQoITVbZX/Ia9/3eSQZ1p5lWg0Yxp3/+3t2rbxtcZjmytZ3pFHGkKKIDT+lczpcyQcDRWqbPWsdt8opWv9pl9sTRvfUvTM297BpB4BKLDJEW7e10o72a3AuGT0m2ksvD7tc/sPI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=impulsing.ch; dmarc=pass action=none header.from=impulsing.ch;
 dkim=pass header.d=impulsing.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impulsing.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVlCn+W2j6DZZ8clIkOjrRj1kKZ6Gwd6CslNTiVEH+I=;
 b=IrS0m6/EDZ+12TUzQGT/Gp6lzmlRFyJWp9XAIj8xld2bOmFTs0aWBzywaKySKzsCvKxeQqKGMR19MmFkmBT0cQpNVxFyZYUgHPNfzUhdNiU8vQ+YsQmls8ICP/0FnNoszGE9ZoH8U2OBqdlDNGEUPZzZvJTJ4aAFK2rueAEq0d1c3/4Iqh1hcBPU5zZlh1sdYzNx+j1z7+duDwOI0x33pnm9xP+XX4uGIIXEmL10U1HFIabIXRZmbYjGUHK9cZ1mev3ro93APFDF+Tkq0PsFLMnBU0XsDZYUtiIUj4ZFEdh/mh3JeCBWU5MJ7iHPIKy0lIG/Zo9ELXbbG8RXeonc5g==
Received: from ZR0P278MB1349.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:82::5) by
 ZRAP278MB0111.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:11::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.22; Tue, 22 Apr 2025 07:57:32 +0000
Received: from ZR0P278MB1349.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88bd:d9b1:9ef:4507]) by ZR0P278MB1349.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88bd:d9b1:9ef:4507%5]) with mapi id 15.20.8678.020; Tue, 22 Apr 2025
 07:57:32 +0000
From: Philippe Schenker <philippe.schenker@impulsing.ch>
To: Francesco Dolcini <francesco@dolcini.it>, Wojciech Dubowik
	<Wojciech.Dubowik@mt.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm-verdin: Link reg_nvcc_sd to usdhc2
Thread-Topic: [PATCH] arm64: dts: imx8mm-verdin: Link reg_nvcc_sd to usdhc2
Thread-Index: AQHbr4rJglPuIdtT1kad8qqeZ9uUnbOn0zQAgAeGHQA=
Date: Tue, 22 Apr 2025 07:57:32 +0000
Message-ID: <95107ed358b735cbe9e5a1af20a2d6db74c5ed64.camel@impulsing.ch>
References: <20250417112012.785420-1-Wojciech.Dubowik@mt.com>
	 <20250417130342.GA18817@francesco-nb>
In-Reply-To: <20250417130342.GA18817@francesco-nb>
Accept-Language: de-CH, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=impulsing.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB1349:EE_|ZRAP278MB0111:EE_
x-ms-office365-filtering-correlation-id: 7f7790f5-659f-488d-774b-08dd81735627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WFo1SHJhQTI3L1ZiYWdTZjhVdFd3UU55NWxCL2lrTE9lRmEvV1hBSENYNUNm?=
 =?utf-8?B?TThrZHFtZS83R1V6U1dQTzRpWG55SktiY2dhRFpEMEFSV085UVAwYmEwbDhs?=
 =?utf-8?B?TDNvQ0R3UDBrRXNKdTcxdEozUnpMV0FJOUZ5N2ZkTWgvSHpqS2l6L1dsZXNB?=
 =?utf-8?B?R1dZL1E3cGR0UWFXQm41dDloN0lCS0tpOGVxalNwKzNRY1Flbmcxc0pwN05B?=
 =?utf-8?B?NWJ1NXVocThhak5tZFRKaThpU0dQOERYdHdWYkNjYnhFT2ltbDJJNnNGRHRV?=
 =?utf-8?B?czJNckIxTXg3RWx0VVd0NHQwb1VsU3RXcGg4K1NMcE0zVDdlS3N1L3ZxWWVT?=
 =?utf-8?B?aFZmUEh4Y2gyVjYrdERqdlhROUc5Rytpc0kzME1Gem9tUzg2bHptVnpoRG0z?=
 =?utf-8?B?RUUybE5kRFdpbzI1KzI1NDY3ZUtMVXUrby9JOFY3S3k5N1Bib0creTBWYlEx?=
 =?utf-8?B?Z0pmOUxnSUpURjZTVlhRb2pya0dpNlJuejByWktFWFI1MWxxOFVrSFNDZ3VF?=
 =?utf-8?B?ciswSEdjYkJPdHNKNkRoaXR2U3NVcmdRdTJyeWNjQ3BFOVd4R3lWcktmRW5w?=
 =?utf-8?B?dG5VR2JrVkpCVithNFFiVS9yOHpqZ3FuQ2R0RzdzTnhMVkNYVCtrNXBRSzli?=
 =?utf-8?B?STUvRnRlc2V4VnpZUFV5K2tobDVmVW02NkY1SGQwTTNvRW41aHprelhDa0NV?=
 =?utf-8?B?citkcFNBVUZ6YllqTkdhcXM1UWJqM0RpZTg4M1NrMlNnRFpjQWYxU3ZweSsz?=
 =?utf-8?B?clFqOUg1SVVvdVkzNEhiZE9hT21YZE1SVmhDOWl1RGdXNXpSZDBVcG8vQ0FX?=
 =?utf-8?B?RjNYZnN1eDJBZ1g0WTZKa245b25MbXpSdlFTUGNOSkNUVjZhTUJUS1lZQUJH?=
 =?utf-8?B?Y3RLanB5S0VVdFFINXBjNzVHZTJsbTV6bUtVYmxEYkZtazhJYVRmbDJERVhE?=
 =?utf-8?B?bHBNUm9aRVIvcVZ0QnRKeDZld2NHM3lwd3R0Ynp0REJLWGg4UXVkL3NoZUx4?=
 =?utf-8?B?YTF5S0k1UlFYSFNnTWhjRWorQUdFbXFDUjZhekd5b1lQMVB2VmNUdnhJdXVO?=
 =?utf-8?B?bEF6SzFYWTl5emh6NHA4UUJjaTRDaU9CQ1VMSkpzSTJwOVE3VGdnMFpMUld0?=
 =?utf-8?B?Q0NUTElWbmxTK290R0w0UXdJR0t3eHFSV25nNWp4dVNwTmozT2YzdndpUHVv?=
 =?utf-8?B?ZEVVYkpkenNaMGtySVp5Q1BPZHI3eWlad3g0eG4xeWJ4a0t0Q1BhTE5YNk1K?=
 =?utf-8?B?ZkRnd296ZDF3T2F2TitkakVyK01tWFo0elR6RURaL3daNHVGUi9jZXhpRmls?=
 =?utf-8?B?SGx6T3M1WlV6Wnpxc0VZL2RmOFlhbGF5cEdZRzJOaDRNMExXOHorWmp3U3ZS?=
 =?utf-8?B?ZmdoOFl6aFJUYmdLS0tnNEhNanZ3REdiVSt6MG0wSG0yNjBKcjlwOXQrU2V4?=
 =?utf-8?B?RVUrZlRqMkhYQW1NMDRpUnFqa3Q4MmoxeTZTbVk0QVJjU0IxY2gzS3h5amI2?=
 =?utf-8?B?bTZSMlNyQk4xdWx6cVJ1T0dlVkZDUFNDcHlPSS9sa1JNNktsTFUzeUtxNmNL?=
 =?utf-8?B?SG0xcUxaNklzZ01KQndWcENsaVFmV2ZpbnM5UWN4aWNkWEE4NkFrTEJiUDlz?=
 =?utf-8?B?S21FUDFFQ2R0OEtzNnZWb1RiNDFCczJNQ2k3OWpRbUIzb2dXdExUMkNLMjVY?=
 =?utf-8?B?WmhkVVlSMG5hYlJyTGRuRHp0M3BSQTZKbWhSSm0rVk9PUi9jR0VnTHlLMEo5?=
 =?utf-8?B?MDYwa2w4QXVxbVIxaUhWRVRzcVo3akxYc2wzZ3NDYm05RXRVOXphNkp6SUNT?=
 =?utf-8?B?RTVPNnZHYVJWcG1sZzlNQVU2OGNtZnBIM2N1NGxucC94UnA2YlROYXhud2pZ?=
 =?utf-8?B?bm56Y3dZbUFnaWt6REkyZUxJUmhmMVFZdDRSbTBHdXk4YmN1YVh3aEpjdjlS?=
 =?utf-8?Q?zZstAqFfCJY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB1349.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(4053099003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dVR4RXp1OXVCdjFtSEhhaG9XaU9TYzZwUGZVWG1NbnJwV1RGUWJWOGRMVkNl?=
 =?utf-8?B?OHBnYnJUelhhWk5PSlpnQ3ZVUFhQc3praTFKYWhzQ0VWaUxiUVI0TnZkMXQ4?=
 =?utf-8?B?WmY2OE5relNlK3FGZEZNQTUxdzRwVjNFVnRzVWhWOVFleitpdnVjYzJISUc5?=
 =?utf-8?B?RGwweC81d3lCbCs3b21CN1lvcjlmTmEvOCs4ZjVHVGJreEpRTzZZZE9Rbzdh?=
 =?utf-8?B?cWVzVWVVREdkNjNwT01veUNZMSt5aHZOeGpheW1adjVEdU5GOHZUWFhkeEtn?=
 =?utf-8?B?NTJIdEJmckk0VlUzN09jRE9BWm9FZ3hrYXFtcVI5M3M1ajZMMGtVUjd2b1Fl?=
 =?utf-8?B?alZMUzFoZm0rVXNYQi9xdVlCL21Yd2dzL1pwOXg1TVFqQW5jaHdESTUxVTdk?=
 =?utf-8?B?UzNwTmlDT3FVYXlVdDhnaDg2VUNRMm0wRTJ4VWNLTUljbTNTWWVyZFFrUisy?=
 =?utf-8?B?aHRXODQ5aUtXN3pyL0Y2UU1aMms1M3pURVJxZDgwVlgyTHVuSXNsb1U0ZnhI?=
 =?utf-8?B?elg3VnRyU3IvZDBLSHFUYW00MmZlMmFFYVp1NThseng1Yzh5S09YeUxXbFpz?=
 =?utf-8?B?WUg4elNZTjZSTW91MGlWVmJvWUIvNzZtMXk3dXZoQkhyNHc4M2JWaUNTSEFs?=
 =?utf-8?B?WG8vb2xPd3ZUY1FDOENoZFpXUjZjNVVSZmNxNGpIRDVRdWNlOGJtZjAxaDM4?=
 =?utf-8?B?VHlWMEVYMnl2bUFwN2VEKzY3T3FJMFYrVUp3TlNOTXhRYUxqWWwvSnRKVTkw?=
 =?utf-8?B?YnFWMnF6a0labjNoSjdKQlJkaFlLZjR4VEN2NS82THJscUJkdTh2dDNBL1V3?=
 =?utf-8?B?YlB1N3dNVlRJaHdDZFkxVlNKZ3dsbEZCd2xIMC81RUhYZkxoRDRIRjRhSUdv?=
 =?utf-8?B?ZHlXQlpoMHVONWUrMGYzZ21DblROYjdTdTRLWUpqNHVkMk85NUhFVENxcVBm?=
 =?utf-8?B?eFdNMnJlcUg4cjYrMWtzMjRTRVIrWFAwQTE0Q0c0RGN2TmEzNm1MZU5SWVJq?=
 =?utf-8?B?eG4xMUtFeXE4T0RaU1dTbldmY0taRTFzZldwZDNSdldMZGdFa1M5L3lmM3l4?=
 =?utf-8?B?YWJDUHQ2QXM5bkNLeFd6WDdqOThqZVNLSE81bGdsSlprZk14eFFnanZUM29S?=
 =?utf-8?B?cXFJVXFmRitXNlRzZ3M3NDd1dWtnT0NzMmY1NzArTkFiTmVmVEpWMjVUeFJN?=
 =?utf-8?B?RjVJbnFaazZnK0U2Tk53eHRmRGk0QUEyRHpxV2hNY29FODUvR245VXVDQnRX?=
 =?utf-8?B?RmE0bzdERVh3QjI3NVltSml6NmVaRXV1UlIzSERlK1AxdUY0SHJCUzVYSmhJ?=
 =?utf-8?B?VSt1Y01ZNCt4TTFxdlpxMnp0YThyRitTaXhjWE1VcHM3dUpZQ01EQ2FMNUFI?=
 =?utf-8?B?THRERk14Y3dyY3luQkcxY0Z0bXlzN290dmYrbU5Uak4wK0t0bkdyTFVJcXZ4?=
 =?utf-8?B?WC9hSGNUZVhNVmxQRk5WRnIxSHVjMWh1N25kNlBaWnRjRW1OeTdCZW1TbEFa?=
 =?utf-8?B?OU05R1Bwa21zdVFHOVRHZGVVR0QzZjhZaEIyRUZrRTZscjBxUUUwbHFHN3JX?=
 =?utf-8?B?SUpwZEhQZE9JbWZsaDN1aEt2dndaeXVYWXZ1ZjlmUDlpZWcwNEo0aktJLzF5?=
 =?utf-8?B?MDluNEJZSnhWaXlIbk1QOGtHYmFlQ1pOK09iMDRiVFcxM3FIYStTVnEveXp0?=
 =?utf-8?B?MWNXRmJ1S05XcEh3c1NpYjRkRk9uQ3E0ZEp0M1IzaWhRK1RsT01hUWRJSGlT?=
 =?utf-8?B?TzZraHF3RG9NeFI2aDNwNFA2NkZLYklkTGlseVMxN21SeVVydUl2bWZnNGFV?=
 =?utf-8?B?ZXZIQ1VJOGtLSlpGU1NGSHRYNmMzTFJwSUJ4R0l2Z2RmREd2VU16aHpTMFRa?=
 =?utf-8?B?NzRzblA3Tm4xQTVQVUtDK2tIUnJEd2NQRWFNNUlralE0WjdRVVBma2ZxdFBX?=
 =?utf-8?B?ZW1EUzg0bE1aM2hOWHUxVndoSmNVZ3hESlJVMmNNRHFHbVJ6QnhNNW54ZFhl?=
 =?utf-8?B?OWVmZEoxdVUremdwVm5HU09YQjBaSDVuOTBmbTRiTGF0MmtOSTlzY1k2WGNm?=
 =?utf-8?B?cGpCbmkvQkdTdjR3MCtJbnpIY0djVlUvdkRuekxYOVA5dlZ1Q1pIM3Z4TU9T?=
 =?utf-8?B?ZXpkOFd2QjZQM0xBS05aOGVVRWR4ZitaZHMwQmU0dkJtREZybkVvTUhGWkJY?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="=-bv0dprSH/GrawrKRQEFJ"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: impulsing.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB1349.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7790f5-659f-488d-774b-08dd81735627
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 07:57:32.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86709429-7470-4d0c-bd3c-b912eebdee40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbxMbk1A0oqnglVLsaWQjIB9bN09ykHwYtLhJHOPmzwZRjFHSvwwykZUJ7oroKl8qIDlAq02zZqhYfqN0duEmPBWrRipXSRxLG+T/mkYcJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0111

--=-bv0dprSH/GrawrKRQEFJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

Just for your awareness, I stumbled on this patch this morning and I
actually did the exact same thing on verdin-imx8mp a while ago:
c8d29601fea3080a42731e8535b929a93afa107e

Not sure this causes any side-effects maybe you guys want to
investigate further about this. I needed it due to the strange
requirements I had (described in commit message).
=46rom my point of view it is correct to link the vqmmc-supply so the
voltage can be set also to something different than the default fusing
values.

Philippe

On Thu, 2025-04-17 at 15:03 +0200, Francesco Dolcini wrote:
> Hello Wojciech,
> thanks very much for your patch.
>=20
> On Thu, Apr 17, 2025 at 01:20:11PM +0200, Wojciech Dubowik wrote:
> > Link LDO5 labeled reg_nvcc_sd from PMIC to align with
> > hardware configuration specified in the datasheet.
> >=20
> > Without this definition LDO5 will be powered down, disabling
> > SD card after bootup. This has been introduced in commit
> > f5aab0438ef1 (regulator: pca9450: Fix enable register for LDO5).
> >=20
> > Fixes: f5aab0438ef1 (regulator: pca9450: Fix enable register for
> > LDO5)
> > Cc: stable@vger.kernel.org
> >=20
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > ---
> > =C2=A0arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > index 7251ad3a0017..6307c5caf3bc 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
> > @@ -785,6 +785,7 @@ &usdhc2 {
> > =C2=A0 pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> > =C2=A0 pinctrl-3 =3D <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_cd_sleep=
>;
> > =C2=A0 vmmc-supply =3D <&reg_usdhc2_vmmc>;
> > + vqmmc-supply =3D <&reg_nvcc_sd>;
>=20
> I am worried just doing this will have some side effects.
>=20
> Before this patch, the switch between 1v8 and 3v3 was done because we
> have a GPIO, connected to the PMIC, controlled by the USDHC2 instance
> (MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT, see pinctrl_usdhc2).
>=20
> With your change both the PMIC will be programmed with a different
> voltage over i2c and the GPIO will also toggle. It does not sound
> like
> what we want to do.
>=20
> Maybe we should have a "regulator-gpio" with vin-supply =3D
> <&reg_nvcc_sd>, as we recently did here
> https://lore.kernel.org/all/20250414123827.428339-1-
> ivitro@gmail.com/T/#m2964f1126a6732a66a6e704812f2b786e8237354
> ?
>=20
> Francesco
>=20

--=-bv0dprSH/GrawrKRQEFJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----=0A=
=0A=
iQHTBAABCAA9FiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmgHS+wfHHBoaWxpcHBl=0A=
LnNjaGVua2VyQGltcHVsc2luZy5jaAAKCRCNEONHaGhfGiXSC/93jb8UBpkmksar=0A=
iC7kDaw/+2Knlo4DgmYwYcDOSbJq7a0hlUTpBdXdwVOIhH1ogWD/mwYTXNtcm9/L=0A=
DutWr5V7ZRZ4fwGAaj4yuaIfLSlwl9/tteH3eLRTPa0jRUBGEr+Uv3tD2e5WgsGH=0A=
w2an4BdzOVWWthaaxq2pXzGT57Hx9zv3kJTlLDB8AotnSMiC0slBSOjvzsyqkl3K=0A=
2EZgBgBe1z2jEdIYDWvQyjGwm7fv4ngNHLUZjw91c1HPorJQClJ59ymtoyVsUTIH=0A=
nnIGGJ+gMVVoUvPHkiEOaUpH096MwPPDHePcbS2TeTgIhxnvDvXKVSiWZbA9j9cB=0A=
iz86RZUESkbs94XKtTCSFX4bogd/nGhWBPS+J1ECty6V2evViFPNCcx2v/qdR/AE=0A=
/ueV/PvTaIULO99nhJOvonyPKgdOCwpaj6MXAL5QkQXS4xDfoqSyvPd9EgU4Bz5L=0A=
UH5sSjOs9yWMBj5Gzp6Z2kYMTfm8V55qIZMpzrkftxiZNLxoHGA=3D=0A=
=3DKwvA=0A=
-----END PGP SIGNATURE-----=0A=

--=-bv0dprSH/GrawrKRQEFJ--

