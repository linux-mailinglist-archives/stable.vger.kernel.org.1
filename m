Return-Path: <stable+bounces-91984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EFD9C2C38
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F41B21DED
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8515B0F1;
	Sat,  9 Nov 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="VQhOLOUI"
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2134.outbound.protection.outlook.com [40.107.117.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6D233D95;
	Sat,  9 Nov 2024 11:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731152333; cv=fail; b=eHZPWvYPosL+Lm1b0GFYXIsbarrlE12lhNOTJ3Oh5/gVrL+4YXp9eVxi6YavzidLqyjOBOw5omcPXGIxFzPw0f9FMvF0hVHDpeZEuoBZvlR8To1LVNrkuptZK/b6UH3Eobt7eH8Ok+yoKSpnrCOTbaI4vDSMYSYsI08EPuQUsXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731152333; c=relaxed/simple;
	bh=BgVndYVS8O4LzlhGILNVJaE3TH1F+I+LbNQKzXiw2PI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQUvxc0UGYje82P+VD8UVZ22yqSSNnaWHEp2YAN7Rh70vdZcAIbgLrbAEWOQt4lWT5aDYXNoya4G7lGe4kbytBbFKETlZh8tTZwcX65ELXq9kwjDaVodL+lD5H4xFkjx36cyvTQFBFfu5z06OJOaUHRtOVvwc7DHGxzvM8+ojdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=VQhOLOUI; arc=fail smtp.client-ip=40.107.117.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R49gI5FLOWb8McU31TuDm0SuhclKlYop59YD+SHBKwtdtoqH4mFhr9qjL77SfycKt2HPEKpKtDHZ3ySrt1QwiiKZbevQfIzWMHqgpRIgGa0oBcjA24/YoH9wSxNFrf45oAMyWkaXEei33pOoJZi82IfkA/kJIRIdy7OizxXy/b5BPtSJopl7TxXBZgCTAuaeK8KD1USfMur2sZzWdOAalg1ZxQCnwqPQRLdJlr+eMWLGe1tID4eJ1B0SVUVJpQ6E9AI7fiSn3LS0uM0PJViiCYVAJCtTxUJ0ZAZHHMY2CoQwviSZnMNxviFs4ri0YAFU+/63NTBykwDjOcqq8uKdrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgVndYVS8O4LzlhGILNVJaE3TH1F+I+LbNQKzXiw2PI=;
 b=Gp7aGoVXxEFx94gLbmqA4g68x2QidMsq7wZ5RbqwVLu3lyK2FryjsI4vpTGGN33eWIv1dTnN4bmAKAahvm5GY+vHT4zEwTWjTHxHgZ6X6LZC+P4pwkEvS3KR947s38XkFSQvmDYn5lR3CKSM3K5x07CqWxyj/159u8rrTHTGx0Sc+2DRzZTn3nN6PVdLu7+/ff9EaP95wKKjUUXSnimasl0Gl0zsNXP+4iwM8lRhzX2Wx8LG7YcslGyJiLkWkEjdnpRVbDZzEIFYWZjpNkKHJkPYp6NrWy9PIwo79MGHCFXXn3GzNvWI28/rtr4O0tG9hLDOjWFeWPTKmeapWcEvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgVndYVS8O4LzlhGILNVJaE3TH1F+I+LbNQKzXiw2PI=;
 b=VQhOLOUIvfz7FOYKCsARzE4K0a3A4OnNFpUFKexuwmwpdZmPe0KnmuYOHkv4EaX+HssitoD150FPvxB2tFOccM5/ULGeo86RxAqwV9cbd1c+3PHVf2q2XiJym04vDXNPU+mU6/5K0O4jbOgmvTwTkR8Rl1N6T5ZunCR8xYTmCwpYA/J8D/ARFbisQubwFDK5Q+GPAz9T5dmwzizU6eYAPhjDVe/+hZ/yFm4Cx0YjBJ31jtdKX3jNmXh5Cu5LDyOHDDwv6FWN4ck4YEpcw8Q3lEpFXWLuXh4T6ZH70ohjhJ/T6PzJtE1z3A+8qwOBvRD3AiuZmhtBft9XuW9AUKGdgQ==
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by TYZPR06MB6094.apcprd06.prod.outlook.com
 (2603:1096:400:33c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Sat, 9 Nov
 2024 11:38:43 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%4]) with mapi id 15.20.8137.018; Sat, 9 Nov 2024
 11:38:43 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Angus Chen
	<angus.chen@jaguarmicro.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBVU0I6IGNvcmU6IHJlbW92ZSBkZWFkIGNvZGUg?=
 =?gb2312?B?aW4gZG9fcHJvY19idWxrKCk=?=
