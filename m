Return-Path: <stable+bounces-58256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A76D92AB6F
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 23:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A741C21BCF
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 21:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B613D265;
	Mon,  8 Jul 2024 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bx+V4vpG"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021106.outbound.protection.outlook.com [40.93.194.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73403D3B8;
	Mon,  8 Jul 2024 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475130; cv=fail; b=ajN5CRMZ5LsqkdR2owBjQwW1DPJ3vIZl7Cc5ZHEmIMtMm3ESvUXxv0uL6snImgfxnA/xsJaz1suiZkQ6KoQfMv3dyhDEoLeIMSxw+thOl7I7Nc+zvgp1IUM5pE1sF0YIjapQH2Kq4YsoybQEKzS0Y1czjLPkbxoJcC+sC0dSyDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475130; c=relaxed/simple;
	bh=1ythnx99xjm3OfEMHNPuSotHA2PhyypoaAv8inNSY0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DOSUGFzzLfqm34HM7Hx+E4LWSFdW7njn9Z9StkIDd7uzg/1IVauvl3i5z1FhIuQZ7C6NEG66949vHB3RLO62e+lsxyTnVfY6L3JV5wFfyK1FHfNeIC9Uv0aaIuIe5QXUACc1efN6GfUAqovWSaAujZwcX7atGY8+hkkSFQYzX08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Bx+V4vpG; arc=fail smtp.client-ip=40.93.194.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl4xRz6w7+0LuIdLLYu2ifsV5Go9eZYkpU0+breZp14Je3zWyLPR+YlLMvrXnLdOEoiMSzF91myQjWDe+MKzHkOqSdjN1ckpmT1ybgVxCHhlxdNkJjbb96mA5FHKNkyGKlUHSdQCbY7PEfROFHSAKNCg8AHroZS351jiIMyZPXBWj+/4fAqUYeVkNqVKoRBL07FVZX4DIJPbzdXQJ7SX4+Cj7bl6BRVX7fFHdRwSolAgJFDfqPBJQVNwYTABYK0GEn15u6OUTku7S9+0uq1VG1IpyL4fPTN67lf0TqFOnA4y0xxQNMzmniS13cuufClM8H/zQXe+fl9k4A/17WHIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7iFKesKcn0jDAanuaDRdfd/ROmwl9XBFIkSjuYaTM4=;
 b=N9h5bhw238qHQ27e6/9Ib3wkPwSkLqiYx10UJha23fLoyoh16A7/m9l99zpAmsHDJrUzCUqph/afN/4VhJQjwqVHElFE2xgKPdz5Ivd+wTa6RZWT+JQesGsgtBFOtzRlrs5R0S+7fKxqIItGJZH+ijo8HOrQoQS47NFqTuxZdjiHi2E8NZKDYB/VTLdk+xR5q55zzJPwAyEdoxhJ2FQHTIAM85Mwg8PWpn1bFXwazPSIrasYccobIbEmDvTsv85Uxa/Xm/A4ElndYcxAG9YkN/JZDH+8sxmQSIhUwySRfxVKam2f6mQt9kkUIRxm+71m3bXNChLUj5VvFRElAtzNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7iFKesKcn0jDAanuaDRdfd/ROmwl9XBFIkSjuYaTM4=;
 b=Bx+V4vpGhCJA6AlXk3R+tPmIKa7S+AoAz250hul2DxHcDmqbpNMESn+XtEr80eZspKZcq0p63kzu2SiI1c30Qz45a3TWWmUB/7AgKB86x9MLa/fSBhoelZBk6cAuPMDiW4q/0XtWVzuX100lIwCo94Q5riDzINiuw1hjkL9BNPw=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by BL1PR21MB3355.namprd21.prod.outlook.com (2603:10b6:208:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.4; Mon, 8 Jul
 2024 21:45:24 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%6]) with mapi id 15.20.7784.001; Mon, 8 Jul 2024
 21:45:24 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Borislav Petkov <bp@alien8.de>
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
Thread-Index: AQHa0Wtpz0U6bwgC9Ee4DSiEch1K2bHtOg4A
Date: Mon, 8 Jul 2024 21:45:24 +0000
Message-ID:
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
In-Reply-To: <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=20918404-b51e-4bb9-8c24-31d038cfe22e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-08T19:38:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|BL1PR21MB3355:EE_
x-ms-office365-filtering-correlation-id: be0d4ea9-06b3-4160-c912-08dc9f9745f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ctXJJhPZq3DFVSjBloEaczawl5zpJeAG9ZgkVI1ypAIzO5R+HIdIAUvW5K3n?=
 =?us-ascii?Q?vv5tdtmjswVn+AxPbOil30imebDktGP8+ehd+Yq3C1zn3abzOATDaZY9Qtii?=
 =?us-ascii?Q?BEUvxvAVFVMiKW8DeVpKjqR9gi/TpeL3KPwCRXN07d2Ka5gg3xbdfgBBwuc6?=
 =?us-ascii?Q?lH+W4s/Vcb32Pkq8RD/KCqYJapQqmD25sKUHu+17QkavzR211bgVFzZKG5dV?=
 =?us-ascii?Q?E2koL0Ms0mFqJhgLOi1Rurk6IKCwkwVQNoiJ/ZmYly8KVfUwqcN5A5jMZgaL?=
 =?us-ascii?Q?Znzli8KTACzX5B1LYnpLlGIX4KXA7ulk9ymy4Makehka9e3rJuUJyR2Mg7BK?=
 =?us-ascii?Q?raLUEHvZhBZuYsHfqLPB+RBb7D9v0+/d2FCYhMdwBWFzdFEZAsWVIOvFie+R?=
 =?us-ascii?Q?mXEV4qn2KFK57UQgunyK2vCRwVIZXovzUKxLnIYOijnkhiwb7D5MGiusmH62?=
 =?us-ascii?Q?XqXV+tlT2a7d/dk/9R+3OFikNNmsAouCy4Fhtt3oGzJdjSfXf9QJUJ2bgVi5?=
 =?us-ascii?Q?byq7FXd/0zi2ep9pZuy1DcoK684AHtzZ7UXD9rtYp9IcxKERowFFcd0nFR/F?=
 =?us-ascii?Q?9men12/cYKNeGN2Q7JBKOpWIJyYYA1YlWG9BMUEqnfyngoZJ2JYqvoh+wc3j?=
 =?us-ascii?Q?Ewbmst8x79sEz4lVFgAMZ4gCHWeIxC/Qc60IEhaFFC/ABIdvioZIptJ8xfDd?=
 =?us-ascii?Q?+myQaHa2otyhHYuW/GmAsrs/0WXWuglgOGYHiK/k0As7WykMmhqzbThA+QAU?=
 =?us-ascii?Q?gnspCzpl04sMtvP5Cx2+9811/f9YAjOFbsa4j4L5LOmYhPFQNi7Enir2WGr4?=
 =?us-ascii?Q?C5AWyb6y+UBfqXtCD+ZWPnE5T9+4PhyFTjE+e7PqyGV0MEfUW26FWHxpFQMw?=
 =?us-ascii?Q?1sNy40TPl+wTUkyCZsU9FZGvmFoi4wk/OijpqDpeMgXBMBVdEb+OJ4dQ0Gy7?=
 =?us-ascii?Q?AM+JimRMaCpXOmgwbyiVWc6uBZ5NBH+67/plGXPf/r40gRueBLES8VQP8nLu?=
 =?us-ascii?Q?zXelVojmzsaQmtP7E+RHgdXjdMcRpeupepAlKZvj+5YF3yvC8JR04ew2f+a/?=
 =?us-ascii?Q?FHA8Hr8RM3ZCf0jmH8A9VXA9nad4QhkeweTuPH/f9OgUwNcfGzFDwToo6/vG?=
 =?us-ascii?Q?1kz8+XIbEUTUBRjcnyov0cYpA6G4W9r61o+mA+6+Hnr96IssiQBpBZzxDNI4?=
 =?us-ascii?Q?H6wtiQxuC9nELtZ6T/kY/ubhrq0wRNyw6n7cRCyx9By+nSPKQkkZ28L6gs0S?=
 =?us-ascii?Q?gcC7On9F87MoOts5GLLhQ0YfXjF5NE6riRfSzOSQpILL1ayOlUnpgHMdcgF5?=
 =?us-ascii?Q?isj5ftWvQId3JLsWEoTFtqtqu5s0qNpYOlktmmWHh42r94itwldKAVnUses6?=
 =?us-ascii?Q?5sqFO+4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tyBxcMLv9S0exttDaeF8FkGtu7Kp2GuiGbX1bk0cAnOxV0I6p4WkkAXQI0uh?=
 =?us-ascii?Q?J5x0plMUNzPIJm5BshCizkV7aT8L0kB2ERDwci9Evjh9I3NwvHgO4rKyU7h7?=
 =?us-ascii?Q?dyRgjEROHtbdkf3XTocPOqwylJ/tErH/jcKJVDUjzuQpR+uKjUIPX835UueN?=
 =?us-ascii?Q?rj2QBVACKnZLFgfUzZH/nHB1bzCzWP2b9RC3nvS1QQVa8N8WD7rPWn+N8no2?=
 =?us-ascii?Q?sfecCPU09z+gIvurv7xHioQKvNYAEoFCd2FDogS/w2prsJDgy41Ne5W1HWXh?=
 =?us-ascii?Q?N7DLCfE8EptETdK0PbqNdJcSUGpRJum5wipmba6zfg55Ywx8crDxylq/VfW0?=
 =?us-ascii?Q?3OY0mEMjczBHytR7hjwQq4khThtdG+qsjC8YIilpcu7s/aNx0BzdbpJGRYpl?=
 =?us-ascii?Q?qsj0ImovecxwsQbmOt6AwqghmwVmelqpshbfiLm2VNqv9JT2BgekviW5cAT/?=
 =?us-ascii?Q?q8ErYb1ku9EnnEO6++jb6rKjoEAemaV9eGveiZZuE+VLWACqndLW/Yym/X24?=
 =?us-ascii?Q?ZMwjQ9JGQtIBiujW5/RfAt3djtXaFY4PKpDv0wEhQ0xYM7AJYtw9ECk2259r?=
 =?us-ascii?Q?g8IA06VBYXFCsykTqX5S1vaOg+NVKrHhsI0j5yPU25U6aMUSL5ok4QS78QnE?=
 =?us-ascii?Q?Jb7kD/8NUSk01UeGC4gzJiWW5wtRbVIu8uAwFnbi8mCTnZYu03V4HKMCGCAe?=
 =?us-ascii?Q?mb4WiNzTU2e8nRyn31lBMHyiXdNlOKM0MTAHgqB4X8esZp/xvFHideyXl/oj?=
 =?us-ascii?Q?+MX842WILXbZSWvq3QsUlJcCnDpJb1GKd4pgIdBC/PPPbB+QjggGjRSRo/oS?=
 =?us-ascii?Q?GlNy4Sd8dky+h7IwcMoMddA3DELfHTWlywCYfIE0gJYcKywIA9HoYNX7jnNS?=
 =?us-ascii?Q?Ddtyb9w+ZlLb+CcNB3nLa0EfsOgDMNb+SmILHFfWt4vkWCzFcoXIxuMbLRVI?=
 =?us-ascii?Q?M5Rk53m9XKrqMVAXVoQ2cALod/rM+ZJ4x4P6eMXoTlpUA2AhlsHenjqHqDeS?=
 =?us-ascii?Q?Hwg3SwvAaTZRlworC7+B9sMPuX2N4rIgxT69IbV8wmepKGj+M7pCmxuIviGs?=
 =?us-ascii?Q?DTl21IX1HVojlc8beY7yyfXwn2ZeRhN1lSBXAftumRxO2gbsPTbA+gnLEeYX?=
 =?us-ascii?Q?JcwiQkqNVqcnP/kHQfHJklm8Fyi96rfcRKaUCswmJ24V++XfbeZUVHscEjtH?=
 =?us-ascii?Q?LIjGwPfk72uzbxrmWDatXAxDvZ+xKgRw3R8y4/0NzpaPo8XnYIgMylbXcrqu?=
 =?us-ascii?Q?A40gAETajEmD2bsW0UmgSepRyhHgLAAfcmpfWtGxctfNJZRWKdq7pIux8d7b?=
 =?us-ascii?Q?yoHbu8tJD2MT1TUHW1VO5CyZ53L2QcJusDQvh/R23224ZcwLV97MmM8MVdFI?=
 =?us-ascii?Q?qHSoVpNn+hr2CVda5+j8hk3M6CmRgpxaOzLEVCGRqYZYYcq/eFxwlqnQ35Md?=
 =?us-ascii?Q?aJpcFceFDVqu65ACX29S57wd4LJGtbg6xsCA8G6EDQ4yp9kQxjh9Iw3p0Em7?=
 =?us-ascii?Q?fw3+9oZGmF0arJWUxEWR9MOfwbHJgwSWGc1wkof7iVAtzroF1pjcLVpKOjM9?=
 =?us-ascii?Q?pyUyE2RnBrOc80aQEeqzQI0p64VDUTNYv/KzdAl7tmxX7uzuXkqqRSj2me2j?=
 =?us-ascii?Q?H0mjUKRe1nbF3CH/6oyJGfs=3D?=
