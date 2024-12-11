Return-Path: <stable+bounces-100685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B593F9ED327
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AD316387E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32A61DE4EF;
	Wed, 11 Dec 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jAdqa9dL";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IO7eS0La";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="u4uU9Oge"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE51DDC11;
	Wed, 11 Dec 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937232; cv=fail; b=HeG5D0C/iLE82h/XWkOeZMDzygIEJVWIpQynRUNScx9ylFEPJFQWMK9xvUYh6wVZUf+SaVJSxs7fabx4LQAK1i5WYi+hFTl7MQcDLmKehJg5LJMjZ7ldDCEPA9QoE+THs+n4Ip5oKtvV8sNd15MdRBQrFzbq96ogelmYzWlFKfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937232; c=relaxed/simple;
	bh=9A3ibVPR1w+V6eZHlhc1BIAtxnieH/D3zsW0ayjBXsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iU0fBmkqYX5AzR0GfjyuaKQr7Lwi+BCkaV7HlOiADe1txCOcapBFz9mkrigYREHF5e4LdLjDgU0exeBwxxvoNxj7kAT+Z43qUv06ga1M/PNDzYJGjWEOinRTnqvSg45dbHE4n/WzZmEYkXbPjVapCWgeUT3hBAUnOjYGxXQwRO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jAdqa9dL; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IO7eS0La; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=u4uU9Oge reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBD82ef003774;
	Wed, 11 Dec 2024 09:11:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=9A3ibVPR1w+V6eZHlhc1BIAtxnieH/D3zsW0ayjBXsg=; b=
	jAdqa9dLxWJqfRfH4GLBy0rUdFyCeJDhZEm0GVzTtNRnMxRnI5g9cNYrFnctuMFa
	MKhC8nwsldSf7jdpeyM+CjyNvL7ml5/g/4O3IgODuu4oIaQ2h5TaXZVOs1mucYZ5
	Qmm7+WbWvyApVVKGulOD1xtKpf4I7ie3V+Ztl9rS7j1qUgw9OvF+2yhG/JZ5KwRV
	DjUNFZ/0TAW3Y9ouONkjMRtxwwJ7wDY1MVdVH4b3NC/t3NLvZfxPBnTrLv5qbIIp
	63vAZeAzl18xkYCLRMizZVtvxo6329sI61TXX29z9LbWbVTt90ab7pX9mpYobooT
	7qFKfqZDi8tGObFODHydGQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 43fa6rheq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1733937097; bh=9A3ibVPR1w+V6eZHlhc1BIAtxnieH/D3zsW0ayjBXsg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IO7eS0LaETa4RIeuOyf4cJprRWmBgAeqwyo/TWmT3YjIOyfwK8NbvYtHz3WNBZRK/
	 Y9ZCRZ5fMpqFWUOCax2WqP+HjXYAgWT0QDkSivEShSxhbVOxrJUPIDoldKhE0MwEZv
	 y1jD+SyeHfVWpVhZhvdjNCiTKohK9I3hwoIupBRvLUjBjqARdD+kpXl1IS09+lngXn
	 zIPZcZXS9QPbm79Wpl5B7C3Teem8FwTCxL1BpeQIOKfiviXhhQfNjYEysjNWagCvzm
	 SyooPGUdMwmvoBvyxeNBOnapueNvDGmccIGsSVx/FdYP3ze/DoRS9KNG+v+lBGYY+a
	 oDuD4EYgpAttA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 06DCE4059B;
	Wed, 11 Dec 2024 17:11:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C4A5EA008A;
	Wed, 11 Dec 2024 17:11:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=u4uU9Oge;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 836E44035A;
	Wed, 11 Dec 2024 17:11:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlA7FSVzbZvoa3ZpQZZ7g7udeOkctEk7Ep14e1IYzSFg08NAhhDZ4EfH3c9ZeJrXEoOfsaJgVAJk8r1A8L9tiasq1rIAM21MTu67qCQCC1tTAQZaBuliJcUonj6iRj0JTSQAbAdLEmP0nuXexNQD5RmIT86ZHmrZlNoT/wC4Gt+ULU4jx1WvOTxkb0z/IKpqbXrCq2G5eOqTyjM8WP4bO+WdLBtDGFX8YSNJ6lvgMBD9GtO7NXnUDYB7+Fa5MYGwmphSaoM/r0tnzuesMvtyL7BDzkjnP5yDW8Z2PqCmCniqVq5Z6Zwww+Dl7dtrgput1L4uAkq2Lp4wERE3NCoCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9A3ibVPR1w+V6eZHlhc1BIAtxnieH/D3zsW0ayjBXsg=;
 b=DzpMIdiBqEUMzbF1eDt1nXlwj76J6kT4PrXwBB6EcYU9LJudygMJyMvJeSPSY3geHY2t+o6TCH9Jt3e173N+9cpS/2eQpAcq25SWSr0ce6RS9vpgMbEgoatJC8RNBmhbIzXkJ9nP8mJmtWeXVM3TxDvbHr+xmtrXMzpGIvjjN0Bpm5ZS/tZlqUfXh7TeVIeJxu7vVyrNVh/tcOS28b8jkC6OLtKvQcUq8gkmriAIba4/pIUNJbQ+IdFo0kC61uaFJj1ORFymcoduvy05NyYvSCQA5/eBSifQrkKzGIRca48otI82fypIztySyC/+E+K5az6gGkhea9uBMAIsa2c8cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A3ibVPR1w+V6eZHlhc1BIAtxnieH/D3zsW0ayjBXsg=;
 b=u4uU9OgeuxsQJhcQkZnulTaIaVWj48tlHNe+gVjWKhtiZOPivmQU6uxVvEvMKJQRUxJ5LHySmjNLVjUNGn5f0HrJKK9l5Cr5z5Y+EtFsrddXhzpFHoW4XV7ey6q9ecCWATpJHnWmfBKEuPPewnengQNfDtU95VeYnGObmrGDweY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7729.namprd12.prod.outlook.com (2603:10b6:930:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Wed, 11 Dec
 2024 17:11:30 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 17:11:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Homura Akemi <a1134123566@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 00/28] usb: gadget: f_tcm: Enhance UASP driver
