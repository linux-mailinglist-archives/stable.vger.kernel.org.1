Return-Path: <stable+bounces-169680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB84B27401
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 02:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A4A1CE4771
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFF19DFAB;
	Fri, 15 Aug 2025 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="oCBcYYhk";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YwEHS/oj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rEdytVBp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E09118B47D;
	Fri, 15 Aug 2025 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217645; cv=fail; b=QVjgGrUdppcEi5FWL//Tc0j2pKyMSkyWFbPUbT38yxtYftXilGuXIm0L3t+YhHDBWRrMrQ37h7n1maK5WivHk5PNLc2DVWZvquQySReenT/04M9WiQwoVfFQnqho9TLhCEWc8aKtDeaztJ58St3MvMmFJqfz/BWZ7Lmo4/Ep6TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217645; c=relaxed/simple;
	bh=BTGBS9lQoZLeubfkf+Eo606sCH7uAM+dQs763V+d5bM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oGy1pmyM7/wz2L53Y4xEEDiRPmO1JCJ7FzvskQWRCsrCJ7sw8+SD6Ls/VmQznDxLJJlHxgfUkqv4T6Nct2yv8CrG8jwlR4Mt57lTXSMhwaMxAN1MNKLeXHrh34zKA0QuRaPp0iWZ+98rY5biwX9gl/mgx8wKKqb0W6k1SygABbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=oCBcYYhk; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YwEHS/oj; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=rEdytVBp reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57F092gg020606;
	Thu, 14 Aug 2025 17:26:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=BTGBS9lQoZLeubfkf+Eo606sCH7uAM+dQs763V+d5bM=; b=
	oCBcYYhkJiqBgnhFPqhp0mrfqekwt6ANA2RPbfDOkyq34RHyxcb0/AJbnzZIUBwq
	LMvD6je7tVxESQY2iI+O2h9/EyMvEeaI1RWrX7iIjDxdgjGUuW3k5Ld+yU+ML0jm
	x5AMeFfE5NzQnRsEowgRPFBsyGHVxE7aFAUEANom51cxXrqgwb7EByBHHGBjHqmP
	8yArxMFsjuHxEV+KYk8IF1R+wRmgo5MgLTlEP2PM/4zgxN6VFYITkI2R/SGX2+ae
	AIYPpR/DQpt38Bn863rcL1jnQuWKcb4gSgJ+YUGwyy2JI6Ehjzno6fBBEmKBGiFq
	xxPymoYz6oyTUz8VMX8KDg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48e58tv7b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 17:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1755217601; bh=BTGBS9lQoZLeubfkf+Eo606sCH7uAM+dQs763V+d5bM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YwEHS/ojKcwb7mBepGaTPYWvsD6tbnOpFFUEK0VwuKWanzuLyixBn1NZCvRI5m+d2
	 2TFGR5DEC7IkJr+oCdR4OSGB3jekQAbhzFv4yfVWn5ij0Oc5RRCAVoHQWM1BkG4eGX
	 kg5xB4iO2tLK2jrl3z4LNs3oFps+sVHDbhTFg8X4RLv9s8KJhBfuMYC55PyQMQcp9B
	 kQhMBoAnMs70h3jmYirh8EWlaazMR6K50G7prEY/wQE5zIizWBjddun6Ed59wfDkvL
	 r1XyDBsYzBdwFxU4z6aanfQY5IUts+5KbPXcvdejah83GyLLEBe06qSMf/jqwl6s3L
	 L0yvbI4BVXrKQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EC82C403A2;
	Fri, 15 Aug 2025 00:26:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2A79AA00AA;
	Fri, 15 Aug 2025 00:26:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=rEdytVBp;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 94018404AF;
	Fri, 15 Aug 2025 00:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqoY175Ctl0PwVD2dX8RcZWIk8rlM8QcK3C9+wqJqhQ5mON68OJZpKJEP2zzPs3O0tf5uFGaxyToogeKqsC8fjVCfXd/Ii1EjskyD8XYRsHuX6d6PgHLA2dNx0vc7KJKJg87qVC2R127P+MMJNeO7MXENaNUXEIY1wMQUTHvg8ooVuEq5A3+tbJed3DO1CzrKHbMMFefBDCKihal0G+VKQk+5HurNTZ7JFVEp8ZTUWr+n4hweITdPvdxYDPJ6UXdsDR2aIcEhQh0njhI3A+FjkhnV/XEkCqV7bPbZSseI7sOcPdAleWbQsVhdbLaRaT0zM0RCqpmBPmKVxB0+kgEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTGBS9lQoZLeubfkf+Eo606sCH7uAM+dQs763V+d5bM=;
 b=ia95Rgtbg669XIHLuEcd+PS5DtLcOQZzN1Tl/i+UtisbeNnOk/P63OBC5STW/hKVX0dEecQK0cbcDHyqlRFmfaT7ZaG9wP5yTrYtrhsjFrTi2tpsR/sQbfyxKkbegzbVUUko7nkBDiO3AvKsasdz/IgcYpWoY1EGqwzd8+jAkOytuD5LDGQlisqKgjfEpQH2nEVarQVds7mzyos76+w8buf3WCOltEboRgWMl4MLD6s6be3/7etBfvynjxBZbBQRJXxhebmxpiq+9Am0yI2C+Q9naYzAHAVl+3dlgzyVN+poD7F8/8vXOBGyGA3sdNxxKLBO6wVLIZ+QK9mrH9n6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTGBS9lQoZLeubfkf+Eo606sCH7uAM+dQs763V+d5bM=;
 b=rEdytVBpWXaXSRZc+SS541RY4/M1nj/pULciyW2YVOJNQzwXSRgzxo5iiDYtkNDwoI1J5qc5U4CjMwwdAA9codpxwkTQAoU+DWF8YrQB37cSlEo9+JRL+/ouQxz2Nf5U+1trO8V+P1G112hJSE8zLoyhIealvXSkjEDEjP/q0fc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Fri, 15 Aug
 2025 00:26:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9031.012; Fri, 15 Aug 2025
 00:26:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Selvarasu Ganesan <selvarasu.g@samsung.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "balbi@ti.com" <balbi@ti.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Thread-Topic: [PATCH v3] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Thread-Index: AQHcCGOsyp1KdhVvcEqBHZtDtXw9j7Rgrb2AgADwRwCAABH5AIABNbsA
