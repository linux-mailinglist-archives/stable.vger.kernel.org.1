Return-Path: <stable+bounces-254412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG3mGtPlFWrdeAcAu9opvQ
	(envelope-from <stable+bounces-254412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:26:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445C5DB540
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 20:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6445F30942ED
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E794218B1;
	Tue, 26 May 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XuM+RiBn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E7421885;
	Tue, 26 May 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819602; cv=fail; b=eYvyQOhNVC1mnoHVj/uXtXMy2mPwH2M/QfU++CGHlLSJjYVT44Qfc0MpiVXHsIwaXhB/giclCGnlEH9zDDRB3zjBPOUWSBpuTVA6ztjZkgtdpwWDXxMQ2/5MnOfHxNH5o08yZZ1qLpyAsPYzmIvRqDxDLoYRfQyFKAmYyjrbXNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819602; c=relaxed/simple;
	bh=FhvjjH/UgPrDgkNxQQopASeLG8W6OYR1kyPiu9avUpM=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=mgeQexVuQMFL2JHD2EiZW8VbhWxAiXshaq98Xepd1pyyAF/Hm4eJvx1HHV/adYD8ogZKjXP1I1OJvSupjBXZ9rSbQd7KLdnFhaCkCVRtHNkAKF5wGicTPdPcZv6Kh7tuC0BGGwR+2lVoI6+a9z/FeQVHtpWoJ348j2mxBlb18ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XuM+RiBn; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QGMNPH752061;
	Tue, 26 May 2026 18:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=FhvjjH/UgPrDgkNxQQopASeLG8W6OYR1kyPiu9avUpM=; b=XuM+RiBn
	HzixdZvJDXDkGMOBjuAsfcqE7a+RKQvzG+FRHRMZriUl8EUpQCJzLa+jGvRzEz9C
	lFtsOWQHC3OcCxB1jWRTS74KEs/fccIcy6WUDBJnr4DWpQApjvusSMCaWTEbtlaa
	FiqjdYG2b+GLFTHWHi0DNShftv2oIrj+6Xb6ofFWabJx9LFjE2sxXZloHfqH2IYz
	E17Hcln1AYYO9iF1nyZU2UqQ/5IZX/Os2ep96Rs7pf80b4JW/wOn6U4r7PP3rD/u
	5iGp5koHAF5kbFHt33YbXtwYbBvmpiCWkdJ5qO1OWqYoDizy7kD3CFrHW+QdyLYR
	rlPucYSjDCuF/g==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011019.outbound.protection.outlook.com [40.93.194.19])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdcnst-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 18:19:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqMb2Ds8i/wGLWqFdr74JMo20eTbRpbPZKFPvVaxlj+3nc6w6HwvXG/7sHZIyrckJqPpKeR7FbIFiwIwAfmW53xiqRou7GAev9CI2E8FoGhag9j8ZKP+vtzbHOl2bkyovOW0MP7C6K/Leh5QAQte1ZUt9UGwEUAVocc0wyk3/ySaKROQVMUW1szrFBBl4ldZfFopsxwEXeGyImQkAfMmj8p8iX6UVWv7BfUDkcWFxEh21W+czb582Z2ms3Slq2rn6waOlvLOnXkUwUsfEB0Q5nDS6FqlTUSjXHv5a8sNm8SXnzHnnR+VDARL+e/gTg9tNgyOjDWoKsk4QqYAs5FcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhvjjH/UgPrDgkNxQQopASeLG8W6OYR1kyPiu9avUpM=;
 b=joX2Xe8hJgJmH7UzdM4QKWSR07mujdAyISX1YGbavQXWjDgx5L+6q6FZXCY2ZqsBSFLCih/KjLo2DjqUVtD/6rGTghzWEKb7knaEdhFInj+IPFIP9K2QK4te19ei88J4FsSnfvOf045niSpB2L9evx0/IsKpYDKimvQWJsywyAzxxdRfpn/RkU2QzH2Qo0QcFXNdJZ9SBxRMU6h0mG8U49HCdQV9LBY151hYJrXBXmGDukyQimoXMF44KOJyJbHNiOvghWrP+f+qsUxx/ecxszJKlyUu6fpY8fyWlk41NFPo7I+MAOt/VUC2mC9xZL6DIWYuLkAFozTdS+Yjoy6bsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by MW4PR15MB4393.namprd15.prod.outlook.com (2603:10b6:303:be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 18:19:51 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 18:19:50 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "jhapavitra98@gmail.com"
	<jhapavitra98@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2] ceph: fix OOB read in decode_watchers()
 via missing bounds check
