Return-Path: <stable+bounces-91974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C639C2912
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 02:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C84B22119
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A417C9B;
	Sat,  9 Nov 2024 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iNAgYeI0";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Qo114VOK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ik2479XV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121C23A9;
	Sat,  9 Nov 2024 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731114391; cv=fail; b=YRNVUCbj5PrCsfcgReMyNFlEf75/+B7vooq/ffxDCx0oaDfIKSHhlqEqBj/f6A4i1ka3HnffqXSlZ798+zPYh9LsF6O9ySeQ7RxPuTsS4yIFWWWq2QcU/j5xKc9OW09arWDARLsxZBhDlOu+kCmy8PqCARTpyn5ElH8bNsXuq50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731114391; c=relaxed/simple;
	bh=5i17AdRQNMVQGvrv9ZvH/RhidPzoN2fFPu3bdxowE7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XE33yh5N0jqku3FF3h+TevwjLAbmHJTStKPb4N/uUWSthdUqAIHMTSV43xnRP3IrI/LpkIK0vMxeNNm/TceUudbW3u0/nTYB/pcQXWFdTdfEG17o1J70qqL6YGk+tmbBn4Nq6voQErLXuzcls5RlcCqV4eU9iiOlDLGwnQWNn9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=iNAgYeI0; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Qo114VOK; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ik2479XV reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8HhHBi017602;
	Fri, 8 Nov 2024 17:06:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=5i17AdRQNMVQGvrv9ZvH/RhidPzoN2fFPu3bdxowE7M=; b=
	iNAgYeI0R5dyzib4Gwym+DocFWY2ubWw67aoLgEyjwCscgac+/mIRjEGC16ZDAsH
	lIPx1PwOl6s95RB+b4TP/NqmVjBY2jdNdw+KlIeHuR2Nnj+fkTNbBo1sVXX2N1fa
	mqG/voj7WZtpJXl6ldt4ecNf1fAHVFz2qvm8YWiJiMG2lAlpNbOdBYpHiG3yVvmd
	DBpAxXAhVVok7SoQFw28irS6xjGN5YRhzpyjK3n3KhDtSFoAlnx90UK2s4einZ3H
	0WyKNlNpbbWg2ItqUZJ2RMBRsenfyRMtg9tXEqkipPnWiM8w1mQnG+iZb9XdtAcq
	mlca2sFZwScCwLAZz3TEhw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 42s6gjpvbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 17:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1731114366; bh=5i17AdRQNMVQGvrv9ZvH/RhidPzoN2fFPu3bdxowE7M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Qo114VOKnlRJ+NE/CutJMJg4LcP/RUkxZr66JAVNa7LjZ8rVFQbkUCj+t1OTM6Yh0
	 JNW0WAiTr2yJRZtDxKJZDglqpckDUrG/x1TyYCeakkLRD/vB/rmOoN98bJ+L3KFtY4
	 +yWgjHYR6UlulWZWtJpn4I3seF8mvkg9W8dDiMiMPmJu74POEfreTR7L8ByvuE4qrj
	 za4QQbVoNQwzYG4NfYR0wEU9OoQn6Ex3RV3WEHoBiMsIIBpge4r86rdYcHcmkbGK9V
	 miBrTFF58Y3sMIJr+qPhaAwW5dvrMhoFUdyudpmMovobA0U0cVAxzlCvkhx+jEyAyB
	 YQ/KCAQl5fMgg==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0E16B40354;
	Sat,  9 Nov 2024 01:06:05 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 5005CA0077;
	Sat,  9 Nov 2024 01:06:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ik2479XV;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 647FF40174;
	Sat,  9 Nov 2024 01:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTH+CeYBDQqpAWpygDcNy6X9LRUW84jEPQtCj/rWiy1dM1moY5bKJTQpWoOFV1LLzsdeKqs7RI+9IS8VoYdC+6VC1hqYOU8tWU0OgcuRAhUtzViel6kY3W4fZ2xAUI5j3hycNYeCK014iInemWVyJD0j973YlToGfy3rg9jS+x0hMywAJybqny60D5oKAZP63bCsYyzI/jcjRBzV6y6E3FJsLGmCm8yyk9w1sM8VMs2qM7A47hyTGiy4hdqoLwgtApQrTRuGxW2U++6EzFmjngL5wMjanNRDPZCM/ojsGBBfi4DpqVDqBKjcPg9g7Y62wms3LfQXUasLl5lrBDpplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i17AdRQNMVQGvrv9ZvH/RhidPzoN2fFPu3bdxowE7M=;
 b=h6Y5W9+MySL/1hf47VVnUDYXkDALVYscqKvMLaCTewi0y2Q3XMprE99ThC0rkGSSNDENnUsCRiFyP9TNZXWXxWkQvEGThyoWcdoTCvDzIIpp9/GLJIf0rnKTW0wpJS3ja9jlZfWiK0mKnkKCb79vqaeBNla0poxIpjKt7jvuwuZzWLtGPzpgK0Y5Cv2T71qWDRTM1DPV7se5ktd0vX1nJE1OwEEbfVCDu0h0byavgl7+5uQzzB2HEfriMLR+hFIThGlwMwuxl/0UzRGeguy6bXZJa+Bkh6mcuEIA6senfUN+TnpzDYoVAxm9Kd3Xd3Z/DIlZ6WTl/qnbyblNNHy+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i17AdRQNMVQGvrv9ZvH/RhidPzoN2fFPu3bdxowE7M=;
 b=ik2479XVMvpHsVrMJih19W4JK5vwCMFjMLkliyUJ1473RmOQQxT7tw2+Rr8YvBd1DLkpDdia9pAUKeq/ete+J9IjRzbeoyQAaJg6G//T+2CffWC1XzsvB2FAWcTJbDUfyyOlEfplQ2bHTe0SqoBGI6Ehyke2WJ3gTQCCEDeYikI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Sat, 9 Nov
 2024 01:05:57 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%4]) with mapi id 15.20.8137.019; Sat, 9 Nov 2024
 01:05:57 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>,
        Alan Stern
	<stern@rowland.harvard.edu>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_akakum@quicinc.com" <quic_akakum@quicinc.com>,
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
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Thread-Topic: [PATCH] usb: dwc3: gadget: Add TxFIFO resizing supports for
 single port RAM
