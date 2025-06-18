Return-Path: <stable+bounces-154623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D85ADE319
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 07:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB023BD8CC
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 05:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12991DC9B5;
	Wed, 18 Jun 2025 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="qDDPhAL1";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vmGcK6vF"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4E14F98;
	Wed, 18 Jun 2025 05:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225180; cv=fail; b=LTkP/HhPTspnRqr5auN1lm8YArlkpb0uGFM9/CVuIlliS167T3tvq+gxiaghrb+vhGKdTbH149iHfPLpzScmHHHWH9WcMEwskAeIIRBdbN13t1eu8gd2JHDVEFURhz90Ze7wrdHcGYKcUEIg9UcTbA9XEW2PnfQuUwKhc5iPB3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225180; c=relaxed/simple;
	bh=/z8hNvL9hQ7yZ4M05gSas0w5BSYLhZFY9biTvtzPi4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NqB7dunxGDeDKoQSURrv2XY2ys6KYKNsKgCYHNMoa4hz0sxRP0RtmItk9GaZuAvLW+EEYPofP2T0Nw/6xZLum+DBOmvl7XUE+9MScX79Dmp9fZ5PJld2HGxqC/8OfOiURM2lbHAmTgI5wNvS7hfRNXWnZy4iUbQ6zugx2pD2lPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=qDDPhAL1; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=vmGcK6vF; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HJau4A004319;
	Tue, 17 Jun 2025 22:39:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=moDxm9BsJQmcQZ0Zcrq5ddRbkyb2VryGtWGJoVh1++k=; b=qDDPhAL1HM4b
	Ozo26ow33ZPcggOO7VlrZDZKAubnKEBhKsjR7zme6JZAWvPn7VcUToI0IMOUMQnP
	hXhURSHmBs0P8xNIN9IWPQlgcBXMQ21szeXIPnkwWKuLDD8X2A9xAW1FVpCT1i90
	aQCU2bTOGoek3PzCmKZLE3ObvsgqBLSZ/igO+BPICA7WdnxVnhhAj+IZWLJ2usT0
	4Bm/qfBTSvXt8ERzOnbwakEFX0S/+Q5CbbwE5ut5+6Ao4uOQmLDLlGdnNvDS19ha
	rNyse3P+g/GxA++TJO1sXUxmI/gh+IlmnlWhk0Mwk/upEYexIyRKg+1NdCRKTYEZ
	dst6tCqxYw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 4795mxqs27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 22:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVdl6Y5ZuBinipOfNqoKc6I7lLlOeQSsAbp9O95iXndvY/qWQ3oZBo0Y20Y6NoYF1poS1mBbWDFKdEEdUdZEJo5wF8uZej3CLO1UsZrclrDXQK7Il4TyOmiF+8WMyUDQhhnMfahQTUIDyX/VMof1KRINI4J+oBF6OKvu422KByP50RJHQOerXUx/5HIlbOkkeHg6aDVpXcOW/7VTOQab7hAEX5u04Qjjg4+O8xmzP/UyJOKUj5+qkklr1XCPQYPhZEO+s9mNj35RFDMqp+9/sfAZJ76nk35Wfc+jQZatCSc19Sh20DbvnXiigkbSXrfp5FKaYuoHmA14DzGsM7IRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moDxm9BsJQmcQZ0Zcrq5ddRbkyb2VryGtWGJoVh1++k=;
 b=PPovoLa3eQba8shdyxH3UYcpti3K4KFQ8qgRosZTqWkvD+TTpm9dvMDoam9BlSO1RCyh2f+7vPnyBEfK5hscgFwPd9iBKxzwmh56gqqKdki/LQyqCnPtJmGEwSJpqweAVqcdM38ksQ9nnpyQrz1BvYGrUI7YS4QqaB2Xyp8pHCXEdNkFmZaLnKd3P5J5lESlXUAB10nU1av4PfRweGdkABHDfPycnRvEKwwTQ1n8ZBjomZ8Cze/yO4tyrsyuUVqtiCiGXbhu71P1/C4z2HRAvO+1kGMBXXyPNABeZXXtBnOKziLwTV2S8Smnh2TwOElZVnjbEegqOUKJihkE5+aKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moDxm9BsJQmcQZ0Zcrq5ddRbkyb2VryGtWGJoVh1++k=;
 b=vmGcK6vFdcXV2JIpSJ9qpEv5Ol8nt1w+4kZlpizuntAhvPTbYrkOH3KX5Xa+wFFeq567rxFxl5mk3Te2pi4wGcnXjwmFOqoPbEWd8A5IKbjzOhB9EqSRW/iFlB4o6hop6XcmoiHjTQK3EUli8boS0SaiYoYGepLtAqqfZz+c2ck=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DS0PR07MB10901.namprd07.prod.outlook.com (2603:10b6:8:1fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 05:39:28 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8792.040; Wed, 18 Jun 2025
 05:39:27 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH v2] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Topic: [PATCH v2] usb: cdnsp: Fix issue with CV Bad Descriptor test
