Return-Path: <stable+bounces-69365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529495534B
	for <lists+stable@lfdr.de>; Sat, 17 Aug 2024 00:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AFB2837AD
	for <lists+stable@lfdr.de>; Fri, 16 Aug 2024 22:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3D13F43E;
	Fri, 16 Aug 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XwOJ1St4";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P4XYKXPu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mlsUkBMx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94271AC8B0;
	Fri, 16 Aug 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847506; cv=fail; b=WFOH+kMhVDSQePVWLDfLMWnOLR2iSZ1hEFc9QODNqSu3XeVZtdbV5GQOTRgOEe7SSGgkgNYNnzqw0e8JhyEKq35obw+NSALIkJFIkGaFzLPWo/mhUSThdTOavHm027vLG8nvDWMziZA6AkbHmVYtVHXsRQXXgu16x/v9GkTK8fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847506; c=relaxed/simple;
	bh=uNB/1YYDa1q4cmr0Q+z+9io2NGwLtSLR4WlBOrvgtnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SJGN0+yuvB40mv0vpOqY5Racnu9YAPoyXogQKPdm6EAxlO7gmzVaY8y/cYcjZ3Ixb26lhw33RXBj65MHK+Y/CTM1sGyZEv6tiOJkt48+cxCVa6aZz6cTvSEGYDNWiDztnbV9RwO7gXX5ZEKRxxC6JqBEukcJsKdf1Ha5zWOknHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XwOJ1St4; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P4XYKXPu; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mlsUkBMx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GJ25Dm006443;
	Fri, 16 Aug 2024 15:31:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=uNB/1YYDa1q4cmr0Q+z+9io2NGwLtSLR4WlBOrvgtnw=; b=
	XwOJ1St4xtg4BI0lBdGJ6+tIfdTITBqcVAVutseUI3QObrkFks4DW5jQJsUDUpno
	1G0G9nEReVo2aiJr18LBw0RIELP4MIeTrUN+7meLe/EEVcmeEgDVqWOdEE8KDJ52
	yt/+LAEEQgpOb0wB0ZY852RsA3OoPMc89mXuFToAjNDEDpy4rkBNJoHB//x0NnfX
	Quej3eiBSkLhSj/i4kjX4N6R8vmU9QtrSDUi461D89MwCbtAZns7Irl6QDU5H+p2
	cZl6yrICof39QnHIMKPXS4KvUDU3m6qsZJ16hyue4ghGw79u19etB1Kh6QOQr/4L
	HbrrgJDbxlVn5vnZGqS0qA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4111crak2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 15:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723847498; bh=uNB/1YYDa1q4cmr0Q+z+9io2NGwLtSLR4WlBOrvgtnw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=P4XYKXPuyQNG/C3yjnnLXuZu2CRQ1t/SSbG0OAaXUr8//BiTNt8jI86M9XGx7SWcF
	 YCBhpvGywvrK/sk6osGVkFqbxgaDgt8UODjyVmfzEOGshO5+s0lmIZWbH5jA+ZhwmW
	 zgw8xaMxHkkkjrd9mqiBDfoXirxmvDMSSbLs57xQc1OevkINMTDPbq6xYblqnJQKnZ
	 mrM09SipQmxoFeQwNsyLMLBJ24ep7JEERgutzmhBwnjWtQCu9NPH3iO8sZ+TzFrYRQ
	 isa8bKJTCjbvHlrSqKeN/4QIocJckEZ0Huy7VUVP03xqb5+AkU0qevkuNDkbXnxj0Y
	 SA+CU0r6dYp3w==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DA43D40351;
	Fri, 16 Aug 2024 22:31:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 58714A00E2;
	Fri, 16 Aug 2024 22:31:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mlsUkBMx;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 23F5E40354;
	Fri, 16 Aug 2024 22:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDygLXegM08/3coGWtmcX6VgtuYxfo5fC5Tt+k1JXMCWJbD+h2b7TkGbbxSkqMQOI64mW58PPxdiuUKrXrHyYmhVQeWlwYZdYUxA9mcCrgTh2Lfc7MTNFu/SRPj5OLYF6JJHWEl0z/MukDVrlxyNgXz3Q3JK1xLALilH+c9X2PACEGjX2zqnNulBQ8X95OpX5+u0GfNEdWlXvGLSY5Vp2GHKwhV2JC0IOhmwxICuP6g2a8IxwL6AMHmOI+IxSlA0u5mOWPnxuPDr/iy2BiPCuYBmg8nO5sl7UulqCMMP5dud9lDWj0vuffW6XpZPPtmVu6FsNjgmLV7qaC3dV1U+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNB/1YYDa1q4cmr0Q+z+9io2NGwLtSLR4WlBOrvgtnw=;
 b=I8u1D9usFftL52MpUnRTXTHnkim712Dc6zQYMEvdrjYu6gJp5BJ+xLUZsg1JmwKVoWg9cMsmVVrL5nQIWjkeAm6OEnPJV9ViUETtYPoGUZk84g56brei7o3Mn6HaYF3O5mn5s06+Hr/qg91E0ULfgYDZ8eykwefgIdIfkxw8XpFoEvsNILkf4oCpdwHFy+bOXwhKtxLLSpNeKOcXf/oUVHQkAjoLkMXBhiZyAKQ/cHKHPuKgkpmzLRzkaznF1RTYNj/aWo5a3lOk3milg+saW1bsHBAsEN+PWF0Jok37r92xIUKfehpnszIFqPEA5WTZlAJGv+YIwMPqJxE6LUTX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNB/1YYDa1q4cmr0Q+z+9io2NGwLtSLR4WlBOrvgtnw=;
 b=mlsUkBMxHYqFFyoFz23ZlMVlo2lgkBQw4bt7mbI5vWDYcT76I/AbRLKYsbotctEoZe9/g865CB0MENJ+9T56KhOeZbhTUpii3u8RKNvSfZ4oK0fA6+EM9NJTOGHLs9RkhqhFtk+s/kE5AXwCM+zDQDsuwZTnTR9yZoyssYa/nOI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB9061.namprd12.prod.outlook.com (2603:10b6:208:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Fri, 16 Aug
 2024 22:31:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 22:31:32 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Thread-Topic: [PATCH v3] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
Thread-Index: AQHa78EJ+PYxg6ruJ0OGAvrkVBoKE7IqeI6A
Date: Fri, 16 Aug 2024 22:31:32 +0000
Message-ID: <20240816223127.sig244r3sx2gwgqk@synopsys.com>
References:
 <CGME20240815064918epcas5p1248e4f9084d33fdb11a25fa34e66cdbe@epcas5p1.samsung.com>
 <20240815064836.1491-1-selvarasu.g@samsung.com>
In-Reply-To: <20240815064836.1491-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB9061:EE_
x-ms-office365-filtering-correlation-id: b244c687-2aee-4f18-f837-08dcbe432dde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eGxDakF5d2tIL0NtR1JGYWQwbEcrRlpSRFU5Tjc2Y1BMcHF3ay9DM0N5U2Yz?=
 =?utf-8?B?RnVRTWk1RGt2VXR6dEVhTU1PY3lCVzAvb2J2dHNsTkdiV0NYeFNtUm9yV04y?=
 =?utf-8?B?dTNNTVgzUk1RM0tlM1B1MWJkNVZWZGRNQ1lERkhoTDhFMERUZkJITVJuaXkr?=
 =?utf-8?B?bHFGdUxLN0U0bEtPNUhNNXNEdHF6QVdVRkJ0cTN4SjdPZU9rY2NGNnFWbGpa?=
 =?utf-8?B?TmI4SnBNUUNsRWhKaDErMFJvVS9tNUhFUmJmV3ZUc2x3d3BoZEJyaHJzbWhk?=
 =?utf-8?B?L1YwdWVmTUhkaUVpd0lZamFlYjF6TWQ4V3pRT05wcVpZMmcxN1V6TWREY1gz?=
 =?utf-8?B?aDAzV01BNCtoekVBaUgyV0xLV1FqRXRRZExaSFlhYXVuSnhLMXdZdkNvV2NN?=
 =?utf-8?B?RC82WW14MU4zYzYyUTBVNTVYUGdrV1E3eTVaZVlCbGg4blBzeXJkaUN0Nm1B?=
 =?utf-8?B?TXZQazEwUHpmVlJJL01SekEzMTB6UFhZem9aWHYyaXpSbFZ3YWJpdUhia1M0?=
 =?utf-8?B?cERMYjRaUUZQVlVaNjF4anp4aTBpd3N3aHplaURsRVFVMUgrd1F4bEdRYk02?=
 =?utf-8?B?VFdKSk1JbGRtRGZMVzdSTVVIVlMzZllZaklndmtLRzVZdC9peDVGNVhUS0RC?=
 =?utf-8?B?cXVaZ01JaEtCU1RrdUVpZnowYWwxREkzOVB5MGVXMGRUcGFOTGZQM1dzRHc2?=
 =?utf-8?B?Um5pNkdsTGVESS9aYThiMWhzN1F0aWd2TjdwS3c0UzJadG52d1RtTTk1QXo0?=
 =?utf-8?B?ZCtFNDI2R29PSnZ5VFI5a3d1WEUxSGl1aHFGMHA1eUhVM0svUzNnMjZKbDZF?=
 =?utf-8?B?VWVpME1QWGI5eEtZS3JOZlBZK1hqVm01UWN3RjJlVGdtL3VvakRZbFRkS0gw?=
 =?utf-8?B?OFFBMXV6cmxhbytBald0OFRuR2lmTVE5UlhHcncwSzc1NzVtVno1NlVidGRw?=
 =?utf-8?B?ZzJkUWovNEV6bWF2bVB2QTdDVkh0Vi9oVlZIWUFiYUlHYXJOSW1NWlJJZDlY?=
 =?utf-8?B?dFJrY1pia3BrMVduaGlxVmJRYk5yWjZwU2xkbXV1RlNKeFcrZW04eEEyTGFo?=
 =?utf-8?B?L09PVEVCVW5LemVuS3U3VjdjZUh0K3pxb29nN2JIaHJxYlp1bEF5U3d4dWsw?=
 =?utf-8?B?bkFNamsyVzZnSUF3dmtkbkxOZ3EyKys2N3VsYWJJTHZnS3BxMUlId3NoMjRK?=
 =?utf-8?B?TEx2bFN6bW5OUGhwL2lpRDdCT1d3MG5iRkcvZEFvalZ3eFoxV0ttbEJFV3lP?=
 =?utf-8?B?VnVhbmN5K3N0QUVnTmE1ZjViMld3cldVVVgwVUdmc3AvNW56VmhNVmhac1M5?=
 =?utf-8?B?NFgyRTlJWWIxVW5uQXpUMCtvRVg0ZnlldW41SVJGcjRsbkxKZm96MERub09R?=
 =?utf-8?B?aVRzUWNaeHprbWhBd3JYWW5SeDhlK2NjN3RlRC85OGJVd1FTOGdnd0p2WUp2?=
 =?utf-8?B?U3JzdmU3UUpsV0J1Um1ibG4rY3J4T3JRdzhQVmhMeWNMaDdrTERCSThNSkk5?=
 =?utf-8?B?dHR1anZvRWFtellHK1lKeENkL0RjZ2syMFhRVEV6c3NINmR2cFZpdDNHSDdl?=
 =?utf-8?B?Y0pCdzgrU0tlekxVRloxbVUwdkpacXpPYVJWakdTL2xhTWhEQUFhYWMxbGR3?=
 =?utf-8?B?WFREc201ZUV0QXJQay9mb2xkdUxsWGZWK3dmTWRqaklXbmYxU2l6UVVsU1NN?=
 =?utf-8?B?d204cXhSWWIvbFB1N0R2bWhCSXBNQTI1enhyMm1QZ0luci9JUHdNMHpaak5K?=
 =?utf-8?B?L0srcWpoTmNpbEFtSC92djAxMWxqWXJiaVdHUExPMUhXOG5EdnBzSnNpVW0w?=
 =?utf-8?B?VngycDM1aE8zZHVtZmZEWlV2QTljajBoRUZxZWpvK1BJVWRTSllkeTRjZzB0?=
 =?utf-8?B?U0ZJdzhSeHE0R2FYNmZwS1NyTFlGWDBod1AyMkVoQjgydkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QW9nUkM2WmhJZ0pSTHZDYlZod0Zja2tHVEgzcG1KMkJWcExPamZiMkk3OGdz?=
 =?utf-8?B?eThTQURCTFQwRmtzODB4cGpLQjgrWVFOVlRmQ0JrZmk2akd3VHZOdFBUMXJh?=
 =?utf-8?B?cldNYVUxenY5VXh4dmZTS3J0eXA3M053N2tlajlHb3d2L1VXcnFjSW8vMlZt?=
 =?utf-8?B?d0ljNWoyTm9HbUdHV0NWdW54VWtjK0ZFQ3luRk9NaXVXMVdpY1FDcmxEREU3?=
 =?utf-8?B?Zk5mZ3BtU3VvYXl2NWNuQnlGemJmNGNYalBZaEFwU2ltRkRrS2sxZDltSU9o?=
 =?utf-8?B?S3JMd1QrTG9aeGJ3U08wd2pIWEhHMWFvWUorSDRibVhqM280Y1hNZjNHZk9o?=
 =?utf-8?B?VWhDNS9KY0o4TXkzVXVwdTJudTgrV1pOZUNOM0tYZm9oVDlrY0JheDFHNGMz?=
 =?utf-8?B?TmFFUWZzK1VZVEZmNWZpNFBuUER6bWxHazlLL0FuOEVGUWdSUFp5NHRMenlH?=
 =?utf-8?B?MXpvaEpWMFZQS0lsNGxNYW1UcWY0WFAzdnBLd0l6NUg3czVqZFQyRmFEL00z?=
 =?utf-8?B?MjhFcVo1ek9QUWtkK0N4VnlBdFBsYkUxcTRKL0RaZG9kbkdYVGFhTFFVSmND?=
 =?utf-8?B?L2gvVVJxTjRIc1VxK29CV1VEKzdqZ1pUazI1N3NrQ1R5eW1pYXFLQU9wY3hy?=
 =?utf-8?B?Y0JvT2FxeFE5M05TR0tlZVZ3aC9aUjV1MkRZSlFHVGxmblVyTW95TUdBYXla?=
 =?utf-8?B?MDJaUHFlYXRKVnBxMVNqeVBqRlo0eXE1ZnQ3QWhjQWs5SllEU2tFOVZySWhl?=
 =?utf-8?B?ck5XVkgvRmtNSnJPV2ZpRitqdlpPNUFsenBBcUVRNHMwMDRwZGlMZDM4Y2JZ?=
 =?utf-8?B?RjgrcWpGQmdPU0dmRkpOMzd4R2prQlYrcTZrRlFzVUhtQWhNWk9iK2RiMmJ5?=
 =?utf-8?B?U2ZtWEsycHpPN2JZTnVnNm96a3lQWTJid0pnR3ZkWEU2SVhsZFZzaGN4U0dt?=
 =?utf-8?B?NUJBMWtSN0REYnVwRU15MjBxTTlGbnRUVGo0eERZYWxMeXV6YTVpUkE1MFJw?=
 =?utf-8?B?MmExbUgzWEs1NXVFWWtmc2IzWHBlRTJNUnI2RnJmeHFFUWRxTkF6YUFMOExB?=
 =?utf-8?B?ZWZlOTlMcndpWklNSSsxZWFrVTQ2T0kvVndseG14bk5Qem9vM1k5VEdzM0VK?=
 =?utf-8?B?RUhrYWRZQ2U0RklNaDQ5L3BLdlBMKzQrZ0oxZ1V3UFVIdnJqeVQ4RXFIcWgr?=
 =?utf-8?B?YXQ5aE11c1gzamFldHpzTGNlSzhOaXpVM3ErM1FoRi9YSThVS0VLQjdLRVo1?=
 =?utf-8?B?WFFUdTVEaDdhT1ZuMWd0aG5mdm4zSGtyNUQzYjJTYVp5bFFkRW0zWmlOS2Ny?=
 =?utf-8?B?Q0FCc0lvbFFFdU1jQXByMTNUUXRvdmxDNmUrMUFaa3VuQkFUNDl4YWtJRTdW?=
 =?utf-8?B?VlpndHlMd1RKaXJZUWxpY1ppRjFiazkya21IUlNtMi9nRGxjVUZXcEkwbG95?=
 =?utf-8?B?S20vZTVQdmtXTEZFbjJGZnBzb2NnQStBS2FiVUlzNTVnQitEa0dGY1RKbzFh?=
 =?utf-8?B?dFJpUGZ5aFdGOXR2cUNpK3lHZ2U5S2FkQThMeldkOEtxWTBmaTZIT1hBZ1k0?=
 =?utf-8?B?SllSZHkrekZrM1pSWVBJRm1LQUs4bDRabTlEc1hVUW1lRG9nZS9vQW9La1NN?=
 =?utf-8?B?ZGxRTk1yMkpoU1hHODRFVGpIaDcwWVpYWDk4VHRHSDIwejluUGIxVHFQRE5R?=
 =?utf-8?B?enpaZlJsYmowZ3BZMjBYN3pzaWlRbWNRWGg4L3NxRm9abGFXd25IYy9OVUwr?=
 =?utf-8?B?bk1xb2hJL0x2QTZ3aHA3VEl2SzhnL3R6MEVJWk95Q1FES1NESHFZNHdGclRB?=
 =?utf-8?B?akZ1TjcydlFqdEVRMlZ2SmJadGR6TU5zazZZY2UycVkxUGRkOGJmMDNuOEFs?=
 =?utf-8?B?Z29rSXpwejRKekNZTjFYT2VRMTdRK3g4NUQ4V3MyOGxwZHNJVG9qR1lMc1Zx?=
 =?utf-8?B?dVdJU0pIOXNleTM5eG9TcVZEbVhjRDNZcG8zQzNGbFBPZ1pOeWR3NWNtbkph?=
 =?utf-8?B?MnROZHQ5Q2N1T2pmV2N1L3hjcS80bGZEaU5WMTdkMUFscEJUeHR1dGlRMWtF?=
 =?utf-8?B?YllsbThSczN1WWVsK1kvTS9PQWtaVEE0Yjk4VFNLMHpaYmZzL0xzN054alI3?=
 =?utf-8?B?VlNOOGhuOWFhekNpT1N1d0tvU2U4VVRaWUIyallXU1B2K25KM0pNOEoxKzlz?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <902A88800DF58A46BC5757376F1AA445@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TpFUyMw5qb7DTrCnI6sZbDqBFdCqGXrI9C+nvgOd6TY8G7Cor/7WcxLLvXWrCSvfGhvFPgePJ4K/NmnY4ogEnvzx3RWH5CmZdRedydMWcD5ZFt/APcA0TLiJYay+G9ygf/vDtI71FU75hmq6AZ3QhJMd7sgVB1z6DtK+98D9acS/n9bm8M+dCcpKj71DIRLCr+j92liLc5Sv3qPrO6VSYZvACODPP8Dr2mC/CL6+tI97Dna6U3td5Ll6HruvR7bZ0OEMaAh9TzM5Gyc5f/ccfu9e5UCF9v+5fF6ef9Q3Dk3uQYOhejYH35LsPJKSGW2b9g00ALnNpODr867PC5QU807vBfaYnMrssJZSsuXFOYu6dJHSMrE8d+971YNGbm5EgLzJkjpX3N7ttzFzZb8GoKn0TcAUubJztnV1WcKAVrOOkAU1eMCp8V5aJyl1GIgAtLYLZPXnuz/J6zqY9/4pCAf80Blii8D6hKiiCzoKAWmB6c/ijMOUp8SbNmSwI7P6IJ6wS9tdzP2ITuh/U05FAWmccEoiVBBr6Pzt8Tlllygdi49rHA6wDl2hRZmmVn4Kvyv4dxLAwLyCIILCglP5dN3IyAYayCkhurDfNuajgppmbSs9AafUBYPHkpXJeMfmMjE5cL8rjz9+Wopj7y1HRQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b244c687-2aee-4f18-f837-08dcbe432dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2024 22:31:32.1414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gQDrhPeaALD2IUFguApn9WBsN93F6sX9Ou0GwoksUVkvkoX3uzYTbF5pY1EOmeL8zCyFKTHTOXbbR7W8+eTig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9061
X-Proofpoint-GUID: -zSiJNPEBH-rId_dOTLg9viWTa08NiOh
X-Proofpoint-ORIG-GUID: -zSiJNPEBH-rId_dOTLg9viWTa08NiOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=903
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160159

T24gVGh1LCBBdWcgMTUsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGlzIGNv
bW1pdCBhZGRyZXNzZXMgYW4gaXNzdWUgd2hlcmUgdGhlIFVTQiBjb3JlIGNvdWxkIGFjY2VzcyBh
bg0KPiBpbnZhbGlkIGV2ZW50IGJ1ZmZlciBhZGRyZXNzIGR1cmluZyBydW50aW1lIHN1c3BlbmQs
IHBvdGVudGlhbGx5IGNhdXNpbmcNCj4gU01NVSBmYXVsdHMgYW5kIG90aGVyIG1lbW9yeSBpc3N1
ZXMgaW4gRXh5bm9zIHBsYXRmb3Jtcy4gVGhlIHByb2JsZW0NCj4gYXJpc2VzIGZyb20gdGhlIGZv
bGxvd2luZyBzZXF1ZW5jZS4NCj4gICAgICAgICAxLiBJbiBkd2MzX2dhZGdldF9zdXNwZW5kLCB0
aGVyZSBpcyBhIGNoYW5jZSBvZiBhIHRpbWVvdXQgd2hlbg0KPiAgICAgICAgIG1vdmluZyB0aGUg
VVNCIGNvcmUgdG8gdGhlIGhhbHQgc3RhdGUgYWZ0ZXIgY2xlYXJpbmcgdGhlDQo+ICAgICAgICAg
cnVuL3N0b3AgYml0IGJ5IHNvZnR3YXJlLg0KPiAgICAgICAgIDIuIEluIGR3YzNfY29yZV9leGl0
LCB0aGUgZXZlbnQgYnVmZmVyIGlzIGNsZWFyZWQgcmVnYXJkbGVzcyBvZg0KPiAgICAgICAgIHRo
ZSBVU0IgY29yZSdzIHN0YXR1cywgd2hpY2ggbWF5IGxlYWQgdG8gYW4gU01NVSBmYXVsdHMgYW5k
DQo+ICAgICAgICAgb3RoZXIgbWVtb3J5IGlzc3Vlcy4gaWYgdGhlIFVTQiBjb3JlIHRyaWVzIHRv
IGFjY2VzcyB0aGUgZXZlbnQNCj4gICAgICAgICBidWZmZXIgYWRkcmVzcy4NCj4gDQo+IFRvIHBy
ZXZlbnQgdGhpcyBoYXJkd2FyZSBxdWlyayBvbiBFeHlub3MgcGxhdGZvcm1zLCB0aGlzIGNvbW1p
dCBlbnN1cmVzDQo+IHRoYXQgdGhlIGV2ZW50IGJ1ZmZlciBhZGRyZXNzIGlzIG5vdCBjbGVhcmVk
IGJ5IHNvZnR3YXJlICB3aGVuIHRoZSBVU0INCj4gY29yZSBpcyBhY3RpdmUgZHVyaW5nIHJ1bnRp
bWUgc3VzcGVuZCBieSBjaGVja2luZyBpdHMgc3RhdHVzIGJlZm9yZQ0KPiBjbGVhcmluZyB0aGUg
YnVmZmVyIGFkZHJlc3MuDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIHY2LjEr
DQoNClVzdWFsbHkgdGhlcmUncyBubyAidiIgdG8gaW5kaWNhdGUgdmVyc2lvbi4gSSdtIG5vdCBz
dXJlIGlmIGl0J2xsIGJlIGFuDQppc3N1ZS4gUmVnYXJkbGVzcywNCg0KQWNrZWQtYnk6IFRoaW5o
IE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmgNCg0K
PiBTaWduZWQtb2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdAc2Ftc3VuZy5j
b20+DQo+IC0tLQ==

