Return-Path: <stable+bounces-216021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLvIEme5jmm3EAEAu9opvQ
	(envelope-from <stable+bounces-216021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 06:40:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9651330AF
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 06:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29C14302001B
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049AB2701CF;
	Fri, 13 Feb 2026 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="pf7UhLjA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545BE24677B;
	Fri, 13 Feb 2026 05:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961248; cv=fail; b=TxZYeaDpPhPSHBeEdO2xQM0j/jErn1h9Dxzz3esVN0NFfUddKMgjmURNxJhqeJOuYMhUvnsNr+a27tonWBd/cH919Q6RaVZXIsGmsruqkoXZhAqnEqPqALxLC5KV71/Ib1XoBpui02kSJwala1MrymirlBfETrd9jEMSbjvKrsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961248; c=relaxed/simple;
	bh=P9SrcgYrm/9t6iaS8qtnZvRDRkw4QwZ9vCquNNzcv90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XCkAD/xtQvy9l08N9hJD0Q+a28mvN5HnZYO0cf6PSN5HEFYVMSntcmEq8fipxk25caWyDgMLfS287cG5PDfJZdBMzvmG+3YAycGC6Zubb8xeeNG7rcx46xE5hp7L7D1reAs6RoM4pGwhwPXtoqfDEVftJ+FmnOf5u0BmoC9p3gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=pf7UhLjA; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D5cpL23551241;
	Thu, 12 Feb 2026 21:40:33 -0800
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020072.outbound.protection.outlook.com [52.101.46.72])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4c9x07803c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 21:40:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxeAlFiblH1zkOObGFXsGz0zZGgGbZXGiE6x7Xgugo6F4fRuSK8+kPbxb/LXUgH+ddmIs+OIh2nRSuvFYChNjmXb6VLrcAqBV0rvqCYcKE/p72m0cysgsdqoHkML+v7mVnIkDBtF4FV8ItsJ4TKwV6NWv5RFWwvxeDhkmfuoQc25XmF0BOVAOogIm2zZhoRenMXwje5AWJ/WxjkFbgc093iAMUurCrxSoftqJDiwiscYYtyak9fiICj6UZg1y8lY2/9fHb87D1eUAgU8VyYfqduXRGh69D/31jNbV/7Q3lhOfXSSvd6D8hQOnBLjYJbhLZJ8KBYQumWqJWRAA5vaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9SrcgYrm/9t6iaS8qtnZvRDRkw4QwZ9vCquNNzcv90=;
 b=mmxRTWYsCpcGi0IxomIdqo43rEui/LM1S93dQTqZcud9aDyzBk/klAoa9eSNct/McYEWcNxihxHzgJoGIaTzgzdvX5QlIlxxKsYaqsacOrdm/kBbC2zzBbk1s2Yd65jL/cOUu565mnV3iOqgJ6VVmRmxeAoM8FfQFQgYUmvkLijZ93+V4FSgBvW+oRCtr/FV9+x0k5Ou1SnCCI6qal00NOj99tFfNEgYvJRzD9fAqg0JA8oKfIhXTneSdSKMnr5y0e2wWeL1HedVYAgT3xxKanh929sPcxTuBytc+iWzQzNp1omPTsQ7wwvdZnAsTWsVFakBTDhdU1w2kI3AHQFWmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9SrcgYrm/9t6iaS8qtnZvRDRkw4QwZ9vCquNNzcv90=;
 b=pf7UhLjASqCEljGKYn3v8Dt2BVyRl7GsXezMw9NWjO/r4BjcSsHbKrfyutTNZY1nbWgzR/kAE7x4rMOuB05svukdHpB/IjRhXvKflCu4OXgsr3YG9u1DXTSDlmOcQxu/z1UNMbrM4wt0rvwz9pgTi170wE0JLVhLPQu0E5/cGbo=
