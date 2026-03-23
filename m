Return-Path: <stable+bounces-229970-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM0SDYGAwWl2TgQAu9opvQ
	(envelope-from <stable+bounces-229970-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:03:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200C2FAD3F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AC1F3635B56
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8973C060D;
	Mon, 23 Mar 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="lFZ0LcK0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57C3B9DA5;
	Mon, 23 Mar 2026 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283768; cv=fail; b=Cs8/zg74GoPYAb7jc4+/+bUmQNiJ6r7mL2yMF76u/sTUvBEuz/+D9OeR4jCNLAzWtpvvCKC7e5k8vmxGp+8Vr7UGYvVqpSL5DIE2ntLdOHu9Nd1E9nffquDpAHROcxn6LPOVifXHFt39Y8yNSsyb27A7BJQOf5WDPfzOUhc3po8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283768; c=relaxed/simple;
	bh=ueq744gXwBAlEmfr2g6Sfwduq9vaD8rICAI6HHx2HSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1QYRuKLRa5jrZK/WpzTxSHRz70yE672GVlpE+RzlcKCuMhmCS4ViF699CQF+yWsBhqh59ILqybnuDx+XCSWcU87WTgH/uaDKphFfL/PKP6WyOonMFLz8u1bCtLjHAxTge75PNQKFiWk9TskvYWcKubfl1TftOwa/q4aF5Sze2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=lFZ0LcK0; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NGX9pL2896540;
	Mon, 23 Mar 2026 16:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=tK
	QpusM7YEjdVOQ6Wp+tE1ffBnIbM0UdY/ZbgKwY8FY=; b=lFZ0LcK0GomGl/iBcH
	0XuyyAaH9y8GTdx9E6wWVBZeTIJG0wfyC2uA6l2xDYSFaL7+N4zPQQwUSp7OhqkY
	RjnRF/y8dQHPUT1/QLbgdriDmxE5uWvV85VsWeiwHBgIH+GEkXJ+CbsmZGIjJDMM
	0aJ8MsN9tCkynLjbB8wqhwAacqzobE0UNxIXBPPFasJ/fBlCVykFqPf6GpXAutjs
	kgOkEW+f6RmmGgco4POx0nCPNAKIBy8eQu2bEMpfZ6aQI6EjuA8hUU7M2uRED/oE
	gCPcEL54uc68mNdjZ/AJ9EYj3KJt7IclcEna00INRXCXSfoNG2tPSsiil3h5l0hj
	Wb/w==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4d31arxh3a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 16:35:51 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 3A775295F9;
	Mon, 23 Mar 2026 16:35:50 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 04:35:42 -1200
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 04:35:41 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 04:35:41 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.38) by
 edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:35:35 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrZfkHFD1KVYpBqB4QdHTOjfy7k1fcRpRwYUHmMs+EQ3JaYuakJW9qmnlCxjYNUC7u8Mn81ioeu2irhskfSjWSh7zDtcYpRiiit3fllnT1bbrH7RQS4Gso5yB9y+V00IcefnD7lL6NgL2xVLMH44VbJQ7kCgv6ZEEHeI2WdTck8lrC2YF/nMbSFG6rZfGWUOXsySMH5n7oU8nXxCOnG80/qqAckPs0LwIBnGlT8x1yazRIdQuvQ6k+F/YIEF/Jq+I1hZt1ns1Cfc+XPTbcq6t2/FLbhZOnMT7mEh32/WMYhERV9qNEfb+u9lxHN940KhtvDTcnyM0jSkVZHTpTrJrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKQpusM7YEjdVOQ6Wp+tE1ffBnIbM0UdY/ZbgKwY8FY=;
 b=QML39krw48hCMzVTWJxbVKeATsmeKeD700uRyQmpNpsmrZr0WAmY2CP9XiK4vPmnSbcuTk2dVnYsR3l1x9ORhvqYE/IZvirPRm4jvUK9XZ5D3abr3gp5eEjyW7SR0BKXgP5pEkVjfZxubnIv78IlC98FPVGbJyj0Qx8bK5j8U/65oHcMkgDgFJIXm9eK562zE4M887RK01zb7o5qyBLzxs0JXYSpY+GhfH+jCcOWiwAvf5B7jdS/QTpxQEaOqN0DdO6KpJQIFHTpJoj3KuYMNpKoXwhbrVKul99iPwTpyelBZfa81qJZ5YeoXgvlXAj+ICY0ljLdYkMbSNvxgWJOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by LV3PR84MB3819.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 16:35:33 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 16:35:33 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "wenswang@yeah.net"
	<wenswang@yeah.net>,
        "chou.cosmo@gmail.com" <chou.cosmo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 5/5] hwmon: (pmbus/mp29502) Prevent division by zero from
 hardware register
Thread-Topic: [PATCH 5/5] hwmon: (pmbus/mp29502) Prevent division by zero from
 hardware register
Thread-Index: AQHcuuMRWhDKDR0640+5hvolKJhuMA==
Date: Mon, 23 Mar 2026 16:35:33 +0000
Message-ID: <20260323163343.183186-6-sanman.pradhan@hpe.com>
References: <20260323163343.183186-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260323163343.183186-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|LV3PR84MB3819:EE_
x-ms-office365-filtering-correlation-id: e9174a3f-0e75-4149-1a7a-08de88fa3450
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: UtjrBEKNUFMrL7pziQUdPP/K/h5zrIIk7jckyExSZjxgKWWBLOBJQZNwZ4/qkrpidyGP9fgZL/xun3lrFmpVJRwaKEODkGcEPbcnbVBVbatsD7PeY/KX9+RskEOz2Dk5SOs4/DUD2JeATw055qvBeFi1pYcxDJEdubp7rNU2s/BDCpLpnvY4HJ902WJm9fsMQrv21RegIRVM5h1EvFr3Xb9p+SjTpvy5n9W54VN4lnRDiJh5Dy0m91xdQj/DfqQpjuBRSBlgzDhouyZY+PJJvbSm0nX7aOze8DdjCOTFQtXxYfjAosjCDSPVtqn6NxgaGSwOL56whcWcl5+tgho3DjgMQXHya5BiFFav6q7TfDR93Yg5vpLh1rCdaYGtbo1+4+DYxn5R2vpNSIRYkLWVZkAbs4S1/Ioa/ZYCqy4mktCHqE7eVKsd1qVSW9TvrIkutiD4sUA01o5DG2RiJ/Q9V9Z6chDnOz6LNASSwAobm/bZ45A3lKZJynU04eX32qQJiFgiler2CZB8XrlKcfy0TzYzs+8eAq+0iCA4S3O5Xxry9BcjVecFJaQE+5AAhuquED4r8YMaEWrWef3kJMR9O8RkfN5eWs3MnbK1ZfWq01UZHNvz3lGmmUgBxDBpDPjQ+f57jcjDKPNEq3/KDtLZGK/KEElwcaW0xkR0j4lFnqd4D9MxuZ7KGjEQ9QrVERi5JNWT4a54Cp0H9lG2Oolq9hG26oeoABkkV6z/BcpMQRe2cCqc+OWCE49iIp9gYIO/KMZHBSOawi1cFC3R+k3Bhr9ZritYWx2zXk3j50RjCrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ms5UVrwqh12o5zN/8dt0TA8EtGhk8b+LHtzIcehxWddmHqhWA3WeS941Yy?=
 =?iso-8859-1?Q?tiTS12/df4DpeeMgv+LYB1BbetbNo+umr190oF7c5wupcZDvTp9iegolPm?=
 =?iso-8859-1?Q?MuSpJ7HbI5PIkU8GNaunav4bcRSAcO+j80mBX9c3rjgGF7BLTTnNoEugqF?=
 =?iso-8859-1?Q?P+HiKcffTDGXB0aPKHZwTG23EOXGi3ueSUOpSNdCj6auJtMPBzsZZwAlcA?=
 =?iso-8859-1?Q?A1Ejc4WBLdrIfHXFwevLrVi5qPwb6ESx4iS/6nnljQP0she/1P87aHDIdk?=
 =?iso-8859-1?Q?FlxMbLRvilO8JH9UzKugS/wnqntTt13m5NGQwV4GDlKaVzr2gEmgI8djUQ?=
 =?iso-8859-1?Q?6tYOoRD6/UBQrdaChuqUhL5HNVB16bt7lFV5X/fEkgGGcubWrwko5HHIrQ?=
 =?iso-8859-1?Q?37WXpkIy33v5DOJwOM3CjH39dePqZsH6WFXerpfxnXDHIt7O3RuCnbvGlB?=
 =?iso-8859-1?Q?Ue43KCtGMcoDwSDiNNbaXxjOljwdY3NVoSsvRrUaVYffHvSVyB+l2RIpUa?=
 =?iso-8859-1?Q?v2MsBDnA33zwA9KzWW2BLMIouw9YnAt/W/3aZX76qLeNvfHINNp+7n83n8?=
 =?iso-8859-1?Q?QsmCGvyQSZxcZRKvzlx5vW6JYgqE3sVDu/oPa+T7b0oZ09MZOsQmT9MnOI?=
 =?iso-8859-1?Q?pE6OuFOT4ns89fUwwQv//bzsgkfMkDmOFX8Qm8DsCW2NSoZz+g2tYy1D/H?=
 =?iso-8859-1?Q?VSzoIhvYw1Jyg4h9DawLySXP+ZDqqJ8Z7341d+zriDtSlJMNriyj75Bk0j?=
 =?iso-8859-1?Q?oAvuJeqnj3b4U3jHzEADkb6CzHydd5IUHXBYMj6dZKIeHJQgfuxHU/rIag?=
 =?iso-8859-1?Q?74DMP7M+RQHEi7K5eBqckBvhJX+VarmXRMUmXM1HVMvNjZyE5wh2Zn3fHx?=
 =?iso-8859-1?Q?HHqnxXkVxQ72uZGCe2StmT5/efV15Gk4hZPQnPLgULPHqsJJr1q+/3A7xf?=
 =?iso-8859-1?Q?A1OiKyhp7Ng2/2Z30MI07WezAiaKv7U3KKmf0aWMvJDfCDlqVVl0y7ZIAY?=
 =?iso-8859-1?Q?1JlpFv1E3iBjhYcJd67gkUH36zwHjk7WSVAfyNqlIwVV/+dTZ9bBkHxNyb?=
 =?iso-8859-1?Q?jefs2njbg6FiIO35zueqlUNPT5GAXP/g1AkqOP6kUzMduJHWoW37NHHwJ2?=
 =?iso-8859-1?Q?/33GmCfGlrD2/1StJAcLbQdQrmx3qNbnLeOSLXp6LZT1U8macDDxMF1UFM?=
 =?iso-8859-1?Q?DqGPinQlDRq+Arfc+YEMsdev2r5fU9ttl/DyzShAX2UiBld15ehD5NIap7?=
 =?iso-8859-1?Q?Bc2viVE1xmF0AyFvfLk7nAL5NFCtvaz9GApZkiycBnNFEzC048tb8z8qNI?=
 =?iso-8859-1?Q?oKgUH8bpqtcqurBVPwc+RoFSUlY34tatcr8WqurqvbZMxlfn2Z8stP7E5P?=
 =?iso-8859-1?Q?4rFrhSUuCXq7QGPdg4FUjwRXU6OzTnv1r1bWmoXchXaJBdJSk89rDeWjh/?=
 =?iso-8859-1?Q?cYrNPcdK8wVY9AGp+JWRQkulqkOBDyY/KkGj7lhxjOW+tWyHI43IF4nYYY?=
 =?iso-8859-1?Q?RZBdD49V6VkU30eI7zFBFZKqA+UyYtemVtbp4fBS553SilGDHXl2kbgPgW?=
 =?iso-8859-1?Q?NZ4lcBsvyatdv5mWTAZ2lShDbDTsS0RNQ16PEY8BI0emQSOloDBLtW6o7N?=
 =?iso-8859-1?Q?e4yxEDUyHWERR9lEJyuZEAUJzxsGwSktHCKOfbOmhYwkPL0XFim/XCigx6?=
 =?iso-8859-1?Q?Tub0B7bcyDOONpqnzOHj+UfEXsdvNyM0SAHyL2IMvLXQ2fPhdq/g+nczZG?=
 =?iso-8859-1?Q?ILy4Iros3H9/qFEpNSfMrqKAHvj9OhMACNvyG92hDVmfeP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: t+jsNGXP0JCNzhazOhqxEXpSe+BbMYOzJJ6G+PyoMjahxu1XvZyRXj43TOAW66IgczYEqNZcTiRvBE7Rr8tLKfPNDxYz6lI9Fi84g/cvFoieaiy8Ib6LVrsXBaMxAttQPVEqPNtTuzrIYUAQfOOpkgKDinAJAMyyq4KhIg+GiorTkFmAZRnSirS0qYNyLFi1g+7LplflWDH31Po/hrw240XBFJcR1Cz+UHDR9Jlc9NdU3W91fGatrXiPwSlpl/OfHg2P8Yz0ci6njve+gg1BmWcIRyaRTNNniTDDr+CWBA+fHFhdzc2V1q+gLZ+3FstJNcq9sKMURrG76wt3L8x1sg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9174a3f-0e75-4149-1a7a-08de88fa3450
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 16:35:33.3637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+4OsPqdE2utz55ApkhmdnxzAbGw/MN8Xlaa6mmvfxgeyBMNdIvpFKNMmTxUlJhXcQOm0NjWWNc5gY8e5yFyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR84MB3819
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: uJpN1u3-Lo7Id9R0jNH1SksZlz8vFq2d
X-Authority-Analysis: v=2.4 cv=IcyKmGqa c=1 sm=1 tr=0 ts=69c16be7 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=6XKncaru_qjgLvANlS_8:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=oWjv0WD8qUs_733JoPwA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNCBTYWx0ZWRfX3s+1NgsQp6x4
 kARb77MSKOV9ZN632u+4hjzQGncEy2KzAakyN5xuT3yG+XgrHImhwd5YRxOVKnA8QWQ4Cq+7Yra
 +pe6nuctTO0mE/2AWrkWJXvJLPPNgJhPeqPh644wMy/+fUDsdCxSt5Rwq54b8gd7nv/+Tt6bTFW
 cyJL0n/mza5hmmiupHvSY4lRk+FRuVit6KHHlIK0wxWmjyQnSDUsdBQhyG5GnrWSoYoRj12VkIf
 8NR5znFXBlQjZsyXbDAdpyXjHK07LdZipDeg8zUbIW5XohJxB3+GdxpeU4K2cEQS9uX9y1WOpWd
 wbX3tUKTQt+7VSeoTMJwkDniN16DsTtFc6rxQWGlRZE32zOCgOkvVHZM/4Adk0ltUAEQYlghYXZ
 Qvre12xecREfAJpfHOgAsHgigAq7jAyUgzMpmWHGv4j2IqccVDh7/4MjoWImMscRVXXgiVE8mCk
 235NGqJIex71XCVPjfA==
X-Proofpoint-GUID: uJpN1u3-Lo7Id9R0jNH1SksZlz8vFq2d
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230124
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229970-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[roeck-us.net,yeah.net,gmail.com,vger.kernel.org,juniper.net];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hpe.com:dkim,hpe.com:mid]
X-Rspamd-Queue-Id: 8200C2FAD3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
mp29502_identify_vout_divider() and mp29502_identify_ovp_divider() read=0A=
divider values from hardware registers (MFR_VOUT_PROT1 bits [11:0] and=0A=
MFR_SLOPE_CNT_SET bits [9:0]) into data->vout_bottom_div and=0A=
data->ovp_div respectively. These divisors are used in=0A=
DIV_ROUND_CLOSEST() calculations across multiple read and write paths:=0A=
vout_bottom_div feeds the PMBUS_READ_VOUT, PMBUS_READ_POUT, and=0A=
PMBUS_VOUT_UV_FAULT_LIMIT handlers in addition to the OV-limit helpers,=0A=
while ovp_div is used in mp29502_read_vout_ov_limit() and=0A=
mp29502_write_vout_ov_limit(). If the hardware returns zero for either=0A=
field, a division-by-zero exception occurs at runtime.=0A=
=0A=
Add zero-value guards that return -EINVAL when a divisor is zero,=0A=
indicating the hardware returned an invalid configuration. This causes=0A=
probe to fail gracefully rather than crashing with a divide exception.=0A=
=0A=
Fixes: 90bad684e9ac ("hwmon: add MP29502 driver")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/mp29502.c | 4 ++++=0A=
 1 file changed, 4 insertions(+)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp29502.c b/drivers/hwmon/pmbus/mp29502.c=
=0A=
index aef9d957bdf1..bbcf018e5d05 100644=0A=
--- a/drivers/hwmon/pmbus/mp29502.c=0A=
+++ b/drivers/hwmon/pmbus/mp29502.c=0A=
@@ -134,6 +134,8 @@ mp29502_identify_vout_divider(struct i2c_client *client=
, struct pmbus_driver_inf=0A=
 		return ret;=0A=
 =0A=
 	data->vout_bottom_div =3D FIELD_GET(GENMASK(11, 0), ret);=0A=
+	if (!data->vout_bottom_div)=0A=
+		return -EINVAL;=0A=
 =0A=
 	ret =3D i2c_smbus_read_word_data(client, MFR_VOUT_PROT2);=0A=
 	if (ret < 0)=0A=
@@ -160,6 +162,8 @@ mp29502_identify_ovp_divider(struct i2c_client *client,=
 struct pmbus_driver_info=0A=
 		return ret;=0A=
 =0A=
 	data->ovp_div =3D FIELD_GET(GENMASK(9, 0), ret);=0A=
+	if (!data->ovp_div)=0A=
+		return -EINVAL;=0A=
 =0A=
 	return 0;=0A=
 }=0A=
-- =0A=
2.34.1=0A=
=0A=

