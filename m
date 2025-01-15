Return-Path: <stable+bounces-108660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E805A1167B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 02:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16383A6F4B
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 01:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9181F3595E;
	Wed, 15 Jan 2025 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nlvoEnEI";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XOXyGcpq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZyvJa4aN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1433DB;
	Wed, 15 Jan 2025 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904238; cv=fail; b=RtAv8I1EwnGRySXW3rUQS0O36LMJvKfiJYETygvvDQ5pT9LjIC2gikBlV4YibKdxwVF2Fo2/4hW+rtfAZEhYSc35eo6T/uy5niI1AbFMAbpnJYFaEhi64+xJB0dnG4MxqcrY4GKfWHs59v278ChFAx7OyMX4YXNYS5YTnXC0DRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904238; c=relaxed/simple;
	bh=SJDNhYrJdP+bk/SK4rc/7M/TKwo2cxMHemsY0qKyHRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBsErIegDauhJAe5ia08E3qd1f8ijjYQSz5ofgg60dkwqSn4rzBl0q0q+ZV2O0q/CbSaqSu733GeCVX4wY4t+uS6uwFIsC2MNoLPMsIP67/ON8AmVjuQ7hH5zyyviw5TyWgzoOkeGhJFnAq/L6/fqv0LFK5vQphlYU+FW7yJLI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nlvoEnEI; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=XOXyGcpq; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZyvJa4aN reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EMbHun009579;
	Tue, 14 Jan 2025 17:23:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=SJDNhYrJdP+bk/SK4rc/7M/TKwo2cxMHemsY0qKyHRs=; b=
	nlvoEnEITnbt+dey72FqG/4IyCiVvKhwO56CkSwScopfxDrk3tiGpSEkahLQSud4
	QTE3tKhyDEbluMIgara9JsmpLSYQj9OBX6GqdLXaHwfcBwd01ia7gIfsiefjaAGR
	X0ycKMDAY9bdf8pkPQc+T7t0IQNG686cRmmANb3iACJhcIqMy0w59TjrE4Jsi7px
	ZxjB9A/ycuuCJvtgw+ZkBchk+Zx3z8VW/s4EfFGQb+/zIWzdlON/2GP2gRT0ErdD
	EHi7XJiQIf3GtSdO2bkFqSNHikLGCi9LR85vQUiuJ8Dx6sxM+Rgyshdzw1ZzfkFd
	YKhbtFDiq9KB+nrxBG70KA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4460vm8nce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 17:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1736904216; bh=SJDNhYrJdP+bk/SK4rc/7M/TKwo2cxMHemsY0qKyHRs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=XOXyGcpqNkj4U8YnFnry3zTjhVpzpleHH6xIqJLe6OcFqs2fedia+ikUcR6mkjW1z
	 xsMtR5rigl0tUbY2nTd0rWy8a2wx+lenDuigyvsR92JurzGg6BBVXAOzo/0aPwO70a
	 RXuHPG+bih0yyEc4/NWJTSvHb1sb6SLBVcKlctGqz1twCjL+RiYn/leTOshM+L8czu
	 6i4X8eDpsUttIDF0JGdiBFRL7GLWOhMOLV7GIz9d5aOj+Pc1kYleRnXN7FtnFlslo2
	 koNDqTLMH1x/qExu9KAyjFrAH1KDnWE8AyauKwexq8oAOozkjwDxJ9gZYtsW1Skw2G
	 I8DU6Mfv/yFKA==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B214B4056B;
	Wed, 15 Jan 2025 01:23:35 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 047C4A0072;
	Wed, 15 Jan 2025 01:23:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZyvJa4aN;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0E190405A3;
	Wed, 15 Jan 2025 01:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAcvnV7SFj3cX32gBehU2znjvYDa8SPG5evJtkFTeSr5VDlk2asUJz2wYUEVbVNqhabsnfNi3q3Mrx8/+xU+HR0eWNRNGKKkTP8IGzVIb2Ef5R25g0RTDxZD54/DXco6m6JYOLf2+A4VPFqVYlRvwL3ACDhMP3fCuu6s5vu23G25HgJwg5urJgAn/Goh0vCENB1e9IBiumNrjHnvNVqex8uojEfaYfw+9FozvkVvCjx+tRNWU7z3SbYoWLS6nfV5A4HFc5VlGHdfx3CCmeonBLLinPqjC60n/IiOXuS36mCxlRVVsmhV/PTv4VImIGcNvZXW1lJ9/rt3gOJ59IH5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJDNhYrJdP+bk/SK4rc/7M/TKwo2cxMHemsY0qKyHRs=;
 b=zJaXgVFWWpKjir952C0dJCv/LDpORyLCDH/uHIJFTnMoUGA8LsJ5/1zgMMwcNQB6qjT1gqrGJ5zfydGgeLzpM6TIb4q7VOtSZv19sDFmwum4ZMcP8YTTn7KoYqWbXDXtZDSxgGH9yzEZFqtQ3W+KHIUuRReb0rlmuDYLUjIsVr3RvJ+bh/ceZMhWQtmD2xkxOEDdiPfaidyQ0qoXf5ZEuRHsPpxTw+6cfJQxKRlXzqqAwCIN6QTZ6uwVJGThdlHBVY9L8o5w6SszFqH/BWVPLGBErCGgvPq32tXGYhvRCn54drbtAZSdX3kS92ouYNDtQxjrib6veoWJ3i9z44uVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJDNhYrJdP+bk/SK4rc/7M/TKwo2cxMHemsY0qKyHRs=;
 b=ZyvJa4aNYI6QmPX/WL355t7cyWmotlfWhfoOQPF14GyXNL4D84phe+vhK0hwq+Jrf7AV5KHpODOgmViED/UokDsQ9h3idboV0Cx/c3zaXMp1EnuC+xeINfZR0upYUgK+PHoz8emAXwO2bJ7GFvwNcefzRL+TAXri8YHUdqI8De0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 01:23:30 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%7]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 01:23:29 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Kyle Tso <kyletso@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "raychi@google.com" <raychi@google.com>,
        "badhri@google.com" <badhri@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "royluo@google.com" <royluo@google.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1] usb: dwc3: core: Defer the probe until USB power
 supply ready
