Return-Path: <stable+bounces-54794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E715911B81
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 08:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240BC2821D8
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0E16B3B0;
	Fri, 21 Jun 2024 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EeiVy0wT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D/z0iL23";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IkpTBnOI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175215532C;
	Fri, 21 Jun 2024 06:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950853; cv=fail; b=EH2X1n0jPa13AGupok1Gw2JUASD/sKBbkfq3jHDN3ksuKq+2XARJnyfbdfRgp4roqPD2R0UPKtzBeJ6gUNnwfBpl24rGEsRZPoLLPRWHkQm9SqupxJvqByGJmDDSRiWMrlaBwO815+9wlBA9P3Rh85bMac8SHiCz1fiBzVcuKAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950853; c=relaxed/simple;
	bh=GDJQp8BXzSiSGapuczmTPFyNfZtgFGw9YMtYVQ5O0GA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ItBxgVhR6/uaU/XdTbGrX9kttJz5pgdutZz1za4r9JKr3Yni4AoRgFIhiTcDeyuUhqDsO6BpD7ai15yoW3piVAEfA3So/LbZ9ufjp/egoM869aHPcGbIyttAeGCElYU4ERFX67Hh/kDAn+QcJf6ZvIDLLZlER5uVw6Ja4FrB62c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EeiVy0wT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=D/z0iL23; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IkpTBnOI reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KNK9Ym030085;
	Thu, 20 Jun 2024 23:20:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=GDJQp8BXzSiSGapuczmTPFyNfZtgFGw9YMtYVQ5O0GA=; b=
	EeiVy0wTleJVGQikvqsjN1FHlE7V8j52lvY8SwVyCNa2zNdZHNdL4NFmfFze7+vY
	SKVNpoetZct2UndwvtAkMZTqyA2xjLzuiwsf1bWtsupb20DMD6LlmjLOLhXf5VkU
	irTC++ln6EeTv/K70eHBJpXC6bi1M2+qmMK3rCn+cIqtoClxACpr9uwOxKH7jCFU
	F8GVTV0vSsHLDAaL/o4yp61e6C9b/0bfxWMcJ/YlSE6922y1zrJGyet0Zz/X4I1t
	HQve9TtBGknXrKUzg0A1Y+/BGvTwmLFlyKf5VgNwZPS8T5D+O/43E47PAk/8WLP7
	qIA6Tx0QGtqWFN6i/X/Ghw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3yvrhyjpqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 23:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1718950843; bh=GDJQp8BXzSiSGapuczmTPFyNfZtgFGw9YMtYVQ5O0GA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=D/z0iL23QJjgXYQD6Dythu7+QCeCW4WCf3JUbL8TNPaB//HQqr6u9bxThwVxDflfY
	 AT+HyDXyI+H1HPnsRzQNjIext4gK9dSkI6/hwD8KlFXuLUrMYInqpK/Dz/rJ9OQjVP
	 NPC5xWGnC0yDFTgO3YnX/LudWBUCRDMX1uDJT+LBCmxpYv2Lg711SZDkUi+hEP8Zmq
	 Dixysa0wP9i4ajU9RxE9k6K9exsbI/GhQjuSRizYsDTy1HEZx1U2PKZHYnc1XsBRnX
	 qpGITQ50wgK8Y5BJNk6uCbzmkeO2WRQztj6B/r8EQuWNgmlxniCXUbThARDz2pTW3r
	 8dydyBJU7jLcQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 51BB240467;
	Fri, 21 Jun 2024 06:20:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B1080A00B8;
	Fri, 21 Jun 2024 06:20:42 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=IkpTBnOI;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 11AF540364;
	Fri, 21 Jun 2024 06:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZmd1TWJfAPxcp1F53lnjEQMuy0iOS/6sl0fXgPOq1pZCpg7qTOBs9fS7Wc0H4VqKp76YDOhNEnNhM+q7+a2+Eec1zCqbYyxqsVBkleMWyiX80dYVAr38vh/is5BNO69IFOpsny7u9ftIB6S77GYzGhYHKCiRc2YGAWwm7HJOQVUv/hy7g4tj2+FYqKxZ5BXAkXoylm2gRR1Q1UUXzPkjxXD19QPP5rsAFaO6r/Nm1a6Gw3OJZJdtb2m/DCTXcbBEYUHj9Wv+T99O4DCz+X8/0DK9rzTcBJjIU0CyDhtDOhwRK0LKdgV5cESuQtMkWEG+QNRHcjD9S6l0DGMezq10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDJQp8BXzSiSGapuczmTPFyNfZtgFGw9YMtYVQ5O0GA=;
 b=DZYCqRDlQl3PA9Pw37k8hQxzDFYMRx2ECKufN5iR0YgdyxEB+Y9Voc2DXZY4+1uePkaBxhl5T2XPKauRPXjlQxnOKTp97ajVgIqsXKQ86G5wTuhE9CEoGLmNritl9rqdp+f6xBcuNl3QaUkpFBHrRa796aeX+2v0BMT9RWDYYWEDmg0+qdQvj59PZSKD2t+mrbDSARV2a6w1ws2eQa2fC8EExppnijw2mp5WpPN1bWOJCNGg/Vlz9Vldnm7qiUfiHZcw75FQFfcwrnbj5iBJprPwcFX9sMDKSaVkypF7ar/+B6HftedjDvAvKeiHUdo4Ha0WdBgi+SYkiyk4eptheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDJQp8BXzSiSGapuczmTPFyNfZtgFGw9YMtYVQ5O0GA=;
 b=IkpTBnOIQOTMfI+4mTIWt2rMZNT13G3FjKNT48uVGsXwxelUxKsuY7QuCDWP/s4f4oW9O6/0RM5v+5P+XO/Lm42QAaKrRsGY3XLFqVxh5EM9guv/pKAVEKTs2e51HQGXqxvfeJgFbM0QT6J9R7IIHqRe5lgcnQ7UUha/UUaRTNw=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 06:20:38 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:20:38 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, joswang <joswang1221@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jos Wang <joswang@lenovo.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Thread-Topic: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
