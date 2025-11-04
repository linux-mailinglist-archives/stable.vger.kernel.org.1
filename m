Return-Path: <stable+bounces-192425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C6C32077
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 17:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CF218C3872
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 16:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1490032ED52;
	Tue,  4 Nov 2025 16:22:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020133.outbound.protection.outlook.com [52.101.169.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C38330D2F
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273370; cv=fail; b=NkB4NDbfbqVSK4GaDgDNhIWh3+xtfPxxhD9l+xSL4hOJCx3qrs3f+XPcwBvlu/5mb12Q34ihSmijgTSkoLy0wtkxWRONX/g37fcAdcjphqkk+8p9XfwHg1lJK2ruAQValUmMvxuyokUjdBW4/I2FOwgDGJ9pJX4uZtVWgqoUCdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273370; c=relaxed/simple;
	bh=OPN98MJH6CPMU9EqUn2rAbAJ5jr92JUNPwjMefuesws=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KXd/1Dh/LpDeV4ZSExGc5OkV4kekvuFg2LXCZVdF9BvTUx5qU6AzZtuxMdvXFrvgYrGazazkIy37aJ5rnhNR0YMEswb+ZqflZFr0Kjzihj0TRmKPAxQQXD5QYC/5T11QXDspxHkPVh40CIKba7hgEkp0VUqxy0DDpHvgJWIrBNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jumptec.com; spf=fail smtp.mailfrom=jumptec.com; arc=fail smtp.client-ip=52.101.169.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=jumptec.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jumptec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUXtSJyVwStLABrA7wlBiZaXBChuQVdydzFrdorgkB3oPg7y1g4+zUx85BmQ228neYIZJIYdu0RaFKw0HRSYjVo7+BohwWVFcI0sug5euxdz/qeixkxRpE/YhiqTwHSllBv8eEysDNB1zrKZc3j7APRflHn4bcKXI+011v86CG50qJgdmm5MyAV/WCB5jTn/rNdIPRHe9mVy71rAh3UrnRPROAqBkJSgFi3Szi6rmpkrI1rCJlqy2mNpxrU3olnzmT2xNGTYeKw/GFlG11/LlkLTl+Ctqt7fgT58u8ReABCSOQRQlCCLrFEk8zGH55Fd2KsQG6W7wCoH4Kw8kuxKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF9EmhoKmFH+in6LA9MxQO6O9P6dtfdtBh3GPHvB/8A=;
 b=VgJgPI8YCIJ+TeZl5CZzrLcDBn66H75lbEltBR/J63mYtXzrm7MYO/tkzZ4SL/EFj9xzxb0GfOyBoiBxpHDEJQ4NPSb8ansvVeEAkiNvuq0FBzyvVwRwGy3qqChUCB3xdvRH/vl3LG6mYavIKTllXYqRh8xlzD9x/jpAXfPAA4BEFmiJ9osYNz22wEPxnxpb4ze2ExLYxSt4eRR11m8+GrCB1TL28lwAN+6JHd/B4cULRUmqCs6mY8Ucf16sKCgpiy5E59I0Vbz2Yh1rzxggckoD5qzkLvpKeOgkf12s7RSQxMULQDyVPWZi6pyryF5fQ0MnuM9acStISgQStHB74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jumptec.com; dmarc=pass action=none header.from=jumptec.com;
 dkim=pass header.d=jumptec.com; arc=none
Received: from BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3e::10)
 by FR3P281MB2249.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:30::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 16:22:45 +0000
Received: from BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3455:bc1e:5194:cc17]) by BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3455:bc1e:5194:cc17%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 16:22:45 +0000
From: Michael Brunner <Michael.Brunner@jumptec.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: For stable: mfd: kempld-core: Don't replace resources provided by
 ACPI
Thread-Topic: For stable: mfd: kempld-core: Don't replace resources provided
 by ACPI
