Return-Path: <stable+bounces-67731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D03952776
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 03:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB80284B2E
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8353D9E;
	Thu, 15 Aug 2024 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e0KbUxGa";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eMYyPlGm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RO45PujK"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18C36D;
	Thu, 15 Aug 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684731; cv=fail; b=BLEomdgvFNYt8BlhjfKq0ZMZYDydj7FNCp/XGkFsB1FMHAeksu+/spuRhrUFpTVZKFkczcSbNrF68IGu1hXcRfUPaKiZ29/k6StL+0uvDCtxZ4LtIhhJ/divNxnKWwig/4a6pPzF4Z56iVT9YEv+CVWXkvKYfpaI6y2D5XeAh8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684731; c=relaxed/simple;
	bh=9ZNu1kkl19Ckq0FqZQ/Nj7aYRsyL2QUKncNowqc2DHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W3A5Yx6Dn+u6HEae4VnSpD6H/WFTFJwBZ9Nud/ckB9/7UIDpV7mckmZk5jjlDZW9oZb9fYzn6WoOCu8OsRs+rOTNBbp/gSK5WkD1jss+vZDooS8kEutCcCVhfaVhlyjTUlbbmNWeP/fbBueDRz1U8d8RUqK1yFjAC1cVauajDxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=e0KbUxGa; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eMYyPlGm; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RO45PujK reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHrwd4001412;
	Wed, 14 Aug 2024 18:18:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=9ZNu1kkl19Ckq0FqZQ/Nj7aYRsyL2QUKncNowqc2DHg=; b=
	e0KbUxGaM4cEJWdvkVLSdG68VIr5YiwtNM2VpYz1EIU9teR4B83k4nej4cuJtW5q
	q8oma03zgXS9Ng8hivnV1XiaALPno8AfNo0ObzABnYYjSlwHLtXPblP3KxHp9HKK
	yT5d95hXHE2FHQE8HIODRDOmzK6E1+QHdiozu4HSXW0VMJtiORjLJ2SltQlNbO65
	abSzUr7EnznMuumgQ+WD6l5WvJ0UL+82jLXpJTxvXxncUySYzNHGwd1gixtmX52b
	cvk4HUBn46ERwp0wvoPNSFTOFwr+CSPKroNcpehmczUVebIHRaGKMjWfht0+g5oT
	1ArylaL1X3s4ciR1XFIK6Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4111cr1eyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 18:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723684704; bh=9ZNu1kkl19Ckq0FqZQ/Nj7aYRsyL2QUKncNowqc2DHg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eMYyPlGmbikr8sHTgvoSD9UgdUrzJ+ZooYYQuXDSS+EcPzC9Yir69HMprenfWJ13n
	 X0NT7Q8gLVfnsBEhR7x0aJ8YBX+w3RFrSh57Gr8JSLefwaTEmAB3bddkpx/xIODGW+
	 MTUovPp3UkJolebqIHnQ7Eo6SItSwF4lsMU2JUMOVkdCaTUx7ZA9436e6qQjy3NEQk
	 tVan6ECpU42PafRHR1g9+l3gUW5Oo3/vZc5BgpoHhm3chFMej9IiZGGKwlxG8bLHe1
	 zdxT7lbfRz0Fhrh/DKyEIN+medO/07aJjPJx2azI9DeMoIyduMn2cWqC3N9tpYPtd8
	 IlGFi4lyhSVWg==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3A93140147;
	Thu, 15 Aug 2024 01:18:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 95345A006D;
	Thu, 15 Aug 2024 01:18:18 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=RO45PujK;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7B6B840149;
	Thu, 15 Aug 2024 01:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgrwLSp+zmWuUqPbYMgoNpnGX/EAPZLtTm8MlXlf3MjhTxa400BM6p5tA6PehchE4+J85b61uLX0OKUfNnCw3hFq8WDP67trdo+1PXXMhdGIZ7RFMEHSQqjy5FeM6tvWU4/Bu+Fch0+/TzwUUMVQHxKmDK8vHALi6bXkD3a60C2genXDC8tIDnLHushipx8Uv+BDH2oCDFEyNPg2hMSCpJrjUE033YgNYdjY1VsMQ/k68fJeybn7Esmuv1syv9pQZgTao8gDIsQKr/uCv5WzSQoE793h142dUhvRG+wQgBjONatkDzCWZvird/IrjZVEXJ4p9ycO0iS+mEIjzayt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZNu1kkl19Ckq0FqZQ/Nj7aYRsyL2QUKncNowqc2DHg=;
 b=UKIMLU+jP1ryz+STOuIYMcqEtZUBFApQIxHfK3r69FoYHxf7ibCZVuxHCH6qcB8c1/NHw/y2M5wvivQ0bKvBX7A52GPnptpJSjtjPPu7r+cGCRdn7zHVEaruTyYJ8dCY/y3lsbr7pDjxopdiQ5/ZiUxvIovxb+8XNupeNUc9Adq+HXG5xN/IcIUgIuXcxmqPUvCfBgOQm2o2H3nvKGNH5+2mNg7G9dYItQ8fxNEza5tApbN3akZAHgLRAfaJhFteEwvhsESIYarrFbZWgfMREnx7hYEdIS0VdkWLaUnDhRRDwf2BsS5fvM5PuCf+QINL+64+qnCiUDj7PiA4qHXuCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZNu1kkl19Ckq0FqZQ/Nj7aYRsyL2QUKncNowqc2DHg=;
 b=RO45PujK1Ql2DgBSfTWQEGAjvdtNfPEAcQpGxF1dHW5FjqUPWfv9eu2wkQuTkgUxcxOwBLnayoAQxsF3mZzyIDbCDmf2d23t7IBaEYDPWk9DXIU0+0VXF7fShIIwZrAgE8pKcKNXJRmViCNFyhwfEoxeI1zkAqr2D7OjbAJdNug=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 01:18:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Thu, 15 Aug 2024
 01:18:14 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Sergey Shtylyov
	<s.shtylyov@omp.ru>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
