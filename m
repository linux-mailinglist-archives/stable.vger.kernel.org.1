Return-Path: <stable+bounces-178979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064D4B49CB8
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 00:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C66A18846E0
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 22:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681052DAFBF;
	Mon,  8 Sep 2025 22:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CFNqaDyf"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF732E975E
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369388; cv=fail; b=sl/tRnzmxZPMCYcahQlb7WuKbsQ7C6HCEDtuQIe9ZeaVEg3vbCT4vYNEMXeRWLaPLJolc/zRqAQV2KPFgEsJNMvKaigp8pk7L443pAHEtVOTCuS1J8dhhcG7zyGKPueDWJOTpxu7q4+im99xAE/1HyX86JayB51eh/XLPGyUxhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369388; c=relaxed/simple;
	bh=GuTeB1sPuL9jkKrP7qzstVznTF5QDkuapSIkP+bXf4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHg1yk7UUDs4jS2ckQoUtkK3WJFJmxkdx/D4Kvad3CQKDk1QpKwCnoNJMFFuAhTtabQ3x2jQrrHt1yiS2cqOaK/08N0YbPEt5SMnhSfjNr7jXoDg5JfJHY0SW/uL5OauCS5Vd3h/N0Lhwq+e5+UUBsOVZ8zm8nTrJcaLRv3bgVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CFNqaDyf; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQjB/4s1DSPSMI3woCAiv7um0JVzstvPXkIs+hssqQZKO0DJvHcnYcJm9ImvI8SZ4yY29yKUx5cImYJPe4Jy9Yk/fOV4mH9fPjrftI429vu3R2HwupktCudvNkm6mchS2ZoEgvcI71AjS/DCr9qniEhI07ib2a5qP2/+gyOpKRFXBsaVuXwewy6If+SREKPABPjQ5bJIKKutIvCU8PmhfJqxGnJcs6OoS49fpcfC0MmuNoNgB5KPhj4i/ZN8dolPy8dvHDj2P29R84hdfu6J/PQRUzKpTf9CLIykw2L2TaaIYyJzGWad8WTLP4kIO/XMxTSqKfAHJP27hN5fGHwJuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAg7ca1Jo9W5G2iPJ73dNwjkOg4dGTkRX9Vdu4kisF0=;
 b=kZ2fZDPQNKbOAb2WlX62Ma5o7Fs9aQ5zqxEZtVEDnVjXGseJP0cFaT9SPQS3ojPeWHebf0FMGCUdn0UHNomfzLGoYzsOf65seeMxbt6vOaajzs2fKRPQJOoGZCoL09FMhq6RgxbnAXc+c2wrC8bus3T0Lul1HxnLCy0DLFh19lJsVb+XTy0i0JDXjip/Rcr2ra4Gh/DNegCIJnw+uO9dLJykQuArK8zZxjlv+dIxgFeqnQ6Rx8MaPsRJtOm9LojDbZDHsbgSoX9AQn5eORcpfSh3p3ErkVAwAAaRnLLIOUj0rngmKQzcC3UkltzDP5kFJxvr6+UN4mZ8U5jh/xUMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAg7ca1Jo9W5G2iPJ73dNwjkOg4dGTkRX9Vdu4kisF0=;
 b=CFNqaDyfGBbR1n9w0wUJ6LJUmwHgR86myjU8tWgXMHOczsYbz5B+20wC6q6JCWgvBPADBrj7UpnaqXMv8clHAY9G0cGVB9IXZiNsVOAJOkbNgDdszcJ1TcC8hyB1mpe8WKjUZnyBUEsD2MIx1ZgRN8xYqD0viW5qL1fPx0+4Y9w=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 22:09:43 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 22:09:43 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: Add more checks to PSP mailbox"
Thread-Topic: [PATCH] Revert "drm/amdgpu: Add more checks to PSP mailbox"
Thread-Index: AQHcHef/8I8faftvakWLuhnneSEE6rSEBpWAgAXWLAA=
Date: Mon, 8 Sep 2025 22:09:43 +0000
Message-ID:
 <BL1PR12MB5144EE594B5DFA144D0FDB1CF70CA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250904220457.473940-1-alexander.deucher@amd.com>
 <2025090522-negligent-starless-d683@gregkh>
