Return-Path: <stable+bounces-128779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8548FA7F09C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3279C1896DED
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD1224890;
	Mon,  7 Apr 2025 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hdEKjMsG";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ce9tZpyA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nlokyKgb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F54223701;
	Mon,  7 Apr 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066899; cv=fail; b=p92sD5S2obfCadj0gi3pK0HHgIwus1sqouGr6GmfWvYgSLlB2kTZCvTClR2jR56uhgq0Ds9BqULB+85uuQsbDVHMEUY6NYDea/OSeyepPJactmUTaEh4UJRu5RWmBmyCY0HoXDuqxEJaQfiWI5x5pwJ3HH9NLnMu1Fu6DmFSg2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066899; c=relaxed/simple;
	bh=zB0f6SUmgHrIrBILkTg79MGE5H18BpbxOR7cG3RC0IM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hq8TKlAJF/IKu62D2MK8JFkw+hFe35nFwu9AqAwdpDlbc4k7zh17M3ZJNTmINV4zyr+eMn/PIgypZOcS0fQFuvHLZUludlP5epD4uGlAqu7EDh0R7+94hIAFp3K1F9w1zmrDQvaFawi/p/bb/Qmb6NPL6wUk7PAFWSWliEeNs1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hdEKjMsG; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ce9tZpyA; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nlokyKgb reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537GVVBb022959;
	Mon, 7 Apr 2025 16:01:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=zB0f6SUmgHrIrBILkTg79MGE5H18BpbxOR7cG3RC0IM=; b=
	hdEKjMsGr5P79MU1L5ww/01sxEDf0nSe0JCdPsvrDibmVzBM8jxv+n1ii3UsLNAe
	fDXkpy1pHwJFbRGJFwYn8U39DvKad9GLcpB2DezVRToNb5FLQrBmOG1IRmySIPj0
	TTDvgL+lUrGA5elkojM1TCXxFe5idkbKmu3TvkfAjLKpqa+SrxTLJGOIIi/6Yawn
	l7l8+L5TxhmlxErgpQii8PWkNfj2OSWv9bwPfHhy+dGq9OdDUkED/i+NeI8B9XxW
	gzX/EDGzrtsQ5ASmPTfMfIocWKO3iWiUq02g6eZ1uMooFL7WSaT9MQNCXfDpqthc
	BmrGbVKZlONgzgeN8PEt5A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45u3euxphv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Apr 2025 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1744066879; bh=zB0f6SUmgHrIrBILkTg79MGE5H18BpbxOR7cG3RC0IM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ce9tZpyAQin1NsoIm6pn4c+pO70MiTEl55F2Vf8hPtD1CCe/3ZjRIysRrpcVA/QAY
	 LHw10ZMyaaDi1CMekz+1oyVJNBxF5qiOmiBcp1TRq35neucDEcsw747j3XzvPC9mDU
	 8XNobUz9VqnyC3RHq3IescVhQ+kMhOi34JVnDzvZS6Cvc7rwNJWcD+N8ATKCgWgd7i
	 0KyUWWZFBuEotqziYAdtpwNVdUIGWkPzooItv2MzFVaf4BANWaiw2s2bqamX8gQFyl
	 0fojB84ZMaOP65Y+xTN7ICucbloTz+jE+3NcWVsTjpQaLLrfJz5TQW8fYK/80kLA4y
	 hfYcSpc6qlUhQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7EF7B4045F;
	Mon,  7 Apr 2025 23:01:18 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 6E5B5A005D;
	Mon,  7 Apr 2025 23:01:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nlokyKgb;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 786814076A;
	Mon,  7 Apr 2025 23:01:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVi/m+VG5JK4WH83b3sg2pTO2gWFsyfmLDDDBQ1CWsLG+kP9MAyeDcX+A9zxgZS5xMybnLHvskei/znkJ2WDjUqiF/XoU2+o6depbMXwUYfndHQ6S3z0qds9UZQ79EWc/J2wr5T6ldmQrrbMX2muNRZ6QdjhGtv7LmgzEXNzwyodrQqnfA723NJqT6AntemTuz/EoM6S/6XXfu3HGU+Ri539FTfGPmbJR8NZe6a0mWi2/J5QMyxN4ZbeObNkXC6ouKTVkHaAAo9ZGTy7Yz7Wom/ytqFaoVY17JVjpUl1pp758i1ZNlAlzxwuIN0Ho9J4mRYT+Q6YkILEx6efLRFLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB0f6SUmgHrIrBILkTg79MGE5H18BpbxOR7cG3RC0IM=;
 b=mQZyDWSOZXfjBvPk5MtgF5uh3SxmRICZQSf+V5Bx0SivpB3WRVHmrjAJ/uoZCd+JzmE55gLc0p937IEV4V4Trfxs2H7v2eRJPpIechI+F68+339ioCDwdJpaLpQIewbBXWgpSTCQSuFvWfaTd4FPKDDt8h4PQwhIklD/TKB0L8e55Ci2XJmU8fPRPmvNxVVZhOUahfFXqqJxz2PVm83CVrWfi6YVX7+RkzVua2S2zGg6LbgORFQ+V+yfsctBL6ABs8xIrgXM8+18u3PZLK8qabmE0ZuqQPCq9QjQ5baTJ/P7i9F9hV9wzP3YqSbx8+IF+g/lkVDeDKUzxEBBIMSK2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB0f6SUmgHrIrBILkTg79MGE5H18BpbxOR7cG3RC0IM=;
 b=nlokyKgbb3H5IQzcb5iCDMBwmG0YbI97nL8r5U7tL/5bRJJAd9om6+/QVAX9yDj1tMnNNSuvFOENlGsQYgId0v3xPRDMpqP6Hy3UtXi5j6FcOHZyc9vB7Ydy3DX/9Xv+t2V/+ojsXZngyXG7ExeapW3kBX0ZYBZMPdsofDN+AcY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 23:01:13 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 23:01:13 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frode Isaksen <fisaksen@baylibre.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krishna.kurapati@oss.qualcomm.com" <krishna.kurapati@oss.qualcomm.com>,
        Frode Isaksen <frode@meta.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Topic: [PATCH v5] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Index: AQHbpGotCMyNqVfBQkapu4JvyuN6TLOY2PCA
