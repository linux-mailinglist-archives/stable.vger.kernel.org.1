Return-Path: <stable+bounces-50308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD97905A14
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 19:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 857F6285BAE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 17:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87180170824;
	Wed, 12 Jun 2024 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dHhvpS/U"
X-Original-To: stable@vger.kernel.org
Received: from NAM06-BL2-obe.outbound.protection.outlook.com (mail-bl2nam06on2131.outbound.protection.outlook.com [40.107.65.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EB2EBB
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.65.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213922; cv=fail; b=gbCJInsrrjF2//VgmzG3hyiD4XMWqCv+ADiigBmnQbikq1U4pPEhSrMHrvHbIOQ2pNlr6iGMGxD4TU4UzmlC0ApLCEzNo0ICHnNK2FHEahq0iGH19aNOsXvw/yTUIo5fYETf4gG8y7pAXR8Md7pUXIcBb5MmrQnttelcTdsnJjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213922; c=relaxed/simple;
	bh=lIRghCIr8H6Po2fUli47Vb2AJ7S11yO9jjGGrywDi/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FXc1jyM1UjGN4qH1iADj7H3MAlM1lTNBKixk7brnfqNDIx9tc9J52YpuK0AOQD7KwYYa1ewdK1QvuAOG02ZDhQCvgAZFYSfiOK+c2TZvX1flS1HUDbZuwc4HY5NyPvOxU9DsetvOGeZvV2OJJC+VEUfzAXBe64z5EW9qJbmyx2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dHhvpS/U; arc=fail smtp.client-ip=40.107.65.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg//kaOTU3ilGAb//+bmhA28f/87g4Z8rZqJJo56fws/qzb+Qzrm50VwXeY7xXEpz6C/eMgj1acAij8TCHo9B4VKsbXUB4B/f6LJ84BK/aIlMvzRjCXoDogtfWFjMEziG8kR5lhbq5vUGBhTDmKmPIWH1kOtum6rT3MopW+WJfKlGTm1sPibNkTSdvZklOEPGGqeN3sUzNkvu5yKQLK4n8g/EotPjGb+S6nvly+b/LDnU2k38CktyGlWiKxab6uDvDhKv/cjjQ0UJ18NjqGzKMZAEy6aw5vlyt8v9QImronKezsCSMjXDHDtYB2GrM4tdlEXp6OlJtwn21eNXnEhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyj4wzx+k2ZUjfo8c9nB4J3iF3i2hnMZKi1O31K/CW8=;
 b=bhAvJhpuuQxyHNLzwHSsmjNDkELGpJH3U8TVHEagx22PiJPi8cfsZnDrTDDIYIfhwVW7+SyGgDJCgKwWMPTFDQrYl6JFvRB0FOyux5X7wKw3P8cjYJlkmlg17wKm1wucIN3oDsPVcsoAJ3q+g/9ejRC2YB+xfAj54Z2FLDI8q+JV9P20VBtA8I7e0Dw1SPGGCIq51fNm+5nGcKpPVE86BbkGaMy1b2zkfrXVxEawcFFXb7R6EzZ6hhPpMnBTvyjwtHPim9oAWUr1SndVNC5JUTpd0ssPL+TPeytmxX7cUDNuvgYmcgPwn+afZ44NsqPlRrJigZdBOoiVd3g4Ry1RPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyj4wzx+k2ZUjfo8c9nB4J3iF3i2hnMZKi1O31K/CW8=;
 b=dHhvpS/Ull8K4MNWNYpvWqQ7E3q2v431WIBRwpx0K1BsnNG6kPSeD7wIMo805+TLrzqgtcQC+bfkReu6MKYGkN1tGk/I8PeMZV7GH4Rigl0re61HbV3Q8dyY8zdu73nQcEBkL0Aj3+YxJh+zPItf7ao7k22HeFVBvNIZpvgk1K4=
Received: from MN0PR21MB3607.namprd21.prod.outlook.com (2603:10b6:208:3d0::19)
 by DS1PEPF00012A60.namprd21.prod.outlook.com (2603:10b6:2c:400:0:3:0:11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.7; Wed, 12 Jun
 2024 17:38:37 +0000
Received: from MN0PR21MB3607.namprd21.prod.outlook.com
 ([fe80::3e36:f844:d452:240b]) by MN0PR21MB3607.namprd21.prod.outlook.com
 ([fe80::3e36:f844:d452:240b%5]) with mapi id 15.20.7677.014; Wed, 12 Jun 2024
 17:38:37 +0000
From: Steven French <Steven.French@microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>, Thomas Voegtle <tv@lio96.de>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, David Howells
	<dhowells@redhat.com>, "smfrench@gmail.com" <smfrench@gmail.com>
Subject: RE: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files
 with vers=1.0 and 2.0
Thread-Topic: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files
 with vers=1.0 and 2.0
Thread-Index: AQHavMcRBv1KA1AGQUO0gMRBt6xvHrHENH6AgAACgYCAACbfoA==
Date: Wed, 12 Jun 2024 17:38:37 +0000
Message-ID:
 <MN0PR21MB36071826A93A81733964CCB0E4C02@MN0PR21MB3607.namprd21.prod.outlook.com>
References: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de>
 <2024061242-supervise-uncaring-b8ed@gregkh>
 <52814687-9c71-a6fb-3099-13ed634af592@lio96.de>
 <2024061215-swiftly-circus-f110@gregkh>
In-Reply-To: <2024061215-swiftly-circus-f110@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=dd702383-3afc-4550-8745-656e6d20da01;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-12T17:12:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3607:EE_|DS1PEPF00012A60:EE_
x-ms-office365-filtering-correlation-id: fa5c6335-c398-4b82-fa20-08dc8b067dd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q7EfwXpkwdTW0b/bZ1zFjAOsPHN17e6vdX6ubDptfSUG3SyQAd+FF1ZCZV8e?=
 =?us-ascii?Q?7yw7J5YmhKkfVMOJ7J50M61thrRle6/9VeXsdso9HoA5pnmeBXWkMgyIw2OH?=
 =?us-ascii?Q?ypHCWpFpuBm99yCqbGfspSlISz7RFkgm9cuFe10oriTHvHZ+sV+jFKfPNHdt?=
 =?us-ascii?Q?F0+KV6HiNAi0EWKnHeb0qhtinVcUInVHpLMf54ppd2N1WaSKkotqtxw4r1Gn?=
 =?us-ascii?Q?sNSIOTn0/C29CRotIP0eKRKrIz6DPNQkqwQdzdJKakLwfuu4qc6sRbG6s8v2?=
 =?us-ascii?Q?4lnI7Nh/X+NYjkqlU+zmkVo5z2Mripl4pfPxOLVsyeEPhWGjcJV4Y76HUpou?=
 =?us-ascii?Q?TsKQPlvAsVF1cDJWQszIGkz6Pnm3UnnOMGFAEzPU6jTHejloxbMIfHyOg0ZN?=
 =?us-ascii?Q?Rxdz6NU1hIetiI3/HzNw9ov6KrrLiBUBXrfoCvSAc79HJNQwu0fWbx3V8Fr/?=
 =?us-ascii?Q?XqmEReVVetHo91E7I08hlrPPbvUERiNEA69fj9ZT9qFlOqQtqefaJ5aFPTk6?=
 =?us-ascii?Q?RnwMJjJ5GT3nIHUT11D/iJK2J7+KN829l8Wfy/j2zuQXT1f7SxdkffXyMoIU?=
 =?us-ascii?Q?2p9xAU7HS/Dv9rDl9hvNc++E2ewvh+nUalr+VPzh38SKjTKUVx+Xp2Yfs+fS?=
 =?us-ascii?Q?iBRgcCnfs5q4x9yHLJJTG/3UQYfSqXqDYHKw6nUAzDInR0L7ZHqhxJZ+wEtu?=
 =?us-ascii?Q?LAl8zBP7tq/3aLd7sQugs6q1/liuqSouQhMnUoD7T6P/F+eAiVTlHY8ByXtR?=
 =?us-ascii?Q?o9C8u+JAfkomCiYNNGlD+HZB+Fk2TUL+0CC2YLbHNwdSViooS5ZO/uDCGKwQ?=
 =?us-ascii?Q?P2x/rxb5MRiALIChOkggTt3hw9NkbSd3h5AxfUC/+MyzkDIh/Wi2vK4orZOe?=
 =?us-ascii?Q?G3SPHr7uHBpgA9KvTaIaeLbCozehyi3iqPAodG7lxUPmAW0+3Vn0XQJN5aXL?=
 =?us-ascii?Q?Xr/lA9pj5RrGOQczCN3X8a9ExU2s4vC1h0INPvoSbX7vHtqFdHmi3KlW1FuK?=
 =?us-ascii?Q?O1jdJWbB30JJijGiJbV0EtPSi3bTHPuCO6m0Ul2Jm866PtYhB5XE6p4BE9c7?=
 =?us-ascii?Q?FpdVg+9hesm0+U1Ee8OvMUCRHZ9yZ/UZg2CLswQPxkjR8uugz0Fed4TZM0Jl?=
 =?us-ascii?Q?Wpz+BagYlV7KsXTbAdKpokEnfzBVo6bUWUHJSj7/loNk153DDx0MPX26B0Lk?=
 =?us-ascii?Q?EnLK5gEJQ1j777C9QgXr8IejGWEDdON8aYcpH3Sx143M69ZY2Jni5ZB2qWOi?=
 =?us-ascii?Q?BJLC1Y3ewWK2T+vurDEywXdn+wumQSwrjLrBzslIsnr42QixGEuiRf+/3BS1?=
 =?us-ascii?Q?UHNbBml0bvInTUT2yTGwGqAjHNp8anoAIeyoVSR+k2dRrV1T/Kr9PsV8mvHA?=
 =?us-ascii?Q?cM/Kku4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3607.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5MeQvvHXiZUG1acFaVDYxMdQWRPQ64tih3l1DbuMD7Q3xhJ5s/QmcJJmgd0s?=
 =?us-ascii?Q?eBuzGoY5IrSNaq6HAOLyMKlk9hXOa+d56w5/149jybCsAX+osVneYJ+0wQMJ?=
 =?us-ascii?Q?sAWFR8SOWDjrYOcAnXNhx7yte9z+P5adB5+/p4pXL1A95k/kt/dE/Wn0+xes?=
 =?us-ascii?Q?BjPxUdwDxGPsf2wYXOjTnGXi8DwycTuyB9YMrF9dlOv8ISldtZIBYBrchOKt?=
 =?us-ascii?Q?pTA7lO/v3hvu7M618ndDBp5FnZ2lhsREzu5TJdhMVmUuWJkAXNH8gDwFrLTY?=
 =?us-ascii?Q?bpdUDcXxIRMq62vYKy+JA8xsY8w85cks/WZ/2p5rh2329+RWsDIcF7/7Ccn9?=
 =?us-ascii?Q?F3sOEyOkzwP73INBuCbqzDPyePUuC+M9bUhj9YMo8XHV+9+1rke0QvCP9G2N?=
 =?us-ascii?Q?7O23m5JjxspAFLw4aFxwv0ToL/ggaVEqImWS2wsALOYwMoGY4tc9GNYaJ0y1?=
 =?us-ascii?Q?PrhMWkmPiQ5/JbMH4gWKwyqUSi4EI4VQ/PCdsmEC60Wer9Hhf4SxZfs7jfFx?=
 =?us-ascii?Q?XYJ8s6crAtROCFErWRRzkG/JSA2Ix0i92uuNmPxk1Ntc5uo/7xAb5BPweSmr?=
 =?us-ascii?Q?b97U3dQrdEs3AzxR/l1bky0x6n6eeTSyKt1S8YjYvqcVp81qymF6rYLIG8Lp?=
 =?us-ascii?Q?H1uvPN7zYyljgArf+Q9MyRlDuCuGXJSwou+e4K17b5ubs9iBaWf4DVdntRd/?=
 =?us-ascii?Q?2yhIoQGYDDWlbSwnP3sr4JhTyIcwO8csDdTHHQouy3X1JLUY38WwrkVeSYxR?=
 =?us-ascii?Q?3N7jUkTEhJUs/Hczdmilk5lZ+eNAP2UJOE/HSAeWagrxFPVuZwVxiSuIzeLV?=
 =?us-ascii?Q?urBqwzO52NN3Rq66pSa6+e5xY2fDQRrCBIT32ao5jx4oXe9628+9+u7fDKsa?=
 =?us-ascii?Q?/MAC7MpT0xHVEZf74qmoXNsZBzmEIRKeyCcnXToPPm5akoidNc6C3JBCgtyy?=
 =?us-ascii?Q?N/AsFLJpDfCf5QG/RiIC5k/z4S/39baUecVi6mL35gJePVYxCdmeBxF4h3+7?=
 =?us-ascii?Q?JAOBz+zBAafyas1wxk5zBDo2DzZ/tbHM9dhp2i5bl9Lye/j6adYOiFq1OMdR?=
 =?us-ascii?Q?B0MInX8xgys36jGxF2EGGyWqHo61XMOdVtH7+WkadI9jKLWo1sLGG5gsicSW?=
 =?us-ascii?Q?1/B1dwiRVW1wsx9MAjUBOWp/sTvcJ6lD1dwZApNmKCdBNctQeHgPKiUIsj6B?=
 =?us-ascii?Q?YHueFnLRnnf3qAHIPjvupsPgH01beBO09+r7t+ChGqyXQCN0xJNc369shyOm?=
 =?us-ascii?Q?d+CzfNZu0SFUWbB1yFhR7esQia0G8ucumCaRdBnByeZu3ljObXwc5fuzr/PO?=
 =?us-ascii?Q?Hrha5Ft5GyoJo14Z7b9qBbzv+IeyJBvcrPxbYg2qKAWzYMG8EHpek9ufoghi?=
 =?us-ascii?Q?ea3mD/VT5YjAntTB/rM+1ot7e1VQJtVrE57c6gfLzeSHtsMp3F+bIxLTaGcN?=
 =?us-ascii?Q?VP4ZjLoan0yzOva4lYQiDK/7Nyf4pTLEtWCi39P4x9+65WW9no9GTrXGl9gA?=
 =?us-ascii?Q?kSIo0bzSqIMTLvI0A+7hsbycHmswzWL80b0v3Qv6vbHneeZoqC5gHZ+oop7C?=
 =?us-ascii?Q?RtAJik4pVfOMPxKvE2elQH+WHCF36AZo3657oUQL8ejhrpu59dq4N55705gp?=
 =?us-ascii?Q?x77QDNtGTpQK+ENRT6i7d1RunTYebBP080ib7nu1lp10?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5c6335-c398-4b82-fa20-08dc8b067dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 17:38:37.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TypETY1QYC6r8YuJWuGdCWFuGrdtiK2DRIMgTGhy0R6+zdjpjM//fnzpURL+n585GzI6SbHliePpliWL8fAR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PEPF00012A60

Thanks for catching this - I found at least one case (even if we don't want=
 to ever encourage anyone to mount with these old dialects) where I was abl=
e to repro a dd hang.

I tried some experiments with both 6.10-rc2 and with 6.8 and don't see a pe=
rformance degradation with this, but there are some cases with SMB1 where p=
erformance hit might be expected (if rsize or wsize is negotiated to very s=
mall size, modern dialects support larger default wsize and rsize).  I just=
 did try an experiment with vers=3D1.0 and 6.6.33 and did reproduce a probl=
em though so am looking into that now (I see session disconnected part way =
through the copy in /proc/fs/cifs/DebugData - do you see the same thing).  =
 I am not seeing an issue with normal modern dialects though but I will tak=
e a look and see if we can narrow down what is happening in this old smb1 p=
ath.

Can you check two things:
1) what is the wsize and rsize that was negotiation ("mount | grep cifs") w=
ill show this?
2) what is the server type?

The repro I tried was "dd if=3D/dev/zero of=3D/mnt1/48GB bs=3D4MB count=3D1=
2000" and so far vers=3D1.0 to 6.6.33 to Samba (ksmbd does not support the =
older less secure dialects) was the only repro

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Wednesday, June 12, 2024 9:53 AM
To: Thomas Voegtle <tv@lio96.de>
Cc: stable@vger.kernel.org; David Howells <dhowells@redhat.com>; Steven Fre=
nch <Steven.French@microsoft.com>
Subject: [EXTERNAL] Re: 6.6.y: cifs broken since 6.6.23 writing big files w=
ith vers=3D1.0 and 2.0

