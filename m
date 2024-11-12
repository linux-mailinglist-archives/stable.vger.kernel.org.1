Return-Path: <stable+bounces-92176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549E79C4AA9
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 01:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B2D289A5E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 00:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486F61EBA19;
	Tue, 12 Nov 2024 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XBAi/gt+";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R2d5Ih/M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NhEqeazZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1681BD9EC;
	Tue, 12 Nov 2024 00:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731371153; cv=fail; b=bV0Wi1Dcf8zFItXPJ55y5S8gorhnIRq9d1q++WRhMiMiMqeHR7fEQT5IMCsHhFHPQDJcZ8HzutH2YM0rnbj2MpS1tT976MV8gmCksBkPwPDG4055gr3fQ55beGLH0xThugBllDyoAW+RdL6AQlpCslqJ9bzpppgFGVxiTQjGUKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731371153; c=relaxed/simple;
	bh=UW9C/Q1AZ8X3GwThyRVpPUDwmGYRU49BiRxtiP/5PK8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mm0xIdkkL+9mb33QQ4/IQgDjZQERMS9M4GMrsn/5/1aBs8T/leh9KDG/KQQNJ54lX5ILE1wUiRy8UuMY8vqtCq4S+4xgZ/Bgnq2gWT2O2vrExQkZvuUyEtePzqx+6kJHol3oWOFjm0ekG9GNhdx5u7PbEck6aai6NcHOTVszmLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XBAi/gt+; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=R2d5Ih/M; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NhEqeazZ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABN4MNT020516;
	Mon, 11 Nov 2024 16:25:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=UW9C/Q1AZ8X3GwThyRVpPUDwmGYRU49BiRxtiP/5PK8=; b=
	XBAi/gt+sgxQCDsTL3zl6Zn6NXaqyTrmglkzRx+q87sfAdXYlg40qeh9UTI0wQoz
	G6AIUzkqIw4pMoLGzTtkwSC3KBAGY8Pm+R8tBeChIccZvjx7psHxaB6wkeVK/Mi2
	mmuadxCm3SMKr0TTWV5nIQ2Qk8Qk0zNUB4Mwwtn8+3VbpC0ySKaaTfiCya3H9zJx
	CkzfjiWTqdtg4lSl1jErz0xgB5QEYU7fos/AWA//j3VO3tHK7faDx0QEK+qzJHnH
	KqWVW7X8dAKbWDTAVp0AxMmkkW6u6/4+SLYnyHv6CHYErBmpLE999ZhoogesCLq8
	Tyod8G4NpstO52RippzccQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42t7mtvf0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 16:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731371137; bh=UW9C/Q1AZ8X3GwThyRVpPUDwmGYRU49BiRxtiP/5PK8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=R2d5Ih/MqCtEbQeMzpNGBF2Pk1pCK05LIWEGe3cexcSLE1lxYKAbE3kwiorOioTMi
	 DFsjdSIJbT8MmPTqS7a3csKzp2BwpuISfUMY8hzu1OFlGSVJiR+Es+fcpE+7eXRwl+
	 z4lnuhuFaOBKFi7gbTujJSEwWp7IjEOfna26vTL4rtNN1u6W6WtB74OicRQ+4G0r8G
	 8bpnJg9xrh2gTZGWILRujveC0BcZlRw/w+5mNg8VwJEYfczQ4UJkxZ5auW6taCd4tF
	 D/gQp1fqq4dOXH+Fsq4tPUfoHpeez93aGZsQ9QTKGnnacU+HUnO8hTosX1Trta/Fhq
	 5Ao8mgXoCvS2g==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2CECA401F8;
	Tue, 12 Nov 2024 00:25:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id AB227A00A0;
	Tue, 12 Nov 2024 00:25:36 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=NhEqeazZ;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E55E140114;
	Tue, 12 Nov 2024 00:25:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ad4nQdwmC69Xv2AdRJ9/04FENiOzLTbU4DRFTG0VcKOjc0XqkR5gVjOuoiwaDaPRVwtkZs8m4lJk//IS1dYMdr1jvnv0GHce336U6cqQQJdODUnRATeE3NPi6lC/YBRcz/0n81M2vphBT08LYQtopqbZtdIAkgXiDofKvSDERKe5ZlT2yf3a0ymdYIB6Smxc+9xU0lWETC2fBhtPV7a+SBRy6n2dgbkXOKyWVuMntkXGzi7daJjBBdIeT4MkNXa4ScVD4VkRzO5WNgWfe5p+AoS1SaBy4nLRGuj1aWClETXGt+HSgarYp5tGcvLT3MtmBbZk4ylziq3rYxxsivaEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UW9C/Q1AZ8X3GwThyRVpPUDwmGYRU49BiRxtiP/5PK8=;
 b=uDuLKqjCDnwYGRv3Zg1xj83ZIhDwfiA54us/qepS18NffyiUrqdE+XG7mADJ6ScEyeiZLUGdIaSx/3+WjHRTjItYLj8SovGOzi1dpufCD/MOgXEG2fDEZQvgwEPGfMsVs7G9ze/m4mTMzlVhWoGs2+kqaUMOxqgj/nub6kWPdJYVhax8P4FQ7I9O0bDNsjESz5Se6ce9QfNb0b0ouJdnXh7yKt2SWmPHPDp32ev570NLYZ+gnfXH3/lYFcKChMlf6o8EqrahS55uLj9QmQmYjhsrfToX0lVycRF0DUv2gcHq/3J9+70YWEUnSzw+mrnCnzz8t9ZUEf+AfdZ1RiXH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW9C/Q1AZ8X3GwThyRVpPUDwmGYRU49BiRxtiP/5PK8=;
 b=NhEqeazZJ/3qCyh0ZjHnwK8uU9UJs6qvoLUd7omv1EvCnx7VNEqeDrEX8F56cLgBK6bTsIQ5itAfxwuHcddBUnbfMxr+WMkCF+ZakyilJm2FG8qcoIcKtIjgvVx3Pe8IC+Nk7pfA2lJUNnsA29pvp3GgknXwl+RAagyo6Gz41Jo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Tue, 12 Nov
 2024 00:25:32 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 00:25:31 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_akakum@quicinc.com" <quic_akakum@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Thread-Index: AQHbNEULP/y5D9+7QECCHsqfmPtsvLKywVmAgAAI3YA=
