Return-Path: <stable+bounces-176426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C05B372A0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 20:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCCE1B60068
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E02F546E;
	Tue, 26 Aug 2025 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e1RSai4d"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E432980A8
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234339; cv=fail; b=oDsCmkbwhCsdfKvOR86G8Wx5eApoSGTDf+0tQU7+yX+dm0vTYofB4g+AFWq6P/dgJ/I6u5RL5Me0RIm0OPMgijY0pzNySYnxJ67MUIdHILoOlfijydGzQ+B71WNnLEn7jgj862bivTh0mtUtxry9jISNHBwPlGJs79Edf5h0Zbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234339; c=relaxed/simple;
	bh=rfi4+bOJ4p02Ctwc1lsz8ux67hfKvhB/ouKQkpcjzAk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oZk47QhmWV6UuMYA+RLkqz9vVytYbtqCX7Ly4eUR4/9ORkB16IH3xkiKrP+N1WMkTEGgwFB5b+O25v2a0rhSxXdhtaC+ryjz3I7kDPaEPLXPhOxdGcUHcfWAqTQXQBX1MpR4HwXzqLRXIVhu3MVlNAOr9E1nSCSvwGhTfe+oN3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e1RSai4d; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvlHJ6ITIak1b+srm1FKVtDcxdK/lKLyW5th4iWqcDhQv+S4Tk9lATcd1fQnKLBhG25K4erTnLwBk7AUwlLs6vt8PlhYHYkP4mEELKzxegPXoSdTIYcQTciReN1+B6DiXAZEdMXskpawHhsjDQhFvqNVW51g89kcxdCeHTJRT6KhBT958VvmuguPi3xo3k5gVASmBTFODDxWcYnJNN7DpVhXi5OVvqy6XV+gDRWwjJVBsHNOkXBS+53OgGNAGlOFZrQ3djteeMJZftFDVuIrphY+qkU8as0oOJhKxjtAVvqimS7D2TLMbdQOVLe5XyW5eXXHbFGmsFPHsroKfLnYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfi4+bOJ4p02Ctwc1lsz8ux67hfKvhB/ouKQkpcjzAk=;
 b=OSB2Rlr6MBWtfVynUKuEBt77QUN7zZp1q6ew10t1zRptwbNi3sNs5QQMz4JVLAUPEnvgbxxVIWVbqU6shcHP9f+KTO5XIkLjvfcvNnhCT4XrpT6WQoXeaxna2wO5qeyQaTPq9YJcNtP2vAaUuGbD2XtkJCrq1oq8OjFH7cCEKvBb90ggn8ePbkdDANMhe2p80XWjBv6s4HCt9gx8eUyEkAHy9e1mzD+Gg6tNARIYtufVxFXKHmG//dFgCOfnD//Vqh9cX0jU9fF+GY4OtA/y7SGlOjzHY7802bnyHTWvspqojQ/yzWGMG57UOF5QlZeGmt39iWPtAqKsIzlZB4pSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfi4+bOJ4p02Ctwc1lsz8ux67hfKvhB/ouKQkpcjzAk=;
 b=e1RSai4dJ65Ido5QJqy+2MUk7aY0KRdz0i2ZzK2MPxlj4rF0beeIUJLAhtaU7Fx3ZdzZvpCav8rdyv1Hd8Wl/B9XH8Th0ttLpCrf6oZ/tD7CrP5iCUF1CuswLNPl8OgS3fkxOO0UxSns+hkrkkgAasHM/RX0KRmgouzliAOujtE97C+7/d5TVQtlkv7guBu6cl6Gn7m3Un/qieKO4vsRALxSn7bnXwCzct7X8WXTNfNyvbT1hZXCF5wJT/jnWlPT8m/F2NGjrNJFyODtm2KMRRCxWRb67iEWSZJF1yBeFuL67iE1630ClXA+qTke7y0r9c5xGGT3iCP7lGv6Z3jLaQ==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 18:52:11 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 18:52:11 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: RE: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Topic: [PATCH] Revert "virtio_pci: Support surprise removal of virtio
 pci device"
