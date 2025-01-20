Return-Path: <stable+bounces-109564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC413A16FED
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 17:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D091D3A8A4E
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B751E98E6;
	Mon, 20 Jan 2025 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1sz1fhfB"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2066.outbound.protection.outlook.com [40.107.100.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3654765
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389701; cv=fail; b=tnj7iAABYtzMJ04CjjvHgjA/6fujKHPtc9qu7bsVKFQfvHKIK3YbVXpemm4SDzRLK79qnFgla8CTOJNh962MwfW0vlMPn+cgk9M9AFgOFA8ujs39LGkupW6Ese6Qo8X5KX2sApIRquKk1vH6ImpgHx77KfDOJZPAXncNUk8sZU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389701; c=relaxed/simple;
	bh=YGTOiyuoOG3dEKPEt7AJJUT5eG2tRg/pMJeZjKyiCBA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WlEn0N7v+IJiIhAgYQaixcVxUdds8ft4fwvtv/BXlGVqBPvl2/OChYtvsptoJiGNzghx17VdMlFPx9E9JV9tojsb09Vmc4cjH9h7Tj7gHfPBQGHQ/MGOEH30jzKrW078/dnZMZJRcputbjYETJXXRzn5JpmG+jnzU1Xnq87cPas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1sz1fhfB; arc=fail smtp.client-ip=40.107.100.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESH8RoMa7J4UA7agFp7Y6DiJiuADz2U2cD1qsvpS/7YQjscDwfYZNiX6tup+cNT1NcpsfHHv7oIKzUyBwmozUXbQNBN25j900U1tfnSiEgIAAPE4CNv/Pr3HuucDUxrfm5fAAn4xCqD69c4tzRqNx2TP78Vi/mX0PfO1DGPHMtfaQyAq9H6SztJejlkFxGdWR0/gtG+KAoxhafXnavjjCUGPHdxfJfzeSRY0NONA6ZD18UMqthmXQzohs9epZBJziPfhj3r7Pznp8E9pY8WNAcNirKF9bpLE2zmPxJsjnwxdYJl1PUjeKSqHHbbJF4DkWjZrkh8T4hsFbL1MyKnpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05hOvvDcKUBBllZcot3U8LhLf8NjHH671GExhXNCKEg=;
 b=ufF7Re4EzT+2uq3knp8qXUhcrd6rMumRtUCI+haf/mAjPcNRRv8ZFyxL5bIt36uHcziFKzj5FpSRa76Fxvmt1vOOFWr+SC1Q84cNgTQGu5KxQzHu+JclO5kV7p4x8DX+qV+ZHa8Y7YnTuH54UibVEMS5JZdNQPNi/bBi3iAzo3z9eoHo5cyl9DjWbABM66ZiSH2OWibJ/T+irPCspG5Igk2MZjLpCLxNsOdLmnfLC4GuchT0Y115cfv3v5BE6WDtcPuuTsVmz0YwhMkWPvOY+DXTZJmB8k9rZc1CRMZsNegktrNRN8Zs+m7oi+UX6pWXn/dqa5xNfqUsBneZUMDTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05hOvvDcKUBBllZcot3U8LhLf8NjHH671GExhXNCKEg=;
 b=1sz1fhfBSTn0rFBzZq93UuY1sbteB8KtzMSF8REFP/Ese9JBqA5vgaSXHDrdu6G6GfaazzlTWwoPNAu7tFL/oEdT1fcZgRiIRqi29m7IawgqqlBd0x9QTHfom1Tk6ImBNt/ZBLb9FqOGpj0nVi+ys5GyVQZoct+kAEfTKgQ18yI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 16:14:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 16:14:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Sasha Levin
	<sashal@kernel.org>
Subject: Reverts for 6.6, 6.1, 5.15
Thread-Topic: Reverts for 6.6, 6.1, 5.15
Thread-Index: AdtrU/ut/zy5rmCfRsiyFWsKDtl2VQ==
Date: Mon, 20 Jan 2025 16:14:56 +0000
Message-ID:
 <BL1PR12MB5144D5363FCE6F2FD3502534F7E72@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=96dbbc58-4315-4912-827f-149ee7ab1641;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-20T15:56:58Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ2PR12MB8955:EE_
