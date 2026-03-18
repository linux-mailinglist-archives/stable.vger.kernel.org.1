Return-Path: <stable+bounces-227146-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNSrEukAu2mreAIAu9opvQ
	(envelope-from <stable+bounces-227146-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:45:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E76322C224B
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 20:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F0C312B961
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 19:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF453F54A1;
	Wed, 18 Mar 2026 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VCw2WHNX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6E3F2107;
	Wed, 18 Mar 2026 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773862934; cv=fail; b=insXYxvD0UMfGN9p4veWdqgCZJbjWnRv9QomTYvFarSOy/tDx+B0zYOl1LUxEBxhiWOAgmT4TS50o8QK/BL/lNevsHmtVW8L3HsIabRpYBYKmHMOIhcdmmNqQVmf0FoIP7rw2sjrjWdQZuvOMD6IplTTHrPeozhvaZvfSanypO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773862934; c=relaxed/simple;
	bh=G5LWfGvwf7o2rwygvaPlTkB6yo+8o50XGuxH2tEy3KM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KJE8CsG5npaD1+eyFIoauYHeEegdWf0UiYwevg0QqsKrCYBtdYLQlxGg5it2RIpsD/oPlhbgzZIIxY6IBpKMWX7P26VeJOYCRoebX1hVMTBv/lftxILRtFdANQwstzDI4l/VEVuvOnl0gYrrgzOwYoBdpE/P6jzM3tCmEX3QSC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VCw2WHNX; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I9SifP940706;
	Wed, 18 Mar 2026 19:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=G5LWfGvwf7o2rwygvaPlTkB6yo+8o50XGuxH2tEy3KM=; b=VCw2WHNX
	Yac41g8DjCLIjiiqYxLlzHYNlwzsju9SVsGlvY4jIexYOBlcQXwx/QGkHhiLaBSX
	uyTpLC0PmrG5poScx31trhY/FjWC6N0AUfP14Foo2ne0POg3bNgcYZVClnCVMONT
	cGsu7MGkgNsnq/lcMoY8OCufwZORDvrfOpD4KOy0J1zEM2nxa/AkqmnuWMuzJmLf
	f2EdNZCOV5LA+NUfdpqA0vjqTNMSLw+I1WzhMca6eS3o7oS0kyBmtmJoYWx6v1l1
	HE+tJqVgg86vEb3onfb44mnN1Ox7p/GxCMD8LQ69Tu2k4Epa0GjDXEV9UPxpXgvF
	95KKcACtjYH88Q==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012020.outbound.protection.outlook.com [52.101.48.20])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybsbu4t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 19:42:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+adCBy1Ztk+Y62bcFDh6bWjG2w1J4bROWUl+EK3PXfJNX6vztgrAhKDAXsqCDE2WiZqpbCJbvz7fKdqA6+ZFeLfo5zLrFqv4xZ7QGDHnXohQV2ojnGcZLmQ+MhvjFyJMQTdZDvaoPEDcasvesLStyaftwTcT/jr9EBp13IWG5DsMXnPP/UCp31o1zJMWf617L5HAFqAJQf3Y1adgudM3rNFaxhVxQEysuiIZmotMIKAqsWPzXyf25HrriF53TTz4m4+qlLUd0xoTJgBmK8irq2Rx7exbqrBBkBNp1t95g+3fLndQ3whiUXLg3lGFMyii5Ffwnq14LMWSIvvk3ltWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5LWfGvwf7o2rwygvaPlTkB6yo+8o50XGuxH2tEy3KM=;
 b=SoGXUSgK/sZQJ0QDJwiJsTfmqf6ULcj+LEUAJ3EJjW1sOEoBQybaydGCesyrsEupDZQxZ4oM1ErEmf4gl93oziIe9owjUaY2/f6RiNbzajvaD4MTPBg+axt9DANU1L9Dz7MEeOftVs1J66YZZXfB2bCr7B/cnMtm8cSzIeO+tHlku4pNLDFdDzVnJF1LTfhS2n6YnKH5smnXyRWCgtMBQajmYsl51XOFOEwuZ2+OT7hI9i/18m0IL3p2FMJNAyYvlc+g3Y/5mJicMKdyRXDiyOT2xsi40eYXTu8268ShQ/dux7e1MGRijgHMApMp36iRZ7qrG4cfrQ4eFxA9sQp2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SAVPR15MB7143.namprd15.prod.outlook.com (2603:10b6:806:4e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 19:42:00 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 19:41:59 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "cfsworks@gmail.com" <cfsworks@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: Milind Changire <mchangir@redhat.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Thread-Topic: [EXTERNAL] [REGRESSION] [PATCH v2] ceph: fix num_ops OBOE when
 crypto allocation fails
Thread-Index: AQHctoBEP/PiiXQDA0SXnqDiCUAZcbW0sZAA
Date: Wed, 18 Mar 2026 19:41:59 +0000
Message-ID: <bae7a16910a7b2cff6b9f8996d93ea72dabb9a6b.camel@ibm.com>
References: <20260318023733.116789-1-CFSworks@gmail.com>
In-Reply-To: <20260318023733.116789-1-CFSworks@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SAVPR15MB7143:EE_
x-ms-office365-filtering-correlation-id: 40642778-b6f4-4789-6d58-08de85266bc9
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 ehI9Q5Hmtc5jZr1dISl7VmaOg4xMFJRgrzeTPbGFhtAFdAdLgCYY//2b2ru6jKhlyxE+jxa37zXg9a7YYoj0D6UnKYC9oUFeVBoltymJslrnnhoNqRpEBbXQ+QT0lqk8EhCgP+8Su6OWJLrl0EVWl+4NL730EHZYIwgCNNdH6FbKoWHGuHA+qlJveZcyXHqTAmzO+md5hPQJ4auvwaOFHMmeZ1lI2AlWsTTlTMjlziksd0KVDnJtJdbptI4LWApXyZp4pUnfHwRUpkIS/deUArcf5k6b8JXB5Gw1aoLP3NdFVyC+BzEVI0eXQjqKu+ecIa/POdxC40ZrRtaM4jUFohy1hsSFWKQ6XRyjaI7dblCl6fd7YR7TXPJQbgMx4Y1FRe9o8rlQG0FwBR+1GaX0r9V2wrgYG2oIaJr0z48UinmIwYf0pJIgExXT1dLkPJU8CWWyrVKuDX9Dh9LZNoGcjSkevQN+II85AKaQfcblR7x1CPqv5OvEzwribLFLWMG/ZmIewlB67XFfmbISPsniiUe7Cz5XwPfQEt3euf0QdB3GGy8W8uIJLtMq92byMaUZBJLkPo9rhv1WThtES3oENQto4fk1nX4bjoq0ok5q+W0qdQa4OCUjXivA+fqU6dSfC9e8Aof0XHgIFyjA3g+RKuBRy8/ZLgwkebt5I7Ftc7yDJ2Rue7VPwpILqVd8ttJ6t5+sTWstrddA0P01sjtl/YUaS9as9MZ/TDq/zvIJmHsstff4fIlM/CJhlYqE3wnf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0g3Mzkzek1RUFlWdzM0U0VBUjhHL0R5TVBaM2RJZDN2UE5VQ0xvaXJmWFRI?=
 =?utf-8?B?SHRNaHVDRFJMd0NGYWY0OFJ4cUd5N1NqMHB1L2dKUE5jdmgxd3BVK3BYdEJZ?=
 =?utf-8?B?eUxvc2xxK2s2bzNIanhnOVdWRVBkT1RBejgxVXlCRGpGdTJqdXZueVdnc3RM?=
 =?utf-8?B?cUNEYlhqbjh5RmR5RnhtZFNkWVNmZDkyVzhlbDc1YVlSMFhaSTk4K0V1czJ3?=
 =?utf-8?B?am9NK3hPMWp5UzA3eEFrNm5iUjZkTStlSytrUnZnWUljdmxQK2dGd0pIT3RI?=
 =?utf-8?B?ZjNBR29mR3pXVmxwazdIRHJ6T0dGNjBWbXBYUDF1eUFpN0VGN2JORnpuS0dv?=
 =?utf-8?B?TUlRbE1ReEtEdVFidFJiWEplVFRscWEwc3RpSTFpYWdYTnFGbDNMbWJZelVm?=
 =?utf-8?B?MFV3TWF3VjUrZ2liZ0pjQlVEcTBBbTVnNWRxVXpqc1phRmRzNGNpRnF1V1Np?=
 =?utf-8?B?TnE1VzBodEkrRGxUN1F0SmE0eGZKMm5LMHBjeHRqNFdIWkwwSjY3ZU5zQlFH?=
 =?utf-8?B?R3dNVGZqZFZ3TWNVZFhHYVl5S01qNFBsL0tNYVhHQnB3UldhaW4ycG5hQ3Qy?=
 =?utf-8?B?TGhPbWd0bFpnTUI0dUxsV2gzVWZablVTMXJneGczd2lVREwwdVNIVkpydHU5?=
 =?utf-8?B?WU50amdWSUl5WTdhdWRBTUZOWTc2Yys3SVhlSHp3Q1ZLZEEwTGc2OUVDTHVG?=
 =?utf-8?B?ekppdWV1cHBkbUd0b0JPU2o4RklFWUROdGxKd0JOaERLQW5pdE1XTFhWSXY2?=
 =?utf-8?B?NG03Tmp0T2t1UkNMcWY4MjNXaVg2d0RxTXZxNlhzZWpRbzJVOEFsMVRGYWhB?=
 =?utf-8?B?RUtKREVsdGZ0ckg5bmxQTHRDNDgvQm1DaGNVd0F5ZTk3anJzZmgvWWkvSXRy?=
 =?utf-8?B?S25JcXdvOW5XR28xc05pNzMxT1NTOW14VnZYWWIyTUplY2p0SktDaUJOU2Fy?=
 =?utf-8?B?UG9Rc2JsVlJ1K1N4M016OXNnOVhOYzBuaDBrVUZ6SWcwTXkyOE5ZdzZXdjlo?=
 =?utf-8?B?aGFxajlBYWpBZGlZWTVkTmNpQloybGUxVzByczVYMzJjZW8zZEdvY3YvV3BC?=
 =?utf-8?B?VWNualF4dHBXSTg1K05qVDViblZtSm8wcHRKWjdxaCtFaWV3TXFhQ2xIL3g1?=
 =?utf-8?B?d3J3ZkV0bmRvd1V4aXB2OFZTTUZWWk9FVzY2SDl2Y0JxMzJ6UHRuc1dYblhs?=
 =?utf-8?B?SU1BQ0JnTEFMRnlwc2VlUW1CN0xWUG9OSnBXNXhkRDFkYVBMU0N5aG9yMSs3?=
 =?utf-8?B?bUZUNnU2WGpVMEs0MTFNR2crV1RFWTFPVWdpQXFkaHZXUTRsYnErdVJaa0tL?=
 =?utf-8?B?aEoxcGFLaGRVZFlNaWMyUWhzWVlWaklPWFh0NVJhRVVQNmVCQzNzSjNnSFpG?=
 =?utf-8?B?VzFpL3dXelBrTjVQTi9vZ1lHWm9uTVhGVFpZSzY1ZXVad21HLysxVUpZbHBC?=
 =?utf-8?B?cTMwcXR4WUVhazZHVWFUeXdQK1laSXAxdVhsQVN2Sm9saVhqa0FaQXl6Z3hH?=
 =?utf-8?B?ZEhMN3RuYTUwVkdxSjB2RFFNL0g5b1d6cTJJcHo4UXoyTm51VXR3eVIxTTk0?=
 =?utf-8?B?SGJRcXdUVUVjTmlYOUFHTHlHejMvb0FIMkdmRU9sR05CTXlYbE8vS1JzSURL?=
 =?utf-8?B?Qkh3aG9PekVHWDZxTWZLdGw4WURqTjdHNkM3MHNMMkthZkZubXFjTTUrTHJP?=
 =?utf-8?B?eFpPRVROSzdkY3AxWGFZN0liTXZnemNnYm4vbWFlb1M2Y091M0wwdVpMUXNY?=
 =?utf-8?B?Q3A2d1FVZmRVaExuZVQxRTRiNzlHR1FHQkswdjFxa0kydFNFNU8yVEhnbXV0?=
 =?utf-8?B?Z0t2L3o3VHhCZGxncHhmbFpCNXoybjVyK2ROZWU2akFnaGZEa3A0YmpuYnU4?=
 =?utf-8?B?RUxpOHBidGtmcG9LR3lqZkFmalF4UFdWa1RmQ0tDRVVNUkdnSFppRm1OYzAw?=
 =?utf-8?B?bE9TMHR6MjRWaFp6THRGaWxFV2VVZUIxTHVUNEtGUG14ZGwyUVpYTlpLWURr?=
 =?utf-8?B?WHAxVkVsZVRoMW1DNUQyS2NENTlndVNTbVhaQzUzdXZBOGs0UlNhV2YvQ0lu?=
 =?utf-8?B?OUFNWlpIZXBRZHQxOHdONkdicUhYNlVSZGEzbmhEaFA2c1V5SGpjbmNnSlY3?=
 =?utf-8?B?dW5QYUtxTGRFRHJucHduVnlkT0ljOXdObUNEcTlldlRBNVpkUVNBc0xiblcr?=
 =?utf-8?B?aUVLZ2JjK09RNnkwYnA3SFU1MTN2Z296eWJ1ZnBuQ1F6c0lWMExpaFo5QU9C?=
 =?utf-8?B?NXFocnFKeFNWTHBNK3RQQWZvanZzeXkwUFljaTRwVis3NHZkbXdiS1dzYXQ4?=
 =?utf-8?B?V2dlajhNYlNDUmNPQ3Q5WVNiTXhwL1A3S0didEFVVCtPcHV0UmZZM1hPZjVN?=
 =?utf-8?Q?qcpv53rBfK88tbUZYof+lIRZU6KrzsrRpOkHh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A55349E09748F4409920228468B676CF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	RMKs2IbnwBCRViuIq2pZr9Ec20wdzNBtYPPQ+6isIJsH5tF4JbdOAeMY39iDRITAgTqaut0fZVHQzoXTtiXoP9Q+slh+DBTd026UlTBY9nwEovWSgwWTbwH3IQf1WMZi11k85vOVtMrAJqm1MdeEzZMztXSVO41JiTXaitEsSSOVnbvF01CsjVhp6zeTlkjOhJovPsUeuzl9jlapZxkOHnOiUj35BoipF0X82Yo5yXMy3e4X7lhoazJ5UQZCkoaIASikKXP3eBYF1C4I+zdNetZ88eQQg73Uc16NFpp0JkOycBJ5XOFGEta9gD3gMVwmpccMcBVn3QKtv6aehJPnQg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40642778-b6f4-4789-6d58-08de85266bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 19:41:59.5929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNX9iJgJm12IqdFv25lgxQznTJUbVr1fh4pHur97QBVG7PSP9tpaofQ4OKNrxiN/YE2d2xXTeV7XWPIRop6VMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR15MB7143
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bb000a cx=c_pps
 a=wPn5mG08gX1eKnPfDThLSw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=4exVDVOaHqYBLgRGVCYA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: E3P20tgDC_cyv-VwavmHwP1IR-Bt_gx0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE2OSBTYWx0ZWRfX3wOSJJwNsmT/
 STPsQbeeUPUENaxlWbxXGjk3bzk4vzidg6IuJiE/bsWZfcfKEgjgR5PM7KneYfYFux5z+408fht
 oMk+dpq/DOfSLSqBj2M//XPquZOlWLAPIzVA1ic6ngCacWcDhm70AYtjXpL2LuPeyWGOZ/yh/it
 qLRHAPg20kC+DIgdMaIhE8vnhAT2mkO5yG+6a3qMRPPBFABUI/5RZMcBPYWdTAAeQuY88lKiwfF
 H5EJmjeQ4sCHzL9Vm6EdOkJo4eezNrD0uUephb1lY2n9AcKw6zcdo3G+vM+H3Mb5iVBJDO0lgCI
 GxgyLDCoJNfd5wJe5I3sgvnQsD8IqAqBvXPpL0NPYTm2Y4c9Ikhmq5jSaJf9hDVj5rv67mTqBk5
 edG/cnekDeX2xtqWGkzO3Nn35XC3YqFk3+RHNZkhm2nOP8nfvyX17n8VCMkrCcoygOEWfhTApyH
 Y0OpPJCqX+oni9Rw1Qw==
X-Proofpoint-GUID: 60Q2vOwOrsL91D_cnGJE293BQxKsky6_
Subject: Re:  [REGRESSION] [PATCH v2] ceph: fix num_ops OBOE when crypto
 allocation fails
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180169
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227146-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E76322C224B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAyMDI2LTAzLTE3IGF0IDE5OjM3IC0wNzAwLCBTYW0gRWR3YXJkcyB3cm90ZToNCj4g
bW92ZV9kaXJ0eV9mb2xpb19pbl9wYWdlX2FycmF5KCkgbWF5IGZhaWwgaWYgdGhlIGZpbGUgaXMg
ZW5jcnlwdGVkLCB0aGUNCj4gZGlydHkgZm9saW8gaXMgbm90IHRoZSBmaXJzdCBpbiB0aGUgYmF0
Y2gsIGFuZCBpdCBmYWlscyB0byBhbGxvY2F0ZSBhDQo+IGJvdW5jZSBidWZmZXIgdG8gaG9sZCB0
aGUgY2lwaGVydGV4dC4gV2hlbiB0aGF0IGhhcHBlbnMsDQo+IGNlcGhfcHJvY2Vzc19mb2xpb19i
YXRjaCgpIHNpbXBseSByZWRpcnRpZXMgdGhlIGZvbGlvIGFuZCBmbHVzaGVzIHRoZQ0KPiBjdXJy
ZW50IGJhdGNoIC0tIGl0IGNhbiByZXRyeSB0aGF0IGZvbGlvIGluIGEgZnV0dXJlIGJhdGNoLg0K
PiANCj4gSG93ZXZlciwgaWYgdGhpcyBmYWlsZWQgZm9saW8gaXMgbm90IGNvbnRpZ3VvdXMgd2l0
aCB0aGUgbGFzdCBmb2xpbyB0aGF0DQo+IGRpZCBtYWtlIGl0IGludG8gdGhlIGJhdGNoLCB0aGVu
IGNlcGhfcHJvY2Vzc19mb2xpb19iYXRjaCgpIGhhcyBhbHJlYWR5DQo+IGluY3JlbWVudGVkIGBj
ZXBoX3diYy0+bnVtX29wc2A7IGJlY2F1c2UgaXQgZG9lc24ndCBmb2xsb3cgdGhyb3VnaCBhbmQN
Cj4gYWRkIHRoZSBkaXNjb250aWd1b3VzIGZvbGlvIHRvIHRoZSBhcnJheSwgY2VwaF9zdWJtaXRf
d3JpdGUoKSAtLSB3aGljaA0KPiBleHBlY3RzIHRoYXQgYGNlcGhfd2JjLT5udW1fb3BzYCBhY2N1
cmF0ZWx5IHJlZmxlY3RzIHRoZSBudW1iZXIgb2YNCj4gY29udGlndW91cyByYW5nZXMgKGFuZCB0
aGVyZWZvcmUgdGhlIHJlcXVpcmVkIG51bWJlciBvZiAid3JpdGUgZXh0ZW50Ig0KPiBvcHMpIGlu
IHRoZSB3cml0ZWJhY2sgLS0gd2lsbCBwYW5pYyB0aGUga2VybmVsOg0KPiANCj4gICAgIEJVR19P
TihjZXBoX3diYy0+b3BfaWR4ICsgMSAhPSByZXEtPnJfbnVtX29wcyk7DQo+IA0KPiBUaGlzIGlz
c3VlIGNhbiBiZSByZXByb2R1Y2VkIG9uIGFmZmVjdGVkIGtlcm5lbHMgYnkgd3JpdGluZyB0bw0K
PiBmc2NyeXB0LWVuYWJsZWQgQ2VwaEZTIGZpbGUocykgd2l0aCBhIDRLaUItd3JpdHRlbi80S2lC
LXNraXBwZWQvcmVwZWF0DQo+IHBhdHRlcm4gKHRvdGFsIGZpbGVzaXplIHNob3VsZCBub3QgbWF0
dGVyKSBhbmQgZ3JhZHVhbGx5IGluY3JlYXNpbmcgdGhlDQo+IHN5c3RlbSdzIG1lbW9yeSBwcmVz
c3VyZSB1bnRpbCBhIGJvdW5jZSBidWZmZXIgYWxsb2NhdGlvbiBmYWlscy4NCj4gDQo+IEZpeCB0
aGlzIGNyYXNoIGJ5IGRlY3JlbWVudGluZyBgY2VwaF93YmMtPm51bV9vcHNgIGJhY2sgdG8gdGhl
IGNvcnJlY3QNCj4gdmFsdWUgd2hlbiBtb3ZlX2RpcnR5X2ZvbGlvX2luX3BhZ2VfYXJyYXkoKSBm
YWlscywgYnV0IHRoZSBmb2xpbyBhbHJlYWR5DQo+IHN0YXJ0ZWQgY291bnRpbmcgYSBuZXcgKGku
ZS4gc3RpbGwtZW1wdHkpIGV4dGVudC4NCj4gDQo+IFRoZSBkZWZlY3QgY29ycmVjdGVkIGJ5IHRo
aXMgcGF0Y2ggaGFzIGV4aXN0ZWQgc2luY2UgMjAyMiAoc2VlIGZpcnN0DQo+IGBGaXhlczpgKSwg
YnV0IGFub3RoZXIgYnVnIGJsb2NrZWQgbXVsdGktZm9saW8gZW5jcnlwdGVkIHdyaXRlYmFjayB1
bnRpbA0KPiByZWNlbnRseSAoc2VlIHNlY29uZCBgRml4ZXM6YCkuIFRoZSBzZWNvbmQgY29tbWl0
IG1hZGUgaXQgaW50byA2LjE4LjE2LA0KPiA2LjE5LjYsIGFuZCA3LjAtcmMxLCB1bm1hc2tpbmcg
dGhlIHBhbmljIGluIHRob3NlIHZlcnNpb25zLiBUaGlzIHBhdGNoDQo+IHRoZXJlZm9yZSBmaXhl
cyBhIHJlZ3Jlc3Npb24gKHBhbmljKSBpbnRyb2R1Y2VkIGJ5IGNhYzE5MGM3Njc0Zi4NCj4gDQo+
IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjYuMTgrDQo+IEZpeGVzOiBkNTUyMDc3MTdk
ZWQgKCJjZXBoOiBhZGQgZW5jcnlwdGlvbiBzdXBwb3J0IHRvIHdyaXRlcGFnZSBhbmQgd3JpdGVw
YWdlcyIpDQo+IEZpeGVzOiBjYWMxOTBjNzY3NGYgKCJjZXBoOiBmaXggd3JpdGUgc3Rvcm0gb24g
ZnNjcnlwdGVkIGZpbGVzIikNCj4gU2lnbmVkLW9mZi1ieTogU2FtIEVkd2FyZHMgPENGU3dvcmtz
QGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBDaGFuZ2VzIHYxLT52MjoNCj4gLSBBZGRlZCBhIHBh
cmFncmFwaCB0byB0aGUgY29tbWl0IGxvZyBicmllZmx5IGV4cGxhaW5pbmcgdGhlIEkvTyBwYXR0
ZXJuIHRvDQo+ICAgcmVwcm9kdWNlIHRoZSBpc3N1ZSAodGhhbmtzIFNsYXZhKQ0KPiANCj4gLSBB
ZGRpdGlvbmFsbHkgQ2MnZCByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXYgYXMgcmVxdWlyZWQg
d2hlbiBoYW5kbGluZw0KPiAgIHJlZ3Jlc3Npb25zDQo+IA0KPiBGZWVkYmFjayBub3QgYWRkcmVz
c2VkOg0KPiAtICJDb21taXQgbWVzc2FnZSBzaG91bGQgbGluayB0byB0aGUgbWVudGlvbmVkIEJV
R19PTiBsaW5lIGluIGEgc291cmNlIGxpc3RpbmciDQo+ICAgICAobGluayB3b3VsZCBub3QgcmVh
bGx5IGhlbHAgYW55b25lLCBhbmQgdGhlIGxpbmUgaXMgYSBtb3ZpbmcgdGFyZ2V0IGFueXdheSkN
Cg0KTXkgcmVxdWVzdCB3YXMgdG8gaWRlbnRpZnkgdGhlIGxvY2F0aW9uIG9mOg0KDQpCVUdfT04o
Y2VwaF93YmMtPm9wX2lkeCArIDEgIT0gcmVxLT5yX251bV9vcHMpOw0KDQpCZWNhdXNlLCBpdCdz
IGNvbXBsZXRlbHkgbm90IGNsZWFyIGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlIHRoZSBsb2NhdGlv
biBvZiB0aGlzDQpjb2RlIHBhdHRlcm4uDQoNClRoZXJlIGFyZSB0d28gcG9zc2libGUgd2F5czoN
CigxKSBMaW5rIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y3LjAtcmM0L3NvdXJj
ZS9mcy9jZXBoL2FkZHIuYyNMMTU1NS4NCkkgaG9wZSB5b3UgY2FuIHNlZSB0aGF0IGl0IGluY2x1
ZGVzIGtlcm5lbCB2ZXJzaW9uLiBTbywgaWYgdGhlIGxpbmUgd2lsbCBjaGFuZ2UNCndpdGggdGlt
ZSwgdGhlbiB0aGlzIGxpbmsgYWx3YXlzIHdpbGwgaWRlbnRpZnkgdGhlIHBvc2l0aW9uIG9mIHRo
aXMgY29kZSBwYXR0ZXJuDQppbiB2Ny4wLXJjNCwgZm9yIGV4YW1wbGUuDQoNCigyKSBZb3UgY2Fu
IHNob3cgdGhlIGZ1bmN0aW9uIHRoYXQgY29udGFpbnMgdGhpcyBjb2RlIHBhdHRlcm46DQoNCnN0
YXRpYw0KaW50IGNlcGhfc3VibWl0X3dyaXRlKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5n
LA0KCQkJc3RydWN0IHdyaXRlYmFja19jb250cm9sICp3YmMsDQoJCQlzdHJ1Y3QgY2VwaF93cml0
ZWJhY2tfY3RsICpjZXBoX3diYykNCnsNCjxza2lwcGVkPg0KDQogICAgQlVHX09OKGNlcGhfd2Jj
LT5vcF9pZHggKyAxICE9IHJlcS0+cl9udW1fb3BzKTsNCg0KPHNraXBwZWQ+DQp9DQoNCj4gDQo+
IC0gIkNvbW1pdCBtZXNzYWdlIHNob3VsZCBpbmRpY2F0ZSB0aGF0IGNlcGhfd2JjLT5udW1fb3Bz
IGlzIHBhc3NlZCB0bw0KPiAgICBjZXBoX29zZGNfbmV3X3JlcXVlc3QoKSB0byBleHBsYWluIHdo
eSBjZXBoX3diYy0+bnVtX29wcyA9PSByZXEtPnJfbnVtX29wcyINCj4gICAgIChjZXBoX3diYy0+
bnVtX29wcyBpcyBlYXN5IGVub3VnaCB0byBzZWFyY2g7IGFuZCB0aGUgY2F1c2UtPmVmZmVjdCBv
ZiB0aGUNCj4gICAgICBCVUdfT04oKSBpcyBzZWNvbmRhcnkgdG8gdGhlIGNlbnRyYWwgcG9pbnQg
dGhhdCBjZXBoX3Byb2Nlc3NfZm9saW9fYmF0Y2goKQ0KPiAgICAgIGlzIHJlc3BvbnNpYmxlIGZv
ciBlbnN1cmluZyBjZXBoX3diYy0+bnVtX29wcyBpcyBjb3JyZWN0IGJlZm9yZSByZXR1cm5pbmcp
DQo+IA0KPiAtICJBbiBpc3N1ZSBzaG91bGQgYmUgZmlsZWQgaW4gdGhlIENlcGggUmVkbWluZSwg
bGlua2VkIHZpYSBDbG9zZXM6Ig0KPiAgICAgKHRoYW5rcyBJbHlhIGZvciBjbGFyaWZ5aW5nIHRo
aXMgaXMgdW5uZWNlc3NhcnkpDQo+IA0KPiAtLS0NCj4gIGZzL2NlcGgvYWRkci5jIHwgNCArKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZnMvY2VwaC9hZGRyLmMgYi9mcy9jZXBoL2FkZHIuYw0KPiBpbmRleCBlODdiM2JiOTRlZTguLmYz
NjZlMTU5ZmZhNiAxMDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9hZGRyLmMNCj4gKysrIGIvZnMvY2Vw
aC9hZGRyLmMNCj4gQEAgLTEzNjYsNiArMTM2NiwxMCBAQCB2b2lkIGNlcGhfcHJvY2Vzc19mb2xp
b19iYXRjaChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4gIAkJcmMgPSBtb3ZlX2Rp
cnR5X2ZvbGlvX2luX3BhZ2VfYXJyYXkobWFwcGluZywgd2JjLCBjZXBoX3diYywNCj4gIAkJCQlm
b2xpbyk7DQo+ICAJCWlmIChyYykgew0KPiArCQkJLyogRGlkIHdlIGp1c3QgYmVnaW4gYSBuZXcg
Y29udGlndW91cyBvcD8gTmV2ZXJtaW5kISAqLw0KPiArCQkJaWYgKGNlcGhfd2JjLT5sZW4gPT0g
MCkNCj4gKwkJCQljZXBoX3diYy0+bnVtX29wcy0tOw0KPiArDQo+ICAJCQlmb2xpb19yZWRpcnR5
X2Zvcl93cml0ZXBhZ2Uod2JjLCBmb2xpbyk7DQo+ICAJCQlmb2xpb191bmxvY2soZm9saW8pOw0K
PiAgCQkJYnJlYWs7DQoNCkxldCBtZSBydW4gdGhlIHhmc3Rlc3RzIGZvciB0aGUgcGF0Y2guIEkn
bGwgYmUgYmFjayB3aXRoIHRoZSByZXN1bHQgQVNBUC4NCg0KUmV2aWV3ZWQtYnk6IFZpYWNoZXNs
YXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KDQpUaGFua3MsDQpTbGF2YS4NCg==

