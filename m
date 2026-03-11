Return-Path: <stable+bounces-224765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHQ9FS3csWlPFwAAu9opvQ
	(envelope-from <stable+bounces-224765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:18:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7426A5A5
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC01A3088239
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018334EEF9;
	Wed, 11 Mar 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qip2IUNl"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B562D2483;
	Wed, 11 Mar 2026 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263897; cv=fail; b=fWqlCM8lNjg0WkxB1gErTk+rcy4yM+rDhTHETWmI7xRe02suvrdealdOQO8+IeFXPvU6Ibr2xKl29+l7c6aZ+4ZCxXUJFz0DDDIpl8jRLyu76NNaC1/3l6w45D2oVAY7y9OxgqdZWjwjU4FHE8BW1QX3NCO+4jFr/LJY62uRm8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263897; c=relaxed/simple;
	bh=V/HNXMEoHEnTAHlA/dsiUGApbCIlAsAPHvDIs284txM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KAzAp559nV2+MwqiU1mf/0+xddgepO8iKPN1Wfyw1n0cT8/gkMihS4S423VJoIQH+7FgtoHAKKsDBvLXoaGh64V75jc7k6sL3VLgu0PFR8VZ54z/X/jEprtHodSYktjwEV6y5VtITMOppf4D4skVcDkqS7CEo3jaVXjbMxsGcoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qip2IUNl; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BGCkVQ3972987;
	Wed, 11 Mar 2026 21:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=V/HNXMEoHEnTAHlA/dsiUGApbCIlAsAPHvDIs284txM=; b=Qip2IUNl
	XfrAiBYMIAevwJNN2vU6gTFrP7kJQvizuroiuqiKGxUVjmTGtmZ1bkCtXKPLRu1e
	TwtBRXofQcba2Y4nu2hOUI4qKubq6pg+0HL7JRDPh2yHjAi90gIbJOS2mEuxbFVn
	EoUsnCeQcxG1UC7b6VYkBGKaFrQrWt4NszXwWxn6rh3K4H5NiqWMAobhfkNgiAP9
	qM5+F45r9c/1f72CYH4Df+XLuXLB3asNIy1HffAxmLK/n1tsV7DPOC432ElFJq5+
	45InmCKVaKXDlttTMFUazZ3ZGQlajmwtFOrfTG6Hos2kiedxak3HUY2cD8L3wqKR
	t09TclZv+AgVFQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywj0t6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 21:18:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9sCr4Fk4yUn9e3glalGAdMfuUBK5w33SpygkY+9f7yjDt8u/7FdhQr04yQ77PY+K0bW9LgvczKKCpPEA85gQIUm2BOUo0k3xvHxFeJBsz6V+h+3IQq/8Lsj+r1atxgqqc2wP25Hkl4NgptvKUXPxE+TDfrTHp/+8qfysU11pea05NtKVQZAY7LMElCLn84QIxxETfyZe/AnZY62QiERtKXDE5iJut5Zjueu6UlVZ+QSqrNJTNy6SE2Pd80h1EtIe7o2gDuLXQmmlDgFKCTjZ616FBQs5C1Y3843YjWMY8BFpCOoiXBWx17rGxSmZU2audSTA3wdsnKwuUSUtRDq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/HNXMEoHEnTAHlA/dsiUGApbCIlAsAPHvDIs284txM=;
 b=soeV94zEJYCzziS0hpdvkPVDg9vfKBX4ut5+8sbGtjEBxUW1o7FWMWxEGxEN5LBGc4ad6fCcPjvmO/cgv6SoC/59adRTQ6GFYa0VKh9nZES1wEuxzPagmYySL69ddZxrh7kOez9zmc/sja8PRoSoB9W2kkeubEXr6Gh6W6tBDMCTEsZFkI8zyYGWBOAjl1ZRP5BS0ZlTNlVGTWeqhs/zvDc6aJF6ZuQhmaDOc2DqlHU202JDODqRTNLQeEwIDjsw48VlKtv37f70h6j1a/a0PzML/rEAvmywRJxuu+4tLJaRlZ8+viy8t378g3ApfQAhN0syQPsB+d46GSznMOgCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com (2603:10b6:a03:4e4::8)
 by DM6PR15MB3976.namprd15.prod.outlook.com (2603:10b6:5:2b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Wed, 11 Mar
 2026 21:18:00 +0000
Received: from SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f]) by SJ0PR15MB5821.namprd15.prod.outlook.com
 ([fe80::7a72:f65e:b0be:f93f%4]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 21:18:00 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        "zilin@seu.edu.cn"
	<zilin@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "sougata@tuxera.com" <sougata@tuxera.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] hfsplus: fix held lock freed on
 hfsplus_fill_super()
