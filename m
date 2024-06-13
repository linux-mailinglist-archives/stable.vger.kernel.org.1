Return-Path: <stable+bounces-52106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F3907D27
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 22:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFF51C23BEF
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781CF12D203;
	Thu, 13 Jun 2024 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L/p0cDXm"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2117.outbound.protection.outlook.com [40.107.92.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA557C8D
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309257; cv=fail; b=GvZreCTeUOdHlNHHt5tt0QZz9aM3pFTVLJpVoaD4P2J3Uh3aeio4fwwktEBjZwi273XDaLjWhWN01lun/joeuE6lwoTu35EKMQKFxgBuBhK+cjBh/tVAqHI69zPFxsLXOVvQVV0Z89ITE8N1mBHz3l5lJaBsGXPO7ZR4NJOMlOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309257; c=relaxed/simple;
	bh=gVeFdFwQe1L3S7wD8rBZMoOGzm0R5h9Oncm5pXsvHaA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHDNCX55p7tcATEMYfFH24jM6xSWf9dzcNsnMVcKXD9C3cOL43q94LLXEsPsdKfnzGeafbC3mBFHwP/BuRWnpji+35HbKD/u/o1zlnLfwj/OoMaSgOb3WM4yTIx3k6fKaoSSD8Roru2dJDu0NS9L62Y55u6Bw+f+/+F6q1Piiww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=L/p0cDXm; arc=fail smtp.client-ip=40.107.92.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftbrbEA9+tfgNxpuFgD3ux+to9u6hPfKjYffzK4T7npAk3JDTFUgcHBc1kpaS6xpuAsuHvFaXuk6/aJ9n+FiCphKGR527HAUQ94aiNsRR9mWE15UblntUz+bp8gAMpuEGGUB4yTi/OEIxLgqsnwptuza3Ze4KbTLxfwUG+bp7MRXufpaaBrDOegUvKrzGdkvNO90MoFNGJUqVfzaLr2ypIb+bUzVfHqDVQCIjAAGtC0IPpCXzdkQrwP8soVnw2v6fOvfIocL44TDTtgavex42RdF2aWFWolVX4C0aTZmR5wkLDXHrJpbklQZLT5Qu23+bH3tA+Kl2Qx3K6gnnZJiEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0cADPGLkhoQNGe8d8zJMHYpQAjh3xZ5Jt+OS3thMJs=;
 b=M5KfBatGQTnN97SKxq77nxi2zTZuMH34iYuy35QAR/eW5Qq/2nKNK5Ex3YWvRBeDXfbPSBkyVvPLU2gWlApUMGlyT6TPMGIT2+dLOGkoerJgQWN5IcAPJVVbWmVHs4yxF8togVKRs9+GCaCpm0OCVXc5RbX+g8hISUv57qwpZXsl5IwU5wOhxVEklAxqnglYdmg/EGpMUJzRBlrw/S5SfFYZpUurWyo7fi6zzhGZvldC9XT6HYabAj9AES0VvaNGFxTMqQDn04/SjdTXMUydIGA7BBhqF82nMpx7Nr85pcSwvEgIzbhwUHpJ4OOG8rJFg9uLjinYWyE505zmGo8Q/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0cADPGLkhoQNGe8d8zJMHYpQAjh3xZ5Jt+OS3thMJs=;
 b=L/p0cDXmEoVZPS2YfwvB871Lr5ywdjdH/q860LCQhxxXS5wsy6pBHPkaW8OVob1YJ1WwfwTXylRPOyYXc6jYFCTUytNqIW2BqAKVIW2682yZBkoXQe+W4jkkouh53Tl8xIxAjHOX3LcO6Rf44BQPbTZm/5TuV8UW7C+SYORdCPA=
