Return-Path: <stable+bounces-98856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F078D9E5E57
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 19:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90F216B8B8
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF0229B28;
	Thu,  5 Dec 2024 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BrG91Svc"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305111917F4;
	Thu,  5 Dec 2024 18:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423848; cv=fail; b=JyAlVvhzzCDKIO8/siSz9xICBkuykwEPQFamF5SIWXci54xcjMGm30Undr06x1a/T3/SNHJz+bEkMNbVMeuZMb//p6oShtCLohO58UiOhwgk301NitrsIXEc7GljWa/XGICSTt++OC1JJRzrYIvzcuq4iSyzsMYXEB5+FLHG/aA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423848; c=relaxed/simple;
	bh=ouJRL/yPuaEWDuzRs1ngnvqXncoWqdNYzlYL2zffHWo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kR/EnPj6YyB8yqjzzPM4Aol2NXUJw2OeSln7iASIl4EuXS09ZoQs3Z8ukc5nfNcg/lX1wLIazkRjhv9bt4a9Qi/g9pjSmTvrgCjNdaeA1UVDrS9JkIPUrSW6/obnlYAyszaWoPuobltSkV+/AypwtMchCeu1M+9SMaM2x8s9JzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BrG91Svc; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dg4k4W1snXPtEFXGdCCNbntGf5c/9VjSCYqPuClLyPTQfDnsv37BlCUEdZEiIATE3sKGdgUIw8xR9fFxsjLFmGLzSJUQlJuWHYyMeGrU336w4kEoiVr57jfWCD/Y3Bq5YK6cQezvz/FzAFKKjYwIjjeUf7W4QOKQoHP3IkbqmAYKwiGQPckapVmxflZ/81k48RlS99gjHKhoXHkXXxE0B3vsjaOZmNyVpxZxEM/G7SQB+MGu8s12plekP13LjrQfMQeoB7zl1vcrB0OqvKtD6GymWGpmZ5T6cGHZaBNciPBPtsQhbbrOWsRGY8ITonvqURxpHI0XExm7BUiSRGNAKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ae5cghQPSlplfZ4W6IZBr0BA8ZapYfpx4zU/+/6D/g=;
 b=wfsK+PzMKYoCVGRlilfSN5hsslbLa3oeykCEg8sRKxKAzoVC7NjpO+nuJxUMXFKng+uPyXjfuStKHbQbwDXFbQGYqczL0dT+XHxhnRmd8rRwFy8w76S4BD/E1obvTH7RmnqoLjYRighTaLGmYnlATTy7+lhFHYjdE5HTq0t2Q8BkI8tzYFi12xjvdWwxgbLjLFrILd8nh2cWxDJKik5s7gvLd+83YxHMAYMwF68/zdQjHcURkFP2jrfUs3lfE3NyumgKH680Hh+EE67qB6xzEFMvVIM24RcTrNCvlfIn/aGMky5ALoJP6HKUc2308JD3BZqqjx9sKHQDTtuFnBXxtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ae5cghQPSlplfZ4W6IZBr0BA8ZapYfpx4zU/+/6D/g=;
 b=BrG91SvcexH2kW3SFjZwENGMciVDIZcXWymVQAzl5NlFIoGUovyuwNBgjk776wXiDCZT4UTtu2ag9e0ycCK+uppY9eYxUOnleCjsy3sgnxTV5cf7VrLAZ0NgVNB4UF1itqmNVz3/o9k6+9fsip+iG+/KyIyKTP+Luj4HopeSVGiyC+yAqq+DgwichhFIO3JfwTg7tTajfvTCBfEyF7oOCRScX6uv8sjIDTcsA8IfBqnw4asIykhYAyi0JBWu3t4wshV+Ot8KL+G7Jk9gvehTpTPvyplwrN2/C2Xc4e0FDCk3wOYtDeduMQKTz9mh+RHW4xK+/HQTxnDtPMHqnj26FQ==