Thread-Index: AQHc6dabqZOJLZKIYUaeBer43nYwPrYgpMyA
Date: Tue, 26 May 2026 18:19:50 +0000
Message-ID: <fb2206a9cc8519e54d269b6e5aa772edddfe6fec.camel@ibm.com>
References: <20260521140807.204657-1-jhapavitra98@gmail.com>
	 <20260522101932.304458-1-jhapavitra98@gmail.com>
In-Reply-To: <20260522101932.304458-1-jhapavitra98@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|MW4PR15MB4393:EE_
x-ms-office365-filtering-correlation-id: 5f692d52-1372-4940-0496-08debb536069
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|18002099003|56012099006|38070700021|6133799003|4143699003|5023799004|11063799006;
x-microsoft-antispam-message-info:
 gqy2kq9Y9CXpWIhZcGE4KdIJMAMt4BY58/mMN970b/Bg1fTyHjgJuH3XFJQzZ1h+vtqnPRTjwOsI9HIPlYR+cy6C4fcl/mEcOJFmPWzXgv4rvY3C5VPs9ty1HFTLNBMQJXVYy9isSBsN7tIvTpY2ko8MUI82kK76HfaVmLyAAAlLCwsq9lmo2qMD2s73tsMmYHy1Tac6BgnD2FzJYu8kWh5O9V4kHI0g42G4Kxzr4Ddu/W3+V99egiGiLq3e/pyJ97Jc2FV5xZq4THB20ocF4SluO8VdWsifBZhg2oYHEOGGCDrh8rbN3SqWCIyifAGk4IKsAhOBiUWls8fxjHKKD31e01sCollTgmwD0ztmNwpApJTNDtuhRlTkhAT7MVCi98sk92z/zKSV1jxbSgK2paNpsjhFZPZvoEfVVtSuFYp9hIpc5isLSVTVGgfJaQwEGud0ozWnxO1L52DTreMVhF++swdGelNGqxK9+Vcu7VbHHigVqzMOr+Yadi10HMhwIAqFmPu3xKZGyf5cEUhbl/xR6PC2pVtTrctgM7RhjCwKW4RzyKlSStRgow9JEKtAIF1QaoMiWhnhBFxw47hfnLBnQaIfxEE+g74R8XBtst7ru9c04pJyPwMCpcpjYEjHNty1cfKY35qxqFVAEz9gAeADERe+x6OBwO+vv6VWgIgQnxa/XiHaOhdfuu0190qDLc6T9HzRb657LSV1XFnQvha2zMqotRdKKKScKrbJrEdAkBQIqyPLx7N+O7SpSC4T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(4143699003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SENiaDNQTGwrNjYzNFJKcTJhRmhTbmRsdXl6TVErQmNUdStNUVNpY3FVWjRR?=
 =?utf-8?B?UDdaNnhjaEZGN0o5ZzNueHNsRXdlMFhrY0Ryb21PVjROViszWDhZUDBQbEEr?=
 =?utf-8?B?bnJWVFZIZmdnUUpidUFySmZmRkxNTk5vbnpJcm9SLzVXM0dSY1Y0bm50UStl?=
 =?utf-8?B?eDYyUFFrUXZqQlFXZlJUS0JuKzZmak85TmZnMnIxY1BGZjRaQmJNR2UyQWJH?=
 =?utf-8?B?WXcwZUZqaG8rWHBueFRJNEpZeGpWa0EyRVNqWHFJUmhWbHZnRldqeU9qZS80?=
 =?utf-8?B?aG5oVnVWTFU3U2NMSWVlMHA2M2pDVVBuRUVYdmRRLzZMSWRka2FFREw0S0Js?=
 =?utf-8?B?cXVqWmVMbzA1SlJFS1VFSStQZ3A3NUxOZHBTeW13bDhHcEV3dVNhcmhjOVN3?=
 =?utf-8?B?M2kwR1czV1U0L05BZFJHYnlleVVBTEwxajk4Ny94dUp1czJqUUxVQUVEWTlK?=
 =?utf-8?B?emRvbk9ZQ0JOSkNKNitxMDlheTkvRG9ueEtseUgvTWpzY1AzZitXS2FOUjJ1?=
 =?utf-8?B?R2k4RlpMVmh5K3BZczc2SDFTb3ZJQ0F6eXhOSzQ3WDRWaHpMaDdmM0xsd25I?=
 =?utf-8?B?SlVTRFlDR21CQzVYZWRsUHpMZnpVOHBwOWF5bFJHanNRSk5aa0FNMzZ1TjF5?=
 =?utf-8?B?c291VThIdHVSU3BYMjhRWkh3ZWdVb3c5bnFHTkZ3SE1SNkVLVE8rSkk4Y1cz?=
 =?utf-8?B?SHNVZ0FHSC9LdjZZNmlwdEZXS1lvVTg2OTdGTTJHR1ZpR2I1dmV3L1B3Unds?=
 =?utf-8?B?eGd0R1Byb2lYNmxrNFlXWGNoMzR2SFI1cEV4bDd4SVJDTFVnVHFCcWxENmU1?=
 =?utf-8?B?SnNwZUd3YVUzZ1Z3K1hrQUdZWlFDL2xEU1M2eVhhRVpmemFUbmJMaGVNaDdw?=
 =?utf-8?B?ZGFVSnIxSkJTVXI5elRpeTlLdHBuc2VrYm1YT1ROc3haNnRLSEM1NDEyQXhu?=
 =?utf-8?B?L1paL21YZWg4TFd5eEdZV293d2xFWU5CL1pkU2NiMGVyVzRTSnJ1czBIRnhi?=
 =?utf-8?B?TmNBVXBiN2xZL1grMW9CaUhYVXFxc3FQZjZXNGpDbkFiMU1nYlppcy9jc1Vn?=
 =?utf-8?B?SEoreFptY0dtZG80QWlPWFlXa1QzY1N5ZGVrc3lybzE4djFsWDZRODQ0U1pF?=
 =?utf-8?B?dW9MNmZEY01QK2ZwcmYxNW9LWjlzWmU1LzhwYUk0ZzUvK3EwQUlpWXlJd1NU?=
 =?utf-8?B?a0ZvM3pMaU1GVVdnOHZiN3BXUVZtMVFZd2F6NTQ0TVF4RTlCUGlwSUpmQjB4?=
 =?utf-8?B?VDE3Z3ZTK0VHUjZKajEvQzA5NndBZ2JCRUFLK2NZbzJOSVpYTVRQajUyNCt0?=
 =?utf-8?B?ZDMrY3pHT0VUcHE0ZjlDVUljL1J1cVgrSXdCZ3RMVXoxTW0wWFJHUXUvWjQr?=
 =?utf-8?B?anAxOGVEQ0ZLdXNVUkNYeVFnS3ZEREZSQ1VFSFVia0RORTFENHY4dVQzU1NK?=
 =?utf-8?B?Z0ZoL3djRnFWZjNqWlp2Zm83U2NRUWI2NHRMV1gwR3NFOUxETUI2TUZWbVVm?=
 =?utf-8?B?ZGVqSiticWE3c3pCMWpqUTcxRDlFQzVkTmNKMnVhYWxjVm5rd2VSS2MwdWls?=
 =?utf-8?B?VGtNQkFjdzk2bzBqUUUrL0RodVlnZm8zTVdjQWRyeEE3TGtvMkhkNVFLZ08y?=
 =?utf-8?B?bjk1VHdYOHp0YWFCcUhjNGp5Y2xhaWJ3MlBDajdlbDRSMmFGaTZLY2FNYzY5?=
 =?utf-8?B?aXIzbUorbzlZc1dGSzNpWVdRRHFhS0RzM1ZhV3pTemxtY1ZnMjlNQVF0OTRS?=
 =?utf-8?B?Ni9NMjJzZ1Z2ZmVrbVJWUitLVHhTZ2ZXUEQwTE0vMzdjZmZsQm9DSW1HNW5P?=
 =?utf-8?B?OWNDMjVOL1lkMXJZMCtEK1dCdzk5SGg1SEVkdHN2c0FxQ1B6eUxPeVdoNHIr?=
 =?utf-8?B?ZlhJT1JPSTRqNVVoL3pISlMzOFVGYUhZNWRoK3ROZEhjT0Z2N1MyNzFTRTFk?=
 =?utf-8?B?YmhvMlJHQmthcFNNdnFYNllCUWdpeEV1Snc4bWRSR2dVbWl5RldRaEFZVUJX?=
 =?utf-8?B?aWNXNjVNcmpUa0RER3A3dVVJcUNVaVJKVjN3OE9mNkd1QWMvSVZOZmZoZnBC?=
 =?utf-8?B?c0U0R3NTLzFCb1I3T0tERDVUT0FFUTN2VjRFZTNhZzJYZmd6VUM5NVpEbDU1?=
 =?utf-8?B?RVFnekxjUFkvbGZPZHoybVJLWjNiNzhESUZrcytOcEMzRDFaTXp2OFFOMjRi?=
 =?utf-8?B?UGdwK3c4MnVDZ2pkQkxueDRQM0NreTU2ZlgvQkRkeHQwTHU5NTlOQTNzRkNH?=
 =?utf-8?B?YXNISEZtMU5TaVhNNGpxNks1MzUrSFJxWmozNkFCVXB3b04rL1VPUEg0NkNi?=
 =?utf-8?B?OXlwc0phZlhMaTV3NkVSU3pyU2JLWjJqZ3R1N2M5cElXeTd1MUxURytsd1ov?=
 =?utf-8?Q?UzOyC7fkF1ek1SUG9RWDFvrT+NZ3QGClcZ/T4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86B30013C8FBA24AAB66255343FF1019@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XgLksu4r3Ogy5T8y+Kw/8uzycNcmyU04i9vBnIK8agaUOjMQt0GM6FOSlGKUimKA8kkqrW39DQP1VvVIVgsEl6u++Rf1WbJAmcUmzADy3bFLpi4UVWK6FPZ1AyTCAnntDUJHKN7rZrZvN8+n4akc4sDgtig+n6e1pyacX8+F05Qn1COd7MgIEOo/f0E7SUBSp9ESpheb80YHqK9PcoNd1HLNVFOxbLokwAJzCDCdj1cjeKAFUn6mIRHv4f8S6wSEYfR6itN1YA8GYYB82RnnzhmGpgsK38oaj4CY+7NrnTGnTPJmyC3pY/I6gcc938R7tv8qVUzuRLjlHuek3Y2gJg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f692d52-1372-4940-0496-08debb536069
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 18:19:50.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWOm3rh6DVA3xbufmRjT9zbfWW1RLy94S6wI/sMtUbC/QW4lCZL34mezNz4dG1y/oTmoSRACo4dsbusex4MQ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4393
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a15e44d cx=c_pps
 a=FOw1GTnNYXmOwZ/eduxC4w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=_0w8rwJdB_tnRQ9bPBIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lkeJS3g9q-MhLttWd3DORnvF4p-H1hat
X-Proofpoint-ORIG-GUID: 3bNV0NXZxeXXHJI9b5jlvaOXHuZ0Q1l6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE1OCBTYWx0ZWRfX/dIEZBHtqBu2
 sSYlYRxdVBMY4tDd5MJGNJefklNKLzGv+CP4cC+5YoXD0U4OINlMPfY0xQqJmbFCquitthjY5dd
 pbJlBqZqVb7+i3U5ZnGoESZV7L64KOEE2j1mB8alFyssoWVhnrL9Omva7YbbGLopQZU/8xn6UGQ
 6ZDV/ZvmQuk2Cfv1tEkEBlHaWLYdIdGo7bFh/F4jAb3kRSqpGGIUGHRiQl1OCdTqdo13+ykosdO
 24WF4htTvHu35fDItk1nX+PU+4E9w63+sH+MwD/Zngwv3xCS+0uAqcpa4yiiwhJZUMuFTXljuuP
 hNKE4prlsQ79I+05fV2QQmVBflfIk3ImZj5L7XMnai8PQthBvdy0z3tAXRNtaZs7zoVHd5EblE8
 xYR4oIsgb6kXUXJTP+Vv/vWFESmxZHYGilBfXWlxN6bwKcY45KvKrhIkLPh+gWXdB/80N84IiL4
 zZKM0RpboggadYXZBDw==
Subject: Re:  [PATCH v2] ceph: fix OOB read in decode_watchers() via missing
 bounds check
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260158
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254412-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.739];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1445C5DB540
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDA2OjE5IC0wNDAwLCBQYXZpdHJhIEpoYSB3cm90ZToNCj4g
Y2VwaF9zdGFydF9kZWNvZGluZygpIHZhbGlkYXRlcyB0aGF0IHN0cnVjdF9sZW4gYnl0ZXMgcmVt
YWluIGluIHRoZQ0KPiBidWZmZXIgYWZ0ZXIgdGhlIGVuY29kaW5nIGhlYWRlciwgYnV0IGFjY2Vw
dHMgc3RydWN0X2xlbj0wIGFzIHZhbGlkOg0KPiBjZXBoX2RlY29kZV9uZWVkKHAsIGVuZCwgMCwg
YmFkKSBhbHdheXMgcGFzc2VzLiBXaGVuIGEgbWFsaWNpb3VzIG9yDQo+IGNvbXByb21pc2VkIE9T
RCBzZW5kcyBhbiBvYmpfbGlzdF93YXRjaF9yZXNwb25zZV90IHJlcGx5IHdpdGgNCj4gc3RydWN0
X2xlbj0wLCBjZXBoX3N0YXJ0X2RlY29kaW5nKCkgcmV0dXJucyBzdWNjZXNzIHdpdGggcCA9PSBl
bmQsDQo+IGxlYXZpbmcgemVybyBieXRlcyBndWFyYW50ZWVkIGZvciBzdWJzZXF1ZW50IHJlYWRz
Lg0KPiANCj4gVGhlIGltbWVkaWF0ZWx5IGZvbGxvd2luZyBjZXBoX2RlY29kZV8zMihwKSBpbiBk
ZWNvZGVfd2F0Y2hlcnMoKSBoYXMNCj4gbm8gcHJlY2VkaW5nIGJvdW5kcyBjaGVjay4gV2l0aCBw
ID09IGVuZCB0aGlzIGlzIGEgNC1ieXRlIHJlYWQgcGFzdA0KPiB0aGUgdmFsaWRhdGVkIGJ1ZmZl
ciBib3VuZGFyeS4gVGhlIGdhcmJhZ2UgdmFsdWUgaXMgdGhlbiBwYXNzZWQNCj4gZGlyZWN0bHkg
dG8ga3phbGxvY19vYmpzKCkgYXMgdGhlIHdhdGNoZXIgY291bnQuDQo+IA0KPiBUaGUgc2libGlu
ZyBmdW5jdGlvbiBkZWNvZGVfd2F0Y2hlcigpIGFscmVhZHkgdXNlcyB0aGUgc2FmZSB2YXJpYW50
cw0KPiAoY2VwaF9kZWNvZGVfY29weV9zYWZlLCBjZXBoX2RlY29kZV82NF9zYWZlLCBjZXBoX2Rl
Y29kZV9za2lwXzMyKQ0KPiBhZnRlciBpdHMgb3duIGNlcGhfc3RhcnRfZGVjb2RpbmcoKSBjYWxs
LiBkZWNvZGVfd2F0Y2hlcnMoKSBpcyB0aGUNCj4gb25seSBzaXRlIHRoYXQgdXNlcyB0aGUgYmFy
ZSB2YXJpYW50LCBjb25maXJtaW5nIGFuIG92ZXJzaWdodC4NCj4gDQo+IEZpeCBieSByZXBsYWNp
bmcgY2VwaF9kZWNvZGVfMzIocCkgd2l0aCBjZXBoX2RlY29kZV8zMl9zYWZlKHAsIGVuZCwNCj4g
Km51bV93YXRjaGVycywgZV9pbnZhbCksIGNvbnNpc3RlbnQgd2l0aCB0aGUgZXN0YWJsaXNoZWQg
cGF0dGVybi4NCj4gDQo+IEtBU0FOIHJlcG9ydCAoa2VybmVsIDcuMC4wLXJjNywgUUVNVS94ODZf
NjQsIEtBU0xSIGRpc2FibGVkKToNCj4gDQo+ICAgWyAgIDcyLjA0NzA4NV0gY2VwaF9vb2JfcG9j
OiBidWY9ZmZmZjg4ODAwODU5MzZjOCBlbmQ9ZmZmZjg4ODAwODU5MzZjZQ0KPiAgIFsgICA3Mi4w
NDg2ODVdIGNlcGhfb29iX3BvYzogY2VwaF9zdGFydF9kZWNvZGluZyBPSzogc3RydWN0X3Y9MQ0K
PiAgIHN0cnVjdF9sZW49MCBwPT1lbmQ6IDENCj4gICBbICAgNzIuMDQ5NDc3XSBjZXBoX29vYl9w
b2M6IHRyaWdnZXJpbmcgT09CIHJlYWQgcGFzdCBzbGFiIGJvdW5kYXJ5Li4uDQo+ICAgWyAgIDcy
LjA1MDY5OV0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NCj4gICBbICAgNzIuMDUxNDI3XSBCVUc6IEtBU0FOOiBzbGFiLW91dC1vZi1ib3VuZHMgaW4N
Cj4gICBjZXBoX29vYl9pbml0KzB4MTI4LzB4ZmYwIFtjZXBoX29vYl9wb2NdDQo+ICAgWyAgIDcy
LjA1MTQyN10gUmVhZCBvZiBzaXplIDQgYXQgYWRkciBmZmZmODg4MDA4NTkzNmNlIGJ5IHRhc2sg
aW5zbW9kLzYxDQo+ICAgWyAgIDcyLjA1MTQyN10gQ1BVOiAwIFVJRDogMCBQSUQ6IDYxIENvbW06
IGluc21vZCBUYWludGVkOiBHIE8NCj4gICBbICAgNzIuMDUxNDI3XSAgNy4wLjAtcmM3LWc5YzJh
YmY2OWRhODMtZGlydHkgIzE0IFBSRUVNUFQobGF6eSkNCj4gICBbICAgNzIuMDUxNDI3XSBDYWxs
IFRyYWNlOg0KPiAgIFsgICA3Mi4wNTE0MjddICBkdW1wX3N0YWNrX2x2bCsweDRkLzB4NzANCj4g
ICBbICAgNzIuMDUxNDI3XSAgcHJpbnRfcmVwb3J0KzB4MTcwLzB4NGYzDQo+ICAgWyAgIDcyLjA1
MTQyN10gIGthc2FuX3JlcG9ydCsweGRhLzB4MTEwDQo+ICAgWyAgIDcyLjA1MTQyN10gIGthc2Fu
X2NoZWNrX3JhbmdlKzB4MTI1LzB4MjAwDQo+ICAgWyAgIDcyLjA1MTQyN10gIGNlcGhfb29iX2lu
aXQrMHgxMjgvMHhmZjAgW2NlcGhfb29iX3BvY10NCj4gICBbICAgNzIuMDUxNDI3XSAgZG9fb25l
X2luaXRjYWxsKzB4OWEvMHgzMTANCj4gICBbICAgNzIuMDUxNDI3XSAgZG9faW5pdF9tb2R1bGUr
MHgxODYvMHg0MTANCj4gICBbICAgNzIuMDUxNDI3XSAgbG9hZF9tb2R1bGUrMHgyYmE3LzB4MmU1
MA0KPiAgIFsgICA3Mi4wNTE0MjddICBpbml0X21vZHVsZV9mcm9tX2ZpbGUrMHgxNWMvMHgxODAN
Cj4gICBbICAgNzIuMDUxNDI3XSAgaWRlbXBvdGVudF9pbml0X21vZHVsZSsweDE5Zi8weDQzMA0K
PiAgIFsgICA3Mi4wNTE0MjddICBfX3g2NF9zeXNfZmluaXRfbW9kdWxlKzB4NzgvMHhjMA0KPiAg
IFsgICA3Mi4wNTE0MjddICBkb19zeXNjYWxsXzY0KzB4ZTIvMHg1NzANCj4gICBbICAgNzIuMDUx
NDI3XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzcvMHg3Zg0KPiAgIFsgICA3
Mi4wNTE0MjddIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIG9iamVjdCBhdCBmZmZm
ODg4MDA4NTkzNmM4DQo+ICAgWyAgIDcyLjA1MTQyN10gIHdoaWNoIGJlbG9uZ3MgdG8gdGhlIGNh
Y2hlIGttYWxsb2MtOCBvZiBzaXplIDgNCj4gICBbICAgNzIuMDUxNDI3XSBUaGUgYnVnZ3kgYWRk
cmVzcyBpcyBsb2NhdGVkIDAgYnl0ZXMgdG8gdGhlIHJpZ2h0IG9mDQo+ICAgWyAgIDcyLjA1MTQy
N10gIGFsbG9jYXRlZCA2LWJ5dGUgcmVnaW9uIFtmZmZmODg4MDA4NTkzNmM4LCBmZmZmODg4MDA4
NTkzNmNlKQ0KPiAgIFsgICA3Mi4wNTE0MjddIE1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5
IGFkZHJlc3M6DQo+ICAgWyAgIDcyLjA1MTQyN10gPmZmZmY4ODgwMDg1OTM2ODA6IGZjIGZjIGZj
IGZjIGZjIGZjIGZjIGZjIGZjIDA2IGZjIGZjIGZjIGZjIGZjIGZjDQo+ICAgWyAgIDcyLjA1MTQy
N10gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gICBb
ICAgNzIuMDUxNDI3XSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KPiAgIFsgICA3Mi4xMjk3MjBdIGNlcGhfb29iX3BvYzogbnVtX3dhdGNoZXJzPTM0
MzU5NzM4MzYgKE9PQiBnYXJiYWdlKQ0KPiANCj4gICAweENDQ0NDQ0NDICgzNDM1OTczODM2KSBp
cyBLQVNBTiByZWR6b25lIHBvaXNvbiwgY29uZmlybWluZyB0aGUgcmVhZA0KPiAgIGxhbmRlZCBp
biB0aGUgc2xhYiByZWR6b25lIGltbWVkaWF0ZWx5IHBhc3QgdGhlIDYtYnl0ZSBhbGxvY2F0aW9u
Lg0KPiANCj4gQXR0YWNrZXIgbW9kZWw6IGEgbWFsaWNpb3VzIG9yIGNvbXByb21pc2VkIE9TRCBp
biBhIG11bHRpLXRlbmFudCBDZXBoDQo+IGRlcGxveW1lbnQgKGUuZy4gY2xvdWQpIGNhbiB0cmln
Z2VyIHRoaXMgYWdhaW5zdCBhbnkga2VybmVsIGNsaWVudA0KPiB0aGF0IGNhbGxzIENFUEhfT1NE
X09QX0xJU1RfV0FUQ0hFUlMsIHdpdGhvdXQgYW55IGZ1cnRoZXIgcHJpdmlsZWdlcw0KPiBiZXlv
bmQgT1NEIHNlc3Npb24gZXN0YWJsaXNobWVudC4NCj4gDQo+IEZpeGVzOiBhNGVkMzhkN2ExODAg
KCJsaWJjZXBoOiBzdXBwb3J0IGZvciBDRVBIX09TRF9PUF9MSVNUX1dBVENIRVJTIikNCj4gQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogUGF2aXRyYSBKaGEgPGpo
YXBhdml0cmE5OEBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MjogQ29ycmVjdCBjb21taXQgbWVzc2Fn
ZS4gdjEgb3ZlcnN0YXRlZCB0aGUgaW1wYWN0Og0KPiANCj4gICAtICJ1bmJvdW5kZWQgYWxsb2Mi
OiByZXRyYWN0ZWQuIGt6YWxsb2Nfb2JqcygpIHVzZXMgc2l6ZV9tdWwoKQ0KPiAgICAgaW50ZXJu
YWxseSB3aGljaCByZXR1cm5zIFNJWkVfTUFYIG9uIG92ZXJmbG93LCBjYXVzaW5nIGttYWxsb2MN
Cj4gICAgIHRvIHJldHVybiBOVUxMLiBUaGUgbGFyZ2UgZ2FyYmFnZSB2YWx1ZSBmcm9tIHRoZSBP
T0IgcmVhZCB3aWxsDQo+ICAgICBzaW1wbHkgZmFpbCBhbGxvY2F0aW9uIHdpdGggLUVOT01FTS4N
Cj4gDQo+ICAgLSAiZGVjb2RlX3dhdGNoZXIoKSB3cml0aW5nIGF0dGFja2VyLWNvbnRyb2xsZWQg
ZGF0YSBpbnRvIGl0IjoNCj4gICAgIHJldHJhY3RlZC4gY2VwaF9zdGFydF9kZWNvZGluZygpIGNh
bGxzIGNlcGhfZGVjb2RlX25lZWQoKSBmb3INCj4gICAgIGl0cyA2LWJ5dGUgaGVhZGVyLCB3aGlj
aCBjYXRjaGVzIHA9PWVuZCBhbmQgcmV0dXJucyAtRVJBTkdFDQo+ICAgICBiZWZvcmUgYW55IGNv
cHkgb2NjdXJzLiBWZXJpZmllZCB3aXRoIGEgZm9sbG93LXVwIEtBU0FOIGhhcm5lc3MuDQo+IA0K
PiAgIFRoZSBmaXggaXRzZWxmIGlzIHVuY2hhbmdlZC4NCj4gLS0tDQo+ICBuZXQvY2VwaC9vc2Rf
Y2xpZW50LmMgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvb3NkX2NsaWVudC5jIGIv
bmV0L2NlcGgvb3NkX2NsaWVudC5jDQo+IGluZGV4IDJmZjAwMDcwYy4uMDE0OGU0YzQwIDEwMDY0
NA0KPiAtLS0gYS9uZXQvY2VwaC9vc2RfY2xpZW50LmMNCj4gKysrIGIvbmV0L2NlcGgvb3NkX2Ns
aWVudC5jDQo+IEBAIC01MDMwLDcgKzUwMzAsNyBAQCBzdGF0aWMgaW50IGRlY29kZV93YXRjaGVy
cyh2b2lkICoqcCwgdm9pZCAqZW5kLA0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiByZXQ7DQo+
ICANCj4gLQkqbnVtX3dhdGNoZXJzID0gY2VwaF9kZWNvZGVfMzIocCk7DQo+ICsJY2VwaF9kZWNv
ZGVfMzJfc2FmZShwLCBlbmQsICpudW1fd2F0Y2hlcnMsIGVfaW52YWwpOw0KPiAgCSp3YXRjaGVy
cyA9IGt6YWxsb2Nfb2JqcygqKndhdGNoZXJzLCAqbnVtX3dhdGNoZXJzLCBHRlBfTk9JTyk7DQo+
ICAJaWYgKCEqd2F0Y2hlcnMpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiBAQCAtNTA0NCw2ICs1
MDQ0LDkgQEAgc3RhdGljIGludCBkZWNvZGVfd2F0Y2hlcnModm9pZCAqKnAsIHZvaWQgKmVuZCwN
Cj4gIAl9DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gKw0KPiArZV9pbnZhbDoNCj4gKwlyZXR1cm4g
LUVJTlZBTDsNCg0KTWF5YmUsIEkgbm90IGNvbXBsZXRlbHkgbGlrZSB0aGUgZV9pbnZhbCBuYW1l
LiA6KSBVc3VhbGx5LCBpdCBpcyB1c2VkIGJhZCBuYW1lLg0KQnV0IGl0J3MgY29tcGxldGVseSBu
b3QgY3JpdGljYWwgYXQgYWxsLg0KDQpBbHNvLCBJIGFtIG5vdCBjb21wbGV0ZWx5IHN1cmUgdGhh
dCAtRUlOVkFMIGlzIGNvcnJlY3QgZXJyb3IgY29kZS4gVXN1YWxseSwNCkVJTlZBTCBpcyB1c2Vk
IGZvciBpbnZhbGlkIGFyZ3VtZW50LiBIZXJlLCB3ZSBhbmFseXplIHRoZSByZXBseSdzIGNvbnRl
bnQgYW5kIGl0DQpzb3VuZHMgbGlrZSBub3QgaW5wdXQgYXJndW1lbnQuIEFuZCwgZmluYWxseSwg
d2UgY2Fubm90IGFsbG9jYXRlIG1lbW9yeS4gU28sDQptYXliZSwgLUVOT01FTSBpcyBtb3JlIHBy
b3BlciBlcnJvciBjb2RlLiBIb3dldmVyLCBpdCBpcyBub3QgY3JpdGljYWwgcmVtYXJrIHRvLg0K
DQo+ICB9DQo+ICANCj4gIC8qDQoNClRoZSBmaXggbWFrZXMgc2Vuc2UgYW5kIGl0IGxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJt
LmNvbT4NCg0KVGhhbmtzLA0KU2xhdmEuDQo=