Thread-Index: AQHcsUxvpv/eyTBvdkG6lYxkShnD2bWp1ngA
Date: Wed, 11 Mar 2026 21:17:59 +0000
Message-ID: <afab59a14da6ee4dd23d8ef85301ccff451b87cb.camel@ibm.com>
References: <20260311114336.155482-1-zilin@seu.edu.cn>
In-Reply-To: <20260311114336.155482-1-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR15MB5821:EE_|DM6PR15MB3976:EE_
x-ms-office365-filtering-correlation-id: ac881700-ea51-4138-ab28-08de7fb3ac52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|7416014|366016|1800799024|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Aqp2q8i58rtTdFNgelqaC7mUkMzaFs87JzGSJsAbjwEVqlhf4XYSEZySzy5Dr4arggj8OLJj+uX0C1EDgi7/SLf2xvdVT+Dvjm7Vq+JeEyc5sJ02vKy1LgT/YXg3GsUMesLg5vuwF5KhLggCtCfw17q5mM93a2cRDCOw4PUClhUcx24H4qaj7W144CzhQ/b8WPK//c6oO+RXJugoIaWhqIrsBNuit/TSAKUtDoJScKmFa8DunO78tTvQsWsfpixyxIHB6AAoekEy/GfhiYKFffKbKTBijsniMvirSIHcASvzKSvJvUXH94T6d9/HJFPsoL77YqS7tArwB28tnVIr4naAyS53pgVbEdpv3i8wVkJ1weGC0WNFec98TOnnKFZrzjwWK7GCuf2LCTtD01VyXU+DUST6Lv0gWaBh0KmgXKxbKk7YgXgaE2CGf+6pv3Ky64V0fggA6n8ldPlxFY7tRyFitd1Htsb7yFN7h2sf8OssYJSgFA7c52IVh/8rxvSLbXM0NHwMfckttx2N8x1nVkJe1NGvsLx8OeTs4Zq6QbzROk+Mi9vdlXjEghDalMzieYKhGSolNPdbVti5eB1quhQwe72KHHCPKZp4FCb8TgY87h/TV3S6dLGKlaE7vMbHJTa7sGJ71quZCRJ4ON4UXPgnraH73mpHNscAoDNC2FIY1Ddzyg3GA0UiFPWmP2X5HtDHhIbUQw9amE/SRvWo73iwFktGE8UrjIe5Pe7IZy5SZqPVtnxqj76XHyvZlJeI5aXnERJtiihDp31yZeN9W+uijpnezR38mC3ZvO8EecU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5821.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bi80Ui9TcXk2UEYzZ0R1dDZKUE42YXRJR20xZkJaaGErQktmSXl5em9YTmJs?=
 =?utf-8?B?eUUwQmt6SEVVMkhXWCsyTWNlTlo4OXRqaXgrbENyRGIyZ1ZQTnpLZ0dqVjdC?=
 =?utf-8?B?bSs5YlNzd05OTEVtUU82MEJORVNyUW1ocXdUQmhMb0JMekZNZ2d1WXB4VDB3?=
 =?utf-8?B?QVgxcTNRakNOSTBTc0xKRnozb0VST1YvUTV2Uzl4NXZvSktoN0pmZjdDdEZi?=
 =?utf-8?B?U0xUcW9vczVrTEx0aUJoM013UVpJa000d0JORWZmR3BWSGVPdXcrZVI2d3ZC?=
 =?utf-8?B?ajdZb3pNeTloUFh2Y090WVA4U3MvdHk1Q3pyN0ErM09zRnpBcGtLSkNqMVBL?=
 =?utf-8?B?MkFmVXBoUTQ3ZXlXd3JDNUE2T2ZYRkNwbXZ6T2tQWmdGbjV4WkR3cDZZZ21o?=
 =?utf-8?B?S3FRbWx1QVNFUFhhUHo2YWx5QVE0NkVPNVBnTDRXMEd4elFHa1NLcm51cmJU?=
 =?utf-8?B?Z09yQ1NxSGlIN2g2N3hyMU5ENVZ6OUZBK1FmeStnRjdZaFJTU25VaGpsRnNI?=
 =?utf-8?B?WWdMMzhyWUwwWWMyTjNMK2x4V1dpL09zU29Xc1VCQzdrM1ozN3ZRVzVPQlVZ?=
 =?utf-8?B?MUtXa1ZYNklPMGFJczVzTUtPekNVV2Y4QzFldHplR3pjbXZuS3lOUGd1cGY3?=
 =?utf-8?B?LzFZMitzdjRNbnErZTNkeG4rNGZ6S1d1Q1RDekcrRzVaWG8rQlJLM3J1TEtn?=
 =?utf-8?B?Q1BhRnpkUWVJUTRwSWR3NXBqNDlnZzF3bDlkYyszZGxkYmtkTittTWhsMXVr?=
 =?utf-8?B?elhwTS9tNkY1b3VGbjdPenFQMDdsaDM5TmJLUlhZMkRQQ2k5dHRuSDd2cWVI?=
 =?utf-8?B?WnFKY1gySDVvQUxPQkc4SEs1eVhaWjhPWHJqdlZXTDR6bG1ucXVYWUV3YjZG?=
 =?utf-8?B?NXhzNUhmR21MSTVwclVsRDVvYTN4ZWRhVER1UnlyYmpmUThFSmo5dnVsc2Iw?=
 =?utf-8?B?V0ZkUzc4Z3NaNE1oY1FObklqaGwrQ0VkM2h4Z291ZHNla3JYQU8xL3dFTGtu?=
 =?utf-8?B?ZkJoTEFMcXpMR3dHbklNNmZSTFpHUSt0UGtYNk1ucDIyUUcvRHRUSHFFejdS?=
 =?utf-8?B?dVF5UEhmTWNSRVRxeHE1anVPWitIUkk0OE1iZk1TOUZ1UWVvQ2VxZElEWGtI?=
 =?utf-8?B?bkpYNUdFQThEZUR1Tyt3bXAvdHJQaktWRC95bi83cnIzaHFIUE93RTdKazh0?=
 =?utf-8?B?eVd3SUh5aC9QMFNIQVBBVEJGTENtdFVDcU90eWp5UllIMVhZU1dPRGxxYU5x?=
 =?utf-8?B?TUdTOVV3ejdGdVFRS1YycTZueHJJb2RHSW1xVmJ4eEtMWHpDejhMc0hEMFBt?=
 =?utf-8?B?TStBWjVsOEZGU24wVmoxZU92ZEFXQ3I1SDRobk1xcUx5RVR0MzE3K0RmVjhT?=
 =?utf-8?B?ckt1LzFxWjVXT0h2OGpmNmNVeVZKSXJCcXVDWERwVnZTbGFVb0ZCTE9kOXpV?=
 =?utf-8?B?TmN1N2F5NytYZ1poUHNadGJ2NWh1ZlZpd0VIMmFlZnE4SVc1RXk3S1VkNCtF?=
 =?utf-8?B?aHc3SURaWFhaTjRmVzZvcmFVOElQS1NvcHhRZTJVb0pwTWMzS1ZwUjlZdGFx?=
 =?utf-8?B?eGNQaE0zb1NFQzVIU0lCWG5MS1NqdDFoNDQ5c2xYV2dVSGJBWkx4TWpHK24r?=
 =?utf-8?B?TlFSZ2FsZUlQa1pqcFN5bVgyWEt2YVlYY0FTRTczbmEzMys0YVVLVmxMdTFG?=
 =?utf-8?B?R08zVW1LSUlkVC9UYUZyanVLQm5XUlhYdG40VmNoQldCVzV2R1N2bHZzSkRD?=
 =?utf-8?B?NkNaald6VktoU2dvWW5jekkxMk0yWEc4cG9vN0l5M2RSTyszM2NGR0p4dDBq?=
 =?utf-8?B?Ty9wMmt1SlJPMWV0MWc4aUFDdlljcHpaSWdDeXRJVmFzTEVKVkp1TTNSYUIy?=
 =?utf-8?B?VXRYcW43cGc5UWR5UlQ5UW45VnVsTVp2YklZUTVCVEp1ZGNiTEFpcGtEejZk?=
 =?utf-8?B?WjEydWszdkdtUnJsd05OazBLK0dEYlI5VXVJUFlIUkNDTGhqWVBZd0dBMldQ?=
 =?utf-8?B?L1Qxd2FKSG5tT2NiMDJlQVJCdTBkVWcrdCtmWVF5YTlONU9rSVQvTlRJUlc5?=
 =?utf-8?B?eG5FK3AxM25FdjRmN1BCdjZEenFaWFZ4bzZhUEk0Y2FwcWQyT1QxenRNT3k1?=
 =?utf-8?B?V3BuTi9JQjk1eXo4djNsSnJBa0lvZlJmSytyOVovQW8rZmNCQWJrTEZCTnNK?=
 =?utf-8?B?Y08waldLWmVJZEVpQzJaWFRBRnhOSGZvZDlEUVBGeFhIM3Jrd24rT3VBMW8v?=
 =?utf-8?B?N0VIZDRDMlJNTkpPUkVBeDlnb0p1UW5Kd3VmYTZhRWdCUCtjUWQvT3I4M3V2?=
 =?utf-8?B?d1g0ZVk1Tm54TS85YWMvSXdIbEZrNVl4SDdYRHpjSkY2VEppQzlQWkdoTklo?=
 =?utf-8?Q?K9f+71BW2gxCDeQYDB8Gj2aFZ+PBakJkdvu9E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D468B999B98834BB65A5C0A72D4ADCA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	hlEivwGp0jVX4ivF1WQuSE9onxwleOzTATKEy8NlVhRBBBYA49fLqQK3LYgKaSVbQ80MO/4BK5nMwlU5+DPh+vS07XaDoJ+UyqMj0U0SyUW+sjKQH2qhJkLOF/bTXiV1ez56h25epohRdcUtzRM4iifaeXF5xUKzMpjJ72JKi5/Iy7scjTkRw5PeeK1ieUwCBWM5LSrjCEFqr/KQ14COmHIQ9LvTetNuDjBo971z6rE7Med1wptnPunTOSFIDbe7oaUuShWW/9r3coKGCMNs5X4gAz1DiFUTBAzVhValcVJYUzns20BzBjt6rna3LijgP/hNSTRvCirKhhcCYiVROw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5821.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac881700-ea51-4138-ab28-08de7fb3ac52
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 21:17:59.9505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d9scZ5bKCEL1DYVjQm/h3hP0xEkFXUZSZ7NSSO5ciLJmpCtC4K0OTT17w2iYyJXa3J1uGKpLxc5jiZIZe0Hm5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3976
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE3OSBTYWx0ZWRfXx+uVZiBxCIRT
 qd1XPfqaOOtA16rCa0ral1I5KVd1lKNIra4f5XHlqttzcBJXXDj8pmE8Gqxrm9vZgG/PcMHi/QA
 /CzYCtlEPSy1zevOy4e+QiczCdS7OYaCuX5/VDaA4S63QCyvlpx3GHX5iOrWqeUXR6UnSWvccoW
 o3qwGt9QVPmcexb7KEymER1Bjle0lF60XxSPQTYbsr9NV02Ftnb7QQ4c6bVjiqzTqUgfMLBWsN3
 S8B+WH/55UQbtrkrvQqdMtG0vgYs1AiYZyQZQ0nnMO6ADe7u58H+xbOxog36yciugwaDbit0gqX
 jLExCk+r/AsX1SL/6hy7hK1UO2cRsOa5THJFFcejGtKyGSPF9bVMqZ094FLA8thXCBzRP75vz8c
 iQNGGBHOJ+M4pw5sPfitgkFpaCgqVDTn7pD0YvfzlQLYVQTKkdubqUH+WCwKWX9RIgGN4TBusXq
 XGgHpYfpX7cYcgryCNw==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b1dc0a cx=c_pps
 a=PxsVn2hUj41VgPYomOKOQg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=wCmvBT1CAAAA:8
 a=8yh27InZiaRvzKv88woA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: gRNZsnkFE0rwqBQJVMrk8OQqCC87iJ1Y
