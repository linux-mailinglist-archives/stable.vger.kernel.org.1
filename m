Return-Path: <stable+bounces-67729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6C8952667
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 02:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB7E1F22916
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 00:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F8564A;
	Thu, 15 Aug 2024 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jwJ6GZnR";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YSJDEjwr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uFKpjzsh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7C161;
	Thu, 15 Aug 2024 00:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680261; cv=fail; b=qo9TWfd3SniN5MmKwLw+SuukJPaZsZUARw4DJUosk8GgOxx9fGalMpc2o45iSIfz0LmghzAKGxdj/JWqU90s4d2FALU8EjJjr0zrYIuHDJh44Nut/QVRNr9Nua+L7BGlfv184YMS82V/cE+MtVT+9xX8JyAdFz+vtObSzjUmvjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680261; c=relaxed/simple;
	bh=0MxjqW5BJymmzdK+iGICu+G/Amo2eYaR4A5C1Z8MTyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rPjxZNME8e05N1eVqB91vxGMa45rNE+PmYazv/zjtGqKx4JN00llKHYioApCCKlQ9IS5jwdjHL0qcBOVPX40XrwvyNG7d+wMAWgoML1eqvAZxq9k60IyV9ax0OHXHpr77ouywge123NtKzQTpAnkHJXsvdubX+Q6Dsz+1WK65iI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jwJ6GZnR; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=YSJDEjwr; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uFKpjzsh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EHrwWZ001412;
	Wed, 14 Aug 2024 17:04:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=0MxjqW5BJymmzdK+iGICu+G/Amo2eYaR4A5C1Z8MTyo=; b=
	jwJ6GZnRPMud21APuLS4oAVxO/k7mZbgGr3TE2EMhXs4O67go7bWdvzhNz7AbyNu
	Qa9kpZGIP1CBvY/iBP3FmfxdM1In+VgkZvlQZA1PKLDXoy6GMchVCk4A0ofcFn4f
	nLcxM2FJW6x1YNri6mSiz2WANNI+4PMQPNQGCxIeOp86Wqanb/XjcvsQmEft1xqU
	ammBZ+U7S2tYdA2bXm1fRtRtwl5yCm0wnnzVQb5DGZEfC9beZglB2bsF2HCccm9m
	6Asnpc2w0352QNeYfVkb9MLHP1Myny18yroUnbZFx+3fomEMGDuwzGrgfiGcJPxs
	yWvFdL/GfP+A/OkeVIghIg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4111cr18x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 17:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1723680251; bh=0MxjqW5BJymmzdK+iGICu+G/Amo2eYaR4A5C1Z8MTyo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YSJDEjwrHZTzFcFXp5bE7Mwwe2aAdr7zcOoewcxUJI6oH3wiJX6Ie2DowdfbyucJl
	 uPaoPbMVP1gGU63tkeChDowjl/Tg/+oi6YdW9iy+JpgZgPwJiKY0sl8QS6Ui3w4hHG
	 rZyTrJ8bGoJaBj43uZHOSVg/0mFvPKC4lLJpVihfAzlDZNkyAkRTxQCz+aaAz2caNH
	 Ab8M4Cuwltprf4QOHqyPt6VaGWjLAGD/ujosRBWvzXsJKyNNP3lIOuTx0L9F89NX0F
	 pRuk8eWnUt7iB8d7xCeJBOgMCI4XtZ6a9lrt/HP0elZXOFPSaIyYXNYjwdlb+I03sg
	 ocL54dsiI9Bng==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0C94A40467;
	Thu, 15 Aug 2024 00:04:10 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9FBE2A0081;
	Thu, 15 Aug 2024 00:04:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=uFKpjzsh;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0C4B5405A9;
	Thu, 15 Aug 2024 00:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9Qdozhcn05CkD5ogXHaqwHNiw0PrBfwi36ioU3/Jb6T9dLc+BZ4b2xQC1xPSxpIKRqF5H0ChE68M3xQWyo27NtEBCvXBZCMNkQZcIV6DJSyis6rxJm3C4TH5m8lXgqzPA/2iE1NW79tYUA2yT1kjSC6hTHggu0ewcdrk1ypbZ+EpK9vbZzctnA5U/ZKTpZTxaUwrgwkmmztLNG7WMoTXTSD9d3t0Ajlt/wusAzDInQhfqbEda6XcvpEsyrM+1aOm7Ai4nfYdP9dzF9wQ9FJHsNyGG0btcQC1ykTepxSZCcLz9dMOmelBzf9YZdPCGLZ6sHDF32dqBpFgIwr9xa5cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MxjqW5BJymmzdK+iGICu+G/Amo2eYaR4A5C1Z8MTyo=;
 b=Jo8hz7aS9NrOjLAqiJr64mzoZxbou97hYNGjjXEuEWhKdAKQlyKFdq953pNNMfYQFqfRtE85o8CfIRyTYmh05KtSZOacSnL8luCHs0dboSyI3EJaSYccaCRuFvze2ldym2b3h3NB/18cIMb8Sb+hKkFtdDC/TmEtFerQ+UjBrHrqUbx1CW2BULOwtJgxNRpTGLUS6JTvqbnMjHIkboXHUz/De2JTMTTijlnPvzjxJB7rSgzu1zwGgqsgA1iIwu7hRCUcDZUiLEr2LWZdwlndH9QYUatCAr1FVR/6p4JWhY3241NnZPeqe9kSIxRxgV6LoT2upKInXSNKelicuEVvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MxjqW5BJymmzdK+iGICu+G/Amo2eYaR4A5C1Z8MTyo=;
 b=uFKpjzshBR0USKS9EYSN+yf+pjL620jbh4pzUgjXcU/qa7mprpfLyXuP47KhnpDdLPUgiZkNE54DwD06rKYUhA4f6sUlNQkiwuGix+I+hmZDdQx1kST3dxAVS3fbgOgGparFETYREE3UDsnZv6qRPKbyNURyjXMB8AGqemefFEk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.22; Thu, 15 Aug 2024 00:04:06 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7849.021; Thu, 15 Aug 2024
 00:04:05 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "rc93.raju@samsung.com" <rc93.raju@samsung.com>,
        "taehyun.cho@samsung.com" <taehyun.cho@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event buffer
 address access
