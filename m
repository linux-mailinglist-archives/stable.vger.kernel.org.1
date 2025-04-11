Return-Path: <stable+bounces-132287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E3FA86387
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 18:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12191BC066B
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 16:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3B22068A;
	Fri, 11 Apr 2025 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2GtdmOcV"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626021D3F3
	for <stable@vger.kernel.org>; Fri, 11 Apr 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389789; cv=fail; b=EsLuy8xKf4MuW47NyMc1MmajvdorizXs/hmec6SxKOf1A467dZYhJeB7DvcimC7eGlQMCXIrX0sL/vgetCU+2xjQBFgYxj6aQIq1dcO2qBXZoSEoNJNdNQRqe6pPrpbQxcVQBbxk/SlzXbB52CslXqQtTPRagwEEBDFOUvZBDwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389789; c=relaxed/simple;
	bh=8hXhQQQC98g9vJnAS4E8AAajxzRx3+xl2wvDKvDG/dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhUnbRKMYftaQB6NG3Anwa4gCXhBc5/rCAhnvpUrKMhfT/Tw6hdSQlKWurXm6Hq/BxvSwpeBkGRGoWfxl/yFBXX9Hqw87K8KPpPF9Nvcz3BT9/FsKST6RmZMZGNFqMcLig2InORKd9AlW2GirUJfyGXNK629P1kCwBhLz8tvh5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2GtdmOcV; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3qHkmooekxXrKLYN6VC+8Hdcq8ijBBZDw4Bz2ikY/3k/HUcpkdEfRJJw8+BRDaYlZnfrc/DsJKdf8iA5SMN7l2d/BTdeZpLQ+03c/c31t/bCFYE7kyd6ykKUYANP1n2eEQtpd3RC9rL26x593ziWmiXNvzMYFcIdqrifxtTuZ6XjSvioUunwnt7azp4hWbxauVGgoKD/AkRPfab77i4pzIZlR/20PbvRCw59cmYlGjO+31m0YnIQdvKlfxQNW8iVBK/sMk63fNRN6+FHGVQOJvg2C1vSOs3Da35HHK5JWf+jTZSv8sP0HXEaCjVGVyiZoySSwdGFEshZqvWJ+pdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUgVPVQFM8uu774SA7PJKXb8eHGTrYG+6hsjcihhkRc=;
 b=Yi032AigWRuM9Z+mNa5ReSwQxfTc88mOwvdeP61XCLTFfJ9X0JN3W8qRdDhcyUrM2Xn5MTLGJzHPJOe/Re9XQ3jvFrH0ZjOoNYSQ5dEYEk29/zhSjfCBhlsxqKZwn6AgbWZcDYsQdF5jq+i1VNoRUyVSeZh7cUqaseTipaZz3NWYSGFKwvsSSea1tRpJz4XEAs/7xcGp9evroI1U/8hTkq6/uZsZvVrY4MtSNcFJtr9FKbKCGjZxY8AUjilwlIjWRNZhKQjMoQyj0H1hyM2YIfubZyK1CgyYYG1vgD+p3L/om9NRuIv/12TqFnoSdcfOEuipUJxQ87ahDEW4UYaNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUgVPVQFM8uu774SA7PJKXb8eHGTrYG+6hsjcihhkRc=;
 b=2GtdmOcVbinpCQnZohjej6CePbQ4Pfhm53u9B1M1VLp2NJb7huTTSxtOFJI6+5nLOcEBkaMPN8JglKgLnCWQCqRytjymoT7uRk77N75ionu2dPm/p1A33uN8k3V66FUD/uJgwydZO4FRSlCwkTyHVhavWPhu+jqjYq/TE3V+JvE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:43:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%6]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 16:43:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Sun
 peng (Leo)" <Sunpeng.Li@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
	"Wheeler, Daniel" <Daniel.Wheeler@amd.com>
Subject: RE: [PATCH] drm/amd/display: Temporarily disable hostvm on DCN31
Thread-Topic: [PATCH] drm/amd/display: Temporarily disable hostvm on DCN31
Thread-Index: AQHbqBbndQqPwha28E+jwbHebjefibOZU2GAgAVb7+A=
Date: Fri, 11 Apr 2025 16:43:05 +0000
Message-ID:
 <BL1PR12MB51449394CE86B73675F76287F7B62@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250407234329.2347358-1-alexander.deucher@amd.com>
 <2025040802-seltzer-pedigree-d053@gregkh>
In-Reply-To: <2025040802-seltzer-pedigree-d053@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=fb06bb62-c81c-4fb9-9868-04068dc25f1e;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-11T16:36:14Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10,
 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV3PR12MB9144:EE_
