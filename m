Return-Path: <stable+bounces-177728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266ABB43D20
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A6216633B
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE780302CA5;
	Thu,  4 Sep 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="epUFz/lp"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D148158DAC;
	Thu,  4 Sep 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992404; cv=fail; b=dK5fwjZazkZ7cGfdmXesl8sHJq045mam+dNOVjzzViA8neREmKWWL1VtQPmhg0Q52Og0T+pd9agzFnNXeZCEy8DUF1TZXKnBc+h96VGsSJiF0kf1sYtlrk5sGWCY+LDAXDSUlk/9LtLBmlApSVr5cbdk/iouDIsQbBtIebCUQKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992404; c=relaxed/simple;
	bh=n7J5xzMjcFfLeHSuFDgwaJSiHhiTnc8eWaAeLn8gO48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XT/t8oLF25qqvso+6Jj7CNMVN9Gl8GwOmCKuS3sPYV/ebEXVcv9z+fctYhvd9zXu7V11bTwHq6V2elC9IOjIt0ohmqinCx6YQGhyGz4bJ2HoqzGVGYge6MCKJBGp9wIyNFyQFDfSbvk7i0A/RvoYgIYf2wdLGC4YmYnA1w/NHqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=epUFz/lp; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIGqiLVF6NwCjQTYiSFnYFn4fvbMa6eF4ElD10woecN0rZF7FcU5E45cSBF4bwDReakolE2/pKjvtumWyW93qRv7vBQCrxzo6R76HYUKMH8EQFGFpokMiC1rp9mt9G5AAgpdS3B8fym2dKYJDzbrutsFqjT4uxPZKoxXfYvgaTaeYDQIyfx0NeypQTPXsGo1c3UzTv2QaJ3j67StJ1ESeh0Db5ewBUHs21ijZrj285pFpNErXUeRqPJvos5PqT5ItpQDmwpOYdyCkp6dnYmGAJt+3wWEiNT/TAxBXIAxHFAtxtsZnsU4zWCVSyxoAqZDTh0l7XmknRjKAU0RAma8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLkbiExLAeMGCJfFfle00hzk9efphJmlZlBe/x6UwMY=;
 b=m1QVfEBLqJ+m1XAlnP7tIaHX2P+NabqtZeHYCEKIiaNJKgWPk/vGi2eE7CkVf5J6fzfg4qMXeH+B6p6+JPuBNytKBUM8u5B00xkRAsaLE5hJ93BHHeV9zyPO2XwLEfqriQEmeG45Ol1r6wrdIoiorxFhqqvV21fBB1wHsRMWUcWvQysDnjcKkYx4lVPBkIGAwpIxIe6Y7LKOPRbSkquhaUjfvw5TOksH9zVkeZE2c85hcfrUmKKW1wagDiY9jY7Vw03/53YPFn9J31jqs4xcyvRYwp471Xevw031YF/R3PVU3Sclb8GyUIeh2fBVBNjiFwblOWs9r/m/NbLY6pwxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLkbiExLAeMGCJfFfle00hzk9efphJmlZlBe/x6UwMY=;
 b=epUFz/lpNUe17NpM0noQ7ErT0J+FOJiY4jpw/EbVveWsI7qr1/6wfg6Su1ObjtiGBRVYkhrLSbXYMA8xVy83hVkJFpGvgJO7ftK+X8iOm141gNKFn2Nlewi3xpDeR0OuTg5ep6mtfRXN71DbJZDF5Dmuk/AhXt2wwbJ/jVUT4cM=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 13:26:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 13:26:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: RE: Patch "drm/amdgpu: Add more checks to PSP mailbox" has been added
 to the 6.16-stable tree
Thread-Topic: Patch "drm/amdgpu: Add more checks to PSP mailbox" has been
 added to the 6.16-stable tree
Thread-Index: AQHcD3wiweGLShVjlkmmqkRJjqFrQ7SDHfow
Date: Thu, 4 Sep 2025 13:26:38 +0000
Message-ID:
 <BL1PR12MB5144B138DAAF8ED71C913DE4F700A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250817133749.2339174-1-sashal@kernel.org>
