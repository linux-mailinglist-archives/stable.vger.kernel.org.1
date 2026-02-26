Return-Path: <stable+bounces-219802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLigBfA+oGllhQQAu9opvQ
	(envelope-from <stable+bounces-219802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:39:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 812731A5CC1
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91EE93072470
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907BC378D91;
	Thu, 26 Feb 2026 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="R5jymLHn"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AE37B417;
	Thu, 26 Feb 2026 12:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109521; cv=fail; b=SBE8ZpIgUib9h2Tl1XBnw5SEAHvsG11KJTWrXGtMvYSY0B5A8EeTgU9+r1SGS0WE2plNMQd32AOj79pKgoF0J1SoIbLZCLAABraDCU1vi/DlmuM+9/tGeX136jv12U7b5h+3nMMsedzk5+IPlFocBEVIRXOiRdPm2kVrYcKBubg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109521; c=relaxed/simple;
	bh=fCHqzIqJxP5qvg3mGqSORWyXemaIW75sgHrPspmQQec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxq7n6PoZ3fN4+WoXdLlZSmFRKRQdA7Hyobw3hevKhjgD+SGBTk4bOYrM2K7tdQ+gthAAF32MnRJ+PfONMeumACp9dX+kSPiafO/yih5xouu00cZTZVGptZ+QSwswiGzW9b2PB+gvDBLNBux5KXWMShopn7AdpKgNrUu9m5Dii8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=R5jymLHn; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PNS9HX3789356;
	Thu, 26 Feb 2026 04:38:15 -0800
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021124.outbound.protection.outlook.com [40.107.208.124])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cjasf9gg5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 04:38:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRVPJpJtt11tlXxt7YrsxMlQmy5iBtC7VYf5nJTSOu+W3U09VBoxYL7fd7O5ROjZDRsX0HShpzBow+QneMIxdfLQlxVyhn9oJTiig/u8PzZuPi4IUe3g0R5EpJWjV/YHy4p6IxpyMEW+kFEgIvAYfAQmOqPYbeLZ34Y7kJoty9DzNXJolJJ9VlFZeZfDhdkM3NPvpFGQvmYawcudT0nHyyCpDbUgBTm4Lyu9TjyV4BlDAUkzWDMZDGEyrm4NkeGz8hXbwzS6EW+SfvdfuFdN25+2/QhCWR2OJYGd24F3kUlOlLbj0bhXPhYs5nFRgFB4SeVS7NXE73xe5cKoVpon7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCHqzIqJxP5qvg3mGqSORWyXemaIW75sgHrPspmQQec=;
 b=Xd7khLsXTkCtoXpmMyHCcSNo9PYdTiwiKSSdl2BY9ZqAVqic5/DzK5aqfKg+JmsAdfT0ntRvQil3GYdZyUs5FWvl19Q9Lk3mx+OWP6uJc/PZ3YID2wJSD63B1hP6c7EgUudSpX8h0Mzli19bUbS2cSA7Qr+S6MMCGbP6MIyJIg3q3+0FjlRIRYmM/qbfFIz29Ap0XjJTP+cvvrU7evZOTAwgDyvl8cJYndgaayUb+ozKZpkXqhM93RJwK7VDWpOsabvOSaYKoiK5FxBMLeZhnbxmuzl3WudGj4EUfn5jc8nmNfj21XoWpsJlwT3oYobfL9JHMeTImryKZlpkfsguVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCHqzIqJxP5qvg3mGqSORWyXemaIW75sgHrPspmQQec=;
 b=R5jymLHndjpnplNadWFfFVkg7LjXRPHtZkGmj0jryvMew1OHPdYPEYSEG0lwz0Qbj4dQR3ROh7moovoPvjgMywU3uXjM4wQn4E1509ma1Dp3hSCVEIGCu5+EWKd9DdxTKNOOagpAhmwYeh5/hPvPXeRXXOQPb010jc+ZRmLnwiI=
