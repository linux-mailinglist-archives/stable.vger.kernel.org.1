Return-Path: <stable+bounces-99952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9039E75BC
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 17:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D050316E4E9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1756720C479;
	Fri,  6 Dec 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VAJdXF7L"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBBA20E30C
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501883; cv=fail; b=TI6AKuU2xLOMG/tB6zlCwiRGfpwvNXmZKi/cTBpIv5uqQqB2Krfdu4F5O/u4FTkgCZnST+D8mhjwVopgm1iaCKBroi9Yb0mApCjBlSAP3ywgTRVJAV6pDWyWgbh56Ql+8h6Vxuhdpt4xWXe2giboayosqaOJmZlT1DQ0m9plOPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501883; c=relaxed/simple;
	bh=mZkdQpW5GyxrZHQW0expu64NgfYsK+zCJ4NR+F6PQG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1geBjo931d022sM8JYfcBKiTqicGZXqyDsvPxiqNPGG3WQEB8JmNaOAwVUoO194QssJ/AW7mnpi+V6NSuRnNw6vPL3dlChmANzmkytlrJt9DMHmhY2iHcJEcEuAxafRW/0aTLiR0ZUvNIvzi2MPQeVA5VuVghZI9SvYv2o49DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VAJdXF7L; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHFh2m9/Cl6/VjIRkFrmrNHQXxBdjmWg4IHgChTmzrHo5lUjRi9oZ8h369u4VFtQMokDqL2h2p9xaJTZKl3xgW+glkqPA/fhnFPvErXReQHyLP1nQwmMCMXpxPWeKFiP358EXKbrYxCkajuQUYakijmVhzs6Xzgnt5tdSAe2jtG+/ebsNxlI9OkaspTjyHlpmuzFte4UvInvqFcV34/SSrmoFHAH8Ht4u1lG9wHTzRSr53FIdALx/TTw3m08gTNfyXgnwQ2DhRRAHLxJP9ds4qAXDVEgPQTV705iJCMdLtna47/q635CDTYcSaEFQqfCENNu0djCsgX2dAT99F1Ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANN1JwaeF4o/sfDP1pr0k6VzmcfU56y3m5gZQMtJhns=;
 b=QMILoPrczkxfGW+ZR+gKrv60DdYvg8dBX4R6HrknCMtMsXVQozeEvnEB/2PyUrsaZU/aHJb4QeNEKot45Iz6YCqSPqUmj4CYvVK0GbGmGC3NnyPIW0b4VPXPdU8TRXH5vdFaw8rwbMZibIXB9m67enXdnFWTEu7+mIIpaPIAbpauE9ovYcXsI4p/nABqxNbq/AuV1NcXNrrxQ6rUTDfKMGmqFcFc6JKtak2/4wCUhYM36tIe7hcaqGIkxkBntK6a91QYWFVnjUfEQSD1xJ2G8UXxYnush/GANp9L1PQ7BdjscBbY+gr/Vgjwd9Xy4axyJejPU9j1b/KHZjvOs85U/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANN1JwaeF4o/sfDP1pr0k6VzmcfU56y3m5gZQMtJhns=;
 b=VAJdXF7LGhajxaemP/jYSik43smzRmS5oBJLUs7dx42OYr7maA5q5ELg5nmTu2FDAFHdecny6Uyjn70zjE92OtgNV9SK+2bypniEwdRI4/WZWyU5P/mO3oriUewTnkjalJ0xXsAEacGb0tjBPm5apv2abUnKZxJeIDIU1229RQ0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Fri, 6 Dec
 2024 16:17:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 16:17:58 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo"
	<Aurabindo.Pillai@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
	"Wheeler, Daniel" <Daniel.Wheeler@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC Policy
Thread-Topic: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC
 Policy
Thread-Index: AQHbRN+q+AlX8RfZwUmcxTedyta1f7LUG1QAgAUb+ACAADNCUA==
Date: Fri, 6 Dec 2024 16:17:58 +0000
Message-ID:
 <BL1PR12MB5144F95DBC0D3EEE437F568BF7312@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20241202172833.985253-1-alexander.deucher@amd.com>
 <2024120301-starring-pruning-efe3@gregkh>
 <2024120610-depose-hatching-821c@gregkh>
