Return-Path: <stable+bounces-87662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3669A9753
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 05:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C914DB21884
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 03:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F3F46BA;
	Tue, 22 Oct 2024 03:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TqhBEN2l"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925122083;
	Tue, 22 Oct 2024 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568963; cv=fail; b=r074ppImzL9lZGcP35hTTlbMxZSooJco4eyXd5je5UhKQRrMYlN+gBDVOiz5w8jc46swxY6WtCBndjaTHy8yk+VB7FC/hrz9KDXwOAkneRnMFCPzJ7fJcN52olu1zDCkHQP0OFWwmPfb2NjwP/qboQvap+2v1QIuCENxN6tHsH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568963; c=relaxed/simple;
	bh=qXKlXAao3AFI51+4R5DGpitnsLtq+O/6B3Fzu4+Lflk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j6mazTayiqUtlikwXZQz6nieAosVkRO6PAz+VkIIGgzui7q0wHnQ6BNWw01UmPF+pq0zJQkiIKa8MVJYxH/jfaIyvHWCkzCkbKxGlyntlDzta204JKc0OqC709FG1lBIAw+MyetMyM0aQEHGq/In2sfUYInphFkKIK9DtU0nePw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TqhBEN2l; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS3axr9yqEDBBAjjd/WWrk3AQtIv1GN/0mniCL4eNjuhrxH5ykIOzlvt831aw2OzanRY2UOG/dORA4q78ES+0N41Gd+MEoB+29HPlOhnWhrWXllAM1if6Rh2rU0Qf2NQHQriGEthU43pXjvzSWMXX5tQO6AnEf/Th57vYujMtwgX3YZ8uAmvp0QbnkoKhvhygQjTUJ0YqDwXxutmm43M8XokYQkSbYz3RGkI8sJtOYLQJTqtLLOQHS5yoXNyx8lDTt6AfxsS1DB5L3GqUoDAxMEHRWYdHuOxRRL7hvb30FYC3t/XCxeJiHjDeh7uiXHfLzv6HStCsdrhTckSq5IFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXKlXAao3AFI51+4R5DGpitnsLtq+O/6B3Fzu4+Lflk=;
 b=C01oIgejr5rcfbQNOIc8AzXqM0tQzKyYQ+xZjZ54CifehAp6BxNIWJt1nYPHnTs32BFOJzPshKHcfcq4+ANDnY3aSWdtHZoGQln/gpRZjcdKyLc/KEaXIUx8scpsgJrLH6oTWJdG3SVXf6K/k+8DFYWZCl3gckddMBflSWsdbHAavRWpezHgRadfd2cEIPLQI/weuf+8p+iMQFq5IRx69Lj4eoOEvc/iHPyMrJI9FQjz2sgi4MK6um2tUg7CWFl+sfmeA79jJPqnEnMPHcxPAsGazks4+8fL0ITRS/NhpTfo879t3UwCKylF7rHZjWgMYG/McU816P+axv5i0wOXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXKlXAao3AFI51+4R5DGpitnsLtq+O/6B3Fzu4+Lflk=;
 b=TqhBEN2lon1tF1k66XrPbMDC3W0Rmg/k+0MJDTm313QCjDJm45KVMXe8NqEwiSf4f62ZVkdySO0hKSjC1bqdq9ncpvRpgIVR4GMmDbKvi8GamkgSLmELGLv1mOewPk+cECoLdLsMN55boD88yIl3A9bsovvKRPiJlCU6jnxEOhqap7JiLjYtldm8cwqxKR76/xk4RYfEN/ookSZs2c1xQNx3Q2RU//DzweM23gD2t5OiXl3+ofDqmd+VbuGQx2HUiQd1DHGlQ+jMw2p5+Yh78KrwpKksTcAurVPeb/Gz5YPfQtITPNiXRaSSCtGAbBUnA37uIaDIo08llL3rDfg1vg==
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by PA1PR04MB10938.eurprd04.prod.outlook.com (2603:10a6:102:486::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 03:49:17 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::6b10:a2e8:fdf0:6bdd%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 03:49:17 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: "festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"kishon@kernel.org" <kishon@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, Marcel Ziswiler
	<marcel.ziswiler@toradex.com>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just before
 PHY PLL lock check
Thread-Topic: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just
 before PHY PLL lock check
Thread-Index: AQHbI9FMGl88WWAvnEe0gqFlzhKJarKSIYmA
Date: Tue, 22 Oct 2024 03:49:17 +0000
Message-ID:
 <DU2PR04MB86770FFB0CAEEBE95B91F5FC8C4C2@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <20241021155241.943665-1-Frank.Li@nxp.com>
In-Reply-To: <20241021155241.943665-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8677:EE_|PA1PR04MB10938:EE_
x-ms-office365-filtering-correlation-id: 608e4de1-1481-41bd-361f-08dcf24c8101
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?VEJQWmNPa3lqdW44VGhGNkl0SjBoa1NOeTB0QTFmd2kxU1pMTnFuaEF3ZDBJ?=
 =?gb2312?B?RDlUSDFOQlgyUXc3UHFsdzJlZjJCSW15Ym9JbDRVWlhuRVlRSEhVZkhReXZr?=
 =?gb2312?B?VitKWGUyR1NjbUxGTGhwN2l4U202cG5QQlVzVXlzQmZkUnViakxiVEZaNVV1?=
 =?gb2312?B?N1lQVUQvVGt4aEo4TmxlbEh1ZEU3NWgyMWtoVi9XOW0rRHAvcEt3TzM0Y2Fj?=
 =?gb2312?B?TnU0YW02MnB5bGFsakhHK2wyaFNsdVVMWUUvVUpSNlJraW9rK3RZN1FCVGJY?=
 =?gb2312?B?NGdyMnZkTkpVeEFwWXAvSG1mTmpscXRIb1JQdnBiQ3EwQkZBNHNaR0lPaks5?=
 =?gb2312?B?VnZuS25WTHZCVTJ3Q2JqMi9EUWlzVUdQbWhnMHBTR0tIWGZ1WGtwNjVsbFEy?=
 =?gb2312?B?cmhaYTVvb29mMHlOSElZbEdYVVA5K20xcW9hNkQ1cytqdWUvbHZ1b0k3dHFV?=
 =?gb2312?B?cnhlNGFZVlhLYkF4UDBnVWhFNkRoeEhpdnlqa0syTUNsYVVUdkZweFA3Rlow?=
 =?gb2312?B?YTRlSlhGWVdibHlXT1J2VFA2V2pnMS96U2tOamVCTUJRWXdVNjhFcVZUcE9z?=
 =?gb2312?B?eW1GUngzcEFxSHR0SlErcm90akFPTTZPb1pmclRCc0x1SnpydklmQTJFVU5P?=
 =?gb2312?B?UHZNUkRuQ1ZibVd6OTNjbTA3bzV5UFcvaGxNZmJsbjBxOVlaV3ZtdmJYSERp?=
 =?gb2312?B?NnlRU0xlc0kvckxCV2txbjFYOFZmcDA5S0dkamtrYjdiRmt1bE54SkdCOWc4?=
 =?gb2312?B?YjdyVUlSY0pubEgrVzVWSVh4aWw1ZTY0TjVFQWxnaVNubGtnYXJGejFsaU5V?=
 =?gb2312?B?aTJKamF3Mld1RjhVdXhRSEVoVnZmQ0JFVVJ0UEhOV2REYVBGU1RxelExZ1hy?=
 =?gb2312?B?M3FlSTNQdWdoS3FPTjNLY3BvMG85ZU5samw0TE9rS3ArL2Nsd0VzelgyYUlh?=
 =?gb2312?B?WVpvZC9QSUU3dHNTV0NuMk1SQVJKd0Rvbml2ZmNZSW5uL0RsMmVCYm1jeGl0?=
 =?gb2312?B?VmV2cjFUWmw5TWhpNFh4eHFMK1MwQUJsdFlOR0p6WHhyMy8zbE9VczJVUjQr?=
 =?gb2312?B?TGtnRUJ3SUVWVGNtaHh5MWNST0FaZjh5ZUsyL2lCVTcyaXFlL0c2U2RxSnkv?=
 =?gb2312?B?dmx0bWU3dmw4QzZPUHFXV2E0cENNVUdqUmVzdmRlUzMxUDBXYzRpS2lWWGs3?=
 =?gb2312?B?L0RuQnZWNXZoRWZ2eXYyZkN2TDQwZ3ZwbG03VlN2aDRNMzY0TjdKTDUwSzRP?=
 =?gb2312?B?cWxVQm9LaEV2SHhLQ1RlL0hnTXNXbjJCajgzQ1k1dWxDZ09SQWlrZTZja3E0?=
 =?gb2312?B?d0JwRW8wY2xqNmdqdWxGK2RjcnBaUklDVldvRmszRXNPL3AwdDNLcnNVcE0w?=
 =?gb2312?B?bTh3Y29oYm4zbko1aVQyYk9OZzl3T1RVenhjdDNoblhmUlBBTWNNQ2pSWkxY?=
 =?gb2312?B?dnU3Rk5DVmVVZEVJZjV3TU1sM1J5S1RCN0NpTmU1eDV2U0JabytIeG1OSlFw?=
 =?gb2312?B?ak1najJqQUNlZzFKOStqbFgyVzFYWStvZndvM0ljRzZ4S24wUlAvRHdacEUr?=
 =?gb2312?B?Q01Ydmtabm5uS0k3SDQrdm85ZHlSNDhEZHNCdVhTUVZIRG1SSTE1UDdIQ2RW?=
 =?gb2312?B?aS9OcXFaTjhVL3g2dDFBNGRyNHdvQ0cwTjB3ZHo0OGpMV2pWY0VnQUZBOHpY?=
 =?gb2312?B?SjlCL096UXJJM2x3ZDJRdzZ2WDRVT25GSU9ic1BlRXR5c2hpTUNvTFhvaFQ4?=
 =?gb2312?B?Yll1WXBRb01YTUhoRktnYUR2VldpVk1NOXc1bDJsakxJRUZ0MmFZSGNRVlkz?=
 =?gb2312?Q?GJ2xfU1fqGNlG21DxRfnuNr2x9lzD0yffEgZA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VTAvY2Q2RU1XTG9OK09lTU85M3dJRXd3UTlyN2ZTbm1MN2FBQnZEamFsNlFI?=
 =?gb2312?B?OTJQRUFReXZZU1hkYXFmSjNZckpka1ZzbzJwaW5Xa3A5ZDRybGMxOG4xYWhr?=
 =?gb2312?B?ejB2ZjVKdVFpRmhNUTBNbEZtYkRvcElSUTVqNExmdmtwYnpVT1pyZ01iMFdr?=
 =?gb2312?B?U21ScHJTdWhrYmVRZXdTbGwxN0xiNkt0SUthYkdiZlpnZzM1TnQrNk53OE0x?=
 =?gb2312?B?L2ZiVWJFSm90OWZIUFJxOC92aHJxWDQvZEdWZ3gzUHNkWWpvZEhENG1YMytQ?=
 =?gb2312?B?am5ObUpmTnBCTmJIR1FNejZCaFpWMVF0S3ppZjN4akNDTzM0a3JPZWJhOG1D?=
 =?gb2312?B?UExWcHFwMytVME5PWjhuV2N6cEhUVUJ2TVNHbTBJVnRucG81NVQvcVlVUDhn?=
 =?gb2312?B?VUErY1d2NFhrSEZMMG5OT1B6Y3FBM0tKMFczbTJoWll2dTNuNFNWdldsMjBn?=
 =?gb2312?B?R2lyZjZVY1ZnbDdoTWFEZlhlUGZKYitXREttVUlnbDdNcmJPQ2dPd05qY3Qw?=
 =?gb2312?B?M1BCRVlTNUpld2VuSkExdzlhd1drTDBXd3RrTzZWanBrNVFXeFNxVWFxMUpY?=
 =?gb2312?B?U1kyU1JzOGp4dHoyTDBLVTBMeXZadUx1Q0RJNDN5bW9BTDUxVWNERUUydVN1?=
 =?gb2312?B?YTBqeC9PZC9lRURmTi9meEN0NGs0Njg4MXU1RHgvZUxLeFY5ZUl2MjMrYXBM?=
 =?gb2312?B?WWdaZUhSdWxtZlNqZHdRZ2pXOXZ4Y1RlQjlQb2RzTXZaOFFVaEt4eVlPUXJS?=
 =?gb2312?B?bmpqN0ZRNy9hRjNoVHUyODlUR2ZmcUNTWks3TzZyR3VmaTZRSWhsNzN3ZDZ5?=
 =?gb2312?B?QkppTStvTVQydUJNSWxhVWlXdE1OL3A5OTRLV05MK1dvd0Z3VUZJZWlpZ0Zu?=
 =?gb2312?B?WnVKWWFCcUVlRW9UTWgwcm1JWjR6SmNtNU1oc0ZjZ1Q5QTVkcjhvc1FBUUZN?=
 =?gb2312?B?TjVObU1IT2puTjNpbU16cSsycmVrNG15ZnNjS1YrSXNpbDNVdVlzNlU1b3hj?=
 =?gb2312?B?eGVZajVLTllhN2o0dGd0b2Nad0xNMjRyam43OW1jODFHQ1ZZMnlxKzdCS041?=
 =?gb2312?B?Yk9iYWhKUlhSVlRsOHpCUW9FS2hVZG1tOUZ6Nk1ORDNLZG1FNHk5NmZEeDN0?=
 =?gb2312?B?bkNDb3h0TUJhV0hjNWk4MThXeGY5ZUZqdVJaN0hLU3pOOGJxSnhRWElZYndO?=
 =?gb2312?B?dGQ2NGwrTTdVY1RuSDdPR2QxRjNsdnhuOGFGalVLVmVCa3YySXZ1TlFKZW5x?=
 =?gb2312?B?bmt2TDJLRGYxbW55M0plMDM0YkhqSGlwRGZ0VkVLMW8rODZKREUzN0JxaWFN?=
 =?gb2312?B?cGdFckV2Tll6WjVUUlR0MC9uWkZhYU0yRGFialNYSkRuNkNJMHRTYStOeE9w?=
 =?gb2312?B?RHRWTm5VeFVsTCtzU3NWSjA1RWRPYUQ0VzRtVUJpMnhDWHRNeXc5MXkvVEw3?=
 =?gb2312?B?ZXA4MkppMVpCVkM0bDdtSHpQUDNSeTQ5SjRTQ3ExMEVSWVJxM3ByRXZLKzQ3?=
 =?gb2312?B?T25tMmNJanpKYW1GSDljYk8zbjIzVGtQS1JKZ1lHTVpHUHA3VGtjN2xDMEtH?=
 =?gb2312?B?VkJycy82T0RVT3JCQWxyOWhJbmpQdW9GV0FNUU1LenJxU0RET3ZzSE93aVF6?=
 =?gb2312?B?U1U2K2N3REt0SnFPdmNXYlM4Yy84L0FPc1pnRVRoczJSRUhzQWRhRzVLTzRY?=
 =?gb2312?B?dTA5TjkvVHRmYmd0WWNjalE3ZHRXZWpsS21ubE4zVlhJditvMUxQTW9ZWHYx?=
 =?gb2312?B?OTcwVmphS1ZvbVd3V1ZwSTZneHFHWVE5R1hienB3WUpBSG9aRDhsSm1wUjNU?=
 =?gb2312?B?c3dWZ0xYeGZSMmtRN1NGYzE2RlRNcGNsSVJrREFkUmE3bi9pUExxck8vK0NR?=
 =?gb2312?B?NGlaTkNCN01ST3dCMmI4YjI5clBHV1VGVEROTkFRalhNb3pMTi9hbDkrajR3?=
 =?gb2312?B?SkdUcXZMUmI0cXBDK3BhWjJpOWIwUlc4NG1KNVhxWEU0dEdGekM3clNOZVJQ?=
 =?gb2312?B?ME5JMkIwREhSK2J5bUJoNnp2Z1FlMDV5cTdxVk9BVUpRaXk5N25GOUV0Z0Q4?=
 =?gb2312?B?QkFqWkh1QU9YYis2ejBoZDhRb2o0QzdVRk1RNUVaMG9ObFVNeGJrOXRmUmF0?=
 =?gb2312?Q?lbWxXo0Ma10tMbDVCnThAO9ms?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608e4de1-1481-41bd-361f-08dcf24c8101
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 03:49:17.4970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhWdi1L72fHjPdkDDZ3rReCi7gO+cmZDpoAS/4YsdXjnWUqyeyPRLusLNsurh4HqY/Vlg+ol+JygFTNQYR5xGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10938

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjIxyNUgMjM6NTMNCj4gVG86IHZrb3VsQGtlcm5l
bC5vcmcNCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsgZmVzdGV2YW1AZ21haWwu
Y29tOyBIb25neGluZyBaaHUNCj4gPGhvbmd4aW5nLnpodUBueHAuY29tPjsgaW14QGxpc3RzLmxp
bnV4LmRldjsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBraXNob25Aa2VybmVsLm9yZzsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTWFyY2VsIFppc3dpbGVy
DQo+IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+OyBzLmhhdWVyQHBlbmd1dHJvbml4LmRl
Ow0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2MiAxLzFdIHBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2llOiBEbyBDTU5fUlNU
IGp1c3QgYmVmb3JlDQo+IFBIWSBQTEwgbG9jayBjaGVjaw0KPiANCj4gRnJvbTogUmljaGFyZCBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiANCj4gV2hlbiBlbmFibGUgaW5pdGNhbGxfZGVi
dWcgdG9nZXRoZXIgd2l0aCBoaWdoZXIgZGVidWcgbGV2ZWwgYmVsb3cuDQo+IENPTkZJR19DT05T
T0xFX0xPR0xFVkVMX0RFRkFVTFQ9OQ0KPiBDT05GSUdfQ09OU09MRV9MT0dMRVZFTF9RVUlFVD05
DQo+IENPTkZJR19NRVNTQUdFX0xPR0xFVkVMX0RFRkFVTFQ9Nw0KPiANCj4gVGhlIGluaXRpYWxp
emF0aW9uIG9mIGkuTVg4TVAgUENJZSBQSFkgbWlnaHQgYmUgdGltZW91dCBmYWlsZWQgcmFuZG9t
bHkuDQo+IFRvIGZpeCB0aGlzIGlzc3VlLCBhZGp1c3QgdGhlIHNlcXVlbmNlIG9mIHRoZSByZXNl
dHMgcmVmZXIgdG8gdGhlIHBvd2VyIHVwDQo+IHNlcXVlbmNlIGxpc3RlZCBiZWxvdy4NCj4gDQo+
IGkuTVg4TVAgUENJZSBQSFkgcG93ZXIgdXAgc2VxdWVuY2U6DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiAxLjh2IHN1cHBseSAgICAgLS0tLS0tLS0tLw0KPiAgICAgICAgICAgICAgICAgICAgIC8tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gMC44diBz
dXBwbHkgICAgIC0tLS8NCj4gDQo+ICAgICAgICAgICAgICAgICAtLS1cIC8tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgICAgICAgICAgICAgICAg
ICAgIFggICAgICAgIFJFRkNMSyBWYWxpZA0KPiBSZWZlcmVuY2UgQ2xvY2sgLS0tLyBcLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiBpX2luaXRfcmVzdG4g
ICAgLS0tLS0tLS0tLS0tLS0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwNCj4gaV9jbW5fcnN0biAgICAgIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IG9fcGxsX2xvY2tfZG9uZQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiANCj4gTG9nczoNCj4gaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBob3N0IGJyaWRnZSAv
c29jQDAvcGNpZUAzMzgwMDAwMCByYW5nZXM6DQo+IGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTog
ICAgICAgSU8gMHgwMDFmZjgwMDAwLi4weDAwMWZmOGZmZmYgLT4NCj4gMHgwMDAwMDAwMDAwDQo+
IGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTogICAgICBNRU0gMHgwMDE4MDAwMDAwLi4weDAwMWZl
ZmZmZmYgLT4NCj4gMHgwMDE4MDAwMDAwDQo+IHByb2JlIG9mIGNsa19pbXg4bXBfYXVkaW9taXgu
cmVzZXQuMCByZXR1cm5lZCAwIGFmdGVyIDEwNTIgdXNlY3MgcHJvYmUgb2YNCj4gMzBlMjAwMDAu
Y2xvY2stY29udHJvbGxlciByZXR1cm5lZCAwIGFmdGVyIDMyOTcxIHVzZWNzIHBoeQ0KPiBwaHkt
MzJmMDAwMDAucGNpZS1waHkuNDogcGh5IHBvd2Vyb24gZmFpbGVkIC0tPiAtMTEwIHByb2JlIG9m
DQo+IDMwZTEwMDAwLmRtYS1jb250cm9sbGVyIHJldHVybmVkIDAgYWZ0ZXIgMTAyMzUgdXNlY3Mg
aW14NnEtcGNpZQ0KPiAzMzgwMDAwMC5wY2llOiB3YWl0aW5nIGZvciBQSFkgcmVhZHkgdGltZW91
dCENCj4gZHdoZG1pLWlteCAzMmZkODAwMC5oZG1pOiBEZXRlY3RlZCBIRE1JIFRYIGNvbnRyb2xs
ZXIgdjIuMTNhIHdpdGggSERDUA0KPiAoc2Ftc3VuZ19kd19oZG1pX3BoeTIpIGlteDZxLXBjaWUg
MzM4MDAwMDAucGNpZTogcHJvYmUgd2l0aCBkcml2ZXINCj4gaW14NnEtcGNpZSBmYWlsZWQgd2l0
aCBlcnJvciAtMTEwDQo+IA0KPiBGaXhlczogZGNlOWVkZmYxNmVlICgicGh5OiBmcmVlc2NhbGU6
IGlteDhtLXBjaWU6IEFkZCBpLk1YOE1QIFBDSWUgUEhZDQo+IHN1cHBvcnQiKQ0KPiBDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAu
Y29tPg0KPiANCj4gdjIgY2hhbmdlczoNCj4gLSBSZWJhc2UgdG8gbGF0ZXN0IGZpeGVzIGJyYW5j
aCBvZiBsaW51eC1waHkgZ2l0IHJlcG8uDQo+IC0gUmljaGFyZCdzIGVudmlyb25tZW50IGhhdmUg
cHJvYmxlbSBhbmQgY2FuJ3Qgc2VudCBvdXQgcGF0Y2guIFNvIEkgaGVscCBwb3N0DQo+IHRoaXMg
Zml4IHBhdGNoLg0KPiAtLS0NCkhpIEZyYW5rOg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGtpbmRs
eSBoZWxwLg0KU2luY2UgbXkgc2VydmVyIGlzIGRvd24sIEkgY2FuJ3Qgc2VuZCBvdXQgdGhpcyB2
MiBpbiB0aGUgcGFzdCBkYXlzLg0KDQpIaSBWaW5vZDoNClNvcnJ5IGZvciB0aGUgbGF0ZSByZXBs
eSwgYW5kIGJyaW5nIHlvdSBpbmNvbnZlbmllbmNlLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQg
Wmh1DQoNCj4gIGRyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYyB8IDEw
ICsrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wt
aW14OG0tcGNpZS5jDQo+IGIvZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNp
ZS5jDQo+IGluZGV4IDExZmNiMTg2NzExOGMuLmU5ODM2MWRjZGVhZGYgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiArKysgYi9kcml2
ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4bS1wY2llLmMNCj4gQEAgLTE0MSwxMSArMTQx
LDYgQEAgc3RhdGljIGludCBpbXg4X3BjaWVfcGh5X3Bvd2VyX29uKHN0cnVjdCBwaHkNCj4gKnBo
eSkNCj4gIAkJCSAgIElNWDhNTV9HUFJfUENJRV9SRUZfQ0xLX1BMTCk7DQo+ICAJdXNsZWVwX3Jh
bmdlKDEwMCwgMjAwKTsNCj4gDQo+IC0JLyogRG8gdGhlIFBIWSBjb21tb24gYmxvY2sgcmVzZXQg
Ki8NCj4gLQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14OF9waHktPmlvbXV4Y19ncHIsIElPTVVYQ19H
UFIxNCwNCj4gLQkJCSAgIElNWDhNTV9HUFJfUENJRV9DTU5fUlNULA0KPiAtCQkJICAgSU1YOE1N
X0dQUl9QQ0lFX0NNTl9SU1QpOw0KPiAtDQo+ICAJc3dpdGNoIChpbXg4X3BoeS0+ZHJ2ZGF0YS0+
dmFyaWFudCkgew0KPiAgCWNhc2UgSU1YOE1QOg0KPiAgCQlyZXNldF9jb250cm9sX2RlYXNzZXJ0
KGlteDhfcGh5LT5wZXJzdCk7DQo+IEBAIC0xNTYsNiArMTUxLDExIEBAIHN0YXRpYyBpbnQgaW14
OF9wY2llX3BoeV9wb3dlcl9vbihzdHJ1Y3QgcGh5DQo+ICpwaHkpDQo+ICAJCWJyZWFrOw0KPiAg
CX0NCj4gDQo+ICsJLyogRG8gdGhlIFBIWSBjb21tb24gYmxvY2sgcmVzZXQgKi8NCj4gKwlyZWdt
YXBfdXBkYXRlX2JpdHMoaW14OF9waHktPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxNCwNCj4gKwkJ
CSAgIElNWDhNTV9HUFJfUENJRV9DTU5fUlNULA0KPiArCQkJICAgSU1YOE1NX0dQUl9QQ0lFX0NN
Tl9SU1QpOw0KPiArDQo+ICAJLyogUG9sbGluZyB0byBjaGVjayB0aGUgcGh5IGlzIHJlYWR5IG9y
IG5vdC4gKi8NCj4gIAlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXQoaW14OF9waHktPmJhc2UgKw0K
PiBJTVg4TU1fUENJRV9QSFlfQ01OX1JFRzA3NSwNCj4gIAkJCQkgdmFsLCB2YWwgPT0gQU5BX1BM
TF9ET05FLCAxMCwgMjAwMDApOw0KPiAtLQ0KPiAyLjM0LjENCg0K

