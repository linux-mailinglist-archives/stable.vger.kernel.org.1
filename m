Return-Path: <stable+bounces-107935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F392A04FD2
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 02:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B00916451E
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98BB13B288;
	Wed,  8 Jan 2025 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tch/qlzY";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RTvvtykh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mW24A4Me"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060B139CF2;
	Wed,  8 Jan 2025 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300679; cv=fail; b=HJi75kfWc3e8F6eA09rnMFJm86Es+KEtisA+rmbgDzO+uvOjZnvoZCBp8e+T61A4nZwzW9HjPQ1/OUffj/h5WgnsxbY8XAAAZTD2e8Y3fwLknYOLDinZBC5TuMm6gAnYX76cwFw77w8U2FKrmee/EWaQ2ZUphaT/Wi8OnYbj+uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300679; c=relaxed/simple;
	bh=jE5YGVgiJ5tyg4CA67Vv8si966kfpP8SFDKrl3KkmPo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BlfS+RlmhK7xPgDWMlR+Kxcvkscq8GLpTFGYuTtGi/ZRIpUXMw2flfR6Xw/5r5maNRZp4uxHS8CaVn5raryMfA7JlA2mlgrMyxGDJa+CigtR1N5Gy2n7M9LgP+GexvbsUTCfKHk3riwHQoh61pkDLDQoybMdrIFviodWugLnDiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tch/qlzY; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RTvvtykh; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mW24A4Me reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507J76CF025480;
	Tue, 7 Jan 2025 17:25:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=jE5YGVgiJ5tyg4CA67Vv8si966kfpP8SFDKrl3KkmPo=; b=
	tch/qlzYhCJozCldat7rkd/kSh1UBkmdaNJU6j8eAcBYKcbBAdarpGk+hh+DoGDa
	Ny8sz+KU0Ed1w3JkiiUKZNOftk9Wd6oz+RFBgWTYYMwa/rzaKgRRmbML6E0WBwAi
	3ldwPJ7M/iHab4pimN+gwQRKDscYZv/F9uHVC8a7ASUMKKBZex4ybOCOhkmPpr/D
	b+PM2ei45d43dGzvJixyhcQ7Xas/KqTFXgS4hqNyB5e16fzQ0SeviEVjPLChH5j5
	VQYOeBoYUp0Gwe2aQHL8O5EhKhJFHpFgqUWKwNOQVTq+Jnppozo9PX4s3Swwxz9S
	sG1qW7pK6gCk+djSq+QP7Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 441a549ch8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 17:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1736299514; bh=jE5YGVgiJ5tyg4CA67Vv8si966kfpP8SFDKrl3KkmPo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RTvvtykhZAollPztc6qxZVm1Rz9mL6JfmLbHIvr0DRrQ/zhxGEPArXyMH6YfJeyGu
	 M71hOtWgxBZyhylkFMSc4JJT+rdP2Jx4FIgHvv/pfP1Ag+/xGBTzrPsO+UMX+86vCw
	 Si8FPWdJB2RBJjWFz5yl5Ng86S1EfXNjK19yBM7eJdcvKUGaEdCmrc58qVlmOhz6vI
	 6/L9vMVSZfC6HT9rify54+aXgqkxbEt7WK3vg6bIspzW1HjqWAjbRwt7hLanDeU+tw
	 HNfckupeO1W3Hz+5wisb/Mu2sPKpHmkCqT3IBGoknKkYWiDBCYEOM+HPADZJyyFkzz
	 M1VgZJa9Nf07Q==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9A6D840136;
	Wed,  8 Jan 2025 01:25:13 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 53F9AA006D;
	Wed,  8 Jan 2025 01:25:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mW24A4Me;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1F95D40148;
	Wed,  8 Jan 2025 01:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etGQ6F5jTLftfPmBdlB/TC1wuF6chK57+Yfgg/IDe19+ve249KZmBCWDe+3Q4aY1ffYkmtETMy40cLhkk/bSyHtC2l6tOBUf8At2hemwHBpZyYPAWJvwA34OmhX8KqiDK5RtZFx0tnvnGoVa0kofL6avpU/mqsQK59tMorahpGmL77iyzRWyE7rlyxVT+7/zgKH9GV5CEesM43cze3yz3IWwJfLfWAokTiw7bJy2oeX9lBb2zadDV8XPgnT/K/VC04vSJMWxqWUVg4YouVGcoQYQBwfr5BhJ2VHCrcZJBmo9eNnGpDpJ8q/4WPOuMWS3/4w4QgnCPgPCcGL0lFNtVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE5YGVgiJ5tyg4CA67Vv8si966kfpP8SFDKrl3KkmPo=;
 b=juYjEPesqC9po8vgM9EaKK6dG5I54uAkhZ1QHq7DwuQQJnRrDWr8JxLlZWpb7WQ6w06d8e5wldQcuhtH996VBumwS5s1xOygK0YcZBvPfaFNbK/1rKamop46BzqI8P958uIVdBbMkSE2CeYzmn95LlkJ/X0RgDX4df1G7RcVNv9H6kCFieW+xeoeon9Jl7Ek7edeF8U5VdcUiLgmUKQ5b4zP5jUqwJKpTL/dM2xcC/iyqIteX6EWJjn8o+B0qQYtU0aEErtl6Fktb7mrY1qJfFFObu9pV9Z6fyePhf8bvPvk01MnT7DnYwidR9s5pZIdPlLrTVBa9hKNDKiF58k/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jE5YGVgiJ5tyg4CA67Vv8si966kfpP8SFDKrl3KkmPo=;
 b=mW24A4MeAmvVJGWPzq9KMf3gojnl9LLBbpv6yvHcT+zOS/qhCerH936TPYuD/AEqWSy4gfb1pHAM4cElUwrZruNA5UileDgM7PyZ/QIayENNwFrDax2Re4NY98OltIsFgxrNGqRgTZRuSV6909ftcHLIUVEVU07yv3QtR/iXOg8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 01:25:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:25:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Ray Chi <raychi@google.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "albertccwang@google.com" <albertccwang@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pumahsu@google.com" <pumahsu@google.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Skip resume if pm_runtime_set_active() fails
