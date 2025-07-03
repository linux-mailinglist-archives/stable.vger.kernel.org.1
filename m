Return-Path: <stable+bounces-159280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4D7AF69B9
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 07:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FA63AA117
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 05:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F095288C21;
	Thu,  3 Jul 2025 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h9ltF1Hp"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022087.outbound.protection.outlook.com [40.93.200.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1240B224FD
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751520364; cv=fail; b=VSJWChXrOvzyW4Edl/EEQswDycvTODxJsSpxCeXK1dSIR3E7uH/zRZL14VJA3QwUMUkHXKOvd9hWdS4yiylPVF+Qr5oz6+Gn+oP0arFMi2qlZ1HozrVoGOkZsAkfDrhGbEJuJyL1SByF3Rxx3dPQfawWGs5VkGO0xdx49FNiVqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751520364; c=relaxed/simple;
	bh=MQkzhqVpQaFNp2Yv0kzZvsvcvAD2SXUevvSUPHLYXRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rlS692urxWsItADUlrnJVzv4MKeLST6ZzXNQs6Sm/dC5SlIJL5OGSd5pkAAbNbsqmWg7SJA7hK9am8aGUfXvOn73SBDXhPic5RVYt/uLgSr3dq1T2n7e1pEv6BPA6LaocvxI1rP8grHk+9xk08V2XPwwnaJSMTX2Gx2BGTi7mhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=h9ltF1Hp; arc=fail smtp.client-ip=40.93.200.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0LeVsSz+qApyBe2g21S8OL8Hw4fS8Ar7HTJceXycs9GJToqc6bMmyzzFNH0TCXdTFc3tA1g1uaGYaG7kJIG9zXQn5o5MmPlhwkRZtasYdL8hPe5lQU929fHA9EYdzh0/PwCPK8NTIzhqLIbR3YMsdFU6HAxGqFi2ST9sSWU0r+YHveSfggXAMmoSaxP2aAOZf6Pwjg3ff+pZumpKPkjpbSzzU8GvxN9XAViHmPirF/DXR3LqxcDSmJkxMM790SFbnIl/VKL9/0G8cwU02HOHdThjmNhTH+0rhoSAWTRZ87OKqIqVjp9YhbqDUbvNr6vqRn2crzb2E7nuAoNNhrtnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQkzhqVpQaFNp2Yv0kzZvsvcvAD2SXUevvSUPHLYXRw=;
 b=SvqXnst2JWDD9odLWDCWqA7ych0aEMHojPS5+DeG2a0ndDiD1NXjxq/NIfoFXJahGjsqIowmZu99poH4vyxju4jUGWkVZTSwkpZquTjo4GVFFvkbZBClUm9BR2Dy6c75192ZTCqeFceNTcsuzn6T6BBCk1kF+/lD2y9QwCaQZzuKiS71FCzAegjRME4SwZyGotf7Ln9HzA9Ko2PL8RVGX6ZvwsGHKRcFTieYGpioGPGs264ythWWodPptSIcN42YE9swCA1uvCDmh9vnXNHSOL+ZhHl83l5idMJTyXVZlmmQy5u/4nzbZ3wNic8NuzulGvokbdSaDLEzKlU2LNm5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQkzhqVpQaFNp2Yv0kzZvsvcvAD2SXUevvSUPHLYXRw=;
 b=h9ltF1Hp4zKv/Kisi5Df+bAGVI6IOmRJain6WP3/TnLTWK0We9/t+tYIv0TbjrixlGY6S6UQzo1D8o2S0pgY7wUHTtNRWtNVoN+D7fQ4tFAgtmaq4oiCugK+BXeVxwG1NKmIDXE7pE3s1tak8WD190WQC18zAJgqZcN+VpZVOAg=
