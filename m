Return-Path: <stable+bounces-220024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KMSC442omnR0wQAu9opvQ
	(envelope-from <stable+bounces-220024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:27:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AFD1BF6BF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202DA30936F4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 00:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FEA86323;
	Sat, 28 Feb 2026 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Zwyq6P50";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hXVd7v6d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="OyuEaPko"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C3B24B45;
	Sat, 28 Feb 2026 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238472; cv=fail; b=YDB77Qm2KftRQWOKdBl4KGtCIcQIlWjCIu44lX0cd2Q0NhLjBJ+qi1cV6PFvMZ+7OJYnJRmHw+ca4BjXJXHG8R/Io9pew0nm0/zhmvszBKl8HTO6vIUEP+1+nbgQnwpjB05ARSEea+GVnYpyDbbSzcOwjUXVI/bF3lkFz4v/SE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238472; c=relaxed/simple;
	bh=R7P5DZMKkT3Gy463IOkBPdQlD8p+u+anpK9WTLNpVDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m4K4kFJ9Mq4Wy1zHzkUx2LuJdUXbEXOwjfPdSZQF+y4+roXqalFJAXDP0lRKJY8+se57TmSx+PkGb7TEe7z5dwx8HlmgWODLd9LyjYIXzqa9TGiH+0yoGqvOgWTbXZPudu3xnsLKRnSICdX8h6/swrkTyGPIrMpIyfY2hb0xiHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Zwyq6P50; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hXVd7v6d; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=OyuEaPko reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RLB9v6852018;
	Fri, 27 Feb 2026 16:27:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=R7P5DZMKkT3Gy463IOkBPdQlD8p+u+anpK9WTLNpVDg=; b=
	Zwyq6P50NVmpSVZMjJhBHAotq4Z0JdJOIbcp15jTtzJ/Vp1dMH8Ty/3BXE2XFZYh
	TDLqDCLjPr52hEjsjeP7N2GCEhDYpNCf2E8Xeyf8I9CYrTIWf/3kICmUNfUiyB6t
	YSeKWYaCaZjIPrxXckZghgNQGpWCkxBm4gCFfWjVIZbQI8DomDecrdP/aA4b5HKr
	uvuOTicuxlyOgrmI6ZuGrz4hwgyalDzr5tXyI15LF8Y6uh/cknWfrB0BhhJORnys
	G8ZfvvJcanuGtlixpBjmQ4EKUwMIK3yFjqDnW0cLeX7sQxThGAJ8FZSiTYtXGWYd
	xKGyeTmw1mBXkCvkk5oNvA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4ckgyhhfxu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 16:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1772238458; bh=R7P5DZMKkT3Gy463IOkBPdQlD8p+u+anpK9WTLNpVDg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=hXVd7v6d0fGEc9goRxT1lr8ZzO0PkC8Is363DqD/9LsKOoVauc2GzpJ1lqwe8eJSI
	 FTx7K4VNwr4VSF89qUClLfbTRH9nzay1D/fDhh+RsSrYeCgOck5bJV9blzNyVj/B4D
	 rH89uv/fVRewGg8sO1lbEyA3gYkxS2YOrsoTJWavCZn9rOkcp1+82ierwe+TKE8CEs
	 RuAU5KX9khgFs63hy2McUYaYW7OUM/iVA/cpnEw19fkRJYfIxqGOtHX+du0RTWqGqh
	 QuaZjb3SnOenfMjqt420UCngC0uEB+bd3fGsyGl74w0wzBddcVdx2tVBN3p9U69LBU
	 LnkJvIL74Xs6Q==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 94BD7401CD;
	Sat, 28 Feb 2026 00:27:38 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 428EFA0162;
	Sat, 28 Feb 2026 00:27:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=OyuEaPko;
	dkim-atps=neutral
Received: from SN1PR07CU001.outbound.protection.outlook.com (mail-sn1pr07cu00100.outbound.protection.outlook.com [40.93.14.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E30E6401CB;
	Sat, 28 Feb 2026 00:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dY23JttMIKbn33kgqHdd3rjZfoxon8O08G4fUGkd8tm4WdGwpFoqlXSriVLltJyMh+UQEjviZZxsEhWSBIozxY9Q7eelP81T5cHNt6KRTFhMBAJ/7941PJTLq74xNjp4lBbZw1GyGj2BEoDbNxxx9fcjx28SpRskcbcVaC1S85trX4E4m4hixpTUxm2UbvFpNhI7GQAc6EdSv8hb4rYND4TNgI1CDNoFmXmy6N8fiLeLXWhB7wi7Bhv7z6epnjVLvkmn9LDoQVDPs+XexqXULf1VunWXw+ZNORzITC9JTIEySbLWamdvBXigKfkNiTpJTYbx97KtYlFKAAc8zUnB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7P5DZMKkT3Gy463IOkBPdQlD8p+u+anpK9WTLNpVDg=;
 b=TUCE1Ai2EHHG52DE8NeggqFx9/oQDVGAgo5pRGwly2jQLi3qUtrGeIekQtd6FOzk9NBD3317M9fXngTxHbc29k94PzhR/6+r57J2qLKJ8RpGJ7AJC16uak42jaTMnMQSwfI2zwpJHtx2lU9unfJguskur6MgpWnlRu+d+PjgExTsLBpbPbGjBhsNxUNzP0LL4MVw8pFGOYY0nsrmTDi2OakB08Bq9BwVzC/Xwh1YPDKBR2iJ4FPO57aa6I5SpAjT3LTnZQNg4bgA2kxwmcS/SnmdFZN4lPUlAVPvJeex8G9w1FfDSPXKH+ORvfUoQa1lavEOvWvz0Ig7hr/YrKd6wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7P5DZMKkT3Gy463IOkBPdQlD8p+u+anpK9WTLNpVDg=;
 b=OyuEaPkoS5eeP0uzBAO8IOjHbYxDbcn0GMHmdZtyBTbdt4flFu02J4aBqXKQjG0YVFnQa6x4/r4e7HJHpOnLpvxdWGY2NqZpsk3qkqz0SgoMqhShIZlPVqNfz3kqrWXEFeSh2rJco8pz3JPRl7RW8LYmyBGyNbFq/a6hIQfSYuE=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 00:27:31 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7b72:b921:b9bd:4899%6]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 00:27:31 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "pritam.sutar@samsung.com" <pritam.sutar@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
Thread-Index: AQHcp+KIOUWlRKngOUe8KQBAqja6m7WXQjCA
Date: Sat, 28 Feb 2026 00:27:30 +0000
Message-ID: <20260228002711.e442cuxwld4s2f66@synopsys.com>
References:
 <CGME20260227121338epcas5p4baebb406db37f07223545b2f85751bf2@epcas5p4.samsung.com>
 <20260227121236.963-1-selvarasu.g@samsung.com>
In-Reply-To: <20260227121236.963-1-selvarasu.g@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM6PR12MB4075:EE_
x-ms-office365-filtering-correlation-id: 312bad12-7083-43d7-34d1-08de76602908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 DwOJKV6lYovaNPXXS6bjCft72evwg9ZNEXCZwDIqhNVDOKD1DdR43LiYym5nGCk18y2bfW5jheyp2R6lGJPlT/6nc0oGTtysep/ar9QxxpHN2s52j7aVdKteMMiOt44kNEjFHX6zv3npSQ3mKWf0HFViCS4SJAoPqTcdd4K2gJfhvZqi+1juyaQcixM6XXX4VpuTYq3rJsTLCkt6cj27lFb8gnW57QUrH/nXqE0cCGvPytP/hjB9CnDm+qs8B1SaweEgsQ6j2wXdT+0FW0i04S3UR85qSnMMTivZcBb3YsLF63fZP3hQBRJVQ1OaD4C75l8Xgpo43jE2g3WCuiBOmFlSLlgRZpszNW1oW/mEp+To/MWbURB/qeIQ9xIAthMRnywussQOu7PD9qS4AOzA4OFKMdXFxkIbxup1oyJBs3DXx0KmSXGEqN3ytk36HGUMIahELNbogpirjVUJltUnEIQdV54VzliQ388YWAVaI9uee95x+oo/i0CdxY0tzGLU6jvgweAhnqVKFZ4z/sHJ6Fa3PxzA0ch52MU9Ow6CE1a631GKN6IFNrMsoj8gF8XUqDfzhrrgQYkNHZtm7iKT9Hl/oUf28WRK3VN/Xj3fs+rb0lK1c+K+KkjkqF6F8apECz2NYNriXVSW7FudzKYmrMUnevJ9aY4jAa3f0ClosAM9iNCDSLq4ABmH3uF6uqK5zOQpYy3Q5+32zYCie7cLHuzxsYksSW9X7uWjujuVKax0vW55e3w2rLJ8EvcIcDwl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDkxM1FlWDB4QmJVUGRnOHRPMjhrcmdpZFFCYmYzVG4rRHFhUjNIeUdIRHpi?=
 =?utf-8?B?a21CWlY2dGFDa2hzb2syTjR3eU9WcmpWUWdsVXFNUmtYc3VSQmxuc3ZHY1F2?=
 =?utf-8?B?cHVLeWxxcmxzUHNLd2tkU2R3RTZnUmV3K3VaUC9zNnNLdHVnS1I2OExOR3Aw?=
 =?utf-8?B?cEFhNDJyLy8ydWFBR3FCTmZlemhjYWxlWWFLTmxOMVQrcFA4dnR5ZVFUcVEr?=
 =?utf-8?B?Q2dubUFCYW1XVnNxZnVVbjlCV0dDSGVqNVBHTGlVL2Y3N0prK1M1aFVJNDJn?=
 =?utf-8?B?aml4Sk5oWGhCRk0xNFVZakxpZWNROHhOWTZ5NjNhTnVyK0pjT0JYamRWQUh2?=
 =?utf-8?B?eUdQT2hKMWR5VzlSMzZ1WUlhQWp5MnZkbDFsa0RKZUpqSkZSdUdsRVl0Vkpv?=
 =?utf-8?B?aDA5RDMwQnRteFRFUysrV0lRTjFmbS9ybFVRdklqLzVtcFVQdm02MTE1aTVM?=
 =?utf-8?B?OVNBNVhJaldXWHpRMzYyTHVYa2ViZy8zb2FRVW1yUUNLUGs2Zjdwb2F5M1lO?=
 =?utf-8?B?NVdRTDdZQXdzc0tTbDlyN3hHK1RYLzFqWUkyWFN4WmRreURZV3k5OHkwMWQz?=
 =?utf-8?B?c0FveHlVOFBrSlZ1SEYzM0NkZ3RYWjE0KzJyMUxFZUp3dWVkQ0tLQ1c0YzVq?=
 =?utf-8?B?cVFXcHdoeUc2OWVKd2xCRDFGTjNpZXIwVzF5Y3NrUStEdThmdmpLS2Z6Qzda?=
 =?utf-8?B?WmhNd0RiN2lRSU5nYkJ3L2NwcDArVFhRY1YrKzUyOVNtVzdBSi9LNE5hN2Vi?=
 =?utf-8?B?c2RFeVpXbFZyNDBaOUV4NS9Ub29lbi9XemVxVnJMdUdTUDd4YWY5RnhzdGR0?=
 =?utf-8?B?a0lXMFJMZ0dsWVVYb3NKZ1FqWFRlcC81a2dwdG1jcFZlVGIybnQvdHRNQ0lK?=
 =?utf-8?B?cEJJeGN5MXNBVTBMNnlJNnAxM3lONGZJQXlFeUJBdXNiN2JPdlNZN1FtYWV6?=
 =?utf-8?B?TEhIVVgyOUtYdFg5UjcvOVBGVVlReHhkcFNIZHpDSHExR2ZsVkpsZW0wSDlh?=
 =?utf-8?B?NXNpa1pHRkloVGlOVmEzc0lWSmo0R1RNRDlsRGVuT3lZNXBYYmdwR3Rqd3lu?=
 =?utf-8?B?UWQ2dC9WOTBRaVNlSGlyaGJrMVkvRUgzM3hSU2g4YWd3bFgyZ1VzYUQ3eVMz?=
 =?utf-8?B?THlzbDdiRFlWZ0k4amUvS3g5Mm5iY1R6d0xUM0Vkbis4UHZuY0ZZWE5BZllN?=
 =?utf-8?B?aUJtbzFKZTFGNWNyWi9FZWxzTlZTRkJmZUs3ZWdralBPbVR6MkVPdzd4MjdZ?=
 =?utf-8?B?ZFFUaWxJa1RleGdmMjI0YlJlWXlxWWxvMVp2Z0VPUzIwM2pZUlRpbkZOaTN3?=
 =?utf-8?B?K211aURKdGdqcWg5ZHMvNlR6SThoWXVOUi8zWFQxbWhORHpmWVlTQXd0YU5s?=
 =?utf-8?B?VkhRb1ROUm5HV1lxQTRmMHlRTFdkaUtja0JKZGxaeDh3UXh6ZDFjSDhsZ1Ns?=
 =?utf-8?B?NUU4TkJDck8yNEdKMFpIUUxVQTVYNlFkOTJCUCtnTktpZnJlN0Yydm9EZTBU?=
 =?utf-8?B?cHZ6NXRhZ0FlU3NvdWtuZGRrVFdDeWNtKzRIRUZlQ3lrOXF3WnpZNW45M0hY?=
 =?utf-8?B?bExPZEgyU3V0QW5KMUFtdFBVa1ZnQThTK2h2aUN0R0gxZEtZTklJcU84TXFH?=
 =?utf-8?B?VjJwaHVoTjNKWTFnUTBnaWVzWVVHUlNrZE9rbkZYNmhJdE0wcWJBU2dvaXhS?=
 =?utf-8?B?WjIrbGJWNWljbmpPdjNaVUFORWxXZ2FpZk1kVDNWVmJEWm9OTXlPN2w1cXJv?=
 =?utf-8?B?TElzeTh5RkpRNW44U3lPMnY5Z1c2NHFOK2N4b1M1RVJkMDBjaW1tVWRSd1Vs?=
 =?utf-8?B?K0VpclZtQVNlb1lIOW0xMFV2UmdrR2dtMVc3b21BU0RmQlZaZWs1VjY2OCtW?=
 =?utf-8?B?V1k3MTJ4eWZUaWxuWTc1eXJxbVdVTmR1WWQ1S2VHd0ZOelZpeUx5R1oxMTZl?=
 =?utf-8?B?eS9ad2dxUnZIWW81Rm1UNlpMQW9OZGFzcm9QQ01nSzd1V1RROFBHTUhqYVIx?=
 =?utf-8?B?c1NMS1RUZHNkaGE1dkF4d3BoQ013OHVXT1l4T2F4S2xHWkpjM2x1dDAyMDVH?=
 =?utf-8?B?WFZnSTcyT3h2eklQSW1hSkNicnN4WXlla09qcDZoUnRIcHBMaW9yb28xS1I0?=
 =?utf-8?B?YldsZXg2RTNETXBGU0ZEcHRDSW8yT2hFNVBlc2NjMkNvM3piUy9hb2YrSGcx?=
 =?utf-8?B?WlBLdkZtM2QxSFRueEhXNTJTRUZ5bHhNcWc5WGNoQkRsdVBrcFpDcmlJWHc2?=
 =?utf-8?B?STAyMG5yakQ4V2R1cnFxL3NQREdsZ2psQm12NXBveGdDSlJ4NTFYc1phTkxT?=
 =?utf-8?B?OW1qWW9XZjh4ODgwREhDWmYzK3U3K0k3L25LaTlaK1MzVkNhRGlpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F978F62434275F48BE131A75887341C1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Zv+9yKgrfW/856mN1492mZI08rwkrnAphxObnoRmX6IU/dcb+yEqCEYZwUkWHyVrE+h9086J3FSNrNrqBqme58+5MDzY0lThhPtfvCrlwAGwdPbEwVypc60xJv4rp67IwUe96lIq6mnxKSxtaorF/+0DNabGjWOC5LyZtJcMIBIFKHAUptGZUh5u02/P1tgZvNzgmRasHfZTX+VhTSGPvdtPPGNZ2LxZO2zlSqzEKoRb+Ua5Y+fK+seWnv85G7WdmJDZ1XOWkd4kFkK5kRaqIxHNFP/hregY2zv4iai+Yz08s+kUQYijQtvgFFzLcvpcCSRKU77nW1lnl+QHhBvbkAXqKqN1C8ZqHqYc8BGooYH4WU6232ZUJA8iddeYeibFq2jk+oIu+Mc6gIavnyK80xKmzC8d7scri6RVQyOnfHolZ4gyB/bpSKdbvmrqN5KYuDwjHY/aSr6N2kk1UfE2sUF6CeLLMRL2c2cpUkyk4jcSb49vNQNFMPbCDEdNDfPhw9V4UdmfGl/LafllaRpZZ+FSGQq5pYxyehcnBLt6tCx5fURoCwNGRxYGi04nKw0w+XLfTbJOBCqn8ebzukK0CKIsQ1UjwgS51E9JPJjugUZCoPlfEPJujKeB6vZUiqtvirOQtLHgLb+sPaJW9STSJA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 312bad12-7083-43d7-34d1-08de76602908
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2026 00:27:31.0270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQ3oU5rxUa99rgjP4tr0Icc6na2/E8nuqUPpE7g9ELrAcQriH3H+t1060V1CUtWCp8WDNE66x36R6Q3qR8ZJug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDAwMiBTYWx0ZWRfX+x7gIKHzsoco
 4emI1k9feuacJwQMDvqFyS6R3GGLKBo74VVqx8Z4iKbWCiR6fNABMEFOPGI+4SGgTJ8Xh9PTRil
 4JjVkN+myuCoZuMNANeBOEUVIXOl3voh6jyDFFN4Zzyg5lgDFRpzw/69crFKbatudu5qx2SgbgX
 GfcMnGLVjiMTqj0of8orkfSLbSR+1JQ22fM4KYEdln90iZ/ORVp+4kYPkfgqfowVfy7uNB1HWXs
 uQA89sRgB3yU6KHXYytlhvA8eihQcIz0PEp5bYbdIszva577qAK7asDUq2APmtBxT6iJR0AbfiP
 IeaPFoL+Qlc3y6M0vn/pkXNYklBMa01N7YJ8ui5Ef0W3fVFcYbjHJMbGWZfbMgxgNppKqo4Elh6
 ce8AyqtfCD6ZRA5c3T0PDR9t9SQJOH0BcL1u4QQrN5iZNLrMhY3o93LJV62N2qb0laBJkAX02O1
 3usy1FoqK1XlYDAtfyw==
X-Proofpoint-ORIG-GUID: sKkvXCPVctHQQJ5L5Rbjv3H-wdheaM7f
X-Authority-Analysis: v=2.4 cv=UNjQ3Sfy c=1 sm=1 tr=0 ts=69a2367b cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=-4-sGo8i1FcW4KD7_GeR:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=jIQo8A4GAAAA:8 a=W6hOAeJSYGO0-irV2NoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: sKkvXCPVctHQQJ5L5Rbjv3H-wdheaM7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 bulkscore=0
 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2602130000 definitions=main-2602280002
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[synopsys.com:s=pfptdkimsnps,synopsys.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	R_DKIM_REJECT(0.00)[synopsys.com:s=selector1];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220024-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[synopsys.com,quarantine];
	DKIM_TRACE(0.00)[synopsys.com:+,synopsys.com:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[urldefense.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,synopsys.com:mid,synopsys.com:dkim,synopsys.com:email,samsung.com:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Thinh.Nguyen@synopsys.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 97AFD1BF6BF
X-Rspamd-Action: no action

T24gRnJpLCBGZWIgMjcsIDIwMjYsIFNlbHZhcmFzdSBHYW5lc2FuIHdyb3RlOg0KPiBUaGUgYmVs
b3cg4oCcTm8gcmVzb3VyY2UgZm9yIGVw4oCdIHdhcm5pbmcgYXBwZWFycyB3aGVuIGEgU3RhcnRU
cmFuc2Zlcg0KPiBjb21tYW5kIGlzIGlzc3VlZCBmb3IgYnVsayBvciBpbnRlcnJ1cHQgZW5kcG9p
bnRzIGluDQo+IGBkd2MzX2dhZGdldF9lcF9lbmFibGVgIHdoaWxlIGEgcHJldmlvdXMgU3RhcnRU
cmFuc2ZlciBvbiB0aGUgc2FtZQ0KPiBlbmRwb2ludCBpcyBzdGlsbCBpbiBwcm9ncmVzcy4gVGhl
IGdhZGdldCBmdW5jdGlvbnMgZHJpdmVycyBjYW4gaW52b2tlDQo+IGB1c2JfZXBfZW5hYmxlYCAo
d2hpY2ggdHJpZ2dlcnMgYSBuZXcgU3RhcnRUcmFuc2ZlciBjb21tYW5kKSBiZWZvcmUgdGhlDQo+
IGVhcmxpZXIgdHJhbnNmZXIgaGFzIGNvbXBsZXRlZC4gQmVjYXVzZSB0aGUgcHJldmlvdXMgU3Rh
cnRUcmFuc2ZlciBpcw0KPiBzdGlsbCBhY3RpdmUsIGBkd2MzX2dhZGdldF9lcF9kaXNhYmxlYCBj
YW4gc2tpcCB0aGUgcmVxdWlyZWQNCj4gYEVuZFRyYW5zZmVyYCBkdWUgdG8gYERXQzNfRVBfREVM
QVlfU1RPUGAsIGxlYWRpbmcgdG8gdGhlIGVuZHBvaW50DQo+IHJlc291cmNlcyBhcmUgYnVzeSBm
b3IgcHJldmlvdXMgU3RhcnRUcmFuc2ZlciBhbmQgd2FybmluZyAoIk5vIHJlc291cmNlDQo+IGZv
ciBlcCIpIGZyb20gZHdjMyBkcml2ZXIuDQo+IA0KPiBBZGRpdGlvbmFsbHksIGEgcmFjZSBjb25k
aXRpb24gZXhpc3RzIGJldHdlZW4gZHdjM19nYWRnZXRfZXBfZGlzYWJsZSgpDQo+IGFuZCBkd2Mz
X2dhZGdldF9lcF9xdWV1ZSgpIHdoZW4gbWFuaXB1bGF0aW5nIGRlcC0+ZmxhZ3MuIFdoZW4NCj4g
ZHdjM19nYWRnZXRfZXBfZGlzYWJsZSgpIGNhbGxzIGR3YzNfZ2FkZ2V0X2dpdmViYWNrKCksIHRo
ZSBkd2MtPmxvY2sgaXMNCj4gdGVtcG9yYXJpbHkgcmVsZWFzZWQuIElmIGR3YzNfZ2FkZ2V0X2Vw
X3F1ZXVlKCkgcnVucyBpbiB0aGF0IHdpbmRvdywgaXQNCj4gbWF5IHNldCB0aGUgRFdDM19FUF9U
UkFOU0ZFUl9TVEFSVEVEIGZsYWcgYXMgcGFydCBvZg0KPiBkd2MzX3NlbmRfZ2FkZ2V0X2VwX2Nt
ZCgpLiBXaGVuIGVwX2Rpc2FibGUgcmVzdW1lcywgaXQgdW5jb25kaXRpb25hbGx5DQo+IGNsZWFy
cyBhbGwgZmxhZ3MgZXhjZXB0IHRob3NlIGV4cGxpY2l0bHkgbWFza2VkLCBwb3RlbnRpYWxseSBj
bGVhcmluZw0KPiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQgZXZlbiB0aG91Z2ggYSBuZXcgdHJh
bnNmZXIgaGFzIHN0YXJ0ZWQuIFRoaXMNCj4gbGVhZHMgdG8gIk5vIHJlc291cmNlIGZvciBlcCIg
d2FybmluZ3Mgb24gc3Vic2VxdWVudCBTdGFydFRyYW5zZmVyDQo+IGF0dGVtcHRzLg0KPiANCj4g
VGhlIHVuZGVybHlpbmcgZnJhbWV3b3JrIGlzc3VlIGlzIHRoYXQgdXNiX2VwX2Rpc2FibGUoKSBp
cyBleHBlY3RlZCB0bw0KPiBjb21wbGV0ZSBwZW5kaW5nIHJlcXVlc3RzIGJlZm9yZSByZXR1cm5p
bmcsIGJ1dCBpcyBhbGxvd2VkIHRvIGJlIGNhbGxlZA0KPiBmcm9tIGludGVycnVwdCBjb250ZXh0
IHdoZXJlIHNsZWVwaW5nIHRvIHdhaXQgZm9yIGNvbXBsZXRpb24gaXMgbm90DQo+IHBvc3NpYmxl
Lg0KPiANCj4gQXMgdGVtcG9yYXJ5IHdvcmthcm91bmRzIGZvciB0aGlzIGZyYW1ld29yayBsaW1p
dGF0aW9uOg0KPiANCj4gMS4gSW4gX19kd2MzX2dhZGdldF9lcF9lbmFibGUoKSwgYWRkIGEgY2hl
Y2sgZm9yIHRoZQ0KPiAgICBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQgZmxhZyBiZWZvcmUgaXNz
dWluZyBhIG5ldyBTdGFydFRyYW5zZmVyLg0KPiAgICBUaGlzIHByZXZlbnRzIGEgc2Vjb25kIFN0
YXJ0VHJhbnNmZXIgb24gYW4gYWxyZWFkeSBidXN5IGVuZHBvaW50LA0KPiAgICBlbGltaW5hdGlu
ZyB0aGUgcmVzb3VyY2UgY29uZmxpY3QuDQo+IA0KPiAyLiBJbiBfX2R3YzNfZ2FkZ2V0X2VwX2Rp
c2FibGUoKSwgcHJlc2VydmUgdGhlIERXQzNfRVBfVFJBTlNGRVJfU1RBUlRFRA0KPiAgICBmbGFn
IHdoZW4gbWFza2luZyBkZXAtPmZsYWdzIGlmIGl0IGlzIGFjdHVhbGx5IHNldCwgcHJldmVudGlu
ZyB0aGUNCj4gICAgcmFjZSB3aXRoIGR3YzNfZ2FkZ2V0X2VwX3F1ZXVlKCkgZnJvbSBjb3JydXB0
aW5nIHRoZSBmbGFnIHN0YXRlLg0KPiANCj4gVGhlc2UgY2hhbmdlcyBlbGltaW5hdGUgdGhlICJO
byByZXNvdXJjZSBmb3IgZXAiIHdhcm5pbmdzIGFuZCBwb3RlbnRpYWwNCj4ga2VybmVsIHBhbmlj
cyBjYXVzZWQgYnkgcGFuaWNfb25fd2Fybi4NCj4gDQo+IGR3YzMgMTMyMDAwMDAuZHdjMzogTm8g
cmVzb3VyY2UgZm9yIGVwMW91dA0KPiBXQVJOSU5HOiBDUFU6IDAgUElEOiA3MDAgYXQgZHJpdmVy
cy91c2IvZHdjMy9nYWRnZXQuYzozOTggZHdjM19zZW5kX2dhZGdldF9lcF9jbWQrMHgyZjgvMHg3
NmMNCj4gQ2FsbCB0cmFjZToNCj4gZHdjM19zZW5kX2dhZGdldF9lcF9jbWQrMHgyZjgvMHg3NmMN
Cj4gX19kd2MzX2dhZGdldF9lcF9lbmFibGUrMHg0OTAvMHg3YzANCj4gZHdjM19nYWRnZXRfZXBf
ZW5hYmxlKzB4NmMvMHhlNA0KPiB1c2JfZXBfZW5hYmxlKzB4NWMvMHgxNWMNCj4gbXBfZXRoX3N0
b3ArMHhkNC8weDExYw0KPiBfX2Rldl9jbG9zZV9tYW55KzB4MTYwLzB4MWM4DQo+IF9fZGV2X2No
YW5nZV9mbGFncysweGZjLzB4MjIwDQo+IGRldl9jaGFuZ2VfZmxhZ3MrMHgyNC8weDcwDQo+IGRl
dmluZXRfaW9jdGwrMHg0MzQvMHg1MjQNCj4gaW5ldF9pb2N0bCsweGE4LzB4MjI0DQo+IHNvY2tf
ZG9faW9jdGwrMHg3NC8weDEyOA0KPiBzb2NrX2lvY3RsKzB4M2JjLzB4NDY4DQo+IF9fYXJtNjRf
c3lzX2lvY3RsKzB4YTgvMHhlNA0KPiBpbnZva2Vfc3lzY2FsbCsweDU4LzB4MTBjDQo+IGVsMF9z
dmNfY29tbW9uKzB4YTgvMHhkYw0KPiBkb19lbDBfc3ZjKzB4MWMvMHgyOA0KPiBlbDBfc3ZjKzB4
MzgvMHg4OA0KPiBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDcwLzB4YmMNCj4gZWwwdF82NF9zeW5j
KzB4MWE4LzB4MWFjDQo+IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQt
b2ZmLWJ5OiBTZWx2YXJhc3UgR2FuZXNhbiA8c2VsdmFyYXN1LmdAc2Ftc3VuZy5jb20+DQo+IC0t
LQ0KPiANCj4gTm90ZTogTm8gRml4ZXMgdGFnIGlzIGFkZGVkIGJlY2F1c2UgdGhpcyBpcyBhIHdv
cmthcm91bmQgZm9yIHRoZQ0KPiBnYWRnZXQgZnJhbWV3b3JrIGlzc3VlIHdoZXJlIHRoZSBnYWRn
ZXQgZnJhbWV3b3JrIGNhbGxzIHVzYl9lcF9kaXNhYmxlKCkNCj4gaW4gaW50ZXJydXB0IGNvbnRl
eHQgd2l0aG91dCBlbnN1cmluZyBlbmRwb2ludCBmbHVzaGluZyBjb21wbGV0ZXMuDQo+IEEgcHJv
cGVyIGZpeCByZXF1aXJlcyByZWZhY3RvcmluZyB0aGUgZnJhbWV3b3JrIHRvIG1ha2Ugc3VyZQ0K
PiB1c2JfZXBfZGlzYWJsZSBpcyBpbnZva2VkIGluIHByb2Nlc3MgY29udGV4dC4NCj4gDQo+IENo
YW5nZXMgaW4gdjM6DQo+ICAtIFJldmlzZWQgdGhlIGNvbW1pdCBtZXNzYWdlIHRvIGRldGFpbCB0
aGUgcmVhbCBnYWRnZXQgZnJhbWV3b3JrIGlzc3VlDQo+ICAgIHBvaW50ZWQgb3V0IGJ5IHRoZSBy
ZXZpZXdlci4NCj4gIC0gTWVyZ2VkIHRoZSB0d28gZml4ZXMgZm9yIHRoZSBzYW1lIGVwIHdyaW5n
aW5nIGludG8gb25lIHBhdGNoLg0KPiBMaW5rIHRvIHYyOiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjUxMTE3MTU1OTIwLjY0
My0xLXNlbHZhcmFzdS5nQHNhbXN1bmcuY29tL19fOyEhQTRGMlI5R19wZyFjUXpRUTVrQVdGNkNF
NWhRZTdWcUZkbmF4cXd6c1RCMVpHTlQxR3ZDSDI4R29CX25FU1pSNVkyanR4ZFpCbHM2d0JJTTRP
dHB2RzRkU2F5bHZOQzNxYmg1NDdrJCANCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gUmVtb3Zl
ZCBjaGFuZ2UtaWQuDQo+IC0gVXBkYXRlZCBjb21taXQgbWVzc2FnZS4NCj4gTGluayB0byB2MTog
aHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LXVzYi8yMDI1MTExNzE1MjgxMi42MjItMS1zZWx2YXJhc3UuZ0BzYW1zdW5nLmNvbS9fXzshIUE0
RjJSOUdfcGchY1F6UVE1a0FXRjZDRTVoUWU3VnFGZG5heHF3enNUQjFaR05UMUd2Q0gyOEdvQl9u
RVNaUjVZMmp0eGRaQmxzNndCSU00T3Rwdkc0ZFNheWx2TkMzOHotQ1JENCQgDQo+IC0tLQ0KPiAg
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jDQo+IGluZGV4IDBhNjg4OTA0Y2U4YzUuLjNhZjFiYmZlM2Q5MmIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYw0KPiBAQCAtOTcxLDggKzk3MSw5IEBAIHN0YXRpYyBpbnQgX19kd2MzX2dhZGdl
dF9lcF9lbmFibGUoc3RydWN0IGR3YzNfZXAgKmRlcCwgdW5zaWduZWQgaW50IGFjdGlvbikNCj4g
IAkgKiBJc3N1ZSBTdGFydFRyYW5zZmVyIGhlcmUgd2l0aCBuby1vcCBUUkIgc28gd2UgY2FuIGFs
d2F5cyByZWx5IG9uIE5vDQo+ICAJICogUmVzcG9uc2UgVXBkYXRlIFRyYW5zZmVyIGNvbW1hbmQu
DQo+ICAJICovDQo+IC0JaWYgKHVzYl9lbmRwb2ludF94ZmVyX2J1bGsoZGVzYykgfHwNCj4gLQkJ
CXVzYl9lbmRwb2ludF94ZmVyX2ludChkZXNjKSkgew0KPiArCWlmICgodXNiX2VuZHBvaW50X3hm
ZXJfYnVsayhkZXNjKSB8fA0KPiArCQkJdXNiX2VuZHBvaW50X3hmZXJfaW50KGRlc2MpKSAmJg0K
PiArCQkJIShkZXAtPmZsYWdzICYgRFdDM19FUF9UUkFOU0ZFUl9TVEFSVEVEKSkgew0KPiAgCQlz
dHJ1Y3QgZHdjM19nYWRnZXRfZXBfY21kX3BhcmFtcyBwYXJhbXM7DQo+ICAJCXN0cnVjdCBkd2Mz
X3RyYgkqdHJiOw0KPiAgCQlkbWFfYWRkcl90IHRyYl9kbWE7DQo+IEBAIC0xMDk2LDYgKzEwOTcs
MjMgQEAgc3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoc3RydWN0IGR3YzNfZXAg
KmRlcCkNCj4gIAkgKi8NCj4gIAlpZiAoZGVwLT5mbGFncyAmIERXQzNfRVBfREVMQVlfU1RPUCkN
Cj4gIAkJbWFzayB8PSAoRFdDM19FUF9ERUxBWV9TVE9QIHwgRFdDM19FUF9UUkFOU0ZFUl9TVEFS
VEVEKTsNCj4gKw0KPiArCS8qDQo+ICsJICogV2hlbiBkd2MzX2dhZGdldF9lcF9kaXNhYmxlKCkg
Y2FsbHMgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKSwNCj4gKwkgKiB0aGUgZHdjLT5sb2NrIGlzIHRl
bXBvcmFyaWx5IHJlbGVhc2VkLiBJZiBkd2MzX2dhZGdldF9lcF9xdWV1ZSgpDQo+ICsJICogcnVu
cyBpbiB0aGF0IHdpbmRvdyBpdCBtYXkgc2V0IHRoZSBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQg
ZmxhZyBhcw0KPiArCSAqIHBhcnQgb2YgZHdjM19zZW5kX2dhZGdldF9lcF9jbWQuIFRoZSBvcmln
aW5hbCBjb2RlIGNsZWFyZWQgdGhlIGZsYWcNCj4gKwkgKiB1bmNvbmRpdGlvbmFsbHkgaW4gdGhl
IG1hc2sgb3BlcmF0aW9uLCB3aGljaCBjb3VsZCBvdmVyd3JpdGUgdGhlDQo+ICsJICogY29uY3Vy
cmVudCBtb2RpZmljYXRpb24uDQo+ICsJICoNCj4gKwkgKiBBcyBhIHdvcmthcm91bmQgZm9yIHRo
ZSBpbnRlcnJ1cHQgY29udGV4dCBjb25zdHJhaW50IHdoZXJlIHdlIGNhbm5vdA0KPiArCSAqIHdh
aXQgZm9yIGVuZHBvaW50IGZsdXNoaW5nLCBwcmVzZXJ2ZSB0aGUgRFdDM19FUF9UUkFOU0ZFUl9T
VEFSVEVEDQo+ICsJICogZmxhZyBpZiBpdCBpcyBzZXQsIGF2b2lkaW5nIHJlc291cmNlIGNvbmZs
aWN0cyB1bnRpbCB0aGUgZnJhbWV3b3JrDQo+ICsJICogaXMgZml4ZWQgdG8gcHJvcGVybHkgc3lu
Y2hyb25pemUgZW5kcG9pbnQgbGlmZWN5Y2xlIG1hbmFnZW1lbnQuDQo+ICsJICovDQo+ICsJaWYg
KGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQpDQo+ICsJCW1hc2sgfD0gRFdD
M19FUF9UUkFOU0ZFUl9TVEFSVEVEOw0KPiArDQo+ICAJZGVwLT5mbGFncyAmPSBtYXNrOw0KPiAg
DQo+ICAJLyogQ2xlYXIgb3V0IHRoZSBlcCBkZXNjcmlwdG9ycyBmb3Igbm9uLWVwMCAqLw0KPiAt
LSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5A
c3lub3BzeXMuY29tPg0KDQpUaGFua3MhDQpUaGluaA==

