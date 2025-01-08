Return-Path: <stable+bounces-107936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E61A04FD5
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 02:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849231887B86
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 01:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128F313C67C;
	Wed,  8 Jan 2025 01:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cIXklebw";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jhtVH9Ca";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TpzgbKj9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C51139CF2;
	Wed,  8 Jan 2025 01:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736300689; cv=fail; b=E3t9hYrD6ld+TTPstZoO6QkdyyxXgIoMlE/uCw0zGYMzDR02MRJSICDwfM+K/nejRzswiyfpCgkd1nDEanqojvKeH9xoZ4eC6LcdjvN3iBOVwqn0wP+aeCtEsKl6wHDaNt3/SqA7Vrv5QtOUmlbPCkVnWVaBderDsGS9FR3Myas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736300689; c=relaxed/simple;
	bh=z0raMT2r/nMPXCe4rGrWilHpkHUN9RHCCXs3yO8dOZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=US3uvcHsfSHKaYszKXiTEyLiNxgfVVhTk6v5ToDMT7/LrEZoqsqia4MAzML36VLreMTPPYbT+XZJO8VXznE2oeX3o3QDlYM5W9VNlRDHLGsB3fW1tDpRFZABh4VV0RRmjzlH1rCKGMiOoduZWbT8ISbci3lLXKFRzGbPY1iVnXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=cIXklebw; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jhtVH9Ca; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TpzgbKj9 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507N7oSP027242;
	Tue, 7 Jan 2025 17:19:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=z0raMT2r/nMPXCe4rGrWilHpkHUN9RHCCXs3yO8dOZw=; b=
	cIXklebwk8mC8RqDFPu1T8frzHw7lHXHXX2Exs2eD4Wp8s2mSaoHQiYr62AvbqNk
	ntgCsF3pxUQXVgEzLhHVpyHdl1sBKMOEHEJHdEUBoIq0yoKI8p9UUM/6KmwEJ6da
	CEZ/+nvZkES29l2UJi4unVOufRJvF+1OfvzgXlaF/Rk20Z8LObpcunGWMUelw48l
	GSnLFh8l9YQAHugKtQ8FUc+4sDxAve6ZWBzNc5nphGx3FwKVDP3Ed9cunsJ3tiNO
	94ZRPtErLjkxMk0U598Nr29sfN8PJZbLz9FGKmprD/a123pmt+tEdgvkTIwL3Bj0
	eIh+e07MKwK2KYbpK6o53g==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 441dp10duf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 17:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1736299176; bh=z0raMT2r/nMPXCe4rGrWilHpkHUN9RHCCXs3yO8dOZw=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=jhtVH9CazwsDnnJOiSBYHvMoJ0C8Xa5LRLzHnYFbxqYN8ngndowWmoDtjEuggVPUP
	 9zLz4jqI72RkFwDjBNop9JEZhLVUi1/PVnkpqypRuV1L4geezB8jjlQmttjXw2/+xM
	 elVCMveVRq1pWcpA/HBxWCq62L4S1tcbXpeLMdSJtyeam9DxZi4gXjx4YUTiPol+hO
	 qJGhaAyrZyegOWmzTwdOmQHcfLI+Da+vFgq9B72fpkOjXKTGqqlV1k+J6j61C/d3/+
	 x9TvstR0PcG4X8cvUAL/3GPBeBtXlG21mG0ZAyq84tM06/kPrjpqCGhOYxEqyoYBcp
	 GUFc9oo6ornXQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F329A40340;
	Wed,  8 Jan 2025 01:19:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 16AB5A0071;
	Wed,  8 Jan 2025 01:19:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TpzgbKj9;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 60D8440218;
	Wed,  8 Jan 2025 01:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iS25y04kS9SE5poNllhCb68JRkxlS/OLiO0giv39vimzS9G2rzEl3ee2/VV6HGdJor7iNhZH/NEF2DRdVoWAhW/ba+c2jBuNxf8PSLLNnMbKPrAiubOKBo9nKdKQEkHXgOJyyldF/RrXP1z/QTRUPg9tS0FaYBvGZNKoJ8r2WHP2nDQSVJ4RBvoh9o5+bBpeQf6JI4dUFNYtOA5jcLI+gx59voLA6w3aTopJRNJLnW9wwG/4PxQrZpiziOfGrYDKbc6SXw/L2Vh+mJrFGjdkXqCQBCEMKZ40HqAfA5M0NfgcOYAhKsLGwtcRd3Jze4ei/JBXnZrIHigt/ynZ/8f04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0raMT2r/nMPXCe4rGrWilHpkHUN9RHCCXs3yO8dOZw=;
 b=OI7DXKqELlcP6WUtyWc5AgW6PApR5iFpxzKi5EAixK3csNNAW425OLDvUlrRndOHg/PXvIRNEfl62NKS3D6WxYHPbziYBV+tym+XPOCw+gPfecFUuwUS8igbVWAfXHDKDFJG7eR5eDurZf2ccZeuuOTyb4ylBhpAop5ZmGFHe1cC4qKK62sUoMxE96BntB5ribjFunmyIdfcMO/TvLd9QuqlbZR1XF3H6h/1Op5amSZb4uhvN5ypJMe0W05iXPSmuj5b0oVv0NvZAMP4DSaKht5y73Lgvd1iP70OttpXH7l8TYWm/mZT13w3TvT9QdgcXkdQEPnGDFd++c5N135Ilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0raMT2r/nMPXCe4rGrWilHpkHUN9RHCCXs3yO8dOZw=;
 b=TpzgbKj9G5MqG/rXaV5zy/kPBoP9poViUegCpGrkMqQ7gnkpYxsFNSWiOk2W0C7NuHydPJf4/OW47XalIT7hrspD7+6+3EszSAem9OUqOHgelco/KYURnY6T0odWbx4HRGCjNtiD/cjPGgAH91BvXvcA8vl9/vB0J1b/T0qyPJc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 01:19:25 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 01:19:25 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Ray Chi <raychi@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "albertccwang@google.com" <albertccwang@google.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pumahsu@google.com" <pumahsu@google.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Skip resume if pm_runtime_set_active() fails
