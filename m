Return-Path: <stable+bounces-108163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A44C7A08558
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 03:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95226167776
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ACF18052;
	Fri, 10 Jan 2025 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K1y/WQht";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RUxi2L0b";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SOtf7pEA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570B1FA4;
	Fri, 10 Jan 2025 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736476271; cv=fail; b=irpKnQTFZM5UwxFtYD6NF+c6AMO3/pB25N++F4MzMpe3Qbc61BF5NRnpvJOY71mzNMmSo+ySg3nLkRixuUyrsDIQZmfJklVIdbFLdtVEdDNZVvDuZmlY3uf83vtHmMmD/fgo0P2dfkDY5hGsvHeyxZovqEVrBYnIbNfMknClLpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736476271; c=relaxed/simple;
	bh=wp3AlPhYDFbvhFNTRgDz813kE9y1k8yClifrcYzz980=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kHfuHlxrLqYnPg2Q/SclD2QKjY70Q0ecikw6KtNmfU7MEjPDMMLqfmHGVP5QLW3a7XRHI6ri4anbqJLvNo65DxfKUR3o++lSBQeau2pIKeillaFk4lZ1s+l2lUja1E+0VNMVuopmx5MdGy3YctLa3Dg0/w4+0+YN7Ir0whgBUAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K1y/WQht; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RUxi2L0b; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SOtf7pEA reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509LE5xN008294;
	Thu, 9 Jan 2025 18:31:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=wp3AlPhYDFbvhFNTRgDz813kE9y1k8yClifrcYzz980=; b=
	K1y/WQhthrclMQMMQd8HY3K540YFYOcNB5ccyRlKtiGJliIWRJk7T86fZs8uzJUz
	PxqRAkEJMfGT91SxSU/py3q8iHIB2yT8O3/1bfhlAmlEvg9O0rqwbPj+ve6C9Orv
	6K+6ne+QUvNBoW6AgdvnEBweEGiT0pXUAiS89VE8HOFyi0IiD4uMXV+oXkRX37ZG
	PZgYX/UTEsyzufKcvmONQdlbXIBpzGQVh1SUXJy3GNTGUHCDlaZIZZ22UqqVxZ57
	o9tVOIs/8/53UEo4P6dokDYTkCmL79SBfOYo4RwnR1O0UfGKtsimEqrWh3QemmuA
	l+m+hZ5hrldw6hJKOjeC6Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 442p6hh47v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 18:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1736476259; bh=wp3AlPhYDFbvhFNTRgDz813kE9y1k8yClifrcYzz980=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RUxi2L0buCnye/UxpfpPZLZlNgdiTFRwdMiCYc+8dGSPBFbF2q/7uUUmznz0dDCb4
	 SIP07UTM2Fa9xBkjzlCsiEYzl/5c9KswGkgpi1Qm3jcsx/E57EuNIDqQ+rxl4BVKGO
	 IyT8vb1zvK5E/5MHEzmzYqIokWm5o3mIb5PJfeB7oAlZdOgH5+mRjlHe+iJYUqXPEM
	 N3EME6B4OLabTd4rgrHkro20IMD4eInQfmQehTR2x1IhWtGV5lSvxaoWdGYoECCDjS
	 8AvrAPJ3LeqBUj5L6EgGZF7PqlIrmM6EBVGpSGturRSw3352t4YVfety4QfYI5maox
	 1meVyay/t9B6w==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 79A91405EC;
	Fri, 10 Jan 2025 02:30:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D6D88A00A6;
	Fri, 10 Jan 2025 02:30:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=SOtf7pEA;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id EC48F401D3;
	Fri, 10 Jan 2025 02:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkd3O8fjg6uWIMh9ZZMRiojnwfEcbal40zjqm3IEoTy/hUrKc6dPTJ2nS8pubMjOaF+y/9EYjNbq8aF/Mn3gMlv5jQwGydxWdh0NR/rwY9jy34xVJUdL35mElK+m47J/TMTgCyh8ZC34Tol0e5poDIFyplBwWcT/GfsHpQ+rsqfrYxiZZzLqIMAmYI5zbL/xeV6TZoyuXWsoz1oZ9zDhTr0v5K+aNfW7mxyzmRmJPwGY0LeQZ2JyIEG/Yu8uQ/0V006AajgkFwEk48HlLl7uK2zqOx0gjp9kIZki2mX2Fmh1CUjObLm9Fze8ZfgElKipnIWXdWtxdSyj4E30Mm+wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp3AlPhYDFbvhFNTRgDz813kE9y1k8yClifrcYzz980=;
 b=CoZRaiIwXpaVRdAzFeQVpJUqA6q5frhdZvRS2Dl/XmW9zyFJWGCuOksHvHcGiNNHlgFQXXsvOG6YiAJto3n7nHf8uhV56UTLK8L1UoCaezZUI92ejENF9we66NpyBXcCRIx1tOaouTxEufyILUJ94dEP1TVqR+g9mtTDOnkaU6uhO5yfzpzGDO40z+z59xj52OTESWiY0K/oZ9uuvgF5iRUModVCXe16rxmHbUV2IoU40tkSMu+WIM8ERx10IR6hNg1+ZW+vCVlT1ZQv3NxmPosxrLVKRvgZgzWGXZvVb0CbJ+/gSnTjnZkUMK2T7Y1AjogLuL0kCl6WhBmcpljt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp3AlPhYDFbvhFNTRgDz813kE9y1k8yClifrcYzz980=;
 b=SOtf7pEAl7g9Oszk+46FLp8q0QD9vNJU+yl18fw1QqZKN6OQbwRplCa8Qylm7KwHDDdSjJ6RDztZo6Wv+WCtPbd6wJed8ihqN7u0ohgtdAxceYbdhxIsLdos9oTILGQk+8UpglW5BlYWUGfvESg7BiIzkUXRPc3SOJkxVUNAOJU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 02:30:54 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 02:30:54 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3-am62: Fix an OF node leak in
 phy_syscon_pll_refclk()
