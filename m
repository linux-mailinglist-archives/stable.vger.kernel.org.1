Return-Path: <stable+bounces-226879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPQvOWCSuWl3KgIAu9opvQ
	(envelope-from <stable+bounces-226879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:41:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFCD2AFFFF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6195F3086C41
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDDA37B005;
	Tue, 17 Mar 2026 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QSJLl8uX"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7037C106;
	Tue, 17 Mar 2026 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.143.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769073; cv=fail; b=bgGFpAChhtBEBqGLLOik02LrNLzkx11GIW8pTfK2ThYZiQVgWVWp5JDfMnUSpM+ij+65X4nB+giBmCcuWcuGty8D9JZdFpefaKMEuZzpRywWqtgYmW7gaLZrBdhkYd3HR9nM7TV2GI2y5Umtzno/x98vcP/vLctNDrgzc9QSw6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769073; c=relaxed/simple;
	bh=sFnGZDE2JjJSYYD24qNPzE3SyDGlUtl1vzYobXZYfA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAeIQcF/U6O/cRTHKB9g3cYwmHXm2ZbbTnJ+Pr17FymeXVFqX9+jdE8GVPy39UKPrfEX+vwJ6z6HBBh8/VEFEPG7rMf3sT6YTzY0ASfk/VoVCp5ZIuHQWe6jp4qnbBn4Frr50wt6wLH7sOrx49n/mAd7RNSMKelkF1z8KznqM1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QSJLl8uX; arc=fail smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HGxIN91919998;
	Tue, 17 Mar 2026 17:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=q8
	z2fw9K/+MqImu18RVjZQz8rJEN4eytNXwFjw7TKZc=; b=QSJLl8uXBmrxTZVicy
	Zt+YKtDG9cdkS1zylkQX/13nc7f/oA8RDHjmMUUUGpmYEy3uJrGYKfRHuD2z02jU
	Yl2PDtuhl4SPnKnZ5zW9oNJpfLKAGYb4LLHp59skoeztgPKNHbqgrX/+jT6KWWIV
	dPxCKN4ToQtZRAaDw8Ey+9DWFf4baPptYhWRTOvqRtElQwrN6FnDoudoar20m6uK
	9gGl2T0b1yWihwJtXWPnyE+Uqxmil6K5zPTCowG5vSUNajmcQkX5f2gONYPqhfL7
	vFXG0WuojpK6bqYwvHZhgkLbqA/XzsnHRJLau69CUET2U4MbwciAJAruZ4F5v+CS
	iGwA==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cy85yk3wa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 17:37:29 +0000 (GMT)
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 5139A295C6;
	Tue, 17 Mar 2026 17:37:28 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 17 Mar 2026 05:37:21 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 17 Mar 2026 05:37:21 -1200
Received: from BN1PR07CU003.outbound.protection.outlook.com (192.58.206.35) by
 edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 05:37:20 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWbkekzzfpyxV8Szb9aMysEuD23ElZctCbG+ODp/bVhkLd6ygO8xvTpegxEZchHX/duVZA33TWBfV5zKIAFI4i0I/RPpr5czk/eLAjRsLTZPI4okqFkhYOcqPn0nWnaBlWECjCM4nqYemPk94F1EF9KEUJHmo/vbK7FWkj3nDGFlnRyyAIv5Zf/A8Eh6MhOstPts4/Lo4r/ZF80iFlLh75npHqB/xP4d9Bvm4QCg6DRy6yFLFoad3MrlhmHRSLjTomtiZsozlpg0FWcFSeMBMSNTZ/ZeCMXT611ee/meFnqTk8hL38szlJtjZkqDW690+6JHaxVq157hNBXznG2X0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8z2fw9K/+MqImu18RVjZQz8rJEN4eytNXwFjw7TKZc=;
 b=s6XqlNiFyLzofkTYGwFOZUHaMVh4UGJwDBxGSeMSEg8jd4pDPXHxq9604mi4jQrjOTgUQhfpCl64KFrSRrxHvGUdl02FFoSkpxL+PHa6UBfnYUGoiY7hzz0qsg7x9BE0NBrtsJ0ahu2x+ErrBBhOGhTFpmfVEfE9Zd+kXgozNIPI6AVZ6JLPbYJ2uZehUSobGyA9hscGDFkb18/4LBlBpSrsBt63NbYsXG7exmyASpnslXCLLQPU1OKI30JkAU+t9Ut+5Fa3lpeeeOpZ2sWb84KwbxoEwblCik9BNlOBAGHiSVKVU737/b40ebINnsPFuJwdRor9cAoJNltj6jWTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1cc::7)
 by SJ0PR84MB1579.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Tue, 17 Mar
 2026 17:37:17 +0000
