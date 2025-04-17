Return-Path: <stable+bounces-132889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACEFA910D6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 02:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CB03B701F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 00:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB42A935;
	Thu, 17 Apr 2025 00:43:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2139.outbound.protection.outlook.com [40.107.117.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81313C82E
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744850583; cv=fail; b=G+HarbdKoWa1hvVkK7ctMlGcddCpFBj+6ncBCm9/1XUUaKdILw6tct9BMNjHdd95w5bfWvxzISyREhZ+/dJTnw+1Y7odj5YE6ea1hXUPO13Rj7ONJuCUEpQIUTYPfZY1hmYWB0sKtS2hG8G58flXtmgPTQte1WpjDVM8Bc2673c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744850583; c=relaxed/simple;
	bh=ww3ibZO1MVFse9Y9X/NY+oGh3lKx7iVvMJOHYrlaVgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BXoCUfPCMQjnjOVbEbOo+szAm6A2GzNafgz/hXJA3VDQZ+7uOHJCiZ1AqG6BXoTlGG27qbGM6PzeMf+8yZCtiFud7oqB2Ln+R+gn0lWajwrLpnca4cSj9yFCVD6lfxtwWv8gM4blIrJdQs6hSe0X1vNFi6R5wpNBlGSGbWArCuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQs6Ure6R7vdgv2X9pEaLW92QpGwdH3vPBzFFWATcDgg/c2WVOcihL/iBNsPJUgDnhw/0KNaLGz2EQ5S+fJYDYqBcfgBPq3Kl8qYb8fS9ECdiaIQkHxdAvkYWkKpvkGENxJF315meIyIryhU+kFVUT0dyCoDzyTftN1d3Hmk99RwF2KG2E/Iu1m3pcgFzC2mC8IHKoGEQdbfN28C4wlUDjti1PXHjzpJT6OoopOJ+hepVLg/atVwKoNCGl9wAC/T4LQfLmL0oE26BOKPcJawm911FkN+NwEo6LQs6D0h5EAWpaAqSt7Y/J6IrDYJvj7eqfDzgmF/00DbHDH1x0K9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ww3ibZO1MVFse9Y9X/NY+oGh3lKx7iVvMJOHYrlaVgk=;
 b=Q3rWoqPjVx1lK80KpSj1SQNhvEqt4ZgBWWkVUOZMORWDvZAcVuX0gqqkpgrdCeb1UF0u3jV5tF2ZiMnBLloPG33q20aVSBR/8C052PCcHVMvSeqsX7yzZQxlrbgsTEYmaDsMOa5ON3xmUEGKR1xMIdpsr4BpbO+/Of3G/8+j5lFv3/08T6rKroTOquM7cnHx+blYLpjngyQHOmiMsQN+TJ+7pbFG24F5onxrKPljLuPVAx3+XSCR6BwjKIhYfsNl5HqOoG5AeOslCozNv4q7+02n8Wcv3VM4ZfhnFYDYJVXSSH8/Yh9QWTbqasrQIZLwfbJKu63wWeOpV6wrwEEtRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB6925.apcprd06.prod.outlook.com (2603:1096:101:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Thu, 17 Apr
 2025 00:42:56 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%4]) with mapi id 15.20.8632.025; Thu, 17 Apr 2025
 00:42:56 +0000
From: Fugang Duan <fugang.duan@cixtech.com>
To: Alex Deucher <alexdeucher@gmail.com>, Alexey Klimov
	<alexey.klimov@linaro.org>
CC: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
	"frank.min@amd.com" <frank.min@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "david.belanger@amd.com" <david.belanger@amd.com>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>, Peter Chen
	<peter.chen@cixtech.com>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject:
 =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtSRUdSRVNTSU9OXSBhbWRncHU6IGFzeW5jIHN5?=
 =?utf-8?B?c3RlbSBlcnJvciBleGNlcHRpb24gZnJvbSBoZHBfdjVfMF9mbHVzaF9oZHAo?=
 =?utf-8?Q?)?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUkVHUkVTU0lPTl0gYW1kZ3B1OiBhc3luYyBzeXN0ZW0gZXJy?=
 =?utf-8?B?b3IgZXhjZXB0aW9uIGZyb20gaGRwX3Y1XzBfZmx1c2hfaGRwKCk=?=
