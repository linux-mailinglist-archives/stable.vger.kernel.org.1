Return-Path: <stable+bounces-191673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D93C1D81B
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 22:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD521892F2C
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 21:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7E311978;
	Wed, 29 Oct 2025 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DOd+exIx"
X-Original-To: stable@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B12ED154
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 21:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774459; cv=fail; b=SIzVN1n1V5fsajNTgyYjvnaTQ/aQLsxOc6qMOg7Wiav29+w2dvO7ThqJbb5l1slfzXK4ZqL4XH6jAWJ+KIVK2qrab711aRAFUx8H3ylhw4iqzQIUG/4pfQjkCMkxHe26tuXiq1g+uh5hgY6GgfXyNyZ09NABChF+nsObSVYHN6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774459; c=relaxed/simple;
	bh=DbwT5YJqAxx1jXvcr4hR4u2mvO8Jug7TzOKB+S+GeV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2IGu+SFuBitKVlvuI3mvG9WDczHKAOvPF0m/jwufbFlTuBZ5FszxehRwMaLjMFRWgCSR9HLLRg3x+/SQmzwLud8cd8eFVzPxZucdiDAlAYP3MQ7cgsUs02Ex4CzUaIdlMy0ZIW6J7eYDB16tJhoQGepjppX6ru6OraYubs5R2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DOd+exIx; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iylq5eOO1qE+XJO5UjwnAtnJAJAWXcEfORXq5UOT8WXXgZEjbTStll9pzFeKYYF7pm5R5gPlkOEMV2CiUjHXWsstd+qUikyV26ummb9iUrMkLi4G/FKGfaAYHUC/pJaiQYuk70vZepttaJCsvk7EoI28I/fH5UrgjOemsDjMMel7CIKqGDs12VQHcDln4cPjhdJy8Wv6YxyFbCzCAT0ubweybT49MdR0N6wP5g9XjGKOA2pXOObi9nYIyg640ZBTzStPTyXMsoNkf1lAPNpzduaIXHv9sB3lNmh0oSENpmfPOSmM93+vZMYlzoCehsWeISoSm8/KHVICdKiuU7fuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMRBWF5DkHwcmKcUFtBoOG6NKWBys8CxiPZQfqf4R7U=;
 b=a9B0mLvBvA64XOUcXoEmVQe7JIbrf9eu4vWGtdKx2TdTdwKZ2Cxw417aStYbadH5jtFLrnsCKSupyRXrOLJtODO2BgoxOZpPcc08szfaowuxNDlicFsXnLHfbc3F5LhMlj3fOfCkYFNJFEJJwc6CpTdVMLdzT/L1zsjPLtrwgZzD11n7m8R2IIPk+vSZPQZqMvuo0ISnAguj4ffdXqu5/u6z7FASmsk2Qn6syOiXEkshBYSlgNwKcmF+4xzvdExmLAwyA0nIPG8tkQeyhW9kSGwAb6B81gaiAIA0/KUH45YV5tKT5eq0q8U3gsSGIdeJ1i7q9NrwdK6RYjMwt3E0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMRBWF5DkHwcmKcUFtBoOG6NKWBys8CxiPZQfqf4R7U=;
 b=DOd+exIxyY5HXKcEVVFQL09OFEVihgGamRu2xiQerXZAjDK10/QLRWreS/0a3RmqcEZQjCSb+wLjtGYhb6fmOEPg91oT9th0gW+gnoCDZbopTR2OMh5uajLpaWby/hAuMOPLdgiNLQUp0cgf9ETBTAGVQ3PIFjsVZqlwwCPvrBg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 21:47:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 21:47:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Salvatore Bonaccorso <carnil@debian.org>, stable <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: RE: Missing backport of 3c591faadd8a ("Reapply "Revert
 drm/amd/display: Enable Freesync Video Mode by default"") in 6.1.y stable
 series?
Thread-Topic: Missing backport of 3c591faadd8a ("Reapply "Revert
 drm/amd/display: Enable Freesync Video Mode by default"") in 6.1.y stable
 series?
