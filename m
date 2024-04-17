Return-Path: <stable+bounces-40065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE18A7C76
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B971C20B85
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5955053E08;
	Wed, 17 Apr 2024 06:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IoJat+BO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="O7Yxb0Fy"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D6B2AF0A
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713336331; cv=fail; b=bs09IP4Rw1C5GKGyIpM8FOCKy26pZQrDoC3Y3NpQxud0KI/ZsUp9m59wkw4QXqAYkNr3TitWpohwMKZxdM4AXfW5QTREM3u9SlGHYffGZ0dcIKj17OcXSwbrHVGUM/BsOL/Ues/6SLkk+jG6lTMIlPKjIAzpRA5EYP7ZIBaovPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713336331; c=relaxed/simple;
	bh=9psdCxwHbiDwLJYkEyPrXcQNZjN9uQNxnHaikpypAaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tz2wWUE/ntxvvPWGrWfwj3rN0xEg1N6H0gaKjVeDicCAtRURei2DqJUbtc0cBOylclRavHHM8DFr0biFewDj4sDkrsFiQANiq6P+Th8eG60EtfTR/eF96NqdT/KX5M6SY16VXBR2+zxI0JdevWWMggAqj1wHzTs0JNCeMeKjkxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IoJat+BO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=O7Yxb0Fy; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 10eceb6cfc8611eeb8927bc1f75efef4-20240417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9psdCxwHbiDwLJYkEyPrXcQNZjN9uQNxnHaikpypAaA=;
	b=IoJat+BOO688doi9ENMRgQAMg1wtS4yLk5JB8XTDX1VQhJ23DNB+gCFBFcPdXzDLSIAmcCrUxryBVnmdLGwl4yrnbkAcO4zWJqoqvXr1lcfCFUP9XnL8yK8UFpjd3Ne1IQjqPY7thib76Eh3so1RKUUAA5AiEa7cHmrwcKybo7c=;
X-CID-CACHE: Type:Local,Time:202404171424+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:243643e8-5920-43e9-a2a0-6eb13177491b,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:60864686-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:0,Content:0,EDM:-3,IP:nil,URL
	:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1
	,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 10eceb6cfc8611eeb8927bc1f75efef4-20240417
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <bo.ye@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 878406430; Wed, 17 Apr 2024 14:45:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Apr 2024 14:45:22 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Apr 2024 14:45:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljrjfOaZcBI1+Xa4w2nm/K57d2NfGnVG7Bg1C3/nF+YemnLpOD6FnNEXq/cR69+cvUhzc5eahySZV1hhjaylGZAefwy9XaiE285rbre5wc0sCvUiFKGXCy4GBWMXpKKvx8Mw6Fft1cbDHW1eMIfVz81hkbW8TdwwS9NilekVJ5itgyR+ownWDL9rX+lI9jHir1E9+j8cgvGB5OwiFzHdVN3B2vPCAnGHWM4lweqFAiPeg/n2poh5a7eBq5Si7YcbXFiPPX9rl0MrnMQWd+qu/Yt4YYn2QUvlR29Dk4kcRsl64w+keGpJpU/de8C3VoTIJ6ulJkyLrd56Ts6YNV8Jyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9psdCxwHbiDwLJYkEyPrXcQNZjN9uQNxnHaikpypAaA=;
 b=bDtG1GP0Pj8qrCcOfE0ZO7WlK0sX5jXDUd0WFY8Q+PkdNnoCw7Zo+KUG/AX6hVZOjB8sf5s0CkSgffacvvBmijPE+GTdXz03QKjQM+c/dFqv4H0iCbuwuTw+oOr9Ba+a+34q69bMoYh9ZAbtQO6+fO1YIb1nxLmVc6+6nZqLKxv8aOue91819TLZXpUnfeZsersleWppkpVMXDBUuJI99inTdGNYXYgVURewBlCXr7M5aavlldhLuk9vQoVEOpfPmiOAsEv8IJLFUrIV2SZkcFztUe0RBARWYLfK9W2sbkQvyojlca6QC9+/h8FafkMYl0mql7Su9EO5Atx+0eOHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9psdCxwHbiDwLJYkEyPrXcQNZjN9uQNxnHaikpypAaA=;
 b=O7Yxb0FykDOBGshrekq9Vq82HLV9QBR7KYLJpzjkfZ8eP4miRUwSeAeqlL+7S1jzEv+yLSudPZez+/LHguJMlVpK9mvGgXunQDcXTaos+pkOYWAbuomwHzrmy3CGddreV6L3xEPDvZ0YC44Ymsm9SE5UijUooYPoCHLfHmOrooc=
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com (2603:1096:101:8a::9)
 by TYUPR03MB7088.apcprd03.prod.outlook.com (2603:1096:400:355::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 06:45:19 +0000
Received: from SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::3b4f:ca00:4a28:e7c6]) by SEYPR03MB6531.apcprd03.prod.outlook.com
 ([fe80::3b4f:ca00:4a28:e7c6%7]) with mapi id 15.20.7452.050; Wed, 17 Apr 2024
 06:45:19 +0000
