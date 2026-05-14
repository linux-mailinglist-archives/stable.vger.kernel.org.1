Return-Path: <stable+bounces-247085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qH9YL9AoBWoYTAIAu9opvQ
	(envelope-from <stable+bounces-247085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:43:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD5253CD12
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00559301C158
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2D320CCC;
	Thu, 14 May 2026 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GUw/VhW5";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gvV4X5Ek";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="E5K9TF4y"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D331F987;
	Thu, 14 May 2026 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723017; cv=fail; b=AyBVvTZikJxI08Zqn+j3ZJFs3JXQBRC8y3503oaHj8LuhJhNv9gdw/S9+SwJmegJquDW5B4Z418TWQg1W/Hr8EI7o9Zr23/LqSkg6EyBz9OG7fZTo5VQnIqjwjOdRGLs3yO3Ej5uFMWvSLCjVMHGHkJjGlp5LZTP+R0kLdpvBfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723017; c=relaxed/simple;
	bh=XkWst1w6HBp7OB+s0mG2Iid9IneBnc94knKGWNrXlGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dnsEOOAIhThkp2v51ze4InyVmZwzrUStNjnFQ/2QM0drNxXT+z8WfJIHWGewF6e4R50uOHlVql1q+6rfVMaFXnxX/N/LZCL/4mABuwuOHT8Ky7ztOdG3Wp8Ludacwt3GnmkDIK4Q6UU43aeA+ntTcZVqkdA2Q0xZ1TA0zCEOQUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GUw/VhW5; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gvV4X5Ek; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=E5K9TF4y reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DLQcYd3314980;
	Wed, 13 May 2026 18:43:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=XkWst1w6HBp7OB+s0mG2Iid9IneBnc94knKGWNrXlGw=; b=
	GUw/VhW5MqkCaBqBOOm9Coab1YdxEAIyczhFFeFlR/vMPm/i/gatdvhkKTpWUqU5
	tDoEI4AhAXWes0BNWQWPLE9o326ZzjO6e8XB3tnQAkGmWxNekP9HRfQg1Pj4WMht
	P6J3zqvDTier8FZFGG4spsEfGBYvqvqwzS4u7Zn+ncQnwyBbU2iQ6vC3X3TdsMrx
	Bqcj9DeRMVD09AiFahPPiT7d9jg9+nYKT4B+or6Xf3pzV/PBEme0Bt2csQULrqK2
	UM9QK1eUezru9jmrf4Vq5ZmGSbeInJ4IXwCr2PBy257vgXPNqtD/tUb4Qgw1dLX+
	cCOTEniutzS2DYCPRGeb+A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4e4utf39nv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1778722994; bh=XkWst1w6HBp7OB+s0mG2Iid9IneBnc94knKGWNrXlGw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gvV4X5EkqtR54HA0c5ITVzMM/QjyMsiRBWQt2iJsL+1EPNtlZZfwDTKkYNKObb/r4
	 dM6IMPF8JMvW22EJlp8OQFsyXVg/cwGVPzF+2tMeYDr5On+eu3vs5vxBEgyNh21dyh
	 SStebDrZku3lZjRkhSEJjDvpq53RHcul2RQ/q3Ba7oPGGbHrZdgt/tFuDq6QP2yYMF
	 ON+MPqInZ0kf03fqE7OWYr3/bRe9bybxCQ4OpWrgvwK5betLcOd9BhoHzwFyVbM97D
	 A1wiZuE7xa612n+7AHS0aKhFwplZqVmkN56wum/7aCM2zZQ3K9lGKFJolpcodWayRb
	 qa7MdT6pfcs8A==
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AD57E40340;
	Thu, 14 May 2026 01:43:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 288FDA026F;
	Thu, 14 May 2026 01:43:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=E5K9TF4y;
	dkim-atps=neutral
Received: from CO1PR07CU001.outbound.protection.outlook.com (mail-co1pr07cu00105.outbound.protection.outlook.com [40.93.10.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D644240130;
	Thu, 14 May 2026 01:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WchfpyZ/Gsir1J4P1DOaFjAnEEq81WNQh136VYa9FlBl1kkSL9cYVWUb483bN8iF5JzP+97jW8TNTxwnKGAbWC9Og9lDvR9v5zpqRJU9hXxesDZc+mAhm03htBu+iS2Yuca3tQV58NNYVjDOTQVzw3044NVUdhXK+STnKp7Diq9tAJxAQj2hBEHH4WYn5U2tFlZyrbUcUd8otg1RR27IxAdBtRc81yA/i0Rt10pB3CGRWMJpKBtCVNObp94QjAwEBFTk5qG/rgGqcPFCvJ4GGp4wLV/VcBgQbEqfWcS/YQB0DYKTlTbGOJ1kBDtwWG6S1TV9GO0tIjkA2dWugfLFGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkWst1w6HBp7OB+s0mG2Iid9IneBnc94knKGWNrXlGw=;
 b=btBQwil98KQJ5s/mcLI6n6/IvWZtT4cxZ5i9w8k1WKcpGioXebyzXt/mHEUTgKBVkMB+tr5+6W2sGqiH09QpwV7w/dUdOyKqw/xwJYmPGelch7NQCipQ7fxCmquGcmjA/eIriMkOF+d/ylPh5LacT1HOzWLIe8trHQvFSJf5OptJjyrrH6YJVH+BXFPQEdrDaEylSB7myzzNc3f6uABRJmK3nYx1YOnmjS1ak91SaUNNkyJ4q9hPg3zz8ndM861FVImr/n6oUCG0ko1ZLeIuaQ5eNdJhlFmWrumK7B1XTJIx6elqAGSVGKo2IeVvF2faDbvndvobNATfVBhLDyfHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkWst1w6HBp7OB+s0mG2Iid9IneBnc94knKGWNrXlGw=;
 b=E5K9TF4yTeUwZSUKam26eWrwVbibRuhklwo5xVJClxVmKAiSznoP4y89JqwnKoCDpAJpkQd4AMyMXDJhyjjTlDT5BUyVFybe1QOVu9Y+nModr3//9obIftkMm4pjEROHqLhy/he6TBHzWrJvC2pizlMskrP61iIwBABopuX0rp8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 01:43:07 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 01:43:07 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@amd.com" <git@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 3/3] usb: dwc3: xilinx: fix error handling in zynqmp init
 error paths
Thread-Topic: [PATCH 3/3] usb: dwc3: xilinx: fix error handling in zynqmp init
 error paths
Thread-Index: AQHc4WCJ388cHRBdu0u38FjUG8Y1VrYMwxOA
Date: Thu, 14 May 2026 01:43:07 +0000
Message-ID: <agUnwgXyyrGQ2t2y@vbox>
References: <20260511160814.2904882-1-radhey.shyam.pandey@amd.com>
 <20260511160814.2904882-4-radhey.shyam.pandey@amd.com>
In-Reply-To: <20260511160814.2904882-4-radhey.shyam.pandey@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS7PR12MB8347:EE_
x-ms-office365-filtering-correlation-id: dba5a8f6-7055-460e-34cb-08deb15a25e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|4143699003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 abtsHGNnjTKl5eGXa1BRwsd7VJgYJGMGpg6G+rAPWQ9U2IF2DLrashU3vccYSqjsjwmNBBZ4YpcgPXGPP+EM1W/MZVxdcYpAbn3IlRLta3CEzh9QRwfgKgpZEDHqN+KmQ9wcepOZkp7lLMPNgv4heU6KNutM4JaaxoHakApBBOGt5q7oWPaU0GHl0PqA8e6CckNu2xGyLwzLogEub7cYFuLCuwczl5TFNoofoXR+qXFS0ydFrUY9qyRRoSkDRr2ZcMjNm3Me6HYDUgA4P5aa75X7OJ29DNcRke5WCeD3oqQo8xrzv7jizQqFAJWOTwyokAj9he9/buqKX77xmhp9pkoIFw6IYf98BQciF8lyQq19h506KMpLJL6sFqan6ooXId6GaEabIocj/g7ae1P1O5rl+hR4VaMfCXy2PWBjQ2ednnmPXFo4OHhupmEKVICuVdAhLTdichxqA1HJ1PYRef+NgScMRANfDCZto/9LHt+85L4qScW3Oagmni7wLROjRSGeJnGtLhSIvAthw8nocPS19+OcYYRXHdGjXY6D3ySjJd0p7NT7fd4cA8i7jyHLb/drGit22MAtn/insXgOtPdLptoyyfgNymDBMEV7bmAwc2gFFo/uH8k2xRU04WIqMBHNTz5ooM3sIcp8EVRjJe9EbX5xbpek0Kj0l62F5cRnFX0JqPbWLvTzlTO4yjlyeWERHvbzLNwsALcCjLFw0aCFxmxEj/fIjAeutY3/O/Co2lknOM5EfnvvjCTmDim/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RmlRUTdWcXRHR1ROTmR0aVNFNnJJYVFydUF5UnVKaUFoYzN3dFJKWG1iYjF1?=
 =?utf-8?B?WEVhWHZQZTBvMVdJSW1OWUFHVnlGK3RYVXV6ZFRRamtBU1E1dFdnRTRNeUxl?=
 =?utf-8?B?aEhoT1EvbXUzYVRZQU5PM0pMRWJPbndtRzZXOEd3VmtsWk5RcXVwZTlGRVcr?=
 =?utf-8?B?T1lDaWkyWjVuK1FweXVaMXRDQ1pkQllaY3JjZWJBeHN5Z2FEMlFudi9hUnl1?=
 =?utf-8?B?WDdVQkNmd3JZQm9lUGduQklSUGg0MVFmWS91Y0FCek9LbDJ6enRKN1VPUjhH?=
 =?utf-8?B?NlpEOUl3SStTR1hTT2llQmdhY1JVbnpWRWs0L1dqTElMYk1mVVh1UDFOSXFL?=
 =?utf-8?B?K2x3aFpQYlpTRW04a2Z2aEhZUldFbkVxam9xMzJMaUJ6c1RMYVRSNGpoakFU?=
 =?utf-8?B?NDZRaHU3UWMxZW43UXB5NjhKcnk3M1JiWUh2dlUxdkRhVmUyY20rbXc5c1VQ?=
 =?utf-8?B?ZnMreGFOSWJrcURsTU5makowN29rVkVLSUpCVlAyZDFTdVpNYW45RXdMQUdT?=
 =?utf-8?B?UEZuTWwvL2RCalhYdDJpZEduL0YxY1pWdlQ4dkFFc3pac09ER1VmUk9NWWgy?=
 =?utf-8?B?N1NXTlVqL2d5N09BcVczVFM1RTR3VVRLN3ZYT0dhZ3U0cFlTZk0vRWpaQk1u?=
 =?utf-8?B?S1hHbU1ER3JReDV3dWg1SWFleElmRHQxMlU4Ty9NVTlqSjlFc1I0SWU2ZjU2?=
 =?utf-8?B?MVd6THR3MVpFU1YvWk5rV3lHZ0JxbFJ2SndwNTM5R3RrTUloSlBQSkNqVmtI?=
 =?utf-8?B?c0VGV1dwcklDTHlpRTZHZlVRU1ZzczdIcGZBUDNwWHcvVWY4cVFpTS9ncTFw?=
 =?utf-8?B?WFowQVBBeHhMU21FNmtLeGRIa3hjbk9ySEdzU0Npd3JYWkluU2xRdzQzMzJp?=
 =?utf-8?B?czhSODIycGlydzhKcmMrS3BHVFljN0s2MVRwYnFNZENqcWJ4Q1Eydlh4RUZz?=
 =?utf-8?B?SlpXYk14blFLbXAwZ2lqdnpkZFN0YWszME0xT0RSaTBHeW11Q3puRGVvMXJV?=
 =?utf-8?B?bnZjRVhibGx4N25kZ3JBajZ6UWRsQ2VoZmwyem50UWtxOWNhK21jckVmcHc1?=
 =?utf-8?B?WEtKMXNBclF4elZMc1V6NUNWOXAwcmpUU2JhTHpNSVJ6eG9QSW0yQWVIcndX?=
 =?utf-8?B?UG4wNzZYL3J1c1FyMS9IVlNzSTd2d3RLbnUxSURwK1A4aEZXN0xPVE9rbC92?=
 =?utf-8?B?YTk0ejVDS1cvWW1HUHl1UHl3b0ZJRUo0ZnRidk9rMjAzc00xR0dFckk4Q1VV?=
 =?utf-8?B?R3ZJYkkyRGI5NXhWU3NmbHdlcVg4ck5weDZpNXdNL24rMVNhT3pFQTlMVy9n?=
 =?utf-8?B?QXZSdXEzMWFmeWlBL1p0bXkyakdtZWZKMG45Y051NTRudDVYaFRJN21IQkZQ?=
 =?utf-8?B?a0dsVEdDYnQ0STZ5bnRqbjZZWk95V1dJV3l6d3dlVHNuaml0UnExYzRwNnJU?=
 =?utf-8?B?bWNLeU1kWTlrMDY4VjNabktNNmlVOTkram13ckJWcnpPbnkyN2VLS012bGhQ?=
 =?utf-8?B?WlNoaWdnc3A0NlN4eWtNQ1lsWnJHODExc1dxMk8yZG9BUCtxbTBBRERya2xn?=
 =?utf-8?B?cDIwcTY1YzdDYVZuN2kzTklsSzRqbUk4SlhzYlBUQUdZdDRIUWFubUJQVHJZ?=
 =?utf-8?B?ZlcxWXE2R01aL2NqRmVMUHVJZUZ0YzJ5cmhRK0tCbjNLZ3dCaDhOZm5qT2hs?=
 =?utf-8?B?NHhJU1dRM2tDT3Rkd3h4akhmU21nRk8rWFE0K3VyNGZQdzVhanNxY3A3cFlq?=
 =?utf-8?B?QlBxdUdibk9vTy94TnV2cHloTDRTdngvNTc4NTcyaHg1eVlsd0V6MjU1NHp0?=
 =?utf-8?B?czdjSUhWVFNzK0JickhCZjY2bVNPYllMcHplTWk4Q3FKTlZYWTl5MUprN0xJ?=
 =?utf-8?B?ak4xMjRKajdUVDU2WCtlQi8zRmxIcVpmSCtueVVRQmowUkJMQkYwRUtmUkJW?=
 =?utf-8?B?YkxGVjRvVThNbGQraVo3UnJCTWxsNjdsRVdteVF6TjM4RjZNSkwvblNtY3g3?=
 =?utf-8?B?cnRzU3RrSE92bWVGZVFVU25yWURrNThCUnJhbmE1dVhZRVN4YUovRXdMMTN0?=
 =?utf-8?B?MU93YzF5WUUrZXFoK2FidUJGNCtjdUx6VGdHOHdSdWdBNnVzSmxLTnZJRkZ0?=
 =?utf-8?B?YlAyZUFhbytXUTZEUDIvcjlneTQ1anJiQ1E4RXN3ckpieitjSFhscXR2TjRy?=
 =?utf-8?B?bkpYSm53MDlOZ2liZEtiSXhOSHAxNUNBMUJSQ284WldwN2lZR3V6ajVpZERy?=
 =?utf-8?B?WnBSOEVKNFhOeHRNMC9MdDVUQUJWSVZld3BzUU9PbWZUS0czRlNqQ1ZqcXFh?=
 =?utf-8?B?cXFyM3p4WGErYTZ3bzkzSWxXOExYWUJDd3ZUN0pMR3hhbTMyUW1Jdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36C2EF8622435B42BD2EC8180E28D9AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MyzL0OMTIFeAB0+QGhXyBPMBpk0s53utHweG7l15H94HwdQlMkvEi4JDBFcGjbK2QurcZ1N0HAQcBc9+0Nl9aASxityLkFezmPMBc1TJS2nkMpaFHvrfZ6IJ9GTHwyOuSliGhS16Gqn4+37uDcTmuUynajt12YlqaQMPIiBWmr1XPpRpr259qDX8NwSt/hl/WLu8DtImEThatrx+wiB6ygl6z3y+6rv+ggQGuGd6xZIP3J1hjMNBeUv+dNVQm/iwwGGV7WAltUk/aS1jVDVCGD2aTuVeCuWCfUSrq0dORRjGR1RclqW8XHgdCuUT4feuQrGpLn8FFUdxCIlEVRR36Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yOhWL4mq+ZxAJzEMmc80EXDdYFz0htKOnYJ6So5WRiMfN0ZsI198Xqy76YLIiP8y3RUocsbHGCNuEC4GmTlyf+n3CKYGuKzCXVs7mrPgw0Y3vpIdeZ/ccFLN79z+0GLXf1jYYE2P4IW60j1iBpbe0thKZ5aI3VW8Km2EmVWzDZGOAqaTk2FumwSYiPOUrNsZIBwz0xFZLQvTap/kwmSPQ2FtH0GDD1T4AjtdgRLDtup6iXn/KQ0hLDakGCY67zWLXGVKpg8xLOsBDpelKtJODPqiwHw0cY6MQxHtcm/WiRUceenkJeNgKmIH5WiKQfA3OqlNytngbJzQAuccVdSbyOKY2Ts0zi8e90oPnPDLIkAp4ZvCGUsc7VYJgWc0UUU1Phq9LZ1bExyIiZdhxoJoNOgCSpblnGf8qdvgsrKRwShX1/eL7MSqB3bpPs83WeKW9g/6BeIFf4gQP2fIl7hVs98mqdwO97y+ZA7K58tmz2UKG4GIA4/rivNjvROKLu+VnDfliiUrYs3M4KN3q/luLU3L5n/+s9MSw5XM6uXyM4uad1e+Z3slXVHBJQKb3hA5z7hICmcGPnWxI11fpVsGYWnPBu09F6xKNydVYF6Kkr5MNaxXtytWQQ/5xhubca6rtYNRKZ8AmZDlS7daHfQGQg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba5a8f6-7055-460e-34cb-08deb15a25e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 01:43:07.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrMnF3I7eJCypoW/jm0xC/eKkhh34tF1UccktTDgn0ebHuuRMVLhtCpPjyl0xIQ0+QCE5fcKbZRpe1OHGsWsXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxNSBTYWx0ZWRfX6JlPPyTv2iCA
 Rlob5kd/SmDMGlV9tvMVizWWcnsjbUhCgi8/CfkikfSw8ARrddKtkR9bKJz8J882yjKn+Tn13GR
 Q67zTJRwo088bbWvquN9rSTAcv3CYHAyuDA6q/HkIJMML3hbUIB8BB2RTHeCMnncyQYDgUYA8bA
 emI4z2iT9uFfrVbhnGvZaEoeEMkDLbgKMlWICO0ReqnGINA7rVbMAfCmacoUCDEhHKc9WF5qzHX
 67DLi+nZ7uRMIZgQa9RMHal5wm28t4phCvXWg54Cc4o1iK2FAObgOknGE+e0zLHTKwpssdE3V5l
 ZfW6pb9HlzVLicxLbLpf2+rAi7aMyGVVG/4hI+nXIrXw7KeaujFNwIipd5a6KI2NxBs8iZB2VZM
 6O0EJDt3dySiJhGD/6pLErdA2whjgSXNKfJ6AjlTFqy1wZqsbeYRWVsJ3tBcF6bvx//wrYbR+53
 cKhjflTQmuQM7R7KwMA==
X-Proofpoint-ORIG-GUID: XVloLwgo7H8N_XuoumUVM6DXP_6enBLe
X-Proofpoint-GUID: XVloLwgo7H8N_XuoumUVM6DXP_6enBLe
X-Authority-Analysis: v=2.4 cv=W/AIkxWk c=1 sm=1 tr=0 ts=6a0528b3 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=VFU5Akf9p8PI5X4w4VMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605050000 definitions=main-2605140015
X-Rspamd-Queue-Id: 2FD5253CD12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247085-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,synopsys.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_MIXED(0.00)[];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gTW9uLCBNYXkgMTEsIDIwMjYsIFJhZGhleSBTaHlhbSBQYW5kZXkgd3JvdGU6DQo+IEZpeCBl
cnJvciBoYW5kbGluZyBhbmQgcmVzb3VyY2UgY2xlYW51cCBpLmUgcmVtb3ZlIGludmFsaWQNCj4g
cGh5X2V4aXQoKSBhZnRlciBmYWlsZWQgcGh5X2luaXQoKSwgcm91dGUgZmFpbHVyZXMgdGhyb3Vn
aA0KPiBwcm9wZXIgY2xlYW51cCBwYXRocyBhbmQgcmV0dXJuIDAgZXhwbGljaXRseSBvbiBzdWNj
ZXNzLg0KPiANCj4gRml4ZXM6IDg0NzcwZjAyOGZhYiAoInVzYjogZHdjMzogQWRkIGRyaXZlciBm
b3IgWGlsaW54IHBsYXRmb3JtcyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNp
Z25lZC1vZmYtYnk6IFJhZGhleSBTaHlhbSBQYW5kZXkgPHJhZGhleS5zaHlhbS5wYW5kZXlAYW1k
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMgfCAyNyArKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2R3YzMteGlsaW54LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMNCj4gaW5kZXgg
OTQ0NThiM2RhMWEwLi5iODMyNTA1ZTFiMDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvZHdjMy14aWxpbnguYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMteGlsaW54LmMN
Cj4gQEAgLTE3NiwxNSArMTc2LDEzIEBAIHN0YXRpYyBpbnQgZHdjM194bG54X2luaXRfenlucW1w
KHN0cnVjdCBkd2MzX3hsbnggKnByaXZfZGF0YSkNCj4gIAl9DQo+ICANCj4gIAlyZXQgPSBwaHlf
aW5pdChwcml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gLQlpZiAocmV0IDwgMCkgew0KPiAtCQlwaHlf
ZXhpdChwcml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gIAkJZ290byBl
cnI7DQo+IC0JfQ0KPiAgDQo+ICAJcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChhcGJyc3Qp
Ow0KPiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlbGVh
c2UgQVBCIHJlc2V0XG4iKTsNCj4gLQkJZ290byBlcnI7DQo+ICsJCWdvdG8gZXJyX3BoeV9leGl0
Ow0KPiAgCX0NCj4gIA0KPiAgCWlmIChwcml2X2RhdGEtPnVzYjNfcGh5KSB7DQo+IEBAIC0yMDAs
MjYgKzE5OCwyNCBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3QgZHdj
M194bG54ICpwcml2X2RhdGEpDQo+ICAJcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChjcnN0
KTsNCj4gIAlpZiAocmV0IDwgMCkgew0KPiAgCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byByZWxl
YXNlIGNvcmUgcmVzZXRcbiIpOw0KPiAtCQlnb3RvIGVycjsNCj4gKwkJZ290byBlcnJfcGh5X2V4
aXQ7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0ID0gcmVzZXRfY29udHJvbF9kZWFzc2VydChoaWJyc3Qp
Ow0KPiAgCWlmIChyZXQgPCAwKSB7DQo+ICAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlbGVh
c2UgaGliZXJuYXRpb24gcmVzZXRcbiIpOw0KPiAtCQlnb3RvIGVycjsNCj4gKwkJZ290byBlcnJf
cGh5X2V4aXQ7DQo+ICAJfQ0KPiAgDQo+ICAJcmV0ID0gcGh5X3Bvd2VyX29uKHByaXZfZGF0YS0+
dXNiM19waHkpOw0KPiAtCWlmIChyZXQgPCAwKSB7DQo+IC0JCXBoeV9leGl0KHByaXZfZGF0YS0+
dXNiM19waHkpOw0KPiAtCQlnb3RvIGVycjsNCj4gLQl9DQo+ICsJaWYgKHJldCA8IDApDQo+ICsJ
CWdvdG8gZXJyX3BoeV9leGl0Ow0KPiAgDQo+ICAJLyogdWxwaSByZXNldCB2aWEgZ3Bpby1tb2Rl
cGluIG9yIGdwaW8tZnJhbWV3b3JrIGRyaXZlciAqLw0KPiAgCXJlc2V0X2dwaW8gPSBkZXZtX2dw
aW9kX2dldF9vcHRpb25hbChkZXYsICJyZXNldCIsIEdQSU9EX09VVF9ISUdIKTsNCj4gIAlpZiAo
SVNfRVJSKHJlc2V0X2dwaW8pKSB7DQo+IC0JCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRS
X0VSUihyZXNldF9ncGlvKSwNCj4gLQkJCQkgICAgICJGYWlsZWQgdG8gcmVxdWVzdCByZXNldCBH
UElPXG4iKTsNCj4gKwkJcmV0ID0gUFRSX0VSUihyZXNldF9ncGlvKTsNCj4gKwkJZ290byBlcnJf
cGh5X3Bvd2VyX29mZjsNCj4gIAl9DQo+ICANCj4gIAlpZiAocmVzZXRfZ3Bpbykgew0KPiBAQCAt
MjI5LDYgKzIyNSwxMyBAQCBzdGF0aWMgaW50IGR3YzNfeGxueF9pbml0X3p5bnFtcChzdHJ1Y3Qg
ZHdjM194bG54ICpwcml2X2RhdGEpDQo+ICAJfQ0KPiAgDQo+ICAJZHdjM194bG54X3NldF9jb2hl
cmVuY3kocHJpdl9kYXRhLCBYTE5YX1VTQl9UUkFGRklDX1JPVVRFX0NPTkZJRyk7DQo+ICsNCj4g
KwlyZXR1cm4gMDsNCj4gKw0KPiArZXJyX3BoeV9wb3dlcl9vZmY6DQo+ICsJcGh5X3Bvd2VyX29m
Zihwcml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gK2Vycl9waHlfZXhpdDoNCj4gKwlwaHlfZXhpdChw
cml2X2RhdGEtPnVzYjNfcGh5KTsNCj4gIGVycjoNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAt
LSANCj4gMi40NC40DQo+IA0KDQpUaGlzIGZpeCBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaCBm
cm9tIHRoaXMgY2xlYW51cCBzZXJpZXMuDQoNClRoYW5rcywNClRoaW5o

