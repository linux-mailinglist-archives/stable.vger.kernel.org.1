Return-Path: <stable+bounces-159270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC87AF6714
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 03:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CCD1BC7B69
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 01:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D64414;
	Thu,  3 Jul 2025 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="b06FwABc"
X-Original-To: stable@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020086.outbound.protection.outlook.com [52.101.85.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ADA17F7
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 01:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751505351; cv=fail; b=FOPx2VpkrxxVTExphop54TZDWmz+UCgiuUxTnEr+kGhz0Q+XbmfCJea0qEimJGQWxi7jFBk2woeXZfGGa+COpTNi3HlaiD4ytAj8OdLMwFLlU8QRMvONaY0vab+N9ETPD1buwkv4X2bWAP1CewbjpuhEEpRUingByqcCmsDqIVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751505351; c=relaxed/simple;
	bh=VY9swJmhNYnK3ENyAkmSXutAlUQIKBQ1IwmDIVyRyIQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fc3E4NUaIyavHldFBXRXTNDawRMuNM1jqZiycVPdNKenxX11WPpx8tZNQh1TbI/R9Ogo8Bzb05jO7SlBoOStuJHoHg1Q6yaIGSl8V7+3XSFUHCKrC6FwUxGvSyAVTRDKt9ZOJn4jIEKskD5j/1g44e7jE4aNPUWKSvC+Bw8Ns5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=b06FwABc; arc=fail smtp.client-ip=52.101.85.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKqY1p6ezv/r1ZolTYBKQhab8HgMzyVgM3534m/qblT/tpGOntLseQEewIYqGglcXNf0jbjWMCxYcp7Ul4QN21uUNnzLlW0l62aY1j7tfFVLB4GhghYWR7shZLmrHlzyc8hxI2s6qrObwTjXXBR61pUizFdltvJ0+90qvoQG/ufX5PGvzK4c43E/e9lbD06wIOIA29nTzEyF0Q68WtdT3n56cPmxfLzEyalDOkOhfyBdKPdMXEr9BwP/YwhADE2RqIBDU/PxZzOcuEbbh0OR/8V0LjN0Q/hwpilZDup8ZCHXi5iqZ1MVa80jtR9yHYd3MqZDTM0Z/XIg+rpPln5BcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHVsVircOyXoJ3yN6FaW1iX63mWk871e1vbNVXUEvic=;
 b=Qo7m98fLEx/G0R7SRBkYJfboXpt51/AMXdkMUMf02c+Fgqz9SfERVYjZkTr49JOIftYbqEtYe0RVTbJ6xzntyzAk2zAIieRymThl0kBoPVLwJh49JpHCtHGEDmd9ytoZVzc5Tkcl1Sep6pcGvbM1fZpNhFsLyb7cdBay1ohkhrNudO9KkHxZnjnzfX6GeuAyK8kwl82L0Rssjq9YadsixmIdGktp5TNAPAFNzHT89yRP1YFM6wRI+iqj+AUGUP5KR6QntCqBGJy2/s1JxWENe2sZ1/1yNzoG+TP3U0yew9HrYHRejD97iUfu6tqqSPbCyPrD/rhpawJPKCLuZfYO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHVsVircOyXoJ3yN6FaW1iX63mWk871e1vbNVXUEvic=;
 b=b06FwABc2TNVlM/1UkU0xPrvoQk94x5B5w8qj7zsSbDgnAEYxv1kz93/8ic8ravm0d6sWT5a559DY3CirNzY/AqYoms26hHOX+4vUz2iFbyPdBDwPaeAMP5/gR+9c1ez5215tnDVbpHT3tiMa2wxcVwUERn1luweF7WTpjFn1hA=
Received: from BL1PR21MB3115.namprd21.prod.outlook.com (2603:10b6:208:393::15)
 by IA4PR21MB5048.namprd21.prod.outlook.com (2603:10b6:208:551::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.8; Thu, 3 Jul
 2025 01:15:48 +0000
Received: from BL1PR21MB3115.namprd21.prod.outlook.com
 ([fe80::7a38:17a2:3054:8d79]) by BL1PR21MB3115.namprd21.prod.outlook.com
 ([fe80::7a38:17a2:3054:8d79%3]) with mapi id 15.20.8901.009; Thu, 3 Jul 2025
 01:15:47 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Stable <stable@vger.kernel.org>, Long Li <longli@microsoft.com>
Subject: RE: [EXTERNAL] Re: Please cherry-pick this commit to v5.15.y, 5.10.y
 and 5.4.y: 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM
 boot time")
Thread-Topic: [EXTERNAL] Re: Please cherry-pick this commit to v5.15.y, 5.10.y
 and 5.4.y: 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to reduce VM
 boot time")
Thread-Index: AdvllVoB26Bwt2gvTKGjPCsNTOJcQgFkx56AACOOJHA=
Date: Thu, 3 Jul 2025 01:15:47 +0000
Message-ID:
 <BL1PR21MB311511454704263AF04C53B8BF43A@BL1PR21MB3115.namprd21.prod.outlook.com>
References:
 <BL1PR21MB31155E1FE608F61CFC279B2DBF7BA@BL1PR21MB3115.namprd21.prod.outlook.com>
 <2025070245-monogamy-taekwondo-3c95@gregkh>
In-Reply-To: <2025070245-monogamy-taekwondo-3c95@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9c57f4c6-0de0-401c-9990-f5e8b6ff8297;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-07-03T01:06:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR21MB3115:EE_|IA4PR21MB5048:EE_
x-ms-office365-filtering-correlation-id: 291eaa90-fbad-42f5-5e4e-08ddb9cf2465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?i0jI6gp7gycK1J1eTB0ykTZ77ZRfKeiK4f+gARuzw8pfnTTN8lFtTblUoU36?=
 =?us-ascii?Q?48LSHGNnDV6qiirCkc6iu5/3UjCUXVrIjHOYSf9xa3c+C6XK8dlb5hr0Gqfn?=
 =?us-ascii?Q?2X7q50qTrsewN+74oENcUFGbqA91RdKLKkk5BWnW7aTLPCtOAmY4UkN1P/gj?=
 =?us-ascii?Q?pqrU6jlZVb6thijPWYQb8NnLj/MB78ZEW9jsOe5MriN8r0sOdEZRxq2OcgBZ?=
 =?us-ascii?Q?21WsbVf6P3rZ4ZpU8cFeU++Kd+lyNGdDCfcs9mUiylpc7EHX/1dzxyC9vIOK?=
 =?us-ascii?Q?F+ZSAvsMceBYujA/jIMxLzXSboTo2xOhhhLxJGSbA6ruJBAMoqUvJLR1Y+yV?=
 =?us-ascii?Q?BHBv8m19BKqIZOkAsklVXDAgAC2NpU2tW8O56MMV7faBTYn/dH5ZkYgB2YiG?=
 =?us-ascii?Q?IBv9zNnD9hBI2cc/7Daf9B1xGnBWX9Q1X9DqxtgktgYwTtXYLSCOVMq3nLMh?=
 =?us-ascii?Q?ZssOPQ5eoJ/2MpARHzUOJuNGG24e9gqXjqnfb4Oi4/REEHBIOFIHOZjLPRZn?=
 =?us-ascii?Q?bvNUJG9nCI79rhTo7X3rRouZ9MB6ebgyDnO3ICcnQv2W8ySjM1C13NR0cVWB?=
 =?us-ascii?Q?ZeMeCRsL2ERsxUyQWq0O3fwOKXTQ7kw/WCbhL9T7IVYE0CEx+PpTBtOIFta4?=
 =?us-ascii?Q?wMoRLA4wbZhmwtqLH3EJpFs20BEeCiDtJex9NA/HpjauK1VS0KhfFFisLV7O?=
 =?us-ascii?Q?8ajwvIabv6tEH53IM4Usn9eYN4wIXroogmnAv5ECwaILVft4HVidQ2xnPUdp?=
 =?us-ascii?Q?QPGAiFRwWEK6O3qp4KJY9+NRWnT4j6OqNnwCVqSk1cis4LlHk7AdS50uTThv?=
 =?us-ascii?Q?wHI76TzFiy74xrpn9zY2OUAKmggR3Y2VkX7H983COcoLNoUk7k+4ALusIV6Y?=
 =?us-ascii?Q?Beiz/rRmXzuIdc2vXBZVulcjnEyULKsixo7DDl/jy6DbaOgcGchEh9DAICJs?=
 =?us-ascii?Q?rOkHiHADY9YGPaUUVNSvRXLgVyVh0R01odi+57e6UptK+N79uqxGyLHT+i8s?=
 =?us-ascii?Q?BLRFWam2Vm6oDRvfJvIKpu5ROAlvkZbn5EjSMbjkRcsJY/jCC1r8lpMUE0LL?=
 =?us-ascii?Q?Moas1p1V+/L2aFOMgr1ExjpQ9tjfh6IIQKITE+rvQAxBCJ9H+uqOS5iJ/Ec1?=
 =?us-ascii?Q?oKMFfwKmuqE8V9Kpd7wLiHMYEeQViPxDM4imuohfO4MWM9zA6pIyKFVBjd66?=
 =?us-ascii?Q?laWRyO+bPHFzde7deZyZfdg1TO4x03EJNhGc8mxTsG5wQWxgLolyzQkKYg5I?=
 =?us-ascii?Q?56nh7SMO1RJ/9DSqVjKCHunRdix64NFaQcD3hnHiR0fDKyhv9nkVL6xUq825?=
 =?us-ascii?Q?WW8+ZEVaBu52WtlWnX1PglWB0SqkCCWlf2I0ngxb0GPY8YuwPEHTtUpK/3V4?=
 =?us-ascii?Q?28VEY5sCoAVey9WSsxG+JeFOAq9TbILOAcGjOS0wFIJKtfG8XL8cBmc6P+pR?=
 =?us-ascii?Q?ikb/J5s/t+ZanjUi1/aLc7fLey7od1FtqqBuX/2+61SizZjcgN/x1g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR21MB3115.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nrGIwezsjb3AT2n42Oe0NF8Rr8vBheLvC5Nx3mKhEdrdklIllSIdUnxD+BOl?=
 =?us-ascii?Q?9148qivy3Avwr8zZ/kROKMTIzhs80z0tz0hSjmPkQbrodaaZqPwr377Jfqrd?=
 =?us-ascii?Q?6nUwHcohmKZU4uwECrvey1DTL9WZtFyCb9GFJcx5gINABQB6gU70NK+bJX6w?=
 =?us-ascii?Q?NMGpwHROWdGLaXOytJ3w0DFTdhnugB25ZI8FGsSIVAie3+2OnCRmyqqBW+N5?=
 =?us-ascii?Q?P/MnKmKBvNhZmF+DsfDWTRf9iZl1XVXvu2I6zBqhG3R+tWQWcJVSrZP24ZC7?=
 =?us-ascii?Q?MaBmZRia83pbrwuJosOR4hXUeVmZzzr4OzSPIn/eHydPyicVU+Kl4mO5UJcH?=
 =?us-ascii?Q?Fk/mSUocgcXMhx7nYvZWfkQqfoBQ1/o/fVKiramZH4774GTDBlV7F8Fap+yD?=
 =?us-ascii?Q?a2m14oW6vS7cgJV2qh7iI6bkZee9m1ZvCN90kSaYxgBxpxZX9LAEfQqJiUiU?=
 =?us-ascii?Q?imPJ2imv0MG4ZipMB4iPfpdqKgKN8AwAoYi++YNGKdmo7UMbm+Ob9ny0mf0i?=
 =?us-ascii?Q?o5LUbqpsm4p5QwbwsNsFRXPDOqW9LRnM1Vt+JdxrU40QOKA5K/xyAmACBOMF?=
 =?us-ascii?Q?t5SExRmhkdMA1mPCJ8yBbGaUeRaxc9uG0gPMWv7uetHWvCCvdHsRbrqaaxrK?=
 =?us-ascii?Q?9thBk77wMvNEsoeQ7ELcVDrV87DJwAoxmvRM96t6Mfum+zHzbEEjopJzrfzY?=
 =?us-ascii?Q?cW12DzcODNE0uh/epxozFa+PBsmdDEj1YH2Gr5UHmiAOI+faj5QuWn8GaIGo?=
 =?us-ascii?Q?4bwqTwF/1NFwE0RhKoJm2ccDYKrLcSWLRTw8mG8ZqTYZ/vReVv18h+Y5F84Z?=
 =?us-ascii?Q?TRGsFtAYghVw88AyyO74nG3IdDyTWWxiPTCbxIiGW+knxoUsyyOwvTwe9hrL?=
 =?us-ascii?Q?tPwew7/oHdvhpEW2Auz0zG8Vj3jMRU49fwx0qI81GONwQMRl0Awnu3KUzulI?=
 =?us-ascii?Q?7uxBbxe97pq5kxrdu/bskBHADEwbpKwHq5uWi5YSwYlpIDmOray/TOsUB7rT?=
 =?us-ascii?Q?VS2qjQmOKh0REU4wM+WmkLGT0Dhq0qw/FeAezwhMunk0QVYPRSUALE0LzCzt?=
 =?us-ascii?Q?T6TbQy5MmNCnLompVlrDCWOVLID5LpNvIc8rJKNM+siNgDu/aPX6C6RfCoVN?=
 =?us-ascii?Q?41F75EJUgpMOgWQFTrzmJmyoxreePAs/9VNZyEpMFhR1wVS3nNPhaiJPLBTp?=
 =?us-ascii?Q?kDiJvwubyF/SsOeTSgB0cYwVkL0lZx5QhhqpgovCXGu4ObQXywUgmw/xtQG9?=
 =?us-ascii?Q?WdjUdn+Y9OEbqUT8ZbGJmJw8mDqArd4gsbtWKxeeWtvpLyFH4oxO3tKcgOzb?=
 =?us-ascii?Q?Li7N2PvSm98yigYB7WU1szfYq8CoTzARPjVxmcuMEPeYtTWP41T1/2L4Tul2?=
 =?us-ascii?Q?3HpamYXu/FEnxVAU9vYBMKxZxQvqjw8AoUqmU9j0m86vFFaLCnYPZi/9SRRW?=
 =?us-ascii?Q?XOU4SK+fdGVmN2Npe87EPDobUNLirbQ0/MomOCWncEaayQQUdduQBVz4gU0M?=
 =?us-ascii?Q?Tn3lAoKc1VeDikD9Ek6fW2Lo+3DAcfhH63yqt0UeYxri7wndwB4/+UK2Izr/?=
 =?us-ascii?Q?qyyP0E7MW/deLcduWYlMtL4VBN7MFzlTI+xEfLBw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 291eaa90-fbad-42f5-5e4e-08ddb9cf2465
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 01:15:47.5565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UvnJsCiIKVFsQy/nppO6E43wdFejHdeiIi2rZviR3e5Jw+DfXC6gmumGZUin6nZkoThlUaNiAQgk6AHzDv8zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR21MB5048


> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, July 2, 2025 1:08 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Stable <stable@vger.kernel.org>; Long Li <longli@microsoft.com>
> Subject: [EXTERNAL] Re: Please cherry-pick this commit to v5.15.y, 5.10.y=
 and
> 5.4.y: 23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to
> reduce VM boot time")
>=20
> On Wed, Jun 25, 2025 at 06:05:26AM +0000, Dexuan Cui wrote:
> > Hi,
> > The commit has been in v6.1.y for 3+ years (but not in the 5.x stable
> > branches):
> >         23e118a48acf ("PCI: hv: Do not set PCI_COMMAND_MEMORY to
> > reduce VM boot time")
> >
> > The commit can be cherry-picked cleanly to the latest 5.x stable branch=
es,
> > i.e. 5.15.185, 5.10.238 and 5.4.294.
>=20
> It adds a new build warning on 5.4.y, so I will not apply it there,
> sorry.  Will go apply it to 5.10.y and 5.15.y for now.

Out of curiosity, I built 5.4.y plus the commit and got this warning:

drivers/pci/controller//pci-hyperv.c: In function 'prepopulate_bars':
drivers/pci/controller//pci-hyperv.c:1731:13: warning: unused variable 'com=
mand' [-Wunused-variable]

I think 5.4.y lacks another commit made in 2019:
ac82fc832708 ("PCI: hv: Add hibernation support")
but definitely we don't want to pull this commit into 5.4.y.

> thanks,
>=20
> greg k-h

I guess this requested commit doesn't really need to go into 5.4.y,
which I suppose isn't used widely any more. I listed it just for
completeness :-)

Thank you Greg for applying the commit into 5.10.y and 5.15.y!

Thanks,
Dexuan

