Return-Path: <stable+bounces-230485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIcyOjhRxWmD9QQAu9opvQ
	(envelope-from <stable+bounces-230485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:31:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F5533797B
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58BF4305C8DA
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975743FB7C2;
	Thu, 26 Mar 2026 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="CBVpQ6Vh"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011035.outbound.protection.outlook.com [52.103.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057753F9F40
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538337; cv=fail; b=YiM0kQY77S2i+jxmow7FwZ3xc58iF0uPrZ7agxR95d+Y3UEadrAjzC3eGW0hPedrW7pVFg2sAZzrfR1vaRO9ayv4UDlxwa6GU3VJBedB+6zU4GDkF7eGv7+PKkdJb1FF9Cs8FhPz4zC0asOqEQ+tkpdriDUShPJIReOw5dO3dxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538337; c=relaxed/simple;
	bh=MAOG/0F0/3fhJGNuIgK5GKkPMZ+y+OE2cY2A948Ms+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qn0n7ocqbcK2s8MLPoQNs3cvpCKUAaRXmZi4+PqWYbDSMt7hZl7FDX/3MiFa8VoM2UyP2FEtEQzOfLrqYcW0QmlEBd5kNmK0BPYC51NrmXevPLfyvKhcKC2DQNPLPSunHmjzfdaCT6EevyBJZLc/Jgs9CIo6m+eofwYjO1WZLw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=CBVpQ6Vh; arc=fail smtp.client-ip=52.103.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoDAntvDh4UZtc1o2joWgWrZHAGoZIMeXO2A+U7UV82+5Yj2Yrop+hhwB21NG0HYMdK7nRTRmP26dW3qDpNPxAY6Mqd5d5JtVpQiwr79cO62xXaNTsMwucrDrLGxoeTFKc8Sx5OJ3U/CewVz/LEDEvC2o0ejeyIGN8YLnr3lu04wHBlhT5AW/dI+JRVlom6+bTHEaPhvPkHNhwZjTOCMY+Vk2yfwmNAUxj+EFbc+MUpCbe21sVdTtVsRWEwayctV8JjxXGbb7cksHciovLtFTddDbt90o9MhE6jaqZQnlpH7cros9OJMMLaJZ4/yEWHLYH8pJRe0U6NI2qvMD6bdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAOG/0F0/3fhJGNuIgK5GKkPMZ+y+OE2cY2A948Ms+0=;
 b=ciC8gUJLruqQ1Jg7MUxrFf/RYjK0SpGGAm7ikufaWSRgfHzLyvEeFxhs4PzmcXQQIHrAjnLtDJjHprqF2akV7oGIQ2dBnS+thQshj4a/7te31BOuKBcCrhSrG3w0wQEySG+wKzVQvemhIRQ5swt4u9aB0NBsaeHvbCZdQdq5ucQOlTeYBGPfMhQHGt/aTSkhEUCDt4dFOqi5TyjyMRKqDXvDTd0JqqE7qjiG/oihuJTbV5qvt0duAsCrr9+0UaEnfrTZMzChF4pUi8Hlabm7dYB+FkfgvmTWs1sHQLmqSqXTwIWXIIIj6LY6V+COuhsRiVz2ZE8EZF519Oi8NVmW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAOG/0F0/3fhJGNuIgK5GKkPMZ+y+OE2cY2A948Ms+0=;
 b=CBVpQ6VhuwQMnUrPT2nGGXDLwBpIqTuLPJ8+ypOSCB0qTFj0svlQpXi5BjhaUEaKGLNU9yBSNNwtSM8mD2G77lVp5nwyGLkrK3a5rGaMbNK+f9qIDpxmEfwg8CLW7RBjS0gZ77XKY5bNzg4VAHfU9/5AKuD0ic+CU2ULaPaB5PDbqpeR9jpco0cR+0npp02zSjlt59MScbIhpyOsKnmfekhqkY8o8I7Jd+bW015KUMvzj1HIU1xALqdFQ2JhXBtN3hRdXrAAyUHS81oTh1SXM8gaFKXK8B1N4z90mGgQiuXhzjbJzZ6eUVkTYir7S5hfZ9WITKvVTOhEryLzAWjcEQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN3PR01MB10377.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1e4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 15:18:51 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 15:18:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, Jiri Kosina
	<jkosina@suse.com>
Subject: Re: [PATCH] HID: appletb-kbd: add .resume method in PM
Thread-Topic: [PATCH] HID: appletb-kbd: add .resume method in PM
Thread-Index: AQHcvTARaIW+BCtVfUOoDarvSyrwnLXA7OqAgAAAaeM=
Date: Thu, 26 Mar 2026 15:18:51 +0000
Message-ID:
 <MAUPR01MB11546B684D5455A56838A777BB856A@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <20260326145134.1371-1-gargaditya08@live.com>
 <2026032613-childcare-exposable-3a75@gregkh>
In-Reply-To: <2026032613-childcare-exposable-3a75@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PN3PR01MB10377:EE_
x-ms-office365-filtering-correlation-id: c70157f2-3380-4e2a-cdd8-08de8b4afcca
x-ms-exchange-slblob-mailprops:
 9qw5+ftluCCm9yoJ9fgtGwzhjjsJDn+q4D6WCmt86pnVeI4NCy1sb8tMYdaRIyS4Tgf9/9OVRkkmr14tpGD+08mvIOMBk2K5RFWN/+m7rYyvl5H89815CQd0WmAnvvGEsT+3D3qLThh2OkpiXPYPrK2gTWmsKgV0WXAYEsWhnYTyyxEbJo82PKKNHHsAYXCrcB4fw8eklYiHWUmqgOOKLAwYaOWCVTXi3RJ+EnlYmwfNgC4HuLZSDFpFdVrhO6BRrvVkO6vzBa0lXTM4F0tPQvgm2Wwxn4OqnpNcTt2MtSZmeM+UbUcjZycQS0ECSyGPQqmXaBG0hsvnAJ7yfnUqgTCn7GVBd18f4cb81qu3iwRik1TXDgM0QZ+4VGFN2IgrEinXsmqGWYVmkicEfP0b7lA6ZJ8SGcTJDHsjlhiv/igVPKhBBzAYLkvI2fDlto3oHLQJTt51O/2WtsipYTFHa8I2TOC8gWWn4HTlsHwKha1GEOpR9OO0jbGxWgLRrgZxsJggJ4J6e7ar0oNSeIghcvcQTPiRUV6VbYdgYUZkLseP7Flt62WANmTrKdLK0oYUBS71c9RZ5vc8F2h7jQa8rc7o4/npOiZx3ZQWET8fRwBHnp2WIoTftYBSGcwVJhwvNXPtMgnpcUD/s+k8vaMuWCz2dPWEHVAZc8UjRogQk6mdw+pPMOqjHvxcBKDeGZ3M6ja2Gi6BLJo=
x-microsoft-antispam:
 BCL:0;ARA:14566002|14091999006|51005399006|15080799012|461199028|31061999003|8062599012|6072599003|19110799012|8060799015|25031999004|102099032|40105399003|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkEvUWRiT3ZWYzlFS205TG4vZGVhcUVyd05JRHFLeThEdHJTT00yQWFBUllC?=
 =?utf-8?B?elFmZlR1cW11VGpzMlQzZWdSQVl2UVUwOGVWNk84WVl1WnpwZjZaTzdaTlNY?=
 =?utf-8?B?eXJzVG5wTGxPVUpIZVhWN1FPR3BLdTJrVUsrOGgyNkhmV3RhTk5RdjFrL3I3?=
 =?utf-8?B?R0hDL2s4dTBkS3lSRmdDVUdGYVY1bHlQWUJGNjc2VGpRYUFwVjB3d256T0Nm?=
 =?utf-8?B?akJtSkdic0RtTXBST2xSd1FVOEhCRk9ZYmZHbFpBRVlBYmZIdG5NQjVrZE95?=
 =?utf-8?B?VWh6M1J3ZkYvRi9KV2dMelVhSFdnOVZmUHJRSlFySWdweHlWL0E4d2hWaGVn?=
 =?utf-8?B?eHFHVjFSYm5DUDhCZlA1cVVLQURpanZMS21YNncxL294NldBbXE3VFFUbXlV?=
 =?utf-8?B?WVIzV1lHY2Yyd1BRaUYzS3dBSDZXN0ZadEpyZGI0VmRtb2R2aVE3ZXJZQ2U3?=
 =?utf-8?B?N3FJOVpyaE1OZmFQVWpCeE9iL1hNRlFzS2p2czhWSXM4a0tpR2dtRENSODBi?=
 =?utf-8?B?QldJVGRpK1h3Nm1uVU1FOGlMZ3ZhRDV5YTUwSzl6Tyt3MXlCc2NRTCtHdklZ?=
 =?utf-8?B?Z0RFdnQ0SDd3MmJRTGREVWNaeDFvek0zaWNDK0Q3WThhNDM4bnlZQVZTY3Vk?=
 =?utf-8?B?YzVrZkhhd2Nueitxa0l1NGJnWmlXSWNiR3d4UE1yWUY4RDBtSjlxYUtsYndN?=
 =?utf-8?B?RlRpSDFaNlBURmVLV09pVEFOVGFLbU9UQWM2aXZ3cFAyN1VoMFZ1QTZ5OCtj?=
 =?utf-8?B?bEhwNVZrVXRjc2FVRXZUeWxNUXRpL0h3NGVRaGttZlJ2ZTJuR3gyNUwzT2U2?=
 =?utf-8?B?d0JQaldhZnV3TGY5OWdLSCtUUElWUDRXOVc1UXU3Z3EydEV0NVU2c29tMkZK?=
 =?utf-8?B?SEJpZEFNc3QvTW5FL0lDU09wNWJDMWJ5NFNJcTNFUjExZDF5TDc3anZCSlIx?=
 =?utf-8?B?Qit5WVdhWk5jbXZCRDE2OFdHYjc1Z2FaZERoNjNCRWlWUG9mb2NDbHZLOEhs?=
 =?utf-8?B?UXVwSEhqcGptN05ZK3FJM1RQSjlLV29qM2tWV3NVNzNYdG1sU2tibUh6Rk5t?=
 =?utf-8?B?dlhjUFRPaU9uOEoxc2NUS1BnM0wyWXhQSi9wVXVXR293WXpITEw4dHY1VS9Y?=
 =?utf-8?B?L3M0azRWeXBWU1pRYzZFZ1N2MWhjMmFXd043NDBBdVpVbStJYkMwMVFUYWwy?=
 =?utf-8?B?bDg3aW1BMHJXWlZjWmN1ZW43bHowRzc5S28xREdjTTdpajBpVEMvOVNhZ1Y1?=
 =?utf-8?B?MHViQ3Z5Y1doUDJGS3NpVlhJV0J0Y0FtRnFmL2N5Nm1lVkVxS3pTYi9ORlZz?=
 =?utf-8?Q?oo6IeXUAz9pSuPANzxbi+5Ez7DMXyHbRLZ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkR3MGdRUG91SWU4eXJUY0NsaHVneHZqYVVHUDJvNXU5MW5uTjlHQ2JhQldJ?=
 =?utf-8?B?ZWRXMGU2OVUvcE55ajMyVVUyRlZ5dTZvZzY4ZnZUb2RqSFQzMldDL2xWTWxj?=
 =?utf-8?B?UXZEWkZOTmJ0SkRFa3NtSDRHU25lK0hMbHF4V2xmKzRHTXd1ZVhvMlA0NFdv?=
 =?utf-8?B?UFRpR3NLTjY0WVd0bVkzb0R3cENkdmw4c1lVMW5zZHFLbklyRDNkdkpNVytX?=
 =?utf-8?B?dUMzNGJhR0tlSlpVNUdKVVdnZGpoSlEyOU9CUzJFbWhla1gzUHc2ZkxkNXBD?=
 =?utf-8?B?dWN3dDI1VTFkVkgxZmtZd3JzcmdmWmFyM1ZWR3NzZzI3MVRmZlh6S2MveEdO?=
 =?utf-8?B?NTlJNHFzaUYwYzkxTkZFV3RYUmJtS0s4UVA2eVl4ajZYMUxqTVNQaU52Nk95?=
 =?utf-8?B?THo2ZGg2aGNoMmY0L3NPY0xBRk9GV3M5UCsvWkRCajRGZHhsOVRFNGxJQkFy?=
 =?utf-8?B?djg3OWh4NithVk1ZaHlEMnpMc2w3aU54SWlWZ2JOdGFpTXNxTmFCRG9neXdF?=
 =?utf-8?B?QXp5U1lhR0hhQjY5ek1oQ1ZGR1dsYmRwUTJ3QVJjWG81NzEwOHErV0JSb2lM?=
 =?utf-8?B?b2Y2YUhyempnblB4VTJCVEMrSjVocy82OFlBaEhBQ05oZHhVSnV1Z09WZnZl?=
 =?utf-8?B?aGUybUNYN0FYUXQwMWJlVm5rNjB6Nm1ldmJNQ1VJcVBaZ3N2cUxiZThWdTk5?=
 =?utf-8?B?R0RBOE1IazJXdXhURGVqNit3UWU3TFFDVHRSUUtvN1N5UmtuQ3Z4M25vM01l?=
 =?utf-8?B?dGpnTlU5NEVyajlDVVgrQzhwck1tM25LNjl2VjBMZDZ3bC9lQUNJQUNOV2FX?=
 =?utf-8?B?TmFWRzIxbVQ2TTQrZ25RWi9xWUk2N2kweGExQ3BNcFBsSHljQWhWaWRQMmU5?=
 =?utf-8?B?OVQ0clZ6MkJNdmZIb0lCQlM1MnpLWTQ0WFptenlHa2JzWXI5K2hMOEJkWHFZ?=
 =?utf-8?B?SFViSmZUT01nMU90UE9Vek0vMzFGSlFCT284aG9OTlFhSk9QVHhpR1RlbE04?=
 =?utf-8?B?Qm1lNE9TWHd6M0FaYlQ4Q1dSUldCbnd5NnJwMnBTcUkxTGNHNlM2QmhGazdR?=
 =?utf-8?B?RXNseUFHSmYrQUZ0d2tTM1ZiLzd2RHBJcjJZR0kyUXU3Tnp6bG0wNHlaVWxv?=
 =?utf-8?B?eXltV2VOaHpDWGpUaFBtYmpHUUNiTW1Ha1A3b0p5UFgzWks1OFp6eVVqb0dM?=
 =?utf-8?B?QXdLWFNqRm03dGo3UzQ2aU50SDA4U1EyeWFXWWdkQWphUE54WXBocjVURE9x?=
 =?utf-8?B?WERPMHJGYk5DYUhQYkVzMnkxb09uZzJlZWxWMVUwUU83Q0VHM0JwZTVCYzA2?=
 =?utf-8?B?bVpaWlJiUWZoeXcxMExDUzVnT25EWTVWVk1rRjdQcHVUbldGU1NCNjlxamdo?=
 =?utf-8?B?QnFqZ3Vmc01adWQxR21NRGlYeFh4ZnpjSnVwbXN3QzBrKzVieU93M3k0aldO?=
 =?utf-8?B?T1luNC85TW1IVldQcXo3WHd0U0RxbkpBaHJuUjBma2NJbysrbGtKTE5rLzRH?=
 =?utf-8?B?Y0VFdHkrRHU5TGVUY3NsMGRTUlZKWi9MdDNzdkx0Rk1YRVAwaEljTEdCUnoy?=
 =?utf-8?B?NjdyMGlJbE9LdHdwb1hwTlMzVFcyRjM3ZnJ5T0M2ay9JYW1UQVdqNkxzVGtt?=
 =?utf-8?B?eFlsV0psck1ML2NHOVdFNFFPdHIybEJoeWk0K0t4eW1mMlRESnNSc2Q2QTNp?=
 =?utf-8?B?dFRKYzVBdFNCUkIvWHo1ZTd3ekdwODJIWmRGckJtNHRxdXhYOHZxc2FiSC8v?=
 =?utf-8?B?VkJBNU9sOHdjKzMwRFpIOEdBUzlPWWwrNjN2aWEvclE2Y3oyVnpkUmZqdHZ4?=
 =?utf-8?B?T1B5L1V5cmJDTkkwbDhybzZzaTliekpCNlBETUgrNTNkQ3dkV0haSGZOQ1BH?=
 =?utf-8?B?SGNuZk5rZkprTGFmTmx6Qk1XUUtJNG5rTUVnMmhSdGNRRExHZzhQZWxLVEx4?=
 =?utf-8?Q?tE6OKZvtI0YoyeQ3I8vAgyemiKPLSq+9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c70157f2-3380-4e2a-cdd8-08de8b4afcca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 15:18:51.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10377
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230485-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[live.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[live.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,suse.com:email,live.com:dkim,live.com:email]
X-Rspamd-Queue-Id: 60F5533797B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gT24gMjYgTWFyIDIwMjYsIGF0IDg6NDfigK9QTSwgR3JlZyBLSCA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gVGh1LCBNYXIgMjYsIDIwMjYgYXQg
MDI6NTE6NDdQTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6DQo+PiBjb21taXQgMTk2NTQ0NWUx
M2MwOWI3OTkzMmNhODE1NDk3N2I0NDA4Y2I5NjEwYyB1cHN0cmVhbS4NCj4+IA0KPj4gVXBvbiBy
ZXN1bWluZyBmcm9tIHN1c3BlbmQsIHRoZSBUb3VjaCBCYXIgZHJpdmVyIHdhcyBtaXNzaW5nIGEg
cmVzdW1lDQo+PiBtZXRob2QgaW4gb3JkZXIgdG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgbW9kZSB0
aGUgVG91Y2ggQmFyIHdhcyBvbiBiZWZvcmUNCj4+IHN1c3BlbmRpbmcuIEl0IGlzIHRoZSBzYW1l
IGFzIHRoZSByZXNldF9yZXN1bWUgbWV0aG9kLg0KPj4gDQo+PiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZl
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEppcmkgS29zaW5hIDxqa29zaW5hQHN1c2UuY29tPg0K
Pj4gLS0tDQo+PiBkcml2ZXJzL2hpZC9oaWQtYXBwbGV0Yi1rYmQuYyB8IDUgKysrLS0NCj4+IDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBXaGF0
IGtlcm5lbCB0cmVlKHMpIGlzIHRoaXMgZm9yPw0KDQpJdCBzaG91bGQgYXBwbHkgb24gNi4xOCBh
bmQgNi4xOQ0K