Thread-Index: AQHbMQHbau1m5SPRoEuLkzV8BIeusLKseQuAgABZaQCAAVKHAA==
Date: Sat, 9 Nov 2024 01:05:56 +0000
Message-ID: <20241109010542.q5walgpxwht6ghbx@synopsys.com>
References:
 <CGME20241107104306epcas5p136bea5d14a1bb3fe9ba1a7830bf366c6@epcas5p1.samsung.com>
 <20241107104040.502-1-selvarasu.g@samsung.com>
 <20241107233403.6li5oawn6d23e6gf@synopsys.com>
 <0c8b4491-605f-466c-86cd-1f17c70d6b7b@samsung.com>
In-Reply-To: <0c8b4491-605f-466c-86cd-1f17c70d6b7b@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SN7PR12MB8104:EE_
x-ms-office365-filtering-correlation-id: 3d64fb63-4f96-4dc8-671e-08dd005aaade
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ejJCY0NJRnlRRnhMUDhQYk40MUF6UXpYT3RtODBKNDhmS3hiVzhybm5DRDdC?=
 =?utf-8?B?OU1ySStLdkRoMm5zQ0wvcTJtUHRHUWl5dHQwNExNTnRmVCttRFcrNWQ1N09P?=
 =?utf-8?B?ZXVodzVhMWx1TDZKaU5ta3lkT1ovMjZibytOc1VoM3BlM2lubzIwQlo5WUVa?=
 =?utf-8?B?d1dzaG53NjhBSEZmL0o4U0VrekZBcEJBMnFLbGhBNzJhcVdKQk9tSzVSek5h?=
 =?utf-8?B?NW91WGp4K21tWHVZWTVTZ2tCaHloS0ZaUzN6dDQ0QTZab0dGYlBnSFBjOFp4?=
 =?utf-8?B?eU5Sa1pIQ2g4aHdWY29qWTRXcDBXa3hzV3NhbXJZOWxmSkN3czlFUFhGcDNy?=
 =?utf-8?B?d1Y5YnpPVUNENllDbUVoSlkxcXc1QnltaUxVSzAvLzhNOGp5eGZTOUZEckI4?=
 =?utf-8?B?MXMxMkhXWXBHSjJldzJ5ZzVSblJ0UjRFMzAzVVZuNkxWdVB0ZWZOQ2g3UmRF?=
 =?utf-8?B?d2k1bnYxcTdpbzNBNk5KSHRCUU9yekR5OEJUREtyYy9kSUw4ZlYrck11bHVG?=
 =?utf-8?B?U05ETllOUlYwTlFHL25TZ2ZNZDBsLzFiVlpoR2pzbEY2NXJOMnpLME5yREw4?=
 =?utf-8?B?U1owS0lnVnlUWEtUbmRaVDRnOGgxV0E5a2dQU2tEUjJFNXAxSHoyL2xtSU5T?=
 =?utf-8?B?aGdSUGxhaDVCRFZLdDk1aXphbWxWSEhIMWhUVVBNTHFKa0NwWW42U1pwY2JL?=
 =?utf-8?B?dVpCRkovN3hON1h5L0o5TWtFRVd1TUpkemhCSEo4Zk5OU1BUNU4rMGdGNWVU?=
 =?utf-8?B?a3hpWTRQZjVUQkdBSW1XT0xITDdJaVRQdXVWOTZmTCsyYk14TVl5R0U3QWN1?=
 =?utf-8?B?NTErTDFsVDY1aXV4MVoyOE90b1dqTVdlbjR2UmlkVCtMTmlHcUg3MU1GZm8y?=
 =?utf-8?B?dE8xeXk2djFMVzYxc1JMVlNKNk9vYzhMd3FFSzlaN1JYSEFvTWVFWUswOTRF?=
 =?utf-8?B?cFY3bEthdFQwSndKYU41Qm8yYXFEYzMyNWkydmJReE1PSXBNc3BmeW9PYkY0?=
 =?utf-8?B?VzlieWRJU1R3dFpCMGR2SVBjUDdEWCtkQ0FyTlFUczJlRS80dGtEZXVGS2pI?=
 =?utf-8?B?NFgxV3Q5THdRRkJWNnJCUm9oRDRNZjluUXdMYXByeGMzaWJCcHc3N3UvM2I0?=
 =?utf-8?B?NmgxVGp0TFpiNytIZGtRTFJNMC85ZHhsenZPM3ZFK0l4RUJTdCtWT0hPZXlx?=
 =?utf-8?B?YnUwdXBLbXdmTy9MR0F4VGt3VHVsRzB2a3ZOOVVTM0pjOWcwK1pMc2p4UC9y?=
 =?utf-8?B?Q1FIUWNXcjZMMDdWdEJzU0JhTnBSb1YyL2ZPMENhVHJWN3luV2pRUFJLeTE1?=
 =?utf-8?B?SW5tOWJNZHZNaVMwdnRaeXhXaTFlTFc0WjhKYnEvMjFjOXRaWlppUDF4SjZt?=
 =?utf-8?B?TzROb3RscHBhVCtIOGtrQ3BvUmxmckVIQ290Y21BajF2YzVnSFVDNDhNQ05G?=
 =?utf-8?B?MXhDcEQrTmdkWm84RUZBZVVKL1BVeDRVT25HMEIrbjlzSGQ2TUp1SU1YaGVm?=
 =?utf-8?B?dzZDM1FHbnpqYks5NzQyRlJUb01pZ1RaZlVSV1JKZit0UkExVWgxVzMxenY0?=
 =?utf-8?B?MGFJNmNlK2xhTjl1S29FYmt5VWE3Tnl5eEs5R3pBY2dUai81bklkaURpazZy?=
 =?utf-8?B?TkY4bnIxaXU3RTZXd0ROZ0YxK2lSNkg5SGEwM28wZ3J1K3dTZWtlbG9TMmdP?=
 =?utf-8?B?eVEwSngyNzdRcTJPK2NwNEg1Z3pDcUNmcCtmbWJvMmRtVDJWZmN1T1BzMERy?=
 =?utf-8?B?UnNQck5neWMwNkRmWi9JWjVvRUNxSG9CRFZOY2FMdE9POGxSdnRhVXNidER2?=
 =?utf-8?Q?YhlGgx2gOU4aoFC2X/zZQ55dufbZG6NMg7NTQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDAvSXU1c2RYdkpFTHNpWDVLdVAveVI1ekZJL0pHZnJiQWJFd1N0TmhUM0dC?=
 =?utf-8?B?YzRhcXU2b09OSEtBVVlqUFRnbUNMT1N0aVNaNzNNc2NPMnZ1dDlDNE9GMXRr?=
 =?utf-8?B?aVhXTjNxdDBaV3pjWE1TNkw3MUg4TE5OMHBPcWhjZzdHQW4yYWtORjhOR0hG?=
 =?utf-8?B?MDl2VDZwc29Ya2RTZllZVVpReU1BckI4TmdmbG12dXVTbzErUWVmbUgwamRW?=
 =?utf-8?B?a3dNeEczZVdaanQxSXZ3eEJGSHVoVXBMU25tR2tFUjhiZk9rSTgya0NnaU5J?=
 =?utf-8?B?UWlUalN0ZklkaVBjdk1sTHNYUEtqRTVyVVpsa2R2Und6cFpTV3JmTk90UUt2?=
 =?utf-8?B?TzN3Z2VPWitoRXZiYTIwMG1oTHFNKzVZeXc5ZFJOTHRkalJXVE1ucGZ3OXBp?=
 =?utf-8?B?MjF5RjVXM0oyTHJqVFdZQW9pUGtQV0UvYVdZckFuVXRwSnFNbTdpZldab3Br?=
 =?utf-8?B?bEk0eU1IZ3dBZGQ1RlQrSkFpSDliSEM4ejBFMVBUU0ZsalFORUt1RGVXWVpR?=
 =?utf-8?B?cExFblM5UWM0N0ZidVBWZDBmSStQOG5zenhJWERodlBsT3I0ejhWN2RiZnA4?=
 =?utf-8?B?bkNvczlkcW5HR01UdTYxc3BqbExJT2FWNHU5cUgwNWc0ZzVTQUxVSmI4ZE9s?=
 =?utf-8?B?b3JQaDdQSE15OGhvcDVLbExNSWZFMVA3Sk0zbzJNczAzNEVEc0k5VXluRUFm?=
 =?utf-8?B?dDg2dTFxZGtudGFSVmY0bktCcmpMVzUxVXcvNHg2dlRZZU9XSkx2WFgySVo4?=
 =?utf-8?B?SDZJejkvVWZLeGk2clBmYUV1T2NyVWN4L2syN1hVODJDRVI0ZElORm1lc1ll?=
 =?utf-8?B?RFJFZkJZc21hUGtjaXhoTnpkTmtmRlVwcEh6RW8xUG5NQWRFSnVCRzU5WGtN?=
 =?utf-8?B?NHV5ODM1bVdDeVJCTy9zbXE5OXFqbkcvczNrMFdSYm9FcTZqZEk0dGhzdkdD?=
 =?utf-8?B?eUxvYnRKd3BwYnNiUmhXTjI3bnhZRGdybFFZblRDUmVMUVZVVk5weVRxSENI?=
 =?utf-8?B?WmI2U2YrSHgrTDkveHpsVjR0ekZOclVya2pKdExVY2RmNG50bjdtQVBKZHha?=
 =?utf-8?B?akx3SkowRG1pWVB2TjdjeUlEa3lWMWgxMC9ONFVSaER2Zzl6Mnc3VTRjSHhH?=
 =?utf-8?B?aGNMR2RvOTZLamNQN1dxcHBKdzI0RDlEZ3JMWitTN0ZlaDQwWWZaYWhBQllD?=
 =?utf-8?B?bGlBaE5FTFZBZm5TMXVkOVJEd3VWeTUwdUtOZHk1TXA5dVRBOTBObm9GNS92?=
 =?utf-8?B?OFVlckpkK3ZiQVdnWDQwYXJYcDFZTHFMcnBpOGVFYzJIc2VTZkNuNlR5d3ZU?=
 =?utf-8?B?TERxZU4yODYySEd5M3M5T1N4a25Eb0Rmd1NCR0pUQzFrL2JSRzNwRkgvSUlJ?=
 =?utf-8?B?RWtXZHh3MVYwNmIzQkg3d0tJWEwwZEI0YW9kMjJUbHpFVVpvZ2J5SXJuQjZ1?=
 =?utf-8?B?TXh3SG5kSFBrZzVVU2xvZzlKL1FrTGJaRnNoUWxSMnQ2b1ZIR2kwS2N4UVhN?=
 =?utf-8?B?RmNLQWtJd0FSWU9leGRpRVVtVlNoWU43QlJFYWo4VGQ0T0RlR3ExWWkyNTYx?=
 =?utf-8?B?RzVoTWtQTTc1RDN1R0xwOXR0WjBLbldKOTJFdG9UamNqUFlqbmw4cnk1ZEUx?=
 =?utf-8?B?S3p5Mm1JSWVtSkJOTWpuS2lJZzJKZ2h6U1BkQm9QU0tlaHpiTWVqV2xaSGxP?=
 =?utf-8?B?WjB1aWozdXlERk9GY3RRQWdveEtiK0kyVDJNa2wxRzYxWEUwWW9Mc2NwQzhj?=
 =?utf-8?B?RjZCeFgvZ2UwcFNhUW1SWGNFQk94ODVmQ2V0Wmt3NWVrK3NmVkQzT1htc3Mx?=
 =?utf-8?B?RmVNNHI2OGdSRERMYllIWDFUVloxc0VGejNvaWlsVmhnNnBRSDcyYnBkdjhD?=
 =?utf-8?B?N29sVldLS0NLanlzS2FFbklKOEtoWHlabUZHdWZCR2J2U3lNQWgrTjJRTEwv?=
 =?utf-8?B?dUNiZWlNVWx4SjJrSDJUSWdSRGRHOUVUTHV0THRsb1g0OGhpMzV4UFhFOURE?=
 =?utf-8?B?SDUwVU0xS1B4MUkySDJMcjg3M1lsaUtEeElJT0txRHVhbnEwOTdmdTQ2RDRI?=
 =?utf-8?B?WjB0S09WZTBCVHRQU29Cdm1rQmpQL0poYkZwWUNLa2d0bUxjenpWV3BxOWJH?=
 =?utf-8?Q?sf/4BbTO5kpKcmbJRVYVRNbnQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4F672A03753674EAB9A4A1DA3BE3E00@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q39ftb4Tz8D1Yoqim16YGtZAXFivbC62EHlLb6MltVEd8e7LiWBwzVnBxK2HPZ7Dwt32h84ZXjPsyh+S1U1zyYueYw5m7DzAWHAxXLrOpx5/U4qZS/hAA8DrmHLXE8FdzJvgjiWQhCSKZWNqWqJQEtmNr5irZZ/+D/zfXUloJ+pqK5gB66OL7FyF+bYZZGH9t54kAswjF75qvvrqEccPQw9kXYwd3zXdiLG3nw99n9JIiXxTETIf+NuGp7sLEeDz9k0UnPD9fIEbwm5+nQhqzQ09CS6Aaz7AedCT3B5B/H5lwySLqfhNpHtwhLTz1PZ4ZNpQBW+vpPoYNuBoHhcyKG7JLNU8hW6N2+q92MlKOVrWw90qxmNOcg1x2adbzVM6LglE+Rwh8wAqGZHP0z7zxCE62GSSLkLVO9RHdHylibV6RD9z+vatdoe8u2+TygIMHSt7g3CMAkDzDpMaCuij7FQF8biXtUWltWJ18m4LwZH7Uv31hNccn2Kd6XKXApmGxNXjXkk87KsAj/pKwsG2ZC5CCaKgvR+qQ/nUZsKB6oDC+ha3tg3EMgHaZ6I7tndx/boiLt0y1lMIYb/CTh2wjsvmlR/KWUXgrp10O95KKOlYEsRBJbN2Xuv/VlHtBh1pM14gocxF859khQYOt8suiQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d64fb63-4f96-4dc8-671e-08dd005aaade
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2024 01:05:57.0103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: db0oV+c7L4cKJfUDTNBwKiPYlFCYw1aODP7b8o+K+qFjvU6/GPii9YAwotrzPqqMtx+4dddeFjK0D64+e+km7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
X-Proofpoint-GUID: UJwScy80a7ApszoaQk1ksdKR0z7g8DFT
X-Authority-Analysis: v=2.4 cv=e9lUSrp/ c=1 sm=1 tr=0 ts=672eb584 cx=c_pps a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VlfZXiiP6vEA:10 a=nEwiWwFL_bsA:10 a=qPHU084jO2kA:10 a=Eo1u7mT9do79otc5dFAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UJwScy80a7ApszoaQk1ksdKR0z7g8DFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411090007

