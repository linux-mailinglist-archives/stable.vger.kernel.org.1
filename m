Return-Path: <stable+bounces-132073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20715A83DFD
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 11:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF608A7801
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 09:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647320F079;
	Thu, 10 Apr 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="nwrM1BjE";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="R+flg7aR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4329420C47B;
	Thu, 10 Apr 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275784; cv=fail; b=XpTTYxD5J9U4ldvJxkN+X2aZH08ESSVtb3Q/LEe48YPACzm+pXLMUCRN387xd+VJax0ki24AR66VylvdVqalDxkFmtX5hnM2yCbdEKsXTXsjGf0NOeq+ox2lJIO72wBVBGn0GblRkybKHSJmIBFEkgHUG5EnDTJjAbGkpVkn7VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275784; c=relaxed/simple;
	bh=71/QtSYmxWeUCMYijZ7kmfGaicNdJKBgLiRX4ZwjRbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pEn8bm8r6tXXV2ErG1u7hhWEwSofEqdwB/wZaOzZRHHzvP4GJsynkox9kKFiVzdzziNCqIJ2zQcPheiuIR9/SPaIDveuSFWKi6oSLU2nztDkeiT/wlolrhVCMP7Y1edt9RyX5fJ1M5WeZGOW56gvXwAgf6QUJuvi6tBUXiFC4ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=nwrM1BjE; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=R+flg7aR; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A5ZnFf026063;
	Thu, 10 Apr 2025 00:34:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=3oSlgtGUYejqnITvVywCJmvP02J9Y5BsTQjNrv3IS30=; b=nwrM1BjE5rvo
	idAPi26zhTpNqiJX44dLxdTm8qWF11w8Q57Y4/JbcM1VmXugdN5gIRSCLCXO5Rx6
	M96btCUZCv/xZieRPidcJQqXxfbbYPwM5kwVozHn/5OVJO6gphYKufPo69hZUn6n
	NjRbNCMXHiYZXOHHvLkT1XYJg+Fz2q6iXfBPLHtSiWnWKMUPahKzYxOyr7y1hpdw
	chDTwMn55/KlejIAYkfgs4P6+PBsvw6WTgrycNL5z2xUr7XP042eBDBhj+dDEdCP
	q+b91sIwrV9FKNTojvGgVCmiC2qq0EXkpjua8p2eKhKR4YiDTFQT/e+igObWBC/r
	7ByZoqyOng==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010004.outbound.protection.outlook.com [40.93.10.4])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45vbd2rqg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 00:34:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnBlDiWReOfZak7ZEkKk+j0Fs6MzJqjQ2v1RbE70kgl5Jx4xX6Qi3crPHMHidMlYB/TyXmRAyTXZ//07PD5wTtklbugZAMX8b1tDZFPjgZOA5pSOzRV0NciGUmzKZ140E20fj7GQX8yB+S8taRqhU+jSiSkr/qwmqz9HmmAIVSKIetgm2a4uWN7URgXiGrcJ6qo7XCOAFyNfKte9ZcCcXuynqh2YZq7De2Q04LozOo3Hsxu+FpNEVP/iYryIQ0MBYtbpnd3E+PeIvELQFzpU0mSGmeNXbWy2/XvXPivtRkEeHQUicTEvScTJtQ4+DnUY/z2p/PvkaNonPTjhsJsBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oSlgtGUYejqnITvVywCJmvP02J9Y5BsTQjNrv3IS30=;
 b=MPnmTW7VaZDb7U5aYz0fQSmp/ES9zP3Dl9BRXhnkPH4Phm8IWdxPe54xL6oMCo04G7jJs5E1QWW9IYuvUGw9yzc9jrpxwpQaKdomzL6/QW0E7Ccp3OPqWZu4nUmaxa5LZkrihZvtGae3NhOFkhz8br1ME8RATY3hHKzedmupNJIX9JjtAyGXPtzdxt+s3U9H1HxdkHXLdLYZdU2QEmV0F1qmo0JXLOC222Kq+AHOHgBqt1TITIPbGVe30Bnn6Z+4KedZdhGxAZ6YiyiMCMBpzdPYjyucxkxD41Vicefrp7PMD0Mh9pvhCMK61/Jn5MjwMPWFld9zZu5EVqwVEkOM4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oSlgtGUYejqnITvVywCJmvP02J9Y5BsTQjNrv3IS30=;
 b=R+flg7aRFQPsh7kjfvankpg//KPLp7YcI7CdlGxeypnIz7dGVB7KGzolEr0bSICwbjrtFxbbXELJRUTgACOMYPtug7hmDQzbG8ZtisJMsOrYRX7xpesZ0W6k0Km8xwLdPc92Gji5jz2BuFDlDLWkEyRrCVIqsg6OUeRt/UQ6yTU=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by DS7PR07MB7767.namprd07.prod.outlook.com (2603:10b6:5:2c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 10 Apr
 2025 07:34:17 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 07:34:16 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Thread-Topic: [PATCH] usb: cdnsp: Fix issue with resuming from L1
