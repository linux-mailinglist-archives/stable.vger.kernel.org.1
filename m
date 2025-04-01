Return-Path: <stable+bounces-127366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF6BA7854E
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 01:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494EC18878F4
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 23:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4980E214A66;
	Tue,  1 Apr 2025 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Qa7x2ug2";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LDzck6sM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mTXEtgTn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1523B1EB1AE;
	Tue,  1 Apr 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743551011; cv=fail; b=IAeoRusrKmEl6tsOnUQWfC50jzPu8FqrKxly0fazafZQjqcbO0Gr8s2vxnl+tBl11KXUcsKpZlish1d7oPQ4efTxNqgo9/PTtVpzH02GNwCPaOTJnLqHm6LLXxGlLjSBvAMSp62jh67TJa4nV6oDzem220CcRt/P0ygrb9IwFaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743551011; c=relaxed/simple;
	bh=ur+HA9kKgzCAry0SPvlltlb7Qv2yg0LaShgH311dxbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DdqW2OLlqeyz3s90k1w7qqyBIKRsCzqp/smxQye+tEECbLFFtkVNxMW0R63fLNjcBxkztzibGUTMtAeWYaQcgEH8ioDzO2oeh8ZdwF6LtYolRbsHvoEBJY7czpNlk/sdEgQ9cCOo/a9Der9cyouSdwckxCsW+liBXr5HugAdAa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Qa7x2ug2; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LDzck6sM; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mTXEtgTn reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531IlQqO012524;
	Tue, 1 Apr 2025 16:43:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ur+HA9kKgzCAry0SPvlltlb7Qv2yg0LaShgH311dxbw=; b=
	Qa7x2ug2VxAyEZmjJYwSc3J1I6O69rfpquiWLMvH1Fr2tykfdaWrccdq0XLqoszJ
	aoRXpE37j7jHpdiU9S8Pev00EKh4xLy9ju9gt0CyzsH/RH1UMDUZjGGkD5Q0E5R1
	aH1YkxjPUWFF1bRa6p3b5J2Tyk5OuV1R/SFdEmr0/7YZlFoygKSpxHZBwgOR50zY
	3YqqCMRvaiSdzI/HQpDu61RqDPndK8JcitvHpUgkCX3LYUqtcsljPxrRYfJHsi0G
	iRzuGOZBhp5vZSsxh5Kldma+zmpxvATTbkUGhw/k6dkWXNjdPfDSWeq0qld5LmwU
	nVOTcHAedj4kcfwY0f8LoQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 45pfsw7r16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 16:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1743551001; bh=ur+HA9kKgzCAry0SPvlltlb7Qv2yg0LaShgH311dxbw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LDzck6sMUfUQMKRxbSmFNvHt6UNsNOrDkFfxuebcoKjFj4InHbCXoSAJDAWpQGKZ+
	 g+ava2ZXRPN+xwrZgDbBm1VCXec3I4wkUCcuAaVAF6ngdO46X6BNE7oBXEAkWbqDng
	 vyOpqPdwwBYBlY1LiE1I/f92m0MBHPRkhEwODnvf6Uh0RxVhNV3J7W3k6S0uDf3Xq1
	 2TRutbHcqE9MmlJ6Zpn5GQdx9YEyhLGrMWnBIqHO5eVd+z+RUzX4ArrHDKZ1/7skws
	 XwFqYNsG9FK/k+OvttGrQpiMq8SZUv/lImrCdbb+htFduwj7PU7bttcuLolI5k9S80
	 Pcf2rUOAis9xA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C06944034A;
	Tue,  1 Apr 2025 23:43:20 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A17A1A007A;
	Tue,  1 Apr 2025 23:43:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=mTXEtgTn;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7FDDA4048E;
	Tue,  1 Apr 2025 23:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfSkoFFVUWULcTKKWbRbvxH5ElqNvtzn98RjDA6WFWI7XF+NxpzvdlWKUj8Dt++MORF5/KKOhvBulrNo1y4BjojvgRzDvQ+XNgHEhxpNTR4rWjcrI9ssZU0m6DjZnM6Vuy91d+Zf5c0klnkWww2LavUEX8hnDOpZqxblPCsiPEriFZfC2XbfiyRvRvs/xacpWdkQMJ6XTNtBAqAsnq4g8VV3BmYa+6TJNliHG0xbBTRyVm1ykG97+v/oK/VPFKsb7jvS40vsIvOGN4P+0QGopPlF51Bs626alBpRLd7nHXNNaDgEHxNdX/oajaqOp5lTNSotp1pq/JMMzOnoRanakw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur+HA9kKgzCAry0SPvlltlb7Qv2yg0LaShgH311dxbw=;
 b=q90VspUTB8epCAJG7o8FQZBHILYsnbju5z5PFIx45IjglmG0EXbXvMJXV4BVI9YyM/MQoxsviCr4H4/iWjJ5Lh8taxGDQm9quXFngoVmIrKjxALfTps0WmkUOhtQ/m5ZsvjDy/6EdHZpxXx41dZjBDfKrbEJmCKjzNw3JJ1KlTsHX6wVK8LxfawvNrcYME58eg93/SA5lDYTv14E9qsuFY3dc20LDFHYp6/NveE4nsynbxZ0bWsBNtUfQML5Vb5bAw44CIrJjedjKxuprLTfWDoKtOjG6FftsZ4K1CqRynxa0unY6/1D4z9MQ8u+P2EY3Vv4lkO3mC2y0k2vPX49/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur+HA9kKgzCAry0SPvlltlb7Qv2yg0LaShgH311dxbw=;
 b=mTXEtgTn5cr+0BDYFlKi1zBG8x0gxIGCWLxPyg6Gt6peKIKGRT9F3YOXOrEW3uefRFbj63GghFveBTxEpbydsDOdDIL/IuNzwo0LozXB7Y3Zs+sHhBeCrcbWPS1lPCV81/IfCGx5UFDQvjw6qQX/+FdHyXCnM0qCo3ncNn3FJHY=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 23:43:15 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 23:43:15 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frode Isaksen <fisaksen@baylibre.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krishna.kurapati@oss.qualcomm.com" <krishna.kurapati@oss.qualcomm.com>,
        Frode Isaksen <frode@meta.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Topic: [PATCH v2] usb: dwc3: gadget: check that event count does not
 exceed event buffer length
