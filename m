Return-Path: <stable+bounces-76103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF48197879F
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF741F25E83
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 18:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A256126C1E;
	Fri, 13 Sep 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PUMbthpC";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RF1MruVT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PWk9jR5s"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C079B8E;
	Fri, 13 Sep 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726251190; cv=fail; b=M6BPYOZd5P5BgMqIdHaQVbvEpfMkJsjJblVLxtuThTrY/F8Qiv83S9YaxfnULA5c4q5coIp7NOPr9rZlRMBSNRiw5ia3JbqmKjkwTzIPDUOP9JJyTltQHtKaxFMHiQe8kdpOfl/IAWU9bWaBAjgoZy+JDTOzda0mxSNJDMvJQlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726251190; c=relaxed/simple;
	bh=tvoQKj752mIvOWtEPTZGW2wHhlVQoVYEkVdhr/01bMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rJkBitxb/psZo8VJ6t7MqOnoWJy5Qb7sD5gZXM7cYAxL1/LK9LSsadnSjec1oHjJrlmaDSlL7pl8CsFA9J4LR6vNtH9mRirN7qibG/9wiFLhW6skneAyarFvU78dO3WQcYuG7XTFSxjB6ZwzeY6UTTPr4zmyhWJ7/MMzDgp/fRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PUMbthpC; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RF1MruVT; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PWk9jR5s reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFwRDO014411;
	Fri, 13 Sep 2024 11:12:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=tvoQKj752mIvOWtEPTZGW2wHhlVQoVYEkVdhr/01bMI=; b=
	PUMbthpC3/QyUhNiKw55/dUyTijq0NMYvCKpvDh+ZSCbb+XGBiDZM75adPiaHkpO
	Hb6vi2qb3zJODMenoSEhBCyyVUVN01Twj2XC7maVLv+wYzVH4Z69smP3y8HiCY2e
	sXM88nD7bWSmtPisYDz7gCvhXJ9uJ2j3FryAfsqGq0w41zmBATww1/ICSmcFFYEz
	BU5yAAwvL7PomsLeYKGjG1h6AGlfKQTEIu/2vfMA6dxx9SEUkUvrMlbxFSDop0lb
	u0MNjsHVeBae1p0KbdSTRH0VmAZhpp9YV2+QaC6okJyI1+UzTdJEZ/WKzqGD2coZ
	MMy1+hrQeTNXDbdPDwPAQw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 41gybcjrh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1726251178; bh=tvoQKj752mIvOWtEPTZGW2wHhlVQoVYEkVdhr/01bMI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=RF1MruVTIJBrNaohQgwpi4CJTMOapP2r5h6OAnKNaJPuVw/ljKo5/+Ce33nbNx6zd
	 fwJpi8wl7c3RA8d2G6wg2TRkEbF/7ySIWsn7alvVta/CTxMSRpeFrrRaTnBK0walg1
	 oDDK08lVc6pYwQ0dUiDuPS+tdmTSqlUBXiyUSO2GtMbLaw4iGFhX5rhSoUfHMBVb6F
	 lMo6/Q03ZIfrBungNPEdcB4L5Y++bxQweR11J1DqmNE4ip/86ckt5rBmhDOl/N/cge
	 UQ9JU7VF1N0xVANc+lNvermAIF6Ft/ujjMubru8vv7PmmcjTVh6MD89/4xSRQiD3op
	 DIUJzaRWnV9EA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B21C040521;
	Fri, 13 Sep 2024 18:12:57 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 330AFA006D;
	Fri, 13 Sep 2024 18:12:57 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PWk9jR5s;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6834440236;
	Fri, 13 Sep 2024 18:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqYhjjI4TAMbExxWp4CB/9w2hnBgK+1Kgk/0cEAcKRtH9cb6WQzdcaw6fVkRaHBd7PbgjaTRTLgnJHoX2l8xDfZ+NMZoIY77ydrI54IVfVyZx3+WdUjRFRMMeSqjdn3dD975MF/h+bTQ0+95FwsV6wYRYYCm1BbGWkMiQ6JvCiDRqGTIW8OeWIx7LKham4NPpeAnfL+pDkQYGH6sFFxw2wGKq6S2l3Qan0qaj1Fw43hUWLy9IcVJIDfj9jtSEiVfJg0D3pEuBzwBvFiKbY70rBZHylewqU55wTqKI4fcZsikxkSpDgv4QdtvKCRxQ4uC9DhmNnpuPvbtJPBjwKmQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvoQKj752mIvOWtEPTZGW2wHhlVQoVYEkVdhr/01bMI=;
 b=n6n3fVJiKVXOWSGLx3s4LJZr0yVWN6WmoS5oCXqpGWt8m/igU79IpjVPYPB9oVauCYInRIUVgdw24/RNUciMRsJYcPAtlsakglyKJocjsLRG2VdA7UslxYoCRXS6yd/eRIlmXP/ekM4hDPH69aXpmLLyDKppiT5uS08/08+87Sd1NL1ELZu0swqS8A9PKt0GJEljlDbss6KshwLRGl6Cj8QksbhVfjaZGfhiGf90RmTOYZE+RRARqeu5lfZXVRjfp2+JVrXJUAcno1h65ZY4u4EcjFg+PkZBMc26jw0SYEbG9U/vGodr4w9FzVcewd8D9b9LEKr/6Tiz3/d1I+unVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvoQKj752mIvOWtEPTZGW2wHhlVQoVYEkVdhr/01bMI=;
 b=PWk9jR5snsqYrqec8FMkABUg3BFPoBMsRQevh6e+w3kG/3ehkOkFvavlS2QcqOaY4oBAOLFbQuatFosXpApGBI8HVmzyUwwu3BCWjaFPETrPa6N0InbcIddKXlKm8fwsMHeEgI+yIEVeQbBIDzDap9uF3ZAxcCBSSgJUHS8xBpE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB8312.namprd12.prod.outlook.com (2603:10b6:208:3fc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 18:12:53 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 18:12:52 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roy Luo <royluo@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "badhri@google.com" <badhri@google.com>,
        "frank.wang@rock-chips.com" <frank.wang@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1] usb: dwc3: re-enable runtime PM after failed resume
