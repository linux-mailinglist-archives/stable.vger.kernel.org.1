Return-Path: <stable+bounces-66294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594D394D91A
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 01:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34501F232BD
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 23:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276FA16D32D;
	Fri,  9 Aug 2024 23:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cm6JiHRI";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Bf083Pum";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lDGP26rT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968E26AE4;
	Fri,  9 Aug 2024 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246107; cv=fail; b=SA/xQsdqjabW3Ybjun7xKmMAFvbBJEsosP9L8xXYrdNzTCYOcbVasam38NeL/HYbLHebqRmHAt0QJ0DVzdZdnEGowjxArtLxULLCfqrF50krqd2d9jghJMH2Are+ApvAI/kvISX3oTU+nSer3ccPa46QsYyZBawR+faqtPrEdhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246107; c=relaxed/simple;
	bh=ZrhXls9G+W+c2bFc9qTX3xAaLzR1ni3I3sQJadycBwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jZ44OK0SwTmtNiqJWxYq/kFJrYXMyWw3/IKLCMVLvnB6nkHZLYt9Fa5A8Woe4Y/CkLwQ/2Wm2SoxkfdesBncqjaHVEmdJHUWCBOCmZNv/76IHia+SZNR8PkwNTZsl+t13Q9znnicMW9Av2qdMz0zurJ/zvUHYGZVtn6NFwkmxL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cm6JiHRI; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Bf083Pum; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lDGP26rT reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479MBwCt031471;
	Fri, 9 Aug 2024 16:28:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ZrhXls9G+W+c2bFc9qTX3xAaLzR1ni3I3sQJadycBwc=; b=
	cm6JiHRILxjOBlqYblVBtr2Wie7GhMc8K6HXqc+AcJdHw3gsRlb4O6ugTX/3wTLa
	Rx3B/9wJAhKIJpfzLGLpyH76ZPHx73nxEeAesDVObihKOn8Kor5ElaHroRCT1lEc
	nsshnRRrXGViuvjUHX3Ds2EECZZ5QOcga+Hbh8y+NbV5CPcxwIf/dMZDSDrqaEs7
	TjydlTCAZhi0WZHiG1AgNHcfFN+53lDACZYQ7FbbWdeV45/wwcMbRE2Ld0WOgY3o
	eqdzz5+K6aZnwfpB5R886+IgJKvYa1dylNDImfh5fA2sb4NNu0W5sqzpSajy0sAu
	u8sO5MFHgJHLdB2v8KuWhw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uuj6aqry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723246099; bh=ZrhXls9G+W+c2bFc9qTX3xAaLzR1ni3I3sQJadycBwc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Bf083Pum60rMQAYs8KG0+ePe8u6/wUJ1XvgP/dRKTDA4wDkmgcRw5VneKBnYugXy3
	 gw8EBPh46OYm5sIMErGsMG7Jrzut9UzNn11aVWuVhDWzfAbfsIJQJGclTyeVcMphgh
	 EXnhBGDijIFcA5nXOVeZm/9ijr5c1TCAVX9fOMpYnzGtUXzcCkeDYRZ27BkD0KAj2g
	 JziNQ4Qv1peSBPgtvLs5diGrvL14E8st1vUhwB0Ml1bny1MXikJ99ze7ir8eqRp5LX
	 QIzQGlokN3MA8ah4w5s05ZmU0sO89egkhZ4goSrQeXpMbf5HLv/WsA2j+RjTvNTi/P
	 zij2s/+NET5Kg==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 453114035A;
	Fri,  9 Aug 2024 23:28:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DC4A4A0070;
	Fri,  9 Aug 2024 23:28:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=lDGP26rT;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5281E401CB;
	Fri,  9 Aug 2024 23:28:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWAxy4rN06mc7WVakkb+rgexJzsnMSW+/2Z1LMKnhY330CJUsu0kzfWZ9DpZVwxopJbYLLhc0gb2zULeo9EUi75pOafoTDvlhdL/5XrMIP4Nhs2vB3D+B2ZdyOuM2bWNnJq9mOr07yk48kjidVVEmehus4TmobakpJnvWjMiJKHLhci5aqwPfyRinHNv4l/pRe7MO+mN5RxdcU2fqMM5ruy2YFDYDNDbzY0Az9FPHjRMU8OeeuqjNqj64BlxY/hD71MIIyW9JPVh8SWGNa99H6d5ZS1mkZFLxg5/Zb0Dd5Thhr1BISNv0zDs0jQPPoVAXNH5q8mH5el/xa7MWP3CIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrhXls9G+W+c2bFc9qTX3xAaLzR1ni3I3sQJadycBwc=;
 b=m9h45P5u4bHZGSMvELS8gXnYmo+7olit2x+MXGDEinGQdRPIw/2FYSl0/F3GfYG5Tpb4DfdzO5BhdwJT0LDxRi6w5HP5wpdE56CuJtS/1c7AQ2YeEYfBlmlzM48i7+9KhabU2sH0tUbeBncTUZtzifH14IEadikLlqYWP1W7I9jdqVZ2nSowPw64/61fER5caRGYePGHCzQGys962hzSISIaGpggI1r8NcB7lXfK84iZ01VDnTpzqbgGZDm/t5wfQouDIX/2x1jEvpoDiPPM5plpla2298Xu0gYnUx5/8c6eq+fagL9tGk4aFkI8bia2JlEnHiFbU28gN9mkLefhSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrhXls9G+W+c2bFc9qTX3xAaLzR1ni3I3sQJadycBwc=;
 b=lDGP26rTNUP2wkjFtWvKRFoNe7ts7vMhDNqhmaiYcSD2RyRq4bWiVI7OkQbeRtmYwDPzQL5ovmZOFdB9soCGDqqAFQVHfhfasFgD1QGvl/sIU9gsW+ZB+i6mDNaBXSzMTXdHfFOxbV9wy2OFyrrrmwet5nYRA7AN4TgrRBM4V4s=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 23:28:12 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 23:28:12 +0000
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
Subject: Re: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Thread-Topic: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
Thread-Index: AQHa6YuP+qYtFRYGC02uoJ+XT4o4f7IflHkA
Date: Fri, 9 Aug 2024 23:28:12 +0000
Message-ID: <20240809232804.or5kccyf7yebbqm6@synopsys.com>
References:
 <CGME20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd@epcas5p2.samsung.com>
 <20240808120507.1464-1-selvarasu.g@samsung.com>
