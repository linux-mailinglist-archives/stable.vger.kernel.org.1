Return-Path: <stable+bounces-73149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71796D111
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3B17B22963
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA75194138;
	Thu,  5 Sep 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JsNVlbxg";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ev192y27"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17F193070;
	Thu,  5 Sep 2024 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523138; cv=fail; b=UZGZVQ9zRC5Rr4oO7DilsIHM2PUj7t6p4Bw513Sr34UUUhkOxZ/9e6t0wNquLufw+BkA38J/YRumHirYFUHl6U7UMYEoeRfQHIuyL14Yrw5x65j92PbgACzDeK5BhEaxiAxcdNrVvZ1Lrl4yeMEkJYNTDs2u046zzRDvKUS7B1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523138; c=relaxed/simple;
	bh=PcqrmKbu0DUNH3A+QKwO8dc2ydopc1rTjA5D1CfZ+k0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tFOgMIkSh87+m0EMfm+UHamy3GZJAW26/UFvE3sym8lDDlNzXEqiOquBxRNUwb334M1wDPsbeQOmnyU8+EooyeE85Xnw6zwK+VQENU4HOZSJ8YlXAfGMN2YaOeFi8xn34X2KgpCR67MiTk8Hk61RA1nRWeeDuUg9npJG1Hm9GUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=JsNVlbxg; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=ev192y27; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484LtcEq005333;
	Thu, 5 Sep 2024 00:03:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=OMl7bGZOIQhrWGDNvwDF1W+AqPyJQTeLY0wX+xCW1po=; b=JsNVlbxgkUbh
	OpLO6cI6gyvh2xWXfVykQZVwkD2CE0h2ErhjW376BniJx9LFkoguOYI9VePwbLJy
	Y9oc5JMzCx62O+eeTdt8St4qRC6832T2vUpTqjkkh9lOQVBq9A6pLcDkGntSAmSV
	D1uH4YI59NXeZ2MWF6qzY5tJYhSUwccdrMz5Y7WAH1AczWONWuwndATNguNl40sw
	inKMnJBxVwHqEw6Vvf1iQWDwUUJWmK1B+bntuRKsfhUKWriTL3ber7lDNdu7Ak2S
	Z6eo2mKDnekHJsSMX+2FB9pzZDHiMWFm287mkctsEljSYJfKpEy5Auu9mxGP9DCY
	3MInJlqKdQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010004.outbound.protection.outlook.com [40.93.12.4])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 41byqtgunn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 00:03:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVitRc4UV9sT3Y48Y3Ut6Yp4JAWZc/Oq77HWNdGQ6g9Gj1nfKQU8+lELzC3A7HPGJ3JbVkIYWmYfKyg4SCStR6a4aR5J5Y87hDuk0Kx7baPB1rFdSjRlWSP/iiTj6iM7ILp+tRRKdUl2k0vuh9e5R4rM8ahOeYNXo23hs4NxkK6MoZvoJlb+LngXG8hn3kX4ZQQz4riMTiAkzmlqiaXJoNLaZXF0i77dSdwUSDNFlMbx6g/f3uXXHI6rmQmDrkx17hLX6eQXzkjrXAY5N2sHH4H66BCRNvdomS+3toxS5TfBMC1buPc6W88KtpWTCYqRlPu3u0KZq3AngYDy/fJtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMl7bGZOIQhrWGDNvwDF1W+AqPyJQTeLY0wX+xCW1po=;
 b=uBs7syT/bDxL4Q6g7jCKSfLJU9f4ILwLS7m6gljlbR3CqbnH1KYg5rPXX6fi821LaOOg32WADCHXVk7I8VQCKy+3H4BPARqdNzHkTUBJgxqlmNcxcTWhPZM3VQsvApwJKDnpW8jLlSzmqso+nc7M/5CpKK9UFwGEcg4XM9OMsKStuvpxs/bJ4x7vnfJ7tMQTgmFxGu9NL4PrmrtDhqw15/iwS4o+HlhsRPY1IIttjzn93TkpQGlu8xu/Mtmr15XUmQKOnRHwOTONjTGnP8xrYK9Fu9XTlq2K67B1PEFzesVctCUbUcus58MhJ8TX8yjN4z0KYvZ4YOdvg7P5X+5uiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMl7bGZOIQhrWGDNvwDF1W+AqPyJQTeLY0wX+xCW1po=;
 b=ev192y27sHhL5pTZK8sdpKJj1KIZm8DTU9GAQMG5UQbdIpC62j8uzFCNAOiYywVaaO+MidmslkvDOyXWZ9yOusPZ0eoTu+sak0iNCx6/nBCU2gRrx1qKKvhRiQeNvZCa2iuyQy2u7a3WN4OD+g2azYKZjOaxBjesVPzxzF5zevw=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BL0PR07MB8210.namprd07.prod.outlook.com (2603:10b6:208:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 07:03:28 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:03:28 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3] usb: xhci: fix loss of data on Cadence xHC