Content-Type: multipart/mixed;
	boundary="_002_SA1PR21MB1317816DFCE6EF38A92CF254BFDA2SA1PR21MB1317namp_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0d4ea9-06b3-4160-c912-08dc9f9745f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 21:45:24.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V15FbzX93XmW1xLiQF3eSzK6Jkw9aX/lRKtcAcH4S1KNLRuuMn0jwAwiLzqPSgh36CG+HX6Ld3FSsnQtNyismA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3355

--_002_SA1PR21MB1317816DFCE6EF38A92CF254BFDA2SA1PR21MB1317namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: Borislav Petkov <bp@alien8.de>
> [...]
> On Mon, Jul 08, 2024 at 06:39:45PM +0000, Dexuan Cui wrote:
> > When a TDX guest runs on Hyper-V, the hv_netvsc driver's
> >  netvsc_init_buf()
> > allocates buffers using vzalloc(), and needs to share the buffers with =
the
> > host OS by calling set_memory_decrypted(), which is not working for
> > vmalloc() yet. Add the support by handling the pages one by one.
>=20
> "Add support..." and the patch is cc:stable?

I meant to use "Cc: stable@vger.kernel.org # 6.6+".=20
Sorry for missing the "# 6.6+".=20
=20
> This looks like it is fixing something and considering how you're rushing
> this, I'd let this cook for a whole round and queue it after 6.11-rc1. So=
 that
