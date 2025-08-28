Return-Path: <stable+bounces-176562-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41663B393B9
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594931BA25A0
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062412494FE;
	Thu, 28 Aug 2025 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uDmAR8Ft"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AEB1CAB3
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756362188; cv=fail; b=DNSqsITIeCse+t2SsEUucBRLwQl5GB8yQvOcz3NIa5VZeGnyn/RevkkrlPw5hw7R31SXBwsaIe/ZAjYcmIFneHGk9Fqhen25smMCoe0jTztXjf9c1IZ7DVXPTPRHZBCrIu26Ennu2Ffbd1uEjr3XQfrHa9npJUW1nRyVm3Dmz0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756362188; c=relaxed/simple;
	bh=kApRzK9AfoUKBeTZIH7l1OqwLgDY5oTH65zqB3hispg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uWgxqa4JvwQ7O8nhDleKOE2J/eoRc3NiX6jtPqNmilP6TiuFyG/2+EqN4FXS9a5mbBa9it7HCaVkNo32iFCTZw40V0VZh+AhgTvt1XpExXVTg8GHoCm7BASbqDlkNuPZO6c38PwjkMoVMIE5klSyHXEl8K4HfB8HKm/Ht/9UFbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uDmAR8Ft; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeEZZMmSitoOgUq5vppMKNHYR59Y+ejUsQ6ZXt7BB5DHjLG5p/yo8NfwtwvDTDzwQNY4wAEGku4sm97WQ8t5slZvyQhh73xlKY3A7FQmWKjdfbyZevOjxlHfkcJuorMM2kWS2JmAItWRw1bAZeQfiRJ/ukg/RbYru2amXQNbfpkFPQFlh1TJ/FPf9qW7vNDZk2TE26Hu+/3wMdXdE6dp44h70hNQcrxlOj4Is/z1s1Nj5IcM8+O7RDVTgQIEZya6StAj3x071ytkMo3w1TzwmR91RoM4LXwqzfJXXWbKYU1LNm3XfLx3Q+ok4rwvgx3tpGxx377OZFE7BxCNfjmAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kApRzK9AfoUKBeTZIH7l1OqwLgDY5oTH65zqB3hispg=;
 b=Ywma0X2uJzcHDBeoowkkpfqt6VGw5ZHux4E8ARZOW2NZiUZphtRpQ1sTDA4/fMkESaBZovmtstJyKdNJNJamgo6YR/ImGfy/W08GdywD9aM5FGBcRtnc8fGL/kuEXv7nSNhEDybEGPPKLslzQHkhEHVTjPRZUkhFc6+KtwxgokT3HS4I81r1qQsisMRC7ERNEGxVh0sLgwkojJGdA6G0EqLkC81lDra7v0RxALsuD1PKtZpkWDK2eFM/CIM5h/iF6DRiM+LdhLIg4QikJ9zQxwIXhx8ODivwlbEnIWcV+GWbNyvBjaiL5wcRb0jckWbWA1gmJZZAD0TFpwYg9s3Row==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kApRzK9AfoUKBeTZIH7l1OqwLgDY5oTH65zqB3hispg=;
 b=uDmAR8Ft+0BxeL015ZhpJ1iD9pRjUH/5Jb9tsLL4n2etemjcC/MYHhnRhz4/mJ1a3CHYqNjYnaL0W9BVyLBEAjt+6fUBt2dtEPP9XEZIZR3NcSpsMG6fFyee3xImtv/kXTwt8jqy5w67/8NJiCWYgcVUh5GDey3I5B6uMnWIIEigyqWRA3qZ+jGcKNjg3tN06HTjoAbuftoSr6A/nb6lop+E25tcaca6CbpnsNYEEu9Cp/tKD1bxQfMxqSTHr5YML21bZIk1q8vNpmJUKGHUsOPiZPCIvLvmdWQ3UEV0fnHCE5q2LKr0mlaWSdOeW/IknWOcvksOdwiGFZRabGUBIw==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 06:23:03 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 06:23:03 +0000
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
 AdwTTxd+YdVEFNqzQBWcarw+isQ7dgAEGgsAAAF2L4AAAZBEYAAAb+MAAEx3t3AAGRJRgABs+xOwACE6ZgAAAPkmAAAm38wQ
