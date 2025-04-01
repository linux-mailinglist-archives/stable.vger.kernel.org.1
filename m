Return-Path: <stable+bounces-127368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7120A7855A
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 01:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9AA3AFAAF
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DB321B905;
	Tue,  1 Apr 2025 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lQu14pEs";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N1n2LWDR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ju61w771"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023D21859F;
	Tue,  1 Apr 2025 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743551450; cv=fail; b=fAFxCrRKUpnDGGPUHFcegQG6sDSAc/4MtA8GkVaCxxGJK5hc+lOTHgBuk8aBSeZ8uNWDJYUhjenBdpyQWO9JJBjNPOlIo5Jcse9OF49L5i83ekFh34e8IL5efAYOF+Kfv5G1ORCTN4KQkUBG7ZMriz1kVjJAJ7zIx5d5x0eKZK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743551450; c=relaxed/simple;
	bh=jN4zYV0aaiaoKKOEIFOA5tyQRFtdPnT2lfSbdlpvQ60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uk1DhuwQFDD1aOIGdMGSLIj6XXNxhgE3nA5enEv1S7hsM5J3BBwCLJ55akW8IBAoTrVDMjyXNdWCSG3iFhRrAMQtyw+MybWdXIeLHQO1/45usfAC80nj31EqQBaOa0pBoR7vKTkbIhUE8hHxUdToBKbXzvtBYsS1m4tX6GGaev8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lQu14pEs; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=N1n2LWDR; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ju61w771 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531IlSu8020731;
	Tue, 1 Apr 2025 16:36:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=jN4zYV0aaiaoKKOEIFOA5tyQRFtdPnT2lfSbdlpvQ60=; b=
	lQu14pEsqX5NVF50nM7A6J8pgNGncv5w1VmDUyiraElurbXWvo9sYAA0D4/l0zn8
	hyBqyjJcnuwpsdUQnTYwal/Xtx8UsAClt0II0KMFngJf/HHxpwZuHCBz0PsSqopI
	Lqp68ptTj2MIkvy/04gqHI7qUAh6J1jCxkj1SqQlvsBVIWF8xM84DLOQceHlq0j1
	zKZ10jYbyuVzZ9N4l1zoPFqi7Tp7OF01TjuxOEtoL4RcJw1PUvZr62J7O+Fp780Q
	lypWdqfhoEAiubCbRxFcWeZpsWkrqqFQaJYsTJrLYjQfUIZCMFgZs9dwyxi15lAb
	fHhd0o9KWR673qEGWyXS9w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 45pfgfqt5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1743550595; bh=jN4zYV0aaiaoKKOEIFOA5tyQRFtdPnT2lfSbdlpvQ60=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N1n2LWDRHC2fICeN9lFnBgy5SYFuE9ie+EMtmp8xwNFEeozvq3NRsCfcm6nyYnRgu
	 tGN7lsX++sy/ubP25JYe3tune/6SBN5KcslRHVwdjIAKqzUh/j5fb8/sP3QM9w1DZD
	 i702ZSQuQlJSXyOZgv3TqutP84jRksXfaa3yqM1lHUtMy8cwcBjaieSM4lBf2M6IBm
	 JcM9Htpag+gyURBwOFwMRGMU1sKqBLFarB5uc+6zvW+yQBFr0P/52fs3hwS2YY4uEs
	 1+vFLS1kHGuNKDDXAuIhCGxvUE4JB39j/PjVbWqADRiQL11gFjdYd0st0jVVlWPbQX
	 ke+nmdUgClxug==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AFDE940354;
	Tue,  1 Apr 2025 23:36:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C4D16A006E;
	Tue,  1 Apr 2025 23:36:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ju61w771;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 86EE840127;
	Tue,  1 Apr 2025 23:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqssiavkyVpSF8MWQ44kmQpnJLZYy58YzCrqXgqSY6aJlVIUkrmJTR5I+u58HIBorAEQ9ACGt3ejrUIxGh/JCmPGgnhBFyj1a7KQpTkvOLq45lUJ8wkyvxAx4msAo4RCbhbwdrg2HcWjaQ0bR//fAraEQua9+NOoEvGqbE7vISELRX00VzC1HJnlKMrcG2dkGisqk4sUJubeDhhCHZmHX6ACFp2qK+0Esp/duSdTMenOGBhEcTEfqDvmO7gJz77fhfGimVNvLZT7JnSsVI6mu0GFDznBJqedm5/uPQHqDmGhS7GJSg9mz6aHo2vZup//S+luPoMIFErzECIA6Jc1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jN4zYV0aaiaoKKOEIFOA5tyQRFtdPnT2lfSbdlpvQ60=;
 b=NKllUdgvfTk1IDVUni0AuOx8/0GKnHSI8NhU+hi7oIMFtawgaXzcr22XVenbmnIJXA0Zoj1B9HObMYWThbDDxDLoDC+U7DotoKVXsWIi6Yqi46o6QE0YnbdJ2DnuPjBIWWCHXVUWK1Shti7JlgIbTLHObhh9bC4B5SIktsBzPH/ynUmy5sr9oTXoaflDKctvS0NSWOUEshad00xGEAQZ7Rdks3+efVLOufhL7h4x67kQu0Rivbcu3YHhT7hLxvIWO0PLS6TIxZ2Mw6eyV8X1RPg1+faU/DbpIUNfgWJWFMraiStV5NolXKkKW2DpRGQRdERBk8/iN7CoYQfXCvs9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jN4zYV0aaiaoKKOEIFOA5tyQRFtdPnT2lfSbdlpvQ60=;
 b=ju61w7713nhN+KuOccrAaPoxK4531yW67WXcGjPjKwChf5vEqMS5TFlRfYJOWw5FX3a6bD41JSNrCzmR31Vb87Ct622Ypuh428g7x+IrHWKFvoh4CJVXzMOoC7qnIjxE17NOvJJZeyJRD1wvT52y1AzCvjGxfAzat4SKwUicq+U=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 23:36:29 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 23:36:29 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frode Isaksen <fisaksen@baylibre.com>,
        Krishna Kurapati
	<krishna.kurapati@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Frode Isaksen <frode@meta.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Topic: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Index: AQHbn88kqDW/B37ovUqwebLGGZUk+LOOUlcAgABri4CAAAT9AIAAu0aA