Thread-Index: AQHcSD+UMKApCXgSjEeXzEB14ESi5rTZqpwg
Date: Wed, 29 Oct 2025 21:47:35 +0000
Message-ID:
 <BL1PR12MB5144C73B441AAC82055D9A6EF7FAA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <aQEW4d5rPTGgSFFR@eldamar.lan>
In-Reply-To: <aQEW4d5rPTGgSFFR@eldamar.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-29T21:47:08.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MN2PR12MB4470:EE_
x-ms-office365-filtering-correlation-id: dddac70b-a822-400b-3ff7-08de1734c5c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LKjxBwf/Xw2D58Zb5sZEFaBgG1+kTjWN6eSqTy1YFldBuEOTJBzqhfErdNmD?=
 =?us-ascii?Q?HpZodvkBRBGGmGjnxLe2AkPKPByAhPXx0m2RmrDU0hRsdq1YQwOfPn2ijj8E?=
 =?us-ascii?Q?h9ZpWEKxzQQs19HWVSmfa0hYRgChnJ1fcIrpBMV2GZFwy3dCKsWjN0tSV9RS?=
 =?us-ascii?Q?Wdq1cbWb+rb3ro93deRx7yBxcLZTiMVoB5KRtRw/mZmd2+WM3hif6gM00pI9?=
 =?us-ascii?Q?GUdktI0m6uZpwtuabpKrYlWfcTwNvAnU8yQ089L38px8Ru7dWlHmuXccYTtp?=
 =?us-ascii?Q?j4exxHMxhwUdtvOz91wTh5Rjpn+HkN6cBBVBsK2MEfL1CBYn6UVBfKTr6bPC?=
 =?us-ascii?Q?LcfbcJVArithhZavuxtqRA6uKKt31x/9nuPv9kg9Qg16lR+gSf1WXG/fLFwc?=
 =?us-ascii?Q?/21a1m3nqd3tI0b2xEn+pvKFVFC5H/4iRjymEeKhPZKemNhna6SQnQNFj1ei?=
 =?us-ascii?Q?GEqhXnHE3K1IklTq8Q6dzqWbrFm4yeGJLPpGJeTTjDQHIVQWOqZhlEYz0kIw?=
 =?us-ascii?Q?mal+B+ZcSEGkSvynjzOwgu1+UfnkzksAujr0fv+d+7F6K0aQI02xbaiWHw2K?=
 =?us-ascii?Q?6/QMPshBjJjBpRc8zePIkPWT5uOaDSf3E+AGIuD0/UOu24b1usqTi26EoV0K?=
 =?us-ascii?Q?PWL5XM4e6Qe34Il+7wfX1YjoX38GNyBNSDIrK7+Rc6iycgRFs9ZO43uFQND2?=
 =?us-ascii?Q?xU08hNdPx84d6mcp9qfC47pmUMMii4vi2frx3EgRjivRpnyNW4PPljs7M5NF?=
 =?us-ascii?Q?SBY9CdTrt6O47tkm+VAP9JxM9jg+nLrtmX6BlYBn5EYMZFaaJ8nReSVskojr?=
 =?us-ascii?Q?1Ct2Eqrq2m50GqqCaE7r4S5EQCk8qMUS1Hl5AAESjm5qkT2qFeIZUYu2+taY?=
 =?us-ascii?Q?/tBPBsBTdCdPPFYOcIemsz44Gc4A3TdzPDFkHGp7XBbhWOy+5pYAbRTEZRMO?=
 =?us-ascii?Q?evnGGtOT3TbW55ocO5c++DNBgf75d4n8YHVlhQW236FikczX8QBWSCJ6Z0ls?=
 =?us-ascii?Q?qAMhoh6Ms7PQXkL+B14PEa2AeGF0yvrQvNY57JRbujRt498z6B7M1aPBQXEF?=
 =?us-ascii?Q?qs1nXZTOjsJ1tPUTBgG0GvYjd4ptRJN5yYl7yPBaB28tYioaEUBBWnlbbk9R?=
 =?us-ascii?Q?1sm+gq9H0N07k3hBBXc503Ci8LGB6yIfrUOLJFHjcXLTwbNC4RCTIrsKz4gJ?=
 =?us-ascii?Q?PhqL0HWebUQuXw3R5FBcpcnID6fha8/j1RGIYKsZhps1UAimCd2BHiQfCUnY?=
 =?us-ascii?Q?vybP9fahX0+mwQe+h5YP4xWKh0fA09yB6YQT/MkyuI8YM7Lio6s2E08gtMHu?=
 =?us-ascii?Q?JqMSj6DEd9Ic/CFY01f8WMfryfkmntcsbeaKxXtCQ4+En16C3xWRQMDvfUHq?=
 =?us-ascii?Q?bR+JW3TbnNdPq1NvYqy2NUNbiM4ruI1znrsvkR3X8hq10qztEG2gpPnJlI29?=
 =?us-ascii?Q?yGBWDgmgia56JddYJt0PBRsxxnRNqHaFMot1/JUgmz0vMz9ZIzINNjqsB+5N?=
 =?us-ascii?Q?0iWwBC5aCPuTpLYMDcniddkN0L6muC+JOVBk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oZCz7+bxDzmL0pGAcwxGRZupSpOVlcDvqpuYpSXsMB4n0dxLtZRuCHzYDmaq?=
 =?us-ascii?Q?mGwjSRL6GwSU1XUfRA+m/riEzemURb3UvJkrjDA7xnZgCltmtpGJpYCY392r?=
 =?us-ascii?Q?BTi6+AR1kP8vVQvGx8cWDmKqNwH30By95YQ5U/xL15KvRHQbvJnloseFAePP?=
 =?us-ascii?Q?eXb2BZQpS6C5769vq5hPZKp8nJiU1fpN/KOkfV8tfhk/EuUKWxfQL65lJPt4?=
 =?us-ascii?Q?O7s/NNUdncRLLm+2JXzTlqtDMaKBt5x98fAZwmJZi7B5kUzAzOTtXkv7sM6Q?=
 =?us-ascii?Q?1QDiH6yuDihWUBtLrLk7SQ5siQFbboY1sRE4Z80pSmIMKFBBvCbGK/lxSAg7?=
 =?us-ascii?Q?WPH5HSD1ddoS0GRhM61uk/9AbOntWB+KEfj7hSLhNUZcztk55hOW/GVRvHZB?=
 =?us-ascii?Q?oZDN3pkOC0oCXZPhIhnUBPe2Z+8OtFg+hMQt6b182fp37ROruV6jooafpYXD?=
 =?us-ascii?Q?kMhMgeMgw/8mD7EsM7YD7JTKNilnywxfr42GarU3ywMutFBQsRA7gXyWzZTf?=
 =?us-ascii?Q?Beflui6GaU8EBj5Cqk6veHCHxrMU7+UjWg2cDojIl3yqfrnOPIRgX4MVzW+h?=
 =?us-ascii?Q?I1grDZL0xtbu9TLYxz3rhHlCw3Vxutl1uKMvhaTTMPxOW8Fie0FxSzcc6ULs?=
 =?us-ascii?Q?SSI6QMyHxGYrA65W2bSgb8HeoikmH1Hy7beKUvS7Q1m2lqPMHXCcSARNpL5C?=
 =?us-ascii?Q?dkIEeL1nergaxZK746KweMj8CiIHjCkmPtlvBXaykV1ySVxIA4n5euMWVCyB?=
 =?us-ascii?Q?nTQHttPh0TVqlLU2+6xgCagpNeREsZ9Nvm5NGW3hRdBpl06IbcdR1un9BVEl?=
 =?us-ascii?Q?liiH6KiC4imQtBO+2NHGdnr49PZoWbhVsDUwhLFoVAdaWO9Kb6C3OlzGiCJc?=
 =?us-ascii?Q?Ec2rL75mviAUObgq+RH358E2ieOzT9kNfTTMN6UHOKEtexLYQG7809Kb+1eC?=
 =?us-ascii?Q?Yk8adM/AHIajBaVzoVW2mkjK966UlAL0ZYQg3Qw/Z34UCAo5srfJXLLA37WF?=
 =?us-ascii?Q?VWWRcblmif4wAY8IPSx5xEttEMeXic+PGNQquVPUQnH1DCOn10XyaY1p/w6u?=
 =?us-ascii?Q?nJB3LqIRNGJ/1JPy5r0r7p3/FtD+uijuXNxKsNpjX39lrlQmmSW7n/VGXHsI?=
 =?us-ascii?Q?fTN5+RIHFfA0/CcaHJFSrvlh+5TeBYq2NlevTvVX73yc1qMJXCI/hcyGBOOr?=
 =?us-ascii?Q?xPmJvsULhpKaOE594Rtm7w1v1KR5+hrt1Z3Ia4oL+WeMap/tvNyolWfe8KQD?=
 =?us-ascii?Q?dJuKYlwM6wZC67izRDuUbKKouRq12DOsXR4MH9yRgGzsAVSJPkvowVf5g9Ir?=
 =?us-ascii?Q?mQUUfUzFqN4WlBUVzyKfk/nfDhkC4yrpxYvqKSdTIMVp16PzRpZBcP1HxvnQ?=
 =?us-ascii?Q?XRtGLPQeVfhxs7WTk0K2WzYthXeVtMjp0R7icWHbR8lj+FcLlF1Ji1z9w9Zm?=
 =?us-ascii?Q?os5l8Y50DvG8Hemqqne09DO/mrh6cyDGCMO4FllpWM0++cyw3keP6EvIsvbj?=
 =?us-ascii?Q?EFcfo38YWJjh4ShSMwHwrj+uAFeCfLRE7gO3sfHcR2wkHJnRI/74Q/3oSmtc?=
 =?us-ascii?Q?+LRWyzhx+O+sq1IY3hY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dddac70b-a822-400b-3ff7-08de1734c5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 21:47:35.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDnkYYaxPLQbLAF+GnZt0Uv1y8vrcACit3zEA7Rc454L6nUuAjugC4X2cvl93AZS7e1g8NwgLtkDGo7SQVsUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470

