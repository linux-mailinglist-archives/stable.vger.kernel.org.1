Return-Path: <stable+bounces-223125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGoDAdF2qGnxugAAu9opvQ
	(envelope-from <stable+bounces-223125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:15:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B72060CC
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C57230C0700
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 18:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36113E51FF;
	Wed,  4 Mar 2026 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NX6eEWrV"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D195B3D7D9C;
	Wed,  4 Mar 2026 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647476; cv=fail; b=Y92pb5X+E3bN8qxa9LQmxgm60v8E4WTniT1P6U2lrCPYvDX5cM6GTCT7L90cOZEWn2qEgPSNttFu3QSD2IjX5fYvoLamzFgEgWTWxJqIoGKKFgOvnPDW+XOR79qZVm7N6xs9TTnimnHDssW4Dd1G7/qml36WIqndL5vmo2VfrPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647476; c=relaxed/simple;
	bh=0EE61i8C7MM9miUoVX5iJR9ehBHrpQmwDTJCVq3+u94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gppEUQ66h1yOBAukp5HHjXKKgCUkuSq1tyHCchOYO11BUTxbRyMKc9R6czyaBvASCQI7BYpoMgPBEo1xB6jSpH1rPchpmOgbjqg8T03dkE3gG+iJWYFSlQ3rL0CKVj8RqUuWBVpMDDOeR135W1Byla0X8GEgh7Kwx/aKq4kkY3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=NX6eEWrV; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZD2szGDbzQLCB1tVCZf5ywx7ibmRmj+ZpXXm5Hv9M1yP9Q8Rl+Y2jSGWX3XkXnFQ5LbZ95nS+E12mYx9FjGkWtFXi8FM08+9hvxo9ZCzz4lMa7HQK92v9kWFJOgPw4jXgwqIowIGqXyj8vlb7heKw1q4CZNySzgAgyKYg1yU5GJ8P696IGfnQtibgxBZKmBf0B6+Nf+yJ+xGiout3Wpw5h/Qig+SL2qBPyOXE1K+WYouKpv29rbhhMZpkFmyNZpdYaiR5juv4WjMlFYpHajRi1rf024b52uK62M3nIItakUfPTJ4CSHq5010ethYbG+oU7XPc2V0CLh127IlfhohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EE61i8C7MM9miUoVX5iJR9ehBHrpQmwDTJCVq3+u94=;
 b=jqFY45t9IhjQr2cQMqQGpbq5l+wfKRNgtgnCOdIaTltaWt85+zQBlZ9efM6OClhD4VXGVTgAwCxFAlhS5irTxARBYp18qvKf+HDAk+2jkl9bIGZY5lqvWDCMwH8xJ1n6f/+BOA3BGsubinnP9xyqQ9Y9cWxephLL6LjH03ktsCK4VF+f8p1f+XclLAcTNn2kbNpq+u8BXBNxSZgQZzA7YLeO3bTeSHt0q0dGe1Abu5CFsWuzz2sFpaW2XmqJC++IB2zs8B/c9heHinyKFW+EbQk3ItRgJuYLksoYpW350aSXz1UQtUlv/D5cLx/aOg6iEelJ40Fo0jNDV5sSqJ2zAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EE61i8C7MM9miUoVX5iJR9ehBHrpQmwDTJCVq3+u94=;
 b=NX6eEWrVUa2UcXg1hzyLAN3rsGwAdvBCb78ZsWqLL9xOyLy8XatPhhkqPCQTdE+XMXMJKZDABTUjsGoyfN6074mE1gpGlj/o0GLo6JwJLNgzf/8iT6cfz/1EAdCqZkb4NPwQgeRlChIaKUF1swxK5w9zRsP+b76dOodiN+1HKW8LXVWO7TydJapkbQy/gFfVVuhPgJQTmAsjvDkdNngVrs98+F+r9f/E7K9ZT56BBRLxcu6HsbO0lakvkQVaR+bFaSMDpcWbTWdsL4y0df4vlZNusVGcDWhkC4v7t03SPNWqqK5kQDaE5e8s+1yH9Pbp/0btbVi0GcBshe6GgQP8hQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PNXPR01MB6993.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 18:04:25 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 18:04:25 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "zohar@linux.ibm.com" <zohar@linux.ibm.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, Harshit Mogalapalli
	<harshit.m.mogalapalli@oracle.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"graf@amazon.com" <graf@amazon.com>, "guoweikang.kernel@gmail.com"
	<guoweikang.kernel@gmail.com>, "henry.willard@oracle.com"
	<henry.willard@oracle.com>, "hpa@zytor.com" <hpa@zytor.com>, "jbohac@suse.cz"
	<jbohac@suse.cz>, "joel.granados@kernel.org" <joel.granados@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "noodles@fb.com" <noodles@fb.com>,
	"paul.x.webb@oracle.com" <paul.x.webb@oracle.com>, "rppt@kernel.org"
	<rppt@kernel.org>, "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>,
	"harshit.m.mogalapalli@oracle.com" <harshit.m.mogalapalli@oracle.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: [SEVERE] Re: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
Thread-Topic: [SEVERE] Re: [REGRESSION] Linux kernel 6.12.75 fails to compile
 with -Werror=implicit-function-declaration
Thread-Index: AQHcq/1MJ0ZQ8kX8tE+l5S0JLRjgyrWepzvNgAADdCc=
Date: Wed, 4 Mar 2026 18:04:25 +0000
Message-ID:
 <MAUPR01MB11546DC07AF1759DA3DA965ABB87CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
 <MAUPR01MB11546202F5CB445AC8683A176B87CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <MAUPR01MB11546202F5CB445AC8683A176B87CA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PNXPR01MB6993:EE_
x-ms-office365-filtering-correlation-id: a84d7e21-ab70-45b2-ccb9-08de7a187862
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799012|8060799015|51005399006|14091999006|8062599012|6072599003|15080799012|31061999003|1602099012|40105399003|3412199025|4302099013|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2VqRVZ5NzhCbXNXQ2xEUmFaa2Z4T241NUJQcVVTem80QlNaUHhzVHhiNXp6?=
 =?utf-8?B?RFhNaUdpUjNnak12TE1xZlhyWFVlNFJzTE1oTmltZ1JGV1RPbTF1SmIrVVlz?=
 =?utf-8?B?WmdINW0yOUVyWWh1eWZadUlTd0t1Z1JXYjVWYnhHa05oNjBUdUZsTEdMNisx?=
 =?utf-8?B?UmJ5b1BacCtXSytHWlJXU1BpVjVLVnRTT2EyTituMWFkOWkyM21rTHBEamhJ?=
 =?utf-8?B?M2dsY1ZsUFdKckpqOWdzT3ZQTVhjOXNBTFVYeDJNMWZPY0piSEkzUFVndUJL?=
 =?utf-8?B?aG1yVVBoQTBSalFwd0dkdE54UlZZY2UyUUM2Ums3cFdNRDZOL2Z2RVFzcGVi?=
 =?utf-8?B?WnZNUWJrOXZ2VllUaXNBc3IzVXJwT05vV0ZVSkYwL2VsNXZueVZtNStLQXl6?=
 =?utf-8?B?cGJKc2pxNUZuYVlYV3dwNWFqbmhuSkJnOTFkV3drQWhxOURMUzVxV1dMNlJS?=
 =?utf-8?B?TlIreHE4c2hIelN4cTJSR3JSWnQ2aUxvQ2U0Q0s1Ni9hYXVHdG85ZTRiaEor?=
 =?utf-8?B?MzIwZFkvcFFlVmlQQWp4S0JLVlUvWE8rN1hoQTloYmdVQWZwM1J0RDRBcytx?=
 =?utf-8?B?NmVtOWpQZm1ieFY2VnhGU2UvOS9vWnBabDBqR1Z1cUFaSkNhWlBvclFnWFps?=
 =?utf-8?B?S01DYnFDand5UlVPQTJGdGRhdUo1SlVmbVNjVkk4RG9hbTUyU1dXRHZXVHZZ?=
 =?utf-8?B?OEdta0N5TzZnTG4wYSt2Y0Q0UVIzTGhHZGJDUVU1QXVzVEV2emJKYjNlaUUz?=
 =?utf-8?B?VUprTWpSUG5qQzlsSkZuRTJuNEh5T1lBdGxlVWZOeUZEV1NqbCs1dkNWZ3Fk?=
 =?utf-8?B?QTlRV0lvWEgvQk9YbGlWbS9SeTdzcUxTK3NkY3hYaktmNUx5aWVNdUhlVUNY?=
 =?utf-8?B?Z0FVTC96QmdoWDk2VmNZZXZ6NDRQVjArdE0ydmxzRmhrUmY2Y3l5ZXJnWVk3?=
 =?utf-8?B?cEU2RlJnSmprKzFhSHhQV1VrOVZQUG83NnV1VTBLMkNmZXREd1hnYTFSU2U1?=
 =?utf-8?B?ZElacVZ3SzlhRzhKUGdQRjF1N0dzTHBZU0RzbFVaVldkWTlzV0M5KzBtY2JF?=
 =?utf-8?B?M0JhRXRzRVRTZE1tNmFNV1hIYytOZDRBaGV5d294YmpUaWZkdWx5Uk1YNVlU?=
 =?utf-8?B?M0lORjRteEh1RktEM0M1SGxmUWdkT2lzQXBCWXJhT20rRC9hRXFRT0ttckNx?=
 =?utf-8?B?Q09sL2VuTnJDUjlyV25lT3pFdU50OXBkMDBWc0lza3lSM1lxS1NTbGh1WE55?=
 =?utf-8?B?QUFxNi9FM1dMWVBVV216Y1VmdWVncVM3UmtOb0hXNWpuSW1FbEhYWjZrcUVL?=
 =?utf-8?B?ZmNQNi83QmJGT0h5OGx6NG1lYU9QUXJKSFRjcUxaWUFNZHBsZnlDSjVYL0pQ?=
 =?utf-8?B?ZzE2WVh1d0oxZ1NVUjFpYlgzUk5uaVIzbUtaWW1qWElSUDhLdzRmZzhCTEhG?=
 =?utf-8?B?TlJUS2NYOXJoV1RkdWxtWXc0TUN6dE5razU1ZFdmeVplSmZzSkQvVDQ1TVZZ?=
 =?utf-8?Q?+Hfn9w=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFFYT0ZxNDMwdUJTTEJCaUo1VDVwNFBNYjUxLzRmYmc5bmZjZmM3Z0Y3cUxR?=
 =?utf-8?B?VXhwbEx2S3JDZmlEYlhtUGV2QVo1UlpvU3owTE9RQ3V2c3VScE9nT05kWkNG?=
 =?utf-8?B?Tk5reXBiSEl3TXI4U3hvMWlPN21mZ2JGMVJPeW1RclZvam1TbC9CRVczR1pY?=
 =?utf-8?B?a3lnZnZETXVEbDNNS0ROV2F6NXNIbml6K1JxYW9iV2kyTUhuTnF4RXFveVBX?=
 =?utf-8?B?enJJNklValdUc1dpTkp6QmdzREx3aXk0QXFDYjZsMVRpNUx4dys5SG5ONnFj?=
 =?utf-8?B?ZHJNR2xHM0hrY3FDUUFmbWgrQ25BUExuTzRCUXNXSHYrM1JMWmk3REpDd3Jq?=
 =?utf-8?B?QzRTdXExRE8yTzMrMG5va1JKWEZLWURBRVlRQmtRWnB1ZmZabUgvTlN3dllR?=
 =?utf-8?B?WkMzTW84eXdBMGl0T0FWZjVHQXhBSGtBTEQwaGc0WVlFU3hXVHI5WXFhbXRK?=
 =?utf-8?B?NG9QL25VYzBxa1BCMWd1QkthaWtXRUR6Z3R2Q1Rud2lnTk8zSjF1bzMwcGEy?=
 =?utf-8?B?M2txMnZsZkF4c2tqSUdwT3ZiSHNFVTJMQm9NR0pyS2VWcXI5K1BTczAwa3g1?=
 =?utf-8?B?TE80VlZGVjlUTlpQMU5zdG5JazNROUFmelpOaU03ZXFTNWxBVFZjZjJOTUha?=
 =?utf-8?B?dnFYNEFEdTFGZlpIT3VVM1o5WUJ3MjNBZG9JeEdVZTBlODN3UmpxYVVEWW1Q?=
 =?utf-8?B?YUNSWTcwTGQ4YTJpVmJkSHJ5V3pXanJ4NUF4eVJhZy82UW9qY0wrQTNmTDBq?=
 =?utf-8?B?WVBlNUZ5dE4zcStGVzcwN3pGajRGS3A2c2VQWVB1OHN3SWl0U0VlNFBXc2FT?=
 =?utf-8?B?MGRXRnZTdXhERzJLdERpMC9OTjFHSDAwQnl0UENPem1kdTRCYjlnVnRxVVF5?=
 =?utf-8?B?L24zQU9tQ1JqbGJKQWY1dnFKd1pyb1I1RVIzRzIyYkYyOThLbGVsZ0FTZldu?=
 =?utf-8?B?QXlCdnMrVzVtV2orOXBSalkwSWVYYStTY3JyVjQxc2pxL0VicnJIbjh5RnBw?=
 =?utf-8?B?eWJNQ01ObjdsVVBiT002RG1CRU8rdGgyZlhDWExnaElLL2FKUmR5dUlZQjlV?=
 =?utf-8?B?V2xrdFFxYkFNd2xKSXJOWGJEV0hnWWJZT2d2blhyZlRNcjdlaklDQ2Y0ZWtV?=
 =?utf-8?B?SFNKTy9STzQ1NlB1Mzd4M254VFVVYldvTUtsOEZZQnZ2bGZWVnp2S0hXbGhn?=
 =?utf-8?B?OUlxeXJDYlA2WjE2VUViSjdtRFFWYitndGl6OXZXQzNGYmxPZVVSU0QrNzlL?=
 =?utf-8?B?emxQN2tKRlh2M21PYUMxbXZGc2tDN2swcjBHVmxDSGtuSE1sWS9NYnZMUFFi?=
 =?utf-8?B?Z3FHWVV0RGRxTHBsMGEvUWEvQXFWMDZGNlZQNmh4RVp5d2hxUjMweXJ3ZlVv?=
 =?utf-8?B?VXFobHFvZzFRUVpnZXhhVXQ0MW9iRFkxRTY2cDlIcHlGU0YrbUtESGJBL29o?=
 =?utf-8?B?L2dCZCs1ZlFTb0VZOHZ2bzAvVVJab3FSbWhqV0VxUzlXWlJZWlV0ajFsYUVR?=
 =?utf-8?B?SjF6WnFUbFRXQXRpSk1hVGh1ZGw0Snc5U0dUVTBkSjU1NmZ1VXRkekhnVFZE?=
 =?utf-8?B?WFVJc0JhMVNpU1RST2hGMW1XOGE1emdWS0MyMEZrT0tiZTIyS2laZWUwaUQ0?=
 =?utf-8?B?SVZXdjBTLzdxa0Q1SVgvTEtpNklvU2NiSzRteVBveXV1aU5KM2pSUkxyeS83?=
 =?utf-8?B?YVNwNUVid296Vkdwd0x1V0xnTGw0S3NpRFN0UVNLRjdLdFBRV0hTOExIbUZP?=
 =?utf-8?B?MjU2QjVIR090OEFoc2NZZlMxeHBVOGpZQklQU2FGUG5UdEl2THg0OVJ5R2s2?=
 =?utf-8?B?b1cyRm5lUnlKV1hnTytqZk00YkZQNDdNVjlMcUdIczRQcHk1aElENUVoamFC?=
 =?utf-8?B?Sy91UDZ0SHlwR01WWjFwMUNmUTExSGJEUGNjVmI5Z25FZG1xTm5JQTlxMmtz?=
 =?utf-8?Q?qH0tBcfANKRC9ymMKCiINKvDh7dHhkWC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a84d7e21-ab70-45b2-ccb9-08de7a187862
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2026 18:04:25.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6993
X-Rspamd-Queue-Id: 939B72060CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223125-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[live.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,oracle.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linux.ibm.com,linutronix.de,linux-foundation.org];
	DKIM_TRACE(0.00)[live.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,live.com:dkim,live.com:email,MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM:mid]
X-Rspamd-Action: no action

VGhlIGZhdWx0eSBjb21taXQgc2VlbXMgdG8gYmUgZjhmNzNiZjBmOGE1N2VlOWI4Njc5MjQ1NmJk
NDIwNzliYzk4YzZiNyBvbiA2LjEyDQoNCj4gT24gNCBNYXIgMjAyNiwgYXQgMTE6MjLigK9QTSwg
QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79Mb29r
cyBsaWtlIGtlcm5lbCA2LjEyLCA2LjYgYW5kIDYuMSBzZXJpZXMgZ290IG9ubHkgb25lIHBhcnQg
b2YgdGhlIHRocmVlIHBhdGNoZXMgc2VudCwgdGh1cyBjYXVzaW5nIHRoaXMgcmVncmVzc2lvbi4N
Cj4gDQo+IE1hcmtpbmcgdGhpcyBhcyBTRVZFUkUsIHBsZWFzZSBmb3JnaXZlIG1lIGlmIEkgZGlk
IHdyb25nLg0KPiANCj4+IE9uIDQgTWFyIDIwMjYsIGF0IDExOjA14oCvUE0sIEFkaXR5YSBHYXJn
IDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPj4gDQo+PiDvu79IaQ0KPj4gDQo+PiBJ
IGZvdW5kIG91dCB0aGF0IExpbnV4IGtlcm5lbCA2LjEyLjc1IGZhaWxlZCB0byBjb21waWxlZCBp
biBteSBhdXRvbWF0aWMgYnVpbGRzLiBUaGUgY29tcGlsZXIgdGhyb3dzIHRoZSBlcnJvcjoNCj4+
IA0KPj4gYXJjaC94ODYva2VybmVsL3NldHVwLmM6IEluIGZ1bmN0aW9uICdpbWFfZ2V0X2tleGVj
X2J1ZmZlcic6DQo+PiBhcmNoL3g4Ni9rZXJuZWwvc2V0dXAuYzozODA6MTU6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnaW1hX3ZhbGlkYXRlX3JhbmdlJyBbLVdlcnJv
cj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCj4+IDM4MCB8ICAgICAgICAgcmV0ID0g
aW1hX3ZhbGlkYXRlX3JhbmdlKGltYV9rZXhlY19idWZmZXJfcGh5cywgaW1hX2tleGVjX2J1ZmZl
cl9zaXplKTsNCj4+ICAgfCAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fg0KPj4gY2Mx
OiBzb21lIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzDQo+PiBtYWtlWzddOiAqKiog
W3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjI5OiBhcmNoL3g4Ni9rZXJuZWwvc2V0dXAub10gRXJy
b3IgMQ0KPj4gbWFrZVs2XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjQ2NjogYXJjaC94
ODYva2VybmVsXSBFcnJvciAyDQo+PiBtYWtlWzVdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVp
bGQ6NDY2OiBhcmNoL3g4Nl0gRXJyb3IgMg0KPj4gDQo+PiBVcG9uIHNlYXJjaGluZyBhIGJpdCwg
SSBmb3VuZCBvdXQgdGhhdCBmYWlsdXJlIG9mIHRoaXMgcGF0Y2ggdG8gYmUgYmFja3BvcnRlZCBz
ZWVtcyB0byBiZSBtYWluIHJlYXNvbjoNCj4+IA0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjUxMjMxMDYxNjA5LjkwNzE3MC0yLWhhcnNoaXQubS5tb2dhbGFwYWxsaUBvcmFjbGUu
Y29tLw0KPj4gDQo+PiBMb29rcyBsaWtlIHRoaXMgc2VyaWVzIGl0c2VsZiB3YXMgbm90IHByb3Bl
cmx5IGJhY2twb3J0ZWQuDQo+PiANCj4+IEkgYW0gbm90IHN1cmUgaWYgYW55IG90aGVyIGtlcm5l
bCB2ZXJzaW9uIGlzIGFmZmVjdGVkLiBJIGN1cnJlbnRseSBidWlsZCA2LjE5IGFuZCA2LjEyIHNl
cmllcyBmb3IgbXkgdXNlLg0KPj4gDQo+PiBUaGFua3MhDQo+PiBBZGl0eWENCg==