> it gets tested properly.

x86/tdx: Fix set_memory_decrypted() for vmalloc() buffers

When a TD mode Linux TDX VM runs on Hyper-V, the Linux hv_netvsc driver
needs to share a vmalloc()'d  buffer with the host OS: see
netvsc_init_buf() -> vmbus_establish_gpadl() -> ... ->
__vmbus_establish_gpadl() -> set_memory_decrypted().

Currently set_memory_decrypted() doesn't work for a vmalloc()'d  buffer
because tdx_enc_status_changed() uses __pa(vaddr), i.e., it assumes that
the 'vaddr' can't be from vmalloc(), and consequently hv_netvsc fails
to load.

Fix this by handling the pages one by one.

hv_netvsc is the first user of vmalloc() + set_memory_decrypted(), which
is why nobody noticed this until now.

v6.6 is a longterm kernel, which is used by some distros, so I hope
this patch can be in v6.6.y and newer, so it won't be carried out of tree.

I think the patch (without Kirill's kexec fix)  has been well tested, e.g.,
it has been in Ubuntu's linux-azure kernel for about 2 years. Kirill's=20
kexec fix works in my testing and it looks safe to me.=20

I hope this can be in 6.11-rc1 if you see no high risks.=20
It's also fine to me if you decide to queue the patch after 6.11-rc1.

> > Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
https://lwn.net/ml/linux-kernel/20230412151937.pxfyralfichwzyv6@box/

> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3De1=
b8ac3aae589bb57a2c2e49fa76235c687c4d23

> > Reviewed-by: Michael Kelley <mikelley@microsoft.com>
https://lwn.net/ml/linux-kernel/BYAPR21MB16885F59B6F5594F31AE957AD79A9@BYAP=
R21MB1688.namprd21.prod.outlook.com/

> > Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
https://lwn.net/ml/linux-kernel/d20baf1e-a736-667f-2082-0c0539013f2b@linux.=
intel.com/

> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
https://lwn.net/ml/linux-kernel/e8b1b0b5f32115c0ef8f1aeb0b805c4d9a953b31.ca=
mel@intel.com/

> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
https://lwn.net/ml/linux-kernel/4732ef96-9a47-3513-4494-48e4684d65cd@intel.=
com/

> > Acked-by: Kai Huang <kai.huang@intel.com>
https://lwn.net/ml/linux-kernel/6b6e7f943b7e28fa6ae6c77e1002ac61c41c1ee2.ca=
mel@intel.com/

> When were you able to collect all those tags on a newly submitted patch?

This is not really a newly submitted patch :-)
Please refer to the links above.

