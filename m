Return-Path: <stable+bounces-58266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3A92B0E5
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 09:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548E12820F1
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 07:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F69813AD20;
	Tue,  9 Jul 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dPSYwuXI"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021089.outbound.protection.outlook.com [40.93.194.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943813A24B;
	Tue,  9 Jul 2024 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509247; cv=fail; b=ql/EjoePkddLl1SbC2pNEcwx0XRAb9eRgrsn6bZvbyLmmjoOKt1VQG/MTaYkJ9tfqXZX3WKOSI+0hMY4V7v+mMGXP2pwGIxDvcpLeZcF+fO7LNxysof+KLtoD+apzfOYrSsGyay4g0H4rtvxeJGriQD+Uuq6pxB1z720NN5Zhaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509247; c=relaxed/simple;
	bh=PBHqVFImpCAtpHDIEIjYCNyCwH0/3WdUKW+IJ8+IWAw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ooU1jntfK5JM7f5Khmb3tWAFZNzgS5uxezsBjl1IOZbI9BEekZQTWbALPWGHo6x9vBD+/GUMG/pQFNWGHbA/yIzzn4rLISLxFzTMar7Co2tsLU5UGMlZDIfmvGtm8coRvMnyuA9RmIo3CIiqCGedInhu06zxEk4tvVHLlSW7Y8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dPSYwuXI; arc=fail smtp.client-ip=40.93.194.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQVlEabl5Wf+Cv1KEjRof32Ad34W9kn4WRKHidApdesckBqcwXsBa+QpxuXrn+vXXO9vrCpO8OXA9gA+z31Dt3VAroe/2KYRMDCUrNyIb1qfEpIfdAJKPw05qRi3OwHkeirKHGPB4KVMGD1FXfn9IQq7kwNQyYwtZKS88/GTQsjlony00lXUYRldlY8i5sZWn/N8hKpZ9eisvH4d024Msm/KIMY/v7/AISI0ER5KiFqjUJ/rCPSzoBthZ0gYNIRAs/ffDN9gsfiokrdhURYhoJDuS+QWpUUgjnClaVOmWNjayWB/XF/THQG4PV4EoXNSr9GZizqXckCKZVZazdC+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Se+556Hl6FNv5IUNjmYlUyHvxdvBF7bmRQv6rVOlXyU=;
 b=FcxH+9z+I7Mc3BwHAOvXW1LGlwJPblmyDxl9veLwoXSHFPlUlYejfkeSRnJ7QvnBEqBKZLbL+5II/UiUZIj1N6CNAbSlPHLCqPxx/oYxzemMej42LM13kAEEFzecD2Xq6Ae2KA2vxKA1gnoGFqcNQbsCzqEGOyJ22bOKBCa6QG+WaSdGsZKE4F7fELpAmgsyt1ZhC4yoMWQYGmwvBZKm8sB8pgwpX4R33tU69+422DFyV2zXt1DlWDI9ezXFCwjTNu96RthQT/SZZHY/av4VSpGoDGy04KJMsXLI8fW9yhCpkafkjPPSrGfrkyMqOU/EA92m5kLh/kG307SQQVVAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Se+556Hl6FNv5IUNjmYlUyHvxdvBF7bmRQv6rVOlXyU=;
 b=dPSYwuXI8pZja8vPkBEi5IJMq2DnMVfAMVorMHaGPEEq7Lc5+MUPgwI+wtHH+ymTySZMMIrkxXZBmbLmMz9/sJT1aCwRHbH1HFagrScAbdnKpk0mUNKet0qLsk9dJxX60wTyVj6muyze5iWrjnPpRs1dxJma79v0VmkF2Wmkgs0=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by SN6PR2101MB1344.namprd21.prod.outlook.com (2603:10b6:805:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.4; Tue, 9 Jul
 2024 07:14:02 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%6]) with mapi id 15.20.7784.001; Tue, 9 Jul 2024
 07:13:56 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Jiri Slaby <jirislaby@kernel.org>, Borislav Petkov <bp@alien8.de>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "open list:X86 TRUST
 DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>, "open list:X86
 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, Michael
 Kelley <mikelley@microsoft.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Thread-Topic: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Thread-Index: AQHa0Wtpz0U6bwgC9Ee4DSiEch1K2bHtOg4AgACpo4CAAAJcQA==
