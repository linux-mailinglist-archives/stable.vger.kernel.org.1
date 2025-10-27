Return-Path: <stable+bounces-190009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CDC0EBE7
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 01EF04F585F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74D2D0298;
	Mon, 27 Oct 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lgMbyAtx"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B929346F;
	Mon, 27 Oct 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576941; cv=fail; b=WSh8Z9FxrJexjwQhHB8p4JGvApxYRsN/FZ31MnLSZw3HMeQ+Octfu2Er3W2dVk3LyHMt1zgVjlhFGOPcGWtbIzkdYkION2pqoCeXqgPreshJXueKUGH6wZk8WBi8tWO7kWofOvquB5gL9v7mS3F8XYyJNC4KIgh7546d7oimB0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576941; c=relaxed/simple;
	bh=JdUlRol5lPRTKTakFfZbMAB4g4+umjSJEjy4UbMGfoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXuPnDRxzSrDl+dunOXVTqpRG2Fi7YoBpeagjbfs46LxzT2syiByvmQ9b7csk3/Fx3PM+4pcC8LFdvbfHO8Dflt5BDpjMuYsJ8yI04sVb5Vln502FWSkmShj3LEnwH5pXqq+MCJdQE57AM4MVW/F4ZqC7pjY5lpaCxGl3h6ey5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lgMbyAtx; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gV6XGMoVTc0NkaiS/hAtjnV3DIAV5cebv/2n8YnUDCtu5X/zBWHighE70PR6rw15BHEuzQe5uMi3NjHe6W1lEq/YJgvnNWcbFlaFWxrzvJI0Bs91DEE1IrSc2cZ0uI9xlxu0hM2ftT76qjBoiXjIHRm4YbExldWCfvl17XW5OpGNHaU3qwZoLsEy9sHs7Hj3wmGj3HMpcuqZaSz8FzJlzAHMXF1jtFLX8JQLrQcp58Rt5y7uMGBKn76KbJe6svyxcgItZObM30JTCyh9L2c8etxLX71PRmVHelTF7rLRhp4YNL2MFLxoLfJt3uHggg2QA59Yv5ElrSkCmuCndW3/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdUlRol5lPRTKTakFfZbMAB4g4+umjSJEjy4UbMGfoc=;
 b=oUhyJ3WPJSGMQF4SkAPUuJn8/RB4W9ICzxkb/jtGsvvIZAL6p5/OTR06JhOW1ysZmxSXdd1P86m/YjMAVrayBDH5At7KWgXymvGnSX90rXA6WJFdbqihJgPIjTDqZNoObiRPByJguDKMIQs+397Tw23LppwrClbZf0lkFgFfULX4OqmgfxmKuOBr33Pic9tm8Px2GqCOAKcZFVI2sMXhv0os2HeqoVzccfBPO3NjiZuybcoQGkdOOpEXORO75HU3gQQV+8VQHAy2JiUz8EK9Ws1mmx38nCMiH7TEaVqRs2yvKEZz/eV+XkkigtfE6GsgijFH/Cj0S4emxJBK6bE8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdUlRol5lPRTKTakFfZbMAB4g4+umjSJEjy4UbMGfoc=;
 b=lgMbyAtxsrwaZyYv9lPsXchc5UnF/FuKPUL8Pftjs23szZZTBIukKRIrM4PSWkI4Xo4TQWDUhCV3RolbjeJpYPvzp+PyecAE3Eu9q7HslenejVIMaMdoh40XLyxrUniQsSUvbPbDLonk0GKt5doalLEjMHQsZP6WfoiTICuyN7oCOF6SgMq38RKp+aFOK3ru+uc25+o6nRbEq80sMVsH054H6ZKvJsYca2UcTCdc2t2eO5lA/T64fKpSYL4hgH1q5LFuPRmXOdFdYOpHXNORYogr3F31NzRDutVJysSb/FFRQD/qpSCAVSIl8LUF+7zJ2wG/mguofuqCGG5siuDnbA==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 14:55:35 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 14:55:35 +0000