v9 was posted here (Jun 2023):=20
https://lwn.net/ml/linux-kernel/20230621191317.4129-3-decui@microsoft.com/

v10 was posted here (Aug 2023):
https://lwn.net/ml/linux-kernel/20230811214826.9609-3-decui%40microsoft.com=
/

The last submission was May 2024:
https://lwn.net/ml/linux-kernel/20240521021238.1803-1-decui@microsoft.com/
(Sorry, I should have made it clear that this is actually v11)

> Do you even know what the meaning of those tags is or you just slap them
> willy-nilly, just for fun?

The original patch was submitted in Nov 2022:
https://lwn.net/ml/linux-kernel/20221121195151.21812-4-decui@microsoft.com/

I added Kirill's Co-developed-by in v4 (Apr 2023)
https://lwn.net/ml/linux-kernel/20230412151937.pxfyralfichwzyv6@box/
and added Kirill's Signed-off-by in v5, and added other people's Reviewed-b=
y
and Acked-by over time. There are only minor changes since v4, so I think
it's appropriate to keep all the tags in the final commit.

> > Cc: stable@vger.kernel.org
>=20
> Why?
>=20
> Fixes: what?

Please refer to my reply above.=20

This is not to fix a buggy commit. The described scenario never worked befo=
re,
so I suppose a "Fixes:" tag is not needed.

