Return-Path: <stable+bounces-253667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGfVAoiyD2rmOgYAu9opvQ
	(envelope-from <stable+bounces-253667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 03:34:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7585ADB15
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 03:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557D6300CE55
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 01:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA0A287247;
	Fri, 22 May 2026 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WcDoSyWZ"
X-Original-To: stable@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400833BB40;
	Fri, 22 May 2026 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413550; cv=fail; b=MJWwXZ9a4wWCwbjAJ3C1pQ8syNmTpafGov46uO4N+MiLAJ7V/aNlon3Dsea30/S+2XcR0DF4WgpiBLBJ3etVkbCFO4q1bN/26HT55XEfHhdKYml7w+hjgD9874b4nkf8CmJZlDUiruUDzae/GS5jDZaIeY9NUglq/xcn9jBDp0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413550; c=relaxed/simple;
	bh=dSoQKDK62WbAt3sviA3cVzW/0qHXizx3A8kG+dZYDx4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jR5NyuYmI0egBgNK2tH0cJEwe9enD/jwHeabsqshH6ukDmassMjxIQ85X9gi4mQH+HljHa+szowGtj3K3/zwrKh6Pz/s9pLGZPXz5OnjH4JRz/1ZF+uVPrplQZQ/GwVh47u6ZSbbdEjn7r5K7YrTSEf4Pm5D8MuVg6/JlK8N6Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WcDoSyWZ; arc=fail smtp.client-ip=52.101.52.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajOeLnBy5YoyY98xyQptrWEejv/BGDKKIcpEQLIQk2Dq4QZODvXqc6d+vU/h/R1Abw8U92WymtmzyIY9huVkZMbqzsDEiO+dPQz8qZVh3HGlkIWH3b6iDstQwvhiNZFbsG5HSCgr+jtAXEcwG/IfCfSlrt/0iPjVbM8Sk8R6MRp6vuOGGrnpXNC4aC99QmSO6+jGcbxKDUDrduyfv4Pq2xB8JelhGdUGr1P9ssZQ3HoZDZD5wLw764a7ifGLH++NC1WOVgUAFbEyG3Ucvjp69pkhMg5Ils07Db89K8Kv55clstg12znOcKzVqwwDKgtq3YxaqThhiCa6QToFxu84JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEeiYF4cLtmXpBr32wEH03Rj1WDSbAY/h+eA9H1uCyU=;
 b=K2V04yGAuIdkFjFK4pJK3SkODR2Dr1LUSYkKS0pCzffUmNDLfxjbqRZ95L9lo3kArVdTwZ8rrl6x0WBB2u6xS/ATt51/MTnz1r5S0Hv4caafvFWt+bJ6ZEH9UNCnL+oOetkeZYt5s+Gkf14ki3k5fhgj/DjS2bV7naPgZEDatXdKjY2fuTs5QK52/tHrAQo7riOA0EH4Rk+mMaslT/Yesi5NBIDTj5W8my8bhbGXDRfGjUKECOAaiag1SlmCCVhFiWhmi17V5qZ5+dYTf8x9hB6ArzBm0hngvXSlzc1zZe898JdIZDdtEy3iu+gaQdZ49i052QCDFMzN3dggSEOPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEeiYF4cLtmXpBr32wEH03Rj1WDSbAY/h+eA9H1uCyU=;
 b=WcDoSyWZJfY2BJlo5frNACX/xltpDd4Y4Zmxx5No2SJQOdm6To7gEqFFGghCFKAUDQhzlppzG64fRfz4BT8+MtCB9PMR2fONlCwLKiS6XqQ0rhtyROhoU0+LBAkR3ntaLF2yb7zxdqMXcY1+XQQq9YORUf2pxn1W8HEQOnLGu2C66asbv+3/JhAlh5PX5cybRo5ejBuu/uzDz1J4CbquYepxIglAXNEIY9aDAisu05UbfRaEBvcT3K1YmO2S5wpWcCNie4z2yLTKa6xxvUS5wEEIgOFCMgAdh8X/+JoMuZMm6G8awCGW3G180AWIBtSuh0PLyplULOOsIIoINgSE3A==
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 01:32:25 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 01:32:25 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Bernd Schubert <bschubert@ddn.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3] fuse: back uncached readdir buffers with pages
Thread-Topic: [PATCH v3] fuse: back uncached readdir buffers with pages
Thread-Index: AQHc5ykcfyYGKvV4qUmok0MZew/ajbYVH2SAgABcHQCAAAI7gIADyZQA
Date: Fri, 22 May 2026 01:32:25 +0000
Message-ID: <3447B6B6-7D86-4058-ABCF-B093BEB5D391@nvidia.com>
References: <20260519004746.3203156-1-mochs@nvidia.com>
 <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
 <F3BA075C-8E63-4077-B701-63269703155E@nvidia.com>
 <CAJfpegsJ+ZQW_WteMypErq31hggYsMMkBOPd0o+vifhAS6dPvQ@mail.gmail.com>