Thread-Index: AQHbrjQsyP3jhAPl60GLV5n21BS/cbOlnd8AgACKPQCAADjdgIAApZ2g
Date: Thu, 17 Apr 2025 00:42:56 +0000
Message-ID:
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
In-Reply-To:
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB6925:EE_
x-ms-office365-filtering-correlation-id: 17e43475-922f-4688-805d-08dd7d48cb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d0MvajdpSDUyM05mQjd0cGNPSUlRWHo4c1VSUGtBeUlSRklmT29ZVGppYk5U?=
 =?utf-8?B?c0xnai9NcjBraGI2SlBxM3V3NUNGNmgzMlI2cGo4anl1OGNEUTB5dExTSGY0?=
 =?utf-8?B?bm1YVGZ2TXc2VllkNG8zenBwcHJic29DZHpPOThHdXhBMWZ4WXVMdzFJWktM?=
 =?utf-8?B?MFVObkZHbWlwQzljWVhDbzJBcHNkU3lIS0tRbnVVNEdnZWhnMDV6c2NUNVk2?=
 =?utf-8?B?WWFZNXRvVlBDSURSUXR2bVhKejl4V2RmTHpmOUJnQjdTZk0wajBGY2ROekM3?=
 =?utf-8?B?cy94a2pGVk5LaURFUTkrQ0owcTd0WkhCRmRzeGJRMTRzVWVveit4ZWUwMm0r?=
 =?utf-8?B?NEIyaDlubmR3anY2MWRCRG5lNllkbmtYVktBa1VITCtoVWtSVlVBeGFwWGgr?=
 =?utf-8?B?Q2ltM1Z3MXo0VG90SUV5aXB0Z2w4Z2F1WTlNQ0Rsc1JYaU1LbUtQY2JlNzJl?=
 =?utf-8?B?VmdlcWJJK0VsbTRvbTFKR0c2UUtWYm9qNDFQNTJZWHRIY2swQzNLV2RGVjI2?=
 =?utf-8?B?TTRoZllaZlkybXVaa3JrUGpCVld5SG1MQmFKYUJoTFJPWmY0SnZxVmc0akhw?=
 =?utf-8?B?UndyVXhraVRWdGs3VlFmaFloY1pvbFZBVy9pWG5UdTMzVzd3WnlmWU5SWGdO?=
 =?utf-8?B?QXl6ZmplWlNLeGRyVWZFMU4wQ29EUGNGbmhCbHRZb1pOY3JiVHNyVTdZYk5a?=
 =?utf-8?B?dVlyZktmbWpKcUY0ZktFQm44MEtIWWdDcGgvOUhtYUJaUUttL0hzU1BZVVhy?=
 =?utf-8?B?VWhWeFpmSG5VQ3VvV3RlL3pTRk96ZldDM3dXbzFzMEE0UFhoQmFYYUJBU1kx?=
 =?utf-8?B?QnY0cXE3K2hLNkx1eFJ2aGxWbUUvblgwWmpNOVZ4a1ovUlowZWlQbGI2ZW9E?=
 =?utf-8?B?eFkvOWFBbU5UOEQ4OEgvSmFEbVFXb3FsY2Vjald5V0JjeUM5eUlPeHdDYlds?=
 =?utf-8?B?MkE5aDkraWlmbGQ3NnlGTWwzTkxCWW9tdjBMaDBUMFI0S0cwOTd3aGplZHZH?=
 =?utf-8?B?VjNSQXBnYnpGUzRMOTFSL1dyZnhaU2ljQUEyMTJMUlp0dUpNRDlnYVRmMnlR?=
 =?utf-8?B?NGJBSzFhK3c4RzI2UnFDSG4xQWpqQXhSazlVVEpwVldGRHNTc3ZZT093TzZm?=
 =?utf-8?B?ZkhzUTNnNWFtdFRHN2R3WUk4YkdPWnNWejdHN0tjZXpQQWxRbk9BRlNOd25R?=
 =?utf-8?B?Z3BBVml4dURlL1RvNXBWVGtmWTJWcnhLc3RBaEJQMmVjTUpTb0o4OVNoNzJQ?=
 =?utf-8?B?WW9rdndGZ0lINTloSTl3RENSWitSbC9PWXE0MnRUOWV5VDJOUmUyVVZhMkVN?=
 =?utf-8?B?cHFTdytaQU1BclZOZmVDbldXa3BOVlFBWDVDQk9Yd25STXlrR3NodnEvKzlF?=
 =?utf-8?B?VUxRbUVrMEtoOU5KQUNLTzVheTI5RTR5SExiYVlZam5QTnVoMVhJdnZpSkJw?=
 =?utf-8?B?a2dxalFCbmRTRTh2WmpsTWFkYWYvWUplZ0tPWVhyV1ZoSmY0S3JPcFdWVW5U?=
 =?utf-8?B?ek9SQzY0OTgyK1F4VkpjcFRVK2hOVElmYkY1aHNwam1qM3U5VlNIN09BbWMz?=
 =?utf-8?B?ZW1RaUtuNFpibkdaeVdySnhpcnlDdWFsRXMwNjdQUmdSWnl0cXpOUUpZK0VG?=
 =?utf-8?B?SER6K21XdHo5dkRCNURHVHFZcVQ4Wlh1MnpiTldXdExFZFBxN0NLK2ZxMno3?=
 =?utf-8?B?ZmZoSU8valFHWGYzM2lNTzVpVGhqYmNXRHVDZUlCZVNWZkZ3aTZoYXdpMURF?=
 =?utf-8?B?UmJJVklWMmNHQzNEOHgvdmFMS0lHRGpEZ1N6dWdaQ1ozbHBKbVRlOG9aaXhF?=
 =?utf-8?B?SkJrdEJxbnZYVDVwR1A3WlIrenpFY1hYays2WkJzM1V1Wnl1aXlLK1NFdGdp?=
 =?utf-8?B?VUNKNlgxS0RvQjM3NkVDOCtkUFhjblpiSGtZMlNUQnM3Y1ZnOFpHd0xKaWZF?=
 =?utf-8?B?SDgrNGMzN2lxQXd4ZDgrTFE0UHN6NjlSYnljL1RwWWxZZ3MzallicVowdlFT?=
 =?utf-8?Q?+PetiJ7TVEfzntjToSdFbGGoAn1KbY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5041.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0M1ZXVZZjA5ellqV0JwRHlXVUJWL1NqMkVtdS9teXF3aUtCanFCbUJyTFVR?=
 =?utf-8?B?c1puNzRneE5lc3RYc2dxYzJYdFljZ0UzQlRkREVNNE03ejkyeDExcXRERlRQ?=
 =?utf-8?B?ZDFSS1pGTEgvNDdXaDlsWGRORWZZY2gxbVpTSzhpRDBFVitCY3hhaWVSc2Yw?=
 =?utf-8?B?RlpkUDE2OTk4b0Z4VCtmcGhuVU82UFgrUHZlU0NNUkZ3THdQd3lTU2c0cU9J?=
 =?utf-8?B?WU9mL05IT1JHVDk4RlJXd3ZQWFVNN3BOZHZ3dDY4bHc2SXNlNlFONlNoVzQx?=
 =?utf-8?B?SDBGYmRTbGt0NmliYVFhaUNWSkwxeEtMRXN5bVJzOHBYU1Y0dTBtWW40Y254?=
 =?utf-8?B?TGcxQkJ0YStRc05IQlFaQUFuTlhmUUFVWnpnNmlyYktwR25yaHorenlLTG0v?=
 =?utf-8?B?elFyY1hGR0EyanNEQi9sellXVFp0UFErTUdxWHpBcUtQcHZaNFlJcG16SHgx?=
 =?utf-8?B?RmtjczRDZS9CTVl5WFBhVEJ5a3k4YUJKeTNENUtnYmkzdG9YeUdaMnVYU29Q?=
 =?utf-8?B?aEJsQkVCQ3BxNlM0bXJybHd1NFV4bDZPRkJHSUg2S2VEdzBySzYxdnZacHk0?=
 =?utf-8?B?aERnZ0hiL3VURXR2aWtsWW90NGZRWWsvRnFHYXo0MTZWUTlQaDQzd3dlVkNh?=
 =?utf-8?B?S1cyajZHc2hZL08rYnFsQW9ycWJyOHNubU16ME1JeHpmSG40bk4yQWNOUmli?=
 =?utf-8?B?cnNjSmFSdEtzUnFBTDlXNFNpQSs5eWNKc08wM2NSVXVYVk9RS2tXb0hwQzJT?=
 =?utf-8?B?WGNleVlmZTFNWVowNUJ5N21XbXhseUxpaVpHNys3Vi9FcS9IU3h6NnJxN1h6?=
 =?utf-8?B?NWZoNzlMYjVldzduTVpyWWtVR0JCZ0JGQVFoUzk3KzJscTgzZzJpczFXQlVz?=
 =?utf-8?B?eVBPVStRbFNPNnlrd1JsUFVGMi94bUhGN3NveFZsWEtqR1hkLy9SRXZUeSts?=
 =?utf-8?B?R0dhMEU2TnU1K2xKcWpWbENNYXkyQkIycHdFYVB4V3p6UUZvUHBBcFF1OGha?=
 =?utf-8?B?dGROL0NMOWlKaTNUcUd4SnYrZ3RJQ29LN29xdmxPMWpSR1lNU2o4bXQxLzlJ?=
 =?utf-8?B?MlhlUDdDMWNyN3NrYUJaT2JQSmFiZHBCckszVW42Sk5zSG9DSFFBZDUyalds?=
 =?utf-8?B?R21hQnlhdU5Md3gvbWZ2Q3BOTmgvNXBML3ExblYyS0tGMWxxeFZLdkMyM243?=
 =?utf-8?B?d3h3aDhubkVZdENnODR3U2NPQi8rUXFidjVQeWNienRiY3BhRkNveTZTdGxX?=
 =?utf-8?B?WkdSdkpNR1pBbUpseGkrcEhzd1dpMzJ3OHBzaG5aZ1NpTVI5TGdGemxlNGts?=
 =?utf-8?B?cWM3K1MwZVJuUEZUTFB1MC9ydE04OXcwNm94TyttODU0dVhOaTlGblVlVFdR?=
 =?utf-8?B?WCtHK0tSLzN3MUxNZFlYN280NDBXNXlNem44Q2QyVDNYT0NTMjJwaTVMbzJ0?=
 =?utf-8?B?S2ZGb3Zra1NaQ1ZFT3BQWE0zR29tNUhZY0Q5NTBpbGdZMEdQcXhXbUtXa01q?=
 =?utf-8?B?ZTkzZElmdHhhVW9qL1UzY3l1aTFid3IwMHpmRVA3QVVUMHI2ZlhuWUQ0RVZT?=
 =?utf-8?B?YjlkZmtiK3E1NGw1WmxPMWVTenV0WkQ5Y1hhN2pzNnl0R0t6dllyZU11L2xs?=
 =?utf-8?B?RUVSb01DbG9OVWhjcUhLZ0hMR2lJT0t4UFZ2cWlVQXl3eGlMSm5pSlU3N3JK?=
 =?utf-8?B?aElRUFJPSjVTWUFBWHNKcEtLYlFPQ2N4TFFUalFYYWRZd2lEamdvVmY1eUNC?=
 =?utf-8?B?SVR4bnBNUG5CZDF3U2RVYVFIc1FOWE1sditLcUErZWtrWnQ1WEhYRC9lUzBG?=
 =?utf-8?B?aTU3V0VRN3A3d2lmNU9TdVdnWTIwOE5PMkZsWFZZN0k5MkE1OW9hUC9hcEwy?=
 =?utf-8?B?M2ltL3lTTEhpTGNNcjMvRWRKRkJwME5PWnRQZ0dreFk1RXBNM3IyaWIzdGtM?=
 =?utf-8?B?NkpiVVU2ZXFKMFhBVG8rWjE2NHlsMVE4R2RiQVNPeXRGK3JQbHBJSHdFZFlJ?=
 =?utf-8?B?c0FpTjIzYXVIMVBSTWlkUUJmeEpiaWxrRCtzS21mNjd4NElsbjJPWWZlZS9C?=
 =?utf-8?B?NnR4UWYxN095WmplVXJzcGRERjg5NmR4Q0dSWTE3QXAzczJRTzlsWTExMWpR?=
 =?utf-8?Q?/w55iyuv/aJsGKqYaIZ6dGiYp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e43475-922f-4688-805d-08dd7d48cb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 00:42:56.0952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJnKJx+47gRiF0vldYxixmv5JSUyfpikeSNJJBKbQnF2dNCxSXm5gKVrdXHDtWMjFBTjkz+1584dE0treBk1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6925