From: Parav Pandit <parav@nvidia.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?=
	<eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Minggang(Gavin) Li"
	<gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v5] virtio-net: fix received length check in big
 packets
Thread-Topic: [PATCH net v5] virtio-net: fix received length check in big
 packets
Thread-Index: AQHcRPgJwKk3Q45MeUGTanh0wr8u4LTSclGggAOldQCAAAGUoA==
Date: Mon, 27 Oct 2025 14:55:35 +0000
Message-ID:
 <CY8PR12MB7195F589628BD6617A77F81CDCFCA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <8e2b6a66-787b-4a03-aa74-a00430b85236@gmail.com>
In-Reply-To: <8e2b6a66-787b-4a03-aa74-a00430b85236@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|SJ0PR12MB5611:EE_
x-ms-office365-filtering-correlation-id: 00035c15-5c4d-4bbb-81e1-08de1568e249
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFM5RHJ4WkRtK2RjSS8ybkxOYUtibEl3N0NLaTZIYXFUWklGKzBhV1FLZ2gz?=
 =?utf-8?B?ODgxZ0FrZ2x3Q0hnSnd4OXduZnlsQ3JEdXJraGk1L3A3d25UQSt5dDZjR09a?=
 =?utf-8?B?d2FabjErSjRiSkdUVDF6Zm0yOVU3a3FYR0svSURmU090RjJydGpObTB5bmhX?=
 =?utf-8?B?dUFSRTFpS2NhaVJWSDE1THhUR0JNdy9HUjRYQ1FzZ1ZCVko3M0VJc2NwRmds?=
 =?utf-8?B?UmtSeDRTUDQ0dzhXMEw1bXZlaThhRUdKUjhQSlRvUkJLU3o0K09YZTZZS0Ix?=
 =?utf-8?B?a0hqVHJPdW5wK3E2SlZyU0t1MGhuNXJoVUdTaklXYUlpNGhWVjM5VkVKVUlE?=
 =?utf-8?B?bXA4dTJucTMvelQ0a1ZiNGZvb29VODJjZjZ1ZEEyZlgrYjd5S0pBQjZDMmlC?=
 =?utf-8?B?akZxVExpT3RWdnRpTTF1ODdCdVl5WHYvL21WbmdwcERmWXZmS0t0eHM3Sm1B?=
 =?utf-8?B?Y3dXMEhxcmxDRFdyRmg2ckt4R3puRkE3QUduM25ZbjdORWhuMy9EaisvZ1Mw?=
 =?utf-8?B?QTdqVWFpWWl5R3dhSWwzT3JrVTJxR2FhUW9lYlF2R3U1UTA4d3JPN2RSU21n?=
 =?utf-8?B?T3lOZnhrTEJMK1FqTUttWGhjNllSRFVmTTE1SEcrSTFDdGtmU2ZXQVl1bEdt?=
 =?utf-8?B?Y0NDcUwvcXE4NERqQlZUZnd1cm5ZWEszMkYzNnNHM281M3NrczlqdHYvZStI?=
 =?utf-8?B?Wm45b242cWZpTjROaXovQ0RsSmRkNUo2R2R0YnR0OWpmQ01TcXdpQVpDcXJW?=
 =?utf-8?B?NTUrUXRNd0lCR0RrTElNaU9JZGVkNHUvSXJKazhjZUd2UkwvT21VNXpxS1o2?=
 =?utf-8?B?WWJqL0QwNTFIb29ieUZUbzFHTmg5VFVYMUliVXZlWmt2NmpWNE1ZNWt4V1dE?=
 =?utf-8?B?UVlYT0ZnTE5IRm1lVmRrbzdLRjk3MUpkc2x2TXVKZzNEd0RmU1Nkd2VoWVhD?=
 =?utf-8?B?REU2Y1Y5V3VKK0hSNU9JSkZHVWlXQUp3V3JQY1NuRnRyRVlYMjZhdm02NnFs?=
 =?utf-8?B?Qlo5VVgyU3ZuekZYeFBXUEJRa3NZV0xEMnFvWmhXcnVlNXZueTN1Q1RjQnhm?=
 =?utf-8?B?T3lHQW1XVEtuNnIrK1FrbE5uMHpwME1nNVZDM0FmSm9pT1VQNkJLZFhoZGJ6?=
 =?utf-8?B?MXpzbVU3d1BVN25oNWZyMWtScjRRZDJYSGxtWUhrZ09IYzk1cXhHbnNDQXRs?=
 =?utf-8?B?SEtTaUtxM3lLR0dWZlh4VEdKOHJLWEVnNWZNTlRzM0U0a0hYRHpWNzBIU09T?=
 =?utf-8?B?RkowOW5maDY5dUZoT2lKSW1lbFJpK1ZxNFZ5bjd0a2xna2tPdzFBdWphNVNj?=
 =?utf-8?B?dEFIWC9xdXlnK1JTNVBIejNhaFlYNDFLcXJuSXczNXQ4dmNNQnUvTmNBekxV?=
 =?utf-8?B?SUpub2EvUUFSdjk0cXRhc0N1aGY1RU1YZzB3YmxjNFo3K2NBaVJUR3h2cXho?=
 =?utf-8?B?TTQyRkdqbUQyeU84Nkp2RVRqUlhSOGl5L2tMRDFFMmNzOEIwOUt1dTRYWGdD?=
 =?utf-8?B?cTh0d2hQbDgzODE3ZC8zMUxWNVFkN2U3VXlBUlRHT0Nkbkowd3h6ZERnTjB6?=
 =?utf-8?B?czVWNWtsblMwNkc0aWhXQURRdVh1SVkvL1JkVFZ4QnNOQzViZ2N3Z2JqcStN?=
 =?utf-8?B?VHJOd1hHZ0thSk40dzNDdXlKN3cyQk1pOElNQ2pCVWsyRnBySDUrL0oyS0dJ?=
 =?utf-8?B?TEE3NkltdDRycjcrbnJSbE1rVlAvN2lyRTZDV2U1Rkl4UGl2MWhFejJ2dHBj?=
 =?utf-8?B?cHZObWtIUk5OMk9NMjdXREI4VUl3T1FiZDBob0tieW4yM0ZnRmI1alptdUZF?=
 =?utf-8?B?dTY0MGxKbW43VERuM0E1a1hsMk81NGtzTkhVcXRQVUljaUpXbDUyWVE5b1hy?=
 =?utf-8?B?d2dCUTJKU1JnR0lRREgwOHIwK04yRFlTQkt6MkNlbDBpcHJQUzh4UmREcktX?=
 =?utf-8?B?cmpndUVxeDdOTWdPbVFkSFVUOGRvODk4bkJnaDFkZTZvNmpyaldoaGJLaHJL?=
 =?utf-8?B?ZThEdE1OR0JwbTVGK3lrd0xrcVFncTVQWjE0UDlrSHU0UUJGM3kxejM1dlha?=
 =?utf-8?Q?ZfEh8G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlFLaERqUnBTRlNHaDhRbXdhMGEzNFdWYkJlYkNjOWM4U1VQMGR5UGMyUmZP?=
 =?utf-8?B?RlJxSUN0THJzRjkyalJjbVQ4bUpMMFJwQngybXNlUm5RMmZhMENaOXBLTlhM?=
 =?utf-8?B?bCt5eUMvYWZJT2VKTnpIOEZEb1ljVHVwRzc4Qy80MWp6endTZ0ViaFFlbEJt?=
 =?utf-8?B?REV3L1lDVFMrUHp1UXE1b3lmdXNyaEQrT29lVTBBVjhYcnVKT21YZWtDd1hZ?=
 =?utf-8?B?TmlPTFZ4UUx6QXRkc2dudGRaNkVLVXFyeGFGRm1NbXJsNlNEZ09VSnpCRUVa?=
 =?utf-8?B?UEVhaURwSmlBZlAzY21panhPRFF0cVEwNnZvYXpQMkdIaGtMbFVoVGpCYkNt?=
 =?utf-8?B?cEU5U3l0RDZtUFBsMml6Tmc0cVVXSGlDcm5uYWJWajdkREQvV3lIcHJXZUFR?=
 =?utf-8?B?aTgxd1VvWjlrdkZOMDFhMlZ3MFFmaG04RFU0YTFuZ2VtVHJLZ1hTUk5SZHBD?=
 =?utf-8?B?SEtudWgranFVdnB5Si9uckpZNmd0azdwV1J4cjI4c1RCOEx5ZDFYeEhjSUFJ?=
 =?utf-8?B?M0E5NkVpMTRGTTRzaDE1b3J0VkZ2K3UvM09rTjdvbitzcGk3QzVVYTdUb1pa?=
 =?utf-8?B?c3dwQ2hDeElHeWMxR2FCMTlDc3JMSW11cDlzS04wT3NDaUI0anY2bnAxUTBv?=
 =?utf-8?B?MFVLTThJUHZkMTlvUUNzT1dUT2kyY0F3RU10U0QzQnRnNmZXUDlJSEVjSERu?=
 =?utf-8?B?bC9KVDBaemNLczZxTEQ1OHdtQzRoRnlEZ1VXSFFycktlSndVeTdoVVl1K3BF?=
 =?utf-8?B?YWFWYjFrUHozS3BlWmVQZG5TYThpc0hqMHVESys4UWxISVJNaVV0RHMrZUwv?=
 =?utf-8?B?UGROVHZqQ1R6ckMrZE1rV2t5dzRKRTFKTklhTHpVU3loS0F2MXZ6c3ltbXdW?=
 =?utf-8?B?QUM0NHovU1NJa0NRZ09YcTBRMDhKMUk0akFIS2xJanIzd2dNR1NsNDE0dEUw?=
 =?utf-8?B?ajVqVDcyM1FoOVAvSWk2SkFMWVdtZkEveUFnTUxCV2RQUGlCL21TZUFYVFNq?=
 =?utf-8?B?Ynd3QXkyWkFaY256cDhBS3pTbUhlay9POWlzaWx4MCtyUllKNDZsRTFHOFA0?=
 =?utf-8?B?dHlnZnFEWUMzcXU2WldMTEk1NGIyeXVhWFQxQUpOcnZpalNCdFVqUk96SjZo?=
 =?utf-8?B?MWtUeTdNbk5xWmRmaWNldWZKNlVxOSthcGhybUx2Y1l1cVRJWFZCMVFvSTFm?=
 =?utf-8?B?MVZjSUg5MTczL0tEQkFTNjRuUmQ1alovUUlYRUlzSElHRStJeS9WZUJPUXo3?=
 =?utf-8?B?N0NLbHZzWmIzM3ZMMEU3eDYzSUhpNklONUxHYlFscnFNMzBOOWUwSWJMOVp2?=
 =?utf-8?B?Q2owZnc0M210bzh0WlhVTklRQ1VmSFQxTDZqZHJPMHZlRXR4MGI5eVBJUm4y?=
 =?utf-8?B?MEFmaUlEQXY2OFVaM2pkeXk2NGZxcHpLSVE5dUhadHdPOC90SnJBNWdqU3Bt?=
 =?utf-8?B?TVdYQVNyVGdKOXpBaDRnd3VPd2w0NEdPdmZWRjIrMU9PR1lmd1d3WXp1Z0Ex?=
 =?utf-8?B?dWdsU3RmYk1ZZFVVTUs2QUc4Q0FkZ2pvVlpSZTF2Zit6NTM3SnVPZ3dNNEZp?=
 =?utf-8?B?cEZ6a1l6ZnVlekZKMmtBZmhBNnhFNFhJd0lnbUdlS2RtUFJ4TCtvcnp2RjIv?=
 =?utf-8?B?cUlycGY0UGFrMGRiWTFIeCtqQzNZU000SFN0aml2RjJnQmxWSTlGZWVrOTFn?=
 =?utf-8?B?Z2plZHZ5ZHZsdWRVUVpYWDJqRlRxSDczMm5ZdE5BQXhRMDdpTVVaajNUYWd2?=
 =?utf-8?B?WHVNVlI1bWpQRHdPb1dDMmczVDR3Z1dld2p2OVdyYk8xbUh1Y0VXb2d1ZXpM?=
 =?utf-8?B?YzRVY1FRdFhzYUZ0cVpDVnptbFY5aGlLMHowRkUvL29mYWoycytQQU11Ti9X?=
 =?utf-8?B?M3kzQlI5WS96UzVvVnNkZWFLNXFNS0NHa21iZllVWGh2SDc2RjhvRnBuZk1x?=
 =?utf-8?B?bFAxVTIvOW1GMUR1YngyWGlYdmN2TUwzaDZZNmdUVTZGYm05UDNsTWIrNzJt?=
 =?utf-8?B?WkI3UURHUWVTRWs0ZmxkazdKbnlCdTgzNmh6UTFNV1haYW45K0xuZG9yU25N?=
 =?utf-8?B?VmlQMVBkRnBpczlaTDJlRXJTRGE0bVR5WG5meEYyREM4dVJOTDhLTXZHZUx2?=
 =?utf-8?Q?8OJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00035c15-5c4d-4bbb-81e1-08de1568e249
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 14:55:35.0313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkrkW0nRobCR9epfzt/D9DL4jhJlra4MsxRj9ZpRXIdZBR2IazKavJlGdw2D+CEzQbFfPAeKqxzA1VXnKs4T+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611