In-Reply-To:
 <CAJfpegsJ+ZQW_WteMypErq31hggYsMMkBOPd0o+vifhAS6dPvQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8442:EE_|DS7PR12MB9528:EE_
x-ms-office365-filtering-correlation-id: 46261005-f089-4536-b9bc-08deb7a1fa6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021|4143699003|3023799007|56012099003|18002099003|22082099003|11063799006;
x-microsoft-antispam-message-info:
 gHol5pNL0DjzdAezoVWFZQAOr8qP2/gWUrGPA6dm6g4DU1az/gKDGzDqtW7dEGleFIbvIOB4wmFiXQMHFpupuTSWgqWetqSdzhcYfdqOpXPQX61SruTb7UqGV7+BrlO84qAjMNHuJAWsoLFbOOpakwJaROm/hWkRx4cz7ZTdbwTGZHJtZcE4RN+ryEkjRO1BYb+ye9SAA1/Kx0kBNEMIVlPUTTLnQI0ElXO0K2Lg65G1kkC5aMrlS6+3G4N1AlIohEwmlSkUruspi3Sr1+yCwP0xLxmjgomu9WeJSja6r+MBickBSSGGHb0Nk6fIqI1b7Ta/cym4HgVlcH3jlir2WFubiDKwERoQtI3PYnqOR228eWHlVtP7Zb3WoeSYIfi0BbiHAx4a0tKapKZETeYMtfLP1cEc9mdDb88mVUVxBjGIKIsGSj6JOC4W+en7TCZgKfS6Q6yyLsG7yH2dEpqW+IGdmPV8XVv1zIoxCKZzx5ZNmYphV3fSF8sBITE4dqiMXA0VRx6Vtw5X59giKv5GGMQ/QU4GZITHyNILJbT2rKsolwpV4B4E4pW6foq2EyyJ9zfH+9KVN13tyYrV8ZqHYAzyUakbqFZC2mRPhhYr2cb01nbO60pQes+9RlDE3SYaOvoAmyIDJ5FCCC3wUrooaUwYanLhz4BeE9gim3j2E+LDi5QE1McCNf4gIrGZEJblkapV9czY6+pMV2tPnqqPceDesLcr2hqMQrs8kgjm7nRCAwiMhN+EiW2h09Irf2yl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(4143699003)(3023799007)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wW6ysom7yNB9EqcgSXNs9n2AQ1WEuwW8Ri6cFpM+rZQ48cbJ1yk4mg0t1KQl?=
 =?us-ascii?Q?4U10yAgMQIpptA+97SyVVWqN8U6ZQicZMK5b2chUWcByB0xe0LHjs9cSSAti?=
 =?us-ascii?Q?zQlucozrDMldlJSJippnJ/1wwp2T0ImA2z8Z3aEMJpHh4saXm8LEhoOmpm+s?=
 =?us-ascii?Q?zH4YDtTaYzNGp9biDYInoZZ1AMOkboiS3zgPR2/u1PbxzyCbSBxdd6dkeNah?=
 =?us-ascii?Q?X4Qzggjp0v2oFFa1C5G8+fa7JtU9bu3DuXC6iJlBWlfvIIh8VATYDWCvwRne?=
 =?us-ascii?Q?QVRMmmXIAbSDXnJ68D74r3Q1oVG8WcD3l+xM5XgsWE6UHVfxQzqDoe7COkdT?=
 =?us-ascii?Q?LdBh9DA0CGC9sF37p85gaLdGHOmenlahTreIEQ8zDQfHxugvnq9rVUV51uI9?=
 =?us-ascii?Q?H8ffVZQGD08ZMT1hLgaB+LkVMepySK9vaO0kDraXOtSkX46FzEqzIHVg6WTl?=
 =?us-ascii?Q?FWLXuGsfVCIV3vconhYX0kPT+JEkWsNc7aN8Td2f4CdTEQ1by15UExPHROck?=
 =?us-ascii?Q?xxLs0gyqK8AJq6nNLHlnDzIPp/Oa5PKjVSie1NDAWnjV++OVYxzAHs27WXvp?=
 =?us-ascii?Q?aTBrOuGM0xVEeSH1rTQkC2LB5HyBaoK+cUQKbgdQcrGwuHOJ3CgJw8C9eKVc?=
 =?us-ascii?Q?dmmBmER9zfkZYJzjd5rnhNqTRW/7zXC4r0yOlOR+D4PR0gzlms09+yHfXHLt?=
 =?us-ascii?Q?5TJ4CSdz7VPlo9L27Acp8lzR5TJErb+jHLG9q10ldEyA0uZfTseP/Cf7bQkS?=
 =?us-ascii?Q?x0YCDNWjBUgPFCnQIdu5arNB1dOI6uibjlsQ2bNogR2iXpVv9R9PV//X56qm?=
 =?us-ascii?Q?cn821zWF1w4BJFIDpe5TZvl5ZCmALfaAB7ko41pYKGhWpLEcgJiXfwIv3AFM?=
 =?us-ascii?Q?i9i8U85ml9d6u7aNDr2ctr9zNCWhRPVVi3jMdsEr38OKl94EB/vNjOEbJfvz?=
 =?us-ascii?Q?mr1VE/N5PKrKmBEn2BaeZqGiwozVWuscvhEID1SGYcZVGRVjlMUZuPWL6HlO?=
 =?us-ascii?Q?p2v8nnnamhJn2SYuX1QS9lnyFzv7VjZlgQ5yB+2qVW8tsJcbRCLsHuX9JWfY?=
 =?us-ascii?Q?BkDBm05oCLlcgyEN6gL/He1wvcEKQ9bsGCY6z0YsqbHliLYFjENJpnGi/YDx?=
 =?us-ascii?Q?ac+o+5qtl74TqciQlpyF6D+Cjm2us1rdSFFiIoRCfcIAhIwsdihqBP3RB+eT?=
 =?us-ascii?Q?J7Azyf8xaST7M0XvfBTIOeAfL4q4Zbj1rbyOUyR/911ERBcINYP4H9kAffds?=
 =?us-ascii?Q?CRb0JOdDZxq7jPKVQ0Rs9KxVGIyfU23W7gAJaY0o58h48YUKftohtCPi4kR5?=
 =?us-ascii?Q?Buo3k5f+kPbAoRdEXu0ZY4vhgIOlDzG5G58FTXafV6+D9NCJCaVeUmcuGAao?=
 =?us-ascii?Q?6jPhDiVyeGYlpQKUsTDc+2A5OGuxMrk0zLaB63h7kUciAe6ayX+QjlKaqQ/d?=
 =?us-ascii?Q?62QM8P+6LyLdmciYZ/T4FD5aYTe4Q0K9jdmFecfV24K9mMHaH/2Ic2AADjvc?=
 =?us-ascii?Q?jSuKTgDtffKi3JLCZXkx0KjrBJTDvfqv6onjg/U0wz7Q4hyj5ge3lJf6U1Or?=
 =?us-ascii?Q?0xkNya3m84u3qJ+LzhUK08qElZyPX127QsxWrpWpJRC2aST4KhenqVOoN50h?=
 =?us-ascii?Q?Ysre8nDQ+qxybsoZIEP+/0Ro5+2QmxuQeTda6fYGixjGmFt9nA47mAUYrQsS?=
 =?us-ascii?Q?EtkuneZmV8nhT6Xw5ShOVk+Xul3Bcai5c4zSnEJjtNR1c5kbmjkVS5mksWNj?=
 =?us-ascii?Q?Tcw+kRraKg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29BFD23DB4CDB94596F67F5D2236B7D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46261005-f089-4536-b9bc-08deb7a1fa6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 01:32:25.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jn/ZY7NBLZtrOKFBnAP0EdJB17dCBoOQ6klwTkgIf0rkOwahqC7VYw7suLVrlc6xoHHa8065y2qKJPssNpL2+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253667-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mochs@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,szeredi.hu:email]