5Y+R5Lu25Lq6OiBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4g5Y+R6YCB5pe2
6Ze0OiAyMDI15bm0NOaciDE25pelIDIyOjQ5DQo+5pS25Lu25Lq6OiBBbGV4ZXkgS2xpbW92IDxh
bGV4ZXkua2xpbW92QGxpbmFyby5vcmc+DQo+T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgOTo0OOKA
r0FNIEFsZXhleSBLbGltb3YgPGFsZXhleS5rbGltb3ZAbGluYXJvLm9yZz4gd3JvdGU6DQo+Pg0K
Pj4gT24gV2VkIEFwciAxNiwgMjAyNSBhdCA0OjEyIEFNIEJTVCwgRnVnYW5nIER1YW4gd3JvdGU6
DQo+PiA+IOWPkeS7tuS6ujogQWxleGV5IEtsaW1vdiA8YWxleGV5LmtsaW1vdkBsaW5hcm8ub3Jn
PiDlj5HpgIHml7bpl7Q6IDIwMjXlubQ05pyIMTYNCj7ml6UgMjoyOA0KPj4gPj4jcmVnemJvdCBp
bnRyb2R1Y2VkOiB2Ni4xMi4udjYuMTMNCj4+DQo+PiBbLi5dDQo+Pg0KPj4gPj5UaGUgb25seSBj
aGFuZ2UgcmVsYXRlZCB0byBoZHBfdjVfMF9mbHVzaF9oZHAoKSB3YXMNCj4+ID4+Y2Y0MjQwMjBl
MDQwIGRybS9hbWRncHUvaGRwNS4wOiBkbyBhIHBvc3RpbmcgcmVhZCB3aGVuIGZsdXNoaW5nIEhE
UA0KPj4gPj4NCj4+ID4+UmV2ZXJ0aW5nIHRoYXQgY29tbWl0IF5eIGRpZCBoZWxwIGFuZCByZXNv
bHZlZCB0aGF0IHByb2JsZW0uIEJlZm9yZQ0KPj4gPj5zZW5kaW5nIHJldmVydCBhcy1pcyBJIHdh
cyBpbnRlcmVzdGVkIHRvIGtub3cgaWYgdGhlcmUgc3VwcG9zZWQgdG8NCj4+ID4+YmUgYSBwcm9w
ZXIgZml4IGZvciB0aGlzIG9yIG1heWJlIHNvbWVvbmUgaXMgaW50ZXJlc3RlZCB0byBkZWJ1ZyB0
aGlzIG9yDQo+aGF2ZSBhbnkgc3VnZ2VzdGlvbnMuDQo+PiA+Pg0KPj4gPiBDYW4geW91IHJldmVy
dCB0aGUgY2hhbmdlIGFuZCB0cnkgYWdhaW4NCj4+ID4gaHR0cHM6Ly9naXRsYWIuY29tL2xpbnV4
LWtlcm5lbC9saW51eC8tL2NvbW1pdC9jZjQyNDAyMGUwNDBiZTM1ZGYwNWINCj4+ID4gNjgyYjU0
NmIyNTVlNzRhNDIwZg0KPj4NCj4+IFBsZWFzZSByZWFkIG15IGVtYWlsIGluIHRoZSBmaXJzdCBw
bGFjZS4NCj4+IExldCBtZSBxdW90ZSBqdXN0IGluIGNhc2U6DQo+Pg0KPj4gPlRoZSBvbmx5IGNo
YW5nZSByZWxhdGVkIHRvIGhkcF92NV8wX2ZsdXNoX2hkcCgpIHdhcw0KPj4gPmNmNDI0MDIwZTA0
MCBkcm0vYW1kZ3B1L2hkcDUuMDogZG8gYSBwb3N0aW5nIHJlYWQgd2hlbiBmbHVzaGluZyBIRFAN
Cj4+DQo+PiA+UmV2ZXJ0aW5nIHRoYXQgY29tbWl0IF5eIGRpZCBoZWxwIGFuZCByZXNvbHZlZCB0
aGF0IHByb2JsZW0uDQo+DQo+V2UgY2FuJ3QgcmVhbGx5IHJldmVydCB0aGUgY2hhbmdlIGFzIHRo
YXQgd2lsbCBsZWFkIHRvIGNvaGVyZW5jeSBwcm9ibGVtcy4gIFdoYXQNCj5pcyB0aGUgcGFnZSBz
aXplIG9uIHlvdXIgc3lzdGVtPyAgRG9lcyB0aGUgYXR0YWNoZWQgcGF0Y2ggZml4IGl0Pw0KPg0K
PkFsZXgNCj4NCjRLIHBhZ2Ugc2l6ZS4gIFdlIGNhbiB0cnkgdGhlIGZpeCBpZiB3ZSBnb3QgdGhl
IGVudmlyb25tZW50Lg0KDQpGdWdhbmcNCg0K

