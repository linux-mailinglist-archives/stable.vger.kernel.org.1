Return-Path: <stable+bounces-184043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810F1BCEE71
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 04:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7A7407F29
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 02:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4F3165F1A;
	Sat, 11 Oct 2025 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A7RATX/9"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013031.outbound.protection.outlook.com [40.93.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15084126BF1
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760148729; cv=fail; b=JLoA6C1X0HXbWwKMdhfLX3omIPw88B0bCSwlnHNHdW//j487qqokz051NyjeFodT6JWIRU9o8cHwT76ln/J4yuAet6HE9mJpXbKj3WvwP/JwgBGLL7ryGf+LxiaxtIIL1iHb6V2YUrxFGXhAI5jKRDXojOI5q+rFuygEAktn+RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760148729; c=relaxed/simple;
	bh=NvD3uEu/7JTLYW+wMkZ28gL98C+bSuA+VyStRMz9XL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uf/RY+QFcQTG4dYCMpkmHa/GwseR+ND4MTZdG+V3PeInoj2qKksOLgknBV5OwuYOSpLDcsWQvbEs2GRuNwBl+v4ftVMx3Esh/iKlTVeA49iGvR4Kum41dk2JLJU2kUnJGWlTPp0wXzaYqrGLmdUM8/lx7DkaJVd9587Sp3M7KrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A7RATX/9; arc=fail smtp.client-ip=40.93.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inQEh9/gGQPZjlDlyBkkRdVdeyz48bLtywaHXVUdStc9rjpD3D2PHUg+xt9zdZP4oDsVFczfWhlRGmG1R6uxnqG2ul9SFkdcrVOGBPsDT6rp//4c35VMTm7Iw1FRjlTpvJppIbjumutOaGogWx55dRMWwuVAqiKqOUNfzD98XUKiXT7e+/VNQE7ANjBxOc/kryNPmplTNsyLx4Tmr4Qe80kDbfVkyl8FK5oIWg7K63gI3Vv6b7CgjfGgS++VsEeC7y7R2Yc0Hr6DTWt9r2XE3HjY+KHS/ja1bYKwGOehMOqkTFJhx+EuRlvvbFii/Hg+mgRr/v0U5++oslTAWVRqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhmZysK208o3+B193GMlTXu5ufjNyErMI0vwz9EPw5k=;
 b=elN9ipTzAesWRPDrxoDLb8rMKM0CH050YZWwnduQwt51BjVhwWkJE0/WA5Q/QX8ybuePhwd6/NhAoM3ZxFOsnhxltx1zyU+Z6Y5l9RtQp2FcmKIrbxwdB8M71yocqpTztU1Gy1D/Tfycw5xcuRK4OW9xMpRJWb75AcqdWuPPCgRAqhwaOPmWo3kiLLz+G5hK7hqlU2e3p+4yJxW6deeeo3Euj+j5WynR6jEOmUT7BnZl5490nWQdGf3MNev3DpaoEChZ1pvIifDGmGSXC8juZkzw0blNWvxkFwHKGJ3BDErvetGeB7p3notnjDPkOgX5Kn6ZIzUb6GGVdCGMd/ftVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhmZysK208o3+B193GMlTXu5ufjNyErMI0vwz9EPw5k=;
 b=A7RATX/9VpKvGVozoaNc4/eP4QLKtgUJm/207acp8067rrwLQa8aZFZ2vsjKSo6IM3+92DTVm4JvK9U9GxllVj3KWEk4GytGsxDBtJjpooddsmN0nkTA/Fdf8zxBry4xFa+/oRmNBAh9wECgvHYAx3/k8Rs/TqkRyD4BmzORVrM=
Received: from DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) by
 PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 02:11:59 +0000