From: =?utf-8?B?Qm8gWWUgKOWPtuazoik=?= <Bo.Ye@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: =?utf-8?B?Q2h1YW4gQ2hlbiAo6ZmI5bedKQ==?= <chuan.chen@mediatek.com>,
	=?utf-8?B?WXVnYW5nIFdhbmcgKOeOi+eOieWImik=?= <Yugang.Wang@mediatek.com>,
	=?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?=
	<Yongdong.Zhang@mediatek.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [Request] backport a mainline patch to Linux kernel-5.10 stable tree
Thread-Topic: [Request] backport a mainline patch to Linux kernel-5.10 stable
 tree
Thread-Index: AdqQj9c4yTiJ5CidQ0S6HZ7pjwTf+gAAd7NA
Date: Wed, 17 Apr 2024 06:45:19 +0000
Message-ID: <SEYPR03MB65312AE2FBA8DE870C96A525940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
References: <SEYPR03MB65312F905CF0A33DC5FB8189940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
In-Reply-To: <SEYPR03MB65312F905CF0A33DC5FB8189940F2@SEYPR03MB6531.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6531:EE_|TYUPR03MB7088:EE_
x-ms-office365-filtering-correlation-id: e1674ac2-547f-4d1f-b1f1-08dc5ea9f2f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?b01FL0wyNGt2RWQzV0h1K3FaSlV3NE1nWDBDOXJKSFk3RW92NG81Y3N1YTdQ?=
 =?utf-8?B?YzBJYkFteXFibHNXYWd2NFlTZ3BEa2J1WEFvendDeitiZERNWnJZVTBzRTU1?=
 =?utf-8?B?RGhjQ2JHbDB3TjBqOFNER2E5OFBSa0RJa1RRSVVYREE3am92WU1vUmM0MkFU?=
 =?utf-8?B?YlR0ZmdFZXdnNFJKVFNsQmFtRjBvdk9ZdmV0QlJZbXgwaks1WE9VVnJuSEtX?=
 =?utf-8?B?MlliNzdQcFB5emR5L0xLcC9LWFFqWnZJa1pxbVFGUWZscDBBSTU3bmxzV205?=
 =?utf-8?B?VnVLWWl5b3lQUnNLV25rK2tScU9CRmhoWXp6aTVQdGlYMzB6VU5rR0V3Z0Yz?=
 =?utf-8?B?RmZwSVZ2cnZKVWp0MldtekhmQlJucUxWM29JSkVaQnVHK0xBU21yTWZ3WExm?=
 =?utf-8?B?RUdDeTRTQ0c0NW5TRFkrbHkxSGZIcjduUDRhWi9rZXQ4TkN4UzFPc29vTjNN?=
 =?utf-8?B?V1ZYeTVXMzBkcVJyVlZSQ1JkS0QwSXZ4U1VUTDF5RklnYytRUkF4ZkZZYjdS?=
 =?utf-8?B?TVFGMUEzWU5uaW9TSnhodVNKdHVrREhmVjRlcHVicmg1QStjOGQyM3A3WXd2?=
 =?utf-8?B?NjREbTNaRE9pVVJiYm9acmhNc0JyMlcrOTlBVU12WU9ZNGx0UlMxR2Irdzg4?=
 =?utf-8?B?TzhhYTlIbUhiT2RQLzd6Q1R4QjROQzJVOEtuby85VVN1dG50QXUwWFl2a1VG?=
 =?utf-8?B?VnZ5bVBUOEYyMnF2VStZclV3aHJXd083QmxDRkNzQ2pKZG5uakc4STNSRDVl?=
 =?utf-8?B?YkFnOGtydG51WDZmVzA2VEtWNlh5c1hYRk9Sci80QXhJd25xclg2VlBHSVI1?=
 =?utf-8?B?OFFOR0hjYlNBbk8vaEo2REdOWjRmQ0lzQTNBVmJpaXhBVy85VVVKTEtiQ1V0?=
 =?utf-8?B?dXpxME03SUlOQnFVMVJPK1BKUGcwakdmaWFDc242aEVnbk02MVQ5L2dYdXI1?=
 =?utf-8?B?TElLUHlzREV2ODJKSFdVOGlOZXBKaEJVUzFPaTFsZnJxV0syVnVtWlIwVHRF?=
 =?utf-8?B?czlCSG9IYnV4aG9Dc29MY2JENThGM1h3WW5QTk1hbDQzSWJGOHdNTTlkTUZG?=
 =?utf-8?B?WGhwUmRKb3dnMjIxQW9IS21kaEhGdTJtMm9ybThBT3dBeHNBa1J3V1ZUbDgz?=
 =?utf-8?B?Um8zRDZOU3VTOGFocGRVa0lIenMvdjVuWW5KeitQRmM4TzZNNXNTUWZQN3M3?=
 =?utf-8?B?SUgrcEFpYmhhRHI2K2ozVDdydUJpMkI4K2ErZzJ6MUFOQUxpTW5tMitjQitD?=
 =?utf-8?B?aU1JNVRBTEJxNjVldjcxdVMvRmFQVnJJWSs3cEpDUWt6K3ZSU0R0ZlF6ZlRq?=
 =?utf-8?B?YmxKYVlTWFUyZE9IUzltZ2p4RnhwSDg3VnVzZ3BBeDV3K0EwRE4vbWFYZzhi?=
 =?utf-8?B?V0NBMzlOSDR3VWtWdFB0SHg0N3gvZEFhY1JZdWZLd1F4U2pTVStUa045VGs0?=
 =?utf-8?B?T0ExYzVEVDdMTktWR1kydG1JZzlEcVQ3anlNbkE2ZlFqdHBsNEw1YkhPb21Y?=
 =?utf-8?B?d2loNkxzL1dUS215dzBadUVrd3ZaNFlzY01XeXRHbnBHbW1QSWw3WDhKQzBE?=
 =?utf-8?B?UEVMTUU5OUNDbmRhN1RreFpLampJcUVEcjVMY3F2K0RDMDgrOU56ZW9LSEtq?=
 =?utf-8?B?OUIrbTFPOU52SGpqS0UwcE1samU1Nmt4RmFVZzI4cHhPM2NuYUs0WnJVNjJr?=
 =?utf-8?B?LzdzSVVlSHFLY0NLWWZDV3ZVNG5KWjlKNW4vMFJreCs4ZnRRV3ZKa2Jqc0lX?=
 =?utf-8?B?QXE2bVlkWG9OMGJnNWJ2L0tRaUs2VWF1dzBNY05JeitFLzI5dDFJSklUQVll?=
 =?utf-8?B?bTZWekM0M2V5M3UybkQ2dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6531.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3ZCWVJLekdUM1Uwa3E3bTdnUkNST3JaaExZdW9DZmg0aytFbDh6ZFcxRThu?=
 =?utf-8?B?SmFuenFhUm5ESlpsMkZQM1hjaSt5Qk8zWFBZSStjOXBhMVhHei9vY00zTkpr?=
 =?utf-8?B?YjZrRUFnZHN4aEVRYTUyUmhNeXZUU0NnUUZuYjBENVJIYUlSS015QnhZWGlj?=
 =?utf-8?B?eVFvdUdMT0JUQVVkR3Q2OGN0WFZ0YnkvTjlERFQ0akVsMWkzOE1UUFBxVnBB?=
 =?utf-8?B?dytXMW9xcTVGN25EZ0Y5Z1FhUzRPTWxEVFBDcHNkTzQrRXk3UFEyNkFqMWdH?=
 =?utf-8?B?aTJWeHhLRHJtLzVrNUxpWEk4QmxYWUxBVEZhSmhVaHVtZzZSa0JIOEZ2cTBn?=
 =?utf-8?B?blE5c3hsSkZ5NzhtZHdBM1ZzR3k1YXpJUDlHbWY5c3ZqeGlCUlZjWjRRT0gv?=
 =?utf-8?B?RVR2ZGZvNkdDS00zRk0xbFdIbUVnTkRCTkxMeGVISlRzcnpHdC9BVzVYNSsw?=
 =?utf-8?B?VGUrazlSM0JPMWlJNTdIVVV2aDdmZzZ4SkpIOTVVc3dCalRPeVZ4TXlaSGNY?=
 =?utf-8?B?enBOcVZLQnMxWEQzT2VKb282SU9HWWFzM1dhVkJHbEdENjZ3bHVhNUlHaGd4?=
 =?utf-8?B?MDRVSCtjTXIrdTFUVXFHWUhqVXRJdlFCbWhqMnZERi95bExTRU5BTmx5R3Bh?=
 =?utf-8?B?Y1lmdm9jdWhtZkgvdVlqekFNS1VvTlp6cDFONFZNNENXOHJ2a3pHWmluZnZz?=
 =?utf-8?B?RWVPYThpbWhaNnAvTjFzcGJDNStHUXFhaXJKUnpvaW53aDJGQjNHM1p5SXFR?=
 =?utf-8?B?T09JdnM1Zit0bnlIcTVvbEhCcFc1NTlVTlBBRWdnTVdyQmhSMWlCcGpJc3pj?=
 =?utf-8?B?aTM1ZTJWcXNrZGU2Zk01YW9wUDJucEd0cWdrV2RxOElBWVBuTFg2RGpqVmRx?=
 =?utf-8?B?MVFXYU02bmo4ZS9EN3ZubFl2SDR6TjRuanQ4ZXJLQUF5UEJzOGtFb0JVWU96?=
 =?utf-8?B?TVYrR3BoSUJQMFQxdVRyRmp0NTN2Z0pzWXdEazNCVjVwTElmbm9vWHp1bXA0?=
 =?utf-8?B?Z2hqRlRHSXhDVWI1UEdGUFhIWVIxblRUa29UZUtVaThwamNKdlliRzNTTG1q?=
 =?utf-8?B?Ymk3UVFZTExaVE9QUFpsNE1KQkxNaDhuS2hkY2MyVXVvdnVvSy9XeXBYK3VV?=
 =?utf-8?B?NkZvTTB5ZlN5MWxSd3JXYTQyZFNqZ2VUNEJNVGdPcjdrMXIvWUw0Y1ZVVUFB?=
 =?utf-8?B?bHJDOVJSK3liQWhRRFoycmcxbEhFWkJnRlY1cVlWSjhDa3k2Y0szUVcyck5J?=
 =?utf-8?B?d0tTS2YzcVpJU0QySjJHN2twWDZnY21CVmh1ZCs4OTlhbzg5WXlMeHFXdFNh?=
 =?utf-8?B?ZjE5enpQK0puR3NIbC9DNy82UWd4QzBZWHVtVFpiYkRtZWxnMEY0dEdTdzFm?=
 =?utf-8?B?dzB0cUk1THlxUm9PSDNhaWdpb216RGVsK1kvcU5tc3hzVXNkMldBSGw2Y1h2?=
 =?utf-8?B?VncxTHpoWTB2eHdqbkNUM3lGUFlSOVd6OGN2UzNGajEwYk9RT0M4dWIwajd5?=
 =?utf-8?B?QzN2R2JwTlQzd0RHYXE5dGVPUmFSK2VRTmN4TDB3VnZhbThsMFE4OWV5Umx2?=
 =?utf-8?B?K1JmRGNWRWgrcEtVZ3BTYk1FOEFma2ZqZTZlSkZiL3A2QkhmcmZNbmxmOWZi?=
 =?utf-8?B?OGJDU3JjVzd2N2VoV1ZMOFBHL3hRRXlvQVZHUjdmaE1xNURpb3B2d2dHZ2E0?=
 =?utf-8?B?NjNmc1Y5WHZIVkdlNXlaeDhJNWVwTVBvWWJYbXhLVWFsTmZSVTVLMXZZeWlD?=
 =?utf-8?B?ZEF0djFYNmhlNWNjQktMb1ZsVVo3SHZBSVJ1MHZPMWhSNWNYVUVNZCt4ZzlH?=
 =?utf-8?B?TXQ3cVZzRFJ2ZE1BSkVMZVRPenBHcEp4bHE5WnNFb1U4UTJLd2dvOFRkak5J?=
 =?utf-8?B?VmJKZUdhQ3JieUVlbm1IaU44eTNITVlpNFFQR2NiOG5paUhxSTgvWXhEZDRQ?=
 =?utf-8?B?QWM0SGtwd2lFNW5OSUlZVHFZRGhSb1o2b3oyM1hFa0NXMXhhSHhldDRhNE9Q?=
 =?utf-8?B?TjlDSzBNZ1VXcUxUMjBYSVBXdkxhV1dORnRqMHB3YXM5MFZnOTZTNDgwRndS?=
 =?utf-8?B?enZpY0g5T0U2MS9WSU5PYmtWeTYrcnBlbXVzWVdEMXcvODVlNDJidyt0eHpJ?=
 =?utf-8?Q?LOL4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6531.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1674ac2-547f-4d1f-b1f1-08dc5ea9f2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 06:45:19.8161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ya4JpgoJBfjD5xWi/jp0fqbqWOVr6iZwgUuUCTNDVx9khc/3pwT/e2g3sdrS0Um9fgU+C0d/sRFEiVxNowbN5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7088

