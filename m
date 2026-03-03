Return-Path: <stable+bounces-222766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBn4KJQvpmkrLwAAu9opvQ
	(envelope-from <stable+bounces-222766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 01:47:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D251E75AE
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 01:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C091301BA47
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 00:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCD21E5B9E;
	Tue,  3 Mar 2026 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QFLj/wMe";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O4vIz3x+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GEcKvtQG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5C19C546;
	Tue,  3 Mar 2026 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772498415; cv=fail; b=kP2lV/Xet6UmXu2/SejtphkQKJiqu9ch/yvz46vKkidtTcxHr5ThRnRmit3LywXBLe6oQZ1fr4NnaJiVUMziOHABw2jkAK/ZuKhN/1fEWBdYIvvkw0wk+n+UDSv4RxtWHpDwHYCYRu4AouFXuZw5QX8vfrmAYasU3JZiR/2okdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772498415; c=relaxed/simple;
	bh=VtBKU1/mfBtqd3VGo1FWk2wrh5Srq9EWUXrbd7VCHAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ahAcpPYdU4RdhiRbxnCF3uaodvKaVKuPpcVryzuIBSToOiYCWXK1eB6R287/YAzJjUQmL6pZ3zcy/9PGDkQYJSMOlc3zU0I3/b0nu4mOEOVZtgT7CsD4lwCrwOqpGc99pGVcPuWVdWFtXI8AfNJo/tN3tuCp4L/yaQR6kCZq8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QFLj/wMe; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O4vIz3x+; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GEcKvtQG reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622Kj9N82556738;
	Mon, 2 Mar 2026 16:40:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=VtBKU1/mfBtqd3VGo1FWk2wrh5Srq9EWUXrbd7VCHAU=; b=
	QFLj/wMejApH/6OvCnxig+FhcMFXDgQXsfTq/H13b9ES45m5BHiYG7PcVaaQqYjM
	Aey4DvFOsBwcYCiWXFAvTquHm3Hqybh6mAi7a3tU4nL4O5k31FNlQIkivdcqV2eN
	9/6xwsXKbgAAeODOb4PszTYFHznnbaxtqkjmy9NWQgJVZjoa3SQ75AJcKgpgM/oq
	wUpt8B4jBi5d/U35PBL0SgGl/KlaCoDgQ3FphM/fB+0yZdMSUjUev5ZzeyBRPUS8
	JsynoL/1CvUbUHNYXfo69i8OwW3Qn3GBxfVLV8QfUu7JtuSYvF6FrIbgAAWp+U7N
	TgKVoiIOLEPx7sUrGw34JA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4cng9uss0x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 16:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1772498402; bh=VtBKU1/mfBtqd3VGo1FWk2wrh5Srq9EWUXrbd7VCHAU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=O4vIz3x+Fno//2zivta99E+yMO5CQBvV6X5YCSav/OJxcRm2HmLImAxsOAKedFXAR
	 aRcMjPJO5H+3bzHxTvbzHh2QjUAJJnCtnD11fT5b5sKVYUxfDJaX40b8J/BGPZszak
	 e1INQbupXcxxapVvy5R+9x+Xctc95BlfXAIjC+YVtN1nszyhhjK2cd92OsaeyHxfsY
	 bLqpN1eO+xlnwLL6Wvc10j7/x4J3Vk+pzK9Zb6GFlv+1P2x11XT5u6/IN5jL1c/kv1
	 HVlybjucei4G6bhsMG9UqFv+CE+vy0asyk4emTGlYu50UYk+x2kdUCE7U9ka2p8w44
	 ScpL1x4rG8KfA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B783C40124;
	Tue,  3 Mar 2026 00:40:02 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4BDD1A0099;
	Tue,  3 Mar 2026 00:40:02 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GEcKvtQG;
	dkim-atps=neutral
Received: from DM2PR0701CU001.outbound.protection.outlook.com (mail-dm2pr0701cu00106.outbound.protection.outlook.com [40.93.13.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BF7AE4029A;
	Tue,  3 Mar 2026 00:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4TpAD0haW8zllqFi9zkb+wLSawKx0RhydcVQH/8CpCoCLnKk1Kk8fCwo5AApK1dBPe8AEkwvay5Diym7ajJxVYaLnfwMP6YMBdqWJFEpvmh1S4jzKiGqefLjqrtF8nEcFbLCRBYpiOLkHyAUo7Gfd/GX+pCaS8xyOUTvcQDOUDy0XrY8415AJkb5I5TKlBWwF3OYppOlACqI22e+bLPzk1Khptz7i/zY/G/kPHisECOGq3MsjnTStRaIoFOZmnZuLOZODMUXIySczcrFPpEqTocNq7fbzo2iwDJ0HHJORgZmV8rYMY1nGKFiU8PY5pkB5/Gn0yxcRfuabHLNTKEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtBKU1/mfBtqd3VGo1FWk2wrh5Srq9EWUXrbd7VCHAU=;
 b=iqXOrEgVe3g2RPb7O6YC7A6Wi596RijPNja7xQ0chfXWlm5wF0gXmQXs0qvqP9BvXFKf2kFTRrwPmqEbre0TWRjs+XUsz5+sbwreckpQ+XiRCnvIQ1upzP3F3oqR+nOktcdBboCgih6IYCDCDpCPWHI5tEeuk9acnaz0YZXbcZPiwZMeV6+vOia0Btcs3Y4RFfR6tROW/cuY+/8nP5GaNnM78ZPMt366gbzgCuBzgI8hFt6VOCaS58hEk5kxXSvaS7P6YGDtI2Oi5RBP+Znf0rrPqedoc6cGBWTTkuNjaEw0+L6ti2Rmrqpslny10ozWEzeFs7pY90UwMfyf6aDRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtBKU1/mfBtqd3VGo1FWk2wrh5Srq9EWUXrbd7VCHAU=;
 b=GEcKvtQG1FZN31S2qyWYZwIRIcPCWHKCOOba86Xr1NWFoJIMj17xuYsUWeMx5rayOsWAYwidPCYUQzfyVNhn1/uzrB58gvv8QAQJh6b5P8FcO4yhPNzhRVAqYCvk2PJxdmXXgDOS9+bu/arfdqye6zCUNe4R+82drrEhCfpNuBM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY5PR12MB9055.namprd12.prod.outlook.com (2603:10b6:930:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 00:39:56 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 00:39:56 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com"
	<eomji.oh@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>,
        "muhammed.ali@samsung.com"
	<muhammed.ali@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "pritam.sutar@samsung.com" <pritam.sutar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Index: AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCAgAS6jYA=
Date: Tue, 3 Mar 2026 00:39:56 +0000
Message-ID: <20260303003955.5lbb6xdrg7tp3zzi@synopsys.com>
References:
 <CGME20260227121338epcas5p4baebb406db37f07223545b2f85751bf2@epcas5p4.samsung.com>
 <20260227121236.963-1-selvarasu.g@samsung.com>
 <20260228002711.e442cuxwld4s2f66@synopsys.com>
In-Reply-To: <20260228002711.e442cuxwld4s2f66@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY5PR12MB9055:EE_
x-ms-office365-filtering-correlation-id: f99f246e-8269-4800-7105-08de78bd6474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 JreJNpaCxJrZrOWpxKJYlhBvVq/NXLxjdfEIgg7GQTXSSlt95fzdlYTgNLhxVJh++psSncGz8zelWP1HNv107Dd+2K1w2A3n1MnQ7qs4TiSJtkiYzV2FK/UXYN+z1MDFTf+o/nEmoZNHlMh6bPPl0GEJcyiuOITYGPRBpQLoVcqHKjQxvNDQsnNuWn2Ie8i7ohiwIOlCzUoDmNQxNacvbBJFujf0gcRS7HNmsTxZoY/2KNGg0sHNDgcETzR3Lfi0kQYYOgPtCjz7TALzkYKNcG6AcFGmWnMrjctj8lih7gl9OxVBoWRurCtkF+9QtgSeBIwImUK2nNKwaohwlOP4ahEx8NVbv5NX89xGT/2vKv1Wrf5I0RKrgKqcpzqp5Ow0B4PCtF8ZE3XhSwqnnLo7Uo1vwauXvHX9evrCAEjGJZ4aDoZyivI5d0FaB+lKgfN6dZERyHHHF4py53+XH5LjQwbArNR9tKraYSsywluGZsUMKiAiudPHkIIr+OdDQ79e6jzU3sa5sMWv9D3hCk0WasAAYsjcX2G3rsI9qXQwYMLC1zdMPujUs1P8sBaNK3mqVLoIdumxLptLBi+liH8lRt0y/9I6nMdihNxv8K4mR86GkmY1wHHcFl689Dv0Q5yyd+jwN+TEleop2GKygnPD1XfT+V3F+XTeA1o5CsVWpPj/Z0ijC9vLlDr08Rp3NHEy8kz3lZizHX0PlOhVGkWMKEP6XZahO82fOFLVSkzuWwl6VvrH9qdLT9jZ0y71BKfl5jR2BC6DtVN++kj5feGsnb0Bnc9lLDr2VSL6J2C42KA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDRxOFNBYy9leFUwS2o2ek9IV0Z4QnNFWThGYXoyQk1tSjdRRyt6OVFWa0wx?=
 =?utf-8?B?ZG9OODh0UHFRak5EdCtubGxGMTE4RmJCZzRtcUZITEdOTk16TXBZUS92Ynd1?=
 =?utf-8?B?WHZuUnlyRFNnUFdFMmJ5QXlsN0w5Y3Vtc2t1SjVtWXFPUTFRWlptUWlydXNG?=
 =?utf-8?B?cGVya1V6VU10Wk1jRFdmTGZMS2VtYkVmWGYwditoc2VHVHpLdlZLZGI4UFYw?=
 =?utf-8?B?ZmZBVjZ5MTBQTnF0NXpSdGVlOVF5SXlpTWtZWmprMEVYUzdiOVFLZ3NvUTZy?=
 =?utf-8?B?SWdOaHZOSDVwMFlqUnhWVk1wSmF6UHd3SUlMQkljZHorVGxERmNmME5UVEo3?=
 =?utf-8?B?MkVIT0h6VTZwYUk3bWtpMmtVT2RodVdtRWFZREFPYnNwdHdxbTNQNEVRWGFS?=
 =?utf-8?B?Z2RrSWRCZUNMZ0Nya0NCRVNISm1vbFJpRjZoRm5GRGtRR3Jkb01ETlFBZmZp?=
 =?utf-8?B?cDcydjdoaG90OWQ5Y3hTNEM2ZFVLTWUyRVJnS1QzcVdXRzZPSHZuY013ZHJK?=
 =?utf-8?B?VGdHbjRjbCtxd2dUOE9NYXBGSmhuNGNFbVA5b1paQ3QxUHRZbmQ2SE5HVzIv?=
 =?utf-8?B?b05NUnVnSWxkQ1p2YVBwYUw0aGRrS3U3dHFFaTNJcVFwSFlzZ2pOcVFzSmRJ?=
 =?utf-8?B?aUFlZ2pMZGl1T0dWcUt1c3EvVmxGN1JYeW1PSDhEUmtRRGZuY0xmdDByUW00?=
 =?utf-8?B?L3RqVXpzekYwNXd1Y3g2SnZBQ1VjL0JWVmNUM25EekR4RVQ1MHJGeUJkUVRK?=
 =?utf-8?B?ZTB2eUVaVDZiWkR0b0FTRXJYSG00NVBQdkhIUHJCcEhEZC9pQmJKeW12YjFz?=
 =?utf-8?B?czJKZUFPUXlBK25ET3J1eFdYVm9OaURyZ3VvT2pXRnEzT2FqM3d2bFVJN1pm?=
 =?utf-8?B?dmczUUoxTldkckNKamNpNVVGY2RRaERCV09Xc2MxdDdSVG5XVEtmck9XN2lD?=
 =?utf-8?B?bEc1UXBWVHlCYlAzN0tKUXlnS2NWVTVsSG40RGZORTJvM2RxV1NJMS8vMjE5?=
 =?utf-8?B?bERDT3ZxQUlaSDVRTGdXK3R4bi9tcmgxdDViNS9Ua1o4M3hVY2NOU3k0djEz?=
 =?utf-8?B?TERLYWFNSU9qMENDOWdrQ09RZGFrMjJxYXp6cGthZVFVR0VZNk5Tak9hN1RM?=
 =?utf-8?B?R0ROclpGemJ6c3F2bUlzbm9vSlY1TGo2dTBZTGxyV2l4bDNCRTlKdEpNZmFh?=
 =?utf-8?B?ZDBtM1FzV2UvNEZrT3poWDN0ZXRBM2hvYS82U2dCOS9BZWJHVmNlTTIxb0dw?=
 =?utf-8?B?aFVzMTBIQVQwblF2aG9IaDR5Z0xTSjh1VlVuSFJLL2RCZ2xUVVFqYkFHbGd4?=
 =?utf-8?B?SDhoYkxEK0VPYnkyaHQ1RmtkOXFSVS9IM3diY0EraWlwaUI2NEpNWDVHZFQ1?=
 =?utf-8?B?UjE1QXRVNW1XRzJLK05oWisvcFUzWGhWL2hEcHFIdEduM0JPOG1iSE5TTkVQ?=
 =?utf-8?B?eHBQYmtYWjhzY0tQSHhkYU44RzdueThQZEhDREtFSkJiRDY1TDI5ckQwWFBo?=
 =?utf-8?B?N2owWnV6TVh2YW55bUQ0Z0ZheTdZTzNBQWZnSkJlYlRsVjBVbk4vR1ZEdmZ2?=
 =?utf-8?B?U1ZlT3dYNk4wMEdTSkl2cGpvL3pYdlE5MTJNUW5MUngyNTd5MWx5TjNmeEtk?=
 =?utf-8?B?bXBCVGJzVjlWKzZXWTVsRUg1cFo3T21DRVZUSnAzTXZZdTFyZVRwa2lvdm0r?=
 =?utf-8?B?aFNYdjJHYVloZmZwUW5sdHRUbVc5MzhYSTQwRHZJNlpzRkYzWHNIa2ZWbjJ1?=
 =?utf-8?B?emJxclVFeStxZlgwL0tZelEyczZuSjN3SGNxZTFSMTdFOXpqV3ZzYWJNM2pt?=
 =?utf-8?B?WTdSS0lPZEpocVNDVWJ3dzlXS1N5L1VWV0xRNDczTG5TMnVoakdtTm44VU1J?=
 =?utf-8?B?TmkzanVFKy9PY1laWElhTGRHalFaMzdZUDNCT0FSLzdqbDlkZG9zeFBlZVd3?=
 =?utf-8?B?dXczanFlbTd4SWFNSmR2c0Z3MFJmRXkwZW5QYjFxYjZSeEZYZ2s5Z01PU01N?=
 =?utf-8?B?Ry9YV0huUnd1VkdBMmZCM0Zzek1QY0NiTTJpK0FPRHc1cENYQ2l5bEVGeXZ4?=
 =?utf-8?B?K0sxSU13OUJtd1VJRlVSbm5LMks0MFpuQ2R3a3NleFhpMDFKUjZDTCs5cmNp?=
 =?utf-8?B?Y0lKTTVyR1RTOTdBQ3RKZzE4KzJhekZmUFp5bFoyb0xLR05VU21rbk5RWEcv?=
 =?utf-8?B?QWpzWU5xQWl0NTM5QXhYYzR4WnZzVndDRUZMa1M5MVFzNm1IZGR5SlNmdm12?=
 =?utf-8?B?dTZpUE5pcGk4dTRZODBkcC9NUUUrUFFHRGE1SXRQTjRwKzdZUDFuU1VibFVq?=
 =?utf-8?B?ejBSSHp3NHhIOEJaZk1GMWwvUElranBIU2I4cWtQdjFqTEpNQmg0Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F4F7B9822FC50458CE97CAB6D9E082C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7dRB1aT77L2JO4BXIavVfQWn9i2VARJIluIaP7u8Nxcllq5S881/kH6RX/HFqq2M1xAI78XSgtKrbF45N88EdNn+0D6PJB5cHkRVPyjhkTSSTOgZAKsJdIG7YQVmdkxFdTW+CanZ9t8LT4eZ2d23S4uzCKLvNVan7y5z2rUiqJ5VzTN/72G/9nwMdgIVhCb37f4oSnc23HmnJwGLTiXTDWnqYnjblw5N5cvUy62JNlRck7SnMTt+Pgoi1x1spdPKkjdJr+IWEpy3LMfmZ7UTvU8je8GymdRm3yI0fV9CePi38fyAGZLr3N0UO/EFtE+woYdWF5K3lImBRRqn+yMKrJnGjwZUbxFFHYUTSr45jiNrtooKR9IagAmXxpNTbiJGmbFOoG5MhmaSzfUuJu7UxrA+J3vgjz31o96pxDk2C7+wclfpnlul2Ac2YLKzkXa97BmEigBH+ia8zurCs2FLAs/Oo1cASjOEj7BpcWD6Gf7KsDBuWwtM4u4TRrNNl8tA6by6lM+jSgpMlSpwEFOGhBf3j8WPi4qUdLG+jZ5PcMb/Iajlpcu6bySvn18xaiYVo5p/dcTAM8WQLdNYKgzrncVgIz+QTcfnjBm1hyrSNEd6Z7bqwkrmjEKpRwy1yWM6SHaoz9kIbdFfNoq0OSCivg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99f246e-8269-4800-7105-08de78bd6474
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2026 00:39:56.2379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qlz3XFTothG/CHVSNovdzNGcSyZMef49Lja6AtZOPLYEsVoWnJX7cQb3kYFSFaNbyxw8Xrskl06oIPClNq62Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9055
X-Proofpoint-GUID: o86JrEyUuA2MN8vBEtuLsnkI25HHgxJ7
X-Proofpoint-ORIG-GUID: o86JrEyUuA2MN8vBEtuLsnkI25HHgxJ7
X-Authority-Analysis: v=2.4 cv=X7hf6WTe c=1 sm=1 tr=0 ts=69a62de3 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=Wo6YDfOMAEstGd-0DxeT:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=z8x4lxVUFTnqNructWcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDAwMSBTYWx0ZWRfXzbtPdZ/ChJHp
 QzlhyM513kN9lC6AsHItzCPtl9F55CrQSQjSqUYFcYQAQzSuvSsA0O3IW7GpXs6UWoC9DWOyiVQ
 0OUkERSUd1ZGah0wwreAXOtr01ZsOc61iDl3aVkOa2VrM4rB6FBdQVfzpT464EQ04wlfADgnu9b
 O/vk3eujGeQcngFyqNvaAI7u7Bzzfsy0Zh4uppQ2wB95ZWF60UiGHFTJSUgUrsGYhLtUNczok5v
 63v7lDa5tDatsgW4xPqMQf14XD2kZZe/JMDhsTpMKoQDM77iPEoS5jqSIrGciOxH4iZKMOkcMTN
 LaIqiiVqSxU2iBC4JI/kZDwSQBNMKmT5b2FaZDIhJzeL8yq3EYOiP3dXqPajAFB71CpWrDhkU9z
 9GE12LuzfF3v72/mNEhPBeONfeuOoDeKdkAH1dbMSHBar6wfffqhN4dIp4ysDriCUlzsMrJrQHg
 cIUpl467A7FyeMQwGmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2602130000 definitions=main-2603030001
X-Rspamd-Queue-Id: B1D251E75AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222766-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,samsung.com:email,urldefense.com:url];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gU2F0LCBGZWIgMjgsIDIwMjYsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gRnJpLCBGZWIg
MjcsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+IFRoZSBiZWxvdyDigJxObyBy
ZXNvdXJjZSBmb3IgZXDigJ0gd2FybmluZyBhcHBlYXJzIHdoZW4gYSBTdGFydFRyYW5zZmVyDQo+
ID4gY29tbWFuZCBpcyBpc3N1ZWQgZm9yIGJ1bGsgb3IgaW50ZXJydXB0IGVuZHBvaW50cyBpbg0K
PiA+IGBkd2MzX2dhZGdldF9lcF9lbmFibGVgIHdoaWxlIGEgcHJldmlvdXMgU3RhcnRUcmFuc2Zl
ciBvbiB0aGUgc2FtZQ0KPiA+IGVuZHBvaW50IGlzIHN0aWxsIGluIHByb2dyZXNzLiBUaGUgZ2Fk
Z2V0IGZ1bmN0aW9ucyBkcml2ZXJzIGNhbiBpbnZva2UNCj4gPiBgdXNiX2VwX2VuYWJsZWAgKHdo
aWNoIHRyaWdnZXJzIGEgbmV3IFN0YXJ0VHJhbnNmZXIgY29tbWFuZCkgYmVmb3JlIHRoZQ0KPiA+
IGVhcmxpZXIgdHJhbnNmZXIgaGFzIGNvbXBsZXRlZC4gQmVjYXVzZSB0aGUgcHJldmlvdXMgU3Rh
cnRUcmFuc2ZlciBpcw0KPiA+IHN0aWxsIGFjdGl2ZSwgYGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGVg
IGNhbiBza2lwIHRoZSByZXF1aXJlZA0KPiA+IGBFbmRUcmFuc2ZlcmAgZHVlIHRvIGBEV0MzX0VQ
X0RFTEFZX1NUT1BgLCBsZWFkaW5nIHRvIHRoZSBlbmRwb2ludA0KPiA+IHJlc291cmNlcyBhcmUg
YnVzeSBmb3IgcHJldmlvdXMgU3RhcnRUcmFuc2ZlciBhbmQgd2FybmluZyAoIk5vIHJlc291cmNl
DQo+ID4gZm9yIGVwIikgZnJvbSBkd2MzIGRyaXZlci4NCj4gPiANCj4gPiBBZGRpdGlvbmFsbHks
IGEgcmFjZSBjb25kaXRpb24gZXhpc3RzIGJldHdlZW4gZHdjM19nYWRnZXRfZXBfZGlzYWJsZSgp
DQo+ID4gYW5kIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkgd2hlbiBtYW5pcHVsYXRpbmcgZGVwLT5m
bGFncy4gV2hlbg0KPiA+IGR3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoKSBjYWxscyBkd2MzX2dhZGdl
dF9naXZlYmFjaygpLCB0aGUgZHdjLT5sb2NrIGlzDQo+ID4gdGVtcG9yYXJpbHkgcmVsZWFzZWQu
IElmIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkgcnVucyBpbiB0aGF0IHdpbmRvdywgaXQNCj4gPiBt
YXkgc2V0IHRoZSBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQgZmxhZyBhcyBwYXJ0IG9mDQo+ID4g
ZHdjM19zZW5kX2dhZGdldF9lcF9jbWQoKS4gV2hlbiBlcF9kaXNhYmxlIHJlc3VtZXMsIGl0IHVu
Y29uZGl0aW9uYWxseQ0KPiA+IGNsZWFycyBhbGwgZmxhZ3MgZXhjZXB0IHRob3NlIGV4cGxpY2l0
bHkgbWFza2VkLCBwb3RlbnRpYWxseSBjbGVhcmluZw0KPiA+IERXQzNfRVBfVFJBTlNGRVJfU1RB
UlRFRCBldmVuIHRob3VnaCBhIG5ldyB0cmFuc2ZlciBoYXMgc3RhcnRlZC4gVGhpcw0KPiA+IGxl
YWRzIHRvICJObyByZXNvdXJjZSBmb3IgZXAiIHdhcm5pbmdzIG9uIHN1YnNlcXVlbnQgU3RhcnRU
cmFuc2Zlcg0KPiA+IGF0dGVtcHRzLg0KPiA+IA0KPiA+IFRoZSB1bmRlcmx5aW5nIGZyYW1ld29y
ayBpc3N1ZSBpcyB0aGF0IHVzYl9lcF9kaXNhYmxlKCkgaXMgZXhwZWN0ZWQgdG8NCj4gPiBjb21w
bGV0ZSBwZW5kaW5nIHJlcXVlc3RzIGJlZm9yZSByZXR1cm5pbmcsIGJ1dCBpcyBhbGxvd2VkIHRv
IGJlIGNhbGxlZA0KPiA+IGZyb20gaW50ZXJydXB0IGNvbnRleHQgd2hlcmUgc2xlZXBpbmcgdG8g
d2FpdCBmb3IgY29tcGxldGlvbiBpcyBub3QNCj4gPiBwb3NzaWJsZS4NCj4gPiANCj4gPiBBcyB0
ZW1wb3Jhcnkgd29ya2Fyb3VuZHMgZm9yIHRoaXMgZnJhbWV3b3JrIGxpbWl0YXRpb246DQo+ID4g
DQo+ID4gMS4gSW4gX19kd2MzX2dhZGdldF9lcF9lbmFibGUoKSwgYWRkIGEgY2hlY2sgZm9yIHRo
ZQ0KPiA+ICAgIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRCBmbGFnIGJlZm9yZSBpc3N1aW5nIGEg
bmV3IFN0YXJ0VHJhbnNmZXIuDQo+ID4gICAgVGhpcyBwcmV2ZW50cyBhIHNlY29uZCBTdGFydFRy
YW5zZmVyIG9uIGFuIGFscmVhZHkgYnVzeSBlbmRwb2ludCwNCj4gPiAgICBlbGltaW5hdGluZyB0
aGUgcmVzb3VyY2UgY29uZmxpY3QuDQo+ID4gDQo+ID4gMi4gSW4gX19kd2MzX2dhZGdldF9lcF9k
aXNhYmxlKCksIHByZXNlcnZlIHRoZSBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQNCj4gPiAgICBm
bGFnIHdoZW4gbWFza2luZyBkZXAtPmZsYWdzIGlmIGl0IGlzIGFjdHVhbGx5IHNldCwgcHJldmVu
dGluZyB0aGUNCj4gPiAgICByYWNlIHdpdGggZHdjM19nYWRnZXRfZXBfcXVldWUoKSBmcm9tIGNv
cnJ1cHRpbmcgdGhlIGZsYWcgc3RhdGUuDQo+ID4gDQo+ID4gVGhlc2UgY2hhbmdlcyBlbGltaW5h
dGUgdGhlICJObyByZXNvdXJjZSBmb3IgZXAiIHdhcm5pbmdzIGFuZCBwb3RlbnRpYWwNCj4gPiBr
ZXJuZWwgcGFuaWNzIGNhdXNlZCBieSBwYW5pY19vbl93YXJuLg0KPiA+IA0KPiA+IGR3YzMgMTMy
MDAwMDAuZHdjMzogTm8gcmVzb3VyY2UgZm9yIGVwMW91dA0KPiA+IFdBUk5JTkc6IENQVTogMCBQ
SUQ6IDcwMCBhdCBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jOjM5OCBkd2MzX3NlbmRfZ2FkZ2V0
X2VwX2NtZCsweDJmOC8weDc2Yw0KPiA+IENhbGwgdHJhY2U6DQo+ID4gZHdjM19zZW5kX2dhZGdl
dF9lcF9jbWQrMHgyZjgvMHg3NmMNCj4gPiBfX2R3YzNfZ2FkZ2V0X2VwX2VuYWJsZSsweDQ5MC8w
eDdjMA0KPiA+IGR3YzNfZ2FkZ2V0X2VwX2VuYWJsZSsweDZjLzB4ZTQNCj4gPiB1c2JfZXBfZW5h
YmxlKzB4NWMvMHgxNWMNCj4gPiBtcF9ldGhfc3RvcCsweGQ0LzB4MTFjDQo+ID4gX19kZXZfY2xv
c2VfbWFueSsweDE2MC8weDFjOA0KPiA+IF9fZGV2X2NoYW5nZV9mbGFncysweGZjLzB4MjIwDQo+
ID4gZGV2X2NoYW5nZV9mbGFncysweDI0LzB4NzANCj4gPiBkZXZpbmV0X2lvY3RsKzB4NDM0LzB4
NTI0DQo+ID4gaW5ldF9pb2N0bCsweGE4LzB4MjI0DQo+ID4gc29ja19kb19pb2N0bCsweDc0LzB4
MTI4DQo+ID4gc29ja19pb2N0bCsweDNiYy8weDQ2OA0KPiA+IF9fYXJtNjRfc3lzX2lvY3RsKzB4
YTgvMHhlNA0KPiA+IGludm9rZV9zeXNjYWxsKzB4NTgvMHgxMGMNCj4gPiBlbDBfc3ZjX2NvbW1v
bisweGE4LzB4ZGMNCj4gPiBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KPiA+IGVsMF9zdmMrMHgzOC8w
eDg4DQo+ID4gZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg3MC8weGJjDQo+ID4gZWwwdF82NF9zeW5j
KzB4MWE4LzB4MWFjDQo+ID4gDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdAc2Ftc3VuZy5jb20+
DQo+ID4gLS0tDQo+ID4gDQo+ID4gTm90ZTogTm8gRml4ZXMgdGFnIGlzIGFkZGVkIGJlY2F1c2Ug
dGhpcyBpcyBhIHdvcmthcm91bmQgZm9yIHRoZQ0KPiA+IGdhZGdldCBmcmFtZXdvcmsgaXNzdWUg
d2hlcmUgdGhlIGdhZGdldCBmcmFtZXdvcmsgY2FsbHMgdXNiX2VwX2Rpc2FibGUoKQ0KPiA+IGlu
IGludGVycnVwdCBjb250ZXh0IHdpdGhvdXQgZW5zdXJpbmcgZW5kcG9pbnQgZmx1c2hpbmcgY29t
cGxldGVzLg0KPiA+IEEgcHJvcGVyIGZpeCByZXF1aXJlcyByZWZhY3RvcmluZyB0aGUgZnJhbWV3
b3JrIHRvIG1ha2Ugc3VyZQ0KPiA+IHVzYl9lcF9kaXNhYmxlIGlzIGludm9rZWQgaW4gcHJvY2Vz
cyBjb250ZXh0Lg0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gIC0gUmV2aXNlZCB0aGUg
Y29tbWl0IG1lc3NhZ2UgdG8gZGV0YWlsIHRoZSByZWFsIGdhZGdldCBmcmFtZXdvcmsgaXNzdWUN
Cj4gPiAgICBwb2ludGVkIG91dCBieSB0aGUgcmV2aWV3ZXIuDQo+ID4gIC0gTWVyZ2VkIHRoZSB0
d28gZml4ZXMgZm9yIHRoZSBzYW1lIGVwIHdyaW5naW5nIGludG8gb25lIHBhdGNoLg0KPiA+IExp
bmsgdG8gdjI6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC11c2IvMjAyNTExMTcxNTU5MjAuNjQzLTEtc2VsdmFyYXN1LmdAc2Ftc3VuZy5j
b20vX187ISFBNEYyUjlHX3BnIWNRelFRNWtBV0Y2Q0U1aFFlN1ZxRmRuYXhxd3pzVEIxWkdOVDFH
dkNIMjhHb0JfbkVTWlI1WTJqdHhkWkJsczZ3QklNNE90cHZHNGRTYXlsdk5DM3FiaDU0N2skIA0K
PiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBSZW1vdmVkIGNoYW5nZS1pZC4NCj4gPiAt
IFVwZGF0ZWQgY29tbWl0IG1lc3NhZ2UuDQo+ID4gTGluayB0byB2MTogaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI1MTExNzE1
MjgxMi42MjItMS1zZWx2YXJhc3UuZ0BzYW1zdW5nLmNvbS9fXzshIUE0RjJSOUdfcGchY1F6UVE1
a0FXRjZDRTVoUWU3VnFGZG5heHF3enNUQjFaR05UMUd2Q0gyOEdvQl9uRVNaUjVZMmp0eGRaQmxz
NndCSU00T3Rwdkc0ZFNheWx2TkMzOHotQ1JENCQgDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYw0KPiA+IGluZGV4IDBhNjg4OTA0Y2U4YzUuLjNhZjFiYmZlM2Q5MmIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gPiBAQCAtOTcxLDggKzk3MSw5IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dh
ZGdldF9lcF9lbmFibGUoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQgaW50IGFjdGlvbikN
Cj4gPiAgCSAqIElzc3VlIFN0YXJ0VHJhbnNmZXIgaGVyZSB3aXRoIG5vLW9wIFRSQiBzbyB3ZSBj
YW4gYWx3YXlzIHJlbHkgb24gTm8NCj4gPiAgCSAqIFJlc3BvbnNlIFVwZGF0ZSBUcmFuc2ZlciBj
b21tYW5kLg0KPiA+ICAJICovDQo+ID4gLQlpZiAodXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXNj
KSB8fA0KPiA+IC0JCQl1c2JfZW5kcG9pbnRfeGZlcl9pbnQoZGVzYykpIHsNCj4gPiArCWlmICgo
dXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXNjKSB8fA0KPiA+ICsJCQl1c2JfZW5kcG9pbnRfeGZl
cl9pbnQoZGVzYykpICYmDQo+ID4gKwkJCSEoZGVwLT5mbGFncyAmIERXQzNfRVBfVFJBTlNGRVJf
U1RBUlRFRCkpIHsNCj4gPiAgCQlzdHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3BhcmFtcyBwYXJh
bXM7DQo+ID4gIAkJc3RydWN0IGR3YzNfdHJiCSp0cmI7DQo+ID4gIAkJZG1hX2FkZHJfdCB0cmJf
ZG1hOw0KPiA+IEBAIC0xMDk2LDYgKzEwOTcsMjMgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0
X2VwX2Rpc2FibGUoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gPiAgCSAqLw0KPiA+ICAJaWYgKGRl
cC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApDQo+ID4gIAkJbWFzayB8PSAoRFdDM19FUF9E
RUxBWV9TVE9QIHwgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKTsNCj4gPiArDQo+ID4gKwkvKg0K
PiA+ICsJICogV2hlbiBkd2MzX2dhZGdldF9lcF9kaXNhYmxlKCkgY2FsbHMgZHdjM19nYWRnZXRf
Z2l2ZWJhY2soKSwNCj4gPiArCSAqIHRoZSBkd2MtPmxvY2sgaXMgdGVtcG9yYXJpbHkgcmVsZWFz
ZWQuIElmIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkNCj4gPiArCSAqIHJ1bnMgaW4gdGhhdCB3aW5k
b3cgaXQgbWF5IHNldCB0aGUgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEIGZsYWcgYXMNCj4gPiAr
CSAqIHBhcnQgb2YgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQuIFRoZSBvcmlnaW5hbCBjb2RlIGNs
ZWFyZWQgdGhlIGZsYWcNCj4gPiArCSAqIHVuY29uZGl0aW9uYWxseSBpbiB0aGUgbWFzayBvcGVy
YXRpb24sIHdoaWNoIGNvdWxkIG92ZXJ3cml0ZSB0aGUNCj4gPiArCSAqIGNvbmN1cnJlbnQgbW9k
aWZpY2F0aW9uLg0KPiA+ICsJICoNCj4gPiArCSAqIEFzIGEgd29ya2Fyb3VuZCBmb3IgdGhlIGlu
dGVycnVwdCBjb250ZXh0IGNvbnN0cmFpbnQgd2hlcmUgd2UgY2Fubm90DQo+ID4gKwkgKiB3YWl0
IGZvciBlbmRwb2ludCBmbHVzaGluZywgcHJlc2VydmUgdGhlIERXQzNfRVBfVFJBTlNGRVJfU1RB
UlRFRA0KPiA+ICsJICogZmxhZyBpZiBpdCBpcyBzZXQsIGF2b2lkaW5nIHJlc291cmNlIGNvbmZs
aWN0cyB1bnRpbCB0aGUgZnJhbWV3b3JrDQo+ID4gKwkgKiBpcyBmaXhlZCB0byBwcm9wZXJseSBz
eW5jaHJvbml6ZSBlbmRwb2ludCBsaWZlY3ljbGUgbWFuYWdlbWVudC4NCj4gPiArCSAqLw0KPiA+
ICsJaWYgKGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQpDQo+ID4gKwkJbWFz
ayB8PSBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQ7DQo+ID4gKw0KPiA+ICAJZGVwLT5mbGFncyAm
PSBtYXNrOw0KPiA+ICANCj4gPiAgCS8qIENsZWFyIG91dCB0aGUgZXAgZGVzY3JpcHRvcnMgZm9y
IG5vbi1lcDAgKi8NCj4gPiAtLSANCj4gPiAyLjM0LjENCj4gPiANCj4gDQo+IEFja2VkLWJ5OiBU
aGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+IA0KDQpPaCB3YWl0LCBk
b24ndCBwaWNrIHRoaXMgcGF0Y2ggdXAgeWV0Lg0KDQpUaGlzIHdpbGwgY2F1c2UgYSByZWdyZXNz
aW9uIGZvciBVQVMgZGV2aWNlLiBXaGVuIHN3aXRjaGluZyBhbHQtc2V0dGluZw0KaW50ZXJmYWNl
IGZvciBCT1QgdG8gVUFTUCwgdGhlIGRldmljZSBuZWVkcyB0byBpc3N1ZSBhIFN0YXJ0IFRyYW5z
ZmVyDQpjb21tYW5kLg0KDQpUaGlzIHdvcmthcm91bmQgd29uJ3Qgd29yay4gQ2FuIHdlIGZpeCB0
aGUgdXNiX2VwX2Rpc2FibGUoKSBpbnRlcmZhY2UNCmFuZCByZXdvcmsgdGhpcyBpbnN0ZWFkPw0K
DQpCUiwNClRoaW5o