Thread-Topic: [PATCH v2] usb: dwc3: core: Prevent USB core invalid event
 buffer address access
Thread-Index: AQHa6YuP+qYtFRYGC02uoJ+XT4o4f7IflHkAgAEHAoCABT9uAIAAX4WAgAE/tAA=
Date: Thu, 15 Aug 2024 00:04:05 +0000
Message-ID: <20240815000352.squzue3q646bfmmx@synopsys.com>
References:
 <CGME20240808120605epcas5p2c9164533413706da5f7fa2ed624318cd@epcas5p2.samsung.com>
 <20240808120507.1464-1-selvarasu.g@samsung.com>
 <20240809232804.or5kccyf7yebbqm6@synopsys.com>
 <98e0cf35-f729-43e2-97f2-06120052a1cc@samsung.com>
 <20240813231744.p4hd4kbhlotjzgmz@synopsys.com>
 <45a638d0-57e0-405f-bbb0-8159d73cc8b6@samsung.com>
In-Reply-To: <45a638d0-57e0-405f-bbb0-8159d73cc8b6@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB6012:EE_
x-ms-office365-filtering-correlation-id: d071c664-db90-4c9c-3b4c-08dcbcbdc744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VWpSenNRazdKdy9xelJMK2Z0UTU0T2ltSHE3bFlnWXFjU25RcjF0M0RGRCtr?=
 =?utf-8?B?eDRMVW1QTzIrK2RmQ1VtdmRSakdBWVpVRzFUOEJ5YlhnR3hkNXpkbHN6dU80?=
 =?utf-8?B?bXlJVGtWRjNFMlR3aFVHcjRCcUZzR3JQZkJSa3N2ZmFzdWtUM28vVzI3eTVt?=
 =?utf-8?B?TFZVbEhNaTY1ckFvei8yQUtpUTV1L29HbFJpbmd3bTYxeGFBNTVQUnFRelB1?=
 =?utf-8?B?YVRMSktCM2xHY0dJcE8wZWowUWFjYTlCUkkxQmhqWmI1TVdKTml0OUhLa1Bo?=
 =?utf-8?B?VkVmZDc4bkEwNmQ2aCtTeDFWcDVic2RqaHVoNjRjc3JYdVFTcC9OOXRCRmpX?=
 =?utf-8?B?Tzh2bUkrODZGMDlSbS9CS1M3ZUtYOTIySlpUMlRISFppTzcvTzkxSTFQWVN3?=
 =?utf-8?B?YWxLZDl2MnZwams1WktUQUxsYWYyYm02YnNDSi9xWWlPeFd4MnZhUDhFUjZx?=
 =?utf-8?B?T3FLb0ZUMDZQemdWaS9PblhqT1pDVHp6TzRhRXpkMnlCbHRVWTlWV1d2MFp0?=
 =?utf-8?B?QXdkNFpRRkZ4N0kvUmhIcXczRVI4U05mV0JiRmJNSjNlRFp0cmNVYW1JQkZL?=
 =?utf-8?B?MFlQSVdDSWswejh0OVNxa3hDeU9vdVp4MU56Wm5RQzN1VGdJbnRaL0hsL1dS?=
 =?utf-8?B?WFBnL1lGVFhCS1UxYVpORlRLam1ob296aUxDVnAxbE9JdHhnR3NCYmZLM3ZZ?=
 =?utf-8?B?aVJUcHBOc1dicCtGQi9Hd2VxMnNJR01GU3VQVWJpcW56L3BIMDhDcmtZNFBG?=
 =?utf-8?B?S2xycU5IQjA3ZHNvQldvWERtTURVZHpEYWpIT1ZUVHZzRmtpVVJOUG11WGVq?=
 =?utf-8?B?alhFR0tSMnczT0VJT1NQaUZkY1NzZkx0OVdhZSt4YVF1WGtPMytmbndHYXha?=
 =?utf-8?B?NC9UM012TUhwcEtvTWlyV3ZWMnZBTSs4bnlrN2JoM1dMTXorVDdzSW40WFZz?=
 =?utf-8?B?bmVvbXlxOTdHemdtcGE1a1d0WFRPbm1tU0FaQ0owaWNmSk5jU0ROSVdwRXRo?=
 =?utf-8?B?cUxwanpqNXdqWURoVzduMkFscE9wWnM4SmwvTG1rcm55Q29vU3hMc2VaN05I?=
 =?utf-8?B?TEllS2lYeUtoM08vbXFDMTFUR2trYnZyREdLUUR2UGtZejUxUkREaWkxWXdJ?=
 =?utf-8?B?amdaTXlOUExic0Y2d28rVURmRHcvcSt2Ly9HWFk2TnFtVUtTZDRWVUhzTm14?=
 =?utf-8?B?VTlMaUYzVXlJNW10WlR1ZnEvbnJ0SFF6SkExSDhvdWRwc2VKTVFZaWtlOG8r?=
 =?utf-8?B?eGh1K1lQdGhNNmtod1JBTkh5U09lSFV0cDkzOGU5OEZRaG5hYTdMMDNPcWNr?=
 =?utf-8?B?LzA3cTM0NW13WVNqRTM4NHhPdFpSOVlwc2JwSnBnclVzTWJWbkhhUzJkSG5o?=
 =?utf-8?B?Sm1NcXJQSDAvNlRWSlJJZUQwQ3lQeWlGRmRMK3h5SWtkRVNHK29jRHV0aGJa?=
 =?utf-8?B?OGpYYzFndTM1Wno0UjNnbjJ1dHo4Y3BrS1ZJMzdseUZuUyszYnBrNHY5MXFp?=
 =?utf-8?B?RFZBN25tdGxOajJaMElRTlEzaFJTZEVRWkllNkMyNlJKTXB1SnFoaDJOYnky?=
 =?utf-8?B?cFhOZ1NaaEZGVnplckVuTWlzNFYwT0VvbE1uVjNseUFQU1JpYWNWVXR0bUto?=
 =?utf-8?B?dmlCSDVvRmJKNTdRQUMvWTYrV2ZlTmUvMHJCOWtualkxU3AwbzZza041aDJK?=
 =?utf-8?B?bnQ0UTFXd1ZDWXJ4UzFURGVRM3RtYXZNZE51dStFY0o5QWNnd3lMMUw5ZTlQ?=
 =?utf-8?B?MTcyTEYxVnlPQ1lCbVlXVk1HRFRORTJVK0tZKzFVTkdYTHVML2phenltU1Nu?=
 =?utf-8?B?YnhjZk5uQjNXVGlhelBKRFZpWjU0NXduRUN2Tnl3RTdyN3E1c3hUeXRSUHly?=
 =?utf-8?B?Wkw1SHNrdXE5R2F5L01iMno5THFYRXdQUlFMSjlRRmFCK3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejhEOTlMcExmeWZzV0Fxc09KR29rTHNCd1IvOFlGR01UTFZ5OFpITlJ5bXpE?=
 =?utf-8?B?RTIzVUlieUxnUkF1VGVWbTZVR3BQNEUzS0N4dXpCRVdvdFRqcDdGVEZLc1pY?=
 =?utf-8?B?eFJDS3BQTmgrZ2dYTTFUNEJlYmhSdjF5eDRmb1I2TmluOUdRZjZha015Rm5B?=
 =?utf-8?B?RVJ0Vm5FakRYbFdtbjljcHBrc2FSRUpqVWdLMmdDSWVqc2VEblJVZ201ekE1?=
 =?utf-8?B?YlJpRm9Ua3RDRDdkVHhjZkpNNTBBSDBnczhMSG04YUYweTlaV01xS2lENUd3?=
 =?utf-8?B?RGtrWWtHenFpN0wralBlQVJlVkxYRnp5aEFhRU9qbyt2WkludnlLdW5XOERG?=
 =?utf-8?B?ZXBRdUFBaEE5REUvVFF3cjlVc2lURVdDZjVScmdYM2dzR3lUWEpkYTlyM1BR?=
 =?utf-8?B?ZVdVWlpaemFDYSt4L0dNeEI5VmNKSzNwRmpoaGlxb0JGdjFXd3V5WTdMOW1O?=
 =?utf-8?B?bzBLa1JEbXJUcVVwb2NnQVhOMitiMEZ1NU5FaXJYYUxDN0Z2bnI0SFRFaTZv?=
 =?utf-8?B?NlZrMDJTMTliVUQzNGxlcFpjSEw4Z0NDQjJGNTdQdUYvVGFtNHM4dEJCK2FZ?=
 =?utf-8?B?UE9xdnJpaUV1Zm9ORXpqcy9ZOWpxd280bEtjMkhzVm1TTXVsSVN2MGp2WWxF?=
 =?utf-8?B?MTE4b0poZUthUjA4QllQMmQwSFpUMTUvRm1oS3J6cnZSblNlR1JRTzU1TUZl?=
 =?utf-8?B?NVRnZWErZis5cmoxaDFKR3Ntd0lOT09TL1BWV1kxbjBoWGs5UGd3WEREMTNN?=
 =?utf-8?B?UlBqSCtoYStRZGllOGU4R29PUjJMN0VUaVFCbmMyb29uZzFVSEttY3Q2YVhn?=
 =?utf-8?B?eithSEJxMndOOEUyNFVseHhkWFE4dEdudUJRdVgxRFdUNXZOTmhhVFVNN01t?=
 =?utf-8?B?dkF0OUFtUGZhdXVTU2RkNGh0TEFxTU15bk9qaE9JWmprd1RJNTJ6dk1uMEZO?=
 =?utf-8?B?VklsV2VHbjZ0dGhaSTFqTEZqTWp0Y0t1bUJja20yVFFNYUVOalBqSjk3a2dN?=
 =?utf-8?B?THpvb0dHYWwybzhjamRyVVdwY2wwb3UrdWt4bGN2QWRMQmNUSHpMVmlySEZh?=
 =?utf-8?B?c3kybmRUY1l2c2lSOWlDOUFOUlVWL1lsVHM0VlVvWlpha1I4NVZpV0UrbXVn?=
 =?utf-8?B?Mm9ta2g5Z3RaUnQxOEQwdE5XVUNSOTA3ekNXYWVFd25YOTJuUTM2NU5haTJD?=
 =?utf-8?B?Tkc4SC8yTVN3QTlSZlpoQ2VhODhOb1gxZDJrMFlObzhzMnBSNmlnN1ZRL2xk?=
 =?utf-8?B?QUpEdEZIeWRYVjZGSzJmeTFHZkpQUTZMNjNReTRSVkx6aDdQOUY0VFhjSm00?=
 =?utf-8?B?bXFDZ2NUR014OHUrbVlLYUdvZDdFN2xoQXNwOE5UaVg5dzh2OXA5RnBSOWpD?=
 =?utf-8?B?bjR2Rnh1akEyUVZQU3Y0c2wzaGpkdUZxOGFlS05CeWNENjVxUWsvTUsxb21D?=
 =?utf-8?B?MnF6VXR2eG0zWTNrakIzWC9jbUx1eHc0UWxBaXlkZ2s2WmdieVdZaVdCZW02?=
 =?utf-8?B?UnZvWVJ0cEp3Q0RaeXZtcm8rUXljRWJnTDAwSk1iYkpvNzgrVXA4NmV6RVBu?=
 =?utf-8?B?cHk0dXB3NU9hcGZZSmE2YVk3S2psbU5DdVE1c3hkNkx3dDJkTlNvWnI3TC9W?=
 =?utf-8?B?dlc1eVhtTXhuWDlNT2xBakJ5YU96S25uNTNlT1pUYWZCNHUvSzVmbk9LOU8w?=
 =?utf-8?B?VzJ3Ylh2R3JNUWVpTFJSWDNVbnJXeVBxRHhEMUEvVHBhWkpqa0RnZzczMUFK?=
 =?utf-8?B?S2FnaGpqMEMwKzltN0NEc2g5RENScXhFVDdyOTJZaUlwU0JsNGZhM1NmUjUx?=
 =?utf-8?B?aDN5dFJxNTl5azJMWWlENCtObjBFa3M0NEhhREQxU2kwd2xHYnRiYzV5REc3?=
 =?utf-8?B?RUs1TDFzc0hxVEFLcGp3YkZqamROU2diREVPa3JKZnpvZHRUWEZpbU1YTC85?=
 =?utf-8?B?a1JVbTEwOVZXNkphYkFFekcxSjZVdHNRalE0RXRZU2NWeTJmYnd5cysydlJO?=
 =?utf-8?B?a2pIaEFrNXk4MTFQTFpaTEJ0L1AvTXZuK3dRcnJRWmlyL0Zud0pJWmVSMFNJ?=
 =?utf-8?B?UXZHYkhsa25JUTBxUVE0U04wMUs3ZXpqZ0FkNnNGUEFOeW9RVk9jUDJZTDhF?=
 =?utf-8?B?bzljdDVTSnJna3MrZlNwSVF2NXg2K2pLdzQ2VkFoZ3hic0JpdVhsbmh6Nlhi?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C71926E90EB74E429E4F590E4220D041@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0ARRfweS1XVGPoyPvci5+cZiDtdD9qsltWfHMQeBlNaBlHo+DZZDd+oyPm1ERHRUQfQZRPU0NCj3Po7jFFvg6+zJNxizHevC7pAuDg+IpgsOPBujcw9N2sleDHjd2K1/CUts71VarA2mcoZBzTcfSwaKsqmFyvNgj/1eBrX6qwu9DguVCZzDzQ80DdNtKy60XpA8ZU0fGYvSmB6bdOhodEyxTSD9uKZLlL9+kADJRDD/yqBtYyBXpW6t7FrdAxfA0c8MGKa3WHDqiYVhjD3hUeqosFgFLsOc7w9CL3GlfbOhp3lwtMzcirCOhJqqFX6HuJqj0K1VP7AVaGVLU85Vl8BlkqsSnTDq261Yes1urKt1E5tpLwXeeb5mSBN3Wk83UsbqpZAfKq/MB2OYeIIY0G+/5E8wt0P/5UgTIsEltg7LSimvDsQjawuNymjKLCFB+AXn3cBokRJG8wGuuySlGDUmxfE+oRhqVq9EDRnjzdzARxpidJvP4cdmznYUDnRBR+DBCik7oL7AM5Jhrv37Pqcm7eJgeR3tsfOzFfTNA3pwjgy2mhzUpiy2Db7lcYHssAvgPvG7sBSb9IV9aH1oy6Zj9Hy6p3s3fh+KYxIe7Nv/aVqVWsK3JDErinYN2QSbH6EcB3X/B3Sg6Xr4Viirzg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d071c664-db90-4c9c-3b4c-08dcbcbdc744
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 00:04:05.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncOpG8EI9yjlgTK8wnWBr30RcITUGHwdWH2uvfgGJG0NCJ1zGFoWaBZWtYmEuhc0j4QRCIyhffSbfjXQ5+o9pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012
X-Proofpoint-GUID: v5u6vHGY0uUsyzcd9kj24el5RAHFft-B
X-Proofpoint-ORIG-GUID: v5u6vHGY0uUsyzcd9kj24el5RAHFft-B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_20,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140167

