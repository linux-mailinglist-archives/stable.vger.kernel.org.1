Return-Path: <stable+bounces-111979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E6FA250DA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 01:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F451884AFA
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 00:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAF11367;
	Mon,  3 Feb 2025 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="qq1601FT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C990A31;
	Mon,  3 Feb 2025 00:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738541597; cv=fail; b=EzwBSZHH+FCfXMUdb+qzE09KL7uRPPcfT6gpJ2tlYq1D+pHQWwPC+49y/l7bAp57r7fGltlWyouEsVtvzg5dDwdoX/TbWsTrisLpRH1t/RzutYUmRpKs+HFDQH1Ne0BKF1qGmnw/Jy5lN6mqUWHOkZabE7wh3QbAyddtxFIelrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738541597; c=relaxed/simple;
	bh=CN2IA2zl59aMTSRLxiLeSkXqoH9WV+1i6+HGeVor48A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O08J0DXGfFM4vknX4cZUcyWokTph5avvVFIKR0zfNvSrfvckhJKS0o3bJG8u+ZVp9IGOIvysLhNhXMf2uPSI6IBZYUdB3rRU+WA9g3i7TfeTe3sWlGuQaVHpUVB0M6YGj5eK0ujYk7m2wTyN1IEtdffqB6WY+OCxYEhwpg2wM44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=qq1601FT; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272704.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51305eRp028852;
	Mon, 3 Feb 2025 00:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=CN2IA2zl59aMTSRLxiLeSkXqoH9WV+1i6+HGeVor48A=; b=qq1601FTssfk
	sv+y5xscHmAwQWzTTDPlM+mZLb1r0FyJ0kojtQob2AO45QxM4oR6OFEL4UAR4pMa
	ojMpefgXsFebGYp2i/AmFY7NddENiNvNJ/cUpWikfw4H08PUaPkc2gOu0i/qi3QK
	e9xi0+/1x5uY1bVCMS8uHUiy1sMI7TSj6cv/aJ4khFGWiGIKbvYUXLPi3xUbwrWT
	+ILDkegx2s8gKHJSRIiQl0TsHrhK6j3P+D6GXiQk+qkkrDa2BA60nC2r6eEmJcQj
	+P9U1dGWcMQjVNoBrSk2s9iu2XVRx+7agWEKgcTmsuCxO8iimQPKOcYSiKETpw3H
	fCQJWk5VtQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44jjy401px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 00:13:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slptAQthQx1WjYtg4XKdoyg3M7MRLKIij1eYPAJLaVnACNeIRttCLsUO8gmusbO8cKWjQEiOqLYuAvbheC9KQszGFI5tG7nlZ7fOW9lY8NpDyyF26saDSyhe0cJf+Xb/c4w4PuxdzMCKHId7xA3RhYkHuI6tdDzNZqy8uwD/sLkgm4rib2Z+9qLszOd9O8BuvSKM1ORObKXIlJKMKars8aYMffZdiEmvLmrumuYI6SjiviWTIsKQDiKjB/zuKyn2zbjoPw8u9kwfvZLWN2n7YgO1E16L393hb0ldgQDp843Rz5OtzlPyu+v9rb2OfWbuojSrkhUieX0kDSA7AukB0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN2IA2zl59aMTSRLxiLeSkXqoH9WV+1i6+HGeVor48A=;
 b=KmCQcmZlMlqWEPb2kGgIk2sGzvkQY6NYEWNRnqMFvcqPnj68mDzM5l73ur3K+O5prPnObrfcf5k/xGCtKuRWWhEiCHugOBTC1SIPD4s3TqAVy1FZpjZYtnXD2AYfW18tJ6/5nLehI4963/Ld/ejS9p+PKXY9VDCKxQsjnbpTeWaTu/tVA0OQ5mawS8FNwEGl82QQLO+rFT94GcPZiQ1OyvoR65U7l9baCW0P8HmaxSp8QvDlXI/9f8H/tR7/MajBWQ3com0ZCrvUxb7PqIiRhmQADzW2ne34PydHIIT0HYHytrFRxc8gZdjMKdClLto/RyHdhQX9/nolZQL2pbgE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7768.namprd11.prod.outlook.com (2603:10b6:8:138::17)
 by SA2PR11MB5210.namprd11.prod.outlook.com (2603:10b6:806:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 00:13:08 +0000
Received: from DS0PR11MB7768.namprd11.prod.outlook.com
 ([fe80::3232:c728:db3c:3211]) by DS0PR11MB7768.namprd11.prod.outlook.com
 ([fe80::3232:c728:db3c:3211%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 00:13:08 +0000
From: "Ahmed, Shehab Sarar" <shehaba2@illinois.edu>
To: Christian Heusel <christian@heusel.eu>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: TCP Fast Retransmission Issue
Thread-Topic: TCP Fast Retransmission Issue
Thread-Index: AQHbdNmMOPBwnc+jzUGeEqbVDLvXU7Myz9WDgADvdoCAAAAtgIAA8aFCgAAF6mo=
Date: Mon, 3 Feb 2025 00:13:08 +0000
Message-ID:
 <DS0PR11MB7768E5D66FF32A5703333EA4FDF52@DS0PR11MB7768.namprd11.prod.outlook.com>
References:
 <DS0PR11MB77682EBD149E7965F1D8E8F1FDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
 <DS0PR11MB7768A5B80C9BF2366CFEC89BFDEB2@DS0PR11MB7768.namprd11.prod.outlook.com>
 <f86dd0f6-6a2e-40f3-b0be-d9816ccb20cc@heusel.eu>
 <fa131e75-7398-4add-8665-333b92bb500b@heusel.eu>
 <DS0PR11MB7768CE00F0A4663EB0D7DF63FDEA2@DS0PR11MB7768.namprd11.prod.outlook.com>
In-Reply-To:
 <DS0PR11MB7768CE00F0A4663EB0D7DF63FDEA2@DS0PR11MB7768.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7768:EE_|SA2PR11MB5210:EE_
x-ms-office365-filtering-correlation-id: f77c5e34-0333-4a3d-01e8-08dd43e789ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XKF1DEeeZxf8aTNsEGJOhELZOtyi1nWweXiPxnXVWLVXcXK3QlxUUusInoDn?=
 =?us-ascii?Q?A+O91zTNM5U3r1BVi0DPZynjeh/FfyqwpgnQsjYk6dkKtMYHeI3kZscH3UT6?=
 =?us-ascii?Q?Tp62AGuKdpWZukyZYEy2RH7dFNgzUUkJ+PQvVT1wgMrp1nfZatk24hPKAW2Q?=
 =?us-ascii?Q?XDXlEVUCwehivF5OjIcLOTBDTAqQ6MqWQWGEsiqKe49x3yL7G2JCoZuHG9U8?=
 =?us-ascii?Q?kAgQFkNByIbZGnIhjp4fcmD2oUNQRSBy5QNHB82eJJiIadm4J9CH7GqYkl/R?=
 =?us-ascii?Q?/DHSFJ3yvJrqxJyBx5jSNvHZQBS46ueytHiOlyucJ7XJs/obwwXoTPCzwWtd?=
 =?us-ascii?Q?kOIF/WD6SWfFz8/RspeVV/52KsKTd1qQFusSpOkI3/QRwl0tDeaV8OwnFhVZ?=
 =?us-ascii?Q?4Vs/xdtrVAGnyGF6/23WW3DtTF72wIqVcTtUTrxmVmzRF/Bud3/8OdhwSQ6U?=
 =?us-ascii?Q?z9d/GEcb2hZ7s8C5Dbh7TZsfSyfbfldGN7sqStvqDD9rq4jhzMEFQKC31PWp?=
 =?us-ascii?Q?NQbWkpBHm5orHf5KrJ6H1ZKFJCuQKctB7uXxI6l3WFCsK82W/qVEAxpd8Wv9?=
 =?us-ascii?Q?Z/9zxgaNPTU+LnAH+D5hDW2l0Jmm4mEqBnE+6ddaL/L9nCUngt3BHKcG1YVw?=
 =?us-ascii?Q?eWpeBa/c4tWHzgUz/pnBLTZna+IUyIzTvc3XRVezp0t7wO9W/Nwg2ScgtTKs?=
 =?us-ascii?Q?IPqsCg3vxyfyLhUQPVvc4LonzwIcIVwIuDMJT+cB/lgNVwOMoceMQDl4guTT?=
 =?us-ascii?Q?aghKM/MigRq8npSWR/luAyKpvrSIcXrWbIhzNfItIUT2YulZZ8CohNvlRggQ?=
 =?us-ascii?Q?ygPU3VYGosMyFa3T5+6yR+QGBKeEQO+bTC+8Ac03578rBOdokJ2bkHhGq3rX?=
 =?us-ascii?Q?UbkLWL5NRH1bjJ+WiwOUlD7N6iikGqpnpEhWD6jIbm2QNM4hczqKJ5pKUapv?=
 =?us-ascii?Q?jR6nJItBw/WNaXNc+fqTumkvoa0qhgLRrKoIqNhndP+YlTHg6/eIBlVQLW1g?=
 =?us-ascii?Q?11s6fy5iC4BpGvZgiJip0sPtuwYXKDPWIwleF6VtFQLFVd4jaFBOV+NdmhlM?=
 =?us-ascii?Q?OsHBiYRge8SE5QAs/SE/j3Y3HVr6UlSQlOzyMpevE2TH9+E9E6dg0FZpnqts?=
 =?us-ascii?Q?o8g0asCruEA7Q9i6tGBAVZEMslplmQha+gDft2Vw5dHEm7eey3QOspmunofR?=
 =?us-ascii?Q?DlTrVQ0r/Gm2gr5O92zF71ok5Uxq5WNQ9UdFLvXE3q6sCU66ZMqvzpWg6nrS?=
 =?us-ascii?Q?ynh/FvKCQk2OUHr1FQUytfvmVxzudeHBbDwadCzDM97+USWJbF/PmE1wr90t?=
 =?us-ascii?Q?gbWT90Qnmz66QnCeiIVNUgK+CD9/cwNxHdl4WcmjmZyfXja/dSpX+EX8DP4T?=
 =?us-ascii?Q?wr7rQe4pKAKOKafZvy+QYxdfonQv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F7YWg3z6rOdOe+B5YuBlmeJQo/FcTKJ8meRA8CI2ln6RkEroT/BGlMAxCmzJ?=
 =?us-ascii?Q?EDlmIUpcDWbQVWC8jRVWiogWClNlpVvrDjpnvk61dm+GmFKlAnYvNdqrOs/6?=
 =?us-ascii?Q?Fuvjulex1n6jRLIGYQnrdz/O4yddG1i7JkpccdR9R6+LyEuXAKxTY0u8uF0y?=
 =?us-ascii?Q?MtWWyL4eCs/XJ2YBURZu8KkJ1BBXs764DRYT+N2m4Cn0bwArFoIoMuuHlp5n?=
 =?us-ascii?Q?4Ck3rjbrNvtiFJVr52Z8FH3JMvPPVEA0XC4bPf1cwuxEabaot20hccFGa/+V?=
 =?us-ascii?Q?mxOC7Nq0LW3uatD+ArLZl8ElOBBP8FTtPTQvRWpSiATF4QZF9w1DXsGJbpUL?=
 =?us-ascii?Q?vuyxqSBQYXeDysixlkOIwoWMOPjDmghNYqP+CSzU+36ESFQtl5U5rhpnE+Ov?=
 =?us-ascii?Q?RuTv3tro6sBCdEqlt8z5ePFgDc3vhNDF+yZ44WXsDkq288eEof9wj0FZtI8K?=
 =?us-ascii?Q?K1a+X/+ody+S/K+jYsy7quoFTp1IAjXpCU8rGyCkRyfSuJDPCOZvIt2ud9wo?=
 =?us-ascii?Q?PRsZAWl4POh8maDPATyx6KaNy+DRF82jIVUyISr9f+fO8dSxWdpy1+YyMyl0?=
 =?us-ascii?Q?JSdBnCSRRJTiWRT/KtyOYZ/SB55/qxtVDZiFIcqP5Xgk2fYtqMcO9atjN7qf?=
 =?us-ascii?Q?xMsUj205x18uL+BtVM4TTE6yUsH1AvYeOvG9Y36Y6fkRPSMkgAfC1fAtRx5H?=
 =?us-ascii?Q?m4KIsyCrbPU+lA96WFabrmCaSrpOc/swNPxFFkoIu55yz8A6l3omhvcKblvN?=
 =?us-ascii?Q?exLRuA9xryJ0Qs4to7Z82dGH/87JK3RLsX2aRnZwODNz3ryZ/BoJOI2x5CsW?=
 =?us-ascii?Q?1rl2dy1rF/kdpSzd02pFQMJlR70ufk6VkoUWx40IRkWi5FQUA1tvwyiqyilO?=
 =?us-ascii?Q?RxreUcc/ga2EOB7DIB2DXaMx7wldoFbO8aHSNT116ks4N0MNYZpl6IzDBrTL?=
 =?us-ascii?Q?MLx6pFUjA4OE03GBl1/HeIZFhAl/LEuT2vsGIKVxfjzYEmYSSEdnZnOu1kbK?=
 =?us-ascii?Q?6F6RgYsFFPf2dY4c1lPLz8jOju4yZTEdkoI9n4SHl0FCw9M8y/EVtWSoudzF?=
 =?us-ascii?Q?jw5vUISRJ7z2ncCtuNylsNZ4HHnY7cyhksK3pa8jUh1AaOixL9D3ujcL38OV?=
 =?us-ascii?Q?hxGGe5kyy9OHNESiIfKgPE75o0zFC5K32H8rYeZQMFD7e8r5SO7NlNzKSCe1?=
 =?us-ascii?Q?39T2ouey4+u0p2wllGdt5V+DV/Ls93NMu4foVaShYnqu9AQdXHEiPRInQ08V?=
 =?us-ascii?Q?cPSVB/RJXg08s1FBtyK6ZKXHSy9fFIo7q48kBSS79cyJYjbAE0j7jnTap1nz?=
 =?us-ascii?Q?IMi1rTDWnGZafrQd773ULps3ITGrwqoAbgW705kpWPUlR8ggj5bnHIwf90Rh?=
 =?us-ascii?Q?rYDD8bO2d1JSnF9POyLUb6KWVAbrYPbifByDLsh+vaXpSQcI9UVJ2aibDO4+?=
 =?us-ascii?Q?DPNxs1sRCLo4immPEPPpWzxQvsZ4yY6KmjpWNxln2gepv+qkzO162QVLO/xb?=
 =?us-ascii?Q?YRdjUS0M9D3u3SD9mubQBssQxYIHlvpFlQjcwMRYkoPwdbH8PIvd7JopJvi5?=
 =?us-ascii?Q?t+ERik2MEr5Q+zRddBd5DM+6edQkqrEsVW+CtL6r?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f77c5e34-0333-4a3d-01e8-08dd43e789ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 00:13:08.6273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NyeG/pXQ4VomicwxmzwFEbyTHOV7g0H8Z0d1/qXCxznyRMdsUSCOK1h4BDpOgnNSfk25dfqgPc6VbsTQMTyUxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
X-Proofpoint-ORIG-GUID: 8_OeqRRqERSCBhnASjkAklLNu6WZZpCA
X-Proofpoint-GUID: 8_OeqRRqERSCBhnASjkAklLNu6WZZpCA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-02_10,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 clxscore=1011
 mlxlogscore=999 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502020212
X-Spam-Score: 0
X-Spam-OrigSender: shehaba2@illinois.edu
X-Spam-Bar: 

Hello Christian,

It will cause problems for real applications if the specific event happens,=
 but that happens with a very low probability. It's more an issue that can =
be resolved at the author's convenience, but I would be comfortable if the =
issue I discovered is acknowledged at least, if not addressed.

Thanks
Shehab

________________________________________
From: Ahmed, Shehab Sarar <shehaba2@illinois.edu>
Sent: Sunday, February 2, 2025 6:10 PM
To: Christian Heusel
Cc: stable@vger.kernel.org; regressions@lists.linux.dev
Subject: Re: TCP Fast Retransmission Issue

Hello Christian,

It will cause problems for real applications if the specific event happens,=
 but that happens with a very low probability. It's more an issue that can =
be resolved at the author's convenience, but I would be comfortable if the =
issue I discovered is acknowledged at least, if not addressed.

Thanks
Shehab


________________________________
From: Christian Heusel
Sent: Sunday, February 2, 2025 3:26 AM
To: Ahmed, Shehab Sarar
Cc: stable@vger.kernel.org; regressions@lists.linux.dev
Subject: Re: TCP Fast Retransmission Issue

On 25/02/02 10:26AM, Christian Heusel wrote:
> On 25/02/01 07:09PM, Ahmed, Shehab Sarar wrote:
> > Hello,
>
> Hello,
>
> > While experimenting with bbr protocol, I manipulated the network condit=
ions by maintaining a high RTT for about one second before abruptly reducin=
g it. Some packets sent during the high RTT phase experienced long delays i=
n reaching the destination, while later packets, benefiting from the lower =
RTT, arrived earlier. This out-of-order arrival triggered the receiver to g=
enerate duplicate acknowledgments (dup ACKs). Due to the low RTT, these dup=
 ACKs quickly reached the sender. Upon receiving three dup ACKs, the sender=
 initiated a fast retransmission for an earlier packet that was not lost bu=
t was simply taking longer to arrive. Interestingly, despite the fast-retra=
nsmitted packet experienced a lower RTT, the original delayed packet still =
arrived first. When the receiver received this packet, it sent an ACK for t=
he next packet in sequence. However, upon later receiving the fast-retransm=
itted packet, an issue arose in its logic for updating the acknowledgment n=
umber. As a result, even after the next expected packet was received, the a=
cknowledgment number was not updated correctly. The receiver continued send=
ing dup ACKs, ultimately forcing bbr into the retransmission timeout (RTO) =
phase.
> >
> > I generated this issue in linux kernel version 5.15.0-117-generic with =
Ubuntu 20.04. I attempted to confirm whether the issue persists with the la=
test Linux kernel. However, I discovered that the behavior of bbr has chang=
ed in the most recent kernel version, where it now sends chunks of packets =
instead of sending them one by one over time. As a result, I was unable to =
reproduce the specific sequence of events that triggered the bug we identif=
ied. Consequently, I could not confirm whether the bug still exists in the =
latest kernel.
> >
> > I believe that the issue (if still exists) will have to be resolved in =
the location net/ipv4/tcp_input.c or something like that. There are so many=
 authors here that I do not know who to CC here. So, sending this email to =
you. Sorry if this is not the best way to report this issue.
>
> does this cause problems for real applications? To me it sounds a bit
> like a constructed issue, but I'm also not really proficient about the
> stack mentioned about :p
>
> I'm asking because this is important for how we treat this report, see
> the "Reporting Regression"[0] document for more details on what we
> consider to be an regression.
>
> > Thanks
> > Shehab
>
> Cheers,
> Christian

(forgot the link)

[0]: https://docs.kernel.org/admin-guide/reporting-regressions.html#what-is=
-a-regression-and-what-is-the-no-regressions-rule