Date: Thu, 28 Aug 2025 06:23:02 +0000
Message-ID:
 <CY8PR12MB71950328172FA0A696839623DC3BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <0cfe1ccf662346a2a6bc082b91ce9704@baidu.com>
 <CY8PR12MB7195996E1181A80D5890B9F1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822090407-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195425BDE79592BA24645C1DC3DA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250822095948-mutt-send-email-mst@kernel.org>
 <CY8PR12MB71954425100362FBA7E29F15DC3FA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250824102542-mutt-send-email-mst@kernel.org>
 <CY8PR12MB7195EC4A075009871C937664DC39A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250827061925-mutt-send-email-mst@kernel.org>
 <20250827064404-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250827064404-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS7PR12MB6070:EE_
x-ms-office365-filtering-correlation-id: 76d44eb3-e40c-49e7-85c9-08dde5fb57dd
x-ld-processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GUBCRI1K3HOue+z87Wvup6nj4IIk+4Hi9G/kZ5OQv5W7YanaGi8u9vCObQly?=
 =?us-ascii?Q?JLfesxBwIERf0qGNBJ8kOJEeFHS+9LHxyQx5HW17idDHJekv2ZLfGh4ee65g?=
 =?us-ascii?Q?Vuo4Rya06+wDFNlAE5pd+2sbxH733x4iGD3Ptc1Z4BLi+bZGYlcJNQgLqaGX?=
 =?us-ascii?Q?+C06gDRAI9VaOCrBrZ447NIp6p61abVqIIoiBBzYhVbVB5aozF59U31bjrd4?=
 =?us-ascii?Q?Z7HJ69ha18GkH11uJQV+DXhMQcBEMBZKqwaeh74LYIfPRO0xadvMA0CJJTTt?=
 =?us-ascii?Q?I3LLAKTJ80f2c2wpFmLqdW6/R/SFFS35ZIpB7VpISZLXOPju1Bs6jXVTZqfU?=
 =?us-ascii?Q?i8o/41oiuSoeLFzM3KEoQk7pI6FUDx5uetFcP2R9k3ge60qFrTsvEhAtFoDg?=
 =?us-ascii?Q?95HphOjn/IXzoTlcgMSPf8AZ1CfX7qtf8L84QlOnpNZe3va/gsneE/PcodpL?=
 =?us-ascii?Q?LXQ6/TmzQVnBKFYxtGN8dALUXHz2s0b137Zy4DAt3OsyUy72wyblAsAMCAcE?=
 =?us-ascii?Q?mDYPIGSaNryxL4E5IeHLeAJbA7IxXz0aGsPsUzzQEE270ggZOROzXEoxjq8m?=
 =?us-ascii?Q?utk7PI80IFmhfhSFsCl7OOoD1WkISQWzjXROWUopOz/ZJ7JlADa7x2b6gmU3?=
 =?us-ascii?Q?Oj9KRzkKAxII+5/9zckPqd7pgrU8Flz/MF7OCytMcep6uT00yA9qvP31zGTS?=
 =?us-ascii?Q?Bfptb3qQmh+x8suWXAuIpNU0T6hZJvqPRS984/h/iH/GKviLtKy4YZA6YHwY?=
 =?us-ascii?Q?sIulDFBXp6v4ifUzZQZ9uN4/8PMZ23ZUHLYBou7I1WjvW+yQC/3hPlknxW9j?=
 =?us-ascii?Q?COHc7Wj6RuGrtDItHkgcZ2OWLSxKMSn9f6HwGdNS3/W1xwCYZ9nlX9Ia5/0M?=
 =?us-ascii?Q?9MQuFX/CKx4KqvRivwNVPHzE1Xh25kY9mIpUlI/faya6qoXjzKUk/J1wfNc+?=
 =?us-ascii?Q?NRrJH5lAe4/vA9mVXdb3y6ra5WYwdizGVvUueuV9WNuHq5ZGqt1dB1Ksm24P?=
 =?us-ascii?Q?WapfRShBN6cfdS3YDRRJjuoMAZbhTmGFRTPDOSeOJfO6cP+fJi0CEYf/BVP1?=
 =?us-ascii?Q?EsyLlV6moQU1j1W6vDyd0tUacO9Gd3St8Tvt35/FNNYjiNmIjAjsWMtGltum?=
 =?us-ascii?Q?UynjEUvdeVJ2i6+R6qNM0PdgmMTpkFnrgxj3w9dzDXHo2vO2ldnHSJrj2Wgf?=
 =?us-ascii?Q?goG+QnXdKQAoz8h+WukWM8K4iXFSVzrjy83VRDfmX/F9VoRtFWGqQMQKptyv?=
 =?us-ascii?Q?VJ0N8yNOA3CTb21rD1DvDAm9AqLE7xKVe19AdFPHom4waczatK9sM2ZnbluF?=
 =?us-ascii?Q?uFVkYWewzlwfg7j91SXQyURkT0oe7GrwaR0TMg/WVA7WZDW0QM5YKaioOeoQ?=
 =?us-ascii?Q?JEuvtHpobE4e4AU97PJinmOuyY4uGXoDqnmGojFQUs+IQyxj1Ck4K3dg3+VB?=
 =?us-ascii?Q?CWlfmOLULW8GRS09QJG/zRLpOlUSz3DDfxph73UbuF2Vc0wMdCECyg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fKglnigz9OIxWh9es4HMUmvmXXY+tfaEpgKm5kDWLNXe7TvgQ+GL+C+RW/BY?=
 =?us-ascii?Q?a+IVtW2PI6rCTdPAHSsdxTQa+I2YORjg5yHiJxSGy3HRu1EFQhhNBj+7TKPW?=
 =?us-ascii?Q?cSM5L1RvgfWw6kCbrK5DQKPW9QfdbE2z28pcWG7FJ9mkHSOvLKsRUHW4Rrb9?=
 =?us-ascii?Q?UPOKNnJ6gluVT7CarfBtGEB+aUzZUiO7DubVdsTR8OjoxdUxelnPZPLKPYKT?=
 =?us-ascii?Q?fhIJYnkv2Rfd9bmPCQHqzgnZvy+pDmTCcCdzgtTUFNPOanKQzvsm3MK17BUL?=
 =?us-ascii?Q?vBL8b/2Ovzhu0ve98HPxYA6M2A13Dhaja4Pf6MqXVAaooU38O7YUCoKXvaP1?=
 =?us-ascii?Q?/dCO5/abiPNcWo3+ZjN6iP8slaakqSnbDbB9aHZWamrM9LyIyCz1+XV4ryYs?=
 =?us-ascii?Q?gTBxLXnMYx/psGevX14QGft2fFsDa1F3m4xUlz6uGJ/z1Sytv9wOouX/lM6M?=
 =?us-ascii?Q?vc5G1si4TQboRKZq/gJFN3vEebYktN51TM4JCldB+rKbF1GBTY8pnfowBkHq?=
 =?us-ascii?Q?bazfi2Tl9KKCibtXwCpEkWK10vHokK3iMaHklumhJQFfJ5WewL0zHuktJ+TS?=
 =?us-ascii?Q?IvfKCfMPlV2V5s//J0FZr1OIoydmN86vhTof7go6DHvOJP0caDdPmuVdfe67?=
 =?us-ascii?Q?x4ArayvKY5r2lfFBtYMMZBt/U6X7XhLtFsgOmhA0DEHYVsGgR8Te9fO5iLyf?=
 =?us-ascii?Q?d+wCf8eVCC5LkgQ8FawL3s58Zx4nE2JQhg51Vhb2hp/1QaLfEUfQXlHUaScf?=
 =?us-ascii?Q?ZAazNl84qpGRC3BL9WoX6rON+BXB31xvdVJJJxCYzI1IROwmFvKZ1rPOeMNg?=
 =?us-ascii?Q?Up+misiDCI+Lr+X13bH3qSMS4FFn2UR2fBphzgDLDumBE1YmjZPOxslkGt7s?=
 =?us-ascii?Q?BZLpDLG882Go8QUW1rTnbXt1584h9vUvsRliE8w50NINdD5le8VWnjydBkHM?=
 =?us-ascii?Q?rQWSg0H1IcOT41J4QQyNX1r/7UWF69Gbuw9sEVYUFML6Hs3+q0mDA0fLCUIk?=
 =?us-ascii?Q?n5GOrYtGdwUfA1DOw0okEN0+/CAJd/7eq3Bc2f/6uBE74EsUe1IGlKkNQ6Kf?=
 =?us-ascii?Q?02JFFHhBxFW0Q6UrcH2CENHVBggHWCnUT5HSVSVBsWh0yvEp2EaZcyn9m5MA?=
 =?us-ascii?Q?TswGFTLf0or3lDrusgs2p77zakdrL7lQPJ1OyTfV/BYcAhVgLkR76J1m9cQi?=
 =?us-ascii?Q?+xsbwlEll5ZcN4QNy1Gt4L6TdtDlWjkeA4l6lB5Xk3qyD9LPxRIy48ipBZoE?=
 =?us-ascii?Q?vEC+65Lu+4HjuYC3X1pWU7SilL2gfz/gSXsXg2B0OfHrgVg+Crzqi6L34OiU?=
 =?us-ascii?Q?tbIJlTNGOJ6AxUxxlJmJ3YnP0GckqnXZ4se99MCMKQA/A0Sdcv05OTx6lJvI?=
 =?us-ascii?Q?DvWBXgMOQULHF7MOvz0m8DFW2ZeAzCxVtwOpp4Tay5uZy71doLXFVTSg3exQ?=
 =?us-ascii?Q?FMeduTAZSsib+1iTrxqpEMdhHqBQltHiyOOFdLY2O2tnHBWzE9DCG5pEEHRQ?=
 =?us-ascii?Q?hwGXtfsk1tPLe+/CETooAb7KIWvcdFdYlGDqpOCYexMrEiM3BTmwhhfwOCJk?=
 =?us-ascii?Q?IECqHBnzbPmsT5lcCg8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d44eb3-e40c-49e7-85c9-08dde5fb57dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 06:23:02.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jkg3b5jzVVhJk7eefzlHGcq57DUmitDJqB8LRsV4H8GVw331fe9T+rcUskcZ3LLUDirRFSR5/FCVroynlAkNxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 27 August 2025 04:19 PM
