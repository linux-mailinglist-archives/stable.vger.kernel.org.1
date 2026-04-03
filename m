Return-Path: <stable+bounces-233228-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HrsHGL+z2kr2QYAu9opvQ
	(envelope-from <stable+bounces-233228-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 19:52:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D68583972B7
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 19:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C00D8302198E
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 17:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D7B3C4574;
	Fri,  3 Apr 2026 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="evM75+TB"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013043.outbound.protection.outlook.com [52.103.14.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105693B3895;
	Fri,  3 Apr 2026 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238751; cv=fail; b=NUT4xMYgxeuVN8ngwX23yAiMnFqpbNGnY5CSofFoIQ5HajWXwl5wqahiMKXlCiqiuBkC0Nj7MqX5m1OPTgyCf0ZKuZzDCvK+VhHalk4pXyol5GYPIrdo9pyFr/AtFNT14eOfFBaiFmADE5qanniJjpuCeXF0Q1tiA107f5C1Hzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238751; c=relaxed/simple;
	bh=nDyBabOhjJmPrr/tW9LOfDHIem1hJiM9I3ORhiv7reI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JC47qwdyJJF+0sKw8LE484/NdBWEIAvyWDtlEVNZsJDXE5D1g+fHR9GmxHXeeq5VjV0dN4YzhEu4Ue0mzBb6iX9gcIl3XX1YprC0Mvryp87Wb8RdhG8ttlVGFE8yJEQfRD7/ccBQsvj+jNBmDP3rwvV6b/RZ0hQGiT2c7TzFtOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=evM75+TB; arc=fail smtp.client-ip=52.103.14.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q43souVaZDiVd0eCBWdMbiCBSad/RdUMojfK/lHQvO2zS8GJkbtY3cSuPrRG7bi7xRx1sF3+NGN5GXELXSWzD2/+FcqGvSftxWZr3mW2nG8wtHyjEBgQA2AxMnVnJiwiDjJ6SLPntkhqczRwzdtir8WN27mmiXdZoUUPunDleCgyrKKSCswM22t4KGKwTs2wNgnajLD8JPBvMC2tNhUKGy6+II/GnLigp1hPu4uNxB50eYiSKPqAZ91q/04v95I3qwNe7jFzmeXl6dwvuUWfTrcN46VDPTEC3Vd5rpYUTJXgKi9I6isfWXUCGVrh+zR0oLHNia+ygaWcIR33aU5ryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDyBabOhjJmPrr/tW9LOfDHIem1hJiM9I3ORhiv7reI=;
 b=ojw5HDOvJ4eet5ns+cZ5VgQop7UVnqDoSxFAyrUjBYG8ZXbvkBUwIJ04O0FkdqLguSwF+99eY41OvcYliq+O3oVuBpjyv3Ii03yITScsrE+FQBa/B4rBLELaOZvCO4gRT44QsEYzy/H2fJ7n3tBykyEwOwgboeUflsLu7l1MdW/J+lxZBvb+mGZV/nzXijRx8xjcGqK4YIlBYnM83EN1AmoO604j00yEtLLrBcxLyQx1Fillw6UfUGY56EZh0Z/S4XVuwDXKB/E7+6V2yYVHWzYQOjOaJG0QZWhu43oD/MpZRrw6CqQ/RYmF84hddgAB4rDjleX4ptCqdC+9u6Sxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDyBabOhjJmPrr/tW9LOfDHIem1hJiM9I3ORhiv7reI=;
 b=evM75+TBtwG0naiBMvH/qqSG+ebtG2c7PAjSiC10AVkFTBVvUnpavQoRYBnDV1VqFArJrUaE8KESAd5UiGczlyv506rXmpkGUNvlxSVC4kZ86+rGnDFWa/ObR5lR248KQrw5Nf9YBn9Q0lo7h+BQwyvF2bpwsw5lYWR13Uy3XJEXZjlOWdUxpkFk6GNzb9ciWy0P+ikqIQmQ/zjwZJV1ycJ3Vr8Mp6jHsyiorm3F53HJp8t9J1syxg3tifFHD+iKxuFbE9bJFi99SROa+k/wGdHkRLNp9r+DPotMb3KAa1gHbSIJLYq83JM0mr12r1PPhjoqTXb6AmR5yxjt3+zxlQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10035.namprd02.prod.outlook.com (2603:10b6:610:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 17:52:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 17:52:26 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
CC: "driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Michael Kelley
	<mhklinux@outlook.com>
Subject: RE: [PATCH] sysfs: attribute_group: Respect is_visible_const() when
 changing owner
Thread-Topic: [PATCH] sysfs: attribute_group: Respect is_visible_const() when
 changing owner
Thread-Index: AQHcw4dRnhT1m2eJDkC53lQsu0XrBrXNnjPA
Date: Fri, 3 Apr 2026 17:52:26 +0000
Message-ID:
 <SN6PR02MB4157C4F81A88353B031514DDD45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <20260403-sysfs-is_visible_const-fix-v1-1-f87f26071d2c@weissschuh.net>
In-Reply-To:
 <20260403-sysfs-is_visible_const-fix-v1-1-f87f26071d2c@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10035:EE_
x-ms-office365-filtering-correlation-id: 34569c22-09d8-4a10-f18d-08de91a9c495
x-ms-exchange-slblob-mailprops:
 BP6inkMtVg5ZicFeQglYWiW0wIV8Xy0DOJ/oXCg14C6tQIpOYemGyBYLUI5Qzn68lg11eaDKDA+a6s8Rgp+h7VBznX+07dudLQi/EHqu3o34btriXtAjgX9OsYMe1eSpgTEIO3JRxRiV/V4heCyG6tcgxceIpOoY2MZcsC9x4VsgNRqDlkW7IB9kSauA2FMps5FICuU6ibDeNuMnV9ArVg8xlgkc6iHQQnUO3YZZ07+caRlFJUOznZt2DDQmh2O72tJ6TiJvMmGhgSu3AacxuIHKxeuTlEg2aQ0o9G2A9W9V9mOWqjkJhW3yX7Zo8tHmmJOl4RjfXuTh/N9gE67ttiRKzo8ojhKJWE3OVr4kmwTxQZmiBr767HiiZrjxdaWTt/m2GXMRASuDDuXvCLfTxaaUMFmdnXWquiB1zPVSh/btTRojRIAhbxsYJHH+QB0rMTIBjAdPm559RfDwLzUzP84lVsJAVt0wA11KeKAXjxf8quu1s82dEH9UkzLWP/WPWYmmR94t3OnXjnGCiDxL7lnLpSSRj+xfSMV6mmt9Ku+JU6JTqQPYV+VwqI0JI9njydGqbgWhT8fIqu9vJaYasqulzFhgjptnIgOvzvGaVZsB4Su2hBapqaRlCtECzO+5WpVJXtgzaN4EaJKn1jWlN9YAQBqgrR0gdn75HHLPxaoay/YnJj9edbMzWX1j+FYi/MmjvDzVNWCw+fyjOfTbRGJ8s/7un8UPkvJWQPu0QvdUotPqDpynE83sR7fbHBfqNkGocHAPNh6ALYPjRp53jRDSafcta3U8g3MhXpL5KGjog+VwiB1fPVWu59CV1Ux8tmUHDJXNpV+huLeKINH2wsMrMeJFzEpWg8Y6Cb7zPeA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|12121999013|8060799015|31061999003|19110799012|13091999003|51005399006|37011999003|8062599012|461199028|102099032|40105399003|1602099012|26121999003|4302099013|3412199025|440099028|10035399007|1710799026;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXphbkxKZ3krZzRtL21yeGRtOHdnejYxOWcyRmVWMHJBREdOcDhuVCtRZHZG?=
 =?utf-8?B?RzZzUkhEZzdpMmVnU1g5bWhXRjVkcjBVUmpDWGFNWXdPbzVIemlEMnRXelhs?=
 =?utf-8?B?UE1lZnZRTHJHMllYaUJQbmRaTlIzenJIS2hobzlwQWltd01ObysxZjErMC9u?=
 =?utf-8?B?UmVxRkV6TDhMTEdnSU5OcW1SeXlDV1EvbVc0cDZrWnVuY0tNbnRoS1BCYXRq?=
 =?utf-8?B?R0ZZdUI1M1dQMmk4OGxRS09TazBucFp2UnFSTXQ3UlY0ZEZCbStZUTMrY1Az?=
 =?utf-8?B?bEovYTBvQ1Q5UldaaWZpRUhmeno0WDNtdUNOZUdKWWlJMk1ndFRnWXBDczZa?=
 =?utf-8?B?eHo1QnlGL1VNTzl6NWNMNk5NanM0cEtwa1Z1K2Z6eld2NTNMWlBTKy9xN3NC?=
 =?utf-8?B?cGtPM0d3M2xHbndoaSt3dHh1S1BjUk5wM1prUG1EZ0FXV2FLSGNHSm1FUXhk?=
 =?utf-8?B?S3NGWGJNWWIxeFk0U2x1RjhES0lCcXc1SEVkVjBzYitodDRtRytYckJlc25V?=
 =?utf-8?B?SEprcS83RUVldEwyMUNjMDZ3Nk1lRWRsWlM5S0lTUXdodVV0UEErVkhFQlFp?=
 =?utf-8?B?M3ZkcTFpc0ZGTm1ncG8xSllQSnpNbzdSUTVoTkY2UjVHWFg5RndXSk5UTnkz?=
 =?utf-8?B?OVZLZFk0NXlYSW9odHR2Snp1YzFoVWxMM1Vkclg5aGMydDc1VHBNOXBmTUxQ?=
 =?utf-8?B?WE9WTzAvOWRWa2NXUWMxRFZEaHJmT0I4RTIyRGtRbThOa2d4a3F6NWxRWE1s?=
 =?utf-8?B?d2dMTTEvME95YmJPQnF2MmlVRTZVK3RKVUlYTUpYZ1I4VTQxK0IydkkvRjE2?=
 =?utf-8?B?V2F2cUswTk1Oek1yTXV4enJBZ2d0bWNyVFlVQ2JtSnVVc1Y3OTdLK0I4UkVB?=
 =?utf-8?B?allUN3dTRk9aQ3c4VkpKem82WjM4MDE2YnJodXpLY3ozanlaSkVpM3U2N3Rh?=
 =?utf-8?B?OXlCZnBkM2ROR0xlQzRwbXpmRXJRZ29KSU90RlBxTnVSK3BIZi9nS3lRdWox?=
 =?utf-8?B?b3JERXlDUWpOUCtmODBHL2ltV0lPdlBRbVd1aTBmR25SRVBOT3FCRkczT2w3?=
 =?utf-8?B?c1VacCs2aEFLblRrUU8vUWt4V0VsZjV1WWIxM2lMci9qQXRyRWJQaXRoemk5?=
 =?utf-8?B?SEFrNy9pRHpNeWFmbFg0NUROUTFZUWZEd2FXQ29KcVBGYW50YkJKeUpyWXBw?=
 =?utf-8?B?azhlUHQvTy9idkJ1RTZuY2dXWTdNRE5jRWNSU0E1Y1B4a3hVNG1uOWtMTmNX?=
 =?utf-8?B?MncyS3ptSi96dnFERkNKdkF6WG54V0ljanFjUVR4Y3kvb1U2TEsrVjlSM2Z4?=
 =?utf-8?B?WE5tOEs2RG03Q1k1N2YrdUFwRCtqc2hjWVFUSDVpSFRhZjBkbGVyZE5vRnc2?=
 =?utf-8?B?QUFPWDZUZzBhSDdqWEFzdkRiWjJEUWR6bnQ0REJQUVltYmpGZDhQNFd0Q3hF?=
 =?utf-8?B?NDZlQzZEYkpwYkNCYXY1YTd0U01XcSs1ZzBnWnFVSXFFc2p4V25vZ1ZXeXIx?=
 =?utf-8?Q?aR1ZHKNWdXUBM+WlFJQF8gissCv?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sk44NVRpOFNsQm5nUTBkbW9QYXZCL2RXOVBjOHZodDBrQ0R2eXp1dzBINWRU?=
 =?utf-8?B?ZzRlSlpiTG5LY0dlWjdwRkVOQldZbC8rVlRxMWZZL00yazB2SldWRVhaOGs3?=
 =?utf-8?B?YWJrZHZYTWd4d1dPdElxSFhSOS9VTkxKeDVnc1F0U1hHVDlqOWhVeHBqb0ZE?=
 =?utf-8?B?alNGbGwydWI0akxvcHZsZ1BwMzcxb3IyUzdoMm9jZFdQMkg3MlphcjRBT2Iv?=
 =?utf-8?B?T3UzeWFiOSsvbmZXZUQwR2hDaVQzcmJTK0grTzdhUCtuV0IyT3ZyYWVYa0VK?=
 =?utf-8?B?TjQzMmNYWGk2WFZ4TEcwNi8yNi9aT3NDOW5ZQkxBVVNSMGFUTWl2N3NKZTdM?=
 =?utf-8?B?bThHSWlaeWladW5abDlneEJFNy9pSkMxVWMySWgyanREdzRQd3F3OEdHV3d1?=
 =?utf-8?B?ZjJGVXNjZ2E5eUU3REptcDNzK2FqY2lxVmZ3dTZmZkxEKzRtWWVNcytTbk9P?=
 =?utf-8?B?TjVHSTkrSHpzQUcrRnVpRFYxbFdqT09wQ0JvaUlJeWFqRWZNN215MGlJSWU1?=
 =?utf-8?B?QTVGMnpzZGVGYk50M1A1NTFVUkVROXI2MHE5dmYyNTZjdnFESHRZZFpsOE5P?=
 =?utf-8?B?cUE2QVN2V1UxcC9iWkV4QXRGSWc2UUhSbjU2UTRLQ3lTQlI5eVdaelhQb3BY?=
 =?utf-8?B?NHNWdGFYMVRTZ1pPbW5WNTNtTXV4citLZTN0M0lROEsyNzhoOVg4cDRWTk1T?=
 =?utf-8?B?NGhmVDhSV3BjT3ZDdE4zSjZSajlmWE5BZ1J5NUdMUnF1NnZZcEI0UHFjdjNm?=
 =?utf-8?B?aU9za0p6anNvMWZpUjRkUWJDYVVLYW50ZWplQi9nUmpsL29wSzBDVkZEYnRM?=
 =?utf-8?B?ZDFVakFONW9lT3B1RnBwdlBPclBGOEFuMkxsU0JkTlNaUUJISUNmN2ROd0J0?=
 =?utf-8?B?Q2lCNmlqOU9mQzk0dmIxYkNnaStod29kallSRHVraDZ6M1BUR0Q0VmdRemZJ?=
 =?utf-8?B?TVJ3TWNzc3BJODA1Z2JkNG1FNmp6M0xpQkRTV1poVlBzZlVVU3RWa2xqMWYx?=
 =?utf-8?B?cVc0dnFLdlFBVVRqZkRkYjVBSHhKdHNCMHcyQm1BT2VuQ1Q2bUtDbjNpYkdz?=
 =?utf-8?B?S05WcXF0a0M5Z2ZTNnlEY1hjK21SMkhCRmcwZTYreTkwd0J4dkl4WjBoMTNT?=
 =?utf-8?B?TUIwNG5tL3VCTlNkaVRlQ0M2YzVxT3ovekdpcm5wdjNSSGtZNS9VekZiWklr?=
 =?utf-8?B?RGQ2ZFBkQzJRRjZnU2o5SUYxTnR0NWJtRWVQSlFxcy9HMmdOUWhTVVlyN3hu?=
 =?utf-8?B?NkpmRjNLelJmNldYVDNwVXEvMnB0cUg1YW5XbHAzdjZFOFlGcEVwbVZtdXFv?=
 =?utf-8?B?dG5HOXFLVHQ4aFFGeVR2RlVKR3p6WEdFQ0h1ZkZ3clY4ZGJPOC9FdEpnbzNE?=
 =?utf-8?B?bjk5MWszYzBpaXZrUjFnZ21ISnNzc1dvZ1BVVDZyUFZVcTREdUwrSEVHcjFl?=
 =?utf-8?B?dXRFbUcxajdpUkNBQ0R3WDBhaU02TFUyZXVxQWhaSXZ4ZXNURWVHZHV2cUxY?=
 =?utf-8?B?UG9CWkxNQ1I0U2ErV04zQzNTdEdIdmRmUTdkVDVhZ3FRRXFRZ1E1R0FBTmpk?=
 =?utf-8?B?dE5TUlNNS0ZjSmFXRG5aeGluRVZmN1YvbTh3MlhLVnZSK3g1bmJqTHdoVjBO?=
 =?utf-8?B?K0tYK3U0OXFNaXlIRXF4TURhN3hLWHpqTVI5SWtQSkVEWGNaeDZNY1o5bFRG?=
 =?utf-8?B?ckJ6c2VXYUZ2cWZLR25yNFhjdUFFbkd1ZHZvTjd3a1hpSEI4dzdGZE5yMzBY?=
 =?utf-8?B?Y2hHRjcvQklOZmhkc3E3OExScHQxZ2ZpeE5nN1pJKzhTZXR2S2tncGJtK0Rs?=
 =?utf-8?Q?eOy6r9aSc7IbRBPXrdNGA3qSl8LC3nZ4K9ujM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 34569c22-09d8-4a10-f18d-08de91a9c495
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 17:52:26.6692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10035
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233228-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,outlook.com];
	FREEMAIL_FROM(0.00)[outlook.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[outlook.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:dkim,outlook.com:email,weissschuh.net:email,sashiko.dev:url]
X-Rspamd-Queue-Id: D68583972B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0PiBTZW50OiBGcmlk
YXksIEFwcmlsIDMsIDIwMjYgOTozMSBBTQ0KPiANCj4gVGhlIGNhbGwgdG8gZ3JwLT5pc192aXNp
YmxlIGluIHN5c2ZzX2dyb3VwX2F0dHJzX2NoYW5nZV9vd25lcigpIHdhcw0KPiBtaXNzZWQgd2hl
biBzdXBwb3J0IGZvciBpc192aXNpYmxlX2NvbnN0KCkgd2FzIGFkZGVkLg0KPiANCj4gQ2hlY2sg
Zm9yIGJvdGggaXNfdmlzaWJsZSB2YXJpYW50cyB0aGVyZSB0b28uDQo+IA0KPiBGaXhlczogN2Rk
OWZkYjQ5MzliICgic3lzZnM6IGF0dHJpYnV0ZV9ncm91cDogZW5hYmxlIGNvbnN0IHZhcmlhbnRz
IG9mIGlzX3Zpc2libGUoKSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFJlcG9y
dGVkLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+IENsb3Nlczog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9TTjZQUjAyTUI0MTU3RDVGMDQ2MDhFNEUzQzIx
QUI1NkVENDVFQUBTTjZQUjAyTUI0MTU3Lm5hbXByZDAyLnByb2Qub3V0bG9vay5jb20vDQo+IExp
bms6IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDQwMy1zeXNmcy1jb25zdC1o
di12Mi0wLTg5MzJhYjhkNDFkYiU0MHdlaXNzc2NodWgubmV0DQo+IFNpZ25lZC1vZmYtYnk6IFRo
b21hcyBXZWnDn3NjaHVoIDxsaW51eEB3ZWlzc3NjaHVoLm5ldD4NCg0KUmV2aWV3ZWQtYnk6IE1p
Y2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCg0KPiAtLS0NCj4gQ3VycmVudGx5
IHRoZXJlIGFyZSBubyBpbXBsZW1lbnRhdGlvbnMgb2YgJ2lzX3Zpc2libGVfY29uc3QoKScgaW4g
dGhlDQo+IHRyZWUsIHNvIHRoaXMgc2hvdWxkIG5vdCBhZmZlY3QgYW55IGNvZGUuDQo+IC0tLQ0K
PiAgZnMvc3lzZnMvZ3JvdXAuYyB8IDcgKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9zeXNmcy9n
cm91cC5jIGIvZnMvc3lzZnMvZ3JvdXAuYw0KPiBpbmRleCBlMWU2MzlmNTE1YTAuLjk4OWVkZDZj
NmMyMyAxMDA2NDQNCj4gLS0tIGEvZnMvc3lzZnMvZ3JvdXAuYw0KPiArKysgYi9mcy9zeXNmcy9n
cm91cC5jDQo+IEBAIC01MTcsOCArNTE3LDExIEBAIHN0YXRpYyBpbnQgc3lzZnNfZ3JvdXBfYXR0
cnNfY2hhbmdlX293bmVyKHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiAgCQlzdHJ1Y3QgYXR0cmli
dXRlICpjb25zdCAqYXR0cjsNCj4gDQo+ICAJCWZvciAoaSA9IDAsIGF0dHIgPSBncnAtPmF0dHJz
OyAqYXR0cjsgaSsrLCBhdHRyKyspIHsNCj4gLQkJCWlmIChncnAtPmlzX3Zpc2libGUpIHsNCj4g
LQkJCQltb2RlID0gZ3JwLT5pc192aXNpYmxlKGtvYmosICphdHRyLCBpKTsNCj4gKwkJCWlmIChn
cnAtPmlzX3Zpc2libGUgfHwgZ3JwLT5pc192aXNpYmxlX2NvbnN0KSB7DQo+ICsJCQkJaWYgKGdy
cC0+aXNfdmlzaWJsZSkNCj4gKwkJCQkJbW9kZSA9IGdycC0+aXNfdmlzaWJsZShrb2JqLCAqYXR0
ciwgaSk7DQo+ICsJCQkJZWxzZQ0KPiArCQkJCQltb2RlID0gZ3JwLT5pc192aXNpYmxlX2NvbnN0
KGtvYmosICphdHRyLCBpKTsNCj4gIAkJCQlpZiAobW9kZSAmIFNZU0ZTX0dST1VQX0lOVklTSUJM
RSkNCj4gIAkJCQkJYnJlYWs7DQo+ICAJCQkJaWYgKCFtb2RlKQ0KPiANCj4gLS0tDQo+IGJhc2Ut
Y29tbWl0OiBkOGE5YTRiMTFhMTM3OTA5ZTMwNmU1MDM0NjE0OGZjNWMzYjYzZjlkDQo+IGNoYW5n
ZS1pZDogMjAyNjA0MDMtc3lzZnMtaXNfdmlzaWJsZV9jb25zdC1maXgtNzRiZDA5MjIzYTY1DQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFRob21hcyBXZWnDn3NjaHVoIDxsaW51eEB3ZWlz
c3NjaHVoLm5ldD4NCj4gDQoNCg==

