Return-Path: <stable+bounces-202744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3C8CC5805
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 00:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAF91302E2F0
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2041B340286;
	Tue, 16 Dec 2025 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="prbflKMR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="acZ0lIr0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="caW8GB3i"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332F33FE0A;
	Tue, 16 Dec 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765928415; cv=fail; b=RtUlddA44CIpPGZRks7axBGVT+CC5gb4SUPtp9Q8lJPo9prUxzsb4y9sycAiTmULdJu8TecDCg6Iv3x3/GCsi+o9NOOspTu3AMTAf6veeoDY17sGtgDzPi9OWe2R4jXuxHJiz5uQFxPXnRCUhnKpkuFnrcQjWvhx2dgxNNiJgC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765928415; c=relaxed/simple;
	bh=yh5MBuITqse/bwZIsFYBL2hEytWe4rMgXzGYiIr/gqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npCyB0Nhw7DGVlvelNEj6XKz8vgr9UJumbvB4CdiuPvtfnZlsyf8U+y2Ks6kkeumEol51K1zx1FYjvnyZ0C0DQbs6Ydm8b2meCDhXEwag3G3Dn00K75HW4RFhgC80gJ+c25fR1SriaVByLZIzC9Fh0cBillTfPdyDblJmkP+g60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=prbflKMR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=acZ0lIr0; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=caW8GB3i reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGLj8hf2216842;
	Tue, 16 Dec 2025 15:06:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=yh5MBuITqse/bwZIsFYBL2hEytWe4rMgXzGYiIr/gqA=; b=
	prbflKMR94IuGSwSuZHddSfD9KRdkMPyHd0Erbi8KN6UX7eB455jldgTwkb5a2cY
	fvKiGH9y5c0vj+dIX1MVmmxUk4BMc6O8Wk45gG0q2QvHgO7LSWmAEYYu9HMiQ8jj
	QjUuSNum5NIjhsBkBPseWfwuHNA9pLUa6UFbWfGLfmOd2M/8HVcO/F2tzysbn0cA
	+Wn2pLe30ZNjAazP7OymrHE6b9diyp0P6vafmpD3ecdlvHlk0ARuKz707Q62kniK
	oH6rF7FeH+XI4LgK8DpIWYGhL+kdzpPmQ9rGUdJlF+TvOaxQcLrA+z4SaRcIP/n4
	tSrbgsd4ygyOHkQYIIAzSQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4b2vjudc6e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 15:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1765926392; bh=yh5MBuITqse/bwZIsFYBL2hEytWe4rMgXzGYiIr/gqA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=acZ0lIr094KFmYuMMM0eleww4tzi16fdIMYKHSykG/c+5Cf5EBF3xU1hNs311b+A5
	 r2rQE/RTix93TeWLjbJPF94BBqIi/cLV/tsxEwDHBLfTYHtUkrI9l0M9g/bDNoBP4m
	 qQmLyQjLjwaOW6LW7a+WnP3rqj7BZ2ZSD9NLZ/+XSH2EEWCTGzlkGnP1JH4EWRfQJR
	 9wgdLWACJ9ElS6Pa0eMSmjA6bYBY9e98aWHTWM90t7A8i+JreZBkV0iZ5ss7KmaydH
	 nCgPS2xeELvJpnNMrHs12/n3HOapFGFHidWitA5vdqoiEL04Dp4Ie0paPH9l8sOgmC
	 hDqXYQ5aNGHxQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C4DE14048F;
	Tue, 16 Dec 2025 23:06:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com [10.202.1.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 844F2A005A;
	Tue, 16 Dec 2025 23:06:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=caW8GB3i;
	dkim-atps=neutral
Received: from CH4PR07CU001.outbound.protection.outlook.com (mail-ch4pr07cu00105.outbound.protection.outlook.com [40.93.20.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C6A4622025B;
	Tue, 16 Dec 2025 23:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJWafTC9GQ+0oVxBklDoK8imck0C8xyKVjxBy6sZeh6EBmi/ss6DHOjjGMgvTX3n5f2nJrNFdcr3ZdXM3PBrJtwYLXLBcptuszGx1v736NgmmuTduCv8Dtdmj+V4h4Qbq2Re8fJSn5A3etEaxzTulsn1heJvJOUA9DnJL2a2IDLR/qfEus0awMmZ6YVpbg/c3F2HO7AoxxJ4SHySFS9+P/TEEkt2htKf1fKF7OuKvWCTrfktokjCb18k7jytKwx/8EpxRpeBYdarAAC225kVEIH7wBgZgBJQgMeaeku1BtIjxUOjmGd4vEgg3VcCckxHC7QwR/qJ7NrKJrL4sFObww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh5MBuITqse/bwZIsFYBL2hEytWe4rMgXzGYiIr/gqA=;
 b=Lt5LeIrrMdnx9WSEsbJVCURpPQoc3XwapxwKPmbUsW64e46bK10ViizQCoTF1XrFVfwhyZ/aWfc6wJO876n79UoXYckTghJhK22UJSpGmnaU5UzYnLlJfNVn1396IzmLAcJGECCET9kSthiCetqGP/KQJV9LdlG3pxJy4K1DczWEEB61FKD7a1jwpr3L8t2SadAxMXnaFRFJH7AyaLn0a9Swk6Zf1KaqhGXm7r/ne6AMWYKJQpn7GXAU6XpDs84w8Q+S4Ezd+SKhC0B4fvrdO68LG5zpj3zDhDzSsud4Yl4t8UmZnfjxEC3g7M4hZPy2ZR43cdybIKTs84YwhVaBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh5MBuITqse/bwZIsFYBL2hEytWe4rMgXzGYiIr/gqA=;
 b=caW8GB3iT9f1Ud7sudqF+6SAJOTE1X/RDzHPCnl8GCCARMxIC81Lll1ldux0kZd8S5N00oqro7BcUNH1vFRIYdTH9ZMr57Cy5V85Mti68temQR8qG0R45a2M55tK4GAgu93oY2Z6Gkpn5qmEKfgejHM66QMNVYP9LWJrlwZymNI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 23:06:27 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 23:06:27 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Miaoqian Lin <linmq006@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: of-simple: fix clock resource leak in
 dwc3_of_simple_probe
Thread-Topic: [PATCH] usb: dwc3: of-simple: fix clock resource leak in
 dwc3_of_simple_probe
Thread-Index: AQHcampcG5VRyRQZlEOXvTIrQebZILUk7F4A
Date: Tue, 16 Dec 2025 23:06:26 +0000
Message-ID: <20251216230624.kcztn2cqcaohtzip@synopsys.com>
References: <20251211064937.2360510-1-linmq006@gmail.com>
In-Reply-To: <20251211064937.2360510-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB7860:EE_
x-ms-office365-filtering-correlation-id: cb2965f7-022a-48f5-2058-08de3cf7bdbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NTBrK0J5cmxpSWpGS1N5c2F0VXIrcGlnSC9qT0owMVJQY0NEMjU1dzVYWGc0?=
 =?utf-8?B?bm9SRjNzaW4xajU0YzNzbS9CT2thKzJ4bXM0OEl1VloySEd3TWhPNXQ5aUhj?=
 =?utf-8?B?OHBhRU12eUVLMk9KdmpCSnJiMjJwVS9mcmdjL2xYcnppbXdDMkw2VjRRckJW?=
 =?utf-8?B?S0F3cTVsaFNzTjRha0hOSGZJUFJRRTF0ZmR1Kzgzblh2YVpCWWlFRVc1Zi82?=
 =?utf-8?B?QUZZVVJmak5CS0tDVHdSN1RzOXE4c1YzU25QcnJ2NVVxRmdwa1VFZHRXRjZN?=
 =?utf-8?B?MmI2cmRicEVtQWp3V0FUSk1IOEVlRXJzcHRRSmtCR081QW82WHZwcHVZNVNo?=
 =?utf-8?B?cjNtYnBCdXU5OFhJN05uaWlETHdaQ1RhWEhCa1R1dHZUbENPemJaOUZ1bW9a?=
 =?utf-8?B?bFB6RmZnZU1OUnVTWERRZHhUZ1BBb3FHSXpvUFJPak9UMW9KZzVtekFCWkk1?=
 =?utf-8?B?cnNObm9BdndaVkhmRzlZWEpCb2U4U1RnS1IzNWZHZlhvRVRVcU51WUd0dUxS?=
 =?utf-8?B?djllMTFFRkZSZmw5ZmYwaFpidnJScmJlajhoQStNQ3Fhd1ZMZ0ZXSkk0d294?=
 =?utf-8?B?Q2VxbXU2dWVUL1ljTTJkYU84RkFpVVdLdVFYVEd4c2hkZVB3R2RjSExYZXBD?=
 =?utf-8?B?QnRlQXZJSEhjSzQ3cHdGMTRuWThTamplYlhFcEJ1d3FmUE1Oa3VlRmF5bXJu?=
 =?utf-8?B?R2Rzc0FSNUNWa0hlcWwvUEVvbXBzVFR0eTFqby9QcjVQaUpjYlBNbUdnd0RZ?=
 =?utf-8?B?cWpuNU9Xb0tZbTBTYi8wYTh1TlVrS2Y4RkNPWFNXc253TitsMmUzT1E3TkhE?=
 =?utf-8?B?bVBmbEQzL0l2UEZZU0NYTzl0dHJrMTkxOUtBc0IyN0FJTFc2MzcyOVNKRzFT?=
 =?utf-8?B?d2t0NW1ha01yUlpOUGFGUFVIb3habytEYmtlQ3prZjdEOHU1QlZyMkE2MzlZ?=
 =?utf-8?B?OXB6L3VEUFc4bXZDV0IyMFZTSVM3d0ZobklSRXZ5dk53ZEtJMjFqUTA3VE50?=
 =?utf-8?B?OWVwbjBrMUQ2Wk5aejJLbXFzeWtWd2dhR1B5MzU0Slpyb2MwSlc2RGR5eWNT?=
 =?utf-8?B?V1JFREttMW5zMU92bHVFcmRHSnNWZDJMcW9RTmhKVDZRWVVGWmI5b0tvZzE4?=
 =?utf-8?B?cTAra05XbHpWME1JeVJXNzBDT1pJVlZJYzV5Q29ZbzJ3VDdadFdvV2xXWGU2?=
 =?utf-8?B?Nk9tTmhEOTVJc0dab0g4NUhlYjZDc2tNcFhsdlhCdWpCMnZoS2hwekx5S3Mv?=
 =?utf-8?B?VERtVyt6WG1qTlNpb1AzWkNsMStBRmd5aThnZmRLcXZKSFZ5ajdQdHBjZ29E?=
 =?utf-8?B?YmpIWTBYc044K3dmckZ1VUhIMlRNaW9mUTFKTHlvMU51V0VxWHdzRE5GNnVk?=
 =?utf-8?B?Vk1EZW0rTHlER1ZpT2Mrc3hqcHZML28wNFhaM1FQdkNXVExuKzVnM25hUWxW?=
 =?utf-8?B?UUVQdUZuTC9INE4vTmlWejdSeG8zSmppRnRjd1NSWS8vSDc4cjJ1L3g0YUFJ?=
 =?utf-8?B?MmM4MVByT2JVNGNsanoydEl2OUhKZ3BaaElFM1VhZlg4Z21vSnBKeERqTDgy?=
 =?utf-8?B?QVk4QmhjMDVPTldaWjViNVIrU3A3Rm9SMmhwZ2NkOU5BeWt3Q3hZQm1VUExZ?=
 =?utf-8?B?WjJ6aGc3YThkYTFsamNsRTFyb3I2ampPYzkxWENaOTY5QTdWZWE2SmtBUDdE?=
 =?utf-8?B?cGM1MDJMSmV2YnFMZ2x2RjdMRXZ4REJrNzRJalVsQTl1YjMrWGpVK0RTdnB2?=
 =?utf-8?B?amxHVjNoU1NUbjBqUkpRQkRycUl0RS9BNU5nZmc0QTk3dXo2UnlKRFgrS1p4?=
 =?utf-8?B?UWlyMVJRMmdqaU9kbmw1dTVYV3MyL2JCY1NEcjI2R013UTMwNG5zdEFiUUR6?=
 =?utf-8?B?RkdmZ0dpVmNpRkoreEpNNHRKRytjSFNCejA3STc3N1Q4aHRuVC9BQjNyNU9Q?=
 =?utf-8?B?M0xaME1SZ2FSU0VoRW9vLzgxeXVFbVVqK0hsT2FRSUFRaDlnTWJneXBDbjdI?=
 =?utf-8?B?VzZwb0VTNEdSbFZzTnVuMG9Zb3RQQ3ZUQTlDdDN4d3hDTTNlUmVTZzN6YTZp?=
 =?utf-8?Q?VvmF/D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmlVZnBoT24rK2RPeGF1MmpTaVh0R3VtVCt0a3ZwRWFFbFJaYkRiR0x3aUxs?=
 =?utf-8?B?VzUzeGt3aGtUZGhNWktWZE44RFNWeHdUN3ZjT2JBZ3MwRUVIMlBmWWNNU05U?=
 =?utf-8?B?U0ZvcjRNRUkyTC9GTWx6RTM1Y1Z5Q1BUNUUyVjhEemxIZEMvaUJtVkh0aDJu?=
 =?utf-8?B?QVA2STRHd1hseW9PNUdqU1VEa0VQN0ZJV21mRm1sRXpvZCtFWFFacGxWNTZz?=
 =?utf-8?B?b25GcU53V3RNcEhQUEZWT0xMZ01LV0UvSXNYZll2OFI0eW1XeHZ2U3o2U0Zp?=
 =?utf-8?B?aTFuUm4wTjdiVEdwbVZPMTNRQ1dJUGQvY21aSnFzblg1UDkvMjMzQUNCUWdD?=
 =?utf-8?B?dS9JK0lKeDYydUdDTU1Da3Y5bDZjRlZsNHMxeFJDVXBlTzVQY2hyOW5tWTds?=
 =?utf-8?B?UWQzenhLOHhsczM3c0dnWWNZZXMrUjFRYVNZYkwxSlhmS1pJOWRFbW5JRXpD?=
 =?utf-8?B?NWNQbFdJZHlDSk5rUzdPVWRxOUxmMWZKQ1RHem5vWDlnOE92NHlQTmxKL3hN?=
 =?utf-8?B?NDBxQXVUdTlTZDV1cnVUWVFmd1N4ZVNnMkJmNnBqS3NxSXo1RUpHbmQ2UHFl?=
 =?utf-8?B?UVRQNHZ0L3BsMTdseEtzRHcwd2ZxNnhONUR1SENjZ3g3SUUrTDNVckNFb2Zp?=
 =?utf-8?B?YnF0ZWtPZDNaMVRoSXpLTXFXYm5rTk1lQThZN3Y4eXdjam84ZTh0MnBrRGJX?=
 =?utf-8?B?Y1B3a24yQTladTg1YkhlankxT2paZWM0RGcxa2ZGa2E5SlIxZTlrbnRDUTRj?=
 =?utf-8?B?WENKOWVaRFUxUzJhZHpXS21jQ28vTytRTmhEK0xOQ0V4VW1HcW81RnFlaWJr?=
 =?utf-8?B?MEQzOU8wTGFXenZHL21XSE5kNG5rNEcxMUxqWGhiOFVQS3J5SVIyczZ0d2Nu?=
 =?utf-8?B?ZnRabUdtbjFtYWVvRG56TmtlaTNzM084bGFmMW5RaFNmNlpNb0FieEQrOHYw?=
 =?utf-8?B?TTJ5UXdteW5Rd0ZjUWczN241TlhlVnM3emhxSFlLcGNyVGhvaW4wY0IzODhX?=
 =?utf-8?B?c1ZZMVRxU25GckZFMjMwNmZyTHY2Rkg3aC9icjI3UGJHQ0dGK0Y1bHBYblZX?=
 =?utf-8?B?S0tncWpQYlB2SnZ1aWdjNVUzTElnOEtSUGZGZXl5c0gzSmRpSVRyZzk1QnZX?=
 =?utf-8?B?NTcwWnJZKzRsOXZGeHdxckswS0J3N0JBaUlRdWpKNkhaZHhxeU90ZXc5Z2R3?=
 =?utf-8?B?d2VjMEp0d1MybUQrOXpPOXozYzlpQTZNaFJ3cjhzckRRY3JVVUlMQk9ZdzZH?=
 =?utf-8?B?V2krbmJMQk9nQk1GOWticHZ5NUJkSU9BYjVZWDBCbldQU0xtQkVXNG1zQUVh?=
 =?utf-8?B?R2JQRmtmVFpjVFdTVG92Y3B5QUJaSGRNWUVvbmVUemo3QjlwdDVudDE1OUxS?=
 =?utf-8?B?VUZ2N3Q5MHRYd3M0MzNobzlCRkxUK1dLSHkzUmh6ZXY2QWhYOUc3blJjN2ow?=
 =?utf-8?B?NVFpaUprUEFvKzllakhJVVBQWEtpZ0MwQmRmNlQ0VjdDb2dsb1NTMU1wY3FU?=
 =?utf-8?B?MG14M2RJQ2JBVE9FL3FiQWY4ZEtXQXA4a1BpUHptMzFybHowNmRnMjRMaFNo?=
 =?utf-8?B?bVh5R200Tk5LMTF3OWUyVFpzVHBmdVpvQ2dZZjhxU2dXOXBpR1JXTVB2VEJW?=
 =?utf-8?B?dGdzR0NjVVFZOTlzNDRZK01Wa3NKWTRzWXBEcE1QN2g1bS9nd0N3UzlrMVdm?=
 =?utf-8?B?T2Jpd2FYTS9YSmplZ1dZR244NE4zdlFhQUg4YkgxNWJSbEtrTTVnNU41cUFa?=
 =?utf-8?B?V3JDdENoQ3ZJNHlXY3V6cFVhVkFmWEhVUXNNM1dFQkg0L3ovMnV1NVcvMXQr?=
 =?utf-8?B?WjEwL090ZEdGSnlCR3N0Q2Z6OHlrTzVHMDNHZjh1TzYramQvUzAyRGpGelFu?=
 =?utf-8?B?MlFvc2ZUZVZOOC9hNTNMYjVRRTBzVm5FNW5vY1U4aU5BdVpxZU1GODdJUnBs?=
 =?utf-8?B?aUFnWXJ3VTB2by9YLzNNMVZ3bit6eU1yOHhDYVgzQThJMk1MREtrcGNmK0Z3?=
 =?utf-8?B?M2JEdTZaRDZ4UFhGbjB1QWk5VTdBMEREZEp6Ti9SWjhPZnNyWUY5M0xWUFpB?=
 =?utf-8?B?cllpWGx0WjhaQ2E3UTF0WXNrd3UvdVpxdmRlU0VtZDg3cG5KTjJGOGhGZjg0?=
 =?utf-8?B?V0hYc1dndXVmTkJLeG5VdEZPTVAxL2cxaHpxRGY5MXNsWjZVZTRWdmJsWXRr?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <013D4BD2DC964247B21EAC11088F47E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pTech1BJV2ABr4PEyHPUmyTLtg3J71Bxtv+rxZsIHGaHiztboL1Cj7DIummijuzod1i6Vq8zZvkJk6xILKfKh4UivtKwN4sHFlPtzYI0S72m3PgjkLPvLP2xrV8bMOP5slfapbj2TgimDBUGiFIfiQtBRypazr5Bf/L4rjRy4IDBCess+a9cSKjrIXCwoY0wtTtefhUVcT8uuiw2kY0IXSFBdhcNgyKCrWXe4wc+uoqoBHHipJ48YNOoTFVRiYIrd1INVrT3lp5KUiusqLFKKiXyq0LMJbB4dc8mtirEcoQc7z3eLpf8K8Ef8a4HkARnPk+KExHixjvbeCaHR0Q/K48dShK/Dfg1t7Y83afWvTS/a2xe+Nt2nR0PdM1H018LTnt+HfPJlfDC2CKZdXSRSJO0RixhTq/ewy7hrC8vMlrOSUhI3WMtjykmrKmCH/CUk+rIJ2anCLVgvszxb3xPemBZpzJztpsZ8Y1zr+DL9RTNhlF3nVbRxouiHhgRWKf+2OjpOMxlJOXdpkbcartcHNDSXIcvZDevD8mCwLGs/S2qwMswqtO/wIGaa+Tn4Ab6Xve8IIeJUtx/lmy3nrytwGAT8aw14td9CD/80ToYCzejIxvdq/fZ6hiEuKe1bIXDLRrQ9UndsCoF2vLfiIMZhQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2965f7-022a-48f5-2058-08de3cf7bdbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 23:06:27.0855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okWpY9YuAiqltfjjZvi4JErtzspLRInBTGN1N3M7FQM1/M2/aYYTV1m+aEzCBtTz3epdf71wLRoZ3oWC6G7WHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860
X-Proofpoint-GUID: 3Mt9hqvBdyd7DKCEbM-iiUF878GonMd7
X-Authority-Analysis: v=2.4 cv=Ka7fcAYD c=1 sm=1 tr=0 ts=6941e5f8 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=jIQo8A4GAAAA:8
 a=e6Dcx8WNQ1jhqHQgsowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE5NiBTYWx0ZWRfX0vi9oANE16s3
 WPdzzPcM12yeQAo5BlQLoHKwnt3K+fNcdibctPjwRbBDwWDWlqvjIxzLtIcGZWBEBZrDvytX5aR
 3sc1fjCTSdHiOHRiZnjqO9poTd9PhUdYdJVNSkCaRBvrabMOk4C2+Cc+7YXcar92jp92dIYn19d
 3UEsCwbBin2S8WsuOLhOye9tj5ecU2K3guU9ATqYg1P1PcDiaDPtD+2PE0Vd/2xDKBDnUrVhpcv
 fRsfVfhht75nmkCGSmVoycX825DLftRVPlnmrx7fXtkLQXV++ZwF1bk2Vr+0VlB3Bhctl1Ss7Dy
 QsGjyx7sL+qYh7rFeHS9ZV075a1zkUD5WdXgCwA6Z67TuU7orJ+M7Uoy2/0tAFP1XfrVCoML1xR
 /0rNMKPwsC+MAycu5Ho2U+EgGvbizg==
X-Proofpoint-ORIG-GUID: 3Mt9hqvBdyd7DKCEbM-iiUF878GonMd7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512160196

T24gVGh1LCBEZWMgMTEsIDIwMjUsIE1pYW9xaWFuIExpbiB3cm90ZToNCj4gV2hlbiBjbGtfYnVs
a19wcmVwYXJlX2VuYWJsZSgpIGZhaWxzLCB0aGUgZXJyb3IgcGF0aCBqdW1wcyB0bw0KPiBlcnJf
cmVzZXRjX2Fzc2VydCwgc2tpcHBpbmcgY2xrX2J1bGtfcHV0X2FsbCgpIGFuZCBsZWFraW5nIHRo
ZQ0KPiBjbG9jayByZWZlcmVuY2VzIGFjcXVpcmVkIGJ5IGNsa19idWxrX2dldF9hbGwoKS4NCj4g
DQo+IEFkZCBlcnJfY2xrX3B1dF9hbGwgbGFiZWwgdG8gcHJvcGVybHkgcmVsZWFzZSBjbG9jayBy
ZXNvdXJjZXMNCj4gaW4gYWxsIGVycm9yIHBhdGhzLg0KPiANCj4gRm91bmQgdmlhIHN0YXRpYyBh
bmFseXNpcyBhbmQgY29kZSByZXZpZXcuDQo+IA0KPiBGaXhlczogYzBjNjE0NzFlZjg2ICgidXNi
OiBkd2MzOiBvZi1zaW1wbGU6IENvbnZlcnQgdG8gYnVsayBjbGsgQVBJIikNCj4gQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTWlhb3FpYW4gTGluIDxsaW5tcTAw
NkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLW9mLXNpbXBsZS5j
IHwgNyArKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1vZi1zaW1w
bGUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1vZi1zaW1wbGUuYw0KPiBpbmRleCBhNDk1NGEy
MWJlOTMuLmMxMTYxNDMzMzVkOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LW9mLXNpbXBsZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1vZi1zaW1wbGUuYw0K
PiBAQCAtNzAsMTEgKzcwLDExIEBAIHN0YXRpYyBpbnQgZHdjM19vZl9zaW1wbGVfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlzaW1wbGUtPm51bV9jbG9ja3MgPSByZXQ7
DQo+ICAJcmV0ID0gY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoc2ltcGxlLT5udW1fY2xvY2tzLCBz
aW1wbGUtPmNsa3MpOw0KPiAgCWlmIChyZXQpDQo+IC0JCWdvdG8gZXJyX3Jlc2V0Y19hc3NlcnQ7
DQo+ICsJCWdvdG8gZXJyX2Nsa19wdXRfYWxsOw0KPiAgDQo+ICAJcmV0ID0gb2ZfcGxhdGZvcm1f
cG9wdWxhdGUobnAsIE5VTEwsIE5VTEwsIGRldik7DQo+ICAJaWYgKHJldCkNCj4gLQkJZ290byBl
cnJfY2xrX3B1dDsNCj4gKwkJZ290byBlcnJfY2xrX2Rpc2FibGU7DQo+ICANCj4gIAlwbV9ydW50
aW1lX3NldF9hY3RpdmUoZGV2KTsNCj4gIAlwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiBAQCAt
ODIsOCArODIsOSBAQCBzdGF0aWMgaW50IGR3YzNfb2Zfc2ltcGxlX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gIA0KPiAtZXJyX2Nsa19w
dXQ6DQo+ICtlcnJfY2xrX2Rpc2FibGU6DQo+ICAJY2xrX2J1bGtfZGlzYWJsZV91bnByZXBhcmUo
c2ltcGxlLT5udW1fY2xvY2tzLCBzaW1wbGUtPmNsa3MpOw0KPiArZXJyX2Nsa19wdXRfYWxsOg0K
PiAgCWNsa19idWxrX3B1dF9hbGwoc2ltcGxlLT5udW1fY2xvY2tzLCBzaW1wbGUtPmNsa3MpOw0K
PiAgDQo+ICBlcnJfcmVzZXRjX2Fzc2VydDoNCj4gLS0gDQo+IDIuMjUuMQ0KPiANCg0KVGhhbmtz
IGZvciB0aGUgY2F0Y2ghDQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBz
eW5vcHN5cy5jb20+DQoNCkJSLA0KVGhpbmg=