In-Reply-To: <2024120610-depose-hatching-821c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=634fdbae-e924-40e5-974e-b9f5b834429c;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-06T16:16:14Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|IA1PR12MB6330:EE_
x-ms-office365-filtering-correlation-id: 5f89655a-6bb7-4d0d-b1a5-08dd16118cac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HKxstQZctZwGNRRZxvtUSIEVIs3NClIjDtLCa157qWr96a310lJ6Ck071nfF?=
 =?us-ascii?Q?qbSPJ6FdyzMutDZ8afvRHBJTMQ7qihVAb9uGahTjD9Ev00u1PT72AFTXlBrk?=
 =?us-ascii?Q?CDo3Do3ydLM92uZuMDvphRg5alxMjPkK7xu+a7FzB/MVAgT/ZdgGy4jxvQHy?=
 =?us-ascii?Q?UdMDFWzJq/VKJSHLYtxE2plgqkpYr61m5HE9AROZWIJ3QLzZI3lMYtazl5t7?=
 =?us-ascii?Q?MMTIaD1F5955PpG5VjaDUqAyiksAuiwcLye7SsCD8t8C8q/KCtg6H1c8cJYg?=
 =?us-ascii?Q?8FimowvB4b6lrQ1Lq9K7MS6M2Ci+jdBga9ooQoeuaM8ZPk05L4pOGcYZjqnV?=
 =?us-ascii?Q?J78QSxNKcUsaB586fH31FUMjLEbtZ7cNDEQB8p2WTwxRAfQ/X7uAZCCOEusV?=
 =?us-ascii?Q?evsWwaS0LSkvXzkP0o+8ShmhsI9+DaDNxZclRbKKIWL5sXfc6wF+6cTm6msg?=
 =?us-ascii?Q?ikBE6bTG+d2es95bpNqwQGR7DStT4hHy7tRTLAPQ/NvDpX91wapPDi77X/5v?=
 =?us-ascii?Q?j0EQ2Q0Jdcogie1NhEHzwLCinv6nUaPBHAiNvWhPTGcFIzxSoS7fI43P7YJn?=
 =?us-ascii?Q?oKRoVa0mB06DGSgK0mY414If578aqHc+W0f/PXvKM/8/pSkYtWRVdPvB3Mn8?=
 =?us-ascii?Q?H2wleQz/fqO19PWGmat6p7NoY+aLdztmxvagMXPZQcTnoWYxAacAyikThZHC?=
 =?us-ascii?Q?kNnGhiPwqrcgV1oCB2PHsMSF23OqXrf8pjujID8SzKG1aPGHbnRsy1/FYPk+?=
 =?us-ascii?Q?MfDjxvyUFc9+VJxR96m5j0kLGeiuJLfyJUGscBn8iIncYFa+6qaqNM+Eb0u4?=
 =?us-ascii?Q?kLF7MOJJu9NvxuRfoYL72qQ4fx38IzOKbgsGC8iyh0EjY/mC5mU6ndkMju5v?=
 =?us-ascii?Q?aoOiKf1vOUc/zUBCVtVavenRdTGZ1dXeJF/Wp9cb9e+IDv05wvWpL6tEa/pK?=
 =?us-ascii?Q?oH/UqRZaSB+e1VhYeuHjRD57zCcT2CKRDzfPMS0Em1qTEU6jQCPBAKGHfZ1R?=
 =?us-ascii?Q?QqeaiNLNHVRAN8grTXKMpjnQe1MRYQ5n+UgYKsTR6IbSuKJVst9CzgR5FcPF?=
 =?us-ascii?Q?RSIQaLFD/TknESb4S/BSIKZAp1vbYzN/GyaeFzNROEF5N/cfBIITViZs+Vp9?=
 =?us-ascii?Q?0EHSvVL2ZXTeOfKAdA604QanCrLp4hlLxVxupJdAD/0g/JEZG3RZCjDIKCLx?=
 =?us-ascii?Q?fg3Ma4niuI4YPS2D+KrQ8iHXdHQGDOW3aUqd4Su4ZHOehhh/5UDSlM1yYtFr?=
 =?us-ascii?Q?b3vKPUZbtbKHbn9SCNGSUZSn/c6f9wwKlaIjHxDTO1RExWhjrIbSHArnpg3E?=
 =?us-ascii?Q?1p2gfUMoawt6gE8Kd+Qw01lIcU6EauLudiamMhkR0qQSNHgCS1HOFa0QWXH/?=
 =?us-ascii?Q?Ui0lvmY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iBQstZI+Ul/Bzj45DkHFtUtAheCFJGIxYhbR3wFC8tgvqiIh/acSHds2O/5e?=
 =?us-ascii?Q?MvESUZokMl16UhRl9AFphGtmqmh1gYT1N3vmCD2Rd6cwhOesrYToc5TkJqxb?=
 =?us-ascii?Q?KSs/VRkmrpB6P0k6x4VVsGm5Vn9rifXl9k6BLYeWpPQEcALk4GH6I5wKfJpD?=
 =?us-ascii?Q?div5Lh11U2/dLApEAxkF3GjJdxkqb93FD9uvPtk9ZVun28dVTV/11XwTGWuH?=
 =?us-ascii?Q?Dhoal0It0rIrnyeEnTQpTIWijqSQuLKGEDeTrhC3c913XjccmTQLKhFZq5W7?=
 =?us-ascii?Q?y+7NWxk8SWYJxjr2TZv2dzOcRWX+4F8cw79o8md0wSd2NEXxj5c0ZXUGYmho?=
 =?us-ascii?Q?Rm1wqaEYSg522WzgrhlCv8ML66tem3Esq4arJyqaiPsva/hFI96nHj3ZW5f4?=
 =?us-ascii?Q?y37ICnYQMp9V3h+9SGPYxCjPHRlGsQTBwhcV/wYAOb+DoUAgN9Yr0wdRLrhT?=
 =?us-ascii?Q?JhTubd9JME7VdI9Y3E7uAkoX8qy8kfw+M5iXnpJM0K/a87mjN3EPURwu9Qvq?=
 =?us-ascii?Q?05AuL5PMyCm1a56fkp12FS7qcCClJxZtK2/Mz0jdaGv1K/zjQfCvd4aMnRr0?=
 =?us-ascii?Q?ZFMhxcJKfv4rrzVvS0wXZHr98bNVlDS7bBBKAtEnQConZf3UzhDUFKIqyrJc?=
 =?us-ascii?Q?t3nSdfixtBbTauXTc8pmQxmIzgHYCKvP+QIBa2MRZTlMQ9Ql3BXtV4l9L2Tz?=
 =?us-ascii?Q?sMpoDmW3PeD/6VM74YXEMuPE4UndiGAKZKmP+IxyE1cfnDwwpC5Xr/g38e1a?=
 =?us-ascii?Q?LLcuHZ7VqNQqkXGtQIm35zLc/KXNNohF6ctjIv+pqRGidpYBmiP5zVLjNUjy?=
 =?us-ascii?Q?qUvntLPBSOH5v0QWDBu65lXDiJ4RXuHdm1jUTMXdQ3+l2fkZQC9qdOJdDztg?=
 =?us-ascii?Q?zFhMlLrrdDxNTwGdeqHu7tVaSmJjAbNdomKUNEIYKAIjpVTKs1L8tVVtzxS6?=
 =?us-ascii?Q?u+wdoyKRaZMOIp4lB1kitVzeC3tdI2ttwPIS++E6FMYYt14eI7jhKbTB/4nZ?=
 =?us-ascii?Q?OUkB/AzzCumRH8iDYJoXVi8DrP1gAUn2aikbgHbNyYjXPC/6idPUd7n/MQLY?=
 =?us-ascii?Q?0S6etsGnJrrMgcG8Z+y5xV/PvAV8nQLHlwrpPlMS05N3lSsbzJ+4VZmlOpet?=
 =?us-ascii?Q?ROx7d61wjO9llcptfD0IXqAQ9ljXgoeZrFh0iMHmMN8szz7yte0T6P/mGn9q?=
 =?us-ascii?Q?Z4lUUA4HUX2VAdev+q4Vr5ZyPS0PLjVdNfgnxw0vBsU/FMr1pwCQ9AoJNSBK?=
 =?us-ascii?Q?SHDt3yD46GhVswyNHUz3LIiMWkK+HmyCpMYyxb0G025Pk2bm5LS5DwpX9hSv?=
 =?us-ascii?Q?uWN2XmMh/keuocQoCcfM49/6THQ3GHNd5B3ioaVMgE4L07SdKLGCa+BDBuXk?=
 =?us-ascii?Q?P2FHh+/cKe3mV2GNhCiq9Kyuv1am/y7G6MBzoC53L43HOXz8rRdCcifZFfPv?=
 =?us-ascii?Q?0okojmMWsePzi6nakvsrw/v/qXmj2hzHXXrsAemFMnxWNpiNxL3QpWSM0DYm?=
 =?us-ascii?Q?r8tD9X3Lg42RqVMtaE6oqObEJnyTC36L9yhp8eCBoYWrzyfv4+IBhf3SjSxr?=
 =?us-ascii?Q?nSnIV5ygjEeFor6RRTA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f89655a-6bb7-4d0d-b1a5-08dd16118cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 16:17:58.6286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFckaJpO9twOG4buYU5C3rxnxDiAZpt4dy51STMbhPQIp2xqpMl2z+pJi8/OF2+XxxNSyhAAdXJPtVTHvHMtTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

[Public]

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, December 6, 2024 8:13 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; sashal@kernel.org; Zuo, Jerry
> <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Siquei=
ra,
> Rodrigo <Rodrigo.Siqueira@amd.com>; Wheeler, Daniel
> <Daniel.Wheeler@amd.com>
> Subject: Re: [PATCH 1/2] drm/amd/display: Skip Invalid Streams from DSC P=
olicy
>
> On Tue, Dec 03, 2024 at 08:11:14AM +0100, Greg KH wrote:
> > On Mon, Dec 02, 2024 at 12:28:32PM -0500, Alex Deucher wrote:
> > > From: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > >
> > > Streams with invalid new connector state should be elimiated from
> > > dsc policy.
> > >
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3405
> > > Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> > > Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > > Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> > > Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com> (cherry
> > > picked from commit 9afeda04964281e9f708b92c2a9c4f8a1387b46e)
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 13
> > > ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > What kernel tree(s) is this series for?
>
> Dropping from my queue due to lack of response :(
>
> Please resend if you need this, with a hint of what we are supposed to be=
 applying it
> to.

Sorry I just saw this now.  This landed in 6.13, but it was determined that=
 it needed to go to stable.  Ideally at least 6.11 and 6.12.

Alex