> From reading this, it seems to me you need to brush up on=20
> https://kernel.org/doc/html/latest/process/submitting-patches.html
Thanks for the link! I read it and did learn something.

> while waiting.
>=20
> Thx.
>=20
> --
> Regards/Gruss,
>     Boris.

I hope I have provided a satisfactory reply above.

How do you like the v12 below? It's also attached.
If this looks good to you, I can post it today or tomorrow.

Thanks,
Dexuan

From 132f656fdbf3b4f00752140aac10f3674b598b5a Mon Sep 17 00:00:00 2001
From: Dexuan Cui <decui@microsoft.com>
Date: Mon, 20 May 2024 19:12:38 -0700
Subject: [PATCH v12] x86/tdx: Fix set_memory_decrypted() for vmalloc() buff=
ers

When a TD mode Linux TDX VM runs on Hyper-V, the Linux hv_netvsc driver
needs to share a vmalloc()'d  buffer with the host OS: see
netvsc_init_buf() -> vmbus_establish_gpadl() -> ... ->
__vmbus_establish_gpadl() -> set_memory_decrypted().

Currently set_memory_decrypted() doesn't work for a vmalloc()'d  buffer
because tdx_enc_status_changed() uses __pa(vaddr), i.e., it assumes that
the 'vaddr' can't be from vmalloc(), and consequently hv_netvsc fails
to load.

Fix this by handling the pages one by one.

hv_netvsc is the first user of vmalloc() + set_memory_decrypted(), which
is why nobody noticed this until now.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.i=
ntel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Cc: stable@vger.kernel.org # 6.6+
---
 arch/x86/coco/tdx/tdx.c | 43 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac25531..8f471260924f7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -782,6 +783,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t=
 end, bool enc)
 	return false;
 }