Thread-Topic: [PATCH v2] usb: dwc3-am62: Fix an OF node leak in
 phy_syscon_pll_refclk()
Thread-Index: AQHbYivPhJErbgPleEOj2qnApNkELrMPSvsA
Date: Fri, 10 Jan 2025 02:30:53 +0000
Message-ID: <20250110023050.k2d62xjmdtascmol@synopsys.com>
References: <20250109001638.70033-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20250109001638.70033-1-joe@pf.is.s.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA0PR12MB7749:EE_
x-ms-office365-filtering-correlation-id: 649f49be-f855-45db-aa50-08dd311ece90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFZuV0pPd2RqRy93QllhNjhvZ2RSYjlHcEJyU0hka0tZdzV6dFZUSDZtNFpW?=
 =?utf-8?B?Yk5HV3V1NjhHcGhIQTZXbjlKalhuYXU1Vnk3Ykc1WWZ5VjdGT3NSNWp2cmJt?=
 =?utf-8?B?cXRRNThFcTR5c3R1UHk1cFpnTDhGNERQaDdLdjhyVUtpRHIrOHpmNEMzQWd6?=
 =?utf-8?B?am9XK2tWeXRNa0JhODZJaUErUE9ST2VhZ3YybzNhRWRsK2tmY3ZTai83OW5T?=
 =?utf-8?B?QTE0bkdlcVZDK3JWSmlhZVNBVkZtcG5uV2I0NEt2aVdTQmZmZDhmQldiOUhU?=
 =?utf-8?B?WlNlNngvT1p5TzNWZWRKZjJJVE9ZT1I2VHkrby9KZHlkUE92WVd1VEZXRWU4?=
 =?utf-8?B?MXJpZmlJbk1NamEra3ljTS9kQkhkc1ZqamlrSjRlSXVIb1g5RGE5eU5VaFpX?=
 =?utf-8?B?aitCNjRHTWlUeUFMd0F0OTF3VHBiV3ZZdWdNQVV6YzF0MERhV25ScTZYc1Nz?=
 =?utf-8?B?V09nWjhONkRQMDUzTXRwWXJnUmxxaVQ5cW9zRkdpb2Z4STlxWS9Xc3RiMDJk?=
 =?utf-8?B?a25ZVWdYcytGS2Y1ZUxmVmdGRlBsa2NXbGN5WWp0NCtWYTlsRndNZFVZSmtM?=
 =?utf-8?B?dzhnRnhJMURhTmtKcW1BWjVxNEY5akphQ1M2TUhMNjdmU2x3dVZUeHpnSEVN?=
 =?utf-8?B?MllvR1FRaXlLUnFORHc0ZWQyOFpkdjZ0UE5rSTYrajR5b2JBZmdmckF5dEZu?=
 =?utf-8?B?S3QyTWxQYWVwWXBjMW05eXpoRVp1S3NOcGViNnhDQnFDMXJpWFlYT3ZhSzRt?=
 =?utf-8?B?Sy81WXBPOENLSFhEcVUwRi9ud1VrVXZyQkhUN1EvYS8zZ3VBTkRpR0lCUjdx?=
 =?utf-8?B?Zk41TnBlem9NcFczV2NIVkgzalFCQ0daeGN3YmZEYkd1OXdsYURuVm1jdyts?=
 =?utf-8?B?aFFkaHdIVUlueW56N3daaEIrUDVpYnVvQnk1YXRUbXFTMmVCVThGZVV4WU5I?=
 =?utf-8?B?QmcvV1pQb0ZreXhiUVc3Tklxa2pMWVFTZ1lZZU8xR0FRTk9hTk9qNXhINGwr?=
 =?utf-8?B?cXJYYW9xMUNNMXVnWVB1K2xvMHBrZzh4VC9PRUtPTW1sQ3hWNDcwd21aQk42?=
 =?utf-8?B?eG8wZHBpeEdLM0d2VHkwbkZjRzRtRUJmYlArVjdNN2dWaGhIZHJTZDdMVUE5?=
 =?utf-8?B?YjNNYjl3cVBsY1YwaGJsZWJickRmQzhTM3V3NG9qZi9IMFFyVXBZa2FuSFpJ?=
 =?utf-8?B?UWZ3eUJZWFE1NVl0dmNrWEh0TGlmN1pYYUkyZ0M2aFM3RTNQSUJYWkJGbmNL?=
 =?utf-8?B?Y1ZWenRnNGcrRUtjSmh6eTFmVjBraWk4OGRLQWttdmtkSnRnWVloSno0WE5o?=
 =?utf-8?B?R0hPZTdhaVQ1ZEpGTUNnQTdqeEZKc0grWHorU2tMdTJiZC9GeDVLQlg3cUJw?=
 =?utf-8?B?SGpVekFGVHRMTGRxM3BFRUl5SnlKVG1RMDg0MHZoNmpmZ3RCenJzMnJHdjho?=
 =?utf-8?B?cTJ6R3d6Vmdrdk9QRVhHQjduSTlUazd0cWhYdkRVYzI0VzhseG9uWEdTZ0VU?=
 =?utf-8?B?L2tVVWZBYTJjdWlvMmhNelJGejhpdFdhTUZNeVRzc3NZZTJ4Q3FaSG5Oemg2?=
 =?utf-8?B?Tk9keWRDdFI5akVialdLbW9PVHBaeVd2dmdLVlc3UGp5UUNta0FhOVVhb2dJ?=
 =?utf-8?B?aUF5VHI3azdRYXNzU2hZWUFMbUJwck5xbUZnWFI4eHpLTHdMVzRhdFJVTlk0?=
 =?utf-8?B?cXJ2ZUs5a0JkYmJGU2wzSzczMHFERG1LN3VPVjE3ZDc3V2ZLVStGL0VIcmJW?=
 =?utf-8?B?YVZCaXpwZVp6YXF6TUdtaUhhZU5FcTg4Qlp4dmE4OW5YblNRdHk5K0VVWHdK?=
 =?utf-8?B?dGdLYnFid1RGOWZYdmJIeHliTXRFelJPdVhGc09DaiszTXZJTmc2M2dHazVP?=
 =?utf-8?B?RkxTdTl3bzliTVlMSmtDdldjL2R1NEdxS3hzZThpOE5LeU9BZlE5cTZxYS96?=
 =?utf-8?Q?qwQhK9bJa8Pl82w9Y1p4MS5L3QJIwz8U?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGRuc3FocHB1MUNoWGx5ZytPeXc5bVJpeDVkTkRRTWhRNEowZUovL3FlUzg2?=
 =?utf-8?B?aTZidjdKaFoyT0ZvNnQ2K0pEbHBHT0FXVk9tTDBSaUhSUlh5U1ZzUjkvblRG?=
 =?utf-8?B?QlVtRm1hd2t3cjgvZzE3dEgvZzhZRmIxelgya0lpdFcxV21jL2hMbW1jMXkr?=
 =?utf-8?B?WHdlaE9ZUjU2c0ZScXN4aFUzdTl5Y1VIVldGUG5GMnh2ZmgyN0dHYXRKcTNa?=
 =?utf-8?B?S3ZPK0EwZDBIQnd5SUFRSDhWbU9GdXZsdlg5QVluVzJ2dU1lQnplL0JQSHFw?=
 =?utf-8?B?STNVK08rUjNEMEFGK2dheTJZM05MVStqeFBYL3JFUDFjR1AxdTZJMnJkY2F5?=
 =?utf-8?B?Qnp5NFgyVExMWFRuMG1rek5qRmJIZFphWXJGSm10Uk81d0dCbHYybGorbnA1?=
 =?utf-8?B?TEwwTmFHVEc3Q0NKSllHQ29Od2VETVFycTZ4M2VrU24rVTNNNXlhK0pOa0kv?=
 =?utf-8?B?M1EydkJROHdDTUtkQUJVZklVVlNVaE4wcm5ubGduRk84Zmd6aWQ5NHZUUDVw?=
 =?utf-8?B?WGJqRHM4UHhsOWtXT1c4bWMveWRIUlRiS2phN0pIbGl6MjRiQWQ0MFVOaWZp?=
 =?utf-8?B?RFBGWVJmdWYxVklLVVg1K29jYWlabDc2OHBTVmdMMjNBcDBncEFoYTc2b08x?=
 =?utf-8?B?VnU3RE42OVovN1dmU05XSzZJcUpxWHJ2aWpqRXJrWTJxcUhWaHQ4eGNBOHRw?=
 =?utf-8?B?bnZVOERLSmJqcjVIaFAyc0EyRFp0dUFkNVNlR25iSlZSSG9yZEMrRkpQcDJa?=
 =?utf-8?B?VkwwTmZZaW1pb0hNOWZLNktXeXhwMXdHaFFjVzArS1RTbEZPRmdyNlRsSjBX?=
 =?utf-8?B?UVNTYW94aFFRK0Y4cGIwRm94QnQ2aldweFpPaWZnYmRuNmZCdDdEeHpmVys3?=
 =?utf-8?B?M2pEbS8zMHM0bVpCcDBoTi9SQzZZeE9wY0oybDdMcFEwR05CUmdDaW5ZbEp2?=
 =?utf-8?B?SG5hcVFFWHhwSW9TY1dOeWFFKzdHMWVBQjRqeFE2OXJXV3ZXTnpVTG9LS1Vp?=
 =?utf-8?B?MElYTDZCVUhrSExhbmc0OWtwcFNGclFlL1dvdUJpL1dwZVd5ZDUxSFJmT09U?=
 =?utf-8?B?TmNIc2NBSTNLRkFacFpRQmVHMDhRdWpmREhnYXdMb1VBTUZnLytZVWY2YzJ3?=
 =?utf-8?B?MEFuK0d2TjJiZ0ZGZEk0OTRnZmdSVkpkM2FuK3FRYkR6OHdWckJuYy9TN3JU?=
 =?utf-8?B?SitQOXVMN2JJeU00NjZIdWFiUERVYUc5WlpHMVlTSmhaV05VR3RTZTFNaHhW?=
 =?utf-8?B?bnBhZGhHRzZtU3djY05WZGJLTmRsby9Xd1VVS2o4NnlqNGkyY2d5NVNCL2xX?=
 =?utf-8?B?NmZRTUNqKzhwaXlvbmhiNVFJZ2U2bGFldDIxM29wZ2hKTVYzQXR1TGlsUlZP?=
 =?utf-8?B?bkRjMzRSRE5pc2FBVng3RlZIYkhHcjMvNnMweVFtYmhQOWcwRDUvL1oyUHRs?=
 =?utf-8?B?M0RMclN1Q0hUSFdzM2RRR1pvL1JsbmM4bE1ScEY1MmdLU3EvYjRPWVhHQnlH?=
 =?utf-8?B?QVVTNFhxd1RXU0tnZ002c2ppOFRKY09YdzM0MjNycEN4Z1YyWWUyd3NvTlN5?=
 =?utf-8?B?aHdCSVNacldCckR6SDYxekI4NDFGQTJ1ck9TK2s1K0x1NjZxNHNzd083SURu?=
 =?utf-8?B?WUVRclUxTmJYdkpWMnRVOFlnYlFYNUxYMW9rU0hNZ2pRMVdOWGkxVURXWVNY?=
 =?utf-8?B?REZ2bE41YUxDMnpQSG50bU5CdW55QXFJSnR1STVKOGkvM2EyelUzZGxtVmp4?=
 =?utf-8?B?b2ZUVEpkWW4xdzVFNVlTcXRIeXRhOEpOUWVBc2g4dUFWcE12VnZ4Ly9KZGl1?=
 =?utf-8?B?NllqMHFkMWdPZHJtdFNxOWh1ZlBoOU42YzAxWWl0cEVzS3ljNzNRM05YRnF4?=
 =?utf-8?B?dnk1YldpU0hoSDA5YlNzN3AzR0l2ZEpSVENCdEJwbXBPRTBKMEVPLzVWZEdT?=
 =?utf-8?B?bG92WXF5UVkrcDlTUUFrN3k5c3RxaVdXaENYckl0YzdaYnpaWHE0ZEx6UXRS?=
 =?utf-8?B?d1lXaXpZbkZ6azE1b2c3MDhtMjAxRlphQy96QXA2V3BZLzZBM2trSWppUXc2?=
 =?utf-8?B?V0NZVUlFSjdIUVR2Y0d5STYya2ZrM1M2b3U0STRLTC9sWHN3aDVqdDluWThN?=
 =?utf-8?Q?Ukhl1FIHGBGRCqw/dmb77tvkL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78CBD98D38075D48B1379712B28371D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GA7ugK+650tSbEyxeQMPU7Dcx4jBglGXMSQwfRV4k/0c7gQszcJ/CgQCUoCOrUppuDwUyLG1GFLpegXZt5d2ioPAAACwGfjuAdM/rxyTvkvWPCbZMBSLQ8U60oMxSpoGaZXmJy4Nlp6PNB+trfbdkxfKbGcm3bR+yDadzxYa3Y+kU1LyB3rxrZL+d9HXn/yn1JZ/arseufu0wMjPGKg+2tMJ4xEcchXY6R2IknURdbtdD0hNCyP1aXt8+RNNBCdINUAKiImKRiMVK/cZL4i5FUbuO7MxbKnU+42rh0gqvo5TRdSm99/qzEhrWOdIPEbU1BZnlGt8hXXj2lColebIKyzuKlZnbJEl16gjNK1LNmAybOE9KDXJVpogPgHAy4Js5mDq74G1YsDYnULiDL8azxU3Q3OvJ3E2+VXJ17dOy9+iVJHkZjAZ97eu4nf+Y3nZxL9R4bhBjXGK9wenP4bnL+1LsOyweQjwyyndIOAORL41VtTQ8l3N8pv72579VkLjjErSzg8XzkCCEFYYpnOeR7GBO3TZLTqkrE8vHGQdmXSdCrrH+Vr3tCw6S7PWuxvwP2Nl+zE4+S/3NUTZzkmJoU25Gak5bFc137crzSVoXg9iOpohhwt44faGcxnVnnovmip0Mg8v8qGxQXRBMH/kmw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649f49be-f855-45db-aa50-08dd311ece90
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 02:30:54.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 70NRfTLrwLeUJNr7bCHSU5EEaKy/TsCjcAqbnlC7guFF0WpG2MqgnnfgbxqYl0zP/zdVSB4K9q7kB84PHpRm+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
X-Authority-Analysis: v=2.4 cv=T8x2T+KQ c=1 sm=1 tr=0 ts=67808664 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=05UBtA2xzUANmcsQm1MA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-GUID: eZe8Nz4h-5v3aUgxoNlrxG_CggpRizmG
X-Proofpoint-ORIG-GUID: eZe8Nz4h-5v3aUgxoNlrxG_CggpRizmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 spamscore=0 mlxlogscore=922 clxscore=1011 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100018