In-Reply-To: <20250817133749.2339174-1-sashal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-04T13:19:16.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH8PR12MB7421:EE_
x-ms-office365-filtering-correlation-id: 16440fd8-e889-4754-f288-08ddebb6add5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ww7fwS9FbOtpen2VOGsg1pgumsbdRoyouTLGfC6uwAFSuqwqc8okMh7E2gxI?=
 =?us-ascii?Q?FipPjrOyNSWaae57kQwi9G68Bfu9tiFmaE+okABYESf3kixe1l+MrstTVpJm?=
 =?us-ascii?Q?gqqr6TI/gmin5pLTiFmMV2bJ2vvjD4rVGg9A2canT6IEAkvkEN8gNiZt2wu1?=
 =?us-ascii?Q?3MqAkgdN3rsTaUHRMyJ1flZBfhdL2CtNXo+ZlAX/ytn1TCkC8S2GIsYaKCsy?=
 =?us-ascii?Q?1L3DH5ifKFjoqX3NiojVcHdTuetpnVvHV8gSPl3BYDxQF60mVXZFbff83QFp?=
 =?us-ascii?Q?SmGXsN0qKXsiCcLJe9XGpgONEPWAn4KQntlU2DqkOsFCTHTsKBqf+IU+G75N?=
 =?us-ascii?Q?Eg0XcoOgVzYHtmgGnTox+strYnx5wowO7nuy8TN3VgGDNmnHtUoF/+tq20MH?=
 =?us-ascii?Q?tUlrEkvDK5J/WbJa+AywfIJ5CvgV0kF6fv+qHHYtTbRfnib8TE3oqLZeo5Bf?=
 =?us-ascii?Q?IhImyintHZNGA6AzWpyUlB+rOKq8GvbzuCy3f62sXl9cLthQ6D8t/wUnqF8X?=
 =?us-ascii?Q?IXXo2WrIO21brntdCy4820nP9SND/tXaGBZig7q33w6v1qvvmqYzbQf6yS7+?=
 =?us-ascii?Q?4DcRoLfE08VvYhXP6J6G2CkxfxeP6OuPW/5lRfwCt6kyk2xlXO+hFa/YIZ4d?=
 =?us-ascii?Q?jsjXEml8W8pnNvcl+fKz19Ikxy7FU49I2GfTd/HNCi5qwc0qzELW6P63HrO3?=
 =?us-ascii?Q?sGBrjgWzxxbDd0/J1G1HudczuU0u1u5bS50mtBC2IQAnKLsuPGaUeX9SSs4V?=
 =?us-ascii?Q?lHGnv3mckgBRhb5/O4Ucilc7eiN+et1HN8vPXsVyYkcwhBstduSYWlmifoex?=
 =?us-ascii?Q?gsm/eMcxMswT9dTWtFCnYwIpebBwWzqn7jdEcmeEILfYwM6M8UKwdN7jEJrB?=
 =?us-ascii?Q?lRAmVfQ8zWd3cz9jZv8QPwtuCdVYXuTVrvxA4fIgi2cRAKEz42uEWaU9sdyn?=
 =?us-ascii?Q?deO7TUhzxTWCaGWoodn+PWg8/1tLUl75wmFHIoifsLNBJVU5EkfcefQRjD+A?=
 =?us-ascii?Q?Z6TzBvQyZMSH5Iu7bBOioePZeCd2gdJFxF9zUgvo9yS/0X+AhL7ADyuSldIW?=
 =?us-ascii?Q?Q2d+ZmsKsZoxnt/eG2N/yCrBhEW/lteEh8I+7WjkV09UYVzzUv3qTco48wTO?=
 =?us-ascii?Q?rPDHXxkkBLl3b6o1UxZqQjdRY13gjyyt6j41UfMO81v4zUZiWxArxqryppED?=
 =?us-ascii?Q?UWYPIZ7qtXsFmZSkyEwp24YdCrx+XzDgSNCN/P+417/CxEDbW6d9xBN9gaq3?=
 =?us-ascii?Q?ob8Rh9P1rsBcK/l/u22ENBX5V+pAW8BkfICNvBR4YqbLbeJWXR1sh23ByoS6?=
 =?us-ascii?Q?//yr2jucK+L/3MMt9wJiUA0NkxSI2hEbA5Y7Px2MW3vWV8KA4D3gyTbBatlf?=
 =?us-ascii?Q?iA4+0UOEfexdhnHw5DFRyjVxG8zr+Yj04chpn6nueg+LpL/pIcUgzCTBu4Ph?=
 =?us-ascii?Q?MHYNzshAT1k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?it5k6BtoZq0ZP0P8OYpNP6WH6MSTX3UDKK8ri8u8V7rgQPUCXyoVoiMdTkm0?=
 =?us-ascii?Q?h2OtmFaPyIX67ielG5JtEIgVW2JbOFh1TtcmUdnH7t9m6R87ItUerRy3lPx0?=
 =?us-ascii?Q?APFofV3TrFtwtlcf81CZWvkPoSMe2oljakRNKJV9UmmtOVvQ11Nm7UQq7ycv?=
 =?us-ascii?Q?8mG/t8bmqgDUxJ+IhX53kwT+wW8/QK7y6E2m8OYFDtGdzcIjRehYrWUCYz9f?=
 =?us-ascii?Q?u41Ir3ysVPdqgDXuGMH8iuwuFxrJ6GsLK1XgQqD64/9kOlKul18qrn921fml?=
 =?us-ascii?Q?1c/2aLpI1b5wH+Ivhc+kIRyUk1/5JnbBf5y8guYIKjrPQgoffKbzbW+pi6GD?=
 =?us-ascii?Q?zTiB29kf1iEUuc0MwIJdRO8JL/eXbYvfaEJZCDS9wOXFupwSf60pZErSBRxo?=
 =?us-ascii?Q?FeqEc3R5BqM9N/v991rSdlRqbM9D3Pwpu+7BjqecV63nr1ZFWshxhsqjh6Vu?=
 =?us-ascii?Q?ANBLo8RN6qu8BcpQ4GOQ/MYaN+MR+o940NOrGd7yvNJysaBisBhCbhmSD72S?=
 =?us-ascii?Q?J08wHBbLny8/UuAfvzAhcFCpYu5ofmk9MqLjI/CQLpY9snoPLu9pMndHROaM?=
 =?us-ascii?Q?KBKDuxFjEWUWfsWPq02A9dn+SPNUyfz9zEDkVhQRskCo541tGNT6umXwARE2?=
 =?us-ascii?Q?Podehap7IMQC0DRNByk34+/pMfhi2aFlIeorJistlmGNOReBqrsOKvr5iHBe?=
 =?us-ascii?Q?Lubo7XYZex+MkkdrRxJaPCvboxVvxzPZ4jLzd8Gln9h8150IFCRYzCPkB6UZ?=
 =?us-ascii?Q?fEvUsOokycUoeaAsMMAnz2vG2rr8vonSe+ha+bsSg7MY05JDevzXLl8LcneF?=
 =?us-ascii?Q?9BqVtunTVZ8DMZBzshNFam17J3MewxjayX/Yx6j+XhJwCShqMq3p6hqZH47r?=
 =?us-ascii?Q?zixoJsIQIwrqR7Q/Qfx+nLlFlbt9WBmblKYGfYpLpNHN9G2IRu/sGfQa/Dck?=
 =?us-ascii?Q?8VArzeom4xPvZJgUHs3sLHcHg16wzlO0Tx3zYNQHpWBrbPeJYEjjFlA4d7mw?=
 =?us-ascii?Q?VgqDzo3BW2Poqf8fMyZzecyV+K79ErcdAUvROypb5AI7Qx58g1V6qgDonb61?=
 =?us-ascii?Q?UEt1a4hOCPsLkCAig0dxwZxGTE6TFSDpejPIrEr141kxjCT1IKBwO8XbzGUO?=
 =?us-ascii?Q?EouCrQsSsD5tXaJ8THQoshAUxdeBjWt4LcH7ytrZ46y7xR71iXzLynWiVm0W?=
 =?us-ascii?Q?rvSkxVIe1t1T1kNGj6q9EU9TA7RCJYVRlNOe0WFjmSxmtiX1+X+0XLvM1032?=
 =?us-ascii?Q?MYahgBZGV8aEdEFiKArtfaCA6pGUkLfXoeTUNdZw2xAu+QI0UyG5xcgZEeKd?=
 =?us-ascii?Q?wSkR3H/n0dhgWCaUW8qMVoYQi0sWUDYMc50Bt3Pl97HNcqb34Cf5B5xnXOU6?=
 =?us-ascii?Q?usErqxqI4dAzhRL71gH5s/ADUperJXKBNtL1SfIhMp4dpe3wPxggS1sN8IZm?=
 =?us-ascii?Q?d+wcxfOKsWazibs6ZDCPguPWpiSPqzr6th7tcg8xqPXM38OHfr/k77zVmrFn?=
 =?us-ascii?Q?S1aLUD17gyG67vaACQoD8Id98OXte38hJyykhmun3cqaoLv6ijHEsL8nINo6?=
 =?us-ascii?Q?fZOJB5dTR29KhsGvgow=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 16440fd8-e889-4754-f288-08ddebb6add5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 13:26:38.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uv2qbcnX22XRd9QVaTAIt95Ybz4xVbktSQ0R8I6mVCmrnF8+z8Bmg3YD5fE1K0mCBpTnBtDBRtCIZj8ziLIboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421

