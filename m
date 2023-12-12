Return-Path: <stable+bounces-6506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD380F79B
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 21:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8FA1F215F3
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 20:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC8663BEA;
	Tue, 12 Dec 2023 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XJCxfQET"
X-Original-To: stable@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11022019.outbound.protection.outlook.com [40.93.200.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593ABD
	for <stable@vger.kernel.org>; Tue, 12 Dec 2023 12:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SatmcmKBxQ7P6N5UAEGnDgKvdznkdgMUBfJh/A0TzYRNLlRjdKlE4v6lFhw8Pybt3YLWygC2fiv7uhcaShYKJOUx7BPBjztNVQowbzulpg9ioRPId/SzKoQGNq+60YZ/6+Bv5Ja7e0P6dECAS/Fp0whYrvutGrvzFnTViwbdxy0ia8FPOg6P8Ip5KdqbDrjfVF7ZY5q9Jt/uSqkYOHOFKHN6uumR/yR72zMWj9b/JAljY0+QeEn31u7iYLTZmL4+DkgwwL8jJLKssd9haGQxRgASn/GrWCiTURx/8AFK2R972EMMRmoW/wt0OcNo/w9IQl6OVu83opfu+lDU1t1KuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFUPmF0CIwUsQMDjCmIdR2zmZbRS9cy2Rk6If1T6QeU=;
 b=BtJGL0xAIXh84/Gub9CB6kzmMwQ/f/cY+wBYnuGzs3kwv9gj/YtXQe9QpDQTujwvWz9mTs8OPZKzI3KCKyz7yJH9CVM4ays6BlQzhEZNq2/MFupUH5iDnCYEKHQeQ1vOfkwD6D205MfG3LxRcR/cvDlHElHvWREQ5uBrZnHEXXOIL8oq9MECrWhxWZqSyiF9M0OII6Sayj+581UqvqiROZ5Mr8820kLhxPTAU9MHbaRmt+oyXk7k+gBDLqaVhjN0y3meIDRN/wXKb90VyMET0LmDCc5MfiDspMw5F0Nnbz5Qc/SWestZH6ysl6HKTrlAEBQWlwTcyjF6HjUBXeBfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFUPmF0CIwUsQMDjCmIdR2zmZbRS9cy2Rk6If1T6QeU=;
 b=XJCxfQETn2YWLLY6pEduAqzu6fIVUw11S1cXiAulI9d0F7dM6so6dmJ58gPopPquTeCQgdxaltBdMD+dQv65NPaYWX5A/hNTJc5bpUxsyQRy8d9CeU6azaGZRIlUxSMQ5vVB39tN/g1XuOPIN1u00LHtYs/+2QviuqVmsdFEsKw=
Received: from DM4PR21MB3441.namprd21.prod.outlook.com (2603:10b6:8:ac::18) by
 DM4PR21MB3610.namprd21.prod.outlook.com (2603:10b6:8:a2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.4; Tue, 12 Dec 2023 20:13:37 +0000
Received: from DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::424e:ad61:8198:101f]) by DM4PR21MB3441.namprd21.prod.outlook.com
 ([fe80::424e:ad61:8198:101f%7]) with mapi id 15.20.7113.001; Tue, 12 Dec 2023
 20:13:37 +0000
From: Steven French <Steven.French@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>, "paul.gortmaker@windriver.com"
	<paul.gortmaker@windriver.com>
CC: Namjae Jeon <linkinjeon@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for
 CVE-2023-38431
Thread-Topic: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for
 CVE-2023-38431
Thread-Index: AQHaLTZ0FraRoh/tHEGy7qr1Q4udKLCmEtOw
Date: Tue, 12 Dec 2023 20:13:37 +0000
Message-ID:
 <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
