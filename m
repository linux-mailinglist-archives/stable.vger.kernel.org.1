Return-Path: <stable+bounces-114983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592AAA31B1A
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 02:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9857A3415
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96961C695;
	Wed, 12 Feb 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sGJx59wu";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iA3BqjMV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="wu1fBCDh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4B2557C;
	Wed, 12 Feb 2025 01:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739323110; cv=fail; b=uCk88RWsRXmj30njRS2baym5prdpVbZlqeIIs3H1/z7fM+hlXg1ErV2XObtcSsTINw0//5BO5IPkynDxXYlwoQ3e+T0dhfJrZOo6YlNPDkrIzoS93U3pDN07kmqiqiO36We2Gl21aNawVJgN5F3Gi8Y5IECKcxpkE9/+Rod+PHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739323110; c=relaxed/simple;
	bh=PpDnoTMbEOhfxgbMLgToHxD5XnCDaTPvHik6GwzqvWY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WV1aGgx4cOcmtO3j+qJQyurIRzoZmtdhURu9LXFu9ivJeBi8Znb4SWKYEd8o2ky60n53GNXqH2QcsNJ29EwwzQOg4ZVPFTEs4NysrJMuTEDbumtUCGJ91B/FBLhmaQs+Mnbq5/bu6/r38KTPz79O5QlfP9QgWpk0TOApRAR3+b8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sGJx59wu; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iA3BqjMV; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=wu1fBCDh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0lPTq002463;
	Tue, 11 Feb 2025 17:18:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=PpDnoTMbEOhfxgbMLgToHxD5XnCDaTPvHik6GwzqvWY=; b=
	sGJx59wuC1aHtCEsE8rKAQiJOLGiNfjah8ZKWloVXoUlcBNILVZJHS5FASpdp8HZ
	vcOhZD4k+XIhvdgWtToM3Et7vb45YjriuPmjxRFSRYlitiGvVUz7xRKkssR8Sdqx
	r/jYetN5Hr7WZtMOmi0YqETxh7p5OrmLFVp3ZwmcPaqR4fcMvk7wruFadczJiODs
	bWJ3Xu5Mp/OBk/Mn187fpFf0WZCfT3xGZsiTnMmskvIWjcSNMBSA5+Hnlo2ADs7K
	JTDUlV0ZMQDzSfuBfXj3aADwiGSa0UINEZoviCWERr8yaHvdasLnUskXL9vWoQgt
	3ujNvoA/glqSMNoBb695gw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 44p6sjj2vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 17:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1739323080; bh=PpDnoTMbEOhfxgbMLgToHxD5XnCDaTPvHik6GwzqvWY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=iA3BqjMVVudDPgipNbP8GI5l60NsZaU1ovcNMGCk6ooMNg6kSq+jo0abjJYqHbb6V
	 mkaD/pstvQVa678AD1rsmD1djpsZ/eJa+ocq+L3kIVWXscm4wvzN7rk/+17mFljhS1
	 jNt7uxf3HGson6Kb6u8284yD6ZQ5N2iUvuQ8p2LXQSVXo/CFdbvc0/8EW1/006b6ZM
	 pGWyc8GUV/f4tf9WCkTnuCe9hXxcAi5AaOaMYnpMuAYUymS138kD59be0ergTz/tk/
	 k+Q2pNjDPYS8SWNudwGh2aO/V0T1qByxvRfWqVIGQfMWHvzBXXJdN7sTyUhduhuxL5
	 Conx8m6wCKNjw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 10DA040353;
	Wed, 12 Feb 2025 01:17:59 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9B9FEA0077;
	Wed, 12 Feb 2025 01:17:59 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=wu1fBCDh;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DCA1F4034B;
	Wed, 12 Feb 2025 01:17:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USwr3drfptr415W68VlJSAxmZaeORPCBRHT0qe6ACeA8UigTn5devdNwVh5ePKgG56YLn+syKi305tArLoByUN2IaDrPuRZFRJKF2HO72S24azjJ6Vi8IzDXusF4utiFBc53SVqKoc1+ECVwV4OAlaZW1Gw4NkPCn0wvTr1dE81fpYzW9LxaUkkDOTBXVTQ7q/EUwtE1eXRApp5O0rHYT+mEMAFL9HQKhYTCY3xbJArt+8dnkbB+4gtH2lmcxmFTlCijliSAKbZf8niAsTc0RHvxBspwqdQRwyXoCIzFS2w2T0NXlhZRU3vS9ICTYu5M3ltWjrPXexUvOTwEKLyFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpDnoTMbEOhfxgbMLgToHxD5XnCDaTPvHik6GwzqvWY=;
 b=XEC9Lf32jUZ0OSLws49EqxP3OiZvY+xDpDZFCvBO83hMZMiyt0o88xCO9eNWu03wCN2pASl2wUvdIzG8jrzMg/QF4kpvO5sdtGw96FVuRJlLQOocSZZexsySlx6n4YxwUtmjUEHHgPrlQ83M3N3nIk5I+n1b0q55PJuX0TjFXaCEdsigf4fqgOmhIQugXV+aYaFaRe5g7Hh/hH/82vbvzRsHkfGh3LXtJ8ggnvUTZ35pujUswjmGFmMehCx0fKVyTKI7yQE+3+zAHgVxszBip1xrU9+rHgomhEHy46vGKeVUmd46kEMJN7yy0xQtIUP90gBXY8mgEpiOjqSsw5GLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpDnoTMbEOhfxgbMLgToHxD5XnCDaTPvHik6GwzqvWY=;
 b=wu1fBCDhOCke+vN1jd0MVO4kEcM+WuRl0ljBRT4vctRv+nlp1/1pJLB3NrWmxQDxcZTxahiu9S6fnZYrvpRfgb3oE/kjG111z0xn7OJhKS3okG38VO8nrHN4fYaItz9RaQJ8XmeeWRCttwlVLgQrK2QJt2nQPckq4uJpZyz+ZNc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 01:17:53 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 01:17:53 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roy Luo <royluo@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andre.draszik@linaro.org" <andre.draszik@linaro.org>,
        "elder@kernel.org" <elder@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "crwulff@gmail.com" <crwulff@gmail.com>,
        "paul@crapouillou.net" <paul@crapouillou.net>,
        "jkeeping@inmusicbrands.com" <jkeeping@inmusicbrands.com>,
        "yuanlinyu@hihonor.com" <yuanlinyu@hihonor.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "balbi@ti.com" <balbi@ti.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: core: flush gadget workqueue after device
 removal
