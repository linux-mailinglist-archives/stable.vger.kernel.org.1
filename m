Return-Path: <stable+bounces-237709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJVbEk6u3WkFhwkAu9opvQ
	(envelope-from <stable+bounces-237709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:02:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E54E3F5246
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8B1D305E1F4
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2973128B0;
	Tue, 14 Apr 2026 03:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="COx+5dcM";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jVm2Ghmf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tmMHaUuY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8078F2E;
	Tue, 14 Apr 2026 03:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776135680; cv=fail; b=lJUdnNbcWcZsvAy81OQvThcDIhVF4rgb9bWIOg+ZGq2z0EugRj0vbT7YKNFx5VHk9s1HyoSJF0m7AUu1KuMRuObU+AxI7NyfwvYM8z4YP/fzOApSnZAy606jazeJgfiyjcG2JkV19AHqRy/E6IhUrQmAh5nwxAd5uTFPK0DruIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776135680; c=relaxed/simple;
	bh=RxZ7prD6NjHLBU6bOxv4rdLGqqfQMR1lewLqfoq05TQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EnQqkw2pD8PMmglqW1BSncXKneTe6M17TDEK327muvyE9C6HILROIMhnWgqcaUK4CmYFQoJU44nRy9ULA32zrNq7UgMtPwF0PKM5MpUD8uZ9HSDpxwHInYcvwMPGfmPv+njC5POzzNplG43hQc+BaZChkt+fOVWcvqMpA8z4VxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=COx+5dcM; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jVm2Ghmf; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tmMHaUuY reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DNgaJV142976;
	Mon, 13 Apr 2026 18:05:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=RxZ7prD6NjHLBU6bOxv4rdLGqqfQMR1lewLqfoq05TQ=; b=
	COx+5dcMHh3OilvtnUgWwkXF2jdTe0CEv62ObwttCYNpKMdrDCdO2fOUBxLguQJX
	mBHdAtWWvfZhBZu7E5b4lltjAapgeDPxBWMsgAr34bNwNnjQjKHPIQ7AHmk9VMcw
	2VoDPTEosvODDCwbqBUPnmOUx5+fIbIkhbBePW81ZTElCjTx8mEDLuxrSJbntJli
	jEh8ZMBe5hgCCg7j7wtGn0G4zdTfzedHOW+e6il97GmSeK0NyslbTbh/9QZkT1sD
	NhDEfLFPwMH2JnbVh+vZWcfekPpE6ax6dZ0+gaC/17C4f2kPcDcyrSyFM3FRoxlc
	fEFkO7SfE3VeCggJ7UCfkQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4dh84vrutc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 18:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1776128750; bh=RxZ7prD6NjHLBU6bOxv4rdLGqqfQMR1lewLqfoq05TQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jVm2GhmfFiDbQoSClrCSpMRMZJ0CvOYH6zRjW6T2O7lU2VOllMp7l3ZNMTJOka/hJ
	 5r2juk6FcVJeJZ7hMX/MZLFSVPOi4nhHFrsnA1TNkd3NULGs0RJdpKlKtSj24ekOej
	 2XIsw7JiFZ63Ct6CoaRYGice3GLOKrQaHuiADb8gj8lt1homtWVIA2A9y9+3T44Ozb
	 smOSIYDF/U+9i3mNXh5p7ueIgCCW6ByuYbeMbCu5hwX8RnVqpFEWzh41kVeKhJg9l7
	 ja72M9FotdUXHvwJIvrqnMSUa8YRPMHfIilI7hlnICi80mStjh3KqeM66K8slNLDR9
	 k+6Np45/mjCQw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A5D8C4034A;
	Tue, 14 Apr 2026 01:05:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4A50CA00E5;
	Tue, 14 Apr 2026 01:05:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=tmMHaUuY;
	dkim-atps=neutral
Received: from BL2PR08CU001.outbound.protection.outlook.com (mail-bl2pr08cu00104.outbound.protection.outlook.com [40.93.4.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4C9B34052D;
	Tue, 14 Apr 2026 01:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbsznPy1+8wJVss6YEToBJLwZcSvCqjCNIohmHdUxnI2zKBsId5y0ZXwLxN8ERRcH6PxKChNLdaoT3tmlOHBeH6AiYB56Lmy01xEubgS/JAVLt7xg3EUFtnzMblO1vHpyQCFeuoscJ4bIVpL5hD5YT3F3F/HHZOX3QGsvotTqYvGMEdk0LBVm6wwCOQbqo+InRGJwgXlbcAZffs/UCo23MOL7kUvWMfvhXO6PNmds7Gn0FVrmQSfqG7zRzNl6t7a8EAS/cvqLwwXGrTowoFLAz9Am71zQPaVuDI7wC2g6anwVkPBat7A8Amt2SoAWfg4HApUYtXbozQhYdC2XnCo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RxZ7prD6NjHLBU6bOxv4rdLGqqfQMR1lewLqfoq05TQ=;
 b=h8j8wcoOgVNq+e4rPUgD3im0fuSr1HtXIEgLjPVpVV8vcJiz40CakE5Joe8ynSPNeiCQabrhkHSk911E3ZXRC54AOqCmW1IaqCnjiOuA/Rt1byoJ2gpOnkur1SpLzLMwJL7H7pr9JN9U6L6ilLfnBIY7lGVj/v3G/XFVlSxf8bCBpgHUVQ72MrgBzFOkt6AP0foxfSvxtjch7GgVwbCPO7581iNwpO6GFuc+wCxHImcOvuYJ3rGeu8QXWhHR2/k6NFoYpkMpZCghKk15bPI14RbtWFbsUXH2IuuGyFWglDsvvxBDJqnL4XlVfz+AUOIoDfE4TyZEht1c5890tu1ECA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RxZ7prD6NjHLBU6bOxv4rdLGqqfQMR1lewLqfoq05TQ=;
 b=tmMHaUuYfM3GA2KbooutWjvX3YW69C6uVhmVMNM0KpnfSjgC7cswSVa33hHyFqgfnMDbJQn+keJs6yEj+dEcZ6bbPEHFBIBlldVw+cSNPJLjtuTZEt07a3buCE5ORxgi8SjY+M0WKWTA3DsVxHRHJ4xKxWWuHde4L0+Gs9MtfLI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 01:05:43 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9769.046; Tue, 14 Apr 2026
 01:05:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "paulz@synopsys.com" <paulz@synopsys.com>,
        "balbi@ti.com" <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pritam Manohar Sutar <pritam.sutar@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Fix GUID register programming order
Thread-Topic: [PATCH] usb: dwc3: Fix GUID register programming order
Thread-Index: AQHcyLgQyzkLRpw34UCOsx3EE2u92bXdxCUA
Date: Tue, 14 Apr 2026 01:05:42 +0000
Message-ID: <20260414010532.sxciijnzak3ldw35@synopsys.com>
References:
 <CGME20260410070245epcas5p49355581dcb9f629641c9914ce4ce80ec@epcas5p4.samsung.com>
 <20260410064735.515-1-selvarasu.g@samsung.com>
In-Reply-To: <20260410064735.515-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ1PR12MB6340:EE_
x-ms-office365-filtering-correlation-id: 58832098-eae5-4b82-ce58-08de99c1f3bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 KPLE9AK6/zmxNpD+RK+CdcCyV6krpkJZDr4WGp7EdJVXCPdLwRGtZf5IlEVyoJQw0n5WGeVyJZI/Z1cK5P8Rc7056APsHbZlOwhkOCH4F175sQJJPNv4LdCMr0K15tn9v1k4Oj+c+YZtBpOkqX6vlgvagvl7Erj67unhCS4dY3UgvDoSCnNgndXIjbWnqCRieAUD7CUIyqCmx10B4lcUU13pqzBKlWZB0SF7jDM53Dhn83TjfiALVF9auTf+xTBhW1pltIRr5Kx2RheRO6pFRMv7XXGv7oXklztLW4ZbFg6O+AlqLiifII3x7Y8j7LTBf625N9HGBvce9Dl03LV6Npi7n6B80txUwtQooVGANRkL7k515DGdhRSK7za9Fy8GU5abmZjtTAJgIamdGpzY9Pqbcv0uKLcTAPdUxr4mMdC/L1LTcItbhnWVCoGvALFbhoBa7EElY/1FQxvE5qG5WqXBx8URfBq8qIK7Ee6+iCuKdVVIWq3NJH0+h1/TDBuUGAeT9yVdEDyqpBCLKUkqLd29ouicKXSD/xsXAXJ1LJqpboBzJFo9kJGbxA594ySyUaM1rbZY588YMv0FYzwb+b1Rz9MPo2rRktNSqxt41Dy/+mytF0D/yt8q6fFFneSWhwmPoefAVvq/n+JKx3KstbzVOIHCD7kwboWbB2+X7dbfXZ99lMZfFEGS9jZfTo51HnnMbTHRRwKy2OMTsjZvpDCPamr+wODA1DXrj5hsS+2xJPGn6XNi5hgu2tf9L2ctnW+/5BK9WSETNFOArhrW5SQTiQMre+ZBh6fM/Bt3cNM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjBCeDE1SWE1SU1FWHkvZHVUdGlZTzkxWERUQno2WVlvWGdkL1ByRW44eHcv?=
 =?utf-8?B?bnNOdGNqK2NJMmh0QWhzeVFKUFExZXI3NklVRTJ2ZTFuSGF0RUp2V2hhYWF0?=
 =?utf-8?B?Tlh0RFRZeUlGVTRKVFJ1dzgvZ1cwMC9pcFp5TkpwWFlqMENUWmdXREFXTXVw?=
 =?utf-8?B?R2p4eVJXRFNIK0NZYXdaMkFJQURvQk9pdEoydFFlbUw3RXdWWHVMdWxoWUJZ?=
 =?utf-8?B?OUlwcFU2RHNyL2pQcmhPSkxzSGVCd1ZEaEZ6Z09uUmtiUnhtVE96eTk0c056?=
 =?utf-8?B?MjVFbVV6cEs4TURaVm0rVGFvK3gxV0grMmdZb1hVVURyaTA1RFlOQUVGVWR0?=
 =?utf-8?B?ZDJkcDVSeVBwMWZqd0xLeEJYNVNXUTRiT0htYzFwbjRoUGxzWFdwNDZONkFH?=
 =?utf-8?B?cXBBSGJTSG81MjJHWmZzMWE1dlRsVVFYZjFuQnphNUdQV1p3OEJMUm5sbmF1?=
 =?utf-8?B?eUlBdWZjZG94UFZjekJHakZRQ2JHUFBXRkM3Tk5GSVZCYWg5czNuNHBObU93?=
 =?utf-8?B?UzZ0TDNDR05zMG12ZSs4dVNLVnh3T3BEU3prVzhrVlFnaWo2Y1BTNU5rdmwv?=
 =?utf-8?B?Vm5kajRWLzhyRWIzRGxkcmtHWXBuTFhvZFE4N01KYUl2YWFQZjAySFFMU0Ey?=
 =?utf-8?B?Q1VXeFQ5Y2dqKzlrRm9xdEhxdnRGby91NzRDRklYRXpGMmhjMExRdlpWQjEx?=
 =?utf-8?B?UER0Q2E4RWE4b0N6WldXQXFWTld4eFYwczNtVitTV0RnY0RQK1RGZWxNVFVW?=
 =?utf-8?B?bWdSTWRwaERJS3dvNFZucmp6Z1hGNEJReW1tVGJXR3lKZUp1MFlWVnEzUitZ?=
 =?utf-8?B?MUlXN1NlYk12ZmxrWUFZSngxUE0zSHkzc3I3Z0xpTTQ0Y3lRZEowbFFFUVBt?=
 =?utf-8?B?WC9rUkMvTG9LYVRlNVlzZ0ozeFpPemkwNkhXUkYyN08vNGN3YXVva3FIUW05?=
 =?utf-8?B?MWFjbTR3QXBGN3VEZnpKUERzc3ZBUzg0clhwb0JqQ1FCejl3dFVIbDkvZFht?=
 =?utf-8?B?NFFRNGR5Y00wOHFuci84VjZTWFMwRTBQMitsaGhEUDQ5RUJQZFV0SGIwejZz?=
 =?utf-8?B?cEppVWJiOTV3ZmZDU1lqdVI5eWVwUDF2S2FCRFRHcDVMNXJPdnBaK1g0b2pV?=
 =?utf-8?B?MzlFWHNHQmJQV3lsK2o4eXViMWFNSi91UnNVRzFSL3VrNTh3b0pxMzEwQTYy?=
 =?utf-8?B?VmhHRGFqdFBrWlljbFU1NFBVUll0eE5uYTg5RUk0MnZGS05vdVdwc0FQeFBX?=
 =?utf-8?B?R0pQNTE5aFZRSi9IRU84d1c2a1VKbHZMU2dTWXlEZkRKWlpFL0NxbkdBZnh1?=
 =?utf-8?B?RmpIbEp4TnpKcWJmYW5Pc1RDZ0tUeXBpWUNkWHZCQjNVbmE2RUlQTzA0V0pa?=
 =?utf-8?B?Z0hETTZ2U3hDMWVPaHJIQ0xienFuTkFFSGhQWU5UMUU3Y3NGYnFCeWtOTG8x?=
 =?utf-8?B?b3BIOVdTOHpIMExZQjRKYTVGR29tRkdNd3V2endpYkVzZS92VDhHekZSSWhr?=
 =?utf-8?B?a2Zub3ZRM0tXR2ZjcTd3akdCY0hkT094Smx6SDRnWjVOaFJXMGRxZERUU2J4?=
 =?utf-8?B?aURBeXNqNnQrcXdQTCtEaFBWZ1Q1NXZZemFZVVpBVXRPcHdPckpzWVVMSklY?=
 =?utf-8?B?ZHRJM29oS3cxK2EwN2JlenRKMENVK0RRek9xc05xd2kxWGlSTFl6UGJPVlpw?=
 =?utf-8?B?ZmlKbERsM1IrOVE5Z1JYcFZXNEtpNzg3TnRpdnlvZkhITE1uU2VUVm1Cc0pn?=
 =?utf-8?B?NEJZWUFwdW1jVlUyQ1VZdjhjOEsyS1doZjdXWGJzZGJGRE80dGYzNG9FTnk2?=
 =?utf-8?B?WlBpYkIwK25oUi9xaE54RnlxcldVOUtzTENqQ3NiSWx1OXdpcys1N2JteGVF?=
 =?utf-8?B?YklPZDhNRTJUaldJajZKTU1kSWVCVDB1KzFNUzU4STlhZHVNblJxWS9Na3Zq?=
 =?utf-8?B?VGVXNXdGSm9qQTBuekFGNHJ5OTVTejZRaGZGS1I1YmdNRWt6OHl3TFFkNFo0?=
 =?utf-8?B?d3FYdTMxTTZtSmY5R1dHZFNxMUhkSVNRY1hLb0M4QXVQRzR2T1dBb2tDclVr?=
 =?utf-8?B?TTg0UlNKK1orNXN5ZXJDME5PZEZSUGo3WE1iZ3FBM1B0bUZTU2ZQeFA0UUtZ?=
 =?utf-8?B?M1hJM0xYVUQ2VEQ1U2RwV0tCdUNrZFB3OUNlL0Z5d0l2UTRBLzdhclhHUmlF?=
 =?utf-8?B?cURvTHNYQ2RXYmZPc0ZmQzdtT0pYSENBenU3ZXVXYUw4NTlMbDdsUE11K2g5?=
 =?utf-8?B?cVIrRllkdUI0OUVEQStHdGVsSzRsVFhYUXZYRVpNZkJPRUpqU1FjeW5GNWho?=
 =?utf-8?B?SWZqS1BrZ2phZlFXaDh2VjdjWGJ2emQxWEcwQVlkZ3pOdUtuR3QwQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EFFEDEE76DDE640AE1877B7FB0BEB97@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	eQFep/Of0TAE96HR5hPWFKcu9pbNkhdnZjntzabd8vdkM640e2RcrEuRtPC5164ZYjISeWdd9+xEQwsdmQu9YJcK2RnVy2lQulLcgNZ5wstCHhp8XPr6srPr365PPwlpIc+wwwGyrxkAidHGoI1Cf7OBkmpHXRRTGQaCTxwhP828vzScbeSV1VvZbHBZ/cwwWRnZdG32GcLD5ON5UPbhOEsMSoOZYk60nFqaBrNbu4RPkQkLaI3b7ngHQteV9RvtiO1e9vpUVS9qqMIutUdI8doa/c8AkZa8y9P636LliAEUUkd7J9szlcoc9vChLdSLTLN76CvBxX24eM9spDAAQw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GszvLBl7X83ZIvywzUQxQPVevLrZyNykBMZ4EObvmZJjUAqsIxvF3SgNk+e4cGVTiC1LRrKCkxYuDmeR79WAeRS1/lvxkyQf4/l3YCLoHUtAmqvaBTkmZMVrdWjRhWO2MrznPQCO4M1e+HPDp2kFu+NfswEmre+2dNQDIVBIGIpIKfm/cuIoDhPIsEhdb9aySQlu9K14ktmb4rM8tVNBJeNEqJG6QuZaZhSLiZmIyq7O6EbAVucbVVuI3vyfvSP1bTqBt0ReHV/3ZjZpUvDOaa1aKNxp6gaxXPpkbpaZ1sCkIAp2XIhfEzIsL+eh78iMp3EEbH4XjepbmGzpUPnMbH4f6VpcbpvjQvVluMtBIRTQyWPJaiKWJRBTT8CNcCNtYdz/OeFeTqqZFTOY3E//W/0giAG/J3eLE/s7Gj1wxPPOUxuu7+1N5zVi5CfhG2uKbO5nMv8F/hqLDK5XLY1vLePPvOT7fM+YYTrB+HbG13Y0fcvibDRp+yRDtZCNbPBLFQ3rY2QS7oJ74jwvhVAE1DxNAXVx5x1JNdyRp36x0O2pAQt33qbqgA0NIjUY3oUOKklrP+WJrSlL207nAu7od5Nxq+KNi2C8sloJnJKuX9gTUiUlJ3EsJ4fnV+Ty8QBWOA3DH+sLFiujrRWN0UGftA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58832098-eae5-4b82-ce58-08de99c1f3bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 01:05:42.9613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKg/jb3F8UHDGNKaPU3/5IBqOe9EjsFsooKqIzQDsiHC6ZOae0MyR7P68iHab2UfjkrMaW7KV2G/vcmihYKeuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
X-Proofpoint-GUID: dS8VeG1jRGNQzLe3K5ca-nw3IdrFR_Ef
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAwNyBTYWx0ZWRfX7HQmr+c5392g
 +B+8qG3jZPDmXcc8kkiN3eKCPBRX8DfZtNedaJO0KPmvf87duqqawdp6wG1sj+Og+9HaisojziI
 bbceCDb7UQhMBeJexxtgITZrzDIQePHHaDSi6qUqbY9F5JTxSiR35LuPq19sd+yq8Be+QFx/Hg1
 8OZAPmoajfoWjoDxhANVRnWr+7mDXkfN2kNFxzqLnmQ+oDG+AlTj5ZIw0Nq3GRXDgkUB0YwGxST
 ahDuDWg3U6KUIu2W00KzjNCJtRBrzQm9JRAWHJyvCiyIoXlY2acAZQCDHe1q1fM3uF5FU2A0JNY
 tCmCd2UVrMfdzAKNPb4C6ltiqKEXV3iMUcX+zk6El1Kdu2dAtOPiViG3XbDC1L5Y2K6lrT4AGbz
 2DJMG3o1y3FqFBhJXIfti5U7xtUkidjFFLKE+F/+eBCozk6PrGxIX6pSvCvYn/3F2H011YBtW8g
 unHbHsFSm8RcIqHj7NA==
X-Authority-Analysis: v=2.4 cv=TJZ1jVla c=1 sm=1 tr=0 ts=69dd92ef cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=GLuEah2PNnTpZbAg6XwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dS8VeG1jRGNQzLe3K5ca-nw3IdrFR_Ef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604070000 definitions=main-2604140007
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	TAGGED_FROM(0.00)[bounces-237709-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synopsys.com:dkim,synopsys.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_MIXED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9E54E3F5246
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCBBcHIgMTAsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGUgTGlu
dXggVmVyc2lvbiBDb2RlIGlzIGN1cnJlbnRseSB3cml0dGVuIHRvIHRoZSBHVUlEIHJlZ2lzdGVy
IGJlZm9yZQ0KPiBkd2MzX2NvcmVfc29mdF9yZXNldCgpIGlzIGV4ZWN1dGVkLiBTaW5jZSB0aGUg
Y29yZSBzb2Z0IHJlc2V0IGNsZWFycyB0aGUNCj4gR1VJRCByZWdpc3RlciBiYWNrIHRvIGl0cyBk
ZWZhdWx0IHZhbHVlLCB0aGUgdmVyc2lvbiBpbmZvcm1hdGlvbiBpcw0KPiBzdWJzZXF1ZW50bHkg
bG9zdC4NCg0KVGhpcyBpcyBub3QgcmlnaHQuIFNvZnQgcmVzZXQgc2hvdWxkIG5vdCBjbGVhciB0
aGUgR1VJRCByZWdpc3Rlci4NClNvbWV0aGluZyBlbHNlIG11c3QgaGF2ZSBjbGVhcmVkIGl0LiBE
aWQgeW91IGFzc2VydCBWY2MgcmVzZXQgKGhhcmQNCnJlc2V0KSBkdXJpbmcgcGh5IHJlc2V0L2lu
aXRpYWxpemF0aW9uPw0KDQpCUiwNClRoaW5oDQoNCj4gDQo+IE1vdmUgdGhlIEdVSUQgcmVnaXN0
ZXIgcHJvZ3JhbW1pbmcgdG8gb2NjdXIgYWZ0ZXIgdGhlIGNvcmUgc29mdCByZXNldA0KPiBoYXMg
Y29tcGxldGVkIHRvIGVuc3VyZSB0aGUgdmFsdWUgcGVyc2lzdHMuDQo+IA0KPiBGaXhlczogZmEw
ZWExM2U5ZjFjICgidXNiOiBkd2MzOiBjb3JlOiB3cml0ZSBMSU5VWF9WRVJTSU9OX0NPREUgdG8g
b3VyIEdVSUQgcmVnaXN0ZXIiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXBv
cnRlZC1ieTogUHJpdGFtIE1hbm9oYXIgU3V0YXIgPHByaXRhbS5zdXRhckBzYW1zdW5nLmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogU2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMTIgKysrKysrLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gaW5kZXggMTYxYTRkNThiMmNlYy4uMGQzYzdlN2IyMjYyZiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9j
b3JlLmMNCj4gQEAgLTEzNDEsMTIgKzEzNDEsNiBAQCBpbnQgZHdjM19jb3JlX2luaXQoc3RydWN0
IGR3YzMgKmR3YykNCj4gIA0KPiAgCWh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2Mt
Pmh3cGFyYW1zLmh3cGFyYW1zMCk7DQo+ICANCj4gLQkvKg0KPiAtCSAqIFdyaXRlIExpbnV4IFZl
cnNpb24gQ29kZSB0byBvdXIgR1VJRCByZWdpc3RlciBzbyBpdCdzIGVhc3kgdG8gZmlndXJlDQo+
IC0JICogb3V0IHdoaWNoIGtlcm5lbCB2ZXJzaW9uIGEgYnVnIHdhcyBmb3VuZC4NCj4gLQkgKi8N
Cj4gLQlkd2MzX3dyaXRlbChkd2MsIERXQzNfR1VJRCwgTElOVVhfVkVSU0lPTl9DT0RFKTsNCj4g
LQ0KPiAgCXJldCA9IGR3YzNfcGh5X3NldHVwKGR3Yyk7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0
dXJuIHJldDsNCj4gQEAgLTEzNzgsNiArMTM3MiwxMiBAQCBpbnQgZHdjM19jb3JlX2luaXQoc3Ry
dWN0IGR3YzMgKmR3YykNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGVycl9leGl0X3BoeTsNCj4g
IA0KPiArCS8qDQo+ICsJICogV3JpdGUgTGludXggVmVyc2lvbiBDb2RlIHRvIG91ciBHVUlEIHJl
Z2lzdGVyIHNvIGl0J3MgZWFzeSB0byBmaWd1cmUNCj4gKwkgKiBvdXQgd2hpY2gga2VybmVsIHZl
cnNpb24gYSBidWcgd2FzIGZvdW5kLg0KPiArCSAqLw0KPiArCWR3YzNfd3JpdGVsKGR3YywgRFdD
M19HVUlELCBMSU5VWF9WRVJTSU9OX0NPREUpOw0KPiArDQo+ICAJZHdjM19jb3JlX3NldHVwX2ds
b2JhbF9jb250cm9sKGR3Yyk7DQo+ICAJZHdjM19jb3JlX251bV9lcHMoZHdjKTsNCj4gIA0KPiAt
LSANCj4gMi4zNC4xDQo+IA==