Received: from MN0PR21MB3607.namprd21.prod.outlook.com (2603:10b6:208:3d0::19)
 by IA1PR21MB3496.namprd21.prod.outlook.com (2603:10b6:208:3e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.8; Thu, 13 Jun
 2024 20:07:27 +0000
Received: from MN0PR21MB3607.namprd21.prod.outlook.com
 ([fe80::3e36:f844:d452:240b]) by MN0PR21MB3607.namprd21.prod.outlook.com
 ([fe80::3e36:f844:d452:240b%5]) with mapi id 15.20.7677.014; Thu, 13 Jun 2024
 20:07:27 +0000
From: Steven French <Steven.French@microsoft.com>
To: Thomas Voegtle <tv@lio96.de>
CC: Greg KH <gregkh@linuxfoundation.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, David Howells <dhowells@redhat.com>,
	"smfrench@gmail.com" <smfrench@gmail.com>
Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files
 with vers=1.0 and 2.0
Thread-Topic: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files
 with vers=1.0 and 2.0
Thread-Index:
 AQHavMcRBv1KA1AGQUO0gMRBt6xvHrHENH6AgAACgYCAACbfoIAAI/GAgAGEuFCAAA3FAIAAC9jA
Date: Thu, 13 Jun 2024 20:07:26 +0000
Message-ID:
 <MN0PR21MB36074A492D71AEF2CFA7DE45E4C12@MN0PR21MB3607.namprd21.prod.outlook.com>
References: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de>
 <2024061242-supervise-uncaring-b8ed@gregkh>
 <52814687-9c71-a6fb-3099-13ed634af592@lio96.de>
 <2024061215-swiftly-circus-f110@gregkh>
  <MN0PR21MB36071826A93A81733964CCB0E4C02@MN0PR21MB3607.namprd21.prod.outlook.com>
 <07f55e43-3bab-33fd-fffb-2b6a39681863@lio96.de>
  <MN0PR21MB3607C6D879D4A92EFCAB1664E4C12@MN0PR21MB3607.namprd21.prod.outlook.com>
 <7f5d7d2a-14e1-a33b-626d-d8e851a32b8a@lio96.de>
In-Reply-To: <7f5d7d2a-14e1-a33b-626d-d8e851a32b8a@lio96.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9665b95e-530c-47b5-b5a3-8a161f5b5e09;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-13T20:04:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3607:EE_|IA1PR21MB3496:EE_
x-ms-office365-filtering-correlation-id: bb7cdfa3-9841-416e-fce3-08dc8be4727e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UDFWzJ8vNJ2/5m7edpQFTh9JxTB9Gs3v/3npRfSlPzrly0i8Wf3SiHbdI/dZ?=
 =?us-ascii?Q?0X3i2nCC+tC/dvtcxsBX6OiIKjCHfFxp7q7cq0sRSjIgpbiZCZB3ZznkcmeI?=
 =?us-ascii?Q?5lqo8stLHJoH7T/tuadLW8gTqVG7vw3udUFtBz9apRpv3UsLMvFd4KiU+HqK?=
 =?us-ascii?Q?8ZF1ViIS3xWoMh0cYS0bK4s1v1Bwnvtk0ehBtuSTh6RdDlp9sXT6gNeSerD5?=
 =?us-ascii?Q?PAv2aagpPiJsC5W76N6qFRmXsGgILQK6lHnzDHGAiODNOuUhjvguE0xomQHQ?=
 =?us-ascii?Q?0wXOrtvLehd4nU5KzgfOLm19AqtA+37BG1r05N5W7+jRv/XETU98Q+67SCWM?=
 =?us-ascii?Q?6cKZUvTzGEH+2Rjhz3Ip17Q9OuxRTbfW/MPmGxJGmsh5b5+Li8gYpPiHU3Bg?=
 =?us-ascii?Q?Wk0eKGqFqkl+sTA2yuim5yLvUELjvRC3W1XFeKYwBbWXGJwkThm5pcKcMEik?=
 =?us-ascii?Q?57wOkJaGiXBqk7oPWODF6OWWOoXDuN9RAudPXVf58ZHWNlRgOUeFmBdNTkBs?=
 =?us-ascii?Q?nyP+sK1eVvOKrpvpk6UTtvalLJ8qLNR1mLxDuQwpRGLyIyYxTfEZ/dHzdCYa?=
 =?us-ascii?Q?kca9saUgnaA6S5gLNZtQF+KlJIUI5cPE193ahvl5OqBXjRFOxcnDKKaX5OJ3?=
 =?us-ascii?Q?6x9AmRq11BlyoQbdTGVk6LQnBiOaT0EJq/PAES3y4rBHAZZbsA5iS1RyLcM3?=
 =?us-ascii?Q?McNn3kV1VEmdMgvcY90CapBwvKvkpLCWlEmCRQIPQGW9n4fGJXefaOJpZmzA?=
 =?us-ascii?Q?sY+58XU20kfQmDCw7uI9kDxP36ILrGa0IYAobau5zo9tl1L2GO2Voun2IZS6?=
 =?us-ascii?Q?Uj7bh1ATZfqJbg8i+Ett3JFwK1MsTujkfUpKZyrURCXDOT6Qyk/UDlhMaTZB?=
 =?us-ascii?Q?emn00wJsvAlzb4pnCKuxCL2WnpCo/J3wAGA3F1p/KefX7rt5bK0pbNmwDvK5?=
 =?us-ascii?Q?SIm/bPmTx/Tzjp9DRYgz5bbLyb1VYL62Ds2xLtU2rv9h7Xj5aaflVk3X9WGB?=
 =?us-ascii?Q?S/2MTk3c8asqcoXh3pAjJDveulPklxMAx8+qYhrvpjDjg4mTrq4kAX2ubPCm?=
 =?us-ascii?Q?mp3yrtWFEByf91QbJuGmMgVxSRurGedgl1lplrHETHzgLqLeOt3B2eu6tEyu?=
 =?us-ascii?Q?2Y0Yj3JzEJkILiXy/EyBUQt6YL75n85nDjI8pFn7mvGIXeVFY87Ge+rwNu9Q?=
 =?us-ascii?Q?XWOVNohloc288yYw0AsSa8g5CQ4j9OLdHJ1In0fcoHct7MZS+71Z+cOFGlUV?=
 =?us-ascii?Q?aEba2RRwYdWZ9MZYjUacnl5OJAw49xr4Jwo9Kgdk7DYLQrJAjPji3JamznLZ?=
 =?us-ascii?Q?iGCZTbMounqcWRhyOjelGpuoZe/VBJRd//Oq2gxiVQcqwQjkItJ31s6Qrdt/?=
 =?us-ascii?Q?loOBUkY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3607.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(38070700013);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sklawwtZoWs5OmICpFxs7CkYnIAm3pVT3xFW67H3Xk9rxs3IelvQ1jgr3omI?=
 =?us-ascii?Q?QxZtHOa4IKIxUMvJ5y1BAq+CC6JNEz6/oWRq50GNOvcP9gSEJ6dCyGmJxB6G?=
 =?us-ascii?Q?l0wI8mjUoKSA91+Dg91fcpZIIt37PDv16DuwgkwcC8DGv1Xy1bQ8gSBE7TJM?=
 =?us-ascii?Q?H27gLQj8zP/kVExTGBTMHJ3OX2sJ0wvQnuN6//4+5Bslw04RomlyICuZr7OI?=
 =?us-ascii?Q?B9GMeaHUOd3dZPkxrby+j+LcMOtV1UsKc1W2ktdrTAap2yntkUI4D+3kjUra?=
 =?us-ascii?Q?l+UkTJlPFB00mlt0VrCZFlgaLObCkyF+0zxlJtefVWLTaFBW6gC1tcxS/MHa?=
 =?us-ascii?Q?q2Se/6+5rnP5rgewH8g+hFvzsBVaLFEEX/8FU8LLPetiK7Dms23zgQ2wlgUV?=
 =?us-ascii?Q?DewiiUMG5MAyiEJWBNKVRiPvnKMGGTFgxVrdBQRNZci4OjaMdoJCXWOAc0y+?=
 =?us-ascii?Q?qIpE/Gtqb7adBg8n5n4bB6ZrbFMztHYryH3+krnkw955wYisL2rvtKqY4u/a?=
 =?us-ascii?Q?nFuRwjR3LmW2hj9gNqKGuV9Rxt8MP+ZhAla2n1WI1DeFtYDO9ns4oPERQ2/N?=
 =?us-ascii?Q?ykchVyThP+AW21GgyEjRr9+GnHAshJBUeHYmqF9OAU4iWLnaqNSpGybvWE4W?=
 =?us-ascii?Q?1+Zp5YaCAS2LGgVp1XluJngL7wvOpCCYR0VlLsKHxwuls7ZBSebXF/D5Qp58?=
 =?us-ascii?Q?9vD/MBtKeGVMG8DyC4/IoCcNmcIlTPWuGd0iKPGYXoATJ5nmSoUfuwr9m8g3?=
 =?us-ascii?Q?xaTCg8S38lcRo1jANlUNFpdPC3soJhPKkNvepYLzesAbvI7lHfan0Ec9issd?=
 =?us-ascii?Q?N0Ejc4TouI5T+PibFCSlnSton5wKwY+sWwt/KeMlD5uZsscftZAIHXMkB+35?=
 =?us-ascii?Q?tWIbfs1TUXO/7jdKr3qiVwMkGCBmW55rrwKQytR/ou7ZBEK+uT6kXhsu83me?=
 =?us-ascii?Q?Rp7KtGMOOgwbqtvgjQyqLZA2ssDpY7r+Tmn+Z4oBCpi3t9U5CmF3+aoqH+4U?=
 =?us-ascii?Q?VLdJTBXvDp2TMcd2g0lx3CSr9XzZmFmbR0uFDtNoXvJRPQOmnwewnt/n4scA?=
 =?us-ascii?Q?qX/JmJncTmJRGO6OeI8cFycHMIgKBOJL3RKckRycjpWd0BTnyVbn7LGV+c5l?=
 =?us-ascii?Q?PzdRP4z1zAz8dMp2kMpUoAHAjZ3AElF7ibLTabG88s8PI5Hu+2kIjWTQ7RLb?=
 =?us-ascii?Q?WojR4wFQE8HSNwV+nVyzMlwrnmfsKxyxIespQeEwzBGbXBdnhkkBnnzkfIk/?=
 =?us-ascii?Q?tabsD5EoDeVZxtZtEQHf14+nKsHd2bxEoLEsKp2C6Y2MRztf8Qvr48Hpr3gP?=
 =?us-ascii?Q?ttSJ4nG5uHL0Q2zlVT8Rdqb4Z/cY3pNdB2QLolRx3Mx9+cY0vfo03z9v3tmJ?=
 =?us-ascii?Q?9PxHmkl4uqInjX/RYe5n4msPPoEerhNXg4bbcfN6CUNKSoid5KJzWZnXBx9+?=
 =?us-ascii?Q?5re/7jP6D0MwvZM7THCNjSA3tNb5rzyT+koUfl8r8BBCGP2bLzTVmSbseuNt?=
 =?us-ascii?Q?3WKSvYEpJxDSft/jPUmVX3c1Cd1l5MC95vLZ4f3tFeUffGxJkOGvR+2X6IKT?=
 =?us-ascii?Q?BeEHg1zspXtJu0D4+axL3Qdfs4r6lZp1zl6x5RyaTx860K0lN5GC0G/NK7fd?=
 =?us-ascii?Q?q7Ou9Yd4Utn7kpcCgW2SwmRAMAwvFmruSIQCJBkaBIHY?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3607.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7cdfa3-9841-416e-fce3-08dc8be4727e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 20:07:26.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRGDhO7mzilolHsvfJXdJ4iJn41jF1kA3SFb8Kjg4K/igQNDBnOfM5iSLgSZNug1Y8PC5Yjuqus1on5wV8lPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3496

> so I did a bisect search for the fix, and it is:
>      cifs: Cut over to using netfslib
> And that's bad? As I see it, there are many commits for preparation commi=
ts to switch and a few fixes. Too many for stable?

Yes - that changeset is part of a larger series (for the folios/netfs conve=
rsion) that would not make sense to backport for 6.6.

If we can have some better luck reproducing it it may not be hard to reprod=
uce - in the case I was able to reproduce it briefly yesterday, I didn't se=
e any i/o in flight but traffic was hung so I had assumed it was a reconnec=
t issue (a slow or stuck response perhaps due to more i/o in flight now tha=
n before), but your Stats/DebugData rules out that idea.

-----Original Message-----
From: Thomas Voegtle <tv@lio96.de>=20
Sent: Thursday, June 13, 2024 2:22 PM
To: Steven French <Steven.French@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>; stable@vger.kernel.org; David How=
ells <dhowells@redhat.com>; smfrench@gmail.com
Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big fil=
es with vers=3D1.0 and 2.0

On Thu, 13 Jun 2024, Steven French wrote:

> I haven't been able to repro the problem today with vers=3D1.0 (with
> 6.6.33 or 6.9.2) mounted to Samba so was wondering.
>
> For the "vers=3D1.0" and "vers=3D2.0" cases where you saw a failure can=20
> you "cat /proc/fs/cifs/Stats | grep reconnect" to see if there were=20
> network disconnect/reconnects during the copy.
>
> And also for the "vers=3D2.0" failure case you reported (which I have=20
> been unable to repro the failure to) could you do "cat=20
> /proc/fs/cifs/Stats | grep Writes" so we can see if any failed writes in =
that scenario.