Date: Tue, 12 Nov 2024 00:25:31 +0000
Message-ID: <20241112002529.hcoqtr7a35zxxlzs@synopsys.com>
References:
 <CGME20241111142135epcas5p32c01b213f497f644b304782876118903@epcas5p3.samsung.com>
 <20241111142049.604-1-selvarasu.g@samsung.com>
 <20241111235345.2vpht6ck2bwojdc7@synopsys.com>
In-Reply-To: <20241111235345.2vpht6ck2bwojdc7@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV3PR12MB9120:EE_
x-ms-office365-filtering-correlation-id: b35a5337-31fa-4ea1-3f9a-08dd02b0845d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WmVYczh1ajlyWGVTZTFYeVVrWklVRy9MY0RTNWh5ZXdYaCtIR3pCWGgraEdu?=
 =?utf-8?B?b3NBZzdheWxJUEY1ejdUd21Xak1QdmFndm1iSXp0WWxnY0tZblBmMEpaWUFy?=
 =?utf-8?B?ZmQvQisxWkF2L1RhL21UNTZSQmMxS3JwbkI3d0d3VzZEbmlZdGFRRXZNMnQ2?=
 =?utf-8?B?K3MzVkFQdVlBd3ZVRjBLc3lHRmVENGNDTmVuK2RnVWlrd2xvNVNucHhlcWF1?=
 =?utf-8?B?WkZCeVM0dUpmUFJKVWk4ZlNkOVgzSXNmWDhqeEc5Z0xiWEhaL3ovMmZVdkdE?=
 =?utf-8?B?K203OWx5aFd1SGljMFJuWVdvMzEvcFdBOGRNR2t2NlJDK1JoSURqQzBYd1F5?=
 =?utf-8?B?SXR3RkFNMXBGZk9OU1Q2QVI5SS9sSG1rcG1Na1dxckhEMVgyUjVLb2FFdEwr?=
 =?utf-8?B?Q2x3blJkSzV5RUVRbU04MC95UUgzSDZzOXdNYU5OcnVJaURiOVdIcmlncE1T?=
 =?utf-8?B?SWcyQkM0YTBKM0hxbjFPYnJQbWU1c3lpZ3UrQ2gwVmx5Ty9LR1lwaFZGR01H?=
 =?utf-8?B?dzY1OE5qbHRLckkxSEs3Nll4R3Q0bThRY0NwS2p6ZjdnUjN6SjY1Y0JYV2U5?=
 =?utf-8?B?bzA4K1U4enFQckZqSDhQUGxBWmJORE5Bc1RWbzNndUNaLzBwVWQ5UVdxdzR6?=
 =?utf-8?B?ZGRmT0VocUxlaEg4TnJVcDd5QjZvUUx0UHVVblRxblFJUUhZdUxjMnFvbjRS?=
 =?utf-8?B?RFgrbUROT2JXYVRNcW9MMGFITUFTMmc4bG5td1NPclVzczc1WWQrOEdsdDZK?=
 =?utf-8?B?WmdBTVBTRXI1eUprU3NQVW5UQ0JSNkV0Q1hoRkcxMTJCQTdtVlYzWHYySEor?=
 =?utf-8?B?aUdMblpyb25UOUhKKy9iQ3cySkZpY2p3bVRZMi83c3BBMHhmR3Q3KzRUdkN3?=
 =?utf-8?B?MytlTnl3aHlWOG1lTis1VS9VTzdlVlQwdGJlOTJsZzdGSHdaZmVvRFE2THlK?=
 =?utf-8?B?ZzlBU0dMZGwxTURnNHovSFdmTVJtNHFKMjdQZ3JRUGtLZTN2aVFEaEJqU3Zx?=
 =?utf-8?B?N20zMGMxTVV4RG13UnFUb2llejlrRklSSnhmOUxmOElMNWlMNmFSelBSMUJl?=
 =?utf-8?B?aXFHcU84SDJ2SGRqbEV4VDhua0JIVy85enpBOUgxSEdKYmRDQXBvckc4RXB3?=
 =?utf-8?B?UUhUZ1JDNGxUNThXdW5xZUJ1aVU0NkJiUUZsZDdMRENsWXhBQjRkODROYXRm?=
 =?utf-8?B?cXg5L0VrRThCZ1E2c0k3TDkyMjBmM2FLQ3JkbjFyd0gyZm92RWxkdDFZUFVR?=
 =?utf-8?B?NEpuSDZDbUVxdlAxZmtqYUJmZ2pGMDBOeUh0dGFCazd0dW1sNnM4QVZQbjd2?=
 =?utf-8?B?SmovT1F1ekRrck1nTWcvK0xnelBOYk91UEQveWRxSDJ0ZE5ybGhoOTNQRk1a?=
 =?utf-8?B?aWhxc29hUHpIeGI4ZU4vZEdaVXhXQUFGbWNLMWhERDJ6T2xJMjBUV09nQ0VJ?=
 =?utf-8?B?ZFNxbGN4Wk1ab0gwZ3BKdm1RYkNoN2thWFJHTDczbnAxNFI3VDRROTlxaFBr?=
 =?utf-8?B?cCtPT0pwK0drVFIxOVlWbHF5dVZhak9hUW5lN0JNQjk3M05xSTB4L2MwQnVK?=
 =?utf-8?B?M3RaeXYzcDlXS2FpN215T01sZWJQVndGNUEyblVRcHdWYm14Mm1ER3drQVZ2?=
 =?utf-8?B?SW9UdUcwSXpRTlY4VlFGVmlIdVBlc1pmRWsxdXBsMlR6cDgwaUZZa24veWJU?=
 =?utf-8?B?eXluQVBZZm1XMFVFMjl0R3pMZE1VVFdBZVR6dmE5VlN6MWpCQWFLc1VYNUZq?=
 =?utf-8?B?dlh6Y2s5dWVhSG0ramcrR2ZuMDBwTU1xeU1CdWk4RWgwRmEzbC9ldVdud0pw?=
 =?utf-8?Q?QahXIkJEWiVpVxOuFebctorlrkPfSGc8BDemc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGREbHZOL0lKMm05UmY2aWRzNkltWGR6OFZReURnVFR0aHVkNUlYdmh2Y28y?=
 =?utf-8?B?cTQ3VEtHVlpZUHhrbk9tVFY0Y1FQUjBxaW5jc2lTUEp0R3YwUXd5THpWdmFq?=
 =?utf-8?B?NloyRFJhUmdoN20xdm1kNEhleTN4ajEzLzkzOEF6azRiWDM1QVNjTzZQNGdo?=
 =?utf-8?B?cVNSc0hqQUoyTzNrZEp0RWR6eERnTTJnSmtIMU4vYVVZMVdmZlF0amNHWWE5?=
 =?utf-8?B?K2JIOUZ2dUNoTVhXMGorbVppanQzcCsyOE9MTTZxaXBoSGJ5dWRzSjF4bnNx?=
 =?utf-8?B?c2ZZT1pCbU52bXg3OVBRejhVWXRCUnpKOTBENHJEeXB6Y3Awa3FIaklLL093?=
 =?utf-8?B?dGk5dENkREdXdTQyTy91anZhZENOVTB0U05majZPRE12RDlDN2FNRENCenps?=
 =?utf-8?B?a3NQd2lJSVpYenZoTzRvQlJkQ29YNzVnTEhaR05ZZ2hKYitoVENHQW9Gd3lk?=
 =?utf-8?B?RTU2U0J5U25HcmFQcUlyNVBpMGJrZm9rMkFjdkhBdnd2T052QW5BSzFDdTRt?=
 =?utf-8?B?d2JYZUpLbGpGOS9naGprQmV1NlRZaVl5RmNvRmw2UFNTaGloVG1hVk5uNE1U?=
 =?utf-8?B?MlV5UVRPTzNHQTV4UmRzR0JxaHp4dndJNTFzN25qNmJQYVpCS09Nd3Y3Q2hF?=
 =?utf-8?B?b3ArVUpkNUNVU0tuTmFlOS9VbHZUanZSM2Z2bXlpRXAvZWxGVHN4UzZ1YzlQ?=
 =?utf-8?B?aTNwcHBHay9qRnNreWFVWkt5U2VpbElSQjFDTEQ0RHdrclVyandJT3o5Umd4?=
 =?utf-8?B?VVVmNWgvZjdOWXFoQzZvNGpxV09JWEZVUlZlUlgwMXZmTmxpQ3JMQUZOc29r?=
 =?utf-8?B?a3VmTmdoUjBoL0Q1NUgybmNySDlUUnE4SklZNE9oenYxZTc0YlZodC84Q2Zh?=
 =?utf-8?B?c1RvdWc2a0tSbUJrNlhlTkFtZmN5KzBOMHFYRlhZemZIeVZEVGVCL0JkaEx0?=
 =?utf-8?B?SGc4emtoUFo5TVdZR0prc2tMTXFvNkFEUE42eXExdnpzZTg3VERkdENDcldT?=
 =?utf-8?B?WnA1cmU0WHptUThtNUdMVUoxNUkvR2xVTDBmTkpneDhTOHNvRE1odjBKWDlj?=
 =?utf-8?B?OWdKZTUxWkJLSlZCalIzSU9odVdBQ04vR1JucUxCbzFVTHpudE0xcGZBYkVX?=
 =?utf-8?B?NTIyNTlaQ1RMeFg0WjA0dDFZM3VIKzd6d0VVSVRHcW03T3krVEQvNFl5U0VP?=
 =?utf-8?B?YnJ1eGN4YkdyQ0lXaE1EeG5yMzBMYkNYWTB0Q3FiY1FYVFFXSGNVVUxaek1U?=
 =?utf-8?B?QytGUmhNUkx0dGtDRHRDWjJPa0pRNHM0MDk4YUxrVHkwYUxBekx3bktVTFMv?=
 =?utf-8?B?amlkbVlZSWZyaFNPVFQydEhDeXpTWnhsZzdaczJKR1BTNTA5MTc4b2hTNnhv?=
 =?utf-8?B?amQ5c0plbm9Ubzk0eEt5NWxPUWE2Z1BPUmNud1NvSGsrRXduOHpoTi95NUpk?=
 =?utf-8?B?VFBhMWt4alhBVlF3SDM3NmxTeFhLb201SVgwS25naHBvOFBpTWQ0Y2lRaGMw?=
 =?utf-8?B?MGI4b2ZMYk9hY1llbnRNK0RYbUFiVHV1N2EvRkZBMTVyR1BaeEJNTEVSdGV6?=
 =?utf-8?B?WnRreVNuRkVBeEtaZTRaV0V6M1RwMjVvK2ZkTjlFT3RubElMYjU4NklhdUZa?=
 =?utf-8?B?a09TZ2hEYTFQNUpYd0lHaXpFZWR6bjRoL01wOVpTSDNsMzFhRkJIZDF3STdk?=
 =?utf-8?B?NFl0aXFIa1Evb0lDNmVnblNFeGV0TUhFdTFWTnNSLzYzMWE5eFJxV3Y1ZE1i?=
 =?utf-8?B?Vm1sbjNrV0VKdEZ2eHZxK2Zkd1BmdnhQaFhJMENnMGVMVGlyMTN4d3FPelgy?=
 =?utf-8?B?S2lmcElZeEF2THdIS0ZZcjVMRStSa3JmeUhkTndrRloyeFQ4WUc2ZFlTUkVD?=
 =?utf-8?B?WWcxVmQ2eFBzaDVlYnNReUFZNmxRUmc1V0V5QWVOMmt3UXV3aEs0bU9mN1FR?=
 =?utf-8?B?NGdUTXFlMTRDWWYyRzhHdmd5V2s4aHJjcVE5TXBJdzNLdjBZTEJhZmRKT1JL?=
 =?utf-8?B?c3Y2WjdoaEZ1SkFrS3pFZzB0emVMUkQwSnBGbXUwbExhQWZsdEhUUGpoTVp1?=
 =?utf-8?B?aUxwb1pMdUJiZEg3Q3FJTzA5OEtrV3VVVVhJMlB1ekUzQmlpZUVvVUFMRkJo?=
 =?utf-8?B?MlFQUmh3QW0ydUFxK25TTytQRTJOK2swY2piNXR0bTFLcFQ5dXVqTVpJQU53?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B05B57E408F174C805D7230D3870B26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	59Syi04Gs6CuHJsZ4TuCBQY139YvToPgAXrHmbxo1kmlJvb4Ex/6CQ1qz9gTda+37IJj7mHuH817b9PIQoz2KCUxqtFuxbQCehZa7nU3ojM/ELolUCp6FEQlHQrLnrUubiTfDj2y1Wk+UYiHbeS43OzMViL3z4bWvo2iAkahRGSCfO3ssdXN0IVPcLVLImp5IhpA6biWcMmQgqXrxzkpiSwFHjHZU9o+RpYd+PgMApQC/2xbYEl/LYQ+2UJ4qyNFDYvLqPSdXixDK+UKTGt0UoLt8TIxgDodIPAFSnc/BnuhaYsEi0JHXasoT+LKwgSR6HmihtFQeHNFPkVv3xy2V6p5hODj6Cokg0hAMnOKJq0Zt2e1UaSeSD2hiIPptwiVeNq6GqsJk4lk8fvF5TKPYn8wvDEYMs42pPxhPXK+Ou9320BvONvANwnjZJHsWkQ9VjKOjc3Ho34axIxCegm/cguXKfTO/8QOmYmjm5xpgf0B5/Sqm6sOcka9XzLBNcDsd57sTNKRdX0LpQXfsjZGNaAcF2z9JuD0Es0bSmCU741kMtGoCCeA4CLlJEJhN/8AgjWw4y3g8i84TxKKNVvdj+DH044GvYT5xsY4uzd39kVBLGIeQn+P2zoOUtqmJqK5B3AzfdcAEiYvyKcNLpZV6Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35a5337-31fa-4ea1-3f9a-08dd02b0845d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 00:25:31.4448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LisH7j72+wslnwioVYo/UsWMRjZ0PYdbIF+xyL62J04pPNHXNIhX9I4EA5J3GtmtXVf2eVWXRVElBdQK6+mT3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