Date: Tue, 1 Apr 2025 23:36:28 +0000
Message-ID: <20250401233625.6jtsauyqkzqej3uj@synopsys.com>
References: <20250328104930.2179123-1-fisaksen@baylibre.com>
 <0767d38d-179a-4c5e-9dfe-fef847d1354d@oss.qualcomm.com>
 <d21c87f4-0e26-41e1-a114-7fb982d0fd34@baylibre.com>
 <a1ccb48d-8c32-42bf-885f-22f3b1ca147b@oss.qualcomm.com>
In-Reply-To: <a1ccb48d-8c32-42bf-885f-22f3b1ca147b@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB7370:EE_
x-ms-office365-filtering-correlation-id: e43b9bb2-a644-4670-9b2a-08dd717606c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UXFjZWFVZnNUcDNJSWlkRFRsNExML09QRW5Ya3BLOXBMeTVwZXlaRUJHVzFF?=
 =?utf-8?B?M0ZicDAxLzZ6eDNxc05JYTdvWVNqb3NrT2haV2tub1hIUHBJKzZobXpUeTI3?=
 =?utf-8?B?U0NNT2pJMzliUXpNV1IrY0VGY1lIektRT21zUmIvMjN5elJLdTZtc01xWFd0?=
 =?utf-8?B?bEkwQWwzTU9Ob3g2dTdhNEhNTC80TmQ2QjkydXBqa0hxWTIxdWdQYVhMb3dh?=
 =?utf-8?B?Qjh1Wjc5L2ZoREpQNTV3Z1pQM1RiQnpXbzczMmxTeVU3YTcxWXNNMXp0Sk1r?=
 =?utf-8?B?bk9uTFdRcE94enc1a1QxMUxvSmV0a1VYL1lqcTA1ejZSRmpRMHBWQms2TTZR?=
 =?utf-8?B?L0NZc3lSNVVwMmpTbm13NTJKSzlranZnM0pkcENyQ3AyZ2FuSlJpMTNUWFBX?=
 =?utf-8?B?bjltYmJKR2NDeXArRGJTSmNCUXhHTmYzU3dJUTM5VTVEYVd4Tys5RnRJVEpk?=
 =?utf-8?B?YXdkTGc4TXdHTnlNSWRTK1hENHVnOHFCUk9RSW9MaE1LanNORnNpangzMis4?=
 =?utf-8?B?WWFyVGhNTnNBc3I2SlE1ZkgxWmFqMmpTZDBKMFFNQkw0Z0JxSU54Z1lUWVA3?=
 =?utf-8?B?YUZyclhadTF0Z2I5ZmoyWFhBSVZEMUxNL0RyK2tiVTR2SHRhQktDemwxM281?=
 =?utf-8?B?MFpsbitSWC9ZWHQvKzE3ZGg0M05Hc3ZlTndSWTNFSUZkKzdZemNyb0s0alpK?=
 =?utf-8?B?eG1jNHZHT2EvT1p3WklERGtmTGpybVZBa3VtLy9FVHRYa245NEhpMWtiNk1k?=
 =?utf-8?B?TDZNN2hnWldEbXhldzhhNFJ6M0RaNDFUL2JTVjJBSjk1VElzUUh1V2tPL3gx?=
 =?utf-8?B?cG5BZWJqdjNZa2xYYXFUV0NFUEp2N2kxdXF1ZG5ySVZqSi9FUWFkY3BEZWtr?=
 =?utf-8?B?YTJXUXFVZ3FpTmw2eUJUYjFERjdSR201VFB5VUJHbEVCNmhrMXZEeXEzb1hw?=
 =?utf-8?B?UklpaXg5M0lKdHpwMGdTQnBLOUw1UVR6bUxGSm9SVGsvVjdpVGxTRWxnTVJS?=
 =?utf-8?B?TUJYNFFLSnBSMTN1SXo4R2FMSU1aOXhhRFdudkF3Um5tVUJ4MkFYcFR6QXg1?=
 =?utf-8?B?UHJISmthOElXMkR6a1lnRXRnK2w3WVdhbmJ0QkdsOVdEWUQ3ZUJZTkU4RDVD?=
 =?utf-8?B?S1JJdlVtMzJ1YklQazJoZTl3Q2tyWUhKQVA5TG15b3lTNThqQnQ3K3F3Vjky?=
 =?utf-8?B?ekh1QWI0TTYvdXlQSHJSUXdzL295bkp4c0t3ODRIb3ZQZE8vNkdmemdpd1Zz?=
 =?utf-8?B?LzRVR0dFZ2lJRldLeVFQVW5zNHFzTU5WZk1tcmJYYkhZenIxQzNCL3B4OHcv?=
 =?utf-8?B?enM5S3VoWk1wTUUvN0JzL0xja28yUkNwKzFURDhZdkxvNHAzRGpwRFhpWEpG?=
 =?utf-8?B?Tk14ay9zQUJGWlJrWjZZOEp6VlRqVTU5djZoalJ5dStaekF6T21taFRHQklz?=
 =?utf-8?B?L1EvcFc1VFU3Q0xkTUFoVU1KamxpRGUrelRUTXVCWmcwRWJxaU9HK1lnZkFo?=
 =?utf-8?B?dE9xd2lHWHFiRlpJTFR4TkNSZ0tMOU9CUVdxYWJ4dU5sd3R0cENpN1J4bTR1?=
 =?utf-8?B?THVuOEl1T1g5T1gxdmZ3a3NObFo2VWh6UmxZTnhWdjJuOWN0T244enV6S1hm?=
 =?utf-8?B?eHlhNXBZc1djRFh4QTB4LzBZNUp4L0NOVStsK292WGRxZUF6aVRXSHZmanpS?=
 =?utf-8?B?WDZCTzJPeUhpeS8xM2dQeUh6RjhmV21TMmZkN21UbFJwY0lvd2NKUE9CZDZj?=
 =?utf-8?B?RkJzUTV0R1RIUjBjb3BOOWYzcHJTNjZjRmNLVUh2b0U0c2FCazZvSWhtZlM2?=
 =?utf-8?B?RFdQTkc4bE1qeVRrNG1SdnBSRHNqZXIwV3dWTFByQnJyL2NnZ0tnVjhDd3dY?=
 =?utf-8?B?dWFWcGJmcHdyMVRONXRUMUNuSXRxTHpjRHVra0w5Mi9NZTNUUmErK2JjQyt3?=
 =?utf-8?Q?6biou4AdBYUKyOqJSkktHd7ROmxiX41r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TklIRHUxYWVhTXBiclZ4MWR1eEViVEtINU9uZ09HWkV2WUQ4c3BYL1JZMWpz?=
 =?utf-8?B?d05QdEhaMVk4eGgxbnFIb0hqMW1WNURiRDkvTjFoSThpcmkzS0EyMnMrZVhW?=
 =?utf-8?B?MzFhb2dFOTdRV2t6WGh3UUNpY1gxVC9YdWlKTXRkK3RGcUxheHl2MHVoTU9Q?=
 =?utf-8?B?TzNrRFp5ZXFPUEFDVVp2SzEvUEpKYzI0ZlAxWVNoYXFBZTBhR0themtXQjlz?=
 =?utf-8?B?bG0rTlJ1US9Sb2x2ZC9OUTZHMjZxUUVlSGg2dWhnMEFNUFpiL1lNWTRlaGZL?=
 =?utf-8?B?S3lDbFNROHdMcnlwTmNOYnE2Y296UnFLOTRCZFFhR3RSa000TEhhWWRrZnJK?=
 =?utf-8?B?VzVCeFJnMjJBa0JVQWo0bVhWU3ErODllb3ozVDQ4N0d4UzRja05kTEV6Y1pY?=
 =?utf-8?B?ZytRSDFhSGJuR0lPdnc5eHVUVWhaTllGd0dJQ3ZaSmovT3FMcFlteWNMSld3?=
 =?utf-8?B?K3RCMW93cmZ1anArb3dvWFo1anFCaGxsSk96SEM0K2d3cThXT2JIN1NKaXZ0?=
 =?utf-8?B?blpqM2c1YWNrOEc0TkxyeFF1TW1ZKzZOQVU5ZC9OejBMMVRmOWFDS2VnUHk4?=
 =?utf-8?B?aXZQeW1vOHJuSmwvZG5qeXNXUkJJL2VVWnQ1WjJURlA1ckZXQmkwbC9weVFv?=
 =?utf-8?B?ZUlCdnJ0TTZ0eEpqUFVKV3FIckozOFJ0QVdBcGVOTUlKcmN3MjhyeTdWS3Ba?=
 =?utf-8?B?NGxIVW5rT0FjS0xzQWFzazBMRVBBaDk4MGtVYmhvNTBMMHQwTVM5NXJvZFBl?=
 =?utf-8?B?aFBlTDgzRTlwL05iV3lscGJKWmZoM0loWmNmYWQwVEYyOGRMQlNvamN2bitT?=
 =?utf-8?B?bUF2WFlnblpCMEZwa3ZPQ3RuM3pSUXA1Ulh5MjhrazlHM1BpcmNPWWpPcUU0?=
 =?utf-8?B?SHhrWllPWGVtTWcyZlFPeDZGclV5V0xWWklsVU9WS3VyeVBWbURoL05XcUpj?=
 =?utf-8?B?OGRqR09hWXJoSGFPdVkycWhqeFpkdTJCR2plR0syclpFLzExaFBBa2Z4cHAy?=
 =?utf-8?B?RHRqZ3BZb2d2ZXFJenMyVGYzZW1NaHh2bHhndUtGUkl4VzJ6N2dRM2xuZENT?=
 =?utf-8?B?VTJua1FKeTFPbTlpSGJPVTVpZ3ZHVzI0aDFMek90dmtqemdFZ2xoL1NMK3NI?=
 =?utf-8?B?azhEK2V0UGt1NW5jY0QyNHpSWDU2dWpjVjB5Y1pISk9lZkZBbk9oQmVzMGFU?=
 =?utf-8?B?eG9nZGttSTlobkpaK0JJYVZlUjNCWHpqSllHMGlkS05VMngyUUw2NWt0SDN2?=
 =?utf-8?B?VU1SL0NCMTVSeGJkanpjS3NzaEI2eGhvQkxJbWl1Qm1kNzY2emhyY3g3OHpU?=
 =?utf-8?B?NEJEUFlxZi9iWG5yRnprT0l2dEpyaE5PR0ZoM2EwdUVycG11SDV3ZzVYOW4y?=
 =?utf-8?B?MHRpb3JCV29KMmtIS0FjaWhpRnJUL0t4VVgzWWIvci9Lc0w4czJhU2FUL25q?=
 =?utf-8?B?UkdJMjNWN2Z1bEg2YmhHcXJ1NFFQa2J3QkRLMHJtTEthU2NHMjFEZTI2d1Jk?=
 =?utf-8?B?MlR1dS9XN2hEMDJWUUM0VmVncm1VeTlwbVBndFRPMmVaVEEyWmo3M1BuRitt?=
 =?utf-8?B?bXJFRWFaRXliVWFkNEwzb1luTVZCUTBLSVg1V2UrdW1tejJEMTNkYTRYZDA4?=
 =?utf-8?B?L0J5WVVsMllnWkxCaEo2UUxMQlJZNCtwREJITlBrSHMrSXcrN21JbFRwUUNT?=
 =?utf-8?B?cmZzTG5UNVlwUG51cWlWNGE3M0hEa3J6c1VKSUNFL05IMS9rVjV1ais0V3Jo?=
 =?utf-8?B?bUhmSzlXVEFSajFXMG9sSkhUQUI4M2t0L1lxb09FZUhBeW5MRTRPMjh1U2xH?=
 =?utf-8?B?aWxWQklDT1Z5bHRXdEZCVkorbER3YTBKOTRXdFRscURxV0NPbll5VTNONDR1?=
 =?utf-8?B?RnE4VWg2TUprY3FvNUZCeDBwQThqWm9Ua0Z1TW44TjJwZmZ6QW5DV2lPalhJ?=
 =?utf-8?B?VGFOT2M4REFvRURnV1JNVTE1eElQSndWdDVIckhTOEhIVjRCL3NGZVFOWHJH?=
 =?utf-8?B?ZU5acDNqN3psK1owZFRMSnI1N01CRFVyOUNia2pTSnhXTFoyVmJHc3BlMS8v?=
 =?utf-8?B?L1l1dHRKWHpnUGpPZVZMWFhubU9Tb3lLNzV0TjNyOG9xK0E3dGdnUWFEeCtj?=
 =?utf-8?Q?PnWKCWrPUcoo2gMX7/V6Dezb4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38CA10406C1E374EA70775463F203E7D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jYSmwkIW+97nmjhdoopxcp2B2mC66cG7XeA978/+5rD2NEXtVHLLgRyv4FOQ+G4rORKEo0xIqTFzEq+48DyjmV0qNSgmJ5wAcfiiUsCQRbB2UYm1NfU7K/x9/6FP24EZtoN/C+M2gUE985z+FP5gX5t42qFu+nISkaQSjcoEjH0RnPTYo89FOwvbfcN7hYn4DABC1n2xEOvxxElXg4ymJuuaxgULtyBVFJ233kclKtFPLDuBE4tpj7hS9UJSmQjmvgnqqa2R1Hl/NbMGOX98JpBOsqmeWEAe6E7ih7+CmXlV9S8gqQbOim2R8Syse4BMm/LF9w0pRkGdnQTggepBWsM7sqPV/dKNxUTj2rBWnWIp8VV8T7dZeUWIsChN37hH/met7CadbmYzA0WdWvtGphNdJcNLnXfQUazi1S94Nx1K/LBMcDoTp0w4n3P3ogFybGkSCYrJoeV5DY3Zk/sG3+zpbutJ6BX8ogvyT/5xDRUpUd3YRS8rd8Whk8q0uzXQvCtwaLyznsDjPMV47G9ApIYZ1lPuqKV5lGeQyB1FEQ1PRZQ+5jLL/x2TOYiIOmOyFt1Ygd4o8MIg402FMDiqICunmCcp8D9fdq+9jMTWXqbEWFuM02pl1nrgKa0UkSAWbsDVkcx0YRtnCKWvXratYQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43b9bb2-a644-4670-9b2a-08dd717606c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 23:36:28.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xRKM1AUbNm05bxjklD/YTSUxhSNtz9It6rJl9bZBPMHDBHGHhWCtSCyAnpHFLPOXAoU2VuiDfD/1zeoYit9gig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
