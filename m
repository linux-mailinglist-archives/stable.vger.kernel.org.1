Return-Path: <stable+bounces-136541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41190A9A74E
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 11:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E354E188D65F
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 09:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8A21C160;
	Thu, 24 Apr 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="GcULBEnb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jdg+g/c+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327641B040B;
	Thu, 24 Apr 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745485304; cv=fail; b=jSzIudYeW8GNNAMNPTjSf6SEDG4vB/McAGQupCkMt2jeHK0IEywziJSe26cIsX6r8ionuU4V/Hzmu+iM1dIsk7u3Lf11UZA9GDRXAZFMLfY+pPbF7r/Axl1K3EC3HLbzQXeePBcLPDZZAS27X1S1J0jOtvHyVDzKc+N9eBeuDX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745485304; c=relaxed/simple;
	bh=qbEB7+dVnsSNeBPy+8XESndKwKNmoQ/OP7v7yajbn5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3pcQaYBXUOmOIV730dyC7sdxXMqe4tqtFy6o4iAl4M+PX6yJyAVl5XYH3CPIoVosFBR+I44L5QHLt5bNh4imlHPfnrOGCv0nA80YZAs5luRsOCBZ7CiciwpbNJifjB7+UmNYThlJp7k0VhbabkQGch8POxS0XE0qF2ZdANty0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=GcULBEnb; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=jdg+g/c+; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NN8tGn023631;
	Thu, 24 Apr 2025 02:01:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=GtUb5DZ5cUE95z9WsHxlRSM8HGRD+uOqkMOSW1Oeqew=; b=GcULBEnbckJQ
	ozdPs+f8dybBFQNZ1Qn6iZ7OpC4CDmPD5OjJSfk3HENjsxCuFp4B/+M8mtH46em4
	1Y9JTImRS7TQvdbIhQJ29fhoX0V2zx6mRtUv63iPvPcVLYgWUtzbe437rrb3me8a
	2NohcDismA+4e7K/otcz43ioEO1AMCrhdKyZY5jTax/yCIv+Mrrnli0RzaEBCyZG
	/RAelcy8eY+4qIiM1z460MhiKc3XDtm6Nj3kLXDtFpHPV+MPln2ir8Tms8a2eN4e
	ZA5b5XqdDIkGmVNjyiDDV9JQ+vbMvf03n74e/tdPeWKqybUt7/AdtDDWRu3S1nUk
	RD98XUNhug==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010002.outbound.protection.outlook.com [40.93.13.2])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 466jjyputy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 02:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBBVW5PmS7n0bD+lb6JU1RSS2Fu9MGu94AGjnOhBTy9XucAHAp6N+XBtIeVdJztWBjEePRAr1YunTdbYGC03EUuQeXXvcAe8v8tozGsszJA2ughdEyvSBRkKID5h03Qd1DHrWXQzRKav9F2mVuDcQu53rYOuKCv55q3RQr9Z12cnZtcB6j+uYoKip6NYfRHVDXQ1aq9PmDsx7I/nH5o4Bt42UzILrWRxNmFq2Iw61x0wXwUootwgB75+YKi2tDDByWZYN9xUofh6/Xhmdxb/8fZvJBu3KJ2MnTyOH99uaASRpzEN9WNePwLt3ekx4BAbRed3XxrEVO9YLVpVT69dFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtUb5DZ5cUE95z9WsHxlRSM8HGRD+uOqkMOSW1Oeqew=;
 b=dkEAwqy3KyFeoTSVT5uqXv+A1No2+AuTgRsnhSY/MaRc35LlykUd60ioRguL3eZC6waP3pgjt3sxFqDlEI1jibRgOxFjRTtsSZHq4zSCS2yZ/S2dxtdwEveSPQGlj9W92DNSpMU2Oa2XVLg9nhRFHfy1IWE56cAPbWPPvgIXRcrXNoCr+TRZ8C6JxyO/D6zlT0OZhdxT0CkQfGo/tO5VMQact+K/zGtxKoy69iLA+3JQCr1crFBymgiYO+5zl7vKryZ5DONLZK88GLD3Q+TBy260Y7tneo4VFxVmdSzScrtgRUcNrdpt6wvmIGYBy8hNGa+eiNX4K2NXo4nsrwjbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtUb5DZ5cUE95z9WsHxlRSM8HGRD+uOqkMOSW1Oeqew=;
 b=jdg+g/c+/3apB3HJBaMAPSFRI7NXPFx6DRv6VkhH44eJfW40UbTMO0SrO/NW609KwfQgsueBwzYskUlgcckBDjN8fB/fG2gZ7KWZMfTdfqQlq3jc8KmJ3TgBMhrlA/6UZPHgEyzwUpsPmaQq8s/VslT80u17qKZATrTBnRIXZnY=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by LV3PR07MB10203.namprd07.prod.outlook.com (2603:10b6:408:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 09:01:31 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 09:01:31 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM
 version
Thread-Topic: [PATCH] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM
 version
Thread-Index: AQHbtEEvQ7zZtKOwf0+ZY/0fGIjH4LOxH2BwgAE2hQCAAC7PMA==
Date: Thu, 24 Apr 2025 09:01:31 +0000
Message-ID:
 <PH7PR07MB95384A1319F64B5DA9F04190DD852@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250423111535.3894417-1-pawell@cadence.com>
 <PH7PR07MB9538D15B4511A76BF9EE49DEDDBA2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <20250424060748.GA3601935@nchen-desktop>
In-Reply-To: <20250424060748.GA3601935@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|LV3PR07MB10203:EE_
x-ms-office365-filtering-correlation-id: 0e94bea6-7869-4231-6c2a-08dd830e9b64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KGowX3JkXwfNVmthze1tFFp9I9PTryMGTlfags7y3mZAAd9ySWXk0+qXIx8C?=
 =?us-ascii?Q?nVWWN03OPyaNKRVDTjx2QXfpJQFB/cUquKmqcmoKx1FBMc/OtSQO+PLlOSQv?=
 =?us-ascii?Q?3uwMyDVodPoNWKRZhc2epKB0d3ZtsnoD3FM/WzzN300KR2e1MZ53O2xlREz+?=
 =?us-ascii?Q?wUc1Zf6MLBIUqWKPMQPuvWAskoRwlWRS5pof11wxaHpF7UL/Ky9m/4E47or5?=
 =?us-ascii?Q?A++VRMY4nxasOq35uDKLp3U5TnE2r7xgQBUex2G0mh9AQ8Q0oyC96ikVvuIe?=
 =?us-ascii?Q?fMxcGh1rwRXMO6hSG14GsacCYvKFtaT8ZAAr77B3EVPVpHiUMblCTXBJ1IhS?=
 =?us-ascii?Q?l+zyzIlidZEBNeYCAMVln4aAVlAZFA0xPSrOisBoPxlfo5806x/Isbseq7xj?=
 =?us-ascii?Q?EDdNJ3w6p0lK1Cv/5oAak64u+6X2Ix7/+mqM1jcL3XEuBPE/GWU/OVGnAwXW?=
 =?us-ascii?Q?+DDj51cyNmmrxoANeKn0K5zHvmebPTC2ivXCAScQbW+g8IPrLr1cIRiFQO0E?=
 =?us-ascii?Q?awGNIbwfzHKxaZmEL4s7O5HPPF/uscTXmaR7ILafbqAu2MbO1852TrC/f80O?=
 =?us-ascii?Q?zz94xoqoAwH9d8VEp1N6T8OvEhe+WXYYzImmGj93/TPI1CapUue4eafRsVpV?=
 =?us-ascii?Q?tDu24iQyjNynw3UL25Gw+YlOaOv3Q049lWYpjouCjiZw8nV+5nejOKo1m50+?=
 =?us-ascii?Q?09kMiYmSf/xExGgIgxklE6lUvs9A6IFZjaGAgZ5UsqiAVAgWWKstgKFaFIrR?=
 =?us-ascii?Q?fxGdw5v1THewyHEvw6WI1hOeRLVaPuoazoa+N2iFoJ10TtVEAn4ZO1aHQSBw?=
 =?us-ascii?Q?4BuyIEiF3mGHxBpD9EBf4RlUs04SmWq2tlhDA0Z20qixSgg939xis8jhPa/G?=
 =?us-ascii?Q?W+f3Jh9+Yb+FpEYlL2XDxpPjs4jyhSvhQj2C+CVsFeKdwvVwVxb5cuHje/9y?=
 =?us-ascii?Q?TnhdWiHlamtMhkN9t4Xx/Bi90Xch3Cg+KE3G4qVFZfNvJBKjwMPCZo/KvhEI?=
 =?us-ascii?Q?NpW156VNNVr7qOrV4S8/h+RYJlnuOodwex2kAXkkiCVvb+SkUBhhbuzNll8+?=
 =?us-ascii?Q?Rvtd/pQZlkrpTY9HDyTpWUVnFmRYe2maULJulh/Sm3caN7bGe70VhX7ax9ng?=
 =?us-ascii?Q?mSm8PKI0Ujufv75hySyyOzlP5jSK2asHNRn4gXax6QZLL/jwdSp1cmm82zZT?=
 =?us-ascii?Q?3Ch78dIuSsMbBazsfu61TCTVcpZ0QZDKeUTm8QshruLfKY9piLoJbkTSuUjI?=
 =?us-ascii?Q?iy1WNRAoggVa+vZ14/l6SPtGuqtSP8GY6LimWV/T1RBnLAyynZihOZdiPdzZ?=
 =?us-ascii?Q?kzDXN26Fm0FGwoBfbkda3tWfN9dndcwjanLZiDMykrPPhwMb5Nm6yB0VGEVa?=
 =?us-ascii?Q?5Tm00PZQk2TXCwG6CdMtj4IhTuSfhI9SMRnAz9P1fXLFZLaMW0H8/zjpK+Zb?=
 =?us-ascii?Q?OB1ZTMbtH+aVeKc5tspQM2BKLu4Q1eQ++sFAF28f/bmzrV1wFtPNwPDJhq6D?=
 =?us-ascii?Q?3CFu3adQTZIbVZ8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fnKB4l2QDEExYEf0Jz0Z5nBSDkyZQgO24Amm6ic91zkyyaKHpPWCM0xdcs+r?=
 =?us-ascii?Q?F4Cdj5PI5PRsWO0bcUl1YmkJ1oiyzn/916nKFblFwW/THoozB3wztjIRqe0p?=
 =?us-ascii?Q?pHb1t1fv7CQBeHkNZY7ydw1bXrEYVA+habluXL716Xw6rigWMSof6Vivz64w?=
 =?us-ascii?Q?KSEj3wc5DCac8ZWoXYIy/SSMM2OzoSY3pbJHCigmAdeHT9HSdZ/PxGVOrXym?=
 =?us-ascii?Q?8Ls/drGeA03i5w2v6NYx0X6A0tzCM7Vo3FTAXVxEnB/300LPDUGiG4R/Dom8?=
 =?us-ascii?Q?KTcrebC6vFW4QR6pw8sSzF3aq3roTZH96Z/pQ7Ui711JfsR5IKOIwQYxvegB?=
 =?us-ascii?Q?eL5NMObW5AwILCcJim5eQhmmeppV0dhdjCPTAOT7kHU9uA9qfnwsUOmffW5E?=
 =?us-ascii?Q?AlTybKYT8wdhzwMb5TCRfUuQbXCJd+nJe9G2Na6rCXhCgG10QfvZoXW39uJ7?=
 =?us-ascii?Q?tynN09x+bm68U86vVXyu3KOVreePl4dCIKt82qLokPz/NjKEpQxmZ1IseJeQ?=
 =?us-ascii?Q?xhJrZFGnCbhEuSMnzxtgP7k6DdiBo6S6kDmOCtMDQUOPBwTFtxced9d9Lf8A?=
 =?us-ascii?Q?uXPCvyu/B8WuBPMajNI2I3TNMWpaEOWUk88ygThAqhuWXQ/dMHFhJwIUEJ4Q?=
 =?us-ascii?Q?8sHlSXh499bipfm0Z7aet7gaDlf/2g3q19BN0HTcM9u/2qTSMif4/tqVl7Wg?=
 =?us-ascii?Q?aot/yiYaJvhP/FYfj3qylOBlp8d/nXJHAemygIfRCZWX48pEbSQsiSYGDyqN?=
 =?us-ascii?Q?uof6FVckaVMKS1lKSqxek8h16Mf9GmKz6QCUkZOv5cDT+m+2TSl+OVzZU++q?=
 =?us-ascii?Q?T2vC3kWC23ufOI5c5FycWLlxHR0hWBcZt1yuo/qfWjPHUSkESjSLDCvIyFTJ?=
 =?us-ascii?Q?238oh5EzWI3+9zURWH9A7VXRctK0q6WKdZdNKh7GZUV23aoV1CTcsYkd6iTh?=
 =?us-ascii?Q?lpr5k79wdk089pZvrX1m18qGD3uZrGa9DKO2mibujc4icGtsMjR5l0UGx9hc?=
 =?us-ascii?Q?ynW3pYnlbiIji86vlXTk2y97NH8i8yi56uF8Dxf/89i+OKJiFiiXPwDDg8Lj?=
 =?us-ascii?Q?5k4IIJhWlf2c6sfLSxj3jNw0tBFkkM+oAxOJMoczFmEfY0Kq2ABvPAYlnID/?=
 =?us-ascii?Q?VMLo/eUAFcXwFLEzEOo6fA651YdbBlUOB91yR4G5P7oI7mm8EG5K1kCroMDc?=
 =?us-ascii?Q?Q3G6B4vPbTuZ1WMvA0QSALC7pwqEzN/Xs2AbmBZa3inARNi604wf/aYi3DdK?=
 =?us-ascii?Q?Cp4WyYSb/mOD3Q5ezrTHJtAcUF5wuuMTzQpOckiJKq2NoxuxPZkcOOpn/Ula?=
 =?us-ascii?Q?/RZuFkfSzg3wWkIdnP1HcmDkISdvrqcfmVkz6I+BpVrNLv6ww2c/ohc8RMP+?=
 =?us-ascii?Q?EAeHCWFQ+ooRGdqQsAkaC0qygvkI8E38fqXlsGcEVMo1lDhiZKlnNnojLm2R?=
 =?us-ascii?Q?piVZ+cDr90iFfscXcNV6zbybGEFL4xu4n2JzBDaV8AkI9RhEDUS97yhL/8Wl?=
 =?us-ascii?Q?/Dv487bVUJIvvoU8I6nXzsv/PoQnwq7zSIjW2EKtCLdNXrniQiT7/mva3TEj?=
 =?us-ascii?Q?qwAjwDNZBam53ezv+SzZE4ezqqr5HeZHqmHR/Dm6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e94bea6-7869-4231-6c2a-08dd830e9b64
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 09:01:31.5908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfLkqQdJl5xXADXEpvMmkqoZmSG2a/fN/NBH92tx9+B2xThp8uyTNzQf6W3W8J6JvKMWSbQAfE8bEcvoT1XqIW9MyLtwuR4FXQw73bD66Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR07MB10203
X-Proofpoint-ORIG-GUID: z6mobcjSpeR1J7xGX2v7Sd4H5lBVDW0v
X-Authority-Analysis: v=2.4 cv=bIoWIO+Z c=1 sm=1 tr=0 ts=6809fdee cx=c_pps a=rknZK0v7KRh+kGA6vhtu4g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=HiE-jvSBEvqQPKlQqbAA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA1OSBTYWx0ZWRfXzOU/4jdNpvX+ h7hcv1SHtv/EBCJrjIMB4Ir/ObBOroinAb3PX6m1mT5QypA13/bghlY96iJRxFj/coL9D9dmXHe FDHmrIjrBIh61I3twRehrtiyLa4LUuczh0qD4OXjfK1kIQyzeI1C6SvVWlE/XQn2SKbVHfTgbQK
 +NZwrZpIpp72bW1giSbU3bGYGKtGJ7WxS91GlLdij6gJD5AhKbuG6pbL5kNeqxGWxTTBxbbp6Ca vW6BwsD1trwzzTIcHn8riQBDhMaOTxzduBybh8EFs7z66hox2rXSlS2crLEq/O9zCvY/rcQib2L WkeQCD17AVSA8yarSN7wMHDFMX+uYQqX3C5KT/eTMSsyw7tVlit0HFW+GShiMOeq0XKCgvVWVEi
 2dpr8zeQgHxMzH2Xl7y24V5bwQ5L4cuo7SsdISuB2p6MZVtYor4PHUZGyaDv3o0F4Sp6RFFr
X-Proofpoint-GUID: z6mobcjSpeR1J7xGX2v7Sd4H5lBVDW0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_04,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2504240059

>
>On 25-04-23 11:43:03, Pawel Laszczak wrote:
>> The controllers with rtl version greeter than
>less than?
>
>> RTL_REVISION_NEW_LPM (0x00002700) has bug which causes that controller
>> doesn't resume from L1 state. It happens if after receiving LPM packet
>> controller starts transitioning to L1 and in this moment the driver
>> force resuming by write operation to PORTSC.PLS.
>> It's corner case and happens when write operation to PORTSC occurs
>> during device delay before transitioning to L1 after transmitting ACK
>> time (TL1TokenRetry).
>>
>> Forcing transition from L1->L0 by driver for revision greeter than
>
>%s/greeter/larger
>
>> RTL_REVISION_NEW_LPM is not needed, so driver can simply fix this
>> issue through block call of cdnsp_force_l0_go function.
>>
>> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence
>> USBSSP DRD Driver")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/cdns3/cdnsp-gadget.c | 2 ++
>> drivers/usb/cdns3/cdnsp-gadget.h | 3 +++
>>  drivers/usb/cdns3/cdnsp-ring.c   | 3 ++-
>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.c
>> b/drivers/usb/cdns3/cdnsp-gadget.c
>> index 7f5534db2086..4824a10df07e 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.c
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.c
>> @@ -1793,6 +1793,8 @@ static void cdnsp_get_rev_cap(struct cdnsp_device
>*pdev)
>>  	reg +=3D cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
>>  	pdev->rev_cap  =3D reg;
>>
>> +	pdev->rtl_revision =3D readl(&pdev->rev_cap->rtl_revision);
>> +
>>  	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
>>  		 readl(&pdev->rev_cap->ctrl_revision),
>>  		 readl(&pdev->rev_cap->rtl_revision),
>> diff --git a/drivers/usb/cdns3/cdnsp-gadget.h
>> b/drivers/usb/cdns3/cdnsp-gadget.h
>> index 87ac0cd113e7..fa02f861217f 100644
>> --- a/drivers/usb/cdns3/cdnsp-gadget.h
>> +++ b/drivers/usb/cdns3/cdnsp-gadget.h
>> @@ -1360,6 +1360,7 @@ struct cdnsp_port {
>>   * @rev_cap: Controller Capabilities Registers.
>>   * @hcs_params1: Cached register copies of read-only HCSPARAMS1
>>   * @hcc_params: Cached register copies of read-only HCCPARAMS1
>> + * @rtl_revision: Cached controller rtl revision.
>>   * @setup: Temporary buffer for setup packet.
>>   * @ep0_preq: Internal allocated request used during enumeration.
>>   * @ep0_stage: ep0 stage during enumeration process.
>> @@ -1414,6 +1415,8 @@ struct cdnsp_device {
>>  	__u32 hcs_params1;
>>  	__u32 hcs_params3;
>>  	__u32 hcc_params;
>> +	#define RTL_REVISION_NEW_LPM 0x00002701
>
>0x2700?
>
>> +	__u32 rtl_revision;
>>  	/* Lock used in interrupt thread context. */
>>  	spinlock_t lock;
>>  	struct usb_ctrlrequest setup;
>> diff --git a/drivers/usb/cdns3/cdnsp-ring.c
>> b/drivers/usb/cdns3/cdnsp-ring.c index 46852529499d..fd06cb85c4ea
>> 100644
>> --- a/drivers/usb/cdns3/cdnsp-ring.c
>> +++ b/drivers/usb/cdns3/cdnsp-ring.c
>> @@ -308,7 +308,8 @@ static bool cdnsp_ring_ep_doorbell(struct
>> cdnsp_device *pdev,
>>
>>  	writel(db_value, reg_addr);
>>
>> -	cdnsp_force_l0_go(pdev);
>> +	if (pdev->rtl_revision < RTL_REVISION_NEW_LPM)
>> +		cdnsp_force_l0_go(pdev);
>
>Pawel, it may not solve all issues for controllers which RTL version is le=
ss than
>0x2700, do you have any other patches for it?

At this moment, it's the last patch for LPM issues which we was able to
debug and make fix in driver.=20

Thanks,
Pawel

>
>--
>
>Best regards,
>Peter