Date: Fri, 15 Aug 2025 00:26:33 +0000
Message-ID: <20250815002632.wjazxhscdkaelp5p@synopsys.com>
References:
 <CGME20250808125457epcas5p111426353bf9a15dacfa217a9abff6374@epcas5p1.samsung.com>
 <20250808125315.1607-1-selvarasu.g@samsung.com>
 <2025081348-depict-lapel-2e9e@gregkh>
 <f9120ba5-e22b-498f-88b3-817893af22be@samsung.com>
 <2025081442-monotype-pony-83ed@gregkh>
In-Reply-To: <2025081442-monotype-pony-83ed@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7914:EE_
x-ms-office365-filtering-correlation-id: 0675be1b-7649-4125-ad10-08dddb926352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUswZXpiZllsWlZOazFhcDF1V2o2K3h3RmJGN0VmOERWbmFkSFJ6YmYvcG5n?=
 =?utf-8?B?NWVLUUQ2RCtFc0dWR2lScVFySzczRGZEakFuNWFGMndiWDFvTGZyZnhGV2Y0?=
 =?utf-8?B?Ky9aNFZpd3ZlN2t5ZU80Y0xNaTNraVZXQlVkN3NMVkxiRUxzU3BVQ3BSRkYy?=
 =?utf-8?B?Qk8xQ0pPL2hMaFBhMDJnUmhjaGxyQktOZitUNXFleFVvT2lLN2JnRnRJaXFt?=
 =?utf-8?B?amY0czVLK0o5Y25ybDNsZDAvUE9YTXpuVW9hOVRaK0hkaXYrUUhkYW5SbEtw?=
 =?utf-8?B?UnlmUXZmYkIyVGdzMmhIT1JXVjN3d0NBSFpNa2R2V3NyVEFnWGhxUjdQVmNo?=
 =?utf-8?B?eS9nY2FzZE9jUHFQRjFLV3hIOC93MW94MUdQY2x5bWErSjAxekNBWkhIZGlq?=
 =?utf-8?B?L1d3d3huU2hvakRLZkwzSXcxTVpmTEZxSGI3UU9PU2ZaOWc2Q3hhQkZBaWZj?=
 =?utf-8?B?N3FVb1drUk96dHZlcXlIZnV0QThLell3MHA2SzMzVkNwTFkvdVZrMi9vSEpz?=
 =?utf-8?B?N0Flc1FCMU5yTUZDalhMK0dCWlZNeUcrK3lMeG12NzIxcXhUUWdQdUIrNVFX?=
 =?utf-8?B?UlNUdkF6MmRYMHFNNVpGTVJsekQyRS9qL2djVWwxR29DTEtFbDRzdGVKaVpI?=
 =?utf-8?B?WDVqUHo0R0t6bE8vanYzTEZsRWNOTWxLNVl1K2ZTV1d0YVJaQmpSSTl1ZkFr?=
 =?utf-8?B?MzgxVk5zUjRhTE56bmtlNmc4U3hQNklzZk5sd3BJbXpvRk1neG41b2FCSmxa?=
 =?utf-8?B?QzdmV1kreVF2ZG5id1BqYXVSUGJ3U1htTU8yenA0elE2b0lnazZJK1lVZzJG?=
 =?utf-8?B?eXNRc0hHS3p6bkNER0NJQzJrMTA4RmFsOWZMSitJU2dpbXFBalBTU2x1ZVpL?=
 =?utf-8?B?L3phL3M0dEFaOHdWN3F5SjErRzBDU0kweTZtRVpJWlJoaHB3ZHNBbzZrSEtG?=
 =?utf-8?B?cDN5Vm1WZnJqK3RPbnNvN3VLMUM4L1BFQ2JrZzVFNnE0REdncEtYNDJQUWVr?=
 =?utf-8?B?MEc3c3IybXc3NVk0M0k4QytUbUNRazV1MnhJUERrcFZBbnBpaVBTbkZDQ2sw?=
 =?utf-8?B?bWFpMTFJQjRrU2FrMjkrSE1hb2NjNHNMMGlDVTRmTkxIRzZndHZYODZScGo4?=
 =?utf-8?B?TXU0M3lINVM2cDlqK2dDMFJkbUhEMlpHOENVT0pkenNmVHNsemp3KzE5djVF?=
 =?utf-8?B?YTUrRG9ZVmNMT2JVTDFickVnV3A2VXVqYUtCTHhVMUgyc1pZNVNnS1RVS3FZ?=
 =?utf-8?B?WFlaU2ZUbTZoVEg2eDJmd3A3TmdaaTIyS251TklLSVlYZnRWcHd4aWM3THdM?=
 =?utf-8?B?OXdwb0lpZkozREhueEhHMFFEcEQxUnhxTWhjRTl3aWpYbldUU1FDTEJCVDc4?=
 =?utf-8?B?bUdCbDUxVmNORzNETHJLK1ZmdTJMenJhdFNXLzZQOVh5SmZYdHRvN3RtZ2RJ?=
 =?utf-8?B?Rnd1ZUtwRW1HRkxuTFh1OTJWZE8yZ1F5Y1lNZXpsREQ0a005VHphdVh6SGZX?=
 =?utf-8?B?a0d3TU43S21OWXhTNVhUN0EzUFFIYjBlUHlGZXV2K0hJU2EwbStUUEx2Nll2?=
 =?utf-8?B?cXNWYlNGcXh3NlR1YUZWNkxqZk85NHdOSHpJQ0tyN2JWVEV0c0ZuQXJDb3RN?=
 =?utf-8?B?Rms2eUNBeE1OZ1FmRUlGejdZVThKYnZCVlI5RTdoNW9VYXZadFA0OWRiRnBo?=
 =?utf-8?B?RnI2bDl4amFRTHNLa2FBSVBHdUxLVktMcXFSUk9RNWZvdmpHaVlPNjh3ZkIv?=
 =?utf-8?B?Uy9IRVd6UjUvQWlwYW44ZHlPbjBENnBLNkFPT1VUV05CY1FwdjVNWVlsN0xR?=
 =?utf-8?B?aU5jclNQc3p1WUFFMWJ1QjV3OHlZNHJYcjFjbDYwQ1FLRGxQSHJkUzlBQVRG?=
 =?utf-8?B?dWlrRTNRb0xXanFtNDU1SHg1Nm5CTTdwSUNtM0V1eTVHQXVDQ3J0NUZXYkxE?=
 =?utf-8?B?TFJlbVpkTldyUEtLSFBlMEllbXBOVllMWkhyWUlZUU5lemNpMFd4MjlVSzRs?=
 =?utf-8?Q?ekgP9QfPp1q1aRdh73zV0adMd/ZbBI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlZCSWdVaGQ1Ym9sKy9idjg0dXBxN054T0ZjcTh3M1I5SXc2Zk1ZWkxUOFZZ?=
 =?utf-8?B?RzViS29vd0JpSFpDRUEvcElJd3M5dXhlQUdZMG84cm5pT3pKM2IzUi9KRDBy?=
 =?utf-8?B?NmU2MWlHL0lMUUVKQzJDck5FNVRTamN0S0FpUHFDS2VSYkhsNTZnOTZJeEly?=
 =?utf-8?B?QjNqYjRmNEoxeTR1MHo0cmJ4RGpka0tPUi9pdEUxQ0xOR1dIZXZROWQ3emhr?=
 =?utf-8?B?UXdRR3NsMFg1dGNxUllrdUwycFZTNWVrVzFDcUFzWWNWMEhKdGRvTjlTYS83?=
 =?utf-8?B?YnpMRm9Ob1pOV0syVitCaGtNOFVSWFEvQmpRSC90S3dMdXZOR3hHSmNZZ3BW?=
 =?utf-8?B?T3NUOUxBWE1KWWNLVDh5N3dRNENxMW9oVllPUVk3c2tzZmtmbTErVWUwdWNn?=
 =?utf-8?B?MU1xYXVHMjZKMnk4cmpYbVpMY0d1aDNRNktTMnZnSWlpZVcxRXQzaHQ3U0tO?=
 =?utf-8?B?bmgrakcyUzdmNnhPb3ZDeU1vdnpsV1I5L2hHRTh2K1VaZkFnRmJYekQ2ZXha?=
 =?utf-8?B?RkpQNlRmbTE3eDd2QytNTTZGb1JaQ1VDRml0bkt6RHhseWo0WWJxSzNVVjQ4?=
 =?utf-8?B?cGExS2c4TlJuMjdkNitsRlEyeGM5N0tuSGpLUU5HVGxPQzZLeWR4ejFqMkN3?=
 =?utf-8?B?SGgrQklnTk45SHpBaGp2TGdzMXV3bTZ6ejFoN1dHRGpyeHBsSUtDd0RPZzdS?=
 =?utf-8?B?MzZ3U1F4M1BsR0NGdGRWR1lmcEs3SmNQUVorR3pNeU0rTFNNbW84ano0VFVn?=
 =?utf-8?B?azJJQkhtOCtWZEhsQlM1SG9nVERncFR0RFdQVDFjRko0emR3cDlVVjAyTTVS?=
 =?utf-8?B?YVR3UTZaNHNlZE5qYWNJSGVUSlZCWGVBQXBQOU0reTY2RXovcWJMY1NOZHI2?=
 =?utf-8?B?YXlqTGpxNmZMUWo3ZlhOb2hGTmFZNjZkd1BDTHJWeTJ0YnNkU0hIdzJDUUtk?=
 =?utf-8?B?bkRyd2tMM2lVZ1k3bVovbFZEZDNBUEhPL3pzeUM2YjBaSmwrWEs4SVpyWXhi?=
 =?utf-8?B?Q3V4bEEvYkpOekZFM1NRclpiTFVTNm9pWndNajN1TGphK1FBdzhKekdCUUdL?=
 =?utf-8?B?ZWROUCtWNHVGQ0t2YkxVdDZQbEUwZG9TWVFDQlZVRlFSczBLcVNlVC9reDVS?=
 =?utf-8?B?eHpWMnRZTHN3ZWoxenZtMThSR3RxeTJQZjhieENKN3B5MUZrQUd6RjYwMWJG?=
 =?utf-8?B?R1RBZ1BETzRRRWhqMnIvYUpYOXRSdm9sNTlPSklSY0hzK3ZyNitmU1lrMTNx?=
 =?utf-8?B?Z2JjdWpOT2dtWnVody9QTDdSWFZIeCtGSklKdERmQVRCN1FKTGI3WUQyNzBI?=
 =?utf-8?B?YkhCOUVjNmxwcHFscW1kNitPR3lZRVdrOVdJK2dUS2ZqWmg3a0QvakIyRHE4?=
 =?utf-8?B?VlhNeW94K0VYOGJVRDJUaWhIQ1NiWFgyT1JhK1BXM2paV3YzYjFJdlE0ekZ4?=
 =?utf-8?B?UWpWVE9neHkyOVgxQzhsVVFBbTBoZkdGcnIrSkNSZlliV1pFT0kyU0JzVnRR?=
 =?utf-8?B?KzI4dFJTL3FaTjJGbmsvUUp3RERIZXI4VlhPSlk2MG44dE5zQ0UwTk1rNlBj?=
 =?utf-8?B?U3ozRnhaeE14UjJnUE4rN2w2cVlVRXBtSmpUelhFcWsrelM1SzgrK0h4SEpy?=
 =?utf-8?B?NEtiOEIwMkRMdE5Fb3pCK0E3N20xNDdvbm5xNWdKRU5TUnRiYjA0ZW5yYUo3?=
 =?utf-8?B?RVFVOG9OZ2pVNzR0b2FFTERuM2NhcEYxQlB6bTltYVJQMy83ZHhUZVl3NWNY?=
 =?utf-8?B?WDdKeXo3TXNoRU51WWdkM0F5SjdiWTBMOXhLUXBUYkFsT3dlZHYzc2pDcjZz?=
 =?utf-8?B?U2dTVHVWQ0RPNS82elhJdFFySjBxSFdwcFRmcUo1UWVVSzJONlphUTdabmRk?=
 =?utf-8?B?R2RBQXU1M3RFdmROTi96cVBqTm40dUNXR013YjJScFc3dXBmOWpZdkZQKzd1?=
 =?utf-8?B?RDBMWlBkL1YrR2RyWXlPN0pMRkJBOGYxMHRsLzY4NWVINDViemJkbHhZbE5Y?=
 =?utf-8?B?Slh2d2ZuYmY5bmhBbFErTmV1V3JNN1FpOG90YnlMMFZXTXVudFhuaDJmKzAx?=
 =?utf-8?B?b2Q5ekN5SkZ3SlZ1bElROHdHYTlEYkJYMHZZVDN4blN3NndNeDF2Ym82QVJT?=
 =?utf-8?B?eUxzSnFQb0NzUG1lTms0ZDdjRmdtMTBxQ3JmSWEraGZJQ3lqaGZDN2MvU1Zz?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96419EBF63341C4EB24FA543CB7223BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BWp43IJq583yktRCktqim9eVqzsYykgUUckgq1Qwvp/kayGTmuNhkIdoEvUFlna4KFXMZnUetiYZ2FJQ/k7HTbviWg2zuUDAmOzTkzo7w8xzpqVVLzSmUL/rVH/DbDpDjtq5SrYjJNsUadDcl907+LMNthjey3xPVqLuoJAFBFIgoxP6bFyHyLJ1dYVxuZuE8f4Uijh7ssInyn9Uhcit12m8x5sA+0SYYSd7B3qHnHc4zi6PfPU6cAPcJAirIs4IrwmYNqQEf+RNfEWaiJASfeFB/lArlxlPibi4NjyKO6ZHpao1fQx8AFt4U+4zwzlIKUlbdVwNo2ExleciOa2fGj1p93eZQ/ye/3i8hg/t2FPV+VL0JTV8m6MCtNeGMtSmKHAH/qYl1cT+Ulh4+qDCkK+BsxsDy0bLaf5Q5jzBIjZuVHmIShvyPrgssl1EGcYSzCLrmQIG9gctLGslrbO991ryisGqeZOgyhjzxXBAqbg6WTD7VWdZYSbXeWCA7huTIt2LlO9oJH0brEEZ8KiEMXhzhUq0yqipoxlIJiRToyGTYpiEGcxvu+AEf6kAB1gFlavo1A/1MrwZay6nVCyfyNsx9tPheWdAFNh1vQ2P1wKlOO2JoqdQV3DpVId9ofsT7aH3xS/NTmB1OeEdxCL0nw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0675be1b-7649-4125-ad10-08dddb926352
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 00:26:33.4159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QclOwZhLrgsMjpGhepfs2JxMR+HMjeFYD2lyOF04GtaFhHXII/ewTJ1CJCYI2dYtEXOaicZHkal3fmnvAkZffg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7914
X-Authority-Analysis: v=2.4 cv=IpEecK/g c=1 sm=1 tr=0 ts=689e7ec2 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=VtlG1h_svF4-rsJwZ48A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qdpSDpJRKqIaeNzlLM8u00f13ZGty_L_
X-Proofpoint-GUID: qdpSDpJRKqIaeNzlLM8u00f13ZGty_L_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDA5MSBTYWx0ZWRfXyRp9yL6hVJ/V
 NmSNEMKi/j2AP6+f/uSrcPvlieMoTWIi7WF52ld7dG2RNgW2AKSl1N+DNF2i8mUz4gEd1wHio5z
 StigC/DD2saAlxr9qUiCSDh5MPNJDuytqyTn9q6IJ4M5wg9B0Tz0jPPFqr/qeRwrN5LdbD9tanX
 ainxqvnRThOYc/RZtVubKrPBb5kz2LZ5et8WKDQtVPIwGB99+qFZjdgIUorWEPtHXZuTW9uHvc+
 pYHBXx8B8k/K4T1yN5Je1voZgEXOj6CCKIUDS/14SpHQ9YJkHb0SUdgG/bJgRbDZkp14Zp/2oOW
 YcNMtiY7XzxBdDG8Q/mgXZUF9zJCSYqOE1tNpdaAM81TrEkTYXLNu9wfl8/mC7p7r1MvjA/hT/u
 XEmaeIo/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-14_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508090091

