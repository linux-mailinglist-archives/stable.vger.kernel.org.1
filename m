Return-Path: <stable+bounces-256582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LintK09lGWqfwAgAu9opvQ
	(envelope-from <stable+bounces-256582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:07:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F94600709
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B24D307B555
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048722E7379;
	Fri, 29 May 2026 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leroy-agon.com header.i=@leroy-agon.com header.b="0nUTzDsN"
X-Original-To: stable@vger.kernel.org
Received: from smtp-mibc-fr-09-azure-outgoing-2.mailinblack.com (smtp-mibc-fr-09-azure-outgoing-2.mailinblack.com [185.209.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796DA305673
	for <stable@vger.kernel.org>; Fri, 29 May 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.209.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048755; cv=fail; b=FCMrH28K3kCdLHnmaqWxRzFD2EajukY1bleezkjl//UwBivIimDchzvaF1tcpUorEPUqBDq2ScB9ilfq6YzNg+ATYCR6RmBNE6kzgjwqAeG1BcIsm/DD3uQyoqzfZD2rUv6T3I2U4Zj5B2BIMu6u585F+h2U64oifkD7AVcKPYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048755; c=relaxed/simple;
	bh=Br0xGrX74XJBGUHegT5b8ztz6atirRPxRaythR4uv+8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q0OkbT7s2KUryt3H6BPGz0oBWHv14glBsvx4mIeug7saZT8JH+92hr7rQcEm9IDtiVNJnc476cA96asEay8TmZf2zjaIUNBbPGSmVVCYRZgsvtvj15TJlxCcnNV8B7IkHDf/K3r3p4cp7TcmD758Tba5vFTgN4sY5aKzR1lZ1AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leroy-agon.com; spf=pass smtp.mailfrom=leroy-agon.com; dkim=pass (2048-bit key) header.d=leroy-agon.com header.i=@leroy-agon.com header.b=0nUTzDsN; arc=fail smtp.client-ip=185.209.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leroy-agon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leroy-agon.com
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020127.outbound.protection.outlook.com [52.101.167.127])
	by mx-4-mibc-fr-09.mailinblack.com (Postfix) with ESMTPS id 458C7800050;
	Fri, 29 May 2026 11:43:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H708lMQ2J4oA3hST2dVhqNujUBkI2Qo/FnwqFUwL0rmaCoED+HNUK7gNzmzXxR/LUULLjUAbQ/ksMJRoeBs/DNxWS05zpPrHJ+xt2O3RJIH/uepSpEFScrovshmxTEgKqjNm13QocWjmNbUq4mVqK8RpUsa5v+gok7AGzkFibm0DxfZhzeBZ97TRvNK0Ow92L7Z/AfdeSgxn5Ee5evELXHLIuHT45rWsPa19j0yV5WEuV+NeizcXDsgbGG1C3aJQsB8ECAMJLwu6anQf9EV1JOFFOWTx1jb3d9OlDiWcd4liiD8ceb4z3e8Z2NWke0UsUmMIT/pq+/xP3RneOoNF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br0xGrX74XJBGUHegT5b8ztz6atirRPxRaythR4uv+8=;
 b=QMNuF/Sajjq/9IJo9RvFknOwxdGnCk7Jrg4WkiIZ2piuR1KEhd+7tVqPI6BQ4QeASl0+PLICrn7cmyC/SS3Tiag/70K42k2UJ7msIaMt14Xec1GdReXmwaG/Y4YHYXk2lknZ77MBB2+v+mpbykJDnH98CjRQtVwPYwfYjQ03oOTQ1WxR7xuU+QsplKoEjzQK68v0qVPYiT1gcHDV3W0LaqcTj8M/fGDDFP8RxxowOqE0aOXtPCw+3M4NXiHoDyW3WEFJpOtzcfXdh17ysE0tJKHWuKtmPAf76LzoS0DXvZv79AHIPRpGMVcB8hDLk3Q8a68dsNBDvKXK2k/wLXLlYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leroy-agon.com; dmarc=pass action=none
 header.from=leroy-agon.com; dkim=pass header.d=leroy-agon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leroy-agon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0xGrX74XJBGUHegT5b8ztz6atirRPxRaythR4uv+8=;
 b=0nUTzDsNTgHOD63/LAimXC5ss56ZUR0+Y+T1U+mqTpmGFgEKz2MS6V2fnsy16s1DG28rXQQLk2dG9AyOgPEQj3wgnq6vt1cndGSg89oTZOFPGh4YaFamzVujRPI9+8uueFbiT78MXLEpKkjWfIjJEZcjdrtPPASyXFIfYFLFC4I2RuDdVgWZD//rqsehva2OnKMtzPIJWo0SX0MfgjiDhRoRdYQwzJMV7NYVGkjfPddCDYPmLF5Xos/N5V2E1U2TTuqjhqe7fcaNnSw0d/4hQ9PZDlvhZr1DLAZ+icZkk9rW33+BI4xLPHdmZO/D3d2xdIGsaCaURLl24+n4d7qqRw==
Received: from PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e4::24)
 by MR0P264MB6923.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 09:43:23 +0000
Received: from PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d3d1:c80f:9bbf:c5d4]) by PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d3d1:c80f:9bbf:c5d4%4]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 09:43:23 +0000
From: =?utf-8?B?Sm/Dq2wgRVNQT05ERQ==?= <joel.esponde@leroy-agon.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Robert Marko
	<robert.marko@sartura.hr>, Jakub Kicinski <kuba@kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Thread-Topic: [PATCH 6.12.y] net: phy: micrel: fix LAN8814 QSGMII soft reset