Thread-Topic: [PATCH v1] usb: dwc3: core: Defer the probe until USB power
 supply ready
Thread-Index: AQHbZo7vsKXoeIuwyk6kGzgIu+QPH7MXCwCA
Date: Wed, 15 Jan 2025 01:23:29 +0000
Message-ID: <20250115012319.td2wh6jwv6q3ujda@synopsys.com>
References: <20250114141607.2091154-1-kyletso@google.com>
In-Reply-To: <20250114141607.2091154-1-kyletso@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA0PR12MB4399:EE_
x-ms-office365-filtering-correlation-id: c45ab3b0-e697-4fef-d653-08dd3503380e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3h3bXVMeFJHWlFBd2gvb0oyc2hQWjlNMmI2NlVkQmxhSlIvTVlscWxwUDZY?=
 =?utf-8?B?Z0NPQkl0UFU2MTA2RmlOaFBSR0JlUEZrNFZEUXdRcHBGa1RxTzBIUjhDYzVh?=
 =?utf-8?B?WVNSWWtyM2VWNDRROXJIYUFEMGQ4WHhiRXAvUVBFWHNvejFmMy9DR0NieVdE?=
 =?utf-8?B?NnRLcjJ4KzJTdGtpVGRDbGFJSE1ZK2YzWjhHSXBSWFVHRmcyWmlMSnZMVUZl?=
 =?utf-8?B?OUtWb290clBSMUhwR2V0ZmJkYjN3RlZqaGhWb29lLzF6clgyMmRyRGpycVI2?=
 =?utf-8?B?dEtPNFBKNnlRTlNmMDIwT3RQb0Qxd1dBeU1SQUltRnpSTWdFYmpRRGl3Q1dF?=
 =?utf-8?B?ZzZhYUprNkxzTjlNL2k4NlpZTHV2N1hubldnWXNKdkZoMGVKZld3UWxHcjlV?=
 =?utf-8?B?dXFJN0FJc3BEM1lKNStUNnhadnEvdXZmRXp6aFJuM0ZqNHdBeXQwZ1hrRThO?=
 =?utf-8?B?UGhwTTllWW9TdjZ6Rzl6UkJIb0hwcjJzZGhsekdjT3Mybkh5Z1dBeXdGL3Fu?=
 =?utf-8?B?V1QrQ1A3V2F5NFhwdHlCWXUzdGFxZDE2c3pJZGM3TUQwS1pNanV1OWlaQU4v?=
 =?utf-8?B?TjBCMVRYQ1pKamdwZVFMTCtkdWZkdnJtYmFja2JGTE54RkRZaFFjdWlKR3VC?=
 =?utf-8?B?Ui90RVdlWk9RLzBPVmFLUVIvNE82NlhpRm1uTnhvN1plLytYa1JtWWo0TSs5?=
 =?utf-8?B?ZjRYR0R5d2w0bDF1emtVVEVyelNGb3R6VmRNRkU3TGhWWUF2bm5xOTBxR3h6?=
 =?utf-8?B?YUJTTDBtMVRRNDllZHJObXFWU2ZDdHNTRTFXWG9CMXpTMENNc3E5a0lWQVYy?=
 =?utf-8?B?UGhzRCtnUmtKOGFENm5xc29jcXlTNXVzZ1dORDQ3QXZCVWpBdVhETUp1NXRn?=
 =?utf-8?B?MEdzMUYrM3lpOTNEVEJwNGNKOEhsQzFkczVZbGpOS29FMmhWK2JzSHVWWXlB?=
 =?utf-8?B?a0lBSDN5Nkdtdjd0SnFrSDRQMWUzdEVjMXBuV2swM0ZKcVFVTkFIRFUvNGo3?=
 =?utf-8?B?blVPSkZkRXNRcWxISk5jdngyS1RFK3hEUGZ6UWlOcGZxZTMvUEVHVkRwcTFX?=
 =?utf-8?B?MnZTNGVCcjVHQm1sZzdwd1ZvSzRKdXVobTJSMHFXVVZxOXhPR2RUT0VvMFBT?=
 =?utf-8?B?aXdySFp1dmYyM1FUaE1jQmFUOXZTNzJOcGZDRWg5MjlpVWpaNS9qYjJJVEFM?=
 =?utf-8?B?T0FmWVZkcGpodkdwV3VmSG5sQXR4YXRsalk5Rk5BUlhVSnNYbmFUZnNZamZB?=
 =?utf-8?B?c3NHamZEeWl3Z1ptRWExKzdKVi81UytjQjZoRnhRZXJXNVhsZlNIcXdMYzQ4?=
 =?utf-8?B?YkJXcmZTYzBUUlFlUlp5bW9DeHFuUTVNZjhqZWNITTliNXRwVUQzSm5YVlZR?=
 =?utf-8?B?S25wWFNJSVhlT1c3L3BLSWlPK2ZZcFc4QXF5ZVU1eWFsdGpyWFBXQkhBVTlT?=
 =?utf-8?B?MkYwS3dEWE9QMEVqVUxJWHRkZXFNUndLQjdGUm51MlVWVVNNNzViN0hvZUJP?=
 =?utf-8?B?R0ZkbzB0NThVMnBnU2dhTHMwd0RlUlJzQWpLMTVua0RZUHk4Q1N5NGhQcDZU?=
 =?utf-8?B?bG93QkZBVHRGSmgzTjUwN0RiM1hSTDl4SjAxWERmckt0OC95anNqZlEzcjJz?=
 =?utf-8?B?OTFNNWZ5YW5aQ0ZxK1Y2R29Uc2x4NWQ0aHdvSk0yVDNoVDFqanRGbnRlUVdY?=
 =?utf-8?B?clprTVJxQm5kVS9MZ3d2MHdyaUd6TEp6R21RQWhTWmljSWFWMmFxZkR5NkdL?=
 =?utf-8?B?SUF3eW1ZSDlkd2l2eDFLWjVPWE9KOFlnS3dBOFRuRW1URFQ0TysweWR4a0tS?=
 =?utf-8?B?Y0VNUXVNajY5NjBIUG1PeGJxZnFhZ0Qzb2tHV2JEL0FaSXp5ZGNtOVFNa1BJ?=
 =?utf-8?B?TlhaWVFYRHRuaXBPMWRqbWZhb01sNFlzdzJ5MDdqS2VXRXdsQWZWekRINmdL?=
 =?utf-8?Q?da+lxGD05MS/SubjGUVGIN0yirn24kAU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T28xWlFaVjZsdkJYK1pKR0NBWkJtRXQrZ1EyQUh4NDc3bTV6WXlZRitkNkxU?=
 =?utf-8?B?VU8xTmQ5aisxSCthMENjdkg4ZEpLcVVyZFRhU3pnbExQaVhUSTNvVy9ZRHdY?=
 =?utf-8?B?c1dXN1djOGc5WmJKWHRyM0RNc1J0YUl0Q3EwS3hXT3dTV0JQRjVzTkZnVHNY?=
 =?utf-8?B?eEEvU2hiamJMMG4zMUpieEtnNGVzYnhmMEs1MU5lNkR6cmpyWFZxWUZWb3NS?=
 =?utf-8?B?TDYxcE5wVDVFcjlmTGlJeFFHT3QrMk1Zc3ZaODB6TDFQenJoVThPYzNKSlI3?=
 =?utf-8?B?TkFiNm1mTWlLajkyMzZBMVFLVWo3MGNkbGlmWjVDcGhieEI0NTdRTllHbVBT?=
 =?utf-8?B?V1V5MTgxZ3V3OUdNa3E5VllMV014YWI4UzZIc0kvNnFkb3VsNlNDKzBKU2tQ?=
 =?utf-8?B?S05DbEhhbEc4cnNCVzVQNkg4dEZWbmE4SjZYUTVsbGoyNXI0UTdTMXRTNHVU?=
 =?utf-8?B?UElzYkQ5QnZHNXdyazhva3phWEp1YWFiM0l4aXB0SW1UM1hOdlBaNEsza0Jv?=
 =?utf-8?B?bG9Qa2lCcXM3WGRRaWJ2eDJrSVRuS0o3djdDSkRIejhUKzZvbUJMV3BPTUJD?=
 =?utf-8?B?cGNIYVBacTQ1akNEbk5VbVM5VElnUm5VaDJVd3NQWFg0bW9zbEhjenE3TWNG?=
 =?utf-8?B?cWptVFJDYWs2Z216dlJtNGRkZzN6MTMyREhyME5QUUlaYlN2YWF6NW5jenF5?=
 =?utf-8?B?cmMxMG13VlZ5MFI0UUl1NytUWUVBVmNHZ3lQK0E1cmxkSVVhM2lhVWNUN3c2?=
 =?utf-8?B?V1Uzbm1TMTk5MldnSlU1bmc4bUFQUmtnRUN0UXRJUlFMN2N3cmlOTGkzYkZP?=
 =?utf-8?B?VFloRDlCTWZ3SnV1VDNGNnlKditzN0JzK28yNWVwL2phVzM4SWdYYlBkcmNo?=
 =?utf-8?B?ZEx5K3R1bVZ4RGtKb3VhS2dxeHlST2g2MEJhcTdLbTVFWFJ0Y2o0UkcvTERj?=
 =?utf-8?B?bU0wcCtreVZPZTFhbHQ4cmFQZEUxdHQ5a2tJL0haMFBvV0tUaFhmM1JMNmVC?=
 =?utf-8?B?L1Nwd09VOUpPYWNyVkpTRnk2TU9XaUs3RHVvTHRranFPaGU1TUdtcUFGMmNG?=
 =?utf-8?B?MmFwN21laW1JODEzQkdYRWVvanlaUnhLQ1M1Z1lYcVJXYUxKc0w5Snh4dzY4?=
 =?utf-8?B?N1JWTzFsVlI5Ym5lcGJFc0dUcUtSRVp3c0E4TFJsZWZhbHhRL0dPR1dOR21B?=
 =?utf-8?B?Tld3SHYvN01GdnB3Ujg5ZDU5azhQaWRsZkFDNmJsNXJEY1k5NlFINjBhSXJt?=
 =?utf-8?B?OE04OSsxcStsSnNuSmlxSUVoaDJOL2czdVVHdjdlNDVrNlhLUGROV1VZOWpO?=
 =?utf-8?B?SXQ2MDN3ZHlJR1FlZmxwd0JkN2ZtV2Zac2VBYlNuekZyZUVYQkdYYzMyZ0Fn?=
 =?utf-8?B?ZVM0a1RRVTZSVjFsWWhVUm5hdlZVRDA0dzZzSENpamJLSVVoVkw3QWkyMHVB?=
 =?utf-8?B?b0xDT2ZNVEdORFJqY0lNY2VJRmR1WUFjMmNjdjFyNndTOUdkRWlDTWhnbTJj?=
 =?utf-8?B?djBwdjIveGN0S3NxdzZuQ1BVcEQ0eGt5VFphYWxQZ0xKZXg2Y2M0dEJ3NktI?=
 =?utf-8?B?NGNtN0dRMmhPc1RuKzlWeFVZUkE0emxjNXUycU10YVliaTVLdVgzbTBYU3pC?=
 =?utf-8?B?MkxCZWE0RXRqZGZCcE5VSW9CcXVvaWJNRFl3NDcwekE3Q2UyS3JRRWlCbmpj?=
 =?utf-8?B?WVZZMEs2YnpJQld5Y2crWkNaQzhSUUR1Ky9RdWhMZnM3K2REY1ZLN2x6R3l1?=
 =?utf-8?B?VWg5UHJVa1RPbStnT3VmNkR0TnBHR2gwOWZEUHFXb2MxLzJ6RmlwUFN2bHg1?=
 =?utf-8?B?eXBJdWc0VmlFcEdEcnVQSG5ZeGZUREQvaDNzM2NVbzM1RGJJOFF0WnlIaEVL?=
 =?utf-8?B?Z3pkMkF3ZUhZejU2anVLdzlhNmhsRnZxd2JUbVpsYldoQWdGRTNkdmtaS2Zl?=
 =?utf-8?B?VzFxejJNTTcxYTdrTkt0UTdYVUJ1RjRyT2JQQ3UwYkUzTjhsd0k0Z3lNN1Zq?=
 =?utf-8?B?V21CeVFvTHd3cWF3THZTdCszWXB0MTJCMTZhY1pjdy9ybTlkMS9aWkR0Zy9W?=
 =?utf-8?B?ZXdQbTNxZ3FtWGphNFYxZ3dUTGVkZkNJQWxVdHJSTmRVSDErTTUvaTdiMld1?=
 =?utf-8?B?bENMK1FwODVvWWxMSVVzT3R1dTRHamlpeG5VeG1ZNEQwblFULzlYNDRwbnlQ?=
 =?utf-8?B?a2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <342A4D10C970D3419074ED58C1645E1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ib2vAOM/bR6jSp4k39iobJND2CYL+97tsQXqAqLhAcIAXogIh9TikwjNxOOFPXzhpW10114r39SDQDlWbTKZyw5IPcPs+6MZPAgNEt4dzbPqfcQ34nwWbCBtJ3owYNedKYYpDkkjpHA9GHzB0gT4wT/KwqyX92SjZSFmyvVWL7VqcKRHmNmxdr/O5LRiAi5A8OGt1axIyoKTy/GGbYzVYXMnggBqYOb2vmj69ySU4xDVwBnpvAiUxUIQtVxbkioAHxPT4EeEgCcfiGxmVsoDXjU+im9lCkeaKcO64nDpJmvbBO/5oqdOGCG7SBUl0XcGo7zKorU4omII/YS7Ij1Up6N37zfaWBJmu2ZhGA2mxV4NTWXkFE+A4ke/LM9fV07Uk52MX4z81J5UckF+cziaT30qLQEfQUCca7DlpFSEqlC6LjTTR1JboUq3NOLy0SEOEHz6h26DHyfJoAzw1nKORNhnsZXUwM2yCpN5aH/41N5M8Sz3ls81xtlfdci0oglq8/yInqLtHzAG/FIssP6msAsLLB1mzDPJxRPflRzUktp1ZiqEImPpNDrXpjna18vv074Miobn4yzHGxzEWfNApjIJNNoe216WAFGKLaAZcRSX2YSILDeLelXfHsuZ53LOPaY3pnorCMMz7DW+Bi0MQA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45ab3b0-e697-4fef-d653-08dd3503380e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 01:23:29.7767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pS+FboHz6dHBeQbeL/wj+nC2SCevj1DsrW3EGxLXiIokhJWAnCRmPL/EuME/4RBu/qNzVQV3C+47661cZ0Rbjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