Thread-Topic: [PATCH] usb: dwc3: Skip resume if pm_runtime_set_active() fails
Thread-Index: AQHbYBQubw0bBfE6x0CGK56duHGdn7MMFokAgAABm4A=
Date: Wed, 8 Jan 2025 01:25:09 +0000
Message-ID: <20250108012507.jv2wkw7qtxztfkvv@synopsys.com>
References: <20250106082240.3822059-1-raychi@google.com>
 <20250108011922.lmdafz3sqbbhbj6p@synopsys.com>
In-Reply-To: <20250108011922.lmdafz3sqbbhbj6p@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB5812:EE_
x-ms-office365-filtering-correlation-id: 454a9333-2f73-4fae-795a-08dd2f834ac9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0h3N3dPUjN2VW5OSHdDazZtS3FSTWNjKzk3QnEyUGtMcm1yc0dNSjR4bmdR?=
 =?utf-8?B?MFdzbndTWkxhaE9pN3luMGwrODhnKzFGRU9rSXh5WXVXeFpVak9ieEFueUx5?=
 =?utf-8?B?d2l6a2g5cDN4QitQZmZsdC9SVGlIemgyOXZBc0YxNXVaSC9WRVd6dWZBQjdG?=
 =?utf-8?B?dFRNQzYycGppVDVtTDd4cXV3Z1ljTnpTNnhQMytMMms0eWJ2V1V6cDBoNjdR?=
 =?utf-8?B?aS9sTFNnRGQvTzdXV1lKd2VpeHlDczRYZFUvZnpSTXJ4OFptQUt4TVVTLzZy?=
 =?utf-8?B?SjRBMmpXKzN1U25oQjJ4Tkx2cWFXcDdnd1UxK0k2bWVrTWhKNVlKYk8rZkNU?=
 =?utf-8?B?N1FkcjBIRWJQTEZWcm1QKytpTFpGMFpBcVUyZWVDZVIrVjNqejBMUDFLeDQ5?=
 =?utf-8?B?UjRsMDllQyswNFpSM1VsWHRIeURla2hweW9RUUZEemxZbzYreGhtYkNaRjN2?=
 =?utf-8?B?UDgwbHRLeGs5ODlIRUd1Y0Z5d29leVB0UFZVb3BxcXIwd2RJNlAvOGJIcXow?=
 =?utf-8?B?Wk1WT2dLQUxqeTFLblh0SW1wNmIxc1ByczhWOE5WRityanJsNlVsZ3VYbDVF?=
 =?utf-8?B?STd3UzZkYmRrRWE5MThEdUlBV3BuVjhMZWptTWdtcW52QUltbVhoOUdVUThY?=
 =?utf-8?B?VHY5UmJoNityYkhhNWtiTmZXTjRqWnBlNWhlMjNSL0VzSHRJdGhoSjM5N3gw?=
 =?utf-8?B?MG9ybXBVeGdyVWtXN1RsNnhtRmVGakdZaXlQbTdsUWU0UllJYVdlTXF4LzJF?=
 =?utf-8?B?bm0yUWFSYkRRaXQvYkJoR2M2SkJkdmRTaWErTXBYMDVZamFadjU1REl0a1VP?=
 =?utf-8?B?TUUxVUhZYzZnQmEvaFBHTVhWOXZYc3hYVElIMEc1SUdOL1htYWNjYnFoZWZw?=
 =?utf-8?B?aFBDUTM5WXp0ajJPSG9UQlRIZFZlVThRRDNKWk0yVVZta0gySTZKOEp3WEJJ?=
 =?utf-8?B?LzVJOWxyT29YQnFUWHhPVkEwUzVyQTNzYVQxZGpnbWdkUCtGWWtSRkJqa0xa?=
 =?utf-8?B?VFNGZGVVZjhoSFVOVEc0NXRYTEtDaU5XUXdKNVh5Q2NuVWxpOEJabEhISmpK?=
 =?utf-8?B?bHIwcHAvMTEwSXZkc0NLRHNDU1VWTnJLNVNQVnpDVUg3K05GQmFYaEI4cTcw?=
 =?utf-8?B?SFRGZStIRExUZUtKeUo4aGZTNVE5UXZQWEZoUjRRRXh1bWtUSmZOaVVZWHpH?=
 =?utf-8?B?TGpCVlBEQlQ3YnBkK29SUGxuRWYxNDFTdGxHeXNFbURJcDFWTXZYWCtGS05U?=
 =?utf-8?B?bFBqNWpibmhMM3UwQjZHK3RJTkRRc1ozRnZvUjBHZWpURkZKaUh1S1N3d0tD?=
 =?utf-8?B?RFFDUFo2U0h1blVVUGRxUHoxcEZnSm15VElONG9SNVVtd0hmUlNScUMrbFc0?=
 =?utf-8?B?KzVVWTlnU28zKzB2V1JQTmtBT0JyaXRhWXhsbkxyemtLWWdaUTNKZm15cDQv?=
 =?utf-8?B?UjRZUExkN0FObm5kd2c3K3NwQlhjVERLSllLTkxCd0JQR0RoNldHb205WC8x?=
 =?utf-8?B?WFk2dnp1bHo4ajEzMU1oS0pnNnViT2duc3JnNWhvMjdRQkNUdVljaGwzUnIx?=
 =?utf-8?B?UXFQT1VyNDNCOHJ1cjVzQkRnYzJ1Q1g0L0RhOHpHMlB2WFo2MjM2cFR0Uk41?=
 =?utf-8?B?c0hWWkVHdlRIMHJQWHhHTkpKNWtnQ0N6aElNQUdpdVV4OEUyOHBvL0huNHVM?=
 =?utf-8?B?RVpEYjZyNDN3SUpoUWJidDJwS0xJTlJqSlFmeXc0WXFpRW5WK0NEU3JIUEsx?=
 =?utf-8?B?WFViaVkwM3k1ZDBReS92VXR3MHRtRUxPNEtuRDZweTB3MFhPTGI0OHNIam5z?=
 =?utf-8?B?dEF2dDlWUUJ5aXVpUXNHVWJ5U2R4NWhveXRhS0FLSW9oVWlEK2JKZEdrSkZa?=
 =?utf-8?B?ODhUQkNtSlphOUg3cFhJSmVWVGlzZjNhQUNUMnZlTGpBYllRTDVMb01EVWdZ?=
 =?utf-8?Q?t9y/Zhb73Ww9UUDs4aGomWQIPMTP57tB?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1FGWUVudzRhWEhvQ2VwZVdUK0cxR2ZQVEV5WGY1cTZIYmdXNWp3bnNlMGdn?=
 =?utf-8?B?bzM2KzVqMk0wa0h6amlKVXp4bXpJVTN2bUhGRjNqUC9BQ2hhOGlnNWVacGRT?=
 =?utf-8?B?RStscnduYS9NQ2VjUll0dmFlUzhzK3I3bUpwTEwvcU9ORDZxWkl6R1djTWFR?=
 =?utf-8?B?bUxYNEs0dHdQTkVoS1VhUmpzWmlEOUtGR1MxVlVBVUxtMW1mU3FWV1U4dFcx?=
 =?utf-8?B?S2ZLWDM4dmNISktsbG1yUHJlZWQxVE9IMllvVG50S0RrSFRpeVBJT3A1STRM?=
 =?utf-8?B?WWVEd2dKc2tvVHgyWW80SkJMYU5kNEsxNjNvQ1hlYTBaMitEb3pVUFF4WUtj?=
 =?utf-8?B?S09udkMzaUVhNVQyRTcvbloraGFjdWo3ODZPM1VzaU0yalNQOGd0RFg2MzdP?=
 =?utf-8?B?MUh4Zk1jNDNVNG9QMzNOL0Y1KzdZNU1IQWFIYlRQVWRCcUlZR25vSzA2bXBS?=
 =?utf-8?B?Sm5PK0hWcDByTWphTE1uTUxBbm1lZWF5emo1bnlVZTY5NkVBc3QzNVVHYiti?=
 =?utf-8?B?S1grNVJpMmFYUnpGZEc3R3Zqc0k4ZFlESHlGcDRXUWh0V0tHa1MvSUlYRG1Z?=
 =?utf-8?B?ejBHNTV5K1YyQkZzeDErQXJvYUg2akdFUW5FK1dYM0Nyd1FPakZ1UUQzaVY4?=
 =?utf-8?B?Z0tESkpWYWNkWjdYeElxMmdNSENVQmdwWEdCdG93U1ZHOWJTWWJCelU2Sk1i?=
 =?utf-8?B?VFNDeEdSMTZEMUY3Rk0xenllc3RzUDhjbk9mMXduVHpJdHg0UGd0UEg0czR0?=
 =?utf-8?B?NHpKRWRIeU5GOS82NjlpNG9YVE1LbmdnRE1YNzhaY0N0ZkN0Y1JtcTB0M203?=
 =?utf-8?B?MWE0dFJnVmxpWWRoWSt1WUNucWJPNEd4bkV5M3ZvcDdNN01uZmFwUUJWeEtS?=
 =?utf-8?B?WjZnYzRMSlBKeFV5WUJJU0dxdyt5Y2lXWFlHbWRtT2ErUHI2UlJZN1NnLzdz?=
 =?utf-8?B?Z2IxV1FWaG1rUm93bFpraWQwd1dsTW0vZklXaDdpY1lZVWd1aDc2RnpZdUd2?=
 =?utf-8?B?a1VkU3lzdnNMOGcxZEhHKzYwUmhnQmFKeEJHbVZqM2hHVWRZM0RiVkVNUFJk?=
 =?utf-8?B?MnhPb1V1THRPTWpNeFoyTkV4dFZ5U1ExUUF6R2dyRkg5Mmp2OGh4d2x4VDgy?=
 =?utf-8?B?azVkU0tZTFF1OUNiamhBd1NnTXVGK3pDdVQ0alExMXB6SFd6S0lFMjJEaUwx?=
 =?utf-8?B?eFdDRWswMmNYMDM3VTVUY1JVOVhaT2xQM1VLcEtjK0Eza2lxM0Y1Ni9pWFVS?=
 =?utf-8?B?WGlyd0ptTkpqc1dEdWV0VFhXZy9Gdmp2WnFDdENsNTR6VE9wNVNSNER0a3hr?=
 =?utf-8?B?L3crNlJsME9zWWxQcmY1UnFieW9NTTVQbjZNcHBVbklVVUNjU1NjZ2pPK2tx?=
 =?utf-8?B?Q3Jab0d4NzdXWE0zMlBxb2hVK283R2FUU1RwcXdwUklBeFIvRmxhM09oVmg0?=
 =?utf-8?B?aGdVNVRaRTkwbll2aGFDVDhCeS90Y0txTzVadEdZUzE5RzRjN2JHeWs4WGZj?=
 =?utf-8?B?QXlOZ3hOcDVubGJEY2JrVkR6QTZRbG9nQmZJb05xb3RHaUFBaWpsTEx0TjVJ?=
 =?utf-8?B?aHl5SUVCS0FjUlorcnVOL0FCNHR2NlJxaDkyZnRVbnVBbldCbGdLUzNZZ0RK?=
 =?utf-8?B?OVJNWHMvQzYrZVFjZDVVSDlpU2Z0TmZQbGtvK25TOUxLMjBadDBnUUdud0J2?=
 =?utf-8?B?ZHdXaHBKekFtSWhUMWxzT0x3cTJUaW5mbUkvVUtXOE84Wng1aGNLS3p6SHR5?=
 =?utf-8?B?dWs1SHNPVk1KVE0rQjVaOVpWc0xTK09uaWJqbklhS2hvQ3BMbDMzNUhmNStO?=
 =?utf-8?B?S3RQWW5pbGdCSEN6cmdibVd3T0xucEVwVEZLYU5nbnllVWg4aWdqempxVURK?=
 =?utf-8?B?ZHhxY1NqZkZmejVhZFJNb0dHbVBZWmVtWGxabW1GQXc4anExemorRklGcVo2?=
 =?utf-8?B?L3M4WkloL0hFOHR3dWoxeUI2K2s4cXRmaEcyRjZBWlRhOEczTDc2ai9xYXZk?=
 =?utf-8?B?MkJMUTNTeDNkMlpBVjRwSUwvbUdCbWJVTlJNUGp0Nk9IV29TbGlCWTlRVzRo?=
 =?utf-8?B?ZXBXTklVQ3VsN0E0ZTdhNU14ZkEvMlRTWC9FU2ZZdnozRWpqQ0s2Qk5ad1Aw?=
 =?utf-8?Q?vTpt+WsmoKoKYYeeKToYr1DTD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D4C297889F501419AA41DF4D268B7D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YS/oJXvPQ1vjksTStAGiwK2EFu0Rs6TU3CQlBXAeGFLhJmZ61vokzspei1P4hKzTZ9PewBvxkbV2jpgN11p8PcmMAsw/VlL+PJn51Jl+dqFPF+zKVwKqQ8IK9nfOLS81YEWh5azHLPKIv7jwXJl2jz1Sy48pKMXT0FZNmeY7I2D7XOBFhD1fxiJywD8EQlk71eqVxaAwVLaLXzgLOlXcwcEXDVx9wV42Zzx/6nfMse8Ywq/88s+rgeaSh3ub0Ln2fvo45H2i+MEojbXl/b9DUgsan6qzMa6JBdsFHpUESIFzUlNeHjsNsBQBf+YDoDNF7IIcr2rEKcT4+7knlYh7d0j0YtFZb5NyFxoF6vJVDSAVfFS/GUK3B7ifhRk4DTOdi7Vld6T4Xv5ym6JeHmx4N0lgtdDDSmLwURtEfjYAy/YHnqr2tmiIfNzguPsJaq0bsQSqi6W1sfMhygGlvrx11RF0+mgRrHhZBusaEsqZwXwJ/qU4fT8Hoi07ZdB2pO7URuUORPECPPqjmp8XwfK15r4mWfxERJsM2Y8zIFVF+tS7147xAi1ktkMCnrKrrtPNRVWgnVrJA9KHD+7aN0FbeSQXXQd4VkpIhzsOVPOwOV/zOmNZVFG9Y/uJoziB1Ae4uOFePHhXU82obl+89SLVsQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454a9333-2f73-4fae-795a-08dd2f834ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 01:25:09.7805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hBqRtvhYz99KQgvEqPkC/1GF3zgOHwO8A6PJFP99gnce4HulO2fsqSRQ+Ge/iLSRh73kyLrs6b4C7VnaSMtD3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
