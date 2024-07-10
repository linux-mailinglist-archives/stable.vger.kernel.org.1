Return-Path: <stable+bounces-58967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C188992CC4D
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 09:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2B1F21301
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 07:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E384A52;
	Wed, 10 Jul 2024 07:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PbsIel7C"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020129.outbound.protection.outlook.com [52.101.85.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217182485;
	Wed, 10 Jul 2024 07:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598059; cv=fail; b=UHs6hSld41DA+NPfWCLG2GgxY2zZaxRuG86SdBm3YnrZCqj78m966YWmRqgHbTKMFsYWUdiritnBR19KWag7FYEvqaHvOO6N1FdPbXa4JZxXqi8W0lW6iy9Zskjje0m2H6kSVqwpCLovzUsJmywqLpnYtQHf66S7FvEpyxEpZCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598059; c=relaxed/simple;
	bh=GKTcc++wblUjdMIxEVhudBI/RQ4Ee8v22UmbhCiYFw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MftE0L7HDKw6gSn4AaXM4AlD/iUt36r3UgMqQK30V9LWt59HEs9Y1l8lnbz5eCguj2Lmt+Q9zL/NKUWFf8FI5TCCdLhz8NPGPcjJ3joAQijESeqdDA/CKueCr5tq41X6+60u66a8EawaAFCPmObGQVEcyRFvCQhYR84W9epzYP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=PbsIel7C; arc=fail smtp.client-ip=52.101.85.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv/k9+PG4ax7QTCfWhNoJgOMGfJLLAjhfXZQYoL848Brk/copM4S0+m6P8GxQYIBdjJ5oBfMRXA5r1GzgKhzttHRFNVPagNXvqefh10Dz7CpmWiyLJPAS8cfIRk1OZPJ54L4Whm80NWHM5pVRmLSIkgaofAgkhgWe8ZtL44dwsBKOxN1+Uq/cpQ8ngQeYm4S3YoNANoBnOtVByt0PLRKN/Xa+vRmbWTG08MjR8wo+T9VG6CIV4swKXj9BkD+OfFWYG4WiPoHSpUsCwA2xlXVDqulNNNxZ3vQdOnA5W+8EX3Cf9gHc5UfoYhNVBb5ODq46T0sP4GWXbDN4460WuPPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKTcc++wblUjdMIxEVhudBI/RQ4Ee8v22UmbhCiYFw0=;
 b=ckg094ZkiMNNOhR25jFJemm6co0vO6rNbFJ7TiKlEHPeCmI9yLuIomLuWFxqRrcbmubn+bRHrhq2q90nfJM8+umS2iwaVv3jneOPULqFo7IuCR4N3ok8uQPj8NDxz+ntg/6PRPCQxN/qOrEcxLUT0MygJYOFt+Uhm8SoCmdsOLv2yonM/wtkNvwxeQ86R3PYKFkWnk1v2VIfmPp/Oobj+FQzyFwpNQXi56Bm+Sb8JHnRYBlm2QMUh11N524b4zMHRzZOMXtt7lAQr1+tZFL7EJwPwJ+mKwW6PSOOdBI+uTFz1PAaH9D4nxbhxOwhBasPdylHYrcKHBpio2qjg0MylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKTcc++wblUjdMIxEVhudBI/RQ4Ee8v22UmbhCiYFw0=;
 b=PbsIel7CdYIw5PRu7e1VB8sz9weQzruhGM6FdmYyO1hQvYi8Nzmj054kwFUArK9hmjJ6+iTWJY4z/3H+omoT0degCmmz6WB8JvMvwNNHDbTF35gnMwBOv1GTnNU4TAjk6KHcXAhlBCV/hgYu4isIXbMzRR4F0leqvV47ldSmvl4=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by CH4PR21MB4218.namprd21.prod.outlook.com (2603:10b6:610:22d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.5; Wed, 10 Jul
 2024 07:54:03 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%6]) with mapi id 15.20.7784.001; Wed, 10 Jul 2024
 07:53:59 +0000
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
Thread-Index: AQHa0Wtpz0U6bwgC9Ee4DSiEch1K2bHtOg4AgAEDVACAAUnJMIAAEb8A
Date: Wed, 10 Jul 2024 07:53:58 +0000
Message-ID:
 <SA1PR21MB1317EC980E4E02C20A2C1350BFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240709110656.GEZo0Z0EoI4xmHDx9b@fat_crate.local>
 <SA1PR21MB13173395ACC3C0FD6D62E36EBFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB13173395ACC3C0FD6D62E36EBFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a3268431-e318-44b3-93fa-31ea7c931370;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-10T06:47:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|CH4PR21MB4218:EE_