Thread-Topic: [PATCH] usb: dwc3: Skip resume if pm_runtime_set_active() fails
Thread-Index: AQHbYBQubw0bBfE6x0CGK56duHGdn7MMFokA
Date: Wed, 8 Jan 2025 01:19:25 +0000
Message-ID: <20250108011922.lmdafz3sqbbhbj6p@synopsys.com>
References: <20250106082240.3822059-1-raychi@google.com>
In-Reply-To: <20250106082240.3822059-1-raychi@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV3PR12MB9403:EE_
x-ms-office365-filtering-correlation-id: bcf82012-77b7-4711-75e7-08dd2f827da8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjV4N1hYMk5MdytiekdLNXBZT2Z5T3RUamU2SG5aZ21pNkZQeFFoVkhXRjY5?=
 =?utf-8?B?NkhpYWMvc0FwOC94bnNYSDVrNnY1dU5FcWN5ZTlhaDc5Z2ROem1Lc3lvL2Fz?=
 =?utf-8?B?d2diRnJJRnROMjVPVk94dHZ2R1poNUJ6Z1RoMVB4Wklvamc2citmTGxDNzNS?=
 =?utf-8?B?M0dsTFgyZWk1clBIN3hjaUR4d2Q1SktNRHJlUi9zR3d4bTRFNzV0cVJBYWxV?=
 =?utf-8?B?bXh1ZVpNYUlIK3N1WTZPell4MWNYNTNNU2N6ZGdKcHlWRGN1OFpkREJxaXJ6?=
 =?utf-8?B?c2N0TW4zVFg4TVh1aWVSLzQ5endhVzFodEQ0dXBvVnpkRkswMHE5RGp5VG12?=
 =?utf-8?B?VXFZcmszbFlRZ1NoN2dvc3JZZUdDMmU3V3M5eTFQdjJNcmFwR09QMW1COXZV?=
 =?utf-8?B?VDdCZlBEM0ljMzdtUSsrb2RVTndpRWh0SW5OUkVBMmVESk80a1F4VjdSc25S?=
 =?utf-8?B?ZkRMeFRrRFNtOUVyWEtUTUdMVGs3T3RXdkp5WE9nNENtREFtREp4cWtKQmJu?=
 =?utf-8?B?VkkwN0lIQ1lGWWhOTUZod2oxVjJ3dzFZUmVFUzM0cFJxSDlQZEtnZGhwQkJm?=
 =?utf-8?B?MGhHQkppc0kyaW5xTG55M0JPSjdQYXZSUTlPSGlyK3lIQkszeW9KQm1NK0kr?=
 =?utf-8?B?NUZ5YzJPT1FpRGc5KytRVEJjZzhFM2lZWGF3eU12MGtoanRBdzgzcU5DRkdn?=
 =?utf-8?B?TVV2Nys3Nm40elVYdjdTdFUxOURDT2tHSnhXdFJCT3o3d1QzdjFRSkRSaXR1?=
 =?utf-8?B?TUkxSVo3S3k0TG1Xa1phVnhWM2tsWnErWFg3dkJja3orZmxCbTFEYnZvVUxX?=
 =?utf-8?B?Y0luWFZZOVhZYmlmTHY3Y3RlZDllS1ZXSVNhOFNEc25ycUUvUnQrNi9QdmJr?=
 =?utf-8?B?b2dCRmFFZE5uV2hqWFlLZTZnSFJxK1dwWjZUSGg5QXdFUGhJRlA3QzlKZUpj?=
 =?utf-8?B?R2FLeGNQM0JxemVZNmdCSkhiR1FCU3hCT0FHR3phNzFwR0RGTWR4cDhFajBw?=
 =?utf-8?B?a1FWVGhyOFd5emZmRVNyLzQ1MkJwZEt1aE5xemliQTc3Y05rdGZnNDBLbXRI?=
 =?utf-8?B?bmlPMUNsbVIyOTFkTUgzKzVieWpSQzlQK3E2K1ZCUlQ5Zmx3RE9zd1cwTjJQ?=
 =?utf-8?B?MndaZWU2OW11R2s4WTFZSzUraHBwRWxJNityYTZlUTgyMHFDZUgyRzg1V3RM?=
 =?utf-8?B?U29aS282aHc1SjFqa0h4SFJXRDkrZ3NRVGxaTUtTa0M0Mm1ZQno3ajJldVN1?=
 =?utf-8?B?RFo4Sk9oY2Y1SWJtSE9IVVlZS2VtT2NIc1Z6YVVrZk9MWmQ1aWZEMTNJWElP?=
 =?utf-8?B?M1NoWHozcXdOSTdzSXhLUlFpZHRieThBc3dyOXpTZmNmeFJKQVY0UDhsNkdh?=
 =?utf-8?B?VU8zRlZXQzVKdVlkR01POTNFU2k2V0ZodmlReWN0ZFdoVzBHWHZmaGM4ckRa?=
 =?utf-8?B?YThtS1lOcGdkRnFaL2dldmpmMEVJOTlsL3RuVGw3RW1EWjU4dHcrenQxQ0kw?=
 =?utf-8?B?dmxHWTh4UGdZNVcyUTYxcW1CdkVsWDVDejZVUHhGV1kxb0k3MlkvTEltSGt6?=
 =?utf-8?B?bmFiR0hObzZYRzVrYi9pUEJNOWMvc3hJQW5JVTVnUDIzTmoxWVNGYTBPZWhV?=
 =?utf-8?B?MEUyNVl4TTE0ZGs3Qm92K1hRY2FDa1o0MGN4bEhuVjUrR1g5ajZEakRsS0FF?=
 =?utf-8?B?eDBGZXEzZDZYbnNxMnlYQnNDR21ZelFQejcwZ25YWFE4NHZmb3RiSWxvL0No?=
 =?utf-8?B?aE1NbHpnM2pQVDJDU3hLZEJhdkFDb3NCUnVkY2M2SGxhQ05yeHhzZzhKTWhH?=
 =?utf-8?B?QUNCNHg0cFBmWW9CQ2U0VGhOMzNMelhWQnhWQS9tMkZsNVVsUkJ5emMrVnk5?=
 =?utf-8?B?QjVuT2JadjFoT0dKSW9lN2hqNjBBS3pEL2ZOelRVdGpPSmwycGJIdW1KZmw4?=
 =?utf-8?Q?5cmcyHttLEPr8HCwaVT6NyyLtvvF2bKd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWRNK3ByZXhyeTRGanBPWE5Ya3F0eXZlVzNTTDBiMEdoeTNReGdyUGZPL29q?=
 =?utf-8?B?aWVaVkRGNngwNmo4TG9PdnJkRWhZbkJZejVqd21lQjdoUjYrTXc1SndTeWVp?=
 =?utf-8?B?TXJKTXROdkhqakFZWG85VnBUckNOeXVLVjg3TVpaazV6eDFtQWo1SDN6M3pu?=
 =?utf-8?B?R1NCMUJ5R2gwU2F2TFVwWFFSYitBVnNtcW5hZS9SUW0xNU5aRUxvUzZ4WHZB?=
 =?utf-8?B?blVhVS94ZEkxN0lLYXNPWEdITWU0YUhmVW50alFDVm41ZGl4NFZEUTZzU2xv?=
 =?utf-8?B?Uzh2aWl2WWEvS3l6OVNrSEtNL2JCSjFldWV2RVNLcmhFYWU4eWpJMWZJUDdh?=
 =?utf-8?B?STRpdWxNOVhqa2JTV29VbTU2ckJ4QTdtR2RzT2JnazUranVJeWxHTXBRZlpq?=
 =?utf-8?B?VmFNU0JCTW94TFcwV3FseHVlWnJ4SkpSalZoMVBoM01pbEYzUW1tUjFxWlgy?=
 =?utf-8?B?M25RU1QwTlRMMWR5SGJOWXFJK25MY1I3ZFRiV3RyMFlyOHluRW53blVJVHVD?=
 =?utf-8?B?dkZYTmpadTZPUG50c3FmWmxVQnZ0SGxaNld0YlZoWW1MY3J6R2trRjRNeTU5?=
 =?utf-8?B?ZWdaRFZteEhJNDJXQXloN1dsZ0M2K0pSUW5uZU1tcDM1dVVUN3VhZ2Y5NzJv?=
 =?utf-8?B?WDh3OHVLem1ERE10YnI1bzdaV1JMa0s5UTNZQU94YXVlWkFsRUJ5WkFqRVFO?=
 =?utf-8?B?UDdqZjJraHhsSDNiTXdYM0Rjb1pXTnR6bHNJR0xVdVJmNXUrQzNLdlgvYXh1?=
 =?utf-8?B?WmN6RGcremFKRXVzOFBla2pXejExTExxdGxvdDQ5ZlhIVU43T3dJRlBnakJr?=
 =?utf-8?B?MFVUTEpFVnlkV045cjVKYUpmWVlkK3JrOEFVdHE1R1JBYWpIZk0xS1ByQm43?=
 =?utf-8?B?SSt6WWNiUmMybGwxYlo5MWFsMjVRWjUwbnlBNmQ3U3lNbUFmN3dxMFRBNC91?=
 =?utf-8?B?bDVRVlRZak9EdzJ3UUVhb3o0NzlXUm5MSW1JWVArUDhZNkx6bWQ5WG9zeTJZ?=
 =?utf-8?B?b2RYcTI0V3dHWmU0VHh6cnE5Sm41aVNjeitwOGI5VzVYbWN6WFpBTjhjWGJ1?=
 =?utf-8?B?cEJqTzVacExuWXBWeVg3bzZTdlUvSmZlNitqMDYyTE9sUVBwelNRU0EzMTdi?=
 =?utf-8?B?RDBZQytQZGtmUUsrOHd6TllxanV1UFdkR2lqME5kWXVzYzNTa1pFRFYvS2px?=
 =?utf-8?B?WGVZYUl5Wm9GSjZoWHNxYmludVAyV09ReVNJbWNUK0xxSjdqcnFyUjZwQnNt?=
 =?utf-8?B?RnNWcERpeFBBb1BJeWo4bmZUZzZsbHptUzltMmo5TUJzOEl2MXlDbVorMllI?=
 =?utf-8?B?T1p2OTJ4ZmhkOU9ZSEJoVmNFMjg4WnNOTWoyc2dibGxUeXB1c0VwTjZkS2tX?=
 =?utf-8?B?dkdDSkJlU3ovR3dFSzIrN3hxTWllMUFiVDdvMHBJNDVOVVdlLzVSY3VqMHE5?=
 =?utf-8?B?NGhaUGttbnFadm1JQTJPRno1MkFUc0N3SUdRcTJ5SUxTTHVlUTlheElicUpS?=
 =?utf-8?B?cmZ3aGhubzZwTS9JNjZyWExpMkxLcTFjYlRzYXB5U2RDODhQQ2FCR0xBTUhi?=
 =?utf-8?B?U1lKd2lST2hiZkNPMHFXbk5UZWtaczBEaHlUWmphbXMxNmlkWkt6ZmZWaXJu?=
 =?utf-8?B?ZG1CZHdwOXFITjZ2dmxKclhiT2cwclFTVHRmeUFYTzFnbkFSUmlzMG9KV1A2?=
 =?utf-8?B?M1pWeTVUQWpKTyt1ajVQejcyN2JrdlF4SmNUMzdhaysxUWJYdnpWd0dSa1A4?=
 =?utf-8?B?cC9FTWV1SVFFUmphYnFQeXAwaDFGT1ZiQkRhaG81WVlHN2JUcVhpSjdtVEEw?=
 =?utf-8?B?d1VzN2JDMkFNeE9FVlp2cUxwMXFIYlU0QWhLWnVrWDZ5Q2I5alo3SUErM3JO?=
 =?utf-8?B?MG56WU5uN1BtQ0RBd3NNRURMRSsxZi9EYll0QW83aW93Sk1neW9VenFNWUlv?=
 =?utf-8?B?ODFaZkRacStLY3ZRY2lsT1Q4akdEck9xZjJXWm5HcCtDSXhIeW9ualNXLzNX?=
 =?utf-8?B?NEI0ZHN5T1NTckFnVXEzK3VVRWoxRFlOR1ZMR0hhQ1ZLQTNmR25SSC9Qa1o2?=
 =?utf-8?B?dW5nOWdLTUI5Z0FSeVdHUmh6aVZpWkZEUk94S2x6NlJuN1E0VUxCRzI5OSt2?=
 =?utf-8?Q?EpaJ8uvcI7vshMYTl2cJjodB8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0E16C5855CD324E8E6D3FC25A24ED26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ePCYm120vfTVgsgFeUII6vXAfiMDY2V4GDKbbE1IfxzQfe8SNG6gIpo6bX/M2gbHmMJv3NrqWK+s+EdFJy8zplK7rlWzpC4Q04Rd1taxpmLMXFhC5OJD8q3C13LO927kXo4Muhni9xlNEEhHCgay2fY2pJMk5tqCMemE86F7xOwdFMenlIIYGLjcULjO5h+0n7vVQ5sUvTZkBGQIe8Nnq+Dll0h23q4DV182hz0LRBCpOCPAW1+8+BCyIqmnq/To5iH4fhlJqmvW55YiawzN24rwJCu4TmzLtvrAvlfHZs0QfpXJUJB0gS32EXW6jWJMAokOVEQfTLmKct5YrHZQ3ymqaVTDuvIrtZ93/TiIPsyz2Z8fl/8drOXyehcjccHna8wGhyNS5BKAhNTq2cLN0VglT1HTSDm9UXjVExR3OD4lFoXZtyguC1acZeuYw0dW0RDxsUsz/NFuMcljB2WLFwz1/SwW9UztOqIpoe5c9u5ZqF9tvMS9pz2fO/MhNEvAD4xikyA2Mv/fCzku9fDTEZw/h23oy1zJvsyfNtDqeB/b7goDiF3NsREFtuvCytLwO6ftZaDXyY+mh89oCg+ydZEllKpJrNC3QlqxzYxWxOwdew5FoBD1ddp4H6fZ6ZB4AHpQiY5QmPCBq6F44mSVZg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf82012-77b7-4711-75e7-08dd2f827da8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 01:19:25.6588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbxIYfsbajdcyXcC3/96Z834RkMhjBT0jkcIuSSvVMgkCK4OWvc0P29t8Ym7PURNSJ1SUNF5HuIhZKmhQA5B2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
