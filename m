Return-Path: <stable+bounces-46186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578998CF277
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 04:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58ED2813D4
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 02:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58BCEC4;
	Sun, 26 May 2024 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N+Glo31J";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hLc009kv"
X-Original-To: stable@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F41633
	for <stable@vger.kernel.org>; Sun, 26 May 2024 02:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716691919; cv=fail; b=rbXhm4Xoxxlc0sTD++ObwCcmZGWqwhrNgXOuxTaDKAugRd9z6azkYV0S/lW72fKGahlvPkuj2LyM3g+CJlUGS5T+Z/92Gwt/QIDGVgCZDSLB0QfmE8RKorqd8ImPszo1cVbcW129flO0z4xVRF9qxiTwfA2zlvhTxiUy8/9cDzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716691919; c=relaxed/simple;
	bh=8t0ekOwNR3e83iXxSEdOgWZpTm4TesTHP0NRD1zevGc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fq5MxwTgREg1etg9tKY/xjogO/b7x25fS/KdFtR5iafc3vGSkr94gyXmzIwao6cJA6MxpPyOkVEu+WjGt8T5qvq4BoXsZMy625i5Psh6FOtCA5slAzbBoVt4dra42F1bvp67Vpqm3HUAITfL3d/eL9kWiaWBCfrUHi9VRufOhGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N+Glo31J; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hLc009kv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e62c856a1b0a11efbfff99f2466cf0b4-20240526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8t0ekOwNR3e83iXxSEdOgWZpTm4TesTHP0NRD1zevGc=;
	b=N+Glo31Jvij6ViszFwhS8uQRDXwFr+aQaoQEJdWP9Up9Vufttl/KMCsoqpDyVYsSByP59QJWLdPggbTdYZoCvSfGiSHLzm8+HxRepPbO1xMM4YJkJHJ/+SNDnE2Pa7tuq7M6Ob3tTCDLPDLuCPqPuoygBkr1rQPWoiuvPTARoQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:5b8770f2-8053-4ce0-807d-d903716ce7b2,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:82c5f88,CLOUDID:c3ddd087-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 50,UGT
X-CID-BAS: 50,UGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e62c856a1b0a11efbfff99f2466cf0b4-20240526
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <lin.gui@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 958737292; Sun, 26 May 2024 10:51:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 26 May 2024 10:51:48 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 26 May 2024 10:51:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni1JIy+RAy340VuK1OwVbhC6pKhCAZn+23oFkjQjHWM8xgDgCsulTD/LmG7EGYrH5vfFpdQosAUEL+WA/2y2SSApOm8UrMU4Q9lygn4YKICoThkoHy08WmvHY/IJPD7djpuMOhanOTCAS3wbAVSHvwA+FM04iIDN37j1UPrIigNeZU5Xo/Ww6aBZFF4Q9mXYylQJF7wWa8rPSpbOE2A1hObFEfYfsQAR4F2koaMF2T/D6kBd64P/W92PnXPZwIHU+RSe07G+UG6kwiEtiNy0KJCfxBdYBH3pY68HNSfSdSsKv0fb6Ppa7JPSfCFyz8iKRR141dbmf3xPvUHhPFD1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t0ekOwNR3e83iXxSEdOgWZpTm4TesTHP0NRD1zevGc=;
 b=jc3kEDEoc96P6jplRopYtZFAOfcsuIoiq2gWLp8K/4HMjuXmWdQoPLPvqpBqf6Dsx+LRoJrpz0873yUlqFZIM+TawHtmEw9m+PuV9Zzx25UNnGvjVxAldFSE7dbc5fk5kHjTxJV62cMcqOLFOj4p6MVf7KLaG065lF7EOfkQYXiHQqsOLPkgIpqG9o6nWPTtJ5XFi4oA7OGKIeakbx17rIaDzK1sP16y/ggUikkYlF9dYJjzu2NI8dIqtQSSqL6yOJFsrtlfKgXQCkM0h881IAwY7DNJwWMy5fyo/WSWhxXdaUek5YrTCEQHLTyQ9nulCacHSJc/5q50DrsLhQ3Jxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t0ekOwNR3e83iXxSEdOgWZpTm4TesTHP0NRD1zevGc=;
 b=hLc009kvkeALgXBfFTLjcBrcsKh+wIAde8+FnjOHAxKNCHp2RPPnFcKCyW+keyglOuLIsmobaGYfDmZD0+XS7vdfedZYni/TvZpv2/QFSy5iiLyw/Q9IBI8Yzqol/GcGyS+UCzRNMS3gv9iiQ6vzrr0m0wbbtQWCEzE36I9P1So=
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com (2603:1096:301:8f::9)
 by SEYPR03MB6673.apcprd03.prod.outlook.com (2603:1096:101:80::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9; Sun, 26 May
 2024 02:51:43 +0000
Received: from PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::4ca6:7dcb:47ec:f6f2]) by PSAPR03MB5653.apcprd03.prod.outlook.com
 ([fe80::4ca6:7dcb:47ec:f6f2%4]) with mapi id 15.20.7633.001; Sun, 26 May 2024
 02:51:42 +0000
