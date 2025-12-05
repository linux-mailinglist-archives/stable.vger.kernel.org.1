Return-Path: <stable+bounces-200091-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D731CA5C14
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 01:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80CB8311F8D6
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 00:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4521D6187;
	Fri,  5 Dec 2025 00:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="I7BMFAJz";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TN6YUokN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TvNVCSUv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AEE1448E0;
	Fri,  5 Dec 2025 00:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764895071; cv=fail; b=biU2x7QVgS5nkt2Zbez1IqPRsLxxB+rjzIayRVD3pRej4lMcizYjS7Fdp1GuvOd0XeWtRNs4kiEtUNuDBxKFGi1LD37LFYSbsuf8/DxrEDu9Vj6XDHM+wFOrWzu8dEEUOfzZacgkNX1jPZympuQYAKC0tVbTvCthKJl1GU/s9ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764895071; c=relaxed/simple;
	bh=XQNXfDGeoHixfnZJMfe6hi7JSsB5zYmSQysx2caevY8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aAvvJbMVdvwgsHJeZ/lggCZHqJa0foYIUXj32UjeU1/rVqykJ65VB/xURSywEVXoKMam/7D4YozB7FI4+djgtFCHmCN+I3gF++ktyX0r4u0ac+JuQjw/Zv/ExnJukhBwJdH8nlJK7l0zIUVHZ+ro99L88FTTfVAXr0JyUzu+ruc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=I7BMFAJz; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TN6YUokN; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TvNVCSUv reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4Jfmtd2769770;
	Thu, 4 Dec 2025 16:37:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=XQNXfDGeoHixfnZJMfe6hi7JSsB5zYmSQysx2caevY8=; b=
	I7BMFAJzF0H761omURP9xfc/PwN4EJjZ52DE+NmhP0bmcaMs2HlAKxvqYS6Kd1+0
	ulXNKVVYJjD9sVxnWgg0oZNsWxYVBD35yfvRKwa9DHAAR5pm00wi8W3TbasujYvI
	WqhNgYgWosA8I6mTxTx3yL1/y+dmoTsFhKRKKz+vAYZB0kPOcLZqRnjMl8ja9Fao
	vsEvy7F9VDetEPLWGLkhGL84Oyk4uJkfWsZQZRcPdyEwJfOMQG9D0sCgga7MfyJF
	9mCjwcS321JytAtprA4QDvqHMJ4Egv/gNbARfDMso/8k7wpnv5rIwoeJETeYuaBf
	aK2p0ObD3x4XA77VFwiNyA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4au057x3m7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Dec 2025 16:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1764895058; bh=XQNXfDGeoHixfnZJMfe6hi7JSsB5zYmSQysx2caevY8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TN6YUokNwy8F3CUIU+SdjBF07pE6aNAV9sk1E5igXL5+3gkVF1/vGM+Y2Ni8iGHwt
	 kOl+Pf2t6m0phbbuT64nycxyOUCcc+BunNLE4HOkqqVEqLFhGv1o0uhqdZSjrOFv0M
	 R14KRtHnq/TH5TAd2adK7Z7/fa54HnIcXZdib6YgT98M1J5i4MHeAviw80C73gQv7P
	 YUXHOWcPagXx1ccAh7MR8BB7La77+uM9yFxY15b7o+z1UKSV6bKO9e/yNVTVl3KzmS
	 UwydiWIcjdIRPR4jKwjBzsBXFO/lOgC58ufu1etILN5ur6NTC+TRXkzfwL8X1ZoebX
	 Sj0TTE1H5cYtQ==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F3067401CB;
	Fri,  5 Dec 2025 00:37:37 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 875C1A0087;
	Fri,  5 Dec 2025 00:37:37 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TvNVCSUv;
	dkim-atps=neutral