x-ms-office365-filtering-correlation-id: 1fda7ad3-393b-45c4-82d4-08dd7917eec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?upvWQuNTWgln8CmzMlnWyOqD7Q9ccyr6o7VvbMDiHtU+lOIukdvoHhDRLmZt?=
 =?us-ascii?Q?R8GUryypC2Srzcj3K865u3GLREnoNkMNYLZDg3tepYr1+heGO9Vqab9sN5ff?=
 =?us-ascii?Q?3mMOCYOWjuCb8QyyaZAxnmMZAiaIRM9CG2cnighVkD0PVez7edB7FeDQ2g8b?=
 =?us-ascii?Q?X3WXMVawWphKFbBsOYxigEGd5o5JJ1Chc0wrBI6VXCmranscMGZD0U+rZnPU?=
 =?us-ascii?Q?yy/GUhH9IFXCsCkW9wSmY9Mmz6RUDQMOrJ2H5Den5sQq9cxGWAkxZr9Jln0g?=
 =?us-ascii?Q?jLLZX7sd3wswNfY03h+9qheEV2HVf3ONWvjGhsuZ5RPUYaAfoyHs8sdA+HB/?=
 =?us-ascii?Q?llNCQYHH6hM3NRlLYOKtKvJ7d7pYOh140fTreW1fqRQQIclzwccUGV/xbJD2?=
 =?us-ascii?Q?HlbhwwczXQt20rLU+f6H2+zitqOxgKbgOPlFw0Y42kaBOcxcaYZxfCZ0veyZ?=
 =?us-ascii?Q?NfkUwduie8FkhKCnOXisGjLg1qkQCvZ191AwcHQnTdTX9b0QR8kuS5WFoXt2?=
 =?us-ascii?Q?sX1j7ae7L6Fwsc3i1CgCBglv5hPx5OgSn6peK7IWOLVTA9NHEA+wrKPwXX8p?=
 =?us-ascii?Q?W6oSPylk01D0Iwto+jFk8xRMS3MwDM8QI38YnLf8mwe4XjbXPWK9DoKdiyRc?=
 =?us-ascii?Q?VtA0IPmko2egQU4Xi8djbKWXDOC2hSW0P/QQfSjBiZee5m0pDWGBG4olslHy?=
 =?us-ascii?Q?Ev7tTm4hFRs0ta3HJLORvN37wT79SXk+sNVhmzDDsFQgVcXE1PekQaBuMc//?=
 =?us-ascii?Q?LMq6V6aLI3eUPVbNvocTKoGexWm+eAt01nm8F6rOYKCaEln1r8GKjGTGcEFz?=
 =?us-ascii?Q?q1HzGZTxZTV5xsDn+9/Nn/VD2ixmrfFCAvXLhjfnX+/bGbtAWvHjWF59VSR/?=
 =?us-ascii?Q?xyA8O+p06aJ4W7o/SVeCHANf6uUNyrcDwtrn8McLZkhihn5OGz7sJ/1hBeeg?=
 =?us-ascii?Q?oQfBX4TOzs1LJWAMtV4d+m3x3mCIte5dfxa2HfcDtAQQCF/HWj3CKbZneB4U?=
 =?us-ascii?Q?AfxyzNTWWkpIkQ0cVel3Mqk4P858Q1Y7H/srZW1TPjHCX1IIKIz4Ct3gEXnf?=
 =?us-ascii?Q?zhLQgAduzdzwoIgUqppSSIN6EdHLWR96SV7UjStW1ipjlUXuudU04ifag+7h?=
 =?us-ascii?Q?kaFhwMjPr6ClgKlNiG43HbCGx64oqEekGXaXkfoA9tBFmPkSsV+3oUXk6Yxg?=
 =?us-ascii?Q?u5K84TyzBd2zxBtlHtOyAWx818em/uyzicTtT5MsC1yuYEBLhHLzAGdgu0k3?=
 =?us-ascii?Q?h1ttnRM4we/gRcZ/ze5/NYXs0ZGYNuJ5BUFVc8uftHxnXL3oS77tw2YODv7B?=
 =?us-ascii?Q?FFW7c+q4Jyo0LDoncLMtzZg5sqaJsb8ZUeYh92cBZQ+XUi8R82MdSotkDoRm?=
 =?us-ascii?Q?Re9L8mbR/WF2E2Vpnzw0PQUx84eR16z6Eo+uqqPj+EUEaitePcL3YCJOr86H?=
 =?us-ascii?Q?ZLceldY+3DIbSLMwZOcXqHn9aPFAp+nez/6sHLRuftB/aCXneXUFUQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+RMAXGbFTS/mB9j9XqlvDZklASv+Fjf2iQXcBwDCn0TPrjeHdxHoZA6ytp50?=
 =?us-ascii?Q?GlqLu5ZVcErwikS006uQWSTWUdr3CW1YrUHT3lyfGtG5rV4kNfoBdfuLrF7n?=
 =?us-ascii?Q?SgT+Kn2G2UluPxmQezOY/voZ2pHLi3AtaIwLKfKXj86znduejvDceOKzLtMR?=
 =?us-ascii?Q?sKw7quHMtTKsaZcbI9M3ls2Uy2OqMuAfcN+1h5/mOxPtiu9TILKhj5bsh6Tc?=
 =?us-ascii?Q?3ngLTgzWu073/aSCRdbw+CN27A711QGvJ14D0bhreCOIw1+wHhy6DLTl2/2y?=
 =?us-ascii?Q?EzXSc7pls8EM1J+kzRxDyTUgsoZpkH3QhNup+mPNxJs29HOCXg6YuCU2wA3I?=
 =?us-ascii?Q?8MNbFa6Q8YeqTYq8qQiQ0p6o4eMn++hctJU/CrpIFGdgtr2Pie5KWMIguTCo?=
 =?us-ascii?Q?4Ua6AY/5JCJvQDR5lgbPHqyThlPa7k1J8kIJDIMYEdbvql4BpF86U0YL97cm?=
 =?us-ascii?Q?nfxwkHNW9Lq1DnzpG1E32suNoPHk8XFlXpXi8WQVMpCcgM1e2Bioxhv41oB1?=
 =?us-ascii?Q?KgIBEMYP0r3g00kcKevQygK+yUqOdna04p/acELm7EYqXMECP5e3iH0fTbS1?=
 =?us-ascii?Q?KRMIkqgTtmsNrUkC0ZTNFz5l1YKnbrQJYEkAhEniSJbDtrv3ZEh95p3QnWdR?=
 =?us-ascii?Q?qaE3iUexf16PgMEw6SHU23jpw6dDTQ7m68p7KC3Lv6Kl/SV3auKWhlbNPQbG?=
 =?us-ascii?Q?2q9WRW+CdkRzbujmz2z8kKEvt9wa8azb4EF/GyKKpyVaPRNGgQ5fUmzi8BF1?=
 =?us-ascii?Q?y2XGi1biSKGHSl8wq6VT8/t6nDmev4sCM4b4tocimU+faCRuPwELx/6GYk63?=
 =?us-ascii?Q?iRVnFuTp4NgavdaRWEDcQSvluIv1/3qgB7e2PmgYNAiaX8obqThanOYp0QVX?=
 =?us-ascii?Q?xfBLRFkU0ih+E49FFgFPs7Xz5CElBJJXp2DZiw+wuu1MRGlAVyi73wVKeLxK?=
 =?us-ascii?Q?S4/2MQSGF4csO5PpsDu3GoR/SHau1kAjUk0Gf66q38XXpGYf+ILOD14Nv4RD?=
 =?us-ascii?Q?2kjrvcIu36o+UmOdy2f8Ieas3ZINTbvd6ZjhQjicPOhYF3L8VYDDMEHd23ns?=
 =?us-ascii?Q?wYc1Y/F6qORpr+1NbN7VhW8CvURN7OnqZxVBmJkktT7hrrL1tPa+ppqUm+gp?=
 =?us-ascii?Q?oiBowvNSbHBuk6TyCt16DH1sjaca746ZGGtH+BQ9kjh6Z1DcBukL4UWYXpIK?=
 =?us-ascii?Q?EE2UruuznO8rx1le7FPrMrDS2j6UApJu+cgMxcVtzwM2O0Af1agImzQz7Jjq?=
 =?us-ascii?Q?SP0Ic6hELjCl0uBRwEG3a9xdBo0Q9kvvMD2QrUHd/yKaZIrxkX6oeqjXeAb7?=
 =?us-ascii?Q?eIF2EWs5fojv6H+UYeFixk0L0kpBQvTGVt/j3xCW2LMRqbYWtxa6ghtb4Y8+?=
 =?us-ascii?Q?0dJVUHMt9MKJJb63zIC5s3aTzd6FyJezyhkO9XN6V4iP9626Cr/y6JbZ+VwS?=
 =?us-ascii?Q?qGv3BmiEGDZF6h73FA3YIZ9TC71H9RO6NDSpN0kiUImkeASqnV0BZlEYrh5o?=
 =?us-ascii?Q?GsRJ4zgSj199M3Yc+QfyPVst2H+JEiN5zwUzx/jA8WKhCLurirNm5bWCUTm+?=
 =?us-ascii?Q?M0nFKTAVgLV42621Ltg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fda7ad3-393b-45c4-82d4-08dd7917eec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 16:43:05.3677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhvsISFAmzPNOtfnp1LPG0eUkRFGFJMIg5N4QErftuOD63fyRyJVSIC9yrT9mCgvoKmqy0+m3+TpQsxuu/v0Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144

[Public]

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, April 8, 2025 2:45 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; sashal@kernel.org; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
> Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Wheeler, Daniel
> <Daniel.Wheeler@amd.com>
> Subject: Re: [PATCH] drm/amd/display: Temporarily disable hostvm on DCN31
>
> On Mon, Apr 07, 2025 at 07:43:29PM -0400, Alex Deucher wrote:
> > From: Aurabindo Pillai <aurabindo.pillai@amd.com>
> >
> > With HostVM enabled, DCN31 fails to pass validation for 3x4k60. Some
> > Linux userspace does not downgrade one of the monitors to 4k30, and
> > the result is that the monitor does not light up. Disable it until the
> > bandwidth calculation failure is resolved.
> >
> > Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
> > Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
> > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com> (cherry picked
> > from commit ba93dddfc92084a1e28ea447ec4f8315f3d8d3fd)
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> What tree(s) is this for?

6.10 and newer.

Thanks,

Alex