Thread-Index: AQHc70+Wp1K41CMp+ka10OJNNdD4uQ==
Date: Fri, 29 May 2026 09:43:22 +0000
Message-ID: <7b95f12f-aac6-47bb-ab9f-eab98b3911fd@leroy-agon.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leroy-agon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAZP264MB2688:EE_|MR0P264MB6923:EE_
x-ms-office365-filtering-correlation-id: 4080cd49-76a2-41f7-0da1-08debd66b99c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|38070700021|56012099006|6133799003|11063799006;
x-microsoft-antispam-message-info:
 THHMvToU6xlXwgfFfQgSN7ntDGu3CXBxRwJqXhwU1aI/rALQVJI5BXCwZPSssazzPDxrNi5f4cP7F/3PzbM/P3cF2sWPioOXYHYVEEeO9ix8U1T2GbOQbXJqnP901gTsz5nAlfvalikqnIV+FSmdbtuDDfjHpnUuuMoZFrNSqA+BBD7jsF4fJjewQ6OU9/Z6x+3D2kHSlH/Ihl4wHMlgkiKDIRfrGIk2mEhq6vEQEktAasNwLBDgjC2zNFJzglxpTOIQyIt6kmNOxxSkbzfty7uFCKrkL/fzx5rcMHdYMCNQIetVd13GxtRX0uPjs/EuDLP7eNiuG84v7NcS4AGUGtBgGBKLfx7ZBb/fmqoBCp1otmpi9/Dke2Jg3ya/qQXemIWNiH7xM00RKTojprivVgg82OzXNcolO+e5jcYKlHDSAvgP0zABklmYxcrAyuBBs9k1FYf1puCo3gb3n71u3uQjrLDXtZiKJI/mWzfzED/Xtl1aH2EakQOPqBUhjrouwiTd6mFhvarGoNixejfvlHTVhAu6C68JLKNuGHbHK03frWPod3Yly7rddULD4TtG61OUj5jGurHGzHgMUM9ucODXClKOvK4phlpFx3tDo7JM9DSsCxdM18LvH3uustYbl9v+BbDH7kZLd8QI9ZsUzYvIOFdNwuWonRy/VO4dfjBaqYTdhIfbQ79fAxHH9UWeHg0hsDX8T31Cf1D17E6J1w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(38070700021)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UndIWlJpb2RyRHM0RjlqOGVSVkFXeHRrUDlEV2xYOUdIVFFaWjVPVFNQR09R?=
 =?utf-8?B?OGVLRWljVmlxTjJyTHFrTVV6RklUc1BTOGhrMzlsRSsxSmk4c1BCa2g4TFlI?=
 =?utf-8?B?WmEyT0Zyd1ArY1BlcFRjZkVQRS8rOU5FVTF6Q05FN2oyVzc2Tmtjd3JLdUd5?=
 =?utf-8?B?TXQ0blhjaEx3QlNhZVZXWkJmbjNEQS9aSzdRYkRvOUVUUEd5eDdNTUR4Q2t3?=
 =?utf-8?B?MkxWYmZnTkRwZHpZeEZzU2YrYVBPWXp0RWpvd1NTQld6MEhOUzZ4SDhtM3pN?=
 =?utf-8?B?ZVB0Ukx6ZDNXZnVJRU4yelZCSFN5U0loQ21GbFo1VE4yWGpJL1AxR0I1WDVF?=
 =?utf-8?B?NENueHozZ0NoVlZyRHdVRzJ1a0pPc25yRFJIU21RdUI2Nks4OGY2Um45QzFp?=
 =?utf-8?B?QzJvcmZJRTdwRDFWbVByQ3A0UTcvMFkwMUVFTzN4RC9MUHp6dTFVc1loN1ZB?=
 =?utf-8?B?SjQ1V1N4VjhrUE1RV0lCRnNoaC9hTkNJVjhhbUNPRnV5K0l2ZjVoM2ZhZ0pM?=
 =?utf-8?B?ZmtUbzE1dzBKSW1FNDM3N2pzQnNGN0kvSERkamNoZmhNRjh1YUNpRmF6Zzhp?=
 =?utf-8?B?VzFCT0UxL0tVQTRabS8yS09HR3prd1l0b2kyeE9SdDlpNHQwZjREdFdFaW44?=
 =?utf-8?B?USsyaUZZc3VEWllDWkh3WHpQQ1NVSW5uRVZJR2FUT3prV20yL1NyMWdZLzND?=
 =?utf-8?B?Tm5ZMEsybWxHVGdqSTdCSGd2b3BvWUFubEI4NldxMVlZOVFMNWU4S2V6azBG?=
 =?utf-8?B?bGpZemJhcmhZT1V6aURWVGhySHNLWHNlYVA4OFJ4V3BsVXlHR09hVjlCNkFu?=
 =?utf-8?B?S3pVdUxaUGk5K29abDJKWGdPOEFMVFNBRXJXM0RPUjV5S0o3aGxzYWFDd2hH?=
 =?utf-8?B?ODN0RlprUExrUWhIMVJpaWQ1NzNobzlWRTErT3dOZ0RmTEkzaXV3VmN1bFg2?=
 =?utf-8?B?SzNINlZxcngwK3hhaE9EV1hDQmZXMWRmQmxseTc1RTZEcGxORXdIbEwvcHVK?=
 =?utf-8?B?M0sxcHJJM2MxUWVSYlhFQkFvWnVuMHB2Rms1UVcrR21ESFd6WG1nVUl4OEdr?=
 =?utf-8?B?cWs4K25VNFg0K05lVXdIWlZKZUdtSlhhZE13N2RITjA1TVhsNzVjOU5KdjlO?=
 =?utf-8?B?eUxFcGZ3RkZ6YlNIc0NQVWhzUEhrMTQxME9EeWNvZHdUcXJVMVkxalVidGhI?=
 =?utf-8?B?NGRYb2tHRzdCQ1oyaFdVeTh2OVp5YXo1WEdHeDFxY2VUaGU0RlFialBaNnlh?=
 =?utf-8?B?eEVhK2VSNFlybU5UVFB6ckZKT1YwajhyVDBaMUFISndNN1FmdFFqU3dSNVIz?=
 =?utf-8?B?UW9QS2pYTHpvVVhNMHpuQ1lkRmJOR1poMnJ4SURnVk1lWjYzZTJIQUMwS0lp?=
 =?utf-8?B?SFVTdXlaYmRvM0RzNE95UmJtQmUzbFVBZlJoTFhpbWhEVVNLUDkvRUhrWnBQ?=
 =?utf-8?B?dER4SlZMZnRLcS9JcVZteVQvY3JQSnY3cEU4elVTVGlyUkg4cjJlQjB3d1lF?=
 =?utf-8?B?dkMzbjErTDlMRUlhSDVOdGFuVURaY2RuWExGb1MrM3dHd2dpaVNlMkF0VXJU?=
 =?utf-8?B?VnF4dFF0Y1RHNUNkaUY1R2x1K2ZxbjhGY2Q2UW1pZ1ppSUorbzBzTVEzTVMy?=
 =?utf-8?B?dzlvNGpJU0hQbWh6MmhIcjBORlorWitHMzFSQzFZNDc0NFVsdGtJdmlBMnNy?=
 =?utf-8?B?Ulo2UE1uRG1iVDVOTVFyQ2ZGN1lYZldJMEN2bCtWQ2JSMG56NzdLUFhOSkNU?=
 =?utf-8?B?czJveUtwSFR5Z1hzc3U4MVJ4UnZpQWdpWm5iWFh6ajRYZGxBQkxlRVNNdnpz?=
 =?utf-8?B?akM5aDFXcUNvaDV2MEJFaitxL3N1azVRTWJZSGNub3l0WS9vZnpsSGtnVnFT?=
 =?utf-8?B?MUs3RmhQRytuWHdkRlFqMm11aGcvaURtTlM4RDZrTzZ1L1BmNGxjMVpsb2JN?=
 =?utf-8?B?aC9UN0FFQ3lKS0tOdmg4Q3BlbDE5d3Z4Qytwajd6Ny9ZN2NzMTA0SEh1eDQy?=
 =?utf-8?B?Q2tKNDQ5ckorVFBLWkZtN2IyNS9uQzNZcUhSdjRRM1RVZmIxUmU0RnI0R3RU?=
 =?utf-8?B?QmdzaVIrQ2g2SXBzSFU3eUhJM2xyN3hVVVppaGhVbUhHRzNJQ25JYVVmSHk4?=
 =?utf-8?B?NjFDQlozQm5IdUlhN2F0M25qYmI5YkpZTjJCTFFSSG5TakxXZUZoQmpVNnVl?=
 =?utf-8?B?LzZ1R21jNFIvYlRzYmpNM1M2emd5RmVTY2pWNW05c1BKdTNRT1lUVTUydG5n?=
 =?utf-8?B?cHpwUEZUbW1nc3E2NVZ3cGpKRVVEZ3I3YUpsVHF1OWdiZDlOZDVKeUNzVzM4?=
 =?utf-8?B?K2dlU3ovbmF6SE9PMjNieDBnY3ZUK2s4R0c0TW5yOUpFWUg4L2Q0VnBZK2k3?=
 =?utf-8?Q?PmKrXdRVr4UKhn3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BC7218C791EFC45AE26EBBEE5F277E2@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	cagSeGEal9juQCM9ZiQBC6tAyRNrrr3CJKvI/dAkPG47CMrmjfCL3uTYrX/CoW6EFk8BotJFCRBk7oyv/fAIbZeawnEpMfICR9/xPFNosNrwDLvuarUE6uSzZRjVr5SHrBCfUoS6IxW/kIJ0SfGYCI2M4J6OwhIsij8SwdT+gS99v+LoqeQO4SEjDETJb80Q7KULGEKV2okThMOiWyV9cN3pWEnNBuJV5qUn9Upuy2Lhld3hGJeT7avzeutpNomRdLbrpq5ZbrKDFEENyMpv3cjIodJT+vrfOB0BO4j/BuVn516o5wQUngMXbK78LMOoyH5gACNnjgdfgmGgipTr6g==
