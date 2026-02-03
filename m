Return-Path: <stable+bounces-213139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJxhM+dBgWl6FAMAu9opvQ
	(envelope-from <stable+bounces-213139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:31:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75888D3000
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6B003006156
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22C1DF256;
	Tue,  3 Feb 2026 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OLT0fQtj";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AiRki+X7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Zyqzletm"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D268834;
	Tue,  3 Feb 2026 00:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770078688; cv=fail; b=jdV6qFt3F7xZ/2qhil7QNvTIqG3ZghplqDb/eczlYgmV1fa8bpC5ZPW+WckTH13KaIg/dIoV1x73Cebxm+CaGr9nqFTkjq3Dz0ZDq6qxJi7UpFJ0bIFx7hW5YqLJu3bWuZ68WFo+yOS0X6tP9t7/iL5XW0OpLwKlK0ZvtI6voQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770078688; c=relaxed/simple;
	bh=K3AHYapxXaobGXVCZAUuB3m3MhRgxrmyjl/GYx17ZIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RNHOOI2bMO5OPLhJrIfIJ1GLgqZxejkVbdyUv+njrEx3iU6Wwr/XFFpS9ue4YpQ0/1Gdc3j2tfuuY9DcC9JnefKlnQcRl6c72AgA6stXFkDSXSeobOcu6rbstED1xo4D+pEtswPBGuyl+IjbO1w6K9CVXxNERtQstZVCGvHXcO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OLT0fQtj; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AiRki+X7; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Zyqzletm reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612LsmuT2680433;
	Mon, 2 Feb 2026 16:04:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=K3AHYapxXaobGXVCZAUuB3m3MhRgxrmyjl/GYx17ZIw=; b=
	OLT0fQtjPaRjfsMyuRIJ/8i6wavkCAF1n1qE8gf6RIThwn/tAIcTPtsLO/ydJTHN
	SqVUKI/kbaCKK04lu3F+IG8LK9ZiXR6Jxe3wjACl97p0ZjD5FzMcEaNPC4IrGykq
	942g+Vg0vEutveisXcu0w/esm51XquMNkp8QEV77HWG0PxQU6Q3bHJt8etHQsiTd
	AS4Ba1Z7nPM9RG+Mquu+4Jz5dLDMLZDMTTzh4K7kjRgkjnXd+/cUsXAAqQXmrgLa
	113ekaFbPSOns0bcCPp30M8Fp4UDBqzkWypxbbPeRsuCsbKSLJg0N1+eAj4v0P2h
	99/FB+QOfHwmP1VCAJK1ng==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4c1hhxsf36-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 16:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1770077068; bh=K3AHYapxXaobGXVCZAUuB3m3MhRgxrmyjl/GYx17ZIw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AiRki+X7MYhvxSY6UyHDASJoyvCU52lx9jyKuY11UYde75VVP9bhICF77P2tnqBH/
	 oxCFV8bOP4qkIMWENk/96dnDYaN1owdzy8KOQuCsRVkWMkbqtTMXuOi7jW+h+6gVi5
	 Iq0rL1Ti41oDnybtWvOoqngDCTjdYHQvP7F+UhElwKX5A+ytS4xXUF1j1FMIxiaji8
	 2/iEZMPJpDhGyv22HnHJrUMrf/l3cEbwJrJTC7VGUBGJRxqTTOw5myuDCyLFy325Gm
	 8/KG/kccC5MApszMxiMyS9emrMSFv30b1iDsp8IsPJet13+7q+R/4I2vNAAnzgCO3m
	 aclBJlufJwMZg==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 755E340664;
	Tue,  3 Feb 2026 00:04:28 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 2273CA0070;
	Tue,  3 Feb 2026 00:04:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Zyqzletm;
	dkim-atps=neutral
Received: from CY3PR08CU001.outbound.protection.outlook.com (mail-cy3pr08cu00107.outbound.protection.outlook.com [40.93.6.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7C65E40580;
	Tue,  3 Feb 2026 00:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvqNsd/BTds/v4yG2mLHrPaGUYqN/ufj3xFhMz3ts6ajQXA59L8iLjZ4U4pfcr9WSlee71NLe/ZI4dV0yb3jqodZKrmZW/NlUfFCaKabvAjnKV38eCiivILgi1NGlNJIP7fKSGvx7nGVUaRHjwYnKM8qQs1EGnnzXY52M5Fu2XxOJ/1MG5rfSd7k1ReMYOSXWMHGNgQWstmaJp7uXzVjPVxR0LXh2Veyf0XYGR7cS3lCoN1fIj991mfgBD9VImME+dPlOIKDWdi3xYHeeIyQybzq8L08ahNJ16Jnd9WkIU1Sdye/hGpzcmhj6uQNbDy83KX5RojS4L96fVUQ8qilTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3AHYapxXaobGXVCZAUuB3m3MhRgxrmyjl/GYx17ZIw=;
 b=OeQdjqwwQPZdRqYc/Cu1rCoIz2oRscGo6fDk0ArFQKdre6cU1uJOCX280/J5ETmu52bDV1qreDXIJezvMujtjnQLoRK1OELWE/p1bf2iRXnfB66Fegt96hPZzkwOpiTVHe+P+UXaML4qNe3+p6FUMxg8vJTBpOZi+JYnNDVoW2HyFhtxRveUvgtvwtD8BrhlD/BhTTH7hLsViMzIPy6QIM3r4X2hZ7PGAPsNB8YmO7zjrlpLjD/atoGZW1890aLvZWGbobTZiDKKpRYVJ/9+fkSk46bZiRBpd8Wzdna0fNXSaFCrjJ3bLC6h3qD8AnRl5jIc/Pqh0arTLMdpCg/DkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3AHYapxXaobGXVCZAUuB3m3MhRgxrmyjl/GYx17ZIw=;
 b=Zyqzletmp07PBcuQdOcmYpv9l5dpv9NcZPAqyz44b3iiF/g99PtLTMb3SUTcpPxTrhAs378g9bUaycBIiDvKRliaKfcjVeuw/mHOsdhGaGK71qPiOc4fVa1/tcncXFbsrOkmURmj4nh4gPPhWSRSsmxww+IuPZbCvm4YrJ42gv8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 00:04:22 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9542.009; Tue, 3 Feb 2026
 00:04:22 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Move vbus draw to workqueue context
Thread-Topic: [PATCH] usb: dwc3: gadget: Move vbus draw to workqueue context
Thread-Index: AQHckRBpREVTDVaT0keB603DyWOdaLVwHyiA
Date: Tue, 3 Feb 2026 00:04:22 +0000
Message-ID: <20260203000419.3fxiarn3wh7zq4vp@synopsys.com>
References: <20260129111403.3081730-1-prashanth.k@oss.qualcomm.com>
In-Reply-To: <20260129111403.3081730-1-prashanth.k@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB7639:EE_
x-ms-office365-filtering-correlation-id: c5265eb7-d178-4195-7c6a-08de62b7c944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UTJlQTFZcXVHUnBTdDdaOWxGTGNqMlFPZmZRMUJoRWx3NTFNbTF5Tm00WmRV?=
 =?utf-8?B?S2tDbGxXazdBUVE1T2ZkU2hmNGxoN3NDM3ZhMnN2bDR3SXVsQUNNbWJEVFdr?=
 =?utf-8?B?S01rdXJhSzhTQjR3bDBUbllhZ1NrVjdBd05CMnJlZElKbE9Rb056Y3dxTlo4?=
 =?utf-8?B?UGhuYW5GQVQ1WCtwM0lMUUZSK3BybU50QURYUjdSbkNGYm83Q2ZtaGNNTC95?=
 =?utf-8?B?cUNlYk9GamRkVkp1ZzB5ZkFqTFN0Y0ZKZ1FVUHNHVnVWOXNDOFFMK1BnNUFZ?=
 =?utf-8?B?QnMrcWgxUG5XdVc3dTdZcUFxa292TFpiNXI0b2VrMmNLekxPaUt4UzE2TDY2?=
 =?utf-8?B?MWRZNlJ1T0RiS0dEcnBwWlMrYTJtSDBlWnV2eXRGN0RsMFZINzF6Y2pHS0F3?=
 =?utf-8?B?aDUrZG9MZ0tPeFdiV1UweDFScXFDYlk4V3VtWG5oMjNjRTREcnBzbllZVkJL?=
 =?utf-8?B?Nm9sZy81OE9sL1B1U2ZDVzU5SlFNVmRua09hd1V3TWdLek1zMlgvSnBSTktS?=
 =?utf-8?B?a0h6UDB0K0M2bzJkUVBORmlxL29EbHNLK2VOSGxlMWlZaEoyQitiVG1kRkxY?=
 =?utf-8?B?bC9udmJuUHBvdkJoNmIwQXVkelFWZ2ZFek1tTDhtdDFLSTdXOUpaMzdoYUNW?=
 =?utf-8?B?QklTbk4zaG10cmxXSXU4ZlpMSW5XQ3psem00Lzc0Qnd2S3dUcU83M0l1cSs4?=
 =?utf-8?B?ZnRCT2tOSmhzVGRlRmdlRFRFRTl5Mmg5MXBrN3U5NDRqdE9WR1JxRU1KOFdP?=
 =?utf-8?B?eDhzNTV5c2FNM0FDVCt5cy9oM1BrYjU4TGphT0ZYYXVDL3RVVGVhYm83YTZa?=
 =?utf-8?B?YWNYS3Yxb3FJK20yOCtCVGtOV0dSK0J1TmpOVVVCTWx4UVFma0VqdnNGNlRq?=
 =?utf-8?B?ajAyMGZ2YzZuMHFBSHR3QVZ5QUx3NzEzaitHYUFQMEYrd1ltY2NleFYxd05T?=
 =?utf-8?B?YXp2ME5GektOTnIvcTBSQ2krckF1VCtDYmtGbGRhOVpZckRzblE0aVlESjB0?=
 =?utf-8?B?MjQwekppU3lYU3R3MmRzZTArZ01yVTB4bVI2MnVaUkhuaW5sOEt2MG9kT1Nk?=
 =?utf-8?B?bXVNOU5TRVNFMUNJd0R0Z2JINTZHT0pNR05oR09odks5dkc3V1Nud1JiMVl0?=
 =?utf-8?B?aGtpbXBRTFl3a25QWlBOK3JvY2Y3T2JNbWNnM1pPUUxPR3ZiV0YrNmE3QVRa?=
 =?utf-8?B?WWxTV21sUmNLUjdXWDhKeGkycmxkdmx3MEowMXpXdHNvRUc1N21pcWNQL2hO?=
 =?utf-8?B?Wk95d0thYk1takJRWXpzelN5ckpuR0xkMzVCcWozWFRJcDBubDBxRzE0emtK?=
 =?utf-8?B?VU1Mbk9qTEhEUnZabkpBOFEzN3J3S0ViODYzWWJZYWVBTDhCaExCYlBpeTJS?=
 =?utf-8?B?eXRqUDJrblQ4d3FNdDdsQ3U5djI2UFRadkNoalJJWmRhcEVlQXlTVlowa2t0?=
 =?utf-8?B?emRBajVFQWs1WFFncEtQcFRyOEhwTVFpRmg2bXZYeUNFNDR4b3lKbUdLTnpB?=
 =?utf-8?B?N0tqSWx0c1hRc21DSHk5SjJlZTlaVndhTzZxYlcwcnFIY2g2ZkxpZ3RmZlRS?=
 =?utf-8?B?V05ER2FWQ1AyMzRIdHQvVk9Od1YwVTY2Q3FKZU9lMStOWjdWZzNhV2Mwemhi?=
 =?utf-8?B?czNPb1pEeGxHWnRoZkhUdExYWXBZaktRZFBoZnFFbC9qSC9uanllNUdqKytK?=
 =?utf-8?B?NEtKeHBRNFltUkdPM2Rjd3MrOHlNMnlvcVlzQUEwVGtJVHdKMEE2YzZxdlRE?=
 =?utf-8?B?ZzBkVjR0Mlorc2tEVnJvZ0ZEQWw4VkNtMmxPb2pjd2dUQnhJQkRPUE5iR1Vi?=
 =?utf-8?B?WlFGL0R4ZWE5WC9FZ3NHdmNRNlpMVWJvVjRaV1NreVBRdzd5bCtUQUxERnRv?=
 =?utf-8?B?Qnk4dE9tcGJBVkhFejZkVlk2cVUvdUFxVzFkOUROU2d0alZyTWpmNnZpcXZm?=
 =?utf-8?B?dkUxaU9jMnV5RllkM3F5NmFlUndCNnoyaXRaeUpMdlRvVDREQ1JKZHExWVli?=
 =?utf-8?B?dUVqRTl4SFpQOGZIWk02b29SY3VuUnFwdWI4UHZhWHFIeU55ZUFvY2tLOWp3?=
 =?utf-8?B?UTdTSndnOTQ5SklSazh6Z0liVVhBYmtsZnpUMFNFaG4xSktXVmx2VmNYYVMx?=
 =?utf-8?B?MElPV3JtT0pXanZkUUpPQWZ2QUFyK3Jwdmp5VGJXZDlIeHMzMUdzRDh3bEtv?=
 =?utf-8?Q?WlIdzFEnyW155a2L50ZE20g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2U4QXdHb200RTdOTFlmVWg5Z28vTVgycUlBU3hUd0o4U1ZnS3l6UGNicjRz?=
 =?utf-8?B?T25DVlN5ckt4NGJ3MTdxcmlLOUhyRHNPV1l4d2pjUXdjN3hETHdXZmlESWhP?=
 =?utf-8?B?QlRCd2lkSDUyRHNHdlFiR0JzeDJ6VDJoR3Vaa0pEbFh2RlpvcS9MejRDWWRG?=
 =?utf-8?B?RzNQMGQ0dnFXNytYU0xobTZneTVJY0FvWDNDMXc5RU85WVlJWmx6aWF2cXRF?=
 =?utf-8?B?SjNWRjVCZ0puNGZMWnR6b1JEbE9YZjhzNG83UUJPbGo4dUpyQkVyVlhseUpQ?=
 =?utf-8?B?eHRKS0VSUUdWaVRQL1N3c1BWTEl3bjliU2ZlMUp0dEFJdnZDYlhaUTV4aUQ3?=
 =?utf-8?B?WE9ya0NLZkhkSElobXZOREg5VndsK2N0S0xqLzRQTlYyMGlIbGYwN0pSVytu?=
 =?utf-8?B?MkhoUHBvdGpnd1R6QTJhcHI0OXFPN2hJU2paTldKWFdHcVlRRVF4VkIyZnpS?=
 =?utf-8?B?V2JlVkdSNEc4TWVlNTBxQW9PamVlMEhOZ0lBMWxxTm1pa1NKZUZZenN5eXRF?=
 =?utf-8?B?cEdieGt6aE80RW1meFlIcTdjY3JyQXZRQldxSm9ONjF6dyswdGNvalNZbGdq?=
 =?utf-8?B?bTdnTGdhQzZ0UWNCYmdYaW1DNWloVU16bUNYeSsxNFdibi9sUTdENnZvTUIz?=
 =?utf-8?B?T2xGTlBkRUFxcDRPZW04TDc0MEc3Unl4bWV0TFZvMmlJY3BuQThDQ3ZuUkgw?=
 =?utf-8?B?UUM5cnRvZXJkeCtNM05jRGxUMVBwY3lSZ2NrbTJFNlhSZjZvWCt6S2JTSFhp?=
 =?utf-8?B?czNVR2IzeG50YTVQWU5JMnhlWTdsdmxtaVdqTVF1Q1ZOaHFSMkltSkFiZW45?=
 =?utf-8?B?N3NYUG1HdjBzdHN0bExQUWdjeXpYdTV0U2p5Q0ZxclRqTnNpYVZFMGprZDU4?=
 =?utf-8?B?bWdlUFUvNnFZUWhNaThyN3pmcjFBMnZtUXJ6a2NsQUFBejFSOUw2akNNejZp?=
 =?utf-8?B?TEg4U08wYnRpai9zVU9zTlNjRlVzRFg1M3h1SWUyYjFDN0lOc1dSRWRvODQ0?=
 =?utf-8?B?bWozNlY1QXBCV0ZlNFNYSlRjTnBleG9FdFdxbStzU2dSd25tVVVKVGprQ21z?=
 =?utf-8?B?b05FQmxuQ24yV3pSV2xaQVJuOW5yVE5KNXpFWjZHM1ZFakZqVkVZUEdmd3pv?=
 =?utf-8?B?S2JKVVhBUFQwcHpLMGlsSXEvV1RobTZ2Y2lYVW9KTXVJOThZN2tmUXNxbExh?=
 =?utf-8?B?bWRBWU1KSGlTTEVIUFBVcnB1bzRDejA1ZW1LSGVzL1I3Z3k4dE1jVDJsOEVN?=
 =?utf-8?B?RnZ4MGNiancrK3BtZ0oxanY5WkRMT1Zsa2lOMHRxTzJZNXZxS0NmWHh4U3Rh?=
 =?utf-8?B?MHRUWm9ZcEUrNWUyTXU5Yi9lUlAvYkQ1VWVack9uNEFqYjBZYnA1UjNuRW5Y?=
 =?utf-8?B?eGQvQUJFNFJvZHg4dEd4Tk8va2VpdzlxODlSVE9sbTNCQmNXUG8zZkV3Ulpr?=
 =?utf-8?B?OS85SGZjM0pNN3R2ejhxTEphL2NFcWxIdTRDYXJIVVd3VUUvQlN3c3FmTDZN?=
 =?utf-8?B?azlPS2NpWmtVdHVLeGVvSGhnb2RmTUI3ZHo5T2h6NFBJV2ZUQi9PQ2p0ZmU1?=
 =?utf-8?B?U3BkQ0hDS2Z5bHhWdXRVTUx1Qk04dzMwdGZmd1FoRk5BUys0cEluQ1h3Q0JY?=
 =?utf-8?B?dHlLQTV5aHBNQm1QNXllUks0ZDY1d1VSQjNsM2luOXNZa2RQWCtXRndLZ3E2?=
 =?utf-8?B?Y011aENTSlY1VTQ4dXlQeHBhMlZWL2o4QnBtNUxWTGJhUzRoR2U3ajBpKy9w?=
 =?utf-8?B?TGZVdzRONHI2ZStCWVdET20vUll1T3MrUERvcSswV3ZqMXFDMzQ0MkV5anhv?=
 =?utf-8?B?Skt5WTJUay9lMlJVQUlzQzU0cTZWTzNNVkgvc0dzRmc1aGptUmIxU3ltd2o0?=
 =?utf-8?B?R2ZHUm43b2o3U2tNVE8yV2tYdGErL1FRMElKTmtDOXlrMVFaUUQ0eWtOUUNY?=
 =?utf-8?B?eEpoa3RiUGpKajRhcjJMdlo2RmIzVkZjSkhXMGdNVENIWWZSRC9OWkR3bS9P?=
 =?utf-8?B?UUk3ZzJ1ZkZTaGwybVFhaXgzMHVJN0NTOHRyV2NRWXltQVZIYUxONWN6MmY3?=
 =?utf-8?B?TDdmaTBOWC82MUMveG03RnFKRkRVNzV4UnRzVmdCam5sRjh0ZGJHNUIwbjVN?=
 =?utf-8?B?VjhzUVBrUXZ0bUhmRks5UkhMb2I2bXdaWiszL2cxSkwyQ1RXY0I3ZzR1Zzlk?=
 =?utf-8?B?MGQzT215cCtRSWRiWWtuVmhlWVBuOXFKenozTk8zMkxUR05NYlZrRHp5bDZN?=
 =?utf-8?B?bDgzWm1jTkd6Q0lqRzFTb2hPVkZ4dEhuaC9seXdlN24reGpjNU5rdTNTTzN6?=
 =?utf-8?B?ODhqakNrSzNHZTgyNWtsWjB5TExxNHhFazVyZ2RkNS90MTFlL0dSQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC9A0C0977738E4C8E38EFC694435CCB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Af/7q+rQs9SzcOVTACIAUrKdBu/3OaCOKVIaTpyFfaO52CXuk2DduzDD15dQe5QtaAVvND2RsC2nlS8M+YPLWW5rAAG3SemnK4qw3MxlWwhjMilpqX5h2kYjPW8ap32JygpqlMyEs+TnYrqCigXZGPFZ3pLt95ZckRuhAa0XAltEwxxeI8MqDvpupJwfuFkWUO4jXDF0F8RJXUNZM95OfzuX34/Rbb0PIk90QKMRPdfM/NYac0usPMfBpxwPxbFah0r66NpmhsiNJ+vzLYuvh3ms9a3IAFLXiUoZ7Q7DwuMzSFuoryEFRfIqR4HpKMyYHnBM7pzvDaolFOg1mGMTCsT65/6OMBbSD7tyPDBcFSFinml5yWHoyu+7CVDaMJKyOfAtNdeiEVO+ypZbAstNxbdCFFB+qD+eJnN0o9dTpki0Zol7ZeCJppUS5cWWBOIR3ewYTXcOiU9QDrlyKt6jlPVgxwhb7rPz+P8HD1kPMe/k2CPiGV5PDawGLNTxJFQZYa9+uyomzOwknN1pcDyl2o4IRbVQEfYeBg/drcxp1rp0NHKWwmQ0p1psSMx9tMWvOw4C4uPLn+h0B2cMP3LqX46ajLt+pFqH8uFKWJj1Ti0JYyMSt+2RMaoaIwK/6Ick0cPm2PmUKz0Usx5hjFdAdw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5265eb7-d178-4195-7c6a-08de62b7c944
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 00:04:22.8053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EecnIRlzDyDxPtK0qMxnJDB6giDwB3sz19qdtcDtEynzuaek4b3vuOYRZ7n8o7HyKx7MOnrtSepB82QoKQr/5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
X-Authority-Analysis: v=2.4 cv=CNInnBrD c=1 sm=1 tr=0 ts=69813b8d cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=tPUZ71AOWTTdvHcK6E0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AJclyOyxgcXG3jl7FEfAs_iGWaZgFnJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE5MCBTYWx0ZWRfX1c0QDh8HjMTu
 5glIAR+OYqk0RQDfw4bkPDRJbRKVbNCTKtWb5rNmNEgF8LtY9uq6bADRSbhjeNgeepYVqdc76uq
 ay1MCTWAhNQoq3UP2w7HJu1yh037V24hbTVQPdzPZATY20YfcNQcuL+KufAqdTrJQbflAU7wrQr
 Jc7DwnNwl5iZ3xuDchBcRzaKotCE9u+WCaRQHo44nDO9JyE5MQ7Jf5Cku0q+Hb6LTTZ4fOBBj9I
 zGqcSQgjmiR3HjJrpnEG0VxyIoV440XvnEl0odUoiBUbdC/Dy281Bosr4C/WPhcWupvl1rQYzln
 AEDgyGqgbeq4Vt2UmxZHdM5ofIIM5x5Pi21vwMOayNPmtHjALjYot/tD/aUx6VZtxJF0DN/Aq8O
 9AOL6+mGTIIcuH2dSD95QPFzMP1tXPry01Lov+1BjtXpA3RMTro0Bn4tctv++vaT4EcmZAFZ83b
 lUih9pUhLk5o6X8X+eg==
X-Proofpoint-ORIG-GUID: AJclyOyxgcXG3jl7FEfAs_iGWaZgFnJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602020190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213139-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,synopsys.com:mid,synopsys.com:dkim];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_MIXED(0.00)[];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 75888D3000
X-Rspamd-Action: no action

T24gVGh1LCBKYW4gMjksIDIwMjYsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBDdXJyZW50bHkgZHdj
M19nYWRnZXRfdmJ1c19kcmF3KCkgY2FuIGJlIGNhbGxlZCBmcm9tIGF0b21pYw0KPiBjb250ZXh0
LCB3aGljaCBpbiB0dXJuIGludm9rZXMgcG93ZXItc3VwcGx5LWNvcmUgQVBJcy4gQW5kDQo+IHNv
bWUgdGhlc2UgUE1JQyBBUElzIGhhdmUgb3BlcmF0aW9ucyB0aGF0IG1heSBzbGVlcCwgbGVhZGlu
Zw0KPiB0byBrZXJuZWwgcGFuaWMuDQo+IA0KPiBGaXggdGhpcyBieSBtb3ZpbmcgdGhlIHZidXNf
ZHJhdyBpbnRvIGEgd29ya3F1ZXVlIGNvbnRleHQuDQo+IA0KPiBGaXhlczogNjZlMGVhMzQxYTJh
ICgidXNiOiBkd2MzOiBjb3JlOiBEZWZlciB0aGUgcHJvYmUgdW50aWwgVVNCIHBvd2VyIHN1cHBs
eSByZWFkeSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6
IFByYXNoYW50aCBLIDxwcmFzaGFudGgua0Bvc3MucXVhbGNvbW0uY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAxOSArKysrKysrKysrKysrKysrKystDQo+ICBkcml2
ZXJzL3VzYi9kd2MzL2NvcmUuaCAgIHwgIDQgKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyB8ICA4ICsrKy0tLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBpbmRleCBmMzJiNjdiZjczYTQuLmM5YWYx
MjZiOTY5NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gQEAgLTIxNTUsNiArMjE1NSwyMCBAQCBzdGF0aWMg
aW50IGR3YzNfZ2V0X251bV9wb3J0cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXJldHVybiAwOw0K
PiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBkd2MzX3ZidXNfZHJhd193b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCj4gK3sNCj4gKwlzdHJ1Y3QgZHdjMyAqZHdjID0gY29udGFpbmVyX29m
KHdvcmssIHN0cnVjdCBkd2MzLCB2YnVzX2RyYXdfd29yayk7DQo+ICsJdW5pb24gcG93ZXJfc3Vw
cGx5X3Byb3B2YWwgdmFsID0gezB9Ow0KPiArCWludCByZXQ7DQo+ICsNCj4gKwl2YWwuaW50dmFs
ID0gMTAwMCAqIChkd2MtPnZidXNfZHJhd19jdXJyZW50KTsNCj4gKwlyZXQgPSBwb3dlcl9zdXBw
bHlfc2V0X3Byb3BlcnR5KGR3Yy0+dXNiX3BzeSwgUE9XRVJfU1VQUExZX1BST1BfSU5QVVRfQ1VS
UkVOVF9MSU1JVCwgJnZhbCk7DQo+ICsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJZGV2X2RiZyhk
d2MtPmRldiwgIkVycm9yICglZCkgc2V0dGluZyB2YnVzIGRyYXcgKCVkIG1BKVxuIiwNCj4gKwkJ
CXJldCwgZHdjLT52YnVzX2RyYXdfY3VycmVudCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyBzdHJ1
Y3QgcG93ZXJfc3VwcGx5ICpkd2MzX2dldF91c2JfcG93ZXJfc3VwcGx5KHN0cnVjdCBkd2MzICpk
d2MpDQo+ICB7DQo+ICAJc3RydWN0IHBvd2VyX3N1cHBseSAqdXNiX3BzeTsNCj4gQEAgLTIxNjks
NiArMjE4Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgcG93ZXJfc3VwcGx5ICpkd2MzX2dldF91c2JfcG93
ZXJfc3VwcGx5KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJaWYgKCF1c2JfcHN5KQ0KPiAgCQlyZXR1
cm4gRVJSX1BUUigtRVBST0JFX0RFRkVSKTsNCj4gIA0KPiArCUlOSVRfV09SSygmZHdjLT52YnVz
X2RyYXdfd29yaywgZHdjM192YnVzX2RyYXdfd29yayk7DQo+ICAJcmV0dXJuIHVzYl9wc3k7DQo+
ICB9DQo+ICANCj4gQEAgLTIzOTUsOCArMjQxMCwxMCBAQCB2b2lkIGR3YzNfY29yZV9yZW1vdmUo
c3RydWN0IGR3YzMgKmR3YykNCj4gIA0KPiAgCWR3YzNfZnJlZV9ldmVudF9idWZmZXJzKGR3Yyk7
DQo+ICANCj4gLQlpZiAoZHdjLT51c2JfcHN5KQ0KPiArCWlmIChkd2MtPnVzYl9wc3kpIHsNCj4g
KwkJY2FuY2VsX3dvcmtfc3luYygmZHdjLT52YnVzX2RyYXdfd29yayk7DQo+ICAJCXBvd2VyX3N1
cHBseV9wdXQoZHdjLT51c2JfcHN5KTsNCj4gKwl9DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQ
TChkd2MzX2NvcmVfcmVtb3ZlKTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdj
My9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCAwOGNjNmYyYjVjMjMu
LjA1MmZiMThjNmI1YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTExNzgsNiArMTE3OCw4IEBAIHN0
cnVjdCBkd2MzX2dsdWVfb3BzIHsNCj4gICAqIEB3YWtldXBfcGVuZGluZ19mdW5jczogSW5kaWNh
dGVzIHdoZXRoZXIgYW55IGludGVyZmFjZSBoYXMgcmVxdWVzdGVkIGZvcg0KPiAgICoJCQkgZnVu
Y3Rpb24gd2FrZXVwIGluIGJpdG1hcCBmb3JtYXQgd2hlcmUgYml0IHBvc2l0aW9uDQo+ICAgKgkJ
CSByZXByZXNlbnRzIGludGVyZmFjZV9pZC4NCj4gKyAqIEB2YnVzX2RyYXdfd29yazogV29ya3F1
ZXVlIHVzZWQgZm9yIHNjaGVkdWxpbmcgdmJ1cyBkcmF3IHdvcmsNCg0KVGhpcyBpcyAid29yayIg
YW5kIG5vdCB3b3JrcXVldWUsIGFuZCBpdCdzIHVzZWQgdG8gc2V0IHRoZSB2YnVzIGRyYXdpbmcN
CmxpbWl0LiBNb3ZlIHRoaXMgYmVsb3cgdXNiX3BzeS4NCg0KPiArICogQHZidXNfZHJhd19jdXJy
ZW50OiBIb3cgbXVjaCBjdXJyZW50IHRvIGRyYXcgZnJvbSB2YnVzLCBpbiBtaWxsaUFtcGVyZXMu
DQoNCkNhbiB3ZSByZW5hbWUgdGhpcyB0byBjdXJyZW50X2xpbWl0IHRvIG1hdGNoIHRoZSBzZXR0
aW5nIG5hbWU/IEFuZCBtb3ZlDQp0aGlzIGFsb25nIHdpdGggdGhlIGFib3ZlLg0KDQpUaGUgcmVz
dCBsb29rcyBmaW5lIHRvIG1lLg0KDQpUaGFua3MsDQpUaGluaA0KDQo+ICAgKi8NCj4gIHN0cnVj
dCBkd2MzIHsNCj4gIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QJZHJkX3dvcms7DQo+IEBAIC0xNDEzLDYg
KzE0MTUsOCBAQCBzdHJ1Y3QgZHdjMyB7DQo+ICAJc3RydWN0IGRlbnRyeQkJKmRlYnVnX3Jvb3Q7
DQo+ICAJdTMyCQkJZ3NidXNjZmcwX3JlcWluZm87DQo+ICAJdTMyCQkJd2FrZXVwX3BlbmRpbmdf
ZnVuY3M7DQo+ICsJc3RydWN0IHdvcmtfc3RydWN0CXZidXNfZHJhd193b3JrOw0KPiArCXVuc2ln
bmVkIGludAkJdmJ1c19kcmF3X2N1cnJlbnQ7DQo+ICB9Ow0KPiAgDQo+ICAjZGVmaW5lIElOQ1JY
X0JVUlNUX01PREUgMA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggOTM1NWM5NTJjMTQwLi4wM2Q4YTNh
MTUxZTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMzEyNCw4ICszMTI0LDYgQEAgc3RhdGlj
IHZvaWQgZHdjM19nYWRnZXRfc2V0X3NzcF9yYXRlKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLA0KPiAg
c3RhdGljIGludCBkd2MzX2dhZGdldF92YnVzX2RyYXcoc3RydWN0IHVzYl9nYWRnZXQgKmcsIHVu
c2lnbmVkIGludCBtQSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGdhZGdldF90b19k
d2MoZyk7DQo+IC0JdW5pb24gcG93ZXJfc3VwcGx5X3Byb3B2YWwJdmFsID0gezB9Ow0KPiAtCWlu
dAkJCQlyZXQ7DQo+ICANCj4gIAlpZiAoZHdjLT51c2IyX3BoeSkNCj4gIAkJcmV0dXJuIHVzYl9w
aHlfc2V0X3Bvd2VyKGR3Yy0+dXNiMl9waHksIG1BKTsNCj4gQEAgLTMxMzMsMTAgKzMxMzEsMTAg
QEAgc3RhdGljIGludCBkd2MzX2dhZGdldF92YnVzX2RyYXcoc3RydWN0IHVzYl9nYWRnZXQgKmcs
IHVuc2lnbmVkIGludCBtQSkNCj4gIAlpZiAoIWR3Yy0+dXNiX3BzeSkNCj4gIAkJcmV0dXJuIC1F
T1BOT1RTVVBQOw0KPiAgDQo+IC0JdmFsLmludHZhbCA9IDEwMDAgKiBtQTsNCj4gLQlyZXQgPSBw
b3dlcl9zdXBwbHlfc2V0X3Byb3BlcnR5KGR3Yy0+dXNiX3BzeSwgUE9XRVJfU1VQUExZX1BST1Bf
SU5QVVRfQ1VSUkVOVF9MSU1JVCwgJnZhbCk7DQo+ICsJZHdjLT52YnVzX2RyYXdfY3VycmVudCA9
IG1BOw0KPiArCXNjaGVkdWxlX3dvcmsoJmR3Yy0+dmJ1c19kcmF3X3dvcmspOw0KPiAgDQo+IC0J
cmV0dXJuIHJldDsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiAgLyoqDQo+IC0tIA0KPiAy
LjM0LjENCj4g

