Return-Path: <stable+bounces-124427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BD1A60F2C
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 11:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E5416C5BC
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 10:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597F1F462A;
	Fri, 14 Mar 2025 10:39:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68E51581F1;
	Fri, 14 Mar 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948759; cv=fail; b=o2+Z1j8YGpUZWz+KIxitdYohGsZUXnr/lP2mkajlE4rVpfNOINCnOCTwGHnAcCcJhFO2OLdYCVN8kaiB3G1k32WxgJGL4Ld14bZBqcW7m3fTCFsgS+ZLpAajfLAgi741TB/AFbpIIE0bPeVo7BC+ve5yyEK+chWJ1HClqOehrnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948759; c=relaxed/simple;
	bh=g9IWotZxdppBoSExg5S4WL0BbPcfLmpRvpTj8Vwb1PY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qk4nvMinuMGHk2P3HsJjeFTpLAejVYavzhJ5H0KTJgWwy6Lyd/kgNlcgDOtT23Fxzjjk4XlhTwud3IOr8VGISAgh+FPj28m/sp8MQuv1fm8kZInlha6tcIYPlLVpE0hUzU/3C8IPYM0a1z9SvHtRPoU/qPe3x+rlkHBCoi+en0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E6R920027955;
	Fri, 14 Mar 2025 10:38:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45b0ga36sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 10:38:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrLeHtBeN3WG7YMtzPNY1Cj6C7vuG3h57r5KXoJZEem6RwSqdB4t+ohmZK+/Th559maXe2UtDkeUev+HSDUIgtmiHhwLrctDuuvzYI7Jj3J6Ur6c80kc9z4IHGH4Mz+SZSKq+0VljgXKdsGMi3ybhnXMMBEYcvHyk2IWEpAozDAqhpskjMpkJBlBGuRYucZ38K7FN/9pUrt12eOgKr97ZAUhGKQ1bt07imuF5/QkjOeQG6nRsTvLArJe4KdkKkKKZPgsQM3NpB5JuRhr1WrWJyEavNK32bu48vdpwQss7wzxMsePanW59Vv6Zupjs9j7OjHArKGrbCnlOtTC28Yyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awybtU2PNToZ5ntr51EiFn10ryA6mMFdd1MzeI0d8is=;
 b=Ud/ehVgGrxavVf84+w6gumUc7unxIUKyRpbrglaT1ns+BmNDzL8Jpxu9wQ4Di/Xaz6lEzCm/Evce+9kgnvqGmYO5daByHbXH3WwKWsodbH2/8yf4+M8bg5kOUI/gN/LHcKqGMSmVdZOd6YzJMs1sOjOit6eeF6zr6xHKiryl5FRqVuAXwDT+0ipX+a1yoYMA4rzsRJ0kqLW5vIjVPh4sQgSpRjdM04IY7Mnzl/szLaX6X7J/DdYgWq0077UBLWRvNOW0wyG/myjDr3/X7fXfeRsk1mMJIjJLuEWtFIawcSTlA/NyaY9GhA5+InUWSrXhkIm3e/0f/ewPTRSYL6RYeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM4PR11MB6503.namprd11.prod.outlook.com (2603:10b6:8:8c::7) by
 DS7PR11MB7887.namprd11.prod.outlook.com (2603:10b6:8:e2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Fri, 14 Mar 2025 10:38:55 +0000
Received: from DM4PR11MB6503.namprd11.prod.outlook.com
 ([fe80::5881:5ec3:6913:3119]) by DM4PR11MB6503.namprd11.prod.outlook.com
 ([fe80::5881:5ec3:6913:3119%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 10:38:55 +0000
From: "Ma, Jiping" <Jiping.Ma2@windriver.com>
To: "juri.lelli@redhat.com" <juri.lelli@redhat.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sashal@kernel.org"
	<sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiping.ma2@windirvier.com" <jiping.ma2@windirvier.com>,
        "Tao, Yue"
	<Yue.Tao@windriver.com>
Subject: RE: sched/deadline:  warning in migrate_enable for boosted tasks
Thread-Topic: sched/deadline:  warning in migrate_enable for boosted tasks
Thread-Index: AduUlbvhp17hxZyWQSiDwC+Hn8B24wAMuKOAAAD/UbA=
Date: Fri, 14 Mar 2025 10:38:55 +0000
Message-ID:
 <DM4PR11MB6503BFEBC01DD2B33A0CA2CED8D22@DM4PR11MB6503.namprd11.prod.outlook.com>
References:
 <IA1PR11MB6489427BF9BCE1809FA4D1EED8D22@IA1PR11MB6489.namprd11.prod.outlook.com>
 <Z9P_a9y_2aqJH2xy@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z9P_a9y_2aqJH2xy@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6503:EE_|DS7PR11MB7887:EE_
x-ms-office365-filtering-correlation-id: f416d6f4-027b-4898-963c-08dd62e46ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dGbN7nBinCz5iNpjMDs8Zjz05/VqeaVkgnXkPBgs1j2kNOnBw5hXM/OX0ZnY?=
 =?us-ascii?Q?i8fleONs78ityYMxHscjAzmggx4S5QPs8Ld+R0O819AvOIGsmSZs9CVkixD5?=
 =?us-ascii?Q?UD6m03vbKq+siUS8fDOAxLw5HN/VY15tfhr3treuLEAiMf7Sg/RgBQMufEy0?=
 =?us-ascii?Q?c2xbq2K+BsaV86AB/nYkryCUpwsO+U9KcnK/JC1Wg+QUgdxdd5/5WNiq6Rk0?=
 =?us-ascii?Q?24Ge588tFmtRnGnfLx61uDqzInbhb5AXmy8rO0wXXPSVU8CH7h/ZAGsm5o1A?=
 =?us-ascii?Q?3s2ciDosFWWUv6l4eJ6h+dbJID8+UmaKyd8PTAHKbvYJ1/VdcNT8a3fI8V+h?=
 =?us-ascii?Q?uIrwK7xpabhRufn+iD8JcNz66haQnlcmscddJSB7pfOe+Zn1gC69eRObrlZ9?=
 =?us-ascii?Q?GuigH/UvdxiE8jVxmKmAfGf6XItueUFXfVC9g2r9e9LhYVSCY3SzcjCTdzdw?=
 =?us-ascii?Q?+kzBI6Ck9TP/uICyAweZvQh0d5yJlAZmodvDIJAKmArecn8bdNrPF0md+Epv?=
 =?us-ascii?Q?W7tECINSMfqQu3cm3V2xzZrc1dfpgK9dvEhqm6AVYdfUqEquubMtYxt0If5V?=
 =?us-ascii?Q?lwb8RkvHLpiTh28OsViIIGvooWyzcdAgfuWX+QEhXJFdTQVC7nnVCxB7bsEL?=
 =?us-ascii?Q?nV9K/BGj+DXKQcDkttEzm8SAonox94HQVPkZoAu4cxQXOlkyg12HgoriyZmI?=
 =?us-ascii?Q?8Yw1AYxrXS9GHX9qjjmsqgC2z8q548uZlGsvyDx8ombM/NgqhdHxEXA8Wjch?=
 =?us-ascii?Q?h1OPNCnjXOeXEH8qIYwnjbgG93oA/T+TLdw9YiMhDjEHAdhts5TO8Hvz9yIG?=
 =?us-ascii?Q?l330rp7gs1FiGKvbhmhdNoy8taOIQUeYhbsoBq8DpMcIlZiL5H0Vxm9nTfpR?=
 =?us-ascii?Q?kWbXJU6xP0iUn7pXPwbeF001ovMx/ehmIjnicf+mYsdtZ6lW0anQ473WIKYw?=
 =?us-ascii?Q?fPcoTOMF1ZOOe7CwFI0hh33GNpbFBzlJr18Jalw8OD74D1QEiioTE9N2B770?=
 =?us-ascii?Q?O1DwuWCnoe03aKqHytXESYgUd3lj3sSwp0tMpJdoGR9TBoEgfkK6aXOS6lY8?=
 =?us-ascii?Q?YaOuTEya1K9fZfOd2/turB1Mc8rj+mqdnaZ+lNHdMJ0z9Vp2YVVEmZU3wSDa?=
 =?us-ascii?Q?t1rCz7Ls5zVnWKQofyCZ07Z+oXD0MKdX/RwvW8xXcrBzYO1QcfEfZDjzV9EF?=
 =?us-ascii?Q?xtlyHHmkt2fa//jzYUQpP48nCpv/imGahSsitRBsZ/sPAcmDtb58uVH1r3wJ?=
 =?us-ascii?Q?9BrjjPM4CAwjJ0zjY0hQawwtTCvkwdeHQ6qBqBdfK8zSODQAJwFvswwOu317?=
 =?us-ascii?Q?GPv/Z4Vyrvly2jV0Gz71gtgmRyMJt/5noU+AAOAwP6faq4Q1+7STHZTB2MRr?=
 =?us-ascii?Q?kEndi+a0N3/2j47Pl3Bs61hbQhVmZHsCEkyRv4vd1ly+vCbAu7OE6yVBLXs8?=
 =?us-ascii?Q?d1RJ2OEfYEPmQY57ESlQVTlnki6M/rhN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6503.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D+50vAaWAQ+lBVNmQUNs48txE9Ty1HK+kJmqgEMtAU4ceeflEFY5NuPEZHde?=
 =?us-ascii?Q?vdv4t3XvWafDfrYuSRvLkvVF5w/6qsXgZWe63cVDj2V2fGhyOnzSmff0q6Hw?=
 =?us-ascii?Q?MrjxdgpicZza5oaLQwTbdGWQ6025hXiezqc04EPkCgB0+0GCtHeZiwaIn9gw?=
 =?us-ascii?Q?daPZjrzakV6OL+MTD78fuhSap0xwqP0TmV7eQ1sIK3c1sWGMyx2Bk41hp1D1?=
 =?us-ascii?Q?5VGGsHG7EiXzePP4BQ9srgo1+/I2Bb2zlKoefohFQZbEzc00rVCbEv9iphzv?=
 =?us-ascii?Q?ow6ta+rfpsDt10MqAIO/OnJ+VtnUf4XALsYRUV1SCF4U4n1nv/FFRqatOuux?=
 =?us-ascii?Q?UF86wV3UFpWRKHwHGUUbDKV2xO9m4OG4k3lHhPAfRnA9h3Cd9zTL/c9480ua?=
 =?us-ascii?Q?I7pNxU6xGy40Aky455VZZtgE31i+aMuf8ePLG852209QK4SCpWrYBKujQFpP?=
 =?us-ascii?Q?So1gs7Z2bBN/snD7ZJTVdvDSn5963N8CClixCzwen7pTwH9mK21iW4IY+ECM?=
 =?us-ascii?Q?G3sdvwlGFRUqFrt+RTeSy0WbLrrF7eEhnLKRf8365Yr1rbzvtrWSX/IgOb/g?=
 =?us-ascii?Q?7iGFUqzmueofm/O5O3GJfhTRclyr+nSH8kVaUrZ1lbN8yQvZ3moT2O+n28md?=
 =?us-ascii?Q?y1M3BpqluGAJ5u9grCp3yHAVPwcyP3oqbfVBEwlZV8VWYi7/M6xaaRsSSLYp?=
 =?us-ascii?Q?HDXeor7OjeOOnGEql5Zb94Pe8ak0KTIBo4wRfqBATKn7cO/1XgVVo1YZ2UkE?=
 =?us-ascii?Q?L3o23JEX/9L3JS2bm2Mmzc2xthAZ6i+dli8IyaWE1nfcUseqy/Bmgi0p/Xjy?=
 =?us-ascii?Q?92hnMM8DUQBb/Ypo6HVKu9zqdikXx5Fdn3J/mV0+0wBKEKjosVWm2E0WC3//?=
 =?us-ascii?Q?sEfDJ/PrwcxECkVNUZs5z9D/jC6l3zWB1dAYURqs+x/4YSN6ltIrxjaI0jC0?=
 =?us-ascii?Q?evtXfs6fYsHN28V70F2oojSIhjdZ7C0klOH+t1kkk/WV/HqamcbHzkC912dI?=
 =?us-ascii?Q?e0mp0IEq//gkFFRbpy6LKY5ZtdHn3GvdsdEzlAC3+QWJkJB0lxtj63ie1HU6?=
 =?us-ascii?Q?t6ogBcJ5NN1QGQ59kELuEXqyEp5SJw1vy+5UHOEAPJV62aA0rBsJTn55Yjej?=
 =?us-ascii?Q?BOnkwA4JobCjzYM+BgoNiLJfO1p1CIEbk+F7QmU+/nEQDx4rZ4RTm/P5cfVs?=
 =?us-ascii?Q?cpZuMunqeirPs8I5rhUPAeT5HalwoN1v0UOEEzgvXgKaj7jSeW1qYbEoFxHI?=
 =?us-ascii?Q?nxy3+o5OGI1dCWEeFQI3dpNjRKVCKDBZsWf4/v/c7OCoR3J6VO3fG5n9C+DX?=
 =?us-ascii?Q?BiCni6Eg4ddH8yc88evl5ONO0et4mJyAl5OLeaqGN7Wi4TssMHdcbNaNsIR/?=
 =?us-ascii?Q?ILniCPQ10V19mMCsulkEtyogCRCkoNN82RWN1sua4LQ9iml4LewxVx7YCO9c?=
 =?us-ascii?Q?I70AvucHhHCMTFW+XsW0QTP9iucxWFJsC83lKuOLguWX3Pcd5FqbBxWGuBUS?=
 =?us-ascii?Q?XgF+kqTBo+HwtT7lzgqFkCrJAtHWOQkNOITGGuHa9CgQwbglg58GJ1X46kp+?=
 =?us-ascii?Q?G1ONG9MfhEC8cpx5X5h7jVeLtPL/Z6hnQbuM0AjX?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6503.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f416d6f4-027b-4898-963c-08dd62e46ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 10:38:55.3935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UYONhfcK7rEYKWrWnQtt/JUX1I3ZIVw/HhsFzutfmb54a9e7loftlOOWwVXMnOQUnUjFzLk8QD7Y7ftMueo3+RsQnlsI/8pDw2hUwvHw0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7887
X-Proofpoint-GUID: mg9Q0P6YSpq5VQPml8YfQWYe4fRxbuVy
X-Proofpoint-ORIG-GUID: mg9Q0P6YSpq5VQPml8YfQWYe4fRxbuVy
X-Authority-Analysis: v=2.4 cv=ZrXtK87G c=1 sm=1 tr=0 ts=67d40743 cx=c_pps a=gHjWyi4SN+6fNgZLRl0D7Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=meVymXHHAAAA:8 a=1XWaLZrsAAAA:8 a=EO0ndD4tAAAA:8 a=TGWRFvGZnzJx6LKCTUUA:9 a=CjuIK1q_8ugA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=2JgSa4NbpEOStq-L5dxp:22 a=tegIgetnaL1jUUJuQklI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503140084



-----Original Message-----
From: juri.lelli@redhat.com <juri.lelli@redhat.com>=20
Sent: Friday, March 14, 2025 6:06 PM
To: Ma, Jiping <Jiping.Ma2@windriver.com>
Cc: gregkh@linuxfoundation.org; peterz@infradead.org; sashal@kernel.org; st=
able@vger.kernel.org; wander@redhat.com; mingo@redhat.com; vincent.guittot@=
linaro.org; dietmar.eggemann@arm.com; rostedt@goodmis.org; bsegall@google.c=
om; mgorman@suse.de; vschneid@redhat.com; linux-kernel@vger.kernel.org; jip=
ing.ma2@windirvier.com; Tao, Yue <Yue.Tao@windriver.com>
Subject: Re: sched/deadline: warning in migrate_enable for boosted tasks

CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and =
know the content is safe.

Hello,

On 14/03/25 04:02, Ma, Jiping wrote:
> Hi, All
>
> We encounter this kernel warning,  it looks similar with the one you=20
> are discussing [PATCH 6.6 331/356] sched/deadline: Fix warning in=20
> migrate_enable for boosted tasks - Greg=20
> Kroah-Hartman<https://lore.kernel.org/all/20241212144257.639344223@linuxf=
oundation.org/>.
> Do you have any idea for the issue?
>
> kernel: warning [  998.494702] WARNING: CPU: 19 PID: 217 at=20
> kernel/sched/deadline.c:277 dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494705] Modules linked in: iptable_nat ceph=20
> netfs macvlan igb_uio(O) uio nbd rbd libceph dns_resolver=20
> nf_conntrack_netlink nfnetlink_queue xt_NFQUEUE xt_set xt_multiport=20
> ipt_rpfilter ip6t_rpfilter ip_set_hash_net ip_set_hash_ip ip_set veth=20
> wireguard libchacha20poly1305 chacha_x86_64 poly1305_x86_64=20
> curve25519_x86_64 libcurve25519_generic libchacha xt_nat xt_MASQUERADE=20
> xt_mark ipt_REJECT nf_reject_ipv4 nft_chain_nat nf_nat xt_conntrack=20
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_comment vfio_pci=20
> vfio_pci_core binfmt_misc iscsi_target_mod target_core_mod drbd=20
> dm_crypt trusted asn1_encoder xt_addrtype nft_compat nf_tables=20
> nfnetlink br_netfilter bridge virtio_net net_failover failover nfsd=20
> auth_rpcgss nfs_acl lockd grace overlay 8021q garp stp mrp llc xfs=20
> vfio_iommu_type1 vfio sctp ip6_udp_tunnel udp_tunnel xprtrdma(O)=20
> svcrdma(O) rpcrdma(O) nvmet_rdma(O) nvme_rdma(O) ib_srp(O) ib_isert(O)=20
> ib_iser(O) rdma_rxe(O) mlx5_ib(O) mlx5_core(O) mlxfw(O) mlxdevm(O)=20
> psample tls macsec rdma_ucm(O) rdma_cm(O) iw_cm(O)
> kernel: warning [  998.494748]  ib_uverbs(O) ib_ucm(O) ib_cm(O) lru_cache=
 libcrc32c fuse drm sunrpc efivarfs ip_tables ext4 mbcache jbd2 dm_multipat=
h dm_mod sd_mod t10_pi crc64_rocksoft_generic crc64_rocksoft crc64 iTCO_wdt=
 wmi_bmof iTCO_vendor_support dell_smbios dell_wmi_descriptor ledtrig_audio=
 rfkill video intel_uncore_frequency intel_uncore_frequency_common x86_pkg_=
temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pc=
lmul bnxt_re(O) crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 =
ib_core(O) rapl mlx_compat(O) uas intel_cstate intel_uncore acpi_ipmi mei_m=
e ahci i2c_i801 bnxt_en(O) usb_storage i2c_smbus intel_pch_thermal mei liba=
hci intel_vsec wmi ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter ia=
vf(O) i40e(O) ice(O) [last unloaded: drbd]
> kernel: warning [  998.494781] CPU: 19 PID: 217 Comm: ktimers/19 Kdump: l=
oaded Tainted: G        W  O       6.6.0-1-rt-amd64 #1  Debian 6.6.52-1.stx=
.95
> kernel: warning [  998.494783] Hardware name: Dell Inc. PowerEdge=20
> XR11/0P2RNT, BIOS 1.15.2 09/10/2024
> kernel: warning [  998.494784] RIP: 0010:dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494786] Code: 48 c7 c7 e0 eb 89 ae c6 05 fd a2=20
> 6d 01 01 e8 9b ac f9 ff 0f 0b eb 81 48 c7 c7 c5 39 83 ae c6 05 e7 a2=20
> 6d 01 01 e8 84 ac f9 ff <0f> 0b 48 8b 83 28 09 00 00 49 39 c5 0f 83 53=20
> ff ff ff 48 c7 83 28
> kernel: warning [  998.494788] RSP: 0000:ff32fa3140adbca8 EFLAGS:=20
> 00010082
> kernel: warning [  998.494790] RAX: 0000000000000000 RBX:=20
> ff2ef1f93faf23c0 RCX: ff2ef1f93fae0608
> kernel: warning [  998.494791] RDX: 00000000ffffffd8 RSI:=20
> 0000000000000027 RDI: ff2ef1f93fae0600
> kernel: warning [  998.494793] RBP: ff2ef1e9c19eaf80 R08:=20
> 0000000000000000 R09: ff32fa3140adbc30
> kernel: warning [  998.494794] R10: 0000000000000001 R11:=20
> 0000000000000015 R12: 000000000000000e
> kernel: warning [  998.494795] R13: 0000000000000000 R14:=20
> 00000000ffffffff R15: 000000000000000e
> kernel: warning [  998.494796] FS:  0000000000000000(0000)=20
> GS:ff2ef1f93fac0000(0000) knlGS:0000000000000000
> kernel: warning [  998.494798] CS:  0010 DS: 0000 ES: 0000 CR0:=20
> 0000000080050033
> kernel: warning [  998.494799] CR2: 00000000181b50a0 CR3:=20
> 000000063db68005 CR4: 0000000000771ee0
> kernel: warning [  998.494801] DR0: 0000000000000000 DR1:=20
> 0000000000000000 DR2: 0000000000000000
> kernel: warning [  998.494802] DR3: 0000000000000000 DR6:=20
> 00000000fffe0ff0 DR7: 0000000000000400
> kernel: warning [  998.494803] PKRU: 55555554
> kernel: warning [  998.494804] Call Trace:
> kernel: warning [  998.494805]  <TASK>
> kernel: warning [  998.494805]  ? __warn+0x89/0x140
> kernel: warning [  998.494808]  ? dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494810]  ? report_bug+0x198/0x1b0
> kernel: warning [  998.494814]  ? handle_bug+0x3c/0x70
> kernel: warning [  998.494816]  ? exc_invalid_op+0x18/0x70
> kernel: warning [  998.494818]  ? asm_exc_invalid_op+0x1a/0x20
> kernel: warning [  998.494821]  ? dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494823]  ? dequeue_task_dl+0x16c/0x1f0
> kernel: warning [  998.494825]  rt_mutex_setprio+0x240/0x460
> kernel: warning [  998.494828]  rt_mutex_slowunlock+0x143/0x280
> kernel: warning [  998.494831]  ? __pfx_mce_timer_fn+0x10/0x10
> kernel: warning [  998.494833]  mce_timer_fn+0x90/0xe0
> kernel: warning [  998.494835]  ? __pfx_mce_timer_fn+0x10/0x10
> kernel: warning [  998.494837]  call_timer_fn+0x24/0x130
> kernel: warning [  998.494840]  expire_timers+0xd3/0x1c0

Not sure it's the same issue. Stacktrace looks different. Anyway, are you m=
aybe able to verify if the issue is still reproducible with latest v6.6-rt =
stable (v6.6.78-rt51 at the time of writing)?

Looks like you are on v6.6-rt, thus the question.

-------Yes, we use v6.6.52-rt.  It is not easy to reproduce. We will try to=
 test it with v6.6.78-rt51.

Thanks,
Juri