Date: Mon, 7 Apr 2025 23:01:13 +0000
Message-ID: <20250407230041.a37e4ay36b342pvk@synopsys.com>
References: <20250403072907.448524-1-fisaksen@baylibre.com>
In-Reply-To: <20250403072907.448524-1-fisaksen@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB5744:EE_
x-ms-office365-filtering-correlation-id: 5a6b10a7-44a8-4f4a-8725-08dd76281835
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S08zZ0lkR1JTMGZHUE44N1ErTnEvZ2doNWlVdWVwQTlHWjJkMEFSb1pCUkhH?=
 =?utf-8?B?NGROVld5c1ZhQ0VERmJkQ25hV2ZaZ3ppL1l3Q1BLRlBCK282djhrdzBLT1hZ?=
 =?utf-8?B?UzZ4bWIxblN2N3pnclBnUXFCejU4WjhuOWU5bW44eUpTd3g1MDRseHFJbzFY?=
 =?utf-8?B?bHo5R09uMEdmRjJxOHV0dndPKy9rM056OGQ2RDJOanFTQ3lJZmNjMHhxTU0v?=
 =?utf-8?B?QTRXTDl5R1llS0FiZnpHYlJZR0lzY0JoN0REWXlEbEZSOCt0MTR5OW5wM1ZV?=
 =?utf-8?B?WHdzOWFLMzV1QlRsc3BzNHlLQ0hucU5VM3N6bzM0aWZFT2Q4N1lUM1ZzcE8z?=
 =?utf-8?B?Qm1vNERlVU5uR1VkR0crUjRUay9oeWwvSC9IazA4K25aVmhZZDcwZWdBUFR4?=
 =?utf-8?B?RTRJU1BJRUVkbVNETDl4ZkQ1K3VKcXl5bUNhb0lJMFYyeXhuaHdtSy9YTWc5?=
 =?utf-8?B?d01ac3g0WWJ6amNaWU1HWTU2QzgzYnpUdTk4QjNjOFNNSWdEdHk4cDlHcXRx?=
 =?utf-8?B?RFZpSCt6RjIrRGJ3a0JycGExSWFVR2Qyai9MMk9POHdaWU1yWk9LZ2paK2NY?=
 =?utf-8?B?am5nSmVSVHo3TWdEbGRuMTIvS05sU2w2RmtOc2RINUxVeUtUMEpnaW1NVVUz?=
 =?utf-8?B?SEYvQnBYVEM3b21wKzY1RjYvbDNJSEkrSDVMKzA0NVJiUXNUdlpWOHUrT2Ey?=
 =?utf-8?B?TmFVMmJlSWxXRjl0RXczYmVjYnBoS2NpdlkyZm1uZmJOUnk1S3lxY2psNjR4?=
 =?utf-8?B?N1lMc2RSbXg2RmkwUFU2WFd0bm9MbWYrMGw3ekQvcUhYN294eElFN1g2LzZW?=
 =?utf-8?B?eXd4ZXBtSW5QNnRWZzloaDh5SGdteUdWYmYxKzgrdUdDbkVHQ0NDaVVqLzM4?=
 =?utf-8?B?QVVKd2lCZklGTkIvMGo2SkNnSEo0bmdMYVh5T1Z2b3RaZERCTS80MEVIby8y?=
 =?utf-8?B?MTNJMnZlbWIrZE5TQjdKaFdDcmV0Rk9ObGdkVS9ZaUd4L3RZSEdZM3VIL2gx?=
 =?utf-8?B?L2NQNzdtNUlkc3p6SE5IOHV0VitUcUlkbUI4V242OVFCSUN1Lzl2MVh0SHN5?=
 =?utf-8?B?WEdSR1VaZks5SDI2Y0xrSCtQaW1QcEpIV3VvZzRDSm5lcWhycS9ZQ0RWUHBL?=
 =?utf-8?B?eWFLOHN3elp1MHdoMjhlTWFQdlNMS094ampHOFUzdzFpU0k0OUNVRzlOY3cr?=
 =?utf-8?B?aTl5RUpneCtPQ2hGaXUxbmpYME1qeU9nS2o1UkhsejZHSTAvZFo0dVFpaEUv?=
 =?utf-8?B?NVFJSHc2d1RtS29GTmtiUGVsRzFmY0o4RWMrK1g5RUpMdmFpMWdMZmZodnRl?=
 =?utf-8?B?enltQVUvYWh4ZjkwYWo3MCsvY2EvdmFYZjNFbGJKdCtPY1BOZWxaZHZIUGxi?=
 =?utf-8?B?SUtHWURHVERpdHE4cS9mRXZFdm9vMXNCc2o5enJGdng3bTJ0cEVSc2o2QXVI?=
 =?utf-8?B?RjZ6V1VpK3pnNkZXR3IvbFNDUjJkMFNhejdDMHU3TVpuUWNGbmlZNjJqMVNS?=
 =?utf-8?B?ZkQxUTQ1cXBLYWNSZ0duVy9CdklnVEZrNTFXQmp1cy9ZZFpmTXNhMlJackNE?=
 =?utf-8?B?SW9GY3pFaXppTzdMODdqL0NKa0dxUk5JU0Z4TW96WnBYR2ZjQjN1d2p2N25Y?=
 =?utf-8?B?WUk4Z3U5dmtHQlpBUGZJQW1LTFVuSFRuQVprRUxDQ2ZLMGxJenZpYnFUM3Zi?=
 =?utf-8?B?dGsyelZLNm9icWdkeHVaZW9YUWh5N2FiYXRFOTVsaWxWc3poa1hvVUNwUnpk?=
 =?utf-8?B?UUJRSlphN1Z6KzJzY3JIYVRaS0FJMmFVWGgvc3JrV2x1ZkRuR3kvNmRGcjZp?=
 =?utf-8?B?L1ZZZmJLVE9lWVpUcUdzYnBOdytMM045R3Bobmk4R3BRSWNMdSthdklBTDZy?=
 =?utf-8?B?NVZ4d1hSbHoxOTV4ZkFuaFRPaEtxcVlKaUdJQWwwKzlvS2haNy85UkhXcjds?=
 =?utf-8?Q?XjFv+/x2Hi4FZdEEShoCE0HXDjcVub3W?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTNuMHkrVXFsTXMzcEF0UitsQ2FqbGlTSnEveTBzNXBlYVZCL1lWWGU1eHI4?=
 =?utf-8?B?dWNnQy9mOU9jTFhkY3pndFc2UWt2NnBSamxHOTF3Z3U3ZTdxZ2I1T3dWdjdx?=
 =?utf-8?B?TXhiOGlCNGlqN3pYdG5NQ2kxUitTMngyMmg1dWhaT082ZEQ2Y2pmM1htOVpw?=
 =?utf-8?B?aUlSQXJTS09FMk44Y2UzMDcrOHdCL2pJV283Z24yTEJSYmZQOHdwSENQemJ2?=
 =?utf-8?B?ZXBVOEZReGpSNUw5ZENUdU1jelRSNDBNUXFFN1pWQmRBTjR0VTNybUs5cUlB?=
 =?utf-8?B?K3B0ZzQ4RUtMRjdBY1IvSmZGRnVCdnpuN0VOSGpZakNicXZqZzlhTm9wNjZt?=
 =?utf-8?B?VDdMY3B0bTRUMjlxSktRT0xBaUdrYkswazdDcDJwM01KSm9uTlQybkR1UFln?=
 =?utf-8?B?Ym1NblZYZ3RGWVN4MGVOVkRSc2cyNHArcUJJdlNJL3M3eGxScFJkQmVzUTNP?=
 =?utf-8?B?UFNWeE9aWWNwYVpOSllrc3lCRW5FeENkMW5WTjQzaFNucHJTUHMvZUdGbFkr?=
 =?utf-8?B?Z2dIdFhSb0cwb20vRDlzd2lCMU9kcnRZUXpyOEdxM3d6bERWcmRKUThuYlBj?=
 =?utf-8?B?MXY2RlQwM0wxcCtabStnckh0MUx5Y0t6VXdMbWV1Smp4Y29tWEI2WWwxSHli?=
 =?utf-8?B?MGJXM0VybWxIMTdEbDFVbjBPQ2YzVEVzNStKTjVVL01rTWJvTE9uWG1qc1hk?=
 =?utf-8?B?M3hRL2RpeC8xN0RJb2wrdnJhT2J0SWpoamo1NTd4NmxMYnRnUWFIYmIyOEph?=
 =?utf-8?B?NFVZL2d0OXpJd0Qvc3NmMk5FeWZCU0hXVDRzaThaZ2dyV3JTcWR6UXJBV2Z3?=
 =?utf-8?B?RnpuYUFHN3VZZHk3N0lDSVo0MTJFbXpxN3lCa2x3aTdEN3lLdWlxVmRRa0Zs?=
 =?utf-8?B?UWpxZGE4WXp2TVJyRjJ4MGZWMjMwUmRlUGQvU2YzanhxUmo1MFpGdG95Q0Vw?=
 =?utf-8?B?cGJ6cHo1bFZtV25uc1VkWnJzUUJ0VkdqUXY3WlROaDI2MFdqTS9JenhLb09X?=
 =?utf-8?B?aXVoM25DOXpUT1V4K1FSNXpWTHpjaEwrQ0c2MG11MW1GQWloZTZJRnhhdkxp?=
 =?utf-8?B?bmp0Y3ppRjJEMkgwZHM0VEMyUTl5N05MNWhuNkZvOGJ6THU2bm1rd0hHK1ZQ?=
 =?utf-8?B?NVBTQXlVZXlwUVlKQzVtampUeE1vbktPZEwzWlpnUUZBeFJNbjNxcmdqeWdJ?=
 =?utf-8?B?dzlDbGhZY0tRb3NyT3M4amt1ZHNFUXRIMFBwQWVsUDN6ZlNrejBZYjduNUpY?=
 =?utf-8?B?YlB2U3dSZ05ibkZ2MEkxWXFGYlBIZTU0VVU4RmxyYm5aOTAyZFpKaWUvREd5?=
 =?utf-8?B?cUNkTjd6TUJtdWpreWNwWkVrUTJFcnRYM3lINVkwQ0NueUZLNmVaTVloQ0pw?=
 =?utf-8?B?WFlFVkVmL0NjMFVlQk1GSmwxQ2ZQakZCdzdsQ0hlbmM3OTd1R0F6WGhUeWZh?=
 =?utf-8?B?bEhzUjNhVVk5cnN4Q2JLQ0R2VTFyMGYxNFRFZkpaL0xLTnNKbHQvRk1VZG45?=
 =?utf-8?B?ZU4weGlTM3A0MWQvc0k2WUJ2NEJTUy9qWUNOKy9hVnVZYm5wZHRtZWNLaVZw?=
 =?utf-8?B?a2ltQWQyTkoveDVOOEhtMHc2d013elNSVTRyTFRuTDAzWUtGM2J4RXVlcit3?=
 =?utf-8?B?SFFoZHpuQnlrSmtDR2p6SU0weTAxL3lpOXV4V0Y5V1BsbEpSYnNGYmNCMTFk?=
 =?utf-8?B?eXZUeEhsdDZzcnh0SjRMZjBSa0tRZ1JJcEpBRU5ybjBjb09xL1pZblBYOXpH?=
 =?utf-8?B?bzUzeGJHOEN5cVJRVExZbGVGZDFoRnBlSDVoZlNKWXJ1ZFlGMk9Nanc5cmZP?=
 =?utf-8?B?cVcrU2hzamQrcS9DQWZFNW9INi8vVVp5Yzl4Y21MNmU5MHlqMGhiN09Fb0lP?=
 =?utf-8?B?WldmNkRlK0VzYTFnV25uRHM2TUxZSVhwTk9FNkRnM3VYSEtzSCsxaDRNMFdT?=
 =?utf-8?B?RlNCNzdxa1o2Y1hmWFlaZGVzaXpKN3VBNTdaVldTZUQvZ1ZwZEM2c0RrejBJ?=
 =?utf-8?B?ZEIrdk5kYlZMMld6ZHcvM282M1REdm5vaFBHb2JFekxUUW1pVGxFQUZLOTQw?=
 =?utf-8?B?bFZXa05NdUtJWHJsaWVIamtZNUludTdjVGM0TmhycXlmTTZPWGtOYnY1eE1F?=
 =?utf-8?Q?wsdvbWasgLlmNYZT3vjeBGkx9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0AC2C4481ED3048844CD7838A31DE37@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2nsB0lqymI5paViShLYBuKRYgE6MEcJopOo+d3Yaa6ugYh6OkVYTtyNkv9PEYSwXiNXm+m11BVZBmLkFt2RhbZuLIGoiRwrIu7wrQkg7LV6rf/hWqysNDg/i1+25U2QLKM3hDSYgM/pvysX4ZoaqK4mtBjy0+XWXucc24cHq6wNq17UG3ljD1/4GG0ySrMxWyvgDk1DMCd/UeEzw+5I0adn3vVHW+h2MxM1EnT4qXCz52Eh5VETL/PAiXKY7u7ErAhl0B4/C65uwIVqkok0j5wQ9MyikaJzrHV885zM/CFq6sIxv1XNtMcrV5UVze1Vm5vPXvYA40Kt+bL8/hiilpf1kiR3s+VN39L9OoNL+f85gpAd4BTPqPvLPYJG6onTeDuSSMl6ILo1+Ss6qdTQa0wzUCDRRF01Fs4WSpR7Sr95lm3QLok88f2Q/C/C2nza/KbgjymZzaogarou/1wvnSg3wJDC/Qit4HJ+Slu0dhENjnhjaDIMM/d0+UGK5WbhLr9/y/B5KzxmjaWzSo4/lD34jY+Xc12ko458KYZdtZnABJp44EWjT8Fd//PrmISHCyer0aoMXA4mnRrqalRmrBiu613DF13FeTn5N3BNZ3dKbDM7cKSnzpTs80H3Xk4XUq7mZz4gWnlL+Cc6KTqAeDA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6b10a7-44a8-4f4a-8725-08dd76281835
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2025 23:01:13.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JD7dCLztK7tosPdsilEKqnjH8e2BOMcf7wfzJXpH77Ou7Y/LoW3ZAYQ8MVwFcJDDL8msXpsqsJDEnvL5MuN4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
X-Authority-Analysis: v=2.4 cv=L9cdQ/T8 c=1 sm=1 tr=0 ts=67f45940 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=qPHU084jO2kA:10 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=a-4Oi9pBIDeB1OqtASAA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: 2Du37VHXAbAjzdtcjXdnUeSPqEmCq3IT
X-Proofpoint-GUID: 2Du37VHXAbAjzdtcjXdnUeSPqEmCq3IT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_07,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=577
 suspectscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070161