X-Authority-Analysis: v=2.4 cv=ZP8tmW7b c=1 sm=1 tr=0 ts=677dd2a9 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=WUXnSDRgQTPo38-ZOzoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Sl3Xax4wPNXuk5dUaXRZNdOafB6gqVRg
X-Proofpoint-ORIG-GUID: Sl3Xax4wPNXuk5dUaXRZNdOafB6gqVRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=431 phishscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080007

T24gTW9uLCBKYW4gMDYsIDIwMjUsIFJheSBDaGkgd3JvdGU6DQo+IFdoZW4gdGhlIHN5c3RlbSBi
ZWdpbnMgdG8gZW50ZXIgc3VzcGVuZCBtb2RlLCBkd2MzX3N1c3BlbmQoKSBpcyBjYWxsZWQNCj4g
YnkgUE0gc3VzcGVuZC4gVGhlcmUgaXMgYSBwcm9ibGVtIHRoYXQgaWYgc29tZW9uZSBpbnRlcnJ1
cHQgdGhlIHN5c3RlbQ0KPiBzdXNwZW5kIHByb2Nlc3MgYmV0d2VlbiBkd2MzX3N1c3BlbmQoKSBh
bmQgcG1fc3VzcGVuZCgpIG9mIGl0cyBwYXJlbnQNCj4gZGV2aWNlLCBQTSBzdXNwZW5kIHdpbGwg
YmUgY2FuY2VsZWQgYW5kIGF0dGVtcHQgdG8gcmVzdW1lIHN1c3BlbmRlZA0KPiBkZXZpY2VzIHNv
IHRoYXQgZHdjM19yZXN1bWUoKSB3aWxsIGJlIGNhbGxlZC4gSG93ZXZlciwgZHdjMyBhbmQgaXRz
DQo+IHBhcmVudCBkZXZpY2UgKGxpa2UgdGhlIHBvd2VyIGRvbWFpbiBvciBnbHVlIGRyaXZlcikg
bWF5IGFscmVhZHkgYmUNCj4gc3VzcGVuZGVkIGJ5IHJ1bnRpbWUgUE0gaW4gZmFjdC4gSWYgdGhp
cyBzdXRpYXRpb24gaGFwcGVuZWQsIHRoZQ0KPiBwbV9ydW50aW1lX3NldF9hY3RpdmUoKSBpbiBk
d2MzX3Jlc3VtZSgpIHdpbGwgcmV0dXJuIGFuIGVycm9yIHNpbmNlDQo+IHBhcmVudCBkZXZpY2Ug
d2FzIHN1c3BlbmRlZC4gVGhpcyBjYW4gbGVhZCB0byB1bmV4cGVjdGVkIGJlaGF2aW9yIGlmDQo+
IERXQzMgcHJvY2VlZHMgdG8gZXhlY3V0ZSBkd2MzX3Jlc3VtZV9jb21tb24oKS4NCj4gDQo+IEVY
Lg0KPiBSUE0gc3VzcGVuZDogLi4uIC0+IGR3YzNfcnVudGltZV9zdXNwZW5kKCkNCj4gICAgICAg
ICAgICAgICAgICAgICAgIC0+IHJwbV9zdXNwZW5kKCkgb2YgcGFyZW50IGRldmljZQ0KPiAuLi4N
Cj4gUE0gc3VzcGVuZDogLi4uIC0+IGR3YzNfc3VzcGVuZCgpIC0+IHBtX3N1c3BlbmQgb2YgcGFy
ZW50IGRldmljZQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeIGludGVycnVw
dCwgc28gcmVzdW1lIHN1c3BlbmRlZCBkZXZpY2UNCj4gICAgICAgICAgIC4uLiAgPC0gIGR3YzNf
cmVzdW1lKCkgIDwtLw0KPiAgICAgICAgICAgICAgICAgICAgICAgXiBwbV9ydW50aW1lX3NldF9h
Y3RpdmUoKSByZXR1cm5zIGVycm9yDQo+IA0KPiBUbyBwcmV2ZW50IHRoZSBwcm9ibGVtLCB0aGlz
IGNvbW1pdCB3aWxsIHNraXAgZHdjM19yZXN1bWVfY29tbW9uKCkgYW5kDQo+IHJldHVybiB0aGUg
ZXJyb3IgaWYgcG1fcnVudGltZV9zZXRfYWN0aXZlKCkgZmFpbHMuDQoNCg0KU28sIGlmIHRoZSBk
ZXZpY2UgaXMgcnVudGltZSBzdXNwZW5kZWQsIHdlIHByZXZlbnQgYW55IGludGVycnVwdCBkdXJp
bmcNCnN5c3RlbSBzdXNwZW5kPyBBbnkgd2F5IHdlIGNhbiBrZWVwIHRoZSBzYW1lIGJlaGF2aW9y
IGFuZCBhbGxvdyBQTQ0KaW50ZXJydXB0aW9uIGFzIHdoZW4gdGhlcmUncyBubyBydW50aW1lIHN1
c3BlbmQuDQoNCkJSLA0KVGhpbmgNCg==