Thread-Topic: [PATCH v2] USB: core: remove dead code in do_proc_bulk()
Thread-Index: AQHbMkzVPsdcEHgF6kCJy18g0Sud77KuhSkAgABHMdA=
Date: Sat, 9 Nov 2024 11:38:43 +0000
Message-ID:
 <KL1PR0601MB5773F9F97A6AFC7E5D987323E65E2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
References: <20241109021140.2174-1-rex.nie@jaguarmicro.com>
 <2024110947-umpire-unwell-ac00@gregkh>
In-Reply-To: <2024110947-umpire-unwell-ac00@gregkh>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5773:EE_|TYZPR06MB6094:EE_
x-ms-office365-filtering-correlation-id: 5f0ad230-17b4-4bd1-d3dd-08dd00b31063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?NUhaMXVhSkkvWnB5RW55aThMNC8vNGROTnREa0llQzBJMGRsZXRJSWV4UUE1?=
 =?gb2312?B?NWRmeG81RXJsZDMxdWFvblh0bUhNSFRkc2xLRlZIWlJMTUJLbU1nKzF5VlBv?=
 =?gb2312?B?UlZ6c0J4dmRudHJMdFU2OUgwV3lkSEF4aE13d216WmtKVkZtb3ZubnBxcDVK?=
 =?gb2312?B?S3RkcGh0QXFWOGkxajJxbkRrWmZxOXl1S3J5MU5Lbi9oMkdsd3kzbGljTHpF?=
 =?gb2312?B?TW5vdWxmbUFEd0Yxd2JjMzViVVNaWG1PSlB1YStZRk1EVlJZWHJtbjV6c3N3?=
 =?gb2312?B?blgwSzZmbzhFNWFHZzJqMnI2dExydWtYMGk4Umw0S1NYaDROY0tGemRSKzNR?=
 =?gb2312?B?N0xoRW1Gdzl2c1NtdzNTOHJyRFRkMkRCajZGR0JWelJvcW4xWkJpMEFpNXI4?=
 =?gb2312?B?c00zUjY2d2Z4UFR5Mno5MC9ZKytnVkVRREI0bWg1clI4NUozTCtuY0gzV3da?=
 =?gb2312?B?MFJUN2ttMU05NmRGdHR0bkQzdXlqaXpscXpKblAvQ1czYlc2SjFLVW1RNHJq?=
 =?gb2312?B?TVN5UHhMcmNEQVhTRGdrRWIrOFdwWkFWVkZ5TjhpTyt5YTY4R1Z3dkd3S1hy?=
 =?gb2312?B?WmFxV014SkY0RklPYTNKRmhIbUlaQzdMOXl4MUtrS0tPSWpZWStVcUI2R3BQ?=
 =?gb2312?B?dVRvZnNDUHVvQ3IxQWhRNmJYSk9jcWtnRlVFOWxNMiswZFE5WTdLZVlFZXVP?=
 =?gb2312?B?WWc1ZHM4NWs0V29Rb29BUG5wS1FzT1F4c290MzdHZWFRMVBBY1ZHUGtNVEZ5?=
 =?gb2312?B?eVduSGlrUlhCN3g5WG9ucllNd3RmcFd0dHZEZXlyVEdud3owS0pDcWppOEEz?=
 =?gb2312?B?U3I4RElBdEdBbWo5YmxmWnpDYkpadVZCb3lmcld0eVAyZk9KMjVZMk9CQzhH?=
 =?gb2312?B?TVZVNGRtRlBCU0hXaTE2SC94aGtkcnNyT2FEVzE1bmpUSTRaajJEcVc0VjVi?=
 =?gb2312?B?VXF6OW42MERqcEI3M0RBcFMyK2tsMWt3YWRLMnpLemduZzdFUkpaUnhZMnBa?=
 =?gb2312?B?S0VqVUh1MnJVWVI4bk4xa25CdlNyem9adVBzRGpIUjArekg2bGhjeSt0ek0z?=
 =?gb2312?B?N1B5azZ2M1BodlVuKzFqUy9jeFNTMkRDc1hlTXpNRmdaL3d2STBFa3dQcGVr?=
 =?gb2312?B?ZU8zNG1jK3BMWFA1TlJQcVAxKzBhZGRoelVVUjJmelcrVmNMMGdMZmVhL3JF?=
 =?gb2312?B?cGN1bGtKMDkvN01vYTNkYzdZM0tkcmpDSWhaNTJLNEZOSWtFUWFBVUdxc3Rs?=
 =?gb2312?B?emNKcXkreEV1TDhNcUwwaVhReURzekFBM0VWSU92eTJxcnk3dGhtOWE1OFh1?=
 =?gb2312?B?a2N0NWNVUFdpVWM0NTVZZ0o5NTB1NUNvV1IrRWdXWWRvcXc3cEpaQkJjV1Yx?=
 =?gb2312?B?VEVrVFJ6NVFwMWNsTWF1dGlZbzJBWkVrc3h1LzlJWGFUclhvWURPR0UvWTcx?=
 =?gb2312?B?Wm1ndjQvK3NlUnJSdHdWUEVJTWlHYTFkOS9HVzM2RUhsZW0vU05KV0hpVEZP?=
 =?gb2312?B?cjJ6aml0UEJHMVp0MFBFM1NzeTRjWHVpbE02TGd1Zm1TdWh3ZW95WG5SMkph?=
 =?gb2312?B?UUgvNjVwQ0VvTnZRWThGSzdGSkkrU29TR0p3NkRzNzc2TStRZVRKRXZNUFI2?=
 =?gb2312?B?dU1vVHJyMlFVdjJFTTNndm9Rd2dSNW9wZXpGNmdUTXRNNWZLNm8xK2E5KzJN?=
 =?gb2312?B?MG56bVoybGp1ODVxelRqaEJkUU1XRlFHSVpBVUJVRFBwcnZnbHRiQlIxTVg3?=
 =?gb2312?Q?rxM3tTiUa0zdEX/dOTn2rWH/5zsCrtbnp9uXYIz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RmNlSW5NZk96RkF0dTZCWFZQWmE1VG8xUWthU1R2RXBWL3FCY2VJd3FqOG1i?=
 =?gb2312?B?SzZ5YUhERWN0VStJdGNUUlBKcE5nb1gyODh6NStvMHpkNS9pMnhxL2d6QitH?=
 =?gb2312?B?dS80S3NiUUVLQ2RIbU81d3VEZURvZVBUcnFRdzF6T1l6L002QWNyMzJUVzFW?=
 =?gb2312?B?OFFQK1YxVWw3aE9XVWxPSDVxOHRHUTN1Um0reEZFN0U2RDR4eXh4bGlxTzN3?=
 =?gb2312?B?MjQwZTMwVGNid2czMk9Td3NmNmpESCtkblZ4QjBjU1NMekVsTlN3WkhhSFpo?=
 =?gb2312?B?WUFJVExEamlRaittVXA1c0pNb2xieVBIbE0zSHpGTkJENHhnMUxPcExsRlFr?=
 =?gb2312?B?b0dhYzFaNVlodXBvdzVNQUd4dCtCTC83NE1vZTVQMkVTQXVQcjhydTNTeWhJ?=
 =?gb2312?B?aW91UExSZ2dreEtRL0d1dm9aSHlnc1BQOHZhMkI4YU52MlFpMU9lNmpVWnBF?=
 =?gb2312?B?dFdiV2xmdlZua0JsZEJxY0ljYTZtVHFXa0M0cGxiMXROQ0tLV0V3TGZncnhS?=
 =?gb2312?B?OG82NFMrYnlnS3BUcDRzS2cyVHUxV3NiWDdnUHczL3dvQkhCZU1zcEp2TGw2?=
 =?gb2312?B?QXlVQ2xFcG1vN1NGdU1EK1dEYnFEQjZaUm04SHUvcXJVZmo3d0VIV3J0Ym5o?=
 =?gb2312?B?Sk9xR2xzQzMvSDYwTUZNN2dyOHdkQjBKZmZVLzhxWFZhRUhBSWNqeGRpYWpw?=
 =?gb2312?B?cnBGNDRvd3BvQkVyWnhCU2lJZzVjK2FxeFUyejZvVTRuVFJhMmJaTWlEMDFP?=
 =?gb2312?B?V1I2M1NFNU1DbVNwRU9aWUtRWjZMNW5zR01FeFNWYnpvN3dFVlYzTEJXRnJV?=
 =?gb2312?B?YTZ6QnhJV1JDTU5hNUdzTGNiOFRoaXFHNy9MdHVqUEdXdTRJdHZyK1k0czYr?=
 =?gb2312?B?a2JuSU84TndoTlZnWkQ0SlBMSHkzUW44SHVaenkzQkVKWVAwbms0QloweHd1?=
 =?gb2312?B?T29vWHlZbC8yQVBxeDBYdUZsZmRqbnlkUm5GZ3k2bmFVUEgvZnIrZ3dDMmtW?=
 =?gb2312?B?MXhRNEh3VkxSSEFLVmpmT21ETGlwRTFONXNxTTVEYmNiVkVSbUVBL2VjWTNn?=
 =?gb2312?B?UVZzNFdqQnFEa2J2eVRZbVprQzlyQWlCbjBaSWZKNDd2QWRjTGo4cEdTakR2?=
 =?gb2312?B?WlVEaWpseDVQMnFjcmh5K0d1a0N5Mm1LaUI4U254L2hGZG5ZOEFuMlNJcGI2?=
 =?gb2312?B?MVpzdTZHc0NjNTNRdm9OVWwyeHZQRGRHMy9PZkwyM0hnVlBldW9ucnNyL2xx?=
 =?gb2312?B?bVg0ZXFYdGx3bHZIcVdQcWFwN2Y4MVNwQlNIbC9TN2hTSEViM2FCbkdkL29M?=
 =?gb2312?B?WWp6SU1ocUJjWkprbVZadkJzcVY1K2huemJjdU4zbXUxdXdYSTJLRTd3cThY?=
 =?gb2312?B?bndFZG1TS0oxRFo5QXVyRzNkMWxOTFVqWUVWazRMd0wybDA3VHlQTURhQ29r?=
 =?gb2312?B?Zjh4STkzNUlsR0NodGRkaktnbU9TN1IxZFRlVmhCKzE2ejlnREloL1VWeTBi?=
 =?gb2312?B?eHU4OU5aWUhDR2VGSXRrOExBTUErNHRQcllsWnpETE5GdU1wVU9EQWV0OVJn?=
 =?gb2312?B?WUs5SFNRLytsMzl3dnVFRmVaekd1SWl0eVBSU0hXZEZOc3dBcENaejlWU0lo?=
 =?gb2312?B?dzBnd0dBV2JITVMvR2VRVmd2SlVVUURvbmNtQW5mdWF6amVNQlNoSmo0ejZV?=
 =?gb2312?B?NXpRSEZXL1liVS9pYXJPS0Y2V3ZUc1cwaW8zQnc0T3F2bGttWHNKcXhYT3c1?=
 =?gb2312?B?WGg2RnZsVFBYRFdwOTh5blZZNVF3SG1xNVB0U3UwT1Z3NHZkSkE0RHhyRUhS?=
 =?gb2312?B?NEowRDMzQ0tYbTNrOHFGeGJWb3NmZEZmUHAwL2l4Y0o1UDBmYmZlL1kzL0Vh?=
 =?gb2312?B?Q1MwdW5iWlRISTh6SkVNU3RFNXZmZzFJSjhTUks4SkM3dXc4bnpzMnB3SjF0?=
 =?gb2312?B?NlZkUHEyQzYyM0dHc1VuY1BaZDY3aEVBdDV0R2dOTVBJTTlKTmJNQytxbU1F?=
 =?gb2312?B?N1hneUt5YjJOY1BXQ2NrL0sveWxTV2Jsd1JYVW5majR3V0tHN3ZNV3V6TFpa?=
 =?gb2312?B?MjBlSk9veGp3aFdyWEdndG9kbVRTdTZwK2dTdUQwNHhtOUJaRjBSbGRhamFy?=
 =?gb2312?Q?G3tC1wg0kVZehq2sUG8AGgbH2?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0ad230-17b4-4bd1-d3dd-08dd00b31063
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2024 11:38:43.0222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixc/ugB986w4WQhORzEiLr9cmPkz4HoSktcRngUJ2a8lV23dqdPDxOtpSTaZE6t4iKltrUqV8lnwPMrzHyQUxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6094

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+DQo+ILeiy83KsbzkOiAyMDI0xOoxMdTCOcjVIDE0OjU5DQo+IMrVvP7I
yzogUmV4IE5pZSA8cmV4Lm5pZUBqYWd1YXJtaWNyby5jb20+DQo+ILOty806IGxpbnV4LXVzYkB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEFuZ3VzIENoZW4N
Cj4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPjsgc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiDW98ziOiBSZTogW1BBVENIIHYyXSBVU0I6IGNvcmU6IHJlbW92ZSBkZWFkIGNvZGUgaW4gZG9f
cHJvY19idWxrKCkNCj4gDQo+IEV4dGVybmFsIE1haWw6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBm
cm9tIE9VVFNJREUgb2YgdGhlIG9yZ2FuaXphdGlvbiENCj4gRG8gbm90IGNsaWNrIGxpbmtzLCBv
cGVuIGF0dGFjaG1lbnRzIG9yIHByb3ZpZGUgQU5ZIGluZm9ybWF0aW9uIHVubGVzcyB5b3UNCj4g
cmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+
IA0KPiBPbiBTYXQsIE5vdiAwOSwgMjAyNCBhdCAxMDoxMTo0MUFNICswODAwLCBSZXggTmllIHdy
b3RlOg0KPiA+IFNpbmNlIGxlbjEgaXMgdW5zaWduZWQgaW50LCBsZW4xIDwgMCBhbHdheXMgZmFs
c2UuIFJlbW92ZSBpdCBrZWVwIGNvZGUNCj4gPiBzaW1wbGUuDQo+ID4NCj4gPiBDYzogc3RhYmxl
QHZnZXIua2VybmVsLm9yZw0KPiA+IEZpeGVzOiBhZTg3MDliMjk2ZDggKCJVU0I6IGNvcmU6IE1h
a2UgZG9fcHJvY19jb250cm9sKCkgYW5kDQo+ID4gZG9fcHJvY19idWxrKCkga2lsbGFibGUiKQ0K
PiA+IFNpZ25lZC1vZmYtYnk6IFJleCBOaWUgPHJleC5uaWVAamFndWFybWljcm8uY29tPg0KPiA+
IC0tLQ0KPiA+IGNoYW5nZXMgaW4gdjI6DQo+ID4gLSBBZGQgIkNjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnIiAoa2VybmVsIHRlc3Qgcm9ib3QpDQo+IA0KPiBXaHkgaXMgdGhpcyByZWxldmFudCBm
b3IgdGhlIHN0YWJsZSBrZXJuZWxzPyAgV2hhdCBidWcgaXMgYmVpbmcgZml4ZWQgdGhhdA0KPiB1
c2VycyB3b3VsZCBoaXQgdGhhdCB0aGlzIGlzIG5lZWRlZCB0byByZXNvbHZlPw0KSEkgR3JlZyBr
LWgsIEkgZ290IGEgZW1haWwgZnJvbSBsa3BAaW50ZWwuY29tIGxldCBtZSBhZGQgQ2MgdGFnIHll
c3RlcmRheSwgc28gSSBhcHBseSB2MiBwYXRjaC4NCkFsdGhvdWdoIHRoaXMgc2hvdWxkbid0IGJv
dGhlciB1c2VycywgdGhlIGV4cHJlc3Npb24gbGVuMSA8IDAgaW4gdGhlIGlmIGNvbmRpdGlvbiBk
b2Vzbid0IG1ha2Ugc2Vuc2UsDQphbmQgcmVtb3ZpbmcgaXQgbWFrZXMgdGhlIGNvZGUgbW9yZSBz
aW1wbGUgYW5kIGVmZmljaWVudC4gVGhlIG9yaWdpbmFsIGVtYWlsIGZyb20ga2VybmVsIHJvYm90
IHRlc3QNCnNob3dzIGFzIGZvbGxvd3MuIEkgdGhpbmsgaXQgbm8gbmVlZCBhIGNjIHRhZyBlaXRo
ZXIuDQpUaGFua3MNClJleA0KLS0tDQpIaSwNCg0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLg0KDQpG
WUk6IGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZXMgdGhlIHN0YWJsZSBrZXJuZWwgcnVsZSBpcyBu
b3Qgc2F0aXNmaWVkLg0KDQpUaGUgY2hlY2sgaXMgYmFzZWQgb24gaHR0cHM6Ly93d3cua2VybmVs
Lm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLmh0bWwjb3B0
aW9uLTENCg0KUnVsZTogYWRkIHRoZSB0YWcgIkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnIiBp
biB0aGUgc2lnbi1vZmYgYXJlYSB0byBoYXZlIHRoZSBwYXRjaCBhdXRvbWF0aWNhbGx5IGluY2x1
ZGVkIGluIHRoZSBzdGFibGUgdHJlZS4NClN1YmplY3Q6IFtQQVRDSF0gVVNCOiBjb3JlOiByZW1v
dmUgZGVhZCBjb2RlIGluIGRvX3Byb2NfYnVsaygpDQpMaW5rOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9zdGFibGUvMjAyNDExMDgwOTQyNTUuMjEzMy0xLXJleC5uaWUlNDBqYWd1YXJtaWNyby5j
b20NCg0KLS0NCjAtREFZIENJIEtlcm5lbCBUZXN0IFNlcnZpY2UNCmh0dHBzOi8vZ2l0aHViLmNv
bS9pbnRlbC9sa3AtdGVzdHMvd2lraQ0KLS0tDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgN
Cg==

