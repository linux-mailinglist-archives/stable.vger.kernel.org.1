Return-Path: <stable+bounces-199954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDAECA2211
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 02:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6779D3004991
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 01:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA3E23C503;
	Thu,  4 Dec 2025 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GSDOv8wO";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WWz3YHnz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Gol7VsbD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C435212FAD;
	Thu,  4 Dec 2025 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764813116; cv=fail; b=n+YzYtTP2eE2fFTxZNpWMC9dWOhXACqtWzzZ/0jMv+6KpWXww79wm1vJ0pvdIwDyL50PnJ6WOfVbrzzupBEpWY2sa1t/vk+U7Ae5lNH0Ru2O3mWLVwiZ3hpJZH+WBpNR+NSTEOEyEoke3i8+XSxO86NlQG3M6UgSeF2r9TDcMtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764813116; c=relaxed/simple;
	bh=bUMkEWBMryYpnkwdpmGUG4Cw6cnYRSr7yB64AsSSQl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dA8eEDxcP0cC6TtUhX1NgjJH4jTxbZ/1XufF/NnhUrUOQy7jZq6wB5n2Sepb+3EcjZdR1GlcndYsWBfp9u7AZDo6QAqHY8C3IC8JZ9eDg5Zufnyvw94Q4/yOD1dqRz5203nc+JdACRcpcphapn1lmTxkR18SK38suQmw9HWowwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GSDOv8wO; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=WWz3YHnz; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Gol7VsbD reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B3LYWCD1012984;
	Wed, 3 Dec 2025 17:51:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=bUMkEWBMryYpnkwdpmGUG4Cw6cnYRSr7yB64AsSSQl8=; b=
	GSDOv8wOqWyJuVm1NB4IlhsVCb7IvclAQgPCBNrGaQr7jR4tHmsIIGn4QybfdIYn
	/SahkYKyyOC8O0b1B1FKhl5vMjPnYzltX8AllPYR1wk7PI2Pp8zvsXyX3vm2PVQY
	3JxCUUa3ifCHjDDABCY7KAMFN+dL+CDL462l0nBkjyZqAN35uRpOCXKvrbZ9InHq
	XKxQegBW5m+ygGVhZTcC7OM7WNdJdrC1QWPLgILpNOv5El8CLQQRIJ52g/BwGd2z
	ugkvAqnxOhGfNM4Nq09KabX7lg+6Em64dssTu9+IiCstmd7aXzF9f8HhpPh1hSe4
	VpdUSf7dd7D17o54aA66AQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4atnuvux84-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 03 Dec 2025 17:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1764813094; bh=bUMkEWBMryYpnkwdpmGUG4Cw6cnYRSr7yB64AsSSQl8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=WWz3YHnzQ0s1gVjh/m4w9gelFzR9GILFTiLyiApDO/1iVu9EX51/JwI/Aq4bYuuGp
	 fEeJ+4Kk7OjHOFmYzuU3WZ2ii5HscnAdDRDEh9ZLMfiK4bzZrkWleCP9/sva+smD4r
	 aL5DTF79CLzJB2OmLKz8WrYioHcnau6EhKjZ1zh/7ixNymBQ3A7r+NALTudO/SM2gx
	 jskanjNuA6bnsjPVy6RzaMJ7F/jI3LSywNl37cJ2FZEq0g2oTjqILoSvR/azfrEuvj
	 wxGp87JWn+C2On67sCn6pGCMSMdTCcR71t9RTO4zEPtZXUcT8nWL2llDk5X4AZRL6y
	 vJRU9TK23oBJw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B19704035F;
	Thu,  4 Dec 2025 01:51:33 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 927B9A005A;
	Thu,  4 Dec 2025 01:51:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Gol7VsbD;
	dkim-atps=neutral
