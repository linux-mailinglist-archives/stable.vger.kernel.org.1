Return-Path: <stable+bounces-166982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C5B1FD93
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 04:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF51895DD8
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 02:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC27957C9F;
	Mon, 11 Aug 2025 02:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vk5tTvEe";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qsP80l9g"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0AAE573
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754877740; cv=fail; b=ldpXPqSFvD9IU2QHI+uvVLatDwCL2eSUJUuBf0bt2mc4I3/GdGIbRsaIR/Qo9HzUD3ka/F2nX/ZD0jWrKE8H2Pl/G+SdUwZsZ7VTma4SzTA4wdVcxyponAH5RwlQCkUCJNRrtl6K/sp2wjce6Rl3eE0JabTozxRrm5PzXA+kGvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754877740; c=relaxed/simple;
	bh=SWgCyzpDcdIa+u21lnHpzZ/+mzPJVYg/Gf4lZGVP7kg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lZIkOME0AuFeBZVAwdb//g0de6KaxjNMmTl+hGMjWNZqgnk0VdXtrEe2fJvHvSi/u/8cvVNj3OdQR3oyjAEuQYsESVW0LNN4faTUrNljyMHY0CCYLhiCQcfBYNQ9De+7G+9EfiJ1bn+kTN4X1lFvGvMxkQkrAp5GTYjY1PhOJSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Vk5tTvEe; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qsP80l9g; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1875f5e6765511f0b33aeb1e7f16c2b6-20250811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=SWgCyzpDcdIa+u21lnHpzZ/+mzPJVYg/Gf4lZGVP7kg=;
	b=Vk5tTvEe8WJbCujdCTUbMoAdxoj2069/50TW8Uebxj3ix0tPObEuuZ+b6N4mA1XwsjPE3vCTA057GZ8KYRtXHRfKiKpQdYRBw5CtQwYgP+KE0QkZ9kIk9g1iVKgMo3gHof4iZyhXGN2Fnp9BZROb39NWSaVoKD6pxL4R9CRRRjw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:2b53ad65-e902-4e2e-b5e0-7463b888523f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:eb43cc9d-7ad4-4169-ab95-78e9164f00fe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1875f5e6765511f0b33aeb1e7f16c2b6-20250811
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1623927888; Mon, 11 Aug 2025 09:47:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 11 Aug 2025 09:47:03 +0800
Received: from OS8PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 11 Aug 2025 09:47:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TiA1AmJ/aHBsL5OA4A9uhKr6VjlKPTm/PoFwLEXtt+r+cJSiBrVJ1U2nrUXyLkjG98Mtur6eTnC1xYywywKVZqcgwdQQ+mvlZaRhgVC11Ad3Flzkly1uwbfiPXfRRxwKeFAGB0ozNUQ+t6n7HdPFTZ3WsT0eXQsaiMvlJysgPA952fxr/9ciOHFlO8D0yzbaMjC1pb8KXOcnuXQIXmvLFKMNN68WJS+6KAHHGmqP0g4kT8Amn271SA/APmd4fum+2FZdamqCVP+WqK2MpQNAauNcWvl8NIjhU5+B4w7tI3KjB4Sdep9OnCUSrI1UXyDU/syD8NwS/MIIsR9mSRWBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWgCyzpDcdIa+u21lnHpzZ/+mzPJVYg/Gf4lZGVP7kg=;
 b=Kk/6G0LKRavWEoBPopRpinmirtxUoPyrM0/1zjN/uzxEQ0nv7uRHOF59u2pLIWJSv84p1YmpPi62ZzIYEMaJqqQT5unJkPpaxkgSmm8pqieCdugiM74WwdTJjs6Z0RXTnIZt2+xb4lYQqniVwdahrt6/XsOLFRM9TF1INwDGVmGxyrjFUIHqbY8/BzkmngwwEUvsB0VQzdRbwGYsoGCW375tuAKXovHLQpK8SO6bfxAmVRSXXgeqnVBY59o3eabg+I/5MyxYE/gVoqa/jzm97vexNjpSCxNN276t2c8GKsgImde1JlUlNJrp3ocEFpOJUUTi2ss7wvxxudAT8iiWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWgCyzpDcdIa+u21lnHpzZ/+mzPJVYg/Gf4lZGVP7kg=;
 b=qsP80l9gAfENGKZP8e6IVblGN2VZpaLI7UjaHmOKTvqqz1GE44toskHpxsHrGBH49IbR09Bs/G3oiTPYh1VdB/exHKwRyZ9DnJfA9exJGRLxYjtB+h1xmBnMFX516tMS9p31SqlkYbT+lfQxrqX2bU3t+4EvHMB//QVCNkUkL8c=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SEZPR03MB7914.apcprd03.prod.outlook.com (2603:1096:101:186::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 01:47:06 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 01:47:06 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "inbartdev@gmail.com" <inbartdev@gmail.com>
