Return-Path: <stable+bounces-142804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED1AAF402
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 08:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCBE7BCFFB
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 06:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD8E220680;
	Thu,  8 May 2025 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TyzNJktZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nCflk/J0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AA21D3C7;
	Thu,  8 May 2025 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686669; cv=fail; b=NYqgU+0LC/XDbrOz6k9BzCd6StbMTpNZXAQfnZIKfmt+UxXkmVib0XX4Cy0WCiDr1h2C3noVyjA40w8WqUjvYUxVgQnpvXNGJqz3hOOIGYiV22dAgyReHl2qxSk/hOgvpICCE3C92p2wsQEAWIRpABHxMB2dZzvGkDy7sw9dsNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686669; c=relaxed/simple;
	bh=pqydxFYUPJeb5LaYDlQ4oeXBwfAKc9nAIOvg6vwBxtQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YJWrU6F6vTOqRn9/U1wiSd1TpOrazYeF1YUA3+oRExfq2x2Souwhz8RCqXuooTwX7d9X8VGmE1qcKTmpDOPm4ojfbYdNFLjgDphD7wAAtdXEWN5JLuZUiQu1a99A1bVxRjM9TSH1IN2ts3OKEtsRlZ7TPXCeafcJBxl1PS8Bang=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=TyzNJktZ; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=nCflk/J0; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547LUVTZ001921;
	Wed, 7 May 2025 23:44:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=jbLu3BeArrTknqywAWU/zAapvQB3cF3R8dnzmKfSW4U=; b=TyzNJktZxBUP
	DUNfDbugD6CItFG0MHVvQP723ee/hqRTgSey7NG7/781wmOVTxSQmlJFfpZiyHwN
	b4izNDMHEDQNGGmbQsIDLP47qmUNhNGSFXE6Jk3CfO4dczvxZFGxRqqt2ikMP/8e
	QJ/59Di+p3V2c0OMQXO+XozNLWDSVpNPuAb5SAS5aWXSmjLwlzRRbQyBs/WDh3oV
	P1keHfNfNvRLd1PL+jr7f0E7Fl1RdkwXC0FmESwfi4W9qOaQAoKHCU/Bf4iS9YVg
	BFdpJQuDnWyG1ti6NKAmD1euOBdiHTYvMERKhV7lBPXBbnszptNWzb8M9btJKwFc
	UIC3Ynz7rA==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011030.outbound.protection.outlook.com [40.93.13.30])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 46deqwwg4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 23:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCraXt83/orEEpjbmra3QQcl43g5VQ3m5N3C2ITaILoLaGy5QqA7ybP/hG1hCQFFjuz7PUIWUDScFzTG6SD6+X65zbKuorlcaj2CGLGXCsg/5FTZqvpvztveS00oAYjRmVyvkp1tiWUC+YsM6wasnZzx/x/BZjaiog/XK//yYWUuBqp8DVDvKdZE9rfQkD994v/Jz5MRZGeLabfwu5eBqnEWaCjSjSOdBkmjZNdP6yaEPa20Sr+rfC8y5iHH+03SVFs1M3EkkfXuaAOQRK2dsl88oSYl+o/yWjfQo/237lNC8CRk74Go8Z9G5nRdYLa/1mNtYtFBhLiKMDyneaES/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbLu3BeArrTknqywAWU/zAapvQB3cF3R8dnzmKfSW4U=;
 b=GOWFPFk4cXtvJRdcRC9CuFz1fQwVbcWhroeQkQeBxKs31a/sILrvgHoGeJSaQF97Nxm0oDn24ePQI16HvUf6P/kBnYUlHrnI9dI+Nv0tmRiXtQBBFa+Pc1SuRmr5N8S8jdxq6RedBXWGDpkxXDwzfUVUOleeuT+oPRdlc92Muz9jq9y7CR0WOAIsoDKilmJ66oXNf4IR0tij7B1vgtQPYDZXX+6lR1rG/gRmPSB7vGWLmrNcGaTG9lPeqlivP0SP3EXH+/uG+QZfvdWQ3spXCL3ma4ZfCRDx//uT8gPmKs89JN9Ga55CbzVswWhg4bHklmlhxPGf+9gDs6PZUm8tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbLu3BeArrTknqywAWU/zAapvQB3cF3R8dnzmKfSW4U=;
 b=nCflk/J0mpgZlTwjS/Ewv6odXAK9sgTbT0hoCX6f/dTI6ZDdsO3ZpFiG5OJcB2YWHMOwNLFktQDLy9/tMlaBeLWtTq0QwdiPihr8v8RXM2NIqGnuPle66DpHjH/kd6i/fLE7LIbxBi3zSfkg9fDufJpleSJIXzn4CNV7u4lcGNY=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DM6PR07MB6892.namprd07.prod.outlook.com (2603:10b6:5:1e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 06:44:20 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 06:44:20 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: Fix issue with detecting command completion
 event
Thread-Topic: [PATCH] usb: cdnsp: Fix issue with detecting command completion
 event
Thread-Index: AQHbvxnya97aAZjaiECX74c59YsKxbPGwtgAgAGGIvA=
Date: Thu, 8 May 2025 06:44:20 +0000
Message-ID:
 <PH7PR07MB953895BB387C725E701DCC0ADD8BA@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250507063119.1914946-1-pawell@cadence.com>
 <PH7PR07MB953855E1D951721A143A83ADDD88A@PH7PR07MB9538.namprd07.prod.outlook.com>
In-Reply-To:
 <PH7PR07MB953855E1D951721A143A83ADDD88A@PH7PR07MB9538.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DM6PR07MB6892:EE_
x-ms-office365-filtering-correlation-id: aaa64de0-70bc-42d5-399a-08dd8dfbc2eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pYcyz3zb5GSp2ejHKpk/l3TKJX0zJMWjKldz/E/b4JeRqqnCMTTNB1DYDH34?=
 =?us-ascii?Q?2+DnGo2g9K5f1v29cCXiE/DK35Zz6Kj8ObDpXTi7Rmp1zIscCd8t6biOKof5?=
 =?us-ascii?Q?Lgw52qbGMKzkZeZVU7wgoc0Cke6G/kZ0zeKDxRxB5reb7o3en2dwR2PyoI+t?=
 =?us-ascii?Q?QPcrodjqOXoSuvD6+Vq3LVcFnC7OKEdRtt4Th8141k6dFqmoDJchTPbztfQv?=
 =?us-ascii?Q?yIv00f4mMInAJV1ox0aUsTPQTHAqInO2p6PB2OLE94LNYFsONBy83HslSWj5?=
 =?us-ascii?Q?vAgGubMqEqgXWQwe09DzpVPTTktxgvQvhLjjIhLQyo8NocAxMAkHB799At1Y?=
 =?us-ascii?Q?hq5nA8Uj/420u8dHY+4UzV9Tzvq9qg8XAcb0kMVz13ORjZgH9CmKCHVdGM2L?=
 =?us-ascii?Q?vNTOMqI99YZNUzqSpvWb+zHt3fWWkXnphV6ql90OPQHKixs5iSVcjdsm1lHM?=
 =?us-ascii?Q?uJQdy3oY67fGCMswyIuVGq61VBuKHlTLO2UobjFfJ8b04Y4tlYnwP4Bgzj8w?=
 =?us-ascii?Q?d87atcVhlenPkxnF1etig+3JYgwOgOIYE2kdCre+1POD6J5FL6lF/vvRNkPs?=
 =?us-ascii?Q?8PLA0/zy6a6/wE6juwCfmIUIhRoKr27fa+bbPW4M8ZD7ldremhHVvn3KnIFr?=
 =?us-ascii?Q?H1gSMis8ZiFi4jATwsjrdIX0DPIIFjBcw7rwPg3L2HNcH1019JeJvoECgsaS?=
 =?us-ascii?Q?0EAUS9l/nyeDCXrKakGfHEdU/W0XTf9/ACEyZQiihzgVOhxpMWnkzYAC8s9R?=
 =?us-ascii?Q?wUjrtqPREpjls7zfSbUoKJAfBxKCZOq6j9qZ2D0/U69rh2DfXOP1R2LjFpCW?=
 =?us-ascii?Q?xy9o/x7eT707jkrf+tdfvCsggCGpe2IbNKjze+wUZCdQ7jDIRZk4Fpji39CH?=
 =?us-ascii?Q?N/Ayytxs4LkUb8V3UM5f47skBPIE8tsDv0q7kWeuxijRFjITFA1IP4wa7VhG?=
 =?us-ascii?Q?QRlTjfJmeO5FAv7H1Kez+/EETTBG3gaYBncn8w0iuAzj3rbx2S3uWMSRfUTF?=
 =?us-ascii?Q?EAImM2d66NtzXM32IX7QAmkkuIFigcmGgXDTgEAMVmhVGe1pGjOwjyB89s4k?=
 =?us-ascii?Q?d5ND8UNQu13zkybn0QJM2xk93TS0psSHiMjLKXXWBgeq1N5Tgu9GFqHHdPse?=
 =?us-ascii?Q?UnMbeFqiSo+jpu42aWuTjNIC9a9Gw+dWUnrbW3REQbVYapWiQLNRq9KgELaN?=
 =?us-ascii?Q?cYWBTbIekvswnW5xI/z4bmL3MCmgf2qvD/H7lMJPsfMpoa1bnvRZLTz8XWG6?=
 =?us-ascii?Q?z1k6c7FCKR28VS7wZpqry9mBG1vfdvA7NK1FCaa43YRX8y/sIFSy9JH94vhu?=
 =?us-ascii?Q?aSMUyee5WL6Ce54JPdh1Nhv8gBh+jT1nySxcA/DevKyTNeF90c0H96CG4kAD?=
 =?us-ascii?Q?TLhvwR3UYOstLWXwA1qYgB3TE7t+BJZYTxpdRmQCoueoVtJycV9R+vt1NypQ?=
 =?us-ascii?Q?tZPnoWXsYxp46ad5QeyAjmoL7m41Hx68y+M+OKVHkrCCp7qGTHXq85O7p0I8?=
 =?us-ascii?Q?tRVj/v2mZZIitpk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mG//tPxUDrCXsUxSQ4fH1tMvw/Ee1zzvgaw70WVaw6BVAtiFcrWlmCbUjt3/?=
 =?us-ascii?Q?gdf/E/43wwYF1PSMxNqyWYZW8bN4ia7iPcmIhd+zeAENEIdZkHNEJy823nMO?=
 =?us-ascii?Q?LkYINryt0/eCtWtWNRV189qmzg4nOnmBcixOect12ZXUb3rWVZW/sHgK5Rqh?=
 =?us-ascii?Q?Q5YOZYh/Gcv72lCW2Dm6YyXk14HNR1BijB0TMvcdd7a/NAFycXCizE4DpxPT?=
 =?us-ascii?Q?LqawLiOooEOUehQxIsrm3Yho6Tr6M82RUZKfA4SMIrRDiZ/vQRcv79eytmvh?=
 =?us-ascii?Q?MAu8DmHk/U98fLTICdndxvuz838b1O0tgP0r29tC695RosktBAYz/Uv9FMz9?=
 =?us-ascii?Q?sEhbsYb/vqqzsOaJzDKPd8u52bmRAALob+ccqDbvq+nP+pkxhKT/gud48hKB?=
 =?us-ascii?Q?ACV+3y4yVGFV8GLJLsLlb7qK4lAZC2bZB3v2BpPCRXewbhaWxwLuNvg1ynk1?=
 =?us-ascii?Q?BGrL0XeTydn4T/nFKCk5Xp7P8BIYXf1rE8TitUwCMw1tTgVSBXPmx9g/iG2U?=
 =?us-ascii?Q?q373r1f7dNqgSRDAU7gcl8Wv2kC5SfhwuYr6sLMXy0McaGl/GxkynACWjz50?=
 =?us-ascii?Q?hXEjEEeyDINkV6q0hhnbeAd7USrpxo35z5W3FaVzChrZRjcq2LBfB1CWKRuc?=
 =?us-ascii?Q?d/ABXe5sI/vGaGAOfaI1urwsp/Vve2qGDGl1vgbK68+gne+Hv6wgRU2+o5Y0?=
 =?us-ascii?Q?ifa9TqZuW3g0ZcgKPuAfNM01GV70y6iqtBV1upRvQsBUcasbsmbkmoSyf9M3?=
 =?us-ascii?Q?rGzKQ4LVODJ4RCQegfUwLweneFKBnqiEhusEfXk9RqqVqAmTqGyD7sp80u1T?=
 =?us-ascii?Q?/ZyZGXyWv1zMVRRRuhdeMR0iM0ohBD1nbEmzYqPeMdYuUyTYZPBSt96ALXF7?=
 =?us-ascii?Q?QtaDfYwMSBH6Jhn6KXs5DhpTrNSThDjiffTQHlqy+8TT0k2wbRhG1FgD2bTY?=
 =?us-ascii?Q?zhseaZHemOy0bXDXhjjz0LVgZjd/5IZNbwv+SJymu2Bv7BOzIUcks4KAEdhc?=
 =?us-ascii?Q?q/Wfa6cQpy+T0dkMudXtJKbVSsoKSfW6lGBQAktJJX02UuvyLuP48ebnNtsv?=
 =?us-ascii?Q?RacANvh1hT6bKE+YjOqVLnpLytMgFee9QlkuPtrELybbYgp5c7TJuaTmCCL5?=
 =?us-ascii?Q?RryzSPb3ixRlrKLOeHLELiBb5cK+CdQpTbibxdL2DRDIIxJ7sn906F+BW+Th?=
 =?us-ascii?Q?Y4jGNQah9aOPTchCzbTPNH3aVgJd05DtuUBZy1E7sEjJPoeD1k7/nI/O3TjT?=
 =?us-ascii?Q?ws29nN1B1Ui7Kf+NhpbMPW/CXNNhcoFSkYCgo0JRq5zdKN9etHEwE3CQruIT?=
 =?us-ascii?Q?a9z5EMXZ1/qUrO07Cqm5/Gc1mtHe4ihWSBuqub5nVHokEcDcsarr36VjRExR?=
 =?us-ascii?Q?H/kUUKxPgfMlZhsgk9aSzBis6XjjVmuwAEIJGtTRoBglFhKHfWM6Zr1+gA2P?=
 =?us-ascii?Q?QVMpgWthpDTsDIxeWKsB7e+2uROh91NFU4TWqLdLhLaE7o9wNyc1kWvNMZTR?=
 =?us-ascii?Q?rIYg5mLqEBC/cl306oYUxVj6OfKOyM4lxSYkl6ceoCSuCSzG1+tq/21iMOWj?=
 =?us-ascii?Q?l2LAMWvDsv3PhSsQ/OvbjtmolvuKhc5TSEXHyQux?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa64de0-70bc-42d5-399a-08dd8dfbc2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 06:44:20.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YBKwF5tg2CE7Ob1lj4JBkxM2IDoIJB5la3YUMFs+b9C9C2tw2TI9mqQzZOIvcfn7IePU3ZwhCoXK0BqHMX9KzCDZiLGJNkU4s/3KNZfbb5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6892
X-Authority-Analysis: v=2.4 cv=NL7V+16g c=1 sm=1 tr=0 ts=681c52c6 cx=c_pps a=0OKJ/AtwRMkc9g4riGvs8g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=dt9VzEwgFbYA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=OL2gQ9fao7jpvXb_F8wA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: WVfDFhgPg2qvLbNeULEL8vNPWfN1XEzW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDA1NiBTYWx0ZWRfXxK32etapGjt3 b8NwtAFptijfa5Jlj8tVhpWL6U+m5LUFjz+07ovScSyxc42NIxImhH5sIhPH11wQeov/Zf8d3j8 IdnjnxscKyTloF7c4wxmCibiVt642Nyx/xhW8EcVeXBncL/MnBf11zlYecsjt7LBbfc3aZtRtU4
 Y2KXuUcVMKeQVIhQgvqE/k9/sSu6rD6MEnVvJkW0R7MTwuiI2LSuSUL2xKQzjoXRR/T1Wh+XToo hI/4Z5cYmvhJ19Wr9qWiM7W07oX+R9iSHqnzA7YCIcYK2mB625G/U1lfhhzuSR/yPsfWR2Rb8KQ UZJ6yP4KzllnVB2XCZuB3jxTi6s5zxzIVlCHDPlf1n/EsdHNn+y+yXJWkd5yVfqMOBYgTgrNpSe
 2DJGoIaHcKH/lmMM1vfaoDWBv3muPW/7RvwseDkaqBEKoN6nPmjjPwTfiHNpYcEdZ7FZ2Pep
X-Proofpoint-GUID: WVfDFhgPg2qvLbNeULEL8vNPWfN1XEzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_02,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505080056

>In some cases, there is a small-time gap in which CMD_RING_BUSY can be
>cleared by controller but adding command completion event to event ring wi=
ll
>be delayed. As the result driver will return error code.
>This behavior has been detected on usbtest driver (test 9) with configurat=
ion
>including ep1in/ep1out bulk and ep2in/ep2out isoc endpoint.
>Probably this gap occurred because controller was busy with adding some
>other events to event ring.
>The CMD_RING_BUSY is cleared to '0' when the Command Descriptor has
>been executed and not when command completion event has been added to
>event ring.
>
>To fix this issue for this test the small delay is sufficient less than 10=
us) but to
>make sure the problem doesn't happen again in the future the patch
>introduce 3 retries to check with delay about 100us before returning error
>code
>
>Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP
>DRD Driver")
>cc: stable@vger.kernel.org
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>---
> drivers/usb/cdns3/cdnsp-gadget.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-
>gadget.c
>index f773518185c9..0eb11b5dd9d3 100644
>--- a/drivers/usb/cdns3/cdnsp-gadget.c
>+++ b/drivers/usb/cdns3/cdnsp-gadget.c
>@@ -547,6 +547,7 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device
>*pdev)
> 	dma_addr_t cmd_deq_dma;
> 	union cdnsp_trb *event;
> 	u32 cycle_state;
>+	u32 retry =3D 3;
> 	int ret, val;
> 	u64 cmd_dma;
> 	u32  flags;
>@@ -578,8 +579,23 @@ int cdnsp_wait_for_cmd_compl(struct cdnsp_device
>*pdev)
> 		flags =3D le32_to_cpu(event->event_cmd.flags);
>
> 		/* Check the owner of the TRB. */
>-		if ((flags & TRB_CYCLE) !=3D cycle_state)
>+		if ((flags & TRB_CYCLE) !=3D cycle_state) {
>+			/*
>+			 *Give some extra time to get chance controller
>+			 * to finish command before returning error code.
>+			 * Checking CMD_RING_BUSY is not sufficient because
>+			 * this bit is cleared to '0' when the Command
>+			 * Descriptor has been executed by controller
>+			 * and not when command completion event has
>+			 * be added to event ring.
>+			 */
>+			if (retry--) {
>+				usleep_range(90, 100);

I was guided by the warning from checkpatch.pl script and changed udelay to=
 usleep_range.
It was wrong. In this place must be used udelay.=20
I will give some time linux community for commenting  and  I will send it a=
gain in a few days.

Regards,
Pawel

>+				continue;
>+			}
>+
> 			return -EINVAL;
>+		}
>
> 		cmd_dma =3D le64_to_cpu(event->event_cmd.cmd_trb);
>
>--
>2.43.0