Received: from CO1PR08CU001.outbound.protection.outlook.com (mail-co1pr08cu00103.outbound.protection.outlook.com [40.93.10.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5009640593;
	Thu,  4 Dec 2025 01:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEnaXXrtr9P6Luy2qGXJOAkgN4/fyg0CFI/36zv4mUO3gg6L47s9UcB+DVM+uAyx7TIdnle9uEj7cxs/nFFzWoDgNyq30badFyo9Z9gBJI8rAU2pfGgU0j3aMuiBNQKgHWrpYVJFkD2/5ETv9Kr9xTxxiV3fwZT8RVqopPdbmv7r2nH20wIBUKOPQxyikktMnLap5vkwackmncq3ydhQmX3S0TM3GzIsssbeepPULhDnG1+TSgbDsOdPJl+WYTmqYvFWYq/Ps6x1KNQFZ+8LUsoBbQ9/VAjH/HrLRKxSGyLkagUxol7zfYYMDUAldmFCRa9oaNw2PyRKUJIGs6dhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUMkEWBMryYpnkwdpmGUG4Cw6cnYRSr7yB64AsSSQl8=;
 b=R/bK79R4K50W3po8x1dkCe7EDMyAWRnPql3lR44chdkjy72hvvmwx1MxxPt5P9jAB4888aC6Wlg5AynM+xduoov0nL3fbQbUrHx4k87YZEM3CHMfUzLuK7kkjJqeqIPTjhmUZwYZXJxyp9w4txiv+ZYgxcuoVZssscN0HHKVeKvDQIQKKie2MhxjodzYVqxlcYeV+/nVM1G3IxqqqNyfpg8uazETooqnXGzZ54+vQCd1a6YXSJIH9aMFTW6IDvIwlsv1Lq0e9lOEkusW6Pn/+qrx8565CtBia443Ihh8QOe3bq+/d7SWR308m/loFS4H/eS4vL3wkleyyH0IDgqDxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUMkEWBMryYpnkwdpmGUG4Cw6cnYRSr7yB64AsSSQl8=;
 b=Gol7VsbDm74Dr+7cXyeD6piwMx7oN5RRRp9rm8SJYv+OXv7O2cL89hX6PHIEC7Mn2yir0y8RNRZ2FQMemJzd/G0z2sCnrs4fTYTobsJ/fm1CCpdbRZhUtEiY1UhoGBizFYDIfRxuGCL+ENLVPPTaNFdD8bJhcZ4zV3SfRAkdkhM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 01:51:29 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 01:51:29 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
Thread-Index:
 AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAhQQCAAWgNAIAAJ0QAgAFwPYCAABgXAIABfkgAgAAM6ACAEwJnAIABVnmA
Date: Thu, 4 Dec 2025 01:51:29 +0000
Message-ID: <20251204015125.qgio53oimdes5kjr@synopsys.com>
References: <20251117155920.643-1-selvarasu.g@samsung.com>
 <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
 <f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
 <20251119014858.5phpkofkveb2q2at@synopsys.com>
 <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
 <20251120020729.k6etudqwotodnnwp@synopsys.com>
 <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
 <20251121022156.vbnheb6r2ytov7bt@synopsys.com>
 <f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
 <4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
In-Reply-To: <4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB6296:EE_
x-ms-office365-filtering-correlation-id: f5c17ed8-5764-4629-11db-08de32d7a4cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk41WHpwM0hUWHA0ek9NMTZLYXpaUEF2Wk1VWTZBRTduQU9rd1lqM3hqclJJ?=
 =?utf-8?B?SGFmcjJxR3R5MTNsT2ZTMytvQUd0STNhSHliaWlkbGRVMDBhS1ZIc2diMGQ5?=
 =?utf-8?B?OG5WVFJZVTdtYldheHhnUHdZUFpjcmIyTWtaa1JpelZpNmlqK2ZweHJsakxz?=
 =?utf-8?B?cTZEdzg3QjFrZXc5Z2ZnNHc0cHcxZWFHWkxWQnRwRGlramUwclZQVm5INFpC?=
 =?utf-8?B?NE4zS2hhN09GYmZLTjVVVnhjUkNhRXdLbFpyVnVCbGdrMWpJQWpuWnhra1lo?=
 =?utf-8?B?QlBqclR4azd4bVBGUFd4SzdtZWkra3lpTXdIZlV1R3NkY00yUGtocHdiSmRZ?=
 =?utf-8?B?Sm9zUHI1TDRxQmVTaUs4bVN1SlNWL0N5eFZBbUpxa0NQWEs0eCtRTFh5V2tn?=
 =?utf-8?B?V3VsUG1SOE9yNjFpQm5UTlZWOUw0TmdpdWI2VWVwWHprMEx0Wk1Ea0N4VmZ2?=
 =?utf-8?B?VTNYOWpzNVZoTVZwbzVjS0lXVERNcDB4Rno0SDI2TDVZUHdOVlptOCtzMFpz?=
 =?utf-8?B?TGhqWFpQRmF2anVlU1RJS29rTTBvU2V0dlpSZUxPUG8rNE1yZ0pMa2Y1Mm5r?=
 =?utf-8?B?NXc0dHkrL3pOZHZRdTFONHE4RE5jL1lOc0RQam4ycjdoRXZqUWh0eDRGR3Bp?=
 =?utf-8?B?UjhaTlhlZzhhSlEwNkdPenZkY3VsTElnVkRRWTZBVFNTUzhUNFlSYjBPa1Fu?=
 =?utf-8?B?a3p6N2prVEJCV2hNMVNPSHgzRGtscUl4MkR0WmdqMitacTh1MHQ2VWs2S1lR?=
 =?utf-8?B?ZFRYWElRemNtTlFraE1jaWlmdmVPVnNDa0FGZUhaNTdyTVRGT0NlWmJWR3Br?=
 =?utf-8?B?OEFSZGZGTXFiVEpNWDNFdmlsRHRlQkFMNEFvZnpJMnhBRng4cVgrVzZ1dHU2?=
 =?utf-8?B?aGc4aDdwRnhyM1hXa2xxeDBhWkI0U2ducDJiNHRWYWx0WkIrZTNzek8wWWJl?=
 =?utf-8?B?bVJZczNMTHQ5TWpUWjJZMGxmY2dMOUV2ZXNoOWc5VElGekNJTkduUjNHeE1D?=
 =?utf-8?B?WlJRdUJOMEJvT2laV05hYUtUVTd3d0xxSEMxSzAyVk1TL1VZdm5TbEVBVWxr?=
 =?utf-8?B?enJ0Rk5Vb0ttMVBrZzFxMVF2RVRQVnFBa0l2bHFvL2FwcjJaUEJPS0xUYmVq?=
 =?utf-8?B?d0ZKU3AvQzVpM0tzMzF1Z1JwcG5YaStBMGZ6MEM4R1NmOFNLQUxhdloweE84?=
 =?utf-8?B?SjhySVFjY2krVXNUT01qTTJzTGhVcUlmNWFNYU02SEZ1QUhLQ29tT3VrcUtM?=
 =?utf-8?B?Nm1yK0JsZmZjaHFVeHM2L2lMV2Z3NGROWTBHWFlVRmR3LzlqcTJpSGEwZWF0?=
 =?utf-8?B?YmRqdUVGejBJRGdQamh1QlduZ1NXTEVUS2NFM0xFSURtN1oxSFVSOXdzSlk1?=
 =?utf-8?B?V1UxZHduNThoa1MwdldwSFBqNTI2cDBNZi9nSzJpdkhYZWJvc290c2N6WllL?=
 =?utf-8?B?QzJtN3lvb0ttR1Qwc2NicVJBQTFwL0paRStkRjZaT1hyaHk0QTJzZFpwd1o0?=
 =?utf-8?B?YksxaXh4SDh6RGhQa0hKZnNIS2FuekZ2M2wrRXZjRllDb2VoTnZGbno0UFFs?=
 =?utf-8?B?emJuS002bE11OWlBYi84alZZQjFzWVJyeXRIazRDNEZkaGhvQXVRZWg4cTVr?=
 =?utf-8?B?NWhDL0RTVUVaa0h0RVFaYjJsTUdYSzlFTzFHcUlCaWszeEh4T3pPZ3VacHpm?=
 =?utf-8?B?dUVkZkc1WWUvT2tTWE9saEpFTlBickhsWDNJeFdVdTFqVDJCR0NUa1RsOHV3?=
 =?utf-8?B?NW9MaUdFSDRxQTEvMzRvWUMwbWFrazhEblRUc2Ntb2o0UDg3Vk5JZDhzeEkr?=
 =?utf-8?B?WktSWU9Dd2xVQnd0eUt3bnUxbXJNZ0lhRTBZR0g3cG1DcHMxdU5DT01jVFpv?=
 =?utf-8?B?UzduaTNRSUFCcEp5T3NGSmJGNGpDSUJqWkhMY2ZkSnRWTVNQZ3gzZ1VldmF6?=
 =?utf-8?B?VG1nQVZNVkluZitYTHRSdWpwbjFWaW5VL3ZxQTZEalBSVmtpbHNDSGNRRnFl?=
 =?utf-8?B?dWhWUDVxcHRiNTJoMFVUTHN0QjIya2l3NHJGTVd5dHBVS0ZpdCszVjArb0lB?=
 =?utf-8?Q?A4ZS15?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjZmV3kzVEU3M1JFNmg3aGRRK21xajV0c3NJTkVFL1N5ODlJczJwUjFndVBV?=
 =?utf-8?B?M0dWdmtoaXY2QjRnNHNPV3pCMlVNaExUNWw2TUVNN291SlFhT0xiTTIxYThy?=
 =?utf-8?B?Q3pwSmZZd1E5a3lDTnc3eXR6N1VmYjN4aC8xOTFoY0lKUFkrbFA2dGlIN3ZZ?=
 =?utf-8?B?T2NwYU8vaHcraGF3VkNDcVYzbHpLRDVaLy8vdVovTGQxMWlneTRPVGhNeWZz?=
 =?utf-8?B?MnNIWWFRTDM1aTJKb05seXVYN2ZPMWNEQUhUWlFCOHcvQ2l2blhxNmYwWS82?=
 =?utf-8?B?c1RROExRU3pMazRtNzI2eEI4Q241NkhuV2F2ZUExUjJjeUx6cEFVUmVDbUpl?=
 =?utf-8?B?WkZLczM2YkNyejBnVjh6TXBkU1ByRE9uUHQ5TElIanAyY2hjSkZTNWluQjkw?=
 =?utf-8?B?azVkQzdqRTVoVFJqR1cxR1k2WFNnWFdMd1J0eksyWVMzMk84SmZLcG05K2Y2?=
 =?utf-8?B?ZnhmSkpEUHBMS1ZpMHJKaEtiYkNWNFBsYmZBa1FBeXpNemxMVnA4TlBNN0No?=
 =?utf-8?B?Wms5Y0VlTWIyZ0JKM2MzeWxsdTB4MDQ1ajA1amlmYWxQTVhDeEo0ZUxxaUpq?=
 =?utf-8?B?VGxPdlhzQWJUaWlpYTROajJwejBobmZHR0ZLTkRVVzNZVTlzUHRoNHl3NVlC?=
 =?utf-8?B?UitXTGRIYVdYSW5RMjlaQS9yTEFRQnluRVBER2thdnFBR0oxTms1RFZ5U1lP?=
 =?utf-8?B?bFlWSC9WeHV0VC95YkpGODJtbGtQbE1GY2JCdjQzZVQ4VnpsSmZEUmlmWnMz?=
 =?utf-8?B?NGpPcTE0VlBLTUVCd1lIUUZQQjRHOEFxYzhnM0xZK25SL21nSmVtU25ZZ2FC?=
 =?utf-8?B?Z0p4UE9OMElaYWZKQjc3MVc4RjJQUU4vTGNTMjg3Ukh1ZkJOOHVPTE1kMUJE?=
 =?utf-8?B?T21oZExQaDhJbUcxVmNwcHkwMGFOTWZybkYvRWhJcEYxdVlob002Mk5Pa1dW?=
 =?utf-8?B?dDlpKzJGUnRVZVNIU2RDZkNZVUpXdVV3aXgrWHRaL2V2K0p4b1dZYUVVS2hp?=
 =?utf-8?B?eWxTemhKQUtEVVpDMlR6N2dPdnYxU0crUjFFQUxCcndQNVJrcEJEZGExdXZh?=
 =?utf-8?B?YW1uVDhlaVBZS3ZOc0pVYmp5NGY3c2ozM1RLTlI1SlM3bzYrbldCRjIzZFdv?=
 =?utf-8?B?QlVtQVk5SHRUUHZyOVNhVzJqUWluR0pMMjFZZmVMOGJhZ3ArcHhRdHVGSEx5?=
 =?utf-8?B?WW16N3gvTUorZEdLMGFPTnIwQSs2NE5aQzVuYlRDTEFBN3c5aDl6NnBQb2px?=
 =?utf-8?B?UGFVQ3N6T2t2MXVzMnlNY2dnbTRXVm8vVHJCNEVpWDRKcGVTMnRPaEdaRllo?=
 =?utf-8?B?ZjJjVzRqVnRLS1RwNEFXZENWM00wMXZDV0ppVlJ4SlAzdXZ3UTBxTVFzTEE4?=
 =?utf-8?B?R3Viak9RdThmdVdFNlhra1JDSThPSmVGK21tMERFU2FqL1BoWmlWQ3BEbG1h?=
 =?utf-8?B?b2cxM1JoUWVVTy9aUzhXNEhSYWdDd0VqZW1GVzlScDduTlRkQitHMjR2ZlNP?=
 =?utf-8?B?d3NHV2EwUU1CT2F4M3A2T1oraC9pM0NlREg4Y1hDTklLMGRXL1ZBMGF5MnZx?=
 =?utf-8?B?Rkp3UGh2VUZsMWVFRjhhZ3F2eGJmc0VrMTF2SmZzZHJJOFNEaWtIWDNVcmxi?=
 =?utf-8?B?Q1A0ZFZyenUraWViWWcrVkFyVWtGcnQweU5XMnd6c3BLd0NJNHZrZlRRTzZv?=
 =?utf-8?B?KzZSNU1GZTNTamNMMStIdHpyZnJrN215eVRxWFQxYzZhVXd5YnRPL09wVHFX?=
 =?utf-8?B?VHVDd29peGdFZFN2bERzNEFyQ2ZadkRjR3ZjU3hNUmY0YVZXRHhTT1VKdDAz?=
 =?utf-8?B?aHpYVzNYR3NKczEyVWpiQytIRVNQOFNObmNVZGRwdVRNZFJiNTVVYXpDTVp1?=
 =?utf-8?B?RkJYa0RxNGNWeU1Fa0pubEdXUUVhVGdwMWc0anNIZVpBVTdHQzZPb1RHNURr?=
 =?utf-8?B?d0ExZCtPYUtydXAwbkgxeDNocStzUWZnNTI2VFVwQzNrNGpHOU5YcUpjUGNL?=
 =?utf-8?B?eU00R3RSWnBJVjJ1TnlkOGs4akJSYXRFenVJVVVFbUQ1RGZ5ck1QSDYzUHg2?=
 =?utf-8?B?QVRoWENkNGZHb2JNYWZ6akdrWG45NldaUkZrZEdUaUlIcnZ0bFFnaDlJZ0RX?=
 =?utf-8?Q?P26ApIlYlYPM8v17SuSFzJRQF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F57ED68719C0FE4096BFE61D4EB09A3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GL/lmSvS29zv4OJ5eOFioqWwmoJ5tqbEnzbCNZ2E/dCPPJfzmMMvy5CBrP7bUHH8d8Vli6BLQNLpVs0wbwcONeB/bGWcIcimF0jOcvlBWQftWzT7WRofFFV+H+e8EERWELHeRn2BuSvuDoVKuvYn/+fiwIblvbPVU5cAUeNk5Vm8qfX33XXlU2F5IvVENp8ZPlWdPscMFqsvx3lzi852t6Nj5T7Ti6Yok/m1BV6G+La5BFb6OMjhqM0NQXA3hgxu0qcwSXIvSojYwkc9s2tCuk1DhvHW7hYA3x1iFvntC3L5qL0XK6N/1X5gLf3yTw9YMC9fpioO1xKp22f5MwMCCnH6h8JXMjzMMnGBe+Q25Hr0S0AfRNqi2JXsSjHLImCfOWFRPLAUGNErauyPVTtTccAq35RG0mycL2axHhr2MuCFaF5m6Tmhe+AAIpKF5bMF1ZfWjNjvms0+YuvCoYYOhZqwDhLAJzO10q/Cc2jc5930JjYKYR+jxzg4IaCWH7EicSTEtNR51b5asChAYH+OiBHNO0zYW42N4l+dKDIX+CNsYyTen8xECbrnphq/nFwVZPO1glvm4+rSasmaHsmn4A/U5rJMgtfChPjkBDkdL9jCTd1vB5FQaj7dYy67xsZnaO9EhwJjS1I9k6nWC3xQqA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c17ed8-5764-4629-11db-08de32d7a4cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 01:51:29.6869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0l8tTLXxBZoVVDsSpNgzpcHYsBGW7fpcVxWxXvZQUvinAF0s6QF4gHyxQljTkTCMzvTP+g9a4VDYemF0IvMv3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
X-Proofpoint-ORIG-GUID: DxQR6Znnh3LGjs3pgYfs2uhm67M9qdZ8
X-Proofpoint-GUID: DxQR6Znnh3LGjs3pgYfs2uhm67M9qdZ8
X-Authority-Analysis: v=2.4 cv=fK00HJae c=1 sm=1 tr=0 ts=6930e926 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HXOu7QG0cErZX54bDX0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDAxMyBTYWx0ZWRfX5vVPFRpOoVof
 QjtLax0iz6S8RBqM2HUL3esd2Jm00ZPP+DBrIwfGA7nvfz0OCpPKnrK0mtKkG451+M6zfl6uydE
 QZu5dFvpf0LYSUlm483jkoxKMVkKpjwHJAhPt/DNRFBG0YLTElH63QmlLePe0Pw6SmXoAHSFjNH
 nJ4QoiUBiSQUtJ6yq0fBa8D7ac7aQcH7/BdjFkWYi8MVdGZ/rykEaxZvaenE5+V3XF6iT+LZv7J
 D9BCHkgBf7wmtXeyXhJJi5kuurN6LopitoxusSIxt+NqbN/o2ndtk7CfeqR4XLCztwHRtdAxSAr
 48itxyDTKM9frX4eGgwi0jXCIai/UlQuxAg9bs7i8/oOPNDb7vY2RG8lKBSu5qs+b1ZLlJzmJoc
 9W+XPVxnHq41HkeqO+wmB+kKW/rTig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_01,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512040013

T24gV2VkLCBEZWMgMDMsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
MTEvMjEvMjAyNSA4OjM4IEFNLCBBbGFuIFN0ZXJuIHdyb3RlOg0KPiA+IE9uIEZyaSwgTm92IDIx
LCAyMDI1IGF0IDAyOjIyOjAyQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPj4gT24g
V2VkLCBOb3YgMTksIDIwMjUsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+ID4+PiAtPnNldF9hbHQoKSBp
cyBjYWxsZWQgYnkgdGhlIGNvbXBvc2l0ZSBjb3JlIHdoZW4gYSBTZXQtSW50ZXJmYWNlIG9yDQo+
ID4+PiBTZXQtQ29uZmlnIGNvbnRyb2wgcmVxdWVzdCBhcnJpdmVzIGZyb20gdGhlIGhvc3QuICBJ
dCBoYXBwZW5zIHdpdGhpbiB0aGUNCj4gPj4+IGNvbXBvc2l0ZV9zZXR1cCgpIGhhbmRsZXIsIHdo
aWNoIGlzIGNhbGxlZCBieSB0aGUgVURDIGRyaXZlciB3aGVuIGENCj4gPj4+IGNvbnRyb2wgcmVx
dWVzdCBhcnJpdmVzLCB3aGljaCBtZWFucyBpdCBoYXBwZW5zIGluIHRoZSBjb250ZXh0IG9mIHRo
ZQ0KPiA+Pj4gVURDIGRyaXZlcidzIGludGVycnVwdCBoYW5kbGVyLiAgVGhlcmVmb3JlIC0+c2V0
X2FsdCgpIGNhbGxiYWNrcyBtdXN0DQo+ID4+PiBub3Qgc2xlZXAuDQo+ID4+IFRoaXMgc2hvdWxk
IGJlIGNoYW5nZWQuIEkgZG9uJ3QgdGhpbmsgd2UgY2FuIGV4cGVjdCBzZXRfYWx0KCkgdG8NCj4g
Pj4gYmUgaW4gaW50ZXJydXB0IGNvbnRleHQgb25seS4NCj4gPiBBZ3JlZWQuDQo+ID4NCj4gPj4+
IFRvIGRvIHRoaXMgcmlnaHQsIEkgY2FuJ3QgdGhpbmsgb2YgYW55IGFwcHJvYWNoIG90aGVyIHRo
YW4gdG8gbWFrZSB0aGUNCj4gPj4+IGNvbXBvc2l0ZSBjb3JlIHVzZSBhIHdvcmsgcXVldWUgb3Ig
b3RoZXIga2VybmVsIHRocmVhZCBmb3IgaGFuZGxpbmcNCj4gPj4+IFNldC1JbnRlcmZhY2UgYW5k
IFNldC1Db25maWcgY2FsbHMuDQo+ID4+IFNvdW5kcyBsaWtlIGl0IHNob3VsZCd2ZSBiZWVuIGxp
a2UgdGhpcyBpbml0aWFsbHkuDQo+ID4gSSBndWVzcyB0aGUgbm9ib2R5IHRob3VnaHQgdGhyb3Vn
aCB0aGUgaXNzdWVzIHZlcnkgY2FyZWZ1bGx5IGF0IHRoZSB0aW1lDQo+ID4gdGhlIGNvbXBvc2l0
ZSBmcmFtZXdvcmsgd2FzIGRlc2lnbmVkLiAgTWF5YmUgdGhlIFVEQ3MgdGhhdCBleGlzdGVkIGJh
Y2sNCj4gPiBkaWQgbm90IHJlcXVpcmUgYSBsb3Qgb2YgdGltZSB0byBmbHVzaCBlbmRwb2ludHM7
IEkgY2FuJ3QgcmVtZW1iZXIuDQo+ID4NCj4gPj4+IFdpdGhvdXQgdGhhdCBhYmlsaXR5LCB3ZSB3
aWxsIGhhdmUgdG8gYXVkaXQgZXZlcnkgZnVuY3Rpb24gZHJpdmVyIHRvDQo+ID4+PiBtYWtlIHN1
cmUgdGhlIC0+c2V0X2FsdCgpIGNhbGxiYWNrcyBkbyBlbnN1cmUgdGhhdCBlbmRwb2ludHMgYXJl
IGZsdXNoZWQNCj4gPj4+IGJlZm9yZSB0aGV5IGFyZSByZS1lbmFibGVkLg0KPiA+Pj4NCj4gPj4+
IFRoZXJlIGRvZXMgbm90IHNlZW0gdG8gYmUgYW55IHdheSB0byBmaXggdGhlIHByb2JsZW0ganVz
dCBieSBjaGFuZ2luZw0KPiA+Pj4gdGhlIGdhZGdldCBjb3JlLg0KPiA+Pj4NCj4gPj4gV2UgY2Fu
IGhhdmUgYSB3b3JrYXJvdW5kIGluIGR3YzMgdGhhdCBjYW4gdGVtcG9yYXJpbHkgIndvcmsiIHdp
dGggd2hhdA0KPiA+PiB3ZSBoYXZlLiBIb3dldmVyLCBldmVudHVhbGx5LCB3ZSB3aWxsIG5lZWQg
dG8gcHJvcGVybHkgcmV3b3JrIHRoaXMgYW5kDQo+ID4+IGF1ZGl0IHRoZSBnYWRnZXQgZHJpdmVy
cy4NCj4gPiBDbGVhcmx5LCB0aGUgZmlyc3Qgc3RlcCBpcyB0byBjaGFuZ2UgdGhlIGNvbXBvc2l0
ZSBjb3JlLiAgVGhhdCBjYW4gYmUNCj4gPiBkb25lIHdpdGhvdXQgbWVzc2luZyB1cCBhbnl0aGlu
ZyBlbHNlLiAgQnV0IHllcywgZXZlbnR1YWxseSB0aGUgZ2FkZ2V0DQo+ID4gZHJpdmVycyB3aWxs
IGhhdmUgdG8gYmUgYXVkaXRlZC4NCj4gPg0KPiA+IEFsYW4gU3Rlcm4NCj4gDQo+IA0KPiBIaSBU
aGluaCwNCj4gDQo+IERvIHlvdSBoYXZlIGFueSBzdWdnZXN0aW9ucyB0aGF0IG1pZ2h0IGJlIGhl
bHBmdWwgZm9yIHVzIHRvIHRyeSBvbiBvdXIgc2lkZT8NCj4gVGhpcyBFUCByZXNvdXJjZeKAkWNv
bmZsaWN0IHByb2JsZW0gYmVjb21lcyBlYXNpbHkgb2JzZXJ2YWJsZSB3aGVuIHRoZSANCj4gUk5E
SVMgbmV0d29yayB0ZXN0IGV4ZWN1dGluZyBpZmNvbmZpZyBybmRpczAgZG93bi91cCBpcyBydW4g
cmVwZWF0ZWRseSANCj4gb24gdGhlIGRldmljZSBzaWRlLg0KPiANCj4gVGhhbmtzLA0KPiBTZWx2
YQ0KDQpBdCB0aGUgbW9tZW50LCBJIGNhbid0IHRoaW5rIG9mIGEgd2F5IHRvIHdvcmthcm91bmQg
Zm9yIGFsbCBjYXNlcy4gTGV0J3MNCmp1c3QgbGVhdmUgYnVsayBzdHJlYW1zIGFsb25lIGZvciBu
b3cuIFVudGlsIHdlIGhhdmUgcHJvcGVyIGZpeGVzIHRvIHRoZQ0KZ2FkZ2V0IGZyYW1ld29yaywg
bGV0J3MganVzdCB0cnkgdGhlIGJlbG93Lg0KDQpUaGFua3MsDQpUaGluaA0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
CmluZGV4IDM4MzBhYTJjMTBhOS4uOTc0NTczMzA0NDQxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KQEAgLTk2
MCwxMSArOTYwLDE4IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF9lcF9lbmFibGUoc3RydWN0
IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQgaW50IGFjdGlvbikNCiAJfQ0KIA0KIAkvKg0KLQkgKiBJ
c3N1ZSBTdGFydFRyYW5zZmVyIGhlcmUgd2l0aCBuby1vcCBUUkIgc28gd2UgY2FuIGFsd2F5cyBy
ZWx5IG9uIE5vDQotCSAqIFJlc3BvbnNlIFVwZGF0ZSBUcmFuc2ZlciBjb21tYW5kLg0KKwkgKiBG
b3Igc3RyZWFtcywgYXQgc3RhcnQsIHRoZXJlIG1heWJlIGEgcmFjZSB3aGVyZSB0aGUNCisJICog
aG9zdCBwcmltZXMgdGhlIGVuZHBvaW50IGJlZm9yZSB0aGUgZnVuY3Rpb24gZHJpdmVyDQorCSAq
IHF1ZXVlcyBhIHJlcXVlc3QgdG8gaW5pdGlhdGUgYSBzdHJlYW0uIEluIHRoYXQgY2FzZSwNCisJ
ICogdGhlIGNvbnRyb2xsZXIgd2lsbCBub3Qgc2VlIHRoZSBwcmltZSB0byBnZW5lcmF0ZSB0aGUN
CisJICogRVJEWSBhbmQgc3RhcnQgc3RyZWFtLiBUbyB3b3JrYXJvdW5kIHRoaXMsIGlzc3VlIGEN
CisJICogbm8tb3AgVFJCIGFzIG5vcm1hbCwgYnV0IGVuZCBpdCBpbW1lZGlhdGVseS4gQXMgYQ0K
KwkgKiByZXN1bHQsIHdoZW4gdGhlIGZ1bmN0aW9uIGRyaXZlciBxdWV1ZXMgdGhlIHJlcXVlc3Qs
DQorCSAqIHRoZSBuZXh0IFNUQVJUX1RSQU5TRkVSIGNvbW1hbmQgd2lsbCBjYXVzZSB0aGUNCisJ
ICogY29udHJvbGxlciB0byBnZW5lcmF0ZSBhbiBFUkRZIHRvIGluaXRpYXRlIHRoZQ0KKwkgKiBz
dHJlYW0uDQogCSAqLw0KLQlpZiAodXNiX2VuZHBvaW50X3hmZXJfYnVsayhkZXNjKSB8fA0KLQkJ
CXVzYl9lbmRwb2ludF94ZmVyX2ludChkZXNjKSkgew0KKwlpZiAoZGVwLT5zdHJlYW1fY2FwYWJs
ZSkgew0KIAkJc3RydWN0IGR3YzNfZ2FkZ2V0X2VwX2NtZF9wYXJhbXMgcGFyYW1zOw0KIAkJc3Ry
dWN0IGR3YzNfdHJiCSp0cmI7DQogCQlkbWFfYWRkcl90IHRyYl9kbWE7DQpAQCAtOTgzLDM1ICs5
OTAsMjEgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2VwX2VuYWJsZShzdHJ1Y3QgZHdjM19l
cCAqZGVwLCB1bnNpZ25lZCBpbnQgYWN0aW9uKQ0KIAkJaWYgKHJldCA8IDApDQogCQkJcmV0dXJu
IHJldDsNCiANCi0JCWlmIChkZXAtPnN0cmVhbV9jYXBhYmxlKSB7DQotCQkJLyoNCi0JCQkgKiBG
b3Igc3RyZWFtcywgYXQgc3RhcnQsIHRoZXJlIG1heWJlIGEgcmFjZSB3aGVyZSB0aGUNCi0JCQkg
KiBob3N0IHByaW1lcyB0aGUgZW5kcG9pbnQgYmVmb3JlIHRoZSBmdW5jdGlvbiBkcml2ZXINCi0J
CQkgKiBxdWV1ZXMgYSByZXF1ZXN0IHRvIGluaXRpYXRlIGEgc3RyZWFtLiBJbiB0aGF0IGNhc2Us
DQotCQkJICogdGhlIGNvbnRyb2xsZXIgd2lsbCBub3Qgc2VlIHRoZSBwcmltZSB0byBnZW5lcmF0
ZSB0aGUNCi0JCQkgKiBFUkRZIGFuZCBzdGFydCBzdHJlYW0uIFRvIHdvcmthcm91bmQgdGhpcywg
aXNzdWUgYQ0KLQkJCSAqIG5vLW9wIFRSQiBhcyBub3JtYWwsIGJ1dCBlbmQgaXQgaW1tZWRpYXRl
bHkuIEFzIGENCi0JCQkgKiByZXN1bHQsIHdoZW4gdGhlIGZ1bmN0aW9uIGRyaXZlciBxdWV1ZXMg
dGhlIHJlcXVlc3QsDQotCQkJICogdGhlIG5leHQgU1RBUlRfVFJBTlNGRVIgY29tbWFuZCB3aWxs
IGNhdXNlIHRoZQ0KLQkJCSAqIGNvbnRyb2xsZXIgdG8gZ2VuZXJhdGUgYW4gRVJEWSB0byBpbml0
aWF0ZSB0aGUNCi0JCQkgKiBzdHJlYW0uDQotCQkJICovDQotCQkJZHdjM19zdG9wX2FjdGl2ZV90
cmFuc2ZlcihkZXAsIHRydWUsIHRydWUpOw0KKwkJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcihk
ZXAsIHRydWUsIHRydWUpOw0KIA0KLQkJCS8qDQotCQkJICogQWxsIHN0cmVhbSBlcHMgd2lsbCBy
ZWluaXRpYXRlIHN0cmVhbSBvbiBOb1N0cmVhbQ0KLQkJCSAqIHJlamVjdGlvbi4NCi0JCQkgKg0K
LQkJCSAqIEhvd2V2ZXIsIGlmIHRoZSBjb250cm9sbGVyIGlzIGNhcGFibGUgb2YNCi0JCQkgKiBU
WEZfRkxVU0hfQllQQVNTLCB0aGVuIElOIGRpcmVjdGlvbiBlbmRwb2ludHMgd2lsbA0KLQkJCSAq
IGF1dG9tYXRpY2FsbHkgcmVzdGFydCB0aGUgc3RyZWFtIHdpdGhvdXQgdGhlIGRyaXZlcg0KLQkJ
CSAqIGluaXRpYXRpb24uDQotCQkJICovDQotCQkJaWYgKCFkZXAtPmRpcmVjdGlvbiB8fA0KLQkJ
CSAgICAhKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM5ICYNCi0JCQkgICAgICBEV0MzX0dIV1BBUkFN
UzlfREVWX1RYRl9GTFVTSF9CWVBBU1MpKQ0KLQkJCQlkZXAtPmZsYWdzIHw9IERXQzNfRVBfRk9S
Q0VfUkVTVEFSVF9TVFJFQU07DQotCQl9DQorCQkvKg0KKwkJICogQWxsIHN0cmVhbSBlcHMgd2ls
bCByZWluaXRpYXRlIHN0cmVhbSBvbiBOb1N0cmVhbQ0KKwkJICogcmVqZWN0aW9uLg0KKwkJICoN
CisJCSAqIEhvd2V2ZXIsIGlmIHRoZSBjb250cm9sbGVyIGlzIGNhcGFibGUgb2YNCisJCSAqIFRY
Rl9GTFVTSF9CWVBBU1MsIHRoZW4gSU4gZGlyZWN0aW9uIGVuZHBvaW50cyB3aWxsDQorCQkgKiBh
dXRvbWF0aWNhbGx5IHJlc3RhcnQgdGhlIHN0cmVhbSB3aXRob3V0IHRoZSBkcml2ZXINCisJCSAq
IGluaXRpYXRpb24uDQorCQkgKi8NCisJCWlmICghZGVwLT5kaXJlY3Rpb24gfHwNCisJCSAgICAh
KGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM5ICYNCisJCSAgICAgIERXQzNfR0hXUEFSQU1TOV9ERVZf
VFhGX0ZMVVNIX0JZUEFTUykpDQorCQkJZGVwLT5mbGFncyB8PSBEV0MzX0VQX0ZPUkNFX1JFU1RB
UlRfU1RSRUFNOw0KIAl9DQogDQogb3V0Og0K