Received: from BL1PR21MB3115.namprd21.prod.outlook.com (2603:10b6:208:393::15)
 by IA1PR21MB3714.namprd21.prod.outlook.com (2603:10b6:208:3e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.3; Thu, 3 Jul
 2025 05:26:00 +0000
Received: from BL1PR21MB3115.namprd21.prod.outlook.com
 ([fe80::7a38:17a2:3054:8d79]) by BL1PR21MB3115.namprd21.prod.outlook.com
 ([fe80::7a38:17a2:3054:8d79%3]) with mapi id 15.20.8901.009; Thu, 3 Jul 2025
 05:26:00 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Stable <stable@vger.kernel.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] Re: Please cherry-pick this commit to v5.15.y, 5.10.y
 and 5.4.y: 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM
 boot time")
Thread-Topic: [EXTERNAL] Re: Please cherry-pick this commit to v5.15.y, 5.10.y
 and 5.4.y: 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM
 boot time")
Thread-Index: AdvllVoB26Bwt2gvTKGjPCsNTOJcQgFkx56AACOOJHAACKaLAAAASbEg
Date: Thu, 3 Jul 2025 05:25:59 +0000
Message-ID:
 <BL1PR21MB3115C5010EB37D03E436A993BF43A@BL1PR21MB3115.namprd21.prod.outlook.com>
References:
 <BL1PR21MB31155E1FE608F61CFC279B2DBF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
 <2025070245-monogamy-taekwondo-3c95@gregkh>
 <BL1PR21MB311511454704263AF04C53B8BF43A@BL1PR21MB3115.namprd21.prod.outlook.com>
 <2025070345-viral-never-921c@gregkh>