Thread-Topic: [PATCH v2] usb: gadget: core: flush gadget workqueue after
 device removal
Thread-Index: AQHbd12ql8TFqGFfNk6mnSGWIWfpIrNC6SEA
Date: Wed, 12 Feb 2025 01:17:53 +0000
Message-ID: <20250212011750.h6epao5gs25ibdvb@synopsys.com>
References: <20250204233642.666991-1-royluo@google.com>
In-Reply-To: <20250204233642.666991-1-royluo@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH8PR12MB7446:EE_
x-ms-office365-filtering-correlation-id: 144df338-b546-4c70-4ee1-08dd4b0312f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q0JoL0NaOVFzRkg5cm8vODVaTHdiRHFZOUJaTmVSYXZIUWVDNGYzRnZzdzFr?=
 =?utf-8?B?VHh4Q3ZiZlNKbkhOS1V3MFI2NjE0Nnhhbm1WWnBTN2FZcGRsdXVRN0pMS1Az?=
 =?utf-8?B?RitaVGxUdmh4MVZxRTBYODdlNmpjNVY3MVdWWlhQS2hvQUZUU2g3cDkvMWFn?=
 =?utf-8?B?WEZDSkR6dm10VjROTWhIN0ZYMSt6dTM5WE1BR0Zzd3JZRnpQYndiNk1LalpN?=
 =?utf-8?B?aEdqT3QyYWd5S1dFRTE5VkJzRGt0S0tjOHg1V0ZsNkxjb3Q5VTRtRUkxUnZ2?=
 =?utf-8?B?djNueFFFeURNR0Zldmw0TktMemNpWi9WU1l2NDFKbEpxRGNJT0dpa0k2c0U3?=
 =?utf-8?B?YVRoV1VldW96Z0NpcDVKTXc4T0pTd05xakw4Wk1FMkRGUEhoWVFicThjMXM1?=
 =?utf-8?B?bFY1bXZ0a0Qwbm5oOE54NzFmazZSTEJWNDhsR3ZQNERZVkdUMUtQNHB3cjdm?=
 =?utf-8?B?aE5zcC84TkdFTnZZMzkvSFJOZWlxbVhOQ1RScUpvN0pweFphdzAwQVRyMkxy?=
 =?utf-8?B?TFprTzBpcU4yZE41dUF3TURROHBRS3BPWmpiWFBqSEh4SDJvOGZwME5DL1lZ?=
 =?utf-8?B?M1hPMTk0SHdLc2lYdnhpNlg3ZDlDUjhXZGxEMXVBUWdYa2hXZ3hGcU45TmR6?=
 =?utf-8?B?ekwvejl6VHNTTkg5UnJkTC9yc3ppYXhMaUI2ZlNPczljaTBFWTF5c2dOQXUr?=
 =?utf-8?B?NHMrZWtaOTliOVpYL2t3ZWltQzVXUmZod0ovUENpWDNuaVhSNi83RFVoSStC?=
 =?utf-8?B?OUo0ZHkxRlpmcW81dUloVW9vb0U2Tjd2VklWbERTRE8wK1djdUg4enVIZFNj?=
 =?utf-8?B?YXlaYVlDTHhXcHlkMFNvS0hLaHY2dy9nOG1tNkRPa0F5N1UvYUhyemFORmEr?=
 =?utf-8?B?RGtKU04xa2JadmhkWVlpaVgwQ3IrR0U0MDhQcXZYTkg3VzdnUVAyN01UY3BF?=
 =?utf-8?B?NFlLQVNLdStQai81V3JwYmJLcGk2NXNqK2dBWWlnSnlUZlVtUFdONGcrc01W?=
 =?utf-8?B?azViblRZQXZoUHNlcnEyajhmU1pTelNHaDFyRlNCQW5JSTM1TURqTzE4UDJu?=
 =?utf-8?B?d0YzME9QZkZLNjF5SEZYcFZrd3ZYbzdiQ3JzMUg2bk4yM0J2bHBoYVNSL3lm?=
 =?utf-8?B?aTNqUEFnc2J2cE5xbTdBQnF3NHhxRDFLK1djODEvL3JMYnM3SEpyMmN2Rnl0?=
 =?utf-8?B?RnhUMkp6TUlCWWVuOEcrSDdmU05QMHNkRENsL0I4K2JLMlJGVm15M0x2RkdE?=
 =?utf-8?B?VHZJbXJNdE4xRUZ3ekpuS2VPOGh5aG0veklDa1lZNDA3L1YwcWkvL09iMUZ3?=
 =?utf-8?B?bytYcWNNYTFacG9NU3dkT0RYbC9xRFZ6c28xa0FkNXgrcUNkc3VlUmo0RTRq?=
 =?utf-8?B?eG1aeTlKVWMwMzV2UDR0VjNLNzJGYlZFT3Y0UWN1ME1Fb3dNTHRrQzNmNVcr?=
 =?utf-8?B?aVF4R00wWDBzVnIrd0FYaHRnNVRkUE5vbWJoS2o0THI1M0k5WmIxZlVpQ2Iz?=
 =?utf-8?B?VkdiaXp6RkhrVEdtaGFydXM4OFk0U291Rms1TWp1UnZ6Y1BESXQyKzlnRURP?=
 =?utf-8?B?eVpJRndpdjljL0lWc2tZN25pNm80TjdHZUZ3ZkZ4V3c3UEVrWmlrdWhpWmQ0?=
 =?utf-8?B?bS9KVGdEQmJYQndEdXk1VjM3WXVIYkFXcE5jT2M3VW8rM2gzQjI0a0VHOWZO?=
 =?utf-8?B?R1JwUjhPRkVjaEE2TGpRcDlYc1dERldNU2hOMDNES2Vudzd1QWNlOGRwU0RM?=
 =?utf-8?B?Vk40OWhvRnEzSVBKV0QzVzBrS2p6THl1NytRWlBqR20wMXZQdGhqdlFzT2FK?=
 =?utf-8?B?aUg2UkpQSXZDK0FWK0ovQWllY0h2MDZrMFYxSUszZGhDbEhhcFQ3cXhyRTBj?=
 =?utf-8?B?eWxMNENTQ1F2SDFKRjlScTBrYWNOdm5HZWpNcHh4dGJJZEVlN1FtZ2RNUXQ1?=
 =?utf-8?Q?wbQWmqXy14LPXePoJMqIjyOX+DXIg8Q1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnVKd3BCZXdvcUpjSVl0OGYxZXRwWEpBOEduMExJNEVDd1lXZWNXaFhNUGtr?=
 =?utf-8?B?ZWM5L0RHdG42dmNGUTZNWHFjek5mN3c4TE1JRmZQUVNyVUN4ME5wOFNZNUF5?=
 =?utf-8?B?QktWWmtybS93ODU2bVVMcS9icUxtc1hQK2IvV2I3NS85QnpJaklKcUFFaU1J?=
 =?utf-8?B?V283bnZsajJzenVWcUxDbGNBcEk4cWRaSDNWMUcwZWFvSHcwU0MyaUlnUHQr?=
 =?utf-8?B?MFcvTElFaE8ySWdrK0tCRVEyQWFvWmtlUkZsc1R1YkRtVlFNMHprOHhWMHJD?=
 =?utf-8?B?cnhXcUNuMC8xekNxdmdoUFlvWGRKaHdmRFc3aDJUUnAxRURaZ01iWHBhUnkv?=
 =?utf-8?B?WnloWDYyZ2VvK1pReGNvemJRN1hJdFpWMk5LVEtjRXhoalQxYU5ZQVJNbFUy?=
 =?utf-8?B?djlMRjYrQzVuUm1LS0dtOEdnaE8vTEZVb3gzK1ptSlFtbzhrak1zRWhNWEM3?=
 =?utf-8?B?UXhGM1l0dzBBb2hQMXdzaXFzbGw0dDI4cytNUUVocVIwVFhtcXBZY3M4OFVP?=
 =?utf-8?B?eFZGT2NVVC8yME5rcjlzVUlMTHcwMk1Kb2JVZ1o2Mzh0eEZsKzNoT3MvMTBK?=
 =?utf-8?B?eXpXelJZTXZoSTRTWXdnb3BsT0JobDVYWWlCR25OeXpUNHpUek9IQTl0QzVW?=
 =?utf-8?B?WDdmYzhIbVlpdUYvZkpBNWprdGcrYW56YVVlcVJuSCtPcHFNSTBCZ1B2eUdt?=
 =?utf-8?B?QUYrWHU2ZHkxbFhxcEpIRkYzZFpScWhhcnJ4c0RqeWdhN2E4YkRLN25WZm91?=
 =?utf-8?B?b0FYRHlsVFVJbUZkWlRTbjlwaDE0TFJ4L2FNdVNmcjRvR2I2RFJiRVBqcmNP?=
 =?utf-8?B?ZUdIOXIzV2N5Tm9jSi9oK3V1Sko5cXlPWDdtQXVKSkxNalo5ZldKWWlmL1Mv?=
 =?utf-8?B?cmtDMlZib1kvdU1YUG5lejZhaEFpYzFhQUxnZTBKejFSYVk4aVNmelpLSGtz?=
 =?utf-8?B?ZE5VSzg2OFc0ejNKODZEUmI3ZzZLSDhVVytzYnkvZFUxbUV4eHlvM05JbW5B?=
 =?utf-8?B?SkRFTCtoNnZSWXRlOUdJbDl4YmdacWc5aTR2d0QyV1Z1ZGNxd2JhUzd1ZGhG?=
 =?utf-8?B?QlU4WFRQdW5IS29TMnI4a0J0QnB3d0pFZXNEL1dsd0ttUkZRWCtJVlU4c0VO?=
 =?utf-8?B?Y0I3YkpQSk9iTW42djY3SEVkWG1TUm1DRG1sVmZiRFoyREMyNmgyVSsrclBz?=
 =?utf-8?B?aEcvWjkzWGVQcWFGN0VyVVd5d3ROdzBZN3d4d3QxR0gzNjJ4Wkp5OWxoWjNi?=
 =?utf-8?B?bXhNSlBmWW9xM3AwSWREMTFsUll5OENHYldwUTl6ZGVFTGs3QnhEeEFJVnVa?=
 =?utf-8?B?TkZKY1FXYnlkOERoWXNhWnpBNzhCQnpWVHE0L1VVM0JGbjkrdjR1SVg0K29D?=
 =?utf-8?B?emdFTVJ5V1ordytseno5Qkpvb1o3MURiOVZDakliTU5GM1VMV2l4ZUNyQmdC?=
 =?utf-8?B?TUliNmtRSzJHVW44SmRVd0NYUEQ0ZmNEc2xrRUhWams2RjhsVFMvb2ZTL2Ry?=
 =?utf-8?B?Nm5MTTUrZzd1R09rWDBBV3B2OWJXMTZQMWR4SGlmZHRyQWFhbFJHdzdrVW5Q?=
 =?utf-8?B?OCtmTEJobXA4YndrQnJEdlZuV0hoQlFVYWduS254SXVFZ3ZOSVdBMCs0N25j?=
 =?utf-8?B?eXBKek9OQVl0blk5am9sd2E4QXFYeFJTU0M1UWVNQTNNS0k0UXJmbURRZkp3?=
 =?utf-8?B?anZTc2dsbVFDMEJHWkdFd04xSVBxVU83KzNQWkNDeGFBS1NqOWtlMlBDb2kv?=
 =?utf-8?B?WEk2UlRBcExSeUpLL2NzSU9ZRVBEYU5sbSsyWU9NUnlYbGNveW5QSVFERWFu?=
 =?utf-8?B?dURGckdBWEdoL3NNVFZZUmFMYkFUdWcxdlVwMFVTZlEzSlVLRFB1WGl0SEFu?=
 =?utf-8?B?NVBHVERhbFExWk54M0hSZkNvano0V1dFWjZjbUtMMjVHUlRvWm9hbmNiRzZy?=
 =?utf-8?B?ZEZqd0huNTVPMGNJOXNBV05BTnZMV2w0bUZvZlFaNUZCa1ZyeGFTSzBHaVVk?=
 =?utf-8?B?U2VjM2JiVkZMQjdHOWhodmtMeEt6endQOHNCc0YralNMQUpxSEJlYTEyajJI?=
 =?utf-8?B?ejVkMVRNdjRjRmIvaUQ0WjBsL1JVTUhZUFcxVmw5TENrMGM2OTZ4dlJWMTlJ?=
 =?utf-8?Q?Uw1HKnySPP9SrhWDIv3zuUvrM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F815F0FAB384DE468E94956B58DFDE2C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6hEkbJ0G/jNSl5EhIxtPkOINH/GlcOnyj2vUQOVstdCPD27AG5ptgRg6yjL8lXwUNmaI/v8bmeuuLGtkqxBzyalaeZzJHUY5HY+hSZ4/OT/RTyP5Bwu+6IbIRwV/p/SiBXNLBhBZO5k8I5puqjAUR267CkOaZOUAJTcvsUtUf9GYzUDqcOPZL3rmgqPiGRkkbyf/q1WLj5gXv4cktzedXIFMiMCSDKYYoc0cLRyWkrL6pRie0SBkMYlTL7wOKaDSXJP8RFbc3W6mU3UjtrqsvdV8T0HVU6XaVSV+KUlpTKExZplIPbZRJ9wr6HEmR5h5aiR7BBcPCCl3o2b14SX859SsaGh8Qii6ow7hAqQffoQhwHNEWbUNGwQs1OUl/0lrpXHqcGhxf2c5epdRYzIAtdxnnPaJijWbKTPW65Jmz8aUh4xF/SCvKfQVdPdWAEUmsTX/THjOKSkkzOw7ZSutfNeZpkY+9Tdy49fgZ3ByqNe91AlOf2i8I62mod36cWjw++nY3GPjoh7z+wG1jkB/8lQ9JMLD6oQqRV1SjGpuyJFaMNNm6ntrvh0BLoH/kx0gsDXiIevchQaTa9pkUptQKZSkKygA96AO6qryc+nmzgk0/HD6xqCTwcUa2DyQrMDCnp0PP0XBvJ0eVoaGWHLyRA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 144df338-b546-4c70-4ee1-08dd4b0312f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 01:17:53.1554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q12jq5M581ReS+6g0y65z76V/rQm8I8wujcZ/99klbRCE0UcfGSHpLd6AChvgJhsVUG2+LA7lFhHHloTgOmuTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
