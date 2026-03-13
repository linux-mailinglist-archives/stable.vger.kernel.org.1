Return-Path: <stable+bounces-225376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNG5ObRZtGklmQAAu9opvQ
	(envelope-from <stable+bounces-225376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:38:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F57288CF7
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 727D43023146
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BFF3DDDCA;
	Fri, 13 Mar 2026 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FfzhyQIh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDD3DF009;
	Fri, 13 Mar 2026 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773427117; cv=fail; b=NjUyl3X9XayG6umXPWI8ZqP6XXjJN0SId47nW+bQhciksdAsYratvOQ414/8g3foRJSLmadBgD92v1L0Kb8MIb7Mr2UlbkUJ55gEg7fKlhipalnUFVKQw9c6MEo67GvZ1r50Js1MgbhWUHpiPCwtX3dZ/o0q7WoT6Rwp0wFzHpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773427117; c=relaxed/simple;
	bh=gRIk/MbyhKk3D/sCQOWbIHDgWjrDpqLGfwBVXTQFQkM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=rRBk3fVcRk/Wsrv0LnD5yoiCOVf0mONF8zi5oxvyOJc5eqYfTuoWQhva3t0IoN8ud+3u0+AKhUUJgWpMA7gRjcSN2oUBJ8SbIbyDI2JsNOGupLmp9ESnji99m1fk7+IlZWzVRw/ABVnNwOSLsoXS7InShWjkbKQDW9mtWQRvGoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FfzhyQIh; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DIFE7X2544840;
	Fri, 13 Mar 2026 18:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=gRIk/MbyhKk3D/sCQOWbIHDgWjrDpqLGfwBVXTQFQkM=; b=FfzhyQIh
	W7frcGOiIt+xNXuyinBPU5nXb1gYYsuq4xI6nFAXQ1lHsBD2heHQ7h1zL10BuUdg
	rFHymW6qDaMoRMFcjw6LHEx7rneXCqAPqdHD445se+YRUXAhyTbUoyVkYBnEdo5R
	XPjbIHQKUVXagEyuk0v+3HcWuZiSp1gj4w+cF2UL4/MwWWZrhIUdoEnKvnpTugeb
	Tf+QKd5cBq2mF63sak+OUGgtW9fymWa1h+A4G29mIBPmf3PE3AlgXLVgHFYffKsc
	778UyK0KYqem8rxyD9bAc/wXzUbLENwkMakhQvZbYwQcfQOTw1rWrbsAJZ678hgk
	j737NM1FvJEgKg==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011027.outbound.protection.outlook.com [52.101.62.27])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh98gxe6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 18:38:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQYAZUmRuW2HA261lk5cj9wJKC1fprle5V91fMUvYZc71mTX/d0MIE1w7ZKt1GP0AP5Nh1Y3Ndb64G3FiWZl7o/hY3vyhE5Wu0YuCV33kahRYsFdfoNNB73qEe0WAJ+WwoiyHWSX1KDmwEAs4R8nhxCJQpWBlLPdhOJOunPLKOeV106EStDX04NuM715weml3RUjDAXmn+snezW72EAPsFp0y5C9Jf+Tvptsou1dac0UFv5ECkpUKD+GogzxPSCHWVfRahhYH58p295zH0wcMEb/t0DbHBwtR6XyWzcNzwowsDvUQ1DZNPX4PeCxPCtajIhhCmpi00muPAb1pUSguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRIk/MbyhKk3D/sCQOWbIHDgWjrDpqLGfwBVXTQFQkM=;
 b=SfyXmVTPs7PxLl5I8ggaCvtqXpyJ68bywbvDLOCgl77U06BNyPT8DzLAdqx58PX+8WZLsQJabcbbOqxCSrgVDnQoel6UEydMU/nHpIV1a2UO+hN/PJKLCXRppou4sjMRtEuaSGaaZQ2oDCgDGgg/QqXbujxuwt2XaYFT8mEMLp6fpY755Gzz1p2bMVXKHrTEZFps8Nq6TQ52PwpSMdyJh639okg3CMl26keub8xIzWRVtr7XcVwNuWb+/zGyhrBSXM4jcIOy6SxY7i+FGB+qjhGPHfk2ldVtobbhN4fg1euW8kSl2RFaev64AaL4WbIdUsHLXnPDk7NvDDgeGtUvdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY1PR15MB6175.namprd15.prod.outlook.com (2603:10b6:a03:52c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 18:38:15 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Fri, 13 Mar 2026
 18:38:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "zilin@seu.edu.cn" <zilin@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
        "sougata@tuxera.com"
	<sougata@tuxera.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  [PATCH] hfsplus: fix held lock freed on
 hfsplus_fill_super()
Thread-Index: AQHcscZlUtL+PntFI0i7djFUt62CeLWrKgGAgACJzICAARm+gA==
Date: Fri, 13 Mar 2026 18:38:14 +0000
Message-ID: <74c78d0e14517ec28ad269113244562c081722a8.camel@ibm.com>
References: <77a8534a8b7922a1c0cf85f68fd8bda2bd7a61dc.camel@ibm.com>
	 <20260313014949.19178-1-zilin@seu.edu.cn>
In-Reply-To: <20260313014949.19178-1-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY1PR15MB6175:EE_
x-ms-office365-filtering-correlation-id: 943bd745-c9e6-4b0a-4038-08de812faff1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 G0S9XSuD4p5shCJS61E08pVPBL/O9OfHbTnMrP92jYzYvRW5Bn/OJjC1IGWeLnOCRnfuG5/2qcjs0ntlNPxFWzlcVHMzZmFRGwT4if+DTr1w76UVpqpjl1jLmXuIwHwGsuizBD47kDu/7ft1oqwXzNn7+gOgfdXypZtq1PJ3vVwU++xe6sLeEXvkFxzPyBJeTcG8hOGmq+6+mB47ASO75v5PxroTBKljgStAAmDCTFr2sy1nSj0mVkSa5M8/yQEsDWKafNRJi5NC0f4Gg4OyX/VBU9lUoS0En2jeZs3uUmA1UICozNhoAsVbGPSAJBsCoh9cpS66N+vH/yQUnd+QXu+A9jKRZIFbhtPoH10HNm4+tmBAK83+MS7uaMKqcH0eJygGnfTwA3G3gttQ9mNbqbJ19IJ6J6ee2u8euSWGQFRK8eZu15O3FcSd8/trjyTTcQO2B5VvPDMXWhvxtlf9/VsJpVgSp+uqKJuHfHfsEJygQ6snyHzWh9Qn5cbLt2q7uI5FqrKbY0bvblAsbTOTZG9603BPLEGMtXb1DWBJuAia0Cf2Ozcf+zjifp0XxYE9hMmnEdtvc/OKR/+87KdGqhvsoQXXuY0YQlQv7Wa+jtBsPB3pm+2k2fvKg90xX1vr95I4ggl0xxEml4nFSQ8ACQMOGqNdEbmXXkQ0AGAlJafYlSyEhLbPF5E3uK2QcsMM8fmJA03sdtYuFGjP7jUOjwbzOKzUNtHoqOp45zw03LkBJM3x4lzt7cX/egi4VScsNWHJYyUX69NtPdfkU24UME98cNUkhY0owgvYiq8g6G0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SlhNWWE2Vzk2VWtQeEovY1IxTXk1S3U1aEpDYXBIZWNYWjdDZnRjMWxuQ0JC?=
 =?utf-8?B?QXFJRVRtdzJqOGJ5Rmp5dk5aSjRCT1hBTVJuWGVoV2ZUbEcvb05xekFWTTM0?=
 =?utf-8?B?QTgxUUxPeXlYME1UZ0NpSkp4SVpBTUlQTFdGcnNwUU9EMmdQajFRWUg4Ky82?=
 =?utf-8?B?cENVU2drS1pnODlnSVV0VittWWtITGhmOGtybjh6QW1naG1Db0UxS1FvaHFx?=
 =?utf-8?B?ajA4WCtQSDg5dG1xMW1Nc1BZamtRcy9pbTRCSk9qSVZsOVpCNTc4aVJibGVV?=
 =?utf-8?B?cDRLYXpTZngwL2xHTlVFWGdBY1BOdnlqTXkxLzdIN1B0aWhvWmpvTUZBNTNt?=
 =?utf-8?B?cWFYQlZDYTFDV2pIVGhmZFFTREswSTA5OVFCYmlhaFViZlJOL3JnNi91Z2dl?=
 =?utf-8?B?ZFlzVHFnU2plRmRxUDNZZW9tSmE3S3NyY2F4dGRhNzA3YTVkV1o1SG9tVXpm?=
 =?utf-8?B?UTg4L1VQbE1HZnd5ZndhamVtY0o2K0JqMVZJR2lkSHBML01xSFJ3aG1PUjdz?=
 =?utf-8?B?Y3hNcTQwaEZYcXdPdnZwME5Pc05jRGZ5a3E0VC94WjZXQ1hpOCszRWEwTHc3?=
 =?utf-8?B?ZTc4WVhOOVM1UXA4R1pYUUFhUy8wSktuTU4zbFdOWU9EODFUTnc3VERTcXo5?=
 =?utf-8?B?bmlTVER6WnE0bThLRS8vMEpzNzFZSVBZSEN6bkEyS0NITmdJZDdiWUl4U0kv?=
 =?utf-8?B?SVBkVUFwVnZtQk1pVzdwRVR1M1NZdWt2aFAvSTliMHdpUTByZE9VTVJncDNQ?=
 =?utf-8?B?dm1ROVIvOGhmbjFHVUZsS3VkY1pYWEpBTDFya1Y4NXR2eDFhNVFVTkxHS1cy?=
 =?utf-8?B?SDhvVDhHcWN3MW1XcFFscnBObHhOTCtMZ3BMdW9DdnNyQXJxbTFpOUhjM0Fq?=
 =?utf-8?B?YXZIVkd4Z3NkUjg3Y0RqZysvNzgrakp2VlRjSGR0Q0h0b3VCK2JCMkpsNWl0?=
 =?utf-8?B?TnlzSE5FR3VWSDFTeEV6Z1BYb3Z5TEE5aE9LS21iVEMyNFNaamVERzRydDA1?=
 =?utf-8?B?dzFJWkVPZ0NmTUpCNmx2M3dRcHVUMTdxQUJRYTlpemlyRnhvOUJ3Y0tDaVJU?=
 =?utf-8?B?WTVuVmthNTJsc05hZjA1RnA2RU5TanBjZGx1VmZHY0REcHlSU2pyMGE4N3NH?=
 =?utf-8?B?cXFJS0dBT1RCcHpJVCtwL3YvVlRMUzNRejc2a0dRNzhkd1hZbDhyY0hORmVh?=
 =?utf-8?B?ZWRGNVNCRmhHSGJqNjYzMExIU21KQm5GNWtXL0JtQk9FWm85QU9LM3c0b2Vs?=
 =?utf-8?B?anUyRmF6bHhUNkw1QXU5MHU4OEdGYlVMWDZkU3JtcCs2anRMd0daVDUxdE9s?=
 =?utf-8?B?d2xqSDhHc3Y2RS9NZk4xVjViUXBDbmM2bUo1TDMyaks1ZE9hMFE5MGNlR1dP?=
 =?utf-8?B?U3oxTXV0aldySTVYa3FjVm5ZSTlyWWJ4SGdxSWRJdDVpTXkwSTJaOGxFUlNQ?=
 =?utf-8?B?WkU5Q0pKOGZxcDJYTXBCZHdML29Kd3JOa3FPNTRlek5oOHF3eSs3OU5uVi9O?=
 =?utf-8?B?OVB6SnNrVDBZZHNiM0NKRWxLRWQvMHJ1VXo4VXVMSjk1VitzZm83REFmSHpq?=
 =?utf-8?B?Z1dVVnNFd0psN0ZMTmRtV045K1Fucm5iZ0ZFY3dSZzNaSXhkZ1FJR0RZOExa?=
 =?utf-8?B?OCt5QmF3TDZOcHRkQWVkRE5rWjdVOVdWYWJ6VElRc2FCRDA2L1lDK3hKTVds?=
 =?utf-8?B?ZlBPdlloTStLcjZSTSs3ZFJwenFXY3RFbmZSWk9EM0xwYUtmYTluVURjRDBY?=
 =?utf-8?B?UjZpbjQ4NndvaFM1WjdKT1lqM3l3c2ZYUjVwaFRONEdYTzlUTERXb2VDK29W?=
 =?utf-8?B?dm5CWW1UcGNwOVJXK1kzYUF0TFlyR0kyNW1YZ1FvU3FEMTdCNmxGaW53YmtU?=
 =?utf-8?B?UWdwaHlIL2tTUDR0Q2NER0gzODQxTVBXS0VEM1dGdkxRcFh2WTAydGRGVmF3?=
 =?utf-8?B?Ukt0SFhoSUlpNnUwVXdkVVhKNnNUQUlVZWhnR0dmV3BTTjVES0hwdEZJdmMz?=
 =?utf-8?B?S2xrVm9qL3JyS3BVdEtteHNmdDRJQlhQM3ZDKytZcTh3MjA2WG83L0JHNC9l?=
 =?utf-8?B?dFZ0Q3FwWWF0dlUxazI2R0x1ZENlSXRrL09remRSR1lQN3RqMVYxWXd6ODFH?=
 =?utf-8?B?bFk3SE02eUFHUUdBOUNESlRPQ0FpQ1YxcW1FVnRHOWhUWGRaMHlnSHBvM3FD?=
 =?utf-8?B?b1l6aU8rV0N0aHpadGpGaitRb3ZpUGc3N0U1MjVrYnRHWDJ3MjJIOTQ5ZHZK?=
 =?utf-8?B?V3U4d1lneHlLR0dBYVBSWjJYZ3IvM1E2RDhMNWJKVGxYT0JDSVlvZzZuN0Z0?=
 =?utf-8?B?U3R0cXpGMFdXSTJMWUtrSGJ2NmMxODQ2NmdkZ2lrdTMxamo2VnJ4SWpBcVdM?=
 =?utf-8?Q?Das4OP3A0zsG9Egp1C8wgwGACLbFhuQIlXfGG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52092179CEC11042BB3359D6B3C53FA4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tnc8ZzjfgcDfMmIfXQxkh/M82P6MRIPCwUCGl9gIDXbi45+Uv0zV3oiy430B7cLFn68/QceyV+ShPMWFE4uJhRBLBxfHyfVE0hsj1wSTqdGmupT43+ap587BDSFP21Ca5W8dSn03Td6PizOKdn6mwS56R38UBqjoZf4BTRP7cjhH5ep/tnhdHJBo7EV6VIjjU0JQIF3H0FYNqhu+Sow1aL6lniy3m3XM1i6ZJEi+wAI0ix6j2HsCyFh6YbDlBR+4o/zxB/k+Xc2+XpxuXvYJIdZyoMBruKrWQuGxhUW2bJui0jTUpE0Ed6ropKQHrfFUGt2HCn5vuzENB1AHLPDqgQ==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 943bd745-c9e6-4b0a-4038-08de812faff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2026 18:38:14.7866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zqFSGwVVN7Oiv+2vsGOMV018B5F37VHFOewY5tkjLNGqhYvQrFkaALJPRYOTMhyefgPsKXPXWluhPt5am/VIOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6175
X-Authority-Analysis: v=2.4 cv=M+pA6iws c=1 sm=1 tr=0 ts=69b45999 cx=c_pps
 a=F5APu9G2MQgGAPAZFPwQAQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=wCmvBT1CAAAA:8 a=3NFCGVDrsvq5H3T0AsQA:9
 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: eWOyi5aWrLHARqWMXPN9zBiTFZ5RDTGG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE0NyBTYWx0ZWRfX1EEmoRESKBpw
 Fj4z55UJOAFhQfkuJqYN6Nn69jdou9mqyuJG3z85qDe8o1MmHte6OnhFiZAQYLaKJ+xmda7GdX1
 F6bwHfi6nOIz2p/kCMJB8dcgNAszDeN3mUcfD2YsMwYJuyCN8/39pXXxLJNoUcnPF2ADA3kyGUu
 O3kViVTGZO0UwnRADV4FzTPg3nnl72ywpcEZPli5kOstFdQ/8gBqd73zh2yEZEt6MVOyYjjTZwr
 W8MPJmjXrRXDd+AMRX8xRhIg1Ci+SS47E/8iS+ZpvxLwyPWD8HNJnB4VVy2HxPG3rvcEiuiSHzc
 YH2LBjiN8hpO+Qh/cac67I8cPofnLRhdibrbjMSPtBYc3oMiK32toP7S7jax3WUdW556cE3N7ZJ
 iKgUMAn1HVLwMrXBJ7zO2PPKOPhPUIUdU0ZVS4xipZ2qmeUHUmMcwJ8BEhHIi9Zf99/oNVWmzoH
 jljTvQ9cQZ0q5uV/hAA==
X-Proofpoint-ORIG-GUID: eWOyi5aWrLHARqWMXPN9zBiTFZ5RDTGG
Subject: RE:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130147
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,folder.id:url];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-225376-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 17F57288CF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTAzLTEzIGF0IDA5OjQ5ICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBP
biBUaHUsIE1hciAxMiwgMjAyNiBhdCAwNTozNjozOFBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5
a28gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE3ICswODAwLCBaaWxpbiBH
dWFuIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBNYXIgMTEsIDIwMjYgYXQgMDk6MTc6NTlQTSArMDAw
MCwgVmlhY2hlc2xhdiBEdWJleWtvIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIDIwMjYtMDMtMTEg
YXQgMTk6NDMgKzA4MDAsIFppbGluIEd1YW4gd3JvdGU6DQo+ID4gPiA+ID4gIGZzL2hmc3BsdXMv
c3VwZXIuYyB8IDQgKysrLQ0KPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2Zz
L2hmc3BsdXMvc3VwZXIuYyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiA+ID4gPiA+IGluZGV4IDcy
MjlhOGFlODlmOS4uZjM5NmZlZTE5YWI4IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2ZzL2hmc3Bs
dXMvc3VwZXIuYw0KPiA+ID4gPiA+ICsrKyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiA+ID4gPiA+
IEBAIC01NjksOCArNTY5LDEwIEBAIHN0YXRpYyBpbnQgaGZzcGx1c19maWxsX3N1cGVyKHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250ZXh0ICpmYykNCj4gPiA+ID4gPiAgCWlm
IChlcnIpDQo+ID4gPiA+ID4gIAkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+ID4gPiA+ID4gIAllcnIg
PSBoZnNwbHVzX2NhdF9idWlsZF9rZXkoc2IsIGZkLnNlYXJjaF9rZXksIEhGU1BMVVNfUk9PVF9D
TklELCAmc3RyKTsNCj4gPiA+ID4gPiAtCWlmICh1bmxpa2VseShlcnIgPCAwKSkNCj4gPiA+ID4g
PiArCWlmICh1bmxpa2VseShlcnIgPCAwKSkgew0KPiA+ID4gPiA+ICsJCWhmc19maW5kX2V4aXQo
JmZkKTsNCj4gPiA+ID4gPiAgCQlnb3RvIG91dF9wdXRfcm9vdDsNCj4gPiA+ID4gPiArCX0NCj4g
PiA+ID4gPiAgCWlmICghaGZzX2JyZWNfcmVhZCgmZmQsICZlbnRyeSwgc2l6ZW9mKGVudHJ5KSkp
IHsNCj4gPiA+ID4gPiAgCQloZnNfZmluZF9leGl0KCZmZCk7DQo+ID4gPiA+ID4gIAkJaWYgKGVu
dHJ5LnR5cGUgIT0gY3B1X3RvX2JlMTYoSEZTUExVU19GT0xERVIpKSB7DQo+ID4gPiA+IA0KPiA+
ID4gPiBNYWtlcyBzZW5zZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFJldmlld2VkLWJ5OiBWaWFjaGVz
bGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gRnJhbmts
eSBzcGVha2luZywgSSB0aGluaywgcG90ZW50aWFsbHksIHdlIGNhbiBpbnRyb2R1Y2Ugc3RhdGlj
IGlubGluZSBmdW5jdGlvbg0KPiA+ID4gPiBmb3IgdGhpcyBjb2RlOg0KPiA+ID4gPiANCj4gPiA+
ID4gCXN0ci5sZW4gPSBzaXplb2YoSEZTUF9ISURERU5ESVJfTkFNRSkgLSAxOw0KPiA+ID4gPiAJ
c3RyLm5hbWUgPSBIRlNQX0hJRERFTkRJUl9OQU1FOw0KPiA+ID4gPiAJZXJyID0gaGZzX2ZpbmRf
aW5pdChzYmktPmNhdF90cmVlLCAmZmQpOw0KPiA+ID4gPiAJaWYgKGVycikNCj4gPiA+ID4gCQln
b3RvIG91dF9wdXRfcm9vdDsNCj4gPiA+ID4gCWVyciA9IGhmc3BsdXNfY2F0X2J1aWxkX2tleShz
YiwgZmQuc2VhcmNoX2tleSwgSEZTUExVU19ST09UX0NOSUQsDQo+ID4gPiA+ICZzdHIpOw0KPiA+
ID4gPiAJaWYgKHVubGlrZWx5KGVyciA8IDApKQ0KPiA+ID4gPiAJCWdvdG8gb3V0X3B1dF9yb290
Ow0KPiA+ID4gPiAJaWYgKCFoZnNfYnJlY19yZWFkKCZmZCwgJmVudHJ5LCBzaXplb2YoZW50cnkp
KSkgew0KPiA+ID4gPiAJCWhmc19maW5kX2V4aXQoJmZkKTsNCj4gPiA+ID4gCQlpZiAoZW50cnku
dHlwZSAhPSBjcHVfdG9fYmUxNihIRlNQTFVTX0ZPTERFUikpIHsNCj4gPiA+ID4gCQkJZXJyID0g
LUVJTzsNCj4gPiA+ID4gCQkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+ID4gPiA+IAkJfQ0KPiA+ID4g
PiAJCWlub2RlID0gaGZzcGx1c19pZ2V0KHNiLCBiZTMyX3RvX2NwdShlbnRyeS5mb2xkZXIuaWQp
KTsNCj4gPiA+ID4gCQlpZiAoSVNfRVJSKGlub2RlKSkgew0KPiA+ID4gPiAJCQllcnIgPSBQVFJf
RVJSKGlub2RlKTsNCj4gPiA+ID4gCQkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+ID4gPiA+IAkJfQ0K
PiA+ID4gPiAJCXNiaS0+aGlkZGVuX2RpciA9IGlub2RlOw0KPiA+ID4gPiAJfSBlbHNlDQo+ID4g
PiA+IAkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiA+ID4gPiANCj4gPiA+ID4gQmVjYXVzZSwgaGlk
aW5nIHRoaXMgY29kZSBpbnRvIHNtYWxsIGZ1bmN0aW9uIHdpbGwgcHJvdmlkZSBvcHBvcnR1bml0
eSB0byBjYWxsDQo+ID4gPiA+IGhmc19maW5kX2V4aXQoKSBpbiBvbmUgcGxhY2Ugb25seSAoYXMg
Zm9yIG5vcm1hbCBhcyBmb3IgZXJyb25lb3VzIGZsb3cpLg0KPiA+ID4gPiANCj4gPiA+ID4gV2hh
dCBkbyB5b3UgdGhpbms/DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IFNsYXZh
Lg0KPiA+ID4gDQo+ID4gPiBUaGFua3MgZm9yIHRoZSBmZWVkYmFjaywgU2xhdmEuDQo+ID4gPiAN
Cj4gPiA+IFdoaWxlIEkgc2VlIHRoZSBtZXJpdCBpbiByZWZhY3RvcmluZyB0aGlzIGludG8gYSBo
ZWxwZXIgdG8gY2VudHJhbGl6ZSB0aGUgDQo+ID4gPiBjbGVhbnVwLCBJ4oCZbSBjb25jZXJuZWQg
dGhhdCBkb2luZyBzbyB3b3VsZG7igJl0IGFjdHVhbGx5IGFjaGlldmUgYSBzaW5nbGUgDQo+ID4g
PiBoZnNfZmluZF9leGl0KCkgY2FsbCB3aXRob3V0IGNvbXByb21pc2luZyB0aGUgcmVzb3VyY2Ug
bGlmZWN5Y2xlLg0KPiA+ID4gDQo+ID4gPiBJbiB0aGUgY3VycmVudCBsb2dpYywgd2UgbmVlZCB0
byBjYWxsIGhmc19maW5kX2V4aXQoJmZkKSBhcyBlYXJseSBhcyANCj4gPiA+IHBvc3NpYmxl4oCU
c3BlY2lmaWNhbGx5IGJlZm9yZSBlbnRlcmluZyBoZnNwbHVzX2lnZXQoKSwgd2hpY2ggbWlnaHQg
aW52b2x2ZSANCj4gPiA+IGZ1cnRoZXIgSS9PIG9yIHNsZWVwaW5nLiBJZiB3ZSB3ZXJlIHRvIHVz
ZSBhIHNpbmdsZS1leGl0IGdvdG8gcGF0dGVybiBpbiBhIA0KPiA+ID4gaGVscGVyIGZ1bmN0aW9u
LCB3ZSB3b3VsZCBlbmQgdXAgaG9sZGluZyB0aGUgc2VhcmNoIGRhdGEgYW5kIGl0cyANCj4gPiA+
IGFzc29jaWF0ZWQgYnVmZmVycy9sb2NrcyBsb25nZXIgdGhhbiBuZWNlc3NhcnkuIFRvIG1haW50
YWluIHRoZSBjdXJyZW50IA0KPiA+ID4gZWFybHktcmVsZWFzZSBiZWhhdmlvciwgd2Ugd291bGQg
c3RpbGwgYmUgZm9yY2VkIHRvIHNwcmlua2xlIG11bHRpcGxlIA0KPiA+ID4gaGZzX2ZpbmRfZXhp
dCgpIGNhbGxzIGFjcm9zcyBkaWZmZXJlbnQgYnJhbmNoZXMgd2l0aGluIHRoYXQgaGVscGVyIGFu
eXdheSwgDQo+ID4gPiB3aGljaCBkZWZlYXRzIHRoZSBwdXJwb3NlIG9mIHRoZSByZWZhY3Rvcmlu
Zy4NCj4gPiA+IA0KPiA+ID4gR2l2ZW4gdGhhdCB0aGlzIGlzIGEgc3RyYWlnaHRmb3J3YXJkIGZp
eCBmb3IgYSBzcGVjaWZpYyBsZWFrLCBJIGJlbGlldmUgDQo+ID4gPiBrZWVwaW5nIHRoZSBsb2dp
YyBpbmxpbmUgcHJlc2VydmVzIHRoZSBvcHRpbWFsIHJlc291cmNlIHJlbGVhc2UgdGltaW5nIA0K
PiA+ID4gd2l0aG91dCBhZGRpbmcgdW5uZWNlc3NhcnkgYWJzdHJhY3Rpb24uDQo+ID4gPiANCj4g
PiANCj4gPiBJIG1lYW4gcmVhbGx5IHNpbXBsZSBzb2x1dGlvbjoNCj4gPiANCj4gPiBzdGF0aWMg
aW5saW5lDQo+ID4gaW50IGhmc3BsdXNfZ2V0X2hpZGRlbl9kaXJfZW50cnkoc3RydWN0IHN1cGVy
X2Jsb2NrICpzYiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBoZnNwbHVz
X2NhdF9lbnRyeSAqZW50cnkpDQo+ID4gew0KPiA+ICAgICBpbnQgZXJyID0gMDsNCj4gPiANCj4g
PiAJc3RyLmxlbiA9IHNpemVvZihIRlNQX0hJRERFTkRJUl9OQU1FKSAtIDE7DQo+ID4gCXN0ci5u
YW1lID0gSEZTUF9ISURERU5ESVJfTkFNRTsNCj4gPiAJZXJyID0gaGZzX2ZpbmRfaW5pdChzYmkt
PmNhdF90cmVlLCAmZmQpOw0KPiA+IAlpZiAoZXJyKQ0KPiA+IAkJZ290byBmaW5pc2hfbG9naWM7
DQo+ID4gDQo+ID4gCWVyciA9IGhmc3BsdXNfY2F0X2J1aWxkX2tleShzYiwgZmQuc2VhcmNoX2tl
eSwgSEZTUExVU19ST09UX0NOSUQsDQo+ID4gJnN0cik7DQo+ID4gCWlmICh1bmxpa2VseShlcnIg
PCAwKSkNCj4gPiAJCWdvdG8gZnJlZV9mZDsNCj4gPiANCj4gPiAgICAgICAgIGVyciA9IGhmc19i
cmVjX3JlYWQoJmZkLCBlbnRyeSwgc2l6ZW9mKCplbnRyeSkpOw0KPiA+IA0KPiA+IGZyZWVfZmQ6
DQo+ID4gICAgICBoZnNfZmluZF9leGl0KCZmZCk7DQo+ID4gZmluaXNoX2xvZ2ljOg0KPiA+ICAg
ICAgcmV0dXJuIGVycjsNCj4gPiB9DQo+ID4gDQo+ID4gc3RhdGljIGludCBoZnNwbHVzX2ZpbGxf
c3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiA+
IHsNCj4gPiAgIDxza2lwcGVkPg0KPiA+IA0KPiA+ICAgZXJyID0gaGZzcGx1c19nZXRfaGlkZGVu
X2Rpcl9lbnRyeShzYiwgJmVudHJ5KTsNCj4gPiAgIGlmIChlcnIpDQo+ID4gICAgICAgZ290byBw
cm9jZXNzX2Vycm9yOw0KPiA+IA0KPiA+IAkJaWYgKGVudHJ5LnR5cGUgIT0gY3B1X3RvX2JlMTYo
SEZTUExVU19GT0xERVIpKSB7DQo+ID4gCQkJZXJyID0gLUVJTzsNCj4gPiAJCQlnb3RvIGZpbmlz
aF9sb2dpYzsNCj4gPiAJCX0NCj4gPiAJCWlub2RlID0gaGZzcGx1c19pZ2V0KHNiLCBiZTMyX3Rv
X2NwdShlbnRyeS5mb2xkZXIuaWQpKTsNCj4gPiAJCWlmIChJU19FUlIoaW5vZGUpKSB7DQo+ID4g
CQkJZXJyID0gUFRSX0VSUihpbm9kZSk7DQo+ID4gCQkJZ290byBmaW5pc2hfbG9naWM7DQo+ID4g
CQl9DQo+ID4gCQlzYmktPmhpZGRlbl9kaXIgPSBpbm9kZTsNCj4gPiANCj4gPiAgIDxza2lwcGVk
Pg0KPiA+IH0NCj4gPiANCj4gPiBEb2VzIGl0IG1ha2VzIHNlbnNlIHRvIHlvdT8NCj4gPiANCj4g
PiBUaGFua3MsDQo+ID4gU2xhdmEuDQo+IA0KPiBIaSBTbGF2YSwNCj4gDQo+IFRoYW5rcyBmb3Ig
dGhlIGRldGFpbGVkIHByb3Bvc2FsLiBIb3dldmVyLCB0aGlzIHByb3Bvc2VkIHJlZmFjdG9yaW5n
IA0KPiBjaGFuZ2VzIHRoZSBleGlzdGluZyBzZW1hbnRpY3MgYW5kIGludHJvZHVjZXMgYSByZWdy
ZXNzaW9uLg0KPiANCg0KSSBkb24ndCBxdWl0ZSBmb2xsb3cgdG8geW91ciBwb2ludC4gSSBkb24n
dCBzdWdnZXN0IHRvIGNoYW5nZSB0aGUgbG9naWMuIEkgYW0NCnN1Z2dlc3RpbmcgdGhlIHNtYWxs
IHJlZmFjdG9yaW5nIHdpdGhvdXQgY2hhbmdpbmcgdGhlIGV4ZWN1dGlvbiBmbG93LiBEbyB5b3UN
Cm1lYW4gdGhhdCBjdXJyZW50IGhmc3BsdXNfZmlsbF9zdXBlcigpIGxvZ2ljIGlzIGluY29ycmVj
dCBhbmQgaGFzIGJ1Z3M/DQoNCj4gVGhlIGhpZGRlbiBkaXJlY3RvcnkgaXMgb3B0aW9uYWwuIElm
IGhmc19icmVjX3JlYWQoKSBmYWlscywgdGhlIG9yaWdpbmFsIA0KPiBjb2RlIHNpbXBseSBjYWxs
cyBoZnNfZmluZF9leGl0KCkgYW5kIHByb2NlZWRzIHdpdGggdGhlIG1vdW50LiBJdCBpcyBhIA0K
PiBub24tZmF0YWwgZXJyb3IuDQo+IA0KDQpZb3Ugc2ltcGx5IG5lZWQgc2xpZ2h0bHkgbW9kaWZ5
IG15IHN1Z2dlc3Rpb24gdG8gbWFrZSBpdCByaWdodDoNCg0KZXJyID0gaGZzcGx1c19nZXRfaGlk
ZGVuX2Rpcl9lbnRyeShzYiwgJmVudHJ5KTsNCmlmICghZXJyKSB7DQoNCgkJaWYgKGVudHJ5LnR5
cGUgIT0gY3B1X3RvX2JlMTYoSEZTUExVU19GT0xERVIpKSB7DQoJCQllcnIgPSAtRUlPOw0KCQkJ
Z290byBmaW5pc2hfbG9naWM7DQoJCX0NCgkJaW5vZGUgPSBoZnNwbHVzX2lnZXQoc2IsIGJlMzJf
dG9fY3B1KGVudHJ5LmZvbGRlci5pZCkpOw0KCQlpZiAoSVNfRVJSKGlub2RlKSkgew0KCQkJZXJy
ID0gUFRSX0VSUihpbm9kZSk7DQoJCQlnb3RvIGZpbmlzaF9sb2dpYzsNCgkJfQ0KCQlzYmktPmhp
ZGRlbl9kaXIgPSBpbm9kZTsNCn0NCg0KSSBzaW1wbHkgc2hhcmVkIHRoZSByYXcgc3VnZ2VzdGlv
biBidXQgeW91IGNhbiBtYWtlIGl0IHJpZ2h0Lg0KDQo+IEluIGNvbnRyYXN0LCBmYWlsdXJlcyBm
cm9tIGhmc19maW5kX2luaXQoKSBhbmQgaGZzcGx1c19jYXRfYnVpbGRfa2V5KCkgYXJlIA0KPiBm
YXRhbCBhbmQgbXVzdCBhYm9ydCB0aGUgbW91bnQuDQo+IA0KPiBCeSB3cmFwcGluZyB0aGVzZSBp
bnRvIGEgc2luZ2xlIGhlbHBlciBhbmQgcmV0dXJuaW5nIGVyciwgdGhlIGNhbGxlciBjYW4gbm8g
DQo+IGxvbmdlciBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZW0uIEEgbWlzc2luZyBoaWRkZW4gZGly
ZWN0b3J5IHdpbGwgdHJpZ2dlciANCj4gaWYgKGVycikgZ290byBwcm9jZXNzX2Vycm9yOyBpbiBo
ZnNwbHVzX2ZpbGxfc3VwZXIoKSwgbWFraW5nIGl0IGEgZmF0YWwgDQo+IGVycm9yLiBUaGlzIHdp
bGwgYnJlYWsgbW91bnRpbmcgZm9yIGFueSB2YWxpZCBIRlMrIHZvbHVtZSB0aGF0IGxhY2tzIHRo
ZSANCj4gcHJpdmF0ZSBkYXRhIGRpcmVjdG9yeS4NCj4gDQo+IA0KDQpTaW1wbHkgbWFrZSBteSBz
dWdnZXN0aW9uIGJldHRlciBhbmQgY29ycmVjdC4gVGhhdCdzIGFsbC4NCg0KVGhhbmtzLA0KU2xh
dmEuDQo=

