Return-Path: <stable+bounces-58979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12092CE13
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 11:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BCE1C21F7A
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C118F2F7;
	Wed, 10 Jul 2024 09:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VRK06fWS"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021090.outbound.protection.outlook.com [52.101.57.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5D117BB31;
	Wed, 10 Jul 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603263; cv=fail; b=RpbfzaskodQGvn7TleRtYF3p7VvA7viuvH/+JbMQq/CwNczd5lOh0/yj+DozwQ+1aPP22obv1HvWf+vyNRB/MzzMv3AWTyBZUz7BkX9oo2poK2Xmt06i+tBAeB62gewo6YYI9NBA66um8x8Jv0CL9ggh45ReQFvUOrukvcOYWQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603263; c=relaxed/simple;
	bh=7V7inL22ONKCrPGQo1jMNM1mtIj4ZsKmUSSxsjo4Mp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvCOO4YNWgigXQjijJ6huAlp0u/DsbwIPVp8Bd7N3UxsthTUD5Q29Ar05rPjdsimAiUFSSeFgaEzB0efP5JPfj/GKKeQVfTcSNMLr7k5iy1pPaKBrpehKx/YERk1EWwzwQHKq9kbkiryIRoi9m9+m4oV6V2R/77DqB0f45SaZMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VRK06fWS; arc=fail smtp.client-ip=52.101.57.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+WRM3Nad5orZjyGfx4NMR1RLgQUKPESS9hq2rR1Ahyz37HDpa/ap7FiIqUK8qYk6o9Fd3BSfFfne248qK6Zv8YZssRPOocVymz/PHJ/vtM6+w9RFSI3GGXa3GeY9R/Bi0SRoox/qYlzPFu/dLMx7KB+Hc/peur/s9BkooFciXRsOmibwjrTrmFH7amaTD+lN1C5ra71u/QsZLklisbh9o/2JkkSie6P4ypc4NqY5KyGkQjvgtje+3tm5tZLDqVOy8DA/V+An4C3vIbypcIPAAQT5GLfqYvf4CBZMXUnXAJnp2CKWszl7wcLlSHpobM0apSDn9684PqHFetPLGhPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2OV6kQvov1N839pwgjXtUqVgh4PIp0yM1EYUnqYY0E=;
 b=maaT8q+rqiATnR/kZbEkO4KMiWcZMAfJ1YE86jZtaEmIkq/XL9PZ/a5N32TJHdG0JUHTWZVr4jz04oSz1bdQkY1/AMqaArONuEnLC02ueSy/E6vEy3FWGyU3FCPUTrwsyLYGmqRNypMzosoiAiHBGCJ3CByCfXofhwlv/ZDd3jiwUUgi3ioKDxlWvMbs+nTfZMfm9lcFLdb0E0f1mgypdy8XytBho9iiv6WTRHRl527TVbfIX6oyr1tMddGjbAhLgsRE/j3dxplbYoS9ViCJmpsqPUi/VbeY/eW6IxCx0udpCwUmvNznnZy8WC3vrAwHooxhQOlSd1YF7GQt4DCTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2OV6kQvov1N839pwgjXtUqVgh4PIp0yM1EYUnqYY0E=;
 b=VRK06fWSMk75yL0gZVM+uK/nSgz2GOB9PyhC+kRp0nJHtT8Cj4Cfu007KjZEfs8DOKTH7L7/4HXG4ymxrwz2twTx9Uaf9PtQqJ14OOt0jrh+WE2shKYej9c0DRXYIjZi2VHQLDR5TUrqCFoZr7S1hrEUtwja6joWUoMehax5BmE=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by DS7PR21MB3477.namprd21.prod.outlook.com (2603:10b6:8:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.6; Wed, 10 Jul
 2024 09:20:46 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%6]) with mapi id 15.20.7784.001; Wed, 10 Jul 2024
 09:20:46 +0000
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
Thread-Index: AQHa0Wtpz0U6bwgC9Ee4DSiEch1K2bHtOg4AgAEDVACAAUnJMIAAGIOAgAAKsFA=
Date: Wed, 10 Jul 2024 09:20:46 +0000
Message-ID:
 <SA1PR21MB1317C5633D8F537A73A1CE17BFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240709110656.GEZo0Z0EoI4xmHDx9b@fat_crate.local>
 <SA1PR21MB13173395ACC3C0FD6D62E36EBFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240710081501.GAZo5DBW3nvdzp34AI@fat_crate.local>