Thread-Topic: [PATCH v3 00/28] usb: gadget: f_tcm: Enhance UASP driver
Thread-Index: AQHbS2QFjUURmKlzgkWNYg6lxVUSiLLg3AIAgABskIA=
Date: Wed, 11 Dec 2024 17:11:30 +0000
Message-ID: <20241211171111.zsi3rkvkxy3gpnhc@synopsys.com>
References: <cover.1733876548.git.Thinh.Nguyen@synopsys.com>
 <2024121147-hamburger-enforced-5db3@gregkh>
In-Reply-To: <2024121147-hamburger-enforced-5db3@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7729:EE_
x-ms-office365-filtering-correlation-id: 7e4d8977-c9a7-4fca-3d9d-08dd1a06daf9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elRTVXF0UmYrd0VlTHhjMnZ1TXFvdGxsMjRLNzBLZ0NaYTdUMitCZEp3ZjA3?=
 =?utf-8?B?WHNQaDA4K1JkajRUZ3VrdkVSN21NOU1rMjZXT2NEVCtlTElXa2pGc3FEOTJn?=
 =?utf-8?B?L205ZUQ1Z3kxdWJkenIxK1NVTTZzbHY2ZkdZN1hXb0xiY25tSWZYY0hKQlVn?=
 =?utf-8?B?NU4vc1RtOS9udVRMRjZ6OG5yOHd2M1pMSTNlTWZ0b1FwenIzbTZrL3RZbmZN?=
 =?utf-8?B?dXJpQ2cvUWp6R0FTSDBKM3pna2wwa3kra1BlRlJFb0lUZmNkeGdHanB1V2dF?=
 =?utf-8?B?cEF0NjBKVTJyY2V2ajR5RmlQWlpsUGFma2Q2d3V3NVBqdVRGYTJtcVJqa3NO?=
 =?utf-8?B?dmhxNTNycVB0eDNOSUQyS0o3WXFyR1c5N2Q5aTNCV3lnRmFMODU0VG9lbmM5?=
 =?utf-8?B?QmViamJZZm5WRy9IVlU1NEhhV0c5MUdjdnlkekh1TXMxSjY3WjkyY0FYRVJz?=
 =?utf-8?B?d0dKajkrdXkwZnY1L3Uyd0YwTjlrVk4ydFNPZlNZQ05aT0s3YU5OalZCMGxU?=
 =?utf-8?B?VkY1SmI3SWdFOVFWSGFac3J4S2ZmYjlOZWFxSnhMYUNtUUE4R2k5aTBWTHpY?=
 =?utf-8?B?ZS9XRllqLzArODhMRElKTWJLbm1DZHpMT1J0S3FEUWlJZlpRU0FnVEtNOFpP?=
 =?utf-8?B?RndMNEZaOEZ2WUFLMTMvVmJZblBaYnRKT0h0WTF4cURmT3dPd0c0eHFScWpj?=
 =?utf-8?B?bTBTdXp1dENPSGgxTDhlN1NEdXg4a2poR3czUkJPVGQrOXBzOE1HZ1FDNzZF?=
 =?utf-8?B?U096QUFjdkZOMHhreDRwK2Q1SnFqSWlTUHI3RFZLb0Z6cWh3MENNZVR6bk9z?=
 =?utf-8?B?enRnOUpLWUtETlN6Yjl6bEt6SGJhVHNQY0RucjBjdmdwRG84enk4Z3I5aWM1?=
 =?utf-8?B?Qm9WL09BejMxd1B2S1hnaG9mRVdiVk11WUZDdXFub3U5cXc5TnFWcFBrMkNQ?=
 =?utf-8?B?QmloeHc4ZS9WRzhSQWZtVjJxeWg3dlJFS21lNlRoaGJPc0ZWTENYeU9Id2F3?=
 =?utf-8?B?cnhEdFc1NVd0RERraUt6WXhtajIrTStXdFNUOTM0bE9pN2VZeGsybWkrUEVs?=
 =?utf-8?B?YjIwQWR3U05LVm0wdktZcDZBVkZpd3ZIcVlJQlROeDJqSmZEcW5KN3lmRzBj?=
 =?utf-8?B?QytsSFJHTGdlVGVzUnU3aVl4S3k3bDF5OTZNbFhoRWpSRlNBZHFFYWw3Wk94?=
 =?utf-8?B?VzliNkU5cisrcG1weVYwVldpRmk1cU5hdEtscHUzNm1DM2hETmMzZ3FyZHVW?=
 =?utf-8?B?ZWUrVXZ1a2hIeXMrcmlnaHc0N2VFMDIrZjJzTDNvSGhEOW5WMTBaVGZySkpa?=
 =?utf-8?B?eTRwZUJuZFYzMGNYVXJiUGMxbTc3Q0NFWWlIb0NjZU03Zy9rd2hOVE96UmVm?=
 =?utf-8?B?ZE9yYnBJMkhFb1kwNHBOek9va2NqNWdRM0pmNjU2aUJ4Nkkvb2pUQUtRQUI1?=
 =?utf-8?B?ZEtaZHUyMkFHZnV0d1JhS1QvbHd5dTlQWTBzZWRIN3NOTm5FSm4zMk84OXNF?=
 =?utf-8?B?M3NXTnh6WTlINVVjNHdiYXZ3WWtTVDlnVjlpbXZQQjhJekE4VkxVT3R5Sysr?=
 =?utf-8?B?RGdWbjBGUHFKc3E0U2NCZ1lGd1NwUUIvV0h1QVZsSk53eCtkK0VzMjF5aUxN?=
 =?utf-8?B?bElnMGdsRHFycEYrQUVIUE83ZGQ5UHpHM1AxK2VJUWh4U3B2akFhcGdmeXZJ?=
 =?utf-8?B?MVYwWjBvbUUzNnRPc3N3anF2UUJVZktORXRvOTBOQUQzZWg4eUdRODFlN3Vn?=
 =?utf-8?B?UUlDVUJJYjFwTWVEUTdGejhHRFBHaFJBMzNLdVpWTWpDTmtGYjN6bUlMT0k4?=
 =?utf-8?B?WFU4WUhJVzdxaDg5RlFmZ3luajROUm9SdTdhV1hBMTUrY29CNUVvSGtsT0h1?=
 =?utf-8?B?d0RVRHQ0ZVJHSFJVMHlGVVpsYnZQbjlIYzNGY1ZrN2lXOEE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVV2N2dETkl2cit0cHNaVlhMZks1U3RCQkV0UnB4ZllLUzZJZ2xZaVFSSmlo?=
 =?utf-8?B?eUdrK2tSdGRCZFN3YXl4S3NxVFhhR0JYcDNRN1FIWnNqaWJ2amNEWkJCaUFH?=
 =?utf-8?B?Rk1DYWluWmlZMktjcDBBeXFPNDMzbDAvcldNcE1UY1N0b2ZuN0lCZXcwMFFn?=
 =?utf-8?B?UzVnVjNnYTlJQjJ5YVFrR05tZTBsbVdhZXNyWVJNWElGWFNaaE5aUHNNMDlJ?=
 =?utf-8?B?R1BsWXJaNUNuSEZhRmt3a1N0MlZKYUtRTzlaaHJtNzVaSHRSUy80c2RKNmFZ?=
 =?utf-8?B?M09uMDFKYjJFcExUbWV1V0VQSVoyTFc5a0ttN0thbkQ1dkhsU0N5WVRiNzlE?=
 =?utf-8?B?anJIY0JuU0puR013TTRWSGJyeS9WdFpTNThWK0dBZzVSWFN4TVM1OFkvaHJ6?=
 =?utf-8?B?ZVArelN2VjdYM0l1SkwyZ0h4VkxBSVpRRDFydVF5SzEwZlFxdVBwcTNIbGRk?=
 =?utf-8?B?RHFVRmxLQWszdURpU1doYjRJMzBQOG1TdUphS29lQjQxTHMxc21Yb3JvaXNn?=
 =?utf-8?B?aEtKellPclB5VTUxcERqQTNjTEhyNEQyRTBlVTNWM3hOc1JhS1NZeUNUS0Zm?=
 =?utf-8?B?OEhPSTdTWHdhVm42cXhMTkxMUlNOelY3OC9aZ2MvT3A5bWFBbk5uc0RWb2ts?=
 =?utf-8?B?MXRMZkNrK2orV1JybUd0cXFwWCszMFM2QW1SVnQrTmRoQWIxRUxnSHNBU0V4?=
 =?utf-8?B?OXpsRkhxZUZRL2FqZzNnOGFoRlpjMUZUWWdrdjBkRVlHMjlrZFUvUHp4S2FY?=
 =?utf-8?B?Nzd5NHJuTEZEeW5IWTJZWUtoejRoWm1ESjV3VE42eUk2MEl2Yk9yS21udXBP?=
 =?utf-8?B?bG9hbWpSd05tVWtLcEpjSW16V1VqTG5NYm8rdFBaSUN2SmYyRXNvZ1ZoSGpM?=
 =?utf-8?B?cG5DVlhiNFpFOXZUaHJzTWlpMGlMbGVrbXorQUVQMWErVXUyTzVZVmJKOVhC?=
 =?utf-8?B?V0tabzcxZ1JTclEyRnhVRmNYK1p5UjhQQjFDaXNGQVcxcFhKa0RrYVRpcFYy?=
 =?utf-8?B?TzFSbGQzRFJPWVRTRXZueXg1K3oySUtxRStqdGhLUFhVV2pLSzJ2Z2IzSlll?=
 =?utf-8?B?djR0dzVIZmFJUU1IQ29NekdsM1FGaEZ1MTB3QkdhTlEwbmRBVGpubVN0TGs1?=
 =?utf-8?B?d1V6cWVaTWM5cmltb2RaVGV6dkEzWHJJZlowT0orT3IvWlhlQS9Rbm8wZlhP?=
 =?utf-8?B?UkRCOVJzdG9UdmtrbTIrZTc1eFRHdGhzN1c2aGZWL3EwTkl3SHdGcUdKRUxw?=
 =?utf-8?B?ZGVKMlg4Um8xNjZZbG1YZWU5eWMrRjVhWWUvNWRUd09nTk1hT0kzTCtELy9w?=
 =?utf-8?B?d0RHWDNzNG0wK1Zqdkl6ZWI1UjdRRUxjR3dhNmRlUXJBNzlBWXJCRTZyUEJo?=
 =?utf-8?B?YnNzZEtNZExUNmptOGEzQVl1aUJkRzN6Ry9NUjJQL1hoaFZqOGVFdHBleWZ3?=
 =?utf-8?B?MGNSRklWNnB3SkxUZ0J6eGpOTytkMjljWHYvNS9FSVZ2N0p3R0pqUFo0cldi?=
 =?utf-8?B?a0hmNHd4Rm5vTHRhckllYUdFTTNIN0lrT2h6M2VxQUhvTkhzemp1NlVhWVc2?=
 =?utf-8?B?Z2NnbjQ0bldwRTBBK2g4T1A0dy9oS2laV20ydSt4emhDQnhqR21rSDQ5bkQy?=
 =?utf-8?B?TlYvdURTL2JLZitZQVExQ1ZKQkk4SWN6UjFQNFRESE5lUjNva0RXcUdxblpR?=
 =?utf-8?B?MDRRZTlnVzZ4dnlSbTh3b3dLaUtnTTBZQ3VRYkJSNnVScTdhQWcrMDZhd2Y4?=
 =?utf-8?B?UDFCMWRPd3ZMNlNsZHN3MlNhaHloRU1vMktWVHRMR0VCQUJucmhMMmhlSlBT?=
 =?utf-8?B?Y243TEZuWitjN2RFaDVQUDBKdldwMVlDVkJSZGxQc3VUN3U2RXM0cXJJcEhx?=
 =?utf-8?B?dythOEZPbjlYYjdHTWc4NEE2alhER3M1MmlmMWJnZTRNRnAxVWN1TC9jdzRm?=
 =?utf-8?B?aGRRRk1yUXhER2E2dFYrTkJDZFVRNlNCdDMxZnBDR1Zja2ltSHU4ZEFSQndi?=
 =?utf-8?B?SGNHdjlkN1VhUnY5YmRhdTJpZ3dyaE1DRy9PejNMVlZsVVRQRXB3UVhBMjd0?=
 =?utf-8?B?TnoxQ0pneWs4Z0plT1JGTHFmc1hVa3hZcG1sUmF6ekZodXVOai85ZWVDd0lk?=
 =?utf-8?B?QkFLcXkrajBnNi9ybXpKYkc4MTNKanUyTGJ5WkFhTFB4eTVIY3dMNDIzc1NW?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7A6E6C7710AA44A92EB9786C86D483E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yjvqj7fhSYZOJezoIel1B4gE7NqkbzfOb97X0tovMYY715PpisVG5kPnIjEe2AQfmt7aOLpSBmcy9zkFG5z3impe61875s82fxKDiUJze1wqDoQ6k9KiYnJfYz2nW4KaSUKN7IqGQD6yFZETq+oKTVtuegDOL+xvfYxCTQu9Dh64CyVuUzTQY6X6wdr611+rwhVnJZqJQnY83gvh/NTcDOvy4QVGxS9wUZONg1xUgJAQYl418RowytW9SWtnuBAkUlHSJUbwaAXyQmZ1iIgPTE2SEFAvzWVaq3fI5WqsY7dP5mz9qD/RDqO03cEtUdGWsnoqXfv41iduQ0DBwMoXIb/GwyjSQHCwikc7TDtBwq3Z0T8d1B3t0biIGhWKL4nA1csKgaUZdNBMBLZSFcVugT0kAHIp9CBvN0WecBACp2JdBzXoIM92tZuD73zBfGJcQD6hWDtL/OZ8CRiZo2i8tU3O+EC1JSLtKpzU6UPYzfSzsSSkPLHQA34HLmbbd8XiOtH8Urf04QZ54dHjFjxSL5AQmEgDO4rg+5882NCyQ+Vqe3U4ssCZKQgtxtwUY+fmHkzk7la81OiJBfm7hBeeWYz5rVrX73Pjyc+mcZ8LwMNdgzEEDdigYoRfgQyf1WpwYPBNGo9ILt2istyibPSnPg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4d8977-c9a7-4fca-3d9d-08dd1a06daf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 17:11:30.1833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VEitCStNCm4PoVkVbr1DdcjTJkSf6uzM4EQsiarmfiQ+Pozt4srpZzYojF9nVnZ3lpcAe6dUkBUNk5mv6Q17A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7729
