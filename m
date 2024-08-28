Return-Path: <stable+bounces-71451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F6196364C
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 01:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CC12813F9
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 23:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B121AE055;
	Wed, 28 Aug 2024 23:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ibgIEJ10";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TYnDm5lS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Uqo2on+4"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAB81AE03A;
	Wed, 28 Aug 2024 23:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888520; cv=fail; b=tcAqmt8S6WU5xjrtdndf12SB/kLB4kcmQdBrq7fRI3L8DmCTHQLDycpS3a/OYDxEPmBXy2hiPAocQFI9sq7W6B7LQCPWiMdHwGVEc1r4+MmVrjdh7d9+rWCRPcTAYYbusVJiTBWgoyX3VP+O4OZeA4TlLQ1nkfzjlhrhCFEyAOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888520; c=relaxed/simple;
	bh=qRNoc+g8MGqkxmXPhwm2Bqmzez763PMj4mXKFUJ1I5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GI2AAJAykWbDpTvIwV/oRRmee3WXMB7RkimYa4lZcc9BY+J7lM0fr0gDkTy67NZwWKvekuu7UnRx84+uI9J54Z8KWyPhVg8vdoqj/zLBl6HKM28NAOGXOYoO6ro9Df0t3qZ7HW1J0OpOvytz8lLwGL9wv94dsB6OxSp/nIfcmPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ibgIEJ10; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TYnDm5lS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Uqo2on+4 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJ5kR5031494;
	Wed, 28 Aug 2024 16:41:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=qRNoc+g8MGqkxmXPhwm2Bqmzez763PMj4mXKFUJ1I5I=; b=
	ibgIEJ10xssMqUCvxWgXOP5PoL3Y0VoZP0oEh1+fGotIXdj7BIH5xS2JUIxUenug
	banjVCAda2dhcUarO5kPsJXClTFqixyrUQ5hJqgoUiQTJOgYs0gC9KSZOEQPckbv
	5SWbZIa3sQMZD/UswvO9K7SWcvNRv4161VUjj1DxEcRMk/XgkMyo89xSJN9VXneW
	EJQeXPM032AXX5ERahirByo2yCgC1hynw94F1Irm4ZWln4NenM6PyB8dNzaxTgAO
	OrFlmvtXfSlbM2V1eoNIZqhoVEtW8/Grizz55B8PPtdR4hkhBxx2rWrfOtmzNlc/
	VuTOQg7U1AWz7UndLgaIng==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 419py4pr14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724888513; bh=qRNoc+g8MGqkxmXPhwm2Bqmzez763PMj4mXKFUJ1I5I=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TYnDm5lSjF/iX03dOGTq2QxJqCGOZfBXbUCwfPbTDxI39zJ//F/6E+FazYSmPYqIr
	 +xRftyQFF5+3gXEXgQa6xzZ4IfyIc7QhbxcWuzRqXYCrGjucgv0vt/8/w0QRquc7Aa
	 16pXE4YPZUMpVx/iFJsv33Bqn3P4fA35sylQW4Uc7Nja0rk6TQtSJAx6Uc34NGu8Zv
	 mOEjuQdYNrWFrAW4WEYKIUW2oQwSBnpS7Q9xlHRXkvWuDrLF/2U3kQBl/hb72h5BF9
	 y2CLHYlIsccJrlUh+A1Dp5xsIuL/2rRkz8vZSc5041LH2/Pxv4Nwd5Og6/hGKcWCdb
	 WXb1csIUEk76Q==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A9A2940136;
	Wed, 28 Aug 2024 23:41:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 30015A009D;
	Wed, 28 Aug 2024 23:41:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Uqo2on+4;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 509CC40147;
	Wed, 28 Aug 2024 23:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJEwUY4pNZz+LnRNxLTM4ZMA745ihrP0XhrgLifPWvCh5cpO8CdZDer3Al++v1ISDRnzrVt4s7+f9kD2NWw30cAfCs5CB0anK/iTzaV8dNyEctpluL7kKSaYr2LLRqRKIYtJfshKTYUMBIncDgVtsbddKiupVd0Hi9FqwhJTewnVZftcxhPftyCD0ALITREPWrXoaSE3UStm4iwPqxc1RZARrKDZdYy5svII4hS5/fibaglGzveTXP+1PV8UvDn659yw9NQodiV4n+V4SXBowj47OhrqU8Cw14KcJCicSD5N8I0GWChIgj+UpBJMBHCDQtHbw6wM6yNz85v2i00Gtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRNoc+g8MGqkxmXPhwm2Bqmzez763PMj4mXKFUJ1I5I=;
 b=eJ3Z8l+4GQtip2+NiFPIG+gs2kM69wHFfPCWZbu4vBSgCRbn3x9e9P1fd6FCjxCHzFrfvP+Xt78RdfYl+rr1AekIlSW0VRXgb/lnhB6h/625xOn7x+mcqAC5va7HtFbvtgftOmBz4GxLKYzNlAXWBuRqjEcWPC0EkJj38TuskbcX0PvwnDayJLQCwwLftYSxoZGhJupugR/ZS1vL/hLhVdr2ex3BgZVG1vG89W8NxTfWiFnp361iOgckYRa9/COM03rJJmT7sxy9NRpGboTggnEKqMgzM6GVA87jSYgdEKYlT3FaMLEWk9CemhHwnZW2TdUEkU6WT88PmrT3pKr9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRNoc+g8MGqkxmXPhwm2Bqmzez763PMj4mXKFUJ1I5I=;
 b=Uqo2on+4cF2XlENfy238cmE7zchHfGXdZrlr9/dJUVuSGM5n0ksK3OGZPiC+mJ7ioDEPysJYw/ThSZ70YX5jRF4xnxEYcvshBEl5pfhuHbn0QZGG0e3Fo8J8Au4KDH6kYCrVS3lKmEtiZb8RtVTEEQwaW8ep15mSXBTB4AP2dQs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH0PR12MB8486.namprd12.prod.outlook.com (2603:10b6:610:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Wed, 28 Aug
 2024 23:41:49 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 23:41:48 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v5] usb: dwc3: Avoid waking up gadget during startxfer
