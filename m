Return-Path: <stable+bounces-73817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF8996FED2
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 02:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0EF2849EA
	for <lists+stable@lfdr.de>; Sat,  7 Sep 2024 00:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11379E5;
	Sat,  7 Sep 2024 00:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OuRbOaEf";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TFScI1Jf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SZTcMgh3"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE01F4C62;
	Sat,  7 Sep 2024 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725670734; cv=fail; b=kF2B64eERouFrPUJeXALJFZeer/kGGfHqrHgVkvKgxmaGylsX4sjx32d4Yxzxu+ni1qlLm1Y3u2ESjRJEjR29n4nfsx9LhG/9nBAgvQxjOLFb9iauGB+tXuwxS3Af3jQf8Ph7Ac2R6jihNnMedr1X9CTJDja62/d/EA6CW+uVbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725670734; c=relaxed/simple;
	bh=x/0/82wCoVduNdf9IgNwDjUcq7e4xVmb2Nl3ZnU4QxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3M+SqsRuncXujdYXk3C9VNkW76okYBva4+KNAc+4qDPdqpzIsVQpPyZR/dSqhKpdwk8sEd2aWU7eyOfUeiBOdvqPs5HWRzthDXDxzeHMkYknKCtXAeYdzr59so7j6LhFt93tgeCQdYlyWVkMD9wg44+X1HWyVh9QUGb8mRP4MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OuRbOaEf; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TFScI1Jf; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SZTcMgh3 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4870H3Yw002220;
	Fri, 6 Sep 2024 17:58:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=x/0/82wCoVduNdf9IgNwDjUcq7e4xVmb2Nl3ZnU4QxM=; b=
	OuRbOaEf9FDi8ATdPW4lE/GGYplGGh0ne7UE9LU7H45N1gDokdHokDnq5B2Tz7Nt
	eK1YmLO+b9mewDtPLzKenaBpPjVisbpPfoEe6lD4ctuZz9HATktrjXprkvXqMVqK
	eUctCDiuF57jrmULGqlX11prKFa/9wbXf46Z4RAi/Xq09brvdsR/wPlKwLGFjkb8
	f0owX+YKuJo3tFeuiLERIlW6HQULjgzoV+GzUU1LX61zkzTp7QuCpMweMrJKeCQl
	BlZIIJn4Oqlc/i9ur6ZVbFcYg8eS20SBLZPqGwkSR/aETApF3Hlx8vpRfHzcMgfR
	jcVuHW5gzvk/YHyPGLJ5kw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 41fhxtep09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 17:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1725670720; bh=x/0/82wCoVduNdf9IgNwDjUcq7e4xVmb2Nl3ZnU4QxM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TFScI1Jf+8rlworG5HxgTw22uLkwY1Tqp2rHCBeLU75OXPfGyk/mPQDX5m37Ha+Q7
	 koNg/z5wNRFcXj+R1BJj2ss/omp9ayghv7loJmcQJrEMJooXarQJjzLyqRH1q27Ddk
	 n89ueIsv/+sJRgCsJnRHGjfy1zm3oPbr+mVp6S7eAgDlQMSnwoDZ7WQF50l5WwtpBW
	 4H0hs2liYMM/UCF13zyadKNJ2IgzPDEx2xp4MsO16hw18h9x945rM5IrT8ho2zu9It
	 qBLCdBUFMr435JouQZG1UWVMuQI+OHSwXqWOiMfur73Cjebz97Pm4jnFzlXll1AE3F
	 qQTnhUSATUDuw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0D90A4045D;
	Sat,  7 Sep 2024 00:58:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 74620A009D;
	Sat,  7 Sep 2024 00:58:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=SZTcMgh3;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 93CC440354;
	Sat,  7 Sep 2024 00:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRLaTvxtPqp2CXtj+rUuFkdGhyYMHgZ+mhpW0kj90Nl1VM5g4o1EfC6DiGuQ0LjnkXOSfxKDKKXOrouMUtNFAnicHI/iMQ7Vz5f9Lju5CAUQih2YZOygvGvuOmMH2AZAZ/lA1XfaOYmytF91GKYBSrPp6rA6BY8u/c7D6MZ/His/Ra5w03oYCXTriJ4iSBHL5YF7LIt/u5ec7OlAtsBiivZWMRkIOeyOTPV8aIyVezbE+lX6vcVRVVi6MiX7mm1FTXSvEYdRkf1Op5eNBviaNFVGQDzuyOctT1SJSJmtaiQNP9gqo/osG0j9fmzGiOaMAZWmkFgKMPv+emf6RRrdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/0/82wCoVduNdf9IgNwDjUcq7e4xVmb2Nl3ZnU4QxM=;
 b=sruLhpmSdbzNhKoJzkTqxUoK/wm7Msw/MC/5NVDAg30pFkOH4LiuIdxndxSYffh+qTViG3HG7U9nhzceEcFzMKeghj6u7HOicwzmn2KViL21V8QZP7K+ikaWC9DuJC4WHiykdINp5rT/lh8Hn6/YadfU1LwOjQPqgFFdBUGPqFOUKQiFOzaeUKr2KQN1DTcZmjtbTUQQxXu1C6QNNQr8iGHrVlzNdrPfm/xanf44mqPnplKZvcFWYaRfQivtAfTqt7Qp681LfvcYdyxX7nxo3CV4YyIZ9IOAHjQqab0GXc09NYW0Q06uRFhJozcbvVFCMtzXFzXJmGH5qOgnSxJQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/0/82wCoVduNdf9IgNwDjUcq7e4xVmb2Nl3ZnU4QxM=;
 b=SZTcMgh3zyhrJEyfGMsnY7SI/HQY1AfK5zydXLlj7A0RGielO8jPYCFM7Oqd/pnx8dTYD+Sj6lnMoHEKumvuqOjBOWH5K43IK1kJbkQp1/s2CVE8G/IK3IST831jgTZNqSAU3BIVn0z2pWJqXsZsdHurvo0QI8tsNZDZhEq99e0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 00:58:35 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7939.017; Sat, 7 Sep 2024
 00:58:35 +0000
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
Thread-Index: AQHa//fY6wNHWEvagUmr/yz5/gCG+rJLgiqA
Date: Sat, 7 Sep 2024 00:58:35 +0000
Message-ID: <20240907005829.ldaspnspaegq5m4t@synopsys.com>
References: <20240906005803.1824339-1-royluo@google.com>
In-Reply-To: <20240906005803.1824339-1-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB7821:EE_
x-ms-office365-filtering-correlation-id: d2bf8fc5-44f8-4eb8-7564-08dcced83381
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXFmL01lUTFBRVlNbGdKaVJIcnUyQ05XODVyOFgySFhraW5XbFVTclRoODJ6?=
 =?utf-8?B?Mk0xUVlwTWs0UDU4SVAyTFhSZVhPWm1GVmlZSFd5bUZDV2k4VWoyZE94cUhp?=
 =?utf-8?B?OUdmbWpBWVFPYjFhRVV4M0J6bWVselZDQWlaM1FxVXpPdTFZMkhET1VNRHNE?=
 =?utf-8?B?aGRIUEtuVWhjOG9OYVV5WGNSU1pYQmEwbEU3cFBHQTlCdnU4N0tSOWdkdGNo?=
 =?utf-8?B?V0cxakxtZldlRE05dzl6am5Pd0VYZGZJNElaRzJFUjRzNFNFbWhjZFJaZURN?=
 =?utf-8?B?QjdTL3hrcnE3dU9TOWpBUk1Ebk9QV2UydzFBMVEyZkJvSFo0YjZrZ0w2YnBu?=
 =?utf-8?B?c0tKK1NRSE9HYUlLbXZTTzFvaEFzZHltWm8xT2EzbnlOTS9WMGwvVENyZEhP?=
 =?utf-8?B?S00vQjVEOVhWcGVFcmhRSjVSRUE3ZkxzYU5QdExWZkxUbXhoSVdiS1k5elJ4?=
 =?utf-8?B?czd0NVN4QzVVZG5KTVMwSlZHblY2OVNLcGd5dmkzeWVFN2dzejdPTVlQbzJL?=
 =?utf-8?B?UmFFenpubWczSGsrNWxmUXZxZlp3RkpkY3hBK040N3hyM1FQV3FKNnpIWExT?=
 =?utf-8?B?Z2Y1ZmZiRUpucEJnSW5DTXRsd2hvTlVQQU12T3R3TlJxVzhYVWs2VWpkdWc0?=
 =?utf-8?B?a3JrK3Y3Q0plZ04zUWF6ck9JUHdDZlRXRS9JWHlCZHM4VEEyakNLN1NQeHZC?=
 =?utf-8?B?OFY5b3RoeTdVYTdZTDc1T2srOXFLOTdnRTcvUGNQTnNBTHFSc25Hdnpkck9B?=
 =?utf-8?B?MmlVTGNhUjVHYTZ2SVNkN1liOGlvTGRROUVkWWpNdjBlR1JiYW1RRHNDYnh4?=
 =?utf-8?B?RmNoZkl4cE8xQmpiUHM2TlZGcm9FN25XRU8zSDFocGhpUUp1cDFWajFMUGRw?=
 =?utf-8?B?ZFJyZURDV29ORzBmUEFmd21qVzJNdi91c3JGWVFXRWNjZHlhUC9zcFY4eHpj?=
 =?utf-8?B?RXU4eFBoN2YzYTB5QXNkMm00WTJGSmwycThTTTZybHpWMHRYcStQNjdCMzdq?=
 =?utf-8?B?TVdLM2VEb3lDNjg0dFlVTFkyNFg5OGp1YmJ0MGNxQmZ2RFIxV3BzZUhoTHJk?=
 =?utf-8?B?bkZiTDg3MXdsbEIzWnhuZ21EZ1p3NnNoS28wdlpQUERJbU80cGJwayt5Rms2?=
 =?utf-8?B?elg4MVJmVy9kd3QzN0djYWZreWJvL2xITysrOXpRRXkxdFQwdVdFNnBNSVZm?=
 =?utf-8?B?bFdMeU4vb1lmK3lQSkZUYjhZem9CU2h3dnpVdXdpVThTMk1ISThFSGplOXRl?=
 =?utf-8?B?NVhXMFBqOE5nZkgrQTBIY3JseW5ObnZscnpnNm5Cb1VDdktKYmJ2NjBVSkV5?=
 =?utf-8?B?NnNGeUlTZG9wTFh4UXl4THNkRGRXTEdDVHYwV2EwcGRGRUpPWVJnZHNTT3FO?=
 =?utf-8?B?KzlhTU1RbG5YZFNKOVRTcDlMQVJCUUtkN1ZTcGRlSTlFR0pMNjk5dzJFQ3ZZ?=
 =?utf-8?B?N3VCamFqUjlKUHNRZ0dMcVE4Rmo2azFtMHJtTXI3dWJzcytHV2ZXYTR4ak9l?=
 =?utf-8?B?R05Ca1FLQk1IMGgyQm95TkI5Ykg5QktBWFZuaFZFRmVRdlMyTnJHWVZZKy8v?=
 =?utf-8?B?VnlHOFFSdkg1SmE5Z3ZwckdJZkt6b2J2c2s0eUtIRkoxdm5TSTBaZHFmNExT?=
 =?utf-8?B?bFpsbnEraU4vMENEOWpEamNmYkt5eisvMVE1MlZoV3cvZEVkeHphZEM4Wkg4?=
 =?utf-8?B?eEpxWGZCMi9iS2xqTGxURUpXa1l0dkh4RU5oWVZYSlB1bFJrTk10cjJYaGlW?=
 =?utf-8?B?dlhyWTJ5OHBvV29rdXBRN3lPeXgrbjl1V2U3d3N5OXFzTHJxU1B2YU9SVXZR?=
 =?utf-8?B?cnp3VE81RlFNem5MWUsybk95RStLOStMNWlvYWFaWWpRWlBkT2ZwYU1vTzYw?=
 =?utf-8?B?SWZkOFdBdEp2RjBBanFWVDlNZ1dzczBnMWFCSExBRVlFM2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTB4ZFFGTEF6bWhqejRVN0VZM3J1NTZBMHNYRmJrMmJkQXpVUlp1d3pIY2FS?=
 =?utf-8?B?MVVia2RqWDRDeHovMVphaWE3ejJXVDY0WW8rbWNmSHhzcmhjUUNGL1hWUkcv?=
 =?utf-8?B?eHlsUUREOVcrWnhhNGwyMVdDMjlVM2tocytaN3MwanRtTlF0ajBJaTN4ZVVM?=
 =?utf-8?B?RitmUXBSMGZ3bDRWTnUrSGYxcUJCdWYzNUE5T1NnMElST3FTRkM2aWl3aUhK?=
 =?utf-8?B?Q3Q1N1BpVk1ScnVWc1Boc0tOcU9HbTZSSTEwREQ2Ykw4SkpCWGJvMUxONGdW?=
 =?utf-8?B?Yml2NHZRMGJZQ0kzU2o4K3VMMUl2NVc1WlU1UVhRRHd3b2F0RWUwS1JhWDc3?=
 =?utf-8?B?Y1pGVzdkVFB6TlVPQVFpY3NSaUYwVUxhb1VNdjQraitQL2N3dlN6SDBsVFht?=
 =?utf-8?B?ZytxaDZlU0l4MndDWDF4VzBrUkVlMEVON2IwUjNwVzZVbjV0Z01GZ1ltNEhy?=
 =?utf-8?B?ZWJtaTZYcy9mVWE3TjBnOXZDN2YxWTBaNElwTEM3blZxVW5Oa0h1L04yMlNX?=
 =?utf-8?B?R29Wc2FIZ29vRGI0UmlnNFRCb2YvSmtyVitsZ0FuNkV1eW9oQjNDSHRQNDA5?=
 =?utf-8?B?MmFNL0dldkhGeGROMnc1NTJXRkhlVjd4OU5GbnFPTnNCOXZocE1CQWk4UzZS?=
 =?utf-8?B?WXRTbUwyekZyVW0rc2ZlV2F2clVUM1RrVGFFU3lWZTNPcC9vOTJaaUhvMDZS?=
 =?utf-8?B?V3duM0x0U3BXbFpWei93RnhxL2NhUmpnL3Bsdm53Mm94T0s2WGIrR2xRbU1u?=
 =?utf-8?B?OUJjS1FtdjF6Wnd1Q1ZodmxEWjV6T2RIK0dHMHdEYURFVUR4Ynl2OHNXaFFw?=
 =?utf-8?B?aGFBdk1PaHJhd0FjeWRGUUJ6KzM5NVJQNlIxV3BxVXE4bEZMZHN4UDdNSXdF?=
 =?utf-8?B?SFQrL2NPdDg0V0o5cmJRTlJZS0NvTVdNUnFoMVlkRlZvbDc0WlhJREV4T2FS?=
 =?utf-8?B?WUtIVDJlSTdoN0lCeWhtVjJSbm9Ua1hhcXF0UUMzMFAwU0REcEJNblY1TDBH?=
 =?utf-8?B?RkhPOWh0Rk9mV2Q5N3p1TjZUMW1jR2dPZVVHdmRVNU5yVkE5VytYUVYvK05X?=
 =?utf-8?B?OEpEK084czNKa0gySDQ4S1RKTUU3M3dKL2dFcjVxbEtKRk5yUnowa1BWVTAr?=
 =?utf-8?B?ektiQm11ZGtla2VFOE45eThRU2piSDkxbjZiTUE4akhsT3RyMStLTEpNU2FO?=
 =?utf-8?B?MGpxRFlQZTBTQjJoZSt1Vll6U3lKWVEyaWk1NnRXZE5CSkxiTVphS1FYWmpF?=
 =?utf-8?B?Z2hYSmJwSzFHMGRQQXp0ekdqYlRNNS9wWmpIMVNVdUxXSFFXbDVOcENneGhZ?=
 =?utf-8?B?SkNlZXMvRFJDQ2djdERhaWVrYm5ibHp3WUVOSElWV1E1SU5xUk9sMm4xRDZ5?=
 =?utf-8?B?TW9qYVl5OXppRTh5QitRNUM1aEJpVHhDcHNSUDkvU3hXdEhpMldWK2Z0dWlt?=
 =?utf-8?B?R2ptN0tqVzJjbXhabzFOUHBJam9WZDcrbWVacjZpd200bmlZdFdVZHhNVWE1?=
 =?utf-8?B?elREMWtqVTlvNXJCZlZjL2pFMUllNGZ6S3VKUGJ4UzlzSVY5a1NGWWNnV3o2?=
 =?utf-8?B?Z1Y0UWh0N3RXWWF5QXQzdW9iV2pVNWhWbTBVY0V3dVJkUVM3blhTV1B6cEds?=
 =?utf-8?B?RmxMN2RsU28vSmo1SElRVklaQXVaQkZRbUk4NXI1Mlc0blFTNnFtSzdRb2Vu?=
 =?utf-8?B?SFNtNXk5cE4rYnFJWXpqcENrUHg1cjdiUlhaWWFmSktmb1NscWFNT1FlVnB2?=
 =?utf-8?B?WnJ3enAyQk5tTnZjYjQ3Rm5VNHJ0dSsvVjgxc3hjTmVMTUxvVXZEdHVIN082?=
 =?utf-8?B?Q0g2WURaN0JsaVp0MmcrN3FRUWtYa3F1a1JldVIySy9uSUhVMDg2em9Oa1RK?=
 =?utf-8?B?UjZHazFsYmdKMWRLVzJtSHNJNE5tY2UvUFlTZlZWZXJGclRScXFpdi9ROWRa?=
 =?utf-8?B?YXYyc0dBb2dDcUdPVHNkRElnekRlYTRteERSRk1pb1g3SXBLaHVSM0lnK2lG?=
 =?utf-8?B?OEIyVkN6U3lSdm9zcVpGdVJRbFVTbC9DWnVqcXpzcEw3c1JrZVNvOFhGOHZo?=
 =?utf-8?B?UkJQZklldjFGQ2orbXdsWmtBbG14NnVsVFBhTTJHeWxUTUhSMStybXFwN2F5?=
 =?utf-8?Q?xuvLg4A4AdRryoRZIMwQoszQZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E633FBC4A5267458E71819FD0F076F2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CWuO5J0Qs4BTOk9oXNulvXadmJHgrzwT2ZtunwNfydY6MJoXFb6wstNpNeJt0hJ9LuJTpIAvpdY9Jjk6kfPupgtABxilaf6D0pd+MBNucnlxrsmgXuRkLkpoAhXkDzuCrsPdwqy28bxCg2x6bErrWVlnDo6fGqsdyExUDHHD/Y2ndrH9agQytB4/spSljwyhqNwfng3KSKI8sgqqRv+jzadgxHLqIZGPYC+wwf8CwKRFJapw9Xv9jZkgMBg5S0+xpwAT61Y1GWriN2zU1lSc5+zET065G8suvFBg4UDC25PeJe/gyGUjzMiI+Y8sEKvNR31pM3heMteWuqTQvxTy+wWCs6iE6oPLrWm5pLIxs9hLS+xe5lriULMiBzesSB+IRO8Qx9EmcuxuAK2C1mfWEe3QCaqXqq01WpTiMvLh1HzYUzFJnAbh8OQXyI5UJpfn+DSpIc6UodAy1mEnak8tShDCQyn1eV9JlvF9+DKiJqt6eb+bbHl2a1l8InULbIRfcLZl469usnctKZAi9xLFi1KmlsHpj9T4IsKQ36MYI4TkOn8JEh7d6V7HXRxjjSkwGs/sCabpZ+D9BYwY/lmiGMjijd3dkQyRd1R31DN7qTdDg7vhHb/EMq8G/o9tHgk7sYTfYrTT5qtMmhSAtURAzA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bf8fc5-44f8-4eb8-7564-08dcced83381
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 00:58:35.2012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eq7jYvkD6AUPFfuOpSAKY++AYFOlZ01MRj2oXkMkmB8imwXQiu1cjTWcgB4uXeO1pmv/0qAHBHvKnA8WUBWjMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
X-Authority-Analysis: v=2.4 cv=H/mJwPYi c=1 sm=1 tr=0 ts=66dba542 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=gfOWrcSENeI6MO7Pl2IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kYrks8rHrx0V0vTw0rygyGWgQu5hF816
X-Proofpoint-GUID: kYrks8rHrx0V0vTw0rygyGWgQu5hF816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=694 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409070001

