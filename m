Return-Path: <stable+bounces-195137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDE6C6C4BF
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 02:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 42EC7358B12
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F74C1CDFCA;
	Wed, 19 Nov 2025 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PKj8ARTR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IMRhxdmk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fp21pV1f"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD19D515;
	Wed, 19 Nov 2025 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516969; cv=fail; b=eGQq9YxL8m+fFi7IhlLc6uAgzA9SxcU1nx+GxwIXIC2jT6fliQGCEbRksl6KJY/ytIv1AtZ21/tunTfK0hg3PABfV8C4epvIWw1SlqnP/TeCqNK0dXD37fJMlkTqrNWk9+/muadafbOeDnTRAqSFNnpzSFq6hXYr8lcFgVoOpos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516969; c=relaxed/simple;
	bh=hn79sfpyCPXLJK8mIrQ3LkzJGY5vokbH+bnwNj3tSsE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cOpbwTY36ojjGJn4QG+4Dp+ICVdvPWx49KOwDsfIU4ML4fxKteasGSMBg0Pho7ZYAMxkXqbikPccceBRkGbxOUfssLKYOEV1G/qMWJc8b+K+TbYdyKUzaZhmE7wmEmUTiNAmxZPUDctzO1YFh+PuFULVozjI30WxP9w+MAH1hDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PKj8ARTR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IMRhxdmk; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fp21pV1f reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AIJLBLu2302486;
	Tue, 18 Nov 2025 17:49:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=hn79sfpyCPXLJK8mIrQ3LkzJGY5vokbH+bnwNj3tSsE=; b=
	PKj8ARTREku81fs+INv0395imUVNB74zQRpARkrNW97+P2B5+PXR0vZmIotMfO2t
	b32NcF3P1e4hdzFRtbPtXbvXDji7XWDiUdamAUinZVwlo0ot5Sj9qwWkfU6GIwZe
	n15sgLY9jYlIUeJnOfdBjFtrRYqqoU1RUvio2HYHZzx0NmGdf1tDb8gyEY510vDR
	9wmUFiuGl9ARAbtNcmnG/sza6J+v1dh2TX7FjnSyRAnniqc5YtwAzzvdrI5HHg1e
	iH+VIj0YS082LmH+VppQXabMXqzwKUZNFfTS5e37XqYgjqdmn/uCN+04HwACAugE
	NlTpSXptzCO+T+voaFRsVw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4agxvqh9ge-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 17:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1763516956; bh=hn79sfpyCPXLJK8mIrQ3LkzJGY5vokbH+bnwNj3tSsE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=IMRhxdmk6vUZaUScJhOmjx6aK1whiqosCOUV8GVGzF3z0t3qtDPf2NjfbrLX4NtaX
	 47/HSQpnFvUz35zl2cJKnCdU7thLTnKN7N6mYOnNYA5O1gxDZ+/arBMr/LC1uvAnmM
	 UXvQdd2HaaWSrh9m/FKwCGquqsfMdZJxYTlc03DjLBrRpZoD9K2aVRb6IBltT9i1O7
	 hyQDMnZV2OIRd0bPBy3Gx4p8Ma4jMEwWVJxBxhnnAijB+Mhoa97yw/iIur5Cdv3Bb4
	 dxLscqPDGaPA7vajOE6alr0l5QSwk0HyKKnz5nFeANLXpHMPdY9eJ78dEHbrQQJvQ8
	 bVrAex5KL25qw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3EA7F4035E;
	Wed, 19 Nov 2025 01:49:16 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E7E59A005D;
	Wed, 19 Nov 2025 01:49:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fp21pV1f;
	dkim-atps=neutral