X-Rspamd-Queue-Id: 5E7585ADB15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Miklos,

> On May 19, 2026, at 10:41, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> On Tue, 19 May 2026 at 17:34, Matt Ochs <mochs@nvidia.com> wrote:
>=20
>> With out_pages but without the byte-size cap, fuse_simple_request()
>> still returned -ENOMEM. Capping the request to 1048576 bytes / 16 pages
>> made the same test pass.
>=20
> Can you tell why is it failing now?

I tracked down where the remaining -ENOMEM comes from.

For the failing READDIR request, kernel-side instrumentation shows:

  READDIR out_size=3D8126464 num_folios=3D124 total_sgs=3D127
  copy_args_to_argbuf: num_in=3D1 num_out=3D0 len=3D40
  virtqueue_add_sgs: ok
  completion: out_error=3D-12 out_len=3D16

So the output is page backed, the argbuf only contains the 40-byte input
argument, and the virtqueue submission succeeds. The -ENOMEM is coming back
from virtiofsd.

The remaining failure is the virtiofsd READDIR/READDIRPLUS range check.

Virtiofsd advertises:

  max_write =3D MAX_BUFFER_SIZE
  max_pages =3D ceil(MAX_BUFFER_SIZE / host_page_size)

and then rejects READDIR/READDIRPLUS if the requested size is larger than
MAX_BUFFER_SIZE.

On the failing setup the host is 4K and the guest is 64K. The guest ends up
with fc->max_pages=3D124 after the virtqueue-size cap, so uncached READDIR =
asks
for:

  124 * 65536 =3D 8126464 bytes

That exceeds virtiofsd's MAX_BUFFER_SIZE of 1048576 bytes, so virtiofsd
returns ENOMEM before doing the directory read. On a 64K host this is maske=
d
because virtiofsd advertises max_pages=3D16, keeping the guest request at 1=
MiB.

Given that, I agree the generic FUSE patch should not include the max_write
cap. I'll send a v4 that only backs uncached readdir with output pages.

For the remaining virtiofsd issue, does capping the local READDIR response
size in virtiofsd sound like the right direction? READDIR can return less
than requested, so treating MAX_BUFFER_SIZE as the maximum chunk to produce
seems preferable to rejecting an otherwise valid request.


-matt