Thread-Index: AQHb4BJdNoA3/4BZQ0yC09SwBbO6wLQIZknw
Date: Wed, 18 Jun 2025 05:39:27 +0000
Message-ID:
 <PH7PR07MB9538574F646FD0664C05B055DD72A@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250618053148.777461-1-pawell@cadence.com>
In-Reply-To: <20250618053148.777461-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DS0PR07MB10901:EE_
x-ms-office365-filtering-correlation-id: d84b0b1e-92f5-45c4-1033-08ddae2a7dcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zHuT1C/DGNBCjamdvpKTU+mLLJNoldssZ0PvqePCOuK5mjgTQjEPNrBqixFq?=
 =?us-ascii?Q?oIyTboeKB6AezlP40hfWBaqXX7uJb1/+/LwzpGBaFPnFIBHDHBsMG+7Ulc7n?=
 =?us-ascii?Q?zknv2CRMPR1SjhcxGRDInEh7dRTfijtuj/vOwlt82Zr9zvEDmkZQYpVM7CcU?=
 =?us-ascii?Q?vLgBa9YgMbLi30wzkcTnlI3j3rIyRSJ0AnypwoZsxYfgifemX5sjIfjUIjEg?=
 =?us-ascii?Q?HXH99E1UTqsPZQ1KY0bT2DFmwly5tzAOjabdm//FZPCUtdOabeJBqZx4U4RR?=
 =?us-ascii?Q?7ETDX8dR2rNh4UIUlYwqp6dRirRW7a3EpdFXcTXdICB3sQIuYqolFNWZ5Rcv?=
 =?us-ascii?Q?sV9K1pt8AQAdvAdkdiuCDglqE2I/nvb8Y3x2kwM/wOUzwwmNDXJrC6GFJDjf?=
 =?us-ascii?Q?Eg6Zjw28D/uFkNi32O9zbZpaNFkHr6qYtqclLsvFtBT2QjazQhZT44dnwPHk?=
 =?us-ascii?Q?hsMbjWtJJFK2AGcgBhR6wVQGwUJ2eAFwQbCglHXrjlO1AUAfn92gd8shNxw5?=
 =?us-ascii?Q?9QdStPC3JyuA4max6fAFfr1ivThZZc1Bhp7wMKAEaACRuVSW0rL75aHBs+9d?=
 =?us-ascii?Q?JndCVfON1WQBpkg+OMxAaYYDGcpbRCxKcwoMHxh9hE1pLjwssrtNlIyImeB7?=
 =?us-ascii?Q?+w5xcy2bxVl3B7aYX9DKJJZ9+I3NYoTBGTgdsiLsLSOGwqTFjMsbgh2LTL7s?=
 =?us-ascii?Q?pLJ74wMroMVeos6d9uTzBXjxb87yp2PeqhQeLCSKK2UD66lISN0JNwf+H6qg?=
 =?us-ascii?Q?HVmPFegfXgjBlRWMQF9rIfP6jtZ6k/5Vlbypti747HptzwaGV0R2KpyVRtRS?=
 =?us-ascii?Q?mADbfMh5uA3nfeiKcKxxFOLCe6A8OztzEdGt+x0X6fPr1CQlCahJJ+YgH4fJ?=
 =?us-ascii?Q?H8Z1Y79Sfnfgli4LbevkshKFE5V2Vuc7UfXF9pKU4u/wiZTazEGrrdo2jjOt?=
 =?us-ascii?Q?2s8uihv4pmOsZl6lyFz/EpUhr1ylvO9okzf6bldy6hvtQHXTbEVGspI2UsXB?=
 =?us-ascii?Q?a35eCAjVCdphywax+t9cWNi8/rrYuA18ujLZ4y2PEJ4EUSb98p/ahgaXfjm7?=
 =?us-ascii?Q?hbmAN/vgd8SXmrjW4yfwHCTpCvU6Akmi2yPWaVKr9Z+x0u4YeewwtI7/7DrS?=
 =?us-ascii?Q?6i/49Jl4D0IbSeiVaTixLT7pwJPs2bng8lSbIWNzQYMfaFJNzqC4BNi+W1eP?=
 =?us-ascii?Q?1UnE8COWrDwY6l8XxiEvMcBgFsj3BiRIBHMdjF8G9EVDx/xpOHQa8TUpyNwY?=
 =?us-ascii?Q?dC7PgAaM0+JCbLCFVxbwhjJGcVEvlk1Wqg4IgMUZwuhDQT+mRGWHePsHAY2O?=
 =?us-ascii?Q?fWrjF+AD+J+kpURYMqDFAcdf1xP64N9msisSoV4JKPgaT82xyxM0x/gXlPyS?=
 =?us-ascii?Q?TauS6UML38RgGtBz3LEBDNLI0CSmVBX2i4t6qRl09jZx5MUYmdFTQVIeOk5D?=
 =?us-ascii?Q?V/vrpBshXb1L9gyfxNIxeUjILM6ARhgvpo7okAoW4+pLQOX/O4jWeQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lllPt5F9bzyBZ21erEXDjkMRNbTjl8hOQKOH+mFydcXsjGYeeJNvhr8WDQqr?=
 =?us-ascii?Q?dNEX8IgkVWIhgH9LTL1RJDxCbG36iVOqt8aLq3RS1cT9p9Ko3bwaEgH1Ezzv?=
 =?us-ascii?Q?FPLn//I7pFgyt5nH4tkHHrW41tUx5mjh0pybe0klO4mFR6HG9/q363eK1kLp?=
 =?us-ascii?Q?SSPckCdL/2apJ+98x1XEhL9TbZmXQI5y816Ob4TeT2M+qj0vbjYVCOi+WwB5?=
 =?us-ascii?Q?OYvzk4btgAUbaliBpih/0pcZ8UUZrDDASmqKcyeWPIfYKDublD/rqPIEU2YL?=
 =?us-ascii?Q?WBEaN8o6FiYUs2RMhEbBYPGhat4u8ZVQUoLa8EF3yC/+vaLrXaPhw6TZwNdq?=
 =?us-ascii?Q?g7PjdWCjVg7IOJEKP9y1MSzfEp3iiMwLbKblL+z2Sw88SbzPZj1jvJThwLw8?=
 =?us-ascii?Q?VhIJJM/myB9N94ABVOmwjpXTZ+X1HUVpzmkKJilm3kX9xU9Agk1ApuhLgKeC?=
 =?us-ascii?Q?kljbCORwfwPWQ7ulWFpVAE68yZmNuYnvNdwVD/a1ckSqT7ATsDxyV0Q2okcz?=
 =?us-ascii?Q?nZsNmkLuH4gp0DEBgSsz83h61WQ0bv7KP18FXnM5nFz4Dc+bqjf1/v+bF4X0?=
 =?us-ascii?Q?sjT9lI9EJbVXFCHMTd7foUi0TML9wdYVqC0xZH6X9kqK4A31OnO76zq+QFUO?=
 =?us-ascii?Q?OetFfHhZo8EQ8rqqnEg/6MIfqeLCz1SednayxRI1UK90zm1NGgyRoK5gW3qE?=
 =?us-ascii?Q?lKJ8cQvQk1q5xkoQZZZ5zF29WauTeeDpLohhucQ1mkUR7WlcHd/o3MepbaLx?=
 =?us-ascii?Q?8uzcQYMZwdeiqHaljV67+jkRfYTaXmBx3PTB8lF1AWW7rRmlsLfs/at+AFbQ?=
 =?us-ascii?Q?xkpw3lCmoTE7I5EwJFn0dir1+Li0UwfPcGFcR7NnGHSXmiuYjPUa3jMpF0sf?=
 =?us-ascii?Q?Dt6Lf242soWDAWNnV0Rc/kuIeXHKdGCh99FrlFtTzzHL8HZlHW33QmlzLKDe?=
 =?us-ascii?Q?smMBQaaDuHKUNIDfTEqc1hBHn9LJYlGjHDokjkkHGxjz0nfWuRgM+mpNa3bn?=
 =?us-ascii?Q?6sODsTkEW9rUTxtQC0JhcGDINYqoUN9sKrGLvfb4zil4cWyj8oZBPFs1ain2?=
 =?us-ascii?Q?iisg209kYUIXbjYlpEPEMkLxEDmmEcZ/f23D9vut6x+gI4qIcDGazCsKkX5V?=
 =?us-ascii?Q?x1Zvo32CR60WHc543Vkt6zRCgRzxxpOz5VX6xLn2SbUDLGP3sPO+0vT3+sE3?=
 =?us-ascii?Q?9ze7DUebRT4bdZTZWBdq1gShJQCNv38UMR/8Jqg0owftj1EEf5UbB4iR3V5D?=
 =?us-ascii?Q?I1xa3LHqNeM6bl8u4GVpSyL2o0mIoxocRqOlAp6wyam2usH7BwVfokd62Oo9?=
 =?us-ascii?Q?T+uj81+/sF+XNJEgCqee1rJa2u323oGjkz17oUf6P0o161uXoTWqbSEVWW02?=
 =?us-ascii?Q?o/k8wqPZLv9idwHZ1tGCt34b+LNBCrLMiRa7f3NLV6xIDLqKiHvB8l6r1ux6?=
 =?us-ascii?Q?7hnPy6QdsIdiRyPWwRYWJGqr7UPWNyRT801H0HHVSCImJZUHOp60bEuFedEj?=
 =?us-ascii?Q?POsOsIEotBpu4HN73HxBABuoD9S9a1PwCsHv4ahpKHAtL+KoOd2BdqPFc0X7?=
 =?us-ascii?Q?tpl//H0gu7wm1eTNjLZ3la642Y7IPaywflQ4dMjX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d84b0b1e-92f5-45c4-1033-08ddae2a7dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 05:39:27.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrAN+JHtisJ26lTiVzcQAGSfJYDN3pF5eq6Go+n7WnlGCICsbDgdDt8nNRyUY5aSRIMc0PldDAc+SbaFWy/xJZzRKGQaaNO3FU94+tU26Jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR07MB10901