Received: from CO1PR07CU001.outbound.protection.outlook.com (mail-co1pr07cu00106.outbound.protection.outlook.com [40.93.10.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E372040556;
	Wed, 19 Nov 2025 01:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDu1sEW6Iq4+IAXwbrs2TcO6urcRDPOnRYsyg8oQAbmzwYMMOeUZbCfua6m2yCklPY8jvj5qkdQbuYq8cACIx5g0au9RHFNhx7fePgC4pUs6FQaFXqbiDLWHD2wdaqeRVBCJLEOmK1ilUMTPFvGWjlXXloRb3oKOZvJEatCGE7/btsp4sTN1kvj7Tnrpu9o6HsPQCiBe3B84r9yXFcdKb4NiQLNCIl9l9Nz3t014dGN1AxVrV/vGHckV2m3vtDIMZ1jXqWE81bvib4xKf+f5BYcGHWYuaMMkO/oGCYWIYYpPtvO71vzukzBkhg3fN6Zem+ON4goL02PF6aUKWAkMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hn79sfpyCPXLJK8mIrQ3LkzJGY5vokbH+bnwNj3tSsE=;
 b=nvhk9fi3NcMEmqJhzMLUG+go01byeaeSHnvzYPoxtfzDAjIkSg45+i5iIFNp8TFcGbNDvy9GblMCvLztZ83wHmud0j5B2zSWcy7SLhtgGEP9jF7SxXRE92obXtgIsLAprt1uac5aHNiNnjMEP3KbffmmViRilro2LeI1ffIpeVOimcqqNrW650qfOCd90CERXfy8KC9BzKzU0Ce+PinVIBGx05JCUXMb5+1camfJFgtWu82tdXLyLgc008iYbHtOb4dFsgyRc6iUZxTJ4SRRik5VhSu/kQfQOyWfBR47tziee6v8q3sd1cpQgorMimkotUhR6sHRh3KQinDpAxiLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hn79sfpyCPXLJK8mIrQ3LkzJGY5vokbH+bnwNj3tSsE=;
 b=fp21pV1fklp5Gj7OIIsOmcyKpUvOpyLxDYMRL2+akzcTMlfYaqmu/DWFXPn6dEDt2GIOJN5x+Gd5QySAmGPRG8rFfZ46MqEo3f0CDgiJtT5C0TTSI9H+mMz38pUqdPA5fUiDXXtqiNUGQ2DHkzmfNHuIvalpx7uLWsalYhfMULI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 01:49:12 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 01:49:12 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>,
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
Thread-Index: AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAhQQCAAWgNAA==
Date: Wed, 19 Nov 2025 01:49:12 +0000
Message-ID: <20251119014858.5phpkofkveb2q2at@synopsys.com>
References:
 <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
 <20251117155920.643-1-selvarasu.g@samsung.com>
 <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
 <f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
In-Reply-To: <f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB8598:EE_
x-ms-office365-filtering-correlation-id: b182421f-3ada-47c7-718a-08de270dd6a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXNaQWdubURjVEJIeVZpWkxwWXhBZlMrV1pXMFJsVFhEWlZENmdFcDhwUnA4?=
 =?utf-8?B?alp0MkRKREZKSC9hYXFENy9pYjFwbHhwUGpTNVVKQVpMOE11OHVjQ2wrd3ZC?=
 =?utf-8?B?VUV1SVY5aVhaVkZ0cDhvN1o4M3NCdmkra0hUcDBiak1lcmhLNGlQQTY1am8z?=
 =?utf-8?B?NHBXWWtkZk9RR3JpWVhaZmw2TzBpa01YT1VsakkxUjVDdVc0cGtVQzRJUTh4?=
 =?utf-8?B?eTBwTDZQRURnQjNrQWY1ZldiMUhHMGZZaVZsTUs1UDVTd2lVaW5FcGNNZkJu?=
 =?utf-8?B?cE41U3BzSDZDdW5GWSt5aERMVHFEcHJ0c0lDR081dy9oRjJZVkhON0ZpTFM3?=
 =?utf-8?B?WVVkQXE1RFplUzhSVjJhQlVPaDJoMFZIc2lKOGZ2bE5wUG5ydVJ2bytXc0pC?=
 =?utf-8?B?ME1qVmUvYWZSb0sycGlHL0dMV1cwbjhxV1hITnp1anI0NHZBakQzVmpMYlBu?=
 =?utf-8?B?TE1VZDVxc2VNcmdHRU9JejYzQklxakI1UXZJT0hTMXFNZ25GVHZVc3RKUHND?=
 =?utf-8?B?clQyTmpJUCsrM3BjUFhadEwxbHJLbVVhMGgvQVZaZTdHQlRIT0RUT2RONHZa?=
 =?utf-8?B?U1FSeUdNczltdThSbkwrbDlWdGY1QzRXT1p3em9KbnZZN29tV3JYUVlmSThO?=
 =?utf-8?B?RytBWk41UEdMUFh3NzgySUVodDJKb3RjL0hOdjlENFRYZ0JINVpDbDFxb3ZS?=
 =?utf-8?B?S1lwNzNyM09ETFFWaGh2M2Q0b0EycngvMG5LUDJjZGtsaUU3aFZPTmFCZlQy?=
 =?utf-8?B?UmcydmFYL284a1lwSlJzSnZoTGxrclZ3Q2FzanVySnJTamxJNHk2dTNmMkpE?=
 =?utf-8?B?NmhvbWFPRFVQOGY2b1JQM09XU2tHWjVQb29OTGZlaUJpOTN5SjVHUEdyTWwy?=
 =?utf-8?B?b1lTUk5XUTl4RHo5Nm44TUsxL2JZQVgrWFU1YnpuUkRoL1hPRVlWRmVCQ1ht?=
 =?utf-8?B?M3dTMVlFOHB2QTJ4cjl2YWlESHVrSVVaUFJCUXZvV1BGZ25zd1VFa2JUdk1M?=
 =?utf-8?B?ZmxQSjFaVmRqcUtWMWkvN1IwQjkvb00vcXBYZ3M1OVI0RExQWGxWdmdBS3p1?=
 =?utf-8?B?bnl3cDlLRFVOZ0N1dUFoc080bmI0c1J0aDlkL0FPdFU1N1ZvLzcyeTNaTjZr?=
 =?utf-8?B?T1FsZXZIY2NmZjE1RWV4b0pSeTk5c0JZcURLTitIajUzS3dHWmEvdXRlbVVh?=
 =?utf-8?B?aThsYmIveWdtV1FuUEdjNlV4UU9WVkgzUFFkMGJHNEpMdkUrV3pPbG1Rdm5K?=
 =?utf-8?B?RlM1N25ZV0c0QkV4SjJ2V01MMHlmQVlTTW5VeTJlaFpNUWhYdkc3V283dksv?=
 =?utf-8?B?bTFqelFVc0VpUHFzc0dWa0J3S3BGa2JrYlprbUlRTkZhSXh2K2VpU1RFT0d5?=
 =?utf-8?B?eXErcmg1R0NvOHFXVFB2aElXcG16ZHZFWElrcDhsSlVmTml4amgrSTZpQXFj?=
 =?utf-8?B?Wlpjd3F2Yll3bDNXTTNteExtYW8zdEo5N1cwS0VJQSsyY3VjZEJPTTlLcitY?=
 =?utf-8?B?eis0WlRLT1B2ekRxN0JqU2kvZmEveFR4WDI3dXVTYXNncHBNd25ya0VBWlRS?=
 =?utf-8?B?TE03Q29TekVmQjhFRnIvMU81VjR5THcxQlhqZ2VMWDRnS1A0SGt6RU1uT3dG?=
 =?utf-8?B?MTZRQ0JNZWUvREhrQzYvQkZkYS90MXNpV1dweUttK3NlQTVCKy9WaW5CQkN5?=
 =?utf-8?B?a2JISk1LaDNWVU00aFlQR21GUEhSa0wrRWk0dW1FYXVDQzRMK3JxYStMNzZw?=
 =?utf-8?B?Kzdxb0hBbnJJdHhVV3ZiQ05zNnpEazRTbUZzTnJmTjJEVVpQUzdrWjk0K3ZE?=
 =?utf-8?B?ZUErQUl6VTAvTUlWSlFTYnVtL1pLdHRSa253ckNQd016YjZZa2dOemRFOEVv?=
 =?utf-8?B?SkJ4RjBqL1VLSmM0ck1xSzVaNkk3ZjJsMWFTM3QxQVpwOWptUTlueXhhNDVG?=
 =?utf-8?B?OHlZMy9kYTk1Vm1Ua0c2eWdJZkI2WlU1L3F1VGx4Ly95UGYzVDNxbzhHVnJT?=
 =?utf-8?B?N3lXZmc2RjNTTHYxc0ZaWmVFMUREdnlicVZSRzgzWlpFTnR3ZHNSaGhXallO?=
 =?utf-8?Q?kD0ICS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHpacWE1eFJaU0tVVmoxeVRXSXF1L2xTUXNoVE1udnFxTHBVY1o2VStIUFpT?=
 =?utf-8?B?QW5ySGs4bmUvNHlod2Y3ZjlMSCt4QzdmQkw3bjJTYTFaSFdOU2I4Q1h5N2t4?=
 =?utf-8?B?eHE1WmJFOU91c2FkSUtlK3VVTlZOY1lXcDRQZXZjTWVDQlN0Y280WnJ5OUhV?=
 =?utf-8?B?dWV4WlpDeXpDQ1F4S2tNMldaWFNPVG1xTzRlQjBsRE42UUtyV21YSTZRT1FN?=
 =?utf-8?B?YzRCbHJvMTZPYVdkcFlDVGV5NUZMb1BzbnJCQ1lHWnpGT0hRVGZhYzFkb1NL?=
 =?utf-8?B?ZUJ6ZWlPSkZUdWxrbXhCNTN3RnpMSUNpL0JOWnRvdjhvU3RCOGhsVTFBYTgw?=
 =?utf-8?B?em8zNTNoRTM5d256NzdqTTYyZjJLY1JDRHVDQjM2Z0V4dUxEeldZbUVMeGln?=
 =?utf-8?B?a041cDRXamtiaXdRQkc1R2gwZHVzTnE1ZXVLMWZqejh6UkFBeEFyTjlSZTdV?=
 =?utf-8?B?S3A5S0NTT0MyUzVEenNsRmw1T0VVQnh2VURoL1BsWnIwQUV4d3ZNMDA2SWs0?=
 =?utf-8?B?RDcvMjhGWjVXNlJUTUJzbVhBRmI1eDd2cW1ZUmhmRytURWErdlVRbEJTS1pX?=
 =?utf-8?B?ZDlRWVJJaC9QNENhWGxtU0ltSXdEc2djY2h5NUthcHZqRmtRWW9CU0ZUeldj?=
 =?utf-8?B?T0ljMUNRNDlYT1hVNTNUMnZTdFNzUm5KYkZhcS9NeDc4S1kyZ3g2OUtMYXZr?=
 =?utf-8?B?M0hrZXhQVDJWcjNxWDhlMXNiTEhDbmNlMkFyZjdEc1BPT1hUSE53b3JlU01w?=
 =?utf-8?B?OStFakRHdUgrdGNNLzV3MUM1Ymh5eUl2LzZ0N1ZOa3R6QzVyNlpjamxGRXQ2?=
 =?utf-8?B?blB3bEtCcXhmcmpvVFpOblU4czZtZzJEa0oyZkZCWG9MSjBtbksyQ0c5Q3V6?=
 =?utf-8?B?WTBrVkpaeHBnYm5kS2ZZcHFKM1NHZjJrMDBhWStvQ2tnRTNRcVBsNzYwUm8y?=
 =?utf-8?B?Y1JFRURxQjE1MFNrcUpmS0lpZWNLK05KTVE0ZnREUnlzdUhrWUxHSzYrbE1x?=
 =?utf-8?B?cEFBOG42MGdueWFIRW5oWWZpdVJtK2VWRi83OGc2QnloWSt3bzRuWGJqakNn?=
 =?utf-8?B?QlZhMmhqYmZFZUNmTDM3MlRDMVVtU3l0M0VJNnlXY25JQ21sang3NlpGZVhq?=
 =?utf-8?B?QVpMak9wZytsV1JHQjRaaDdxZ3phL2wycWt3S0oyOGoxWEdjbyt3VFRWaUxW?=
 =?utf-8?B?eXVTMkZ3QjF5SUhGYS9RaFl4cVhxNVVyUFVZVEVEYTBoMWx3TCt5K3BsTE1E?=
 =?utf-8?B?OUUxSGo3V3lib0RhdHd4ZTZqMXlHSzJlVHJ1ZDd3Zm1lUHBOUzlFQ3hxbkF6?=
 =?utf-8?B?eDcxNGtWZW9nVHB3aXMvSi9hOEZOQ0dFTVphSTBjcloza2tIUWV1UUROaURE?=
 =?utf-8?B?K0ZWakxJbVA0L01SdlQ3WmZhRmdQL3VQQXoyMnNXRWdudEk4U1hkQXRJMFhh?=
 =?utf-8?B?bW9Kazlra3Y5M2lvWGpuVWhTNURUZ21BMFFseTd2N2gvc2NvTERIekNZUVlz?=
 =?utf-8?B?SUNyZWZIaExDaHFzRm1rUytPVzBXMHJQWUs2eWwwalU4azB1Y0RXZkZmY0lk?=
 =?utf-8?B?SmZFZG44dUN6c213YzhaNUQ4Rmo4c0hEM1RPZWE0WnE3c2tQSlp5c1Uzblpo?=
 =?utf-8?B?d2IyUFdyMWsxMklpenU5amI0bXJuNkJSWndTazFtWDgyWU1oUU84VDZkSThs?=
 =?utf-8?B?VytER1dpS0Fob3hBYVptWEF1RXlOMmVMZlJvSGpqZE9TN2hoQzI0NkNlSlJ5?=
 =?utf-8?B?bkpQYk4yUXJseFQya1BMTldTT2pOdlhLMVloWkFlMlN2OHZYQlFXVFB2RlAr?=
 =?utf-8?B?NmJCSE5sMllZS0t2Qkh6U0FTOUs1Tml2bVdVZDRXK2pxRTdMTGdhTjlkTWds?=
 =?utf-8?B?YnJ5ZGVRdkhKVHBVL0pSckwxWTgzcVZNY2EwQUs2b003MnVoL2dCaGx5Y3VG?=
 =?utf-8?B?eWpGMS8yanVrTWtxVTd0WFZESmVVRnplVUtNbzF3ZlpJZE9YWnFIZVhOSVVz?=
 =?utf-8?B?Q1lGSWFMenRabjk3MDd5cjRTZDNscmFmNHhFS3Z1aVlDdjVOSHJOa3habHNk?=
 =?utf-8?B?WVpuUEkyRkkwTStBSjB6Y0ZsMytoTGRIZGFqaEpGcEFRbU8wbzgyUk1xcTc1?=
 =?utf-8?Q?bQN7TiLivTk8ba2yHDdCjetVc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB41B718F2555F469573860B721A78D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uF+mnBD0Lq9TTLrw0WQCXsWZ0eXixDGz6eGtO4rRTu+zVPqAoH5npk3Pp2j+uIs/CGfTi+hfyvXjvE9GLarJCSsyvVE1fEWeyn9giaaCCksKwG+hHfpphuNTHDsI9idOOFTeMNeIEMJwNGyMwkMW6RSDgAK1MYC1Tt0na9k+H3VjY9V/RzPLlsQyKuZlCUHtp19yVVDl1D9/rMXgJKLmFLsBOh1POTAy0/tsQUkZ+ZAIbUJdaFYCgsK8hDF1FF6MfhJHwsFmyIyRaywkQ+jjByTbdUJRD3ehdzih+pauS3CN2VFayYAV3E37wWMI7dhhjk2IJHttBbllahMzMQr9YeEtPb477oqIVXJURfw5nGZ22K3oLExT4PPn/1tUsHNI+tiSVm5+n/FA6qYpIHE/i+S8Duxw/rRipGvrgR+1S1/KPx24CIKrEvx7Wc0vDdQrfD/cQOtV5WkCyvNoEKE6Q39xYuCO2d5NPlLgXgJCYNBZPtVDnKZKNjc7wSIKZjo90ZBKibdKwUmIbeGe0GyGjIxIDAv7BqBephSVlg2FthnwW6JA2V0NSgrVy1MwM0+JxzMCF2OpGw+ghKsY50waB/4hzYdaIkph5BgNdSOnge81NcqO5zvEKI990y9b+btv/o3cVMrNUdWsBRoCGiqWEA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b182421f-3ada-47c7-718a-08de270dd6a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 01:49:12.2512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dv3C//Gd2IrHXBmLMhmDPfgyvnTDupmyWowqnmZ48akYzWK2SZPM4e+P8X52Epq9NyZdlEE0RTBTND9+WKHoCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDAxMiBTYWx0ZWRfX0nNmUSxM4w6L
 EQ5RMd8d6n3CIquxGXdUwzcQsMLRC+ZtjPoOrAp5LGPZoyIKb4VSeoojE+z+sS23A+32GzgrMG2
 JCDJJNecpa07QM8tVunIaBD8Viond5YXtz09FHvXd8RuD1NGQwSteStRpzDLEihGaNe0jgzR/4U
 fsdlNaJ3qal1n+RrWoSHOaj5LjRLFwUd+FdulzUSxnkg7f/xLlp0SQtSGpprJM3Ebnkmv2qM9wm
 uaM32l8T4foGdEU9/BFt/z7q45e+Ave8qvrxXFfYGnE4xVkX2nDt5H8djJoDpnbtvwv73ZPB0X4
 sl73YNsC4lIOZiZXPT0YgGz+EZHxHnYAflz5aIeLk43MwP6aBCOL88oo82WYf7cmbaw5KHqKKDg
 FnoBMWZSnfylxYWL64FmZW2u7/pHsA==
X-Proofpoint-GUID: -ejBjNnaqUz8vYV_WI4xCGS1Y9NA9ZgP
X-Authority-Analysis: v=2.4 cv=XZeEDY55 c=1 sm=1 tr=0 ts=691d221c cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VURjxpRSEUvEhA-Rl88A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -ejBjNnaqUz8vYV_WI4xCGS1Y9NA9ZgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 priorityscore=1501 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511190012

T24gTW9uLCBOb3YgMTcsIDIwMjUsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDE4
LCAyMDI1IGF0IDAyOjIxOjE3QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBUaGFu
a3MgZm9yIHRoZSBjYXRjaC4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGUgImVwX2Rpc2FibGUiIHBy
b2Nlc3MNCj4gPiBzaG91bGQgYmUgY29tcGxldGVkIGFmdGVyIHVzYl9lcF9kaXNhYmxlIGlzIGNv
bXBsZXRlZC4gQnV0IGN1cnJlbnRseSBpdA0KPiA+IG1heSBiZSBhbiBhc3luYyBjYWxsLg0KPiA+
IA0KPiA+IFRoaXMgYnJpbmdzIHVwIHNvbWUgY29uZmxpY3Rpbmcgd29yZGluZyBvZiB0aGUgZ2Fk
Z2V0IEFQSSByZWdhcmRpbmcNCj4gPiB1c2JfZXBfZGlzYWJsZS4gSGVyZSdzIHRoZSBkb2MgcmVn
YXJkaW5nIHVzYl9lcF9kaXNhYmxlOg0KPiA+IA0KPiA+IAkvKioNCj4gPiAJICogdXNiX2VwX2Rp
c2FibGUgLSBlbmRwb2ludCBpcyBubyBsb25nZXIgdXNhYmxlDQo+ID4gCSAqIEBlcDp0aGUgZW5k
cG9pbnQgYmVpbmcgdW5jb25maWd1cmVkLiAgbWF5IG5vdCBiZSB0aGUgZW5kcG9pbnQgbmFtZWQg
ImVwMCIuDQo+ID4gCSAqDQo+ID4gCSAqIG5vIG90aGVyIHRhc2sgbWF5IGJlIHVzaW5nIHRoaXMg
ZW5kcG9pbnQgd2hlbiB0aGlzIGlzIGNhbGxlZC4NCj4gPiAJICogYW55IHBlbmRpbmcgYW5kIHVu
Y29tcGxldGVkIHJlcXVlc3RzIHdpbGwgY29tcGxldGUgd2l0aCBzdGF0dXMNCj4gPiAJICogaW5k
aWNhdGluZyBkaXNjb25uZWN0ICgtRVNIVVRET1dOKSBiZWZvcmUgdGhpcyBjYWxsIHJldHVybnMu
DQo+ID4gCSAqIGdhZGdldCBkcml2ZXJzIG11c3QgY2FsbCB1c2JfZXBfZW5hYmxlKCkgYWdhaW4g
YmVmb3JlIHF1ZXVlaW5nDQo+ID4gCSAqIHJlcXVlc3RzIHRvIHRoZSBlbmRwb2ludC4NCj4gPiAJ
ICoNCj4gPiAJICogVGhpcyByb3V0aW5lIG1heSBiZSBjYWxsZWQgaW4gYW4gYXRvbWljIChpbnRl
cnJ1cHQpIGNvbnRleHQuDQo+ID4gCSAqDQo+ID4gCSAqIHJldHVybnMgemVybywgb3IgYSBuZWdh
dGl2ZSBlcnJvciBjb2RlLg0KPiA+IAkgKi8NCj4gPiANCj4gPiBJdCBleHBlY3RzIGFsbCByZXF1
ZXN0cyB0byBiZSBjb21wbGV0ZWQgYW5kIGdpdmVuIGJhY2sgb24gY29tcGxldGlvbi4gSXQNCj4g
PiBhbHNvIG5vdGVzIHRoYXQgdGhpcyBjYW4gYWxzbyBiZSBjYWxsZWQgaW4gaW50ZXJydXB0IGNv
bnRleHQuIEN1cnJlbnRseSwNCj4gPiB0aGVyZSdzIGEgc2NlbmFyaW8gd2hlcmUgZHdjMyBtYXkg
bm90IHdhbnQgdG8gZ2l2ZSBiYWNrIHRoZSByZXF1ZXN0cw0KPiA+IHJpZ2h0IGF3YXkgKGllLiBE
V0MzX0VQX0RFTEFZX1NUT1ApLiBUbyBmaXggdGhhdCBpbiBkd2MzLCBpdCB3b3VsZCBuZWVkDQo+
ID4gdG8gIndhaXQiIGZvciB0aGUgcmlnaHQgY29uZGl0aW9uLiBCdXQgd2FpdGluZyBkb2VzIG5v
dCBtYWtlIHNlbnNlIGluDQo+ID4gaW50ZXJydXB0IGNvbnRleHQuIChXZSBjb3VsZCBidXN5LXBv
bGwgdG8gc2F0aXNmeSB0aGUgaW50ZXJydXB0IGNvbnRleHQsDQo+ID4gYnV0IHRoYXQgZG9lc24n
dCBzb3VuZCByaWdodCBlaXRoZXIpDQo+ID4gDQo+ID4gVGhpcyB3YXMgdXBkYXRlZCBmcm9tIHBy
b2Nlc3MgY29udGV4dCBvbmx5IHRvIG1heSBiZSBjYWxsZWQgaW4gaW50ZXJydXB0DQo+ID4gY29u
dGV4dDoNCj4gPiANCj4gPiBiMGQ1ZDJhNzE2NDEgKCJ1c2I6IGdhZGdldDogdWRjOiBjb3JlOiBS
ZXZpc2UgY29tbWVudHMgZm9yIFVTQiBlcCBlbmFibGUvZGlzYWJsZSIpDQo+ID4gDQo+ID4gDQo+
ID4gSGkgQWxhbiwNCj4gPiANCj4gPiBDYW4geW91IGhlbHAgZ2l2ZSB5b3VyIG9waW5pb24gb24g
dGhpcz8NCj4gDQo+IFdlbGwsIEkgdGhpbmsgdGhlIGNoYW5nZSB0byB0aGUgQVBJIHdhcyBtYWRl
IGJlY2F1c2UgZHJpdmVycyBfd2VyZV8gDQo+IGNhbGxpbmcgdGhlc2Ugcm91dGluZXMgaW4gaW50
ZXJydXB0IGNvbnRleHQuICBUaGF0J3Mgd2hhdCB0aGUgY29tbWl0J3MgDQo+IGRlc2NyaXB0aW9u
IHNheXMsIGFueXdheS4NCj4gDQo+IE9uZSB3YXkgb3V0IG9mIHRoZSBwcm9ibGVtIHdvdWxkIGJl
IHRvIGNoYW5nZSB0aGUga2VybmVsZG9jIGZvciANCj4gdXNiX2VwX2Rpc2FibGUoKS4gIEluc3Rl
YWQgb2Ygc2F5aW5nIHRoYXQgcGVuZGluZyByZXF1ZXN0cyB3aWxsIGNvbXBsZXRlIA0KPiBiZWZv
cmUgdGhlIGFsbCByZXR1cm5zLCBzYXkgdGhhdCB0aGUgdGhlIHJlcXVlc3RzIHdpbGwgYmUgbWFy
a2VkIGZvciANCj4gY2FuY2VsbGF0aW9uICh3aXRoIC1FU0hVVERPV04pIGJlZm9yZSB0aGUgY2Fs
bCByZXR1cm5zLCBidXQgdGhlIGFjdHVhbCANCj4gY29tcGxldGlvbnMgbWlnaHQgaGFwcGVuIGFz
eW5jaHJvbm91c2x5IGxhdGVyIG9uLg0KDQpUaGUgYnVyZGVuIG9mIHN5bmNocm9uaXphdGlvbiB3
b3VsZCBiZSBzaGlmdGVkIHRvIHRoZSBnYWRnZXQgZHJpdmVycy4NClRoZSBwcm9ibGVtIHdpdGgg
dGhpcyBpcyB0aGF0IGdhZGdldCBkcml2ZXJzIG1heSBtb2RpZnkgdGhlIHJlcXVlc3RzDQphZnRl
ciB1c2JfZXBfZGlzYWJsZSgpIHdoZW4gaXQgc2hvdWxkIG5vdCAoZS5nLiB0aGUgY29udHJvbGxl
ciBtYXkgc3RpbGwNCmJlIHByb2Nlc3NpbmcgdGhlIGJ1ZmZlcikuIEFsc28sIGdhZGdldCBkcml2
ZXJzIHNob3VsZG4ndCBjYWxsDQp1c2JfZXBfZW5hYmxlZCgpIHVudGlsIHRoZSByZXF1ZXN0cyBh
cmUgcmV0dXJuZWQuDQoNCj4gDQo+IFRoZSBkaWZmaWN1bHR5IGNvbWVzIHdoZW4gYSBnYWRnZXQg
ZHJpdmVyIGhhcyB0byBoYW5kbGUgYSBTZXQtSW50ZXJmYWNlIA0KPiByZXF1ZXN0LCBvciBTZXQt
Q29uZmlnIGZvciB0aGUgc2FtZSBjb25maWd1cmF0aW9uLiAgVGhlIGVuZHBvaW50cyBmb3IgDQo+
IHRoZSBvbGQgYWx0c2V0dGluZy9jb25maWcgaGF2ZSB0byBiZSBkaXNhYmxlZCBhbmQgdGhlbiB0
aGUgZW5kcG9pbnRzIGZvciANCj4gdGhlIG5ldyBhbHRzZXR0aW5nL2NvbmZpZyBoYXZlIHRvIGJl
IGVuYWJsZWQsIGFsbCB3aGlsZSBtYW5hZ2luZyBhbnkgDQoNClJpZ2h0Lg0KDQo+IHBlbmRpbmcg
cmVxdWVzdHMuICBJIGRvbid0IGtub3cgaG93IHZhcmlvdXMgZnVuY3Rpb24gZHJpdmVycyBoYW5k
bGUgDQo+IHRoaXMsIGp1c3QgdGhhdCBmX21hc3Nfc3RvcmFnZSBpcyB2ZXJ5IGNhcmVmdWwgYWJv
dXQgdGFraW5nIGNhcmUgb2YgDQo+IGV2ZXJ5dGhpbmcgaW4gYSBzZXBhcmF0ZSBrZXJuZWwgdGhy
ZWFkIHRoYXQgZXhwbGljaXRseSBkZXF1ZXVlcyB0aGUgDQo+IHBlbmRpbmcgcmVxdWVzdHMgYW5k
IGZsdXNoZXMgdGhlIGVuZHBvaW50cy4gIEluIGZhY3QsIHRoaXMgc2NlbmFyaW8gd2FzIA0KPiB0
aGUgd2hvbGUgcmVhc29uIGZvciBpbnZlbnRpbmcgdGhlIERFTEFZRURfU1RBVFVTIG1lY2hhbmlz
bSwgYmVjYXVzZSBpdCANCj4gd2FzIGltcG9zc2libGUgdG8gZG8gYWxsIHRoZSBuZWNlc3Nhcnkg
d29yayB3aXRoaW4gdGhlIGNhbGxiYWNrIHJvdXRpbmUgDQo+IGZvciBhIGNvbnRyb2wtcmVxdWVz
dCBpbnRlcnJ1cHQgaGFuZGxlci4NCj4gDQoNCklmIHdlIHdhbnQgdG8ga2VlcCB1c2JfZXBfZGlz
YWJsZSBpbiBpbnRlcnJ1cHQgY29udGV4dCwgc2hvdWxkIHdlIHJldmlzZQ0KdGhlIHdvcmRpbmcg
c3VjaCB0aGF0IGdhZGdldCBkcml2ZXJzIG11c3QgZW5zdXJlIHBlbmRpbmcgcmVxdWVzdHMgYXJl
DQpkZXF1ZXVlZCBiZWZvcmUgY2FsbGluZyB1c2JfZXBfZGlzYWJsZSgpPyBUaGF0IHJlcXVlc3Rz
IGFyZSBleHBlY3RlZCB0bw0KYmUgZ2l2ZW4gYmFjayBiZWZvcmUgdXNiX2VwX2Rpc2FibGUoKS4N
Cg0KT3IgcGVyaGFwcyByZXZlcnQgdGhlIGNvbW1pdCBhYm92ZSAoY29tbWl0IGIwZDVkMmE3MTY0
MSksIGZpeCB0aGUgZHdjMw0KZHJpdmVyIGZvciB0aGF0LCBhbmQgZ2FkZ2V0IGRyaXZlcnMgbmVl
ZCB0byBmb2xsb3cgdGhlIG9yaWdpbmFsDQpyZXF1aXJlbWVudC4NCg0KQlIsDQpUaGluaA==