On Linux 6.9.0 and vers=3D2.0 while hitting the bug and getting slower:

cat /proc/fs/cifs/Stats | grep -E 'Writes|reconnect' ; uptime
0 session 0 share reconnects
Writes: 887694 Bytes: 58072834560
  21:15:27 up 6 min,  2 users,  load average: 9.36, 2.84, 1.06

The last one:
cat /proc/fs/cifs/Stats | grep -E 'Writes|reconnect' ; uptime
0 session 0 share reconnects
Writes: 901903 Bytes: 58985102336
  21:20:22 up 11 min,  2 users,  load average: 28.16, 17.01, 7.49


> And can you paste the exact dd command you are running (I have been=20
> trying the copy various ways with dd and bs=3D1MB or bs=3D4M) in case tha=
t=20
> is why I am having trouble reproducing it.

Strange.
I just do this:
dd if=3D/dev/zero of=3Dbigfile status=3Dprogress

Something over 70G is good.
Everything else freezes and you hardly can interrupt the dd.
Maybe with more memory or faster target it is different?

It is so nice reproducable for me, so I did a bisect search for the fix, an=
d it is:

commit 3ee1a1fc39819906f04d6c62c180e760cd3a689d (refs/bisect/fixed)
Author: David Howells <dhowells@redhat.com>
Date:   Fri Oct 6 18:29:59 2023 +0100

     cifs: Cut over to using netfslib


