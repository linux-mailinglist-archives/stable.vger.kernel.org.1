Return-Path: <stable+bounces-169913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C7BB29748
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 05:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6A41962E7B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 03:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4F7286A9;
	Mon, 18 Aug 2025 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fMop5rom";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IRw92gr9"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE5244664
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755487358; cv=fail; b=QvogWpN68+JmePJypQPw2AD4ofsHl5ifyEtkq8YeA++Q4Sun7GsSmB2RZnN5KsialET7itXWFEX+QCTYsG9W3J8KMwc474JqX9hpx09UFL0aM90QM2Ubd6n9SbBAbbERFCzstwVnxI4AljMcL+ZwzjwO29cy8kRqDtD80dV7e0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755487358; c=relaxed/simple;
	bh=cP6WwnEK7CheWEyZr7G33D/jR1YxknlYJNmncFsroLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cBUZm04fcLfPoDqb18w6ci0ONnugWXhJ4H+X4QMqAa3Knd7+g4k2ZupwCTrVpEIzo9dXTmb15z6RO0YG5qSgJmeqYOv383Ms+oBT/AcqVjXyfB9mJTibG2VrqYYRzVL1YDCn+SiVTeHw92/RhJX6+NmHsBY7Ekd8fM2mA3NpUKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fMop5rom; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IRw92gr9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 930a759c7be211f0b33aeb1e7f16c2b6-20250818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cP6WwnEK7CheWEyZr7G33D/jR1YxknlYJNmncFsroLA=;
	b=fMop5romRDGA/2D0KJISJR6ube8yMQvA1vOwlip9WfUglz6X7U/V+WUH4MYfDpQatbQ8rQiZ/Mkx4JjezXhurISmTqeKXY6Ev7UBrPSEmKnvGm0rr88GwhUkC6i6Zt4ROJZjJddtaX7pJier9yiZpvlOnea3TLGal9X3KGBtKGg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:3a4d1393-20e0-445f-812d-3023af18442e,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:0ec107f4-66cd-4ff9-9728-6a6f64661009,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 930a759c7be211f0b33aeb1e7f16c2b6-20250818
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1987221861; Mon, 18 Aug 2025 11:22:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 18 Aug 2025 11:22:30 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 18 Aug 2025 11:22:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bo5GO+jFW2Om2MkgfTFdh+wg1QMSmHS5I4TIzuoBuLTWdOTM/JKutv92XDQKg/AByaBzqh7fHVFuoUkr/RDn2PwZGhk5DsJeDrupzVbZT/PcC9hGJptlUpP7eJVxsrK/QPyxHLcfiKI20Nin4DHyrTE6Av/90NV0MKnXnZU3V0pFrHzcBJ3pKzai2gEvVSkA2Ta5X5cWh6pKDB1OAlAajV/73MkDA8dAG/T+J+DtCyybZdSb9c21k6AT/2ES/XmApD4SeNeaPgyVgMp0Ogid4gptYN3DjF6UMzhfrZTYJgmSf1Kr9NRZfGRWksftDE+dMQvBxOhiGXdvH2IQCv9aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP6WwnEK7CheWEyZr7G33D/jR1YxknlYJNmncFsroLA=;
 b=X1s6xq4i5w+C4kOSPqW1EAy4MI6U0EigFCFNvAbkbVu2ATeN60QMJBJvDGR2qgMua4OdwTd7rh5rvrhTOykiAxFwihmFiv4B8EBWwm545IQLHoAmyQk4QikmJlq54pvVmSNhY+ZZaNrclQw+p4L+IeBwJb/i7daeRx51fEPQnRtPEMqQx6Cug+XlWawKxAUpa8L99+Tx1G18Qg98Hh2IGd53MjwZPOCMkjjCqJejGPs2XL2k4DQDfJF590+MvKgxcLtIo+MfvLqevDUbqcfE3zLLxIAayVSiygZmgwY9t1OhuUbThCMGnjh/qodA6pQjQoSULy9F+ItfAcn6P4MkCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP6WwnEK7CheWEyZr7G33D/jR1YxknlYJNmncFsroLA=;
 b=IRw92gr94HKUrZ5/ozNW1DaZn9FkUk29fNGTvN9u29PUejY66tR5VBvtAqn9D5Vas0MTBw9J0XuOOtzpXrezIUcioZ2f5ib2ob7gL8gXfxskYT8v1k2zKug8tP5nxpk6wg5iwlqaMOZ9wA9tRM7J757GVyX9pv2uuTcmy8TMvM0=
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com (2603:1096:4:ef::8) by
 SG2PR03MB6431.apcprd03.prod.outlook.com (2603:1096:4:1c2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Mon, 18 Aug 2025 03:22:27 +0000
Received: from SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741]) by SI2PR03MB5322.apcprd03.prod.outlook.com
 ([fe80::4f8e:6e62:b8a5:5741%6]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 03:22:27 +0000
From: =?utf-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?=
	<Mingyen.Hsieh@mediatek.com>
To: "inbartdev@gmail.com" <inbartdev@gmail.com>
CC: Sean Wang <Sean.Wang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, =?utf-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?=
	<Allan.Wang@mediatek.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?=
	<Deren.Wu@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>
Subject: Re: [REGRESSION] [BISECTED] MT7925 wireless speed drops to zero since
 kernel 6.14.3 - wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Thread-Topic: [REGRESSION] [BISECTED] MT7925 wireless speed drops to zero
 since kernel 6.14.3 - wifi: mt76: mt7925: integrate *mlo_sta_cmd and *sta_cmd
Thread-Index: AQHcCGZ+N2cRSRBuyEaLM6TVn70PzbRY0w6AgAPf04CAAHtLAIAE5cMAgAW55wA=
Date: Mon, 18 Aug 2025 03:22:27 +0000
Message-ID: <a28a7735e9ac1bdebb7b2e875c7c8433c40f7e38.camel@mediatek.com>
References: <CAJmAMMyOk7AVqQRrtK4Oum2uVKreGeLJ943-kkRCTspoGApZ8w@mail.gmail.com>
	 <CAJmAMMyt5QQQOavVy+Gytf00Y0F6G+GCLYhj0E9RZ8cV85gwCw@mail.gmail.com>
	 <10850475be9302b5b397173c1d4554335c0df966.camel@mediatek.com>
	 <CAJmAMMxtH+WnJfU2tcHRxP472cnyM4cZ7vaTcZN0NSxQ6U5HCg@mail.gmail.com>
	 <CAJmAMMzYkoVWq2w4UCdyF1x2huwtcbW37RyKiDiCR9pmACdDuQ@mail.gmail.com>
In-Reply-To: <CAJmAMMzYkoVWq2w4UCdyF1x2huwtcbW37RyKiDiCR9pmACdDuQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5322:EE_|SG2PR03MB6431:EE_
x-ms-office365-filtering-correlation-id: b638ff67-6082-4fe3-6560-08ddde067575
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGh5MWE2Qmhqdm40TElZdGsrQ0NPNitjTlovcVRxMGNGaGVrUFZjbUxXRExZ?=
 =?utf-8?B?WS9WUjR4aklZQ0p1RUc1dGdQRUt5elh5a3JGSExMRGY5VmgrT2VJL21kbkVj?=
 =?utf-8?B?ejQ0MjJMaHFwT2Z5ZGZHcWROKzQ3bDc0SmpBMEtGbkdoOWZpOWtrMVkvMFJY?=
 =?utf-8?B?MExhMG1KWkNQQWtEczJQWm85SjRvOUpBUHJLb09VV0xvNElGQlBnd1g0M0R0?=
 =?utf-8?B?bk0vRytPb0RFWEtoQTVqanZNdFFjelNPK3J4NGp0NmhxLzFWdlVxZ2draFJR?=
 =?utf-8?B?M2JPbnJQTTYwVGg5aW5aUkJ3T1VsSlN3bGxkTSthVHJCdXhUTmZvTTNyZWZE?=
 =?utf-8?B?SW4vUFVNS2pkZXViV3VrMkloblNLYzA0QjMvL2h6bmJLQllSYkRoUnVnQXM0?=
 =?utf-8?B?MWF0U0FMLytvWE1yYldOdEpobVJXSmk4ZS9NYWdFYUc2Zi9rYTcraWhCYmhh?=
 =?utf-8?B?ZEZJZVlyVDZ5QkZaK1IrT1VyUTcrY0F5UTRuSTUwNitwaU5LbkRGWW5SOGpV?=
 =?utf-8?B?RFpDOG9tSlJIT3JKd21GSlFSakN0M1J3OUVFMTl1K3hVL2FZamVVTWJyM3hL?=
 =?utf-8?B?UWZvMzVTbDB2aTVRL3BLM2xqTENTS2E2VjZKWkI5RnNhcXdpemVLNHNuQ0Qz?=
 =?utf-8?B?QnNsakp6ZklmZnVBVE5PSkNQQVY2MVZwSVNOaXVXdVF6MC9lcGVGbDc5Yyt6?=
 =?utf-8?B?QVprcHRyUWZSUlE4V1VjbmFFZTJGVU16Yy9JNEl4VkJDTldqa3BlWjRtVGdP?=
 =?utf-8?B?SDRycE5BTjRUQ1FBenJnOEpMOE5aL29qOWRvNXk1eUFxWmtWTENMbGZBSDZh?=
 =?utf-8?B?VDhYZGNNYVBxT1dZY3N1bEVYOGhsL213a3RidjhRNEcwRmRKeVJmaklmQ042?=
 =?utf-8?B?cDFiYTFQUWh6cXFsbDh2MllVUHQybkVtUXJ3Ylh3amZoQlRhNE1LbUMwYnJr?=
 =?utf-8?B?S1lrZnJ3RTRXK3pEempwMTY4bWhFSjRJbU5pMHpmeUpmS2U2bC9uVldReE90?=
 =?utf-8?B?R1UrQ1pnN3VoNkg4d0pSWmFaQkIzeGtYNmFkOXNiRmpqamJFd2tHZS9kcFJI?=
 =?utf-8?B?ejU4SEZWY1hWbmw3QThueGJxbE12ZVBPRGVRalN3REdpWXhWWHJNVTlDOGVv?=
 =?utf-8?B?bkpvY0xZR0g2clN2VjB6ODRLNG9PUlErcmF2UTF5TGlLbDZEMWRJWDJEVUF6?=
 =?utf-8?B?OEpKZFhXR3g0YnFCMjgyWW1ycXBPMmM4aG5DRFRNL1dLM2EwY3pSRXZFTTZU?=
 =?utf-8?B?VkZXUFd6cW9TZG1yVWhaR3FUcjkvZ3BqU01yL3VINm4xNmFhZVh6dnlGVTNK?=
 =?utf-8?B?Q2Y0eFIzV2NFUkl5U2x4WnlwRzJMQ284a0pCYlBvQlVqWDZXNWV3cVFuOEJN?=
 =?utf-8?B?RnFmNytmbXZ0SnZ5V01CMlZiQUR2cmZVVmxUTXphbkVvaGUrZ1FVOE4yUkha?=
 =?utf-8?B?di82amZHNlM2eTdsZUxmQlpXZnVHRGtIZzhVNS84MHFURmp5bE9MK0xoNGZF?=
 =?utf-8?B?a2V0K1hzTm0rNE9UVHQ1S2hDekUyTkt1S2E0WDdMdU0rU2kvVy9IbHdkMis4?=
 =?utf-8?B?cVVoa2N3ZlB0eTVIUnlWK211WmlXSHlnd2NDNFJ1eHJBaEhQdGVEcDZDOExp?=
 =?utf-8?B?bC8zQXNvYVpaRHZTdUV6N0h3aXVQM1JYMFhpZG4rWDZsK0Q3d3RlK3A1UkpV?=
 =?utf-8?B?MDB2M1dQYnFVVlhJVTBGWjFITEZOaWpWcE1hVVpSeFZGOTM5UHpKYVVNMmlD?=
 =?utf-8?B?MHJYVVRXaFZzQXFrUllNcmw3OHQ4a2NRSnRoTjRITk4weWlobHFLYlZEYUdC?=
 =?utf-8?B?SWs1dmJ0dC92TU1GUDQzckl1MjQ4cG9mSmVoWHhCaWo0R0dsZDdxeC9oZnBD?=
 =?utf-8?B?TEF3UmF5NWw1R2JkRVhHaUhBbXpiUUFWeVlZZ1kxaEtmZStqVElYYjlqOWZV?=
 =?utf-8?Q?OjXInSO9JXmWcfIhhMfsbcs4XWxmsw84?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5322.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHNTZngwVWNTMWJLWjYvbXBBaWZURmpjcnhEaUhVQU0zU3NuU2krSlRjbEoy?=
 =?utf-8?B?ZVE4M2tqa2hKUmFIdksxLzBaWGNrREF4elIwSTVHZEV6SXJIRTVaaHFDNUND?=
 =?utf-8?B?MU1nMFJoMlVlRXlKZ1FNYXN2MTV3R3VRMzEvVFR1ZHBaVzlRZ09HblgyYUFK?=
 =?utf-8?B?WGJqUmczd0NsRklhN3l2a2tRR1d3eGVKVDljUEw4Z2dOa0RYNHhnSFVodmgx?=
 =?utf-8?B?REFqTVZuTEdXUXc4TU1vZEJxaWlPZFZoT2J3NUZ0NFRTeEd2TFRpaEVjR1Rp?=
 =?utf-8?B?M1VhWXlZRHFHOEcxbVRhR2Ztd2Njcm16TWppK2VNbTIyaVBGSjBNd05mZEJE?=
 =?utf-8?B?eVRnSitVSGFMazJ1ZmJTQW13cXlJV2lDMDlDVlJKTkdrQ3JjMjVpTk9wbklT?=
 =?utf-8?B?eTBsbXFIbE5nUTUxTlBCaUp5ajBadm1CckRlUUFzcVoyb2c1eHQrcUZTeEpS?=
 =?utf-8?B?OVZ2STVYQVlVZmtvd2VXVVRTalJjeEloNlBsL0J6WXc2OHJpSzJVQng5WFRI?=
 =?utf-8?B?bWVsb3c1ZTNka29TU1k4NFVnTUUvbjJNZTlVMUNDSFk3Z2dNMUZhdkFSeTZk?=
 =?utf-8?B?VjNNbzdXTVBrN3E5T0RyeFdrSUpDUkk5Ny9sSUUrSjVxb29FVXdhWlFWT3ky?=
 =?utf-8?B?R0hkMzJiWm9wbzU5d2N5ZkJvZFd0M1VpZVl2QTBqaEN6ZHU3WWJjQjMzejhW?=
 =?utf-8?B?NXJxbkhKSWxwK2lKYnNJUXVsdlpDcmczb1hKa0ZrMkhFYjZWakZKbGdRUEZK?=
 =?utf-8?B?M2pneGhpUEhDYXVmdWV6WUYzTGM4bmFWYWNUYjJnTERkVmNXcW1WSkxKbFhy?=
 =?utf-8?B?QlVIVVFkSDlhc1BZbWtDRDlYZE4xQ3dMTklybmJUVnBmbXFKV1RhazZKVkhV?=
 =?utf-8?B?K01Fd01EaHpLb2UyVnJBeEFyYUhGNlBMaDJzclpKenRDdzlPZEU3dVpVOHZk?=
 =?utf-8?B?bnp6TG5FZ0FERmZsWkxKd3lwVDdLSUsvSGtjWWo2Szk2alhtLzVEbE40cWw5?=
 =?utf-8?B?TXBtV094bUh1RkNGMXNTVHc0SnFYQmViWFE2eVNhSndnaHdTV0sxc1FaZXFq?=
 =?utf-8?B?Zkk1aHhRVElOb1NoMGxvVW9KV2dZMW5XcDZmYkJ2OHNTRC96ZVFEY2J4c2V4?=
 =?utf-8?B?YTRjaTN2R2tLVlB6ekhxQi9qTm4yVjAzVnlWWWdyeitLS1FOdzI0MFpTUGY0?=
 =?utf-8?B?d0xFK1ZWVU9tZzZuMWMzbzFZZ1BwWUgyQlBZanZpTlRLQzQ1M1dCTkIyb2NY?=
 =?utf-8?B?My82QjN6Q0UwT3VDQWhPaVg1R0h1anNINkFPMHJ0SWNSWnFWMjlZRzlydk1z?=
 =?utf-8?B?QVpSaW1Zby9uVUlLWDJlcmVSVTBoZm45WUZLVkJwdkIvSVBHc0o0bVhLcGJn?=
 =?utf-8?B?VEkrUnROS3pxU2FPbVl3Vk5CZTFzRWpxdDNza085bElsdGtNa1VZVXBnbjFG?=
 =?utf-8?B?ZnBKL1JwaDNTek9wYXVkR25tM1ROSUlDdEh5VnBibWEwTzBSc2RVeTF3UGRm?=
 =?utf-8?B?ZGZ0SU03aUYxN3RKYXB6UFRTRDJLNHVvTXlZWDFOZXQ0ck9QRFlOWVdVdWx5?=
 =?utf-8?B?UVJwR2tzOGZRR0w2blJ5Yml0OFFONVdOMkJKaWZ0Q0x5dVhoc3NpR3JaN1p3?=
 =?utf-8?B?NDZZY3NvNHJRQ09mOVphbWxwVEp6OEtjbzJUc2ZocUhLTWttd283SDdrZllx?=
 =?utf-8?B?S2kyTnVqSDBKbTJjM1VVTGt4SjJ1bmp4U3ZKTHVxY3gyTWVTTDBSVW5Eb2JE?=
 =?utf-8?B?KzlIVmtDemRGYXdTQ3pyaFZJWmhUODFMZ2ZlVGtMYmFRaGkwdmMwS295ODdw?=
 =?utf-8?B?ZUIyVE5WTzJDM0VKMjdNR2JZMVFhWENhbXBTb0tScVMyQndHQkt4WFFURmFZ?=
 =?utf-8?B?S3BSbm14ejBhV0NmT0ZFRkQzNXlleHlHckJnRlFrL3BnelBSalZ0ZGlPc29l?=
 =?utf-8?B?WmxCQ015ZUYrZWNBdS9lbkdiM3c4R2UyUVNaaEFQTEtzYS9RTnFHZXFseWkr?=
 =?utf-8?B?V2kxZnlGbzVQamt6RHZDUm8yNkRJUnJOSjhOVjltL2FZV2ZZMlZ6Z3FKZWpz?=
 =?utf-8?B?eTFjT0V2T3AvZ3BXRDdYNGI5M2FydWxWRVhCeFc1SW0zU3RSTjdjWWRrTFQx?=
 =?utf-8?B?Si9IbXhlNk5uZ1VzQ1FyRjI4ZkZQMStkVlk1T1YzblQ5QVlKeVBSZE03MmRw?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B07B0A461E9E6349BE8CE297FEC8BADC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5322.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b638ff67-6082-4fe3-6560-08ddde067575
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 03:22:27.7720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWg71A2rqOCsM6KEGcrSmSWnXzY4zmGlGPkSHLoCxxXLghkFzh/cao/vbFSq7xh2eKzzykuPUIFcn8JBzKQ4/jUjMFoodbZT9FDfwzBBQC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6431

T24gVGh1LCAyMDI1LTA4LTE0IGF0IDE0OjU1ICswMzAwLCBUYWwgSW5iYXIgd3JvdGU6DQo+IA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IEhpIE1pbmd5ZW4sDQo+IA0KPiBJJ3ZlIGNvbGxlY3RlZCBzb21lIG9m
IG15IFJvdXRlcnMnIGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRpb24gd2hpY2gNCj4gSSdsbCBzaGFy
ZSB3aXRoIHlvdSBpbiBhIHByaXZhdGUgZW1haWwgbWVzc2FnZS4NCj4gDQo+IFRhbA0KPiANCj4g
T24gTW9uLCBBdWcgMTEsIDIwMjUgYXQgMTI6MDjigK9QTSBUYWwgSW5iYXIgPGluYmFydGRldkBn
bWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IEhpIE1pbmd5ZW4sDQo+ID4gDQo+ID4gSSds
bCBzZWUgd2hhdCBJIGNhbiBnYXRoZXIgYW5kIEknbGwgbGV0IHlvdSBrbm93Lg0KPiA+IA0KPiA+
IFRhbA0KPiA+IA0KPiA+IE9uIE1vbiwgQXVnIDExLCAyMDI1IGF0IDQ6NDfigK9BTSBNaW5neWVu
IEhzaWVoICjorJ3mmI7oq7opDQo+ID4gPE1pbmd5ZW4uSHNpZWhAbWVkaWF0ZWsuY29tPiB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gT24gRnJpLCAyMDI1LTA4LTA4IGF0IDE3OjM3ICswMzAwLCBUYWwg
SW5iYXIgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gPiB1bnRpbA0KPiA+
ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4g
PiANCj4gPiA+ID4gDQo+ID4gPiA+IHR5cG8sIGxhcHRvcCBtb2RlbCBpczoNCj4gPiA+ID4gTGVu
b3ZvIElkZWFQYWQgU2xpbSA1IDE2QUtQMTANCj4gPiA+ID4gDQo+ID4gPiA+IE9uIEZyaSwgQXVn
IDgsIDIwMjUgYXQgNDoxNOKAr1BNIFRhbCBJbmJhciA8aW5iYXJ0ZGV2QGdtYWlsLmNvbT4NCj4g
PiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSGksDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gU2luY2Uga2VybmVsIHY2LjE0LjMsIHdoZW4gdXNpbmcgd2lyZWxlc3MgdG8gY29ubmVj
dCB0byBteQ0KPiA+ID4gPiA+IGhvbWUNCj4gPiA+ID4gPiByb3V0ZXINCj4gPiA+ID4gPiBvbiBt
eSBsYXB0b3AsIG15IHdpcmVsZXNzIGNvbm5lY3Rpb24gc2xvd3MgZG93biB0byB1bnVzYWJsZQ0K
PiA+ID4gPiA+IHNwZWVkcy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBNb3Jl
IHNwZWNpZmljYWxseSwgc2luY2Uga2VybmVsIDYuMTQuMywgd2hlbiBjb25uZWN0aW5nIHRvDQo+
ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gd2lyZWxlc3MgbmV0d29ya3Mgb2YgbXkgT3BlbldSVCBS
b3V0ZXIgb24gbXkgTGVub3ZvIElkZWFQYWQNCj4gPiA+ID4gPiBTbGltIDE1DQo+ID4gPiA+ID4g
MTZBS1AxMCBsYXB0b3AsDQo+ID4gPiA+ID4gZWl0aGVyIGEgMi40Z2h6IG9yIGEgNWdoeiBuZXR3
b3JrLCB0aGUgY29ubmVjdGlvbiBzcGVlZCBkcm9wcw0KPiA+ID4gPiA+IGRvd24NCj4gPiA+ID4g
PiB0bw0KPiA+ID4gPiA+IDAuMS0wLjIgTWJwcyBkb3dubG9hZCBhbmQgMCBNYnBzIHVwbG9hZCB3
aGVuIG1lYXN1cmVkIHVzaW5nDQo+ID4gPiA+ID4gc3BlZWR0ZXN0LWNsaS4NCj4gPiA+ID4gPiBN
eSBsYXB0b3AgdXNlcyBhbiBtdDc5MjUgY2hpcCBhY2NvcmRpbmcgdG8gdGhlIGxvYWRlZCBkcml2
ZXINCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiBmaXJtd2FyZS4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBEZXRhaWxlZCBEZXNjcmlwdGlvbjoNCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBBcyBtZW50aW9uZWQgYWJvdmUsIG15IHdpcmVsZXNzIGNvbm5lY3Rpb24gYmVjb21lcyB1
bnVzYWJsZQ0KPiA+ID4gPiA+IHdoZW4NCj4gPiA+ID4gPiB1c2luZw0KPiA+ID4gPiA+IGxpbnV4
IDYuMTQuMyBhbmQgYWJvdmUsIGRyb3BwaW5nIHNwZWVkcyB0byBhbG1vc3QgMCBNYnBzLA0KPiA+
ID4gPiA+IGV2ZW4gd2hlbiBzdGFuZGluZyBuZXh0IHRvIG15IHJvdXRlci4gRnVydGhlciwgcGlu
Z2luZw0KPiA+ID4gPiA+IGFyY2hsaW51eC5vcmcNCj4gPiA+ID4gPiByZXN1bHRzIGluICJUZW1w
b3JhcnkgZmFpbHVyZSBpbiBuYW1lIHJlc29sdXRpb24iLg0KPiA+ID4gPiA+IEFueSBvdGhlciB3
aXJlbGVzcyBkZXZpY2UgaW4gbXkgaG91c2UgY2FuIHN1Y2Nlc3NmdWxseQ0KPiA+ID4gPiA+IGNv
bm5lY3QgdG8NCj4gPiA+ID4gPiBteQ0KPiA+ID4gPiA+IHJvdXRlciBhbmQgcHJvcGVybHkgdXNl
IHRoZSBpbnRlcm5ldCB3aXRoIGdvb2Qgc3BlZWRzLCBlZy4NCj4gPiA+ID4gPiBpcGhvbmVzLA0K
PiA+ID4gPiA+IGlwYWRzLCByYXNwYmVycnkgcGkgYW5kIGEgd2luZG93cyBsYXB0b3AuDQo+ID4g
PiA+ID4gV2hlbiB1c2luZyBteSBMZW5vdm8gbGFwdG9wIG9uIGEga2VybmVsIDYuMTQuMyBvciBo
aWdoZXIgdG8NCj4gPiA+ID4gPiBjb25uZWN0DQo+ID4gPiA+ID4gdG8NCj4gPiA+ID4gPiBvdGhl
ciBhY2Nlc3MgcG9pbnRzLCBzdWNoIGFzIG15IGlQaG9uZSdzIGhvdHNwb3QgYW5kIHNvbWUNCj4g
PiA+ID4gPiBUUExpbmsNCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiBaeXhlbCByb3V0ZXJzIC0g
dGhlIGNvbm5lY3Rpb24gc3BlZWQgaXMgZ29vZCwgYW5kIHRoZXJlIGFyZQ0KPiA+ID4gPiA+IG5v
DQo+ID4gPiA+ID4gaXNzdWVzLA0KPiA+ID4gPiA+IHdoaWNoIG1ha2VzIG1lIGJlbGlldmUgdGhl
cmUncyBzb21ldGhpbmcgZ29pbmcgb24gd2l0aCBteQ0KPiA+ID4gPiA+IE9wZW5XUlQNCj4gPiA+
ID4gPiBjb25maWd1cmF0aW9uIGluIGNvbmp1bmN0aW9uIHdpdGggYSBjb21taXQgaW50cm9kdWNl
ZCBvbg0KPiA+ID4gPiA+IGtlcm5lbA0KPiA+ID4gPiA+IDYuMTQuMw0KPiA+ID4gPiA+IGZvciB0
aGUgbXQ3OTI1ZSBtb2R1bGUgYXMgZGV0YWlsZWQgYmVsb3cuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gSSBoYXZlIGZvbGxvd2VkIGEgcmVsYXRlZCBpc3N1ZSBwcmV2aW91c2x5IHJlcG9ydGVkIG9u
IHRoZQ0KPiA+ID4gPiA+IG1haWxpbmcNCj4gPiA+ID4gPiBsaXN0IHJlZ2FyZGluZyBhIHByb2Js
ZW0gd2l0aCB0aGUgc2FtZSB3aWZpIGNoaXAgb24ga2VybmVsDQo+ID4gPiA+ID4gNi4xNC4zLA0K
PiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+IHRoZSBtZXJnZWQgZml4IGRvZXNuJ3Qgc2VlbSB0byBm
aXggbXkgcHJvYmxlbToNCj4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1t
ZWRpYXRlay9FbVduTzViLWFjUkgxVFhiR25reDQxZUp3NjU0dm1DUi04X3hNQmFQTXdleENuZmt2
S0NkbFU1dTE5Q0diYWFwSjNLUnUtbDNCLXRTVWhmOENDUXdMMG9kam82Q2Q1WUc1bHZOZUItdmZk
Zz1AcG0ubWUvDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSd2ZSB0ZXN0ZWQgc3RhYmxlIGJ1aWxk
cyBvZiA2LjE1IGFzIHdlbGwgdXAgdG8gNi4xNS45IGluIHRoZQ0KPiA+ID4gPiA+IGxhc3QNCj4g
PiA+ID4gPiBtb250aCwgd2hpY2ggYWxzbyBkbyBub3QgZml4IHRoZSBwcm9ibGVtLg0KPiA+ID4g
PiA+IEkndmUgYWxzbyBidWlsdCBhbmQgYmlzZWN0ZWQgdjYuMTQgb24ganVuZSB1c2luZyBndWlk
ZXMgb24NCj4gPiA+ID4gPiB0aGUgQXJjaA0KPiA+ID4gPiA+IExpbnV4IHdpa2ksIGZvciB0aGUg
Zm9sbG93aW5nIGJhZCBjb21taXQsIHNhbWUgYXMgdGhlDQo+ID4gPiA+ID4gcHJldmlvdXNseQ0K
PiA+ID4gPiA+IG1lbnRpb25lZCByZXBvcnRlZCBpc3N1ZToNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBbODAwMDdkM2Y5MmZkMDE4ZDBhMDUyYTcwNjQwMGU5NzZiMzZlM2M4N10gd2lmaTogbXQ3NjoN
Cj4gPiA+ID4gPiBtdDc5MjU6DQo+ID4gPiA+ID4gaW50ZWdyYXRlICptbG9fc3RhX2NtZCBhbmQg
KnN0YV9jbWQNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUZXN0aW5nIGZ1cnRoZXIgdGhpcyB3ZWVr
LCBJIGNsb25lZCBtYWlubGluZSBhZnRlciA2LjE2IHdhcw0KPiA+ID4gPiA+IHJlbGVhc2VkLA0K
PiA+ID4gPiA+IGJ1aWx0IGFuZCB0ZXN0ZWQgaXQsIGFuZCB0aGUgaXNzdWUgc3RpbGwgcGVyc2lz
dHMuDQo+ID4gPiA+ID4gSSByZXZlcnRlZCB0aGUgZm9sbG93aW5nIGNvbW1pdHMgb24gbWFpbmxp
bmUgYW5kIHJldGVzdGVkLCB0bw0KPiA+ID4gPiA+IHN1Y2Nlc3NmdWxseSBzZWUgZ29vZCB3aXJl
bGVzcyBzcGVlZHM6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gWzBhYTg0OTZhZGRhNTcwYzIwMDU0
MTBhMzBkZjk2M2ExNjY0M2EzZGNdIHdpZmk6IG10NzY6DQo+ID4gPiA+ID4gbXQ3OTI1OiBmaXgN
Cj4gPiA+ID4gPiBtaXNzaW5nIGhkcl90cmFuc190bHYgY29tbWFuZCBmb3IgYnJvYWRjYXN0IHd0
YmwNCj4gPiA+ID4gPiBbY2IxMzUzZWYzNDczNWVjMWU1ZDllZmExZmU5NjZmMDVmZjFkYzFlMV0g
d2lmaTogbXQ3NjoNCj4gPiA+ID4gPiBtdDc5MjU6DQo+ID4gPiA+ID4gaW50ZWdyYXRlICptbG9f
c3RhX2NtZCBhbmQgKnN0YV9jbWQNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGVuLCByZXZlcnRp
bmcgKm9ubHkqDQo+ID4gPiA+ID4gMGFhODQ5NmFkZGE1NzBjMjAwNTQxMGEzMGRmOTYzYTE2NjQz
YTNkYw0KPiA+ID4gPiA+IGNhdXNlcw0KPiA+ID4gPiA+IHRoZSBpc3N1ZSB0byByZXByb2R1Y2Us
IHdoaWNoIGNvbmZpcm1zIHRoZSBpc3N1ZSBpcyBjYXVzZWQgYnkNCj4gPiA+ID4gPiBjb21taXQN
Cj4gPiA+ID4gPiBjYjEzNTNlZjM0NzM1ZWMxZTVkOWVmYTFmZTk2NmYwNWZmMWRjMWUxIG9uIG1h
aW5saW5lLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkndmUgYXR0YWNoZWQgdGhlIGZvbGxvd2lu
ZyBmaWxlcyB0byBhIGJ1Z3ppbGxhIHRpY2tldDoNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAtIGxz
cGNpIC1ubmsgb3V0cHV0Og0KPiA+ID4gPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvYXR0YWNobWVudC5jZ2k/aWQ9MzA4NDY2X187ISFD
VFJOS0E5d01nMEFSYnchZ1RBYUplSU42czNlRl9LcDZVM2l3ZnYwd0NDT19CVmNSa05WcEpZbndS
OHFlcUlJaDEzNG1FSjVkeGRlTnF6dVdTUEYyb2NMQXQ0M0x4YUJUSVktN3ckDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gLSBkbWVzZyBvdXRwdXQ6DQo+ID4gPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9hdHRhY2htZW50LmNnaT9pZD0z
MDg0NjVfXzshIUNUUk5LQTl3TWcwQVJidyFnVEFhSmVJTjZzM2VGX0twNlUzaXdmdjB3Q0NPX0JW
Y1JrTlZwSllud1I4cWVxSUloMTM0bUVKNWR4ZGVOcXp1V1NQRjJvY0xBdDQzTHhZMXBralpDQSQN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiAtIC5jb25maWcgZm9yIHRoZSBidWlsdCBtYWlubGluZSBr
ZXJuZWw6DQo+ID4gPiA+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vYnVn
emlsbGEua2VybmVsLm9yZy9hdHRhY2htZW50LmNnaT9pZD0zMDg0NjdfXzshIUNUUk5LQTl3TWcw
QVJidyFnVEFhSmVJTjZzM2VGX0twNlUzaXdmdjB3Q0NPX0JWY1JrTlZwSllud1I4cWVxSUloMTM0
bUVKNWR4ZGVOcXp1V1NQRjJvY0xBdDQzTHhZY3UtRGIyZyQNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBNb3JlIGluZm9ybWF0aW9uOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9T
IERpc3RyaWJ1dGlvbjogQXJjaCBMaW51eA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IExpbnV4IGJ1
aWxkIGluZm9ybWF0aW9uIGZyb20gL3Byb2MvdmVyc2lvbjoNCj4gPiA+ID4gPiBMaW51eCB2ZXJz
aW9uIDYuMTYuMGxpbnV4LW1haW5saW5lLTExODUzLWcyMWJlNzExYzAyMzUNCj4gPiA+ID4gPiAo
dGFsQGFyY2gtZGVidWcpIChnY2MgKEdDQykgMTUuMS4xIDIwMjUwNzI5LCBHTlUgbGQgKEdOVQ0K
PiA+ID4gPiA+IEJpbnV0aWxzKQ0KPiA+ID4gPiA+IDIuNDUuMCkgIzMgU01QIFBSRUVNUFRfRFlO
QU1JQw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9wZW5XUlQgVmVyc2lvbiBvbiBteSBSb3V0ZXI6
IDI0LjEwLjINCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBMYXB0b3AgSGFyZHdhcmU6DQo+ID4gPiA+
ID4gLSBMZW5vdm8gSWRlYVBhZCBTbGltIDE1IDE2QUtQMTAgbGFwdG9wICh4ODZfNjQgUnl6ZW4g
QUkgMzUwDQo+ID4gPiA+ID4gQ1BVKQ0KPiA+ID4gPiA+IC0gTmV0d29yayBkZXZpY2UgYXMgcmVw
b3J0ZWQgYnkgbHNjcGk6IDE0YzM6NzkyNQ0KPiA+ID4gPiA+IC0gTmV0d29yayBtb2R1bGVzIGFu
ZCBkcml2ZXIgaW4gdXNlOiBtdDc5MjVlDQo+ID4gPiA+ID4gLSBtZWRpYXRlayBjaGlwIGZpcm13
YXJlIGFzIG9mIGRtZXNnOg0KPiA+ID4gPiA+IMKgIEhXL1NXIFZlcnNpb246IDB4OGExMDhhMTAs
IEJ1aWxkIFRpbWU6IDIwMjUwNTI2MTUyOTQ3YQ0KPiA+ID4gPiA+IMKgIFdNIEZpcm13YXJlIFZl
cnNpb246IF9fX18wMDAwMDAsIEJ1aWxkIFRpbWU6IDIwMjUwNTI2MTUzMDQzDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUmVmZXJlbmNpbmcgcmVnemJvdDoNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiAjcmVnemJvdCBpbnRyb2R1Y2VkOiA4MDAwN2QzZjkyZmQwMThkMGEwNTJhNzA2
NDAwZTk3NmIzNmUzYzg3DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUGxlYXNl
IGxldCBtZSBrbm93IGlmIGFueSBvdGhlciBpbmZvcm1hdGlvbiBpcyBuZWVkZWQsIG9yIGlmDQo+
ID4gPiA+ID4gdGhlcmUNCj4gPiA+ID4gPiBpcw0KPiA+ID4gPiA+IGFueXRoaW5nIGVsc2UgdGhh
dCBJIGNhbiB0ZXN0IG9uIG15IGVuZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGFua3MsDQo+
ID4gPiA+ID4gVGFsIEluYmFyDQo+ID4gPiANCj4gPiA+IEhpLA0KPiA+ID4gDQo+ID4gPiBDYW4g
eW91IGNhcHR1cmUgYSBzbmlmZmVyIGxvZz8gVGhlcmUgc2hvdWxkIGJlIHNvbWUgY29uZmlndXJh
dGlvbg0KPiA+ID4gZGlmZmVyZW5jZXMgdGhhdCB3ZSBjYW4gaWRlbnRpZnkgZnJvbSB0aGUgcGFj
a2V0IGZyYW1lcyBkdXJpbmcNCj4gPiA+IHRoZQ0KPiA+ID4gY29ubmVjdGlvbiBwcm9jZXNzLiBT
byBwbGVhc2UgcHJvdmlkZSB0aGUgc25pZmZlciBsb2dzIHdoZW4NCj4gPiA+IGNvbm5lY3RpbmcN
Cj4gPiA+IHRvIHlvdXIgT3BlbldSVCwgVFBMaW5rLCBhbmQgWnl4ZWwuDQo+ID4gPiANCj4gPiA+
IE9yIHlvdSBjYW4gY2hlY2sgZm9yIGFueSBjb25maWd1cmF0aW9uIGRpZmZlcmVuY2VzIGJldHdl
ZW4NCj4gPiA+IE9wZW5XUlQgYW5kDQo+ID4gPiB0aGUgb3RoZXIgcm91dGVycywgd2hpY2ggbWln
aHQgYWxzbyBoZWxwIHdpdGggZGVidWdnaW5nLg0KPiA+ID4gDQo+ID4gPiBUaGFua3N+DQo+ID4g
PiANCj4gPiA+IFllbi4NCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiAqKioqKioqKioqKiBNRURJQVRF
SyBDb25maWRlbnRpYWxpdHkgTm90aWNlDQo+ID4gPiDCoCoqKioqKioqKioqDQo+ID4gPiBUaGUg
aW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRoaXMgZS1tYWlsIG1lc3NhZ2UgKGluY2x1ZGluZyBh
bnkNCj4gPiA+IGF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50aWFsLCBwcm9wcmlldGFyeSwg
cHJpdmlsZWdlZCwgb3INCj4gPiA+IG90aGVyd2lzZSBleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVu
ZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQgaXMNCj4gPiA+IGludGVuZGVkIHRvIGJlIGNvbnZleWVk
IG9ubHkgdG8gdGhlIGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkNCj4gPiA+IHVzZSwgZGlz
c2VtaW5hdGlvbiwgZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcN
Cj4gPiA+IG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1lbnRzKSBieSB1bmlu
dGVuZGVkDQo+ID4gPiByZWNpcGllbnQocykNCj4gPiA+IGlzIHN0cmljdGx5IHByb2hpYml0ZWQg
YW5kIG1heSBiZSB1bmxhd2Z1bC4gSWYgeW91IGFyZSBub3QgYW4NCj4gPiA+IGludGVuZGVkIHJl
Y2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZSB0aGF0IHlvdSBoYXZlDQo+ID4gPiBy
ZWNlaXZlZA0KPiA+ID4gdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNl
bmRlciBpbW1lZGlhdGVseQ0KPiA+ID4gKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVs
ZXRlIGFueSBhbmQgYWxsIGNvcGllcyBvZiB0aGlzDQo+ID4gPiBlLW1haWwgKGluY2x1ZGluZyBh
bnkgYXR0YWNobWVudHMpIGZyb20geW91ciBzeXN0ZW0sIGFuZCBkbyBub3QNCj4gPiA+IGRpc2Ns
b3NlIHRoZSBjb250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5r
DQo+ID4gPiB5b3UhDQoNCkhpLA0KDQpBcyB3ZSBkaXNjdXNzaW9uIG9uIHRoZSBwcml2YXRlIG1h
aWwsIHRoaXMgaXNzdWUgaGFzIGJlZW4gZml4ZWQgYXQgdGhpcw0KcGF0Y2g6DQpodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxlc3MvcGF0Y2gvMjAyNTA4MTgw
MzAyMDEuOTk3OTQwLTEtbWluZ3llbi5oc2llaEBtZWRpYXRlay5jb20vDQoNClRoYW5rcy4NCg==

