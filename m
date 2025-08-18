Return-Path: <stable+bounces-169950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58536B29E52
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB047164F85
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 09:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60942226CE5;
	Mon, 18 Aug 2025 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="AINvGyYQ"
X-Original-To: stable@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023138.outbound.protection.outlook.com [52.101.127.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2B2036FA
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510400; cv=fail; b=Y/V9y/1sTV+GXEvjgt94Ba1HYLn8z9ElN4EoivunMbxie+8PaKgQtXn6INcox9B7rLetOacn3VI1UfKKAEoikuB7J9GZi0BKQ0LeAVYbFx43zKaty04bxSHeHnP3IPISyV5ug+yui7nMiHnUzCH8J+y/FJRzxYiBLJ1W1aQJw70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510400; c=relaxed/simple;
	bh=i9rOzNMFApc/h/KQjg2nlgCij/LA/WAplLjbaVXRLoA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pL5/z1OmMnwF7JH+N65heH5kf19aWxIKq/flfIYkOq38tj6zxICM7uwIJZ20CXRoWtEewLkm9ZPTWU2zFaItXn+xXixw14lvzS2LVPg9ouolL+0Tc9qlg4y9XreFztgTpzvbzUNkwn9GAhrd2WPiA6YSKJL6m693z6d1y51jCUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=AINvGyYQ; arc=fail smtp.client-ip=52.101.127.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFSSnLIs3vYQwtPnQuSspStMGv+8CEtBGkdvl2E/B6RpvlhOpEOGjTWB/pKTcQZnISw9M9PU8VHSCijazYN+zl0c5CuYHcI+RGTW/MaJ+EbuPP0nvzDpv+inb1moIJ8AttHV3f0RNG8lUd3wTCq19oUBuHqzcKPZHhAzWryTqmoeKg399Ru71i00WfneJLS9B7S6HGq9QIcMUJbLMbSigFLadEqxl3zoPMNmJvgTUM4XqjFrBt92pnilNbIQlcMqFrAYp618Qm1IwYUW8vNJ7B4fhCyCf1yqyIsKeMLH0G1faGtGWLErADFdGAxbaMvwUQH8vPrf4TTApqw9PNhpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9rOzNMFApc/h/KQjg2nlgCij/LA/WAplLjbaVXRLoA=;
 b=y2SyGlJnE5heHLv+ITvAgJ3r1X0pWgtLrCIrGpjRNJZRwtscNQJc1qNceUBMbTCs16Z6xOM1WZVR0s2tKxsJtnZIfD6PR8TZRJT5gzeTYuczSEdBg1+GOfyaun1im12K4p5Qt03pIivTLgO7sGs2C5FjUR+IBCeROq/LaqSjRh23go6nQigS0KctgUqjcqxga4ypZUHtRvHTkfrcTTAnk4iQrzeGL1qyIeqmZeH13toPwS4nQpDeN6RCw3fJ3HUNaHFtefCwOoIqZX0mvl6AbwKt5h6bJvvh2xo9OIWZZ4VnZyV/BIu9FciMtA6Qf9infvGLR4+vIeSOUr4z5Hifxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9rOzNMFApc/h/KQjg2nlgCij/LA/WAplLjbaVXRLoA=;
 b=AINvGyYQmbn5RY853PIbaunOJpJDU9S+YCFQGg3AT01Bzn/XY6pGWuqwFLqCjaPAHJat78nPFmn6f4GSfSQPqWrM1BoTThQxbZ8+09q2FOXkixPPdK8eicwXsNG9UmdZpymjCYjMFP+ewBL4ZCjYIuVMly1TUPaO3DD2zkuQFTwMRZI7o5cMCD2kqKpBr8XjAJ1YnoG5aYMGv9PS0jxReocmUbeJ5IjmhAHtKVstaBY42gd+nK2An0UVz1V/fR6T8y/Ze67XDfQBNh4vGAWuDATrSjCwzOZIZ+TkWoZZx9d6ji3e9KqSUiNeEH9ze3hhEihiG0qMkbjbmJaRs33DrQ==
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by JH0PR03MB7448.apcprd03.prod.outlook.com (2603:1096:990:13::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 09:46:32 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::1939:7c2b:9e87:2c38]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::1939:7c2b:9e87:2c38%7]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 09:46:32 +0000
From: Jiucheng Xu <Jiucheng.Xu@amlogic.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Tuan Zhang <Tuan.Zhang@amlogic.com>, Jianxin Pan <Jianxin.Pan@amlogic.com>
Subject: f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
Thread-Topic: f2fs: fix to avoid UAF in f2fs_sync_inode_meta()
Thread-Index: AQHcECT6iL5seh2Ae0S+DNPwM5v09w==
Date: Mon, 18 Aug 2025 09:46:32 +0000
Message-ID: <ae6791c0-8bd0-4388-bb65-53c421b35380@amlogic.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYUPR03MB7232:EE_|JH0PR03MB7448:EE_
x-ms-office365-filtering-correlation-id: 0dc783d1-df94-4f3b-c82f-08ddde3c1d15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFNvczAyZnB6UTBTdEh1c0ZjS0pReUNpY2xKQUJmOWdZZmRMTlQvQ3dzNUxt?=
 =?utf-8?B?Sk1YZTJMTlg0V3Flbmpkci83aHZBKzZnLytnSXRUV0ZiSkpETHVhYjhSMUhY?=
 =?utf-8?B?Z2k3UG8xZ0FRdThtaDJLWEZoZFNVcDBGY3hEUTNEb3dIL3ZGbXJQSDQ4ZjVk?=
 =?utf-8?B?STR3bUJLVGgxVTI2WEJPeTVzMW01NUhwNzZEOE1kWGZTeXhGbkJEMStWSW1y?=
 =?utf-8?B?MUFQU1E4dFBRVmpHdzVOYjFrZmdOTlF4RklzRmFvbGZkV1dLV0NzRldxSTg5?=
 =?utf-8?B?Y3FSMXphZmM2MjdPS0dUMG81Wm1JZDB5ZjRiODVlOVN6V0kyNnlrMWxzd1NQ?=
 =?utf-8?B?WDl5NlNUeWZRcmZLa1BiL25QRlRmSHZvNWdSeVNwLzMrMnNERWYrZHEyM3ZF?=
 =?utf-8?B?bVlCWEVUQ1ZhdnNDUnA5MGZXajZHdnI2NFB5SEdUTTIwU0svS1BMQTlOdU5T?=
 =?utf-8?B?cGZsUEdvcVBTdEFHTEpNRkh5QnB6c0dMdXlWNzVtQzBBaHdoVDNQLzV4RGdK?=
 =?utf-8?B?a0puUkE3UEhxWHBQMmlKNXY5TUpMb3A5Y3l5WGtSNW1lT2hnbmVhTUNwSDJp?=
 =?utf-8?B?NzdPNzErZnQ4d21rWXFkOGVJbUppUWRiWER2Y1lhdUc0blE3Ylp4UWtmZXhM?=
 =?utf-8?B?NWN6WUQybjhkclh5Y3VjUWJlazBmL0JGZldDaHBxekhOYW9mRDVnZ1JVUWhS?=
 =?utf-8?B?T1BBSTVqNDFYTGs5dnJpd1had2Y1TGl3WXVFRWlxLzVFM2ZFdlI2TmFwYWFm?=
 =?utf-8?B?eWhZU2wyaXk2TC9pTWhJbTJ6UTQ1WE5YTTNwRWhqUENpQ0ptYTNLWngrbUdx?=
 =?utf-8?B?TzB3OFpwNWw4d0hhVzE0bGJiWkxpZ3lPYldPWWFwdjdGV2tKdnR4V2YyU3lw?=
 =?utf-8?B?Yk5wM3l0N3l6c3FTZmhSdndNNWl3cGRRQzFNSEpjczBxTkZSeG5oeForNUpt?=
 =?utf-8?B?dVdvVUpKemVXL2RlM0dnTlBudWpIc2xZelpIN2FBanhVNXRrWThrVjlzNml4?=
 =?utf-8?B?SFhQYzlWRFNVWmdCeWgyNjdxdWxYNGxvU2pidUVXRlRoTW5QaHlPalRZQ3Ba?=
 =?utf-8?B?QVJCUVI2UjJJbDVRdDVDOThPUU1lbDl1elRPbEwyU05STGJTcStoUGJpbnhF?=
 =?utf-8?B?KzhyNjhWZTdUTGJmMFVpUnR2TDFJV0ozNHU5dzJSWjdVMjJyM0RRTk8zOXJp?=
 =?utf-8?B?SFgvV25jQzI2VjVjNjhWUFJ1aWNBMmNEakpGeXY5d2dKR0J1dFV4Q1piRVMz?=
 =?utf-8?B?Qnh4R09ERStCL21WcXpOYlZNVXgwNjZKR0tHNDNqaDgva0dpK21Xbk9QZjJB?=
 =?utf-8?B?MERPbkdIVGRyOGlBdTBUUmFKaEVqT3JmaElEZlloZGJyaWVyWUFyeWZyRjNw?=
 =?utf-8?B?NXBIM3hRR0x2Ylc0Wjg2OFB1NjJiV1VmaytsVlFEN0FTanBYdmozbis3Z0pZ?=
 =?utf-8?B?Mmk1QWxSb21BWkFwYlM5QXR2SjJyTjFwZG1zWnZ5MnU5cVBmNmd0WkpucVZj?=
 =?utf-8?B?TVoxMEpqMytPc0FEbmhweEJXNStHaHJxV01xVW1YNHJGT0RvdmxFdUdhMldC?=
 =?utf-8?B?c05CRDJORUhSVnIrZFpVU3dhY1l5ajZGajNGNlUvc05iSWg2TWRKY2p2K1VB?=
 =?utf-8?B?dWxiYnAyeUR0RTBsSUhwVkpLMjJ6K1MremMrczBRT0dKQnhJSlZIblhZQkEv?=
 =?utf-8?B?Yys5V0lHRXovNkIzakZQV3FaNEJPN1FHWHJ5WVN3RXZMSm1xRVRRUnVDZnBK?=
 =?utf-8?B?b1JYSGZpSzErNERDZDNLa3dPQTdZUzErQTBQNVg5NHdObzNtenFSSE1wT1E3?=
 =?utf-8?B?WVUxRW9IYmFUWHBwWjArVlY4RkE4ZThEZ3FzZUdwN1ZoaUxkbVY1S2lEb0Jh?=
 =?utf-8?B?ZWlWTVJyb0xseEZzeEJ1MGZzMjJqc1VscUNGdW4wR29jaUFMZGl5dHR0cERQ?=
 =?utf-8?B?eXcvVDFzNlV1UFFLSGNCa1QrQXJzYmkrNmpqWXR0aXgwZ0Z4cVVDU0QrdDVW?=
 =?utf-8?Q?od04xGXIgd+v95eQyfdJ/vmZfqkMhM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2x6OXhhSVdkQndkZC9OV3ZZamZvTWx0RWdpRkNRVDMyaFVSZXdzci9SY2ln?=
 =?utf-8?B?c2xGUGlUTFBoSkJRQXhFdjlmeFl4cUg0dXpsRmRZMUQwSUNHWjZ0VWVwZ0tH?=
 =?utf-8?B?aFNsaENvcDRZaitSZUpwYnlnVkF3WEJaK0NCYy9GSEFwZzg5Y3pkQXdVNXlN?=
 =?utf-8?B?dEJpWXZ2akovZ1RKdEFvQ2VzYkdCU25XWHZsaGZqWjh2VS93aTU2ZU1Bek0w?=
 =?utf-8?B?M0FYcTdDd0NTeUI4UGVmamNRVXovUVMrTzAxR2V0ODNkbDFHcVR2U3M3RGp1?=
 =?utf-8?B?YjRRTzBZTWQramxpV05FcmR0RXVuaG1mMzFEZ3AwL2x5S3FOZmQzVFUxdlZG?=
 =?utf-8?B?ZjBEZXRTaCtUcHZ4WjQwS0g0Nmg2RCs0VlFUQzJPWStvVWdiUFAzVE94Z0dQ?=
 =?utf-8?B?Qm04Z0hVVjFQWUtBL29rcGl0ZTVRNUs4dHV2WmdRMWlPNERyc2FHY2R6QzQ1?=
 =?utf-8?B?d0d2MU5UckMvVjJPSW5xQzlHeENHallyRGRJUmZiYk9BTHpETDVxczUxeTlC?=
 =?utf-8?B?cXNLekpHVGR5T29zYmZGVVcwTlc5YTJDaVFwdktwVlM1TDh5SW01cFl5TGhH?=
 =?utf-8?B?bFZXa0RScVd4Y21XNFlOZHVtSFFlMU5idHpHbjJ4NTZqVFdpNEQ4cGxVYTVW?=
 =?utf-8?B?UTFCbE9ybG9UZlQ2YWlydWx2ME5oNVVDQ2EzbzJLS3A1RjY0ampyM1EzL1Iw?=
 =?utf-8?B?T0tDMlVrcUVhWFpHcFVWTnVKZDFrbE1ycFAzVDVtZ2p4K24yQzZIbXBLTEE4?=
 =?utf-8?B?QUNxRk8xNUZQb29OY1I0UXFXVU5mRU9oaWZrdHJhbERzbTdKUGFBTlcxakRr?=
 =?utf-8?B?S3Y0Mk13a1JDcnM4Q1lOc0FKVHhXRGovY1pjZ0s4aVFzOXJ0R01XV3NnRzlz?=
 =?utf-8?B?Q3BTWmpXSkdCdnp2N0FxeEVpZ29aT3dNOTYyQ2RlMktYczQzVWVVOEdFYTZm?=
 =?utf-8?B?UFdIQUlUd1BQYzk2K2JiTkdEeU5jS3ZUTGt2QnVCMDNaeVNMOXE2NW5FREtS?=
 =?utf-8?B?emp6dlBsVjhEZlA3aGNJNjhzU1hWVU91ZUVQTFNuMzhOZ2dYNktoRTdKU2xa?=
 =?utf-8?B?Z1Z5TCtsdm5CYW40NXNmTWpFVWt3RlZ0ZG9VbVg3eG5heUJlRk5DZjUzQ0Fl?=
 =?utf-8?B?MVlCRkt4Z1JnV3huR2xVa25PU3RLTXVtc2g2TitRYUpHSnVRcFE2dHhUS1FF?=
 =?utf-8?B?QysySVU1bUZsSDZXWDdKVTMvVE82S1ltenJodTZEc3FoVjlYVnhKcEsxUnZu?=
 =?utf-8?B?eklvT0prTUdlSisvWTFnOUxoYmkzTmR3eERLVWtRMlNiYVlaYi9MNm1rMnc5?=
 =?utf-8?B?Qi9wR1ptWno0dkhMSlFKRmh6SkpZM2JNZnhRZ0YyeGtrUzRsbitnZklGNnZQ?=
 =?utf-8?B?YXh5OEZkaWdhMWd1UFlxVVAyUHI3aWVSVkhDSkNBL0FDOTk3NUt4NDVkeUhH?=
 =?utf-8?B?dkIrZEpIVXVtbk11a1BBSHhuWFNpamFuTVMzTE9JUVk4KzY3USs4OFpYSy90?=
 =?utf-8?B?N1hEd0p5ekdBZDVxRkVMZnNjU0oxMW4yL29xNFlDb2pscjlMcjFDU1JXaDZ1?=
 =?utf-8?B?UUVOa09QaU43bFRTMVlaalRxZG1rR3ZTcE1hZzg1R2Z6Um5vRUdYR0ZsWjdO?=
 =?utf-8?B?TlJkVXF3aFJWenQ0T3NZUnd3VkV2RjdnVUNLM3Y1UUR5VkgrazFYWk9rOFJx?=
 =?utf-8?B?UTJ2WVl5K3AvVSt3Rjc4aHhzZmViUVk3R0cvWVFOaDZpT0RLa0w0aDN1T1Rr?=
 =?utf-8?B?YzZFRWFiQUFTUVl0L0s4ZGtJMkNqTmd2ZXVvNDh6WjRNM0kvYVQrb3A4d3FS?=
 =?utf-8?B?NSsyc0FqZ0cwRjNqcnNuUU1SajZhVWxEVVRQNVdsaklHbkhLVk95bytJWGRa?=
 =?utf-8?B?amNSTVJmL0JVVlR5ZnNWL0lHWFY0TGhWUU10QlRCclM1RllQeUxnSUtrY2VH?=
 =?utf-8?B?QWRxVTFaUXlMbTBYQnZZdEdLZ0pjMlhoa2FQKzFxOWN0R0hNTVBTS1MvZFhB?=
 =?utf-8?B?bzh6ako2WWxxVkVvazZ5OEJVenJMMjdRdWlZK1BoSTFkOU9EUjF3eWVJRUZ1?=
 =?utf-8?B?MVZlUnJDQU1kRHN4bi9TZVUxVkpnQVlZaWpNcUdOTGhTYko3blo1dXVoeGRK?=
 =?utf-8?B?NHFreGxNWWhLYjhiZkdabWtEeXIwMU9mSXJBNk9VVkorQWxVRVRXS0JZMXJh?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <813FC56D036127409CFF9E0BBEB31F21@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc783d1-df94-4f3b-c82f-08ddde3c1d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 09:46:32.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgufRIMphFCqEfdcfF8j3BwVFxkqC7hhYkoZdQ1Lg6YzPxk8yADus0vY3wPOypl+Q0AgH9hsCO0gLzx5RVBM1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7448

