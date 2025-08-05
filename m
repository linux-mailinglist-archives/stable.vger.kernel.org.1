Return-Path: <stable+bounces-166659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C53B1BD6B
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB00625361
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 23:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D975B245038;
	Tue,  5 Aug 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LhAj0Un4";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NXndy+Mb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uc/2IYnh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2A6244669;
	Tue,  5 Aug 2025 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437152; cv=fail; b=ZRxor2CGyiv7l7vq0ZwKdFDv4qzNwNoltHwxDsWOqlMWzRgxXt0gHi8G7Hc4Wdfvw8vqmQ43i0Au7yf+vIzUnAqeg1N1A0XvC6305Go3xljr3CneZt+paj8x/9seixi/DQi96rRMLzqsbPBu1XcXOLQueaIIRtSYQqc0eb2h9qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437152; c=relaxed/simple;
	bh=JlDr7JdG1gr0PL8HOg3qrfLZb3PPj0lSUYYgsWvJhLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AuD6YYQC+/I8P7PSPc5o/j5O16vYmEv0mR9OZJOCpueJxwswKqhR6K7I1c2o5Usi1pqIqB8utdbO3YkFtlb3HaBuXJJl5MUm1EyMQdbXy8p9vT8e6KHQk/gkq6bzwLt4v5+gC2c5Y2Dnerj1OM63VIOi/9bZQRhWVIIrEiTHufw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LhAj0Un4; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NXndy+Mb; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uc/2IYnh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IB25A015830;
	Tue, 5 Aug 2025 16:38:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=JlDr7JdG1gr0PL8HOg3qrfLZb3PPj0lSUYYgsWvJhLQ=; b=
	LhAj0Un4ohxBr/+ijHDFMR6PeT4in3N880UTPcmln9MsUex/HYEu8brCmeiMDc4h
	QfsLOvlEQ95gGy/avuZ3fWLsqwkSYVhZfbrkaAvjyzxq4iDjYkuAiCUDuuShWVr7
	LZkb4pcUcQtOtGClZt+jIZFc0ldAg+8IEeRmpYZWsC4mGjByJ1Nec7M7Puk/580f
	SGn3nAHz1MX07Ha9HDHhqzH4wGQbxxCrljGX1iMkesFL1Uvs0a8A4u4SdcAi/EnF
	io0+rkb9abfkfPubyHxmWpIL1D+cz3JmD175qp/ZL9DMumsYLyH2sNk78c2GnYx0
	pmjxpbF/FqFwgTtRFNWJCA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 48bq0w9fuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 16:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754437119; bh=JlDr7JdG1gr0PL8HOg3qrfLZb3PPj0lSUYYgsWvJhLQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=NXndy+Mby4UaslGZJXRbJy/Kz0HTgiLi4G8mnk/xhGR+KAdbIXsp/pC7BypvnVhs/
	 PBYBwSA4z6ffvqWbLHTe/ynel21i5zC/O9hyY5OnilMDH6MrcrQeN0yRoRQ7iYRG4/
	 e1YLOv6enpMW/2iB2/5GQK1409ElnZnNs34zHjQXmdxmOJ2R1xPb+QunhFx5WbVzRq
	 JINNqFXU8V2U41NwxD/aIhSfscfnikN9k2Ok3OZZMzjGagaa2Jr4f9ylgQHQ+S2r3q
	 D1JgW9/cLiItAhmWtViXJ7f9EzyqZ3tJZbuRA3TXlvxsUun2N40dqCS9Fckv4RUXFK
	 3B6/GHqNkEdtQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0A6524013B;
	Tue,  5 Aug 2025 23:38:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3292AA00A2;
	Tue,  5 Aug 2025 23:38:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=uc/2IYnh;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C7B0540919;
	Tue,  5 Aug 2025 23:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qC0aTq+SI4BrJ2jhVJK3QJa52cRybY1puI7NXB4SFiKeiNH3nTXPyJBfnonTjbmzMRAzhwx+Y8MZFoCsiPELwe2uI43KjUxXWg8/ZeT+yOQ0aWKmmZGpCiQurRt/G94LWNBGjcIyocwr75oErwrg69UJbOlB5Mjj/GWP9HKTEU7nun2cDB3PxnjYgqKXMh9U2s+MLmsl4vXv1MRB3cNXucVRR+QnQywzNG9kkd5e9dyfah2YZsf6PZh/7gYkoRkRSKQi4rKWMcSQbAjenCQKovqZZq9iRO8Ec3qak28dU7+JQBwspkoKvUdyk1eEiTnq2pwoCvXFCBFBTWToJeURJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlDr7JdG1gr0PL8HOg3qrfLZb3PPj0lSUYYgsWvJhLQ=;
 b=PWYilm56anNDNmeI7mvoqGeFzMbjg4gSoW83z5RdI++tzhMngYfMGoNMvgM0dZUIYATJBc2fN3ReICeTDf+XvHEnMhKuXE+crTMFWcdXquhu/E1kFALO6QIM3Z5IuBq/KiMq/ovrqDmyJNpIwy82OJ+RDv9SxjIbNu9wzQEsWR/TXln9rhRBjl6QScgMZzNKToPHUxJJ6L721l9SV2w3cE6//epjY3QE7Dj8KuYylv6QaF7xX7aw0vuch9EuxJrA3xRXvNiLzEtOd2dnaA1m7U89vWTqDTgQv8gkediUTpELrSIH+b9xDm5mIkB+f7H7b4MZwyeTqJtOYh6sPof/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlDr7JdG1gr0PL8HOg3qrfLZb3PPj0lSUYYgsWvJhLQ=;
 b=uc/2IYnhsCCQ6/uHzmxwVQGmLLJqU8vBo6yiY/BE2MAZZthzG7Q2ugrSO72nDcDXlKCsPGSsrKkLOJukX1/WPJt0hQ/yOtK11Dk3yEr12+3rBn4Zx4V4fGyzMNzZN/Rc7eZUmuawD7WZUPiawVkdcozdfb2XDMmzVamuWW5cCCo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB9516.namprd12.prod.outlook.com (2603:10b6:806:45b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 23:38:33 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 23:38:33 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Thread-Topic: [PATCH] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Thread-Index: AQHcBUtvKX8K+bPbv02NXD2kHFXWYLRUuYQA
Date: Tue, 5 Aug 2025 23:38:33 +0000
Message-ID: <20250805233832.5jgtryppvw2xbthq@synopsys.com>
References:
 <CGME20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e@epcas5p3.samsung.com>
 <20250804142258.1577-1-selvarasu.g@samsung.com>
In-Reply-To: <20250804142258.1577-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB9516:EE_
x-ms-office365-filtering-correlation-id: 255b070f-0a9c-470d-b724-08ddd4793108
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YnJ2bVFnOFRvcEhJaktYaUV0NUFmQU53M1prTFZqRXE5L0ZkQ0xWTU1aUHIy?=
 =?utf-8?B?RDd6d09wVjhQNDA4MmZRbkFEMHRGRFlrdnNwVStJaTZnYWw4Z0NzdDlLNDBk?=
 =?utf-8?B?ZVhQYTYxRmNrYTI1enhaa2hKYmNGZDlNZFRvU0hHY0RxZW1meEt0UHNqNy9z?=
 =?utf-8?B?WFFLRlBZUVZhL09xVTkwUHhZdFJJUEdQZ3BDSXBHRFVoNEo4M2wyeHU5Wmpy?=
 =?utf-8?B?aGJCckc4VGVOaWZQUU9Ja3pHbzI2NjZVTDcxU1lMVlVMeUxkZVNpclY0ajll?=
 =?utf-8?B?SUROMjlLZnhTZEdrbnhOU1M2ZVV1MnZwY01NVllld2ZKUWNVd3RFVFc2Z204?=
 =?utf-8?B?UkdsUjBnVWV3VWw0MERLaEZTMlpRRkpwKzhVdityNFp2K0FRQzNJbHZNNnhm?=
 =?utf-8?B?ZDl4NTErS3Fhb0JzN3hLbWVEaFNHVmU0NEZ2WVBoR0Q2Qy9rU2xvQmNpN3A5?=
 =?utf-8?B?UGdjV0s4YVhCVmFIbUhtMzV3d1RNRVhGTlFrZGNpUlR3cHBHRThUbTYyVU5Q?=
 =?utf-8?B?QkdubHVqWmFLMjdRRTVzRjc0VDNVUlpVZldjRW1pZHp6eHFkcnA1UElrcENP?=
 =?utf-8?B?bXhtNDdac3V1M0k1VUJUYS9sRXJjMzRFUkZhUzRGc3RMaDhqdUpIb1lCZW91?=
 =?utf-8?B?ZS9wc1VUWWlpaHJURDZvVStIWmk0K0xTNm82TGwzbjdONzRPRHZoT1BHSmNh?=
 =?utf-8?B?QWNkNW1MUzlGd0sxOGNyV3dhei8ySEtyWDJSUno4MFdpRkw3dVAzUDRvZmda?=
 =?utf-8?B?YWxLcmJkZXc0cXo5VlZUY0xQN1RHRU9qZG5Nb0lRMDF1QUFVT0I1cTFoMDMw?=
 =?utf-8?B?WlpYeWZ1ell5dWFtQlhkMmc5OEZGbG9IU3dLYUZuUjdKM0VoaHdhSVpqeis3?=
 =?utf-8?B?ZVUyM2Yrd3BHbkVnWjJ0OWZZejJGcnFOQ2ZVNjc4YUpoeStCVDRpdU5mdC9Q?=
 =?utf-8?B?WVc5eHNWeVBSL3UwZHczTFFMK05hMHc3Q3hKcjYzWG5DNzcrdjVnS2lXeVZJ?=
 =?utf-8?B?R1JYZUhFVzFLR1I3OTlnUVl3Qzg0cUk1bU1LcFIyRldBTXVQZ094cGpHbzJG?=
 =?utf-8?B?V1dVd2lrMVd2K0RrakdpSitDU01BRTRtL29ySUNtS2VoRzZ0b1MzWWRXd0xC?=
 =?utf-8?B?dVFULzF3RUNqWnZsM1I2OHpVZ1pFYzBhcDZnWFhpWG5CMHNtYXNOUldwczRm?=
 =?utf-8?B?M2Q3UGh0azkzeWRIVnFkYnQ5VXNaRkdPallwN3dCOUd0a1dkdS94Q0h5b2lU?=
 =?utf-8?B?M2RjRWJwUG0rc0p4K0NRcWFHak40bVhpWmV3RS90WC94SFkzQkpGNnE0bEJE?=
 =?utf-8?B?TFBheHFiWkZmeEV2UWM5UzIwZk1IV01vMGJGQ01yS0w2eG5MUFM3M3NHWE9W?=
 =?utf-8?B?ZmhHT0hSSlpFQnR2SnRQMWFuOHN5bFJKbHc1WjhpQmN1YmtnWmdXUDdIVmhw?=
 =?utf-8?B?WEwwaGhuakVmck5VYSs5ZzZiY2t4SHlkV3hPUmFOUTNqVncvVWY5SkU3dWdM?=
 =?utf-8?B?Zml5R21FRUpOMzRhL2RHd0swbnVncnExbTJZdVJFcnZLbTdSaXdNOHFxb0Mx?=
 =?utf-8?B?RUJLUC82OXRaeEV3bFFzM0k0MFhxcGRWY2NxazY4Nmg3ZUJDdVlyckQ0czRK?=
 =?utf-8?B?WWRUcnJibEZRWjJBd0J0K2lOMmQvZkk4eFVtRENReFUrQlNBNDFMcDRqMVlM?=
 =?utf-8?B?NHhzamorb0dwV3k4bXdZbGNGMEx3UGoxM1Vjdk9kVGVnM3UwM1ZUWElNZ0tD?=
 =?utf-8?B?N0x4WWhpTXJDcFRGTGNkdEdORjA3cUFPcVUxdlYzd0dFWXVlMWN1MVJ6NjhS?=
 =?utf-8?B?bVg3aEIrUnNWbTJpeWx5MkpHUXV0TFpwdW04dndSVFBoSWs1Q0xZVTJMdVMz?=
 =?utf-8?B?K2xIRzlhK0lRZFFzS041ODZ5WElvWlBVNGpMdXZNN091ZSs1NFZBQzlWRTg2?=
 =?utf-8?B?RVVTU2MwZldQYUEwMmNuR1F2eGlGeGZuSEx6elZrclBUVUdLWGdZbE5PZWxK?=
 =?utf-8?Q?1i0+WSmdWuNq7IVipnD1HYihbs32tA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V0s2QXgrR2dYSXA5c2JlTFFoRFdsOWNjQ0E5OHRFUGZPN2RCMCtUYUtKaExh?=
 =?utf-8?B?TmtYaExxWE1DT3VsMVcxaVZpZ09RZnJsVjRtUHBQOEZqalhaTVI1WjdnNW5B?=
 =?utf-8?B?R1hzWnViZ2d5WlJxMEtyN0I2ZHduenF5UnpDS3YyM3FtKzJLMmVIYVJLMlp6?=
 =?utf-8?B?Z1J6YkxoUFcxVHd4aEpNeGVJdk1nUG03ZGxZMkg5VGFKaXVLakE4bm5PT0hl?=
 =?utf-8?B?RCtpU2Y3MVpKK3ZnWGpCVG9FekVkZU8zMVpRL29mNkhYYWJLTWFUNFBOWUdY?=
 =?utf-8?B?WFJ1R1BkaThpVmRvTjdLc0JwdnJhenlYenN4L1J0NStJZUVra1VPOXoyWEFJ?=
 =?utf-8?B?d3YvWFAyMG1obFE4ZzlaN0RoZlQ5bUlCSVZKSzkrQ2tXQS9zTm5UU2tDSEJV?=
 =?utf-8?B?K21CUzBHdmVMVlFndjRSR2hmSjNyTVdCM3ZqQS96OTd5d3VxTW1pcmc2NDlr?=
 =?utf-8?B?VGU4bGpOdHZJelVUVCtrMnBEdW82NlZaM3lRNkttZmJBcm1CTG5XTnh5NFRj?=
 =?utf-8?B?MlJ3ODdOMlhramZQcXpWVTcwNFRhWnQ2SFJwNzBTYjRONXprdjRQczMzQmgr?=
 =?utf-8?B?dTVTUkRrZXoycWRpSmZYQTVGOElzS0MyYXU3NkgxdGxmZGxvNVc3aXBxTDE0?=
 =?utf-8?B?bEZVRUt5RU5FSzVRdVBESkY4OGFpSWVKTDFwQ1RRWUl1NGlRRHM0eVk4dDFK?=
 =?utf-8?B?STBKVzFPWHpEMm5EdWxYb1NveVdlM1pSY3dRQXNNVHIwWG5tbjNmN2xxYmE4?=
 =?utf-8?B?U2oydEhOVzdFUFZ3ZytHN2prbGl6RGU0S2lEd1RFZlc1OFczUjFTNXVmZ2FY?=
 =?utf-8?B?QTN6L3prOGd5RXhmUEN2VkVrbVVwb05vY0NyRnpUZ2ZRL1Q0QjFheEpUZ0Qz?=
 =?utf-8?B?MnFGT3d1S2xRUVp1VHRYaC9ES2lJeEJUNzhWSmZsYmhyNVhZQ0E2N1R6SnV1?=
 =?utf-8?B?RGlqcWZlWXhkVWZNTzZxblVFT1dtbFg3WkY5U05QSUxrSnNEdWxDUHRTaEgy?=
 =?utf-8?B?RUpVWVRRaDVGTnBvbEhOQXgrWFJmRmFmSXZuSEhhbENybVk0M29qNWVPSDRZ?=
 =?utf-8?B?ZzJnQ29ZYklLZlBIQm1xYTlvcUpVUEVRaWJvRmN1aGlDZWQ1YnFLOVFSSVEw?=
 =?utf-8?B?UkdNUmVhbjkvVUZsR0Z6OGk2T2RlTC96S2p1aGRwS3UyZmpRSzV4ays4Ry9v?=
 =?utf-8?B?R3hKOHlNVDlqbVRrcEM1RkwzVEdqTjhhNWF0ZnZRd0pndzdTZU9jTk5Da1Ry?=
 =?utf-8?B?WGxDckY5MWlKZlZZdEF4YUUxSDdtOG5hV1RLaUhHRkJ6MzNzRGdRcElCNWNx?=
 =?utf-8?B?ckROQnB6b0N2cTJYSHJ6bCt3VE5QbmZ6R0tLUW5wenRsSGI2cXQ4TE0zekxB?=
 =?utf-8?B?c3lYZGlLWTBjYjNwcDZzTUFGV0tKTXpMZlZOQVRIRlJtK3NXRlYxcHRiR3l4?=
 =?utf-8?B?ZVNUcG4rZmhyZkVXKzdvMVZpbWpxK0d4L3dMWkVGRWxtQUsxYVl3WVRLR0Vn?=
 =?utf-8?B?VlVsY20rNVZGNmVQMTcydEgxY3RIOXFoSU1ueEZNMGNRZXJmd3pHelRWbTRX?=
 =?utf-8?B?cU9CQVd4ZFV6TkFrMmhMc3dZQU5NbW1mKzltNDRXMFErY3pXZFJtYTg5TE1B?=
 =?utf-8?B?a0NZTER4c2ZsRE9zTHJzQUszK2YySDd1aWtDOVQvdFhxSVNPUGFCT0hmVThP?=
 =?utf-8?B?T2ROZk9PRXEyY2tTL1Y3c0xTbHNpT3lVNE9nTmMzcE9xMnF2OVAxTWs3MXZu?=
 =?utf-8?B?OHZLK2pHdC82M1RrSEIwVHExUk1Zekw2VEJuTXZ3VWQyUE5wRHQyZzZNU2ts?=
 =?utf-8?B?ZUorMUlMZzRqUy9HWmMzU20zZU5RbU9iNU52TlVYN0daMEtrbnVQam4rZlp5?=
 =?utf-8?B?L1ZWem1MeS9JcTRad0c2OEhQTU0zMEdIUjFDM3lDZlliZzdjQndYTGYyMmFH?=
 =?utf-8?B?VjEzbzN2SzZ2Tk1temFIWXhjOTV0MitkK0VucU9SZzA3RFRMaDVpamVpTk9l?=
 =?utf-8?B?Y1pVdEtuSHB3MC9hcnhKVW5TUFo2K09YU3ZyV2tOaXBEYVFzZUFuT2EyK2J0?=
 =?utf-8?B?d3lleFNyK1ZHSFFTdEpvRFFCT3pzL2tiRFlycjBRVy9CM2s2OHhnUVNUaFRU?=
 =?utf-8?Q?1nvCyaqr/r22K/Nf4pLWNVOMw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C90E9F5847AB304CADCD85275FA54A80@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l4TiZAIFFu1OAslU8IDHjift9MqrsFXKorOKZIKQZ8oTVJ2vX/seXrLPa0uVFT2ddo6M8yv80xyfBKa2lGSgpLizup5EIwlKyoGo2w/OqW7EmLHZDO33VD9txjkShhn9ouXuOYHbvZRldyW1FHY3QXLrHwNi9U3Jcw7usqF116pt9ivFt1veo+wKY0SyTt6UQQc7vnq/CJCYkGePM98jWfER6gYL+dFnmzdKOIpqhccYVUq34z1eJIyIpOl2qUzIJRJGSu3ym4VSJglmOuGldIk5vw1lJEpDbr2rJXQiShnClAazGWyODRfB0+g4+60eAXiJthzsAJs2FH5lvebYWOjNUpT952cIpg6oLQrYw1NiEa+/7v1nX4LMpQQQAUKccCDNBLeNWDxTuvfb3mhUZwZL3kmIXFZ8RvBB3E88ao0Py/1OZXArGrLVCI+J7B9JNxuA16PAXBmBAu8WlsIOomXqMCQcIY7VrE5+2LMl9MxbC0u6QQMkbpvpoC1zTEWxJNE8t1X42SNofbq1QhBaqCqM9JRytjwjfdmAE9tYGfcMwrnl+vJSgjzYMyhYIjyn099BtbTzvvzrtvG2HIMmXT/yKduifVKVxbxTpJeN4/Fd06Do6hqPGRXldpC+L766cAz27CLTtyUFcgFgJQ3Q1w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255b070f-0a9c-470d-b724-08ddd4793108
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 23:38:33.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80yqrYmJHRUh3x+FdVGZVN3HaQXYdIZqBexJUmq+VHyY1UHhSS5z4W3JMtzIFkX+HC87PNlO8zqkUy87+KFJ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9516
X-Proofpoint-GUID: AaTJ7Op0105jpCOT7sVV5ulYQstpTARM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyOCBTYWx0ZWRfXw3N4RBA4YVWp
 kzjUpmx2splkC9yS0llQPYAvW/rOeRSkgMGBSYFCh0ZRVQYDchQvOljdS6WZrV65c4SKv3labbM
 kQOznIk/A/yjD7TX1tjRc3tPW3BWyha/MAYNrPYfE/3DK6GwRQSnZ0qBQFm/BImUtn/pjjLp2Lu
 iCgsmUP3zXgbkgdgJqZ3fY0iYjjw8SayTnaMcguuometEeYvd6iaUiaaotLjQ6SuCa+8UJ0D3vq
 Q63k3T8CIVzJxP4a6zKvjqt5vyOvaeapy10Kdy31klPklkJhncW2was+Qu1NFo1Pu4S5QaQGQAt
 6ILAxZyCv+JpYaC4NdhjNkcd3mDSMdk+FH3MDC3wVtaNbEoN0dVSOs7hXvrZo4KjIuHxest6WGj
 PEiIMHT6
X-Proofpoint-ORIG-GUID: AaTJ7Op0105jpCOT7sVV5ulYQstpTARM
X-Authority-Analysis: v=2.4 cv=HYMUTjE8 c=1 sm=1 tr=0 ts=68929600 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=JloXFaeXwdkSA3akGm8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 phishscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508050128

T24gTW9uLCBBdWcgMDQsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBGcm9tOiBB
a2FzaCBNIDxha2FzaC5tNUBzYW1zdW5nLmNvbT4NCj4gDQo+IFRoaXMgY29tbWl0IGFkZHJlc3Nl
cyBhIHJhcmVseSBvYnNlcnZlZCBlbmRwb2ludCBjb21tYW5kIHRpbWVvdXQNCj4gd2hpY2ggY2F1
c2VzIGtlcm5lbCBwYW5pYyBkdWUgdG8gd2FybiB3aGVuICdwYW5pY19vbl93YXJuJyBpcyBlbmFi
bGVkDQo+IGFuZCB1bm5lY2Vzc2FyeSBjYWxsIHRyYWNlIHByaW50cyB3aGVuICdwYW5pY19vbl93
YXJuJyBpcyBkaXNhYmxlZC4NCj4gSXQgaXMgc2VlbiBkdXJpbmcgZmFzdCBzb2Z0d2FyZS1jb250
cm9sbGVkIGNvbm5lY3QvZGlzY29ubmVjdCB0ZXN0Y2FzZXMuDQo+IFRoZSBmb2xsb3dpbmcgaXMg
b25lIHN1Y2ggZW5kcG9pbnQgY29tbWFuZCB0aW1lb3V0IHRoYXQgd2Ugb2JzZXJ2ZWQ6DQo+IA0K
PiAxLiBDb25uZWN0DQo+ICAgID09PT09PT0NCj4gLT5kd2MzX3RocmVhZF9pbnRlcnJ1cHQNCj4g
IC0+ZHdjM19lcDBfaW50ZXJydXB0DQo+ICAgLT5jb25maWdmc19jb21wb3NpdGVfc2V0dXANCj4g
ICAgLT5jb21wb3NpdGVfc2V0dXANCj4gICAgIC0+dXNiX2VwX3F1ZXVlDQo+ICAgICAgLT5kd2Mz
X2dhZGdldF9lcDBfcXVldWUNCj4gICAgICAgLT5fX2R3YzNfZ2FkZ2V0X2VwMF9xdWV1ZQ0KPiAg
ICAgICAgLT5fX2R3YzNfZXAwX2RvX2NvbnRyb2xfZGF0YQ0KPiAgICAgICAgIC0+ZHdjM19zZW5k
X2dhZGdldF9lcF9jbWQNCj4gDQo+IDIuIERpc2Nvbm5lY3QNCj4gICAgPT09PT09PT09PQ0KPiAt
PmR3YzNfdGhyZWFkX2ludGVycnVwdA0KPiAgLT5kd2MzX2dhZGdldF9kaXNjb25uZWN0X2ludGVy
cnVwdA0KPiAgIC0+ZHdjM19lcDBfcmVzZXRfc3RhdGUNCj4gICAgLT5kd2MzX2VwMF9lbmRfY29u
dHJvbF9kYXRhDQo+ICAgICAtPmR3YzNfc2VuZF9nYWRnZXRfZXBfY21kDQo+IA0KPiBJbiB0aGUg
aXNzdWUgc2NlbmFyaW8sIGluIEV4eW5vcyBwbGF0Zm9ybXMsIHdlIG9ic2VydmVkIHRoYXQgY29u
dHJvbA0KPiB0cmFuc2ZlcnMgZm9yIHRoZSBwcmV2aW91cyBjb25uZWN0IGhhdmUgbm90IHlldCBi
ZWVuIGNvbXBsZXRlZCBhbmQgZW5kDQo+IHRyYW5zZmVyIGNvbW1hbmQgc2VudCBhcyBhIHBhcnQg
b2YgdGhlIGRpc2Nvbm5lY3Qgc2VxdWVuY2UgYW5kDQo+IHByb2Nlc3Npbmcgb2YgVVNCX0VORFBP
SU5UX0hBTFQgZmVhdHVyZSByZXF1ZXN0IGZyb20gdGhlIGhvc3QgdGltZW91dC4NCj4gVGhpcyBt
YXliZSBhbiBleHBlY3RlZCBzY2VuYXJpbyBzaW5jZSB0aGUgY29udHJvbGxlciBpcyBwcm9jZXNz
aW5nIEVQDQo+IGNvbW1hbmRzIHNlbnQgYXMgYSBwYXJ0IG9mIHRoZSBwcmV2aW91cyBjb25uZWN0
LiBJdCBtYXliZSBiZXR0ZXIgdG8NCj4gcmVtb3ZlIFdBUk5fT04gaW4gYWxsIHBsYWNlcyB3aGVy
ZSBkZXZpY2UgZW5kcG9pbnQgY29tbWFuZHMgYXJlIHNlbnQgdG8NCj4gYXZvaWQgdW5uZWNlc3Nh
cnkga2VybmVsIHBhbmljIGR1ZSB0byB3YXJuLg0KPiANCj4gRml4ZXM6IGUxOTJjYzdiNTIzOSAo
InVzYjogZHdjMzogZ2FkZ2V0OiBtb3ZlIGNtZF9lbmR0cmFuc2ZlciB0byBleHRyYSBmdW5jdGlv
biIpDQo+IEZpeGVzOiA3MjI0NmRhNDBmMzcgKCJ1c2I6IEludHJvZHVjZSBEZXNpZ25XYXJlIFVT
QjMgRFJEIERyaXZlciIpDQo+IEZpeGVzOiBjN2ZjZGViMjYyN2MgKCJ1c2I6IGR3YzM6IGVwMDog
c2ltcGxpZnkgRVAwIHN0YXRlIG1hY2hpbmUiKQ0KPiBGaXhlczogZjBmMmIyYTJkYjg1ICgidXNi
OiBkd2MzOiBlcDA6IHB1c2ggZXAwc3RhdGUgaW50byB4ZmVybm90cmVhZHkgcHJvY2Vzc2luZyIp
DQo+IEZpeGVzOiAyZTNkYjA2NDg1NWEgKCJ1c2I6IGR3YzM6IGVwMDogZHJvcCBYZmVyTm90UmVh
ZHkoREFUQSkgc3VwcG9ydCIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQoNCkkgZG9u
J3QgdGhpbmsgdGhpcyBpcyBhIGZpeCBwYXRjaC4gWW91J3JlIGp1c3QgcmVwbGFjaW5nIFdBUk4q
IHdpdGgNCmRldl93YXJuKiB3aXRob3V0IGRvaW5nIGFueSByZWNvdmVyeS4gTGV0J3MgcmVtb3Zl
IHRoZSBGaXhlcyBhbmQgdGFibGUNCnRhZy4gQWxzbywgY2FuIHdlIHJlcGxhY2UgZGV2X3dhcm4q
IHdpdGggZGV2X2VyciogYmVjYXVzZSB0aGVzZSBhcmUNCmNyaXRpY2FsIGVycm9ycyB0aGF0IG1h
eSBwdXQgdGhlIGNvbnRyb2xsZXIgaW4gYSBiYWQgc3RhdGUuDQoNClRoYW5rcywNClRoaW5oDQoN
Cj4gU2lnbmVkLW9mZi1ieTogQWthc2ggTSA8YWthc2gubTVAc2Ftc3VuZy5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFNlbHZhcmFzdSBHYW5lc2FuIDxzZWx2YXJhc3UuZ0BzYW1zdW5nLmNvbT4NCg0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2VwMC5jDQo+IGluZGV4IDY2NmFjNDMyZjUyZC4uN2IzMTM4MzZmNjJiIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAw
LmMNCj4gQEAgLTI4OCw3ICsyODgsOSBAQCB2b2lkIGR3YzNfZXAwX291dF9zdGFydChzdHJ1Y3Qg
ZHdjMyAqZHdjKQ0KPiAgCWR3YzNfZXAwX3ByZXBhcmVfb25lX3RyYihkZXAsIGR3Yy0+ZXAwX3Ry
Yl9hZGRyLCA4LA0KPiAgCQkJRFdDM19UUkJDVExfQ09OVFJPTF9TRVRVUCwgZmFsc2UpOw0KPiAg
CXJldCA9IGR3YzNfZXAwX3N0YXJ0X3RyYW5zKGRlcCk7DQo+IC0JV0FSTl9PTihyZXQgPCAwKTsN
Cj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJZGV2X3dhcm4oZHdjLT5kZXYsICJlcDAgb3V0IHN0YXJ0
IHRyYW5zZmVyIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ICsNCj4gIAlmb3IgKGkgPSAyOyBpIDwg
RFdDM19FTkRQT0lOVFNfTlVNOyBpKyspIHsNCj4gIAkJc3RydWN0IGR3YzNfZXAgKmR3YzNfZXA7
DQo+ICANCj4gQEAgLTEwNjEsNyArMTA2Myw5IEBAIHN0YXRpYyB2b2lkIF9fZHdjM19lcDBfZG9f
Y29udHJvbF9kYXRhKHN0cnVjdCBkd2MzICpkd2MsDQo+ICAJCXJldCA9IGR3YzNfZXAwX3N0YXJ0
X3RyYW5zKGRlcCk7DQo+ICAJfQ0KPiAgDQo+IC0JV0FSTl9PTihyZXQgPCAwKTsNCj4gKwlpZiAo
cmV0IDwgMCkNCj4gKwkJZGV2X3dhcm4oZHdjLT5kZXYsICJlcDAgZGF0YSBwaGFzZSBzdGFydCB0
cmFuc2ZlciBmYWlsZWQ6ICVkXG4iLA0KPiArCQkJCXJldCk7DQo+ICB9DQo+ICANCj4gIHN0YXRp
YyBpbnQgZHdjM19lcDBfc3RhcnRfY29udHJvbF9zdGF0dXMoc3RydWN0IGR3YzNfZXAgKmRlcCkN
Cj4gQEAgLTEwNzgsNyArMTA4MiwxMiBAQCBzdGF0aWMgaW50IGR3YzNfZXAwX3N0YXJ0X2NvbnRy
b2xfc3RhdHVzKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICANCj4gIHN0YXRpYyB2b2lkIF9fZHdj
M19lcDBfZG9fY29udHJvbF9zdGF0dXMoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAg
KmRlcCkNCj4gIHsNCj4gLQlXQVJOX09OKGR3YzNfZXAwX3N0YXJ0X2NvbnRyb2xfc3RhdHVzKGRl
cCkpOw0KPiArCWludAlyZXQ7DQo+ICsNCj4gKwlyZXQgPSBkd2MzX2VwMF9zdGFydF9jb250cm9s
X3N0YXR1cyhkZXApOw0KPiArCWlmIChyZXQpDQo+ICsJCWRldl93YXJuKGR3Yy0+ZGV2LA0KPiAr
CQkJImVwMCBzdGF0dXMgcGhhc2Ugc3RhcnQgdHJhbnNmZXIgZmFpbGVkOiAlZFxuIiwgcmV0KTsN
Cj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgZHdjM19lcDBfZG9fY29udHJvbF9zdGF0dXMoc3Ry
dWN0IGR3YzMgKmR3YywNCj4gQEAgLTExMjEsNyArMTEzMCwxMCBAQCB2b2lkIGR3YzNfZXAwX2Vu
ZF9jb250cm9sX2RhdGEoc3RydWN0IGR3YzMgKmR3Yywgc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4g
IAljbWQgfD0gRFdDM19ERVBDTURfUEFSQU0oZGVwLT5yZXNvdXJjZV9pbmRleCk7DQo+ICAJbWVt
c2V0KCZwYXJhbXMsIDAsIHNpemVvZihwYXJhbXMpKTsNCj4gIAlyZXQgPSBkd2MzX3NlbmRfZ2Fk
Z2V0X2VwX2NtZChkZXAsIGNtZCwgJnBhcmFtcyk7DQo+IC0JV0FSTl9PTl9PTkNFKHJldCk7DQo+
ICsJaWYgKHJldCkNCj4gKwkJZGV2X3dhcm5fcmF0ZWxpbWl0ZWQoZHdjLT5kZXYsDQo+ICsJCQki
ZXAwIGRhdGEgcGhhc2UgZW5kIHRyYW5zZmVyIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ICsNCj4g
IAlkZXAtPnJlc291cmNlX2luZGV4ID0gMDsNCj4gIH0NCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5k
ZXggMzIxMzYxMjg4OTM1Li41MGU0ZjY2N2IyZjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAt
MTc3NCw3ICsxNzc0LDExIEBAIHN0YXRpYyBpbnQgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVy
KHN0cnVjdCBkd2MzX2VwICpkZXAsIGJvb2wgZm9yY2UsIGJvb2wgaW50DQo+ICAJCWRlcC0+Zmxh
Z3MgfD0gRFdDM19FUF9ERUxBWV9TVE9QOw0KPiAgCQlyZXR1cm4gMDsNCj4gIAl9DQo+IC0JV0FS
Tl9PTl9PTkNFKHJldCk7DQo+ICsNCj4gKwlpZiAocmV0KQ0KPiArCQlkZXZfd2Fybl9yYXRlbGlt
aXRlZChkZXAtPmR3Yy0+ZGV2LA0KPiArCQkJCSJlbmQgdHJhbnNmZXIgZmFpbGVkOiByZXQgPSAl
ZFxuIiwgcmV0KTsNCj4gKw0KPiAgCWRlcC0+cmVzb3VyY2VfaW5kZXggPSAwOw0KPiAgDQo+ICAJ
aWYgKCFpbnRlcnJ1cHQpDQo+IEBAIC00MDQxLDcgKzQwNDUsOSBAQCBzdGF0aWMgdm9pZCBkd2Mz
X2NsZWFyX3N0YWxsX2FsbF9lcChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQlkZXAtPmZsYWdzICY9
IH5EV0MzX0VQX1NUQUxMOw0KPiAgDQo+ICAJCXJldCA9IGR3YzNfc2VuZF9jbGVhcl9zdGFsbF9l
cF9jbWQoZGVwKTsNCj4gLQkJV0FSTl9PTl9PTkNFKHJldCk7DQo+ICsJCWlmIChyZXQpDQo+ICsJ
CQlkZXZfd2Fybl9yYXRlbGltaXRlZChkd2MtPmRldiwNCj4gKwkJCQkiZmFpbGVkIHRvIGNsZWFy
IFNUQUxMIG9uICVzXG4iLCBkZXAtPm5hbWUpOw0KPiAgCX0NCj4gIH0NCj4gIA0KPiAtLSANCj4g
Mi4xNy4xDQo+IA==