RGVhciBSZXZpZXdlcnMsDQoNCndlIHN1Z2dlc3QgdG8gYmFja3BvcnQgYSBjb21taXQgdG8gTGlu
dXgga2VybmVsLTUuMTAgc3RhYmxlIHRyZWUgdG8gZml4IHRoZXJtYWwgYnVnLiBUaGFua3MgYSBs
b3QNCg0Kc291cmNlIHBhdGNoOg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC9kcml2ZXJzL3RoZXJtYWwvdGhl
cm1hbF9jb3JlLmM/aD12Ni44JmlkPTRlODE0MTczYThjNGY0MzJmZDA2OGIxYzc5NmYwNDE2MzI4
YzlkOTkNCnRoZXJtYWw6IGNvcmU6IEZpeCB0aGVybWFsIHpvbmUgc3VzcGVuZC1yZXN1bWUgc3lu
Y2hyb25pemF0aW9uDQpUaGVyZSBhcmUgMyBzeW5jaHJvbml6YXRpb24gaXNzdWVzIHdpdGggdGhl
cm1hbCB6b25lIHN1c3BlbmQtcmVzdW1lDQpkdXJpbmcgc3lzdGVtLXdpZGUgdHJhbnNpdGlvbnM6
DQoNCjEuIFRoZSByZXN1bWUgY29kZSBydW5zIGluIGEgUE0gbm90aWZpZXIgd2hpY2ggaXMgaW52
b2tlZCBhZnRlciB1c2VyDQrCoMKgwqAgc3BhY2UgaGFzIGJlZW4gdGhhd2VkLCBzbyBpdCBjYW4g
cnVuIGNvbmN1cnJlbnRseSB3aXRoIHVzZXIgc3BhY2UNCsKgwqDCoCB3aGljaCBjYW4gdHJpZ2dl
ciBhIHRoZXJtYWwgem9uZSBkZXZpY2UgcmVtb3ZhbC7CoCBJZiB0aGF0IGhhcHBlbnMsDQrCoMKg
wqAgdGhlIHRoZXJtYWwgem9uZSByZXN1bWUgY29kZSBtYXkgdXNlIGEgc3RhbGUgcG9pbnRlciB0
byB0aGUgbmV4dA0KwqDCoMKgIGxpc3QgZWxlbWVudCBhbmQgY3Jhc2gsIGJlY2F1c2UgaXQgZG9l
cyBub3QgaG9sZCB0aGVybWFsX2xpc3RfbG9jaw0KwqDCoMKgIHdoaWxlIHdhbGtpbmcgdGhlcm1h
bF90el9saXN0Lg0KDQoyLiBUaGUgdGhlcm1hbCB6b25lIHJlc3VtZSBjb2RlIGNhbGxzIHRoZXJt
YWxfem9uZV9kZXZpY2VfaW5pdCgpDQrCoMKgwqAgb3V0c2lkZSB0aGUgem9uZSBsb2NrLCBzbyB1
c2VyIHNwYWNlIG9yIGFuIHVwZGF0ZSB0cmlnZ2VyZWQgYnkNCsKgwqDCoCB0aGUgcGxhdGZvcm0g
ZmlybXdhcmUgbWF5IHNlZSBhbiBpbmNvbnNpc3RlbnQgc3RhdGUgb2YgYQ0KwqDCoMKgIHRoZXJt
YWwgem9uZSBsZWFkaW5nIHRvIHVuZXhwZWN0ZWQgYmVoYXZpb3IuDQoNCjMuIENsZWFyaW5nIHRo
ZSBpbl9zdXNwZW5kIGdsb2JhbCB2YXJpYWJsZSBpbiB0aGVybWFsX3BtX25vdGlmeSgpDQrCoMKg
wqAgYWxsb3dzIF9fdGhlcm1hbF96b25lX2RldmljZV91cGRhdGUoKSB0byBjb250aW51ZSBmb3Ig
YWxsIHRoZXJtYWwNCsKgwqDCoCB6b25lcyBhbmQgaXQgbWF5IGFzIHdlbGwgcnVuIGJlZm9yZSB0
aGUgdGhlcm1hbF90el9saXN0IHdhbGsgKG9yDQrCoMKgwqAgYXQgYW55IHBvaW50IGR1cmluZyB0
aGUgbGlzdCB3YWxrIGZvciB0aGF0IG1hdHRlcikgYW5kIGF0dGVtcHQgdG8NCsKgwqDCoCBvcGVy
YXRlIG9uIGEgdGhlcm1hbCB6b25lIHRoYXQgaGFzIG5vdCBiZWVuIHJlc3VtZWQgeWV0LsKgIEl0
IG1heQ0KwqDCoMKgIGFsc28gcmFjZSBkZXN0cnVjdGl2ZWx5IHdpdGggdGhlcm1hbF96b25lX2Rl
dmljZV9pbml0KCkuDQoNClRvIGFkZHJlc3MgdGhlc2UgaXNzdWVzLCBhZGQgdGhlcm1hbF9saXN0
X2xvY2sgbG9ja2luZyB0bw0KdGhlcm1hbF9wbV9ub3RpZnkoKSwgZXNwZWNpYWxseSBhcm91bnQg
dGhlIHRoZXJtYWxfdHpfbGlzdCwNCm1ha2UgaXQgY2FsbCB0aGVybWFsX3pvbmVfZGV2aWNlX2lu
aXQoKSBiYWNrLXRvLWJhY2sgd2l0aA0KX190aGVybWFsX3pvbmVfZGV2aWNlX3VwZGF0ZSgpIHVu
ZGVyIHRoZSB6b25lIGxvY2sgYW5kIHJlcGxhY2UNCmluX3N1c3BlbmQgd2l0aCBwZXItem9uZSBi
b29sICJzdXNwZW5kIiBpbmRpY2F0b3JzIHNldCBhbmQgdW5zZXQNCnVuZGVyIHRoZSBnaXZlbiB6
b25lJ3MgbG9jay4NCg0KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMjAy
MzEyMTgxNjIzNDguNjkxMDEtMS1iby55ZUBtZWRpYXRlay5jb20vDQpSZXBvcnRlZC1ieTogQm8g
WWUgPGJvLnllQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tp
IDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvIHRoZXJtYWw6IGNvcmU6IEZpeCB0aGVybWFsIHpv
bmUgc3VzcGVuZC1yZXN1bWUgc3luY2hyb25pemF0aW9uDQpUaGVyZSBhcmUgMyBzeW5jaHJvbml6
YXRpb24gaXNzdWVzIHdpdGggdGhlcm1hbCB6b25lIHN1c3BlbmQtcmVzdW1lDQpkdXJpbmcgc3lz
dGVtLXdpZGUgdHJhbnNpdGlvbnM6DQoNCjEuIFRoZSByZXN1bWUgY29kZSBydW5zIGluIGEgUE0g
bm90aWZpZXIgd2hpY2ggaXMgaW52b2tlZCBhZnRlciB1c2VyDQrCoMKgwqAgc3BhY2UgaGFzIGJl
ZW4gdGhhd2VkLCBzbyBpdCBjYW4gcnVuIGNvbmN1cnJlbnRseSB3aXRoIHVzZXIgc3BhY2UNCsKg
wqDCoCB3aGljaCBjYW4gdHJpZ2dlciBhIHRoZXJtYWwgem9uZSBkZXZpY2UgcmVtb3ZhbC7CoCBJ
ZiB0aGF0IGhhcHBlbnMsDQrCoMKgwqAgdGhlIHRoZXJtYWwgem9uZSByZXN1bWUgY29kZSBtYXkg
dXNlIGEgc3RhbGUgcG9pbnRlciB0byB0aGUgbmV4dA0KwqDCoMKgIGxpc3QgZWxlbWVudCBhbmQg
Y3Jhc2gsIGJlY2F1c2UgaXQgZG9lcyBub3QgaG9sZCB0aGVybWFsX2xpc3RfbG9jaw0KwqDCoMKg
IHdoaWxlIHdhbGtpbmcgdGhlcm1hbF90el9saXN0Lg0KDQoyLiBUaGUgdGhlcm1hbCB6b25lIHJl
c3VtZSBjb2RlIGNhbGxzIHRoZXJtYWxfem9uZV9kZXZpY2VfaW5pdCgpDQrCoMKgwqAgb3V0c2lk
ZSB0aGUgem9uZSBsb2NrLCBzbyB1c2VyIHNwYWNlIG9yIGFuIHVwZGF0ZSB0cmlnZ2VyZWQgYnkN
CsKgwqDCoCB0aGUgcGxhdGZvcm0gZmlybXdhcmUgbWF5IHNlZSBhbiBpbmNvbnNpc3RlbnQgc3Rh
dGUgb2YgYQ0KwqDCoMKgIHRoZXJtYWwgem9uZSBsZWFkaW5nIHRvIHVuZXhwZWN0ZWQgYmVoYXZp
b3IuDQoNCjMuIENsZWFyaW5nIHRoZSBpbl9zdXNwZW5kIGdsb2JhbCB2YXJpYWJsZSBpbiB0aGVy
bWFsX3BtX25vdGlmeSgpDQrCoMKgwqAgYWxsb3dzIF9fdGhlcm1hbF96b25lX2RldmljZV91cGRh
dGUoKSB0byBjb250aW51ZSBmb3IgYWxsIHRoZXJtYWwNCsKgwqDCoCB6b25lcyBhbmQgaXQgbWF5
IGFzIHdlbGwgcnVuIGJlZm9yZSB0aGUgdGhlcm1hbF90el9saXN0IHdhbGsgKG9yDQrCoMKgwqAg
YXQgYW55IHBvaW50IGR1cmluZyB0aGUgbGlzdCB3YWxrIGZvciB0aGF0IG1hdHRlcikgYW5kIGF0
dGVtcHQgdG8NCsKgwqDCoCBvcGVyYXRlIG9uIGEgdGhlcm1hbCB6b25lIHRoYXQgaGFzIG5vdCBi
ZWVuIHJlc3VtZWQgeWV0LsKgIEl0IG1heQ0KwqDCoMKgIGFsc28gcmFjZSBkZXN0cnVjdGl2ZWx5
IHdpdGggdGhlcm1hbF96b25lX2RldmljZV9pbml0KCkuDQoNClRvIGFkZHJlc3MgdGhlc2UgaXNz
dWVzLCBhZGQgdGhlcm1hbF9saXN0X2xvY2sgbG9ja2luZyB0bw0KdGhlcm1hbF9wbV9ub3RpZnko
KSwgZXNwZWNpYWxseSBhcm91bnQgdGhlIHRoZXJtYWxfdHpfbGlzdCwNCm1ha2UgaXQgY2FsbCB0
aGVybWFsX3pvbmVfZGV2aWNlX2luaXQoKSBiYWNrLXRvLWJhY2sgd2l0aA0KX190aGVybWFsX3pv
bmVfZGV2aWNlX3VwZGF0ZSgpIHVuZGVyIHRoZSB6b25lIGxvY2sgYW5kIHJlcGxhY2UNCmluX3N1
c3BlbmQgd2l0aCBwZXItem9uZSBib29sICJzdXNwZW5kIiBpbmRpY2F0b3JzIHNldCBhbmQgdW5z
ZXQNCnVuZGVyIHRoZSBnaXZlbiB6b25lJ3MgbG9jay4NCg0KTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtcG0vMjAyMzEyMTgxNjIzNDguNjkxMDEtMS1iby55ZUBtZWRpYXRlay5j
b20vDQpSZXBvcnRlZC1ieTogQm8gWWUgPGJvLnllQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCkJScw0K
Qm8gWWUNCg==