x-ms-office365-filtering-correlation-id: cd7f3529-da70-4102-6124-08dca0b574c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sncmajf5ms7g8RGacEKzMULWOUyD0bqH7g9RJsxIgn13iK1dVYc5nTRnlcAq?=
 =?us-ascii?Q?OlGKyRaiwVZqj0A8isJR7D/6myusfPrjSohJvC5gtsBVDIHTT+kbuJJnANfB?=
 =?us-ascii?Q?5YdV/fdFGyRJY89QgYO6WkXG2uk65e8dg14GQPzP2d2feHFoTBL0ZrgjdJSy?=
 =?us-ascii?Q?GCAzZxOUzmKgzeSg0G0tA2aL7jkhRowHUvapxzjGAwaInvryHXBYHnT1SNmS?=
 =?us-ascii?Q?qWDOvKurIJFElPn8OEDvP0nxBl1EqRZFgjKDbLsbWVIHdW+SY3zhky89Ps6n?=
 =?us-ascii?Q?YZa6qw5n5xkZr6X+NmOyap8Y/4rUducCvW3JSmBvnK6l51hvG9aiO/8jJA1X?=
 =?us-ascii?Q?nVuuvTzBGw9fP2EyjVIs//qAT7DQuDA3vq/aYgbgm8yv+UmFjdGmS24Y/mb9?=
 =?us-ascii?Q?FV9ZLIvlDtSHrRi2dZN1lJ15nw5YQpGU/rtuYzHKJFsAujmR74Skp7ic10Aa?=
 =?us-ascii?Q?oRtNndykjK29j/xdXQEKr0rhCvMVyoxzJq4EsbvzdsmPlxbr/+4SqzFTLVt8?=
 =?us-ascii?Q?HhuOUHkX3bMRXIBQRweApV2cPHyNAbDP3Q+7vowo7LtrhpLMVFRUYJM/MDdN?=
 =?us-ascii?Q?ijL9FFozXF7fA34faOPWaA0jr74EaBmyb10rZzomBz1qZjzlY2yAmhhpzM15?=
 =?us-ascii?Q?aZl1IAOMzMTFhrKk0sJrVP0efYZORWmgzkxvdwHbYRIA3yF0jFSQCkfKSjfE?=
 =?us-ascii?Q?uuFpELTig2BvavyTAARCsgMyqeG+UYRUqlysBPqvnAYgzE1EjjTDYuGdVXEs?=
 =?us-ascii?Q?Z2VQlDWGDS0N3wgiFRnklQU7TKdOXPfAbKZQQC/oCVh6D/D2kZU4Efg3b8pR?=
 =?us-ascii?Q?5/MHDTUlr4mmdtV7QuRh3t8Y77nCzNrk7hjLgQX11caTCbStqVJS4Sgi63w6?=
 =?us-ascii?Q?9IctumbTHR9QSiJ0lY7xE6gH/2Qe8zznIadebmQ3S11vCwdpYUHeKyvsGsUp?=
 =?us-ascii?Q?F1KCBrjOrU/mKxxLEpahJXOrH/b+vD2vhwqmj2OYs6VlnWWOs2hrHnAp+7R0?=
 =?us-ascii?Q?nzsueNJo9IuASNLQhWR7IveHQ5D2ATUyvO7GB4zsLVcTPk3HSFOL5ef5hcn0?=
 =?us-ascii?Q?GMSwYWY0UuVyIK4EUOp4HpZu5A1eXip3+Kq5c2D5hOkyEiNDS1VUoVgbDeZ7?=
 =?us-ascii?Q?roUkH6O7l6Hl2cNduTQopVf/vI4UKekAD675IfUo3Bjw49XfjeGS2VnzukBm?=
 =?us-ascii?Q?D1+6t+wb7xMErDuTXGim2QUu7FFvlXNVfKAuIOgJMlgI7h9EssegNn4p8WZM?=
 =?us-ascii?Q?T/FMAeJu0TDs2gFsc0Nu0G3AGiWuT+Yv1GdRpE0H1xWBYtWctPF4hXOdsq6e?=
 =?us-ascii?Q?HODvc3ebAAkdJY6GTFdFPt1cb6GKburfoJWK7oaNNOt4blev1+tQeiXFA9V/?=
 =?us-ascii?Q?c4mzX9pznc16hqtV4hOgb7HqmCGfe4BoSFXo4IFwCeRssIWE9w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2VLlA4/L6Gm93nSZdRYpwNdz3BpB/xneC7m9V8pF0QMV06VaVkHQ5ep0WiRT?=
 =?us-ascii?Q?G5jqaD9AUM5BjCsyeS0efTe0SxmcXT1bjlabxCpYfnv+vc533vnrd63D2xmy?=
 =?us-ascii?Q?xeP38wj2DgBhvOFwjyUk9E1lYhgVCs/2m2qttBB4yKCLrYno2Kz88ao0uV49?=
 =?us-ascii?Q?wxymLEoKGGrcCcPhLPNm16o42kThj1hemfL4KSBcF1yvdEL/D0eLOVeKC7Wa?=
 =?us-ascii?Q?fqqa0dX7uLxqSGEBifPXfIv2zQ4HQHHhQfcnjWCXuf5HoT7kkiWtQhceQTTn?=
 =?us-ascii?Q?Ov3eHqvvwlcAXRIJrB1lHT4e+w+ttAxnnChsl2Tf18Oz9PvfLYk7Oip+fzUo?=
 =?us-ascii?Q?SDwoCzlGIAi8mOi7d+zdTbrZBhOmn7DmmdDpFpqOexGknMcCfca/aGSZ+mnt?=
 =?us-ascii?Q?H6HOxWSeqzoCxdam04NVGZxhhF1ezWkh/KxW8pdA3eDslJmmWu04+wd6oJAl?=
 =?us-ascii?Q?htYsrxuUGbxnKF2Q10gdESV1zjVZbCEF2gMeKFjo4LYKMpHD8SPBtNRgHxi9?=
 =?us-ascii?Q?QH0kZbvz+ToWmkrgrSCPRysOtvCvHvAjQpHEhpteyt/y3P51RhiH9qvZ9+1a?=
 =?us-ascii?Q?X4f2GookawInOsscbyEppO74/LgiDmzXKcXmHcgxQKzbP5BRh6C0Bn3Xm4Bq?=
 =?us-ascii?Q?X/pFR6I1kNzsPgIgGprvnRPrA8le247gRGEOtgbwGm3VTfD5iSxuF3OfRR73?=
 =?us-ascii?Q?lLpk7LUS+1wJhW+MDHaVQLMGmGi7xWZNNM1fB+QJXRFnC16MQan0sfrI5eAa?=
 =?us-ascii?Q?fe9WQU3ZhU0fwiWu0qICJpAQVShdMQOXdYWvkmeIFmFSN0EURN9ZQ+L8QAX6?=
 =?us-ascii?Q?79kQmgj3ww5tMb+5Ej7bPonmcpqY/d9+mO3xEVHFcr6Wc05+v0c5IH9mf7DJ?=
 =?us-ascii?Q?PixRgYNsrNz/VqjVqAF5yHl5x/RLbwGADFgQ2Cm/w1sRYf2MixuCLsAM9Y88?=
 =?us-ascii?Q?BXtM78WNorNbK9L5YaByiasEvKuz+epLqdsC1N5KVMGbClXlO6MDkoWjbV22?=
 =?us-ascii?Q?M7q973GppYJuT5wJvjUbSwUg3tUtVAO4csva8BYkdNqanHbcKcgLe8WcCdUk?=
 =?us-ascii?Q?XJe1WiWJvMQ1e++Qpl6F9iIdhhatvyx7Swrk/QSUeS9r4GVDoRClmnjT457H?=
 =?us-ascii?Q?RFGmv6R1P16QOm2hHUF6LvjKqAtWKBup1ht6pe5pvXLuKau1sfAgYDLX0PQS?=
 =?us-ascii?Q?Y8lZDkm3Dk+kv7KZU4JquaTTwWAU2rkaAIeCKMdKeg3/ffz9R2CKXT7USlw+?=
 =?us-ascii?Q?UmGIDYm7ADE7VGJy+G8gxIIm1A1qoOgK4+KQ0JrbmZLqRYwmEui+ZCc1d51f?=
 =?us-ascii?Q?XgpYOgRsLMQUNxaGCXr3y+RELh83cm1xenRDBXQbCV3Yp1E3mThy3JtVgSGZ?=
 =?us-ascii?Q?By3OqqKMyxSobz+XuzGrM9STvLBs7Z+fMCpSRizfhiFdlsdCRYXcu8/L2LBU?=
 =?us-ascii?Q?J5Xh1HmmQdFCPWDzgqeELf5aVQUl7Kdy/kpSrapY14BL8zMTP+Zdn1lz7v/s?=
 =?us-ascii?Q?re8G4n9uafhii81+Na5tbnXmLV5uJ6E/RHZZgKAly+Z3ojsaPcTR3WY+WiME?=
 =?us-ascii?Q?bfoL3vErL9OIRZQBoG7ZcLmnKjzwRYm00RzYukVk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7f3529-da70-4102-6124-08dca0b574c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 07:53:58.7652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hSq7s9w0JASIBVVTSBuslSiX6UrSRRZvhFDNk3H+EFruGliApK5Yb5JvZkjdCLXQd+/Vi0+33RpuWXc00ODKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR21MB4218

> I guess we have different options on whether "the patch has changed
Sorry for the typo -- I meant "opinions", not "options"...

