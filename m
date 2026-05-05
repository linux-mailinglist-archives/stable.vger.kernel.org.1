Return-Path: <stable+bounces-244177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ne/ItoF+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:59:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3494CFD79
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 576DD30672C9
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2E242317B;
	Tue,  5 May 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="jd30bID3"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643E282F13;
	Tue,  5 May 2026 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993056; cv=fail; b=JM6TuwDYspiJuMKY8O9P1OL37LwQPmHYl4mQihUmC13JlEKM9Ey9WfmFTSXEeLOmFO4NeEpIrrpd6CUUboSJ5AkoxQtpRjBKySaMiSQffBXuTOZ5NapJl8jTG3LohPgMhRxWfJCW0rQ/mcQSS87N5YJGeq09hNLdTSX6ohfiGm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993056; c=relaxed/simple;
	bh=cmXv6wLIvzWdScYK0LF8kkoyqwELAH/hAfkkNwwTSpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ltQfy62UcNyq/5VSgKBhk+AYzr+OxB1MKh/W3tNiQ2aKdueFAHMDAmylf+oqN3BekEzYnYR93muts1A7mxXliriNxuqN3CNeGHugVSwZWR/rfSwBAK63JfkWOM0f3jUByHcBwdA8ardPE8ElQgDXidELSCXX4kQ9tChZrp74yeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=jd30bID3; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5THkNi91QEhnFDsfyRc7i5AAvDaDq8D5H/YBx1FlkO7vYP/TI5mkvXYbe/wmI3vZ6WI9c3x977XFx/qJWcFa2wqVBhi+qDg8EAyK9zhQhvrFBMZnh6pTMunNJAdX91a19nSSTbFCthL3HXCCY2osL8HnxdChqyDZGM0OShZCtSjOp8jAdtRdYJ8wsO07btlrhleNrgU6AFO3IDlnOLx1TLOeMneiqQsSnpzdVSLceRgrNhCgFdya3X85RYB5Ax/b4kud4a3Cog3ISI2sq6OuTcyE2YCy5QCCryqE28rK+KQkP5CIiWTa07TQLYur9NKY7JMMRPKDY4Oo4cdIVThEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmXv6wLIvzWdScYK0LF8kkoyqwELAH/hAfkkNwwTSpI=;
 b=V6w136SpABnDnKCtsVAtzPt/d+NUOgOp1KmM2hCNTEAtQv1Krn+WxRYNLFOFxrN1W7oaI0nDXd2Rdl3zEOzSFduHffCF+X1VHPYEnkITzs2DCyju1Sr9o+qrsdu8D9liHqX3PxI2sSbZ7lRpLGXkmnf49/D0FJWVsZ4Tm9u6LaLfBIy14mGnqWy7wNCUjvxmW/SCO4woLdr9Mej5vWjSEgnZYzd9yCjjyw48RTA9NyUeIsz3/hnJ3oXb8iDIeaZ9DuNceN6QSW6Innp/5Ksuiof85n6i56521tqBwviVhFTvdYXHlO/GdSduvFbaER5TUl3dLN88a2ULBLr1yiHkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmXv6wLIvzWdScYK0LF8kkoyqwELAH/hAfkkNwwTSpI=;
 b=jd30bID3xz0dKYfu1VqxX2rVhKear09IP5cyCUIG4SyVhqFpXFACibFzITWcwR/LDwXJS5nvKVlbGzVzagHZCoY1a1i2/SMqWi/Dljs3TwRFB6fanE5RQRJpxyX0g2C0WGKe42lWDZGQWti6Lz45INSojVzEo8oQ4AMLwaGeN3TBV4F4rcSCnAhXuYg7bCRjOOL4iHAfEsn/p+Z+5MNbh2DEm4vO0QfiA5FRHgDvz0bML9NA0oCLJ9T/4M6vXeGvI6za5QdpCzcu2JKzlJK+2/I/HRaq9f+olmwKjKNc/wbw5i8tFsUQqveley1nXTFR1Y14mG4Nf4zKBvRZ+8sTew==
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:39b::19)
 by DU0P189MB2018.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 5 May
 2026 14:57:31 +0000