T24gVGh1LCBKYW4gMDksIDIwMjUsIEpvZSBIYXR0b3JpIHdyb3RlOg0KPiBwaHlfc3lzY29uX3Bs
bF9yZWZjbGsoKSBsZWFrcyBhbiBPRiBub2RlIG9idGFpbmVkIGJ5DQo+IG9mX3BhcnNlX3BoYW5k
bGVfd2l0aF9maXhlZF9hcmdzKCksIHRodXMgYWRkIGFuIG9mX25vZGVfcHV0KCkgY2FsbC4NCj4g
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IEZpeGVzOiBlODc4NGMwYWVjMDMgKCJk
cml2ZXJzOiB1c2I6IGR3YzM6IEFkZCBBTTYyIFVTQiB3cmFwcGVyIGRyaXZlciIpDQo+IFNpZ25l
ZC1vZmYtYnk6IEpvZSBIYXR0b3JpIDxqb2VAcGYuaXMucy51LXRva3lvLmFjLmpwPg0KPiAtLS0N
Cj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBBZGQgdGhlIHN0YWJsZSB0YWcuDQo+IC0tLQ0KPiAgZHJp
dmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIu
YyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMNCj4gaW5kZXggNWUzZDE3NDE3MDFmLi4w
YTMzZWQ5NThlYmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1hbTYyLmMN
Cj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWFtNjIuYw0KPiBAQCAtMTY2LDYgKzE2Niw3
IEBAIHN0YXRpYyBpbnQgcGh5X3N5c2Nvbl9wbGxfcmVmY2xrKHN0cnVjdCBkd2MzX2FtNjIgKmFt
NjIpDQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiArCW9mX25vZGVfcHV0
KGFyZ3MubnApOw0KPiAgCWFtNjItPm9mZnNldCA9IGFyZ3MuYXJnc1swXTsNCj4gIA0KPiAgCS8q
IENvcmUgdm9sdGFnZS4gUEhZX0NPUkVfVk9MVEFHRSBiaXQgUmVjb21tZW5kZWQgdG8gYmUgMCBh
bHdheXMgKi8NCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8
VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