X-Proofpoint-GUID: iLxikqUh_i7qTUuLPhq-hlJEC0CdjmlY
X-Proofpoint-ORIG-GUID: iLxikqUh_i7qTUuLPhq-hlJEC0CdjmlY
X-Authority-Analysis: v=2.4 cv=Y5mqsQeN c=1 sm=1 tr=0 ts=6732a082 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=-lfundCfXdeh9JgvHQ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=861 priorityscore=1501
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411120001

T24gTW9uLCBOb3YgMTEsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiArLyoqDQo+ID4g
KyAqIGR3YzNfZ2FkZ2V0X2NhbGNfcmFtX2RlcHRoIC0gY2FsY3VsYXRlcyB0aGUgcmFtIGRlcHRo
IGZvciB0eGZpZm8NCj4gPiArICogQGR3YzogcG9pbnRlciB0byB0aGUgRFdDMyBjb250ZXh0DQo+
ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X2NhbGNfcmFtX2RlcHRoKHN0cnVj
dCBkd2MzICpkd2MpDQo+ID4gK3sNCj4gPiArCWludCByYW1fZGVwdGg7DQo+ID4gKwlpbnQgZmlm
b18wX3N0YXJ0Ow0KPiA+ICsJYm9vbCBpc19zaW5nbGVfcG9ydF9yYW07DQo+ID4gKwlpbnQgdG1w
Ow0KPiANCj4gVHJ5IHRvIGxpc3QgdGhpcyBpbiByZXZlcnNlZCBjaHJpc3RtYXMgdHJlZSBzdHls
ZSB3aGVuIHBvc3NpYmxlLiBNb3ZlDQo+IGRlY2xhcmF0aW9uIG9mIHRtcCB1bmRlciB0aGUgaWYg
KGlzX3NpbmdsZV9wb3J0X3JhbSkgc2NvcGUuDQo+IA0KDQpBbHNvLCB1c2UgdHlwZSB1MzIgYW5k
IHJlbmFtZSAidG1wIiB0byAicmVnIi4NCg0KQlIsDQpUaGluaA==

