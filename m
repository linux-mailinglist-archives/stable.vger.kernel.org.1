Return-Path: <stable+bounces-153204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C5ADD310
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 17:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21EE17F576
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543412F3625;
	Tue, 17 Jun 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b="CO1ypjtq"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021125.outbound.protection.outlook.com [52.101.57.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BA2E88B1;
	Tue, 17 Jun 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175212; cv=fail; b=uOrS3r0ybVwti0niB+rC8WZOIwa/7PS6gX9ynFCLn59WajaMIT6c6CvbsOw2ceeJNqsgF1uTLdrugLd60UBqS5uZBXWmDEzRa29dBmOUYaQNlgitSzpXeZCuyvv4VD6iKy6Px6qKKqqhe3njWHOgrIzIPwWetxVqS9TpzV3HK+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175212; c=relaxed/simple;
	bh=NjrnvAK4ozt+gXZ01Pd5Z2nm8/kcOtCIdBhw/MhLpmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jXjG7Lcy+oWY93R0fqzwQKmVFiGj+L0HsZeaKo5HyIRFjYHHfBgTZ7Ht7SbtqmL2CYzrqqsYjtoCHP73ANDZZTdbwloo9AepL8EgkH4TZ7thjcpofwyL/efw2EO2vHmbc2oNVx7RXmZXIcCSaSwceLwA//9OlqsSQbkbRt8Jkdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com; spf=pass smtp.mailfrom=tektelic.com; dkim=pass (1024-bit key) header.d=Tektelic.onmicrosoft.com header.i=@Tektelic.onmicrosoft.com header.b=CO1ypjtq; arc=fail smtp.client-ip=52.101.57.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tektelic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tektelic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWdLBum+MtDT0kjDIzDOeTspjKtvHDUlQCofXkeYNsVh4ErpUmEzll1RnSsA2+X47YqDz7Klrj1oFiLi+NVYuzMF4zSpR+ntCznuInMG4IQfoKnvGy1TpnYJi+9rAfjiV3uXF+Zi4/Nz1lFLsOG5f6IVP8GAT1uwLpTKi979s4imohHDU+Wi/NxgBmcchz+xjx7hWN8RLIblqswfILwf5SHw/kO8U1WaIux6z1xz0VT+NpgIo6aCVHTL9PWTvjET83D1rFdhr49NJY5poZA1tQgdYuF7iY6AjrC8R/gSwsexvCqXmF1ZGdjIxSGk9hnAnwT6LImJHsnj7dj1LzfloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjrnvAK4ozt+gXZ01Pd5Z2nm8/kcOtCIdBhw/MhLpmk=;
 b=wk1q7DxTGSVdWBMGUiBnwprjvM4lqyxBVKIvi9kd+n8yuyrNyOE+DYQbxkZgoCnx32RZcc56YMseedryTGp8yIDp7JqUB3D3EvGThRC3RFzLnk+hLrVj8kPgQ+PoP6/wsDNiGRf/2m1eVBEs29nomvJ4JHTLKcZDg/D4LvX/5Ml+X5uruKVqQGZMCy98fHUNuBQsIl8qNdGhdyafr7MQvKV2a55rjK+/NL4Lx0N1a3zwcWbOGCg2SFBOrZjVV62MpFVkeim/BexFuXxFFbsGVI2JvvlI1O72BE0ULSt1XWqRr9kyoNBYOWZv3uq/Zlw+L0ndYFUQfEWqXQZfywmqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tektelic.com; dmarc=pass action=none header.from=tektelic.com;
 dkim=pass header.d=tektelic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Tektelic.onmicrosoft.com; s=selector2-Tektelic-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjrnvAK4ozt+gXZ01Pd5Z2nm8/kcOtCIdBhw/MhLpmk=;
 b=CO1ypjtqFPaLxZyDO2Ad8d9Wr/E066amN8BxAqoaRcpCYkUoF9j2v18SlfGEybxgd6/hJFSe462fNfsh1LY9ZJvgiWHC0EqNOiq5smQjQAbKr0oyNoUByLDc8CGDZkhvUU1fQrRP71krG3aIxJfs97czdI8Guawk7WoBNmYmdLo=
Received: from DM6PR05MB4923.namprd05.prod.outlook.com (2603:10b6:5:f9::28) by
 SJ0PR05MB7229.namprd05.prod.outlook.com (2603:10b6:a03:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 17 Jun
 2025 15:46:38 +0000
Received: from DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc]) by DM6PR05MB4923.namprd05.prod.outlook.com
 ([fe80::27b8:b7d6:e940:74bc%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 15:46:37 +0000
From: Aidan Stewart <astewart@tektelic.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "jirislaby@kernel.org" <jirislaby@kernel.org>, "tony@atomide.com"
	<tony@atomide.com>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] serial: core: restore of_node information in sysfs
Thread-Topic: [PATCH] serial: core: restore of_node information in sysfs
Thread-Index: AQHb3trWuoYm/FvB5UeAt4WYhHq487QGx0IAgAC5DYA=
Date: Tue, 17 Jun 2025 15:46:37 +0000
Message-ID: <915d0631ac123bbbb5d3fac1248b97d9de3295c6.camel@tektelic.com>
References: <20250616162154.9057-1-astewart@tektelic.com>
	 <2025061746-raking-gusto-d1f3@gregkh>
In-Reply-To: <2025061746-raking-gusto-d1f3@gregkh>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tektelic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR05MB4923:EE_|SJ0PR05MB7229:EE_
x-ms-office365-filtering-correlation-id: 56ed8a97-a6a3-4b8a-b162-08ddadb62528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXBVWmpCVDF3QnA1RzE5LzVOa0tzRzlXYkNVRTl5VGNGZ0YvbnByMGFNbERN?=
 =?utf-8?B?TGZON3FxdnJaU050Q01nQ1lRelg2RDFxUFNQd1lVUG5OakFLbWhiMHdKdTBZ?=
 =?utf-8?B?YkVEeHlGMzlFWVExVkpyOE5PeWxPN2pzeW54OXo4SnE3bDFsN1VhYVRWVUd1?=
 =?utf-8?B?VmkzcU5Ba25RVjM4MlhncGE2TFVtTVFzNlV5NE9hblJBOFRtV3czRW4rdHhh?=
 =?utf-8?B?dHB0RXVWdndKOTFrbzYrWDNBTEYxRlRPKzBQR1h1Tml6Q3NFSlZzUkNTU01H?=
 =?utf-8?B?eFZMUGJiaFo3elA5bHd6YUt2YnZoQ2RSdWZFNVdCOGdpOW9XMGJpZnRQZTQ4?=
 =?utf-8?B?M2xnS0dYbTNoS0VXQ1lWSmVOMDR2T3hZZXA4R0NsNE92NnpJWkpmdlpSNTQw?=
 =?utf-8?B?aW50UC8vQ09GeFJ5THFCcDQ5VWJDOW1zTzZ4dElZQWNSVjl4cjVjQmJIZzVG?=
 =?utf-8?B?RjJVeUI5cEdaNEZ1UW5PSGxkMmJRVGlVRGFHMmVHdGNMcjNPZjVvN0xma1p6?=
 =?utf-8?B?cDk2MmRyWis2cXJUbi9GWXNYSUdxQ2ZudXYwdFdNdGVod09tYlpuMWFENHZq?=
 =?utf-8?B?WWM4dHUwMFg0c29qTFpOeWhpc00yakM0THp2Y1pjaXJxL3JWVzVLWVNDN0ZH?=
 =?utf-8?B?T21SKzBIL0FQR2VZeWIraFNsUTZXSUhXSWhZSWxKUnRIUmxUODJna0RMSSs1?=
 =?utf-8?B?d0ZBU0cvWnJENlJZT1U4bzBJSzVJZ1pTa0tuOFpiWVUwMzRSOTg0OHI3dmlm?=
 =?utf-8?B?R1FkN3V2bnBpZGNYZm9iRzBKTHFGeVNjditLUUlUVGdoV1VURXpXT1JhSzR5?=
 =?utf-8?B?UHFLeXJvWFBVZmJzbEt6MFhyTm1QV2RMSmZnem8yN25mOHBvb0hWakhaaWxs?=
 =?utf-8?B?dTdTNkRsVHI0a2UrTGN3V1NIL01xdmFCdjdZV2hVY0ZlRy95TzZCT3I1ZWFh?=
 =?utf-8?B?Qkd6RlFsMGVCaDNyTm5EOUpJTGhnOGZOcElzZVk4SkI0dmpjTEpOWW1sOE5x?=
 =?utf-8?B?UjNvK3VVMk1xV0JRT3hCcmpkUmh1YVFaTFFEblkzNnkweTdPbEtPeFZFS0d3?=
 =?utf-8?B?OTE4dUU5enBJMXdaeTB0QmRMbDIzSjRobURxTWVMZHN4R1VxZjJiNGdkNWVp?=
 =?utf-8?B?MmhuakJpVnJwOENGZkwwMFVEUHY2R1VDdXBCRnVxbmpBNW8veFc3RXVmSkR0?=
 =?utf-8?B?eXRaL2M0T3RZb0tuaHNTSEw4YTExb245SHNzeWdudGh0UVluMG40cVpueEdm?=
 =?utf-8?B?cWhoTWRkUkVLMFVjUXZjSml4SjZMdHFPSGYrU3NCM1BldWIxTWIwMVF3ckFX?=
 =?utf-8?B?ZnNzNlNUT2VwZEVxN0pCejF4R09CcGZkOFVNN3VXV1Mra2JqNi9EMXl3dWFu?=
 =?utf-8?B?LzFkeXJtL0RuNDdwZXQ5eFBTRll1cEZTR1NNaVlPV3NDWTRJVUxOK09ZMWNZ?=
 =?utf-8?B?TllQMndYNDRYNEtOMVVCTHlUOVRNR2FNTEJsdDJoVkMzR0F0bThqYTBXSlE1?=
 =?utf-8?B?MGxxVzdrSWQ0VkFiVE5yUUFjVDZrQ01TUURWMG9IdUZJQVRCR0xpSktXMU53?=
 =?utf-8?B?Mi9SdU5nbi9zNGFSSkJ6UTF1N0F0OGNWbkxqK0pVYTRBbHJJTTRuVzlpRSts?=
 =?utf-8?B?cTZhWEtTSGdIRmtQZllZb245cDU0VTh2WEV1NDRQRStaZWdzMTUyMkNQRDRn?=
 =?utf-8?B?MmRuSTlIOVIrNUdvUmdPdWhxZ2FTV0tGWVJidVRVTzlnVWFNQmNtVk0zVlVG?=
 =?utf-8?B?WmNWa2ZoRWdXcDU4RmZQbW1HMVk3aUxWdllvYVc3d21yVnJaQTF0bUNiQWs2?=
 =?utf-8?B?bzJRQTBJV1JFMEZmb2VQZnEwQjJBY1pHU0tRZ3c2MUVGUG1JSXFaanBGMVFm?=
 =?utf-8?B?SXRCOXZ0QVNkRThsVWhaMDd1TTRJNU5za0FiYmJEMVJmYU5tRkI2NjhRc2Jx?=
 =?utf-8?B?alAvMTF3eWxsVjg2aW8vbGFBS0Nxdkc5NWFOUnBXNTM1OWFvWjJiaFZuU1px?=
 =?utf-8?B?TEt6ZU94ak9BPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR05MB4923.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NWRxQUVGMXY2alRsK3dhUDVQT3pVNm1Pb3pHWWx0eC81SVNXUElYTk1QTzRG?=
 =?utf-8?B?NVd4UHBKM1ltMTZzTzNmQ1huNkdMUklhNEJGQkdKYldFWHZJYmE5UjVFS09a?=
 =?utf-8?B?Y0hYQlY5WnB2VFk4SXo4dXhYK2tzUDR5dVBXWVdSeFdpdkgyMFp6MmF6WGEr?=
 =?utf-8?B?RnFZTGIxS2s4UnlIcW9KWjdMNkhUSTB3U3llOFQ3Y0tHL0hITm1pUHczcUhG?=
 =?utf-8?B?SnlvRkh4VHdCamF6SE9GY05Eeks0amZ1Tm1IRzZQV1dyditKQjd1YWUwSEY2?=
 =?utf-8?B?RFNqNXpTNndpOFJxSW9YUk9MMjQxM0hzaVNnMTlyYWNRV2hSc0puNlpmdGZD?=
 =?utf-8?B?OFo5QW9JTWxmZFZuT1NSZS9RZnY1VzV3VlMyQWYzN29RSzFzc1p5bkwyMnZi?=
 =?utf-8?B?V1ZocU1rN0JLUURIOHBoNnBiaTErRmFYeWxIYXd6U3V0ems2d1pzWkc5NGZT?=
 =?utf-8?B?ZkNmVS9oZEFJS3JmYkxzNmtUMDNmWncraG1OS0hKd3lKY0xsN1FHbGlJekFl?=
 =?utf-8?B?U2l4M1RVelFxU2dCeXZpUy93cWFXcHpEWk94UHBwcVJzN2pvQmlFSzVrcndB?=
 =?utf-8?B?ODF6alhIcW10ZGkzdXY0YmZET0lzNkZieCtjYnNrb2FibWVtcWNQbVhRZlFT?=
 =?utf-8?B?L21UQ0lVb2VSQ3lVdXNwMUZDaWlTblZ0czgzM3hsdW94ZTNWRTFSb05kTjhx?=
 =?utf-8?B?SlFROVRHbVdQaWdXRjlwdUh2M3hXQ2kvNEtMaWp6YW9ZWTVrb1cwUUpYRkFB?=
 =?utf-8?B?TFJvWlpFUnhwcUNraTdORTlFYTk3UlBtTlBmQWZDMEV2bGpsQ202TFR4QUh2?=
 =?utf-8?B?R1drT09ucVhOYkp3ZmI2R2lFUzJUWlptYUNtZzBrVVVKN0UzbEZHZ21YTlV0?=
 =?utf-8?B?M2lLc096Y0FzVmhKMXVNcVpJbHU0ZXFIN2FNTDZrWFpPZXBqTVNiUi9ZeHc1?=
 =?utf-8?B?NVlFdTQrZ0EwbFpGRThkVFphTzZBazNqWFpIdEZ2bkdJRHQ0RGNURXUvOFIx?=
 =?utf-8?B?NC94MURLOTZyMnZablNEV0IrOWhNdmRiTytKeW1qQVE5NjFqNFBzWDRwU3lS?=
 =?utf-8?B?WHR6YVM3WWV3OEdaSGcvd0VVZ05pV0RYaHI4QWRDak5aUnMyTGhSTmc1UHEv?=
 =?utf-8?B?clU1VUZ0MHdsejFiL25zcCtoNm9PbWpYOXFOa0FNSWxzSDY1QnlQN3VPMnE0?=
 =?utf-8?B?LytvNWthVmZHTDlUbG5Ya0d2T3lva2ZzbWllMjFxbHVLSHQvUXNUeGxMMlRa?=
 =?utf-8?B?UElydTREZmFlclJMZWx1M3J5by9DejFDamhZb01YUE9LZk5ITGVpZnFLb1FW?=
 =?utf-8?B?SE9nNTJ5ejhqQWdjRWY5ZFJFRm5CKzhoSGpnN0NiVnlLZlhwWVgreXNReito?=
 =?utf-8?B?QVpPZVJOTnBNT1krOC9lMHhjcUdobTJHZ0FmTG1WSXFBUzFnZ1dyMENlM1JE?=
 =?utf-8?B?YTJwR0FQWVZpTU0zYUFmWlkyU1RCbGZDWDdkZGF5RFl2RkU5RHlBUndoR3hw?=
 =?utf-8?B?T0M5Q3NVU3RnNllPbys4bTZqSG1HeWlseEJOTGwzMzNtNGVWS1F0YlcvTGg4?=
 =?utf-8?B?TmljazlUM0F5dzEzdHRkYlU0Q3BEWFN2NHQxdHFEemx6Ti9FYjBKcTBGN1ow?=
 =?utf-8?B?a2JrYkpWV1dXdEtYMjJoTHIxNUZsSzh3VmQxeU9ab3lvZ0t3NEVIYUw2Tmdz?=
 =?utf-8?B?MENwNDBWZFh5MkpaUkRSVit1UG8ydTVXaGhSUXdYMldWUmEzeGYyd01KOE9p?=
 =?utf-8?B?eEM0V0xpZ2E2N1lhQjNaV1kzSkZOMXJnVHRGYklQTS9lSnl3SVF1WUh3bkRz?=
 =?utf-8?B?RFJWM3A2bFdtUXRNOHFmQUlGRUllbmZxZDZnbU00Zlk1cDF5VGxiUkJ0aXNM?=
 =?utf-8?B?MXlKeW56TUc1U0t6amU5bEJDWjJ5TThSdStoem5wZURtNVlsZFZ3ZTByelk3?=
 =?utf-8?B?czQ5cmJDQm52Rm1MVXE5cVd1VXNMQ29NZTlydzJSdUcwenl6K0RuZlRkVTU2?=
 =?utf-8?B?SWxyOTlqNzNqZWNEWG5DSkp5RzVkTDMxeVUrL1RZV1lkaW9lVkJLc0QvRjFn?=
 =?utf-8?B?VTRLZXFWUzhQZFV0eXBRdFRUQXdtV0ZqWGdKV3UrcDliM2p5SVN5ZHFBTFBo?=
 =?utf-8?Q?1O87oI61kQ+TTWNRzevbxswrD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E14419280D969D4E9B118ADD4C4EEDDA@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tektelic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR05MB4923.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ed8a97-a6a3-4b8a-b162-08ddadb62528
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 15:46:37.4927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 852583a0-3638-4a6d-8abc-0bf61d273218
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOQqO3qZZhGodvfCJdR+QaYuc8e8nyq4NW5LWfyREVFFD1FyOCFmU+r+RYByfB2Cq4Y93tf8jQ7A+0jxKO447A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7229

T24gVHVlLCAyMDI1LTA2LTE3IGF0IDA2OjQ0ICswMjAwLCBHcmVnIEtIIHdyb3RlOgo+IAo+IE9u
IE1vbiwgSnVuIDE2LCAyMDI1IGF0IDEwOjIxOjU0QU0gLTA2MDAsIEFpZGFuIFN0ZXdhcnQgd3Jv
dGU6Cj4gPiAKPiA+IAo+ID4gK8KgwqDCoMKgIGlmIChJU19FTkFCTEVEKENPTkZJR19PRikpIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2aWNlX3NldF9vZl9ub2RlX2Zyb21fZGV2
KGRldiwgcGFyZW50X2Rldik7Cj4gPiArwqDCoMKgwqAgfQo+IAo+IERpZCB0aGlzIHBhc3MgY2hl
Y2twYXRjaC5wbD8KSSByYW4gY2hlY2twYXRjaC5wbCB3aXRoIHRoZSAtLXN0cmljdCBvcHRpb24g
YW5kIEkgZGlkbid0IGdldCBhbnkgd2FybmluZ3MKb3IgZXJyb3JzLiBJcyB0aGVyZSBhIHN0eWxl
IGlzc3VlIHlvdSB3b3VsZCBsaWtlIG1lIHRvIGZpeD8KCj4gQW5kIHdoeSBpcyB0aGUgaWYgc3Rh
dGVtZW50IG5lZWRlZD8KSSBndWVzcyBpdCdzIG5vdCByZWFsbHkgbmVlZGVkLiBJIHdhcyB0cnlp
bmcgdG8gYXZvaWQgdGhlIGNhbGwgZm9yIG5vbi1EVApzeXN0ZW1zLCBidXQgaXQgc2hvdWxkIHN0
aWxsIGJlIHNhZmUgdG8gZG8uIEkgd2lsbCByZW1vdmUgaXQgaW4gdjIuCgo+IHRoYW5rcywKPiAK
PiBncmVnIGstaAoKLS0gClRoYW5rcywKCkFpZGFuIFN0ZXdhcnQK