SGksDQoNCk9uIFRodSwgQXVnIDE0LCAyMDI1LCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBUaHUsIEF1
ZyAxNCwgMjAyNSBhdCAxMDoyMzozOEFNICswNTMwLCBTZWx2YXJhc3UgR2FuZXNhbiB3cm90ZToN
Cj4gPiANCj4gPiBPbiA4LzEzLzIwMjUgODowMyBQTSwgR3JlZyBLSCB3cm90ZToNCj4gPiA+IE9u
IEZyaSwgQXVnIDA4LCAyMDI1IGF0IDA2OjIzOjA1UE0gKzA1MzAsIFNlbHZhcmFzdSBHYW5lc2Fu
IHdyb3RlOg0KPiA+ID4+IFRoaXMgY29tbWl0IGFkZHJlc3NlcyBhIHJhcmVseSBvYnNlcnZlZCBl
bmRwb2ludCBjb21tYW5kIHRpbWVvdXQNCj4gPiA+PiB3aGljaCBjYXVzZXMga2VybmVsIHBhbmlj
IGR1ZSB0byB3YXJuIHdoZW4gJ3BhbmljX29uX3dhcm4nIGlzIGVuYWJsZWQNCj4gPiA+PiBhbmQg
dW5uZWNlc3NhcnkgY2FsbCB0cmFjZSBwcmludHMgd2hlbiAncGFuaWNfb25fd2FybicgaXMgZGlz
YWJsZWQuDQo+ID4gPj4gSXQgaXMgc2VlbiBkdXJpbmcgZmFzdCBzb2Z0d2FyZS1jb250cm9sbGVk
IGNvbm5lY3QvZGlzY29ubmVjdCB0ZXN0Y2FzZXMuDQo+ID4gPj4gVGhlIGZvbGxvd2luZyBpcyBv
bmUgc3VjaCBlbmRwb2ludCBjb21tYW5kIHRpbWVvdXQgdGhhdCB3ZSBvYnNlcnZlZDoNCj4gPiA+
Pg0KPiA+ID4+IDEuIENvbm5lY3QNCj4gPiA+PiAgICAgPT09PT09PQ0KPiA+ID4+IC0+ZHdjM190
aHJlYWRfaW50ZXJydXB0DQo+ID4gPj4gICAtPmR3YzNfZXAwX2ludGVycnVwdA0KPiA+ID4+ICAg
IC0+Y29uZmlnZnNfY29tcG9zaXRlX3NldHVwDQo+ID4gPj4gICAgIC0+Y29tcG9zaXRlX3NldHVw
DQo+ID4gPj4gICAgICAtPnVzYl9lcF9xdWV1ZQ0KPiA+ID4+ICAgICAgIC0+ZHdjM19nYWRnZXRf
ZXAwX3F1ZXVlDQo+ID4gPj4gICAgICAgIC0+X19kd2MzX2dhZGdldF9lcDBfcXVldWUNCj4gPiA+
PiAgICAgICAgIC0+X19kd2MzX2VwMF9kb19jb250cm9sX2RhdGENCj4gPiA+PiAgICAgICAgICAt
PmR3YzNfc2VuZF9nYWRnZXRfZXBfY21kDQo+ID4gPj4NCj4gPiA+PiAyLiBEaXNjb25uZWN0DQo+
ID4gPj4gICAgID09PT09PT09PT0NCj4gPiA+PiAtPmR3YzNfdGhyZWFkX2ludGVycnVwdA0KPiA+
ID4+ICAgLT5kd2MzX2dhZGdldF9kaXNjb25uZWN0X2ludGVycnVwdA0KPiA+ID4+ICAgIC0+ZHdj
M19lcDBfcmVzZXRfc3RhdGUNCj4gPiA+PiAgICAgLT5kd2MzX2VwMF9lbmRfY29udHJvbF9kYXRh
DQo+ID4gPj4gICAgICAtPmR3YzNfc2VuZF9nYWRnZXRfZXBfY21kDQo+ID4gPj4NCj4gPiA+PiBJ
biB0aGUgaXNzdWUgc2NlbmFyaW8sIGluIEV4eW5vcyBwbGF0Zm9ybXMsIHdlIG9ic2VydmVkIHRo
YXQgY29udHJvbA0KPiA+ID4+IHRyYW5zZmVycyBmb3IgdGhlIHByZXZpb3VzIGNvbm5lY3QgaGF2
ZSBub3QgeWV0IGJlZW4gY29tcGxldGVkIGFuZCBlbmQNCj4gPiA+PiB0cmFuc2ZlciBjb21tYW5k
IHNlbnQgYXMgYSBwYXJ0IG9mIHRoZSBkaXNjb25uZWN0IHNlcXVlbmNlIGFuZA0KPiA+ID4+IHBy
b2Nlc3Npbmcgb2YgVVNCX0VORFBPSU5UX0hBTFQgZmVhdHVyZSByZXF1ZXN0IGZyb20gdGhlIGhv
c3QgdGltZW91dC4NCj4gPiA+PiBUaGlzIG1heWJlIGFuIGV4cGVjdGVkIHNjZW5hcmlvIHNpbmNl
IHRoZSBjb250cm9sbGVyIGlzIHByb2Nlc3NpbmcgRVANCj4gPiA+PiBjb21tYW5kcyBzZW50IGFz
IGEgcGFydCBvZiB0aGUgcHJldmlvdXMgY29ubmVjdC4gSXQgbWF5YmUgYmV0dGVyIHRvDQo+ID4g
Pj4gcmVtb3ZlIFdBUk5fT04gaW4gYWxsIHBsYWNlcyB3aGVyZSBkZXZpY2UgZW5kcG9pbnQgY29t
bWFuZHMgYXJlIHNlbnQgdG8NCj4gPiA+PiBhdm9pZCB1bm5lY2Vzc2FyeSBrZXJuZWwgcGFuaWMg
ZHVlIHRvIHdhcm4uDQo+ID4gPj4NCj4gPiA+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiA+ID4+IENvLWRldmVsb3BlZC1ieTogQWthc2ggTSA8YWthc2gubTVAc2Ftc3VuZy5jb20+DQo+
ID4gPj4gU2lnbmVkLW9mZi1ieTogQWthc2ggTSA8YWthc2gubTVAc2Ftc3VuZy5jb20+DQo+ID4g
Pj4gU2lnbmVkLW9mZi1ieTogU2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcu
Y29tPg0KPiA+ID4+IEFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5
cy5jb20+DQo+ID4gPj4gLS0tDQo+ID4gPj4NCj4gPiA+PiBDaGFuZ2VzIGluIHYzOg0KPiA+ID4+
IC0gQWRkZWQgQ28tZGV2ZWxvcGVkLWJ5IHRhZ3MgdG8gcmVmbGVjdCB0aGUgY29ycmVjdCBhdXRo
b3JzaGlwLg0KPiA+ID4+IC0gQW5kIEFkZGVkIEFja2VkLWJ5IHRhZyBhcyB3ZWxsLg0KPiA+ID4+
IExpbmsgdG8gdjI6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyNTA4MDcwMTQ2MzkuMTU5Ni0xLXNlbHZhcmFzdS5nQHNhbXN1bmcuY29t
L19fOyEhQTRGMlI5R19wZyFaVXVTX0t4MUNxTFFuTUMxNzdTeTJwdG1lS1FFaVVzTkg2V1Myc281
c1BPVjBMRTdDNDR4Q2F3ZTM3OVd6UXpGTkh3OHo3b2xWYU5obTJxMTNvR0Z4bUhDbDhzJCANCj4g
PiA+Pg0KPiA+ID4+IENoYW5nZXMgaW4gdjI6DQo+ID4gPj4gLSBSZW1vdmVkIHRoZSAnRml4ZXMn
IHRhZyBmcm9tIHRoZSBjb21taXQgbWVzc2FnZSwgYXMgdGhpcyBwYXRjaCBkb2VzDQo+ID4gPj4g
ICAgbm90IGNvbnRhaW4gYSBmaXguDQo+ID4gPj4gLSBBbmQgUmV0YWluZWQgdGhlICdzdGFibGUn
IHRhZywgYXMgdGhlc2UgY2hhbmdlcyBhcmUgaW50ZW5kZWQgdG8gYmUNCj4gPiA+PiAgICBhcHBs
aWVkIGFjcm9zcyBhbGwgc3RhYmxlIGtlcm5lbHMuDQo+ID4gPj4gLSBBZGRpdGlvbmFsbHksIHJl
cGxhY2VkICdkZXZfd2FybionIHdpdGggJ2Rldl9lcnIqJy4iDQo+ID4gPj4gTGluayB0byB2MTog
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI1MDgwNzAwNTYzOC50aGhzZ2puNzNhYW92MmFmQHN5bm9wc3lzLmNvbS9fXzshIUE0RjJSOUdf
cGchWlV1U19LeDFDcUxRbk1DMTc3U3kycHRtZUtRRWlVc05INldTMnNvNXNQT1YwTEU3QzQ0eENh
d2UzNzlXelF6Rk5Idzh6N29sVmFOaG0ycTEzb0dGZVpLTVNJMCQgDQo+ID4gPj4gLS0tDQo+ID4g
Pj4gICBkcml2ZXJzL3VzYi9kd2MzL2VwMC5jICAgIHwgMjAgKysrKysrKysrKysrKysrKy0tLS0N
Cj4gPiA+PiAgIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAxMCArKysrKysrKy0tDQo+ID4g
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
ID4gPj4NCj4gPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvZXAwLmMNCj4gPiA+PiBpbmRleCA2NjZhYzQzMmY1MmQuLmI0MjI5YWExM2Yz
NyAxMDA2NDQNCj4gPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+ID4gPj4gKysr
IGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPiA+ID4+IEBAIC0yODgsNyArMjg4LDkgQEAgdm9p
ZCBkd2MzX2VwMF9vdXRfc3RhcnQoc3RydWN0IGR3YzMgKmR3YykNCj4gPiA+PiAgIAlkd2MzX2Vw
MF9wcmVwYXJlX29uZV90cmIoZGVwLCBkd2MtPmVwMF90cmJfYWRkciwgOCwNCj4gPiA+PiAgIAkJ
CURXQzNfVFJCQ1RMX0NPTlRST0xfU0VUVVAsIGZhbHNlKTsNCj4gPiA+PiAgIAlyZXQgPSBkd2Mz
X2VwMF9zdGFydF90cmFucyhkZXApOw0KPiA+ID4+IC0JV0FSTl9PTihyZXQgPCAwKTsNCj4gPiA+
PiArCWlmIChyZXQgPCAwKQ0KPiA+ID4+ICsJCWRldl9lcnIoZHdjLT5kZXYsICJlcDAgb3V0IHN0
YXJ0IHRyYW5zZmVyIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ID4gPj4gKw0KPiA+ID4gSWYgdGhp
cyBmYWlscywgd2h5IGFyZW4ndCB5b3UgcmV0dXJuaW5nIHRoZSBlcnJvciBhbmQgaGFuZGxpbmcg
aXQNCj4gPiA+IHByb3Blcmx5PyAgSnVzdCB0aHJvd2luZyBhbiBlcnJvciBtZXNzYWdlIGZlZWxz
IGxpa2UgaXQncyBub3QgZ29pbmcgdG8NCj4gPiA+IGRvIG11Y2ggb3ZlcmFsbC4NCj4gPiANCj4g
PiBIaSBHcmVnLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQo+
ID4gDQo+ID4gVGhlIHRyaWdnZXIgRVAgY29tbWFuZCBpcyBmb2xsb3dlZCBieSBhbiBlcnJvciBt
ZXNzYWdlIGluIGNhc2Ugb2YgDQo+ID4gZmFpbHVyZSwgYnV0IG5vIGNvcnJlY3RpdmUgYWN0aW9u
IGlzIHJlcXVpcmVkIGZyb20gdGhlIGRyaXZlcidzIA0KDQpUaGlzIGlzIG1pc2xlYWRpbmcuIFdl
IHNpbXBseSBkb24ndCBoYW5kbGUgaXQgYXQgdGhlIG1vbWVudC4gSXQgZG9lcyBub3QNCm1lYW4g
dGhhdCB3ZSB3b24ndCBoYW5kbGUgaXQgaW4gdGhlIGZ1dHVyZS4NCg0KPiA+IHBlcnNwZWN0aXZl
LiBJbiB0aGlzIGNvbnRleHQsIHJldHVybmluZyBhbiBlcnJvciBjb2RlIGlzIG5vdCBuZWNlc3Nh
cnksIA0KPiA+IGFzIHRoZSBkcml2ZXIncyBvcGVyYXRpb24gY2FuIGNvbnRpbnVlIHVuaW50ZXJy
dXB0ZWQuDQoNClRoaXMgaXMgYWxzbyBtaXNsZWFkaW5nLiBBbiBjb21tYW5kIGZhaWx1cmUgY2Fu
IHB1dCB0aGUgY29udHJvbGxlciBpbiBhDQpiYWQgc3RhdGUgYW5kIG91dCBvZiBzeW5jIHdpdGgg
aG9zdC4gV2UgY2Fubm90IGd1YXJhbnRlZSB0aGF0IHRoZSBkcml2ZXINCmNhbiBjb250aW51ZSB0
byBvcGVyYXRlIGFzIGlmIGV2ZXJ5dGhpbmcgaXMgZmluZS4NCg0KPiA+IA0KPiA+IFRoaXMgYXBw
cm9hY2ggaXMgY29uc2lzdGVudCB3aXRoIGhvdyBXQVJOX09OIGlzIGhhbmRsZWQsIGFzIGl0IGFs
c28gZG9lcyANCj4gPiBub3QgcmV0dXJuIGEgdmFsdWUuIEZ1cnRoZXJtb3JlLCBUaGlzIGFwcHJv
YWNoIGFsaWducyB3aXRoIGhvdyBoYW5kbGVkIA0KPiA+IHNpbWlsYXIgc2l0dWF0aW9ucyBlbHNl
d2hlcmUgaW4gdGhlIGNvZGUsIHdoZXJlIGFkZGVkIGVycm9yIG1lc3NhZ2VzIA0KPiA+IGluc3Rl
YWQgb2YgdXNpbmcgV0FSTl9PTi4NCj4gDQo+IE9rLCB0aGFua3MgZm9yIGxldHRpbmcgbWUga25v
dywgYnV0IGJlIHByZXBhcmVkIGZvciBzb21lb25lIGluIHRoZQ0KPiBmdXR1cmUgdG8gY29tZSBh
bG9uZyBhbmQgYXR0ZW1wdCB0byBhY3R1YWxseSBhZGQgZXJyb3IgaGFuZGxpbmcgcmV0dXJuDQo+
IGxvZ2ljIGFzIGl0IGRvZXMgc2VlbSBhcmJpdHJhcnkgdG8gZG8gdGhpcyBmb3IgdGhlc2UgY2Fz
ZXMuDQo+IA0KDQpXZSdyZSBqdXN0IGJhc2ljYWxseSBpZ25vcmluZyB0aGUgZmFpbHVyZSBsaWtl
IGJlZm9yZS4gSXQganVzdCB0aGF0IHdlDQp3b24ndCBhbHNvIGJyaW5nIGRvd24gdGhlIG90aGVy
cyBhbG9uZyB3aXRoIGl0LiBBZGRpbmcgY29kZSB0byBwcm9wZXJseQ0KcHJvcGFnYXRlIHRoZSBl
cnJvciBjb2RlIGFuZC9vciBhZGRpbmcgcmVjb3Zlcnkgd2lsbCBiZSBtb3JlIGludm9sdmVkDQph
bmQgcmVxdWlyZSBtb3JlIHRlc3RpbmcuIFRoaXMgY2hhbmdlIGlzIHNtYWxsIGVub3VnaCB3aXRo
b3V0IG11Y2gNCmltcGFjdCB0byB0aGUgY3VycmVudCBsb2dpYywgYW5kIEkgdGhpbmsgaXQncyBh
IHN0ZXAgaW4gdGhlIHJpZ2h0DQpkaXJlY3Rpb24uDQoNCkJSLA0KVGhpbmg=