Received: from DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e]) by DM4PR12MB6158.namprd12.prod.outlook.com
 ([fe80::b639:7db5:e0cc:be5e%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 02:11:59 +0000
From: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>, "Simek, Michal"
	<michal.simek@amd.com>
CC: Jani Nurminen <jani.nurminen@windriver.com>, Manivannan Sadhasivam
	<mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [Withdrawn]: [LINUX PATCH] PCI: xilinx-nwl: Fix ECAM programming
Thread-Topic: [Withdrawn]: [LINUX PATCH] PCI: xilinx-nwl: Fix ECAM programming
Thread-Index: AQHcOk4qX9be6Aj3QUW7MyyvFVw9WbS8NDog
Date: Sat, 11 Oct 2025 02:11:59 +0000
Message-ID:
 <DM4PR12MB615800EE0A16DF722F63C7D4CDECA@DM4PR12MB6158.namprd12.prod.outlook.com>
References: <20251011012539.548340-1-sai.krishna.musham@amd.com>
In-Reply-To: <20251011012539.548340-1-sai.krishna.musham@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-11T01:44:31.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6158:EE_|PH7PR12MB8124:EE_
x-ms-office365-filtering-correlation-id: ee01337a-4a34-46e7-9cd5-08de086b8f77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YOe0zt9SreCcHNJfkhiOcw/dBn4xw7z5MIWyFfINNzGNA2FPXbFGFYHiytRq?=
 =?us-ascii?Q?94GWROfNasAVTnAdyajXwLDZguqyP0DXOACy04D6hVEfpS7jSyMn8YXxlFe6?=
 =?us-ascii?Q?HhI1CGt03PLjQYXsWsOG8xFsxMZoi4vNixRzD0b0DjWeFHxnX4icjCwQ8fRP?=
 =?us-ascii?Q?rWGg4hP0emr9NAH/CdaxgeXrMxrIP/tQSzUmrcdVw2M2bQbGfXHHOchh4ewg?=
 =?us-ascii?Q?raIQ6d2bnCziUkJ02k0eDgfITkJDabPou5gSWmUVRSiXDRYhcGFeF36zA49R?=
 =?us-ascii?Q?AgGYaYP5zkRm9p8xqCkhYU1mEfxni9rsUAUiGlyG3X5caL0IOAA8Xw8dO8tf?=
 =?us-ascii?Q?jDQ93Jp2J0RTT4Z8O4tv14nTMS+nWA3RiChpXb/Ke9IUwKHvLmOCRF5A2arB?=
 =?us-ascii?Q?w6jvD4HnKRvwDIH1lWJ8fa0HDBAAiDutqqhBcopPeL7U3N2Njzc28GCw2GwA?=
 =?us-ascii?Q?Yri/duaGiJ872Mnw4NiQdstiy9QnXSumTfe1BxqSgEO1s9TLDUNAkg5NSJcU?=
 =?us-ascii?Q?itt6oN+OnyFgPyu4iD/NNBv0z02AHjnwl6S++Slc1xMSRGal6keoK1YPUrma?=
 =?us-ascii?Q?gdBr1dIv3nT+FYz6BZkhd0cpr4gHXbrFrJd6DkKnd/phkxgHSP8duNS83r79?=
 =?us-ascii?Q?UYyLAvnE/vkVrOarScLIXLOIFC2V/3tBIIEGMsoMKBhmu2cLsb7+Igzuhq6N?=
 =?us-ascii?Q?62UAB1nF6nvFP6fXpzn79dcGJzMeXbL3sMBaoVQnBsSWffkU6ioDS4jECI7M?=
 =?us-ascii?Q?V4+L9cxgsgo2VS1AuRidigcTmPAlthlEfsOYsiB9O4ZaL1A0oWAK2o5Kd7k3?=
 =?us-ascii?Q?ozSO8gCe/sPO7NOazrLA2IFgHP971g/8D/J0DZEw1Eq6kxD5LDZNWQdMNUXr?=
 =?us-ascii?Q?me/NVNp5pWZuZFrdpz57oIOVPKsPbctoYTR+MEac9g0/DoBDbtoJZssgtSyO?=
 =?us-ascii?Q?bfSnZxIfFPuwFjcJjBzCZ7nNiyBAZPRkgNn/Yj38ME0lInw4Hq8y031j6dLL?=
 =?us-ascii?Q?Q6ZcaUhjXf0XqKmQ3QqrHMBgZD2snTkL7LXHVWsaYshdom8+odCcU/DiaP2J?=
 =?us-ascii?Q?WL/tbtgc7SmaHa06gSUmWiYKUlRly3aVU4JvwsH/zmTUAYMEwGQilm3ju/Yp?=
 =?us-ascii?Q?ddQaVSCXJpiOfkT4i/RpiRt1ZgUSasAs5WKbSGbfDqaNTnUWZsCjjIqE+YBP?=
 =?us-ascii?Q?SCN+8vltxRfAdPXaqeHeaXwW4CP44g1QILhAlNITCadDHpEjAt6zfPjzQujA?=
 =?us-ascii?Q?1foyx3iswmnuftPqvxQsZEEgLnkmuVwg00aztPjWRpNFmxc9/s4tcixyftJY?=
 =?us-ascii?Q?maOScSvDaNRCIz2WsHdNeU9aa72TYA32sM7dR/cXVYSHKcSoOoxrSYf0+13m?=
 =?us-ascii?Q?V3n391EHLoH8lyQG3Z6A2fxsO6Sx/wxYdU6CynvezK/J2OQ+X7PkdB2TGuhW?=
 =?us-ascii?Q?+jYzab17jPhgfcH65pRD+Iw5rHGoBQhwf9jOLRbypgBAi5oJbs86vw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6158.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/KpvirqzEyRPzqZW270j0MVlnPZOIuiBFlyPHB1aQF6oUsdrkRPPIeKfcJVl?=
 =?us-ascii?Q?WsAg3uIBmTrebde+yS30GmXVB4l2+P55ksv9kMgVcz2W+KHMeNayiZ1YNuFB?=
 =?us-ascii?Q?jtTZy8yPDQzxSwvvqngQn5crwUtav7HIlaeOVU+EWbBflRe9A+cJfX7dYVF7?=
 =?us-ascii?Q?f8LKYX3eAoDQ4qvg64/ZuN8aB0aFOwJNoxo85vSVlVMyN1v8/MHRAhEQHfmE?=
 =?us-ascii?Q?QDf2l56OmMnajL876s9BNZYTPs0jpQZ4cAN9wy39dc0jsEv2fZjXwFJdFMfW?=
 =?us-ascii?Q?Pa94g8baP1KKVDDyCfgshlzaCAXJ5E/vJTTt3Bjad33fu246bruuS+CC5Vim?=
 =?us-ascii?Q?JpTxPFISgJRQ5Y+xcPAv2qiVmICqudgB/GXRul10a1NDLnyCihNHpUGgW3nK?=
 =?us-ascii?Q?l2tv4fe093uYxw7AFruoiaEPnGvhPuqIlb91Zrlcr2QOP12Lv2iaySBb+jRU?=
 =?us-ascii?Q?2uXV1rtG8SOLejYFJ8gtI7DI4CmB6y2vqFHAi943Z/istyrapSzzwhF/RGkZ?=
 =?us-ascii?Q?F64hCyPXh2s+FI38YeoRltfpTCEQUEDoaGgUK6ocdFpVlNPt09ssXYt7F7K7?=
 =?us-ascii?Q?xyPVX7LInTHbNgEc43AtVVVUh9pXYlfp7sGzH1YR+qYDpRj1AJ+vZ1ffgf7z?=
 =?us-ascii?Q?a5z7LpoTiNvp+epbZtKDuPQgx1FIl20gUp5qzTYyPZd9OqwRxIBkhplEbowZ?=
 =?us-ascii?Q?cAVg+5bbeLX2c3ESnF3in7orCJk2WupSSo1J/D87rSLfcxCKRqbt1q3cgy//?=
 =?us-ascii?Q?a8yt6nLY8Jx9aZKJHXvQyyz/SMmP26zmgrwOASOxnt/Alm7Rcp2/9jOA9gbJ?=
 =?us-ascii?Q?Ee5NAWFDgK/zcIX2BXCFFnrH4QqsjftPDXLXLO/rJb6BI7Jz8FgsN44UNa/I?=
 =?us-ascii?Q?+oL92rOMcDaQyG1J2WZDkdBqfZBebup0gfPdsIV7iqxZmqNzR3kULoueevaN?=
 =?us-ascii?Q?km1iHBQ6Z98LJkehqKwczFM2DO9yWTMz+7dwd5bDurHQJ0ozo1o3cukWMV3c?=
 =?us-ascii?Q?V6Lz+TxhLT1tS00TTe4M3tKj6IDLyT34ucysxSBgqPHwl/Jh3vbW5eMe97l2?=
 =?us-ascii?Q?aFgIhLZW2pFrcMbXnmzcjJLFSIaNQ2ClLDHZRtE7uYAo8l9mtnoabFnkMDAv?=
 =?us-ascii?Q?cmtEMtFKs19Mw6SSOBc0yk9L6oe48duekOeXXUzFROh4w4FpinBn7iG/DDeR?=
 =?us-ascii?Q?eNBs1NjpBBDLedWnUj7a7JPqWbLXEFpM9hSW6+BSo1+vlRiL3rno6Kc0DeJh?=
 =?us-ascii?Q?tJ0zlQErX8Szn24QwzHvpyH/4HulCVjEbDbHQTQZbyUIo92eW9kGYiNOzUI6?=
 =?us-ascii?Q?6fz8Yl5urNGerOPEtB8KYwWgxvbQspCgpOLXP5EK8xorRX/kNfu8xxOTpG41?=
 =?us-ascii?Q?V1gi5Twspk6HSRe8pjuveDdTL70TCCtDurmk5g+BDF4eqAmiogyHEszR6YFg?=
 =?us-ascii?Q?uAykgcliO2p4ysFd5sE6X5vd5YLubw4RET4u+zbw8TIb7cGGnM94bFjirDib?=
 =?us-ascii?Q?f4avdf/HFICZVB67yXQF5dznvLOBEWJ/k2flEwPl/j8KrgdlmMKMuVSq2DST?=
 =?us-ascii?Q?flX1uN0FCAjbw6kfyig=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6158.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee01337a-4a34-46e7-9cd5-08de086b8f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2025 02:11:59.4499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMQ3BOO061stHD0eJbiYIsybABaJ/XGFWZRmeGTkIfnaP8q6t0/Brz1LeeOxXq5ZX8sF5E7mgGVrsN120o6Qhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

[AMD Official Use Only - AMD Internal Distribution Only]

Hi,

I would like to withdraw this patch.

Apologies for any confusion - this patch was not intended for mainline subm=
ission. Please disregard it.

Thank you for your understanding.

Regards,
Sai Krishna

> -----Original Message-----
> From: Sai Krishna Musham <sai.krishna.musham@amd.com>
> Sent: Saturday, October 11, 2025 6:56 AM
> To: git-dev (AMD-Xilinx) <git-dev@amd.com>; Simek, Michal
> <michal.simek@amd.com>
> Cc: Yeleswarapu, Nagaradhesh <nagaradhesh.yeleswarapu@amd.com>; Musham,
> Sai Krishna <sai.krishna.musham@amd.com>; Jani Nurminen
> <jani.nurminen@windriver.com>; Manivannan Sadhasivam <mani@kernel.org>;
> Bjorn Helgaas <bhelgaas@google.com>; stable@vger.kernel.org
> Subject: [LINUX PATCH] PCI: xilinx-nwl: Fix ECAM programming
>
> From: Jani Nurminen <jani.nurminen@windriver.com>
>
> When PCIe has been set up by the bootloader, the ecam_size field in the
> E_ECAM_CONTROL register already contains a value.
>
> The driver previously programmed it to 0xc (for 16 busses; 16 MB), but
> bumped to 0x10 (for 256 busses; 256 MB) by the commit 2fccd11518f1 ("PCI:
> xilinx-nwl: Modify ECAM size to enable support for 256 buses").
>
> Regardless of what the bootloader has programmed, the driver ORs in a
> new maximal value without doing a proper RMW sequence. This can lead to
> problems.
>
> For example, if the bootloader programs in 0xc and the driver uses 0x10,
> the ORed result is 0x1c, which is beyond the ecam_max_size limit of 0x10
> (from E_ECAM_CAPABILITIES).
>
> Avoid the problems by doing a proper RMW.
>
> Fixes: 2fccd11518f1 ("PCI: xilinx-nwl: Modify ECAM size to enable support=
 for 256
> buses")
> Signed-off-by: Jani Nurminen <jani.nurminen@windriver.com>
> [mani: added stable tag]
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/e83a2af2-af0b-4670-bcf5-
> ad408571c2b0@windriver.com
> ---
> CR: CR-1250694
> Branch: master-next-test
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/contr=
oller/pcie-xilinx-
> nwl.c
> index a91eed8812c8..63494b67e42b 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -665,9 +665,10 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pci=
e)
>       nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
>                         E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
>
> -     nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> -                       (NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT),
> -                       E_ECAM_CONTROL);
> +     ecam_val =3D nwl_bridge_readl(pcie, E_ECAM_CONTROL);
> +     ecam_val &=3D ~E_ECAM_SIZE_LOC;
> +     ecam_val |=3D NWL_ECAM_MAX_SIZE << E_ECAM_SIZE_SHIFT;
> +     nwl_bridge_writel(pcie, ecam_val, E_ECAM_CONTROL);
>
>       nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
>                         E_ECAM_BASE_LO);
> --
> 2.44.1


