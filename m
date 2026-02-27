Return-Path: <stable+bounces-219999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ2gM2ztoWmJxQQAu9opvQ
	(envelope-from <stable+bounces-219999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:15:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E621BC8F8
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3AA930D4F9F
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96093A7836;
	Fri, 27 Feb 2026 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l0vdyirj"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361D3859FE;
	Fri, 27 Feb 2026 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219585; cv=fail; b=YBOqnT4xyp1vTN67L0EIFIcI75Q4yW2KO/6TkgauvT6y4irijCgqiZgjfRSm7hWyBRTAmghorrsR/Rcik+g38StGUXMBcnUSf7CUwO4s/SJVjdlkWw/20BRCppSeIqdmsQDePEvQO6ToOf1v0HActbN34V+jmkmind+pnVHuyqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219585; c=relaxed/simple;
	bh=6DbYn871XRzShztLhSjZSrb1afC6lSO2o3rLg59sFQo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=VCsls+jXuvxsCOgoVWNtOqOoSHtodfKLWDHo9eQW2qpX7zEqsXrgUU287YzUX3m3Zrnj2MonhRILFk0tmPBFsIx7vZ5AIfx1j+xoe5qlFMIaYauQApTojjVddWB8qpOUI7GOM4Z9OSDOWMCTgp6H/HFWH6iWiDHlVV9+VHy4bqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l0vdyirj; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9sR5p2522900;
	Fri, 27 Feb 2026 19:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=6DbYn871XRzShztLhSjZSrb1afC6lSO2o3rLg59sFQo=; b=l0vdyirj
	ubpjW6pFhPzh9fjreyvLSILHIEosdDsEMUHsKuUSXY+mTgX+S0hINR/laxk8KX1q
	BXqWj6qbU1S3DTf0zn9nDztjc0EZP+OxRANLpkHqxyUqfL0CJ16/WBjbdW35wjYs
	9khwbpd6Yo65CeQMMruEoFV4S0SlUoOgT7U/dTMJ4g00ztYRj6JoonC+s+HYvH/l
	laXp80yRMDtp96lZKx3dk/2p4c2q7vpqTZp2VYH+Xr2o3XheI80vizQC5LISREee
	KwuWxMvZsQIALwB4B1tBsSl59bteU+OdvS/ymbAaZxQU8WyromQXlHZUC2CD5znp
	3l/W2UgObYVRtg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bsd7cc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 19:12:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJo66JDwFr7JNwl71tg2CxgqrHAM301tp/z5V7omxzf/tw/+gMywzVC462sviOtmaq+5cdgFsjb/MTRczZiXtS/VzGjp99o5QZ2RT/YvfJ4K5X7icjFxv7ov9qqjECT8Q6W/q7mgsqmSZoH/7XjxUYvKr2MEEiN5guuJq7ch4+7+b/2zpyOWHN6MTKwwKUkNZVDUr6+86HFhGuyTNeXmEaEDcUvYWGNSBL484vCsMmQHI5ZbEJpXH2CLbvFW2zssIzj9IGqTu+PAeifxJKw5T0v4/BVknqNqQK32DxGZazvzxn1vrHud9Z9vv7Ku9mXWexV4onvWaU56nJ9KcDsf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DbYn871XRzShztLhSjZSrb1afC6lSO2o3rLg59sFQo=;
 b=twTwQcCUvl2Hk//0Gr41CYkNE7Qiswya/oscS1Y+Zw+pqBaRp+m6KtFhJaVbato9679cGLncmGBTzAmAm8Er42RiirFNAhJfpZ9jjE6rK9L/E8OJu1BMSSL4qbeXtPZbjGGr2RBzt/TxdxtGB6gLm5GAvjWeSzXyqH54b4JSE0Mg2/BwuzY7DK8szeKIM03KLp1CEm2FTitrOXNH+giXZ4iQiDomWIpa2gHzRgXO0Aj0hpRcowcSSknakuSSwNk/xTO7y3hh9J3kO7UQeiSFXkcVKsw3bE4Q6BjgUHkVHkmg/gY7RA49EkmYwKYZkljGtjVttXjgD8q4S4O+dCePrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4808.namprd15.prod.outlook.com (2603:10b6:806:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 19:12:53 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 19:12:53 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hristo@venev.name" <hristo@venev.name>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Alex
 Markuze <amarkuze@redhat.com>
Thread-Topic: [EXTERNAL] RE:  [PATCH] ceph: Do not skip the first folio of the
 next object in writeback
Thread-Index:
 AQHcppgDS668W704B0iRyTKXxOujMrWT6I8AgAF3MwCAAAMxgIAAA36AgAAD5gCAAAN4gIABfyQA
Date: Fri, 27 Feb 2026 19:12:52 +0000
Message-ID: <c4276585d30375876dfbdc4a538359addec5f1c3.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
								 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
							 <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
						 <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
					 <daf3f64ab55d5c6e6c4bf612db609e5505795d05.camel@ibm.com>
				 <b7c3c502da0d135fe1d57014f9f1074f8a2d4ceb.camel@venev.name>
			 <c1c033c44edf8d20b0a9dd8944a2f21bec942c1e.camel@ibm.com>
		 <e714d8106a492077707cd31df96401a08caef6fe.camel@venev.name>
	 <0c8d905c386f5f9ca2632307802ada7423c82c2a.camel@ibm.com>
In-Reply-To: <0c8d905c386f5f9ca2632307802ada7423c82c2a.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4808:EE_
x-ms-office365-filtering-correlation-id: 666c1729-11f9-4aba-5b5a-08de763434ea
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021|13003099007;
x-microsoft-antispam-message-info:
 skDF90MdBB+CQrQhhbZJUhp/Lnv64OWdhn5w3vNZdhAaSkrctCON1bSgelvlmBfmbwhMlw3lG0cb/2izjuzToloFIskG9LhkS81E3UkKAIdc+aMju1+8CfCpJ9UMsQWsLWh9JdhGroWunTvqD5tpWHhPc4pkcCLvaApmdOlh5sb1sz9JczUq9kbR52P0n7clWPE2GCOsuT+8wqJTo6TDkHusr/DTBgWFHxoCMXJnbfk2BW66BLmJS6TqwskPXx++IS1JgWW5WUVX++7r/WL6P1xqbTgNTnE0KxMjV5gBRLaSH/HzAczR/qhWgIR9NBuw9uT1mCov291V+ZfA1kWgpQ8IQVY61PfFoUdOJ3B1/Yb3p5ryFlno7za1OaWHQ9zZovEEQY9c7KJDBAo66fjVp19765AUZNmdvpl29winBoR/J1cGQnBj1V6TjPk01GUrJAqBcMrAxlQJ7VwjCkfESSKnb0InqXMWSbd0Z1Th5w/jSZq4aEw/eMs6QXMyFwrqGOi9t8N2SNqZBrTptbxPb+bGQyJlDLmdjN5TxdKVg9HobaBWfIp+ws2gicSSVrQtMTHDRkuXvZILGte0krMC2HpLmMP+J86HcnOqeM4l277y/D5qRZMwJKPsZPaeH3n+QwGxNMx7C21iYMKiV17KCBgk/kGiJV3DJQGl6Fmk5mXaXYMOLBNJ9/krGd12WhPhdisw0iBokUAh6MdQ7d26VGyDlPVthBYPM0us+S+uJMeZvCxOtTpc+H9kKKLk2I2f
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUxKYlp3S1pQamZRYWhtYUxMQ1lnZ2RPV2VIRjJrTFdlQ2R1elV2aGNHNTdt?=
 =?utf-8?B?UGFrMW9sNDBGcUVLTWZQVUEyZ1pBK3VrSm4rWmhVZm5QWjJNcUJwcmV1S1dq?=
 =?utf-8?B?M3JYZFM4QXVNdnFYVHF3QTJSQ2lvQVlnSE5tRmdQNnk4U1d4bThucmswTXdq?=
 =?utf-8?B?WnpyVUgyNE1ldWEwRDlXczlwR0RyVkFrV3g2aHlreHRhM1BocklLYmtUMjBB?=
 =?utf-8?B?ZkcyUlVsY21rRDdZcnJkd3IwMjNSVmtyaWI5N2NvVloxRjQ3bDZmUDdUKzI3?=
 =?utf-8?B?c3lkVHNlK2NuQkJOSExoZVd1elRYVGhSaHRiQ0ZQRGp1L3I5UnFTS09PUkEv?=
 =?utf-8?B?UWd0R0EwdDVydmVzVVYyWFJJamtvOHJ3OHFXQVpMdG1jeFVTSHlmWEkxRnRF?=
 =?utf-8?B?UkR5VmtDcmJKTVJnWGtTK2FNMWlpb1YwbDNTUnlWTWs0T015cUFpbGp0UjEx?=
 =?utf-8?B?anhOTXEreWFDNncwVUpHT2MyYkpuUkhxZXNLdmFpelpPbzRpb3FERmlSRXI0?=
 =?utf-8?B?MklvcjJacGY3N1JZZmpnQTR5RWZVNG11TDZ0RGZ4OTc5UDFHTE54TmN0V2Jh?=
 =?utf-8?B?OUlpc1hYcGE5ZE5WVnpqeWltNGRRK3RCRWlTNWpXUGxJcERNM2F4NzQ1VWxt?=
 =?utf-8?B?TTFSWDcrMWJ1SnUvVW10WFBPSUhnR0hocitya2JsQ2xnSFN4TGZRSkRYQ2d6?=
 =?utf-8?B?enZlN0UwQUE3bS93aU5qVnBJWHBtdzl5eWc1M21jS0J0MmFlVGJvUFArSmp4?=
 =?utf-8?B?alBoS0dXSE1hQnJjbGJ6ZkFub1E3b2ZYVDlvbnJkL1hnSGRrVGhEcFJDQVNu?=
 =?utf-8?B?NE9KanE3eTNjNVl2RGx1UHFqOTRZWTl2dTNtNGtMMHFIQ0w4NE9qQmZVenBM?=
 =?utf-8?B?b1M3NisyYVNtSGpPYWdSSzJEWUsrL042ejVWcTFiZ0cybEd1bmorUnIySk9V?=
 =?utf-8?B?OGNCMFFFQW1uQ1ZjQXNjNVpVS0tTbHIvbVhyaXp3RXpyVU4vd0Q0M3dML1B2?=
 =?utf-8?B?azdwTlpic0lleUlDd04xVEd0bkVFRVRjcERaekhKZkNsZ3BESldVRUxIeW5i?=
 =?utf-8?B?RzRuL09TVk43Rld6cG4xelJFTUM3eUMvTktnTW91T3pEMlpRSVFrL2pPL29x?=
 =?utf-8?B?MnNCVC9FOGFZeVNZZUI2ek52Q0RKbTlJa25rQ1hGNGJlTEJ5eXpCQTArQVJX?=
 =?utf-8?B?L2djU0ZGZHQ2Q21UcWRqUW1jVUNVMlZyUjhTS1BXcU1MbExlclhrSmxYajVJ?=
 =?utf-8?B?ZXRKRFFYMlFzUDR2WG13enMyMTlBTU0vTVFVQnpmVDgwT2R3S1JSaEc4VXdR?=
 =?utf-8?B?RFdwN3ZXRUVOKzJ0U1FHeWgySnp2cHFXdFFmYmNHRjZrYnlMTUhxWUFoeFhY?=
 =?utf-8?B?N1JMN2JqNXU1bE0wY3lyRDVqWngvcC9nWEZ4cG1KR05SbkJmMzhPaDhYeFlP?=
 =?utf-8?B?NHlRSFV0NUgzOUVnR2xKdTlyUGJTbkJOeUV4OTArZ3AwYlhpOS9mMEsrY0tW?=
 =?utf-8?B?dVVtbyt3QjRvK296bWEwajhQeXJydHk1bFB0SXl1T1BJMEdWOHFoYVF6YUpO?=
 =?utf-8?B?eHd2Y25PY2REZlBYRDVIbk5NK3g2dERRamUrSHVINmVyaTBwQWx1d0s3WVd2?=
 =?utf-8?B?ZzhiRkN0ZXpaWWkyNUNkQ0x1eU8xSHBIVDV2Vmd6UTQveXlheUswRWY2ZUdB?=
 =?utf-8?B?TlF2dVUvZ2FhelkvZDFlUlV6cUlscS84ZHp5VnFtbXVRNHNVelN6SXo2TWx4?=
 =?utf-8?B?aEZVemJUVXdoNmxHMTN3TDJLL1FQNmVQZFVDNjhKVmdCWUlLeitSMmJmRk1W?=
 =?utf-8?B?TWZEdUptQmpOME1MeDJxRUlKN243aDhLTmp6NWdpNk5LVTlrSyt2TWNuK3ZH?=
 =?utf-8?B?T3NHU0dVSmZQbDJSb1NXUnNEbXU0VGRsSW4wRUFrK1VyOEdPbno0UStxTlBM?=
 =?utf-8?B?QjlVU3oxd0c4d1p0WEdtRnVQWndPSTR4Q1JPQWhyK1JwSitSbXgrNjVvR3d1?=
 =?utf-8?B?LzhNVXhrRzhWSHpaRjdQdUVVQ0tqRXFaUEkzYUZsMzRwSmNyVEUrVlpVbGJ4?=
 =?utf-8?B?VUtKRDErbXBRd3BYcWtNeVAveDFQNEg5aXNDcWZVeGRGeS84RnBNZTJ2MW1y?=
 =?utf-8?B?eG9kWWlwNFhsMExnQ2FrZk15NTFRVFExbEFENnpUNDBmZW9uRjQrS1Y3c1p2?=
 =?utf-8?B?Q3ZUSHpWUzZEZklBNGQvMm5tNWlJNXJTMXZsdTcrNmZBL3JxVUtLRHZIUEFG?=
 =?utf-8?B?cDlxRDUyMzZlSTJucHZHS1dTOW0wWGJjOVNlTGl6NGdrcGVuSHNJRGIrMG1Y?=
 =?utf-8?B?Z2RETUU4V2ZCTWtNZTZkK3ZzU092YTNaRnhUTGdRSXVNSVJzT0dzVXl5ckty?=
 =?utf-8?Q?x3kuSD0CokGhBt3hznUxrkgfmVdbgCPcdSs92?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E03C278857CA046A9A151C4995B8A56@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666c1729-11f9-4aba-5b5a-08de763434ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 19:12:53.0321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFy56Mx4dXsF/Wyg0z0gZR5JmPHSWAaNCq5zrPQi/JMZI9mPJdZqzjMGFRFzB/bUnlOPHi3pDgrecmgY3JJFmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4808
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dVcs6Gb0cOHPZOs5yGBG3vopF7iD_t4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE2NCBTYWx0ZWRfX1hInS7qHKcpU
 FN/af0hUuEkCLCqczjS8rK15nKg9FMoLXaLy3OUh6qTiye4IieJjCQYlOb+UEmIHpdRn+8VAItZ
 +iV4+k/fQdrt+rfMj2IMWDV2PL8lrRXx9Pkr3EspnLrbD6Pn5kLfXMsyS9O/sEa3Ufipkhp75bF
 liK3vkoFwieZsAT4k2H5w/kxQi0Z42nmnPhy1w2l9r92mFoVbId1QLeL8Ksi2LtBP6bieQITLxb
 81KMBaxfhOKPePodbQ9qnZEmYPyQDYmEUM5AmeeFMhwxOSZ6i5r1LuTpmLEjkrOSZdo6NixQPcE
 L/IoO+ayMBjZ/4rWCXFU+HCEKfleGG+nqOWX/aQXQYmXrLIpFw1UDCb8k7QKoqHXA2OiUR7DF85
 GOmskuK27fr26uCZ9RjB80AJbi7NOKafn77Cnanwg6wX113x2q9AposDMw1ZQwCExgPKlmDoKIR
 bmSnfEfrYZurWde5A1g==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a1ecb8 cx=c_pps
 a=7HTsEC4o+G4Ts3XEwqQVug==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=GVT9W4Wiak6UpZ1B:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jX2HzZST6GZoLp3zjZ4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5QkxODblEGgGx3Q4Vz05dfWZf6QrNSPF
Subject: RE:  [PATCH] ceph: Do not skip the first folio of the next object in
 writeback
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219999-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,dubeyko.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proofpoint.com:url,box:email,venev.name:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 35E621BC8F8
X-Rspamd-Action: no action

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDIwOjIxICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IE9uIFRodSwgMjAyNi0wMi0yNiBhdCAyMjowOSArMDIwMCwgSHJpc3RvIFZlbmV2IHdy
b3RlOg0KPiA+IE9uIFRodSwgMjAyNi0wMi0yNiBhdCAxOTo1NSArMDAwMCwgVmlhY2hlc2xhdiBE
dWJleWtvIHdyb3RlOg0KPiA+ID4gQXJlIHlvdSBjYXBhYmxlIHRvIGV4ZWN1dGUgc3VjY2Vzc2Z1
bGx5IHRoaXMgc2VxdWVuY2U/DQo+ID4gPiANCj4gPiA+IGI0IGFtDQo+ID4gPiBodHRwczovL3Vy
bGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xvcmUua2VybmVsLm9y
Z19jZXBoLTJEZGV2ZWxfMjAyNjAyMjUxNzA3NTguMjAxNDE3Mi0yRDEtMkRocmlzdG8tNDB2ZW5l
di5uYW1lX1RfLTIzdSZkPUR3SUZhUSZjPUJTRGljcUJRQkRqREk5UmtWeVRjSFEmcj1xNWJJbTRB
WE16YzhOSnUxX1JHbW5RMmZNV0txNFk0UkFrRWx2VWdTczAwJm09dTk2SUh2VGEtYVpIblg3eTIz
NkVFSXpwcFdBM20tNWt2Q2xRRzh0VmNpUjZKQ3BZNUNhdWFpMDN1bzRUdklkOCZzPXFfYlh1cEdY
ZHE1WUlMb1M5ajFsTzJubVB2MjhFWU1mOFFSQS1Cb09vaFEmZT0gDQo+ID4gPiBnaXQgYW0NCj4g
PiA+IDIwMjYwMjI1X2hyaXN0b19jZXBoX2RvX25vdF9za2lwX3RoZV9maXJzdF9mb2xpb19vZl90
aGVfbmV4dF9vYmplY3RfaQ0KPiA+ID4gbl93cml0ZWJhY2sNCj4gPiA+IC5tYngNCj4gPiANCj4g
PiBJdCBhcHBsaWVzIGZvciBtZSBvbiB2Ny4wLXJjMToNCj4gPiANCj4gPiANCj4gPiBocmlzdG9A
Ym94IH4vc3cvbGludXggJCBnaXQgY2hlY2tvdXQgdjcuMC1yYzENCj4gPiBIRUFEIGlzIG5vdyBh
dCA2ZGUyM2Y4MWE1ZTA4IExpbnV4IDcuMC1yYzENCj4gPiBocmlzdG9AYm94IH4vc3cvbGludXgg
JCBiNCBhbSAnaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX19sb3JlLmtlcm5lbC5vcmdfY2VwaC0yRGRldmVsXzIwMjYwMjI1MTcwNzU4LjIwMTQxNzIt
MkQxLTJEaHJpc3RvLTQwdmVuZXYubmFtZV9UXy0yM3UmZD1Ed0lGYVEmYz1CU0RpY3FCUUJEakRJ
OVJrVnlUY0hRJnI9cTViSW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZt
PXU5NklIdlRhLWFaSG5YN3kyMzZFRUl6cHBXQTNtLTVrdkNsUUc4dFZjaVI2SkNwWTVDYXVhaTAz
dW80VHZJZDgmcz1xX2JYdXBHWGRxNVlJTG9TOWoxbE8ybm1QdjI4RVlNZjhRUkEtQm9Pb2hRJmU9
ICcNCj4gPiBBbmFseXppbmcgNyBtZXNzYWdlcyBpbiB0aGUgdGhyZWFkDQo+ID4gQW5hbHl6aW5n
IDAgY29kZS1yZXZpZXcgbWVzc2FnZXMNCj4gPiBDaGVja2luZyBhdHRlc3RhdGlvbiBvbiBhbGwg
bWVzc2FnZXMsIG1heSB0YWtlIGEgbW9tZW50Li4uDQo+ID4gLS0tDQo+ID4gICDinJMgW1BBVENI
XSBjZXBoOiBEbyBub3Qgc2tpcCB0aGUgZmlyc3QgZm9saW8gb2YgdGhlIG5leHQgb2JqZWN0IGlu
IHdyaXRlYmFjaw0KPiA+ICAgLS0tDQo+ID4gICDinJMgU2lnbmVkOiBES0lNL3ZlbmV2Lm5hbWUN
Cj4gPiAtLS0NCj4gPiBUb3RhbCBwYXRjaGVzOiAxDQo+ID4gLS0tDQo+ID4gIExpbms6IGh0dHBz
Oi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJu
ZWwub3JnX3JfMjAyNjAyMjUxNzA3NTguMjAxNDE3Mi0yRDEtMkRocmlzdG8tNDB2ZW5ldi5uYW1l
JmQ9RHdJRmFRJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNIUSZyPXE1YkltNEFYTXpjOE5KdTFfUkdt
blEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT11OTZJSHZUYS1hWkhuWDd5MjM2RUVJenBwV0EzbS01
a3ZDbFFHOHRWY2lSNkpDcFk1Q2F1YWkwM3VvNFR2SWQ4JnM9VjR5b3VGV25kb1R1R2dUWnh6UW9U
WTI0OHlKblBHWlhnSjJGaV9hYUlUOCZlPSANCj4gPiAgQmFzZTogYXBwbGllcyBjbGVhbiB0byBj
dXJyZW50IHRyZWUNCj4gPiAgICAgICAgZ2l0IGNoZWNrb3V0IC1iIDIwMjYwMjI1X2hyaXN0b192
ZW5ldl9uYW1lIEhFQUQNCj4gPiAgICAgICAgZ2l0IGFtIC4vMjAyNjAyMjVfaHJpc3RvX2NlcGhf
ZG9fbm90X3NraXBfdGhlX2ZpcnN0X2ZvbGlvX29mX3RoZV9uZXh0X29iamVjdF9pbl93cml0ZWJh
Y2subWJ4DQo+ID4gaHJpc3RvQGJveCB+L3N3L2xpbnV4ICQgZ2l0IGFtIC4vMjAyNjAyMjVfaHJp
c3RvX2NlcGhfZG9fbm90X3NraXBfdGhlX2ZpcnN0X2ZvbGlvX29mX3RoZV9uZXh0X29iamVjdF9p
bl93cml0ZWJhY2subWJ4DQo+ID4gQXBwbHlpbmc6IGNlcGg6IERvIG5vdCBza2lwIHRoZSBmaXJz
dCBmb2xpbyBvZiB0aGUgbmV4dCBvYmplY3QgaW4gd3JpdGViYWNrDQo+ID4gaHJpc3RvQGJveCB+
L3N3L2xpbnV4ICQgZ2l0IHNob3cgfCBoZWFkDQo+ID4gY29tbWl0IDE0ZjQ5NGNlZmQwYTQ5YWJm
NDFkNDU1YjRjM2EzMGQ3OGJhMWY5MWINCj4gPiBBdXRob3I6IEhyaXN0byBWZW5ldiA8aHJpc3Rv
QHZlbmV2Lm5hbWU+DQo+ID4gRGF0ZTogICBXZWQgRmViIDI1IDE5OjA3OjU2IDIwMjYgKzAyMDAN
Cj4gPiANCj4gPiAgICAgY2VwaDogRG8gbm90IHNraXAgdGhlIGZpcnN0IGZvbGlvIG9mIHRoZSBu
ZXh0IG9iamVjdCBpbiB3cml0ZWJhY2sNCj4gPiAgICAgDQo+ID4gICAgIFdoZW4gYGNlcGhfcHJv
Y2Vzc19mb2xpb19iYXRjaGAgZW5jb3VudGVycyBhIGZvbGlvIHBhc3QgdGhlIGVuZCBvZiB0aGUN
Cj4gPiAgICAgY3VycmVudCBvYmplY3QsIGl0IHNob3VsZCBsZWF2ZSBpdCBpbiB0aGUgYmF0Y2gg
c28gdGhhdCBpdCBpcyBwaWNrZWQgdXANCj4gPiAgICAgaW4gdGhlIG5leHQgaXRlcmF0aW9uLg0K
PiA+ICAgICANCj4gPiBocmlzdG9AYm94IH4vc3cvbGludXggJCBzaGEyNTZzdW0gLi8yMDI2MDIy
NV9ocmlzdG9fY2VwaF9kb19ub3Rfc2tpcF90aGVfZmlyc3RfZm9saW9fb2ZfdGhlX25leHRfb2Jq
ZWN0X2luX3dyaXRlYmFjay5tYnggDQo+ID4gYTYyM2UxZjhmMDYwMDBlZmQ4NmIwNzgxMTRiYTQx
YzRmMDc5YjVjMTQwY2RjODM0MmU2OTkzYmI5ZDI5OTg1MSAgLi8yMDI2MDIyNV9ocmlzdG9fY2Vw
aF9kb19ub3Rfc2tpcF90aGVfZmlyc3RfZm9saW9fb2ZfdGhlX25leHRfb2JqZWN0X2luX3dyaXRl
YmFjay5tYngNCj4gPiA+IA0KPiANCj4gWWVhaCwgSSB3YXMgYWJsZSB0byBhcHBseSB0aGUgcGF0
Y2ggb24gdjcuMC1yYzEuIDopIEJ1dCBJIHRyaWVkIHRvIGFwcGx5IG9uIHRoZQ0KPiBlYXJsaWVy
IHZlcnNpb25zIGJlY2F1c2Ugc29tZWhvdyB4ZnN0ZXN0cyB3YXMgZmFpbGluZyB3aXRoIHRoZSBr
ZXJuZWwgY3Jhc2ggb24NCj4gNi4xOSByZWxlYXNlIGZvciBDZXBoRlMga2VybmVsIGNsaWVudC4g
QW5kIEkgYW0gdHJ5aW5nIHRvIGludmVzdGlnYXRlIHdoYXQgdGhlDQo+IGhlbGwgaXMgZ29pbmcg
b24uIFNvLCBsZXQncyBzZWUgd2hhdCBJIHdpbGwgaGF2ZSBmb3IgdjcuMC1yYzEuIDopIEl0IGNv
dWxkIGRlbGF5DQo+IHlvdXIgcGF0Y2ggdGVzdGluZy4NCj4gDQo+IA0KDQpUaGUgeGZzdGVzdHMg
cnVuIHdhcyBzdWNjZXNzZnVsIG9uIHY3LjAtcmMxIHdpdGggYXBwbGllZCBwYXRjaC4gSSBkaWRu
J3QgZm91bmQNCmFueSBuZXcgaXNzdWVzLiBTbywgdGhlIHBhdGNoIGhhc24ndCBpbnRyb2R1Y2Vk
IGFueSByZWdyZXNzaW9uLg0KDQpSZXZpZXdlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2
YS5EdWJleWtvQGlibS5jb20+DQoNClRoYW5rcywNClNsYXZhLg0K

