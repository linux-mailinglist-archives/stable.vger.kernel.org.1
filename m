Return-Path: <stable+bounces-86517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5669A0E00
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E01C224ED
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A3F20C03F;
	Wed, 16 Oct 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iH2DOCHg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iwcdMw3w"
X-Original-To: stable@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163E42076B3;
	Wed, 16 Oct 2024 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092066; cv=fail; b=QbcgFmC1XiWRP9NtGnEgAYoFENfrYYQ3ikfrAn6TEpq4hQn0XDFy5E+eYkrLSFZEV/UBEWmg3BZrbOsJXAZsodRXQpYnUwxCTDDU5LcykgH194qDcK/sakMbv/jAT4h/W+U+OFhUm2+/kFmejjqR88q2KxpwGJYCgSymXsadREE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092066; c=relaxed/simple;
	bh=ZW54+pq+O59kaiuEBQSraNo2/RWao29+D9xCoc3UTwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s00KRYyieyyKyeii/N7a94FEXK5Ti7NxDYFwBVM+wPnD84SCgukPuCJ7EjE269ErKl7TplKsCIMQURbS0pZCEAO6QEspE00lzSQC+6wRTc7uhmgEkfwKbZ0QbFE7zs5ER74/UzFtcuTd6kxE3Ac2sSrRm5agHtDQZSzf+izpwm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iH2DOCHg; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iwcdMw3w; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729092063; x=1760628063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZW54+pq+O59kaiuEBQSraNo2/RWao29+D9xCoc3UTwQ=;
  b=iH2DOCHguZpiJQrObH5SVkPxlHEFCIacpLUybLVRlWgp3+Marn6XOCAx
   5YY0FwGlGUiZ8bly2JHzIxT1l7FMfj58DPKgqdZ5Mx+hm9smVRR6XGdVG
   dyN4uGtMgUKImLbK/zEpEf9z2eJs5D5KszDvrR7uoVR75hVD5YEzt/3pG
   ZDPnSrnS3lEHNppbcJEsS/TCDdCkUHmn2XwDwFXm1oiKfD11JKU0e744p
   17RrA/RwRrqWYyVD1FO/hSIgvhRskI/cP1gGKxsUcl79oo98UG2Jor9Qj
   XwokCWDTnpo5OKx1xCuj7cDMSlBCFKLkSEqCyajkeyRbrWdAsFC4EiFjI
   w==;