X-OriginatorOrg: leroy-agon.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAZP264MB2688.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4080cd49-76a2-41f7-0da1-08debd66b99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 09:43:23.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b97cad2-240b-425a-b0cb-987a43def8d0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F09fAbgDjnkouJXXsdJGIT1YI+55xZYegklzArde4xmocWshmOTmxkrhvY1B70pKRL2FdTI3BAZG+LXbyxzYnh2bUAEq2DKpugmhaHXn6JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB6923
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[leroy-agon.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leroy-agon.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256582-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joel.esponde@leroy-agon.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[leroy-agon.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,leroy-agon.com:email,leroy-agon.com:mid,leroy-agon.com:dkim,msgid.link:url,sartura.hr:email]
X-Rspamd-Queue-Id: 01F94600709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

RnJvbTogUm9iZXJ0IE1hcmtvIDxyb2JlcnQubWFya29Ac2FydHVyYS5ocj4NCg0KWyBVcHN0cmVh
bSBjb21taXQgZTAyN2MyMThjNDgyYzZhMGFlMTk0ODEyOWNjZGEzYjBhMjAzMzM2OCBdDQoNCkxB
Tjg4MTQgUVNHTUlJIHNvZnQgcmVzZXQgd2FzIG1vdmVkIGludG8gdGhlIHByb2JlIGZ1bmN0aW9u
IHRvIGF2b2lkDQp0cmlnZ2VyaW5nIGl0IGZvciBlYWNoIG9mIDQgUEhZLXMgaW4gdGhlIHBhY2th
Z2UuDQoNCkhvd2V2ZXIsIHRoYXQgYnJva2UgUVNHTUlJIGxpbmsgYmV0d2VlbiB0aGUgTUFDIGFu
ZCBQSFkgb24gbW9zdCBMQU44ODE0DQpQSFktcywgc3BlY2lmaWNhbHkgZm9yIHVzIG9uIHRoZSBN
aWNyb2NoaXAgTEFOOTY5eCBzd2l0Y2guDQpSZWFkaW5nIHRoZSBRU0dNSUkgc3RhdHVzIHJlZ2lz
dGVycyBpdCB3YXMgdmlzaWJsZSB0aGF0IGxhbmVzIHdlcmUgb25seQ0KcGFydGlhbGx5IHN5bmNl
ZC4NCg0KSXQgbG9va3MgbGlrZSB0aGUgcmVzZXQgdGltaW5nIGlzIGNydWNpYWwsIHNvIGxldHMg
bW92ZSB0aGUgcmVzZXQgYmFjaw0KaW50byB0aGUgLmNvbmZpZ19pbml0IGZ1bmN0aW9uIGJ1dCBn
dWFyZCBpdCB3aXRoIHBoeV9wYWNrYWdlX2luaXRfb25jZSgpDQp0byBhdm9pZCBpdCBiZWluZyB0
cmlnZ2VyZWQgb24gZWFjaCBvZiA0IFBIWS1zIGluIHRoZSBwYWNrYWdlLg0KQ2hhbmdlIHRoZSBw
cm9iZSBmdW5jdGlvbiB0byB1c2UgcGh5X3BhY2thZ2VfcHJvYmVfb25jZSgpIGZvciBjb21hIGFu
ZCBQdFANCnNldHVwLg0KDQpGaXhlczogMzQ3YmY2MzhkMzlmZjkyICgibmV0OiBwaHk6IG1pY3Jl
bDogbGFuODgxNCBmaXggcmVzZXQgb2YgdGhlDQpRU0dNSUkgaW50ZXJmYWNlIikNClNpZ25lZC1v
ZmYtYnk6IFJvYmVydCBNYXJrbyA8cm9iZXJ0Lm1hcmtvQHNhcnR1cmEuaHI+DQpMaW5rOg0KaHR0
cHM6Ly9wYXRjaC5tc2dpZC5saW5rLzIwMjYwNDI4MTM0MTM4LjE3NDEyNTMtMS1yb2JlcnQubWFy
a29Ac2FydHVyYS5ocg0KU2lnbmVkLW9mZi1ieTogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVs
Lm9yZz4NClNpZ25lZC1vZmYtYnk6IEpvw6tsIEVzcG9uZGUgPGpvZWwuZXNwb25kZUBsZXJveS1h
Z29uLmNvbT4NCi0tLQ0KICBkcml2ZXJzL25ldC9waHkvbWljcmVsLmMgfCAxNSArKysrKysrKy0t
LS0tLS0NCiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkN
Cg0KKGxpbWl0ZWQgdG8gJ2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYycpDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMgYi9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMNCmlu
ZGV4IDJhYTFkZWRkMjFiOGViLi5lMjExYTUyM2MyNTg0ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
bmV0L3BoeS9taWNyZWwuYw0KKysrIGIvZHJpdmVycy9uZXQvcGh5L21pY3JlbC5jDQpAQCAtNDA5
OSw2ICs0MDk5LDEzIEBAIHN0YXRpYyBpbnQgbGFuODgxNF9jb25maWdfaW5pdChzdHJ1Y3QgcGh5
X2RldmljZQ0KKnBoeWRldikNCiAgew0KICAgICAgc3RydWN0IGtzenBoeV9wcml2ICpsYW44ODE0
ID0gcGh5ZGV2LT5wcml2Ow0KDQorICAgIGlmIChwaHlfcGFja2FnZV9pbml0X29uY2UocGh5ZGV2
KSkNCisgICAgICAgIC8qIFJlc2V0IHRoZSBQSFkgKi8NCisgICAgICAgIGxhbnBoeV9tb2RpZnlf
cGFnZV9yZWcocGh5ZGV2LCBMQU44ODE0X1BBR0VfQ09NTU9OX1JFR1MsDQorICAgICAgICAgICAg
ICAgICAgICAgICBMQU44ODE0X1FTR01JSV9TT0ZUX1JFU0VULA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgTEFOODgxNF9RU0dNSUlfU09GVF9SRVNFVF9CSVQsDQorICAgICAgICAgICAgICAgICAg
ICAgICBMQU44ODE0X1FTR01JSV9TT0ZUX1JFU0VUX0JJVCk7DQorDQogICAgICAvKiBEaXNhYmxl
IEFORUcgd2l0aCBRU0dNSUkgUENTIEhvc3Qgc2lkZSAqLw0KICAgICAgbGFucGh5X21vZGlmeV9w
YWdlX3JlZyhwaHlkZXYsIExBTjg4MTRfUEFHRV9QT1JUX1JFR1MsDQogICAgICAgICAgICAgICAg
ICAgICBMQU44ODE0X1FTR01JSV9QQ1MxR19BTkVHX0NPTkZJRywNCkBAIC00MTkwLDEzICs0MTkw
LDcgQEAgc3RhdGljIGludCBsYW44ODE0X3Byb2JlKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYp
DQogICAgICBkZXZtX3BoeV9wYWNrYWdlX2pvaW4oJnBoeWRldi0+bWRpby5kZXYsIHBoeWRldiwN
CiAgICAgICAgICAgICAgICAgICAgYWRkciwgc2l6ZW9mKHN0cnVjdCBsYW44ODE0X3NoYXJlZF9w
cml2KSk7DQoNCi0gICAgaWYgKHBoeV9wYWNrYWdlX2luaXRfb25jZShwaHlkZXYpKSB7DQotICAg
ICAgICAvKiBSZXNldCB0aGUgUEhZICovDQotICAgICAgICBsYW5waHlfbW9kaWZ5X3BhZ2VfcmVn
KHBoeWRldiwgTEFOODgxNF9QQUdFX0NPTU1PTl9SRUdTLA0KLSAgICAgICAgICAgICAgICAgICAg
ICAgTEFOODgxNF9RU0dNSUlfU09GVF9SRVNFVCwNCi0gICAgICAgICAgICAgICAgICAgICAgIExB
Tjg4MTRfUVNHTUlJX1NPRlRfUkVTRVRfQklULA0KLSAgICAgICAgICAgICAgICAgICAgICAgTEFO
ODgxNF9RU0dNSUlfU09GVF9SRVNFVF9CSVQpOw0KLQ0KKyAgICBpZiAocGh5X3BhY2thZ2VfcHJv
YmVfb25jZShwaHlkZXYpKSB7DQogICAgICAgICAgZXJyID0gbGFuODgxNF9yZWxlYXNlX2NvbWFf
bW9kZShwaHlkZXYpOw0KICAgICAgICAgIGlmIChlcnIpDQogICAgICAgICAgICAgIHJldHVybiBl
cnI7DQotLQ0KY2dpdCAxLjMta29yZw0KDQpDZSBtZXNzYWdlIMOpbGVjdHJvbmlxdWUgZXQgc2Vz
IHBpw6hjZXMgam9pbnRlcyBzb250IGNvbmZpZGVudGllbHMuIElscyBzb250IGRlc3RpbsOpcyBl
eGNsdXNpdmVtZW50IMOgIGxhIHBlcnNvbm5lIG91IMOgIGwnZW50aXTDqSDDoCBxdWkgaWxzIHNv
bnQgYWRyZXNzw6lzLg0KU2kgdm91cyBhdmV6IHJlw6d1IGNlIG1lc3NhZ2UgcGFyIGVycmV1ciwg
dmV1aWxsZXogZW4gaW5mb3JtZXIgaW1tw6lkaWF0ZW1lbnQgbCdleHDDqWRpdGV1ciBldCBsZSBz
dXBwcmltZXIgZGUgdm90cmUgc3lzdMOobWUuDQpUb3V0ZSBkaXZ1bGdhdGlvbiwgZGlzdHJpYnV0
aW9uIG91IGNvcGllIG5vbiBhdXRvcmlzw6llIGRlIGNlIG1lc3NhZ2Ugb3UgZGUgc29uIGNvbnRl
bnUgZXN0IGludGVyZGl0ZS4NCkwnZW50cmVwcmlzZSBkw6ljbGluZSB0b3V0ZSByZXNwb25zYWJp
bGl0w6kgZW4gY2FzIGRlIHRyYW5zbWlzc2lvbiBkZSB2aXJ1cyBvdSBkZSB0b3V0ZSBhdXRyZSBj
b250YW1pbmF0aW9uIGxpw6llIMOgIGNldCBlbWFpbC4NCg==