Thread-Index: AQHbowUwq7ilQa/t40GzU88Uu688NbOPeZ2A
Date: Tue, 1 Apr 2025 23:43:15 +0000
Message-ID: <20250401234311.nf5f4nomu6w5wwts@synopsys.com>
References: <20250401125350.221910-1-fisaksen@baylibre.com>
In-Reply-To: <20250401125350.221910-1-fisaksen@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB9046:EE_
x-ms-office365-filtering-correlation-id: 37c6e33e-b11a-47fa-60cf-08dd7176f8ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2JOVjUvRGFlSmRsd2w2SDd5NGZyRElmTE9RU09MT0FtUm1PdTFPREticXcw?=
 =?utf-8?B?d29PcHNid0xEYXliSXROblZiUmZNZzRhNXhKY1dHemNHVUd3enV6Q1dValc2?=
 =?utf-8?B?VTNIbmNQbjFrb0FpeHhNK1ZwYmRGeFdEaDlwWjVLYitUTG1UNlhicFkzWis4?=
 =?utf-8?B?TnY1MnJML1Z4ZmdsUzVVakphUzhrZkZhZUdsRm5IL29GUHdCWVhpa1FxcjZw?=
 =?utf-8?B?eFZpa1dwNEZVVHk1Y0Vqc2YyY1JzODBsWGV6V3lrMk5oOEpEY1hEUU52a3VL?=
 =?utf-8?B?RmhKejMvRmk3enB0VnAxRDRlTFVWVm83Vkw3eVZGTkJtUUc3eXUyR2pUdkF6?=
 =?utf-8?B?NWx5QUVGNTNPVW5HbS9BMVV3dlVUTk1GMThNaEU0TXl4VXVxc2tWTTBYM3Qw?=
 =?utf-8?B?YjgwMy9ZODRQMVBWb0I0c2h1QURaYTdGbnFNY0YrdE9EZjlwRDJTZDFOUEl4?=
 =?utf-8?B?Njlkc3F1azRkU2pMd1kxeUlIenBKSjR0WFo5dHVzdEJ3MUpuUVhCZ0ZMTDFi?=
 =?utf-8?B?YXdJRnF0U0U2aHB6L2N6ZlNLRWxuWTB5QUtwK0FJUzBJc1NzeW9WYm4vZm5z?=
 =?utf-8?B?WkVpZnRXeGdLZURabWlBcUduUmxYZDR2TXR0S3B5USs2bnRweENGRmczakUw?=
 =?utf-8?B?T0ZBVnViRVU2NmQ0Umhmd0NWa21BaVBHRlE0c1htdFFqZ0JMT0E5MFlKS3Y1?=
 =?utf-8?B?dHUvejRkdDc3Mnltd2E3dENSM3BOT2Y5NUp2WXJXWk5LRk5iMjFWZnlHdjhP?=
 =?utf-8?B?VDlUTytXT2c5TjM0N3hZZjZwQmtUSFQ2R1pFU0JsYnl6N2s4MEFHUFpva1ZR?=
 =?utf-8?B?aS93enJKSUIveTllMHNCcVNMVVJCanc3UmhiNnQvQm5US041KytEZzlUOU5J?=
 =?utf-8?B?STl0RTZtYzdmMjJVbXA5NUhZaS9pZW8yYTVJTDQzMENLLzdrR0E0K0h2ZDBj?=
 =?utf-8?B?aHNydXNXUFlXMm5wY3NrUGJRMUx4WUlqRzRXeEx6S3ZwakNyS29ZZWl1S3Mv?=
 =?utf-8?B?YzU4TjFGRzBaRnd0aGhvRzJGSWR4ZjVRTm1CbC9hYlZIMDNYQjBGNGJPWFZ3?=
 =?utf-8?B?MTgvY1RGdnVSU0NCTnQ5R1BJemhSc01kbm13QUJuUUh4NWRLVkRBeTZxU3Ey?=
 =?utf-8?B?bFd6TUczbnI2eEtpRlB6RS9NMXJxWlozdXJYbDZRaHgvUDFOa0o0OXV3bnZo?=
 =?utf-8?B?WHMzeksyRit4WHF4V2ZKRm41RkFCbElnOWJXbHY5SjNpc1NtTER6K0VkNnl5?=
 =?utf-8?B?cy9PM01UNkl2Q2xQa1JOd2hYU0N6ZmR6ZXhSSUNzRlpYTUFZdi9aQ0hpclgr?=
 =?utf-8?B?Mkxsb2orSTFxVFFOYzl4TGlMUG9IbUhuVnBaY3JqZktTMUd6SEl6SFRTamVM?=
 =?utf-8?B?SWxnM2k0Qi9VNmtSVE05WEREOVhtTjI2SGd5VVJFd2JlT3lTV21GcjRyNW9R?=
 =?utf-8?B?UGtJTGtuNFBqWUx3ckpCRU9Qc2NFOWxFUXBwSGF4YjJDS1dxNHJodkJKcVBH?=
 =?utf-8?B?RHdaeWZpVUJla3k4YnRLdks0WlZxbkdvVHZOenFtbnErZjJqZ3FzWmpxZTll?=
 =?utf-8?B?Q2N2c2FlbnNDajBQOHRYZFQzaGcxQXhvNEJ5c20yTjY5SlczYlB4Q2h3Z0Y0?=
 =?utf-8?B?YnJLUjJRV0tIaG1BQ0V5OGp1cCs0YWtCcWx3OWE1SlQ3NVlTQmp0WDhsNUZ0?=
 =?utf-8?B?ckFKSDdhcG0zb1BnTnZrU21aVnh1ejA3a1IydFprS0RBS2pjMUh6c3ArQU1v?=
 =?utf-8?B?TzdjbjlMVTBzZzBTeCtxaHZsQjVNQ0tQWVJYYi9JUlBSMnREeHRkMXJFU3pF?=
 =?utf-8?B?NE92b1Q0MmNIdzdKdmVjcjdmTFBFcE1kbFExM0JoVGVRTE83YlJ0ZW5NSk1x?=
 =?utf-8?B?Y3l2L2ZZRFJRSGZuRU14b2JFTFhFT1p4MXIvRHNrWFJSY3BBWGt3Z0hHbHBj?=
 =?utf-8?Q?vkjebjpl584kK34e0Nde6VyrvZCW6PCA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFFvaGZQU3UxUU5CeFd5NVhEc1cwa0tTZWVHRWhKd1k4RUJCU2doNmFyKzdt?=
 =?utf-8?B?aUlLWGthUnEreTc0dzNHSTl3dnhVRTBaSzlodDY5SEpwVWQ0aEZkMXNrN3BE?=
 =?utf-8?B?azlkN1kvUjEzRnVCNWxxRlBHR1A1RDZ6eEdvWFUwcUN5YkpLbnJxN04vNUlN?=
 =?utf-8?B?VDBWakM4WDgrTjRFaEpVT3kyZWlTcnJaRnZzYkprSXVEcVBZd2R4Qnc5OTJz?=
 =?utf-8?B?NTA2SHBDcnY2Sm53dXIrMWp6MmFrYWwyc0VuRUZxUHBadWlLV0JvQWU5d2RJ?=
 =?utf-8?B?Rnd6R0ZKMUI3NUFPZStIV25lMkwxT2RUMEdrL0t6cUo4d2RqS256YlpZYTg5?=
 =?utf-8?B?STc4RWFBNVNmL3Y2NWtybVJhRkhjcUJrb3FjYXR0ZG5QZ3FnTU5iUEhESmhC?=
 =?utf-8?B?UTZWZVI3d280TlgrODJsYngzU2M1Wk9yOFV4aE1Md1g5Nkc1elhoQzVWUUVv?=
 =?utf-8?B?a3pZcFd5a1R2dDdNVlhXaVpMWisraTJ1TGI1a1FoMDZsTGdaVTZSYU4yMDAr?=
 =?utf-8?B?SzBvNVM4d0ZpMkJMSm45QjNRQzZZSFZjWjRQSERVVE9mY2I5Y3lybnFaL3lZ?=
 =?utf-8?B?K1JHUyt5eHNtWjAzdFBVRjdkSzJ3bzJ5ZVE5SWd6aXB0NGg1SEVXcDZuR1Fm?=
 =?utf-8?B?QzljSkVKZ0I2dTZmUjdudE5BOEF2OFdjcmFmSGpOWStwamtlN3pPY0pEVGFW?=
 =?utf-8?B?NlhJcW9IdEgySVFaYWNYcFlwd3ZrcklOVFRHZWsvM3lmbHZlZmdVYWdJWGNQ?=
 =?utf-8?B?NU5UR3FKWmUzNldpNUx1SWk0R3JOUGw1NkRWN2dTdnpncS9OWE1MK0pZTTIy?=
 =?utf-8?B?S3EzY0pSWWJBUWJHVjAzWDNSaVdIT2ZaR1B2K0xyWURTb2U2aFZURjhnbGhw?=
 =?utf-8?B?bWFCb2ZwSDcvRmt4RWh6M25ZN0xUejBtajVOTEl2c2NuVVVJR01RalBpRk1S?=
 =?utf-8?B?UmRPcWxCOGRuODlNOVNEUmgwVjVxcFk3NkpNZW81VndFQkhjY2JMbkRITDds?=
 =?utf-8?B?ODU0WFZncllXOEp1Y2daT2c0OENWY1FiNlRtV1Z3dWFCS2FsK1NPVVMzZHZ6?=
 =?utf-8?B?d1FYQnpQWDNuRWVaWjlUL2hpN2R1U29WSlRWdWpNaHdnRUFEUUJTQzF6NkEy?=
 =?utf-8?B?ZXJ0SjhTL0FSOTl0M3hkNnk2KzBVUnc3cWtoUzBKUlFvdjNmcXE2dU4wU3hT?=
 =?utf-8?B?MmlTRkQ4MUFFQWNUVjAxcFZPY2o5UW9STVArNWw0dC9RRGcxOG1JUS9PMUw0?=
 =?utf-8?B?VmhGS3NKREFoYVNMZll4dVdUQTg1Qnp3R0Z6dzVOcFFsUVdlUVBmSVJjUlNU?=
 =?utf-8?B?ZHY3ME5RcXpFYS8rVkJma1lqUDBOUWUzUlpRRWhJZkV2ZHdWblo0RFEvcjda?=
 =?utf-8?B?VjJnSHZDMTVQdFB4L3llUUJ2bUNTcy8zc096azRWeElxb2p6ektVWk0zUGtB?=
 =?utf-8?B?aUhzWW1hVFJxSnJDWE0xYytnWHBOZ3BsS0VaVnE3NnhMU1RISHNPeU51aVBy?=
 =?utf-8?B?dDNheFlFOTh0NWRFUDBOLzVCREVOV0FIWXNXYThnU0ZzOTYzMGFReXMyeisr?=
 =?utf-8?B?UkhiZEVEUlhiS0Y0SmtpWVJBaDQ5YVgydkJjTlZ6RXR1Tm1CZzJNaHZyRWMz?=
 =?utf-8?B?djd4eTZGNkN6cXF3cDVPVVFpaU5RbU9nbU95VWxZbFE3L2twdEFlN2tmTDZh?=
 =?utf-8?B?ekxjTUxsYWkvUU5BcjlRTGpselV2dEhtUU9yTkYxZ1lQaEo3T093bnZ1SFNO?=
 =?utf-8?B?UE9GNWw1MERicjh4bVk4RzJ2T1B4UjFaSnVONW5ma3Azbjc1TU1HMUpWK2Zv?=
 =?utf-8?B?VWlqbFo1OFJwQWMrTXo0R2V0UzRHNlovWFQ2emFhUUJORVF3aklSc2YvdzBO?=
 =?utf-8?B?bCtPMzNEaHA4SlVFRTB6a2dlUUpKUXhkaStWNGZ3ME9NeUQ5ZmM5K200SUlj?=
 =?utf-8?B?YnNBZGVMcWxSaTEva2VPZmRIODBrMlI0bmR6SGFQVVVoRWdVTkhJc05NeTd3?=
 =?utf-8?B?OEZoeXRVQUJQVHdBSDkvVGxocHVPMXFGWHdaZ3Z4ZTZmOFVkREhtaGZMYTNY?=
 =?utf-8?B?djZoSlkvcjcvVHhNRm5tNmtvMEtHamVZTzIyTUdHYlZRdngyMFVRY1JDZndS?=
 =?utf-8?Q?FVAWghUdHvLrOLVno2p8fzZ+a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <047EA6602FC31C469A940347D2D2F818@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GL2nSjqFlEFR8KolSQOKdh6Am+44wTWrTXA2I1VFanRB527Pvldexv13VNe4gAaC7MJb6m40Yl+++n7xNk2569u4D5DCylBXZHp6ICLv0pUEsfarzlco5dj28H0Sig8NQ3SGymzqQx55xY3GC09xPIzg1xo7e6ZiuvnwaM5aTDN2WMq6nKpN5KQU5s8lJDkgj6pc+jfgPeMPu59ci+OSAOKAK5vaAz01OYQ2jhkIv0jzvOSK3dJVPQ2tQSYgvgBt0KT9gnBAlpSAmc0OwHdMAWrcI76u2a+StWJK6HHF18xQ1tameB+HGUQaRfRvFqojmMsmO98aYHZ+UVeLNTZ82NiPDxuVwGu2BR70WBrbJ0f/SIqdahxWtQJp4rJ4Ndsu7Uga85d6OlDjdlLy381/dNyxTWozyWr1FXkeZONjHO9F/XeigdaKjC4iCWNTAOsgyTbMtHC5tVRwqMw59Uw0rkgYvRxgbgSm0A6hgYzuQka76HMAwAjbAY7+w8don1UK8nzo4lZR4QxFBY613nK8lzIiv5C5mybALTBjpEAm0n9rp1n7mWcb0MKfk39Km9C5FLWJZLX9NrvwYiHKQqOO+AOIwPZq8/xppUtNE3z5kFMdjZIrNQtjrDBVz0ojrl/EvsOuB2DdKGM9Kv5mH/ZTSA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c6e33e-b11a-47fa-60cf-08dd7176f8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 23:43:15.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZw4w94PwlRUC/dhnTBXNjShggyrYQ9/Kv7orNauPi2RJ6VnzGvREr+xQsHVRPHF5PvXL5Nukn6B+QvnULf73g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
