Return-Path: <stable+bounces-111914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467F5A24B82
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 20:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E830D3A5200
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 19:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186857C93;
	Sat,  1 Feb 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="DbDoJ2k8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379092F5E;
	Sat,  1 Feb 2025 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738436973; cv=fail; b=QioGjnqtC6ma7gutQuhREk4R2J0grr4b5XEMFkmc6tV/3lRwi3oTDy31zrryBesHmT0koytXWtcZfKz/2CQ5LUTeR3VvD7LTQDWM0FjTJhw+F4QZjixu3Z5NQjpMwMYnYG4pbsCfIQjRVAz/6fDoGjzwz25XPrre0Eht1xSRe8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738436973; c=relaxed/simple;
	bh=nqWc8vYaj19yhR53JKMbKBDO7zVSxyE8kX/BeexEv1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKDwqeaA7A/9XCjhFbyik2vuKGI4TcBT711RIqMJ/afo6QvqPKP6Xd2zFEElfwN9aCyz5Jv+35rezakSUKVLZ1WrHexWBbnqwIUJdzBqLMuOaHzjg3/Ggod1L/E5hiKtmyqqAcUD7hkvI7DMZWUZdXfjHVq+PoipXEM1D4Wn/Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=DbDoJ2k8; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 511FjjgL017218;
	Sat, 1 Feb 2025 19:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=nqWc8vYaj19yhR53JKMbKBDO7zVSxyE8kX/BeexEv1w=; b=DbDoJ2k8PafA
	7h2viacrqTkRsF2nLPmdRSR+YkCAUsXl9+9y9eqembxBACsXfm7n6mfsJ9Z+sYlg
	NTr/u72nX0X8Hc3N40kpFaUby69WgHxRD6e1ioZjjjATnNefvpw89vcGRbth3wDk
	SoPxzTl/VrFImuuZrIAcbW0pEw88yZ2kKtM2maSZAmaJlRaxqq2I04VDtmjLUmI9
	kv6UGO4UTfaHuKoMieHShuKzxdBRWWTu5S8w1Eb2UWzeHD2buWzU4PAGKUjyQdaE
	RI2cChc7T7BMmuFLRYKZMAqN+2ahwpnzvuWY/yY0UK71++AxNmsmkg4lhOGqAqTB
	7PONSEdfJg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44hd7du3vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 19:09:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/oHcLA5xD0hQi1+0y3H3BjTV/XTzn+S+h+/DA96RuEKF0jVTjbYkTV9KPYXJwoUmdihhGBkzdce5/nDIjWdPQFHFudl+GRqc6puqD0ZCLr6qRGfYLl3NYjQRU3jiNbLUvqmj56sqChDPFGaSeIiWYHnbRhoLEP8s8IP7+vWbQFZelTn6wrLj6T34Dp8emsAueYcfmsmeiEuZaaBjRHxLkQVoswucBHQBeqrK60lzyfzCtqHriiVhLWQiYzLKi3Kify6aiI1HnUCdSoNSxH0XwgPFNafdAPWlhli+lQiUBNS0p44+2/qLTm9LOgkD/VB/OdT7k4jcs12JqQRVgWaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqWc8vYaj19yhR53JKMbKBDO7zVSxyE8kX/BeexEv1w=;
 b=AbAw2JvrcoDphiyMntlrn5jF6JO8I51zpcr1c9Wn97Xr2QchYohXkht5IVQQpHA6QMfcet/FCx6goC+IHFqmv5Obk/Uk41QudZgQPAPG8WvKp/0k0Ho5I7bMJPd2kYmYJwEjEww1DNPUXujdQ3REPmi9xLgfNLSV798eNQstp/4U8I26fdou7N8AJDyaoZqeCTcntebFbLHvWrEdagDfD4K+au/GnewEp4JZlc+qEul/HCHCms2ZGLa6M/tuA9/zKS0FR6sO8v/RT+wKpaCeclbPf4X7q9G0L2UgssgN7rW0uFiKC3NGkRYhDo1dTjsFivIq2Eqv6RtkLrILPAzrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17)
 by IA0PR11MB7284.namprd11.prod.outlook.com (2603:10b6:208:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Sat, 1 Feb
 2025 19:09:21 +0000
Received: from DS0PR11MB7768.namprd11.prod.outlook.com
 ([fe80::3232:c728:db3c:3211]) by DS0PR11MB7768.namprd11.prod.outlook.com
 ([fe80::3232:c728:db3c:3211%5]) with mapi id 15.20.8398.021; Sat, 1 Feb 2025
 19:09:21 +0000
From: "Ahmed, Shehab Sarar" <shehaba2@illinois.edu>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: TCP Fast Retransmission Issue
Thread-Topic: TCP Fast Retransmission Issue
Thread-Index: AQHbdNmMOPBwnc+jzUGeEqbVDLvXU7Myz9WD
Date: Sat, 1 Feb 2025 19:09:21 +0000
Message-ID:
 <DS0PR11MB7768A5B80C9BF2366CFEC89BFDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
References:
 <DS0PR11MB77682EBD149E7965F1D8E8F1FDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
In-Reply-To:
 <DS0PR11MB77682EBD149E7965F1D8E8F1FDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7768:EE_|IA0PR11MB7284:EE_
x-ms-office365-filtering-correlation-id: 2bf5f45f-c4ae-4282-12b6-08dd42f3ef56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Wy7vbCY158HNvvDNR5peY0ri6jl3xTYeH+Vv571CK92oeUSMWu0Q7c4W/7Hq?=
 =?us-ascii?Q?0AReLU5qzkMmyLo4uc+uxLwx/Qkbd6TH4c2Pc1rEnfGd0znzY1Fd4QHzqY/b?=
 =?us-ascii?Q?NN0D0zoLQ+6d3Ya85mNo6NPGUKTty6muq6PR/QMKdTVggLJEUOcgpuzqOL2N?=
 =?us-ascii?Q?b0eUAmigsGdSsnpW21sENwSTJHStYY0AybwVmiPjLfMC5as77MmPEphKujSm?=
 =?us-ascii?Q?5zhlQrXVGPBNWqETrqe90vgmnSn9WautMVLUPaMcbZ7l4FH+M24sII/yvZNf?=
 =?us-ascii?Q?s54WDb36q8DuOOhXoqUdWr67Rxapn4i9KjhFOADxkYAPXKTZb4oJjFvm/V4+?=
 =?us-ascii?Q?FVbvE9smtW3V+ArS+UBrKrEtalK9Qv63BEdiVQthIbK/M4e/kIpHf3w09/6g?=
 =?us-ascii?Q?JTbyRcSU1oti0GhEempn2iR7/1DqUGgzpGJsihX3+JUEGnV9ZuHAOGrn8npD?=
 =?us-ascii?Q?tY7HCWL27ZgnKinFEZeB37DdxFdXw1oFxhmKo2vJrVTm35HCrLeRh1DIVm5+?=
 =?us-ascii?Q?qIDocHswpi5PAGWJAfF5MibgRqOWuI82GjCrxD3ydyIC0FiFz9MiWVkPKSxi?=
 =?us-ascii?Q?cxADyBfulWIilna38iOxp7/9Hg9Qzwup2TKdJQNbfSP5iNiTJoGph1ctuTH5?=
 =?us-ascii?Q?Buw6S0ASQJtclq8YmLteR18wCwQPHSMMScWYASRSxPfq+2SbNceTyPcIx5BK?=
 =?us-ascii?Q?Lg/iTWq5Nqho1Yknp59F+G3oTIPw0u/hAN3Gb2AvWcryGQnEkEbzAqOlCXtX?=
 =?us-ascii?Q?ll0BYs+56SvGAv6YTmVW9IhHpNHH+d5mmdh+XBb50X6eMuTOfLwCDTdVnVrZ?=
 =?us-ascii?Q?/Pclox8sQ88MONujuRdosU2Dk3/uoI4TpzHSWo4zrHLFGEGV62GpBWjdZEAp?=
 =?us-ascii?Q?R9vuQNR1uvkt/6cARYcOLzMT/4cO+9Phtc6PbD3lcIUNZxIvVFJ5khAIdjUI?=
 =?us-ascii?Q?d/sVxhIEYI/Ak6AMsdqJeU1a4kh/GJm5o5SuI5Zq1sP9MqapmeE+USzao3sK?=
 =?us-ascii?Q?xP5UKuQRkwze350fJs8kL6hpFXuVlhrQTHgrslnpSFI9vC/6uKECgAIt/Qvj?=
 =?us-ascii?Q?cofing2SXSkbMEUqUZVj4dglENbP1Pu9hWJ+3KUiWCNXsWIMMHKtoREXIGZD?=
 =?us-ascii?Q?CMVW97uQ+02RB9plgkok56GlBRpeR+qIZmDjVXd20Cflspl9vaHXpFfZbzD4?=
 =?us-ascii?Q?A/xcboIx9NXpoMZ0tuysT7o1MkJbbHqFQPTR2/SzP1SCSX7vMMRFZcQrdZYz?=
 =?us-ascii?Q?/VJ/UYR45dDqguRsZELRS2IvFdrpZv3gItF3aoF1w6COaXFwSzDoibLN/eqZ?=
 =?us-ascii?Q?mBVZxe9TG9owpclRf5uoovu5Z5C0sqTlOEmNrJz5ZXUxc1HYp8Xz82iWTrZm?=
 =?us-ascii?Q?d9S5RbTpDW9vQYzNpYuzDDDNjrakFrU37KDNavo/DkG1gZMNi07iT3ActTXn?=
 =?us-ascii?Q?sY6tvJg46M8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4UQWDT5eMHqxapQHdZ6YA7fhDCiqKaHRjiD3SQa4y39X9782yNcNj50RccGu?=
 =?us-ascii?Q?EKBWTvg8pXn/n3Vc8xE9bxW9GXFBiI9Np2Nz9JDAd1cx/8yHohd+tO8GYCVz?=
 =?us-ascii?Q?vyN+WoN7EFYJ3McQeXTQ8YVj3olsMBmpngUj9LKP4nodcQEcaZDIUaJ6t1h2?=
 =?us-ascii?Q?nmJGIayXgH3CzFmCcke6SPmtzOcw1ElZvowcpbqN0WRJiXXHGV7o5nOS0OCu?=
 =?us-ascii?Q?H8v3ttfd+vjhHcO72NZVf42nFG3io3mHEv21c8IQJp9NQy4vHwK/vq+uzSxg?=
 =?us-ascii?Q?+1C/7AfbvW2MfWdLpMU8SC0r4SucIHgvSwLZMz3mVddaX5slP6ItBbD+Bdsc?=
 =?us-ascii?Q?gt9kSUtMQNIfD+P2o0tL0bOhoceQtnsvL/oFiOaEa+G+8F7Peq36OZv0YCWc?=
 =?us-ascii?Q?fC+UNQv7vIxlunnmOcZyhT7Bnzob346Asn19Jf6HRW6dhz8g/LUO99WXlosy?=
 =?us-ascii?Q?TcWqN9GwhqO0CMlWtg10GiEPeZYKYiWr5N4IJmeNBCf2fsG+w/DHO3VvcaOJ?=
 =?us-ascii?Q?s76AtDbwYZ41+jBIcBXRwvdpH+6wCxW0OSc97yEcQSKIeGCBZBwe6i7RdXYL?=
 =?us-ascii?Q?ZQLsoBO7r8SlDwnM36ryzS+rRi2nD29WEd7Q4nlI30ChHHeqnE3GkZOxDHCk?=
 =?us-ascii?Q?rTuXWF0r2nPp0jObX3+/io1HGArvclEFMJECfAD8l5GJZYiQeVYvA7a9eaco?=
 =?us-ascii?Q?6EEtg/yvQ1i2z00P1f0q4UebpYZBkEY5VBJCtvNE63sPw73Oc1wso3UshYDO?=
 =?us-ascii?Q?d4FFOg0aOotynxohuzPV/7veAPAopIzwNGPnM8fzBHp4jrHxcYwGXQHNond1?=
 =?us-ascii?Q?TiFZDpWusJHo7ABag/rnjD2FMpSq99G24zT8S3oaH8oWtEJKfjnLC/aihH8D?=
 =?us-ascii?Q?3x7f9Ssnpc9uwsZPvLqfgEAyAZlPyxlOd5uKH43UiGZDLqpoqT9BWyiV3r0f?=
 =?us-ascii?Q?FI3SdBfEpIm6tGqGnwdQfHku0xgdEjqrfF4+4VjYWqBzLsZlnXDCKVBTgAD5?=
 =?us-ascii?Q?Zv+xJ1se1A8hVLkeX1csyqFcsChnU32I9kcDa6hmMnCE3LjQBH4iKrVlz9DM?=
 =?us-ascii?Q?Rslo5sxDDMFy48Q+m9GLdkfuyHEL/UdqzbuWV5js5LcYfUp46Zc0m0IEACUs?=
 =?us-ascii?Q?alLcWnVXrk16jXFThhhmMM0Fiy1bbHV4G46Go9W0AFR6qvrPQukFugDoJ+2A?=
 =?us-ascii?Q?SRMCAaJZgC89HeoicDNdw7eY2jFGH/MIvVMJOMOWHYJ97k0hGJbjWmewgs20?=
 =?us-ascii?Q?4HBPZhF11cdaCsTxTYIFmRq2HgKNs72rQO9tEM+yO/BexlLUBMjsrQIskTX1?=
 =?us-ascii?Q?xuf/hEB2qRsez1Gloqk1GVpixWa/jr/EnNJdvDsctLEMXb/TQjwKYXM4vAQH?=
 =?us-ascii?Q?yU+ncP7TmtMa5txWqxx2VA+e03tA2c5gwInvodPZpIxmvaMFdb8+ffgXx+m4?=
 =?us-ascii?Q?HTKJ6aUzq8ACQLq0mdu4Afzst3KN94ipbU2Pt0j4kaLWGCmXrqFBNf6ITIkn?=
 =?us-ascii?Q?HAPu+TGxfP4HXdlkOT62TvoEdUz4iffNVXGplVbiRzLR1Rbpp4xWHhylemBX?=
 =?us-ascii?Q?tWGzsYtPVao5LXurBLzRHE8YTBHfk5QT0vmfoBPm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf5f45f-c4ae-4282-12b6-08dd42f3ef56
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2025 19:09:21.6047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LTBBNmyke53o+ZfkqgDTnVjWLRbWFfh4EOL6ImKB45pLOSc2M6fQqFPfhxdNYkjqYR0Kf2BlecwdSLUvc18pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7284
X-Proofpoint-GUID: -Y7z6B38NIrK39UgAsf0qtBke6BIaBQM
X-Proofpoint-ORIG-GUID: -Y7z6B38NIrK39UgAsf0qtBke6BIaBQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502010167
X-Spam-Score: 0
X-Spam-OrigSender: shehaba2@illinois.edu
X-Spam-Bar: 

Hello,

While experimenting with bbr protocol, I manipulated the network conditions=
 by maintaining a high RTT for about one second before abruptly reducing it=
. Some packets sent during the high RTT phase experienced long delays in re=
aching the destination, while later packets, benefiting from the lower RTT,=
 arrived earlier. This out-of-order arrival triggered the receiver to gener=
ate duplicate acknowledgments (dup ACKs). Due to the low RTT, these dup ACK=
s quickly reached the sender. Upon receiving three dup ACKs, the sender ini=
tiated a fast retransmission for an earlier packet that was not lost but wa=
s simply taking longer to arrive. Interestingly, despite the fast-retransmi=
tted packet experienced a lower RTT, the original delayed packet still arri=
ved first. When the receiver received this packet, it sent an ACK for the n=
ext packet in sequence. However, upon later receiving the fast-retransmitte=
d packet, an issue arose in its logic for updating the acknowledgment numbe=
r. As a result, even after the next expected packet was received, the ackno=
wledgment number was not updated correctly. The receiver continued sending =
dup ACKs, ultimately forcing bbr into the retransmission timeout (RTO) phas=
e.

I generated this issue in linux kernel version 5.15.0-117-generic with Ubun=
tu 20.04. I attempted to confirm whether the issue persists with the latest=
 Linux kernel. However, I discovered that the behavior of bbr has changed i=
n the most recent kernel version, where it now sends chunks of packets inst=
ead of sending them one by one over time. As a result, I was unable to repr=
oduce the specific sequence of events that triggered the bug we identified.=
 Consequently, I could not confirm whether the bug still exists in the late=
st kernel.

I believe that the issue (if still exists) will have to be resolved in the =
location net/ipv4/tcp_input.c or something like that. There are so many aut=
hors here that I do not know who to CC here. So, sending this email to you.=
 Sorry if this is not the best way to report this issue.

Thanks
Shehab

________________________________________
From: Ahmed, Shehab Sarar
Sent: Saturday, February 1, 2025 1:01 PM
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
Subject: TCP Fast Retransmission Issue

Hello,

While experimenting with bbr protocol, I manipulated the network conditions=
 by maintaining a high RTT for about one second before abruptly reducing it=
. Some packets sent during the high RTT phase experienced long delays in re=
aching the destination, while later packets, benefiting from the lower RTT,=
 arrived earlier. This out-of-order arrival triggered the receiver to gener=
ate duplicate acknowledgments (dup ACKs). Due to the low RTT, these dup ACK=
s quickly reached the sender. Upon receiving three dup ACKs, the sender ini=
tiated a fast retransmission for an earlier packet that was not lost but wa=
s simply taking longer to arrive. Interestingly, despite the fast-retransmi=
tted packet experienced a lower RTT, the original delayed packet still arri=
ved first. When the receiver received this packet, it sent an ACK for the n=
ext packet in sequence. However, upon later receiving the fast-retransmitte=
d packet, an issue arose in its logic for updating the acknowledgment numbe=
r. As a result, even after the next expected packet was received, the ackno=
wledgment number was not updated correctly. The receiver continued sending =
dup ACKs, ultimately forcing bbr into the retransmission timeout (RTO) phas=
e.

I generated this issue in linux kernel version 5.15.0-117-generic with Ubun=
tu 20.04. I attempted to confirm whether the issue persists with the latest=
 Linux kernel. However, I discovered that the behavior of bbr has changed i=
n the most recent kernel version, where it now sends chunks of packets inst=
ead of sending them one by one over time. As a result, I was unable to repr=
oduce the specific sequence of events that triggered the bug we identified.=
 Consequently, I could not confirm whether the bug still exists in the late=
st kernel.

I believe that the issue (if still exists) will have to be resolved in the =
location net/ipv4/tcp_input.c or something like that. There are so many aut=
hors here that I do not know who to CC here. So, sending this email to you.=
 Sorry if this is not the best way to report this issue.

Thanks
Shehab