RGVhciA1LjE1LnkgbWFpbnRhaW5lcnMsDQoNCkEgZjJmcyBwYXRjaCBzaG91bGQgYmUgYmFja3Bv
cnRlZCBmcm9tIHVwc3RyZWFtIG1haW5saW5lIHRvIHRoZSBzdGFibGUgDQo1LjE1LnkgYnJhbmNo
LiBUaGUgcGF0Y2gncyBpbmZvcm1hdGlvbiBpcyBzaG93biBhcyBiZWxvdzoNCg0KW1N1YmplY3Rd
DQpmMmZzOiBmaXggdG8gYXZvaWQgVUFGIGluIGYyZnNfc3luY19pbm9kZV9tZXRhKCkNCg0KW1Vw
c3RyZWFtIGNvbW1pdCBJRF0NCjdjMzBkNzk5MzAxMzI0NjZmNWJlN2QwYjU3YWRkMTRkMWEwMTZi
ZGENCg0KW0tlcm5lbCB2ZXJzaW9uXQ0KNS4xNS55DQoNCltXaHldDQpUaGlzIHBhdGNoIGZpeGVz
IHRoZSBpc3N1ZSB3aGVyZSB0aGUgZjJmc19pbm9kZV9pbmZvLmdkaXJ0eV9saXN0IGlzIG5vdCAN
CmRlbGV0ZWQgd2hlbiBldmljdGluZyB0aGUgaW5vZGUuIFRoaXMgd291bGQgY2F1c2UgdGhlIGdk
aXJ0eV9saXN0IHRvIA0KcmVtYWluIGluY29ycmVjdGx5IGxpbmtlZCB3aGVuIHRoZSBmMmZzX2lu
b2RlX2luZm8gaXMgcmVhbGxvY2F0ZWQsIHdoaWNoIA0KaW4gdHVybiB3b3VsZCBiZSBkZXRlY3Rl
ZCBieSBfX2xpc3RfZGVsX2VudHJ5X3ZhbGlkIGR1cmluZyBsaXN0X2RlbF9pbml0Lg0KDQpPbiB0
aGUgQW5kcm9pZCA1LjE1IFUgYXJtIHBsYXRmb3JtLCB0aGUgaXNzdWUgdGhhdCBjb3VsZCBiZSBy
ZXByb2R1Y2VkIA0Kd2l0aGluIDI0IGhvdXJzIGhhcyBub3QgcmVjdXJyZWQgZm9yIGEgd2VlayBh
ZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQpKaXVjaGVuZw0K

