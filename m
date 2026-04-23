Return-Path: <stable+bounces-240526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKsgHPBn6mkHzAIAu9opvQ
	(envelope-from <stable+bounces-240526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:41:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DFB45628E
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E617F30338A9
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783AC3AF65E;
	Thu, 23 Apr 2026 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="A5QTRhcM"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B0E3B0ACE;
	Thu, 23 Apr 2026 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969707; cv=fail; b=EgWUtI52HSanANVBR0zor9m3QvjZYEQs50F7/YtqIFYRxV81qZEos447MKCy43BMDBvGc+xbts5f2BPeGxvOTjJgqjTphkfJMvYUMolbxcCzX9mCcdRjS8ZAh4XlemfsDZaoUTn3aIPSQ9namVboBVurArNCXbXBqvHEtbp8OCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969707; c=relaxed/simple;
	bh=RX+8Q6SG5w5eqshg3KHTvLf3bL1vzcXWW1wanM373Vw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=icMfqNlPTJlGkJMcnpFmmrQwSdN/rBZyZuvutU0eag9u8ICq2HgZaUde7d8wET9ujfNtS4k/ascdeS9iKTd1KsNN0pV4Mo6cprio6OAPemYDA83O/QPI7MvsXM9vN75vtZkQ6E3xEv79fzyt0+rau/CZ5r8XVxAim/PDRkIMPgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=A5QTRhcM; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63ND2VuL2056368;
	Thu, 23 Apr 2026 18:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=RX
	+8Q6SG5w5eqshg3KHTvLf3bL1vzcXWW1wanM373Vw=; b=A5QTRhcM4fKqGN5hlc
	qfP6Fc0GbHAHdMIy6UPPf9hZO83ApUNPK7QNdOBNmpPnLByWUU5pwq59ZiAI1QK9
	btN5BOXX+CoPIKzuLg1QBvxvdL4hzXbKADP7Ac20T8JUwTDpT+O5I+K4dcvjsrml
	Bs1YnvR06pgvx+std0VE07QjWZ2f4qQrddtdPdAnfNbD3rRqar4kTY/zHEKYiyFP
	fy/ukcIRiLLrIDvagmZFj/DI06lCcfBarZ/X2Paf1qZ6lQ7UTOZgwL+l3NysGpEH
	EZAKCQoL4xfws0HX1b2ZxGu8hQ751VChGHmWEmmmtOBi+q0dF3vDAdAwfqRQaife
	Ic8A==
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4dqec2r6tg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 18:41:31 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 162DD801AF2;
	Thu, 23 Apr 2026 18:41:30 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Apr 2026 06:41:13 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 23 Apr 2026 06:41:13 -1200
Received: from DM2PR0701CU001.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Apr 2026 18:41:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xleOJcdw3JvO3NQ5oROFdSFvTc6GN+BJCw2i1VeiQ3qqNR8U3HJVfmeUZGti9fOUq8gPyunpeqfiZ8BkSNAJNo662lOUaDB/0rUy91eKcfrI6eOJqppoKxS8CMZ2dl0BgEBx8jRDT24/icJJzVxYn2rR75xo7vKTlN3h8Q94rwQO2ChpNk3SdbiUmIYkHy2vQqJE1SvIxyez/73g1ACiKudMVcxi83We5VMIUj1TQYg+yRuVGx5T6xShGmKCrHkjoFV9QdmB/W8w5PQc+q9RDGdBL+aDVRHtRiwWKtnVLl/n3Y7l52W4zomReG9Mjm5ffE1ZcAfLW7joxuG9cj+Gqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX+8Q6SG5w5eqshg3KHTvLf3bL1vzcXWW1wanM373Vw=;
 b=r2Xe0ezf3QDUtVyyi8DTnIcReNn+H/3Ag62YeUfG8h9bnPJjVaKXyZepYGnpLer4P132ILX2a9sRdwg8FKxvFoRDrdUHdw36/7ebt4WzsncduY2T1z645MF6pGrpgazKhYhPUP9+q2YnOoD7+EWUwMJgw8nBqjB/emJOxQIggrG+SgmVGqi1nji6iwKPbVpbaxhfpXvOm6H6exvtJPXpoOzqnJQ6KpH03JwBfIdy/0ligcvhXN/uHoGFR0eHRbtLl71MyDJFsMJjr1DlSDE3DwHeDB8qsgMxKOARZIf/jdx9ZpFxcRlbn+kiHlfmSndi/MjGvYIpJgn3GqR4h9ezVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:203::11)
 by SJ0PR84MB1918.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 18:41:11 +0000