Date: Tue, 9 Jul 2024 07:13:56 +0000
Message-ID:
 <SA1PR21MB131747711B9BC5F293139FA1BFDB2@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <cabc0b75-6536-4aee-9d6b-57712bb2e1a8@kernel.org>
In-Reply-To: <cabc0b75-6536-4aee-9d6b-57712bb2e1a8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=14203d24-972b-4830-b801-c39555669721;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-09T05:54:21Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|SN6PR2101MB1344:EE_
x-ms-office365-filtering-correlation-id: 9b296ff4-bfbe-4996-9a97-08dc9fe6b27a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tHy67VBJedNqfciQgXP94aKjmZ521hdMNGRiFZrDGCaXq5ji0gVTlXGI1NiP?=
 =?us-ascii?Q?CVFyjQjLOGF3Sj62HoVl+cUxAct1rWXqrGmUDzzQOysy9knVSm/h49Vmhqwa?=
 =?us-ascii?Q?ZnA1PLN7oV3E+c5s7mDkWJRY8Wwma/+A0ICNv1GWbLYRBgdT2jIsy/Kexpzm?=
 =?us-ascii?Q?u44Sp8sC5QYQ5tXujEqdxNDb5GEezeWXgwhqxzVQOlOLm5ursZ0Drxyq3WM7?=
 =?us-ascii?Q?uG5DvuP4eT5ZsVWE/94AJZ5Zz5WvPijP0Od60q9XIox0rkgN5NdTTeoagufj?=
 =?us-ascii?Q?xQwrbwIIo2lx3SnABUox9EeflUlDj68jipzLdA2jm/us/ly+d6VWzDCWl3vf?=
 =?us-ascii?Q?ELGqHv8N5ZGZ86xd+IHlo47RihTVzTlYHTBTRZhJVJy+bifgfHFlc6JqnK9t?=
 =?us-ascii?Q?0VMGicmMF8yfc8hp6lBYxyO7fwQxu1lCi8UiT6sAPPn2pl28ndfW3lbumU/U?=
 =?us-ascii?Q?Je7wLwnbX0iB9McknKzcqozOTp9zIwPrEhV848sLZuN0PSRZrTe12le2/LVo?=
 =?us-ascii?Q?SxaN6Ny+gkmlxn4GYZPoRTeTPYpL3JP5x7LgYzRcusi0mXfI4NEJATx1o5di?=
 =?us-ascii?Q?BlPYgIWEHdIJszCVNp1AoXVXxUcTPJAMUB2K8DsKK/l3rLuRNIgglI40rmlx?=
 =?us-ascii?Q?UN+zFaRWXezSlc5MppvHRcVhbf8Vax33VTHGC6I8vjIby1glFrz4PmHFEplA?=
 =?us-ascii?Q?INWZQ3GKZJ1Ai4dJCtRWCJ2HJ3fTzISL5h2vn5ZaOOJ6HaM3XpJOU0YFJ/6C?=
 =?us-ascii?Q?0MkJrMIRgN0Sz3zITXL89Ii32OKoGobWusrFfPs1MCi5O6g1YHEwEZbV6C7Q?=
 =?us-ascii?Q?8li3U8hqLCWgBmfXlKkjvu4GL3D3MoOPuYDsd4KF74zqzqKo/imrFmt10fI2?=
 =?us-ascii?Q?cTiMPOLfVsSORT6A71yZ2TIpAVilMSXA4HBmwenTWaEWwI5hrPqsiN86emrw?=
 =?us-ascii?Q?jiU+9J1kYyumFFP8fzFUGx5wYf3Dz36gaE8DRh3l0EqeHJpvP4DK4fF25X2A?=
 =?us-ascii?Q?8cEa4Hm0eMTK630dUj+BIg8sjWnZkcsTYHDn8FYwBSPfvgNYUoZ805DMRNt7?=
 =?us-ascii?Q?gtzmtqkE/7fI0o2K030hRU8jJM4BAjdUxZjryDSBTIfVWszG3CDqB8qLeKoe?=
 =?us-ascii?Q?h5qWKd/1nozGap8k7/b6zX3Lp2wRl5JhigImvNQ9gnDCpLTKuWRCNnt8FuFh?=
 =?us-ascii?Q?7PmEdeq7FfNXMwHcx+Ain+yoyyHP9Y5I1RdQ58Zw+OgIon0LjIsp+QmpuDs1?=
 =?us-ascii?Q?LUuOWzyBxg1oSv2hwwva30UxqLz2jy8kHmKUh6V5JEtGwsu4Ugb4fvDX7yrX?=
 =?us-ascii?Q?6kyQJHEHOzfgQwFqI3ygJ8A6fhdf/gCgEJg0PFm+QsCkeVGJ+n0ju8Epz9X0?=
 =?us-ascii?Q?NNzsbE8kAZFSAuWQC6c1Su0RiNfGBYK5QhI7yiQD+1yTh4Icgg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GOmJgPt2L9lMH7gpUSHkv568aGSv4KZTK3q5wdxpKYIzrbQrmPW3Vyjw6/GA?=
 =?us-ascii?Q?jE16wZ7f9hBDYs9e8WteF4E5El9qjJXq9jsw8c+HEDoxVj5Q49X2Lt/yshaE?=
 =?us-ascii?Q?j2TISuwimIVilU1nqYXzRiXYmmMazRzBlj0sHv4ixMEFU1FWMLe7LCIwzsp6?=
 =?us-ascii?Q?kiHFW0qoCGrbuO5rI+ZjOPTDw+4IrRoPMwwJShy80MQ47NDKsCsne8Jv2Aot?=
 =?us-ascii?Q?BS46cRtzIWYPRSKJayF4YWtqTSFgGEV3s3FkInAANanwcB2XKYsmXI8NOqY2?=
 =?us-ascii?Q?o62SSGrk9KVxMXff80Jr2E8Hb6tU4s4apyFTOtR3NjecuMls2grWyNeIoddj?=
 =?us-ascii?Q?bqfELUtVK/1kebnXtRkJnnRxxq9L2AthPztS5JWf94H9Cp/BvIIH7nKFEtu9?=
 =?us-ascii?Q?cMn70j3eqgncFbVWjiRJNz74VMVP3W6n+dEFWc+LO3JX4TujbBePV+ewu2Pl?=
 =?us-ascii?Q?O9mGm7bllDQjZLVjKTUBNl6DI4llPGOb0OBZ7ws1gKptzXTUo8FnPdGn/oPW?=
 =?us-ascii?Q?OT7U65rV/+e/nHYmp7hBuDIK+CKWBBtMChrMXEty+Z1kAfmULc+qKYIHJB1F?=
 =?us-ascii?Q?6B3YEWZmMUVjVGA1TKVvGD9UYJ64CUkP8F2Qno7LSAE6X5ePE400YyzdhI2C?=
 =?us-ascii?Q?yNWdyMQ2fN+qpTttseZGD0uu+FYfVnVo4rR/6joUdyIQuCW1Q+N8NkxBRUar?=
 =?us-ascii?Q?fS5u+Hnf6aPIttMdkOtWz9V5dhlfRIWa/VZE2/dT1t8bwCuHHmVKVHMajcs0?=
 =?us-ascii?Q?/dStI6S8wMgMD2Rd2sYNOBNvEUo69vsJkHBNeP+Av+W7GTUD7pVcG9xu4Aok?=
 =?us-ascii?Q?W3j56T7jeQhIaqF8FHp4qvNqseDGqOQndcmTw2haTvKvyfdRYKgsa3NsmrSs?=
 =?us-ascii?Q?wRHur3UC34+A8XXX24qOocmNiOS/LMNdBbQHF2dzU5xmLGSOkVVPGGf595GO?=
 =?us-ascii?Q?jhyGGEH5Yo0C+E7z+YcHs55C6aYZ6UGySXPuyipBV2L9KsEpd7wxV95dLJhs?=
 =?us-ascii?Q?vro21sDASyYnXLng1B55LWr9YhNuCxiUUUu6S0Yd0ThIyL9fkxKsGHp+SCXR?=
 =?us-ascii?Q?7+LOUpufzhHwXSLIEjLJXpYFPtbHmxmEjTod6yB6MvHwGzEjb8rjJbs5dmIl?=
 =?us-ascii?Q?+AcenjErdCboQNY8qwEwAGNgccjxPZOFEC0LT5RFu2eP/VRbkUaJ+oZRXKf+?=
 =?us-ascii?Q?85PlrOD45nc4NUS6yibsnPSmtaTpsevkVomTgiMFipyeloW4TYURr3j+HRSg?=
 =?us-ascii?Q?Tbhab3yWxutLFhrB+Jo7+7q0mXHLlD1xG9WU4m8/49SfVUrIpR50wsgCTqR4?=
 =?us-ascii?Q?3JMg2OtC7gxFqBQt/5WJAMc7DomzianeDV6+Bh0OsxnGOtTRJkHURYAE5Fky?=
 =?us-ascii?Q?XlzrA9G4lcGCuOKo8p+qlXm3PuEr3Kbi1gBaPlyqUfGqPqctUshC4l4EI6jd?=
 =?us-ascii?Q?E5gD5cdzmQQiKkVu9k84zR8+sHHZlmyafDi6Cu+kGJxE2+KBfAtT+fLuQ439?=
 =?us-ascii?Q?eOSkreoN/iVB7ujS/P8gWqThvSURMAGdPlw9Ez4+lAJwgNnMZXRKLZN0hkJD?=
 =?us-ascii?Q?gWdhbUANNRiUxrw3Zi5PXG0WcAlgbtg6s7a3z36T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b296ff4-bfbe-4996-9a97-08dc9fe6b27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 07:13:56.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXf4mhA7ea7GD/W/NZoOCFhN3zg4Kwp923oKbDuL/1CUfRU6BFXPjf/uvs9uutAeDuvcBJEoh9dLUGgoiKIUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1344