Thread-Topic: [PATCH v5] usb: dwc3: Avoid waking up gadget during startxfer
Thread-Index: AQHa+RWVCsn/uoe/akKokBJ1uUqGRbI9VXsA
Date: Wed, 28 Aug 2024 23:41:48 +0000
Message-ID: <20240828234138.xi4mqowmltmyxc42@synopsys.com>
References: <20240828064302.3796315-1-quic_prashk@quicinc.com>
In-Reply-To: <20240828064302.3796315-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH0PR12MB8486:EE_
x-ms-office365-filtering-correlation-id: 383e3349-bde8-4d22-7da5-08dcc7bafbdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2k3cHlxbVBsditvQkVTNVR4SW9VWHdGMmJweXlzci94eCtZdExlWHlIMlMr?=
 =?utf-8?B?bFpzTkh4dFFocHdFSkRpQlcwelpxTk5JU0IxeEJJdHFrN1hwNUFISDFQenYr?=
 =?utf-8?B?U3hWVEtNQUtROGQ5bDFyL2JjUTFMS3JDcDRmVmhkeXErQjJMKzFRbUdBSjdv?=
 =?utf-8?B?TmkweUpIV3VkRVBvYjhORkUyazNXcndGRUdlcnN3amlWT1cyaWVnamgxUFR0?=
 =?utf-8?B?UVY0MUpXS2hxMG1QTUpFVHlVbldidXc0cFYvVVNzeVgwdDI0bTBSVVRiUG9J?=
 =?utf-8?B?QlBVNFM0NXgzaHJxSEFzVlZoOXJNckdJaFYyd1BWT0ZHZnRKT1NlK3pYby9o?=
 =?utf-8?B?NFRIeXJWcklIVHlRUXkwRTFXTEVjLyt1c3FKOGxTOU9wMDkwTGVVeG5ybExw?=
 =?utf-8?B?bzZ3NzJEbUhma1BkbWJraXU4ZGVHOGhWdU9VemRlRlRGRm5iMmJzTXpRNTFG?=
 =?utf-8?B?dGJzenNWYjBQZkRraTNPd0FKNzFWNXhwVm1kbjdCSFBCVHJFZzNhWXoyZXMy?=
 =?utf-8?B?YUl1aUwvYjAzTWZJNDVYWGFUQ1F4eTRVamMyRWpXbjdRNVNzZHhsbVVUSEdr?=
 =?utf-8?B?TVFGREJGeCtEVy9JWTYwVWFqelQ0TjdwTE5pYmw3QmQzTUlSYmJhZ1J0ZzlD?=
 =?utf-8?B?Y1VTcGJ3NmtUaXRNa0JOTDRGQThEcldqMjA3Q1Njc2VtUHVnSWd0enp3WVNJ?=
 =?utf-8?B?UmsvZjBFcjE0aWJ2Tm5hOTJVZllJV1J1MUdndHBUSnJnUmlLSi90TVJ1Y1RD?=
 =?utf-8?B?NUllZkJ5MllTU2JZbUVHYysvcmdvbmk0ZFV6b1ZRRXd4QldQbkpXanRGQzRn?=
 =?utf-8?B?NGd3NXNublI3Y2NDRHZPOUpjalcxeG9RRWNabEhKZUJpVlRGMW4vOWZycndB?=
 =?utf-8?B?S1NNZnl1dTdhZ3JRMUJ5WU9GTVQveHNaR3pKVWFPckdJTVgrbWRMY0ZhODli?=
 =?utf-8?B?d01jTWpBSFBiT2ZrR2JuT3puM0dWZ2dlZmVvUHg5V2ZYVXRldDgyaE9qZ2l1?=
 =?utf-8?B?RU83ZDBrOVUrZllVRG5NdGQ2R1JrV1JyeWhWdTFGcGdsNXpSVitQcy9abTlD?=
 =?utf-8?B?WGV3RDJNSXFtWGxoVDMvVmFTQXNyYmI1b09qRk5TMzFjUWNmaFNIY3hzTVIy?=
 =?utf-8?B?NmVhcmdXa0NTWFprRkdVeVhHTEhQbStOWlpYeENuTnZYNTJCNjYyb0ZGQW1Q?=
 =?utf-8?B?TDFpYXlFWjd2eWpYdTlDOXlablJkZXZNc1QxOXUySmNGTEd1c2QrU2RyZnRL?=
 =?utf-8?B?T2NRMnEwYms0bkd4MDJvOEVzTndzcGlYcG50ZTN0b3hTZHNmMFBMSXYwTjZP?=
 =?utf-8?B?dEZiN3dUMnFCemNWTkxNSmYrNnAyV1FjL3IvK1lPQXViUWgrWG12SjRic0ll?=
 =?utf-8?B?TkZSKzdXT2JWVExZMXBHQzUyQlMzbVBENy9rVGVFQ0RVdHg4dWE5QXd6RVpV?=
 =?utf-8?B?ek85cWNNZ0NEd3UxcEF6NGhUNWVnNWtVQ2JPbWVGMG9qbXg1NkhaVHU3dU1N?=
 =?utf-8?B?TVVaVnhSa0ZaQzBhOHpleTNnVkhYZm80OU1jSlVCS1lXZFN0RStoQS80aS9V?=
 =?utf-8?B?bFFIQXJjREozRlN5Ymtxb3EwSE9pZ0F2Wnh4dGJ1YUc4MWhrL1hKVnNvUnFC?=
 =?utf-8?B?Ukh5Mll1Q0RlNThYUm11enl1NFdXdyswT0Z4bXNFL2Z2VFVDS1E2Y1NWbkl4?=
 =?utf-8?B?OGlPK29uQUx0K3BNdEY1OVEyUTBwQWdMdTZsa0E5b2RFU1J0TnBtcmdacllI?=
 =?utf-8?B?YjJIZnJrNXFiSVFUU0F1d0djTG9ZNWRCUldNNm9uaXRWUjR0cHpWeitMMFMr?=
 =?utf-8?B?Y1ordDFVOGRlQzY3d0g0QnNNSXF0YjdSVVJPTExwQXA5dVVmekZXejJEdk9I?=
 =?utf-8?B?WHhTaldUTEhtblNlOHhFaW5JL1dKR2pOV01GbzlZblNYT3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1l6ai8zeXh5cWhBdmEvTFQ5Ympqc0ZqZkpRRXlORXFWWk5ieEg0bGtNQjZy?=
 =?utf-8?B?OTFQdXRYNEE4VXMyQUdpYTdSWll1akdCWEFxTzdwQ1FzUEozaVdUZ2hxWmUy?=
 =?utf-8?B?ZFZoNk5HUkdBZEE5RVREOVdCb3U5czl2S3R3SS9XanNhM25vdWRYZ2NDR3J0?=
 =?utf-8?B?ZU5RMlloS294bmlQU1ZOZGJXRFEwNUFaV3BRejkvR3M1NGhIY3V3ZGR6c3BR?=
 =?utf-8?B?QXpiY3FaWEYveWlVcDhPWG0rQ3JrNThNZWxVNDR6alFuZVlCWC9sNldDUWRV?=
 =?utf-8?B?ZzhYTitWWWlZK1c4eG9PKzRMcGpPNUZTV3IvVFNaZTJVRzNQanRaTXZhMG5D?=
 =?utf-8?B?Vk1hamZ0Zmkzcklsci9XeVJFTTlBYWozTlhGWUx4V3BOdzZKaXh4ZFFuYWgy?=
 =?utf-8?B?ZTh4TVZzZDBET25uZUxHVWFkRytaWFJDeENJQXUzbVd5NlJaTWNkZE9Pay9Z?=
 =?utf-8?B?SWREb2VzeDBNYVJHSzhhUlF5Y0l2c2hiR1ZYOHN1ZWZkN1U2Rkc2ZkRMeDdr?=
 =?utf-8?B?bDZ0eG84MktEZGdUeldGTkJzMW5oRjVwNWpwRkRieE92MWx6VEVCNjMydWh6?=
 =?utf-8?B?UWV4L0pUYUczb0VaL1hvWHhNSGJ2YUhINVhqNXo1Q3dSQVp2TVdUbTVLL0dw?=
 =?utf-8?B?T2FnUHJRR0hwS1ZGSVNoR2tnZzZjWTFNcWhaY3BZR1VuVHA3SlFUQUxpS2RJ?=
 =?utf-8?B?SHBCR2ZDd3lUZVZ3QTBwekVXNVB0Uk1ub2lqaU9Uc1h1QW93QTlLNVFERHhL?=
 =?utf-8?B?SzlRN2FFRVNpQk40c1NCTER5aHRjdEc1MjM1WVlWK0FTZlNhemtEQzJ4a0xi?=
 =?utf-8?B?TTB0ZWt0YVFIVmxhZzMxZk52eFpsMUJCenRWS1owcWNBZ1l6dkRNOFBvRTVG?=
 =?utf-8?B?czZ3cWh2b2k0RkJwbGpwS2crb2RBcGI3S2QwU1c3S25NQkpQM1hjbmdubU5k?=
 =?utf-8?B?cGZmczNaanZTbmN3SklVT2RCRmdjaGRUNnQ2aUN6OTR1cEJSdzBRdDJVYXVB?=
 =?utf-8?B?eWo5WnpxNyt4bzRCdHEwVTBMamxFa2RHYWFnbmNDVklmekZoNlJ6d0xTWWpj?=
 =?utf-8?B?bmxiNTVQc3Q5L1pTOTVjUFVyYWdGNWJUbUVzaVpFclowUEJTa2VtK0FQVE1U?=
 =?utf-8?B?T1NsYnZPNzZEbzFHcGNUb2NrVk0xYTc3eWdwZlhYc3IvN2NhV3lsdHpDZlls?=
 =?utf-8?B?SzZlVzh0b3RhOFNMT01WVmJ0RzlqYUwzU3FUclhzeHozTFlTMWxDbXlkK0c0?=
 =?utf-8?B?YWJRdmxTdTVlS09QWkFSeUNKS0pHbFBScWk5R0V0Q1ZJM2JYU2VsVGk3b0Nl?=
 =?utf-8?B?UFp2VFVwY2ZHQVduODRBcHFIc2FSaFNmOTRRVUhDQ2dGaytlYUxGRkpITnhY?=
 =?utf-8?B?bVlwK0ppNW1BZmxRQkxuTXV1RXluanN4TmdyZkZNbzJQNjJrVkpDTExuTHp1?=
 =?utf-8?B?N0MwZGx3R0lFZ1A5QlZOVDcrTGtQM1V0dTA4NGpwMmFjVlhqZmZkSlBTZE9Q?=
 =?utf-8?B?bjFXekxRSElIM3VWTE9wbEdqQ1lOZjl3cU1Md2lURFdGeDFsOFBRRWttV2J6?=
 =?utf-8?B?a2ZDU0xNY3dSZkV5ejhROUx2T3AvQVZhVW9tMDBSMFhodVBvcUxkRFlFQUVK?=
 =?utf-8?B?dytqQjE1eGtWdXlzeTZMTXl2T0p2QUlrWGlsTWZkUlZWcmtLUkJMM05tZE5N?=
 =?utf-8?B?ZENjVjFRbTZMdFlxWlpnOWEyUVBPNnA3Ym9paTRXQWhmZGgyRW95VlpLZXVh?=
 =?utf-8?B?UTFjY3VBRDM0VHlIQzZxMXJObXBzMGp1RWZhdDBNM0JSTkMvU2p6Zzkyanln?=
 =?utf-8?B?NG5mOGg4OWtqcklqaTdCUmhzTUZZUjhqUGdDQ3ZycUptdFBuM3dHWnpVTEkv?=
 =?utf-8?B?NmpyVjVRRjB5V1UzenR4c1RQNU9nMjFZVFVvQVFxeVRUS2VHc2lzQndVcHd5?=
 =?utf-8?B?cGpIcnpCWUxoWDhzaDRQQkQvRnhZOUljcUF5UjdaUUpnSmxtNDEyYVdWUzVz?=
 =?utf-8?B?ZlIxVHp5QzVRbjdvcUtWNU9uWjlNVVpvbFE3R0RLM2FwamhiZkZSa0xuVE0v?=
 =?utf-8?B?OWthVTRLTHlNeVlRZ2NickhQKzZyRWttZFgrRS9sVDd3SUN0dnkvd0hDTHRX?=
 =?utf-8?Q?hgbKIPe+gtpcMu0j2im6nXJ01?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AB68661484AC648A2FCFCDEFA4DFFE0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zQ8SNiEfMv6RNfbkLmMG1FVRN8MwzxW0q9CXl+LGyPJE1YObM8XB0FU6E3r7kTs54YJ/aewMo1nJvuexDuSKqEGmfQC1dvp27LSdnXbdeWFbIpCb6paGFZRZYQGU8mO1YvV9zqeHAzksiosxLsV0WRqBzgdnZ0pmx+z+UhdgTQ9ExXLpAlFKf4eH6uhcVytgyZBcEFysS6FdA9ObKxuE8SxBtsngpTBMqphqg0NVRuS93b/ZnZDk3Ob2K39fcKHKfVQUTQnj5TagWg64ECEcFjtAAc9FQdH/qt+6RYn4u6+xUxwrgtJVVursNHr+OmjHz8HR06/NrACe9Rg21cc+tg8Qj/OTAbwMtHNkuKHOWHF0Rqa53PN4/YeCeHs0X/1JsY7aS0ymNCsOoJ+IH5VFp2IEDqndFsHk5JdUwHPiMdYxU8DzcoP10Ywm0Z5mB3EukPAUgoHPv5jWweN+NmPoHx60Fg51eZWDcuCFR3KdkWm01auUcrbhxpGWum4dIZbBWbanr4LxwFWaxnFt2N1LRySzKFECe1EIcas2MMKcmHeixc3dk/HTDyQZZtneHp2mr0xrfxD89ge7hnbAw5s5+ZlOlIzuKEBBMD7JroUjQOa3VvGCGVlc0Di/LNvsVCKGyAV0AGvjcPn2+PmWa8jWvg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383e3349-bde8-4d22-7da5-08dcc7bafbdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 23:41:48.2792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SXKxuPnePYYudKfF4IFnp2rSkOsA89TweSKUfRByFNo33Z0X8gz0UR3jFXzhO+Y4nYScjDYbVOdxmgW5naxW6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8486