T24gVGh1LCBBcHIgMDMsIDIwMjUsIEZyb2RlIElzYWtzZW4gd3JvdGU6DQo+IEZyb206IEZyb2Rl
IElzYWtzZW4gPGZyb2RlQG1ldGEuY29tPg0KPiANCj4gVGhlIGV2ZW50IGNvdW50IGlzIHJlYWQg
ZnJvbSByZWdpc3RlciBEV0MzX0dFVk5UQ09VTlQuDQo+IFRoZXJlIGlzIGEgY2hlY2sgZm9yIHRo
ZSBjb3VudCBiZWluZyB6ZXJvLCBidXQgbm90IGZvciBleGNlZWRpbmcgdGhlDQo+IGV2ZW50IGJ1
ZmZlciBsZW5ndGguDQo+IENoZWNrIHRoYXQgZXZlbnQgY291bnQgZG9lcyBub3QgZXhjZWVkIGV2
ZW50IGJ1ZmZlciBsZW5ndGgsDQo+IGF2b2lkaW5nIGFuIG91dC1vZi1ib3VuZHMgYWNjZXNzIHdo
ZW4gbWVtY3B5J2luZyB0aGUgZXZlbnQuDQo+IENyYXNoIGxvZzoNCj4gVW5hYmxlIHRvIGhhbmRs
ZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzIGZmZmZmZmMwMTI5YmUw
MDANCj4gcGMgOiBfX21lbWNweSsweDExNC8weDE4MA0KPiBsciA6IGR3YzNfY2hlY2tfZXZlbnRf
YnVmKzB4ZWMvMHgzNDgNCj4geDMgOiAwMDAwMDAwMDAwMDAwMDMwIHgyIDogMDAwMDAwMDAwMDAw
ZGZjNA0KPiB4MSA6IGZmZmZmZmMwMTI5YmUwMDAgeDAgOiBmZmZmZmY4N2FhZDYwMDgwDQo+IENh
bGwgdHJhY2U6DQo+IF9fbWVtY3B5KzB4MTE0LzB4MTgwDQo+IGR3YzNfaW50ZXJydXB0KzB4MjQv
MHgzNA0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJvZGUgSXNha3NlbiA8ZnJvZGVAbWV0YS5jb20+
DQo+IEZpeGVzOiA3MjI0NmRhNDBmMzcgKCJ1c2I6IEludHJvZHVjZSBEZXNpZ25XYXJlIFVTQjMg
RFJEIERyaXZlciIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiB2MSAt
PiB2MjogQWRkZWQgRml4ZXMgYW5kIENjIHRhZy4NCj4gdjIgLT4gdjM6IEFkZGVkIGVycm9yIGxv
Zw0KPiB2MyAtPiB2NDogUmF0ZSBsaW1pdCBlcnJvciBsb2cNCj4gdjQgLT4gdjU6IENoYW5nZWQg
Rml4ZXMgdGFnDQo+IA0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDYgKysrKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5k
ZXggODlhNGRjOGViZjk0Li5iNzViNGM1Y2E3ZmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAt
NDU2NCw2ICs0NTY0LDEyIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2NoZWNrX2V2ZW50X2J1
ZihzdHJ1Y3QgZHdjM19ldmVudF9idWZmZXIgKmV2dCkNCj4gIAlpZiAoIWNvdW50KQ0KPiAgCQly
ZXR1cm4gSVJRX05PTkU7DQo+ICANCj4gKwlpZiAoY291bnQgPiBldnQtPmxlbmd0aCkgew0KPiAr
CQlkZXZfZXJyX3JhdGVsaW1pdGVkKGR3Yy0+ZGV2LCAiaW52YWxpZCBjb3VudCgldSkgPiBldnQt
Pmxlbmd0aCgldSlcbiIsDQo+ICsJCQljb3VudCwgZXZ0LT5sZW5ndGgpOw0KPiArCQlyZXR1cm4g
SVJRX05PTkU7DQo+ICsJfQ0KPiArDQo+ICAJZXZ0LT5jb3VudCA9IGNvdW50Ow0KPiAgCWV2dC0+
ZmxhZ3MgfD0gRFdDM19FVkVOVF9QRU5ESU5HOw0KPiAgDQo+IC0tIA0KPiAyLjQ5LjANCj4gDQoN
CkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRo
YW5rcywNClRoaW5o