Thread-Topic: [PATCH v3] usb: xhci: fix loss of data on Cadence xHC
Thread-Index: AQHa/2G1gUFHsnwWjk2GJAFNv3diAg==
Date: Thu, 5 Sep 2024 07:03:28 +0000
Message-ID:
 <PH7PR07MB95386A40146E3EC64086F409DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240905065716.305332-1-pawell@cadence.com>
In-Reply-To: <20240905065716.305332-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWYyN2RjMmQwLTZiNTQtMTFlZi1hOGI1LTYwYTVlMjViOTZhM1xhbWUtdGVzdFxmMjdkYzJkMi02YjU0LTExZWYtYThiNS02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9Ijg0NzIiIHQ9IjEzMzY5OTkzNDA3MTY4NDI0NCIgaD0ieHEzVUUzVEVJNkY1K1c2dk5FTGdQLzNoTkhBPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BL0PR07MB8210:EE_
x-ms-office365-filtering-correlation-id: d832f8b3-53c4-469c-6a98-08dccd78d84d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MT5yAzgIAFpqHa6fN99P7ZsjwHA6x+QchodFvgvQZhpd/gvU9ckE8wFXFwcy?=
 =?us-ascii?Q?7m3oD+9lQfSewTPC9a24AMUuCGOMWYVFgWf7mzzwQZYxeViIDvuz4d0ZND33?=
 =?us-ascii?Q?wCSpGMlTtz2hiw5GFvXm8qUm2UCjd+OlKZIbn7VaEi6ZOu9j35TMR0c4vWyP?=
 =?us-ascii?Q?QO/9H7mTOvnOm3eshFcRLuD4bBqJ/UaXwyIPD3mybls3cIGjVMLd5P2D+KXo?=
 =?us-ascii?Q?WA1YAF4lWur/8HKxdDYdE80bxlQliqJ8LWiKhmefGPQKyjXOWTb9OEMZAYxN?=
 =?us-ascii?Q?oZMyWk/QpdEYsjdNbxOyr1SsyO3bxsXhixHAE2LA4TcctanbiDGQ6V/4dQvL?=
 =?us-ascii?Q?1B+k27C5YEBpaqGMbPJwJOUyKuTT9A6y63ZAlatclhVGtLtKwEnNgB6m9BII?=
 =?us-ascii?Q?w1f4zrPDLwr1jRsE6VAN+LgRrReSQIHy1xZt8QyDY8bZf3ap4pw/T3qi414r?=
 =?us-ascii?Q?fp65zxj7lVqk9eOQgjHObxpLBRyO/tJNmi9LQGM2kkj1I/M1NaxiKRYuzgBb?=
 =?us-ascii?Q?FmviSROhsZz7NI/TaCFjqN6zCGaNsebU55ryzg/2rn/pkgxpBcS/Mwu+JXbL?=
 =?us-ascii?Q?RYGKRkE5ABsx2I+QekU/zK3k3a4moON7YevzjfoCMuKc+CNAIgrjeg7/I0mA?=
 =?us-ascii?Q?qFuAVTzbihaC1bwjy02+Z6B142sYLFrHnaBJLPOfgM5mysXZd6f1ptfE5p4P?=
 =?us-ascii?Q?oarzhrsCfEK9lQJOGteJTEf9Z8kgfV2X+B5T/c0/fu22tgnuvhqqG9TIWwLu?=
 =?us-ascii?Q?i4fonrfRv2heithsyPtZbiwJfckMODKHXsdvm0AfHRJ5ULIvo/4lEUkcRkv3?=
 =?us-ascii?Q?bi4HTVJE2SiDoYeg4EKs5f9TdKgLdYvrMMBw0/AEEyVeJsa8Re/bYdKBecOE?=
 =?us-ascii?Q?NNfBhAadX6p4S96ch/rgJig+f9UKFAnijkW+Apm19h9poWrNGqnMLN/Nm6SZ?=
 =?us-ascii?Q?OdJnf3YTTF5MQad5hW0pV6iAiwgpc5zRfFwjQo6urzNJj8zPcrmVPabTgVt2?=
 =?us-ascii?Q?E11z7QmFWLE8RLb49SE+zvDOuioR6cN2IP8OhrHeOKp9cHwORUc7zTobKR0l?=
 =?us-ascii?Q?IUbTjFFJPYwuR5g/DNY3lvyW7G/qEIuFimVfoK5a1omF/6apPoHOlpc6adZq?=
 =?us-ascii?Q?khigmnnYfXHLJEK2D/vw+Ea0SMPce3lhoZKykv3UG3/AjgbHOWTMa1D4CEBC?=
 =?us-ascii?Q?bdAhD9njFueSnbWpG9AYA+9CQiR4ZAIIND8GLWQP/WINp5ubSK0yYCJRzTEa?=
 =?us-ascii?Q?w6a0XCnxOMg4apjSqSGo6LFhvynfjCF5zMdiy3OtvSpjMkZM8cZygHYMnpLh?=
 =?us-ascii?Q?3bS28x71dl6GescE4L5FENRoLhmPmLUJrGjgSOWJMY/yI9njHuuuHDZzoRP1?=
 =?us-ascii?Q?4T75yklHgiygo50etUoFl8fZoriMR87B52h56RmE7c2K5pbBeg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pEHZbtRf3lig+0s8adEoqohAzFph+l6Spib4hcPKIoDRjaZq/4uQZDd5QLY1?=
 =?us-ascii?Q?KSJ9OJ61aoxNdtgzPYSub+bfzg8N9GMLBq4k/D1Za8oG/9QL3n0BnXuYPk1B?=
 =?us-ascii?Q?FPvge9/bvqu+Bs30JO3KixEKeNoRYc8LuZXrwDuVHWIosjxThxxfUziDi5HI?=
 =?us-ascii?Q?Sp9GYRZESbv85IyML5+dUGmfWSVNBkn3UTXsvsPvjPTBGvDUMfUtmbZxKiie?=
 =?us-ascii?Q?TVa46X623/On8tZcYThmGOxQm3bwNKMlmswHiyBAaR4wM/FaDMhC6HhAc5um?=
 =?us-ascii?Q?KpTmajmDW5bewLUyVd28iZVBqIRQZfmPG/iLEfVjJ9y6d3pMXrwLhegln60R?=
 =?us-ascii?Q?eFvcH5erwopOo1eTbM1fqH5m40B8gD3cNplWSzvD3j/7H8IELYjiav9gdgPv?=
 =?us-ascii?Q?TQ8DLElJ1NB90M3IHYOoo2Gg5FqTVHQS1xgM1YKGZZ2yX27B+E/evEgls1nn?=
 =?us-ascii?Q?AVbHGX4NXZKTibWIuYoCZnLUXWRnHlKFWtXS0ilbzaGJ7/DEs3dj+RBATDYs?=
 =?us-ascii?Q?rbSJPgUBPhY+s9078T1eymg6/dNQTRsfnQ+QiYHIpbRJa77dcqftlVsPPTZX?=
 =?us-ascii?Q?9D95+gj2hqTQ6hSvugpCQLhmIumdalaiXg8gM5UtMbZFUbA2DvFGPYNXMHeH?=
 =?us-ascii?Q?F96ZTTtvaGki1IEhDfWTuTpO7lQWSLwo/9UYJ+8FCwU6a/1ohIraOgrKjaig?=
 =?us-ascii?Q?xQceoI7xKNjPBTCRLTZifZ20csm/DIdk5dBrskNnIPBrhOii0sd3hQ5z/ax1?=
 =?us-ascii?Q?kxDIuJbNgl1r+yFa3SLz8UiLnube2gnfqfsuv6RwfExTmHuGztkAO5D5mVfT?=
 =?us-ascii?Q?VN1UUfZ2tslj7SkWWTnxFJDFxe7mi0je90ds/oagI0NxiuMCVuhhe/mX+/+x?=
 =?us-ascii?Q?LY9iaHREFTaCkHQyHHLguKIkXTg6hrwT53B76EMU8ff2xiFkUTNx47T/K6yX?=
 =?us-ascii?Q?ciYUlY1+Jg0jx9otR81aZgMq9G42Q1rvOu9hednDwF84aeUiK017O3u1CYXZ?=
 =?us-ascii?Q?+QIAZg5MIgTc4QKJJlWoS9vX56dPhlJqfL+jMM76uhxxNBgW53y/GfAWnYNa?=
 =?us-ascii?Q?tZKvaEP62bFPnmosl86Y0pQp33iuCs/BfJ/xQ9emDlMyrFgaZ7DW4Km924rV?=
 =?us-ascii?Q?o7+i8z1k3udIx76gjUBOEyN+yKqu+GGdisWfegW67yt9DIISwDaBRsDTt9dg?=
 =?us-ascii?Q?A4lFW+N3K6SgBCh7fB/nmtWMtYKfG4jbWIh8PYlHaOaQfUUYMrpNl5sMMkp9?=
 =?us-ascii?Q?57vNrvYh65r+vjEs5nnMd7H6xx9psELbW5X+nwR/fKwayCXCfEImWQxoQ8Fe?=
 =?us-ascii?Q?ktOkKOgG3PpOAEsXl2lnSUJHBbqCNS6PVvzeLWR+W7g4CotzpxVyZ+SU7fCf?=
 =?us-ascii?Q?/VrLzTORS+OzeWNcPfOytGp7YgjpPFY9rByiNdxWKMoVAdhgqA1C4BU2uMOp?=
 =?us-ascii?Q?TaTkL00SENRRcIQhp7wMG6akZnJ12zFw4lZpVEmU0mM4V2ZDDV2x8GTpA9Mq?=
 =?us-ascii?Q?sKs0rnrhLT+oNJtW2ONLul409oUTqoct5tf5ORdq2PCqp8ty8O+Gk+QEnA58?=
 =?us-ascii?Q?a7vNMQgGGJS0CvZu8H2vWXGQAJTYC7VkSjU+MQiq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d832f8b3-53c4-469c-6a98-08dccd78d84d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 07:03:28.8417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXtddycfLXD7UKKtZPwnZat5KbFx3CUvbwt3IfY9fV2rKFEDlZzOs0fl0ngwGoZ+K48MX0BmZg2v6Z8SSjRXX9ky6umxHpcOA/OvAGhnO7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB8210
