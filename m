Return-Path: <stable+bounces-166810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769FFB1DF5B
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 00:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7C21894D6E
	for <lists+stable@lfdr.de>; Thu,  7 Aug 2025 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9AB2356BE;
	Thu,  7 Aug 2025 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kydt44bE";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="e9XXSqi9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sGTbXXMs"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3213FE7;
	Thu,  7 Aug 2025 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754606026; cv=fail; b=o2Qt0Izk2zz7FwZGJRkwXzVtwhGw22IhPqLjHxyvHvBoVXTk3IrYN9ElWNGS8Cj6CGlfUsJTDMIm827K7tGbftAhQz+xJrMBo4SyXCKE3PR377H0LUZJ6p0RV433nbvnl+rfZymHhU6VwzMFM0Ix0wtnK73w6g8Nd6iemlA6ne8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754606026; c=relaxed/simple;
	bh=8metBVdDZ09caWhYUYalTBZ+bBM+UzEcpv8mgWwcz6A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSQNexstKJM8LCi8OxOsKn0vzC6PE1APgjmsLmiGNbkanTyNurPZyP88mrwLKpt0GTIWJ6kTl0iKrOncmKRqmjqmnMRYiHEprMua020HFt2wPLuHs2fZbs7ibV7lFS6+O3z+HJ0uQfk/J5JJzMmt/5Nkw7aweaeSmM0/K/yDS5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kydt44bE; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=e9XXSqi9; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sGTbXXMs reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577GhwrJ002793;
	Thu, 7 Aug 2025 15:33:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=8metBVdDZ09caWhYUYalTBZ+bBM+UzEcpv8mgWwcz6A=; b=
	kydt44bE+IWkbPynsh2pT/0KnfXyAux/+jOHIxq50ol1CE51nFZxMFMnNEuSIATI
	sMZbTRpFia9eTkRrs2WxdBZHNSKT0TGpYWRyOK021wLmH/rK5mUNKW6oA+rMYHUW
	+sJT08VZWWzSyIG9lB4pE+29nYxMHNzKnROU6kGXAdkN5nt+ZSBCG5FXeJQh9cU8
	DYZdCRWbb8pS9ZtYUXRd5VMIhN6OncTd/gxGXW/BEe7cD9ETxqTANGJH7MafcUD2
	iAwnXgaNkVWSmjmrd4ChWRAUEsflFl1FdITgKAQ6uS1RlMPjtqKoFaJUb9ifM17S
	zfHFsBopIeayPFSEKOO4NA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 48bq0rnfu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1754606005; bh=8metBVdDZ09caWhYUYalTBZ+bBM+UzEcpv8mgWwcz6A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=e9XXSqi9YFa0XQRylvo1Npk6oleBqZodU3vacpmTKoaq09fw51GTeKZZHAXQR4Bri
	 X//EJRG/PagN9yhk1eHGn3CT7igdIkJ3td9SumoAOb3KbY38tFL3zAq/l+f/GLranJ
	 rP2stTPpVeCq5ZfHUL5eKgelqjn1wEA61o4liCNvUab2DlKq8pzWjsUV7UMOYP31YU
	 hSdFmUagIvG2bf6NLU7nRQt1ohyIO5Av3Ef6hUeeEdSSZN1hDDrKAs+eDMIUhTXi+x
	 dqNX1LM12MlOGeiIf4JMc1aSM9msEgp5u9cqNOWNgaCCvlv29JvsWnZf7LvIMZ8cgN
	 QGcPhVltzPD5Q==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 42A0B40360;
	Thu,  7 Aug 2025 22:33:24 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2B3A9A0089;
	Thu,  7 Aug 2025 22:33:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=sGTbXXMs;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1B21740453;
	Thu,  7 Aug 2025 22:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqITHLpb25ptGzf1Z971A4a9JKhwn+Nya+2nBDrslnZX2yOrIC+ZnyM8WNe6pxvDi5fsf4gEcJDDDu0dUHf5W3CRvEHPbql1d1JbJdLXLM1sNqQ2oG1Fr7eB88k27M6pFYYrDhSKQ57vPURIWwgQbQhFfG9SOQH1De5Jgm0B1tgqXvFD+PMPdyE5fg2x4ovWC9k6Z9fW/uKGWUNJoSOEyTug4Px6c3CCeoSx9yOs7EuwTM8+ii7ik73ovGeT6un+UnZwRUJSHpJHk85WEE5lx+sgjT3cjObfZHhnNbMKylK8DxTocJ01dwePoQI11aidFiG8qtz6vAQFGg0V/J/c1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8metBVdDZ09caWhYUYalTBZ+bBM+UzEcpv8mgWwcz6A=;
 b=sbe7JXsUpGLBqVwyRHJcrj5G23nkFtDfo4eEkT6emAgQQagyw4JcpAium5155gFHvR+r84UGnVfnl5AdYNDFs/tWaApmeKbYSDxwRhcCnUBmwVsHuf+g8snZQ49GyenImJV/TlzTYjotaxgitLk+d90lugCYYFCuKDRoWYAq2EJWJWZf1XmPIdy7x71Sswvd2+4lWVsZy2OZaLKyXmjt/fiBX64BxLOdz2fWuT6YtR4filAg+vMOstYHxLJbHmr4lon5RRj/WuOkiCr6h9KExitnMYUaFgvJPQKI1PzrmCRW+EESWI0epkQZ7KQghLj7ynfQ5Zz26hvCFE0NBRW2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8metBVdDZ09caWhYUYalTBZ+bBM+UzEcpv8mgWwcz6A=;
 b=sGTbXXMsJrPYAqLocf5JVwqLBSlqOLP43/gy4GNlGvT5y2JwUKtexum3R0rgxRA7yxpDpsLUTrmbSSotwtx91svVi4IKWN9+QHncrB5+f48CuZrz5XHcWaWXkMEZR3HGQ0XoN4SFXCy5+e0D6gnvglqnw9mOW2dEbIrCZhxPh4I=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA0PR12MB4381.namprd12.prod.outlook.com (2603:10b6:806:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Thu, 7 Aug
 2025 22:33:17 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 22:33:17 +0000
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
Subject: Re: [PATCH v2] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Thread-Topic: [PATCH v2] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Thread-Index: AQHcBz177mJnOG2J50aFXEhQbIUcn7RXyAqA
Date: Thu, 7 Aug 2025 22:33:17 +0000
Message-ID: <20250807223313.bloba4uvw4z5uia2@synopsys.com>
References:
 <CGME20250807014905epcas5p13f7d4ae515619e1e4d7a998ab2096c32@epcas5p1.samsung.com>
 <20250807014639.1596-1-selvarasu.g@samsung.com>
In-Reply-To: <20250807014639.1596-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA0PR12MB4381:EE_
x-ms-office365-filtering-correlation-id: 4634f5bc-2191-43df-2a9c-08ddd60267bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dTJuZW4ySDg5US85Q0FsRUtubUxPaHQyaU54ajlJS282c0g4S3J0ZGpKMXU5?=
 =?utf-8?B?UnI1THBXSVBNNmQrOTVXM1ErVCs3VFNRSmVNMFR3OWJqTnd4RlRJcUxmL08v?=
 =?utf-8?B?c2tGTUFSY2g1bzV0ZFJWVmpOK2NnK0VaU0orN0xSd3VuT2poSzMydDZDajJF?=
 =?utf-8?B?ZlZZeWJhdXN5MFhWSFNnRmpDYyt5R0tyUTY5eHQvbkFobTlXK2E1NW1WUnVD?=
 =?utf-8?B?WStLc2s0bFJQRFNFQTE4M0pXWjQ5TGJrQUZVU0w0bHNvK3dXdVh6V0w1bDdI?=
 =?utf-8?B?UXZWQitWOVArbmV5UlFQSUptNEpwamFMNEF1cUlwNFJzbkV3aE1nQ1d6dllH?=
 =?utf-8?B?QkErblhtN3RkaG5LOTErbXRXWW0vRVVtOTlyQVVpallySmJFL0xocW9oOXhl?=
 =?utf-8?B?cDh4cTlEWmp4a0pHc1pkY2JKVW0yeXo3dVBLOWVVeWtPRVF3elcxRVYxNndD?=
 =?utf-8?B?NitMRlQxdXFKWWFoSlJqM2pYYUQ2Ui9VaEZBaTZUR2pxc3FlS1dKOC9KR082?=
 =?utf-8?B?NVFaNldtV2ZaSjNaOWw0dVl4V250ZFp1eXExOGVLdEZ2NzllVGFDNDNHM2px?=
 =?utf-8?B?RkdaRkpFTzVIZUhjTllOd2ZjMWJFdzN3VlViUjNZMXVhK1JPSkxTUDZUUHdL?=
 =?utf-8?B?SnZXc09meHNJL3YxNUYzaUlxMFFoWEc4aFJjQWl0RUdsaWlBcVpFdENtK0tn?=
 =?utf-8?B?MW83djFhZ0wxR3dMWGdFVzQ5RGd5bDcyRnB2WWoyUDVOTnlEbVNFTUFMNmFv?=
 =?utf-8?B?c29ZUW0yaXdYZGpkSlR5K0RkVGxNVHFwTFFxTU1OWW83SFkzUFRNODY0eEJo?=
 =?utf-8?B?T1NkQVN3YkZBWW4rUUhqcU9NbmtWdDRoV0d3UEZteXZySmlOVVlHRmNmdGow?=
 =?utf-8?B?TFk3T1Btd2RjZkxWS0VNcm1PbmNoeWhGNEY2bS8zQlRHcXlLSG1hUm9EY1JF?=
 =?utf-8?B?R2dYYUxUTDQ1VExldFpJaDFZUStqTzVJSkc5dGtOY1dadEZjcllYS3g0QXNX?=
 =?utf-8?B?UEVSTWh5bXA5VFNiemt4d015c2hUNFVqTThzU0JCZVBuekw3c0hGMUh0Mzcy?=
 =?utf-8?B?aERJWlhtek9IdmVJV3c1SkZnV1ZlMU12UTh1SkNoc0pyUGZpamg2THJrL3pC?=
 =?utf-8?B?VzBldkl0VStnbXRWSWFFMDIyZ2YrbS9iaTgrTUJuUFFDQXV4NG05cE9wT1Zr?=
 =?utf-8?B?a0kyTlJuMmVTblpFMkVaQXV5RW5SNGxWVWFKWUFvQ3Vab1E0elBQdlJ3RXZI?=
 =?utf-8?B?bVpKbmczMkp0eHM2NmF6b1EvNy8xUlFHQ2M4ZUVIbStjT0d1dlk1STlwZUpK?=
 =?utf-8?B?TjRCU3FpY25PVmppZkxYcTNXbXh4RFozSVV0elhkSkhHRlhFQUFoaFY2Z3c4?=
 =?utf-8?B?cXBJRkdQbGRiN3VkUWVOeFBKTmlUNGJBZzJaV1RlN1Rwb3RWQ1VTM1FTdUxI?=
 =?utf-8?B?ZWNrWkJFS0Z6dHpHK2RmdjF0NjFJRGU4M3ZRS25WRWNLUmtncVQrS2JKNndM?=
 =?utf-8?B?Z2xjYmdnT3dZbGl1cmZVRC9RRFZCTXVlbWgzNnY5d0xrTCtLbytjUHk0bjlM?=
 =?utf-8?B?VVZXOXBjaVBuazFLcWdlN203Tkc1amhVQ0ZzeWR6bXF1ekZRUUwwSDNhWkFs?=
 =?utf-8?B?emlvdlRQT1oxOG9keFcxU3N6MnYwQkppSGFkblliREZ5VlpkL2ZRTjZtNHY2?=
 =?utf-8?B?NDI2RWYrc3RnUlJPMFVHbnNtZjNpWGh0NXNiUzl2SzlKOTU2TEZSTDRpSjNr?=
 =?utf-8?B?UEY2Zks2VHljWm50eENlTHhHVTBpeHJ0ZGl0ZHdYc0JPcVlaM0hJYng3UlIy?=
 =?utf-8?B?ZmVhN0ZUd1p3TWtNcm1PRlZ5bzFuTWhxNFVxVTN1RTQyamg4ZlpobHZNZDF4?=
 =?utf-8?B?UkFZNm1zVy9selNBeG12WmR6WGE0bVZkSmNIUzRPM2xXd2JwejJONTlNdXVC?=
 =?utf-8?B?dmRUTzcwajhqVnpzR3V6MVFvc0toaFFwOVd4NjZTSkxPOGw0TGIwTzFBR0d6?=
 =?utf-8?Q?1KENS588n/Jz8PMexEWlbvt75XD2Bw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXpIVGpZQmsyQ09aL2ZoUFJaKzlyOGtjTTFUZTd4K3MzV2RxMDdQdmk4Yk5K?=
 =?utf-8?B?YkZYdSt1eFZjL1VqY1VIUE13bFNLcWUzZVdwdnU4ZHBJMkZJMVM2Y3h3ZXVR?=
 =?utf-8?B?RWdXa1A4anBrbkNoK0U2eWsyeWx0SlBuVlQ2WlpmMzBYZUtqbWE1L2ltdVZM?=
 =?utf-8?B?OFcreTBJbk0vMUpLdExROVFQY1FOeTNCb2xQKzVQSkZMS0wxN3pNQmdrWlI3?=
 =?utf-8?B?cGl0dG9OYTZmWHNjVlE1d1ZuaHJSOUQrU1lkaFJvckRhQ01RTVhETi9YU0l3?=
 =?utf-8?B?YVpsT0l6Q1Mvc2g1RFh2STZIejEwUm9FeTRMNndrYVdmMFpRNUVMVU5RTTNj?=
 =?utf-8?B?N2hvNFBrYnlEdXNnb3N1eExFSmMrWnE4c0lYMk11RWlsdzNBTVBHelJpTWNI?=
 =?utf-8?B?MVg0N2VQU0lBZUJvNnptVDVzSnEyVFFaVG1ZRUVQaVdwOUpNZnhDT2VnTnVk?=
 =?utf-8?B?amYwcFdDVTFvZFhzT0h3d0RlTDFLbklBZnEzTEhCQjE3c3NFL1R2eUhsajgw?=
 =?utf-8?B?TmhTVndEQmNRVjN5TGpxbWE3eFU5Q2lZaXVFamtjUkM2K01oVEtKZnNGU2ZT?=
 =?utf-8?B?ZXM1QW80dUxhcHRMbjF0K1JNelB2N3ZzUzZtbklxRlJwL3NJc2N1Rkh1Smly?=
 =?utf-8?B?N1c5VUdLd2lFdFMybjZEQjF4QnhyMEhXWlBnSEVyMHNwdEc2YzBWZEthSTFy?=
 =?utf-8?B?TzlrVk1XbzZzMFdsTU44Q3JzeTFVUkFqWVZhNmlhcDJuemd4L1lpYWppZjgy?=
 =?utf-8?B?TkQ2NFVMY1FRSHQydE1ERkdjU3NLbFJjYm54YnNCYUZXdlRnQUlOV1dJWmNn?=
 =?utf-8?B?QzVYNldURjc4bnJpRHRnVFppZ2FaLytMRVJnWDVPa1A1VXFmL3JEdi9SRjAx?=
 =?utf-8?B?bk9US1FBTmZycCtwYlEyaHN1c0h5VmlpVXAwVytrSEN1UzRlRVFGVmZ6TTBM?=
 =?utf-8?B?OG9PYm9jNlY5TzR0Vng0aUVqS1FOZmR0NzkxeXFYZy9FZ29iSmUveWNPdUJW?=
 =?utf-8?B?NFFVeVJWdVVXZDJsNTlPaTkreHFtTDhoUkZ2dzZGWTBYWFpGNERmSEp4OHRJ?=
 =?utf-8?B?NHYvTzFHak5RaHV6ZDljaCs4cWoxenM3U081U1hzR2tRUnVPM1VPZU11SnJD?=
 =?utf-8?B?NHFWMnlNU2dSMXBSMlRPbENqcnBKL2FLdjNBbkRmbitmb1h1SVA0ZXBjZlds?=
 =?utf-8?B?ZjRWM2VXd2JLWUtZMG5oTk1DMTFkWEU2bjNSbmZXL05ycVRqckNUNjNFZENp?=
 =?utf-8?B?UWMvcXFiUWQzS003c0I4OGpNbklROTg1SUEvTXgzQ3FvUFBIczdhN0lOSHhX?=
 =?utf-8?B?eE9nSCtPa2RmSWtsOE1VSld2Z0FBQ1d1dUZqMVBxdHpZK0FDd00xU0FzNTB1?=
 =?utf-8?B?WUl2OEhaYWhPN3lsTmcwZjVLd2pZVERlQWI3N0RubEg0MXNOR3R3MUMrVGd5?=
 =?utf-8?B?QnVjNHdtais3aWFwemdRc216MmVxR0lCcDZ4amtXbmhFZXBRUWR6YUJHbkFC?=
 =?utf-8?B?M3VEWVlibU9icU5YK3l2RVhseUFzUVVUeHZPVDhBdDNjZkdZQlZ0MXA1RHBj?=
 =?utf-8?B?M1czbVBIS1lrOWFPMEZ6dXpFT2lYQWJMT2IzOHhzdms3Zk9ZakZQMjdxbHdY?=
 =?utf-8?B?SkRoWUtFdkdWcVQ2aTdTWWpSUUpmc3dFaDFWSUJCWUlDSzFQa1pxWDVhSGIz?=
 =?utf-8?B?TjQ4QmQwUTNmUTBlMjZuWkI3c0Vmb0hBK0Rwais0cnlSK2Y0STJlYmcyUW9I?=
 =?utf-8?B?Uk45QjVpazExdDU5R1FoR1dia0RxSzZWbjBuSTVKTC9mYW1iV2JmNklKNHc3?=
 =?utf-8?B?bHFnaGFtTDZvVjFnU1pka0NUZzN3cGx5QXpnNTZmNFhLaEoyNmZ5N1I2Q01z?=
 =?utf-8?B?ZnliQjlScnQ3bUYyYU0rRlA4bU1mL0psdUcxa3o1TFlnb1lVRm8wMDNWWDBa?=
 =?utf-8?B?bmhtVDloeHc5Z0d0MzhGb1ZNbGVKVFRuVkN1eGZ3bTBQc1Z4dmdTSmc0YWhs?=
 =?utf-8?B?VHpYbWJWdXArNzlDcG5yOUkxVmk0RmprRFhhaFJaaHhhY0NCTTBXaEdHOVQ2?=
 =?utf-8?B?WHN1MHZwS3kyMUszS1p1ZDhxMXlpOE9tQ0xoNDZtbVl0TkVnRHFOZ3o3c3o2?=
 =?utf-8?Q?C1vA5JNbqyf64oYPQZLtPxXrF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <989421062043BB4DB3179D6028F63F83@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1bSF66NTdpIn/CZAylsvQPdU1Us8q3tYPao2la4P6n66mfbzawC7cA1tWyJ7BXF9NvjfeSfYwJuZ+C8zismnR9nUZhpQQ+as7Q7TM1iB8TOAnkdLnCkp6j6oe4hASrT2UbOq0TCSMS5DPs5gy3iOdMI/NntXfghWnZbLz2Jv1Yab9r+QtdSbxulJj0eYUE7SOTJDiUeSxAAGneZBXcysa3CG//S8tvhHClEAQ1E61jXpnPWMTQTcIpNkfYdSpeFjgTp3rrPXWa7U6rV/L+PkEptFcCh6kdkgxdkgTIuF1bCpgvh5UABKvd3/mL/tIfJBxGq8Qs8z6i8NOQswjfFvsD/jUp32qSlrNJmJ2d431KAi6JoXCxGs40Fe/ZhsGZln8jqrx2ZPdXUIsBIJbMSXq92s9pEmWitNPzzfODukuaLX/Kkb/7W7bbuqieselaYC8zZAKtd7MCjf4JbXQ8C5u5dSv6+6AtYcNim6TsCteah14Z6iiTQfXnHfZTjXnWSQdD91T7gJv+3Z6Hw222sTlA++dAxt4ID1R/rRboyQ9fZ9RzVn8LueyYduATw5W/ZS8iEy6o+7MMJ5UKQfz98aJH7Iy50ovGjncNfQHgzAAipyTLk7zvFnnwU3KoMWUJSCnUySzMxOZBeN2LxlPbli4w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4634f5bc-2191-43df-2a9c-08ddd60267bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 22:33:17.5286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IKBA1IA8nHTE6+cKr15XG3qqa0eR8EbfyGusr5dXvt1EoKZix0D9OEMI8Z9yrk7b+QLPk+bEw6gscpVcY7ozCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4381
X-Proofpoint-GUID: aaOuHrsC_1AUjAoDZvhqdAn_QG_Xe4zW
X-Proofpoint-ORIG-GUID: aaOuHrsC_1AUjAoDZvhqdAn_QG_Xe4zW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyNyBTYWx0ZWRfX+vsGpeNj61qi
 uZotR3b69Hm1h+UnXFgZdtIUAFzeNl+1tmrlKuhOHVQv9588izM/krUWUNqbQ0y3lQoCrm7KNCY
 OMVhbVd8kXlTQL21WQEUklt1vnwScblgO+0NcZkGuuQC8Cobc4SeSyFG7M2/8Di4OqtNpz89o4Y
 ZpySpR26krCdfSzsOs1EiqBY3mUYD4CGMeap4H/IwDSXTGAGGuo8GgpzYQK2PYxqLzyxYYMWrb0
 HvI7ffEShNrN5Y9IpCoa/GDxlEjvwG0Zbxz7vWggvJLwAuIMO5KyQ8Ct8aQEivbIVsCfjO0wCcl
 B3b1+IChXISP644S83DJqPXjNISVa6TcLzYEQL5o3cTCxVD7wf0OnPokHjI/FnDHiYahlX4rKWH
 21b+xYqC
X-Authority-Analysis: v=2.4 cv=H+nbw/Yi c=1 sm=1 tr=0 ts=689529b5 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=qPHU084jO2kA:10
 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=hD80L64hAAAA:8 a=JloXFaeXwdkSA3akGm8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508050127

T24gVGh1LCBBdWcgMDcsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGlzIGNv
bW1pdCBhZGRyZXNzZXMgYSByYXJlbHkgb2JzZXJ2ZWQgZW5kcG9pbnQgY29tbWFuZCB0aW1lb3V0
DQo+IHdoaWNoIGNhdXNlcyBrZXJuZWwgcGFuaWMgZHVlIHRvIHdhcm4gd2hlbiAncGFuaWNfb25f
d2FybicgaXMgZW5hYmxlZA0KPiBhbmQgdW5uZWNlc3NhcnkgY2FsbCB0cmFjZSBwcmludHMgd2hl
biAncGFuaWNfb25fd2FybicgaXMgZGlzYWJsZWQuDQo+IEl0IGlzIHNlZW4gZHVyaW5nIGZhc3Qg
c29mdHdhcmUtY29udHJvbGxlZCBjb25uZWN0L2Rpc2Nvbm5lY3QgdGVzdGNhc2VzLg0KPiBUaGUg
Zm9sbG93aW5nIGlzIG9uZSBzdWNoIGVuZHBvaW50IGNvbW1hbmQgdGltZW91dCB0aGF0IHdlIG9i
c2VydmVkOg0KPiANCj4gMS4gQ29ubmVjdA0KPiAgICA9PT09PT09DQo+IC0+ZHdjM190aHJlYWRf
aW50ZXJydXB0DQo+ICAtPmR3YzNfZXAwX2ludGVycnVwdA0KPiAgIC0+Y29uZmlnZnNfY29tcG9z
aXRlX3NldHVwDQo+ICAgIC0+Y29tcG9zaXRlX3NldHVwDQo+ICAgICAtPnVzYl9lcF9xdWV1ZQ0K
PiAgICAgIC0+ZHdjM19nYWRnZXRfZXAwX3F1ZXVlDQo+ICAgICAgIC0+X19kd2MzX2dhZGdldF9l
cDBfcXVldWUNCj4gICAgICAgIC0+X19kd2MzX2VwMF9kb19jb250cm9sX2RhdGENCj4gICAgICAg
ICAtPmR3YzNfc2VuZF9nYWRnZXRfZXBfY21kDQo+IA0KPiAyLiBEaXNjb25uZWN0DQo+ICAgID09
PT09PT09PT0NCj4gLT5kd2MzX3RocmVhZF9pbnRlcnJ1cHQNCj4gIC0+ZHdjM19nYWRnZXRfZGlz
Y29ubmVjdF9pbnRlcnJ1cHQNCj4gICAtPmR3YzNfZXAwX3Jlc2V0X3N0YXRlDQo+ICAgIC0+ZHdj
M19lcDBfZW5kX2NvbnRyb2xfZGF0YQ0KPiAgICAgLT5kd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZA0K
PiANCj4gSW4gdGhlIGlzc3VlIHNjZW5hcmlvLCBpbiBFeHlub3MgcGxhdGZvcm1zLCB3ZSBvYnNl
cnZlZCB0aGF0IGNvbnRyb2wNCj4gdHJhbnNmZXJzIGZvciB0aGUgcHJldmlvdXMgY29ubmVjdCBo
YXZlIG5vdCB5ZXQgYmVlbiBjb21wbGV0ZWQgYW5kIGVuZA0KPiB0cmFuc2ZlciBjb21tYW5kIHNl
bnQgYXMgYSBwYXJ0IG9mIHRoZSBkaXNjb25uZWN0IHNlcXVlbmNlIGFuZA0KPiBwcm9jZXNzaW5n
IG9mIFVTQl9FTkRQT0lOVF9IQUxUIGZlYXR1cmUgcmVxdWVzdCBmcm9tIHRoZSBob3N0IHRpbWVv
dXQuDQo+IFRoaXMgbWF5YmUgYW4gZXhwZWN0ZWQgc2NlbmFyaW8gc2luY2UgdGhlIGNvbnRyb2xs
ZXIgaXMgcHJvY2Vzc2luZyBFUA0KPiBjb21tYW5kcyBzZW50IGFzIGEgcGFydCBvZiB0aGUgcHJl
dmlvdXMgY29ubmVjdC4gSXQgbWF5YmUgYmV0dGVyIHRvDQo+IHJlbW92ZSBXQVJOX09OIGluIGFs
bCBwbGFjZXMgd2hlcmUgZGV2aWNlIGVuZHBvaW50IGNvbW1hbmRzIGFyZSBzZW50IHRvDQo+IGF2
b2lkIHVubmVjZXNzYXJ5IGtlcm5lbCBwYW5pYyBkdWUgdG8gd2Fybi4NCj4gDQo+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEFrYXNoIE0gPGFrYXNoLm01QHNh
bXN1bmcuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1
LmdAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBSZW1vdmVk
IHRoZSAnRml4ZXMnIHRhZyBmcm9tIHRoZSBjb21taXQgbWVzc2FnZSwgYXMgdGhpcyBwYXRjaCBk
b2VzDQo+ICAgbm90IGNvbnRhaW4gYSBmaXguDQo+IC0gQW5kIFJldGFpbmVkIHRoZSAnc3RhYmxl
JyB0YWcsIGFzIHRoZXNlIGNoYW5nZXMgYXJlIGludGVuZGVkIHRvIGJlDQo+ICAgYXBwbGllZCBh
Y3Jvc3MgYWxsIHN0YWJsZSBrZXJuZWxzLg0KPiAtIEFkZGl0aW9uYWxseSwgcmVwbGFjZWQgJ2Rl
dl93YXJuKicgd2l0aCAnZGV2X2VycionLiINCj4gTGluayB0byB2MTogaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDgwNzAwNTYzOC50
aGhzZ2puNzNhYW92MmFmQHN5bm9wc3lzLmNvbS9fXzshIUE0RjJSOUdfcGchZkdob2xadV9naXFQ
VVk0MExSRWFuOWM3QTA1ZWM2bWJqbEl4cnN1enNNS2ZPaUVrOHU4R3NQeFJsWFRDYXhvV000bkxi
b0hjbXpibHFnUVAyZVN6dk9xRXVBWSQgDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9lcDAu
YyAgICB8IDIwICsrKysrKysrKysrKysrKystLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIHwgMTAgKysrKysrKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZXAw
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IGluZGV4IDY2NmFjNDMyZjUyZC4uYjQyMjlh
YTEzZjM3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+ICsrKyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTI4OCw3ICsyODgsOSBAQCB2b2lkIGR3YzNfZXAw
X291dF9zdGFydChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCWR3YzNfZXAwX3ByZXBhcmVfb25lX3Ry
YihkZXAsIGR3Yy0+ZXAwX3RyYl9hZGRyLCA4LA0KPiAgCQkJRFdDM19UUkJDVExfQ09OVFJPTF9T
RVRVUCwgZmFsc2UpOw0KPiAgCXJldCA9IGR3YzNfZXAwX3N0YXJ0X3RyYW5zKGRlcCk7DQo+IC0J
V0FSTl9PTihyZXQgPCAwKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJZGV2X2Vycihkd2MtPmRl
diwgImVwMCBvdXQgc3RhcnQgdHJhbnNmZXIgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gKw0KPiAg
CWZvciAoaSA9IDI7IGkgPCBEV0MzX0VORFBPSU5UU19OVU07IGkrKykgew0KPiAgCQlzdHJ1Y3Qg
ZHdjM19lcCAqZHdjM19lcDsNCj4gIA0KPiBAQCAtMTA2MSw3ICsxMDYzLDkgQEAgc3RhdGljIHZv
aWQgX19kd2MzX2VwMF9kb19jb250cm9sX2RhdGEoc3RydWN0IGR3YzMgKmR3YywNCj4gIAkJcmV0
ID0gZHdjM19lcDBfc3RhcnRfdHJhbnMoZGVwKTsNCj4gIAl9DQo+ICANCj4gLQlXQVJOX09OKHJl
dCA8IDApOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlkZXZfZXJyKGR3Yy0+ZGV2LA0KPiArCQkJ
ImVwMCBkYXRhIHBoYXNlIHN0YXJ0IHRyYW5zZmVyIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ICB9
DQo+ICANCj4gIHN0YXRpYyBpbnQgZHdjM19lcDBfc3RhcnRfY29udHJvbF9zdGF0dXMoc3RydWN0
IGR3YzNfZXAgKmRlcCkNCj4gQEAgLTEwNzgsNyArMTA4MiwxMiBAQCBzdGF0aWMgaW50IGR3YzNf
ZXAwX3N0YXJ0X2NvbnRyb2xfc3RhdHVzKHN0cnVjdCBkd2MzX2VwICpkZXApDQo+ICANCj4gIHN0
YXRpYyB2b2lkIF9fZHdjM19lcDBfZG9fY29udHJvbF9zdGF0dXMoc3RydWN0IGR3YzMgKmR3Yywg
c3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gIHsNCj4gLQlXQVJOX09OKGR3YzNfZXAwX3N0YXJ0X2Nv
bnRyb2xfc3RhdHVzKGRlcCkpOw0KPiArCWludAlyZXQ7DQo+ICsNCj4gKwlyZXQgPSBkd2MzX2Vw
MF9zdGFydF9jb250cm9sX3N0YXR1cyhkZXApOw0KPiArCWlmIChyZXQpDQo+ICsJCWRldl9lcnIo
ZHdjLT5kZXYsDQo+ICsJCQkiZXAwIHN0YXR1cyBwaGFzZSBzdGFydCB0cmFuc2ZlciBmYWlsZWQ6
ICVkXG4iLCByZXQpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBkd2MzX2VwMF9kb19jb250
cm9sX3N0YXR1cyhzdHJ1Y3QgZHdjMyAqZHdjLA0KPiBAQCAtMTEyMSw3ICsxMTMwLDEwIEBAIHZv
aWQgZHdjM19lcDBfZW5kX2NvbnRyb2xfZGF0YShzdHJ1Y3QgZHdjMyAqZHdjLCBzdHJ1Y3QgZHdj
M19lcCAqZGVwKQ0KPiAgCWNtZCB8PSBEV0MzX0RFUENNRF9QQVJBTShkZXAtPnJlc291cmNlX2lu
ZGV4KTsNCj4gIAltZW1zZXQoJnBhcmFtcywgMCwgc2l6ZW9mKHBhcmFtcykpOw0KPiAgCXJldCA9
IGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKGRlcCwgY21kLCAmcGFyYW1zKTsNCj4gLQlXQVJOX09O
X09OQ0UocmV0KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlkZXZfZXJyX3JhdGVsaW1pdGVkKGR3Yy0+
ZGV2LA0KPiArCQkJImVwMCBkYXRhIHBoYXNlIGVuZCB0cmFuc2ZlciBmYWlsZWQ6ICVkXG4iLCBy
ZXQpOw0KPiArDQo+ICAJZGVwLT5yZXNvdXJjZV9pbmRleCA9IDA7DQo+ICB9DQo+ICANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jDQo+IGluZGV4IDRhM2U5N2U2MDZkMS4uNGEzZDA3NmMxMDE1IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gQEAgLTE3NzIsNyArMTc3MiwxMSBAQCBzdGF0aWMgaW50IF9fZHdjM19zdG9wX2Fj
dGl2ZV90cmFuc2ZlcihzdHJ1Y3QgZHdjM19lcCAqZGVwLCBib29sIGZvcmNlLCBib29sIGludA0K
PiAgCQlkZXAtPmZsYWdzIHw9IERXQzNfRVBfREVMQVlfU1RPUDsNCj4gIAkJcmV0dXJuIDA7DQo+
ICAJfQ0KPiAtCVdBUk5fT05fT05DRShyZXQpOw0KPiArDQo+ICsJaWYgKHJldCkNCj4gKwkJZGV2
X2Vycl9yYXRlbGltaXRlZChkZXAtPmR3Yy0+ZGV2LA0KPiArCQkJCSJlbmQgdHJhbnNmZXIgZmFp
bGVkOiAlZFxuIiwgcmV0KTsNCj4gKw0KPiAgCWRlcC0+cmVzb3VyY2VfaW5kZXggPSAwOw0KPiAg
DQo+ICAJaWYgKCFpbnRlcnJ1cHQpDQo+IEBAIC00MDM5LDcgKzQwNDMsOSBAQCBzdGF0aWMgdm9p
ZCBkd2MzX2NsZWFyX3N0YWxsX2FsbF9lcChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCQlkZXAtPmZs
YWdzICY9IH5EV0MzX0VQX1NUQUxMOw0KPiAgDQo+ICAJCXJldCA9IGR3YzNfc2VuZF9jbGVhcl9z
dGFsbF9lcF9jbWQoZGVwKTsNCj4gLQkJV0FSTl9PTl9PTkNFKHJldCk7DQo+ICsJCWlmIChyZXQp
DQo+ICsJCQlkZXZfZXJyX3JhdGVsaW1pdGVkKGR3Yy0+ZGV2LA0KPiArCQkJCSJmYWlsZWQgdG8g
Y2xlYXIgU1RBTEwgb24gJXNcbiIsIGRlcC0+bmFtZSk7DQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IC0t
IA0KPiAyLjE3LjENCj4gDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBz
eW5vcHN5cy5jb20+DQoNCkJSLA0KVGhpbmg=