Thread-Index: AQHbqemXS6B5IuQjiUyJckm8ZGIk1bOcgYzQ
Date: Thu, 10 Apr 2025 07:34:16 +0000
Message-ID:
 <PH7PR07MB9538959C61B32EBCA33D1909DDB72@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250410072333.2100511-1-pawell@cadence.com>
In-Reply-To: <20250410072333.2100511-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|DS7PR07MB7767:EE_
x-ms-office365-filtering-correlation-id: e08adb24-a186-4623-fc53-08dd78021980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tdT4FVfyY3sy9VXlTXeoOjkZStJvN3MMV+foD2Ui0HtMmlYGqWjTptD73aCm?=
 =?us-ascii?Q?8dKmsSb0AQXKLcNpNX3y1LTG24Z0J5Cv8anYgxOXZ4uxqID+CZaK/crJxYml?=
 =?us-ascii?Q?Ej96vhgoICjmiqGaNXKC1PVwD7N6Sddg4FSiLGLv85/HM9FCkp0rXveCZ2d/?=
 =?us-ascii?Q?fByxGwLUAlwn5zg1gtCbXwySRC+4FKStuoK5CSxS1Iun33HkskRkLezqq1+C?=
 =?us-ascii?Q?3SL/+cwJTb2SdN1vttH5FdhWsJ21hi9Qw0rHoS63/by0WxkKCnl/2eh1I3F1?=
 =?us-ascii?Q?lGLHuE8CtPaN5zVsXry8kjj89w5bf/cvPhq57+R/3gB2sqTvJCFWU5lw1JQa?=
 =?us-ascii?Q?wuwh4MBPEiYWR9D0/PDwdUl8KghbT1JI8ffteZhUy1u7bT6WhcT49xWED8He?=
 =?us-ascii?Q?MObPypD5amzNCll/ZqSED8V3p8oZJTwZOhN8p9Xi1yBmyNK6tyl6ULRMeFsZ?=
 =?us-ascii?Q?AfwPdhT/K1kRiYeXxNoRL+RQUksiqcAAkct/4nTrNiZ+SvxXB0WkW5jsasep?=
 =?us-ascii?Q?ki+jxHD5EJXymNVld21/zBg8p4v5Vg+1fKiutN2ukRatSpbrlnmdt8X+uDKN?=
 =?us-ascii?Q?tjju32PlRcDsh9QNY2JdN3bOL0k6S5jq+9fr3Tq3VtH0jNnZkYtUycTq2gvQ?=
 =?us-ascii?Q?8b0c/WzKzdWPh86vFK3XbiMGqAV5q7ij3hSqE0ngzpi8vF0j4dctI33FEY8c?=
 =?us-ascii?Q?tRsV13J/FyyUi5lZQCJ+03/UtQFr+bsBpNOCdbpat7E4l3u6p5kENPhqrfkn?=
 =?us-ascii?Q?HzA3ZxhsVlsEdkKuX60nmHu1ukPBA50LyWgB51st7XRYWs83Rc1hp+hEneFD?=
 =?us-ascii?Q?NtpmyalWS/sRMDKzo9iAq3fhvI1cxrh4GrJZD1JQXZzh/wJdka1mLlRWshWi?=
 =?us-ascii?Q?lQVPCSkHM5f9Q7xJryu/Iwjn5mRh6IMMV7LuW5/XEw9XCEtPisbNm+eOzZvU?=
 =?us-ascii?Q?A6KwRkST6jU8Sn+Hnh5AiHjOQfqG5GhD3veNn20XHu+IfRz1+ciN17lrrJP4?=
 =?us-ascii?Q?JwFMhf817t5L/eaSpZ16/sTmAqk17mgviFzUKduRwLMKpsf+HmziPC3uT3uB?=
 =?us-ascii?Q?e693gKdPwYx+7mRWhkEBvdjcGCoLSdSL33fXuoxk+UlC69S2OXheQhhOSjlu?=
 =?us-ascii?Q?9QIklbci7/+zkF9Y9maAaMtx3ca3RKkdngqmQQjBGa5dS+Er/4MFfLeCqlgQ?=
 =?us-ascii?Q?Ic+0hf3XC1Xxy3VaOMgvTztRWOsEuB+3Td00Wb+3215d06VZriXEcjiz+5VQ?=
 =?us-ascii?Q?iz4E+EarnV0STUWK+8EXUAd8G15/h7a7w2WbRaj7nlOcLb08mGYFWdvfmsyx?=
 =?us-ascii?Q?c4iFHl5nXlPiuOimP6PF8YV9pLKGn2XJzlomXhREdc/wwr9GHyLYhw38Nqbt?=
 =?us-ascii?Q?IRy/jQ8xQBUSwcJZJP1zSBPQ8Ij2/zvC7PKvcVv9HxSZUcnM2NUr9RqdvoPw?=
 =?us-ascii?Q?5LafZRoH/bu+MBscojo2FljN+Lcfzwa3Z+8A+fZttWSEAOHAurlwHHmQV1ck?=
 =?us-ascii?Q?8hjamiUvEC/eTUU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?db5L38X1yDrAoYlkLpXvRTRUgOiDI2aXhUt2Z8OV9mCevgcqV31LQDHlrsXI?=
 =?us-ascii?Q?6POjr5K0jhmMXINdtkHCPZLCqAQpEo1AH4DO6TMwMd47Rw/hE4xZXmjFhNp7?=
 =?us-ascii?Q?b3DZXBCWMapiwhywcNJ0Bfidiaz/W0TSUMlk3DwgVibagTlPnosqBvTvuUMb?=
 =?us-ascii?Q?9RB6jqy15U/gsvWmWRwIslUIKqlJAIdodqFk0nWgzpQywhU1mziTK+YBgbiI?=
 =?us-ascii?Q?CBJFwwlznnlHOPkEtSDBSRjSeJRMytc2Jq5HJ186pZzjvEkHCTmkn/yReivm?=
 =?us-ascii?Q?D0mjHiqnA7S6dXQGzFf2imtU/m9/WyASti13XUxq8/ZF6DG2qzWnL4U2MeYX?=
 =?us-ascii?Q?shADy7p5NRxArLCQcq3ZseF60mJBdJvnDt/s6lzyovHXICVIUpaostIpf6Ya?=
 =?us-ascii?Q?DkIhd5BeagBg2oKv6NhenY+WBd9waPF00Yt/9IyxtoRdv8/mmNxVg+NOWsED?=
 =?us-ascii?Q?5JyrBNKGK8kx893q1+kYl0iyV0Q00uo6h3zn6U7f/S4tEBoACsQ8ehJhQ1o/?=
 =?us-ascii?Q?sckvWuies+qWuCMWD8y5/qJq0ddNW6zF9ZEkzWBqSOM5egQA63+dn+iWO50z?=
 =?us-ascii?Q?hgXXwp+QNeoHr6NK2vs8MSgh3kp3mYfTYHKsx7F8ZYg8Ewdhve0QfUPr15s1?=
 =?us-ascii?Q?g4bTMqYX/pK0apd9094E/Uv3MIaIwprsncCv2IPW3r63VK/MxQqFZHoeBsiv?=
 =?us-ascii?Q?SZhla8njVQ+NvRQs8KDqoUpXhHWrgVm6hsfc+1WpqeFbYfj5xlwNlH6vNVPL?=
 =?us-ascii?Q?LF6hbiuxA6Zs7GyRnq4+s7WXDixJog2EEbweEIgzU8tlb9ZXaeL3js06dbWD?=
 =?us-ascii?Q?iSd0o24KGrmF9JfuiRpr7YsQmgZQyMbAW5/P6XJbUmgNfzPLwkmEjpKkbQYO?=
 =?us-ascii?Q?qfuGRn9UdMEVYa9zkR4mZYng3YcWtcBI490qJV+D1TrBwW5K9oc8hhLt6vPJ?=
 =?us-ascii?Q?nSR0GQdDmU7I1uRN+g4zkGztcIoth4ze4OW8w8vhvE5um6u6NJBm0umuNoHp?=
 =?us-ascii?Q?R5KbUM7PtooxA9E7JrkmpDhMt3Fu2BtwNF7+ug/OdbTabA4Mokv6XLsgWoVW?=
 =?us-ascii?Q?7XA7lsag1xqIbNQ14lyHIVFrI0WNhlgeQjZDLc3eKxfULrP1cs2ZaBQsUrRF?=
 =?us-ascii?Q?8G9FR7Q4eeRiMc8tlciJKqiatHnhS6+ymRE6nfJJNRaAySgAgYBxMwcnYv5I?=
 =?us-ascii?Q?ITEkkGUZvTkIYAa1GvnS+xTOdlbkOnsQA0o9ZWPKU5GHXGP0MNd9RzvXwW6S?=
 =?us-ascii?Q?q0pvJaeTe8oKVKLa1dV8eD9ieZSmVx6DhPF+mtMgUaCwbfTH2pL9qmVxOYxK?=
 =?us-ascii?Q?yJzP2cDk3yneagVaBrtQa9w77TgzJ9ZIVIHh1CmpaW1zJM0osdY/cmb6EAMV?=
 =?us-ascii?Q?85lvxLVJ0B3iB6BDy21Q6iedgkxMdBJ8WMmp4WsNkOQAoSqfpgaXWbuEgOb5?=
 =?us-ascii?Q?RemtgSAaDcoA2rKW2jtrBMPCy6iBt6ZeTrSRCQ7rg/Yzg7yCo5w3WPbDuhpw?=
 =?us-ascii?Q?zqplWnrFs6nv6GJwUX4vANq778IBmGPotg+bMYDQVSZAwkWkb6o00jQAjbIr?=
 =?us-ascii?Q?2pZERmwXp8LoC5T/yFMSszgjkYoSqXnWCZOZsPlx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e08adb24-a186-4623-fc53-08dd78021980
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 07:34:16.9290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wj8LZGMbtuhFZe1HBW+NWyRjY5OZP1qvldr6+4qIM9gxm1G9djBsXh9KUTnTKIBD40xOoBVpcb3MBogw8E2WYBNUuwMynxppeltPctZU548=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7767
X-Proofpoint-ORIG-GUID: j52aSXTiRpnBKm-ThkBpJsRwBmoTTELt
X-Authority-Analysis: v=2.4 cv=HIXDFptv c=1 sm=1 tr=0 ts=67f7747a cx=c_pps a=2UemalefZ2tksy65qfitKQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=qn7WcJB-aiKbXgfgM7oA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: j52aSXTiRpnBKm-ThkBpJsRwBmoTTELt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=841 suspectscore=0
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100055