In-Reply-To: <2023121241-pope-fragility-edad@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=87d6b1cf-e384-4069-b94f-2c6ee911ca8f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-12T20:05:59Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3441:EE_|DM4PR21MB3610:EE_
x-ms-office365-filtering-correlation-id: dfe7a82a-83c4-48b1-c692-08dbfb4ed35d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 x19MncGjLRKcoyS9F2D2IQ459opVzLS5fzCbTQWvaDxOmQT8sH1P08WAh52fnFNYlfHrYcJQfOnAuFhafXXqjZvrBlFLfDd4EQFIKkyzC9s5mig+Bjx/xp6tqiAJ0KVr48HgDquigRbjNvtO12P5oX/dLETuF/KTu/3PpYMrnvqMB5Lhy15eBKlHQvcmTfr6xsdcCELF1HrnFKb7M0Z5gN9w7wWqwdMZzEhzymYBkrPgHZdTadH0LFXkT9wkwgDfmzdFxsgTc4e5/GIv9L4IdPMvQxXUPEojWXr9J9Pm6/LXV1Tx3cJNgVDtmbUhhzxfTL+xLEMGW5hbPe+SCS8Luk61ASTOcNFHKkrMhrABq5aSRBdsJ/FjUylZHRM62EsRZ8Wp0NbEF5ooyNBbrFk9BUi16szGkDKwAX4SE1/xllmmAvzdwpreE98BbH8pY7y7LZjyzO6SQSP77QA2iIb+pYafaU5r9mrIhmplfNcy3oTkzJkoyLpHClmC+bO0gqImnAIDndg98036bD8EONMsps/4ZZjcZuEWywQ/OESJbAuP4+QLG9Pz5ZWvad6QD2plevEx0svqWQtvYWv9vzc941LDawD98NDKmRE4SikfsXXzWg1VQGuD4WyAWzkJFVxIFsmLHfkabRIicWl7HqegoAoHje8JwzS3vHCWov4J1ccCXEnPYOEn8K7QkCSR+Ju8BOHLJpBGUC5z9PDiErDQtg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3441.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(55016003)(38070700009)(33656002)(86362001)(316002)(76116006)(66556008)(64756008)(7696005)(41300700001)(66446008)(82960400001)(110136005)(71200400001)(66946007)(54906003)(82950400001)(66476007)(9686003)(122000001)(5660300002)(83380400001)(38100700002)(478600001)(4326008)(2906002)(10290500003)(6506007)(53546011)(8676002)(8936002)(8990500004)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VhJzKfXTZ3/0bumQE3jyb5rRUAJvZVc/Gsa3f9w8Nx5smnPjoHtOrz//6xPi?=
 =?us-ascii?Q?NBtPpz/jPud50JdscJ1mY9EJRMyg6EqONZGjayVHs9D97Vuu8hUx/UTBUEmv?=
 =?us-ascii?Q?1h3uXsGujFJTORDd/ToYN2OOIMg5SftO08mmRoMfYA2raebSPaTn8JZjuseu?=
 =?us-ascii?Q?K4eOUlZaYyEMIGvlHpA9fC1Gk/SVspdjYogWODb5+W5XRVEvO7W3UzZQBWh/?=
 =?us-ascii?Q?5wgi+mn0m2aqK4bR5kO7f7OYjpmULnY/9kcZQGdkXsA5K6igkgVcqfllfbV9?=
 =?us-ascii?Q?iTSdConAEX0yyVVFKOYeFVGD2qKcVogonpPTq5x495DyPFgfUNWG5Fp3x61N?=
 =?us-ascii?Q?Pk1R+IXHFn0/V2TrXQU1Wlb79cH1o2v6TQYf/6Bwg85zOhG0zZbrymIj0Y9b?=
 =?us-ascii?Q?uZWrUsc+Gy0gWLHx5M8Nrdd93ta2eK7/6mLX6T/ZEhR6VRipGZtxqhJ/upuQ?=
 =?us-ascii?Q?Xl+evqo3Dw3uI5ixXLFSYlCgzSy+DREGOCVUhyvtu+MXapDUF2IaB6jruKzp?=
 =?us-ascii?Q?nhJxo1OoygNrybhWwShP3ZODI5mZSgPkssPY+F67N/TWCiy9UCOCwTRbdbJv?=
 =?us-ascii?Q?7znc/g4LL35ZKK8Tzbok0F6QdO6IqNx/KrOZqb77wggXuIrB3WKJM/8vUM91?=
 =?us-ascii?Q?swIgZaeb6bz++hEAG1BtZEspDuVl7K3oHrt/pDEW3p8iXH+312v9eqAkCv8c?=
 =?us-ascii?Q?C+KUJAu1YxnYtFrfmm8K9GDT4xv8g37DzI//gfCGh0M2o3lnw4b6bvx46Rn5?=
 =?us-ascii?Q?vFZVEZnuDzR8slXqWePPXdeGW1Gxq77sQ1Jzz4e8mK6aXoqNAkKnneXVVTMM?=
 =?us-ascii?Q?NQucz85pt/BnBI7gZ5A//FEQIelBesXVHaiAwdCNVftZveCndQ1Y3FVo1Wvm?=
 =?us-ascii?Q?X61Akx7OeC0vClpk/C57IkDikUbDCHx/t7nzAf7E/9ve7uT6IuThfWptbbWq?=
 =?us-ascii?Q?iPvLvpnfqY/V54qOdG5E3ZsLYOjVoauaCCJWKCvfljX89aUbr2wTEedus58Q?=
 =?us-ascii?Q?2zpaxgImJufR/GtfAHcW6Q68+DfIctsPcdCYyX7S3DKG1QI0ucC8i7h/WCTg?=
 =?us-ascii?Q?o0WtWlktRTVJprpO1BgcbcmGs5knnzt1P5oIEvCexWknsFtZiRMEuPISXAHq?=
 =?us-ascii?Q?1+/ygluPfFnRMoe/7uoe5aL7ce6xGr/JOt0Z64XPk9JeyJzQNZ97KzJWMAHX?=
 =?us-ascii?Q?m9G6EhQEPGsK8ZP7vaVkpIL/m+Nmd2HgIg84BcuLm4pay5kATk42a2TwuBnp?=
 =?us-ascii?Q?F6fflRXvO27Z73lVFyhzDtnQxOA6o03NoOkelTELADGf0mn1nU7fQEYZo9dp?=
 =?us-ascii?Q?MOH9TuXzgo5iTSzfCVqd/vUEef9lllU4FFO3HQ2AJzKYjsVz/QSmD7alk18L?=
 =?us-ascii?Q?Kw9sewCB1oClmvysvl5K92SDWajxrx5s2xGY6xGcaGYtNNKgDZzTswXUakHS?=
 =?us-ascii?Q?IdBVFTr1ZNhbwVjSa6y31s9ayFSzrf+8oIhLevP4XIcFmNVdkZGciQxCuiZK?=
 =?us-ascii?Q?GtDSimyAadteLC1K3n/G+SGO6KUZVsH9/zVXtBPgqhXcFoE1WFpITOuAnx7A?=
 =?us-ascii?Q?VdsJDr9W9JJQcwgjqiPhFszomkTVvDSFHn234BH4ant+gf8QINS7hCcp+9OR?=
 =?us-ascii?Q?yyQRHw7vJS/vPtQVR0mWnQAMIWBi5kIl2DO0WVaynS+G?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3441.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfe7a82a-83c4-48b1-c692-08dbfb4ed35d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 20:13:37.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwUaXfLw+/g8+W0bczL8asrbwvQEIgKWFDoYKqVZQ2+anxtcE85LWJRIcEHW11ENrMIy4h/iejj+vT+b2mm5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3610