X-Proofpoint-ORIG-GUID: aR40H3rJiitVfk9y5BgIcDdE-gGcliVU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA0NiBTYWx0ZWRfX6wau0J7Y8q1/ /g21IJ0FBR3IDVVF/Lxdr2vnczJJgQJfM2Dwx/5UFdREgwYYJxCkZcMkEWMdShTj+jFQSbYiFR8 EZKf1ZueEjNOY6yFxaxQRbHq0KuQWIg5zKzUEtVFaiBRqHUzUdTXvKzKLUWz9rm/EeEvYgooCrh
 GKh/EhLfhR/WhUUL7VIVNi11bGCWLhD3dq81phBV7wWQuh6cMezm/kQTHYFD9pNtcElVZkfudvy FMqbTYPun0nIgJGRCdt4lsAvzBSE4HAENjiHXO7fFBtVXjvPSZSmfBp1zNEuOSfJ5iV5mOYjP4z ipAF5Tjv4MmKjqYUb0HSXah2ZJD998Xy9tlBiK/4zCytwcLrVVNJ6ilAWUcLKJYug+XbvvGfSpH
 dko62eBetEI90Hy12n+XaPBDQRGUjPVc5wq2QHWNm+jmlq/aLH24njyBaK4ckkGgyW5V8aFM
