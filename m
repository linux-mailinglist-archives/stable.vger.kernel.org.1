Return-Path: <stable+bounces-76053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFA3977C4E
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F0B1C2451B
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01A175D45;
	Fri, 13 Sep 2024 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="B4u4418t";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qOOYeU3r"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835F1B985B;
	Fri, 13 Sep 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220332; cv=fail; b=g4j+EtMamJR//q5dl9+axY9gGB/ayG6BGe7nYasHlkSFN/Mhq8zPqWUOqBG/VzWLP6JLOqho8Nc9nMDHOYeIIkuPF7U6YlpDH4mIGaIs4k1tfPSkmegnjhdrdW6PNmI7sMTnIXLMpcS19tdAxkFm4mwVfVmw89b3gP0zTRPt0pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220332; c=relaxed/simple;
	bh=9J1LCB++bJAhup14OLt5eaGokWRxsS1q4lvARZ+nBI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sVuaKrRXM4x/40rh9l/5jPjBiz5+6pFpGT6K1eJjSFGNzLe/G3dPEVKNE1GhjaRaJNrZyGTa2S/ogXKxRHqRbf49qH43UO7E2JWOtFskdZl9duBfSgFL47UyjBXs8nWzjDzRKDvRC+4E+BvVsP5pHu7ozcfQwPS7HLo34L9q04k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=B4u4418t; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=qOOYeU3r; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CKaSgx023965;
	Fri, 13 Sep 2024 01:19:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Vxc3XbA+2jRc9gzczlbx9Y0hwfitSbRc30AjRNH8krc=; b=B4u4418t9NyX
	L19SHgIPT/QrJlBQEmj6d+YejutemLvYWGEnJgxkcIBDxrD/8c0owPl82ZLMPt/f
	fzxo+ff5/QnM/vQyDOub/19ThlWBVk/iuK0MTsqr4OpzyfmWefP++CLc3B6qoPqu
	07Iq7MLdfyEBnMwHj5grxvus4L2A2/H3A0ny0QrP8dhc5DrtZNFcg85onyIupZze
	+xutoaAYDZW5nsYgO+ZXmx2Z/Fv+Vs9K4+HmrSdbnF7uQz1pK4sOpeNX9CYjwUwG
	epwMPRJdHJjPHoAeQUs9kX1Z+io0P/Z6aVa9npiqrjHYBiueX4BFchHCMgUHbb/F
	p4O6SGimQg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 41k571byhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 01:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTYVi1QlxmGwaxjdRZbcXGCxWw7US9GqSyskogRpj8vFDFcOLCm/cfxmY4m3bKO2CAdJQYlITwXHn/npxPGr9xDMJX6fNepOVbN9KAB7LIsGHLiCLMT/ZljI2M4lap3K48joggBCZulWmXlnH2UqPTQTPUiml66yL7b+UwZXbDyJil0DRgOaR4Z/PbVjfW41y3xcvULzvbp84qN+n9yJkwOC7cI+IXzSglVBK1JgtRZ+5wMXwO85WN4ADFjGKZa51e7siTSGhKq4TYqIJGqFf0BNXBNrozgS6L0ghX/OZN2DnweJcUZ9V7c71gR+vLytVanI1C1g3AZqSL+nG2h7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vxc3XbA+2jRc9gzczlbx9Y0hwfitSbRc30AjRNH8krc=;
 b=tLbpoAPFFXhzGW3CenXwG0qijSqOQ2FILjjDI4d51/14DXp9Qgc2k42VMA8GCz3Hs+Yw2Tf9Z0rt3xK1omoWxaCIz2qEwbVyc9CJLHQPUCJ9d3z1HYilIuZj+5H0zmpk8gU69Fac/SmAJrFpSvxNBCtJtd3/m1GRUmGqUMo8WFenNyw3wTcAGRcb9iy6x+KbrYprNbFlSbO4iDKrpZvvdGRq2/zqp38cUuXWAECGwSzhSOBPJebsI/0t83sEs/UaaK5IaHC6321J7PduZJLvj0OR1ilfov68JwexBmDDwRcRHY1dPUu4moS5Wewy7k0asfmGnVnYYd3hIUJECK5Hhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxc3XbA+2jRc9gzczlbx9Y0hwfitSbRc30AjRNH8krc=;
 b=qOOYeU3recDSitORp9WfcplrziNUSPTv3BFNk53Qrts4dB4M5JswhjugLvMBVE1kCX1AH13D8gYyuFR2aTs/W4omb5sXHUdO5Yl0o6G7iKQVGBsV2QgICtwgKl3g5woMHld4iodg9o+/6KyXB4qy/jb4G/Ym5VOrtcMPFUOPn64=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BN0PR07MB8277.namprd07.prod.outlook.com (2603:10b6:408:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 08:19:28 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%4]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 08:19:27 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] usb: xhci: fix loss of data on Cadence xHC