Received: from DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13)
 by PH8PR12MB7026.namprd12.prod.outlook.com (2603:10b6:510:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Thu, 5 Dec
 2024 18:37:23 +0000
Received: from DS0PR12MB7607.namprd12.prod.outlook.com
 ([fe80::87de:7b37:7b37:1ce4]) by DS0PR12MB7607.namprd12.prod.outlook.com
 ([fe80::87de:7b37:7b37:1ce4%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 18:37:23 +0000
From: Richa Sahasrabudhe <rsahasrabudh@nvidia.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: QNX6 Linux kernel module RO limitation
Thread-Topic: QNX6 Linux kernel module RO limitation
Thread-Index: AQHbR0RxxHgEkjWh+kumAUNpplTD9A==
Date: Thu, 5 Dec 2024 18:37:23 +0000
Message-ID:
 <DS0PR12MB7607A64713EFA94389870625BA302@DS0PR12MB7607.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7607:EE_|PH8PR12MB7026:EE_
x-ms-office365-filtering-correlation-id: e81641f0-3dc5-4da8-d365-08dd155bdbce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?NBlPom8ciMmt9AaRvI6l2F8TItEjmzCz35Q4AS5wsWYzit6Wo5UZXuHx?=
 =?Windows-1252?Q?HSzkNJV5lVhcSs+lNN7CLVDa8NP8SuHN45bwijmqzzf8Opl7FoOJqfFl?=
 =?Windows-1252?Q?S0V3ZNe38bAUSBCIo82XsfiuNdgzZzhaJNxiiTiGlsY7vKdyFQp9Xijc?=
 =?Windows-1252?Q?3tYEMFXHgGhmFepd1fV3J00BUvQWMsFuKOPpog9Hlh83Qx+qxdWZQIs5?=
 =?Windows-1252?Q?Ps7Lx7+yvaTamDkYgRbPJfl7Nz2nZG+oXs54EXXvYoluIp7TO36jWsNJ?=
 =?Windows-1252?Q?iJ5g+QrRAyixCHlPHpR0SsdBb/WtzSZwVd8xIfUt/XJmGECw6lU9n4Ph?=
 =?Windows-1252?Q?46LnG3BbjqxoFYQe0hQ7mpJtk42yr3AO6nHnGZTFyz81jcv+4V1lfZ+l?=
 =?Windows-1252?Q?3jPPXWLjRP2JuQ66F19AGiVa6mgdPUvTHNjEr9Ck+OiEdnnAw4uj0SUL?=
 =?Windows-1252?Q?aGEQb3H1vMIPZ0UUKBpd9XfN0xAsnCrSVdz6SNXcTlgL1VEEDYubvfbw?=
 =?Windows-1252?Q?Z5cMvX1y9rPlYIv7rAfERJIBsXFBUlpKQlumKPTaYVIkJVuhZCh9c4uS?=
 =?Windows-1252?Q?PgJibbicRCB17ofuvH5iMA3GdHUxcMDLclQOz/SOwEfqnAb5EMb+aPDg?=
 =?Windows-1252?Q?AlW/xcegO0KW+LvM13G3lykAFIC92QjnbRwhZYf1CXQbwi5MT1OWPJlV?=
 =?Windows-1252?Q?7QxDqdKMI2L2zrBuaosYzsoCQAK/RWcF2y+shufBa+k3TzN0Bpivyc3r?=
 =?Windows-1252?Q?JeiORxJGfb0FS/DB7i+p0ZUwx3S2cFcMdUE7+eSCXD8AMlV4Bkmmc/9z?=
 =?Windows-1252?Q?Kp3mskU4OW1jLgukVBKTU6vTgMG3UmCFX/Cfbc0eT7mXpk3/z41GDV3W?=
 =?Windows-1252?Q?WmimfBF+PWkXj76WwYCCPFdkghPByRUo5HApTD2LuOJ/I0mD/ORKPu2a?=
 =?Windows-1252?Q?x7SnLGFO4F8jPx6XFYikBUNxxtOjm3R+bLdEvzhnrngGMr8oPJAkTZSe?=
 =?Windows-1252?Q?70v2OGQoezfXFDWhs2wp0AlysNJRkFDXgDe+hwjIM+kkqf9Vra2eC2Y+?=
 =?Windows-1252?Q?cyvrEAm3/uP7MV7PC3zoRmY+h+AU9ydoIxR5aRSids3bv2Jn1QAop/nr?=
 =?Windows-1252?Q?ThftRhZmy8t1IpyHubf07VgRL0tqlhS8jXdNbBypzCIjHeta2fxRgo2i?=
 =?Windows-1252?Q?GmETfa7UauckO38eGYbKJibIF1kH9/4TOALjqH7wmowyfV9W62BC6S1u?=
 =?Windows-1252?Q?1j9oLKyF6mfgJo7N5r6ZnrlcbqOamyLQlMXuZS7QfdA+fmoN51SwP0FM?=
 =?Windows-1252?Q?RHVXINWVfMs6xinlGPiBnqGVV3DssM5CjggGZ8LK7wAsYzD3EFMDeIYm?=
 =?Windows-1252?Q?kWIZD8Bokw/95fTgMlROQccnfhFvyq5AO56cP45gq1u3xIS9nsI4hTnF?=
 =?Windows-1252?Q?srJBIpSOwT45en3uG7IDLhdYMYGgUPs55MQRPxnMKCl5WnCwfA/63lZA?=
 =?Windows-1252?Q?FoiR1k8XpX4/3mSGOC4apSZPTL4Npw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7607.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?ZtyyvIWEt/5vlJiEH2nwF6xfv9y4P2c8/liTjtVDG69pVFxR4jfvuf0U?=
 =?Windows-1252?Q?QVtx7BAHMdIe4sv9/L4JpKtbuZD+KnJmOUen3VYtvL3QJBpR78VZhmfl?=
 =?Windows-1252?Q?vfqcS9MWYh3JFCMIJcuJFZ1517A6oa59MV5iNCzlk29wzkx4Qgn8Do3r?=
 =?Windows-1252?Q?eytUfOJbv/n4lVTRlBgfi5APA2jTvkf4SL/D/nqpMlk3OSmNkEonn9L6?=
 =?Windows-1252?Q?OdO9iAOxwIyOUmkpLWxlEu1V+Neq2188DsqEWzV3Kv/PMruRPFD8j66K?=
 =?Windows-1252?Q?A00DFQNDrRDE0r90XXIm0kPp7Fold1dFzdPUbvYGegHTblkqPyn/uUGe?=
 =?Windows-1252?Q?CT6T9GumZtHUrKbrYuJ4H1ZOU9eB4LPIeIsxUltt2Z410cUhD6KDvsSX?=
 =?Windows-1252?Q?UwqAATqAjN3c+Yn5IFcwVH4SP2Fgqx95mS4kACZ9bYmXepw9vXHjk1n7?=
 =?Windows-1252?Q?Uc4knlftYYRUIga0UX/dik6YUjc62FeKVshXk4E9eWDpg2+QYhCWvj1P?=
 =?Windows-1252?Q?+JPazGOXcTC3nIkhj/XHkx2A8AS1FmQf8rXG6J2cjyvGU5nNUtAFFnJ1?=
 =?Windows-1252?Q?dLTTvtugMpapR0slfPO/TGRr5+V7zXeSLL9P3gztIGUcvYXzEk+7FraR?=
 =?Windows-1252?Q?GSiX0tn7Z0UqyY+EPhP2w7hwmZaNeulCnOLeIw5wygq5w1Zl1MvxMg73?=
 =?Windows-1252?Q?RasWbCmXkXbv05zBlt5nH5pN5UP29Xo9OyafuyStVQaoRkGvZO5OUdRU?=
 =?Windows-1252?Q?4Cx7HXrJXxkVgQ+98MayLfcdqvScO1RBOnfr5VDB3t9bMM0EbOpM3Gux?=
 =?Windows-1252?Q?J0kH0H6yUOFFGVLCY52T2FYEYL4FHPIMYuslYIUlRg0cV7mqlCj1mc3A?=
 =?Windows-1252?Q?3gp5JA25R97L757KWG+zrCFeWWVvybm2BCRzSAy5jLdHz2YA/oxUwV4r?=
 =?Windows-1252?Q?VmONCdXLP+A5fCMlWoVCkBpZl2IwQxp30dPvfGhEsw88U+LI5QhlMoqu?=
 =?Windows-1252?Q?jGFXoGLTnX59kuanHkPaCR6zMghsJTm4mKTSpCXQF+3kCeVfWmLUmSNF?=
 =?Windows-1252?Q?s8SGHwA8gs2Ise0s/7MQFsR+Sla88oRjZAFuwC14O0wmWxLC1biwAFGc?=
 =?Windows-1252?Q?UrG/vlkIO8UbuISebhY02o31PpEaXq8WgNqWwU050JKwrAjJz7Ri60/R?=
 =?Windows-1252?Q?p4Ococv0xmCmzb5DOU3jx8s9f6lXuYEEEy17Ka5Ltlm3xxRiqJLg720y?=
 =?Windows-1252?Q?fBmdhVBrPl9fgbU2dyrZVZLXFCVYAClu3W83IywZeGzNdaej+KYSx9wi?=
 =?Windows-1252?Q?ZFEM3mCGe7hUg3qLJvFqEnvE/0JpGfldbEU9l3twEwpdwHnebRCHiSte?=
 =?Windows-1252?Q?gqZq4Hy509cM3T3a+KC7mrx87PxKvljZCfJvY2qIkcvp9jp1s58xp2s4?=
 =?Windows-1252?Q?MS0T5X6/lgcGMITR3JqtWD0StVa+zI6bLgb8iJDGA21nfO6//TyPB9e6?=
 =?Windows-1252?Q?eViU98GNXFHIVWKqgZuJ0KLrR5gZ/WdZYdPC/h3Zbuga7RXskYYUmkNm?=
 =?Windows-1252?Q?6Es9Z76oEPv2e2kMj2yySNuUx6p2YUoxzqRfL/i0GAaXss2NA0ftJMdK?=
 =?Windows-1252?Q?4wuahDLbtF4a8+LxP+EY18eTGjJ9YhHtMRgm2zREiMjSO+PliDtGDf32?=
 =?Windows-1252?Q?OWalIhXDynHua1/6v9hetCegqwUx9iAw?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7607.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81641f0-3dc5-4da8-d365-08dd155bdbce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 18:37:23.0126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKLlgWlGq9TnSA6bXsMYFz+jby6WVVJlrWw6gQYQsPU+K/YXmvwSf/3sogGLtYVJfwyG6YLmkPImBBG0Pwp+BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7026

Hi=0A=
=0A=
I am trying to use the linux qnx6 module to mount a QNX6 filesystem partiti=
on from an SSD onto a linux host. I am able to mount the partition, however=
 any file > 2GB get truncated (or corrupted?) to 2GB when read from the mou=
ntpoint.=0A=
=0A=
Questions -=0A=
Is there a limitation on maximum file size that the module supports?=0A=
I have tried formatting the QNX6 partition to use 1K, 4K, and 16K block siz=
e.=0A=
The linux module could only mount ones with 1K & 4K bs. However, both canno=
t read files >2GB without corruption.=0A=
16K did not mount =97 =93mount: /mnt/qnx6_16kbs: wrong fs type, bad option,=
 bad superblock on /dev/nvme1n3p2, missing codepage or helper program, or o=
ther error.=94=0A=
Is there a limitation on block size supported by this module?=0A=
=0A=
I browsed the kernel source code to look for any such limitations, but I co=
uld not find any. I want to patch the module to add support for files >2GB.=
 Can you please provide some inputs that will help me find the appropriate =
part of the code?=0A=
=0A=
$ modinfo qnx6=0A=
filename:       /lib/modules/6.8.0-45-generic/kernel/fs/qnx6/qnx6.ko=0A=
license:        GPL=0A=
alias:          fs-qnx6=0A=
srcversion:     B81F3D9620B1753DF4431D7=0A=
depends:        =0A=
retpoline:      Y=0A=
intree:         Y=0A=
name:           qnx6=0A=
vermagic:       6.8.0-45-generic SMP preempt mod_unload modversions=0A=
sig_id:         PKCS#7=0A=
signer:         Build time autogenerated kernel key=0A=
sig_key:        03:0B:6C:98:F4:46:33:57:AA:65:3F:5B:DF:E4:5A:02:84:DF:3A:24=
=0A=
sig_hashalgo:   sha512=0A=
signature:      0D:5A:21:4B:A4:74:DF:06:9C:63:9F:51:02:7A:DD:54:EE:94:A8:F5=
:=0A=
22:3F:B2:1A:F7:1B:BC:55:3B:D5:25:A2:01:C7:40:9B:E8:A1:50:F5:=0A=
67:25:1B:5E:2A:F4:F0:6F:B2:50:1F:0C:86:39:5F:0D:03:B4:68:F5:=0A=
C9:F7:A5:29:78:01:FE:4E:28:75:94:17:0D:9A:B7:D0:24:E3:1B:3A:=0A=
80:C3:FB:DE:04:66:75:2A:4B:BF:D1:3D:6E:49:C7:52:81:B8:00:F7:=0A=
53:B8:58:67:42:85:7A:87:76:07:0D:75:E8:D4:18:7D:D7:03:6F:5B:=0A=
37:25:99:A4:CD:19:9D:A5:57:11:B9:2A:12:00:F2:F6:23:69:67:59:=0A=
F9:BA:D1:2B:69:C7:4D:9E:57:3E:ED:11:6B:64:E2:9F:68:99:71:3D:=0A=
EC:21:FE:E5:3A:21:D2:5A:75:9C:FF:CB:79:65:11:C1:05:49:17:73:=0A=
98:B0:D2:2B:68:11:FD:ED:02:64:5E:B8:80:85:59:5A:33:A5:9D:B9:=0A=
51:49:A2:E2:7B:BB:75:C7:AB:A6:68:C5:99:51:07:F6:49:07:B0:F1:=0A=
BE:72:21:42:B7:2C:81:03:AC:63:BD:C6:C6:F6:D4:B9:BC:D3:93:BA:=0A=
F6:E2:16:B6:DA:1A:F6:1F:89:CF:B5:40:A8:C0:6B:70:7F:A2:08:EE:=0A=
03:9D:4D:7E:81:4F:45:D2:61:77:AE:60:01:30:E5:AE:B9:42:63:6A:=0A=
FC:7F:95:78:73:9C:24:D2:C5:F0:58:C2:10:14:18:08:DF:57:50:34:=0A=
35:50:4F:DA:D6:29:78:75:9C:1E:1F:1F:9D:C0:A1:1A:2E:02:2B:A5:=0A=
B0:FB:C6:F3:F1:42:B4:03:49:25:20:5F:C9:1F:5A:C1:2B:CE:71:A9:=0A=
5C:F6:9D:04:25:41:52:F9:E7:64:1A:0B:85:85:D3:20:7E:AC:93:5C:=0A=
83:F7:FB:78:59:33:30:AE:66:A9:00:0A:66:B2:5B:37:1C:5B:4B:C3:=0A=
CD:48:9F:A4:96:28:BA:12:EF:7D:CB:75:D7:55:A5:FA:03:D7:1B:E0:=0A=
FE:14:A4:68:38:87:1D:39:58:B1:85:09:1B:6C:FC:30:1A:FD:A5:AE:=0A=
1F:73:1D:B1:5E:22:0A:D6:13:85:93:DA:A7:C1:65:63:CB:E8:86:28:=0A=
79:38:FD:8A:84:DE:C4:BB:C6:07:83:4C:58:95:D4:C7:DB:41:DE:52:=0A=
27:09:96:CF:43:CD:35:DC:12:92:13:3A:80:8C:04:B1:33:1D:A2:14:=0A=
1F:58:6A:DE:DB:D0:D8:78:0D:B8:AF:0C:3B:2C:DA:3A:67:F0:57:EE:=0A=
AE:DE:22:BB:DF:E1:CC:11:E9:33:A6:49=0A=
=0A=
Thanks!=0A=
=0A=
-=0A=
Richa=