x-ms-office365-filtering-correlation-id: e8cfb9c3-9f80-4828-cd15-08dd396d94e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UhgiPkpNxYJKmKQMnQgqOv+Vpl7GEfhfSDrkqNAvb5aOAZwOlh/qA1upazaF?=
 =?us-ascii?Q?VGXJ9iKTY+PwzJJ0O5nBPnbSdvPlkpJdYD19m5RexRzNLw4yUtfbyjrfchwN?=
 =?us-ascii?Q?gC6FlzH/NIW7U1hXHxJBPtxBHXGVlkdMg1L64QO9rmpFPa3pGPzkVxqr+Tbn?=
 =?us-ascii?Q?5bf7ZFdyeNaBB0pxY3XdelJWSFK7u6PvcslMtDjA8PQVB0oPlv6DSptPSGZj?=
 =?us-ascii?Q?GpAQBZbxtCLD/QqQ0L4g+ZLELy59sfaqLBiwS6Vkhyue1VX33d5qxbNN98A5?=
 =?us-ascii?Q?eNhcdm17tnOIHUMYPNIMqwHWKF8rxSjH8S0tpuaJLcPjE4X9RZx+ZW3lh49g?=
 =?us-ascii?Q?x4v2Qk2zV706KUaAbt+mAdiy2zkctsxp8MDhOBwING+I9iKOlonUh9mKL/qX?=
 =?us-ascii?Q?xUp/GC6jF+CjK4X6y6MuvtB0E7yMmu95NQ1g7cauBlLOOdlX9GL8pFMTgV+u?=
 =?us-ascii?Q?JmAk3w94B5wNjBfywogAYPBYBAOpN/1EGPzAz9UzkitjW6VkmMCmkmPY33UE?=
 =?us-ascii?Q?VPeW8U4v+duxVNLEAdWYhhhuCk142g8JwKBEhHY2ErNhVMVScgs+fMukH+OF?=
 =?us-ascii?Q?rDfyoQHF3OlBCNt6GdR0s42hYbgAvtoygnxL1MSRYEIXIlamMTtSUD69AvLc?=
 =?us-ascii?Q?ZqjFCI/QbcQ87BscNEK0KzHmpPqwEPqEz8ZUNdA6+TrdfuVEuvUYgWdiV0IY?=
 =?us-ascii?Q?kqMSGIT3N7QUK+aKQDsdHu5+zdPMWS7AvBh9gSe0E8hNSYoAFrEAGkAOyx0P?=
 =?us-ascii?Q?HxfoxgOFMVk8EfkGpZuYrtn/XMVWREuOHw6uetkKQDJPJ7oc071YBn7YHe/p?=
 =?us-ascii?Q?yY3pZp6vZvcMFD8iw3YhJjEkZDG1HAX9KM2spLFiQMzXmCtdae+s4rG5gZLK?=
 =?us-ascii?Q?MsDmH0zchO1n6Pr+MbiKXKAO/ARBxcgpl50JB5IrBbZqoDu6FNveqFcUpAhX?=
 =?us-ascii?Q?SWDGguL92wf69Gixg5Xyq3zKVt/hnCTs2vGRpzH+2cHMwqcvXnr6GZExnrz+?=
 =?us-ascii?Q?Z+4ZNvnyiEWR70m33+N006wjYEn/7+ue0gAeleOrBTGfQejNyGMD+7Cy0xNq?=
 =?us-ascii?Q?UgLzajIsXDmYsRxUfdatC5tWMsQIqx8qMXdE3TwgtuAhTUH7YPSBwtxmGEWO?=
 =?us-ascii?Q?xoUHeMnHT6xZ5GFmLCJD/iuMCGHndPu7SKA31GzL5t0wL2lU8EfugHfCdYPR?=
 =?us-ascii?Q?YbbHe5Htc5ejwkQuQjCwECilapd45DFzd1FOQeHWP8TM9sEataxrtykNCdMx?=
 =?us-ascii?Q?SbuFrtQkigj+U3ra2WrCxA2Y3HnvggEcmDedUQ2exK3Vo0x2Mi0/63qG9+p9?=
 =?us-ascii?Q?hOPQZZTw8jZjdU6jMMoYy4ehvxpgoXS2+xTRDNRlnnVAEAvgMgv+DyDMZU3A?=
 =?us-ascii?Q?GnzH4JS/CnZw7/KWuLHuWeammEZdD6ahsKiiQnkKEffM98iTFE125p+S5b02?=
 =?us-ascii?Q?iE2h1ZIkGt24x4SjlmAj+B6X5F+1M6xO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Vj+r2bPHjIuz1ir4bwNVoAj/MEyh69qlDMeglkn9q+1Gpqhx/PuGiTWVY/sv?=
 =?us-ascii?Q?eu00q2r3zMaokzIcAM1N5hpDii3N4YFzelqgL6bS6PW9s5adHtXW6IDUAmOc?=
 =?us-ascii?Q?u/sVXeL2mKQJ2ZIFr8R3GVoVRwk5EAFBld0weCdHcYsg3nrWVoAcbPlECOCY?=
 =?us-ascii?Q?BU/HRLVzhCEHaawJzahE28SUoMCrnIGEx6umDqLmecN8zLE6AHwY7McHZ2vD?=
 =?us-ascii?Q?oLXjOYbqpd6duG4eOtd/IVv+Xi2e5kx+XBCutEMrTDx/DSeAToK7GMvI3cYZ?=
 =?us-ascii?Q?UacLzVdYF8PkRkDQlKvLgi4khkVfliE19crm7R0lVZod5O9607X8hlRhiEVD?=
 =?us-ascii?Q?LfHApQrQvJw6m0CZ5CbAxPQE7pnuwXPGb5EQAjv/GOk5XrLIQPOMC/Izq3OO?=
 =?us-ascii?Q?d+1eoa9dNmJSQ6UrXI12cpr7UJZc3PkuK2HKeKgHldKt878+tCXPpcnZ6py9?=
 =?us-ascii?Q?n3seeHUTptH1eIXoo3XhRuhymb/9Hm/H9aCFP3rxVN8ou5tYIJKqZTBRlSBU?=
 =?us-ascii?Q?/tk7J9x0VLq23lbd/YuelhfsM6S0agPp7SBOR3zse1Lgsmt/ZQdEnNHtNls7?=
 =?us-ascii?Q?eEpIKM741hPbFkShjAV8MkzN0hUqcI86AApREXw8efm6XuGeMrX4JpdNu4Rs?=
 =?us-ascii?Q?TDHUuie82Z8nSf/Rgyu1152K8IgmQDjOU+zpnJKKps7jLMClEkLWDanmTYhJ?=
 =?us-ascii?Q?wQL0NRpSf3M/w/nnOILDaPI7T13jDDLmhC15KRw2Tw2ZXOXaGw48EKUUsRXk?=
 =?us-ascii?Q?ahD1ApxAda84D3Gnp192G7vDe8GztMQEjNoidX3Qgslq+cyHyUQgXO04TE4L?=
 =?us-ascii?Q?+RiV1rBkFAN8NTXkg4MLJD3AUHgMw0qgFJKQ3QhfglRqrHHyYjwjfoj5/hY9?=
 =?us-ascii?Q?xPYV1LPYL3RdOJ34+49hpRh2CrqdB6WjUk+q43pblYKvVd1F9VV9Re7quvMs?=
 =?us-ascii?Q?QEYncA6czqFcOaJSbF+fnthJgIiAvV+z8JftLgjHjqUoRxvVqoAC1DHDxc7/?=
 =?us-ascii?Q?IWw0cinZtcShCO29jVyILsFAnIrhZHX+HvXTqd2WCsg4QktFkpCCMix2fwBn?=
 =?us-ascii?Q?i2lESqalvAOeBP3AwDNp6WH76OyZndD8ILXYR1wK4cO2CpHsOCH7q+54rwG4?=
 =?us-ascii?Q?og1V35IRoWBY+s7Bwga6IgUQbgfFUFXRT5G45rgr3pcJ4U9VqIWBnVfcYrI4?=
 =?us-ascii?Q?xk/lETRNt7KiHqcwYKQI2P/ci4UY6RsNE5PmtmI6d0s04sy6PpJb05eoPqYm?=
 =?us-ascii?Q?kTefqQ7bjWafSB4TmesFKi0n046OMGP/r0CGCP2NaMiApnOv3+ekdF8jFA43?=
 =?us-ascii?Q?pnqpm1YyywnwBeQn8WleoOO5RT2xTp6CIKcBPNLRpQOugk6+xyQjkpZl97i2?=
 =?us-ascii?Q?nIOzKdecFT9ljlRAh7Pc1OhOUefDWqYql00pQZP0HA7bIJFB541eo7y75OT+?=
 =?us-ascii?Q?VA17lLgrDuK6S/7V3p24Gzxk3ttgp74WK6iYTtoO+NMGdSgslTArBo/KzHCb?=
 =?us-ascii?Q?v11Gn9pUTedCinnzxMePrVP0lPhtS2uwzh+oPibNGJS9SBMppcZlMTvJ8Nvr?=
 =?us-ascii?Q?vuV5Tkgzy/PCZk8bmTU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cfb9c3-9f80-4828-cd15-08dd396d94e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 16:14:56.8124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/4lHNh6YXPxgzwZXFJfmNgDrlyGrdfqe6/4iCO3J+uzvBVPkL0QjBfnLMiDOcX7s1dUJNIaa+h/LwA23yRxxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955

[Public]

Hi Greg, Sasha,

The original patch 73dae652dcac (drm/amdgpu: rework resume handling for dis=
play (v2)), was only targeted at kernels 6.11 and newer.  It did not apply =
cleanly to 6.12 so I backported it and it backport landed as 99a02eab8251 (=
"drm/amdgpu: rework resume handling for display (v2)"), however there was a=
 bug in the backport that was subsequently fixed in 063d380ca28e ("drm/amdg=
pu: fix backport of commit 73dae652dcac").  None of this was intended for k=
ernels older than 6.11, however the original backport eventually landed in =
6.6, 6.1, and 5.15.  Please revert the change from kernels 6.6, 6.1, and 5.=
15.

6.6.y:
Please revert 2daba7d857e4 ("drm/amdgpu: rework resume handling for display=
 (v2)").

6.1.y:
Please revert c807ab3a861f ("drm/amdgpu: rework resume handling for display=
 (v2)").

5.15.y:
Please revert d897650c5897 ("drm/amdgpu: rework resume handling for display=
 (v2)").


Thanks,

Alex