Received: from CH3PR18MB6379.namprd18.prod.outlook.com (2603:10b6:610:205::13)
 by BY1PR18MB5924.namprd18.prod.outlook.com (2603:10b6:a03:4b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 12:38:12 +0000
Received: from CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::e9d6:f43f:cd52:d685]) by CH3PR18MB6379.namprd18.prod.outlook.com
 ([fe80::e9d6:f43f:cd52:d685%4]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 12:38:12 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Topic: [EXTERNAL] Re: [PATCH net,v4,1/2] virtio_net: Improve RSS key
 size validation and use NETDEV_RSS_KEY_LEN
Thread-Index:
 AQHcpVsOKxOBWB2/y0CrIf5i5ji46rWTMV0AgAAk+ICAAAJzgIAAAelwgAABfwCAAAGJIIAAAtEAgAAH/QCAAADq8IAACUWAgAF5mMA=
Date: Thu, 26 Feb 2026 12:38:11 +0000
Message-ID:
 <CH3PR18MB63793392A286E79CA6507896A072A@CH3PR18MB6379.namprd18.prod.outlook.com>
References: <20260224065850.962826-1-schalla@marvell.com>
 <20260225050154-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63744FC9F4786AB2F617AC4CA075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225072355-mutt-send-email-mst@kernel.org>
 <BY1PR18MB6374C4D43F9BD88443A8B067A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225073537-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63741BBD1FEF6CB7328A7B44A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <BY1PR18MB6374C5EC263CB6812B197296A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225081735-mutt-send-email-mst@kernel.org>
 <BY1PR18MB63740F76E83C299E9AAB32F0A075A@BY1PR18MB6374.namprd18.prod.outlook.com>
 <20260225085523-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260225085523-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR18MB6379:EE_|BY1PR18MB5924:EE_
x-ms-office365-filtering-correlation-id: 10c48728-56be-4f2b-6f95-08de7533e759
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|7142099003;
x-microsoft-antispam-message-info:
 FViJE7YL/AWYHbjpGUrg0hK+msjwdNoixBgmucrGkbQFbsdgFur5JRblcUhk1qIveu8utW3P0Gm2P9a7AWAca+9e8v1z6bgeqMuu7elcNfZTwWH7qPps/EaSfXwf4s6ox9f6oBWWhb72uZRTSJ1W3vIPQN2Z4QxCbIsCZdrBoc4cSq6IYHv9NhXRCE4KbdRkufqd8c0Gk2Sca0TKYKN8nxFAGpmLbMuYd9Omv1hl5AYjUKXf071zXzHCR4WHABD9MzEPoymKGjHDbQBTPkyB0v3YuUqzHZ+JKnqlWJBafyzp7clK/he9M7iiTSmfmje1XmTx5QWWtWxgglmpT/dRd1UMxQ0WLcN2/fVxdOZ3r99ZngB8B0XKeuxcWmhl/v4YiptsKXkgf6JQCGFktj6NW3rtxNnPpZK2kEDM4TaoDzPZjsSes6WwQ/SenVftBvdHWyAaJyz9B+MMMYOqUC+dctTj/e/9kQhqnPvtxDJ/BUKgu8a0xPTg64TcVUGqJdh3DPJyKwf2D3ZP6wcUuNMZDHKL7/XJyhV6TMuIgvOw19zP4zR6wPANflaMRwdqHKHWjfwcnbjHIDh3XeCKw+iA/I4e57Op4F8RsK1LSxZrGmhsqSlG0NCHcIt49E48zWgdYIfWJaWmeCPIxo53masuU2Ol+OB8o6rZUr1coIXMfN7eowfDdp7jk3km2ZPDgjYW0pHTsKJNToWPm2Pp2CsPuyZF1Noasp56hhELMF+hidIf3akvU/ybv28WZTIb++MxqzYi4l0gG2F8izsL+WVxr6egfBtitIu8SzJcI54JrA0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR18MB6379.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(7142099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDBOZmROdXV1KzUvUkpFV1BIWlo4bHZxbWZwZlU1UUtNNWlYYWZUSEFDREJF?=
 =?utf-8?B?eVdDT3M1M3Fmc0Z4ejJXeFp3TXE0SG12VllVNVYvRlMxSnZnclhYeWNKM1Z5?=
 =?utf-8?B?STlXUTFzdWVtc3Z1YzNQU3FyZkdWTnp2bzB6MzM1OVRyd01SaXlHTFZzTWt5?=
 =?utf-8?B?bDAzdElZcDRySU9OcTNBVG5KVVZZTU1TRUV6eWY2N3g5SWo3VCtsazN3Z2pk?=
 =?utf-8?B?WU41U2RHTVJXUWc3RkdWN1JXUVlBRmtHMkRMNlYrSFhQSjlTQ0JhcmphdkFR?=
 =?utf-8?B?MnZDT0cvQ0RFWW5nUUE4MncwcUxqUS92VWsrelpadjRzV05UUTZaQWpKSFpu?=
 =?utf-8?B?SjdTZ1RGS2VmaXNXakhaclUyTVBVUUVJT283Y0U3dmpFbjZndzJFeXBHR2dP?=
 =?utf-8?B?dTRUTWhVeDZkQXczUDVBR0dpOTRJcmcyTllKSzk3ZG1oajF5Q2xvcElVU2ZU?=
 =?utf-8?B?MjR1UThRbHdra1ovUHB0VUVKK1hTa0tma0greTN2OGxaOXk2TUVEaWRmZ2xX?=
 =?utf-8?B?MGdHQjBSV3ZxaVJQY3U2U0dlLzI3N0ZkdWtEOFFSNXpBYTJnOUVOUzdPTEIx?=
 =?utf-8?B?TVg4NmpvU3crOEZOS01Zc0tKc24zTU5Cc3BkSHhjMjk2eXlVeUdEc1pUV0sw?=
 =?utf-8?B?OUE1alVuOEp3UTFoeUYzajJlNTU3YTZXNFlEUTJCRk85MXNXcENFcEpWM0k0?=
 =?utf-8?B?eTJYNHFLNzBoekE3cWlMNTBDSVVwc1VlNEJub1QvbEc5WlZMcDRyNGg1TjZQ?=
 =?utf-8?B?ZzFtZVhnL3pKV2ZsNmY2MjFFaUEvMzE0NXlkMGQvbllURC9pZ3BidlRCaVdm?=
 =?utf-8?B?RW9QNitwRmhEakFQOThDM091dDlyV0c0aW9zYTkvdVlOTkE4bHB3QW4yVzZV?=
 =?utf-8?B?TktjcC9aU0tmZjM5SVNZejFqMjVnejZzZFNuZmdLR0x0aDR3S29KVUZsNVBP?=
 =?utf-8?B?OG4vYkFEK0RpcmxBdGlaNEllNFBwbHhnVW9Yei84eEpZMDU1S3pZZWk3SmdG?=
 =?utf-8?B?eHJrUUJmOHpuYm5QcnY4YkZnTTRDaTZxdmZTSlAyQXdHS29HWXZwWlFzb1NV?=
 =?utf-8?B?QnAyRjkyOEtMb3o5WTJSSm1sRnpuSHo3dTg5cG53NFNweGFuUVFVVVZ6ZEpT?=
 =?utf-8?B?QzFrM2xtY1cvclUyT1hxZ0F5UWp0emk5S04wazgzZFhZbENMR0dUM3c2K2hm?=
 =?utf-8?B?NUFoTXMyd0Zrc21vYWxsdTB0d0JETXNkRGVtM2VZUVhBZ3FaWnpJMk1lV0NB?=
 =?utf-8?B?SytoVUloZzhuUk5QdmV4bUNhaDgzZzdFR1ppbWJ6S2xhb09hSGhJbVVOakIw?=
 =?utf-8?B?anIzeGtrWE9RNnhpN3lUR0dEaWpvU1pFVmgrb1lvVFkza21iNXE4a0c4R2FK?=
 =?utf-8?B?aWNDd3M0eTIrQ2dZQVJIaVhRNVVlUG9tdnpROXJMaHN0TDhLS0phUjFIWkhw?=
 =?utf-8?B?bUJEaEt5YU1Xclh2bVV0b2kvOWh5UDllQ2hxNXZXRS9ycHg5dnB0MTk2Z1I4?=
 =?utf-8?B?OUh4SVpNUUxUVTRzZHozd0FYZ3hsWUZ4dCtBSlBJNldoZzJ3eTlYc2xDaWp1?=
 =?utf-8?B?NUZCT3dpTkMzemcwaDRjSHpHaDE2NVZpSHRXMnk0dTI5NVoyMDhnemtFVGhO?=
 =?utf-8?B?M0l6b2Z0Kzh6anJOUVh6RXF6VzJwVTdyeDloOFJ5ckZZRHozL0NoTWpzUHFx?=
 =?utf-8?B?WU4weEFOZitSZisvYUorN1M5SEhjd05FS3dRSTlNTUIwcXV2aWVNZDlmaU1a?=
 =?utf-8?B?c2tNVjZBVWU3ZWh3RWIwZkpWcEFaalM1dXd4dVNWbGlsOFllOFEvZjNycVFT?=
 =?utf-8?B?aWsvY3NPcEVmRGt5MUZ5dEpYRVduWGp4UmhZZm9vVUVkck9zMjZHRFVwR2Zm?=
 =?utf-8?B?M0ZONVVqZ3ZWT014TDVyWFZQeFNUTTlIVWFEeEt2RHVTKzc0TDB1Q0xDR0xk?=
 =?utf-8?B?M0xjcjZNWmRxc3hjSGp0M0VHWWdVNUNOZWdDK2F3T2tMejdFaVRtaGVHa0lJ?=
 =?utf-8?B?Ym1rK3MxM1lGbTlTVS84RXA0UVhtdFE3S3hBQnNIc0E1a0hLbUNRMkRwVStz?=
 =?utf-8?B?QzlJellFZVhFSE9PVkcxQ0puRDZ3UFBITVZCRzd6Y0NHVFJrRThZeGIxR0RO?=
 =?utf-8?B?dnJqMFNicUp0aWFPV3QvVVJ5UzlEVEIwZU1nK2xFdGxUQ1BBSGhZK3ZubWhs?=
 =?utf-8?B?cnV6T0JNNncvS1Urd3NMS0kxeW1PQTVJV2lCUFBRdzN3REx6YkxRZXo3TnZ4?=
 =?utf-8?B?NXdxYzZIY0NXVFdUZk1KVk9YUXlNY29lZFZxbFZsVjFJWFlrTy8zclZSWlND?=
 =?utf-8?Q?DrZRa/GqX918RbNV9v?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH3PR18MB6379.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c48728-56be-4f2b-6f95-08de7533e759
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 12:38:11.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzGoB970erX5e8f5rkpXEBvplgwWfsybdlrWHm/K5q0Bep+u270q+AQWAdWUqKXkRDO9PIEeFDWhHIOcWCS5Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5924
X-Proofpoint-GUID: 5EOQvZ2Fx5cK5CTG09MRmJRT5F5fj1xg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDExNCBTYWx0ZWRfX1B731RpfU4y2
 qoNrMG8pmVPvec2qfVsVgNUEziI7u+RTZ8tAzNf5FvE7EA/Ml2svkFohwROyfErrWo11TR373Y6
 85q4U1x4YsSnN03IF6KQbcPLNW33UI1aPL536PxN5BM8lxJyBulv3bRagJjBHkZIElUEzvyyUl7
 0TQRQY8+Nnk9edbXZ4YpBB7xXk6AnfrMCr80BSifugXAIZGGoRe3iVqlnwvzhAzIHpv5UqtWMWp
 xpNN3KPZwwR9FxTfqaie5pcpZYiGNnMvt8dogun27sUMqmSUa8WfbcO7aLUl9zhPnaWn0qb9Aod
 LgwJSmaMgPZ9b8rwxkg/p+ZvvQTCRXjalf1aKOtQwCZT2XpDdag6Lb6o6Qdx6uA5Ut99qA9zZ5Q
 34LIVYmUjVx7i+T54JQNOXDwu4mYOmNKYo60rQtG93r4xffqUwC6VheM/uN8BlkDpKkWtA2ZOSU
 IpfnPGtiF1/MAd1PDcQ==
X-Authority-Analysis: v=2.4 cv=Fq8IPmrq c=1 sm=1 tr=0 ts=69a03eb7 cx=c_pps
 a=4+O0lPtyMgLZyqY/Ud9keA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=WoWRyDgbo8bG5iPFwoQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5EOQvZ2Fx5cK5CTG09MRmJRT5F5fj1xg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219802-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[marvell.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schalla@marvell.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 812731A5CC1
X-Rspamd-Action: no action

PiBaalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+IE9uIFdlZCwgRmViIDI1LCAyMDI2IGF0IDAxOjMx
OjUwUE0gKzAwMDAsIFNydWphbmEgQ2hhbGxhIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBGZWIgMjUs
IDIwMjYgYXQgMTI6NTY6MTlQTSArMDAwMCwgU3J1amFuYSBDaGFsbGEgd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gPiA+IFNv
IGlmIGRldmljZSBpcyBwb3dlcmZ1bCBhbmQgc3VwcG9ydHMgYSB2ZXJ5IGJpZyBrZXkgc2l6ZSB0
aGVuLi4uDQo+ID4gPiA+ID4gPiA+ID4gPiA+IHdlIGRpc2FibGUgdGhlIGZlYXR1cmU/IGhvdyBk
b2VzIHRoaXMgbWFrZSBzZW5zZT8NCj4gPiA+ID4gPiA+ID4gPiA+IFRoZSBpbnRlbnQgaXNu4oCZ
dCB0byBkaXNhYmxlIHRoZSBmZWF0dXJlIG9uIGNhcGFibGUNCj4gPiA+ID4gPiA+ID4gPiA+IGRl
dmljZXMsIGJ1dCB0byBlbnN1cmUgdGhlIGRyaXZlciBuZXZlciBhZHZlcnRpc2VzDQo+ID4gPiA+
ID4gPiA+ID4gPiBzdXBwb3J0IGZvciBSU1Mga2V5IHNpemVzIGxhcmdlciB0aGFuIHdoYXQgdGhl
IG5ldA0KPiA+ID4gPiA+ID4gPiA+ID4gZGV2aWNlIGNhbiBhY3R1YWxseSBoYW5kbGUuIEV2ZW4g
aWYgYSBkZXZpY2UgcmVwb3J0cyBhDQo+ID4gPiA+ID4gPiA+ID4gPiB2ZXJ5DQo+ID4gPiA+ID4g
PiA+ID4gbGFyZ2Uga2V5IHNpemUsIHRoZSBkcml2ZXIgaXMgY29uc3RyYWluZWQgYnkNCj4gPiA+
ID4gPiA+ID4gPiBORVRERVZfUlNTX0tFWV9MRU4sIHNpbmNlDQo+ID4gPiA+ID4gPiA+ID4gbmV0
ZGV2X3Jzc19rZXlfZmlsbCgpIGVuZm9yY2VzOg0KPiA+ID4gPiA+ID4gPiA+ID4gQlVHX09OKGxl
biA+IHNpemVvZihuZXRkZXZfcnNzX2tleSkpOw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4gc28gY2FwIGl0IHRvIE5FVERFVl9SU1NfS0VZX0xFTi4gV2h5IGlzIHRoYXQgYSByZWFz
b24gdG8NCj4gPiA+ID4gPiA+ID4gPiBjbGVhciB0aGUNCj4gPiA+ID4gPiA+IGZlYXR1cmU/DQo+
ID4gPiA+ID4gPiA+IE91ciBkZXZpY2UgbWFuZGF0ZXMgdGhhdCBoYXNoX2tleV9sZW5ndGggbXVz
dCBiZSBpZGVudGljYWwNCj4gPiA+ID4gPiA+ID4gdG8gcnNzX21heF9rZXlfc2l6ZSB0byBndWFy
YW50ZWUgc3ltbWV0cmljIGJpZGlyZWN0aW9uYWwgZmxvdw0KPiBoYXNoaW5nLg0KPiA+ID4gPiA+
ID4gPiBJZiByc3NfbWF4X2tleV9zaXplIGlzIGxhcmdlciB0aGFuDQo+ID4gPiA+ID4gPiA+IFZJ
UlRJT19ORVRfUlNTX01BWF9LRVlfU0laRSwgY2xhbXBpbmcNCj4gPiA+ID4gPiA+IHRoZSB2YWx1
ZSBpcyBub3QgZmVhc2libGUuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSSBkb24ndCBrbm93
IHdoYXQgdG8gdGVsbCB5b3UuIHJzc19tYXhfa2V5X3NpemUgaXMganVzdCB0aGUNCj4gPiA+ID4g
PiA+IG1heCBkZXZpY2Ugc3VwcG9ydHMuIGRyaXZlciBzaG91bGQgYmUgZnJlZSB0byB1c2UgYSBz
bWFsbGVyIHNpemUuDQo+ID4gPiA+ID4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoaXMgcGF0
Y2ggcHJldmVudHMgdGhlIHByb2JlIGZyb20NCj4gPiA+ID4gPiBmYWlsaW5nIGJ5IGRpc2FibGlu
ZyB0aGUgZmVhdHVyZSBpbnN0ZWFkLg0KPiA+ID4gPiA+IEdpdmVuIHRoZSBjdXJyZW50IGltcGxl
bWVudGF0aW9uLCB0aGUgZHJpdmVyIGJlY29tZXMgdW51c2FibGUNCj4gPiA+ID4gPiB3aGVuIHRo
aXMgY29uZGl0aW9uIGlzIGhpdC4NCj4gPiA+ID4NCj4gPiA+ID4gSSB1bmRlcnN0YW5kIHRoYXQg
dGhlIGRyaXZlciBpcyBhbGxvd2VkIHRvIHVzZSBhIHNtYWxsZXIgUlNTIGtleQ0KPiA+ID4gPiB0
aGFuIHRoZQ0KPiA+ID4gZGV2aWNl4oCZcyBhZHZlcnRpc2VkIHJzc19tYXhfa2V5X3NpemUuDQo+
ID4gPiA+IEJ1dCwgb3VyIGhhcmR3YXJlIGRvZXMgbm90IGJlaGF2ZSBjb3JyZWN0bHkgaW4gdGhh
dCBjb25maWd1cmF0aW9uLg0KPiA+ID4gPiBGb3Igc3ltbWV0cmljIGJpZGlyZWN0aW9uYWwgaGFz
aGluZywgdGhlIGRldmljZSByZXF1aXJlcyB0aGF0IHRoZQ0KPiA+ID4gaGFzaF9rZXlfbGVuZ3Ro
IG1hdGNoIHJzc19tYXhfa2V5X3NpemUgZXhhY3RseS4NCj4gPiA+ID4gSWYgdGhlIGRyaXZlciB1
c2VzIGEgc21hbGxlciBrZXksIHRoZSBoYXJkd2FyZSBwcm9kdWNlcw0KPiA+ID4gPiBpbmNvbnNp
c3RlbnQgaGFzaA0KPiA+ID4gdmFsdWVzIGZvciBmb3J3YXJkIHZzIHJldmVyc2UgZmxvd3MuDQo+
ID4gPiA+IEJlY2F1c2Ugb2YgdGhpcyBkZXZpY2UgcmVxdWlyZW1lbnQsIHdlIGNhbm5vdCBjYXAg
dGhlIGtleSB0bw0KPiA+ID4gPiBORVRERVZfUlNTX0tFWV9MRU4gd2hlbiB0aGUgZGV2aWNlIGFk
dmVydGlzZXMgYSBsYXJnZXINCj4gPiA+IHJzc19tYXhfa2V5X3NpemUuDQo+ID4gPg0KPiA+ID4g
V291bGQgeW91IG5vdCBzYXkgaXQncyBhIGJ1Z2d5IGRldmljZSB0aGVuPw0KPiA+IE5vLiBUaGUg
ZGV2aWNlIHdvcmtzIGNvcnJlY3RseSB3aGVuIGEgc21hbGxlciBrZXkgaXMgdXNlZC4gVGhlDQo+
ID4gbGltaXRhdGlvbiBvbmx5IGFmZmVjdHMgc3ltbWV0cmljIGJpZGlyZWN0aW9uYWwgaGFzaGlu
Zy4gRm9yIHRoZSBvdGhlciB1c2UNCj4gY2FzZXMgY2FwcGluZyB0aGUga2V5IHNpemUgaXMgZmlu
ZS4NCj4gDQo+IA0KPiB5ZXMgdGhlIGRldmljZSBzZWVtcyBidWdneSBpbiB0aGF0IGNvbmZpZ3Vy
YXRpb24sIGluIHRoYXQgaXQgaGFzIHRoaXMNCj4gcmVxdWlyZW1lbnQgd2hpY2ggZG9lcyBub3Qg
c2VlbSB0byBiZSBpbiB0aGUgc3BlYy4NCj4gDQo+IHNvIHRlbGwgbWUsIHdoYXQgaXMgdGhlIGFj
dHVhbCByc3NfbWF4X2tleV9zaXplIG9mIHRoYXQgZGV2aWNlPw0KPg0KV2UndmUgY29uZmlybWVk
IG91ciBkZXZpY2Ugd29ya3Mgd2l0aCBjbGFtcGluZyB0aGUga2V5IHNpemUuIE91ciBkZXZpY2Un
cyByc3NfbWF4X2tleV9zaXplIGlzIDQ4IGJ5dGVzLg0KV2Ugd2lsbCB1cGRhdGUgdGhlIHBhdGNo
IHRvIHVzZSBtaW4oZGV2aWNlIHJzc19tYXhfa2V5X3NpemUsIE5FVERFVl9SU1NfS0VZX0xFTikg
YW5kIGRyb3AgdGhlIGxvZ2ljDQp0aGF0IGRpc2FibGVzIFJTUyB3aGVuICJkZXZpY2UgcnNzX21h
eF9rZXlfc2l6ZSA+IE5FVERFVl9SU1NfS0VZX0xFTiIgLiBBbmQgYWxzbyBkcm9wIHRoZSBwYXRj
aDIuDQpXaWxsIHNlbmQgYSByZXZpc2VkIHBhdGNoIHNob3J0bHkuDQoNClRoYW5rcyENCj4gDQo+
IA0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiBNU1QNCj4gPg0KDQo=

