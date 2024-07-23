Return-Path: <stable+bounces-60724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5C9398D2
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 06:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42F91C219F5
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 04:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B25713B5AF;
	Tue, 23 Jul 2024 04:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="guBSQXgc"
X-Original-To: stable@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2082.outbound.protection.outlook.com [40.107.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1815461FE1;
	Tue, 23 Jul 2024 04:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721708550; cv=fail; b=aGspHy/1Y0qPvg8CsgEyUlgxOM9Y83FKQTwE5HUkADDdBSgVV0ETI8roh8Zxe3I389IaPD+rUgR1DjPLE5GpivIRBve5WFhDh//QufvjaJUP3kaHztGJgqc8Bom3WzDq8t+9x/Qt7ASKE3PlJCFdu6gvTQtXFHT+3m3htA130MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721708550; c=relaxed/simple;
	bh=ezcaQjCdZtMk+0uGjRm6NdEdo1HHfTVGByWbhsUUwm4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rySAFt1jZos2UruaE08qdUUs7PmfJQ1UHG2NiVmc3Ak+S2H26OFtu8OT0iddY2LahrTDSIUz5MkO1OiT469XYK8Il2c8VNX0xZbiyeXimxgCWHJJK7td4IdDvoDySoPQ6NPcTgb/iUJ82YMtWJmh20S5h6/1+S9S9B/exdCPUQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=guBSQXgc; arc=fail smtp.client-ip=40.107.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMBaEloPuDRTNSxaKX1Jeg1MrtW0eUnkrdfPXm4IQTXO9VwcFRgow+MOuFOkAVoJ8MYx1y/BW4pcA8fdXpfO9znBpby/NNLfvprlOaeXRfA+q+AxBZNF/fh8O7/YsMf3djTT605xRuvtxSg2bJst85NiRHGzZtR/eawm6BUe3NaWdo54y9l9egqM5mBiIUw+EcilgVrd1ikfCsTAg1GyVHpOsCsWFwl6d732R/WzHTtpnC/SkTWL2mqLUPozMKqrFIAHo1rMOWW8WG9MywidSxua9m3BSqyhBPskEYgJCibutyinB00oXU2kr5UASBMsXlntaOW3U/ruptPz/Lx0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezcaQjCdZtMk+0uGjRm6NdEdo1HHfTVGByWbhsUUwm4=;
 b=tN2u+RftmFj1BBqWGuvV5aEka175uL1fCEgfEU+UNNO6jaOTAzYwk30Js9DkvFu3XJO4tQxm49lR7iuxvrHDCoVD4mwEWmL/gaWpJQ++3yHqWc7Xy8Yqtr8TsYxNrga7OhO+AgN+GHVB6Leo/LFiM6J2Edwk5tk5T7IvVSIqnnajh6Q0dpD+MOBOVxo8B2KNM/ztk8oYvuGOf4NQh4Wez7xsoapsRtInG+O46zlThaq/ymC7pJyaOx0RnfgEcqGVtJjzcOJTRDYIX7GVdrPLHXVBnIUiYoYoH8pPInMWEhSEZ8b+GaDpyH/+gAj3sZT2oTJEXCt49ejC+xk3mNhuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezcaQjCdZtMk+0uGjRm6NdEdo1HHfTVGByWbhsUUwm4=;
 b=guBSQXgc68bYofYkZItidIcVoVry7G6Yp5ns2WCLuv4gaMmHtTEHKiiTBlQlbH3TJhyKOhFdusV3Pi0HLyaU8zVxVRNIWpz/jYwxxMa6k6l4Sipl57y5Z5QncPPvTNYCAVKTkBhqaEfq2DX0+o/AcHKztGtOFXyLUfVgYDVvxuA0UpzV8LW6hV+bNCffhL0eDbtGTn4But3rabS6ZJYlk1UGq1yhXZuuStcVq98clyu0C4QY7ZlQyB3YeCBIUBYxMu50k6mkgP5BEpbtuubGScniiKpotU5wiXnMLos+3OZUg8EpSwcDTKEiyOJLAhXTngHKNtRAxQnFInq6bTLaEg==
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 04:22:24 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%5]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 04:22:24 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, "linux-erofs@lists.ozlabs.org"
	<linux-erofs@lists.ozlabs.org>
