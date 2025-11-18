Return-Path: <stable+bounces-195041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F19C67008
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 03:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83FC94E2C3F
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 02:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0926E711;
	Tue, 18 Nov 2025 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="krCfneuJ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WDDWdBKi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L86M64Ew"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D3A1A9F9D;
	Tue, 18 Nov 2025 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432498; cv=fail; b=RmHprCpI64JKWkSoCuXekyov8iHM0AGxh2eLXek9NuyCrP4i7vJYBK/2dKgLBI4XMqBwP6iGh3encaptfm+N0GLvrFb+NPGHlbe7MOVu0kN3KyTmhZhGHGU4k/PJMo8wt1xTpePas1hhcup7/vGqHUuLk9zGDXPiGsasny4NYNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432498; c=relaxed/simple;
	bh=HXN/PRb82exf5nzaSwEDrteKSpDYpK0jN4tJ7UGtpyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cHEDA6rXkmfRf+/dmBpWweTSlUL7ptfeebu6qexa8it/7KG8oagXiK/hj8/vWnszn2NEiOvk8KcFr5epnpxMevwN5llEhLCGBU5K4j7haSPP68Zw5sMOyZvj+Q7KUshNASTqYG4uJRZSmiqwgpgDZqiMuxEAUwbQ5CMofPS+/es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=krCfneuJ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WDDWdBKi; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L86M64Ew reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AHN2Rjv061943;
	Mon, 17 Nov 2025 18:21:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=HXN/PRb82exf5nzaSwEDrteKSpDYpK0jN4tJ7UGtpyA=; b=
	krCfneuJ8lLu3G79Zui9XUmZG9C1TCl//EfGEYu+r7wn6QC4UcouYuHehJnf8f02
	h5YfE01ItD9wkf32kBbhBj8gS1XRET8rOO/X90yfGDpWbSw7+HjFV92Wbki8ed6E
	olWyEEKz0fuG+NUOKRy++jIX7oHIiUDFQMYMTvvntg4TSix38GWBBNcr7ccI+Jb2
	MT56PqY019LI/hEI4ZYX8tun1XfTbkYEqlrTMV4z8I5XpU7/csKpWffH/NRvpXa3
	n0thKw1av4c28Zf5Fkkkuxf/Vc8T8NNNPTcGDJCFbVQqBV1RNbeSywCeDHn4y22a
	XwwDA44D1mHFXlRFmjppfg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4ag8b31t1j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 18:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1763432484; bh=HXN/PRb82exf5nzaSwEDrteKSpDYpK0jN4tJ7UGtpyA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=WDDWdBKi+DvBLy35urUzxwGfR8VmRNtSPE/GqgrMLQGcaiy9w2vulybT5QmAZFqeI
	 N3NoExTAwuEgfrEpkUKudKLIUC81rAZI5G8axUxJ+jgtUOw+5SC61cCnprk/BimgEO
	 T1Rb4+j+8prIpXWsS5qDT0T+ae1dNbHktgmAes2ZVpRWleuzHCcCb2TsKnzU27yOJZ
	 lCFP30Lpev9BqM07BlpvINgXGO1L48JlSt6qkdDVZyZlqXF6BMkwsE+ommnXwTZNFS
	 2/oKxXkOLh7QG9ojRCijBw4EK3LsLevFfIlTZ1VA5tJLjvcx6zfX5+tknThfg7Sx+t
	 ByAa60Wm4zEwQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 12CDF40359;
	Tue, 18 Nov 2025 02:21:24 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 1249DA0089;
	Tue, 18 Nov 2025 02:21:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=L86M64Ew;
	dkim-atps=neutral