In-Reply-To: <2025070345-viral-never-921c@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ed40666f-53f1-4369-ac58-51a63da37c2d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-03T05:22:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3115:EE_|IA1PR21MB3714:EE_
x-ms-office365-filtering-correlation-id: ecbee34d-de15-4af1-db3b-08ddb9f2185f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rEslpb+a27UDdKTmOUPA4PpyPCMYA1j6m5+R32XIYKZCrTa3HReFnIJiadag?=
 =?us-ascii?Q?O28YLOfx3oDwD+cpizBsC/8RIx3F8XAerbiUu8jofI1VKUlPeNRUBF/B7J5M?=
 =?us-ascii?Q?gRyfPNU6FvJUmvSjb573eNSzATr6VbwujSkQYA6LNYRFpIfHwkEwWtSvZpZ6?=
 =?us-ascii?Q?G9B8AFq6B6RVwHjqPdpt96Qouh0IH+X0pa32umzuReQt1jvFHiNG6gaBbOoj?=
 =?us-ascii?Q?ckrAvQ2RT0rge3FqPv7IWE+g5tL+U8hBdFht3V/1Jvs/5DIg4Xs0PqlyuaQg?=
 =?us-ascii?Q?r9MEIRSe///LtAW2WHs8PtHZjNLWyefP/BC6TNE2DnWi0MDf/nm8/f0kkmQY?=
 =?us-ascii?Q?fZcIYRXD/sysezoQLTollgBpvxpA8DMnkQUjTIJg/KA0B8Mg8TwWbuh5QFyW?=
 =?us-ascii?Q?m/wHNDvDAqnUSY4AxaqG2sM7JIST/QpUDYbM9Hj0PdWwd+2Q/H3w06VCx3mJ?=
 =?us-ascii?Q?S+AWJcIYcXDmRfhrg3XQDEKu1vBQSuftXnyNyz8shG2gnDP4n/iFmfbroR7T?=
 =?us-ascii?Q?dpR7wzsujaeI8Ic3L3njX0zRghURm0Td8BH69LJuexUFwUH2sMYm2kqRLl6a?=
 =?us-ascii?Q?WIMEXJtiVCfxJsyf/iNGMQ2E0KcQRlcZeETszQcikGWzMKIKx4mkt9TQtuDa?=
 =?us-ascii?Q?nwcNjjek+kD5OEuMRIh0DmY68oPDjiAyfvr8o72biiX6pVbOZzKpFromD0Ug?=
 =?us-ascii?Q?vISJWxqxdBqO1nvwAECAdLvdhH7WXwUMflSP0n1BRpcla7w/af7RSR4wcgLj?=
 =?us-ascii?Q?f16OF+Gr9/qxCCYpM0Hq9OvaOA8weXokAz57LLqH1nUr/dUfU4dxQsNXEVw3?=
 =?us-ascii?Q?7Szb/Rshh55tWzRpjsvuqb6abObe5P85UpWBfVlFwVe0OuV/+PdbtMuVvLu2?=
 =?us-ascii?Q?ukYr1xFW2I+p1aD+Hc4WbMqmRNvEGL+iK/HNh6aeaY54o4yDz/Ir9sj8LPCh?=
 =?us-ascii?Q?M4pkNnkSk5OttTpsN1m2DAtQWdNhCYVkSzvimUBeU5r4zvk/KT2vCTJQ+Nnv?=
 =?us-ascii?Q?HHYIAyM3S6+Em9UYtHebrwUBtcYQqRteTmufJknTRCLTnSmaZaiPkC6kExxH?=
 =?us-ascii?Q?aLPcDJL9H+mYHbXHxmadXWlVVC86dPqUrSyCEIafSylusTgAbAcH7aoEjW7B?=
 =?us-ascii?Q?dJYz4P1Cpy60KOzawb33eTdx7HftQUnONHPmF8RrawMGE3rTr73VbIct0BVj?=
 =?us-ascii?Q?jitun/RnALmEzaw9LNAgCuuxNdlUq1jLIyVzbcfjYTlPw+G9RssvR8R9Qqjp?=
 =?us-ascii?Q?ZEZrmDrPn8sIfHdm5I5QDNNww4gMRQjPq4ZjgINKWLqfNKeSunX/6LjYDon1?=
 =?us-ascii?Q?4d8XeeX/QWbwWYHMmxfrHStfrNMCwbxhdfDWV9nJ+s24+v/tDbONjhoLyQqa?=
 =?us-ascii?Q?/AIL6lmbn0WF/C9ghnyhCiRtpOWsF05ByA+v6XHRlANw3Ctwz0E/Wxg1GRxq?=
 =?us-ascii?Q?JM7O/s9zi+ZrbH5B6b48F2e47MmufdSYemywY8nFXwRIWx2zTBg5ew=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3115.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WAzB9u3yaF4Kz27EIz42rUJS74JAHdB5x8pXDyw483/9kpomzUObH/8M24Qw?=
 =?us-ascii?Q?N8uOZgy4j51HG8pXzcy3yNAsnhsWR/QW2uY1kX4lxO0LxDzaaNlt5ij/A9eZ?=
 =?us-ascii?Q?6j+RBoZNnb2+P7XIsvFrF+8qBgD6+UoJ8bdUr4i9V59q/sdazISOFW6dZB8w?=
 =?us-ascii?Q?dTB0qfzzl4eNlaeu7ioPtnCyWIdjxTY9kODLYVEaQqGp6d2u8+uWN3wvjKHW?=
 =?us-ascii?Q?trtTuzM709beS76cdYqIsTJyO1BvsgM+3otnZPb3lzIG9ae36oIXQkunirIq?=
 =?us-ascii?Q?mDsa3wxKQw6UzwIvHxzsUuSslPspkofPlnGASeHS+tmpE1R5tvSVFiilBGjG?=
 =?us-ascii?Q?6U4B8SwuyQmkSL8T1N9drFgnQpRfXb8gA45S+GtI0e1B3NXJm+RVVIpwEJrT?=
 =?us-ascii?Q?iMYKB417FbOib8nmz9TXcOXEXkwPjv/gXwI7OwK3Ie7ndXw09OAKZ5g6s4RG?=
 =?us-ascii?Q?H7Gspok1mxdrDltiEE6Nyc1Wtu8HahQtbUwrBSqnhRmZ8VFw6nLtxSK08Rcy?=
 =?us-ascii?Q?NA9CF0XTFRT32U32aoPmzTmrddBD8lsALVYXgv9yA81kiQZNmAeeNXQ8vhng?=
 =?us-ascii?Q?hOm6LL3zjNz7vFL4A+XwTOzoPb6vcepL6TAtkFbk40IqaBAck7Z9yintT1Bj?=
 =?us-ascii?Q?/P/LhfoqNNPKG6rWxD66LkVthWIY4uDEAf6OUUkRaZrb0xSuxVZn51ALS3Ui?=
 =?us-ascii?Q?k7yYNWH7pu5HL88Jh6vz3EX27MWrmQ+GLBaYrIR7wmuOHMzMbCWTeLnhktse?=
 =?us-ascii?Q?Ql4+sv2JOAriKRxh2lUPczlWvn1bA9MzM49cXVJvtGYGiXGBKLA1O9quUC8R?=
 =?us-ascii?Q?qOaQUVzrKwda86z1QzzheDXpkBoqRJMoHnlMryJpJqFBfwBehqNQm2NenLVF?=
 =?us-ascii?Q?elnZ3sm4ku45/KElvSSD08fqhwaQjwWzkaycryqn7zMCSArJk+RDdReMsCo8?=
 =?us-ascii?Q?pmXCLERq3IiCVRAF5kM3E2zF83oeQSWXYPJpHox8lZusY68eNKoipN8tT6am?=
 =?us-ascii?Q?w6Fkiat+oqDxS0ub0rW4+qSto8Gttt/BPIxOM1FwSA3XERpBPHgNR9TaIFGs?=
 =?us-ascii?Q?9/+SbI2+InS8y6BVOE6FeoVPybc/K9QD1iHIUnTNs35FC9H/nhDFHbK/Wjog?=
 =?us-ascii?Q?P8r5rzxyyaBKE6XhyidS/LFnl2DMpbFdO4WQT6lt3iOJPYrQ3Pr8sV1iWqjR?=
 =?us-ascii?Q?1hVvhGO61UIRrFFhhzto9j37Gd9jTW0i9dIN4L/KbECtKuswuqLpvtFBoI4W?=
 =?us-ascii?Q?mCNcdMT5ba/AmOim09ppjTAccK1R1Xu+tSuaKVULWV5W+3eGMR88wmkevYss?=
 =?us-ascii?Q?ghRgX+nHWCPddBYBRi6IerfQM2krjs2tDF7+WcjYE0JKsIESDPyQQJ5LRPoU?=
 =?us-ascii?Q?UhLOhtwkDx+PiFbM6ikWWbnRoOtFopo4VhcFMHh9HqWn51yKJ5GAS/Sb9Dzi?=
 =?us-ascii?Q?T3N74QMFWjd1eh7wjR6Aom/jV+A2+UidM5u+o2GF89SbJ5v/xRoHTXtXh6R4?=
 =?us-ascii?Q?MsiQeAieQxZsZHTNFTiWmQZgBJX0C1qcITXS+XhnprAPHzpj9Evacm9C9AuC?=
 =?us-ascii?Q?xyrTMMNoFyQfhi8N9L9xLvHa8t/hVL8JVjwf2SsY?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR21MB3115.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbee34d-de15-4af1-db3b-08ddb9f2185f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 05:25:59.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cih7eXr0XakTaCjY73d714X6h8WerlJzRPk9ulkd16blJqAWRplHFT7Vx4Q9a2mQvttNnQNyoYtkHYuVcm1Rrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3714

> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, July 2, 2025 10:14 PM
> > ...
> > I guess this requested commit doesn't really need to go into 5.4.y,
> > which I suppose isn't used widely any more. I listed it just for
> > completeness :-)
>=20
> If you really want it in 5.4.y, please provide a version that doesn't
> add the warning :)

I don't really want it in 5.4.y. It's good enough to me for the commit
to be in 5.15 and 5.10.

Thanks,
Dexuan

