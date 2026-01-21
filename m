Return-Path: <stable+bounces-210715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIOaLRiRcGkaYgAAu9opvQ
	(envelope-from <stable+bounces-210715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 09:40:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C9D53B5D
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 09:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A37267E8D69
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4D647A0B0;
	Wed, 21 Jan 2026 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R//jSNiU"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013009.outbound.protection.outlook.com [52.101.72.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A17C478E58;
	Wed, 21 Jan 2026 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984433; cv=fail; b=AgR5+Akd1Px897PYEQcAND/285F/FbZMJ/Me/OIhRUjrxtJHrXwrAbu7x/Iqm5HoOwX7qDOzrS+p/+VysQDjld2DmiHoUFZ6ip24ZGFdJcrKncs6GbQqVrW+rBENffSwa6xC4BiiR520dk7vMR6L8iEQBlwJO78QXpF4gfID+dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984433; c=relaxed/simple;
	bh=uaCukzmhBdi8QxY4nAWm2IeIcesiswJg0GWcKE1kjBk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsP4dm8sK4JScq/gLQscBkr1LZSLf11z+EnDe7sz82N2I5KHLpu6qBGpYfXnT/o0uEtlbz3+EDfEnbaxOotNZx636VmehuEhJO7I4hVdJI2T59ZDxhW+uRgHsmEtVIvpKlcp8VUN/8ztK56q7h++UfokHPFC3xXbZL4n6J4fb1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R//jSNiU; arc=fail smtp.client-ip=52.101.72.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2xYe9Wf7RmnkhH0g1MfSjE25EAfOZ+MI/OrG3dbWjllfynayedfHwK3gumMoy19xHvZcFyjmLRI+YS5usndom0891a74yQ2bnCENAxHhAM49kPpBXg6euQ5e2LtmMJiFcEx5vYalFO5c81S7F1ooMQqt0ElMmUXTytaV3bYFEMXY1xun0MYHtCWxDja6Jr5OuebYDAa+HgLYsCmGsUMVxstIn/YG0ta4Lh5zKW5uynv8pkSKD4zbbKxzErcbpWMHwl405iEAr0InVUy8j+gkh80sbHHaWh0TQTCPaejbgMXXkwJZBft9IvGNRIMR9V+2BbbUMw/aET/d6jY9ASW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaCukzmhBdi8QxY4nAWm2IeIcesiswJg0GWcKE1kjBk=;
 b=JC3n9NF6+RWv33HZMMGu72FfbU+OyggHOm4jzWvZOd9Dx/I3PeTps+9tjIk8FuoI1D4ufmFj6Peefh/nhBQiilyosWm+vpP140AeYyLFNHGDFakSrOj8J/SSn2RVqtesePWN0ZzTdnv2YrJnyXMhZ+b/6GV+f0sdJo4T3boUrRLyv+sdPJ73aqY28ItPEJhr3yFpqyJLMENyNqIEtLnoPlyYa8xvmvs4/24OFhhxTfQ8mu7xLtcFGYbdduvH89daETu4kDYphol770mm11o+pKD6dxXuJWEY3Tym7wq5qd5feEWcK+OzUz96U0XfZgsLmJxIbeIyFljDNzNI4t352g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaCukzmhBdi8QxY4nAWm2IeIcesiswJg0GWcKE1kjBk=;
 b=R//jSNiUWcWtfgDQExBCJW76cFgfG2LBEgt+hbqUki12X5i3z5uqTzltudS+GR+0p6+/B/7uRPVp0qbMC1nqLeZhwit1menz+EwpUWeTAikXSmb5+xHe+JZUTpaovcp/IE8MPAj8ddVAqOXcp68AscUx5T+IMBcSZ0FCie+8YUFzQEo6AWbhm/sQy4eoWG5ijYCLOqTldJVH/s07rWCv2Vc4zGv2O8auZz1Tv/9i+UYBe3JJDQeLdrnGwPTVMEh96kHRScm+7kXBQT1VGj5L6UslSElcVX5Fhc9QhTkiJqg77YNzbv9UDg2pJbUbVybxDWxeoWTA/wY4gbdjr+GW+Q==
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com (2603:10a6:10:2e3::6)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:33:47 +0000
Received: from DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1]) by DU2PR04MB8840.eurprd04.prod.outlook.com
 ([fe80::7c5d:60c1:2432:86a1%4]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:33:47 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v9] PCI: dwc: Don't poll L2 if skip_l23_wait is true