Out of curiosity, has there been an alternative approach for some backports=
, where someone backports most fixes and features (and safe cleanup) but do=
es not backport any of the changesets which have dependencies outside the m=
odule (e.g. VFS changes, netfs or mm changes etc.)  to reduce patch depende=
ncy risk (ie 70-80% backport instead of the typical 10-20% that are picked =
up by stable)?

For example, we (on the client) ran into issues with 5.15 kernel (for the c=
lient) missing so many important fixes and features (and sometimes hard to =
distinguish when a new feature is also a 'fix') that I did a "full backport=
" for cifs.ko again a few months ago for 5.15 (leaving out about 10% of the=
 patches, those with dependencies or that would be risky).

There are arguments to be made for larger backports when test infrastructur=
e is good and lots of good functional tests (due to risk of subtle dependen=
cies when cherrypicking 1 patch out of 5 to backport).   In general, Namjae=
 has access to excellent functional/regression suites for SMB server (not j=
ust from Samba "smbtorture") so it is theoretically possible to do larger "=
very safe" backports for ksmbd (or at least make these available as an alte=
rnative for users who hit serious roadblocks on older kernels), if the test=
 automation were well trusted.   Is there a precedent for this?

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Tuesday, December 12, 2023 2:05 PM
To: paul.gortmaker@windriver.com
Cc: Namjae Jeon <linkinjeon@kernel.org>; Steven French <Steven.French@micro=
soft.com>; stable@vger.kernel.org
Subject: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for CV=
E-2023-38431

On Tue, Dec 12, 2023 at 01:47:44PM -0500, paul.gortmaker@windriver.com wrot=
e:
> From: Paul Gortmaker <paul.gortmaker@windriver.com>
>=20
> This is a bit long, but I've never touched this code and all I can do=20
> is compile test it.  So the below basically represents a capture of my=20
> thought process in fixing this for the v5.15.y-stable branch.

Nice work, but really, given that there are _SO_ many ksmb patches that hav=
e NOT been backported to 5.15.y, I would strongly recommend that we just ma=
rk the thing as depending on BROKEN there for now as your one backport here=
 is not going to make a dent in the fixes that need to be applied there to =
resolve the known issues that the codebase currently has resolved in newer =
kernels.

Do you use this codebase on 5.15.y?  What drove you to want to backport thi=
s, just the presence of a random CVE identifier?  If that's all it takes to=
 get companies to actually do backports, maybe I should go allocate more of=
 them :)

thanks,

greg k-h