Thread-Index: 
 AQHawj43Ri5O9FacdU6gpV1LQKb6abHQ5pwAgACMzwCAAD1DAIAABnyAgAAB9ACAAAinAA==
Date: Fri, 21 Jun 2024 06:20:38 +0000
Message-ID: <20240621062036.2rhksldny7dzijv2@synopsys.com>
References: <20240619114529.3441-1-joswang1221@gmail.com>
 <2024062051-washtub-sufferer-d756@gregkh>
 <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
 <2024062151-professor-squeak-a4a7@gregkh>
 <20240621054239.mskjqbuhovydvmu4@synopsys.com>
 <2024062150-justify-skillet-e80e@gregkh>
In-Reply-To: <2024062150-justify-skillet-e80e@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA1PR12MB8886:EE_
x-ms-office365-filtering-correlation-id: a34c1603-5d04-4988-e398-08dc91ba44de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TURNM3F0eVpReTJwbWJ6RkZyS0t6MjdjQkdsamlBelgxc3U3WmNFVnZqVmVl?=
 =?utf-8?B?dzVMVkErK3BuR05DM1dpRmZWWGJZM1B2RWhJeVgrSkpkTzBnTytZb1dYZGFD?=
 =?utf-8?B?QThRTlBpT05sb1BySTI3eDVEa3QyaEtsRGpIQThRODNpRWRaWkNVZVJFd2FH?=
 =?utf-8?B?bDFwdi9sTml3WEZ0VXZVakJqT290eFRJaUdoTnkxa3RUT0ZXQWdJdzdvbVdi?=
 =?utf-8?B?WllIdWtSVkkvL1VOUEg4TDdPMzFkcnBLYmY1cDBvRGlnSmRSR1NOc1VnNWI2?=
 =?utf-8?B?OGNYOWU3a0thQVBKUmRMTFR1VktnMmlCbGhQR1RrNnJYQ29EbGVkOW43aWdn?=
 =?utf-8?B?eERRV2NhOHBKSTVzaVFnbTZCYkxLVDNhcW4vQStQQkxNTzVNeFBzYUNwbVhN?=
 =?utf-8?B?VGl0QlVFeHlZd2xSaDkrSENQTGRPWm1XeExBVWFmZ2NrQUJMTFBtTlM5TmJn?=
 =?utf-8?B?ZjJXc05aNEtZeVhFZmIzam9CUGV5ZkMyc3VJUy8zMU9MRDVSRm9RS3NieWZ4?=
 =?utf-8?B?Vnh6QnBVT2hiYWFSdjdYYnE0TnhjdDZSMU4zOGdhT0xaZUZzY214N1BQOFJx?=
 =?utf-8?B?bXNQK0FZSGt3clVFdWlEalRIRmJNWFlFQWoyMUFFS2pXMHFIdlRZb1BSaXdL?=
 =?utf-8?B?dUVsbTYzTTJ0ZTN3TmVQa2h6Y01xb2FieUF3NmNvb1h2V1NudnJETHFneFc4?=
 =?utf-8?B?U043UU4xM25CUVRPWkJ1ejFjZFpjMlpiY0psK2U0WmpsNWNxdHo0c3l6M2dE?=
 =?utf-8?B?cHRROG1zeHY1UDVvVWNyQStiVFNxcThGSGxiZE9ZUWZrR21vRWYwakxWbytq?=
 =?utf-8?B?TlA5TkdNWGFTL1Q2NS8yWDlFQjF4TUlsd1BKeGNMRTdBWW1aYXA4Zzc4aUww?=
 =?utf-8?B?YWtjYnhubGhqS29LUlZRUHpNQ293MDNJSHQyVnA4TzBkSVBYVlhVY1l3MHRz?=
 =?utf-8?B?TlNnb1U1L3JEY0d3Mklacm4ra2NJZS9qRjFMckc1WmRxWFpvejk2aFM2amt2?=
 =?utf-8?B?U1pETFVCbVRVSmtRdnAyVjBxb24rZ2xidnh4aWpEc0lYRmhvZ0c4WWNPemRQ?=
 =?utf-8?B?c3BEZkxsdnlvaHdZUFVIaUU3cjZsNlVzRWN0SitzT2FCT0tDSE1XWDFFb3dV?=
 =?utf-8?B?Q1FvYlp5M2Y4N3hybnlORWlDcGl5Zzk2a3FxSzlQLzRMWXVLMDlGZ2Fyek1u?=
 =?utf-8?B?M3J2M2FKNkRBQ3FybjVjeVR2RnZwa3pZMU1oVmFtRU5UT0pkUHJ6dGgrTHRp?=
 =?utf-8?B?MlltOFE2anJWcjIwM0RRS3ZYOGV3Wk5KMkRRMXVFcFBQdFAxUEVUL2s5NG5m?=
 =?utf-8?B?cGhuZFhBUTVnemZpUmVsbXp4eFc2eWYyYUJhTFBUUlNmMHk1Q1I0VDIrSWtQ?=
 =?utf-8?B?bWI0V0UyZlFZMXhWMWN3MHBBZG9YT1JseXZyYzB3UnRlOGErQ3l6QUFITndB?=
 =?utf-8?B?VkRpWCtRQllJOFdaYmNMWG5qeGFiT0RLNVhOQTJYRjYybmtNSU1Oa1hEeXEy?=
 =?utf-8?B?Z3dkMXBIZ29aeEkzODBLRy9zdTlyR1A3S2xkdzRDYnhjWHR4eENmaXh5Q2dR?=
 =?utf-8?B?SmxmN2JwTzJjcGxoakpnK2NLaE9jU3FjZXM4MzJvejc2QUs0L1FMSWI1RVIz?=
 =?utf-8?B?S1VzTkwwTmJ1YlczSVhGWm5rYmNXWkwwaVFsb2pIU3krZzRPaWp0TUZSUCtq?=
 =?utf-8?B?Vlc2M3Y3N1NJdkVaUFhaSFh0SElvR1FKeWNmeWVQRzR0c1BleDM4V0w5ZTNL?=
 =?utf-8?B?K3BTN0IzRjZpOFJ2SFJ0SVZNM0RKNHp4WFRBQ3dRN2hXWlNkR1dBeHBRaVZ1?=
 =?utf-8?Q?YIv52eph7RvljicMhQlMhFzK3xlgGLdRfzIR4=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YlVxeUpkN054ZXlWYWlNVTkySS9YbzZaejFxNEJRUjhlL09lTXdCckk4TnNa?=
 =?utf-8?B?SGhQQm9YeGticWcrSFl6UFM5WldjOCtFd25CU0RkRUlUUUsrQVNwSmE4QTdC?=
 =?utf-8?B?eWRadTA5UUVEeEdBcUpReHNKT29xQjdHeHFHcE0yenllblJmNWVBVkxlNzZi?=
 =?utf-8?B?YUh5dXZxU0draGpoVytmUjAxcDZCSkd0V1dHYzNnOURKWDBINzRxdnU2ZzdU?=
 =?utf-8?B?SVE2aUFvQlkvbURyRnBYaHBkUTRCeWowZ2hsbzFQRVhoZ01lWEpCVlFlb2x5?=
 =?utf-8?B?TnBaYklYMGdvZFJWRDhSTHdNT3JWVDZYTlV3K3ZFeXFxcmNlbjZidXBocG5y?=
 =?utf-8?B?ZXBrczRITUZPZ3I5U3ZCSlV3MlovNlJBd1F3WitXeEEvL2hLQlpmYWF1cG1u?=
 =?utf-8?B?VGo2TlVHUXBtT2tpQlhrMzJlano3dTBZOENoZ1RmYUNha1lsZkY3ZmF3WmNP?=
 =?utf-8?B?bWVJcDdzVzhURTd0T2JRaStHekZLdmZUeEk5aHVJSk9hckY5N2g1SkNycStE?=
 =?utf-8?B?eEJHb0NXWWtKeTVNNStJdlVrZ0NkOU9LWmZYU2NjaHYvU2lOTHlTdmZod2Jr?=
 =?utf-8?B?R2JlbVk2ZlBmLy8rS3Zobm9wUzd4STA5amlnT3dWd3RaSmRocHRXdnpBSWZ4?=
 =?utf-8?B?RUoyNUEwUGtpdjE4Vi9CMUVrL0NhMFQ2RXkyakI2OUVVbVdTWGlJeC8yUGd6?=
 =?utf-8?B?NWYrQzA3dTVCZk92MU9NOGkvVDBGY3c0RnVqNXVkaWlYWEFhQlNQRCtPK1dJ?=
 =?utf-8?B?ZUFsdis4YWJVUm5lL0tFVXZDNXNGaWFtMnBqMFUrVEVuaWVMdUhENGYrQnhQ?=
 =?utf-8?B?U3dZcTJRTHRmQmhFY1h4d0ZJcU51N3RtV2NraWtlT1RiWTlNQmFkVmlEaE9W?=
 =?utf-8?B?aXgvaUhDVnF2ajltVEluRWw4bEVQNHh5aHhaTDBuQ3ZKb0hrdkYzazBpdUNu?=
 =?utf-8?B?Rk5EaFJEemxQTngzYnh6TExWSUlwcEtWdlFJOFRDNDNZNXdGRi9PMnBBRk8v?=
 =?utf-8?B?cCtCS3AxSzdsS0dBS05YRG1UREowUEc0WFQwNVR6Q1U2WkwxR2ZvaGFyTU1x?=
 =?utf-8?B?WXdIdWhrSEdaTG1YemtrUCt3SlFscmtNbEpBNjZ3UjU1OTdHclFsRDIvOXRQ?=
 =?utf-8?B?cVhZeXFtYUFDWHoySER1SURrVmd1MERCVWxMOGtpS2dvQlZOckdFVmw0d3cy?=
 =?utf-8?B?aERMVW9DeGZNZHYxZFRmTFFBM2wzekdibjhPOVpVVmhScmVSZlE5RFBHeGNv?=
 =?utf-8?B?bDVFcGdRZlRoWCtCSndTUGFuNjhPNUViYzFJUndJQVE0Vk1tS1Nkd1FaMFdw?=
 =?utf-8?B?by9nMkI2VnROeFNSRGhEVFRRaTBITTIxWUllcHNkLzdha2x2YWdyRFlUQzd4?=
 =?utf-8?B?UVZNU0M3aGNFd2lpcVVxeFcxWnBFWTdLY2VWS1VJUk5hbWNjMGhUU1FUQWlC?=
 =?utf-8?B?RU1obTNMSkpUdGZVR296aGtTZkxteVZrZ1IwZTBiTEdudXNXRDljOExtY2xQ?=
 =?utf-8?B?WW1oclQ5UXVqZUVicm10eTYvcUZsVkpPclF6elUzbjE0UWFXRGhNVzVLS2th?=
 =?utf-8?B?bTNSZDVDMG5scnd1bHhsOElLQmI4NlNQdDg2UFhqSVZjSFdYTjVBKzdPeEd2?=
 =?utf-8?B?UjkyTG0xSitUanJNUXMwQ3lSRHFpLzBTQlJUYy9jZko3dXVkeElqb1RETTJS?=
 =?utf-8?B?MzJCcTlRN0UxWVVvczdvT3Nmc2dxZ2o3eUxDeWxZQ1NOZEdLWTlGVmRZWmtK?=
 =?utf-8?B?VW4zRUo4aE91NTljeU9Kd1MzLzNYY2JjcmNoU2VPRjhyamhtdXlKcjVUQWN5?=
 =?utf-8?B?RmZnbU5UdXB3Z2dUNVM0ZVdqVk1jdy9STGRtZ1RGem1kdC9Pa2JzSXZZQlc5?=
 =?utf-8?B?bnRVYnlqNDdldmI2S1JSdkZWOHZ1eUdCOHJXemxDMmhUcytzQ0I5ZGRFOXlh?=
 =?utf-8?B?bnYwSmgrYWxIY0ZlQWk3OXRjcGhiK3lGQTRzbUtEdnFMTUFWKzJDY1VkRWFH?=
 =?utf-8?B?R2p5WGlLUVVEdnY1cVpoQTZITVJMTk96ZFZ1SW05Y1liTnlYMU9jd2p3YXMv?=
 =?utf-8?B?bnE2UzZSc3djYVBqZUtFV29ZREhrUC9rTWNWaW1YNEUrL1JJdlU5SWdXczlI?=
 =?utf-8?Q?9cIp0VqzllwYIrPYtRJoH5M67?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <833F8FF0FC3641449CBF939A571AC693@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qb3pz5MyXwT/LPIrU4yQn4ma6NwLM/VxWFS0v9ez8lWmqi6l3C4bzYmmJ6b8aL7WS2XxGx/rPqg//XEEQ9GAIQMDvHT3ghDNiN26FzhKBLj0mOswdkVcv1Hse6Pc0oMJAhBY8npdhXLJpKmZYbGVrbi/4VxZTgzeZaK9oQRhaCQHJp0bGBmudiMEsDZIOkL2NDDh+uiaENV9TQNcqgqXQ4Gm/mNEAW5MsZDRu3EYxBCCIZdRW44cAsdGOUkoDp+5dT5y8JbuNeLcWNl7vgftx2wQVEzSmHxzKmYfGzyiWHB3Z4ZxTki2E40cWMrl+bMBXTOGogW412rXMV/8dbMrsjYPMCtSgnlNi8sLhT+ZHLQKr+kMGr0AeRBoD+L3f8beKFO8ADwCH3hj01xPK1tvG+NklCmvW3Bj7/G4k1exjmbNp3HfxOMtcmOCUz/vLDSkk8N0DrTvePxQ/VhMgWXv9eGxwN4SNQkeh0zobdsQhBuNwYxeZAVHwEtheCQcmoFkwoCITLa62X2HuJFk+Rf7UbNop1SO0j+yzHF5IJaYp0bOGXRDJYeL/1/12fdPbq/+CCMPt8m4lqI89krVBeoxLRFw03MWxVtuGFCdC1J7VM1O9bTFpBZ3GMY1RLOc65cKVEJ6R+IaOYtPrGrJTjHbuw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34c1603-5d04-4988-e398-08dc91ba44de
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 06:20:38.4636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iNTKdrzRtoWZMPjHrpugzFS/I1I/knE/9UdTaVT+v1HeRxfx5ebk63BnJDEdkqT3q9FGx3OFCvXn2QCFjUKp3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
X-Proofpoint-ORIG-GUID: l27Azq7SR74_MOqMHBZ6IrvhnJxn15Sm
X-Proofpoint-GUID: l27Azq7SR74_MOqMHBZ6IrvhnJxn15Sm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_12,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406210045