On Wed, Jun 12, 2024 at 04:44:27PM +0200, Thomas Voegtle wrote:
> On Wed, 12 Jun 2024, Greg KH wrote:
>=20
> > On Tue, Jun 11, 2024 at 09:20:33AM +0200, Thomas Voegtle wrote:
> > >=20
> > > Hello,
> > >=20
> > > a machine booted with Linux 6.6.23 up to 6.6.32:
> > >=20
> > > writing /dev/zero with dd on a mounted cifs share with vers=3D1.0 or
> > > vers=3D2.0 slows down drastically in my setup after writing approx.=20
> > > 46GB of data.
> > >=20
> > > The whole machine gets unresponsive as it was under very high IO=20
> > > load. It pings but opening a new ssh session needs too much time.=20
> > > I can stop the dd
> > > (ctrl-c) and after a few minutes the machine is fine again.
> > >=20
> > > cifs with vers=3D3.1.1 seems to be fine with 6.6.32.
> > > Linux 6.10-rc3 is fine with vers=3D1.0 and vers=3D2.0.
> > >=20
> > > Bisected down to:
> > >=20
> > > cifs-fix-writeback-data-corruption.patch
> > > which is:
> > > Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
> > > and
> > > linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240
> > >=20
> > > Reverting this patch on 6.6.32 fixes the problem for me.
> >=20
> > Odd, that commit is kind of needed :(
> >=20
> > Is there some later commit that resolves the issue here that we=20
> > should pick up for the stable trees?
> >=20
>=20
> Hope this helps:
>=20
> Linux 6.9.4 is broken in the same way and so is 6.9.0.

How about Linus's tree?

thnanks,

greg k-h