X-Proofpoint-ORIG-GUID: jM0L2BBpbg_Aq8O48NcGi7fzu1IklXc7
X-Proofpoint-GUID: jM0L2BBpbg_Aq8O48NcGi7fzu1IklXc7
X-Authority-Analysis: v=2.4 cv=TPa/S0la c=1 sm=1 tr=0 ts=6759c7ca cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RZcAm9yDv7YA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=RKJp2XKWpsN_0knlBG0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=491
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412110124

SGkgR3JlZywNCg0KT24gV2VkLCBEZWMgMTEsIDIwMjQsIEdyZWcgS3JvYWgtSGFydG1hbiB3cm90
ZToNCj4gT24gV2VkLCBEZWMgMTEsIDIwMjQgYXQgMTI6MzE6MzBBTSArMDAwMCwgVGhpbmggTmd1
eWVuIHdyb3RlOg0KPiA+IEFwb2xvZ2llcyBmb3IgdGhlIGRlbGF5OyBhZnRlciB0d28geWVhcnMg
YW5kIG11bHRpcGxlIHJlcXVlc3RzIHRvIHJlc3VtZSB0aGlzDQo+ID4gc2VyaWVzLCBJIHNxdWVl
emVkIHNvbWUgdGltZSB0byBwdXNoIGFuIHVwZGF0ZS4gVGhpcyBzZXJpZXMgYXBwbGllcyBvbiB0
b3Agb2YNCj4gPiBHcmVnJ3MgdXNiLXRlc3RpbmcgYnJhbmNoLg0KPiA+IA0KPiA+IElmIHBvc3Np
YmxlLCBwbGVhc2UgaGVscCB0ZXN0IHRoaXMgc2VyaWVzIGFuZCBnZXQgdGhpcyBtZXJnZWQgYXMg
bXkgcmVzb3VyY2VzDQo+ID4gYXJlIG5pbCBmb3IgdGhpcyB3b3JrLg0KPiANCj4gWW91IGhhdmUg
bWFueSBidWdmaXhlcyBpbiB0aGUgZmlyc3QgZmV3IGNvbW1pdHMgb2YgdGhpcyBzZXJpZXMsIGJ1
dCBpZiBJDQo+IGFwcGx5IHRoZSB3aG9sZSBzZXJpZXMsIHRob3NlIHdpbGwgbm90IGdldCBpbnRv
IExpbnVzJ3MgdHJlZSB1bnRpbA0KPiA2LjE0LXJjMS4gIElzIHRoYXQgb2sgb3Igc2hvdWxkIHRo
ZXkgZ28gc2VwYXJhdGVseSBpbnRvIDYuMTMtZmluYWwgbm93Pw0KPiANCg0KWWVzLCBpdCBzaG91
bGQgYmUgb2sgZm9yIGFsbCBvZiB0aGVzZSB0byBsYW5kIGluIDYuMTQtcmMxLiBXaXRoIGp1c3Qg
dGhlDQpmaXggY2hhbmdlcyBpbiB0aGlzIHNlcmllcyB3aWxsIG5vdCBtYWtlIGZfdGNtIGFueSBt
b3JlIHVzYWJsZSBiZWNhdXNlDQpvZiBpbnRlcm9wYWJpbGl0eSBhbmQgcGVyZm9ybWFuY2UgaXNz
dWVzLiBJTUhPLCBhZGRpbmcgdGhlIGVudGlyZSBzZXJpZXMNCmluIHlvdXIgbmV4dCBicmFuY2gg
d291bGQgYWxsb3cgbW9yZSBwZW9wbGUgdG8gcnVuIHByb3BlciB0ZXN0cy4NClNwbGl0dGluZyB0
aGlzIG1lYW5zIGZvciBhIGZldyB3ZWVrcywgdW50aWwgYSByZWJhc2UsIG5laXRoZXIgdGhlDQp1
c2ItbGludXMgYnJhbmNoIG9yIHRoZSB1c2ItdGVzdGluZyBicmFuY2ggd291bGQgaGF2ZSBhIHBy
b3BlciB3b3JraW5nDQpVQVNQIGRyaXZlci4NCg0KVGhhbmtzLA0KVGhpbmgNCg==