In-Reply-To: <20240710081501.GAZo5DBW3nvdzp34AI@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6ef10fd5-fd49-4a4e-9ddd-89933fd23c9a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-10T08:53:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|DS7PR21MB3477:EE_
x-ms-office365-filtering-correlation-id: bb403c57-d844-44b4-6a42-08dca0c194b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G5A7MoirGXsTaEze9+JzjH0qmcMlDIVeEy+0r9gB+OLrO3S8uqU6l1GX7Emr?=
 =?us-ascii?Q?ecMxhr7HvOG+kUSC9okJkhdzoLsEk6oT8nRsvo6L/OWyF59rmlAjIyQfBkxm?=
 =?us-ascii?Q?/HRzEbkTNleSQNyC3CEfNWeRBQaEj9iZZd/N6A+pUCFwDjiZtiL2eTNjvKlY?=
 =?us-ascii?Q?aLg8Y3TvdCvOgtrlb8sebGEItJCYiI0uKqYuaZBHY/7VzLO8ejurdAIrGB0V?=
 =?us-ascii?Q?LXIDIs9Ik1/KPNQRbtndKYp4xgeH9/gyv1OWM2QSAEYcpxqoU7bvvKJoippW?=
 =?us-ascii?Q?rXC5fzawVflZM8gEy97/nfkhADIOTAJd+hgZnf8LuOsPNF4FokfnuRg+RBIQ?=
 =?us-ascii?Q?6GBPaf9BPLI/LmCR/TQKTOsnAfG7zmTtOJs5jMeEJhg3+0bHvDAlVR/gLzfs?=
 =?us-ascii?Q?xhG9It+nuwJwNBntd7ohJyoCxnvinMvINXOiSD1zVZH3GCl5ZcIJmBqjXXBm?=
 =?us-ascii?Q?5lfZuLC7IV805UVDjrMcqZaVhfWMerGM/+5HjClZmxVXkKgEfu4NLCUE7dqo?=
 =?us-ascii?Q?bW7WNxOOAC1EZ606dm/jlNShjp8bDftVGtBddg7tUC4pR16wJ2qtEhkUMs4f?=
 =?us-ascii?Q?wCa2oXrXZjkXQbefnxu3KqZs9Qm/2u768A7ba8AhpYLotP8HIiARz2TXnmiq?=
 =?us-ascii?Q?YP/SqxWEqtNKo5VWNkb/8GgrRXTYU2Mu3a7U+l0OOwPQ+nDluSA5c0SLu2wQ?=
 =?us-ascii?Q?B/ex+D/gMNLpdRB4HOs/AJ12ZZE5w6Mb3hjs6HfrmT4wz24f4jMxnts4/QNS?=
 =?us-ascii?Q?elVjbSxpT5OHdVEc6saP4t080QWWafkHip/jKBYs0V61SFwBm7kl2zsyImLZ?=
 =?us-ascii?Q?ANgWoQLP4bSuZ3NeN2r9whUogIG8J+vSOe/XbcTQ/dflcNoRMNd6cgmZ6UQH?=
 =?us-ascii?Q?yRRVPKBbtQZLF3D5alBHl5jM36NWC8N6nC6S+TpRxayeche17aREiuvjm0l9?=
 =?us-ascii?Q?E3tomNI9e216CwDuEOJsPC0Pz+xL4jBEV3kKfJ41WQLwVVcBNdEgPOZG5qcm?=
 =?us-ascii?Q?p17Cul2I8xtTBOGWR1/ZYD6iJjOs1lGAgtkn4vqK19ww6EoNhdNmHFMw4zVm?=
 =?us-ascii?Q?crRVkox12D5EXjSl/UCQLpnR/un4gegllujLbzZTgKuUaZ0mJ+b8vvno1A0T?=
 =?us-ascii?Q?wtV5VhIWQytgzWbbKgp8RpkpLZXV9wU1vZyD0VX8RYxd7icnkg45EaL/E6xn?=
 =?us-ascii?Q?hKIucMZpY6xg1wIIdRqjXlpUFekLeBKDW0ho314jyuJteaqaQ4YRkmM/wkjV?=
 =?us-ascii?Q?lr4bfa6Axj+TSmEH6OUlkMbMAh+uwd+IiwAO4oxAs6SJR5srfaFxTy/P0oEG?=
 =?us-ascii?Q?hZAc7vdc89uLgFiNSRg6hrtNQ8lBZgqe2aZ6KGAERSY2gTri8HHBkoAi/9Op?=
 =?us-ascii?Q?HQJaC2nMUrbAKgoPU1j2O1o0Yehue5FRh1MNVqpw6EIzkG1GlA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MsFY5I9qw7p8VkfUm0JnsPpQrnJSNSHzrm6THCbB886xiSGzgkxbMyivk/Qp?=
 =?us-ascii?Q?ND5bbh6mPonPke/lD3NAlhE0vwa5KyoesVTutJ2RdlP1NngJNLc8cIR/+evB?=
 =?us-ascii?Q?ZZ1ocSIl0tK8IXRlmZvoipHOrfzwMf7YN+xG/Sh0jO7xVkUtTzowLDPBKssK?=
 =?us-ascii?Q?A7kK0uOsy7PNt6P4Pu7CIAJqKKPzqPsxf/bL85tJP//Vx8gWAVZYHFiWRIw5?=
 =?us-ascii?Q?Mcpley2G6dxQzQE3yOUdxRs3iCqHLdRSmdadYCpJEqgZxSw7S9aM8gmP90iW?=
 =?us-ascii?Q?IeLtY6KlYLI3cid2kblwfTEJWkmzzYdI5xOV1jBQuzwnT4xxReFZWNv9tPaG?=
 =?us-ascii?Q?RThd7s/0rpweL4nuFulxfcJ91xu3UdiCqHGs0MdMhUpC0Pg2UXzmUGFA/pVu?=
 =?us-ascii?Q?ly5/becwlX/sAhxAis2XW+FqQYO5Fqwv3l0AUsnPYiFw1awaeVX/Yy07/umS?=
 =?us-ascii?Q?St8eIiE/edf/YkC1HaHRlQ3nH7VNkrInItjH6Ju3IJ5T9n/kggoR+HdF4yPa?=
 =?us-ascii?Q?ord+5ZNlpzrxEp8QVJpc2KT0iNPOmFRAYIqigcyGpUT0hDc4Zt9GiUtlYH25?=
 =?us-ascii?Q?TjJyfqVT6QPT/Nb/RBRVk6FUz792RpQqs35u78wR0nFgSa18aOi4jTsrpI25?=
 =?us-ascii?Q?6a5x3gIuXKlsGmt2noY9WY5BiWck/IkBhlLyZewowpgoi03Zp7BypKzXDpBA?=
 =?us-ascii?Q?bJqaharfP5+qJF1h8p56fv+D31ML73VGvuFHrxjVPv52+4JikJW/V64PCxfH?=
 =?us-ascii?Q?J+wb4zxX6rIUVybJum7KQ34IrZ41Mp2mnVtR/rAqNHO6TS0kzl1T7rDMMmCj?=
 =?us-ascii?Q?ONTDWp38GMQwyMtrTlZ34gFKYwVowbRPBdxJLB2f8tIFIoTWt68JTzdwSb/+?=
 =?us-ascii?Q?AUVXxxptGhg1yQd+jYM2/5S2rm2gQ3/HXZjgnPLjmoQ77Ts3gMNM3m4j6f21?=
 =?us-ascii?Q?SUMFr2cCLvbA9Pa3/ZsXzkdY9SF2oRmu4ayEksT8sJgbLOdHAfONDRYEEAbA?=
 =?us-ascii?Q?ZcZkFnv2bL1ibS3gVX/kYgRnlOejmMHBTPRRFYPeVTI+0ruRd4bG0cyidsRr?=
 =?us-ascii?Q?QYsTY+RaD7HMtrgY+vXO6XWnsay7R0urzgJsq6BlE/+FX4Cma/My0PBlanbr?=
 =?us-ascii?Q?kdNK1mx/I8Bl3GjFOj85bMuYRBly2uhkfgojwOO6T9ed+DWMqpkZvDCHlH0x?=
 =?us-ascii?Q?JhFpcKpjzf4+8XDbVvdyDTT7m1wRfAHYWS25PcygyWvEkR/amfDXd2rpC7s9?=
 =?us-ascii?Q?tNJR/R9mx8qZdwbltNVaMmm/lPl3HabIOBgQwx1L04ik9HzMYcvZYfitAPNy?=
 =?us-ascii?Q?t/1jXObzJngZjA6Z101Hs9Nca3rxKeO7tMKi+QCgqhNVuCZlesGGZ0+ZjQoW?=
 =?us-ascii?Q?epwEGSX/ID0qKAtHl1hTtE7m36DxEJlpw5zFjaxMBqCvai0ooG+aRFaawEjr?=
 =?us-ascii?Q?1fS4VKCiM9MtYSMiUEQgC7WYoNFcqShi6TIOPzi+voXsa4Z3b/VteAObZXCg?=
 =?us-ascii?Q?FwCItsxvQabzd6Z77Caj9U8fIW3xXgfFQJscKsru3JY9OUq97ukmRU/Lw2v5?=
 =?us-ascii?Q?AAZAQVDrBrldPQ59GFQ6GyguVM+IHNvmEbVj95G4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb403c57-d844-44b4-6a42-08dca0c194b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 09:20:46.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: odgjJDzp3IwJitvGyKN2hxin6skKa1fGNNl0wYZ0pO2RW/wiBJjRLj31MpobgSAnq5ifYo1BDXb+QXPNZK79xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3477

> From: Borislav Petkov <bp@alien8.de>
> [...]
> If I queue it after -rc1, it'll be only in tip and linux-next for an
> additional 7 week cycle and I can always whack it if it breaks something.=
 If
> it doesn't, I can send it mainline in the 6.12 merge window.
>=20
> But we won't have to revert it mainline.
>=20
> See the difference?

Got it. Thanks for the explanation!

> If you're calling the difference between what I reverted and what you're
> sending now unsubstantial:
>=20
> [...]

I didn't expect that 'diff' could generate so many lines of changes :-)

> especially for a patch which is already known to break things and where
> we're  especially careful, then yes, we strongly disagree here.
>
> So yes, it will definitely not go in now.

Understood.
=20
> When version N introduces changes like above in what is already non-
> trivial code, you drop all tags. And if people want to review it again,
> then they  should give you those R-by tags.
>=20
> Also, think about it: your patch broke a use case. How much are those R-b=
y
> tags worth if the patch is broken? And why do you want to hold on to
> them so badly?
>=20
> If a patch needs to be reverted because it breaks a use case, all reviewe=
d
> and acked tags should simply be removed too. It is that simple.
>=20
> --
> Regards/Gruss,
>     Boris.

Got it. Will reflect all the comments into the next version.