In-Reply-To: <20240808120507.1464-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB7321:EE_
x-ms-office365-filtering-correlation-id: 11d483ce-501d-4fbc-eb51-08dcb8caefe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGtUZllrbi9HOUI0dlY2MEdIRkg1a1JZV2VHa1pBeGFVdGwxbldiMTBrUHU2?=
 =?utf-8?B?MkN4Tk5hV0dCM0RwZ1FEdEZQZ1Izakt6NDdSWFlBRDFtVVRVMVdhSDUybVFz?=
 =?utf-8?B?aWc4VUlRUmd0S2xtUjFmbS9DeVlQOUZDa3ZqNWFyQ2QwM1dkNzFoeGRZVEE5?=
 =?utf-8?B?OFNWdFVlcWlzeGRjaitxc05ERWJRWS9wWDJOOGJseDQ0emFwb0tKalZVV0pw?=
 =?utf-8?B?OE12QUVuUldZRG1YNlVKQjQ0a0MreUFqTTBiYkthRGhWU1kvbHRQbUVWaEFn?=
 =?utf-8?B?cVZwdGlld3JvbmdpNTFyZEZuVWZZYWRzVTVhSy80MDRSWHJIMDNVOWw4d1k1?=
 =?utf-8?B?bTJLOTRZS2IrWmtTN3dzdFo3bnlYQkVST2JSVGhzR21DUWZienp4emxBa0dE?=
 =?utf-8?B?VEM4bEU2R1BiSi9MTklJTWluVmFvYTFUdHZFdVNna3ByaUx5ZWEybmZoS0pC?=
 =?utf-8?B?MStnUWhLTndLbHhvbXBySzZxbER5WlJFMHREb2dHL1NnWXdXeEM3N3B5bWNq?=
 =?utf-8?B?ZkZlNG9Vd1R0V2o1SFc1N0VvSWxJRXVONEtzbWo4ZUNRcDQ5MjU5RStiSHhi?=
 =?utf-8?B?RVdFeDN2V2VLOXQ4WHhCNlVqU01CdVZ4VkpOWUdZTlZRRmE5MlFDNTRqckRK?=
 =?utf-8?B?aDIxRFYzNFp3MklZSVRiNkhBcmJiT01TNUxrZmp5dGZjdWVVc3U2WnpDSVpU?=
 =?utf-8?B?REdjZjZPYnJ4SysrdFNOSERtY3ZETlp4QVdkRjBFM0RuRy9WWTB4MG5HN0Rz?=
 =?utf-8?B?cWE4UlpQRjUwNHhIZnhhd2JyQk9TdFFxMk9CVExVbGkvVmdnL1FoS3JFcTh0?=
 =?utf-8?B?a2hyTlcybVBMRW5XK0hFd3g1enQ0emxvcFJleUZON2x2Q3lzblFNSU5iMEFB?=
 =?utf-8?B?N3NMdE1wRjV0LzNJSDI3K1lSSVVIZTRVUGdwaVRRZ2huVnZwdUs1Rys4TVNK?=
 =?utf-8?B?aG9yOFNNNnd5azd5UDltbFYwZzR1UVgxcEw4ayt2K2JMOEhlT3g0Ukp5K2o3?=
 =?utf-8?B?RmJVNkxHU2h4RWFRc1c4dnl3NXIrdWJBZ0VqeHVVb1V0YlFPNC9kaXpuckg0?=
 =?utf-8?B?UG5WanhRTS92ZEJCaHFIYW80NHpzODBPZU0rVFJXSGYvRXEzdUJxYXh4MVlh?=
 =?utf-8?B?TTMyTDlzZFF6c2lpS0J3bTlPNStXS3Njak5tME9ac1RYRmFVaU5XcE9UcldT?=
 =?utf-8?B?T2dsazlHczMycTNoYmNHMkZtNXkzYmJaK0NTc2pOVGdoZ1VYbE1ReUhQczBN?=
 =?utf-8?B?ZFdNQjlkNHV6QTlMZ2NOT0dVc2huaUtyMTZ2ZUhQdnF0dlpFZnZ6c1ZYZHFy?=
 =?utf-8?B?STRCMUpHTnhrdjh4U3UwNGs0QWNrUUdmS0dPMks2Vk5IbnhZdDBvMWZ3RmdT?=
 =?utf-8?B?QkRQWEtMU3pmRGIwRStteEY1OTFkRmtVOFZxcmdobGZ0SjJTQlpSK1oyb2hx?=
 =?utf-8?B?S1oyNUlGZWZNWldzcUk0UVRHQUxmcnlNQU5qZDBNRE8xaEEzUTJmZkpzbG9m?=
 =?utf-8?B?Y2M2U1VldVVZcHRDUlo5VWphWmk2N1RFYnErV3QwTiszZjZVZVhySWxTa29w?=
 =?utf-8?B?dDg5OUdISysyaXgxM3AxZ2dJaUVGOGxSVWhCeTFZbFZLZFZyS2gzNVhidEJB?=
 =?utf-8?B?RmJEc0dQTmI2QXp4dkdZTGdxZmxieUY2RFpnemc5V01ramIvL3MxQ3BSYjVh?=
 =?utf-8?B?cTdIeFBJU1lGdmQyMllaT1NWR1VYRDAwWXZZd05BVXRDRG1SY0F5Q1NKRTY5?=
 =?utf-8?B?eWFaS29KSXV5Z0xlWENYeGNvcThYQU1pT0ZGbXNxTVIrNnAraDNiY2ZqaGRO?=
 =?utf-8?Q?Zzkj8hst7mBaAyur6L9bmiaHMhDF2UTYly47s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QTdhUThzb1htL2dGZHVEUjBlQWlGYWEwaS9tUnBRWjhwQ1BRQ29NamR0USts?=
 =?utf-8?B?QTZxbzBISWZQV3hqc01hdy9xUG9kZ1EyYUJ1MHBRdzJlVWNtMW5QRE5ocURY?=
 =?utf-8?B?bzd6WDBLUWRWWUxscTF2bHRqNnM4TUZxSkFtWmJlTk01K1hNNkNmL1lQSFNW?=
 =?utf-8?B?aEJYd3VZSUxQT2k3c0JRZG1QUmcxS3p0RXA3aVVYbEVxTXNWUzdETmRUT3pO?=
 =?utf-8?B?cWVFYnVERk43Wk15SWY0WlJwVi81S1pPQm9qNWczR1dvR3N0aVBIWGhTL2ti?=
 =?utf-8?B?bVZTMHJTK2NTWnNrbTVGZ01pbFdZVTUyT2VsTXFrMU1CWWhJdTFVZVc4K0xj?=
 =?utf-8?B?d3E3SFBCSWx0T1Q0LzF6aGZaQWE1MjJJNVdnT1ZBQm5ncVNmTlBKdDJVWnhM?=
 =?utf-8?B?dm5ZcFhJUWhyMFVJdHhQWWFzWGlqeno3T2RuUis4N1dBdTNtUXBjV1NpeHVO?=
 =?utf-8?B?dDk0SjZCZDRGczhYandXWDladkNQOXlWdzBJbDViNHpVa3U1VnNKTS9rU3l4?=
 =?utf-8?B?RzlJTzQzd21SK3l6V0pmNzRoNDlSSGI4dHd1di8zNjRSanBVdzNLVUI5UXhi?=
 =?utf-8?B?cDI1WHVmSlpjQ0tMVUUxTDNOZThkdS8ySCsrOGxpdjRvTEFwb3R4R0hRZWYx?=
 =?utf-8?B?MWtzMkJHWTNTalkwYTR6a2JzV0lVMWVGamZOV21oMHNCVytNbitxc1c2dUlK?=
 =?utf-8?B?Mjg1NlMvWFNXSmJSQlZXcVQxL2d5NitRbWxHRW53eFg0VDc1bG8zQjl1dEcx?=
 =?utf-8?B?WFJVTkJFSi96dWhIamdVOEtYRXZhLzdmR2dmYjNjV0pKTGpoNzZOVHp5aTE3?=
 =?utf-8?B?WG5YZUg0ODBsd0JDNGZYQmd5MGs1NGtDbWZqRXNkTFVuUjBCUDJFRCtmcGpK?=
 =?utf-8?B?cGFZTCtkelBTV2N0MEJmOTc0Qm80YW9objNXd25vMWZ4L0diaHdpRTI5N04x?=
 =?utf-8?B?SCs3MnduMXZLUHBUajlIdnVZSStKbzR1eHNXMmxDcnphZEE4QlN6WGxEejkx?=
 =?utf-8?B?cURobnl3QXVZaGk5OVFqRlRDTDRJWjg3Sk1yc0dxTWxZT0RNcjV1anc4RjE5?=
 =?utf-8?B?MEJ2SDd1UXlsWVNVa2pZdkkzWnRyZS9USHFlRy8xZS9aWm0ya3Y1S1JhTmlS?=
 =?utf-8?B?NnVYdkp6M3crMzVRUFdWUUNyN1doWnFFdzVOb0FPall6dG1iZEkrM2NGTDBp?=
 =?utf-8?B?ZysvUXcvNnM4dm9NVmhEMVF5b1hmSDBXYzZYcW9oS09zdFZXQzRxVFlUQWtY?=
 =?utf-8?B?MDlDaENKVzRNZTlFSzdEbTYrb1V0N2hLQzVUMUF3R1Vmbis1VnVYaThjb3VW?=
 =?utf-8?B?c0lwTy8wMEdvYzJRU2ZCbTNselZNZXhjbHJiUWZ3SEhjMUFkNm5tNXlLWDBp?=
 =?utf-8?B?N1lmQW5OelF0OXRXekwxTU0xOURCbHl1Z2V0VVRxR2FYQ1dLVTVqajlyOUFW?=
 =?utf-8?B?NU11OE1aZTBSM2d6bGF1NWZXUmNWWW1sb05YTC9qcmlCNjhjWm0yOU9aazRn?=
 =?utf-8?B?VUZicmxVY2kzb0RpOWtwZ3BET3MwS1VpVTFFOWVKR2JxQXZQdWNPOGlNRktM?=
 =?utf-8?B?NkprNXhWUVY4bGVydTZja214UWlpMWNNTHFsMGxqS3Jhbjd1bWJXMEp5RkhO?=
 =?utf-8?B?N0Q1cVZXam1Ja25paWsxZkNNRTM3cXlzTmN6RlBRVVJ2OGVBdllNUGR4T3ZW?=
 =?utf-8?B?eXRZR3JEdlYvc09XR1NLZXNHbUZESUprTlRFOE5HZEFzSW9wSE92WnpVOHk4?=
 =?utf-8?B?NHJKWWVkRVZlblFRd0o1ejFNb2d4ZnhIcjV2VURrNTdrNDdCUHJnMTFlOW5J?=
 =?utf-8?B?Sjcwam8rRURnd3ZVeWU2eEk4QmtzUForKzRxM3hNS1oyNFlhQWtuSzY3Y1NT?=
 =?utf-8?B?bS9Ia2J2ZlJUbXVUaEt5blR5SldxMXlUblc3NHNiM2dXcC9nbXJOOUFESjFG?=
 =?utf-8?B?VHFrNXpZdUp5cllGNjQ4ODNZTHByaHlCZHN4T2RoRnRrL2VCQVBWWTg5WmRi?=
 =?utf-8?B?RFZPZE1TREM3dW02QUhYZjI4bmp0TVMzQlJjYmdmZllRMS9jeXJ5ZWVTdVQ0?=
 =?utf-8?B?MXVLWnZOWlV1RXpGMG1HTjZqeVZvaFNMMFdFMVVqTjFhVU45TzZ4M1dEQkQ0?=
 =?utf-8?B?MGRFRW1vYVFyenhueTdhMXBnZDcrVmx1NnVPTnJkOWs4Yy9CTUJDTDIwVmdU?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A92CE37FB52E8479AF24A8230BDD1F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RmMUbu4PSFSxWx61Oni2O/A9NIE15+NLDy3fUYrHq58cfOEUrKsnOY/NEyj/sdQxWpIS+SmyM8EcWIxygCNiytC5mcEiK3XIzBiBnJ3DWwmpOpJqGKSubrvN7QsQOHHvInjIfWUNlc1WkRLwq1cRgJsnaDaD6ymX0uyh7wB4ggVHQTtdN/rMvKmBj8Q+tGtcGuWj60wc4KG+OulLN3oyIcfOQ7ChtrosZPnvu/o/lgJNbIcMwST1J8Aa3FR1yCBRgngU4JCRzy4Hf22ZussmIYRF5HdHOTistCip384D/M6H8DsPh+CSxFJA/Pl+ZhMyO4RtIP7W2MW8OPMMaDX60xKuhDwoU8eOvhDDXmYDi2Si9vWO6GBkqUnzCYBcRynmsfQFKoaZBWPcghuYKtyhmPBz2sznX/4YF7rLNKVZPOKBfqMYe2yzS1N1pI6gMJDuZU1vWIYJHze/duRMLSLjg+9wwwe9/4dbDlmBXbXaL/phCxJ3K8wz5adx77zc1g/kNbHd++GiehHhTyFuQDLET8gcezkhQgiHGk7sN5bZPLRB4mcp9eN7vZ4Nx2uCYaDPyHwirK5QTNe2FNTEw6LjfBqV+7vLFdQ4mZrH2T6X8j9OHnxhWBwOXgN9KIa1usIbfebGz1W4qtzHBbZbQkNA/A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d483ce-501d-4fbc-eb51-08dcb8caefe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 23:28:12.7514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54XVuaDUb2jjMjXKzdm509u+MWnqeV0omMocYQ9jSIoJ+FI53SRJLywQ10Jaxl+Vu6UhmSJi0cZnpzorqTJaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