Thread-Topic: [PATCH v1] usb: dwc3: re-enable runtime PM after failed resume
Thread-Index: AQHa//fY6wNHWEvagUmr/yz5/gCG+rJLgiqAgAqMFYCAAALogA==
Date: Fri, 13 Sep 2024 18:12:52 +0000
Message-ID: <20240913181251.3upf6zme2j2mobv3@synopsys.com>
References: <20240906005803.1824339-1-royluo@google.com>
 <20240907005829.ldaspnspaegq5m4t@synopsys.com>
 <CA+zupgxMefawABGDkpRy9XmWJ5S50H1U9AF9V3UqX2b5G3pj-Q@mail.gmail.com>
In-Reply-To:
 <CA+zupgxMefawABGDkpRy9XmWJ5S50H1U9AF9V3UqX2b5G3pj-Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB8312:EE_
x-ms-office365-filtering-correlation-id: c2f7cb84-5017-403e-4389-08dcd41faf29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXlNOStPQjAzSG8zOW02QlBsNjBlR3dvM01lYmxETVVWaWgvcEhIdG56WXMw?=
 =?utf-8?B?NUZIaDQzblRsL20rdTBBOWJvZUp2NndVaS9PR2k4V3BEV2dVRHJoVnQ2amZy?=
 =?utf-8?B?VnpoZnhPRVd0RmVBbHdBMUJNd0p2Y2ZEU1ZmbXM2UjVxQVd2WVRXeVIzYm1C?=
 =?utf-8?B?T0tzeitEOTNIWkFpQW1icmlqRWxqd3JxOUdQc25JdnJEbS8zRXBKS1JhL2xI?=
 =?utf-8?B?M1hKa3BpUVZMUU1lUjVTV1BWYUNyUzJxUW5WTkdMcjFHTDNjeFNFdHFWQTVI?=
 =?utf-8?B?S2RrUGJOU0dSdUM1c0NObkU4aDFFTFZxQ1RFdHJFZWE1MmRUa1JnWEJWTUtP?=
 =?utf-8?B?MzRLdjdkejdXNDJxWUtoS3pzWlU2d0NqVHFyMzZ1NnlpRkNnaGxLWVpmenpW?=
 =?utf-8?B?UEprRVlTQ1dlNWEzSXEwcGYzR3pqeEc4WmJ0WEVoRXpqRHZGaVpiQ3NkL0g4?=
 =?utf-8?B?UGdOTGh2SldMZVdtMkNxdnI1Zm9GVzQ4aTE2RTl6aytBK2dlV1VmQlM5QW12?=
 =?utf-8?B?MXh5Y1BRMUFlYjVuRUZObXVmbzRsZ0FNbTJNT1ZoaEtYVEttMEJvRFlEQjVE?=
 =?utf-8?B?M1VXMm5lYTExWS9Pd05zVjkyM05nZmFodGdEbVBZQkRTNkJaa3V0RFBEYlZ2?=
 =?utf-8?B?TnZHbWU4RzdxRGVBakZtS2lvU0poRUQrdFRJS1BQbVpadENHdUZiblEyM2lW?=
 =?utf-8?B?NWxtVjNVT2RHOWRydjFqTTg3a2Q2Q3VaODRQYXFnNWc3VjFkZnFIakdlUHNi?=
 =?utf-8?B?cHJOQXRSRDRSbW0vdTEyb0R3cGlrbVZFMVA2VGlLMWgwNktyZkR0RDE2dmdU?=
 =?utf-8?B?K2lQQk1hVHFMNXVOOUVuUTZBYVdRS2ptN2FiY01qUFBValBpOHEreGdabmVV?=
 =?utf-8?B?SVlyYWVqb0gyVXNuUzNuUEhqZndyY2c2ZjZQTTVLMlppVXVmZ3pBVjlIdXlX?=
 =?utf-8?B?OEVLeWVXNHhMYkwya3dRWGt3cWZtOGdIemxtMnlXWVdkY3h0dTJKRGpNS0JF?=
 =?utf-8?B?eWF2UmkvNFd2cXo2b2NzYTZNUFJVaVdXYitQU3JVTHVTQnB4WWVEZjhZc0Jh?=
 =?utf-8?B?ZEtyUk5YbHIzNXdibG52MU9RN0w1OS9nUW4zOVdLQXpIWkFJNGwzVVRZd3Fm?=
 =?utf-8?B?SVBwbGlxMjY3K29zOWJhMDNhUW9KSUhPdXp2VXphQU1TMXRxVGNLNnMwbzhE?=
 =?utf-8?B?R29IcHNXNjA1RGJzcENDQ2dmd1RIVW8xaDAwYTZBZWt4RnVjOWtBZXNkNUNh?=
 =?utf-8?B?UXQ1K2RWUTlPWUxsQUdyVWhRbXVoRVJrWDl5UmZRbHpNOGQ5aldqd2ZSVEdk?=
 =?utf-8?B?NUlLbkpKbkNKTUIzd01zWVduSzRSaWlwQ2U1bGxMVjlvNGpWa2QyZnUzMSt1?=
 =?utf-8?B?aTBoL2xjUTduQTN6K215QXJRT3pTdTQrSlk4L3licnpkUTFoWDJ3VVNYRXVF?=
 =?utf-8?B?ZFVtcmNYdEpZRm0zNFNyTDB0dmgzb0FpbGtYZTdMdTdFNHVrT2Q5dG1RZFBP?=
 =?utf-8?B?cVNCd09rRTA2WDF4cjczV1BBRDRVMWhqbC83TE5Qa1RsMGRXbUFBdytxcFpw?=
 =?utf-8?B?WmxYYThXTzBibzU5VHIzK3IwWmcyOE1rbVBidy9rOFhoeVRISDdJY09wV0E1?=
 =?utf-8?B?K01RdTFTNVJLTG1PY0lHY1BnWWVIRks5eElYRmFxd2xsaE95S1lkZ2tOODJI?=
 =?utf-8?B?RUlsbU1BeFltRzV6RnJJTnpGa2w4dmlkTk1hSDY1ZEgvQnBObHJPVGRNK3Fs?=
 =?utf-8?B?RzN3Q2kxd3lVcEZkbW1ONGoxOUpEOHRaK21CbFlaZnFvUlVtMFFhdjhtWENK?=
 =?utf-8?B?eHRvZXlvZDVYWnNBUUtEczlzUHFsNzNGVjArVGhiMlZWRStnNDRIQW1maUh3?=
 =?utf-8?B?SUtWOHNhODJudm9rSFpxS1F0bFNkNGNXTVRFNXdNMnVxYmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dk5xU1FBRm5YdHBIY09WempBWG9DRGxQRFFXclZmdU5RS2NCMEhGZG9iTFNR?=
 =?utf-8?B?Mm1tcVVwdm5jWkoydTN3UlJSbVBkUkh5M1JsUWg0clhPRi9XWGJGVWVqREFT?=
 =?utf-8?B?cGdHVVpvbE5MK3lQM1AvWjMyOGVYUHQrUElOaHMzM1ZnT0dwU1JhcU0vdGhk?=
 =?utf-8?B?dkpTdlF3UlZCMlcrd2ZlTTFxSVRHYjI2SzBSckdIN1pBU2V2eVh5dHM1TS83?=
 =?utf-8?B?YmVLSnQwKzFXRzFGMkw0cVFEQWh1eFcvRTFuVzUrT1VwVWlwYXM4MGxZaWh0?=
 =?utf-8?B?Wk50ZzJrbVFpVFFpMmNvc0hYN2tDRnZXbEJZcWRKSTJ5WHduM3hFb051MUVl?=
 =?utf-8?B?U2UvVCttNXNtYjdxYVlRVkJNMmZLS1liMEIvUDd0aFMyVkdZWHdOVGFTdWNy?=
 =?utf-8?B?Ky95eER4b1U4OUhJczJOSEwyNU55bFdKNVdzRUw3SjlUbThvMzFDVUdianZG?=
 =?utf-8?B?UnY2V0pqY3NaTEJ1cm94YnYvYXAyM0VHNHF3bGxFa2k2ZGZrRGVCdmhaVkZZ?=
 =?utf-8?B?UnFpSy9hd3RUeXQxcU9oa0JqUXpyaVhOcHhEU1pzdW4xN3RyV3hxR0lLMEsw?=
 =?utf-8?B?bkk4dVowWWw2ckZpeXFVaXFtdkpkL0tQN0l1elZSZlQrT0tSa0dLR0w0ZjJn?=
 =?utf-8?B?eXl6UjFWOVhWL3VxVXBWRzJrWmg4UFVoaVAySTB4ZzJKdFU4WkpyUmxobTRp?=
 =?utf-8?B?NG51MkR0eXhvaDZyUXZRY1ZBa3p3Rml6Q3dCeDFZSzI2MDFNY3pXSG8xSEd2?=
 =?utf-8?B?bEwzUjBsaXF2ckF6U2NjZ1dBNlV4c3J3WTVyYTJBTUZCbkNKNWRUUEE3UDNa?=
 =?utf-8?B?bXJiRHJkVk50R1V2RVJBOHJtUkN3S3MzVkNrSE5VSDVVU2NmUW9SOXdRVDRS?=
 =?utf-8?B?OHpockZwS2JyUGllcDh3c20rYlVTK05ubFhwYjZRNUd4WXBWSEl1U0twd1py?=
 =?utf-8?B?a2krMGdja3VTcG1IM1NEU0EzMzdsTGpoZ0l4M044eVlQTkdYS1EvVlZLd1B0?=
 =?utf-8?B?R0VuS3FCWkc2cWhCYmhJWDhZVDhZWlFCZUlYWkF0SWoyYi9hakxFVDI0dCtP?=
 =?utf-8?B?ZTQ5NXlPbzZOS0p3SzFWTEZFVWxzRHQ0ejE4czd4QjkzYm44YlE1Q01ML090?=
 =?utf-8?B?Nlp1eC9tQzRHelJFVHVMb1pHUzh6YmdLTjNyYTJmQjJVbmViYS9MTTEvRWwv?=
 =?utf-8?B?dnlwVGEyY2JzTkUyRnVnUVRtbkpEdUZtSXNmRGlXVHFJNHh2aUR1RCt3RGJM?=
 =?utf-8?B?UStHTVR1akdkOW5qUytVeDRPWHZiWmxzejJpbHppOWtHU2NhRmZFM2Jqd0Rv?=
 =?utf-8?B?UnJsbzVhYStHeGpZWTM2MmZOaHRINUMrVlBJMklOMmljdWN6VFJYRVBMeVJi?=
 =?utf-8?B?eHJkQ09NZFEvdUJXL1RTVU5kODhxcm1CbjJROHl0YVFPVUpIaktxWVh2SnRI?=
 =?utf-8?B?c2tHZjlkbWU0Z01VL2FKVitvQyt0SHNoYlJJM1B5NEdic29XdmFmUzRqSTk4?=
 =?utf-8?B?UkhQbVRNaDFyZEdqaXhCUHFFVVVVQVVoTEh2Y3BHeSt0bEJGNFBqOEc2MVd1?=
 =?utf-8?B?a2J4NVhXQWsvVzhYMnVSSk5DUFFxUHFpVmE1b2pwdXZmejhmbG9jWEJlYUJG?=
 =?utf-8?B?elE5WDZTNy9YK0Y1ZFltYWI3am5zd3hBNmlTQnJ6RXRjUHVYU0lPM1pXTmxo?=
 =?utf-8?B?ZkJBK2x4R0pCdVJvVkxhSzdhUmJQTFBqbkxxNVI5WUJuMHRMSUFNUUlJMEZZ?=
 =?utf-8?B?VFRxNzg3QUtBTGpHZURpUUdIUGRoTkxYWWUrZVBqc0NNYzU4OEtrYTRCR3ZD?=
 =?utf-8?B?TEEvRHZhR2l0cmlFVi9QdU1PcDhCbzhueExKSFpsTzY5Y1FjV3VpaEp0NEtr?=
 =?utf-8?B?ZVpoYnRGV2o2TTFaOTU0Y1UzRlVyczZ6VnNVTzVuSEIrWVM0dHZpdnRlVm8x?=
 =?utf-8?B?ZXMyM2JBSUN3emdOZWhNNWFnT3ozSWJ4MUtnQ2tpOHc5ZnlQTWlTdW5zdmVD?=
 =?utf-8?B?ZHFPSkdWRE12M09YbGtKKzJzaGxDc1pEQkhuSGU0ajZkb2o4dkNYMHhYZmpF?=
 =?utf-8?B?Y09MK2lIQklxQmdmdldmSURBeEhsdm9vMVpQV1ArK3JieVFYVVpFRyttY2ho?=
 =?utf-8?Q?NUAzReOaVQDhmKLDTx+fIr6Dq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98BEC48090263E49910B238AA31145A3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1NWNh0Pf6el8MkV4aPVywbpvcY76L6TY3Vmo1vUX+y9Zk8K0UoWWnQi0X3WymrHT1A9FU3Lbiwj65ji3I1moiquAbhOuw3ty/tw5eWvTTDcxewqMSnYZ/72mKfxoTqhI+ro3jmH5qJ5X3Ob43SMtscnXj/wC10IWdQmC82xd9wKTnWIM1IhzqhypHSa6EDCI4ozS07mpZrMcS/mmh2SpZqESSDj6gu5H/T2c3pdSHpCUOdPCnqyrYGLyu49CZGMK3l8MobjuaN7AvDbxNjwqLVu6eQKQRhWsAB/tXCGm3ivlXkypB8Ddu7fBUO48oYtf1qYmYgB7BzDfWlJvIFol/A1l4hJz6h4as5xiRoSbHu1ID52EQBTMdDgQYRhF6p87flT+LHrxkGHXJxqV7DF5RN1dwPp4X51vEmLUsoVFKk26OQSbvPIvlKkni7DBHhrnWdrrbPlUcmiO77ppLZhoyC8KI+ki26207eC/Tb4UCGwEA25CE7WvfZFQp3OkQrf8ue10HpnmfEudQq2R8XwgT76YOg8wR9Q9JmAvZ8G37iFkxEdWLNpzCzJEOMlrtyVy8Bdnkys+fEPQ/dmoT1gATNM8RRItZpTYFdtwKfTnRzzyFbQOIqWjLFeyHQJhkA4TvjIyqOGOlklA9TCJXqnIiw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f7cb84-5017-403e-4389-08dcd41faf29
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 18:12:52.7343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ErvpuZ5jHqrl3Z0KwU+3izSa9Cu2XH63R641J6G0fR+eQlFU+B93EqdOrU/ifjmVjVoMa96ilDIvWjWmfQvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8312
X-Authority-Analysis: v=2.4 cv=Z+i+H2RA c=1 sm=1 tr=0 ts=66e480aa cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=jIQo8A4GAAAA:8 a=oFHC-UFn2i36fH7CH2sA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: TInEYoEorlo6ngnfXaJGlBUoxVHnwqUo
X-Proofpoint-GUID: TInEYoEorlo6ngnfXaJGlBUoxVHnwqUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 adultscore=0 mlxlogscore=302 spamscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130130

