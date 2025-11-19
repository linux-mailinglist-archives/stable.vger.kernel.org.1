Return-Path: <stable+bounces-195138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DECCC6C504
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 02:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 695004E8BD6
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076023C4F3;
	Wed, 19 Nov 2025 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="O8f7MZVm";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T8EVfUcv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="d3wvzSfq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613518E1F;
	Wed, 19 Nov 2025 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517431; cv=fail; b=gVhXsY7SjDfMM3OvCHnMNyKAwTT2gIZFTNlYb3KdtnZ2eTI5EzQBaOyuqVFhc0QLI/WuOTTytITKoeZAnj6ltpp4gGJXc3R9OXXE4G0L+LYBGgBYrd3Vb17lHItw/FWqUDE3ADN1lFmvebhWIV/dtkTKbyP7zniMvdgP8zH9in8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517431; c=relaxed/simple;
	bh=GyH2yHjy+JWD9gOS3MAlvlIeJ9b9YZPWNp3IA3ezU/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSDHuNshjQKR9MY32HUR7wdlw3B65I1+vDSaU9gRZYpbAUQ3h5NtxSramClCYEfGE5KhxW+yICvLFxpBds3GzS9y+MK0QGDXf3M/3ytKJ7CDsGwLJQfAR3g3TmXz2uAK9xVYz2SDceD2CbIG1k4YaXZrAirjRcI7nYCzelqptA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=O8f7MZVm; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=T8EVfUcv; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=d3wvzSfq reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIKAsDZ2105162;
	Tue, 18 Nov 2025 17:56:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=GyH2yHjy+JWD9gOS3MAlvlIeJ9b9YZPWNp3IA3ezU/o=; b=
	O8f7MZVmlQSbZTkNo66CikLX+fdecH+F3LDPQuG/zog00QbKQ3RFXMw57URdlsvT
	XurXFU4qlrZdUp/UC5FX7ZUQOWu5qYUAA0Ut0kHa+ACILTKL5VfJlNRUwmiyhzjB
	Cxr71fLXdfsdhyRsLLEe6uoMM7u8MWqjRLN4XIb/GZMFVj48XFsWd8rOk4H13rDL
	nmO7YEwKcDbdukwq8NQXovVDCm5WSByidGMS7B5LckfTiBy3OaC2AJOMnUruvZ3C
	SsWg/35OdQ5PzFML3WEyEYV37nqWXczgB6gBH3AHaR3ILzzeNCcZw/+zkuWtmA77
	mjFMZEA41Y9+brL9oiOFwg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4ag6p1qhax-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 17:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1763517418; bh=GyH2yHjy+JWD9gOS3MAlvlIeJ9b9YZPWNp3IA3ezU/o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=T8EVfUcvST9MERauX0l3PTmfhY7dlc2wRHhVmvT4sQvJnLSvnE/JWX+HX9uY5celV
	 AkNeeMYyp/Q9WZBHvifnbmfRPXBwUGyi5cmYHdEGagiPPJ6Nc3bqPoG2in3ODSbxxe
	 2z9OVzYf/bdQDmKVBLyT8DjuU1IcQ2QyI8RkAdKvdFMibnOivsaWI+Uh1RO+8CcgLy
	 Gn/2KE+x1S7CaJk7yqjd+tcrThI/5xfg+9bVSV2sid0e/d2cjRbEfauob7LG8zhqk7
	 fqekP7gpHLAtoSLh7SEzveG6rG3bUy5XfOP5QfZycaeNuRbvdDVkw/jOS82aQFe6gw
	 q0MTRz/bG5/Og==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9DC5D4035E;
	Wed, 19 Nov 2025 01:56:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay5.synopsys.com [10.202.1.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 75D04A00B4;
	Wed, 19 Nov 2025 01:56:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=d3wvzSfq;
	dkim-atps=neutral
Received: from PH0PR07CU006.outbound.protection.outlook.com (mail-ph0pr07cu00607.outbound.protection.outlook.com [40.93.23.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 83EAE220742;
	Wed, 19 Nov 2025 01:56:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKTevBQHQFl46FmATkDJwB6wGMTlETvF+h8d7sy7r+nmUurdUKElnubV8oi8CbNrCMiCUgWbvlfo22hT2mAxv/6LI5glfjXGAS4oh6VAL6oP4SovdwtP80qF+gUVr3DD5YdeORySS1NTphdVKBOQRw3I9w2TrVevBjQq2KJCz8HijPXP3CS2hywlvST12fCByBGNw/Qf/6GdHBgTX2qDp2wdSZ1P7ZklJ/X5qB5xuj4CPI6FBav8mJPqxDoMjxHc3nUwiABqna9/JSsuuSwEx/jSVUua89tj1LuaUhIXxSwCucoln0w8BMNdJwawwz4snQ4GTqTwJ0wwGq4cGrPhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyH2yHjy+JWD9gOS3MAlvlIeJ9b9YZPWNp3IA3ezU/o=;
 b=H3JVFZPC6suaeudmhT3wVjx+vqfSHygKste8W8AZFqDRRYQp0lVbNIyqkHKp7D3VdknJ1V/fCxaZTwHFSzeyp04MPmN4DEKbgtP/mch5L7WLW/sew3BrraUohd/ogiqxnX1iALGWLI+qrLGqIxLfHkexSkOHZGQLeOFvwPuzshjSxPjGwfd0BXU1PEWUTJjuU6NUSf5W3RanSOgOFqT3Cd513+M2PrhMpwG/yoH2t0U6Di+5nQ4C+rKacSTYCxDdGyo/bAfGbATYJjvj9S9zvPzma2dkg9ByaeFeoYFZ83vMl3x4X5d64WodOBHbPGs19bHn2wOuTsESZ6w3qlBlbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyH2yHjy+JWD9gOS3MAlvlIeJ9b9YZPWNp3IA3ezU/o=;
 b=d3wvzSfq2F7JJY552wLlWa67shnW9At9WYKwXfCftxoo9xLKRhtXy+nYfZEJMpz5RhfF/lYu2Q7R3aDWREUjmmueRTjr6GCQAD/tm3b06DQ2Ofl7u9lqTr67EjgC0+R7PBDnBS8TRYInQZew45LWlbU1XHefc+L/Mb5L1HwA69I=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 01:56:55 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 01:56:55 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Index: AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAbSICAAXA8gA==
Date: Wed, 19 Nov 2025 01:56:54 +0000
Message-ID: <20251119015653.dymmcwebpbrwae5k@synopsys.com>
References:
 <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
 <20251117155920.643-1-selvarasu.g@samsung.com>
 <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
 <eb19ca1d-1919-4ead-9795-5dd24ca1950c@samsung.com>
In-Reply-To: <eb19ca1d-1919-4ead-9795-5dd24ca1950c@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB9255:EE_
x-ms-office365-filtering-correlation-id: 8b2d628c-612e-456c-f34b-08de270eea7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eU5BZ1ZqRHR4ZmRrTGpEalRxUUZndTNEa0U4b09KOTJtRFUxRnVCaVNUWCt1?=
 =?utf-8?B?N3BSRVNHaG1RSWpOdlJGRDh5YmtSSGZ2c3l5SjBaeTcvV3RLalJZQXd3bWxB?=
 =?utf-8?B?NVFyaGhueUhNajRQUnpITWtGVDF6SUoya1hCRm5QR1paOE81aUs4MXFNVjNs?=
 =?utf-8?B?eDA3NzJDbUM5eG9SbndYaUNyZ3d0Z1RobmJVRnpRTDczVXMvZjBJV0wyTDVh?=
 =?utf-8?B?dFlmQmRDYUpjV0xUZnNLQXFES1NOWjkvdmhLWmhmZGg1bE9xOWFXN1p0aFpS?=
 =?utf-8?B?WktLR0xKVmVzTUdZa1JNSWM0SmpJL3ArMHMxSFFPQ1lST1R3ZG8xcE1JVGtK?=
 =?utf-8?B?REZVLzNoQ2NvYXVmaExrL21qbjRRaUJodjhHWDFoTnA0anlxMGdBTUFKNFVS?=
 =?utf-8?B?WjZjem4xR0VUZ2VObU5jb1I2TFhTV0ZBUytvL2c5UHpqZHBWeHB3ak1YUVVQ?=
 =?utf-8?B?VnFUeVkwQUpLYi81TFg0bTczbmwvdVpvdGNPeFpldE53ODFaUnVnZGZ4NEc5?=
 =?utf-8?B?TndJT2xmcGVwaHBCN1VmS0RWcHdiQnNTbWIvMlRqZlJyOWhPNkIxbDZRRGJP?=
 =?utf-8?B?My8wd1ZTNjc3VFJITXdzVFNnMXFFc0hLUi81QUo4b3h1bUhwdGp5SG00eVY2?=
 =?utf-8?B?TGVYM3N5bC9hc3ZaeVpaVlFKb05OSjlSdG93aG4vWTZ2L0FTUDNNYk9jNk9w?=
 =?utf-8?B?RnBxTSsvMXFUdThvMk9CWlB5bEIwYVUyNjdJZStqS0pWRlQ2NU5DUXlCVGhQ?=
 =?utf-8?B?TzVJZ3k1MEN3eU9FODE0R01NQzN0MnVqTnpaZXJLRkdCL2Y1a2dYNVdoRUZI?=
 =?utf-8?B?WkRCY1lLaXdQeStrb3BUeURDOGprcHFOdG02TnViZW10bmE2Tzc2cFZEeThZ?=
 =?utf-8?B?ajBtL1hKQWhwVnJ5NmFpZmpQb0lJemVQVTJ0eHNYQXBPSldSR1NkZWh4N1dv?=
 =?utf-8?B?RjJPTVZ5MURrd1hSejFLSVJ0bnpIUWkyYmNmQlIvTGNZYytTaDAwLzJUQnNi?=
 =?utf-8?B?cFdqenQ3SncwU2VCNFZXUmJobkNkaUFvQmVHSDlZb25YeTVBdFNydVQ1YWlF?=
 =?utf-8?B?S1k0VDJjVjZDWERwNjBXWXpjMDZXQVlPeHJHQTF3cE1zWTN4Z1d5RVNTbWZW?=
 =?utf-8?B?K256dkExV2NDM2hXM2NTaWFwbVh5ZGo5cUR2a002ejIwZ1BMd1NRbjJPcFZi?=
 =?utf-8?B?NVhQK2NIN0R2by8zeEI0Vk5pUHI1dEZNQXVhbnJTM3M5clB1a0RvZldHeENk?=
 =?utf-8?B?Wm9sWEtLcS96THVOTjJhckkxK0NCM1ZBM2FWZENTMzNILzRxbDlicVNZT1JC?=
 =?utf-8?B?VTZGNDVWSkVPU1J6YnZPZTJDd2RLY1B1TThZUHFLc0RyOERUNmVVOEo0TzY1?=
 =?utf-8?B?eElOVWRpOHQ1WXUvOE5kR2xpa01rWUsxeHAvR2xZUHg3TFVZWlBOYnk2MlZM?=
 =?utf-8?B?T0hiU0RtQUVhM0VvRzA1QTJLME5md3BhQ1hXbjVjMXpudDA4aHd1bmtxN0ZF?=
 =?utf-8?B?UEhGNFYyQUt6elhHZHJQOHJJQkdTODZmd1cwY1haTk9EVS9qMWNtMTJoTjVT?=
 =?utf-8?B?YUd0dkM5Smhkb2RpZmhVZG5UM3VYYlVmS0E5NFM2dTJkM1ZJTktRMHRWR0hC?=
 =?utf-8?B?dkNENjYranRwQWZsbzVJdTFFOFcyRVV1QmdGcTk1UVd2Z1RQVXFEN0traDdI?=
 =?utf-8?B?dnkrKzVIUk95TnV2MHZRUGFNYVNyYTdDVVVUMVFLRUdYWmVaMnpyZ05ycng2?=
 =?utf-8?B?UTRUTWFveWh0ZExHWmxMWS9xaWdXbkxHSE1UMTdJZGh1eWYyZGlJdksrWG82?=
 =?utf-8?B?a1R0SHkvcU1wYzdiRS80ZnVGQTNCMExabFN5QzlPWk52bzJ2K1NvMkk3bkM4?=
 =?utf-8?B?eE4wZkM5U2hRNDNCZGpkVmw4bmtmTmpVdjJEakhoK0dIWWZsQ2JVT1hISFly?=
 =?utf-8?B?NlhFdlRhbzhVL3A4LzhWWitTY1VOTjZnYmE5SUlxTGx0MHd4cjZsMHZXWm52?=
 =?utf-8?B?cTlKaXpVTWJPRjNlMHlyMmlDRFJsYXI4bU9uOFpBZXlMVExtTXgxVTg2SklQ?=
 =?utf-8?Q?aVTd3I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkRuNHh5Ui9Qb0R6ellqcnhiR1VSWnN2a0ZKMGhuQk1RZ2hMdUovcFh3ZmIr?=
 =?utf-8?B?OVZ6dkxsQ1Yvc0ZON0FIZWpBQ1VDWjgwTjZEeVJxTC9lV1lubmRpSlEvdWVU?=
 =?utf-8?B?VE9VNXp1UjYyKzJhUFpBYlkwdUl1SEZGRmd0MVpBb3hKOTZOMm1XdGlOaVhr?=
 =?utf-8?B?MWxXbHFDSEhlR0MyY3hsSmdkaDNNOFBtaGIxOGlOeW15R2l5ajFOV3RWYTBW?=
 =?utf-8?B?MEVuK3lGcWNxZSthb21WclFyb1VLRUhDRjJXYkhLa3hKSDVCS2tlNFRkREVK?=
 =?utf-8?B?VFdOemJQZXB0SG1rTnlHVTYvOTIvMlhnYk9Lc2FkemtQakV5MnJ3UGpDVVcy?=
 =?utf-8?B?SGc3Sm51UVhKR0NYdVd2SThBUS8vMkFuRmJrMStPWE1tejB4Q2lQSkR6aHhs?=
 =?utf-8?B?Ymd1Q2szcUF4MHhSZ1ZvMTBMOGJvUjgycHJ0eEtJSWczeWtzcHVOVC90QVJX?=
 =?utf-8?B?WGhwaWJWMnpaZmQzU05QZllwdDVHN3hWN3BZZmVxblA0NUJ5WGRFcnVRcjZ4?=
 =?utf-8?B?c2ErTkpObWk3RmI3dFlSQTM5TXYzMmtjUmNON2NMRm5QdUtGMGNieW16SHlp?=
 =?utf-8?B?WXRhUVRwMnpidGQrdUJ1TE9xWGN5S2ZpQlFueDQyUm9NTXJQQXpvR1JHOTEx?=
 =?utf-8?B?aERJbStNV3pEWUlob1FuRzlyWFBUbGREOGE5QlVtR0J0NHFRbU40OFhCSFEr?=
 =?utf-8?B?RHBPaE91UHk3Q0RvejhBRjNKTzNmMlFSbHBnMzhNdmtueEdGQ3BnUmovLzls?=
 =?utf-8?B?T0R0cmtFdGZZczVDaUxKRmhIeHNrOTcyQjFsNHZRNytqSXZsejJJRjRtSld3?=
 =?utf-8?B?SnI4UEhqQ3M1TTBrN1ZTcVRzd1gwZ3drWGFwdUVXWGdxTVVxL2FiZTUxMEU3?=
 =?utf-8?B?ZVgxOFF1c0NCL1dQZkppWUlrQUJNSDJtV0tZZjNZQndTdisyMGNFdW5Calpl?=
 =?utf-8?B?MldXc21wbjROVTZlalBVbGZpYWhFSEsxb1FXWkZxZWQxditsdVhYbnoyMU1S?=
 =?utf-8?B?TklueFBudVhPWXQxZFdlcHl5K29aOUpXamQ4dHBteDFhbmRKNzNZZUlMSDZR?=
 =?utf-8?B?Vnl3Z09MdHBXNkdENENiZ2p5UE5jcm1qSzZGRklJTTFvU1pOdHZka2xWSEVh?=
 =?utf-8?B?MDVLNGFCK0RYUk0yUzdVUmRXL1FWM25TS0kyRkl3UWVwZjNQZDBYZ1ZKK3A3?=
 =?utf-8?B?aFJ4RUZLZEJiTHREdjc4WEJrbThySFZsaFVZMll2eStsK0RhOWJ2Yk0ydHZX?=
 =?utf-8?B?RzQra2E5TG9ST0dsVnNrZ3RFbVhpU05VbUQ0K3daZjFZcGZrV0dDNDRhRXlm?=
 =?utf-8?B?RStmUkFVaGlnZ24wZDJIM1BlRHpQeHRlOC9zVlRWSGwxQ1hOYWtVSVozdEFZ?=
 =?utf-8?B?M3p5U2FWaW9OMHdrbk5mL3M4SmpRYWk0NDFDTytINk1qVUJaUXJaZ0p4Znpk?=
 =?utf-8?B?cXpNZVBmejEwejN0VzhHYURzNHdiMURyM3RvNUpaZVpnbmtHOUZHUnhaaERq?=
 =?utf-8?B?NEdFT1Zaczg1alR5em1kY09NOFh4akhwMXBrcGluWFQwQ1FHWG9hbXlHN25z?=
 =?utf-8?B?b3ZNMWRGSG1JTFBzWEkyZXJRaFM5N1pXUEIrS3MzY3h1K3ZnUmtyalEzTXBV?=
 =?utf-8?B?Z3B0OUhqbUZzZVh6M3psTEJ2Yk1nOUNNTVpyQTJkNTIxT0wvblduWTE3SE56?=
 =?utf-8?B?R2djQUN0L1VlU1ljeGI0djdXMUlBNDFRZTFGQzIzTWo1RytBVXMwYzJCd3R6?=
 =?utf-8?B?QkVtUFd1UlVsaWgvbjh0SlcxRkF2YWwvdXVkWnNQMUNzU3VSU29HMHhCN2U3?=
 =?utf-8?B?bUkzYk1MM09zSnBGYW4zYldFUWovUSt4VW01WnR0UEk1TTNsNGtMOEtIZFVv?=
 =?utf-8?B?NGpIR0ZmSU9QR3BKbjYyY1VsZzBpYWx1SHlYRGI0Vms4MVJyV3Jpb2dla2Yr?=
 =?utf-8?B?eXdGcXNYdTRWMjJYV2twRkJ2dFVISWFnZW1VVXRCOFBRdy9XSlBUNnRGZG14?=
 =?utf-8?B?MFcvcHcwZUhERzVTRTFBaEQzUDF1aGJaeFBNb2twUmVCNlpIcnFxc0p2QkEz?=
 =?utf-8?B?dytyMW5pQlAxU3JxVTEwRURSZ29xK2htZ1Znd1dzaTB2d2tCZU9PVUIyOWlv?=
 =?utf-8?Q?DuXhSHq8c3+9sLJaDNZfNMcCf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4E4EE03DE65C840A03C356E8D9F3E14@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r4OZAVSxB0v9t4wNBdySsyCKKi16hDUYC6q4v4my7y6rpzZYnqVELI+tSbEFWkzf12FzkuEgSfrY2fhN6NsvzNiMOwx7KhHrQ0fTPg5lb6suzbSWEvjQbDCpC3jLBhbsBvM2QxkhyFN5LlU3Sup/03tqZ1fa0/K8jytZi/HzAWO40AkTc/JbvGUo21G1daJa/1L2Xufs58ktm/s3FrrEfaaIcOb2Jga9hvTwISshDv26fcIKFf2G/6+OB2OZ3xE2YATuM+4O5xczv4vrXpM4ZOzZjxVeoySwIgDp1eemV09DtT1oXYdSXPyJpQS/9R+jR3h4uXIJZnrZAhqkMwhVyFPvBmpMkjCLNZntbN4CcT+gtiSjTNwyZB//KH8BCwvXsvVkBG4iRUpoxFW2ymEQik8sVFY4nnEmgcSdWNDqzfmOoCOTH/fNdb77bT3tKvHMZqdAbGTfnJrs7tzQ0iJS63LwDOltFWdMIWY8/UbI5CHl50SJ5NfM+KAsewpLyz9O19Q7d1YsYEw229GzgJABzTmtJ28s7DiltPEAwjMiDvLs6blJJ8V/zZFQi6AXmlB2UQmcgFlehZlnDhBM0D2akjkezMzuG2e6t3X7EiORQLs1kgwpjvPZpQYK+Br2e1rGeh21euekto2UIdhzsKrdIQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2d628c-612e-456c-f34b-08de270eea7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 01:56:55.0010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWzNEP6UwNCSM4Iy7LoWe7m166WJflTyQ1DtK62fEJYU1vh7/8idqd8Pq+jD+zCX6U3Msjh9a2Fovf77GvjTfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255
X-Proofpoint-GUID: 77IiP_vFRVkc3E2Yg_6OTtQXzEH6VVAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDAxMyBTYWx0ZWRfX/NpMfPyEYdOJ
 asvJwZjwuJlwvCGG7LNDnuzIlf7Lllihmcq8LzKN6XjO5pclQelZ+SV3kEcRNU8ym2J6RN899RS
 kbzuCdfqSJFFF4kY8LTLi9WGR2J5Z+FFlmcbE4ubhDarg8eacqzERX3aJPJydD+fx0/AGdMm9PH
 0/8qs1AeNijYUm5wEZgATnUB0h4Wy4Bpav6Gg1+hFp3xeggGqxzj/iwRjmBz8ztPj5QaMiKSx99
 g8RqWc8WkQtaKSVm2k5R5fEBZFV0+uRa+T7gejG32w+miYxf8TDrdNkeQtb5P9PaagfKW6lXfxE
 sW/PKsHppgnRQdh+XCtIjgPgMWgficUiOIjtDvEOYNXRTmcM2MFgNqf1TsJ9ekfK6xFZMQzfiYO
 x/Ov5KLh15dK1rQRvy6Tg1DuVcASvw==
X-Proofpoint-ORIG-GUID: 77IiP_vFRVkc3E2Yg_6OTtQXzEH6VVAM
X-Authority-Analysis: v=2.4 cv=PJMCOPqC c=1 sm=1 tr=0 ts=691d23eb cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8
 a=ZeY0DjOJmbvPZHPwpMgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1011 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511190013

T24gVHVlLCBOb3YgMTgsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
MTEvMTgvMjAyNSA3OjUxIEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gT24gTW9uLCBOb3Yg
MTcsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiA+PiBUaGUgYmVsb3cg4oCcTm8g
cmVzb3VyY2UgZm9yIGVw4oCdIHdhcm5pbmcgYXBwZWFycyB3aGVuIGEgU3RhcnRUcmFuc2Zlcg0K
PiA+PiBjb21tYW5kIGlzIGlzc3VlZCBmb3IgYnVsayBvciBpbnRlcnJ1cHQgZW5kcG9pbnRzIGlu
DQo+ID4+IGBkd2MzX2dhZGdldF9lcF9lbmFibGVgIHdoaWxlIGEgcHJldmlvdXMgU3RhcnRUcmFu
c2ZlciBvbiB0aGUgc2FtZQ0KPiA+PiBlbmRwb2ludCBpcyBzdGlsbCBpbiBwcm9ncmVzcy4gVGhl
IGdhZGdldCBmdW5jdGlvbnMgZHJpdmVycyBjYW4gaW52b2tlDQo+ID4+IGB1c2JfZXBfZW5hYmxl
YCAod2hpY2ggdHJpZ2dlcnMgYSBuZXcgU3RhcnRUcmFuc2ZlciBjb21tYW5kKSBiZWZvcmUgdGhl
DQo+ID4+IGVhcmxpZXIgdHJhbnNmZXIgaGFzIGNvbXBsZXRlZC4gQmVjYXVzZSB0aGUgcHJldmlv
dXMgU3RhcnRUcmFuc2ZlciBpcw0KPiA+PiBzdGlsbCBhY3RpdmUsIGBkd2MzX2dhZGdldF9lcF9k
aXNhYmxlYCBjYW4gc2tpcCB0aGUgcmVxdWlyZWQNCj4gPj4gYEVuZFRyYW5zZmVyYCBkdWUgdG8g
YERXQzNfRVBfREVMQVlfU1RPUGAsIGxlYWRpbmcgdG8gIHRoZSBlbmRwb2ludA0KPiA+PiByZXNv
dXJjZXMgYXJlIGJ1c3kgZm9yIHByZXZpb3VzIFN0YXJ0VHJhbnNmZXIgYW5kIHdhcm5pbmcgKCJO
byByZXNvdXJjZQ0KPiA+PiBmb3IgZXAiKSBmcm9tIGR3YzMgZHJpdmVyLg0KPiA+Pg0KPiA+PiBU
byByZXNvbHZlIHRoaXMsIGEgY2hlY2sgaXMgYWRkZWQgdG8gYGR3YzNfZ2FkZ2V0X2VwX2VuYWJs
ZWAgdGhhdA0KPiA+PiBjaGVja3MgdGhlIGBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURURgIGZsYWcg
YmVmb3JlIGlzc3VpbmcgYSBuZXcNCj4gPj4gU3RhcnRUcmFuc2Zlci4gQnkgcHJldmVudGluZyBh
IHNlY29uZCBTdGFydFRyYW5zZmVyIG9uIGFuIGFscmVhZHkgYnVzeQ0KPiA+PiBlbmRwb2ludCwg
dGhlIHJlc291cmNlIGNvbmZsaWN0IGlzIGVsaW1pbmF0ZWQsIHRoZSB3YXJuaW5nIGRpc2FwcGVh
cnMsDQo+ID4+IGFuZCBwb3RlbnRpYWwga2VybmVsIHBhbmljcyBjYXVzZWQgYnkgYHBhbmljX29u
X3dhcm5gIGFyZSBhdm9pZGVkLg0KPiA+Pg0KPiA+PiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0t
LS0tLS0tLS0tLS0NCj4gPj4gZHdjMyAxMzIwMDAwMC5kd2MzOiBObyByZXNvdXJjZSBmb3IgZXAx
b3V0DQo+ID4+IFdBUk5JTkc6IENQVTogMCBQSUQ6IDcwMCBhdCBkcml2ZXJzL3VzYi9kd2MzL2dh
ZGdldC5jOjM5OCBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCsweDJmOC8weDc2Yw0KPiA+PiBDYWxs
IHRyYWNlOg0KPiA+PiAgIGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKzB4MmY4LzB4NzZjDQo+ID4+
ICAgX19kd2MzX2dhZGdldF9lcF9lbmFibGUrMHg0OTAvMHg3YzANCj4gPj4gICBkd2MzX2dhZGdl
dF9lcF9lbmFibGUrMHg2Yy8weGU0DQo+ID4+ICAgdXNiX2VwX2VuYWJsZSsweDVjLzB4MTVjDQo+
ID4+ICAgbXBfZXRoX3N0b3ArMHhkNC8weDExYw0KPiA+PiAgIF9fZGV2X2Nsb3NlX21hbnkrMHgx
NjAvMHgxYzgNCj4gPj4gICBfX2Rldl9jaGFuZ2VfZmxhZ3MrMHhmYy8weDIyMA0KPiA+PiAgIGRl
dl9jaGFuZ2VfZmxhZ3MrMHgyNC8weDcwDQo+ID4+ICAgZGV2aW5ldF9pb2N0bCsweDQzNC8weDUy
NA0KPiA+PiAgIGluZXRfaW9jdGwrMHhhOC8weDIyNA0KPiA+PiAgIHNvY2tfZG9faW9jdGwrMHg3
NC8weDEyOA0KPiA+PiAgIHNvY2tfaW9jdGwrMHgzYmMvMHg0NjgNCj4gPj4gICBfX2FybTY0X3N5
c19pb2N0bCsweGE4LzB4ZTQNCj4gPj4gICBpbnZva2Vfc3lzY2FsbCsweDU4LzB4MTBjDQo+ID4+
ICAgZWwwX3N2Y19jb21tb24rMHhhOC8weGRjDQo+ID4+ICAgZG9fZWwwX3N2YysweDFjLzB4MjgN
Cj4gPj4gICBlbDBfc3ZjKzB4MzgvMHg4OA0KPiA+PiAgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4
NzAvMHhiYw0KPiA+PiAgIGVsMHRfNjRfc3luYysweDFhOC8weDFhYw0KPiA+Pg0KPiA+PiBGaXhl
czogYTk3ZWE5OTQ2MDVlICgidXNiOiBkd2MzOiBnYWRnZXQ6IG9mZnNldCBTdGFydCBUcmFuc2Zl
ciBsYXRlbmN5IGZvciBidWxrIEVQcyIpDQo+ID4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNlbHZhcmFzdSBHYW5lc2FuIDxzZWx2YXJhc3UuZ0BzYW1z
dW5nLmNvbT4NCj4gPj4gLS0tDQo+ID4+DQo+ID4+IENoYW5nZXMgaW4gdjI6DQo+ID4+IC0gUmVt
b3ZlZCBjaGFuZ2UtaWQuDQo+ID4+IC0gVXBkYXRlZCBjb21taXQgbWVzc2FnZS4NCj4gPj4gTGlu
ayB0byB2MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXVzYi8yMDI1MTExNzE1MjgxMi42MjItMS1zZWx2YXJhc3UuZ0BzYW1zdW5nLmNv
bS9fXzshIUE0RjJSOUdfcGchZFFORWFNdmp6ck9pUDBjOVU2bHlqMzF5c1hHa2pCQXM4Y19LamdE
Q3A2T05TWmNUckYxNURYYUplRlRLMDJ2MFJMUzN3ME5RMks1X3B2WGFrXzdjOHRJeEtMOCQNCj4g
Pj4gLS0tDQo+ID4+ICAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrLS0NCj4gPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pg0K
PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gPj4gaW5kZXggMWY2N2ZiNmFlYWQ1Li44ZDNjYWE3MWVhMTIgMTAw
NjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+PiBAQCAtOTYzLDggKzk2Myw5IEBAIHN0YXRpYyBp
bnQgX19kd2MzX2dhZGdldF9lcF9lbmFibGUoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQg
aW50IGFjdGlvbikNCj4gPj4gICAJICogSXNzdWUgU3RhcnRUcmFuc2ZlciBoZXJlIHdpdGggbm8t
b3AgVFJCIHNvIHdlIGNhbiBhbHdheXMgcmVseSBvbiBObw0KPiA+PiAgIAkgKiBSZXNwb25zZSBV
cGRhdGUgVHJhbnNmZXIgY29tbWFuZC4NCj4gPj4gICAJICovDQo+ID4+IC0JaWYgKHVzYl9lbmRw
b2ludF94ZmVyX2J1bGsoZGVzYykgfHwNCj4gPj4gLQkJCXVzYl9lbmRwb2ludF94ZmVyX2ludChk
ZXNjKSkgew0KPiA+PiArCWlmICgodXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXNjKSB8fA0KPiA+
PiArCQkJdXNiX2VuZHBvaW50X3hmZXJfaW50KGRlc2MpKSAmJg0KPiA+PiArCQkJIShkZXAtPmZs
YWdzICYgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKSkgew0KPiA+PiAgIAkJc3RydWN0IGR3YzNf
Z2FkZ2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0KPiA+PiAgIAkJc3RydWN0IGR3YzNfdHJiCSp0
cmI7DQo+ID4+ICAgCQlkbWFfYWRkcl90IHRyYl9kbWE7DQo+ID4+IC0tIA0KPiA+PiAyLjM0LjEN
Cj4gPj4NCj4gPiBUaGFua3MgZm9yIHRoZSBjYXRjaC4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUg
ImVwX2Rpc2FibGUiIHByb2Nlc3MNCj4gPiBzaG91bGQgYmUgY29tcGxldGVkIGFmdGVyIHVzYl9l
cF9kaXNhYmxlIGlzIGNvbXBsZXRlZC4gQnV0IGN1cnJlbnRseSBpdA0KPiA+IG1heSBiZSBhbiBh
c3luYyBjYWxsLg0KPiA+DQo+ID4gVGhpcyBicmluZ3MgdXAgc29tZSBjb25mbGljdGluZyB3b3Jk
aW5nIG9mIHRoZSBnYWRnZXQgQVBJIHJlZ2FyZGluZw0KPiA+IHVzYl9lcF9kaXNhYmxlLiBIZXJl
J3MgdGhlIGRvYyByZWdhcmRpbmcgdXNiX2VwX2Rpc2FibGU6DQo+ID4NCj4gPiAJLyoqDQo+ID4g
CSAqIHVzYl9lcF9kaXNhYmxlIC0gZW5kcG9pbnQgaXMgbm8gbG9uZ2VyIHVzYWJsZQ0KPiA+IAkg
KiBAZXA6dGhlIGVuZHBvaW50IGJlaW5nIHVuY29uZmlndXJlZC4gIG1heSBub3QgYmUgdGhlIGVu
ZHBvaW50IG5hbWVkICJlcDAiLg0KPiA+IAkgKg0KPiA+IAkgKiBubyBvdGhlciB0YXNrIG1heSBi
ZSB1c2luZyB0aGlzIGVuZHBvaW50IHdoZW4gdGhpcyBpcyBjYWxsZWQuDQo+ID4gCSAqIGFueSBw
ZW5kaW5nIGFuZCB1bmNvbXBsZXRlZCByZXF1ZXN0cyB3aWxsIGNvbXBsZXRlIHdpdGggc3RhdHVz
DQo+ID4gCSAqIGluZGljYXRpbmcgZGlzY29ubmVjdCAoLUVTSFVURE9XTikgYmVmb3JlIHRoaXMg
Y2FsbCByZXR1cm5zLg0KPiA+IAkgKiBnYWRnZXQgZHJpdmVycyBtdXN0IGNhbGwgdXNiX2VwX2Vu
YWJsZSgpIGFnYWluIGJlZm9yZSBxdWV1ZWluZw0KPiA+IAkgKiByZXF1ZXN0cyB0byB0aGUgZW5k
cG9pbnQuDQo+ID4gCSAqDQo+ID4gCSAqIFRoaXMgcm91dGluZSBtYXkgYmUgY2FsbGVkIGluIGFu
IGF0b21pYyAoaW50ZXJydXB0KSBjb250ZXh0Lg0KPiA+IAkgKg0KPiA+IAkgKiByZXR1cm5zIHpl
cm8sIG9yIGEgbmVnYXRpdmUgZXJyb3IgY29kZS4NCj4gPiAJICovDQo+ID4NCj4gPiBJdCBleHBl
Y3RzIGFsbCByZXF1ZXN0cyB0byBiZSBjb21wbGV0ZWQgYW5kIGdpdmVuIGJhY2sgb24gY29tcGxl
dGlvbi4gSXQNCj4gPiBhbHNvIG5vdGVzIHRoYXQgdGhpcyBjYW4gYWxzbyBiZSBjYWxsZWQgaW4g
aW50ZXJydXB0IGNvbnRleHQuIEN1cnJlbnRseSwNCj4gPiB0aGVyZSdzIGEgc2NlbmFyaW8gd2hl
cmUgZHdjMyBtYXkgbm90IHdhbnQgdG8gZ2l2ZSBiYWNrIHRoZSByZXF1ZXN0cw0KPiA+IHJpZ2h0
IGF3YXkgKGllLiBEV0MzX0VQX0RFTEFZX1NUT1ApLiBUbyBmaXggdGhhdCBpbiBkd2MzLCBpdCB3
b3VsZCBuZWVkDQo+IA0KPiANCj4gSGkgVGhpbmgsDQo+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50
cy4NCj4gSSBhZ3JlZSB3aXRoIHlvdSBvbiBkd2MzIG1heSBub3Qgd2FudCB0byBnaXZlIGJhY2sg
dGhlIHJlcXVlc3RzIHJpZ2h0IA0KPiBhd2F5IChpZS4gRFdDM19FUF9ERUxBWV9TVE9QKSBhbmQg
bWlnaHQgYWxzbyBpZ25vcmUgdGhlIEVuZCBUcmFuc2ZlciANCj4gY29tbWFuZC4NCj4gQ29uc2Vx
dWVudGx5LCB0aGVyZeKAmXMgbm8gcG9pbnQgaW4gc2NoZWR1bGluZyBhIG5ldyBTdGFydOKAr1Ry
YW5zZmVyIGJlZm9yZSANCj4gdGhlIHByZXZpb3VzIG9uZSBoYXMgY29tcGxldGVkLiBUaGUgdHJh
Y2VzIGJlbG93IGlsbHVzdHJhdGUgdGhpczogZm9yIA0KPiBFUDFPVVQgdGhlIEVuZCBUcmFuc2Zl
ciBuZXZlciBvY2N1cnMsIHNvIGEgbmV3IFN0YXJ04oCvVHJhbnNmZXIgaXMgaXNzdWVkLCANCj4g
d2hpY2ggZXZlbnR1YWxseSBlbmRzIHdpdGggYSDigJxObyBSZXNvdXJjZeKAnSBlcnJvci4NCj4g
DQoNCkhpLA0KDQpJbiB5b3VyIHBvaW50LCB3ZSBtYXkgYXMgd2VsbCByZW1vdmUgdGhlIFN0YXJ0
IFRyYW5zZmVyIGZvciBhbGwgY2FzZXMuDQpJdCBhY3R1YWxseSBkb2Vzbid0IGltcGFjdCBwZXJm
b3JtYW5jZSwgb3IgcmVxdWlyZWQsIG9yIG5lZWRlZCBmb3IgTm8NClJlc3BvbnNlIFVwZGF0ZSBU
cmFuc2ZlciBjb21tYW5kIGZsb3cuDQoNClRoZSByZWFzb24gd2Ugc3RpbGwgaGF2ZSB0aGF0IGlz
IGFjdHVhbGx5IGZvciBidWxrIHN0cmVhbXMuIFlvdXIgY2hhbmdlDQphY3R1YWxseSBkb2Vzbid0
IGZpeCBmb3IgdGhlIGNhc2Ugb2YgYnVsayBzdHJlYW1zLiAoTmVlZGVkIHRvIHN0YXJ0IGFuZA0K
c3RvcCB0aGUgZW5kcG9pbnQgdG8gYnJpbmcgaXQgdG8gYSBjZXJ0YWluIHN0YXRlIGFzIGRvY3Vt
ZW50ZWQgaW4gdGhlDQpzYW1lIGZ1bmN0aW9uKS4NCg0KVGhlIHByb2JsZW0gSSdtIGJyaW5naW5n
IHVwIGlzIHJlbGF0ZWQgdG8gdGhlIGR3YzMgbm90IHJlYWxseSBmb2xsb3dpbmcNCnRoZSB1c2Jf
ZXBfZGlzYWJsZSgpIGRvYyBpbiAxIHNjZW5hcmlvLiBEZXBlbmRpbmcgb24gaG93IHdlIHdhbnQg
dG8gZml4DQp0aGF0LCB0aGVuIHdlIG1heSBub3QgbmVlZCB0byBjaGFuZ2UgaGVyZS4NCg0KQlIs
DQpUaGluaA==

