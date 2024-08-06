Return-Path: <stable+bounces-65511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D561949C7A
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 01:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629E0B20CED
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 23:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82356171E64;
	Tue,  6 Aug 2024 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hJaWo3oP";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bDuDriIS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZgOWC80b"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50098A59;
	Tue,  6 Aug 2024 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722988318; cv=fail; b=RLZRkaz0GEr7g5MF8ntepBsApk/FoOTZMEGS+Pl53UshHTF/D3gdZusOiYcb2jUbdFN5DMwxvyzLNyy9mTzAFiZ2lmVtAbyOVZfn3+KUwcnq7WLADdIxzi8r/YIa4lh+EMfHDEEzqzL3Y00cVRJaMuCESXwVqtCjuwEK++ji2gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722988318; c=relaxed/simple;
	bh=5lGDk4CdHMRODwIjPgabvs3r/i3t488L8c/0d7w1bto=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tge+ItMtmA/s+8UQFkT5PKfYH4XcOkNiPiEWVVklERCdUllmMkZg9uGgjRuFHQrJVpWF0BcLhraCMA64xogs16u52ZflecXrE3ZoMKypTUe5dOatXBi05o5IglSfce5i/HQrmzTRFYtMLgzmM3sAbnYZ/ntm2+DV14yXAtISgw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=hJaWo3oP; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=bDuDriIS; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZgOWC80b reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 476MJhtQ025821;
	Tue, 6 Aug 2024 16:51:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=5lGDk4CdHMRODwIjPgabvs3r/i3t488L8c/0d7w1bto=; b=
	hJaWo3oPU+7Dsi3Ra1bq45ydgK6dvYlp912lX7yhsALtMSo1QYWSNumvsWMUpJcl
	Y6yCE3H5Ifc9fESw0hjN8xXqhXLjJtmQvhK5nTZ6d6Tlj+bt8AjH6YAOzhasPDxq
	+xQcDXAdLQ2QwOQIficJC3EZ75dUmwTP9vBnL1IwTT0X5EIcAHtvNGLvskdsqa6Y
	0QhLcMtyv7ulaGChdhFbY7+3pUNu62h6ZDh+m/UC4qlToAVV7QbQ+8lq9znVqvDJ
	nCO+in2B8AbzZtKGnufD8ce6HqJbwX0Z/zMuxPyWo/x+W3Ophvih2IYuinrPX75+
	BUDjdodESWSj8GCtyYua1A==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 40uujb8f5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 16:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1722988312; bh=5lGDk4CdHMRODwIjPgabvs3r/i3t488L8c/0d7w1bto=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=bDuDriISzZKB7t5CSkcf7iwVjCXGHICtGsg8nCtYbQgbj+flPIveIaGTPi36rJnZv
	 lFs7Vwg4KPPMRoc2AX6aizBNViPHTC9iz9CEc3+J/+Asosv1q5NKSlP/doX0fB1UtS
	 2GQ3/VzpnqCuz2t0Bsu7xYQta59TMhQEnH7u7dKMiE6UzXrMqbxJCIGyhfvSJcCqUC
	 stIgOPkI9k9QcUofhmSm5hxd+Jc7sy1A9fZC6pbP5m83bAUbjlOngrCRjQL5PUfIcG
	 /Q71cTxDqmA74InU+A9koC4NRNgTFauQShSS+Nwg4dumeqrZh95MUajvZClpNKyw4d
	 3LTprhHSYAZRw==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7CD7B40147;
	Tue,  6 Aug 2024 23:51:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 3D633A007B;
	Tue,  6 Aug 2024 23:51:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ZgOWC80b;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 828964028D;
	Tue,  6 Aug 2024 23:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh4gnD5MWfzPHP9aaiEWG8ClGy6fUJhgSz7aJD4dtjFwHyvzlcWzQMebOOY4/Iiyma/mXCAujrHSnPfr/febGJxoZgqUETyAXvMR/nMY13RFfmn25ptyrjQydsFiRuHEjaXo3jhWK/NXuVuFlhIKouApOvyZPVhz0FLXw4M0lrfjMwWf+/wZokDBdE1E90FkVCS4EQX7JWKS0hoRMP1jlbt6N6r5cHOy6VYQzVzeR3CR56ZNDcp8kwiRJDsU0VeK4W+dCHbm377k8iHBomgDRXXhC6z0OXwpKletan+oU0GfTfGt92RZ/KP1Lo24XERF1FUKSkzRJoaUN+C2cXRmYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lGDk4CdHMRODwIjPgabvs3r/i3t488L8c/0d7w1bto=;
 b=R36hbtPCsUGCdWrkoYsHR3B6K9BhHyF4zgSihUkP9ICfgSSqdtCZL37DiSDkEaY4RER7nLZLTXMZbQ3b/hc2TOLgGvb8FlYS7MEBJy/JYX7tpowdK2O98aHnvlV5KWMo/oOLVaZteOgchmjU1NwnrxdAHD99RYq5/x3bZSvhMMFyK5TSy3O4r4uTL/Bk9ZZKl7V3uXEWrsyinwqNUbXskaSWp7+ITDpikQa3VNEMzQ1pnPFXcODsIPP6pooKxcbMxzJlissIFh9gLRs69h6GyrgKezWCFRn1v2JhJ2JXdVaFJJJk96dDz54Z20nORjpCUxziFIe9IHd0eGAvTNINxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lGDk4CdHMRODwIjPgabvs3r/i3t488L8c/0d7w1bto=;
 b=ZgOWC80b4LwV6AcSETRzGu2cpyLLGkWm9MjSdfK4/KgjNMVwNuS+6SVy3exMDPQD37N4TEmD7Ifl8bEGxONFsqu7Ii5no0Mcr2hN1dA/YRvC1FCEfN/daiOE8XUQpzVhSS/ks2CyBCXYIamsp4LboUrB+hTkh/zT60gU56WcQUI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.12; Tue, 6 Aug
 2024 23:51:48 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 23:51:47 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Prashanth K <quic_prashk@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: Fix latency of DSTS while receiving wakeup
 event