From: =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?= <Lin.Gui@mediatek.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	=?utf-8?B?WW9uZ2RvbmcgWmhhbmcgKOW8oOawuOS4nCk=?=
	<Yongdong.Zhang@mediatek.com>, =?utf-8?B?Qm8gWWUgKOWPtuazoik=?=
	<Bo.Ye@mediatek.com>, =?utf-8?B?UWlsaW4gVGFuICjosK3pupLpup8p?=
	<Qilin.Tan@mediatek.com>, =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?=
	<Wenbin.Mei@mediatek.com>, =?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?=
	<Mengqi.Zhang@mediatek.com>, =?utf-8?B?TGluIEd1aSAo5qGC5p6XKQ==?=
	<Lin.Gui@mediatek.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiDlm57lpI06IGJhY2tw?=
 =?utf-8?B?b3J0IGEgcGF0Y2ggZm9yIExpbnV4IGtlcm5lbC01LjE1IGtlcm5lbC02LjEg?=
 =?utf-8?Q?kenrel-6.6_stable_tree?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiBiYWNrcG9ydCBhIHBh?=
 =?utf-8?B?dGNoIGZvciBMaW51eCBrZXJuZWwtNS4xNSBrZXJuZWwtNi4xIGtlbnJlbC02?=
 =?utf-8?Q?.6_stable_tree?=
Thread-Index: AQHarLpm4Pel55rT8EmHOVSPAeydx7GkXJ4AgAABPICAAANHgIAAFiUAgAAweoCAAOtIEIAAM6mAgAAd3ZCAABCpAIAC336g
Date: Sun, 26 May 2024 02:51:42 +0000
Message-ID: <PSAPR03MB5653D6A7D9FB3668FD499A1A95F72@PSAPR03MB5653.apcprd03.prod.outlook.com>
References: <PSAPR03MB565326FF3D69B95B7A5897D7952F2@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <PSAPR03MB56531563C88DFF85F963CA3295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052333-parasitic-impure-6d69@gregkh>
 <PSAPR03MB565389D72939161224B110CE95F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052329-sadden-disallow-a982@gregkh>
 <PSAPR03MB5653135ABCAF08A979BCCE0295F42@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052313-taste-diner-2d78@gregkh>
 <PSAPR03MB5653638EEC15BE49B2E03E9495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052426-recognize-luxurious-bda8@gregkh>
 <PSAPR03MB56537E5242876A4EE9E910A495F52@PSAPR03MB5653.apcprd03.prod.outlook.com>
 <2024052432-ashamed-carport-c4a0@gregkh>