X-Authority-Analysis: v=2.4 cv=Uc2rSLSN c=1 sm=1 tr=0 ts=67870e19 cx=c_pps a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdSt8ZQiCzkA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=w17741Uzo5v3yYVCP1wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8RCrEe4faDKpzRJyy7yT2-0JXiYPJUMg
X-Proofpoint-GUID: 8RCrEe4faDKpzRJyy7yT2-0JXiYPJUMg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_09,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150007

T24gVHVlLCBKYW4gMTQsIDIwMjUsIEt5bGUgVHNvIHdyb3RlOg0KPiBDdXJyZW50bHksIERXQzMg
ZHJpdmVyIGF0dGVtcHRzIHRvIGFjcXVpcmUgdGhlIFVTQiBwb3dlciBzdXBwbHkgb25seQ0KPiBv
bmNlIGR1cmluZyB0aGUgcHJvYmUuIElmIHRoZSBVU0IgcG93ZXIgc3VwcGx5IGlzIG5vdCByZWFk
eSBhdCB0aGF0DQo+IHRpbWUsIHRoZSBkcml2ZXIgc2ltcGx5IGlnbm9yZXMgdGhlIGZhaWx1cmUg
YW5kIGNvbnRpbnVlcyB0aGUgcHJvYmUsDQo+IGxlYWRpbmcgdG8gcGVybWFuZW50IG5vbi1mdW5j
dGlvbmluZyBvZiB0aGUgZ2FkZ2V0IHZidXNfZHJhdyBjYWxsYmFjay4NCj4gDQo+IEFkZHJlc3Mg
dGhpcyBwcm9ibGVtIGJ5IGRlbGF5aW5nIHRoZSBkd2MzIGRyaXZlciBpbml0aWFsaXphdGlvbiB1
bnRpbA0KPiB0aGUgVVNCIHBvd2VyIHN1cHBseSBpcyByZWdpc3RlcmVkLg0KPiANCj4gRml4ZXM6
IDZmMDc2NGI1YWRlYSAoInVzYjogZHdjMzogYWRkIGEgcG93ZXIgc3VwcGx5IGZvciBjdXJyZW50
IGNvbnRyb2wiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5
OiBLeWxlIFRzbyA8a3lsZXRzb0Bnb29nbGUuY29tPg0KPiAtLS0NCj4gTm90ZTogVGhpcyBpcyBh
IGZvbGxvdy11cCBvZiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjQwODA0MDg0NjEyLjI1NjEyMzAtMS1reWxldHNvQGdvb2dsZS5jb20v
X187ISFBNEYyUjlHX3BnIVpUd2NLU2lkLWk3a040X042MjJIMVFEZUMzanppMHVDS1JxanpyVE5T
dEZHcjhndU1lM3hZMEVGMzBDbkdHUHlCSzI1WkNHZ1VjX1dnM2tveHdxYSQgDQo+IC0tLQ0KPiAg
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCAxMCArKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXgg
NzU3OGM1MTMzNTY4Li4xNTUwYzM5ZTc5MmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBAIC0xNjY5LDcg
KzE2NjksNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9zb2Z0d2FyZV9wcm9wZXJ0aWVzKHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAJfQ0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBkd2MzX2dldF9w
cm9wZXJ0aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICtzdGF0aWMgaW50IGR3YzNfZ2V0X3Byb3Bl
cnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCg0KSXQgZG9lc24ndCBtYWtlIHNlbnNlIGZvciBkd2Mz
X2dldF9wcm9wZXJ0aWVzKCkgdG8gcmV0dXJuIC1FUFJPQkVfREVGRVIuDQoNCj4gIHsNCj4gIAlz
dHJ1Y3QgZGV2aWNlCQkqZGV2ID0gZHdjLT5kZXY7DQo+ICAJdTgJCQlscG1fbnlldF90aHJlc2hv
bGQ7DQo+IEBAIC0xNzI0LDcgKzE3MjQsNyBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0
aWVzKHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJaWYgKHJldCA+PSAwKSB7DQo+ICAJCWR3Yy0+dXNi
X3BzeSA9IHBvd2VyX3N1cHBseV9nZXRfYnlfbmFtZSh1c2JfcHN5X25hbWUpOw0KPiAgCQlpZiAo
IWR3Yy0+dXNiX3BzeSkNCj4gLQkJCWRldl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IHVzYiBwb3dl
ciBzdXBwbHlcbiIpOw0KPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCAtRVBST0JFX0RF
RkVSLCAiY291bGRuJ3QgZ2V0IHVzYiBwb3dlciBzdXBwbHlcbiIpOw0KPiAgCX0NCg0KTW92ZSB0
aGlzIGxvZ2ljIChpbmNsdWRpbmcgcG93ZXJfc3VwcGx5X2dldF9ieV9uYW1lKCkpIG91dHNpZGUg
b2YNCmR3YzNfZ2V0X3Byb3BlcnRpZXMoKS4gSXQgZG9lc24ndCBiZWxvbmcgaGVyZS4NCg0KVGhh
bmtzLA0KVGhpbmgNCg0KPiAgDQo+ICAJZHdjLT5oYXNfbHBtX2VycmF0dW0gPSBkZXZpY2VfcHJv
cGVydHlfcmVhZF9ib29sKGRldiwNCj4gQEAgLTE4NDcsNiArMTg0Nyw4IEBAIHN0YXRpYyB2b2lk
IGR3YzNfZ2V0X3Byb3BlcnRpZXMoc3RydWN0IGR3YzMgKmR3YykNCj4gIAlkd2MtPmltb2RfaW50
ZXJ2YWwgPSAwOw0KPiAgDQo+ICAJZHdjLT50eF9maWZvX3Jlc2l6ZV9tYXhfbnVtID0gdHhfZmlm
b19yZXNpemVfbWF4X251bTsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICAvKiBj
aGVjayB3aGV0aGVyIHRoZSBjb3JlIHN1cHBvcnRzIElNT0QgKi8NCj4gQEAgLTIxODEsNyArMjE4
Myw5IEBAIHN0YXRpYyBpbnQgZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgCWR3Yy0+cmVncwk9IHJlZ3M7DQo+ICAJZHdjLT5yZWdzX3NpemUJPSByZXNvdXJjZV9z
aXplKCZkd2NfcmVzKTsNCj4gIA0KPiAtCWR3YzNfZ2V0X3Byb3BlcnRpZXMoZHdjKTsNCj4gKwly
ZXQgPSBkd2MzX2dldF9wcm9wZXJ0aWVzKGR3Yyk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJu
IHJldDsNCj4gIA0KPiAgCWR3YzNfZ2V0X3NvZnR3YXJlX3Byb3BlcnRpZXMoZHdjKTsNCj4gIA0K
PiAtLSANCj4gMi40Ny4xLjY4OC5nMjNmYzZmOTBhZC1nb29nDQo+IA==

