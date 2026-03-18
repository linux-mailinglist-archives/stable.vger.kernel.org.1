Return-Path: <stable+bounces-227178-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB5fMI8pu2kcfwIAu9opvQ
	(envelope-from <stable+bounces-227178-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:39:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A942C38DB
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 23:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E84231476DE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 22:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA53126AD;
	Wed, 18 Mar 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RPMCEwYo"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32421CA03;
	Wed, 18 Mar 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873242; cv=fail; b=L2azfZ14xaCUXlRp9whMLYeOg1d0R+VXkNHAY7UEciWVfz/iYwdwA+IWl/xvJ6WLc4ATPctAj42qzga+8mzaokIj47WkTwN0LMp6uILJpqs9p3xTm47PnyYyE1m+g4x6G3k/Nq2vb1ysafGJnt19fqoQRdp/U2/E1bcyuxxcLI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873242; c=relaxed/simple;
	bh=UFAaHq0PpzI4+nIrF4zhodMg3M60AEKbXWhnbYcFBps=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=uQNLqVtqIAPJRF+7q2fTNDs9Hpq0KIP1yo96a24/drpjSyeFdoWuobR+N+V2e1/Kl7ZyZrM6owE6U6rQ0MCUF0QQzG32kg/z0kA/RaQu8dcNTHE4+5cFFSpGcpTQGrnqJTAlxov/33fDhiSRXGzrowG+Hf9BAZ7+Mw8JWDTavBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RPMCEwYo; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IJWLPI509786;
	Wed, 18 Mar 2026 22:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=UFAaHq0PpzI4+nIrF4zhodMg3M60AEKbXWhnbYcFBps=; b=RPMCEwYo
	NtHMAbaRGoedK3jCmCAq58XVi4a+8raHsDZL622mJfW8QuSsso2SAbI5RngMhFmB
	BTQWy3o4wHCX85kjDfGGXmHYAF699t6EFdz7WO3Kh1zSNJzF/8GAQRi6gEHZ6W3q
	Z1jzmwMfdIo3X8bD6g7BnHsqFoWHlcXsuZyZIskduZa1J1UAlStTkU285S5uymDh
	H3wcL6l4QDffXlVosvC6Eg6E2c5gMm8KCPFGJe0NW0iO4O4hQzKNfyAwPkcuTkU0
	RCV3Z2qbdcP64A2dDFd2N8mA/qRmZRImjZp9QUfAH7lFpdYC8FObXqdPNaGYqxFh
	hYhp2ndz/2XGGQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyauknd9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 22:33:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vprftiLR7RHavEh8BH4JcTDxzKHSezXcrMYnGas1D5x1i0RPPcQsORPNuXqVQAlo5GnOfeLeYyCvkO+tCSSyPSt8GWgdPoUPwjFfJn+ZoFLqNDvzv3gCU+Ugpz49nNAVL1+34kcarLj62T+UjImozFTH9s6c5cXF2OF9mOW13Icc9ZOBS11uTDNmHVetUDZCMd9rZ6RLU297HHTsNn6dJGFH1Bi5HcIqyNTApo4/lqduU5Q5dhuWiPtmzrVjGwZGI1YDIC5HXvVR5oMYaBFhEn7LX9jtlPMJ1TcA4jSrqhroLC+YuwTa4SLTC6wEEO7AwQeq+ELGn81p4f0BkmomQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFAaHq0PpzI4+nIrF4zhodMg3M60AEKbXWhnbYcFBps=;
 b=Lh9deb7VM7mFuJrDeEFWp3SHNNaGKfmew1k+/JNCfryhr/6mmi0uw9Qy/kjRGUmRKeBCWSfwZRSgx7NTdh9zxAQrb9dJl9WN3d6YVHPCARVhBqiFrcysmmsP6Uheag9hy4QOjd4hiR9+3VZNyyp5HKtcJKr7unY3YH5ovshgxf32NZPA0M8RqWTIZbPLBo021LKCkpQ9hqfiLXkZ8YofyTtod+ocknZSvUAKT5a6wFdUtjqxATMvBW8XvqmxgTAB5Kl71iSxgoKd+aAqjZVfTprUGqIeUdnRvpbWn7bSyHgBNi+f8iVoy9avCBBa5Purrw+G/J9kzsEAAGocDAFl9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4534.namprd15.prod.outlook.com (2603:10b6:a03:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 22:33:48 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 22:33:47 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "zilin@seu.edu.cn" <zilin@seu.edu.cn>
CC: "jianhao.xu@seu.edu.cn" <jianhao.xu@seu.edu.cn>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH v2 2/2] hfsplus: extract hidden directory
 search into a helper function
Thread-Index: AQHctugQZaovAtR6fEWXtCcXGbNekrW04MAA
Date: Wed, 18 Mar 2026 22:33:47 +0000
Message-ID: <e86980b8682bb9ea007d9fdfab8a8530781ebb2b.camel@ibm.com>
References: <20260318150046.431428-1-zilin@seu.edu.cn>
	 <20260318150046.431428-3-zilin@seu.edu.cn>
In-Reply-To: <20260318150046.431428-3-zilin@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4534:EE_
x-ms-office365-filtering-correlation-id: 60e5055a-b6f7-4463-7456-08de853e6b9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 JVrcr+2tYBPkMeDZOpXm0KIllU9rcnzCh9bdj04RpABR8+bS8C9VMKd8JLb8ichRC73zO4piNTPMzoLgifV9/EuQBqg8lcj4faY+zl5HY6K/HMyBl3P7EEMo6GhbkoyqjiYZlCl5O5PlsiwWez4sTbjgSO9+KVzVUG2mq1VRNFX69MmN4q2syVHuLO6kiLCSpej5AlKzGd1Pgh3Rm9dMRRTygnF0Ri47oIYLGlqfO0lyqxChL7G2MUlHy+S46e5C8y+VfEEv81HRhszSvsGiFVZDrBKz18hE5XdlmUQBCkOR1DquyaoRSDjeoO3N+IWG/9fJ1gaLU10KLZP83tvfqVewxim4iFNes3qpcg9lDhzMbcxTe5KKtGH7BtDG1Iy5Fgqx3oMxFe3dN6amtlnmLdDEBNV7Xz1rhUaQtFofHIBvthH7fIJO967eEDeG14q/l7FbDRjbRJMFSlVOQE3eyYPjMLcznYaMRqfd0T1AjfREZxROVYK7Eff3fJbbFZ1RYg2nahhxU9tbYsEQqpqZJNxP9BVbAWW52ocBrUSr+UmUEv1U8j21iQ3l35UVIPpajj+GMdiT55GbwLu3z+EEQ1rRlDoHpyewKBg96ZMwsuhfqBSIH9UonFuemvHCY2QRMWECgTuLnVWnTjks59Svk9+s3gfp44ud5bhmXE2T54bf4ExAg8j1mXqexysunc5y20Y6SnT1VltdZX2cxIC3h+fy6/e7pDkRZ1/o48vUfFwqk9zMWxEvApXPSx5Td7kR3pfVuPnmWfpu7uYl1+AC6fGtzNFujulhbRQ7zOAjlj4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzZhbG9OQzkrZXFNSTRnSnNTZ0o5bjV2WG1VREJiSHNaYS9EREdsWUhnRWQ2?=
 =?utf-8?B?d21zQkpPSTd6ZmM2cXVCRjdiM0RaRzlSb0lVLzBWK0k1S3BNQjNpeTdHTE1h?=
 =?utf-8?B?K2N2WGhFNVNWNUR0R2plaEFiaGpRa2IySnBKTXJnemIvVUZIZmR5dEduUXF6?=
 =?utf-8?B?TXdPZ2htNzdsSkNNNjFicVZxQXZpZ213b056VmV0VEdhOURiVkRNUHJZS3RO?=
 =?utf-8?B?RXE0Rm92REhEY0R1b1V4Ky8rMUxXdEJnR3VudWhJNjYvV2gxazBxaUxqcWhx?=
 =?utf-8?B?SzNxcy9YY1A1cXJMdmp0ODhSdkdGcEZsMVd4NFlXWXk2czJSa2t4My9OL29D?=
 =?utf-8?B?VW1CNFp5RS80MVZNcFlnODN1eXp3cTRsYUk4dURXallHelBtOEU2aXFEc0U3?=
 =?utf-8?B?dDZMb1YzWitUUFpOQS8zSHVrT1NEczRxRDFIQXN6OGFoZU9hcmhoUExlTHNT?=
 =?utf-8?B?VklGRE9NdytsbGx6c1h6d1B6TzY3cnltRm9JRVJXRGlFZ1B4bXNQeDM0RUlQ?=
 =?utf-8?B?bDZHVHFzSmRaU3FGSXV0Qjl2MkFQVzE4QmVLNzJVMUp2d0JMMDZNeUJSK21a?=
 =?utf-8?B?Ry9Mb2lmMFY2UEdIb0Q1WlRERDFMZUJsWHd1ZndUUEtDOEcyQXlWYUJ4ckhk?=
 =?utf-8?B?dXlSR1R2VWMvOTZpSFFDcUNBWHdoSlZIRzZEVmtDRzhFR3dDbytyMldoaGtS?=
 =?utf-8?B?TFE2QXQyU0lUKzZHajk3dzk3TTM0dnNvQlVhVlJoZTF3TEY1R3p5aHl6K2Np?=
 =?utf-8?B?STVzcmpmTkwrNTlhSTNDeHFvTDJRVElWRjhpYVdKdFY3d0xKY0dNalM5VHZN?=
 =?utf-8?B?aTFZQXB2S2xNc0ZheFhKNGZNNUhzbkRIUytNMlBUd0VOcmt3MzhLN3FDQWhE?=
 =?utf-8?B?cmQwUUZIakVCS1ZtQWNlYktTRXBUTzZ4UURTSThpVnJ3QU9zejVZZW5IS1Na?=
 =?utf-8?B?ZDJac1YyKzUwOVc3TXRWa0Y3VnVTVUtGSmw5bnlpM2FQYXdDQ3pYUGsxRHJu?=
 =?utf-8?B?cStGWXBVQThaT2FLdjhYUUFia1lIRmI5Q01JeWxMdlRGMEl6bTBySjNhOUtt?=
 =?utf-8?B?TWJSK29GQ2c5N2hjMGlrS2VmcWphVXJVa2xlWjd3UDN3dldXTU1aNTV4UjM4?=
 =?utf-8?B?VkpRdG5FekdkdjlaQ05Zd2wwWGZEazczN2d4d0h3Q01IMEZGRklnUmJacFJX?=
 =?utf-8?B?Y1BWVVBTcDNPTk5sSEpnTUZLdzFYVVdjYnIvdDVYb045Mi8vaDBKZ0xwdjg1?=
 =?utf-8?B?L1BUeHYwSWZQQW1ZZUpxOHg2czZ0WVNlNi9ISWVkWkZHWEExY2dydWZmVyt5?=
 =?utf-8?B?UTVHQkZTZUQ0OE1CTWVjRU5IbnJBczRXcU1HLzdBSDh3WE1vQVZ0OFc3Yzgz?=
 =?utf-8?B?LzJ5Uk1BZ3d3M0hvVmM0bWdrOXZDdU45YXV6QVMxNElxQmdJOFhtM3BtMURj?=
 =?utf-8?B?MWdBMDhKRjdndVkvd3lrd3pBZ0NCZDRwZFowM2gxemRCclhORDMxa1lhenVx?=
 =?utf-8?B?emVPME1pN2p0WW55NUp5dEoxR1dWSXl3dHBsVWs4MUxYeU8rZUtmL0VkampR?=
 =?utf-8?B?VlhySXBUdGJ5MEdELytlSG83UVp0WUhPQjNucmNWY1NmenZpb3NmalUybUhy?=
 =?utf-8?B?WDVxOVd5UXd2c0hYb1JETU4xVnhMeHpMMS9WR2o4Y2FreDBCVFBVSFZpQWVu?=
 =?utf-8?B?aTBZZ0V1WS80VWxrZHNUV2FFWlZaekRZVUczaEpSdy9YbkxHckRMSHh1cVBX?=
 =?utf-8?B?bWVRZ1dhYW9WaUlBNXNtOXhrbEViQnppRXdiWHRqbzMvOC9UekdJSTVMU09E?=
 =?utf-8?B?dTR6UEdsMWlIT2FSUUJSRkRVcTlkUXAvRnRMUWNWMnZ1VmswUmhVT0pFWGZB?=
 =?utf-8?B?Nkw3TS9HSjNXRXh3RE9OWkdPcjdDbmtYY1RwTkxjWnArZVZ1NDY2VUpQbWZi?=
 =?utf-8?B?UDlwVGJCMDBUQ0pYcmttUFFnY1E0eTZqUFhGNzhtTlQ5SkZ5WU9MVHdmNEli?=
 =?utf-8?B?N0FKQ3BVeENHUUEzVGpjSlUvU21CeDQvaGdtZmoxWFczYkNtUytnWDU4M2tR?=
 =?utf-8?B?d1Z2alE1VFMrQkRCYzUzVmxMTHVURXhNN0VuZU42bFZOUUdvYkxXWEF3MDdp?=
 =?utf-8?B?MldUSFd2QlI1czZiRHZMUEJQQnZqK2tWY29tbVJ6T2ZCSGV2QjBQTi92S2F1?=
 =?utf-8?B?OC9RbW1YOXp1Y0E2QVRPekRvaW9JSDdFNS9OMFZoLzUzYjRtdG42MWxqLytz?=
 =?utf-8?B?SE4wa3M4Q2N6YnEzN0orWXgxNXFmTUFKZEtudm5Ha1gxU2dmUGt3b2kvalVD?=
 =?utf-8?B?bGVkZWJOUHpjNUI0Y2JqUTFxQ2svV0JVOXh4L0tzK0RJby90Rmx0TE1zMHNz?=
 =?utf-8?Q?1XE2t7lDx5kEB3tILXhcNOgq6pAdKoAxEMWak?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4389FE97B829F045A198AA04BE2FAF27@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	tPaeazWrce4fa0kYwYIISUKfnQT1GXaKJ8MYwjWJVhHu6IFjzcPkZvs1+HB/pAkkZVuFdk1YgSvKCs/9ph7V64K0KgGy+FrVjGPtmXs/8xHL7Fs1BPUzDgHyYOlXxVZwXGpbNAXGCiiZaS4B4cIiNewd/ettJUE47kxlK3IonzXX0mzUkjVPBquPyUf2uf/ozAeoSXJSwNKlUFILdKB2iusipaNQIQV02pojIzLo6e/lCbWWgeJa/WckQno0kKkefqFWTxKjY7oVdk+ANCB7Em8qrwxKfwzoRxps/Z9pF61u6JGWblGkktdU/LqjGq7cHq2OuA1M7l3LrN14NVmOFg==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e5055a-b6f7-4463-7456-08de853e6b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 22:33:47.2975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1+auPhLlKU2OwluiWX7LemuhJsoybxgXBZRRb/eJbs2O8Wzx522n8UNZTchbH5x6yV/58vW9EqXsaa4Jdaj/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4534
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE5MiBTYWx0ZWRfX1HASrmC8SEEh
 vG+NZ0nm5fLDm5HiEEVxoNStvbELl11bvlmRHXm5IQMjvKzEwFOFT7SSfXDPDeKuLh/yRo0U0yk
 6cjivcOcY1Fn8K7emTsWmGoRVpdHJCTZ3RHXL9nAEyOUyJVvARD85Ps74cY1xuLvFJL83L+fqG/
 DThv/fSmgN3g6rR2jghosC1ha+FIUUtZ1OXfj1jwlhn3ASLNb+/VKDFAHVnasaf6JcQTj/QKgTI
 TmL2mVlgg3EzWKKIT0u5DWyxP0qLvTtdV4+C1J3TXSOHNBk1VpW/8v0I+UpWGq5BpMPVdMrBtKQ
 FiDajhfs6v3+EJfuTGTQCK3iCHORCfm9DiBklpHTdxhPWZt7diuxUqhvnQw78LiNHWBfjrziHav
 EpoKUn3H8RCUEQ7VD83h14ZYqTX6mQpwgAvOjTb3KU2UN+R2aD0x4rqbfVvSw4P28UavNx9y0wu
 /A+ABoOcJHWhSrdonzA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bb284e cx=c_pps
 a=H8U4Gh8omvmqDI9iB/RWMg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=PQ6SMGNLiiK4PPM3B2UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l8IyAzxRRdV0IBTiaZYBngEc4aLslOQT
X-Proofpoint-GUID: l8IyAzxRRdV0IBTiaZYBngEc4aLslOQT
Subject: Re:  [PATCH v2 2/2] hfsplus: extract hidden directory search into a
 helper function
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180192
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
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227178-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 28A942C38DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gV2VkLCAyMDI2LTAzLTE4IGF0IDIzOjAwICswODAwLCBaaWxpbiBHdWFuIHdyb3RlOg0KPiBJ
biBoZnNwbHVzX2ZpbGxfc3VwZXIoKSwgdGhlIHByb2Nlc3Mgb2YgbG9va2luZyB1cCB0aGUgaGlk
ZGVuIGRpcmVjdG9yeQ0KPiBpbnZvbHZlcyBpbml0aWFsaXppbmcgYSBjYXRhbG9nIHNlYXJjaCwg
YnVpbGRpbmcgYSBzZWFyY2gga2V5LCByZWFkaW5nDQo+IHRoZSBiLXRyZWUgcmVjb3JkLCBhbmQg
cmVsZWFzaW5nIHRoZSBzZWFyY2ggZGF0YS4NCj4gDQo+IEN1cnJlbnRseSwgdGhpcyBsb2dpYyBp
cyBvcGVuLWNvZGVkIGRpcmVjdGx5IHdpdGhpbiB0aGUgbWFpbiBzdXBlcmJsb2NrDQo+IGluaXRp
YWxpemF0aW9uIHJvdXRpbmUuIFRoaXMgbWFrZXMgaGZzcGx1c19maWxsX3N1cGVyKCkgcXVpdGUg
bGVuZ3RoeQ0KPiBhbmQgaXRzIGVycm9yIGhhbmRsaW5nIHBhdGhzIGxlc3Mgc3RyYWlnaHRmb3J3
YXJkLg0KPiANCj4gRXh0cmFjdCB0aGUgaGlkZGVuIGRpcmVjdG9yeSBzZWFyY2ggc2VxdWVuY2Ug
aW50byBhIG5ldyBoZWxwZXIgZnVuY3Rpb24sDQo+IGhmc3BsdXNfZ2V0X2hpZGRlbl9kaXJfZW50
cnkoKS4gVGhpcyBpbXByb3ZlcyBvdmVyYWxsIGNvZGUgcmVhZGFiaWxpdHksDQo+IGNsZWFubHkg
ZW5jYXBzdWxhdGVzIHRoZSBoZnNfZmluZF9kYXRhIGxpZmVjeWNsZSwgYW5kIHNpbXBsaWZpZXMg
dGhlDQo+IGVycm9yIGV4aXRzIGluIGhmc3BsdXNfZmlsbF9zdXBlcigpLg0KPiANCj4gTW9yZW92
ZXIsIHRoZSBlcnJvciBoYW5kbGluZyBsb2dpYyBmb3IgaGZzX2JyZWNfcmVhZCBpcyB1cGRhdGVk
IHRvIG1pcnJvcg0KPiBoZnNwbHVzX2xvb2t1cCgpLiBUaGlzIGdyYWNlZnVsbHkgaGFuZGxlcyB0
aGUgLUVOT0VOVCBjYXNlLCBrZWVwaW5nIHRoZQ0KPiBkaXJlY3Rvcnkgc2VhcmNoIGJlaGF2aW9y
IGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgZmlsZXN5c3RlbS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFppbGluIEd1YW4gPHppbGluQHNldS5lZHUuY24+DQo+IC0tLQ0KPiAgZnMvaGZz
cGx1cy9zdXBlci5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9mcy9oZnNwbHVzL3N1cGVyLmMgYi9mcy9oZnNwbHVzL3N1cGVy
LmMNCj4gaW5kZXggZjM5NmZlZTE5YWI4Li5kZjNmMTA0Mjk4Y2YgMTAwNjQ0DQo+IC0tLSBhL2Zz
L2hmc3BsdXMvc3VwZXIuYw0KPiArKysgYi9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gQEAgLTQyNCwx
MiArNDI0LDMzIEBAIHZvaWQgaGZzcGx1c19wcmVwYXJlX3ZvbHVtZV9oZWFkZXJfZm9yX2NvbW1p
dChzdHJ1Y3QgaGZzcGx1c192aCAqdmhkcikNCj4gIAl2aGRyLT5hdHRyaWJ1dGVzIHw9IGNwdV90
b19iZTMyKEhGU1BMVVNfVk9MX0lOQ05TVE5UKTsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGlubGlu
ZSBpbnQgaGZzcGx1c19nZXRfaGlkZGVuX2Rpcl9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LA0KPiArCQkJCQkgICAgICAgY29uc3Qgc3RydWN0IHFzdHIgKnN0ciwNCj4gKwkJCQkJICAgICAg
IGhmc3BsdXNfY2F0X2VudHJ5ICplbnRyeSkNCj4gK3sNCj4gKwlzdHJ1Y3QgaGZzX2ZpbmRfZGF0
YSBmZDsNCj4gKwlpbnQgZXJyOw0KPiArDQo+ICsJZXJyID0gaGZzX2ZpbmRfaW5pdChIRlNQTFVT
X1NCKHNiKS0+Y2F0X3RyZWUsICZmZCk7DQo+ICsJaWYgKGVycikNCg0KV2h5IG5vdCB1bmxpa2Vs
eShlcnIpIGhlcmUgdG9vPw0KDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwllcnIgPSBoZnNw
bHVzX2NhdF9idWlsZF9rZXkoc2IsIGZkLnNlYXJjaF9rZXksIEhGU1BMVVNfUk9PVF9DTklELCBz
dHIpOw0KPiArCWlmICh1bmxpa2VseShlcnIgPCAwKSkNCg0KVGhlIGhmc3BsdXNfY2F0X2J1aWxk
X2tleSgpIHJldHVybiBlcnJvciBjb2RlIG9yIDAuIFNvLCB3ZSBjYW4gdXNlIHVubGlrZWx5KGVy
cikNCmhlcmUuDQoNCj4gKwkJZ290byBmcmVlX2ZkOw0KPiArDQo+ICsJZXJyID0gaGZzX2JyZWNf
cmVhZCgmZmQsIGVudHJ5LCBzaXplb2YoKmVudHJ5KSk7DQo+ICsNCj4gK2ZyZWVfZmQ6DQo+ICsJ
aGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiArCXJldHVybiBlcnI7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBpbnQgaGZzcGx1c19maWxsX3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBm
c19jb250ZXh0ICpmYykNCj4gIHsNCj4gIAlzdHJ1Y3QgaGZzcGx1c192aCAqdmhkcjsNCj4gIAlz
dHJ1Y3QgaGZzcGx1c19zYl9pbmZvICpzYmkgPSBIRlNQTFVTX1NCKHNiKTsNCj4gIAloZnNwbHVz
X2NhdF9lbnRyeSBlbnRyeTsNCj4gLQlzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSBmZDsNCj4gIAlzdHJ1
Y3QgaW5vZGUgKnJvb3QsICppbm9kZTsNCj4gIAlzdHJ1Y3QgcXN0ciBzdHI7DQo+ICAJc3RydWN0
IG5sc190YWJsZSAqbmxzOw0KPiBAQCAtNTY1LDE2ICs1ODYsMTEgQEAgc3RhdGljIGludCBoZnNw
bHVzX2ZpbGxfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQg
KmZjKQ0KPiAgDQo+ICAJc3RyLmxlbiA9IHNpemVvZihIRlNQX0hJRERFTkRJUl9OQU1FKSAtIDE7
DQo+ICAJc3RyLm5hbWUgPSBIRlNQX0hJRERFTkRJUl9OQU1FOw0KPiAtCWVyciA9IGhmc19maW5k
X2luaXQoc2JpLT5jYXRfdHJlZSwgJmZkKTsNCj4gLQlpZiAoZXJyKQ0KPiAtCQlnb3RvIG91dF9w
dXRfcm9vdDsNCj4gLQllcnIgPSBoZnNwbHVzX2NhdF9idWlsZF9rZXkoc2IsIGZkLnNlYXJjaF9r
ZXksIEhGU1BMVVNfUk9PVF9DTklELCAmc3RyKTsNCj4gLQlpZiAodW5saWtlbHkoZXJyIDwgMCkp
IHsNCj4gLQkJaGZzX2ZpbmRfZXhpdCgmZmQpOw0KPiAtCQlnb3RvIG91dF9wdXRfcm9vdDsNCj4g
LQl9DQo+IC0JaWYgKCFoZnNfYnJlY19yZWFkKCZmZCwgJmVudHJ5LCBzaXplb2YoZW50cnkpKSkg
ew0KPiAtCQloZnNfZmluZF9leGl0KCZmZCk7DQo+ICsJZXJyID0gaGZzcGx1c19nZXRfaGlkZGVu
X2Rpcl9lbnRyeShzYiwgJnN0ciwgJmVudHJ5KTsNCj4gKwlpZiAoZXJyKSB7DQo+ICsJCWlmIChl
cnIgIT0gLUVOT0VOVCkNCj4gKwkJCWdvdG8gb3V0X3B1dF9yb290Ow0KDQpUaGUgaGZzX2JyZWNf
cmVhZCgpIGNhbiByZXR1cm4gbXVsdGlwbGUgZXJyb3JzIChmb3IgZXhhbXBsZSwgLUVJTlZBTCku
IEFyZSB5b3UNCnN1cmUgdGhhdCB0aGlzIGNoZWNrIGlzIGNvcnJlY3Q/DQoNClRoYW5rcywNClNs
YXZhLg0KDQo+ICsJfSBlbHNlIHsNCj4gIAkJaWYgKGVudHJ5LnR5cGUgIT0gY3B1X3RvX2JlMTYo
SEZTUExVU19GT0xERVIpKSB7DQo+ICAJCQllcnIgPSAtRUlPOw0KPiAgCQkJZ290byBvdXRfcHV0
X3Jvb3Q7DQo+IEBAIC01ODUsOCArNjAxLDcgQEAgc3RhdGljIGludCBoZnNwbHVzX2ZpbGxfc3Vw
ZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGZzX2NvbnRleHQgKmZjKQ0KPiAgCQkJ
Z290byBvdXRfcHV0X3Jvb3Q7DQo+ICAJCX0NCj4gIAkJc2JpLT5oaWRkZW5fZGlyID0gaW5vZGU7
DQo+IC0JfSBlbHNlDQo+IC0JCWhmc19maW5kX2V4aXQoJmZkKTsNCj4gKwl9DQo+ICANCj4gIAlp
ZiAoIXNiX3Jkb25seShzYikpIHsNCj4gIAkJLyoNCg==