Thread-Topic: [PATCH] usb: dwc3: Fix latency of DSTS while receiving wakeup
 event
Thread-Index: AQHa4n64myRqI4MS10KyZQtJfHhLF7Ia8i4A
Date: Tue, 6 Aug 2024 23:51:47 +0000
Message-ID: <20240806235142.cem5f635wmds4bt4@synopsys.com>
References: <20240730124742.561408-1-quic_prashk@quicinc.com>
In-Reply-To: <20240730124742.561408-1-quic_prashk@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH2PR12MB4133:EE_
x-ms-office365-filtering-correlation-id: 1bdc60c8-1443-4235-69d3-08dcb672bc0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1k0OTNOMWt0MmllNFg3RXZsOFgvVGl3OGVlRlg2L0tJcHNxeHFvY0prYnFE?=
 =?utf-8?B?SDVQSS9zVkYzVkgxeXdkVnpQNlVFQ09URTZMUjgxUkVSeFZpS2ZhUmZjcDEv?=
 =?utf-8?B?bjVmS2xpVHUrSXB1cExFTEhYV0ZWTjBQSUh3dnMvcmFtY3o1cnNYYjIvN0FN?=
 =?utf-8?B?UVZ2YU9SblkxVWZzcVd0eUVSRHB3V1FNQ1dlaFFXdkxSQVBlSkN3REEvWFU3?=
 =?utf-8?B?QUZ0SnlpaDMxdkdzS0c4bzdEbW1XMzE1ajJ2b3RXSHhFamJ5WFU4b2IwcnRh?=
 =?utf-8?B?ampKN0Z1NzV6U2VSYUZDeVZjYnY4RzNRalVpOVJqR2QxSXpkWDY5WWs4WjNo?=
 =?utf-8?B?Y0xVellaN3Rqb0JIeHowYis5L3ZRTG1YcEZDQnJtUFcwdmM3UHZuaXJiT2dj?=
 =?utf-8?B?Uy9RM2FBNnFGdVp6SjVKNThpcHdZQmwxRzUxei9qT0crMy9HbUJJUGhNejhI?=
 =?utf-8?B?cjhEd0hvbzRBTUZyMGc3dUt0Y25EZ3Q3bTZtWFZqWGhzTDdFL2xvUnhIMUVJ?=
 =?utf-8?B?bTV3eGMwM0hMSDlvQXB2aTZUcm15TnNWeEtTMzJRbmtwMzM2bi9SMGltYlFF?=
 =?utf-8?B?dVF2YmFZTldJSnd0UUExS0lLZmltS1JTczNuRjN2cHpmdXlINitmUmpXWE9K?=
 =?utf-8?B?VTc5d3JRQ0srbEk1SjNOWDJORUplN2I2Zy9TN3RacWkzNmVDdmJHdTVmanh5?=
 =?utf-8?B?aHdIT2ZVTTJIOWM4RFFaUG1CVDBWQklaenlXZjZLV2RCK1J2MXdIMXArZWFM?=
 =?utf-8?B?RDNtbXRtVWxxVm5zL09JMUtXOG1vcGJtWW81bTByY20zZTNjQ2NsQkhpSTJo?=
 =?utf-8?B?ZjRhcS9OaGNVRWpnRVNSOS9jVDFhWkl2K3VxQ2w2V2xTSTNJQk1JckZ6TTFQ?=
 =?utf-8?B?cnBWTXJMWHczRWVpUGM3VVlEZmJPaW05dm1qalJSSXVaY2VwNlBzMk1oZVJM?=
 =?utf-8?B?cnkyT2dmVzN5SXJuUzZqcmxMYjNENTBNOXZ4VktjbjNJQmI5K3hFZDNOclRu?=
 =?utf-8?B?U1BSUHlWWkNQRkJtSTBHeEZVaEJDNTdmRjZ4TTFkNU10Y01vMWZrM1hMNXZG?=
 =?utf-8?B?RHFJTWxkUEZBRE0wbERZY2hJcThrTVVJRXhTcVEwaHNVakVMUk9GMmJIdFNW?=
 =?utf-8?B?RVFSd3lYRHZ3Sm9IbUdlS2dCdFRPY2UyNTJyMDRmaXZBOTRscmt2NHZoR0JB?=
 =?utf-8?B?K0w5ekNQUCttRWx0RUZhZDhVS0c1d01PWDQ3ZmJaOFVBdGpCd2pwNjhhK3Js?=
 =?utf-8?B?UUtzMmRKKzU5bWxUbTRPZ2JMRDFjNTJYYlVQa3NmbXNWL01qSk5YcVNEVVpF?=
 =?utf-8?B?ZGtsd0p0dEgrbGM1bDFTNDZJdjk3NVBWWGY1MUlaR3YxQVlZMXhBMVhVT2lM?=
 =?utf-8?B?aXErQ2ZTQTNpelZXR09WVkY4dEI0OHdmdE9BNGFTdUdlOWo2Smp2V2hpNFha?=
 =?utf-8?B?MkpmNktQYy9tSzllZWVMbWtCcktPVVBlOUVNdkQ4K0pPbW9qdW41aHIxZVFm?=
 =?utf-8?B?b0xWTGQvT2tlbHBXQmE4NVRGaGRHYWxCZWFGcXdmMEVDMHVVN2c4Zkt2SHo2?=
 =?utf-8?B?TDRuN1pDaTlOV09jdlh5SXgvTVpnNWtocjRzMWVqMWxrVVh2RXFMNitlZmZo?=
 =?utf-8?B?TDVFMmZKQWthR0xOZ0J5VE5QWmRnU2F5QkVXbWQrK1JUaG9SSENuYWp1d0Ra?=
 =?utf-8?B?M2xBam4wWmlXQkNVRitsdG9aeHJkL1ZZVnVRTjEvNUs3U28rUDQ4c09xNkQv?=
 =?utf-8?B?d3RCZlFVdGRSc283dm4rTFFxUnBiOHRmaWo3ZjhsQ3hqNFMwczBFeDVBUGhF?=
 =?utf-8?B?Y25za2x1eFJkOW54T2RwLzJRYm1QM0djTUJIRkxzQ0trZFU1VWdtS3dNYW5S?=
 =?utf-8?B?RkFiMmgraEc4YW9kMi9UdGlnSTFPUDNLZVd5ckFXN0FnRWc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2hmOUQ3MTN0RUtmZzdyM0xCc1NGeUIzYmJpTHp2MEZ5T284K2o0L2x6Slgw?=
 =?utf-8?B?b3l6UnhqTVpvVzJ4cWhzNHp6cjh2MWhpd3gzZktSdnFUYmUxWjVCdGc3Tzhn?=
 =?utf-8?B?d2xmNEpWUkpXaHZUTVpDYzBkMDBlVXpPbTJtSFVSTTY5VG5YdE15MXV5QTdw?=
 =?utf-8?B?cWVoTzlBaUNqYU5NV2NUV2tpNzl3dlRldHBYd09CdnlieDVTbEcrWjZYcFV1?=
 =?utf-8?B?Ly9oM2RKZStQaFpnSEN5SUt4WWRRSUdvS2xxWnNKRDR1cGFSdHdHRzJpWWlW?=
 =?utf-8?B?SWcxK0MwVHdRcStVdWxUNWRwa2t2Y3lleXJNTFdUZkNEVE9yR2dlVkUybFVU?=
 =?utf-8?B?NlpRZE1VZC90UlNXWDAvU2kzSzFuMDUzdWEwUXQ2RW9hTHY5blZOV2FOMnk3?=
 =?utf-8?B?VVRaa2lENTZ0elZCazg3ZzZ0UitnN2ZrK2ZTUWFHeURFbFA4cnZGd0l3KzVN?=
 =?utf-8?B?dkNMd1NtUmp4SEdKdDNpQ3Rsd0lvVk9kUmV0aXVmU040aWNKQmcxL2Q4Unhs?=
 =?utf-8?B?TlVNYlMvMEh2bkkvNVFQb1BIM2VuSWFLYkV4SkFmQyt6dU85ZnJicDJLWTZK?=
 =?utf-8?B?dnZzT3FmNmFqa3hMWkxTdkJmcDBKYmh5ZHBOUFJyMTZINVNpZnlZa3JiQW1D?=
 =?utf-8?B?bUYwMG53c2lMUFFsSHJiYjVtK0ptQ3dGZUViWmFvNVVWbEVQSmtNYTdzcm8y?=
 =?utf-8?B?TklYU3ZTb0xBTkczMHlBQXU2Z2xiM1c1U1REV1RKMmxLY1FtWW9ObzYxVjND?=
 =?utf-8?B?eHBuRWxTOXhialNFNW9FNDBWc0tDQzdPNjRDL2VlSEkveU92WkhDSjBPb0Fo?=
 =?utf-8?B?T0VtaTBwbTJSQmRSbEYydnFKeHB5RUJKVU8zMzRwYkdTTDJmMGdmWGFFakpi?=
 =?utf-8?B?ejNPRmQxRkorQkdReGF4K3cwZ1J5UGxhb0RleEdlc0RMZzI1SGhVUmtLeHdK?=
 =?utf-8?B?L1d1aTlXZ3hlaVE3a2ovOE9PRlU5MHN3bThYc1RPU3V6cEljQ3NkM1dTRjVp?=
 =?utf-8?B?THhFQlo5YnBNajJKTU5aN3c4RUNXNzVrT0o2TEdmQXM3MjhSbGVuczlUeWJP?=
 =?utf-8?B?ME40UjdtRDlDRXdYczVDQWdUc0FFYnNMdFBCTTZwMVhjVllQTHJmb3ZaNHdh?=
 =?utf-8?B?Mk5hUlBQTEZ5NEZXQXdnMGNSd2lUV1AvZHhSUGNZTlBsY05taE1nSnVKMVg5?=
 =?utf-8?B?YTMzVS9ZOUhiOWRQNDNxMzhydyswV1R6S3B4SWdjK0poRzRCREUyRjMxb0hF?=
 =?utf-8?B?Q1V5Z1ZOSm1IWEFGNGgzeFpiUHVleUVWZ0V6dkRyQ3JOam15QlBud0dpQnhN?=
 =?utf-8?B?dlhkWlJQTGYwMzlJRkVweEU1Y0drMVBtR3JydWoyeFgrTFBBcnBuMlhmR3ZG?=
 =?utf-8?B?TytSenUwK1ROTUY3eEM2YTNXdHdvRkYrS0lGd3lhRWZYRmIxWENEZ2FmdlJy?=
 =?utf-8?B?SVU0bnRBdTZJclIvdmlLbkZ6UElzV2RwYmNRQ2g0MUdyS0dKRkxWT3lVU3Qy?=
 =?utf-8?B?TDFDdENjTG1rdXhEdzJ5eEhHTG0vUEhaMCticEM5NFRnK0hCOUczeXNraVJB?=
 =?utf-8?B?cis4Zk5MZFFGeEx3cnZyeWxsVGkyai9ES2JpSWlDUk9qM3NvRnR4UjBmQmZO?=
 =?utf-8?B?ZHMyREJtbmdnUVIzL1o1eG5QMVUvaFBHcUVic0lJdnBrbjhmMTZCR00yM3hh?=
 =?utf-8?B?L2hMMytyU2l6eDd4YjJSUTJBYnRxdzA5czF4SHREZXd0ZUpSQVpWS0kxelNo?=
 =?utf-8?B?OEk0azgxYlkxdW84bFRxL1AvN0RxVmd4aTNqWC9rN0g5d001bVVBZWxGRlZH?=
 =?utf-8?B?ek5QbkZRVlFOYm52S3Fsa0pPWS9mcHZxQVhjZkdtMS92NW52alNLNkRtVTV4?=
 =?utf-8?B?V2ZPdG1Qd2JKZDBGRW5hMUlpS1IrczN0czhnWnk4Vk43UisrWjRJdGx0ZzhM?=
 =?utf-8?B?NmFwVHdVbkE2T1NOZGJKMENPV1Brd0ZGT2N3eURKN2x2NXF3WjNWbDNxUnFP?=
 =?utf-8?B?OGJOanFRSDVvRTF6bXlPRlNKR20xU08vSTcrcC9CMnBQQzE1aWVyV1o0amNa?=
 =?utf-8?B?dFpDWml6NkZnaWJzeFhBMmR4c1NnbFpRdFNrUC80alVLYWpRVnZDZ1pBRFVt?=
 =?utf-8?Q?MQB30k4HLj7IVty4JYmUaq9CB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <122F414E0A4F6F4E9F18730C1A1EA96B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4y1rYHOGDd/nS3A636aH7+JJ+tOxHUm4U/WBI4rP45fl5cVJNFKf6Z8xJfMUnTYMZS3PLSjB1DLRRZBptt/pf0nlflpGjajvGNVq1CI+yl54/T2cN5opAZ+r5qL0JrZc/PxJGxgHbL+cULShhcfWsUHFk8BktkNHpEW/5IXaOCkdrfxiKV+zCxrknWIUUCtc000kzY23zxIrdj7tH6wpBi3aNI5/FJApdUf6uF7vD5/vZqJnJ9zSsAhN0mmnp9T7Q6VsOL3pEv8k1LPyVnQU3yNYMmFTlEN33JoOL4bj99ILIxXPy3IJGOzN0MHhVSjEJTmpbI75Jx8IzwYD0n8AjHd8JPaQfU/Dxq+NuTeBAMJm/ceyTZ6de9EFRxOiLdXE3lPZFV46VDsOhSxYqre/WpV0PMUYIXY3V1mfGnvHA4Hs+p8mrbFgEf+Q69dGEJ21fYzg6q8Fm839g7LPY9r9hhK9xHXrqRSS5RcqFrFScljotM2bwgaY34TIACH9d5fqCZjS/0LWhp5zQAuLhV7q5kukJ2OI7NQwynpzd9jZ2FCJN4EDwpQVlfE0lGGBT2hyWbhjy+2HwqOZI2BfJ2Aq3ynv6MQBKIHr0dPDC+LHOS2PeycP1UTGNs1awJKx4ecv9cHuNqGoGB2JdOnnaSW/iA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdc60c8-1443-4235-69d3-08dcb672bc0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 23:51:47.6738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mYsdDv2Pud5xit4cU6ZNiC3PuG5URPm/n6yZf1NRe2eA+R9bE/JMGD2qFRZzNUqrvBmp2Qlqa2y/VAcVcUNmTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