Subject: [PATCH] usb: cdnsp: Fix issue with resuming from L1

In very rare cases after resuming controller from L1 to L0 it reads
registers before the clock has been enabled and as the result driver
reads incorrect value.
To fix this issue driver increases APB timeout value.

Probably this issue occurs only on Cadence platform but fix
should have no impact for other existing platforms.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-gadget.c | 22 ++++++++++++++++++++++
 drivers/usb/cdns3/cdnsp-gadget.h |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gad=
get.c
index 87f310841735..b12581b94567 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -139,6 +139,21 @@ static void cdnsp_clear_port_change_bit(struct cdnsp_d=
evice *pdev,
 	       (portsc & PORT_CHANGE_BITS), port_regs);
 }
=20
+static void cdnsp_set_apb_timeout_value(struct cdnsp_device *pdev)
+{
+	__le32 __iomem *reg;
+	void __iomem *base;
+	u32 offset =3D 0;
+	u32 val;
+
+	base =3D &pdev->cap_regs->hc_capbase;
+	offset =3D cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
+	reg =3D base + offset + REG_CHICKEN_BITS_3_OFFSET;
+
+	val  =3D le32_to_cpu(readl(reg));
+	writel(cpu_to_le32(CHICKEN_APB_TIMEOUT_SET(val)), reg);
+}
+
 static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
 {
 	__le32 __iomem *reg;
@@ -1798,6 +1813,13 @@ static int cdnsp_gen_setup(struct cdnsp_device *pdev=
)
 	pdev->hci_version =3D HC_VERSION(pdev->hcc_params);
 	pdev->hcc_params =3D readl(&pdev->cap_regs->hcc_params);
=20
+	/* In very rare cases after resuming controller from L1 to L0 it reads
+	 * registers before the clock has been enabled and as the result driver
+	 * reads incorrect value.
+	 * To fix this issue driver increases APB timeout value.
+	 */
+	cdnsp_set_apb_timeout_value(pdev);
+
 	cdnsp_get_rev_cap(pdev);
=20
 	/* Make sure the Device Controller is halted. */
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index 84887dfea763..a4d678fba005 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -520,6 +520,10 @@ struct cdnsp_rev_cap {
 #define REG_CHICKEN_BITS_2_OFFSET	0x48
 #define CHICKEN_XDMA_2_TP_CACHE_DIS	BIT(28)
=20
+#define REG_CHICKEN_BITS_3_OFFSET	0x4C
+#define CHICKEN_APB_TIMEOUT_VALUE	0x1C20
+#define CHICKEN_APB_TIMEOUT_SET(p) (((p) & ~GENMASK(21, 0)) | CHICKEN_APB_=
TIMEOUT_VALUE)
+
 /* XBUF Extended Capability ID. */
 #define XBUF_CAP_ID			0xCB
 #define XBUF_RX_TAG_MASK_0_OFFSET	0x1C
--=20
2.43.0