T24gRnJpLCBKdW4gMjEsIDIwMjQsIEdyZWcgS0ggd3JvdGU6DQo+IE9uIEZyaSwgSnVuIDIxLCAy
MDI0IGF0IDA1OjQyOjQyQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBGcmks
IEp1biAyMSwgMjAyNCwgR3JlZyBLSCB3cm90ZToNCj4gPiA+IE9uIEZyaSwgSnVuIDIxLCAyMDI0
IGF0IDA5OjQwOjEwQU0gKzA4MDAsIGpvc3dhbmcgd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgSnVu
IDIxLCAyMDI0IGF0IDE6MTbigK9BTSBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBXZWQsIEp1biAxOSwgMjAyNCBhdCAw
Nzo0NToyOVBNICswODAwLCBqb3N3YW5nIHdyb3RlOg0KPiA+ID4gPiA+ID4gRnJvbTogSm9zIFdh
bmcgPGpvc3dhbmdAbGVub3ZvLmNvbT4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGlzIGlz
IGEgd29ya2Fyb3VuZCBmb3IgU1RBUiA0ODQ2MTMyLCB3aGljaCBvbmx5IGFmZmVjdHMNCj4gPiA+
ID4gPiA+IERXQ191c2IzMSB2ZXJzaW9uMi4wMGEgb3BlcmF0aW5nIGluIGhvc3QgbW9kZS4NCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGVyZSBpcyBhIHByb2JsZW0gaW4gRFdDX3VzYjMxIHZl
cnNpb24gMi4wMGEgb3BlcmF0aW5nDQo+ID4gPiA+ID4gPiBpbiBob3N0IG1vZGUgdGhhdCB3b3Vs
ZCBjYXVzZSBhIENTUiByZWFkIHRpbWVvdXQgV2hlbiBDU1INCj4gPiA+ID4gPiA+IHJlYWQgY29p
bmNpZGVzIHdpdGggUkFNIENsb2NrIEdhdGluZyBFbnRyeS4gQnkgZGlzYWJsZQ0KPiA+ID4gPiA+
ID4gQ2xvY2sgR2F0aW5nLCBzYWNyaWZpY2luZyBwb3dlciBjb25zdW1wdGlvbiBmb3Igbm9ybWFs
DQo+ID4gPiA+ID4gPiBvcGVyYXRpb24uDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvcyBXYW5n
IDxqb3N3YW5nQGxlbm92by5jb20+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaGF0IGNvbW1pdCBp
ZCBkb2VzIHRoaXMgZml4PyAgSG93IGZhciBiYWNrIHNob3VsZCBpdCBiZSBiYWNrcG9ydGVkIGlu
DQo+ID4gPiA+ID4gdGhlIHN0YWJsZSByZWxlYXNlcz8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IHRo
YW5rcywNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGdyZWcgay1oDQo+ID4gPiA+IA0KPiA+ID4gPiBI
ZWxsbyBHcmVnIFRoaW5oDQo+ID4gPiA+IA0KPiA+ID4gPiBJdCBzZWVtcyBmaXJzdCBiZWdpbiBm
cm9tIHRoZSBjb21taXQgMWU0M2M4NmQ4NGZiICgidXNiOiBkd2MzOiBjb3JlOg0KPiA+ID4gPiBB
ZGQgRFdDMzEgdmVyc2lvbiAyLjAwYSBjb250cm9sbGVyIikNCj4gPiA+ID4gaW4gNi44LjAtcmM2
IGJyYW5jaCA/DQo+ID4gPiANCj4gPiA+IFRoYXQgY29tbWl0IHNob3dlZCB1cCBpbiA2LjksIG5v
dCA2LjguICBBbmQgaWYgc28sIHBsZWFzZSByZXNlbmQgd2l0aCBhDQo+ID4gPiBwcm9wZXIgIkZp
eGVzOiIgdGFnLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCB3b3JrYXJvdW5kcyB0aGUg
Y29udHJvbGxlcidzIGlzc3VlLg0KPiANCj4gU28gaXQgZml4ZXMgYSBidWc/ICBPciBkb2VzIG5v
dCBmaXggYSBidWc/ICBJJ20gY29uZnVzZWQuDQoNClRoZSBidWcgaXMgbm90IGEgZHJpdmVyJ3Mg
YnVnLiBUaGUgZml4IGFwcGxpZXMgdG8gYSBoYXJkd2FyZSBidWcgYW5kIG5vdA0KYW55IHBhcnRp
Y3VsYXIgY29tbWl0IHRoYXQgY2FuIGJlIHJlZmVyZW5jZWQgd2l0aCBhICJGaXhlcyIgdGFnLg0K
DQo+IA0KPiA+IEl0IGRvZXNuJ3QgcmVzb2x2ZSBhbnkNCj4gPiBwYXJ0aWN1bGFyIGNvbW1pdCB0
aGF0IHJlcXVpcmVzIGEgIkZpeGVzIiB0YWcuIFNvLCB0aGlzIHNob3VsZCBnbyBvbg0KPiA+ICJu
ZXh0Ii4gSXQgY2FuIGJlIGJhY2twb3J0ZWQgYXMgbmVlZGVkLg0KPiANCj4gV2hvIHdvdWxkIGRv
IHRoZSBiYWNrcG9ydGluZyBhbmQgd2hlbj8NCg0KRm9yIGFueW9uZSB3aG8gZG9lc24ndCB1c2Ug
bWFpbmxpbmUga2VybmVsIHRoYXQgbmVlZHMgdGhpcyBwYXRjaA0KYmFja3BvcnRlZCB0byB0aGVp
ciBrZXJuZWwgdmVyc2lvbi4NCg0KPiANCj4gPiBJZiBpdCdzIHRvIGJlIGJhY2twb3J0ZWQsIGl0
IGNhbg0KPiA+IHByb2JhYmx5IGdvIGJhY2sgdG8gYXMgZmFyIGFzIHY0LjMsIHRvIGNvbW1pdCA2
OTBmYjM3MThhNzAgKCJ1c2I6IGR3YzM6DQo+ID4gU3VwcG9ydCBTeW5vcHN5cyBVU0IgMy4xIElQ
IikuIEJ1dCB5b3UnZCBuZWVkIHRvIGNvbGxlY3QgYWxsIHRoZQ0KPiA+IGRlcGVuZGVuY2llcyBp
bmNsdWRpbmcgdGhlIGNvbW1pdCBtZW50aW9uIGFib3ZlLg0KPiANCj4gSSBkb24ndCB1bmRlcnN0
YW5kLCBzb3JyeS4gIElzIHRoaXMganVzdCBhIG5vcm1hbCAiZXZvbHZlIHRoZSBkcml2ZXIgdG8N
Cj4gd29yayBiZXR0ZXIiIGNoYW5nZSwgb3IgaXMgaXQgYSAiZml4IGJyb2tlbiBjb2RlIiBjaGFu
Z2UsIG9yIGlzIGl0DQo+IHNvbWV0aGluZyBlbHNlPw0KPiANCj4gSW4gb3RoZXIgd29yZHMsIHdo
YXQgZG8geW91IHdhbnQgdG8gc2VlIGhhcHBlbiB0byB0aGlzPyAgV2hhdCB0cmVlKHMpDQo+IHdv
dWxkIHlvdSB3YW50IGl0IGFwcGxpZWQgdG8/DQo+IA0KDQpJdCdzIHVwIHRvIHlvdSwgYnV0IGl0
IHNlZW1zIHRvIGZpdCAidXNiLXRlc3RpbmciIGJyYW5jaCBtb3JlIHNpbmNlIGl0DQpkb2Vzbid0
IGhhdmUgYSAiRml4ZXMiIHRhZy4gVGhlIHNldmVyaXR5IG9mIHRoaXMgZml4IGlzIGRlYmF0YWJs
ZSBzaW5jZQ0KaXQgZG9lc24ndCBhcHBseSB0byBldmVyeSBEV0NfdXNiMzEgY29uZmlndXJhdGlv
biBvciBldmVyeSBzY2VuYXJpby4NCg0KVGhhbmtzLA0KVGhpbmg=