CC: LKML <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: fix race in z_erofs_get_gbuf()
Thread-Topic: [PATCH] erofs: fix race in z_erofs_get_gbuf()
Thread-Index: AQHa2+przXPWG30pUU6wq4Sxs1XSJrIDt/+A
Date: Tue, 23 Jul 2024 04:22:24 +0000
Message-ID: <be4787d1-f68d-4415-b079-c10d2700dc80@vivo.com>
References: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7096:EE_|TY0PR06MB5283:EE_
x-ms-office365-filtering-correlation-id: d17859b6-5a92-48da-1062-08dcaacf0dc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L29OdG5jbFdCTVJFQy81aFRlYmdTV2h1RVRCVkdOMEhBUm1lVzJjNnpKb0dF?=
 =?utf-8?B?WCt4OHd4ZWRoK0cvUmdrTEsxaXVZY0tqREVjQ2tjSkJlVjVJU21IRHhsZnE5?=
 =?utf-8?B?Nk5XY1REMFpkVnYvYnFEY29KQW5Zc3BGZzZLeDBKd2tnM1NYYmJlM0QxN05H?=
 =?utf-8?B?RE1Pcnl3YlVyL0tTczBtaDRzZzMvYUxTWW9XaDJsRkZkdzZOb1VEUEVEZU5p?=
 =?utf-8?B?NGozR0x1Z1Y0UjVaUDY0NExuVUtBaEgxalFUN1B1clQwVlUyTTgrQ3ZMcjF4?=
 =?utf-8?B?cTA0aHRlQm9qaHhYQU5aK2Q3c0k0K1JrV1JoQkVlZ2VRVi9TL2F1cXZRQWhT?=
 =?utf-8?B?b28vN1dhbVZyRENwNGhnVlFpMjZUd0s4LzhBOC9jTlVmcUoxYS9ZdmNBZDlD?=
 =?utf-8?B?V2htOG12L01FQ2FPcjRxQUsxS0s2N2ZZcmlLTlhiaGorMHBlMkYwUEI3Z3Nq?=
 =?utf-8?B?a2RkcTRuQTVzZ0Y4WkhwaUQxZ1RlVFZDbVVRdTZRQTRnTVBxNVlqR213amFm?=
 =?utf-8?B?YnJ5QnlwOHRCdGdSRGhuWjNHN2UwdTltVTF6a3FVQlZTTHBZQ2NJTWFUdkdy?=
 =?utf-8?B?dm5YZllyR0lvaW1BQlpRTm5xckN2bmZwMm1QWk9ndEdJOU5pbnRTbTh4OUEv?=
 =?utf-8?B?R1VJOWZxRW8raGtjWlJ0UjVTY3I1ejZmUE1IaUk3Q1JnSFl0ZUFkNi9tQVJ3?=
 =?utf-8?B?TUgxT2c3ZXF4Ti9FeUpobTh2cFV5djFvUWNyTnpoV3l5T01zOEpPZVFBdXBt?=
 =?utf-8?B?bk5jY2JCdHV2TlpGNVRoREx6Ty91KzZsY3F2L2wyQWY0MTV6ckpzYjdJNzFm?=
 =?utf-8?B?UHpQa1RiS0M5RFdWQmlVOEcycnQzSmZ1Y3lEK2I2UUxYQklTS2R1ZkZDUlUy?=
 =?utf-8?B?OXB3Y2FOUTVPN1JuRUFpN0VxeHVSNzRBZDJUK1dhemU1c1dQQnczNFRLdUo0?=
 =?utf-8?B?UTNYb1BtZzRaeHlOSVRISlFjMExldVJsSDJ5bEFEMW9VdjFJMVA4WmtYaTVX?=
 =?utf-8?B?MnhhdnYwNkpiL1p6WEhQb1FzYWZtcTdwUGtDTjUvWkEzSUpPU3ZhKys4eWRX?=
 =?utf-8?B?RitKRFhkMHpBMmVBa0RMbmZZOEFtV0dXYi9FUmRXV3crRFQzM3NPRFEvMWxi?=
 =?utf-8?B?SS9wMVY4RzRnRkJXeE9md2VIcjFveTZNSmVLUTNsRHJWT0lzU1VVODZaaFR6?=
 =?utf-8?B?MEh6UjJHNjlnbXh3dnllTkhEOEh2aWVuRVFQdVRpZWxpV0RnWHBwTEVwaXd2?=
 =?utf-8?B?Vm5GQy9INGhXNlFjdGdwVU1hL1hwS0tYNW43cXNsVGdGVUYxQmZ1TGpUZElM?=
 =?utf-8?B?cWx5cUFBLzYyUStEWVJFRzhuM3IzeEJTdFFsMmRaQlk3V3NEQVJDcldLQU43?=
 =?utf-8?B?UTByVENxT1VJeFBQU01VZnRQUnBhUW1hRVZXVitpeTQ0eElQRVRHMHJzM0kv?=
 =?utf-8?B?QXlIOTVFcG9MRkFXVzFpcnRQV1BKb0NRUm5GWm9jbGtRUTNOWnhwQnd3cncy?=
 =?utf-8?B?d1RjeVJpRkFCR2ZsWlNrd2hvRkhvOXpMejNKRFZ3ODJtK1pJZVR5bjhoS3dV?=
 =?utf-8?B?bk96QTV6NE4rL0g5N2F6NFR5TEh1WHhMejVzVWNJUEk3alljL2xVU2wyblJZ?=
 =?utf-8?B?TVR0RVJuQXBaK1pwZGgwczdocDNRS3lqZGJwU3Yxc1h2ay96V0Rjb2FZYVJm?=
 =?utf-8?B?MG5MWDFBWDR4WDBDc3lFR1gxKzc2c1ZScUhzRWREM1FVMVhtK2o3bFpZeXZj?=
 =?utf-8?B?QVpiOVJtU0Z5MWRUSWZydDA3cStaVFB2a01ueE1wYXFmSDJLZzIzaENpSm1q?=
 =?utf-8?B?bjA3MjEyRVF2Rm8relVQNWlIVTZGYSt2bTZ5bXNucGNYZndBOForWVlmWG5C?=
 =?utf-8?B?VTNWcTFRSzN1Wm85ZHdua05kYkYxdTBiSy83Y0VQcGRnSWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0lvVDdSdXJKTDJXUGdENko5K25LaDZtZjJmQncreVRYZllUaVlEZ09ZVlNU?=
 =?utf-8?B?T21hVmtseWcvZXdodlA5czM4RW1aZUxOSnpqRnZaQ2dIZDQzMS9sbXQvdHFZ?=
 =?utf-8?B?SHJGVU5YSHhZaDVOZnFlSC9iY2NyK3NrVnF3VlNLSXAzTVl4TWw3U3ltMjBT?=
 =?utf-8?B?MjdJMzMyOFNPNFJLNGl5SzFHclRtNXg5djZiaXBRY3dpaDk3QjFLSDVpZnh3?=
 =?utf-8?B?akswQ3BJWjNNalRSaTZ4V0Vnai93MWUxMEZkYTlkMXorWVRyTXV5bUc4ME16?=
 =?utf-8?B?RFIrYTZaTVBPUFNGMlJQbmpVVTBjeFBCR1JXVm5iYjFDSzlIZWJQVGprdjJG?=
 =?utf-8?B?ZStWNjFhVkJJK2ltdktzNzhEdVpJenB1MlhBY3hIQ0c5aFloZXNrSDcrQnJm?=
 =?utf-8?B?NElXYW5hOWJzZkJRMWhUU3JlM3J3RzVLS2V0TmZ4c01XV2hxM01VOHA5MnVV?=
 =?utf-8?B?czh1N0NIZ2JPdVVNZGpQa0w2R2FKbjJNUkdNVkJEbCt1Y2RscDdqcjRaWFlB?=
 =?utf-8?B?R20wTXhCWXRnS2k4NkRpM2ZQN2hHL1JIekNpVnFCWVlObU9iNGEwZjhRbFFU?=
 =?utf-8?B?YTFRWlZCVzJENlJlaDZaVVExcndXK2N4Z2I4NlBWZG8za1FsZXdvcGNGdnVa?=
 =?utf-8?B?NXBGVTFQSEYwcFptYnhuK0FDTk9QQ3pnK01CZVRnUzBQOVBYcDBRdTFrdEZB?=
 =?utf-8?B?amZUaDJidDhYNHE5MzhmeGJSS0JYUk9xbng0NjVhTnpHM2E0WGZGU25reXV0?=
 =?utf-8?B?NWkvOHZ4ZnRXblFsVStzaHZTZ0JpZDZxQ21teXE3elNxM25LNkpoQm5TaTJ0?=
 =?utf-8?B?bFJjRXlJdEN4LzZsMkxqcUh1aDhMaERnMnQxWnpXLzJtdGxLNG95WHA1RDNv?=
 =?utf-8?B?QVZpT1lFTU1VTllrSXRWQmFjcFl5WmFqRk9veHdoQmloNlJoeGpDMjhMNFpI?=
 =?utf-8?B?YTFNYVM4cUhweDBYWDFrLzRGa2hobjNiT2xrNmd6UU85QjJIVldXK0h0WDNS?=
 =?utf-8?B?YWRGNi82eFJJQmZDOWxRa3R1NjBLNXhjdHZMVms3ZHArRllPS1RETUxXUVBQ?=
 =?utf-8?B?a3VQK3dlbDIwb3lpQXlaSFdiR1Bod2ZtK0RRWXUzVUFLNnpjRWpTeDh1SzNy?=
 =?utf-8?B?QjNSUGl2R3VFQWpQMjlFeXRLUmFIRGl4d2tWNk1RbUtCeStlTmhGWlNxSUF6?=
 =?utf-8?B?OUhlOXRuVk5KSloyMWRUVDFmU2VMZnlpUlZQVE1Mb2twaVQvNHVFUGY4ak83?=
 =?utf-8?B?MTBJcmJlQVd3LzQ4Z3FFUTlkSU5PSkQ3bzhNd0o2cm5xeGVmNlhuakpVUFBK?=
 =?utf-8?B?UzJzQlU2QVFEZXJUK0gxNC9adEkrOU5Hd2U5eDJjS1l0OFNERWd6eW4wcVJP?=
 =?utf-8?B?ZnB6aFhvMHlLVll0ZUF1S0FPdnNDTWhSQlgvWHJmZnhuRnNpa053Z1VhZ2ZE?=
 =?utf-8?B?MnNudm93K0hYdnducDBlaXZpTWIwTXNRWXFsbkkwencvcGFHZlZINkZReEY0?=
 =?utf-8?B?S3Vad1pPMUNuUDMrbjJBMHUyVXRaRjd6cnc1Nlh0MEZleXJIekJpSDRtMllH?=
 =?utf-8?B?bU03TThYRVkxK1BGRTRZVVgwdzBkM0pqZW1kbi9Jd2lCVno4dGFPZjZhcUdY?=
 =?utf-8?B?M2RsNXcveFlUakl4cWNVQ3lCWEp5SFFDc2JYTUVxaGRkWnpzTGQ4cUQ1bjZX?=
 =?utf-8?B?SDgvUUcwWXpqMkwyYWJzWm5oZm8wSFd1UFhNSkJDU3pSdS9uWVcwTkRvS1c2?=
 =?utf-8?B?N1I1N3g0Y08vSnJmdkpYM3BLU1RIN1BJd2RsMjB6ZFhtRWlEcnJSVFlxdFVq?=
 =?utf-8?B?dnFrU1pZdTFTVW1yMzFSMXFhRUNZN2dXNHdnR3oxaFdEZldhSEZtS2ZDRUdw?=
 =?utf-8?B?SU9wUnhnNDdEbS9tUGNCbXovNlVqK0d2NDB6ZGhTYU5iZFV3YnlFWGJ6emlI?=
 =?utf-8?B?QzZKenAvdlprOVk3SXRaT3A3RVoyM3FPeUViRUpHS3JwVDRjb0gzUXBDN2dO?=
 =?utf-8?B?RDAyalkzMUJDc005RWpoQ1Y2VWIwSm40emxnaDhrcnNZTkdZcUtONWJrd3Jl?=
 =?utf-8?B?Z1BrS0F0cHVzYUVZdzJyNUpyZkR0dDlFUGJmamU2N2tzUndGTmtlNXJxL3o1?=
 =?utf-8?Q?LsoQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4290B188C86C74B98A8D394974A0F3B@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17859b6-5a92-48da-1062-08dcaacf0dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 04:22:24.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9FM2UtOck0KhHLXiu3/CsQZXSLfesfqcnhnPhDaRJr2MBPegRNcN42D5fqA7MfpseAB35O3CwtAiXJoBXz2Wfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5283