Received: from BL2PR08CU001.outbound.protection.outlook.com (mail-bl2pr08cu00102.outbound.protection.outlook.com [40.93.4.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C36AF4028D;
	Tue, 18 Nov 2025 02:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdjOlvGgiKinknjl7Es6VtA7jnFVOWp+DKziqqQrkH2p0us2v8lASclRskzCGEkkNkRbufBDr76PLaTxGY8LK4Lb7BInEpd12/9a9AfM6brwK2pyz4VKoswbdTRBtE2j06VyhRPe1XQ6Lgdz2imd8RsythlBafMo3CcjfhEZ5gscvbBmwK9GlxCY7Nif8zg7yQqh2jkMjJryKZbsCnlOicaEl4wJHM8j6soHSFIIzWnUQKPuOQcPU5koZPwYJwupGKlWezaAeCt8lcDU7W/MlhKy1Vdjr6sWiMTrBhEGPRKCwZjxZPBSOf14e47W92pCtPej2/7kWLcPpl0eedwoVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXN/PRb82exf5nzaSwEDrteKSpDYpK0jN4tJ7UGtpyA=;
 b=RhSuKfue9Zr64OIlpyftD9QZDO/9XkLaoCvgvFo0Ubbtk7g5idIDliVOGpXnkQkUCBjm4xhAM6SHtPxGlkhkC158qhK+q1btw+NlAWlEh8rJMdpLA07H6bXAo+LNcPuYel2hglls9NrLMwKGq45Y5VMTQjVVY5F4scCN6HVBtqek5kiTDOMoonYlX1mvbnxE+h6T7lqW3ZJ47WLIKHKAK7/yoyTjg5yokf9UDZPTaf52UQKzF4jpN5/Esuj12Oe3ZolbthvpLvgGItYoxqCahdnle0xN5UIY/U/L689iNbPJkFftUzcJkhiC1gIbNGEzPcY5qTw9iOhdZmvDM+INnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXN/PRb82exf5nzaSwEDrteKSpDYpK0jN4tJ7UGtpyA=;
 b=L86M64EwJJ9TL3K4DjQCjD5yKMiXqTgDFY5xt2Mu5PCv8rZTOtFdw+cxINBn6n3pKDLbqKpV60irNvUImCB6X4uqEw2JeE0YHbNV3FLPFZA/0wecKqhoOWpqggpMYm6f4Zciult9rPf9sh7oHXCB/K4OJVFM7AINzgGVNBda3c0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV3PR12MB9215.namprd12.prod.outlook.com (2603:10b6:408:1a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.20; Tue, 18 Nov
 2025 02:21:17 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 02:21:17 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>,
        Alan Stern
	<stern@rowland.harvard.edu>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Index: AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIA
Date: Tue, 18 Nov 2025 02:21:17 +0000
Message-ID: <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
References:
 <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
 <20251117155920.643-1-selvarasu.g@samsung.com>
In-Reply-To: <20251117155920.643-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV3PR12MB9215:EE_
x-ms-office365-filtering-correlation-id: 3ad23d66-4656-4fb3-7b20-08de264927c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkptM0Rpd0wvTzE0ZmtZTTRYYUV0blZOUE5lbDZqTUdJd1VCU01xaXVpK1Mw?=
 =?utf-8?B?Z1J2NUE3VGUzSDFHRHR0RnQ1aHJHcTNNMVdyNXdIY1Q3ZzhlUEdsU0thL0FI?=
 =?utf-8?B?eWpLcmY5UlhwYkN6UDBIamhsbzdOTE03KzBYNkV4QkhiSlNadkRVbWhKQ0lS?=
 =?utf-8?B?UnpnVFlPRFBXM3pCcmpuNXFMYytIL252bWxYMWRNMlJaQWwwZE5sdC9pTGZP?=
 =?utf-8?B?bjIyL0VJdHhXclZ1U0hJOExxS3h0N0lQemdGbm8veXBBSDRRbGJxVTJzTzNt?=
 =?utf-8?B?UCtBandUWDZPbFRZSkwxQUw3aGs4UlZkRzgxZzg0WVBydGlmMzBnSGZKa2NM?=
 =?utf-8?B?RmtvSEdqYmpFYmE3LzYzOXIzcVVYcHh4SG4yd3pNb0xlUVZrYjRsOWdPK0o5?=
 =?utf-8?B?ajFCcFFObURMd2oyZWhuYy9VSVFyalNwNnY2Tnc1Z0dUZThsckJxNUk2MnZh?=
 =?utf-8?B?WFZvaWwyYjNMR2k5bjJXbFd1YmJjSzJ0NndvSnJtZTFiT3BxNzBCSVFOQ2FL?=
 =?utf-8?B?SmExVWVRMU5aY3FTeWUrTWJoZHpnNS96QS93VlQ1bnBaQi9jRDRZY3lGaytu?=
 =?utf-8?B?ME1wZEtjK0lxTHpaTjJpNk9yR1VZZCszRmNGOVhJZm1ibUtpZ2sxZzZENnRz?=
 =?utf-8?B?eTF0eThrM1ptanJrL3dJRXEzaFlMaksxbGlSZXV0NVQzQTQ2NTF1aTdSM05h?=
 =?utf-8?B?QTluWDI2RGtuZjRUTXBGN2VNMklFMXlSc083UnhvcWZuanhHZHlnVG9YRjNm?=
 =?utf-8?B?R0MxbHlkdnhxVG0yZEdpdWpNeHN4d1ZqVjY5MVVxd1JNQ0R2ZjlIMllra2xD?=
 =?utf-8?B?cnljS3R5QWIrL3NaSENGd1JCVk5Pc05nNTJCUC9BN2gwUmxTdUZITjVKelRB?=
 =?utf-8?B?cnBEdVdtUHVkdFB5Y081SUx6dzBVOVBTWTFtY3dvUHZYS3VJL3RsVExEaWl5?=
 =?utf-8?B?dXR2Ujh3cDZva2ZoQXBUQVhHRlkyaUJlNnk4bHhmdVlxaGwwOG5JbUh2SFdp?=
 =?utf-8?B?djl3N3BMVzZKK3pFanlZWFd1cW5SL1JsTzcrWG9JUi81R1dVTERxbEhzd25T?=
 =?utf-8?B?K01kY2FIQ1QyZlhiUS8vRDZodXkvMWVwZXRNV1p0Qm1WYk1CblIxcWdnQktr?=
 =?utf-8?B?NjMvbGtwVTNoSm9zR3FSby9DZFJFUVpUWUZwQ3h5ZkV3NHB5VXl5TjcrOU45?=
 =?utf-8?B?RlNuUVBDYzdtZm5La3c0dDg0UlUrK3VXbFovZDUzK3p0V1NrYjEyd1FHaWJH?=
 =?utf-8?B?VjJRc2E1NFZzclQ4aFI0bXZVVlJhcHNabTBoQ3d3dzY1a1ZwVWR4SG5nWU9p?=
 =?utf-8?B?MHV6WGh0OHB6Snk5NlphQWdZdFJja29GSWtnNGc0MjZHQU9zL2d2SWltWE5T?=
 =?utf-8?B?ZU1MQy8rVTFHdXIyVThDN3pYS2VVMTYvTkZ4c0l6VjgxaEZDZSs4amhRZklz?=
 =?utf-8?B?aS9sZ01MQ0M4NjhjYXF0eGtTZTdVMEkyWWRRL3FEZU15WVE3VUZadUQ5YWx4?=
 =?utf-8?B?K1lhV1ROR0x1Nmg5SW9yZmxsNjNrRXpXQ1lHME9xZ2wzbmNOQVR0LzBzbzEy?=
 =?utf-8?B?L1R2Y2FLaTRwc0FTUEQ2SzhIaW9CUCtPNDc0WUQ1cHlaL24zQ3NDcXBramlv?=
 =?utf-8?B?Y1dFVEdqWkxDMEI3MEdldXl2VFh5dmhJMnBlQXpxNWxXMFZVakNqSTE3cndL?=
 =?utf-8?B?b3ZwZ2RLcWZLSmJ4OU5JQ0NMR2lsY3gyYWRLUkhnN0gwNEdkTlpUeTdkYW1l?=
 =?utf-8?B?N2xlR2lETFgvU1ZQdG5DU0RNOEI0NDlBQVhXU25mbjdsRzk1dGlBN0ttZUhV?=
 =?utf-8?B?UGRhUExCam5ablA1TmNqS1BzMFZUMTRHUlY1UEpQdFVaTXlBYUZzb01qL0l4?=
 =?utf-8?B?NzB2aXBZYmJURTdTZ0RiN1kvVlcrODlnVUFzR0J3QjBSZThERVVzYm9hblNr?=
 =?utf-8?B?Yi94L2JPcDFCWkZNblZuY2dUZ1pxK2RzOXBpSTQ0OXk2Q05nT3FtYlpjQUVt?=
 =?utf-8?B?SC9QSVhGVURGQmU3YXhSN3Bpd282RmVvQ2IrV2tkWXdkazF5ZEU1aVpFSTEv?=
 =?utf-8?Q?w+qTpK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NDRlUHRuSlJmK3hBelVzWnRydEZDVzJYRVgycU5RbWhkek90eUphNlZmeGpN?=
 =?utf-8?B?M2REbUhmZFRGZStQVHl4Tko3MENXOU5Gb0IzSlZzekRvTjhqZzJHdCtHZ3Y4?=
 =?utf-8?B?M2ZRVzI1NDZ2ZE4yRVNNUDVDbytJT3BNZTRST3F6bE5XbEtoemRSQlJGdWlM?=
 =?utf-8?B?ZEdueDFiUzBqWVhYbmxHbVVPbDQzV2hlMHJlS3ZvdWdWTnpSRi9FWkJoSEJz?=
 =?utf-8?B?Z1FVdnUvM2NINzhmamZmSkloV1hyM2VEMjVKdlVqNjNMdHhyVGdueXFCWmhx?=
 =?utf-8?B?Y0VXVjVHd0YwL01OYmkrdHJHcGllNm1Sam0rY2dPZGJVbDV0R0dLU013QWo0?=
 =?utf-8?B?UVBqeVNyaTdEdHFBSDRYL2p0YUlpQTFtaEYyZ3hJanFIUWZGU2NiTjVSSEVR?=
 =?utf-8?B?RlB1emxxcU8wRnJGekQwbGFDNmQxS0ZkWWJJekhOVFJTd1pqSmVBL08rc1hh?=
 =?utf-8?B?eTBrN0MwVFpOeURpQVFWQXdFbDREdHlONWE0M1JZK0pOcG9yWHZQeVVBUDVR?=
 =?utf-8?B?RWVhejZHb3Z4UW1Ia3Q4QW41SldSbnQyeEtleEUwbFZ0SU5jbmd0REtCUlov?=
 =?utf-8?B?Y0w4RUtNZ0pOWEI2OCtrWDdqWExTMll3ZHNIdjQ2bU80TGlLM1c1VjJkbDdx?=
 =?utf-8?B?SmtiR0RjQ25xdmdwM2VCR3V2K0hmVjBob0lTekZLN29RVUxlOTB4a0JWRHNY?=
 =?utf-8?B?bXpad1BDaE9FRjdCZUFRYm1FczVVanVoZHZCQzgyYXg4VVpSUlN6T1VvSG9Z?=
 =?utf-8?B?dXRaMUczS0NyZUl3VlBCcG5TSUo2SjNReWdKeWRBcmtWK3hCNjg0NThDcHEv?=
 =?utf-8?B?akhxb2hBMUZJMm15Z0R0Vi9CVzMrbjV6b21CUHc5L2hVbm4weWRJU2NFaDEz?=
 =?utf-8?B?SUF0RXRFTHhvQlRYVGJnTDdNblgvVUNKcktqZEJHL3NQVlI3eG5GTU9YdEpD?=
 =?utf-8?B?RTRINVN4R0wyR2VhcjViSGlWUDE5ekdNZ0VTNlZ3YU02TjczaS9Jc2NEalJK?=
 =?utf-8?B?SSsxaDk4UFhVT1N0YnBzTjhZWmVSanVMQUw3OEtsR2FUNWdUUThIOGRsYkhB?=
 =?utf-8?B?UkRZYTd0OFIwT2hpMlErYmFEcXJqbkxFMmFpVHJoMkpINE9KQVZ6T3g5ams1?=
 =?utf-8?B?ODhaUnI1T0J0T291ZTAvTHZPdGN0N2xHa2JsSWU5NlhEbmxZd052NzVYWjZB?=
 =?utf-8?B?NHRaeDVVWDlmZkxCbGQ2SGh0Y1IyMXY5TU44NEdPTGhlTzhVcUQyMi90MVhK?=
 =?utf-8?B?NkpZTng4Qk11bmRaVWdyODd3K3I1ZkxhZnhjNVNJV2Z1ekMyL3Z6MXNDZytn?=
 =?utf-8?B?WVZEYlFBVW1CbHptaFpYSCtnY2wyeDNnNkRYOXlTdGVEc2NpNkFVRUczelA5?=
 =?utf-8?B?SU1jYjNob2lZNEppWnlaUmdVNlVMeHFueWZqQzFHUTdLWjI1TmpEU2oxQW05?=
 =?utf-8?B?MHo4aHVZU29HUTFwQUdUMUhCVGtJNTFSMHFmWDBUZlBJK0F0cFVpK0RjWjNI?=
 =?utf-8?B?L2VWSU1xYVpOZUE0ckVIODZKM1R1d291ZmJvbGRTUFplVnBBUFdNMlE3WTRT?=
 =?utf-8?B?Qy8zemJteFRqeHpXOG5JeXhvdXFHQmY5N0ZYUW1DWHpHeGh6ZGM3QU01eExx?=
 =?utf-8?B?MU9EQXIyU1dpbnFUUEo3d0NHQjRlcUtiUlVsUklFNFZ4VW9ndTFEcURUQzQw?=
 =?utf-8?B?eFYrdEtuZmlvNU9rMTIvdllFWlV4VElxRHEwZWpWbldWUktxcWNhR0JtSHMr?=
 =?utf-8?B?NzJzVW5Da3NkL1QySEY1YWMrZjl2L3BtblJhY1ZrOENJSnVwTmtVK0pkSFNz?=
 =?utf-8?B?QS9aRjJNQzJ4UDZDa1JocUhpeUJKYnVSZW92VFp6TFJDQXhSS2FsdzRLL0hz?=
 =?utf-8?B?WXFXNFYrSHMzUVplUmNiKzFTMXJERFNLbEIzK1ZuY2xNbWRoa0d0TmIxeWhY?=
 =?utf-8?B?cXowZlNsVkFhNUNXVXNlNlFvN29JRUhVSk1Pb1JkMFk2T1FkT01mcUhzSXpo?=
 =?utf-8?B?aGsrWGVIUUJia0RXeCtVNk4vSTh2WWxvdGJDd012TW0zV25KYXNiWG1GVTZV?=
 =?utf-8?B?VGNMa1VrSjIvN3hiR3F6OEFIdTV1MzlzUUg5NzRzeWNsU0xyWS94MVVndXJM?=
 =?utf-8?Q?l224MIE11DQVcVqBDYHLGg7va?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE57EA8B0361114D8401B07D767ABD3A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F765wTG0y2fFwpScMCVZ/Lk3Wa1zyT5un5QBVEFcybJV4zjmRWj7NlEW4VPXBHeLbhucGqFtmTVVaq/FnCG1oWm1gcNLbLXcOWWJzwWK30BcARsQvFZ6ibmyd+TSfmsND1R6FVMYvSzz1+bnIyp0JLd1D4G7APlPsD1obUTmmuLyiWav82x6jcv85wdGyxUAlabveAtWKv/Y7Z3m1Gs2ADI9Ar0T3tJLe+2CJaiYo6Vj4lur+wGs8BFda7XJMDv31XAiT+IASN4pj9p9vUGXe3o/EcRjxPiThlzYC3IQP696WOyrbKulxGkoNLjRtXjhPDfsOTuLkDiQfKzUphQdSWulH3jZlnifXU/eh7Hg+SYdFf8diL/MAUiWjCglKoqxwY3mkk/3KUVf1cVnKbPo8SjhRFWMB6dwCvrArttjOtiyn69MAJ3OIpxkAEAtRf+bXw0Q1schJ2KepKQAz+eZm4ncFS2xzgKdXJILjZPet0gTQDhfQ2Iad8h0R19hv8cJjowYBjdbM9kdo/fqHKOV9FkQbsQfpffCpakmei6eNN+a+gZ9QtjDtJ2tV914Oh+Ae/ic2AbTe1YESiz7akRBFeAkPZiUPVeRwAIQGWs8DgM4cpx9wfj9DN5QXXUhXrmwbxE5zcecYZm8RfjMoYkegg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad23d66-4656-4fb3-7b20-08de264927c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 02:21:17.4825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddzdZS+nwe3a2gtHKT/DBusLRlw28Z8onaeHC14QtIEbVl5LHuS/Ks4yl/AzVZiE4bw1U0Am+W3z33j8nSeEuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9215
X-Authority-Analysis: v=2.4 cv=W7w1lBWk c=1 sm=1 tr=0 ts=691bd825 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8
 a=cFrQ6hbm5z4EuNxgfJAA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: S_lZf5gS8rLadA0WLwzADeKSnslFqnHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDAxNyBTYWx0ZWRfX/tm0y/EMYa6q
 U1iMdaxGfHrMJjRxscba/IEiMpMo88anlMpFoLNJ8rKTx7E8ex8J23RdvMPyUnuiWnclZEpTRIk
 VWnJVHdCcTbh/puZcaqYmziAfqU6+na/Jd3WqNjzsaXxvPvjHuXq9lUEfkmo1XnfUyxUu6jB+Jj
 V/yhzkYdM3CGNzK8LDCeWLYf65GCyuJBM60lDkUkbioSASnaAE4fuAXfMSxFCm8GL7MrxZJo1uh
 RFl3Yg0yle+JqkWgcUf6l8Sg92FdNEqDJFlSYZJgvR7K/P4bVT1X9JJvmRQ/338MfginDllX7yU
 ZJKTtUOveX9GieSPDSJH5VaMD8TVudTWGRXrNoBO7jer8hrGOoa6K74tMUvj0YmFvfvESKEfGrk
 EQW8EG4QwdDhEpftGjPCCgztC6L0dg==
X-Proofpoint-GUID: S_lZf5gS8rLadA0WLwzADeKSnslFqnHa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511180017

T24gTW9uLCBOb3YgMTcsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGUgYmVs
b3cg4oCcTm8gcmVzb3VyY2UgZm9yIGVw4oCdIHdhcm5pbmcgYXBwZWFycyB3aGVuIGEgU3RhcnRU
cmFuc2Zlcg0KPiBjb21tYW5kIGlzIGlzc3VlZCBmb3IgYnVsayBvciBpbnRlcnJ1cHQgZW5kcG9p
bnRzIGluDQo+IGBkd2MzX2dhZGdldF9lcF9lbmFibGVgIHdoaWxlIGEgcHJldmlvdXMgU3RhcnRU
cmFuc2ZlciBvbiB0aGUgc2FtZQ0KPiBlbmRwb2ludCBpcyBzdGlsbCBpbiBwcm9ncmVzcy4gVGhl
IGdhZGdldCBmdW5jdGlvbnMgZHJpdmVycyBjYW4gaW52b2tlDQo+IGB1c2JfZXBfZW5hYmxlYCAo
d2hpY2ggdHJpZ2dlcnMgYSBuZXcgU3RhcnRUcmFuc2ZlciBjb21tYW5kKSBiZWZvcmUgdGhlDQo+
IGVhcmxpZXIgdHJhbnNmZXIgaGFzIGNvbXBsZXRlZC4gQmVjYXVzZSB0aGUgcHJldmlvdXMgU3Rh
cnRUcmFuc2ZlciBpcw0KPiBzdGlsbCBhY3RpdmUsIGBkd2MzX2dhZGdldF9lcF9kaXNhYmxlYCBj
YW4gc2tpcCB0aGUgcmVxdWlyZWQNCj4gYEVuZFRyYW5zZmVyYCBkdWUgdG8gYERXQzNfRVBfREVM
QVlfU1RPUGAsIGxlYWRpbmcgdG8gIHRoZSBlbmRwb2ludA0KPiByZXNvdXJjZXMgYXJlIGJ1c3kg
Zm9yIHByZXZpb3VzIFN0YXJ0VHJhbnNmZXIgYW5kIHdhcm5pbmcgKCJObyByZXNvdXJjZQ0KPiBm
b3IgZXAiKSBmcm9tIGR3YzMgZHJpdmVyLg0KPiANCj4gVG8gcmVzb2x2ZSB0aGlzLCBhIGNoZWNr
IGlzIGFkZGVkIHRvIGBkd2MzX2dhZGdldF9lcF9lbmFibGVgIHRoYXQNCj4gY2hlY2tzIHRoZSBg
RFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEYCBmbGFnIGJlZm9yZSBpc3N1aW5nIGEgbmV3DQo+IFN0
YXJ0VHJhbnNmZXIuIEJ5IHByZXZlbnRpbmcgYSBzZWNvbmQgU3RhcnRUcmFuc2ZlciBvbiBhbiBh
bHJlYWR5IGJ1c3kNCj4gZW5kcG9pbnQsIHRoZSByZXNvdXJjZSBjb25mbGljdCBpcyBlbGltaW5h
dGVkLCB0aGUgd2FybmluZyBkaXNhcHBlYXJzLA0KPiBhbmQgcG90ZW50aWFsIGtlcm5lbCBwYW5p
Y3MgY2F1c2VkIGJ5IGBwYW5pY19vbl93YXJuYCBhcmUgYXZvaWRlZC4NCj4gDQo+IC0tLS0tLS0t
LS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiBkd2MzIDEzMjAwMDAwLmR3YzM6IE5vIHJl
c291cmNlIGZvciBlcDFvdXQNCj4gV0FSTklORzogQ1BVOiAwIFBJRDogNzAwIGF0IGRyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmM6Mzk4IGR3YzNfc2VuZF9nYWRnZXRfZXBfY21kKzB4MmY4LzB4NzZj
DQo+IENhbGwgdHJhY2U6DQo+ICBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZCsweDJmOC8weDc2Yw0K
PiAgX19kd2MzX2dhZGdldF9lcF9lbmFibGUrMHg0OTAvMHg3YzANCj4gIGR3YzNfZ2FkZ2V0X2Vw
X2VuYWJsZSsweDZjLzB4ZTQNCj4gIHVzYl9lcF9lbmFibGUrMHg1Yy8weDE1Yw0KPiAgbXBfZXRo
X3N0b3ArMHhkNC8weDExYw0KPiAgX19kZXZfY2xvc2VfbWFueSsweDE2MC8weDFjOA0KPiAgX19k
ZXZfY2hhbmdlX2ZsYWdzKzB4ZmMvMHgyMjANCj4gIGRldl9jaGFuZ2VfZmxhZ3MrMHgyNC8weDcw
DQo+ICBkZXZpbmV0X2lvY3RsKzB4NDM0LzB4NTI0DQo+ICBpbmV0X2lvY3RsKzB4YTgvMHgyMjQN
Cj4gIHNvY2tfZG9faW9jdGwrMHg3NC8weDEyOA0KPiAgc29ja19pb2N0bCsweDNiYy8weDQ2OA0K
PiAgX19hcm02NF9zeXNfaW9jdGwrMHhhOC8weGU0DQo+ICBpbnZva2Vfc3lzY2FsbCsweDU4LzB4
MTBjDQo+ICBlbDBfc3ZjX2NvbW1vbisweGE4LzB4ZGMNCj4gIGRvX2VsMF9zdmMrMHgxYy8weDI4
DQo+ICBlbDBfc3ZjKzB4MzgvMHg4OA0KPiAgZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg3MC8weGJj
DQo+ICBlbDB0XzY0X3N5bmMrMHgxYTgvMHgxYWMNCj4gDQo+IEZpeGVzOiBhOTdlYTk5NDYwNWUg
KCJ1c2I6IGR3YzM6IGdhZGdldDogb2Zmc2V0IFN0YXJ0IFRyYW5zZmVyIGxhdGVuY3kgZm9yIGJ1
bGsgRVBzIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTog
U2VsdmFyYXN1IEdhbmVzYW4gPHNlbHZhcmFzdS5nQHNhbXN1bmcuY29tPg0KPiAtLS0NCj4gDQo+
IENoYW5nZXMgaW4gdjI6DQo+IC0gUmVtb3ZlZCBjaGFuZ2UtaWQuDQo+IC0gVXBkYXRlZCBjb21t
aXQgbWVzc2FnZS4NCj4gTGluayB0byB2MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDI1MTExNzE1MjgxMi42MjItMS1zZWx2
YXJhc3UuZ0BzYW1zdW5nLmNvbS9fXzshIUE0RjJSOUdfcGchZFFORWFNdmp6ck9pUDBjOVU2bHlq
MzF5c1hHa2pCQXM4Y19LamdEQ3A2T05TWmNUckYxNURYYUplRlRLMDJ2MFJMUzN3ME5RMks1X3B2
WGFrXzdjOHRJeEtMOCQgDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDUg
KysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMv
dXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggMWY2N2ZiNmFlYWQ1Li44ZDNjYWE3MWVhMTIgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtOTYzLDggKzk2Myw5IEBAIHN0YXRpYyBpbnQgX19kd2Mz
X2dhZGdldF9lcF9lbmFibGUoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQgaW50IGFjdGlv
bikNCj4gIAkgKiBJc3N1ZSBTdGFydFRyYW5zZmVyIGhlcmUgd2l0aCBuby1vcCBUUkIgc28gd2Ug
Y2FuIGFsd2F5cyByZWx5IG9uIE5vDQo+ICAJICogUmVzcG9uc2UgVXBkYXRlIFRyYW5zZmVyIGNv
bW1hbmQuDQo+ICAJICovDQo+IC0JaWYgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVzYykgfHwN
Cj4gLQkJCXVzYl9lbmRwb2ludF94ZmVyX2ludChkZXNjKSkgew0KPiArCWlmICgodXNiX2VuZHBv
aW50X3hmZXJfYnVsayhkZXNjKSB8fA0KPiArCQkJdXNiX2VuZHBvaW50X3hmZXJfaW50KGRlc2Mp
KSAmJg0KPiArCQkJIShkZXAtPmZsYWdzICYgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKSkgew0K
PiAgCQlzdHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3BhcmFtcyBwYXJhbXM7DQo+ICAJCXN0cnVj
dCBkd2MzX3RyYgkqdHJiOw0KPiAgCQlkbWFfYWRkcl90IHRyYl9kbWE7DQo+IC0tIA0KPiAyLjM0
LjENCj4gDQoNClRoYW5rcyBmb3IgdGhlIGNhdGNoLiBUaGUgcHJvYmxlbSBpcyB0aGF0IHRoZSAi
ZXBfZGlzYWJsZSIgcHJvY2Vzcw0Kc2hvdWxkIGJlIGNvbXBsZXRlZCBhZnRlciB1c2JfZXBfZGlz
YWJsZSBpcyBjb21wbGV0ZWQuIEJ1dCBjdXJyZW50bHkgaXQNCm1heSBiZSBhbiBhc3luYyBjYWxs
Lg0KDQpUaGlzIGJyaW5ncyB1cCBzb21lIGNvbmZsaWN0aW5nIHdvcmRpbmcgb2YgdGhlIGdhZGdl
dCBBUEkgcmVnYXJkaW5nDQp1c2JfZXBfZGlzYWJsZS4gSGVyZSdzIHRoZSBkb2MgcmVnYXJkaW5n
IHVzYl9lcF9kaXNhYmxlOg0KDQoJLyoqDQoJICogdXNiX2VwX2Rpc2FibGUgLSBlbmRwb2ludCBp
cyBubyBsb25nZXIgdXNhYmxlDQoJICogQGVwOnRoZSBlbmRwb2ludCBiZWluZyB1bmNvbmZpZ3Vy
ZWQuICBtYXkgbm90IGJlIHRoZSBlbmRwb2ludCBuYW1lZCAiZXAwIi4NCgkgKg0KCSAqIG5vIG90
aGVyIHRhc2sgbWF5IGJlIHVzaW5nIHRoaXMgZW5kcG9pbnQgd2hlbiB0aGlzIGlzIGNhbGxlZC4N
CgkgKiBhbnkgcGVuZGluZyBhbmQgdW5jb21wbGV0ZWQgcmVxdWVzdHMgd2lsbCBjb21wbGV0ZSB3
aXRoIHN0YXR1cw0KCSAqIGluZGljYXRpbmcgZGlzY29ubmVjdCAoLUVTSFVURE9XTikgYmVmb3Jl
IHRoaXMgY2FsbCByZXR1cm5zLg0KCSAqIGdhZGdldCBkcml2ZXJzIG11c3QgY2FsbCB1c2JfZXBf
ZW5hYmxlKCkgYWdhaW4gYmVmb3JlIHF1ZXVlaW5nDQoJICogcmVxdWVzdHMgdG8gdGhlIGVuZHBv
aW50Lg0KCSAqDQoJICogVGhpcyByb3V0aW5lIG1heSBiZSBjYWxsZWQgaW4gYW4gYXRvbWljIChp
bnRlcnJ1cHQpIGNvbnRleHQuDQoJICoNCgkgKiByZXR1cm5zIHplcm8sIG9yIGEgbmVnYXRpdmUg
ZXJyb3IgY29kZS4NCgkgKi8NCg0KSXQgZXhwZWN0cyBhbGwgcmVxdWVzdHMgdG8gYmUgY29tcGxl
dGVkIGFuZCBnaXZlbiBiYWNrIG9uIGNvbXBsZXRpb24uIEl0DQphbHNvIG5vdGVzIHRoYXQgdGhp
cyBjYW4gYWxzbyBiZSBjYWxsZWQgaW4gaW50ZXJydXB0IGNvbnRleHQuIEN1cnJlbnRseSwNCnRo
ZXJlJ3MgYSBzY2VuYXJpbyB3aGVyZSBkd2MzIG1heSBub3Qgd2FudCB0byBnaXZlIGJhY2sgdGhl
IHJlcXVlc3RzDQpyaWdodCBhd2F5IChpZS4gRFdDM19FUF9ERUxBWV9TVE9QKS4gVG8gZml4IHRo
YXQgaW4gZHdjMywgaXQgd291bGQgbmVlZA0KdG8gIndhaXQiIGZvciB0aGUgcmlnaHQgY29uZGl0
aW9uLiBCdXQgd2FpdGluZyBkb2VzIG5vdCBtYWtlIHNlbnNlIGluDQppbnRlcnJ1cHQgY29udGV4
dC4gKFdlIGNvdWxkIGJ1c3ktcG9sbCB0byBzYXRpc2Z5IHRoZSBpbnRlcnJ1cHQgY29udGV4dCwN
CmJ1dCB0aGF0IGRvZXNuJ3Qgc291bmQgcmlnaHQgZWl0aGVyKQ0KDQpUaGlzIHdhcyB1cGRhdGVk
IGZyb20gcHJvY2VzcyBjb250ZXh0IG9ubHkgdG8gbWF5IGJlIGNhbGxlZCBpbiBpbnRlcnJ1cHQN
CmNvbnRleHQ6DQoNCmIwZDVkMmE3MTY0MSAoInVzYjogZ2FkZ2V0OiB1ZGM6IGNvcmU6IFJldmlz
ZSBjb21tZW50cyBmb3IgVVNCIGVwIGVuYWJsZS9kaXNhYmxlIikNCg0KDQpIaSBBbGFuLA0KDQpD
YW4geW91IGhlbHAgZ2l2ZSB5b3VyIG9waW5pb24gb24gdGhpcz8NCg0KVGhhbmtzLA0KVGhpbmg=