Thread-Index: AQHcTadARIurlDDFTUa6zuXpUa080g==
Date: Tue, 4 Nov 2025 16:22:45 +0000
Message-ID: <8c43f27156cae212537b8854d1efa8b78a0f2643.camel@jumptec.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jumptec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2787:EE_|FR3P281MB2249:EE_
x-ms-office365-filtering-correlation-id: befc6e9a-e3e2-49e3-3657-08de1bbe6303
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-15?Q?O+ph72GE7XIwbLwI+uh3V6wqfo+ajNKiLBDDO/WnQw8XgWqtJftO7Yahy?=
 =?iso-8859-15?Q?uqYS3qo9pEGrmorWdxh4AL9pdx9wdZcjiLIqYLUy19qCIrmLxuZbjgG6k?=
 =?iso-8859-15?Q?yLAv+t7p3a03EPqJCG3SOx/kilS6mKBIiaBuu5bHKQe+IQcrnaed4DU1z?=
 =?iso-8859-15?Q?ZeucCi85SecWsttG/p95Wrt8+I01V4H4CuL5VdHM/3LoMW9FdMLlk0t4y?=
 =?iso-8859-15?Q?zLETyjZMVSgbOoLuYvsp0CH0YLk6CUwi/vP9UJGZMWIMWXBlc3cgojNOR?=
 =?iso-8859-15?Q?IhPdq/kfQ4wDMf66tR9U9XMkwha2l2DxRM+tu6N0/rJrAcAdpNR90QHCT?=
 =?iso-8859-15?Q?K8wqjueazDEWz4vAKMOBzmSXNF2d8fkpIBfDiEI5vLZP9nbeIMdzup+dr?=
 =?iso-8859-15?Q?TVmGEbHON3ehqg12+NGflWBOQ/xW7Rfhom57IbCggOngF9dcBjAToVT8w?=
 =?iso-8859-15?Q?ceXr670OMQYZt6eexTzm0LSBlT+DNnBaQXW0DKadvcri5jN1414BAgMDP?=
 =?iso-8859-15?Q?oIeCGU5MxfwHe7qU6LQqTnzrpmS5/6C8kjRB6l0r1v7wqYhAXwZbZ+p+b?=
 =?iso-8859-15?Q?G/dBHDDr5hSB5LkEEV5cYow7R6vWnarS/Kpz4pts048yrsFIf3diyE6v4?=
 =?iso-8859-15?Q?73GCA4pKk2Dl7PNo2Nj+c0eLrHa94IoqDeqm7Yu9MBESNli69sgfGZcZi?=
 =?iso-8859-15?Q?YMiGFSmNpMNuBNrYx5BftGXWV+pqbF9kbCGy8UYiuI/J6Cl4vqw30rems?=
 =?iso-8859-15?Q?IEeaFSA6nDu6igeiyKFnysjRnOcD3XaXfY60o/zpRKcfcTvnTcOciT5/3?=
 =?iso-8859-15?Q?QPNwFEjDb+96LiGCCIOYO33N93bUmXPgPMWpiDndJI0jF8vUr6U/Kf4OD?=
 =?iso-8859-15?Q?+shqHCbrrvkBM9owu9gNrR/OPkwzb69gULFDnzpY+bGncPggQuE1Wfhea?=
 =?iso-8859-15?Q?lGOTB9kWGFyBQSPGjwdGXXkv3VP3eu0oS9X2Sx0Cp5ZqbIUXpiVevSKJg?=
 =?iso-8859-15?Q?WaQs5s3mFvh7TCXoXQOuxKXV63wEXf/tYvKWwX15QO8NaBSJ07PFp1ujS?=
 =?iso-8859-15?Q?pqWcgPb5LtZpuyHTAC9w2hWYh+LkOLQEDij2hyWRXmoDzsZCxFbrW16eo?=
 =?iso-8859-15?Q?ws7UajtvxOsVCSp6/OnO+1HmQHdVXd05/ymrKp5gLnk3XWPZKO1U6s69/?=
 =?iso-8859-15?Q?IjKrKnu2ag7PHcHzpXEzMGpGch7UqpHS2AlLlDBel2wBEp6c1c58wI2q/?=
 =?iso-8859-15?Q?SKlDuznngQNRKFlvJvLfg16fwAp4bWulae7SUo4jnYA+ZMHCoQQJj8gL6?=
 =?iso-8859-15?Q?Tp8gnaFRC5bORcqBHCyitu5wJCgK6pCPnDVZ/D8O//EpEltf3Au5+7r4l?=
 =?iso-8859-15?Q?9Vu036hNJmDTh9DKgv3yIcSmj/B8osKAOAtFDEGO0rxiMfKP7I9tglz/3?=
 =?iso-8859-15?Q?UwjLRe4UdW0iuoXf7V846zcMahTeJLe36Ipn/1GDNnkWlxVVILovmmDgp?=
 =?iso-8859-15?Q?H8pc2PZyBXNBSepWd80ebNYKREbUNJdYmPiGq4U58GAOVaJjKkKHhhKro?=
 =?iso-8859-15?Q?t/EjoXBk5nnHkBYxAOhTZnT0O+LAFxxnatNAsv3MAniObcF4sgpJc7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-15?Q?qBHDc3FtlhGbQaZWb8lx4u9u1e0u5SmHhogHyBfKVV3rOOHp9gJVYo+Lu?=
 =?iso-8859-15?Q?9y1c9lhBZT2CssB+kYjVUlkhi0TNkFQArZsOgG57ZHUqKKZz08y5pFyOW?=
 =?iso-8859-15?Q?0cdsBIjB7dXAD8sOZkS1pU6y7VWvZbDD2FLR9BXKvmLBd+hYevXXzaEej?=
 =?iso-8859-15?Q?QedaSWd0Xwc5ulPokDhqUcLnwUVwbYEfKn92JZZ5KNiRdww7EWhn4Dq9e?=
 =?iso-8859-15?Q?NcYRrjy0bNEI0rqFjIpWaUms6xgzNzG8CB0rCHDId5DrxcD/73ou+mnSt?=
 =?iso-8859-15?Q?KGVZt4ylL5IxK/XjoH+mr0qCaWvAGmgM6niP6hteO802KS8JW1hoEykiy?=
 =?iso-8859-15?Q?OxZytooYZuL9rwlbq9PUap+AGhna470e9tUHLFVDjs2ndxSW/4A5UzZ1D?=
 =?iso-8859-15?Q?bKIjtyJK27iPsJQ6WSdd7J8/qaHorZdebMtHph4OsRp/qbRho8dDEyIBY?=
 =?iso-8859-15?Q?tvI6asm5JfNgze1gOIFHpwwWkMwK1wiE1JWj3SXDaxed5jkc3D2Rj5jlN?=
 =?iso-8859-15?Q?SmZghmkoqX34UGhJRp9XqpQc25Qu7orFXQlEPTA7QCDU5n7EMt/SNH/IB?=
 =?iso-8859-15?Q?i1V09tZSkQvPpLQXDsacmdfbFb0ZQahwon5G0I9HQRREEeu0X95st9v2c?=
 =?iso-8859-15?Q?wkmzWcWlWsh2SJJeuLhCMdb7yWeopyKq/cllPXXV+ZGChe5UvYAJrJMU5?=
 =?iso-8859-15?Q?PB7hSl0smFgNXYWuUFVRGuKQqPWXocqAeOGGzpTkUlN5wKLK4K1lkAOhD?=
 =?iso-8859-15?Q?M0oBjWc0ZeKyIrlwnSRE0wgZOowO8w6HgziDh+NxUl8H0zOxBYOlVhcrC?=
 =?iso-8859-15?Q?XqxKDo6CiET6nVmMBxb4rkc45NowlvHReBuO2iolQgiBK8XG/3jrjjTls?=
 =?iso-8859-15?Q?cQOeF3jn3rJA8SdtLHqtpYg6HWZuI0jzi0exUxLRGY27DQdKApUtmx+5e?=
 =?iso-8859-15?Q?0H9qCoe/KKtcNOs1iGoUtc4XHSRAnCoYhtLOtKy7H3uzWzW+ulMJivpcb?=
 =?iso-8859-15?Q?NAlOso4+vU5fyAh7rPf13CXNQG7lkrmSE7UP3z73Ta95xjmM83PoRw4d0?=
 =?iso-8859-15?Q?w954wtz/XvvEcarMySCxMiU89sYrXhb8adlxgLqJQ8cMXL8FYkF/8E9zW?=
 =?iso-8859-15?Q?uyrduzYY45mV8GwFbsnN1WFV9bF7imlfy/PGvbiErvO/1B7Md851LO+GP?=
 =?iso-8859-15?Q?svNo0xu8QB2YscgBY1o4+e/WGMZtnkzC+RrdBqsyAJH4fZGv5RmfdIf3u?=
 =?iso-8859-15?Q?lh2N/MFZqZJj92nte5+B0lbanDvB7uWgAC95G0Ra/qf6T5cBmXs27xFTO?=
 =?iso-8859-15?Q?DGZkkHNqu96nAJcL48Xo8lDiUST1AAXqpqF2BMNw7OSOzxwclQMZRD0cM?=
 =?iso-8859-15?Q?+lkdqQR1V6bUS56PbqRhS7p3sSj2fl9+Heyz2xcZ6fmchmACZWMas9tgO?=
 =?iso-8859-15?Q?58GBhGfLxCIT64rU8GL3+YaVcohJnONsF0LC6Tk44nYfz5xdYWfkIwdCs?=
 =?iso-8859-15?Q?W2yyP9RLmcu+MhI1sCcTHPyKLyp3rRFQpGbqEt3uZpejJOzJg7R0fuC+y?=
 =?iso-8859-15?Q?VizGMkOJcbgZUUT5HKFeYD++o/0EijPuHdV9aGDdkL1TggFdpmuirtl1j?=
 =?iso-8859-15?Q?Q7645MGc0omFtbHv7f0Z5y3XE52ry3c7GRvoLZKBAWupNPg/ntFk+e+V3?=
 =?iso-8859-15?Q?+mr9HlZUMRRYfKG4K4NtLl3e/WLtJUFKrjUfm+z48yBgCnc=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <B9CECFD161316044B59320409CFAC206@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: jumptec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2787.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: befc6e9a-e3e2-49e3-3657-08de1bbe6303
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 16:22:45.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: db368334-1f76-4002-a68f-6dc6e8b50cd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHTjdh51W8zWNqigcZm+oGxXtzNcJzpAYwIy2eMBtHDTu/lYTogYY5lHZAJZEkm6tqNAThjzSSOzLcQjAu1rCIMtEkimoZx2EwA5dQXsLbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2249

Mainline patch information (included since v6.9):
mfd: kempld-core: Don't replace resources provided by ACPI
commit 87bfb48f34192eb29a0a644e7a82fb7ab507cbd8

This patch fixes an issue with the ACPI handling of the kempld driver,
that can lead to issues ranging from messed up /proc/ioports resource
listing up to non booting systems.
It is already included mainline since v6.9, but nevertheless it would
also apply to earlier kernels starting with v5.10.
Please consider to add it to the supported LTS trees in the affected
range (v5.10, v5.15, v6.1 and v6.6).

Many thanks,
  Michael Brunner