X-Authority-Analysis: v=2.4 cv=Ks5N2XWN c=1 sm=1 tr=0 ts=68525115 cx=c_pps a=mTK3PmBKiS78iTy2M0NrJw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=MGusajUyK0823r2cBs4A:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: aR40H3rJiitVfk9y5BgIcDdE-gGcliVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 adultscore=0 mlxlogscore=761 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506180046

The SSP2 controller has extra endpoint state preserve bit (ESP) which
setting causes that endpoint state will be preserved during
Halt Endpoint command. It is used only for EP0.
Without this bit the Command Verifier "TD 9.10 Bad Descriptor Test"
failed.
Setting this bit doesn't have any impact for SSP controller.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v2:
- removed some typos
- added pep variable initialization
- updated TRB_ESP description

 drivers/usb/cdns3/cdnsp-debug.h  |  5 +++--
 drivers/usb/cdns3/cdnsp-ep0.c    | 19 ++++++++++++++++---
 drivers/usb/cdns3/cdnsp-gadget.h |  6 ++++++
 drivers/usb/cdns3/cdnsp-ring.c   |  3 ++-
 4 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debu=
g.h
index cd138acdcce1..86860686d836 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -327,12 +327,13 @@ static inline const char *cdnsp_decode_trb(char *str,=
 size_t size, u32 field0,
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
 		ret =3D scnprintf(str, size,
-				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c %c",
 				cdnsp_trb_type_string(type),
 				ep_num, ep_id % 2 ? "out" : "in",
 				TRB_TO_EP_INDEX(field3), field1, field0,
 				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				field3 & TRB_ESP ? 'P' : 'p');
 		break;
 	case TRB_STOP_RING:
 		ret =3D scnprintf(str, size,
diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index f317d3c84781..9280a7b97e20 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct cdnsp_device *p=
dev,
 void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 {
 	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
+	struct cdnsp_ep *pep;
 	int ret =3D -EINVAL;
 	u16 len;
=20
@@ -427,10 +428,22 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 		goto out;
 	}
=20
+	pep =3D &pdev->eps[0];
+
 	/* Restore the ep0 to Stopped/Running state. */
-	if (pdev->eps[0].ep_state & EP_HALTED) {
-		trace_cdnsp_ep0_halted("Restore to normal state");
-		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
+	if (pep->ep_state & EP_HALTED) {
+		/*
+		 * Halt Endpoint Command for SSP2 for ep0 preserve current
+		 * endpoint state and driver has to synchronize the
+		 * software endpoint state with endpoint output context
+		 * state.
+		 */
+		if (GET_EP_CTX_STATE(pep->out_ctx) =3D=3D EP_STATE_HALTED) {
+			cdnsp_halt_endpoint(pdev, pep, 0);
+		} else {
+			pep->ep_state &=3D ~EP_HALTED;
+			pep->ep_state |=3D EP_STOPPED;
+		}
 	}
=20
 	/*
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index 2afa3e558f85..b1665f9e9ee5 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
 #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31, 16))
 #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
=20
+/*
+ * Halt Endpoint Command TRB field.
+ * The ESP bit only exists in the SSP2 controller.
+ */
+#define TRB_ESP				BIT(9)
+
 /* Link TRB specific fields. */
 #define TRB_TC				BIT(1)
=20
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index fd06cb85c4ea..d397d28efc6e 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2483,7 +2483,8 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *p=
dev, unsigned int ep_index)
 {
 	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT) |
 			    SLOT_ID_FOR_TRB(pdev->slot_id) |
-			    EP_ID_FOR_TRB(ep_index));
+			    EP_ID_FOR_TRB(ep_index) |
+			    (!ep_index ? TRB_ESP : 0));
 }
=20
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
--=20
2.43.0