Thread-Topic: [PATCH] usb: dwc3: ep0: Don't reset resource alloc flag
 (including ep0)
Thread-Index: AQHa7nDk1dgqkywC+0uFNhKLhSI/DrInN/GAgAAAeoCAACDLgIAAK+MA
Date: Thu, 15 Aug 2024 01:18:14 +0000
Message-ID: <20240815011810.3bwdhmckcuhtimbu@synopsys.com>
References: <20240814-dwc3hwep0reset-v1-1-087b0d26f3d0@pengutronix.de>
 <c0e06e73-f6d1-1943-fc83-2cf742280398@omp.ru>
 <e26d660b-ce53-6208-d56b-b33a1d1b22be@omp.ru>
 <20240814224105.3bfxvq63zpa3gjzv@synopsys.com>
In-Reply-To: <20240814224105.3bfxvq63zpa3gjzv@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB7166:EE_
x-ms-office365-filtering-correlation-id: a9a4a472-96b5-400c-b2be-08dcbcc822e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnFhWUxzY21XbmpWdS8vSk5ZQ3JhRVkwdEovNkw5Z3NGcW5mVnZ1NEdhTGhI?=
 =?utf-8?B?WkxuSDBQMDIrMDVnc1pyL05FZ2dLajZaVFBJSVdtYjRpcGl5Tjh2R0h0MTNx?=
 =?utf-8?B?TGtRR3ZMTEhPdkt1SzZTL3d6clMweDRyN2RDdG44Ymg2b2FPUFNEaWhTUzhl?=
 =?utf-8?B?d2ZSUWYvWm5wZWxDMEZCNzRkMHF2Y3ZFMWFVRXBwVTVSTDdDMmpyblBCK1dO?=
 =?utf-8?B?OWF1RkFuZEtuLzRRT0hTNW5MdlEyZ1BYNnhRU2czM0U0cXZFODQzRE5PQzQ1?=
 =?utf-8?B?bExlK21oUGl3bnlpNklMRURWL3hndk81c3JSRzVtV0tHT2djYzNvbUhNckw2?=
 =?utf-8?B?blQyeGt0NzA4OVR2YnQ3eVg3SUlWT0tVSHN5UWJyTkQ0OXhJMjZUb0xDVFZX?=
 =?utf-8?B?U0Z5WHJ1TmxaVkI1SVJTOVk5QnZDdjVUUHJBVG9qWHNOQzlsdHk4Zm1pbE04?=
 =?utf-8?B?empGbUlZazh5bGZUeEhibURWdkRNd1RUODhueFdaZS9Vc0liT1hSSHMrVXVB?=
 =?utf-8?B?Sk9rd2tHUCsyVkY1aWNJZVFVQkpqV3BVWHhZUllxTkk4R0ZpZlEzWU9JS1Vj?=
 =?utf-8?B?N3VFYmhuYnB1ZWFsZi9CN1ZBcjNrT2NaeEFkbCthUDhJUHBva1JOVWNCZmFR?=
 =?utf-8?B?R3FjalFaSGp6T3NkR1c0VUNyQStUc3RZQm9mSFVrcUwxSEk4ckRIZEYveURo?=
 =?utf-8?B?eUUwbnFNWHBoWWgzWTZCUmJFMHU5eENXQWUxOFVqVEwzanFXWnF4NTZlRFox?=
 =?utf-8?B?NUluV0E5NVIweVFXbE1uM0NXR0VBVmk0NkNBVXE1eUZvMStMbk5wUmFwblJP?=
 =?utf-8?B?MDU3RnRsdVAzMFk0VldJbGtkTklHYXpwMEdKSmdSeUVMNEI5SC9oWWlUdFlo?=
 =?utf-8?B?ZS9rYS9UR3h4WjlSRStxOU9hZEIyTUp6bFRyY0liVzNzNGlrOFpGR2liK0Qz?=
 =?utf-8?B?MUdYRTc0bkZYbmk0NzFyaDdab2gza0FkbVlZZWVTNDJyRzR3aEN0K1o0N0R5?=
 =?utf-8?B?U1d6Vi9lM1JzNkFNa0JSWjhJb29xSVpWK3VNZytUeUJnKzM1a081VU9aUG9G?=
 =?utf-8?B?c3lXRVdkUWVVdWQzc2pCMEhnT2VzMFR3VkE5MGtQTlkveTNqYzBtVGFKVnFC?=
 =?utf-8?B?QUhhYnhBTEY5T1pvbEVuM1ZVb0RMWVVPb2pCdXg3dC8wUk5YdStocjNzSEN2?=
 =?utf-8?B?eGxoNHFXUU00RHdzVmJGRGF3YVg3cVY5SGFjYVFoT0pTTHBWcFUzU0RISDJC?=
 =?utf-8?B?VzN1M0k0MHRZWktNRm1pdm1uTE9UUjllejRWdlp0cWNvRm5CZS9SdVlVRmpw?=
 =?utf-8?B?Q3NqcnFoRzJKR3Z1SVl0OUIvaWordW5mYnEyRG5aYkdPak9Wd2xQaVVjTkIz?=
 =?utf-8?B?VzdtZGNlbXhCMTRhd1J5M1ZEWk1QRWNzTXV2RFJKK1cyTUEzRG5JTldSSkph?=
 =?utf-8?B?akNvNWFoR3BiTDhTU3dCeE02WXdzTDl3aXA3YUtZZVQ2WGxYQmhVaXhrcWxV?=
 =?utf-8?B?WFFJMFNic1dSMjlZWEdDMTlPbHNnbEkveGU3bkN0UHJDQVdJRG5zYjZQSjlr?=
 =?utf-8?B?T1NaM3Npb254ejNaZ1Q5Z2JNQTZCWUNkZ2FYRjVWU0JONCtTekltZDZyNEts?=
 =?utf-8?B?TjdBR3diZkd0YWxYOEVEcTN5eWpGa3h0T2Fwd3lxWUc5cElLV2htM2JEQ3U3?=
 =?utf-8?B?Y1BrVUtWMXZiSEdUOUV0b2c5SWdPK2VTQUN3T2FMS1RzTVZZVnEwWVhOam9H?=
 =?utf-8?B?b3lTS0hhK1ExaWxHVE1KQnlDQmRlRXJrdndhcU9IMkxSTGVJSnJBa3h2SHpM?=
 =?utf-8?B?QS9MM21RdzdZeExTMUJ4VG43ZTlYQnBUQ2lOeW03RVQ5b2dORmxKVEtMWnQx?=
 =?utf-8?B?WkNoTWlKTzlUZFQxcU02bktSaFljVVB1UGpocXdCalA1NlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2NLdGczRXg2MERzbUo5OGZLRU03bHVqQ3luOEpDSmtkWk5YWTNpSWdRQVd2?=
 =?utf-8?B?V3RiVDNsbjRTdk8yME0vUDlaVi9ONlBGSEtnMDJ3NDN0YnNHb0dDZ1hqVnRu?=
 =?utf-8?B?ZkRiYlIrSWdWcWp0SkFtcWRmbHNjS0FUWEl3UTdkWHNzUXNtM2VRbW1OMVNF?=
 =?utf-8?B?Z09hVEJaRlFST0VSR2Z1VXNlL2IwcTNWUmtlNlFaeXcxL292WENHSFhQVWta?=
 =?utf-8?B?UHBKTGQ1NlZJRldINE5RMUZQVG5EOFZQdHRxUXBFOUNnSmN0UGhCY0FHVGJs?=
 =?utf-8?B?N09iSXh0ZXNvQ2wvY0JkMUFld0dBUzE4dlRYYUFjSldkUHZwampBUmV6MHhJ?=
 =?utf-8?B?YSsyTjVMMUxFZDlyaXhSY0c5SWJQVU9xZDFLWFBNSnc0YjhzT1MzeFBWY1Vx?=
 =?utf-8?B?amZnR1hlM2FucGxhVlJMRjkyVWtacFc5Uk1tSHBSQVBMQlA4N21SKy92bTNY?=
 =?utf-8?B?V1Y3bndkMk8ydHJ0djU2SHNEY2xMSTBma204YU0reXgrN01sczVTNXR6WVk0?=
 =?utf-8?B?VEk5cHpVWHFFODM5eWFSM1pCSllNSWt3NmdTN0UyYnliWWxIVEJpK1YyTDBz?=
 =?utf-8?B?dDRaTjJTTjhhUk9TZG5nMjR5eFBZOCtiNlB4emgxcVJXNFFlM29IZ2tHN0xY?=
 =?utf-8?B?L0w4cWFEdEc0c1ExS3M1U2VWQU8vSnFJcmEwcDFKN0cxZmsvR05jbElpUEY5?=
 =?utf-8?B?RGpncDZNQ2wwa0dESkxHUW5jaUJHc3Noa1NJOWdqWnJEaFZNTVdHNGtOOGd0?=
 =?utf-8?B?YS9QN253cm04MUtPTUNjMm53RDB0OTBsK3J2YTlHRGcwZ3lLSGVFWW82aW0w?=
 =?utf-8?B?bzZsTkZtTUJoeTV4RlJUZnNsdjAvRHRoNGxVbldYZGgrSWVDN2FrNzhUWVVH?=
 =?utf-8?B?UVVpYTNNa1VZcWlTaW1ncEdZZkJwaHkvWWlRbHVRcHVhVWdJNWxqVFlvaGp0?=
 =?utf-8?B?MWxVWmd0aXhwSTRJL0ZrWjlhbEJQRUVUd3RGL0ZxNjBFVjZqQmY3bHV4aC95?=
 =?utf-8?B?QldMREMzZXRxeHZzWmJ1eUg2eFdlUkJRSVgwbm03VVhoUnRWbVk1akhVSTJN?=
 =?utf-8?B?L0hvR2dsMjFtOW1CMUIvdGJCTUdtVVVoNW96ZkZPdXpQN0tqMENrc0RvRGFj?=
 =?utf-8?B?N09iODF3VjhMNWYvVTJrc1hWa0tlVTJoYUIwbmVIMjZUeWNsSzFlRG4zWXNO?=
 =?utf-8?B?Rng5b3BBcHZnU2c4Y1Rvc24rVUpDOEYzU1RZZkQ3Y2NFV0JaT3JUbXpLbUh0?=
 =?utf-8?B?RFhHdmpSVGcwdzBOcDZmZGNNM1ltMDJNVnNNMHFueUtLRDh1azdUd1Y2YkFD?=
 =?utf-8?B?SlNqelBETFEvblZhVXdhcU1VZm9NcVEzK0psQjlUMmp1VFJLUnF4Nnc2ZzRp?=
 =?utf-8?B?TUEzSkVVVGFlRTZZUFRHQTZaQit6M1lxWWJSZi91akhGS3JGbXNlbjFSeUI2?=
 =?utf-8?B?NUNPbnAwUksvQnpiNi9hTG9XTXhpdWlCNDFKdmNQaDhUNnQ0MDNLM2ZaMVlr?=
 =?utf-8?B?T0Vsb001akF4Q3FlcDRCY1Z3UVlMWmpiTVF2aEJoNFpGMmtPVmdESXJSRVlk?=
 =?utf-8?B?cjM4YUpwYXorcUd5clZ2aHBuaW54aXIxaGFibC9GY1plSTR3aHc0SmFDNjdp?=
 =?utf-8?B?dVMyZUNUcnlqeTRicGtIWGdLVU56ZDFrVER0ZUFPM1VDMC9iam5xcG1nREFU?=
 =?utf-8?B?LzhqUUlqV3E3bUxod3lLbjh6dmZWNTlKbXM4NklkRmR1b0plM2pHRU9ZSFFP?=
 =?utf-8?B?RHkycmVORFVNbEVFaDNQa2ZNem1lYXMxNUV2QzlnS3lpZ1o3OVUzbGNjRU5H?=
 =?utf-8?B?Y0FGNkZSZU1Ta29lWGt5alJhaGhTUFFLcFVQTkJTMnBKcmxkWGxwZ0lsZ2d4?=
 =?utf-8?B?RkNPUWJ1VHVvdFVLbUNmaU56OXdZMVl1YXN5RExZWVBna0FIUy8xUDQ5ZHBW?=
 =?utf-8?B?dVlaSUtkMDZFaDkvNkdUSi9kTVM5OW5lclFLK3AwK3BaSlZMU3lHbzdZRDJI?=
 =?utf-8?B?eEgzS3VLMHh0ZFowdkI3RUswV0J3Y1VER0dpY3ZqNTZSQ0x5Y3VhVHowR0sr?=
 =?utf-8?B?TDlZZm85dXBFenVWUHIvTHRuTk94Mytmb1pjQzhQUFowVkZYR1J0M2xZejh3?=
 =?utf-8?B?cU5jdU1SOC90MVkyZVFSRk12SS9XUzlYemRja1VHNzY4emhHV0RHS2h1eFRo?=
 =?utf-8?B?Snc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32B219953AD95349A66C07D95C623C30@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	46y/3/FCLSLfXZ23doPiH8wt682yGOC3MwAqWvPC2wjHtKg0Gip129aFWFtKL+oz2dF0l7h6AgtNCG+4k9fKZMoX5oJ1MIWXV0Cgax66TnkI2VuDXHA2s3cpbINNHacKIX2djeaO1exEfpmIgmVb/RXuaZN7eLaHcRbdL0HUMUJaSJ081MHfYZI77OCeFGDZ84x8dmZoPJYbx+2KUAYaFnRQTtoiQ21tALYdgXakcuXql9z0Z8DtdUlIB6joglIsH0EzfjZmSELqUpq8ENt6vHAPR55NfVvuxrCMKL7uYEWvEEXYgsTivG2o4IEJ/ntd0ggiDSHsqL//NaHZWtG74CoJAwv4/mcfRciqkAgG9NhZyOcvAIWkOsgZTIuDm3XmPpZaExolYdkJmBr5eeiTbeyGyjWZBe8Wet+uJviri+RIupzaBHDjwbwc2t8ZfVjI4QkZA2xaTdufid3aoRtCxKKAf74NYrtyWssckVNttcCMrVgkqsV9yhFQLArIw89b65nE847Zg4ChwJPMUy2sKPMNSwhJqLz1J5PmCmYFjpWdP7iPtFr4M/cq/3e1YV7xLkrtffWHRUwGmfY6F+ATGiC+vn5G2AviK9pP3ZToQMAmnbznPrJEet4a0ZhgAvU/KEIgIZWIiKE6Mwy4u6SBdg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a4a472-96b5-400c-b2be-08dcbcc822e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 01:18:14.4072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnhoFCRtxxM8n592G7Q2eEHwbaAoLG4Z5p1bTSgd/1PH5dX33ScTUcIdeaZGUQH+qu5QslABS1wbxkgLgvnzFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
