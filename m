Return-Path: <stable+bounces-98164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E0E9E2BD6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFDB284931
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D620371A;
	Tue,  3 Dec 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ONGiqVM7"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB21FE461;
	Tue,  3 Dec 2024 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253464; cv=fail; b=f1iLWGA7aKrUvannD+Sts31ATJ1Svgu0czVCzOk4/cPjh4vVbzTjCfFqkpW5UuHjY5CBf5iLoS3svFYAEduhKipKbU0xYDlYjyHMt1abPHv1jAH4uh43a+M0+HBFavV9ZLgiK9lmdpu6cOt6oZLNnenylANusVrDlY9zxkGy4jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253464; c=relaxed/simple;
	bh=7bVkjQdP4rSHPE/0Io2LrX6VHhV9itRvg7SgleaQuNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l5kI9RVuZYYMuzlO5vLz74E4pthoUZqkmsOmJJzXjYuWb4hFc/28LqsZ3xcGwaXJNmoaaHpu0wQ0zZWPPI3F2eIYBsBrexoN4YsO5RIOLrfS9Dyt2mlfnYPnWQGo3EBnOFlJnhjVXL6cgXAoywyifBE6/bYWgOlj7YkmLLBZZlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ONGiqVM7; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH7GYR28tHtc12KTRTRhne9hlEg6P8UwUW6LIEFbkU5BOjDioSnEGvMi7oOe+BmDOy2FXAkRUl6YAOtgzqj1HgDyT26ZXZPDm61WGGdk2ZgAUwfONUTrVF6Azu/zLNiU+nVyn0pFUPUsmZISeMmwDZGFRaWn4WIakA0IuuZIEvLu6EGpXBeZDR+/TlAaY+qdul2hCYd1BfU0vkHjNueVOY2HfOgXaEu5o+sCA+itIgzbhTG1iDfnlD8O5ZO+vc+PPvwA1HO+QFOqZllGn2XwXXEY6e41zISiv28dXWKoXL4HVfbtvXY3XcCEpDoJDU+1coGYAdmo/26/TnwSwgvD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bVkjQdP4rSHPE/0Io2LrX6VHhV9itRvg7SgleaQuNc=;
 b=VxzwiNIrF2sF3S8dh+LUYsjpsZeqAZZqf/ESbdh3ao0qBL4JnVcmXy5O+H71e2fLf/awSHieUV3voRrqjfQpARK97jhjE51AGrXK2qWBhm9zEmcDeTdaAnLMoOJC3I3YWeVbXMPJ8AAeC6NVHHG9tSLKywZuOXUvoXAlgTXGcHm9STnkwF5ZLe41gIShz8ryNTESHAf8nIGhpdgC+SLhT12outi3HYovHPXerbRxqA3C4RHqPW92RoXeBCkN3mol3fSjBEEFYmqkOn5ebGqnF1Ddjwpv4mgiHFpbJNOWyvS0lLwWsTm6uD/Jie4sT1VP/Qi09C6lCeRtehEG+/HP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bVkjQdP4rSHPE/0Io2LrX6VHhV9itRvg7SgleaQuNc=;
 b=ONGiqVM7oRUWg2uYGpGesZHusYMC1ktJ18VZxnfr7OR6y78mAu2A5JyBcuO3JYufYB2ENoVa9+iFAXN1mASVLUwtmcMDoZ/q0Xvw9sHuBpHMCw24c0CK+5Z4S3OqO7PotdhXktE+f+oyHufzZVY0qkG6Di/u9jGERN3cuSPo64Y=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 19:17:39 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 19:17:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>, Zhang Zekun
	<zhangzekun11@huawei.com>
CC: "cve@kernel.org" <cve@kernel.org>, "linux-cve-announce@vger.kernel.org"
	<linux-cve-announce@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
	"liuyongqiang13@huawei.com" <liuyongqiang13@huawei.com>