Received: from AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4]) by AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
 ([fe80::69fc:c4d4:200b:e4b4%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 14:57:31 +0000
From: Yunseong Kim <yunseong.kim@est.tech>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Chen Zhen
	<chenzhen126@huawei.com>, Jussi Maki <joamaki@gmail.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Paolo Abeni <pabeni@redhat.com>, Malin Jonsson
	<malin.jonsson@est.tech>, =?utf-8?B?RGF2aWQgTnlzdHLDtm0=?=
	<david.nystrom@est.tech>, =?utf-8?B?Um9sYW5kIEtvdsOhY3M=?=
	<roland.kovacs@est.tech>, "ysk@kzalloc.com" <ysk@kzalloc.com>,
	"42.4.sejin@gmail.com" <42.4.sejin@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Topic: [PATCH 6.12.y] bonding: fix use-after-free due to enslave fail
 after slave array update
Thread-Index:
 AQHc1bj77gFL/C3sNkacAb6ql69PQbX90UuAgAGZQwCAAAFVAIAABL+AgAADbYCAAB97gA==
Date: Tue, 5 May 2026 14:57:30 +0000
Message-ID: <4a86e614-bcf0-4bba-b9f4-d0eafe952544@est.tech>
References: <20260426201205.465809-1-yunseong.kim@est.tech>
 <2026050435-glider-undrafted-71d7@gregkh>
 <59f615b6-eea4-4186-8e63-d60a57ed7822@est.tech>
 <2026050517-parking-pyromania-70a1@gregkh>
 <898a7348-f15f-4c4a-a5ca-d4900a0db606@est.tech>
 <2026050516-finite-roman-d056@gregkh>
In-Reply-To: <2026050516-finite-roman-d056@gregkh>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P189MB1752:EE_|DU0P189MB2018:EE_
x-ms-office365-filtering-correlation-id: 5bdab42a-5014-4c4b-8daf-08deaab6a1b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 aI/qOHbsVoMvC3f6djuMN2RWhbmWCL2ErbXOn1Q9dtquuTPutoN/mVAS+7IUvwhBpuTZX2ZGWGABRVDUW7mAtZW23V3U5HQ33k20oem8yALH+5UNDqaxt/gNJdQEnYMWddlP0hEHpEm8deyGls4+2XcgVCQiKDRhLrRW68TPDoIMi2ppG0Tvmg6wKzyWEWzfoTWHtF7lKejMl09OqIbX6q9QrbJl4uQT6JVValyHgoOzwhBZWrsJcYHyYjZSl2ev2XuaMC9vofVPu9C8vvtnQcoCCj81cRhvC+Aqi8lp2aZUDllKSk9D0k57JdIZ/j5PWKGBNvGXiCW5i0aT9eDYVuAk9SBx2yl6JUdkPDRIKuAgj/F1EtfL89N1PpMNSCUld77hsV8HIFTYeiI/q4j7iWPmGD5bRw6+5hM8fBg1E/4HCqJVOkYP3HDGqb+aJqcAqvDj2gLt1f0B1gSetfg9Pvmr0H6txn+iW/BdrMYr7skaCOaCjZFESP4iC/38gW4znE7On2+sx+mAcCTqLinKvelGHyp02AR/9vPYwFWyglYHMEOhbH+PNaaLZJGs0yw7jh29WTUYyBhUWmlb4aPDs0zX2ls/1LNT3XinqvSN+VQs5Rt1S7RTuauzoVYwtHTEMogmzVgXBilWppwNqy32n4f2ogdRqrxZE8/bDU+vk8UeaGe1npYK/9mmE05vttnp3lclsHYFd01iveIef4zgXX/RlhYY9HRrnWcaeAW7PXS2aGLwUEPQ4xu3k7CKXZ1R
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P189MB1752.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cTVORzc1M1hUM05ySlZTS041UDJaZGVTd3d4bWJzRy9odXlJeUFGMVV3cjdT?=
 =?utf-8?B?ZFBtazliVDBUOTUrVmlyMkZGaVZYT2taY2daSmtMUklCWHM3OXNYWm1ocDFC?=
 =?utf-8?B?b1daQUhXRGNRUEsxa2Vic1dXU210QVJna1N0TzBoc3NzeTRKKzBiY2ZoOWgz?=
 =?utf-8?B?NmtyejdWQXg5NHFkMzhibC9PcjF0ak1sOHI1WTlGZXRsdWUrUjJxRm9BYXZw?=
 =?utf-8?B?TlVFdmlJK3VsMlozb3NJR2ExRGFJN2Yzd2F2bS9EcHF5dWliT21CWDE1cW9q?=
 =?utf-8?B?Zi9tMzN5enM4QUhKOFdXMXRvTDdnQTB1cnA4RHpoNW13OE5UeHhudXd6UDN5?=
 =?utf-8?B?NjhjR05OajREYVBwKzUvQmxXLzBuamovbmlEcGFsZXJEY1JMeDF1eXR3cVQy?=
 =?utf-8?B?eEo0TEwvSFN3V2tGNE91SEIzT2hpYXdjWG91ZC9YVDRSOHBORU5aUmVLaGpY?=
 =?utf-8?B?WEZxQ1l4d0IzZzZGUTdWWFZBdzVaWXN2elc2SzdhTVJtbmxPYyszNlBwWFhw?=
 =?utf-8?B?RjZEdEpmTnozMm5jKzlGa1diTU53WFdmQVdZcEo4NFRGYk51VFJkRTZtZkxz?=
 =?utf-8?B?SWJlSXgwZzZvMUIvYVZOQ0JqZm9wQWwzU0QvM2lOZ1ErNURzR1U0WGpFbW5w?=
 =?utf-8?B?ZHhlL2t6eklvOHpTYklSUXlNWEpRWG5xSVVRazZIU3I5KzRodkFBZ0h1VDBp?=
 =?utf-8?B?ZE1aVGR5WGw1bExZdjlTdUd5eUpCODM0MUcrNFY4WllkcERuSk1qUEJRNWF4?=
 =?utf-8?B?czNyd0J3bHBQTFV1ZE0rRkVLc3BKNUNicmErWDFENGdHUGxQRlhzczRXdFRo?=
 =?utf-8?B?ZmJ1cnRsekxVb0hJRGtwNXF2YVQ5Wmo1NjZqYzBwWW93NEx4QUYxS1ZDTDZv?=
 =?utf-8?B?UmxyaDkzbUQyRUF1REc4TU0zU2R0Mm1Db0VUR2RiVnYvOVc3aVBJbjVvVllK?=
 =?utf-8?B?aHprUDRYUGdBN1FJWUhyakduVWxhSmRpMDY4L0RmMk8zUVNTZW4wZlZBMHg0?=
 =?utf-8?B?SWJ0dENVY2NMVC9xd2J0eEt1TzY4N2lMSXJWNEhJQzZQeHpQT0NqRlZzcGxF?=
 =?utf-8?B?VDgyZ28xL1pDYlU5OHVmUy9VUGZLT3dRT011aDY3TGFwUTUwdktCRjdLQStm?=
 =?utf-8?B?K2grRzBUS2RIclo1dDAwalQ2TFVlN1I1eVdvZ1ROL0M5a3lUTTc4YWxRREtE?=
 =?utf-8?B?ZzVkUzVUUGxNWmpyUWFvUTNnOGR2R0QyYjlhK1U0RW5lNDBMRCszWHgxZjZk?=
 =?utf-8?B?TS9WK3pHb3ppaW94cWljMGY3VVJDU3U1cnFIVUY3NGlWVnpTQ05VMWpzcTVW?=
 =?utf-8?B?VlFJa3BLTkxaNnpqeGpVZmJhLzFIODJSRk9lWlVHWSsxdGdSNzdzQThaSEFC?=
 =?utf-8?B?bDduSFY1WnZpLzJENW1UdDZkU2ZlbEh1dDlQalVjZHVlREwybXMxL2NPQW1n?=
 =?utf-8?B?NlV5N0p2SVlkeC9LVXlPUkc4cDl5ZVZiaFpQNXpZRHFicWw0eDhRdmd1aEU0?=
 =?utf-8?B?MW9hdnpFaTRJeG1STmhnYk9mWXVwY054My9FSXlnT2EyNVFrSW5ZK3Z3WjAz?=
 =?utf-8?B?bloxRGxNZm96YjFrMzNyNkNJUGlnaWxnMFpqNXlPRkEvWGY2cFlHUndIdEwz?=
 =?utf-8?B?dE9RdW9xYXk3MkpjV3NzMUFjc0l3QjE4bTl3aFQ3alBGQkFRa3UrcnJYNFZR?=
 =?utf-8?B?bGhBRUVDN0tYL0Y5T1J0K29RSEx2NDBWa21lSlR0RVJwOXZGMTJpQWRBRytu?=
 =?utf-8?B?L3pSdFg2ZFlLK0NpeGZCNG50ays1TzgvUFRTd2dLTzU5R3VMb2o2U0xMYzls?=
 =?utf-8?B?OWVQV1I2THhYOHIraktaQTgrY1hsUHRQM3JpVmRnempxOFlTZGVVVHAyd2I1?=
 =?utf-8?B?V0hhRklOcFlvNHAxbU1xTk9sT2tIaC9lZEJ5ZmhuQ3gyemJUUXV4VkFHeUZM?=
 =?utf-8?B?bkpNM0pDMDg4eFlrdXNqRHpheEpNUUg4cEVWS0hUSUVOVHlWcHpUUXBJMkZU?=
 =?utf-8?B?SEVZZXNPNUh0WmdoNGNSQW53eG02OEhuU2EweWowYzMzeG1ZU2R1NUhVRnNP?=
 =?utf-8?B?TCtUUG1MekxpcExudjVISWRYcThDTXZLL3ZsTk4wY3RjWHpNSXIvQ0M3QWhV?=
 =?utf-8?B?dzh1WXc2RXZwVVFTL3NEdDVVUURLMWpIRnNSeUNveUJUaFJ2T0lFR2grbTA1?=
 =?utf-8?B?R3lRdEtEazIwY2FtS3I1UWlVODg5ekJlZjZCOHBRVTBPQlErdEVsRjBlSWtK?=
 =?utf-8?B?R1NmME5DVnl0ZjNZbTZpOENjN0d3bm81dHRGMGR4aTdVU2VOTWhJNXNROHdI?=
 =?utf-8?Q?Zp1TsqDaSL6Iz/fGEV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92049707E4B0DD4A86A014C06E19F919@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB1752.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdab42a-5014-4c4b-8daf-08deaab6a1b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 14:57:30.6731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1mO6dwwwKXzslw7tQKzdIciF+ByW8HKhNU3srEcSvgMVy4KI6bwBfGtkIT8tE0UBYWA/9qggu+yUxb/pp/hPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2018
X-Rspamd-Queue-Id: DB3494CFD79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244177-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,blackwall.org,huawei.com,gmail.com,iogearbox.net,redhat.com,est.tech,kzalloc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yunseong.kim@est.tech,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[est.tech:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:dkim,est.tech:mid]

VGhhbmsgeW91IEdyZWcsDQoNCk9uIDUvNS8yNiAxNTowNCwgR3JlZyBLSCB3cm90ZToNCj4gT24g
VHVlLCBNYXkgMDUsIDIwMjYgYXQgMTI6NTI6MzRQTSArMDAwMCwgWXVuc2VvbmcgS2ltIHdyb3Rl
Og0KPj4gSGkgR3JlZywNCj4+DQo+PiBPbiA1LzUvMjYgMTQ6MzUsIEdyZWcgS0ggd3JvdGU6DQo+
Pj4gT24gVHVlLCBNYXkgMDUsIDIwMjYgYXQgMTI6MzA6NDhQTSArMDAwMCwgWXVuc2VvbmcgS2lt
IHdyb3RlOg0KPj4+PiBIaSBHcmVnLA0KPj4+Pg0KPj4+PiBPbiA1LzQvMjYgMTQ6MDUsIEdyZWcg
S0ggd3JvdGU6DQo+Pj4+PiBPbiBTdW4sIEFwciAyNiwgMjAyNiBhdCAxMDoxMjowNVBNICswMjAw
LCBZdW5zZW9uZyBLaW0gd3JvdGU6DQo+Pj4+Pj4gRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4+Pj4+DQo+Pj4+PiBJIGRpZCBOT1Qgd3JpdGUg
dGhpcyBjb21taXQuDQo+Pj4+Pg0KPj4+Pj4+IFsgVXBzdHJlYW0gY29tbWl0IGU5YWNkYTUgXQ0K
Pj4+Pj4NCj4+Pj4+IFBsZWFzZSB1c2UgdGhlIGZ1bGwgY29tbWl0IGlkLiAgQW5kIGdldCB0aGUg
YXV0aG9yc2hpcCByaWdodCA6KQ0KPj4+Pj4NCj4+Pj4+IHRoYW5rcywNCj4+Pj4+DQo+Pj4+PiBn
cmVnIGstaA0KPj4+Pg0KPj4+Pg0KPj4+PiBUaGFuayB5b3UgZm9yIHRoZSBjb2RlIHJldmlldy4g
SeKAmWxsIGZpeCBpdCBhbmQgc2VuZCBhIHYyLg0KPj4+Pg0KPj4+PiBBZGRpdGlvbmFsbHksIGxh
c3Qgd2VlayBJIHN1Ym1pdHRlZCBhIGZldyBwYXRjaGVzIHRvIHRoZSBjaGVja3BhdGNoLnBsDQo+
Pj4+IHNjcmlwdOKAlGN1cnJlbnRseSwgYWxsIGJhY2twb3J0IHRhZ3MoZm9sbG93aW5nIHN0YWJs
ZSBrZXJuZWwgcnVsZXMNCj4+Pj4gT3B0aW9uIDMpIHVzaW5nIDxzaGExIDQwIGxlbmd0aD4gcGF0
dGVybiBhcmUgdHJpZ2dlcmluZyBmYWxzZSBwb3NpdGl2ZXM6DQo+Pj4+DQo+Pj4+ICAgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI2MDUwNTExMjMyMC4zNjI3MTUtMi15dW5zZW9uZy5r
aW1AZXN0LnRlY2gvDQo+Pj4NCj4+PiBDaGVja3BhdGNoIHNob3VsZCBub3QgYmUgbmVlZGVkIHRv
IGJlIHJ1biBvbiBzdGFibGUga2VybmVsIGJhY2twb3J0cywgc28NCj4+PiBJIGRvbid0IHJlYWxs
eSB0aGluayB0aGF0IGlzIG5lY2Vzc2FyeS4NCj4+Pg0KPj4+IHRoYW5rcywNCj4+Pg0KPj4+IGdy
ZWcgay1oDQo+Pg0KPj4gV2hpbGUgcmVhZGluZyBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3RhYmxl
LWtlcm5lbC1ydWxlcy5yc3QsIEkgbm90aWNlZCB0aGF0DQo+PiBpdCBkb2Vzbid0IGV4cGxpY2l0
bHkgbWVudGlvbiB0aGUgcmVxdWlyZW1lbnQgZm9yIGEgZnVsbCA0MC1jaGFyYWN0ZXIgU0hBLTEg
b3INCj4+IHRoZSB3aGV0aGVyIHRvIHVzZSBvZiBjaGVja3BhdGNoLnBsIGZvciB2YWxpZGF0aW9u
Lg0KPiANCj4gVGhhdCdzIGZpbmUuDQo+IA0KPj4gV291bGQgaXQgYmUgZ29vZCB0byBhZGRpbmcg
dGhlc2UgcnVsZSB0byB0aGUgZG9jdW1lbnRhdGlvbj8gSSBiZWxpZXZlICAgICAgICAgICAgDQo+
PiBmb3JtYWxpemluZyB0aGlzIGNvdWxkIGhlbHAgY29udHJpYnV0b3JzKGxpa2UgbWUgOikpIHN1
Ym1pdCBtb3JlIGFjY3VyYXRlICAgICAgICAgICAgICAgICAgDQo+PiBiYWNrcG9ydCBhbmQgcmVk
dWNlIHRoZSBuZWVkIGZvciBtYW51YWwgY29ycmVjdGlvbnMuDQo+IA0KPiBXaGVuIHlvdSBnZXQg
YSBGQUlMRUQgZW1haWwsIGl0IHByb3ZpZGVzIGZ1bGwgaW5mb3JtYXRpb24gb24gaG93IHRvDQo+
IGNyZWF0ZSBhIGJhY2twb3J0ZWQgcGF0Y2guICBpcyB0aGF0IGxpc3Qgbm90IHN1ZmZpY2llbnQ/
DQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLiBJdCBpcyByZWFsbHkgaGVscGZ1bC4gWW91J3Jl
IHJpZ2h0LiB0aGUgaW5mb3JtYXRpb24NCnByb3ZpZGVkIGluIHRoZSBlbWFpbHMgaXMgc3VmZmlj
aWVudC4gSSdsbCBtYWtlIHN1cmUgdG8gZm9sbG93IHRob3NlDQppbnN0cnVjdGlvbnMgbW9yZSBj
YXJlZnVsbHkgZm9yIGZ1dHVyZSBiYWNrcG9ydHMgd29yay4NCg0KPiB0aGFua3MsDQo+IA0KPiBn
cmVnIGstaA0KDQpJIGFwcHJlY2lhdGUgeW91IHRha2luZyB0aGUgdGltZSB0byBjbGFyaWZ5Lg0K
DQpCZXN0IHJlZ2FyZHMsDQpZdW5zZW9uZw0KDQoNCg==