Thread-Topic: [PATCH v9] PCI: dwc: Don't poll L2 if skip_l23_wait is true
Thread-Index: AQHchTCNV6lEpDLsWkeyUv2pgGdgkbVcS8+AgAAK9RA=
Date: Wed, 21 Jan 2026 08:33:47 +0000
Message-ID:
 <DU2PR04MB8840183790BC22DD09E720038C96A@DU2PR04MB8840.eurprd04.prod.outlook.com>
References: <20260114083300.3689672-1-hongxing.zhu@nxp.com>
 <20260114083300.3689672-2-hongxing.zhu@nxp.com>
 <drqhmcl5vzuk7dx5g4fjhrsfstu2tssmmotychgyf3vcus2tz5@rqsrsrbpjc2o>
In-Reply-To: <drqhmcl5vzuk7dx5g4fjhrsfstu2tssmmotychgyf3vcus2tz5@rqsrsrbpjc2o>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8840:EE_|GV1PR04MB10105:EE_
x-ms-office365-filtering-correlation-id: 0c8b5bd9-ede6-4d88-916f-08de58c7cbea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?OUJTOGtQTEhjN0h0V2JJRDAwYjQrVGJ3ZGYwV0I3UC9VaytTVEk0cW5lVlpN?=
 =?utf-8?B?ZEpkNDdCUnNxSzczQXV3K3ZQNUVWWFpnQjcwWFV0bzlPZGU4bXRXUnExb1dP?=
 =?utf-8?B?dHJpUWdjUXVyKzhqQVV6cnRNR2NLRTlIcUpsUDFPU25wd1RaQjZlS3oxREpw?=
 =?utf-8?B?eStVM3VmamFmdU9lcUxreUtES2lqOVR2em00MjFWYWlzQ0FGVjdUWU8zaFY2?=
 =?utf-8?B?V3RFckYrdEtBVmxLUUZ6b0RCVXZMZFFuRm40TE5DWFZsaStOUDhVczRBcjVF?=
 =?utf-8?B?WFgwT2hiK3IyRXNFZm5oQlIxTmo0TjVLMC9Xdk4wSmlVa2YvRVVpeDRTQnNW?=
 =?utf-8?B?Q0gvTS9yU1pEUTI0UHpQNXRIOHZHUGdrNEN4NlA5Ums0Vm82eXFhZTN2VC9a?=
 =?utf-8?B?Y1BKMDhzT0MwQjdhNVU1UW1xbVZDSkgzR3hCOVRuN3l4TjNBY1l1UWpSTExB?=
 =?utf-8?B?VE4zU3hUMnhtRlBLbmVVY3VvN0U1dnVzWUVmV0ZVZlk5TVl6SjY0SWhHdXBu?=
 =?utf-8?B?eDhqWDBtUXIxMzNQd2xtRHg5dmZoYWNDUjBEUGxzSXAxdDAvMWppMmREMFFW?=
 =?utf-8?B?aVlzdzdwcERHNkZBa1FDVlJWanhJZTBvVXZxUlFyVWJEV1dZNGx0cm9pQXdk?=
 =?utf-8?B?d0RJMkVuSGhaR3oxUGd2bHQ5TWJCdmcrdjFMdzFwSXd3V2lwOTROWmlJcU0w?=
 =?utf-8?B?NncyVG9COVZrdVRVcUxicHgrNEtUUkJWcFJRc09pSk5MNzlkT29BYkdmdkVT?=
 =?utf-8?B?eHNtbHdwQjFqTjh6UStGVUZDcjdVQVRkUVo0V28yNEpDSURnTjBtekxtdFdY?=
 =?utf-8?B?VldRL2xPVVp3eWk5OGVKdndTdXY5Y2UzZ0JaUHNvMzJVejI5Tk1nZUpUSy9t?=
 =?utf-8?B?blFSYUY5YnFlQ2pQMytPRytzSXNNazdWdXJyVjR3bGJHSG50VjZBYlVXRndW?=
 =?utf-8?B?dU1XYTYrTlhVUEVoU3ZrRkMzcHVsdmtsMldRa2lZM3RJSmxDQlE0cmJINWcv?=
 =?utf-8?B?OStOL2h5a0I0NFVabVIzd3NMUm1DcXVaTzJXRGIvTmN6cWNuV1I0VmZ3ZnFZ?=
 =?utf-8?B?RWpqY2FBT1o3ZUUrTlNpZ3EzQ21YbmgwMlkwVm9OSExudTFSQ0Q1M1BsU0pY?=
 =?utf-8?B?c2NKVDhFV1J0bU02M0xKeFZqQlhHUDVpbFNLQ0xOWWN4ZGVLSFBCNGZJZ3J3?=
 =?utf-8?B?Um8yTitGQlcvNUxUOWxIKzd1OTB2VjVZYXpVNHYzZDlXUFZrNzl4c3preC9k?=
 =?utf-8?B?NHZwUWFSNll4OWR4S29hU3hlVVBWdjE1TUZMbjU4dmxwRU1YMFMycUpMQmdy?=
 =?utf-8?B?R0N3TDVWWWVUaTlxbHVkRXc0RVUzYjIxaUM2NkFjMHFKRURhY2Rrc0hQYVJ3?=
 =?utf-8?B?WnVnU3pLNm00ekQ2dUdkVTdTZUw4cmN5WWZiR2l0SEU3NXY1NmpjaHVCY25j?=
 =?utf-8?B?R0JSeVBIM1VpT3U3WG53dmlzeDBrQ3g5a0Vpc2VMWE94Ukl6NU9vS0p5K1lM?=
 =?utf-8?B?OURjTDhTdVRKeFRnMVc4QitWcFU5dlJidmtJSTFsdERKbzl2ZHY5WUo0azdt?=
 =?utf-8?B?ZjY4dnJQSnpJZyt2MUVvbDVRR2hTSXdlQ2ZFWHh4cVJKTnJLSHRKTUtXSkZX?=
 =?utf-8?B?d0ZEOFRnblRUTTR6Qk00VW1OUXBacVNJSE40OHdTSFJMOUJWbDBWdEJFcFZ5?=
 =?utf-8?B?TU1yY1FuSjk3bkpkOHJqUGNxZE40N0cyV0tvTm5YRFlSSW1vakgyenpqQUJs?=
 =?utf-8?B?MU83YjVJY2Y4SFpMdGdEOFhMOHg4STJEYjJSbGJYS0ZBQnhmY2txQ1NnTCth?=
 =?utf-8?B?UTR0eXpjOS9sL1ZSNHB2ZXN2NHJwUDlkZFFGWVRDeno1RlVhdXRuZmdCUVJQ?=
 =?utf-8?B?ajNFakpIOVlLTEVoL0FxWStVMTRXenBvekZKczNueE9wZHZEL0kwd3FLc3JI?=
 =?utf-8?B?VTJ1b3ZRcFhDM2k0Qkc5Z1kzRktnbjM1cFR5VXFsV3UyRTdrVUdoQmk2UDVq?=
 =?utf-8?B?aHkyMC9jMmVrWlVaaUFYK0JEYkxTdTVCcXhGY3lqRVpQdGhqWnk2NEZKQmdX?=
 =?utf-8?B?VXVsZ1F3RWFwdGRwMHYwRklhWmQwMG52NUZ3aEt5SnUxaUpxUVNuNklWM3Fn?=
 =?utf-8?B?eTRrRTJFNEhSNkY5NmhoVzJBaEp6MGg4R203MWZkRDhUdlp4UWpWT09iK3J6?=
 =?utf-8?Q?En/9BxJnur9zrGOCjKp1LaQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8840.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDZEYVpEaFptTThaNWlLWEQ1aVhYZGkxMWdySHZGSnNscWEwbWZMcXNhVlQ3?=
 =?utf-8?B?MklHZk45ck1PckJjSnZkNmRIbXVJbVZPL1pxVzloMGk5SXRRSXI2cTFIWUpq?=
 =?utf-8?B?MWVHdWlBTmF4TjlvNE5EaktMY2hDVlNTaEhWM2NaSXcvSXZ4cWdWSk1VV1hs?=
 =?utf-8?B?MTlDem01TndrdWU0MStLeHJKSG9zS0h2aDJPUEQ2dHdWZkdaTytSWjJMQ01n?=
 =?utf-8?B?L0h6Nkx3ZWc3ME1IOFcxZEZYLzRtTFk0dm5LQWxKdFZhbmdPdlNiRktySXpl?=
 =?utf-8?B?SkwxQzl2VnM4eFZ2cnE0UnJKM1hwV21EQ1lvZUtLOHc3b092UWtxbHplSUdU?=
 =?utf-8?B?ZnAxeS9XTHJtZXpaK0JYRVdBaDVYb2d2dzhPYWhNSkc4VVhmU0RpWXhyNitp?=
 =?utf-8?B?NTlTWTFTMTlDQVoreXR6RmZDanBZblN1a1poRFpERTlYSjcxMDZpQ25VeXdn?=
 =?utf-8?B?cEJXbGh4ZHQ3YnBDdWtubzlETklXUTFnbnJsbHpUeWJMbmp3WXFJYTlSb1RC?=
 =?utf-8?B?SEI0c0s5Ti9uWTE3NjJXT3Y1TUJyMEhEV1cwWCtJUkZEM2JaK1hiRlpyd1gy?=
 =?utf-8?B?dGtEbjdtKy8vaW5mcW5BUkVMU2xSeWZOeEZwbHVEcUd2VjAzdEVnOFdPclFi?=
 =?utf-8?B?eit6bVAwMDl0NVdrcDhpcDhialRHSUNaUEZwWmhVSm81Wk5kNXJVZVhydlBM?=
 =?utf-8?B?bzJTRnplQ1lwWmEvcVFLWWtvRUh1ejBZKzdQQjhEd24yaDlIY1ZsOWcwaEhv?=
 =?utf-8?B?VWVyZjYzRlB3MXdseFM5TFhtOSt6UWZIQlRiSVJueS96WU03U01BNXp0YVpy?=
 =?utf-8?B?NjU4b1VVd016MXFObTRQMFU4aWhMY1gvQlc0SnVjamU2eGJNZVNwa3RvaFNQ?=
 =?utf-8?B?WTlrYktwOTdxaEJrcjZDclFPMlFjTkF2QUg2SDBHUmlVQXgyZXV2ZVBEMUdH?=
 =?utf-8?B?ZE1iU0hTWGJGOTc2MUVzRkNrS2JtclkvWnZJV0duRVFPalp5QWY2NHhjeWR6?=
 =?utf-8?B?UU55bStPM3dTdzQ0TTI1SitmM092eUhSenErZDU2YVlOOTJNaytvQW1tNnFj?=
 =?utf-8?B?ZmF1VzdoNklFdE0zajE0ci9zL0ExcUFack1qUzZ6VWQ1ZUl3dEYxRjMvOXZK?=
 =?utf-8?B?VG8vazNmdXhLVjl5TnRJMWhXdlhXZHpQWUJ5SkttY0k5SVc4bFZaVHlQSXZR?=
 =?utf-8?B?eFJML1FEdFdDNkpQYTNwZm9KdEZlQXh2OXNJK2hwM3RkZEZZOHJaKzJzY0Ru?=
 =?utf-8?B?YnBmVkZxT2VHNHVBN2I0ZmVPVVI3YWVtUi94emN1WWdpMitjeU1IYmt2UW4y?=
 =?utf-8?B?YmUvK2VDNmQ0YUgzaFhpcExPTldnOHZHRGVoVGdnMWNGcS80WmYyM2E2ZVZz?=
 =?utf-8?B?QkRuaXU3dDJlY1JCUDRwdFhwQkRUNmdBejhXTUN3K3g2bEsvWHBuVUpqYW1Z?=
 =?utf-8?B?cXFVNUFjK09yUXU4R3krc2RlZk1saWI3YnRqYXRaVm5JV3ZweWUzOVk3MkRE?=
 =?utf-8?B?Z3pGV0ZPZVNiUXBzWkluc2x1aUpZQXpOTGlDbHpMYjdJNnlZNkxFeVBVNldC?=
 =?utf-8?B?QlJvQm9ON3c1eFFESGVadks0VWthRml5TnBHeHB6U1IxWjEyTTFKd0NuemtB?=
 =?utf-8?B?Mmkzd0lkd2pEdTVFSmtvc0FBa25TL1p6RlJ2elV3SUIzZkxETzJ1YVUvZW96?=
 =?utf-8?B?L0liUUlOSVRQbDEzclR5TnZQOTNHOE1LKzk1WU5QVE01STJ4ZG01dVdjS3Rh?=
 =?utf-8?B?OGVNMnJyZnRaeHFRL3RZYTdjb05yeGc5MnhMUjFjQmtyak9vdTFaV3ZlNTlI?=
 =?utf-8?B?YysxeERGQkN6dDBNTTIwbHhRTG5aVTJtM3I4d1FrclJteEw0bWpDOTEraEtN?=
 =?utf-8?B?aU44cGViZmo5bXdUOU9GOEU0M0lka0RDRU96d1ZSd2M0VlArQVpBSXdoNUNV?=
 =?utf-8?B?YzErRVcxQzlnaDc3RXc5b1FrdU5ROEtUYXdIVlVFS2pGenBwU2Y5T3d6dGRv?=
 =?utf-8?B?M0p2cnFHcElvRFZwNnViT0Y4Si9kM1pvTWprZzh2OHZ4QUJSS09IWXpjRGxw?=
 =?utf-8?B?UFUyT1E1dDZLalNkMUdYQlN2cVdkdWpjVXQ4bi9uQ05kb1RvZW5tbjloZUdV?=
 =?utf-8?B?SUowc2xrY2VRczlrYnJwa3RRcHFidGVpMVdUNnBhcjM4djF2SnNsWTJJTnhr?=
 =?utf-8?B?TGNZL3JpZ0VNL3V5c2FMaS9kT2JtZXRrTDB1c1FSbEhKaTExWlEycVIvbXBW?=
 =?utf-8?B?UzJ2Q050R04zR2N4Y1lPWk9KUjRmQTBsQTlGQ054RzZZcFgzdGJqckFNc3Jw?=
 =?utf-8?Q?BPsEKAFTQSCsmDj/fr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8840.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8b5bd9-ede6-4d88-916f-08de58c7cbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 08:33:47.5502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I7W/0S+Nn2xK/FHMzgRaaTgZjmVVmsss8UekKwmJ8HMcg014OUuSOBqASh8XxSzojfUDHRW4ZMJcO7gMpJYUoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210715-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,pengutronix.de,kernel.org,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hongxing.zhu@nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,pengutronix.de:email]