In-Reply-To: <2024052432-ashamed-carport-c4a0@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-Mentions: gregkh@linuxfoundation.org
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrNTQyMzJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kZmExZjY3Ni0xYjBhLTExZWYtYjczNi1hNGY5MzMyZDU2ZjhcYW1lLXRlc3RcZGZhMWY2NzctMWIwYS0xMWVmLWI3MzYtYTRmOTMzMmQ1NmY4Ym9keS50eHQiIHN6PSI2NzYyIiB0PSIxMzM2MTE2NTQ5OTkwMTY4MjQiIGg9Ii82aTJvSlJLSWhTaVRzKytsUnJTZkFRSmN4VT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5653:EE_|SEYPR03MB6673:EE_
x-ms-office365-filtering-correlation-id: 66ca8e1c-1a42-4b07-b559-08dc7d2ec621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Tjd3Z01ZVkM3Rk5VTnlkZWxvVXZVL3hJNzlXQ0dqeHhmNlZQaG9PVTJMUmJs?=
 =?utf-8?B?ckhZRFFRVmRnclluMGVVN0diU1JlcVJzVFhQQ0RFQUxRRDM0YnhrcnQvbS80?=
 =?utf-8?B?THlXdjRMRGF4UU5obVRicVFUNUdsZmt5amJpanliejhyN1A5RXpUTFk0MVky?=
 =?utf-8?B?WTNBcXBKaGUvVWFPN0lua3Era0NZa0V3UjY2NXNMRHBPaFhvSC9FN05Ta3Jt?=
 =?utf-8?B?NEk3MmxZYko2Q2tDclN1V1hCSEFjSzBWT3EyL242aTBuMmcvRXBuNjk0STdT?=
 =?utf-8?B?SU9ncXdxWFljZXNvc20rTTd5Umt1dFRKS01ObVdnNHdCQjd1MXlINitmTm9j?=
 =?utf-8?B?ekx1WlZVbjZWYXBBOUpXekpmcUU3bjB5VGdVYkdxMWF5UHVFQzJKU0hrc1hT?=
 =?utf-8?B?c1EzV21JY2JNR0RBRzZxZnk2RjBnWkN6NlA5MWY0N2RGdU1uYnpLaVJ2OG4w?=
 =?utf-8?B?WHFQMDc4U3hvQmN3OW10TXZKRUNSOVJCcTY2L2wrKzVuaWdMWDdMcWFoNXlI?=
 =?utf-8?B?RmFiWG96NkdFVHVXNy9nbmVEYnp4a0tNd3lJNjVOb2x5OVl0TXFwcWlJK2dV?=
 =?utf-8?B?V3IyVnYrQmJoOTgycUhUUXFuOXpKdllwdU9lR0RkTmJHdHFBbHAxaFhDNzNk?=
 =?utf-8?B?ODhPdjJaamVrRXAwRyt5bmV6eVduVXJLUUU2MWhTQnYzQmRNYy9ZQnRWZ3g5?=
 =?utf-8?B?cVIyZmRvcXZVWGtJMG5xWE9RSER1OTZEQXc3RWh0VlU5dnN6RmkzMnFCYkMr?=
 =?utf-8?B?eGdRSWxSeDdWRkU4b2JDTG1YNnNTNS9ubk1uM1pYZ1NEZjFibWJyQzM4ejRl?=
 =?utf-8?B?YXk4RHc4NEpwcHB3Q3dqNGFUNllsTlBlZGxjRzVaWmtzYXBtd09VSW9NS0M3?=
 =?utf-8?B?eXYxbjRxS0FnV21zcmtqR2kzT0Qrd0FheERSRkRnRi9neHQ0bk1zSGtiQlJW?=
 =?utf-8?B?d2kwbnJPRFFKdDlWR2ZEUERvdUsrekF3MkpKV3k5NTJqTmRlYjBOT2h3dXdm?=
 =?utf-8?B?bm1mQ2ZGWE1jK21hNksrcjNZbjB2TklLaVZFRnhVdlRabjRTSkticDBya0Fj?=
 =?utf-8?B?UXR2MFZVejdCOWtWM0R4MEc1b1VWd3d2T2k1TFNvTGZNeDdodzdjalhSWk53?=
 =?utf-8?B?MDY1dzJHYjVjTEFINC9kRnJpVGUrbXpMd1ZEblVXTVJxa3FZMDhwY29zWDhn?=
 =?utf-8?B?UlBZak1PSGJ5YytDSDBkVE11dGNOWDlGQjFkQjhkUWZES2hzc2VQTUJObUpi?=
 =?utf-8?B?U1pIMUE2bHFSSXFIR21Ua25oajQ1QTY5YlNHS2VKcHkyMzdYR1kzakVNOHg2?=
 =?utf-8?B?OU1qdVdTekQyS0M2OHdXbzFLMVlBR1FzaUlDRDdxV25RSG1mcm1FZldMMDU0?=
 =?utf-8?B?SHVTd0RHM2Npa1grRTA5azhHUGZEZmhFSHVjNFVtRm5EUU9uNGFLbytMSnd5?=
 =?utf-8?B?enh2SWVJd1BFQkV1RVRsSE5KaU5kdmFsRnF0Vit1Z3JhL3lzZWc1ckdzZlNR?=
 =?utf-8?B?cE5zU0kvOXJ6TzNxMkN0SFMvaDduSXFEWE9GQUFyV2I0eUV3VmRMU3QxdnAy?=
 =?utf-8?B?S3NBcGlYT1RHcXFkWmRJUW92LzJLd3JLSWVNdDZsMkhqS1BzTUl5RkwwcGpZ?=
 =?utf-8?B?TVJWNk5saGNRaUUvNjROOXIzSG05eG1sRU1jZ3g4bzJzTXJuUHZqbTRtY3VC?=
 =?utf-8?B?dFZjZXU5L0xMMnEyVWdONlYyUVExUUNiVjNtcFlWWVZ2ak5IbEtvTFh3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5653.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWdYdjgrQmxBSHlHcXdacG5hNU5Vbms3ZldNZnhuUW01T0VMa05LR1ljWnJW?=
 =?utf-8?B?eTZ4TUc3VE0rL1FBamkrVEwzQ0piencxYVR4OUtEcXUwb1dONlpXTlBUczlw?=
 =?utf-8?B?bDFoYk1HcFJzZ3REMGhiOE5VSStPbENxVkpqQVZidnYvKzlEek5McWloYTBI?=
 =?utf-8?B?M2lFWjZScXgzQzhUV3NXZ2lVbHYzNWwyMUVQK1M0Rzd1ZTRDK0pCRTV4NVRn?=
 =?utf-8?B?MXVRVzhOenBUUS9VNFMzbUxkamtxN1p4aTlEQmVwL3l3REpIZGJPVmQ4OUI5?=
 =?utf-8?B?VnZQQk5uQnExNCtxYlNKSGNtcU5kVXU2VXBFTER1SEUwRUQ5VEtuMlpZQk5R?=
 =?utf-8?B?Y1FLVkIyTElBQXJuVXNudFUwQ01BZVFFeExBR2pYbVZHdEwrNWZDeTk5c3p3?=
 =?utf-8?B?UklIaG9BL1htTHZnODE1YXVaODRFNW1nSFZrVkIxRURDRzk5ekllY2dzaHVp?=
 =?utf-8?B?R3hRNFEwR3RERGFYdG5pMG0vcFdjZEk2WXJqL0dMNGhodzRzWndQRXE3RWhK?=
 =?utf-8?B?b3FBcDNnZFcxcnhqcFNyOWtxL2VHc1gwU29NczBFV01hZ3k5WVJ6Z1AxMXpJ?=
 =?utf-8?B?SU5uaUhUR04venFMYkNodGZ6RWxpSnlZRnZ3V21mVDlXYzdWbFM4QkVYM014?=
 =?utf-8?B?RGhBOTNWcHRuK2kxR2htM0l2S1hzbGdSSTFNVzRGdkdaZDNMVkNBQW5nTDRo?=
 =?utf-8?B?MGdHTDQ3cVpBNzluSVJZMytkQVo3RzRoYWcwQThYOUEwN2dzZXZMczNTUUx5?=
 =?utf-8?B?aEhpeXJHMnZkdzVVUzJmVzFaSEpxZVdUVWhac0QrZHZjMWkyZXpaT01Td1B1?=
 =?utf-8?B?alh4THpEUit3Y1h5UkdDczloMUNxbDNEQVlob2lCVkFSZ2hhRlkrcnJkTVMx?=
 =?utf-8?B?MEhkRnpIMnlJU1R5S0oyTUxjQ0R2djBqbWxTdUh3RzZ2M1FVenZVRkVnajA1?=
 =?utf-8?B?WksvT2VMSDhhS0syeGJSZDNpYUluZEZXRmh5MlZYSVBldVRIRHRKbkxVUjhm?=
 =?utf-8?B?YnBuRUM1aFhPOFhiOUNiLzRYK0JXaTIySWpmc2pCV0YwL25GYVM1RzdKSUJY?=
 =?utf-8?B?ZHBzTU9JWmY4UFZWNmdobis2NGhJTWVhNGZyUFZuTkN6SDlkTWxOQ0NCNTU1?=
 =?utf-8?B?akVtYndzYkZEZm5McmpVem9xUlVWZHF0TmlJV0l6alJCbE0zRld6MHpuVEd1?=
 =?utf-8?B?clBLSWdpYlltMDkvQ1h1a3pGeERkNmFWbWI0c0t1UmJvN2RpSzh5TzNwWFhY?=
 =?utf-8?B?MUZZMitJckJuOTAzZVVBM01WcnVvSWRTcWMrRDAzOTIzcFZGR0pwTmhEUmwv?=
 =?utf-8?B?cEZCSXM3eEdub2FzN05OaXdUbERpbys5eVhvSlV4dWlMUTFLaWxld1dCUVp1?=
 =?utf-8?B?SER0a1haMGhqVFJWdFh5blIvWDd2RXF0WTJmZk9mUDBEOVJyMFdrRUpxMXFh?=
 =?utf-8?B?bjNSMldueDVQZklGcUF2bGhLSzVNZndUc05FZTBucHhVWlFERnVaRmhGVVda?=
 =?utf-8?B?M09VVU9rS01DakRVNmZKd2N5ZXdtRnhhdWV3VDNnZ2l3TW8xenJ0K3haQWlt?=
 =?utf-8?B?Sld3ZVIxZEFwdzF6ZU0zREVaZ002N0hlbjBIWUVIWjFzN3FKSmQyT0lPYTJv?=
 =?utf-8?B?aWV3ZEVMVm56Z3d4QWpucVJJZ1d6Ni9ESGtTVlFhMUYzWXN0Q0xOeHJDMlh2?=
 =?utf-8?B?aXpLbjdKVmZRVjFudjU5TlA3MG9QUVAyZkhpWG5HODZtd0tnYmhPenNRSDlB?=
 =?utf-8?B?MzVFNUxBOHNTVXRiSVRwZm5VU05sU3kzbWVzdnhnaDFpSGlGTE8weGM4T0tx?=
 =?utf-8?B?WFF3NGZWU2M2b2oyeks2cGZmS1JTU254Qi9STUhvZHhZMzR1dWZFUGdRR1ky?=
 =?utf-8?B?RUliV2lucWhTWjRZYUVCNUVIWlI5V040cXQ1T0hPUFdGMlNCeUxzU1ZGekQ2?=
 =?utf-8?B?NzUzYzlrVUVVbWRrYVJzTUxnV2Y3eGQ1VDVjcGFCd2dKV1kyN2srOThoTFcx?=
 =?utf-8?B?RGNac2REREhxL3RqdHVaWExZZE5CM3lpeEJmelllYjRyYzdkc3llY0NKa2Jp?=
 =?utf-8?B?M3Y2V09zeDZrbHhWYjcxTDRzUnRWSkdDcU4vVnhoMXhoZkxOYnIxbTZQSVlW?=
 =?utf-8?Q?QwrpSX+BWhkU2wAdBXOuVUZRA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5653.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ca8e1c-1a42-4b07-b559-08dc7d2ec621
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2024 02:51:42.5458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBWNl6EDPgxXNaTlNEqBi2hBA+JEkjwLznJcqHFDPuLrTU9UQPeWyrhUi8oGyDtyVaWTMm7O0Z4PTuK3WtT62A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6673

RGVhciAgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcsDQoNCkknbSB2ZXJ5IHNvcnJ5IGZvciB0
aGUgdHJvdWJsZSwgaGVyZSdzIHRoZSB1cGRhdGU6DQoNCkZyb20gZjAzM2VmMGJmYjI5Y2Q0MTNk
MTBhYmE4NjBjZThkMTc4Y2MzMTRlMiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDENCkZyb206IE1l
bmdxaSBaaGFuZyA8bWFpbHRvOm1lbmdxaS56aGFuZ0BtZWRpYXRlay5jb20+DQpEYXRlOiBNb24s
IDI1IERlYyAyMDIzIDE3OjM4OjQwICswODAwDQpTdWJqZWN0OiBbUEFUQ0hdIG1tYzogY29yZTog
QWRkIEhTNDAwIHR1bmluZyBpbiBIUzQwMGVzIGluaXRpYWxpemF0aW9uDQoNCmNvbW1pdCA3N2Uw
MWI0OWUzNWYyNGViZDE2NTkwOTZkNWZjNWMzYjc1OTc1NTQ1IHVwc3RyZWFtDQoNCkR1cmluZyB0
aGUgaW5pdGlhbGl6YXRpb24gdG8gSFM0MDBlcyBzdGFnZSwgYWRkIGEgSFM0MDAgdHVuaW5nIGZs
b3cgYXMgYW4gb3B0aW9uYWwgcHJvY2Vzcy4gRm9yIE1lZGlhdGVrIElQLCB0aGUgSFM0MDBlcyBt
b2RlIHJlcXVpcmVzIGEgc3BlY2lmaWMgdHVuaW5nIHRvIGVuc3VyZSB0aGUgY29ycmVjdCBIUzQw
MCB0aW1pbmcgc2V0dGluZy4NCg0KU2lnbmVkLW9mZi1ieTogTWVuZ3FpIFpoYW5nIDxtYWlsdG86
bWVuZ3FpLnpoYW5nQG1lZGlhdGVrLmNvbT4NCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyMzEyMjUwOTM4MzkuMjI5MzEtMi1tZW5ncWkuemhhbmdAbWVkaWF0ZWsuY29tDQpTaWdu
ZWQtb2ZmLWJ5OiBVbGYgSGFuc3NvbiA8bWFpbHRvOnVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQot
LS0NCsKgZHJpdmVycy9tbWMvY29yZS9tbWMuYyB8IDkgKysrKysrKy0tDQrCoDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMvY29yZS9tbWMuYyBpbmRleCBhNTY5MDY2
MzNkZGYuLmMxZWIyMmZkMDMzYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMN
CisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCkBAIC0xNzk5LDggKzE3OTksMTMgQEAgc3Rh
dGljIGludCBtbWNfaW5pdF9jYXJkKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwgdTMyIG9jciwNCsKg
DQrCoAkJaWYgKGVycikNCsKgCQkJZ290byBmcmVlX2NhcmQ7DQotDQotCX0gZWxzZSBpZiAoIW1t
Y19jYXJkX2hzNDAwZXMoY2FyZCkpIHsNCisJfSBlbHNlIGlmIChtbWNfY2FyZF9oczQwMGVzKGNh
cmQpKSB7DQorCQlpZiAoaG9zdC0+b3BzLT5leGVjdXRlX2hzNDAwX3R1bmluZykgew0KKwkJCWVy
ciA9IGhvc3QtPm9wcy0+ZXhlY3V0ZV9oczQwMF90dW5pbmcoaG9zdCwgY2FyZCk7DQorCQkJaWYg
KGVycikNCisJCQkJZ290byBmcmVlX2NhcmQ7DQorCQl9DQorCX0gZWxzZSB7DQrCoAkJLyogU2Vs
ZWN0IHRoZSBkZXNpcmVkIGJ1cyB3aWR0aCBvcHRpb25hbGx5ICovDQrCoAkJZXJyID0gbW1jX3Nl
bGVjdF9idXNfd2lkdGgoY2FyZCk7DQrCoAkJaWYgKGVyciA+IDAgJiYgbW1jX2NhcmRfaHMoY2Fy
ZCkpIHsNCi0tDQoNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpCZXN0
IFJlZ2FyZHMg77yBDQpHdWlsaW4g5qGC5p6XDQoNCuWPkeS7tuS6ujogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0NeaciDI05pelIDE0
OjU1DQrmlLbku7bkuro6IExpbiBHdWkgKOahguaelykgPExpbi5HdWlAbWVkaWF0ZWsuY29tPg0K
5oqE6YCBOiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBZb25nZG9uZyBaaGFuZyAo5byg5rC45Lic
KSA8WW9uZ2RvbmcuWmhhbmdAbWVkaWF0ZWsuY29tPjsgQm8gWWUgKOWPtuazoikgPEJvLlllQG1l
ZGlhdGVrLmNvbT47IFFpbGluIFRhbiAo6LCt6bqS6bqfKSA8UWlsaW4uVGFuQG1lZGlhdGVrLmNv
bT47IFdlbmJpbiBNZWkgKOaiheaWh+W9rCkgPFdlbmJpbi5NZWlAbWVkaWF0ZWsuY29tPjsgTWVu
Z3FpIFpoYW5nICjlvKDmoqbnkKYpIDxNZW5ncWkuWmhhbmdAbWVkaWF0ZWsuY29tPg0K5Li76aKY
OiBSZTog5Zue5aSNOiDlm57lpI06IOWbnuWkjTog5Zue5aSNOiBiYWNrcG9ydCBhIHBhdGNoIGZv
ciBMaW51eCBrZXJuZWwtNS4xNSBrZXJuZWwtNi4xIGtlbnJlbC02LjYgc3RhYmxlIHRyZWUNCg0K
DQpFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50
Lg0KDQpPbiBGcmksIE1heSAyNCwgMjAyNCBhdCAwNTo1ODozMkFNICswMDAwLCBMaW4gR3VpICjm
oYLmnpcpIHdyb3RlOg0KPiBEZWFyICBtYWlsdG86Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcs
DQo+IA0KPiBTb3JyeSwgdXBkYXRlIHRoZSBmb3JtYXQ6DQo+IFRoaXMgcGF0Y2ggaGFzIGJlZW4g
dGVzdGVkIG9uIE1lZGlhdGVrIFBob25lLCB0aGUgdGVzdCBwYXNzZWQsDQo+IFRoYW5rIHlvdQ0K
PiANCj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYyBiL2RyaXZl
cnMvbW1jL2NvcmUvbW1jLmMNCj4gaW5kZXggYTU2OTA2Ni4uZDY1Njk2NCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5j
DQo+IEBAIC0xODAwLDcgKzE4MDAsMTMgQEAgc3RhdGljIGludCBtbWNfaW5pdF9jYXJkKHN0cnVj
dCBtbWNfaG9zdCAqaG9zdCwgdTMyIG9jciwNCj4gIGlmIChlcnIpDQo+ICBnb3RvIGZyZWVfY2Fy
ZDsNCj4gIA0KPiAtfSBlbHNlIGlmICghbW1jX2NhcmRfaHM0MDBlcyhjYXJkKSkgew0KPiArfSBl
bHNlIGlmIChtbWNfY2FyZF9oczQwMGVzKGNhcmQpKXsNCj4gK2lmIChob3N0LT5vcHMtPmV4ZWN1
dGVfaHM0MDBfdHVuaW5nKSB7DQo+ICtlcnIgPSBob3N0LT5vcHMtPmV4ZWN1dGVfaHM0MDBfdHVu
aW5nKGhvc3QsIGNhcmQpOw0KPiAraWYgKGVycikNCj4gK2dvdG8gZnJlZV9jYXJkOw0KPiArfQ0K
PiArfSBlbHNlIHsNCj4gIC8qIFNlbGVjdCB0aGUgZGVzaXJlZCBidXMgd2lkdGggb3B0aW9uYWxs
eSAqLw0KPiAgZXJyID0gbW1jX3NlbGVjdF9idXNfd2lkdGgoY2FyZCk7DQo+ICBpZiAoZXJyID4g
MCAmJiBtbWNfY2FyZF9ocyhjYXJkKSkgew0KPiANCj4gDQoNCkFnYWluLCBwbGVhc2UgYXBwbHkg
dGhpcyB0byB0aGUgbGF0ZXN0IDUuMTUueSBrZXJuZWwgYW5kIHNlZSB3aGF0DQpoYXBwZW5zLiAg
SSBkbyBub3Qga25vdyB3aGF0IGtlcm5lbCB5b3UgYXJlIHVzaW5nLCBidXQgeW91IGtub3cgd2hh
dA0Ka2VybmVsIHdlIGFyZSB1c2luZyA6KQ0KDQp0aGFua3MsDQoNCmdyZWcgay1oDQo=