X-Proofpoint-GUID: snP1oF5WaZKdDX-l6cx2smzCGytkfMWR
X-Proofpoint-ORIG-GUID: snP1oF5WaZKdDX-l6cx2smzCGytkfMWR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_21,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150008

T24gV2VkLCBBdWcgMTQsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gSGkgTWljaGFlbCwN
Cj4gDQo+IE9uIFdlZCwgQXVnIDE0LCAyMDI0LCBTZXJnZXkgU2h0eWx5b3Ygd3JvdGU6DQo+ID4g
T24gOC8xNC8yNCAxMTo0MiBQTSwgU2VyZ2V5IFNodHlseW92IHdyb3RlOg0KPiA+IFsuLi5dDQo+
ID4gDQo+ID4gPj4gVGhlIERXQzNfRVBfUkVTT1VSQ0VfQUxMT0NBVEVEIGZsYWcgZW5zdXJlcyB0
aGF0IHRoZSByZXNvdXJjZSBvZiBhbg0KPiA+ID4+IGVuZHBvaW50IGlzIG9ubHkgYXNzaWduZWQg
b25jZS4gVW5sZXNzIHRoZSBlbmRwb2ludCBpcyByZXNldCwgZG9uJ3QNCj4gPiA+PiBjbGVhciB0
aGlzIGZsYWcuIE90aGVyd2lzZSB3ZSBtYXkgc2V0IGVuZHBvaW50IHJlc291cmNlIGFnYWluLCB3
aGljaA0KPiA+ID4+IHByZXZlbnRzIHRoZSBkcml2ZXIgZnJvbSBpbml0aWF0ZSB0cmFuc2ZlciBh
ZnRlciBoYW5kbGluZyBhIFNUQUxMIG9yDQo+ID4gPj4gZW5kcG9pbnQgaGFsdCB0byB0aGUgY29u
dHJvbCBlbmRwb2ludC4NCj4gPiA+Pg0KPiA+ID4+IENvbW1pdCBmMmUwZWVlNDcwMzggKHVzYjog
ZHdjMzogZXAwOiBEb24ndCByZXNldCByZXNvdXJjZSBhbGxvYyBmbGFnKQ0KPiA+ID4gDQo+ID4g
PiAgICBZb3UgZm9yZ290IHRoZSBkb3VibGUgcXVvdGVzIGFyb3VuZCB0aGUgc3VtbWFyeSwgdGhl
IHNhbWUgYXMgeW91DQo+ID4gPiBkbyBpbiB0aGUgRml4ZXMgdGFnLg0KPiA+ID4gDQo+ID4gPj4g
d2FzIGZpeGluZyB0aGUgaW5pdGlhbCBpc3N1ZSwgYnV0IGRpZCB0aGlzIG9ubHkgZm9yIHBoeXNp
Y2FsIGVwMS4gU2luY2UNCj4gPiA+PiB0aGUgZnVuY3Rpb24gZHdjM19lcDBfc3RhbGxfYW5kX3Jl
c3RhcnQgaXMgcmVzZXR0aW5nIHRoZSBmbGFncyBmb3IgYm90aA0KPiA+ID4+IHBoeXNpY2FsIGVu
ZHBvaW50cywgdGhpcyBhbHNvIGhhcyB0byBiZSBkb25lIGZvciBlcDAuDQo+ID4gPj4NCj4gPiA+
PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4+IEZpeGVzOiBiMzExMDQ4YzE3NGQg
KCJ1c2I6IGR3YzM6IGdhZGdldDogUmV3cml0ZSBlbmRwb2ludCBhbGxvY2F0aW9uIGZsb3ciKQ0K
PiA+ID4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgR3J6ZXNjaGlrIDxtLmdyemVzY2hpa0BwZW5n
dXRyb25peC5kZT4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGNhdGNoIQ0KPiANCj4gSWYgeW91IHNl
bmQgdjIgZm9yIHRoZSBkb3VibGUgcXVvdGUgZml4IGluIHRoZSBjb21taXQgbWVzc2FnZSwgeW91
IGNhbg0KPiBpbmNsdWRlIHRoaXM6DQo+IA0KPiBBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGlu
aC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiANCg0KQWN0dWFsbHksIHBsZWFzZSBpZ25vcmUgdGhl
IEFjay4gUGxlYXNlIGRvIHRoaXMgaW5zdGVhZDoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQppbmRleCBkOTZmZmJlNTIwMzku
LjliMDY5YzQ2NjNhMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCisrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCkBAIC0yMzIsNyArMjMyLDcgQEAgdm9pZCBkd2MzX2Vw
MF9zdGFsbF9hbmRfcmVzdGFydChzdHJ1Y3QgZHdjMyAqZHdjKQ0KICAgICAgICAvKiBzdGFsbCBp
cyBhbHdheXMgaXNzdWVkIG9uIEVQMCAqLw0KICAgICAgICBkZXAgPSBkd2MtPmVwc1swXTsNCiAg
ICAgICAgX19kd2MzX2dhZGdldF9lcF9zZXRfaGFsdChkZXAsIDEsIGZhbHNlKTsNCi0gICAgICAg
ZGVwLT5mbGFncyA9IERXQzNfRVBfRU5BQkxFRDsNCisgICAgICAgZGVwLT5mbGFncyAmPSB+RFdD
M19FUF9TVEFMTDsNCiAgICAgICAgZHdjLT5kZWxheWVkX3N0YXR1cyA9IGZhbHNlOw0KDQogICAg
ICAgIGlmICghbGlzdF9lbXB0eSgmZGVwLT5wZW5kaW5nX2xpc3QpKSB7DQoNCg0KV2UgZG9uJ3Qg
d2FudCB0byBjbGVhciBvdGhlciBmbGFncyBzdWNoIGFzIHdlZGdlIGZsYWcuDQoNCkJSLA0KVGhp
bmg=

