Return-Path: <stable+bounces-100837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116FC9EDFEB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 08:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D7B286279
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0699204F98;
	Thu, 12 Dec 2024 07:06:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018F204C35;
	Thu, 12 Dec 2024 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987195; cv=fail; b=hAoNQ1Kq5ZBCqX9zoZ7ZJxb/pTg8Ki/odS9MhNYRaeCFHiyBghAVL1H/d2iLTxp+GxD+pE8Ph8/yOYeGAbqVGIzEtw0gepgxtfPff2HEVhDjxn+/2qLWTwRC4n/8vOBTvdzPnq5r63TK+t9kyeXrA2bWook3znfBIOJuAWq8mGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987195; c=relaxed/simple;
	bh=oWBOeM+Rn2mWOlDflUcYxpdk+s2ZkZJ3qON2bobPrmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=csdBBhBbRfRMGPSpQl2hJbngSI/mSBBtfKQRhWVy5/VB9jEqhP3LGVMxVniAUdbyH7QVAgPsjTRVZhAWbGdUXCAcbRA+R4fM3lLiJItpuQFmsRc58cecL/Y7CfJEVWkdoQgE2QdM9T3BRdNRjiBuZB0nu8xsFLnNKeUJjRs7mTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC5SxcS028348;
	Thu, 12 Dec 2024 07:06:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xd79x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 07:06:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4HhIdvIqkzYcurkcg/F8VXVxbdiddSqcelMuDWQlklInDq2q9OUmtyW3322LOteQ2V6+tpYfFfJHtgdfY/JA53xSJTdSF4WWz2sRxsbsNGjgRu9AF44X+WrLABis9ICM79jXbX4BZc0hYOxEPC1J3SPzteyDqXGuVJTH8x0trAs7riJ+5XHJi1P/nnuDS0WD7IVlqbJ9dArQ3kTQNRdZtqE8AJaxid7dgUpX7wfh/5NBznI/uaAo4rI3zw591qQmQ6LwR/rmuFhoWO431JtlvafDFLtwznEruNZj1MRrtclkj8+E4NrQtWnYUIWOYlvtS62h9LAn9QqA+Fl3+XQvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWBOeM+Rn2mWOlDflUcYxpdk+s2ZkZJ3qON2bobPrmU=;
 b=vByuplXK2rbrV+J6pSj8caDl9LmC2Df2tUZekxhHDpkEo/Yy3wneQNlluJmsjwAKdYzVeAAWbLHzoNPVsaBQD6uc2vkXacpBza8wJh7fkS8up3cq4lTEime2cBnK+0bZBxgucq2EBO35j9GLn/i448+n9o88dSYuVEwe6f+JDi4N2gMNWgPYve6BXvR1RfPfNGFxuOTzSZKPbvm5Ap6svIE0h3uVW6p1uu+rPWX8AHVVttyZRbtGHqGqHC8JnKt556pntepIRH8JKmZMLzM+K7vgkCbyHXpHEXQzgF/+113WTmhHSdxLy3V/aKhWz8fcQDPTco0Ew6VOh7FYI9YkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB6170.namprd11.prod.outlook.com (2603:10b6:208:3ea::11)
 by LV8PR11MB8721.namprd11.prod.outlook.com (2603:10b6:408:203::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 07:06:19 +0000
Received: from IA1PR11MB6170.namprd11.prod.outlook.com
 ([fe80::f850:53da:e11b:1653]) by IA1PR11MB6170.namprd11.prod.outlook.com
 ([fe80::f850:53da:e11b:1653%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 07:06:19 +0000
From: "Ren, Jianqi (Jacky) (CN)" <Jianqi.Ren.CN@windriver.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "sashal@kernel.org"
	<sashal@kernel.org>,
        "jamie.bainbridge@gmail.com"
	<jamie.bainbridge@gmail.com>,
        "jdamato@fastly.com" <jdamato@fastly.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6.1.y] net: napi: Prevent overflow of napi_defer_hard_irqs
Thread-Topic: [PATCH 6.1.y] net: napi: Prevent overflow of
 napi_defer_hard_irqs
Thread-Index: AQHbTEto4OqCZXDuc0C1kLGykNE/+7LiLomg
Date: Thu, 12 Dec 2024 07:06:19 +0000
Message-ID:
 <IA1PR11MB61702361F5B701B51B5C638FBB3F2@IA1PR11MB6170.namprd11.prod.outlook.com>
References: <20241211040304.3212711-1-jianqi.ren.cn@windriver.com>
 <20241211200739.47686258@kernel.org>
In-Reply-To: <20241211200739.47686258@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6170:EE_|LV8PR11MB8721:EE_
x-ms-office365-filtering-correlation-id: 012d2a5f-e194-4619-1e30-08dd1a7b7a70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ql04lK88uCYSX19UIvZBv3gRx1TtNUMQ1gMl8gKIL0+MTcecOXN5/L6omkls?=
 =?us-ascii?Q?l7rxOTwi/YSv/A1qoS9D9Rdjk/1ao6W3IKG/BtIVAlXzHMcYusHfeWTW0TkP?=
 =?us-ascii?Q?icKgWQpoH6oX7iJxdVossUWuHJHxsZwkPZ+PAvcM+YLF6ZZFLKBasq9uobZ5?=
 =?us-ascii?Q?WM/AxyZaJaKsfF13I9LwMPzV2mjpHJTxjiHcFz0n82Qgf1YcMLSiBMozQU2C?=
 =?us-ascii?Q?aI9+YqEabIBGerhdJKw9bM9WOZJlfm5DOyceeVnnCW6T8fAkgpW8yCYxNgJT?=
 =?us-ascii?Q?IBKeeDn2T6YpD3xl929SX9UINRh53+/qSaEq9Kc+R7QGzKgdyZuBCu3B7YrL?=
 =?us-ascii?Q?Q1BQEjxvtYvyvE6C9gGqgS5pD/+7IXdHEQXW2S/gIU5Ff8EWgZR8KaoxlzcZ?=
 =?us-ascii?Q?dCxhaLlSt960IxPj8P5AM/Z9a2c2+6stwxxkno+j8eWg44/0uZTIH21P7F15?=
 =?us-ascii?Q?UDj4vPOS3JnucGCt+jJCKyZXoXyQR/O5ynnXyQ2/5Hs5/5YJwh2BjPp2T73Q?=
 =?us-ascii?Q?iBBo8adkgb7MLMADcgPNMqJkVS/6QIJ8vP3TZp2XDkLqj9RQeMMPv3vaHr7y?=
 =?us-ascii?Q?KEFxuq2+X5y969xPs61Z4m99HT/hCUZJMIds1ecYy4GGxJCYkHIS3NoZLckE?=
 =?us-ascii?Q?/XUKcG2msRdztToFSVWfioxBToyaGn4AKRo32uYdT2EZvQdd+/me+7+oamgY?=
 =?us-ascii?Q?brPmY3EkGiylQcZXfwMFswYL3HKFZlShwWxujcS4FgkBi8YmcMLEeLQwuDbh?=
 =?us-ascii?Q?de5YmiQJW19MyoDsI148pabB6wVfBIgpKEDKEkMlZ5iJyweKGiFPhRWqu7na?=
 =?us-ascii?Q?47h/YL9rCbvaI/nCcF6Pd8iNtQFUhaegP7KJzICjUAKmqOJ7DOApwNFTpISh?=
 =?us-ascii?Q?pYLga69JNyFGGTyemYRsTsywK9MIEjsTiopHwZJoDjHMFGz9iNPNHST96vMJ?=
 =?us-ascii?Q?sbVZs1vEXRJcMjs0KdXx1qcCIjAEOPIm5oQ6ee85V7RBiSX8+c30UD3AhPkF?=
 =?us-ascii?Q?ES7TSNNIZ29QZ40/UG9Dou0wXoLRdhXzvYCHT/OXgZDdWDA5DZn/YHwubRjA?=
 =?us-ascii?Q?qV2Zv/ZiJTRK4KwcbXXwbedY3hBhmuzzzVrmK51kd5B55wuCECCwD3bFet5j?=
 =?us-ascii?Q?tPv/cDeejYibgUZdFIOXJz6SBV41RxGCvazVuN6i9iTU3t7v1OaG8LLUV/kQ?=
 =?us-ascii?Q?tY2WCu/+yeUYdTPjVfbI17mHHg30uF/Ajs1ncGCANHibniBUgm18GZY7V8iP?=
 =?us-ascii?Q?z+ySy7M76wpffOfAfTbrL7u/CpKaY9mGXcE73mYQGvURD3j4QdBjavMjtlim?=
 =?us-ascii?Q?xjMH2ZF+E3U+MFxrahnYTTk9ZfxI59ATEA/U+aa4O3vPt/Oxl7VvHavTZuiv?=
 =?us-ascii?Q?QGAzYGz3BkbHbKMOEAF8uZH3uzgXFPYjEub6LLg1TaZ3Ys+oHg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6170.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fXmv3ryP19n8FNW0vwStOuL5q1z2woCK0+ZVrqC2S7t0o6nm9IWJtUlyYXMT?=
 =?us-ascii?Q?XliXXH0JVNqqOUE/OA07FE+BCrGlqycQcM61TTQHyUdiV/1OiGk1c/r0ZqPw?=
 =?us-ascii?Q?1KIUPm2QfEgoWP9xVaMD27Urx/i9ItAqA3lVc9ssr0nkIrqt2hsNYmcNQyze?=
 =?us-ascii?Q?TeXJk7+RdgiolkjAA0yN8JBtoosFhO4PDxh9vTHWmRlXRZnDnQH/e1Vlah+A?=
 =?us-ascii?Q?caMfXkzJ8VLj0+PpOWbwmwWL1cGob4hop63tqPlEsDNBpV5MNBLSg0JjT1W1?=
 =?us-ascii?Q?xE4qxFUT0AyP0BrcFDNWUYIBseQXvQYOrthUVoppDw0tT46u4dYNkO6prvyd?=
 =?us-ascii?Q?YjwuHHUJC3hW10RgrXmWgqqYgy+WlcYZISlgCYJg4u/wrLBrQA6gGocZ1wOv?=
 =?us-ascii?Q?aVi5NTjsjCim7K3eGx59BbbAtiC/w4GUxkFb1Y3ChX7kY+k+lnCPEW1HrhUu?=
 =?us-ascii?Q?5b0fhpJfCyNXGpTtOKL4h53lfwCAUDQkr6XjjGLQKyNrfUin0mpjYKOLgaNf?=
 =?us-ascii?Q?Nit3yfe7NllsPGBT3+yHkGTI19yjehmrEpwS1vj5fl1KnMqo+l/lMSg5PEf9?=
 =?us-ascii?Q?VntyfteQCcNDAifSr7tSJOfT9Cdk+w1MAHta/G3S6xf/g2/MfiAHBE16T+di?=
 =?us-ascii?Q?O678+YxBk8i9yl7vnkzmQ7oVdU4Wq8kKNnt6vnjpe03/o4gYmvejJf54H6f7?=
 =?us-ascii?Q?cc9OpPoKCpjPyQ6l+eG7KqLL8Z5NI6qxo49z443zHr7iOBpcIrnvJpQFezol?=
 =?us-ascii?Q?+IJIzH7jD+AWmvHlipBeJfh+JfCS2ncAYRDG3Kl8LTjgsFOXSS4kOzNiCNPj?=
 =?us-ascii?Q?gJSwWX5EE9RspqOaPOloxm/FV+5SOpPIW5ewTrY7wIQHLGvutChHF+7S5lJo?=
 =?us-ascii?Q?aM06RT5myTMkmCytBt0HmACJ+E+vnNsrCCzh+4/14v74UUsnnV8zTIgn+ph9?=
 =?us-ascii?Q?zJfnu99LuELCOaFFC49xQpso4lzVEAS5po/x1Hls2BhcxhAEMs7rkWHmd6gw?=
 =?us-ascii?Q?a7v0lRmSyN99IOf+jigDWjZ6vwE8Srg7LCByIu2sNyp2r6pADHbbAX4hSNbt?=
 =?us-ascii?Q?y3+bDd8kkaV0W8ACO4wOQXat1xrz51Tifseabkl7j9lrmIow34/aEpemJY2Y?=
 =?us-ascii?Q?dJA9Bya4Pqm8OssjabmsKj1ZsXPYg67tSMYho1LKTNk7ZtTeuJq55vnjD4GY?=
 =?us-ascii?Q?HORJ8RuT/bO3Q/jHfGXPv67MuXbu+QRso1rReQtqZhwdxFohFnlzpx4GLRFK?=
 =?us-ascii?Q?nvzZAhXcPcFRkx11V2v9wFYVG9Wqil9Nnr8JeuwZrlZbuph1eRAw/i3mbv+Q?=
 =?us-ascii?Q?EWrvGQOOjT95/vWCFQ2AsOZ6+9u7VrZ/BLSzIOYbL7F0/il3ZkjLQ2mKrjRD?=
 =?us-ascii?Q?po7YaUBwalWRuEUQITjhjlCw8hR66wMDgkJytWGBTMyWPA/UwC8c3/lMBbsb?=
 =?us-ascii?Q?e5MAN8PpNaqXkDd5cf0ivEfxvdiiHspf4Jmj9g7TE+ka9R7TO6xdlkv5PPyA?=
 =?us-ascii?Q?qA9whdxH2SI2N7eppFHKOvC0Y+3hC/7v6cWjaJezr8cO61LGhY5ed/Gzcbzw?=
 =?us-ascii?Q?j2Jm1pFmXtOcPTEPjJSkB1K+yw8PICsBFU3nfu6Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6170.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012d2a5f-e194-4619-1e30-08dd1a7b7a70
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 07:06:19.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQigisXnZOdn2KIiLnqzXKlj6ViHiG/d5ZU3J7mMbMshQuWYGdoP+hZn5/350e4VGv46I0l4dOH1O8dB2GGiejB4IZkd1F9l6V4kiSKHdQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8721
X-Proofpoint-GUID: eYROlEtXm12SGexX0fxNH85feNbuFANr
X-Proofpoint-ORIG-GUID: eYROlEtXm12SGexX0fxNH85feNbuFANr
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=675a8b70 cx=c_pps a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=ag1SF4gXAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=Cy2GHhHaAAAA:8 a=wvPkM9v7g1_ikmSEda4A:9 a=CjuIK1q_8ugA:10 a=FdTzh2GWekK77mhwV6Dw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=bTms1Ghn32FVZww6NAbk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_02,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=994 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412120047

I port the fix to fix CVE-2024-50018 in linux 6.1.

-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Thursday, December 12, 2024 12:08
To: Ren, Jianqi (Jacky) (CN) <Jianqi.Ren.CN@windriver.com>
Cc: gregkh@linuxfoundation.org; stable@vger.kernel.org; davem@davemloft.net=
; edumazet@google.com; pabeni@redhat.com; sashal@kernel.org; jamie.bainbrid=
ge@gmail.com; jdamato@fastly.com; netdev@vger.kernel.org; linux-kernel@vger=
.kernel.org
Subject: Re: [PATCH 6.1.y] net: napi: Prevent overflow of napi_defer_hard_i=
rqs

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

On Wed, 11 Dec 2024 12:03:04 +0800 jianqi.ren.cn@windriver.com wrote:
> From: Joe Damato <jdamato@fastly.com>
>
> [ Upstream commit 08062af0a52107a243f7608fd972edb54ca5b7f8 ]
>
> In commit 6f8b12d661d0 ("net: napi: add hard irqs deferral feature")=20
> napi_defer_irqs was added to net_device and napi_defer_irqs_count was=20
> added to napi_struct, both as type int.
>
> This value never goes below zero, so there is not reason for it to be=20
> a signed int. Change the type for both from int to u32, and add an=20
> overflow check to sysfs to limit the value to S32_MAX.

Could you explain why you want to backport this change to stable?