And that's bad? As I see it, there are many commits for preparation commits=
 to switch and a few fixes. Too many for stable?




>
>
> -----Original Message-----
> From: Thomas Voegtle <tv@lio96.de>
> Sent: Wednesday, June 12, 2024 2:21 PM
> To: Steven French <Steven.French@microsoft.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>; stable@vger.kernel.org; David H=
owells <dhowells@redhat.com>; smfrench@gmail.com
> Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big f=
iles with vers=3D1.0 and 2.0
>
> [You don't often get email from tv@lio96.de. Learn why this is important =
at https://aka.ms/LearnAboutSenderIdentification ]
>
> On Wed, 12 Jun 2024, Steven French wrote:
>
>> Thanks for catching this - I found at least one case (even if we don't
>> want to ever encourage anyone to mount with these old dialects) where
>> I was able to repro a dd hang.
>>
>> I tried some experiments with both 6.10-rc2 and with 6.8 and don't see
>> a performance degradation with this, but there are some cases with
>> SMB1 where performance hit might be expected (if rsize or wsize is
>> negotiated to very small size, modern dialects support larger default
>> wsize and rsize).  I just did try an experiment with vers=3D1.0 and
>> 6.6.33 and did reproduce a problem though so am looking into that now
>> (I see session disconnected part way through the copy in
>> /proc/fs/cifs/DebugData - do you see the same thing).  I am not seeing
>> an issue with normal modern
>
> You mean this stuff:
>         MIDs:
>         Server ConnectionId: 0x6
>                 State: 2 com: 9 pid: 10 cbdata: 00000000c583976f mid
> 309943
>                 State: 2 com: 9 pid: 10 cbdata: 0000000085b5bf16 mid
> 309944
>                 State: 2 com: 9 pid: 10 cbdata: 000000008b353163 mid
> 309945
>                 State: 2 com: 9 pid: 10 cbdata: 00000000898b6503 mid
> 309946
> ...
>
> Yes, can see that.
>
>
>> dialects though but I will take a look and see if we can narrow down
>> what is happening in this old smb1 path.
>>
>> Can you check two things:
>> 1) what is the wsize and rsize that was negotiation ("mount | grep cifs"=
) will show this?
>
> rsize=3D65536,wsize=3D65536 with vers=3D2.0
>
> rsize=3D1048576,wsize=3D65536 with vers=3D1.0
>
>> 2) what is the server type?
>
> That is an older Samba Server 4.9.18 with a bunch of patches (Debian?).
> I can test with several Windows Server versions if you like.
>
>
>>
>> The repro I tried was "dd if=3D/dev/zero of=3D/mnt1/48GB bs=3D4MB count=
=3D12000"
>> and so far vers=3D1.0 to 6.6.33 to Samba (ksmbd does not support the
>> older less secure dialects) was the only repro
>
> For vers=3D2.0 it needs a few GB more to hit the problem. In my setup it =
is 58GB with Linux 6.9.0. I know. It's weird.
>
>
>              Thomas
>
>
>
>>
>> -----Original Message-----
>> From: Greg KH <gregkh@linuxfoundation.org>
>> Sent: Wednesday, June 12, 2024 9:53 AM
>> To: Thomas Voegtle <tv@lio96.de>
>> Cc: stable@vger.kernel.org; David Howells <dhowells@redhat.com>;
>> Steven French <Steven.French@microsoft.com>
>> Subject: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big
>> files with vers=3D1.0 and 2.0
>>
>> On Wed, Jun 12, 2024 at 04:44:27PM +0200, Thomas Voegtle wrote:
>>> On Wed, 12 Jun 2024, Greg KH wrote:
>>>
>>>> On Tue, Jun 11, 2024 at 09:20:33AM +0200, Thomas Voegtle wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> a machine booted with Linux 6.6.23 up to 6.6.32:
>>>>>
>>>>> writing /dev/zero with dd on a mounted cifs share with vers=3D1.0 or
>>>>> vers=3D2.0 slows down drastically in my setup after writing approx.
>>>>> 46GB of data.
>>>>>
>>>>> The whole machine gets unresponsive as it was under very high IO
>>>>> load. It pings but opening a new ssh session needs too much time.
>>>>> I can stop the dd
>>>>> (ctrl-c) and after a few minutes the machine is fine again.
>>>>>
>>>>> cifs with vers=3D3.1.1 seems to be fine with 6.6.32.
>>>>> Linux 6.10-rc3 is fine with vers=3D1.0 and vers=3D2.0.
>>>>>
>>>>> Bisected down to:
>>>>>
>>>>> cifs-fix-writeback-data-corruption.patch
>>>>> which is:
>>>>> Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
>>>>> and
>>>>> linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240
>>>>>
>>>>> Reverting this patch on 6.6.32 fixes the problem for me.
>>>>
>>>> Odd, that commit is kind of needed :(
>>>>
>>>> Is there some later commit that resolves the issue here that we
>>>> should pick up for the stable trees?
>>>>
>>>
>>> Hope this helps:
>>>
>>> Linux 6.9.4 is broken in the same way and so is 6.9.0.
>>
>> How about Linus's tree?
>>
>> thnanks,
>>
>> greg k-h
>>
>>
>
>       Thomas
>
> --
>  Thomas V
>
>

       Thomas

--=20
  Thomas V