X-Proofpoint-GUID: SU_59QTsvOkj-PJA_ptbNYtoC8z9b_L0
X-Authority-Analysis: v=2.4 cv=F/NXdrhN c=1 sm=1 tr=0 ts=67ec7a1a cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=H5OGdu5hBBwA:10 a=qPHU084jO2kA:10 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=a-4Oi9pBIDeB1OqtASAA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: SU_59QTsvOkj-PJA_ptbNYtoC8z9b_L0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_10,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 mlxlogscore=554 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010146

T24gVHVlLCBBcHIgMDEsIDIwMjUsIEZyb2RlIElzYWtzZW4gd3JvdGU6DQo+IEZyb206IEZyb2Rl
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
DQo+IEZpeGVzOiBlYmJiMmQ1OTM5OGYgKCJ1c2I6IGR3YzM6IGdhZGdldDogdXNlIGV2dC0+Y2Fj
aGUgZm9yIHByb2Nlc3NpbmcgZXZlbnRzIikNCg0KVGhlIGZpeCBzaG91bGQgZ28gYmVmb3JlIHRo
aXMgYW5kIHNpbmNlIHRoZSBiZWdpbm5pbmc6DQoNCjcyMjQ2ZGE0MGYzNyAoInVzYjogSW50cm9k
dWNlIERlc2lnbldhcmUgVVNCMyBEUkQgRHJpdmVyIikNCg0KPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiAtLS0NCj4gdjEtPnYyOiBhZGRlZCBlcnJvciBsb2cNCg0KSXNuJ3QgdGhpcyBz
dXBwb3NlZCB0byBiZSBWMz8NCg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA2
ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+IGluZGV4IDg5YTRkYzhlYmY5NC4uOTIzNzM3Nzc2ZDgyIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0
LmMNCj4gQEAgLTQ1NjQsNiArNDU2NCwxMiBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgZHdjM19jaGVj
a19ldmVudF9idWYoc3RydWN0IGR3YzNfZXZlbnRfYnVmZmVyICpldnQpDQo+ICAJaWYgKCFjb3Vu
dCkNCj4gIAkJcmV0dXJuIElSUV9OT05FOw0KPiAgDQo+ICsJaWYgKGNvdW50ID4gZXZ0LT5sZW5n
dGgpIHsNCj4gKwkJZGV2X2Vycihkd2MtPmRldiwgImludmFsaWQgY291bnQoJXUpID4gZXZ0LT5s
ZW5ndGgoJXUpXG4iLA0KPiArCQkJY291bnQsIGV2dC0+bGVuZ3RoKTsNCj4gKwkJcmV0dXJuIElS
UV9OT05FOw0KPiArCX0NCj4gKw0KPiAgCWV2dC0+Y291bnQgPSBjb3VudDsNCj4gIAlldnQtPmZs
YWdzIHw9IERXQzNfRVZFTlRfUEVORElORzsNCj4gIA0KPiAtLSANCj4gMi40OS4wDQo+IA0KDQo=