In-Reply-To: <2025090522-negligent-starless-d683@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-08T22:03:31.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM4PR12MB5746:EE_
x-ms-office365-filtering-correlation-id: b13a022b-a4ff-4bbd-9a51-08ddef2469fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3ca74okPHYWSeD2+YaqnMlGC4V/eAdjzmqE+a59ozZkQSvaDuJ9zSkbuDMBZ?=
 =?us-ascii?Q?+Sb+hX45vcm3MdDCOZ3fH21Gd+9JMCU0Hdb69GbcOqaS9L1EyzoKq0gQ8tpb?=
 =?us-ascii?Q?IZOZB4cYslIpyqJr3esM+ygjJd82MIoAQdKvy90KC9LUrkjAb46VV1A94iXn?=
 =?us-ascii?Q?oYyNClkKFprZ5955WxyhxFaE90jf8lhwKXfPsSYlA4iwKmVa7Wc47JnT6QDo?=
 =?us-ascii?Q?MPabiFTEYn2dWBdpZbCCdUdIqUZs1cDerJS5CPUgG57TP4SsdFQtxMeunBzN?=
 =?us-ascii?Q?403dcfPbNWoXKgDIYb2KKiWaYvtRQlTBpgBYvGO+DY1rqdLFscQc3jrhz2Zd?=
 =?us-ascii?Q?TGKe8RgHaQdFExtlso+v6Ia8fkpOj7uH3PbDL96iTtFTzHVXaw3CQvfZVfzn?=
 =?us-ascii?Q?9WtmFQOksSHk1z1L5TT7fVl99TndpxW1RKRrgURKrFYaSWCtNhGO8lmzh060?=
 =?us-ascii?Q?7AYq/5juNDt3SORa4pQQ2f4SJvbX2Ip0WAytTx00e86x+6/YGeVZN2nuEBWp?=
 =?us-ascii?Q?nhnINX4svBE9ISv5Nh+5Qif9dwqelvYTcWAPHfDDjkeuE/jgUZ87E7DJ/+ss?=
 =?us-ascii?Q?iL4i5m5XuJJ307EEVNZ/16U45g53WvZGJBj+HhaeagnTFEU0ESpfhoJwH7S+?=
 =?us-ascii?Q?J23GpeWMDUuoK6YhMCm39fcNFaG76Sye1bYQyVxTfYMLlZoHvzzzSFjDt2Yy?=
 =?us-ascii?Q?d2r7UOteHLMPwM/6cRY8pt5bqsgOVX7jPH0rDdvyoHkKWSY44Fvw1QBSn50S?=
 =?us-ascii?Q?67FA5jyB3+RawsGlSAUI/fgKXPEFjO8Eig8x26VvntAc8IYDx4QRthZB6GVR?=
 =?us-ascii?Q?BLh6OlJSCbG294A9gHdT75SPn0ywkActKDfcR/NBhTfX3uh6t6cuz54mXVsG?=
 =?us-ascii?Q?mqe618G6VBRhA0G7Ilr1er1gNdqCY5uij8ic42FpOtr8irGEEUAbl2oaGslb?=
 =?us-ascii?Q?reFGYyZue6kIabhlcIGwGjXV8uNJFabFDkgkIOjSiW0IEPEKO01DBQpYHE2L?=
 =?us-ascii?Q?3CP602Js7bAVcdg48Kq6YwuwgZe/MGrfJ/hGZhri/E9dbVG9/2cIljP2620O?=
 =?us-ascii?Q?O1uRpKE4qwHDpU/VqhIMy4IZxAoCpbE85lg0zGRLDsmOwxhfr18d7fwg7YQ+?=
 =?us-ascii?Q?bvbj37XmT44MyN7K07p1IwqvjvwnRURY3yJpsMFVmyZb8QYepCllO259qsws?=
 =?us-ascii?Q?YHYUuUX36rTp2xG7r8WOB/Son78cITXOjFyNT2ftJ4ZPQnZaLeQfpROkkyBM?=
 =?us-ascii?Q?n1WgcaPl5D+T8Aj1028IThVb4Savc7wvStzSOpMo2OZUHg3qsjObc8W0MONu?=
 =?us-ascii?Q?BQnhl2mlD+dGOL9R/rh7TKHOSDQ9ihUN9IawyDK2MeoqRhjcmnPcwxr2A0pJ?=
 =?us-ascii?Q?kq0RwoAS0RoHClz/ilP2en0qxRfuj5zJG6PqpgdanIdR2lLhgAwxmG7dIZ6M?=
 =?us-ascii?Q?GpCAfZdVkjZy2VyUXYcZkoLI9PBUWYVNdZyr1v9IFpdQXF1/QhtPPg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uFuolbCIPlJc8kYZkeyA7C0Op4tlvNPmjSIdj+J2n4MUo7MJg+D8Mpo+K71/?=
 =?us-ascii?Q?XsiEKWN2ZHh77aiBsoTnYnyJT8B8oSFl4YLRKKcMoa9f4ZGS7mGaPw+B8y1f?=
 =?us-ascii?Q?ReRR+Qkv3v30Uhmyd17YyJFZnRpcvaIvAqELii4fAsqdJERyiAlVkwuDs4tG?=
 =?us-ascii?Q?tgN4S+/BPO46hazW8ssDequ0T4s4xiUZ1UwLB4dm6PzDgvSxeU7j2siU9+wk?=
 =?us-ascii?Q?R9QPWSteh7p/UkcR+BZdELVqZmuywoB0P78tqRF7H2uEc5qy2MHfdDNbtrgl?=
 =?us-ascii?Q?8SpHLZd03b5e/y1vQoF9rBeevCMbL4QkoFwtfH+h9q4kD++RQGL7WHjwWkWQ?=
 =?us-ascii?Q?3nf6XllbBIWKAiguoTvUBdf6HXPhtWbPLsKd5bPP7s/qkOH4QJDG7mr0LeK6?=
 =?us-ascii?Q?1cQFX4udPA3+7i8/7ssp6tIKnWjDplWOC7B7wamy3dKVudYhKQlX//khgrHz?=
 =?us-ascii?Q?1/+TqiIQG4UorBPlSyiJ3kfMzyuyV3JSo6VuIs7kYBgkEeQDVTCa4HakrntO?=
 =?us-ascii?Q?KjmZn9q53FSksWoim22AVofhYr50c2F6llyTi8SPtqqxf96OpcJJ8mZ7hwOe?=
 =?us-ascii?Q?dWDxnI+kXK8K0ZSdGntvUFBtQMCNDxGNTvjsF+AD4pUJt6CBZPhENMQuN5ic?=
 =?us-ascii?Q?cLVT0DrjEFuK3pir7nIWJ8TUKIyGRMuvYpoyWSN+ITqjkJ2opz5KbNmPHih5?=
 =?us-ascii?Q?XViuXrYif2T6NhXy+5qKwz6JipoFs5doVDZ4na+OGUXS1Ws+cWQ2Zc7YbWuW?=
 =?us-ascii?Q?9fpPg0OexOtBLJWstY1IV8b8kzYqLoACkhSM9NM+wgyifKa8vavaxqxetu1M?=
 =?us-ascii?Q?u/CKMjFdYIVXKvT22yJxhxmQVbBekR5yuH/T4Fqw2oW/nkmCPvojI27FXEqD?=
 =?us-ascii?Q?NXD8fCCm3h8PtfP/k2tZCMYNtEdAqbrPl7JOZU1c4tJjta0yKcamt+2TisF+?=
 =?us-ascii?Q?7iODE0MBcEUL9jLb0PdNeMZ+kFFSS7oJzl5wlCEvjot0uqQv+1hCw6LHWm4Y?=
 =?us-ascii?Q?S5aamRqQdV9Vv6EHAKwLTHfMkQwe2fTFwduxc79/M+wCIokrRz/uPDiR1idC?=
 =?us-ascii?Q?0Z/TKQguMKKaPJJYXbMSYkx8lADBufTj8RmDQM8SIObmdvQAqEwK6gFfdw91?=
 =?us-ascii?Q?ajMyId+ukiULAtGoVJ+5bZKz7ZTEqGFMiJvbNXnvQVK4WuRT1PzEaxziGUbc?=
 =?us-ascii?Q?9scBTjJdOq/j5yuP9ZWzfimigDu55dXV57jwv4mMwicyIKSLZeANX7uiS5jT?=
 =?us-ascii?Q?jICiK8e+yjFD/5Y/bhTGssNz9kyydiSlU2nXnFDQh8qnwG0r8r8hcIJDJXK0?=
 =?us-ascii?Q?LSnrMBZLBTae66eZM2xm2XLzd+47It8hJleedeKA7ql6pPpWAYcJkCTNYVCD?=
 =?us-ascii?Q?NzkzYhhX03TTsq14NkekuIgzeyytHEp5RFnZAy5U3yrgp1IGs1U2pr/dKSx1?=
 =?us-ascii?Q?vciA+6rz0zD6Ifg3LKnN3EDRys/D6+fuNAxi9mIQxiNxRPSF5RG93512QMKn?=
 =?us-ascii?Q?zderadc5HbsIwZI1h1sW8NS84189+eHBguzeJs4guGbDs9S6JRQZ0qvPzs9Y?=
 =?us-ascii?Q?p+T8Me7lMWiJL5GFAmA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13a022b-a4ff-4bbd-9a51-08ddef2469fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 22:09:43.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wLrh0mHgIGdVF3gOinb7PJdkJtHuJm8EXLPHFOggEK9JLGfkR3mtXlY3Y2CfabOLHm0A3ctmVhrubw+Tgaezrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746

[Public]

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, September 5, 2025 12:55 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: stable@vger.kernel.org; sashal@kernel.org
> Subject: Re: [PATCH] Revert "drm/amdgpu: Add more checks to PSP mailbox"
>
> On Thu, Sep 04, 2025 at 06:04:57PM -0400, Alex Deucher wrote:
> > This reverts commit 165a69a87d6bde85cac2c051fa6da611ca4524f6.
> >
> > This commit is not applicable for stable kernels and results in the
> > driver failing to load on some chips on kernel 6.16.x.  Revert from
> > 6.16.x.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org # 6.16.x
>
> What is special about 6.16.y that causes this to fail, but yet it works i=
n 6.17-rc?
>

Nothing.  It's broken on 6.17-rc as well, but there is already a fix lined =
up for it for this week.  However, this patch was never meant to be applied=
 to stable in the first place.  Sasha's tools just auto nominated it.  It w=
as part of a rework for new functionality that was added in 6.17.  Now the =
fix patch for 6.17-rc may also fix this for older kernels, but I don't want=
 to risk further regressions in stable.

Alex