T24gRnJpLCBTZXAgMTMsIDIwMjQsIFJveSBMdW8gd3JvdGU6DQo+IE9uIEZyaSwgU2VwIDYsIDIw
MjQgYXQgNTo1OOKAr1BNIFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIFNlcCAwNiwgMjAyNCwgUm95IEx1byB3cm90ZToNCj4g
PiA+IFdoZW4gZHdjM19yZXN1bWVfY29tbW9uKCkgcmV0dXJucyBhbiBlcnJvciwgcnVudGltZSBw
bSBpcyBsZWZ0IGluDQo+ID4gPiBkaXNhYmxlZCBzdGF0ZSBpbiBkd2MzX3Jlc3VtZSgpLiBUaGUg
bmV4dCBkd2MzX3N1c3BlbmRfY29tbW9uKCkNCj4gPg0KPiA+IFdoYXQgaXNzdWUgZGlkIHlvdSBz
ZWUgd2hlbiBkd2MzX3N1c3BlbmRfY29tbW9uIGlzIG5vdCBza2lwcGVkPw0KPiANCj4gQXBvbG9n
aWVzIGZvciB0aGUgZGVsYXllZCByZXNwb25zZS4NCj4gDQo+IFRvIGFuc3dlciB5b3VyIHF1ZXN0
aW9uLCBpZiBkd2MzX3N1c3BlbmRfY29tbW9uKCkgaXNuJ3Qgc2tpcHBlZCwgaXQNCj4gY2FuIGxl
YWQgdG8gaXNzdWVzIGJlY2F1c2UgZHdjLT5kZXYgaXMgYWxyZWFkeSBpbiBhIHN1c3BlbmRlZCBz
dGF0ZS4NCj4gVGhpcyBjb3VsZCBtZWFuIGl0cyBwYXJlbnQgZGV2aWNlcyAobGlrZSB0aGUgcG93
ZXIgZG9tYWluIG9yIGdsdWUNCj4gZHJpdmVyKSBhcmUgYWxzbyBzdXNwZW5kZWQgYW5kIG1heSBo
YXZlIHJlbGVhc2VkIHJlc291cmNlcyB0aGF0IGR3Yw0KPiByZXF1aXJlcy4NCj4gQ29uc2VxdWVu
dGx5LCBjYWxsaW5nIGR3YzNfc3VzcGVuZF9jb21tb24oKSBpbiB0aGlzIHNpdHVhdGlvbiBjb3Vs
ZA0KPiByZXN1bHQgaW4gYXR0ZW1wdHMgdG8gYWNjZXNzIHVuY2xvY2tlZCBvciB1bnBvd2VyZWQg
cmVnaXN0ZXJzLg0KPiANCg0KQ2FuIHlvdSBpbmNsdWRlIHRoaXMgaW5mbyBpbiB0aGUgY29tbWl0
IG1lc3NhZ2U/DQoNCkFuZCB3aGlsZSBhdCBpdCwgY2FuIHlvdSBhbHNvIHVwZGF0ZSBtaW5vciBz
dHlsZSBjaGFuZ2UgdG8gcmVtb3ZlIHRoZQ0KYnJhY2tldHMgZm9yIHNpbmdsZSBsaW5lIGlmIHN0
YXRlbWVudCB0byB0aGlzOg0KDQogCXJldCA9IGR3YzNfcmVzdW1lX2NvbW1vbihkd2MsIFBNU0df
UkVTVU1FKTsNCiAJaWYgKHJldCkNCiAJCXBtX3J1bnRpbWVfc2V0X3N1c3BlbmRlZChkZXYpOw0K
DQpUaGFua3MsDQpUaGluaA==