KysgQWxhbiBTdGVybg0KDQpPbiBGcmksIE5vdiAwOCwgMjAyNCwgU2VsdmFyYXN1IEdhbmVzYW4g
d3JvdGU6DQoNCj4gPj4gKwlyYW1fZGVwdGggPSBzcHJhbV90eXBlID8gRFdDM19SQU0wX0RFUFRI
KGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXM2KSA6DQo+ID4+ICsJCQlEV0MzX1JBTTFfREVQVEgoZHdj
LT5od3BhcmFtcy5od3BhcmFtczcpOw0KPiA+IERvbid0IHVzZSBzcHJhbV90eXBlIGFzIGEgYm9v
bGVhbi4gUGVyaGFwcyBkZWZpbmUgYSBtYWNybyBmb3IgdHlwZSB2YWx1ZQ0KPiA+IDEgYW5kIDAg
KGZvciBzaW5nbGUgdnMgMi1wb3J0KQ0KPiBBcmUgeW91IGV4cGVjdGluZyBzb21ldGhpbmcgbGlr
ZSBiZWxvdz8NCj4gDQo+ICNkZWZpbmUgRFdDM19TSU5HTEVfUE9SVF9SQU0gwqDCoMKgIDENCj4g
I2RlZmluZSBEV0MzX1RXMF9QT1JUX1JBTSDCoMKgwqDCoMKgwqAgMA0KDQpZZXMuIEkgdGhpbmsg
aXQncyBtb3JlIHJlYWRhYmxlIGlmIHdlIG5hbWUgdGhlIHZhcmlhYmxlIHRvICJyYW1fdHlwZSIN
CmFuZCB1c2UgdGhlIG1hY3JvcyBhYm92ZSBhcyBJIHN1Z2dlc3RlZC4NCg0KSWYgeW91IHN0aWxs
IHBsYW4gdG8gdXNlIGl0IGFzIGJvb2xlYW4sIHBsZWFzZSByZW5hbWUgdGhlIHZhcmlhYmxlDQpz
cHJhbV90eXBlIHRvIGlzX3NpbmdsZV9wb3J0X3JhbSAobm8gb25lIGtub3dzIHdoYXQgInNwcmFt
X3R5cGUiIG1lYW4NCndpdGhvdXQgdGhlIHByb2dyYW1taW5nIGd1aWRlIG9yIHNvbWUgZG9jdW1l
bnRpb24pLg0KDQo+DQoNCjwgc25pcCA+DQoNCj4gPj4NCj4gPiBXZSBtYXkgbmVlZCB0byB0aGlu
ayBhIGxpdHRsZSBtb3JlIG9uIGhvdyB0byBidWRnZXRpbmcgdGhlIHJlc291cmNlDQo+ID4gcHJv
cGVybHkgdG8gYWNjb21vZGF0ZSBmb3IgZGlmZmVyZW50IHJlcXVpcmVtZW50cy4gSWYgdGhlcmUn
cyBubyBzaW5nbGUNCj4gPiBmb3JtdWxhIHRvIHNhdGlzZnkgZm9yIGFsbCBwbGF0Zm9ybSwgcGVy
aGFwcyB3ZSBtYXkgbmVlZCB0byBpbnRyb2R1Y2UNCj4gPiBwYXJhbWV0ZXJzIHRoYXQgdXNlcnMg
Y2FuIHNldCBiYXNlIG9uIHRoZSBuZWVkcyBvZiB0aGVpciBhcHBsaWNhdGlvbi4NCg0KPiBBZ3Jl
ZS4gTmVlZCB0byBpbnRyb2R1Y2Ugc29tZSBwYXJhbWV0ZXJzIHRvIGNvbnRyb2wgdGhlIHJlcXVp
cmVkIGZpZm9zIA0KPiBieSB1c2VyIHRoYXQgYmFzZWQgdGhlaXIgdXNlY2FzZS4NCj4gSGVyZSdz
IGEgcmVwaHJhc2VkIHZlcnNpb24gb2YgeW91ciBwcm9wb3NhbDoNCj4gDQo+IFRvIGFkZHJlc3Mg
dGhlIGlzc3VlIG9mIGRldGVybWluaW5nIHRoZSByZXF1aXJlZCBudW1iZXIgb2YgRklGT3MgZm9y
IA0KPiBkaWZmZXJlbnQgdHlwZXMgb2YgdHJhbnNmZXJzLCB3ZSBwcm9wb3NlIGludHJvZHVjaW5n
IGR5bmFtaWMgRklGTyANCj4gY2FsY3VsYXRpb24gZm9yIGFsbCB0eXBlIG9mIEVQIHRyYW5zZmVy
cyBiYXNlZCBvbiB0aGUgbWF4aW11bSBwYWNrZXQgDQo+IHNpemUsIGFuZCByZW1vdmUgaGFyZCBj
b2RlIHZhbHVlIGZvciByZXF1aXJlZCBmaWZvcyBpbiBkcml2ZXIswqAgDQoNClRoZSBjdXJyZW50
IGZpZm8gY2FsY3VsYXRpb24gYWxyZWFkeSB0YWtlcyBvbiB0aGUgbWF4IHBhY2tldCBzaXplIGlu
dG8NCmFjY291bnQuDQoNCkZvciBTdXBlclNwZWVkIGFuZCBhYm92ZSwgd2UgY2FuIGd1ZXNzIGhv
dyBtdWNoIGZpZm8gaXMgbmVlZGVkIGJhc2Ugb24NCnRoZSBtYXhidXJzdCBhbmQgbXVsdCBzZXR0
aW5ncy4gSG93ZXZlciwgZm9yIGJ1bGsgZW5kcG9pbnQgaW4gaGlnaHNwZWVkLA0KaXQgbmVlZHMg
YSBiaXQgbW9yZSBjaGVja2luZy4NCg0KPiBBZGRpdGlvbmFsbHksIHdlIHN1Z2dlc3QgaW50cm9k
dWNpbmcgRFQgcHJvcGVydGllcyh0eC1maWZvLW1heC1udW0taXNvLCANCj4gdHgtZmlmby1tYXgt
YnVsayBhbmQgdHgtZmlmby1tYXgtaW50cikgZm9yIGFsbCB0eXBlcyBvZiB0cmFuc2ZlcnMgDQoN
ClRoaXMgY29uc3RyYWludCBzaG91bGQgYmUgZGVjaWRlZCBmcm9tIHRoZSBmdW5jdGlvbiBkcml2
ZXIuIFdlIHNob3VsZA0KdHJ5IHRvIGtlZXAgdGhpcyBtb3JlIGdlbmVyaWMgc2luY2UgeW91ciBn
YWRnZXQgbWF5IGJlIHVzZWQgYXMgbWFzcw0Kc3RvcmFnZSBkZXZpY2UgaW5zdGVhZCBvZiBVVkMg
d2hlcmUgYnVsayBwZXJmb3JtYW5jZSBpcyBuZWVkZWQgbW9yZS4NCg0KPiAoZXhjZXB0IGNvbnRy
b2wgRVApIHRvIGFsbG93IHVzZXJzIHRvIGNvbnRyb2wgdGhlIHJlcXVpcmVkIEZJRk9zIGluc3Rl
YWQgDQo+IG9mIHJlbHlpbmcgc29sZWx5IG9uIHRoZSB0eC1maWZvLW1heC1udW0uIFRoaXMgYXBw
cm9hY2ggd2lsbCBwcm92aWRlIA0KPiBtb3JlIGZsZXhpYmlsaXR5IGFuZCBjdXN0b21pemF0aW9u
IG9wdGlvbnMgZm9yIHVzZXJzIGJhc2VkIG9uIHRoZWlyIA0KPiBzcGVjaWZpYyB1c2UgY2FzZXMu
DQo+IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGNvbW1lbnRzIG9uIHRo
ZSBhYm92ZSBhcHByb2FjaC4NCj4gDQoNCkhvdyBhYm91dCB0aGlzOiBJbXBsZW1lbnQgZ2FkZ2V0
LT5vcHMtPm1hdGNoX2VwKCkgZm9yIGR3YzMgYW5kIHVwZGF0ZQ0KdGhlIG5vdGUgaW4gdXNiX2Vw
X2F1dG9jb25maWcoKSBBUEkuDQoNCklmIHRoZSBmdW5jdGlvbiBkcml2ZXIgbG9va3MgZm9yIGFu
IGVuZHBvaW50IGJ5IHBhc3NpbmcgaW4gdGhlDQpkZXNjcmlwdG9yIHdpdGggd01heFBhY2tldFNp
emUgc2V0IHRvIDAsIG1hcmsgdGhlIGVuZHBvaW50IHRvIHVzZWQgZm9yDQpwZXJmb3JtYW5jZS4g
VGhpcyBpcyBjbG9zZWx5IHJlbGF0ZWQgdG8gdGhlIHVzYl9lcF9hdXRvY29uZmlnKCkgYmVoYXZp
b3INCndoZXJlIGl0IHJldHVybnMgdGhlIGVuZHBvaW50J3MgbWF4cGFja2V0X2xpbWl0IGlmIHdN
YXhQYWNrZXRTaXplIGlzIG5vdA0KcHJvdmlkZWQuIFdlIGp1c3QgbmVlZCB0byBleHBhbmQgdGhp
cyBiZWhhdmlvciB0byBsb29rIGZvciBwZXJmb3JtYW5jZQ0KZW5kcG9pbnQuDQoNCklmIHRoZSBm
dW5jdGlvbiBkcml2ZXIgcHJvdmlkZXMgdGhlIHdNYXhQYWNrZXRTaXplIGR1cmluZw0KdXNiX2Vw
X2F1dG9jb25maWcoKSwgdGhlbiB1c2UgdGhlIG1pbmltdW0gcmVxdWlyZWQgZmlmby4NCg0KV2hh
dCBkbyB5b3UgdGhpbms/IFdpbGwgdGhpcyB3b3JrIGZvciB5b3U/DQoNCkJSLA0KVGhpbmg=