Received: from BY1PR18MB6374.namprd18.prod.outlook.com (2603:10b6:a03:5aa::19)
 by SJ0PR18MB4044.namprd18.prod.outlook.com (2603:10b6:a03:2ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 05:40:29 +0000
Received: from BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374]) by BY1PR18MB6374.namprd18.prod.outlook.com
 ([fe80::7a39:16fc:86:c374%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 05:40:29 +0000
From: Srujana Challa <schalla@marvell.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jasowang@redhat.com"
	<jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Nithin Kumar
 Dabilpuram <ndabilpuram@marvell.com>,
        Shiva Shankar Kommula
	<kshankar@marvell.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3,net] virtio_net: Improve RSS key size
 validation
Thread-Topic: [EXTERNAL] Re: [PATCH v3,net] virtio_net: Improve RSS key size
 validation
Thread-Index: AQHcnCAJMYpvZMYZg06OdIkBQuY/bbV/IuiAgAD2k8A=
Date: Fri, 13 Feb 2026 05:40:29 +0000
Message-ID:
 <BY1PR18MB637428F39A68562CF5233E67A061A@BY1PR18MB6374.namprd18.prod.outlook.com>
References: <20260212130340.3540415-1-schalla@marvell.com>
 <20260212093707-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260212093707-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR18MB6374:EE_|SJ0PR18MB4044:EE_
x-ms-office365-filtering-correlation-id: c15f29bf-c308-429c-203b-08de6ac2658a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SE1zN0VlWG5Sdmo5ZjU2T3pNWmsrcHluZUVJRlNiQ3ZOZXE4VEpoWGgyS1FU?=
 =?utf-8?B?ajVpWG1mM0lrMnZIY1o3aUtPMElvZ0xEZkpvNm45TGh6SlZFSk5vWHAzSjIz?=
 =?utf-8?B?UTdQeEREbUtveXoyTFJOVGhXV3NGd1k1Sm03UFRESytDbVF4eXRJcm9CaW41?=
 =?utf-8?B?cjNEZTdFQXFpQTR6bFJNa3Z3dDQ0MDQxZ0IxZVh2Um5QVzRXbzE0MjZnM1BU?=
 =?utf-8?B?c3o4TjVML1VaY1oxZUJtR3dYR1Z3NXpYTXRQaGFOZktxb1BISkRYN3FXTVBB?=
 =?utf-8?B?ajZkV3pQYlVUL1RJcHJXRW5RYWw2b2J2UTRlUld1NVN5THJuTUV6K1dvenZh?=
 =?utf-8?B?ZXBVd3lNR0hyOUJkQWRVMlFUK2RVenRWU0o1bDhVdE80MlM5V21kZzdvcm1O?=
 =?utf-8?B?SzJjbWUrYlVjdlpXZGpBQ1VjU0dEaGJxNFRrKytjR01adUZXT0VWK3g1b0Vu?=
 =?utf-8?B?K0ZLYlEyMU9Qb0xZcnJGQnpzTlphYnRXSUpUa0VoMWFEOWtsNzZIMjBJSlNT?=
 =?utf-8?B?RlRBYmNCTHNHbW50b1Y3L1Jlc2ZnTVE3NHNJdnIrdFc3ZzNkczVUSGFrSDNq?=
 =?utf-8?B?NDVCbjlGNnduVWdCeEFYd1pCYUR6SFRKd2R3N1o4Q3pHV05MQ2lpWHhmUUZm?=
 =?utf-8?B?SGZBdno2VERVMlRuUktFdkhFUUpETnowSldDT0Y5NFRSL1cwUEFON1o4UmdG?=
 =?utf-8?B?VnEyQkpybUJMMDFsWGo2NGJVWitpMWRKOXhhSWN4TW9Db2w3ZUJQYlpqdy9i?=
 =?utf-8?B?UEdTQzRKaUhJUlhidTFDZHd2MGI0RzNHaGNNc2hOTjFYUGxsOHlYdy8zS0VW?=
 =?utf-8?B?blVCalZSblNlbk96cDd5Y3c1VGUzeUp5OHl2R3cvbHUrbUVzU2k0NnVMR0hY?=
 =?utf-8?B?QmlPOFg3S3RsRE9LOXBFb01wTXhWb2pjQ3BDcVUzQnhZVzVUaXlUOHF3UFZX?=
 =?utf-8?B?WTVUTWhYSC9Yc3VjbFVwYnRrZFNjbGU5UlVBK0FNR2hBRm9tNXA4eVpidmtC?=
 =?utf-8?B?THgyeUUyRlkxTWJqQms1NUZmSnN3WUE5WWVPcHZHWDVNN1JvQ3Rua1JBajh0?=
 =?utf-8?B?YmJEZTg5dStVMThBeHBOZTVsYnVLV0FVZXMwMGQ4M28wOERuSlNiU0hGUWxa?=
 =?utf-8?B?RkR3ZE5URUM1QlJIMnl0R3NReEhhZXY2ZzhiODlJRG1OR1dmVVNBb3k3TVdp?=
 =?utf-8?B?SWRWbjludVR5NFBxLzI4aTBQbXJHK3FoZFVJTWUvcWMwY09BRkIxcy9QS2ly?=
 =?utf-8?B?cFFITHBZUlBBUk93VHN2dE9OU1J3U0hhTnBHOWFIRGJTSWRteEF5YlRBNGgy?=
 =?utf-8?B?bTF0REZTNHo3VThNQzl2eHhUNmowWjJSTDhQaG90QWxFWUx5WGhOYkZ1bFFZ?=
 =?utf-8?B?MkVUaEtkQjc0N2JFcHZXa1RkN0tXVEVndU92OWFTajdHMkpPN0MrUXlWN3BJ?=
 =?utf-8?B?NTJsUUx4MmdsanhiTVBIWWw4b3lkZndaY2d6KzNrVWFxN1piY0F3QVp3cUgv?=
 =?utf-8?B?NFlhTC8rbEg4eTVFUVl5bEllR0FKdG40U2lwOXVoNnk2czV5T09jV1Z6KzR1?=
 =?utf-8?B?ZVBPeGtGeEhpREJaWEFROXhEbDdIQmkvZVdaTmhLSjF6aWJ0QUNvSXNEdkhV?=
 =?utf-8?B?THlvdnFlWUVSMnR1U0lVYXQ3YVgvanlkRHhnTFV6dmh3bVZObCthZnBjU2lw?=
 =?utf-8?B?MFR1am1kWVFvVHgxcDBBb09VTmUwODNxSDkyNmRHRVl6Ulo5OVpYTmdIVjBt?=
 =?utf-8?B?RlordkJlNjVpcFhZRURiVGJBNFNjMGhRVEdxMlh3anNTRW8xRjJNL2wrY202?=
 =?utf-8?B?bW9jS3E4THJwb1g1UG9lUXAzZjJLQXRsY01WR1FFYUdTdW9yUTNCMmMyZ3pL?=
 =?utf-8?B?c1BERWlpUHFuclRERHhnTWtzZS9mZG9JUEJ3UlNQaVdOVThDZlVxQVBIenJy?=
 =?utf-8?B?Z1B0SXY3TlorRlNNZG9vUW9ZVU5NeW81NVllR3BSMGVKNDBvTzd3d1NsRjU1?=
 =?utf-8?B?RFBOVG9YRkF0ZUd1cklDV3RGOXU3QkZRTU9oZW9aSjJEY3hPUmpQTzhOcC9v?=
 =?utf-8?B?bkZzMWw1UTd4d3Z3aUZGODF3QVlGTUxiZTVLcHNUR2JXMHNHSlI3Tlh0bUt6?=
 =?utf-8?B?ZmkwNi9nOEtrdkZEY25objVDUUs4a09oNkM4cWtrUUhmNUltN3FBeE9JblpB?=
 =?utf-8?Q?NLa/KIwGdFxyJybP0OiSxC4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR18MB6374.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWJvWW8xY1dLV0xTL0hoU3lxdWxYVEVVdHU0NlJsRGI1ZTZPWW1HMXBkenNW?=
 =?utf-8?B?cEoveE4zK0pEVEtQVDluMjdzVjcxTGYrdDhpVExhYTIrZXJlZkViT29vdlNq?=
 =?utf-8?B?QjZxSzVpWDJnWGJSNFZ4QnlaQnZCOTF4dW9aNDBWNXMyaEpJUWpTbGw4NTNS?=
 =?utf-8?B?aGgzSnYrOEo2MHJlSWgxUWNvNWtWVXRYZ05kbkJHdWtHODZUbjQ0b0xTN3ZD?=
 =?utf-8?B?dy9rRC9ydzM4UERPSU9qMEVkWjIyMGxGa0VXL0VtcmJWa3U3R2VTR0N3Mi9P?=
 =?utf-8?B?YWJzcUk3UTM0UHJGL2UrRWVPZG03cXlGZG1QT05wMFhxYkl6WS8rZzhMZjQv?=
 =?utf-8?B?Q0NHem45cmtsaWJpWXNWN1BaRzE3cE5wQkR4ait3dlR4TFhRK2RCcWlvQWdU?=
 =?utf-8?B?NHphUnRlemFxN2plU20xdE03cEdJRUhITmE1NVQzMEpSOHhqUU0wSDdiV0U2?=
 =?utf-8?B?enlZeS9rVHUxR084d3F2bnJnN1JQaDB5MHlnb004MWRjZi91RXhRSG9LejQ2?=
 =?utf-8?B?enlTK0szaE9PZG5NWDh1Mk5IK2xHYUF2TGJMVWpkRTBSSTZRdkYvVjhWYUpT?=
 =?utf-8?B?NVdpM3RQbWJpSzJ2OWxSUENqRjFDRDdnWDlxZEhhaU1ONUx0MHZSNDlzb3NO?=
 =?utf-8?B?T3dFUmlKU3FyWFJwMStVdkUwMzJyQWhiT1VmTmtEL2R4UW9nWWdvMExNV2l5?=
 =?utf-8?B?alovbFc2c1FRM0V2R0cyTWxJbGliYUs2MlJXdHBVOU43emhna2JaSVFQSTNp?=
 =?utf-8?B?dDNjNzlLTW5mMDBrOFdNamszMEFCbHBwQlZrTGZwVDdvMStUa0NUQVRTNnJa?=
 =?utf-8?B?OC9JYjNyZTJZTm9SaWl2OUxZZ0tDNlQzdmppZEtSWHNZZTU1TjhrQVZjczRC?=
 =?utf-8?B?a0hTN0dOUGZaalFWVGQ3QURhVDVuKzVSZjZiZXdxaW9wV3Y0TXY2SkFkM1hQ?=
 =?utf-8?B?QkJOSTFHMWJSWmhXSU5OMDlJblliNG1EUis3Q3YyZ2J4ZVJpR25pL1Mvd0F5?=
 =?utf-8?B?bXR3L3NyV2hZZmsvTEgvTjdyd2ZzNnhrV1V2QzJmc1dESFY3ZDFRZGRLOHZq?=
 =?utf-8?B?WHVsc29hOEJlcEpjQXdRNnBPeWlUUFJCOVp5Syt3Zncza3NjZGhyUVJmUWJI?=
 =?utf-8?B?QlNtSW1wdXJrL1hoc2hDRUNBZmpKUzR0TzZKTE1ZdjhsekFnclEvM2lRbHNy?=
 =?utf-8?B?RFJ3N01GbUpaNCt6aVpWa3VsQUZOVWIrVFcwQVF5ZUc1M0ROOTgxaStLM1JG?=
 =?utf-8?B?VW5jcDBsL0xKOE9CZ0Z5cHdsdGNoeXN4NFc0RTJLcEFQb2hXUmVWNVZCeHFQ?=
 =?utf-8?B?Z09zbHlmblR6anFET05QaGNEbFJ1MGNkTmQyTVRKNXhnQW5MMFRWRS9YYmlK?=
 =?utf-8?B?RmZNMjZzUk5UTjVwb3hiVmhGbCtJdlcwK08yamFiR0FOR1VNL3NZR0tkNm1N?=
 =?utf-8?B?bDRjQXViSUdFWGpITGhmVnVzMFlnM001M0JKQmxyaGpQRjVDN1N4R0p3eHFZ?=
 =?utf-8?B?S1ZzdU1vUExTcHpzdHhIV1VvNmh3UWVodWlJY29oRnJKTnlna2loa25SREYv?=
 =?utf-8?B?eDc4bHcrb052Y3ZSb1VSSkJWeFhNc09BdHFHOWp3Zi9BUnQ2K0NTMU13MlF3?=
 =?utf-8?B?dmJ2REVuM0Q3c09TSFl1RVgvUExDOGJlSU1BR05adjBNdTVqaDB0ZjlCVWoz?=
 =?utf-8?B?UmxybW1zKzVXbzNXTjQ1ai8zU2psajBndURBaXZCdS85Zmd5ZW9EbXBlV3Z3?=
 =?utf-8?B?Nktta3Y4QlBnTVRwUHZGM3pQSy9XVS9wejY1ZmI4N3dzYkhUdnBzeWQ5ZHI4?=
 =?utf-8?B?UG1XcHhxQzdtTVFVSU5YZmpzQU0rSjlJOHFLSkc5TzhxZFdvZmZ6L3llZ1Jv?=
 =?utf-8?B?V0RvZE54ZWRNOHZZdEpTeDBkZEtaR1d1bGU5Y0VtUnMxdFk3SGRpblEvdjg4?=
 =?utf-8?B?T3FUdGpwSnVaWm9iNmxsYURsVmNReFNObW5CYWZJRHd6SStRc3B6ZDk5Qndw?=
 =?utf-8?B?Zk1oNWtnekRzc0I2SThCRGFJMVphdC90N01HYWgyNFhaK3ErYmRsUlFxM29p?=
 =?utf-8?B?SGdIY3c4RFo1VldGMTNsY1JURklkNUI3Q05LMmJxT3pNUzArcHRrQUNOZjBu?=
 =?utf-8?B?ZVV5ZnhHZ1VLT1ROLytOTnJTMS9YYXkvYkM0SFhWY3l4RWhoUDhqZER4Ujd5?=
 =?utf-8?B?NS9ieXpFajZqWlZ1cUhlWXdNN1pGYlZ4OGFNcitYL3d1eThXN3ZpWE1WZ3RO?=
 =?utf-8?B?QWNKRTJsY0pDTWRMbzRva2d2T1RPaTYzdmtqTWpUSU1zNWkrREtYb0pGSkU1?=
 =?utf-8?Q?2DmZGjWLlE0N3ykjQl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR18MB6374.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15f29bf-c308-429c-203b-08de6ac2658a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 05:40:29.2419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xxIYawjMXGyvwveuvj4daD1pqg9xwtrg1EiqrxxwD1oSV/aRRNO4v9AdbOt7bI2gi/hCyYJ+HmD3XY9YAYJMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4044
X-Authority-Analysis: v=2.4 cv=ZNzaWH7b c=1 sm=1 tr=0 ts=698eb950 cx=c_pps
 a=8IEGYdEUWSgKkCiJ0Q1qZw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=V7XrBm94W3iARfm7cnUA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: uHlWTAd_9XXwkQttvfzn8exnWss4Mm8U
X-Proofpoint-ORIG-GUID: uHlWTAd_9XXwkQttvfzn8exnWss4Mm8U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA0MSBTYWx0ZWRfX3SOpN6s8BrTd
 hWnY3DvxCDZ9obaLmCIcZvHXnsnU/NkfPKrZNRIMWy6/ZpZfs0kWhirykQYbxXlVcFF5ArbMuVJ
 qvu8orr5hltmrZhin30cICFrFKxrKcmDvh9A2rssQN0+2qnYbaujw25cATrMk5oLsQysm6Ow/A6
 2wy5JUkwORJgkmQsutBrcmOvcElmRnpIcomfe9DezEtjHVcK2SnftgdU05T3WPyT1oJ86xV6mze
 9P3YcUicT3v3bCGp11GchotjXnCXj1CrX00yOiGwLTOJTkreYcdFQp1wXD7iWRvFDjjgmrUJas4
 P3Ii7v8usbPKeJznPU1HbbDsQfClSYUlvj9/wG5U2CXzjhXmZ8Z64/5RR+bcZ4ciOAgXqhmZ7L0
 iANMsV4B0fTAv+uWRQFYVAbsHxbGBvDYrddjnTQirD9nFmkfG6ORG2VO24DuJDnTheicjywIkfx
 ZWnq16Ls5puv+SKsM8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216021-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:email,marvell.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EB9651330AF
X-Rspamd-Action: no action

PiBPbiBUaHUsIEZlYiAxMiwgMjAyNiBhdCAwNjozMzo0MFBNICswNTMwLCBTcnVqYW5hIENoYWxs
YSB3cm90ZToNCj4gPiBSZXBsYWNlIGhhcmRjb2RlZCBSU1MgbWF4IGtleSBzaXplIGxpbWl0IHdp
dGggYSB0eXBlIGJhc2VkIGRlZmluaXRpb24uDQo+ID4gQWRkIHZhbGlkYXRpb24gZm9yIFJTUyBr
ZXkgc2l6ZSBhZ2FpbnN0IHNwZWMgbWluaW11bSAoNDAgYnl0ZXMpLiBXaGVuDQo+ID4gdmFsaWRh
dGlvbiBmYWlscywgZ3JhY2VmdWxseSBkaXNhYmxlIFJTUyBmZWF0dXJlcyBhbmQgY29udGludWUN
Cj4gPiBpbml0aWFsaXphdGlvbiByYXRoZXIgdGhhbiBmYWlsaW5nIGNvbXBsZXRlbHkuDQo+ID4N
Cj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IEZpeGVzOiAzZjdkOWMxOTY0ZmMg
KCJ2aXJ0aW9fbmV0OiBBZGQgaGFzaF9rZXlfbGVuZ3RoIGNoZWNrIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTcnVqYW5hIENoYWxsYSA8c2NoYWxsYUBtYXJ2ZWxsLmNvbT4NCj4gPg0KPiA+IHYzOg0K
PiA+IC0gTW92ZWQgUlNTIGtleSB2YWxpZGF0aW9uIGNoZWNrcyB0byB2aXJ0bmV0X3ZhbGlkYXRl
Lg0KPiA+IC0gQWRkIGZpeGVzOiB0YWcgYW5kIENDIC1zdGFibGUNCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIGluZGV4DQo+ID4gZGI4OGRjYWVmYjIwLi5lNjFjZWE1MGRjYWIgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jDQo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jDQo+ID4gQEAgLTM4MSw3ICszODEsOSBAQCBzdHJ1Y3QgcmVjZWl2
ZV9xdWV1ZSB7DQo+ID4gIAlzdHJ1Y3QgeGRwX2J1ZmYgKip4c2tfYnVmZnM7DQo+ID4gIH07DQo+
ID4NCj4gPiAtI2RlZmluZSBWSVJUSU9fTkVUX1JTU19NQVhfS0VZX1NJWkUgICAgIDQwDQo+ID4g
KyNkZWZpbmUgVklSVElPX05FVF9SU1NfTUFYX0tFWV9TSVpFIFwNCj4gPiArCSh0eXBlX21heCgo
KHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyAqKTApLT5yc3NfbWF4X2tleV9zaXplKSArIDEpDQo+
IA0KPiArMSBoZXJlIHJlYWxseSB1bmludHVpdGl2ZS4NCj4gSXQgZG9lcyBub3QgbG9vayBsaWtl
IGl0J3Mgc3RpbGwgdXNlZCwgdGhvdWdoPw0KSXQgaXMgc3RpbGwgdXNlZCBmb3IgdGhlIHJzc19o
YXNoX2tleV9kYXRhW1ZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRV0gaW4gc3RydWN0IHZpcnRu
ZXRfaW5mby4NClNob3VsZCBJIGNoYW5nZSBpdCB0byB1c2UgTkVUREVWX1JTU19LRVlfTEVOPw0K
PiANCj4gDQo+ID4gKyNkZWZpbmUgVklSVElPX05FVF9SU1NfTUlOX0tFWV9TSVpFIDQwDQo+ID4N
Cj4gPiAgLyogQ29udHJvbCBWUSBidWZmZXJzOiBwcm90ZWN0ZWQgYnkgdGhlIHJ0bmwgbG9jayAq
LyAgc3RydWN0DQo+ID4gY29udHJvbF9idWYgeyBAQCAtNjYyNyw2ICs2NjI5LDI0IEBAIHN0YXRp
YyBpbnQNCj4gPiB2aXJ0bmV0X3ZhbGlkYXRlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQ0K
PiA+ICAJCV9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfU1RBTkRCWSk7DQo+
ID4gIAl9DQo+ID4NCj4gPiArCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05F
VF9GX1JTUykgfHwNCj4gPiArCSAgICB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05F
VF9GX0hBU0hfUkVQT1JUKSkgew0KPiA+ICsJCXU4IGtleV9zeiA9IHZpcnRpb19jcmVhZDgodmRl
diwNCj4gPiArCQkJCQkgIG9mZnNldG9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZywNCj4gPiAr
CQkJCQkJICAgcnNzX21heF9rZXlfc2l6ZSkpOw0KPiA+ICsJCS8qIFNwZWMgcmVxdWlyZXMgYXQg
bGVhc3QgNDAgYnl0ZXMgKi8NCj4gDQo+IG1vdmUgdGhlIGRlZmluZSBoZXJlIHRoZW4/DQpXaWxs
IG1vdmUuDQo+IA0KPiA+ICsJCWlmIChrZXlfc3ogPCBWSVJUSU9fTkVUX1JTU19NSU5fS0VZX1NJ
WkUpIHsNCj4gPiArCQkJZGV2X3dhcm4oJnZkZXYtPmRldiwNCj4gPiArCQkJCSAicnNzX21heF9r
ZXlfc2l6ZT0ldSBpcyBsZXNzIHRoYW4gc3BlYw0KPiBtaW5pbXVtICV1LCBkaXNhYmxpbmcgUlNT
XG4iLA0KPiA+ICsJCQkJIGtleV9zeiwgVklSVElPX05FVF9SU1NfTUlOX0tFWV9TSVpFKTsNCj4g
PiArCQkJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfUlNTKSkNCj4g
PiArCQkJCV9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfUlNTKTsNCj4gPiAr
CQkJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LA0KPiBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBP
UlQpKQ0KPiA+ICsJCQkJX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsDQo+ID4gKw0KPiBWSVJUSU9f
TkVUX0ZfSEFTSF9SRVBPUlQpOw0KPiANCj4gDQo+IHdoeSBub3QgY2xlYXIgdGhlbSB1bmNvbmRp
dGlvbmFsbHk/DQo+IA0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gIAlyZXR1cm4gMDsN
Cj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTY4MzksMTMgKzY4NTksNiBAQCBzdGF0aWMgaW50IHZpcnRu
ZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UNCj4gKnZkZXYpDQo+ID4gIAlpZiAodmktPmhh
c19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpIHsNCj4gPiAgCQl2aS0+cnNzX2tleV9z
aXplID0NCj4gPiAgCQkJdmlydGlvX2NyZWFkOCh2ZGV2LCBvZmZzZXRvZihzdHJ1Y3QgdmlydGlv
X25ldF9jb25maWcsDQo+IHJzc19tYXhfa2V5X3NpemUpKTsNCj4gPiAtCQlpZiAodmktPnJzc19r
ZXlfc2l6ZSA+IFZJUlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSkgew0KPiA+IC0JCQlkZXZfZXJy
KCZ2ZGV2LT5kZXYsICJyc3NfbWF4X2tleV9zaXplPSV1IGV4Y2VlZHMNCj4gdGhlIGxpbWl0ICV1
LlxuIiwNCj4gPiAtCQkJCXZpLT5yc3Nfa2V5X3NpemUsDQo+IFZJUlRJT19ORVRfUlNTX01BWF9L
RVlfU0laRSk7DQo+ID4gLQkJCWVyciA9IC1FSU5WQUw7DQo+ID4gLQkJCWdvdG8gZnJlZTsNCj4g
PiAtCQl9DQo+ID4gLQ0KPiA+ICAJCXZpLT5yc3NfaGFzaF90eXBlc19zdXBwb3J0ZWQgPQ0KPiA+
ICAJCSAgICB2aXJ0aW9fY3JlYWQzMih2ZGV2LCBvZmZzZXRvZihzdHJ1Y3QgdmlydGlvX25ldF9j
b25maWcsDQo+IHN1cHBvcnRlZF9oYXNoX3R5cGVzKSk7DQo+ID4gIAkJdmktPnJzc19oYXNoX3R5
cGVzX3N1cHBvcnRlZCAmPQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQoNCg==