X-Proofpoint-ORIG-GUID: xQewrwqBpdbsLYuVL4Tsgdya_cahGiVp
X-Authority-Analysis: v=2.4 cv=d+2nygjE c=1 sm=1 tr=0 ts=66cfb5c2 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=jIQo8A4GAAAA:8 a=COk6AnOGAAAA:8 a=HFHBjB-0_E_u1e3_KskA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Lf5xNeLK5dgiOs8hzIjU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: xQewrwqBpdbsLYuVL4Tsgdya_cahGiVp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_09,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=571
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408280171

T24gV2VkLCBBdWcgMjgsIDIwMjQsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBXaGVuIG9wZXJhdGlu
ZyBpbiBIaWdoLVNwZWVkLCBpdCBpcyBvYnNlcnZlZCB0aGF0IERTVFNbVVNCTE5LU1RdIGRvZXNu
J3QNCj4gdXBkYXRlIGxpbmsgc3RhdGUgaW1tZWRpYXRlbHkgYWZ0ZXIgcmVjZWl2aW5nIHRoZSB3
YWtldXAgaW50ZXJydXB0LiBTaW5jZQ0KPiB3YWtldXAgZXZlbnQgaGFuZGxlciBjYWxscyB0aGUg
cmVzdW1lIGNhbGxiYWNrcywgdGhlcmUgaXMgYSBjaGFuY2UgdGhhdA0KPiBmdW5jdGlvbiBkcml2
ZXJzIGNhbiBwZXJmb3JtIGFuIGVwIHF1ZXVlLCB3aGljaCBpbiB0dXJuIHRyaWVzIHRvIHBlcmZv
cm0NCj4gcmVtb3RlIHdha2V1cCBmcm9tIHNlbmRfZ2FkZ2V0X2VwX2NtZChTVEFSVFhGRVIpLiBU
aGlzIGhhcHBlbnMgYmVjYXVzZQ0KPiBEU1RTW1syMToxOF0gd2Fzbid0IHVwZGF0ZWQgdG8gVTAg
eWV0LCBpdCdzIG9ic2VydmVkIHRoYXQgdGhlIGxhdGVuY3kgb2YNCj4gRFNUUyBjYW4gYmUgaW4g
b3JkZXIgb2YgbWlsbGktc2Vjb25kcy4gSGVuY2UgYXZvaWQgY2FsbGluZyBnYWRnZXRfd2FrZXVw
DQo+IGR1cmluZyBzdGFydHhmZXIgdG8gcHJldmVudCB1bm5lY2Vzc2FyaWx5IGlzc3VpbmcgcmVt
b3RlIHdha2V1cCB0byBob3N0Lg0KPiANCj4gRml4ZXM6IGMzNmQ4ZTk0N2E1NiAoInVzYjogZHdj
MzogZ2FkZ2V0OiBwdXQgbGluayB0byBVMCBiZWZvcmUgU3RhcnQgVHJhbnNmZXIiKQ0KPiBDYzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1Z2dlc3RlZC1ieTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFzaGFudGggSyA8
cXVpY19wcmFzaGtAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiB2NTogRnVydGhlciByZXdvcmRpbmcg
b2YgdGhlIGNvbW1lbnQgaW4gZnVuY3Rpb24uDQo+IHY0OiBSZXdvcmRpbmcgdGhlIGNvbW1lbnQg
aW4gZnVuY3Rpb24gZGVmaW5pdGlvbi4NCj4gdjM6IEFkZGVkIG5vdGVzIG9uIHRvcCB0aGUgZnVu
Y3Rpb24gZGVmaW5pdGlvbi4NCj4gdjI6IFJlZmFjdG9yZWQgdGhlIHBhdGNoIGFzIHN1Z2dlc3Rl
ZCBpbiB2MSBkaXNjdXNzaW9uLg0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA0
MSArKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0K
PiBpbmRleCA4OWZjNjkwZmRmMzQuLjI5MWJjNTQ5OTM1YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
IEBAIC0yODcsNiArMjg3LDIzIEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdldF93YWtldXAoc3Ry
dWN0IGR3YzMgKmR3YywgYm9vbCBhc3luYyk7DQo+ICAgKg0KPiAgICogQ2FsbGVyIHNob3VsZCBo
YW5kbGUgbG9ja2luZy4gVGhpcyBmdW5jdGlvbiB3aWxsIGlzc3VlIEBjbWQgd2l0aCBnaXZlbg0K
PiAgICogQHBhcmFtcyB0byBAZGVwIGFuZCB3YWl0IGZvciBpdHMgY29tcGxldGlvbi4NCj4gKyAq
DQo+ICsgKiBBY2NvcmRpbmcgdG8gdGhlIHByb2dyYW1taW5nIGd1aWRlLCBpZiB0aGUgbGluayBz
dGF0ZSBpcyBpbiBMMS9MMi9VMywNCj4gKyAqIHRoZW4gc2VuZGluZyB0aGUgU3RhcnQgVHJhbnNm
ZXIgY29tbWFuZCBtYXkgbm90IGNvbXBsZXRlLiBUaGUNCj4gKyAqIHByb2dyYW1taW5nIGd1aWRl
IHN1Z2dlc3RlZCB0byBicmluZyB0aGUgbGluayBzdGF0ZSBiYWNrIHRvIE9OL1UwIGJ5DQo+ICsg
KiBwZXJmb3JtaW5nIHJlbW90ZSB3YWtldXAgcHJpb3IgdG8gc2VuZGluZyB0aGUgY29tbWFuZC4g
SG93ZXZlciwgZG9uJ3QNCj4gKyAqIGluaXRpYXRlIHJlbW90ZSB3YWtldXAgd2hlbiB0aGUgdXNl
ci9mdW5jdGlvbiBkb2VzIG5vdCBzZW5kIHdha2V1cA0KPiArICogcmVxdWVzdCB2aWEgd2FrZXVw
IG9wcy4gU2VuZCB0aGUgY29tbWFuZCB3aGVuIGl0J3MgYWxsb3dlZC4NCj4gKyAqDQo+ICsgKiBO
b3RlczoNCj4gKyAqIEZvciBMMSBsaW5rIHN0YXRlLCBpc3N1aW5nIGEgY29tbWFuZCByZXF1aXJl
cyB0aGUgY2xlYXJpbmcgb2YNCj4gKyAqIEdVU0IyUEhZQ0ZHLlNVU1BFTkRVU0IyLCB3aGljaCB0
dXJucyBvbiB0aGUgc2lnbmFsIHJlcXVpcmVkIHRvIGNvbXBsZXRlDQo+ICsgKiB0aGUgZ2l2ZW4g
Y29tbWFuZCAodXN1YWxseSB3aXRoaW4gNTB1cykuIFRoaXMgc2hvdWxkIGhhcHBlbiB3aXRoaW4g
dGhlDQo+ICsgKiBjb21tYW5kIHRpbWVvdXQgc2V0IGJ5IGRyaXZlci4gTm8gYWRkaXRpb25hbCBz
dGVwIGlzIG5lZWRlZC4NCj4gKyAqDQo+ICsgKiBGb3IgTDIgb3IgVTMgbGluayBzdGF0ZSwgdGhl
IGdhZGdldCBpcyBpbiBVU0Igc3VzcGVuZC4gQ2FyZSBzaG91bGQgYmUNCj4gKyAqIHRha2VuIHdo
ZW4gc2VuZGluZyBTdGFydCBUcmFuc2ZlciBjb21tYW5kIHRvIGVuc3VyZSB0aGF0IGl0J3MgZG9u
ZSBhZnRlcg0KPiArICogVVNCIHJlc3VtZS4NCj4gICAqLw0KPiAgaW50IGR3YzNfc2VuZF9nYWRn
ZXRfZXBfY21kKHN0cnVjdCBkd2MzX2VwICpkZXAsIHVuc2lnbmVkIGludCBjbWQsDQo+ICAJCXN0
cnVjdCBkd2MzX2dhZGdldF9lcF9jbWRfcGFyYW1zICpwYXJhbXMpDQo+IEBAIC0zMjcsMzAgKzM0
NCw2IEBAIGludCBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2NtZChzdHJ1Y3QgZHdjM19lcCAqZGVwLCB1
bnNpZ25lZCBpbnQgY21kLA0KPiAgCQkJZHdjM193cml0ZWwoZHdjLT5yZWdzLCBEV0MzX0dVU0Iy
UEhZQ0ZHKDApLCByZWcpOw0KPiAgCX0NCj4gIA0KPiAtCWlmIChEV0MzX0RFUENNRF9DTUQoY21k
KSA9PSBEV0MzX0RFUENNRF9TVEFSVFRSQU5TRkVSKSB7DQo+IC0JCWludCBsaW5rX3N0YXRlOw0K
PiAtDQo+IC0JCS8qDQo+IC0JCSAqIEluaXRpYXRlIHJlbW90ZSB3YWtldXAgaWYgdGhlIGxpbmsg
c3RhdGUgaXMgaW4gVTMgd2hlbg0KPiAtCQkgKiBvcGVyYXRpbmcgaW4gU1MvU1NQIG9yIEwxL0wy
IHdoZW4gb3BlcmF0aW5nIGluIEhTL0ZTLiBJZiB0aGUNCj4gLQkJICogbGluayBzdGF0ZSBpcyBp
biBVMS9VMiwgbm8gcmVtb3RlIHdha2V1cCBpcyBuZWVkZWQuIFRoZSBTdGFydA0KPiAtCQkgKiBU
cmFuc2ZlciBjb21tYW5kIHdpbGwgaW5pdGlhdGUgdGhlIGxpbmsgcmVjb3ZlcnkuDQo+IC0JCSAq
Lw0KPiAtCQlsaW5rX3N0YXRlID0gZHdjM19nYWRnZXRfZ2V0X2xpbmtfc3RhdGUoZHdjKTsNCj4g
LQkJc3dpdGNoIChsaW5rX3N0YXRlKSB7DQo+IC0JCWNhc2UgRFdDM19MSU5LX1NUQVRFX1UyOg0K
PiAtCQkJaWYgKGR3Yy0+Z2FkZ2V0LT5zcGVlZCA+PSBVU0JfU1BFRURfU1VQRVIpDQo+IC0JCQkJ
YnJlYWs7DQo+IC0NCj4gLQkJCWZhbGx0aHJvdWdoOw0KPiAtCQljYXNlIERXQzNfTElOS19TVEFU
RV9VMzoNCj4gLQkJCXJldCA9IF9fZHdjM19nYWRnZXRfd2FrZXVwKGR3YywgZmFsc2UpOw0KPiAt
CQkJZGV2X1dBUk5fT05DRShkd2MtPmRldiwgcmV0LCAid2FrZXVwIGZhaWxlZCAtLT4gJWRcbiIs
DQo+IC0JCQkJCXJldCk7DQo+IC0JCQlicmVhazsNCj4gLQkJfQ0KPiAtCX0NCj4gLQ0KPiAgCS8q
DQo+ICAJICogRm9yIHNvbWUgY29tbWFuZHMgc3VjaCBhcyBVcGRhdGUgVHJhbnNmZXIgY29tbWFu
ZCwgREVQQ01EUEFSbg0KPiAgCSAqIHJlZ2lzdGVycyBhcmUgcmVzZXJ2ZWQuIFNpbmNlIHRoZSBk
cml2ZXIgb2Z0ZW4gc2VuZHMgVXBkYXRlIFRyYW5zZmVyDQo+IC0tIA0KPiAyLjI1LjENCj4gDQoN
CkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoNClRo
YW5rcywNClRoaW5o