Subject: RE: Possible wrong fix patch for some stable branches
Thread-Topic: Possible wrong fix patch for some stable branches
Thread-Index: AQHbRSjlSuJEQaJVPUibAGMKTzihXbLUNlwAgACuZaA=
Date: Tue, 3 Dec 2024 19:17:36 +0000
Message-ID:
 <BL1PR12MB51442379F8F2141093B44F46F7362@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <2024111943-CVE-2024-50282-1579@gregkh>
 <20241203020651.100855-1-zhangzekun11@huawei.com>
 <2024120351-slighted-canary-12a2@gregkh>
In-Reply-To: <2024120351-slighted-canary-12a2@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3e0eca93-d43d-403b-8707-8254d965eb9d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-03T19:14:20Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB8829:EE_
x-ms-office365-filtering-correlation-id: 052d6b2c-cefe-4884-9c32-08dd13cf25ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bVmciF/tBpTOpCUNDjKht8ZB8madbQ+LFisxW6q0eQAvv0FS2deRVttZymkF?=
 =?us-ascii?Q?V1vU0gweEl56k0Pv43BoT8v3pDh8T09gHNgPoG3bHE7YzrkChJohi55r5ptn?=
 =?us-ascii?Q?uwcAqMtjG/RwaAdj+uKwCrsWABvG4KsjGjIAVyj+sha/Jyc/N/ASIsil0wN4?=
 =?us-ascii?Q?DweplO7XiO7WaAlQKrs1Vkmt47Nq9UEXA0UW46riAWwtNowwnUasYJIeP8cE?=
 =?us-ascii?Q?tvosI/KtF0Cbg4MgNGfSVoxCQmFS8ObHBEAckHGJYZM5aqAtsgdzvyCcmCA9?=
 =?us-ascii?Q?XeAsH54+gwO4dw0fo3kclvifp8R5pb/t7MDCXa9ZSq0RMOxEy76J82TJ5V86?=
 =?us-ascii?Q?WbteiT5apNsZ0she2Fz18/LzcW6+DlxruzJUOQl5wtTs5ureWQbKifIuE99U?=
 =?us-ascii?Q?crd91OoRV+yucC/LTZ71rQeXhg34cp3U8q0ir45ZILf6mGVn4Uc2RFAGSD19?=
 =?us-ascii?Q?Tse2w0/rTP4vcodMic1pXR/fLSqSpCWfKx8F5M/XX2SMNRhYRzOJ7wp448Pk?=
 =?us-ascii?Q?lixaAmod8rf06s8PIWDxzKoqNVpG2YWx1DpmEvyeX4xFEVUunBPPxt0/48wZ?=
 =?us-ascii?Q?FbWnA4xCVSxe1Vu/fhmRGPEGVE8i9k30vT/ZJKynbPnmaR2NIhW4Jv0DHTbO?=
 =?us-ascii?Q?rRx4CsKOj0YS59rYGWxVkLLa4k4sNX/xauqSYMnzNEZc402a3gU8ufhRqTVb?=
 =?us-ascii?Q?UygKMfPDGYK++YT09ui+tQfR7ks2+zx8KfKNlSv8ZylVcpkDhoqV4C1Lj5k0?=
 =?us-ascii?Q?qHDYS5vWGUD+pXm4KUX/75djOOB36P48t9yUiqbfgDpKGKp92u1UrjUUNSZO?=
 =?us-ascii?Q?JPufkXLAjYEkQ/EMZY343li5LvAL6wqB4ryiTfz3USIImzkQn6JeaZwnGLYM?=
 =?us-ascii?Q?umWp6t9SrdK0J+v5XM3GhTJsLB2ipszX+0e4axX+i+5h/Zv9NgK9yFd1GOWH?=
 =?us-ascii?Q?IMREtnZ3MO04HBC1LGj3LgwK5GbtWkuXA0VIywPkPzSSnvOCZeXPFBPFq5w5?=
 =?us-ascii?Q?shsXjepkVM1J9Mj0ij1Li9TS7edrPguhB93sxR9wRFtN0mUWL7ES8S9NJrzM?=
 =?us-ascii?Q?YCNH1eXUpKBSDbLawgaHgPSWt0blGHdzx0QE6z9UoGC5f+Ood+/T8RCv2bk2?=
 =?us-ascii?Q?mmZQtenZnGdibqW3q1wCq395ExvT0FeVnGmKg2+5H0VMXP6DXDqjXQE4wdFy?=
 =?us-ascii?Q?9JmhaIGRJc0V8h6c3zs4t/O6iaGT88/3h5pNP0hBh30ndeRyWDGBB4JcgeRf?=
 =?us-ascii?Q?GP+pHEB19UnwbHkpnZvMpsmP8A41jJZ1bZa14DXofPqixveqIUMKeOyp6MN0?=
 =?us-ascii?Q?I/Bj2JEJcoqHI5ALlkWdNYy9ycQ7jQSbKKuqE/Eux79wcKhXrpImfCNanDYw?=
 =?us-ascii?Q?UXbWUFCWW2J8ykmV7W0PaAaT7eOAwMzL3GZ9vsB2NaMmFnkTWw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jULqtnEf0cRnu4QJcFyKF0ZDY5/h6u2OjVqrJu1nJyNsALTqoWeAB9yWglAE?=
 =?us-ascii?Q?KMxqoudtYwvwo464zEAPNoIGHPAr2PtjW6D9ZK7yum0vAZs7WxqueBPQ8Pn2?=
 =?us-ascii?Q?pg0Sdj1tSc0s42xLPZ8O/Ic9Iwyt7HdhKdiwMkQUieR3kzF2w2J/JC1mz/J0?=
 =?us-ascii?Q?p/Rrw1BVv92TjhTYMOtspgI4yFJe0drzmwGc4Sv8b0MQPSUtjl5jHUwd04o3?=
 =?us-ascii?Q?cf6nKjidhx161adGcSa9QDnRJpWqJ1IBnv6RtdCU4i2zY+shHtVrnSd3V1sk?=
 =?us-ascii?Q?0FOegOsXKGRos18k+FfN2hdwj6+NzeKxHeusgi/yIk/4SYzxHVhf5+AmJff0?=
 =?us-ascii?Q?wp+abneuHBUzuo5rMSFw9DEnArUqeaepqrMLCH+mNGG6biPCiRFvgAoKPm2T?=
 =?us-ascii?Q?/511YHPTvMqy7TUmd7GkSk4uaHZIA2BcoT4EXD8Jt21A5F04wleihRzK0DCG?=
 =?us-ascii?Q?Lct9s0ekH0lmWvaGycu4nWCy4YU/QtMi9IunRfBtljSD+YygvgcgQXN6mqho?=
 =?us-ascii?Q?dwk9UFxmqjt9rj/IqgvL3PYEENE/CSgZwZpzZ/iSo2lXPPx22akMhSxMxYtw?=
 =?us-ascii?Q?39aAEPXjsJwI3abw8/ia4gsnXA/PEcxhJ+7JSvAM/hEbZ1Wm6buOsODwC7tX?=
 =?us-ascii?Q?jiNID5hsOBOkTEBh2Wa5idR0EwBh+RDDCgMsCP+ZTCCsK+uVKzVIVxKh3Bvr?=
 =?us-ascii?Q?JCCEwU6C8D8i++gno8PvDRWznMvZf1dfJsLmYieWXuapSGXmY+jpLdK215OJ?=
 =?us-ascii?Q?dArHDCumruRkzR/QmdjL6/X2QEl+ZzfjNZG1Bc0QMNUnWBk9HxIcYUbjKaPg?=
 =?us-ascii?Q?bB8zPXQ57fTzaBajsBAyjTD0qQa1+UANiudXWydl82Y6XKfqMdUGOO/uHDXd?=
 =?us-ascii?Q?kTXvrKZ3y0kvz/r5R5yflUbC9AHplsKUTOW7wnot4oWc6AdNHPo16MzeW+hx?=
 =?us-ascii?Q?g3wo157L9pmL7iAEL72jjfGnJgxV+sjtejv/QerdxxecO00Zpe1ut3326dIM?=
 =?us-ascii?Q?U3UvLCHtBIlZDnrxumwfolqaJdbPV9LUiSHNzKz1deLPcIjJEADTY35/glsu?=
 =?us-ascii?Q?HnTVzk0YJFCSoVrkMakxVE1XueSVt2OpPKJVEsc6FabxNuHDFVOgvi89vVQY?=
 =?us-ascii?Q?4GHQxraM29GPV2VLpKE8/R55XMghRss+L5pnNqKgzjaQUjmZ/ZOr1PRkK+8q?=
 =?us-ascii?Q?kjbXlUH2bKTV9mD4fCaJHL8LqpBjtzMLXGEALwZ+BdGKt6FmJN9RAFpfQGaM?=
 =?us-ascii?Q?qd/JEDcUGPwwViBS+eB9GNAy629xI4BlSK5hAxvtLeMtXkM39vM1soMQFb+2?=
 =?us-ascii?Q?7TUDCp9ItqY04nuGxZ1STAod5cgQuGCtup5UOXS58xqWzvXKSIQxwwWWtK/p?=
 =?us-ascii?Q?D8tmTLSzgoQQw1N2qC/6JOp+VinRI79PuI1PrHoRnPd+vVk5dDq5TMZMd5EN?=
 =?us-ascii?Q?JPbShCnFyBBIAdd2mGZ4nVNDjNViQkxnM5Rs1tNOH11wOxK2E7lhUaF1un8C?=
 =?us-ascii?Q?tvgkG0S75GnWLkZrCODUAUJMjN471Xke5N034TwtHomS96hHi9ZJai/ktr2F?=
 =?us-ascii?Q?7gBPPChYNVr86jkAb9g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 052d6b2c-cefe-4884-9c32-08dd13cf25ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 19:17:36.8199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZxiOMAZTOw+wwR9FTKR8bHiaTETncDl+VKcCnHzFK0erZAzeT+TALZjCzEVHhDJurTJbTppJogJqcIDlg/lGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829

