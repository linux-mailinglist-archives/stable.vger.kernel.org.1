Return-Path: <stable+bounces-10617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6158082C8D6
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 02:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1C21C21B49
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 01:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D001A179BA;
	Sat, 13 Jan 2024 01:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VRiYnhTM";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="N3MOouDQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KEGTmvHD"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C01A5B5;
	Sat, 13 Jan 2024 01:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40CMTbxE028320;
	Fri, 12 Jan 2024 17:39:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=5QalOAmQBWmDG4c9b6EeEBHqXDCQf4qShwjKZo/sBCo=; b=
	VRiYnhTM2HlpeVVvuWGu5kR3WMBnXzU03BUC6h45ltB8ypxkWuKuTfSY5ib5ekkO
	riPalQEVUYTAGrq1xLkD55vKS4f4Ktds5mIpM6/ijwr9LWFGKvkJm9MMAAISd7r5
	FFrbCTBc2bzvXP0lCbsfxap11sAEcMbMa968FlsqorsUbFmurixHfq/4LyDH50ax
	a7yvB8/ZvNPDSI+D2XbB2SZYWcSIWO4lkxpBcfynIBzDTPL6pcJT2MnyR/ema4Ji
	5eeTElnZBEbom/VidQ44BG6O7BVK44xkhzaCyPqjrnvR0Bdf7t8UOda2qcZ/QIQ2
	ISMme2pkEqHXMFK3rYse0Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3vkdaxgpj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 17:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705109968; bh=5QalOAmQBWmDG4c9b6EeEBHqXDCQf4qShwjKZo/sBCo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=N3MOouDQXV8FtMPCVs8mUKzA+mlUyTYU1MhzJBcy3C96o89qZpaRomEfO1y0PUIgb
	 WhhKH8USA260xcJJjH0ocUypUmQ0CvKVHXvgi2s1TtGnjh2aSx6pCFxRcrQFF0+5Vd
	 U/jiPwLJj1PT0uG5V+LAVRmx37lxcWlnN4U5vOF52SHD65NZzBCIYRpb4ZFLzBfDOJ
	 BvY22wEukhqGjqJpAnzwb3Xrmszk/DCvm+B1lV8SaPOa5LvoDIaNS+l9q/y32KoYWb
	 uKANLigJrs8TwSMcaZmozWhyMq1B7mqh8xlMXHYRD6rZc3Snushx4WvlTuIHQFir/G
	 wPHrDInSyDtKw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DF37940408;
	Sat, 13 Jan 2024 01:39:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 4D8D8A006D;
	Sat, 13 Jan 2024 01:39:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KEGTmvHD;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 994E7400A2;
	Sat, 13 Jan 2024 01:39:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9PiPUFGiSWQ22C+01DylHZ7hjl8O3CoE0p08rpJBs6hZWYNvf/bOyPFzd005XioylNAdof/5G5qGs5YPhQdhk/QlKFMrRsscIXwLl1+cio2S1ZNScFYbitQZ6v+0bB8YMuWgVQSHEz5K8QosMS9uaaEw7yWKlBpBd1130uk+lWTuWRVvTYFY/lyZTSApTbK4gtT2s3IS274RMcQfqhdAQSehD/lZsTZl1Bh5Sfb+KvsNazmjmptj/9Jv09SU2j46ppT+dZsZEpqowUJ1yMih98y78GsIIQvLv4VSb3iu8fKmKZUrFRA7QXjYpgcWtB3U0wDH3Ntmbce27jg2i8iDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QalOAmQBWmDG4c9b6EeEBHqXDCQf4qShwjKZo/sBCo=;
 b=YiexMEOfYOC0/boqpqxm2NArmNWCR1mLsN2QQqc0V+pUjF5ALjR9yshSSxSAmP0ZzNQ+5av6KYKdJzm5cZnEZiMOXxurBBuS1KgkOqrPtrb509wnJQJxQyD0rPjHPh+SJWbsz+gWz+qO+3S76EUP7WDtrzxzi3xkXTLkJ0DsMR3udD3lo7GHBnN+m6u+PJh19HMN2awANLXSJrTSHlg/TtoeasDOX1qgnP+4OIw0Y+YV94r4aC+u43gTcG/6LHgBxgq932faI+zrqyR7bGCSKAISif4daepRMF5Q2Tiv7Bm0NmP+oYZR2FNgI9468vN37twOXeXy/v/uNZUi4NXL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QalOAmQBWmDG4c9b6EeEBHqXDCQf4qShwjKZo/sBCo=;
 b=KEGTmvHDtgFrLzRVLLNmU6nRgO3nC/auPhe1Blg5wqdWJwfuWMGw+zAmo+ep9FCo9gZU5gy6OA2R2f9CFH5L7rJxFoCrIuKaWwpMFej76pF6Uq05UUeYUaBiBm/V3KZN8vqQOflCiMx0mBz5bL7obwgYw/5Y6hNCvS5/R0rokyI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Sat, 13 Jan
 2024 01:39:22 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7181.015; Sat, 13 Jan 2024
 01:39:22 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: pci: add support for the Intel Arrow Lake-H