>=20
> On Wed, Aug 27, 2025 at 06:21:28AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 26, 2025 at 06:52:11PM +0000, Parav Pandit wrote:
> > > > > > If it does not, and a user pull out the working device, how
> > > > > > does your patch help?
> > > > > >
> > > > > A driver must tell that it will not follow broken ancient
> > > > > behaviour and at that
> > > > point device would stop its ancient backward compatibility mode.
> > > >
> > > >
> > > >
> > > > I don't know what is "ancient backward compatibility mode".
> > > >
> > > Let me explain.
> > > Sadly, CSPs virtio pci device implementation is done such a way that,=
 it
> works with ancient Linux kernel which does not have commit
> 43bb40c5b9265.
> >
> >
> > OK we are getting new information here.
> >
> > So let me summarize. There's a virtual system that pretends, to the
> > guest, that device was removed by surprise removal, but actually
> > device is there and is still doing DMA.
> > Is that a fair summary?
>=20
Yes.

> If that is the case, the thing to do would be to try and detect the fake =
removal
> and then work with device as usual - device not doing DMA after removal i=
s
> pretty fundamental, after all.
>=20
The issue is: one can build the device to stop the DMA.
There is no predictable combination for the driver and device that can work=
 for the user.
For example,=20
Device that stops the dma will not work before the commit 43bb40c5b9265.
Device that continues the dma will not work with whatever new implementatio=
n done in future kernels.

Hence the capability negotiation would be needed so that device can stop th=
e DMA, config interrupts etc.

> For example, how about reading device control+status?
>=20
Most platforms read 0xffff on non-existing device, but not sure if this the=
 standard or well defined.

> If we get all ones device has been removed If we get 0 in bus master: dev=
ice
> has been removed but re-inserted Anything else is a fake removal
>=20
Bus master check may pass, right returning all 1s, even if the device is re=
moved, isn't it?

> Hmm?
>=20
>=20
>=20
> > --
> > MST
>=20