> From: Jiri Slaby <jirislaby@kernel.org>
>  [...]
> If you cc stable, fixes *is* actually needed. So again, why to cc stable
Ok, I can add a tag to next version, i.e., v12:
Fixes: 68f2f2bc163d ("Drivers: hv: vmbus: Support fully enlightened TDX gue=
sts")

68f2f2bc163d is already in v6.6.
A v6.6 kernel works for a Linux TD-Mode TDX VM on Hyper-V, if the VM
doesn't have a virtual NIC device; if the VM has a vNIC, the hv_netvsc driv=
er
fails to load and the VM gets stuck in the network init script. This patch =
fixes
the issue.

> when this is a feature? I suppose you will receive a Greg-bot reply
> anyway ;).
As explained above, my understanding is that this is more of a bug fix rath=
er
than a feature, though the described NIC driver issue is specific to Hyper-=
V.
In the future, there might be new users of vmalloc() + set_memory_decrypted=
().

> > How do you like the v12 below? It's also attached.
> > If this looks good to you, I can post it today or tomorrow.
>=20
> Then you need to enumerate what changed in v1..v12. In every single
> revision. Do it under the "---" line below. And add v12 to the subject
> as you did below (but not above).
Ok, I'll post v12 tomorrow with changes enumerated from v1..v12.
=20
> >  From 132f656fdbf3b4f00752140aac10f3674b598b5a Mon Sep 17
> 00:00:00 2001
> > From: Dexuan Cui <decui@microsoft.com>
> > Date: Mon, 20 May 2024 19:12:38 -0700
> > Subject: [PATCH v12] x86/tdx: Fix set_memory_decrypted() for vmalloc()
> buffers
> >
> ...
> >
> > hv_netvsc is the first user of vmalloc() + set_memory_decrypted(), whic=
h
> > is why nobody noticed this until now.
> >
> > Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Acked-by: Kai Huang <kai.huang@intel.com>
> > Cc: stable@vger.kernel.org # 6.6+
> > ---
>=20
> The revision log belongs here. I believe you had to meet that
> requirement in the submittingpatches document.
Ok, will do.

> And to avoid future confusion, I would list the links to received
> "Signed-off-by"/"Reviewed-by"s here too. The links you listed earlier.
Ok, will do.

> regards,
> --
> js
> suse labs

Thanks for your comments!