X-Proofpoint-GUID: EaZl7St7PqjnWJ053JA08ffeh6jqOJmo
X-Authority-Analysis: v=2.4 cv=Q7/S452a c=1 sm=1 tr=0 ts=67ec7884 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=I4O6-A5A453dnQ7Iw6YA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: EaZl7St7PqjnWJ053JA08ffeh6jqOJmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_10,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 mlxscore=0 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010146

SGkgRnJvZGUsDQoNCk9uIFR1ZSwgQXByIDAxLCAyMDI1LCBLcmlzaG5hIEt1cmFwYXRpIHdyb3Rl
Og0KPiANCj4gDQo+IE9uIDQvMS8yMDI1IDU6MzggUE0sIEZyb2RlIElzYWtzZW4gd3JvdGU6DQo+
ID4gT24gNC8xLzI1IDc6NDMgQU0sIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+ID4gPiANCj4g
PiA+IA0KPiA+ID4gT24gMy8yOC8yMDI1IDQ6MTQgUE0sIEZyb2RlIElzYWtzZW4gd3JvdGU6DQo+
ID4gPiA+IEZyb206IEZyb2RlIElzYWtzZW4gPGZyb2RlQG1ldGEuY29tPg0KPiA+ID4gPiANCj4g
PiA+ID4gVGhlIGV2ZW50IGNvdW50IGlzIHJlYWQgZnJvbSByZWdpc3RlciBEV0MzX0dFVk5UQ09V
TlQuDQo+ID4gPiA+IFRoZXJlIGlzIGEgY2hlY2sgZm9yIHRoZSBjb3VudCBiZWluZyB6ZXJvLCBi
dXQgbm90IGZvciBleGNlZWRpbmcgdGhlDQo+ID4gPiA+IGV2ZW50IGJ1ZmZlciBsZW5ndGguDQo+
ID4gPiA+IENoZWNrIHRoYXQgZXZlbnQgY291bnQgZG9lcyBub3QgZXhjZWVkIGV2ZW50IGJ1ZmZl
ciBsZW5ndGgsDQo+ID4gPiA+IGF2b2lkaW5nIGFuIG91dC1vZi1ib3VuZHMgYWNjZXNzIHdoZW4g
bWVtY3B5J2luZyB0aGUgZXZlbnQuDQo+ID4gPiA+IENyYXNoIGxvZzoNCj4gPiA+ID4gVW5hYmxl
IHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBhZGRyZXNzDQo+ID4g
PiA+IGZmZmZmZmMwMTI5YmUwMDANCj4gPiA+ID4gcGMgOiBfX21lbWNweSsweDExNC8weDE4MA0K
PiA+ID4gPiBsciA6IGR3YzNfY2hlY2tfZXZlbnRfYnVmKzB4ZWMvMHgzNDgNCj4gPiA+ID4geDMg
OiAwMDAwMDAwMDAwMDAwMDMwIHgyIDogMDAwMDAwMDAwMDAwZGZjNA0KPiA+ID4gPiB4MSA6IGZm
ZmZmZmMwMTI5YmUwMDAgeDAgOiBmZmZmZmY4N2FhZDYwMDgwDQo+ID4gPiA+IENhbGwgdHJhY2U6
DQo+ID4gPiA+IF9fbWVtY3B5KzB4MTE0LzB4MTgwDQo+ID4gPiA+IGR3YzNfaW50ZXJydXB0KzB4
MjQvMHgzNA0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRnJvZGUgSXNha3NlbiA8
ZnJvZGVAbWV0YS5jb20+DQo+ID4gPiA+IEZpeGVzOiBlYmJiMmQ1OTM5OGYgKCJ1c2I6IGR3YzM6
IGdhZGdldDogdXNlIGV2dC0+Y2FjaGUgZm9yDQo+ID4gPiA+IHByb2Nlc3NpbmcgZXZlbnRzIikN
Cj4gPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gLS0tDQo+ID4gPiA+
IHYxIC0+IHYyOiBBZGRlZCBGaXhlcyBhbmQgQ2MgdGFnLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhp
cyBidWcgd2FzIGRpc2NvdmVyZWQsIHRlc3RlZCBhbmQgZml4ZWQgKG5vIG1vcmUgY3Jhc2hlcyBz
ZWVuKQ0KPiA+ID4gPiBvbiBNZXRhIFF1ZXN0IDMgZGV2aWNlLg0KPiA+ID4gPiBBbHNvIHRlc3Rl
ZCBvbiBULkkuIEFNNjJ4IGJvYXJkLg0KPiA+ID4gPiANCj4gPiA+ID4gwqAgZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYyB8IDIgKy0NCj4gPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+
ID4gaW5kZXggNjNmZWY0YTFhNDk4Li41NDhlMTEyMTY3ZjMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiA+ID4gPiBAQCAtNDU2NCw3ICs0NTY0LDcgQEAgc3RhdGljIGlycXJldHVy
bl90DQo+ID4gPiA+IGR3YzNfY2hlY2tfZXZlbnRfYnVmKHN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZl
ciAqZXZ0KQ0KPiA+ID4gPiDCoCDCoMKgwqDCoMKgIGNvdW50ID0gZHdjM19yZWFkbChkd2MtPnJl
Z3MsIERXQzNfR0VWTlRDT1VOVCgwKSk7DQo+ID4gPiA+IMKgwqDCoMKgwqAgY291bnQgJj0gRFdD
M19HRVZOVENPVU5UX01BU0s7DQo+ID4gPiA+IC3CoMKgwqAgaWYgKCFjb3VudCkNCj4gPiA+ID4g
K8KgwqDCoCBpZiAoIWNvdW50IHx8IGNvdW50ID4gZXZ0LT5sZW5ndGgpDQo+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gSVJRX05PTkU7DQo+ID4gPiA+IMKgIMKgwqDCoMKgwqAgZXZ0
LT5jb3VudCA9IGNvdW50Ow0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEkgZGlkIHNlZSB0aGlzIGlz
c3VlIHByZXZpb3VzbHkgKFsxXSBvbiA1LjEwKSBvbiBTQVIyMTMwICh1cHN0cmVhbWVkDQo+ID4g
PiByZWNlbnRseSkuIENhbiB5b3UgaGVscCBjaGVjayBpZiB0aGUgaXNzdWUgaXMgc2FtZSBvbiB5
b3VyIGVuZCBpZg0KPiA+ID4geW91IGNhbiByZXByb2R1Y2UgaXQgZWFzaWx5LiBUaGluaCBhbHNv
IHByb3ZpZGVkIHNvbWUgZGVidWcgcG9pbnRlcnMNCj4gPiA+IHRvIGNoZWNrIHN1c3BlY3Rpbmcg
aXQgdG8gYmUgYSBIVyBpc3N1ZS4NCj4gPiANCj4gPiBTZWVtcyB0byBiZSBleGFjdGx5IHRoZSBz
YW1lIGlzc3VlLCBhbmQgeW91ciBmaXggbG9va3MgT0sgYXMgd2VsbC4gSSdtDQo+ID4gaGFwcHkg
dG8gYWJhbmRvbiBteSBwYXRjaCBhbmQgbGV0IHlvIHByb3ZpZGUgdGhlIGZpeC4NCj4gPiANCj4g
DQo+IE5BSy4gSSB0cmllZCB0byBza2lwIGNvcHlpbmcgZGF0YSBiZXlvbmQgNEsgd2hpY2ggaXMg
bm90IHRoZSByaWdodCBhcHByb2FjaC4NCj4gVGhpbmggd2FzIHRlbmRpbmcgbW9yZSB0b3dhcmRz
IHlvdXIgbGluZSBvZiBjb2RlIGNoYW5nZXMuIFNvIHlvdXIgY29kZSBsb29rcw0KPiBmaW5lLCBi
dXQgYW4gZXJyb3IgbG9nIGluZGljYXRpbmcgdGhlIHByZXNlbmNlIG9mIHRoaXMgaXNzdWUgbWln
aHQgYmUNCj4gaGVscGZ1bC4NCj4gDQo+ID4gTm90ZSB0aGF0IEkgYW0gbm90IGFibGUgdG8gcmVw
cm9kdWNlIHRoaXMgbG9jYWxseSBhbmQgaXQgaGFwcGVucyB2ZXJ5DQo+ID4gc2VsZG9tLg0KPiA+
IA0KPiANCj4gSXQgd2FzIHZlcnkgaGFyZCB0byByZXByb2R1Y2UgdGhpcyBpc3N1ZS4gT25seSB0
d28gaW5zdGFuY2VzIHJlcG9ydGVkIG9uDQo+IFNBUjIxMzAgb24gbXkgZW5kLg0KPiANCg0KSSBz
dGlsbCB3b25kZXIgd2hhdCdzIGN1cnJlbnQgYmVoYXZpb3Igb2YgdGhlIEhXIHRvIHByb3Blcmx5
IHJlc3BvbmQNCmhlcmUuIElmIHRoZSBkZXZpY2UgaXMgZGVhZCwgcmVnaXN0ZXIgcmVhZCBvZnRl
biByZXR1cm5zIGFsbCBGcywgd2hpY2gNCm1heSBiZSB0aGUgY2FzZSB5b3UncmUgc2VlaW5nIGhl
cmUuIElmIHNvLCB3ZSBzaG91bGQgcHJvcGVybHkgcHJldmVudA0KdGhlIGRyaXZlciBmcm9tIGFj
Y2Vzc2luZyB0aGUgZGV2aWNlIGFuZCBwcm9wZXJseSB0ZWFyZG93biB0aGUgZHJpdmVyLg0KDQpJ
ZiB0aGlzIGlzIGEgbW9tZW50YXJ5IGJsZWVwL2xvc3Qgb2YgcG93ZXIgaW4gdGhlIGRldmljZSwg
cGVyaGFwcyB5b3VyDQpjaGFuZ2UgaGVyZSBpcyBzdWZmaWNpZW50IGFuZCB0aGUgZHJpdmVyIGNh
biBjb250aW51ZSB0byBhY2Nlc3MgdGhlDQpkZXZpY2UuDQoNCldpdGggdGhlIGRpZmZpY3VsdHkg
b2YgcmVwcm9kdWNpbmcgdGhpcyBpc3N1ZSwgY2FuIHlvdSBjb25maXJtIHRoYXQgdGhlDQpkZXZp
Y2Ugc3RpbGwgb3BlcmF0ZXMgcHJvcGVybHkgYWZ0ZXIgdGhpcyBjaGFuZ2U/DQoNClRoYW5rcywN
ClRoaW5o