Thread-Topic: [PATCH] usb: dwc3: pci: add support for the Intel Arrow Lake-H
Thread-Index: AQHaRWTft26vTmFlX02yPk3MSztK47DW99sA
Date: Sat, 13 Jan 2024 01:39:22 +0000
Message-ID: <20240113013918.fhcz32gkwtlf6viu@synopsys.com>
References: <20240112143723.3823787-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20240112143723.3823787-1-heikki.krogerus@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SA3PR12MB7951:EE_
x-ms-office365-filtering-correlation-id: 3e31b220-546f-480f-9816-08dc13d877c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 n1RXZQ5lz4JJc0adfU6vHifhAbU4qRYZpMyPdpz1d+pfJkcPSEMkdSqEifj3EXSjGz+C98bsrvLbBABuE4L62cm1LFOX7Q1C84AQAWfqIUeajw8y3eqv7No7DgOjJmKEVZ1s24DX9PA5oCiXS9j37IprBKgPYJJpgUEgGao5oQ4JdqTb65jADwmrSaAQOHe82+m1rH7aOQPEZ9hruJCs9A98m+uhRMQfd7uG4vd2ySHS14qvvUB4iAfp+nzxHuRSJaHTcfzmQNuRIyFEZMyBtDYqOaPk6p09UqhDUvlt50W/DmKubK9fQww0RZ7fE5mi4Sm+JmbD4pD9hAWqbpmauU5ZF8nFeFqLJxF6ms5UpOT74u1KrMTbirq1xMVHviLKxMqFu9RoMslsX9d0Lpt3aNw+wvWsL2lREktuhrY8KVLz29DSmmROLANDEr5a9yi7LeTljwc46MK09HwgIrhqd2VTvKqp9MrfHNFI5NN/hsnEcXxE4CSCKMpeDNrI/HLRoGEIPJUyxwv2EamV5G2wrq4jv75ZgM/YGRaXvz4serD04aNDsHSV812AIMTY8P7sHNlNYPas8Z4nQmly5z3yCVKhgNV1pMOTyfI4sjZf+ygzcrIoc19aFBo0w7osmte/
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(478600001)(6486002)(71200400001)(6512007)(6916009)(6506007)(64756008)(54906003)(41300700001)(66446008)(91956017)(66476007)(76116006)(66946007)(316002)(86362001)(26005)(1076003)(2616005)(8936002)(8676002)(4326008)(38100700002)(66556008)(5660300002)(38070700009)(2906002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VTgrL1EvTTRqbWpncVlSVFNPbERTQm8yL21yeWRQbTloU1dnTW93S2JKU3dj?=
 =?utf-8?B?TGFGRW14WE1HRkxMVmNhdkM1NENmRXBBVndhSG5KcUVmQnJoOTJKOUlZMXBx?=
 =?utf-8?B?WWJOajB4cSs1dHlrWG9xNjN1MTMvUktFUVVuWE05T2paQllDT3ZIOFRJYjZP?=
 =?utf-8?B?UlNQR0pGbFo5RmxRZElCRzhoRkRKSjZKS1U0RFp5eVB0Q0xXWXY4MzRONXpz?=
 =?utf-8?B?T3IyWDI5ZEpPaHJPMmpTamhmVXJzMTV1YXlHN2VBcUZCZW1zT00rZ2ZIVXZ6?=
 =?utf-8?B?UnRwSzE3c3dzRWlMK09VU0lMTHUwVW10MTVxakh5SFNCVmJmRGY4TW1nQ0tZ?=
 =?utf-8?B?eEFQTFZZd3k4NDNPTTlYcURSdFdEcC8vem5BbnYxdVVVQVphWllmL1ZSR0xu?=
 =?utf-8?B?cVJhOURzMkJEMWdNbzhIZk1JTHhUWURpdzQxY0o0Z3FaVnhYTDhTMXZ6OWwy?=
 =?utf-8?B?YVZnNXZzeklja01FRkkzRHFZVGFiWjNNVU5FYmdKSUNucTFlejY1a0tVTnVW?=
 =?utf-8?B?czQrOVRzM3hKV3BiZlNiZWxtbGthTUsxbkh1ZUtlZVZnOVNLRWE1d3Q0ZDFV?=
 =?utf-8?B?bHd6SlJGK0xESEdDSVoyK0wrUHRmWG5pVXFDaTZoa3VrWFgzUGhBZytoYUhU?=
 =?utf-8?B?blpSSVNSd2U1NE41QVdsRWROUVM0MkVLRytWMXNxYnBBZFR0b3NoS1FER2Nk?=
 =?utf-8?B?ck1ZTnpScmZVK0FSOFp4UzJoZWU5elc4N05lS2JDbmwyZTVzRC9DYzdrcDJG?=
 =?utf-8?B?Qms5bjRYM2o4VTB3ckl6aWxKVWRzMFNGbkRiQXQ1ZGdLMmM3RThPREF3Z3Y1?=
 =?utf-8?B?MzhpRzREVGN0UklFbEN5ak9vS2JxemhkcDYwUTdVdnFqeDRBNmxIdUtXYW1r?=
 =?utf-8?B?cGFUYkNLRS85cUlCVTJHWFNHM2wwQjFldFRVdGNURm1tWXcyV1ZIcHpXZTRX?=
 =?utf-8?B?b2hoNVFhNW9oNmZ6MTY0V1dLM05TcFpKdTRJUmVmcWE4VG5KR0QyUC9KK0Vq?=
 =?utf-8?B?SStJaUk3WlZCUjFvQ2tVOWRRZEF0TXRjTE1RQ3U3Sm80b1hLM3VVVUdZNzAv?=
 =?utf-8?B?Mm5YOFd4N3pXWW1ybGNBblBaTjcxc2NhVUtaa1NVNTlYZ0NPM1pleUhYRFRa?=
 =?utf-8?B?cTFCU3BYMHBQU2ZpRTFDYWVEU2IyMHNMdVpwYkwySWFoeWNVTjV2Qi9Qd3A3?=
 =?utf-8?B?Z3ZJMEJOT0k1OXBCU1JoOE9MQVEvaHZtSXNyTFg0NjQ3bGxYMllrRTJqcVU4?=
 =?utf-8?B?cXZRUHZvU2Evdi8yak9CV29GRDdDN2hFUzV5TldsVlRwWEZ4Y3A1NUIzWEJn?=
 =?utf-8?B?LzBCSzFGV25jL0ZGVkNNeHJ3R2JvYVNOV2hPVWRBUGdMaHdYcThwYzRNZmgy?=
 =?utf-8?B?TXlGMEkvdjg3NkdvalJsTWlGRjZPWGFuYjlPYXZrWnVEVGZHZDZvU3F1R0t2?=
 =?utf-8?B?RjAxcERkSlUxVlgzVGp6VWhVU21aMkt1MjFQRGJCL1NiMUdaMUVpdDFZVyt3?=
 =?utf-8?B?V3ZnOHRXd0NjN3ZsYTFaOUVORmlEMXoxaFp4Q3VOVWhERUxnQmRVVTlwbkl4?=
 =?utf-8?B?R3FsMlYyN1NDNUV3NE9Rczd4UkxxL0lZMk5QYVQvaWo0QVlKUGxCeTJ3TFJv?=
 =?utf-8?B?SEtMWHRRb2ZjcE5IMyttemdLV3FaUlFTWlpSM2xDbmwzVXN0cC8yM056cjdR?=
 =?utf-8?B?Vk1PdmhneDdId3phK3ZVMDYvWkZuazJjcjJSR1Y3VlNQKzQvMW1FeUp3dkVI?=
 =?utf-8?B?bGxpYnd4NEtzT1c0WXZwb0E2dDFIRkdPVUJHM2FEdmFLbGhSS2traExwbjlI?=
 =?utf-8?B?RHNBOXFHZGNUMXU4V1h0M2NiNXNacmt2VWFEM3piY3ZFU0ZSbUh6TzlyeG81?=
 =?utf-8?B?cTdxR2tWa0J1KzhDajh0MjVKYjk1czQ2WFFMMUZLS2dxaXdhT1JOLzJCMHhy?=
 =?utf-8?B?VXpWWDYySld1enZhckVnOWNqSE9JRE9xcVdvQnlYSWlLeUZoWHNqWWVUVHhV?=
 =?utf-8?B?QVpzenVaclp4aDJQVThiVnlJb3FJd2VudzJoWm9GVUFjNnhCS3ZDbytDWnN3?=
 =?utf-8?B?Umh0bHIwQ3FhSm1NMWdkcEJBUkVZUytFdUtJQ1NaY3o4NEFWdXczNTBNeTNC?=
 =?utf-8?Q?HKmmHfW4TShHURlM0iBPMJAT3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29C7D9D45A26544AA139BB903EEAECE2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	bO9e7ssIFq+1Tqv/AI56XecYFoA84ufNPM4fud0nyfwtq/w/qcEyVYr4Fy89DQXQwRHj4J8pHgjymCPl/9Kw4NtlzbraTh7zxNAJuXnL/xL5vejYoyUvBbmXBleHYPq41psMWzb/ui0L+vtPcPNlqpO5xoQLrI2LfvfpZf/Y/kK0+JqcToStUvyYlPlaZas93lKkQr+GTXF65aWrIaZuvzjL4cevHDqQVoWsbIH+i2oDzAysDTwzbxvogrpSA364PCJ/6cpxB5ZPVgjD+NWWmGdFIPz6nJqCMAdWPrpNbCjpn1qBgxCh5c1YTrvwopqKvX7tLU/GjwIy4WEYxHGSx/7WePA6wOu50gjB+4HanTqtEqDpD2/1hUvRYHVYn4R6GAn5PumyJkCrvZQlfC4DGgnYwOKTK/ZxwDBdTQOivJ0zk18GDRDiSJlMfbr958v6MJY/02E7b7Vs2nmYT/VBqq3WnCeEswsgpYNcHsJgokH15vMXOoFNaM2+BgGHV1COcGYggQzay0ZG2/LHrgJ9gW40GNV7yL5O74TEiS3OLNJcwD8rQabIapdvdVeJ3axKrfWLkUbrsQIZPc5fEcc4jyMeDIP93VmEufMZzQijzt5aAhHPToabSvLyIH9etsjXQoVXqhHI103yK8trIcBIbQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e31b220-546f-480f-9816-08dc13d877c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2024 01:39:22.2740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cy0aymAYBOKyX94CewpjPhLTV3vmRlKJCB7fNteSAHMaJfoR649WioUmMBZPFI/bvcgs49YHnf/JLFXcsBZfOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
X-Proofpoint-GUID: C4lHbZPFub2aE8JPYkkncQ6GL4QRX_j7
X-Proofpoint-ORIG-GUID: C4lHbZPFub2aE8JPYkkncQ6GL4QRX_j7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxlogscore=989 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401130010

T24gRnJpLCBKYW4gMTIsIDIwMjQsIEhlaWtraSBLcm9nZXJ1cyB3cm90ZToNCj4gVGhpcyBwYXRj
aCBhZGRzIHRoZSBuZWNlc3NhcnkgUENJIElEIGZvciBJbnRlbCBBcnJvdyBMYWtlLUgNCj4gZGV2
aWNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhlaWtraSBLcm9nZXJ1cyA8aGVpa2tpLmtyb2dl
cnVzQGxpbnV4LmludGVsLmNvbT4NCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0t
DQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtcGNpLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2R3YzMtcGNpLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcGNpLmMNCj4gaW5kZXggNjYwNDg0
NWMzOTdjLi4zOTU2NGUxN2YzYjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1wY2kuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcGNpLmMNCj4gQEAgLTUxLDYg
KzUxLDggQEANCj4gICNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF9NVExQCQkweDdlYzENCj4g
ICNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF9NVExTCQkweDdmNmYNCj4gICNkZWZpbmUgUENJ
X0RFVklDRV9JRF9JTlRFTF9NVEwJCQkweDdlN2UNCj4gKyNkZWZpbmUgUENJX0RFVklDRV9JRF9J
TlRFTF9BUkxICQkweDdlYzENCj4gKyNkZWZpbmUgUENJX0RFVklDRV9JRF9JTlRFTF9BUkxIX1BD
SAkJMHg3NzdlDQo+ICAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfSU5URUxfVEdMCQkJMHg5YTE1DQo+
ICAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfQU1EX01SCQkJMHgxNjNhDQo+ICANCj4gQEAgLTQyMSw2
ICs0MjMsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgZHdjM19wY2lfaWRf
dGFibGVbXSA9IHsNCj4gIAl7IFBDSV9ERVZJQ0VfREFUQShJTlRFTCwgTVRMUCwgJmR3YzNfcGNp
X2ludGVsX3N3bm9kZSkgfSwNCj4gIAl7IFBDSV9ERVZJQ0VfREFUQShJTlRFTCwgTVRMLCAmZHdj
M19wY2lfaW50ZWxfc3dub2RlKSB9LA0KPiAgCXsgUENJX0RFVklDRV9EQVRBKElOVEVMLCBNVExT
LCAmZHdjM19wY2lfaW50ZWxfc3dub2RlKSB9LA0KPiArCXsgUENJX0RFVklDRV9EQVRBKElOVEVM
LCBBUkxILCAmZHdjM19wY2lfaW50ZWxfc3dub2RlKSB9LA0KPiArCXsgUENJX0RFVklDRV9EQVRB
KElOVEVMLCBBUkxIX1BDSCwgJmR3YzNfcGNpX2ludGVsX3N3bm9kZSkgfSwNCj4gIAl7IFBDSV9E
RVZJQ0VfREFUQShJTlRFTCwgVEdMLCAmZHdjM19wY2lfaW50ZWxfc3dub2RlKSB9LA0KPiAgDQo+
ICAJeyBQQ0lfREVWSUNFX0RBVEEoQU1ELCBOTF9VU0IsICZkd2MzX3BjaV9hbWRfc3dub2RlKSB9
LA0KPiAtLSANCj4gMi40My4wDQo+IA0KDQpDYW4geW91IHNlbmQgYSAidjIiIGFuZCBhIGNoYW5n
ZSBsb2cgdW5kZXIgdGhlIC0tLSBsaW5lIG5leHQgdGltZT8NCg0KUmVnYXJkbGVzcyB3aGV0aGVy
IHlvdSdkIHNlbmQgYSB2MjoNCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVu
QHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