T24gV2VkLCBBdWcgMTQsIDIwMjQsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiANCj4gT24g
OC8xNC8yMDI0IDQ6NDcgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBTYXQsIEF1ZyAx
MCwgMjAyNCwgU2VsdmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4+IE9uIDgvMTAvMjAyNCA0OjU4
IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4+PiBPbiBUaHUsIEF1ZyAwOCwgMjAyNCwgU2Vs
dmFyYXN1IEdhbmVzYW4gd3JvdGU6DQo+ID4+Pj4gVGhpcyBjb21taXQgYWRkcmVzc2VzIGFuIGlz
c3VlIHdoZXJlIHRoZSBVU0IgY29yZSBjb3VsZCBhY2Nlc3MgYW4NCj4gPj4+PiBpbnZhbGlkIGV2
ZW50IGJ1ZmZlciBhZGRyZXNzIGR1cmluZyBydW50aW1lIHN1c3BlbmQsIHBvdGVudGlhbGx5IGNh
dXNpbmcNCj4gPj4+PiBTTU1VIGZhdWx0cyBhbmQgb3RoZXIgbWVtb3J5IGlzc3Vlcy4gVGhlIHBy
b2JsZW0gYXJpc2VzIGZyb20gdGhlDQo+ID4+Pj4gZm9sbG93aW5nIHNlcXVlbmNlLg0KPiA+Pj4+
ICAgICAgICAgICAxLiBJbiBkd2MzX2dhZGdldF9zdXNwZW5kLCB0aGVyZSBpcyBhIGNoYW5jZSBv
ZiBhIHRpbWVvdXQgd2hlbg0KPiA+Pj4+ICAgICAgICAgICBtb3ZpbmcgdGhlIFVTQiBjb3JlIHRv
IHRoZSBoYWx0IHN0YXRlIGFmdGVyIGNsZWFyaW5nIHRoZQ0KPiA+Pj4+ICAgICAgICAgICBydW4v
c3RvcCBiaXQgYnkgc29mdHdhcmUuDQo+ID4+Pj4gICAgICAgICAgIDIuIEluIGR3YzNfY29yZV9l
eGl0LCB0aGUgZXZlbnQgYnVmZmVyIGlzIGNsZWFyZWQgcmVnYXJkbGVzcyBvZg0KPiA+Pj4+ICAg
ICAgICAgICB0aGUgVVNCIGNvcmUncyBzdGF0dXMsIHdoaWNoIG1heSBsZWFkIHRvIGFuIFNNTVUg
ZmF1bHRzIGFuZA0KPiA+Pj4gVGhpcyBpcyBhIHdvcmthcm91bmQgdG8geW91ciBzcGVjaWZpYyBz
ZXR1cCBiZWhhdmlvci4gUGxlYXNlIGRvY3VtZW50IGluDQo+ID4+PiB0aGUgY29tbWl0IG1lc3Nh
Z2Ugd2hpY2ggcGxhdGZvcm1zIGFyZSBpbXBhY3RlZC4NCj4gPj4gUGxlYXNlIGNvcnJlY3QgbWUg
aWYgaSBhbSB3cm9uZy4gSSBkb250IHRoaW5rIHRoaXMgd29ya2Fyb3VuZCBvbmx5DQo+ID4+IGFw
cGxpY2FibGUgb3VyIHNwZWNpZmljIHNldHVwLiBJdCBjb3VsZCBiZSBhIGNvbW1vbiBpc3N1ZSBh
Y3Jvc3MgYWxsDQo+ID4+IG90aGVyIHZlbmRvciBwbGF0Zm9ybXMsIGFuZCBpdCdzIHJlcXVpcmVk
IHRvIG11c3QgY2hlY2sgdGhlIGNvbnRyb2xsZXINCj4gPj4gc3RhdHVzIGJlZm9yZSBjbGVhciB0
aGUgZXZlbnQgYnVmZmVycyBhZGRyZXNzLsKgIFdoYXQgeW91IHRoaW5rIGlzIGl0DQo+ID4+IHJl
YWxseSByZXF1aXJlZCB0byBtZW50aW9uIHRoZSBwbGF0Zm9ybSBkZXRhaWxzIGluIGNvbW1pdCBt
ZXNzYWdlPw0KPiA+IEhvdyBjYW4gaXQgYmUgYSBjb21tb24gaXNzdWUsIHRoZSBzdXNwZW5kIHNl
cXVlbmNlIGhhc24ndCBjb21wbGV0ZWQgaW4NCj4gPiB0aGUgZHdjMyBkcml2ZXIgYnV0IHlldCB0
aGUgYnVmZmVyIGlzIG5vIGxvbmdlciBhY2Nlc3NpYmxlPyBBbHNvLCBhcyB5b3UNCj4gPiBub3Rl
ZCwgd2UgZG9uJ3Qga25vdyB0aGUgZXhhY3QgY29uZGl0aW9uIGZvciB0aGUgU01NVSBmYXVsdCwg
YW5kIHRoaXMNCj4gPiBpc24ndCByZXByb2R1Y2libGUgYWxsIHRoZSB0aW1lLg0KPiANCj4gQWdy
ZWUuIFdpbGwgdXBkYXRlIHBsYXRmb3JtIGRldGFpbCBpbiBuZXh0IHZlcnNpb24uDQo+ID4NCj4g
Pj4+PiAgICAgICAgICAgb3RoZXIgbWVtb3J5IGlzc3Vlcy4gaWYgdGhlIFVTQiBjb3JlIHRyaWVz
IHRvIGFjY2VzcyB0aGUgZXZlbnQNCj4gPj4+PiAgICAgICAgICAgYnVmZmVyIGFkZHJlc3MuDQo+
ID4+Pj4NCj4gPj4+PiBUbyBwcmV2ZW50IHRoaXMgaXNzdWUsIHRoaXMgY29tbWl0IGVuc3VyZXMg
dGhhdCB0aGUgZXZlbnQgYnVmZmVyIGFkZHJlc3MNCj4gPj4+PiBpcyBub3QgY2xlYXJlZCBieSBz
b2Z0d2FyZSAgd2hlbiB0aGUgVVNCIGNvcmUgaXMgYWN0aXZlIGR1cmluZyBydW50aW1lDQo+ID4+
Pj4gc3VzcGVuZCBieSBjaGVja2luZyBpdHMgc3RhdHVzIGJlZm9yZSBjbGVhcmluZyB0aGUgYnVm
ZmVyIGFkZHJlc3MuDQo+ID4+Pj4NCj4gPj4+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
PiA+Pj4gV2UgY2FuIGtlZXAgdGhlIHN0YWJsZSB0YWcsIGJ1dCB0aGVyZSdzIG5vIGlzc3VlIHdp
dGggdGhlIGNvbW1pdCBiZWxvdy4NCj4gPj4NCj4gPj4gQnkgbWlzdGFrZW4gSSBtZW50aW9uZWQg
d3JvbmcgY29tbWl0IElELiBUaGUgY29ycmVjdCBjb21taXQgaWQgd291bGQgYmUNCj4gPj4gNjYw
ZTliZGU3NGQ2OSAoInVzYjogZHdjMzogcmVtb3ZlIG51bV9ldmVudF9idWZmZXJzIikuDQo+ID4g
VGhlIGFib3ZlIGNvbW1pdCBpc24ndCB0aGUgaXNzdWUgZWl0aGVyLiBJZiBpdCBpcywgdGhlbiB0
aGUgcHJvYmxlbQ0KPiA+IHNob3VsZCBzdGlsbCBleGlzdCBwcmlvciB0byB0aGF0Lg0KPiANCj4g
DQo+IFRoaXMgaXNzdWUgc3RpbGwgcGVyc2lzdHMgaW4gb2xkZXIga2VybmVscyAoNi4xLlgpIGFz
IHdlbGwuIFdlIGJlbGlldmVkIA0KPiB0aGF0IGl0IGNvdWxkIGJlIGEgY29tbW9uIGlzc3VlIGR1
ZSB0byB0aGUgbWlzc2luZyBjb25kaXRpb24gZm9yIA0KPiBjaGVja2luZyB0aGUgY29udHJvbGxl
ciBzdGF0dXMgaW4gdGhlIG1lbnRpb25lZCBjb21taXQgYWJvdmUuIFdlIHJlcXVpcmUgDQo+IHRo
aXMgZml4IGluIGFsbCBzdGFibGUga2VybmVsIGZvciB0aGUgRXh5bm9zIHBsYXRmb3JtLiBJcyBp
dCBmaW5lIHRvIA0KPiBvbmx5IG1lbnRpb24gdGhlICJDYyIgdGFnIGluIHRoaXMgY2FzZT8NCg0K
WW91IGNhbiBqdXN0IENjIHN0YWJsZSBhbmQgaW5kaWNhdGUgaG93IGZhciB5b3Ugd2FudCB0aGlz
IHRvIGJlDQpiYWNrcG9ydGVkLiBNYWtlIHN1cmUgdG8gbm90ZSB0aGF0IHRoaXMgY2hhbmdlIHJl
c29sdmVzIGEgaGFyZHdhcmUNCnF1aXJrLg0KDQplLmcuDQpDYzogc3RhYmxlIDxzdGFibGVAa2Vy
bmVsLm9yZz4gIyA2LjEueA0KDQpCUiwNClRoaW5o