Received: from LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6]) by LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::fce6:5af1:e04e:caf6%4]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 18:41:10 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>
Subject: Re: [PATCH] intel_th: msu-sink: Fix coherent buffer leak on partial
 allocation failure
Thread-Topic: [PATCH] intel_th: msu-sink: Fix coherent buffer leak on partial
 allocation failure
Thread-Index: AQHcxe7Ti8Oqvr5I6UyUHvvGnHl8gLXtFZmA
Date: Thu, 23 Apr 2026 18:41:10 +0000
Message-ID: <20260423184101.158045-1-sanman.pradhan@hpe.com>
References: <20260406175714.208227-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260406175714.208227-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR84MB3535:EE_|SJ0PR84MB1918:EE_
x-ms-office365-filtering-correlation-id: 66888e7f-505c-4311-4bc5-08dea167e38e
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: fgXVWk/JOFkqgKiRahLqsirhgplkgek57viELPHtXVEfKEFTBIPSOkgDGoywE7c5ITV7w4BTAgeeX9h8PRbLn5v+suycnWeYWyUSUpCFXkxrQ4f1rzfPvjAGVHZg0qMucN/qzvAfUR1wvWBhgTdU7jJlT8otRnTpxryh1UDw8u536AAYcZI7sPEx3fp1nbhYkefHkz9q/APb5DMDENW48N7fD5kbVZmJwNhHwNcfhEHDW/fHjREjiwjqNG379tvrGg6dDkOU5fYcI6E+Cfwdu2m51otY/VoPzBz28B3gss5FPKAIyFHqlRToGEbewwJvJ6wlg9/IShpvxvnAnXbXNjzCYWGtvu8aiLGH7QPX6q5KdIk00TkCxKb5BLt1kZSRpIiSEvRbRUQ0iAcoC+XInV4r7viB6Rz293R2uqIncIp9C3Z7M9AWocyFhfnuwwAkH5I/KL8I7AhKFOWDUhnpodUjVRAXmbkXvRTWOzqW26Pj3kALOlz/Nd4V2P4PHKOS10YxPCjdCO8MnpU+UM2eUyVk2Pfhd2Eqqavoc8uCACoTgwPWiU3TnrVMNGkw5GlE9xOgEZcP+axZbOggncY7B82z3GofUGQJIHmgsUb2UvVHIwG+MCYuhYhp/TWQ1a7mUD8Ozgp9ryzPcLe3wn8WxO/1I1Xr/rI/HcgagP5J8RadwyOXa+oCrBOUQnxKR1gYSNUfSDSci81gYSD9hR6uwWO2rWTturqG3dHJ+1wUwvw+SQyExvvjHCQQkEdTee9NmE3wlaUswdalsXUePDEsbFDLy6uuxrFuPIM5I9rMH+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7TlaMaoDbD0TTETVkI0pXlpwEjXyCGRj/SJ3u5CnnzA+qI1M16g2u+JRQn?=
 =?iso-8859-1?Q?7ECh8yg5R5sr4Tjy6nEMPGYWGHEle1Wj8aEJK4wuUmS+WBSjzKb2FuGZEn?=
 =?iso-8859-1?Q?lzZ+fv2D9baLUizwmV+13bXAeCMgfGUiLFgiRjTfpRjc/iIl7H3PYNaPcR?=
 =?iso-8859-1?Q?gmER167PfyrQfZC420JTwcmDm0MYlHjk6lRJ+Z9qVoBj0BoRvAH3FL2vBa?=
 =?iso-8859-1?Q?v9+GbVOiazFYuhB/MUQA+KIIO3k5Ats6rEhejFdLtZvnE3MDUGteXlJy/d?=
 =?iso-8859-1?Q?AxYILdyfK9FfP1Dhz9T9onk5B2wUznWk9bVcqLlgoivikXPDGQiQIELqah?=
 =?iso-8859-1?Q?48rAuxMHvClHo0HvS1e1pEZHqEYR663JpWwipIl+IVi4OfpqUOZA2H2aPa?=
 =?iso-8859-1?Q?3qkDIRgCOtttVYqo/t9IL5oV0fqfmAzRG3DaY60Ige8CwNKAnxeSco7TYg?=
 =?iso-8859-1?Q?hHeQQV6rxaAbgN+CPhPhSFe5tiSQ7tQEqIAOlVvU/sMPfXOeAtdI0p3eS9?=
 =?iso-8859-1?Q?hhN6sPlJ1M8kRub615fCFyJ0/lfQeSiFxNcdLxiwBlxOSVGuG+j6tPdFzS?=
 =?iso-8859-1?Q?ot4ss2qpK3Cqh46Uo4uVXM8ItfLQdex9AK7QN10pncFRzPvOmTUiwxYMdd?=
 =?iso-8859-1?Q?4/lh0brP4fMk3rmmvlNjxs0XXdMN2FigZqpeBIf51Gs96vpHpM3pokgQPu?=
 =?iso-8859-1?Q?x84vc1HUwl2gPlSJd/C4YiTOybm1SEnogBBh24JW80ZRiMBIJ+GTQXVDB/?=
 =?iso-8859-1?Q?DYr8Zq8G0yLun6sYMLQgSbDLFbovkGC5qiWzKoAH73Ty55Lw28ZfhawvHl?=
 =?iso-8859-1?Q?TMEGLofOqU9O3mCM7KUS9LMgHLTWwUyAGPNt6PRs3nPjmRRx/B0YVbZZ5f?=
 =?iso-8859-1?Q?vjoLMjDlgcQbT3TKk8yxTnEzWC4JThTNmiQu6Lv9+RTNn1k9JAb0kxATJY?=
 =?iso-8859-1?Q?HOwv57l9UQAUxgeNjAbE8VGeFNWzuzyFnoKeBpV975jlFmmzcaOMx3t57v?=
 =?iso-8859-1?Q?2j70ibQjHbU2w3Zq0OemuEFz3SBoDwuiMkExgugAAbxh8bJzalAys9Wqe8?=
 =?iso-8859-1?Q?no5FRHlCf8SYrCSGXA6AZy9Gt/5xCJyVWhuFiDuJcyNOwOiOUOehNlOKtm?=
 =?iso-8859-1?Q?mKtDGwUFPEv5XGq2Ygf+0CjF01640JD1bN4ctsZDpAUOOZJMBbIZLXx+2i?=
 =?iso-8859-1?Q?fR7Kx/QfEqF2S64b0DwpjUZVxZkXRYAVTm0yN/6l2GhNFAeTudWHms9r39?=
 =?iso-8859-1?Q?TzMr60uQegU+ZUdrivkJW6VNlUEG9jMzDZjY/7yjNiQDBDnaDmWTFe5NSI?=
 =?iso-8859-1?Q?3uPRY1d6ym5oBNvK08lb36MKGOHfcg3UdcpXzf7smnDr7kTheAcGp1XFwv?=
 =?iso-8859-1?Q?R5nKwuM1AFOc4IYjTD1RHkVB3W7D47JnDNyLiUDgZF7AiyYvgnd+cZ1Wq3?=
 =?iso-8859-1?Q?uxMCUAEmjPSwBKseymFOlSY3k39HFNDx379UnVceb6Coan2p7QKwehqkAU?=
 =?iso-8859-1?Q?AwGffDfjWKns6neN8epWRGMStLJTvr1zXfsL5lh9lWVFPSl0VmQVt0Em55?=
 =?iso-8859-1?Q?pRrM5rrmntm4uvQBFOfdHAaeV7FHMN3dq2AlSUjzFdDO1SPO/sNm6lBGvT?=
 =?iso-8859-1?Q?HwWHzjvZkHRk/UtnutJbnv+xNNV10q7gFRpnXt5pEd/PW2lnhCmQKxZjnc?=
 =?iso-8859-1?Q?Yk+FxZddqOMEiO4mF16L5XbF/DZnrta5Xp6O2Bw+4seKGca0vN3b4oeNxQ?=
 =?iso-8859-1?Q?0iXbWF22TqfnkaoZ7pHM7Ku8e8kvj0lFa2A8h6GHkStcSN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DBM0wqwNMokJXw4lzDR1YOGf4uoIxyujgaZ9ll9pom28Dwdt2rlNABK20fVi9mGbgfMvAvc1boEDsO0Lyw30DJ8Kg0v0O7fLHPV6k4843rKe/6n1uBc1n5WTZ98Wb8yFbfMZRVQICCc9tRiwPkdzauPv7hNLb6cL8L3oWgH8Z0ejzLhmggXmbZrZwWnn/J1HBQkpAraetJKf89FBECd7BWX8Wdy/RDNSLpVbp5cqwqiME6p1H7LTWh3ayDllkFsOHIZ2Z9tzJnxySqPaGgFEy135sy2zBAqZNi9Ov3BQ6aC+O3H/xcHcV1RgYpkgumazE3OFqcN7VRaSV9b600LIyg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR84MB3535.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66888e7f-505c-4311-4bc5-08dea167e38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 18:41:10.4524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ULHWmAvZp0IVKxUXt0WYu2n8lgoj70Zr1absgWJxyNWW2R2XYEO1LaouK+ucmAtG7TRmTut0BHvXiO7Qms3Mag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1918
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: T37PhohRYSx7P-qOfxthUe6vjrF6flWV
X-Proofpoint-ORIG-GUID: T37PhohRYSx7P-qOfxthUe6vjrF6flWV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE4MiBTYWx0ZWRfX4BlhzzR/kNST
 RudWyEraEp01l/9lZk3CzEsmxYajVu9DuSViBKMSa/Nyi+fspLfg6ViF5urJZc+9tDjl51i9Pu9
 Nd6av/l4awciYjC23CZ32ikus+XsQINKj1B5vo53sDnXWVqXYtGorXgbNEI2cMPzTZodNxpwTX2
 cJBFr8ZFHkPdLh8imznJDa8MYgBqpzQRNBD2+ZuE46taE1ZeYR97ban7eDpBdtem7hVLC9y8Tk7
 HNL2ZGUhCWTlzGeBYxtosi0J/wOYFFYCiB9EbkdPYdBJFdPKQOs29nQagO9hZiOhv7s7lnKl7Rg
 V27rDBZsKPcGqZdjhcve0svQvO8H8qUdRmxpzyIslKio8LKIVs6FUw+Iht/TTtv7vU03LYO5F/W
 JD7flhBCUo5qE8X99dwcL/WtjgLzDx/V9RxtRtMQyKJeEkY2T/R0j4lCR4D5QtGVwvAaXxtiQfS
 1Ht+DzLrb0RqjhrXZeQ==
X-Authority-Analysis: v=2.4 cv=dcGwG3Xe c=1 sm=1 tr=0 ts=69ea67db cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=g3u0LPWLDYfGfufhFw6-:22
 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=OUXY8nFuAAAA:8 a=2_KcmLF6-GlNZb7Nng8A:9
 a=wPNLvfGTeEIA:10 a=q5mp2vxMLvQA:10 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230182
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240526-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 85DFB45628E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
Ping. Kindly requesting a review when you get a chance.=0A=
=0A=
https://lore.kernel.org/lkml/20260406175714.208227-1-sanman.pradhan@hpe.com=
/=0A=
=0A=
Regards,=0A=
Sanman Pradhan=0A=