Received: from CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f]) by CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2c54:3534:122f:e74f%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 17:37:17 +0000
From: "Pradhan, Sanman" <sanman.pradhan@hpe.com>
To: "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>,
        "vasileios.amoiridis@cern.ch"
	<vasileios.amoiridis@cern.ch>,
        "leo.yang.sy0@gmail.com"
	<leo.yang.sy0@gmail.com>,
        "wensheng@yeah.net" <wensheng@yeah.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sanman Pradhan
	<psanman@juniper.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH 2/5] hwmon: (pmbus/mp2975) Add error check for
 pmbus_read_word_data() return value
Thread-Topic: [PATCH 2/5] hwmon: (pmbus/mp2975) Add error check for
 pmbus_read_word_data() return value
Thread-Index: AQHctjSzXIVxk2f4B0ywXSXOJzgdvQ==
Date: Tue, 17 Mar 2026 17:37:17 +0000
Message-ID: <20260317173308.382545-3-sanman.pradhan@hpe.com>
References: <20260317173308.382545-1-sanman.pradhan@hpe.com>
In-Reply-To: <20260317173308.382545-1-sanman.pradhan@hpe.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR84MB3523:EE_|SJ0PR84MB1579:EE_
x-ms-office365-filtering-correlation-id: a8a80835-0ccd-480b-9daa-08de844bd596
x-ld-processed: 105b2061-b669-4b31-92ac-24d304d195dc,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: jMUVxIB/1Ds1mR5Z6V6hJ+EzZq+Bbp1pDlne+gQsLEAZllQ+1EeDimT/78cUBo/i4eWSeFA05QmH1B24uNtbe/SxAsUIxtcGDoNM30Tcqb0B9QopXIoyOGPlAssKouzp1w1nuv/TOCLZPqDAKGFTLDKSJh1axlnAVgmJvWQjtDkFRPLiPhLSUbxoztJbgNNAzN9Uqd3TVzg6FIvrf1FTlGYpFbI+SdHwcKbzdvyCrd6/InLThNm0DYb2k/lvF4RGNSsVFkvKzv8ZOc9JQrBa2EExwVW8zZGA4XMKT8t5V1baKlE3z6NIlnhxYFzcFEGtaIr3P2n7gHS+AWTKoaabA8bX23Hc3MTZOcYN4cBc12/qy6ayHArNiiN8FdJ1Hk9IKD7+E5QFfnT1PSXvLQm/nG/jE+Bg6wFOCuTCkRepglom2kDUbatsor5nwIZ/6arTChJkK7W3z1N9P0HOxjjwN/+VaUJFGzLg7tHooQPqF/ZnDXjVv3DVACTjvpwfzUxtNecJ9kcKtFCtG6kvHGEaBvqVNknlrhKw69rzDZC1uievcaSerzHipYgxufOzOBRWrsy2/NS25OMplfn4/XekosI7MBb9CnGB0p0ygzmGoevekE5HlhfJxE6zwQZUNaJEbZ096fCWSMIbSoF7F6YQJtgADcJWdsbUbZ4GMN5JhNZNoN1hVe1dCvYWG1mSxNp+9l2qEXiJQsvzEnq4HA/vJ+BTxslIiCZYLHfQ7eUDtvFBjtr6gAPjM7Fq5RK0dH/Q0k4iBQcq3eC7FHIAHVSFxKhxmdIoSPTbCrm7gc4ME7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OEoTihxUKUmUK1YK0wNT8DPN3ZodhyLd5Yj6OtwgNYsUcaYV/SoFF8nEnn?=
 =?iso-8859-1?Q?G7No60oap+9bwHzJTSyRc4FJe5rouoInQIUaNk2/e/Uvh1VEl23xsBfHM9?=
 =?iso-8859-1?Q?gn538XDwhnQei+lTW1U79TPGbPnMhptUYyvDTgQtppFNwXDxV9R7GPXKM+?=
 =?iso-8859-1?Q?qntiQorcr3uoLtVSfUFLZYmc5M6twFXgnEcuMwtMamVHe90+UI41IkW4rX?=
 =?iso-8859-1?Q?+eC38lzyuyc+NF0uYV9Er5rLwXomrQdGcycg2GG3VtTcfvn/xpSBmF6PqH?=
 =?iso-8859-1?Q?zXdGow94xX+U6N8aAHM8JKdjCPqD0C6u/pO22FYIKboXSIN4RtMWdL1LMB?=
 =?iso-8859-1?Q?un7MPqYqF9HD7oN0EQvjovs7eqA1g8As1Gh4gcBeNB2jA3xOoWTZy9UjVH?=
 =?iso-8859-1?Q?tu6lfXVfbOqe2UaF4XIrFkImLxSj3xNYg49Ggl6WOPJRHtsCRCPG9hmllq?=
 =?iso-8859-1?Q?BSSJOU621fc6V701jyLnHUPD9TgkFj/+GF5uIPdxiUl8/k+W3CRFk07Tkq?=
 =?iso-8859-1?Q?nAXy5bnVDU7PimDBvZe1d6xDj4Np/N9219hzISydNfS1gbe6L/Ta/B5OYZ?=
 =?iso-8859-1?Q?qr1ft1y+ptet1ay9M/1nM5tKEgDzx067wujfILRZF54t1s00db3EfVJJEV?=
 =?iso-8859-1?Q?bBeJA2mhTaHQ76ZlFc9Q79OCKi6ih0ntJZOiBOLh3amtg0/RS7qyTcKt3a?=
 =?iso-8859-1?Q?WcVnrzJLVWASVx5/jDI0Ov6i4lmA7Wi12SVlcqvLV/ORE1sJ3I2SmfsdLk?=
 =?iso-8859-1?Q?VCKIQowQz+0/5U4UgEcGZ0+Aq6Y4ZNSO3nwGpKkoaBtc7aoDd7ywtSJwvC?=
 =?iso-8859-1?Q?5COr2byBmAi9dW/D36+5dC/+HH7l0Hb8xr1j7dWfnMf8Wvei049TtA39Vt?=
 =?iso-8859-1?Q?BKEBSHswfIHnhwtzOuh6D7D1MTpTbMXs6Iy7B+L1Q/PY8wiA4T4QgIhkzu?=
 =?iso-8859-1?Q?VZbm5zQvtPH3/wbn8MA11e2YFPy1wkAcG317vr8xmvzejErXrzLgBLq7sB?=
 =?iso-8859-1?Q?XbobZpqEqfwNjG4ec7JdBhdqqLNi1g4UyqAInCF4ND7t0ByJEnSf60IHS7?=
 =?iso-8859-1?Q?B7cfSvW2TT3/Tz0ZNMqQEkkFWHdfVmftVTEDbiMEh03VZROqDDWFCdMj96?=
 =?iso-8859-1?Q?+iwaooGt1QtmSfI+qY+zw4DjBIC6UDNEh1yRjUcaydo++Nj2Cywb4GdYae?=
 =?iso-8859-1?Q?kiTcY0i/dXg3RTT54a+q49GgCfL7X2GE3dBM5s+F5eRQxZ51lgFxnYlLFn?=
 =?iso-8859-1?Q?29802ErezUtEhJcPCV4DVOIbUl0b9KNvR5JgSeBhCxnO4WDVSJY1DVAqqq?=
 =?iso-8859-1?Q?2svxlQWblZWshoI0IBAtwnvk2hePCw1aAwP0+r6+nB9L4Au+llsx+fx9/A?=
 =?iso-8859-1?Q?ZELK9VzPt+d+gjI3PSoziGEaRk5s4mmnr+tI9lMK1OEgnRrZSjrZFyzcBe?=
 =?iso-8859-1?Q?hxFzq6ckhSONwZdBVV3r7yMUXFfprtxelEZBNfXU5/L32yvoUymWoFjixA?=
 =?iso-8859-1?Q?4cfqz39zbJ9NtoKqmxQ8YhjEE/6HUievvtfO/59BlcJtittUplRa+JLTb1?=
 =?iso-8859-1?Q?gaWFODNDYt+UXum2u0Dw0qQFSTmDDp4UVyasr5dkaM+aRDUl1diVtqkO0q?=
 =?iso-8859-1?Q?DAUVWwKZ6Zk5g9osoH9ux4vVryz3MClkx6tIt8zltOGrcJ+/LHhigv2/hM?=
 =?iso-8859-1?Q?guWbiOBdaagwk4hL8uOt8UfY3TTzcDyINfYALBIDmVpU2/GyFEP0jnA437?=
 =?iso-8859-1?Q?QYwug1bKqnXH/Gny8TVfNzlk0Vm4eDG+bOv5/y5AlInyHTgMF0OLKIJzG9?=
 =?iso-8859-1?Q?lD+8yA0LGQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MUN0iTM1c9o8rhNj7Qsf9KoqtOF0JV0bfFRcmgXfvdGYIV177P8vsOfnG5eH5B455PuRhHBXtwtPVbNclSoQ9ahuLZnsvmaT4VQv00y1qJs8a44/zsNj0pQEuROHpuCsBVwO136c91+8+hciZ1wZ6bqDaY7AdWeeD7OJL18A4DdRuv8HXnJPOmVhOKkdNQbwn+wsPqgUGhKX/ut8n0a7zdRMSlN1sUSkwc9znRjLy7iLFr29hqh2wkCW4bhQbGl6jq0QXxGitCTADh7c+o6c7AOwvpHpuWmnpXP13/7CEIsYy5K1WsHWfARwjXITfxXH9MFc72g5FMDRyEsFgL93Ug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR84MB3523.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a80835-0ccd-480b-9daa-08de844bd596
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:37:17.3177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: crhTHx5kcQxTi7Djgv8OyM1Tj0tYD6N+UmhqIWy2dvMlUzlp75d4VN/G970tzx4ckSKFF5nyl+2bhVubavD16Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1579
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: x44pcVo6DDzvKro5X30u1uOofYtOFd9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE1NSBTYWx0ZWRfX9GcNovdtjE2G
 6XzhZoq8NH5KgqJYELso7IMe3AgBe6gmk/Rgozi1Z9S3Oc0PqptYVSZkvwO8FbiPc2lgpaNcgIP
 77mb/hNwNKY3k34X7h+BA7mUHsPefD+p6IlZlpdAqc9cVSt25A1U6wzvQm/m905R1ppHBAwUqWl
 Fl6LixZzRWTqLviB89we82pGUIp4OTBrR3P1MfObmtbwaqFgpKyLiFp7robiti8dpv0aVCDjcDH
 QoQRl7Hgist4HGS4Ph4uMHFtC7cN4y8Xlsmcs7aq8UQvpcXLAHPlwxYOI+lu5vJIJuht1fhEqob
 pPXVhPRYs7VaFjGNZRh2uKWxEA/sgfRuWiffccbdG27fcqeXPP3S4OgrI0D4SyZ8m/plrSocfYF
 8Va31k9JI5cJwSTZQ0da4VZnmw9xqafrTpZSbOzNp3LzV/wOuIMbdZnkqykYyu2HArT90eb7EQW
 P68S1YjnmWGwc5WQSNA==