X-Rspamd-Queue-Id: 25C9D53B5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNuW5tDHmnIgyMeaXpSAxNTo1NA0KPiBU
bzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxm
cmFuay5saUBueHAuY29tPjsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+IGwuc3RhY2hAcGVuZ3V0
cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwu
b3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjldIFBDSTogZHdjOiBEb24ndCBwb2xsIEwyIGlmIHNraXBfbDIzX3dh
aXQgaXMgdHJ1ZQ0KPiANCj4gT24gV2VkLCBKYW4gMTQsIDIwMjYgYXQgMDQ6MzM6MDBQTSArMDgw
MCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gUmVmZXIgdG8gUENJZSByNi4wLCBzZWMgNS4yLCBm
aWcgNS0xIExpbmsgUG93ZXIgTWFuYWdlbWVudCBTdGF0ZSBGbG93DQo+ID4gRGlhZ3JhbS4gQm90
aCBMMCBhbmQgTDIvTDMgUmVhZHkgY2FuIGJlIHRyYW5zZmVycmVkIHRvIExEbiBkaXJlY3RseS4N
Cj4gPg0KPiA+IEl0J3MgaGFybWxlc3MgdG8gbGV0IGR3X3BjaWVfc3VzcGVuZF9ub2lycSgpIHBy
b2NlZWQgc3VzcGVuZCBhZnRlciB0aGUNCj4gPiBQTUVfVHVybl9PZmYgaXMgc2VudCBvdXQsIHdo
YXRldmVyIHRoZSBMVFNTTSBzdGF0ZSBpcyBpbiBMMiBvciBMMw0KPiA+IGFmdGVyIGEgcmVjb21t
ZW5kZWQgMTBtcyBtYXggd2FpdCByZWZlciB0byBQQ0llIHI2LjAsIHNlYyA1LjMuMy4yLjENCj4g
PiBQTUUgU3luY2hyb25pemF0aW9uLg0KPiA+DQo+ID4gVGhlIExUU1NNIHN0YXRlcyBhcmUgaW5h
Y2Nlc3NpYmxlIG9uIGkuTVg2UVAgYW5kIGkuTVg3RCBhZnRlciB0aGUNCj4gPiBQTUVfVHVybl9P
ZmYgaXMgc2VudCBvdXQuDQo+ID4NCj4gPiBUbyBzdXBwb3J0IHRoaXMgY2FzZSwgZG9uJ3QgcG9s
bCBMMiBzdGF0ZSBhbmQgYXBwbHkgYSBzaW1wbGUgZGVsYXkgb2YNCj4gPiBQQ0lFX1BNRV9UT19M
Ml9USU1FT1VUX1VTKDEwbXMpIGlmIHRoZSBza2lwX2wyM193YWl0IGZsYWcgaXMgdHJ1ZSBpbg0K
PiA+IHN1c3BlbmQuDQo+ID4NCj4gDQo+IEkgdGhpbmsgdGhpcyBwYXRjaCBzaG91bGQgc2ltcGx5
IHNheToNCj4gDQo+ICJJbiBpLk1YNlFQIGFuZCBpLk1YN0QgU29DcywgTFRTU00gcmVnaXN0ZXJz
IGFyZSBub3QgYWNjZXNzaWJsZSBvbmNlDQo+IFBNRV9UdXJuX09mZiBpcyBicm9hZGNhc3RlZCB0
byB0aGUgbGluay4gU28gdGhlcmUgaXMgbm8gd2F5IHRvIHZlcmlmeSB3aGV0aGVyDQo+IHRoZSBs
aW5rIGhhcyBlbnRlcmVkIEwyL0wzIHN0YXRlIG9yIG5vdC4NCj4gDQo+IEhlbmNlLCBhZGQgYSBu
ZXcgZmxhZyAnZHdfcGNpZV9ycDo6c2tpcF9sMjNfd2FpdCcgYW5kIHNldCBpdCBmb3IgdGhlIGFi
b3ZlDQo+IG1lbnRpb25lZCBTb0NzLiBUaGlzIGZsYWcgd2hlbiBzZXQsIHdpbGwgYWxsb3cgdGhl
IERXQyBjb3JlIHRvIHNraXAgdGhlIEwyMw0KPiBwb2xsIGFuZCBqdXN0IHdhaXQgZm9yIDEwbXMg
YXMgcGVyIHRoZSBkZWxheSBtZW50aW9uZWQgaW4gUENJZSBzcGVjIHI2LjAgc2VjDQo+IDUuMy4z
LjIuMS4iDQo+IA0KPiBEb2VzIGl0IGxvb2sgZ29vZD8NCkl0J3MgZ29vZCB0byBtZS4gVGhhbmtz
IGZvciB5b3VyIGtpbmRseSBoZWxwLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0K
PiAtIE1hbmkNCj4gDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBGaXhlczog
NDc3NGZhZjg1NGY1ICgiUENJOiBkd2M6IEltcGxlbWVudCBnZW5lcmljIHN1c3BlbmQvcmVzdW1l
DQo+ID4gZnVuY3Rpb25hbGl0eSIpDQo+ID4gRml4ZXM6IGE1MjhkMWE3MjU5NyAoIlBDSTogaW14
NjogVXNlIERXQyBjb21tb24gc3VzcGVuZCByZXN1bWUNCj4gPiBtZXRob2QiKQ0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBSZXZpZXdl
ZC1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAgICAgICAgfCAgNSArKysrKw0KPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgMTUg
KysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS5oICAgICAgfCAgMSArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
PiBpbmRleCA0NjY4ZmM5NjQ4YmYuLmNiZTk4ODI0NDI3YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IEBAIC0xMTQsNiArMTE0LDcgQEAgZW51bSBp
bXhfcGNpZV92YXJpYW50cyB7DQo+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19CUk9LRU5fU1VT
UEVORAkJQklUKDkpDQo+ID4gICNkZWZpbmUgSU1YX1BDSUVfRkxBR19IQVNfTFVUCQkJQklUKDEw
KQ0KPiA+ICAjZGVmaW5lIElNWF9QQ0lFX0ZMQUdfOEdUX0VDTl9FUlIwNTE1ODYJCUJJVCgxMSkN
Cj4gPiArI2RlZmluZSBJTVhfUENJRV9GTEFHX1NLSVBfTDIzX1dBSVQJCUJJVCgxMikNCj4gPg0K
PiA+ICAjZGVmaW5lIGlteF9jaGVja19mbGFnKHBjaSwgdmFsKQkocGNpLT5kcnZkYXRhLT5mbGFn
cyAmIHZhbCkNCj4gPg0KPiA+IEBAIC0xNzc3LDYgKzE3NzgsOCBAQCBzdGF0aWMgaW50IGlteF9w
Y2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gIAkJICovDQo+
ID4gIAkJaW14X3BjaWVfYWRkX2x1dF9ieV9yaWQoaW14X3BjaWUsIDApOw0KPiA+ICAJfSBlbHNl
IHsNCj4gPiArCQlpZiAoaW14X2NoZWNrX2ZsYWcoaW14X3BjaWUsIElNWF9QQ0lFX0ZMQUdfU0tJ
UF9MMjNfV0FJVCkpDQo+ID4gKwkJCXBjaS0+cHAuc2tpcF9sMjNfd2FpdCA9IHRydWU7DQo+ID4g
IAkJcGNpLT5wcC51c2VfYXR1X21zZyA9IHRydWU7DQo+ID4gIAkJcmV0ID0gZHdfcGNpZV9ob3N0
X2luaXQoJnBjaS0+cHApOw0KPiA+ICAJCWlmIChyZXQgPCAwKQ0KPiA+IEBAIC0xODM4LDYgKzE4
NDEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlteF9wY2llX2RydmRhdGEgZHJ2ZGF0YVtdID0g
ew0KPiA+ICAJCS52YXJpYW50ID0gSU1YNlFQLA0KPiA+ICAJCS5mbGFncyA9IElNWF9QQ0lFX0ZM
QUdfSU1YX1BIWSB8DQo+ID4gIAkJCSBJTVhfUENJRV9GTEFHX1NQRUVEX0NIQU5HRV9XT1JLQVJP
VU5EIHwNCj4gPiArCQkJIElNWF9QQ0lFX0ZMQUdfU0tJUF9MMjNfV0FJVCB8DQo+ID4gIAkJCSBJ
TVhfUENJRV9GTEFHX1NVUFBPUlRTX1NVU1BFTkQsDQo+ID4gIAkJLmRiaV9sZW5ndGggPSAweDIw
MCwNCj4gPiAgCQkuZ3ByID0gImZzbCxpbXg2cS1pb211eGMtZ3ByIiwNCj4gPiBAQCAtMTg1NCw2
ICsxODU4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpbXhfcGNpZV9kcnZkYXRhIGRydmRhdGFb
XSA9IHsNCj4gPiAgCQkudmFyaWFudCA9IElNWDdELA0KPiA+ICAJCS5mbGFncyA9IElNWF9QQ0lF
X0ZMQUdfU1VQUE9SVFNfU1VTUEVORCB8DQo+ID4gIAkJCSBJTVhfUENJRV9GTEFHX0hBU19BUFBf
UkVTRVQgfA0KPiA+ICsJCQkgSU1YX1BDSUVfRkxBR19TS0lQX0wyM19XQUlUIHwNCj4gPiAgCQkJ
IElNWF9QQ0lFX0ZMQUdfSEFTX1BIWV9SRVNFVCwNCj4gPiAgCQkuZ3ByID0gImZzbCxpbXg3ZC1p
b211eGMtZ3ByIiwNCj4gPiAgCQkubW9kZV9vZmZbMF0gPSBJT01VWENfR1BSMTIsDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0
LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0
LmMNCj4gPiBpbmRleCBmYWQwY2JlZGVmYmMuLjVhYTdmMjNiYjU4ZSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0K
PiA+IEBAIC0xMTk0LDYgKzExOTQsMjEgQEAgaW50IGR3X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1
Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJCQlyZXR1cm4gcmV0Ow0KPiA+ICAJfQ0KPiA+DQo+ID4g
KwkvKg0KPiA+ICsJICogU2tpcCBMMjMgcG9sbCBhbmQgd2FpdCB0byBhdm9pZCB0aGUgcmVhZCBo
YW5nLCB3aGVuIExUU1NNIGlzDQo+ID4gKwkgKiBub3QgcG93ZXJlZCBpbiBMMi9MMy9MRG4gcHJv
cGVybHkuDQo+ID4gKwkgKg0KPiA+ICsJICogUmVmZXIgdG8gUENJZSByNi4wLCBzZWMgNS4yLCBm
aWcgNS0xIExpbmsgUG93ZXIgTWFuYWdlbWVudA0KPiA+ICsJICogU3RhdGUgRmxvdyBEaWFncmFt
LiBCb3RoIEwwIGFuZCBMMi9MMyBSZWFkeSBjYW4gYmUNCj4gPiArCSAqIHRyYW5zZmVycmVkIHRv
IExEbiBkaXJlY3RseS4gT24gdGhlIExUU1NNIHN0YXRlcyBwb2xsIGJyb2tlbg0KPiA+ICsJICog
cGxhdGZvcm1zLCBhZGQgYSBtYXggMTBtcyBkZWxheSByZWZlciB0byBQQ0llIHI2LjAsDQo+ID4g
KwkgKiBzZWMgNS4zLjMuMi4xIFBNRSBTeW5jaHJvbml6YXRpb24uDQo+ID4gKwkgKi8NCj4gPiAr
CWlmIChwY2ktPnBwLnNraXBfbDIzX3dhaXQpIHsNCj4gPiArCQltZGVsYXkoUENJRV9QTUVfVE9f
TDJfVElNRU9VVF9VUy8xMDAwKTsNCj4gPiArCQlnb3RvIHN0b3BfbGluazsNCj4gPiArCX0NCj4g
PiArDQo+ID4gIAlyZXQgPSByZWFkX3BvbGxfdGltZW91dChkd19wY2llX2dldF9sdHNzbSwgdmFs
LA0KPiA+ICAJCQkJdmFsID09IERXX1BDSUVfTFRTU01fTDJfSURMRSB8fA0KPiA+ICAJCQkJdmFs
IDw9IERXX1BDSUVfTFRTU01fREVURUNUX1dBSVQsIGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+IGluZGV4IGY4N2M2N2E3YTQ4Mi4u
YjMxZjgwNjFmMjNhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmgNCj4gPiBAQCAtNDQyLDYgKzQ0Miw3IEBAIHN0cnVjdCBkd19wY2ll
X3JwIHsNCj4gPiAgCXN0cnVjdCBwY2lfY29uZmlnX3dpbmRvdyAqY2ZnOw0KPiA+ICAJYm9vbAkJ
CWVjYW1fZW5hYmxlZDsNCj4gPiAgCWJvb2wJCQluYXRpdmVfZWNhbTsNCj4gPiArCWJvb2wgICAg
ICAgICAgICAgICAgICAgIHNraXBfbDIzX3dhaXQ7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3RydWN0
IGR3X3BjaWVfZXBfb3BzIHsNCj4gPiAtLQ0KPiA+IDIuMzcuMQ0KPiA+DQo+IA0KPiAtLQ0KPiDg
rq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