Thread-Index:
 AdwTTxd+YdVEFNqzQBWcarw+isQ7dgAEGgsAAAF2L4AAAZBEYAAAb+MAAEx3t3AAGRJRgABs+xOw
Date: Tue, 26 Aug 2025 18:52:11 +0000
Message-ID:
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250824102542-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|PH8PR12MB7303:EE_
x-ms-office365-filtering-correlation-id: 07ff8be4-f294-443b-a5b5-08dde4d1aa36
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mZecC34QcFjKMuIWpY8bK76WAmTkTSC6SsjBL3j+4Gk/SKce3gUd7X2zOGaw?=
 =?us-ascii?Q?aqM3WcdEt6qYu2+0Q9ShOzqdAR009yPzEeuO8UGmFGTUHiOm5YZSvsK4y1N1?=
 =?us-ascii?Q?g6FHmSYcyzCMAZIRirsxfNfKG0ThspPmWHvGf9nQT7Sz7jwfv/k3xDQq7+Sy?=
 =?us-ascii?Q?xFEkFsp5h8ywReMTPlxXmEGen5wKtBBCy4ER7rCrWyxCNsUuht4YnUrdbbg8?=
 =?us-ascii?Q?h3CTbLEBk2ujxBMiXKzx134zy9K/uLjCJ40nibIm+bQFK7MRy0s5kVMnYI3L?=
 =?us-ascii?Q?LQTggF869UyXO6rL3QYCtGUn7jtsFHejaZG0mUOZ9/nN7/Qjv/qFTj8BaIEr?=
 =?us-ascii?Q?Rynt/cfWtci6JU6Q6UZqFb18RklCUKgPza8kpfl7sxr1Ujqp4V7WVkgdHLxX?=
 =?us-ascii?Q?YDaCD0Ey5PZMFDE9QEzpLnoiuR8laibRwaysJGjiRP2XDuZ9CKOybLZLlSVN?=
 =?us-ascii?Q?cBpKhRCTY+IdXDV/tu7/q7YNXMVWDzXVltsYCxWtZ4ljcvLJiBNzLWSDIVJt?=
 =?us-ascii?Q?Qh7WpnRzGM03jK/YplbTpKMjsWSKmyB94eJYpu39k5FOm8kfK2QITr2G47iO?=
 =?us-ascii?Q?hA1GO0AyqXHWZf9/Tida9prfhi4e5BwKZZK8q6g8qeZcx+rYea4JNdOtgiFY?=
 =?us-ascii?Q?q1NhhNqB8592d42fTxEByq3YTR735p0DRymQ51JBtA7sIcf+ED+uwhwJGDXZ?=
 =?us-ascii?Q?Lcu4kmjoO6C2yr97AfBxEOe6KL/6c9QfkkYpd4FXa50dJZW2QaY81wafNUUE?=
 =?us-ascii?Q?wLzA8BfY047gjtaW5L5wF1QS9e8yALv1rziPqu70VbGcKyUsDTFPVUwWcceS?=
 =?us-ascii?Q?HZes3LQokAd2hNAZjZn8qHCh3+FoTBA4we832u5DYHnNqX9+wSD5yKCAB0qG?=
 =?us-ascii?Q?Lk+30o2VRoDpyoTlqXN42LOMG2I0FGqxLjzH+v8yjw2cM43Ms3szF6Ju8CA/?=
 =?us-ascii?Q?btz3ryXhhgGf+jmMV4T63WjyK8r3ctP6bG1ouwOvyT7AfpUZ1HC9GZiTtfp3?=
 =?us-ascii?Q?ck9eIz1mecGEwsKf0u9gF+rtjcxreloiqNPhFI7KdSsxQlF+4bmbDTGcDzi6?=
 =?us-ascii?Q?y5XgDyAZ6JnIKL7DS4jhpQ6PWiEfb2e1qYPJc00/5lfssyofTdq5kve/u2tp?=
 =?us-ascii?Q?3sZCPkqzbCPD/hOWdD9rrpBk1fYMO0SBdtVIEZ6Y9IkwYbTuDhOklZmS7JNh?=
 =?us-ascii?Q?Sp8fQASX7+AZHGQnWTT4qXd6XB8QHXtXLpOZDgbPSRm+0X9ekctEBoZZisLt?=
 =?us-ascii?Q?EXiXqbru/uKgqUkHENuyE7xsmThWfUT/asrBbvS3Vu6yxtwRNZtxF94BMbPy?=
 =?us-ascii?Q?l67UL3eZObhHeyBn5l/hUp8qT4P3r7d6wqqAdoG9FOuvKKIlEYHS7jzMZEaF?=
 =?us-ascii?Q?OqPgRCWfy01RIGeDtnkgUgS2Mcmkro5tUyuMrBVWH2rVV3hMHu7963LICziJ?=
 =?us-ascii?Q?KAWF8XHvwmPOkBTbj9EBv4KqXfP/lJ7hHGmcLYZYaL8bBB8QYgAVtFc2bsAc?=
 =?us-ascii?Q?TKqvaVhcu9BZq6E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1YNJeZXDGUlBted36oFKRHDxNCdPVb2G+7nCa3KYEVHX8SEojBVvvgi6VN/C?=
 =?us-ascii?Q?CNLGbZfz3KXuHGPr17kw8A32yxDy/O00OH4xe776axqSxtifN3QHDv+JV4Xh?=
 =?us-ascii?Q?+PrlAV8tWslKZW2SZN3ki3QmPlM32PyPCbubxgkX3OUDsO5F1uHoPp47Chfq?=
 =?us-ascii?Q?fYvKM8qZewOa5mD5PswM4AOcsJ1UOomBE38VvIS/qxtsXw+fl3bLMn9FM2p+?=
 =?us-ascii?Q?KHqWFezbj2xTt4vLhpRAy8x9Z0lXJpKfC84AxGoNDuFD+CoYFuGIlX/CQhOh?=
 =?us-ascii?Q?ocliayan/QZWMYx0O/FdL8hx24WXdzk6gUppFDMeF1TJRt6WXRFfqJl6eSXN?=
 =?us-ascii?Q?4YT8JGCStgyTBym1Se9EBdsXIIGl/eGUe2g0B5dxJ/jNdLEx+/hdUPTPjHMY?=
 =?us-ascii?Q?2TsR9/QOE3w8zPMZNzePVxBY8fE2ofJnUrWuw3LLs/UXblXlHBhkKa8lOOTU?=
 =?us-ascii?Q?LA3O34ffXNEas/4A+Jw7GHACIDTG94nKG/4L7GO0Wm1EnKXqfLaFclSCvwTC?=
 =?us-ascii?Q?0u+RbtgfOVxQddN2lTrevBD6dNL6X+8ZrenNoiqpQOugn+8VNM0p76rR1HBX?=
 =?us-ascii?Q?jGMG5+gPtxZPgs4HaUEnZEVz3VTs9hWFZUQ5siGZ39ozipaGMLObTgCns9NP?=
 =?us-ascii?Q?HBccDlGys/i7mkWzltXyLHR1P+xMZrsdZ2vf4Mv5VmxHIonuQ++rFIBw7CYi?=
 =?us-ascii?Q?UGlvt92x0YuA1q6gnoKZhHzpCJzE2GofksPQ034qLEkKuZsADVNVE2z/U1ws?=
 =?us-ascii?Q?6PKXN2OJtu/kNQICK1MElaafgyLt9Z6xgdRRo/CgaLOLb370lOU8N7NFbDoV?=
 =?us-ascii?Q?RdBxRZdBcmyS383UyiC3hDuCW/VUFM/duEvAZ19FOeDM8fjJIr8UzK5p3MuH?=
 =?us-ascii?Q?2yeJafyPV/wT7P5btqCm7XwL7ZYiH8he7BHIZ7jqE3asKMgKkadJiEkYy+5T?=
 =?us-ascii?Q?9wkMQbDd+heV0dr0CVN13VCrxmH3YO/HpCJCVl/ybDVkGWFjsg86SlGWKIP+?=
 =?us-ascii?Q?K3r3xGav4HrRhrA2Aj8iWO1xO+lSQ9D4HyzopkeRa/BdytqrGrEc2/J67fB4?=
 =?us-ascii?Q?GD/82ah95Z88XS9w2WBlPi1uzcBNO30GfGM/54Tw5iwkBnsnrTHMAsxR/00P?=
 =?us-ascii?Q?XvzozwcsyoGtn5XU8015yCW5TZgJ3zZx2F+WOgc4QY0DuU8xsc6ueouVucNj?=
 =?us-ascii?Q?SMkbHm0Sz3AqgUz6VdnvW8ppwjv0hiKJgAfyFao4TT/+oQ7qeWAbIWwoW4vY?=
 =?us-ascii?Q?hM6wz4P3mYzcptt0UC2Jwd1AItBJmsdDVf58Tfds9fjV0KWA1ooA1NfGp63x?=
 =?us-ascii?Q?2o9pmUGUqHr/icZOY9nb5pdqBZBqDj5WN630I2rTvD2ea0cPkDeNT+1jCnaO?=
 =?us-ascii?Q?qLjEu5ZoybW87YNsl3u9IkRdBgCmAgCb/LhQgmRM5Iru4eCY99weV9QxdDm7?=
 =?us-ascii?Q?MJ9meoGPlylGDf3u4ViH0tMgPTVOIvi4x3Pv5yj8Ew/eTMsKJj7HeEsixF1S?=
 =?us-ascii?Q?P3ysJqdBDjdJQZKSd9v+2jbpoLNv1+ble7oY2VNpSkVSyvsZ5RgOf1b9mY6/?=
 =?us-ascii?Q?3GjidrJRyvTOq5FNAqU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ff8be4-f294-443b-a5b5-08dde4d1aa36
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 18:52:11.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eY/7tC5zlAwtm67wiLWnNDkAFg/aTiWgt/6S144E84ccSBI0YdIeHIt98H2nuyscWL/2Zj567sJe7/Ub1zXScQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 24 August 2025 08:00 PM
>=20
> On Sun, Aug 24, 2025 at 02:36:11AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: 22 August 2025 07:32 PM
> > >
> > > On Fri, Aug 22, 2025 at 01:53:02PM +0000, Parav Pandit wrote:
> > > >
> > > >
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: 22 August 2025 06:35 PM
> > > > >
> > > > > On Fri, Aug 22, 2025 at 12:24:06PM +0000, Parav Pandit wrote:
> > > > > >
> > > > > > > From: Li,Rongqing <lirongqing@baidu.com>
> > > > > > > Sent: 22 August 2025 03:57 PM
> > > > > > >
> > > > > > > > This reverts commit 43bb40c5b926 ("virtio_pci: Support
> > > > > > > > surprise removal of virtio pci device").
> > > > > > > >
> > > > > > > > Virtio drivers and PCI devices have never fully supported
> > > > > > > > true surprise (aka hot
> > > > > > > > unplug) removal. Drivers historically continued processing
> > > > > > > > and waiting for pending I/O and even continued synchronous
> > > > > > > > device reset during surprise removal. Devices have also
> > > > > > > > continued completing I/Os, doing DMA and allowing device
> > > > > > > > reset after surprise
> > > > > removal to support such drivers.
> > > > > > > >
> > > > > > > > Supporting it correctly would require a new device
> > > > > > > > capability and driver negotiation in the virtio
> > > > > > > > specification to safely stop I/O and free queue
> > > > > > > memory.
> > > > > > > > Failure to do so either breaks all the existing drivers
> > > > > > > > with call trace listed in the commit or crashes the host
> > > > > > > > on continuing the
> > > DMA.
> > > > > > > > Hence, until such specification and devices are invented,
> > > > > > > > restore the previous behavior of treating surprise removal
> > > > > > > > as graceful removal to avoid regressions and maintain
> > > > > > > > system stability same as before the commit 43bb40c5b926
> ("virtio_pci:
> > > > > > > > Support surprise removal of virtio pci
> > > > > > > device").
> > > > > > > >
> > > > > > > > As explained above, previous analysis of solving this only
> > > > > > > > in driver was incomplete and non-reliable at [1] and at
> > > > > > > > [2]; Hence reverting commit
> > > > > > > > 43bb40c5b926 ("virtio_pci: Support surprise removal of
> > > > > > > > virtio pci
> > > > > > > > device") is still the best stand to restore failures of
> > > > > > > > virtio net and block
> > > > > > > devices.
> > > > > > > >
> > > > > > > > [1]
> > > > > > > >
> > > > > > > https://lore.kernel.org/virtualization/CY8PR12MB719506CC5613
> > > > > > > EB10
> > > > > > > 0BC6
> > > > > > > C6
> > > > > > > > 38 DCBD2@CY8PR12MB7195.namprd12.prod.outlook.com/#t
> > > > > > > > [2]
> > > > > > > > https://lore.kernel.org/virtualization/20250602024358.5711
> > > > > > > > 4-1-
> > > > > > > > para
> > > > > > > > v@nv
> > > > > > > > idia.c
> > > > > > > > om/
> > > > > > > >
> > > > > > > > Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal
> > > > > > > > of virtio pci device")
> > > > > > > > Cc: stable@vger.kernel.org
> > > > > > > > Reported-by: lirongqing@baidu.com
> > > > > > > > Closes:
> > > > > > > > https://lore.kernel.org/virtualization/c45dd68698cd47238c5
> > > > > > > > 5fb7
> > > > > > > > 3ca9
> > > > > > > > b474
> > > > > > > > 1@b
> > > > > > > > aidu.com/
> > > > > > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > Tested-by: Li RongQing <lirongqing@baidu.com>
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > -Li
> > > > > > >
> > > > > > Multiple users are blocked to have this fix in stable kernel.
> > > > >
> > > > > what are these users doing that is blocked by this fix?
> > > > >
> > > > Not sure I understand the question. Let me try to answer.
> > > > They are unable to dynamically add/remove the virtio net, block,
> > > > fs devices in
> > > their systems.
> > > > Users have their networking applications running over NS network
> > > > and
> > > database and file system through these devices.
> > > > Some of them keep reverting the patch. Some are unable to.
> > > > They are in search of stable kernel.
> > > >
> > > > Did I understand your question?
> > > >
> > >
> > > Not really, sorry.
> > >
> > > Does the system or does it not have a mechanical interlock?
> > >
> > It is modern system beyond mechanical interlock but has the ability for
> surprise removal.
>=20
> I am not sure what does "beyond" mean. I guess that it does not have it?
>=20
Right.

> > > If it does, how does a user run into surprise removal issues without
> > > the ability to remove the device?
> > >
> > User has the ability to surprise removal a device from the slot via the=
 slot's
> pci registers.
>=20
> I don't know what this means. Surprise removal is done by removing the
> device. Not via pci registers.
They are many ways to surprise remove a device from a slot.
Slots are capable to detect the device removal and when that occurs, the pc=
ie switch/bridge updates the slot registers for the downstream port and ind=
icate to the sw.
Some slots are physical in nature. Some are virtual slots in the pcie switc=
h/bridge.
End result is, sw gets to know this sw PCIe registers in switch/bridge/port=
 level.

>=20
> > Yet the device is capable enough to fulfil the needs of broken drivers =
which
> are waiting for the pending requests to arrive.
>=20
> I don't know what this means. A removed device can not do anything at all=
.
>=20
If this was really physically removed, yes.=20
but in virtual system, the device is still present on the slot until it get=
s indication from the OS.

> > > If it does not, and a user pull out the working device, how does
> > > your patch help?
> > >
> > A driver must tell that it will not follow broken ancient behaviour and=
 at that
> point device would stop its ancient backward compatibility mode.
>=20
>=20
>=20
> I don't know what is "ancient backward compatibility mode".
>=20
Let me explain.
Sadly, CSPs virtio pci device implementation is done such a way that, it wo=
rks with ancient Linux kernel which does not have commit 43bb40c5b9265.
Commit 43bb40c5b9265 was partial in nature.
Hence request to revert and do proper implementation like you mentioned usi=
ng extra callback and/or with spec extension.

>=20
>=20
>=20
>=20
> > > --
> > > MST