T24gRnJpLCBTZXAgMDYsIDIwMjQsIFJveSBMdW8gd3JvdGU6DQo+IFdoZW4gZHdjM19yZXN1bWVf
Y29tbW9uKCkgcmV0dXJucyBhbiBlcnJvciwgcnVudGltZSBwbSBpcyBsZWZ0IGluDQo+IGRpc2Fi
bGVkIHN0YXRlIGluIGR3YzNfcmVzdW1lKCkuIFRoZSBuZXh0IGR3YzNfc3VzcGVuZF9jb21tb24o
KQ0KDQpXaGF0IGlzc3VlIGRpZCB5b3Ugc2VlIHdoZW4gZHdjM19zdXNwZW5kX2NvbW1vbiBpcyBu
b3Qgc2tpcHBlZD8NCg0KQlIsDQpUaGluaA0KDQo+IHNob3VsZCBiZSBza2lwcGVkIGFzIHRoZSBk
ZXZpY2UgaXMgYWxyZWFkeSBpbiBzdXNwZW5kZWQgc3RhdGUgYnV0DQo+IGl0J3Mgbm90IGJlY2F1
c2UgcG93ZXIuZGlzYWJsZV9kZXB0aCBpcyBub24temVyby4NCj4gRW5zdXJlcyBydW50aW1lIFBN
IGlzIGFsd2F5cyByZS1lbmFibGVkIGV2ZW4gYWZ0ZXIgZmFpbGVkIHJlc3VtZQ0KPiBhdHRlbXB0
cy4NCj4gDQo+IEZpeGVzOiA2OGMyNmZlNTgxODIgKCJ1c2I6IGR3YzM6IHNldCBwbSBydW50aW1l
IGFjdGl2ZSBiZWZvcmUgcmVzdW1lIGNvbW1vbiIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+IFNpZ25lZC1vZmYtYnk6IFJveSBMdW8gPHJveWx1b0Bnb29nbGUuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNSArKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IGNj
YzM4OTVkYmQ3Zi4uMTkyOGIwNzRiMmRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMjUzNyw3ICsy
NTM3LDcgQEAgc3RhdGljIGludCBkd2MzX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAg
c3RhdGljIGludCBkd2MzX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3Ry
dWN0IGR3YzMJKmR3YyA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAtCWludAkJcmV0Ow0KPiAr
CWludAkJcmV0ID0gMDsNCj4gIA0KPiAgCXBpbmN0cmxfcG1fc2VsZWN0X2RlZmF1bHRfc3RhdGUo
ZGV2KTsNCj4gIA0KPiBAQCAtMjU0NywxMiArMjU0NywxMSBAQCBzdGF0aWMgaW50IGR3YzNfcmVz
dW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlyZXQgPSBkd2MzX3Jlc3VtZV9jb21tb24oZHdj
LCBQTVNHX1JFU1VNRSk7DQo+ICAJaWYgKHJldCkgew0KPiAgCQlwbV9ydW50aW1lX3NldF9zdXNw
ZW5kZWQoZGV2KTsNCj4gLQkJcmV0dXJuIHJldDsNCj4gIAl9DQo+ICANCj4gIAlwbV9ydW50aW1l
X2VuYWJsZShkZXYpOw0KPiAgDQo+IC0JcmV0dXJuIDA7DQo+ICsJcmV0dXJuIHJldDsNCj4gIH0N
Cj4gIA0KPiAgc3RhdGljIHZvaWQgZHdjM19jb21wbGV0ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+
IA0KPiBiYXNlLWNvbW1pdDogYWQ2MTg3MzY4ODNiODk3MGY2NmFmNzk5ZTM0MDA3NDc1ZmUzM2E2
OA0KPiAtLSANCj4gMi40Ni4wLjQ2OS5nNTljNjViMmE2Ny1nb29nDQo+IA==