X-CSE-ConnectionGUID: C0IuRr4+TPy5ODJLAi1CXg==
X-CSE-MsgGUID: oDQGXoHLR8mjvc1a5HbraA==
X-IronPort-AV: E=Sophos;i="6.11,208,1725292800"; 
   d="scan'208";a="30046540"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2024 23:21:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efqfUGDiGgKAR5FGLbY4vubbZ7bdqgMrKHj1kPmFUjUXTD969Xd+AL1J56ybPrUl1rQubddNQQf9NaF/h6OHxI/uaN+04DkbjDo+T+OS3MJiAWW1FzWmw1CxuA68+zeGmHAl2cTplIDqRymN/wHzKqfbNxFB0EJUfXOjk3rwv5GDQ3ng/jL5CiOXMTJ0iSn1u1X3SzAnWEud/Bqs41l9ifqZ1sSMB52s/9VlYGBDCfvIY7RR09qjSRSNfNnv/oQsbAwFxPv8X8sphN0ThNvcAFDOTYp4zZxH+6X4UIvsh+oDbgKk2fLsBk7p+wACcjyCkyA2HL7XwGyhX0+tzm3ZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW54+pq+O59kaiuEBQSraNo2/RWao29+D9xCoc3UTwQ=;
 b=TMwIywuBr6Oe38BhNVfLrsAxVa7tezn8+7glcW8pJXFyogKo0RZt0v5vwqLoKvVbSOC/OgmTPL7p6rLg2CC2raPG5lH8XxtrKwpmn/l3H+VrSFVbhokKQfTbsOeHR9tfLg9zBhkHYY8Rva12o8xIR3qYpT7MaX+sBaSiGecYcSHgcgXj5qKHNHWaGVTFjQkgzMOoOvBvV6Rlh775wx6U1hfjCwjkNq30krFjXKjTL1gD6Cg8QsYRZ5ceBp+R1LT4Iw+i05An7SWMYt/g0hUmBLVKj/4HJcrIuybw9XulenkfpW3i1txwWifDWwhpJDn2YHUnC4TuIeg+wN3mGyZOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW54+pq+O59kaiuEBQSraNo2/RWao29+D9xCoc3UTwQ=;
 b=iwcdMw3wg7dpMiC1EDQOiTh5QPnPcHKdIPKfxj4WAMALVR9yPfExHMcZLCFp50rzqW03599z2xYxSsLQx2xcGCTtRdFZh4rXWI9Grk9yigRryyLJkfj4SlvKgZ3HiU8vwd/jJXeTXyrZbSVdggSQMQaUEtCCLBa+/qpZpD5Ycho=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH0PR04MB8452.namprd04.prod.outlook.com (2603:10b6:510:294::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Wed, 16 Oct
 2024 15:20:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 15:20:59 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
	<adrian.hunter@intel.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Use GFP_NOIO in ACMD22
Thread-Topic: [PATCH] mmc: core: Use GFP_NOIO in ACMD22
Thread-Index: AQHbHi7TFZSMk/o14kmdcXcmd7NitrKHkVSAgAHmQYCAAAe+cA==
Date: Wed, 16 Oct 2024 15:20:58 +0000
Message-ID:
 <DM6PR04MB65750E8C697235F8E0B42CA8FC462@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241014114458.360538-1-avri.altman@wdc.com>
 <18e66783-0fc7-4c55-8087-dc4212e851b4@intel.com>
 <CAPDyKFoXsgXNevDoCGTKSTwz-PfavfEHG5feyzEbeynRq3bDGw@mail.gmail.com>
In-Reply-To:
 <CAPDyKFoXsgXNevDoCGTKSTwz-PfavfEHG5feyzEbeynRq3bDGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH0PR04MB8452:EE_
x-ms-office365-filtering-correlation-id: c60f6665-bf98-42f5-4a1e-08dcedf6234b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YmY4YWRXSFcwR3ZacTNjNHBONFl3b1RFZVliblg4WThvUGtPMWJlMkxXWFpP?=
 =?utf-8?B?NUVnQmhSTGtJS3pwMWJuQ21BUlQ3NzcxUWwyZ0I5dm45elVwUUg0d0tWdWJL?=
 =?utf-8?B?SmYzU1hZVFZOeEgwZlFkb3pDSDFuZlhsa2UvZ1U4VUJTOXJ1enJZWGM2cWF3?=
 =?utf-8?B?T1Z0YTEvZ1M0dHhmV25jcStLeFdqTnc4ZGhVaVh3aHZxMjFYQUhuMWZ4S1g1?=
 =?utf-8?B?MGhxcExCZ1VVd1FsTkN6Z201ckpXcDczc3hZYUtWTFp1WUJpZjFKRW9yTGtJ?=
 =?utf-8?B?YXNmRW54U2Z2VGpFcVQ5aUdNZlJ6UlZyR05NVWd1bTZkOG5kanFHWFlSV2RM?=
 =?utf-8?B?ek5YenFreklmY2FYZEhmQkZnbVZjbzVoNFV0RXcrWFA2cWRhQ0hkUlpQa0JP?=
 =?utf-8?B?a3JXMG1WL1g4RlNISEtaMEM4Tkh1NHMybXYrTk50bGpkcFBPRHMxeDI1dUJQ?=
 =?utf-8?B?c0lmWlZSTlFOV2RKcWMrSU1lMGxjYUkweDQ5VjY5N3M5cWhza1NzYWkxQmpq?=
 =?utf-8?B?VEFvRWFiR2dXbEo4ZkZUNW1lc1lBV21qektDT3M4SWJrN2t1UGtQYVQrc1c1?=
 =?utf-8?B?WEtNU1M0YmJQTU90VEtHNWlTQkVueEl4Nk16SU1zNEJzYzNYVVZpUVdMWjEr?=
 =?utf-8?B?WUxDUHRkK3o2VzBEeDFlQitXRVJ5a1ZJMHJpZlIvU2FQR0NhZFRhcm9ackkz?=
 =?utf-8?B?NzhTTU9DSkQvZloxVXNjTzRjOUhYSklYTzRjV2JlSHBDZzJtZ2U4bUlRb2NS?=
 =?utf-8?B?b010RFF4YWVHcE5mNlViVFJ2VTlvTkZpMmRRZ1kwRGdrMTNrNVBJdVdUanlx?=
 =?utf-8?B?VjJPR3hlRU5NMEJ4OWRqU2k2TTZpZmNaQ3lMTkNhSlhhdnpjbGlnQVFYOEo1?=
 =?utf-8?B?Z2Izc2VXUkJnTXVuNVBFTDRWZ2c3Ym94bldCQlh4QXRBNnluRzZFamFnYUJ4?=
 =?utf-8?B?WngwcGt0NU1pd3A3bkQzVmpZSDRVdzAyTFFlak5UUFA4WDVGbWcrQjRSQU5a?=
 =?utf-8?B?dGNHc0NYYkJ3NFJWeXEvZTZaVTdOU1VXK3pRNUNBUEVsMDVHYlNIdE4zQ3pI?=
 =?utf-8?B?Y0pIMHg5c0x3eEZsZzFnMENDa2tjb0dlY1cwZnNHT0NJdWRlNnRSNzY4UXdW?=
 =?utf-8?B?c0Fqb0U1MExIWjlPZFlZc1VWcytSUjJMK0pSZkQ1ZEJYQzE0NW5QK0w2QTJE?=
 =?utf-8?B?QjVEc0lLTTcrV3MxUElQRlJ0OHZPSlhhWjFKZkpRVER5SWU1T09iK1JUUVYz?=
 =?utf-8?B?S2FBTVZDWVRkeEViRTRMRFNDaU1ISkhpSmtwL3p5aHBUcWVNemhEcVpnc2l3?=
 =?utf-8?B?MVArbXhKQUhKVVdEQ2ZQZ1BybGlRU1lyUzZXbzJLZWlYdWNGSXpVT3VyaHBH?=
 =?utf-8?B?bTUyUmFpZVRsZS9UcytCVVNSSUk5R1M1cTF0ZGRQb0JDZGpjV1daMy9IRTRW?=
 =?utf-8?B?Z2g4ZnpIWGVBc2xmTmJHdkZ3a3VUS0U5OUkxaWRFSkowQW5oblBXUnFvVitl?=
 =?utf-8?B?czR5dUZ5TUhpY3UyOE0yUkdmVVFrckk3TGxSaEpsblFxNW5YSHFqZXpkbVJC?=
 =?utf-8?B?WmFXSFNmdTg3VmR1ekhUanFNd3IvZEZjV21LdlVZc09pKy9hYzhETE5PM0Fn?=
 =?utf-8?B?OS9aU0tEYU8vNS9MaVZVczd2a0locG1EeVUwUVptMStremxPTkJmWW50cGtE?=
 =?utf-8?B?SGpJTEpTN25aQUtpR2NTMjQ0Nkl6LzhPYXZzTkxGbUFYVStXTmpKOERRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cnpTMFc0TGRnMTQvaWdxTjY1eXB5TVIxTS8wRk0ydGowaFlXTGcxdWNBOXMv?=
 =?utf-8?B?a0k5NEJLUWNrL2plc3pMNHhtWnlkL3FFSEI3YnZ3WHZwcjhWSEh1aDZQRmg0?=
 =?utf-8?B?M0daRUtpa25rNEM1ZHdBYUd6LzEyaEdvT1NobVlTRHVrVWRTWCsvTGFlMklu?=
 =?utf-8?B?RFJyQ0Iyd2l1RU5sL0xkZkN5alZEOUFwQkdKN1JVZ2RBZ2I4NDZaTWVxekwr?=
 =?utf-8?B?QTVDcmVDNmdUbzJNN2lxZW9ONjY0bW5uU0x6OVZ1aHZ6REtuYWt2TFQ4T200?=
 =?utf-8?B?YXUzY2dSSC83VnhheCt5TWgzRUJBdGYxeHJ1aWRad3VCZ2hSbm1tSk1EWHU5?=
 =?utf-8?B?WXBwQnc3UmVNV2xTU3VPbHNLY1R2aTk4RzViUEo4N25SNTVUaEpRMlNJaE41?=
 =?utf-8?B?QmlmQld5dFVyc0UyUWdQQUJXZHFFUWlWckJpc05nRDRWUWQ5K2FlNEg3Skov?=
 =?utf-8?B?UDQxd0FiQkJLYVRLS3hYS1JOV3dZeTRsZm8zRzlEd2NaUkhLc2ZiVm0wRWNp?=
 =?utf-8?B?NlJuTTdycEEzRlFYSnFTbElpS3NRY2hqMUQyWnlNdXpTTXFDeVU5djNxSVVY?=
 =?utf-8?B?ZnBaUDhnbnlzei81ejQrcVJNMHdONHJodnRTK2piUVlqdEFUNTdRNmRYZFpq?=
 =?utf-8?B?UklPMlJpekNRcVFTeWNGN3lTWjFoUE1tcDBqMGM2RHEyRndWYkNSZHZCVG93?=
 =?utf-8?B?cXQ5OTBaZTVTektNQ1pGbEc2WFZVS09ERmVKdDY3YmI2TnNodzF5Q2tzcU1R?=
 =?utf-8?B?dmozbFZsdUJoaTd4Wlg1R05MU0tiMGp4L1NBdGdCQ1JDM2JTL3hybGdSaGk4?=
 =?utf-8?B?QmhqVFRjKzNXbUJRUG5sZkRDeWtBRFdoQVhBcmVWRHVqYndvSmRiQkZpVjVH?=
 =?utf-8?B?RTVpeDNmK1puMUppNkpxS2pOVHpraUUwaGNPbStiWUNRaFpUczhxTURoV0FR?=
 =?utf-8?B?NmFHakhESTVDTTkwQmZCRkRGRldoOE9ZTFlpZ3VhYmJhZTVOMkttUTBHWmN3?=
 =?utf-8?B?ZHZkT2Z6VDFuQlkweXJEai9jbmRIRFhBZzNiemFQdHVyUGtYblVOR1ZZTGk1?=
 =?utf-8?B?eEIyR0RuWXVlSHMremdqYXZIbVF6dUYrUnVYWEVob3R5ZFEweVgrTXpzTDJa?=
 =?utf-8?B?bHBJY2lEdU9HbnpmQTZhNURKZlI1cGlzOEVZT3RMVVVjeUd1cHFCdXJnd3Rs?=
 =?utf-8?B?TWxNQjhFaHc2RWcrMEhjT25URjJtVE1YNVVuRnlYMmFnN2Q4MklxS2dOc3dJ?=
 =?utf-8?B?RGR6U1JmQkxYUVlLQVE5OVpSYjFUVEs3SkdNY2JSTno4Z1hrNzFwYXcxQTBh?=
 =?utf-8?B?OHk2YzllNy8xblBRcVZhdXhONmg5TlhpSGdJYjU4YitKR2gwT1ZSV3MrSFZx?=
 =?utf-8?B?MUZpMWllQ1BIREtVV3ZmM1JrUGFNZ0xSRFpPRllGOTdXRUJCYTd1OHZYdmRD?=
 =?utf-8?B?bDlFZTVhRDJxRmFUQWJxSUNGTmE5TEtFSmpRNG9rKzQwT2c4emlsZS85dFM4?=
 =?utf-8?B?U3NtamFMeUpHNmROZk1YVXhjWkthMVBydGVHQVF5U0hHRms2YlBWWHBiTjBU?=
 =?utf-8?B?MzBWSW94RHBGYzlEV2RqeklYeXJINjljV1hYZFBnRFFzWnAxanhjbGNJMFVi?=
 =?utf-8?B?S3ZEV000bVRoVjdMczFNL3o4U1A5NnpIOUpDY2kyZTBaN1VXbGM4N1FvRUJQ?=
 =?utf-8?B?Q0xqVGNiYk1LL01pdjBVcTlmanFKQ1hpRit2R0Z3TVlvcnl2L3RkUXd6TkxO?=
 =?utf-8?B?SFFRVDFxNDk1VXdMTFpwdzRKME1PNjF6VW1FQmtweVlYOTFVdWxHSVJNOS9M?=
 =?utf-8?B?MlNDVmRNRTgxd0xDL3NCeDZxU1dnYnpzRVNtTlBZSWlIK1VqbjU3M241aDZU?=
 =?utf-8?B?eWR2VmpTUVhLMlpDMEZqNFhvMUFFNnRzZ0VwbWw1UDZOZThWMTc4bS9kZkdZ?=
 =?utf-8?B?R2NSNFp2MXJ3MG04T2phelIrNWtpNEV0SkRiWkhaK3JoMUtjNzZSQnRTVjNL?=
 =?utf-8?B?eTMwVHNuSGFjZnlOZDdCUFZJOExDZ1pJOEFNcHRUelczYlBIUit4bFY5ditv?=
 =?utf-8?B?bkNkVUgvaG80M2dmeGVtcEw1bVI1aTNKWmkyR2dxUVRNY3VWVkwvT3A5Ty9D?=
 =?utf-8?B?WFBhd1RXelhmRUVrdkZkN0ZYOTlFSEVvMWlHaDRoeXVGNTdTSzFIL1JjQnZy?=
 =?utf-8?Q?MGUYnk00eXD/zsd7Jefo83SDg9F8VaiWHR53PlzffUrd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WdIdA3mDPe+Z6NSKj1+p2JBpWfF8yqpNuRpsgIJ5qnzo/sTKeNh7PJHD3+tSEYNKjjnjvPGXfRebTNH2MUbJZgiFErt9SWOFGmThpiiInQy1pbRqRWOtMA4uUwa6UntYyZ7exFx1oSK3wlndgT0bD/Ltz9ERGnztJ1Ba1OAcyxxUbICjvEnzWFkDW3m3YX9OYyPf7mv4QX5x2EsBQTwUKWLTOSks+rdqVqq9HWHmOCNqFBbZOLPviKGCk5nmnTtjboxVJYlsBNSeIM6s4lFBj9XZSseil+sModDPGb1+hN6D23HurTDkV6wAGp8iOowuj+m0vAD1sxlSKhrwJKgAa/avREkezY/1TDHlxNSLJjaqvlKxImeZRfVUEOMZaybdqlR/6+Oyw9gHQyvc1hi12HK8k5d+rM2y8uuRiC1bl3uiYJXGm6pYznymAkoyzrxQbroOVysiNh+ZIdWaQHzXV1Mq0lI3yPDIatK8cUDE25FbTTugK2VB+PciuGeZzpergKC0bxrapWVnyy8OU42L5bw8+LRX0M+vQkLGCLpEsZcBTQX8CzKPZK1u1nPJy75cdjRumHJoK7JBUFEROKCrhlFdnkFCt5Tv5DAM4wyz4TwnhRtqCNZmA9dyR5GgmmR5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60f6665-bf98-42f5-4a1e-08dcedf6234b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 15:20:58.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1trEx4LDFEuFUNZxrCMDN00V0a6HDENLfLbvRKzcoPjHpJZN0Ql9BwhJycZxL+mWsOxYdVzrepTxKhNvky5UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8452

PiBPbiBUdWUsIDE1IE9jdCAyMDI0IGF0IDExOjQ0LCBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVu
dGVyQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiAxNC8xMC8yNCAxNDo0NCwgQXZy
aSBBbHRtYW4gd3JvdGU6DQo+ID4gPiBXaGlsZSByZXZpZXdpbmcgdGhlIFNEVUMgc2VyaWVzLCBB
ZHJpYW4gbWFkZSBhIGNvbW1lbnQgY29uY2VybmluZw0KPiA+ID4gdGhlIG1lbW9yeSBhbGxvY2F0
aW9uIGNvZGUgaW4gbW1jX3NkX251bV93cl9ibG9ja3MoKSAtIHNlZSBbMV0uDQo+ID4gPiBQcmV2
ZW50IG1lbW9yeSBhbGxvY2F0aW9ucyBmcm9tIHRyaWdnZXJpbmcgSS9PIG9wZXJhdGlvbnMgd2hp
bGUNCj4gPiA+IEFDTUQyMiBpcyBpbiBwcm9ncmVzcy4NCj4gPiA+DQo+ID4gPiBbMV0gaHR0cHM6
Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtbW1jL21zZzgyMTk5Lmh0bWwNCj4gPiA+DQo+
ID4gPiBTdWdnZXN0ZWQtYnk6IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
Pg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5jb20+
DQo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gLS0tDQo+ID4gPiAgZHJp
dmVycy9tbWMvY29yZS9ibG9jay5jIHwgMTAgKysrKysrKysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5j
DQo+ID4gPiBpbmRleCAwNGYzMTY1Y2Y5YWUuLjA0MmIwMTQ3ZDQ3ZSAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ID4gKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9ibG9jay5jDQo+ID4gPiBAQCAtOTk1LDYgKzk5NSw4IEBAIHN0YXRpYyBpbnQgbW1jX3NkX251
bV93cl9ibG9ja3Moc3RydWN0DQo+IG1tY19jYXJkICpjYXJkLCB1MzIgKndyaXR0ZW5fYmxvY2tz
KQ0KPiA+ID4gICAgICAgdTMyIHJlc3VsdDsNCj4gPiA+ICAgICAgIF9fYmUzMiAqYmxvY2tzOw0K
PiA+ID4gICAgICAgdTggcmVzcF9zeiA9IG1tY19jYXJkX3VsdF9jYXBhY2l0eShjYXJkKSA/IDgg
OiA0Ow0KPiA+ID4gKyAgICAgdW5zaWduZWQgaW50IG5vaW9fZmxhZzsNCj4gPiA+ICsNCj4gPiA+
ICAgICAgIHN0cnVjdCBtbWNfcmVxdWVzdCBtcnEgPSB7fTsNCj4gPiA+ICAgICAgIHN0cnVjdCBt
bWNfY29tbWFuZCBjbWQgPSB7fTsNCj4gPiA+ICAgICAgIHN0cnVjdCBtbWNfZGF0YSBkYXRhID0g
e307DQo+ID4gPiBAQCAtMTAxOCw5ICsxMDIwLDEzIEBAIHN0YXRpYyBpbnQgbW1jX3NkX251bV93
cl9ibG9ja3Moc3RydWN0DQo+IG1tY19jYXJkICpjYXJkLCB1MzIgKndyaXR0ZW5fYmxvY2tzKQ0K
PiA+ID4gICAgICAgbXJxLmNtZCA9ICZjbWQ7DQo+ID4gPiAgICAgICBtcnEuZGF0YSA9ICZkYXRh
Ow0KPiA+ID4NCj4gPiA+ICsgICAgIG5vaW9fZmxhZyA9IG1lbWFsbG9jX25vaW9fc2F2ZSgpOw0K
PiA+ID4gKw0KPiA+ID4gICAgICAgYmxvY2tzID0ga21hbGxvYyhyZXNwX3N6LCBHRlBfS0VSTkVM
KTsNCj4gPg0KPiA+IENvdWxkIGhhdmUgbWVtYWxsb2Nfbm9pb19yZXN0b3JlKCkgaGVyZToNCj4g
Pg0KPiA+ICAgICAgICAgbWVtYWxsb2Nfbm9pb19yZXN0b3JlKG5vaW9fZmxhZyk7DQo+ID4NCj4g
PiBidXQgSSBmZWVsIG1heWJlIGFkZGluZyBzb21ldGhpbmcgbGlrZToNCj4gPg0KPiA+ICAgICAg
ICAgdTY0IF9fYWxpZ25lZCg4KSAgICAgICAgdGlueV9pb19idWY7DQo+ID4NCj4gPiB0byBlaXRo
ZXIgc3RydWN0IG1tY19jYXJkIG9yIHN0cnVjdCBtbWNfaG9zdCBpcyBiZXR0ZXI/DQo+ID4gVWxm
LCBhbnkgdGhvdWdodHM/DQo+ID4NCj4gDQo+IEkgaGF2ZSBubyBzdHJvbmcgb3Bpbmlvbi4NClRo
ZW4gSSB3b3VsZCB2b3RlIHRvIHN0YXkgd2l0aCBBZHJpYW4ncyBvcmlnaW5hbCBOT0lPIHN1Z2dl
c3Rpb24sIGJlY2F1c2U6DQoxKSBNeSB0ZXN0aW5nIHNob3dzIHRoYXQgbW1jX3NkX251bV93cl9i
bG9ja3MoKSBpcyBoYXJkbHkgYmVpbmcgaGl0LCBhbmQNCjIpIHRoYXQgYWxsb2NhdGlvbiBpcyB3
aXRoaW4gdGhlIHdyaXRlIHRpbWVvdXQgYW55d2F5DQoNClNvIHVubGVzcyB5b3Ugd2FudCBpdCBv
dGhlcndpc2UsIHdpbGwgcmVtb3ZlIHRoZSByZWR1bmRhbnQgbWFjcm8gY2FsbCBhbmQgcmUtc3Bp
bi4NCg0KVGhhbmtzLA0KQXZyaQ0KPiANCj4gQSB0aGlyZCBvcHRpb24gY291bGQgYmUgdG8gYWxs
b2NhdGUgdGhlIGJ1ZmZlciBkeW5hbWljYWxseSBpbiB0aGUgc3RydWN0DQo+IG1tY19jYXJkIHdo
ZW4gcHJvYmluZyB0aGUgbW1jIGJsb2NrIGRldmljZSBkcml2ZXIsIGJhc2VkIG9uDQo+IG1tY19j
YXJkX3NkKCkgcmV0dXJuaW5nIHRydWUuDQo+IA0KPiBpZiAobW1jX2NhcmRfc2QoKSkNCj4gICAg
Y2FyZC0+aW9fYnVmID0gZGV2bV9rbWFsbG9jKCZjYXJkLT5kZXYsIDQsIEdGUF9LRVJORUwpOw0K
PiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==