X-Proofpoint-GUID: x44pcVo6DDzvKro5X30u1uOofYtOFd9V
X-Authority-Analysis: v=2.4 cv=cPPtc1eN c=1 sm=1 tr=0 ts=69b99159 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22 a=NCWKwCw8Xy9Og0ibBRsL:22
 a=OUXY8nFuAAAA:8 a=VwQbUJbxAAAA:8 a=_gXBvBSidZrcrPkRqYIA:9 a=wPNLvfGTeEIA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170155
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[hpe.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hpe.com:s=pps0720];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[roeck-us.net,cern.ch,gmail.com,yeah.net,vger.kernel.org,juniper.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226879-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,juniper.net:email,hpe.com:dkim,hpe.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanman.pradhan@hpe.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[hpe.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9BFCD2AFFFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sanman Pradhan <psanman@juniper.net>=0A=
=0A=
mp2973_read_word_data() XORs the return value of pmbus_read_word_data()=0A=
with PB_STATUS_POWER_GOOD_N without first checking for errors. If the I2C=
=0A=
transaction fails, a negative error code is XORed with the constant,=0A=
producing a corrupted value that is returned as valid status data instead=
=0A=
of propagating the error.=0A=
=0A=
Add the missing error check before modifying the return value.=0A=
=0A=
Fixes: acda945afb465 ("hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD"=
)=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Sanman Pradhan <psanman@juniper.net>=0A=
---=0A=
 drivers/hwmon/pmbus/mp2975.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c=0A=
index c31982d851962..d0bc47b12cb07 100644=0A=
--- a/drivers/hwmon/pmbus/mp2975.c=0A=
+++ b/drivers/hwmon/pmbus/mp2975.c=0A=
@@ -313,6 +313,8 @@ static int mp2973_read_word_data(struct i2c_client *cli=
ent, int page,=0A=
 	case PMBUS_STATUS_WORD:=0A=
 		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */=0A=
 		ret =3D pmbus_read_word_data(client, page, phase, reg);=0A=
+		if (ret < 0)=0A=
+			return ret;=0A=
 		ret ^=3D PB_STATUS_POWER_GOOD_N;=0A=
 		break;=0A=
 	case PMBUS_OT_FAULT_LIMIT:=0A=
-- =0A=
2.34.1=0A=
=0A=

