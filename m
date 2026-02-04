Return-Path: <stable+bounces-213335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENADIaCngmmVXQMAu9opvQ
	(envelope-from <stable+bounces-213335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 02:57:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA2E09CC
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 02:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1996830B63B4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 01:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFF6289E17;
	Wed,  4 Feb 2026 01:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FsGXI0Px";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TjiS65RD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="r6rnrMu5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562321509AB;
	Wed,  4 Feb 2026 01:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170266; cv=fail; b=iBCCck0PsptPERcxlWAvC+WhWDsqD/oHgz/4UPId3Pv1zsKdzHc5C0Lgd5v6nXJY9H9zc8ENPxtbzqGQ295VdAHk2yVOO+XLxC5pcCgZJGPgRFg/mciVax6tHu6unqZXYMkG+D3bQBHnKE0pNg0P+W8YipSAZ42L8vaT0Fbvmkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170266; c=relaxed/simple;
	bh=ugwpwXPN4WX2Y+/tqr9YtyjddnS11aDLsg4lNMhO+/E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOcACQvCkkuXF458pjTlv4UWoJqybq+fpSU/V/lDKDIyeAqqrI6r5BH8W5MvSaHzhyZk4hPAtNkKxIBKztMTBtdE2XitZJF3+MxHcTyrvJzdCG8NIvPpZmYuEkmVB1HMVl5KwqwYdDL7StFEjwIeGjPfpI/UIFPohDYWIusVS8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FsGXI0Px; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TjiS65RD; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=r6rnrMu5 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613Kvvlw2484566;
	Tue, 3 Feb 2026 17:57:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ugwpwXPN4WX2Y+/tqr9YtyjddnS11aDLsg4lNMhO+/E=; b=
	FsGXI0Px12KnIZgls8mrnk8YJOntGOnb7tAwyqBG0BRfwLDXBbdNCPOZy6PQi5c9
	gWerhAq1IzQQSPEahhSxEzVwuuwzd/mQW02y0h676zatdE8nCLttSE2zJo7ZI/Ik
	RvNdcW7sSLTdJZT+5rgFFyHhGvacOc+t+3Mg4Lms1UpMB3BHYK0TxNxjD3lYobqS
	TTm+gFwgXx9df7UAE02GYiIDnd7c6xCR/b2RHIcQN10JQ908qd1SuvflDJ2eG6St
	hexQtFNRjGweDrXxySYtzffTGQPARB3la6xQJnweRcCVYTb5NSo3ifKj2ISSIJt/
	14aYty9Rmw8sgUzy2wg/1Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4c377c5ytg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 17:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1770170255; bh=ugwpwXPN4WX2Y+/tqr9YtyjddnS11aDLsg4lNMhO+/E=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=TjiS65RD74yFE8posWca++fqeuBIlpm4SPMCfqzt/+U4SMKpZm3MGiFWJriXonyDj
	 vm/HZq/BimcfVk1rjFDPuTlekSTWiOU994/aWdSMLNyx8u4u9vLEIBFmdoI1tK2Cgh
	 YZjOreXCBYfvqQYMvS/2caSZcyRhQA6JcEWTLVMIBQWQvEqd9WTrRa8CtYQFYLu5lC
	 dZQyQhT45/nSTocGaGUECYnPDJEe3EiduOUWzFHD0Rr11HgG4kG4vvtVPyTbdFOUxi
	 swbzwimcG4nvDainuqS3wsIkFfD9xWfJmvF97UgZy3EUuJK+tMLZe5mEsN6nUqfcSb
	 6wvHgBdqpi6lA==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8A3D740364;
	Wed,  4 Feb 2026 01:57:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4E563A005A;
	Wed,  4 Feb 2026 01:57:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=r6rnrMu5;
	dkim-atps=neutral
Received: from DM2PR04CU003.outbound.protection.outlook.com (mail-dm2pr04cu00303.outbound.protection.outlook.com [40.93.13.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BEBE14035E;
	Wed,  4 Feb 2026 01:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDdu/QCdnSQ8Gsap4XJB8cAwUELH5LXnIJvUPmKvK1urhrOFauWLFfu65+ln4kgclA/Y13FAeyIBQJoK4BYE9j8doYeu5BRrAoay4HAEFeeaWsdqOzRveuxPqQa/jlDaYiJHL549SKxeFXraCeUrJkGl3TYmj5YjqDnRXxRFEkTP/tfg+J8LBF81vl4afVr0tJY+9vN185/uIeu2XcQ5Fx40GK9ZwIAyyF1j6BUeKZ5sBIapnEsQhwgwquf667RMl7guag77Y4rJUKXtKds9qJOT1D98tosHB8EtdkoxXuyRFARmjPSAYqCyglFSrz3n1z72WCLiCK+bc5WxRjhPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugwpwXPN4WX2Y+/tqr9YtyjddnS11aDLsg4lNMhO+/E=;
 b=v6dJDjphXqImQs0rC4z/Gj1dKrq7e5TfB4uU+Ru2opegvreumZA5C2IVbi/tZBVjSHs25n9HeEBpGYpJIvFmgjqR0EEjmedIvrMWs9A3SWTENv1B4uXFhz4/t5A9bzwyuDG9jqtXvJDFd0wgJQ5EkxIVDKyCBBx3T5dHWO5fC2ajR7EdXjNnlqo+rEPA0XZR6Kf3dPVRLoTinCAqyTeXIl631FY7rXTIzA2AyI8RypwQLMilo7Adf4z1RUix/hruhTfYw91DfRTctWZs5Pn509xT0FLC7VzpPFhD3Kpl74LtMnOg/rIOohpXsuhDsSVcXYZfh+XUeo+OQxj0RyGupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugwpwXPN4WX2Y+/tqr9YtyjddnS11aDLsg4lNMhO+/E=;
 b=r6rnrMu5le+rdljggLP0sNVOcxNRVAB3Edv6MI37OyeANDoab8uzfR/etH8cnK1qSsvk+LJ1bMnBsTdxpWcE+bhlSft1/RPm4Ml6X3x/ihkLtRAJUM7YsOq4dotTkGiJXN/g/b8V72y3Xt1G8DrGJxGVnpMfHLO2N8yZh6d8Y8w=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 01:57:30 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.9542.009; Wed, 4 Feb 2026
 01:57:30 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <prashanth.k@oss.qualcomm.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Samuel Wu <wusamuel@google.com>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Move vbus draw to workqueue context
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Move vbus draw to workqueue
 context
Thread-Index: AQHclMqj0ysPiYL+QUGwzoEDg2lXXLVxyaMA
Date: Wed, 4 Feb 2026 01:57:30 +0000
Message-ID: <20260204015726.ercycq7uto6ofuhk@synopsys.com>
References: <20260203050430.2211487-1-prashanth.k@oss.qualcomm.com>
In-Reply-To: <20260203050430.2211487-1-prashanth.k@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB6434:EE_
x-ms-office365-filtering-correlation-id: 4a419491-1d7c-4b8f-c27e-08de6390c160
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UEE3cDk1YXJGYXZGMUI4TVNEWGZQTmxhYkY5YjVTKzYva0Y3UDhGK0JzVGhD?=
 =?utf-8?B?ZWFWRnE2TmFSc2NhNkx6anJ3eitNZU56cUw4cURDaEJxMFNSNVZyM0ZwdG56?=
 =?utf-8?B?S0dpMUZnbzZkU0kxL2JnS2ZVM1pET3NuRTJkN2xRNitOZlJoZGF2cEZFOHU0?=
 =?utf-8?B?RjJteWxBc2wzQUpyVDFwU0c1OEQ1dlNrdXF2SmVCVUs1azZPT2xXc2U1YWR6?=
 =?utf-8?B?blRySTJWbmc3WGVBRmhFRlJ4VlBDSXlOd1ZiWXJFbStsUVFZeDdmNHZzVFVw?=
 =?utf-8?B?aTdxYUpxZDh6bGlLWURwcndaZXlDazdDSk1jZ24yb0tYc0tsR1EyOTZrQnQx?=
 =?utf-8?B?Q0p2cDRoM1QxUDhzSmNmTUloVjl4ZW5HNEJVUm5heW1xMUFiT3JMS25jeHcx?=
 =?utf-8?B?VHMvM09jV2hqcFRZM3RPMzc3NzkvMmZRQjFNS01EOTFKSlQ3YWhmekFTR0pD?=
 =?utf-8?B?OHdEbFJqaFRhU3cyZWNPbkRaZVFxTVdJQ09wYWRWdUk3QkU3MXNkdUxtZ3F1?=
 =?utf-8?B?TVpKRkNnay9Cd20zR0dDMm56ZHkwOWxUTnVTTTRTSzk0WHA4VGxTTVEvSy9R?=
 =?utf-8?B?b0VoZ09uNnBWMTgycTFlQjBRczVlUWdwTTdiVXdnMXU2RnZBcGRwVkNmOWRR?=
 =?utf-8?B?TEp2N1FQNGFWWldpK2VSTkhSRzcxTUF0RWtzRGdCeHZpektjV1JrN2NoY3VD?=
 =?utf-8?B?MUozZjVBcXFrZStzQ0dKbDM4YTlVNlNoZGtSUE1PSmg2L3p1aktLTXozQTNT?=
 =?utf-8?B?N1ZZNlppRGc4ZzRGMDh4eTF3RzI5ZmtqN3lRRnA1RjBJU1dpVEt1TGRKLzNv?=
 =?utf-8?B?cWtqUkIwei9valNSVFhZQ3B0R1djanhyN0dDZU1zSGRsUUlmZkNIY3VZREIr?=
 =?utf-8?B?Y2hBc05VSUErMzhsU3FCYVQ4Rk9sSVpLWGs3blZHSHVxMVl6Rmt5b3dyZGU4?=
 =?utf-8?B?TkRyaE54ZXNCKy91Yko1VkZ4QkxVaDlVMmRubjY1V3lYUTBZdGZPNkllUnBk?=
 =?utf-8?B?V2tVRGRkbEJqTzVNc05zdXJKSVFDRzhEMFhPVlZ4VHBTSXEvWktvc05WS0M1?=
 =?utf-8?B?SURuVVF0S0RTTm5SOHNhUlFSTVcxTUV2ZmlVTFZ0MG9IUGVjSGpESy9pbzJ2?=
 =?utf-8?B?UmxocTN0MWgrK3pDWWMyQ3d5NkRWbHRoeEdVblo4ZVpXMmVtUHYzVnIybTJq?=
 =?utf-8?B?ZHVoNnJpZnVHYVpnWDdNMDFMeXFNMUdzMDRwcEpqcGY5SlpZa0llaXIwVlVN?=
 =?utf-8?B?VG82NFg1QVkvc1NKYnNlRndtT1ZMZS90K3piVWFYWTZscFoxUi82YmxUaHls?=
 =?utf-8?B?NW4waU1adWpzM2krK2tvRU1TSHpuY3FPVXhoQUNCQ2h3QVNBdUtzQVhvTXNE?=
 =?utf-8?B?Q1F5TnVNQlZnWFE5Kzc0SGt4OXphbjI5VzBXazFjR3NZcko4bG1jMHhFeXh3?=
 =?utf-8?B?Zys0Y1JSdzNyL0FncUVvT0xmdDd4eWFKY2RQWW1xdDJ2Q2p2M0szc0d6TWpT?=
 =?utf-8?B?S2xqMTZwak04SFJBb0JKN3lFa0oybEljNmVFSCs2L1hJVWZpZ3lmMHpiK0Ry?=
 =?utf-8?B?OUxYM0J0bDZ3YjZRU0ZCdDB0Q1hrUmQ2VzJnanBRNWpRbUphLzNqRStEdVZl?=
 =?utf-8?B?UWx4cCt4QkU0T2ZRdTJMNmE5WjF2ZVRBMVExZ2VkQUoxZ2hBTUovb1RVb05v?=
 =?utf-8?B?QU1lQUhQOGtEd3dpWWpjMTB2RHl5NlZpemtUWGdLSmp0R0d1TnBzWlJ4eitl?=
 =?utf-8?B?cWhLVFRuSnltVmFSQWtNNVJWOTQ1WURsdUduSDlPK3gzYXBMVU03SWh5b1FO?=
 =?utf-8?B?Nzg2QlgxMUJ6ZzByS1VJcDhjUUVIZWpiN2xudHNIVjhqVEttM0s4RTZrNHF0?=
 =?utf-8?B?eTB2NzgxWHZhS0ZHV2VKYlNlY05Melg1WHg0RWlzeFdYMzIvK3dlM0NsdVpl?=
 =?utf-8?B?OURFUjJqNWtyVjdoM1JlblVjaDNQN3FIT21vd0IrSnpkUXNLV3BGNTNpTk1x?=
 =?utf-8?B?cjFHZWQzYnljaEhTUC9ERnloTzVRVk1iZXJPSWtYZnBFVEZ5SDdFNXRZK1FN?=
 =?utf-8?B?N09TMVlZQ09ZSTFlOCtNTTdtS0FmajZReFBDdVdrRitKWXJObUNCdDduSnZL?=
 =?utf-8?B?TDJoN3NRUFJiK0xVb20raWFkbzNNdElMN09qeTNpMjNUTEd2NmdROXFNdUxF?=
 =?utf-8?Q?Pbx7c0+bRyYit+etlLscjig=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzJWdFlFb3JEYndocDBSUW40enE2MlI5NTRsUGx6MGRrM2VnMHdFK1N2VkJM?=
 =?utf-8?B?aDYwcndyekRjUTJtUEhtVEgzOFErSGdyeU5lSGRDSlUrQkFCc2t3MS91N3d4?=
 =?utf-8?B?eitQNVNFTnVxNlNIRWtsWEJRU2dQSnhQbnhiS3Aybkp1TmpVamo5aTlSN3Rn?=
 =?utf-8?B?MFFTQXdTY3BLVmRCcW9sSzV1WHBpVGovSkViZDg4UmZyLzJPRDZIeGp1TmNB?=
 =?utf-8?B?VXpCdVJwQ3FnM3BTMjBjaVhsM2ZHbG52NU93TUhldnVzUDB5NXJjaUFPUEZ3?=
 =?utf-8?B?QTFXVzFMQW5iS25oOG5lTmdwc0I0d3dTK290TlNRemtpaWZGeitSY1NlSGFp?=
 =?utf-8?B?eVZqejNtQkdBeTVMZW4vVnc2aFdQK3FWOE01cTkyeGkvSGFjL0Z5US8yeHVB?=
 =?utf-8?B?dmtiME82YTJpQ2FQeU5Da09LaEp2SFQ5REZtK05QUmpyM0VRelpxTHlDeS9V?=
 =?utf-8?B?L3VTSXRYMFd6RW5NTzVTQ1ZHeVlzYjI3bTVPYk9Rd1VHSEFJRitCdVMxazhZ?=
 =?utf-8?B?MWwvOEhRd1NhS2V5OW84MGN0VVl3TytXa0xQZVBGOEdxaWhJVjhhK2NHUFBp?=
 =?utf-8?B?Y0diU3dqZUZ4NXdtWkp2L2Q5RUxpY2JNczJzZUpDZUVkbnQ4ai8xM1pYVGl4?=
 =?utf-8?B?NXJsQmxoQUc1L3JtY3F4amh0TXEyQWU5N2NXTDVHcVBya1lleDBaMm9TVUc0?=
 =?utf-8?B?bS9FWnNqaFJnODB2NFZ0SFR3czdaTklmUXBzOUx2dVVSQU1kMkdzVFAzd0xK?=
 =?utf-8?B?cVM0YVNyWkFpZXBLcHRrbFd6T0xYSUpTckZ3cFZ6ajJCZk5uWFNhS3Z2UU0y?=
 =?utf-8?B?dzNPb2ZZeU1yZE9jVkszRzVHMWVoUzdXb0d0YUFvYzIwRHMrc0tqZUFsYXZH?=
 =?utf-8?B?QWIydnROcmxnUmw1ZnNtMGVCZS9GV3RWSlpWdElydmFtN1JpRkRaVFJ1eHpH?=
 =?utf-8?B?RmtobGZIckZDZnEwSFJLZzhzRng2YllDRDljVUtMK1JHcVl3NkhuOGVBRG1R?=
 =?utf-8?B?OTJQOERYeUIvYlJMNGtYWXEyMlUrcVRVdDZiaWV3TVVEenBjQzZ6Z0p0Si9o?=
 =?utf-8?B?eHY3UEJtdHlLY2VNSEl5VVpwQ0wzR3dsR0JuTHJrY2lDT2g4a1BRK00wMWdq?=
 =?utf-8?B?Q2I5ektwakJRZ1NoYVRVZElaUUExdmR2SzhUYjRhazFtbGFYb2hhRjZ6UHVD?=
 =?utf-8?B?Z3pYamZWUG9pNHBlSUdQbUhjQ2hQV1Y3QTBGK1ExTEYvaVJPL3E2akF1b0V3?=
 =?utf-8?B?QTUycVVDNllmUVFzbkhtRUZOZ3dnblRYdGY5N1gzUWhpN3IxUEdKNWk0Qm5x?=
 =?utf-8?B?enNnRURjY29UcEFUSEd6M0FIOW1UdTNDZmZJdVk4SGMxOGhUamJ3NjlSa3BV?=
 =?utf-8?B?eFYvVDVscGx1bk5wNllOVW51c3h3VDJ3cWdPRjIvcmdxL3lkRUtQZkdZallW?=
 =?utf-8?B?Mnd6MURrTUZUUjIwVHp3UmU2NDZjMlYxQ2xWejJKSjBrQVNIMVJ2c3RzU2pW?=
 =?utf-8?B?TGxwVzkrbVdxQW9SVnVkZTd1UUplbXRSdjlENjYrTzhMckhRWjBxQ2trUitC?=
 =?utf-8?B?NmtzQjRnNjRjckh1MkRqbWNyNDQyb1BhWDMzL2w4bHdhWWIwcVhuYzAzamRL?=
 =?utf-8?B?SnQ3Q2ZtMk11TDFxM1ZocFF5cld3Smlkd1ArZ0JrM2I5U1pLTDZGUy9lTVNV?=
 =?utf-8?B?aTY2T3F4S0srSU96cGQ0dlhLc3VadmNFNWJ6VDVZVExNQzBMTUs2YTFVSUw0?=
 =?utf-8?B?ZmFSMVZkV21BOXZHMGZlbFFvWXI0NTVHQjhCa3JBdWkzNUs3VTFUemYyMS8z?=
 =?utf-8?B?NzhueUc3ZC80bUdsMGR4S2hpaGRtalh3NlJaVjFPYTZGL1Yyc0w4QVlOdkpW?=
 =?utf-8?B?U1JPVUdGVGV1TTBuUUdLNDVZYTRwT1U0bUs3czl6MjVNSHVQcDhnZjlIQVFL?=
 =?utf-8?B?a3V0VExGSVI1RU1FdUZEWTAxSFp0aFhHbGQwMWMyM2hoWXZTNDVaNktjMnRa?=
 =?utf-8?B?OUpzSDlKdjNvQ2tSUTJBMGk5NGNobnA0dDZDZDJrcHlBb0NQdDU2RGlQZ3Ur?=
 =?utf-8?B?V29saWFXVXR1NWZYWlFGL3NQOXdVZmFVUEpGeHNQMFZnNHBqRWlSd1dyMXVJ?=
 =?utf-8?B?R2hGZ3ppWlJJeXdCOVV1QWtHQWZXSGhiMXU2SVN5WThTVXdRb3UzZSt3UUpl?=
 =?utf-8?B?c3JtKytoN0VYRjNPZEIwdkhCZmhvb2Vac0hBYldvcC9iekhHM1dDNjUwbXRX?=
 =?utf-8?B?dDlQdVpPUGloTjVZekh6WlBMNlIrTHNJcmt2S0N0Zko0STJTcUJ1WHZzbjNo?=
 =?utf-8?B?eThRN2FmczJZWDdKK0trSlJXTmpCWC9PaFhmRXVJN09Ka1lIV2laQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C838D0354D0CA4F8F0CE6371F05B9CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QTJ6TSaZscUnHcbNk750L9EptbqCpHsGvGfbfV/r8u3N942Qq88MOg/NxKSAI2S3Yv3KU/k7RHwQCc8yxdLhBoQ4OU4bs8Le6rTO5xt05QNJH3jBcbAUuOZLwtOG0VOUW21XjKFZhqy3PsoF4zlLm0XMMCmP4x5x3zXJTSb6HgrZZq8adBbETNYeAmY32s4B+xOi1MubiKxfx3h4PW5qnPDPof0PZEEzMo9Js8gbkDHlu/aGLUV9CBpjfxemcvUi1LAke2CUfwPjm5gtAiMTdP1pGr2/myC/LvqH/rGQ8xZvKLgAklYmlglgrNweOzx8pEUaxDMEmwOph8BL2SzGqFkjrUPMCfGWNUREutZdH6KTUaxut/cqSO6MPVMJcyzw6aU6vMFA12W8d9gl8CN24ia4csYhDlj+A5Wf6lA747DuUgRXvu0lX/NVMKL9Dlvl4rLaQ8x7zb5LKbJ8BgYiwyOyWg68JIREHgTiAC7x+/a+xtYHKEt43O7jSjuQAmGpzGg55vwlYDzYd4KTy81635V+PD3Oyb/qs7SdpB0Xh/PiIKPWz3HaiLbMReM/Ds4voH+P0eQSaNnqxhjJWXdvwNI2SJfNPEonrFGeiyCgIsxsY17dOPrPksgrr4h4Mwy9oqszb264r/Racrga1STIkw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a419491-1d7c-4b8f-c27e-08de6390c160
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 01:57:30.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2xeedS3VT93peBAyuAH3czY4ioHGPaDTur7dw2QB7H7UIkcWRzl10OYSk6+1R/mKHupIEcrIZ399Xcn7Gp+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
X-Proofpoint-ORIG-GUID: rK0isCNkkA-yMxDZ8LQC7uoVxsBpZPtG
X-Authority-Analysis: v=2.4 cv=Kp5AGGWN c=1 sm=1 tr=0 ts=6982a78f cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8
 a=jIQo8A4GAAAA:8 a=fL-BTf_Akv9jInFKFIkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAxMSBTYWx0ZWRfX8GhHn2bDY4s7
 BlriaQaNWw/fgQiyRyJpUVOO8HGYcJM4EeywbYJMq6xpDoWG4rZxDUmzq98Ep0aj1Y1Rv9snzXX
 h93niBNeVrrvwv/8LjpZGSr1WM+T5/6IAO7Ev/Wu+2IIXNSUrXlk3z6ahJdZnlCrCZCPWnH39tW
 vm2aOsNobKi4i3AqYLYlfNFg8CYA5o6O4CYyUF2MH9XD9+EHmCaLCFTRI4OzocgKkM1rzWWKjKz
 eW/4lHPVE9D2Z6OvO6OXIys7qYTGleiusk9lVLSE6Y2R/Fi2qi1i+fcv/kJ8fwSRGElmGZbm1Md
 VmyvWnQBIaDP6mZfhxbS0N5pZAwzkHosyNhZfeyNFAEJjoPqLI0ap+RQOt3C5yPaCycdRAk+roj
 Kzp+oJlahSfyvdVrgUngeNfYi7+oR29v59KbQa64yoR9TG6kgnk/n4w9WvCxVJ0JiLr82WwFOYG
 pkvhP3uIOlVIntWQ20g==
X-Proofpoint-GUID: rK0isCNkkA-yMxDZ8LQC7uoVxsBpZPtG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1011 malwarescore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2602040011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	TO_DN_SOME(0.00)[];
	DKIM_MIXED(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213335-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synopsys.com:email,synopsys.com:dkim,synopsys.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,urldefense.com:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 9DBA2E09CC
X-Rspamd-Action: no action

T24gVHVlLCBGZWIgMDMsIDIwMjYsIFByYXNoYW50aCBLIHdyb3RlOg0KPiBDdXJyZW50bHkgZHdj
M19nYWRnZXRfdmJ1c19kcmF3KCkgY2FuIGJlIGNhbGxlZCBmcm9tIGF0b21pYw0KPiBjb250ZXh0
LCB3aGljaCBpbiB0dXJuIGludm9rZXMgcG93ZXItc3VwcGx5LWNvcmUgQVBJcy4gQW5kDQo+IHNv
bWUgdGhlc2UgUE1JQyBBUElzIGhhdmUgb3BlcmF0aW9ucyB0aGF0IG1heSBzbGVlcCwgbGVhZGlu
Zw0KPiB0byBrZXJuZWwgcGFuaWMuDQo+IA0KPiBGaXggdGhpcyBieSBtb3ZpbmcgdGhlIHZidXNf
ZHJhdyBpbnRvIGEgd29ya3F1ZXVlIGNvbnRleHQuDQo+IA0KPiBGaXhlczogNjZlMGVhMzQxYTJh
ICgidXNiOiBkd2MzOiBjb3JlOiBEZWZlciB0aGUgcHJvYmUgdW50aWwgVVNCIHBvd2VyIHN1cHBs
eSByZWFkeSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFRlc3RlZC1ieTogU2Ft
dWVsIFd1IDx3dXNhbXVlbEBnb29nbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQcmFzaGFudGgg
SyA8cHJhc2hhbnRoLmtAb3NzLnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6
DQo+IC0gUmVuYW1lZCB2YnVzX2RyYXdfdG9fY3VycmVudCBsaW1pdCwgYW5kIHJlYXJyYW5nZWQg
dGhlIG5ldyB2YXJpYWJsZXMuDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDEyOTExMTQwMy4zMDgxNzMw
LTEtcHJhc2hhbnRoLmtAb3NzLnF1YWxjb21tLmNvbS9fXzshIUE0RjJSOUdfcGchYmwxeUo5LXVH
NkllaW5ReEwxaTd3Y0RDUzI0Vzk2dENCV2l4djBIM2RWemxGcXBBQ1M2SDhwbld2SkdWSjYta0Ew
WTVNSXpzX2lMMmdIaGNFZXJfbTVRUkU5eXUzbzQkIA0KPiANCj4gIGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jICAgfCAxOSArKysrKysrKysrKysrKysrKystDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaCAgIHwgIDQgKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8ICA4ICsrKy0t
LS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiBpbmRleCBmMzJiNjdiZjczYTQuLmNiNWU4MjlhYWFlOCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9jb3JlLmMNCj4gQEAgLTIxNTUsNiArMjE1NSwyMCBAQCBzdGF0aWMgaW50IGR3YzNfZ2V0X251
bV9wb3J0cyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICtz
dGF0aWMgdm9pZCBkd2MzX3ZidXNfZHJhd193b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykN
Cj4gK3sNCj4gKwlzdHJ1Y3QgZHdjMyAqZHdjID0gY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBk
d2MzLCB2YnVzX2RyYXdfd29yayk7DQo+ICsJdW5pb24gcG93ZXJfc3VwcGx5X3Byb3B2YWwgdmFs
ID0gezB9Ow0KPiArCWludCByZXQ7DQo+ICsNCj4gKwl2YWwuaW50dmFsID0gMTAwMCAqIChkd2Mt
PmN1cnJlbnRfbGltaXQpOw0KPiArCXJldCA9IHBvd2VyX3N1cHBseV9zZXRfcHJvcGVydHkoZHdj
LT51c2JfcHN5LCBQT1dFUl9TVVBQTFlfUFJPUF9JTlBVVF9DVVJSRU5UX0xJTUlULCAmdmFsKTsN
Cj4gKw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlkZXZfZGJnKGR3Yy0+ZGV2LCAiRXJyb3IgKCVk
KSBzZXR0aW5nIHZidXMgZHJhdyAoJWQgbUEpXG4iLA0KPiArCQkJcmV0LCBkd2MtPmN1cnJlbnRf
bGltaXQpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgc3RydWN0IHBvd2VyX3N1cHBseSAqZHdjM19n
ZXRfdXNiX3Bvd2VyX3N1cHBseShzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiAgew0KPiAgCXN0cnVjdCBw
b3dlcl9zdXBwbHkgKnVzYl9wc3k7DQo+IEBAIC0yMTY5LDYgKzIxODMsNyBAQCBzdGF0aWMgc3Ry
dWN0IHBvd2VyX3N1cHBseSAqZHdjM19nZXRfdXNiX3Bvd2VyX3N1cHBseShzdHJ1Y3QgZHdjMyAq
ZHdjKQ0KPiAgCWlmICghdXNiX3BzeSkNCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVQUk9CRV9ERUZF
Uik7DQo+ICANCj4gKwlJTklUX1dPUksoJmR3Yy0+dmJ1c19kcmF3X3dvcmssIGR3YzNfdmJ1c19k
cmF3X3dvcmspOw0KPiAgCXJldHVybiB1c2JfcHN5Ow0KPiAgfQ0KPiAgDQo+IEBAIC0yMzk1LDgg
KzI0MTAsMTAgQEAgdm9pZCBkd2MzX2NvcmVfcmVtb3ZlKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAN
Cj4gIAlkd2MzX2ZyZWVfZXZlbnRfYnVmZmVycyhkd2MpOw0KPiAgDQo+IC0JaWYgKGR3Yy0+dXNi
X3BzeSkNCj4gKwlpZiAoZHdjLT51c2JfcHN5KSB7DQo+ICsJCWNhbmNlbF93b3JrX3N5bmMoJmR3
Yy0+dmJ1c19kcmF3X3dvcmspOw0KPiAgCQlwb3dlcl9zdXBwbHlfcHV0KGR3Yy0+dXNiX3BzeSk7
DQo+ICsJfQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTF9HUEwoZHdjM19jb3JlX3JlbW92ZSk7DQo+
ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gaW5kZXggMDhjYzZmMmI1YzIzLi40MmNkMTY2N2E5MWIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5oDQo+IEBAIC0xMDU4LDYgKzEwNTgsOCBAQCBzdHJ1Y3QgZHdjM19nbHVlX29wcyB7DQo+
ICAgKiBAcm9sZV9zd2l0Y2hfZGVmYXVsdF9tb2RlOiBkZWZhdWx0IG9wZXJhdGlvbiBtb2RlIG9m
IGNvbnRyb2xsZXIgd2hpbGUNCj4gICAqCQkJdXNiIHJvbGUgaXMgVVNCX1JPTEVfTk9ORS4NCj4g
ICAqIEB1c2JfcHN5OiBwb2ludGVyIHRvIHBvd2VyIHN1cHBseSBpbnRlcmZhY2UuDQo+ICsgKiBA
dmJ1c19kcmF3X3dvcms6IFdvcmsgdXNlZCBmb3Igc2NoZWR1bGluZyB2YnVzX2RyYXdfd29yaw0K
DQpUaGlzIGRlc2NyaXB0aW9uIGlzbid0IHZlcnkgaGVscGZ1bC4gUGxlYXNlIHVwZGF0ZSB0aGUg
ZGVzY3JpcHRpb24gaGVyZQ0KYXMgbm90ZSBwcmV2aW91c2x5Og0KDQoiV29yayB0byBzZXQgdGhl
IHZidXMgZHJhd2luZyBsaW1pdCIgb3IgdGhlIGVxdWl2YWxlbnQuDQoNCkFmdGVyIHVwZGF0ZSwg
eW91IGNhbiBhZGQgdGhpczoNCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