X-Proofpoint-ORIG-GUID: EIRWBsuFz6Jc_-zivmbfBKnptkn-OY13
X-Authority-Analysis: v=2.4 cv=LrRoymdc c=1 sm=1 tr=0 ts=677dd3fa cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=jIQo8A4GAAAA:8 a=wWXSnbDSnInHeOwxLgAA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: EIRWBsuFz6Jc_-zivmbfBKnptkn-OY13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=552 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080007

T24gV2VkLCBKYW4gMDgsIDIwMjUsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gT24gTW9uLCBKYW4g
MDYsIDIwMjUsIFJheSBDaGkgd3JvdGU6DQo+ID4gV2hlbiB0aGUgc3lzdGVtIGJlZ2lucyB0byBl
bnRlciBzdXNwZW5kIG1vZGUsIGR3YzNfc3VzcGVuZCgpIGlzIGNhbGxlZA0KPiA+IGJ5IFBNIHN1
c3BlbmQuIFRoZXJlIGlzIGEgcHJvYmxlbSB0aGF0IGlmIHNvbWVvbmUgaW50ZXJydXB0IHRoZSBz
eXN0ZW0NCj4gPiBzdXNwZW5kIHByb2Nlc3MgYmV0d2VlbiBkd2MzX3N1c3BlbmQoKSBhbmQgcG1f
c3VzcGVuZCgpIG9mIGl0cyBwYXJlbnQNCj4gPiBkZXZpY2UsIFBNIHN1c3BlbmQgd2lsbCBiZSBj
YW5jZWxlZCBhbmQgYXR0ZW1wdCB0byByZXN1bWUgc3VzcGVuZGVkDQo+ID4gZGV2aWNlcyBzbyB0
aGF0IGR3YzNfcmVzdW1lKCkgd2lsbCBiZSBjYWxsZWQuIEhvd2V2ZXIsIGR3YzMgYW5kIGl0cw0K
PiA+IHBhcmVudCBkZXZpY2UgKGxpa2UgdGhlIHBvd2VyIGRvbWFpbiBvciBnbHVlIGRyaXZlcikg
bWF5IGFscmVhZHkgYmUNCj4gPiBzdXNwZW5kZWQgYnkgcnVudGltZSBQTSBpbiBmYWN0LiBJZiB0
aGlzIHN1dGlhdGlvbiBoYXBwZW5lZCwgdGhlDQo+ID4gcG1fcnVudGltZV9zZXRfYWN0aXZlKCkg
aW4gZHdjM19yZXN1bWUoKSB3aWxsIHJldHVybiBhbiBlcnJvciBzaW5jZQ0KPiA+IHBhcmVudCBk
ZXZpY2Ugd2FzIHN1c3BlbmRlZC4gVGhpcyBjYW4gbGVhZCB0byB1bmV4cGVjdGVkIGJlaGF2aW9y
IGlmDQo+ID4gRFdDMyBwcm9jZWVkcyB0byBleGVjdXRlIGR3YzNfcmVzdW1lX2NvbW1vbigpLg0K
PiA+IA0KPiA+IEVYLg0KPiA+IFJQTSBzdXNwZW5kOiAuLi4gLT4gZHdjM19ydW50aW1lX3N1c3Bl
bmQoKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAtPiBycG1fc3VzcGVuZCgpIG9mIHBhcmVu
dCBkZXZpY2UNCj4gPiAuLi4NCj4gPiBQTSBzdXNwZW5kOiAuLi4gLT4gZHdjM19zdXNwZW5kKCkg
LT4gcG1fc3VzcGVuZCBvZiBwYXJlbnQgZGV2aWNlDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXiBpbnRlcnJ1cHQsIHNvIHJlc3VtZSBzdXNwZW5kZWQgZGV2aWNlDQo+ID4g
ICAgICAgICAgIC4uLiAgPC0gIGR3YzNfcmVzdW1lKCkgIDwtLw0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICBeIHBtX3J1bnRpbWVfc2V0X2FjdGl2ZSgpIHJldHVybnMgZXJyb3INCj4gPiANCj4g
PiBUbyBwcmV2ZW50IHRoZSBwcm9ibGVtLCB0aGlzIGNvbW1pdCB3aWxsIHNraXAgZHdjM19yZXN1
bWVfY29tbW9uKCkgYW5kDQo+ID4gcmV0dXJuIHRoZSBlcnJvciBpZiBwbV9ydW50aW1lX3NldF9h
Y3RpdmUoKSBmYWlscy4NCj4gDQo+IA0KPiBTbywgaWYgdGhlIGRldmljZSBpcyBydW50aW1lIHN1
c3BlbmRlZCwgd2UgcHJldmVudCBhbnkgaW50ZXJydXB0IGR1cmluZw0KPiBzeXN0ZW0gc3VzcGVu
ZD8gQW55IHdheSB3ZSBjYW4ga2VlcCB0aGUgc2FtZSBiZWhhdmlvciBhbmQgYWxsb3cgUE0NCj4g
aW50ZXJydXB0aW9uIGFzIHdoZW4gdGhlcmUncyBubyBydW50aW1lIHN1c3BlbmQuDQo+IA0KDQpB
Y3R1YWxseSwgSSBtaXNyZWFkLCB0aGUgaW50ZXJydXB0aW9uIGlzIHN0aWxsIHRoZXJlLiBKdXN0
IHRoZSByZXN1bWUgaXMNCnByZXZlbnRlZC4NCg0KTG9va3MgZ29vZCB0byBtZS4NCg0KQWNrZWQt
Ynk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0K
VGhpbmg=

