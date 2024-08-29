Return-Path: <stable+bounces-71452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E3796368F
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 02:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBC2B225AF
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 00:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF091370;
	Thu, 29 Aug 2024 00:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M8iaqMYD";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XLHljpFz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eIvqQuEA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327C360;
	Thu, 29 Aug 2024 00:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889825; cv=fail; b=YP8X1rLG8Ry+mvizJ5uY1vqdxwBd1IscnTx0nGwbczw9AjCFl5oNQpfySloqhg9I5pN6QI8VzNUevM4/CFUGsayYCqykvFIYZNNM5MAHNDh615h03ko2ag9lRMhVomXfbveIVsu7RKtQAg5ukBGjvUIKenvnIy9TMPZJAqJynKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889825; c=relaxed/simple;
	bh=ulSMsR1xw4T5WRktDt2B/i+Ki359janu5SX6og1g548=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cCqS9358qAW+tsjG0PcGQjrFgTfT4FjWAABMP7GweeSow25oZCOVSRzlxINXgbL/yz2cBr34XpB8EYRavui+rssN9aWl6EdoRZejVWtUbZQbRKETFGRX9F0tz6r2dta9oN55lzyPXNMw/vWYxrmc1ICiUcxs8R4KDYQfV9QbmYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=M8iaqMYD; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XLHljpFz; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eIvqQuEA reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJ5rXo014706;
	Wed, 28 Aug 2024 17:03:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ulSMsR1xw4T5WRktDt2B/i+Ki359janu5SX6og1g548=; b=
	M8iaqMYDTvDh2OXDBbnk7l6Ab55mAwr7OW1sBrwUGPeaetIvFQSokfSno/T6Qc4o
	iijJ4n8XSdtkJiMSMAbGxI4je70z4Ps5vD0vV/Ry7AHs3+21QXgf/9yOiVQyUkZO
	p19cYFgBpcQvagyej/2HjSqMoHprk7MfFoGkdjycdjLq9iK41M4ZSJigxVdO2S7A
	WIqYjlDQ75hnGnmZCShWuYFFCPLsphMIXobIqWFk0OsOOgCtRIt8Zol3a5oX6bDX
	+8rlsgaWfn0WzPLoekN6/Mu7JefzirWcH1ZdRsR/d5jy9uqHmL/5sDSw+O6ClToo
	KCGgP9/X0xvkhqZEmGqlNA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 419py0xt67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 17:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1724889818; bh=ulSMsR1xw4T5WRktDt2B/i+Ki359janu5SX6og1g548=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XLHljpFzVB4TNjY+ipuGLmWKNkbSyLkyP2QIHLRQdOnmJw9Sq1OvUGNbmKYJe4SSk
	 dbU+MD8GE+mSlELSzjz70HCFHI0jR+cuCa+tPTs9nZXXFmU1ddWLneAP9IaafvA4Pw
	 Hyu3cT6/XxyJWVhLp6aHrFq9YovBESfk8h2Byfq7wL6wBzobZc6leUANfQAkxzFaio
	 5DymX5XIxKczSchNXF1edp4wWlJ4besqm+c6bLbMIdUmcF7z/6AGiNI2l8Vfzna1zs
	 4vxZECvyHXsee41RIP+mFqSKUnGsQmmwupS0ZB1iqaMyT2gZ7/Xi8DePbPPhHWeRe2
	 G7uilFlo6hPaQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D737A4045D;
	Thu, 29 Aug 2024 00:03:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 91C56A0077;
	Thu, 29 Aug 2024 00:03:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=eIvqQuEA;
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id B6BCE40407;
	Thu, 29 Aug 2024 00:03:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtDwNen7oq88eDTqa6L0zAjyJj+rHBIWEN0hROVIlh/kZ980Ay5G0JGUXVK5eB/pi3L4Vq4ppt2v6FMRRsWh9mBd52jSy79/9yrMq3uALJuewH74Q6hhWWVlIFq0PJ4s4/uFfv6RbhwGWM0S2k+c2F0lAscd0lpDEb0Ntd9oaHHlDI6FQAoFuZU47PfPgGMzy3TYWerdwVeGLBwgx2uVm3zj3anCQEMog/RpIAvfgO5Y4rmyJV4vqpTCPS5T79batXO29iCHb/nTr91AET/lqSBXRrMIMjn0hf1zP9hCHoZQA8U0VwtPhP4Rl7Nh/uzpWtedhJ10tN2Gi1b1+7biKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulSMsR1xw4T5WRktDt2B/i+Ki359janu5SX6og1g548=;
 b=KQgXQl8D/eYty4poT+K8pXUlHk0uK+DVhlQMqzrUveDIsvPGcO1QUU+3ZpmN2FLOpuWZLfAVM+DVe+Gn76TYgqVM3gneb/AwKcKnCsFLoY3rSIgQYikGx1qzPNrmdpAdOQmJV1bpoby6Ne9vbnnBxknHa8YeW4QALbwvtxFYNO6ulZtLcC1Lf60FRD+MVUwEIUj6xhFz8s5LVVKkKTfYA9RtHUjceFLG7vzifQ19vNBMiFPgwem1P3s/CkXE2hNmKx3hQWMFptRPsRsnEi/d/SB0ADfddpjsC2M8f/ORjGX/S1mMxaObCh5bajjY9jV2gICkT96pdF4n1rwEONUmGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulSMsR1xw4T5WRktDt2B/i+Ki359janu5SX6og1g548=;
 b=eIvqQuEAT1qsaX39Rbxlu+EvwR7wsQeJPDb4cxw1HninCRJgnmXfzBTnwLDLX1ImfdZO2PdTSDN7XHQNOsgsPZBzxnbVE2AhW5zwbBAdsxOVW3uJAxRvevzBxvG8ErMRg7VXj7t361M0we9CIcQ+CgaB11buSnz3vgumaotm0RU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB7574.namprd12.prod.outlook.com (2603:10b6:8:10e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 00:03:34 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 00:03:34 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Faisal Hassan <quic_faisalh@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: core: update LC timer as per USB Spec V3.2
Thread-Topic: [PATCH] usb: dwc3: core: update LC timer as per USB Spec V3.2
Thread-Index: AQHa9G+uvJyAvtfidUO/RZdAQO8ENbI9ZN+A
Date: Thu, 29 Aug 2024 00:03:34 +0000
Message-ID: <20240829000327.wqol2m3fbpc6h3dn@synopsys.com>
References: <20240822084504.1355-1-quic_faisalh@quicinc.com>
In-Reply-To: <20240822084504.1355-1-quic_faisalh@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB7574:EE_
x-ms-office365-filtering-correlation-id: 38f4a469-77f3-4285-deae-08dcc7be0649
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3J3TlV1S2h3OTZqZStFM3paWEtweS9KUk1wQWtLTDhVY09LZWwvdDFkenUr?=
 =?utf-8?B?SzlBU2x2SW9USnhPc29YTjNOVE9leUlxaUhCWW5aRmVuQm96VHdnc3poRUdR?=
 =?utf-8?B?QzRQdVdyeks1WHNQcnE0Y2l4MGNiZGl3dVFtTTJRdmU5bmtFQ1BSRnBEMVVl?=
 =?utf-8?B?ZitwNmJyZ1REOFp6YWJ6UVY2RjNhcFNhQXJ1dkZ2b0FUYjI1VzFqUDN0OFpX?=
 =?utf-8?B?Rlkvejk2Qk9zVXA0TUh5NlBQWkxKWlVmWjhxQURHVGVmTFhNclZOcWgwN0NF?=
 =?utf-8?B?T1Ftc2lPcVRXUk9CT2NzS0lqR1NxZDJFajNIZGFHL1llWGphK3ZGYUQvakpV?=
 =?utf-8?B?b0NTdkNVaFc5TlIvQ0pFaVZWMnBycGZlV0JsZjk1eGhldVRXbHIzUG4wdmZZ?=
 =?utf-8?B?WTJPc2hwaDZhTCtGaTNXUFNEYTFSYUQ3V2lmUlRFNmltT3g3Tzd3WkpzdHVm?=
 =?utf-8?B?d3VUaC8yUjhOWHpjb1EvL1VIZTJxK1huR2lFOWE1RFhyNzBsc29LUnlaaVpl?=
 =?utf-8?B?OEU3VWhxOExFTDU3Nm1yNDR0OEZub1NmWThETWg4ejVkS1Z2aUxsc0grdFpR?=
 =?utf-8?B?alBKbGYzSnpkQmxkMDF4ZXlQVWE5azg5djJ0VEhLZUtiVE8wM2o1MXNvOTBU?=
 =?utf-8?B?ZGxqWFRGVE8xSDhmZnBFYTdBUXRNcjFEUC8xTHhmT25IaG0zQTV2VSs3ZXpT?=
 =?utf-8?B?VytTUHdra3Yvd1MvbS9iSFkrTjIvYnBjRmpTQS9GNjJnblJYT2Y0QmpOQjNX?=
 =?utf-8?B?c3M5ZG1PeHp3SG5wU0FMQ0ZpbHQzVGZUTjB5d2R5RWZxTDJ1M0l6Qi9uYlRY?=
 =?utf-8?B?QlBpTTZYYjk4K0V4cFVjVXN4RDk0MGUrZ1FhRFdXTWJrempDN1gzVjU1Y3ds?=
 =?utf-8?B?Q3JOZkJ0YnJrVHMwL2NZTEhVOGNlbUxLZStZMjNaUmx6Ti9tV3BDYjk5S3Bw?=
 =?utf-8?B?Mzd5ZjE1YlBvdlAxelhKTUlGY2NSVzRmNmY2K3lWdE44L1NIWkNiZDFKOTJm?=
 =?utf-8?B?RnMzbmFhejVZZnJyNWZzTjVLQUhZRnIzOUdOQkpxNWFNVnUwelR5TGtLQ3JZ?=
 =?utf-8?B?UUNQUEFPWnRuRWI0SjQ5TExwRlVScTN0dVo1N0Q5UzNsRUwrNjNTWFNGamov?=
 =?utf-8?B?RFdpNDRUd05iNzBzNmRIRFZCcUZ3Snc4UU5weUhybjFNNTFXNU85WXVnVGh4?=
 =?utf-8?B?Q3pDZnJnN0tmVmpsWUh1dFRhSWpFMVY5emdiS0FRb0JxOHVhM29jZkFzY0lJ?=
 =?utf-8?B?bFpEZzFGM2FjUlQ1Z2hvYkRZeEphanJjT1ZCMVhTRGsxWlBLTWpNVFord0N2?=
 =?utf-8?B?eEJFTC9IZStaK2ZNYW8rNkpSUENWc2NwZDMyTU9pL2lNcnN3blBqN1l6eVpP?=
 =?utf-8?B?RnQzUEgzWFprN2VET252eityZWk5QU1aTE5rbzJPQnllMCtwd090di8rZjFy?=
 =?utf-8?B?ZFZSb05mdGdBUXNzTlhrc0wzREtEbGh2SmNiaXVrQmZ2V3NxbXJTRmdhYVE1?=
 =?utf-8?B?eWFBNmpFWHpGcHJGZ01lcHgyak83bjhXbEdQdjJjd0JHM29kYXNCNVV2bC9H?=
 =?utf-8?B?Ui91M0tWcUFRNDRwbWMvZ2RCU1A5bWU0MkRWbjlJYmFyUStJRWN1K3lTOGpl?=
 =?utf-8?B?aFJvV1BXcnRHTnUvT0hYUVMvMFJ1K0hvU3R2QlhxUWpwNTVRaURNZ0R0UEg4?=
 =?utf-8?B?L202SUp4SnZaTVEyTmhHdCtRK3Uza2FCSHdZYlVsNnZ1Z1UxOHdqcmZnWmhS?=
 =?utf-8?B?RG9OSlQ0a2srUVBZTHpRblZDeUVGTXV6ZGNLZHl5aEFnQ2NuZ1ZJaU4zbTla?=
 =?utf-8?B?T2ZoSDJaL2lYZlY3bkkyekFlbnZSZ0pNU3A1UnJjVWVuZ01Hd1RHeHBjTExn?=
 =?utf-8?B?NmhLYUUzSUtuUUxvSHpQdFFlcGdzSnZReDlIYXJ0YVNQOFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WkVDRC9kUlNIb2pIRVNRbWphS2E1U0hIR3ZTU1pJYXBxTVVjUVlPekVCcFVP?=
 =?utf-8?B?c2VnbzR1UmUrbThoMnkyYzYyZXcvUmNId01icjFSRzZUdDhJVW1CL3EvZDNh?=
 =?utf-8?B?QzFwQTBJL1JXTklQUnovVEZZWmFEQUlQV016RXRqRnZnS3hXNVozUUdPRy9r?=
 =?utf-8?B?RDlHOTJXZDdyWDE3cVF0UUdWM29hVjNpUEtFMlNRbEpFalhoOENBUWYwTDQ4?=
 =?utf-8?B?QS8zTWpZWUkwdlBZejBvaWVzMGFzZFZHMHVKZWNPYUo4YXdZU0tUUERQbmJD?=
 =?utf-8?B?TUkvYlFRbzZNOUpzdTdUajVvMU9ndGJhU1RhWU50M1B2WkhHMUNkV3FLdjdM?=
 =?utf-8?B?OGJDcDNzVk9ENHV2ZUkxMUVIU0psUExMdmRBRXZBcE5XanJ4ZEE4VGdpSDc3?=
 =?utf-8?B?b3lnVklDcXpId3N3SWxRanFTYUI4dGRBZkYzMmF5RXVLTXdmVDZISzgwUHJZ?=
 =?utf-8?B?c2dyOVdwQmpKT05Kd0pVY3A1bkpRMm4rN3psa2N3dTZHSnZMbnhPdURlNWJH?=
 =?utf-8?B?emtxeHdwdTFzNlhKK0E3TDRycDhUQWhvK3p0OVRLa08xSUxXdTFFNythelY4?=
 =?utf-8?B?V2F2d0p2dFY1VUhuUzBzTlhzbVk1ZnBHMkdUNnZFOVJVV0lyRXE1VmxYd2Uv?=
 =?utf-8?B?RlI0WVpZTm5aSVB0K1Z1T3VOcDlWajcyMGRVSHlPU2FQV0lWTmtQRVdkbW1y?=
 =?utf-8?B?R1JEMXpMUmxPQXdQS0VrY1hxa1hONHlTZU43dWZTemUxL0FqWWJLL0Y2RUgv?=
 =?utf-8?B?R29iQ201QnpQQjFLZWRlTUpCcS9OTnJmSjQyZnZFTTFvS1BCNzkvS3RndW5K?=
 =?utf-8?B?c044c091bHQxU1FxLzFnYVYvOFRHUGtaQzJOcDJONTB1NWxaeTRlemtxbGpY?=
 =?utf-8?B?M242VHhJeWZsdHhuNGhQWkpOT3NBZHMyWVBSbE5Pd2N3aTVPVmxrUEc4U0xV?=
 =?utf-8?B?VjMya3NWVlk5bzB5cDdBNDRIOEJUTllNYTJMUTFzbGF4YWJtSitNdmEvNGNX?=
 =?utf-8?B?NjNzWlMrVU9kWnhVM21JMTVPWFRPZnF6Z2swY3hDaXk2a2dZbVJrVkliRmlW?=
 =?utf-8?B?WmE2V2VMTlNYOHBmS1cwT2tSL0tVRVQvTlM2Y2U5M3YxbTROZmU3U1h0Mkxz?=
 =?utf-8?B?UU5nNjNzWkl1bTR1YnlBSWN4OWhmMUtGYVNxNnE4SnoyU2N3dStrdzhpUmZn?=
 =?utf-8?B?TGFPTDNob09rNWRPcVNPVHZYYjdZdEErV3Fzb2F5UkFuQTd3VnJwRjhTREdY?=
 =?utf-8?B?TjN5bXRWVzBPb2lQOUVRMzM4TVR1dUxYcnFZVkVBQkJjVE1WUDdyVDNIdUNE?=
 =?utf-8?B?NlcvZ1c2ZzNxcENjSUhZbktrRjV6RUcrbmljL2Myd0lsS3RPVXpESDlsTTF4?=
 =?utf-8?B?NnRuMTV3NmtlK2xDQzVSOSs0ZWw0a2tBRVdsZkJ6THhvL211QjJucGRBbUtW?=
 =?utf-8?B?cm1OWm1xM2Q1MHRCQ0VNYy9YNCtmQlk2d3JqNklmdEIvVlRVR3hLVVRDNUhv?=
 =?utf-8?B?Y2FHajR1TnpmSmswMHZoTWJhRURqbi9vQnJIZzRveDJOTEkxQlNQSVpQR1Vm?=
 =?utf-8?B?L1BtdFZaMjk0MkxuNXB0VHhYcGpnd3VycW1vS3BEZ2l6UkdFMi9kWU5hc2tl?=
 =?utf-8?B?ZDk1ZDE4cWFUVVhXT3RBR3BMclVMZ0NXT2Z0VFJhZldZbmdlL0F6L2pNSHRW?=
 =?utf-8?B?YldvbEMzR21adVluOWZPNDRVa0UxWTJ0NjdENldBVEpNQTZMR2VKZDYzOFJF?=
 =?utf-8?B?SldKUTlDTW9iRW04WWhTNGY1TmIrTzFObklubkorRk1wZHVOY1lYczM0UytW?=
 =?utf-8?B?SWJMRjgwVkVDbis0WUJDRkdyNmFWM0RIL1hzbk5QL0t2M3ViaTNXWU13TmtW?=
 =?utf-8?B?Z2dUYWhETHBKUlF1aHpkRldxQWVhSDRqNFZYMmtLSjNsK0E2S1ljQjJRRDJa?=
 =?utf-8?B?SGtERjAwYXVnVk12NFBad09veU13TllLZ00rSGppTytieXl0dVZwQXRhbmg1?=
 =?utf-8?B?Yk9FaE9Ob0tqZEdYT1lCaGYwcWZRcXEvMTVqQjBMZDNWTmR0Y09oMy94ajZY?=
 =?utf-8?B?QTA4cTRueG1JUU9WVEs2MjJoYUNiS2JSR3pwWTUweDVCR0xKZXRvUi9KV1F2?=
 =?utf-8?Q?LWzMHqTypJt3Lkmjp2FokU6iD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C946AA16C11DF4EBD2E0779A642FF25@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wX2L/QNAOBGc54duzaO6MF7ubUGscDZaVw9E2R/p5iPvhjZLcuFHRuanGAgXWs1khJoz5nzgNDUmNKUs/sw8va5H8k2G5c6TRa/1uRdigW5dHtmn0YpgqsHwBT2XLq8jSYU9W36j38O8k7N/4SZbdm8egQi6QFovlosUVjVRVq2mSX63caikfbvCgRPnmjaeofnkWxA1lLxPziZ2qCZZgLLd5ifPTBA6hfzxQ3HICYTBWunaSEJc2TUA58F+XTyWim2DKrl4GSq5GGciLirWNCkU3nRBJ7KtBVqYqzpLjusL8Ttp8jJk54ChPLVPnotAsuJZMsspEYtlcCckrWMLtRhXuoPbLsHR3TOuGtzJt2gc58mkywbi0KyoyjMo0InrskhKcmqRgkfvcqrw3JAf2skagUo8MtCc3vG23v9RY7UgZF7RzIgYOR3EunK99VPnT8cvGSjrg7rjwwW2anpuabhttTibPkQRBi9Uk6XX25Eysq1N8rKOPddPuCoLjN6AlfXBAEfIbl7+cvY+oN3kbzCneemhWCJiMc0lRPIYHVBqhZSuTnagfoEAhv5drw4uLARYbnLtsJb1ihz7ORehOlUU0AoTVr/uE/hLJmqXJQJ9bJUAc80X8kgRqeFYIVDpuX7KCpxWwPMjbxG4PKjcAw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f4a469-77f3-4285-deae-08dcc7be0649
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 00:03:34.2605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIs5TlqMThb4nQ5M6rTZKSc6EAJ69l5ULWJpa7S8IboaA67vGHgvhj/TWm/8A/MXCgFwpniKyBK0w42powoMbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7574
X-Authority-Analysis: v=2.4 cv=PpXBbBM3 c=1 sm=1 tr=0 ts=66cfbadb cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yoJbH4e0A30A:10 a=nEwiWwFL_bsA:10
 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=jIQo8A4GAAAA:8 a=u05nFtkXkWGhSOkWz9IA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=TjNXssC_j7lpFel5tvFf:22 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: HtMJKz5hud9QBKX1LhLUJYdUFA_9Hg-A
X-Proofpoint-GUID: HtMJKz5hud9QBKX1LhLUJYdUFA_9Hg-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_09,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408280175

T24gVGh1LCBBdWcgMjIsIDIwMjQsIEZhaXNhbCBIYXNzYW4gd3JvdGU6DQo+IFRoaXMgZml4IGFk
ZHJlc3NlcyBTVEFSIDkwMDEyODU1OTksIHdoaWNoIG9ubHkgYWZmZWN0cyBkd2MzIGNvcmUgdmVy
c2lvbg0KPiAzMjBhLiBUaGUgdGltZXIgdmFsdWUgZm9yIFBNX0xDX1RJTUVSIGluIDMyMGEgZm9y
IHRoZSBMaW5rIEVDTiBjaGFuZ2VzDQoNCldoZW4gbm90ZSBmb3IgdGhlIGNvbnRyb2xsZXIgSVAg
YW5kIHZlcnNpb24gaW4gY29tbWVudHMsIHVzZSB0aGUgSVAgbmFtZQ0KYW5kIHZlcnNpb246IERX
Q191c2IzIHZlcnNpb24gMy4yMGENCg0KImR3YzMiIGlzIGFtYmlndW91cy4NCg0KPiBpcyBpbmNv
cnJlY3QuIElmIHRoZSBQTSBUSU1FUiBFQ04gaXMgZW5hYmxlZCB2aWEgR1VDVEwyWzE5XSwgdGhl
IGxpbmsNCj4gY29tcGxpYW5jZSB0ZXN0IChURDcuMjEpIG1heSBmYWlsLiBJZiB0aGUgRUNOIGlz
IG5vdCBlbmFibGVkDQo+IChHVUNUTDJbMTldID0gMCksIHRoZSBjb250cm9sbGVyIHdpbGwgdXNl
IHRoZSBvbGQgdGltZXIgdmFsdWUgKDV1cyksDQo+IHdoaWNoIGlzIHN0aWxsIGFjY2VwdGFibGUg
Zm9yIHRoZSBsaW5rIGNvbXBsaWFuY2UgdGVzdC4gVGhlcmVmb3JlLCBjbGVhcg0KPiBHVUNUTDJb
MTldIHRvIHBhc3MgdGhlIFVTQiBsaW5rIGNvbXBsaWFuY2UgdGVzdDogVEQgNy4yMS4NCj4gDQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEZhaXNhbCBIYXNz
YW4gPHF1aWNfZmFpc2FsaEBxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmgg
fCAgMiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUu
Yw0KPiBpbmRleCA3MzRkZTJhOGJkMjEuLmQwYmQzYTBlMWY5YyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4g
QEAgLTEzNzgsNiArMTM3OCwyMSBAQCBzdGF0aWMgaW50IGR3YzNfY29yZV9pbml0KHN0cnVjdCBk
d2MzICpkd2MpDQo+ICAJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVUNUTDIsIHJlZyk7
DQo+ICAJfQ0KPiAgDQo+ICsJLyoNCj4gKwkgKiBTVEFSIDkwMDEyODU1OTk6IFRoaXMgaXNzdWUg
YWZmZWN0cyBkd2MzIGNvcmUgdmVyc2lvbiAzLjIwYQ0KDQpOb3RlIElQIG5hbWUgYWxvbmcgd2l0
aCB2ZXJzaW9uLg0KaWUuICIuLi4gYWZmZWN0cyBEV0NfdXNiMyB2ZXJzaW9uIDMuMjBhIC4uLiIN
Cg0KPiArCSAqIG9ubHkuIElmIHRoZSBQTSBUSU1FUiBFQ00gaXMgZW5hYmxlZCB0aHJvdWdoIEdV
Q1RMMlsxOV0sIHRoZQ0KPiArCSAqIGxpbmsgY29tcGxpYW5jZSB0ZXN0IChURDcuMjEpIG1heSBm
YWlsLiBJZiB0aGUgRUNOIGlzIG5vdA0KPiArCSAqIGVuYWJsZWQgKEdVQ1RMMlsxOV0gPSAwKSwg
dGhlIGNvbnRyb2xsZXIgd2lsbCB1c2UgdGhlIG9sZCB0aW1lcg0KPiArCSAqIHZhbHVlICg1dXMp
LCB3aGljaCBpcyBzdGlsbCBhY2NlcHRhYmxlIGZvciB0aGUgbGluayBjb21wbGlhbmNlDQo+ICsJ
ICogdGVzdC4gVGhlcmVmb3JlLCBkbyBub3QgZW5hYmxlIFBNIFRJTUVSIEVDTSBpbiAzLjIwYSBi
eQ0KPiArCSAqIHNldHRpbmcgR1VDVEwyWzE5XSBieSBkZWZhdWx0OyBpbnN0ZWFkLCB1c2UgR1VD
VEwyWzE5XSA9IDAuDQo+ICsJICovDQo+ICsJaWYgKERXQzNfVkVSX0lTKERXQzMsIDMyMEEpKSB7
DQo+ICsJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVQ1RMMik7DQo+ICsJCXJl
ZyAmPSB+RFdDM19HVUNUTDJfTENfVElNRVI7DQo+ICsJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywg
RFdDM19HVUNUTDIsIHJlZyk7DQo+ICsJfQ0KPiArDQo+ICAJLyoNCj4gIAkgKiBXaGVuIGNvbmZp
Z3VyZWQgaW4gSE9TVCBtb2RlLCBhZnRlciBpc3N1aW5nIFUzL0wyIGV4aXQgY29udHJvbGxlcg0K
PiAgCSAqIGZhaWxzIHRvIHNlbmQgcHJvcGVyIENSQyBjaGVja3N1bSBpbiBDUkM1IGZlaWxkLiBC
ZWNhdXNlIG9mIHRoaXMNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXggMWU1NjFmZDhiODZlLi5jNzEyNDBlOGY3
YzcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC00MjEsNiArNDIxLDcgQEANCj4gIA0KPiAgLyogR2xv
YmFsIFVzZXIgQ29udHJvbCBSZWdpc3RlciAyICovDQo+ICAjZGVmaW5lIERXQzNfR1VDVEwyX1JT
VF9BQ1RCSVRMQVRFUgkJQklUKDE0KQ0KPiArI2RlZmluZSBEV0MzX0dVQ1RMMl9MQ19USU1FUgkJ
CUJJVCgxOSkNCj4gIA0KPiAgLyogR2xvYmFsIFVzZXIgQ29udHJvbCBSZWdpc3RlciAzICovDQo+
ICAjZGVmaW5lIERXQzNfR1VDVEwzX1NQTElURElTQUJMRQkJQklUKDE0KQ0KPiBAQCAtMTI2OSw2
ICsxMjcwLDcgQEAgc3RydWN0IGR3YzMgew0KPiAgI2RlZmluZSBEV0MzX1JFVklTSU9OXzI5MEEJ
MHg1NTMzMjkwYQ0KPiAgI2RlZmluZSBEV0MzX1JFVklTSU9OXzMwMEEJMHg1NTMzMzAwYQ0KPiAg
I2RlZmluZSBEV0MzX1JFVklTSU9OXzMxMEEJMHg1NTMzMzEwYQ0KPiArI2RlZmluZSBEV0MzX1JF
VklTSU9OXzMyMEEJMHg1NTMzMzIwYQ0KPiAgI2RlZmluZSBEV0MzX1JFVklTSU9OXzMzMEEJMHg1
NTMzMzMwYQ0KPiAgDQo+ICAjZGVmaW5lIERXQzMxX1JFVklTSU9OX0FOWQkweDANCj4gLS0gDQo+
IDIuMTcuMQ0KPiANCg0KQWZ0ZXIgdGhlIG1pbm9yIGZpeCwgeW91IGNhbiBpbmNsdWRlIHRoaXM6
DQoNCkFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQoN
ClRoYW5rcywNClRoaW5o