X-Authority-Analysis: v=2.4 cv=K87YHzWI c=1 sm=1 tr=0 ts=67abf6c9 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8 a=Gi2OQlj1whm7ZgGx-tYA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
X-Proofpoint-ORIG-GUID: Nna-2cmrAU99lB4gkMkrDDQNmH_GIXWe
X-Proofpoint-GUID: Nna-2cmrAU99lB4gkMkrDDQNmH_GIXWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120008

T24gVHVlLCBGZWIgMDQsIDIwMjUsIFJveSBMdW8gd3JvdGU6DQo+IGRldmljZV9kZWwoKSBjYW4g
bGVhZCB0byBuZXcgd29yayBiZWluZyBzY2hlZHVsZWQgaW4gZ2FkZ2V0LT53b3JrDQo+IHdvcmtx
dWV1ZS4gVGhpcyBpcyBvYnNlcnZlZCwgZm9yIGV4YW1wbGUsIHdpdGggdGhlIGR3YzMgZHJpdmVy
IHdpdGggdGhlDQo+IGZvbGxvd2luZyBjYWxsIHN0YWNrOg0KPiAgIGRldmljZV9kZWwoKQ0KPiAg
ICAgZ2FkZ2V0X3VuYmluZF9kcml2ZXIoKQ0KPiAgICAgICB1c2JfZ2FkZ2V0X2Rpc2Nvbm5lY3Rf
bG9ja2VkKCkNCj4gICAgICAgICBkd2MzX2dhZGdldF9wdWxsdXAoKQ0KPiAJICBkd2MzX2dhZGdl
dF9zb2Z0X2Rpc2Nvbm5lY3QoKQ0KPiAJICAgIHVzYl9nYWRnZXRfc2V0X3N0YXRlKCkNCj4gCSAg
ICAgIHNjaGVkdWxlX3dvcmsoJmdhZGdldC0+d29yaykNCj4gDQo+IE1vdmUgZmx1c2hfd29yaygp
IGFmdGVyIGRldmljZV9kZWwoKSB0byBlbnN1cmUgdGhlIHdvcmtxdWV1ZSBpcyBjbGVhbmVkDQo+
IHVwLg0KPiANCj4gRml4ZXM6IDU3MDJmNzUzNzVhYTkgKCJ1c2I6IGdhZGdldDogdWRjLWNvcmU6
IG1vdmUgc3lzZnNfbm90aWZ5KCkgdG8gYSB3b3JrcXVldWUiKQ0KPiBDYzogPHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFJveSBMdW8gPHJveWx1b0Bnb29nbGUuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvY29yZS5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2NvcmUuYw0KPiBpbmRleCBhNmY0NjM2NGJlNjUuLjRiM2Q1MDc1NjIxYSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9jb3JlLmMNCj4gQEAgLTE1NDMsOCArMTU0Myw4IEBAIHZvaWQgdXNiX2RlbF9n
YWRnZXQoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCkNCj4gIA0KPiAgCWtvYmplY3RfdWV2ZW50
KCZ1ZGMtPmRldi5rb2JqLCBLT0JKX1JFTU9WRSk7DQo+ICAJc3lzZnNfcmVtb3ZlX2xpbmsoJnVk
Yy0+ZGV2LmtvYmosICJnYWRnZXQiKTsNCj4gLQlmbHVzaF93b3JrKCZnYWRnZXQtPndvcmspOw0K
PiAgCWRldmljZV9kZWwoJmdhZGdldC0+ZGV2KTsNCj4gKwlmbHVzaF93b3JrKCZnYWRnZXQtPndv
cmspOw0KPiAgCWlkYV9mcmVlKCZnYWRnZXRfaWRfbnVtYmVycywgZ2FkZ2V0LT5pZF9udW1iZXIp
Ow0KPiAgCWNhbmNlbF93b3JrX3N5bmMoJnVkYy0+dmJ1c193b3JrKTsNCj4gIAlkZXZpY2VfdW5y
ZWdpc3RlcigmdWRjLT5kZXYpOw0KPiANCj4gYmFzZS1jb21taXQ6IGYyODY3NTdiNjQ0YzIyNmI2
YjMxNzc5ZGE5NWE0ZmE3YWIyNDVlZjUNCj4gLS0gDQo+IDIuNDguMS4zNjIuZzA3OTAzNmQxNTQt
Z29vZw0KPiANCg0KUmV2aWV3ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9w
c3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