5ZyoIDIwMjQvNy8yMiAxMTo1MSwgR2FvIFhpYW5nIOWGmemBkzoNCj4gSW4gel9lcm9mc19nZXRf
Z2J1ZigpLCB0aGUgY3VycmVudCB0YXNrIG1heSBiZSBtaWdyYXRlZCB0byBhbm90aGVyDQo+IENQ
VSBiZXR3ZWVuIGB6X2Vyb2ZzX2didWZfaWQoKWAgYW5kIGBzcGluX2xvY2soJmdidWYtPmxvY2sp
YC4NCj4NCj4gVGhlcmVmb3JlLCB6X2Vyb2ZzX3B1dF9nYnVmKCkgd2lsbCB0cmlnZ2VyIHRoZSBm
b2xsb3dpbmcgaXNzdWUNCj4gd2hpY2ggd2FzIGZvdW5kIGJ5IHN0cmVzcyB0ZXN0Og0KPg0KPiA8
Mj5bNzcyMTU2LjQzNDE2OF0ga2VybmVsIEJVRyBhdCBmcy9lcm9mcy96dXRpbC5jOjU4IQ0KPiAu
Lg0KPiA8ND5bNzcyMTU2LjQzNTAwN10NCj4gPDQ+Wzc3MjE1Ni40MzkyMzddIENQVTogMCBQSUQ6
IDMwNzggQ29tbTogc3RyZXNzIEtkdW1wOiBsb2FkZWQgVGFpbnRlZDogRyAgICAgICAgICAgIEUg
ICAgICA2LjEwLjAtcmM3KyAjMg0KPiA8ND5bNzcyMTU2LjQzOTIzOV0gSGFyZHdhcmUgbmFtZTog
QWxpYmFiYSBDbG91ZCBBbGliYWJhIENsb3VkIEVDUywgQklPUyAxLjAuMCAwMS8wMS8yMDE3DQo+
IDw0Pls3NzIxNTYuNDM5MjQxXSBwc3RhdGU6IDgzNDAwMDA1IChOemN2IGRhaWYgK1BBTiAtVUFP
ICtUQ08gK0RJVCAtU1NCUyBCVFlQRT0tLSkNCj4gPDQ+Wzc3MjE1Ni40MzkyNDNdIHBjIDogel9l
cm9mc19wdXRfZ2J1ZisweDY0LzB4NzAgW2Vyb2ZzXQ0KPiA8ND5bNzcyMTU2LjQzOTI1Ml0gbHIg
OiB6X2Vyb2ZzX2x6NF9kZWNvbXByZXNzKzB4NjAwLzB4NmEwIFtlcm9mc10NCj4gLi4NCj4gPDY+
Wzc3MjE1Ni40NDU5NThdIHN0cmVzcyAoMzEyNyk6IGRyb3BfY2FjaGVzOiAxDQo+IDw0Pls3NzIx
NTYuNDQ2MTIwXSBDYWxsIHRyYWNlOg0KPiA8ND5bNzcyMTU2LjQ0NjEyMV0gIHpfZXJvZnNfcHV0
X2didWYrMHg2NC8weDcwIFtlcm9mc10NCj4gPDQ+Wzc3MjE1Ni40NDY3NjFdICB6X2Vyb2ZzX2x6
NF9kZWNvbXByZXNzKzB4NjAwLzB4NmEwIFtlcm9mc10NCj4gPDQ+Wzc3MjE1Ni40NDY4OTddICB6
X2Vyb2ZzX2RlY29tcHJlc3NfcXVldWUrMHg3NDAvMHhhMTAgW2Vyb2ZzXQ0KPiA8ND5bNzcyMTU2
LjQ0NzAzNl0gIHpfZXJvZnNfcnVucXVldWUrMHg0MjgvMHg4YzAgW2Vyb2ZzXQ0KPiA8ND5bNzcy
MTU2LjQ0NzE2MF0gIHpfZXJvZnNfcmVhZGFoZWFkKzB4MjI0LzB4MzkwIFtlcm9mc10NCj4gLi4N
Cj4NCj4gRml4ZXM6IGYzNmYzMDEwZjY3NiAoImVyb2ZzOiByZW5hbWUgcGVyLUNQVSBidWZmZXJz
IHRvIGdsb2JhbCBidWZmZXIgcG9vbCBhbmQgbWFrZSBpdCBjb25maWd1cmFibGUiKQ0KPiBDYzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ICMgNi4xMCsNCj4gQ2M6IENodW5oYWkgR3VvIDxndW9j
aHVuaGFpQHZpdm8uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBHYW8gWGlhbmcgPGhzaWFuZ2thb0Bs
aW51eC5hbGliYWJhLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENodW5oYWkgR3VvIDxndW9jaHVuaGFp
QHZpdm8uY29tPg0KDQoNClRoYW5rcywNCg0KQ2h1bmhhaSBHdW8NCg0K