X-Proofpoint-GUID: fh02fGLYLvNC5OxkTmQZimVAu2_oyw-p
X-Proofpoint-ORIG-GUID: fh02fGLYLvNC5OxkTmQZimVAu2_oyw-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050050

Streams should flush their TRB cache, re-read TRBs, and start executing
TRBs from the beginning of the new dequeue pointer after a 'Set TR Dequeue
Pointer' command.

Cadence controllers may fail to start from the beginning of the dequeue
TRB as it doesn't clear the Opaque 'RsvdO' field of the stream context
during 'Set TR Dequeue' command. This stream context area is where xHC
stores information about the last partially executed TD when a stream
is stopped. xHC uses this information to resume the transfer where it left
mid TD, when the stream is restarted.

Patch fixes this by clearing out all RsvdO fields before initializing new
Stream transfer using a 'Set TR Dequeue Pointer' command.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>

---
Changelog:
v3:
- changed patch to patch Cadence specific

v2:
- removed restoring of EDTLA field=20

 drivers/usb/cdns3/host.c     |  4 +++-
 drivers/usb/host/xhci-pci.c  |  7 +++++++
 drivers/usb/host/xhci-ring.c | 14 ++++++++++++++
 drivers/usb/host/xhci.h      |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index ceca4d839dfd..7ba760ee62e3 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -62,7 +62,9 @@ static const struct xhci_plat_priv xhci_plat_cdns3_xhci =