CC: Sean Wang <Sean.Wang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?=
	<Allan.Wang@mediatek.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>
Subject: Re: [REGRESSION] [BISECTED] MT7925 wireless speed drops to zero since
 kernel 6.14.3 - wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Thread-Topic: [REGRESSION] [BISECTED] MT7925 wireless speed drops to zero
 since kernel 6.14.3 - wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Thread-Index: AQHcCGZ+N2cRSRBuyEaLM6TVn70PzbRY0w6AgAPf04A=
Date: Mon, 11 Aug 2025 01:47:05 +0000
Message-ID: <10850475be9302b5b397173c1d4554335c0df966.camel@mediatek.com>
References: <CAJmAMMyOk7AVqQRrtK4Oum2uVKreGeLJ943-kkRCTspoGApZ8w@mail.gmail.com>
	 <CAJmAMMyt5QQQOavVy+Gytf00Y0F6G+GCLYhj0E9RZ8cV85gwCw@mail.gmail.com>
In-Reply-To: <CAJmAMMyt5QQQOavVy+Gytf00Y0F6G+GCLYhj0E9RZ8cV85gwCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SEZPR03MB7914:EE_
x-ms-office365-filtering-correlation-id: b7ebbcff-bbfd-4c3c-a739-08ddd878fa1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WnYzc0lRK3UvSW9HeENua2dhejJEcjlDRjhiK1ZJWE5OWWZFS2FvajJvQVVs?=
 =?utf-8?B?MSswbkpkWDBDMW8vRFo1enhmbGRPVVluQnpGRVhtVzFQazdtNTdMTEpHazQw?=
 =?utf-8?B?bTRYL3E2amlsTmdndkxra1d0UHZpVnRFRjRoTkw0cTkzSFlHU2tWdDRxRXFD?=
 =?utf-8?B?bk5pdlNzTDVST1I0UUhCSkxiK0JRS2duTkw3RFFFZjA0WTNaMEdLQjJlNUor?=
 =?utf-8?B?QVlHR3BETGVmMytXVktlWjNKVUdha3MySGUzZTVZcHpJNEZNeTU5ejF5Nlda?=
 =?utf-8?B?L09UNVJRTGprOTBFdC9xWkN6dEZlb2RRY1JHOFRtclNlUUFqOU5OS1V6amdw?=
 =?utf-8?B?alBzVnV0NktoY3NENW1uZGh0WEJnVEtXbkxwQ2NHUFRxdkgveDZVdit6U2FR?=
 =?utf-8?B?TncrWUQyTUU4VU91cGpsZjE4Vy9kNDJnYXRMT0V2ZEJuUSt6bFlEclMvTThP?=
 =?utf-8?B?a3hIUmRuODNvdGxhRFlZcmxNM1lkZGYxV0g3VUcvTUFIZnhHa2VnRVBpWjd5?=
 =?utf-8?B?eWQ0eXY0a3JsTVVmbWoyQzFhVkRIMlcrOUNaSk93UmVGR0M0aFBzaFR1bVhv?=
 =?utf-8?B?bVJuYVo3MmdCN0tLcll2SXVXZm1HdzBhU2F5NmZnL0tQcnh1d3ZmNk4wRHpq?=
 =?utf-8?B?dzY5T1JJdmJLYjZObGdaL2ZORjZZaDJzTFlKTUJ0Q2FIajB1akYxclVBODRO?=
 =?utf-8?B?TjdjTVJIdHlmNGJNSmFvR1MrNDBOZzYvTCtQMUkrcXUwd0YrVDEzd1Z1M2ZL?=
 =?utf-8?B?ZFBqUXphbHNNSDNsL3dQMUNkK3MwYW0zaGpHU0dwTEZOUURoZGZESWlrNkEz?=
 =?utf-8?B?Z0tKSWZEUE9QNTB3NkhOWVhubTVZdWhtbnBLSEgxb2FnSzBiRVdidnZpMlJJ?=
 =?utf-8?B?SENBMEdkOVFzbFdHbWRvbmxiMEFBd21Zc0I1ZUdNam9oYzhkbWF5OHl4aE5v?=
 =?utf-8?B?SkZtY2c2ZjhVaTFVOVc5WVZUZ1V2RGZ4Z3pxNmQwWjlldjdTVDVsdGtrZ2dj?=
 =?utf-8?B?ZytIU3l5c1VRQyt1VWFYWGpmWHd0TCtnZktLb2dVNTdmdDQzZHI5enc5MExT?=
 =?utf-8?B?UkJ5dGNLS2tkdm1LRytiK1hHZ21GcUlSUGpuYmpTcE1ZMjVoSHJqVmhacHJB?=
 =?utf-8?B?QWxQOUU2NVJyZXNsTDZGSjRrTU1TdVlZQ0hsUnJUYkJpc1dMRGNBNDNiUHp2?=
 =?utf-8?B?bzJvb0JSNDNiVUFaRS8xMlpFcEdRU2gvZ0NFMGlGZHlTZy9aUzAvMzdVS3FX?=
 =?utf-8?B?cDdWWXpQdmhmUDA3eVhXV2w2MnBmN3YrVndrZC9NOUN4T3NJTlBSL0lrOWNW?=
 =?utf-8?B?eDNlQ0FtVCtMQndrUlo3SmVzWHJBczc4MVl6Rlg5ZWY4MEx4eStUNFR2WWQ4?=
 =?utf-8?B?S0JNZ253Z21USm9tai96UU5VeERYai9ERms0b24zZjZ0Q1Jwc055T3JISVM1?=
 =?utf-8?B?bjVBSFgzdmgrbkVmNERoS1NyMGFMZWtxVXo5bzRPYUk3Lyt4VnJUZko1bFhF?=
 =?utf-8?B?REluK09HOVhEMTRFbHdWWmhKbDQ3M2tCdmxzTFJHd3hpeU95K2JsRFVNT3Vw?=
 =?utf-8?B?a2JHM2tLdmM3VlBiNjZDbkRqV0hBMlZWa3g2MTJKelYxdzBFOHgzTGJFUW1k?=
 =?utf-8?B?eTlHb1g2bWt0VlJNM0xyaWhCZ3krVW82TnEzbG9JdEMxeU5BL3VMaXh2MXVa?=
 =?utf-8?B?dkNhR1JkeVk0ai80dlhtWkpLb3RlcmpvVDV0RW13SW9OTEpCZW52YzNRS3Mw?=
 =?utf-8?B?Rnp5R3JoaGNlQ1QvS3Y4UzlpeG5tUGt4UmJtWFcyWmptWEZQbkJLV2Y4TVd0?=
 =?utf-8?B?YzlxSDJUdUhaT2E4NDN2djB4amo2cVZ2a04rOC9JaVkvWkN2ZXlMU1IwUFhu?=
 =?utf-8?B?WmYray9LdmVIcVRmazBOSExLZFVxeXI3Syt4c2huT1d1ZytYUHlkYm1HTU5h?=
 =?utf-8?Q?Q8MQ5lyDKpUZwgkHOMuaE/Unb2MhFaf0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjF5V1hLQ05vVEZpaU05OWxFNi95djlPT29JWE1NTVZGWTFoRWM0bHQ0RHdJ?=
 =?utf-8?B?VlM5eU0rSGlPT3l6Q0pxVUwrYjV3OXFGcE1GRFpTalBVaWd0blFCR0ZWT2Zq?=
 =?utf-8?B?SW5LV1VCSXZKTFEyZXdPRGtHQUpzVWR4eXRta2VDNWJ3VkZUSlEyTWdLUHNR?=
 =?utf-8?B?emJRNWhJVDRIWm94SWNDeWlrNkZQVDExVm0wMFFsQjVjOVZzTHJjWm95OGpO?=
 =?utf-8?B?RlhFVnlJTGtQV3ZFOEoya0U3anlucTJZR2R3bnUzL24wZTdualFoNW54SnpK?=
 =?utf-8?B?L0R4a2doa28rL2sxRkxKUHhHNE1NVE5vd2UrZkovb2IyWHFvOGlBV012OXZR?=
 =?utf-8?B?SGNLdEtsdlB4OFpobGNTSy81ejJkMWJqV09WN2Q2eU9nK2hNUWJjVHU0WXh0?=
 =?utf-8?B?bnRlYWU3TTJYNkpZSXI0RXc0d2R1OXArRy95MElqMDhlVkxEMlpDbXVNRTFC?=
 =?utf-8?B?WHA1Uld4RlNpcHlLQVNTZHR5cHBSeE1nRXBXNm5KWUtnTDlQK2lzYm1TdWFL?=
 =?utf-8?B?aWhsQnA1OS94ZG9ZNjlobXhmR0ZROXpYK3k4Mml1WXNYWEV2NzM2Y204ZFps?=
 =?utf-8?B?YWFOeDlZS3dlQXd1c2FDUmRoQUNCNVRWK25sc2VUdW9GbTNWUE1Ya3RwYmEx?=
 =?utf-8?B?WHdhUGI4Y0JJdUpWTjhZcmZ0enF6L0RYZmdqS0J4RVRZU0xtRXh0dlJBbkpP?=
 =?utf-8?B?eGRIc3phNEM5ZmltK1k5Znl1UEhmYVllV2diWC9FdHlpbjdIUGJHMmFjRXBG?=
 =?utf-8?B?YnVwNFd4aXFrbFBySk9nTXM0a0lMMUVYM1BxNnZYQU1iRGFibkxZQm1jc3or?=
 =?utf-8?B?cFJlTG1CR0ZGQkFDcTNRYWNnaitDbWtlZnNhV2dYVUdxc2dPU3FEM1RYV3Jz?=
 =?utf-8?B?bWNvOVJwaTNRMThwSXY4M1JKZ2VvNWNLblA5bkoyNm5HNVA5VWtVeVBxa0dy?=
 =?utf-8?B?bGZzUGJRRXdnME1obGtMLzU5QzRMMXVyTUN0amMxVmlDUkwzS2pCQTNQcDND?=
 =?utf-8?B?RVhDbVc0ZGo3dVZMcTVBdGJ5Nmx0a1lwVktvZ2RUMm1YYWtCVUFvaVR4M1p6?=
 =?utf-8?B?ZHJydS9XL3pEcFQxdkRLMVlBMXdtQkt3c2htbk9RZ1VFTE9ONzBLNm5zT0Nj?=
 =?utf-8?B?akh0OGxTTlUrWXVVUlNFWnZyeHhHc1lQcmdPL250eG5EYTNJbnV3L0daTjhR?=
 =?utf-8?B?aGtKQzl3ZjN6UDRpMDQzcHpNeFIzdW1zbktLVTd0UXpCY2NXcjl2N3JZL1Z6?=
 =?utf-8?B?YnRMa0ZDZnlWUDRZTDRmSzBxc1NjWlM0MFpzMkNKZHM3dXgvNEt5VzQraXJt?=
 =?utf-8?B?NVg3NElZcld4QkFjZmYvcXZ5dHZ5eFRhbER0dTRCeVA3dktTaitiUlBLNUJQ?=
 =?utf-8?B?dXd5M293Tk9BM2s5bHFoZVNYWUp4TEVrNUF2SGxFK2hmaUp5ZUNwUlNuS1dI?=
 =?utf-8?B?ekJBRk5vNENCUFlKQjFWblh2MWhoaUFYUHhvTWpoRWFna1dpNzRtLzRISjVH?=
 =?utf-8?B?YUlFUnBhQUVUVlpQZlc2MWlKbGNjbGI4R1Y2cnN0N09FcHRNQU5YWmpPZ3I1?=
 =?utf-8?B?M0RDUHpNNmhNRTl2L3JzamRRdHV0a2RwMlVYMzVLQ0tMbDNJMVNXRkFzUWQ3?=
 =?utf-8?B?a3lSaDJKWnYydUk1VEtOcWc0MTZjc1ovcTRyRXJzVzQ0czBXQ0ZTQ0VjTnB0?=
 =?utf-8?B?TTVpN2JBRFgyMm5ONUt5VWpOR09CY1U1TnE3R0ZHNXJERXh4TzlzWTExU3lX?=
 =?utf-8?B?cVNFSk1Fb0s3VkpSUlpiblMxQ0o3NVRobm9hbVFGQXNUek03b3hPNm4raE01?=
 =?utf-8?B?Uk8wbnFsZ3g3NC8xRHZhSVFkYjlnZ2JFanRtamcxRXhXNG9PS0YxVU9XdW9J?=
 =?utf-8?B?b1BjR0k2RVVodnhUTEJ4blkrcEdNa2x6UkpRWmY3Rksyd2JrbEVVdURtWmdM?=
 =?utf-8?B?RHoyakhOT1FRazFKU3hXcjA2L0wrc1BpZmFZdTJ6OGYxUTFnTnQxWk1teFR4?=
 =?utf-8?B?dHA2b2FTMWpsZndUbzBYcFA1TnZ3ZXZya0IwL2s3bEFFSE9KSGxzNi9YMWh3?=
 =?utf-8?B?bTI0TkcvU0VmeFZ2R2g3NDd3QnljNWIzaUhZdi8xWVd6VTNXQ29vNTZ5c1JU?=
 =?utf-8?B?bzVBditaTkhWZUxxSWl2TzVTTWJielFvUTI5eGRMaldzeDU3eHVGVTdMaG00?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F124394ED0917F458BFA4376101B5C98@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ebbcff-bbfd-4c3c-a739-08ddd878fa1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 01:47:05.9930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhCSeKv1kCpLsVb1ABf8j0LoNWlUUwgtfaqx/m14LGDvHdR8INpRlvxOhSa6lDZ2SxmTzcSh/YK4LckLpr7eVJaRKZwxN+FJdnBAvisGWX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7914