X-Proofpoint-ORIG-GUID: gRNZsnkFE0rwqBQJVMrk8OQqCC87iJ1Y
Subject: Re:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110179
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224765-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BEA7426A5A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCAyMDI2LTAzLTExIGF0IDE5OjQzICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBo
ZnNwbHVzX2ZpbGxfc3VwZXIoKSBjYWxscyBoZnNfZmluZF9pbml0KCkgdG8gaW5pdGlhbGl6ZSBh
IHNlYXJjaA0KPiBzdHJ1Y3R1cmUsIHdoaWNoIGFjcXVpcmVzIHRyZWUtPnRyZWVfbG9jay4gSWYg
dGhlIHN1YnNlcXVlbnQgY2FsbCB0bw0KPiBoZnNwbHVzX2NhdF9idWlsZF9rZXkoKSBmYWlscywg
dGhlIGZ1bmN0aW9uIGp1bXBzIHRvIHRoZSBvdXRfcHV0X3Jvb3QNCj4gZXJyb3IgbGFiZWwgd2l0
aG91dCByZWxlYXNpbmcgdGhlIGxvY2suIFRoZSBsYXRlciBjbGVhbnVwIHBhdGggdGhlbg0KPiBm
cmVlcyB0aGUgdHJlZSBkYXRhIHN0cnVjdHVyZSB3aXRoIHRoZSBsb2NrIHN0aWxsIGhlbGQsIHRy
aWdnZXJpbmcgYQ0KPiBoZWxkIGxvY2sgZnJlZWQgd2FybmluZy4NCj4gDQo+IEZpeCB0aGlzIGJ5
IGFkZGluZyB0aGUgbWlzc2luZyBoZnNfZmluZF9leGl0KCZmZCkgY2FsbCBiZWZvcmUganVtcGlu
Zw0KPiB0byB0aGUgb3V0X3B1dF9yb290IGVycm9yIGxhYmVsLiBUaGlzIGVuc3VyZXMgdGhhdCB0
cmVlLT50cmVlX2xvY2sgaXMNCj4gcHJvcGVybHkgcmVsZWFzZWQgb24gdGhlIGVycm9yIHBhdGgu
DQo+IA0KPiBUaGUgYnVnIHdhcyBvcmlnaW5hbGx5IGRldGVjdGVkIG9uIHY2LjEzLXJjMSB1c2lu
ZyBhbiBleHBlcmltZW50YWwNCj4gc3RhdGljIGFuYWx5c2lzIHRvb2wgd2UgYXJlIGRldmVsb3Bp
bmcsIGFuZCB3ZSBoYXZlIHZlcmlmaWVkIHRoYXQgdGhlDQo+IGlzc3VlIHBlcnNpc3RzIGluIHRo
ZSBsYXRlc3QgbWFpbmxpbmUga2VybmVsLiBUaGUgdG9vbCBpcyBzcGVjaWZpY2FsbHkNCj4gZGVz
aWduZWQgdG8gZGV0ZWN0IG1lbW9yeSBtYW5hZ2VtZW50IGlzc3Vlcy4gSXQgaXMgY3VycmVudGx5
IHVuZGVyIGFjdGl2ZQ0KPiBkZXZlbG9wbWVudCBhbmQgbm90IHlldCBwdWJsaWNseSBhdmFpbGFi
bGUuDQo+IA0KPiBXZSBjb25maXJtZWQgdGhlIGJ1ZyBieSBydW50aW1lIHRlc3RpbmcgdW5kZXIg
UUVNVSB3aXRoIHg4Nl82NCBkZWZjb25maWcsDQo+IGxvY2tkZXAgZW5hYmxlZCwgYW5kIENPTkZJ
R19IRlNQTFVTX0ZTPXkuIFRvIHRyaWdnZXIgdGhlIGVycm9yIHBhdGgsIHdlDQo+IHVzZWQgR0RC
IHRvIGR5bmFtaWNhbGx5IHNocmluayB0aGUgbWF4X3VuaXN0cl9sZW4gcGFyYW1ldGVyIHRvIDEg
YmVmb3JlDQo+IGhmc3BsdXNfYXNjMnVuaSgpIGlzIGNhbGxlZC4gVGhpcyBmb3JjZXMgaGZzcGx1
c19hc2MydW5pKCkgdG8gbmF0dXJhbGx5DQo+IHJldHVybiAtRU5BTUVUT09MT05HLCB3aGljaCBw
cm9wYWdhdGVzIHRvIGhmc3BsdXNfY2F0X2J1aWxkX2tleSgpIGFuZA0KPiBleGVyY2lzZXMgdGhl
IGZhdWx0eSBlcnJvciBwYXRoLiBUaGUgZm9sbG93aW5nIHdhcm5pbmcgd2FzIG9ic2VydmVkDQo+
IGR1cmluZyBtb3VudDoNCj4gDQo+IAk9PT09PT09PT09PT09PT09PT09PT09PT09DQo+IAlXQVJO
SU5HOiBoZWxkIGxvY2sgZnJlZWQhDQo+IAk3LjAuMC1yYzMtMDAwMTYtZ2I0ZjBkZDMxNGIzOSAj
NCBOb3QgdGFpbnRlZA0KPiAJLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAJbW91bnQvMTc0
IGlzIGZyZWVpbmcgbWVtb3J5IGZmZmY4ODgxMDNmOTIwMDAtZmZmZjg4ODEwM2Y5MmZmZiwgd2l0
aCBhIGxvY2sgc3RpbGwgaGVsZCB0aGVyZSENCj4gCWZmZmY4ODgxMDNmOTIwYjAgKCZ0cmVlLT50
cmVlX2xvY2speysuKy59LXs0OjR9LCBhdDogaGZzcGx1c19maW5kX2luaXQrMHgxNTQvMHgxZTAN
Cj4gCTIgbG9ja3MgaGVsZCBieSBtb3VudC8xNzQ6DQo+IAkjMDogZmZmZjg4ODEwM2Y5NjBlMCAo
JnR5cGUtPnNfdW1vdW50X2tleSM0Mi8xKXsrLisufS17NDo0fSwgYXQ6IGFsbG9jX3N1cGVyLmNv
bnN0cHJvcC4wKzB4MTY3LzB4YTQwDQo+IAkjMTogZmZmZjg4ODEwM2Y5MjBiMCAoJnRyZWUtPnRy
ZWVfbG9jayl7Ky4rLn0tezQ6NH0sIGF0OiBoZnNwbHVzX2ZpbmRfaW5pdCsweDE1NC8weDFlMA0K
PiANCj4gCXN0YWNrIGJhY2t0cmFjZToNCj4gCUNQVTogMiBVSUQ6IDAgUElEOiAxNzQgQ29tbTog
bW91bnQgTm90IHRhaW50ZWQgNy4wLjAtcmMzLTAwMDE2LWdiNGYwZGQzMTRiMzkgIzQgUFJFRU1Q
VChsYXp5KQ0KPiAJSGFyZHdhcmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwg
MjAwOSksIEJJT1MgMS4xNS4wLTEgMDQvMDEvMjAxNA0KPiAJQ2FsbCBUcmFjZToNCj4gCTxUQVNL
Pg0KPiAJZHVtcF9zdGFja19sdmwrMHg4Mi8weGQwDQo+IAlkZWJ1Z19jaGVja19ub19sb2Nrc19m
cmVlZCsweDEzYS8weDE4MA0KPiAJa2ZyZWUrMHgxNmIvMHg1MTANCj4gCT8gaGZzcGx1c19maWxs
X3N1cGVyKzB4Y2I0LzB4MThhMA0KPiAJaGZzcGx1c19maWxsX3N1cGVyKzB4Y2I0LzB4MThhMA0K
PiAJPyBfX3BmeF9oZnNwbHVzX2ZpbGxfc3VwZXIrMHgxMC8weDEwDQo+IAk/IHNyc29fcmV0dXJu
X3RodW5rKzB4NS8weDVmDQo+IAk/IGJkZXZfb3BlbisweDY1Zi8weGMzMA0KPiAJPyBzcnNvX3Jl
dHVybl90aHVuaysweDUvMHg1Zg0KPiAJPyBwb2ludGVyKzB4NGNlLzB4YmYwDQo+IAk/IHRyYWNl
X2NvbnRlbnRpb25fZW5kKzB4MTFjLzB4MTUwDQo+IAk/IF9fcGZ4X3BvaW50ZXIrMHgxMC8weDEw
DQo+IAk/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmDQo+IAk/IGJkZXZfb3BlbisweDc5Yi8w
eGMzMA0KPiAJPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KPiAJPyBzcnNvX3JldHVybl90
aHVuaysweDUvMHg1Zg0KPiAJPyB2c25wcmludGYrMHg2ZGEvMHgxMjcwDQo+IAk/IHNyc29fcmV0
dXJuX3RodW5rKzB4NS8weDVmDQo+IAk/IF9fbXV0ZXhfdW5sb2NrX3Nsb3dwYXRoKzB4MTU3LzB4
NzQwDQo+IAk/IF9fcGZ4X3ZzbnByaW50ZisweDEwLzB4MTANCj4gCT8gc3Jzb19yZXR1cm5fdGh1
bmsrMHg1LzB4NWYNCj4gCT8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1LzB4NWYNCj4gCT8gbWFya19o
ZWxkX2xvY2tzKzB4NDkvMHg4MA0KPiAJPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KPiAJ
PyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KPiAJPyBpcnFlbnRyeV9leGl0KzB4MTdiLzB4
NWUwDQo+IAk/IHRyYWNlX2lycV9kaXNhYmxlLmNvbnN0cHJvcC4wKzB4MTE2LzB4MTUwDQo+IAk/
IF9fcGZ4X2hmc3BsdXNfZmlsbF9zdXBlcisweDEwLzB4MTANCj4gCT8gX19wZnhfaGZzcGx1c19m
aWxsX3N1cGVyKzB4MTAvMHgxMA0KPiAJZ2V0X3RyZWVfYmRldl9mbGFncysweDMwMi8weDU4MA0K
PiAJPyBfX3BmeF9nZXRfdHJlZV9iZGV2X2ZsYWdzKzB4MTAvMHgxMA0KPiAJPyB2ZnNfcGFyc2Vf
ZnNfcXN0cisweDEyOS8weDFhMA0KPiAJPyBfX3BmeF92ZnNfcGFyc2VfZnNfcXN0cisweDMvMHgx
MA0KPiAJdmZzX2dldF90cmVlKzB4ODkvMHgzMjANCj4gCWZjX21vdW50KzB4MTAvMHgxZDANCj4g
CXBhdGhfbW91bnQrMHg1YzUvMHgyMWMwDQo+IAk/IF9fcGZ4X3BhdGhfbW91bnQrMHgxMC8weDEw
DQo+IAk/IHRyYWNlX2lycV9lbmFibGUuY29uc3Rwcm9wLjArMHgxMTYvMHgxNTANCj4gCT8gdHJh
Y2VfaXJxX2VuYWJsZS5jb25zdHByb3AuMCsweDExNi8weDE1MA0KPiAJPyBzcnNvX3JldHVybl90
aHVuaysweDUvMHg1Zg0KPiAJPyBzcnNvX3JldHVybl90aHVuaysweDUvMHg1Zg0KPiAJPyBrbWVt
X2NhY2hlX2ZyZWUrMHgzMDcvMHg1NDANCj4gCT8gdXNlcl9wYXRoX2F0KzB4NTEvMHg2MA0KPiAJ
PyBfX3g2NF9zeXNfbW91bnQrMHgyMTIvMHgyODANCj4gCT8gc3Jzb19yZXR1cm5fdGh1bmsrMHg1
LzB4NWYNCj4gCV9feDY0X3N5c19tb3VudCsweDIxMi8weDI4MA0KPiAJPyBfX3BmeF9fX3g2NF9z
eXNfbW91bnQrMHgxMC8weDEwDQo+IAk/IHNyc29fcmV0dXJuX3RodW5rKzB4NS8weDVmDQo+IAk/
IHRyYWNlX2lycV9lbmFibGUuY29uc3Rwcm9wLjArMHgxMTYvMHgxNTANCj4gCT8gc3Jzb19yZXR1
cm5fdGh1bmsrMHg1LzB4NWYNCj4gCWRvX3N5c2NhbGxfNjQrMHgxMTEvMHg2ODANCj4gCWVudHJ5
X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3LzB4N2YNCj4gCVJJUDogMDAzMzoweDdmZmFj
YWQ1NWVhZQ0KPiAJQ29kZTogNDggOGIgMGQgODUgMWYgMGYgMDAgZjcgZDggNjQgODkgMDEgNDgg
ODMgYzggZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgOTAgZjMgMGYgMWUgZmEg
NDkgODkgY2EgYjggYTUgMDAgMDAgOA0KPiAJUlNQOiAwMDJiOjAwMDA3ZmZmMWFiNTU3MTggRUZM
QUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDBhNQ0KPiAJUkFYOiBmZmZmZmZm
ZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDA3ZmZhY2FkNTVlYWUNCj4g
CVJEWDogMDAwMDU1NzQwYzY0ZTViMCBSU0k6IDAwMDA1NTc0MGM2NGU2MzAgUkRJOiAwMDAwNTU3
NDBjNjUxYWIwDQo+IAlSQlA6IDAwMDA1NTc0MGM2NGUzODAgUjA4OiAwMDAwMDAwMDAwMDAwMDAw
IFIwOTogMDAwMDAwMDAwMDAwMDAwMQ0KPiAJUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAw
MDAwMDAwMDAwMDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDANCj4gCVIxMzogMDAwMDU1NzQwYzY0
ZTViMCBSMTQ6IDAwMDA1NTc0MGM2NTFhYjAgUjE1OiAwMDAwNTU3NDBjNjRlMzgwDQo+IAk8L1RB
U0s+DQo+IA0KPiBBZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLCB0aGUgd2FybmluZyBubyBsb25n
ZXIgYXBwZWFycy4NCj4gDQo+IEZpeGVzOiA4OWFjOWI0ZDNkMWEgKCJoZnNwbHVzOiBmaXggbG9u
Z25hbWUgaGFuZGxpbmciKQ0KPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQt
b2ZmLWJ5OiBaaWxpbiBHdWFuIDx6aWxpbkBzZXUuZWR1LmNuPg0KPiAtLS0NCj4gIGZzL2hmc3Bs
dXMvc3VwZXIuYyB8IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvc3VwZXIuYyBiL2Zz
L2hmc3BsdXMvc3VwZXIuYw0KPiBpbmRleCA3MjI5YThhZTg5ZjkuLmYzOTZmZWUxOWFiOCAxMDA2
NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9zdXBlci5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvc3VwZXIu
Yw0KPiBAQCAtNTY5LDggKzU2OSwxMCBAQCBzdGF0aWMgaW50IGhmc3BsdXNfZmlsbF9zdXBlcihz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZnNfY29udGV4dCAqZmMpDQo+ICAJaWYgKGVy
cikNCj4gIAkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+ICAJZXJyID0gaGZzcGx1c19jYXRfYnVpbGRf
a2V5KHNiLCBmZC5zZWFyY2hfa2V5LCBIRlNQTFVTX1JPT1RfQ05JRCwgJnN0cik7DQo+IC0JaWYg
KHVubGlrZWx5KGVyciA8IDApKQ0KPiArCWlmICh1bmxpa2VseShlcnIgPCAwKSkgew0KPiArCQlo
ZnNfZmluZF9leGl0KCZmZCk7DQo+ICAJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiArCX0NCj4gIAlp
ZiAoIWhmc19icmVjX3JlYWQoJmZkLCAmZW50cnksIHNpemVvZihlbnRyeSkpKSB7DQo+ICAJCWhm
c19maW5kX2V4aXQoJmZkKTsNCj4gIAkJaWYgKGVudHJ5LnR5cGUgIT0gY3B1X3RvX2JlMTYoSEZT
UExVU19GT0xERVIpKSB7DQoNCk1ha2VzIHNlbnNlLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xh
diBEdWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCg0KRnJhbmtseSBzcGVha2luZywgSSB0aGlu
aywgcG90ZW50aWFsbHksIHdlIGNhbiBpbnRyb2R1Y2Ugc3RhdGljIGlubGluZSBmdW5jdGlvbg0K
Zm9yIHRoaXMgY29kZToNCg0KCXN0ci5sZW4gPSBzaXplb2YoSEZTUF9ISURERU5ESVJfTkFNRSkg
LSAxOw0KCXN0ci5uYW1lID0gSEZTUF9ISURERU5ESVJfTkFNRTsNCgllcnIgPSBoZnNfZmluZF9p
bml0KHNiaS0+Y2F0X3RyZWUsICZmZCk7DQoJaWYgKGVycikNCgkJZ290byBvdXRfcHV0X3Jvb3Q7
DQoJZXJyID0gaGZzcGx1c19jYXRfYnVpbGRfa2V5KHNiLCBmZC5zZWFyY2hfa2V5LCBIRlNQTFVT
X1JPT1RfQ05JRCwNCiZzdHIpOw0KCWlmICh1bmxpa2VseShlcnIgPCAwKSkNCgkJZ290byBvdXRf
cHV0X3Jvb3Q7DQoJaWYgKCFoZnNfYnJlY19yZWFkKCZmZCwgJmVudHJ5LCBzaXplb2YoZW50cnkp
KSkgew0KCQloZnNfZmluZF9leGl0KCZmZCk7DQoJCWlmIChlbnRyeS50eXBlICE9IGNwdV90b19i
ZTE2KEhGU1BMVVNfRk9MREVSKSkgew0KCQkJZXJyID0gLUVJTzsNCgkJCWdvdG8gb3V0X3B1dF9y
b290Ow0KCQl9DQoJCWlub2RlID0gaGZzcGx1c19pZ2V0KHNiLCBiZTMyX3RvX2NwdShlbnRyeS5m
b2xkZXIuaWQpKTsNCgkJaWYgKElTX0VSUihpbm9kZSkpIHsNCgkJCWVyciA9IFBUUl9FUlIoaW5v
ZGUpOw0KCQkJZ290byBvdXRfcHV0X3Jvb3Q7DQoJCX0NCgkJc2JpLT5oaWRkZW5fZGlyID0gaW5v
ZGU7DQoJfSBlbHNlDQoJCWhmc19maW5kX2V4aXQoJmZkKTsNCg0KQmVjYXVzZSwgaGlkaW5nIHRo
aXMgY29kZSBpbnRvIHNtYWxsIGZ1bmN0aW9uIHdpbGwgcHJvdmlkZSBvcHBvcnR1bml0eSB0byBj
YWxsDQpoZnNfZmluZF9leGl0KCkgaW4gb25lIHBsYWNlIG9ubHkgKGFzIGZvciBub3JtYWwgYXMg
Zm9yIGVycm9uZW91cyBmbG93KS4NCg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNClRoYW5rcywNClNs
YXZhLg0K

