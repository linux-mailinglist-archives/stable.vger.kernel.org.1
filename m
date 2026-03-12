Return-Path: <stable+bounces-224900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGa/EMz6smmLRAAAu9opvQ
	(envelope-from <stable+bounces-224900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:41:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A43AD276ABF
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 18:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2F5D3114926
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F69E3FE356;
	Thu, 12 Mar 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QPFdjy8K"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748C717A2EA;
	Thu, 12 Mar 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337015; cv=fail; b=EHg2mclF+uxBqb0SngvCaeKGnDcVSxZpyHTm30K51rXhzcNHHrAJpLhUQKAp8/1v1/dG2ED4syXJSF6ybziieWzGqzRYVWUkiSZCSm8tN1ori/hMrBh5T7Nwja9EKMSeMGyA4Xm5XFoOGo8Tj5L8aynz9y0u5xiYCRBH+8EPxxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337015; c=relaxed/simple;
	bh=W5QJ395rlwVMKHCPsYu3FlQECnb/+oGOyzpNWNrBZ1g=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=um0NgGKMvinGStVbXg6B2oASON1zb9rjqmI9FFLz+U2TmN6J5s0GhjDnaZm1h59u4oKCeASWzxViTLrs85DSLgBCHiRaZbt5uM3bLI27vD6ZDWXuUPN8xQkQYiV/HYp3gun+M5ch43zkp6UMZ63S6UOuIVaNEUFVvnNEKIYmsj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QPFdjy8K; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CEWMss2301819;
	Thu, 12 Mar 2026 17:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=W5QJ395rlwVMKHCPsYu3FlQECnb/+oGOyzpNWNrBZ1g=; b=QPFdjy8K
	aKAsN5Kp4wUjdSaISqA1qOr7/AM1PTVv2Uaz0j1ZA0nOnLVuDUc/OBAQMd64wcB3
	+x/2DFtKcvD0FJejaLFrfoQ4DIijT1O6DB6OqLPo+mmXFx+iOBNIms2pOf09dkwF
	CSCOWi3TfJYYJTo0O+qt6AchuToJCJi7CwC85BXBWFAPYRB9dSXHMY+EaR84MpUF
	t1Tx0LZCvAp9iDNsmgV3Xpf5yKVeK+ne9z71rwaWR5Lmv0mfVvwuFELccMZWZmN6
	AzM56GfVa9iDnOPHmn4l5rtGi1f86Td8DOr9aj4u2YJe1uzxuE7xtC8JnS3njl1G
	adRwxgY8gyZAUg==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh95uwbh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 17:36:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gekq0awF/3a6hLzC0I7l98YLLUjwHOcBsSsk3TG8OrfInYsz6c7fW1R+NCtnbTMiSqdwEHrkeSksOnWvFx3DHT2GTBAbdIB9ZnFcFjdDgWPM7xrsHQ99kvsr03xS63x42g36O3QLLCKCBXhH4cBJNysudFevJyfiEecd644I/1bzjex27ChzWfKBc0yvpWxkaGYazhr0dKpF4jbnee2cJLTwzbTX0rBXMfpMF5CjemPVEYttNSOdJUN3+sPoEccwXI7QLnR/HRFXbTy0QV7lYd2ZdzZOtqMXpuAsPNXBk/WqzYkeQ+i6IBlDItV98mydycSroK6rm6OTFst5aT9/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5QJ395rlwVMKHCPsYu3FlQECnb/+oGOyzpNWNrBZ1g=;
 b=XokklqE6yeYEHXpSOjldel/GFDWzIcG88KBRcvjMMjDBHhQpOXh7tYWczpLx3HMyY0/qaXTxsNSWNHYapbsP4erF/aPwWXVTQ9ALOQlmq/cUi99lV13fthoQO/nFheu1nznXckI9ExznpyzO4FntHQK/2Ux8UqnNdih6oAnya49o5LmCbIwT9/1fTKAHeu4+Y9xYqCUl/RpAkdUuKPJqgpQZTiU23cnsPH94neMd6IaEgxhHckSls1MHJgYrALY7J2TLcqpA4zkDG4KbOMXCRlNZE0C6/+1HU1WOn0Md3IOxQLKLHyvrn5YLMKe52Mzl/xm/qNk59qRWFd8QWz0DVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB5514.namprd15.prod.outlook.com (2603:10b6:610:143::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 17:36:39 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 17:36:38 +0000
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
Thread-Topic: [EXTERNAL] Re:  [PATCH] hfsplus: fix held lock freed on
 hfsplus_fill_super()
Thread-Index: AQHcscZlUtL+PntFI0i7djFUt62CeLWrKgGA
Date: Thu, 12 Mar 2026 17:36:38 +0000
Message-ID: <77a8534a8b7922a1c0cf85f68fd8bda2bd7a61dc.camel@ibm.com>
References: <afab59a14da6ee4dd23d8ef85301ccff451b87cb.camel@ibm.com>
	 <20260312021728.446944-1-zilin@seu.edu.cn>
In-Reply-To: <20260312021728.446944-1-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB5514:EE_
x-ms-office365-filtering-correlation-id: 2df89e4d-4e38-44fa-9128-08de805dea78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 bNqRCgwn91klzJUROUEjXZ9hlu4ZBOTJh3WxR4VMq9H7jjgt1+8BiB2DeEvPVdYlB248pJPWzHtYlvT0T1AA/E4Zr7JjQXQRjuTj1D87LiFn7KfobMrvmYUA1dTZGlO1hNlEvdc39hNWijcOb17E92U8AuhzmvN0h0Ke/mOjZzTNK1fW80AjwYDYro5DIKu01unpDpEXCjzdqG+Zq6InSzlPkXoaTnxvX0BYqVgjFCZh0bdUM4Tqj8PpoOV3Dw8tFzXHunK+ODnQw0HcSk7PvQ/dEW+MUfJMlbC2PNHJK+wk5T9HF5+Jt2sKlBwUKYlvB5aVyijVw131kI7CKklDUo1udcdIzUJh85pCHQ0Zti7KcjFnlDs6N4zJ1CwpfxkBEbC7z9j43Abp5hVu/q3JaARCimYmL1hw+do18je9j1O+6P0/jI04Cvl76h/PXTfrvf+AS+9qcq0uO/Fj1H0muJIY4TEGFObBZTni77fbIBXTRUCsegTQJtgMEMmFXK5WeOUUcx/P0MCkRkD+VIJv4CI9WRprmtg5tYKn/txWeXXvzH3lTj30BWoabj4GBwZU+yXGQCm2FrdagL+6Sdokz9OBz/rLsH3WIZ35p1JCa2OIuDAPw0m4SMg8XlmCucDqrLg22INUn4U1TXiDYPYyLJnUzdnRjkZ/oS8sy+pY1iBu52eXxLJ/b+xfEfsATXAPeheP8QhKVm4xceVvtjTcYtrwWhF33bAxznkEuBdo+V3KZ+SKWhH1uE5EnsiU87sNk9c+d+bQie4uvdphDpASUJbtouYCRbUw7qTq8VwR0BI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDQwZ3M5VUs5WkhsbUw2Vzg5THlFbmIxVTF4VTNQeFM4b2dxZUoxdXRaNmpZ?=
 =?utf-8?B?MHV2aHIvYk9hbmt2eDBPRjMyNXQyVHhhNjRUeVI2TnYrU0ZtUDhIZEgxVW9X?=
 =?utf-8?B?UnNjc0VZVzNtVDBxbklKVmxvT2c5UWtZQmR4cVJicTZyampNSEoxc3FVTllr?=
 =?utf-8?B?SUQ0bmZPL0IvWUtVUldrSi9oSkJSRDZTYnBTUndEcnJtelk3Z1lua3hqUGZm?=
 =?utf-8?B?bTlrai9rT1loRkNNc2VZNmhReGtjQ20wL0lOcG81TGxaTUd1OUEwcmNWbnNX?=
 =?utf-8?B?VVpORDgxM1R0eVNJUmFpNG1WMm9Rb3Y2RGVkZjdjSzhYZHlFV2pwd0xnWWY3?=
 =?utf-8?B?azFwNmVSZ1NhOUxNWGZjNUt1cmVHT3pCbDg4UVhaWkhVMXRMU1FQcUtkaU1j?=
 =?utf-8?B?UEl6b1B4WmlNLzkxdnRuR1o4KzZ4NG9KaTBLNk9YV0NwbEhLZy8rRWtCRkJH?=
 =?utf-8?B?YTNRQXJDSXZGcHB3MEtmOVl1emd0cG54QmJBekMvZE94VG4vK0syRE9aM1ZJ?=
 =?utf-8?B?Yjg3K05kczMzZXVQSjdkbk5XWEJKakRNMzdhZDZTVk9hc3Y4Y2hPUHgxWmZu?=
 =?utf-8?B?ckRQblpKbWFRZ2pjaDlYYkw1Q004YlJFQ21sVDFyNHltM0pVQm5QcVZubE1G?=
 =?utf-8?B?R09MTFloc0FhT3M3bWd2OEc3RUxYSFBqWW5oUUU3ZitwTVcrRWtXcXZzaDc5?=
 =?utf-8?B?dk5Xdm5rM2tTR2g4OFZzWWtVR0xyNnMrSTFkVFNJZng1ZmgvMGVuNUlhMnBu?=
 =?utf-8?B?cW5kWGx6R1FsS2J0dEg3VXIzYWNFd3g5NFF3MHExUVZXTU5ud0xNQ0pYMldz?=
 =?utf-8?B?bCs5SFdLdHNzaWczMUx6UGJhK2FURVQraE5oMEt3Y1BMaUZNejNIeUdMMFds?=
 =?utf-8?B?bEZJc2NtREZabWlrakhpNjJaSW0rcGlBSnp3Y3g2U1pjQ1RDMUVZbU95Mkkz?=
 =?utf-8?B?NysyRUN3K2piMVVoYW4xZUJJTkdmQU9MT1lraDBGT3N5bFBHaG5YemI2RUhm?=
 =?utf-8?B?cjQ3Z2RBZDkxRnZFbmMxblJOU2Zpbk9sLzBQNVpBZmRQRmlOZFFJNWl1VGRl?=
 =?utf-8?B?TWNjL0t4MFVZR1JBalFXRTRyRjFNelk3N292SkRwOUNIWnRibGYyNHVRTHN2?=
 =?utf-8?B?cEhLbkMwYm9qMmJIcGIzM09lZTk3R0J2TSt1VVBuUWI3YUxpSno4bVpFVE5I?=
 =?utf-8?B?eTB3M0RaQnAyMDhTa1pRZ3NyZjRaRVZFNWVsYmlzQmsrcVlZZlZlZUY0bCs0?=
 =?utf-8?B?by9OUEZqc2RuWFE5UEVjUENKWkxpZGlMYzg5MGpYMjJsUXdINnVOVy9GZFJ4?=
 =?utf-8?B?UHFnYWhyMTMxWVpVSHdmcFhhbHVHRzNUb2xjWWVKUllJTU1sa1BmS1V6ZzlY?=
 =?utf-8?B?RkR1WnlpN0grNHZFMmtLM2hSRitZV05FU3JEMEpRT3pxbG0vMkxSa2VSMmUr?=
 =?utf-8?B?WDFCYzVqMVVqanZ0QmR3SllONm4ycmkyemhXQ0w4bVlpcUF3OEVLNEIvU1RG?=
 =?utf-8?B?WXNyVlhZbWZjMFpwQjdUT3pMYU16NzJKUTdmV0pYRjIrY3owaUtrVXhKY0tQ?=
 =?utf-8?B?UXVocnF4VXQ2YVFScnIyWktWcEZpZzZQWWFFZ29wbnFFaGNyS2FwMFNxVnc0?=
 =?utf-8?B?MGJFUzNVajVGdWR2TjE5UlNPa200WUV6NDVtVFBBdHZkYXVYQkx4elM1TWdM?=
 =?utf-8?B?dHB1cmRjNjJ3MEhWbXd4SVAwcFFOdnA2NnFlbE50eTZKYmQ3YlFWYy83YWZZ?=
 =?utf-8?B?TjZ6c2ZXajJPYzFIRjVRakZNZU1DYmxGOWxDb1N6ZitONzNNbCtRSm9hMTgz?=
 =?utf-8?B?N2Fxb3c0emtjWVFxRCtoTWV4ZCszcm1hMUlwZVBINm5SNDBxNnFlY2I3UmFJ?=
 =?utf-8?B?bFRvWnFtaHVnaVNYNnBHb1hocEQyWjA2aWRRa1NwMzJtSU5ZZm5iMDNwUE9i?=
 =?utf-8?B?bHg0cnE0K0pERThRV2NVYk9aZTkyYjBZb01QMXpiVW1kbFE4ajYvMGRXWjlW?=
 =?utf-8?B?SmtpWUlIUEtjUEUwMmowdGJnTHRicnhmNnRSUUltanJpVGp0VURjT0dCUTlQ?=
 =?utf-8?B?dXZLRDJQVjU5SUNWYk5OdXEwQVlxNkRzNVZYYkdlSTJkM0plWm9pdjgyNTBP?=
 =?utf-8?B?L2xTbGJmbTVzY3RPOWlHOTdDaGhqWU5yVEpRVXBST0p5YmhCZmtJeXMwMWFY?=
 =?utf-8?B?RkJERFpvM28vMlVOWmltUEF4akdzU0h0Njl6ekxyVzJCa0tjeENVT1pTNXUw?=
 =?utf-8?B?WFRCSEdranAzUXhLMXFrSHJUL0RteStoTnJ0Smp4NHI4WElWOTNJMktWK0VE?=
 =?utf-8?B?L1NiR1VZamhMVjFNTXB4UDVuRnRZYTN6MExqamhRNjFnazNtc2lYM09vaGo3?=
 =?utf-8?Q?ywIZvcCkqLgoXOhsYJwKaGYqYs6bzSuqtJN8W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07A597030E7496439F025FDDE20C6335@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dRlfQEwZ8iiZnm1Sbj3gfw1RcmDUUq8ZFHZIgJAmOXtkckI7l2rGulHfvsRrtdd1cuq9jMKmAOkW9ctS1a0ZezAyYBZQLMRZwvb50FnPBWUVVV5EY9OwZ06ZRwaWDSuxtQzAcg4G9iJBbG062PjB+Nudn1NEnTgXYqTYNrkzDMDeYwZIktsBk7X9IeaHiV9iZT/DMo4l5rc6X8EvYfGgw4FcyJbbF+pPtymioEjxoLNW3kLdsjkVYSy6ZBTrPt3+x1k7VRs/2pGOtZhxKijE/aFDtZTWfGGsJHEVQie1UhhLFiXnlSb9mMAvVMyUhY5Gt3u3DlruSIeEo3N2QD74cg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df89e4d-4e38-44fa-9128-08de805dea78
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 17:36:38.6834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTMqlGEDxCJQE2+i2sf2pog4szVx2v9ek/Er24nRVaC3zr+2mXi20GyU/mjfY6KW1uskiCcAoCicgBirFYsr0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5514
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDE0MSBTYWx0ZWRfX6wifz0Q3hpI4
 cYml1cmybCzO2jXjVMOVcnXA59Jn3LqSWpNRpAC/nGsVEnAtBhSNLp3QyAHBU9S/8j2+enQoZSC
 zXs4J4xzVeXJaLgikYbLesmq/J0NsyvFPmF8SSQTFfFcCdRMNS/TKOCyq+ObIGSugXsUouI2W0s
 C4R7leN+ZjrOds/KIzzIOfxxwI1v55XGPcM3bStbV8i1MAaBQCxk4TUs7YxjSqwhHpFHuqzHzgs
 XcJMPkjytGGan8ESppHb9iP5Dqv51sg0zAC9yHDbehTdctjESRkLw4Pz5d/RSeEI0d6YtyjuiNE
 c4kRZJlQPZip8WTvsfUk3S5PuAJMDEy+fyUrVj4n0Du5HKZyXC783uEar4SmyH4X4+svwzZpJ/I
 SgMlXpdXyCQ8RYWZ7OOwyLmvEol+xVjAhNKghVg57ZvD25gvapP4oPrlAICqJBS0h/kD6R3fx3M
 PVEH4zsoA11RS4RTEXg==
X-Authority-Analysis: v=2.4 cv=FowIPmrq c=1 sm=1 tr=0 ts=69b2f9aa cx=c_pps
 a=NwWuzY5ekLRC++Nx77IK4w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=wCmvBT1CAAAA:8 a=A_CSCt3RQoQpL3P2VUsA:9
 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: IgvjJjFJVdQOQu_TCaQS4nsDPtSJ2ABa
X-Proofpoint-ORIG-GUID: IgvjJjFJVdQOQu_TCaQS4nsDPtSJ2ABa
Subject: RE:  [PATCH] hfsplus: fix held lock freed on hfsplus_fill_super()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120141
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224900-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A43AD276ABF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEwOjE3ICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBP
biBXZWQsIE1hciAxMSwgMjAyNiBhdCAwOToxNzo1OVBNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5
a28gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDI2LTAzLTExIGF0IDE5OjQzICswODAwLCBaaWxpbiBH
dWFuIHdyb3RlOg0KPiA+ID4gIGZzL2hmc3BsdXMvc3VwZXIuYyB8IDQgKysrLQ0KPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2ZzL2hmc3BsdXMvc3VwZXIuYyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0K
PiA+ID4gaW5kZXggNzIyOWE4YWU4OWY5Li5mMzk2ZmVlMTlhYjggMTAwNjQ0DQo+ID4gPiAtLS0g
YS9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gPiA+ICsrKyBiL2ZzL2hmc3BsdXMvc3VwZXIuYw0KPiA+
ID4gQEAgLTU2OSw4ICs1NjksMTAgQEAgc3RhdGljIGludCBoZnNwbHVzX2ZpbGxfc3VwZXIoc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiA+ID4gIAlpZiAo
ZXJyKQ0KPiA+ID4gIAkJZ290byBvdXRfcHV0X3Jvb3Q7DQo+ID4gPiAgCWVyciA9IGhmc3BsdXNf
Y2F0X2J1aWxkX2tleShzYiwgZmQuc2VhcmNoX2tleSwgSEZTUExVU19ST09UX0NOSUQsICZzdHIp
Ow0KPiA+ID4gLQlpZiAodW5saWtlbHkoZXJyIDwgMCkpDQo+ID4gPiArCWlmICh1bmxpa2VseShl
cnIgPCAwKSkgew0KPiA+ID4gKwkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiA+ID4gIAkJZ290byBv
dXRfcHV0X3Jvb3Q7DQo+ID4gPiArCX0NCj4gPiA+ICAJaWYgKCFoZnNfYnJlY19yZWFkKCZmZCwg
JmVudHJ5LCBzaXplb2YoZW50cnkpKSkgew0KPiA+ID4gIAkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0K
PiA+ID4gIAkJaWYgKGVudHJ5LnR5cGUgIT0gY3B1X3RvX2JlMTYoSEZTUExVU19GT0xERVIpKSB7
DQo+ID4gDQo+ID4gTWFrZXMgc2Vuc2UuDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IFZpYWNoZXNs
YXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQo+ID4gDQo+ID4gRnJhbmtseSBzcGVha2lu
ZywgSSB0aGluaywgcG90ZW50aWFsbHksIHdlIGNhbiBpbnRyb2R1Y2Ugc3RhdGljIGlubGluZSBm
dW5jdGlvbg0KPiA+IGZvciB0aGlzIGNvZGU6DQo+ID4gDQo+ID4gCXN0ci5sZW4gPSBzaXplb2Yo
SEZTUF9ISURERU5ESVJfTkFNRSkgLSAxOw0KPiA+IAlzdHIubmFtZSA9IEhGU1BfSElEREVORElS
X05BTUU7DQo+ID4gCWVyciA9IGhmc19maW5kX2luaXQoc2JpLT5jYXRfdHJlZSwgJmZkKTsNCj4g
PiAJaWYgKGVycikNCj4gPiAJCWdvdG8gb3V0X3B1dF9yb290Ow0KPiA+IAllcnIgPSBoZnNwbHVz
X2NhdF9idWlsZF9rZXkoc2IsIGZkLnNlYXJjaF9rZXksIEhGU1BMVVNfUk9PVF9DTklELA0KPiA+
ICZzdHIpOw0KPiA+IAlpZiAodW5saWtlbHkoZXJyIDwgMCkpDQo+ID4gCQlnb3RvIG91dF9wdXRf
cm9vdDsNCj4gPiAJaWYgKCFoZnNfYnJlY19yZWFkKCZmZCwgJmVudHJ5LCBzaXplb2YoZW50cnkp
KSkgew0KPiA+IAkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiA+IAkJaWYgKGVudHJ5LnR5cGUgIT0g
Y3B1X3RvX2JlMTYoSEZTUExVU19GT0xERVIpKSB7DQo+ID4gCQkJZXJyID0gLUVJTzsNCj4gPiAJ
CQlnb3RvIG91dF9wdXRfcm9vdDsNCj4gPiAJCX0NCj4gPiAJCWlub2RlID0gaGZzcGx1c19pZ2V0
KHNiLCBiZTMyX3RvX2NwdShlbnRyeS5mb2xkZXIuaWQpKTsNCj4gPiAJCWlmIChJU19FUlIoaW5v
ZGUpKSB7DQo+ID4gCQkJZXJyID0gUFRSX0VSUihpbm9kZSk7DQo+ID4gCQkJZ290byBvdXRfcHV0
X3Jvb3Q7DQo+ID4gCQl9DQo+ID4gCQlzYmktPmhpZGRlbl9kaXIgPSBpbm9kZTsNCj4gPiAJfSBl
bHNlDQo+ID4gCQloZnNfZmluZF9leGl0KCZmZCk7DQo+ID4gDQo+ID4gQmVjYXVzZSwgaGlkaW5n
IHRoaXMgY29kZSBpbnRvIHNtYWxsIGZ1bmN0aW9uIHdpbGwgcHJvdmlkZSBvcHBvcnR1bml0eSB0
byBjYWxsDQo+ID4gaGZzX2ZpbmRfZXhpdCgpIGluIG9uZSBwbGFjZSBvbmx5IChhcyBmb3Igbm9y
bWFsIGFzIGZvciBlcnJvbmVvdXMgZmxvdykuDQo+ID4gDQo+ID4gV2hhdCBkbyB5b3UgdGhpbms/
DQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+IFNsYXZhLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgZmVl
ZGJhY2ssIFNsYXZhLg0KPiANCj4gV2hpbGUgSSBzZWUgdGhlIG1lcml0IGluIHJlZmFjdG9yaW5n
IHRoaXMgaW50byBhIGhlbHBlciB0byBjZW50cmFsaXplIHRoZSANCj4gY2xlYW51cCwgSeKAmW0g
Y29uY2VybmVkIHRoYXQgZG9pbmcgc28gd291bGRu4oCZdCBhY3R1YWxseSBhY2hpZXZlIGEgc2lu
Z2xlIA0KPiBoZnNfZmluZF9leGl0KCkgY2FsbCB3aXRob3V0IGNvbXByb21pc2luZyB0aGUgcmVz
b3VyY2UgbGlmZWN5Y2xlLg0KPiANCj4gSW4gdGhlIGN1cnJlbnQgbG9naWMsIHdlIG5lZWQgdG8g
Y2FsbCBoZnNfZmluZF9leGl0KCZmZCkgYXMgZWFybHkgYXMgDQo+IHBvc3NpYmxl4oCUc3BlY2lm
aWNhbGx5IGJlZm9yZSBlbnRlcmluZyBoZnNwbHVzX2lnZXQoKSwgd2hpY2ggbWlnaHQgaW52b2x2
ZSANCj4gZnVydGhlciBJL08gb3Igc2xlZXBpbmcuIElmIHdlIHdlcmUgdG8gdXNlIGEgc2luZ2xl
LWV4aXQgZ290byBwYXR0ZXJuIGluIGEgDQo+IGhlbHBlciBmdW5jdGlvbiwgd2Ugd291bGQgZW5k
IHVwIGhvbGRpbmcgdGhlIHNlYXJjaCBkYXRhIGFuZCBpdHMgDQo+IGFzc29jaWF0ZWQgYnVmZmVy
cy9sb2NrcyBsb25nZXIgdGhhbiBuZWNlc3NhcnkuIFRvIG1haW50YWluIHRoZSBjdXJyZW50IA0K
PiBlYXJseS1yZWxlYXNlIGJlaGF2aW9yLCB3ZSB3b3VsZCBzdGlsbCBiZSBmb3JjZWQgdG8gc3By
aW5rbGUgbXVsdGlwbGUgDQo+IGhmc19maW5kX2V4aXQoKSBjYWxscyBhY3Jvc3MgZGlmZmVyZW50
IGJyYW5jaGVzIHdpdGhpbiB0aGF0IGhlbHBlciBhbnl3YXksIA0KPiB3aGljaCBkZWZlYXRzIHRo
ZSBwdXJwb3NlIG9mIHRoZSByZWZhY3RvcmluZy4NCj4gDQo+IEdpdmVuIHRoYXQgdGhpcyBpcyBh
IHN0cmFpZ2h0Zm9yd2FyZCBmaXggZm9yIGEgc3BlY2lmaWMgbGVhaywgSSBiZWxpZXZlIA0KPiBr
ZWVwaW5nIHRoZSBsb2dpYyBpbmxpbmUgcHJlc2VydmVzIHRoZSBvcHRpbWFsIHJlc291cmNlIHJl
bGVhc2UgdGltaW5nIA0KPiB3aXRob3V0IGFkZGluZyB1bm5lY2Vzc2FyeSBhYnN0cmFjdGlvbi4N
Cj4gDQoNCkkgbWVhbiByZWFsbHkgc2ltcGxlIHNvbHV0aW9uOg0KDQpzdGF0aWMgaW5saW5lDQpp
bnQgaGZzcGx1c19nZXRfaGlkZGVuX2Rpcl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGZzcGx1c19jYXRfZW50cnkgKmVudHJ5
KQ0Kew0KICAgIGludCBlcnIgPSAwOw0KDQoJc3RyLmxlbiA9IHNpemVvZihIRlNQX0hJRERFTkRJ
Ul9OQU1FKSAtIDE7DQoJc3RyLm5hbWUgPSBIRlNQX0hJRERFTkRJUl9OQU1FOw0KCWVyciA9IGhm
c19maW5kX2luaXQoc2JpLT5jYXRfdHJlZSwgJmZkKTsNCglpZiAoZXJyKQ0KCQlnb3RvIGZpbmlz
aF9sb2dpYzsNCg0KCWVyciA9IGhmc3BsdXNfY2F0X2J1aWxkX2tleShzYiwgZmQuc2VhcmNoX2tl
eSwgSEZTUExVU19ST09UX0NOSUQsDQomc3RyKTsNCglpZiAodW5saWtlbHkoZXJyIDwgMCkpDQoJ
CWdvdG8gZnJlZV9mZDsNCg0KICAgICAgICBlcnIgPSBoZnNfYnJlY19yZWFkKCZmZCwgZW50cnks
IHNpemVvZigqZW50cnkpKTsNCg0KZnJlZV9mZDoNCiAgICAgaGZzX2ZpbmRfZXhpdCgmZmQpOw0K
ZmluaXNoX2xvZ2ljOg0KICAgICByZXR1cm4gZXJyOw0KfQ0KDQpzdGF0aWMgaW50IGhmc3BsdXNf
ZmlsbF9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgZnNfY29udGV4dCAqZmMp
DQp7DQogIDxza2lwcGVkPg0KDQogIGVyciA9IGhmc3BsdXNfZ2V0X2hpZGRlbl9kaXJfZW50cnko
c2IsICZlbnRyeSk7DQogIGlmIChlcnIpDQogICAgICBnb3RvIHByb2Nlc3NfZXJyb3I7DQoNCgkJ
aWYgKGVudHJ5LnR5cGUgIT0gY3B1X3RvX2JlMTYoSEZTUExVU19GT0xERVIpKSB7DQoJCQllcnIg
PSAtRUlPOw0KCQkJZ290byBmaW5pc2hfbG9naWM7DQoJCX0NCgkJaW5vZGUgPSBoZnNwbHVzX2ln
ZXQoc2IsIGJlMzJfdG9fY3B1KGVudHJ5LmZvbGRlci5pZCkpOw0KCQlpZiAoSVNfRVJSKGlub2Rl
KSkgew0KCQkJZXJyID0gUFRSX0VSUihpbm9kZSk7DQoJCQlnb3RvIGZpbmlzaF9sb2dpYzsNCgkJ
fQ0KCQlzYmktPmhpZGRlbl9kaXIgPSBpbm9kZTsNCg0KICA8c2tpcHBlZD4NCn0NCg0KRG9lcyBp
dCBtYWtlcyBzZW5zZSB0byB5b3U/DQoNClRoYW5rcywNClNsYXZhLg0K