X-Proofpoint-GUID: uB2Wxojp4loIDH9xFNxsuPckOTQ5Rhx1
X-Proofpoint-ORIG-GUID: uB2Wxojp4loIDH9xFNxsuPckOTQ5Rhx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_18,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=718 clxscore=1011 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408060168

SGksDQoNCk9uIFR1ZSwgSnVsIDMwLCAyMDI0LCBQcmFzaGFudGggSyB3cm90ZToNCj4gV2hlbiBv
cGVyYXRpbmcgaW4gSGlnaC1TcGVlZCwgaXQgaXMgb2JzZXJ2ZWQgdGhhdCBEU1RTW1VTQkxOS1NU
XSBkb2Vzbid0DQo+IHVwZGF0ZSBsaW5rIHN0YXRlIGltbWVkaWF0ZWx5IGFmdGVyIHJlY2Vpdmlu
ZyB0aGUgd2FrZXVwIGludGVycnVwdC4gU2luY2UNCj4gd2FrZXVwIGV2ZW50IGhhbmRsZXIgY2Fs
bHMgdGhlIHJlc3VtZSBjYWxsYmFja3MsIHRoZXJlIGlzIGEgY2hhbmNlIHRoYXQNCj4gZnVuY3Rp
b24gZHJpdmVycyBjYW4gcGVyZm9ybSBhbiBlcCBxdWV1ZS4gV2hpY2ggaW4gdHVybiB0cmllcyB0
byBwZXJmb3JtDQo+IHJlbW90ZSB3YWtldXAgZnJvbSBzZW5kX2dhZGdldF9lcF9jbWQoKSwgdGhp
cyBoYXBwZW5zIGJlY2F1c2UgRFNUU1tbMjE6MThdDQo+IHdhc24ndCB1cGRhdGVkIHRvIFUwIHll
dC4gSXQgaXMgb2JzZXJ2ZWQgdGhhdCB0aGUgbGF0ZW5jeSBvZiBEU1RTIGNhbiBiZQ0KPiBpbiBv
cmRlciBvZiBtaWxsaS1zZWNvbmRzLiBIZW5jZSB1cGRhdGUgdGhlIGR3Yy0+bGlua19zdGF0ZSBm
cm9tIGV2dGluZm8sDQo+IGFuZCB1c2UgdGhpcyB2YXJpYWJsZSB0byBwcmV2ZW50IGNhbGxpbmcg
cmVtb3RlIHdha3VwIHVubmVjZXNzYXJpbHkuDQo+IA0KPiBGaXhlczogZWNiYTliYzk5NDZiICgi
dXNiOiBkd2MzOiBnYWRnZXQ6IENoZWNrIGZvciBMMS9MMi9VMyBmb3IgU3RhcnQgVHJhbnNmZXIi
KQ0KDQpUaGlzIGNvbW1pdCBJRCBpcyBjb3JydXB0ZWQuIFBsZWFzZSBjaGVjay4NCg0KV2hpbGUg
b3BlcmF0aW5nIGluIHVzYjIgc3BlZWQsIGlmIHRoZSBkZXZpY2UgaXMgaW4gbG93IHBvd2VyIGxp
bmsgc3RhdGUNCihMMS9MMiksIENNREFDVCBtYXkgbm90IGNvbXBsZXRlIGFuZCB0aW1lIG91dC4g
VGhlIHByb2dyYW1taW5nIGd1aWRlDQpzdWdnZXN0ZWQgdG8gaW5pdGlhdGUgcmVtb3RlIHdha2V1
cCB0byBicmluZyB0aGUgZGV2aWNlIHRvIE9OIHN0YXRlLA0KYWxsb3dpbmcgdGhlIGNvbW1hbmQg
dG8gZ28gdGhyb3VnaC4gSG93ZXZlciwgY2xlYXJpbmcgdGhlDQpHVVNCMlBIWUNGRy5zdXNwZW5k
dXNiMiB0dXJucyBvbiB0aGUgc2lnbmFsIHJlcXVpcmVkIHRvIGNvbXBsZXRlIGENCmNvbW1hbmQg
d2l0aGluIDUwdXMuIFRoaXMgaGFwcGVucyB3aXRoaW4gdGhlIHRpbWVvdXQgcmVxdWlyZWQgZm9y
IGFuDQplbmRwb2ludCBjb21tYW5kLiBBcyBhIHJlc3VsdCwgdGhlcmUncyBubyBuZWVkIHRvIHBl
cmZvcm0gcmVtb3RlIHdha2V1cC4NCg0KRm9yIHVzYjMgc3BlZWQsIGlmIGl0J3MgaW4gVTMsIHRo
ZSBnYWRnZXQgaXMgaW4gc3VzcGVuZCBhbnl3YXkuIFRoZXJlDQp3aWxsIGJlIG5vIGVwX3F1ZXVl
IHRvIHRyaWdnZXIgdGhlIFN0YXJ0IFRyYW5zZmVyIGNvbW1hbmQuDQoNCllvdSBjYW4ganVzdCBy
ZW1vdmUgdGhlIHdob2xlIFN0YXJ0IFRyYW5zZmVyIGNoZWNrIGZvciByZW1vdGUgd2FrZXVwDQpj
b21wbGV0ZWx5Lg0KDQpUaGFua3MsDQpUaGluaA==