Received: from CO1PR08CU001.outbound.protection.outlook.com (mail-co1pr08cu00106.outbound.protection.outlook.com [40.93.10.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AF34640980;
	Fri,  5 Dec 2025 00:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrqeNIVF1+ZJwj9+uPVcuaUrkzlEuoGrH4LNeCRmPvA0Ii6ei+xMM60mF3hkfWsKnLdYgMCoaj6y2YiGTjc+hncPcG4b539tcu2K5TMbj7frS4x7Sm+bi1O0uiJxklHTGy1I2sSDQxWUuZ7qgadzM6Vsc1O7BTlOzyqlSYDwHvIn1NXGmRCh1rUU3vDvLvkv9kQ95XcoSksZqyXAx6R+Cdo+NuUL/i0KxsbOiXzc/P9tKDEeNgctbPKAXgZevMRLvwrDK2gEVtTGMCzr1uLf34AQSBFBlCzpJQ/OG4JVjO2twjbTQYvJFF2pseG8ozZEdbkKhCDm2VnvSUXilDzhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQNXfDGeoHixfnZJMfe6hi7JSsB5zYmSQysx2caevY8=;
 b=JWFJ0UJBL0wUaBVx7+K/2/IjTaTa7hEjDpGfjeU1MafYK5BVSzLg6xLOljpFE/Z3VikCd5oesx3LwpR2b/C4h5C4lt9WRkHxy5BGgIA7rEYF9Vlvn+DM5j8/OjuLtQWJ5qIqe0p7wWcPa8j83niQsBrRRGBYlZ877J92yM9Cs+jiejSMtRxKSwpdGQsLwJXkvrOjqCQjykU7r+4PWyUcx6mmV8caCXkr5aKzpuXSHAi8lcUxWJbGHDTB3qS2TfoBiXSgUBgepzHTdylC5WAptAxHxEPlgZOKDz7o6a/c5UWBPpI+Frsp6Tb2xr/lv/6ePg0H4l3/TLTZxcdvfLPGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQNXfDGeoHixfnZJMfe6hi7JSsB5zYmSQysx2caevY8=;
 b=TvNVCSUvwnAp8DHSwcN1hx0IvN2MYtpvrVTLI6qDvXfKj0BF7EiuKlDBmZt1KHT7xqk0A19P1+VJABwNK04s/gXIx7wq3yuiwv0e5sodrvwEbnzCCLnwpHjlOJ5GLXk9WXJqnioVb3aiIQXMyJdt4LcduwS1iHJOqUtHzbviBd4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 00:37:31 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 00:37:31 +0000
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
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Index:
 AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAhQQCAAWgNAIAAJ0QAgAFwPYCAABgXAIABfkgAgAAM6ACAEwJnAIABVnmAgAC/OICAAL5tgA==
Date: Fri, 5 Dec 2025 00:37:31 +0000
Message-ID: <20251205003723.rum7bexy2tazcdwb@synopsys.com>
References: <20251119014858.5phpkofkveb2q2at@synopsys.com>
 <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
 <20251120020729.k6etudqwotodnnwp@synopsys.com>
 <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
 <20251121022156.vbnheb6r2ytov7bt@synopsys.com>
 <f6bba9d1-2221-4bad-a7d7-564a5a311de1@rowland.harvard.edu>
 <4e82c0dd-4a36-4e1d-a93a-9bef5d63aa50@samsung.com>
 <CGME20251204015221epcas5p3ed1b6174589b47629ea9333e3ddbb176@epcas5p3.samsung.com>
 <20251204015125.qgio53oimdes5kjr@synopsys.com>
 <9d309a6f-39b2-43da-96a6-b7c59b98431e@samsung.com>
In-Reply-To: <9d309a6f-39b2-43da-96a6-b7c59b98431e@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8728:EE_
x-ms-office365-filtering-correlation-id: 1de00ba0-41eb-4f60-3b21-08de339679f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFdzMEZaNFc5VmZDQ0t0ZlR6QnFIUVJvVFFWZFdEd2JpM3cya0l2dENsaEpR?=
 =?utf-8?B?eXpBMWdWM3I1MU1ZdE5JTWZVdjJ4dTRpUExlMjlaTEtvRC9yeFd4UEM4T3py?=
 =?utf-8?B?OUlUSDJ1VDVUZFNwOFRhSFJiVFMranBJcm1wK24vNUx3NTA1ZmUwMnRQa3Av?=
 =?utf-8?B?MWRManNPcTFrcDdOU1poSlQ5dWZMSEgvMTR1Q2VvalVRQk1zVW9BYWZPNlFK?=
 =?utf-8?B?RVFmM3FYR1FFWWJZL0ZLMnJXUUlsWUxGT1d4Qks1STJUNVlFNUJHWDgxdm1v?=
 =?utf-8?B?Q2Y2ekhXbDh2ckFPNVhSbHgySXM0ZmZJMFNpclhKblpFQlpGSWFtREV5QmhS?=
 =?utf-8?B?QlkvN2p6UkZTbkhhaHlCaUlKSENXekNodG5ndU9lYjdoaU9vNE0yRWlObHZl?=
 =?utf-8?B?dkJwWHROZTFlcW9jM2xIaE4rNk1VRkczZ1Z6NmQ3SUVXSEJDZEpGMkdNS1JQ?=
 =?utf-8?B?UjV4K3FQN3RNVHhNb1ErbjJBa1Z4eFBlWHRBL1Fmb3RCcXBuTHkvNk5pODRO?=
 =?utf-8?B?WHZWd2JBN1Rqczdza1I0cDJpUFZGTU56ZWJXeTNMdTVISGFmN1cvZy8ycHZi?=
 =?utf-8?B?OEwzanZJcDlTcGtnV3AzNWFWS3EzeHZFZ2lYZjhQKzVVeGNSejgvZXVMT0RL?=
 =?utf-8?B?enVEUXFsWHJSaER3cFZaVmtxZ2hGM0NwbkdVQkh0cWMrVjJDTE51WGhQbWZK?=
 =?utf-8?B?MnQ3SXNCazdpK2szRjkvZW9KUHE1aW5QNUllV29FMTVEd0JCUndlVGlFN0VK?=
 =?utf-8?B?aloxRTZOb1RadVo4SzVzWTlVMkxvdUpvRHczY1JObHV6cHZLUm96NFRydE56?=
 =?utf-8?B?Mno2eXZUbW1hZXpocHk1YXl1UW94U0t6MVhGQjRrenJBeHgvNGcvWGFvb1BD?=
 =?utf-8?B?VzYwMEowZ25pR3ZKSnk1eEhLRWlyM2RqdkdPRTFwd0tNc2orNkloTFhDTjIv?=
 =?utf-8?B?bEs5bjFkYkk0SUFSbFc2UXAzM0ZyczV3M1phTFJRNDNMSHlYbTBSdWRkdHdZ?=
 =?utf-8?B?SDQwYkxxVWxMUCtOc25kUExNOXZ1cythYXlaK2g1M08yMDY4MVpUYXVwOFVC?=
 =?utf-8?B?alU3TjN5SVRFMElNaXhuN0YvQ0t3TVdsaVFyTGxoeFJhbVdVQ3NIYnQ4TWNh?=
 =?utf-8?B?T3JRNkRjeDRyc2tFOGNNN3pxaVRoRklNMUtHeWhRY0hqUFZxeTd1MThOZG9T?=
 =?utf-8?B?dVFuMFlaQWJ3bEV3WEpGdjZESHNHQldlcUpBR0tyUEg4WlR6YUNtdWpHTzFR?=
 =?utf-8?B?dmUwNUVZNW04R0Qya0xaV1cxV0Y5eWFRTEd2M1lWRFRpQmc2aHhnRk1PaGFk?=
 =?utf-8?B?d1BTeXN2VjFzYTlzU2crTWhTQmpzL2xaOUhpOTIzWnd6ZlVnMUtwWHYyNXlo?=
 =?utf-8?B?dW95c01WbFlZcUM2bUNVaEJvNFJvN1FVZjZjbExUN0dZVEV3SmJ3MVVEQ0xZ?=
 =?utf-8?B?UGh4Mitmakx6ODZZRUpzNXZTVXFrY3BJSmJMUGNzMlplQjV0SmtEQ09wb1Bu?=
 =?utf-8?B?MHJ3T1ZUanl5VjBtMFJvMXd4MysvMmhkWlVxV2cwM0orSlNwZnFETE1GOWgv?=
 =?utf-8?B?YmpLRFQ2WHhkdHRibVp4c0dyczVCS2dqRlA0SzRVTWxRYWowaStxZ01XeHV1?=
 =?utf-8?B?OXpGM1o4elR1K0NjS204WjJicVB2RjBpR0dybFJSYUptK0lNZGlqaVE4a0xF?=
 =?utf-8?B?TXplNUxrdkdqanZ4TEdXMlZHOU5SMGo0RHB3d1FqZkFUd00wNWpnYWV6enBz?=
 =?utf-8?B?YTg2WFdheGc4UnRsK1E3b2FiWit6RzU1WlRqV0JUUUcya2EzMzhvUDYyVEVN?=
 =?utf-8?B?MnM1eU8xK0RPcERhb2VuS3pZVlpIMEZyUHk0U24vbVZ5TjZMN3BXT3JlZ3JH?=
 =?utf-8?B?STVBSHU1LzJWSWRvc01TTFR2dXAzR0pNMGNyNTZzVkgzYmZKZ2xOMTVuTW14?=
 =?utf-8?B?Z2EycmYyelBhaWZUYjloWTIrMiszWERNdnhpK2pQc0NxV3g2WjhBSDFmVHJD?=
 =?utf-8?B?ejBTZnVQZm1wZDhZK3JmMGpqNHZLVWNUajhBem0yZldwQWZuMjE4MXpaWXMr?=
 =?utf-8?Q?CLGbQ2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZEhaNUs1UjlPdHFKR2RYYjUweU9hZjZpWW5CRjE5djJPOVhraE9ZS1o0N0F3?=
 =?utf-8?B?R3prWVh0dGxmaGk4V1VROGc0TWJzRzd6a2ppckw0OUd2eHI1dE1PaUJadE5Z?=
 =?utf-8?B?VWM5N3hCQTZzNER6M1pqd3A2Q1hmZHJpN2oyV0w3S3pjZCtlVCt0THBUeEhq?=
 =?utf-8?B?VkRGU2xZWDZpOWJISHNQbzh3Y1U4RzROQWk2QjZISVl3TzF1cDc5d1lUbjM1?=
 =?utf-8?B?YnJRbFZod0MvVW14YlNvbE1CMDBMTVFZVSt5c0s1ME16d0djUFhlcFpPaW1Y?=
 =?utf-8?B?NWpicWJNcEZCeWtWMnhwbisrSGM3VnF6aEo4ckJxeWlWUEJpeERjMUd5UUF2?=
 =?utf-8?B?RFp3RmMwc0VFckNPN3hzNHdUUFRPd3NxbmI5QkpsWWJTeDJCZWowbFBsRWUw?=
 =?utf-8?B?dXdDeGRzV2w1U1hWY1RVMytVdHlZSXJzaHBjbXVjUTUraFF6OXZ6RURvRkdj?=
 =?utf-8?B?T0RmbUtnYk9xelFKejhiWXZFMEN4UC85TXVERmVKejZnaWVJcXhjaUVydDAy?=
 =?utf-8?B?Y3ZRdTJlQ3A2TjV2cllPZzhFZDBIemZDakRZT2ttanl1b1daZm0yUytqa2RT?=
 =?utf-8?B?V2JobHpvUUt2WUkzbEwxK3MwMEJ1N2dTK0s3eXVtNUNUelVka0xjSEFNMHIx?=
 =?utf-8?B?U1JleFlRc3V4RWFqTVNUSVVUL2JDUWtzTThyZldXRkFSSWJIZEpLZHRIVTB1?=
 =?utf-8?B?eWtDMnpIejJObEVTUnRvK1R2Y0ZJcXdhczJOSThzcHRiNGFqS0M3WkNjZlEx?=
 =?utf-8?B?NmpUbXRZa0o5bWJYTnBKenNuc2dXRFhRQjZTdjVRcU10Q3RCbFZ6dFVVZTJQ?=
 =?utf-8?B?VnRmNzNlbmxWZFpNNDBLakZiMWNXbVo5aHNyTFdhcE9zL2hYQVNWczROZW1p?=
 =?utf-8?B?dGxhbzlyRHh5NTJGS3RSUWF5dWppWnZUb0pydmk3bDdBSVF6Tmh2Mm9SR3lV?=
 =?utf-8?B?dFpwSlBDOGZlRExUNk0rUXNaVDNLRzRHT2tWVDN1dEtMNG0wai81YkRVb3ds?=
 =?utf-8?B?VHRKY2s3WlE0TU9uWEYzZEVuSlM3cDBib1llWnpxZmMvS2tZU2VPRnFmUzlK?=
 =?utf-8?B?WjJBOHB0SUdoMWRWY0JrSVdJcmQ0OFF3d3d1WmNHV0NBYStmaGN1ZXA1T0w5?=
 =?utf-8?B?VXVWcTNEZGZaa2JwU3h4bmdDNHFNMWRXZzVueU5xNmVOSGY0ajRLVXBqWGRi?=
 =?utf-8?B?Z0NIemR2WlRKWDF3ZTg4Zy9nSVJ0WEpTVFZSRmVzYTI3TWlKTkZCRmtyVE9G?=
 =?utf-8?B?RlNIZmV2VjJWc0V5Zis2SEpaNHFSQW9Ob01vaHhTK2NBNlJ0bE0xVFJWeFRl?=
 =?utf-8?B?M0JuM0Z4NTRudFg5QnJDbzFmaDQwZi92Tkh3RmVnYy9aTkN6TGU3ZW5YZ25S?=
 =?utf-8?B?S3h1Y1dqL1NMMVkweUdrS2FNOWp5VkVwMlhaOUNuYk5JL1psU1FPTjE1Q1Fo?=
 =?utf-8?B?U3lad3dGbWR4eElqMjNhWnI2TzRJV3lNbndRNXBUS0FkcnZpZW8xVXZ3MVlx?=
 =?utf-8?B?U1RXc2J4R3pyMUYwelJGZG5vWTZqNzdBTzcxamZ5bitOSjAwd2tJOHh6WkR6?=
 =?utf-8?B?SHlGUHIybndZVlExQXlQWFBvVzdoNFJNQjFBK3RHZ3lNNURleW1OcWZUMWZu?=
 =?utf-8?B?b2s3NkhUMXNaVTk5bEt5M3V6VW5BU3czbXZqSlIvQ1VYVXc4SVlSN0pTdGRi?=
 =?utf-8?B?VTBXYWcyTlo1cjYyTXo4aVVuOFppYXVJTGl2c2NwaFJiSEo5aXVvd0RaV2VV?=
 =?utf-8?B?cytZdnVnUkN6NVRRM29lc1RRUE5nVUdWYjd5MlozUzR6NkdMcjBqSUJBaWJp?=
 =?utf-8?B?dkp6NmM3NUhNQ01KOVkrTWV2WXJIdVR6NVl4MWc1UEp6UUtINjI1ZGsyNTg1?=
 =?utf-8?B?SDRQLzd3YVBYQXJDRi91MUZSNjJHcVltSG4yQXR3clBjY2FlYVlJNDJ3OWVr?=
 =?utf-8?B?RVVrYmRkbmRzeGUvQW1tMlV5VmV3aWdvRngyNmZMMk9yY3g5cnVsdytVRGcz?=
 =?utf-8?B?ZnRlR2tTWGFMZm5WMUU4WkhzanFjdUcwallpVXdFUTNoamJwT0haK2NrOFFx?=
 =?utf-8?B?Y2JLclJUOHhFNGEwSVo1Uk9qbGlNVktMRHBGdUsxM3cxVm4rTDdrcDRLK1Ns?=
 =?utf-8?Q?NrwMQf1xCmaoO1qWfhCrVg97l?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4575B884C9FFD046B432C51F876F3E9E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2MaODIyOXRh/BmRAw0P0cAewRsR2PO5GlzQ8d9JaQ5JR/BTeXgZYDRA28O1adXaSqJVPW/3zTjDpNYs5NQ6rvoUgpXFh6D8jk2+eopwTa/33rmJwc00Xe4p97kGc0PmWIXCX07U8c2RodZhwmxm3RSR1KkS9CYnhJptKY2TeAn0iRqk+0xeLKGflNLvzYlbUSeBU6P+EM4aSZxbPi7ckzfHTm6uyuowdyS6xDHOiRSEEDrz/N/tlNHuFihHodgd9wNcmm7FjsXp8EMwJf0sre2NgbM3onDGTeOQF+5yRyXDGKGAXJ7RfcdF8uX9HIjFJYdamrg3pv1vSjW5dgYckrqGPM+L3TqoEgAi6PSjk7LyjCE9GqASvj82pDWG3QykguoWYr1iK4T0oBcM8Gj8WTDyXG3QDvXyI/AV3LCdTYJPFyKllZlgbabUxDR4HF9PpQaXqb02NP6IZOcc7eTceWy5mt77xHcdp5L0G0cunK39S62q4tMs0voXYvdp/HevKEKNrBIOdSvmKDEaP5gMi+jF/elL1y4SaPA29BThKEo/MRTiBh/0oQ1Mh+bFV47E/DFvWtn967u7xPvMoQJj4gsfPZioTN3Mq8t0VlCUr0S60YZ94YSBVvnAC/kC3BMq7pdhJXblHYeme1lsH288FZQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de00ba0-41eb-4f60-3b21-08de339679f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 00:37:31.7116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6MYIIhw4rNu8l5wKO14hQ2oEBc6eBqaCBQ/XaZpe2b337BX5oVvQqAT52OxB+V1EhL1mtdLbDNLJ3ej/qsVgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
X-Authority-Analysis: v=2.4 cv=dozWylg4 c=1 sm=1 tr=0 ts=69322952 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uMrF3-gnynrVQ4vwiMsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: w4hVlNf6PXw9teG6Il6w1ED4VUjU2hLa
X-Proofpoint-GUID: w4hVlNf6PXw9teG6Il6w1ED4VUjU2hLa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDAwMyBTYWx0ZWRfXxUslbdiMV0zx
 W/51hbpMjcxoUMXSqDt9w2Xwvk+vaECz+Ts1TAJrFkkCEKr/XWSCKnX7llH5FjyrqLQETIXjFx9
 08OTBIv1fmRoUGvgvEfW3UEbqiM7E+wIuIY8dT+ZPiFMQu+YrHDAmGQc1g3WecvAHTVrgwUPDD9
 1OxrapxrCIixHmQZsvc+uS3Ux8nY/i41oEkulFjTTMq7h8mRh5r+CKJwni74m2cspKhNfAuFKBA
 +FijL4fFMj0D1ANJlR/uFRq2DGfPNcTf25IAfP+iUF/20r+1d3x3QwGw6ALeaSGhxNtPH4GzNts
 7BuDwM8td7mmMsShjINCddo3J9Bfx002ZGOGerSKlogR8IHsqrXTrLbRaddP5s9YqHmHcioeuJ5
 5Lsv1C1vh7pp8PByZq7+b+YRSEOk0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_06,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512050003

T24gVGh1LCBEZWMgMDQsIDIwMjUsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
MTIvNC8yMDI1IDc6MjEgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBBdCB0aGUgbW9tZW50
LCBJIGNhbid0IHRoaW5rIG9mIGEgd2F5IHRvIHdvcmthcm91bmQgZm9yIGFsbCBjYXNlcy4gTGV0
J3MNCj4gPiBqdXN0IGxlYXZlIGJ1bGsgc3RyZWFtcyBhbG9uZSBmb3Igbm93LiBVbnRpbCB3ZSBo
YXZlIHByb3BlciBmaXhlcyB0byB0aGUNCj4gPiBnYWRnZXQgZnJhbWV3b3JrLCBsZXQncyBqdXN0
IHRyeSB0aGUgYmVsb3cuDQo+ID4NCj4gDQo+IA0KPiBIaSBUaGluaCwNCj4gDQo+IFRoYW5rcyBm
b3IgdGhlIGNoYW5nZXMuIFdlIHVuZGVyc3RhbmQgdGhlIGdpdmVuIGZpeCBhbmQgaGF2ZSB2ZXJp
ZmllZCANCj4gdGhhdCB0aGUgb3JpZ2luYWwgaXNzdWUgaXMgcmVzb2x2ZWQsIGJ1dCBhIHNpbWls
YXIgYmVsb3cgd2FybmluZyBhcHBlYXJzIA0KPiBhZ2FpbiBpbiBgZHdjM19nYWRnZXRfZXBfcXVl
dWVgIHdoZW4gd2UgcnVuIGEgbG9uZyBkdXJhdGlvbiBvdXIgdGVzdC4gDQo+IEFuZCB3ZSBjb25m
aXJtZWQgdGhpcyBpcyBub3QgZHVlIHRvIHRoaXMgbmV3IGdpdmVuIGNoYW5nZXMuDQo+IA0KPiBU
aGlzIHdhcm5pbmcgaXMgY2F1c2VkIGJ5IGEgcmFjZSBiZXR3ZWVuIGBkd2MzX2dhZGdldF9lcF9k
aXNhYmxlYCBhbmQgDQo+IGBkd2MzX2dhZGdldF9lcF9xdWV1ZWAgdGhhdCBtYW5pcHVsYXRlcyBg
ZGVwLT5mbGFnc2AuDQo+IA0KPiBQbGVhc2UgcmVmZXIgdGhlIGJlbG93IHNlcXVlbmNlIGZvciB0
aGUgcmVmZXJlbmNlLg0KPiANCj4gVGhlIHdhcm5pbmcgb3JpZ2luYXRlcyBmcm9tIGEgcmFjZSBj
b25kaXRpb24gYmV0d2VlbiANCj4gZHdjM19nYWRnZXRfZXBfZGlzYWJsZcKgYW5kIGR3YzNfc2Vu
ZF9nYWRnZXRfZXBfY21kIGZyb20gDQo+IGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlwqB0aGF0IGJvdGgg
bWFuaXB1bGF0ZSBkZXAtPmZsYWdzLiBQcm9wZXIgDQo+IHN5bmNocm9uaXphdGlvbiBvciBhIGNo
ZWNrIGlzIG5lZWRlZCB3aGVuIG1hc2tpbmcgKGRlcC0+ZmxhZ3MgJj0gbWFzaykgDQo+IGluc2lk
ZSBkd2MzX2dhZGdldF9lcF9kaXNhYmxlLg0KPiANCg0KSSB3YXMgaG9waW5nIHRoYXQgdGhlIGR3
YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkgd29uJ3QgY29tZSBlYXJseSB0byBydW4NCmludG8gdGhpcyBz
Y2VuYXJpby4gV2hhdCBJJ3ZlIHByb3ZpZGVkIHdpbGwgb25seSBtaXRpZ2F0ZSBhbmQgd2lsbCBu
b3QNCnJlc29sdmUgZm9yIGFsbCBjYXNlcy4gSXQgc2VlbXMgYWRkaW5nIG1vcmUgY2hlY2tzIGlu
IGR3YzMgd2lsbCBiZQ0KbW9yZSBtZXNzeS4NCg0KUHJvYmFibHkgd2Ugc2hvdWxkIHRyeSByZXdv
cmsgdGhlIHVzYiBnYWRnZXQgZnJhbWV3b3JrIGluc3RlYWQgb2YNCndvcmthcm91bmQgdGhlIHBy
b2JsZW0gaW4gZHdjMy4gSGVyZSBpcyBhIHBvdGVudGlhbCBzb2x1dGlvbiBJJ20NCnRoaW5raW5n
OiBpbnRyb2R1Y2UgdXNiX2VwX2Rpc2FibGVfd2l0aF9mbHVzaCgpLg0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Nv
cmUuYw0KaW5kZXggMDQ3NGM5MmFjNDFhLi5mNWJiMDY0YzJlOWMgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2NvcmUuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9j
b3JlLmMNCkBAIC0xNDQsMTAgKzE0NCw5IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHVzYl9lcF9lbmFi
bGUpOw0KICAqIHVzYl9lcF9kaXNhYmxlIC0gZW5kcG9pbnQgaXMgbm8gbG9uZ2VyIHVzYWJsZQ0K
ICAqIEBlcDp0aGUgZW5kcG9pbnQgYmVpbmcgdW5jb25maWd1cmVkLiAgbWF5IG5vdCBiZSB0aGUg
ZW5kcG9pbnQgbmFtZWQgImVwMCIuDQogICoNCi0gKiBubyBvdGhlciB0YXNrIG1heSBiZSB1c2lu
ZyB0aGlzIGVuZHBvaW50IHdoZW4gdGhpcyBpcyBjYWxsZWQuDQotICogYW55IHBlbmRpbmcgYW5k
IHVuY29tcGxldGVkIHJlcXVlc3RzIHdpbGwgY29tcGxldGUgd2l0aCBzdGF0dXMNCi0gKiBpbmRp
Y2F0aW5nIGRpc2Nvbm5lY3QgKC1FU0hVVERPV04pIGJlZm9yZSB0aGlzIGNhbGwgcmV0dXJucy4N
Ci0gKiBnYWRnZXQgZHJpdmVycyBtdXN0IGNhbGwgdXNiX2VwX2VuYWJsZSgpIGFnYWluIGJlZm9y
ZSBxdWV1ZWluZw0KKyAqIE5vIG90aGVyIHRhc2sgbWF5IGJlIHVzaW5nIHRoaXMgZW5kcG9pbnQg
d2hlbiB0aGlzIGlzIGNhbGxlZC4NCisgKiBQZW5kaW5nIGFuZCBpbmNvbXBsZXRlZCByZXF1ZXN0
cyBtdXN0IGJlIGZsdXNoZWQgYmVmb3JlIGV4ZWN1dGluZw0KKyAqIHRoaXMuIEdhZGdldCBkcml2
ZXJzIG11c3QgY2FsbCB1c2JfZXBfZW5hYmxlKCkgYWdhaW4gYmVmb3JlIHF1ZXVlaW5nDQogICog
cmVxdWVzdHMgdG8gdGhlIGVuZHBvaW50Lg0KICAqDQogICogVGhpcyByb3V0aW5lIG1heSBiZSBj
YWxsZWQgaW4gYW4gYXRvbWljIChpbnRlcnJ1cHQpIGNvbnRleHQuDQpAQCAtMTc0LDYgKzE3Myw0
MCBAQCBpbnQgdXNiX2VwX2Rpc2FibGUoc3RydWN0IHVzYl9lcCAqZXApDQogfQ0KIEVYUE9SVF9T
WU1CT0xfR1BMKHVzYl9lcF9kaXNhYmxlKTsNCiANCisvKioNCisgKiB1c2JfZXBfZGlzYWJsZV93
aXRoX2ZsdXNoIC0gZGlzYWJsZSBhbmQgZmx1c2ggZW5kcG9pbnQNCisgKiBAZXA6IHRoZSBub24t
Y29udHJvbCBlbmRwb2ludCB0byBiZSBkaXNhYmxlZCBhbmQgZmx1c2hlZC4NCisgKg0KKyAqIE5v
IG90aGVyIHRhc2sgbWF5IGJlIHVzaW5nIHRoaXMgZW5kcG9pbnQgd2hlbiB0aGlzIGlzIGNhbGxl
ZC4NCisgKiBBbnkgcGVuZGluZyBhbmQgaW5jb21wbGV0ZWQgcmVxdWVzdHMgd2lsbCBiZSBjb21w
bGV0ZWQgd2l0aCBzdGF0dXMNCisgKiBpbmRpY2F0aW5nIGRpc2Nvbm5lY3QgKC1FU0hVVERPV04p
IGJlZm9yZSB0aGlzIGNhbGwgcmV0dXJucy4NCisgKiBnYWRnZXQgZHJpdmVycyBtdXN0IGNhbGwg
dXNiX2VwX2VuYWJsZSgpIGFnYWluIGJlZm9yZSBxdWV1ZWluZw0KKyAqIHJlcXVlc3RzIHRvIHRo
ZSBlbmRwb2ludC4NCisgKg0KKyAqIFRoaXMgcm91dGluZSBtdXN0IGJlIGNhbGxlZCBpbiBwcm9j
ZXNzIGNvbnRleHQuDQorICoNCisgKiByZXR1cm5zIHplcm8sIG9yIGEgbmVnYXRpdmUgZXJyb3Ig
Y29kZS4NCisgKi8NCitpbnQgdXNiX2VwX2Rpc2FibGVfd2l0aF9mbHVzaChzdHJ1Y3QgdXNiX2Vw
ICplcCkNCit7DQorCWludCByZXQgPSAwOw0KKw0KKwlpZiAoIWVwLT5lbmFibGVkKQ0KKwkJZ290
byBvdXQ7DQorDQorCWlmICghZXAtPm9wcy0+ZGlzYWJsZV93aXRoX2ZsdXNoKQ0KKwkJcmV0dXJu
IC1FT1BOT1RTVVBQOw0KKw0KKwllcC0+ZW5hYmxlZCA9IGZhbHNlOw0KKw0KKwlyZXQgPSBlcC0+
b3BzLT5kaXNhYmxlX3dpdGhfZmx1c2goZXApOw0KK291dDoNCisJdHJhY2VfdXNiX2VwX2Rpc2Fi
bGVfd2l0aF9mbHVzaChlcCwgcmV0KTsNCisNCisJcmV0dXJuIHJldDsNCit9DQorRVhQT1JUX1NZ
TUJPTF9HUEwodXNiX2VwX2Rpc2FibGVfd2l0aF9mbHVzaCk7DQorDQogLyoqDQogICogdXNiX2Vw
X2FsbG9jX3JlcXVlc3QgLSBhbGxvY2F0ZSBhIHJlcXVlc3Qgb2JqZWN0IHRvIHVzZSB3aXRoIHRo
aXMgZW5kcG9pbnQNCiAgKiBAZXA6dGhlIGVuZHBvaW50IHRvIGJlIHVzZWQgd2l0aCB3aXRoIHRo
ZSByZXF1ZXN0DQoNCi0tLQ0KDQpUaGVuIHdlJ2xsIGdyYWR1YWxseSBzdGFydCBhdWRpdGluZyBh
bmQgcmVwbGFjaW5nIHVzYl9lcF9kaXNhYmxlKCkgd2l0aA0KdXNiX2VwX2Rpc2FibGVfd2l0aF9m
bHVzaCgpIHdoZXJlIG5lZWRlZC4gV2UnbGwgYWxzbyBuZWVkIHRvIHJld29yayB0aGUNCmNvbXBv
c2l0ZSBmcmFtZXdvcmsgZm9yIHNldF9hbHQoKSB0byBiZSBydW4gaW4gcHJvY2VzcyBjb250ZXh0
Lg0KDQpCUiwNClRoaW5o

