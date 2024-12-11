Return-Path: <stable+bounces-100510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CEE9EC20A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 03:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2CC0284882
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76251BDAAA;
	Wed, 11 Dec 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P+HNYza/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="egdp84iV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="r2GGRf4w"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530478F3E;
	Wed, 11 Dec 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733883631; cv=fail; b=Qho9rdg6gBIN23KrNUNEYUP5L00ttakjjX5PNckcPr89rk4qI/fTk4iBAxVXlaLNua3ZQO4SmZGvpvC0DM55JHPx/C7Fjqu2ByBkR95UU+O9eDHSoGTrDntdJYz0UaIZE+AHEYUaNJDR/9QHh4TaGcq27FTKAt5s7uvr0DvVhLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733883631; c=relaxed/simple;
	bh=YkvVHPfwLXWc1ZBpTtJnA4GESwM60wl2Tv4u5ryGbn8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jf2gx9OTm/j9WyhV/rgBC+q0znnCEUkRcFSBuReaTDbY+WKSb8WE9A6svGxfRLPIahCwapw0rKNVQHJnQiwlqisz2k1NqkQMqlI6PGocoFzfhRio57k9L1tIaGvHW15N23SLH6WCojZEG0aIwL387yDcEQpsAfKPR8cMRyS4wGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P+HNYza/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=egdp84iV; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=r2GGRf4w reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BALFNOi000621;
	Tue, 10 Dec 2024 18:20:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=YkvVHPfwLXWc1ZBpTtJnA4GESwM60wl2Tv4u5ryGbn8=; b=
	P+HNYza/sZ+ENICw/Z3u0uLmIRITYO4Wypu1pGwsm2uOOQbCkpYgJ13xVmdgNy2Y
	ElABCy0H6EGiyDgZNnHVKy8vtW1Y7epWTC0KF2CFvR24uD7oqi+C0UJdTsw/3hQz
	67h/BY9f49jVfuY/vXBDsezrY12Yu9U13xrXMItJWWACRVqx/1GV6UF6+6bjJHkY
	0Xksgaq5jFBP2Uc2QIwaVi0exsWkRvYmgmZb9usUgYDFGgfagkSq2OqA9tXM2pn2
	mfVwoSyxQhMmyaDAMZPGBwwgeaftM2UGawxSFdv+D8XxEMmSb2nfErvyX35CC/t1
	TtxvIraxvf7UQW2sQd6cCA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 43cnvkae69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 18:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733883621; bh=YkvVHPfwLXWc1ZBpTtJnA4GESwM60wl2Tv4u5ryGbn8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=egdp84iVJIDqJpKkDHWFGOyObh/M/dO1W3Wd0jNEKgXn5HMxeqa/wkMaNUqUYA4pC
	 Bxw3P5LMwychvZTqPb3aLxClrvDSCNZ9cTCHsol2n8nt13XTaDHxzof2OwQAQIaRiJ
	 aeLkT1xwbIxYk+56o/obdnqZ2shD0EFDbBwWVYUxsj4hk5BQliN0xzBXGk0BI3GZuL
	 SYMjB9T1oDgWT9VK5wH/1WdRNIyRTi8JFOJNnALAtpyQiapWlUXc6vzaouMqeLCSKW
	 JZDmsSaW8wyhrj3OFdf1itsyGxZXYzWiWmSJGrKEE+trDBgjY6FK/FadhkoOYdfyZi
	 tv2ILUVWJ+9Zg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6BDDE4013B;
	Wed, 11 Dec 2024 02:20:21 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 03ABFA0063;
	Wed, 11 Dec 2024 02:20:20 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=r2GGRf4w;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E3E6A40347;
	Wed, 11 Dec 2024 02:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9T0Azgm5QlfRf41RqPyGrFCC0KXaHy0Q3DnR0KchkTlXnDOZR9wyQIFYdh+kA7Lu9QkGXZ9hJMePTkeIvSZJrm3VaRv2hGSiAjYKwavH4U4tmnQxFIxp7Be+TkROkIOrjvEheLH99bn6tFrR5DqkKGZMG0jj7K22r6Fex58hLmvW2pF4iZE+0Vt3v5yydzYDhVrYPIHxAXG6XI1YdmON561HI+1DDhj/rczS5uaqxtiSgAt8a/Ko4KbjQWMQyGuMl6xJsJZZ1pUSZrvuYvDNExFZZ+90S+/zg+2Vv7PRZ8vCUCyx06DFtgCfETMrEpMVf+RZ5+3+mqExuWiWlaPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkvVHPfwLXWc1ZBpTtJnA4GESwM60wl2Tv4u5ryGbn8=;
 b=p9wUdgfKWv6UexHUNNsZPKOhmM31gjz7iyw3l1HxwrX4rhKhQVR4m7NzTOeNF770vs2xyzCfG4CJBM0s19jBlGfw30Mtgp2QQtzsDS29ru5ziAXWhAw537fmS4oNKsrlkpS1sRyLDbAhoSJdXvnX9ZJccMR9GDlR78ZgCoiHn0oJP43YLtvy/Zu5b8xamX9t0hTahaC3rwIkfREbrS69TV13Oz0j4VvMEm5TSwvTIHCP6CIBpvPwGnTQGiDNk06BSw/WDV7IyvJPM3O7AaC1zFSBzhrRo1WRhd59T2ZGQyJVXVuoGvUZHn30/XraZk/J1UEwotqnF/M/Q4kNvtyKcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkvVHPfwLXWc1ZBpTtJnA4GESwM60wl2Tv4u5ryGbn8=;
 b=r2GGRf4wfKOYt5ZSaEQvsZwIB2OO0CB1CdSChrdGQpXK6No/FQgyQv3vVuE/877RGoWsrXcNNaLJEcTOzY8jWlGv3cfq37+ckjnVGl0Ecu0KF7wP1EH8GyGK9sod1Dlvfatli5Y1KSaM4lk/1S814ZRYynUfxrbuE1TPT8AY9Vo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 02:20:16 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 02:20:16 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3-am62: Disable autosuspend during remove