X-Proofpoint-ORIG-GUID: 4-BxfjC0YP3MwaOdVVwtrT6_zUz4iI1D
X-Proofpoint-GUID: 4-BxfjC0YP3MwaOdVVwtrT6_zUz4iI1D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_18,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090170

T24gVGh1LCBBdWcgMDgsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGlzIGNv
bW1pdCBhZGRyZXNzZXMgYW4gaXNzdWUgd2hlcmUgdGhlIFVTQiBjb3JlIGNvdWxkIGFjY2VzcyBh
bg0KPiBpbnZhbGlkIGV2ZW50IGJ1ZmZlciBhZGRyZXNzIGR1cmluZyBydW50aW1lIHN1c3BlbmQs
IHBvdGVudGlhbGx5IGNhdXNpbmcNCj4gU01NVSBmYXVsdHMgYW5kIG90aGVyIG1lbW9yeSBpc3N1
ZXMuIFRoZSBwcm9ibGVtIGFyaXNlcyBmcm9tIHRoZQ0KPiBmb2xsb3dpbmcgc2VxdWVuY2UuDQo+
ICAgICAgICAgMS4gSW4gZHdjM19nYWRnZXRfc3VzcGVuZCwgdGhlcmUgaXMgYSBjaGFuY2Ugb2Yg
YSB0aW1lb3V0IHdoZW4NCj4gICAgICAgICBtb3ZpbmcgdGhlIFVTQiBjb3JlIHRvIHRoZSBoYWx0
IHN0YXRlIGFmdGVyIGNsZWFyaW5nIHRoZQ0KPiAgICAgICAgIHJ1bi9zdG9wIGJpdCBieSBzb2Z0
d2FyZS4NCj4gICAgICAgICAyLiBJbiBkd2MzX2NvcmVfZXhpdCwgdGhlIGV2ZW50IGJ1ZmZlciBp
cyBjbGVhcmVkIHJlZ2FyZGxlc3Mgb2YNCj4gICAgICAgICB0aGUgVVNCIGNvcmUncyBzdGF0dXMs
IHdoaWNoIG1heSBsZWFkIHRvIGFuIFNNTVUgZmF1bHRzIGFuZA0KDQpUaGlzIGlzIGEgd29ya2Fy
b3VuZCB0byB5b3VyIHNwZWNpZmljIHNldHVwIGJlaGF2aW9yLiBQbGVhc2UgZG9jdW1lbnQgaW4N
CnRoZSBjb21taXQgbWVzc2FnZSB3aGljaCBwbGF0Zm9ybXMgYXJlIGltcGFjdGVkLg0KDQo+ICAg
ICAgICAgb3RoZXIgbWVtb3J5IGlzc3Vlcy4gaWYgdGhlIFVTQiBjb3JlIHRyaWVzIHRvIGFjY2Vz
cyB0aGUgZXZlbnQNCj4gICAgICAgICBidWZmZXIgYWRkcmVzcy4NCj4gDQo+IFRvIHByZXZlbnQg
dGhpcyBpc3N1ZSwgdGhpcyBjb21taXQgZW5zdXJlcyB0aGF0IHRoZSBldmVudCBidWZmZXIgYWRk
cmVzcw0KPiBpcyBub3QgY2xlYXJlZCBieSBzb2Z0d2FyZSAgd2hlbiB0aGUgVVNCIGNvcmUgaXMg
YWN0aXZlIGR1cmluZyBydW50aW1lDQo+IHN1c3BlbmQgYnkgY2hlY2tpbmcgaXRzIHN0YXR1cyBi
ZWZvcmUgY2xlYXJpbmcgdGhlIGJ1ZmZlciBhZGRyZXNzLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcNCg0KV2UgY2FuIGtlZXAgdGhlIHN0YWJsZSB0YWcsIGJ1dCB0aGVyZSdzIG5v
IGlzc3VlIHdpdGggdGhlIGNvbW1pdCBiZWxvdy4NCg0KPiBGaXhlczogODlkN2Y5NjI5OTQ2ICgi
dXNiOiBkd2MzOiBjb3JlOiBTa2lwIHNldHRpbmcgZXZlbnQgYnVmZmVycyBmb3IgaG9zdCBvbmx5
IGNvbnRyb2xsZXJzIikNCj4gU2lnbmVkLW9mZi1ieTogU2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZh
cmFzdS5nQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gQWRk
ZWQgc2VwYXJhdGUgY2hlY2sgZm9yIFVTQiBjb250cm9sbGVyIHN0YXR1cyBiZWZvcmUgY2xlYW5p
bmcgdGhlDQo+ICAgZXZlbnQgYnVmZmVyLg0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwNzIyMTQ1NjE3
LjUzNy0xLXNlbHZhcmFzdS5nQHNhbXN1bmcuY29tL19fOyEhQTRGMlI5R19wZyFjdlptbmF4VFd0
SktSNFpEUlpEYS04bXZ4cHZrZjVLUHg1N0l3U1hUU0V0RUZJVmtQdWxsUjdzVFlQMEFNOWRlMHhG
YkhMS2RNXzVqekJVaUJMM2Y5U3Vpb1lFJCANCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IGluZGV4IDczNGRlMmE4YmQyMS4uNWI2N2Q5YmNhNzFiIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiBAQCAtNTY0LDEwICs1NjQsMTUgQEAgaW50IGR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgdm9pZCBkd2MzX2V2ZW50X2J1ZmZlcnNfY2xlYW51cChzdHJ1
Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlcgkqZXZ0Ow0K
PiArCXUzMgkJCQlyZWc7DQo+ICANCj4gIAlpZiAoIWR3Yy0+ZXZfYnVmKQ0KPiAgCQlyZXR1cm47
DQo+ICANCg0KUGxlYXNlIGFkZCBjb21tZW50IGhlcmUgd2h5IHdlIG5lZWQgdGhpcyBhbmQgd2hp
Y2ggcGxhdGZvcm0gaXMgaW1wYWN0ZWQNCnNob3VsZCB3ZSBuZWVkIHRvIGdvIGJhY2sgYW5kIHRl
c3QuDQoNCj4gKwlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19EU1RTKTsNCj4gKwlp
ZiAoIShyZWcgJiBEV0MzX0RTVFNfREVWQ1RSTEhMVCkpDQo+ICsJCXJldHVybjsNCj4gKw0KPiAg
CWV2dCA9IGR3Yy0+ZXZfYnVmOw0KPiAgDQo+ICAJZXZ0LT5scG9zID0gMDsNCj4gLS0gDQo+IDIu
MTcuMQ0KPiANCg0KVGhhbmtzLA0KVGhpbmg=