[Public]

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Tuesday, December 3, 2024 3:50 AM
> To: Zhang Zekun <zhangzekun11@huawei.com>
> Cc: cve@kernel.org; linux-cve-announce@vger.kernel.org; stable@vger.kerne=
l.org;
> Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; liuyongqiang13@huawei.com
> Subject: Re: Possible wrong fix patch for some stable branches
>
> On Tue, Dec 03, 2024 at 10:06:51AM +0800, Zhang Zekun wrote:
> > Hi, All
> >
> > The mainline patch to fix CVE-2024-50282 add a check to fix a potential=
 buffer
> overflow issue in amdgpu_debugfs_gprwave_read() which is introduced in co=
mmit
> 553f973a0d7b ("drm/amd/amdgpu: Update debugfs for XCC support (v3)"), but
> some linux-stable fix patches add the check in some other funcitons, is s=
omething
> wrong here?
> >
> > Stable version which contain the suspicious patches:
> > Fixed in 4.19.324 with commit 673bdb4200c0: Fixed in
> > amdgpu_debugfs_regs_smc_read() Fixed in 5.4.286 with commit
> > 7ccd781794d2: Fixed in amdgpu_debugfs_regs_smc_read() Fixed in
> > 5.10.230 with commit 17f5f18085ac: Fixed in
> > amdgpu_debugfs_regs_pcie_write() Fixed in 5.15.172 with commit
> > aaf6160a4b7f: Fixed in amdgpu_debugfs_regs_didt_write() Fixed in
> > 6.1.117 with commit 25d7e84343e1: Fixed in
> > amdgpu_debugfs_regs_pcie_write()
> >
> > Link to mainline fix patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
> > mit/?id=3D4d75b9468021c73108b4439794d69e892b1d24e3
>
> If this is incorrect, can you send patches fixing this up?

All of these should be reverted:
4.19.324 with commit 673bdb4200c0
5.4.286 with commit 7ccd781794d2
5.10.230 with commit 17f5f18085ac
5.15.172 with commit aaf6160a4b7f
6.1.117 with commit 25d7e84343e1

The function which was patched didn't exist in kernel 6.1 and older kernels=
 and the patches ended up patching a different function in the same file in=
stead.

Thanks,

Alex

>
> thanks,
>
> greg k-h

