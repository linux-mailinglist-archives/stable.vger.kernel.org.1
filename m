Return-Path: <stable+bounces-255082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCKhIOmGGGq6kggAu9opvQ
	(envelope-from <stable+bounces-255082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:18:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0F35F62E5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA253310E361
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242973FF1BC;
	Thu, 28 May 2026 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jmnyVQqb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B39A2BEC3F;
	Thu, 28 May 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992084; cv=fail; b=EHgdBEee0yCsMx0Gs3wUrdJimsahDGYjSE7kN4cneGALtpmnfVh5ExWrj80c0sTqyp+ATGU1W+SKV8RvBo8YJK8jMnC0LbOomzadjDQYVyU8f/AifwX3H1Q9HGaiKhQVwencYwUf1WrPaKArDuvjDynGkH6eVQF02qVsVHEV3QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992084; c=relaxed/simple;
	bh=RMBt2CQd9k2RGs1ekr+3lUc54b/TQi4eAtq0cHrBsw0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ZXXvYCtOmNCaXGqMPi6F3gO0NTYEK/f2oiSvEOBrU1eYowY3ygO/uTNTXctMmdFPhziNAi4EDwvXsE9x0+9drYZTOU7Y0uD756IZvvyVNG5OPJ9zvs0mk/Dytulfw+0RYZ9VQ/OaanNJbqi6ShEeEWkbL42DJmfVnYSLW9Osxy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jmnyVQqb; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SBHRPs3784371;
	Thu, 28 May 2026 18:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=RMBt2CQd9k2RGs1ekr+3lUc54b/TQi4eAtq0cHrBsw0=; b=jmnyVQqb
	UIphBL1ssWf3FE9wfqYW/4O2QDS6vpaUXcNG4Dsqk064Cs2b7Ht/hvJPxgOod88z
	5GK4k7DTk994lfMMwVTe4GmYJXae8VF9PXeDKT0oOgOsKQDQh/mC+tSPHoOhY74D
	5ATSTobm9klu4AwUzboe89vwn/H2QxibSXIntxbkv9B9tuNF1nWUA53sxBCnBpzG
	0XMEJEd7lpgGuumzWkpe8tHC1rHizyqu9F9VywJ8rKLNGLyrvuSEnwPc2T8yleJb
	JYKN7HCXwGjUlXuAepQVnGz9FTyBPSacsILqh4yO3qNG/k9nZh/fHWczo2NuXxuO
	yo1Ck5lhb/jP9g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889c8wn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 18:14:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvCoIJJoaV0IdVof1kI1ezbHXcxKJX9fSaTy4Hl4WgMlAyBniXUDsRjXA88qFkle9p97Zb1Yhzo9QgkByQ5M4wJSvMgNo3eCcqq45xsu4nkmsOA9aLVeR7ckK926Ec9rPgpaPwPEcjI9tzurUfJ0owOV17Vg/0aiWF02J3M2Q4iT4yxZ85qYDhgX6fM/DtHWoUnTle/sbg53TY8CN0ALl/7dUvOv2feqWX3hrA/IImjPP/q1EwKDj8soEkO4wDcZzfppdJNt2tQfHO0oclXDmrRXJFg9gMiyNE/3ociGNltBvWcfM3MJsQ5/QxJQ6i453Xjxdc3x86G2saEsK9ufBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMBt2CQd9k2RGs1ekr+3lUc54b/TQi4eAtq0cHrBsw0=;
 b=sHjpWp/1KxY5BCJxyo9b81Hwzb0StD9Q881Xq1FFBmgVJ6SQXb6+izvqi50Y8Sr3UFyEesg1gYvE0jre1ttFujlCeElM0X1Nqyc/ostznoVql+tiRG+5J7HrOg4EsyX1Z18G3meTTUYSKbhTZsSyCuOrufCwvdOWUZbLOE5l+6JHnnWsLZz9KeCgWW9CeuImdbxqfsOtgMLUxV0EpIQgWoYE+sfZi7CIifcmxdZ52o0JcwftGD39LZG17D4v6w2b80xrTE7InFxEctsB2xePmZ5e/BO1qSpY2qnq8NQYv8tGH9ON+wYidg5klXProA4b7Tq2Q+KQkahsbksAwhBtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6141.namprd15.prod.outlook.com (2603:10b6:8:114::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Thu, 28 May
 2026 18:14:38 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 18:14:38 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "jhapavitra98@gmail.com"
	<jhapavitra98@gmail.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] ceph: fix multiple unsafe decodes in
 decode_locker()
Thread-Index: AQHc7qIpOMDoQbrb+kSwHXB4rlhxXrYjvmoA
Date: Thu, 28 May 2026 18:14:37 +0000
Message-ID: <581a303fac01d2854bc32cf2afff928990026aa0.camel@ibm.com>
References: <b8ccb15776c8b9770c09b884d1a908d4994ac936.camel@ibm.com>
	 <20260528130114.830041-1-jhapavitra98@gmail.com>
In-Reply-To: <20260528130114.830041-1-jhapavitra98@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6141:EE_
x-ms-office365-filtering-correlation-id: 1c2fcc12-dbcc-4b3f-6cf2-08debce4fac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|3023799007|11063799006|6133799003|18002099003|22082099003|4143699003|56012099006|5023799004|38070700021;
x-microsoft-antispam-message-info:
 bUUmjpZqYbUx43batD8EZQm6Kync+pBUSOcigUlEBat5NyDpS9HCrujYaJ4/iR6qJLmgHpT+GKbB1zdLg30O+LrgkTqLoChZ9QX2YsdzJa7ilRoCBJii36jrt0xknu1Wr68myM/od82sSLKQukEoSo1XYeFCspcxCRhALPjcOokxYH0Fo3qLIUseOWtkadxyI3Xk6FuEG9NQTO/1D9DLYPPO31FtXXnmbNv4/1jkZzXQQ0T1ufjhmPlk79R1lS48xL3Sn/j19umPg8dndhDQ4fo+QyRS992+xTIeGSJcVHZmPFv0DGbr4pkA4+PozYHkHnUAHL5df+0RNV4btdvvtm42YhBAMsq7fp6oCTlnO/B868qLKmImn7chEmyiUyYSIYzomnMnqD7N5+29IXCINVnBXSkbXfoRCAbg6YqN8NOUbjNyFzxOOZylNZSfW4I9xr6SXdzPmZw6uMMb4nzrOkOw5UBG5qsoRFWqY7+1bbKvF9HT+dVJKhXO1hPT8owkAtOiwI8nFFuo88A2WSengif9V9bP5DYHwvjnx7gz097ycHBsDCu5/rRwMfrx+0YKM67TurBfKwkUtIzAKse0u0nsREgla/mMa5KhIyqpFVDTlL3ScoLS2UtvOmd5AsUgX4UuAZWCFqt7QPcABnOl2t5ZxXfJjXrDCuyC/6foLT8p/qpHmMvptBNLga+mPKXtb0DSDxbGoyp2ISbYSkXLu0iAAjqaOKsmXxcq5gzetrydwaxayaPhgL+sAR/JCOU3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(3023799007)(11063799006)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(5023799004)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RVdPYWFxR1RUcHhUMm9jWlNKKzNHbnQ2cVg1WkNKZFd6RTIvdXU2ampvUHIv?=
 =?utf-8?B?Q0prSVpHY3Y0RWl5VXgrU3VrU1l4OHJzN1ZuMUp2bDJOL1E0K3JHY3BtSVll?=
 =?utf-8?B?R1ZPVUxSdGJKNkgwdW40T21teW9wbVppRktWZSs4ZE0xNlpWeGlVMk1WMzMy?=
 =?utf-8?B?NlZUTWZRN3llNmp4V3dhYWVZcFk2WHE0ZlpjM3Jra2RJMURZdGRVcHJHOENC?=
 =?utf-8?B?R0NJV0duTEMrWXNUbjlGRmxkNm9HSzl6T044a2pyeVhrR0syTHNhNk5CQ1ky?=
 =?utf-8?B?Y0lGLytxUm1uV25Cb0xZRXMvM0xKYldFKzBvTFAyZlU3b1NaQUh2RUtZK3RQ?=
 =?utf-8?B?Z3AxNm1PdXNUTXdiL3BHUktnQzdXWHkwWEQwWnNZUVBYbStNbFl5OXpacW9Q?=
 =?utf-8?B?MG43K0UwWllYVUlLZ3V1Si9YZlRHWEFTR2NYeFg3MGlTZHlNMjBPUW1WS2x3?=
 =?utf-8?B?SWtDYVNER21JUlZRZzlyT0tGUEVzL254N3dBd3hYb1FHL0QwcUJQcjhRVUZn?=
 =?utf-8?B?RnV1TWNJVDBWWnBlTGtkcEJnc3NDRzVHeEhnZkc0MVIvanJwSGV0NjQwRkVi?=
 =?utf-8?B?VEROcWJza09EQkZqOWtRWnVBVzJJVHR4NWkxL3VhYzRLQit6UDdtdXR3Njl2?=
 =?utf-8?B?TENGc3gzUnJVUjZxcW5QRXV1d2hHWXFNaTJjUFBvSnhGMjNkYzg3Y210RXAz?=
 =?utf-8?B?bHRneUFIcHpyR0lKVHdQY3VrRGlpWFVEazVNdUt6SXdzM0tGZVUxL0Vwd1Fo?=
 =?utf-8?B?RTZiUnZaVFN2ZzJqTnMrTnQ4dHM2VlMxVFNWK1NNdWdNajU2WUs0RTNPK0or?=
 =?utf-8?B?V3dNR3ZDSUxWTWs0WWNQWHFKWkdCU3JuMG5wQW1zVzRXWE5MTVVZRHpMWUU1?=
 =?utf-8?B?M3hLeUNGSTcwZjZYZU4rRVp6UEhqQ2gxblNqa0d5cGZXYmJKSGx1TzZPd1Vq?=
 =?utf-8?B?dzZZSXVTR1JRWnlkdW9BTzBBV3Q4azF0RlErcS9aTzljUlYxUDlOK3N6ZzRO?=
 =?utf-8?B?eDJTdGpJK0FpSWNRcGdRRk9RT3lkdTAzczVoOHYwaUhMOWtDcGZld3FTVTdW?=
 =?utf-8?B?a1BlZVBPWkVBRVU2OFdGQzhwQ3E0c3JUUVZDdjRwK2dYdmo4TXJuSFJjWXlJ?=
 =?utf-8?B?Mk1WSkNzT0djSWZoWlBVUjN4YlFRcXh3eWJ2RGo5eWhnYkFRV2pSL0I2bkdM?=
 =?utf-8?B?aFYrN0d6YUFSRjVzb2F6NThHYXkwaU1OdGdZSExkeDRUNjB0cHRPMlZMMjFE?=
 =?utf-8?B?RnFKQlRYSjdMWU1RaG44TVZXZ2ZmL0xYYkRvYk9iUjdHeTk5ZUtJQkZyUUJa?=
 =?utf-8?B?aEM2eGJRcm9LS0VYbWRZZDhHNTlsN1lYTXRTS25HZjZMamZ4WGJmS3ROcm5h?=
 =?utf-8?B?M29hT1loVFhxVDB3SDhmNENBcFg3N0ExN0MxQUhJWS81Z0s2RzJJalVsZEpj?=
 =?utf-8?B?dnEyTFVmazNSUlMzRWtyT2J6UStjZVBsamFkRTJhVHI1dUptdHJ1Tk56U29S?=
 =?utf-8?B?UmRSYXZ1Rnk4Q2ppVld0Y1lXS2JTUnkwOGk5RVhvWStKRjJOTEVjUk5Ed1JZ?=
 =?utf-8?B?Q0pidnMzbGZlN2tCNWs2L0JndmYvTkFEZHVwbGxBVFgwVyt3V1l1ZTlsOE9y?=
 =?utf-8?B?SXZKLzB4NkZ2QitsYkdsY0JMSGFsRVN6NlU1aG9KREwxem1oeVlsaTBZSmJO?=
 =?utf-8?B?VDZFZlNwY25UWGFyK3ZJUDROM0JXK0Q5SVBFdC9tRVMxTm9yZURhQ1pZQ00x?=
 =?utf-8?B?LzlTeEVzSUNSZWRndUwvcHMreHpqZVNrZFRSUlNnQVdQOE5xdjFnRHg3QXJL?=
 =?utf-8?B?ZFF6K1ErL1ZoTDU0ZFVCcmdOUXFCQnA4MFBlcFNVaWpJcTJyRklTaUpyK3B4?=
 =?utf-8?B?aWZMYnRPWVdXYmk3bFE1M0owSTZjNzc4bGZCek1FcHVKL1A5NFRNOHNib3NM?=
 =?utf-8?B?YWdmYWFZQ3VWai85K0sxL1kzTEFCTDhJeVN2NkJicUlUTGFNZkk5YVI3bkpx?=
 =?utf-8?B?eFVZTFMzTW5lZUhBU2RPNFFuL1B5U1B6enlSdE1oQUkyU3lQYThvazlkb2Rj?=
 =?utf-8?B?TDFzMm1WTmFkQ0lqNEE4bmR1VWUvbm40NEZ2UlFKczdxaTE3dlA5YnJDc0ph?=
 =?utf-8?B?M3dBZGxmeGxuNHd4UzFNTWRrOG92TW5pcXhMd2M5Z0JiNmZmanU2USt4YWQ2?=
 =?utf-8?B?SVh6TTNBSUpuZnhUaWNoL1NHcitMd0JNa2VZWEpHbC9WbEMzd1NmZUdvWm9x?=
 =?utf-8?B?alVUMk5wdkhBUkdrUjNGWTFZcTlxSVpMdUpJMmNQWjB3QytycVFWZkpxQ0pS?=
 =?utf-8?B?NXNXbDBicldidEtHVGs3KzJFcWs0bk1GZ2JRWko5RTl3YXlFMHJTWEY4M05z?=
 =?utf-8?Q?sWnPBJIAZkxV+pjHtEMQn3ecqG7adxfvWvFLP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74A606A65326AB459F0D95167CA4AA85@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	IET4grRqQfb11mSwtHMo7TD9AYKhTplPM2dAwZigPR0DlavZenkS+QKMv+M0PJkXz98LDAtmIAv3z3FyfAoYIdFt4kFrcB/fRrGunzn/Bp+kBKhLO6mVvYc3mjFVzW5F2focfaw/7iW7fQmprQY1EqvvS9OR/HegvKWnlpy/ZWrV9KNii+k1d7GI/lkRaDtafnktSdjchnyXe/3qhYlnmnax4X3XYi0PIMbF9g7XhLGZndTwANo8mPoXKaLvJB4kTirLElpGcM/Ahogosu2IL36XbKM+c0UfuxL/aHK7QKOtO7BN5ft5prlzeIt+QUFD2JoWfPUrArBGqBxTUTXEMg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2fcc12-dbcc-4b3f-6cf2-08debce4fac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2026 18:14:37.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMoerOgGiV0JpUh5OnP/PMc7COtw4EgY8e1jPFqGNT5PtQsk6g6ZmgkCi1mste/dOM5b3mNIcv6F+98mN1BYgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6141
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dA6q65H95mNoD_JC7ctdag8xFbbBBX7k
X-Proofpoint-GUID: WWoPfQ6RJZritrxv8kSF20WHVIrX9RWC
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a188612 cx=c_pps
 a=JPzmcyOoIuAgIyAaop9pOg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yoSpkUkCJE6Id47F3mwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE4MiBTYWx0ZWRfX6lBBpp+uU46X
 VkGWf8dCA38xJoXoFH6ecBIv0TfUzsT6nx0UqiOzoRJ14oyNwjAtz/1rHSRorIFTChGvyF/qGXa
 ajD5Ok2tZdBOR1ZH7ONtC6tseuTJORFVKWCCHDwIq4vTuTNTOJ81gxwAV3gkwTAgc2KKrna1A1s
 bPA9uYi7v/N/QBfRdMXv+tSf8jPRcogodyiqMsrU1MgOq+XRVrKico/owwfz5KpoN4bFwNcINS7
 l5HzXlpjuCnZP45uGEU6wPtjj6L5EPsWrBZSUsinrULAW6IYA1hukbGPfNr11XGcVFiTArkRy9p
 GIqxMLz0ZM7UisjigWl9PNk9LLUsAucZCgQ8SNn1eew080dEsIXIbzvM/7vww/jiBj3FObBPAEF
 2l2iIYNU+vPawAyr6BJEfEUXNoWli2Q7KH8MZKayM5eT7gnSHAKBuub3IDqQUG8PqTsWL9g0AlU
 kXnMCJzNn3L4aliF6+Q==
Subject: Re:  [PATCH v2] ceph: fix multiple unsafe decodes in decode_locker()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280182
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255082-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CD0F35F62E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTA1LTI4IGF0IDA5OjAxIC0wNDAwLCBQYXZpdHJhIEpoYSB3cm90ZToNCj4g
ZGVjb2RlX2xvY2tlcigpIGluIGNsc19sb2NrX2NsaWVudC5jIGNvbnRhaW5zIHRocmVlIHVuc2Fm
ZSBkZWNvZGUNCj4gb3BlcmF0aW9ucyB0aGF0IGFsbG93IGEgbWFsaWNpb3VzIG9yIGNvbXByb21p
c2VkIE9TRCB0byB0cmlnZ2VyDQo+IHNsYWItb3V0LW9mLWJvdW5kcyByZWFkczoNCj4gDQo+IDEu
IGNlcGhfZGVjb2RlX2NvcHkoKSBhdCB0aGUgbG9ja2VyX2lkX3QgbmFtZSBmaWVsZCBoYXMgbm8g
cHJlY2VkaW5nDQo+ICAgIGJvdW5kcyBjaGVjay4gV2l0aCBwID09IGVuZCBhZnRlciBjZXBoX3N0
YXJ0X2RlY29kaW5nKCkgYWNjZXB0cw0KPiAgICBzdHJ1Y3RfbGVuPTAsIHRoaXMgcmVhZHMgc2l6
ZW9mKGNlcGhfZW50aXR5X25hbWUpID0gOSBieXRlcyBwYXN0DQo+ICAgIHRoZSB2YWxpZGF0ZWQg
YnVmZmVyIGJvdW5kYXJ5Lg0KPiANCj4gMi4gKnAgKz0gc2l6ZW9mKHN0cnVjdCBjZXBoX3RpbWVz
cGVjKSBhZnRlciB0aGUgbG9ja2VyX2luZm9fdCBoZWFkZXINCj4gICAgaXMgYW4gdW5jaGVja2Vk
IHBvaW50ZXIgYWR2YW5jZS4gQSBtYWxpY2lvdXMgT1NEIGNhbiBwb3NpdGlvbiBwDQo+ICAgIHBh
c3QgZW5kLCBjYXVzaW5nIGFsbCBzdWJzZXF1ZW50IF9zYWZlIGNoZWNrcyB0byBwYXNzIGFnYWlu
c3QgYQ0KPiAgICBib2d1cyBib3VuZGFyeS4NCj4gDQo+IDMuIGxlbiA9IGNlcGhfZGVjb2RlXzMy
KHApIGhhcyBubyBwcmVjZWRpbmcgYm91bmRzIGNoZWNrLCBhbmQgdGhlDQo+ICAgIGltbWVkaWF0
ZWx5IGZvbGxvd2luZyAqcCArPSBsZW4gaXMgdW5jYXBwZWQuIEEgbWFsaWNpb3VzIE9TRCBjYW4N
Cj4gICAgc2VuZCBsZW49MHhmZmZmZmZmZiwgYWR2YW5jaW5nIHAgZ2lnYWJ5dGVzIHBhc3QgZW5k
IGFuZCBlc2NhcGluZw0KPiAgICB0aGUgZGVjb2RlIHdpbmRvdyBlbnRpcmVseS4NCj4gDQo+IEZp
eCBhbGwgdGhyZWUgYnkgcmVwbGFjaW5nIGJhcmUgb3BlcmF0aW9ucyB3aXRoIHRoZWlyIHNhZmUg
dmFyaWFudHM6DQo+ICAgY2VwaF9kZWNvZGVfY29weSAgIC0+IGNlcGhfZGVjb2RlX2NvcHlfc2Fm
ZQ0KPiAgICpwICs9IHNpemVvZiguLi4pICAtPiBjZXBoX2RlY29kZV9za2lwX24NCj4gICBjZXBo
X2RlY29kZV8zMihwKSAgLT4gY2VwaF9kZWNvZGVfMzJfc2FmZQ0KPiAgICpwICs9IGxlbiAgICAg
ICAgICAtPiBjZXBoX2RlY29kZV9za2lwX24NCj4gDQo+IEEgbmV3IG91dF9iYWQ6IGxhYmVsIGlz
IGFkZGVkIHRvIHJldHVybiAtRUlOVkFMIG9uIGFueSBib3VuZHMNCj4gdmlvbGF0aW9uLiAtRUlO
VkFMIGlzIGFwcHJvcHJpYXRlIGhlcmU6IHRoZSBkYXRhIHJlY2VpdmVkIGZyb20gdGhlIE9TRA0K
PiBpcyBzdHJ1Y3R1cmFsbHkgbWFsZm9ybWVkLCB3aGljaCBpcyBhbiBpbnZhbGlkIGFyZ3VtZW50
IHRvIHRoZSBkZWNvZGUNCj4gY29udHJhY3QgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZSBjYWxs
ZXIgb3IgdGhlIHdpcmUgaXMgYXQgZmF1bHQuDQo+IA0KPiBLQVNBTiByZXBvcnQgKGtlcm5lbCA3
LjAuMC1yYzcsIFFFTVUveDg2XzY0LCBLQVNMUiBkaXNhYmxlZCk6DQo+IA0KPiAgIFsgICAyNi4x
ODM5NjldIGNlcGhfb29iNF9wb2M6IGJ1Zj1mZmZmODg4MDA5ZTMxMDAwIGVuZD1mZmZmODg4MDA5
ZTMxZmEwDQo+ICAgWyAgIDI2LjE4NjA4N10gY2VwaF9vb2I0X3BvYzogc3RydWN0X3Y9MSBzdHJ1
Y3RfbGVuPTAgcD09ZW5kOiAxDQo+ICAgWyAgIDI2LjE4NjczOF0gY2VwaF9vb2I0X3BvYzogdHJp
Z2dlcmluZyBiYXJlIGNlcGhfZGVjb2RlXzMyIHBhc3Qgc2xhYiBib3VuZGFyeS4uLg0KPiAgIFsg
ICAyNi4xODc2NzldID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQ0KPiAgIFsgICAyNi4xODgyMzZdIEJVRzogS0FTQU46IHNs
YWItb3V0LW9mLWJvdW5kcyBpbiBjZXBoX29vYjRfaW5pdCsweDIyYi8weGZmMCBbY2VwaF9vb2I0
X3BvY10NCj4gICBbICAgMjYuMTg4MjM2XSBSZWFkIG9mIHNpemUgNCBhdCBhZGRyIGZmZmY4ODgw
MDllMzFmYTAgYnkgdGFzayBpbnNtb2QvNTkNCj4gICBbICAgMjYuMTg4MjM2XSBDUFU6IDAgVUlE
OiAwIFBJRDogNTkgQ29tbTogaW5zbW9kIFRhaW50ZWQ6IEcgICAgICAgICAgIE8gICAgICAgIDcu
MC4wLXJjNy1nOWMyYWJmNjlkYTgzLWRpcnR5ICMxNSBQUkVFTVBUKGxhenkpDQo+ICAgWyAgIDI2
LjE4ODIzNl0gQ2FsbCBUcmFjZToNCj4gICBbICAgMjYuMTg4MjM2XSAgPFRBU0s+DQo+ICAgWyAg
IDI2LjE4ODIzNl0gIGR1bXBfc3RhY2tfbHZsKzB4NGQvMHg3MA0KPiAgIFsgICAyNi4xODgyMzZd
ICBwcmludF9yZXBvcnQrMHgxNzAvMHg0ZjMNCj4gICBbICAgMjYuMTg4MjM2XSAga2FzYW5fcmVw
b3J0KzB4ZGEvMHgxMTANCj4gICBbICAgMjYuMTg4MjM2XSAgY2VwaF9vb2I0X2luaXQrMHgyMmIv
MHhmZjAgW2NlcGhfb29iNF9wb2NdDQo+ICAgWyAgIDI2LjE4ODIzNl0gIGRvX29uZV9pbml0Y2Fs
bCsweDlhLzB4M2EwDQo+ICAgWyAgIDI2LjE4ODIzNl0gIGRvX2luaXRfbW9kdWxlKzB4MjdjLzB4
NzkwDQo+ICAgWyAgIDI2LjE4ODIzNl0gIGxvYWRfbW9kdWxlKzB4NGE5YS8weDYzNTANCj4gICBb
ICAgMjYuMTg4MjM2XSAgaW5pdF9tb2R1bGVfZnJvbV9maWxlKzB4MTVjLzB4MTgwDQo+ICAgWyAg
IDI2LjE4ODIzNl0gIGlkZW1wb3RlbnRfaW5pdF9tb2R1bGUrMHgyMWYvMHg3NTANCj4gICBbICAg
MjYuMTg4MjM2XSAgX194NjRfc3lzX2Zpbml0X21vZHVsZSsweGJhLzB4MTIwDQo+ICAgWyAgIDI2
LjE4ODIzNl0gIGRvX3N5c2NhbGxfNjQrMHhlMi8weDU3MA0KPiAgIFsgICAyNi4xODgyMzZdICBl
bnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ny8weDdmDQo+ICAgWyAgIDI2LjE4ODIz
Nl0gIDwvVEFTSz4NCj4gICBbICAgMjYuMTg4MjM2XSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdz
IHRvIHRoZSBvYmplY3QgYXQgZmZmZjg4ODAwOWUzMTAwMA0KPiAgIFsgICAyNi4xODgyMzZdICB3
aGljaCBiZWxvbmdzIHRvIHRoZSBjYWNoZSBrbWFsbG9jLTRrIG9mIHNpemUgNDA5Ng0KPiAgIFsg
ICAyNi4xODgyMzZdIFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQgMCBieXRlcyB0byB0aGUg
cmlnaHQgb2YNCj4gICBbICAgMjYuMTg4MjM2XSAgYWxsb2NhdGVkIDQwMDAtYnl0ZSByZWdpb24g
W2ZmZmY4ODgwMDllMzEwMDAsIGZmZmY4ODgwMDllMzFmYTApDQo+ICAgWyAgIDI2LjE4ODIzNl0g
IGZmZmY4ODgwMDllMzFmODA6IDAwIDAwIDAwIDAwIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZj
IGZjIGZjIGZjDQo+ICAgWyAgIDI2LjE4ODIzNl0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF4NCj4gICBbICAgMjYuMTg4MjM2XSAgZmZmZjg4ODAwOWUzMjAwMDogZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMNCj4gICBbICAgMjYuMTg4MjM2XSA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCj4gICBbICAgMjYuMjU1NTEzXSBjZXBoX29vYjRfcG9jOiBsZW49MHhjY2NjY2Nj
YyAoT09CIGdhcmJhZ2UgZnJvbSBLQVNBTiByZWR6b25lKQ0KPiANCj4gICAweENDQ0NDQ0NDIGlz
IEtBU0FOIHJlZHpvbmUgcG9pc29uLCBjb25maXJtaW5nIHRoZSByZWFkIGxhbmRlZCBpbg0KPiAg
IHRoZSBzbGFiIHJlZHpvbmUgaW1tZWRpYXRlbHkgcGFzdCB0aGUgNDAwMC1ieXRlIGFsbG9jYXRp
b24uDQo+IA0KPiBBdHRhY2tlciBtb2RlbDogYSBtYWxpY2lvdXMgb3IgY29tcHJvbWlzZWQgT1NE
IGluIGEgbXVsdGktdGVuYW50IENlcGgNCj4gZGVwbG95bWVudCBjYW4gdHJpZ2dlciB0aGlzIGFn
YWluc3QgYW55IGtlcm5lbCBjbGllbnQgdGhhdCBpc3N1ZXMgdGhlDQo+IGxvY2suZ2V0X2luZm8g
Y2xhc3MgbWV0aG9kIChlLmcuIGR1cmluZyBSQkQgZXhjbHVzaXZlIGxvY2sgYWNxdWlzaXRpb24p
DQo+IHdpdGhvdXQgYW55IGZ1cnRoZXIgcHJpdmlsZWdlcyBiZXlvbmQgT1NEIHNlc3Npb24gZXN0
YWJsaXNobWVudC4NCj4gDQo+IEZpeGVzOiBkNGVkNGE1MzA1NjIgKCJsaWJjZXBoOiBzdXBwb3J0
IGZvciBsb2NrLmxvY2tfaW5mbyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNp
Z25lZC1vZmYtYnk6IFBhdml0cmEgSmhhIDxqaGFwYXZpdHJhOThAZ21haWwuY29tPg0KPiAtLS0N
Cj4gdjI6IE1vdmUgaW5saW5lIGNvbW1lbnRzIGFib3ZlIGNlcGhfZGVjb2RlX3NraXBfbiBjYWxs
cyB0byBzdGF5IHdpdGhpbg0KPiAgICAgdGhlIDgwLWNvbHVtbiBsaW1pdCwgYW5kIHJlbmFtZSBs
YWJlbCBiYWQgLT4gb3V0X2JhZCwgcGVyDQo+ICAgICBWaWFjaGVzbGF2IER1YmV5a28ncyByZXZp
ZXcuDQo+IC0tLQ0KPiAgbmV0L2NlcGgvY2xzX2xvY2tfY2xpZW50LmMgfCAxMiArKysrKysrKy0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvY2xzX2xvY2tfY2xpZW50LmMgYi9uZXQvY2VwaC9j
bHNfbG9ja19jbGllbnQuYw0KPiBpbmRleCA3ODI3NjI3M2MuLjRmMjdiM2QxNSAxMDA2NDQNCj4g
LS0tIGEvbmV0L2NlcGgvY2xzX2xvY2tfY2xpZW50LmMNCj4gKysrIGIvbmV0L2NlcGgvY2xzX2xv
Y2tfY2xpZW50LmMNCj4gQEAgLTI1OSw3ICsyNTksNyBAQCBzdGF0aWMgaW50IGRlY29kZV9sb2Nr
ZXIodm9pZCAqKnAsIHZvaWQgKmVuZCwgc3RydWN0IGNlcGhfbG9ja2VyICpsb2NrZXIpDQo+ICAJ
aWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCWNlcGhfZGVjb2RlX2NvcHkocCwg
JmxvY2tlci0+aWQubmFtZSwgc2l6ZW9mKGxvY2tlci0+aWQubmFtZSkpOw0KPiArCWNlcGhfZGVj
b2RlX2NvcHlfc2FmZShwLCBlbmQsICZsb2NrZXItPmlkLm5hbWUsIHNpemVvZihsb2NrZXItPmlk
Lm5hbWUpLCBvdXRfYmFkKTsNCg0KVGhpcyBsaW5lIGNvbnRhaW5zIDg1IHN5bWJvbHMuIFdoYXQn
cyB0aGUgcG9pbnQgb2Ygc3VjaCBsb25nIGxpbmU/IFdoeSBub3QNCnNvbWV0aGluZyBsaWtlIHRo
aXM/DQoNCgljZXBoX2RlY29kZV9jb3B5X3NhZmUocCwgZW5kLCAmbG9ja2VyLT5pZC5uYW1lLA0K
CQkJICAgICAgc2l6ZW9mKGxvY2tlci0+aWQubmFtZSksIG91dF9iYWQpOw0KDQpIYXZlIHlvdSBy
dW4gc2NyaXB0cy9jaGVja3BhdGNoLnBsIGZvciB0aGUgcGF0Y2g/IEkgYW0gc3VyZSB0aGF0IHRo
ZSBjaGVjaw0Kc2hvdWxkIGNvbXBsYWluIGFib3V0IHRoaXMuDQoNClRoYW5rcywNClNsYXZhLg0K
DQo+ICAJcyA9IGNlcGhfZXh0cmFjdF9lbmNvZGVkX3N0cmluZyhwLCBlbmQsIE5VTEwsIEdGUF9O
T0lPKTsNCj4gIAlpZiAoSVNfRVJSKHMpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihzKTsNCj4gQEAg
LTI3MCwxOSArMjcwLDIzIEBAIHN0YXRpYyBpbnQgZGVjb2RlX2xvY2tlcih2b2lkICoqcCwgdm9p
ZCAqZW5kLCBzdHJ1Y3QgY2VwaF9sb2NrZXIgKmxvY2tlcikNCj4gIAlpZiAocmV0KQ0KPiAgCQly
ZXR1cm4gcmV0Ow0KPiAgDQo+IC0JKnAgKz0gc2l6ZW9mKHN0cnVjdCBjZXBoX3RpbWVzcGVjKTsg
Lyogc2tpcCBleHBpcmF0aW9uICovDQo+ICsJLyogc2tpcCBleHBpcmF0aW9uICovDQo+ICsJY2Vw
aF9kZWNvZGVfc2tpcF9uKHAsIGVuZCwgc2l6ZW9mKHN0cnVjdCBjZXBoX3RpbWVzcGVjKSwgb3V0
X2JhZCk7DQo+ICANCj4gIAlyZXQgPSBjZXBoX2RlY29kZV9lbnRpdHlfYWRkcihwLCBlbmQsICZs
b2NrZXItPmluZm8uYWRkcik7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJuIHJldDsNCj4gIA0K
PiAtCWxlbiA9IGNlcGhfZGVjb2RlXzMyKHApOw0KPiAtCSpwICs9IGxlbjsgLyogc2tpcCBkZXNj
cmlwdGlvbiAqLw0KPiArCWNlcGhfZGVjb2RlXzMyX3NhZmUocCwgZW5kLCBsZW4sIG91dF9iYWQp
Ow0KPiArCS8qIHNraXAgZGVzY3JpcHRpb24gKi8NCj4gKwljZXBoX2RlY29kZV9za2lwX24ocCwg
ZW5kLCBsZW4sIG91dF9iYWQpOw0KPiAgDQo+ICAJZG91dCgiJXMgJXMlbGx1IGNvb2tpZSAlcyBh
ZGRyICVzXG4iLCBfX2Z1bmNfXywNCj4gIAkgICAgIEVOVElUWV9OQU1FKGxvY2tlci0+aWQubmFt
ZSksIGxvY2tlci0+aWQuY29va2llLA0KPiAgCSAgICAgY2VwaF9wcl9hZGRyKCZsb2NrZXItPmlu
Zm8uYWRkcikpOw0KPiAgCXJldHVybiAwOw0KPiArb3V0X2JhZDoNCj4gKwlyZXR1cm4gLUVJTlZB
TDsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBkZWNvZGVfbG9ja2Vycyh2b2lkICoqcCwgdm9p
ZCAqZW5kLCB1OCAqdHlwZSwgY2hhciAqKnRhZywNCg==