[Public]

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Sunday, August 17, 2025 9:38 AM
> To: stable-commits@vger.kernel.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; David Airlie <airlied@gmail.com>; Simona Vett=
er
> <simona@ffwll.ch>
> Subject: Patch "drm/amdgpu: Add more checks to PSP mailbox" has been adde=
d to
> the 6.16-stable tree
>
> This is a note to let you know that I've just added the patch titled
>
>     drm/amdgpu: Add more checks to PSP mailbox
>
> to the 6.16-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      drm-amdgpu-add-more-checks-to-psp-mailbox.patch
> and it can be found in the queue-6.16 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree, =
please let
> <stable@vger.kernel.org> know about it.
>


Please drop this patch for 6.16.  It's not for stable and causes regression=
s on 6.16.

Alex


>
>
> commit eb1b9227a503b05c0afd067598c7bcef1e8801cf
> Author: Lijo Lazar <lijo.lazar@amd.com>
> Date:   Mon Jun 2 12:55:14 2025 +0530
>
>     drm/amdgpu: Add more checks to PSP mailbox
>
>     [ Upstream commit 8345a71fc54b28e4d13a759c45ce2664d8540d28 ]
>
>     Instead of checking the response flag, use status mask also to check
>     against any unexpected failures like a device drop. Also, log error i=
f
>     waiting on a psp response fails/times out.
>
>     Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>     Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c14f63cefe67..7d8b98aa5271 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -596,6 +596,10 @@ int psp_wait_for(struct psp_context *psp, uint32_t
> reg_index,
>               udelay(1);
>       }
>
> +     dev_err(adev->dev,
> +             "psp reg (0x%x) wait timed out, mask: %x, read: %x exp: %x"=
,
> +             reg_index, mask, val, reg_val);
> +
>       return -ETIME;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 428adc7f741d..a4a00855d0b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -51,6 +51,17 @@
>  #define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10  #define
> C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
>
> +/* Command register bit 31 set to indicate readiness */ #define
> +MBOX_TOS_READY_FLAG (GFX_FLAG_RESPONSE) #define
> MBOX_TOS_READY_MASK
> +(GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
> +
> +/* Values to check for a successful GFX_CMD response wait. Check
> +against
> + * both status bits and response state - helps to detect a command
> +failure
> + * or other unexpected cases like a device drop reading all 0xFFs  */
> +#define MBOX_TOS_RESP_FLAG (GFX_FLAG_RESPONSE) #define
> +MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK |
> GFX_CMD_STATUS_MASK)
> +
>  extern const struct attribute_group amdgpu_flash_attr_group;
>
>  enum psp_shared_mem_size {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> index 145186a1e48f..2c4ebd98927f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
> @@ -94,7 +94,7 @@ static int psp_v10_0_ring_create(struct psp_context *ps=
p,
>
>       /* Wait for response flag (bit 31) in C2PMSG_64 */
>       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                        0x80000000, 0x8000FFFF, false);
> +                        MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       return ret;
>  }
> @@ -115,7 +115,7 @@ static int psp_v10_0_ring_stop(struct psp_context *ps=
p,
>
>       /* Wait for response flag (bit 31) in C2PMSG_64 */
>       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                        0x80000000, 0x80000000, false);
> +                        MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 215543575f47..1a4a26e6ffd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -277,11 +277,13 @@ static int psp_v11_0_ring_stop(struct psp_context *=
psp,
>
>       /* Wait for response flag (bit 31) */
>       if (amdgpu_sriov_vf(adev))
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       else
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       return ret;
>  }
> @@ -317,13 +319,15 @@ static int psp_v11_0_ring_create(struct psp_context
> *psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_101 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       } else {
>               /* Wait for sOS ready for ring creation */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK,
> false);
>               if (ret) {
>                       DRM_ERROR("Failed to wait for sOS ready for ring
> creation\n");
>                       return ret;
> @@ -347,8 +351,9 @@ static int psp_v11_0_ring_create(struct psp_context *=
psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_64 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;
> @@ -381,7 +386,8 @@ static int psp_v11_0_mode1_reset(struct psp_context
> *psp)
>
>       offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
>
> -     ret =3D psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
> +     ret =3D psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
> +                        MBOX_TOS_READY_MASK, false);
>
>       if (ret) {
>               DRM_INFO("psp is not working correctly before mode1 reset!\=
n");
> @@ -395,7 +401,8 @@ static int psp_v11_0_mode1_reset(struct psp_context
> *psp)
>
>       offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
>
> -     ret =3D psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
> +     ret =3D psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG,
> MBOX_TOS_RESP_MASK,
> +                        false);
>
>       if (ret) {
>               DRM_INFO("psp mode 1 reset failed!\n"); diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
> index 5697760a819b..338d015c0f2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
> @@ -41,8 +41,9 @@ static int psp_v11_0_8_ring_stop(struct psp_context *ps=
p,
>               /* there might be handshake issue with hardware which needs=
 delay
> */
>               mdelay(20);
>               /* Wait for response flag (bit 31) */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       } else {
>               /* Write the ring destroy command*/
>               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, @@ -50,8
> +51,9 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
>               /* there might be handshake issue with hardware which needs=
 delay
> */
>               mdelay(20);
>               /* Wait for response flag (bit 31) */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;
> @@ -87,13 +89,15 @@ static int psp_v11_0_8_ring_create(struct psp_context
> *psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_101 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       } else {
>               /* Wait for sOS ready for ring creation */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK,
> false);
>               if (ret) {
>                       DRM_ERROR("Failed to wait for trust OS ready for ri=
ng
> creation\n");
>                       return ret;
> @@ -117,8 +121,9 @@ static int psp_v11_0_8_ring_create(struct psp_context
> *psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_64 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> index 80153f837470..d54b3e0fabaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -163,7 +163,7 @@ static int psp_v12_0_ring_create(struct psp_context *=
psp,
>
>       /* Wait for response flag (bit 31) in C2PMSG_64 */
>       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                        0x80000000, 0x8000FFFF, false);
> +                        MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       return ret;
>  }
> @@ -184,11 +184,13 @@ static int psp_v12_0_ring_stop(struct psp_context *=
psp,
>
>       /* Wait for response flag (bit 31) */
>       if (amdgpu_sriov_vf(adev))
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       else
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> mmMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       return ret;
>  }
> @@ -219,7 +221,8 @@ static int psp_v12_0_mode1_reset(struct psp_context
> *psp)
>
>       offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
>
> -     ret =3D psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
> +     ret =3D psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
> +                        MBOX_TOS_READY_MASK, false);
>
>       if (ret) {
>               DRM_INFO("psp is not working correctly before mode1 reset!\=
n");
> @@ -233,7 +236,8 @@ static int psp_v12_0_mode1_reset(struct psp_context
> *psp)
>
>       offset =3D SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
>
> -     ret =3D psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
> +     ret =3D psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG,
> MBOX_TOS_RESP_MASK,
> +                        false);
>
>       if (ret) {
>               DRM_INFO("psp mode 1 reset failed!\n"); diff --git
> a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index ead616c11705..58b6b64dcd68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -384,8 +384,9 @@ static int psp_v13_0_ring_stop(struct psp_context *ps=
p,
>               /* there might be handshake issue with hardware which needs=
 delay
> */
>               mdelay(20);
>               /* Wait for response flag (bit 31) */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       } else {
>               /* Write the ring destroy command*/
>               WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64, @@ -
> 393,8 +394,9 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
>               /* there might be handshake issue with hardware which needs=
 delay
> */
>               mdelay(20);
>               /* Wait for response flag (bit 31) */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;
> @@ -430,13 +432,15 @@ static int psp_v13_0_ring_create(struct psp_context
> *psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_101 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       } else {
>               /* Wait for sOS ready for ring creation */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK,
> false);
>               if (ret) {
>                       DRM_ERROR("Failed to wait for trust OS ready for ri=
ng
> creation\n");
>                       return ret;
> @@ -460,8 +464,9 @@ static int psp_v13_0_ring_create(struct psp_context *=
psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_64 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> index eaa5512a21da..f65af52c1c19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
> @@ -204,8 +204,9 @@ static int psp_v13_0_4_ring_stop(struct psp_context *=
psp,
>               /* there might be handshake issue with hardware which needs=
 delay
> */
>               mdelay(20);
>               /* Wait for response flag (bit 31) */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       } else {
>               /* Write the ring destroy command*/
>               WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64, @@ -
> 213,8 +214,9 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
>               /* there might be handshake issue with hardware which needs=
 delay
> */
>               mdelay(20);
>               /* Wait for response flag (bit 31) */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;
> @@ -250,13 +252,15 @@ static int psp_v13_0_4_ring_create(struct psp_conte=
xt
> *psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_101 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       } else {
>               /* Wait for sOS ready for ring creation */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK,
> false);
>               if (ret) {
>                       DRM_ERROR("Failed to wait for trust OS ready for ri=
ng
> creation\n");
>                       return ret;
> @@ -280,8 +284,9 @@ static int psp_v13_0_4_ring_create(struct psp_context
> *psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_64 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMP0_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> index 256288c6cd78..ffa47c7d24c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
> @@ -248,8 +248,9 @@ static int psp_v14_0_ring_stop(struct psp_context *ps=
p,
>               /* there might be handshake issue with hardware which needs=
 delay
> */
>               mdelay(20);
>               /* Wait for response flag (bit 31) */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_101),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       } else {
>               /* Write the ring destroy command*/
>               WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, @@ -
> 257,8 +258,9 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
>               /* there might be handshake issue with hardware which needs=
 delay
> */
>               mdelay(20);
>               /* Wait for response flag (bit 31) */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;
> @@ -294,13 +296,15 @@ static int psp_v14_0_ring_create(struct psp_context
> *psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_101 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_101),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_101),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>
>       } else {
>               /* Wait for sOS ready for ring creation */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_64),
> -                                0x80000000, 0x80000000, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_64),
> +                     MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK,
> false);
>               if (ret) {
>                       DRM_ERROR("Failed to wait for trust OS ready for ri=
ng
> creation\n");
>                       return ret;
> @@ -324,8 +328,9 @@ static int psp_v14_0_ring_create(struct psp_context *=
psp,
>               mdelay(20);
>
>               /* Wait for response flag (bit 31) in C2PMSG_64 */
> -             ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_64),
> -                                0x80000000, 0x8000FFFF, false);
> +             ret =3D psp_wait_for(
> +                     psp, SOC15_REG_OFFSET(MP0, 0,
> regMPASP_SMN_C2PMSG_64),
> +                     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
> false);
>       }
>
>       return ret;

