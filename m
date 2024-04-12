Return-Path: <stable+bounces-39296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C745F8A2C10
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 12:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795AE281343
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 10:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33B53393;
	Fri, 12 Apr 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AQbXgYzx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Cbk0RIgG"
X-Original-To: stable@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFDF52F9C
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916896; cv=fail; b=HXPdws5c6m4aMeRqCjJsrqbiOEWBo9R5AjDNRHSHu2P//M/5LCv5tmJbFg05Ta56efIHfLcGNotx6Xj/GB3L81yOoEzZv/uG1eBKK1cqsDuZ/kzPYG9Ghny29TnlrOzqnvpiLFPTg6ffj9mYiWtlstHtOejbefIOAPKXmHc3rKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916896; c=relaxed/simple;
	bh=3zgq4p7Mc/7uGV12mUqdvJinunEcAWTN0Bn9+XEg8is=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kOcr6hqDBG/+HDjSysXzV5kBiG8HhpXpaDLqNJGRO6QjIHqpRhoYv2dsGlNNVWkrx5PhGBa6YGTVLp3eyUWWEiOIEZyZyhJfD/0fDK7Mr8L8GjEixO0Jk8MHgo23uN78Nav05rf2X5Kgujx6zobDSrUAgS80chAwI7VEYaOhkUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AQbXgYzx; dkim=fail (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Cbk0RIgG reason="signature verification failed"; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7c8450baf8b511eeb8927bc1f75efef4-20240412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=RTj5hW8Le22Po5PkxHO0X5Ae0DgKYpTybL2KWgMT8fw=;
	b=AQbXgYzxgkC6LhVG6LxBQQqYFL8uTeVl7oBTKB48xCYbYAd8gmsxikMALeBRr3V0CyKxWTqg3fvwUf19z1Ern9mzrY2W2tyrNCT4PlpO0Ioxo/K3y0CMZrfcCPiD6/HnWaEmZwmObHHetpoo6LhhDNcA1Z2fgRoqGqNF/YTwCoo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:a34d7e93-2205-4a56-bb11-84e52c7c0721,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:c45d1a86-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:0,Content:0,EDM:-3,IP:nil,URL
	:0,File:82,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR
	:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7c8450baf8b511eeb8927bc1f75efef4-20240412
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <nini.song@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 108976370; Fri, 12 Apr 2024 18:14:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Apr 2024 18:14:45 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Apr 2024 18:14:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaYsvTuWUkXnmKCdtbgJ7tCnYTxM8p1BoEAStDS2BbsPhE1z0Fo2RsCH8+hL9Kz9PLy7N72ZToylgCCnmqDiUnvKvu6+l5QW4Lb9UMsLQvpcx6A5YEVdwbyD7w+lq5Zox+FRNNOrFKcVTGTcNorN1NfnlZbqesM4BwkNWO/DbIzvhkjuFI5WnmngoZG3DFMhbpgYDaecwGALmVT82EFBYKAR4Ajrzm7MfBViqwWXKNFmCwPcrlli/sd0ee98stx/qBYTxk3CB3d8jlpPBlbXFOwwRF1LGBDhU62i05aW0atin5fTR54z0MJ6qe/Q9vB31l42vWN1WtNTGIGUJjtnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke4DBta+MVN34XANRgbsFolUaJvP4QalF1dF6GIkp7Q=;
 b=CyGE06Ei/COVmG7CrpPq/3j8tWy2bjQ3akc+1PJPU5Y8P629hpPqw1JDRMYBpx0i+50S4lcAhy5wJY87NzbZChV8VhOb82htZjsNDU+vUqBQqKnjzC2zTpe3UFdB/L6O/rcwAq9JCVE2VK/cdHgOXPM0hI2v6Mp5XvoxZdJe8KLAAjwMmOqujF4y/nxOgiPemVPwUgSrQzRqc6ldpawLlLfpTXDGajAfaQiwRJd3U9nV+V3UbnRDuWqdqjRPK5Bki7w2pQHb2ce+Mqk2mzzMApqMBHgT0AajPCKbWKCIZBdHLoBwLOi1SPnx/S75QGtn2rrv6SASf+07weVa6vAlLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke4DBta+MVN34XANRgbsFolUaJvP4QalF1dF6GIkp7Q=;
 b=Cbk0RIgGiHe2pw+lrm/OPONHbXstKHBjM2/2TrQ766T2FFICbow/FXfAEwUMNjZEJAn7qQ5UC04bJE4YZnbho+wd7XtjDJoMTcSIXAMY9XC5DOj3+aE/WmVX/UlMln6tQiZlgKroTwvATKpjqLjrAXIKMV7i4OPpcSE24NbxXqY=
Received: from KL1PR03MB6225.apcprd03.prod.outlook.com (2603:1096:820:89::5)
 by TYSPR03MB7544.apcprd03.prod.outlook.com (2603:1096:400:432::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 10:14:42 +0000
Received: from KL1PR03MB6225.apcprd03.prod.outlook.com
 ([fe80::1645:e718:5359:7d76]) by KL1PR03MB6225.apcprd03.prod.outlook.com
 ([fe80::1645:e718:5359:7d76%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 10:14:42 +0000
From: =?big5?B?TmluaSBTb25nICinuql7qWcp?= <Nini.Song@mediatek.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: [PATCH] media: cec: core: remove length check of Timer Status
 solution applies to 5.4 and 4.19
Thread-Topic: [PATCH] media: cec: core: remove length check of Timer Status
 solution applies to 5.4 and 4.19
Thread-Index: AdqMv6SXarpTCpv0ThyWoOxhmJ4QCw==
Date: Fri, 12 Apr 2024 10:14:41 +0000
Message-ID: <KL1PR03MB6225011CAE293E2DBF6C3B8E90042@KL1PR03MB6225.apcprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-Mentions: stable@vger.kernel.org
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IGFpPSIyIiBubT0iaW1hZ2UwMDEucG5nIiBwPSIiIHN6PSIwIiB0PSIwIiBoPSIiIGlkPSIiIGJsPSIwIiBibz0iMCIvPjxhdCBhaT0iMCIgbm09ImJvZHkuaHRtbCIgcD0iYzpcdXNlcnNcbXRrMTg4MjlcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03NzMxOTMxOS1mOGI1LTExZWUtYjczYS0yOGRmZWIwZjliMDRcYW1lLXRlc3RcNzczMTkzMWEtZjhiNS0xMWVlLWI3M2EtMjhkZmViMGY5YjA0Ym9keS5odG1sIiBzej0iNzIyOCIgdD0iMTMzNTczOTA0Nzc5NDk2NjE3IiBoPSI0WDJFeFJWc0ZhMENSWEZPN2EvM0dueG0vSEk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6225:EE_|TYSPR03MB7544:EE_
x-ms-office365-filtering-correlation-id: 1ed9a87a-8092-407a-0d92-08dc5ad95e84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gJRY+jf9wTgswgVcoKVXBmx3kVMYcdVBuaJiqlb6bNTKB5QOGmo6aaI1//qB+Xd6ZLGdr+ZC9iK/LGaJPoJeQ5/TmDNiTXWzDaxrc2fadtc4pfNiV3ZGO7ODU9kzDiYish63fRLsUc9Jt3/WzidoSi7hQr8bK+d6B2TrcSKcqLe5DsNhGWkMe1oEJXrWy/AOYN7rzpeD+s5Ow26MrOKMJdIr/qUaqPPxQPiO5Za/fQbWZivpFDrtWcQs8dGzpjiW5HqOPJLJIUM+Olhnc3Ui7u8Hy7qePajYX3LHZXxKjMHzHRpp7MxRSqf1pAYqh9OxDgKB2HR4fbhR2gRF7EZWbzJWunzqfk5ylgrrd7E3n+Osoh4uRXr3dl7EY96QfFXc4HqA3T2hxnwGEHienfSK56Vzc7AaM3Sh4/sODnXcyTpkobJobewY0ElXspqcYy/ckrKLMGZylAL+E0De/ZIHXwWI4fbKjLbZmKsBCa5PIfSlxXq/dftQQ+JSSoRGcZWqO17AgGlhqeeU20GOD7Mh08S6qsVw2z1X3+fpmri9IZPN0d+l2bsXiGaOCStaB08dwX0FXNf1vm0JngzH1F9TxnXTivubDN0QW2dJuf3J3y2WH+aRaheg+FfEQiu7o0vWR2JiYqvX2GWvGN93xfNw5mGSTNiJDWsxS65gjoTtQeEpxSscRBGuZj//Ch++tlMiAQhVLIFUlOMMoXMbf/yIr8sFRjwSTiRc1UCuckPiZRw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6225.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?alVOb1VwdFl4RkMzc0l6Z0x2cmVJKzFEd1hWYys3Vk95WE9pVTdURkt2b0JHYkRT?=
 =?big5?B?ZFdwdzJtMm5KbmxwS3QwZlFBZ2RFRjZPSTl2ZnoraXhkL255UmJlS0JEOGwwcmZu?=
 =?big5?B?YUlMbEVva2Z4clZNNG40NWEvQnk2dkNIVmhlNTJJZ09mRlpneEpGVzBMU0ZTdzhO?=
 =?big5?B?cGpvK21lVU03WHRaVDdram4yblhzcmUyb2V0clN3TnJUZFhCUERmUFAwS010blRS?=
 =?big5?B?S1p5alRxSGI1Zld0WDRIdHFwN2hod242d3JHSU82R2MyWk5ha29BS2U4MlEyM2Jv?=
 =?big5?B?V1NtcGNubnUzR1diY1VMdCticTRDSVZNS0RvYzBwbE5mWU8xZzZqQmJTeG5id0Rq?=
 =?big5?B?cklCTHNFM0xqVktWekhvSGxuUWthT0FLSkhNZVE4UzAxbHRScjQ3bldIQWlXQk5R?=
 =?big5?B?K0xyQ1U3dzZXUHBXTU40Tmw0UDlBOG54S1J0aGduMWZiTmRlMHpDenhUUVhkY2Vk?=
 =?big5?B?T0d3cUlZdDRPK2tnVHJac0dvQXRHRElSWGxOSjhmclEwTk0xcDNRRDNSUDJ0bmV5?=
 =?big5?B?Z040M1NPWGRXSDBiTDUzWUpqdEZ6bzRPZVJYRDg5QktpblhxOElHMHFydXl1V2xY?=
 =?big5?B?T3cxYnhmN1Q5TXp3U1c4dk5CajhrVUNVV084OGlpRXk0N2pKRS9vOGdaTFhBaklj?=
 =?big5?B?OEJEdWV6YlhDakhTNDNGVzZ0NysyUE5TSnNUMjBsWVJUWEsreTdmWmFGRkE3aW82?=
 =?big5?B?dUQwNHlHcVhra2RXcU11MlBUWVZ0dDdYcnNVeHF6L1JUaDM4NXFaVFhyd0RLWWFZ?=
 =?big5?B?Mzc3YTB5MzBiWkpwQm1ieGRCdElaYmJnOFZEZEpLa0pweEx6OWtOa1NsTktReFMv?=
 =?big5?B?dHhFa3NsNmlhdklwZkd1ZlFTcEI2Q2luS2Q0UDRPQWVNQ1V2TTNGUEFjeVNmQ2Zn?=
 =?big5?B?ZVp1MmlqR3I4dGJKZTBIaVFxWjNtbmY0MjlFeE55Q3AxbXlSbzgzeGFnVUN1UXdM?=
 =?big5?B?cEJDVnRBcmV5QUFKWk9qME1YQzZPY3NOOFVnQXp6dzd2WVlZZnJIdTRwZ09lNWtK?=
 =?big5?B?enREQVhmRGhoN1MyYlN6TVNTdXR2d21aSDRIMzFGb29OVDBOVDNnU2gvZ1RHMHFB?=
 =?big5?B?TEFNU1EwZlY5ZTRYVXJNcldtSnhNNTR1WDNhblczdDNDMWk2YW5ZVXVvRk5pdUZa?=
 =?big5?B?T2ptSGFSZUFiRzNtTXNHTmRvbVJ5eVlCZFM2NDFoeFVXVnZRMXB2UkkxcFZ6aEtj?=
 =?big5?B?VkVuMnZkc0dkdzNZS2Q5NHBCcXpTRTlsWmRNUFFVMHRPejd5ZVpYbndqelUrNkF4?=
 =?big5?B?ZytmRXJneEdDRjRFV0E4NWdvVE52QnJ6eUFNWkhraGZlVmRWZWpuQ2x0UEppY0tH?=
 =?big5?B?WWdYZjZ2M1I2NFdtazN0WXFJWStCYlRUSjVsT3JxOU14TGk0NEZkWkp5Vzd4bHhh?=
 =?big5?B?QW9kZEJQcWhVQjFPdDZyOHBkcWxqWncwdHJmWWR3ZHNKOEs0ODh6SGFsM2ZWMjBn?=
 =?big5?B?ZUJjamxIbDdWL3VXNTUxM3hTL0lGSjJYaEw3MFd0Rkt6ZGVoSkRTZTVmbTFDMW8z?=
 =?big5?B?TExmYzRIWnhnQVlaME1paHR5S0JCbmRXOTFRcm1aY1lCaHFHcVkzaXZTbno3SWl6?=
 =?big5?B?MUgxQXEwMU5YM2Q3UjE0bkpkOTBLcmFjTjM0VHgxQnZBTHFCMTNUR0RLd2h5eWNk?=
 =?big5?B?ZFc0TUNOVzE3bUJyYzUxVmFFY1dtbTNXU3p0c0RUaC8rR0VzS1NTaVhTaWc1RW82?=
 =?big5?B?TzBUcDBtSVRKTWZyWU5NWmVEOWZOSnp2LzZEeU1JYlNwcXF3emEzaGxJYnVoWWFj?=
 =?big5?B?d25aeXp2aE1kRnAyMnJmaWpiYk1Yd1ZDZGtXKzZQNkt5OE12NVF4WVRQVnhvOXNh?=
 =?big5?B?aTdRMmdEL2dEQytaZFNLcnhTVFNZNlJjSXJHSDJCWURvbUwrZlpxaEtZRlMza3B0?=
 =?big5?B?bXNabGdnVUpNajBlb2wxZ3hsa0JJVzJCWVFsOUI0aytsRGZGTU5zYTdGc29BQXVX?=
 =?big5?B?a2RWd3ZsVUkxTDY4bW54N3Q5RDcwWFh2R2t0VThqVEFrb1RzR2dJZTYrbUNCS3JP?=
 =?big5?Q?BcVUPj9w497TKan+?=
Content-Type: multipart/mixed;
	boundary="_006_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6225.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed9a87a-8092-407a-0d92-08dc5ad95e84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 10:14:41.9471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKitfxADtzn64DoOL523WMFMnRerNu3NzDkMqE3n3BYc+IMj/FHJgE2MXaUm4kiHGzuINy0QCZv3vSLRiQmM2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7544

--_006_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_
Content-Type: multipart/related;
	boundary="_005_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_";
	type="multipart/alternative"

--_005_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_
Content-Type: multipart/alternative;
	boundary="_000_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_"

--_000_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64

SGkgQHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc8bWFpbHRvOnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
DQoNClRoaXMgcGF0Y2ggaGFzIGJlZW4gbWVyZ2VkIGluIG1haW5saW5lIGFzIGNvbW1pdCBjZTVk
MjQxYzNhZDQ1Lg0KW3BhdGNoIGRpZmZdDQpbY2lkOmltYWdlMDAxLnBuZ0AwMURBOEQwNC5CQ0Q4
QTA3MF0NCg0KQmVjYXVzZSBvZiBvdXIgY3VzdG9tZXIgdXNlZCB2NS4xNSwgdjUuNCBhbmQgNC4x
OSBmb3IgTVAgcHJvZHVjdGlvbiwgd2hpY2ggcmVxdWlyZXMgdGhpcyBzb2x1dGlvbi4NCg0KV2Ug
bmVlZCB5b3VyIGhlbHAgYXBwbHkgdGhlIHBhdGNoIGluIHY1LjE1LCB2NS40IGFuZCA0LjE5Lg0K
DQoNCg0KVGhhbmtzIQ0KDQpCUiwNCg0KTmluaSBTb25nDQoNCg==

--_000_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_
Content-Type: text/html; charset="big5"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dbig5">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:=B7s=B2=D3=A9=FA=C5=E9;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:=B2=D3=A9=FA=C5=E9;
	panose-1:2 2 5 9 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=B7s=B2=D3=A9=FA=C5=E9";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"\@=B2=D3=A9=FA=C5=E9";
	panose-1:2 1 6 9 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML =B9w=B3]=AE=E6=A6=A1 =A6r=A4=B8";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:=B2=D3=A9=FA=C5=E9;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTML
	{mso-style-name:"HTML =B9w=B3]=AE=E6=A6=A1 =A6r=A4=B8";
	mso-style-priority:99;
	mso-style-link:"HTML =B9w=B3]=AE=E6=A6=A1";
	font-family:=B2=D3=A9=FA=C5=E9;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ZH-TW" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word;text-justify-trim:punctuation">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Hi <a id=3D"OWAAM2C14A1E9E9234D=
FDA4694D905D219F5B" href=3D"mailto:stable@vger.kernel.org">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@stable@vger.kernel.org</span></a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">This patch has been merged in m=
ainline as commit ce5d241c3ad45.<br>
[patch diff]<br>
</span><span lang=3D"EN-US"><img border=3D"0" width=3D"538" height=3D"392" =
style=3D"width:5.6in;height:4.0833in" id=3D"=B9=CF=A4=F9_x0020_1" src=3D"ci=
d:image001.png@01DA8D04.BCD8A070"></span><span lang=3D"EN-US"><o:p></o:p></=
span></p>
<pre><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-ser=
if">Because of our customer used v5.15, v5.4 and 4.19 for MP production, wh=
ich requires this solution.<o:p></o:p></span></pre>
<pre><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-ser=
if">We need your help apply the patch in v5.15, v5.4 and 4.19.<o:p></o:p></=
span></pre>
<pre><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-ser=
if"><o:p>&nbsp;</o:p></span></pre>
<pre><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-ser=
if">Thanks!<o:p></o:p></span></pre>
<pre><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-ser=
if">BR,<o:p></o:p></span></pre>
<pre><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-ser=
if">Nini Song<o:p></o:p></span></pre>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
</body>
</html>

--_000_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_--

--_005_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=39807;
	creation-date="Fri, 12 Apr 2024 10:14:41 GMT";
	modification-date="Fri, 12 Apr 2024 10:14:41 GMT"
Content-ID: <image001.png@01DA8D04.BCD8A070>
Content-Transfer-Encoding: base64

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
D6724PzIdMMEAAAAAElFTkSuQmCC

--_005_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_--

--_006_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_
Content-Type: message/rfc822
Content-Disposition: attachment;
	creation-date="Fri, 12 Apr 2024 10:14:39 GMT";
	modification-date="Fri, 12 Apr 2024 10:14:40 GMT"

Received: from SEYPR03MB8744.apcprd03.prod.outlook.com (2603:1096:101:207::14)
 by KL1PR03MB6225.apcprd03.prod.outlook.com with HTTPS; Thu, 4 Apr 2024
 08:41:28 +0000
Received: from PS2PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::24) by SEYPR03MB8744.apcprd03.prod.outlook.com
 (2603:1096:101:207::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 08:41:25 +0000
Received: from HK3PEPF0000021D.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::1) by PS2PR01CA0060.outlook.office365.com
 (2603:1096:300:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.28 via Frontend
 Transport; Thu, 4 Apr 2024 08:41:25 +0000
Received: from exhb.mediatek.com (60.244.123.129) by
 HK3PEPF0000021D.mail.protection.outlook.com (10.167.8.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 08:41:24 +0000
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Apr 2024 16:41:20 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Apr 2024 16:41:20 +0800
Received: from MTKGWAGT02.mediatek.inc (172.21.85.91) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Apr 2024 16:41:20 +0800
Received: from pps.filterd (MTKGWAGT02.mediatek.inc [127.0.0.1])
	by MTKGWAGT02.mediatek.inc (8.17.1.19/8.17.1.19) with ESMTP id 4344hJmY024784;
	Thu, 4 Apr 2024 16:41:20 +0800
Received: from mailgw02.mediatek.com ([172.29.197.22])
	by MTKGWAGT02.mediatek.inc (PPS) with ESMTPS id 3x9eqdg7ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Apr 2024 16:41:04 +0800
Received: from sin.source.kernel.org [(145.40.73.55)] by mailgw02.mediatek.com
	(envelope-from <srs0=ojwd=lj=xs4all.nl=hverkuil-cisco@kernel.org>)
	(musrelay.mediatek.com ESMTP with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 440852715; Thu, 04 Apr 2024 01:40:53 -0700
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B023FCE203F;
	Thu,  4 Apr 2024 08:40:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC91EC433C7;
	Thu,  4 Apr 2024 08:40:46 +0000 (UTC)
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
To: =?utf-8?B?TmluaSBTb25nICjlrovlrpvlpq4p?= <Nini.Song@mediatek.com>
CC: =?utf-8?B?Q0kgV3UgKOS8jeWAieWEhCk=?= <ci.wu@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "nicolas@fjasle.eu"
	<nicolas@fjasle.eu>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Jani Nikula
	<jani.nikula@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: cec: core: remove length check of Timer Status
Thread-Topic: [PATCH] media: cec: core: remove length check of Timer Status
Thread-Index: AQHaT5J63htVcGX/K06jpL+AsfAJI7FYOGsA
Date: Thu, 4 Apr 2024 08:40:44 +0000
Message-ID: <1caa6a4c-d4c1-474a-abf2-63384dba3cbb@xs4all.nl>
References: <20240125132850.10430-1-nini.song@mediatek.com>
In-Reply-To: <20240125132850.10430-1-nini.song@mediatek.com>
Content-Language: en-US
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Organization-AuthSource: mtkmbs13n2.mediatek.inc
X-MS-Has-Attach:
X-MS-Exchange-Organization-Network-Message-Id: 6439d434-6a45-4c58-7f50-08dc548302f6
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
received-spf: pass(mailgw02.mediatek.com: domain of kernel.org designates
 145.40.73.55 as permitted sender)	receiver=mailgw02.mediatek.com;
 client-ip=145.40.73.55; helo=sin.source.kernel.org
x-ms-exchange-organization-originalclientipaddress: 172.21.85.91
x-ms-exchange-organization-originalserveripaddress: 10.167.8.39
x-ms-publictraffictype: Email
authentication-results: spf=softfail (sender IP is 60.244.123.129)
 smtp.mailfrom=kernel.org; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=xs4all.nl;
x-ms-office365-filtering-correlation-id: 6439d434-6a45-4c58-7f50-08dc548302f6
x-ms-traffictypediagnostic: HK3PEPF0000021D:EE_|SEYPR03MB8744:EE_|KL1PR03MB6225:EE_
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:60.244.123.129;CTRY:TW;LANG:en;SCL:-1;SRV:;IPV:CAL;SFV:SKN;H:exhb.mediatek.com;PTR:mailgate1.mtk.com.tw;CAT:NONE;SFS:(13230031)(82310400014);DIR:INB;
x-ms-exchange-crosstenant-originalarrivaltime: 04 Apr 2024 08:41:24.6613 (UTC)
x-ms-exchange-crosstenant-fromentityheader: HybridOnPrem
x-ms-exchange-crosstenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
x-ms-exchange-crosstenant-authsource: mtkmbs13n2.mediatek.inc
x-ms-exchange-crosstenant-authas: Anonymous
x-ms-exchange-crosstenant-network-message-id: 6439d434-6a45-4c58-7f50-08dc548302f6
x-ms-exchange-transport-crosstenantheadersstamped: SEYPR03MB8744
x-ms-exchange-transport-endtoendlatency: 00:00:03.4601875
x-ms-exchange-processed-by-bccfoldering: 15.20.7409.037
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0;jmr:0;auth:0;dest:I;ENG:(910001)(944506478)(944626604)(920097)(930097)(140003);
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWIxYzlyRW1kMERyM05IcURNUmpUT1EvL0IzekxlNDFJRFhLV2w0THJuaUZC?=
 =?utf-8?B?MFpUaUNFUk1WdFZDY3d0Um5sTUJLcFY5RWRXUFlORWVZYllRa05RU3lDRTYv?=
 =?utf-8?B?WHc3NTY3OG1QRjhvV2c1ZVNSYXMzUzJWQUFlT2hxNm9XQ1JOYkwweFZGQjkx?=
 =?utf-8?B?aFArc29tbDNsbW5wU2IxOENRYjNLbkxOR0xRUXBkNnZxOHg4TnhJR3cweHFL?=
 =?utf-8?B?MlEydUpWU1NOQ0U0Mk54TlNkdTJqY0hvTFpCRkc1VUYzek5tem40Wms4YW5T?=
 =?utf-8?B?UEtRM21nSnM3aGV6QUEydFBwd1VEMi9wWHRRSDdNcmpBb20yNFZqVHpGc0dx?=
 =?utf-8?B?K3VBTVlXWmdweWhmdkFZV0ZBcndTWXZZSGM3cXBRRDNIQm5IWkdyeG1kcy9n?=
 =?utf-8?B?Wk9mMExDS0JmSjZkeUw1K0x6YVRZckxmOVlKL3JRdkM4V2MybGMwRlBkMHQ5?=
 =?utf-8?B?b0Fad2Nlck5qZG01dnRGRzFOeHFnZFFMMUdNWVN2WGFnRllveC84eGFyZXBH?=
 =?utf-8?B?OEFCZ1Q1dExobmNwYmZGUTJtbGgxRFFnaXI2R2p1aWp0UUlldWh0aFIrQVJ1?=
 =?utf-8?B?TkJaYlFDNnNoKzBZaGNQUFBzd2ZhdnB2bys0UHRtNWNGOEpwNHhrSERLWjZX?=
 =?utf-8?B?eHZvd2VHK2lCQWxuV29nTUs0ZHZLMG4xTXhIYXR6QVlkUm9YQytxTHp2Z0Mw?=
 =?utf-8?B?RTFYUmt0VDNTaUg3bHd6YnVHWHNQeXdGbnUvVlUzKzcxNWYxZ212ZTByOGts?=
 =?utf-8?B?cytMdFFsaWVubzc1LzI5MlR4UzVvbmo0NlpyOUpFeEhXelFSZC9YZUVJWldJ?=
 =?utf-8?B?OVFPa1IwZlBtRlA2WldKSzEwUm5IeG04d1pBZTYwUENzSEZ5aHl0czFCWVJE?=
 =?utf-8?B?c3FaOUdJOEtaRUhWVkRZdGp1MDVWZUtQbEtncWZHWDdLNlgvazdtYURvNzZ4?=
 =?utf-8?B?elBXbGQ5Nmg5My9Lcmdvb0hQMVhwbTZRQWM0OGdlcXE5Wk9JbUkyQzNiZlpk?=
 =?utf-8?B?UVl4OU9UNDhPNU13Q3lCQnozUkNRR0ZnU1ZoVlZVbFdTbFhyYXVmb1NiOUFX?=
 =?utf-8?B?aXErZDlqL3BzTERrWUdLdHk4Y2hWeU84elpxcWhyY3lQU3FXQWlNK1NVcEJn?=
 =?utf-8?B?QVJ3RHBxOTZqSVRFclB4TG1VbUFMTllHNnNVcXBnaVR1cWk1KzRSNm0zaFVY?=
 =?utf-8?B?RmwwbUpVam5mdUdHYXRoZFJ4SFhoczQ4YW1YVDNKNTFHUnQxbCs3dWVZUzBn?=
 =?utf-8?B?ZG4wQjBlcDYybVE5VE8yS2VkZXJPbXZTZmdJa2V2dzBjdHVyMW5pZUJJQnAv?=
 =?utf-8?B?NTZPTmYyM25OSVYyMlNMNkRBNzV1QldxRjZVKzE4a0VzdURtUW5xOHVtdSti?=
 =?utf-8?B?dHNQbUtJY0xCNlQ0R1lGU1UzVEtGUXhId1diRWJ4K01DQTR6S3lFOVZGZkVo?=
 =?utf-8?B?MmRObXMxaVlpZmVpdm14SkxYTlNQVFQ4bllCazhpTlNiVW51aERVZm0wekIx?=
 =?utf-8?B?bjdxclVLZ1ltbmhzNDVBTFNwNkpGT3UvNzZtZi9UVUtINXZpaW8wTTFaaVZY?=
 =?utf-8?B?dG9JZS9icE5nQWtrdW1nWERYSkxaaEJrWm9ReUxaVE1SOVlGQTF3WEJ1MURC?=
 =?utf-8?B?V0R4cEJ6WW5BdHhBdzdDR2Y3UkVkYXJQM29ibW5Qd0VKYnNRazJ4SjQrM3BU?=
 =?utf-8?B?WFFoakVNallxRVUxcU85blR6Ky84RGVMbGoxNE8rRjh0STFSdWZ0K2J4cyty?=
 =?utf-8?B?VTJMOEwwV0JJeVllVkx0LyszcmRoOXZJaldjSmV4SUp2UThZb01uamIxOGlE?=
 =?utf-8?B?N1dyZVNxWUU5QVd4NWtob3ZHVnZ5VVpZM21EMjZ5OXROaUtQeWltU3hMQlJM?=
 =?utf-8?B?cTZuZG5TbnpWSC9KWUNSU2tia2xiTzFsUmpkQzJUL3RZdmE4L1dydFJzWTcw?=
 =?utf-8?B?V2NNNXZqd3d2YlhJc0VBTnRzY2h1NFdlUlpKMDMrcFlxMVo5dW5XUmNUeVQv?=
 =?utf-8?B?dHFTVUovaVl2d1Y2M056R25sem9tUXlQS25rcEJDSlN6UTBqVnNDZEJtWk9C?=
 =?utf-8?B?V0o2YUV4YytnWkhZajluQzZMVUozdXl3WTVnQWR1WVZQWEZiUjlSc082MFdt?=
 =?utf-8?B?RDk1aDFKRDhDRmY0ZitWMGlUeFJKM3BicStpc1Q4dTVwWlplSys3ZHlhY2Rr?=
 =?utf-8?B?Mys1ZHNRc2srSTdZbTBDTjk2T25vR2JXR2d1SVpJM1V3eWI1TW9odUl4bEdt?=
 =?utf-8?B?N1N1YXRzNG0zZHczUHNDcTJiclVISTZ5VDgrMTNBNk5QWEJ0cFlHY2pqTFNV?=
 =?utf-8?B?Z3ppbXZRbUpQVTFkcjNxakljendQcjdiSk1jTkdobnRSd0VmZzJsTkRhVlpX?=
 =?utf-8?B?ZWFDRlhpQmRnNEpPcVVsUS80aGZKWk9LdlFRYlpwMnp1M0wxZnUrYkxsekRG?=
 =?utf-8?B?c00vNUNTa0V2RnZqcE9wLzNKdTJkVklleU81OEJUL2VEYTFZWUhTOG5QYUxR?=
 =?utf-8?B?cU9LRjFCN2pZZXdYOVFhMDhVRXM4MWt1L0Rrc2NyVjZPVFNScWNrTFV1NVQw?=
 =?utf-8?B?cUdZekQ3UzlnK1VQK3FaakdBWXdsR3lHWTFqU0tRRnVJT3Zjd1pvZ0NmVXhn?=
 =?utf-8?B?SlFsdXhoTUVhQm0zZzRFNHdhbVVQNkpidVhlYlN5T1gyWmxOVklNc1l0MHVS?=
 =?utf-8?B?QVFwQnhINFhVblJhNXdTLzRFdFN6WlkwV1RnMTcyM2wrS3diNHV2YUg3ZFVN?=
 =?utf-8?Q?7s=3D?=
Content-Type: multipart/alternative;
	boundary="_000_1caa6a4cd4c1474aabf263384dba3cbbxs4allnl_"
MIME-Version: 1.0

--_000_1caa6a4cd4c1474aabf263384dba3cbbxs4allnl_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4N
Cg0KDQpIaSBOaW5pLA0KDQpUaGlzIHBhdGNoIGhhcyBub3cgYmVlbiBtZXJnZWQgaW4gbWFpbmxp
bmUgYXMgY29tbWl0IGNlNWQyNDFjM2FkNDUNCigibWVkaWE6IGNlYzogY29yZTogcmVtb3ZlIGxl
bmd0aCBjaGVjayBvZiBUaW1lciBTdGF0dXMiKS4NCg0KVG8gZ2V0IHRoaXMgaW50byBvbGRlciBr
ZXJuZWxzIHBsZWFzZSBwb3N0IHRoaXMgcGF0Y2ggdG8NCnN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcs
IENDIHRoZSBsaW51eC1tZWRpYSBtYWlsaW5nbGlzdCwgYW5kIG1lbnRpb24gdGhlDQptYWlubGlu
ZSBjb21taXQgdGhhdCBJIHByb3ZpZGVkIGFib3ZlLg0KDQpBbHNvIG1lbnRpb24gdGhhdCB0aGlz
IHBhdGNoIGFwcGxpZXMgdG8gNS4xMCBhbmQgdXAuIFlvdSBjYW4gbWVudGlvbg0KdGhhdCB0aGUg
cGF0Y2ggYXBwbGllcyB0byA1LjQgYW5kIDQuMTkgYXMgd2VsbCBhZnRlciByZW1vdmluZyB0aGUg
Jy9jb3JlJw0KZGlyZWN0b3J5IGZyb20gdGhlIHBhdGhuYW1lcy4NCg0KU2luY2UgeW91IGFyZSB0
aGUgYXV0aG9yIG9mIHRoZSBwYXRjaCwgeW91IHNob3VsZCBiZSB0aGUgb25lIHRvIHBvc3QNCnRo
ZSBwYXRjaC4NCg0KUmVnYXJkcywNCg0KSGFucw0KDQoNCk9uIDI1LzAxLzIwMjQgMTQ6MjgsIG5p
bmkuc29uZ0BtZWRpYXRlay5jb20gd3JvdGU6DQo+IEZyb206ICJuaW5pLnNvbmciIDxuaW5pLnNv
bmdAbWVkaWF0ZWsuY29tPg0KPg0KPiBUaGUgdmFsaWRfbGEgaXMgdXNlZCB0byBjaGVjayB0aGUg
bGVuZ3RoIHJlcXVpcmVtZW50cywNCj4gaW5jbHVkaW5nIHNwZWNpYWwgY2FzZXMgb2YgVGltZXIg
U3RhdHVzLiBJZiB0aGUgbGVuZ3RoIGlzDQo+IHNob3J0ZXIgdGhhbiA1LCB0aGF0IG1lYW5zIG5v
IER1cmF0aW9uIEF2YWlsYWJsZSBpcyByZXR1cm5lZCwNCj4gdGhlIG1lc3NhZ2Ugd2lsbCBiZSBm
b3JjZWQgdG8gYmUgaW52YWxpZC4NCj4NCj4gSG93ZXZlciwgdGhlIGRlc2NyaXB0aW9uIG9mIER1
cmF0aW9uIEF2YWlsYWJsZSBpbiB0aGUgc3BlYw0KPiBpcyB0aGF0IHRoaXMgcGFyYW1ldGVyIG1h
eSBiZSByZXR1cm5lZCB3aGVuIHRoZXNlIGNhc2VzLCBvcg0KPiB0aGF0IGl0IGNhbiBiZSBvcHRp
b25hbGx5IHJldHVybiB3aGVuIHRoZXNlIGNhc2VzLiBUaGUga2V5DQo+IHdvcmRzIGluIHRoZSBz
cGVjIGRlc2NyaXB0aW9uIGFyZSBmbGV4aWJsZSBjaG9pY2VzLg0KPg0KPiBSZW1vdmUgdGhlIHNw
ZWNpYWwgbGVuZ3RoIGNoZWNrIG9mIFRpbWVyIFN0YXR1cyB0byBmaXQgdGhlDQo+IHNwZWMgd2hp
Y2ggaXMgbm90IGNvbXB1bHNvcnkgYWJvdXQgdGhhdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTmlu
aSBTb25nIDxuaW5pLnNvbmdAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWVkaWEv
Y2VjL2NvcmUvY2VjLWFkYXAuYyB8IDE0IC0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTQgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2NlYy9j
b3JlL2NlYy1hZGFwLmMgYi9kcml2ZXJzL21lZGlhL2NlYy9jb3JlL2NlYy1hZGFwLmMNCj4gaW5k
ZXggNTc0MWFkZjA5YTJlLi41NTlhMTcyZWJjNmMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVk
aWEvY2VjL2NvcmUvY2VjLWFkYXAuYw0KPiArKysgYi9kcml2ZXJzL21lZGlhL2NlYy9jb3JlL2Nl
Yy1hZGFwLmMNCj4gQEAgLTExNTEsMjAgKzExNTEsNiBAQCB2b2lkIGNlY19yZWNlaXZlZF9tc2df
dHMoc3RydWN0IGNlY19hZGFwdGVyICphZGFwLA0KPiAgaWYgKHZhbGlkX2xhICYmIG1pbl9sZW4p
IHsNCj4gIC8qIFRoZXNlIG1lc3NhZ2VzIGhhdmUgc3BlY2lhbCBsZW5ndGggcmVxdWlyZW1lbnRz
ICovDQo+ICBzd2l0Y2ggKGNtZCkgew0KPiAtY2FzZSBDRUNfTVNHX1RJTUVSX1NUQVRVUzoNCj4g
LWlmIChtc2ctPm1zZ1syXSAmIDB4MTApIHsNCj4gLXN3aXRjaCAobXNnLT5tc2dbMl0gJiAweGYp
IHsNCj4gLWNhc2UgQ0VDX09QX1BST0dfSU5GT19OT1RfRU5PVUdIX1NQQUNFOg0KPiAtY2FzZSBD
RUNfT1BfUFJPR19JTkZPX01JR0hUX05PVF9CRV9FTk9VR0hfU1BBQ0U6DQo+IC1pZiAobXNnLT5s
ZW4gPCA1KQ0KPiAtdmFsaWRfbGEgPSBmYWxzZTsNCj4gLWJyZWFrOw0KPiAtfQ0KPiAtfSBlbHNl
IGlmICgobXNnLT5tc2dbMl0gJiAweGYpID09IENFQ19PUF9QUk9HX0VSUk9SX0RVUExJQ0FURSkg
ew0KPiAtaWYgKG1zZy0+bGVuIDwgNSkNCj4gLXZhbGlkX2xhID0gZmFsc2U7DQo+IC19DQo+IC1i
cmVhazsNCj4gIGNhc2UgQ0VDX01TR19SRUNPUkRfT046DQo+ICBzd2l0Y2ggKG1zZy0+bXNnWzJd
KSB7DQo+ICBjYXNlIENFQ19PUF9SRUNPUkRfU1JDX09XTjoNCg0KDQo=

--_000_1caa6a4cd4c1474aabf263384dba3cbbxs4allnl_
Content-Type: text/html; charset="utf-8"
Content-ID: <0C757C9A208D824DB59903DE70969010@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64

PCEtLXR5cGU6aHRtbC0tPjwhLS17LS0+DQo8aHRtbD4NCjxoZWFkPg0KPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPg0KPC9o
ZWFkPg0KPGJvZHk+DQo8dGFibGUgY2xhc3M9Ik1zb05vcm1hbFRhYmxlIiBib3JkZXI9IjAiIGNl
bGxzcGFjaW5nPSIwIiBjZWxscGFkZGluZz0iMCIgYWxpZ249ImxlZnQiIHdpZHRoPSIxMDAlIiBz
dHlsZT0id2lkdGg6MTAwLjAlO2JhY2tncm91bmQ6Izc3RkZDQyI+DQo8dGJvZHk+DQo8dHI+DQo8
dGQgd2lkdGg9IjkiIHN0eWxlPSJ3aWR0aDo3LjBwdDtiYWNrZ3JvdW5kOiNFQTA2MjE7cGFkZGlu
Zzo1LjI1cHQgMS41cHQgNS4yNXB0IDEuNXB0Ij4NCjwvdGQ+DQo8dGQgd2lkdGg9IjEwMCUiIHN0
eWxlPSJ3aWR0aDoxMDAuMCU7YmFja2dyb3VuZDojRkZENEQ0O3BhZGRpbmc6NS4yNXB0IDMuNzVw
dCA1LjI1cHQgMTEuMjVwdCI+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1z
by1lbGVtZW50OmZyYW1lO21zby1lbGVtZW50LWZyYW1lLWhzcGFjZToyLjI1cHQ7bXNvLWVsZW1l
bnQtd3JhcDphcm91bmQ7bXNvLWVsZW1lbnQtYW5jaG9yLXZlcnRpY2FsOnBhcmFncmFwaDttc28t
ZWxlbWVudC1hbmNob3ItaG9yaXpvbnRhbDpjb2x1bW47bXNvLWhlaWdodC1ydWxlOmV4YWN0bHki
Pg0KPHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6OS41cHQ7Zm9udC1mYW1pbHk6
JnF1b3Q7U2Vnb2UgVUkmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjojMjEyMTIxIj5FeHRlcm5hbCBl
bWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRp
bCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50LjxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPC90ZD4NCjwvdHI+DQo8L3Rib2R5Pg0KPC90YWJsZT4NCjwh
LS19LS0+DQo8cD48L3A+DQo8cHJlPg0KSGkgTmluaSwNCg0KVGhpcyBwYXRjaCBoYXMgbm93IGJl
ZW4gbWVyZ2VkIGluIG1haW5saW5lIGFzIGNvbW1pdCBjZTVkMjQxYzNhZDQ1DQooJnF1b3Q7bWVk
aWE6IGNlYzogY29yZTogcmVtb3ZlIGxlbmd0aCBjaGVjayBvZiBUaW1lciBTdGF0dXMmcXVvdDsp
Lg0KDQpUbyBnZXQgdGhpcyBpbnRvIG9sZGVyIGtlcm5lbHMgcGxlYXNlIHBvc3QgdGhpcyBwYXRj
aCB0bw0Kc3RhYmxlQHZnZXIua2VybmVsLm9yZywgQ0MgdGhlIGxpbnV4LW1lZGlhIG1haWxpbmds
aXN0LCBhbmQgbWVudGlvbiB0aGUNCm1haW5saW5lIGNvbW1pdCB0aGF0IEkgcHJvdmlkZWQgYWJv
dmUuDQoNCkFsc28gbWVudGlvbiB0aGF0IHRoaXMgcGF0Y2ggYXBwbGllcyB0byA1LjEwIGFuZCB1
cC4gWW91IGNhbiBtZW50aW9uDQp0aGF0IHRoZSBwYXRjaCBhcHBsaWVzIHRvIDUuNCBhbmQgNC4x
OSBhcyB3ZWxsIGFmdGVyIHJlbW92aW5nIHRoZSAnL2NvcmUnDQpkaXJlY3RvcnkgZnJvbSB0aGUg
cGF0aG5hbWVzLg0KDQpTaW5jZSB5b3UgYXJlIHRoZSBhdXRob3Igb2YgdGhlIHBhdGNoLCB5b3Ug
c2hvdWxkIGJlIHRoZSBvbmUgdG8gcG9zdA0KdGhlIHBhdGNoLg0KDQpSZWdhcmRzLA0KDQpIYW5z
DQoNCg0KT24gMjUvMDEvMjAyNCAxNDoyOCwgbmluaS5zb25nQG1lZGlhdGVrLmNvbSB3cm90ZToN
CiZndDsgRnJvbTogJnF1b3Q7bmluaS5zb25nJnF1b3Q7ICZsdDtuaW5pLnNvbmdAbWVkaWF0ZWsu
Y29tJmd0Ow0KJmd0OyANCiZndDsgVGhlIHZhbGlkX2xhIGlzIHVzZWQgdG8gY2hlY2sgdGhlIGxl
bmd0aCByZXF1aXJlbWVudHMsDQomZ3Q7IGluY2x1ZGluZyBzcGVjaWFsIGNhc2VzIG9mIFRpbWVy
IFN0YXR1cy4gSWYgdGhlIGxlbmd0aCBpcw0KJmd0OyBzaG9ydGVyIHRoYW4gNSwgdGhhdCBtZWFu
cyBubyBEdXJhdGlvbiBBdmFpbGFibGUgaXMgcmV0dXJuZWQsDQomZ3Q7IHRoZSBtZXNzYWdlIHdp
bGwgYmUgZm9yY2VkIHRvIGJlIGludmFsaWQuDQomZ3Q7IA0KJmd0OyBIb3dldmVyLCB0aGUgZGVz
Y3JpcHRpb24gb2YgRHVyYXRpb24gQXZhaWxhYmxlIGluIHRoZSBzcGVjDQomZ3Q7IGlzIHRoYXQg
dGhpcyBwYXJhbWV0ZXIgbWF5IGJlIHJldHVybmVkIHdoZW4gdGhlc2UgY2FzZXMsIG9yDQomZ3Q7
IHRoYXQgaXQgY2FuIGJlIG9wdGlvbmFsbHkgcmV0dXJuIHdoZW4gdGhlc2UgY2FzZXMuIFRoZSBr
ZXkNCiZndDsgd29yZHMgaW4gdGhlIHNwZWMgZGVzY3JpcHRpb24gYXJlIGZsZXhpYmxlIGNob2lj
ZXMuDQomZ3Q7IA0KJmd0OyBSZW1vdmUgdGhlIHNwZWNpYWwgbGVuZ3RoIGNoZWNrIG9mIFRpbWVy
IFN0YXR1cyB0byBmaXQgdGhlDQomZ3Q7IHNwZWMgd2hpY2ggaXMgbm90IGNvbXB1bHNvcnkgYWJv
dXQgdGhhdC4NCiZndDsgDQomZ3Q7IFNpZ25lZC1vZmYtYnk6IE5pbmkgU29uZyAmbHQ7bmluaS5z
b25nQG1lZGlhdGVrLmNvbSZndDsNCiZndDsgLS0tDQomZ3Q7ICBkcml2ZXJzL21lZGlhL2NlYy9j
b3JlL2NlYy1hZGFwLmMgfCAxNCAtLS0tLS0tLS0tLS0tLQ0KJmd0OyAgMSBmaWxlIGNoYW5nZWQs
IDE0IGRlbGV0aW9ucygtKQ0KJmd0OyANCiZndDsgZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEv
Y2VjL2NvcmUvY2VjLWFkYXAuYyBiL2RyaXZlcnMvbWVkaWEvY2VjL2NvcmUvY2VjLWFkYXAuYw0K
Jmd0OyBpbmRleCA1NzQxYWRmMDlhMmUuLjU1OWExNzJlYmM2YyAxMDA2NDQNCiZndDsgLS0tIGEv
ZHJpdmVycy9tZWRpYS9jZWMvY29yZS9jZWMtYWRhcC5jDQomZ3Q7ICsrKyBiL2RyaXZlcnMvbWVk
aWEvY2VjL2NvcmUvY2VjLWFkYXAuYw0KJmd0OyBAQCAtMTE1MSwyMCArMTE1MSw2IEBAIHZvaWQg
Y2VjX3JlY2VpdmVkX21zZ190cyhzdHJ1Y3QgY2VjX2FkYXB0ZXIgKmFkYXAsDQomZ3Q7ICBpZiAo
dmFsaWRfbGEgJmFtcDsmYW1wOyBtaW5fbGVuKSB7DQomZ3Q7ICAvKiBUaGVzZSBtZXNzYWdlcyBo
YXZlIHNwZWNpYWwgbGVuZ3RoIHJlcXVpcmVtZW50cyAqLw0KJmd0OyAgc3dpdGNoIChjbWQpIHsN
CiZndDsgLWNhc2UgQ0VDX01TR19USU1FUl9TVEFUVVM6DQomZ3Q7IC1pZiAobXNnLSZndDttc2db
Ml0gJmFtcDsgMHgxMCkgew0KJmd0OyAtc3dpdGNoIChtc2ctJmd0O21zZ1syXSAmYW1wOyAweGYp
IHsNCiZndDsgLWNhc2UgQ0VDX09QX1BST0dfSU5GT19OT1RfRU5PVUdIX1NQQUNFOg0KJmd0OyAt
Y2FzZSBDRUNfT1BfUFJPR19JTkZPX01JR0hUX05PVF9CRV9FTk9VR0hfU1BBQ0U6DQomZ3Q7IC1p
ZiAobXNnLSZndDtsZW4gJmx0OyA1KQ0KJmd0OyAtdmFsaWRfbGEgPSBmYWxzZTsNCiZndDsgLWJy
ZWFrOw0KJmd0OyAtfQ0KJmd0OyAtfSBlbHNlIGlmICgobXNnLSZndDttc2dbMl0gJmFtcDsgMHhm
KSA9PSBDRUNfT1BfUFJPR19FUlJPUl9EVVBMSUNBVEUpIHsNCiZndDsgLWlmIChtc2ctJmd0O2xl
biAmbHQ7IDUpDQomZ3Q7IC12YWxpZF9sYSA9IGZhbHNlOw0KJmd0OyAtfQ0KJmd0OyAtYnJlYWs7
DQomZ3Q7ICBjYXNlIENFQ19NU0dfUkVDT1JEX09OOg0KJmd0OyAgc3dpdGNoIChtc2ctJmd0O21z
Z1syXSkgew0KJmd0OyAgY2FzZSBDRUNfT1BfUkVDT1JEX1NSQ19PV046DQoNCjwvcHJlPg0KPHA+
PC9wPg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_1caa6a4cd4c1474aabf263384dba3cbbxs4allnl_--

--_006_KL1PR03MB6225011CAE293E2DBF6C3B8E90042KL1PR03MB6225apcp_--