[Public]

> -----Original Message-----
> From: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com> On Behalf Of
> Salvatore Bonaccorso
> Sent: Tuesday, October 28, 2025 3:18 PM
> To: stable <stable@vger.kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Sasha Levin
> <sashal@kernel.org>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Hamza Mahfooz <hamza.mahfooz@amd.com>
> Subject: Missing backport of 3c591faadd8a ("Reapply "Revert drm/amd/displ=
ay:
> Enable Freesync Video Mode by default"") in 6.1.y stable series?
>
> Hi
>
> We got in Debian a request to backport 3c591faadd8a ("Reapply "Revert
> drm/amd/display: Enable Freesync Video Mode by default"") for the kernel =
in Debian
> bookworm, based on 6.1.y stable series.
>
> https://bugs.debian.org/1119232
>
> While looking at he request, I noticed that the series of commits had a b=
it of a
> convuluted history.  AFAICT the story began with:
>
> de05abe6b9d0 ("drm/amd/display: Enable Freesync Video Mode by default"), =
this
> landed in 5.18-rc1 (and backported to v6.1.5, v6.0.19).
>
> This was then reverted with 4243c84aa082 ("Revert "drm/amd/display:
> Enable Freesync Video Mode by default""), which landed in v6.3-rc1 (and i=
n turn
> was backported to v6.1.53).
>
> So far we are in sync.
>
> The above was then reverted again, via 11b92df8a2f7 ("Revert "Revert
> drm/amd/display: Enable Freesync Video Mode by default"") applied in
> v6.5-rc1 and as well backported to v6.1.53 (so still in sync).
>
> Now comes were we are diverging: 3c591faadd8a ("Reapply "Revert
> drm/amd/display: Enable Freesync Video Mode by default"") got applied lat=
er on,
> landing in v6.9-rc1 but *not* in 6.1.y anymore.
>
> I suspect this one was not applied to 6.1.y because in meanwhile there wa=
s a
> conflict to cherry-pick it cleanly due to context changes due to
> 3e094a287526 ("drm/amd/display: Use drm_connector in create_stream_for_si=
nk").
>
> If this is correct, then the 6.1.y series can be brough in sync with cher=
ry-picking the
> commit and adjust the context around the change.
> I'm attaching the proposed change.
>
> Alex in particular, does that make sense?

Yes, that makes sense to me.

Thanks,

Alex