=20
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end=
,
+					bool enc)
+{
+	if (!tdx_map_gpa(start, end, enc))
+		return false;
+
+	/* shared->private conversion requires memory to be accepted before use *=
/
+	if (enc)
+		return tdx_accept_memory(start, end);
+
+	return true;
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared wit=
h
  * the VMM or private to the guest.  The VMM is expected to change its map=
ping
@@ -789,15 +803,30 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_=
t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool=
 enc)
 {
-	phys_addr_t start =3D __pa(vaddr);
-	phys_addr_t end   =3D __pa(vaddr + numpages * PAGE_SIZE);
+	unsigned long start =3D vaddr;
+	unsigned long end =3D start + numpages * PAGE_SIZE;
+	unsigned long step =3D end - start;
+	unsigned long addr;
+
+	/* Step through page-by-page for vmalloc() mappings */
+	if (is_vmalloc_addr((void *)vaddr))
+		step =3D PAGE_SIZE;
+
+	for (addr =3D start; addr < end; addr +=3D step) {
+		phys_addr_t start_pa;
+		phys_addr_t end_pa;
+
+		/* The check fails on vmalloc() mappings */
+		if (virt_addr_valid(addr))
+			start_pa =3D __pa(addr);
+		else
+			start_pa =3D slow_virt_to_phys((void *)addr);
=20
-	if (!tdx_map_gpa(start, end, enc))
-		return false;
+		end_pa =3D start_pa + step;
=20
-	/* shared->private conversion requires memory to be accepted before use *=
/
-	if (enc)
-		return tdx_accept_memory(start, end);
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+	}
=20
 	return true;
 }
--=20
2.25.1


--_002_SA1PR21MB1317816DFCE6EF38A92CF254BFDA2SA1PR21MB1317namp_
Content-Type: application/octet-stream;
	name="0001-x86-tdx-Fix-set_memory_decrypted-for-vmalloc-buffers.patch"
Content-Description:
 0001-x86-tdx-Fix-set_memory_decrypted-for-vmalloc-buffers.patch
Content-Disposition: attachment;
	filename="0001-x86-tdx-Fix-set_memory_decrypted-for-vmalloc-buffers.patch";
	size=3592; creation-date="Mon, 08 Jul 2024 21:42:15 GMT";
	modification-date="Mon, 08 Jul 2024 21:45:23 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxMzJmNjU2ZmRiZjNiNGYwMDc1MjE0MGFhYzEwZjM2NzRiNTk4YjVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPgpEYXRl
OiBNb24sIDIwIE1heSAyMDI0IDE5OjEyOjM4IC0wNzAwClN1YmplY3Q6IFtQQVRDSCB2MTJdIHg4
Ni90ZHg6IEZpeCBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpIGZvciB2bWFsbG9jKCkgYnVmZmVycwoK
V2hlbiBhIFREIG1vZGUgTGludXggVERYIFZNIHJ1bnMgb24gSHlwZXItViwgdGhlIExpbnV4IGh2
X25ldHZzYyBkcml2ZXIKbmVlZHMgdG8gc2hhcmUgYSB2bWFsbG9jKCknZCAgYnVmZmVyIHdpdGgg
dGhlIGhvc3QgT1M6IHNlZQpuZXR2c2NfaW5pdF9idWYoKSAtPiB2bWJ1c19lc3RhYmxpc2hfZ3Bh
ZGwoKSAtPiAuLi4gLT4KX192bWJ1c19lc3RhYmxpc2hfZ3BhZGwoKSAtPiBzZXRfbWVtb3J5X2Rl
Y3J5cHRlZCgpLgoKQ3VycmVudGx5IHNldF9tZW1vcnlfZGVjcnlwdGVkKCkgZG9lc24ndCB3b3Jr
IGZvciBhIHZtYWxsb2MoKSdkICBidWZmZXIKYmVjYXVzZSB0ZHhfZW5jX3N0YXR1c19jaGFuZ2Vk
KCkgdXNlcyBfX3BhKHZhZGRyKSwgaS5lLiwgaXQgYXNzdW1lcyB0aGF0CnRoZSAndmFkZHInIGNh
bid0IGJlIGZyb20gdm1hbGxvYygpLCBhbmQgY29uc2VxdWVudGx5IGh2X25ldHZzYyBmYWlscwp0
byBsb2FkLgoKRml4IHRoaXMgYnkgaGFuZGxpbmcgdGhlIHBhZ2VzIG9uZSBieSBvbmUuCgpodl9u
ZXR2c2MgaXMgdGhlIGZpcnN0IHVzZXIgb2Ygdm1hbGxvYygpICsgc2V0X21lbW9yeV9kZWNyeXB0
ZWQoKSwgd2hpY2gKaXMgd2h5IG5vYm9keSBub3RpY2VkIHRoaXMgdW50aWwgbm93LgoKQ28tZGV2
ZWxvcGVkLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRl
bC5jb20+ClNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92
QGxpbnV4LmludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9z
b2Z0LmNvbT4KU2lnbmVkLW9mZi1ieTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4Lmlu
dGVsLmNvbT4KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBtaWNyb3NvZnQu
Y29tPgpSZXZpZXdlZC1ieTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5
YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4KUmV2aWV3ZWQtYnk6IFJpY2sgRWRnZWNv
bWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4KUmV2aWV3ZWQtYnk6IERhdmUgSGFuc2Vu
IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+CkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgNi42KwotLS0KIGFy
Y2gveDg2L2NvY28vdGR4L3RkeC5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jIGIvYXJjaC94ODYvY29j
by90ZHgvdGR4LmMKaW5kZXggMDc4ZTJiYWMyNTUzMS4uOGY0NzEyNjA5MjRmNyAxMDA2NDQKLS0t
IGEvYXJjaC94ODYvY29jby90ZHgvdGR4LmMKKysrIGIvYXJjaC94ODYvY29jby90ZHgvdGR4LmMK
QEAgLTgsNiArOCw3IEBACiAjaW5jbHVkZSA8bGludXgvZXhwb3J0Lmg+CiAjaW5jbHVkZSA8bGlu
dXgvaW8uaD4KICNpbmNsdWRlIDxsaW51eC9rZXhlYy5oPgorI2luY2x1ZGUgPGxpbnV4L21tLmg+
CiAjaW5jbHVkZSA8YXNtL2NvY28uaD4KICNpbmNsdWRlIDxhc20vdGR4Lmg+CiAjaW5jbHVkZSA8
YXNtL3ZteC5oPgpAQCAtNzgyLDYgKzc4MywxOSBAQCBzdGF0aWMgYm9vbCB0ZHhfbWFwX2dwYShw
aHlzX2FkZHJfdCBzdGFydCwgcGh5c19hZGRyX3QgZW5kLCBib29sIGVuYykKIAlyZXR1cm4gZmFs
c2U7CiB9CiAKK3N0YXRpYyBib29sIHRkeF9lbmNfc3RhdHVzX2NoYW5nZWRfcGh5cyhwaHlzX2Fk
ZHJfdCBzdGFydCwgcGh5c19hZGRyX3QgZW5kLAorCQkJCQlib29sIGVuYykKK3sKKwlpZiAoIXRk
eF9tYXBfZ3BhKHN0YXJ0LCBlbmQsIGVuYykpCisJCXJldHVybiBmYWxzZTsKKworCS8qIHNoYXJl
ZC0+cHJpdmF0ZSBjb252ZXJzaW9uIHJlcXVpcmVzIG1lbW9yeSB0byBiZSBhY2NlcHRlZCBiZWZv
cmUgdXNlICovCisJaWYgKGVuYykKKwkJcmV0dXJuIHRkeF9hY2NlcHRfbWVtb3J5KHN0YXJ0LCBl
bmQpOworCisJcmV0dXJuIHRydWU7Cit9CisKIC8qCiAgKiBJbmZvcm0gdGhlIFZNTSBvZiB0aGUg
Z3Vlc3QncyBpbnRlbnQgZm9yIHRoaXMgcGh5c2ljYWwgcGFnZTogc2hhcmVkIHdpdGgKICAqIHRo
ZSBWTU0gb3IgcHJpdmF0ZSB0byB0aGUgZ3Vlc3QuICBUaGUgVk1NIGlzIGV4cGVjdGVkIHRvIGNo
YW5nZSBpdHMgbWFwcGluZwpAQCAtNzg5LDE1ICs4MDMsMzAgQEAgc3RhdGljIGJvb2wgdGR4X21h
cF9ncGEocGh5c19hZGRyX3Qgc3RhcnQsIHBoeXNfYWRkcl90IGVuZCwgYm9vbCBlbmMpCiAgKi8K
IHN0YXRpYyBib29sIHRkeF9lbmNfc3RhdHVzX2NoYW5nZWQodW5zaWduZWQgbG9uZyB2YWRkciwg
aW50IG51bXBhZ2VzLCBib29sIGVuYykKIHsKLQlwaHlzX2FkZHJfdCBzdGFydCA9IF9fcGEodmFk
ZHIpOwotCXBoeXNfYWRkcl90IGVuZCAgID0gX19wYSh2YWRkciArIG51bXBhZ2VzICogUEFHRV9T
SVpFKTsKKwl1bnNpZ25lZCBsb25nIHN0YXJ0ID0gdmFkZHI7CisJdW5zaWduZWQgbG9uZyBlbmQg
PSBzdGFydCArIG51bXBhZ2VzICogUEFHRV9TSVpFOworCXVuc2lnbmVkIGxvbmcgc3RlcCA9IGVu
ZCAtIHN0YXJ0OworCXVuc2lnbmVkIGxvbmcgYWRkcjsKKworCS8qIFN0ZXAgdGhyb3VnaCBwYWdl
LWJ5LXBhZ2UgZm9yIHZtYWxsb2MoKSBtYXBwaW5ncyAqLworCWlmIChpc192bWFsbG9jX2FkZHIo
KHZvaWQgKil2YWRkcikpCisJCXN0ZXAgPSBQQUdFX1NJWkU7CisKKwlmb3IgKGFkZHIgPSBzdGFy
dDsgYWRkciA8IGVuZDsgYWRkciArPSBzdGVwKSB7CisJCXBoeXNfYWRkcl90IHN0YXJ0X3BhOwor
CQlwaHlzX2FkZHJfdCBlbmRfcGE7CisKKwkJLyogVGhlIGNoZWNrIGZhaWxzIG9uIHZtYWxsb2Mo
KSBtYXBwaW5ncyAqLworCQlpZiAodmlydF9hZGRyX3ZhbGlkKGFkZHIpKQorCQkJc3RhcnRfcGEg
PSBfX3BhKGFkZHIpOworCQllbHNlCisJCQlzdGFydF9wYSA9IHNsb3dfdmlydF90b19waHlzKCh2
b2lkICopYWRkcik7CiAKLQlpZiAoIXRkeF9tYXBfZ3BhKHN0YXJ0LCBlbmQsIGVuYykpCi0JCXJl
dHVybiBmYWxzZTsKKwkJZW5kX3BhID0gc3RhcnRfcGEgKyBzdGVwOwogCi0JLyogc2hhcmVkLT5w
cml2YXRlIGNvbnZlcnNpb24gcmVxdWlyZXMgbWVtb3J5IHRvIGJlIGFjY2VwdGVkIGJlZm9yZSB1
c2UgKi8KLQlpZiAoZW5jKQotCQlyZXR1cm4gdGR4X2FjY2VwdF9tZW1vcnkoc3RhcnQsIGVuZCk7
CisJCWlmICghdGR4X2VuY19zdGF0dXNfY2hhbmdlZF9waHlzKHN0YXJ0X3BhLCBlbmRfcGEsIGVu
YykpCisJCQlyZXR1cm4gZmFsc2U7CisJfQogCiAJcmV0dXJuIHRydWU7CiB9Ci0tIAoyLjI1LjEK
Cg==

--_002_SA1PR21MB1317816DFCE6EF38A92CF254BFDA2SA1PR21MB1317namp_--