Thread-Topic: [PATCH] usb: dwc3-am62: Disable autosuspend during remove
Thread-Index: AQHbSikzEfaQlLh+W063PgCUQcWAGrLgUgiA
Date: Wed, 11 Dec 2024 02:20:16 +0000
Message-ID: <20241211021959.xoexyncdyiv7vpew@synopsys.com>
References: <20241209105728.3216872-1-quic_prashk@quicinc.com>
In-Reply-To: <20241209105728.3216872-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH0PR12MB8798:EE_
x-ms-office365-filtering-correlation-id: 9f22731a-d74b-44a3-6bc0-08dd198a5a05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXcvak5WOThnbTBBK3JGd1FyQ3h1TWRhczZSaTRDOW9GbEJKZGlGOWNOY0VO?=
 =?utf-8?B?bkt4SnVmQi9uUDRWZWl0SlEzK3hwaEZmbmZnU2h3UDdoUVFzNHBBRkJZUDdQ?=
 =?utf-8?B?M1I3RVJLSllHRVZERDc3aDM3TDViTWFKNWp6b1pYd3FsaEMxcnhpdENBTnJ4?=
 =?utf-8?B?bkZOdGdxT1g0dlVyWS9NUVBIaUM4a3NKaFZVVnpmdndrNm5GSC9kRjN2eThj?=
 =?utf-8?B?Z255MFJUbFZnQ0VBcmJheTRQbW4ybnlHUGp0alBtQ0F5UzJhRi9pRWNaUkVX?=
 =?utf-8?B?ZU9wV2xQTDFaRmh0M1JpTmVEVW94dGE2SWdoeG13VUwvTDdUZmszTEZldmcr?=
 =?utf-8?B?aW5lOTB3R05uVHE1dnZCRWw0TkR6anh3OGtyMmlTd1ZybiswZUVFL2RyMm5S?=
 =?utf-8?B?T3pJM05iOUtRTmJxbTFGRk50WmtoYWFLOWN3d0ZzVDhVbnlMaENSL21RUlE0?=
 =?utf-8?B?THV1ZFZqeEROREtIWTZzMU1ubWVwUVJsdVVselpiVUlYYjR0aTMyVmFqbjRF?=
 =?utf-8?B?RVJYa1g0c051SWl1T3hDVW5wS0dhdzRFbkpuSmg0VTNCdkYzazN5RWVEV3p4?=
 =?utf-8?B?YnE2OG1NN093ZE1qOVpndzRhYTdHT2lOZjk0M3oyUm9CdGxPUEQrRXZkM0Rj?=
 =?utf-8?B?dDgxbVU2Y2V2MHBQS2Y3SVZSdDB6dUxVM0JWZ3RBMHRzSDFIUzJ4VlpGY0FO?=
 =?utf-8?B?UVRmbXRveFpqY013VGJkS1FzR2dRNm96RzFSZTJyQ255RXR6Yi9WTnpObits?=
 =?utf-8?B?STM1SlRtRG5wdkZ4RTllY0ZONWN2QXJTWGFRUEhnWFQwTGVWdElnMmJtbkU3?=
 =?utf-8?B?cEZhcGI0OTAwOFRvcmpRTnhIYTU4eVNXOTR0ZkcvU2wrU1d0Zm9SZnJ3bEtq?=
 =?utf-8?B?bHdPczFVRy9GYTY3V09qeU9MTW01MnZ1NXdydDN3SmNIenJod2M0OXdyeHJm?=
 =?utf-8?B?cTdRbURnNUdoNlhnK3ZNWTlKRTNSelVtWlk4cWlSVHlOdTdtRFFpZW1Gc2lG?=
 =?utf-8?B?Y0d3b3dES0twcVhzdEZiOW1FWFFsZms4SHl5V3dWNEIzdzU2WHlpcTFFWUlL?=
 =?utf-8?B?SGVUV21HaEVYOGJXU1BMNS92OGR3NTB1OEVrZTFQeHBCQlZ2dVEzRUZkTUFw?=
 =?utf-8?B?RE9jL1YxMFZXZUMzUWNhVDNkU0JuZ29LVE1LL2R5L2Q2ZjdvZUhxUm1tMmFo?=
 =?utf-8?B?RjN1amFNWlFKb3QxMFR3WGNlNENZWXZQUnlTclJZMUdXNU12Z1BEamllQ2NB?=
 =?utf-8?B?MStEd0s4cGZBRmtkVGt5QVpXVm15TW1hdXBvRi9iZXlaVGpkRFkyVFd2N21j?=
 =?utf-8?B?NEJWNHZ2dnVKcUo1WERXVmVhSDJCMCtiVmsxUHJFQ2lObHNvd3kvaXMrbHZB?=
 =?utf-8?B?OUpnd0FUMk0xeWtnYXZjaVZCcWhValUzaUlOTHNIc0J3c2JnUlY3Q0M1ellH?=
 =?utf-8?B?SHJDL2xqdldzRkl5TEtjVjJRYllHNFppTFIxTjhxcTE5UWdLR2x2RTlnZHM4?=
 =?utf-8?B?NEdVMklCRUdjRjBXRTMyM2xXOUl3QU9OdytmMlR6ZTJjZXB3OVF6Ny9xcDc0?=
 =?utf-8?B?WndjblpZaFRPMUowQUl5VlZodVpaejR2eGd5UU1NaXRWV2daeitTVmhScXUy?=
 =?utf-8?B?NWFnOE5zRExiOTdXVEgvc2RLcU0vKzRSNXNCTGNUOTR6YkozMTVaSllUcmtO?=
 =?utf-8?B?VkFjN1o2RjFzMDhiZ3lMNFpMeDdnZFZETVhWRHA1NTBZd2VmcGNqaFZVWnlR?=
 =?utf-8?B?RVRpOGdmUGw3RmwrVTVDSk9xTXoxeTJDTjJFbXB1VUFScHB6aDdsSzFSdXM5?=
 =?utf-8?B?N3IrNUF5enhJZEFYc1ZwQ0NHQnU1akY2OHlhdlBDQmRQMTV0SkZ3ait3QUFZ?=
 =?utf-8?B?SVBuTUx4M1hFNEVjcVJZN0VNam9jVjQ4R2NVVjhNZm1jakE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2xTYm1sa1ZBYTc3bXUzUUJMSUJtMTgwdEx2U2NWSjI3ZjdzYnpsSWppSnlj?=
 =?utf-8?B?UUN0cmIxcEk1UlU3U0dPd0VjZGtES1ZiSzNORGwwSVRlaDdScTA2UmRkNjFW?=
 =?utf-8?B?emRRWmdMODVDM0pzdDRkaWY3eGtCbC9PZDBqNEdVcUhWWFRkUWIyQXNyaVI2?=
 =?utf-8?B?dEdRdHZ4My9VZFRRMDEvaWRXTVdrTDlsc3ZZRkFKMkEwSS9UWWtNa1ZiM3Q5?=
 =?utf-8?B?czdpTnI5cjBpZnBrWVF2d1pOMkZnNzFrUzNTYU1xWE5RSGNobzg5dnloTWtw?=
 =?utf-8?B?VitSeDJNMjVLdVJWcUVuSWtQUytiQThFM2NVZXduNU1ndUlTd3EzNUo3aDl2?=
 =?utf-8?B?VFBBdS9nWVNrZnJXcXlFOUdvL3lpN3NyRmN5YnpWcFFsazhBTXRyZm8vSFZr?=
 =?utf-8?B?MmQxV21uc1dVaXVUSk9nSlZpM09lMndRbE5NL1FYV0VEaWZBdDNYR0lMVnFt?=
 =?utf-8?B?ZFVEWnhtT2xZZnkzd3JuakFCVG9wZERDcXlNaDk4aU9OQXhZT25tNUcvL3c0?=
 =?utf-8?B?OHNsYmI4L1NkWVVxcFN4Y3FZdU1rNGFnaWpPT1U4eUtwR1FkNVI3UXp2QkJV?=
 =?utf-8?B?WWFpU1Fzc3hQbmFySWEvWHNVT21uVHowVE85V2RXY05wOWlLNG1vZitCSjBw?=
 =?utf-8?B?TVJ2OGM0YnVFMGE1bnc5STNXdkw5bkhjWlRCVFVZaXRSMERKTnRTaUZpRUU4?=
 =?utf-8?B?QW02SVdnejVFNm5OOUFIV1JzOVhoY0dDdU9teDh1N3dCeWVhcURIMUdNb09H?=
 =?utf-8?B?N2VZSVFlWktpcmZ0SnZTN3BPYmdiVTZadWNmcUpOS3QxOHZZOXRseE56RnhY?=
 =?utf-8?B?T1lNaUVOK2VGaXZGbzdoYU91WXdHTVlrNnYwMTBITEtpRitpU2MwNkxuUUY5?=
 =?utf-8?B?bityemJpaGZnRFZSN3g2eXVWeUM4Uy82Q29xYjhzL2YwUWFDUForM05tUkND?=
 =?utf-8?B?Nk0wbzJKNDVmRDZiVDNoR2NRWVdYWmFmSVB4MWlGbWY1TVY3cllPUk9ZSmxV?=
 =?utf-8?B?KzZLNklIcFR2YnVKU1Y3WUYzYm9vbHVudEdpa0FNUVNpNnBob041VkxpTmd5?=
 =?utf-8?B?UHRINVhGU3BaLzcreDRRd2VsVFFjVWtXTGFOK05EVXhyYzJYNzhkaUEwRHNn?=
 =?utf-8?B?Z1Rnb2JMc1RiVm0zUHIwU2RZa2RvZXhyeXUyYWNHVjdJYzFsMDByL0I1TTEz?=
 =?utf-8?B?YVVwcGtVQU8ybGlWL2VGaWxxNHlYVk9JR05aL1NsdHhwdGdiZ21JUVZ0dkFX?=
 =?utf-8?B?SkpQZXh3bjIxOEdXQkF2RWNSQmtEbTgwOXBiNk5XdS95aFBtY2Y0VHpaVXhu?=
 =?utf-8?B?SkxqQ3RrSUM0MnhqUUgzckQ2MWQyOXk5LzJVUTZrMEVPRHBWekpwY3ZOalM1?=
 =?utf-8?B?eHk3d1FiY2lZeitmd2tFVjNyQWZ3NmFUTGw3Nm1BUFUyeFFLOHg5bjRDY3U1?=
 =?utf-8?B?ZThrRitwRks5TFZKVHJsOU5NRVpmUlpHQWtQbzhxb0hzRUdINk1Qdlg0M1NY?=
 =?utf-8?B?YzJwNDFQOE1NeFJLS0ZCVlprSUNRcEM3STZSTzNHaVdBYXlEQXhNWEkzY0xv?=
 =?utf-8?B?blZjWnM0Q1liMFFXRlRBU3BtaTVnM3FPSnY4V08vUWIrK2FIR0dJSVZySGJV?=
 =?utf-8?B?U1hZUjZ4TTkyUGNoZ3d3eFhqakIraGRuZCtoeGNBbjA3K1p4Q1JGdzl1blhr?=
 =?utf-8?B?eVN6MnNHd3N1YTlGdnU5bXhJRjZCTnBuTGg5T0wrTURmS2dQbDlZRE9JT3Zm?=
 =?utf-8?B?VGQ0ZzdQSEVTKytFZ1dFVU1HcXM2dTFjQ2dHckUwRy82SW9SMkhkVU9xZnlV?=
 =?utf-8?B?ZHFrTXl4MWxybXo0VTVzWnFoMzlVV2RpZWZ6T21KNkFWUXA0dXJ6NjB5MWJp?=
 =?utf-8?B?NmIvMmlPYzBLRDNnLytmZUROSVVKbjdnN0dlZ0lXaEo3bjlHOG5GTXpGbmlU?=
 =?utf-8?B?dVNHWjBMTUxTdE9HbXNGRThoUjVmWkNpbGZVaVpqbnV3RUh4QmNuUU5hOUg0?=
 =?utf-8?B?ZmJtMHFMK0J0UWRnMWtZWjFmdWNqeXJJMjBaTzA3cHl5ODB3QTVxWnNUaFN3?=
 =?utf-8?B?aTFjOFB5ZnlpWk1IalY4SWhHemlvWHB0d015SXphYkdiMld2ZTBIcGhrZkpv?=
 =?utf-8?B?eEEwb0FxVE1HVDRVTTZsRlJGZDl6ZnBNK3NVcWdQVjl1YzBoelUxSHVCcGRX?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2830CA32E22F548BB038548441ADA2C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6r0wd4rbFn1HzOOrjFMHrt8VsggU5AW9jcDU0iDmU6mLG2PUZnGyhDc6jW1F6U/Pkw829pDbJ/6uOWAURhjks6tQ8p7SLY8Dsoyu0NSNjgkQ5io07m1lE+cbCNpJ8RNCbK4KaNGdFUrn23OIEFt6PrmsMVnIjyxKb0v22PBVdS/aZPy1nWVPUX1B1Rn8AuaE1D1ian7cdJButpZXjR413Fvqj6MLjZVltnyNbJMdIwDimsDStBsySXvEq4JWlkLfmv3LBP3zh6/ZA5wnlW7BWzAfsZulgarmbTZdEPO72/4aARqCpR7ZPjsnKRbzrwVvsMN4XAO0cMYF8aPxIKdK+8s4k2O9GwLRP3bRBaeJFtn/YfhMVWhrHqXC72BOn7rMNKEOWdJ6zShSKJBXkD2ZG282sSihKNxo2JXIVoQeRVt7/EDaIHtcfxeCKz+3JZvLzX5QFhlPQdFMx0udBM7viTdUp7AJ/y8QRDnhi0VJSYylpkXelSDyI3N4em70w0w0PeIwLM8a1K09bK5kMTCtSYzU7lkeLwKd2d5u0LirX8NyejomZ8eDefT/BQqkqST2wez0WiKBvK8lnbHYtVXBxA923GtKLlmp8BaNh11jc28yHJmoPG2GI7lxMR4MMIZtALdjoZGg9f85emP48E6CNg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f22731a-d74b-44a3-6bc0-08dd198a5a05
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 02:20:16.2368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKjPrQGLF920j+SVFGEq1rGt10o1dJALThXb/hkV/7w5aq8WMsqLmZSeFffP8Ln68aMVrpQeBJvYW8c6F7tzhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798
X-Authority-Analysis: v=2.4 cv=fNPD3Yae c=1 sm=1 tr=0 ts=6758f6e6 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=jIQo8A4GAAAA:8 a=x5PO_QLvagec1hsWN-8A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: 1vLV-QFLrDfFnrCFzEEhY2kiHbWGpAdL
X-Proofpoint-GUID: 1vLV-QFLrDfFnrCFzEEhY2kiHbWGpAdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=743 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110017

T24gTW9uLCBEZWMgMDksIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBSdW50aW1lIFBNIGRv
Y3VtZW50YXRpb24gKFNlY3Rpb24gNSkgbWVudGlvbnMsIGR1cmluZyByZW1vdmUoKQ0KPiBjYWxs
YmFja3MsIGRyaXZlcnMgc2hvdWxkIHVuZG8gdGhlIHJ1bnRpbWUgUE0gY2hhbmdlcyBkb25lIGlu
DQo+IHByb2JlKCkuIFVzdWFsbHkgdGhpcyBtZWFucyBjYWxsaW5nIHBtX3J1bnRpbWVfZGlzYWJs
ZSgpLA0KPiBwbV9ydW50aW1lX2RvbnRfdXNlX2F1dG9zdXNwZW5kKCkgZXRjLiBIZW5jZSBhZGQg
bWlzc2luZw0KPiBmdW5jdGlvbiB0byBkaXNhYmxlIGF1dG9zdXNwZW5kIG9uIGR3YzMtYW02MiBk
cml2ZXIgdW5iaW5kLg0KPiANCj4gRml4ZXM6IGU4Nzg0YzBhZWMwMyAoImRyaXZlcnM6IHVzYjog
ZHdjMzogQWRkIEFNNjIgVVNCIHdyYXBwZXIgZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUHJhc2hhbnRoIEsgPHF1aWNfcHJhc2hrQHF1aWNp
bmMuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgfCAxICsNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+
IGluZGV4IDVlM2QxNzQxNzAxZi4uN2Q0M2RhNWYyODk3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtYW02Mi5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYy
LmMNCj4gQEAgLTMwOSw2ICszMDksNyBAQCBzdGF0aWMgdm9pZCBkd2MzX3RpX3JlbW92ZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgDQo+ICAJcG1fcnVudGltZV9wdXRfc3luYyhk
ZXYpOw0KPiAgCXBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOw0KPiArCXBtX3J1bnRpbWVfZG9udF91
c2VfYXV0b3N1c3BlbmQoZGV2KTsNCj4gIAlwbV9ydW50aW1lX3NldF9zdXNwZW5kZWQoZGV2KTsN
Cj4gIH0NCj4gIA0KPiAtLSANCj4gMi4yNS4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVu
IDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