Thread-Topic: [PATCH] usb: xhci: fix loss of data on Cadence xHC
Thread-Index: AQHa/2D1v7Tx38XDdkOfqL/qNaUw7bJIw3GAgAAB0kCAC5PQAIABEb3A
Date: Fri, 13 Sep 2024 08:19:27 +0000
Message-ID:
 <PH7PR07MB9538278A720F77E5B3653541DD652@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20240905065716.305332-1-pawell@cadence.com>
 <PH7PR07MB9538584F3C0AD11119403F11DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <PH7PR07MB9538734A9BC4FA56E34998EEDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <ZuMOfHp9j_6_3-WC@surfacebook.localdomain>
In-Reply-To: <ZuMOfHp9j_6_3-WC@surfacebook.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 PG1ldGE+PGF0IGFpPSIwIiBubT0iYm9keS50eHQiIHA9ImM6XHVzZXJzXHBhd2VsbFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWUzM2I2NDI3LTcxYTgtMTFlZi1hOGI3LTYwYTVlMjViOTZhM1xhbWUtdGVzdFxlMzNiNjQyOS03MWE4LTExZWYtYThiNy02MGE1ZTI1Yjk2YTNib2R5LnR4dCIgc3o9IjE0ODIiIHQ9IjEzMzcwNjg5MTY2MjY5NTgyMCIgaD0iSTVoMFNCUitoUWFjQWhzWThNS0k5SHIxZjU4PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BN0PR07MB8277:EE_
x-ms-office365-filtering-correlation-id: 3a63e60d-8250-4eda-0ebb-08dcd3ccc8ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DdR9Xx3Gmr+KBTTe5J6W1CuQF/ncrKUvJEwoDOsk132i0N5Nu8R/JYKO2DD5?=
 =?us-ascii?Q?zEBAmeEwBnXP89u/NQot/2pKZ/rP4HEnyBnb8Gm0AP7Uyz5KPa4zKFxKArZs?=
 =?us-ascii?Q?HNjMuPPlQIYFNHeoEbXPie9WW42zkOzjO5GOf2XA0DNSJzxQPKIeGL6Kba+M?=
 =?us-ascii?Q?G9d51Mb43QQ2p5aeqLDMjaIudbuIkk4bi7Fw3BqE6b7oA3z873vP2W2O6mVp?=
 =?us-ascii?Q?25hQ7LAxhQ3noKb4OwRu11WHk3ByoLyG4LewMZ+/peDnK8su7UECAFeCJu0x?=
 =?us-ascii?Q?ALh+ktdo3hqOX5nB59udExbKD5Jlq6XqIiPWLnmomPZGEi4phySOx1ydi/EF?=
 =?us-ascii?Q?5oFCPXIBRRgNXUVp+vqXGJEpQ30BwMVrtI9vqr6ntm16pj0NAotj+gAQPypd?=
 =?us-ascii?Q?gHN/ltP+KEsvPXIJGrAkbDAHiX68VcH5YukHGig/NzNJHWN/kNwoIYSNwUuL?=
 =?us-ascii?Q?r4+75arV9l0lY2fEyHv8wpbMaPpkeEDJbZusO7kvZ58BMK4TVnBmM5vhZ4Rz?=
 =?us-ascii?Q?nN5mA+LQUEBNJrF+tNdDhv77LUK0Nx8y07XZ+UQKg19eL5y190ubfxws4C7S?=
 =?us-ascii?Q?Q617c5rB1HuC5rKggwlz1KYUP0yMjRwWavN6pG2OUp3AF0IRfBYvTbYq8jTr?=
 =?us-ascii?Q?XfblAJ0cbJT3R+kEGP/8m5OLhLvB50DnVjoYpIzqvqJFwPnrtL63/DgrKb0L?=
 =?us-ascii?Q?H0GhCctTg31m5lmZffTuGBxwWmWSHMXPp0fHZT+I8RbpayQWuaWTYuO7WI37?=
 =?us-ascii?Q?nz7kMDTGNKTJR4EUZy0lZramuq82YzXoQLb4Ttw2yWGtlX4kdArcHn80X+jS?=
 =?us-ascii?Q?AKHxbuVAYETMpGqr/pgk/fE4ACq7fdNovAzBhdJaV89lCo9eQ5TiesUmBa3I?=
 =?us-ascii?Q?lAU+C06xbckPrbe0jAr7oVmjQp+TD0gpCHm0je0Vpk/+tjBt0HxZusUDZl55?=
 =?us-ascii?Q?nzH+KEDBuvai10Mw6edLJwwvVIGVuXnMYnt3/U8c3SGUE1lqiyMfZfNaFXzA?=
 =?us-ascii?Q?Za6RgP1oAqEaFJClMztbah/MBZeAN2GcaxM7DR5A7QvPobXWR+qBfaisfV/e?=
 =?us-ascii?Q?tg4KlboyjLFsBSXz4yMDtlsqOxULc0zyGUUOresbTlKjlbvqTku91l72emn7?=
 =?us-ascii?Q?CxeWNwzm7U3qYkfDf50ZyTkj6yA9ADGs9fH5DHg3uMGURaDnJMEOpRSRoKYN?=
 =?us-ascii?Q?p10o0BtbkZyCds8PhZPPN3GMrdmMzdVwiyuFh3L4qlTIdwj5CeVwjUcakZ8O?=
 =?us-ascii?Q?I/wRlmrXG0MOUYDfgpgmoV8UsY6yVEfzJ2ocLebeutcOrwHykcPlm9k9s85V?=
 =?us-ascii?Q?1rOVwzaUkE0GANJUKfoGHmqF2FOPB73n5oIlvLUkotKDenRQLHHnadr88xyZ?=
 =?us-ascii?Q?E2CE7XMZYqpCA+EJZVi7AS4tytLb8b0C/QQ6eOc5XO50Nl0aFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?q0jOkrgXwr3K67pe7wZnlE2vWGbcsy3qc1H0x2BM9PhNMJ20g14yJBE3MCbG?=
 =?us-ascii?Q?Y3j5sOGsTsFWMx49vMbk/FszK8i0PX0rio/ADoScJ9TJBSXT4jL/cx6ebE/m?=
 =?us-ascii?Q?lIRvxueViN0lG/MI3UcqenJ2lkw1wixzp9BR5L3mODGU9w1ww4D3ep97w9wv?=
 =?us-ascii?Q?BGSxdgcIym+OkW+th7Qs6LgOz0/f0IsSjNLZlTlPT78AgtnWBtc1fxMGdqTg?=
 =?us-ascii?Q?jKEYoC+qRDi9j0LjFN7AhcO3mQiNGc0pA5Da+S/vqnJgV/wpMJ6h1DfbFKZ+?=
 =?us-ascii?Q?XX0Ameuk2tOTah6Zw3JRcrOBcin/ygu/5gFFijNNeVTAUS0xeT5iIobZCcF0?=
 =?us-ascii?Q?TDnvmJgkBkTwuX2GFsIWADI6BCSKFYZ/9erbqEZtitCLhOdquzQjBTsBVsEZ?=
 =?us-ascii?Q?n0CpXByrKjJB8Bs48R546GUQVXFu2q6ff0W3mmGhglGJWBgCYJev3Ib1Ngsx?=
 =?us-ascii?Q?BR3tFikqB8c9eL8vsUiGeIfmY0rmtNagjULAl+XAkVNbki5YFf4KXoI0FcjE?=
 =?us-ascii?Q?fBMMfNJ3X0AD85jSnP4pCfenprIT05DUDakpnCNr9Grh3qYHoxfkHZFBLqN8?=
 =?us-ascii?Q?eKnw9WnEGdmcxOL1XuW6J9ll3brmyJz1yetXhDIUETrMZeYJuIGAQkmH6oOe?=
 =?us-ascii?Q?TjAUUMopS+8+daZy9ogwQFV0bv5FWqAN1loTXvv11UlytmH0Cr55JS7mkGJB?=
 =?us-ascii?Q?uo/BVnB3dp4PhX4sOxSTQ5ygZttamSIWrEbCUp8vn1+4fjtvbQBPYm8boAIZ?=
 =?us-ascii?Q?ERvUm0DrbMZH92scDcFhxpDWpENUvA+0pNR9YPO4djlizhmx3fzRZL1UBZUe?=
 =?us-ascii?Q?UmUjNzLZCRkQIFfezysxFHGSzrc4BAR+VwTB3RuECFaCvPaC4UnKyyGY325n?=
 =?us-ascii?Q?pzPCT5p1AFuCBuhIiOPTICNaEWXFgRGJry7QKpkFYFKJL2UjM1S9t4k/UzZ4?=
 =?us-ascii?Q?QcL151lfwPCLIYw+LsOTc9vkYVKVapTkzONVWcPw9hMUELtQ9ZR7EBnNQqfp?=
 =?us-ascii?Q?ovJFMaETEwDlt2FKgXdoVvlpG6JJn22KVmsU4hdjLiopG/HIkt0VVPeFrcxV?=
 =?us-ascii?Q?eMrLyVOowSsqwb1EA/YdI3DAv9sHkzVbmA7ZEs2yPE88s3NKYV79sAUyTYVt?=
 =?us-ascii?Q?TXO7nFP7oqZ0lItam0PHSOjdL3uLdozgcMcNMju5CCRpDDSiXslXSckUKXKQ?=
 =?us-ascii?Q?R8N4ArEuXtalK6Jpnt9IRpKzI8lmo2XKoGTIZXa183mtqnqI70nYGzQLyVqM?=
 =?us-ascii?Q?nwOK0YONsiV6+6jKUq2tNki2hfGVXhgXijOp9n4bZZfPVEDAhodwzxlZFyTj?=
 =?us-ascii?Q?eNldERLvY/L6WWvBks2fq/quJfsdpsoD4YfqKmMDMX3BQvfwiWFDbLGiNuRB?=
 =?us-ascii?Q?SlViIIhM5csKk8keENw5mniNA1+tZJzKWTWNFAa7f+/GD57kFzp2t2F5kB64?=
 =?us-ascii?Q?qcwGzQePgIVpH3p3MXxgbBc6yGoyHPB9laLZItSnQS3BbNxQ8x3Hm8y9uJKX?=
 =?us-ascii?Q?dSerUfFZDRbMCJNuCod3VPcLwQm1FXMHkBwKV9OSJEbGUkMPsyDswiFs4LfX?=
 =?us-ascii?Q?4GQzRGm/0HzjTC1b7mOhROCNWe/fFIq19WvywMA1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a63e60d-8250-4eda-0ebb-08dcd3ccc8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 08:19:27.7282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmylaLoAdOBSAUYChLw3M2LTXCiKn8Yie/AEvWSneYF/KdBLSjSRR45ekvb/k1OsOTZUif9lWi3iOYzceZwuoY1QT9MF3DWgaBVE4PUk+Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8277
X-Proofpoint-ORIG-GUID: OHPSlma3jH7BEAYgxHeDcGIAi2jg6PhB
X-Proofpoint-GUID: OHPSlma3jH7BEAYgxHeDcGIAi2jg6PhB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 clxscore=1011 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=402
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409130057

>
>Thu, Sep 05, 2024 at 07:06:48AM +0000, Pawel Laszczak kirjoitti:
>> Please ignore this patch. I send it again with correct version in subjec=
t.
>
>It seems it's in Mathias' tree, never the less, see also below.
>
>...
>
>> >+#define PCI_DEVICE_ID_CADENCE				0x17CD
>
>First of all this is misleadig as this is VENDOR_ID, second, there is offi=
cial ID
>constant for Cadence in pci_ids.h.
>
>#define PCI_VENDOR_ID_CDNS              0x17cd

You have right. I assume that I should send the next patch v4.
I'm going to leave PCI_DEVICE_ID_CADENCE_SSP. I hope that will not be probl=
em. =20

>
>--
>With Best Regards,
>Andy Shevchenko
>