DQo+IEZyb206IEJ1aSBRdWFuZyBNaW5oIDxtaW5ocXVhbmdidWk5OUBnbWFpbC5jb20+DQo+IFNl
bnQ6IDI3IE9jdG9iZXIgMjAyNSAwODoxOSBQTQ0KPiANCj4gT24gMTAvMjUvMjUgMTQ6MTEsIFBh
cmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gRnJvbTogQnVpIFF1YW5nIE1pbmggPG1pbmhxdWFuZ2J1
aTk5QGdtYWlsLmNvbT4NCj4gPj4gU2VudDogMjQgT2N0b2JlciAyMDI1IDA4OjM3IFBNDQo+ID4+
DQo+ID4+IFNpbmNlIGNvbW1pdCA0OTU5YWViYmE4YzAgKCJ2aXJ0aW8tbmV0OiB1c2UgbXR1IHNp
emUgYXMgYnVmZmVyIGxlbmd0aA0KPiA+PiBmb3IgYmlnIHBhY2tldHMiKSwgd2hlbiBndWVzdCBn
c28gaXMgb2ZmLCB0aGUgYWxsb2NhdGVkIHNpemUgZm9yIGJpZw0KPiA+PiBwYWNrZXRzIGlzIG5v
dCBNQVhfU0tCX0ZSQUdTICogUEFHRV9TSVpFIGFueW1vcmUgYnV0IGRlcGVuZHMgb24NCj4gPj4g
bmVnb3RpYXRlZCBNVFUuIFRoZSBudW1iZXIgb2YgYWxsb2NhdGVkIGZyYWdzIGZvciBiaWcgcGFj
a2V0cyBpcw0KPiA+PiBzdG9yZWQgaW4gdmktDQo+ID4+PiBiaWdfcGFja2V0c19udW1fc2tiZnJh
Z3MuDQo+ID4+IEJlY2F1c2UgdGhlIGhvc3QgYW5ub3VuY2VkIGJ1ZmZlciBsZW5ndGggY2FuIGJl
IG1hbGljaW91cyAoZS5nLiB0aGUNCj4gPj4gaG9zdCB2aG9zdF9uZXQgZHJpdmVyJ3MgZ2V0X3J4
X2J1ZnMgaXMgbW9kaWZpZWQgdG8gYW5ub3VuY2UgaW5jb3JyZWN0DQo+ID4+IGxlbmd0aCksIHdl
IG5lZWQgYSBjaGVjayBpbiB2aXJ0aW9fbmV0IHJlY2VpdmUgcGF0aC4gQ3VycmVudGx5LCB0aGUN
Cj4gPj4gY2hlY2sgaXMgbm90IGFkYXB0ZWQgdG8gdGhlIG5ldyBjaGFuZ2Ugd2hpY2ggY2FuIGxl
YWQgdG8gTlVMTCBwYWdlDQo+ID4+IHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gdGhlIGJlbG93IHdo
aWxlIGxvb3Agd2hlbiByZWNlaXZpbmcgbGVuZ3RoIHRoYXQgaXMNCj4gbGFyZ2VyIHRoYW4gdGhl
IGFsbG9jYXRlZCBvbmUuDQo+ID4+DQo+ID4gVGhpcyBsb29rcyB3cm9uZy4NCj4gPiBBIGRldmlj
ZSBETUFlZCBOIGJ5dGVzLCBhbmQgaXQgcmVwb3J0cyBOICsgTSBieXRlcyBpbiB0aGUgY29tcGxl
dGlvbj8NCj4gPiBTdWNoIGRldmljZXMgc2hvdWxkIGJlIGZpeGVkLg0KPiA+DQo+ID4gSWYgZHJp
dmVyIGFsbG9jYXRlZCBYIGJ5dGVzLCBhbmQgZGV2aWNlIGNvcGllZCBYICsgWSBieXRlcyBvbiBy
ZWNlaXZlIHBhY2tldCwgaXQNCj4gd2lsbCBjcmFzaCB0aGUgZHJpdmVyIGhvc3QgYW55d2F5Lg0K
PiA+DQo+ID4gVGhlIGZpeGVzIHRhZyBpbiB0aGlzIHBhdGNoIGlzIGluY29ycmVjdCBiZWNhdXNl
IHRoaXMgaXMgbm90IGEgZHJpdmVyIGJ1Zy4NCj4gPiBJdCBpcyBqdXN0IGFkZGluZyByZXNpbGll
bmN5IGluIGRyaXZlciBmb3IgYnJva2VuIGRldmljZS4gU28gZHJpdmVyIGNhbm5vdCBoYXZlDQo+
IGZpeGVzIHRhZyBoZXJlLg0KPiANCj4gWWVzLCBJIGFncmVlIHRoYXQgdGhlIGNoZWNrIGlzIGEg
cHJvdGVjdGlvbiBhZ2FpbnN0IGJyb2tlbiBkZXZpY2UuDQo+IA0KPiBUaGUgY2hlY2sgaXMgYWxy
ZWFkeSB0aGVyZSBiZWZvcmUgdGhpcyBjb21taXQsIGJ1dCBpdCBpcyBub3QgY29ycmVjdCBzaW5j
ZSB0aGUNCj4gY2hhbmdlcyBpbiBjb21taXQgNDk1OWFlYmJhOGMwICgidmlydGlvLW5ldDogdXNl
IG10dSBzaXplIGFzIGJ1ZmZlciBsZW5ndGgNCj4gZm9yIGJpZyBwYWNrZXRzIikuIFNvIHRoaXMg
cGF0Y2ggZml4ZXMgdGhlIGNoZWNrIGNvcnJlc3BvbmRpbmcgdG8gdGhlIG5ldw0KPiBjaGFuZ2Uu
IEkgdGhpbmsgdGhpcyBpcyBhIHZhbGlkIHVzZSBvZiBGaXhlcyB0YWcuDQoNCkkgYW0gbWlzc2lu
ZyBzb21ldGhpbmcuDQpJZiB5b3UgZG9u4oCZdCBoYXZlIHRoZSBicm9rZW4gZGV2aWNlLCB3aGF0
IHBhcnQgaWYgd3JvbmcgaW4gdGhlIHBhdGNoIHdoaWNoIG5lZWRzIGZpeGVzIHRhZz8NCg==