T24gRnJpLCAyMDI1LTA4LTA4IGF0IDE3OjM3ICswMzAwLCBUYWwgSW5iYXIgd3JvdGU6DQo+IA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IHR5cG8sIGxhcHRvcCBtb2RlbCBpczoNCj4gTGVub3ZvIElkZWFQYWQg
U2xpbSA1IDE2QUtQMTANCj4gDQo+IE9uIEZyaSwgQXVnIDgsIDIwMjUgYXQgNDoxNOKAr1BNIFRh
bCBJbmJhciA8aW5iYXJ0ZGV2QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gSGksDQo+ID4g
DQo+ID4gU2luY2Uga2VybmVsIHY2LjE0LjMsIHdoZW4gdXNpbmcgd2lyZWxlc3MgdG8gY29ubmVj
dCB0byBteSBob21lDQo+ID4gcm91dGVyDQo+ID4gb24gbXkgbGFwdG9wLCBteSB3aXJlbGVzcyBj
b25uZWN0aW9uIHNsb3dzIGRvd24gdG8gdW51c2FibGUgc3BlZWRzLg0KPiA+IA0KPiA+IA0KPiA+
IE1vcmUgc3BlY2lmaWNhbGx5LCBzaW5jZSBrZXJuZWwgNi4xNC4zLCB3aGVuIGNvbm5lY3Rpbmcg
dG8gdGhlDQo+ID4gd2lyZWxlc3MgbmV0d29ya3Mgb2YgbXkgT3BlbldSVCBSb3V0ZXIgb24gbXkg
TGVub3ZvIElkZWFQYWQgU2xpbSAxNQ0KPiA+IDE2QUtQMTAgbGFwdG9wLA0KPiA+IGVpdGhlciBh
IDIuNGdoeiBvciBhIDVnaHogbmV0d29yaywgdGhlIGNvbm5lY3Rpb24gc3BlZWQgZHJvcHMgZG93
bg0KPiA+IHRvDQo+ID4gMC4xLTAuMiBNYnBzIGRvd25sb2FkIGFuZCAwIE1icHMgdXBsb2FkIHdo
ZW4gbWVhc3VyZWQgdXNpbmcNCj4gPiBzcGVlZHRlc3QtY2xpLg0KPiA+IE15IGxhcHRvcCB1c2Vz
IGFuIG10NzkyNSBjaGlwIGFjY29yZGluZyB0byB0aGUgbG9hZGVkIGRyaXZlciBhbmQNCj4gPiBm
aXJtd2FyZS4NCj4gPiANCj4gPiANCj4gPiBEZXRhaWxlZCBEZXNjcmlwdGlvbjoNCj4gPiANCj4g
PiBBcyBtZW50aW9uZWQgYWJvdmUsIG15IHdpcmVsZXNzIGNvbm5lY3Rpb24gYmVjb21lcyB1bnVz
YWJsZSB3aGVuDQo+ID4gdXNpbmcNCj4gPiBsaW51eCA2LjE0LjMgYW5kIGFib3ZlLCBkcm9wcGlu
ZyBzcGVlZHMgdG8gYWxtb3N0IDAgTWJwcywNCj4gPiBldmVuIHdoZW4gc3RhbmRpbmcgbmV4dCB0
byBteSByb3V0ZXIuIEZ1cnRoZXIsIHBpbmdpbmcNCj4gPiBhcmNobGludXgub3JnDQo+ID4gcmVz
dWx0cyBpbiAiVGVtcG9yYXJ5IGZhaWx1cmUgaW4gbmFtZSByZXNvbHV0aW9uIi4NCj4gPiBBbnkg
b3RoZXIgd2lyZWxlc3MgZGV2aWNlIGluIG15IGhvdXNlIGNhbiBzdWNjZXNzZnVsbHkgY29ubmVj
dCB0bw0KPiA+IG15DQo+ID4gcm91dGVyIGFuZCBwcm9wZXJseSB1c2UgdGhlIGludGVybmV0IHdp
dGggZ29vZCBzcGVlZHMsIGVnLiBpcGhvbmVzLA0KPiA+IGlwYWRzLCByYXNwYmVycnkgcGkgYW5k
IGEgd2luZG93cyBsYXB0b3AuDQo+ID4gV2hlbiB1c2luZyBteSBMZW5vdm8gbGFwdG9wIG9uIGEg
a2VybmVsIDYuMTQuMyBvciBoaWdoZXIgdG8gY29ubmVjdA0KPiA+IHRvDQo+ID4gb3RoZXIgYWNj
ZXNzIHBvaW50cywgc3VjaCBhcyBteSBpUGhvbmUncyBob3RzcG90IGFuZCBzb21lIFRQTGluaw0K
PiA+IGFuZA0KPiA+IFp5eGVsIHJvdXRlcnMgLSB0aGUgY29ubmVjdGlvbiBzcGVlZCBpcyBnb29k
LCBhbmQgdGhlcmUgYXJlIG5vDQo+ID4gaXNzdWVzLA0KPiA+IHdoaWNoIG1ha2VzIG1lIGJlbGll
dmUgdGhlcmUncyBzb21ldGhpbmcgZ29pbmcgb24gd2l0aCBteSBPcGVuV1JUDQo+ID4gY29uZmln
dXJhdGlvbiBpbiBjb25qdW5jdGlvbiB3aXRoIGEgY29tbWl0IGludHJvZHVjZWQgb24ga2VybmVs
DQo+ID4gNi4xNC4zDQo+ID4gZm9yIHRoZSBtdDc5MjVlIG1vZHVsZSBhcyBkZXRhaWxlZCBiZWxv
dy4NCj4gPiANCj4gPiBJIGhhdmUgZm9sbG93ZWQgYSByZWxhdGVkIGlzc3VlIHByZXZpb3VzbHkg
cmVwb3J0ZWQgb24gdGhlIG1haWxpbmcNCj4gPiBsaXN0IHJlZ2FyZGluZyBhIHByb2JsZW0gd2l0
aCB0aGUgc2FtZSB3aWZpIGNoaXAgb24ga2VybmVsIDYuMTQuMywNCj4gPiBidXQNCj4gPiB0aGUg
bWVyZ2VkIGZpeCBkb2Vzbid0IHNlZW0gdG8gZml4IG15IHByb2JsZW06DQo+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWF0ZWsvRW1Xbk81Yi1hY1JIMVRYYkdua3g0MWVKdzY1
NHZtQ1ItOF94TUJhUE13ZXhDbmZrdktDZGxVNXUxOUNHYmFhcEozS1J1LWwzQi10U1VoZjhDQ1F3
TDBvZGpvNkNkNVlHNWx2TmVCLXZmZGc9QHBtLm1lLw0KPiA+IA0KPiA+IEkndmUgdGVzdGVkIHN0
YWJsZSBidWlsZHMgb2YgNi4xNSBhcyB3ZWxsIHVwIHRvIDYuMTUuOSBpbiB0aGUgbGFzdA0KPiA+
IG1vbnRoLCB3aGljaCBhbHNvIGRvIG5vdCBmaXggdGhlIHByb2JsZW0uDQo+ID4gSSd2ZSBhbHNv
IGJ1aWx0IGFuZCBiaXNlY3RlZCB2Ni4xNCBvbiBqdW5lIHVzaW5nIGd1aWRlcyBvbiB0aGUgQXJj
aA0KPiA+IExpbnV4IHdpa2ksIGZvciB0aGUgZm9sbG93aW5nIGJhZCBjb21taXQsIHNhbWUgYXMg
dGhlIHByZXZpb3VzbHkNCj4gPiBtZW50aW9uZWQgcmVwb3J0ZWQgaXNzdWU6DQo+ID4gDQo+ID4g
WzgwMDA3ZDNmOTJmZDAxOGQwYTA1MmE3MDY0MDBlOTc2YjM2ZTNjODddIHdpZmk6IG10NzY6IG10
NzkyNToNCj4gPiBpbnRlZ3JhdGUgKm1sb19zdGFfY21kIGFuZCAqc3RhX2NtZA0KPiA+IA0KPiA+
IFRlc3RpbmcgZnVydGhlciB0aGlzIHdlZWssIEkgY2xvbmVkIG1haW5saW5lIGFmdGVyIDYuMTYg
d2FzDQo+ID4gcmVsZWFzZWQsDQo+ID4gYnVpbHQgYW5kIHRlc3RlZCBpdCwgYW5kIHRoZSBpc3N1
ZSBzdGlsbCBwZXJzaXN0cy4NCj4gPiBJIHJldmVydGVkIHRoZSBmb2xsb3dpbmcgY29tbWl0cyBv
biBtYWlubGluZSBhbmQgcmV0ZXN0ZWQsIHRvDQo+ID4gc3VjY2Vzc2Z1bGx5IHNlZSBnb29kIHdp
cmVsZXNzIHNwZWVkczoNCj4gPiANCj4gPiBbMGFhODQ5NmFkZGE1NzBjMjAwNTQxMGEzMGRmOTYz
YTE2NjQzYTNkY10gd2lmaTogbXQ3NjogbXQ3OTI1OiBmaXgNCj4gPiBtaXNzaW5nIGhkcl90cmFu
c190bHYgY29tbWFuZCBmb3IgYnJvYWRjYXN0IHd0YmwNCj4gPiBbY2IxMzUzZWYzNDczNWVjMWU1
ZDllZmExZmU5NjZmMDVmZjFkYzFlMV0gd2lmaTogbXQ3NjogbXQ3OTI1Og0KPiA+IGludGVncmF0
ZSAqbWxvX3N0YV9jbWQgYW5kICpzdGFfY21kDQo+ID4gDQo+ID4gVGhlbiwgcmV2ZXJ0aW5nICpv
bmx5KiAwYWE4NDk2YWRkYTU3MGMyMDA1NDEwYTMwZGY5NjNhMTY2NDNhM2RjDQo+ID4gY2F1c2Vz
DQo+ID4gdGhlIGlzc3VlIHRvIHJlcHJvZHVjZSwgd2hpY2ggY29uZmlybXMgdGhlIGlzc3VlIGlz
IGNhdXNlZCBieQ0KPiA+IGNvbW1pdA0KPiA+IGNiMTM1M2VmMzQ3MzVlYzFlNWQ5ZWZhMWZlOTY2
ZjA1ZmYxZGMxZTEgb24gbWFpbmxpbmUuDQo+ID4gDQo+ID4gSSd2ZSBhdHRhY2hlZCB0aGUgZm9s
bG93aW5nIGZpbGVzIHRvIGEgYnVnemlsbGEgdGlja2V0Og0KPiA+IA0KPiA+IC0gbHNwY2kgLW5u
ayBvdXRwdXQ6DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vYnVnemls
bGEua2VybmVsLm9yZy9hdHRhY2htZW50LmNnaT9pZD0zMDg0NjZfXzshIUNUUk5LQTl3TWcwQVJi
dyFnVEFhSmVJTjZzM2VGX0twNlUzaXdmdjB3Q0NPX0JWY1JrTlZwSllud1I4cWVxSUloMTM0bUVK
NWR4ZGVOcXp1V1NQRjJvY0xBdDQzTHhhQlRJWS03dyQNCj4gPiANCj4gPiAtIGRtZXNnIG91dHB1
dDoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL2F0dGFjaG1lbnQuY2dpP2lkPTMwODQ2NV9fOyEhQ1RSTktBOXdNZzBBUmJ3IWdUQWFK
ZUlONnMzZUZfS3A2VTNpd2Z2MHdDQ09fQlZjUmtOVnBKWW53UjhxZXFJSWgxMzRtRUo1ZHhkZU5x
enVXU1BGMm9jTEF0NDNMeFkxcGtqWkNBJA0KPiA+IA0KPiA+IC0gLmNvbmZpZyBmb3IgdGhlIGJ1
aWx0IG1haW5saW5lIGtlcm5lbDoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL2F0dGFjaG1lbnQuY2dpP2lkPTMwODQ2N19fOyEhQ1RS
TktBOXdNZzBBUmJ3IWdUQWFKZUlONnMzZUZfS3A2VTNpd2Z2MHdDQ09fQlZjUmtOVnBKWW53Ujhx
ZXFJSWgxMzRtRUo1ZHhkZU5xenVXU1BGMm9jTEF0NDNMeFljdS1EYjJnJA0KPiA+IA0KPiA+IA0K
PiA+IE1vcmUgaW5mb3JtYXRpb246DQo+ID4gDQo+ID4gT1MgRGlzdHJpYnV0aW9uOiBBcmNoIExp
bnV4DQo+ID4gDQo+ID4gTGludXggYnVpbGQgaW5mb3JtYXRpb24gZnJvbSAvcHJvYy92ZXJzaW9u
Og0KPiA+IExpbnV4IHZlcnNpb24gNi4xNi4wbGludXgtbWFpbmxpbmUtMTE4NTMtZzIxYmU3MTFj
MDIzNQ0KPiA+ICh0YWxAYXJjaC1kZWJ1ZykgKGdjYyAoR0NDKSAxNS4xLjEgMjAyNTA3MjksIEdO
VSBsZCAoR05VIEJpbnV0aWxzKQ0KPiA+IDIuNDUuMCkgIzMgU01QIFBSRUVNUFRfRFlOQU1JQw0K
PiA+IA0KPiA+IE9wZW5XUlQgVmVyc2lvbiBvbiBteSBSb3V0ZXI6IDI0LjEwLjINCj4gPiANCj4g
PiBMYXB0b3AgSGFyZHdhcmU6DQo+ID4gLSBMZW5vdm8gSWRlYVBhZCBTbGltIDE1IDE2QUtQMTAg
bGFwdG9wICh4ODZfNjQgUnl6ZW4gQUkgMzUwIENQVSkNCj4gPiAtIE5ldHdvcmsgZGV2aWNlIGFz
IHJlcG9ydGVkIGJ5IGxzY3BpOiAxNGMzOjc5MjUNCj4gPiAtIE5ldHdvcmsgbW9kdWxlcyBhbmQg
ZHJpdmVyIGluIHVzZTogbXQ3OTI1ZQ0KPiA+IC0gbWVkaWF0ZWsgY2hpcCBmaXJtd2FyZSBhcyBv
ZiBkbWVzZzoNCj4gPiDCoCBIVy9TVyBWZXJzaW9uOiAweDhhMTA4YTEwLCBCdWlsZCBUaW1lOiAy
MDI1MDUyNjE1Mjk0N2ENCj4gPiDCoCBXTSBGaXJtd2FyZSBWZXJzaW9uOiBfX19fMDAwMDAwLCBC
dWlsZCBUaW1lOiAyMDI1MDUyNjE1MzA0Mw0KPiA+IA0KPiA+IA0KPiA+IFJlZmVyZW5jaW5nIHJl
Z3pib3Q6DQo+ID4gDQo+ID4gI3JlZ3pib3QgaW50cm9kdWNlZDogODAwMDdkM2Y5MmZkMDE4ZDBh
MDUyYTcwNjQwMGU5NzZiMzZlM2M4Nw0KPiA+IA0KPiA+IA0KPiA+IFBsZWFzZSBsZXQgbWUga25v
dyBpZiBhbnkgb3RoZXIgaW5mb3JtYXRpb24gaXMgbmVlZGVkLCBvciBpZiB0aGVyZQ0KPiA+IGlz
DQo+ID4gYW55dGhpbmcgZWxzZSB0aGF0IEkgY2FuIHRlc3Qgb24gbXkgZW5kLg0KPiA+IA0KPiA+
IFRoYW5rcywNCj4gPiBUYWwgSW5iYXINCg0KSGksDQoNCkNhbiB5b3UgY2FwdHVyZSBhIHNuaWZm
ZXIgbG9nPyBUaGVyZSBzaG91bGQgYmUgc29tZSBjb25maWd1cmF0aW9uDQpkaWZmZXJlbmNlcyB0
aGF0IHdlIGNhbiBpZGVudGlmeSBmcm9tIHRoZSBwYWNrZXQgZnJhbWVzIGR1cmluZyB0aGUNCmNv
bm5lY3Rpb24gcHJvY2Vzcy4gU28gcGxlYXNlIHByb3ZpZGUgdGhlIHNuaWZmZXIgbG9ncyB3aGVu
IGNvbm5lY3RpbmcNCnRvIHlvdXIgT3BlbldSVCwgVFBMaW5rLCBhbmQgWnl4ZWwuDQoNCk9yIHlv
dSBjYW4gY2hlY2sgZm9yIGFueSBjb25maWd1cmF0aW9uIGRpZmZlcmVuY2VzIGJldHdlZW4gT3Bl
bldSVCBhbmQNCnRoZSBvdGhlciByb3V0ZXJzLCB3aGljaCBtaWdodCBhbHNvIGhlbHAgd2l0aCBk
ZWJ1Z2dpbmcuDQoNClRoYW5rc34NCg0KWWVuLg0KDQo=