=3D {
 	.resume_quirk =3D xhci_cdns3_resume_quirk,
 };
=20
-static const struct xhci_plat_priv xhci_plat_cdnsp_xhci;
+static const struct xhci_plat_priv xhci_plat_cdnsp_xhci =3D {
+	.quirks =3D XHCI_CDNS_SCTX_QUIRK,
+};
=20
 static int __cdns_host_init(struct cdns *cdns)
 {
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index b9ae5c2a2527..9199dbfcea07 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -74,6 +74,9 @@
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
=20
+#define PCI_DEVICE_ID_CADENCE				0x17CD
+#define PCI_DEVICE_ID_CADENCE_SSP			0x0200
+
 static const char hcd_name[] =3D "xhci_hcd";
=20
 static struct hc_driver __read_mostly xhci_pci_hc_driver;
@@ -532,6 +535,10 @@ static void xhci_pci_quirks(struct device *dev, struct=
 xhci_hcd *xhci)
 			xhci->quirks |=3D XHCI_ZHAOXIN_TRB_FETCH;
 	}
=20
+	if (pdev->vendor =3D=3D PCI_DEVICE_ID_CADENCE &&
+	    pdev->device =3D=3D PCI_DEVICE_ID_CADENCE_SSP)
+		xhci->quirks |=3D XHCI_CDNS_SCTX_QUIRK;
+
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
 	if (xhci->hci_version >=3D 0x120)
 		xhci->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1dde53f6eb31..a1ad2658c0c7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1386,6 +1386,20 @@ static void xhci_handle_cmd_set_deq(struct xhci_hcd =
*xhci, int slot_id,
 			struct xhci_stream_ctx *ctx =3D
 				&ep->stream_info->stream_ctx_array[stream_id];
 			deq =3D le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+
+			/*
+			 * Cadence xHCI controllers store some endpoint state
+			 * information within Rsvd0 fields of Stream Endpoint
+			 * context. This field is not cleared during Set TR
+			 * Dequeue Pointer command which causes XDMA to skip
+			 * over transfer ring and leads to data loss on stream
+			 * pipe.
+			 * To fix this issue driver must clear Rsvd0 field.
+			 */
+			if (xhci->quirks & XHCI_CDNS_SCTX_QUIRK) {
+				ctx->reserved[0] =3D 0;
+				ctx->reserved[1] =3D 0;
+			}
 		} else {
 			deq =3D le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
 		}
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 101e74c9060f..4cbd58eed214 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1907,6 +1907,7 @@ struct xhci_hcd {
 #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
+#define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
=20
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
--=20
2.43.0


